IshiharasHouse_MapHeader:
	db MAP_GFX_ISHIHARAS_HOUSE
	dba IshiharasHouse_MapScripts
	db MUSIC_ISHIHARA

IshiharasHouse_StepEvents:
	map_exit 4, 12, OVERWORLD_MAP_TCG, 0, 2, SOUTH
	map_exit 5, 12, OVERWORLD_MAP_TCG, 0, 2, SOUTH
	db $ff

IshiharasHouse_NPCs:
	npc NPC_ISHIHARA, 4, 4, SOUTH, Func_2c1b8
	npc NPC_NIKKI, 5, 4, SOUTH, $6A, $44
	db $ff

IshiharasHouse_NPCInteractions:
	npc_script NPC_ISHIHARA, $0b, $72, $41
	npc_script NPC_NIKKI, $0b, $cb, $43
	db $ff

IshiharasHouse_OWInteractions:
	ow_script 3, 2, $10, $00, $40
	ow_script 4, 2, $10, $16, $40
	ow_script 5, 2, $10, $2c, $40
	ow_script 6, 2, $10, $42, $40
	ow_script 7, 2, $10, $58, $40
	ow_script 8, 2, $10, $6e, $40
	ow_script 1, 9, $10, $84, $40
	ow_script 2, 9, $10, $9a, $40
	ow_script 3, 9, $10, $b0, $40
	ow_script 6, 9, $10, $c6, $40
	ow_script 7, 9, $10, $dc, $40
	ow_script 8, 9, $10, $f2, $40
	db $ff

IshiharasHouse_MapScripts:
	dbw $06, Func_2c0c1
	dbw $08, Func_2c0f1
	dbw $07, Func_2c0c8
	dbw $02, Func_2c0d1
	dbw $0c, Func_2c101
	dbw $0d, Func_2c12f
	dbw $0b, Func_2c13e
	dbw $01, Func_2c0b4
	db $ff

Func_2c0b4:
	call Func_2c1b8
	jr nc, .asm_2c0be
	ld a, MUSIC_OVERWORLD
	ld [wNextMusic], a
.asm_2c0be
	scf
	ccf
	ret

Func_2c0c1:
	ld hl, IshiharasHouse_StepEvents
	call Func_324d
	ret

Func_2c0c8:
	ld hl, IshiharasHouse_NPCs
	call Func_3205
	scf
	ccf
	ret

Func_2c0d1:
	xor a
	start_script
	script_command_64 $11
	end_script
	ld a, EVENT_F5
	farcall GetEventValue
	jr z, .asm_2c0ef
	ld a, NPC_ISHIHARA
	lb de, 1, 2
	farcall SetOWObjectTilePosition
	ld b, NORTH
	farcall SetOWObjectDirection
.asm_2c0ef
	scf
	ret

Func_2c0f1:
	ld hl, IshiharasHouse_NPCInteractions
	call Func_328c
	jr nc, .asm_2c0ff
	ld hl, IshiharasHouse_OWInteractions
	call Func_32bf
.asm_2c0ff
	scf
	ret

Func_2c101:
	xor a
	push af
	ld a, EVENT_F5
	farcall GetEventValue
	jr z, .asm_2c10f
	pop af
	or $01
	push af
.asm_2c10f
	ld a, EVENT_ISHIHARA_CARD_TRADE_STATE
	farcall GetEventValue
	jr z, .asm_2c11b
	pop af
	or $02
	push af
.asm_2c11b
	pop af
	or a
	jr z, .asm_2c12c
	ld c, a
	ld a, VAR_00
	farcall SetVarValue
	ld a, EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE_DUMMY
	farcall MaxOutEventValue
.asm_2c12c
	scf
	ccf
	ret

Func_2c12f:
	ld a, EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE_DUMMY
	farcall ZeroOutEventValue
	ld a, VAR_00
	farcall ZeroOutVarValue
	scf
	ccf
	ret

Func_2c13e:
	ld a, EVENT_F5
	farcall ZeroOutEventValue
	ld a, VAR_00
	farcall GetVarValue
	bit 0, a
	push af
	call nz, Func_2c164
	pop af
	bit 1, a
	call nz, Func_2c16b
	ld a, EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE_DUMMY
	farcall ZeroOutEventValue
	ld a, VAR_00
	farcall ZeroOutVarValue
	scf
	ret

Func_2c164:
	ld a, EVENT_F5
	farcall MaxOutEventValue
	ret

Func_2c16b:
	ld a, EVENT_ISHIHARA_CARD_TRADE_STATE
	farcall MaxOutEventValue
	ret
; 0x2c172

SECTION "Bank b@41b8", ROMX[$41b8], BANK[$b]

Func_2c1b8:
	ld a, VAR_02
	farcall GetVarValue
	cp 5
	jr c, .asm_2c1d8
	jr nz, .asm_2c1ce
	ld a, EVENT_ISHIHARA_CARD_TRADE_STATE
	farcall GetEventValue
	jr nz, .asm_2c1d8
	jr .asm_2c1d6
.asm_2c1ce
	ld a, EVENT_F5
	farcall GetEventValue
	jr nz, .asm_2c1d8
.asm_2c1d6
	scf
	ret
.asm_2c1d8
	scf
	ccf
	ret
; 0x2c1db

SECTION "Bank b@4479", ROMX[$4479], BANK[$b]

LightningClub_MapHeader:
	db MAP_GFX_LIGHTNING_CLUB_1
	dba LightningClub_MapScripts
	db MUSIC_CLUB_1

LightningClub_StepEvents:
	map_exit 6, 15, MAP_LIGHTNING_CLUB_ENTRANCE, 4, 1, SOUTH
	map_exit 7, 15, MAP_LIGHTNING_CLUB_ENTRANCE, 5, 1, SOUTH
	db $ff

LightningClub_NPCs:
	npc NPC_ISAAC, 6, 2, SOUTH, NULL
	npc NPC_JENNIFER, 7, 9, SOUTH, $f9, $48
	npc NPC_NICHOLAS, 3, 5, SOUTH, NULL
	npc NPC_BRANDON, 11, 6, SOUTH, $f9, $48
	npc NPC_GR_4, 7, 4, SOUTH, $29, $49
	db $ff

LightningClub_NPCInteractions:
	npc_script NPC_ISAAC, $0b, $45, $46
	npc_script NPC_JENNIFER, $0b, $3b, $47
	npc_script NPC_NICHOLAS, $0b, $9d, $47
	npc_script NPC_BRANDON, $0b, $97, $48
	npc_script NPC_GR_4, $0b, $0e, $49
	db $ff

LightningClub_MapScripts:
	dbw $06, Func_2c4fa
	dbw $08, Func_2c560
	dbw $09, Func_2c568
	dbw $07, Func_2c501
	dbw $01, Func_2c4db
	dbw $02, Func_2c50a
	dbw $01, Func_2c4db
	db $ff

Func_2c4db:
	ld a, EVENT_GOT_PIKACHU_COIN
	farcall GetEventValue
	jr nz, .asm_2c4ea
	ld a, MUSIC_HERECOMESGR
	ld [wNextMusic], a
	jr .asm_2c4f7
.asm_2c4ea
	ld a, EVENT_SET_UNTIL_MAP_RELOAD_1
	farcall GetEventValue
	jr nz, .asm_2c4f7
	ld a, MAP_GFX_LIGHTNING_CLUB_2
	ld [wCurMapGfx], a
.asm_2c4f7
	scf
	ccf
	ret

Func_2c4fa:
	ld hl, LightningClub_StepEvents
	call Func_324d
	ret

Func_2c501:
	ld hl, LightningClub_NPCs
	call Func_3205
	scf
	ccf
	ret

Func_2c50a:
	ld a, EVENT_MET_GR4_LIGHTNING_CLUB
	farcall GetEventValue
	jr z, .asm_2c524
	ld a, EVENT_SET_UNTIL_MAP_RELOAD_1
	farcall GetEventValue
	jr nz, .asm_2c54f
	ld a, EVENT_GOT_PIKACHU_COIN
	farcall GetEventValue
	jr z, .asm_2c54f
	jr .asm_2c55e
.asm_2c524
	ld a, $0a
	ld [wd582], a
	ld a, $0b
	ld [wd592], a
	ld hl, $4584
	ld a, l
	ld [wd593], a
	ld a, h
	ld [wd593 + 1], a
	xor a
	start_script
	set_npc_position_and_direction NPC_ISAAC, 5, 9, SOUTH
	set_npc_position_and_direction NPC_NICHOLAS, 8, 9, SOUTH
	set_npc_position_and_direction NPC_GR_4, 7, 9, SOUTH
	end_script
	jr .asm_2c55e
.asm_2c54f
	xor a
	start_script
	set_npc_position_and_direction NPC_ISAAC, 5, 6, SOUTH
	set_npc_position_and_direction NPC_NICHOLAS, 8, 8, SOUTH
	end_script
.asm_2c55e
	scf
	ret

Func_2c560:
	ld hl, LightningClub_NPCInteractions
	call Func_328c
	scf
	ret

Func_2c568:
	ld hl, LightningClub_AfterDuelScripts
	ld a, [wScriptNPC]
	call Func_344c
	scf
	ret

LightningClub_AfterDuelScripts:
	npc_script NPC_ISAAC, $0b, $ec, $46
	npc_script NPC_JENNIFER, $0b, $81, $47
	npc_script NPC_NICHOLAS, $0b, $47, $48
	npc_script NPC_BRANDON, $0b, $dd, $48
	db $ff
; 0x2c584

SECTION "Bank b@4936", ROMX[$4936], BANK[$b]

PsychicClubEntrance_MapHeader:
	db MAP_GFX_PSYCHIC_CLUB_ENTRANCE
	dba PsychicClubEntrance_MapScripts
	db MUSIC_OVERWORLD

PsychicClubEntrance_StepEvents:
	map_exit 4, 8, OVERWORLD_MAP_TCG, 6, 3, SOUTH
	map_exit 5, 8, OVERWORLD_MAP_TCG, 6, 3, SOUTH
	map_exit 0, 3, MAP_PSYCHIC_CLUB_LOBBY, 14, 6, WEST
	map_exit 0, 4, MAP_PSYCHIC_CLUB_LOBBY, 14, 7, WEST
	map_exit 4, 0, MAP_PSYCHIC_CLUB, 6, 12, NORTH
	map_exit 5, 0, MAP_PSYCHIC_CLUB, 7, 12, NORTH
	ow_script 4, 2, Func_2ca3e
	ow_script 5, 2, Func_2ca3e
	db $ff

PsychicClubEntrance_NPCs:
	npc NPC_STEPHANIE, 5, 1, SOUTH, $bb, $4a
	db $ff

PsychicClubEntrance_NPCInteractions:
	npc_script NPC_STEPHANIE, $0b, $a0, $4a
	db $ff

PsychicClubEntrance_MapScripts:
	dbw $00, Func_2c9ac
	dbw $06, Func_2c9d8
	dbw $08, Func_2ca14
	dbw $09, Func_2ca1c
	dbw $07, Func_2c9df
	dbw $02, Func_2c9e8
	dbw $0b, Func_2ca22
	dbw $01, Func_2c9b8
	dbw $10, Func_2c9c8
	db $ff

Func_2c9ac:
	call Func_3332
	call Func_2ca46
	call Func_32d8
	scf
	ccf
	ret

Func_2c9b8:
	ld a, EVENT_GOT_GR_COIN_PIECE_BOTTOM_RIGHT
	farcall GetEventValue
	jr nz, .asm_2c9c5
	ld a, MUSIC_HERECOMESGR
	ld [wNextMusic], a
.asm_2c9c5
	scf
	ccf
	ret

