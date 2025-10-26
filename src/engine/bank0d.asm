SECTION "Bank d@41c4", ROMX[$41c4], BANK[$d]

; RONALD_DUEL_GC_PIECES_2
Script_FinishedRonaldDuelGCPieces2:
	xor a
	start_script
	script_command_01
	check_event EVENT_SET_UNTIL_MAP_RELOAD_2
	script_jump_if_b0nz .player_lost
	print_npc_text RonaldGCPieces2PlayerWon1Text
	give_card SUPER_ENERGY_RETRIEVAL
	show_card_received_screen SUPER_ENERGY_RETRIEVAL
	print_npc_text RonaldGCPieces2PlayerWon2Text
	script_jump .exit

.player_lost
	print_npc_text RonaldGCPieces2PlayerLostText
.exit
	script_command_02
	move_active_npc NPCMovement_341f0
	wait_for_player_animation
	unload_npc NPC_RONALD
	end_script
	ld a, [wNextMusic]
	farcall PlayAfterCurrentSong
	ret

NPCMovement_341f0:
	db SOUTH, MOVE_1
	db EAST, MOVE_1
	db SOUTH, MOVE_5
	db $ff
; 0x341f7

SECTION "Bank d@426f", ROMX[$426f], BANK[$d]

Func_3426f:
	ld a, $a2
	farcall GetEventValue
	jr nz, .asm_342d5
	ld a, $a2
	farcall MaxOutEventValue
	ld a, $14
	farcall GetEventValue
	jr nz, .asm_342d5
	xor a
	start_script
	play_song_next MUSIC_RONALD
	scroll_to_position $ff, $00
	load_npc NPC_RONALD, 6, 15, SOUTH
	set_active_npc NPC_RONALD, DialogRonaldText
	move_active_npc NPCMovement_342da
	wait_for_player_animation
	script_command_01
	print_npc_text Text1274
	script_command_02
	get_player_x_position
	compare_loaded_var $06
	script_jump_if_b0nz .ows_342ad
	move_player NPCMovement_342e5, TRUE
	script_jump .ows_342b1
.ows_342ad
	move_player NPCMovement_342ec, TRUE
.ows_342b1
	move_active_npc NPCMovement_342dd
	scroll_to_position $02, $03
	wait_for_player_animation
	scroll_to_player
	script_command_01
	print_npc_text Text1275
	give_card BILLS_COMPUTER
	show_card_received_screen BILLS_COMPUTER
	print_npc_text Text1276
	script_command_02
	move_active_npc NPCMovement_342e0
	wait_for_player_animation
	unload_npc NPC_RONALD
	end_script
	ld a, [wNextMusic]
	farcall PlayAfterCurrentSong
.asm_342d5
	farcall Func_c199
	ret
NPCMovement_342da:
	db SOUTH, MOVE_2
	db $ff
NPCMovement_342dd:
	db SOUTH, MOVE_5
	db $ff
NPCMovement_342e0:
	db WEST, MOVE_1
	db SOUTH, MOVE_8
	db $ff
NPCMovement_342e5:
	db NORTH, MOVE_2
	db EAST, MOVE_1
	db NORTH, MOVE_0
	db $ff
NPCMovement_342ec:
	db NORTH, MOVE_2
	db $ff
; 0x342ef

SECTION "Bank d@4323", ROMX[$4323], BANK[$d]

Func_34323:
	xor a
	start_script
	script_command_01
	check_event EVENT_SET_UNTIL_MAP_RELOAD_2
	script_jump_if_b0nz .ows_34358
	print_npc_text Text1279
	script_command_02
	spin_active_npc 515
	replace_npc NPC_GR_X, NPC_RONALD
	set_active_npc NPC_RONALD, DialogRonaldText
	script_command_01
	print_npc_text Text127a
	give_booster_packs BoosterList_cdcf
	print_npc_text Text127b
	script_command_02
	spin_active_npc_reverse 515
	replace_npc NPC_RONALD, NPC_GR_X
	set_active_npc NPC_GR_X, DialogGRXText
	script_command_01
	print_npc_text Text127c
	script_command_02
	script_jump .ows_3437d
.ows_34358
	print_npc_text Text127d
	script_command_02
	spin_active_npc 515
	replace_npc NPC_GR_X, NPC_RONALD
	set_active_npc NPC_RONALD, DialogRonaldText
	script_command_01
	print_npc_text Text127e
	print_npc_text Text127b
	script_command_02
	spin_active_npc_reverse 515
	replace_npc NPC_RONALD, NPC_GR_X
	set_active_npc NPC_GR_X, DialogGRXText
	script_command_01
	print_npc_text Text127c
	script_command_02
.ows_3437d
	move_active_npc NPCMovement_3438c
	wait_for_player_animation
	unload_npc NPC_GR_X
	end_script
	ld a, [wNextMusic]
	farcall PlayAfterCurrentSong
	ret
NPCMovement_3438c:
	db EAST, MOVE_1
	db SOUTH, MOVE_6
	db $ff
; 0x34391

SECTION "Bank d@43ef", ROMX[$43ef], BANK[$d]

Func_343ef:
	xor a
	start_script
	script_command_01
	check_event EVENT_SET_UNTIL_MAP_RELOAD_2
	script_jump_if_b0nz .ows_34408
	print_npc_text Text1282
	give_card COMPUTER_ERROR
	show_card_received_screen COMPUTER_ERROR
	print_npc_text Text1283
	script_jump .ows_3440b
.ows_34408
	print_npc_text Text1284
