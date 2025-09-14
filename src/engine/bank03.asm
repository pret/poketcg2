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
	ld b, $01
	farcall Func_10f16
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
	ld b, $01
	farcall Func_10f16
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
	ld a, VAR_3D
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
	farcall Func_10f16
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

Func_c12e::
	sla a
	ld hl, .PointerTable
	add l
	ld l, a
	jr nc, .no_overflow
	inc h
.no_overflow
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp hl

.PointerTable
	dw Func_31a1 ; $00
	dw Func_c162 ; $01
	dw $417d     ; $02
	dw $4169     ; $03
	dw $4183     ; $04
	dw Func_31a8 ; $05
	dw $4199     ; $06
	dw Func_c162 ; $07
	dw $4163     ; $08
	dw $4189     ; $09
	dw Func_3234 ; $0a
	dw $418f     ; $0b
	dw Func_c162 ; $0c
	dw Func_c162 ; $0d
	dw Func_c162 ; $0e
	dw $416f     ; $0f
	dw $4175     ; $10
	dw $41a2     ; $11
	dw $41a6     ; $12

Func_c162:
	ret

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
	ld a, VAR_04
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
	ld a, VAR_04
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
	ld [wd611], a
	ld [wd612], a
	ld [wd613], a
	ld [wd614], a
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

FetchNPCDuelist:
	push af
	push bc
	push de
	push hl
	ld c, a
	ld de, NPCDuelistPointers
.fetch
	ld a, [de]
	ld l, a
	inc de
	ld a, [de]
	inc de
	ld h, a
	or l
	jr z, .null
	ld a, [hl]
	cp c
	jr nz, .fetch
	ld de, wCurrentNPCDuelistData
	ld bc, $c
	call CopyDataHLtoDE_SaveRegisters
	pop hl
	pop de
	pop bc
	pop af
	ret
.null
	debug_nop
	pop hl
	pop de
	pop bc
	pop af
	ret

FetchNPCDuelistDeck:
	push bc
	push de
	push hl
	ld b, a
	ld de, NPCDuelistPointers
.fetch_offset
	ld a, [de]
	ld l, a
	inc de
	ld a, [de]
	inc de
	ld h, a
	or l
	jr z, .null
	ld c, 5 ; max deck count
	push hl
	ld a, 7 ; offset
	add l
	ld l, a
	jr nc, .fetch_deck
	inc h
.fetch_deck
	ld a, [hli]
	cp b
	jr z, .got_deck
	dec c
	jr nz, .fetch_deck
	pop hl
	jr .fetch_offset
.null
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
; 0xc50b

SECTION "Bank 3@4522", ROMX[$4522], BANK[$3]

Func_c522:
	push af
	push bc
	ld b, a
	ld a, c
	ld hl, TextIDs_d171 ; TCG island
	cp TCG_ISLAND
	jr z, .got_text
	ld hl, TextIDs_d18f ; GR island
.got_text
	ld a, b
	sla a
	add l
	ld l, a
	jr nc, .asm_c538
	inc h
.asm_c538
	ld a, [hli]
	ld h, [hl]
	ld l, a
	pop bc
	pop af
	ret

Func_c53e:
	push af
	push bc
	ld a, [wCurIsland]
	ld c, a
	ld a, [wCurOWLocation]
	call Func_c522
	pop bc
	pop af
	ret

GetReceivingCardLongName:
; de == receiving card?
	push af
	push bc
	push de
	ld hl, ReceiveCardTextPointers
.fetch_loop
; bc = card ID
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
; fallback if bc == $ffff terminator
; check de against bc
	jr z, .fallback
	ld a, b
	cp d
	jr c, .next
	jr nz, .next
	ld a, c
	cp e
.next
; proceed if de == bc, loop otherwise
; table_width == 11, already read 2
	jr z, .fetch_name
	ld a, 11 - 2
	add l
	ld l, a
	jr nc, .no_overflow
	inc h
.no_overflow
	jr .fetch_loop
.fallback
	call LoadCardDataToBuffer1_FromCardID
	ld a, 18
	call CopyCardNameAndLevel
	ld [hl], 0
	ld bc, 0
	jr .got_name
.fetch_name
; bc = long card name, fallback if 0
	ld a, [hli]
	ld c, a
	ld a, [hli]
	ld b, a
	or c
	jr z, .fallback
	; fallthrough
.got_name
	ld l, c
	ld h, b
	pop de
	pop bc
	pop af
	ret

GetReceivingCardShortName:
; the first half is a dupe of the above one
; de == receiving card?
	push af
	push bc
	push de
	ld hl, ReceiveCardTextPointers
.fetch_loop
; bc = card ID
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
; fallback if bc == $ffff terminator
; check de against bc
	jr z, .fallback
	ld a, b
	cp d
	jr c, .next
	jr nz, .next
	ld a, c
	cp e
