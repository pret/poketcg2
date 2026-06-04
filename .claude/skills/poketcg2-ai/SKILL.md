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

**Deck IDs (`wOpponentDeckID`) are `*_DECK_ID` values, NOT `deck_const`
ordinals.** The `cp $NN` checks in every dispatcher compare against the
`*_DECK_ID` namespace (defined via `deck_duel` in
[src/data/deck_id_data.asm](../../../src/data/deck_id_data.asm)), which
differs from the `deck_const` collection ordinal in
[src/constants/deck_constants.asm](../../../src/constants/deck_constants.asm).
E.g. `DIRECT_HIT_DECK_ID = $51` but `deck_const DIRECT_HIT_DECK = $53`.
**To name a deck, never read the `deck_const ; $NN` comment** — instead
resolve `<NAME>_DECK_ID` with an rgbasm probe (loop `deck_duel` entries
in deck_id_data.asm), or (most reliable) identify the deck by the card
IDs the decompiled function searches and match them against the card
lists in [src/data/decks.asm](../../../src/data/decks.asm) (the card
list label is `<Stem>Deck:`, sharing the stem with `<STEM>_DECK_ID`).
The `_DeckNN` label suffix is always the hex `*_DECK_ID` literal from
the `cp` instruction — that part is correct by construction; only
human-readable *names* are at risk.

