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
| `Func_1059f` | `04:459f` | `BackupOverworldStateToWRAM3` | copies live OW state block (wOWMap..d89c) to WRAM3 scratch; brackets SaveGame/OW transitions | 2026-06-06 |
| `Func_105de` | `04:45de` | `RestoreOverworldStateFromWRAM3` | inverse of the above | 2026-06-06 |
| `Func_10ea7` | `04:4ea7` | `PushOWObjectsAndExtraByteToBank3` | saves wOWObjects (+1 byte to w3d563) to WRAM bank 3 | 2026-06-06 |
| `Func_10ed3` | `04:4ed3` | `PullOWObjectsAndExtraByteFromBank3` | restores them from WRAM bank 3 | 2026-06-06 |
| `Func_10d40` | `04:4d40` | `InitOverworldObjectState` | InitOWObjects + sets wd8a1=1, wd986=$ff (OW-entry reset) | 2026-06-06 |
| `Func_10f32` | `04:4f32` | `SaveOWObjectStates` | snapshots active OW objects (5 B/obj) into wd98b for the save; inverse Func_10f78 | 2026-06-06 |
| `Func_12c0b7` | `4b:40b7` | `LoadOWMapTilemap` | LoadTilemap (Tiles0) + stores tilemap width/height (wd7dc/dd); caller LoadOWMap | 2026-06-06 |
| `Func_12c1c1` | `4b:41c1` | `DecompressPermissionMap` | **tcg1 name**; decompresses permission data into wd6d4 (wPermissionMap) | 2026-06-06 |
| `Func_10b9c` | `04:4b9c` | `ReloadSpriteAnimTilesets` | re-loads cached wSpriteTilesets into VRAM after DisableLCD/screen rebuild | 2026-06-06 |
| `Func_1dfb9` | `07:5fb9` | `ClearDuelAnimationState` | ClearSpriteAnims + zeroes wDuelAnimBuffer/vars; shared by Reset/FinishQueuedAnimations | 2026-06-06 |
| `Func_189d` | `00:16cf` | `CheckAndDisplayDefenderTransparency` | after damage: if defender affected, run HandleTransparency + show its text | 2026-06-06 |
| `Func_10f78` | `04:4f78` | `LoadOWObjectStates` | load-time inverse of SaveOWObjectStates (respawns OW objects from wd98b) | 2026-06-06 |
| `Func_1132e` | `04:532e` | `SetOWObjectSpriteAnimMovement` | sets an OW object's sprite-anim direction + motion (speed/duration) | 2026-06-06 |
| `Func_12c0fc` | `4b:40fc` | `LoadOWMapTilemapNoDimensions` | LoadOWMapTilemap variant that skips storing width/height | 2026-06-06 |
| `Func_12c35c` | `4b:435c` | `LoadFirstSpriteAnimFrame` | first-update guard; primes frame 0, falls into AdvanceToNextSpriteAnimFrame | 2026-06-06 |
| `Func_1e60c` | `07:660c` | `PlayDuelistIntroScene` | pre-duel duelist intro cutscene (portrait + intro text + theme) | 2026-06-06 |
| `Func_1e73a` | `07:673a` | `LoadNPCDuelConfiguration` | reloads opponent duel config from wNPCDuelDeckID (tcg1 _GetNPCDuelConfigurations) | 2026-06-06 |
| `Func_2c4b` | `00:2c4b` | `PrintTextNoDelay_ZeroAttributes` | print no-delay text at de, then clear its CGB attribute bytes; ~30 callers | 2026-06-06 |
| `Func_2d356` | `0b:5356` | `RockClubEntrance_MusicPreload` | OWMODE_MUSIC_PRELOAD handler (GR theme if boss unmet) | 2026-06-06 |
| `Func_2d366` | `0b:5366` | `RockClubEntrance_MusicPostload` | OWMODE_MUSIC_POSTLOAD (Ronald music) | 2026-06-06 |
| `Func_2d376` | `0b:5376` | `RockClubEntrance_StepEvent` | OWMODE_STEP_EVENT -> RockClubEntrance_StepEvents | 2026-06-06 |
| `Func_2d37d` | `0b:537d` | `RockClubEntrance_WarpFadeInPreload` | OWMODE_WARP_FADE_IN_PRELOAD (queues Ronald cutscene script) | 2026-06-06 |
| `Func_2d653` | `0b:5653` | `RockClub_MusicPreload` | OWMODE_MUSIC_PRELOAD handler (RockClub map) | 2026-06-06 |
| `Func_2d663` | `0b:5663` | `RockClub_StepEvent` | OWMODE_STEP_EVENT -> RockClub_StepEvents | 2026-06-06 |
| `Func_2d66a` | `0b:566a` | `RockClub_LoadNPCs` | OWMODE_NPC_POSITION -> loads RockClub_NPCs (tcg1 RockClubNPCS) | 2026-06-06 |