.next
; proceed if de == bc, loop otherwise
; table_width == 11, already read 2
	jr z, .fetch_short_name
	ld a, 11 - 2
	add l
	ld l, a
	jr nc, .no_overflow
	inc h
.no_overflow
	jr .fetch_loop
.fallback
	call LoadCardDataToBuffer1_FromCardID
	ld a, 18
	call CopyCardNameAndLevel
	ld [hl], 0
	ld bc, 0
	jr .got_short_name
.fetch_short_name
; bc = short card name, fallback if 0
	inc hl
	inc hl
	ld a, [hli]
	ld c, a
	ld a, [hli]
	ld b, a
	or c
	jr z, .fallback
	; fallthrough
.got_short_name
	ld l, c
	ld h, b
	pop de
	pop bc
	pop af
	ret

GetReceivedCardText:
; the first half is a dupe of the above two
; de == receiving card?
	push af
	push bc
	push de
	ld hl, ReceiveCardTextPointers
.fetch_loop
	ld a, [hli]
	ld c, a
	ld a, [hli]
	ld b, a
	ld a, b
	cp $ff
	jr c, .ok
	jr nz, .ok
	ld a, c
	cp $ff
.ok
; fallback if bc == $ffff terminator
; check de against bc
	jr z, .fallback
	ld a, b
	cp d
	jr c, .next
	jr nz, .next
	ld a, c
	cp e
.next
; proceed if de == bc, loop otherwise
; table_width == 11, already read 2
	jr z, .fetch_received_text
	ld a, 11 - 2
	add l
	ld l, a
	jr nc, .no_overflow
	inc h
.no_overflow
	jr .fetch_loop
.fallback
	push hl
	call GetReceivingCardShortName
	call LoadTxRam2
	pop hl
	call LoadCardDataToBuffer1_FromCardID
	ldtx bc, ReceivedPromotionalCardText_2
	ld a, [wLoadedCard1Set]
	cp 7
	jr z, .got_text
	ldtx bc, ReceivedCardText_2
	jr .got_text
.fetch_received_text
; bc = received text
	REPT 4
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
	; check alt flag
	ld a, [hli]
	or a
	jr z, .got_text
	call GetEventValue
	jr z, .got_text
	; fetch alt text
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
Data_c651::
	dba Data_40462 ; $00
	dba Data_30080 ; $01
	dbw $10, $4db3 ; $02
	dbw $0f, $4603 ; $03
	dbw $0f, $47dc ; $04
	dbw $0b, $4000 ; $05
	dbw $0f, $4b88 ; $06
	dbw $0f, $4c62 ; $07
	dbw $0b, $4479 ; $08
	dbw $0b, $4936 ; $09
	dbw $0b, $4afa ; $0a
	dbw $0b, $4d23 ; $0b
	dbw $0b, $530a ; $0c
	dbw $0b, $53c4 ; $0d
	dbw $0b, $55f8 ; $0e
	dbw $0b, $5930 ; $0f
	dbw $0b, $5a26 ; $10
	dbw $0b, $5c9f ; $11
	dbw $0b, $606d ; $12
	dbw $0f, $4ee6 ; $13
	dbw $0b, $6163 ; $14
	dbw $0b, $64b7 ; $15
	dbw $0b, $663f ; $16
	dbw $0b, $68e6 ; $17
	dbw $0b, $6cc8 ; $18
	dbw $0b, $6dc5 ; $19
	dbw $0b, $7012 ; $1a
	dbw $0b, $74ff ; $1b
	dbw $0b, $75fc ; $1c
	dbw $0b, $77ca ; $1d
	dbw $0d, $4575 ; $1e
	dbw $0d, $4773 ; $1f
	dbw $0f, $519e ; $20
	dbw $0f, $52d7 ; $21
	dbw $10, $5592 ; $22
	dbw $0b, $7cd5 ; $23
	dbw $0f, $55d1 ; $24
	dbw $0f, $5d58 ; $25
	dbw $0b, $7e45 ; $26
	dbw $0d, $4aaf ; $27
	dbw $10, $5be9 ; $28
	dbw $0f, $6698 ; $29
	dbw $0f, $68e0 ; $2a
	dbw $0f, $6cea ; $2b
	dbw $0f, $6efa ; $2c
	dbw $0d, $4ba8 ; $2d
	dbw $0d, $4e4d ; $2e
	dbw $0f, $704c ; $2f
	dbw $0f, $71f2 ; $30
	dbw $0d, $509f ; $31
	dbw $0f, $73c2 ; $32
	dbw $0c, $518a ; $33
	dbw $0c, $5324 ; $34
	dbw $10, $5e8e ; $35
	dbw $0c, $53ce ; $36
	dbw $0d, $5288 ; $37
	dbw $10, $65cf ; $38
	dbw $0c, $54fe ; $39
	dbw $0c, $55d8 ; $3a
	dbw $0c, $5785 ; $3b
	dbw $0c, $5973 ; $3c
	dbw $0c, $5b29 ; $3d
	dbw $0d, $54a2 ; $3e
	dbw $0c, $5cbf ; $3f
	dbw $0c, $5dd2 ; $40
	dbw $0c, $5fad ; $41
	dbw $0c, $6148 ; $42
	dbw $0c, $641e ; $43
	dbw $0c, $6531 ; $44
	dbw $0c, $6696 ; $45
	dbw $0c, $6804 ; $46
	dbw $0c, $696d ; $47
	dbw $0c, $6beb ; $48
	dbw $0c, $6e20 ; $49
	dbw $0c, $6f5b ; $4a
	dbw $0f, $75ab ; $4b
	dbw $0c, $70c0 ; $4c
	dbw $0d, $55de ; $4d
	dbw $0d, $580f ; $4e
	dbw $0c, $724d ; $4f
	dbw $0c, $7357 ; $50
	dbw $0d, $5989 ; $51
	dbw $10, $6e2b ; $52
	dbw $0c, $7506 ; $53
	dbw $0c, $75da ; $54
	dbw $0c, $762f ; $55
	dbw $0c, $7723 ; $56
	dbw $0c, $7766 ; $57
	dbw $0c, $77bb ; $58
	dbw $0c, $7822 ; $59
	dbw $0c, $7928 ; $5a
	dbw $0c, $797d ; $5b
	dbw $0c, $79b2 ; $5c
	dbw $0c, $7a19 ; $5d
	dbw $0c, $7ab4 ; $5e
	dbw $0c, $7b1b ; $5f
	dbw $0c, $7ba4 ; $60
	dbw $0d, $5c10 ; $61
	dbw $0c, $7bf9 ; $62
	dbw $0d, $5c9a ; $63
	dbw $0f, $77b5 ; $64
	dbw $0c, $7d2e ; $65
	dbw $10, $6e80 ; $66
	dbw $0c, $7d63 ; $67
	dbw $0f, $7884 ; $68
	dbw $0d, $5d36 ; $69
	dbw $0d, $5f14 ; $6a
	dbw $0d, $6097 ; $6b
	dbw $0d, $6173 ; $6c
	dbw $0d, $631f ; $6d
	dbw $0d, $6c9b ; $6e
	dbw $0c, $7d98 ; $6f
	dbw $0d, $6f9a ; $70
	dbw $0d, $7365 ; $71
	dbw $0d, $75df ; $72
	dbw $10, $6ed5 ; $73

