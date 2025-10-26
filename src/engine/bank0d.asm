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

Func_341f7:
	xor a
	start_script
	wait_for_fade
	script_command_64 $06
	set_var VAR_TIMES_MET_RONALD, $04
	set_var VAR_28, $01
	set_var VAR_2B, $00
	get_var VAR_21
	compare_loaded_var $00
	script_jump_if_b0nz .ows_3421c
	compare_loaded_var $02
	script_jump_if_b0nz .ows_34219
	set_var VAR_21, $03
	script_jump .ows_3421c
.ows_34219
	set_var VAR_21, $04
.ows_3421c
	load_npc NPC_RONALD, 4, 9, NORTH
	set_active_npc NPC_RONALD, DialogRonaldText
	move_active_npc NPCMovement_3425f
	wait_for_player_animation
	script_command_01
	print_npc_text Text1271
	script_command_02
	get_player_x_position
	compare_loaded_var $05
	script_jump_if_b0nz .ows_3423b
	move_player NPCMovement_34265, TRUE
	script_jump .ows_3423f
.ows_3423b
	move_player NPCMovement_34268, TRUE
.ows_3423f
	wait_for_player_animation
	script_command_01
	print_npc_text Text1272
	give_booster_packs BoosterList_ce35
	print_npc_text Text1273
	script_command_02
	move_active_npc NPCMovement_34262
	wait_for_player_animation
	unload_npc NPC_RONALD
	end_script
	ld a, $00
	ld [wd582], a
	ld a, [wNextMusic]
	farcall PlayAfterCurrentSong
	ret
NPCMovement_3425f:
	db NORTH, MOVE_5
	db $ff
NPCMovement_34262:
	db SOUTH, MOVE_5
	db $ff
NPCMovement_34265:
	db SOUTH, MOVE_2
	db $ff
NPCMovement_34268:
	db SOUTH, MOVE_1
	db WEST, MOVE_1
	db SOUTH, MOVE_1
	db $ff

Func_3426f:
	ld a, EVENT_MET_RONALD_GAME_CENTER
	farcall GetEventValue
	jr nz, .asm_342d5
	ld a, EVENT_MET_RONALD_GAME_CENTER
	farcall MaxOutEventValue
	ld a, EVENT_GOT_MACHAMP_COIN
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

Func_342ef:
	xor a
	start_script
	wait_for_fade
	script_command_64 $14
	set_var VAR_TIMES_MET_RONALD, $05
	load_npc NPC_GR_X, 4, 15, SOUTH
	set_active_npc NPC_GR_X, DialogGRXText
	move_active_npc NPCMovement_3431d
	wait_for_player_animation
	script_command_01
	print_npc_text Text1277
	script_command_02
	move_active_npc NPCMovement_3431d
	move_player NPCMovement_34320, TRUE
	wait_for_player_animation
	script_command_01
	print_npc_text Text1278
	script_command_02
	start_duel RONALDS_GRX_DECK_ID, MUSIC_MATCHSTART_2
	end_script
	ret
NPCMovement_3431d:
	db SOUTH, MOVE_2
	db $ff
NPCMovement_34320:
	db NORTH, MOVE_3
	db $ff

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

Func_34391:
	xor a
	start_script
	wait_for_fade
	set_var VAR_TIMES_MET_RONALD, $06
	load_npc NPC_GR_X, 4, 10, NORTH
	set_active_npc NPC_GR_X, DialogGRXText
	move_active_npc NPCMovement_343e2
	wait_for_player_animation
	check_event EVENT_GOT_MAGMAR_COIN
	set_variable_text_ram2 GRWaterFortShortText, GRFireFortShortText
	set_variable_text_ram2b GRFireFortShortText, GRWaterFortShortText
	script_command_01
	print_npc_text Text127f
	script_command_02
	get_player_x_position
	compare_loaded_var $05
	script_jump_if_b0nz .ows_343c4
	move_player NPCMovement_343e5, TRUE
	script_jump .ows_343c8
.ows_343c4
	move_player NPCMovement_343e8, TRUE
.ows_343c8
	wait_for_player_animation
	script_command_01
	print_npc_text Text1280
	script_command_02
	spin_active_npc 515
	replace_npc NPC_GR_X, NPC_RONALD
	set_active_npc NPC_RONALD, DialogRonaldText
	script_command_01
	print_npc_text Text1281
	script_command_02
	start_duel RONALDS_POWER_DECK_ID, MUSIC_MATCHSTART_2
	end_script
	ret
NPCMovement_343e2:
	db NORTH, MOVE_6
	db $ff
NPCMovement_343e5:
	db SOUTH, MOVE_2
	db $ff
NPCMovement_343e8:
	db SOUTH, MOVE_1
	db WEST, MOVE_1
	db SOUTH, MOVE_1
	db $ff

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

Func_3442d:
	ld a, NPC_GR_X
	ld [wScriptNPC], a
	ld hl, $a2e
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	wait_for_fade
	script_command_64 $19
	script_command_64 $1a
	set_var VAR_TIMES_MET_RONALD, $07
	script_command_01
	print_npc_text Text1285
	script_command_02
	move_player NPCMovement_34485, TRUE
	wait_for_player_animation
	script_command_01
	print_npc_text Text1286
	script_command_02
	spin_active_npc 515
	replace_npc NPC_GR_X, NPC_RONALD
	set_active_npc NPC_RONALD, DialogRonaldText
	script_command_01
	print_npc_text Text1287
	script_command_02
	spin_active_npc_reverse 515
	replace_npc NPC_RONALD, NPC_GR_X
	set_active_npc NPC_GR_X, DialogGRXText
	move_active_npc NPCMovement_34488
	wait_for_player_animation
	unload_npc NPC_GR_X
	end_script
	ld a, $00
	ld [wd582], a
	ld a, [wNextMusic]
	farcall PlayAfterCurrentSong
	ret
NPCMovement_34485:
	db NORTH, MOVE_3
	db $ff
NPCMovement_34488:
	db EAST, MOVE_1
	db SOUTH, MOVE_6
	db $ff

Func_3448d:
	xor a
	start_script
	script_command_64 $1b
	set_var VAR_TIMES_MET_RONALD, $08
	play_song_next MUSIC_RONALD
	do_frames 60
	load_npc NPC_RONALD, 5, 2, NORTH
	set_active_npc NPC_RONALD, DialogRonaldText
	animate_active_npc_movement $82, $01
	animate_active_npc_movement $82, $01
	animate_active_npc_movement $82, $01
	do_frames 30
	set_active_npc_direction SOUTH
	script_command_01
	print_npc_text Text1288
	script_command_02
.ows_344b5
	get_player_x_position
	compare_loaded_var $05
	script_jump_if_b0nz .ows_344ca
	script_jump_if_b1z .ows_344c4
	animate_player_movement $01, $01
	script_jump .ows_344b5
.ows_344c4
	animate_player_movement $03, $01
	script_jump .ows_344b5
.ows_344ca
	set_player_direction SOUTH
	do_frames 30
	set_active_npc_direction NORTH
	script_command_01
	print_npc_text Text1289
	script_command_02
	start_duel RONALDS_PSYCHIC_DECK_ID, MUSIC_MATCHSTART_2
	end_script
	ret

Func_344da:
	xor a
	start_script
	script_command_01
	check_event EVENT_SET_UNTIL_MAP_RELOAD_2
	script_jump_if_b0nz .ows_34500
	print_npc_text Text128a
	give_card SUPER_ENERGY_RETRIEVAL
	show_card_received_screen SUPER_ENERGY_RETRIEVAL
	print_npc_text Text128b
	script_command_02
	move_active_npc NPCMovement_3451a
	wait_for_player_animation
	set_active_npc_direction NORTH
	do_frames 60
	move_active_npc NPCMovement_3451a
	wait_for_player_animation
	script_jump .ows_34508
.ows_34500
	print_npc_text Text128c
	script_command_02
	move_active_npc NPCMovement_34518
	wait_for_player_animation
.ows_34508
	unload_npc NPC_RONALD
	end_script
	ld a, $00
	ld [wd582], a
	ld a, [wNextMusic]
	farcall PlayAfterCurrentSong
	ret
NPCMovement_34518:
	db SOUTH, MOVE_2
NPCMovement_3451a:
	db SOUTH, MOVE_2
	db $ff

Func_3451d:
	xor a
	start_script
	wait_for_fade
	load_npc NPC_RONALD, 4, 9, NORTH
	set_active_npc NPC_RONALD, DialogRonaldText
	move_active_npc NPCMovement_34565
	wait_for_player_animation
	script_command_01
	print_npc_text Text128d
	script_command_02
	get_player_x_position
	compare_loaded_var $05
	script_jump_if_b0nz .ows_34541
	move_player NPCMovement_3456b, TRUE
	script_jump .ows_34545
.ows_34541
	move_player NPCMovement_3456e, TRUE
.ows_34545
	wait_for_player_animation
	script_command_01
	print_npc_text Text128e
	give_booster_packs BoosterList_ce32
	print_npc_text Text128f
	script_command_02
	move_active_npc NPCMovement_34568
	wait_for_player_animation
	unload_npc NPC_RONALD
	end_script
	ld a, $00
	ld [wd582], a
	ld a, [wNextMusic]
	farcall PlayAfterCurrentSong
	ret
NPCMovement_34565:
	db NORTH, MOVE_5
	db $ff
NPCMovement_34568:
	db SOUTH, MOVE_5
	db $ff
NPCMovement_3456b:
	db SOUTH, MOVE_2
	db $ff
NPCMovement_3456e:
	db SOUTH, MOVE_1
	db WEST, MOVE_1
	db SOUTH, MOVE_1
	db $ff

TcgAirportEntrance_MapHeader:
	db MAP_GFX_TCG_AIRPORT_ENTRANCE
	dba TcgAirportEntrance_MapScripts
	db MUSIC_OVERWORLD

TcgAirportEntrance_StepEvents:
	map_exit 5, 12, OVERWORLD_MAP_TCG, 5, 7, SOUTH
	map_exit 6, 12, OVERWORLD_MAP_TCG, 5, 7, SOUTH
	map_exit 11, 6, MAP_TCG_AIRPORT, 1, 9, EAST
	map_exit 11, 7, MAP_TCG_AIRPORT, 1, 10, EAST
	ow_script 9, 6, Func_3462d
	ow_script 9, 7, Func_3462d
	db $ff

TcgAirportEntrance_NPCs:
	npc NPC_GR_5, 10, 7, WEST, Func_346bc
	npc NPC_GR_CLERK_TCG_AIRPORT, 7, 3, SOUTH, $0
	npc NPC_TCG_AIRPORT_GR_SIS, 3, 2, NORTH, $0
	npc NPC_TCG_AIRPORT_MARTIAL_ARTIST, 1, 7, EAST, $0
	db $ff

TcgAirportEntrance_NPCInteractions:
	npc_script NPC_GR_5, Func_3468f
	npc_script NPC_TCG_AIRPORT_GR_SIS, Func_3471c
	npc_script NPC_TCG_AIRPORT_MARTIAL_ARTIST, Func_34742
	db $ff

TcgAirportEntrance_OWInteractions:
	ow_script 7, 5, Func_346f6
	db $ff

TcgAirportEntrance_MapScripts:
	dbw $00, Func_345f1
	dbw $06, Func_3460d
	dbw $08, Func_3461d
	dbw $07, Func_34614
	dbw $01, Func_345fd
	db $ff

Func_345f1:
	call DoFrame
	call Func_34635
	call Func_32d8
	scf
	ccf
	ret

Func_345fd:
	ld a, EVENT_GOT_GR_COIN
	farcall GetEventValue
	jr nz, .asm_3460a
	ld a, MUSIC_HERECOMESGR
	ld [wNextMusic], a
.asm_3460a
	scf
	ccf
	ret

Func_3460d:
	ld hl, TcgAirportEntrance_StepEvents
	call Func_324d
	ret

Func_34614:
	ld hl, TcgAirportEntrance_NPCs
	call Func_3205
	scf
	ccf
	ret

Func_3461d:
	ld hl, TcgAirportEntrance_NPCInteractions
	call Func_328c
	jr nc, .asm_3462b
	ld hl, TcgAirportEntrance_OWInteractions
	call Func_32bf
.asm_3462b
	scf
	ret

Func_3462d:
	call Func_34635
	farcall Func_c199
	ret

Func_34635:
	ld a, EVENT_SHORT_GR_ISLAND_FLYOVER_SEQUENCE
	farcall GetEventValue
	jr nz, .asm_3468e
	ldh a, [hKeysHeld]
	bit 4, a
	jr z, .asm_3468e
	ld a, [wPlayerOWObject]
	ld b, $01
	farcall SetOWObjectDirection
	farcall GetOWObjectTilePosition
	ld a, $09
	cp d
	jr nz, .asm_3468e
	ld a, $06
	cp e
	jr z, .asm_34675
	ld a, $07
	cp e
	jr nz, .asm_3468e
	ld a, $32
	farcall GetOWObjectTilePosition
	ld a, $07
	cp e
	jr z, .asm_3468e
	ld a, $32
	ld bc, $8201
	farcall Func_10e3c
	jr .asm_34689
.asm_34675
	ld a, $32
	farcall GetOWObjectTilePosition
	ld a, $06
	cp e
	jr z, .asm_3468e
	ld a, $32
	ld bc, $8001
	farcall Func_10e3c
.asm_34689
	ld a, $32
	call Func_336d
.asm_3468e
	ret

Func_3468f:
	ld a, NPC_GR_5
	ld [wScriptNPC], a
	ld hl, $a2c
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	check_event EVENT_GOT_GR_COIN
	script_jump_if_b0z Script_346c9
	check_event EVENT_TALKED_TO_GR5_TCG_AIRPORT
	script_jump_if_b0z .ows_346b6
	set_event EVENT_TALKED_TO_GR5_TCG_AIRPORT
	print_npc_text Text081f
	script_jump .ows_346b9
.ows_346b6
	print_npc_text Text0820
.ows_346b9
	script_command_02
	end_script
	ret

Func_346bc:
	ld a, EVENT_SHORT_GR_ISLAND_FLYOVER_SEQUENCE
	farcall GetEventValue
	jr z, .asm_346c6
	scf
	ret
.asm_346c6
	scf
	ccf
	ret

Script_346c9:
	print_npc_text Text0821
	script_command_02
	move_active_npc NPCMovement_346f0
	move_player NPCMovement_346f3, TRUE
	wait_for_player_animation
	end_script
	ld a, [wPlayerOWObject]
	farcall GetOWObjectTilePosition
	ld c, e
	ld a, VAR_3E
	farcall SetVarValue
	ld a, $1f
	ld de, $1f1f
	ld b, $01
	farcall Func_d3c4
	ret
NPCMovement_346f0:
	db EAST, MOVE_2
	db $ff
NPCMovement_346f3:
	db EAST, MOVE_3
	db $ff

Func_346f6:
	ld a, NPC_GR_CLERK_TCG_AIRPORT
	ld [wScriptNPC], a
	ld hl, $a5a
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	check_event EVENT_GOT_GR_COIN
	script_jump_if_b0z .ows_34716
	print_npc_text Text0822
	script_jump .ows_34719
.ows_34716
	print_npc_text Text0823
.ows_34719
	script_command_02
	end_script
	ret

Func_3471c:
	ld a, NPC_TCG_AIRPORT_GR_SIS
	ld [wScriptNPC], a
	ld hl, $a39
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	check_event EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE
	script_jump_if_b0z .ows_3473c
	print_npc_text Text0824
	script_jump .ows_3473f
.ows_3473c
	print_npc_text Text0825
.ows_3473f
	script_command_02
	end_script
	ret

Func_34742:
	ld a, NPC_TCG_AIRPORT_MARTIAL_ARTIST
	ld [wScriptNPC], a
	ld hl, $a55
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	check_event EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE
	script_jump_if_b0z .ows_3476d
	check_event EVENT_GOT_GR_COIN
	script_jump_if_b0z .ows_34767
	print_npc_text Text0826
	script_jump .ows_34770
.ows_34767
	print_npc_text Text0827
	script_jump .ows_34770
.ows_3476d
	print_npc_text Text0828
.ows_34770
	script_command_02
	end_script
	ret

TcgAirport_MapHeader:
	db MAP_GFX_TCG_AIRPORT
	dba TcgAirport_MapScripts
	db MUSIC_OVERWORLD

TcgAirport_StepEvents:
	map_exit 0, 9, MAP_TCG_AIRPORT_ENTRANCE, 10, 6, WEST
	map_exit 0, 10, MAP_TCG_AIRPORT_ENTRANCE, 10, 7, WEST
	_ow_coordinate_function 11, 8, 0, 0, 0, 3, Func_349cd
	ow_script 10, 9, Func_349cd
	ow_script 9, 9, Func_349cd
	_ow_coordinate_function 8, 8, 0, 0, 0, 1, Func_349cd
	db $ff

TcgAirport_NPCs:
	npc NPC_GR_5, 10, 8, SOUTH, $0
	db $ff

TcgAirport_NPCInteractions:
	npc_script NPC_GR_5, Func_34910
	db $ff

TcgAirport_MapScripts:
	dbw $00, Func_347ce
	dbw $06, Func_347da
	dbw $08, Func_3489d
	dbw $07, Func_347e1
	dbw $02, Func_347ea
	dbw $0f, Func_34873
	db $ff

Func_347ce:
	call DoFrame
	call Func_349d5
	call Func_32d8
	scf
	ccf
	ret

Func_347da:
	ld hl, TcgAirport_StepEvents
	call Func_324d
	ret

Func_347e1:
	ld hl, TcgAirport_NPCs
	call Func_3205
	scf
	ccf
	ret

Func_347ea:
	farcall ClearwD986
	ld a, [wd584]
	cp $00
	jr z, .asm_3483d
	ld a, EVENT_SHORT_GR_ISLAND_FLYOVER_SEQUENCE
	farcall GetEventValue
	jr nz, .asm_34871
	ld a, $0a
	ld [wd582], a
	ld a, $0d
	ld [wd592], a
	ld hl, $48a5
	ld a, l
	ld [wd593], a
	ld a, h
	ld [$d594], a
	ld a, VAR_3E
	farcall GetVarValue
	add $03
	push af
	ld e, a
	ld a, $32
	ld d, $01
	farcall SetOWObjectTilePosition
	ld b, $01
	farcall SetOWObjectDirection
	pop af
	ld e, a
	ld a, [wPlayerOWObject]
	ld d, $00
	farcall SetOWObjectTilePosition
	ld b, $01
	farcall SetOWObjectDirection
	jr .asm_34871
.asm_3483d
	ld a, $0a
	ld [wd582], a
	ld a, $0d
	ld [wd592], a
	ld hl, $49a1
	ld a, l
	ld [wd593], a
	ld a, h
	ld [$d594], a
	ld a, $32
	ld de, $b05
	farcall SetOWObjectTilePosition
	ld b, $03
	farcall SetOWObjectDirection
	ld a, [wPlayerOWObject]
	ld de, $b05
	farcall SetOWObjectTilePosition
	ld b, $03
	farcall SetOWObjectDirection
.asm_34871
	scf
	ret

Func_34873:
	ld a, [wd585]
	cp $00
	jr z, .asm_3487c
	scf
	ret
.asm_3487c
	ld a, $0a
	ld c, $07
	farcall InitMusicFadeOut
	farcall MusicFadeOut.loop
	xor a
	call PlaySong
	ld a, $07
	call SetVolume
	ld a, SFX_89
	call PlaySFX
	farcall WaitForSFXToFinish.loop_wait
	scf
	ccf
	ret

Func_3489d:
	ld hl, TcgAirport_NPCInteractions
	call Func_328c
	scf
	ret

Func_348a5:
	ld a, NPC_GR_5
	ld [wScriptNPC], a
	ld hl, $a2c
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	wait_for_fade
	move_active_npc NPCMovement_348f0
	move_player NPCMovement_348ff, TRUE
	wait_for_player_animation
	do_frames 30
	script_command_01
	print_npc_text Text081a
	script_command_02
	get_player_y_position
	compare_loaded_var $09
	script_jump_if_b0nz .ows_348d9
	move_active_npc NPCMovement_348f5
	move_player NPCMovement_34902, TRUE
	script_jump .ows_348e0
.ows_348d9
	move_active_npc NPCMovement_348fa
	move_player NPCMovement_34909, TRUE
.ows_348e0
	wait_for_player_animation
	do_frames 60
	end_script
	ld a, $00
	ld de, $0
	ld b, $00
	farcall Func_d3c4
	ret
NPCMovement_348f0:
	db EAST, MOVE_9
	db NORTH, MOVE_0
	db $ff
NPCMovement_348f5:
	db NORTH, MOVE_5
	db EAST, MOVE_2
	db $ff
NPCMovement_348fa:
	db NORTH, MOVE_4
	db EAST, MOVE_2
	db $ff
NPCMovement_348ff:
	db EAST, MOVE_9
	db $ff
NPCMovement_34902:
	db EAST, MOVE_1
	db NORTH, MOVE_5
	db EAST, MOVE_1
	db $ff
NPCMovement_34909:
	db EAST, MOVE_1
	db NORTH, MOVE_4
	db EAST, MOVE_1
	db $ff

Func_34910:
	ld a, NPC_GR_5
	ld [wScriptNPC], a
	ld hl, $a2c
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	npc_ask_question Text081b, TRUE
	script_jump_if_b0nz .ows_34932
	print_npc_text Text081c
	script_command_02
	end_script
	ret
.ows_34932
	print_npc_text Text081d
	script_command_02
	get_player_direction
	compare_loaded_var $03
	script_jump_if_b0nz .ows_3494a
	compare_loaded_var $01
	script_jump_if_b0nz .ows_34968
	get_player_x_position
	compare_loaded_var $0a
	script_jump_if_b0nz .ows_34954
	script_jump .ows_3495e
.ows_3494a
	move_active_npc NPCMovement_3497f
	move_player NPCMovement_34989, TRUE
	script_jump .ows_3496f
.ows_34954
	move_active_npc NPCMovement_3497f
	move_player NPCMovement_34990, TRUE
	script_jump .ows_3496f
.ows_3495e
	move_active_npc NPCMovement_34984
	move_player NPCMovement_34995, TRUE
	script_jump .ows_3496f
.ows_34968
	move_active_npc NPCMovement_34984
	move_player NPCMovement_3499a, TRUE
.ows_3496f
	wait_for_player_animation
	do_frames 60
	end_script
	ld a, $00
	ld de, $0
	ld b, $00
	farcall Func_d3c4
	ret

NPCMovement_3497f:
	db NORTH, MOVE_3
	db EAST, MOVE_2
	db $ff

NPCMovement_34984:
	db NORTH, MOVE_3
	db EAST, MOVE_3
	db $ff

NPCMovement_34989:
	db WEST, MOVE_1
	db NORTH, MOVE_3
	db EAST, MOVE_1
	db $ff

NPCMovement_34990:
	db NORTH, MOVE_4
	db EAST, MOVE_1
	db $ff

NPCMovement_34995:
	db NORTH, MOVE_4
	db EAST, MOVE_2
	db $ff

NPCMovement_3499a:
	db EAST, MOVE_1
	db NORTH, MOVE_3
	db EAST, MOVE_2
	db $ff

Func_349a1:
	xor a
	start_script
	do_frames 60
	move_player NPCMovement_349c6, TRUE
	wait_for_player_animation
	move_npc NPC_GR_5, NPCMovement_349c1
	wait_for_player_animation
	set_active_npc NPC_GR_5, DialogGR5Text
	script_command_01
	print_npc_text Text081e
	script_command_02
	end_script
	ld a, $00
	ld [wd582], a
	ret
NPCMovement_349c1:
	db WEST, MOVE_1
	db SOUTH, MOVE_3
	db $ff
NPCMovement_349c6:
	db WEST, MOVE_1
	db SOUTH, MOVE_4
	db NORTH, MOVE_0
	db $ff

Func_349cd:
	call Func_349d5
	farcall Func_c199
	ret

Func_349d5:
	ld a, [wPlayerOWObject]
	farcall GetOWObjectTilePosition
	ld a, d
	cp $0b
	jr c, .asm_349e6
	jr nz, .asm_349e6
	ld a, e
	cp $08
.asm_349e6
	jr z, .asm_34a0e
	ld a, d
	cp $0a
	jr c, .asm_349f2
	jr nz, .asm_349f2
	ld a, e
	cp $09
.asm_349f2
	jr z, .asm_34a2a
	ld a, d
	cp $09
	jr c, .asm_349fe
	jr nz, .asm_349fe
	ld a, e
	cp $09
.asm_349fe
	jr z, .asm_34a46
	ld a, d
	cp $08
	jr c, .asm_34a0a
	jr nz, .asm_34a0a
	ld a, e
	cp $08
.asm_34a0a
	jr z, .asm_34a62
	jr .asm_34a7c
.asm_34a0e
	ldh a, [hKeysHeld]
	bit 5, a
	jr z, .asm_34a7c
	ld a, [wPlayerOWObject]
	ld b, $03
	farcall SetOWObjectDirection
	ld a, $32
	ld b, $01
	farcall SetOWObjectDirection
	call Func_34a96
	jr .asm_34a7c
.asm_34a2a
	ldh a, [hKeysHeld]
	bit 6, a
	jr z, .asm_34a7c
	ld a, [wPlayerOWObject]
	ld b, $00
	farcall SetOWObjectDirection
	ld a, $32
	ld b, $02
	farcall SetOWObjectDirection
	call Func_34a96
	jr .asm_34a7c