Func_2c9c8:
	call PsychicClubEntrance_ShouldRonaldAppear
	jr nc, .appear
	scf
	ret
.appear
	ld a, MUSIC_RONALD
	farcall PlayAfterCurrentSong
	scf
	ccf
	ret

Func_2c9d8:
	ld hl, PsychicClubEntrance_StepEvents
	call Func_324d
	ret

Func_2c9df:
	ld hl, PsychicClubEntrance_NPCs
	call Func_3205
	scf
	ccf
	ret

Func_2c9e8:
	call PsychicClubEntrance_ShouldRonaldAppear
	jr c, .quit
	cp RONALD_DUEL_GC_PIECES_2
	jr z, .duel
	jr nc, .gift
; card pop
	ld hl, $4037
	jr .got_event
.duel
	ld hl, $417e
	jr .got_event
.gift
	ld hl, $41f7
.got_event
	ld a, $0a
	ld [wd582], a
	ld a, $0d
	ld [wd592], a
	ld a, l
	ld [wd593], a
	ld a, h
	ld [wd593 + 1], a
.quit
	scf
	ret

Func_2ca14:
	ld hl, PsychicClubEntrance_NPCInteractions
	call Func_328c
	scf
	ret

Func_2ca1c:
	farcall Script_FinishedRonaldDuelGCPieces2
	scf
	ret

Func_2ca22:
	ld a, EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE_DUMMY
	farcall GetEventValue
	jr z, .asm_2ca3c
	ld a, NPC_RONALD
	farcall ClearOWObject
	ld a, EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE_DUMMY
	farcall ZeroOutEventValue
	ld a, [wNextMusic]
	ld [wCurMusic], a
.asm_2ca3c
	scf
	ret

Func_2ca3e:
	call Func_2ca46
	farcall Func_c199
	ret

Func_2ca46:
	ld a, EVENT_GOT_PIKACHU_COIN
	farcall GetEventValue
	jr nz, .exit
	ldh a, [hKeysHeld]
	bit B_PAD_UP, a
	jr z, .exit
	ld a, [wPlayerOWObject]
	ld b, NORTH
	farcall SetOWObjectDirection
	farcall GetOWObjectTilePosition
	ld a, $02
	cp e
	jr nz, .exit
	ld a, $04
	cp d
	jr z, .asm_2ca86
	ld a, $05
	cp d
	jr nz, .exit
	ld a, NPC_STEPHANIE
	farcall GetOWObjectTilePosition
	ld a, $05
	cp d
	jr z, .exit
	ld a, NPC_STEPHANIE
	lb bc, $81, $01
	farcall Func_10e3c
	jr .asm_2ca9a
.asm_2ca86
	ld a, NPC_STEPHANIE
	farcall GetOWObjectTilePosition
	ld a, $04
	cp d
	jr z, .exit
	ld a, NPC_STEPHANIE
	lb bc, $83, $01
	farcall Func_10e3c
.asm_2ca9a
	ld a, NPC_STEPHANIE
	call Func_336d
.exit
	ret

; beating GR4 at Lightning Club unlocks Psychic Club sequence
Func_2caa0:
	ld a, NPC_STEPHANIE
	ld [wScriptNPC], a
	ldtx hl, DialogStephanieText
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [wScriptNPCName + 1], a
	xor a
	start_script
	script_command_01
	print_npc_text StephanieBeatGR4AtLightningClubFirstText
	script_command_02
	end_script
	ret

Func_2cabb:
	ld a, EVENT_GOT_PIKACHU_COIN
	farcall GetEventValue
	jr z, .asm_2cac5
	scf
	ret
.asm_2cac5
	scf
	ccf
	ret

; set carry if no Ronald events
; clear carry and return RONALD_* event in a
PsychicClubEntrance_ShouldRonaldAppear:
	ld a, VAR_TIMES_MET_RONALD
	farcall GetVarValue
	cp 2
	jr c, .second_meeting
	cp 3
	jr c, .third_meeting
	cp 4
	jr c, .fourth_meeting
.false
	scf
	ret
.second_meeting
	xor a
	scf
	ccf
	ret
.third_meeting
	farcall CountGRCoinPiecesObtained
	cp GC_PIECES_2
	jr nz, .false
	ld a, RONALD_DUEL_GC_PIECES_2
	scf
	ccf
	ret
.fourth_meeting
	farcall CountGRCoinPiecesObtained
	cp GC_PIECES_4
	jr nz, .false
	ld a, RONALD_GIFT_GC_PIECES_4
	scf
	ccf
	ret

PsychicClubLobby_MapHeader:
	db MAP_GFX_PSYCHIC_CLUB_LOBBY
	dba PsychicClubLobby_MapScripts
	db MUSIC_OVERWORLD

PsychicClubLobby_StepEvents:
	map_exit 15, 6, MAP_PSYCHIC_CLUB_ENTRANCE, 1, 3, EAST
	map_exit 15, 7, MAP_PSYCHIC_CLUB_ENTRANCE, 1, 4, EAST
	db $ff

PsychicClubLobby_NPCs:
	npc NPC_PSYCHIC_CLUB_GLASSES_LAD, 8, 8, EAST, NULL
	npc NPC_PSYCHIC_CLUB_LASS, 10, 9, WEST, NULL
	npc NPC_IMAKUNI_BLACK, 1, 10, WEST, $a8, $4c
	npc NPC_PSYCHIC_CLUB_CAPPED_LAD, 7, 6, EAST, NULL
	npc NPC_PSYCHIC_CLUB_GR_LASS, 14, 4, SOUTH, $0e, $4d
	npc NPC_CLERK_BATTLE_CENTER, 2, 2, SOUTH, NULL
	npc NPC_CLERK_GIFT_CENTER, 4, 2, SOUTH, NULL
	db $ff

PsychicClubLobby_NPCInteractions:
	npc_script NPC_PSYCHIC_CLUB_GLASSES_LAD, $0b, $11, $4c
	npc_script NPC_PSYCHIC_CLUB_LASS, $0b, $7d, $4c
	npc_script NPC_IMAKUNI_BLACK, $0f, $0c, $43
	npc_script NPC_PSYCHIC_CLUB_CAPPED_LAD, $0b, $b7, $4c
	npc_script NPC_PSYCHIC_CLUB_GR_LASS, $0b, $e8, $4c
	db $ff

PsychicClubLobby_OWInteractions:
	ow_script 8, 2, PCMenu
	ow_script 9, 2, PCMenu
	ow_script 2, 4, $0f, $b9, $41
	ow_script 4, 4, $0f, $d9, $42
	ow_script 12, 2, $10, $d6, $42
	ow_script 13, 2, $10, $ec, $42
	ow_script 14, 2, $10, $02, $43
	db $ff

PsychicClubLobby_MapScripts:
	dbw $06, Func_2cbcf
	dbw $08, Func_2cbdf
	dbw $07, Func_2cbd6
	dbw $09, Func_2cbef
	dbw $0b, Func_2cbf5
	dbw $01, Func_2cba8
	dbw $10, Func_2cbba
	db $ff

Func_2cba8:
	ld a, EVENT_GOT_GR_COIN_PIECE_BOTTOM_RIGHT
	farcall GetEventValue
	jr nz, .asm_2cbb7
	ld a, MUSIC_HERECOMESGR
	ld [wNextMusic], a
	jr .asm_2cbb7
.asm_2cbb7
	scf
	ccf
	ret

Func_2cbba:
	ld a, VAR_25
	farcall GetVarValue
	cp 3
	jr z, .asm_2cbc6
	scf
	ret
.asm_2cbc6
	ld a, MUSIC_IMAKUNI
	farcall PlayAfterCurrentSong
	scf
	ccf
	ret

Func_2cbcf:
	ld hl, PsychicClubLobby_StepEvents
	call Func_324d
	ret

Func_2cbd6:
	ld hl, PsychicClubLobby_NPCs
	call Func_3205
	scf
	ccf
	ret

Func_2cbdf:
	ld hl, PsychicClubLobby_NPCInteractions
	call Func_328c
	jr nc, .asm_2cbed
	ld hl, PsychicClubLobby_OWInteractions
	call Func_32bf
.asm_2cbed
	scf
	ret

Func_2cbef:
	farcall Script_FinishedImakuniBlackDuel
	scf
	ret

Func_2cbf5:
	ld a, EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE_DUMMY
	farcall GetEventValue
	jr z, .asm_2cc0f
	ld a, NPC_IMAKUNI_BLACK
	farcall ClearOWObject
	ld a, EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE_DUMMY
	farcall ZeroOutEventValue
	ld a, [wNextMusic]
	ld [wCurMusic], a
.asm_2cc0f
	scf
	ret
; 0x2cc11

SECTION "Bank b@4d23", ROMX[$4d23], BANK[$b]

PsychicClub_MapHeader:
	db MAP_GFX_PSYCHIC_CLUB
	dba PsychicClub_MapScripts
	db MUSIC_CLUB_2

PsychicClub_StepEvents:
	map_exit 6, 13, MAP_PSYCHIC_CLUB_ENTRANCE, 4, 1, SOUTH
	map_exit 7, 13, MAP_PSYCHIC_CLUB_ENTRANCE, 5, 1, SOUTH
	db $ff

PsychicClub_NPCs:
	npc NPC_MURRAY, 6, 3, SOUTH, NULL
	npc NPC_ROBERT, 3, 10, WEST, NULL
	npc NPC_DANIEL, 4, 5, NORTH, NULL
	npc NPC_STEPHANIE, 11, 6, EAST, NULL
	npc NPC_GR_4, 7, 3, SOUTH, $3c, $52
	db $ff

PsychicClub_NPCInteractions:
	npc_script NPC_MURRAY, $0b, $88, $4e
	npc_script NPC_ROBERT, $0b, $cc, $4f
	npc_script NPC_DANIEL, $0b, $46, $50
	npc_script NPC_STEPHANIE, $0b, $b3, $50
	npc_script NPC_GR_4, $0b, $90, $51
	db $ff

PsychicClub_MapScripts:
	dbw $06, Func_2cd92
	dbw $08, Func_2ce11
	dbw $09, Func_2ce19
	dbw $07, Func_2cd99
	dbw $02, Func_2cda2
	dbw $01, Func_2cd82
	db $ff

Func_2cd82:
	ld a, EVENT_GOT_GR_COIN_PIECE_BOTTOM_RIGHT
	farcall GetEventValue
	jr nz, .asm_2cd8f
	ld a, MUSIC_HERECOMESGR
	ld [wNextMusic], a
.asm_2cd8f
	scf
	ccf
	ret

Func_2cd92:
	ld hl, PsychicClub_StepEvents
	call Func_324d
	ret

Func_2cd99:
	ld hl, PsychicClub_NPCs
	call Func_3205
	scf
	ccf
	ret

Func_2cda2:
	ld a, EVENT_MET_GR4_PSYCHIC_CLUB
	farcall GetEventValue
	jr z, .asm_2cdc6
	ld a, EVENT_SET_UNTIL_MAP_RELOAD_1
	farcall GetEventValue
	jr nz, .asm_2cdf6
	ld a, EVENT_GOT_GR_COIN_PIECE_BOTTOM_RIGHT
	farcall GetEventValue
	jr z, .asm_2cdf6
	ld bc, TILEMAP_013
	lb de, 5, 6
	farcall Func_12c0ce
	jr .asm_2ce0f
.asm_2cdc6
	ld a, $0a
	ld [wd582], a
	ld a, $0b
	ld [wd592], a
	ld hl, $4e39
	ld a, l
	ld [wd593], a
	ld a, h
	ld [wd593 + 1], a
	xor a
	start_script
	set_npc_position_and_direction NPC_MURRAY, 7, 6, SOUTH
	set_npc_position_and_direction NPC_ROBERT, 5, 6, SOUTH
	set_npc_position_and_direction NPC_DANIEL, 6, 6, SOUTH
	set_npc_position_and_direction NPC_STEPHANIE, 8, 10, SOUTH
	end_script
	jr .asm_2ce0f
