# Func_* labeling — ledger & methodology

Tracks the effort to give all `Func_*` placeholder labels descriptive names.
Renames are **byte-neutral** (`make compare` must stay OK after every batch).

## Scope (measured 2026-06-06)
- **1,209** `Func_*` labels (1,194 global, 16 local).
- Concentration: ~987 (82%) in the overworld/event/map engine — banks `0b`,`0c`,`0d`,`0f`,`10`.
- Out of scope: the duel-AI banks (`08`/`0e`/`11`/`13`) — tracked by the `poketcg2-ai` skill.
- Func naming = linear file offset: `Func_<5hex>` is ROMX (bank = val>>14), `Func_<4hex>` is home (bank 0).

## Tooling (Phase 0 — done)
- `tools/match_tcg1.py` — fingerprints function bodies (opcode stream, 16-bit address
  operands masked) and proposes byte-identical tcg1 names.
- `tools/callgraph.py` — caller/callee graph; `Func_X` detail shows callers + named callees;
  `--bank NN` lists a bank's Func_* by reference count. `--dyn <dump>` merges a dynamic
  graph and flags dynamic-only edges (the indirect dispatch static can't see).
- **Dynamic call graph** (resolves indirect dispatch / jump tables, the ~974 tail):
  the patched `tools/sameboy_trace/sameboy_trace` accumulates a *deduplicated* set of
  `(caller -> callee)` edges (taken CALL/RST/`jp hl`), bounded by distinct edges, not a
  per-call log. Built from `/Users/andrew/coding/sameboy` (SDL/main.c patch; `make sdl`).
  Usage:
    1. `SAMEBOY_CALLGRAPH=cg.txt tools/sameboy_trace/sameboy_trace poketcg2.gbc`
    2. play through the subsystems you want covered (more play = more edges)
    3. quit normally, or `kill -TERM <pid>` (SIGINT is left for the debugger) -> dumps cg.txt
    4. `python3 tools/callgraph.py Func_X --dyn cg.txt` -> static + dynamic callers/callees,
       with `<-*` / `->*` marking dynamic-only (indirectly-dispatched) edges.

## Reality check — what each lever actually yields
1. **tcg1 byte-port: ~10 functions.** tcg1 is 95% labeled, BUT the engine code that's
   byte-identical to tcg1 is *already named* in tcg2; the unnamed `Func_*` are mostly
   tcg2-specific (sequel) or diverged. Even exact matches need the name **adapted** to
   tcg2's own symbols (e.g. Func_8f10 matched `InitPromotionalCardAndDeckCounterSaveData`
   but actually inits `sBoosterPacksObtained` → named for tcg2's data).
2. **Static xref: ~225 functions** are call/jp/farcall-referenced and self-describe via
   their named callees (e.g. a fn calling `FindNPCAtLocation`/`ExecuteNPCScript` is an
   overworld NPC handler). This is the primary lever. Use `callgraph.py Func_X`.
3. **The other ~974** are never call/table-referenced — reached by fallthrough, indirect
   dispatch, or dead. Many are fallthrough continuations that may warrant local-label
   demotion rather than a fresh name. Need per-function disassembly + `sameboy_trace` for
   genuine content handlers.

## Workflow per function
1. `callgraph.py Func_X` for callers + named callees; `match_tcg1.py` for a tcg1 hint.
2. Read the body; cross-check tcg1's analogous subsystem for naming conventions.
3. Name from what it *actually* does in tcg2 (adapt, don't blindly port).
4. Rename whole-word (byte-neutral) + one-line evidence comment; `make compare` → OK.
5. Log below.

## Ledger
| Func_ | @bank:addr | new name | evidence | date |
|---|---|---|---|---|
| `Func_8f10` | `02:4f10` | `InitBoosterPacksAndDeckCounterSaveData` | tcg1 exact match (InitPromotionalCardAndDeckCounterSaveData), adapted to tcg2 SRAM | 2026-06-06 |
| `Func_3a39` | `00:3a39` | `FrameFunc_Overworld` | per-frame OW update (UpdateOWScroll + sprite anims + FadePalettes); set by SetOverworldFrameFunc | 2026-06-06 |
| `Func_1109f` | `04:509f` | `SetOverworldFrameFunc` | pushes FrameFunc_Overworld; callers OverworldLoop/CreditsCmd_InitOW | 2026-06-06 |
| `Func_110a8` | `04:50a8` | `UnsetOverworldFrameFunc` | pops it; callers CreditsCmd_DeinitOW etc. | 2026-06-06 |
| `Func_3a81` | `00:3a81` | `FrameFunc_AnimationQueue` | per-frame update during queued screen anims (gated on wActiveScreenAnim) | 2026-06-06 |
| `Func_110b9` | `04:50b9` | `SetAnimationQueueFrameFunc` | pushes FrameFunc_AnimationQueue; caller ResetAnimationQueue | 2026-06-06 |
| `Func_110c2` | `04:50c2` | `UnsetAnimationQueueFrameFunc` | pops it; caller FinishQueuedAnimations | 2026-06-06 |
| `Func_6fa5` | `01:6fa5` | `TakePrizesForKnockedOutPokemon` | body: CountKnockedOutPokemon + TurnDuelistTakePrizes + "Took all the Prizes"; caller HandleBetweenTurnKnockOuts | 2026-06-06 |
| `Func_6986` | `01:6986` | `TriggerPlayedEnergyCardEffect` | runs played card's PKMN_POWER_TRIGGER effect; callers PlayEnergyCard / OppAction_PlayEnergyCard | 2026-06-06 |
| `Func_1bb4` | `00:1bb4` | `RedrawDuelSceneAndPrintFailedEffect` | DrawDuelMainScene/HUDs + PrintFailedEffectText; caller HandleConfusionDamageToSelf | 2026-06-06 |
| `Func_12c36a` | `4b:436a` | `AdvanceToNextSpriteAnimFrame` | inc frame index + GetFramesetData; caller DecrementSpriteAnimFrameDuration | 2026-06-06 |
| `Func_fc094` | `7e:40ec` | `ExecuteNextSFXCommand` | tcg1 exact match; SFX command dispatcher | 2026-06-06 |
| `Func_fc094_2` | `7f:40ec` | `ExecuteNextSFX2Command` | bank-$7f SFX2 copy of the above | 2026-06-06 |
| `Func_1c735` | `07:5735` | `FadeBGPalsToTarget` | FadeColorToTarget over wTargetBGPalettes (parallels FadeBGPalsToWhiteOrBlack) | 2026-06-06 |
| `Func_1c767` | `07:5767` | `FadeOBPalsToTarget` | FadeColorToTarget over wTargetOBPalettes | 2026-06-06 |
| `Func_1c799` | `07:5799` | `UpdatePaletteFadeToWhiteOrBlack` | calls FadeBG/OBPalsToWhiteOrBlack per wPaletteFadeFlags | 2026-06-06 |
| `Func_1c7b6` | `07:57b6` | `UpdatePaletteFadeToTarget` | calls FadeBG/OBPalsToTarget per wPaletteFadeFlags | 2026-06-06 |
| `Func_1e088` | `07:6088` | `UpdateScreenAnimations` | runs active screen-anim update fn or processes the anim queue | 2026-06-06 |
| `Func_6c12` | `01:6c12` | `LoadDuelScreenBGPalettes` | loads Pals_6f0d8 into BG pals 2-4; 12 duel-screen callers (resolves a gfx-work TODO) | 2026-06-06 |
| `Func_6c15` | `01:6c15` | `LoadDuelBGPalettesFromHL` | shared core: copy 3 palettes hl -> BG pals 2-4 | 2026-06-06 |
| `Func_6c1d` | `01:6c1d` | `LoadCardPictureBGPalettes` | loads Pals_6f0f0; used with a drawn/placed card pic | 2026-06-06 |
| `Func_17fb` | `00:17fb` | `HandleAfterDamageEffects` | tcg1 name (home/duel); AFTER_DAMAGE effect + status + knockouts cascade | 2026-06-06 |
| `Func_83b3` | `02:43b3` | `DrawCurrentPlayAreaPrizeCards` | player/opp prize-card draw; caller TurnDuelistTakePrizes (tcg1 Func_82b6) | 2026-06-06 |

## Progress
- 2026-06-06: 23 named. 1,186 remaining. Batch (2): HandleAfterDamageEffects (tcg1-confirmed
  core duel routine) + DrawCurrentPlayAreaPrizeCards. Deferred Func_189d / Func_2c4b (tcg2-
  specific effect-feedback / ambiguous text helper) pending more study.
- 2026-06-06: 21 named. 1,188 remaining. Batch (8): bank07 palette-fade quad + screen-anim
  runner + the bank01 BG-palette loader trio (the Func_6c12/Func_6c1d flagged during the gfx work).
- 2026-06-06: 13 named. 1,196 remaining. Latest batch (6) used the dynamic call graph
  (cg.txt from a duel session) + tcg1 as a semantic reference for the duel-engine funcs.
- 2026-06-06: 7 named (1 tcg1-match + 6 overworld/animation frame-function cluster). 1,202 remaining.
  Pilot confirmed the xref workflow: callers + named callees + the frame-func convention
  resolve a cluster cleanly and byte-neutrally. The higher-level transition orchestrators
  (Func_1022a/10252/102a4/102c4) need their leaf callees named first (bottom-up).