.ows_3440b
	script_command_02
	spin_active_npc_reverse 515
	replace_npc NPC_RONALD, NPC_GR_X
	set_active_npc NPC_GR_X, DialogGRXText
	move_active_npc NPCMovement_3442a
	wait_for_player_animation
	unload_npc NPC_GR_X
	end_script
	ld a, $00
	ld [wd582], a
	ld a, [wNextMusic]
	farcall PlayAfterCurrentSong
	ret
NPCMovement_3442a:
	db SOUTH, MOVE_8
	db $ff
; 0x3442d

SECTION "Bank d@4575", ROMX[$4575], BANK[$d]

TcgAirportEntrance_MapHeader:
	db MAP_GFX_TCG_AIRPORT_ENTRANCE
	dba TcgAirportEntrance_MapScripts
	db MUSIC_OVERWORLD

TcgAirportEntrance_StepEvents:
	map_exit 5, 12, OVERWORLD_MAP_TCG, 5, 7, SOUTH
	map_exit 6, 12, OVERWORLD_MAP_TCG, 5, 7, SOUTH
	map_exit 11, 6, MAP_TCG_AIRPORT, 1, 9, EAST
	map_exit 11, 7, MAP_TCG_AIRPORT, 1, 10, EAST
	ow_script 9, 6, $0d, $462d
	ow_script 9, 7, $0d, $462d
	db $ff

TcgAirportEntrance_NPCs:
	npc NPC_GR_5, 10, 7, WEST, $46bc
	npc NPC_GR_CLERK_TCG_AIRPORT, 7, 3, SOUTH, NULL
	npc NPC_TCG_AIRPORT_GR_SIS, 3, 2, NORTH, NULL
	npc NPC_TCG_AIRPORT_MARTIAL_ARTIST, 1, 7, EAST, NULL
	db $ff

TcgAirportEntrance_NPCInteractions:
	npc_script NPC_GR_5, $0d, $468f
	npc_script NPC_TCG_AIRPORT_GR_SIS, $0d, $471c
	npc_script NPC_TCG_AIRPORT_MARTIAL_ARTIST, $0d, $4742
	db $ff

TcgAirportEntrance_OWInteractions:
	ow_script 7, 5, $0d, $46f6
	db $ff

TcgAirportEntrance_MapScripts:
	dbw $00, $45f1
	dbw $06, $460d
	dbw $08, $461d
	dbw $07, $4614
	dbw $01, $45fd
	db $ff
; gap from 0x345f1 to 0x34773

SECTION "Bank d@4773", ROMX[$4773], BANK[$d]

TcgAirport_MapHeader:
	db MAP_GFX_TCG_AIRPORT
	dba TcgAirport_MapScripts
	db MUSIC_OVERWORLD

TcgAirport_StepEvents:
	map_exit 0, 9, MAP_TCG_AIRPORT_ENTRANCE, 10, 6, WEST
	map_exit 0, 10, MAP_TCG_AIRPORT_ENTRANCE, 10, 7, WEST
	_ow_coordinate_function 11, 8, 0, 0, 0, 3, $0d, $49cd
	ow_script 10, 9, $0d, $49cd
	ow_script 9, 9, $0d, $49cd
	_ow_coordinate_function 8, 8, 0, 0, 0, 1, $0d, $49cd
	db $ff

TcgAirport_NPCs:
	npc NPC_GR_5, 10, 8, SOUTH, NULL
	db $ff

TcgAirport_NPCInteractions:
	npc_script NPC_GR_5, $0d, $4910
	db $ff

TcgAirport_MapScripts:
	dbw $00, $47ce
	dbw $06, $47da
	dbw $08, $489d
	dbw $07, $47e1
	dbw $02, $47ea
	dbw $0f, $4873
	db $ff
; gap from 0x347ce to 0x34aaf

SECTION "Bank d@4aaf", ROMX[$4aaf], BANK[$d]

GrAirportEntrance_MapHeader:
	db MAP_GFX_GR_AIRPORT_ENTRANCE
	dba GrAirportEntrance_MapScripts
	db MUSIC_GROVERWORLD

GrAirportEntrance_StepEvents:
	map_exit 5, 12, OVERWORLD_MAP_GR, 4, 4, SOUTH
	map_exit 6, 12, OVERWORLD_MAP_GR, 4, 4, SOUTH
	map_exit 0, 6, MAP_GR_AIRPORT, 12, 9, WEST
	map_exit 0, 7, MAP_GR_AIRPORT, 12, 10, WEST
	db $ff

GrAirportEntrance_NPCs:
	npc NPC_GR_CLERK_GR_AIRPORT, 4, 3, SOUTH, NULL
	npc NPC_GR_AIRPORT_GR_PAPPY, 10, 3, WEST, NULL
	npc NPC_GR_AIRPORT_GR_LASS, 5, 8, WEST, NULL
	db $ff

GrAirportEntrance_NPCInteractions:
	npc_script NPC_GR_CLERK_6, $0d, $4b36
	npc_script NPC_GR_AIRPORT_GR_PAPPY, $0d, $4b51
	npc_script NPC_GR_AIRPORT_GR_LASS, $0d, $4b77
	db $ff

GrAirportEntrance_OWInteractions:
	ow_script 4, 5, $0d, $4b36
	ow_script 8, 2, $0d, $4b9d
	db $ff

GrAirportEntrance_MapScripts:
	dbw $06, $4b16
	dbw $08, $4b26
	dbw $07, $4b1d
	db $ff
; gap from 0x34b16 to 0x34ba8

