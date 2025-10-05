SECTION "Bank f@4000", ROMX[$4000], BANK[$f]

Prologue::
	xor a ; MUSIC_STOP
	ld [wCurMusic], a
	ld a, MUSIC_OVERWORLD
	farcall PlayAfterCurrentSong

	xor a
	farcall ShowProloguePortraitAndText

	farcall Func_102ef
	xor a
	farcall InitOWObjects

	; load map and fade in
	ld a, MUSIC_HERECOMESGR
	farcall PlayAfterCurrentSong
	ld bc, OVERWORLD_MAP_GFX_TCG
	farcall LoadOWMap
	ld bc, TILEMAP_001
	lb de, 0, 0
	farcall Func_12c0ce
	ld a, $00
	call Func_338f
	call WaitPalFading
	call EnableLCD

	; do GR Ship movement
	ld a, OW_GR_BLIMP
	lb de, $a0, $30
	ld b, WEST
	farcall LoadOWObject
	lb de, $78, $30
	ld b, WEST
	call .MoveGRShip
	call .DoGRShipBeamAnimation
	lb de, $78, $10
	ld b, WEST
	call .MoveGRShip
	call .DoGRShipBeamAnimation
	lb de, $58, $18
	ld b, WEST
	call .MoveGRShip
	call .DoGRShipBeamAnimation

	ld a, $01
	farcall ShowProloguePortraitAndText_WithFade

	; load player object in map
	ld a, [wPlayerOWObject]
	lb de, $44, $44
	ld b, SOUTH
	farcall LoadOWObject
	lb de, $40, $30
	ld b, WEST
	call .MoveGRShip

	; show beam animation on player
	ld a, EVENT_PLAYER_GENDER
	farcall GetEventValue
	jr nz, .asm_3c08d
	ld bc, FRAMESET_0AE
	jr .asm_3c090
.asm_3c08d
	ld bc, FRAMESET_0B4
.asm_3c090
	ld a, [wPlayerOWObject]
	farcall _SetAndInitOWObjectFrameset
	call .DoGRShipBeamAnimation

	; more GR Ship movement
	lb de, $20, $40
	ld b, WEST
	call .MoveGRShip
	call .DoGRShipBeamAnimation
	lb de, $30, $58
	ld b, EAST
	call .MoveGRShip
	call .DoGRShipBeamAnimation
	lb de, $68, $50
	ld b, EAST
	call .MoveGRShip
	call .DoGRShipBeamAnimation
	lb de, $50, $5c
	ld b, WEST
	call .MoveGRShip
	lb de, $50, $78
	ld b, EAST
	call .MoveGRShip

	ld a, $02
	farcall ShowProloguePortraitAndText_WithFade

	ld a, EVENT_PLAYER_GENDER
	farcall GetEventValue
	jr nz, .asm_3c0de
	ld bc, FRAMESET_0AF
	jr .asm_3c0e1
.asm_3c0de
	ld bc, FRAMESET_0B5
.asm_3c0e1
	ld a, [wPlayerOWObject]
	farcall _SetAndInitOWObjectFrameset

	ld a, OW_GR_BLIMP
	farcall _ClearOWObject

	ld bc, TILEMAP_002
	lb de, 0, 0
	farcall Func_12c0ce

	lb de,  1, 1
	lb bc, 11, 1
	farcall FillBoxInBGMapWithZero

	ld a, OWMAP_POKEMON_DOME
	ld [wCurOWLocation], a
	farcall PrintTCGIslandLocationName

	ld a, [wPlayerOWObject]
	call WaitForOWObjectAnimation
	ld a, [wPlayerOWObject]
	farcall _ClearOWObject
	lb de, $44, $44
	ld b, SOUTH
	farcall LoadOWObject
	ld a, 30
	call WaitAFrames
	ld a, SFX_57
	call PlaySFX
	call .MovePlayer

	ld a, OWMAP_MASON_LABORATORY
	ld [wCurOWLocation], a
	farcall PrintTCGIslandLocationName

	ld a, 60
	call WaitAFrames
	xor a
	call PlaySFX
	ld a, $01
	call Func_33a3
	ld a, SFX_0C
	call PlaySFX
	ret

; b = direction
; de = target position
.MoveGRShip:
	push bc
	ld a, OW_GR_BLIMP
	farcall SetOWObjectTargetPosition
	pop bc
.loop
	push bc
	ld a, 3
	call WaitAFrames
	farcall MoveOWObjectToTargetPosition
	pop bc
	; override direction
	ld a, OW_GR_BLIMP
	farcall _SetOWObjectDirection
	jr c, .loop
	ret

.DoGRShipBeamAnimation:
	ld a, SFX_8B
	call PlaySFX
	ld a, OW_GR_BLIMP
	farcall GetOWObjectPosition
	ld a, e
	add $10
	ld e, a
	ld a, d
	sub $04
	ld d, a
	ld a, OW_GR_BLIMP_BEAM
	ld b, SOUTH
	farcall LoadOWObject
	call WaitForOWObjectAnimation
	ld a, OW_GR_BLIMP_BEAM
	farcall _ClearOWObject
	ret

