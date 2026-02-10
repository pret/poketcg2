; handles intro, title screen and start menu
; as well as the core gameplay loop
_CoreGameLoop::
	call Func_c240
.intro
	farcall IntroAndTitleScreen
	ld a, PLAYER_TURN
	ldh [hWhoseTurn], a
	call InitEvents
	xor a
	call PlaySong
	xor a
	call PlaySFX
.start_menu_loop
	call HandleStartMenu
	ld hl, .StartMenuFunctionTable
	call JumpToFunctionInTable
	jr c, .intro
	jr .start_menu_loop

.StartMenuFunctionTable
	dw StartMenu_CardPop           ; STARTMENU_CARD_POP
	dw StartMenu_ContinueFromDiary ; STARTMENU_CONTINUE_FROM_DIARY
	dw StartMenu_NewGame           ; STARTMENU_NEW_GAME
	dw StartMenu_ContinueDuel      ; STARTMENU_CONTINUE_DUEL

StartMenu_NewGame:
	ld hl, wd554
	bit 0, [hl]
	jr z, .no_save_data
	farcall AskToOverwriteSaveData
	ret c
.no_save_data
	farcall InitSaveData
	call ClearSaveData
	call Func_c24d
	call ClearChallengeMachineRecords
	xor a ; FALSE
	farcall ReadOrInitSaveData
	ld a, GAME_EVENT_NEWGAME_PROLOGUE
	ld [wNextGameEvent], a
	xor a
	ld [wNextWarpMap], a
	call ExecuteGameEvent
	scf
	ret

StartMenu_ContinueFromDiary:
	ld hl, wd554
	bit 2, [hl]
	jr z, .no_saved_duel
	bit 1, [hl]
	jr z, .no_saved_duel
	farcall AskToContinueFromDiaryInsteadOfDuel
	ret c
.no_saved_duel
	call RestoreBackupSave
	xor a
	call PlaySong
	ld a, [wNextGameEvent]
	cp GAME_EVENT_NEWGAME_PROLOGUE
	jr z, .prologue
	cp GAME_EVENT_DUEL
	jr z, .duel
	ld a, [wPlayerOWObject]
	ld b, TRUE
	farcall SetOWObjectAnimStruct1Flag2
	call Func_33b7
	call Func_c29d
	call InitSaveDataState
	ld a, TRUE
	farcall ReadOrInitSaveData
	ld hl, wOverworldTransition
	set 7, [hl]
	ld a, GAME_EVENT_OVERWORLD_UPDATE
	ld [wNextGameEvent], a
	call ExecuteGameEvent
	scf
	ret

.prologue
	ld a, TRUE
	farcall ReadOrInitSaveData
	call ExecuteGameEvent
	scf
	ret

.duel
	ld a, [wPlayerOWObject]
	ld b, TRUE
	farcall SetOWObjectAnimStruct1Flag2
	call Func_33b7
	call Func_c29d
	call InitSaveDataState
	ld a, TRUE
	farcall ReadOrInitSaveData
	call DisableLCD
	farcall Func_10b9c
	farcall Func_1055e
	farcall UpdateOWScroll
	farcall SaveTargetFadePals
	farcall Func_1109f
	call DoFrame
	ld a, OWMODE_CONTINUE_DUEL
	call ExecuteOWModeScript
	ld a, VAR_NPC_DECK_ID
	call GetVarValue
	ld [wNPCDuelDeckID], a
	ld a, VAR_DUEL_START_THEME
	call GetVarValue
	ld [wDuelStartTheme], a
	call ExecuteGameEvent
	scf
	ret

StartMenu_ContinueDuel:
	ld a, TRUE
	farcall ReadOrInitSaveData
	xor a
	call PlaySong
	call LoadMainSave
	ld a, [wPlayerOWObject]
	ld b, TRUE
	farcall SetOWObjectAnimStruct1Flag2
	call Func_33b7
	call EnablePlayTimeCounter
	ld a, EVENT_F0
	call MaxOutEventValue
	ld a, OWMODE_CONTINUE_DUEL
	call ExecuteOWModeScript
	ld a, GAME_EVENT_DUEL
	ld [wNextGameEvent], a
	call ExecuteGameEvent
	scf
	ret

StartMenu_CardPop:
	farcall CardPopMenu
	scf
	ccf
	ret

; a = OWMODE_* constant
; jump to .PointerTable[a]
OWModePostprocess::
	sla a
	ld hl, .PointerTable
	add_hl_a
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp hl

.PointerTable
	dw Func_31a1                               ; OWMODE_IDLE
	dw .Exit                                   ; OWMODE_MUSIC_PRELOAD
	dw OverworldFadeInToBlack                  ; OWMODE_WARP_FADE_IN_PRELOAD
	dw Overworld10FramesWarpInterval           ; OWMODE_WARP_INTERVAL
	dw OverworldFadeOutToBlack                 ; OWMODE_WARP_FADE_OUT_PRELOAD
	dw Func_31a8                               ; OWMODE_MOVE
	dw OverworldResumeAndHandlePlayerMoveInput ; OWMODE_STEP_EVENT
	dw .Exit                                   ; OWMODE_NPC_POSITION
	dw OverworldResumeFromInteract             ; OWMODE_INTERACT
	dw OverworldResumeAfterDuel                ; OWMODE_AFTER_DUEL
	dw ExecuteWRAMOverworldScript              ; OWMODE_SCRIPT
	dw OverworldResumeWithCurSong              ; OWMODE_CONTINUE_OW
	dw .Exit                                   ; OWMODE_SAVE_PRELOAD
	dw .Exit                                   ; OWMODE_SAVE_POSTLOAD
	dw .Exit                                   ; OWMODE_CONTINUE_DUEL
	dw PlaySFXWarp                             ; OWMODE_WARP_END_SFX
	dw PlayNextMusic                           ; OWMODE_MUSIC_POSTLOAD
	dw OverworldWaitPalFading                  ; OWMODE_AFTER_DUEL_PRELOAD
	dw PauseMenu                               ; OWMODE_PAUSE_MENU

.Exit:
	ret

OverworldResumeFromInteract:
	ld a, OWMODE_IDLE
	ld [wOverworldMode], a
	ret

Overworld10FramesWarpInterval:
	ld a, 10
	call WaitAFrames
	ret

PlaySFXWarp:
	ld a, SFX_WARP
	call PlaySFX
	ret

PlayNextMusic:
	ld a, [wNextMusic]
	farcall PlayAfterCurrentSong
	ret

; fade in to black + some processing
OverworldFadeInToBlack:
	ld a, $01
	call Func_338f
	ret

; fade out to black + some processing
OverworldFadeOutToBlack:
	ld a, $01
	call Func_33a3
	ret

OverworldResumeAfterDuel:
	ld a, OWMODE_IDLE
	ld [wOverworldMode], a
	ret

; may as well be called directly
OverworldResumeWithCurSong:
	farcall PlayCurrentSong
	ld a, OWMODE_IDLE
	ld [wOverworldMode], a
	ret

; may as well be called directly
OverworldResumeAndHandlePlayerMoveInput:
	ld a, OWMODE_IDLE
	ld [wOverworldMode], a
	call HandleOverworldPlayerMoveInput
	ret

OverworldWaitPalFading:
	call WaitPalFading
	ret

PauseMenu:
	call PauseSong_SaveState
	ld a, MUSIC_PAUSE_MENU
	call PlaySong
	farcall HandlePauseMenu
	call GetActiveMusicState
	jr nz, .replay_current_song
	call ResumeSong_ClearTemp
	jr .done
.replay_current_song
	farcall PlayCurrentSong
	call ResetActiveMusicState
.done
	ld a, OWMODE_IDLE
	ld [wOverworldMode], a
	ret

HandleStartMenu:
	xor a
	ld [wd554], a
	call CheckIfHasBackupSave
	jr c, .menu_config0
	call ValidateBackupGeneralSaveData
	jr c, .asm_c20f
.asm_c1d7
	ld hl, wd554
	set 0, [hl]
	call LoadBackupSave
	farcall CheckSavedDuelChecksum
	jr c, .no_saved_duel
	ld hl, wd554
	set 2, [hl]
	; on second meeting, Ronald card pops with you
	; and unlocks it in the start menu
	ld a, VAR_TIMES_MET_RONALD
	call GetVarValue
	cp $02
	jr c, .menu_config4
	call CheckIfHasMainSave
	jr c, .menu_config2
	call ValidateGeneralSaveData
	jr c, .menu_config2
	ld hl, wd554
	set 1, [hl]
	jr .menu_config3
.no_saved_duel
	ld a, VAR_TIMES_MET_RONALD
	call GetVarValue
	cp $02
	jr c, .menu_config1
	jr .menu_config2

.asm_c20f
	debug_nop
	call ValidateGeneralSaveData
	jr c, .menu_config0
	call BackupMainSave
	jr .asm_c1d7

.menu_config0
	xor a ; STARTMENU_CONFIG_0
	farcall ShowStartMenu
	ld a, STARTMENU_NEW_GAME
	ret
.menu_config1
	ld a, STARTMENU_CONFIG_1
	farcall ShowStartMenu
	inc a
	ret
.menu_config2
	ld a, STARTMENU_CONFIG_2
	farcall ShowStartMenu
	ret
.menu_config3
	ld a, STARTMENU_CONFIG_3
	farcall ShowStartMenu
	ret
.menu_config4
	ld a, STARTMENU_CONFIG_4
	farcall ShowStartMenu
	inc a
	ret

; called before intro starts
Func_c240:
	xor a
	ld [wCurMusic], a
	farcall Func_13dfa
	ret

InitEvents:
	call ClearEvents
	ret

Func_c24d:
	call ClearEvents
	; reset play time
	xor a
	ld [wPlayTimeCounter + 0], a
	ld [wPlayTimeCounter + 1], a
	ld [wPlayTimeCounter + 2], a
	ld [wPlayTimeCounter + 3], a
	ld [wPlayTimeCounter + 4], a
	call ClearSavedDecks
	xor a
	ld [wNextGameEvent], a
	ld [wNextWarpMap], a
	ld [wd54e + 0], a
	ld [wd54e + 1], a
	ld [wCurMapScriptsBank], a
	ld [wCurMapScriptsPointer + 0], a
	ld [wCurMapScriptsPointer + 1], a
	ld [wCurIsland], a
	ld [wCurMap], a
	ld [wCurOWLocation], a
	ld [wCurMusic], a
	ld [wSentMailBitfield + 0], a
	ld [wSentMailBitfield + 1], a
	ld [wSentMailBitfield + 2], a
	ld [wSentMailBitfield + 3], a
	call ValidateChallengeMachineSaveData
	jr nc, .asm_c299
	call InitChallengeMachine
.asm_c299
	call Func_c2a7
	ret

Func_c29d:
	call Func_c2a7
	ret

EnablePlayTimeCounter:
	ld a, TRUE
	ld [wPlayTimeCounterEnable], a
	ret

Func_c2a7:
	ld a, TRUE
	ld [wPlayTimeCounterEnable], a
	call Func_c2d6
	call Func_c366
	call Func_c3d4
	call Func_c2ff
	call HandleGrandMasterCupState
	call Func_c439
	call Func_c477
	ret

; clears sSavedDecks
ClearSavedDecks:
	ld hl, sSavedDecks
	ld bc, NUM_DECK_SAVE_MACHINE_SLOTS * DECK_COMPRESSED_STRUCT_SIZE
	call EnableSRAM
.loop_clear
	xor a
	ld [hli], a
	dec bc
	ld a, c
	or b
	jr nz, .loop_clear
	call DisableSRAM
	ret

Func_c2d6:
	ld a, EVENT_GOT_GR_COIN_PIECE_TOP_RIGHT
	call GetEventValue
	jr nz, .done
	ld a, [wCurOWLocation]
	cp OWMAP_GRASS_CLUB
	jr z, .done
	cp OWMAP_SCIENCE_CLUB
	jr z, .done
	call UpdateRNGSources
	rrca
	jr c, .asm_c2f7
	ld a, VAR_0F
	ld c, OWMAP_GRASS_CLUB
	call SetVarValue
	jr .done
.asm_c2f7
	ld a, VAR_0F
	ld c, OWMAP_SCIENCE_CLUB
	call SetVarValue
.done
	ret

Func_c2ff:
	ld a, VAR_ISHIHARA_STATE
	call GetVarValue
	cp ISHIHARA_TALKED_AT_VILLA
	jr c, .done
	ld a, EVENT_ISHIHARA_LOCATION_STATE
	call ZeroOutEventValue
	call UpdateRNGSources
	rra
	jr nc, .done
	ld a, EVENT_ISHIHARA_LOCATION_STATE
	call MaxOutEventValue
.done
	ret

HandleGrandMasterCupState:
	ld a, VAR_GRAND_MASTER_CUP_STATE
	call GetVarValue
	cp GRAND_MASTER_CUP_PLAYING
	jr c, .not_playing
	jr z, .done
; played, clear result
	ld a, VAR_GRAND_MASTER_CUP_STATE
	ld c, GRAND_MASTER_CUP_INACTIVE
	call SetVarValue
	jr .done

.not_playing
	ld a, [wCurMap]
	cp MAP_POKEMON_DOME_ENTRANCE
	jr z, .done
	cp MAP_POKEMON_DOME
	jr z, .done
	cp MAP_POKEMON_DOME_BACK
	jr z, .done
; outside pokemon dome
	ld a, VAR_GRAND_MASTER_CUP_STATE
	call GetVarValue
	cp GRAND_MASTER_CUP_ACTIVE
	jr z, .done
	jr nc, .reset
; check cup activation condition
	ld a, VAR_TIMES_WON_LINK_DUEL_FOR_GRAND_MASTER_CUP
	call GetVarValue
	cp MAX_NUM_LINK_DUEL_WINS_FOR_GRAND_MASTER_CUP
	jr c, .done
	ld a, VAR_GRAND_MASTER_CUP_STATE
	ld c, GRAND_MASTER_CUP_ACTIVE
	call SetVarValue
.done
	ret

.reset
	ld a, VAR_GRAND_MASTER_CUP_STATE
	ld c, GRAND_MASTER_CUP_INACTIVE
	call SetVarValue
	ld a, VAR_TIMES_WON_LINK_DUEL_FOR_GRAND_MASTER_CUP
	call ZeroOutVarValue
	jr .done

Func_c366:
	ld a, VAR_21
	call GetVarValue
	cp $02
	jr c, .done
	ld a, [wCurIsland]
	cp TCG_ISLAND
	jr nz, .randomly_choose_club
	ld a, VAR_25
	call GetVarValue
	ld c, a
	ld a, [wCurOWLocation]
	cp c
	jr z, .done

.randomly_choose_club
	ld a, 5
	call Random
	or a
	jr z, .rock_club
	dec a
	jr z, .psychic_club
	dec a
	jr z, .science_club
	dec a
	jr z, .fire_club
	jr .water_club
.rock_club
	ld a, VAR_25
	ld c, OWMAP_ROCK_CLUB
	call SetVarValue
	jr .club_chosen
.psychic_club
	ld a, VAR_25
	ld c, OWMAP_PSYCHIC_CLUB
	call SetVarValue
	jr .club_chosen
.science_club
	ld a, VAR_25
	ld c, OWMAP_SCIENCE_CLUB
	call SetVarValue
	jr .club_chosen
.fire_club
	ld a, VAR_25
	ld c, OWMAP_FIRE_CLUB
	call SetVarValue
	jr .club_chosen
.water_club
	ld a, VAR_25
	ld c, OWMAP_WATER_CLUB
	call SetVarValue

.club_chosen
	ld a, [wCurIsland]
	cp TCG_ISLAND
	jr nz, .done
	ld a, VAR_25
	call GetVarValue
	ld c, a
	ld a, [wCurOWLocation]
	cp c
	jr z, .randomly_choose_club
.done
	ret

Func_c3d4:
	ld a, [wCurIsland]
	cp GR_ISLAND
	jr nz, .randomly_choose_club
	ld a, VAR_26
	call GetVarValue
	ld c, a
	ld a, [wCurOWLocation]
	cp c
	jr z, .done

.randomly_choose_club
	ld a, 5
	call Random
	or a
	jr z, .grass_fort
	dec a
	jr z, .fire_fort
	dec a
	jr z, .water_fort
	dec a
	jr z, .psychic_stronghold
	jr .game_center
.grass_fort
	ld a, VAR_26
	ld c, OWMAP_GR_GRASS_FORT
	call SetVarValue
	jr .club_chosen
.fire_fort
	ld a, VAR_26
	ld c, OWMAP_GR_FIRE_FORT
	call SetVarValue
	jr .club_chosen
.water_fort
	ld a, VAR_26
	ld c, OWMAP_GR_WATER_FORT
	call SetVarValue
	jr .club_chosen
.psychic_stronghold
	ld a, VAR_26
	ld c, OWMAP_GR_PSYCHIC_STRONGHOLD
	call SetVarValue
	jr .club_chosen
.game_center
	ld a, VAR_26
	ld c, OWMAP_GAME_CENTER
	call SetVarValue

.club_chosen
	ld a, [wCurIsland]
	cp GR_ISLAND
	jr nz, .done
	ld a, VAR_26
	call GetVarValue
	ld c, a
	ld a, [wCurOWLocation]
	cp c
	jr z, .randomly_choose_club
.done
	ret

Func_c439:
	ld a, VAR_TCG_CHALLENGE_CUP_STATE
	call GetVarValue
	cp CHALLENGE_CUP_3_UNLOCKED
	jr c, .skip
	ld a, [wCurIsland]
	cp TCG_ISLAND
	jr nz, .determine
	ld a, [wCurOWLocation]
	cp OWMAP_TCG_CHALLENGE_HALL
	jr z, .skip
.determine
	ld a, VAR_TCG_CHALLENGE_CUP_STATE
	ld c, CHALLENGE_CUP_3_UNLOCKED
	call SetVarValue
	ld a, 4
	call Random
	or a
	jr nz, .skip
	; 1/4 chance
	ld a, VAR_TCG_CHALLENGE_CUP_STATE
	ld c, CHALLENGE_CUP_3_START
	call SetVarValue
	ld a, VAR_TCG_CHALLENGE_CUP_RESULT
	call ZeroOutVarValue
	ld a, NUM_TCG_CHALLENGE_CUP_PRIZE_POOL
	call Random
	ld c, a
	ld a, VAR_TCG_CHALLENGE_CUP_PRIZE_INDEX
	call SetVarValue
.skip
	ret

Func_c477:
	ld a, VAR_GR_CHALLENGE_CUP_STATE
	call GetVarValue
	cp CHALLENGE_CUP_3_UNLOCKED
	jr c, .skip
	ld a, [wCurIsland]
	cp GR_ISLAND
	jr nz, .determine
	ld a, [wCurOWLocation]
	cp OWMAP_GR_CHALLENGE_HALL
	jr z, .skip
.determine
	ld a, VAR_GR_CHALLENGE_CUP_STATE
	ld c, CHALLENGE_CUP_3_UNLOCKED
	call SetVarValue
	ld a, 5
	call Random
	or a
	jr nz, .skip
	; 1/5 chance
	ld a, VAR_GR_CHALLENGE_CUP_STATE
	ld c, CHALLENGE_CUP_3_START
	call SetVarValue
	ld a, VAR_GR_CHALLENGE_CUP_RESULT
	call ZeroOutVarValue
	ld a, NUM_GR_CHALLENGE_CUP_PRIZE_POOL
	call Random
	ld c, a
	ld a, VAR_GR_CHALLENGE_CUP_PRIZE_INDEX
	call SetVarValue
.skip
	ret

; load the NPC duelist header corresponding to register a into wCurrentNPCDuelistData
LoadNPCDuelist:
	push af
	push bc
	push de
	push hl
	ld c, a
	ld de, NPCDuelistPointers
.loop
	ld a, [de]
	ld l, a
	inc de
	ld a, [de]
	inc de
	ld h, a
	or l
	jr z, .not_found
	ld a, [hl]
	cp c
	jr nz, .loop
	ld de, wCurrentNPCDuelistData
	ld bc, NPC_DUELIST_STRUCT_SIZE
	call CopyDataHLtoDE_SaveRegisters
	pop hl
	pop de
	pop bc
	pop af
	ret