.asm_2cdf6
	xor a
	start_script
	set_npc_position_and_direction NPC_MURRAY, 6, 3, SOUTH
	set_npc_position_and_direction NPC_ROBERT, 5, 6, SOUTH
	set_npc_position_and_direction NPC_DANIEL, 6, 10, SOUTH
	set_npc_position_and_direction NPC_STEPHANIE, 8, 10, SOUTH
	end_script
.asm_2ce0f
	scf
	ret

Func_2ce11:
	ld hl, PsychicClub_NPCInteractions
	call Func_328c
	scf
	ret

Func_2ce19:
	ld hl, PsychicClub_AfterDuelScripts
	ld a, [wScriptNPC]
	call Func_344c
	scf
	ret

PsychicClub_AfterDuelScripts:
	npc_script NPC_MURRAY, $0b, $73, $4f
	npc_script NPC_ROBERT, $0b, $2a, $50
	npc_script NPC_DANIEL, $0b, $97, $50
	npc_script NPC_STEPHANIE, $0b, $42, $51
	npc_script NPC_GR_4, $0b, $0e, $52
	db $ff
; 0x2ce39

SECTION "Bank b@523c", ROMX[$523c], BANK[$b]

Func_2d23c:
	ld a, EVENT_GOT_GR_COIN_PIECE_BOTTOM_RIGHT
	farcall GetEventValue
	jr z, .asm_2d246
	scf
	ret
.asm_2d246
	scf
	ccf
	ret
; 0x2d249

SECTION "Bank b@530a", ROMX[$530a], BANK[$b]

RockClubEntrance_MapHeader:
	db MAP_GFX_ROCK_CLUB_ENTRANCE
	dba RockClubEntrance_MapScripts
	db MUSIC_OVERWORLD

RockClubEntrance_StepEvents:
	map_exit 4, 8, OVERWORLD_MAP_TCG, 1, 4, SOUTH
	map_exit 5, 8, OVERWORLD_MAP_TCG, 1, 4, SOUTH
	map_exit 0, 3, MAP_ROCK_CLUB_LOBBY, 14, 6, WEST
	map_exit 0, 4, MAP_ROCK_CLUB_LOBBY, 14, 7, WEST
	map_exit 4, 0, MAP_ROCK_CLUB, 6, 13, NORTH
	map_exit 5, 0, MAP_ROCK_CLUB, 7, 13, NORTH
	db $ff

RockClubEntrance_MapScripts:
	dbw $06, Func_2d376
	dbw $02, Func_2d37d
	dbw $0b, Func_2d399
	dbw $01, Func_2d356
	dbw $10, Func_2d366
	db $ff

Func_2d356:
	ld a, EVENT_MET_GR1_ROCK_CLUB
	farcall GetEventValue
	jr nz, .asm_2d363
	ld a, MUSIC_HERECOMESGR
	ld [wNextMusic], a
.asm_2d363
	scf
	ccf
	ret

Func_2d366:
	call RockClubEntrance_ShouldRonaldAppear
	jr nc, .appear
	scf
	ret
.appear
	ld a, MUSIC_RONALD
	farcall PlayAfterCurrentSong
	scf
	ccf
	ret

Func_2d376:
	ld hl, RockClubEntrance_StepEvents
	call Func_324d
	ret

Func_2d37d:
	call RockClubEntrance_ShouldRonaldAppear
	jr c, .quit
; card pop
	ld a, $0a
	ld [wd582], a
	ld a, $0d
	ld [wd592], a
	ld hl, $4111
	ld a, l
	ld [wd593], a
	ld a, h
	ld [wd593 + 1], a
.quit
	scf
	ret

Func_2d399:
	ld a, EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE_DUMMY
	farcall GetEventValue
	jr z, .asm_2d3b3
	ld a, NPC_RONALD
	farcall ClearOWObject
	ld a, EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE_DUMMY
	farcall ZeroOutEventValue
	ld a, [wNextMusic]
	ld [wCurMusic], a
.asm_2d3b3
	scf
	ret

; set carry if no Ronald events
; clear carry otherwise
RockClubEntrance_ShouldRonaldAppear:
	ld a, VAR_TIMES_MET_RONALD
	farcall GetVarValue
	cp 2
	jr c, .second_meeting
	scf
	ret
.second_meeting
	scf
	ccf
	ret

RockClubLobby_MapHeader:
	db MAP_GFX_ROCK_CLUB_LOBBY
	dba RockClubLobby_MapScripts
	db MUSIC_OVERWORLD

RockClubLobby_StepEvents:
	map_exit 15, 6, MAP_ROCK_CLUB_ENTRANCE, 1, 3, EAST
	map_exit 15, 7, MAP_ROCK_CLUB_ENTRANCE, 1, 4, EAST
	db $ff

RockClubLobby_NPCs:
	npc NPC_ROCK_CLUB_LASS, 5, 6, EAST, NULL
	npc NPC_ROCK_CLUB_WOMAN, 12, 10, NORTH, NULL
	npc NPC_IMAKUNI_BLACK, 1, 10, WEST, $7c, $55
	npc NPC_ROCK_CLUB_CHAP, 8, 9, WEST, NULL
	npc NPC_ROCK_CLUB_CAPPED_LAD, 10, 3, SOUTH, NULL
	npc NPC_CLERK_BATTLE_CENTER, 2, 2, SOUTH, NULL
	npc NPC_CLERK_GIFT_CENTER, 4, 2, SOUTH, NULL
	db $ff

RockClubLobby_NPCInteractions:
	npc_script NPC_ROCK_CLUB_LASS, $0b, $e0, $54
	npc_script NPC_ROCK_CLUB_WOMAN, $0b, $46, $55
	npc_script NPC_IMAKUNI_BLACK, $0f, $0c, $43
	npc_script NPC_ROCK_CLUB_CHAP, $0b, $8b, $55
	npc_script NPC_ROCK_CLUB_CAPPED_LAD, $0b, $c7, $55
	db $ff

RockClubLobby_OWInteractions:
	ow_script 8, 2, PCMenu
	ow_script 9, 2, PCMenu
	ow_script 2, 4, $0f, $b9, $41
	ow_script 4, 4, $0f, $d9, $42
	ow_script 12, 2, $10, $08, $41
	ow_script 13, 2, $10, $1e, $41
	ow_script 14, 2, $10, $34, $41
	db $ff

RockClubLobby_MapScripts:
	dbw $06, Func_2d49e
	dbw $08, Func_2d4ae
	dbw $07, Func_2d4a5
	dbw $09, Func_2d4be
	dbw $0b, Func_2d4c4
	dbw $01, Func_2d472
	dbw $10, Func_2d489
	db $ff

Func_2d472:
	ld a, EVENT_MET_GR1_ROCK_CLUB
	farcall GetEventValue
	jr nz, .asm_2d486
	ld a, MUSIC_HERECOMESGR
	ld [wNextMusic], a
	jr .asm_2d486
	ld a, MUSIC_IMAKUNI
	ld [wNextMusic], a
.asm_2d486
	scf
	ccf
	ret

Func_2d489:
	ld a, VAR_25
	farcall GetVarValue
	cp 4
	jr z, .asm_2d495
	scf
	ret
.asm_2d495
	ld a, MUSIC_IMAKUNI
	farcall PlayAfterCurrentSong
	scf
	ccf
	ret

Func_2d49e:
	ld hl, RockClubLobby_StepEvents
	call Func_324d
	ret

Func_2d4a5:
	ld hl, RockClubLobby_NPCs
	call Func_3205
	scf
	ccf
	ret

Func_2d4ae:
	ld hl, RockClubLobby_NPCInteractions
	call Func_328c
	jr nc, .asm_2d4bc
	ld hl, RockClubLobby_OWInteractions
	call Func_32bf
.asm_2d4bc
	scf
	ret

Func_2d4be:
	farcall Script_FinishedImakuniBlackDuel
	scf
	ret

Func_2d4c4:
	ld a, EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE_DUMMY
	farcall GetEventValue
	jr z, .asm_2d4de
	ld a, NPC_IMAKUNI_BLACK
	farcall ClearOWObject
	ld a, EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE_DUMMY
	farcall ZeroOutEventValue
	ld a, [wNextMusic]
	ld [wCurMusic], a
.asm_2d4de
	scf
	ret
; 0x2d4e0

SECTION "Bank b@55f8", ROMX[$55f8], BANK[$b]

RockClub_MapHeader:
	db MAP_GFX_ROCK_CLUB
	dba RockClub_MapScripts
	db MUSIC_CLUB_2

RockClub_StepEvents:
	map_exit 6, 14, MAP_ROCK_CLUB_ENTRANCE, 4, 1, SOUTH
	map_exit 7, 14, MAP_ROCK_CLUB_ENTRANCE, 5, 1, SOUTH
	db $ff

RockClub_NPCs:
	npc NPC_GENE, 7, 2, SOUTH, NULL
	npc NPC_MATTHEW, 2, 3, SOUTH, NULL
	npc NPC_RYAN, 9, 7, EAST, NULL
	npc NPC_ANDREW, 3, 8, EAST, NULL
	npc NPC_GR_1, 7, 3, NORTH, $f3, $58
	db $ff

RockClub_NPCInteractions:
	npc_script NPC_GENE, $0b, $54, $57
	npc_script NPC_MATTHEW, $0b, $ea, $57
	npc_script NPC_RYAN, $0b, $41, $58
	npc_script NPC_ANDREW, $0b, $9c, $58
	db $ff

RockClub_MapScripts:
	dbw $06, Func_2d663
	dbw $08, Func_2d6a6
	dbw $07, Func_2d66a
	dbw $02, Func_2d673
	dbw $09, Func_2d6ae
	dbw $01, Func_2d653
	db $ff

Func_2d653:
	ld a, EVENT_MET_GR1_ROCK_CLUB
	farcall GetEventValue
	jr nz, .asm_2d660
	ld a, MUSIC_HERECOMESGR
	ld [wNextMusic], a
.asm_2d660
	scf
	ccf
	ret

Func_2d663:
	ld hl, RockClub_StepEvents
	call Func_324d
	ret

Func_2d66a:
	ld hl, RockClub_NPCs
	call Func_3205
	scf
	ccf
	ret

Func_2d673:
	ld a, EVENT_MET_GR1_ROCK_CLUB
	farcall GetEventValue
	jr nz, .asm_2d6a4
	ld a, $0a
	ld [wd582], a
	ld a, $0b
	ld [wd592], a
	ld hl, $56ca
	ld a, l
	ld [wd593], a
	ld a, h
	ld [wd593 + 1], a
	xor a
	start_script
	set_npc_position_and_direction NPC_MATTHEW, 5, 1, SOUTH
	set_npc_position_and_direction NPC_RYAN, 8, 1, SOUTH
	set_npc_position_and_direction NPC_ANDREW, 6, 1, SOUTH
	end_script
.asm_2d6a4
	scf
	ret

Func_2d6a6:
	ld hl, RockClub_NPCInteractions
	call Func_328c
	scf
	ret

Func_2d6ae:
	ld hl, RockClub_AfterDuelScripts
	ld a, [wScriptNPC]
	call Func_344c
	scf
	ret

RockClub_AfterDuelScripts:
	npc_script NPC_GENE, $0b, $c3, $57
	npc_script NPC_MATTHEW, $0b, $25, $58
	npc_script NPC_RYAN, $0b, $7e, $58
	npc_script NPC_ANDREW, $0b, $d7, $58
	db $ff
; 0x2d6ca

