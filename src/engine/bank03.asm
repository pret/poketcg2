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
	call Func_e97a
	call Func_c24d
	call Func_eb97
	xor a
	farcall Func_1d475
	ld a, $04
	ld [wd54c], a
	xor a
	ld [wd54d], a
	call Func_3087
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
	call Func_eaea
	xor a
	call PlaySong
	ld a, [wd54c]
	cp $04
	jr z, .asm_c0a0
	cp $03
	jr z, .asm_c0ab
	ld a, [wPlayerOWObject]
	ld b, TRUE
	farcall SetOWObjectAnimStruct1Flag2
	call Func_33b7
	call Func_c29d
	call Func_e9a7
	ld a, $01
	farcall Func_1d475
	ld hl, wd583
	set 7, [hl]
	ld a, $02
	ld [wd54c], a
	call Func_3087
	scf
	ret

.asm_c0a0
	ld a, $01
	farcall Func_1d475
	call Func_3087
	scf
	ret

.asm_c0ab
	ld a, [wPlayerOWObject]
	ld b, TRUE
	farcall SetOWObjectAnimStruct1Flag2
	call Func_33b7
	call Func_c29d
	call Func_e9a7
	ld a, $01
	farcall Func_1d475
	call DisableLCD
	farcall Func_10b9c
	farcall Func_1055e
	farcall UpdateOWScroll
	farcall SaveTargetFadePals
	farcall Func_1109f
	call DoFrame
	ld a, $0e
	call Func_3154
	ld a, VAR_NPC_DECK_ID
	call GetVarValue
	ld [wNPCDuelDeckID], a
	ld a, VAR_DUEL_START_THEME
	call GetVarValue
	ld [wDuelStartTheme], a
	call Func_3087
	scf
	ret

StartMenu_ContinueDuel:
	ld a, $01
	farcall Func_1d475
	xor a
	call PlaySong
	call Func_eb16
	ld a, [wPlayerOWObject]
	ld b, $01
	farcall SetOWObjectAnimStruct1Flag2
	call Func_33b7
	call EnablePlayTimeCounter
	ld a, EVENT_F0
	call MaxOutEventValue
	ld a, $0e
	call Func_3154
	ld a, $03
	ld [wd54c], a
	call Func_3087
	scf
	ret

StartMenu_CardPop:
	farcall CardPopMenu
	scf
	ccf
	ret

; jump to .PointerTable[a]
Func_c12e::
	sla a
	ld hl, .PointerTable
	add l
	ld l, a
	jr nc, .got_pointer
	inc h
.got_pointer
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp hl

.PointerTable
	dw Func_31a1 ; $00
	dw Func_c162 ; $01
	dw Func_c17d ; $02
	dw Func_c169 ; $03
	dw Func_c183 ; $04
	dw Func_31a8 ; $05
	dw Func_c199 ; $06
	dw Func_c162 ; $07
	dw Func_c163 ; $08
	dw Func_c189 ; $09
	dw Func_3234 ; $0a
	dw Func_c18f ; $0b
	dw Func_c162 ; $0c
	dw Func_c162 ; $0d
	dw Func_c162 ; $0e
	dw Func_c16f ; $0f
	dw Func_c175 ; $10
	dw $41a2     ; $11
	dw $41a6     ; $12

Func_c162:
	ret

; clear wd582
Func_c163:
	ld a, 0
	ld [wd582], a
	ret

Func_c169:
	ld a, 10
	call WaitAFrames
	ret

Func_c16f:
	ld a, SFX_0C
	call PlaySFX
	ret

Func_c175:
	ld a, [wNextMusic]
	farcall PlayAfterCurrentSong
	ret

Func_c17d:
	ld a, $01
	call Func_338f
	ret

Func_c183:
	ld a, $01
	call Func_33a3
	ret

; clear wd582, dupe of Func_c163
Func_c189:
	ld a, 0
	ld [wd582], a
	ret

Func_c18f:
	farcall PlayCurrentSong
	ld a, 0
	ld [wd582], a
	ret

; clear wd582, then Func_32f6
Func_c199:
	ld a, 0
	ld [wd582], a
	call Func_32f6
	ret
; 0xc1a2

SECTION "Bank 3@41c9", ROMX[$41c9], BANK[$3]

HandleStartMenu:
	xor a
	ld [wd554], a
	call Func_e883
	jr c, .menu_config0
	call Func_e8b7
	jr c, .asm_c20f
.asm_c1d7
	ld hl, wd554
	set 0, [hl]
	call Func_eaf6
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
	call Func_e8a3
	jr c, .menu_config2
	call Func_e91a
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
	call Func_e91a
	jr c, .menu_config0
	call Func_e9b7
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
	ld [wd54c], a
	ld [wd54d], a
	ld [wd54e], a
	ld [wd54f], a
	ld [wd551], a
	ld [wd552 + 0], a
	ld [wd552 + 1], a
	ld [wCurIsland], a
	ld [wd586], a
	ld [wCurOWLocation], a
	ld [wCurMusic], a
	ld [wd611 + 0], a
	ld [wd611 + 1], a
	ld [wd613 + 0], a
	ld [wd613 + 1], a
	call Func_ebc6
	jr nc, .asm_c299
	call Func_eb39
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
	call Func_c319
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
	ld a, VAR_02
	call GetVarValue
	cp $06
	jr c, .asm_c318
	ld a, EVENT_F5
	call ZeroOutEventValue
	call UpdateRNGSources
	rra
	jr nc, .asm_c318
	ld a, EVENT_F5
	call MaxOutEventValue
.asm_c318
	ret

Func_c319:
	ld a, VAR_0D
	call GetVarValue
	cp $04
	jr c, .asm_c32d
	jr z, .asm_c357
	ld a, VAR_0D
	ld c, $01
	call SetVarValue
	jr .asm_c357