.asm_34a46
	ldh a, [hKeysHeld]
	bit 6, a
	jr z, .asm_34a7c
	ld a, [wPlayerOWObject]
	ld b, $00
	farcall SetOWObjectDirection
	ld a, $32
	ld b, $02
	farcall SetOWObjectDirection
	call Func_34a7d
	jr .asm_34a7c
.asm_34a62
	ldh a, [hKeysHeld]
	bit 4, a
	jr z, .asm_34a7c
	ld a, [wPlayerOWObject]
	ld b, $01
	farcall SetOWObjectDirection
	ld a, $32
	ld b, $03
	farcall SetOWObjectDirection
	call Func_34a7d
.asm_34a7c
	ret

Func_34a7d:
	ld a, $32
	farcall GetOWObjectTilePosition
	ld a, $09
	cp d
	ret z
	ld a, $32
	ld bc, $8301
	farcall Func_10e3c
	ld a, $32
	call Func_336d
	ret

Func_34a96:
	ld a, $32
	farcall GetOWObjectTilePosition
	ld a, $0a
	cp d
	ret z
	ld a, $32
	ld bc, $8101
	farcall Func_10e3c
	ld a, $32
	call Func_336d
	ret

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
	npc NPC_GR_CLERK_GR_AIRPORT, 4, 3, SOUTH, $0
	npc NPC_GR_AIRPORT_GR_PAPPY, 10, 3, WEST, $0
	npc NPC_GR_AIRPORT_GR_LASS, 5, 8, WEST, $0
	db $ff

GrAirportEntrance_NPCInteractions:
	npc_script NPC_GR_CLERK_6, Func_34b36
	npc_script NPC_GR_AIRPORT_GR_PAPPY, Func_34b51
	npc_script NPC_GR_AIRPORT_GR_LASS, Func_34b77
	db $ff

GrAirportEntrance_OWInteractions:
	ow_script 4, 5, Func_34b36
	ow_script 8, 2, Func_34b9d
	db $ff

GrAirportEntrance_MapScripts:
	dbw $06, Func_34b16
	dbw $08, Func_34b26
	dbw $07, Func_34b1d
	db $ff

Func_34b16:
	ld hl, GrAirportEntrance_StepEvents
	call Func_324d
	ret

Func_34b1d:
	ld hl, GrAirportEntrance_NPCs
	call Func_3205
	scf
	ccf
	ret

Func_34b26:
	ld hl, GrAirportEntrance_NPCInteractions
	call Func_328c
	jr nc, .asm_34b34
	ld hl, GrAirportEntrance_OWInteractions
	call Func_32bf
.asm_34b34
	scf
	ret

Func_34b36:
	ld a, NPC_GR_CLERK_6
	ld [wScriptNPC], a
	ld hl, $a5a
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	print_npc_text Text082e
	script_command_02
	end_script
	ret

Func_34b51:
	ld a, NPC_GR_AIRPORT_GR_PAPPY
	ld [wScriptNPC], a
	ld hl, $a43
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	check_event EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE
	script_jump_if_b0z .ows_34b71
	print_npc_text Text082f
	script_jump .ows_34b74
.ows_34b71
	print_npc_text Text0830
.ows_34b74
	script_command_02
	end_script
	ret

Func_34b77:
	ld a, NPC_GR_AIRPORT_GR_LASS
	ld [wScriptNPC], a
	ld hl, $a36
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	check_event EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE
	script_jump_if_b0z .ows_34b97
	print_npc_text Text0831
	script_jump .ows_34b9a
.ows_34b97
	print_npc_text Text0832
.ows_34b9a
	script_command_02
	end_script
	ret

Func_34b9d:
	xor a
	start_script
	script_command_01
	print_text BiruritchiStatueCaptionText
	script_command_02
	end_script
	ret

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
	npc NPC_ATTENDANT_BLACK_BOX, 7, 4, SOUTH, $0
	npc NPC_ATTENDANT_BILLS_PC, 1, 9, SOUTH, $0
	npc NPC_ATTENDANT_COIN_FLIP, 9, 10, WEST, $0
	npc NPC_GAME_CENTER_GR_GAL, 3, 5, EAST, $0
	npc NPC_GAME_CENTER_CHUBBY_KID, 8, 8, EAST, $0
	db $ff

GameCenter1_NPCInteractions:
	npc_script NPC_ATTENDANT_BLACK_BOX, Func_34d49
	npc_script NPC_ATTENDANT_BILLS_PC, Func_34d76
	npc_script NPC_ATTENDANT_COIN_FLIP, Func_34da3
	npc_script NPC_GAME_CENTER_GR_GAL, Func_34de6
	npc_script NPC_GAME_CENTER_CHUBBY_KID, Func_34e18
	db $ff

GameCenter1_OWInteractions:
	ow_script 5, 4, Func_34d15
	ow_script 6, 4, Func_34d15
	ow_script 2, 9, Func_34d35
	db $ff

GameCenter1_MapScripts:
	dbw $06, Func_34c2c
	dbw $08, Func_34c3c
	dbw $07, Func_34c33
	db $ff

Func_34c2c:
	ld hl, GameCenter1_StepEvents
	call Func_324d
	ret

Func_34c33:
	ld hl, GameCenter1_NPCs
	call Func_3205
	scf
	ccf
	ret

Func_34c3c:
	ld hl, GameCenter1_NPCInteractions
	call Func_32aa
	jr nc, .asm_34c4a
	ld hl, GameCenter1_OWInteractions
	call Func_32bf
.asm_34c4a
	scf
	ret

Script_34c4c:
	quit_script

Func_34c4d:
	farcall Func_1d7be
	cp $09
	jp z, .asm_34cef
	jp nc, .asm_34d03
	cp $07
	jr z, .asm_34cc7
	jr nc, .asm_34cdb
	cp $05
	jr z, .asm_34c9f
	jr nc, .asm_34cb3
	cp $03
	jr z, .asm_34c77
	jr nc, .asm_34c8b
	ld a, $01
	start_script
	script_command_01
	print_npc_text GameCenterCoinFlipAttendantNoPrizesTryAgainText
	script_jump .ows_34d12
.asm_34c77
	ld a, $01
	start_script
	script_command_01
	print_npc_text GameCenterCoinFlipAttendant3HeadsPrizeText
	game_center
	give_chips 20
	print_npc_text GameCenterCoinFlipAttendantTryAgainText
	script_command_71
	script_jump .ows_34d12
.asm_34c8b
	ld a, $01
	start_script
	script_command_01
	print_npc_text GameCenterCoinFlipAttendant4HeadsPrizeText
	game_center
	give_chips 40
	print_npc_text GameCenterCoinFlipAttendantTryAgainText
	script_command_71
	script_jump .ows_34d12
.asm_34c9f
	ld a, $01
	start_script
	script_command_01
	print_npc_text GameCenterCoinFlipAttendant5HeadsPrizeText
	game_center
	give_chips 100
	print_npc_text GameCenterCoinFlipAttendantTryAgainText
	script_command_71
	script_jump .ows_34d12
.asm_34cb3
	ld a, $01
	start_script
	script_command_01
	print_npc_text GameCenterCoinFlipAttendant6HeadsPrizeText
	game_center
	give_chips 200
	print_npc_text GameCenterCoinFlipAttendantTryAgainText
	script_command_71
	script_jump .ows_34d12
.asm_34cc7
	ld a, $01
	start_script
	script_command_01
	print_npc_text GameCenterCoinFlipAttendant7HeadsPrizeText
	game_center
	give_chips 500
	print_npc_text GameCenterCoinFlipAttendantTryAgainText
	script_command_71
	script_jump .ows_34d12
.asm_34cdb
	ld a, $01
	start_script
	script_command_01
	print_npc_text GameCenterCoinFlipAttendant8HeadsPrizeText
	game_center
	give_chips 1000
	print_npc_text GameCenterCoinFlipAttendantTryAgainText
	script_command_71
	script_jump .ows_34d12
.asm_34cef
	ld a, $01
	start_script
	script_command_01
	print_npc_text GameCenterCoinFlipAttendant9HeadsPrizeText
	game_center
	give_chips 3000
	print_npc_text GameCenterCoinFlipAttendantAlmostCompleteTryAgainText
	script_command_71
	script_jump .ows_34d12
.asm_34d03
	ld a, $01
	start_script
	script_command_01
	print_npc_text GameCenterCoinFlipAttendant10HeadsPrizeText
	receive_card MEW_LV8
	print_npc_text GameCenterCoinFlipAttendant10HeadsCongratsText
.ows_34d12
	script_command_02
	end_script
	ret

Func_34d15:
	xor a
	start_script
	script_command_01
	print_text TurnedOnBlackBoxText
	script_command_02
	end_script
	farcall Func_1312e
	jr c, .asm_34d2f
	farcall Func_4569f
	ld a, $81
	farcall Func_1f24e
.asm_34d2f
	ld a, $00
	ld [wd582], a
	ret

Func_34d35:
	xor a
	start_script
	script_command_01
	print_text TurnedOnBillsPCText
	script_command_02
	end_script
	farcall Func_1f8eb
	ld a, $00
	ld [wd582], a
	ret

Func_34d49:
	ld a, NPC_ATTENDANT_BLACK_BOX
	ld [wScriptNPC], a
	ld hl, $a58
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	get_player_opposite_direction
	restore_active_npc_direction
	print_npc_text GameCenterBlackBoxAttendantWelcomeText
	ask_question GameCenterBlackBoxAttendantGuidePromptText, TRUE
	script_jump_if_b0z .ows_34d70
	print_npc_text GameCenterBlackBoxAttendantGuideText
	script_jump .ows_34d73
.ows_34d70
	print_npc_text GameCenterBlackBoxAttendantNoGuideText
.ows_34d73
	script_command_02
	end_script
	ret

Func_34d76:
	ld a, NPC_ATTENDANT_BILLS_PC
	ld [wScriptNPC], a
	ld hl, $a58
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	get_player_opposite_direction
	restore_active_npc_direction
	print_npc_text GameCenterBillsPCAttendantWelcomeText
	ask_question GameCenterBillsPCAttendantGuidePromptText, TRUE
	script_jump_if_b0z .ows_34d9d
	print_npc_text GameCenterBillsPCAttendantGuideText
	script_jump .ows_34da0
.ows_34d9d
	print_npc_text GameCenterBillsPCAttendantNoGuideText
.ows_34da0
	script_command_02
	end_script
	ret

Func_34da3:
	ld a, NPC_ATTENDANT_COIN_FLIP
	ld [wScriptNPC], a
	ld hl, $a58
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	get_player_opposite_direction
	restore_active_npc_direction
	game_center
	print_npc_text GameCenterCoinFlipAttendantWelcomeText
	ask_question GameCenterCoinFlipStartPromptText, TRUE
	script_jump_if_b0z .ows_34ddf
	script_command_71
	get_game_center_chips
	compare_loaded_var_word $0000
	script_jump_if_b0nz .ows_34dd9
	game_center
	take_chips 1
	print_npc_text GameCenterCoinFlipAttendantStartText
	script_command_71
	script_command_02
	script_jump Script_34c4c
.ows_34dd9
	print_npc_text GameCenterCoinFlipAttendantNotEnoughChipsText
	script_jump .ows_34de3
.ows_34ddf
	print_npc_text GameCenterCoinFlipAttendantComeAgainText
	script_command_71
.ows_34de3
	script_command_02
	end_script
	ret

Func_34de6:
	ld a, NPC_GAME_CENTER_GR_GAL
	ld [wScriptNPC], a
	ld hl, $a42
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	print_npc_text Text0d59
	script_command_02
	get_active_npc_direction
	compare_loaded_var $01
	script_jump_if_b0nz .ows_34e0f
	compare_loaded_var $02
	script_jump_if_b0nz .ows_34e14
	set_active_npc_direction EAST
	script_jump .ows_34e16
.ows_34e0f
	set_active_npc_direction SOUTH
	script_jump .ows_34e16
.ows_34e14
	set_active_npc_direction NORTH
.ows_34e16
	end_script
	ret

Func_34e18:
	ld a, NPC_GAME_CENTER_CHUBBY_KID
	ld [wScriptNPC], a
	ld hl, $a53
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	get_player_opposite_direction
	restore_active_npc_direction
	check_event EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE
	script_jump_if_b0z .ows_34e47
	check_event EVENT_TALKED_TO_COIN_TOSS_BOY
	script_jump_if_b0z .ows_34e41
	set_event EVENT_TALKED_TO_COIN_TOSS_BOY
	print_npc_text Text0d5a
	script_jump .ows_34e4a
.ows_34e41
	print_npc_text Text0d5b
	script_jump .ows_34e4a
.ows_34e47
	print_npc_text Text0d5c
.ows_34e4a
	script_command_02
	end_script
	ret

GameCenter2_MapHeader:
	db MAP_GFX_GAME_CENTER_2
	dba GameCenter2_MapScripts
	db MUSIC_GAMECORNER

GameCenter2_StepEvents:
	map_exit 0, 6, MAP_GAME_CENTER_1, 10, 6, WEST
	map_exit 0, 7, MAP_GAME_CENTER_1, 10, 7, WEST
	db $ff

GameCenter2_NPCs:
	npc NPC_ATTENDANT_1COIN_SLOT, 1, 10, SOUTH, $0
	npc NPC_ATTENDANT_5COIN_SLOT, 10, 10, SOUTH, $0
	npc NPC_ATTENDANT_CARD_DUNGEON, 7, 3, SOUTH, $0
	npc NPC_GAME_CENTER_BOY, 2, 4, EAST, $0
	npc NPC_GAME_CENTER_FIXER, 4, 10, NORTH, $0
	npc NPC_GAME_CENTER_GR_WOMAN, 8, 10, NORTH, $0
	db $ff

GameCenter2_NPCInteractions:
	npc_script NPC_ATTENDANT_1COIN_SLOT, Func_34f25
	npc_script NPC_ATTENDANT_5COIN_SLOT, Func_34f50
	npc_script NPC_ATTENDANT_CARD_DUNGEON, Func_34f7b
	npc_script NPC_GAME_CENTER_BOY, Func_35016
	npc_script NPC_GAME_CENTER_FIXER, Func_35047
	npc_script NPC_GAME_CENTER_GR_WOMAN, Func_3506f
	db $ff

GameCenter2_OWInteractions:
	_ow_coordinate_function 2, 10, 1, 0, 0, 0, Func_1d96e
	_ow_coordinate_function 3, 10, 1, 0, 0, 0, Func_1d96e
	_ow_coordinate_function 4, 10, 1, 0, 0, 0, Func_1d96e
	_ow_coordinate_function 7, 10, 5, 0, 0, 0, Func_1d96e
	_ow_coordinate_function 8, 10, 5, 0, 0, 0, Func_1d96e
	_ow_coordinate_function 9, 10, 5, 0, 0, 0, Func_1d96e
	db $ff

GameCenter2_MapScripts:
	dbw $06, Func_34ee7
	dbw $08, Func_34ef7
	dbw $07, Func_34eee
	dbw $02, Func_34f07
	db $ff

Func_34ee7:
	ld hl, GameCenter2_StepEvents
	call Func_324d
	ret

Func_34eee:
	ld hl, GameCenter2_NPCs
	call Func_3205
	scf
	ccf
	ret

Func_34ef7:
	ld hl, GameCenter2_NPCInteractions
	call Func_328c
	jr nc, .asm_34f05
	ld hl, GameCenter2_OWInteractions
	call Func_32bf
.asm_34f05
	scf
	ret

Func_34f07:
	ld a, [wd584]
	cp $2d
	jr z, .asm_34f23
	ld a, $0a
	ld [wd582], a
	ld a, $0d
	ld [wd592], a
	ld hl, $4fde
	ld a, l
	ld [wd593], a
	ld a, h
	ld [$d594], a
.asm_34f23
	scf
	ret

Func_34f25:
	ld a, NPC_ATTENDANT_1COIN_SLOT
	ld [wScriptNPC], a
	ld hl, $a58
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	print_npc_text GameCenterSlotMachine1AttendantWelcomeText
	ask_question GameCenterSlotMachine1AttendantGuidePromptText, TRUE
	script_jump_if_b0z .ows_34f4a
	print_npc_text GameCenterSlotMachine1AttendantGuideText
	script_jump .ows_34f4d
.ows_34f4a
	print_npc_text GameCenterSlotMachine1AttendantNoGuideText
.ows_34f4d
	script_command_02
	end_script
	ret

Func_34f50:
	ld a, NPC_ATTENDANT_5COIN_SLOT
	ld [wScriptNPC], a
	ld hl, $a58
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	print_npc_text GameCenterSlotMachine5AttendantWelcomeText
	ask_question GameCenterSlotMachine5AttendantGuidePromptText, TRUE
	script_jump_if_b0z .ows_34f75
	print_npc_text GameCenterSlotMachine5AttendantGuideText
	script_jump .ows_34f78
.ows_34f75
	print_npc_text GameCenterSlotMachine5AttendantNoGuideText
.ows_34f78
	script_command_02
	end_script
	ret

Func_34f7b:
	ld a, NPC_ATTENDANT_CARD_DUNGEON
	ld [wScriptNPC], a
	ld hl, $a58
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	game_center
	print_npc_text GameCenterCardDungeonAttendantWelcomeText
	ask_question GameCenterCardDungeonStartPromptText, TRUE
	script_jump_if_b0z .ows_34fd7
	get_game_center_chips
	compare_loaded_var_word $000a
	script_jump_if_b1z .ows_34fb3
	quit_script
	xor a
	farcall Func_1f84c
	ld a, $01
	start_script
	print_npc_text GameCenterCardDungeonAttendantNotEnoughChipsText
	script_jump .ows_34fda
.ows_34fb3
	set_var VAR_3A, $00
	print_npc_text GameCenterCardDungeonAttendantReadDescriptionText
	quit_script
	ld a, $01
	farcall Func_1f84c
	ld a, $01
	start_script
	print_npc_text GameCenterCardDungeonAttendantEnterText
	script_command_71
	script_command_02
	end_script
	ld a, $2f
	ld de, $508
	ld b, $00
	farcall Func_d3c4
	ret
.ows_34fd7
	print_npc_text GameCenterCardDungeonAttendantComeAgainText
.ows_34fda
	script_command_71
	script_command_02
	end_script
	ret

Func_34fde:
	ld a, NPC_ATTENDANT_CARD_DUNGEON
	ld [wScriptNPC], a
	ld hl, $a58
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	set_active_npc_direction WEST
	get_var VAR_3A
	compare_loaded_var $06
	script_jump_if_b0nz .ows_35005
	script_jump_if_b1z .ows_3500b
	print_npc_text GameCenterCardDungeonAttendantPlayerWonComeAgainText
	script_jump .ows_3500e
.ows_35005
	print_npc_text GameCenterCardDungeonAttendantPlayerLostTryAgainText
	script_jump .ows_3500e
.ows_3500b
	print_npc_text GameCenterCardDungeonAttendantPlayerQuitTryAgainText
.ows_3500e
	script_command_02
	end_script
	ld a, $00
	ld [wd582], a
	ret

Func_35016:
	ld a, NPC_GAME_CENTER_BOY
	ld [wScriptNPC], a
	ld hl, $a31
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	check_event EVENT_GOT_MACHAMP_COIN
	script_jump_if_b0z .ows_35041
	check_event EVENT_GOT_MAGNEMITE_COIN
	script_jump_if_b0z .ows_3503b
	print_npc_text Text0d6e
	script_jump .ows_35044
.ows_3503b
	print_npc_text Text0d6f
	script_jump .ows_35044
.ows_35041
	print_npc_text Text0d70
.ows_35044
	script_command_02
	end_script
	ret

Func_35047:
	ld a, NPC_GAME_CENTER_FIXER
	ld [wScriptNPC], a
	ld hl, $a34
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	check_event EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE
	script_jump_if_b0z .ows_35067
	print_npc_text Text0d71
	script_jump .ows_3506a
.ows_35067
	print_npc_text Text0d72
.ows_3506a
	set_active_npc_direction NORTH
	script_command_02
	end_script
	ret

Func_3506f:
	ld a, NPC_GAME_CENTER_GR_WOMAN
	ld [wScriptNPC], a
	ld hl, $a44
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	check_event EVENT_TALKED_TO_SLOT_MACHINE_WOMAN
	script_jump_if_b0z .ows_35091
	set_event EVENT_TALKED_TO_SLOT_MACHINE_WOMAN
	print_npc_text Text0d73
	script_jump .ows_3509a
.ows_35091
	get_random $02
	compare_loaded_var $00
	print_variable_npc_text Text0d74, Text0d75
.ows_3509a
	set_active_npc_direction NORTH
	script_command_02
	end_script
	ret

CardDungeonBishop_MapHeader:
	db MAP_GFX_CARD_DUNGEON_BISHOP
	dba CardDungeonBishop_MapScripts
	db MUSIC_FORT_3

CardDungeonBishop_StepEvents:
	map_exit 4, 0, MAP_CARD_DUNGEON_ROOK, 4, 8, NORTH
	map_exit 5, 0, MAP_CARD_DUNGEON_ROOK, 5, 8, NORTH
	db $ff

CardDungeonBishop_NPCs:
	npc NPC_BISHOP, 5, 3, SOUTH, $0
	db $ff

CardDungeonBishop_NPCInteractions:
	npc_script NPC_BISHOP, Func_3512c
	db $ff

CardDungeonBishop_OWInteractions:
	ow_script 4, 1, Func_35273
	ow_script 5, 1, Func_35273
	db $ff

CardDungeonBishop_MapScripts:
	dbw $06, Func_350e6
	dbw $08, Func_350f6
	dbw $09, Func_35127
	dbw $07, Func_350ed
	dbw $02, Func_35106
	db $ff

Func_350e6:
	ld hl, CardDungeonBishop_StepEvents
	call Func_324d
	ret

Func_350ed:
	ld hl, CardDungeonBishop_NPCs
	call Func_3205
	scf
	ccf
	ret

Func_350f6:
	ld hl, CardDungeonBishop_NPCInteractions
	call Func_328c
	jr nc, .asm_35104
	ld hl, CardDungeonBishop_OWInteractions
	call Func_32bf
.asm_35104
	scf
	ret

Func_35106:
	ld bc, $49
	ld de, $400
	farcall Func_12c0ce
	ld a, $0a
	ld [wd582], a
	ld a, $0d
	ld [wd592], a
	ld hl, $525b
	ld a, l
	ld [wd593], a
	ld a, h
	ld [$d594], a
	scf
	ret

Func_35127:
	call Func_351dd
	scf
	ret

Func_3512c:
	ld a, NPC_BISHOP
	ld [wScriptNPC], a
	ld hl, $9fe
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	get_var VAR_3A
	compare_loaded_var $02
	script_jump_if_b0z Script_351d7
	game_center
	check_event EVENT_TALKED_TO_BISHOP
	script_jump_if_b0z .ows_35156
	set_event EVENT_TALKED_TO_BISHOP
	print_npc_text BishopWantsToDuelInitialText
	script_jump .ows_35159
.ows_35156
	print_npc_text BishopWantsToDuelRepeatText
.ows_35159
	ask_question BishopDuelPromptText, TRUE
	script_jump_if_b0z .ows_351bb
.ows_35160
	print_text GameCenterCardDungeonBetPromptText
	quit_script
	ld a, $07
	ld b, $00
	farcall Func_121e1
	jr c, .asm_3517c
	cp $01
	jr z, .asm_35178
	jr nc, .asm_3517c
	ld a, $0a
	jr .asm_35184
.asm_35178
	ld a, $1e
	jr .asm_35184
.asm_3517c
	ld a, $01
	start_script
	script_jump .ows_351bb
.asm_35184
	ld h, $00
	ld l, a
	ld [$d615], a
	call LoadTxRam3
	farcall GetGameCenterChips
	ld a, b
	cp h
	jr c, .asm_35199
	jr nz, .asm_35199
	ld a, c
	cp l
.asm_35199
	jr nc, .asm_351a6
	ld a, $01
	start_script
	print_npc_text BishopNotEnoughChipsText
	script_jump .ows_35160
.asm_351a6
	ld c, l
	ld b, h
	farcall DecreaseChipsSmoothly
	ld a, $01
	start_script
	print_npc_text BishopDuelStartText
	script_command_71
	script_command_02
	start_duel TEXTURE_TUNER7_DECK_ID, MUSIC_MATCHSTART_1
	end_script
	ret
.ows_351bb
	print_npc_text BishopDeclinedDuelText
	ask_question BishopQuitDuelPromptText, TRUE
	script_jump_if_b0nz .ows_351cb
	print_npc_text BishopResumeDuelText
	script_jump .ows_35159
.ows_351cb
	set_var VAR_3A, $07
	print_npc_text BishopPlayerQuitText
	script_command_71
	script_command_02
	end_script

Func_351d4:
	jp Func_3524f

Script_351d7:
	print_npc_text BishopProceedRepeatText
	script_command_02
	end_script
	ret

Func_351dd:
	xor a
	start_script
	script_command_01
	check_event EVENT_SET_UNTIL_MAP_RELOAD_2
	script_jump_if_b0nz .ows_35210
	print_npc_text BishopPlayerWon1Text
	game_center
	quit_script
	ld a, [$d615]
	sla a
	ld h, $00
	ld l, a
	call LoadTxRam3
	ld c, l
	ld b, h
	ld hl, $afc
	farcall PrintScrollableText_NoTextBoxLabelVRAM0
	farcall IncreaseChipsSmoothly
	ld a, $01
	start_script
	print_npc_text BishopPlayerWon2Text
	script_command_71
	script_jump .ows_3521b