SECTION "Bank b@5930", ROMX[$5930], BANK[$b]

FightingClubEntrance_MapHeader:
	db MAP_GFX_FIGHTING_CLUB_ENTRANCE
	dba FightingClubEntrance_MapScripts
	db MUSIC_OVERWORLD

FightingClubEntrance_StepEvents:
	map_exit 4, 8, OVERWORLD_MAP_TCG, 3, 7, SOUTH
	map_exit 5, 8, OVERWORLD_MAP_TCG, 3, 7, SOUTH
	map_exit 0, 3, MAP_FIGHTING_CLUB_LOBBY, 14, 6, WEST
	map_exit 0, 4, MAP_FIGHTING_CLUB_LOBBY, 14, 7, WEST
	map_exit 4, 0, MAP_FIGHTING_CLUB, 5, 10, NORTH
	map_exit 5, 0, MAP_FIGHTING_CLUB, 6, 10, NORTH
	db $ff

FightingClubEntrance_MapScripts:
	dbw $06, Func_2d99f
	dbw $09, Func_2d9d2
	dbw $02, Func_2d9a6
	dbw $0b, Func_2d9d8
	dbw $01, Func_2d97f
	dbw $10, Func_2d98f
	db $ff

Func_2d97f:
	ld a, EVENT_GOT_GR_COIN_PIECE_TOP_LEFT
	farcall GetEventValue
	jr nz, .asm_2d98c
	ld a, MUSIC_HERECOMESGR
	ld [wNextMusic], a
.asm_2d98c
	scf
	ccf
	ret

Func_2d98f:
	call FightingClubEntrance_ShouldRonaldAppear
	jr nc, .appear
	scf
	ret
.appear
	ld a, MUSIC_RONALD
	farcall PlayAfterCurrentSong
	scf
	ccf
	ret

Func_2d99f:
	ld hl, FightingClubEntrance_StepEvents
	call Func_324d
	ret

Func_2d9a6:
	call FightingClubEntrance_ShouldRonaldAppear
	jr c, .quit
	cp RONALD_DUEL_GC_PIECES_2
	jr z, .duel
	jr nc, .gift
; card pop
	ld hl, $4037
	jr .got_event
.duel
	ld hl, $417e
	jr .got_event
.gift
	ld hl, $41f7
.got_event
	ld a, $0a
	ld [wd582], a
	ld a, $0d
	ld [wd592], a
	ld a, l
	ld [wd593], a
	ld a, h
	ld [wd593 + 1], a
.quit
	scf
	ret

Func_2d9d2:
	farcall Script_FinishedRonaldDuelGCPieces2
	scf
	ret

Func_2d9d8:
	ld a, EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE_DUMMY
	farcall GetEventValue
	jr z, .asm_2d9f2
	ld a, NPC_RONALD
	farcall ClearOWObject
	ld a, EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE_DUMMY
	farcall ZeroOutEventValue
	ld a, [wNextMusic]
	ld [wCurMusic], a
.asm_2d9f2
	scf
	ret

; set carry if no Ronald events
; clear carry and return RONALD_* event in a
FightingClubEntrance_ShouldRonaldAppear:
	ld a, VAR_TIMES_MET_RONALD
	farcall GetVarValue
	cp 2
	jr c, .second_meeting
	cp 3
	jr c, .third_meeting
	cp 4
	jr c, .fourth_meeting
.false
	scf
	ret
.second_meeting
	xor a
	scf
	ccf
	ret
.third_meeting
	farcall CountGRCoinPiecesObtained
	cp GC_PIECES_2
	jr nz, .false
	ld a, RONALD_DUEL_GC_PIECES_2
	scf
	ccf
	ret
.fourth_meeting
	farcall CountGRCoinPiecesObtained
	cp GC_PIECES_4
	jr nz, .false
	ld a, RONALD_GIFT_GC_PIECES_4
	scf
	ccf
	ret

FightingClubLobby_MapHeader:
	db MAP_GFX_FIGHTING_CLUB_LOBBY
	dba FightingClubLobby_MapScripts
	db MUSIC_OVERWORLD

FightingClubLobby_StepEvents:
	map_exit 15, 6, MAP_FIGHTING_CLUB_ENTRANCE, 1, 3, EAST
	map_exit 15, 7, MAP_FIGHTING_CLUB_ENTRANCE, 1, 4, EAST
	db $ff

FightingClubLobby_NPCs:
	npc NPC_FIGHTING_CLUB_PAPPY, 1, 5, SOUTH, NULL
	npc NPC_FIGHTING_CLUB_GLASSES_KID, 4, 9, EAST, NULL
	npc NPC_FIGHTING_CLUB_CAPPED_GUY, 7, 9, WEST, NULL
	npc NPC_FIGHTING_CLUB_CAPPED_LASS, 6, 8, SOUTH, NULL
	npc NPC_CLERK_BATTLE_CENTER, 2, 2, SOUTH, NULL
	npc NPC_CLERK_GIFT_CENTER, 4, 2, SOUTH, NULL
	npc NPC_MICHAEL, 11, 6, EAST, $97, $5b
	db $ff

FightingClubLobby_NPCInteractions:
	npc_script NPC_FIGHTING_CLUB_PAPPY, $0b, $ac, $5b
	npc_script NPC_FIGHTING_CLUB_GLASSES_KID, $0b, $17, $5c
	npc_script NPC_FIGHTING_CLUB_CAPPED_GUY, $0b, $48, $5c
	npc_script NPC_FIGHTING_CLUB_CAPPED_LASS, $0b, $79, $5c
	npc_script NPC_MICHAEL, $0b, $0e, $5b
	db $ff

FightingClubLobby_OWInteractions:
	ow_script 8, 2, PCMenu
	ow_script 9, 2, PCMenu
	ow_script 2, 4, $0F, $B9, $41
	ow_script 4, 4, $0F, $D9, $42
	ow_script 12, 2, $10, $4A, $41
	ow_script 13, 2, $10, $60, $41
	ow_script 14, 2, $10, $76, $41
	db $ff

FightingClubLobby_MapScripts:
	dbw $06, Func_2dade
	dbw $08, Func_2daee
	dbw $07, Func_2dae5
	dbw $09, Func_2dafe
	dbw $01, Func_2dace
	db $ff

Func_2dace:
	ld a, EVENT_GOT_GR_COIN_PIECE_TOP_LEFT
	farcall GetEventValue
	jr nz, .asm_2dadb
	ld a, MUSIC_HERECOMESGR
	ld [wNextMusic], a
.asm_2dadb
	scf
	ccf
	ret

Func_2dade:
	ld hl, FightingClubLobby_StepEvents
	call Func_324d
	ret

Func_2dae5:
	ld hl, FightingClubLobby_NPCs
	call Func_3205
	scf
	ccf
	ret

Func_2daee:
	ld hl, FightingClubLobby_NPCInteractions
	call Func_328c
	jr nc, .asm_2dafc
	ld hl, FightingClubLobby_OWInteractions
	call Func_32bf
.asm_2dafc
	scf
	ret

Func_2dafe:
	ld hl, FightingClubLobby_AfterDuelScripts
	ld a, [wScriptNPC]
	call Func_344c
	scf
	ret

FightingClubLobby_AfterDuelScripts:
	npc_script NPC_MICHAEL, $0B, $7B, $5B
	db $ff
; 0x2db5b

SECTION "Bank b@5c9f", ROMX[$5c9f], BANK[$b]

FightingClub_MapHeader:
	db MAP_GFX_FIGHTING_CLUB
	dba FightingClub_MapScripts
	db MUSIC_CLUB_3

FightingClub_StepEvents:
	map_exit 5, 11, MAP_FIGHTING_CLUB_ENTRANCE, 4, 1, SOUTH
	map_exit 6, 11, MAP_FIGHTING_CLUB_ENTRANCE, 5, 1, SOUTH
	db $ff

FightingClub_NPCs:
	npc NPC_MITCH, 5, 2, SOUTH, $e4, $5d
	npc NPC_MICHAEL, 7, 7, SOUTH, $9c, $5f
	npc NPC_CHRIS, 2, 5, SOUTH, $9c, $5f
	npc NPC_JESSICA, 9, 4, SOUTH, $9c, $5f
	npc NPC_GR_1, 6, 2, SOUTH, $23, $60
	db $ff

FightingClub_NPCInteractions:
	npc_script NPC_MITCH, $0b, $62, $5d
	npc_script NPC_MICHAEL, $0b, $f1, $5d
	npc_script NPC_CHRIS, $0b, $ad, $5e
	npc_script NPC_JESSICA, $0b, $3a, $5f
	npc_script NPC_GR_1, $0b, $b1, $5f
	db $ff

FightingClub_MapScripts:
	dbw $06, Func_2dd0e
	dbw $08, Func_2dd3a
	dbw $07, Func_2dd31
	dbw $09, Func_2dd42
	dbw $02, Func_2dd15
	dbw $01, Func_2dcfe
	db $ff

Func_2dcfe:
	ld a, EVENT_GOT_GR_COIN_PIECE_TOP_LEFT
	farcall GetEventValue
	jr nz, .asm_2dd0b
	ld a, MUSIC_HERECOMESGR
	ld [wNextMusic], a
.asm_2dd0b
	scf
	ccf
	ret

Func_2dd0e:
	ld hl, FightingClub_StepEvents
	call Func_324d
	ret

Func_2dd15:
	ld a, EVENT_SET_UNTIL_MAP_RELOAD_1
	farcall GetEventValue
	jr nz, .asm_2dd2f
	ld a, EVENT_GOT_GR_COIN_PIECE_TOP_LEFT
	farcall GetEventValue
	jr z, .asm_2dd2f
	ld bc, TILEMAP_01A
	lb de, 5, 0
	farcall Func_12c0ce
.asm_2dd2f
	scf
	ret

Func_2dd31:
	ld hl, FightingClub_NPCs
	call Func_3205
	scf
	ccf
	ret

Func_2dd3a:
	ld hl, FightingClub_NPCInteractions
	call Func_328c
	scf
	ret

Func_2dd42:
	ld hl, FightingClub_AfterDuelScripts
	ld a, [wScriptNPC]
	call Func_344c
	scf
	ret

FightingClub_AfterDuelScripts:
	npc_script NPC_MITCH, $0b, $c8, $5d
	npc_script NPC_MICHAEL, $0b, $75, $5e
	npc_script NPC_CHRIS, $0b, $1e, $5f
	npc_script NPC_JESSICA, $0b, $80, $5f
	npc_script NPC_GR_1, $0b, $08, $60
	db $ff
; 0x2dd62

SECTION "Bank b@606d", ROMX[$606d], BANK[$b]

GrassClubEntrance_MapHeader:
	db MAP_GFX_GRASS_CLUB_ENTRANCE
	dba GrassClubEntrance_MapScripts
	db MUSIC_OVERWORLD

GrassClubEntrance_StepEvents:
	map_exit 4, 8, OVERWORLD_MAP_TCG, 8, 4, SOUTH
	map_exit 5, 8, OVERWORLD_MAP_TCG, 8, 4, SOUTH
	map_exit 0, 3, MAP_GRASS_CLUB_LOBBY, 14, 6, WEST
	map_exit 0, 4, MAP_GRASS_CLUB_LOBBY, 14, 7, WEST
	map_exit 4, 0, MAP_GRASS_CLUB, 6, 13, NORTH
	map_exit 5, 0, MAP_GRASS_CLUB, 7, 13, NORTH
	db $ff

GrassClubEntrance_MapScripts:
	dbw $06, Func_2e0dc
	dbw $09, Func_2e10f
	dbw $02, Func_2e0e3
	dbw $0b, Func_2e115
	dbw $01, Func_2e0bc
	dbw $10, Func_2e0cc
	db $ff