INCLUDE "data/npc_duelists.asm"

Data_cc9b:
	db $00, $08, $ff
	db $00, $08, $ff
	db $00, $00, $ff
	db $00, $01, $ff
	db $00, $09, $ff
	db $00, $02, $00, $ff
	db $00, $00, $ff
	db $00, $01, $ff
	db $00, $00, $ff
	db $00, $04, $04, $ff
	db $00, $00, $ff
	db $00, $02, $02, $ff
	db $00, $01, $00, $ff
	db $00, $03, $ff
	db $00, $02, $02, $ff
	db $00, $00, $00, $ff
	db $00, $03, $00, $ff
	db $00, $01, $ff
	db $00, $02, $ff
	db $00, $02, $02, $ff
	db $00, $04, $02, $ff
	db $00, $00, $00, $ff
	db $00, $01, $01, $ff
	db $00, $02, $ff
	db $00, $03, $03, $ff
	db $00, $00, $00, $ff
	db $00, $04, $04, $ff
	db $00, $01, $01, $ff
	db $00, $03, $02, $ff
	db $00, $03, $02, $ff
	db $00, $04, $03, $ff
	db $00, $03, $03, $ff
	db $00, $00, $ff
	db $00, $01, $01, $ff
	db $00, $00, $00, $ff
	db $00, $03, $03, $ff
	db $00, $02, $ff
	db $00, $00, $ff
	db $00, $04, $04, $ff
	db $00, $02, $01, $ff
	db $00, $00, $00, $ff
	db $00, $06, $05, $ff
	db $00, $03, $ff
	db $00, $04, $ff
	db $00, $00, $ff
	db $00, $04, $00, $ff
	db $00, $05, $00, $ff
	db $00, $05, $01, $ff
	db $00, $05, $02, $ff
	db $00, $06, $02, $ff
	db $00, $05, $ff
	db $00, $05, $ff
	db $00, $05, $ff
	db $00, $05, $05, $ff
	db $00, $05, $ff
	db $00, $05, $ff
	db $00, $05, $05, $ff
	db $00, $01, $00, $ff
	db $00, $02, $ff
	db $00, $05, $ff
	db $00, $06, $05, $ff
	db $00, $06, $05, $ff
	db $00, $02, $ff
	db $00, $03, $ff
	db $00, $06, $ff
	db $00, $05, $05, $ff
	db $00, $06, $03, $ff
	db $00, $06, $04, $ff
	db $00, $06, $05, $ff
	db $00, $06, $00, $ff
	db $00, $06, $01, $ff
	db $00, $05, $01, $ff
	db $00, $05, $02, $ff
	db $00, $06, $06, $ff
	db $00, $01, $01, $ff
	db $00, $02, $02, $ff
	db $00, $03, $03, $ff
	db $00, $05, $03, $ff
	db $00, $06, $04, $ff
	db $00, $06, $06, $ff
	db $00, $09, $ff
	db $00, $03, $02, $00, $ff
	db $00, $03, $02, $ff
	db $00, $03, $02, $01, $ff
	db $00, $06, $05, $ff
	db $01, $02, $00, $01, $02, $03, $04, $05, $06, $ff
	db $02, $02, $00, $01, $02, $ff
	db $02, $04, $00, $01, $02, $ff
	db $02, $04, $00, $01, $02, $03, $ff
	db $02, $04, $00, $01, $02, $03, $04, $ff
	db $02, $02, $02, $05, $06, $ff
	db $02, $04, $01, $02, $05, $06, $ff
	db $02, $04, $02, $03, $04, $05, $06, $ff
	db $02, $04, $00, $01, $02, $03, $04, $05, $06, $ff
	db $00, $0a, $0a, $0a, $ff
	db $00, $0b, $0a, $0a, $ff
	db $00, $0c, $0b, $0a, $ff
	db $00, $0a, $ff
	db $00, $0b, $ff
	db $00, $0c, $ff
	db $00, $00, $ff
	db $00, $01, $ff
	db $00, $02, $ff
	db $00, $05, $ff
	db $00, $06, $ff
	db $00, $09, $ff