SECTION "Bank d@4ba8", ROMX[$4ba8], BANK[$d]

GameCenter1_MapHeader:
	db MAP_GFX_GAME_CENTER_1
	dba GameCenter1_MapScripts
	db MUSIC_GAMECORNER

GameCenter1_StepEvents:
	map_exit 5, 14, MAP_GAME_CENTER_ENTRANCE, 5, 1, SOUTH
	map_exit 6, 14, MAP_GAME_CENTER_ENTRANCE, 6, 1, SOUTH
	map_exit 11, 6, MAP_GAME_CENTER_2, 1, 6, EAST
	map_exit 11, 7, MAP_GAME_CENTER_2, 1, 7, EAST
	db $ff

GameCenter1_NPCs:
	npc NPC_ATTENDANT_BLACK_BOX, 7, 4, SOUTH, NULL
	npc NPC_ATTENDANT_BILLS_PC, 1, 9, SOUTH, NULL
	npc NPC_ATTENDANT_COIN_FLIP, 9, 10, WEST, NULL
	npc NPC_GAME_CENTER_GR_GAL, 3, 5, EAST, NULL
	npc NPC_GAME_CENTER_CHUBBY_KID, 8, 8, EAST, NULL
	db $ff

GameCenter1_NPCInteractions:
	npc_script NPC_ATTENDANT_BLACK_BOX, $0d, $4d49
	npc_script NPC_ATTENDANT_BILLS_PC, $0d, $4d76
	npc_script NPC_ATTENDANT_COIN_FLIP, $0d, $4da3
	npc_script NPC_GAME_CENTER_GR_GAL, $0d, $4de6
	npc_script NPC_GAME_CENTER_CHUBBY_KID, $0d, $4e18
	db $ff

GameCenter1_OWInteractions:
	ow_script 5, 4, $0d, $4d15
	ow_script 6, 4, $0d, $4d15
	ow_script 2, 9, $0d, $4d35
	db $ff

GameCenter1_MapScripts:
	dbw $06, $4c2c
	dbw $08, $4c3c
	dbw $07, $4c33
	db $ff
; gap from 0x34c2c to 0x34e4d

SECTION "Bank d@4e4d", ROMX[$4e4d], BANK[$d]

GameCenter2_MapHeader:
	db MAP_GFX_GAME_CENTER_2
	dba GameCenter2_MapScripts
	db MUSIC_GAMECORNER

GameCenter2_StepEvents:
	map_exit 0, 6, MAP_GAME_CENTER_1, 10, 6, WEST
	map_exit 0, 7, MAP_GAME_CENTER_1, 10, 7, WEST
	db $ff

GameCenter2_NPCs:
	npc NPC_ATTENDANT_1COIN_SLOT, 1, 10, SOUTH, NULL
	npc NPC_ATTENDANT_5COIN_SLOT, 10, 10, SOUTH, NULL
	npc NPC_ATTENDANT_CARD_DUNGEON, 7, 3, SOUTH, NULL
	npc NPC_GAME_CENTER_BOY, 2, 4, EAST, NULL
	npc NPC_GAME_CENTER_FIXER, 4, 10, NORTH, NULL
	npc NPC_GAME_CENTER_GR_WOMAN, 8, 10, NORTH, NULL
	db $ff

GameCenter2_NPCInteractions:
	npc_script NPC_ATTENDANT_1COIN_SLOT, $0d, $4f25
	npc_script NPC_ATTENDANT_5COIN_SLOT, $0d, $4f50
	npc_script NPC_ATTENDANT_CARD_DUNGEON, $0d, $4f7b
	npc_script NPC_GAME_CENTER_BOY, $0d, $5016
	npc_script NPC_GAME_CENTER_FIXER, $0d, $5047
	npc_script NPC_GAME_CENTER_GR_WOMAN, $0d, $506f
	db $ff

GameCenter2_OWInteractions:
	_ow_coordinate_function 2, 10, 1, 0, 0, 0, $07, $596e
	_ow_coordinate_function 3, 10, 1, 0, 0, 0, $07, $596e
	_ow_coordinate_function 4, 10, 1, 0, 0, 0, $07, $596e
	_ow_coordinate_function 7, 10, 5, 0, 0, 0, $07, $596e
	_ow_coordinate_function 8, 10, 5, 0, 0, 0, $07, $596e
	_ow_coordinate_function 9, 10, 5, 0, 0, 0, $07, $596e
	db $ff

GameCenter2_MapScripts:
	dbw $06, $4ee7
	dbw $08, $4ef7
	dbw $07, $4eee
	dbw $02, $4f07
	db $ff
; gap from 0x34ee7 to 0x3509f

SECTION "Bank d@509f", ROMX[$509f], BANK[$d]

CardDungeonBishop_MapHeader:
	db MAP_GFX_CARD_DUNGEON_BISHOP
	dba CardDungeonBishop_MapScripts
	db MUSIC_FORT_3

CardDungeonBishop_StepEvents:
	map_exit 4, 0, MAP_CARD_DUNGEON_ROOK, 4, 8, NORTH
	map_exit 5, 0, MAP_CARD_DUNGEON_ROOK, 5, 8, NORTH
	db $ff

CardDungeonBishop_NPCs:
	npc NPC_BISHOP, 5, 3, SOUTH, NULL
	db $ff

CardDungeonBishop_NPCInteractions:
	npc_script NPC_BISHOP, $0d, $512c
	db $ff