.not_found
	debug_nop
	pop hl
	pop de
	pop bc
	pop af
	ret

; for a = deck id,
; return a = NPC_* constant corresponding to that deck
GetNPCByDeck:
	push bc
	push de
	push hl
	ld b, a
	ld de, NPCDuelistPointers
.loop_duelists
	ld a, [de]
	ld l, a
	inc de
	ld a, [de]
	inc de
	ld h, a
	or l
	jr z, .not_found
	ld c, MAX_NPC_DUELIST_DECKS
	push hl
	ld a, NPC_DUELIST_STRUCT_DECKS
	add_hl_a
.loop_decks
	ld a, [hli]
	cp b
	jr z, .get_npc_id
	dec c
	jr nz, .loop_decks
	pop hl
	jr .loop_duelists
.not_found
	debug_nop
	jr .done
.get_npc_id
	pop hl
	ld a, [hl]
.done
	pop hl
	pop de
	pop bc
	ret

; return - a : number of coin pieces obtained
CountGRCoinPiecesObtained:
	push bc
	ld b, EVENT_GOT_GR_COIN_PIECE_TOP_LEFT
	ld c, 0 ; counter for how many pieces obtained
.loop
	ld a, b
	call GetEventValue
	jr z, .not_obtained
	inc c ; obtained this piece
.not_obtained
	ld a, b
	cp EVENT_GOT_GR_COIN_PIECE_BOTTOM_RIGHT
	jr z, .done
	inc b
	jr .loop
.done
	ld a, c
	pop bc
	ret

; for c = island and a = location,
; return the location name in hl
GetLocationName:
	push af
	push bc
	ld b, a
	ld a, c
	ld hl, TCGIslandLocationNamePointers
	cp TCG_ISLAND
	jr z, .got_island
	ld hl, GRIslandLocationNamePointers
.got_island
	ld a, b
	sla a
	add_hl_a
	ld a, [hli]
	ld h, [hl]
	ld l, a
	pop bc
	pop af
	ret

; load the current island and location into c and a, then get the name
GetCurrentLocationName:
	push af
	push bc
	ld a, [wCurIsland]
	ld c, a
	ld a, [wCurOWLocation]
	call GetLocationName
	pop bc
	pop af
	ret

; for de = receiving card id, return its long name in hl
; the first half of this function and the next two are identical
GetReceivingCardLongName:
	push af
	push bc
	push de
	ld hl, ReceiveCardTextPointers
.loop_cards
	ld a, [hli]
	ld c, a
	ld a, [hli]
	ld b, a
	cp16bc_long $ffff
	jr z, .not_found
	cp16bc_long de
	jr z, .load_name
	ld a, CARD_RECEIVE_STRUCT_TEXTS_SIZE
	add_hl_a
	jr .loop_cards
.not_found
	call LoadCardDataToBuffer1_FromCardID
	ld a, 18
	call CopyCardNameAndLevel
	ld [hl], 0
	ld bc, 0
	jr .got_name
.load_name
	ld a, [hli]
	ld c, a
	ld a, [hli]
	ld b, a
	or c
	jr z, .not_found
	; fallthrough
.got_name
	ld l, c
	ld h, b
	pop de
	pop bc
	pop af
	ret

; for de = receiving card id, return its short name in hl
GetReceivingCardShortName:
	push af
	push bc
	push de
	ld hl, ReceiveCardTextPointers
.loop_cards
	ld a, [hli]
	ld c, a
	ld a, [hli]
	ld b, a
	cp16bc_long $ffff
	jr z, .not_found
	cp16bc_long de
	jr z, .load_short_name
	ld a, CARD_RECEIVE_STRUCT_TEXTS_SIZE
	add_hl_a
	jr .loop_cards
.not_found
	call LoadCardDataToBuffer1_FromCardID
	ld a, 18
	call CopyCardNameAndLevel
	ld [hl], 0
	ld bc, 0
	jr .got_short_name
.load_short_name
	inc hl
	inc hl
	ld a, [hli]
	ld c, a
	ld a, [hli]
	ld b, a
	or c
	jr z, .not_found
	; fallthrough
.got_short_name
	ld l, c
	ld h, b
	pop de
	pop bc
	pop af
	ret

; for de = receiving card id, return its "received" text in hl
GetReceivedCardText:
	push af
	push bc
	push de
	ld hl, ReceiveCardTextPointers
.loop_cards
	ld a, [hli]
	ld c, a
	ld a, [hli]
	ld b, a
	cp16bc_long $ffff
	jr z, .not_found
	cp16bc_long de
	jr z, .load_received_text
	ld a, CARD_RECEIVE_STRUCT_TEXTS_SIZE
	add_hl_a
	jr .loop_cards
.not_found
	push hl
	call GetReceivingCardShortName
	call LoadTxRam2
	pop hl
	call LoadCardDataToBuffer1_FromCardID
	ldtx bc, ReceivedPromotionalCardText_2
	ld a, [wLoadedCard1Set]
	cp PROMOTIONAL
	jr z, .got_text
	ldtx bc, ReceivedCardText_2
	jr .got_text
.load_received_text
REPT CARD_RECEIVE_STRUCT_RECEIVED_TEXT - CARD_RECEIVE_STRUCT_TEXTS
	inc hl
ENDR
	push hl
	call GetReceivingCardShortName
	call LoadTxRam2
	pop hl
	ld a, [hli]
	ld c, a
	ld a, [hli]
	ld b, a
	; check alt flag, load alt text if TRUE
	ld a, [hli]
	or a
	jr z, .got_text
	call GetEventValue
	jr z, .got_text
	ld a, [hli]
	ld b, [hl]
	ld c, a
	; fallthrough
.got_text
	ld l, c
	ld h, b
	pop de
	pop bc
	pop af
	ret

; de = card id
Func_c63e:
	call GetReceivedCardText
	farcall Func_1d53a
	ret

; de = card id
Func_c646:
	call AddCardToCollection
	call GetReceivedCardText
	farcall Func_1d53a
	ret

; bank and offset table of data for LoadMapHeader and Func_33b7
; table corresponds to MAP_* IDs (do not confuse with MAP_GFX_*)
MapHeaderPtrs::
	dba OverworldTcg_MapHeader
	dba OverworldGr_MapHeader
	dba MasonLaboratoryMain_MapHeader
	dba MasonLaboratoryComputerRoom_MapHeader
	dba MasonLaboratoryTrainingRoom_MapHeader
	dba IshiharasHouse_MapHeader
	dba LightningClubEntrance_MapHeader
	dba LightningClubLobby_MapHeader
	dba LightningClub_MapHeader
	dba PsychicClubEntrance_MapHeader
	dba PsychicClubLobby_MapHeader
	dba PsychicClub_MapHeader
	dba RockClubEntrance_MapHeader
	dba RockClubLobby_MapHeader
	dba RockClub_MapHeader
	dba FightingClubEntrance_MapHeader
	dba FightingClubLobby_MapHeader
	dba FightingClub_MapHeader
	dba GrassClubEntrance_MapHeader
	dba GrassClubLobby_MapHeader
	dba GrassClub_MapHeader
	dba ScienceClubEntrance_MapHeader
	dba ScienceClubLobby_MapHeader
	dba ScienceClub_MapHeader
	dba WaterClubEntrance_MapHeader
	dba WaterClubLobby_MapHeader
	dba WaterClub_MapHeader
	dba FireClubEntrance_MapHeader
	dba FireClubLobby_MapHeader
	dba FireClub_MapHeader
	dba TcgAirportEntrance_MapHeader
	dba TcgAirport_MapHeader
	dba TcgChallengeHallEntrance_MapHeader
	dba TcgChallengeHallLobby_MapHeader
	dba TcgChallengeHall_MapHeader
	dba PokemonDomeEntrance_MapHeader
	dba PokemonDome_MapHeader
	dba PokemonDomeBack_MapHeader
	dba OverheadIslands_MapHeader
	dba GrAirportEntrance_MapHeader
	dba GrAirport_MapHeader
	dba IshiharasVillaMain_MapHeader
	dba IshiharasVillaLibrary_MapHeader
	dba GameCenterEntrance_MapHeader
	dba GameCenterLobby_MapHeader
	dba GameCenter1_MapHeader
	dba GameCenter2_MapHeader
	dba CardDungeonPawn_MapHeader
	dba CardDungeonKnight_MapHeader
	dba CardDungeonBishop_MapHeader
	dba CardDungeonRook_MapHeader
	dba CardDungeonQueen_MapHeader
	dba SealedFortEntrance_MapHeader
	dba SealedFort_MapHeader
	dba GrChallengeHallEntrance_MapHeader
	dba GrChallengeHallLobby_MapHeader
	dba GrChallengeHall_MapHeader
	dba GrassFortEntrance_MapHeader
	dba GrassFortLobby_MapHeader
	dba GrassFortMidori_MapHeader
	dba GrassFortYuta_MapHeader
	dba GrassFortMiyuki_MapHeader
	dba GrassFortMorino_MapHeader
	dba LightningFortEntrance_MapHeader
	dba LightningFortLobby_MapHeader
	dba LightningFortRenna_MapHeader
	dba LightningFortIchikawa_MapHeader
	dba LightningFortCatherine_MapHeader
	dba FireFortEntrance_MapHeader
	dba FireFortLobby_MapHeader
	dba FireFortJes_MapHeader
	dba FireFortYuki_MapHeader
	dba FireFortShoko_MapHeader
	dba FireFortHidero_MapHeader
	dba WaterFortEntrance_MapHeader
	dba WaterFortLobby_MapHeader
	dba WaterFortMiyajima_MapHeader
	dba WaterFortSenta_MapHeader
	dba WaterFortAira_MapHeader
	dba WaterFortKanoko_MapHeader
	dba FightingFortEntrance_MapHeader
	dba FightingFort_MapHeader
	dba FightingFortMaze1_MapHeader
	dba FightingFortMaze2_MapHeader
	dba FightingFortMaze3_MapHeader
	dba FightingFortMaze4_MapHeader
	dba FightingFortMaze5_MapHeader
	dba FightingFortMaze6_MapHeader
	dba FightingFortMaze7_MapHeader
	dba FightingFortMaze8_MapHeader
	dba FightingFortMaze9_MapHeader
	dba FightingFortMaze10_MapHeader
	dba FightingFortMaze11_MapHeader
	dba FightingFortMaze12_MapHeader
	dba FightingFortMaze13_MapHeader
	dba FightingFortMaze14_MapHeader
	dba FightingFortMaze15_MapHeader
	dba FightingFortMaze16_MapHeader
	dba FightingFortMaze17_MapHeader
	dba FightingFortMaze18_MapHeader
	dba FightingFortMaze19_MapHeader
	dba FightingFortMaze20_MapHeader
	dba FightingFortMaze21_MapHeader
	dba FightingFortMaze22_MapHeader
	dba FightingFortBasement_MapHeader
	dba FightingFortGoda_MapHeader
	dba FightingFortGrace_MapHeader
	dba PsychicStrongholdEntrance_MapHeader
	dba PsychicStrongholdLobby_MapHeader
	dba PsychicStronghold_MapHeader
	dba PsychicStrongholdMami_MapHeader
	dba ColorlessAltarEntrance_MapHeader
	dba ColorlessAltar_MapHeader
	dba GrCastleEntrance_MapHeader
	dba GrCastle_MapHeader
	dba GrCastleBiruritchi_MapHeader

INCLUDE "data/npc_duelists.asm"
INCLUDE "data/booster_lists.asm"
INCLUDE "data/card_receive_texts.asm"

TCGIslandLocationNamePointers:
	tx MapMasonLabText         ; OWMAP_MASON_LABORATORY
	tx MapIshiharasHouseText   ; OWMAP_ISHIHARAS_HOUSE
	tx MapLightningClubText    ; OWMAP_LIGHTNING_CLUB
	tx MapPsychicClubText      ; OWMAP_PSYCHIC_CLUB
	tx MapRockClubText         ; OWMAP_ROCK_CLUB
	tx MapFightingClubText     ; OWMAP_FIGHTING_CLUB
	tx MapGrassClubText        ; OWMAP_GRASS_CLUB
	tx MapScienceClubText      ; OWMAP_SCIENCE_CLUB
	tx MapWaterClubText        ; OWMAP_WATER_CLUB
	tx MapFireClubText         ; OWMAP_FIRE_CLUB
	tx MapTCGAirportText       ; OWMAP_TCG_AIRPORT
	tx MapTCGChallengeHallText ; OWMAP_TCG_CHALLENGE_HALL
	tx MapPokemonDomeText      ; OWMAP_POKEMON_DOME
	dw NULL
	tx MapOpeningText

GRIslandLocationNamePointers:
	tx MapGRAirportText           ; OWMAP_GR_AIRPORT
	tx MapIshiharasVillaText      ; OWMAP_ISHIHARAS_VILLA
	tx MapGameCenterText          ; OWMAP_GAME_CENTER
	tx MapSealedFortText          ; OWMAP_SEALED_FORT
	tx MapGRChallengeHallText     ; OWMAP_GR_CHALLENGE_HALL
	tx MapGRGrassFortText         ; OWMAP_GR_GRASS_FORT
	tx MapGRLightningFortText     ; OWMAP_GR_LIGHTNING_FORT
	tx MapGRFireFortText          ; OWMAP_GR_FIRE_FORT
	tx MapGRWaterFortText         ; OWMAP_GR_WATER_FORT
	tx MapGRFightingFortText      ; OWMAP_GR_FIGHTING_FORT
	tx MapGRPsychicStrongholdText ; OWMAP_GR_PSYCHIC_STRONGHOLD
	tx MapGRColorlessAltarText    ; OWMAP_COLORLESS_ALTAR
	tx MapGRCastleText            ; OWMAP_GR_CASTLE

INCLUDE "data/challenge_cup_prizes.asm"

INCLUDE "data/challenge_machine_opponents.asm"

; main ow handler for GAME_EVENT_OVERWORLD_UPDATE
; e.g. map loading, player movement/interactions, game event transitions
OverworldLoop::
	push af
	ldh a, [hKeysHeld]
	bit B_PAD_A, a
	jr z, .skip_nop
	bit B_PAD_B, a
	jr z, .skip_nop
	nop
	nop
	nop
	nop
.skip_nop
	pop af
	ld hl, wOverworldTransition
	bit 6, [hl]
	jr nz, .warp
	bit 7, [hl]
	jp nz, .fade
	ld a, EVENT_02
	call GetEventValue
	jp nz, .end_duel
	ld a, PLAYER_TURN
	ldh [hWhoseTurn], a
.warp
	ld hl, wNextMapScriptsBank
	ld a, [hl]
	ld [wCurMapScriptsBank], a
	ld hl, wNextMapScriptsPointer
	ld a, [hli]
	ld [wCurMapScriptsPointer + 0], a
	ld a, [hl]
	ld [wCurMapScriptsPointer + 1], a
	ld a, OWMODE_MUSIC_PRELOAD
	call ExecuteOWModeScript
	farcall Func_102ef
	xor a
	farcall Func_10d40
	ld a, $01
	farcall SetOWScrollState
	ld b, $00
	ld a, [wNextMapGfx]
	ld c, a
	farcall LoadOWMap
	ld a, [wNextWarpPlayerXCoord]
	ld d, a
	ld a, [wNextWarpPlayerYCoord]
	ld e, a
	ld a, [wNextWarpPlayerDirection]
	ld b, a
	ld a, [wPlayerOWObject]
	farcall LoadOWObjectInMap
	farcall StopOWObjectAnimation
	farcall SetOWObjectAsScrollTarget
	farcall SetOWObjectFlag5_WithID
	ld b, TRUE
	farcall SetOWObjectAnimStruct1Flag2
	ld a, OWMODE_IDLE
	ld [wOverworldMode], a
	xor a
	ld [wOverworldTransition], a
	ld a, OWMODE_NPC_POSITION
	call ExecuteOWModeScript
	ld a, OWMODE_MUSIC_POSTLOAD
	call ExecuteOWModeScript
	ld a, OWMODE_WARP_FADE_IN_PRELOAD
	call ExecuteOWModeScript
	ld a, OWMODE_WARP_INTERVAL
	call ExecuteOWModeScript

.wait_input
	ld a, [wVBlankCounter]
	and $3f
	call z, UpdateRNGSources
	ld a, [wOverworldMode]
	call ExecuteOWModeScript
	ld a, [wOverworldTransition]
	bit 1, a
	jr nz, .start_duel
	bit 0, a
	jr z, .wait_input
	ld a, OWMODE_WARP_FADE_OUT_PRELOAD
	call ExecuteOWModeScript
	ld a, OWMODE_WARP_END_SFX
	call ExecuteOWModeScript
	ret

.start_duel
	ld a, [wNPCDuelDeckID]
	ld c, a
	ld a, VAR_NPC_DECK_ID
	call SetVarValue
	ld a, [wDuelStartTheme]
	ld c, a
	ld a, VAR_DUEL_START_THEME
	call SetVarValue
	ld a, EVENT_02
	call MaxOutEventValue
	ld a, GAME_EVENT_DUEL
	ld [wNextGameEvent], a
	call SaveGame_NoBackup
	ret

.end_duel
	ld a, OWMODE_AFTER_DUEL_PRELOAD
	call ExecuteOWModeScript
	ld a, EVENT_02
	call ZeroOutEventValue
	call InitSaveDataState
	ld a, EVENT_F0
	call ZeroOutEventValue
	farcall PlayCurrentSong
	ld a, OWMODE_AFTER_DUEL
	ld [wOverworldMode], a
	xor a
	ld [wOverworldTransition], a
	jr .wait_input

.fade
	farcall Func_10b9c
	farcall Func_1055e
	farcall UpdateOWScroll
	farcall SaveTargetFadePals
	farcall Func_1109f
	call DoFrame
	ld a, FALSE
	ld b, $00
	farcall StartPalFadeFromBlackOrWhite
	ld a, OWMODE_CONTINUE_OW
	ld [wOverworldMode], a
	ld hl, wOverworldTransition
	res 7, [hl]
	jp .wait_input

; a = map id
; b = direction
; de = coordinates
SetWarpData:
	ld [wNextWarpMap], a
	ld a, GAME_EVENT_OVERWORLD_UPDATE
	ld [wNextGameEvent], a
	ld a, d
	ld [wNextWarpPlayerXCoord], a
	ld a, e
	ld [wNextWarpPlayerYCoord], a
	ld a, b
	ld [wNextWarpPlayerDirection], a
	ld a, OWMODE_IDLE
	ld [wOverworldMode], a
	ld hl, wOverworldTransition
	set 0, [hl]
	ld a, [wNextWarpMap]
	ld [wTempPrevMap], a
	ret

Func_d3e9::
	ld a, [wPlayerOWObject]
	push af
	farcall GetOWObjectTilePosition
	pop af
	push de
	farcall GetOWObjectAnimStruct1Flag0And1
	pop de
	ld a, b
	rlca
	ld hl, .offsets
	add_hl_a
	ld a, [hli]
	add d
	ld d, a
	ld a, [hl]
	add e
	ld e, a
	ret

.offsets
	db  0, -1 ; NORTH
	db  1,  0 ; EAST
	db  0,  1 ; SOUTH
	db -1,  0 ; WEST

PCMenu:
	call PauseSong
	ld a, MUSIC_PC_MAIN_MENU
	call PlaySong
	farcall _PCMenu
	call ResumeSong
	ret

; a = map id
; load *_MapHeader at MapHeaderPtrs[a] into wNextMapHeaderData
LoadMapHeader::
	push af
	ld c, a
	ld b, 0
	sla c
	add c ; *3
	ld c, a
	rl b
	ld hl, MapHeaderPtrs
	add hl, bc
	ld a, [hli]
	ld c, a     ; *_MapHeader bank
	ld a, [hli] ; *_MapHeader ptr
	ld h, [hl]  ;
	ld l, a
	ld a, c
	ld de, wNextMapHeaderData
	ld bc, MAPHEADERSTRUCT_LENGTH
	call CopyFarHLToDE
	ld a, [wCurMap]
	ld [wPrevMap], a
	pop af
	ld [wCurMap], a
	ld a, MAP_NONE
	ld [wTempPrevMap], a
	ret

