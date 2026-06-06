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
  `--bank NN` lists a bank's Func_* by reference count.

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

## Progress
- 2026-06-06: 7 named (1 tcg1-match + 6 overworld/animation frame-function cluster). 1,202 remaining.
  Pilot confirmed the xref workflow: callers + named callees + the frame-func convention
  resolve a cluster cleanly and byte-neutrally. The higher-level transition orchestrators
  (Func_1022a/10252/102a4/102c4) need their leaf callees named first (bottom-up).
