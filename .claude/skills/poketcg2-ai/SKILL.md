---
name: poketcg2-ai
description: >
  How the AI subsystem of Pokemon Card GB2 (poketcg2) is laid out, what's
  been decompiled, and what's still raw. Trigger this skill whenever the
  user works on the AI: "decompile bank 8", "trainer card AI", "AIDecide_*"
  / "AIPlay_*" functions, "AI thinks", AI scoring, evolution checks, "Gene
  is thinking", "AI scratch" flags (wd084, wAIScore, wPreviousAIFlags), or
  when they reference the `AITrainerCardLogic` table. Also trigger when
  using the [tools/sameboy_trace.py](../../../tools/sameboy_trace.py)
  workflow to find new AI decompilation targets — the trace surfaces
  hot-spots inside bank $08 that this skill helps interpret.
  Read in full before proposing new decomp, and update the
  "Decompilation status" + "Decompiled functions" sections after every
  successful new label landed in source.
---

# poketcg2 AI subsystem

The AI is split across **five engine banks**. Most of bank $05 is
decompiled; banks $08, $0e, $12, $13 are partial. Bank $08 — the
trainer-card decider/play table and its helpers — is the biggest open
target.

## File map

| Bank | Symbols | What's there |
|---|---|---|
| `$05` | ~85 `AI*` labels | Main AI driver, scoring, attack picker, energy attach decisions. Mostly decompiled. |
| `$08` | 5 `AI*` labels + the table | `AITrainerCardLogic` master table, per-trainer-card decide/play functions, evolution helpers. ~8% source-defined (everything past `$4c32` is raw or a placeholder named `Func_20be6`). |
| `$0e` | 8 `AI*` labels | Deck-specific behavior (some AI deck strategy hooks). |
| `$12` | ~23 `AI*` labels | More deck-strategy logic + a chunk of trainer-card deciders that didn't fit in $08. |
| `$13` | 5 `AI*` labels | Atomic helpers (e.g. `CheckIfEvolvesInto`) used by both $08 and $12. |

Constants live in [src/constants/deck_ai_constants.asm](../../../src/constants/deck_ai_constants.asm)
(phase numbers, AI flags, energy flags).

## The `AITrainerCardLogic` table

Entry point for every "AI considers playing a trainer card" decision.
Lives at the top of [src/engine/bank08.asm](../../../src/engine/bank08.asm).
Each row is `(phase, card_id, decide_fn, play_fn)` where:

- **phase**: when in the AI's turn this row is considered — `PHASE_01`
  runs first, `PHASE_15` is reserved for Professor Oak, `PHASE_14`
  runs immediately before the AI attacks. If Professor Oak is played,
  all other phases re-run except `PHASE_15`.
- **card_id**: the trainer-card constant (POTION, GAMBLER, etc.).
- **decide_fn**: returns carry SET if the AI wants to play this card
  (and usually leaves arguments in some scratch RAM for play_fn).
- **play_fn**: carries out the play, given the decision.

A lot of these still reference **raw hex addresses** (`$5511`, `$66e7`,
`$5adf`, etc.) — those are the per-card deciders living inside the
giant `Func_20be6` placeholder in bank $08. The decompilation work in
this branch is exactly: pick a raw-hex entry, decode it, give it a
real name, update the table.

## Standing conventions

**Play-area position `e`**: across nearly every AI function in bank $08,
input register `e` holds the play-area position of the Pokemon under
consideration. `0` is the Arena, `1`-`5` are bench slots. This maps
through `add DUELVARS_ARENA_CARD; get_turn_duelist_var` to the deck
index of whatever Pokemon is at that slot.

**Carry convention**: `decide_fn` returns **carry SET** when the AI
chose to play the card. Lower-level helpers usually follow the same
pattern (`scf; ret` = success, `or a; ret` = fail). Watch for
inverted helpers (`CheckIfEvolvesInto` returns NC = "evolves", C =
"doesn't evolve") — wrappers like `LookForEvolutionInHand` re-invert
to match the success-set-carry convention.