Func_2e0bc:
	ld a, EVENT_GOT_GR_COIN_PIECE_TOP_RIGHT
	farcall GetEventValue
	jr nz, .asm_2e0c9
	ld a, MUSIC_HERECOMESGR
	ld [wNextMusic], a
.asm_2e0c9
	scf
	ccf
	ret

Func_2e0cc:
	call GrassClubEntrance_ShouldRonaldAppear
	jr nc, .appear
	scf
	ret
.appear
	ld a, MUSIC_RONALD
	farcall PlayAfterCurrentSong
	scf
	ccf
	ret

Func_2e0dc:
	ld hl, GrassClubEntrance_StepEvents
	call Func_324d
	ret

Func_2e0e3:
	call GrassClubEntrance_ShouldRonaldAppear
	jr c, .quit
	cp RONALD_DUEL_GC_PIECES_2
	jr z, .duel
	jr nc, .gift
; card pop
	ld hl, $4037
	jr .got_event
.duel
	ld hl, $417e
	jr .got_event
.gift
	ld hl, $41f7
.got_event
	ld a, $0a
	ld [wd582], a
	ld a, $0d
	ld [wd592], a
	ld a, l
	ld [wd593], a
	ld a, h
	ld [wd593 + 1], a
.quit
	scf
	ret

Func_2e10f:
	farcall Script_FinishedRonaldDuelGCPieces2
	scf
	ret

Func_2e115:
	ld a, EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE_DUMMY
	farcall GetEventValue
	jr z, .asm_2e12f
	ld a, NPC_RONALD
	farcall ClearOWObject
	ld a, EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE_DUMMY
	farcall ZeroOutEventValue
	ld a, [wNextMusic]
	ld [wCurMusic], a
.asm_2e12f
	scf
	ret

; set carry if no Ronald events
; clear carry and return RONALD_* event in a
GrassClubEntrance_ShouldRonaldAppear:
	ld a, VAR_TIMES_MET_RONALD
	farcall GetVarValue
	cp 2
	jr c, .second_meeting
	cp 3
	jr c, .third_meeting
	cp 4
	jr c, .fourth_meeting
.false
	scf
	ret
.second_meeting
	xor a
	scf
	ccf
	ret
.third_meeting
	farcall CountGRCoinPiecesObtained
	cp GC_PIECES_2
	jr nz, .false
	ld a, RONALD_DUEL_GC_PIECES_2
	scf
	ccf
	ret
.fourth_meeting
	farcall CountGRCoinPiecesObtained
	cp GC_PIECES_4
	jr nz, .false
	ld a, RONALD_GIFT_GC_PIECES_4
	scf
	ccf
	ret

GrassClub_MapHeader:
	db MAP_GFX_GRASS_CLUB
	dba GrassClub_MapScripts
	db MUSIC_CLUB_1

GrassClub_StepEvents:
	map_exit 6, 14, MAP_GRASS_CLUB_ENTRANCE, 4, 1, SOUTH
	map_exit 7, 14, MAP_GRASS_CLUB_ENTRANCE, 5, 1, SOUTH
	db $ff

GrassClub_NPCs:
	npc NPC_NIKKI, 6, 2, SOUTH, $f6, $63
	npc NPC_BRITTANY, 10, 4, NORTH, $f6, $63
	npc NPC_KRISTIN, 2, 7, EAST, $f6, $63
	npc NPC_HEATHER, 7, 9, SOUTH, $f6, $63
	npc NPC_GR_2, 7, 8, SOUTH, $98, $64
	db $ff

GrassClub_NPCInteractions:
	npc_script NPC_NIKKI, $0b, $26, $62
	npc_script NPC_BRITTANY, $0b, $8c, $62
	npc_script NPC_KRISTIN, $0b, $32, $63
	npc_script NPC_HEATHER, $0b, $94, $63
	npc_script NPC_GR_2, $0b, $0b, $64
	db $ff

GrassClub_MapScripts:
	dbw $06, Func_2e1d2
	dbw $08, Func_2e1fe
	dbw $09, Func_2e206
	dbw $02, Func_2e1d9
	dbw $07, Func_2e1f5
	dbw $01, Func_2e1c2
	db $ff

Func_2e1c2:
	ld a, EVENT_GOT_GR_COIN_PIECE_TOP_RIGHT
	farcall GetEventValue
	jr nz, .asm_2e1cf
	ld a, MUSIC_HERECOMESGR
	ld [wNextMusic], a
.asm_2e1cf
	scf
	ccf
	ret

Func_2e1d2:
	ld hl, GrassClub_StepEvents
	call Func_324d
	ret

Func_2e1d9:
	ld a, EVENT_SET_UNTIL_MAP_RELOAD_1
	farcall GetEventValue
	jr nz, .asm_2e1f3
	ld a, EVENT_GOT_GR_COIN_PIECE_TOP_RIGHT
	farcall GetEventValue
	jr z, .asm_2e1f3
	ld bc, TILEMAP_01E
	lb de, 5, 11
	farcall Func_12c0ce
.asm_2e1f3
	scf
	ret

Func_2e1f5:
	ld hl, GrassClub_NPCs
	call Func_3205
	scf
	ccf
	ret

Func_2e1fe:
	ld hl, GrassClub_NPCInteractions
	call Func_328c
	scf
	ret

Func_2e206:
	ld hl, GrassClub_AfterDuelScripts
	ld a, [wScriptNPC]
	call Func_344c
	scf
	ret

GrassClub_AfterDuelScripts:
	npc_script NPC_NIKKI, $0b, $6e, $62
	npc_script NPC_BRITTANY, $0b, $f6, $62
	npc_script NPC_KRISTIN, $0b, $78, $63
	npc_script NPC_HEATHER, $0b, $da, $63
	npc_script NPC_GR_2, $0b, $49, $64
	db $ff
; 0x2e226

SECTION "Bank b@64b7", ROMX[$64b7], BANK[$b]

ScienceClubEntrance_MapHeader:
	db MAP_GFX_SCIENCE_CLUB_ENTRANCE
	dba ScienceClubEntrance_MapScripts
	db MUSIC_OVERWORLD

ScienceClubEntrance_StepEvents:
	map_exit 4, 8, OVERWORLD_MAP_TCG, 8, 2, SOUTH
	map_exit 5, 8, OVERWORLD_MAP_TCG, 8, 2, SOUTH
	map_exit 0, 3, MAP_SCIENCE_CLUB_LOBBY, 14, 6, WEST
	map_exit 0, 4, MAP_SCIENCE_CLUB_LOBBY, 14, 7, WEST
	map_exit 4, 0, MAP_SCIENCE_CLUB, 6, 14, NORTH
	map_exit 5, 0, MAP_SCIENCE_CLUB, 7, 14, NORTH
	db $ff

ScienceClubEntrance_NPCs:
	npc NPC_JOSEPH, 6, 1, SOUTH, $2a, $66
	db $ff

ScienceClubEntrance_NPCInteractions:
	npc_script NPC_JOSEPH, $0b, $d0, $65
	db $ff

ScienceClubEntrance_MapScripts:
	dbw $06, Func_2e538
	dbw $08, Func_2e574
	dbw $09, Func_2e57c
	dbw $07, Func_2e53f
	dbw $02, Func_2e548
	dbw $0b, Func_2e582
	dbw $01, Func_2e518
	dbw $10, Func_2e528
	db $ff

Func_2e518:
	ld a, EVENT_GOT_GR_COIN_PIECE_TOP_RIGHT
	farcall GetEventValue
	jr nz, .asm_2e525
	ld a, MUSIC_HERECOMESGR
	ld [wNextMusic], a
.asm_2e525
	scf
	ccf
	ret

Func_2e528:
	call ScienceClubEntrance_ShouldRonaldAppear
	jr nc, .appear
	scf
	ret
.appear
	ld a, MUSIC_RONALD
	farcall PlayAfterCurrentSong
	scf
	ccf
	ret

Func_2e538:
	ld hl, ScienceClubEntrance_StepEvents
	call Func_324d
	ret

Func_2e53f:
	ld hl, ScienceClubEntrance_NPCs
	call Func_3205
	scf
	ccf
	ret

Func_2e548:
	call ScienceClubEntrance_ShouldRonaldAppear
	jr c, .quit
	cp RONALD_DUEL_GC_PIECES_2
	jr z, .duel
	jr nc, .gift
; card pop
	ld hl, $4037
	jr .got_event
.duel
	ld hl, $417e
	jr .got_event
.gift
	ld hl, $41f7
.got_event
	ld a, $0a
	ld [wd582], a
	ld a, $0d
	ld [wd592], a
	ld a, l
	ld [wd593], a
	ld a, h
	ld [wd593 + 1], a
.quit
	scf
	ret

Func_2e574:
	ld hl, ScienceClubEntrance_NPCInteractions
	call Func_328c
	scf
	ret

Func_2e57c:
	farcall Script_FinishedRonaldDuelGCPieces2
	scf
	ret

Func_2e582:
	ld a, EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE_DUMMY
	farcall GetEventValue
	jr z, .asm_2e59c
	ld a, NPC_RONALD
	farcall ClearOWObject
	ld a, EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE_DUMMY
	farcall ZeroOutEventValue
	ld a, [wNextMusic]
	ld [wCurMusic], a
.asm_2e59c
	scf
	ret

; set carry if no Ronald events
; clear carry and return RONALD_* event in a
ScienceClubEntrance_ShouldRonaldAppear:
	ld a, VAR_TIMES_MET_RONALD
	farcall GetVarValue
	cp 2
	jr c, .second_meeting
	cp 3
	jr c, .third_meeting
	cp 4
	jr c, .fourth_meeting
.false
	scf
	ret
.second_meeting
	xor a
	scf
	ccf
	ret
.third_meeting
	farcall CountGRCoinPiecesObtained
	cp GC_PIECES_2
	jr nz, .false
	ld a, RONALD_DUEL_GC_PIECES_2
	scf
	ccf
	ret
.fourth_meeting
	farcall CountGRCoinPiecesObtained
	cp GC_PIECES_4
	jr nz, .false
	ld a, RONALD_GIFT_GC_PIECES_4
	scf
	ccf
	ret
; 0x2e5d0

SECTION "Bank b@662a", ROMX[$662a], BANK[$b]

Func_2e62a:
	ld a, EVENT_GOT_GR_COIN_PIECE_TOP_RIGHT
	farcall GetEventValue
	jr z, .asm_2e63c
	ld a, EVENT_SET_UNTIL_MAP_RELOAD_1
	farcall GetEventValue
	jr nz, .asm_2e63c
	scf
	ret
.asm_2e63c
	scf
	ccf
	ret

ScienceClubLobby_MapHeader:
	db MAP_GFX_SCIENCE_CLUB_LOBBY
	dba ScienceClubLobby_MapScripts
	db MUSIC_OVERWORLD

ScienceClubLobby_StepEvents:
	map_exit 15, 6, MAP_SCIENCE_CLUB_ENTRANCE, 1, 3, EAST
	map_exit 15, 7, MAP_SCIENCE_CLUB_ENTRANCE, 1, 4, EAST
	db $ff

ScienceClubLobby_NPCs:
	npc NPC_DAVID, 9, 6, EAST, $0d, $68
	npc NPC_ERIK, 4, 9, EAST, $0d, $68
	npc NPC_IMAKUNI_BLACK, 1, 10, WEST, $22, $68
	npc NPC_SCIENCE_CLUB_MAN, 3, 9, WEST, $d1, $68
	npc NPC_SCIENCE_CLUB_GLASSES_KID, 13, 4, SOUTH, $d1, $68
	npc NPC_SCIENCE_CLUB_TECH, 7, 9, WEST, $d1, $68
	npc NPC_CLERK_BATTLE_CENTER, 2, 2, SOUTH, NULL
	npc NPC_CLERK_GIFT_CENTER, 4, 2, SOUTH, NULL
	db $ff