.ows_35210
	set_var VAR_3A, $06
	print_npc_text BishopPlayerLostText
	script_command_02
	end_script
	jp Func_3524f
.ows_3521b
	ask_question BishopProceedWithCardDungeonPromptText, TRUE
	script_jump_if_b0z .ows_35237
	set_var VAR_3A, $03
	print_npc_text BishopProceedInitial1Text
	set_active_npc_direction NORTH
	play_sfx SFX_0F
	load_tilemap TILEMAP_04A, $04, $00
	print_npc_text BishopProceedInitial2Text
	script_jump .ows_3524c
.ows_35237
	print_npc_text BishopDeclinedProceedingText
	ask_question BishopWithdrawFromCardDungeonPromptText, TRUE
	script_jump_if_b0z .ows_3521b
	set_var VAR_3A, $07
	print_npc_text BishopPlayerWithdrewText
	script_command_02
	end_script
	jp Func_3524f
.ows_3524c
	script_command_02
	end_script
	ret

Func_3524f:
	ld a, $2e
	ld de, $603
	ld b, $02
	farcall Func_d3c4
	ret

Func_3525b:
	xor a
	start_script
	animate_player_movement $00, $01
	animate_player_movement $00, $01
	play_sfx SFX_0F
	load_tilemap TILEMAP_049, $04, $07
	end_script
	ld a, $00
	ld [wd582], a
	ret

Func_35273:
	ld a, VAR_3A
	farcall GetVarValue
	cp $02
	jr nz, .asm_35287
	xor a
	start_script
	script_command_01
	print_text DoorsAreShutText
	script_command_02
	end_script
.asm_35287
	ret

GrChallengeHallLobby_MapHeader:
	db MAP_GFX_GR_CHALLENGE_HALL_LOBBY
	dba GrChallengeHallLobby_MapScripts
	db MUSIC_GROVERWORLD

GrChallengeHallLobby_StepEvents:
	map_exit 13, 6, MAP_GR_CHALLENGE_HALL_ENTRANCE, 1, 3, EAST
	map_exit 13, 7, MAP_GR_CHALLENGE_HALL_ENTRANCE, 1, 4, EAST
	db $ff

GrChallengeHallLobby_NPCs:
	npc NPC_GR_CHALLENGE_HALL_GR_GRANNY, 3, 5, WEST, $0
	npc NPC_CUP_HOST, 2, 10, NORTH, Func_353ce
	npc NPC_GR_CHALLENGE_HALL_GR_CHAP, 8, 9, EAST, Func_35444
	npc NPC_GR_CHALLENGE_HALL_GR_WOMAN, 12, 8, WEST, $0
	npc NPC_GR_CLERK_BATTLE_CENTER, 5, 2, SOUTH, $0
	npc NPC_GR_CLERK_GIFT_CENTER, 8, 2, SOUTH, $0
	db $ff

GrChallengeHallLobby_NPCInteractions:
	npc_script NPC_GR_CHALLENGE_HALL_GR_GRANNY, Func_35342
	npc_script NPC_CUP_HOST, Func_353a8
	npc_script NPC_GR_CHALLENGE_HALL_GR_WOMAN, Func_35451
	npc_script NPC_GR_CHALLENGE_HALL_GR_CHAP, Func_353e5
	db $ff

GrChallengeHallLobby_OWInteractions:
	ow_script 1, 2, PCMenu
	ow_script 2, 2, PCMenu
	ow_script 5, 4, Func_3c1d0
	ow_script 8, 4, Func_3c2d9
	db $ff

GrChallengeHallLobby_MapScripts:
	dbw $06, Func_35322
	dbw $08, Func_35332
	dbw $07, Func_35329
	dbw $01, Func_35308
	db $ff

Func_35308:
	ld a, VAR_30
	farcall GetVarValue
	cp $01
	jr z, .asm_3531a
	cp $03
	jr z, .asm_3531a
	cp $06
	jr nz, .asm_3531f
.asm_3531a
	ld a, MUSIC_GRCHALLENGECUP
	ld [wNextMusic], a
.asm_3531f
	scf
	ccf
	ret

Func_35322:
	ld hl, GrChallengeHallLobby_StepEvents
	call Func_324d
	ret

Func_35329:
	ld hl, GrChallengeHallLobby_NPCs
	call Func_3205
	scf
	ccf
	ret

Func_35332:
	ld hl, GrChallengeHallLobby_NPCInteractions
	call Func_328c
	jr nc, .asm_35340
	ld hl, GrChallengeHallLobby_OWInteractions
	call Func_32bf
.asm_35340
	scf
	ret

Func_35342:
	ld a, NPC_GR_CHALLENGE_HALL_GR_GRANNY
	ld [wScriptNPC], a
	ld hl, $a46
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	check_event EVENT_TRADED_CARDS_GR_CHALLENGE_HALL
	script_jump_if_b0z .ows_353a2
	check_event EVENT_TALKED_TO_TRADE_NPC_GR_CHALLENGE_HALL
	script_jump_if_b0z .ows_35369
	set_event EVENT_TALKED_TO_TRADE_NPC_GR_CHALLENGE_HALL
	print_npc_text Text0e32
	script_jump .ows_3536c
.ows_35369
	print_npc_text Text0e33
.ows_3536c
	ask_question TradeCardsPromptText, TRUE
	script_jump_if_b0nz .ows_35379
	print_npc_text Text0e34
	script_jump .ows_353a5
.ows_35379
	get_card_count_in_collection_and_decks CHANSEY_LV55
	script_jump_if_b0z .ows_35385
	print_npc_text Text0e35
	script_jump .ows_353a5
.ows_35385
	get_card_count_in_collection CHANSEY_LV55
	script_jump_if_b0z .ows_35391
	print_npc_text Text0e36
	script_jump .ows_353a5
.ows_35391
	print_npc_text Text0e37
	receive_card BILLS_COMPUTER
	take_card CHANSEY_LV55
	set_event EVENT_TRADED_CARDS_GR_CHALLENGE_HALL
	print_npc_text Text0e38
	script_jump .ows_353a5
.ows_353a2
	print_npc_text Text0e39
.ows_353a5
	script_command_02
	end_script
	ret

Func_353a8:
	ld a, NPC_CUP_HOST
	ld [wScriptNPC], a
	ld hl, $a5b
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	check_event EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE
	script_jump_if_b0z .ows_353c8
	print_npc_text Text0e3a
	script_jump .ows_353cb
.ows_353c8
	print_npc_text Text0e3b
.ows_353cb
	script_command_02
	end_script
	ret

Func_353ce:
	ld a, VAR_30
	farcall GetVarValue
	cp $01
	jr z, .asm_353e3
	cp $03
	jr z, .asm_353e3
	cp $06
	jr z, .asm_353e3
	scf
	ccf
	ret
.asm_353e3
	scf
	ret

Func_353e5:
	ld a, NPC_GR_CHALLENGE_HALL_GR_CHAP
	ld [wScriptNPC], a
	ld hl, $a41
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	check_event EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE
	script_jump_if_b0z .ows_35423
	get_var VAR_30
	compare_loaded_var $03
	script_jump_if_b0nz .ows_35417
	script_jump_if_b1z .ows_3541d
	compare_loaded_var $01
	script_jump_if_b0nz .ows_35417
	script_jump_if_b1z .ows_3541d
	print_npc_text Text0e3c
	script_jump .ows_3543c
.ows_35417
	print_npc_text Text0e3d
	script_jump .ows_3543c
.ows_3541d
	print_npc_text Text0e3e
	script_jump .ows_3543c
.ows_35423
	set_event EVENT_94
	print_npc_text Text0e3f
	script_command_02
	get_player_direction
	compare_loaded_var $02
	script_jump_if_b0z .ows_35434
	set_player_direction WEST
	animate_player_movement $81, $02
.ows_35434
	move_active_npc NPCMovement_3543f
	wait_for_player_animation
	unload_npc NPC_GR_CHALLENGE_HALL_GR_CHAP
	end_script
	ret
.ows_3543c
	script_command_02
	end_script
	ret
NPCMovement_3543f:
	db NORTH, MOVE_2
	db EAST, MOVE_6
	db $ff

Func_35444:
	ld a, EVENT_94
	farcall GetEventValue
	jr nz, .asm_3544f
	scf
	ccf
	ret
.asm_3544f
	scf
	ret

Func_35451:
	ld a, NPC_GR_CHALLENGE_HALL_GR_WOMAN
	ld [wScriptNPC], a
	ld hl, $a44
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	get_var VAR_33
	compare_loaded_var $02
	script_jump_if_b0nz .ows_35490
	get_var VAR_30
	compare_loaded_var $05
	script_jump_if_b0nz .ows_35496
	script_jump_if_b1z .ows_3549c
	compare_loaded_var $03
	script_jump_if_b0nz .ows_3548a
	script_jump_if_b1z .ows_35484
	compare_loaded_var $01
	script_jump_if_b0nz .ows_3548a
.ows_35484
	print_npc_text Text0e40
	script_jump .ows_3549f
.ows_3548a
	print_npc_text Text0e41
	script_jump .ows_3549f
.ows_35490
	print_npc_text Text0e42
	script_jump .ows_3549f
.ows_35496
	print_npc_text Text0e43
	script_jump .ows_3549f
.ows_3549c
	print_npc_text Text0e44
.ows_3549f
	script_command_02
	end_script
	ret

GrassFortMorino_MapHeader:
	db MAP_GFX_GRASS_FORT_MORINO
	dba GrassFortMorino_MapScripts
	db MUSIC_FORT_1

GrassFortMorino_StepEvents:
	map_exit 6, 15, MAP_GRASS_FORT_MIYUKI, 5, 1, SOUTH
	map_exit 7, 15, MAP_GRASS_FORT_MIYUKI, 6, 1, SOUTH
	db $ff

GrassFortMorino_NPCs:
	npc NPC_MORINO, 7, 2, SOUTH, $0
	db $ff

GrassFortMorino_NPCInteractions:
	npc_script NPC_MORINO, Func_354fb
	db $ff

GrassFortMorino_MapScripts:
	dbw $06, Func_354d3
	dbw $08, Func_354e3
	dbw $09, Func_354eb
	dbw $07, Func_354da
	db $ff

Func_354d3:
	ld hl, GrassFortMorino_StepEvents
	call Func_324d
	ret

Func_354da:
	ld hl, GrassFortMorino_NPCs
	call Func_3205
	scf
	ccf
	ret

Func_354e3:
	ld hl, GrassFortMorino_NPCInteractions
	call Func_328c
	scf
	ret

Func_354eb:
	ld hl, GrassFortMorino_AfterDuelScripts
	ld a, [wScriptNPC]
	call Func_344c
	scf
	ret

GrassFortMorino_AfterDuelScripts:
	npc_script NPC_MORINO, Func_35596
	db $ff

Func_354fb:
	ld a, NPC_MORINO
	ld [wScriptNPC], a
	ld hl, $a0d
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	check_event EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE
	script_jump_if_b0z .ows_35570
	check_event EVENT_BEAT_MORINO
	script_jump_if_b0z .ows_35545
	check_event EVENT_TALKED_TO_MORINO
	script_jump_if_b0z .ows_3552c
	set_event EVENT_TALKED_TO_MORINO
	spin_active_npc 774
	do_frames 30
	print_npc_text Text0db6
	script_jump .ows_3552f
.ows_3552c
	print_npc_text Text0db7
.ows_3552f
	ask_question Text0db8, TRUE
	script_jump_if_b0z .ows_3553f
	print_npc_text Text0db9
	script_command_02
	start_duel MAD_PETALS_DECK_ID, MUSIC_DITTY_1
	end_script
	ret
.ows_3553f
	print_npc_text Text0dba
	script_command_02
	end_script
	ret
.ows_35545
	check_event EVENT_TALKED_TO_MORINO
	script_jump_if_b0z .ows_35557
	set_event EVENT_TALKED_TO_MORINO
	spin_active_npc 774
	do_frames 30
	print_npc_text Text0dbb
	script_jump .ows_3555a
.ows_35557
	print_npc_text Text0dbc
.ows_3555a
	ask_question Text0db8, TRUE
	script_jump_if_b0z .ows_3556a
	print_npc_text Text0dbd
	script_command_02
	start_duel MAD_PETALS_DECK_ID, MUSIC_DITTY_1
	end_script
	ret
.ows_3556a
	print_npc_text Text0dbe
	script_command_02
	end_script
	ret
.ows_35570
	check_event EVENT_TALKED_TO_MORINO
	script_jump_if_b0z .ows_3557d
	set_event EVENT_TALKED_TO_MORINO
	print_npc_text Text0dbf
	script_jump .ows_35593
.ows_3557d
	print_npc_text Text0dbc
	ask_question Text0db8, TRUE
	script_jump_if_b0z .ows_35590
	print_npc_text Text0dbd
	script_command_02
	start_duel MAD_PETALS_DECK_ID, MUSIC_DITTY_1
	end_script
	ret
.ows_35590
	print_npc_text Text0dbe
.ows_35593
	script_command_02
	end_script
	ret

Func_35596:
	xor a
	start_script
	script_command_01
	check_event EVENT_BEAT_MORINO
	script_jump_if_b0z .ows_355ba
	check_event EVENT_SET_UNTIL_MAP_RELOAD_2
	script_jump_if_b0nz .ows_355b4
	set_event EVENT_BEAT_MORINO
	reset_event EVENT_TALKED_TO_MORINO
	script_command_64 $0a
	print_npc_text Text0dc0
	give_booster_packs BoosterList_cd59
	script_jump .ows_355d1
.ows_355b4
	print_npc_text Text0dc1
	script_command_02
	end_script
	ret
.ows_355ba
	check_event EVENT_SET_UNTIL_MAP_RELOAD_2
	script_jump_if_b0nz .ows_355cb
	print_npc_text Text0dc2
	give_booster_packs BoosterList_cd59
	print_npc_text Text0dc3
	script_jump .ows_355ce
.ows_355cb
	print_npc_text Text0dc4
.ows_355ce
	script_command_02
	end_script
	ret
.ows_355d1
	set_event EVENT_GOT_GOLBAT_COIN
	print_npc_text Text0dc5
	give_coin COIN_GOLBAT
	print_npc_text Text0dc6
	script_command_02
	end_script
	ret

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
	npc NPC_SENTA, 6, 3, SOUTH, $0
	db $ff

WaterFortSenta_NPCInteractions:
	npc_script NPC_SENTA, Func_35679
	db $ff

WaterFortSenta_MapScripts:
	dbw $06, Func_35624
	dbw $08, Func_35661
	dbw $09, Func_35669
	dbw $07, Func_3562b
	dbw $02, Func_35634
	db $ff

Func_35624:
	ld hl, WaterFortSenta_StepEvents
	call Func_324d
	ret

Func_3562b:
	ld hl, WaterFortSenta_NPCs
	call Func_3205
	scf
	ccf
	ret

Func_35634:
	ld bc, $8a
	ld de, $500
	farcall Func_12c0ce
	ld a, EVENT_SENTAS_ROOM_BRIDGE_STATE
	farcall GetEventValue
	jr nz, .asm_3565f
	ld bc, $8b
	ld de, $c05
	farcall Func_12c0ce
	ld a, $44
	ld de, $b06
	farcall SetOWObjectTilePosition
	ld b, $01
	farcall SetOWObjectDirection
.asm_3565f
	scf
	ret

Func_35661:
	ld hl, WaterFortSenta_NPCInteractions
	call Func_328c
	scf
	ret

Func_35669:
	ld hl, WaterFortSenta_AfterDuelScripts
	ld a, [wScriptNPC]
	call Func_344c
	scf
	ret

WaterFortSenta_AfterDuelScripts:
	npc_script NPC_SENTA, Func_356e8
	db $ff

Func_35679:
	ld a, NPC_SENTA
	ld [wScriptNPC], a
	ld hl, $a17
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	check_event EVENT_SENTAS_ROOM_BRIDGE_STATE
	script_jump_if_b0z .ows_356c4
	check_event EVENT_TALKED_TO_SENTA
	script_jump_if_b0z .ows_356a0
	set_event EVENT_TALKED_TO_SENTA
	print_npc_text Text123c
	script_jump .ows_356a3
.ows_356a0
	print_npc_text Text123d
.ows_356a3
	ask_question Text123e, TRUE
	script_jump_if_b0z .ows_356be
	duel_requirement_check DUEL_REQUIREMENT_SENTA
	script_jump_if_b1z .ows_356b5
	print_npc_text Text123f
	script_jump .ows_356c1
.ows_356b5
	print_npc_text Text1240
	script_command_02
	start_duel PARALYZED_PARALYZED_DECK_ID, MUSIC_MATCHSTART_1
	end_script
	ret
.ows_356be
	print_npc_text Text1241
.ows_356c1
	script_command_02
	end_script
	ret
.ows_356c4
	print_npc_text Text1242
	ask_question Text123e, TRUE
	script_jump_if_b0z .ows_356e2
	duel_requirement_check DUEL_REQUIREMENT_SENTA
	script_jump_if_b1z .ows_356d9
	print_npc_text Text1243
	script_jump .ows_356e5
.ows_356d9
	print_npc_text Text1244
	script_command_02
	start_duel PARALYZED_PARALYZED_DECK_ID, MUSIC_MATCHSTART_1
	end_script
	ret
.ows_356e2
	print_npc_text Text1245
.ows_356e5
	script_command_02
	end_script
	ret

Func_356e8:
	xor a
	start_script
	script_command_01
	check_event EVENT_SENTAS_ROOM_BRIDGE_STATE
	script_jump_if_b0z .ows_3570b
	check_event EVENT_SET_UNTIL_MAP_RELOAD_2
	script_jump_if_b0nz .ows_35705
	set_event EVENT_SENTAS_ROOM_BRIDGE_STATE
	print_npc_text Text1246
	give_booster_packs BoosterList_cd7c
	print_npc_text Text1247
	script_jump .ows_35722
.ows_35705
	print_npc_text Text1248
	script_command_02
	end_script
	ret
.ows_3570b
	check_event EVENT_SET_UNTIL_MAP_RELOAD_2
	script_jump_if_b0nz .ows_3571c
	print_npc_text Text1249
	give_booster_packs BoosterList_cd7c
	print_npc_text Text124a
	script_jump .ows_3571f
.ows_3571c
	print_npc_text Text124b
.ows_3571f
	script_command_02
	end_script
	ret
.ows_35722
	set_event EVENT_FREED_JACK
	print_npc_text Text124c
	script_command_02
	set_scroll_state $02
	get_player_direction
	compare_loaded_var $01
	script_jump_if_b0z .ows_35735
	set_player_direction NORTH
	animate_player_movement $82, $02
.ows_35735
	move_active_npc NPCMovement_357a2
	scroll_to_position $03, $00
	wait_for_player_animation
	do_frames 30
	script_command_01
	print_npc_text Text124d
	script_command_02
	do_frames 30
	play_sfx SFX_0F
	load_tilemap TILEMAP_08C, $05, $00
	load_npc NPC_JACK, 6, 1, SOUTH
	set_active_npc NPC_JACK, DialogJackText
	move_active_npc NPCMovement_357aa
	wait_for_player_animation
	load_tilemap TILEMAP_08A, $05, $00
	set_active_npc_direction EAST
	set_npc_direction NPC_SENTA, EAST
	compare_loaded_var $01
	script_jump_if_b0nz .ows_3577b
	compare_loaded_var $02
	script_jump_if_b0nz .ows_35774
	move_player NPCMovement_357b0, TRUE
	script_jump .ows_3577f
.ows_35774
	move_player NPCMovement_357b5, TRUE
	script_jump .ows_3577f
.ows_3577b
	move_player NPCMovement_357ba, TRUE
.ows_3577f
	wait_for_player_animation
	scroll_to_player
	do_frames 30
	script_command_01
	print_npc_text Text124e
	receive_card MAGIKARP_LV10
	check_event EVENT_FREED_COURTNEY
	print_variable_npc_text Text124f, Text1250
	print_npc_text Text1251
	script_command_02
	move_npc NPC_SENTA, NPCMovement_357a7
	move_active_npc NPCMovement_357ad
	wait_for_player_animation
	unload_npc NPC_JACK
	script_jump Script_357bf
NPCMovement_357a2:
	db WEST, MOVE_5
	db NORTH, MOVE_2
	db $ff
NPCMovement_357a7:
	db WEST | MOVE_BACKWARDS, MOVE_1
	db $ff
NPCMovement_357aa:
	db SOUTH, MOVE_2
	db $ff
NPCMovement_357ad:
	db SOUTH, MOVE_9
	db $ff
NPCMovement_357b0:
	db NORTH, MOVE_4
	db WEST, MOVE_4
	db $ff
NPCMovement_357b5:
	db NORTH, MOVE_2
	db WEST, MOVE_4
	db $ff
NPCMovement_357ba:
	db NORTH, MOVE_4
	db WEST, MOVE_3
	db $ff
Script_357bf:
	set_active_npc NPC_SENTA, DialogSentaText
	move_active_npc NPCMovement_357fe
	wait_for_player_animation
	set_player_direction SOUTH
	do_frames 30
	script_command_01
	print_npc_text Text1252
	script_command_02
	move_active_npc NPCMovement_35803
	scroll_to_position $04, $02
	wait_for_player_animation
	do_frames 30
	script_command_01
	print_npc_text Text1253
	script_command_02
	do_frames 30
	play_sfx SFX_0F
	load_tilemap TILEMAP_08D, $0c, $05
	do_frames 30
	move_active_npc NPCMovement_35808
	scroll_to_position $03, $00
	wait_for_player_animation
	scroll_to_player
	do_frames 30
	set_player_direction WEST
	script_command_01
	print_npc_text Text1254
	script_command_02
	set_active_npc_direction SOUTH
	end_script
	ret
NPCMovement_357fe:
	db EAST, MOVE_2
	db NORTH, MOVE_0
	db $ff
NPCMovement_35803:
	db SOUTH, MOVE_2
	db EAST, MOVE_4
	db $ff
NPCMovement_35808:
	db WEST, MOVE_5
	db NORTH, MOVE_3
	db EAST, MOVE_0
	db $ff

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
	npc NPC_AIRA, 4, 5, SOUTH, $0
	db $ff

WaterFortAira_NPCInteractions:
	npc_script NPC_AIRA, Func_3589a
	db $ff

WaterFortAira_MapScripts:
	dbw $06, Func_35855
	dbw $08, Func_35882
	dbw $09, Func_3588a
	dbw $07, Func_3585c
	dbw $02, Func_35865
	db $ff

Func_35855:
	ld hl, WaterFortAira_StepEvents
	call Func_324d
	ret

Func_3585c:
	ld hl, WaterFortAira_NPCs
	call Func_3205
	scf
	ccf
	ret

Func_35865:
	ld a, EVENT_AIRAS_ROOM_BRIDGE_STATE
	farcall GetEventValue
	jr nz, .asm_35880
	ld bc, $8f
	ld de, $400
	farcall Func_12c0ce
	ld a, $45
	ld de, $505
	farcall SetOWObjectTilePosition
.asm_35880
	scf
	ret

Func_35882:
	ld hl, WaterFortAira_NPCInteractions
	call Func_328c
	scf
	ret

Func_3588a:
	ld hl, WaterFortAira_AfterDuelScripts
	ld a, [wScriptNPC]
	call Func_344c
	scf
	ret

WaterFortAira_AfterDuelScripts:
	npc_script NPC_AIRA, Func_358f3
	db $ff

Func_3589a:
	ld a, NPC_AIRA
	ld [wScriptNPC], a
	ld hl, $a18
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	check_event EVENT_AIRAS_ROOM_BRIDGE_STATE
	script_jump_if_b0z .ows_358da
	check_event EVENT_TALKED_TO_AIRA
	script_jump_if_b0z .ows_358c1
	set_event EVENT_TALKED_TO_AIRA
	print_npc_text Text1202
	script_jump .ows_358c4
.ows_358c1
	print_npc_text Text1203
.ows_358c4
	ask_question Text1204, TRUE
	script_jump_if_b0z .ows_358d4
	print_npc_text Text1205
	script_command_02
	start_duel BENCH_CALL_DECK_ID, MUSIC_MATCHSTART_1
	end_script
	ret
.ows_358d4
	print_npc_text Text1206
	script_command_02
	end_script
	ret
.ows_358da
	print_npc_text Text1207
	ask_question Text1204, TRUE
	script_jump_if_b0z .ows_358ed
	print_npc_text Text1208
	script_command_02
	start_duel BENCH_CALL_DECK_ID, MUSIC_MATCHSTART_1
	end_script
	ret
.ows_358ed
	print_npc_text Text1209
	script_command_02
	end_script
	ret

Func_358f3:
	xor a
	start_script
	script_command_01
	check_event EVENT_AIRAS_ROOM_BRIDGE_STATE
	script_jump_if_b0z .ows_35916
	check_event EVENT_SET_UNTIL_MAP_RELOAD_2
	script_jump_if_b0nz .ows_35910
	set_event EVENT_AIRAS_ROOM_BRIDGE_STATE
	print_npc_text Text120a
	give_booster_packs BoosterList_cd7f
	print_npc_text Text120b
	script_jump .ows_3592d
.ows_35910
	print_npc_text Text120c
	script_command_02
	end_script
	ret