INCLUDE "data/card_receive_texts.asm"

TextIDs_d171:
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

TextIDs_d18f:
	tx MapGRAirportText        ; OWMAP_GR_AIRPORT
	tx MapIshiharasVillaText   ; OWMAP_ISHIHARAS_VILLA
	tx MapGameCenterText       ; OWMAP_GAME_CENTER
	tx MapSealedFortText       ; OWMAP_SEALED_FORT
	tx MapGRChallengeHallText  ; OWMAP_GR_CHALLENGE_HALL
	tx MapGRGrassFortText      ; OWMAP_GR_GRASS_FORT
	tx MapGRLightningFortText  ; OWMAP_GR_LIGHTNING_FORT
	tx MapGRFireFortText       ; OWMAP_GR_FIRE_FORT
	tx MapGRWaterFortText      ; OWMAP_GR_WATER_FORT
	tx MapGRFightingFortText   ; OWMAP_GR_FIGHTING_FORT
	tx MapGRPsychicStrongholdText  ; OWMAP_GR_PSYCHIC_STRONGHOLD
	tx MapGRColorlessAltarText ; OWMAP_COLORLESS_ALTAR
	tx MapGRCastleText         ; OWMAP_GR_CASTLE

NonSpecialPromo_d1a9:
	; 34 promo cards
	; just excluding Legendaries, Phantoms, Bill's Computer and related ones, and GR Mewtwo
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

; two tables from $0e to $6c (without $10, $16, $42, $59, and $62--$66) in ascending order
Data_d1ed:
	db $12, $07
	db $13, $07
	db $14, $07
	db $15, $07
	db $18, $07
	db $19, $07
	db $1a, $07
	db $1c, $07
	db $1d, $07
	db $1e, $07
	db $20, $07
	db $21, $07
	db $22, $07
	db $23, $07
	db $25, $07
	db $26, $07
	db $27, $07
	db $28, $07
	db $2a, $07
	db $2b, $07
	db $2c, $07
	db $2e, $07
	db $2f, $07
	db $30, $07
	db $31, $07
	db $33, $07
	db $34, $07
	db $35, $07
	db $11, $08
	db $17, $08
	db $1b, $08
	db $1f, $08
	db $24, $08
	db $29, $08
	db $2d, $08
	db $32, $08
	db $37, $08
	db $38, $08
	db $39, $08
	db $36, $08
	db $0e, $10
	db $0f, $10
	db $3a, $10
	db $3b, $10
	db $3c, $10
	db $3d, $10
	db $67, $10
	db $69, $10
	db $6a, $10