ScienceClubLobby_NPCInteractions:
	npc_script NPC_DAVID, $0b, $6e, $67
	npc_script NPC_ERIK, $0b, $e3, $67
	npc_script NPC_IMAKUNI_BLACK, $0f, $0c, $43
	npc_script NPC_SCIENCE_CLUB_MAN, $0b, $31, $68
	npc_script NPC_SCIENCE_CLUB_GLASSES_KID, $0b, $62, $68
	npc_script NPC_SCIENCE_CLUB_TECH, $0b, $a0, $68
	db $ff

ScienceClubLobby_OWInteractions:
	ow_script 8, 2, PCMenu
	ow_script 9, 2, PCMenu
	ow_script 2, 4, $0f, $b9, $41
	ow_script 4, 4, $0f, $d9, $42
	ow_script 12, 2, $10, $ce, $41
	ow_script 13, 2, $10, $e4, $41
	ow_script 14, 2, $10, $fa, $41
	db $ff

ScienceClubLobby_MapScripts:
	dbw $06, Func_2e71e
	dbw $08, Func_2e72e
	dbw $09, Func_2e73e
	dbw $07, Func_2e725
	dbw $0b, Func_2e752
	dbw $01, Func_2e6f7
	dbw $10, Func_2e709
	db $ff

Func_2e6f7:
	ld a, EVENT_GOT_GR_COIN_PIECE_TOP_RIGHT
	farcall GetEventValue
	jr nz, .asm_2e706
	ld a, MUSIC_HERECOMESGR
	ld [wNextMusic], a
	jr .asm_2e706
.asm_2e706
	scf
	ccf
	ret

Func_2e709:
	ld a, VAR_25
	farcall GetVarValue
	cp 7
	jr z, .asm_2e715
	scf
	ret
.asm_2e715
	ld a, MUSIC_IMAKUNI
	farcall PlayAfterCurrentSong
	scf
	ccf
	ret

Func_2e71e:
	ld hl, ScienceClubLobby_StepEvents
	call Func_324d
	ret

Func_2e725:
	ld hl, ScienceClubLobby_NPCs
	call Func_3205
	scf
	ccf
	ret

Func_2e72e:
	ld hl, ScienceClubLobby_NPCInteractions
	call Func_328c
	jr nc, .asm_2e73c
	ld hl, ScienceClubLobby_OWInteractions
	call Func_32bf
.asm_2e73c
	scf
	ret

Func_2e73e:
	ld hl, ScienceClubLobby_AfterDuelScripts
	ld a, [wScriptNPC]
	call Func_344c
	scf
	ret

ScienceClubLobby_AfterDuelScripts:
	npc_script NPC_DAVID, $0b, $c7, $67
	npc_script NPC_IMAKUNI_BLACK, $0f, $ca, $43
	db $ff

Func_2e752:
	ld a, EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE_DUMMY
	farcall GetEventValue
	jr z, .asm_2e76c
	ld a, NPC_IMAKUNI_BLACK
	farcall ClearOWObject
	ld a, EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE_DUMMY
	farcall ZeroOutEventValue
	ld a, [wNextMusic]
	ld [wCurMusic], a
.asm_2e76c
	scf
	ret
; 0x2e76e

SECTION "Bank b@68e6", ROMX[$68e6], BANK[$b]

ScienceClub_MapHeader:
	db MAP_GFX_SCIENCE_CLUB
	dba ScienceClub_MapScripts
	db MUSIC_CLUB_3

ScienceClub_StepEvents:
	map_exit 6, 15, MAP_SCIENCE_CLUB_ENTRANCE, 4, 1, SOUTH
	map_exit 7, 15, MAP_SCIENCE_CLUB_ENTRANCE, 5, 1, SOUTH
	db $ff

ScienceClub_NPCs:
	npc NPC_RICK, 2, 2, NORTH, $87, $6a
	npc NPC_DAVID, 10, 2, NORTH, $07, $6c
	npc NPC_JOSEPH, 6, 5, WEST, $07, $6c
	npc NPC_ERIK, 3, 8, EAST, $07, $6c
	npc NPC_GR_2, 6, 8, SOUTH, $a9, $6c
	db $ff

ScienceClub_NPCInteractions:
	npc_script NPC_RICK, $0b, $c7, $69
	npc_script NPC_DAVID, $0b, $94, $6a
	npc_script NPC_JOSEPH, $0b, $ef, $6a
	npc_script NPC_ERIK, $0b, $a5, $6b
	npc_script NPC_GR_2, $0b, $1c, $6c
	db $ff

ScienceClub_MapScripts:
	dbw $06, Func_2e955
	dbw $08, Func_2e99f
	dbw $09, Func_2e9a7
	dbw $02, Func_2e95c
	dbw $07, Func_2e996
	dbw $01, Func_2e945
	db $ff

Func_2e945:
	ld a, EVENT_GOT_GR_COIN_PIECE_TOP_RIGHT
	farcall GetEventValue
	jr nz, .asm_2e952
	ld a, MUSIC_HERECOMESGR
	ld [wNextMusic], a
.asm_2e952
	scf
	ccf
	ret

Func_2e955:
	ld hl, ScienceClub_StepEvents
	call Func_324d
	ret

Func_2e95c:
	ld a, EVENT_SET_UNTIL_MAP_RELOAD_1
	farcall GetEventValue
	jr nz, .asm_2e994
	ld a, EVENT_GOT_GR_COIN_PIECE_TOP_RIGHT
	farcall GetEventValue
	jr z, .asm_2e994
	ld bc, TILEMAP_022
	lb de, 4, 1
	farcall Func_12c0ce
	ld bc, TILEMAP_023
	lb de, 9, 1
	farcall Func_12c0ce
	ld bc, TILEMAP_024
	lb de, 4, 6
	farcall Func_12c0ce
	ld bc, TILEMAP_025
	lb de, 5, 12
	farcall Func_12c0ce
.asm_2e994
	scf
	ret

Func_2e996:
	ld hl, ScienceClub_NPCs
	call Func_3205
	scf
	ccf
	ret

Func_2e99f:
	ld hl, ScienceClub_NPCInteractions
	call Func_328c
	scf
	ret

Func_2e9a7:
	ld hl, ScienceClub_AfterDuelScripts
	ld a, [wScriptNPC]
	call Func_344c
	scf
	ret

ScienceClub_AfterDuelScripts:
	npc_script NPC_RICK, $0b, $4b, $6a
	npc_script NPC_DAVID, $0b, $d1, $6a
	npc_script NPC_JOSEPH, $0b, $6d, $6b
	npc_script NPC_ERIK, $0b, $eb, $6b
	npc_script NPC_GR_2, $0b, $5a, $6c
	db $ff
; 0x2e9c7

SECTION "Bank b@6cc8", ROMX[$6cc8], BANK[$b]

WaterClubEntrance_MapHeader:
	db MAP_GFX_WATER_CLUB_ENTRANCE
	dba WaterClubEntrance_MapScripts
	db MUSIC_OVERWORLD

WaterClubEntrance_StepEvents:
	map_exit 4, 8, OVERWORLD_MAP_TCG, 7, 6, SOUTH
	map_exit 5, 8, OVERWORLD_MAP_TCG, 7, 6, SOUTH
	map_exit 0, 3, MAP_WATER_CLUB_LOBBY, 14, 6, WEST
	map_exit 0, 4, MAP_WATER_CLUB_LOBBY, 14, 7, WEST
	map_exit 4, 0, MAP_WATER_CLUB, 6, 14, NORTH
	map_exit 5, 0, MAP_WATER_CLUB, 7, 14, NORTH
	db $ff

WaterClubEntrance_MapScripts:
	dbw $06, Func_2ed37
	dbw $02, Func_2ed3e
	dbw $04, Func_2ed75
	dbw $0b, Func_2ed8c
	dbw $01, Func_2ed17
	dbw $10, Func_2ed27
	db $ff

Func_2ed17:
	ld a, EVENT_GOT_STARMIE_COIN
	farcall GetEventValue
	jr nz, .asm_2ed24
	ld a, MUSIC_HERECOMESGR
	ld [wNextMusic], a
.asm_2ed24
	scf
	ccf
	ret

Func_2ed27:
	call WaterClubEntrance_ShouldRonaldAppear
	jr nc, .appear
	scf
	ret
.appear
	ld a, MUSIC_RONALD
	farcall PlayAfterCurrentSong
	scf
	ccf
	ret

Func_2ed37:
	ld hl, WaterClubEntrance_StepEvents
	call Func_324d
	ret

Func_2ed3e:
	xor a
	start_script
	script_command_64 $12
	end_script
	call WaterClubEntrance_ShouldRonaldAppear
	jr c, .quit
	or a
	jr nz, .gift
	ldtx hl, DialogGR3Text
	call LoadTxRam2
	ld hl, $40a4
	jr .got_event
.gift
	ld a, EVENT_EE
	farcall ZeroOutEventValue
	ld hl, $451d
.got_event
	ld a, $0a
	ld [wd582], a
	ld a, $0d
	ld [wd592], a
	ld a, l
	ld [wd593], a
	ld a, h
	ld [wd593 + 1], a
.quit
	scf
	ret

Func_2ed75:
	ld a, EVENT_SET_UNTIL_MAP_RELOAD_1
	farcall GetEventValue
	jr z, .asm_2ed8a
	ld a, [wd585]
	cp 0
	jr nz, .asm_2ed8a
	ld a, EVENT_TALKED_TO_SARA
	farcall ZeroOutEventValue
.asm_2ed8a
	scf
	ret

Func_2ed8c:
	ld a, EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE_DUMMY
	farcall GetEventValue
	jr z, .asm_2eda6
	ld a, NPC_RONALD
	farcall ClearOWObject
	ld a, EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE_DUMMY
	farcall ZeroOutEventValue
	ld a, [wNextMusic]
	ld [wCurMusic], a
.asm_2eda6
	scf
	ret

; set carry if no Ronald events
; clear carry and return RONALD_* event in a
WaterClubEntrance_ShouldRonaldAppear:
	ld a, VAR_TIMES_MET_RONALD
	farcall GetVarValue
	cp 2
	jr c, .second_meeting
	ld a, EVENT_EE
	farcall GetEventValue
	jr nz, .won_gr3
	scf
	ret
.second_meeting
	xor a
	scf
	ccf
	ret
.won_gr3
	ld a, RONALD_GIFT_WON_GR3_ONCE
	scf
	ccf
	ret

WaterClubLobby_MapHeader:
	db MAP_GFX_WATER_CLUB_LOBBY
	dba WaterClubLobby_MapScripts
	db MUSIC_OVERWORLD

WaterClubLobby_StepEvents:
	map_exit 15, 6, MAP_WATER_CLUB_ENTRANCE, 1, 3, EAST
	map_exit 15, 7, MAP_WATER_CLUB_ENTRANCE, 1, 4, EAST
	db $ff

WaterClubLobby_NPCs:
	npc NPC_JOSHUA, 8, 6, WEST, $5f, $6f
	npc NPC_WATER_CLUB_LASS, 11, 1, WEST, NULL
	npc NPC_IMAKUNI_BLACK, 1, 10, WEST, $9f, $6f
	npc NPC_WATER_CLUB_PAPPY, 12, 11, EAST, NULL
	npc NPC_WATER_CLUB_LONGHAIRED_LASS, 4, 9, SOUTH, NULL
	npc NPC_CLERK_BATTLE_CENTER, 2, 2, SOUTH, NULL
	npc NPC_CLERK_GIFT_CENTER, 4, 2, SOUTH, NULL
	db $ff