.MovePlayer:
	ld a, [wPlayerOWObject]
	ld b, $01
	farcall _SetOWObjectAnimStruct1Flag2
	lb de, $24, $68
	farcall SetOWObjectTargetPosition
.loop_wait_1
	call DoFrame
	farcall MoveOWObjectToTargetPosition
	jr c, .loop_wait_1
	ld a, [wPlayerOWObject]
	lb de, $c, $68
	farcall SetOWObjectTargetPosition
.loop_wait_2
	call DoFrame
	farcall MoveOWObjectToTargetPosition
	jr c, .loop_wait_2
	ret
; 0x3c1b9

SECTION "Bank f@43ca", ROMX[$43ca], BANK[$f]

Func_3c3ca:
	xor a
	start_script
	script_command_01
	set_var VAR_25, $0f
	check_event EVENT_SET_UNTIL_MAP_RELOAD_2
	script_jump_if_b0nz .ows_3c41b
	inc_var VAR_22
	get_var VAR_22
	compare_loaded_var $0a
	script_jump_if_b1nz .ows_3c3e3
	set_var VAR_22, $0a
.ows_3c3e3
	compare_loaded_var $03
	script_jump_if_b1nz .ows_3c3f8
	script_jump_if_b0nz .ows_3c3ff
	compare_loaded_var $06
	script_jump_if_b0nz .ows_3c406
	compare_loaded_var $09
	script_jump_if_b0nz .ows_3c40d
	script_jump .ows_3c414

.ows_3c3f8
	script_call .ows_3c441
	script_jump .ows_3c41e

.ows_3c3ff
	script_call .ows_3c448
	script_jump .ows_3c41e

.ows_3c406
	script_call .ows_3c452
	script_jump .ows_3c41e

.ows_3c40d
	script_call .ows_3c45c
	script_jump .ows_3c41e

.ows_3c414
	script_call .ows_3c474
	script_jump .ows_3c41e

.ows_3c41b
	print_npc_text Text12cc
.ows_3c41e
	print_npc_text Text12cd
	script_command_02
	get_player_direction
	compare_loaded_var $02
	script_jump_if_b0z .ows_3c42d
	set_player_direction WEST
	animate_player_movement $81, $02
.ows_3c42d
	move_active_npc $4492
	wait_for_player_animation
	unload_npc OW_IMAKUNI_BLACK
	end_script
	ld a, $00
	ld [wd582], a
	ld a, [wNextMusic]
	farcall PlayAfterCurrentSong
	ret

.ows_3c441
	print_npc_text Text12ce
	give_booster_packs $4ddd
	script_ret

.ows_3c448
	print_npc_text Text12cf
	give_card FARFETCHD_ALT_LV20
	show_card_received_screen FARFETCHD_ALT_LV20
	script_ret

.ows_3c452
	print_npc_text Text12d0
	give_card IMAKUNI_CARD
	show_card_received_screen IMAKUNI_CARD
	script_ret

.ows_3c45c
	print_npc_text Text12d1
	get_random $02
	compare_loaded_var $00
	script_jump_if_b0z .ows_3c46d
	give_card FARFETCHD_ALT_LV20
	show_card_received_screen FARFETCHD_ALT_LV20
	script_ret

.ows_3c46d
	give_card IMAKUNI_CARD
	show_card_received_screen IMAKUNI_CARD
	script_ret

.ows_3c474
	print_npc_text Text12d2
	get_var VAR_22
	compare_loaded_var $06
	script_jump_if_b1nz .ows_3c486
	compare_loaded_var $09
	script_jump_if_b1nz .ows_3c48a
	script_jump .ows_3c48e

.ows_3c486
	give_booster_packs $4de3
	script_ret

.ows_3c48a
	give_booster_packs $4de9
	script_ret

.ows_3c48e
	give_booster_packs $4df0
	script_ret
; 0x3c492

SECTION "Bank f@4603", ROMX[$4603], BANK[$f]

MasonLaboratorySide1_MapHeader:
	db MAP_GFX_MASON_LABORATORY_SIDE_1
	dba MasonLaboratorySide1_MapScripts
	db MUSIC_OVERWORLD

MasonLaboratorySide1_StepEvents:
	map_exit 0, 5, MAP_MASON_LABORATORY_MAIN, 12, 5, WEST
	map_exit 0, 6, MAP_MASON_LABORATORY_MAIN, 12, 6, WEST
	db $ff

MasonLaboratorySide1_NPCs:
	npc OW_TECH_13, 4, 3, SOUTH, $0
	npc OW_TECH_14, 7, 3, SOUTH, $0
	npc OW_TECH_15, 3, 8, NORTH, $0
	npc OW_TECH_16, 7, 9, EAST, $0
	db $ff

MasonLaboratorySide1_NPCInteractions:
	npc_script OW_TECH_13, $0f, $4739
	npc_script OW_TECH_14, $0f, $475f
	npc_script OW_TECH_15, $0f, $477a
	npc_script OW_TECH_16, $0f, $47ab
	db $ff

MasonLaboratorySide1_OWInteractions:
	ow_script 2, 3, $0f, $46c3
	ow_script 3, 3, $0f, $46c3
	ow_script 8, 10, $0f, $46e8
	ow_script 9, 10, $0f, $46e8
	ow_script 8, 3, $0f, $4715
	ow_script 9, 3, $0f, $4715
	db $ff