**`DECK_SIZE`** = 60. Many functions iterate `d = 0..59` over deck
positions, using `DUELVARS_CARD_LOCATIONS + d` to fetch
`CARD_LOCATION_*` (hand=1, deck=0, discard=2, prize=8, arena=$10,
bench=$11-$15).

**Scratch slots** at `$d080`-`$d090` are reused across AI passes. The
same byte often has different aliases (`wd084` is also
`wAISetupEnergyCount` and `wAIPkmnPowerUserCardIndex` depending on
context — see [src/wram.asm](../../../src/wram.asm)). Prefer
`wd084` in raw-decode source unless you're certain which alias
matches the calling context.

## AI flag registers worth knowing

| WRAM | Purpose |
|---|---|
| `wPreviousAIFlags` / `wCurrentAIFlags` | Per-turn AI state: `AI_FLAG_USED_PLUSPOWER`, `_SWITCH`, `_PROFESSOR_OAK`, `_MODIFIED_HAND`, `_USED_GUST_OF_WIND`. Read by deciders to avoid double-play. |
| `wAIScore`, `wAIMinDamage`, `wAIMaxDamage` | Attack picker scoring. |
| `wd084` | Multi-purpose AI scratch. Common reuse: "did we find ANY of X in the deck/hand?" (binary 0/1). |
| `wd082` | Trainer-card scoring offset (`add $0a` / `sub $0a` patterns when ranking which card to play). |
| `wTempAITargetPokemonCardDeckIndex` / `wTempAITargetNonPokemonCardDeckIndex` | Used by `Func_214ad` to tag results of `LookForEvolutionInHand`. |

## Decompiled functions (this skill's running ledger)

Update this table when you land a new named label in any AI bank.
Keep it short — one row per function, "via" column = how you found
the target (helps justify future decomp prioritization).

| Bank | Address | Name | Via | Landed |
|---|---|---|---|---|
| `$08` | `$5505` | [`LookForEvolutionInHand`](../../../src/engine/bank08.asm) | sameboy_trace duel-gene, 240-hit saturation | 2026-06-01 |

## Bank $08 decompilation status

**Source-defined**: 8.06% (~1.3 KiB of 16 KiB).
**Last updated**: 2026-06-01.

### Decompiled regions (named, in source)
- `$4000-$4c32` — `AITrainerCardLogic` table + early decompiled functions through `Func_20be6.return_with_carry`.
- `$5505-$5527` — `LookForEvolutionInHand`.

### Still raw, in priority order (highest = most leverage)
Addresses listed are bank-$08 CPU addresses; nearest table card in
parens.

1. `$5511`-region helpers — **partially addressed by `LookForEvolutionInHand`**, but the table entries pointing at `$54xx`/`$55xx` may still wrap more shared logic.
2. `$66e7` (GAMBLER decide) — 26 hits per Gene-duel session, ~80 bytes.
3. `$5adf` (SUPER_ENERGY_RETRIEVAL decide), `$5a9d` (play).
4. `$566e` (ENERGY_RETRIEVAL decide), `$5643` (play).
5. Everything else in the table that's still a raw hex address (see
   [src/engine/bank08.asm](../../../src/engine/bank08.asm) lines
   8-65).

## Workflow for adding the next AI label

1. **Make sure you're on a branch.** The bank-01 byte-shift hazard
   from [CLAUDE.md](../../../CLAUDE.md) applies to bank $08 only in
   spirit — bank $08 itself has hardcoded hex addresses in the
   `AITrainerCardLogic` table that the assembler resolves, so adding
   a SECTION at a known CPU address is safe.