.asm_c32d
	ld a, [wd586]
	cp $23
	jr z, .asm_c357
	cp $24
	jr z, .asm_c357
	cp $25
	jr z, .asm_c357
	ld a, VAR_0D
	call GetVarValue
	cp $02
	jr z, .asm_c357
	jr nc, .asm_c358
	ld a, VAR_20
	call GetVarValue
	cp $0a
	jr c, .asm_c357
	ld a, VAR_0D
	ld c, $02
	call SetVarValue
.asm_c357
	ret
.asm_c358
	ld a, VAR_0D
	ld c, $01
	call SetVarValue
	ld a, VAR_20
	call ZeroOutVarValue
	jr .asm_c357

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
	ld a, VAR_28
	call GetVarValue
	cp $05
	jr c, .skip
	ld a, [wCurIsland]
	cp TCG_ISLAND
	jr nz, .asm_c450
	ld a, [wCurOWLocation]
	cp OWMAP_TCG_CHALLENGE_HALL
	jr z, .skip
.asm_c450
	ld a, VAR_28
	ld c, $05
	call SetVarValue
	ld a, $04
	call Random
	or a
	jr nz, .skip
	; 1/4 chance
	ld a, VAR_28
	ld c, $06
	call SetVarValue
	ld a, VAR_2B
	call ZeroOutVarValue
	ld a, $11
	call Random
	ld c, a
	ld a, VAR_29
	call SetVarValue
.skip
	ret

Func_c477:
	ld a, VAR_30
	call GetVarValue
	cp $05
	jr c, .asm_c4b4
	ld a, [wCurIsland]
	cp GR_ISLAND
	jr nz, .asm_c48e
	ld a, [wCurOWLocation]
	cp OWMAP_GR_CHALLENGE_HALL
	jr z, .asm_c4b4
.asm_c48e
	ld a, VAR_30
	ld c, $05
	call SetVarValue
	ld a, $05
	call Random
	or a
	jr nz, .asm_c4b4
	; 1/5 chance
	ld a, VAR_30
	ld c, $06
	call SetVarValue
	ld a, VAR_33
	call ZeroOutVarValue
	ld a, $11
	call Random
	ld c, a
	ld a, VAR_31
	call SetVarValue
.asm_c4b4
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

LoadNPCDuelistDeck:
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
	add l
	ld l, a
	jr nc, .loop_decks
	inc h
.loop_decks
	ld a, [hli]
	cp b
	jr z, .got_deck
	dec c
	jr nz, .loop_decks
	pop hl
	jr .loop_duelists
.not_found
	debug_nop
	jr .done
.got_deck
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

; return the location name in hl, using c == island and a == location
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
	add l
	ld l, a
	jr nc, .got_location
	inc h
.got_location
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

; using de == receiving card, return its long name in hl
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
	ld a, b
	cp $ff
	jr c, .ok
	jr nz, .ok ; redundant
	ld a, c
	cp $ff
.ok
	jr z, .not_found
	ld a, b
	cp d
	jr c, .next
	jr nz, .next
	ld a, c
	cp e
.next
	jr z, .load_name
	ld a, CARD_RECEIVE_STRUCT_TEXTS_SIZE
	add l
	ld l, a
	jr nc, .got_pointer
	inc h
.got_pointer
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

; using de == receiving card, return its short name in hl
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
	ld a, b
	cp $ff
	jr c, .ok
	jr nz, .ok ; redundant
	ld a, c
	cp $ff
.ok
	jr z, .not_found
	ld a, b
	cp d
	jr c, .next
	jr nz, .next
	ld a, c
	cp e
.next
	jr z, .load_short_name
	ld a, CARD_RECEIVE_STRUCT_TEXTS_SIZE
	add l
	ld l, a
	jr nc, .got_pointer
	inc h
.got_pointer
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

; using de == receiving card, return its "received" text in hl
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
	ld a, b
	cp $ff
	jr c, .ok
	jr nz, .ok ; redundant
	ld a, c
	cp $ff
.ok
	jr z, .not_found
	ld a, b
	cp d
	jr c, .next
	jr nz, .next
	ld a, c
	cp e
.next
	jr z, .load_received_text
	ld a, CARD_RECEIVE_STRUCT_TEXTS_SIZE
	add l
	ld l, a
	jr nc, .got_pointer
	inc h
.got_pointer
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

Func_c63e:
	call GetReceivedCardText
	farcall Func_1d53a
	ret

Func_c646:
	call AddCardToCollection
	call GetReceivedCardText
	farcall Func_1d53a
	ret

; bank and offset table of data for Func_d421 and Func_33b7
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

; 34 promo cards
; just excluding Legendaries, Phantoms, Bill's Computer and related ones, and GR Mewtwo
NonSpecialPromoCards:
	dw ARCANINE_LV34
	dw PIKACHU_LV16
	dw PIKACHU_ALT_LV16
	dw SURFING_PIKACHU_LV13
	dw SURFING_PIKACHU_ALT_LV13
	dw ELECTABUZZ_LV20
	dw SLOWPOKE_LV9
	dw MEWTWO_ALT_LV60
	dw MEWTWO_LV60
	dw MEW_LV8
	dw JIGGLYPUFF_LV12
	dw FLYING_PIKACHU_LV12
	dw IMAKUNI_CARD
	dw SUPER_ENERGY_RETRIEVAL
	dw MEWTWO_LV30
	dw PIKACHU_LV13
	dw FLYING_PIKACHU_ALT_LV12
	dw DARK_PERSIAN_ALT_LV28
	dw MEOWTH_LV14
	dw COMPUTER_ERROR
	dw COOL_PORYGON
	dw HUNGRY_SNORLAX
	dw VENUSAUR_ALT_LV67
	dw CHARIZARD_ALT_LV76
	dw BLASTOISE_ALT_LV52
	dw FARFETCHD_ALT_LV20
	dw KANGASKHAN_LV38
	dw DIGLETT_LV16
	dw DUGTRIO_LV40
	dw DRAGONITE_LV43
	dw MAGIKARP_LV10
	dw TOGEPI
	dw MARILL
	dw MANKEY_ALT_LV7
; 0xd1ed

SECTION "Bank 3@5299", ROMX[$5299], BANK[$3]