WaterClubLobby_NPCInteractions:
	npc_script NPC_JOSHUA, $0b, $ea, $6e
	npc_script NPC_WATER_CLUB_LASS, $0b, $74, $6f
	npc_script NPC_IMAKUNI_BLACK, $0f, $0c, $43
	npc_script NPC_WATER_CLUB_PAPPY, $0b, $ae, $6f
	npc_script NPC_WATER_CLUB_LONGHAIRED_LASS, $0b, $e1, $6f
	db $ff

WaterClubLobby_OWInteractions:
	ow_script 8, 2, PCMenu
	ow_script 9, 2, PCMenu
	ow_script 2, 4, $0f, $b9, $41
	ow_script 4, 4, $0f, $d9, $42
	ow_script 12, 2, $10, $10, $42
	ow_script 13, 2, $10, $26, $42
	ow_script 14, 2, $10, $3c, $42
	db $ff

WaterClubLobby_MapScripts:
	dbw $06, Func_2ee9a
	dbw $08, Func_2eeaa
	dbw $09, Func_2eeba
	dbw $07, Func_2eea1
	dbw $0b, Func_2eece
	dbw $01, Func_2ee73
	dbw $10, Func_2ee85
	db $ff

Func_2ee73:
	ld a, EVENT_GOT_STARMIE_COIN
	farcall GetEventValue
	jr nz, .asm_2ee82
	ld a, MUSIC_HERECOMESGR
	ld [wNextMusic], a
	jr .asm_2ee82
.asm_2ee82
	scf
	ccf
	ret

Func_2ee85:
	ld a, VAR_25
	farcall GetVarValue
	cp 8
	jr z, .asm_2ee91
	scf
	ret
.asm_2ee91
	ld a, MUSIC_IMAKUNI
	farcall PlayAfterCurrentSong
	scf
	ccf
	ret

Func_2ee9a:
	ld hl, WaterClubLobby_StepEvents
	call Func_324d
	ret

Func_2eea1:
	ld hl, WaterClubLobby_NPCs
	call Func_3205
	scf
	ccf
	ret

Func_2eeaa:
	ld hl, WaterClubLobby_NPCInteractions
	call Func_328c
	jr nc, .asm_2eeb8
	ld hl, WaterClubLobby_OWInteractions
	call Func_32bf
.asm_2eeb8
	scf
	ret

Func_2eeba:
	ld hl, WaterClubLobby_AfterDuelScripts
	ld a, [wScriptNPC]
	call Func_344c
	scf
	ret

WaterClubLobby_AfterDuelScripts:
	npc_script NPC_JOSHUA, $0b, $43, $6f
	npc_script NPC_IMAKUNI_BLACK, $0f, $ca, $43
	db $ff

Func_2eece:
	ld a, EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE_DUMMY
	farcall GetEventValue
	jr z, .asm_2eee8
	ld a, NPC_IMAKUNI_BLACK
	farcall ClearOWObject
	ld a, EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE_DUMMY
	farcall ZeroOutEventValue
	ld a, [wNextMusic]
	ld [wCurMusic], a
.asm_2eee8
	scf
	ret
; 0x2eeea

SECTION "Bank b@7012", ROMX[$7012], BANK[$b]

WaterClub_MapHeader:
	db MAP_GFX_WATER_CLUB
	dba WaterClub_MapScripts
	db MUSIC_CLUB_1

WaterClub_StepEvents:
	map_exit 6, 15, MAP_WATER_CLUB_ENTRANCE, 4, 1, SOUTH
	map_exit 7, 15, MAP_WATER_CLUB_ENTRANCE, 5, 1, SOUTH
	db $ff

WaterClub_NPCs:
	npc NPC_AMY_LOUNGE, 11, 2, SOUTH, $6d, $73
	npc NPC_JOSHUA, 10, 4, SOUTH, $6d, $73
	npc NPC_SARA, 4, 9, EAST, $78, $74
	npc NPC_AMANDA, 11, 10, WEST, $78, $74
	npc NPC_AMY, 4, 6, SOUTH, $ed, $71
	npc NPC_GR_3, 8, 6, SOUTH, $f2, $74
	db $ff

WaterClub_NPCInteractions:
	npc_script NPC_AMY_LOUNGE, $0b, $fa, $71
	npc_script NPC_JOSHUA, $0b, $cf, $72
	npc_script NPC_SARA, $0b, $82, $73
	npc_script NPC_AMANDA, $0b, $f1, $73
	npc_script NPC_AMY, $0b, $d2, $71
	npc_script NPC_GR_3, $0b, $85, $74
	db $ff

WaterClub_OWInteractions:
	ow_script 12, 3, $0b, $fa, $71
	db $ff

WaterClub_MapScripts:
	dbw $06, Func_2f095
	dbw $08, Func_2f0f7
	dbw $02, Func_2f0a5
	dbw $09, Func_2f107
	dbw $07, Func_2f09c
	dbw $01, Func_2f085
	db $ff

Func_2f085:
	ld a, EVENT_GOT_STARMIE_COIN
	farcall GetEventValue
	jr nz, .asm_2f092
	ld a, MUSIC_HERECOMESGR
	ld [wNextMusic], a
.asm_2f092
	scf
	ccf
	ret

Func_2f095:
	ld hl, WaterClub_StepEvents
	call Func_324d
	ret

Func_2f09c:
	ld hl, WaterClub_NPCs
	call Func_3205
	scf
	ccf
	ret

Func_2f0a5:
	ld a, EVENT_GOT_STARMIE_COIN
	farcall GetEventValue
	jr nz, .asm_2f0c3
	xor a
	start_script
	load_npc NPC_CAPTURED_AMY, 4, 6, SOUTH
	load_npc NPC_CAPTURED_SARA, 3, 6, EAST
	load_npc NPC_CAPTURED_AMANDA, 5, 6, WEST
	end_script
	jr .asm_2f0f5
.asm_2f0c3
	ld bc, TILEMAP_02A
	lb de, 2, 4
	farcall Func_12c0ce
	ld a, EVENT_SET_UNTIL_MAP_RELOAD_1
	farcall GetEventValue
	jr nz, .asm_2f0e1
	ld bc, TILEMAP_029
	lb de, 5, 12
	farcall Func_12c0ce
	jr .asm_2f0f5
.asm_2f0e1
	xor a
	start_script
	set_npc_position_and_direction NPC_AMY, 9, 5, SOUTH
	set_npc_position_and_direction NPC_SARA, 8, 5, SOUTH
	set_npc_position_and_direction NPC_AMANDA, 10, 5, SOUTH
	end_script
.asm_2f0f5
	scf
	ret

Func_2f0f7:
	ld hl, WaterClub_NPCInteractions
	call Func_328c
	jr nc, .asm_2f105
	ld hl, WaterClub_OWInteractions
	call Func_32bf
.asm_2f105
	scf
	ret

Func_2f107:
	ld hl, WaterClub_AfterDuelScripts
	ld a, [wScriptNPC]
	call Func_344c
	scf
	ret

WaterClub_AfterDuelScripts:
	npc_script NPC_AMY_LOUNGE, $0b, $8a, $72
	npc_script NPC_JOSHUA, $0b, $35, $73
	npc_script NPC_SARA, $0b, $d5, $73
	npc_script NPC_AMANDA, $0b, $4f, $74
	npc_script NPC_GR_3, $0b, $d9, $74
	db $ff
; 0x2f127

SECTION "Bank b@74ff", ROMX[$74ff], BANK[$b]

FireClubEntrance_MapHeader:
	db MAP_GFX_FIRE_CLUB_ENTRANCE
	dba FireClubEntrance_MapScripts
	db MUSIC_OVERWORLD

FireClubEntrance_StepEvents:
	map_exit 4, 8, OVERWORLD_MAP_TCG, 7, 1, SOUTH
	map_exit 5, 8, OVERWORLD_MAP_TCG, 7, 1, SOUTH
	map_exit 0, 3, MAP_FIRE_CLUB_LOBBY, 14, 6, WEST
	map_exit 0, 4, MAP_FIRE_CLUB_LOBBY, 14, 7, WEST
	map_exit 4, 0, MAP_FIRE_CLUB, 6, 14, NORTH
	map_exit 5, 0, MAP_FIRE_CLUB, 7, 14, NORTH
	db $ff

FireClubEntrance_MapScripts:
	dbw $06, Func_2f56e
	dbw $09, Func_2f5a8
	dbw $02, Func_2f575
	dbw $0b, Func_2f5ae
	dbw $01, Func_2f54e
	dbw $10, Func_2f55e
	db $ff

Func_2f54e:
	ld a, EVENT_GOT_GR_COIN_PIECE_BOTTOM_LEFT
	farcall GetEventValue
	jr nz, .asm_2f55b
	ld a, MUSIC_HERECOMESGR
	ld [wNextMusic], a
.asm_2f55b
	scf
	ccf
	ret

Func_2f55e:
	call FireClubEntrance_ShouldRonaldAppear
	jr nc, .appear
	scf
	ret
.appear
	ld a, MUSIC_RONALD
	farcall PlayAfterCurrentSong
	scf
	ccf
	ret

Func_2f56e:
	ld hl, FireClubEntrance_StepEvents
	call Func_324d
	ret

Func_2f575:
	xor a
	start_script
	script_command_64 $12
	end_script
	call FireClubEntrance_ShouldRonaldAppear
	jr c, .quit
	cp RONALD_DUEL_GC_PIECES_2
	jr z, .duel
	jr nc, .gift
; card pop
	ld hl, $4037
	jr .asm_2f594
.duel
	ld hl, $417e
	jr .asm_2f594
.gift
	ld hl, $41f7
.asm_2f594
	ld a, $0a
	ld [wd582], a
	ld a, $0d
	ld [wd592], a
	ld a, l
	ld [wd593], a
	ld a, h
	ld [wd593 + 1], a
.quit
	scf
	ret

Func_2f5a8:
	farcall Script_FinishedRonaldDuelGCPieces2
	scf
	ret

Func_2f5ae:
	ld a, EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE_DUMMY
	farcall GetEventValue
	jr z, .asm_2f5c8
	ld a, NPC_RONALD
	farcall ClearOWObject
	ld a, EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE_DUMMY
	farcall ZeroOutEventValue
	ld a, [wNextMusic]
	ld [wCurMusic], a
.asm_2f5c8
	scf
	ret

; set carry if no Ronald events
; clear carry and return RONALD_* event in a
FireClubEntrance_ShouldRonaldAppear:
	ld a, VAR_TIMES_MET_RONALD
	farcall GetVarValue
	cp 2
	jr c, .second_meeting
	cp 3
	jr c, .third_meeting
	cp 4
	jr c, .fourth_meeting
.false
	scf
	ret
.second_meeting
	xor a
	scf
	ccf
	ret
.third_meeting
	farcall CountGRCoinPiecesObtained
	cp GC_PIECES_2
	jr nz, .false
	ld a, RONALD_DUEL_GC_PIECES_2
	scf
	ccf
	ret
.fourth_meeting
	farcall CountGRCoinPiecesObtained
	cp GC_PIECES_4
	jr nz, .false
	ld a, RONALD_GIFT_GC_PIECES_4
	scf
	ccf
	ret

FireClubLobby_MapHeader:
	db MAP_GFX_FIRE_CLUB_LOBBY
	dba FireClubLobby_MapScripts
	db MUSIC_OVERWORLD

FireClubLobby_StepEvents:
	map_exit 15, 6, MAP_FIRE_CLUB_ENTRANCE, 1, 3, EAST
	map_exit 15, 7, MAP_FIRE_CLUB_ENTRANCE, 1, 4, EAST
	db $ff