Data_d24f:
	db $3e, $07
	db $3f, $07
	db $40, $07
	db $43, $07
	db $44, $07
	db $46, $07
	db $47, $07
	db $48, $07
	db $4a, $07
	db $4b, $07
	db $4c, $07
	db $4e, $07
	db $4f, $07
	db $51, $07
	db $52, $07
	db $53, $07
	db $54, $07
	db $41, $08
	db $45, $08
	db $49, $08
	db $4d, $08
	db $50, $08
	db $55, $08
	db $56, $08
	db $57, $08
	db $58, $08
	db $5a, $10
	db $5b, $10
	db $5c, $10
	db $5d, $10
	db $5e, $10
	db $5f, $10
	db $60, $10
	db $61, $10
	db $68, $10
	db $6b, $10
	db $6c, $10

Func_d299::
	push af
	ldh a, [hKeysHeld]
	bit A_BUTTON_F, a
	jr z, .skip_nop
	bit B_BUTTON_F, a
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
	farcall Func_10413
	ld b, $00
	ld a, [wd58a]
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
	farcall Func_10eff
	ld b, $01
	farcall Func_10f16
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
	jr nz, .asm_d357
	bit 0, a
	jr z, .asm_d333
	ld a, $04
	call Func_3154
	ld a, $0f
	call Func_3154
	ret
.asm_d357
	ld a, [wNPCDuelDeckID]
	ld c, a
	ld a, VAR_NPC_DECK_ID
	call SetVarValue
	ld a, [wDuelStartTheme]
	ld c, a
	ld a, VAR_3D
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

; a = ?
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
	farcall Func_10da7
	pop af
	push de
	farcall Func_10dcb
	pop de
	ld a, b
	rlca
	ld hl, .data
	add l
	ld l, a
	jr nc, .no_overflow
	inc h
.no_overflow
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

Func_d411:
	call PauseSong
	ld a, MUSIC_PCMAINMENU
	call PlaySong
	farcall Func_110c6
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
	ld hl, Data_c651
	add hl, bc
	ld a, [hli]
	ld c, a     ; bank
	ld a, [hli] ; offset
	ld h, [hl]  ;
	ld l, a
	ld a, c
	ld de, wd58a
	ld bc, $5
	call CopyFarHLToDE
	ld a, [wd586]
	ld [wd584], a
	pop af
	ld [wd586], a
	ld a, $ff
	ld [wd585], a
	ret

; a = OW object ID
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
	farcall SetOWObjectDirection
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
	farcall SetOWObjectDirection
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
	ld bc, $68
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
	ld c, $00
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

Func_d6b8:
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
	ld c, $00
	call SetEventValue
	pop hl
	pop bc
	ret

Func_d6f0:
	call GetByteAfterCall
;	fallthrough
ZeroOutVarValue:
	push bc
	ld c, 0
	call SetVarValue
	pop bc
	ret