2. **Record a trace** of a scenario that exercises the target:
   ```sh
   python3 tools/sameboy_trace.py record <scenario-name>
   ```
   Pick the scenario for the type of AI behavior you want. Different
   opponents stress different trainer cards:
   - Gene (Rock Club) → mostly energy-management cards
   - Sam (practice) → very basic, often no trainer plays
   - A GR fort leader → wider trainer-card mix including GR cards

3. **Filter the report** to bank $08 and the address you care about:
   ```sh
   python3 tools/sameboy_trace.py report <scenario-name> --bank 0x08
   ```
   The "nearest symbol" column may show stale labels (anything in
   the `Func_20be6.return_with_carry+N` family is just a placeholder
   — N is the bytes-since-placeholder distance, not real semantics).

4. **Disassemble** the hot region with the project's existing tool:
   ```sh
   python3 tools/tcg2disasm.py -r poketcg2.gbc -s poketcg2.sym -nw \
       --hard-stop 0x<end-file-offset> 0x<start-file-offset>
   ```
   File offset = `0x<bank>*0x4000 + (cpu_addr - 0x4000)` for ROMX,
   or just `cpu_addr` for ROM0.

5. **Cross-reference**: find the call sites (`grep` the ROM for
   `cd LL HH`), the targets of the function's own calls
   (`farcall TARGET = ef BB LL HH`), and which AI flags it touches
   (DUELVARS_*, w[A-Z]*).

6. **Name and decompile.** Match the surrounding style — `AIDecide_*`
   for table deciders, `AIPlay_*` for table plays, descriptive verb
   phrases (`FindBenchCardThatCanBeKnockedOut`,
   `CheckIfArenaCardCanPotentiallyDamageDefendingCard`,
   `LookForEvolutionInHand`) for helpers.

7. **Add a SECTION at the function's CPU address.** Pattern:
   ```
   SECTION "Bank 8@<cpu_addr_hex>", ROMX[$<cpu_addr_hex>], BANK[$8]
   ```
   The layout.link glob `"Bank 8"` already matches this name.

8. **Update the table** in `AITrainerCardLogic` to reference the new
   symbol instead of the raw hex (if this was a table entry).

9. **Verify.**
   ```sh
   make compare      # SHA1 must still match baserom
   python3 tools/rom_coverage.py | head -10
   python3 tools/sameboy_trace.py report <scenario-name> --bank 0x08
   ```
   `OK` = bytes are bit-identical = decomp is correct. Bank $08 % should
   tick up. The new symbol should disappear from the trace report's
   undecompiled list.

10. **Update this skill** — see next section.

## Keeping this skill up to date

**After every commit that lands a new AI label**, update this file in
the same commit (or in a follow-up no-code commit):

1. **Add a row to "Decompiled functions"** with bank, address, name,
   discovery method, and the date you landed it.
2. **Bump the bank's "Source-defined" %** under "Bank $08 decompilation
   status" (rerun `python3 tools/rom_coverage.py` and copy the bank
   line — match the per-bank `src %` column).
3. **Update "Decompiled regions"** to include the new CPU-address range
   if it's contiguous with an existing region, or as a new bullet.
4. **Remove the target from "Still raw"** if it was listed there.
5. **Add new "Still raw" entries** for any addresses the just-landed
   function called that are themselves undecompiled — those are the
   next natural targets and you have rich context on them.
6. **Bump "Last updated"** to today's date.
7. **If you discovered a new convention**, helper pattern, or AI flag
   reuse worth knowing, add a paragraph under "Standing conventions"
   or "AI flag registers" — that's the part future-you/future-Claude
   will rely on for the next decomp.

Do NOT include in this skill:
- The disassembly of the function (it's in the .asm file already).
- A play-by-play of the trace numbers (they go stale fast — the
  workflow section already says "use the tool").
- Restatements of `CLAUDE.md` or `CONTRIBUTING.md` rules.

The skill should fit on a screen for any single reader. If it stops
fitting, split out the most decompiled bank into a dedicated
companion file and link from here.