.ows_35916
	check_event EVENT_SET_UNTIL_MAP_RELOAD_2
	script_jump_if_b0nz .ows_35927
	print_npc_text Text120d
	give_booster_packs BoosterList_cd7f
	print_npc_text Text120e
	script_jump .ows_3592a
.ows_35927
	print_npc_text Text120c
.ows_3592a
	script_command_02
	end_script
	ret
.ows_3592d
	print_npc_text Text120f
	script_command_02
	move_active_npc NPCMovement_3597d
	scroll_to_position $ff, $00
	wait_for_player_animation
	do_frames 30
	script_command_01
	print_npc_text Text1210
	script_command_02
	play_sfx SFX_0F
	load_tilemap TILEMAP_090, $04, $00
	do_frames 30
	get_player_x_position
	compare_loaded_var $04
	script_jump_if_b0z .ows_3595a
	move_active_npc NPCMovement_35984
	scroll_to_position $ff, $01
	wait_for_player_animation
	set_active_npc_direction WEST
	script_jump .ows_35961
.ows_3595a
	move_active_npc NPCMovement_35984
	scroll_to_position $ff, $02
	wait_for_player_animation
.ows_35961
	scroll_to_player
	do_frames 30
	script_command_01
	print_npc_text Text1211
	script_command_02
	get_player_direction
	compare_loaded_var $01
	script_jump_if_b0z .ows_35976
	set_player_direction NORTH
	animate_player_movement $82, $02
	set_player_direction NORTH
.ows_35976
	animate_active_npc_movement $03, $01
	set_active_npc_direction SOUTH
	end_script
	ret
NPCMovement_3597d:
	db NORTH, MOVE_4
	db WEST, MOVE_1
	db NORTH, MOVE_0
	db $ff
NPCMovement_35984:
	db EAST, MOVE_1
	db SOUTH, MOVE_4
	db $ff

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
	npc NPC_KAMIYA, 6, 2, SOUTH, $0
	db $ff

FightingFort_NPCInteractions:
	npc_script NPC_KAMIYA, Func_35b16
	db $ff

FightingFort_OWInteractions:
	ow_script 7, 1, Func_35be4
	ow_script 8, 1, Func_35be4
	db $ff

FightingFort_MapScripts:
	dbw $06, Func_359fd
	dbw $08, Func_35a7c
	dbw $09, Func_35a8c
	dbw $07, Func_35a04
	dbw $02, Func_35a0d
	db $ff

Func_359fd:
	ld hl, FightingFort_StepEvents
	call Func_324d
	ret

Func_35a04:
	ld hl, FightingFort_NPCs
	call Func_3205
	scf
	ccf
	ret

Func_35a0d:
	ld a, [wd584]
	cp $50
	jr nz, .asm_35a18
	farcall Func_1f293
.asm_35a18
	ld a, EVENT_BEAT_KAMIYA
	farcall GetEventValue
	jr z, .asm_35a2e
	ld a, EVENT_CAN_TRAVEL_PAST_FIGHTING_FORT
	farcall GetEventValue
	jr z, .asm_35a37
	farcall Func_30056
	scf
	ret
.asm_35a2e
	ld a, $49
	ld de, CopyDataHLtoDE_SaveRegisters
	farcall SetOWObjectTilePosition
.asm_35a37
	ld bc, $96
	ld de, $700
	farcall Func_12c0ce
	ld a, EVENT_MET_FIGHTING_FORT_MEMBERS
	farcall GetEventValue
	jr nz, .asm_35a7a
	ld a, EVENT_MET_FIGHTING_FORT_MEMBERS
	farcall MaxOutEventValue
	ld a, $0a
	ld [wd582], a
	ld a, $0d
	ld [wd592], a
	ld hl, $5a9c
	ld a, l
	ld [wd593], a
	ld a, h
	ld [$d594], a
	ld a, $47
	ld de, $502
	ld b, $02
	farcall LoadOWObjectInMap
	ld a, $48
	ld de, $a02
	ld b, $02
	farcall LoadOWObjectInMap
.asm_35a7a
	scf
	ret

Func_35a7c:
	ld hl, FightingFort_NPCInteractions
	call Func_328c
	jr nc, .asm_35a8a
	ld hl, FightingFort_OWInteractions
	call Func_32bf
.asm_35a8a
	scf
	ret

Func_35a8c:
	ld hl, FightingFort_AfterDuelScripts
	ld a, [wScriptNPC]
	call Func_344c
	scf
	ret

FightingFort_AfterDuelScripts:
	npc_script NPC_KAMIYA, Func_35b82
	db $ff

Func_35a9c:
	xor a
	start_script
	set_event EVENT_MET_FIGHTING_FORT_MEMBERS
	move_player NPCMovement_35b09, TRUE
	wait_for_player_animation
	set_active_npc NPC_KAMIYA, DialogKamiyaText
	script_command_01
	print_npc_text Text0c11
	script_command_02
	do_frames 30
	set_active_npc_direction WEST
	do_frames 30
	set_active_npc NPC_GODA, DialogGodaText
	script_command_01
	print_npc_text Text0c12
	script_command_02
	animate_active_npc_movement $02, $01
	do_frames 30
	set_active_npc NPC_KAMIYA, DialogKamiyaText
	script_command_01
	print_npc_text Text0c13
	script_command_02
	do_frames 30
	set_active_npc_direction EAST
	do_frames 30
	script_command_01
	set_active_npc NPC_GRACE, DialogGraceText
	print_npc_text Text0c14
	script_command_02
	animate_active_npc_movement $02, $01
	do_frames 30
	set_active_npc NPC_KAMIYA, DialogKamiyaText
	script_command_01
	set_active_npc_direction SOUTH
	print_npc_text Text0c15
	script_command_02
	do_frames 30
	move_npc NPC_GODA, NPCMovement_35b0c
	move_npc NPC_GRACE, NPCMovement_35b11
	wait_for_player_animation
	unload_npc NPC_GODA
	unload_npc NPC_GRACE
	do_frames 30
	script_command_01
	print_npc_text Text0c16
	script_command_02
	end_script
	ld a, $00
	ld [wd582], a
	ret
NPCMovement_35b09:
	db NORTH, MOVE_2
	db $ff
NPCMovement_35b0c:
	db WEST, MOVE_2
	db NORTH, MOVE_2
	db $ff
NPCMovement_35b11:
	db EAST, MOVE_2
	db NORTH, MOVE_2
	db $ff

Func_35b16:
	ld a, NPC_KAMIYA
	ld [wScriptNPC], a
	ld hl, $a1a
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	check_event EVENT_BEAT_KAMIYA
	script_jump_if_b0z .ows_35b69
	check_event EVENT_FREED_MITCH
	script_jump_if_b0nz .ows_35b3d
	check_event EVENT_GRACES_ROOM_CHEST_STATE
	script_jump_if_b0nz .ows_35b3d
	script_jump .ows_35b43
.ows_35b3d
	print_npc_text Text0c17
	script_command_02
	end_script
	ret
.ows_35b43
	check_event EVENT_TALKED_TO_KAMIYA
	script_jump_if_b0z .ows_35b50
	set_event EVENT_TALKED_TO_KAMIYA
	print_npc_text Text0c18
	script_jump .ows_35b53
.ows_35b50
	print_npc_text Text0c19
.ows_35b53
	ask_question Text0c1a, TRUE
	script_jump_if_b0z .ows_35b63
	print_npc_text Text0c1b
	script_command_02
	start_duel RUNNING_WILD_DECK_ID, MUSIC_DITTY_1
	end_script
	ret
.ows_35b63
	print_npc_text Text0c1c
	script_command_02
	end_script
	ret
.ows_35b69
	print_npc_text Text0c1d
	ask_question Text0c1a, TRUE
	script_jump_if_b0z .ows_35b7c
	print_npc_text Text0c1e
	script_command_02
	start_duel RUNNING_WILD_DECK_ID, MUSIC_DITTY_1
	end_script
	ret
.ows_35b7c
	print_npc_text Text0c1f
	script_command_02
	end_script
	ret

Func_35b82:
	xor a
	start_script
	script_command_01
	check_event EVENT_BEAT_KAMIYA
	script_jump_if_b0z .ows_35ba8
	check_event EVENT_SET_UNTIL_MAP_RELOAD_2
	script_jump_if_b0nz .ows_35ba2
	set_event EVENT_BEAT_KAMIYA
	set_var VAR_30, $03
	set_var VAR_33, $00
	print_npc_text Text0c20
	give_booster_packs BoosterList_cd8e
	script_jump .ows_35bbf
.ows_35ba2
	print_npc_text Text0c21
	script_command_02
	end_script
	ret
.ows_35ba8
	check_event EVENT_SET_UNTIL_MAP_RELOAD_2
	script_jump_if_b0nz .ows_35bb9
	print_npc_text Text0c22
	give_booster_packs BoosterList_cd8e
	print_npc_text Text0c23
	script_jump .ows_35bbc
.ows_35bb9
	print_npc_text Text0c24
.ows_35bbc
	script_command_02
	end_script
	ret
.ows_35bbf
	script_command_64 $0b
	set_event EVENT_GOT_MACHAMP_COIN
	print_npc_text Text0c25
	give_coin COIN_MACHAMP
	print_npc_text Text0c26
	script_command_02
	get_player_direction
	compare_loaded_var $01
	script_jump_if_b0z .ows_35bd9
	set_player_direction NORTH
	animate_player_movement $82, $02
	set_player_direction NORTH
.ows_35bd9
	move_active_npc NPCMovement_35bdf
	wait_for_player_animation
	end_script
	ret
NPCMovement_35bdf:
	db WEST, MOVE_1
	db SOUTH, MOVE_0
	db $ff

Func_35be4:
	ld a, EVENT_CAN_TRAVEL_PAST_FIGHTING_FORT
	farcall GetEventValue
	jr nz, .asm_35c0f
	xor a
	start_script
	script_command_01
	print_text Text0c27
	check_event EVENT_GOT_MACHAMP_COIN
	script_jump_if_b0nz .ows_35c0d
	ask_question Text0c28, TRUE
	script_jump_if_b0z .ows_35c0d
	set_event EVENT_CAN_TRAVEL_PAST_FIGHTING_FORT
	script_command_02
	play_sfx SFX_0F
	load_tilemap TILEMAP_097, $07, $00
	end_script
	jr .asm_35c0f
.ows_35c0d
	script_command_02
	end_script
.asm_35c0f
	ret

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
	_ow_coordinate_function 4, 6, 104, 10, 1, 2, Func_35c86
	_ow_coordinate_function 5, 6, 104, 10, 1, 2, Func_35c86
	db $ff

FightingFortMaze16_MapScripts:
	dbw $06, Func_35c68
	dbw $0f, Func_35c6f
	dbw $02, Func_35c7b
	db $ff

Func_35c68:
	ld hl, FightingFortMaze16_StepEvents
	call Func_324d
	ret

Func_35c6f:
	ld a, [wd585]
	cp $68
	jr z, .asm_35c78
	scf
	ret
.asm_35c78
	scf
	ccf
	ret

Func_35c7b:
	ld bc, $53
	ld a, $05
	farcall SetwD896
	scf
	ret

Func_35c86:
	ld a, SFX_0F
	call PlaySFX
	ld bc, $c7
	ld de, SetBGP
	farcall Func_12c0ce
	farcall Func_30005
	ret

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
	_ow_coordinate_function 4, 6, 104, 10, 1, 2, Func_35d22
	_ow_coordinate_function 5, 6, 104, 10, 1, 2, Func_35d22
	db $ff

FightingFortMaze18_MapScripts:
	dbw $06, Func_35d04
	dbw $0f, Func_35d0b
	dbw $02, Func_35d17
	db $ff

Func_35d04:
	ld hl, FightingFortMaze18_StepEvents
	call Func_324d
	ret

Func_35d0b:
	ld a, [wd585]
	cp $68
	jr z, .asm_35d14
	scf
	ret
.asm_35d14
	scf
	ccf
	ret

Func_35d17:
	ld bc, $53
	ld a, $05
	farcall SetwD896
	scf
	ret

Func_35d22:
	ld a, SFX_0F
	call PlaySFX
	ld bc, $cc
	ld de, SetBGP
	farcall Func_12c0ce
	farcall Func_30005
	ret

FightingFortGoda_MapHeader:
	db MAP_GFX_FIGHTING_FORT_GODA
	dba FightingFortGoda_MapScripts
	db MUSIC_FORT_3

FightingFortGoda_StepEvents:
	map_exit 5, 10, MAP_FIGHTING_FORT_MAZE_15, 4, 1, SOUTH
	map_exit 6, 10, MAP_FIGHTING_FORT_MAZE_15, 5, 1, SOUTH
	db $ff

FightingFortGoda_NPCs:
	npc NPC_GODA, 5, 4, SOUTH, $0
	npc NPC_MITCH, 6, 2, SOUTH, Func_35de2
	db $ff

FightingFortGoda_NPCInteractions:
	npc_script NPC_GODA, Func_35def
	db $ff

FightingFortGoda_OWInteractions:
	ow_script 6, 4, Func_35dc0
	db $ff

FightingFortGoda_MapScripts:
	dbw $06, Func_35d7a
	dbw $08, Func_35da0
	dbw $09, Func_35db0
	dbw $07, Func_35d81
	dbw $02, Func_35d8a
	db $ff

Func_35d7a:
	ld hl, FightingFortGoda_StepEvents
	call Func_324d
	ret

Func_35d81:
	ld hl, FightingFortGoda_NPCs
	call Func_3205
	scf
	ccf
	ret

Func_35d8a:
	ld a, EVENT_GODAS_ROOM_CAGE_STATE
	farcall GetEventValue
	jr z, .asm_35d94
	scf
	ret
.asm_35d94
	ld bc, $a1
	ld de, FlushPalette
	farcall Func_12c0ce
	scf
	ret

Func_35da0:
	ld hl, FightingFortGoda_NPCInteractions
	call Func_328c
	jr nc, .asm_35dae
	ld hl, FightingFortGoda_OWInteractions
	call Func_32bf
.asm_35dae
	scf
	ret

Func_35db0:
	ld hl, FightingFortGoda_AfterDuelScripts
	ld a, [wScriptNPC]
	call Func_344c
	scf
	ret

FightingFortGoda_AfterDuelScripts:
	npc_script NPC_GODA, Func_35e5e
	db $ff

Func_35dc0:
	ld a, EVENT_GODAS_ROOM_CAGE_STATE
	farcall GetEventValue
	ret nz
	ld a, NPC_MITCH
	ld [wScriptNPC], a
	ld hl, $9d8
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	print_npc_text Text0be7
	script_command_02
	end_script
	ret

Func_35de2:
	ld a, EVENT_GODAS_ROOM_CAGE_STATE
	farcall GetEventValue
	jr z, .asm_35dec
	scf
	ret
.asm_35dec
	scf
	ccf
	ret

Func_35def:
	ld a, NPC_GODA
	ld [wScriptNPC], a
	ld hl, $a1b
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	check_event EVENT_FREED_MITCH
	script_jump_if_b0z .ows_35e3a
	check_event EVENT_TALKED_TO_GODA
	script_jump_if_b0z .ows_35e16
	set_event EVENT_TALKED_TO_GODA
	print_npc_text Text0be8
	script_jump .ows_35e19
.ows_35e16
	print_npc_text Text0be9
.ows_35e19
	ask_question Text0bea, TRUE
	script_jump_if_b0z .ows_35e34
	duel_requirement_check DUEL_REQUIREMENT_GODA
	script_jump_if_b1z .ows_35e2b
	print_npc_text Text0beb
	script_jump .ows_35e37
.ows_35e2b
	print_npc_text Text0bec
	script_command_02
	start_duel ROCK_BLAST_DECK_ID, MUSIC_MATCHSTART_1
	end_script
	ret
.ows_35e34
	print_npc_text Text0bed
.ows_35e37
	script_command_02
	end_script
	ret
.ows_35e3a
	print_npc_text Text0bee
	ask_question Text0bea, TRUE
	script_jump_if_b0z .ows_35e58
	duel_requirement_check DUEL_REQUIREMENT_GODA
	script_jump_if_b1z .ows_35e4f
	print_npc_text Text0bef
	script_jump .ows_35e5b
.ows_35e4f
	print_npc_text Text0bf0
	script_command_02
	start_duel ROCK_BLAST_DECK_ID, MUSIC_MATCHSTART_1
	end_script
	ret
.ows_35e58
	print_npc_text Text0bf1
.ows_35e5b
	script_command_02
	end_script
	ret

Func_35e5e:
	xor a
	start_script
	script_command_01
	check_event EVENT_FREED_MITCH
	script_jump_if_b0z .ows_35e81
	check_event EVENT_SET_UNTIL_MAP_RELOAD_2
	script_jump_if_b0nz .ows_35e7b
	set_event EVENT_FREED_MITCH
	print_npc_text Text0bf2
	give_booster_packs BoosterList_cd86
	print_npc_text Text0bf3
	script_jump .ows_35e98
.ows_35e7b
	print_npc_text Text0bf4
	script_command_02
	end_script
	ret
.ows_35e81
	check_event EVENT_SET_UNTIL_MAP_RELOAD_2
	script_jump_if_b0nz .ows_35e92
	print_npc_text Text0bf5
	give_booster_packs BoosterList_cd86
	print_npc_text Text0bf6
	script_jump .ows_35e95
.ows_35e92
	print_npc_text Text0bf7
.ows_35e95
	script_command_02
	end_script
	ret
.ows_35e98
	set_event EVENT_GODAS_ROOM_CAGE_STATE
	reset_event EVENT_TALKED_TO_MICHAEL
	reset_event EVENT_TALKED_TO_CHRIS
	reset_event EVENT_TALKED_TO_RICK
	reset_event EVENT_TALKED_TO_NICHOLAS
	reset_event EVENT_TALKED_TO_MITCH
	reset_event EVENT_TALKED_TO_STEPHANIE
	print_npc_text Text0bf8
	script_command_02
	do_frames 30
	set_active_npc_direction NORTH
	do_frames 30
	fade_out $00, TRUE
	wait_for_fade
	play_sfx SFX_0F
	load_tilemap TILEMAP_0A2, $04, $02
	set_active_npc_position_and_direction 5, 4, SOUTH
	set_player_position_and_direction 5, 5, NORTH
	set_npc_position_and_direction NPC_MITCH, 6, 5, WEST
	do_frames 28
	fade_in $00, TRUE
	wait_for_fade
	do_frames 30
	set_active_npc NPC_MITCH, DialogMitchText
	script_command_01
	set_player_direction EAST
	print_npc_text Text0bf9
	receive_card COOL_PORYGON
	print_npc_text Text0bfa
	script_command_02
	script_jump .ows_35ee4
.ows_35ee4
	animate_active_npc_movement $02, $01
	set_active_npc_direction NORTH
	do_frames 30
	script_command_01
	print_npc_text Text0bfb
	set_active_npc NPC_GODA, DialogGodaText
	print_npc_text Text0bfc
	set_active_npc NPC_MITCH, DialogMitchText
	print_npc_text Text0bfd
	script_command_02
	move_active_npc NPCMovement_35f11
	wait_for_player_animation
	unload_npc NPC_MITCH
	set_active_npc NPC_GODA, DialogGodaText
	script_command_01
	set_player_direction NORTH
	print_npc_text Text0bfe
	script_command_02
	end_script
	ret
NPCMovement_35f11:
	db SOUTH, MOVE_5
	db $ff

FightingFortGrace_MapHeader:
	db MAP_GFX_FIGHTING_FORT_GRACE
	dba FightingFortGrace_MapScripts
	db MUSIC_FORT_3

FightingFortGrace_StepEvents:
	map_exit 4, 10, MAP_FIGHTING_FORT_MAZE_5, 4, 1, SOUTH
	map_exit 5, 10, MAP_FIGHTING_FORT_MAZE_5, 5, 1, SOUTH
	db $ff

FightingFortGrace_NPCs:
	npc NPC_GRACE, 4, 2, SOUTH, $0
	npc NPC_CHEST_CLOSED, 5, 1, SOUTH, Func_36062
	npc NPC_CHEST_OPENED, 5, 1, SOUTH, Func_36082
	db $ff

FightingFortGrace_NPCInteractions:
	npc_script NPC_GRACE, Func_35f81
	npc_script NPC_CHEST_CLOSED, Func_36049
	npc_script NPC_CHEST_OPENED, Func_36077
	db $ff

FightingFortGrace_MapScripts:
	dbw $06, Func_35f59
	dbw $08, Func_35f69
	dbw $09, Func_35f71
	dbw $07, Func_35f60
	db $ff

Func_35f59:
	ld hl, FightingFortGrace_StepEvents
	call Func_324d
	ret

Func_35f60:
	ld hl, FightingFortGrace_NPCs
	call Func_3205
	scf
	ccf
	ret

Func_35f69:
	ld hl, FightingFortGrace_NPCInteractions
	call Func_328c
	scf
	ret

Func_35f71:
	ld hl, FightingFortGrace_AfterDuelScripts
	ld a, [wScriptNPC]
	call Func_344c
	scf
	ret

FightingFortGrace_AfterDuelScripts:
	npc_script NPC_GRACE, Func_35ffb
	db $ff

Func_35f81:
	ld a, NPC_GRACE
	ld [wScriptNPC], a
	ld hl, $a1c
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	check_event EVENT_EF
	script_jump_if_b0z .ows_35fd1
	check_event EVENT_GRACES_ROOM_CHEST_STATE
	script_jump_if_b0z .ows_35fd7
	check_event EVENT_TALKED_TO_GRACE
	script_jump_if_b0z .ows_35fad
	set_event EVENT_TALKED_TO_GRACE
	print_npc_text Text0bff
	script_jump .ows_35fb0
.ows_35fad
	print_npc_text Text0c00
.ows_35fb0
	ask_question Text0c01, TRUE
	script_jump_if_b0z .ows_35fcb
	duel_requirement_check DUEL_REQUIREMENT_GRACE
	script_jump_if_b1z .ows_35fc2
	print_npc_text Text0c02
	script_jump .ows_35fce
.ows_35fc2
	print_npc_text Text0c03
	script_command_02
	start_duel FULL_STRENGTH_DECK_ID, MUSIC_MATCHSTART_1
	end_script
	ret
.ows_35fcb
	print_npc_text Text0c04
.ows_35fce
	script_command_02
	end_script
	ret
.ows_35fd1
	print_npc_text Text0c05
	script_command_02
	end_script
	ret
.ows_35fd7
	print_npc_text Text0c06
	ask_question Text0c01, TRUE
	script_jump_if_b0z .ows_35ff5
	duel_requirement_check DUEL_REQUIREMENT_GRACE
	script_jump_if_b1z .ows_35fec
	print_npc_text Text0c07
	script_jump .ows_35ff8
.ows_35fec
	print_npc_text Text0c08
	script_command_02
	start_duel FULL_STRENGTH_DECK_ID, MUSIC_MATCHSTART_1
	end_script
	ret
.ows_35ff5
	print_npc_text Text0c09
.ows_35ff8
	script_command_02
	end_script
	ret

Func_35ffb:
	xor a
	start_script
	script_command_01
	check_event EVENT_GRACES_ROOM_CHEST_STATE
	script_jump_if_b0z .ows_3601b
	check_event EVENT_SET_UNTIL_MAP_RELOAD_2
	script_jump_if_b0nz .ows_36015
	set_event EVENT_GRACES_ROOM_CHEST_STATE
	print_npc_text Text0c0a
	give_booster_packs BoosterList_cd8a
	script_jump .ows_36032
.ows_36015
	print_npc_text Text0c0b
	script_command_02
	end_script
	ret
.ows_3601b
	check_event EVENT_SET_UNTIL_MAP_RELOAD_2
	script_jump_if_b0nz .ows_3602c
	print_npc_text Text0c0c
	give_booster_packs BoosterList_cd8a
	print_npc_text Text0c0d
	script_jump .ows_3602f
.ows_3602c
	print_npc_text Text0c0e
.ows_3602f
	script_command_02
	end_script
	ret
.ows_36032
	set_event EVENT_EF
	print_npc_text Text0c0f
	script_command_02
	spin_active_npc 260
	load_npc NPC_CHEST_CLOSED, 5, 1, SOUTH
	do_frames 30
	script_command_01
	print_npc_text Text0c10
	script_command_02
	end_script
	ret

Func_36049:
	xor a
	start_script
	script_command_01
	set_event EVENT_OPENED_CHEST_GRACES_ROOM
	play_sfx SFX_85
	load_npc NPC_CHEST_OPENED, 5, 1, SOUTH
	unload_npc NPC_CHEST_CLOSED
	print_text OpenedTreasureBoxText
	receive_card DUGTRIO_LV40
	script_command_02
	end_script
	ret

Func_36062:
	ld a, EVENT_GRACES_ROOM_CHEST_STATE
	farcall GetEventValue
	jr z, .asm_36075
	ld a, EVENT_OPENED_CHEST_GRACES_ROOM
	farcall GetEventValue
	jr nz, .asm_36075
	scf
	ccf
	ret
.asm_36075
	scf
	ret

Func_36077:
	xor a
	start_script
	script_command_01
	print_text TreasureBoxWasEmptyText
	script_command_02
	end_script
	ret

Func_36082:
	ld a, EVENT_GRACES_ROOM_CHEST_STATE
	farcall GetEventValue
	jr z, .asm_36095
	ld a, EVENT_OPENED_CHEST_GRACES_ROOM
	farcall GetEventValue
	jr z, .asm_36095
	scf
	ccf
	ret