MasonLaboratorySide1_MapScripts:
	dbw $06, $4689
	dbw $08, $46b3
	dbw $07, $4690
	dbw $02, $4697
	db $ff
; gap from 0x3c689 to 0x3c7dc

SECTION "Bank f@47dc", ROMX[$47dc], BANK[$f]

MasonLaboratorySide2_MapHeader:
	db MAP_GFX_MASON_LABORATORY_SIDE_2
	dba MasonLaboratorySide2_MapScripts
	db MUSIC_OVERWORLD

MasonLaboratorySide2_StepEvents:
	map_exit 13, 11, MAP_MASON_LABORATORY_MAIN, 1, 5, EAST
	map_exit 13, 12, MAP_MASON_LABORATORY_MAIN, 1, 6, EAST
	db $ff

MasonLaboratorySide2_NPCs:
	npc OW_AARON, 11, 2, NORTH, $0
	npc OW_TECH_17, 10, 11, EAST, $0
	db $ff

MasonLaboratorySide2_NPCInteractions:
	npc_script OW_AARON, $0f, $484c
	npc_script OW_TECH_17, $0f, $4a4d
	db $ff

MasonLaboratorySide2_MapScripts:
	dbw $06, $4817
	dbw $08, $4825
	dbw $09, $482d
	dbw $07, $481e
	db $ff
; gap from 0x3c817 to 0x3c83b

SECTION "Bank f@483b", ROMX[$483b], BANK[$f]

MasonLaboratorySide2_AfterDuelScripts:
	npc_script OW_MINT, $0f, $4931
	npc_script OW_DR_MASON, $0f, $497e
	npc_script OW_RONALD, $0f, $49cb
	npc_script OW_ISHIHARA, $0f, $4a28
	db $ff
; gap from 0x3c84c to 0x3cb88

SECTION "Bank f@4b88", ROMX[$4b88], BANK[$f]

LightningClubEntrance_MapHeader:
	db MAP_GFX_LIGHTNING_CLUB_ENTRANCE
	dba LightningClubEntrance_MapScripts
	db MUSIC_OVERWORLD

LightningClubEntrance_StepEvents:
	map_exit 4, 8, OVERWORLD_MAP_TCG, 2, 5, SOUTH
	map_exit 5, 8, OVERWORLD_MAP_TCG, 2, 5, SOUTH
	map_exit 0, 3, MAP_LIGHTNING_CLUB_LOBBY, 14, 6, WEST
	map_exit 0, 4, MAP_LIGHTNING_CLUB_LOBBY, 14, 7, WEST
	map_exit 4, 0, MAP_LIGHTNING_CLUB, 6, 14, NORTH
	map_exit 5, 0, MAP_LIGHTNING_CLUB, 7, 14, NORTH
	db $ff

LightningClubEntrance_MapScripts:
	dbw $06, $4bf4
	dbw $02, $4bfb
	dbw $0b, $4c37
	dbw $01, $4bd4
	dbw $10, $4be4
	db $ff
; gap from 0x3cbd4 to 0x3cc62

SECTION "Bank f@4c62", ROMX[$4c62], BANK[$f]

LightningClubLobby_MapHeader:
	db MAP_GFX_LIGHTNING_CLUB_LOBBY
	dba LightningClubLobby_MapScripts
	db MUSIC_OVERWORLD

LightningClubLobby_StepEvents:
	map_exit 15, 6, MAP_LIGHTNING_CLUB_ENTRANCE, 1, 3, EAST
	map_exit 15, 7, MAP_LIGHTNING_CLUB_ENTRANCE, 1, 4, EAST
	db $ff

LightningClubLobby_NPCs:
	npc OW_JENNIFER, 9, 8, EAST, $4db1
	npc OW_BRANDON, 9, 6, EAST, $4db1
	npc OW_LASS3_2, 11, 2, NORTH, $0
	npc OW_HOOD_4, 9, 4, SOUTH, $0
	npc OW_LASS1_3, 5, 6, EAST, $4e9b
	npc OW_GR_LASS_7, 5, 6, EAST, $4ea8
	npc OW_CHAP_2, 8, 9, WEST, $0
	npc OW_CLERK_1, 2, 2, SOUTH, $0
	npc OW_CLERK_2, 4, 2, SOUTH, $0
	db $ff

LightningClubLobby_NPCInteractions:
	npc_script OW_JENNIFER, $0f, $4d4b
	npc_script OW_BRANDON, $0f, $4d7e
	npc_script OW_LASS3_2, $0f, $4dc6
	npc_script OW_HOOD_4, $0f, $4e39
	npc_script OW_LASS1_3, $0f, $4e6a
	npc_script OW_GR_LASS_7, $0f, $4e6a
	npc_script OW_CHAP_2, $0f, $4eb5
	db $ff

LightningClubLobby_OWInteractions:
	ow_script 8, 2, $03, $5411
	ow_script 9, 2, $03, $5411
	ow_script 2, 4, $0f, $41b9
	ow_script 4, 4, $0f, $42d9
	ow_script 12, 2, $10, $4294
	ow_script 13, 2, $10, $42aa
	ow_script 14, 2, $10, $42c0
	db $ff