; a = NPC_* ID
; de = target position
SetOWObjectTargetPosition:
	ld [wd595], a
	push af
	ld a, d
	ld [wOWObjTargetX], a
	ld a, e
	ld [wOWObjTargetY], a
	xor a
	ld [wd59c], a
	ld [wd59d], a
	pop af
	push de
	farcall GetOWObjectPosition
	pop bc
	ld a, b
	sub d ; target_x - x
	bit 7, a
	jr z, .got_x_distance
	cpl
	inc a
.got_x_distance
	ld b, a ; x distance
	ld a, c
	sub e ; target_y - y
	bit 7, a
	jr z, .got_y_distance
	cpl
	inc a
.got_y_distance
	ld c, a ; y distance
	ld a, b
	cp c
	jr c, .asm_d4d3

; x distance >= y distance
	push bc
	xor a
	ld [wd598], a
	ld a, 1
	ld [wOWObjXVelocity], a
	ld b, EAST
	ld a, [wOWObjTargetX]
	cp d
	jr nc, .got_x_dir
	ld a, -1
	ld [wOWObjXVelocity], a
	ld b, WEST
.got_x_dir
	ld a, [wd595]
	farcall _SetOWObjectDirection
	ld a, 1
	ld [wOWObjYVelocity], a
	ld a, [wOWObjTargetY]
	cp e
	jr nc, .got_y_vel
	ld a, -1
	ld [wOWObjYVelocity], a
.got_y_vel
	pop bc
	ld d, c ; y distance
	ld e, $00
	ld c, b ; x distance
	ld b, $00
	call DivideDEByBC
	; de = ((y distance) / (x distance)) * $100
	ld a, [wOWObjYVelocity]
	bit 7, a
	jr z, .positive_y_vel
	ld a, e
	cpl
	add 1
	ld e, a
	ld a, d
	cpl
	adc 0
	ld d, a
	; de = -de
.positive_y_vel
	ld a, e
	ld [wd59a], a
	ld a, d
	ld [wOWObjYVelocity], a
	jr .done

.asm_d4d3
; x distance < y distance
	push bc
	xor a
	ld [wd59a], a
	ld a, 1
	ld [wOWObjYVelocity], a
	ld b, SOUTH
	ld a, [wOWObjTargetY]
	cp e
	jr nc, .got_y_dir
	ld a, -1
	ld [wOWObjYVelocity], a
	ld b, NORTH
.got_y_dir
	ld a, [wd595]
	farcall _SetOWObjectDirection
	ld a, 1
	ld [wOWObjXVelocity], a
	ld a, [wOWObjTargetX]
	cp d
	jr nc, .got_x_vel
	ld a, -1
	ld [wOWObjXVelocity], a
.got_x_vel
	pop bc
	ld d, b
	ld e, $00
	ld b, $00
	call DivideDEByBC
	; de = ((x distance) / (y distance)) * $100
	ld a, [wOWObjXVelocity]
	bit 7, a
	jr z, .positive_x_vel
	ld a, e
	cpl
	add 1
	ld e, a
	ld a, d
	cpl
	adc 0
	ld d, a
	; de = -de
.positive_x_vel
	ld a, e
	ld [wd598], a
	ld a, d
	ld [wOWObjXVelocity], a
.done
	ret

; returns carry if still moving
MoveOWObjectToTargetPosition:
	ld a, [wd595]
	farcall GetOWObjectPosition
	ld a, [wOWObjTargetX]
	cp d
	jr nz, .change_x
	ld a, [wOWObjTargetY]
	cp e
	jr nz, .change_y
	scf
	ccf
	ret

.change_x
	ld a, [wd59c]
	ld b, a
	ld a, [wd598]
	add b
	ld [wd59c], a
	ld a, [wOWObjXVelocity]
	adc d
	ld d, a
.change_y
	ld a, [wOWObjTargetY]
	cp e
	jr z, .asm_d562
	ld a, [wd59d]
	ld b, a
	ld a, [wd59a]
	add b
	ld [wd59d], a
	ld a, [wOWObjYVelocity]
	adc e
	ld e, a
.asm_d562
	ld a, [wd595]
	farcall SetOWObjectPosition
	scf
	ret

; de = coordinates
Func_d56b:
	ld a, d
	ld [wOWObjTargetX], a
	ld a, e
	ld [wOWObjTargetY], a
	xor a
	ld [wd59c], a
	ld [wd59d], a
	ld a, [wOWScrollX]
	ld b, a
	ld a, [wOWScrollY]
	ld c, a
	ld a, d
	sub b
	bit 7, a
	jr z, .asm_d58a
	cpl
	inc a
.asm_d58a
	ld b, a
	ld a, e
	sub c
	bit 7, a
	jr z, .asm_d593
	cpl
	inc a
.asm_d593
	ld c, a
	ld a, b
	cp c
	jr c, .asm_d5e2

	push bc
	xor a
	ld [wd598], a
	ld a, 1
	ld [wOWObjXVelocity], a
	ld a, [wOWScrollX]
	cp d
	jr c, .asm_d5ad
	ld a, -1
	ld [wOWObjXVelocity], a
.asm_d5ad
	ld a, 1
	ld [wOWObjYVelocity], a
	ld a, [wOWScrollY]
	cp e
	jr c, .asm_d5bd
	ld a, -1
	ld [wOWObjYVelocity], a
.asm_d5bd
	pop bc
	ld d, c
	ld e, $00
	ld c, b
	ld b, $00
	call DivideDEByBC
	ld a, [wOWObjYVelocity]
	bit 7, a
	jr z, .asm_d5d8
	ld a, e
	cpl
	add 1
	ld e, a
	ld a, d
	cpl
	adc 0
	ld d, a
.asm_d5d8
	ld a, e
	ld [wd59a], a
	ld a, d
	ld [wOWObjYVelocity], a
	jr .done

.asm_d5e2
	push bc
	xor a
	ld [wd59a], a
	ld a, 1
	ld [wOWObjYVelocity], a
	ld a, [wOWScrollY]
	cp e
	jr c, .asm_d5f7
	ld a, -1
	ld [wOWObjYVelocity], a
.asm_d5f7
	ld a, 1
	ld [wOWObjXVelocity], a
	ld a, [wOWScrollX]
	cp d
	jr c, .asm_d607
	ld a, -1
	ld [wOWObjXVelocity], a
.asm_d607
	pop bc
	ld d, b
	ld e, $00
	ld b, $00
	call DivideDEByBC
	ld a, [wOWObjXVelocity]
	bit 7, a
	jr z, .asm_d621
	ld a, e
	cpl
	add 1
	ld e, a
	ld a, d
	cpl
	adc 0
	ld d, a
.asm_d621
	ld a, e
	ld [wd598], a
	ld a, d
	ld [wOWObjXVelocity], a
.done
	ret

Func_d62a:
	ld a, [wOWScrollX]
	ld d, a
	ld a, [wOWScrollY]
	ld e, a
	ld a, [wOWObjTargetX]
	cp d
	jr nz, .asm_d641
	ld a, [wOWObjTargetY]
	cp e
	jr nz, .asm_d651
	scf
	ccf
	ret

.asm_d641
	ld a, [wd59c]
	ld b, a
	ld a, [wd598]
	add b
	ld [wd59c], a
	ld a, [wOWObjXVelocity]
	adc d
	ld d, a
.asm_d651
	ld a, [wOWObjTargetY]
	cp e
	jr z, .asm_d667
	ld a, [wd59d]
	ld b, a
	ld a, [wd59a]
	add b
	ld [wd59d], a
	ld a, [wOWObjYVelocity]
	adc e
	ld e, a
.asm_d667
	ld a, d
	ld [wOWScrollX], a
	ld a, e
	ld [wOWScrollY], a
	scf
	ret

; reset data at wEventVars and wGeneralVars
ClearEvents:
	push bc
	push hl
	ld hl, wEventVars
	ld bc, EVENT_VAR_BYTES + GENERAL_VAR_BYTES
.loop
	xor a
	ld [hli], a
	dec bc
	ld a, b
	or c
	jr nz, .loop
	pop hl
	pop bc
	ret

Func_d683:
	ld a, EVENT_SET_UNTIL_MAP_RELOAD_1
	call ZeroOutEventValue
	ld a, EVENT_EE
	call ZeroOutEventValue
	ld a, VAR_3B
	ld c, 0
	call SetVarValue
	ret

GetStackEventValue:
	call GetByteAfterCall
;	fallthrough

GetEventValue::
	push bc
	push hl
	call GetEventVar
	ld c, [hl]
.loop
	bit 0, a
	jr nz, .got_bit
	srl a
	srl c
	jr .loop
.got_bit
	ld b, a
	ld a, c
	and b
	jr z, .not_set
	cp b
	jr nz, .not_set
; set
	pop hl
	pop bc
	or a
	ret
.not_set
	pop hl
	pop bc
	xor a
	ret

GetStackVarValue:
	call GetByteAfterCall
;	fallthrough

; a = VAR_* constant
GetVarValue:
	push bc
	push hl
	call GetGeneralVar
	ld c, [hl]
.loop
	bit 0, a
	jr nz, .got_bit
	srl a
	srl c
	jr .loop
.got_bit
	and c
	pop hl
	pop bc
	or a
	ret

MaxStackEventValue:
	call GetByteAfterCall
;	fallthrough

MaxOutEventValue::
	push bc
	push hl
	call GetEventVar
	ld c, $ff
	call SetEventValue
	pop hl
	pop bc
	ret

SetStackEventFalse:
	call GetByteAfterCall
;	fallthrough

ZeroOutEventValue::
	push bc
	push hl
	call GetEventVar
	ld c, 0
	call SetEventValue
	pop hl
	pop bc
	ret

SetStackVarFalse:
	call GetByteAfterCall
;	fallthrough

ZeroOutVarValue:
	push bc
	ld c, 0
	call SetVarValue
	pop bc
	ret

SetStackVarValue:
	call GetByteAfterCall
;	fallthrough

; a = VAR_* constant
; c = value
SetVarValue:
	push bc
	push hl
	call GetGeneralVar
	call SetEventValue
	pop hl
	pop bc
	ret

; a - event
; c - value - truncated to fit only the event var's bounds
SetEventValue:
	ld b, a
.loop
	bit 0, a
	jr nz, .got_bit
	srl a
	sla c
	jr .loop
.got_bit
	ld a, b
	and c
	ld c, a
	ld a, b
	cpl
	and [hl]
	or c
	ld [hl], a
	ret

; returns wEventVars byte in hl
; and related bits in a
GetEventVar:
	push bc
	ld c, a
	xor a
	ld b, a
	sla c
	rl b ; *2
	ld hl, EventVarMasks
	add hl, bc
	ld a, [hli]
	ld c, a
	xor a
	ld b, a
	ld a, [hl]
	ld hl, wEventVars
	add hl, bc
	pop bc
	ret

; returns wGeneralVars byte in hl
; and related bits in a
GetGeneralVar:
	push bc
	ld c, a
	xor a
	ld b, a
	sla c
	rl b
	ld hl, GeneralVarMasks
	add hl, bc
	ld a, [hli]
	ld c, a
	xor a
	ld b, a
	ld a, [hl]
	ld hl, wGeneralVars
	add hl, bc
	pop bc
	ret

; returns in a the byte db'd after the call
; to a function that calls this
GetByteAfterCall:
	push hl
	ld hl, sp+$04
	push bc
	ld c, [hl]
	inc hl
	ld b, [hl]
	ld a, [bc]
	inc bc
	ld [hl], b
	dec hl
	ld [hl], c
	pop bc
	pop hl
	ret