.asm_36095
	scf
	ret

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
	npc NPC_GR_CLERK_PSYCHIC_STRONGHOLD, 3, 1, SOUTH, $0
	db $ff

PsychicStrongholdEntrance_NPCInteractions:
	npc_script NPC_GR_CLERK_PSYCHIC_STRONGHOLD, Func_36148
	db $ff

PsychicStrongholdEntrance_MapScripts:
	dbw $06, Func_36104
	dbw $08, Func_36140
	dbw $07, Func_3610b
	dbw $02, Func_36114
	dbw $10, Func_360ef
	db $ff

Func_360ef:
	ld a, VAR_TIMES_MET_RONALD
	farcall GetVarValue
	cp $07
	jr c, .asm_360fb
	scf
	ret
.asm_360fb
	ld a, $0f
	farcall PlayAfterCurrentSong
	scf
	ccf
	ret

Func_36104:
	ld hl, PsychicStrongholdEntrance_StepEvents
	call Func_324d
	ret

Func_3610b:
	ld hl, PsychicStrongholdEntrance_NPCs
	call Func_3205
	scf
	ccf
	ret

Func_36114:
	ld a, VAR_TIMES_MET_RONALD
	farcall GetVarValue
	cp $07
	jr nc, .asm_3613e
	ld a, $63
	ld de, $403
	ld b, $02
	farcall LoadOWObjectInMap
	ld a, $0a
	ld [wd582], a
	ld a, $0d
	ld [wd592], a
	ld hl, $442d
	ld a, l
	ld [wd593], a
	ld a, h
	ld [$d594], a
.asm_3613e
	scf
	ret

Func_36140:
	ld hl, PsychicStrongholdEntrance_NPCInteractions
	call Func_328c
	scf
	ret

Func_36148:
	ld a, NPC_GR_CLERK_PSYCHIC_STRONGHOLD
	ld [wScriptNPC], a
	ld hl, $a5a
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	check_event EVENT_GOT_MEW_COIN
	script_jump_if_b0z .ows_36169
	script_call .ows_3616f
	script_jump .ows_3616c
.ows_36169
	print_npc_text Text1115
.ows_3616c
	script_command_02
	end_script
	ret
.ows_3616f
	print_npc_text Text1116
	script_ret

PsychicStrongholdLobby_MapHeader:
	db MAP_GFX_PSYCHIC_STRONGHOLD_LOBBY
	dba PsychicStrongholdLobby_MapScripts
	db MUSIC_FORT_2

PsychicStrongholdLobby_StepEvents:
	map_exit 13, 6, MAP_PSYCHIC_STRONGHOLD_ENTRANCE, 1, 3, EAST
	map_exit 13, 7, MAP_PSYCHIC_STRONGHOLD_ENTRANCE, 1, 4, EAST
	db $ff

PsychicStrongholdLobby_NPCs:
	npc NPC_PSYCHIC_STRONGHOLD_LADY, 2, 6, WEST, $0
	npc NPC_PSYCHIC_STRONGHOLD_UNCAPPED_LAD, 5, 9, EAST, $0
	npc NPC_GR_PSYCHIC_STRONGHOLD_GR_LASS, 10, 4, EAST, $0
	npc NPC_IMAKUNI_RED, 12, 1, NORTH, Func_36310
	npc NPC_GR_CLERK_BATTLE_CENTER, 5, 2, SOUTH, $0
	npc NPC_GR_CLERK_GIFT_CENTER, 8, 2, SOUTH, $0
	db $ff

PsychicStrongholdLobby_NPCInteractions:
	npc_script NPC_PSYCHIC_STRONGHOLD_LADY, Func_36250
	npc_script NPC_PSYCHIC_STRONGHOLD_UNCAPPED_LAD, Func_362c4
	npc_script NPC_GR_PSYCHIC_STRONGHOLD_GR_LASS, Func_362ea
	npc_script NPC_IMAKUNI_RED, Func_3c4e0
	db $ff

PsychicStrongholdLobby_OWInteractions:
	ow_script 1, 2, PCMenu
	ow_script 2, 2, PCMenu
	ow_script 5, 4, Func_3c1d0
	ow_script 8, 4, Func_3c2d9
	db $ff

PsychicStrongholdLobby_MapScripts:
	dbw $06, Func_3620e
	dbw $08, Func_3621e
	dbw $09, Func_3622e
	dbw $0b, Func_36234
	dbw $07, Func_36215
	dbw $10, Func_361f9
	db $ff

Func_361f9:
	ld a, VAR_26
	farcall GetVarValue
	cp $0a
	jr z, .asm_36205
	scf
	ret
.asm_36205
	ld a, $24
	farcall PlayAfterCurrentSong
	scf
	ccf
	ret

Func_3620e:
	ld hl, PsychicStrongholdLobby_StepEvents
	call Func_324d
	ret

Func_36215:
	ld hl, PsychicStrongholdLobby_NPCs
	call Func_3205
	scf
	ccf
	ret

Func_3621e:
	ld hl, PsychicStrongholdLobby_NPCInteractions
	call Func_328c
	jr nc, .asm_3622c
	ld hl, PsychicStrongholdLobby_OWInteractions
	call Func_32bf
.asm_3622c
	scf
	ret

Func_3622e:
	farcall Func_3c52d
	scf
	ret

Func_36234:
	ld a, EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE_DUMMY
	farcall GetEventValue
	jr z, .asm_3624e
	ld a, NPC_IMAKUNI_RED
	farcall ClearOWObject
	ld a, EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE_DUMMY
	farcall ZeroOutEventValue
	ld a, [wNextMusic]
	ld [wCurMusic], a
.asm_3624e
	scf
	ret

Func_36250:
	ld a, NPC_PSYCHIC_STRONGHOLD_LADY
	ld [wScriptNPC], a
	ld hl, $a40
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	check_event EVENT_TRADED_CARDS_PSYCHIC_STRONGHOLD
	script_jump_if_b0z .ows_362be
	check_event EVENT_TALKED_TO_TRADE_NPC_PSYCHIC_STRONGHOLD
	script_jump_if_b0z .ows_3627e
	set_event EVENT_TALKED_TO_TRADE_NPC_PSYCHIC_STRONGHOLD
	check_event EVENT_PLAYER_GENDER
	set_variable_text_ram2 Text119d, Text119e
	print_npc_text Text119f
	script_jump .ows_36281
.ows_3627e
	print_npc_text Text11a0
.ows_36281
	ask_question TradeCardsPromptText, TRUE
	script_jump_if_b0nz .ows_3628e
	print_npc_text Text11a1
	script_jump .ows_362c1
.ows_3628e
	get_card_count_in_collection_and_decks DARK_HYPNO
	script_jump_if_b0z .ows_362a1
	check_event EVENT_PLAYER_GENDER
	set_variable_text_ram2 Text119d, Text119e
	print_npc_text Text11a2
	script_jump .ows_362c1
.ows_362a1
	get_card_count_in_collection DARK_HYPNO
	script_jump_if_b0z .ows_362ad
	print_npc_text Text11a3
	script_jump .ows_362c1
.ows_362ad
	print_npc_text Text11a4
	receive_card MEWTWO_LV60
	take_card DARK_HYPNO
	set_event EVENT_TRADED_CARDS_PSYCHIC_STRONGHOLD
	print_npc_text Text11a5
	script_jump .ows_362c1
.ows_362be
	print_npc_text Text11a6
.ows_362c1
	script_command_02
	end_script
	ret

Func_362c4:
	ld a, NPC_PSYCHIC_STRONGHOLD_UNCAPPED_LAD
	ld [wScriptNPC], a
	ld hl, $a30
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	check_event EVENT_BEAT_RYOKO
	script_jump_if_b0z .ows_362e4
	print_npc_text Text11a7
	script_jump .ows_362e7
.ows_362e4
	print_npc_text Text11a8
.ows_362e7
	script_command_02
	end_script
	ret

Func_362ea:
	ld a, NPC_GR_PSYCHIC_STRONGHOLD_GR_LASS
	ld [wScriptNPC], a
	ld hl, $a36
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	check_event EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE
	script_jump_if_b0z .ows_3630a
	print_npc_text Text11a9
	script_jump .ows_3630d
.ows_3630a
	print_npc_text Text11aa
.ows_3630d
	script_command_02
	end_script
	ret

Func_36310:
	ld a, VAR_26
	farcall GetVarValue
	cp $0a
	jr z, .asm_3631c
	scf
	ret
.asm_3631c
	scf
	ccf
	ret

PsychicStronghold_MapHeader:
	db MAP_GFX_PSYCHIC_STRONGHOLD
	dba PsychicStronghold_MapScripts
	db MUSIC_FORT_2

PsychicStronghold_StepEvents:
	_ow_coordinate_function 7, 12, 107, 4, 1, 2, Func_36bc8
	_ow_coordinate_function 8, 12, 107, 5, 1, 2, Func_36bc8
	_ow_coordinate_function 7, 3, 110, 7, 10, 0, Func_36be5
	_ow_coordinate_function 8, 3, 110, 8, 10, 0, Func_36be5
	db $ff

PsychicStronghold_NPCs:
	npc NPC_MIWA, 5, 7, SOUTH, $0
	npc NPC_KEVIN, 3, 5, SOUTH, $0
	npc NPC_YOSUKE, 10, 7, SOUTH, $0
	npc NPC_RYOKO, 12, 5, SOUTH, $0
	npc NPC_STRONGHOLD_PLATFORM, 6, 3, SOUTH, Func_36b8f
	db $ff

PsychicStronghold_NPCInteractions:
	npc_script NPC_MIWA, Func_36712
	npc_script NPC_KEVIN, Func_3682a
	npc_script NPC_YOSUKE, Func_36921
	npc_script NPC_RYOKO, Func_36a2a
	db $ff

PsychicStronghold_MapScripts:
	dbw $06, Func_3638f
	dbw $08, Func_36440
	dbw $12, Func_36448
	dbw $09, Func_36490
	dbw $07, Func_36396
	dbw $02, Func_3639f
	dbw $0f, Func_36434
	db $ff

Func_3638f:
	ld hl, PsychicStronghold_StepEvents
	call Func_324d
	ret

Func_36396:
	ld hl, PsychicStronghold_NPCs
	call Func_3205
	scf
	ccf
	ret

Func_3639f:
	ld a, [wd584]
	cp $6b
	jr nz, .asm_363aa
	farcall Func_1f293
.asm_363aa
	xor a
	start_script
	check_event EVENT_MET_PSYCHIC_STRONGHOLD_MEMBERS
	script_jump_if_b0z .ows_363be
	unload_npc NPC_MIWA
	unload_npc NPC_KEVIN
	unload_npc NPC_YOSUKE
	unload_npc NPC_RYOKO
	script_jump .ows_363da
.ows_363be
	script_call Script_36ba6
	check_event EVENT_BEAT_MIWA
	script_call b0z, .ows_36408
	check_event EVENT_BEAT_KEVIN
	script_call b0z, .ows_36412
	check_event EVENT_BEAT_YOSUKE
	script_call b0z, .ows_3641c
	check_event EVENT_BEAT_RYOKO
	script_call b0z, .ows_36426
.ows_363da
	end_script
	ld a, [wd584]
	cp $6e
	jr z, .asm_363e4
	scf
	ret
.asm_363e4
	ld a, [wPlayerOWObject]
	farcall ResetOWObjectSpriteAnimFlag6
	ld a, $e8
	farcall ResetOWObjectSpriteAnimFlag6
	ld a, $0a
	ld [wd582], a
	ld a, $0d
	ld [wd592], a
	ld hl, $6c36
	ld a, l
	ld [wd593], a
	ld a, h
	ld [$d594], a
	scf
	ret
.ows_36408
	set_npc_position NPC_MIWA, 5, 6
	load_tilemap TILEMAP_0A8, $04, $07
	script_ret
.ows_36412
	set_npc_position NPC_KEVIN, 3, 4
	load_tilemap TILEMAP_0A7, $02, $05
	script_ret
.ows_3641c
	set_npc_position NPC_YOSUKE, 10, 6
	load_tilemap TILEMAP_0A9, $09, $07
	script_ret
.ows_36426
	set_npc_position NPC_RYOKO, 12, 4
	load_tilemap TILEMAP_0AA, $0b, $05
	script_call Script_36b76
	script_ret

Func_36434:
	ld a, [wd585]
	cp $6e
	jr z, .asm_3643d
	scf
	ret
.asm_3643d
	scf
	ccf
	ret

Func_36440:
	ld hl, PsychicStronghold_NPCInteractions
	call Func_328c
	scf
	ret

Func_36448:
	ld a, VAR_03
	farcall GetVarValue
	cp $03
	jr nc, .asm_36454
	scf
	ret
.asm_36454
	ld a, [wPlayerOWObject]
	farcall GetOWObjectTilePosition
	ld a, e
	cp $08
	jr nc, .asm_3647c
	ld a, d
	cp $05
	jr c, .asm_3647c
	jr z, .asm_36476
	cp $07
	jr nc, .asm_3647c
	ld a, $e8
	ld bc, $157
	farcall SetOWObjectFrameset
	jr .asm_3647c
.asm_36476
	ld a, $e8
	farcall ResetOWObjectSpriteAnimFlag6
.asm_3647c
	farcall Func_c1a6
	ld a, $e8
	ld bc, $155
	farcall SetOWObjectFrameset
	farcall SetOWObjectSpriteAnimFlag6
	scf
	ccf
	ret

Func_36490:
	ld hl, PsychicStronghold_AfterDuelScripts
	ld a, [wScriptNPC]
	call Func_344c
	scf
	ret

PsychicStronghold_AfterDuelScripts:
	npc_script NPC_MIWA, Func_3678e
	npc_script NPC_KEVIN, Func_36887
	npc_script NPC_YOSUKE, Func_36990
	npc_script NPC_RYOKO, Func_36ad3
	db $ff

Func_364ac:
	ld a, NPC_MAMI
	ld [wScriptNPC], a
	ld hl, $a21
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	set_event EVENT_MET_PSYCHIC_STRONGHOLD_MEMBERS
	print_npc_text Text1137
	script_command_02
	get_player_x_position
	compare_loaded_var $08
	script_jump_if_b0nz .ows_364d4
	move_player NPCMovement_3662f, TRUE
	script_jump .ows_364d8
.ows_364d4
	move_player NPCMovement_36632, TRUE
.ows_364d8
	scroll_to_position $03, $02
	wait_for_player_animation
	do_frames 60
	play_sfx SFX_88
	load_npc NPC_MAMI, 7, 15, SOUTH
	load_npc NPC_STRONGHOLD_PLATFORM, 6, 15, SOUTH
	set_sprite_frameset NPC_STRONGHOLD_PLATFORM, FRAMESET_156
	move_active_npc NPCMovement_36639
	move_npc NPC_STRONGHOLD_PLATFORM, NPCMovement_36639
	wait_for_player_animation
	move_active_npc NPCMovement_3663c
	move_npc NPC_STRONGHOLD_PLATFORM, NPCMovement_3663c
	wait_for_player_animation
	do_frames 30
	animate_active_npc_movement $02, $01
	set_sprite_frameset NPC_STRONGHOLD_PLATFORM, FRAMESET_155
	script_command_01
	print_npc_text Text1138
	script_command_02
	move_active_npc NPCMovement_36629
	scroll_to_position $ff, $04
	scroll_to_player
	wait_for_player_animation
	script_command_01
	print_npc_text Text1139
	script_command_02
	do_frames 30
	set_active_npc_direction EAST
	script_command_01
	print_npc_text Text113a
	script_command_02
	do_frames 30
	play_sfx SFX_86
	load_npc NPC_WARP_SPARKLES, 10, 7, SOUTH
	wait_for_npc_animation NPC_WARP_SPARKLES
	load_npc NPC_YOSUKE, 10, 7, SOUTH
	unload_npc NPC_WARP_SPARKLES
	script_command_01
	set_active_npc NPC_YOSUKE, DialogYosukeText
	print_npc_text Text113b
	script_command_02
	do_frames 30
	set_active_npc NPC_MAMI, DialogMamiText
	set_active_npc_direction WEST
	script_command_01
	print_npc_text Text113c
	script_command_02
	do_frames 30
	play_sfx SFX_86
	load_npc NPC_WARP_SPARKLES, 5, 7, SOUTH
	wait_for_npc_animation NPC_WARP_SPARKLES
	load_npc NPC_GR_4, 5, 7, SOUTH
	unload_npc NPC_WARP_SPARKLES
	script_command_01
	set_active_npc NPC_GR_4, DialogGR4Text
	print_npc_text Text113d
	set_active_npc NPC_MAMI, DialogMamiText
	print_npc_text Text113e
	script_command_02
	do_frames 30
	set_active_npc NPC_GR_4, DialogGR4Text
	set_active_npc_direction EAST
	script_command_01
	print_npc_text Text113f
	set_active_npc NPC_MAMI, DialogMamiText
	print_npc_text Text1140
	script_command_02
	animate_active_npc_movement $83, $02
	play_sfx SFX_08
	animate_active_npc_movement $81, $02
	animate_active_npc_movement $83, $02
	play_sfx SFX_08
	animate_active_npc_movement $81, $02
	set_active_npc_direction WEST
	set_active_npc NPC_GR_4, DialogGR4Text
	set_active_npc_direction EAST
	script_command_01
	print_npc_text Text1141
	script_command_02
	spin_active_npc 260
	play_sfx SFX_86
	load_npc NPC_WARP_SPARKLES, 5, 7, SOUTH
	unload_npc NPC_GR_4
	wait_for_npc_animation NPC_WARP_SPARKLES
	load_npc NPC_MIWA, 5, 7, SOUTH
	unload_npc NPC_WARP_SPARKLES
	set_active_npc NPC_MIWA, DialogMiwaText
	script_command_01
	print_npc_text Text1142
	script_command_02
	spin_active_npc 267
	set_active_npc NPC_MAMI, DialogMamiText
	do_frames 60
	set_active_npc_direction SOUTH
	animate_active_npc_movement $80, $01
	animate_active_npc_movement $80, $01
	do_frames 30
	set_active_npc_direction WEST
	script_command_01
	print_npc_text Text1143
	script_command_02
	do_frames 30
	play_sfx SFX_86
	load_npc NPC_WARP_SPARKLES, 3, 5, SOUTH
	wait_for_npc_animation NPC_WARP_SPARKLES
	load_npc NPC_KEVIN, 3, 5, SOUTH
	unload_npc NPC_WARP_SPARKLES
	script_command_01
	set_active_npc NPC_KEVIN, DialogKevinText
	print_npc_text Text1144
	script_command_02
	do_frames 30
	set_active_npc NPC_MAMI, DialogMamiText
	set_active_npc_direction EAST
	script_command_01
	print_npc_text Text1145
	script_command_02
	do_frames 30
	play_sfx SFX_86
	load_npc NPC_WARP_SPARKLES, 12, 5, SOUTH
	wait_for_npc_animation NPC_WARP_SPARKLES
	load_npc NPC_RYOKO, 12, 5, SOUTH
	unload_npc NPC_WARP_SPARKLES
	do_frames 30
	set_active_npc_direction SOUTH
	script_command_01
	print_npc_text Text1146
	script_command_02
	move_active_npc NPCMovement_3662c
	wait_for_player_animation
	unload_npc NPC_MAMI
	unload_npc NPC_STRONGHOLD_PLATFORM
	do_frames 30
	end_script
	ld a, $00
	ld [wd582], a
	ret
NPCMovement_36629:
	db SOUTH, MOVE_3
	db $ff
NPCMovement_3662c:
	db NORTH | MOVE_BACKWARDS, MOVE_4
	db $ff
NPCMovement_3662f:
	db NORTH, MOVE_2
	db $ff
NPCMovement_36632:
	db NORTH, MOVE_2
	db WEST, MOVE_1
	db NORTH, MOVE_0
	db $ff
NPCMovement_36639:
	db SOUTH, RUN_3
	db $ff
NPCMovement_3663c:
	db SOUTH, MOVE_1
	db $ff

Script_3663f:
	do_frames 60
	play_sfx SFX_88
	load_npc NPC_MAMI, 7, 15, SOUTH
	load_npc NPC_STRONGHOLD_PLATFORM, 6, 15, SOUTH
	set_sprite_frameset NPC_STRONGHOLD_PLATFORM, FRAMESET_156
	move_npc NPC_MAMI, NPCMovement_36706
	move_npc NPC_STRONGHOLD_PLATFORM, NPCMovement_36706
	wait_for_player_animation
	move_npc NPC_MAMI, NPCMovement_36709
	move_npc NPC_STRONGHOLD_PLATFORM, NPCMovement_36709
	wait_for_player_animation
	do_frames 30
	animate_npc_movement NPC_MAMI, $02, $01
	unload_npc NPC_STRONGHOLD_PLATFORM
	load_npc NPC_STRONGHOLD_PLATFORM, 6, 3, NORTH
	set_npc_direction NPC_MIWA, NORTH
	set_npc_direction NPC_KEVIN, EAST
	set_npc_direction NPC_YOSUKE, NORTH
	set_npc_direction NPC_RYOKO, WEST
	do_frames 30
	get_player_y_position
	compare_loaded_var $07
	script_jump_if_b0z .ows_366a5
	get_player_x_position
	compare_loaded_var $06
	script_jump_if_b0nz .ows_36692
	compare_loaded_var $09
	script_jump_if_b0nz .ows_3669a
	script_jump .ows_366a5

.ows_36692
	animate_player_movement $01, $01
	set_player_direction NORTH
	script_jump .ows_366c9

.ows_3669a
	animate_player_movement $03, $01
	animate_player_movement $03, $01
	set_player_direction NORTH
	script_jump .ows_366c9

.ows_366a5
	get_player_y_position
	compare_loaded_var $08
	script_jump_if_b0nz .ows_366b1
	animate_player_movement $02, $01
	script_jump .ows_366a5

.ows_366b1
	get_player_x_position
	compare_loaded_var $07
	script_jump_if_b0nz .ows_366c6
	script_jump_if_b1z .ows_366c0
	animate_player_movement $01, $01
	script_jump .ows_366b1

.ows_366c0
	animate_player_movement $03, $01
	script_jump .ows_366b1

.ows_366c6
	animate_player_movement $00, $01
.ows_366c9
	set_active_npc NPC_MAMI, DialogMamiText
	script_command_01
	print_npc_text Text1147
	script_command_02
	animate_active_npc_movement $00, $01
	do_frames 30
	set_sprite_frameset NPC_STRONGHOLD_PLATFORM, FRAMESET_156
	move_active_npc NPCMovement_3670c
	move_npc NPC_STRONGHOLD_PLATFORM, NPCMovement_3670c
	wait_for_player_animation
	play_sfx SFX_87
	move_active_npc NPCMovement_3670f
	move_npc NPC_STRONGHOLD_PLATFORM, NPCMovement_3670f
	wait_for_player_animation
	unload_npc NPC_MAMI
	unload_npc NPC_STRONGHOLD_PLATFORM
	do_frames 30
	load_npc NPC_STRONGHOLD_PLATFORM, 6, 3, SOUTH
	set_npc_direction NPC_MIWA, SOUTH
	set_npc_direction NPC_KEVIN, SOUTH
	set_npc_direction NPC_YOSUKE, SOUTH
	script_call Script_36b76
	script_ret

NPCMovement_36706:
	db SOUTH, RUN_3
	db $ff

NPCMovement_36709:
	db SOUTH, MOVE_1
	db $ff

NPCMovement_3670c:
	db NORTH, MOVE_1
	db $ff

NPCMovement_3670f:
	db NORTH, RUN_3
	db $ff

Func_36712:
	ld a, NPC_MIWA
	ld [wScriptNPC], a
	ld hl, $a1d
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	check_event EVENT_BEAT_MIWA
	script_jump_if_b0z .ows_3675d
	check_event EVENT_TALKED_TO_MIWA
	script_jump_if_b0z .ows_36739
	set_event EVENT_TALKED_TO_MIWA
	print_npc_text Text1148
	script_jump .ows_3673c
.ows_36739
	print_npc_text Text1149
.ows_3673c
	ask_question Text114a, TRUE
	script_jump_if_b0z .ows_36757
	duel_requirement_check DUEL_REQUIREMENT_MIWA
	script_jump_if_b1z .ows_3674e
	print_npc_text Text114b
	script_jump .ows_3675a
.ows_3674e
	print_npc_text Text114c
	script_command_02
	start_duel DIRECT_HIT_DECK_ID, MUSIC_MATCHSTART_1
	end_script
	ret
.ows_36757
	print_npc_text Text114d
.ows_3675a
	script_command_02
	end_script
	ret
.ows_3675d
	check_event EVENT_TALKED_TO_MIWA
	script_jump_if_b0z .ows_3676a
	set_event EVENT_TALKED_TO_MIWA
	print_npc_text Text114e
	script_jump .ows_3676d
.ows_3676a
	print_npc_text Text114f
.ows_3676d
	ask_question Text114a, TRUE
	script_jump_if_b0z .ows_36788
	duel_requirement_check DUEL_REQUIREMENT_MIWA
	script_jump_if_b1z .ows_3677f
	print_npc_text Text1150
	script_jump .ows_3678b
.ows_3677f
	print_npc_text Text1151
	script_command_02
	start_duel DIRECT_HIT_DECK_ID, MUSIC_MATCHSTART_1
	end_script
	ret