CardDungeonBishop_OWInteractions:
	ow_script 4, 1, $0d, $5273
	ow_script 5, 1, $0d, $5273
	db $ff

CardDungeonBishop_MapScripts:
	dbw $06, $50e6
	dbw $08, $50f6
	dbw $09, $5127
	dbw $07, $50ed
	dbw $02, $5106
	db $ff
; gap from 0x350e6 to 0x35288

SECTION "Bank d@5288", ROMX[$5288], BANK[$d]

GrChallengeHallLobby_MapHeader:
	db MAP_GFX_GR_CHALLENGE_HALL_LOBBY
	dba GrChallengeHallLobby_MapScripts
	db MUSIC_GROVERWORLD

GrChallengeHallLobby_StepEvents:
	map_exit 13, 6, MAP_GR_CHALLENGE_HALL_ENTRANCE, 1, 3, EAST
	map_exit 13, 7, MAP_GR_CHALLENGE_HALL_ENTRANCE, 1, 4, EAST
	db $ff

GrChallengeHallLobby_NPCs:
	npc NPC_GR_CHALLENGE_HALL_GR_GRANNY, 3, 5, WEST, NULL
	npc NPC_CUP_HOST, 2, 10, NORTH, $53ce
	npc NPC_GR_CHALLENGE_HALL_GR_CHAP, 8, 9, EAST, $5444
	npc NPC_GR_CHALLENGE_HALL_GR_WOMAN, 12, 8, WEST, NULL
	npc NPC_GR_CLERK_BATTLE_CENTER, 5, 2, SOUTH, NULL
	npc NPC_GR_CLERK_GIFT_CENTER, 8, 2, SOUTH, NULL
	db $ff

GrChallengeHallLobby_NPCInteractions:
	npc_script NPC_GR_CHALLENGE_HALL_GR_GRANNY, $0d, $5342
	npc_script NPC_CUP_HOST, $0d, $53a8
	npc_script NPC_GR_CHALLENGE_HALL_GR_WOMAN, $0d, $5451
	npc_script NPC_GR_CHALLENGE_HALL_GR_CHAP, $0d, $53e5
	db $ff

GrChallengeHallLobby_OWInteractions:
	ow_script 1, 2, PCMenu
	ow_script 2, 2, PCMenu
	ow_script 5, 4, $0f, $41d0
	ow_script 8, 4, $0f, $42d9
	db $ff

GrChallengeHallLobby_MapScripts:
	dbw $06, $5322
	dbw $08, $5332
	dbw $07, $5329
	dbw $01, $5308
	db $ff
; gap from 0x35308 to 0x354a2

SECTION "Bank d@54a2", ROMX[$54a2], BANK[$d]

GrassFortMorino_MapHeader:
	db MAP_GFX_GRASS_FORT_MORINO
	dba GrassFortMorino_MapScripts
	db MUSIC_FORT_1

GrassFortMorino_StepEvents:
	map_exit 6, 15, MAP_GRASS_FORT_MIYUKI, 5, 1, SOUTH
	map_exit 7, 15, MAP_GRASS_FORT_MIYUKI, 6, 1, SOUTH
	db $ff

GrassFortMorino_NPCs:
	npc NPC_MORINO, 7, 2, SOUTH, NULL
	db $ff

GrassFortMorino_NPCInteractions:
	npc_script NPC_MORINO, $0d, $54fb
	db $ff

GrassFortMorino_MapScripts:
	dbw $06, $54d3
	dbw $08, $54e3
	dbw $09, $54eb
	dbw $07, $54da
	db $ff
; gap from 0x354d3 to 0x354f6

SECTION "Bank d@54f6", ROMX[$54f6], BANK[$d]

GrassFortMorino_AfterDuelScripts:
	npc_script NPC_MORINO, $0d, $5596
	db $ff
; gap from 0x354fb to 0x355de

SECTION "Bank d@55de", ROMX[$55de], BANK[$d]

WaterFortSenta_MapHeader:
	db MAP_GFX_WATER_FORT_SENTA
	dba WaterFortSenta_MapScripts
	db MUSIC_FORT_1

WaterFortSenta_StepEvents:
	map_exit 6, 11, MAP_WATER_FORT_MIYAJIMA, 4, 1, SOUTH
	map_exit 7, 11, MAP_WATER_FORT_MIYAJIMA, 5, 1, SOUTH
	map_exit 13, 5, MAP_WATER_FORT_AIRA, 1, 6, EAST
	map_exit 13, 6, MAP_WATER_FORT_AIRA, 1, 7, EAST
	db $ff

WaterFortSenta_NPCs:
	npc NPC_SENTA, 6, 3, SOUTH, NULL
	db $ff

WaterFortSenta_NPCInteractions:
	npc_script NPC_SENTA, $0d, $5679
	db $ff

WaterFortSenta_MapScripts:
	dbw $06, $5624
	dbw $08, $5661
	dbw $09, $5669
	dbw $07, $562b
	dbw $02, $5634
	db $ff
; gap from 0x35624 to 0x35674

SECTION "Bank d@5674", ROMX[$5674], BANK[$d]

WaterFortSenta_AfterDuelScripts:
	npc_script NPC_SENTA, $0d, $56e8
	db $ff
; gap from 0x35679 to 0x3580f

SECTION "Bank d@580f", ROMX[$580f], BANK[$d]

WaterFortAira_MapHeader:
	db MAP_GFX_WATER_FORT_AIRA
	dba WaterFortAira_MapScripts
	db MUSIC_FORT_1