; location in wEventVars of each event var:
; offset - which byte holds the event value
; mask - which bits in the byte hold the value
EventVarMasks:
	db $00, %00000001 ; EVENT_PLAYER_GENDER
	db $00, %00000010 ; EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE
	db $00, %00000100 ; EVENT_02
	db $00, %00001000 ; EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE_DUMMY
	db $01, %00000001 ; EVENT_GOT_CHANSEY_COIN
	db $01, %00000010 ; EVENT_GOT_ODDISH_COIN
	db $01, %00000100 ; EVENT_GOT_CHARMANDER_COIN
	db $01, %00001000 ; EVENT_GOT_STARMIE_COIN
	db $01, %00010000 ; EVENT_GOT_PIKACHU_COIN
	db $01, %00100000 ; EVENT_GOT_ALAKAZAM_COIN
	db $01, %01000000 ; EVENT_GOT_KABUTO_COIN
	db $02, %00001111 ; EVENT_GOT_GR_COIN
	db $02, %00000001 ; EVENT_GOT_GR_COIN_PIECE_TOP_LEFT
	db $02, %00000010 ; EVENT_GOT_GR_COIN_PIECE_TOP_RIGHT
	db $02, %00000100 ; EVENT_GOT_GR_COIN_PIECE_BOTTOM_LEFT
	db $02, %00001000 ; EVENT_GOT_GR_COIN_PIECE_BOTTOM_RIGHT
	db $02, %00010000 ; EVENT_GOT_GOLBAT_COIN
	db $02, %00100000 ; EVENT_GOT_MAGNEMITE_COIN
	db $02, %01000000 ; EVENT_GOT_MAGMAR_COIN
	db $02, %10000000 ; EVENT_GOT_PSYDUCK_COIN
	db $03, %00000001 ; EVENT_GOT_MACHAMP_COIN
	db $03, %00000010 ; EVENT_GOT_MEW_COIN
	db $03, %00000100 ; EVENT_GOT_SNORLAX_COIN
	db $03, %00001000 ; EVENT_GOT_TOGEPI_COIN
	db $03, %00010000 ; EVENT_GOT_PONYTA_COIN
	db $03, %00100000 ; EVENT_GOT_HORSEA_COIN
	db $03, %01000000 ; EVENT_GOT_ARBOK_COIN
	db $03, %10000000 ; EVENT_GOT_JIGGLYPUFF_COIN
	db $04, %00000001 ; EVENT_GOT_DUGTRIO_COIN
	db $04, %00000010 ; EVENT_GOT_GENGAR_COIN
	db $04, %00000100 ; EVENT_GOT_RAICHU_COIN
	db $04, %00001000 ; EVENT_GOT_LUGIA_COIN
	db $05, %00000001 ; EVENT_TALKED_TO_GENE
	db $05, %00000010 ; EVENT_TALKED_TO_MATTHEW
	db $05, %00000100 ; EVENT_TALKED_TO_RYAN
	db $05, %00001000 ; EVENT_TALKED_TO_ANDREW
	db $06, %00000001 ; EVENT_TALKED_TO_MITCH
	db $06, %00000010 ; EVENT_TALKED_TO_MICHAEL
	db $06, %00000100 ; EVENT_TALKED_TO_CHRIS
	db $06, %00001000 ; EVENT_TALKED_TO_JESSICA
	db $07, %00000001 ; EVENT_TALKED_TO_NIKKI
	db $07, %00000010 ; EVENT_TALKED_TO_BRITTANY
	db $07, %00000100 ; EVENT_TALKED_TO_KRISTIN
	db $07, %00001000 ; EVENT_TALKED_TO_HEATHER
	db $07, %00010000 ; EVENT_BEAT_BRITTANY
	db $08, %00000001 ; EVENT_TALKED_TO_RICK
	db $08, %00000010 ; EVENT_TALKED_TO_DAVID
	db $08, %00000100 ; EVENT_TALKED_TO_JOSEPH
	db $08, %00001000 ; EVENT_TALKED_TO_ERIK
	db $09, %00000001 ; EVENT_TALKED_TO_AMY
	db $09, %00000010 ; EVENT_TALKED_TO_JOSHUA
	db $09, %00000100 ; EVENT_TALKED_TO_SARA
	db $09, %00001000 ; EVENT_TALKED_TO_AMANDA
	db $09, %00010000 ; EVENT_35
	db $09, %00100000 ; EVENT_36
	db $0a, %00000001 ; EVENT_TALKED_TO_ISAAC
	db $0a, %00000010 ; EVENT_TALKED_TO_JENNIFER
	db $0a, %00000100 ; EVENT_TALKED_TO_NICHOLAS
	db $0a, %00001000 ; EVENT_TALKED_TO_BRANDON
	db $0a, %00010000 ; EVENT_BEAT_NICHOLAS
	db $0b, %00000001 ; EVENT_TALKED_TO_KEN
	db $0b, %00000010 ; EVENT_TALKED_TO_JOHN
	db $0b, %00000100 ; EVENT_TALKED_TO_ADAM
	db $0b, %00001000 ; EVENT_TALKED_TO_JONATHAN
	db $0c, %00000001 ; EVENT_TALKED_TO_MURRAY
	db $0c, %00000010 ; EVENT_TALKED_TO_ROBERT
	db $0c, %00000100 ; EVENT_TALKED_TO_DANIEL
	db $0c, %00001000 ; EVENT_TALKED_TO_STEPHANIE
	db $0c, %00100000 ; EVENT_BEAT_MURRAY
	db $0c, %01000000 ; EVENT_WALKED_INTO_MURRAYS_CLUB_ROOM
	db $0d, %00000001 ; EVENT_TALKED_TO_MIDORI
	db $0d, %00000010 ; EVENT_TALKED_TO_YUTA
	db $0d, %00000100 ; EVENT_TALKED_TO_MIYUKI
	db $0d, %00001000 ; EVENT_TALKED_TO_MORINO
	db $0d, %00010000 ; EVENT_FREED_RICK
	db $0d, %00100000 ; EVENT_YUTAS_ROOM_DOOR_STATE
	db $0d, %01000000 ; EVENT_MIYUKIS_ROOM_DOOR_STATE
	db $0d, %10000000 ; EVENT_BEAT_MORINO
	db $0e, %00000001 ; EVENT_TALKED_TO_RENNA
	db $0e, %00000010 ; EVENT_TALKED_TO_ICHIKAWA
	db $0e, %00000100 ; EVENT_TALKED_TO_CATHERINE
	db $0e, %00001000 ; EVENT_TALKED_TO_TAP
	db $0e, %00010000 ; EVENT_RENNAS_ROOM_DOOR_STATE
	db $0e, %00100000 ; EVENT_ICHIKAWAS_ROOM_DOOR_STATE
	db $0e, %01000000 ; EVENT_BEAT_CATHERINE
	db $0f, %00000001 ; EVENT_TALKED_TO_JES
	db $0f, %00000010 ; EVENT_TALKED_TO_YUKI
	db $0f, %00000100 ; EVENT_TALKED_TO_SHOKO
	db $0f, %00001000 ; EVENT_TALKED_TO_HIDERO
	db $0f, %00010000 ; EVENT_JES_ROOM_DOOR_STATE
	db $0f, %00100000 ; EVENT_YUKIS_ROOM_DOOR_STATE
	db $0f, %01000000 ; EVENT_SHOKOS_ROOM_DOOR_STATE
	db $0f, %10000000 ; EVENT_BEAT_HIDERO
	db $10, %00000001 ; EVENT_TALKED_TO_MIYAJIMA
	db $10, %00000010 ; EVENT_TALKED_TO_SENTA
	db $10, %00000100 ; EVENT_TALKED_TO_AIRA
	db $10, %00001000 ; EVENT_TALKED_TO_KANOKO
	db $10, %00010000 ; EVENT_MIYAJIMAS_ROOM_DOOR_STATE
	db $10, %00100000 ; EVENT_SENTAS_ROOM_BRIDGE_STATE
	db $10, %01000000 ; EVENT_AIRAS_ROOM_BRIDGE_STATE
	db $10, %10000000 ; EVENT_BEAT_KANOKO
	db $11, %00000001 ; EVENT_TALKED_TO_KAMIYA
	db $11, %00000010 ; EVENT_TALKED_TO_GODA
	db $11, %00000100 ; EVENT_TALKED_TO_GRACE
	db $11, %00001000 ; EVENT_BEAT_KAMIYA
	db $11, %00010000 ; EVENT_FREED_MITCH
	db $11, %00100000 ; EVENT_GRACES_ROOM_CHEST_STATE
	db $12, %00000001 ; EVENT_TALKED_TO_MIWA
	db $12, %00000010 ; EVENT_TALKED_TO_KEVIN
	db $12, %00000100 ; EVENT_TALKED_TO_YOSUKE
	db $12, %00001000 ; EVENT_TALKED_TO_RYOKO
	db $12, %00010000 ; EVENT_TALKED_TO_MAMI
	db $12, %00100000 ; EVENT_BEAT_MIWA
	db $12, %01000000 ; EVENT_BEAT_KEVIN
	db $12, %10000000 ; EVENT_BEAT_YOSUKE
	db $13, %00000001 ; EVENT_BEAT_RYOKO
	db $13, %00000010 ; EVENT_BEAT_MAMI
	db $14, %00000001 ; EVENT_TALKED_TO_NISHIJIMA
	db $14, %00000010 ; EVENT_TALKED_TO_ISHII
	db $14, %00000100 ; EVENT_TALKED_TO_SAMEJIMA
	db $14, %00001000 ; EVENT_BEAT_NISHIJIMA
	db $14, %00010000 ; EVENT_BEAT_ISHII
	db $14, %00100000 ; EVENT_BEAT_SAMEJIMA
	db $14, %00111000 ; EVENT_BEAT_COLORLESS_ALTAR_MEMBERS
	db $14, %01000000 ; EVENT_TALKED_TO_NISHIJIMA_2
	db $14, %10000000 ; EVENT_TALKED_TO_ISHII_2
	db $15, %00000001 ; EVENT_TALKED_TO_SAMEJIMA_2
	db $16, %00000001 ; EVENT_TALKED_TO_KANZAKI
	db $16, %00000010 ; EVENT_TALKED_TO_RUI
	db $16, %00000100 ; EVENT_BEAT_KANZAKI
	db $16, %00001000 ; EVENT_BEAT_RUI
	db $16, %00010000 ; EVENT_MET_GR_GAL_ISHIHARAS_VILLA
	db $17, %00000001 ; EVENT_TALKED_TO_BIRURITCHI
	db $18, %00000001 ; EVENT_TALKED_TO_TRADE_NPC_ROCK_CLUB
	db $18, %00000010 ; EVENT_TALKED_TO_TRADE_NPC_FIGHTING_CLUB
	db $18, %00000100 ; EVENT_TALKED_TO_TRADE_NPC_FIRE_CLUB
	db $18, %00001000 ; EVENT_TALKED_TO_TRADE_NPC_LIGHTNING_CLUB
	db $18, %00010000 ; EVENT_TALKED_TO_TRADE_NPC_PSYCHIC_CLUB
	db $18, %00100000 ; EVENT_TALKED_TO_TRADE_NPC_TCG_CHALLENGE_HALL
	db $18, %01000000 ; EVENT_TALKED_TO_TRADE_NPC_GRASS_FORT
	db $18, %10000000 ; EVENT_TALKED_TO_TRADE_NPC_LIGHTNING_FORT
	db $19, %00000001 ; EVENT_TALKED_TO_TRADE_NPC_GR_CHALLENGE_HALL
	db $19, %00000010 ; EVENT_TALKED_TO_TRADE_NPC_FIRE_FORT
	db $19, %00000100 ; EVENT_TALKED_TO_TRADE_NPC_WATER_FORT
	db $19, %00001000 ; EVENT_TALKED_TO_TRADE_NPC_PSYCHIC_STRONGHOLD
	db $19, %00010000 ; EVENT_91
	db $19, %00100000 ; EVENT_92
	db $19, %01000000 ; EVENT_TALKED_TO_SAM
	db $19, %10000000 ; EVENT_94
	db $1a, %00000001 ; EVENT_TALKED_TO_ISHIHARA
	db $1a, %00000010 ; EVENT_BATTLED_ISHIHARA
	db $1a, %00000100 ; EVENT_TALKED_TO_ISHIHARA_POST_GAME
	db $1b, %00000001 ; EVENT_MET_GR1_ROCK_CLUB
	db $1b, %00000010 ; EVENT_MET_GR4_LIGHTNING_CLUB
	db $1b, %00000100 ; EVENT_MET_GR4_PSYCHIC_CLUB
	db $1b, %00001000 ; EVENT_MET_YUKI_FIRE_FORT
	db $1b, %00010000 ; EVENT_MET_FIGHTING_FORT_MEMBERS
	db $1b, %00100000 ; EVENT_MET_PSYCHIC_STRONGHOLD_MEMBERS
	db $1b, %01000000 ; EVENT_MET_MAMI_AND_ROD
	db $1b, %10000000 ; EVENT_MET_COLORLESS_ALTAR_MEMBERS
	db $1c, %00000001 ; EVENT_MET_BIRURITCHI_AND_ADMINS
	db $1c, %00000010 ; EVENT_GR_CASTLE_STAIRS_RUI_ROADBLOCK
	db $1c, %00000100 ; EVENT_MET_RONALD_GAME_CENTER
	db $1d, %00000001 ; EVENT_TALKED_TO_GR1_FIGHTING_CLUB
	db $1d, %00000010 ; EVENT_TALKED_TO_GR2_SCIENCE_GRASS_CLUB
	db $1d, %00000100 ; EVENT_TALKED_TO_GR3_WATER_CLUB
	db $1d, %00001000 ; EVENT_TALKED_TO_GR4_PSYCHIC_CLUB
	db $1d, %00010000 ; EVENT_A7
	db $1d, %00100000 ; EVENT_OBTAINED_TWO_GR_COIN_PIECES
	db $1d, %01000000 ; EVENT_TALKED_TO_GR5_POKEMON_DOME
	db $1d, %10000000 ; EVENT_TALKED_TO_GR5_TCG_AIRPORT
	db $1e, %00000001 ; EVENT_TRADED_CARDS_ROCK_CLUB
	db $1e, %00000010 ; EVENT_TRADED_CARDS_FIGHTING_CLUB
	db $1e, %00000100 ; EVENT_TRADED_CARDS_FIRE_CLUB
	db $1e, %00001000 ; EVENT_TRADED_CARDS_LIGHTNING_CLUB
	db $1e, %00010000 ; EVENT_TRADED_CARDS_PSYCHIC_CLUB
	db $1e, %00100000 ; EVENT_TRADED_CARDS_TCG_CHALLENGE_HALL
	db $1e, %01000000 ; EVENT_B1
	db $1e, %10000000 ; EVENT_B2
	db $1f, %00000001 ; EVENT_TRADED_CARDS_GRASS_FORT
	db $1f, %00000010 ; EVENT_TRADED_CARDS_LIGHTNING_FORT
	db $1f, %00000100 ; EVENT_TRADED_CARDS_GR_CHALLENGE_HALL
	db $1f, %00001000 ; EVENT_TRADED_CARDS_FIRE_FORT
	db $1f, %00010000 ; EVENT_TRADED_CARDS_WATER_FORT
	db $1f, %00100000 ; EVENT_TRADED_CARDS_PSYCHIC_STRONGHOLD
	db $20, %00000001 ; EVENT_GODAS_ROOM_CAGE_STATE
	db $20, %00000010 ; EVENT_MIDORIS_ROOM_CAGE_STATE
	db $21, %00000001 ; EVENT_TALKED_TO_COURTNEY_POKEMON_DOME
	db $21, %00000010 ; EVENT_TALKED_TO_STEVE_POKEMON_DOME
	db $21, %00000100 ; EVENT_TALKED_TO_JACK_POKEMON_DOME
	db $21, %00001000 ; EVENT_ENTERED_GRAND_MASTER_CUP
	db $21, %00010000 ; EVENT_FREED_COURTNEY
	db $21, %00100000 ; EVENT_FREED_STEVE
	db $21, %01000000 ; EVENT_FREED_JACK
	db $21, %10000000 ; EVENT_FREED_ROD
	db $22, %00000001 ; EVENT_GOT_CHIPS_FROM_GAME_CENTER_ATTENDANT
	db $22, %00000010 ; EVENT_TALKED_TO_SLOT_MACHINE_WOMAN
	db $22, %00000100 ; EVENT_TALKED_TO_COIN_TOSS_BOY
	db $22, %00001000 ; EVENT_C5
	db $23, %00000001 ; EVENT_LIGHTNING_FORT_ENTRANCE_DOOR_STATE
	db $23, %00000010 ; EVENT_FIRE_FORT_ENTRANCE_DOOR_STATE
	db $23, %00000100 ; EVENT_WATER_FORT_ENTRANCE_DOOR_STATE
	db $23, %00011000 ; EVENT_FIGHTING_FORT_ENTRANCE_DOOR_STATE
	db $23, %00001000 ; EVENT_INSERTED_LEFT_COIN_IN_FIGHTING_FORT_DOOR
	db $23, %00010000 ; EVENT_INSERTED_RIGHT_COIN_IN_FIGHTING_FORT_DOOR
	db $23, %00100000 ; EVENT_CAN_TRAVEL_PAST_FIGHTING_FORT
	db $24, %00000011 ; EVENT_GR_CASTLE_ENTRANCE_DOOR_STATE
	db $24, %00000001 ; EVENT_INSERTED_LEFT_COIN_IN_GR_CASTLE_DOOR
	db $24, %00000010 ; EVENT_INSERTED_RIGHT_COIN_IN_GR_CASTLE_DOOR
	db $24, %00000100 ; EVENT_SEALED_FORT_DOOR_STATE
	db $25, %00000001 ; EVENT_OPENED_CHEST_GRACES_ROOM
	db $25, %00000010 ; EVENT_OPENED_CHEST_FIGHTING_FORT_1
	db $25, %00000100 ; EVENT_OPENED_CHEST_FIGHTING_FORT_2
	db $25, %00001000 ; EVENT_OPENED_CHEST_FIGHTING_FORT_3
	db $25, %00010000 ; EVENT_OPENED_CHEST_FIGHTING_FORT_4
	db $25, %00100000 ; EVENT_OPENED_CHEST_FIGHTING_FORT_5
	db $25, %01000000 ; EVENT_OPENED_CHEST_FIGHTING_FORT_BASEMENT
	db $26, %00000001 ; EVENT_SHORT_GR_ISLAND_FLYOVER_SEQUENCE
	db $26, %00000010 ; EVENT_WON_FINAL_CUP
	db $26, %00000100 ; EVENT_WON_GRAND_MASTER_CUP
	db $27, %00000001 ; EVENT_GHOST_MASTER_STATUES_STATE
	db $27, %00000010 ; EVENT_BATTLED_TOBICHAN
	db $28, %00000001 ; EVENT_BATTLED_EIJI
	db $28, %00000010 ; EVENT_BATTLED_MAGICIAN
	db $28, %00000100 ; EVENT_BATTLED_TOSHIRON
	db $28, %00001000 ; EVENT_BATTLED_PIERROT
	db $28, %00010000 ; EVENT_BATTLED_ANNA
	db $28, %00100000 ; EVENT_BATTLED_DEE
	db $28, %01000000 ; EVENT_BATTLED_MASQUERADE
	db $28, %10000000 ; EVENT_BATTLED_YUI
	db $29, %00000001 ; EVENT_TALKED_TO_PAWN
	db $29, %00000010 ; EVENT_TALKED_TO_KNIGHT
	db $29, %00000100 ; EVENT_TALKED_TO_BISHOP
	db $29, %00001000 ; EVENT_TALKED_TO_ROOK
	db $29, %00010000 ; EVENT_TALKED_TO_QUEEN
	db $2a, %00000001 ; EVENT_EB
	db $2a, %00000010 ; EVENT_TALKED_TO_ROD_POKEMON_DOME
	db $2b, %00000001 ; EVENT_SET_UNTIL_MAP_RELOAD_1
	db $2b, %00000010 ; EVENT_EE
	db $2b, %00000100 ; EVENT_EF
	db $33, %00000001 ; EVENT_F0
	db $33, %00000010 ; EVENT_SET_UNTIL_MAP_RELOAD_2
	db $33, %00000100 ; EVENT_F2
	db $33, %00001000 ; EVENT_F3
	db $33, %00010000 ; EVENT_ISHIHARA_CARD_TRADE_STATE
	db $33, %00100000 ; EVENT_ISHIHARA_LOCATION_STATE

; extra events?
GeneralVarMasks:
	db $00, %11111111 ; VAR_00
	db $01, %00000011 ; VAR_01
	db $01, %00111100 ; VAR_ISHIHARA_STATE
	db $01, %11000000 ; VAR_03
	db $02, %00001111 ; VAR_TIMES_MET_RONALD
	db $03, %00000011 ; VAR_05
	db $03, %00001100 ; VAR_06
	db $03, %00110000 ; VAR_07
	db $04, %00001111 ; VAR_08
	db $04, %00110000 ; VAR_09
	db $04, %11000000 ; VAR_0A
	db $05, %00000011 ; VAR_0B
	db $06, %00000011 ; VAR_FINAL_CUP_PLAYED_ROUNDS
	db $06, %00011100 ; VAR_GRAND_MASTER_CUP_STATE
	db $06, %11100000 ; VAR_GRANDMASTERCUP_CURRENT_ROUND
	db $07, %00001111 ; VAR_0F
	db $08, %11111111 ; VAR_GRANDMASTERCUP_PRIZE_INDEX_0
	db $09, %11111111 ; VAR_GRANDMASTERCUP_PRIZE_INDEX_1
	db $0a, %11111111 ; VAR_GRANDMASTERCUP_PRIZE_INDEX_2
	db $0b, %11111111 ; VAR_GRANDMASTERCUP_PRIZE_INDEX_3
	db $0c, %11111111 ; VAR_GRANDMASTERCUP_ROUND1_NPC1_DECK_ID
	db $0d, %11111111 ; VAR_GRANDMASTERCUP_ROUND1_NPC2_DECK_ID
	db $0e, %11111111 ; VAR_GRANDMASTERCUP_ROUND1_NPC3_DECK_ID
	db $0f, %11111111 ; VAR_GRANDMASTERCUP_ROUND1_NPC4_DECK_ID
	db $10, %11111111 ; VAR_GRANDMASTERCUP_ROUND1_NPC5_DECK_ID
	db $11, %11111111 ; VAR_GRANDMASTERCUP_ROUND1_NPC6_DECK_ID
	db $12, %11111111 ; VAR_GRANDMASTERCUP_ROUND1_NPC7_DECK_ID
	db $13, %11111111 ; VAR_GRANDMASTERCUP_ROUND2_NPC1_DECK_ID
	db $14, %11111111 ; VAR_GRANDMASTERCUP_ROUND2_NPC2_DECK_ID
	db $15, %11111111 ; VAR_GRANDMASTERCUP_ROUND2_NPC3_DECK_ID
	db $16, %11111111 ; VAR_GRANDMASTERCUP_FINAL_NPC_DECK_ID
	db $17, %00000011 ; VAR_GRANDMASTERCUP_GF_GRAND_MASTER_INDEX
	db $17, %00111100 ; VAR_TIMES_WON_LINK_DUEL_FOR_GRAND_MASTER_CUP
	db $18, %00000111 ; VAR_21
	db $18, %11110000 ; VAR_IMAKUNI_BLACK_WIN_COUNT
	db $19, %00000001 ; VAR_23
	db $19, %11110000 ; VAR_24
	db $1a, %00001111 ; VAR_25
	db $1a, %11110000 ; VAR_26
	db $1b, %00001111 ; VAR_27
	db $1b, %01110000 ; VAR_TCG_CHALLENGE_CUP_STATE
	db $1c, %00011111 ; VAR_TCG_CHALLENGE_CUP_PRIZE_INDEX
	db $1d, %00001111 ; VAR_TIMES_WON_TCG_CHALLENGE_CUP
	db $1d, %00110000 ; VAR_TCG_CHALLENGE_CUP_RESULT
	db $1d, %11000000 ; VAR_CHALLENGECUP_CURRENT_ROUND
	db $1e, %11111111 ; VAR_CHALLENGECUP_ROUND1_OPPONENT_DECK_ID
	db $1f, %11111111 ; VAR_CHALLENGECUP_ROUND2_OPPONENT_DECK_ID
	db $20, %11111111 ; VAR_CHALLENGECUP_ROUND3_OPPONENT_DECK_ID
	db $21, %00000111 ; VAR_GR_CHALLENGE_CUP_STATE
	db $21, %11111000 ; VAR_GR_CHALLENGE_CUP_PRIZE_INDEX
	db $22, %00001111 ; VAR_TIMES_WON_GR_CHALLENGE_CUP
	db $22, %00110000 ; VAR_GR_CHALLENGE_CUP_RESULT
	db $23, %00000111 ; VAR_CHALLENGEMACHINE_CURRENT_ROUND
	db $24, %11111111 ; VAR_CHALLENGEMACHINE_ROUND1_OPPONENT_DECK_ID
	db $25, %11111111 ; VAR_CHALLENGEMACHINE_ROUND2_OPPONENT_DECK_ID
	db $26, %11111111 ; VAR_CHALLENGEMACHINE_ROUND3_OPPONENT_DECK_ID
	db $27, %11111111 ; VAR_CHALLENGEMACHINE_ROUND4_OPPONENT_DECK_ID
	db $28, %11111111 ; VAR_CHALLENGEMACHINE_ROUND5_OPPONENT_DECK_ID
	db $29, %00000111 ; VAR_CARD_DUNGEON_PROGRESS
	db $2a, %11111111 ; VAR_3B
	db $2b, %11111111 ; VAR_NPC_DECK_ID
	db $2c, %11111111 ; VAR_DUEL_START_THEME
	db $33, %11111111 ; VAR_3E

; clear 8 bytes from wd606
ZeroOutBytes_wd606:
	push af
	push hl
	xor a
	ld hl, wd606
REPT wD606_STRUCT_SIZE - 1
	ld [hli], a
ENDR
	ld [hl], a
	pop hl
	pop af
	ret

; set n, [wd606 + m], where a = 8m + n
SetBit_wd606:
	push af
	push bc
	push hl
	push af
	ld hl, wd606
REPT 3
	srl a
ENDR
	add_hl_a
	pop af
	and 7
	inc a
	ld c, a
	ld b, 1
.loop_bitmask
	dec c
	jr z, .got_bitmask
	sla b
	jr .loop_bitmask
.got_bitmask
	ld a, [hl]
	or b
	ld [hl], a
	pop hl
	pop bc
	pop af
	ret

; res n, [wd606 + m], where a = 8m + n
ClearBit_wd606:
	push af
	push bc
	push hl
	push af
	ld hl, wd606
REPT 3
	srl a
ENDR
	add_hl_a
	pop af
	and 7
	inc a
	ld c, a
	ld b, 1
.loop_bitmask
	dec c
	jr z, .got_bitmask
	sla b
	jr .loop_bitmask
.got_bitmask
	ld a, b
	cpl
	and [hl]
	ld [hl], a
	pop hl
	pop bc
	pop af
	ret

; bit n, [wd606 + m], where a = 8m + n
CheckBit_wd606:
	push bc
	push hl
	push af
	push af
	ld hl, wd606
REPT 3
	srl a
ENDR
	add_hl_a
	pop af
	and 7
	inc a
	ld c, a
	ld b, 1
.loop_bitmask
	dec c
	jr z, .got_bitmask
	sla b
	jr .loop_bitmask
.got_bitmask
	ld a, [hl]
	and b
	pop bc
	ld a, b
	pop hl
	pop bc
	ret

; a = machine 1 category index
; jump to .category_table[a]
; return a = event flag(s), with carry if nz, with no carry otherwise
; single event check: category unlock
; multiple          : per-deck unlock
CheckCurAutoDeckMachine1CategoryUnlockEvents:
	push bc
	push de
	push hl
	sla a
	ld hl, .category_table
	add_hl_a
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp hl

; unlocked from start
.BasicDecks
	jp .set_carry

; received anti-GR decks, checked with coin flags
.AntiGRDecks
	ld a, EVENT_GOT_KABUTO_COIN
	call GetEventValue
	push af
	ld a, EVENT_GOT_ODDISH_COIN
	call GetEventValue
	push af
	ld a, EVENT_GOT_STARMIE_COIN
	call GetEventValue
	push af
	ld a, EVENT_GOT_ALAKAZAM_COIN
	call GetEventValue
	push af
	ld c, 4
	xor a
	ld d, a
.loop_bitmask_four_coins
	sla d
	pop af
	jr z, .next_coin
	set 0, d
.next_coin
	dec c
	jr nz, .loop_bitmask_four_coins
	ld a, d
	or a
	jp nz, .set_carry
	jp .clear_carry

; beat GR1
.FightingDecks
	ld a, EVENT_GOT_GR_COIN_PIECE_TOP_LEFT
	call GetEventValue
	jp nz, .set_carry
	jp .clear_carry