Func_d6fb:
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
	db $00, %00000010 ; EVENT_01
	db $00, %00000100 ; EVENT_02
	db $00, %00001000 ; EVENT_03
	db $01, %00000001 ; EVENT_GOT_CHANSEY_COIN
	db $01, %00000010 ; EVENT_GOT_ODDISH_COIN
	db $01, %00000100 ; EVENT_GOT_CHARMANDER_COIN
	db $01, %00001000 ; EVENT_GOT_STARMIE_COIN
	db $01, %00010000 ; EVENT_GOT_PIKACHU_COIN
	db $01, %00100000 ; EVENT_GOT_ALAKAZAM_COIN
	db $01, %01000000 ; EVENT_GOT_KABUTO_COIN
	db $02, %00001111 ; EVENT_GOT_GR_COIN
	db $02, %00000001 ; EVENT_GOT_GR_COIN_PIECE_1
	db $02, %00000010 ; EVENT_GOT_GR_COIN_PIECE_2
	db $02, %00000100 ; EVENT_GOT_GR_COIN_PIECE_3
	db $02, %00001000 ; EVENT_GOT_GR_COIN_PIECE_4
	db $02, %00010000 ; EVENT_GOT_MAGNEMITE_COIN
	db $02, %00100000 ; EVENT_GOT_GOLBAT_COIN
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
	db $05, %00000001 ; EVENT_20
	db $05, %00000010 ; EVENT_21
	db $05, %00000100 ; EVENT_22
	db $05, %00001000 ; EVENT_23
	db $06, %00000001 ; EVENT_24
	db $06, %00000010 ; EVENT_25
	db $06, %00000100 ; EVENT_26
	db $06, %00001000 ; EVENT_27
	db $07, %00000001 ; EVENT_28
	db $07, %00000010 ; EVENT_29
	db $07, %00000100 ; EVENT_2A
	db $07, %00001000 ; EVENT_2B
	db $07, %00010000 ; EVENT_2C
	db $08, %00000001 ; EVENT_2D
	db $08, %00000010 ; EVENT_2E
	db $08, %00000100 ; EVENT_2F
	db $08, %00001000 ; EVENT_30
	db $09, %00000001 ; EVENT_31
	db $09, %00000010 ; EVENT_32
	db $09, %00000100 ; EVENT_33
	db $09, %00001000 ; EVENT_34
	db $09, %00010000 ; EVENT_35
	db $09, %00100000 ; EVENT_36
	db $0a, %00000001 ; EVENT_37
	db $0a, %00000010 ; EVENT_38
	db $0a, %00000100 ; EVENT_39
	db $0a, %00001000 ; EVENT_3A
	db $0a, %00010000 ; EVENT_3B
	db $0b, %00000001 ; EVENT_3C
	db $0b, %00000010 ; EVENT_3D
	db $0b, %00000100 ; EVENT_3E
	db $0b, %00001000 ; EVENT_3F
	db $0c, %00000001 ; EVENT_40
	db $0c, %00000010 ; EVENT_41
	db $0c, %00000100 ; EVENT_42
	db $0c, %00001000 ; EVENT_43
	db $0c, %00100000 ; EVENT_44
	db $0c, %01000000 ; EVENT_45
	db $0d, %00000001 ; EVENT_46
	db $0d, %00000010 ; EVENT_47
	db $0d, %00000100 ; EVENT_48
	db $0d, %00001000 ; EVENT_49
	db $0d, %00010000 ; EVENT_4A
	db $0d, %00100000 ; EVENT_4B
	db $0d, %01000000 ; EVENT_4C
	db $0d, %10000000 ; EVENT_4D
	db $0e, %00000001 ; EVENT_4E
	db $0e, %00000010 ; EVENT_4F
	db $0e, %00000100 ; EVENT_50
	db $0e, %00001000 ; EVENT_51
	db $0e, %00010000 ; EVENT_52
	db $0e, %00100000 ; EVENT_53
	db $0e, %01000000 ; EVENT_54
	db $0f, %00000001 ; EVENT_55
	db $0f, %00000010 ; EVENT_56
	db $0f, %00000100 ; EVENT_57
	db $0f, %00001000 ; EVENT_58
	db $0f, %00010000 ; EVENT_59
	db $0f, %00100000 ; EVENT_5A
	db $0f, %01000000 ; EVENT_5B
	db $0f, %10000000 ; EVENT_5C
	db $10, %00000001 ; EVENT_5D
	db $10, %00000010 ; EVENT_5E
	db $10, %00000100 ; EVENT_5F
	db $10, %00001000 ; EVENT_60
	db $10, %00010000 ; EVENT_61
	db $10, %00100000 ; EVENT_62
	db $10, %01000000 ; EVENT_63
	db $10, %10000000 ; EVENT_64
	db $11, %00000001 ; EVENT_65
	db $11, %00000010 ; EVENT_66
	db $11, %00000100 ; EVENT_67
	db $11, %00001000 ; EVENT_68
	db $11, %00010000 ; EVENT_69
	db $11, %00100000 ; EVENT_6A
	db $12, %00000001 ; EVENT_6B
	db $12, %00000010 ; EVENT_6C
	db $12, %00000100 ; EVENT_6D
	db $12, %00001000 ; EVENT_6E
	db $12, %00010000 ; EVENT_6F
	db $12, %00100000 ; EVENT_70
	db $12, %01000000 ; EVENT_71
	db $12, %10000000 ; EVENT_72
	db $13, %00000001 ; EVENT_73
	db $13, %00000010 ; EVENT_74
	db $14, %00000001 ; EVENT_75
	db $14, %00000010 ; EVENT_76
	db $14, %00000100 ; EVENT_77
	db $14, %00001000 ; EVENT_78
	db $14, %00010000 ; EVENT_79
	db $14, %00100000 ; EVENT_7A
	db $14, %00111000 ; EVENT_7B
	db $14, %01000000 ; EVENT_7C
	db $14, %10000000 ; EVENT_7D
	db $15, %00000001 ; EVENT_7E
	db $16, %00000001 ; EVENT_7F
	db $16, %00000010 ; EVENT_80
	db $16, %00000100 ; EVENT_81
	db $16, %00001000 ; EVENT_82
	db $16, %00010000 ; EVENT_83
	db $17, %00000001 ; EVENT_84
	db $18, %00000001 ; EVENT_85
	db $18, %00000010 ; EVENT_86
	db $18, %00000100 ; EVENT_87
	db $18, %00001000 ; EVENT_88
	db $18, %00010000 ; EVENT_89
	db $18, %00100000 ; EVENT_8A
	db $18, %01000000 ; EVENT_8B
	db $18, %10000000 ; EVENT_8C
	db $19, %00000001 ; EVENT_8D
	db $19, %00000010 ; EVENT_8E
	db $19, %00000100 ; EVENT_8F
	db $19, %00001000 ; EVENT_90
	db $19, %00010000 ; EVENT_91
	db $19, %00100000 ; EVENT_92
	db $19, %01000000 ; EVENT_93
	db $19, %10000000 ; EVENT_94
	db $1a, %00000001 ; EVENT_95
	db $1a, %00000010 ; EVENT_96
	db $1a, %00000100 ; EVENT_97
	db $1b, %00000001 ; EVENT_98
	db $1b, %00000010 ; EVENT_99
	db $1b, %00000100 ; EVENT_9A
	db $1b, %00001000 ; EVENT_9B
	db $1b, %00010000 ; EVENT_9C
	db $1b, %00100000 ; EVENT_9D
	db $1b, %01000000 ; EVENT_9E
	db $1b, %10000000 ; EVENT_9F
	db $1c, %00000001 ; EVENT_A0
	db $1c, %00000010 ; EVENT_A1
	db $1c, %00000100 ; EVENT_A2
	db $1d, %00000001 ; EVENT_A3
	db $1d, %00000010 ; EVENT_A4
	db $1d, %00000100 ; EVENT_A5
	db $1d, %00001000 ; EVENT_A6
	db $1d, %00010000 ; EVENT_A7
	db $1d, %00100000 ; EVENT_A8
	db $1d, %01000000 ; EVENT_A9
	db $1d, %10000000 ; EVENT_AA
	db $1e, %00000001 ; EVENT_AB
	db $1e, %00000010 ; EVENT_AC
	db $1e, %00000100 ; EVENT_AD
	db $1e, %00001000 ; EVENT_AE
	db $1e, %00010000 ; EVENT_AF
	db $1e, %00100000 ; EVENT_B0
	db $1e, %01000000 ; EVENT_B1
	db $1e, %10000000 ; EVENT_B2
	db $1f, %00000001 ; EVENT_B3
	db $1f, %00000010 ; EVENT_B4
	db $1f, %00000100 ; EVENT_B5
	db $1f, %00001000 ; EVENT_B6
	db $1f, %00010000 ; EVENT_B7
	db $1f, %00100000 ; EVENT_B8
	db $20, %00000001 ; EVENT_B9
	db $20, %00000010 ; EVENT_BA
	db $21, %00000001 ; EVENT_BB
	db $21, %00000010 ; EVENT_BC
	db $21, %00000100 ; EVENT_BD
	db $21, %00001000 ; EVENT_BE
	db $21, %00010000 ; EVENT_BF
	db $21, %00100000 ; EVENT_C0
	db $21, %01000000 ; EVENT_C1
	db $21, %10000000 ; EVENT_C2
	db $22, %00000001 ; EVENT_C3
	db $22, %00000010 ; EVENT_C4
	db $22, %00000100 ; EVENT_C5
	db $22, %00001000 ; EVENT_C6
	db $23, %00000001 ; EVENT_C7
	db $23, %00000010 ; EVENT_C8
	db $23, %00000100 ; EVENT_C9
	db $23, %00011000 ; EVENT_CA
	db $23, %00001000 ; EVENT_CB
	db $23, %00010000 ; EVENT_CC
	db $23, %00100000 ; EVENT_CD
	db $24, %00000011 ; EVENT_CE
	db $24, %00000001 ; EVENT_CF
	db $24, %00000010 ; EVENT_D0
	db $24, %00000100 ; EVENT_D1
	db $25, %00000001 ; EVENT_D2
	db $25, %00000010 ; EVENT_D3
	db $25, %00000100 ; EVENT_D4
	db $25, %00001000 ; EVENT_D5
	db $25, %00010000 ; EVENT_D6
	db $25, %00100000 ; EVENT_D7
	db $25, %01000000 ; EVENT_D8
	db $26, %00000001 ; EVENT_D9
	db $26, %00000010 ; EVENT_DA
	db $26, %00000100 ; EVENT_DB
	db $27, %00000001 ; EVENT_DC
	db $27, %00000010 ; EVENT_DD
	db $28, %00000001 ; EVENT_DE
	db $28, %00000010 ; EVENT_DF
	db $28, %00000100 ; EVENT_E0
	db $28, %00001000 ; EVENT_E1
	db $28, %00010000 ; EVENT_E2
	db $28, %00100000 ; EVENT_E3
	db $28, %01000000 ; EVENT_E4
	db $28, %10000000 ; EVENT_E5
	db $29, %00000001 ; EVENT_E6
	db $29, %00000010 ; EVENT_E7
	db $29, %00000100 ; EVENT_E8
	db $29, %00001000 ; EVENT_E9
	db $29, %00010000 ; EVENT_EA
	db $2a, %00000001 ; EVENT_EB
	db $2a, %00000010 ; EVENT_EC
	db $2b, %00000001 ; EVENT_ED
	db $2b, %00000010 ; EVENT_EE
	db $2b, %00000100 ; EVENT_EF
	db $33, %00000001 ; EVENT_F0
	db $33, %00000010 ; EVENT_F1
	db $33, %00000100 ; EVENT_F2
	db $33, %00001000 ; EVENT_F3
	db $33, %00010000 ; EVENT_F4
	db $33, %00100000 ; EVENT_F5