WaterFortAira_StepEvents:
	map_exit 0, 6, MAP_WATER_FORT_SENTA, 12, 5, WEST
	map_exit 0, 7, MAP_WATER_FORT_SENTA, 12, 6, WEST
	map_exit 4, 0, MAP_WATER_FORT_KANOKO, 6, 12, NORTH
	map_exit 5, 0, MAP_WATER_FORT_KANOKO, 7, 12, NORTH
	db $ff

WaterFortAira_NPCs:
	npc NPC_AIRA, 4, 5, SOUTH, NULL
	db $ff

WaterFortAira_NPCInteractions:
	npc_script NPC_AIRA, $0d, $589a
	db $ff

WaterFortAira_MapScripts:
	dbw $06, $5855
	dbw $08, $5882
	dbw $09, $588a
	dbw $07, $585c
	dbw $02, $5865
	db $ff
; gap from 0x35855 to 0x35895

SECTION "Bank d@5895", ROMX[$5895], BANK[$d]

WaterFortAira_AfterDuelScripts:
	npc_script NPC_AIRA, $0d, $58f3
	db $ff
; gap from 0x3589a to 0x35989

SECTION "Bank d@5989", ROMX[$5989], BANK[$d]

FightingFort_MapHeader:
	db MAP_GFX_FIGHTING_FORT
	dba FightingFort_MapScripts
	db MUSIC_FORT_3

FightingFort_StepEvents:
	map_exit 7, 0, OVERWORLD_MAP_GR, 4, 4, SOUTH
	map_exit 8, 0, OVERWORLD_MAP_GR, 4, 4, SOUTH
	map_exit 7, 8, MAP_FIGHTING_FORT_ENTRANCE, 4, 1, SOUTH
	map_exit 8, 8, MAP_FIGHTING_FORT_ENTRANCE, 5, 1, SOUTH
	map_exit 3, 1, MAP_FIGHTING_FORT_MAZE_1, 4, 7, NORTH
	map_exit 12, 1, MAP_FIGHTING_FORT_MAZE_3, 4, 7, NORTH
	map_exit 1, 4, MAP_FIGHTING_FORT_BASEMENT, 1, 6, NORTH
	db $ff

FightingFort_NPCs:
	npc NPC_KAMIYA, 6, 2, SOUTH, NULL
	db $ff

FightingFort_NPCInteractions:
	npc_script NPC_KAMIYA, $0d, $5b16
	db $ff

FightingFort_OWInteractions:
	ow_script 7, 1, $0d, $5be4
	ow_script 8, 1, $0d, $5be4
	db $ff

FightingFort_MapScripts:
	dbw $06, $59fd
	dbw $08, $5a7c
	dbw $09, $5a8c
	dbw $07, $5a04
	dbw $02, $5a0d
	db $ff
; gap from 0x359fd to 0x35a97

SECTION "Bank d@5a97", ROMX[$5a97], BANK[$d]

FightingFort_AfterDuelScripts:
	npc_script NPC_KAMIYA, $0d, $5b82
	db $ff
; gap from 0x35a9c to 0x35c10

SECTION "Bank d@5c10", ROMX[$5c10], BANK[$d]

FightingFortMaze16_MapHeader:
	db MAP_GFX_FIGHTING_FORT_MAZE_16
	dba FightingFortMaze16_MapScripts
	db MUSIC_FORT_3

FightingFortMaze16_StepEvents:
	map_exit 4, 8, MAP_FIGHTING_FORT_MAZE_11, 4, 1, SOUTH
	map_exit 5, 8, MAP_FIGHTING_FORT_MAZE_11, 5, 1, SOUTH
	map_exit 4, 0, MAP_FIGHTING_FORT_MAZE_20, 4, 7, NORTH
	map_exit 5, 0, MAP_FIGHTING_FORT_MAZE_20, 5, 7, NORTH
	map_exit 0, 3, MAP_FIGHTING_FORT_MAZE_15, 8, 3, WEST
	map_exit 0, 4, MAP_FIGHTING_FORT_MAZE_15, 8, 4, WEST
	_ow_coordinate_function 4, 6, 104, 10, 1, 2, $0d, $5c86
	_ow_coordinate_function 5, 6, 104, 10, 1, 2, $0d, $5c86
	db $ff

FightingFortMaze16_MapScripts:
	dbw $06, $5c68
	dbw $0f, $5c6f
	dbw $02, $5c7b
	db $ff
; gap from 0x35c68 to 0x35c9a

SECTION "Bank d@5c9a", ROMX[$5c9a], BANK[$d]

FightingFortMaze18_MapHeader:
	db MAP_GFX_FIGHTING_FORT_MAZE_18
	dba FightingFortMaze18_MapScripts
	db MUSIC_FORT_3

FightingFortMaze18_StepEvents:
	map_exit 4, 8, MAP_FIGHTING_FORT_MAZE_13, 4, 1, SOUTH
	map_exit 5, 8, MAP_FIGHTING_FORT_MAZE_13, 5, 1, SOUTH
	map_exit 4, 0, MAP_FIGHTING_FORT_MAZE_22, 4, 7, NORTH
	map_exit 5, 0, MAP_FIGHTING_FORT_MAZE_22, 5, 7, NORTH
	map_exit 0, 3, MAP_FIGHTING_FORT_MAZE_17, 8, 3, WEST
	map_exit 0, 4, MAP_FIGHTING_FORT_MAZE_17, 8, 4, WEST
	map_exit 9, 3, MAP_FIGHTING_FORT_MAZE_19, 1, 3, EAST
	map_exit 9, 4, MAP_FIGHTING_FORT_MAZE_19, 1, 4, EAST
	_ow_coordinate_function 4, 6, 104, 10, 1, 2, $0d, $5d22
	_ow_coordinate_function 5, 6, 104, 10, 1, 2, $0d, $5d22
	db $ff