LightningClubLobby_MapScripts:
	dbw $06, $4d2b
	dbw $08, $4d3b
	dbw $07, $4d32
	dbw $01, $4d1b
	db $ff
; gap from 0x3cd1b to 0x3cee6

SECTION "Bank f@4ee6", ROMX[$4ee6], BANK[$f]

GrassClubLobby_MapHeader:
	db MAP_GFX_GRASS_CLUB_LOBBY
	dba GrassClubLobby_MapScripts
	db MUSIC_OVERWORLD

GrassClubLobby_StepEvents:
	map_exit 15, 6, MAP_GRASS_CLUB_ENTRANCE, 1, 3, EAST
	map_exit 15, 7, MAP_GRASS_CLUB_ENTRANCE, 1, 4, EAST
	db $ff

GrassClubLobby_NPCs:
	npc OW_BRITTANY, 7, 9, WEST, $50ec
	npc OW_KRISTIN, 6, 6, EAST, $50ec
	npc OW_HEATHER, 10, 8, EAST, $50ec
	npc OW_GRANNY, 3, 10, EAST, $5189
	npc OW_LASS2_3, 11, 4, SOUTH, $5189
	npc OW_GIRL_5, 7, 8, WEST, $5189
	npc OW_CLERK_1, 2, 2, SOUTH, $0
	npc OW_CLERK_2, 4, 2, SOUTH, $0
	db $ff

GrassClubLobby_NPCInteractions:
	npc_script OW_BRITTANY, $0f, $4fd8
	npc_script OW_KRISTIN, $0f, $5064
	npc_script OW_HEATHER, $0f, $50a8
	npc_script OW_GRANNY, $0f, $5101
	npc_script OW_LASS2_3, $0f, $5127
	npc_script OW_GIRL_5, $0f, $5158
	db $ff

GrassClubLobby_OWInteractions:
	ow_script 8, 2, $03, $5411
	ow_script 9, 2, $03, $5411
	ow_script 2, 4, $0f, $41b9
	ow_script 4, 4, $0f, $42d9
	ow_script 12, 2, $10, $418c
	ow_script 13, 2, $10, $41a2
	ow_script 14, 2, $10, $41b8
	db $ff

GrassClubLobby_MapScripts:
	dbw $06, $4fa8
	dbw $08, $4fb8
	dbw $07, $4faf
	dbw $09, $4fc8
	dbw $01, $4f98
	db $ff
; gap from 0x3cf98 to 0x3cfd3

SECTION "Bank f@4fd3", ROMX[$4fd3], BANK[$f]

GrassClubLobby_AfterDuelScripts:
	npc_script OW_BRITTANY, $0f, $502b
	db $ff
; gap from 0x3cfd8 to 0x3d19e

SECTION "Bank f@519e", ROMX[$519e], BANK[$f]

TcgChallengeHallEntrance_MapHeader:
	db MAP_GFX_TCG_CHALLENGE_HALL_ENTRANCE
	dba TcgChallengeHallEntrance_MapScripts
	db MUSIC_OVERWORLD

TcgChallengeHallEntrance_StepEvents:
	map_exit 4, 8, OVERWORLD_MAP_TCG, 4, 2, SOUTH
	map_exit 5, 8, OVERWORLD_MAP_TCG, 4, 2, SOUTH
	map_exit 0, 3, MAP_TCG_CHALLENGE_HALL_LOBBY, 14, 6, WEST
	map_exit 0, 4, MAP_TCG_CHALLENGE_HALL_LOBBY, 14, 7, WEST
	map_exit 4, 0, MAP_TCG_CHALLENGE_HALL, 7, 14, NORTH
	map_exit 5, 0, MAP_TCG_CHALLENGE_HALL, 8, 14, NORTH
	db $ff

TcgChallengeHallEntrance_NPCs:
	npc OW_CLERK_3, 3, 1, SOUTH, $0
	db $ff

TcgChallengeHallEntrance_NPCInteractions:
	npc_script OW_CLERK_3, $0f, $5271
	db $ff

TcgChallengeHallEntrance_MapScripts:
	dbw $06, $5259
	dbw $08, $5269
	dbw $07, $5260
	dbw $01, $51f6
	dbw $04, $5210
	db $ff
; gap from 0x3d1f6 to 0x3d2d7

SECTION "Bank f@52d7", ROMX[$52d7], BANK[$f]

TcgChallengeHallLobby_MapHeader:
	db MAP_GFX_TCG_CHALLENGE_HALL_LOBBY
	dba TcgChallengeHallLobby_MapScripts
	db MUSIC_OVERWORLD

TcgChallengeHallLobby_StepEvents:
	map_exit 15, 6, MAP_TCG_CHALLENGE_HALL_ENTRANCE, 1, 3, EAST
	map_exit 15, 7, MAP_TCG_CHALLENGE_HALL_ENTRANCE, 1, 4, EAST
	db $ff