Func_d299::
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
	ld hl, wd583
	bit 6, [hl]
	jr nz, .asm_d2c1
	bit 7, [hl]
	jp nz, .asm_d398
	ld a, EVENT_02
	call GetEventValue
	jp nz, .asm_d377
	ld a, PLAYER_TURN
	ldh [hWhoseTurn], a
.asm_d2c1
	ld hl, wd58b
	ld a, [hl]
	ld [wd551], a
	ld hl, wd58c
	ld a, [hli]
	ld [wd552 + 0], a
	ld a, [hl]
	ld [wd552 + 1], a
	ld a, $01
	call Func_3154
	farcall Func_102ef
	xor a
	farcall Func_10d40
	ld a, $01
	farcall SetOWScrollState
	ld b, $00
	ld a, [wCurMapGfx]
	ld c, a
	farcall LoadOWMap
	ld a, [wd58f]
	ld d, a
	ld a, [wd590]
	ld e, a
	ld a, [wd591]
	ld b, a
	ld a, [wPlayerOWObject]
	farcall LoadOWObjectInMap
	farcall StopOWObjectAnimation
	farcall SetOWObjectAsScrollTarget
	farcall SetOWObjectFlag5_WithID
	ld b, $01
	farcall SetOWObjectAnimStruct1Flag2
	ld a, $00
	ld [wd582], a
	xor a
	ld [wd583], a
	ld a, $07
	call Func_3154
	ld a, $10
	call Func_3154
	ld a, $02
	call Func_3154
	ld a, $03
	call Func_3154

.asm_d333
	ld a, [wVBlankCounter]
	and $3f
	call z, UpdateRNGSources
	ld a, [wd582]
	call Func_3154
	ld a, [wd583]
	bit 1, a
	jr nz, .start_duel
	bit 0, a
	jr z, .asm_d333
	ld a, $04
	call Func_3154
	ld a, $0f
	call Func_3154
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
	ld a, $03
	ld [wd54c], a
	call Func_eaa8
	ret

.asm_d377
	ld a, $11
	call Func_3154
	ld a, EVENT_02
	call ZeroOutEventValue
	call Func_e9a7
	ld a, EVENT_F0
	call ZeroOutEventValue
	farcall PlayCurrentSong
	ld a, $09
	ld [wd582], a
	xor a
	ld [wd583], a
	jr .asm_d333

.asm_d398
	farcall Func_10b9c
	farcall Func_1055e
	farcall UpdateOWScroll
	farcall SaveTargetFadePals
	farcall Func_1109f
	call DoFrame
	ld a, $00
	ld b, $00
	farcall StartPalFadeFromBlackOrWhite
	ld a, $0b
	ld [wd582], a
	ld hl, wd583
	res 7, [hl]
	jp .asm_d333

; a = map id
; b = direction
; de = coordinates
Func_d3c4:
	ld [wd54d], a
	ld a, $02
	ld [wd54c], a
	ld a, d
	ld [wd58f], a
	ld a, e
	ld [wd590], a
	ld a, b
	ld [wd591], a
	ld a, $00
	ld [wd582], a
	ld hl, wd583
	set 0, [hl]
	ld a, [wd54d]
	ld [wd585], a
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
	ld hl, .data
	add l
	ld l, a
	jr nc, .got_pointer
	inc h
.got_pointer
	ld a, [hli]
	add d
	ld d, a
	ld a, [hl]
	add e
	ld e, a
	ret

.data
	db  0, -1
	db  1,  0
	db  0,  1
	db -1,  0

PCMenu:
	call PauseSong
	ld a, MUSIC_PCMAINMENU
	call PlaySong
	farcall _PCMenu
	call ResumeSong
	ret

Func_d421::
	push af
	ld c, a
	ld b, $00
	sla c
	add c ; *3
	ld c, a
	rl b
	ld hl, MapHeaderPtrs
	add hl, bc
	ld a, [hli]
	ld c, a     ; bank
	ld a, [hli] ; offset
	ld h, [hl]  ;
	ld l, a
	ld a, c
	ld de, wCurMapGfx
	ld bc, $5
	call CopyFarHLToDE
	ld a, [wd586]
	ld [wd584], a
	pop af
	ld [wd586], a
	ld a, $ff
	ld [wd585], a
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
	db $21, %00000001 ; EVENT_BB
	db $21, %00000010 ; EVENT_BC
	db $21, %00000100 ; EVENT_BD
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
	db $26, %00000010 ; EVENT_BEAT_GRAND_MASTER_CUP
	db $26, %00000100 ; EVENT_DB
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
	db $2a, %00000010 ; EVENT_EC
	db $2b, %00000001 ; EVENT_SET_UNTIL_MAP_RELOAD_1
	db $2b, %00000010 ; EVENT_EE
	db $2b, %00000100 ; EVENT_EF
	db $33, %00000001 ; EVENT_F0
	db $33, %00000010 ; EVENT_SET_UNTIL_MAP_RELOAD_2
	db $33, %00000100 ; EVENT_F2
	db $33, %00001000 ; EVENT_F3
	db $33, %00010000 ; EVENT_ISHIHARA_CARD_TRADE_STATE
	db $33, %00100000 ; EVENT_F5