FightingFortMaze18_MapScripts:
	dbw $06, $5d04
	dbw $0f, $5d0b
	dbw $02, $5d17
	db $ff
; gap from 0x35d04 to 0x35d36

SECTION "Bank d@5d36", ROMX[$5d36], BANK[$d]

FightingFortGoda_MapHeader:
	db MAP_GFX_FIGHTING_FORT_GODA
	dba FightingFortGoda_MapScripts
	db MUSIC_FORT_3

FightingFortGoda_StepEvents:
	map_exit 5, 10, MAP_FIGHTING_FORT_MAZE_15, 4, 1, SOUTH
	map_exit 6, 10, MAP_FIGHTING_FORT_MAZE_15, 5, 1, SOUTH
	db $ff

FightingFortGoda_NPCs:
	npc NPC_GODA, 5, 4, SOUTH, NULL
	npc NPC_MITCH, 6, 2, SOUTH, $5de2
	db $ff

FightingFortGoda_NPCInteractions:
	npc_script NPC_GODA, $0d, $5def
	db $ff

FightingFortGoda_OWInteractions:
	ow_script 6, 4, $0d, $5dc0
	db $ff

FightingFortGoda_MapScripts:
	dbw $06, $5d7a
	dbw $08, $5da0
	dbw $09, $5db0
	dbw $07, $5d81
	dbw $02, $5d8a
	db $ff
; gap from 0x35d7a to 0x35dbb

SECTION "Bank d@5dbb", ROMX[$5dbb], BANK[$d]

FightingFortGoda_AfterDuelScripts:
	npc_script NPC_GODA, $0d, $5e5e
	db $ff
; gap from 0x35dc0 to 0x35f14

SECTION "Bank d@5f14", ROMX[$5f14], BANK[$d]

FightingFortGrace_MapHeader:
	db MAP_GFX_FIGHTING_FORT_GRACE
	dba FightingFortGrace_MapScripts
	db MUSIC_FORT_3

FightingFortGrace_StepEvents:
	map_exit 4, 10, MAP_FIGHTING_FORT_MAZE_5, 4, 1, SOUTH
	map_exit 5, 10, MAP_FIGHTING_FORT_MAZE_5, 5, 1, SOUTH
	db $ff

FightingFortGrace_NPCs:
	npc NPC_GRACE, 4, 2, SOUTH, NULL
	npc NPC_CHEST_CLOSED, 5, 1, SOUTH, $6062
	npc NPC_CHEST_OPENED, 5, 1, SOUTH, $6082
	db $ff

FightingFortGrace_NPCInteractions:
	npc_script NPC_GRACE, $0d, $5f81
	npc_script NPC_CHEST_CLOSED, $0d, $6049
	npc_script NPC_CHEST_OPENED, $0d, $6077
	db $ff

FightingFortGrace_MapScripts:
	dbw $06, $5f59
	dbw $08, $5f69
	dbw $09, $5f71
	dbw $07, $5f60
	db $ff
; gap from 0x35f59 to 0x35f7c

SECTION "Bank d@5f7c", ROMX[$5f7c], BANK[$d]

FightingFortGrace_AfterDuelScripts:
	npc_script NPC_GRACE, $0d, $5ffb
	db $ff
; gap from 0x35f81 to 0x36097

SECTION "Bank d@6097", ROMX[$6097], BANK[$d]

PsychicStrongholdEntrance_MapHeader:
	db MAP_GFX_PSYCHIC_STRONGHOLD_ENTRANCE
	dba PsychicStrongholdEntrance_MapScripts
	db MUSIC_FORT_2

PsychicStrongholdEntrance_StepEvents:
	map_exit 4, 8, OVERWORLD_MAP_GR, 4, 4, SOUTH
	map_exit 5, 8, OVERWORLD_MAP_GR, 4, 4, SOUTH
	map_exit 0, 3, MAP_PSYCHIC_STRONGHOLD_LOBBY, 12, 6, WEST
	map_exit 0, 4, MAP_PSYCHIC_STRONGHOLD_LOBBY, 12, 7, WEST
	map_exit 4, 0, MAP_PSYCHIC_STRONGHOLD, 7, 11, NORTH
	map_exit 5, 0, MAP_PSYCHIC_STRONGHOLD, 8, 11, NORTH
	db $ff

PsychicStrongholdEntrance_NPCs:
	npc NPC_GR_CLERK_PSYCHIC_STRONGHOLD, 3, 1, SOUTH, NULL
	db $ff

PsychicStrongholdEntrance_NPCInteractions:
	npc_script NPC_GR_CLERK_PSYCHIC_STRONGHOLD, $0d, $6148
	db $ff

PsychicStrongholdEntrance_MapScripts:
	dbw $06, $6104
	dbw $08, $6140
	dbw $07, $610b
	dbw $02, $6114
	dbw $10, $60ef
	db $ff
; gap from 0x360ef to 0x36173

SECTION "Bank d@6173", ROMX[$6173], BANK[$d]

PsychicStrongholdLobby_MapHeader:
	db MAP_GFX_PSYCHIC_STRONGHOLD_LOBBY
	dba PsychicStrongholdLobby_MapScripts
	db MUSIC_FORT_2