; beat GR2
.GrassDecks
	ld a, EVENT_GOT_GR_COIN_PIECE_TOP_RIGHT
	call GetEventValue
	jp nz, .set_carry
	jp .clear_carry

; beat GR3 in Water Club
.WaterDecks
	ld a, EVENT_GOT_STARMIE_COIN
	call GetEventValue
	jp nz, .set_carry
	jp .clear_carry

; beat GR3 in Fire Club
.FireDecks
	ld a, EVENT_GOT_GR_COIN_PIECE_BOTTOM_LEFT
	call GetEventValue
	jp nz, .set_carry
	jp .clear_carry

; beat controlled Isaac
.LightningDecks
	ld a, EVENT_GOT_PIKACHU_COIN
	call GetEventValue
	jp nz, .set_carry
	jp .clear_carry

; beat GR4
.PsychicDecks
	ld a, EVENT_GOT_GR_COIN_PIECE_BOTTOM_RIGHT
	call GetEventValue
	jp nz, .set_carry
	jp .clear_carry

; won final cup / post-game
; each unlocks two decks
.SpecialDecks
	ld a, EVENT_WON_FINAL_CUP
	call GetEventValue
	push af
	ld a, EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE
	call GetEventValue
	push af
	ld c, 2
	xor a
	ld d, a
.loop_bitmask_events
	sla d
	sla d
	pop af
	jr z, .next_event
	set 0, d
	set 1, d
.next_event
	dec c
	jr nz, .loop_bitmask_events
	ld a, d
	or a
	jp nz, .set_carry
	jp .clear_carry

; won grand master cup
.LegendaryDecks:
	ld a, EVENT_WON_GRAND_MASTER_CUP
	call GetEventValue
	jp nz, .set_carry
	jp .clear_carry

.set_carry
	pop hl
	pop de
	pop bc
	scf
	ret

.clear_carry
	pop hl
	pop de
	pop bc
	scf
	ccf
	ret

.category_table
	dw .BasicDecks     ; AUTO_DECK_BASIC
	dw .AntiGRDecks    ; AUTO_DECK_GIVEN
	dw .FightingDecks  ; AUTO_DECK_FIGHTING
	dw .GrassDecks     ; AUTO_DECK_GRASS
	dw .WaterDecks     ; AUTO_DECK_WATER
	dw .FireDecks      ; AUTO_DECK_FIRE
	dw .LightningDecks ; AUTO_DECK_LIGHTNING
	dw .PsychicDecks   ; AUTO_DECK_PSYCHIC
	dw .SpecialDecks   ; AUTO_DECK_SPECIAL
	dw .LegendaryDecks ; AUTO_DECK_LEGENDARY

; a = machine 2 category index
; jump to .category_table[a]
; return a = event flag with carry if nz, with no carry otherwise
CheckCurAutoDeckMachine2CategoryUnlockEvents:
	push bc
	push de
	push hl
	sla a
	ld hl, .category_table
	add_hl_a
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp hl

; beat Morino
.DarkGrassDecks
	ld a, EVENT_GOT_GOLBAT_COIN
	call GetEventValue
	jp nz, .set_carry
	jp .clear_carry

; beat Catherine
.DarkLightningDecks
	ld a, EVENT_GOT_MAGNEMITE_COIN
	call GetEventValue
	jp nz, .set_carry
	jp .clear_carry

; beat Kanoko
.DarkWaterDecks
	ld a, EVENT_GOT_PSYDUCK_COIN
	call GetEventValue
	jp nz, .set_carry
	jp .clear_carry

; beat Hidero
.DarkFireDecks
	ld a, EVENT_GOT_MAGMAR_COIN
	call GetEventValue
	jp nz, .set_carry
	jp .clear_carry

; beat Kamiya
.DarkFightingDecks
	ld a, EVENT_GOT_MACHAMP_COIN
	call GetEventValue
	jp nz, .set_carry
	jp .clear_carry

; beat Mami
.DarkPsychicDecks
	ld a, EVENT_GOT_MEW_COIN
	call GetEventValue
	jp nz, .set_carry
	jp .clear_carry

; beat all three Colorless Altar guardians
.ColorlessDecks
	ld a, EVENT_GOT_SNORLAX_COIN
	call GetEventValue
	jp nz, .set_carry
	jp .clear_carry

; beat Rui
.DarkSpecialDecks
	ld a, EVENT_GR_CASTLE_STAIRS_RUI_ROADBLOCK
	call GetEventValue
	jp nz, .set_carry
	jp .clear_carry

; battled Ishihara
.SuperRareDecks
	ld a, EVENT_BATTLED_ISHIHARA
	call GetEventValue
	jp nz, .set_carry
	jp .clear_carry

; post-game
.MysteriousDecks
	ld a, EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE
	call GetEventValue
	jp nz, .set_carry
	jp .clear_carry

.set_carry
	pop hl
	pop de
	pop bc
	scf
	ret

.clear_carry
	pop hl
	pop de
	pop bc
	scf
	ccf
	ret

.category_table
	dw .DarkGrassDecks     ; AUTO_DECK_DARK_GRASS
	dw .DarkLightningDecks ; AUTO_DECK_DARK_LIGHTNING
	dw .DarkWaterDecks     ; AUTO_DECK_DARK_WATER
	dw .DarkFireDecks      ; AUTO_DECK_DARK_FIRE
	dw .DarkFightingDecks  ; AUTO_DECK_DARK_FIGHTING
	dw .DarkPsychicDecks   ; AUTO_DECK_DARK_PSYCHIC
	dw .ColorlessDecks     ; AUTO_DECK_COLORLESS
	dw .DarkSpecialDecks   ; AUTO_DECK_DARK_SPECIAL
	dw .SuperRareDecks     ; AUTO_DECK_SUPER_RARE
	dw .MysteriousDecks    ; AUTO_DECK_MYSTERIOUS

GetNumberOfDeckDiagnosisStepsUnlocked:
	push bc
	xor a
	ld c, a
	ld a, EVENT_GOT_STARMIE_COIN
	call GetEventValue
	jr z, .got_num_steps
	inc c
	ld a, EVENT_GOT_GR_COIN
	call GetEventValue
	jr z, .got_num_steps
	inc c
	ld a, EVENT_GOT_MAGNEMITE_COIN
	call GetEventValue
	jr z, .got_num_steps
	inc c
.got_num_steps
	ld a, c
	pop bc
	ret

; clear wScriptBufferIndex
; then copy 32 bytes from the script source to wScriptBuffer
ReloadScriptBuffer::
	xor a
	ld [wScriptBufferIndex], a
	ld hl, wScriptPointer
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld de, wScriptBuffer
	ld bc, SCRIPT_BUFFER_SIZE
	ld a, [wScriptBank]
	call CopyFarHLToDE
	ret

; for n = [wScriptBufferIndex],
; get the table index m = [wScriptBuffer + n],
; jump to OverworldScriptTable[m]
; applying m in two steps rather than sla, even though m < 128
RunOverworldScript::
	ld hl, wScriptBufferIndex
	ld a, [hl]
	ld hl, wScriptBuffer
	add_hl_a
	ld a, [hl]
	ld d, a
	ld hl, OverworldScriptTable
	add_hl_a
	ld a, d
	add_hl_a
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp hl

OverworldScriptTable:
	dw ScriptCommand_EndScript                        ; $00
	dw ScriptCommand_StartDialog                      ; $01
	dw ScriptCommand_EndDialog                        ; $02
	dw ScriptCommand_PrintText                        ; $03
	dw ScriptCommand_PrintVariableText                ; $04
	dw ScriptCommand_PrintNPCText                     ; $05
	dw ScriptCommand_PrintVariableNPCText             ; $06
	dw ScriptCommand_AskQuestion                      ; $07
	dw ScriptCommand_ScriptJump                       ; $08
	dw ScriptCommand_ScriptJump_b0nz                  ; $09
	dw ScriptCommand_ScriptJump_b0z                   ; $0a
	dw ScriptCommand_ScriptJump_b1nz                  ; $0b
	dw ScriptCommand_ScriptJump_b1z                   ; $0c
	dw ScriptCommand_CompareLoadedVar                 ; $0d
	dw ScriptCommand_SetEvent                         ; $0e
	dw ScriptCommand_ResetEvent                       ; $0f
	dw ScriptCommand_CheckEvent                       ; $10
	dw ScriptCommand_SetVar                           ; $11
	dw ScriptCommand_GetVar                           ; $12
	dw ScriptCommand_IncVar                           ; $13
	dw ScriptCommand_DecVar                           ; $14
	dw ScriptCommand_LoadNPC                          ; $15
	dw ScriptCommand_UnloadNPC                        ; $16
	dw ScriptCommand_SetPlayerDirection               ; $17
	dw ScriptCommand_SetActiveNPCDirection            ; $18
	dw ScriptCommand_DoFrames                         ; $19
	dw ScriptCommand_LoadTilemap                      ; $1a
	dw ScriptCommand_ShowCardReceivedScreen           ; $1b
	dw ScriptCommand_SetPlayerPosition                ; $1c
	dw ScriptCommand_SetActiveNPCPosition             ; $1d
	dw ScriptCommand_SetScrollState                   ; $1e
	dw ScriptCommand_ScrollToPosition                 ; $1f
	dw ScriptCommand_SetActiveNPC                     ; $20
	dw ScriptCommand_SetPlayerPositionAndDirection    ; $21
	dw ScriptCommand_SetNPCPositionAndDirection       ; $22
	dw ScriptCommand_FadeIn                           ; $23
	dw ScriptCommand_FadeOut                          ; $24
	dw ScriptCommand_SetNPCDirection                  ; $25
	dw ScriptCommand_SetNPCPosition                   ; $26
	dw ScriptCommand_SetActiveNPCPositionAndDirection ; $27
	dw ScriptCommand_AnimatePlayerMovement            ; $28
	dw ScriptCommand_AnimateNPCMovement               ; $29
	dw ScriptCommand_AnimateActiveNPCMovement         ; $2a
	dw ScriptCommand_MovePlayer                       ; $2b
	dw ScriptCommand_MoveNPC                          ; $2c
	dw ScriptCommand_MoveActiveNPC                    ; $2d
	dw ScriptCommand_StartDuel                        ; $2e
	dw ScriptCommand_WaitForPlayerAnimation           ; $2f
	dw ScriptCommand_WaitForFade                      ; $30
	dw ScriptCommand_GetCardCountInCollectionAndDecks ; $31
	dw ScriptCommand_GetCardCountInCollection         ; $32
	dw ScriptCommand_GiveCard                         ; $33
	dw ScriptCommand_TakeCard                         ; $34
	dw ScriptCommand_NPCAskQuestion                   ; $35
	dw ScriptCommand_GetPlayerDirection               ; $36
	dw ScriptCommand_CompareVar                       ; $37
	dw ScriptCommand_GetActiveNPCDirection            ; $38
	dw ScriptCommand_ScrollToActiveNPC                ; $39
	dw ScriptCommand_ScrollToPlayer                   ; $3a
	dw ScriptCommand_ScrollToNPC                      ; $3b
	dw ScriptCommand_SpinActiveNPC                    ; $3c
	dw ScriptCommand_RestoreActiveNPCDirection        ; $3d
	dw ScriptCommand_SpinActiveNPCReverse             ; $3e
	dw ScriptCommand_ResetNPCFlag6                    ; $3f
	dw ScriptCommand_SetNPCFlag6                      ; $40
	dw ScriptCommand_DuelRequirementCheck             ; $41
	dw ScriptCommand_GetActiveNPCOppositeDirection    ; $42
	dw ScriptCommand_GetPlayerOppositeDirection       ; $43
	dw ScriptCommand_PlaySFX                          ; $44
	dw ScriptCommand_PlaySFXAndWait                   ; $45
	dw ScriptCommand_SetTextRAM2                      ; $46
	dw ScriptCommand_SetVariableTextRAM2              ; $47
	dw ScriptCommand_WaitForNPCAnimation              ; $48
	dw ScriptCommand_GetPlayerXPosition               ; $49
	dw ScriptCommand_GetPlayerYPosition               ; $4a
	dw ScriptCommand_RestoreNPCDirection              ; $4b
	dw ScriptCommand_SpinNPC                          ; $4c
	dw ScriptCommand_SpinNPCReverse                   ; $4d
	dw ScriptCommand_PushVar                          ; $4e
	dw ScriptCommand_PopVar                           ; $4f
	dw ScriptCommand_ScriptCall                       ; $50
	dw ScriptCommand_ScriptRet                        ; $51
	dw ScriptCommand_GiveCoin                         ; $52
	dw ScriptCommand_BackupActiveNPC                  ; $53
	dw ScriptCommand_LoadPlayer                       ; $54
	dw ScriptCommand_UnloadPlayer                     ; $55
	dw ScriptCommand_GiveBoosterPacks                 ; $56
	dw ScriptCommand_GetRandom                        ; $57
	dw ScriptCommand_OpenMenu                         ; $58
	dw ScriptCommand_SetTextRAM3                      ; $59
	dw ScriptCommand_QuitScript                       ; $5a
	dw ScriptCommand_PlaySong                         ; $5b
	dw ScriptCommand_ResumeSong                       ; $5c
	dw ScriptCommand_ScriptCallfar                    ; $5d
	dw ScriptCommand_ScriptRetfar                     ; $5e
	dw ScriptCommand_CardPop                          ; $5f
	dw ScriptCommand_PlaySongNext                     ; $60
	dw ScriptCommand_SetTextRAM2b                     ; $61
	dw ScriptCommand_SetVariableTextRAM2b             ; $62
	dw ScriptCommand_ReplaceNPC                       ; $63
	dw ScriptCommand_SendMail                         ; $64
	dw ScriptCommand_CheckNPCLoaded                   ; $65
	dw ScriptCommand_GiveDeck                         ; $66
	dw ScriptCommand_67                               ; $67
	dw ScriptCommand_68                               ; $68
	dw ScriptCommand_PrintNPCTextInstant              ; $69
	dw ScriptCommand_VarAdd                           ; $6a
	dw ScriptCommand_VarSub                           ; $6b
	dw ScriptCommand_ReceiveCard                      ; $6c
	dw ScriptCommand_GetGameCenterChips               ; $6d
	dw ScriptCommand_CompareLoadedVarWord             ; $6e
	dw ScriptCommand_GetGameCenterBankedChips         ; $6f
	dw ScriptCommand_ShowChipsHUD                     ; $70
	dw ScriptCommand_HideChipsHUD                     ; $71
	dw ScriptCommand_GiveChips                        ; $72
	dw ScriptCommand_TakeChips                        ; $73
	dw ScriptCommand_LoadTextRAM3                     ; $74
	dw ScriptCommand_DepositChips                     ; $75
	dw ScriptCommand_WithdrawChips                    ; $76
	dw ScriptCommand_LinkDuel                         ; $77
	dw ScriptCommand_WaitSong                         ; $78
	dw ScriptCommand_LoadPalette                      ; $79
	dw ScriptCommand_SetSpriteFrameset                ; $7a
	dw ScriptCommand_WaitSFX                          ; $7b
	dw ScriptCommand_PrintTextWideTextbox             ; $7c
	dw ScriptCommand_WaitInput                        ; $7d

; add a to [wScriptPointer]
; if [wScriptBufferIndex] + a < 32, add a to [wScriptBufferIndex] too
; else ReloadScriptBuffer
IncreaseScriptPointer:
	ld c, a
	ld hl, wScriptPointer
	add_at_hl_a
	ld a, c
	ld hl, wScriptBufferIndex
	add [hl]
	cp SCRIPT_BUFFER_SIZE
	jr nc, .fallback
	ld [hl], a
	ret
.fallback
	call ReloadScriptBuffer
	ret

ReloadScriptBuffer_Done:
	ret

IncreaseScriptPointerBy1:
	ld a, 1
	jr IncreaseScriptPointer

IncreaseScriptPointerBy2:
	ld a, 2
	jr IncreaseScriptPointer

IncreaseScriptPointerBy3:
	ld a, 3
	jr IncreaseScriptPointer

IncreaseScriptPointerBy4:
	ld a, 4
	jr IncreaseScriptPointer

IncreaseScriptPointerBy5:
	ld a, 5
	jr IncreaseScriptPointer

; get 2 db args or 1 dw arg:
; for j = [wScriptBufferIndex] + a,
; if j + 1 < 32, bc = [dw wScriptBuffer + j], a = (b | c)
; else call ReloadScriptBuffer and retry
Get2ScriptArgs:
.loop
	push af
	ld hl, wScriptBufferIndex
	add [hl]
	inc a
	cp SCRIPT_BUFFER_SIZE
	jr nc, .fallback
	pop bc
	dec a
	ld hl, wScriptBuffer
	add_hl_a
	ld a, [hli]
	ld b, [hl]
	ld c, a
	or b
	ret
.fallback
	call ReloadScriptBuffer
	pop af
	jr .loop

Get2ScriptArgs_IncrIndexBy1:
	ld a, 1
	jr Get2ScriptArgs

Get2ScriptArgs_IncrIndexBy2:
	ld a, 2
	jr Get2ScriptArgs

Get2ScriptArgs_IncrIndexBy3:
	ld a, 3
	jr Get2ScriptArgs

; get 1 db arg:
; for j = [wScriptBufferIndex] + a,
; if j < 32, a = [wScriptBuffer + j] (with flags)
; else call ReloadScriptBuffer and retry
Get1ScriptArg:
.loop
	push af
	ld hl, wScriptBufferIndex
	add [hl]
	cp SCRIPT_BUFFER_SIZE
	jr nc, .fallback
	pop bc
	ld hl, wScriptBuffer
	add_hl_a
	ld a, [hl]
	or a
	ret
.fallback
	call ReloadScriptBuffer
	pop af
	jr .loop

Get1ScriptArg_IncrIndexBy1:
	ld a, 1
	jr Get1ScriptArg

Get1ScriptArg_IncrIndexBy2:
	ld a, 2
	jr Get1ScriptArg

Get1ScriptArg_IncrIndexBy3:
	ld a, 3
	jr Get1ScriptArg

Get1ScriptArg_IncrIndexBy4:
	ld a, 4
	jr Get1ScriptArg

ScriptCommand_EndScript:
	ld a, [wScriptFlags]
	set 7, a
	ld [wScriptFlags], a
	jp IncreaseScriptPointerBy1

ScriptCommand_StartDialog:
	call DoFrame
	farcall HideNPCAnimsUnderDialogBox
	jp IncreaseScriptPointerBy1

ScriptCommand_EndDialog:
	farcall ShowNPCAnimsUnderDialogBox
	jp IncreaseScriptPointerBy1

ScriptCommand_PrintText:
	call Get2ScriptArgs_IncrIndexBy1
	ld l, c
	ld h, b
	farcall PrintScrollableText_NoTextBoxLabelVRAM0
	jp IncreaseScriptPointerBy3

ScriptCommand_PrintVariableText:
	ld hl, wScriptFlags
	bit 0, [hl]
	jr z, .use_text_2
; use text 1
	call Get2ScriptArgs_IncrIndexBy1
	jr .next
.use_text_2
	call Get2ScriptArgs_IncrIndexBy3
.next
	ld l, c
	ld h, b
	farcall PrintScrollableText_NoTextBoxLabelVRAM0
	jp IncreaseScriptPointerBy5

ScriptCommand_PrintNPCText:
	call Get2ScriptArgs_IncrIndexBy1
	ld hl, wScriptNPCName
	ld a, [hli]
	ld d, [hl]
	ld e, a
	ld l, c
	ld h, b
	farcall PrintScrollableText_WithTextBoxLabelVRAM0
	jp IncreaseScriptPointerBy3

ScriptCommand_PrintVariableNPCText:
	ld hl, wScriptFlags
	bit 0, [hl]
	jr z, .use_text_2
; use text 1
	call Get2ScriptArgs_IncrIndexBy1
	jr .next
.use_text_2
	call Get2ScriptArgs_IncrIndexBy3
; fallthrough
.next
	ld hl, wScriptNPCName
	ld a, [hli]
	ld d, [hl]
	ld e, a
	ld l, c
	ld h, b
	farcall PrintScrollableText_WithTextBoxLabelVRAM0
	jp IncreaseScriptPointerBy5