**In comments, the parenthetical after "deck $NN" must be the official
deck name, not a signature-card nickname.** Two decks can share an AI
policy yet be different archetypes (e.g. `$45` Quick Attack and `$50`
Running Wild share `AIDecide_EnergyRemoval_Deck45Or50` but are
Lightning vs. Fighting). Describing the cards the code checks ("our
active is Dark Jolteon or Dark Raichu") is fine and accurate; calling
the *deck* "Dark Jolteon / Dark Raichu" is not — that's the Quick
Attack deck. Verified deck IDs so far: `$41`=Mad Petals, `$43`=Chain
Lightning by Pikachu, `$45`=Quick Attack, `$4a`=Whirlpool Shower,
`$50`=Running Wild, `$51`=Direct Hit, `$53`=Bad Dream.

**Name card IDs, don't hardcode hex.** Whenever an operand is a card
reference — `ld de, $XXX` / `ld bc, $XXX` before `FindCardIDInLocation`,
`LookForCardIDInHand*`, `LookForEvoCardInDeck_*`,
`FindCardIDInTurnDuelistsPlayArea`, `IsCardIDInDeckAndNotInHand`, etc.,
or `cp16 $XXX` against a card — write the named constant from
[card_constants.asm](../../../src/constants/card_constants.asm), e.g.
`ld de, PROFESSOR_OAK` not `ld de, $18e`. Resolve the value with an
rgbasm probe or by counting `const` entries (the Nth `const` = value N,
starting at 1; verified `$125`=GASTLY_LV13). `make compare` proves the
constant equals the byte. Leave hex only for non-card operands (WRAM
addrs, list pointers, flags) and for `jp/call $XXXX` to still-raw
functions.

Applies to new functions AND **boy-scout**: when a trace analysis brings
you to an existing line whose hex operand is clearly a card ID, replace
it with the label in the same pass — leave the code better than you
found it.

**The wholesale retroactive pass was done early on 2026-06-03** (user
request): all 189 card-ID operands in `bank08.asm` are now named
constants. The two `ld de, $10e` before `bank1call TossCoin` were NOT
cards (the classic "value in card range but not a card" trap — `de`/`bc`
are card IDs only when consumed by a `*CardID*`/`AITryMasterBall_GivenTarget`/
`Count*PkmnPower` helper); they are coin-toss prompt **text IDs** and are
now written idiomatically as `ldtx de, TrainerCardSuccessCheckText`
(`ldtx X, Y` expands to `ld X, Y_`, where `Y_` is the text-offset constant
from `text/text_offsets.asm`'s `textpointer` enumeration). No hex
`ld de`/`ld bc`/`ld hl`/`cp16` operands remain. If new raw functions are
later decompiled with hex operands, re-run the pass; it's mechanical and
`make compare`-verified.

**Non-card hex was also labelled (2026-06-03), only where 100% certain and
only on branch-added lines:** every `cp $NN` inside an
`ld a, [wOpponentDeckID]` dispatch run now uses the `*_DECK_ID` constant
(the symbol — its internal name; the official display name still lives in
the comment); `ld a, $00/$01/$02` immediately before
`FindCardIDInLocation`/`CreateBasicEnergyCardListInLocation` uses
`CARD_LOCATION_DECK/HAND/DISCARD_PILE`; `[$c511]`/`[$c512]` →
`wDuelTempList + 1/+2`. Left as hex (no exact label / not certain): raw
`jp z, $XXXX` dispatch targets to still-raw functions, WRAM scratch with
no label (`$d09a`, `$cc3b`, `$d0a4`, `$ffa6`+), and bare arithmetic /
position / sentinel literals (`and $0f`, `cp $36`, `ld e, $00`,
`ld a, $ff`).

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
| `$08` | `$4365` | [`AIDecide_Potion_Phase10_Deck45`](../../../src/engine/bank08.asm) | sameboy_trace duel-catherine (deck $45 Quick Attack; Dark Jolteon/Raichu cards) | 2026-06-02 |
| `$08` | `$439b` | [`AIDecide_Potion_Phase11`](../../../src/engine/bank08.asm) | sameboy_trace duel-sam | 2026-06-01 |
| `$08` | `$43aa` | [`AIPlay_SuperPotion`](../../../src/engine/bank08.asm) + `AIDecide_SuperPotion_Phase08`/`_Phase11`/`_Phase13` + helpers (`CheckIfPlayAreaCardHasAttachedEnergy` ×2, `CheckIfEitherAttackUsableAndHasFlag10`, `CheckIfEnergyDiscardBreaksEitherAttack`) | sameboy_trace duel-biruitchi redo (313-byte Super Potion cluster: heal min(40,dmg) + discard energy; Phase11 bench-heal scan) | 2026-06-03 |
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
| `$08` | `$4de7` | [`AIDecide_EnergyRemoval_Deck45Or50`](../../../src/engine/bank08.asm) | sameboy_trace duel-kamiya (deck $45 Quick Attack + $50 Running Wild shared; Double Colorless priority) | 2026-06-02 |
| `$08` | `$4e90` | [`AIDecide_EnergyRemoval_Deck4A`](../../../src/engine/bank08.asm) | sameboy_trace duel-miyajima (deck $4a Whirlpool Shower; Dark Vaporeon/Starmie cards) | 2026-06-02 |
| `$08` | `$4ede` | [`AIDecide_EnergyRemoval_Deck55`](../../../src/engine/bank08.asm) | sameboy_trace duel-mami (deck $55 Spirited Away) | 2026-06-02 |
| `$08` | `$4f05` | [`AIDecide_EnergyRemoval_Deck74`](../../../src/engine/bank08.asm) | sameboy_trace duel-mami (trampoline to bank-13 Func_4c676) | 2026-06-02 |
| `$08` | `$4f0a` | [`AIPlay_SuperEnergyRemoval`](../../../src/engine/bank08.asm) | sameboy_trace duel-mami (SUPER_ENERGY_REMOVAL table entry, was raw) | 2026-06-02 |
| `$08` | `$4f33` | [`AIDecide_SuperEnergyRemoval`](../../../src/engine/bank08.asm) + helpers `CheckIfPlayAreaCardHasTwoEnergy`, `CheckIfRemovingEnergyDisruptsAttack`, `ScoreSuperEnergyRemovalTarget` | sameboy_trace duel-mami | 2026-06-02 |
| `$08` | `$5610` | [`AIDecide_ProfessorOak_Deck55`](../../../src/engine/bank08.asm) | sameboy_trace duel-mami (play Oak when hand < 8) | 2026-06-02 |
| `$08` | `$5616` | `AIDecide_ProfessorOak_Deck57`…`_Deck72` (9 per-deck delegates) | sameboy_trace duel-ishii ($57 Eye of the Storm = Ishii; thin bank-$0e/$12 delegates, deck $5d still raw Func_4c4ba) | 2026-06-02 |
| `$08` | `$5a0b` | `AIDecide_EnergyRetrieval_Deck57` | sameboy_trace duel-ishii (Eye of the Storm; bank-$0e delegate, rest of $57c8-$5a8c gap still raw) | 2026-06-02 |
| `$08` | `$5a53` | `AIDecide_EnergyRetrieval_Deck6C` | sameboy_trace duel-ronald2 ($6c = Ronald's Super deck; bank-$12 helper then rejoin .got_target) | 2026-06-02 |
| `$08` | `$5a19` | `AIDecide_EnergyRetrieval_Deck5D` | sameboy_trace duel-rui ($5d Psychic Battle; raw Func_4c524 then rejoin .got_target) | 2026-06-03 |
| `$08` | `$5a22` | `AIDecide_EnergyRetrieval_Deck5F` | sameboy_trace duel-biruitchi (deck $5f = internal ScorcherDeck, a Fire/Dark-Charizard deck; bank-$12 helper then rejoin .got_target) | 2026-06-03 |
| `$08` | `$5c4e` | [`RemoveCardFromListByValue`](../../../src/engine/bank08.asm) | sameboy_trace duel-mami (used by AIDecide_ItemFinder) | 2026-06-02 |
| `$08` | `$6396` | [`AIDecide_ItemFinder`](../../../src/engine/bank08.asm) | sameboy_trace duel-mami (dispatcher + default; all deck cases now decompiled) | 2026-06-02 |
| `$08` | `$6421` | `AIDecide_ItemFinder_Deck1A`/`_Deck1E`/`_Deck50` | sameboy_trace duel-andrew ($1e Awesome Fossil = Andrew; recover-trainer-from-discard policies; completes the ItemFinder dispatch) | 2026-06-03 |
| `$08` | `$6542` | [`AIDecide_ItemFinder_Deck55`](../../../src/engine/bank08.asm) | sameboy_trace duel-mami (priority trainer fetch from discard) | 2026-06-02 |
| `$08` | `$65ad` | [`AIDecide_ItemFinder_Deck56`](../../../src/engine/bank08.asm) + helper [`StoreItemFinderDiscardTarget`](../../../src/engine/bank08.asm) | sameboy_trace duel-nishijima redo (Snorlax Guard $56; discard duplicates after recoverable trainer in discard) | 2026-06-02 |
| `$08` | `$662b` | [`AIDecide_ItemFinder_Deck58`](../../../src/engine/bank08.asm) + [`AIDecide_ItemFinder_Deck6E`](../../../src/engine/bank08.asm) | gap-fill ($58 Sudden Growth, $6e Everybody's Friend; both bank-$12 delegates) | 2026-06-02 |
| `$08` | `$52fb` | [`AIDecide_PokemonBreeder_Deck55`](../../../src/engine/bank08.asm) | sameboy_trace duel-mami (Gastly→Dark Gengar; PB dispatcher $50b6 still raw) | 2026-06-02 |
| `$08` | `$6cfd` | [`AIPlay_ComputerSearch`](../../../src/engine/bank08.asm) + [`AIDecide_ComputerSearch`](../../../src/engine/bank08.asm) | sameboy_trace duel-mami (COMPUTER_SEARCH table entry; dispatcher, 8 deck cases left raw) | 2026-06-02 |
| `$08` | `$6e0a` | [`AIDecide_ComputerSearch_Deck55`](../../../src/engine/bank08.asm) | sameboy_trace duel-mami (trampoline to SpiritedAwayDeckAIDecideComputerSearch) | 2026-06-02 |
| `$08` | `$6e0f` | `AIDecide_ComputerSearch_Deck57`…`_Deck70` (5 per-deck delegates) | sameboy_trace duel-ishii (Eye of the Storm; bank-$0e/$12 delegates) | 2026-06-02 |
| `$08` | `$78f2` | [`AIDecide_NightlyGarbageRun_Deck55`](../../../src/engine/bank08.asm) | sameboy_trace duel-mami (rescue energies + Psychic line from discard) | 2026-06-02 |
| `$08` | `$620f` | [`AIDecide_ScoopUp_Deck47`](../../../src/engine/bank08.asm) | sameboy_trace duel-yuki | 2026-06-02 |
| `$08` | `$6b60` | [`AIDecide_Pokeball_Deck47`](../../../src/engine/bank08.asm) | sameboy_trace duel-yuki | 2026-06-02 |
| `$08` | `$6bbb` | [`AIDecide_Pokeball_Deck4A`](../../../src/engine/bank08.asm) | sameboy_trace duel-miyajima | 2026-06-02 |
| `$08` | `$6bf8` | [`AIDecide_Pokeball_Deck4B`](../../../src/engine/bank08.asm) | sameboy_trace duel-senta | 2026-06-02 |
| `$08` | `$6c35` | [`AIDecide_Pokeball_Deck4E`](../../../src/engine/bank08.asm) | sameboy_trace duel-gouda (uses `CheckReelInEvoLineTarget`) | 2026-06-02 |
| `$08` | `$489c` | [`AIDecide_Switch_Phase16`](../../../src/engine/bank08.asm) | sameboy_trace duel-sam | 2026-06-01 |
| `$08` | `$49a7` | `AIDecide_Switch_Phase16_Deck5B`…`_Deck72` (12 per-deck delegates) | sameboy_trace duel-rui ($5c hit; thin bank-$0e/$12 delegates; decks $32/$3a/$3b/$3d inline deciders still raw) | 2026-06-03 |
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
| `$08` | `$566e` | [`AIDecide_EnergyRetrieval`](../../../src/engine/bank08.asm) | sameboy_trace duel-kevin (dispatcher + full `.default` target-selection algorithm; 22 deck cases left raw) | 2026-06-02 |
| `$08` | `$5a9d` | [`AIPlay_SuperEnergyRetrieval`](../../../src/engine/bank08.asm) | AITrainerCardLogic table entry | 2026-06-01 |
| `$08` | `$5ce2` | [`AIPlay_ImposterProfessorOak`](../../../src/engine/bank08.asm) | sameboy_trace duel-gr4 | 2026-06-01 |
| `$08` | `$5cee` | [`AIDecide_ImposterProfessorOak`](../../../src/engine/bank08.asm) | sameboy_trace duel-gr4 | 2026-06-01 |
| `$08` | `$5f63` | [`AIPlay_FullHeal`](../../../src/engine/bank08.asm) | sameboy_trace duel-gr4 | 2026-06-01 |
| `$08` | `$5d2d` | [`AIPlay_EnergySearch`](../../../src/engine/bank08.asm) | sameboy_trace duel-ronald | 2026-06-01 |
| `$08` | `$5d3e` | [`AIDecide_EnergySearch`](../../../src/engine/bank08.asm) + Deck0D + Deck66 + helper `LookForEnergyUsefulToPlayArea` | sameboy_trace duel-ronald | 2026-06-01 |
| `$08` | `$5f6f` | [`AIDecide_FullHeal`](../../../src/engine/bank08.asm) | sameboy_trace duel-gr4 (shared SCOOP_UP helper `$60ed` still raw) | 2026-06-01 |
| `$08` | `$602b` | [`AIDecide_FullHeal_Deck53`](../../../src/engine/bank08.asm) | sameboy_trace duel-yosuke (deck $53 Bad Dream; gated on defender Asleep) | 2026-06-02 |
| `$08` | `$55e8` | [`AIDecide_ProfessorOak_Deck53`](../../../src/engine/bank08.asm) | sameboy_trace duel-yosuke (hand 5-10 unless holding Gastly/Haunter22/Drowzee) | 2026-06-02 |
| `$08` | `$6c5c` | [`AIDecide_Pokeball_Deck53`](../../../src/engine/bank08.asm) | sameboy_trace duel-yosuke (7-card deck search of the Psychic line) | 2026-06-02 |
| `$08` | `$7a73` | [`AIDecide_Sleep_Deck53`](../../../src/engine/bank08.asm) | sameboy_trace duel-yosuke (Haunter22 active + defender not already Asleep) | 2026-06-02 |
| `$08` | `$5a8c` | [`RemoveCardFromListAtHL`](../../../src/engine/bank08.asm) | sameboy_trace duel-miwa (shared list-compaction helper; used by ER + ITEMFINDER) | 2026-06-02 |
| `$08` | `$73d8` | [`AIDecide_PokemonTrader_Deck51`](../../../src/engine/bank08.asm) | sameboy_trace duel-miwa (deck $51 Direct Hit; Abra/Mewtwo/Dark Alakazam line) | 2026-06-02 |
| `$08` | `$7456` | `AIDecide_PokemonTrader_Deck5A`…`_Deck74` (12 per-deck delegates) | sameboy_trace duel-ronald2 ($6c hit; thin bank-$0e/$12 delegates, deck $6d still raw Func_487ff) | 2026-06-02 |
| `$08` | `$7586` | [`AIDecide_TheBosssWay_Deck51`](../../../src/engine/bank08.asm) | sameboy_trace duel-miwa (same chains as deck $51 Trader) | 2026-06-02 |
| `$08` | `$75b2` | [`AIDecide_TheBosssWay_Deck58`](../../../src/engine/bank08.asm) + [`AIDecide_TheBosssWay_Deck5A`](../../../src/engine/bank08.asm) | sameboy_trace duel-samejima ($58 Sudden Growth = Samejima; $5a Bad Guys delegate) | 2026-06-02 |
| `$08` | `$7956` | [`AIDecide_NightlyGarbageRun_Deck58`](../../../src/engine/bank08.asm) + [`_Deck5A`](../../../src/engine/bank08.asm) + [`_Deck6F`](../../../src/engine/bank08.asm) | sameboy_trace duel-samejima (Sudden Growth rescues Dragonair/Clefable lines + basic energy; $5a/$6f delegates) | 2026-06-02 |
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
| `$08` | `$6858` | `AIPlay_ClefairyDollOrMysteriousFossil` + `AIDecide_ClefairyDollOrMysteriousFossil` (+ inline `.deck_1a`, `.deck_3b`) | sameboy_trace duel-andrew (shared by both Trainer-as-Basic cards; play to fill a bench slot) | 2026-06-03 |
| `$08` | `$6e28` | [`AIPlay_PokemonTrader`](../../../src/engine/bank08.asm) | sameboy_trace duel-rie | 2026-06-01 |
| `$08` | `$6e43` | [`AIDecide_PokemonTrader`](../../../src/engine/bank08.asm) | sameboy_trace duel-rie (dispatcher only; 25 deck-specific cases left raw) | 2026-06-01 |
| `$08` | `$6f1b` | [`AIDecide_PokemonTrader_Deck18`](../../../src/engine/bank08.asm) | sameboy_trace duel-rie (Rie is deck $18) | 2026-06-01 |
| `$08` | `$7040` | [`AIDecide_PokemonTrader_Deck2D`](../../../src/engine/bank08.asm) | sameboy_trace duel-amy (Rain Dance Confusion; Squirtle/Seel evo-line trader) | 2026-06-03 |
| `$08` | `$6d59` | [`AIDecide_ComputerSearch_Deck2D`](../../../src/engine/bank08.asm) | sameboy_trace duel-amy (delegate to RainDanceConfusionDeckAIDecideComputerSearch) | 2026-06-03 |
| `$08` | `$581d` | [`AIDecide_EnergyRetrieval_Deck2D`](../../../src/engine/bank08.asm) | sameboy_trace duel-amy (gated energy-recovery heuristic; $44 shares tail) | 2026-06-03 |
| `$08` | `$70a7` | [`AIDecide_PokemonTrader_Deck32`](../../../src/engine/bank08.asm) | sameboy_trace duel-ken (Go Arcanine; Growlithe/Doduo/Hitmonchan/Seel evo-line trader) | 2026-06-03 |
| `$08` | `$4902` | [`AIDecide_Switch_Phase16_Deck32`](../../../src/engine/bank08.asm) + shared `AIDecide_Switch_Phase16_CommitBenchTarget` ($48fc) | sameboy_trace duel-ken (Go Arcanine; switch when Arena is Arcanine/KO-able) | 2026-06-03 |
| `$08` | `$6eca` | [`AIDecide_PokemonTrader_Deck17`](../../../src/engine/bank08.asm) | sameboy_trace duel-murray (Psychic Elite; Abra/Kadabra/Alakazam + Mr. Mime trader) | 2026-06-03 |
| `$08` | `$765e` | [`AIDecide_NightlyGarbageRun_Deck17`](../../../src/engine/bank08.asm) | sameboy_trace duel-murray (Psychic Elite; recover Alakazam line + energy from discard) | 2026-06-03 |
| `$08` | `$61e2` | [`AIDecide_ScoopUp_Deck17`](../../../src/engine/bank08.asm) | sameboy_trace duel-murray (Psychic Elite; delegate to PsychicEliteDeckAIDecideScoopUp) | 2026-06-03 |
| `$08` | `$632c` | [`AIPlay_Lass`](../../../src/engine/bank08.asm) + [`AIDecide_Lass`](../../../src/engine/bank08.asm) ($6340) | sameboy_trace duel-courtney (whole trainer card; play when opp hand 7+ and we hold no other Trainer) | 2026-06-03 |
| `$08` | `$493d` | [`AIDecide_Switch_Phase16_Deck3AOr3B`](../../../src/engine/bank08.asm) | sameboy_trace duel-courtney (Grand Fire + Legendary Fossil share; switch on retreat cost >= 2) | 2026-06-03 |
| `$08` | `$559c` | [`AIDecide_ProfessorOak_Deck3A`](../../../src/engine/bank08.asm) | sameboy_trace duel-courtney (Grand Fire; keep hand with Moltres/Rapidash/Ninetales or 3+ energy) | 2026-06-03 |
| `$08` | `$6201` | [`AIDecide_ScoopUp_Deck3A`](../../../src/engine/bank08.asm) | sameboy_trace duel-courtney (Grand Fire; scoop benched Moltres via shared energy-ready tail) | 2026-06-03 |
| `$08` | `$691e` | [`AIDecide_Pokeball_Deck3A`](../../../src/engine/bank08.asm) | sameboy_trace duel-courtney (Grand Fire; Magmar/Ponyta-Rapidash/Vulpix-Ninetales/Moltres dig) | 2026-06-03 |
| `$08` | `$76ad` | [`AIDecide_NightlyGarbageRun_Deck3A`](../../../src/engine/bank08.asm) | sameboy_trace duel-courtney (Grand Fire; recover 2 energy + Moltres from discard) | 2026-06-03 |
| `$08` | `$55c9` | [`AIDecide_ProfessorOak_Deck3B`](../../../src/engine/bank08.asm) | sameboy_trace duel-steve (Legendary Fossil; Oak when own hand < 4) | 2026-06-03 |
| `$08` | `$6d5e` | [`AIDecide_ComputerSearch_Deck3B`](../../../src/engine/bank08.asm) | sameboy_trace duel-steve (Legendary Fossil; fetch Aerodactyl/PlusPower/Oak/Bill) | 2026-06-03 |
| `$08` | `$76d6` | [`AIDecide_NightlyGarbageRun_Deck3B`](../../../src/engine/bank08.asm) | sameboy_trace duel-steve (Legendary Fossil; recover 2 energy + Zapdos) | 2026-06-03 |
| `$08` | `$79f5` | [`AIPlay_FossilExcavation`](../../../src/engine/bank08.asm) + [`AIDecide_FossilExcavation`](../../../src/engine/bank08.asm) ($7a13, inline `_Deck3BOr63`) | sameboy_trace duel-steve (whole trainer card; recover Mysterious Fossil from discard/deck) | 2026-06-03 |
| `$08` | `$5a75` | [`AIDecide_EnergyRetrieval_Deck73`](../../../src/engine/bank08.asm) | sameboy_trace duel-anna (Damage Chaos; bank-helper delegate) | 2026-06-03 |
| `$08` | `$75f9` | [`AIDecide_TheBosssWay_Deck73`](../../../src/engine/bank08.asm) | sameboy_trace duel-anna (Damage Chaos; delegate to DamageChaosDeckAIDecideTheBosssWay) | 2026-06-03 |
| `$08` | `$5a7e` | [`AIDecide_EnergyRetrieval_Deck74`](../../../src/engine/bank08.asm) | sameboy_trace duel-dee (Big Thunder; bank-helper delegate) | 2026-06-03 |
| `$08` | `$6246` | [`AIDecide_ScoopUp_Deck74`](../../../src/engine/bank08.asm) | sameboy_trace duel-dee (Big Thunder; delegate to BigThunderDeckAI_4c7b5) | 2026-06-03 |
| `$08` | `$4d6b` | [`AIDecide_EnergyRemoval_Deck11`](../../../src/engine/bank08.asm) | sameboy_trace duel-isaac (Electric Self-Destruct; strip bench Double Colorless, else KO-enabling arena removal) | 2026-06-03 |
| `$08` | `$5528` | [`AIDecide_ProfessorOak_Deck11`](../../../src/engine/bank08.asm) | sameboy_trace duel-isaac (Electric Self-Destruct; redraw small hand clogged with Magnemite/Voltorb) | 2026-06-03 |
| `$08` | `$57c8` | [`AIDecide_EnergyRetrieval_Deck11`](../../../src/engine/bank08.asm) | sameboy_trace duel-isaac (Electric Self-Destruct; <3 energy then shared finder via new .find_recharge_target) | 2026-06-03 |
| `$08` | `$58cf` | [`AIDecide_EnergyRetrieval_Deck40`](../../../src/engine/bank08.asm) | sameboy_trace duel-miyuki (Sticky Poison Gas; Muk+Goop Gas Attack or duplicate) | 2026-06-03 |
| `$08` | `$7789` | [`AIDecide_NightlyGarbageRun_Deck40`](../../../src/engine/bank08.asm) | sameboy_trace duel-miyuki (Sticky Poison Gas; multi-target rescue of Poison line + energy) | 2026-06-03 |
| `$08` | `$7d61` | [`AIDecide_MasterBall_Deck40`](../../../src/engine/bank08.asm) | sameboy_trace duel-miyuki (Sticky Poison Gas; complete Koffing/Grimer/Ekans evo lines) | 2026-06-03 |
| `$08` | `$5a10` | [`AIDecide_EnergyRetrieval_Deck5A`](../../../src/engine/bank08.asm) | pattern-inferred pure delegate (Bad Guys) | 2026-06-03 |
| `$08` | `$5a2b` | [`AIDecide_EnergyRetrieval_Deck63`](../../../src/engine/bank08.asm) | pattern-inferred pure delegate (Protohistoric) | 2026-06-03 |
| `$08` | `$5a70` | [`AIDecide_EnergyRetrieval_Deck72`](../../../src/engine/bank08.asm) | pattern-inferred pure delegate (Blazing Flame) | 2026-06-03 |
| `$08` | `$5a83` | [`AIDecide_EnergyRetrieval_Deck75`](../../../src/engine/bank08.asm) | pattern-inferred pure delegate (Power of Darkness) | 2026-06-03 |
| `$08` | `$6241` | [`AIDecide_ScoopUp_Deck6E`](../../../src/engine/bank08.asm) | pattern-inferred pure delegate (Everybody's Friend) | 2026-06-03 |
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
| `$08` | `$7dc7` | [`AIDecide_MasterBall_Deck46`](../../../src/engine/bank08.asm) | gap-fill (deck $46 Complete Combustion; Fire-attacker priority list) | 2026-06-02 |
| `$08` | `$7df4` | [`AIDecide_MasterBall_Deck74`](../../../src/engine/bank08.asm) | gap-fill (deck $74 Big Thunder; delegates to bank-$12) | 2026-06-02 |
| `$08` | `$7df9` | [`AIPlay_BillsTeleporter`](../../../src/engine/bank08.asm) + [`AIDecide_BillsTeleporter`](../../../src/engine/bank08.asm) | sameboy_trace duel-nishijima (play when <47 cards out of deck) | 2026-06-02 |
| `$08` | `$7e0b` | [`AIPlay_MoonStone`](../../../src/engine/bank08.asm) + [`AIDecide_MoonStone`](../../../src/engine/bank08.asm) | gap-fill (6-way deck dispatch on Moon Stone evo targets) | 2026-06-02 |
| `$08` | `$7e79` | [`AIPlay_TheRocketsTrap`](../../../src/engine/bank08.asm) + [`AIDecide_TheRocketsTrap`](../../../src/engine/bank08.asm) | gap-fill (play vs large opponent hand: 5+, or 3+ for deck $6d) | 2026-06-02 |
| `$08` | `$7e9e` | [`AIPlay_GoopGasAttack`](../../../src/engine/bank08.asm) | sameboy_trace duel-miyuki | 2026-06-01 |
| `$08` | `$7eaa` | [`AIDecide_GoopGasAttack`](../../../src/engine/bank08.asm) | sameboy_trace duel-miyuki | 2026-06-01 |
| `$08` | `$7f3e` | [`AIPlay_ComputerError`](../../../src/engine/bank08.asm) | sameboy_trace duel-grx | 2026-06-02 |
| `$08` | `$7f61` | [`AIDecide_ComputerError`](../../../src/engine/bank08.asm) + inline `Deck59`, `Deck68`, `Deck6B` | sameboy_trace duel-grx | 2026-06-02 |
| `$08` | `$7f96` | [`AIPlay_SuperScoopUp`](../../../src/engine/bank08.asm) | sameboy_trace duel-grx (coin-flip wrapper) | 2026-06-02 |
| `$08` | `$7fbc` | [`AIDecide_SuperScoopUp`](../../../src/engine/bank08.asm) | sameboy_trace duel-grx | 2026-06-02 |
| `$08` | `$7a43` | [`AIPlay_Sleep`](../../../src/engine/bank08.asm) | sameboy_trace duel-sousuke (deck $12) | 2026-06-01 |
| `$08` | `$7a4f` | [`AIDecide_Sleep`](../../../src/engine/bank08.asm) + `AIDecide_Sleep_Deck12` | sameboy_trace duel-sousuke (deck $12) | 2026-06-01 |
| `$08` | `$7b0a` | [`AIPlay_MasterBall`](../../../src/engine/bank08.asm) | sameboy_trace duel-rie3 | 2026-06-01 |
| `$08` | `$7b1f` | [`AIDecide_MasterBall`](../../../src/engine/bank08.asm) | sameboy_trace duel-rie3 (12-way dispatch; decks $13, $14 inline; decks $18/$1a/$29/$3d/$3e/$3f/$43/$46/$74 decompiled; only deck $40 left raw) | 2026-06-01 |
| `$08` | `$7bdf` | `AIDecide_MasterBall_Deck18`/`_Deck1A`/`_Deck29`/`_Deck3D`/`_Deck3E` | sameboy_trace duel-daniel ($1a Puppet Master = Daniel; evo-line Master Ball targeting; fills the gap before Deck3F) | 2026-06-03 |

## Bank $08 decompilation status

**Source-defined**: 76.86% (~12.3 KiB of 16 KiB).
**Last updated**: 2026-06-03.

### Decompiled regions (named, in source)
- `$4000-$4c32` — `AITrainerCardLogic` table + early decompiled functions through `Func_20be6.return_with_carry`.
- `$42d0-$4364` — `AIDecide_Potion_Phase10` + `CheckIfAnyAttackBoostsIfTakenDamage`.
- `$4365-$439a` — `AIDecide_Potion_Phase10_Deck45`.
- `$439b-$43a9` — `AIDecide_Potion_Phase11` + `AIDecide_Potion_Phase11_Deck74`.
- `$43aa-$44e2` — Super Potion cluster: `AIPlay_SuperPotion` + `AIDecide_SuperPotion_Phase08`/`_Phase11`/`_Phase13` + 4 helpers (`CheckIfPlayAreaCardHasAttachedEnergy` and a byte-identical duplicate, `CheckIfEitherAttackUsableAndHasFlag10`, `CheckIfEnergyDiscardBreaksEitherAttack`).
- `$483d-$489b` — `AIPlay_Switch` (shared by Phase_09 and Phase_16) + `AIDecide_Switch_Phase09`.
- `$44e3-$4677` — `AIPlay_Defender` + `AIDecide_Defender_Phase13` (inline decks $50, $74) + `AIDecide_Defender_Phase14` (inline deck $72).
- `$4678-$483c` — `AIPlay_PlusPower` + `AIDecide_PlusPower_Phase13` + `AIDecide_PlusPower_Phase14` (inline `Deck45`) + 5 helpers (`CheckIfPlusPowerEnablesKO_Phase13`, `CheckIfDamageThresholdMetForPlusPower_Phase13`, `CheckIfDamageThresholdMetForPlusPower_Phase14` [byte-duplicate of Phase13], `CheckIfAttackWontKOAlready`, `ScoreAttackWithPoisonDiscount`).
- `$4c44-$4d6a` — `AIPlay_EnergyRemoval` + `AIDecide_EnergyRemoval` (6 deck cases left raw) + 3 helpers (`CheckIfHasNonRecycleEnergy`, `CheckIfBothAttacksStillNeedEnergy`, `ScoreBenchEnergyRemovalCandidate`).
- `$4de7-$4e3b` — `AIDecide_EnergyRemoval_Deck45Or50` (Double Colorless priority pass + standard "would-KO + meaningful-HP" gate).
- `$4e3c-$4e8f` — `AIDecide_EnergyRemoval_Deck47` + `CheckIfEnergyRemovalDisruptsBigAttack`.
- `$4e90-$4edd` — `AIDecide_EnergyRemoval_Deck4A`.
- `$4ede-$507a` — `AIDecide_EnergyRemoval_Deck55` + `AIDecide_EnergyRemoval_Deck74` (trampoline) + `AIPlay_SuperEnergyRemoval` + `AIDecide_SuperEnergyRemoval` (with embedded `.check_discardable_energy` + 3 helpers `CheckIfPlayAreaCardHasTwoEnergy`, `CheckIfRemovingEnergyDisruptsAttack`, `ScoreSuperEnergyRemovalTarget`).
- `$52fb-$5322` — `AIDecide_PokemonBreeder_Deck55` (standalone; parent dispatcher `$50b6` still raw).
- `$5610-$5615` — `AIDecide_ProfessorOak_Deck55`.
- `$5616-$5642` — `AIDecide_ProfessorOak_Deck57/_58/_5A/_5C/_5D/_6E/_70/_71/_72` (9 thin per-deck delegates; $5d = raw Func_4c4ba).
- `$5a0b-$5a0f` — `AIDecide_EnergyRetrieval_Deck57` (Eye of the Storm delegate; isolated in the still-raw $57c8-$5a8c EnergyRetrieval deck-case block).
- `$5a19-$5a21` — `AIDecide_EnergyRetrieval_Deck5D` (Psychic Battle; raw Func_4c524 then rejoins `.got_target`; isolated in that block).
- `$5a22-$5a2a` — `AIDecide_EnergyRetrieval_Deck5F` (internal ScorcherDeck, a Fire/Dark-Charizard deck; bank-$12 helper then rejoins `.got_target`; isolated in that block).
- `$5a53-$5a5b` — `AIDecide_EnergyRetrieval_Deck6C` (Ronald's Super deck; bank-$12 helper, then rejoins `AIDecide_EnergyRetrieval.got_target`; also isolated in that block).
- `$5c4e-$5c58` — `RemoveCardFromListByValue`.
- `$6396-$641f` — `AIDecide_ItemFinder` (dispatcher + default duplicate-pick path).
- `$6421-$6541` — `AIDecide_ItemFinder_Deck1A` (Puppet Master) + `_Deck1E` (Awesome Fossil) + `_Deck50` (Running Wild); all ItemFinder deck cases now decompiled.
- `$6542-$664c` — `AIDecide_ItemFinder_Deck55` + `AIDecide_ItemFinder_Deck56` + `AIDecide_ItemFinder_Deck58` + `AIDecide_ItemFinder_Deck6E` + helper `StoreItemFinderDiscardTarget`.
- `$6cfd-$6d58` — `AIPlay_ComputerSearch` + `AIDecide_ComputerSearch` (dispatcher; 8 deck cases left raw).
- `$6e0a-$6e27` — `AIDecide_ComputerSearch_Deck55` (trampoline) + `_Deck57/_58/_6E/_6F/_70` (5 per-deck delegates).
- `$78f2-$7955` — `AIDecide_NightlyGarbageRun_Deck55`.
- `$7956-$79de` — `AIDecide_NightlyGarbageRun_Deck58` (Sudden Growth; rescue Dragonair/Clefable lines from discard + basic energy) + `_Deck5A` + `_Deck6F` (bank-$12 delegates).
- `$620f-$6227` — `AIDecide_ScoopUp_Deck47` (jumps back to AIDecide_ScoopUp's local labels).
- `$6b60-$6bba` — `AIDecide_Pokeball_Deck47`.
- `$6bbb-$6bf7` — `AIDecide_Pokeball_Deck4A`.
- `$6bf8-$6c34` — `AIDecide_Pokeball_Deck4B`.
- `$6c35-$6c5b` — `AIDecide_Pokeball_Deck4E`.
- `$489c-$48fb` — `AIDecide_Switch_Phase16` (deck $32 done at $4902; decks $3a/$3b/$3d inline sub-deciders $493d-$49a6 still raw).
- `$49a7-$49e2` — `AIDecide_Switch_Phase16_Deck5B…_Deck72` (12 thin per-deck delegates).
- `$49e3-$49fb` — `AIPlay_GustOfWind`.
- `$6e28-$6ec9` — `AIPlay_PokemonTrader` + `AIDecide_PokemonTrader` (dispatcher; 25 deck cases left raw).
- `$6f1b-$6f87` — `AIDecide_PokemonTrader_Deck18`.
- `$7040-$70a6` — `AIDecide_PokemonTrader_Deck2D` (Rain Dance Confusion; Squirtle/Wartortle/Blastoise + Seel/Dewgong evo-line trader).
- `$6d59-$6d5d` — `AIDecide_ComputerSearch_Deck2D` (Rain Dance Confusion; bank-helper delegate).
- `$581d-$58ce` — `AIDecide_EnergyRetrieval_Deck2D` (Rain Dance Confusion; gated energy-recovery heuristic; deck $44 reuses tail at `.check_energy_count` = $589d).
- `$70a7-$71d3` — `AIDecide_PokemonTrader_Deck32` (Go Arcanine; Magmar/Growlithe-Arcanine/Doduo-Dodrio/Hitmonchan/Seel-Dewgong evo-line trader).
- `$48fc-$4901` — `AIDecide_Switch_Phase16_CommitBenchTarget` (shared bench-pick commit tail) + `$4902-$493c` — `AIDecide_Switch_Phase16_Deck32` (Go Arcanine). Sub-deciders $493d-$49a6 (decks $3a/$3b/$3d) still raw.
- `$61e2-$61e6` — `AIDecide_ScoopUp_Deck17` (Psychic Elite; bank-helper delegate).
- `$6eca-$6f1a` — `AIDecide_PokemonTrader_Deck17` (Psychic Elite; Abra/Kadabra/Alakazam + Mr. Mime trader).
- `$765e-$76ac` — `AIDecide_NightlyGarbageRun_Deck17` (Psychic Elite; recover Alakazam line + 3 energies/Mr. Mime from discard).
- Grand Fire (deck $3a, Courtney) cases: `$493d-$494e` `AIDecide_Switch_Phase16_Deck3AOr3B` (shared with $3b Legendary Fossil), `$559c-$55c8` `AIDecide_ProfessorOak_Deck3A`, `$6201-$620e` `AIDecide_ScoopUp_Deck3A` (+ new `AIDecide_ScoopUp.scoop_if_energy_ready` label at $61ce), `$691e-$6964` `AIDecide_Pokeball_Deck3A`, `$76ad-$76d5` `AIDecide_NightlyGarbageRun_Deck3A`.
- `$632c-$6372` — `AIPlay_Lass` + `AIDecide_Lass` (whole trainer-card pair carved from the $6228-$6373 ScoopUp gap; AITrainerCardLogic LASS row now resolves). Needed exporting `Zeroes::` in src/home.asm.
- Legendary Fossil (deck $3b, Steve) cases: `$55c9-$55ce` `AIDecide_ProfessorOak_Deck3B`, `$6d5e-$6dbd` `AIDecide_ComputerSearch_Deck3B`, `$76d6-$76fe` `AIDecide_NightlyGarbageRun_Deck3B`. (Switch case $493d already shared via Deck3AOr3B.)
- `$79f5-$7a42` — `AIPlay_FossilExcavation` + `AIDecide_FossilExcavation` dispatcher + inline `AIDecide_FossilExcavation_Deck3BOr63` (whole trainer card carved from the gap after `AddDeckIndexToAIMultiTargetSlots`; AITrainerCardLogic FOSSIL_EXCAVATION row now resolves; decks $3b/$63).
- `$5ce2-$5d2c` — `AIPlay_ImposterProfessorOak` + `AIDecide_ImposterProfessorOak` (deck `$59`/`$67`/`$68` cases inline as local labels).
- `$5d2d-$5e0d` — `AIPlay_EnergySearch` + `AIDecide_EnergySearch` (deck `$09`/`$0b` inline; `$0d`/`$66` as separate sub-functions; unreferenced `AIDecide_EnergySearch_GrassOnly` preserved) + `LookForEnergyUsefulToPlayArea` helper.
- `$5f63-$602a` — `AIPlay_FullHeal` + `AIDecide_FullHeal` (previously raw `call $60ed` is now `call AIDecide_ScoopUp`).
- `$602b-$603d` — `AIDecide_FullHeal_Deck53` (deck $53 Bad Dream; gates on opponent Asleep, jumps back to `AIDecide_FullHeal.no_play`/`.play`).
- `$55e8-$560f` — `AIDecide_ProfessorOak_Deck53`.
- `$6c5c-$6ca1` — `AIDecide_Pokeball_Deck53`.
- `$7a73-$7a8f` — `AIDecide_Sleep_Deck53` (jumps back to `AIDecide_Sleep.no_play`).
- `$5a8c-$5a9c` — `RemoveCardFromListAtHL` (shared list-compaction helper).
- `$73d8-$7491` — `AIDecide_PokemonTrader_Deck51` (deck $51 Direct Hit; solo priority-fetch + evolution-chain walk) + `_Deck5A/_5B/_5C/_65/_6C/_6D/_6F/_70/_71/_72/_73/_74` (12 thin per-deck delegates; $6d = raw Func_487ff).
- `$7586-$75b1` — `AIDecide_TheBosssWay_Deck51` (same chains as the deck $51 Trader).
- `$75b2-$75cc` — `AIDecide_TheBosssWay_Deck58` (Sudden Growth; Dratini/Clefairy evo lines) + `AIDecide_TheBosssWay_Deck5A` (Bad Guys; bank-$12 delegate).
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
- `$6858-$68b6` — `AIPlay_ClefairyDollOrMysteriousFossil` + `AIDecide_ClefairyDollOrMysteriousFossil` (inline `.deck_1a`, `.deck_3b`); shared by the Clefairy Doll and Mysterious Fossil PHASE_05 table rows.
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
- `$7dc7-$7e9d` — `AIDecide_MasterBall_Deck46` + `AIDecide_MasterBall_Deck74` + `AIPlay_BillsTeleporter`/`AIDecide_BillsTeleporter` + `AIPlay_MoonStone`/`AIDecide_MoonStone` (6-way deck dispatch) + `AIPlay_TheRocketsTrap`/`AIDecide_TheRocketsTrap`.
- `$7e9e-$7ec2` — `AIPlay_GoopGasAttack` + `AIDecide_GoopGasAttack`.
- `$7f3e-$7fe5` — `AIPlay_ComputerError` + `AIDecide_ComputerError` + `AIPlay_SuperScoopUp` + `AIDecide_SuperScoopUp`.
- `$7b0a-$7bde` — `AIPlay_MasterBall` + `AIDecide_MasterBall` (inline deck $13, deck $14).
- `$7bdf-$7d43` — `AIDecide_MasterBall_Deck18`/`_Deck1A`/`_Deck29`/`_Deck3D`/`_Deck3E` (evo-line + priority-list Master Ball targeting); only deck $40 ($7d61) still raw.
- `$4c32-$4c43` — `AIPlay_Bill` + `AIDecide_Bill`.
- `$53bc-$5504` — `AIPlay_ProfessorOak` + `AIDecide_ProfessorOak` (19 deck-specific Func_2152x-Func_2163e cases left raw; one named).
- `$55cf-$55d4` — `AIDecide_ProfessorOak_Deck45Or50`.
- `$55d5-$55e7` — `AIDecide_ProfessorOak_Deck49Or4D`.
- `$5505-$5527` — `LookForEvolutionInHand`.
- `$5643-$566d` — `AIPlay_EnergyRetrieval`.
- `$566e-$57c7` — `AIDecide_EnergyRetrieval` (22-deck-ID dispatcher + full `.default` path: `CountBasicEnergyCardsInHand` gate → duplicate-Pokemon target via `FindDuplicateCards_IgnoreTrainerCardToPlay` (9 decks override with the pre-tagged non-Pokemon AI target or jump to `$591a`/`$592c`) → `CreateBasicEnergyCardListInLocation` over the discard pile → per-play-area-Pokemon `CheckIfEnergyIsUseful` loop filling up to 2 multi-target slots via the `$5a8c` list-add helper).
- `$5a9d-$5ade` — `AIPlay_SuperEnergyRetrieval`.
- `$6373-$6395` — `AIPlay_ItemFinder`.
- `$664d-$2693` — `AIPlay_ImakuniCard` + `AIDecide_ImakuniCard` (inline `deck_50_dark_primeape`).
- `$6694-$271a` — `AIPlay_Gambler` + `AIDecide_Gambler`.
- `$7a43-$7a72` — `AIPlay_Sleep` + `AIDecide_Sleep` + `AIDecide_Sleep_Deck12` (deck-$53 case `$7a73` left raw).

### Still raw, in priority order (highest = most leverage)
Addresses listed are bank-$08 CPU addresses; nearest table card in
parens.

1. `$57c8-$5a83` (ENERGY_RETRIEVAL deck-specific handlers) — 22 per-deck handlers reachable from the `AIDecide_EnergyRetrieval` dispatcher at `$57c8, $57d2, $581d, $589d, $58cf, $5937, $5969, $599b, $59cd, $5a0b, $5a10, $5a19, $5a22, $5a2b, $5a34, $5a53, $5a5c, $5a70, $5a75, $5a7e, $5a83`. `$591a`/`$592c` are also the override targets of the now-landed `.default` deck dispatch. None traced yet — each needs a duel against the owning deck. (The shared helper at `$5a8c` is now landed as `RemoveCardFromListAtHL`.)
2. `$5adf` (SUPER_ENERGY_RETRIEVAL decide) — likely similar shape to `AIDecide_EnergyRetrieval`.
2b. `$50b6-$53ba` (POKEMON_BREEDER decide) — 774-byte `AIDecide_PokemonBreeder` dispatcher (`IsPrehistoricPowerActive` gate, 7 deck cases `$3d/$41/$4e/$53/$55/$6f/$70`, big default Stage-2 evolution scoring path scanning VENUSAUR/BLASTOISE/VILEPLUME etc.). Deck-$55 case `$52fb` now landed standalone; the dispatcher + scoring + other 6 deck cases remain raw.
2c. ITEMFINDER decide other deck cases (`$6421/$6475/$64c2/$65ad/$662b/$6630`) and COMPUTER_SEARCH decide other deck cases (`$6d59/$6d5e/$6dbe/$6e0f/$6e14/$6e19/$6e1e/$6e23`) — small per-deck sub-functions, untraced.
3. Deck-specific helpers referenced as raw hex inside the decompiled deciders. Sōsuke is deck `$12` (SLEEP) and `$54` or similar in PROFESSOR_OAK (which falls through to default scoring); other special-case decks haven't been traced:
   - `$4365` (POTION Phase 10, deck `$45` Quick Attack)
   - `$4902, $493d, $494f, $49a7-$49de` (SWITCH Phase 16, 14 deck-specific cases)
   - `$4bc5d` in bank `$12` (POTION Phase 11, deck `$74` delegate)
   - `$5528-$563e` (PROFESSOR_OAK, remaining deck-specific cases `$11, $2d, $32, $3a, $3b, $57, $58, $5a, $5c, $5d, $6e, $70, $71, $72` — `$53`, `$55` now landed)
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
| duel-kamiya | 48 (deck $50; rest in deferred SUPER_ER — ITEMFINDER decide now landed) |
| duel-kevin | **0** ✓ (2-duel trace; both decks fell through ER dispatcher to `.default` → `ret nc`) |
| duel-ryoko | **0** ✓ (no trainer cards played all duel; no AIPlay_* entry fired) |
| duel-yosuke | **0** ✓ (deck $53 Bad Dream; landed deck-$53 cases for SLEEP, FULL_HEAL, PROFESSOR_OAK, POKEBALL) |
| duel-mami | 4 (deck $55 Spirited Away; played 7 trainer cards incl. SUPER_ENERGY_REMOVAL, ITEMFINDER, COMPUTER_SEARCH — all landed; remaining 4 hits are the deferred POKEMON_BREEDER dispatcher cp-chain) |
| duel-miwa | **0** ✓ (deck $51 Direct Hit; landed `RemoveCardFromListAtHL` + POKEMON_TRADER/THE_BOSSS_WAY deck-$51) |
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