; extra events?
GeneralVarMasks:
	db $00, %11111111 ; VAR_00
	db $01, %00000011 ; VAR_01
	db $01, %00111100 ; VAR_02
	db $01, %11000000 ; VAR_03
	db $02, %00001111 ; VAR_TIMES_MET_RONALD
	db $03, %00000011 ; VAR_05
	db $03, %00001100 ; VAR_06
	db $03, %00110000 ; VAR_07
	db $04, %00001111 ; VAR_08
	db $04, %00110000 ; VAR_09
	db $04, %11000000 ; VAR_0A
	db $05, %00000011 ; VAR_0B
	db $06, %00000011 ; VAR_0C
	db $06, %00011100 ; VAR_0D
	db $06, %11100000 ; VAR_0E
	db $07, %00001111 ; VAR_0F
	db $08, %11111111 ; VAR_10
	db $09, %11111111 ; VAR_11
	db $0a, %11111111 ; VAR_12
	db $0b, %11111111 ; VAR_13
	db $0c, %11111111 ; VAR_14
	db $0d, %11111111 ; VAR_15
	db $0e, %11111111 ; VAR_16
	db $0f, %11111111 ; VAR_17
	db $10, %11111111 ; VAR_18
	db $11, %11111111 ; VAR_19
	db $12, %11111111 ; VAR_1A
	db $13, %11111111 ; VAR_1B
	db $14, %11111111 ; VAR_1C
	db $15, %11111111 ; VAR_1D
	db $16, %11111111 ; VAR_1E
	db $17, %00000011 ; VAR_1F
	db $17, %00111100 ; VAR_20
	db $18, %00000111 ; VAR_21
	db $18, %11110000 ; VAR_IMAKUNI_BLACK_WIN_COUNT
	db $19, %00000001 ; VAR_23
	db $19, %11110000 ; VAR_24
	db $1a, %00001111 ; VAR_25
	db $1a, %11110000 ; VAR_26
	db $1b, %00001111 ; VAR_27
	db $1b, %01110000 ; VAR_28
	db $1c, %00011111 ; VAR_29
	db $1d, %00001111 ; VAR_2A
	db $1d, %00110000 ; VAR_2B
	db $1d, %11000000 ; VAR_2C
	db $1e, %11111111 ; VAR_2D
	db $1f, %11111111 ; VAR_2E
	db $20, %11111111 ; VAR_2F
	db $21, %00000111 ; VAR_30
	db $21, %11111000 ; VAR_31
	db $22, %00001111 ; VAR_32
	db $22, %00110000 ; VAR_33
	db $23, %00000111 ; VAR_34
	db $24, %11111111 ; VAR_35
	db $25, %11111111 ; VAR_36
	db $26, %11111111 ; VAR_37
	db $27, %11111111 ; VAR_38
	db $28, %11111111 ; VAR_39
	db $29, %00000111 ; VAR_3A
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

; for the bit offset a = 8m + n, set bit n at (wd606 + m)
SetBit_wd606:
	push af
	push bc
	push hl
	push af
	ld hl, wd606
REPT 3
	srl a
ENDR
	add l
	ld l, a
	jr nc, .got_byte
	inc h
.got_byte
	pop af
	and 7
	inc a
	ld c, a
	ld b, 1
.loop_bitmask
	dec c
	jr z, .got_bit
	sla b
	jr .loop_bitmask
.got_bit
	ld a, [hl]
	or b
	ld [hl], a
	pop hl
	pop bc
	pop af
	ret

; for the bit offset a = 8m + n, clear bit n at (wd606 + m)
ClearBit_wd606:
	push af
	push bc
	push hl
	push af
	ld hl, wd606
REPT 3
	srl a
ENDR
	add l
	ld l, a
	jr nc, .got_byte
	inc h
.got_byte
	pop af
	and 7
	inc a
	ld c, a
	ld b, 1
.loop_bitmask
	dec c
	jr z, .got_bit
	sla b
	jr .loop_bitmask
.got_bit
	ld a, b
	cpl
	and [hl]
	ld [hl], a
	pop hl
	pop bc
	pop af
	ret

; for the bit offset a = 8m + n, return in the z flag whether bit n at (wd606 + m) is empty
; z: empty, nz: set
; then restore bc and load b from it into a
CheckBit_wd606:
	push bc
	push hl
	push af
	push af
	ld hl, wd606
REPT 3
	srl a
ENDR
	add l
	ld l, a
	jr nc, .got_byte
	inc h
.got_byte
	pop af
	and 7
	inc a
	ld c, a
	ld b, 1
.loop_bitmask
	dec c
	jr z, .got_bit
	sla b
	jr .loop_bitmask
.got_bit
	ld a, [hl]
	and b
	pop bc
	ld a, b
	pop hl
	pop bc
	ret

; jump to .check_pointers[a], set carry if the event is set, clear carry if not
CheckTCGIslandMilestoneEvents:
	push bc
	push de
	push hl
	sla a
	ld hl, .check_pointers
	add l
	ld l, a
	jr nc, .got_pointer
	inc h
.got_pointer
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp hl

.jump_set_carry:
	jp .set_carry

.check_four_tcgisland_coins:
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
	; fallthrough
.loop_bitmask_1
	sla d
	pop af
	jr z, .next_1
	set 0, d
	; fallthrough
.next_1
	dec c
	jr nz, .loop_bitmask_1
	ld a, d
	or a
	jp nz, .set_carry
	jp .clear_carry

.check_gr_coin_top_left:
	ld a, EVENT_GOT_GR_COIN_PIECE_TOP_LEFT
	call GetEventValue
	jp nz, .set_carry
	jp .clear_carry

.check_gr_coin_top_right:
	ld a, EVENT_GOT_GR_COIN_PIECE_TOP_RIGHT
	call GetEventValue
	jp nz, .set_carry
	jp .clear_carry

.check_starmie_coin:
	ld a, EVENT_GOT_STARMIE_COIN
	call GetEventValue
	jp nz, .set_carry
	jp .clear_carry

.check_gr_coin_bottom_left:
	ld a, EVENT_GOT_GR_COIN_PIECE_BOTTOM_LEFT
	call GetEventValue
	jp nz, .set_carry
	jp .clear_carry

.check_pikachu_coin:
	ld a, EVENT_GOT_PIKACHU_COIN
	call GetEventValue
	jp nz, .set_carry
	jp .clear_carry

.check_gr_coin_bottom_right:
	ld a, EVENT_GOT_GR_COIN_PIECE_BOTTOM_RIGHT
	call GetEventValue
	jp nz, .set_carry
	jp .clear_carry

.check_grand_master_cup_or_challenge_machine:
	ld a, EVENT_BEAT_GRAND_MASTER_CUP
	call GetEventValue
	push af
	ld a, EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE
	call GetEventValue
	push af
	ld c, 2
	xor a
	ld d, a
	; fallthrough