TcgChallengeHallLobby_NPCs:
	npc OW_CHAP_3, 10, 4, SOUTH, $0
	npc OW_GAL_3, 7, 9, EAST, $55a3
	npc OW_HOOD_5, 5, 6, EAST, $55a3
	npc OW_PAPPY_4, 4, 9, EAST, $55ba
	npc OW_TECH_7, 9, 10, NORTH, $55ba
	npc OW_GIRL_6, 13, 9, WEST, $55ba
	npc OW_CLERK_1, 2, 2, SOUTH, $0
	npc OW_CLERK_2, 4, 2, SOUTH, $0
	db $ff

TcgChallengeHallLobby_NPCInteractions:
	npc_script OW_CHAP_3, $0f, $53c0
	npc_script OW_GAL_3, $0f, $54e9
	npc_script OW_HOOD_5, $0f, $5511
	npc_script OW_PAPPY_4, $0f, $5539
	npc_script OW_TECH_7, $0f, $556d
	npc_script OW_GIRL_6, $0f, $5588
	db $ff

TcgChallengeHallLobby_OWInteractions:
	ow_script 8, 2, $03, $5411
	ow_script 9, 2, $03, $5411
	ow_script 2, 4, $0f, $41b9
	ow_script 4, 4, $0f, $42d9
	ow_script 12, 2, $10, $4318
	ow_script 13, 2, $10, $432e
	ow_script 14, 2, $10, $4344
	db $ff

TcgChallengeHallLobby_MapScripts:
	dbw $06, $53a0
	dbw $08, $53b0
	dbw $07, $53a7
	dbw $01, $5386
	db $ff
; gap from 0x3d386 to 0x3d5d1

SECTION "Bank f@55d1", ROMX[$55d1], BANK[$f]

PokemonDome_MapHeader:
	db MAP_GFX_POKEMON_DOME
	dba PokemonDome_MapScripts
	db MUSIC_OVERWORLD

PokemonDome_StepEvents:
	map_exit 7, 15, MAP_POKEMON_DOME_ENTRANCE, 11, 1, SOUTH
	map_exit 8, 15, MAP_POKEMON_DOME_ENTRANCE, 12, 1, SOUTH
	db $ff

PokemonDome_NPCs:
	npc OW_COURTNEY, 3, 6, EAST, $57e2
	npc OW_STEVE, 9, 6, EAST, $5889
	npc OW_JACK, 12, 6, WEST, $592c
	npc OW_ROD, 6, 6, SOUTH, $59b1
	npc OW_GR_5, 7, 8, SOUTH, $59fc
	npc OW_LASS1_5, 7, 4, SOUTH, $5af0
	npc OW_LASS2_5, 8, 4, SOUTH, $5af0
	npc OW_GR_LASS_8, 4, 12, EAST, $5af0
	npc OW_YOUNGSTER_5, 9, 8, SOUTH, $5af0
	npc OW_SWIMMER, 2, 5, EAST, $5af0
	db $ff

PokemonDome_NPCInteractions:
	npc_script OW_COURTNEY, $0f, $5768
	npc_script OW_STEVE, $0f, $5805
	npc_script OW_JACK, $0f, $58ac
	npc_script OW_ROD, $0f, $594f
	npc_script OW_GR_5, $0f, $59d4
	npc_script OW_LASS1_5, $0f, $5a09
	npc_script OW_LASS2_5, $0f, $5a09
	npc_script OW_GR_LASS_8, $0f, $5a6c
	npc_script OW_YOUNGSTER_5, $0f, $5a97
	npc_script OW_SWIMMER, $0f, $5abf
	db $ff

PokemonDome_OWInteractions:
	ow_script 7, 1, $0f, $5b13
	ow_script 8, 1, $0f, $5b13
	db $ff

PokemonDome_MapScripts:
	dbw $06, $56ba
	dbw $08, $5740
	dbw $09, $5750
	dbw $07, $56c1
	dbw $02, $56ca
	dbw $04, $5719
	dbw $0f, $5734
	dbw $01, $567b
	db $ff
; gap from 0x3d67b to 0x3d75b

SECTION "Bank f@575b", ROMX[$575b], BANK[$f]

PokemonDome_AfterDuelScripts:
	npc_script OW_COURTNEY, $0f, $57c6
	npc_script OW_STEVE, $0f, $586d
	npc_script OW_JACK, $0f, $5910
	db $ff
; gap from 0x3d768 to 0x3dd58

SECTION "Bank f@5d58", ROMX[$5d58], BANK[$f]

PokemonDomeBack_MapHeader:
	db MAP_GFX_POKEMON_DOME_BACK
	dba PokemonDomeBack_MapScripts
	db MUSIC_POKEMONDOME

PokemonDomeBack_StepEvents:
	map_exit 7, 15, MAP_POKEMON_DOME, 7, 1, SOUTH
	map_exit 8, 15, MAP_POKEMON_DOME, 8, 1, SOUTH
	db $ff

PokemonDomeBack_NPCs:
	npc OW_COURTNEY, 7, 13, SOUTH, $0
	npc OW_STEVE, 8, 12, SOUTH, $0
	npc OW_JACK, 8, 13, SOUTH, $0
	npc OW_ROD, 7, 12, SOUTH, $0
	npc OW_GAL_3, 7, 2, SOUTH, $668b
	db $ff

