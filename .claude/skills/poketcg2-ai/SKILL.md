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
| `$08` | `$42d0` | [`AIDecide_Potion_Phase10`](../../../src/engine/bank08.asm) | sameboy_trace duel-sam | 2026-06-01 |
| `$08` | `$433b` | [`CheckIfAnyAttackBoostsIfTakenDamage`](../../../src/engine/bank08.asm) | called from AIDecide_Potion_Phase10 | 2026-06-01 |
| `$08` | `$4365` | [`AIDecide_Potion_Phase10_Deck45`](../../../src/engine/bank08.asm) | sameboy_trace duel-catherine (Dark Jolteon / Dark Raichu deck) | 2026-06-02 |
| `$08` | `$439b` | [`AIDecide_Potion_Phase11`](../../../src/engine/bank08.asm) | sameboy_trace duel-sam | 2026-06-01 |
| `$08` | `$483d` | [`AIPlay_Switch`](../../../src/engine/bank08.asm) | sameboy_trace duel-masahiro | 2026-06-01 |
| `$08` | `$485a` | [`AIDecide_Switch_Phase09`](../../../src/engine/bank08.asm) | sameboy_trace duel-masahiro | 2026-06-01 |
| `$08` | `$44e3` | [`AIPlay_Defender`](../../../src/engine/bank08.asm) | sameboy_trace duel-renna | 2026-06-01 |
| `$08` | `$44f2` | [`AIDecide_Defender_Phase13`](../../../src/engine/bank08.asm) + inline `.deck_50`, `.deck_74` | sameboy_trace duel-renna | 2026-06-01 |
| `$08` | `$45ef` | [`AIDecide_Defender_Phase14`](../../../src/engine/bank08.asm) + inline `.deck_72` | sameboy_trace duel-renna | 2026-06-01 |
| `$08` | `$4678` | [`AIPlay_PlusPower`](../../../src/engine/bank08.asm) | sameboy_trace duel-hidero | 2026-06-02 |
| `$08` | `$4692` | [`AIDecide_PlusPower_Phase13`](../../../src/engine/bank08.asm) + helpers | sameboy_trace duel-hidero | 2026-06-02 |
| `$08` | `$4752` | [`AIDecide_PlusPower_Phase14`](../../../src/engine/bank08.asm) + helpers + inline `Deck45` | sameboy_trace duel-hidero | 2026-06-02 |
| `$08` | `$4c44` | [`AIPlay_EnergyRemoval`](../../../src/engine/bank08.asm) | sameboy_trace duel-ichikawa2 | 2026-06-02 |
| `$08` | `$4c5a` | [`AIDecide_EnergyRemoval`](../../../src/engine/bank08.asm) + helpers `CheckIfHasNonRecycleEnergy`, `CheckIfBothAttacksStillNeedEnergy`, `ScoreBenchEnergyRemovalCandidate` | sameboy_trace duel-ichikawa2 (7 deck cases left raw) | 2026-06-02 |
| `$08` | `$4e3c` | [`AIDecide_EnergyRemoval_Deck47`](../../../src/engine/bank08.asm) + `CheckIfEnergyRemovalDisruptsBigAttack` | sameboy_trace duel-yuki | 2026-06-02 |
| `$08` | `$4de7` | [`AIDecide_EnergyRemoval_Deck45Or50`](../../../src/engine/bank08.asm) | sameboy_trace duel-kamiya (Dark Jolteon / Dark Raichu shared; Double Colorless priority) | 2026-06-02 |
| `$08` | `$4e90` | [`AIDecide_EnergyRemoval_Deck4A`](../../../src/engine/bank08.asm) | sameboy_trace duel-miyajima (Dark Vaporeon / Dark Starmie deck) | 2026-06-02 |
| `$08` | `$620f` | [`AIDecide_ScoopUp_Deck47`](../../../src/engine/bank08.asm) | sameboy_trace duel-yuki | 2026-06-02 |
| `$08` | `$6b60` | [`AIDecide_Pokeball_Deck47`](../../../src/engine/bank08.asm) | sameboy_trace duel-yuki | 2026-06-02 |
| `$08` | `$6bbb` | [`AIDecide_Pokeball_Deck4A`](../../../src/engine/bank08.asm) | sameboy_trace duel-miyajima | 2026-06-02 |
| `$08` | `$6bf8` | [`AIDecide_Pokeball_Deck4B`](../../../src/engine/bank08.asm) | sameboy_trace duel-senta | 2026-06-02 |
| `$08` | `$6c35` | [`AIDecide_Pokeball_Deck4E`](../../../src/engine/bank08.asm) | sameboy_trace duel-gouda (uses `CheckReelInEvoLineTarget`) | 2026-06-02 |
| `$08` | `$489c` | [`AIDecide_Switch_Phase16`](../../../src/engine/bank08.asm) | sameboy_trace duel-sam | 2026-06-01 |
| `$08` | `$49e3` | [`AIPlay_GustOfWind`](../../../src/engine/bank08.asm) | sameboy_trace duel-takahashi | 2026-06-01 |
| `$08` | `$4c32` | [`AIPlay_Bill`](../../../src/engine/bank08.asm) | sameboy_trace duel-gr-leader | 2026-06-01 |
| `$08` | `$4c3e` | [`AIDecide_Bill`](../../../src/engine/bank08.asm) | sameboy_trace duel-gr-leader | 2026-06-01 |
| `$08` | `$53bc` | [`AIPlay_ProfessorOak`](../../../src/engine/bank08.asm) | AITrainerCardLogic, shared duel-gene + duel-sousuke | 2026-06-01 |
| `$08` | `$53d0` | [`AIDecide_ProfessorOak`](../../../src/engine/bank08.asm) | sameboy_trace duel-gene ∩ duel-sousuke (114 shared hits) | 2026-06-01 |
| `$08` | `$507b` | [`AIPlay_PokemonBreeder`](../../../src/engine/bank08.asm) | sameboy_trace duel-morino (3-stage non-standard play wrapper) | 2026-06-01 |
| `$08` | `$55cf` | [`AIDecide_ProfessorOak_Deck45Or50`](../../../src/engine/bank08.asm) | sameboy_trace duel-catherine (shared by decks $45 and $50) | 2026-06-02 |
| `$08` | `$55d5` | [`AIDecide_ProfessorOak_Deck49Or4D`](../../../src/engine/bank08.asm) | sameboy_trace duel-kanoko (hand-size threshold scales with cards-out-of-deck) | 2026-06-02 |
| `$08` | `$5505` | [`LookForEvolutionInHand`](../../../src/engine/bank08.asm) | sameboy_trace duel-gene, 240-hit saturation | 2026-06-01 |
| `$08` | `$5643` | [`AIPlay_EnergyRetrieval`](../../../src/engine/bank08.asm) | AITrainerCardLogic table entry | 2026-06-01 |
| `$08` | `$566e` | [`AIDecide_EnergyRetrieval`](../../../src/engine/bank08.asm) | sameboy_trace duel-kevin (dispatcher only; 22 deck cases left raw; default-path early `ret nc` lands) | 2026-06-02 |
| `$08` | `$5a9d` | [`AIPlay_SuperEnergyRetrieval`](../../../src/engine/bank08.asm) | AITrainerCardLogic table entry | 2026-06-01 |
| `$08` | `$5ce2` | [`AIPlay_ImposterProfessorOak`](../../../src/engine/bank08.asm) | sameboy_trace duel-gr4 | 2026-06-01 |
| `$08` | `$5cee` | [`AIDecide_ImposterProfessorOak`](../../../src/engine/bank08.asm) | sameboy_trace duel-gr4 | 2026-06-01 |
| `$08` | `$5f63` | [`AIPlay_FullHeal`](../../../src/engine/bank08.asm) | sameboy_trace duel-gr4 | 2026-06-01 |
| `$08` | `$5d2d` | [`AIPlay_EnergySearch`](../../../src/engine/bank08.asm) | sameboy_trace duel-ronald | 2026-06-01 |
| `$08` | `$5d3e` | [`AIDecide_EnergySearch`](../../../src/engine/bank08.asm) + Deck0D + Deck66 + helper `LookForEnergyUsefulToPlayArea` | sameboy_trace duel-ronald | 2026-06-01 |
| `$08` | `$5f6f` | [`AIDecide_FullHeal`](../../../src/engine/bank08.asm) | sameboy_trace duel-gr4 (deck-$53 case `$602b` and shared SCOOP_UP helper `$60ed` still raw) | 2026-06-01 |
| `$08` | `$6694` | [`AIPlay_Gambler`](../../../src/engine/bank08.asm) | AITrainerCardLogic table entry, hot in duel-gene | 2026-06-01 |
| `$08` | `$603e` | [`AIPlay_MrFuji`](../../../src/engine/bank08.asm) | sameboy_trace duel-kanoko | 2026-06-02 |
| `$08` | `$604f` | [`AIDecide_MrFuji`](../../../src/engine/bank08.asm) + `Deck4D` + `Deck6D` | sameboy_trace duel-kanoko | 2026-06-02 |
| `$08` | `$60d7` | [`AIPlay_ScoopUp`](../../../src/engine/bank08.asm) | sameboy_trace duel-tashiro | 2026-06-01 |
| `$08` | `$60ed` | [`AIDecide_ScoopUp`](../../../src/engine/bank08.asm) + inline `.deck_3c` | sameboy_trace duel-tashiro (8 other deck cases left raw); also called as a heuristic from AIDecide_FullHeal | 2026-06-01 |
| `$08` | `$6373` | [`AIPlay_ItemFinder`](../../../src/engine/bank08.asm) | sameboy_trace duel-kamiya | 2026-06-02 |
| `$08` | `$664d` | [`AIPlay_ImakuniCard`](../../../src/engine/bank08.asm) | sameboy_trace duel-kamiya | 2026-06-02 |
| `$08` | `$6659` | [`AIDecide_ImakuniCard`](../../../src/engine/bank08.asm) + inline deck `$50` | sameboy_trace duel-kamiya | 2026-06-02 |
| `$08` | `$66e7` | [`AIDecide_Gambler`](../../../src/engine/bank08.asm) | AITrainerCardLogic table entry, hot in duel-gene | 2026-06-01 |
| `$08` | `$671b` | [`AIPlay_Revive`](../../../src/engine/bank08.asm) | sameboy_trace duel-miyuki | 2026-06-01 |
| `$08` | `$672c` | [`AIDecide_Revive`](../../../src/engine/bank08.asm) + Deck14 + Deck40 | sameboy_trace duel-miyuki | 2026-06-01 |
| `$08` | `$67af` | [`AIPlay_PokemonFlute`](../../../src/engine/bank08.asm) | sameboy_trace duel-aira | 2026-06-02 |
| `$08` | `$67c0` | [`AIDecide_PokemonFlute`](../../../src/engine/bank08.asm) + inline `.deck_68`, `.pick_any_basic` | sameboy_trace duel-aira | 2026-06-02 |
| `$08` | `$6e28` | [`AIPlay_PokemonTrader`](../../../src/engine/bank08.asm) | sameboy_trace duel-rie | 2026-06-01 |
| `$08` | `$6e43` | [`AIDecide_PokemonTrader`](../../../src/engine/bank08.asm) | sameboy_trace duel-rie (dispatcher only; 25 deck-specific cases left raw) | 2026-06-01 |
| `$08` | `$6f1b` | [`AIDecide_PokemonTrader_Deck18`](../../../src/engine/bank08.asm) | sameboy_trace duel-rie (Rie is deck $18) | 2026-06-01 |
| `$08` | `$71d4` | [`AIDecide_PokemonTrader_Deck41`](../../../src/engine/bank08.asm) | sameboy_trace duel-morino (Mad Petals deck) | 2026-06-01 |
| `$08` | `$71fc` | [`AIDecide_PokemonTrader_Deck48`](../../../src/engine/bank08.asm) | sameboy_trace duel-shoro (4-way split on play-area count + opponent Water type) | 2026-06-02 |
| `$08` | `$7274` | [`AIDecide_PokemonTrader_Deck49`](../../../src/engine/bank08.asm) | sameboy_trace duel-hidero | 2026-06-02 |
| `$08` | `$72d7` | [`AIDecide_PokemonTrader_Deck4C`](../../../src/engine/bank08.asm) | sameboy_trace duel-aira (gated on opponent Water-type arena) | 2026-06-02 |
| `$08` | `$7327` | [`AIDecide_PokemonTrader_Deck4D`](../../../src/engine/bank08.asm) | sameboy_trace duel-kanoko (3-way play-area × Water matchup split) | 2026-06-02 |
| `$08` | `$739e` | [`AIDecide_PokemonTrader_Deck4F`](../../../src/engine/bank08.asm) | sameboy_trace duel-grace (3-stage chain $f3 -> $f7 -> $fa) | 2026-06-02 |
| `$08` | `$7570` | [`AIDecide_TheBosssWay_Deck4F`](../../../src/engine/bank08.asm) | sameboy_trace duel-grace (same chain as deck $4f Trader) | 2026-06-02 |
| `$08` | `$78c9` | [`AIDecide_NightlyGarbageRun_Deck49`](../../../src/engine/bank08.asm) | sameboy_trace duel-hidero | 2026-06-02 |
| `$08` | `$68b7` | [`AIPlay_Pokeball`](../../../src/engine/bank08.asm) | sameboy_trace duel-ayako | 2026-06-01 |
| `$08` | `$68d8` | [`AIDecide_Pokeball`](../../../src/engine/bank08.asm) | sameboy_trace duel-ayako (13-way dispatcher; 12 deck cases left raw) | 2026-06-01 |
| `$08` | `$6a59` | [`AIDecide_Pokeball_Deck25`](../../../src/engine/bank08.asm) | sameboy_trace duel-ayako (Ayako is deck $25) | 2026-06-01 |
| `$08` | `$7492` | [`AIPlay_TheBosssWay`](../../../src/engine/bank08.asm) | sameboy_trace duel-gr3-3 | 2026-06-01 |
| `$08` | `$74a7` | [`AIDecide_TheBosssWay`](../../../src/engine/bank08.asm) + inline decks $38, $39 | sameboy_trace duel-gr3-3 (deck $39; 8 other deck cases left raw) | 2026-06-01 |
| `$08` | `$7539` | [`AIDecide_TheBosssWay_Deck3F`](../../../src/engine/bank08.asm) | sameboy_trace duel-yuuta (deck $3f) | 2026-06-01 |
| `$08` | `$75cd` | [`AIDecide_TheBosssWay_Deck6A`](../../../src/engine/bank08.asm) | sameboy_trace duel-grx (deck $6a) | 2026-06-01 |
| `$08` | `$75fe` | [`AIPlay_NightlyGarbageRun`](../../../src/engine/bank08.asm) | sameboy_trace duel-morino | 2026-06-01 |
| `$08` | `$761d` | [`AIDecide_NightlyGarbageRun`](../../../src/engine/bank08.asm) | sameboy_trace duel-morino (12-way dispatcher; 11 deck cases left raw) | 2026-06-01 |
| `$08` | `$782f` | [`AIDecide_NightlyGarbageRun_Deck41`](../../../src/engine/bank08.asm) | sameboy_trace duel-morino | 2026-06-01 |
| `$08` | `$79df` | [`AddDeckIndexToAIMultiTargetSlots`](../../../src/engine/bank08.asm) | helper called from deck-$41 NGR | 2026-06-01 |
| `$08` | `$7d44` | [`AIDecide_MasterBall_Deck3F`](../../../src/engine/bank08.asm) | sameboy_trace duel-yuuta (deck $3f) | 2026-06-01 |
| `$08` | `$7dc2` | [`AIDecide_MasterBall_Deck43`](../../../src/engine/bank08.asm) | sameboy_trace duel-renna (Chain Lightning by Pikachu deck) | 2026-06-01 |
| `$08` | `$7e9e` | [`AIPlay_GoopGasAttack`](../../../src/engine/bank08.asm) | sameboy_trace duel-miyuki | 2026-06-01 |
| `$08` | `$7eaa` | [`AIDecide_GoopGasAttack`](../../../src/engine/bank08.asm) | sameboy_trace duel-miyuki | 2026-06-01 |
| `$08` | `$7f3e` | [`AIPlay_ComputerError`](../../../src/engine/bank08.asm) | sameboy_trace duel-grx | 2026-06-02 |
| `$08` | `$7f61` | [`AIDecide_ComputerError`](../../../src/engine/bank08.asm) + inline `Deck59`, `Deck68`, `Deck6B` | sameboy_trace duel-grx | 2026-06-02 |
| `$08` | `$7f96` | [`AIPlay_SuperScoopUp`](../../../src/engine/bank08.asm) | sameboy_trace duel-grx (coin-flip wrapper) | 2026-06-02 |
| `$08` | `$7fbc` | [`AIDecide_SuperScoopUp`](../../../src/engine/bank08.asm) | sameboy_trace duel-grx | 2026-06-02 |
| `$08` | `$7a43` | [`AIPlay_Sleep`](../../../src/engine/bank08.asm) | sameboy_trace duel-sousuke (deck $12) | 2026-06-01 |
| `$08` | `$7a4f` | [`AIDecide_Sleep`](../../../src/engine/bank08.asm) + `AIDecide_Sleep_Deck12` | sameboy_trace duel-sousuke (deck $12) | 2026-06-01 |
| `$08` | `$7b0a` | [`AIPlay_MasterBall`](../../../src/engine/bank08.asm) | sameboy_trace duel-rie3 | 2026-06-01 |
| `$08` | `$7b1f` | [`AIDecide_MasterBall`](../../../src/engine/bank08.asm) | sameboy_trace duel-rie3 (12-way dispatch; decks $13, $14 inline; 10 cases left raw) | 2026-06-01 |