.loop_bitmask_2
	sla d
	sla d
	pop af
	jr z, .next_2
	set 0, d
	set 1, d
	; fallthrough
.next_2
	dec c
	jr nz, .loop_bitmask_2
	ld a, d
	or a
	jp nz, .set_carry
	jp .clear_carry

.check_event_db:
	ld a, EVENT_DB
	call GetEventValue
	jp nz, .set_carry
	jp .clear_carry

.set_carry:
	pop hl
	pop de
	pop bc
	scf
	ret

.clear_carry:
	pop hl
	pop de
	pop bc
	scf
	ccf
	ret

.check_pointers:
	dw .jump_set_carry
	dw .check_four_tcgisland_coins
	dw .check_gr_coin_top_left
	dw .check_gr_coin_top_right
	dw .check_starmie_coin
	dw .check_gr_coin_bottom_left
	dw .check_pikachu_coin
	dw .check_gr_coin_bottom_right
	dw .check_grand_master_cup_or_challenge_machine
	dw .check_event_db

; jump to .check_pointers[a], set carry if the event is set, clear carry if not
CheckGRIslandMilestoneEvents:
	push bc
	push de
	push hl
	sla a
	ld hl, .check_pointers
	add l
	ld l, a
	jr nc, .got_pointer
	inc h
.got_pointer
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp hl

.check_golbat_coin:
	ld a, EVENT_GOT_GOLBAT_COIN
	call GetEventValue
	jp nz, .set_carry
	jp .clear_carry

.check_magnemite_coin:
	ld a, EVENT_GOT_MAGNEMITE_COIN
	call GetEventValue
	jp nz, .set_carry
	jp .clear_carry

.check_psyduck_coin:
	ld a, EVENT_GOT_PSYDUCK_COIN
	call GetEventValue
	jp nz, .set_carry
	jp .clear_carry

.check_magmar_coin:
	ld a, EVENT_GOT_MAGMAR_COIN
	call GetEventValue
	jp nz, .set_carry
	jp .clear_carry

.check_machamp_coin:
	ld a, EVENT_GOT_MACHAMP_COIN
	call GetEventValue
	jp nz, .set_carry
	jp .clear_carry

.check_mew_coin:
	ld a, EVENT_GOT_MEW_COIN
	call GetEventValue
	jp nz, .set_carry
	jp .clear_carry

.check_snorlax_coin:
	ld a, EVENT_GOT_SNORLAX_COIN
	call GetEventValue
	jp nz, .set_carry
	jp .clear_carry

.check_rui_roadblock:
	ld a, EVENT_GR_CASTLE_STAIRS_RUI_ROADBLOCK
	call GetEventValue
	jp nz, .set_carry
	jp .clear_carry

.check_battled_ishihara:
	ld a, EVENT_BATTLED_ISHIHARA
	call GetEventValue
	jp nz, .set_carry
	jp .clear_carry

.check_challenge_machine:
	ld a, EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE
	call GetEventValue
	jp nz, .set_carry
	jp .clear_carry

.set_carry:
	pop hl
	pop de
	pop bc
	scf
	ret

.clear_carry:
	pop hl
	pop de
	pop bc
	scf
	ccf
	ret

.check_pointers:
	dw .check_golbat_coin
	dw .check_magnemite_coin
	dw .check_psyduck_coin
	dw .check_magmar_coin
	dw .check_machamp_coin
	dw .check_mew_coin
	dw .check_snorlax_coin
	dw .check_rui_roadblock
	dw .check_battled_ishihara
	dw .check_challenge_machine

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
	add l
	ld l, a
	jr nc, .got_offset
	inc h
.got_offset
	ld a, [hl]
	ld d, a
	ld hl, OverworldScriptTable
	add l
	ld l, a
	jr nc, .next
	inc h
.next
	ld a, d
	add l
	ld l, a
	jr nc, .got_pointer
	inc h
.got_pointer
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp hl

OverworldScriptTable:
	dw ScriptCommand_EndScript                        ; $00
	dw ScriptCommand_01                               ; $01
	dw ScriptCommand_02                               ; $02
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
	dw ScriptCommand_58                               ; $58
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
	dw ScriptCommand_64                               ; $64
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
	dw ScriptCommand_GameCenter                       ; $70
	dw ScriptCommand_71                               ; $71
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
	add [hl]
	ld [hli], a
	jr nc, .next
	inc [hl]
.next
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
	add l
	ld l, a
	jr nc, .got_pointer
	inc h
.got_pointer
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
	add l
	ld l, a
	jr nc, .got_pointer
	inc h
.got_pointer
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

ScriptCommand_01:
	call DoFrame
	farcall Func_11002
	jp IncreaseScriptPointerBy1

ScriptCommand_02:
	farcall Func_1101d
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
	farcall Func_10def
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
	farcall Func_10def
	jp IncreaseScriptPointerBy4

ScriptCommand_MoveActiveNPC:
	call Get2ScriptArgs_IncrIndexBy1
	ld l, c
	ld h, b
	ld a, [wScriptBank]
	ld b, a
	ld a, [wScriptNPC]
	farcall Func_10def
	jp IncreaseScriptPointerBy3

ScriptCommand_StartDuel:
	call Get2ScriptArgs_IncrIndexBy1
	ld a, c
	ld [wNPCDuelDeckID], a
	ld a, b
	ld [wDuelStartTheme], a
	ld hl, wd583
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
	call Func_344c
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
	add l
	ld l, a
	jr nc, .got_pointer
	inc h
.got_pointer
	ld a, [wScriptLoadedVar]
	ld [hl], a
	jp IncreaseScriptPointerBy1

ScriptCommand_PopVar:
	ld hl, wScriptStack
	ld a, [wScriptStackOffset]
	push af
	add l
	ld l, a
	jr nc, .got_pointer
	inc h
.got_pointer
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
	add l
	ld l, a
	jr nc, .got_pointer
	inc h
.got_pointer
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
	add l
	ld l, a
	jr nc, .got_pointer
	inc h
.got_pointer
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
	add l
	ld l, a
	jr nc, .got_pointer
	inc h