PokemonDomeBack_MapScripts:
	dbw $06, $5da8
	dbw $09, $5e72
	dbw $07, $5daf
	dbw $02, $5db8
	dbw $04, $5e67
	dbw $0b, $5e91
	dbw $0e, $5eca
	dbw $0f, $5e6f
	db $ff
; gap from 0x3dda8 to 0x3e698

SECTION "Bank f@6698", ROMX[$6698], BANK[$f]

IshiharasVilla1_MapHeader:
	db MAP_GFX_ISHIHARAS_VILLA_1
	dba IshiharasVilla1_MapScripts
	db MUSIC_ISHIHARA

IshiharasVilla1_StepEvents:
	map_exit 4, 10, OVERWORLD_MAP_GR, 4, 4, SOUTH
	map_exit 5, 10, OVERWORLD_MAP_GR, 4, 4, SOUTH
	map_exit 4, 0, MAP_ISHIHARAS_VILLA_2, 4, 7, NORTH
	map_exit 5, 0, MAP_ISHIHARAS_VILLA_2, 5, 7, NORTH
	db $ff

IshiharasVilla1_NPCs:
	npc OW_ISHIHARA, 6, 5, WEST, $67d6
	npc OW_GR_GAL_4, 2, 2, NORTH, $68d3
	db $ff

IshiharasVilla1_NPCInteractions:
	npc_script OW_ISHIHARA, $0f, $67c0
	npc_script OW_GR_GAL_4, $0f, $68b1
	db $ff

IshiharasVilla1_OWInteractions:
	ow_script 7, 2, $03, $5411
	ow_script 8, 2, $03, $5411
	db $ff

IshiharasVilla1_MapScripts:
	dbw $06, $672a
	dbw $08, $673a
	dbw $09, $67bb
	dbw $07, $6731
	dbw $0c, $674a
	dbw $0d, $6778
	dbw $0b, $6787
	dbw $01, $6704
	db $ff
; gap from 0x3e704 to 0x3e8e0

SECTION "Bank f@68e0", ROMX[$68e0], BANK[$f]

IshiharasVilla2_MapHeader:
	db MAP_GFX_ISHIHARAS_VILLA_2
	dba IshiharasVilla2_MapScripts
	db MUSIC_ISHIHARA

IshiharasVilla2_StepEvents:
	map_exit 4, 8, MAP_ISHIHARAS_VILLA_1, 4, 1, SOUTH
	map_exit 5, 8, MAP_ISHIHARAS_VILLA_1, 5, 1, SOUTH
	db $ff

IshiharasVilla2_NPCs:
	npc OW_ISHIHARA, 5, 4, SOUTH, $6a55
	npc OW_GR_GAL_4, 4, 2, NORTH, $6cd5
	db $ff

IshiharasVilla2_NPCInteractions:
	npc_script OW_ISHIHARA, $0f, $6a12
	npc_script OW_GR_GAL_4, $0f, $6c75
	db $ff

IshiharasVilla2_OWInteractions:
	ow_script 1, 2, $10, $43de
	ow_script 2, 2, $10, $43f4
	ow_script 3, 2, $10, $440a
	ow_script 6, 2, $10, $4420
	ow_script 7, 2, $10, $4436
	ow_script 8, 2, $10, $444c
	db $ff

IshiharasVilla2_MapScripts:
	dbw $06, $6981
	dbw $08, $6991
	dbw $07, $6988
	dbw $0c, $69a1
	dbw $0d, $69cf
	dbw $0b, $69de
	dbw $01, $695b
	db $ff
; gap from 0x3e95b to 0x3ecea

SECTION "Bank f@6cea", ROMX[$6cea], BANK[$f]

GameCenterEntrance_MapHeader:
	db MAP_GFX_GAME_CENTER_ENTRANCE
	dba GameCenterEntrance_MapScripts
	db MUSIC_GAMECORNER

GameCenterEntrance_StepEvents:
	map_exit 5, 15, OVERWORLD_MAP_GR, 4, 4, SOUTH
	map_exit 6, 15, OVERWORLD_MAP_GR, 4, 4, SOUTH
	map_exit 0, 6, MAP_GAME_CENTER_LOBBY, 12, 6, WEST
	map_exit 0, 7, MAP_GAME_CENTER_LOBBY, 12, 7, WEST
	map_exit 5, 0, MAP_GAME_CENTER_1, 5, 13, NORTH
	map_exit 6, 0, MAP_GAME_CENTER_1, 6, 13, NORTH
	ow_script 5, 9, $0d, $426f
	ow_script 6, 9, $0d, $426f
	ow_script 6, 2, $0f, $6e9e
	ow_script 5, 10, $0f, $6ec7
	ow_script 6, 10, $0f, $6ec7
	db $ff

GameCenterEntrance_NPCs:
	npc OW_GR_CLERK_16, 9, 2, SOUTH, $0
	npc OW_GR_CLERK_17, 2, 2, SOUTH, $0
	npc OW_CHIP_GIRL_1, 5, 2, SOUTH, $0
	npc OW_MONOCLE_1, 4, 9, EAST, $0
	db $ff