.ows_36788
	print_npc_text Text1152
.ows_3678b
	script_command_02
	end_script
	ret

Func_3678e:
	xor a
	start_script
	script_command_01
	check_event EVENT_BEAT_MIWA
	script_jump_if_b0z .ows_367b1
	check_event EVENT_SET_UNTIL_MAP_RELOAD_2
	script_jump_if_b0nz .ows_367ab
	set_event EVENT_BEAT_MIWA
	print_npc_text Text1153
	give_booster_packs BoosterList_cd92
	print_npc_text Text1154
	script_jump .ows_367c8
.ows_367ab
	print_npc_text Text1155
	script_command_02
	end_script
	ret
.ows_367b1
	check_event EVENT_SET_UNTIL_MAP_RELOAD_2
	script_jump_if_b0nz .ows_367c2
	print_npc_text Text1156
	give_booster_packs BoosterList_cd92
	print_npc_text Text1157
	script_jump .ows_367c5
.ows_367c2
	print_npc_text Text1158
.ows_367c5
	script_command_02
	end_script
	ret
.ows_367c8
	reset_event EVENT_TALKED_TO_MIWA
	compare_var VAR_03, $03
	script_jump_if_b0nz .ows_367fd
	compare_var VAR_03, $02
	script_jump_if_b0nz .ows_367e7
	inc_var VAR_03
	print_npc_text Text1159
	script_command_02
	script_call .ows_3680c
	script_command_01
	print_npc_text Text115a
	script_jump .ows_36809
.ows_367e7
	set_var VAR_03, $03
	print_npc_text Text115b
	script_command_02
	script_call .ows_3680c
	script_command_01
	print_npc_text Text115c
	script_command_02
	script_call Script_3663f
	end_script
	ret
.ows_367fd
	print_npc_text Text115d
	script_command_02
	script_call .ows_3680c
	script_command_01
	print_npc_text Text115e
.ows_36809
	script_command_02
	end_script
	ret
.ows_3680c
	get_player_direction
	compare_loaded_var $02
	script_jump_if_b0z .ows_36819
	set_player_direction EAST
	animate_player_movement $83, $02
	set_player_direction EAST
.ows_36819
	set_active_npc_direction SOUTH
	animate_active_npc_movement $80, $01
	load_tilemap TILEMAP_0A8, $04, $07
	set_active_npc_direction SOUTH
	script_call Script_36ba6
	script_ret

Func_3682a:
	ld a, NPC_KEVIN
	ld [wScriptNPC], a
	ld hl, $a1e
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	check_event EVENT_BEAT_KEVIN
	script_jump_if_b0z .ows_3686c
	check_event EVENT_TALKED_TO_KEVIN
	script_jump_if_b0z .ows_36851
	set_event EVENT_TALKED_TO_KEVIN
	print_npc_text Text115f
	script_jump .ows_36854
.ows_36851
	print_npc_text Text1160
.ows_36854
	ask_question Text1161, TRUE
	script_jump_if_b0z .ows_36866
	check_event EVENT_BEAT_KEVIN
	print_npc_text Text1162
	script_command_02
	start_duel SUPERDESTRUCTIVE_POWER_DECK_ID, MUSIC_MATCHSTART_1
	end_script
	ret
.ows_36866
	print_npc_text Text1163
	script_command_02
	end_script
	ret
.ows_3686c
	print_npc_text Text1164
	ask_question Text1161, TRUE
	script_jump_if_b0z .ows_36881
	check_event EVENT_BEAT_KEVIN
	print_npc_text Text1162
	script_command_02
	start_duel SUPERDESTRUCTIVE_POWER_DECK_ID, MUSIC_MATCHSTART_1
	end_script
	ret
.ows_36881
	print_npc_text Text1165
	script_command_02
	end_script
	ret

Func_36887:
	xor a
	start_script
	script_command_01
	check_event EVENT_BEAT_KEVIN
	script_jump_if_b0z .ows_368aa
	check_event EVENT_SET_UNTIL_MAP_RELOAD_2
	script_jump_if_b0nz .ows_368a4
	set_event EVENT_BEAT_KEVIN
	print_npc_text Text1166
	give_booster_packs BoosterList_cd96
	print_npc_text Text1167
	script_jump .ows_368c1
.ows_368a4
	print_npc_text Text1168
	script_command_02
	end_script
	ret
.ows_368aa
	check_event EVENT_SET_UNTIL_MAP_RELOAD_2
	script_jump_if_b0nz .ows_368bb
	print_npc_text Text1169
	give_booster_packs BoosterList_cd96
	print_npc_text Text116a
	script_jump .ows_368be
.ows_368bb
	print_npc_text Text116b
.ows_368be
	script_command_02
	end_script
	ret
.ows_368c1
	reset_event EVENT_TALKED_TO_KEVIN
	compare_var VAR_03, $03
	script_jump_if_b0nz .ows_368f6
	compare_var VAR_03, $02
	script_jump_if_b0nz .ows_368e0
	inc_var VAR_03
	print_npc_text Text116c
	script_command_02
	script_call .ows_36905
	script_command_01
	print_npc_text Text116d
	script_jump .ows_36902
.ows_368e0
	set_var VAR_03, $03
	print_npc_text Text116e
	script_command_02
	script_call .ows_36905
	script_command_01
	print_npc_text Text116f
	script_command_02
	script_call Script_3663f
	end_script
	ret
.ows_368f6
	print_npc_text Text1170
	script_command_02
	script_call .ows_36905
	script_command_01
	print_npc_text Text1171
.ows_36902
	script_command_02
	end_script
	ret
.ows_36905
	get_player_direction
	compare_loaded_var $02
	script_jump_if_b0z .ows_36912
	set_player_direction EAST
	animate_player_movement $83, $02
	set_player_direction EAST
.ows_36912
	set_active_npc_direction SOUTH
	animate_active_npc_movement $80, $01
	load_tilemap TILEMAP_0A7, $02, $05
	script_call Script_36ba6
	script_ret

Func_36921:
	ld a, NPC_YOSUKE
	ld [wScriptNPC], a
	ld hl, $a1f
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	check_event EVENT_BEAT_YOSUKE
	script_jump_if_b0z .ows_3696c
	check_event EVENT_TALKED_TO_YOSUKE
	script_jump_if_b0z .ows_36948
	set_event EVENT_TALKED_TO_YOSUKE
	print_npc_text Text1172
	script_jump .ows_3694b
.ows_36948
	print_npc_text Text1173
.ows_3694b
	ask_question Text1174, TRUE
	script_jump_if_b0z .ows_36966
	duel_requirement_check DUEL_REQUIREMENT_YOSUKE
	script_jump_if_b1z .ows_3695d
	print_npc_text Text1175
	script_jump .ows_36969
.ows_3695d
	print_npc_text Text1176
	script_command_02
	start_duel BAD_DREAM_DECK_ID, MUSIC_MATCHSTART_1
	end_script
	ret
.ows_36966
	print_npc_text Text1177
.ows_36969
	script_command_02
	end_script
	ret
.ows_3696c
	print_npc_text Text1178
	ask_question Text1174, TRUE
	script_jump_if_b0z .ows_3698a
	duel_requirement_check DUEL_REQUIREMENT_YOSUKE
	script_jump_if_b1z .ows_36981
	print_npc_text Text1175
	script_jump .ows_3698d
.ows_36981
	print_npc_text Text1179
	script_command_02
	start_duel BAD_DREAM_DECK_ID, MUSIC_MATCHSTART_1
	end_script
	ret
.ows_3698a
	print_npc_text Text117a
.ows_3698d
	script_command_02
	end_script
	ret

Func_36990:
	xor a
	start_script
	script_command_01
	check_event EVENT_BEAT_YOSUKE
	script_jump_if_b0z .ows_369b3
	check_event EVENT_SET_UNTIL_MAP_RELOAD_2
	script_jump_if_b0nz .ows_369ad
	set_event EVENT_BEAT_YOSUKE
	print_npc_text Text117b
	give_booster_packs BoosterList_cd9a
	print_npc_text Text117c
	script_jump .ows_369ca
.ows_369ad
	print_npc_text Text117d
	script_command_02
	end_script
	ret
.ows_369b3
	check_event EVENT_SET_UNTIL_MAP_RELOAD_2
	script_jump_if_b0nz .ows_369c4
	print_npc_text Text117e
	give_booster_packs BoosterList_cd9a
	print_npc_text Text117f
	script_jump .ows_369c7
.ows_369c4
	print_npc_text Text117d
.ows_369c7
	script_command_02
	end_script
	ret
.ows_369ca
	compare_var VAR_03, $03
	script_jump_if_b0nz .ows_369fd
	compare_var VAR_03, $02
	script_jump_if_b0nz .ows_369e7
	inc_var VAR_03
	print_npc_text Text1180
	script_command_02
	script_call .ows_36a0c
	script_command_01
	print_npc_text Text1181
	script_jump .ows_36a09
.ows_369e7
	set_var VAR_03, $03
	print_npc_text Text1182
	script_command_02
	script_call .ows_36a0c
	script_command_01
	print_npc_text Text1183
	script_command_02
	script_call Script_3663f
	end_script
	ret
.ows_369fd
	print_npc_text Text1184
	script_command_02
	script_call .ows_36a0c
	script_command_01
	print_npc_text Text1185
.ows_36a09
	script_command_02
	end_script
	ret
.ows_36a0c
	get_player_direction
	compare_loaded_var $02
	script_jump_if_b0z .ows_36a19
	set_player_direction WEST
	animate_player_movement $81, $02
	set_player_direction WEST
.ows_36a19
	set_active_npc_direction SOUTH
	animate_active_npc_movement $80, $01
	set_active_npc_direction SOUTH
	load_tilemap TILEMAP_0A9, $09, $07
	script_call Script_36ba6
	script_ret

Func_36a2a:
	ld a, NPC_RYOKO
	ld [wScriptNPC], a
	ld hl, $a20
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	check_event EVENT_BEAT_MAMI
	script_jump_if_b0z .ows_36aa2
	check_event EVENT_BEAT_RYOKO
	script_jump_if_b0z .ows_36a7a
	check_event EVENT_TALKED_TO_RYOKO
	script_jump_if_b0z .ows_36a56
	set_event EVENT_TALKED_TO_RYOKO
	print_npc_text Text1186
	script_jump .ows_36a59
.ows_36a56
	print_npc_text Text1187
.ows_36a59
	ask_question Text1188, TRUE
	script_jump_if_b0z .ows_36a74
	duel_requirement_check DUEL_REQUIREMENT_RYOKO
	script_jump_if_b1z .ows_36a6b
	print_npc_text Text1189
	script_jump .ows_36a77
.ows_36a6b
	print_npc_text Text118a
	script_command_02
	start_duel POKEMON_POWER_DECK_ID, MUSIC_MATCHSTART_1
	end_script
	ret
.ows_36a74
	print_npc_text Text118b
.ows_36a77
	script_command_02
	end_script
	ret
.ows_36a7a
	print_npc_text Text118c
	ask_question Text1188, TRUE
	script_jump_if_b0z .ows_36a98
	duel_requirement_check DUEL_REQUIREMENT_RYOKO
	script_jump_if_b1z .ows_36a8f
	print_npc_text Text118d
	script_jump .ows_36a9b
.ows_36a8f
	print_npc_text Text118e
	script_command_02
	start_duel POKEMON_POWER_DECK_ID, MUSIC_MATCHSTART_1
	end_script
	ret
.ows_36a98
	print_npc_text Text118f
.ows_36a9b
	script_call Script_36b76
	script_command_02
	end_script
	ret
.ows_36aa2
	check_event EVENT_TALKED_TO_RYOKO
	script_jump_if_b0z .ows_36aaf
	set_event EVENT_TALKED_TO_RYOKO
	print_npc_text Text1190
	script_jump .ows_36ab2
.ows_36aaf
	print_npc_text Text1191
.ows_36ab2
	ask_question Text1188, TRUE
	script_jump_if_b0z .ows_36acd
	duel_requirement_check DUEL_REQUIREMENT_RYOKO
	script_jump_if_b1z .ows_36ac4
	print_npc_text Text118d
	script_jump .ows_36ad0
.ows_36ac4
	print_npc_text Text118e
	script_command_02
	start_duel POKEMON_POWER_DECK_ID, MUSIC_MATCHSTART_1
	end_script
	ret
.ows_36acd
	print_npc_text Text118f
.ows_36ad0
	script_command_02
	end_script
	ret

Func_36ad3:
	xor a
	start_script
	script_command_01
	check_event EVENT_BEAT_RYOKO
	script_jump_if_b0z .ows_36afa
	check_event EVENT_SET_UNTIL_MAP_RELOAD_2
	script_jump_if_b0nz .ows_36af0
	set_event EVENT_BEAT_RYOKO
	print_npc_text Text1192
	give_booster_packs BoosterList_cd9e
	print_npc_text Text1193
	script_jump .ows_36b15
.ows_36af0
	print_npc_text Text1194
	script_call Script_36b76
	script_command_02
	end_script
	ret
.ows_36afa
	check_event EVENT_SET_UNTIL_MAP_RELOAD_2
	script_jump_if_b0nz .ows_36b0b
	print_npc_text Text1195
	give_booster_packs BoosterList_cd9e
	print_npc_text Text1196
	script_jump .ows_36b0e
.ows_36b0b
	print_npc_text Text1197
.ows_36b0e
	script_call Script_36b76
	script_command_02
	end_script
	ret
.ows_36b15
	compare_var VAR_03, $03
	script_jump_if_b0nz .ows_36b48
	compare_var VAR_03, $02
	script_jump_if_b0nz .ows_36b32
	inc_var VAR_03
	print_npc_text Text1198
	script_command_02
	script_call .ows_36b58
	script_command_01
	print_npc_text Text1199
	script_jump .ows_36b51
.ows_36b32
	set_var VAR_03, $03
	print_npc_text Text119a
	script_command_02
	script_call .ows_36b58
	script_command_01
	print_npc_text Text119b
	script_command_02
	script_call Script_3663f
	end_script
	ret
.ows_36b48
	print_npc_text Text119c
	script_command_02
	script_call .ows_36b58
	script_command_01
.ows_36b51
	script_call Script_36b76
	script_command_02
	end_script
	ret
.ows_36b58
	get_player_direction
	compare_loaded_var $02
	script_jump_if_b0z .ows_36b65
	set_player_direction WEST
	animate_player_movement $81, $02
	set_player_direction WEST
.ows_36b65
	set_active_npc_direction SOUTH
	animate_active_npc_movement $80, $01
	set_active_npc_direction SOUTH
	load_tilemap TILEMAP_0AA, $0b, $05
	script_call Script_36ba6
	script_ret
Script_36b76:
	check_event EVENT_BEAT_RYOKO
	script_jump_if_b0nz .ows_36b8b
	check_event EVENT_BEAT_MAMI
	script_jump_if_b0nz .ows_36b85
	check_event EVENT_TALKED_TO_RYOKO
	script_jump_if_b0z .ows_36b8e
.ows_36b85
	set_npc_direction NPC_RYOKO, NORTH
	script_jump .ows_36b8e
.ows_36b8b
	set_npc_direction NPC_RYOKO, SOUTH
.ows_36b8e
	script_ret

Func_36b8f:
	ld a, EVENT_MET_PSYCHIC_STRONGHOLD_MEMBERS
	farcall GetEventValue
	jr z, .asm_36ba4
	ld a, VAR_03
	farcall GetVarValue
	cp $03
	jr c, .asm_36ba4
	scf
	ccf
	ret
.asm_36ba4
	scf
	ret

Script_36ba6:
	compare_var VAR_03, $00
	script_jump_if_b0nz .ows_36bc7
	load_tilemap TILEMAP_0AB, $06, $02
	compare_var VAR_03, $01
	script_jump_if_b0nz .ows_36bc7
	load_tilemap TILEMAP_0AC, $09, $02
	compare_var VAR_03, $02
	script_jump_if_b0nz .ows_36bc7
	load_tilemap TILEMAP_0AD, $07, $01
.ows_36bc7
	script_ret

Func_36bc8:
	push af
	push bc
	push de
	push hl
	ld a, EVENT_MET_PSYCHIC_STRONGHOLD_MEMBERS
	farcall GetEventValue
	jr nz, .asm_36bdc
	pop hl
	pop de
	pop bc
	pop af
	call Func_364ac
	ret
.asm_36bdc
	pop hl
	pop de
	pop bc
	pop af
	farcall Func_d3c4
	ret

Func_36be5:
	push af
	push bc
	push de
	push hl
	ld a, VAR_03
	farcall GetVarValue
	cp $03
	jr nc, .asm_36bfc
	pop hl
	pop de
	pop bc
	pop af
	farcall Func_c199
	ret
.asm_36bfc
	pop hl
	pop de
	pop bc
	pop af
	farcall Func_d3c4
	ld a, [wPlayerOWObject]
	farcall ResetOWObjectFlag5_WithID
	xor a
	start_script
	set_scroll_state $02
	set_npc_direction NPC_STRONGHOLD_PLATFORM, NORTH
	set_sprite_frameset NPC_STRONGHOLD_PLATFORM, FRAMESET_156
	do_frames 30
	move_player NPCMovement_36c30, FALSE
	move_npc NPC_STRONGHOLD_PLATFORM, NPCMovement_36c30
	wait_for_player_animation
	play_sfx SFX_87
	move_player NPCMovement_36c33, FALSE
	move_npc NPC_STRONGHOLD_PLATFORM, NPCMovement_36c33
	wait_for_player_animation
	end_script
	ret
NPCMovement_36c30:
	db NORTH, MOVE_1
	db $ff
NPCMovement_36c33:
	db NORTH, RUN_3
	db $ff

Func_36c36:
	ld a, $02
	farcall SetOWScrollState
	ld a, [wPlayerOWObject]
	farcall ResetOWObjectFlag5_WithID
	farcall GetOWObjectTilePosition
	ld e, $0f
	farcall SetOWObjectTilePosition
	farcall SetOWObjectSpriteAnimFlag6
	ld a, $e8
	ld de, $60f
	farcall SetOWObjectTilePosition
	farcall SetOWObjectSpriteAnimFlag6
	xor a
	start_script
	play_sfx SFX_88
	set_sprite_frameset NPC_STRONGHOLD_PLATFORM, FRAMESET_156
	move_player NPCMovement_36c95, FALSE
	move_npc NPC_STRONGHOLD_PLATFORM, NPCMovement_36c95
	wait_for_player_animation
	move_player NPCMovement_36c98, FALSE
	move_npc NPC_STRONGHOLD_PLATFORM, NPCMovement_36c98
	wait_for_player_animation
	do_frames 30
	scroll_to_player
	animate_player_movement $02, $01
	unload_npc NPC_STRONGHOLD_PLATFORM
	load_npc NPC_STRONGHOLD_PLATFORM, 6, 3, SOUTH
	end_script
	ld a, [wPlayerOWObject]
	farcall SetOWObjectFlag5_WithID
	ld a, $00
	ld [wd582], a
	ret
NPCMovement_36c95:
	db SOUTH, RUN_3
	db $ff
NPCMovement_36c98:
	db SOUTH, MOVE_1
	db $ff

PsychicStrongholdMami_MapHeader:
	db MAP_GFX_PSYCHIC_STRONGHOLD_MAMI
	dba PsychicStrongholdMami_MapScripts
	db MUSIC_FORT_2

PsychicStrongholdMami_StepEvents:
	_ow_coordinate_function 7, 10, 109, 7, 3, 2, Func_36f7f
	_ow_coordinate_function 8, 10, 109, 8, 3, 2, Func_36f7f
	db $ff

PsychicStrongholdMami_NPCs:
	npc NPC_MAMI, 7, 2, NORTH, $0
	npc NPC_ROD, 8, 2, SOUTH, Func_36e03
	npc NPC_STRONGHOLD_PLATFORM, 6, 10, SOUTH, $0
	db $ff

PsychicStrongholdMami_NPCInteractions:
	npc_script NPC_MAMI, Func_36e18
	npc_script NPC_ROD, Func_36de8
	db $ff

PsychicStrongholdMami_MapScripts:
	dbw $06, Func_36ce5
	dbw $08, Func_36d21
	dbw $12, Func_36d29
	dbw $09, Func_36d65
	dbw $07, Func_36cec
	dbw $02, Func_36cf5
	dbw $0f, Func_36d1e
	db $ff

Func_36ce5:
	ld hl, PsychicStrongholdMami_StepEvents
	call Func_324d
	ret

Func_36cec:
	ld hl, PsychicStrongholdMami_NPCs
	call Func_3205
	scf
	ccf
	ret

Func_36cf5:
	ld bc, $5f
	ld a, $02
	farcall SetwD896
	ld a, $0a
	ld [wd582], a
	ld a, $0d
	ld [wd592], a
	ld hl, $6f43
	ld a, l
	ld [wd593], a
	ld a, h
	ld [$d594], a
	ld a, $e8
	ld bc, $156
	farcall SetAndInitOWObjectFrameset
	scf
	ret

Func_36d1e:
	scf
	ccf
	ret

Func_36d21:
	ld hl, PsychicStrongholdMami_NPCInteractions
	call Func_328c
	scf
	ret

Func_36d29:
	ld a, [wPlayerOWObject]
	farcall GetOWObjectTilePosition
	ld a, e
	cp $07
	jr c, .asm_36d51
	ld a, d
	cp $05
	jr c, .asm_36d51
	jr z, .asm_36d4b
	cp $07
	jr nc, .asm_36d51
	ld a, $e8
	ld bc, $157
	farcall SetOWObjectFrameset
	jr .asm_36d51
.asm_36d4b
	ld a, $e8
	farcall ResetOWObjectSpriteAnimFlag6
.asm_36d51
	farcall Func_c1a6
	ld a, $e8
	ld bc, $155
	farcall SetOWObjectFrameset
	farcall SetOWObjectSpriteAnimFlag6
	scf
	ccf
	ret

Func_36d65:
	ld hl, PsychicStrongholdMami_AfterDuelScripts
	ld a, [wScriptNPC]
	call Func_344c
	scf
	ret

PsychicStrongholdMami_AfterDuelScripts:
	npc_script NPC_MAMI, Func_36e9b
	db $ff

Script_36d75:
	set_event EVENT_GOT_MEW_COIN
	print_npc_text Text1117
	give_coin COIN_MEW
	check_event EVENT_GOT_SNORLAX_COIN
	print_variable_npc_text Text1118, Text1119
	script_command_02
	script_jump .ows_36d87

.ows_36d87
	set_event EVENT_FREED_ROD
	set_var VAR_28, $04
	set_active_npc_direction EAST
	set_npc_direction NPC_ROD, WEST
	script_command_01
	print_npc_text Text111a
	set_active_npc NPC_ROD, DialogRodText
	print_npc_text Text111b
	set_active_npc NPC_MAMI, DialogMamiText
	print_npc_text Text111c
	script_command_02
	set_active_npc_direction SOUTH
	script_command_01
	set_active_npc NPC_ROD, DialogRodText
	print_npc_text Text111d
	script_command_02
	get_player_direction
	compare_loaded_var $01
	script_jump_if_b0nz .ows_36dba
	set_player_direction EAST
	script_jump .ows_36dc0

.ows_36dba
	animate_player_movement $02, $01
	animate_player_movement $01, $01
.ows_36dc0
	animate_active_npc_movement $02, $01
	set_active_npc_direction WEST
	script_command_01
	print_npc_text Text111e
	receive_card DRAGONITE_LV43
	print_npc_text Text111f
	script_command_02
	set_player_direction SOUTH
	move_active_npc NPCMovement_36de5
	wait_for_player_animation
	unload_npc NPC_ROD
	set_player_direction NORTH
	script_command_01
	set_active_npc NPC_MAMI, DialogMamiText
	print_npc_text Text1120
	script_command_02
	end_script
	ret

NPCMovement_36de5:
	db SOUTH, MOVE_7
	db $ff

Func_36de8:
	ld a, NPC_ROD
	ld [wScriptNPC], a
	ld hl, $9f7
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	print_npc_text Text1121
	script_command_02
	end_script
	ret

Func_36e03:
	ld a, EVENT_MET_MAMI_AND_ROD
	farcall GetEventValue
	jr z, .asm_36e16
	ld a, EVENT_FREED_ROD
	farcall GetEventValue
	jr nz, .asm_36e16
	scf
	ccf
	ret
.asm_36e16
	scf
	ret

Func_36e18:
	ld a, NPC_MAMI
	ld [wScriptNPC], a
	ld hl, $a21
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	check_event EVENT_BEAT_MAMI
	script_jump_if_b0z .ows_36e82
	check_event EVENT_TALKED_TO_MAMI
	script_jump_if_b0z .ows_36e4d
	set_event EVENT_TALKED_TO_MAMI
	print_npc_text Text1122
	npc_ask_question Text1123, TRUE
	script_jump_if_b0z .ows_36e47
	script_call .ows_36e61
.ows_36e47
	print_npc_text Text1124
	script_jump .ows_36e6c
.ows_36e4d
	print_npc_text Text1125
	npc_ask_question Text1123, TRUE
	script_jump_if_b0z .ows_36e5b
	script_call .ows_36e61
.ows_36e5b
	print_npc_text Text1126
	script_jump .ows_36e6c
.ows_36e61
	print_npc_text Text1127
	npc_ask_question Text1123, TRUE
	script_jump_if_b0nz .ows_36e61
	script_ret