.got_pointer
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

ScriptCommand_58:
	ld a, $12
	call Func_3154
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
	add l
	ld l, a
	jr nc, .got_pointer
	inc h
.got_pointer
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
	add l
	ld l, a
	jr nc, .got_pointer
	inc h
.got_pointer
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
; - if n = 0 or n >= 29, skip
; - else, set bit (m-1) of [dw hl] and Func_1f24e, where
;   - hl = wd611 and m = n    if 0 < n <= 16,
;   - hl = wd613 and m = n-16 if 16 < n < 29,
; then IncreaseScriptPointerBy2
ScriptCommand_64:
	call Get1ScriptArg_IncrIndexBy1
	or a
	jr z, .done
	cp $1d
	jr nc, .done
	ld hl, wd611
	cp $10 + 1
	jr c, .set_bitmask
	inc hl
	inc hl ; wd613
	sub $10
.set_bitmask
	ld de, 1
.set_bitmask_loop
	dec a
	jr z, .got_bitmask
	sla e
	rl d
	jr .set_bitmask_loop
.got_bitmask
	ld a, [hli]
	ld c, a
	ld a, [hld]
	ld b, a
	ld a, c
	and e
	jr nz, .checked_bit
	ld a, b
	and d
.checked_bit
	jr nz, .done
; set bit and call
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
	farcall Func_1f24e
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
	ld a, d
	cp b
	jr c, .high_byte_not_equal
	jr nz, .high_byte_not_equal
; high byte equal
	ld a, e
	cp c
.high_byte_not_equal
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

ScriptCommand_GameCenter:
	farcall Func_114af
	jp IncreaseScriptPointerBy1

ScriptCommand_71:
	farcall Func_114f9
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

; returns carry if no save data
Func_e883:
	ldh a, [hBankSRAM]
	push af
	ld a, BANK("SRAM2")
	call BankswitchSRAM
	call EnableSRAM
	ld a, [$baa3]
	ld b, a
	pop af
	call BankswitchSRAM
	call DisableSRAM
	ld a, b
	bit 0, a
	jr z, .set_carry
; no carry
	scf
	ccf
	ret
.set_carry
	scf
	ret

Func_e8a3:
	call EnableSRAM
	ld a, [$baa3]
	ld b, a
	call DisableSRAM
	ld a, b
	bit 1, a
	jr z, .asm_e8b5
	scf
	ccf
	ret
.asm_e8b5
	scf
	ret

Func_e8b7:
	ld a, $02
	ld [wd668], a
	ldh a, [hBankSRAM]
	push af
	ld a, BANK("SRAM2")
	call BankswitchSRAM
	ld a, [$b800]
	ld b, a
	pop af
	call BankswitchSRAM
	call DisableSRAM
	ld a, b
	cp $16
	jr nz, .asm_e918
	ld a, $ec
	ld [wd66f], a
	ld a, $6d
	ld [wd670], a
	ld a, $01
	ld [wd671], a
	ld a, $b8
	ld [wd672], a
	call Func_ea19
	call Func_ed7c
	ld a, [wd66d]
	ld d, a
	ld a, [wd66c]
	ld e, a
	ldh a, [hBankSRAM]
	push af
	ld a, BANK("SRAM2")
	call BankswitchSRAM
	ld a, [$baa0]
	ld b, a
	ld a, [$baa1]
	ld c, a
	pop af
	call BankswitchSRAM
	call DisableSRAM
	ld a, b
	cp d
	jr nz, .asm_e918
	ld a, c
	cp e
	jr nz, .asm_e918
	scf
	ccf
	ret
.asm_e918
	scf
	ret

Func_e91a:
	xor a
	ld [wd668], a
	ldh a, [hBankSRAM]
	push af
	xor a
	call BankswitchSRAM
	ld a, [$b800]
	ld b, a
	pop af
	call BankswitchSRAM
	call DisableSRAM
	ld a, b
	cp $16
	jr nz, .asm_e978
	ld a, $ec
	ld [wd66f], a
	ld a, $6d
	ld [wd670], a
	ld a, $01
	ld [wd671], a
	ld a, $b8
	ld [wd672], a
	call Func_ea19
	call Func_ed7c
	ld a, [wd66d]
	ld d, a
	ld a, [wd66c]
	ld e, a
	ldh a, [hBankSRAM]
	push af
	xor a
	call BankswitchSRAM
	ld a, [$baa0]
	ld b, a
	ld a, [$baa1]
	ld c, a
	pop af
	call BankswitchSRAM
	call DisableSRAM
	ld a, b
	cp d
	jr nz, .asm_e978
	ld a, c
	cp e
	jr nz, .asm_e978
	scf
	ccf
	ret
.asm_e978
	scf
	ret

Func_e97a:
	ldh a, [hBankSRAM]
	push af
	ld a, BANK("SRAM2")
	call BankswitchSRAM
	ld hl, $baa3
	xor a
	ld [hl], a
	ld [$b800], a
	pop af
	call BankswitchSRAM
	call DisableSRAM
	call EnableSRAM
	ld hl, $baa3
	xor a
	ld [hl], a
	ld [$b800], a
	call DisableSRAM
	farcall ClearSavedDuel
	call DisableSRAM
	ret

Func_e9a7:
	call EnableSRAM
	ld hl, $baa3
	xor a
	ld [hl], a
	call DisableSRAM
	farcall ClearSavedDuel
	ret

Func_e9b7:
	ld a, $02
	call Func_e9d6
	ldh a, [hBankSRAM]
	push af
	ld a, BANK("SRAM2")
	call BankswitchSRAM
	ld a, $16
	ld [$b800], a
	ld hl, $baa3
	set 0, [hl]
	pop af
	call BankswitchSRAM
	call DisableSRAM
	ret

Func_e9d6:
	cp $01
	jr z, .asm_e9e2
	jr nc, .asm_e9e8
	ld e, $02
	ld d, $00
	jr .asm_e9f7
.asm_e9e2
	ld e, $00
	ld d, $02
	jr .asm_e9f7