GameCenterEntrance_NPCInteractions:
	npc_script OW_CHIP_GIRL_1, $0f, $6e11
	npc_script OW_MONOCLE_1, $0f, $6e83
	db $ff

GameCenterEntrance_OWInteractions:
	ow_script 9, 4, $0f, $6db2
	ow_script 2, 4, $0f, $6db7
	db $ff

GameCenterEntrance_MapScripts:
	dbw $06, $6d92
	dbw $08, $6da2
	dbw $07, $6d99
	db $ff
; gap from 0x3ed92 to 0x3eefa

SECTION "Bank f@6efa", ROMX[$6efa], BANK[$f]

GameCenterLobby_MapHeader:
	db MAP_GFX_GAME_CENTER_LOBBY
	dba GameCenterLobby_MapScripts
	db MUSIC_GAMECORNER

GameCenterLobby_StepEvents:
	map_exit 13, 6, MAP_GAME_CENTER_ENTRANCE, 1, 6, EAST
	map_exit 13, 7, MAP_GAME_CENTER_ENTRANCE, 1, 6, EAST
	db $ff

GameCenterLobby_NPCs:
	npc OW_TECH_8, 10, 4, WEST, $0
	npc OW_GR_LASS_6, 8, 9, EAST, $0
	npc OW_GR_PAPPY_3, 3, 7, SOUTH, $0
	npc OW_IMAKUNI_RED, 12, 1, NORTH, $703d
	npc OW_GR_CLERK_3, 5, 2, SOUTH, $0
	npc OW_GR_CLERK_4, 8, 2, SOUTH, $0
	db $ff

GameCenterLobby_NPCInteractions:
	npc_script OW_TECH_8, $0f, $6fd6
	npc_script OW_GR_LASS_6, $0f, $6ff1
	npc_script OW_GR_PAPPY_3, $0f, $7017
	npc_script OW_IMAKUNI_RED, $0f, $44e0
	db $ff

GameCenterLobby_OWInteractions:
	ow_script 1, 2, $03, $5411
	ow_script 2, 2, $03, $5411
	ow_script 5, 4, $0f, $41d0
	ow_script 8, 4, $0f, $42d9
	db $ff

GameCenterLobby_MapScripts:
	dbw $06, $6f95
	dbw $08, $6fa5
	dbw $09, $6fb5
	dbw $0b, $6fba
	dbw $07, $6f9c
	dbw $10, $6f80
	db $ff
; gap from 0x3ef80 to 0x3f04c

SECTION "Bank f@704c", ROMX[$704c], BANK[$f]

CardDungeonPawn_MapHeader:
	db MAP_GFX_CARD_DUNGEON_PAWN
	dba CardDungeonPawn_MapScripts
	db MUSIC_FORT_3

CardDungeonPawn_StepEvents:
	map_exit 4, 0, MAP_CARD_DUNGEON_KNIGHT, 4, 8, NORTH
	map_exit 5, 0, MAP_CARD_DUNGEON_KNIGHT, 5, 8, NORTH
	db $ff

CardDungeonPawn_NPCs:
	npc OW_PAWN, 4, 4, SOUTH, $0
	db $ff

CardDungeonPawn_NPCInteractions:
	npc_script OW_PAWN, $0f, $70d9
	db $ff

CardDungeonPawn_OWInteractions:
	ow_script 4, 1, $0f, $71de
	ow_script 5, 1, $0f, $71de
	db $ff

CardDungeonPawn_MapScripts:
	dbw $06, $7093
	dbw $08, $70a3
	dbw $09, $70d4
	dbw $07, $709a
	dbw $02, $70b3
	db $ff
; gap from 0x3f093 to 0x3f1f2

SECTION "Bank f@71f2", ROMX[$71f2], BANK[$f]

CardDungeonKnight_MapHeader:
	db MAP_GFX_CARD_DUNGEON_KNIGHT
	dba CardDungeonKnight_MapScripts
	db MUSIC_FORT_3

CardDungeonKnight_StepEvents:
	map_exit 4, 0, MAP_CARD_DUNGEON_BISHOP, 4, 8, NORTH
	map_exit 5, 0, MAP_CARD_DUNGEON_BISHOP, 5, 8, NORTH
	db $ff

CardDungeonKnight_NPCs:
	npc OW_KNIGHT, 4, 3, SOUTH, $0
	db $ff

CardDungeonKnight_NPCInteractions:
	npc_script OW_KNIGHT, $0f, $727f
	db $ff

CardDungeonKnight_OWInteractions:
	ow_script 4, 1, $0f, $73ad
	ow_script 5, 1, $0f, $73ad
	db $ff

CardDungeonKnight_MapScripts:
	dbw $06, $7239
	dbw $08, $7249
	dbw $09, $727a
	dbw $07, $7240
	dbw $02, $7259
	db $ff
; gap from 0x3f239 to 0x3f3c2

SECTION "Bank f@73c2", ROMX[$73c2], BANK[$f]

CardDungeonRook_MapHeader:
	db MAP_GFX_CARD_DUNGEON_ROOK
	dba CardDungeonRook_MapScripts
	db MUSIC_FORT_3