.ows_36e6c
	ask_question Text1128, TRUE
	script_jump_if_b0z .ows_36e7c
	print_npc_text Text1129
	script_command_02
	start_duel SPIRITED_AWAY_DECK_ID, MUSIC_DITTY_1
	end_script
	ret
.ows_36e7c
	print_npc_text Text112a
	script_command_02
	end_script
	ret
.ows_36e82
	print_npc_text Text112b
	ask_question Text1128, TRUE
	script_jump_if_b0z .ows_36e95
	print_npc_text Text1129
	script_command_02
	start_duel SPIRITED_AWAY_DECK_ID, MUSIC_DITTY_1
	end_script
	ret
.ows_36e95
	print_npc_text Text112c
	script_command_02
	end_script
	ret

Func_36e9b:
	xor a
	start_script
	script_command_01
	check_event EVENT_BEAT_MAMI
	script_jump_if_b0z .ows_36ec0
	check_event EVENT_SET_UNTIL_MAP_RELOAD_2
	script_jump_if_b0nz .ows_36eba
	set_event EVENT_BEAT_MAMI
	set_var VAR_30, $04
	reset_event EVENT_TALKED_TO_RYOKO
	print_npc_text Text112d
	give_booster_packs BoosterList_cda2
	script_jump Script_36d75
.ows_36eba
	print_npc_text Text112e
	script_command_02
	end_script
	ret
.ows_36ec0
	check_event EVENT_SET_UNTIL_MAP_RELOAD_2
	script_jump_if_b0nz .ows_36ed1
	print_npc_text Text112f
	give_booster_packs BoosterList_cda2
	print_npc_text Text1130
	script_jump .ows_36ed4
.ows_36ed1
	print_npc_text Text1131
.ows_36ed4
	script_command_02
	end_script
	ret

Func_36ed7:
	xor a
	start_script
	set_event EVENT_MET_MAMI_AND_ROD
	move_player NPCMovement_36f40, TRUE
	wait_for_player_animation
	script_command_01
	set_active_npc NPC_MAMI, DialogMamiText
	print_npc_text Text1132
	script_command_02
	do_frames 30
	set_active_npc_direction SOUTH
	script_command_01
	print_npc_text Text1133
	script_command_02
	set_active_npc_direction NORTH
	do_frames 30
	play_sfx_and_wait SFX_9D
	do_frames 30
	play_sfx_and_wait SFX_9D
	do_frames 30
	play_sfx_and_wait SFX_9D
	do_frames 30
	play_sfx_and_wait SFX_9E
	do_frames 30
	play_sfx_and_wait SFX_05
	play_sfx SFX_86
	load_npc NPC_WARP_SPARKLES, 8, 2, SOUTH
	wait_for_npc_animation NPC_WARP_SPARKLES
	load_npc NPC_ROD, 8, 2, SOUTH
	unload_npc NPC_WARP_SPARKLES
	do_frames 60
	set_active_npc NPC_ROD, DialogRodText
	set_active_npc_direction WEST
	script_command_01
	print_npc_text Text1134
	set_active_npc NPC_MAMI, DialogMamiText
	set_active_npc_direction EAST
	print_npc_text Text1135
	script_command_02
	set_active_npc_direction SOUTH
	do_frames 30
	script_command_01
	print_npc_text Text1136
	script_command_02
	end_script
	ld a, $00
	ld [wd582], a
	ret
NPCMovement_36f40:
	db NORTH, MOVE_4
	db $ff

Func_36f43:
	call WaitPalFading
	xor a
	start_script
	animate_player_movement $00, $01
	end_script
	ld a, $e8
	ld bc, $155
	farcall SetAndInitOWObjectFrameset
	farcall StartOWObjectAnimation
	ld a, EVENT_MET_MAMI_AND_ROD
	farcall GetEventValue
	jr z, .asm_36f69
	ld a, $00
	ld [wd582], a
	ret
.asm_36f69
	ld a, $0a
	ld [wd582], a
	ld a, $0d
	ld [wd592], a
	ld hl, $6ed7
	ld a, l
	ld [wd593], a
	ld a, h
	ld [$d594], a
	ret

Func_36f7f:
	push af
	push bc
	push de
	push hl
	ld a, $e8
	ld bc, $156
	farcall SetAndInitOWObjectFrameset
	ld a, $1e
	call WaitAFrames
	pop hl
	pop de
	pop bc
	pop af
	farcall Func_d3c4
	ret

ColorlessAltar_MapHeader:
	db MAP_GFX_COLORLESS_ALTAR
	dba ColorlessAltar_MapScripts
	db MUSIC_FORT_4

ColorlessAltar_StepEvents:
	map_exit 5, 11, MAP_COLORLESS_ALTAR_ENTRANCE, 4, 1, SOUTH
	map_exit 6, 11, MAP_COLORLESS_ALTAR_ENTRANCE, 5, 1, SOUTH
	db $ff

ColorlessAltar_NPCs:
	npc NPC_NISHIJIMA, 6, 6, NORTH, $0
	npc NPC_ISHII, 6, 3, NORTH, $0
	npc NPC_SAMEJIMA, 5, 4, SOUTH, $0
	db $ff

ColorlessAltar_NPCInteractions:
	npc_script NPC_NISHIJIMA, Func_37082
	npc_script NPC_ISHII, Func_37179
	npc_script NPC_SAMEJIMA, Func_3728d
	db $ff

ColorlessAltar_MapScripts:
	dbw $06, Func_36fe2
	dbw $08, Func_37011
	dbw $09, Func_37019
	dbw $07, Func_36fe9
	dbw $02, Func_36ff2
	db $ff

Func_36fe2:
	ld hl, ColorlessAltar_StepEvents
	call Func_324d
	ret

Func_36fe9:
	ld hl, ColorlessAltar_NPCs
	call Func_3205
	scf
	ccf
	ret

Func_36ff2:
	farcall Func_1f293
	ld a, EVENT_MET_COLORLESS_ALTAR_MEMBERS
	farcall GetEventValue
	jr nz, .asm_3700f
	ld a, $52
	ld de, $506
	farcall SetOWObjectTilePosition
	ld a, $52
	ld b, $00
	farcall SetOWObjectDirection
.asm_3700f
	scf
	ret

Func_37011:
	ld hl, ColorlessAltar_NPCInteractions
	call Func_328c
	scf
	ret

Func_37019:
	ld hl, ColorlessAltar_AfterDuelScripts
	ld a, [wScriptNPC]
	call Func_344c
	scf
	ret

ColorlessAltar_AfterDuelScripts:
	npc_script NPC_NISHIJIMA, Func_3713b
	npc_script NPC_ISHII, Func_3724a
	npc_script NPC_SAMEJIMA, Func_37329
	db $ff

Script_37031:
	set_event EVENT_MET_COLORLESS_ALTAR_MEMBERS
	set_active_npc NPC_SAMEJIMA, DialogSamejimaText
	set_active_npc_direction SOUTH
	print_npc_text Text0f57
	set_npc_direction NPC_NISHIJIMA, SOUTH
	print_npc_text Text0f58
	script_command_02
	do_frames 30
	set_active_npc_direction NORTH
	script_command_01
	print_npc_text Text0f59
	set_active_npc NPC_ISHII, DialogIshiiText
	print_npc_text Text0f5a
	script_command_02
	set_active_npc_direction SOUTH
	do_frames 30
	set_npc_direction NPC_SAMEJIMA, SOUTH
	script_command_01
	set_active_npc NPC_SAMEJIMA, DialogSamejimaText
	print_npc_text Text0f5b
	script_command_02
	move_active_npc NPCMovement_3706c
	wait_for_player_animation
	set_npc_direction NPC_ISHII, NORTH
	end_script
	ret

NPCMovement_3706c:
	db NORTH, MOVE_2
	db SOUTH, MOVE_0
	db $ff

Script_37071:
	set_event EVENT_GOT_SNORLAX_COIN
	print_npc_text Text0f5c
	give_coin COIN_SNORLAX
	check_event EVENT_GOT_MEW_COIN
	print_variable_npc_text Text0f5d, Text0f5e
	script_command_02
	end_script
	ret

Func_37082:
	ld a, NPC_NISHIJIMA
	ld [wScriptNPC], a
	ld hl, $a22
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	check_event EVENT_MET_COLORLESS_ALTAR_MEMBERS
	script_jump_if_b0nz Script_37031
	get_player_opposite_direction
	restore_active_npc_direction
	check_event EVENT_BEAT_NISHIJIMA
	script_jump_if_b0z .ows_370ef
	check_event EVENT_TALKED_TO_NISHIJIMA_2
	script_jump_if_b0z .ows_370c3
	check_event EVENT_TALKED_TO_NISHIJIMA
	script_jump_if_b0z .ows_370b9
	set_event EVENT_TALKED_TO_NISHIJIMA
	set_event EVENT_TALKED_TO_NISHIJIMA_2
	duel_requirement_check DUEL_REQUIREMENT_NISHIJIMA_REROLL
	print_npc_text Text0f5f
	script_jump .ows_370c8
.ows_370b9
	set_event EVENT_TALKED_TO_NISHIJIMA_2
	duel_requirement_check DUEL_REQUIREMENT_NISHIJIMA_REROLL
	print_npc_text Text0f60
	script_jump .ows_370c8
.ows_370c3
	duel_requirement_check DUEL_REQUIREMENT_NISHIJIMA_USE
	print_npc_text Text0f61
.ows_370c8
	ask_question Text0f62, TRUE
	script_jump_if_b0z .ows_370e6
	duel_requirement_check DUEL_REQUIREMENT_NISHIJIMA_USE
	script_jump_if_b1z .ows_370dd
	print_npc_text Text0f63
	print_npc_text Text0f64
	script_jump .ows_370ec
.ows_370dd
	print_npc_text Text0f65
	script_command_02
	start_duel SNORLAX_GUARD_DECK_ID, MUSIC_DITTY_1
	end_script
	ret
.ows_370e6
	print_npc_text Text0f66
	print_npc_text Text0f64
.ows_370ec
	script_command_02
	end_script
	ret
.ows_370ef
	check_event EVENT_TALKED_TO_NISHIJIMA_2
	script_jump_if_b0z .ows_3710f
	check_event EVENT_TALKED_TO_NISHIJIMA
	script_jump_if_b0z .ows_37105
	set_event EVENT_TALKED_TO_NISHIJIMA
	set_event EVENT_TALKED_TO_NISHIJIMA_2
	duel_requirement_check DUEL_REQUIREMENT_NISHIJIMA_REROLL
	print_npc_text Text0f67
	script_jump .ows_37114
.ows_37105
	set_event EVENT_TALKED_TO_NISHIJIMA_2
	duel_requirement_check DUEL_REQUIREMENT_NISHIJIMA_REROLL
	print_npc_text Text0f68
	script_jump .ows_37114
.ows_3710f
	duel_requirement_check DUEL_REQUIREMENT_NISHIJIMA_USE
	print_npc_text Text0f69
.ows_37114
	ask_question Text0f62, TRUE
	script_jump_if_b0z .ows_37132
	duel_requirement_check DUEL_REQUIREMENT_NISHIJIMA_USE
	script_jump_if_b1z .ows_37129
	print_npc_text Text0f6a
	print_npc_text Text0f64
	script_jump .ows_37138
.ows_37129
	print_npc_text Text0f6b
	script_command_02
	start_duel SNORLAX_GUARD_DECK_ID, MUSIC_DITTY_1
	end_script
	ret
.ows_37132
	print_npc_text Text0f6c
	print_npc_text Text0f64
.ows_37138
	script_command_02
	end_script
	ret

Func_3713b:
	xor a
	start_script
	script_command_01
	reset_event EVENT_TALKED_TO_NISHIJIMA_2
	check_event EVENT_BEAT_NISHIJIMA
	script_jump_if_b0z .ows_37162
	check_event EVENT_SET_UNTIL_MAP_RELOAD_2
	script_jump_if_b0nz .ows_3715c
	set_event EVENT_BEAT_NISHIJIMA
	reset_event EVENT_TALKED_TO_NISHIJIMA
	print_npc_text Text0f6d
	give_booster_packs BoosterList_cda6
	print_npc_text Text0f6e
	script_jump .ows_3715f
.ows_3715c
	print_npc_text Text0f6f
.ows_3715f
	script_command_02
	end_script
	ret
.ows_37162
	check_event EVENT_SET_UNTIL_MAP_RELOAD_2
	script_jump_if_b0nz .ows_37173
	print_npc_text Text0f70
	give_booster_packs BoosterList_cda6
	print_npc_text Text0f71
	script_jump .ows_37176
.ows_37173
	print_npc_text Text0f72
.ows_37176
	script_command_02
	end_script
	ret

Func_37179:
	ld a, NPC_ISHII
	ld [wScriptNPC], a
	ld hl, $a24
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	get_player_opposite_direction
	restore_active_npc_direction
	check_event EVENT_BEAT_ISHII
	script_jump_if_b0z .ows_371f7
	check_event EVENT_TALKED_TO_ISHII_2
	script_jump_if_b0z .ows_371d1
	check_event EVENT_TALKED_TO_ISHII
	script_jump_if_b0z .ows_371c7
	set_event EVENT_TALKED_TO_ISHII
	set_event EVENT_TALKED_TO_ISHII_2
	duel_requirement_check DUEL_REQUIREMENT_ISHII_REROLL
	print_npc_text Text0f73
	script_command_02
	get_active_npc_direction
	reset_npc_flag6 NPC_ISHII
	load_npc NPC_GR_2, 6, 3, NORTH
	restore_npc_direction NPC_GR_2
	script_command_01
	print_npc_text Text0f74
	script_command_02
	spin_npc NPC_GR_2, 519
	unload_npc NPC_GR_2
	set_npc_flag6 NPC_ISHII
	script_command_01
	print_npc_text Text0f75
	script_jump .ows_371d6
.ows_371c7
	set_event EVENT_TALKED_TO_ISHII_2
	duel_requirement_check DUEL_REQUIREMENT_ISHII_REROLL
	print_npc_text Text0f76
	script_jump .ows_371d6
.ows_371d1
	duel_requirement_check DUEL_REQUIREMENT_ISHII_USE
	print_npc_text Text0f77
.ows_371d6
	ask_question Text0f78, TRUE
	script_jump_if_b0z .ows_371f1
	duel_requirement_check DUEL_REQUIREMENT_ISHII_USE
	script_jump_if_b1z .ows_371e8
	print_npc_text Text0f79
	script_jump .ows_371f4
.ows_371e8
	print_npc_text Text0f7a
	script_command_02
	start_duel EYE_OF_THE_STORM_DECK_ID, MUSIC_DITTY_1
	end_script
	ret
.ows_371f1
	print_npc_text Text0f7b
.ows_371f4
	script_command_02
	end_script
	ret
.ows_371f7
	check_event EVENT_BEAT_COLORLESS_ALTAR_MEMBERS
	script_jump_if_b0nz .ows_37204
	check_event EVENT_GOT_SNORLAX_COIN
	script_jump_if_b0z .ows_37204
	script_jump Script_37071
.ows_37204
	check_event EVENT_TALKED_TO_ISHII_2
	script_jump_if_b0z .ows_37224
	check_event EVENT_TALKED_TO_ISHII
	script_jump_if_b0z .ows_3721a
	set_event EVENT_TALKED_TO_ISHII
	set_event EVENT_TALKED_TO_ISHII_2
	duel_requirement_check DUEL_REQUIREMENT_ISHII_REROLL
	print_npc_text Text0f7c
	script_jump .ows_37229
.ows_3721a
	set_event EVENT_TALKED_TO_ISHII_2
	duel_requirement_check DUEL_REQUIREMENT_ISHII_REROLL
	print_npc_text Text0f7d
	script_jump .ows_37229
.ows_37224
	duel_requirement_check DUEL_REQUIREMENT_ISHII_USE
	print_npc_text Text0f7e
.ows_37229
	ask_question Text0f78, TRUE
	script_jump_if_b0z .ows_37244
	duel_requirement_check DUEL_REQUIREMENT_ISHII_USE
	script_jump_if_b1z .ows_3723b
	print_npc_text Text0f7f
	script_jump .ows_37247
.ows_3723b
	print_npc_text Text0f80
	script_command_02
	start_duel EYE_OF_THE_STORM_DECK_ID, MUSIC_DITTY_1
	end_script
	ret
.ows_37244
	print_npc_text Text0f81
.ows_37247
	script_command_02
	end_script
	ret

Func_3724a:
	xor a
	start_script
	script_command_01
	reset_event EVENT_TALKED_TO_ISHII_2
	check_event EVENT_BEAT_ISHII
	script_jump_if_b0z .ows_37276
	check_event EVENT_SET_UNTIL_MAP_RELOAD_2
	script_jump_if_b0nz .ows_37270
	set_event EVENT_BEAT_ISHII
	reset_event EVENT_TALKED_TO_ISHII
	print_npc_text Text0f82
	give_booster_packs BoosterList_cdaa
	check_event EVENT_BEAT_COLORLESS_ALTAR_MEMBERS
	script_jump_if_b0z Script_37071
	print_npc_text Text0f83
	script_jump .ows_37273
.ows_37270
	print_npc_text Text0f84
.ows_37273
	script_command_02
	end_script
	ret
.ows_37276
	check_event EVENT_SET_UNTIL_MAP_RELOAD_2
	script_jump_if_b0nz .ows_37287
	print_npc_text Text0f85
	give_booster_packs BoosterList_cdaa
	print_npc_text Text0f86
	script_jump .ows_3728a
.ows_37287
	print_npc_text Text0f87
.ows_3728a
	script_command_02
	end_script
	ret

Func_3728d:
	ld a, NPC_SAMEJIMA
	ld [wScriptNPC], a
	ld hl, $a23
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	check_event EVENT_MET_COLORLESS_ALTAR_MEMBERS
	script_jump_if_b0nz Script_37031
	get_player_opposite_direction
	restore_active_npc_direction
	check_event EVENT_BEAT_SAMEJIMA
	script_jump_if_b0z .ows_372f4
	check_event EVENT_TALKED_TO_SAMEJIMA_2
	script_jump_if_b0z .ows_372ce
	check_event EVENT_TALKED_TO_SAMEJIMA
	script_jump_if_b0z .ows_372c4
	set_event EVENT_TALKED_TO_SAMEJIMA
	set_event EVENT_TALKED_TO_SAMEJIMA_2
	duel_requirement_check DUEL_REQUIREMENT_SAMEJIMA_REROLL
	print_npc_text Text0f88
	script_jump .ows_372d3
.ows_372c4
	set_event EVENT_TALKED_TO_SAMEJIMA_2
	duel_requirement_check DUEL_REQUIREMENT_SAMEJIMA_REROLL
	print_npc_text Text0f89
	script_jump .ows_372d3
.ows_372ce
	duel_requirement_check DUEL_REQUIREMENT_SAMEJIMA_USE
	print_npc_text Text0f8a
.ows_372d3
	ask_question Text0f8b, TRUE
	script_jump_if_b0z .ows_372ee
	duel_requirement_check DUEL_REQUIREMENT_SAMEJIMA_USE
	script_jump_if_b1z .ows_372e5
	print_npc_text Text0f8c
	script_jump .ows_372f1
.ows_372e5
	print_npc_text Text0f8d
	script_command_02
	start_duel SUDDEN_GROWTH_DECK_ID, MUSIC_DITTY_1
	end_script
	ret
.ows_372ee
	print_npc_text Text0f8e
.ows_372f1
	script_command_02
	end_script
	ret
.ows_372f4
	check_event EVENT_TALKED_TO_SAMEJIMA_2
	script_jump_if_b0z .ows_37303
	set_event EVENT_TALKED_TO_SAMEJIMA_2
	duel_requirement_check DUEL_REQUIREMENT_SAMEJIMA_REROLL
	print_npc_text Text0f8f
	script_jump .ows_37308
.ows_37303
	duel_requirement_check DUEL_REQUIREMENT_SAMEJIMA_USE
	print_npc_text Text0f90
.ows_37308
	ask_question Text0f8b, TRUE
	script_jump_if_b0z .ows_37323
	duel_requirement_check DUEL_REQUIREMENT_SAMEJIMA_USE
	script_jump_if_b1z .ows_3731a
	print_npc_text Text0f91
	script_jump .ows_37326
.ows_3731a
	print_npc_text Text0f92
	script_command_02
	start_duel SUDDEN_GROWTH_DECK_ID, MUSIC_DITTY_1
	end_script
	ret
.ows_37323
	print_npc_text Text0f93
.ows_37326
	script_command_02
	end_script
	ret

Func_37329:
	xor a
	start_script
	script_command_01
	reset_event EVENT_TALKED_TO_SAMEJIMA_2
	check_event EVENT_BEAT_SAMEJIMA
	script_jump_if_b0z .ows_3734e
	check_event EVENT_SET_UNTIL_MAP_RELOAD_2
	script_jump_if_b0nz .ows_37348
	set_event EVENT_BEAT_SAMEJIMA
	print_npc_text Text0f94
	give_booster_packs BoosterList_cdae
	print_npc_text Text0f95
	script_jump .ows_3734b
.ows_37348
	print_npc_text Text0f96
.ows_3734b
	script_command_02
	end_script
	ret
.ows_3734e
	check_event EVENT_SET_UNTIL_MAP_RELOAD_2
	script_jump_if_b0nz .ows_3735f
	print_npc_text Text0f97
	give_booster_packs BoosterList_cdae
	print_npc_text Text0f98
	script_jump .ows_37362
.ows_3735f
	print_npc_text Text0f99
.ows_37362
	script_command_02
	end_script
	ret

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
	npc NPC_GR_CLERK_CASTLE_RIGHT, 7, 3, SOUTH, $0
	npc NPC_GR_CLERK_CASTLE_LEFT, 3, 3, SOUTH, $0
	db $ff

GrCastleEntrance_NPCInteractions:
	npc_script NPC_GR_CLERK_CASTLE_RIGHT, Func_37493
	npc_script NPC_GR_CLERK_CASTLE_LEFT, Func_37534
	db $ff

GrCastleEntrance_OWInteractions:
	ow_script 4, 3, Func_37480
	ow_script 5, 3, Func_37480
	ow_script 6, 3, Func_37480
	db $ff

GrCastleEntrance_MapScripts:
	dbw $00, Func_373cb
	dbw $06, Func_3740f
	dbw $08, Func_3746b
	dbw $07, Func_37416
	dbw $02, Func_3741f
	dbw $09, Func_3747b
	db $ff

Func_373cb:
	call Func_3332
	ld a, EVENT_GR_CASTLE_ENTRANCE_DOOR_STATE
	farcall GetEventValue
	jr z, .asm_37409
	ld a, [wPlayerOWObject]
	farcall GetOWObjectTilePosition
	ld a, $03
	cp e
	jr nz, .asm_37409
	ldh a, [hKeysHeld]
	bit 6, a
	jr z, .asm_37409
	inc d
	inc d
	ld e, $0e
	ld b, $00
	ld a, $72
	farcall Func_d3c4
	ld a, [wPlayerOWObject]
	farcall ResetOWObjectFlag5_WithID
	farcall StartOWObjectAnimation
	ld b, $00
	ld c, $01
	farcall Func_10e3c
	jr .asm_3740c
.asm_37409
	call Func_32d8
.asm_3740c
	scf
	ccf
	ret

Func_3740f:
	ld hl, GrCastleEntrance_StepEvents
	call Func_324d
	ret

Func_37416:
	ld hl, GrCastleEntrance_NPCs
	call Func_3205
	scf
	ccf
	ret

Func_3741f:
	ld a, EVENT_GR_CASTLE_ENTRANCE_DOOR_STATE
	farcall GetEventValue
	jr nz, .asm_37469
	ld bc, $b4
	ld de, FlushPalette
	farcall Func_12c0ce
	ld a, EVENT_INSERTED_RIGHT_COIN_IN_GR_CASTLE_DOOR
	farcall GetEventValue
	jr z, .asm_3744d
	ld bc, $188
	farcall GetPalettesWithID
	ld a, $e6
	ld de, FlushPalette
	ld b, $02
	farcall LoadOWObjectInMap
	jr .asm_37469
.asm_3744d
	ld a, EVENT_INSERTED_LEFT_COIN_IN_GR_CASTLE_DOOR
	farcall GetEventValue
	jr z, .asm_37469
	ld bc, $189
	farcall GetPalettesWithID
	ld a, $e7
	ld de, $602
	ld b, $02
	farcall LoadOWObjectInMap
	jr .asm_37469
.asm_37469
	scf
	ret

Func_3746b:
	ld hl, GrCastleEntrance_NPCInteractions
	call Func_328c
	jr nc, .asm_37479
	ld hl, GrCastleEntrance_OWInteractions
	call Func_32bf
.asm_37479
	scf
	ret

Func_3747b:
	call Func_344da
	scf
	ret

Func_37480:
	ld a, EVENT_GR_CASTLE_ENTRANCE_DOOR_STATE
	farcall GetEventValue
	jr nz, .asm_37490 ; this jump target is likely a bug. should jump to 'ret'
	xor a
	start_script
	script_command_01
	print_text DoorsAreShutText
.asm_37490
	script_command_02
	end_script
	ret