; extra events?
GeneralVarMasks:
	db $00, %11111111 ; VAR_00
	db $01, %00000011 ; VAR_01
	db $01, %00111100 ; VAR_02
	db $01, %11000000 ; VAR_03
	db $02, %00001111 ; VAR_04
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
	db $18, %11110000 ; VAR_22
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
	db $2c, %11111111 ; VAR_3D
	db $33, %11111111 ; VAR_3E

SECTION "Bank 3@5bbd", ROMX[$5bbd], BANK[$3]

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
	ld a, EVENT_GOT_GOLBAT_COIN
	call GetEventValue
	jr z, .got_num_steps
	inc c
.got_num_steps
	ld a, c
	pop bc
	ret

Func_dbdb::
	xor a
	ld [wd61a], a
	ld hl, wd61b
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld de, wd61e
	ld bc, $20
	ld a, [wd619]
	call CopyFarHLToDE
	ret

Func_dbf2::
	ld hl, wd61a
	ld a, [hl]
	ld hl, wd61e
	add l
	ld l, a
	jr nc, .asm_dbfe
	inc h
.asm_dbfe
	ld a, [hl]
	ld d, a
	ld hl, .PointerTable
	add l
	ld l, a
	jr nc, .asm_dc08
	inc h
.asm_dc08
	ld a, d
	add l
	ld l, a
	jr nc, .asm_dc0e
	inc h