## Bank $08 decompilation status

**Source-defined**: 45.35% (~7.3 KiB of 16 KiB).
**Last updated**: 2026-06-02.

### Decompiled regions (named, in source)
- `$4000-$4c32` — `AITrainerCardLogic` table + early decompiled functions through `Func_20be6.return_with_carry`.
- `$42d0-$4364` — `AIDecide_Potion_Phase10` + `CheckIfAnyAttackBoostsIfTakenDamage`.
- `$4365-$439a` — `AIDecide_Potion_Phase10_Deck45`.
- `$439b-$43a9` — `AIDecide_Potion_Phase11` + `AIDecide_Potion_Phase11_Deck74`.
- `$483d-$489b` — `AIPlay_Switch` (shared by Phase_09 and Phase_16) + `AIDecide_Switch_Phase09`.
- `$44e3-$4677` — `AIPlay_Defender` + `AIDecide_Defender_Phase13` (inline decks $50, $74) + `AIDecide_Defender_Phase14` (inline deck $72).
- `$4678-$483c` — `AIPlay_PlusPower` + `AIDecide_PlusPower_Phase13` + `AIDecide_PlusPower_Phase14` (inline `Deck45`) + 5 helpers (`CheckIfPlusPowerEnablesKO_Phase13`, `CheckIfDamageThresholdMetForPlusPower_Phase13`, `CheckIfDamageThresholdMetForPlusPower_Phase14` [byte-duplicate of Phase13], `CheckIfAttackWontKOAlready`, `ScoreAttackWithPoisonDiscount`).
- `$4c44-$4d6a` — `AIPlay_EnergyRemoval` + `AIDecide_EnergyRemoval` (6 deck cases left raw) + 3 helpers (`CheckIfHasNonRecycleEnergy`, `CheckIfBothAttacksStillNeedEnergy`, `ScoreBenchEnergyRemovalCandidate`).
- `$4de7-$4e3b` — `AIDecide_EnergyRemoval_Deck45Or50` (Double Colorless priority pass + standard "would-KO + meaningful-HP" gate).
- `$4e3c-$4e8f` — `AIDecide_EnergyRemoval_Deck47` + `CheckIfEnergyRemovalDisruptsBigAttack`.
- `$4e90-$4edd` — `AIDecide_EnergyRemoval_Deck4A`.
- `$620f-$6227` — `AIDecide_ScoopUp_Deck47` (jumps back to AIDecide_ScoopUp's local labels).
- `$6b60-$6bba` — `AIDecide_Pokeball_Deck47`.
- `$6bbb-$6bf7` — `AIDecide_Pokeball_Deck4A`.
- `$6bf8-$6c34` — `AIDecide_Pokeball_Deck4B`.
- `$6c35-$6c5b` — `AIDecide_Pokeball_Deck4E`.
- `$489c-$48fb` — `AIDecide_Switch_Phase16` (deck-specific Func_209xx sub-deciders left raw).
- `$49e3-$49fb` — `AIPlay_GustOfWind`.
- `$6e28-$6ec9` — `AIPlay_PokemonTrader` + `AIDecide_PokemonTrader` (dispatcher; 25 deck cases left raw).
- `$6f1b-$6f87` — `AIDecide_PokemonTrader_Deck18`.
- `$5ce2-$5d2c` — `AIPlay_ImposterProfessorOak` + `AIDecide_ImposterProfessorOak` (deck `$59`/`$67`/`$68` cases inline as local labels).
- `$5d2d-$5e0d` — `AIPlay_EnergySearch` + `AIDecide_EnergySearch` (deck `$09`/`$0b` inline; `$0d`/`$66` as separate sub-functions; unreferenced `AIDecide_EnergySearch_GrassOnly` preserved) + `LookForEnergyUsefulToPlayArea` helper.
- `$5f63-$602a` — `AIPlay_FullHeal` + `AIDecide_FullHeal` (deck `$53` case `$602b` left raw; previously raw `call $60ed` is now `call AIDecide_ScoopUp`).
- `$603e-$60d6` — `AIPlay_MrFuji` + `AIDecide_MrFuji` + `AIDecide_MrFuji_Deck4D` + `AIDecide_MrFuji_Deck6D`.
- `$60d7-$61e1` — `AIPlay_ScoopUp` + `AIDecide_ScoopUp` (inline `.deck_3c`; 8 other deck cases left raw).
- `$68b7-$691d` — `AIPlay_Pokeball` + `AIDecide_Pokeball` (13-way dispatcher; 12 cases left raw).
- `$6a59-$6a67` — `AIDecide_Pokeball_Deck25`.
- `$7492-$7538` — `AIPlay_TheBosssWay` + `AIDecide_TheBosssWay` (inline deck $38, deck $39; 7 other deck cases left raw).
- `$7539-$754e` — `AIDecide_TheBosssWay_Deck3F`.
- `$75cd-$75f8` — `AIDecide_TheBosssWay_Deck6A`.
- `$507b-$50b5` — `AIPlay_PokemonBreeder` (3-stage play wrapper with action codes `$07`/`$18`/`$19`).
- `$671b-$67ae` — `AIPlay_Revive` + `AIDecide_Revive` + `AIDecide_Revive_Deck14` + `AIDecide_Revive_Deck40`.
- `$67af-$2857` — `AIPlay_PokemonFlute` + `AIDecide_PokemonFlute` (inline `.pick_any_basic`, `.deck_68`).
- `$71d4-$71d8` — `AIDecide_PokemonTrader_Deck41` (5-byte trampoline into `MadPetalsDeckAIDecidePokemonTrader`).
- `$71fc-$7273` — `AIDecide_PokemonTrader_Deck48` (4-way split on play-area count × Water-type opponent).
- `$7274-$72d6` — `AIDecide_PokemonTrader_Deck49` (multi-Pokemon evolution chain vs. solo card-fetch).
- `$72d7-$7326` — `AIDecide_PokemonTrader_Deck4C` (gated on opponent Water-type arena).
- `$7327-$739d` — `AIDecide_PokemonTrader_Deck4D` (3-way split: solo / multi-no-Water / multi-Water).
- `$739e-$73d7` — `AIDecide_PokemonTrader_Deck4F`.
- `$7570-$7585` — `AIDecide_TheBosssWay_Deck4F`.
- `$78c9-$78f1` — `AIDecide_NightlyGarbageRun_Deck49` (rescue 2 basic energies + optional card $65).
- `$75fe-$765d` — `AIPlay_NightlyGarbageRun` + `AIDecide_NightlyGarbageRun` (12-way dispatcher; 11 cases left raw).
- `$782f-$787c` — `AIDecide_NightlyGarbageRun_Deck41`.
- `$79df-$79f4` — `AddDeckIndexToAIMultiTargetSlots` (3-slot list-add helper).
- `$7d44-$7d60` — `AIDecide_MasterBall_Deck3F`.
- `$7dc2-$7dc6` — `AIDecide_MasterBall_Deck43`.
- `$7e9e-$7ec2` — `AIPlay_GoopGasAttack` + `AIDecide_GoopGasAttack`.
- `$7f3e-$7fe5` — `AIPlay_ComputerError` + `AIDecide_ComputerError` + `AIPlay_SuperScoopUp` + `AIDecide_SuperScoopUp`.
- `$7b0a-$7bde` — `AIPlay_MasterBall` + `AIDecide_MasterBall` (inline deck $13, deck $14; 10 other deck cases left raw).
- `$4c32-$4c43` — `AIPlay_Bill` + `AIDecide_Bill`.
- `$53bc-$5504` — `AIPlay_ProfessorOak` + `AIDecide_ProfessorOak` (19 deck-specific Func_2152x-Func_2163e cases left raw; one named).
- `$55cf-$55d4` — `AIDecide_ProfessorOak_Deck45Or50`.
- `$55d5-$55e7` — `AIDecide_ProfessorOak_Deck49Or4D`.
- `$5505-$5527` — `LookForEvolutionInHand`.
- `$5643-$566d` — `AIPlay_EnergyRetrieval`.
- `$566e-$56e3` — `AIDecide_EnergyRetrieval` (22-deck-ID dispatcher; falls through to `.default` which gates on `CountBasicEnergyCardsInHand` and bails with `ret nc` when no basic energies remain in hand to discard as ER fuel).
- `$5a9d-$5ade` — `AIPlay_SuperEnergyRetrieval`.
- `$6373-$6395` — `AIPlay_ItemFinder`.
- `$664d-$2693` — `AIPlay_ImakuniCard` + `AIDecide_ImakuniCard` (inline `deck_50_dark_primeape`).
- `$6694-$271a` — `AIPlay_Gambler` + `AIDecide_Gambler`.
- `$7a43-$7a72` — `AIPlay_Sleep` + `AIDecide_Sleep` + `AIDecide_Sleep_Deck12` (deck-$53 case `$7a73` left raw).

### Still raw, in priority order (highest = most leverage)
Addresses listed are bank-$08 CPU addresses; nearest table card in
parens.

1. `$56e4-$5a9c` (ENERGY_RETRIEVAL deck cases + post-`.default` logic) — 22 deck-specific handlers at `$57c8, $57d2, $581d, $589d, $58cf, $5937, $5969, $599b, $59cd, $5a0b, $5a10, $5a19, $5a22, $5a2b, $5a34, $5a53, $5a5c, $5a70, $5a75, $5a7e, $5a83`, plus the second deck-ID dispatcher inside the `.default` continuation at `$56e4` (decks `$19, $22, $32, $42, $44, $45, $51, $62, $6e` → branches at `$5720, $591a, $592c, $572c`). **Last bucket of hot duel-gene hits (144 remaining undecompiled).**
2. `$5adf` (SUPER_ENERGY_RETRIEVAL decide) — likely similar shape to `AIDecide_EnergyRetrieval`.
3. Deck-specific helpers referenced as raw hex inside the decompiled deciders. Sōsuke is deck `$12` (SLEEP) and `$54` or similar in PROFESSOR_OAK (which falls through to default scoring); other special-case decks haven't been traced:
   - `$4365` (POTION Phase 10, deck `$45` Dark Jolteon/Raichu)
   - `$4902, $493d, $494f, $49a7-$49de` (SWITCH Phase 16, 14 deck-specific cases)
   - `$4bc5d` in bank `$12` (POTION Phase 11, deck `$74` delegate)
   - `$5528-$563e` (PROFESSOR_OAK, 20 deck-specific cases including `$11, $2d, $32, $3a, $3b, $45, $49, $4d, $50, $53, $55, $57, $58, $5a, $5c, $5d, $6e, $70, $71, $72`)
   - `$7a73` (SLEEP, deck `$53` case)
4. Other `AIDecide_*` / `AIPlay_*` table entries still pointing at raw hex — most plays are AIMakeDecision wrappers, structurally identical to the ones already landed. Most decides are small.

### Trace coverage status

| Trace | Bank-$08 undecompiled hits |
|---|---|
| duel-sam | **0** ✓ |
| duel-gr-leader | **0** ✓ |
| duel-sousuke | **0** ✓ (deck $12) |
| duel-takahashi | **0** ✓ (gusted, no other trainer plays) |
| duel-keita | **0** ✓ |
| duel-miura | **0** ✓ |
| duel-gr4 | **0** ✓ (played IMPOSTER_PROFESSOR_OAK + FULL_HEAL) |
| duel-ronald | 10 (deferred SUPER_ENERGY_RETRIEVAL decide territory) |
| duel-gr3, duel-gr3-2 | **0** ✓ (cleared by `AIDecide_EnergyRetrieval` dispatcher) |
| duel-gr3-3 | **0** ✓ (played THE_BOSSS_WAY; deck $39) |
| duel-ayako | **0** ✓ (played POKEBALL; deck $25) |
| duel-masahiro | **0** ✓ (played SWITCH; Phase_09 general decider) |
| duel-tashiro | 5 (played SCOOP_UP; remaining in deferred SUPER_ER territory) |
| duel-gr2 | **0** ✓ |
| duel-grx | **0** ✓ (played THE_BOSSS_WAY; deck $6a) |
| duel-midori | **0** ✓ |
| duel-yuuta, duel-yuuta2 | **0** ✓ (played THE_BOSSS_WAY + MASTER_BALL as deck $3f; ER dispatcher cleared) |
| duel-miyuki | 17 (played REVIVE + GOOP_GAS_ATTACK; remaining in deferred SUPER_ER territory) |
| duel-morino | 23 (played POKEMON_BREEDER, POKEMON_TRADER as deck $41, NIGHTLY_GARBAGE_RUN; remaining hits all in POKEMON_BREEDER decide -- big function with 7 deck cases + complex default scoring still deferred) |
| duel-renna | **0** ✓ (played DEFENDER both phases + MASTER_BALL as deck $43) |
| duel-renna2 | **0** ✓ |
| duel-ichikawa, duel-ichikawa2 | **0** ✓ (Ichikawa2 played ENERGY_REMOVAL default path) |
| duel-catherine | **0** ✓ (played POTION Phase 10 as deck $45 + PROFESSOR_OAK deck $45/$50; ER dispatcher cleared) |
| duel-yuki | **0** ✓ (played ENERGY_REMOVAL + SCOOP_UP + POKEBALL as deck $47; ER dispatcher cleared) |
| duel-shoro | 50 (played POKEMON_TRADER as deck $48; rest in deck-$48's ER handler at `$5937` + deferred SUPER_ER) |
| duel-hidero | **0** ✓ (played PLUSPOWER both phases + POKEMON_TRADER + NGR as deck $49) |
| duel-miyajima | 15 (deck $4a; rest in deck-$4a's ER handler at `$5969` + deferred SUPER_ER) |
| duel-senta | 13 (deck $4b; rest in shared deck-$4a/$4b ER handler at `$5969` + deferred SUPER_ER) |
| duel-aira | 15 (deck $4c; rest in deck-$4c's ER handler at `$599b` + deferred SUPER_ER) |
| duel-kanoko | **0** ✓ (played PROFESSOR_OAK + MR_FUJI + POKEMON_TRADER as deck $4d) |
| duel-gouda | 5 (deck $4e; rest in deferred SUPER_ER) |
| duel-grace | 19 (deck $4f; rest in deck-$4f's ER handler at `$59cd` + deferred SUPER_ER) |
| duel-kamiya | 48 (deck $50; rest in ITEMFINDER decide which depends on shared list helpers `Func_21a8c`/`Func_21c4e` still raw + deferred SUPER_ER) |
| duel-kevin | **0** ✓ (2-duel trace; both decks fell through ER dispatcher to `.default` → `ret nc`) |
| duel-rie | **0** ✓ |
| duel-rie2, duel-rie3 | 5 / 7 (only in deferred SUPER_ER territory) |
| duel-gene | 65 (mostly in deferred SUPER_ER territory + a few ER deck-specific handlers) |

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