PsychicStrongholdLobby_StepEvents:
	map_exit 13, 6, MAP_PSYCHIC_STRONGHOLD_ENTRANCE, 1, 3, EAST
	map_exit 13, 7, MAP_PSYCHIC_STRONGHOLD_ENTRANCE, 1, 4, EAST
	db $ff

PsychicStrongholdLobby_NPCs:
	npc NPC_PSYCHIC_STRONGHOLD_LADY, 2, 6, WEST, NULL
	npc NPC_PSYCHIC_STRONGHOLD_UNCAPPED_LAD, 5, 9, EAST, NULL
	npc NPC_GR_PSYCHIC_STRONGHOLD_GR_LASS, 10, 4, EAST, NULL
	npc NPC_IMAKUNI_RED, 12, 1, NORTH, $6310
	npc NPC_GR_CLERK_BATTLE_CENTER, 5, 2, SOUTH, NULL
	npc NPC_GR_CLERK_GIFT_CENTER, 8, 2, SOUTH, NULL
	db $ff

PsychicStrongholdLobby_NPCInteractions:
	npc_script NPC_PSYCHIC_STRONGHOLD_LADY, $0d, $6250
	npc_script NPC_PSYCHIC_STRONGHOLD_UNCAPPED_LAD, $0d, $62c4
	npc_script NPC_GR_PSYCHIC_STRONGHOLD_GR_LASS, $0d, $62ea
	npc_script NPC_IMAKUNI_RED, $0f, $44e0
	db $ff

PsychicStrongholdLobby_OWInteractions:
	ow_script 1, 2, PCMenu
	ow_script 2, 2, PCMenu
	ow_script 5, 4, $0f, $41d0
	ow_script 8, 4, $0f, $42d9
	db $ff

PsychicStrongholdLobby_MapScripts:
	dbw $06, $620e
	dbw $08, $621e
	dbw $09, $622e
	dbw $0b, $6234
	dbw $07, $6215
	dbw $10, $61f9
	db $ff
; gap from 0x361f9 to 0x3631f

SECTION "Bank d@631f", ROMX[$631f], BANK[$d]

PsychicStronghold_MapHeader:
	db MAP_GFX_PSYCHIC_STRONGHOLD
	dba PsychicStronghold_MapScripts
	db MUSIC_FORT_2

PsychicStronghold_StepEvents:
	_ow_coordinate_function 7, 12, 107, 4, 1, 2, $0d, $6bc8
	_ow_coordinate_function 8, 12, 107, 5, 1, 2, $0d, $6bc8
	_ow_coordinate_function 7, 3, 110, 7, 10, 0, $0d, $6be5
	_ow_coordinate_function 8, 3, 110, 8, 10, 0, $0d, $6be5
	db $ff

PsychicStronghold_NPCs:
	npc NPC_MIWA, 5, 7, SOUTH, NULL
	npc NPC_KEVIN, 3, 5, SOUTH, NULL
	npc NPC_YOSUKE, 10, 7, SOUTH, NULL
	npc NPC_RYOKO, 12, 5, SOUTH, NULL
	npc NPC_STRONGHOLD_PLATFORM, 6, 3, SOUTH, $6b8f
	db $ff

PsychicStronghold_NPCInteractions:
	npc_script NPC_MIWA, $0d, $6712
	npc_script NPC_KEVIN, $0d, $682a
	npc_script NPC_YOSUKE, $0d, $6921
	npc_script NPC_RYOKO, $0d, $6a2a
	db $ff

PsychicStronghold_MapScripts:
	dbw $06, $638f
	dbw $08, $6440
	dbw $12, $6448
	dbw $09, $6490
	dbw $07, $6396
	dbw $02, $639f
	dbw $0f, $6434
	db $ff
; gap from 0x3638f to 0x3649b

SECTION "Bank d@649b", ROMX[$649b], BANK[$d]

PsychicStronghold_AfterDuelScripts:
	npc_script NPC_MIWA, $0d, $678e
	npc_script NPC_KEVIN, $0d, $6887
	npc_script NPC_YOSUKE, $0d, $6990
	npc_script NPC_RYOKO, $0d, $6ad3
	db $ff
; gap from 0x364ac to 0x36c9b

SECTION "Bank d@6c9b", ROMX[$6c9b], BANK[$d]

PsychicStrongholdMami_MapHeader:
	db MAP_GFX_PSYCHIC_STRONGHOLD_MAMI
	dba PsychicStrongholdMami_MapScripts
	db MUSIC_FORT_2

PsychicStrongholdMami_StepEvents:
	_ow_coordinate_function 7, 10, 109, 7, 3, 2, $0d, $6f7f
	_ow_coordinate_function 8, 10, 109, 8, 3, 2, $0d, $6f7f
	db $ff

PsychicStrongholdMami_NPCs:
	npc NPC_MAMI, 7, 2, NORTH, NULL
	npc NPC_ROD, 8, 2, SOUTH, $6e03
	npc NPC_STRONGHOLD_PLATFORM, 6, 10, SOUTH, NULL
	db $ff

PsychicStrongholdMami_NPCInteractions:
	npc_script NPC_MAMI, $0d, $6e18
	npc_script NPC_ROD, $0d, $6de8
	db $ff

PsychicStrongholdMami_MapScripts:
	dbw $06, $6ce5
	dbw $08, $6d21
	dbw $12, $6d29
	dbw $09, $6d65
	dbw $07, $6cec
	dbw $02, $6cf5
	dbw $0f, $6d1e
	db $ff
; gap from 0x36ce5 to 0x36d70