ScriptCommand_AskQuestion:
	call Get2ScriptArgs_IncrIndexBy1
	ld l, c
	ld h, b
	push hl
	call Get1ScriptArg_IncrIndexBy3
	pop hl
	farcall DrawWideTextBox_PrintTextWithYesOrNoMenu
	ld hl, wScriptFlags
	or a
	jr nz, .no
; yes
	set 0, [hl]
	jp IncreaseScriptPointerBy4
.no
	res 0, [hl]
	jp IncreaseScriptPointerBy4

ScriptCommand_ScriptJump:
	call Get2ScriptArgs_IncrIndexBy1
	ld a, c
	ld [wScriptPointer], a
	ld a, b
	ld [wScriptPointer + 1], a
	call ReloadScriptBuffer
	jp ReloadScriptBuffer_Done

ScriptCommand_ScriptJump_b0nz:
	ld hl, wScriptFlags
	bit 0, [hl]
; yes
	jp nz, ScriptCommand_ScriptJump
; no
	jp IncreaseScriptPointerBy3

ScriptCommand_ScriptJump_b0z:
	ld hl, wScriptFlags
	bit 0, [hl]
; no
	jp z, ScriptCommand_ScriptJump
; yes
	jp IncreaseScriptPointerBy3

ScriptCommand_ScriptJump_b1nz:
	ld hl, wScriptFlags
	bit 1, [hl]
; invalid
	jp nz, ScriptCommand_ScriptJump
; valid
	jp IncreaseScriptPointerBy3

ScriptCommand_ScriptJump_b1z:
	ld hl, wScriptFlags
	bit 1, [hl]
; valid
	jp z, ScriptCommand_ScriptJump
; invalid
	jp IncreaseScriptPointerBy3

; for x = [wScriptBuffer + [wScriptBufferIndex] + 1],
; set bit 0 at wScriptFlags if x = [wScriptLoadedVar],
; set bit 1 at wScriptFlags if x > [wScriptLoadedVar],
; else reset both bits,
; then IncreaseScriptPointerBy2
ScriptCommand_CompareLoadedVar:
	call Get1ScriptArg_IncrIndexBy1
	ld c, a
	ld a, [wScriptLoadedVar]
	ld hl, wScriptFlags
	res 0, [hl]
	res 1, [hl]
	cp c
	jr nz, .not_equal
	set 0, [hl]
.not_equal
	jr nc, .no_carry
	set 1, [hl]
.no_carry
	jp IncreaseScriptPointerBy2

ScriptCommand_SetEvent:
	call Get1ScriptArg_IncrIndexBy1
	call MaxOutEventValue
	jp IncreaseScriptPointerBy2

ScriptCommand_ResetEvent:
	call Get1ScriptArg_IncrIndexBy1
	call ZeroOutEventValue
	jp IncreaseScriptPointerBy2

ScriptCommand_CheckEvent:
	call Get1ScriptArg_IncrIndexBy1
	call GetEventValue
	ld hl, wScriptFlags
	jr z, .set
; reset
	res 0, [hl]
	jp IncreaseScriptPointerBy2
.set
	set 0, [hl]
	jp IncreaseScriptPointerBy2

ScriptCommand_SetVar:
	call Get2ScriptArgs_IncrIndexBy1
	ld a, c
	ld c, b
	call SetVarValue
	jp IncreaseScriptPointerBy3

ScriptCommand_GetVar:
	call Get1ScriptArg_IncrIndexBy1
	call GetVarValue
	ld [wScriptLoadedVar], a
	jp IncreaseScriptPointerBy2

; inc VAR_* constant value
ScriptCommand_IncVar:
	call Get1ScriptArg_IncrIndexBy1
	push af
	call GetVarValue
	inc a
	ld c, a
	pop af
	call SetVarValue
	jp IncreaseScriptPointerBy2

; dec VAR_* constant value
ScriptCommand_DecVar:
	call Get1ScriptArg_IncrIndexBy1
	push af
	call GetVarValue
	dec a
	ld c, a
	pop af
	call SetVarValue
	jp IncreaseScriptPointerBy2

ScriptCommand_LoadNPC:
	call Get1ScriptArg_IncrIndexBy1
	push af
	call Get2ScriptArgs_IncrIndexBy2
	ld d, c
	ld e, b
	push de
	call Get1ScriptArg_IncrIndexBy4
	ld b, a
	pop de
	pop af
	farcall LoadOWObjectInMap
	jp IncreaseScriptPointerBy5

ScriptCommand_UnloadNPC:
	call Get1ScriptArg_IncrIndexBy1
	farcall ClearOWObject
	jp IncreaseScriptPointerBy2

ScriptCommand_SetPlayerDirection:
	call Get1ScriptArg_IncrIndexBy1
	ld b, a
	ld a, [wPlayerOWObject]
	farcall SetOWObjectDirection
	jp IncreaseScriptPointerBy2

ScriptCommand_SetActiveNPCDirection:
	call Get1ScriptArg_IncrIndexBy1
	ld b, a
	ld a, [wScriptNPC]
	farcall SetOWObjectDirection
	jp IncreaseScriptPointerBy2

ScriptCommand_DoFrames:
	call Get1ScriptArg_IncrIndexBy1
	ld c, a
.delay_loop
	call DoFrame
	dec c
	jr nz, .delay_loop
	jp IncreaseScriptPointerBy2

ScriptCommand_LoadTilemap:
	call Get2ScriptArgs_IncrIndexBy1
	push bc
	call Get2ScriptArgs_IncrIndexBy3
	ld d, c
	ld e, b
	pop bc
	farcall Func_12c0ce
	jp IncreaseScriptPointerBy5

ScriptCommand_ShowCardReceivedScreen:
	call Get2ScriptArgs_IncrIndexBy1
	ld e, c
	ld d, b
	farcall Func_1022a
	call Func_c63e
	farcall Func_10252
	call WaitPalFading
	jp IncreaseScriptPointerBy3

ScriptCommand_SetPlayerPosition:
	call Get2ScriptArgs_IncrIndexBy1
	ld d, c
	ld e, b
	ld a, [wPlayerOWObject]
	farcall SetOWObjectTilePosition
	jp IncreaseScriptPointerBy3

ScriptCommand_SetActiveNPCPosition:
	call Get2ScriptArgs_IncrIndexBy1
	ld d, c
	ld e, b
	ld a, [wScriptNPC]
	farcall SetOWObjectTilePosition
	jp IncreaseScriptPointerBy3

ScriptCommand_SetScrollState:
	call Get1ScriptArg_IncrIndexBy1
	farcall SetOWScrollState
	jp IncreaseScriptPointerBy2

ScriptCommand_ScrollToPosition:
	call Get2ScriptArgs_IncrIndexBy1
	sla c
	sla b
	ld d, c
	ld e, b
	farcall Func_104ad
.delay_loop
	call DoFrame
	farcall CheckOWScroll
	or a
	jr nz, .delay_loop
	jp IncreaseScriptPointerBy3

ScriptCommand_SetActiveNPC:
	call Get1ScriptArg_IncrIndexBy1
	ld [wScriptNPC], a
	call Get2ScriptArgs_IncrIndexBy2
	ld a, c
	ld [wScriptNPCName], a
	ld a, b
	ld [wScriptNPCName + 1], a
	jp IncreaseScriptPointerBy4

ScriptCommand_SetPlayerPositionAndDirection:
	call Get2ScriptArgs_IncrIndexBy1
	ld d, c
	ld e, b
	ld a, [wPlayerOWObject]
	farcall SetOWObjectTilePosition
	call Get1ScriptArg_IncrIndexBy3
	ld b, a
	ld a, [wPlayerOWObject]
	farcall SetOWObjectDirection
	jp IncreaseScriptPointerBy4

ScriptCommand_SetNPCPositionAndDirection:
	call Get1ScriptArg_IncrIndexBy1
	push af
	call Get2ScriptArgs_IncrIndexBy2
	ld d, c
	ld e, b
	pop af
	push af
	farcall SetOWObjectTilePosition
	call Get1ScriptArg_IncrIndexBy4
	ld b, a
	pop af
	farcall SetOWObjectDirection
	jp IncreaseScriptPointerBy5

ScriptCommand_FadeIn:
	call Get2ScriptArgs_IncrIndexBy1
	ld a, b
	ld b, c
	farcall StartPalFadeFromBlackOrWhite
	jp IncreaseScriptPointerBy3

ScriptCommand_FadeOut:
	call Get2ScriptArgs_IncrIndexBy1
	ld a, b
	ld b, c
	farcall StartPalFadeToBlackOrWhite
	jp IncreaseScriptPointerBy3

ScriptCommand_SetNPCDirection:
	call Get2ScriptArgs_IncrIndexBy1
	ld a, c
	farcall SetOWObjectDirection
	jp IncreaseScriptPointerBy3

ScriptCommand_SetNPCPosition:
	call Get1ScriptArg_IncrIndexBy1
	push af
	call Get2ScriptArgs_IncrIndexBy2
	ld d, c
	ld e, b
	pop af
	farcall SetOWObjectTilePosition
	jp IncreaseScriptPointerBy4

ScriptCommand_SetActiveNPCPositionAndDirection:
	call Get2ScriptArgs_IncrIndexBy1
	ld d, c
	ld e, b
	ld a, [wScriptNPC]
	farcall SetOWObjectTilePosition
	call Get1ScriptArg_IncrIndexBy3
	ld b, a
	ld a, [wScriptNPC]
	farcall SetOWObjectDirection
	jp IncreaseScriptPointerBy4

ScriptCommand_AnimatePlayerMovement:
	call Get2ScriptArgs_IncrIndexBy1
	ld a, b
	ld b, c
	ld c, a
	ld a, [wPlayerOWObject]
	farcall StartOWObjectAnimation
	farcall ResetOWObjectFlag5_WithID
	farcall Func_10e3c
.delay_loop
	call DoFrame
	ld a, [wPlayerOWObject]
	farcall GetOWObjectSpriteAnimFlags
	bit 5, a
	jr nz, .delay_loop
	ld a, [wPlayerOWObject]
	farcall StopOWObjectAnimation
	farcall SetOWObjectFlag5_WithID
	jp IncreaseScriptPointerBy3

ScriptCommand_AnimateNPCMovement:
	call Get1ScriptArg_IncrIndexBy1
	push af
	call Get2ScriptArgs_IncrIndexBy2
	ld a, b
	ld b, c
	ld c, a
	pop af
	push af
	farcall Func_10e3c
.delay_loop
	call DoFrame
	pop af
	push af
	farcall GetOWObjectSpriteAnimFlags
	bit 5, a
	jr nz, .delay_loop
	pop af
	jp IncreaseScriptPointerBy4

ScriptCommand_AnimateActiveNPCMovement:
	call Get2ScriptArgs_IncrIndexBy1
	ld a, b
	ld b, c
	ld c, a
	ld a, [wScriptNPC]
	farcall Func_10e3c
.delay_loop
	call DoFrame
	ld a, [wScriptNPC]
	farcall GetOWObjectSpriteAnimFlags
	bit 5, a
	jr nz, .delay_loop
	jp IncreaseScriptPointerBy3

ScriptCommand_MovePlayer:
	call Get2ScriptArgs_IncrIndexBy1
	ld l, c
	ld h, b
	ld a, [wScriptBank]
	ld b, a
	ld a, [wPlayerOWObject]
	farcall MoveNPC
	farcall ResetOWObjectFlag5_WithID
	call Get1ScriptArg_IncrIndexBy3
	or a
	jr z, .not_set
	ld a, [wPlayerOWObject]
	farcall StartOWObjectAnimation
.not_set
	jp IncreaseScriptPointerBy4

ScriptCommand_MoveNPC:
	call Get1ScriptArg_IncrIndexBy1
	push af
	call Get2ScriptArgs_IncrIndexBy2
	ld l, c
	ld h, b
	ld a, [wScriptBank]
	ld b, a
	pop af
	farcall MoveNPC
	jp IncreaseScriptPointerBy4

ScriptCommand_MoveActiveNPC:
	call Get2ScriptArgs_IncrIndexBy1
	ld l, c
	ld h, b
	ld a, [wScriptBank]
	ld b, a
	ld a, [wScriptNPC]
	farcall MoveNPC
	jp IncreaseScriptPointerBy3

ScriptCommand_StartDuel:
	call Get2ScriptArgs_IncrIndexBy1
	ld a, c
	ld [wNPCDuelDeckID], a
	ld a, b
	ld [wDuelStartTheme], a
	ld hl, wOverworldTransition
	set 1, [hl]
	jp IncreaseScriptPointerBy3

ScriptCommand_WaitForPlayerAnimation:
	call Func_3340
	jp IncreaseScriptPointerBy1

ScriptCommand_WaitForFade:
	call WaitPalFading
	jp IncreaseScriptPointerBy1

ScriptCommand_GetCardCountInCollectionAndDecks:
	call Get2ScriptArgs_IncrIndexBy1
	ld e, c
	ld d, b
	call GetCardCountInCollectionAndDecks
	ld [wScriptLoadedVar], a
	jr c, .set
; reset
	ld hl, wScriptFlags
	res 0, [hl]
	jr .done
.set
	ld hl, wScriptFlags
	set 0, [hl]
.done
	jp IncreaseScriptPointerBy3

ScriptCommand_GetCardCountInCollection:
	call Get2ScriptArgs_IncrIndexBy1
	ld e, c
	ld d, b
	call GetCardCountInCollection
	ld [wScriptLoadedVar], a
	jr c, .set
	ld hl, wScriptFlags
; reset
	res 0, [hl]
	jr .done
.set
	ld hl, wScriptFlags
	set 0, [hl]
.done
	jp IncreaseScriptPointerBy3

ScriptCommand_GiveCard:
	call Get2ScriptArgs_IncrIndexBy1
	ld e, c
	ld d, b
	call AddCardToCollection
	jp IncreaseScriptPointerBy3

ScriptCommand_TakeCard:
	call Get2ScriptArgs_IncrIndexBy1
	ld e, c
	ld d, b
	call RemoveCardFromCollection
	jp IncreaseScriptPointerBy3

ScriptCommand_NPCAskQuestion:
	call Get2ScriptArgs_IncrIndexBy1
	ld l, c
	ld h, b
	push hl
	ld hl, wScriptNPCName
	ld a, [hli]
	ld d, [hl]
	ld e, a
	push de
	call Get1ScriptArg_IncrIndexBy3
	pop de
	pop hl
	farcall PrintScrollableText_WithTextBoxLabelWithYesOrNoMenu
	ld hl, wScriptFlags
	or a
	jr nz, .reset
; set
	set 0, [hl]
	jp IncreaseScriptPointerBy4
.reset
	res 0, [hl]
	jp IncreaseScriptPointerBy4

ScriptCommand_GetPlayerDirection:
	ld a, [wPlayerOWObject]
	farcall GetOWObjectAnimStruct1Flag0And1
	ld a, b
	ld [wScriptLoadedVar], a
	jp IncreaseScriptPointerBy1

ScriptCommand_CompareVar:
	call Get1ScriptArg_IncrIndexBy1
	call GetVarValue
	push af
	call Get1ScriptArg_IncrIndexBy2
	ld c, a
	pop af
	cp c
	push af
	ld hl, wScriptFlags
	jr z, .equal
; not equal
	res 0, [hl]
	jr .bit0_done
.equal
	set 0, [hl]
.bit0_done
	pop af
	jr c, .carry
; no carry
	res 1, [hl]
	jr .bit1_done
.carry
	set 1, [hl]
.bit1_done
	jp IncreaseScriptPointerBy3

ScriptCommand_GetActiveNPCDirection:
	ld a, [wScriptNPC]
	farcall GetOWObjectAnimStruct1Flag0And1
	ld a, b
	ld [wScriptLoadedVar], a
	jp IncreaseScriptPointerBy1

ScriptCommand_ScrollToActiveNPC:
	ld a, [wScriptNPC]
	farcall SetOWObjectAsScrollTarget
	ld a, 1
	farcall SetOWScrollState
	jp IncreaseScriptPointerBy1

ScriptCommand_ScrollToPlayer:
	ld a, [wPlayerOWObject]
	farcall SetOWObjectAsScrollTarget
	ld a, 1
	farcall SetOWScrollState
	jp IncreaseScriptPointerBy1

ScriptCommand_ScrollToNPC:
	call Get1ScriptArg_IncrIndexBy1
	farcall SetOWObjectAsScrollTarget
	ld a, 1
	farcall SetOWScrollState
	jp IncreaseScriptPointerBy2

ScriptCommand_SpinActiveNPC:
	call Get2ScriptArgs_IncrIndexBy1
	ld d, b
	ld e, c
.delay_loop_d
	ld c, 4
.delay_loop_c
	push de
.delay_loop_e
	call DoFrame
	dec e
	jr nz, .delay_loop_e
	ld a, [wScriptNPC]
	farcall GetOWObjectAnimStruct1Flag0And1
	inc b
	ld a, b
	and 3
	ld b, a
	ld a, [wScriptNPC]
	farcall SetOWObjectDirection
	pop de
	dec c
	jr nz, .delay_loop_c
	dec d
	jr nz, .delay_loop_d
	jp IncreaseScriptPointerBy3

ScriptCommand_RestoreActiveNPCDirection:
	ld a, [wScriptLoadedVar]
	ld b, a
	ld a, [wScriptNPC]
	farcall SetOWObjectDirection
	jp IncreaseScriptPointerBy1

ScriptCommand_SpinActiveNPCReverse:
	call Get2ScriptArgs_IncrIndexBy1
	ld d, b
	ld e, c
.delay_loop_d
	ld c, 4
.delay_loop_c
	push de
.delay_loop_e
	call DoFrame
	dec e
	jr nz, .delay_loop_e
	ld a, [wScriptNPC]
	farcall GetOWObjectAnimStruct1Flag0And1
	dec b
	ld a, b
	and 3
	ld b, a
	ld a, [wScriptNPC]
	farcall SetOWObjectDirection
	pop de
	dec c
	jr nz, .delay_loop_c
	dec d
	jr nz, .delay_loop_d
	jp IncreaseScriptPointerBy3

ScriptCommand_ResetNPCFlag6:
	call Get1ScriptArg_IncrIndexBy1
	farcall ResetOWObjectSpriteAnimFlag6
	jp IncreaseScriptPointerBy2

ScriptCommand_SetNPCFlag6:
	call Get1ScriptArg_IncrIndexBy1
	farcall SetOWObjectSpriteAnimFlag6
	jp IncreaseScriptPointerBy2

ScriptCommand_DuelRequirementCheck:
	call ResetDuelDeckRequirementStatus
	call Get1ScriptArg_IncrIndexBy1
	ld hl, DuelRequirementFunctionMap
	call ExecuteNPCScript
	jp IncreaseScriptPointerBy2

ResetDuelDeckRequirementStatus:
	ld hl, wScriptFlags
	res 1, [hl]
	ret

DuelDeckRequirementFailed:
	ld hl, wScriptFlags
	set 1, [hl]
	ret

; GR Grass
DuelMiyukiRequirement:
	ld a, STICKY_POISON_GAS_DECK_ID
	jp CheckDuelDeckRequirementWithNPCDeckID

; GR Lightning
DuelRennaRequirement:
	ld a, CHAIN_LIGHTNING_BY_PIKACHU_DECK_ID
	jp CheckDuelDeckRequirementWithNPCDeckID

DuelIchikawaRequirement:
	ld a, THIS_IS_THE_POWER_OF_ELECTRICITY_DECK_ID
	jr CheckDuelDeckRequirementWithNPCDeckID

; GR Fire
DuelYukiRequirement:
	ld a, FIREBALL_DECK_ID
	jr CheckDuelDeckRequirementWithNPCDeckID

DuelShokoRequirement:
	ld a, EEVEE_SHOWDOWN_DECK_ID
	jr CheckDuelDeckRequirementWithNPCDeckID

; GR Water
DuelMiyajimaRequirement:
	ld a, WHIRLPOOL_SHOWER_DECK_ID
	jr CheckDuelDeckRequirementWithNPCDeckID

DuelSentaRequirement:
	ld a, PARALYZED_PARALYZED_DECK_ID
	jr CheckDuelDeckRequirementWithNPCDeckID