.asm_e9e8
	ld e, $00
	ld d, $02
	ldh a, [hBankSRAM]
	push af
	ld bc, $2000
	ld hl, s0a000
	jr .asm_ea00
.asm_e9f7
	ldh a, [hBankSRAM]
	push af
	ld bc, $1f00
	ld hl, sCardAndDeckSaveData
.asm_ea00
	ld a, e
	call BankswitchSRAM
	ld a, [hl]
	push af
	ld a, d
	call BankswitchSRAM
	pop af
	ld [hli], a
	dec bc
	ld a, b
	or c
	jr nz, .asm_ea00
	pop af
	call BankswitchSRAM
	call DisableSRAM
	ret

Func_ea19:
	ldh a, [hBankSRAM]
	push af
	ld a, [wd668]
	call BankswitchSRAM
	ld a, [$baa2]
	ld [wd673], a
	pop af
	call BankswitchSRAM
	call DisableSRAM
	ret

Func_ea30::
	ld a, $0c
	call Func_3154
	farcall Func_10f32
	xor a
	ld [wd668], a
.asm_ea3d
	ld a, $ec
	ld [wd66f], a
	ld a, $6d
	ld [wd670], a
	ld a, $01
	ld [wd671], a
	ld a, $b8
	ld [wd672], a
	call Func_ec94
	call EnableSRAM
	ld a, $16
	ld [$b800], a
	ld a, [wd66d]
	ld [$baa0], a
	ld a, [wd66c]
	ld [$baa1], a
	ld a, [wd673]
	ld [$baa2], a
	ld hl, $baa3
	set 0, [hl]
	call DisableSRAM
	call Func_ea19
	call Func_ed7c
	ld a, [wd66d]
	ld d, a
	ld a, [wd66c]
	ld e, a
	call EnableSRAM
	ld a, [$baa0]
	ld b, a
	ld a, [$baa1]
	ld c, a
	call DisableSRAM
	ld a, b
	cp d
	jr nz, .error
	ld a, c
	cp e
	jr nz, .error
	ld a, $01
	call Func_e9d6
	ld a, $0d
	call Func_3154
	ret

.error
	debug_nop
	jr .asm_ea3d

Func_eaa8:
	farcall Func_10f32
	xor a
	ld [wd668], a
	ld a, $ec
	ld [wd66f], a
	ld a, $6d
	ld [wd670], a
	ld a, $01
	ld [wd671], a
	ld a, $b8
	ld [wd672], a
	call Func_ec94
	call EnableSRAM
	ld a, $16
	ld [$b800], a
	ld a, [wd66d]
	ld [$baa0], a
	ld a, [wd66c]
	ld [$baa1], a
	ld a, [wd673]
	ld [$baa2], a
	ld hl, $baa3
	set 1, [hl]
	call DisableSRAM
	ret

Func_eaea:
	call Func_eaf6
	xor a
	call Func_e9d6
	farcall Func_10f78
	ret

Func_eaf6:
	ld a, $02
	ld [wd668], a
	ld a, $ec
	ld [wd66f], a
	ld a, $6d
	ld [wd670], a
	ld a, $01
	ld [wd671], a
	ld a, $b8
	ld [wd672], a
	call Func_ea19
	call Func_ed0b
	ret

Func_eb16:
	xor a
	ld [wd668], a
	ld a, $ec
	ld [wd66f], a
	ld a, $6d
	ld [wd670], a
	ld a, $01
	ld [wd671], a
	ld a, $b8
	ld [wd672], a
	call Func_ea19
	call Func_ed0b
	farcall Func_10f78
	ret

Func_eb39:
	ld hl, wddf9
	xor a
	ld c, $14
.asm_eb3f
	ld [hli], a
	dec c
	jr nz, .asm_eb3f

	ld hl, wde0d
	xor a
REPT 4
	ld [hli], a
ENDR
	ld hl, wde11
	xor a
REPT 4
	ld [hli], a
ENDR
	ld hl, wde15
	xor a
REPT 4
	ld [hli], a
ENDR

	ld a, $01
	ld [wde15 + 0], a
	ld a, $05
	ld [wde15 + 2], a
	ld hl, .data
	ld de, wde19
	ld c, $20
.asm_eb6d
	ld a, [hli]
	ld [de], a
	inc de
	dec c
	jr nz, .asm_eb6d
	call Func_ec38
	ret

.data
	db $04, $13, $79, $15, $0f, $6b, $0f, $34, $0f, $2f, $0f, $00, $00, $00, $00, $00, $4e, $0f, $39, $0f, $38, $0f, $5f, $0f, $21, $0f, $00, $00, $00, $00, $00, $00

SECTION "Bank 3@6b97", ROMX[$6b97], BANK[$3]

Func_eb97:
	call Func_ebc6
	jr nc, .asm_eb9f
	call Func_eb39
.asm_eb9f
	call Func_ec6c
	ld hl, wde0d
	xor a
REPT 4
	ld [hli], a
ENDR
	ld hl, wde11
	xor a
REPT 4
	ld [hli], a
ENDR
	call Func_ec38
	ret

Func_ebb6:
	call EnableSRAM
	xor a
	ld [$bae5], a
	ld a, $ff
	ld [$bae4], a
	call DisableSRAM
	ret

Func_ebc6:
	xor a
	ld [wd668], a
	ld a, $20
	ld [wd66f], a
	ld a, $6f
	ld [wd670], a
	ld a, $a4
	ld [wd671], a
	ld a, $ba
	ld [wd672], a
	call EnableSRAM
	ld a, [$bae6]
	ld [wd673], a
	call DisableSRAM
	call Func_ed0b
	ld a, [wd66d]
	ld d, a
	ld a, [wd66c]
	ld e, a
	call EnableSRAM
	ld a, [$bae4]
	ld b, a
	ld a, [$bae5]
	ld c, a
	call DisableSRAM
	ld a, b
	cp d
	jr nz, .asm_ec36
	ld a, c
	cp e
	jr nz, .asm_ec36
	ld a, [wde15 + 0]
	ld e, a
	ld a, [wde15 + 1]
	ld d, a
	ld a, d
	cp $00
	jr c, .asm_ec1d
	jr nz, .asm_ec1d
	ld a, e
	cp $00