Func_37493:
	ld a, NPC_GR_CLERK_CASTLE_RIGHT
	ld [wScriptNPC], a
	ld hl, $a5a
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	check_event EVENT_GR_CASTLE_ENTRANCE_DOOR_STATE
	script_jump_if_b0z Script_375d5
	check_event EVENT_INSERTED_LEFT_COIN_IN_GR_CASTLE_DOOR
	script_jump_if_b0z .ows_3752e
	check_event EVENT_GOT_MEW_COIN
	script_jump_if_b0z .ows_374bd
	print_npc_text Text08e2
	script_command_02
	end_script
	ret
.ows_374bd
	print_npc_text Text08e3
	ask_question Text08e4, TRUE
	script_jump_if_b0z .ows_3751e
	set_event EVENT_INSERTED_LEFT_COIN_IN_GR_CASTLE_DOOR
	print_npc_text Text08e5
	script_command_02
	get_player_direction
	compare_loaded_var $01
	script_jump_if_b0z .ows_374d8
	set_player_direction NORTH
	animate_player_movement $82, $02
.ows_374d8
	move_active_npc .NPCMovement_37524
	wait_for_player_animation
	do_frames 30
	play_sfx SFX_02
	check_event EVENT_GR_CASTLE_ENTRANCE_DOOR_STATE
	script_jump_if_b0z .ows_374f8
	load_palette PALETTE_189
	load_npc NPC_PURPLE_CASTLE_COIN, 6, 2, SOUTH
	do_frames 30
	set_active_npc_direction SOUTH
	script_command_01
	print_npc_text Text08e6
	script_jump .ows_3750d
.ows_374f8
	play_sfx SFX_0F
	load_tilemap TILEMAP_0B5, $04, $02
	unload_npc NPC_WHITE_CASTLE_COIN
	do_frames 30
	set_active_npc_direction SOUTH
	script_command_01
	print_npc_text Text08e6
	script_call Script_375db
.ows_3750d
	script_command_02
	move_active_npc .NPCMovement_37529
	wait_for_player_animation
	end_script
	ld a, EVENT_GR_CASTLE_ENTRANCE_DOOR_STATE
	farcall GetEventValue
	ret z
	call Func_3448d
	ret
.ows_3751e
	print_npc_text Text08e7
	script_command_02
	end_script
	ret

.NPCMovement_37524:
	db WEST, MOVE_1
	db NORTH, MOVE_0
	db $ff

.NPCMovement_37529:
	db EAST, MOVE_1
	db SOUTH, MOVE_0
	db $ff

.ows_3752e
	print_npc_text Text08e8
	script_command_02
	end_script
	ret

Func_37534:
	ld a, NPC_GR_CLERK_CASTLE_LEFT
	ld [wScriptNPC], a
	ld hl, $a5a
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	check_event EVENT_GR_CASTLE_ENTRANCE_DOOR_STATE
	script_jump_if_b0z Script_375d5
	check_event EVENT_INSERTED_RIGHT_COIN_IN_GR_CASTLE_DOOR
	script_jump_if_b0z .ows_375cf
	check_event EVENT_GOT_SNORLAX_COIN
	script_jump_if_b0z .ows_3755e
	print_npc_text Text08e9
	script_command_02
	end_script
	ret
.ows_3755e
	print_npc_text Text08ea
	ask_question Text08eb, TRUE
	script_jump_if_b0z .ows_375bf
	set_event EVENT_INSERTED_RIGHT_COIN_IN_GR_CASTLE_DOOR
	print_npc_text Text08e5
	script_command_02
	get_player_direction
	compare_loaded_var $03
	script_jump_if_b0z .ows_37579
	set_player_direction NORTH
	animate_player_movement $82, $02
.ows_37579
	move_active_npc .NPCMovement_375c5
	wait_for_player_animation
	do_frames 30
	play_sfx SFX_02
	check_event EVENT_GR_CASTLE_ENTRANCE_DOOR_STATE
	script_jump_if_b0z .ows_37599
	load_palette PALETTE_188
	load_npc NPC_WHITE_CASTLE_COIN, 4, 2, SOUTH
	do_frames 30
	set_active_npc_direction SOUTH
	script_command_01
	print_npc_text Text08ec
	script_jump .ows_375ae
.ows_37599
	play_sfx SFX_0F
	load_tilemap TILEMAP_0B5, $04, $02
	unload_npc NPC_PURPLE_CASTLE_COIN
	do_frames 30
	set_active_npc_direction SOUTH
	script_command_01
	print_npc_text Text08ec
	script_call Script_375db
.ows_375ae
	script_command_02
	move_active_npc .NPCMovement_375ca
	wait_for_player_animation
	end_script
	ld a, EVENT_GR_CASTLE_ENTRANCE_DOOR_STATE
	farcall GetEventValue
	ret z
	call Func_3448d
	ret

.ows_375bf
	print_npc_text Text08ed
	script_command_02
	end_script
	ret

.NPCMovement_375c5:
	db EAST, MOVE_1
	db NORTH, MOVE_0
	db $ff

.NPCMovement_375ca:
	db WEST, MOVE_1
	db SOUTH, MOVE_0
	db $ff

.ows_375cf
	print_npc_text Text08ee
	script_command_02
	end_script
	ret

Script_375d5:
	print_npc_text Text08ef
	script_command_02
	end_script
	ret

Script_375db:
	print_npc_text Text08f0
	script_ret

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
	ow_script 6, 5, Func_37a5f
	ow_script 7, 5, Func_37a5f
	ow_script 8, 5, Func_37a5f
	db $ff

GrCastle_NPCs:
	npc NPC_KANZAKI, 9, 9, WEST, $0
	npc NPC_RUI, 5, 9, EAST, $0
	db $ff

GrCastle_NPCInteractions:
	npc_script NPC_KANZAKI, Func_37809
	npc_script NPC_RUI, Func_3792d
	db $ff

GrCastle_MapScripts:
	dbw $06, Func_3765c
	dbw $08, Func_376ed
	dbw $09, Func_376f5
	dbw $07, Func_37663
	dbw $02, Func_3766c
	db $ff

Func_3765c:
	ld hl, GrCastle_StepEvents
	call Func_324d
	ret

Func_37663:
	ld hl, GrCastle_NPCs
	call Func_3205
	scf
	ccf
	ret

Func_3766c:
	ld a, [wd584]
	cp $71
	jr nz, .asm_37677
	farcall Func_1f293
.asm_37677
	ld a, EVENT_MET_BIRURITCHI_AND_ADMINS
	farcall GetEventValue
	jr z, .asm_37691
	ld a, EVENT_BEAT_KANZAKI
	farcall GetEventValue
	jr z, .asm_376bc
	ld a, EVENT_BEAT_RUI
	farcall GetEventValue
	jr z, .asm_376cd
	jr .asm_376eb
.asm_37691
	ld a, $53
	ld de, $803
	farcall SetOWObjectTilePosition
	ld b, $02
	farcall SetOWObjectDirection
	ld a, $54
	ld de, $603
	farcall SetOWObjectTilePosition
	ld b, $02
	farcall SetOWObjectDirection
	ld a, $55
	ld de, CopyDataHLtoDE_SaveRegisters
	ld b, $02
	farcall LoadOWObjectInMap
	jr .asm_376eb
.asm_376bc
	ld a, $54
	ld de, $707
	farcall SetOWObjectTilePosition
	ld b, $02
	farcall SetOWObjectDirection
	jr .asm_376eb
.asm_376cd
	ld a, $53
	ld de, $707
	farcall SetOWObjectTilePosition
	ld b, $02
	farcall SetOWObjectDirection
	ld a, $54
	ld de, $909
	farcall SetOWObjectTilePosition
	ld b, $03
	farcall SetOWObjectDirection
.asm_376eb
	scf
	ret

Func_376ed:
	ld hl, GrCastle_NPCInteractions
	call Func_328c
	scf
	ret

Func_376f5:
	ld hl, GrCastle_AfterDuelScripts
	ld a, [wScriptNPC]
	call Func_344c
	scf
	ret

GrCastle_AfterDuelScripts:
	npc_script NPC_KANZAKI, Func_378cf
	npc_script NPC_RUI, Func_37a21
	db $ff

Func_37709:
	ld a, EVENT_MET_BIRURITCHI_AND_ADMINS
	farcall MaxOutEventValue
	ld a, NPC_BIRURITCHI
	ld [wScriptNPC], a
	ld hl, $a27
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	print_npc_text Text08f1
	get_player_x_position
	compare_loaded_var $07
	script_jump_if_b0nz .ows_3773e
	script_command_02
	compare_loaded_var $08
	script_jump_if_b0nz .ows_3773a
	animate_player_movement $01, $01
	script_command_01
	script_jump .ows_3773e
.ows_3773a
	animate_player_movement $03, $01
	script_command_01
.ows_3773e
	set_player_direction NORTH
	print_npc_text Text08f2
	script_command_02
	do_frames 30
	set_active_npc_direction NORTH
	script_command_01
	print_npc_text Text08f3
	script_command_02
	set_active_npc_direction SOUTH
	do_frames 30
	script_command_01
	print_npc_text Text08f4
	set_active_npc NPC_KANZAKI, DialogKanzakiText
	print_npc_text Text08f5
	script_command_02
	spin_active_npc_reverse 263
	do_frames 30
	animate_active_npc_movement $02, $01
	do_frames 30
	script_command_01
	set_active_npc NPC_BIRURITCHI, DialogBiruritchiText
	print_npc_text Text08f6
	set_active_npc NPC_RUI, DialogRuiText
	print_npc_text Text08f7
	script_command_02
	spin_active_npc 772
	do_frames 10
	animate_active_npc_movement $02, $01
	do_frames 30
	script_command_01
	set_active_npc NPC_BIRURITCHI, DialogBiruritchiText
	print_npc_text Text08f8
	script_command_02
	move_active_npc .NPCMovement_377aa
	wait_for_player_animation
	unload_npc NPC_BIRURITCHI
	script_command_01
	set_active_npc NPC_KANZAKI, DialogKanzakiText
	print_npc_text Text08f9
	script_command_02
	move_player .NPCMovement_377ad, TRUE
	move_active_npc .NPCMovement_377b6
	move_npc NPC_RUI, .NPCMovement_377bf
	wait_for_player_animation
	do_frames 30
	script_jump Func_37809.ows_3782d
.NPCMovement_377aa:
	db NORTH, MOVE_4
	db $ff
.NPCMovement_377ad:
	db SOUTH, MOVE_2
	db WEST, MOVE_2
	db SOUTH, MOVE_2
	db EAST, MOVE_0
	db $ff
.NPCMovement_377b6:
	db SOUTH, MOVE_3
	db EAST, MOVE_1
	db SOUTH, MOVE_2
	db WEST, MOVE_0
	db $ff
.NPCMovement_377bf:
	db EAST, MOVE_1
	db SOUTH, MOVE_3
	db $ff

Script_377c4:
	print_npc_text Text08fa
	script_command_02
	move_active_npc NPCMovement_377ff
	move_npc NPC_KANZAKI, NPCMovement_377fa
	wait_for_player_animation
	move_player NPCMovement_377f3, TRUE
	wait_for_player_animation
	move_active_npc NPCMovement_37806
	move_npc NPC_KANZAKI, NPCMovement_37806
	move_player NPCMovement_37806, TRUE
	wait_for_player_animation
	set_scroll_state $02
	animate_player_movement $00, $01
	end_script
	ld a, $73
	ld de, $70e
	ld b, $00
	farcall Func_d3c4
	ret
NPCMovement_377f3:
	db NORTH, MOVE_2
	db EAST, MOVE_2
	db NORTH, MOVE_0
	db $ff

NPCMovement_377fa:
	db EAST, MOVE_1
	db NORTH, MOVE_1
	db $ff

NPCMovement_377ff:
	db NORTH, MOVE_2
	db WEST, MOVE_3
	db NORTH, MOVE_1
	db $ff

NPCMovement_37806:
	db NORTH, MOVE_7
	db $ff

Func_37809:
	ld a, NPC_KANZAKI
	ld [wScriptNPC], a
	ld hl, $a25
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	check_event EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE
	script_jump_if_b0z .ows_37897
	check_event EVENT_GR_CASTLE_STAIRS_RUI_ROADBLOCK
	script_jump_if_b0z .ows_3786c
	check_event EVENT_BEAT_KANZAKI
	script_jump_if_b0z .ows_37866
.ows_3782d
	check_event EVENT_TALKED_TO_KANZAKI
	script_jump_if_b0z .ows_3783b
	set_event EVENT_TALKED_TO_KANZAKI
	script_command_01
	print_npc_text Text08fb
	script_jump .ows_3783e
.ows_3783b
	print_npc_text Text08fc
.ows_3783e
	ask_question Text08fd, TRUE
	script_jump_if_b0z .ows_37860
	duel_requirement_check DUEL_REQUIREMENT_KANZAKI
	script_jump_if_b1z .ows_37850
	print_npc_text Text08fe
	script_jump .ows_37863
.ows_37850
	script_call Script_37ac0
	set_npc_direction NPC_RUI, SOUTH
	print_npc_text Text08ff
	script_command_02
	start_duel BAD_GUYS_DECK_ID, MUSIC_DITTY_2
	end_script
	ret
.ows_37860
	print_npc_text Text0900
.ows_37863
	script_command_02
	end_script
	ret
.ows_37866
	print_npc_text Text0901
	script_command_02
	end_script
	ret
.ows_3786c
	print_npc_text Text0902
	ask_question Text08fd, TRUE
	script_jump_if_b0z .ows_37891
	duel_requirement_check DUEL_REQUIREMENT_KANZAKI
	script_jump_if_b1z .ows_37881
	print_npc_text Text0903
	script_jump .ows_37894
.ows_37881
	print_npc_text Text0904
	script_call Script_37ac0
	print_npc_text Text0905
	script_command_02
	start_duel BAD_GUYS_DECK_ID, MUSIC_DITTY_2
	end_script
	ret
.ows_37891
	print_npc_text Text0906
.ows_37894
	script_command_02
	end_script
	ret
.ows_37897
	check_event EVENT_TALKED_TO_KANZAKI
	script_jump_if_b0z .ows_378a4
	set_event EVENT_TALKED_TO_KANZAKI
	print_npc_text Text0907
	script_jump .ows_378a7
.ows_378a4
	print_npc_text Text0902
.ows_378a7
	ask_question Text08fd, TRUE
	script_jump_if_b0z .ows_378c9
	duel_requirement_check DUEL_REQUIREMENT_KANZAKI
	script_jump_if_b1z .ows_378b9
	print_npc_text Text0903
	script_jump .ows_378cc
.ows_378b9
	print_npc_text Text0904
	script_call Script_37ac0
	print_npc_text Text0905
	script_command_02
	start_duel BAD_GUYS_DECK_ID, MUSIC_DITTY_2
	end_script
	ret
.ows_378c9
	print_npc_text Text0906
.ows_378cc
	script_command_02
	end_script
	ret

Func_378cf:
	xor a
	start_script
	script_command_01
	check_event EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE
	script_jump_if_b0z .ows_37912
	check_event EVENT_BEAT_KANZAKI
	script_jump_if_b0z .ows_378f7
	check_event EVENT_SET_UNTIL_MAP_RELOAD_2
	script_jump_if_b0nz .ows_378f1
	set_event EVENT_BEAT_KANZAKI
	print_npc_text Text0908
	give_booster_packs BoosterList_cdb2
	print_npc_text Text0909
	script_jump Script_37952
.ows_378f1
	print_npc_text Text090a
	script_command_02
	end_script
	ret
.ows_378f7
	check_event EVENT_SET_UNTIL_MAP_RELOAD_2
	script_jump_if_b0nz .ows_37908
	print_npc_text Text090b
	give_booster_packs BoosterList_cdb2
	print_npc_text Text090c
	script_jump .ows_3790b
.ows_37908
	print_npc_text Text090d
.ows_3790b
	script_command_02
	script_call Script_37b63
	end_script
	ret
.ows_37912
	check_event EVENT_SET_UNTIL_MAP_RELOAD_2
	script_jump_if_b0nz .ows_37923
	print_npc_text Text090b
	give_booster_packs BoosterList_cdb2
	print_npc_text Text090e
	script_jump .ows_37926
.ows_37923
	print_npc_text Text090f
.ows_37926
	script_command_02
	script_call Script_37b63
	end_script
	ret

Func_3792d:
	ld a, NPC_RUI
	ld [wScriptNPC], a
	ld hl, $a26
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	check_event EVENT_GR_CASTLE_STAIRS_RUI_ROADBLOCK
	script_jump_if_b0z Script_379d7
	check_event EVENT_BEAT_KANZAKI
	script_jump_if_b0z Script_37952
	print_npc_text Text0910
	script_command_02
	end_script
	ret
Script_37952:
	check_event EVENT_TALKED_TO_RUI
	script_jump_if_b0z .ows_37980
	set_event EVENT_TALKED_TO_RUI
	set_active_npc NPC_RUI, DialogRuiText
	print_npc_text Text0911
	set_active_npc NPC_KANZAKI, DialogKanzakiText
	print_npc_text Text0912
	script_command_02
	move_active_npc .NPCMovement_379c7
	move_npc NPC_RUI, .NPCMovement_379d0
	wait_for_player_animation
	do_frames 30
	script_command_01
	set_active_npc NPC_RUI, DialogRuiText
	print_npc_text Text0913
	print_npc_text Text0914
	script_jump .ows_37983
.ows_37980
	print_npc_text Text0913
.ows_37983
	ask_question Text0915, TRUE
	script_jump_if_b0z .ows_379c1
	script_call Script_37ac0
	set_npc_direction NPC_KANZAKI, SOUTH
	get_random $03
	compare_loaded_var $02
	script_jump_if_b0nz .ows_379b5
	compare_loaded_var $01
	script_jump_if_b0nz .ows_379a9
	print_npc_text Text0916
	print_npc_text Text0917
	script_command_02
	start_duel POISON_MIST_DECK_ID, MUSIC_DITTY_2
	end_script
	ret
.ows_379a9
	print_npc_text Text0918
	print_npc_text Text0917
	script_command_02
	start_duel ULTRA_REMOVAL_DECK_ID, MUSIC_DITTY_2
	end_script
	ret
.ows_379b5
	print_npc_text Text0919
	print_npc_text Text0917
	script_command_02
	start_duel PSYCHIC_BATTLE_DECK_ID, MUSIC_DITTY_2
	end_script
	ret
.ows_379c1
	print_npc_text Text091a
	script_command_02
	end_script
	ret
.NPCMovement_379c7:
	db EAST, MOVE_1
	db NORTH, MOVE_2
	db WEST, MOVE_3
	db SOUTH, MOVE_0
	db $ff
.NPCMovement_379d0:
	db EAST, MOVE_2
	db SOUTH, MOVE_2
	db WEST, MOVE_0
	db $ff
Script_379d7:
	print_npc_text Text091b
	print_npc_text Text0914
	ask_question Text0915, TRUE
	script_jump_if_b0z .ows_37a1b
	print_npc_text Text091c
	script_call Script_37b18
	get_random $03
	compare_loaded_var $02
	script_jump_if_b0nz .ows_37a0f
	compare_loaded_var $01
	script_jump_if_b0nz .ows_37a03
	print_npc_text Text0916
	print_npc_text Text091d
	script_command_02
	start_duel POISON_MIST_DECK_ID, MUSIC_DITTY_2
	end_script
	ret
.ows_37a03
	print_npc_text Text0918
	print_npc_text Text091d
	script_command_02
	start_duel ULTRA_REMOVAL_DECK_ID, MUSIC_DITTY_2
	end_script
	ret
.ows_37a0f
	print_npc_text Text0919
	print_npc_text Text091d
	script_command_02
	start_duel PSYCHIC_BATTLE_DECK_ID, MUSIC_DITTY_2
	end_script
	ret
.ows_37a1b
	print_npc_text Text091e
	script_command_02
	end_script
	ret

Func_37a21:
	xor a
	start_script
	script_command_01
	check_event EVENT_BEAT_RUI
	script_jump_if_b0z .ows_37a44
	check_event EVENT_SET_UNTIL_MAP_RELOAD_2
	script_jump_if_b0nz .ows_37a3e
	set_event EVENT_BEAT_RUI
	print_npc_text Text091f
	give_booster_packs BoosterList_cdb6
	print_npc_text Text0920
	script_jump Script_377c4
.ows_37a3e
	print_npc_text Text0921
	script_command_02
	end_script
	ret
.ows_37a44
	check_event EVENT_SET_UNTIL_MAP_RELOAD_2
	script_jump_if_b0nz .ows_37a55
	print_npc_text Text0922
	give_booster_packs BoosterList_cdb6
	print_npc_text Text0923
	script_jump .ows_37a58
.ows_37a55
	print_npc_text Text0924
.ows_37a58
	script_command_02
	script_call Script_37b79
	end_script
	ret

Func_37a5f:
	ld a, EVENT_MET_BIRURITCHI_AND_ADMINS
	farcall GetEventValue
	jp z, Func_37709
	ld a, EVENT_GR_CASTLE_STAIRS_RUI_ROADBLOCK
	farcall GetEventValue
	jp z, Func_37a76
	farcall Func_c199
	ret

Func_37a76:
	ld a, EVENT_BEAT_KANZAKI
	farcall GetEventValue
	jr nz, .asm_37a9b
	ld a, NPC_RUI
	ld [wScriptNPC], a
	ld hl, $a26
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	set_active_npc_direction NORTH
	print_npc_text Text0925
	script_jump .ows_37ab5
.asm_37a9b
	ld a, NPC_KANZAKI
	ld [wScriptNPC], a
	ld hl, $a25
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	set_active_npc_direction NORTH
	print_npc_text Text0926
.ows_37ab5
	script_command_02
	animate_player_movement $02, $01
	end_script
	ld a, $00
	ld [wd582], a
	ret

Script_37ac0:
	get_player_x_position
	compare_loaded_var $09
	script_jump_if_b1nz .ows_37aee
	script_command_02
	set_active_npc_direction WEST
	check_event EVENT_GR_CASTLE_STAIRS_RUI_ROADBLOCK
	script_call b0z, .ows_37aef
	get_player_direction
	compare_loaded_var $00
	script_jump_if_b0nz .ows_37ae8
	compare_loaded_var $03
	script_jump_if_b0nz .ows_37ae1
	move_player NPCMovement_37af4, TRUE
	script_jump .ows_37aec

.ows_37ae1
	move_player NPCMovement_37aff, TRUE
	script_jump .ows_37aec

.ows_37ae8
	move_player NPCMovement_37b08, TRUE
.ows_37aec
	wait_for_player_animation
	script_command_01
.ows_37aee
	script_ret

.ows_37aef
	move_npc NPC_RUI, NPCMovement_37b11
	script_ret

NPCMovement_37af4:
	db EAST, MOVE_1
	db SOUTH, MOVE_3
	db WEST, MOVE_5
	db NORTH, MOVE_2
	db EAST, MOVE_0
	db $ff

NPCMovement_37aff:
	db SOUTH, MOVE_2
	db WEST, MOVE_5
	db NORTH, MOVE_2
	db EAST, MOVE_0
	db $ff

NPCMovement_37b08:
	db SOUTH, MOVE_1
	db WEST, MOVE_4
	db NORTH, MOVE_2
	db EAST, MOVE_0
	db $ff

NPCMovement_37b11:
	db NORTH, MOVE_2
	db EAST, MOVE_2
	db SOUTH, MOVE_0
	db $ff

Script_37b18:
	script_command_02
	set_active_npc_direction EAST
	move_npc NPC_KANZAKI, NPCMovement_37b5c
	get_player_direction
	compare_loaded_var $00
	script_jump_if_b0nz .ows_37b38
	compare_loaded_var $01
	script_jump_if_b0nz .ows_37b31
	move_player NPCMovement_37b3f, TRUE
	script_jump .ows_37b3c

.ows_37b31
	move_player NPCMovement_37b4a, TRUE
	script_jump .ows_37b3c

.ows_37b38
	move_player NPCMovement_37b53, TRUE
.ows_37b3c
	wait_for_player_animation
	script_command_01
	script_ret

NPCMovement_37b3f:
	db WEST, MOVE_1
	db SOUTH, MOVE_3
	db EAST, MOVE_5
	db NORTH, MOVE_2
	db WEST, MOVE_0
	db $ff

NPCMovement_37b4a:
	db SOUTH, MOVE_2
	db EAST, MOVE_5
	db NORTH, MOVE_2
	db WEST, MOVE_0
	db $ff

NPCMovement_37b53:
	db SOUTH, MOVE_1
	db EAST, MOVE_4
	db NORTH, MOVE_2
	db WEST, MOVE_0
	db $ff

NPCMovement_37b5c:
	db NORTH, MOVE_2
	db WEST, MOVE_2
	db SOUTH, MOVE_0
	db $ff

Script_37b63:
	move_player NPCMovement_37b6d, TRUE
	move_npc NPC_RUI, NPCMovement_37b72
	wait_for_player_animation
	script_ret

NPCMovement_37b6d:
	db SOUTH, MOVE_1
	db NORTH, MOVE_0
	db $ff

NPCMovement_37b72:
	db WEST, MOVE_2
	db SOUTH, MOVE_2
	db EAST, MOVE_0
	db $ff

Script_37b79:
	move_player NPCMovement_37b83, TRUE
	move_npc NPC_KANZAKI, NPCMovement_37b88
	wait_for_player_animation
	script_ret

NPCMovement_37b83:
	db SOUTH, MOVE_1
	db NORTH, MOVE_0
	db $ff

NPCMovement_37b88:
	db EAST, MOVE_2
	db SOUTH, MOVE_2
	db WEST, MOVE_0
	db $ff