; GR Fighting
DuelGodaRequirement:
	ld a, ROCK_BLAST_DECK_ID
	jr CheckDuelDeckRequirementWithNPCDeckID

DuelGraceRequirement:
	ld a, FULL_STRENGTH_DECK_ID
	jr CheckDuelDeckRequirementWithNPCDeckID

; GR Psychic
DuelMiwaRequirement:
	ld a, DIRECT_HIT_DECK_ID
	jr CheckDuelDeckRequirementWithNPCDeckID

DuelYosukeRequirement:
	ld a, BAD_DREAM_DECK_ID
	jr CheckDuelDeckRequirementWithNPCDeckID

DuelRyokoRequirement:
	ld a, POKEMON_POWER_DECK_ID
	jr CheckDuelDeckRequirementWithNPCDeckID

; GR Castle
DuelKanzakiRequirement:
	ld a, BAD_GUYS_DECK_ID
	jr CheckDuelDeckRequirementWithNPCDeckID

; Colorless Altar
DuelNishijimaRequirement_Reroll:
	ld a, 3
	call Random
	ld c, a
	ld e, a
	ld a, VAR_05
	call SetVarValue
	ld a, SNORLAX_GUARD_DECK_ID
	jr CheckDuelDeckRequirementWithNPCDeckID_TxRam2

DuelNishijimaRequirement_Use:
	ld a, VAR_05
	call GetVarValue
	ld e, a
	ld a, SNORLAX_GUARD_DECK_ID
	jr CheckDuelDeckRequirementWithNPCDeckID_TxRam2

DuelIshiiRequirement_Reroll:
	ld a, 3
	call Random
	ld c, a
	ld e, a
	ld a, VAR_06
	call SetVarValue
	ld a, EYE_OF_THE_STORM_DECK_ID
	jr CheckDuelDeckRequirementWithNPCDeckID_TxRam2

DuelIshiiRequirement_Use:
	ld a, VAR_06
	call GetVarValue
	ld e, a
	ld a, EYE_OF_THE_STORM_DECK_ID
	jr CheckDuelDeckRequirementWithNPCDeckID_TxRam2

DuelSamejimaRequirement_Reroll:
	ld a, 3
	call Random
	ld c, a
	ld e, a
	ld a, VAR_07
	call SetVarValue
	ld a, SUDDEN_GROWTH_DECK_ID
	jr CheckDuelDeckRequirementWithNPCDeckID_TxRam2

DuelSamejimaRequirement_Use:
	ld a, VAR_07
	call GetVarValue
	ld e, a
	ld a, SUDDEN_GROWTH_DECK_ID
	jr CheckDuelDeckRequirementWithNPCDeckID_TxRam2

CheckDuelDeckRequirementWithNPCDeckID:
	farcall LoadDeckIDData
	xor a
	ld e, a
	farcall CheckDuelDeckRequirement
	call c, DuelDeckRequirementFailed
	ret

CheckDuelDeckRequirementWithNPCDeckID_TxRam2:
	push de
	farcall LoadDeckIDData
	pop de
	farcall CheckDuelDeckRequirement
	push af
	call LoadTxRam2
	ld a, l
	ld [wTxRam2_b], a
	ld a, h
	ld [wTxRam2_b + 1], a
	pop af
	call c, DuelDeckRequirementFailed
	ret

DuelRequirementFunctionMap:
	key_func DUEL_REQUIREMENT_MIYUKI, DuelMiyukiRequirement
	key_func DUEL_REQUIREMENT_RENNA, DuelRennaRequirement
	key_func DUEL_REQUIREMENT_ICHIKAWA, DuelIchikawaRequirement
	key_func DUEL_REQUIREMENT_YUKI, DuelYukiRequirement
	key_func DUEL_REQUIREMENT_SHOKO, DuelShokoRequirement
	key_func DUEL_REQUIREMENT_MIYAJIMA, DuelMiyajimaRequirement
	key_func DUEL_REQUIREMENT_SENTA, DuelSentaRequirement
	key_func DUEL_REQUIREMENT_GODA, DuelGodaRequirement
	key_func DUEL_REQUIREMENT_GRACE, DuelGraceRequirement
	key_func DUEL_REQUIREMENT_MIWA, DuelMiwaRequirement
	key_func DUEL_REQUIREMENT_YOSUKE, DuelYosukeRequirement
	key_func DUEL_REQUIREMENT_RYOKO, DuelRyokoRequirement
	key_func DUEL_REQUIREMENT_NISHIJIMA_REROLL, DuelNishijimaRequirement_Reroll
	key_func DUEL_REQUIREMENT_NISHIJIMA_USE, DuelNishijimaRequirement_Use
	key_func DUEL_REQUIREMENT_ISHII_REROLL, DuelIshiiRequirement_Reroll
	key_func DUEL_REQUIREMENT_ISHII_USE, DuelIshiiRequirement_Use
	key_func DUEL_REQUIREMENT_SAMEJIMA_REROLL, DuelSamejimaRequirement_Reroll
	key_func DUEL_REQUIREMENT_SAMEJIMA_USE, DuelSamejimaRequirement_Use
	key_func DUEL_REQUIREMENT_KANZAKI, DuelKanzakiRequirement
	db $ff

ScriptCommand_GetActiveNPCOppositeDirection:
	ld a, [wScriptNPC]
	farcall GetOWObjectAnimStruct1Flag0And1
	ld a, b
	xor SPRITE_ANIM_STRUCT1_FLAG1
	ld [wScriptLoadedVar], a
	jp IncreaseScriptPointerBy1

ScriptCommand_GetPlayerOppositeDirection:
	ld a, [wPlayerOWObject]
	farcall GetOWObjectAnimStruct1Flag0And1
	ld a, b
	xor SPRITE_ANIM_STRUCT1_FLAG1
	ld [wScriptLoadedVar], a
	jp IncreaseScriptPointerBy1

ScriptCommand_PlaySFX:
	call Get1ScriptArg_IncrIndexBy1
	call PlaySFX
	jp IncreaseScriptPointerBy2

ScriptCommand_PlaySFXAndWait:
	call Get1ScriptArg_IncrIndexBy1
	call PlaySFX
	farcall WaitForSFXToFinish
	jp IncreaseScriptPointerBy2

ScriptCommand_SetTextRAM2:
	call Get2ScriptArgs_IncrIndexBy1
	ld l, c
	ld h, b
	call LoadTxRam2
	jp IncreaseScriptPointerBy3

ScriptCommand_SetVariableTextRAM2:
	ld hl, wScriptFlags
	bit 0, [hl]
	jr z, .use_text_2
; use text 1
	call Get2ScriptArgs_IncrIndexBy1
	jr .next
.use_text_2
	call Get2ScriptArgs_IncrIndexBy3
.next
	ld l, c
	ld h, b
	call LoadTxRam2
	jp IncreaseScriptPointerBy5

ScriptCommand_WaitForNPCAnimation:
	call Get1ScriptArg_IncrIndexBy1
	call WaitForOWObjectAnimation
	jp IncreaseScriptPointerBy2

ScriptCommand_GetPlayerXPosition:
	ld a, [wPlayerOWObject]
	farcall GetOWObjectTilePosition
	ld a, d
	ld [wScriptLoadedVar], a
	jp IncreaseScriptPointerBy1

ScriptCommand_GetPlayerYPosition:
	ld a, [wPlayerOWObject]
	farcall GetOWObjectTilePosition
	ld a, e
	ld [wScriptLoadedVar], a
	jp IncreaseScriptPointerBy1

ScriptCommand_RestoreNPCDirection:
	call Get1ScriptArg_IncrIndexBy1
	push af
	ld a, [wScriptLoadedVar]
	ld b, a
	pop af
	farcall SetOWObjectDirection
	jp IncreaseScriptPointerBy2

ScriptCommand_SpinNPC:
	call Get1ScriptArg_IncrIndexBy1
	push af
	call Get2ScriptArgs_IncrIndexBy2
	ld d, b
	ld e, c
	pop af
.delay_loop_d
	ld c, 4
.delay_loop_c
	push de
	push af
.delay_loop_e
	call DoFrame
	dec e
	jr nz, .delay_loop_e
	farcall GetOWObjectAnimStruct1Flag0And1
	inc b
	ld a, b
	and 3
	ld b, a
	pop af
	farcall SetOWObjectDirection
	pop de
	dec c
	jr nz, .delay_loop_c
	dec d
	jr nz, .delay_loop_d
	jp IncreaseScriptPointerBy4

ScriptCommand_SpinNPCReverse:
	call Get1ScriptArg_IncrIndexBy1
	push af
	call Get2ScriptArgs_IncrIndexBy2
	ld d, b
	ld e, c
	pop af
.delay_loop_d
	ld c, 4
.delay_loop_c
	push de
	push af
.delay_loop_e
	call DoFrame
	dec e
	jr nz, .delay_loop_e
	farcall GetOWObjectAnimStruct1Flag0And1
	dec b
	ld a, b
	and 3
	ld b, a
	pop af
	farcall SetOWObjectDirection
	pop de
	dec c
	jr nz, .delay_loop_c
	dec d
	jr nz, .delay_loop_d
	jp IncreaseScriptPointerBy4

ScriptCommand_PushVar:
	ld hl, wScriptStack
	ld a, [wScriptStackOffset]
	dec a
	ld [wScriptStackOffset], a
	add_hl_a
	ld a, [wScriptLoadedVar]
	ld [hl], a
	jp IncreaseScriptPointerBy1

ScriptCommand_PopVar:
	ld hl, wScriptStack
	ld a, [wScriptStackOffset]
	push af
	add_hl_a
	ld a, [hl]
	ld [wScriptLoadedVar], a
	pop af
	inc a
	ld [wScriptStackOffset], a
	jp IncreaseScriptPointerBy1

ScriptCommand_ScriptCall:
	call Get1ScriptArg_IncrIndexBy3
	ld hl, wScriptFlags
	cp b0nz
	jr z, .b0nz
	cp b0z
	jr z, .b0z
	cp b1nz
	jr z, .b1nz
	cp b1z
	jr z, .b1z
	jr .do_call
.b0nz
	bit 0, [hl]
	jr nz, .do_call
	jr .skip_call
.b0z
	bit 0, [hl]
	jr z, .do_call
	jr .skip_call
.b1nz
	bit 1, [hl]
	jr nz, .do_call
	jr .skip_call
.b1z
	bit 1, [hl]
	jr z, .do_call
.skip_call
	jp IncreaseScriptPointerBy4
.do_call
	call Get2ScriptArgs_IncrIndexBy1
	push bc
	call IncreaseScriptPointerBy4
	ld hl, wScriptStack
	ld a, [wScriptStackOffset]
	dec a
	dec a
	ld [wScriptStackOffset], a
	add_hl_a
	ld a, [wScriptPointer]
	ld [hli], a
	ld a, [wScriptPointer + 1]
	ld [hl], a
	pop bc
	ld a, c
	ld [wScriptPointer], a
	ld a, b
	ld [wScriptPointer + 1], a
	call ReloadScriptBuffer
	jp ReloadScriptBuffer_Done

ScriptCommand_ScriptRet:
	ld hl, wScriptStack
	ld a, [wScriptStackOffset]
	inc a
	inc a
	ld [wScriptStackOffset], a
	add_hl_a
	dec hl
	ld a, [hld]
	ld [wScriptPointer + 1], a
	ld a, [hl]
	ld [wScriptPointer], a
	call ReloadScriptBuffer
	jp ReloadScriptBuffer_Done

ScriptCommand_GiveCoin:
	call Get1ScriptArg_IncrIndexBy1
	farcall GiveCoin
	call WaitPalFading
	jp IncreaseScriptPointerBy2

ScriptCommand_BackupActiveNPC:
	ld a, [wScriptNPC]
	ld [wScriptLoadedVar], a
	jp IncreaseScriptPointerBy1

ScriptCommand_LoadPlayer:
	call Get2ScriptArgs_IncrIndexBy1
	ld d, c
	ld e, b
	push de
	call Get1ScriptArg_IncrIndexBy3
	ld b, a
	pop de
	ld a, [wPlayerOWObject]
	farcall LoadOWObjectInMap
	jp IncreaseScriptPointerBy4

ScriptCommand_UnloadPlayer:
	ld a, [wPlayerOWObject]
	farcall ClearOWObject
	jp IncreaseScriptPointerBy1

ScriptCommand_GiveBoosterPacks:
	call Get2ScriptArgs_IncrIndexBy1
	ld l, c
	ld h, b
	ld a, [hli]
	cp BOOSTERS_GIVE_ALL
	jr z, .give_all
	cp BOOSTERS_GIVE_N
	jr z, .give_n
	cp BOOSTERS_GIVE_RANDOM
	jr z, .give_random
	jp IncreaseScriptPointerBy3

; give all boosters in the list, by first counting the length of the list
.give_all
	push hl
	xor a
	ld c, a
.loop_count_length
	ld a, [hli]
	cp $ff
	jr z, .counted_length
	inc c
	jr .loop_count_length
.counted_length
	pop hl
	ld a, c
	ld [wNumBoosterPacksToGive], a ; = list size
	jr .give_boosters

.give_random
	ld a, [hli] ; read N before the list
	call Random
	inc a
	ld [wNumBoosterPacksToGive], a ; = random [1,N]
	jr .copy
.give_n
	ld a, [hli] ; read N before the list
	ld [wNumBoosterPacksToGive], a ; = N
.copy
	ld de, wBoosterPackList
	xor a
	ld c, a
.loop_copy_and_count
	ld a, [hli]
	cp $ff
	jr z, .copied_and_counted
	ld [de], a
	inc de
	inc c
	jr .loop_copy_and_count

.copied_and_counted
	ld a, c
	ld [wBoosterPackCount], a ; = list size
	ld de, wBoosterPacksToGive
	ld a, [wNumBoosterPacksToGive]
	ld c, a
.loop_random_copy
	ld a, [wBoosterPackCount]
	call Random
	ld hl, wBoosterPackList
	add_hl_a
	ld a, [hl]
	ld [de], a
	inc de
	dec c
	jr nz, .loop_random_copy

	ld a, [wNumBoosterPacksToGive]
	ld c, a
.sort
	ld a, [wNumBoosterPacksToGive]
	ld b, a
	ld hl, wBoosterPacksToGive
	ld de, wBoosterPacksToGive
	inc de
.loop_sort
	dec b
	jr z, .consumed_count
	ld a, [de]
	cp [hl]
	jr c, .skip_swap
	ld a, [de]
	push af
	ld a, [hl]
	ld [de], a
	pop af
	ld [hl], a
.skip_swap
	inc hl
	inc de
	jr .loop_sort
.consumed_count
	dec c
	jr nz, .sort

	ld hl, wBoosterPacksToGive
.give_boosters
	farcall Func_1022a
	ld a, [wNumBoosterPacksToGive]
	ld c, a
	xor a
	ld b, a
.loop_boosters
	ld a, [hli]
	farcall GiveBoosterPacks
	inc b
	dec c
	jr nz, .loop_boosters
	farcall Func_10252
	call WaitPalFading
	jp IncreaseScriptPointerBy3

ScriptCommand_GetRandom:
	call Get1ScriptArg_IncrIndexBy1
	call Random
	ld [wScriptLoadedVar], a
	jp IncreaseScriptPointerBy2

ScriptCommand_OpenMenu:
	ld a, OWMODE_PAUSE_MENU
	call ExecuteOWModeScript
	jp IncreaseScriptPointerBy1

ScriptCommand_SetTextRAM3:
	call Get2ScriptArgs_IncrIndexBy1
	ld l, c
	ld h, b
	call LoadTxRam3
	jp IncreaseScriptPointerBy3

ScriptCommand_QuitScript:
	ld a, [wScriptFlags]
	set 6, a
	ld [wScriptFlags], a
	jp IncreaseScriptPointerBy1

ScriptCommand_PlaySong:
	call PauseSong
	call Get1ScriptArg_IncrIndexBy1
	call PlaySong
	jp IncreaseScriptPointerBy2

ScriptCommand_ResumeSong:
	call ResumeSong
	jp IncreaseScriptPointerBy1

ScriptCommand_ScriptCallfar:
	call Get1ScriptArg_IncrIndexBy3
	push af
	call Get2ScriptArgs_IncrIndexBy1
	push bc
	call IncreaseScriptPointerBy4
	ld hl, wScriptStack
	ld a, [wScriptStackOffset]
	dec a
	dec a
	dec a
	ld [wScriptStackOffset], a
	add_hl_a
	ld a, [wScriptPointer]
	ld [hli], a
	ld a, [wScriptPointer + 1]
	ld [hli], a
	ld a, [wScriptBank]
	ld [hl], a
	pop bc
	ld a, c
	ld [wScriptPointer], a
	ld a, b
	ld [wScriptPointer + 1], a
	pop af
	ld [wScriptBank], a
	call ReloadScriptBuffer
	jp ReloadScriptBuffer_Done

ScriptCommand_ScriptRetfar:
	ld hl, wScriptStack
	ld a, [wScriptStackOffset]
	inc a
	inc a
	inc a
	ld [wScriptStackOffset], a
	add_hl_a
	dec hl
	ld a, [hld]
	ld [wScriptBank], a
	ld a, [hld]
	ld [wScriptPointer + 1], a
	ld a, [hl]
	ld [wScriptPointer], a
	call ReloadScriptBuffer
	jp ReloadScriptBuffer_Done

ScriptCommand_CardPop:
	call Get1ScriptArg_IncrIndexBy1
	farcall Func_1f7f1
	call WaitPalFading
	jp IncreaseScriptPointerBy2

ScriptCommand_PlaySongNext:
	call Get1ScriptArg_IncrIndexBy1
	farcall PlayAfterCurrentSong
	jp IncreaseScriptPointerBy2

ScriptCommand_SetTextRAM2b:
	call Get2ScriptArgs_IncrIndexBy1
	ld a, c
	ld [wTxRam2_b], a
	ld a, b
	ld [wTxRam2_b + 1], a
	jp IncreaseScriptPointerBy3

ScriptCommand_SetVariableTextRAM2b:
	ld hl, wScriptFlags
	bit 0, [hl]
	jr z, .use_text_2
; use text 1
	call Get2ScriptArgs_IncrIndexBy1
	jr .next
.use_text_2
	call Get2ScriptArgs_IncrIndexBy3
.next
	ld a, c
	ld [wTxRam2_b], a
	ld a, b
	ld [wTxRam2_b + 1], a
	jp IncreaseScriptPointerBy5

ScriptCommand_ReplaceNPC:
	call Get1ScriptArg_IncrIndexBy1
	farcall GetOWObjectTilePosition
	push de
	farcall GetOWObjectAnimStruct1Flag0And1
	push bc
	farcall ClearOWObject
	call Get1ScriptArg_IncrIndexBy2
	pop bc
	pop de
	farcall LoadOWObjectInMap
	jp IncreaseScriptPointerBy3

; for the buffer value n,
; - if n = 0 or n >= NUM_UNIQUE_MAILS_IN_GAME, skip
; - else, set bit (m-1) of [dw hl] and AddMailToQueue, where
;   - hl = wSentMailBitfield and m = n    if 0 < n <= 16,
;   - hl = wSentMailBitfield + 2 and m = n-16 if 16 < n < NUM_UNIQUE_MAILS_IN_GAME,
; then IncreaseScriptPointerBy2
ScriptCommand_SendMail:
	call Get1ScriptArg_IncrIndexBy1
	or a
	jr z, .done ; 0 is an invalid mail number

	cp NUM_UNIQUE_MAILS_IN_GAME
	jr nc, .done ; mail > NUM_UNIQUE_MAILS_IN_GAME is another invalid mail number

	ld hl, wSentMailBitfield
	cp $10 + 1
	jr c, .set_bitfield
	inc hl
	inc hl ; wSentMailBitfield + 2
	sub $10
.set_bitfield
	ld de, 1
.set_bitfield_loop
	dec a
	jr z, .got_bitfield
	sla e
	rl d
	jr .set_bitfield_loop
.got_bitfield
	ld a, [hli] ; wSentMailBitfield or wSentMailBitfield + 2
	ld c, a
	ld a, [hld]
	ld b, a
	ld a, c
	and e
	jr nz, .checked_bit
	ld a, b
	and d