SECTION "Bank d@6d70", ROMX[$6d70], BANK[$d]

PsychicStrongholdMami_AfterDuelScripts:
	npc_script NPC_MAMI, $0d, $6e9b
	db $ff
; gap from 0x36d75 to 0x36f9a

SECTION "Bank d@6f9a", ROMX[$6f9a], BANK[$d]

ColorlessAltar_MapHeader:
	db MAP_GFX_COLORLESS_ALTAR
	dba ColorlessAltar_MapScripts
	db MUSIC_FORT_4

ColorlessAltar_StepEvents:
	map_exit 5, 11, MAP_COLORLESS_ALTAR_ENTRANCE, 4, 1, SOUTH
	map_exit 6, 11, MAP_COLORLESS_ALTAR_ENTRANCE, 5, 1, SOUTH
	db $ff

ColorlessAltar_NPCs:
	npc NPC_NISHIJIMA, 6, 6, NORTH, NULL
	npc NPC_ISHII, 6, 3, NORTH, NULL
	npc NPC_SAMEJIMA, 5, 4, SOUTH, NULL
	db $ff

ColorlessAltar_NPCInteractions:
	npc_script NPC_NISHIJIMA, $0d, $7082
	npc_script NPC_ISHII, $0d, $7179
	npc_script NPC_SAMEJIMA, $0d, $728d
	db $ff

ColorlessAltar_MapScripts:
	dbw $06, $6fe2
	dbw $08, $7011
	dbw $09, $7019
	dbw $07, $6fe9
	dbw $02, $6ff2
	db $ff
; gap from 0x36fe2 to 0x37024

SECTION "Bank d@7024", ROMX[$7024], BANK[$d]

ColorlessAltar_AfterDuelScripts:
	npc_script NPC_NISHIJIMA, $0d, $713b
	npc_script NPC_ISHII, $0d, $724a
	npc_script NPC_SAMEJIMA, $0d, $7329
	db $ff
; gap from 0x37031 to 0x37365

SECTION "Bank d@7365", ROMX[$7365], BANK[$d]

GrCastleEntrance_MapHeader:
	db MAP_GFX_GR_CASTLE_ENTRANCE
	dba GrCastleEntrance_MapScripts
	db MUSIC_GRCASTLE

GrCastleEntrance_StepEvents:
	map_exit 4, 8, OVERWORLD_MAP_GR, 4, 4, SOUTH
	map_exit 5, 8, OVERWORLD_MAP_GR, 4, 4, SOUTH
	map_exit 6, 8, OVERWORLD_MAP_GR, 4, 4, SOUTH
	db $ff

GrCastleEntrance_NPCs:
	npc NPC_GR_CLERK_CASTLE_RIGHT, 7, 3, SOUTH, NULL
	npc NPC_GR_CLERK_CASTLE_LEFT, 3, 3, SOUTH, NULL
	db $ff

GrCastleEntrance_NPCInteractions:
	npc_script NPC_GR_CLERK_CASTLE_RIGHT, $0d, $7493
	npc_script NPC_GR_CLERK_CASTLE_LEFT, $0d, $7534
	db $ff

GrCastleEntrance_OWInteractions:
	ow_script 4, 3, $0d, $7480
	ow_script 5, 3, $0d, $7480
	ow_script 6, 3, $0d, $7480
	db $ff

GrCastleEntrance_MapScripts:
	dbw $00, $73cb
	dbw $06, $740f
	dbw $08, $746b
	dbw $07, $7416
	dbw $02, $741f
	dbw $09, $747b
	db $ff
; gap from 0x373cb to 0x375df

SECTION "Bank d@75df", ROMX[$75df], BANK[$d]

GrCastle_MapHeader:
	db MAP_GFX_GR_CASTLE
	dba GrCastle_MapScripts
	db MUSIC_GRCASTLE

GrCastle_StepEvents:
	map_exit 6, 15, MAP_GR_CASTLE_ENTRANCE, 4, 3, SOUTH
	map_exit 7, 15, MAP_GR_CASTLE_ENTRANCE, 5, 3, SOUTH
	map_exit 8, 15, MAP_GR_CASTLE_ENTRANCE, 6, 3, SOUTH
	map_exit 6, 0, MAP_GR_CASTLE_BIRURITCHI, 6, 14, NORTH
	map_exit 7, 0, MAP_GR_CASTLE_BIRURITCHI, 7, 14, NORTH
	map_exit 8, 0, MAP_GR_CASTLE_BIRURITCHI, 8, 14, NORTH
	ow_script 6, 5, $0d, $7a5f
	ow_script 7, 5, $0d, $7a5f
	ow_script 8, 5, $0d, $7a5f
	db $ff

GrCastle_NPCs:
	npc NPC_KANZAKI, 9, 9, WEST, NULL
	npc NPC_RUI, 5, 9, EAST, NULL
	db $ff

GrCastle_NPCInteractions:
	npc_script NPC_KANZAKI, $0d, $7809
	npc_script NPC_RUI, $0d, $792d
	db $ff

GrCastle_MapScripts:
	dbw $06, $765c
	dbw $08, $76ed
	dbw $09, $76f5
	dbw $07, $7663
	dbw $02, $766c
	db $ff
; gap from 0x3765c to 0x37700

SECTION "Bank d@7700", ROMX[$7700], BANK[$d]

GrCastle_AfterDuelScripts:
	npc_script NPC_KANZAKI, $0d, $78cf
	npc_script NPC_RUI, $0d, $7a21
	db $ff