FireClubLobby_NPCs:
	npc NPC_FIRE_CLUB_PUNK_GUY, 8, 4, NORTH, NULL
	npc NPC_IMAKUNI_BLACK, 1, 10, WEST, $6f, $77
	npc NPC_FIRE_CLUB_MARTIAL_ARTIST, 10, 9, NORTH, NULL
	npc NPC_FIRE_CLUB_GAL, 5, 8, SOUTH, NULL
	npc NPC_CLERK_BATTLE_CENTER, 2, 2, SOUTH, NULL
	npc NPC_CLERK_GIFT_CENTER, 4, 2, SOUTH, NULL
	db $ff

FireClubLobby_NPCInteractions:
	npc_script NPC_FIRE_CLUB_PUNK_GUY, $0b, $09, $77
	npc_script NPC_IMAKUNI_BLACK, $0f, $0c, $43
	npc_script NPC_FIRE_CLUB_MARTIAL_ARTIST, $0b, $7e, $77
	npc_script NPC_FIRE_CLUB_GAL, $0b, $a4, $77
	db $ff

FireClubLobby_OWInteractions:
	ow_script 8, 2, PCMenu
	ow_script 9, 2, PCMenu
	ow_script 2, 4, $0f, $b9, $41
	ow_script 4, 4, $0f, $d9, $42
	ow_script 12, 2, $10, $52, $42
	ow_script 13, 2, $10, $68, $42
	ow_script 14, 2, $10, $7e, $42
	db $ff

FireClubLobby_MapScripts:
	dbw $06, Func_2f6c7
	dbw $08, Func_2f6d7
	dbw $07, Func_2f6ce
	dbw $09, Func_2f6e7
	dbw $0b, Func_2f6ed
	dbw $01, Func_2f6a0
	dbw $10, Func_2f6b2
	db $ff

Func_2f6a0:
	ld a, EVENT_GOT_GR_COIN_PIECE_BOTTOM_LEFT
	farcall GetEventValue
	jr nz, .asm_2f6af
	ld a, MUSIC_HERECOMESGR
	ld [wNextMusic], a
	jr .asm_2f6af
.asm_2f6af
	scf
	ccf
	ret

Func_2f6b2:
	ld a, VAR_25
	farcall GetVarValue
	cp 9
	jr z, .asm_2f6be
	scf
	ret
.asm_2f6be
	ld a, MUSIC_IMAKUNI
	farcall PlayAfterCurrentSong
	scf
	ccf
	ret

Func_2f6c7:
	ld hl, FireClubLobby_StepEvents
	call Func_324d
	ret

Func_2f6ce:
	ld hl, FireClubLobby_NPCs
	call Func_3205
	scf
	ccf
	ret

Func_2f6d7:
	ld hl, FireClubLobby_NPCInteractions
	call Func_328c
	jr nc, .asm_2f6e5
	ld hl, FireClubLobby_OWInteractions
	call Func_32bf
.asm_2f6e5
	scf
	ret

Func_2f6e7:
	farcall Script_FinishedImakuniBlackDuel
	scf
	ret

Func_2f6ed:
	ld a, EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE_DUMMY
	farcall GetEventValue
	jr z, .asm_2f707
	ld a, NPC_IMAKUNI_BLACK
	farcall ClearOWObject
	ld a, EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE_DUMMY
	farcall ZeroOutEventValue
	ld a, [wNextMusic]
	ld [wCurMusic], a
.asm_2f707
	scf
	ret
; 0x2f709

SECTION "Bank b@77ca", ROMX[$77ca], BANK[$b]

FireClub_MapHeader:
	db MAP_GFX_FIRE_CLUB
	dba FireClub_MapScripts
	db MUSIC_CLUB_3

FireClub_StepEvents:
	map_exit 6, 15, MAP_FIRE_CLUB_ENTRANCE, 4, 1, SOUTH
	map_exit 7, 15, MAP_FIRE_CLUB_ENTRANCE, 5, 1, SOUTH
	db $ff

FireClub_NPCs:
	npc NPC_KEN, 7, 2, SOUTH, NULL
	npc NPC_JOHN, 6, 9, SOUTH, NULL
	npc NPC_ADAM, 5, 7, SOUTH, NULL
	npc NPC_JONATHAN, 10, 5, SOUTH, NULL
	npc NPC_GR_3, 7, 5, SOUTH, $29, $7c
	db $ff

FireClub_NPCInteractions:
	npc_script NPC_KEN, $0b, $26, $79
	npc_script NPC_JOHN, $0b, $25, $7a
	npc_script NPC_ADAM, $0b, $a1, $7a
	npc_script NPC_JONATHAN, $0b, $4e, $7b
	npc_script NPC_GR_3, $0b, $d3, $7b
	db $ff

FireClub_OWInteractions:
	ow_script 7, 12, $0b, $ad, $7c
	ow_script 6, 12, $0b, $b7, $7c
	ow_script 5, 12, $0b, $c1, $7c
	ow_script 8, 12, $0b, $cb, $7c
	db $ff

FireClub_MapScripts:
	dbw $06, Func_2f85e
	dbw $08, Func_2f8c8
	dbw $09, Func_2f8d8
	dbw $02, Func_2f86e
	dbw $07, Func_2f865
	dbw $01, Func_2f84e
	db $ff

Func_2f84e:
	ld a, EVENT_GOT_GR_COIN_PIECE_BOTTOM_LEFT
	farcall GetEventValue
	jr nz, .asm_2f85b
	ld a, MUSIC_HERECOMESGR
	ld [wNextMusic], a
.asm_2f85b
	scf
	ccf
	ret

Func_2f85e:
	ld hl, FireClub_StepEvents
	call Func_324d
	ret

Func_2f865:
	ld hl, FireClub_NPCs
	call Func_3205
	scf
	ccf
	ret

Func_2f86e:
	ld a, EVENT_GOT_CHARMANDER_COIN
	farcall GetEventValue
	jr nz, .asm_2f891
	xor a
	start_script
	set_npc_position_and_direction NPC_KEN, 7, 10, SOUTH
	set_npc_position_and_direction NPC_JOHN, 6, 10, SOUTH
	set_npc_position_and_direction NPC_ADAM, 5, 10, SOUTH
	set_npc_position_and_direction NPC_JONATHAN, 8, 10, SOUTH
	end_script
	jr .asm_2f8c6
.asm_2f891
	ld bc, TILEMAP_02E
	lb de, 5, 11
	farcall Func_12c0ce
	ld bc, TILEMAP_02F
	lb de, 5, 7
	farcall Func_12c0ce
	ld a, EVENT_SET_UNTIL_MAP_RELOAD_1
	farcall GetEventValue
	jr z, .asm_2f8c6
	xor a
	start_script
	set_npc_position_and_direction NPC_KEN, 7, 10, SOUTH
	set_npc_position_and_direction NPC_JOHN, 6, 10, SOUTH
	set_npc_position_and_direction NPC_ADAM, 5, 10, SOUTH
	set_npc_position_and_direction NPC_JONATHAN, 8, 10, SOUTH
	end_script
.asm_2f8c6
	scf
	ret

Func_2f8c8:
	ld hl, FireClub_NPCInteractions
	call Func_328c
	jr nc, .asm_2f8d6
	ld hl, FireClub_OWInteractions
	call Func_32bf
.asm_2f8d6
	scf
	ret

Func_2f8d8:
	ld hl, FireClub_AfterDuelScripts
	ld a, [wScriptNPC]
	call Func_344c
	scf
	ret

FireClub_AfterDuelScripts:
	npc_script NPC_KEN, $0b, $ed, $79
	npc_script NPC_JOHN, $0b, $85, $7a
	npc_script NPC_ADAM, $0b, $32, $7b
	npc_script NPC_JONATHAN, $0b, $b7, $7b
	npc_script NPC_GR_3, $0b, $0e, $7c
	db $ff
; 0x2f8f8

SECTION "Bank b@7cd5", ROMX[$7cd5], BANK[$b]

PokemonDomeEntrance_MapHeader:
	db MAP_GFX_POKEMON_DOME_ENTRANCE
	dba PokemonDomeEntrance_MapScripts
	db MUSIC_OVERWORLD

PokemonDomeEntrance_StepEvents:
	map_exit 7, 8, OVERWORLD_MAP_TCG, 4, 4, SOUTH
	map_exit 8, 8, OVERWORLD_MAP_TCG, 4, 4, SOUTH
	map_exit 11, 0, MAP_POKEMON_DOME, 7, 14, NORTH
	map_exit 12, 0, MAP_POKEMON_DOME, 8, 14, NORTH
	db $ff

PokemonDomeEntrance_NPCs:
	npc NPC_POKEMON_DOME_FAT_GUY, 8, 3, NORTH, $1d, $7e
	db $ff

PokemonDomeEntrance_NPCInteractions:
	npc_script NPC_POKEMON_DOME_FAT_GUY, $0b, $a3, $7d
	db $ff

PokemonDomeEntrance_OWInteractions:
	ow_script 4, 2, PCMenu
	ow_script 5, 2, PCMenu
	ow_script 9, 1, $0b, $2a, $7e
	ow_script 10, 1, $0b, $2a, $7e
	ow_script 1, 2, $10, $5a, $43
	ow_script 2, 2, $10, $70, $43
	ow_script 3, 2, $10, $86, $43
	ow_script 1, 5, $10, $9c, $43
	ow_script 2, 5, $10, $b2, $43
	ow_script 3, 5, $10, $c8, $43
	db $ff

PokemonDomeEntrance_MapScripts:
	dbw $06, Func_2fd83
	dbw $08, Func_2fd93
	dbw $07, Func_2fd8a
	dbw $01, Func_2fd73
	db $ff

Func_2fd73:
	ld a, EVENT_GOT_GR_COIN
	farcall GetEventValue
	jr nz, .asm_2fd80
	ld a, MUSIC_HERECOMESGR
	ld [wNextMusic], a
.asm_2fd80
	scf
	ccf
	ret

Func_2fd83:
	ld hl, PokemonDomeEntrance_StepEvents
	call Func_324d
	ret

Func_2fd8a:
	ld hl, PokemonDomeEntrance_NPCs
	call Func_3205
	scf
	ccf
	ret

Func_2fd93:
	ld hl, PokemonDomeEntrance_NPCInteractions
	call Func_328c
	jr nc, .asm_2fda1
	ld hl, PokemonDomeEntrance_OWInteractions
	call Func_32bf
.asm_2fda1
	scf
	ret
; 0x2fda3

SECTION "Bank b@7e45", ROMX[$7e45], BANK[$b]

OverheadIslands_MapHeader:
	db MAP_GFX_OVERHEAD_ISLANDS
	dba OverheadIslands_MapScripts
	db MUSIC_GRBLIMP

OverheadIslands_MapScripts:
	dbw $02, Func_2fe54
	dbw $04, Func_2fe94
	dbw $0f, Func_2fe97
	db $ff

Func_2fe54:
	farcall InitOWObjects
	ld a, [wd584]
	cp 0
	jr nz, .asm_2fe6c
	ld a, NPC_GR_BLIMP
	lb de, 16, 128
	ld b, EAST
	farcall LoadOWObject
	jr .asm_2fe77
.asm_2fe6c
	ld a, NPC_GR_BLIMP
	lb de, 144, 16
	ld b, WEST
	farcall LoadOWObject
.asm_2fe77
	ld a, $0a
	ld [wd582], a
	ld a, $0b
	ld [wd592], a
	ld hl, $7e9a
	ld a, l
	ld [wd593], a
	ld a, h
	ld [wd593 + 1], a
	ld a, 0
	call Func_338f
	scf
	ccf
	ret

Func_2fe94:
	scf
	ccf
	ret

Func_2fe97:
	scf
	ccf
	ret
; 0x2fe9a