.checked_bit
	; if the bit is set then we have already sent this mail before. do not send again
	jr nz, .done

	; if we got here, this mail has never been sent before.
	; set the appropriate bit in the bitfield, and send the mail
	ld a, c
	or e
	ld c, a
	ld a, b
	or d
	ld b, a
	ld a, c
	ld [hli], a
	ld [hl], b
	call Get1ScriptArg_IncrIndexBy1
	farcall AddMailToQueue
.done
	jp IncreaseScriptPointerBy2

ScriptCommand_CheckNPCLoaded:
	call Get1ScriptArg_IncrIndexBy1
	farcall CheckOWObjectPointerWithID
	ld hl, wScriptFlags
	jr nz, .valid
; invalid
	set 1, [hl]
	jp IncreaseScriptPointerBy2
.valid
	res 1, [hl]
	jp IncreaseScriptPointerBy2

ScriptCommand_GiveDeck:
	call Get1ScriptArg_IncrIndexBy1
	farcall Func_1acbf
	ld hl, wScriptFlags
	jr c, .invalid
; valid
	res 1, [hl]
	jp IncreaseScriptPointerBy2
.invalid
	set 1, [hl]
	jp IncreaseScriptPointerBy2

ScriptCommand_67:
	call Get2ScriptArgs_IncrIndexBy1
	ld a, c
	ld c, b
	farcall Set3FromwDD75
	jp IncreaseScriptPointerBy3

ScriptCommand_68:
.delay_loop
	call DoFrame
	farcall GetwDD75
	jr nz, .delay_loop
	jp IncreaseScriptPointerBy1

ScriptCommand_PrintNPCTextInstant:
	call Get2ScriptArgs_IncrIndexBy1
	ld hl, wScriptNPCName
	ld a, [hli]
	ld d, [hl]
	ld e, a
	ld l, c
	ld h, b
	farcall PrintTextInLabelledScrollableTextBox
	jp IncreaseScriptPointerBy3

ScriptCommand_VarAdd:
	call Get2ScriptArgs_IncrIndexBy1
	ld a, c
	call GetVarValue
	add b
	ld b, a
	ld a, c
	ld c, b
	call SetVarValue
	jp IncreaseScriptPointerBy3

ScriptCommand_VarSub:
	call Get2ScriptArgs_IncrIndexBy1
	ld a, c
	call GetVarValue
	sub b
	ld b, a
	ld a, c
	ld c, b
	call SetVarValue
	jp IncreaseScriptPointerBy3

ScriptCommand_ReceiveCard:
	call Get2ScriptArgs_IncrIndexBy1
	ld e, c
	ld d, b
	farcall Func_1022a
	call Func_c646
	farcall Func_10252
	call WaitPalFading
	jp IncreaseScriptPointerBy3

ScriptCommand_GetGameCenterChips:
	farcall GetGameCenterChips
	ld a, c
	ld [wScriptLoadedVar], a
	ld a, b
	ld [wScriptLoadedVar + 1], a
	jp IncreaseScriptPointerBy1

ScriptCommand_CompareLoadedVarWord:
	call Get2ScriptArgs_IncrIndexBy1
	ld a, [wScriptLoadedVar]
	ld e, a
	ld a, [wScriptLoadedVar + 1]
	ld d, a
	ld hl, wScriptFlags
	res 0, [hl]
	res 1, [hl]
	cp16_long bc
	jr nz, .not_equal
	set 0, [hl]
.not_equal
	jr nc, .no_carry
	set 1, [hl]
.no_carry
	jp IncreaseScriptPointerBy3

ScriptCommand_GetGameCenterBankedChips:
	farcall GetGameCenterBankedChips
	ld a, c
	ld [wScriptLoadedVar], a
	ld a, b
	ld [wScriptLoadedVar + 1], a
	jp IncreaseScriptPointerBy1

ScriptCommand_ShowChipsHUD:
	farcall TurnOnCurChipsHUD
	jp IncreaseScriptPointerBy1

ScriptCommand_HideChipsHUD:
	farcall TurnOffCurChipsHUD
	jp IncreaseScriptPointerBy1

ScriptCommand_GiveChips:
	call Get2ScriptArgs_IncrIndexBy1
	farcall IncreaseChipsSmoothly
	jp IncreaseScriptPointerBy3

ScriptCommand_TakeChips:
	call Get2ScriptArgs_IncrIndexBy1
	farcall DecreaseChipsSmoothly
	jp IncreaseScriptPointerBy3

ScriptCommand_LoadTextRAM3:
	ld a, [wScriptLoadedVar]
	ld l, a
	ld a, [wScriptLoadedVar + 1]
	ld h, a
	call LoadTxRam3
	jp IncreaseScriptPointerBy1

ScriptCommand_DepositChips:
	farcall DepositChips
	jp IncreaseScriptPointerBy1

ScriptCommand_WithdrawChips:
	farcall WithdrawChips
	jp IncreaseScriptPointerBy1

ScriptCommand_LinkDuel:
	ld a, EVENT_SET_UNTIL_MAP_RELOAD_2
	call ZeroOutEventValue
	ld hl, wScriptFlags
	res 1, [hl]
	farcall Func_1d99e
	cp $ff
	jr z, .set
	or a
	jr nz, .ok
	ld a, EVENT_SET_UNTIL_MAP_RELOAD_2
	call MaxOutEventValue
	jr .done
.ok
	jr .done
.set
	ld hl, wScriptFlags
	set 1, [hl]
.done
	farcall PlayCurrentSong
	jp IncreaseScriptPointerBy1

ScriptCommand_WaitSong:
	farcall WaitSong
	jp IncreaseScriptPointerBy1

ScriptCommand_LoadPalette:
	call Get2ScriptArgs_IncrIndexBy1
	farcall GetPalettesWithID
	call FlushAllPalettes
	jp IncreaseScriptPointerBy3

ScriptCommand_SetSpriteFrameset:
	call Get1ScriptArg_IncrIndexBy1
	push af
	call Get2ScriptArgs_IncrIndexBy2
	pop af
	farcall SetAndInitOWObjectFrameset
	jp IncreaseScriptPointerBy4

ScriptCommand_WaitSFX:
	farcall WaitForSFXToFinish
	jp IncreaseScriptPointerBy1

ScriptCommand_PrintTextWideTextbox:
	call Get2ScriptArgs_IncrIndexBy1
	ld l, c
	ld h, b
	farcall PrintTextInWideTextBox
	jp IncreaseScriptPointerBy3

ScriptCommand_WaitInput:
	call WaitForWideTextBoxInput
	jp IncreaseScriptPointerBy1

INCLUDE "engine/save.asm"
INCLUDE "data/save.asm"

; a = TCG_ISLAND or GR_ISLAND
; set five opponents for the set
SetChallengeMachineOpponents:
	or a
	jr nz, .gr_machine
	ld a, NUM_TCG_CHALLENGE_MACHINE_OPPONENT_POOL
	ld [wNumRandomDuelists], a
	ld a, LOW(TCGChallengeMachineOpponents)
	ld [wFilteredListPtr], a
	ld a, HIGH(TCGChallengeMachineOpponents)
	ld [wFilteredListPtr + 1], a
	jr .init
.gr_machine
	ld a, NUM_GR_CHALLENGE_MACHINE_OPPONENT_POOL
	ld [wNumRandomDuelists], a
	ld a, LOW(GRChallengeMachineOpponents)
	ld [wFilteredListPtr], a
	ld a, HIGH(GRChallengeMachineOpponents)
	ld [wFilteredListPtr + 1], a
.init
	ld e, NUM_CHALLENGE_MACHINE_ROUNDS_PER_SET
	ld d, VAR_CHALLENGEMACHINE_ROUND1_OPPONENT_DECK_ID
	ld c, $ff
.loop_init
	ld a, d
	call SetVarValue
	inc d
	dec e
	jr nz, .loop_init
; set
; b = 1 << c for c = round number [0, 4]
; set opponents randomly with the bitmask b
	ld c, 0
.loop_set_opponents
	ld b, 1
	ld a, c
	or a
.loop_shift
	jr z, .loop_pick
	sla b
	dec a
	jr .loop_shift
.loop_pick
	call .PickOpponent
	call .CheckDupe
	jr c, .loop_pick
	push bc
	ld d, a
	ld a, VAR_CHALLENGEMACHINE_ROUND1_OPPONENT_DECK_ID
	add c
	ld c, d
	call SetVarValue
	pop bc
	inc c
	ld a, NUM_CHALLENGE_MACHINE_ROUNDS_PER_SET
	cp c
	jr nz, .loop_set_opponents
	ret

; for b = bitmask, choose a random opponent and return their deck id in a
.PickOpponent:
	ld a, [wFilteredListPtr]
	ld l, a
	ld a, [wFilteredListPtr + 1]
	ld h, a
	ld a, [wNumRandomDuelists]
	call Random
	sla a
	add_hl_a
	inc hl
	ld a, [hld]
	and b
	jr z, .PickOpponent
	ld a, [hl]
	ret

; set carry if the opponent is already picked
.CheckDupe:
	ld d, a
	call GetNPCByDeck
	ld l, a
	ld e, VAR_CHALLENGEMACHINE_ROUND1_OPPONENT_DECK_ID
.loop_check
	ld a, e
	call GetVarValue
	cp $ff
	jr z, .done
	call GetNPCByDeck
	inc e
	cp l
	jr nz, .loop_check
	ld a, d
	scf
	ret
.done
	ld a, d
	scf
	ccf
	ret

LoadChallengeMachineOpponentTitlesAndNames:
	ld c, NUM_CHALLENGE_MACHINE_ROUNDS_PER_SET
	ld a, VAR_CHALLENGEMACHINE_ROUND1_OPPONENT_DECK_ID
	ld hl, wChallengeMachineOpponentTitlesAndNames
.loop_load
	push af
	call GetVarValue
	call GetNPCByDeck
	call LoadNPCDuelist
	ld de, wCurrentNPCDuelistData + NPC_DUELIST_STRUCT_TITLE_NAME
	ld a, [de]
	ld [hli], a
	inc de
	ld a, [de]
	ld [hli], a
	ld de, wCurrentNPCDuelistData + NPC_DUELIST_STRUCT_DIALOG_NAME
	ld a, [de]
	ld [hli], a
	inc de
	ld a, [de]
	ld [hli], a
	pop af
	inc a
	dec c
	jr nz, .loop_load
	ret

SetChallengeMachineDuelParams:
	call SaveChallengeMachine
	ld a, VAR_CHALLENGEMACHINE_CURRENT_ROUND
	call GetVarValue
	dec a
	ld c, a
	ld a, VAR_CHALLENGEMACHINE_ROUND1_OPPONENT_DECK_ID
	add c
	call GetVarValue
	ld [wNPCDuelDeckID], a
	ld hl, wOverworldTransition
	set 1, [hl]
	ret

; return bc = prize card id
; at TCGChallengeCupPromoPrizes[VAR_TCG_CHALLENGE_CUP_PRIZE_INDEX]
GetTCGChallengeCupPrizeCardID:
	push af
	push hl
	ld a, VAR_TCG_CHALLENGE_CUP_PRIZE_INDEX
	call GetVarValue
	sla a
	ld hl, TCGChallengeCupPromoPrizes
	add_hl_a
	ld a, [hli]
	ld b, [hl]
	ld c, a
	pop hl
	pop af
	ret

; return hl = prize card name
; at TCGChallengeCupPromoPrizes[VAR_TCG_CHALLENGE_CUP_PRIZE_INDEX]
GetTCGChallengeCupPrizeCardName:
	push af
	push bc
	push de
	call GetTCGChallengeCupPrizeCardID
	ld e, c
	ld d, b
	call GetReceivingCardShortName
	pop de
	pop bc
	pop af
	ret

; return bc = prize card id
; at GRChallengeCupPromoPrizes[VAR_GR_CHALLENGE_CUP_PRIZE_INDEX]
GetGRChallengeCupPrizeCardID:
	push af
	push hl
	ld a, VAR_GR_CHALLENGE_CUP_PRIZE_INDEX
	call GetVarValue
	sla a
	ld hl, GRChallengeCupPromoPrizes
	add_hl_a
	ld a, [hli]
	ld b, [hl]
	ld c, a
	pop hl
	pop af
	ret

; return hl = prize card name
; at GRChallengeCupPromoPrizes[VAR_GR_CHALLENGE_CUP_PRIZE_INDEX]
GetGRChallengeCupPrizeCardName:
	push af
	push bc
	push de
	call GetGRChallengeCupPrizeCardID
	ld e, c
	ld d, b
	call GetReceivingCardLongName
	pop de
	pop bc
	pop af
	ret

Func_f05c:
	push af
	push bc
	push de
	push hl
	farcall Func_1022a
	farcall SetFrameFuncAndFadeFromWhite
	call FlushAllPalettes
	lb de, 2, 1
	ld b, $00
	call Func_f085
	ld b, $08
	call Func_f085
	farcall FadeToWhiteAndUnsetFrameFunc
	farcall Func_10252
	pop hl
	pop de
	pop bc
	pop af
	ret

; b - ?
; de - coordinates
Func_f085:
	push de
	push bc
	ld b, d
	ld c, e
	call BCCoordToBGMap0Address
	pop bc
	ld d, $00
	ld c, $10
.asm_f091
	push bc
	ld c, $10
	push hl
.asm_f095
	xor a
	call BankswitchVRAM
	ei
	di
	call WaitForLCDOff
	ld [hl], d
	ei
	ld a, BANK("VRAM1")
	call BankswitchVRAM
	ei
	di
	call WaitForLCDOff
	xor a
	or b
	ld [hli], a
	ei
	inc d
	dec c
	jr nz, .asm_f095
	pop hl
	ld bc, $20
	add hl, bc
	pop bc
	dec c
	jr nz, .asm_f091
	ld c, PAD_A | PAD_B
	farcall WaitForButtonPress
	pop de
	ret
; 0xf0c3

SECTION "Bank 3@725a", ROMX[$725a], BANK[$3]

DebugMenuEffectViewer:
	push af
	push bc
	push de
	push hl
	farcall SetFadePalsFrameFunc
	xor a
	ld [wAnimationsDisabled], a
	farcall StartFadeToWhite
	farcall WaitPalFading_Bank07
	farcall Func_10d40
	farcall SetInitialGraphicsConfiguration
	lb de, 0, 0
	lb bc, 20, 18
	ld h, $00
	ld l, $00
	farcall FillBoxInBGMap
	lb de, 0, 12
	lb bc, 20, 6
	call DrawRegularTextBoxVRAM0
	call DebugEffectViewer_PlaceTextItems
	call ChangeAnimationPlayerSideOnStartPress.initialize
	call ChangeEffectNumberOnDpadPress.initialize
	call PauseSong_SaveState
	push af
	ld a, MUSIC_DUEL_THEME_CLUB_MEMBER
	call SetMusic
	pop af
	farcall StartFadeFromWhite
	farcall WaitPalFading_Bank07
	ld a, NUM_COINS
	call Random
	ld [wOppCoin], a
.button_handling_loop
	call DoFrame
	call CancelAnimationOnBPress
	call ChangeAnimationPlayerSideOnStartPress
	call ChangeEffectNumberOnDpadPress
	call PlayAnimationOnAPress
	call DebugPrintAnimBufferCurPosAndSize
	call ChangeDebugViewerStateText
	ldh a, [hKeysPressed]
	and PAD_SELECT
	jr z, .button_handling_loop
	call FinishQueuedAnimations
	farcall StartFadeToWhite
	farcall WaitPalFading_Bank07
	call ResumeSong_ClearTemp
	farcall UnsetFadePalsFrameFunc
	pop hl
	pop de
	pop bc
	pop af
	ret

PlayAnimationOnAPress:
	ldh a, [hKeysPressed]
	and PAD_A
	ret z
	ld a, [wDebugSelectedAnimNumber]
	and a
	ret z
	cp DUEL_ANIM_DAMAGE_HUD
	jr z, .play
	cp DUEL_ANIM_DAMAGE_HUD
	ret nc
.play
	call FinishQueuedAnimations
	call ResetAnimationQueue
	ld a, [wDebugSelectedAnimNumber]
	ld [wCurAnimation], a
	ld a, [wDebugDuelAnimationScreen]
	ld [wDuelAnimationScreen], a
	ld a, [wDebugAnimDuelistSide]
	ld [wDuelAnimDuelistSide], a
	ld a, [wDebugDuelAnimLocationParam]
	ld [wDuelAnimLocationParam], a
	ld a, $ff
	call Random ; pick random damage number to show
	ld c, a
	ld b, $00
	ld hl, wDuelAnimDamage
	ld [hl], c
	inc hl
	ld [hl], b
	ld a, %111
	ld [wDuelAnimEffectiveness], a
	call LoadDuelAnimationToBuffer
	ret

DebugEffectViewer_PlaceTextItems:
	ld hl, .text_items
	call PlaceTextItemsVRAM0
	ret

.text_items
	textitem 10, 14, DebugEffectViewerStartButtonSwapText
	textitem 14, 15, DebugEffectViewerAButtonPlayText
	textitem 14, 16, DebugEffectViewerBButtonStopText
	textitem  2, 13, DebugEffectViewerAnimationNumberText
	textitems_end

ChangeAnimationPlayerSideOnStartPress:
	ldh a, [hKeysPressed]
	and PAD_START
	ret z
	push af
	ld a, SFX_CONFIRM
	call CallPlaySFX
	pop af
	ld b, OPPONENT_TURN
	ld c, DUEL_ANIM_SCREEN_MAIN_SCENE
	ldtx hl, DebugEffectViewerRightToLeftText
	ld a, [wDebugAnimDuelistSide]
	cp PLAYER_TURN
	jr z, .asm_f361
.initialize
	ld b, PLAYER_TURN
	ld c, DUEL_ANIM_SCREEN_MAIN_SCENE
	ldtx hl, DebugEffectViewerLeftToRightText
.asm_f361
	ld a, b
	ld [wDebugAnimDuelistSide], a
	ld a, c
	ld [wDebugDuelAnimationScreen], a
	lb de, 2, 14
	call InitTextPrinting_ProcessTextFromIDVRAM0
	ret

ChangeEffectNumberOnDpadPress:
	ldh a, [hDPadHeld]
	and PAD_UP
	jr z, .check_down
	ld b, 10
	jr .update_anim
.check_down
	ldh a, [hDPadHeld]
	and PAD_DOWN
	jr z, .check_left
	ld b, -10
	jr .update_anim
.check_left
	ldh a, [hDPadHeld]
	and PAD_LEFT
	jr z, .check_right
	ld b, -1
	jr .update_anim
.check_right
	ldh a, [hDPadHeld]
	and PAD_RIGHT
	ret z
	ld b, 1
	jr .update_anim
.initialize
	ld b, 0
.update_anim
	ld a, [wDebugSelectedAnimNumber]
	add b
	and $ff
	ld [wDebugSelectedAnimNumber], a
	ld l, a
	ld h, 0
	lb de, 3, 13
	ld a, 3
	ld b, FALSE
	farcall PrintNumber
	ret

CancelAnimationOnBPress:
	ldh a, [hKeysPressed]
	and PAD_B
	ret z
	push af
	ld a, SFX_CANCEL
	call CallPlaySFX
	pop af
	call FinishQueuedAnimations
	ret

DebugPrintAnimBufferCurPosAndSize:
	push af
	push bc
	push de
	push hl
	farcall GetwDuelAnimBufferCurPos
	ld l, a
	ld h, 0
	lb de, 2, 16
	ld a, 2
	ld b, FALSE
	farcall PrintNumber
	farcall GetwDuelAnimBufferSize
	ld l, a
	ld h, 0
	lb de, 5, 16
	ld a, 2
	ld b, FALSE
	farcall PrintNumber
	pop hl
	pop de
	pop bc
	pop af
	ret

ChangeDebugViewerStateText:
	push af
	push bc
	push de
	push hl
	call CheckAnyAnimationPlaying
	ldtx hl, DebugEffectViewerPlayingStateText
	jr c, .asm_f3fd
	ldtx hl, DebugEffectViewerStopStateText
.asm_f3fd
	lb de, 13, 13
	call InitTextPrinting_ProcessTextFromIDVRAM0
	pop hl
	pop de
	pop bc
	pop af
	ret
; 0xf408