CardDungeonRook_StepEvents:
	map_exit 4, 0, MAP_CARD_DUNGEON_QUEEN, 4, 10, NORTH
	map_exit 5, 0, MAP_CARD_DUNGEON_QUEEN, 5, 10, NORTH
	db $ff

CardDungeonRook_NPCs:
	npc OW_ROOK, 5, 3, SOUTH, $0
	db $ff

CardDungeonRook_NPCInteractions:
	npc_script OW_ROOK, $0f, $744f
	db $ff

CardDungeonRook_OWInteractions:
	ow_script 4, 1, $0f, $7596
	ow_script 5, 1, $0f, $7596
	db $ff

CardDungeonRook_MapScripts:
	dbw $06, $7409
	dbw $08, $7419
	dbw $09, $744a
	dbw $07, $7410
	dbw $02, $7429
	db $ff
; gap from 0x3f409 to 0x3f5ab

SECTION "Bank f@75ab", ROMX[$75ab], BANK[$f]

WaterFortLobby_MapHeader:
	db MAP_GFX_WATER_FORT_LOBBY
	dba WaterFortLobby_MapScripts
	db MUSIC_FORT_1

WaterFortLobby_StepEvents:
	map_exit 13, 6, MAP_WATER_FORT_ENTRANCE, 1, 3, EAST
	map_exit 13, 7, MAP_WATER_FORT_ENTRANCE, 1, 4, EAST
	db $ff

WaterFortLobby_NPCs:
	npc OW_SPECS_2, 10, 10, WEST, $7718
	npc OW_GR_LAD_3, 10, 10, WEST, $7735
	npc OW_GR_GRANNY_2, 2, 7, SOUTH, $0
	npc OW_GR_GAL_2, 5, 9, NORTH, $0
	npc OW_IMAKUNI_RED, 12, 1, NORTH, $77a6
	npc OW_GR_CLERK_3, 5, 2, SOUTH, $0
	npc OW_GR_CLERK_4, 8, 2, SOUTH, $0
	db $ff

WaterFortLobby_NPCInteractions:
	npc_script OW_SPECS_2, $0f, $7691
	npc_script OW_GR_LAD_3, $0f, $7691
	npc_script OW_GR_GRANNY_2, $0f, $7752
	npc_script OW_GR_GAL_2, $0f, $7780
	npc_script OW_IMAKUNI_RED, $0f, $44e0
	db $ff

WaterFortLobby_OWInteractions:
	ow_script 1, 2, $03, $5411
	ow_script 2, 2, $03, $5411
	ow_script 5, 4, $0f, $41d0
	ow_script 8, 4, $0f, $42d9
	db $ff

WaterFortLobby_MapScripts:
	dbw $06, $7650
	dbw $08, $7660
	dbw $09, $7670
	dbw $0b, $7675
	dbw $07, $7657
	dbw $10, $763b
	db $ff
; gap from 0x3f63b to 0x3f7b5

SECTION "Bank f@77b5", ROMX[$77b5], BANK[$f]

FightingFortMaze19_MapHeader:
	db MAP_GFX_FIGHTING_FORT_MAZE_19
	dba FightingFortMaze19_MapScripts
	db MUSIC_FORT_3

FightingFortMaze19_StepEvents:
	map_exit 4, 8, MAP_FIGHTING_FORT_MAZE_14, 4, 1, SOUTH
	map_exit 5, 8, MAP_FIGHTING_FORT_MAZE_14, 5, 1, SOUTH
	map_exit 0, 3, MAP_FIGHTING_FORT_MAZE_18, 8, 3, WEST
	map_exit 0, 4, MAP_FIGHTING_FORT_MAZE_18, 8, 4, WEST
	db $ff

FightingFortMaze19_NPCs:
	npc OW_CHEST_CLOSED, 5, 3, SOUTH, $7830
	npc OW_CHEST_OPENED, 5, 3, SOUTH, $784b
	db $ff

FightingFortMaze19_NPCInteractions:
	npc_script OW_CHEST_CLOSED, $0f, $7817
	npc_script OW_CHEST_OPENED, $0f, $783d
	db $ff

FightingFortMaze19_MapScripts:
	dbw $06, $77ff
	dbw $08, $780f
	dbw $07, $7806
	db $ff
; gap from 0x3f7ff to 0x3f884

SECTION "Bank f@7884", ROMX[$7884], BANK[$f]

FightingFortBasement_MapHeader:
	db MAP_GFX_FIGHTING_FORT_BASEMENT
	dba FightingFortBasement_MapScripts
	db MUSIC_FORT_3

FightingFortBasement_StepEvents:
	map_exit 1, 6, MAP_FIGHTING_FORT, 1, 4, SOUTH
	db $ff

FightingFortBasement_NPCs:
	npc OW_CHEST_CLOSED, 1, 1, SOUTH, $7925
	npc OW_CHEST_OPENED, 1, 1, SOUTH, $7951
	db $ff

FightingFortBasement_NPCInteractions:
	npc_script OW_CHEST_CLOSED, $0f, $790c
	npc_script OW_CHEST_OPENED, $0f, $7932
	db $ff

FightingFortBasement_MapScripts:
	dbw $06, $78b6
	dbw $08, $7904
	dbw $07, $78bd
	dbw $02, $78c6
	db $ff