.asm_dc0e
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp hl

.PointerTable
	dw $5d91
	dw $5d9c
	dw $5da6
	dw $5dad
	dw $5db9
	dw $5dd1
	dw $5de3
	dw $5e01
	dw $5e1f
	dw $5e30
	dw $5e3b
	dw $5e46
	dw $5e51
	dw $5e5c
	dw $5e76
	dw $5e7f
	dw $5e88
	dw $5e9d
	dw $5ea8
	dw $5eb4
	dw $5ec4
	dw $5ed4
	dw $5eeb
	dw $5ef5
	dw $5f03
	dw $5f11
	dw $5f1e
	dw $5f2f
	dw $5f45
	dw $5f54
	dw $5f63
	dw $5f6d
	dw $5f87
	dw $5f9b
	dw $5fb5
	dw $5fd0
	dw $5fdc
	dw $5fe8
	dw $5ff3
	dw $6004
	dw $601e
	dw $604f
	dw $6070
	dw $608e
	dw $60b2
	dw $60c7
	dw $60da
	dw $60ed
	dw $60f3
	dw $60f9
	dw $6115
	dw $6131
	dw $613c
	dw $6147
	dw $616d
	dw $617b
	dw $61a0
	dw $61ae
	dw $61be
	dw $61ce
	dw $61de
	dw $6209
	dw $6217
	dw $6242
	dw $624c
	dw $6256
	dw $636b
	dw $637b
	dw $638b
	dw $6394
	dw $63a1
	dw $63ac
	dw $63c3
	dw $63cc
	dw $63da
	dw $63e8
	dw $63f8
	dw $6424
	dw $6450
	dw $6466
	dw $647e
	dw $64dd
	dw $64fc
	dw $6509
	dw $6512
	dw $6527
	dw $6531
	dw $65d7
	dw $65e3
	dw $65eb
	dw $65f6
	dw $6601
	dw $660d
	dw $6613
	dw $664e
	dw $6672
	dw $667f
	dw $6689
	dw $6697
	dw $66b1
	dw $66ce
	dw $670e
	dw $6724
	dw $673a
	dw $6746
	dw $6752
	dw $6764
	dw $6775
	dw $6786
	dw $679c
	dw $67ab
	dw $67d0
	dw $67df
	dw $67e6
	dw $67ed
	dw $67f7
	dw $6801
	dw $680f
	dw $6816
	dw $681d
	dw $6847
	dw $684e
	dw $685b
	dw $686a
	dw $6871
	dw $687d

SECTION "Bank 3@6883", ROMX[$6883], BANK[$3]

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
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld hl, wde11
	xor a
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld hl, wde15
	xor a
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld [hli], a

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
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld hl, wde11
	xor a
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld [hli], a
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
	inc hl
	inc hl
	inc hl
	inc hl
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
	inc hl
	inc hl
	inc hl
	inc hl
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
	inc hl
	inc hl
	inc hl
	inc hl
	jr .asm_eda2
.asm_ede4
	pop af
	call BankswitchSRAM
	call DisableSRAM
	ret