.asm_ec1d
	jr z, .asm_ec36
	ld a, [wde15 + 2]
	ld e, a
	ld a, [wde15 + 3]
	ld d, a
	ld a, d
	cp $00
	jr c, .asm_ec31
	jr nz, .asm_ec31
	ld a, e
	cp $00
.asm_ec31
	jr z, .asm_ec36
	scf
	ccf
	ret
.asm_ec36
	scf
	ret

Func_ec38:
	xor a
	ld [wd668], a
	ld a, $20
	ld [wd66f], a
	ld a, $6f
	ld [wd670], a
	ld a, $a4
	ld [wd671], a
	ld a, $ba
	ld [wd672], a
	call Func_ec94
	call EnableSRAM
	ld a, [wd66d]
	ld [$bae4], a
	ld a, [wd66c]
	ld [$bae5], a
	ld a, [wd673]
	ld [$bae6], a
	call DisableSRAM
	ret

Func_ec6c:
	xor a
	ld [wd668], a
	ld a, $20
	ld [wd66f], a
	ld a, $6f
	ld [wd670], a
	ld a, $a4
	ld [wd671], a
	ld a, $ba
	ld [wd672], a
	call EnableSRAM
	ld a, [$bae6]
	ld [wd673], a
	call DisableSRAM
	call Func_ed0b
	ret

Func_ec94:
	ldh a, [hBankSRAM]
	push af
	ld a, [wd668]
	call BankswitchSRAM
	xor a
	ld [wd66c], a
	ld [wd66d], a
	call UpdateRNGSources
	or $01
	ld [wd673], a
	ld [wd66e], a
	ld a, [wd66f]
	ld l, a
	ld a, [wd670]
	ld h, a
	ld a, [wd671]
	ld e, a
	ld a, [wd672]
	ld d, a
.asm_ecbf
	ld a, [hli]
	ld c, a
	ld a, [hli]
	ld b, a
	or c
	jr z, .asm_ed03
	push hl
	push bc
	ld a, [hli]
	ld c, a
	ld a, [hli]
	ld b, a
	ld a, [hli]
	ld [wd66a], a
	ld a, [hli]
	ld [wd66b], a
	pop hl
.asm_ecd5
	push bc
	ld a, [hli]
	ld c, a
	ld a, [wd66d]
	xor c
	ld [wd66d], a
	ld a, [wd66c]
	add c
	ld [wd66c], a
	ld a, [wd66e]
	ld b, a
	sla a
	add b
	ld b, a
	ld a, c
	add b
	ld [de], a
	inc de
	ld a, b
	ld [wd66e], a
	pop bc
	dec bc
	ld a, b
	or c
	jr nz, .asm_ecd5
	pop hl
REPT 4
	inc hl
ENDR
	jr .asm_ecbf
.asm_ed03
	pop af
	call BankswitchSRAM
	call DisableSRAM
	ret

Func_ed0b:
	ldh a, [hBankSRAM]
	push af
	ld a, [wd668]
	call BankswitchSRAM
	xor a
	ld [wd66c], a
	ld [wd66d], a
	ld a, [wd673]
	ld [wd66e], a
	ld a, [wd66f]
	ld l, a
	ld a, [wd670]
	ld h, a
	ld a, [wd671]
	ld e, a
	ld a, [wd672]
	ld d, a
.asm_ed31
	ld a, [hli]
	ld c, a
	ld a, [hli]
	ld b, a
	or c
	jr z, .asm_ed74
	push hl
	push bc
	ld a, [hli]
	ld c, a
	ld a, [hli]
	ld b, a
	ld a, [hli]
	ld [wd66a], a
	ld a, [hli]
	ld [wd66b], a
	pop hl
.asm_ed47
	push bc
	ld a, [wd66e]
	ld b, a
	sla a
	add b
	ld b, a
	ld a, [de]
	sub b
	ld [hli], a
	inc de
	ld c, a
	ld a, b
	ld [wd66e], a
	ld a, [wd66d]
	xor c
	ld [wd66d], a
	ld a, [wd66c]
	add c
	ld [wd66c], a
	pop bc
	dec bc
	ld a, b
	or c
	jr nz, .asm_ed47
	pop hl
REPT 4
	inc hl
ENDR
	jr .asm_ed31
.asm_ed74
	pop af
	call BankswitchSRAM
	call DisableSRAM
	ret

Func_ed7c:
	ldh a, [hBankSRAM]
	push af
	ld a, [wd668]
	call BankswitchSRAM
	xor a
	ld [wd66c], a
	ld [wd66d], a
	ld a, [wd673]
	ld [wd66e], a
	ld a, [wd66f]
	ld l, a
	ld a, [wd670]
	ld h, a
	ld a, [wd671]
	ld e, a
	ld a, [wd672]
	ld d, a
.asm_eda2
	ld a, [hli]
	ld c, a
	ld a, [hli]
	ld b, a
	or c
	jr z, .asm_ede4
	push hl
	push bc
	ld a, [hli]
	ld c, a
	ld a, [hli]
	ld b, a
	ld a, [hli]
	ld [wd66a], a
	ld a, [hli]
	ld [wd66b], a
	pop hl
.asm_edb8
	push bc
	ld a, [wd66e]
	ld b, a
	sla a
	add b
	ld b, a
	ld a, [de]
	sub b
	inc de
	ld c, a
	ld a, b
	ld [wd66e], a
	ld a, [wd66d]
	xor c
	ld [wd66d], a
	ld a, [wd66c]
	add c
	ld [wd66c], a
	pop bc
	dec bc
	ld a, b
	or c
	jr nz, .asm_edb8
	pop hl
REPT 4
	inc hl
ENDR
	jr .asm_eda2
.asm_ede4
	pop af
	call BankswitchSRAM
	call DisableSRAM
	ret
; 0xedec