## Progress
- 2026-06-06: ~622 named. ~587 remaining. Batch (20) via 8 parallel subagents:
  duel-effect (ApplyStrikesBackOrPoisonFluid [tcg1], SubtractHPAndPrintReceivedDamage,
  ApplyMirrorShellDamageModifiers, LoadAttackerCardNameLevelToTxRam2), OW fade/anim
  (StartOverworldFadeIn/Out, UpdateOverworldPaletteCycle, ApplyCreditsFadeConfig,
  ExecutePlayerInteractScript, LoadAndQueueOWMapTilemap, WriteTileAndAttrToBGMap0AtCoord),
  Mason/GRChallengeMachineAfterDuel, DrawColorChangeScreen [tcg1], DisplayDeckDiagnosisAdvice,
  SelectDeckToCheck, WalkPlayerAlongTCGIslandPath, ReceiveCardIntoCollection, GiveDeckToPlayer,
  HandleImakuniAfterDuel.
- 2026-06-06: ~602 named. ~607 remaining. **Big seam:** `tools/name_mapscripts.py` named 554
  overworld map-script handlers across 116 `<Map>_MapScripts` OWMODE tables as
  `<Map>_<OWMODEAction>` (tcg1's `<Map><Slot>` convention generalized). Deterministic generator,
  not subagents; only Func_2c4db needed a manual touch (a duplicate in-table entry, = LightningClub_MusicPreload).
  This is tcg2's version of tcg1's fixed-8-slot MapScripts table (tcg2 uses a variable-length
  `dbw OWMODE_*, handler` list with finer modes).
- 2026-06-06: 48 named. 1,161 remaining. Batch (14) via 8 parallel subagents. Key discovery:
  the per-map OWMODE_* script-pointer table system (ExecuteOWModeScript walks <Map>_MapScripts,
  a `dbw OWMODE_*, handler` list) — so map-script Func_* are nameable as <Map>_<OWMODEAction>.
  Two whole map tables done (RockClubEntrance, RockClub). Deferred Func_235e (low-conf text LRU).
- 2026-06-06: 108 named. 285 remaining. npc_script seam COMPLETE (0 npc_script Func_* left).
  8 subagents swept the fort trainer maps (the GR団 fort bosses Midori/Renna/Catherine/Yuki/
  Kanoko/Kamiya/Mami/Kanzaki/Biruritchi... matching the AI skill's per-deck duel names),
  the 6 FightingFort maze treasure chests (Script_<Map>ChestClosed/Opened, named by the
  NPC_CHEST_* state not the action — both subagents' chest sets normalized to this), remaining
  club/fort lobby generics (Script_<Place><Role>), challenge-hall lobbies, the Mason computer-room
  lab techs, and all fort/club entrance GR clerks. Shared 5-map Imakuni Red -> Script_ImakuniRed
  (central). Collisions auto-disambiguated with map suffixes (Script_RuiGrCastle vs villa Rui,
  Script_RodPsychicStronghold vs Dome Rod, Script_StephaniePsychicClubEntrance vs club Stephanie).
- 2026-06-06: 57 named. 393 remaining. npc_script seam batch 2 (8 subagents): the 6 club LOBBIES
  + PsychicStronghold + ColorlessAltar + MasonLab TrainingRoom + RockClub members. Recurring
  trainers whose club-MAIN handler already took the bare name get a map suffix here
  (Script_ScienceClubLobbyDavid, Script_MichaelFightingClubLobby, Script_JoshuaWaterClubLobby...);
  generic lobby NPCs use the descriptive Script_<Club><Role> style (Script_GrassClubGranny,
  Script_LightningClubBro). Named the SHARED 5-lobby Imakuni handler CENTRALLY: Func_3c30c ->
  Script_ImakuniBlack (interaction counterpart of existing Script_ImakuniBlackAfterDuel).
  Func_3ce6a is one handler shared by two npc entries (longhaired/GR lass) -> one name.
  AARON_STEP_1..4 after-duel steps -> Script_AaronStepNAfterDuel. ~120 npc_script handlers remain.
- 2026-06-06: 79 named. 450 remaining. NEW SEAM: the `npc_script NPC_*, handler` tables
  (<Map>_NPCInteractions / _AfterDuelScripts) reference 256 unnamed handlers, map-local, keyed
  by NPC constant. Unlike MapScripts these need READING (existing convention is hand-curated
  Script_<Role>, not a mechanical transform), so 8 subagents each took one club/lab map and named
  its full handler set: the 7 elemental Club masters + members (Amy/Murray/Mitch/Nikki/Rick/Ken/
  Isaac and their members) and MasonLaboratoryMain (DrMason/Sam/Ronald/4 LabTech guides).
  Convention: Script_<Npc> / Script_<Npc>AfterDuel; map-PREFIX the shared generic NPCs
  (NPC_GR_1..4 grunts recur across clubs -> Script_<Map>GR<n>; likewise Jennifer/Brittany/Sam/
  Ronald that recur). ~177 npc_script handlers still remain (lobbies, forts, strongholds, etc.).
- 2026-06-06: 23 named. 529 remaining. Batch analyzed in PARALLEL by 8 subagents. Hot generic
  NPC-interact dispatcher TurnNPCToFacePlayerAndRunScript (83 callers; the turn-to-face variant of
  ExecuteFacingNPCScript). OWModePostprocess slots (HandleOWModeIdleInput, UpdateOWModePlayerMovement),
  the far-data bankswitch helpers behind LoadTilemap/LoadOWMap/UpdateSpriteAnim/UpdateAllOWObjectMovement
  (GetTilemapDimensions, CopyOWMapTileset, DrawOWSpriteAnimFrame [tcg1 DrawSpriteAnimationFrame],
  ReadOWMovementStep), sprite-anim frame-func enable/disable pair, warp/event setters
  (SetWarpToTCGIslandLocation, QueueMasonLabChallengeMachineTilemap, SetFightingFortClearedVar),
  two Ronald after-duel scenes, InitNewGameSaveState, plus two DUEL-engine funcs:
  ProcessFinalBeamWhenKnockedOut (Dark Gyarados dying-trigger) + GetChangedTypeAttackingCardColor.
  Func_3332 RETIRED from candidate list (pure DoFrame alias, intentionally left unnamed).
- 2026-06-06: 24 named. 552 remaining. Batch analyzed in PARALLEL by 8 subagents. Completed
  the OW sub-screen suspend/resume brackets bottom-up: ResumeOverworldFromSubScreen /
  ResumeOverworldKeepingSpriteAnims (exit pairs of last batch's Suspend*), plus the overworld
  feature launchers that use them (StartNPCDuelFromOverworld, RunLinkDuelFromOverworld,
  RunDeckSaveMachineFromOverworld, RunCardPopFromOverworld). Also GB-Printer card strip triad
  (PrintCardInfoHeaderStrip/PictureStrip/FooterStripAndFeed — tcg1 leaves these raw too),
  minicom-mailbox UI (DrawMailboxTitleAndScene, DrawMailboxScrollArrows, AdjustMailboxCursorAfterDelete),
  map idle/NPC scripts (PsychicClubEntrance_MoveStephanieOutOfPath, TcgAirportEntrance_MoveGR5OutOfPath,
  RockClub_GR1AppearanceCheck, Script_Gene/Script_GeneAfterDuel), InitSavedBGMapStack,
  GetPlayerFacingTilePosition. Deferred Func_10ea3 (low-conf alt-mode movement wrapper) + Func_3332.
- 2026-06-06: 21 named. 576 remaining. Batch analyzed in PARALLEL by 8 subagents over the
  callgraph candidate set (still-Func_, named caller AND callee, exclude AI banks). OW screen
  save/restore pair (SuspendOverworldForSubScreen / ...KeepingSpriteAnims), OW object movement
  (TryMoveOWObjectInDirection, UpdateAllOWObjectMovement), map/tile reload (InitOverworldGraphics,
  ReloadOWMapAndTiles), interact/script (ExecuteFacingNPCScript, LoadCurMapScriptPointers),
  GR-island UI (PlaceGRIslandMapCursor, HideOWMapLocationBox, CheckMetRonaldAtLeastTwice),
  plus mail/event helpers. Deferred Func_3332 (trivial DoFrame wrapper, no semantic name).
- 2026-06-06: 34 named. 1,175 remaining. Batch (11) analyzed in PARALLEL by 7 subagents
  (each read body + checked tcg1, returned a structured name proposal; I verified + applied).
  Mostly OW save/restore + map/tilemap + sprite-anim engine; resolved the deferred Func_189d
  (CheckAndDisplayDefenderTransparency) and found a tcg1 match (DecompressPermissionMap).
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
