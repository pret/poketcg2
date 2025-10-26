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
	npc NPC_NIKKI, 5, 4, SOUTH, Func_2c46a
	db $ff

IshiharasHouse_NPCInteractions:
	npc_script NPC_ISHIHARA, Func_2c172
	npc_script NPC_NIKKI, Func_2c3cb
	db $ff

IshiharasHouse_OWInteractions:
	ow_script 3, 2, Func_40000
	ow_script 4, 2, Func_40016
	ow_script 5, 2, Func_4002c
	ow_script 6, 2, Func_40042
	ow_script 7, 2, Func_40058
	ow_script 8, 2, Func_4006e
	ow_script 1, 9, Func_40084
	ow_script 2, 9, Func_4009a
	ow_script 3, 9, Func_400b0
	ow_script 6, 9, Func_400c6
	ow_script 7, 9, Func_400dc
	ow_script 8, 9, Func_400f2
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

Func_2c172:
	ld a, $01
	farcall GetEventValue
	jr z, .asm_2c185
	ld a, $97
	farcall GetEventValue
	jr nz, .asm_2c185
	jp Func_2c3a5
.asm_2c185
	ld a, $f4
	farcall GetEventValue
	jr z, .asm_2c19b
	ld a, $02
	farcall GetVarValue
	cp $05
	jp c, Func_2c28c
	jp Func_2c36d
.asm_2c19b
	ld a, $02
	farcall GetVarValue
	or a
	jp z, Func_2c1db
	dec a
	jp z, Func_2c203
	dec a
	jp z, Func_2c229
	dec a
	jp z, Func_2c2a7
	dec a
	jp z, Func_2c30a
	jp Func_2c388

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

Func_2c1db:
	ld a, $04
	ld [wScriptNPC], a
	ld hl, $9d3
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	check_event EVENT_TALKED_TO_ISHIHARA
	script_jump_if_b0z .ows_2c1fd
	set_event EVENT_TALKED_TO_ISHIHARA
	print_npc_text Text0e97
	script_jump .ows_2c200
.ows_2c1fd
	print_npc_text Text0e98
.ows_2c200
	script_command_02
	end_script
	ret

Func_2c203:
	ld a, $04
	ld [wScriptNPC], a
	ld hl, $9d3
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	check_event EVENT_GOT_ODDISH_COIN
	script_jump_if_b0z .ows_2c223
	print_npc_text Text0e99
	script_jump .ows_2c226
.ows_2c223
	print_npc_text Text0e9a
.ows_2c226
	script_command_02
	end_script
	ret

Func_2c229:
	ld a, $04
	ld [wScriptNPC], a
	ld hl, $9d3
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	check_event EVENT_TALKED_TO_ISHIHARA
	script_jump_if_b0z .ows_2c24b
	set_event EVENT_TALKED_TO_ISHIHARA
	print_npc_text Text0e9b
	script_jump .ows_2c24e
.ows_2c24b
	print_npc_text Text0e9c
.ows_2c24e
	ask_question TradeCardsPromptText, TRUE
	script_jump_if_b0nz .ows_2c25b
	print_npc_text Text0e9d
	script_jump .ows_2c289
.ows_2c25b
	get_card_count_in_collection_and_decks CLEFAIRY_LV15
	script_jump_if_b0z .ows_2c267
	print_npc_text Text0e9e
	script_jump .ows_2c289
.ows_2c267
	get_card_count_in_collection CLEFAIRY_LV15
	script_jump_if_b0z .ows_2c273
	print_npc_text Text0e9f
	script_jump .ows_2c289
.ows_2c273
	print_npc_text Text0ea0
	print_text Text0ea1
	receive_card FLYING_PIKACHU_ALT_LV12
	take_card CLEFAIRY_LV15
	set_event EVENT_ISHIHARA_CARD_TRADE_STATE
	reset_event EVENT_TALKED_TO_ISHIHARA
	set_var VAR_02, $03
	print_npc_text Text0ea2
.ows_2c289
	script_command_02
	end_script
	ret

Func_2c28c:
	ld a, $04
	ld [wScriptNPC], a
	ld hl, $9d3
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	print_npc_text Text0ea3
	script_command_02
	end_script
	ret

Func_2c2a7:
	ld a, $04
	ld [wScriptNPC], a
	ld hl, $9d3
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	check_event EVENT_TALKED_TO_ISHIHARA
	script_jump_if_b0z .ows_2c2c9
	set_event EVENT_TALKED_TO_ISHIHARA
	print_npc_text Text0ea4
	script_jump .ows_2c2cc
.ows_2c2c9
	print_npc_text Text0ea5
.ows_2c2cc
	ask_question TradeCardsPromptText, TRUE
	script_jump_if_b0nz .ows_2c2d9
	print_npc_text Text0e9d
	script_jump .ows_2c307
.ows_2c2d9
	get_card_count_in_collection_and_decks CLEFABLE
	script_jump_if_b0z .ows_2c2e5
	print_npc_text Text0ea6
	script_jump .ows_2c307
.ows_2c2e5
	get_card_count_in_collection CLEFABLE
	script_jump_if_b0z .ows_2c2f1
	print_npc_text Text0ea7
	script_jump .ows_2c307
.ows_2c2f1
	print_npc_text Text0ea8
	print_text Text0ea9
	receive_card TOGEPI
	take_card CLEFABLE
	set_event EVENT_ISHIHARA_CARD_TRADE_STATE
	reset_event EVENT_TALKED_TO_ISHIHARA
	set_var VAR_02, $04
	print_npc_text Text0eaa
.ows_2c307
	script_command_02
	end_script
	ret

Func_2c30a:
	ld a, $04
	ld [wScriptNPC], a
	ld hl, $9d3
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	check_event EVENT_TALKED_TO_ISHIHARA
	script_jump_if_b0z .ows_2c32c
	set_event EVENT_TALKED_TO_ISHIHARA
	print_npc_text Text0eab
	script_jump .ows_2c32f
.ows_2c32c
	print_npc_text Text0eac
.ows_2c32f
	ask_question TradeCardsPromptText, TRUE
	script_jump_if_b0nz .ows_2c33c
	print_npc_text Text0e9d
	script_jump .ows_2c36a
.ows_2c33c
	get_card_count_in_collection_and_decks DRAGONITE_LV45
	script_jump_if_b0z .ows_2c348
	print_npc_text Text0ead
	script_jump .ows_2c36a
.ows_2c348
	get_card_count_in_collection DRAGONITE_LV45
	script_jump_if_b0z .ows_2c354
	print_npc_text Text0eae
	script_jump .ows_2c36a
.ows_2c354
	print_npc_text Text0eaf
	print_text Text0eb0
	receive_card MARILL
	take_card DRAGONITE_LV45
	set_event EVENT_ISHIHARA_CARD_TRADE_STATE
	reset_event EVENT_TALKED_TO_ISHIHARA
	set_var VAR_02, $05
	print_npc_text Text0eb1
.ows_2c36a
	script_command_02
	end_script
	ret

Func_2c36d:
	ld a, $04
	ld [wScriptNPC], a
	ld hl, $9d3
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	print_npc_text Text0eb2
	script_command_02
	end_script
	ret

Func_2c388:
	ld a, $04
	ld [wScriptNPC], a
	ld hl, $9d3
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	print_npc_text Text0eb3
	script_command_02
	set_active_npc_direction NORTH
	end_script
	ret

Func_2c3a5:
	ld a, $04
	ld [wScriptNPC], a
	ld hl, $9d3
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	set_event EVENT_TALKED_TO_ISHIHARA_POST_GAME
	print_npc_text Text0eb4
	script_command_02
	get_var VAR_02
	compare_loaded_var $06
	script_jump_if_b1nz .ows_2c3c9
	set_active_npc_direction NORTH
.ows_2c3c9
	end_script
	ret

Func_2c3cb:
	ld a, $11
	ld [wScriptNPC], a
	ld hl, $9dc
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	check_event EVENT_TALKED_TO_NIKKI
	script_jump_if_b0z .ows_2c446
	set_event EVENT_TALKED_TO_NIKKI
	set_event EVENT_SET_UNTIL_MAP_RELOAD_1
	print_npc_text Text0eb5
	script_command_02
	get_player_direction
	compare_loaded_var $02
	script_jump_if_b0z .ows_2c3f8
	set_player_direction WEST
	animate_player_movement $81, $02
.ows_2c3f8
	move_active_npc NPCMovement_2c450
	wait_for_player_animation
	do_frames 30
	get_player_y_position
	compare_loaded_var $04
	script_jump_if_b0nz .ows_2c40d
	script_jump_if_b1nz .ows_2c413
	move_active_npc NPCMovement_2c457
	script_jump .ows_2c416
.ows_2c40d
	move_active_npc NPCMovement_2c45c
	script_jump .ows_2c416
.ows_2c413
	move_active_npc NPCMovement_2c463
.ows_2c416
	wait_for_player_animation
	do_frames 15
	script_command_01
	print_npc_text Text0eb6
	give_deck GIVE_IN_ANTI_GR2_DECK_ID
	script_jump_if_b1nz .ows_2c42c
	play_song MUSIC_BOOSTER_PACK
	print_text Text0eb7
	wait_song
	resume_song
	script_jump .ows_2c439
.ows_2c42c
	print_npc_text Text0eb8
	play_song MUSIC_BOOSTER_PACK
	print_text Text0eb9
	wait_song
	resume_song
	print_npc_text Text0eba
.ows_2c439
	set_event EVENT_GOT_ODDISH_COIN
	print_npc_text Text0ebb
	give_coin COIN_ODDISH
	print_npc_text Text0ebc
	script_jump .ows_2c44d
.ows_2c446
	check_event EVENT_SET_UNTIL_MAP_RELOAD_1
	print_variable_npc_text Text0ebd, Text0ebe
.ows_2c44d
	script_command_02
	end_script
	ret
NPCMovement_2c450:
	db NORTH, MOVE_2
	db WEST, MOVE_4
	db NORTH, MOVE_0
	db $ff
NPCMovement_2c457:
	db EAST, MOVE_4
	db SOUTH, MOVE_2
	db $ff
NPCMovement_2c45c:
	db EAST, MOVE_4
	db SOUTH, MOVE_2
	db EAST, MOVE_0
	db $ff
NPCMovement_2c463:
	db EAST, MOVE_4
	db SOUTH, MOVE_1
	db EAST, MOVE_0
	db $ff

Func_2c46a:
	ld a, $02
	farcall GetVarValue
	cp $01
	jr nz, .asm_2c477
	scf
	ccf
	ret
.asm_2c477
	scf
	ret

LightningClub_MapHeader:
	db MAP_GFX_LIGHTNING_CLUB_1
	dba LightningClub_MapScripts
	db MUSIC_CLUB_1

LightningClub_StepEvents:
	map_exit 6, 15, MAP_LIGHTNING_CLUB_ENTRANCE, 4, 1, SOUTH
	map_exit 7, 15, MAP_LIGHTNING_CLUB_ENTRANCE, 5, 1, SOUTH
	db $ff

LightningClub_NPCs:
	npc NPC_ISAAC, 6, 2, SOUTH, $0
	npc NPC_JENNIFER, 7, 9, SOUTH, Func_2c8f9
	npc NPC_NICHOLAS, 3, 5, SOUTH, $0
	npc NPC_BRANDON, 11, 6, SOUTH, Func_2c8f9
	npc NPC_GR_4, 7, 4, SOUTH, Func_2c929
	db $ff

LightningClub_NPCInteractions:
	npc_script NPC_ISAAC, Func_2c645
	npc_script NPC_JENNIFER, Func_2c73b
	npc_script NPC_NICHOLAS, Func_2c79d
	npc_script NPC_BRANDON, Func_2c897
	npc_script NPC_GR_4, Func_2c90e
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
	npc_script NPC_ISAAC, Func_2c6ec
	npc_script NPC_JENNIFER, Func_2c781
	npc_script NPC_NICHOLAS, Func_2c847
	npc_script NPC_BRANDON, Func_2c8dd
	db $ff
; 0x2c584

SECTION "Bank b@45f5", ROMX[$45f5], BANK[$b]

Script_2c5f5:
	set_event EVENT_SET_UNTIL_MAP_RELOAD_1
	reset_event EVENT_TALKED_TO_ISAAC
	reset_event EVENT_TALKED_TO_JENNIFER
	reset_event EVENT_TALKED_TO_NICHOLAS
	reset_event EVENT_TALKED_TO_BRANDON
	set_active_npc NPC_GR_4, DialogGR4Text
	move_active_npc NPCMovement_2c637
	wait_for_player_animation
	set_active_npc_direction WEST
	script_command_01
	print_npc_text Text0b0a
	script_command_02
	move_active_npc NPCMovement_2c63a
	wait_for_player_animation
	do_frames 30
	move_active_npc NPCMovement_2c63d
	wait_for_player_animation
	script_command_01
	print_npc_text Text0b0b
	script_command_02
	move_active_npc NPCMovement_2c642
	wait_for_player_animation
	unload_npc NPC_GR_4
	play_song_next MUSIC_CLUB_1
	script_command_01
	set_active_npc NPC_ISAAC, DialogIsaacText
	set_event EVENT_GOT_PIKACHU_COIN
	print_npc_text Text0b0c
	give_coin COIN_PIKACHU
	print_npc_text Text0b0d
	script_command_02
	end_script
	ret

NPCMovement_2c637:
	db SOUTH, MOVE_2
	db $ff

NPCMovement_2c63a:
	db SOUTH, MOVE_4
	db $ff

NPCMovement_2c63d:
	db NORTH, MOVE_4
	db WEST, MOVE_0
	db $ff

NPCMovement_2c642:
	db SOUTH, MOVE_8
	db $ff

Func_2c645:
	ld a, $22
	ld [wScriptNPC], a
	ld hl, $9e8
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	check_event EVENT_FREED_STEVE
	script_jump_if_b0z .ows_2c6c6
	check_event EVENT_GOT_PIKACHU_COIN
	script_jump_if_b0z .ows_2c695
	check_event EVENT_BEAT_NICHOLAS
	script_jump_if_b0z .ows_2c66f
	print_npc_text Text0b0e
	script_jump .ows_2c692
.ows_2c66f
	check_event EVENT_TALKED_TO_ISAAC
	script_jump_if_b0z .ows_2c67c
	set_event EVENT_TALKED_TO_ISAAC
	print_npc_text Text0b0f
	script_jump .ows_2c67f
.ows_2c67c
	print_npc_text Text0b10
.ows_2c67f
	ask_question Text0b11, TRUE
	script_jump_if_b0z .ows_2c68f
	print_npc_text Text0b12
	script_command_02
	start_duel SKY_SPARK_DECK_ID, MUSIC_MATCHSTART_2
	end_script
	ret
.ows_2c68f
	print_npc_text Text0b13
.ows_2c692
	script_command_02
	end_script
	ret
.ows_2c695
	check_event EVENT_SET_UNTIL_MAP_RELOAD_1
	script_jump_if_b0z .ows_2c6c0
	check_event EVENT_TALKED_TO_ISAAC
	script_jump_if_b0z .ows_2c6a7
	set_event EVENT_TALKED_TO_ISAAC
	print_npc_text Text0b14
	script_jump .ows_2c6aa
.ows_2c6a7
	print_npc_text Text0b15
.ows_2c6aa
	ask_question Text0b11, TRUE
	script_jump_if_b0z .ows_2c6ba
	print_npc_text Text0b16
	script_command_02
	start_duel SKY_SPARK_DECK_ID, MUSIC_MATCHSTART_2
	end_script
	ret
.ows_2c6ba
	print_npc_text Text0b17
	script_jump .ows_2c6c3
.ows_2c6c0
	print_npc_text Text0b18
.ows_2c6c3
	script_command_02
	end_script
	ret
.ows_2c6c6
	check_event EVENT_TALKED_TO_ISAAC
	script_jump_if_b0z .ows_2c6d3
	set_event EVENT_TALKED_TO_ISAAC
	print_npc_text Text0b19
	script_jump .ows_2c6d6
.ows_2c6d3
	print_npc_text Text0b1a
.ows_2c6d6
	ask_question Text0b11, TRUE
	script_jump_if_b0z .ows_2c6e6
	print_npc_text Text0b1b
	script_command_02
	start_duel ELECTRIC_SELFDESTRUCT_DECK_ID, MUSIC_MATCHSTART_2
	end_script
	ret
.ows_2c6e6
	print_npc_text Text0b1c
	script_command_02
	end_script
	ret

Func_2c6ec:
	xor a
	start_script
	script_command_01
	check_event EVENT_FREED_STEVE
	script_jump_if_b0z .ows_2c724
	check_event EVENT_GOT_PIKACHU_COIN
	script_jump_if_b0z .ows_2c70d
	check_event EVENT_SET_UNTIL_MAP_RELOAD_2
	script_jump_if_b0nz .ows_2c707
	print_npc_text Text0b1d
	script_command_02
	script_jump Script_2c5f5
.ows_2c707
	print_npc_text Text0b1e
	script_command_02
	end_script
	ret
.ows_2c70d
	check_event EVENT_SET_UNTIL_MAP_RELOAD_2
	script_jump_if_b0nz .ows_2c71e
	print_npc_text Text0b1f
	give_booster_packs BoosterList_cd15
	print_npc_text Text0b20
	script_jump .ows_2c721
.ows_2c71e
	print_npc_text Text0b21
.ows_2c721
	script_command_02
	end_script
	ret
.ows_2c724
	check_event EVENT_SET_UNTIL_MAP_RELOAD_2
	script_jump_if_b0nz .ows_2c735
	print_npc_text Text0b22
	give_booster_packs BoosterList_cd19
	print_npc_text Text0b23
	script_jump .ows_2c738
.ows_2c735
	print_npc_text Text0b24
.ows_2c738
	script_command_02
	end_script
	ret

Func_2c73b:
	ld a, $23
	ld [wScriptNPC], a
	ld hl, $9e9
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	check_event EVENT_GOT_GR_COIN
	script_jump_if_b0z .ows_2c768
	check_event EVENT_TALKED_TO_JENNIFER
	script_jump_if_b0z .ows_2c762
	set_event EVENT_TALKED_TO_JENNIFER
	print_npc_text Text0b25
	script_jump .ows_2c765
.ows_2c762
	print_npc_text Text0b26
.ows_2c765
	script_command_02
	end_script
	ret
.ows_2c768
	print_npc_text Text0b27
	ask_question Text0b28, TRUE
	script_jump_if_b0z .ows_2c77b
	print_npc_text Text0b29
	script_command_02
	start_duel I_LOVE_PIKACHU_DECK_ID, MUSIC_MATCHSTART_1
	end_script
	ret
.ows_2c77b
	print_npc_text Text0b2a
	script_command_02
	end_script
	ret

Func_2c781:
	xor a
	start_script
	script_command_01
	check_event EVENT_SET_UNTIL_MAP_RELOAD_2
	script_jump_if_b0nz .ows_2c797
	print_npc_text Text0b2b
	give_booster_packs BoosterList_cd1d
	print_npc_text Text0b2c
	script_jump .ows_2c79a
.ows_2c797
	print_npc_text Text0b2d
.ows_2c79a
	script_command_02
	end_script
	ret

Func_2c79d:
	ld a, $24
	ld [wScriptNPC], a
	ld hl, $9ea
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	check_event EVENT_GODAS_ROOM_CAGE_STATE
	script_jump_if_b0z .ows_2c821
	check_event EVENT_GOT_PIKACHU_COIN
	script_jump_if_b0z .ows_2c7f0
	check_event EVENT_BEAT_NICHOLAS
	script_jump_if_b0z .ows_2c7d4
	check_event EVENT_TALKED_TO_NICHOLAS
	script_jump_if_b0z .ows_2c7ce
	set_event EVENT_TALKED_TO_NICHOLAS
	print_npc_text Text0b2e
	script_jump .ows_2c7da
.ows_2c7ce
	print_npc_text Text0b2f
	script_jump .ows_2c7da
.ows_2c7d4
	print_npc_text Text0b30
	script_jump .ows_2c7ed
.ows_2c7da
	ask_question Text0b31, TRUE
	script_jump_if_b0z .ows_2c7ea
	print_npc_text Text0b32
	script_command_02
	start_duel OVERFLOW_DECK_ID, MUSIC_MATCHSTART_1
	end_script
	ret
.ows_2c7ea
	print_npc_text Text0b33
.ows_2c7ed
	script_command_02
	end_script
	ret
.ows_2c7f0
	check_event EVENT_SET_UNTIL_MAP_RELOAD_1
	script_jump_if_b0z .ows_2c81b
	check_event EVENT_TALKED_TO_NICHOLAS
	script_jump_if_b0z .ows_2c802
	set_event EVENT_TALKED_TO_NICHOLAS
	print_npc_text Text0b34
	script_jump .ows_2c805
.ows_2c802
	print_npc_text Text0b35
.ows_2c805
	ask_question Text0b31, TRUE
	script_jump_if_b0z .ows_2c815
	print_npc_text Text0b36
	script_command_02
	start_duel OVERFLOW_DECK_ID, MUSIC_MATCHSTART_1
	end_script
	ret
.ows_2c815
	print_npc_text Text0b37
	script_jump .ows_2c81e
.ows_2c81b
	print_npc_text Text0b38
.ows_2c81e
	script_command_02
	end_script
	ret
.ows_2c821
	check_event EVENT_TALKED_TO_NICHOLAS
	script_jump_if_b0z .ows_2c82e
	set_event EVENT_TALKED_TO_NICHOLAS
	print_npc_text Text0b39
	script_jump .ows_2c831
.ows_2c82e
	print_npc_text Text0b3a
.ows_2c831
	ask_question Text0b31, TRUE
	script_jump_if_b0z .ows_2c841
	print_npc_text Text0b3b
	script_command_02
	start_duel TRIPLE_ZAPDOS_DECK_ID, MUSIC_MATCHSTART_1
	end_script
	ret
.ows_2c841
	print_npc_text Text0b3c
	script_command_02
	end_script
	ret

Func_2c847:
	xor a
	start_script
	script_command_01
	check_event EVENT_GODAS_ROOM_CAGE_STATE
	script_jump_if_b0z .ows_2c880
	check_event EVENT_GOT_PIKACHU_COIN
	script_jump_if_b0z .ows_2c869
	check_event EVENT_SET_UNTIL_MAP_RELOAD_2
	script_jump_if_b0nz .ows_2c863
	set_event EVENT_BEAT_NICHOLAS
	print_npc_text Text0b3d
	script_jump .ows_2c866
.ows_2c863
	print_npc_text Text0b3e
.ows_2c866
	script_command_02
	end_script
	ret
.ows_2c869
	check_event EVENT_SET_UNTIL_MAP_RELOAD_2
	script_jump_if_b0nz .ows_2c87a
	print_npc_text Text0b3f
	give_booster_packs BoosterList_cd20
	print_npc_text Text0b40
	script_jump .ows_2c87d
.ows_2c87a
	print_npc_text Text0b41
.ows_2c87d
	script_command_02
	end_script
	ret
.ows_2c880
	check_event EVENT_SET_UNTIL_MAP_RELOAD_2
	script_jump_if_b0nz .ows_2c891
	print_npc_text Text0b42
	give_booster_packs BoosterList_cd23
	print_npc_text Text0b43
	script_jump .ows_2c894
.ows_2c891
	print_npc_text Text0b44
.ows_2c894
	script_command_02
	end_script
	ret

Func_2c897:
	ld a, $25
	ld [wScriptNPC], a
	ld hl, $9eb
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	check_event EVENT_GOT_GR_COIN
	script_jump_if_b0z .ows_2c8c4
	check_event EVENT_TALKED_TO_BRANDON
	script_jump_if_b0z .ows_2c8be
	set_event EVENT_TALKED_TO_BRANDON
	print_npc_text Text0b45
	script_jump .ows_2c8c1
.ows_2c8be
	print_npc_text Text0b46
.ows_2c8c1
	script_command_02
	end_script
	ret
.ows_2c8c4
	print_npc_text Text0b47
	ask_question Text0b48, TRUE
	script_jump_if_b0z .ows_2c8d7
	print_npc_text Text0b49
	script_command_02
	start_duel TEN_THOUSAND_VOLTS_DECK_ID, MUSIC_MATCHSTART_1
	end_script
	ret
.ows_2c8d7
	print_npc_text Text0b4a
	script_command_02
	end_script
	ret

Func_2c8dd:
	xor a
	start_script
	script_command_01
	check_event EVENT_SET_UNTIL_MAP_RELOAD_2
	script_jump_if_b0nz .ows_2c8f3
	print_npc_text Text0b4b
	give_booster_packs BoosterList_cd27
	print_npc_text Text0b4c
	script_jump .ows_2c8f6
.ows_2c8f3
	print_npc_text Text0b4d
.ows_2c8f6
	script_command_02
	end_script
	ret

Func_2c8f9:
	ld a, $ed
	farcall GetEventValue
	jr nz, .asm_2c90c
	ld a, $08
	farcall GetEventValue
	jr z, .asm_2c90c
	scf
	ccf
	ret
.asm_2c90c
	scf
	ret

Func_2c90e:
	ld a, $31
	ld [wScriptNPC], a
	ld hl, $a2b
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	print_npc_text Text0b4e
	script_command_02
	end_script
	ret

Func_2c929:
	ld a, $08
	farcall GetEventValue
	jr z, .asm_2c933
	scf
	ret
.asm_2c933
	scf
	ccf
	ret

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
	npc NPC_STEPHANIE, 5, 1, SOUTH, Func_2cabb
	db $ff

PsychicClubEntrance_NPCInteractions:
	npc_script NPC_STEPHANIE, Func_2caa0
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
	bit 6, a
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
	npc NPC_PSYCHIC_CLUB_GLASSES_LAD, 8, 8, EAST, $0
	npc NPC_PSYCHIC_CLUB_LASS, 10, 9, WEST, $0
	npc NPC_IMAKUNI_BLACK, 1, 10, WEST, Func_2cca8
	npc NPC_PSYCHIC_CLUB_CAPPED_LAD, 7, 6, EAST, $0
	npc NPC_PSYCHIC_CLUB_GR_LASS, 14, 4, SOUTH, Func_2cd0e
	npc NPC_CLERK_BATTLE_CENTER, 2, 2, SOUTH, $0
	npc NPC_CLERK_GIFT_CENTER, 4, 2, SOUTH, $0
	db $ff

PsychicClubLobby_NPCInteractions:
	npc_script NPC_PSYCHIC_CLUB_GLASSES_LAD, Func_2cc11
	npc_script NPC_PSYCHIC_CLUB_LASS, Func_2cc7d
	npc_script NPC_IMAKUNI_BLACK, Func_3c30c
	npc_script NPC_PSYCHIC_CLUB_CAPPED_LAD, Func_2ccb7
	npc_script NPC_PSYCHIC_CLUB_GR_LASS, Func_2cce8
	db $ff

PsychicClubLobby_OWInteractions:
	ow_script 8, 2, PCMenu
	ow_script 9, 2, PCMenu
	ow_script 2, 4, Func_3c1b9
	ow_script 4, 4, Func_3c2d9
	ow_script 12, 2, Func_402d6
	ow_script 13, 2, Func_402ec
	ow_script 14, 2, Func_40302
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

Func_2cc11:
	ld a, $83
	ld [wScriptNPC], a
	ld hl, $a50
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	check_event EVENT_TRADED_CARDS_PSYCHIC_CLUB
	script_jump_if_b0z .ows_2cc77
	check_event EVENT_TALKED_TO_TRADE_NPC_PSYCHIC_CLUB
	script_jump_if_b0z .ows_2cc38
	set_event EVENT_TALKED_TO_TRADE_NPC_PSYCHIC_CLUB
	print_npc_text Text0bcc
	script_jump .ows_2cc3b
.ows_2cc38
	print_npc_text Text0bcd
.ows_2cc3b
	ask_question TradeCardsPromptText, TRUE
	script_jump_if_b0nz .ows_2cc48
	print_npc_text Text0bce
	script_jump .ows_2cc7a
.ows_2cc48
	get_card_count_in_collection_and_decks ALAKAZAM_LV42
	script_jump_if_b0z .ows_2cc54
	print_npc_text Text0bcf
	script_jump .ows_2cc7a
.ows_2cc54
	get_card_count_in_collection ALAKAZAM_LV42
	script_jump_if_b0z .ows_2cc60
	print_npc_text Text0bd0
	script_jump .ows_2cc7a
.ows_2cc60
	print_npc_text Text0bd1
	spin_active_npc 527
	print_npc_text Text0bd2
	receive_card KANGASKHAN_LV38
	take_card ALAKAZAM_LV42
	set_event EVENT_TRADED_CARDS_PSYCHIC_CLUB
	print_npc_text Text0bd3
	script_jump .ows_2cc7a
.ows_2cc77
	print_npc_text Text0bd4
.ows_2cc7a
	script_command_02
	end_script
	ret

Func_2cc7d:
	ld a, $84
	ld [wScriptNPC], a
	ld hl, $a36
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	compare_var VAR_25, $03
	script_jump_if_b0nz .ows_2cca2
	script_callfar Script_3c2f0
	print_npc_text Text0bd5
	script_jump .ows_2cca5
.ows_2cca2
	print_npc_text Text0bd6
.ows_2cca5
	script_command_02
	end_script
	ret

Func_2cca8:
	ld a, $25
	farcall GetVarValue
	cp $03
	jr z, .asm_2ccb4
	scf
	ret
.asm_2ccb4
	scf
	ccf
	ret

Func_2ccb7:
	ld a, $85
	ld [wScriptNPC], a
	ld hl, $a4c
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	check_event EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE
	script_jump_if_b0z .ows_2cce2
	check_event EVENT_GOT_GR_COIN
	script_jump_if_b0z .ows_2ccdc
	print_npc_text Text0bd7
	script_jump .ows_2cce5
.ows_2ccdc
	print_npc_text Text0bd8
	script_jump .ows_2cce5
.ows_2cce2
	print_npc_text Text0bd9
.ows_2cce5
	script_command_02
	end_script
	ret

Func_2cce8:
	ld a, $86
	ld [wScriptNPC], a
	ld hl, $a45
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	check_event EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE
	script_jump_if_b0z .ows_2cd08
	print_npc_text Text0bda
	script_jump .ows_2cd0b
.ows_2cd08
	print_npc_text Text0bdb
.ows_2cd0b
	script_command_02
	end_script
	ret

Func_2cd0e:
	ld a, $0b
	farcall GetEventValue
	jr z, .asm_2cd20
	ld a, $01
	farcall GetEventValue
	jr nz, .asm_2cd20
	scf
	ret
.asm_2cd20
	scf
	ccf
	ret

PsychicClub_MapHeader:
	db MAP_GFX_PSYCHIC_CLUB
	dba PsychicClub_MapScripts
	db MUSIC_CLUB_2

PsychicClub_StepEvents:
	map_exit 6, 13, MAP_PSYCHIC_CLUB_ENTRANCE, 4, 1, SOUTH
	map_exit 7, 13, MAP_PSYCHIC_CLUB_ENTRANCE, 5, 1, SOUTH
	db $ff

PsychicClub_NPCs:
	npc NPC_MURRAY, 6, 3, SOUTH, $0
	npc NPC_ROBERT, 3, 10, WEST, $0
	npc NPC_DANIEL, 4, 5, NORTH, $0
	npc NPC_STEPHANIE, 11, 6, EAST, $0
	npc NPC_GR_4, 7, 3, SOUTH, Func_2d23c
	db $ff

PsychicClub_NPCInteractions:
	npc_script NPC_MURRAY, Func_2ce88
	npc_script NPC_ROBERT, Func_2cfcc
	npc_script NPC_DANIEL, Func_2d046
	npc_script NPC_STEPHANIE, Func_2d0b3
	npc_script NPC_GR_4, Func_2d190
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
	npc_script NPC_MURRAY, Func_2cf73
	npc_script NPC_ROBERT, Func_2d02a
	npc_script NPC_DANIEL, Func_2d097
	npc_script NPC_STEPHANIE, Func_2d142
	npc_script NPC_GR_4, Func_2d20e
	db $ff
; 0x2ce39

SECTION "Bank b@4e88", ROMX[$4e88], BANK[$b]

Func_2ce88:
	ld a, $26
	ld [wScriptNPC], a
	ld hl, $9f0
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	check_event EVENT_GODAS_ROOM_CAGE_STATE
	script_jump_if_b0z .ows_2cf3b
	check_event EVENT_GOT_GR_COIN_PIECE_BOTTOM_RIGHT
	script_jump_if_b0z .ows_2cf17
	check_event EVENT_BEAT_MURRAY
	script_jump_if_b0z .ows_2cee3
	set_var VAR_3E, $00
	check_event EVENT_TALKED_TO_MURRAY
	script_jump_if_b0z .ows_2cebc
	set_event EVENT_TALKED_TO_MURRAY
	print_npc_text Text0b69
	script_jump .ows_2cebf
.ows_2cebc
	print_npc_text Text0b6a
.ows_2cebf
	ask_question Text0b6b, TRUE
	script_jump_if_b0z .ows_2cecf
	print_npc_text Text0b6c
	script_command_02
	start_duel HAND_OVER_GR_DECK_ID, MUSIC_MATCHSTART_2
	end_script
	ret
.ows_2cecf
	inc_var VAR_3E
	compare_var VAR_3E, $04
	script_jump_if_b0nz .ows_2cedd
	print_npc_text Text0b6d
	script_jump .ows_2cebf
.ows_2cedd
	print_npc_text Text0b6e
	script_jump .ows_2cf14
.ows_2cee3
	check_event EVENT_WALKED_INTO_MURRAYS_CLUB_ROOM
	script_jump_if_b0nz .ows_2cefb
	check_event EVENT_TALKED_TO_MURRAY
	script_jump_if_b0z .ows_2cef5
	set_event EVENT_TALKED_TO_MURRAY
	print_npc_text Text0b6f
	script_jump .ows_2cf01
.ows_2cef5
	print_npc_text Text0b70
	script_jump .ows_2cf01
.ows_2cefb
	print_npc_text Text0b71
	script_jump .ows_2cf14
.ows_2cf01
	ask_question Text0b6b, TRUE
	script_jump_if_b0z .ows_2cf11
	print_npc_text Text0b72
	script_command_02
	start_duel HAND_OVER_GR_DECK_ID, MUSIC_MATCHSTART_2
	end_script
	ret
.ows_2cf11
	print_npc_text Text0b73
.ows_2cf14
	script_command_02
	end_script
	ret
.ows_2cf17
	check_event EVENT_SET_UNTIL_MAP_RELOAD_1
	script_jump_if_b0z .ows_2cf35
	print_npc_text Text0b74
	ask_question Text0b6b, TRUE
	script_jump_if_b0z .ows_2cf2f
	print_npc_text Text0b75
	script_command_02
	start_duel HAND_OVER_GR_DECK_ID, MUSIC_MATCHSTART_2
	end_script
	ret
.ows_2cf2f
	print_npc_text Text0b76
	script_jump .ows_2cf38
.ows_2cf35
	print_npc_text Text0b77
.ows_2cf38
	script_command_02
	end_script
	ret
.ows_2cf3b
	check_event EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE
	script_jump_if_b0z .ows_2cf53
	check_event EVENT_TALKED_TO_MURRAY
	script_jump_if_b0z .ows_2cf4d
	set_event EVENT_TALKED_TO_MURRAY
	print_npc_text Text0b78
	script_jump .ows_2cf5d
.ows_2cf4d
	print_npc_text Text0b79
	script_jump .ows_2cf5d
.ows_2cf53
	check_event EVENT_TALKED_TO_MURRAY
	script_jump_if_b0z .ows_2cf4d
	set_event EVENT_TALKED_TO_MURRAY
	print_npc_text Text0b7a
.ows_2cf5d
	ask_question Text0b6b, TRUE
	script_jump_if_b0z .ows_2cf6d
	print_npc_text Text0b7b
	script_command_02
	start_duel PSYCHIC_ELITE_DECK_ID, MUSIC_MATCHSTART_2
	end_script
	ret
.ows_2cf6d
	print_npc_text Text0b7c
	script_command_02
	end_script
	ret

Func_2cf73:
	xor a
	start_script
	script_command_01
	check_event EVENT_GODAS_ROOM_CAGE_STATE
	script_jump_if_b0z .ows_2cfb5
	check_event EVENT_GOT_GR_COIN_PIECE_BOTTOM_RIGHT
	script_jump_if_b0z .ows_2cf9e
	check_event EVENT_SET_UNTIL_MAP_RELOAD_2
	script_jump_if_b0nz .ows_2cf98
	set_event EVENT_BEAT_MURRAY
	reset_event EVENT_TALKED_TO_GR4_PSYCHIC_CLUB
	reset_event EVENT_WALKED_INTO_MURRAYS_CLUB_ROOM
	check_event EVENT_GOT_ALAKAZAM_COIN
	script_jump_if_b0nz Script_2d249
	print_npc_text Text0b7d
	script_jump .ows_2cf9b
.ows_2cf98
	print_npc_text Text0b7e
.ows_2cf9b
	script_command_02
	end_script
	ret
.ows_2cf9e
	check_event EVENT_SET_UNTIL_MAP_RELOAD_2
	script_jump_if_b0nz .ows_2cfaf
	print_npc_text Text0b7f
	give_booster_packs BoosterList_cd2b
	print_npc_text Text0b80
	script_jump .ows_2cfb2
.ows_2cfaf
	print_npc_text Text0b81
.ows_2cfb2
	script_command_02
	end_script
	ret
.ows_2cfb5
	check_event EVENT_SET_UNTIL_MAP_RELOAD_2
	script_jump_if_b0nz .ows_2cfc6
	print_npc_text Text0b82
	give_booster_packs BoosterList_cd2f
	print_npc_text Text0b83
	script_jump .ows_2cfc9
.ows_2cfc6
	print_npc_text Text0b84
.ows_2cfc9
	script_command_02
	end_script
	ret

Func_2cfcc:
	ld a, $27
	ld [wScriptNPC], a
	ld hl, $9f1
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	check_event EVENT_FREED_STEVE
	script_jump_if_b0z .ows_2d004
	check_event EVENT_GOT_GR_COIN_PIECE_BOTTOM_RIGHT
	script_jump_if_b0z .ows_2cff1
	print_npc_text Text0b85
	script_command_02
	end_script
	ret
.ows_2cff1
	check_event EVENT_TALKED_TO_ROBERT
	script_jump_if_b0nz .ows_2cffc
	print_npc_text Text0b86
	script_jump .ows_2d001
.ows_2cffc
	set_event EVENT_TALKED_TO_ROBERT
	print_npc_text Text0b87
.ows_2d001
	script_command_02
	end_script
	ret
.ows_2d004
	check_event EVENT_TALKED_TO_ROBERT
	script_jump_if_b0z .ows_2d011
	set_event EVENT_TALKED_TO_ROBERT
	print_npc_text Text0b88
	script_jump .ows_2d014
.ows_2d011
	print_npc_text Text0b89
.ows_2d014
	ask_question Text0b8a, TRUE
	script_jump_if_b0z .ows_2d024
	print_npc_text Text0b8b
	script_command_02
	start_duel PHANTOM_DECK_ID, MUSIC_MATCHSTART_1
	end_script
	ret
.ows_2d024
	print_npc_text Text0b8c
	script_command_02
	end_script
	ret

Func_2d02a:
	xor a
	start_script
	script_command_01
	check_event EVENT_SET_UNTIL_MAP_RELOAD_2
	script_jump_if_b0nz .ows_2d040
	print_npc_text Text0b8d
	give_booster_packs BoosterList_cd33
	print_npc_text Text0b8e
	script_jump .ows_2d043
.ows_2d040
	print_npc_text Text0b8f
.ows_2d043
	script_command_02
	end_script
	ret

Func_2d046:
	ld a, $28
	ld [wScriptNPC], a
	ld hl, $9f2
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	check_event EVENT_GODAS_ROOM_CAGE_STATE
	script_jump_if_b0z .ows_2d071
	check_event EVENT_GOT_GR_COIN_PIECE_BOTTOM_RIGHT
	script_jump_if_b0z .ows_2d06b
	print_npc_text Text0b90
	script_command_02
	end_script
	ret
.ows_2d06b
	print_npc_text Text0b91
	script_command_02
	end_script
	ret
.ows_2d071
	check_event EVENT_TALKED_TO_DANIEL
	script_jump_if_b0z .ows_2d07e
	set_event EVENT_TALKED_TO_DANIEL
	print_npc_text Text0b92
	script_jump .ows_2d081
.ows_2d07e
	print_npc_text Text0b93
.ows_2d081
	ask_question Text0b94, TRUE
	script_jump_if_b0z .ows_2d091
	print_npc_text Text0b95
	script_command_02
	start_duel PUPPET_MASTER_DECK_ID, MUSIC_MATCHSTART_1
	end_script
	ret
.ows_2d091
	print_npc_text Text0b96
	script_command_02
	end_script
	ret

Func_2d097:
	xor a
	start_script
	script_command_01
	check_event EVENT_SET_UNTIL_MAP_RELOAD_2
	script_jump_if_b0nz .ows_2d0ad
	print_npc_text Text0b97
	give_booster_packs BoosterList_cd36
	print_npc_text Text0b98
	script_jump .ows_2d0b0
.ows_2d0ad
	print_npc_text Text0b99
.ows_2d0b0
	script_command_02
	end_script
	ret

Func_2d0b3:
	ld a, $29
	ld [wScriptNPC], a
	ld hl, $9f3
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	check_event EVENT_GODAS_ROOM_CAGE_STATE
	script_jump_if_b0z .ows_2d11c
	check_event EVENT_GOT_GR_COIN_PIECE_BOTTOM_RIGHT
	script_jump_if_b0z .ows_2d0eb
	print_npc_text Text0b9a
	ask_question Text0b9b, TRUE
	script_jump_if_b0z .ows_2d0e5
	print_npc_text Text0b9c
	script_command_02
	start_duel PSYCHOKINESIS_DECK_ID, MUSIC_MATCHSTART_1
	end_script
	ret
.ows_2d0e5
	print_npc_text Text0b9d
	script_command_02
	end_script
	ret
.ows_2d0eb
	check_event EVENT_SET_UNTIL_MAP_RELOAD_1
	script_jump_if_b0z .ows_2d116
	check_event EVENT_TALKED_TO_STEPHANIE
	script_jump_if_b0z .ows_2d0fd
	set_event EVENT_TALKED_TO_STEPHANIE
	print_npc_text Text0b9e
	script_jump .ows_2d100
.ows_2d0fd
	print_npc_text Text0b9f
.ows_2d100
	ask_question Text0b9b, TRUE
	script_jump_if_b0z .ows_2d110
	print_npc_text Text0ba0
	script_command_02
	start_duel PSYCHOKINESIS_DECK_ID, MUSIC_MATCHSTART_1
	end_script
	ret
.ows_2d110
	print_npc_text Text0ba1
	script_jump .ows_2d119
.ows_2d116
	print_npc_text Text0ba2
.ows_2d119
	script_command_02
	end_script
	ret
.ows_2d11c
	check_event EVENT_TALKED_TO_STEPHANIE
	script_jump_if_b0z .ows_2d129
	set_event EVENT_TALKED_TO_STEPHANIE
	print_npc_text Text0ba3
	script_jump .ows_2d12c
.ows_2d129
	print_npc_text Text0ba4
.ows_2d12c
	ask_question Text0b9b, TRUE
	script_jump_if_b0z .ows_2d13c
	print_npc_text Text0ba5
	script_command_02
	start_duel PSYCHOKINESIS_DECK_ID, MUSIC_MATCHSTART_1
	end_script
	ret
.ows_2d13c
	print_npc_text Text0ba6
	script_command_02
	end_script
	ret

Func_2d142:
	xor a
	start_script
	script_command_01
	check_event EVENT_GODAS_ROOM_CAGE_STATE
	script_jump_if_b0z .ows_2d179
	check_event EVENT_GOT_GR_COIN_PIECE_BOTTOM_RIGHT
	script_jump_if_b0z .ows_2d162
	check_event EVENT_SET_UNTIL_MAP_RELOAD_2
	script_jump_if_b0nz .ows_2d15c
	print_npc_text Text0ba7
	script_jump .ows_2d15f
.ows_2d15c
	print_npc_text Text0ba8
.ows_2d15f
	script_command_02
	end_script
	ret
.ows_2d162
	check_event EVENT_SET_UNTIL_MAP_RELOAD_2
	script_jump_if_b0nz .ows_2d173
	print_npc_text Text0ba9
	give_booster_packs BoosterList_cd39
	print_npc_text Text0baa
	script_jump .ows_2d176
.ows_2d173
	print_npc_text Text0bab
.ows_2d176
	script_command_02
	end_script
	ret
.ows_2d179
	check_event EVENT_SET_UNTIL_MAP_RELOAD_2
	script_jump_if_b0nz .ows_2d18a
	print_npc_text Text0bac
	give_booster_packs BoosterList_cd3c
	print_npc_text Text0bad
	script_jump .ows_2d18d
.ows_2d18a
	print_npc_text Text0bae
.ows_2d18d
	script_command_02
	end_script
	ret

Func_2d190:
	ld a, $31
	ld [wScriptNPC], a
	ld hl, $a2b
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	check_event EVENT_WALKED_INTO_MURRAYS_CLUB_ROOM
	script_jump_if_b0nz .ows_2d1c8
	check_event EVENT_A7
	script_jump_if_b0z .ows_2d1c2
	check_event EVENT_TALKED_TO_GR4_PSYCHIC_CLUB
	script_jump_if_b0z .ows_2d1bc
	set_event EVENT_TALKED_TO_GR4_PSYCHIC_CLUB
	print_npc_text Text0baf
	script_jump .ows_2d20b
.ows_2d1bc
	print_npc_text Text0bb0
	script_jump .ows_2d20b
.ows_2d1c2
	print_npc_text Text0bb1
	script_jump .ows_2d20b
.ows_2d1c8
	check_event EVENT_A7
	script_jump_if_b0z .ows_2d1e0
	check_event EVENT_TALKED_TO_GR4_PSYCHIC_CLUB
	script_jump_if_b0z .ows_2d1da
	set_event EVENT_TALKED_TO_GR4_PSYCHIC_CLUB
	print_npc_text Text0bb2
	script_jump .ows_2d1e3
.ows_2d1da
	print_npc_text Text0bb3
	script_jump .ows_2d1e3
.ows_2d1e0
	print_npc_text Text0bb4
.ows_2d1e3
	ask_question Text0bb5, TRUE
	script_jump_if_b0z .ows_2d1f7
	check_event EVENT_A7
	print_variable_npc_text Text0bb6, Text0bb7
	script_command_02
	start_duel GREAT_ROCKET4_DECK_ID, MUSIC_DITTY_1
	end_script
	ret
.ows_2d1f7
	check_event EVENT_A7
	script_jump_if_b0z .ows_2d208
	check_event EVENT_OBTAINED_TWO_GR_COIN_PIECES
	set_event EVENT_OBTAINED_TWO_GR_COIN_PIECES
	print_variable_npc_text Text0bb8, Text0bb9
	script_jump .ows_2d20b
.ows_2d208
	print_npc_text Text0bba
.ows_2d20b
	script_command_02
	end_script
	ret

Func_2d20e:
	xor a
	start_script
	script_command_01
	check_event EVENT_SET_UNTIL_MAP_RELOAD_2
	script_jump_if_b0nz .ows_2d225
	check_event EVENT_A7
	print_variable_npc_text Text0bbb, Text0bbc
	give_booster_packs BoosterList_cd4c
	script_jump Script_2d2d1
.ows_2d225
	set_event EVENT_WALKED_INTO_MURRAYS_CLUB_ROOM
	check_event EVENT_A7
	script_jump_if_b0z .ows_2d236
	set_event EVENT_A7
	reset_event EVENT_TALKED_TO_MURRAY
	print_npc_text Text0bbd
	script_jump .ows_2d239
.ows_2d236
	print_npc_text Text0bbe
.ows_2d239
	script_command_02
	end_script
	ret

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

Script_2d249:
	print_npc_text Text0bbf
	script_command_02
	get_player_direction
	compare_loaded_var $00
	script_jump_if_b0z .ows_2d25d
	move_active_npc NPCMovement_2d296
	move_player NPCMovement_2d29f, TRUE
	script_jump .ows_2d264

.ows_2d25d
	move_active_npc NPCMovement_2d2ae
	move_player NPCMovement_2d2b7, TRUE
.ows_2d264
	wait_for_player_animation
	script_command_01
	print_npc_text Text0bc0
	give_deck UNFORGIVING_ANTI_GR4_DECK_ID
	script_jump_if_b1nz .ows_2d278
	play_song MUSIC_BOOSTER_PACK
	print_text Text0bc1
	wait_song
	resume_song
	script_jump .ows_2d285

.ows_2d278
	print_npc_text Text0bc2
	play_song MUSIC_BOOSTER_PACK
	print_text Text0bc3
	wait_song
	resume_song
	print_npc_text Text0bc4
.ows_2d285
	set_event EVENT_GOT_ALAKAZAM_COIN
	print_npc_text Text0bc5
	give_coin COIN_ALAKAZAM
	print_npc_text Text0bc6
	script_command_02
	move_active_npc NPCMovement_2d2c6
	wait_for_player_animation
	end_script
	ret

NPCMovement_2d296:
	db SOUTH, RUN_2
	db WEST, RUN_2
	db SOUTH, RUN_4
	db WEST, RUN_1
	db $ff

NPCMovement_2d29f:
	db SOUTH | MOVE_BACKWARDS, RUN_1
	db EAST, RUN_0
	db WEST | MOVE_BACKWARDS, RUN_2
	db NORTH, RUN_0
	db SOUTH | MOVE_BACKWARDS, RUN_4
	db EAST, RUN_0
	db WEST | MOVE_BACKWARDS, RUN_2
	db $ff

NPCMovement_2d2ae:
	db NORTH, RUN_2
	db WEST, RUN_2
	db SOUTH, RUN_8
	db WEST, RUN_1
	db $ff

NPCMovement_2d2b7:
	db NORTH | MOVE_BACKWARDS, RUN_1
	db EAST, RUN_0
	db WEST | MOVE_BACKWARDS, RUN_2
	db NORTH, RUN_0
	db SOUTH | MOVE_BACKWARDS, RUN_8
	db EAST, RUN_0
	db WEST | MOVE_BACKWARDS, RUN_2
	db $ff

NPCMovement_2d2c6:
	db EAST, MOVE_1
	db NORTH, MOVE_4
	db EAST, MOVE_2
	db NORTH, MOVE_2
	db SOUTH, MOVE_0
	db $ff

Script_2d2d1:
	set_event EVENT_SET_UNTIL_MAP_RELOAD_1
	set_event EVENT_GOT_GR_COIN_PIECE_BOTTOM_RIGHT
	check_event EVENT_GOT_GR_COIN
	print_variable_npc_text Text0bc7, Text0bc8
	give_coin COIN_GR_START + COIN_GR_PIECE4
	print_variable_npc_text Text0bc9, Text0bca
	script_command_02
	get_player_direction
	compare_loaded_var $00
	script_jump_if_b0z .ows_2d2ef
	set_player_direction WEST
	animate_player_movement $81, $02
.ows_2d2ef
	quit_script
; 0x2d2f0

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
	npc NPC_ROCK_CLUB_LASS, 5, 6, EAST, $0
	npc NPC_ROCK_CLUB_WOMAN, 12, 10, NORTH, $0
	npc NPC_IMAKUNI_BLACK, 1, 10, WEST, Func_2d57c
	npc NPC_ROCK_CLUB_CHAP, 8, 9, WEST, $0
	npc NPC_ROCK_CLUB_CAPPED_LAD, 10, 3, SOUTH, $0
	npc NPC_CLERK_BATTLE_CENTER, 2, 2, SOUTH, $0
	npc NPC_CLERK_GIFT_CENTER, 4, 2, SOUTH, $0
	db $ff

RockClubLobby_NPCInteractions:
	npc_script NPC_ROCK_CLUB_LASS, Func_2d4e0
	npc_script NPC_ROCK_CLUB_WOMAN, Func_2d546
	npc_script NPC_IMAKUNI_BLACK, Func_3c30c
	npc_script NPC_ROCK_CLUB_CHAP, Func_2d58b
	npc_script NPC_ROCK_CLUB_CAPPED_LAD, Func_2d5c7
	db $ff

RockClubLobby_OWInteractions:
	ow_script 8, 2, PCMenu
	ow_script 9, 2, PCMenu
	ow_script 2, 4, Func_3c1b9
	ow_script 4, 4, Func_3c2d9
	ow_script 12, 2, Func_40108
	ow_script 13, 2, Func_4011e
	ow_script 14, 2, Func_40134
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

Func_2d4e0:
	ld a, $6a
	ld [wScriptNPC], a
	ld hl, $a36
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	check_event EVENT_TRADED_CARDS_ROCK_CLUB
	script_jump_if_b0z .ows_2d540
	check_event EVENT_TALKED_TO_TRADE_NPC_ROCK_CLUB
	script_jump_if_b0z .ows_2d507
	set_event EVENT_TALKED_TO_TRADE_NPC_ROCK_CLUB
	print_npc_text Text1103
	script_jump .ows_2d50a
.ows_2d507
	print_npc_text Text1104
.ows_2d50a
	ask_question TradeCardsPromptText, TRUE
	script_jump_if_b0nz .ows_2d517
	print_npc_text Text1105
	script_jump .ows_2d543
.ows_2d517
	get_card_count_in_collection_and_decks SNORLAX_LV20
	script_jump_if_b0z .ows_2d523
	print_npc_text Text1106
	script_jump .ows_2d543
.ows_2d523
	get_card_count_in_collection SNORLAX_LV20
	script_jump_if_b0z .ows_2d52f
	print_npc_text Text1107
	script_jump .ows_2d543
.ows_2d52f
	print_npc_text Text1108
	receive_card JIGGLYPUFF_LV12
	take_card SNORLAX_LV20
	set_event EVENT_TRADED_CARDS_ROCK_CLUB
	print_npc_text Text1109
	script_jump .ows_2d543
.ows_2d540
	print_npc_text Text110a
.ows_2d543
	script_command_02
	end_script
	ret

Func_2d546:
	ld a, $6b
	ld [wScriptNPC], a
	ld hl, $a3e
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	compare_var VAR_25, $04
	script_jump_if_b0nz .ows_2d576
	script_callfar Script_3c2f0
	check_event EVENT_GOT_GR_COIN
	script_jump_if_b0z .ows_2d570
	print_npc_text Text110b
	script_jump .ows_2d579
.ows_2d570
	print_npc_text Text110c
	script_jump .ows_2d579
.ows_2d576
	print_npc_text Text110d
.ows_2d579
	script_command_02
	end_script
	ret

Func_2d57c:
	ld a, $25
	farcall GetVarValue
	cp $04
	jr z, .asm_2d588
	scf
	ret
.asm_2d588
	scf
	ccf
	ret

Func_2d58b:
	ld a, $6c
	ld [wScriptNPC], a
	ld hl, $a32
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	check_event EVENT_GODAS_ROOM_CAGE_STATE
	script_jump_if_b0z .ows_2d5c1
	check_event EVENT_GOT_GR_COIN
	script_jump_if_b0z .ows_2d5bb
	check_event EVENT_MET_GR1_ROCK_CLUB
	script_jump_if_b0z .ows_2d5b5
	print_npc_text Text110e
	script_jump .ows_2d5c4
.ows_2d5b5
	print_npc_text Text110f
	script_jump .ows_2d5c4
.ows_2d5bb
	print_npc_text Text1110
	script_jump .ows_2d5c4
.ows_2d5c1
	print_npc_text Text1111
.ows_2d5c4
	script_command_02
	end_script
	ret

Func_2d5c7:
	ld a, $6d
	ld [wScriptNPC], a
	ld hl, $a4c
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	check_event EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE
	script_jump_if_b0z .ows_2d5f2
	check_event EVENT_GOT_GR_COIN
	script_jump_if_b0z .ows_2d5ec
	print_npc_text Text1112
	script_jump .ows_2d5f5
.ows_2d5ec
	print_npc_text Text1113
	script_jump .ows_2d5f5
.ows_2d5f2
	print_npc_text Text1114
.ows_2d5f5
	script_command_02
	end_script
	ret

RockClub_MapHeader:
	db MAP_GFX_ROCK_CLUB
	dba RockClub_MapScripts
	db MUSIC_CLUB_2

RockClub_StepEvents:
	map_exit 6, 14, MAP_ROCK_CLUB_ENTRANCE, 4, 1, SOUTH
	map_exit 7, 14, MAP_ROCK_CLUB_ENTRANCE, 5, 1, SOUTH
	db $ff

RockClub_NPCs:
	npc NPC_GENE, 7, 2, SOUTH, $0
	npc NPC_MATTHEW, 2, 3, SOUTH, $0
	npc NPC_RYAN, 9, 7, EAST, $0
	npc NPC_ANDREW, 3, 8, EAST, $0
	npc NPC_GR_1, 7, 3, NORTH, Func_2d8f3
	db $ff

RockClub_NPCInteractions:
	npc_script NPC_GENE, Func_2d754
	npc_script NPC_MATTHEW, Func_2d7ea
	npc_script NPC_RYAN, Func_2d841
	npc_script NPC_ANDREW, Func_2d89c
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
	npc_script NPC_GENE, Func_2d7c3
	npc_script NPC_MATTHEW, Func_2d825
	npc_script NPC_RYAN, Func_2d87e
	npc_script NPC_ANDREW, Func_2d8d7
	db $ff
; 0x2d6ca

SECTION "Bank b@5754", ROMX[$5754], BANK[$b]

Func_2d754:
	ld a, $09
	ld [wScriptNPC], a
	ld hl, $9d4
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	check_event EVENT_TALKED_TO_GENE
	script_jump_if_b0z .ows_2d776
	set_event EVENT_TALKED_TO_GENE
	print_npc_text Text10d5
	script_jump .ows_2d7a3
.ows_2d776
	check_event EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE
	script_jump_if_b0z .ows_2d788
	check_event EVENT_GOT_GR_COIN
	script_jump_if_b0z .ows_2d78e
	check_event EVENT_GOT_KABUTO_COIN
	script_jump_if_b0z .ows_2d794
	script_jump .ows_2d79a
.ows_2d788
	print_npc_text Text10d6
	script_jump .ows_2d7a0
.ows_2d78e
	print_npc_text Text10d7
	script_jump .ows_2d7a0
.ows_2d794
	print_npc_text Text10d8
	script_jump .ows_2d7a0
.ows_2d79a
	print_npc_text Text10d9
	script_jump .ows_2d7a3
.ows_2d7a0
	print_npc_text Text10da
.ows_2d7a3
	ask_question Text10db, TRUE
	script_jump_if_b0z .ows_2d7b7
	check_event EVENT_GOT_KABUTO_COIN
	print_variable_npc_text Text10dc, Text10dd
	script_command_02
	start_duel EVEN3_YEARS_ON_A_ROCK_DECK_ID, MUSIC_MATCHSTART_2
	end_script
	ret
.ows_2d7b7
	check_event EVENT_GOT_KABUTO_COIN
	print_variable_npc_text Text10de, Text10df
	set_active_npc_direction SOUTH
	script_command_02
	end_script
	ret

Func_2d7c3:
	xor a
	start_script
	script_command_01
	check_event EVENT_SET_UNTIL_MAP_RELOAD_2
	script_jump_if_b0nz .ows_2d7de
	check_event EVENT_GOT_KABUTO_COIN
	script_jump_if_b0nz Script_2d900
	print_npc_text Text10e0
	give_booster_packs BoosterList_ccaa
	print_npc_text Text10e1
	script_jump .ows_2d7e5
.ows_2d7de
	check_event EVENT_GOT_KABUTO_COIN
	print_variable_npc_text Text10e2, Text10e3
.ows_2d7e5
	set_active_npc_direction SOUTH
	script_command_02
	end_script
	ret

Func_2d7ea:
	ld a, $0a
	ld [wScriptNPC], a
	ld hl, $9d5
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	check_event EVENT_TALKED_TO_MATTHEW
	script_jump_if_b0z .ows_2d80c
	set_event EVENT_TALKED_TO_MATTHEW
	print_npc_text Text10e4
	script_jump .ows_2d80f
.ows_2d80c
	print_npc_text Text10e5
.ows_2d80f
	ask_question Text10e6, TRUE
	script_jump_if_b0z .ows_2d81f
	print_npc_text Text10e7
	script_command_02
	start_duel ROLLING_STONE_DECK_ID, MUSIC_MATCHSTART_1
	end_script
	ret
.ows_2d81f
	print_npc_text Text10e8
	script_command_02
	end_script
	ret

Func_2d825:
	xor a
	start_script
	script_command_01
	check_event EVENT_SET_UNTIL_MAP_RELOAD_2
	script_jump_if_b0nz .ows_2d83b
	print_npc_text Text10e9
	give_booster_packs BoosterList_ccae
	print_npc_text Text10ea
	script_jump .ows_2d83e
.ows_2d83b
	print_npc_text Text10eb
.ows_2d83e
	script_command_02
	end_script
	ret

Func_2d841:
	ld a, $0b
	ld [wScriptNPC], a
	ld hl, $9d6
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	check_event EVENT_TALKED_TO_RYAN
	script_jump_if_b0z .ows_2d863
	set_event EVENT_TALKED_TO_RYAN
	print_npc_text Text10ec
	script_jump .ows_2d866
.ows_2d863
	print_npc_text Text10ed
.ows_2d866
	ask_question Text10ee, TRUE
	script_jump_if_b0z .ows_2d876
	print_npc_text Text10ef
	script_command_02
	start_duel GREAT_EARTHQUAKE_DECK_ID, MUSIC_MATCHSTART_1
	end_script
	ret
.ows_2d876
	print_npc_text Text10f0
	set_active_npc_direction EAST
	script_command_02
	end_script
	ret

Func_2d87e:
	xor a
	start_script
	script_command_01
	check_event EVENT_SET_UNTIL_MAP_RELOAD_2
	script_jump_if_b0nz .ows_2d894
	print_npc_text Text10f1
	give_booster_packs BoosterList_ccb1
	print_npc_text Text10f2
	script_jump .ows_2d897
.ows_2d894
	print_npc_text Text10f3
.ows_2d897
	set_active_npc_direction EAST
	script_command_02
	end_script
	ret

Func_2d89c:
	ld a, $0c
	ld [wScriptNPC], a
	ld hl, $9d7
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	check_event EVENT_TALKED_TO_ANDREW
	script_jump_if_b0z .ows_2d8be
	set_event EVENT_TALKED_TO_ANDREW
	print_npc_text Text10f4
	script_jump .ows_2d8c1
.ows_2d8be
	print_npc_text Text10f5
.ows_2d8c1
	ask_question Text10f6, TRUE
	script_jump_if_b0z .ows_2d8d1
	print_npc_text Text10f7
	script_command_02
	start_duel AWESOME_FOSSIL_DECK_ID, MUSIC_MATCHSTART_1
	end_script
	ret
.ows_2d8d1
	print_npc_text Text10f8
	script_command_02
	end_script
	ret

Func_2d8d7:
	xor a
	start_script
	script_command_01
	check_event EVENT_SET_UNTIL_MAP_RELOAD_2
	script_jump_if_b0nz .ows_2d8ed
	print_npc_text Text10f9
	give_booster_packs BoosterList_ccb4
	print_npc_text Text10fa
	script_jump .ows_2d8f0
.ows_2d8ed
	print_npc_text Text10fb
.ows_2d8f0
	script_command_02
	end_script
	ret

Func_2d8f3:
	ld a, $98
	farcall GetEventValue
	jr z, .asm_2d8fd
	scf
	ret
.asm_2d8fd
	scf
	ccf
	ret

Script_2d900:
	print_npc_text Text10fc
	give_deck SWEAT_ANTI_GR1_DECK_ID
	script_jump_if_b1nz .ows_2d912
	play_song MUSIC_BOOSTER_PACK
	print_text Text10fd
	wait_song
	resume_song
	script_jump .ows_2d91f

.ows_2d912
	print_npc_text Text10fe
	play_song MUSIC_BOOSTER_PACK
	print_text Text10ff
	wait_song
	resume_song
	print_npc_text Text1100
.ows_2d91f
	set_event EVENT_GOT_KABUTO_COIN
	reset_event EVENT_TALKED_TO_GR1_FIGHTING_CLUB
	print_npc_text Text1101
	give_coin COIN_KABUTO
	print_npc_text Text1102
	set_active_npc_direction SOUTH
	script_command_02
	end_script
	ret

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
	npc NPC_FIGHTING_CLUB_PAPPY, 1, 5, SOUTH, $0
	npc NPC_FIGHTING_CLUB_GLASSES_KID, 4, 9, EAST, $0
	npc NPC_FIGHTING_CLUB_CAPPED_GUY, 7, 9, WEST, $0
	npc NPC_FIGHTING_CLUB_CAPPED_LASS, 6, 8, SOUTH, $0
	npc NPC_CLERK_BATTLE_CENTER, 2, 2, SOUTH, $0
	npc NPC_CLERK_GIFT_CENTER, 4, 2, SOUTH, $0
	npc NPC_MICHAEL, 11, 6, EAST, Func_2db97
	db $ff

FightingClubLobby_NPCInteractions:
	npc_script NPC_FIGHTING_CLUB_PAPPY, Func_2dbac
	npc_script NPC_FIGHTING_CLUB_GLASSES_KID, Func_2dc17
	npc_script NPC_FIGHTING_CLUB_CAPPED_GUY, Func_2dc48
	npc_script NPC_FIGHTING_CLUB_CAPPED_LASS, Func_2dc79
	npc_script NPC_MICHAEL, Func_2db0e
	db $ff

FightingClubLobby_OWInteractions:
	ow_script 8, 2, PCMenu
	ow_script 9, 2, PCMenu
	ow_script 2, 4, Func_3c1b9
	ow_script 4, 4, Func_3c2d9
	ow_script 12, 2, Func_4014a
	ow_script 13, 2, Func_40160
	ow_script 14, 2, Func_40176
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
	npc_script NPC_MICHAEL, Func_2db7b
	db $ff

Func_2db0e:
	ld a, $0e
	ld [wScriptNPC], a
	ld hl, $9d9
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	check_event EVENT_SET_UNTIL_MAP_RELOAD_1
	script_jump_if_b0z .ows_2db62
	check_event EVENT_TALKED_TO_MICHAEL
	script_jump_if_b0z .ows_2db45
	set_event EVENT_TALKED_TO_MICHAEL
	print_npc_text Text08c4
.ows_2db32
	npc_ask_question Text08c5, TRUE
	script_jump_if_b0nz .ows_2db3f
	print_npc_text Text08c6
	script_jump .ows_2db32
.ows_2db3f
	print_npc_text Text08c7
	script_jump .ows_2db4c
.ows_2db45
	check_event EVENT_MET_GR1_ROCK_CLUB
	print_variable_npc_text Text08c8, Text08c9
.ows_2db4c
	ask_question Text08ca, TRUE
	script_jump_if_b0z .ows_2db5c
	print_npc_text Text08cb
	script_command_02
	start_duel YOU_CAN_DO_IT_MACHOP_DECK_ID, MUSIC_MATCHSTART_1
	end_script
	ret
.ows_2db5c
	print_npc_text Text08cc
	script_command_02
	end_script
	ret
.ows_2db62
	print_npc_text Text08cd
	ask_question Text08ca, TRUE
	script_jump_if_b0z .ows_2db75
	print_npc_text Text08cb
	script_command_02
	start_duel YOU_CAN_DO_IT_MACHOP_DECK_ID, MUSIC_MATCHSTART_1
	end_script
	ret
.ows_2db75
	print_npc_text Text08cc
	script_command_02
	end_script
	ret

Func_2db7b:
	xor a
	start_script
	script_command_01
	check_event EVENT_SET_UNTIL_MAP_RELOAD_2
	script_jump_if_b0nz .ows_2db91
	print_npc_text Text08ce
	give_booster_packs BoosterList_ccbb
	print_npc_text Text08cf
	script_jump .ows_2db94
.ows_2db91
	print_npc_text Text08d0
.ows_2db94
	script_command_02
	end_script
	ret

Func_2db97:
	ld a, $ed
	farcall GetEventValue
	jr nz, .asm_2dba9
	ld a, $0c
	farcall GetEventValue
	jr z, .asm_2dba9
	scf
	ret
.asm_2dba9
	scf
	ccf
	ret

Func_2dbac:
	ld a, $6e
	ld [wScriptNPC], a
	ld hl, $a3d
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	check_event EVENT_TRADED_CARDS_FIGHTING_CLUB
	script_jump_if_b0z .ows_2dc0f
	check_event EVENT_TALKED_TO_TRADE_NPC_FIGHTING_CLUB
	script_jump_if_b0z .ows_2dbd3
	set_event EVENT_TALKED_TO_TRADE_NPC_FIGHTING_CLUB
	print_npc_text Text08d1
	script_jump .ows_2dbd6
.ows_2dbd3
	print_npc_text Text08d2
.ows_2dbd6
	print_npc_text Text08d3
	ask_question TradeCardsPromptText, TRUE
	script_jump_if_b0nz .ows_2dbe6
	print_npc_text Text08d4
	script_jump .ows_2dc12
.ows_2dbe6
	get_card_count_in_collection_and_decks HITMONLEE_LV23
	script_jump_if_b0z .ows_2dbf2
	print_npc_text Text08d5
	script_jump .ows_2dc12
.ows_2dbf2
	get_card_count_in_collection HITMONLEE_LV23
	script_jump_if_b0z .ows_2dbfe
	print_npc_text Text08d6
	script_jump .ows_2dc12
.ows_2dbfe
	print_npc_text Text08d7
	receive_card MEWTWO_ALT_LV60
	take_card HITMONLEE_LV23
	set_event EVENT_TRADED_CARDS_FIGHTING_CLUB
	print_npc_text Text08d8
	script_jump .ows_2dc12
.ows_2dc0f
	print_npc_text Text08d9
.ows_2dc12
	script_command_02
	set_active_npc_direction SOUTH
	end_script
	ret

Func_2dc17:
	ld a, $6f
	ld [wScriptNPC], a
	ld hl, $a51
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	check_event EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE
	script_jump_if_b0z .ows_2dc42
	check_event EVENT_GOT_GR_COIN
	script_jump_if_b0z .ows_2dc3c
	print_npc_text Text08da
	script_jump .ows_2dc45
.ows_2dc3c
	print_npc_text Text08db
	script_jump .ows_2dc45
.ows_2dc42
	print_npc_text Text08dc
.ows_2dc45
	script_command_02
	end_script
	ret

Func_2dc48:
	ld a, $70
	ld [wScriptNPC], a
	ld hl, $a54
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	check_event EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE
	script_jump_if_b0z .ows_2dc73
	check_event EVENT_GOT_GR_COIN
	script_jump_if_b0z .ows_2dc6d
	print_npc_text Text08dd
	script_jump .ows_2dc76
.ows_2dc6d
	print_npc_text Text08de
	script_jump .ows_2dc76
.ows_2dc73
	print_npc_text Text08df
.ows_2dc76
	script_command_02
	end_script
	ret

Func_2dc79:
	ld a, $71
	ld [wScriptNPC], a
	ld hl, $a4c
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	check_event EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE
	script_jump_if_b0z .ows_2dc99
	print_npc_text Text08e0
	script_jump .ows_2dc9c
.ows_2dc99
	print_npc_text Text08e1
.ows_2dc9c
	script_command_02
	end_script
	ret

FightingClub_MapHeader:
	db MAP_GFX_FIGHTING_CLUB
	dba FightingClub_MapScripts
	db MUSIC_CLUB_3

FightingClub_StepEvents:
	map_exit 5, 11, MAP_FIGHTING_CLUB_ENTRANCE, 4, 1, SOUTH
	map_exit 6, 11, MAP_FIGHTING_CLUB_ENTRANCE, 5, 1, SOUTH
	db $ff

FightingClub_NPCs:
	npc NPC_MITCH, 5, 2, SOUTH, Func_2dde4
	npc NPC_MICHAEL, 7, 7, SOUTH, Func_2df9c
	npc NPC_CHRIS, 2, 5, SOUTH, Func_2df9c
	npc NPC_JESSICA, 9, 4, SOUTH, Func_2df9c
	npc NPC_GR_1, 6, 2, SOUTH, Func_2e023
	db $ff

FightingClub_NPCInteractions:
	npc_script NPC_MITCH, Func_2dd62
	npc_script NPC_MICHAEL, Func_2ddf1
	npc_script NPC_CHRIS, Func_2dead
	npc_script NPC_JESSICA, Func_2df3a
	npc_script NPC_GR_1, Func_2dfb1
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
	npc_script NPC_MITCH, Func_2ddc8
	npc_script NPC_MICHAEL, Func_2de75
	npc_script NPC_CHRIS, Func_2df1e
	npc_script NPC_JESSICA, Func_2df80
	npc_script NPC_GR_1, Func_2e008
	db $ff

Func_2dd62:
	ld a, $0d
	ld [wScriptNPC], a
	ld hl, $9d8
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	check_event EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE
	script_jump_if_b0z .ows_2dda2
	check_event EVENT_TALKED_TO_MITCH
	script_jump_if_b0z .ows_2dd89
	set_event EVENT_TALKED_TO_MITCH
	print_npc_text Text088c
	script_jump .ows_2dd8c
.ows_2dd89
	print_npc_text Text088d
.ows_2dd8c
	ask_question Text088e, TRUE
	script_jump_if_b0z .ows_2dd9c
	print_npc_text Text088f
	script_command_02
	start_duel RAGING_BILLOW_OF_FISTS_DECK_ID, MUSIC_MATCHSTART_2
	end_script
	ret
.ows_2dd9c
	print_npc_text Text0890
	script_command_02
	end_script
	ret
.ows_2dda2
	check_event EVENT_TALKED_TO_MITCH
	script_jump_if_b0z .ows_2ddaf
	set_event EVENT_TALKED_TO_MITCH
	print_npc_text Text0891
	script_jump .ows_2ddb2
.ows_2ddaf
	print_npc_text Text088d
.ows_2ddb2
	ask_question Text088e, TRUE
	script_jump_if_b0z .ows_2ddc2
	print_npc_text Text088f
	script_command_02
	start_duel RAGING_BILLOW_OF_FISTS_DECK_ID, MUSIC_MATCHSTART_2
	end_script
	ret
.ows_2ddc2
	print_npc_text Text0890
	script_command_02
	end_script
	ret

Func_2ddc8:
	xor a
	start_script
	script_command_01
	check_event EVENT_SET_UNTIL_MAP_RELOAD_2
	script_jump_if_b0nz .ows_2ddde
	print_npc_text Text0892
	give_booster_packs BoosterList_ccb7
	print_npc_text Text0893
	script_jump .ows_2dde1
.ows_2ddde
	print_npc_text Text0894
.ows_2dde1
	script_command_02
	end_script
	ret

Func_2dde4:
	ld a, $b9
	farcall GetEventValue
	jr nz, .asm_2ddee
	scf
	ret
.asm_2ddee
	scf
	ccf
	ret

Func_2ddf1:
	ld a, $0e
	ld [wScriptNPC], a
	ld hl, $9d9
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	check_event EVENT_GODAS_ROOM_CAGE_STATE
	script_jump_if_b0z .ows_2de4f
	check_event EVENT_GOT_GR_COIN
	script_jump_if_b0z .ows_2de29
	print_npc_text Text0895
	ask_question Text0896, TRUE
	script_jump_if_b0z .ows_2de23
	print_npc_text Text0897
	script_command_02
	start_duel YOU_CAN_DO_IT_MACHOP_DECK_ID, MUSIC_MATCHSTART_1
	end_script
	ret
.ows_2de23
	print_npc_text Text0898
	script_command_02
	end_script
	ret
.ows_2de29
	check_event EVENT_TALKED_TO_MICHAEL
	script_jump_if_b0z .ows_2de36
	set_event EVENT_TALKED_TO_MICHAEL
	print_npc_text Text0899
	script_jump .ows_2de39
.ows_2de36
	print_npc_text Text089a
.ows_2de39
	ask_question Text0896, TRUE
	script_jump_if_b0z .ows_2de49
	print_npc_text Text089b
	script_command_02
	start_duel NEW_MACHOKE_DECK_ID, MUSIC_MATCHSTART_1
	end_script
	ret
.ows_2de49
	print_npc_text Text089c
	script_command_02
	end_script
	ret
.ows_2de4f
	check_event EVENT_TALKED_TO_MICHAEL
	script_jump_if_b0z .ows_2de5c
	set_event EVENT_TALKED_TO_MICHAEL
	print_npc_text Text089d
	script_jump .ows_2de5f
.ows_2de5c
	print_npc_text Text089a
.ows_2de5f
	ask_question Text0896, TRUE
	script_jump_if_b0z .ows_2de6f
	print_npc_text Text089b
	script_command_02
	start_duel NEW_MACHOKE_DECK_ID, MUSIC_MATCHSTART_1
	end_script
	ret
.ows_2de6f
	print_npc_text Text089c
	script_command_02
	end_script
	ret

Func_2de75:
	xor a
	start_script
	script_command_01
	check_event EVENT_GOT_GR_COIN
	script_jump_if_b0z .ows_2de96
	check_event EVENT_SET_UNTIL_MAP_RELOAD_2
	script_jump_if_b0nz .ows_2de90
	print_npc_text Text089e
	give_booster_packs BoosterList_ccbb
	print_npc_text Text089f
	script_jump .ows_2de93
.ows_2de90
	print_npc_text Text08a0
.ows_2de93
	script_command_02
	end_script
	ret
.ows_2de96
	check_event EVENT_SET_UNTIL_MAP_RELOAD_2
	script_jump_if_b0nz .ows_2dea7
	print_npc_text Text08a1
	give_booster_packs BoosterList_ccbe
	print_npc_text Text08a2
	script_jump .ows_2deaa
.ows_2dea7
	print_npc_text Text08a3
.ows_2deaa
	script_command_02
	end_script
	ret

Func_2dead:
	ld a, $0f
	ld [wScriptNPC], a
	ld hl, $9da
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	check_event EVENT_GODAS_ROOM_CAGE_STATE
	script_jump_if_b0z .ows_2def8
	check_event EVENT_GOT_STARMIE_COIN
	script_jump_if_b0z .ows_2ded2
	print_npc_text Text08a4
	script_command_02
	end_script
	ret
.ows_2ded2
	check_event EVENT_TALKED_TO_CHRIS
	script_jump_if_b0z .ows_2dedf
	set_event EVENT_TALKED_TO_CHRIS
	print_npc_text Text08a5
	script_jump .ows_2dee2
.ows_2dedf
	print_npc_text Text08a6
.ows_2dee2
	ask_question Text08a7, TRUE
	script_jump_if_b0z .ows_2def2
	print_npc_text Text08a8
	script_command_02
	start_duel SKILLED_WARRIOR_DECK_ID, MUSIC_MATCHSTART_1
	end_script
	ret
.ows_2def2
	print_npc_text Text08a9
	script_command_02
	end_script
	ret
.ows_2def8
	check_event EVENT_TALKED_TO_CHRIS
	script_jump_if_b0z .ows_2df05
	set_event EVENT_TALKED_TO_CHRIS
	print_npc_text Text08aa
	script_jump .ows_2df08
.ows_2df05
	print_npc_text Text08a6
.ows_2df08
	ask_question Text08a7, TRUE
	script_jump_if_b0z .ows_2df18
	print_npc_text Text08a8
	script_command_02
	start_duel SKILLED_WARRIOR_DECK_ID, MUSIC_MATCHSTART_1
	end_script
	ret
.ows_2df18
	print_npc_text Text08a9
	script_command_02
	end_script
	ret

Func_2df1e:
	xor a
	start_script
	script_command_01
	check_event EVENT_SET_UNTIL_MAP_RELOAD_2
	script_jump_if_b0nz .ows_2df34
	print_npc_text Text08ab
	give_booster_packs BoosterList_ccc2
	print_npc_text Text08ac
	script_jump .ows_2df37
.ows_2df34
	print_npc_text Text08ad
.ows_2df37
	script_command_02
	end_script
	ret

Func_2df3a:
	ld a, $10
	ld [wScriptNPC], a
	ld hl, $9db
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	check_event EVENT_FREED_STEVE
	script_jump_if_b0z .ows_2df5a
	print_npc_text Text08ae
	script_command_02
	end_script
	ret
.ows_2df5a
	check_event EVENT_TALKED_TO_JESSICA
	script_jump_if_b0z .ows_2df67
	set_event EVENT_TALKED_TO_JESSICA
	print_npc_text Text08af
	script_jump .ows_2df6a
.ows_2df67
	print_npc_text Text08b0
.ows_2df6a
	ask_question Text08b1, TRUE
	script_jump_if_b0z .ows_2df7a
	print_npc_text Text08b2
	script_command_02
	start_duel I_LOVE_TO_FIGHT_DECK_ID, MUSIC_MATCHSTART_1
	end_script
	ret
.ows_2df7a
	print_npc_text Text08b3
	script_command_02
	end_script
	ret

Func_2df80:
	xor a
	start_script
	script_command_01
	check_event EVENT_SET_UNTIL_MAP_RELOAD_2
	script_jump_if_b0nz .ows_2df96
	print_npc_text Text08b4
	give_booster_packs BoosterList_ccc6
	print_npc_text Text08b5
	script_jump .ows_2df99
.ows_2df96
	print_npc_text Text08b6
.ows_2df99
	script_command_02
	end_script
	ret

Func_2df9c:
	ld a, $0c
	farcall GetEventValue
	jr z, .asm_2dfaf
	ld a, $ed
	farcall GetEventValue
	jr nz, .asm_2dfaf
	scf
	ccf
	ret
.asm_2dfaf
	scf
	ret

Func_2dfb1:
	ld a, $2e
	ld [wScriptNPC], a
	ld hl, $a28
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	check_event EVENT_GOT_KABUTO_COIN
	script_jump_if_b0z .ows_2dfe0
	check_event EVENT_TALKED_TO_GR1_FIGHTING_CLUB
	script_jump_if_b0z .ows_2dfd8
	set_event EVENT_TALKED_TO_GR1_FIGHTING_CLUB
	print_npc_text Text08b7
	script_jump .ows_2dfdb
.ows_2dfd8
	print_npc_text Text08b8
.ows_2dfdb
	set_active_npc_direction SOUTH
	script_command_02
	end_script
	ret
.ows_2dfe0
	check_event EVENT_TALKED_TO_GR1_FIGHTING_CLUB
	script_jump_if_b0z .ows_2dfed
	set_event EVENT_TALKED_TO_GR1_FIGHTING_CLUB
	print_npc_text Text08b9
	script_jump .ows_2dff0
.ows_2dfed
	print_npc_text Text08ba
.ows_2dff0
	ask_question Text08bb, TRUE
	script_jump_if_b0z .ows_2e000
	print_npc_text Text08bc
	script_command_02
	start_duel GREAT_ROCKET1_DECK_ID, MUSIC_DITTY_1
	end_script
	ret
.ows_2e000
	print_npc_text Text08bd
	set_active_npc_direction SOUTH
	script_command_02
	end_script
	ret

Func_2e008:
	xor a
	start_script
	script_command_01
	check_event EVENT_SET_UNTIL_MAP_RELOAD_2
	script_jump_if_b0nz .ows_2e01d
	set_event EVENT_SET_UNTIL_MAP_RELOAD_1
	print_npc_text Text08be
	give_booster_packs BoosterList_cd40
	script_jump Script_2e038
.ows_2e01d
	print_npc_text Text08bf
	script_command_02
	end_script
	ret

Func_2e023:
	ld a, $0c
	farcall GetEventValue
	jr nz, .asm_2e036
	ld a, $98
	farcall GetEventValue
	jr z, .asm_2e036
	scf
	ccf
	ret
.asm_2e036
	scf
	ret

Script_2e038:
	set_event EVENT_GOT_GR_COIN_PIECE_TOP_LEFT
	print_npc_text Text08c0
	give_coin COIN_GR_START + (COIN_GR_PIECE1)
	check_event EVENT_GOT_GR_COIN
	print_variable_npc_text Text08c1, Text08c2
	script_command_02
	get_player_direction
	compare_loaded_var $00
	script_jump_if_b0z .ows_2e052
	set_player_direction WEST
	animate_player_movement $81, $02
.ows_2e052
	move_active_npc NPCMovement_2e067
	wait_for_player_animation
	set_active_npc_direction NORTH
	script_command_01
	print_npc_text Text08c3
	script_command_02
	move_active_npc NPCMovement_2e06a
	wait_for_player_animation
	unload_npc NPC_GR_1
	play_song_next MUSIC_CLUB_3
	end_script
	ret

NPCMovement_2e067:
	db SOUTH, MOVE_3
	db $ff

NPCMovement_2e06a:
	db SOUTH, MOVE_6
	db $ff

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
	npc NPC_NIKKI, 6, 2, SOUTH, Func_2e3f6
	npc NPC_BRITTANY, 10, 4, NORTH, Func_2e3f6
	npc NPC_KRISTIN, 2, 7, EAST, Func_2e3f6
	npc NPC_HEATHER, 7, 9, SOUTH, Func_2e3f6
	npc NPC_GR_2, 7, 8, SOUTH, Func_2e498
	db $ff

GrassClub_NPCInteractions:
	npc_script NPC_NIKKI, Func_2e226
	npc_script NPC_BRITTANY, Func_2e28c
	npc_script NPC_KRISTIN, Func_2e332
	npc_script NPC_HEATHER, Func_2e394
	npc_script NPC_GR_2, Func_2e40b
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
	npc_script NPC_NIKKI, Func_2e26e
	npc_script NPC_BRITTANY, Func_2e2f6
	npc_script NPC_KRISTIN, Func_2e378
	npc_script NPC_HEATHER, Func_2e3da
	npc_script NPC_GR_2, Func_2e449
	db $ff

Func_2e226:
	ld a, $11
	ld [wScriptNPC], a
	ld hl, $9dc
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	check_event EVENT_GOT_GR_COIN
	script_jump_if_b0z .ows_2e246
	print_npc_text Text0e45
	script_command_02
	end_script
	ret
.ows_2e246
	check_event EVENT_TALKED_TO_NIKKI
	script_jump_if_b0z .ows_2e253
	set_event EVENT_TALKED_TO_NIKKI
	print_npc_text Text0e46
	script_jump .ows_2e256
.ows_2e253
	print_npc_text Text0e47
.ows_2e256
	ask_question Text0e48, TRUE
	script_jump_if_b0z .ows_2e266
	print_npc_text Text0e49
	script_command_02
	start_duel MAX_ENERGY_DECK_ID, MUSIC_MATCHSTART_2
	end_script
	ret
.ows_2e266
	print_npc_text Text0e4a
	set_active_npc_direction SOUTH
	script_command_02
	end_script
	ret

Func_2e26e:
	xor a
	start_script
	script_command_01
	check_event EVENT_SET_UNTIL_MAP_RELOAD_2
	script_jump_if_b0nz .ows_2e284
	print_npc_text Text0e4b
	give_booster_packs BoosterList_ccc9
	print_npc_text Text0e4c
	script_jump .ows_2e287
.ows_2e284
	print_npc_text Text0e4d
.ows_2e287
	set_active_npc_direction SOUTH
	script_command_02
	end_script
	ret

Func_2e28c:
	ld a, $12
	ld [wScriptNPC], a
	ld hl, $9dd
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	check_event EVENT_FREED_STEVE
	script_jump_if_b0z .ows_2e2ce
	check_event EVENT_TALKED_TO_BRITTANY
	script_jump_if_b0z .ows_2e2b3
	set_event EVENT_TALKED_TO_BRITTANY
	print_npc_text Text0e4e
	script_jump .ows_2e2b6
.ows_2e2b3
	print_npc_text Text0e4f
.ows_2e2b6
	ask_question Text0e50, TRUE
	script_jump_if_b0z .ows_2e2c6
	print_npc_text Text0e51
	script_command_02
	start_duel REMAINING_GREEN_DECK_ID, MUSIC_MATCHSTART_1
	end_script
	ret
.ows_2e2c6
	print_npc_text Text0e52
	set_active_npc_direction NORTH
	script_command_02
	end_script
	ret
.ows_2e2ce
	check_event EVENT_TALKED_TO_BRITTANY
	script_jump_if_b0z .ows_2e2db
	set_event EVENT_TALKED_TO_BRITTANY
	print_npc_text Text0e53
	script_jump .ows_2e2de
.ows_2e2db
	print_npc_text Text0e54
.ows_2e2de
	ask_question Text0e50, TRUE
	script_jump_if_b0z .ows_2e2ee
	print_npc_text Text0e55
	script_command_02
	start_duel POISON_CURSE_DECK_ID, MUSIC_MATCHSTART_1
	end_script
	ret
.ows_2e2ee
	print_npc_text Text0e56
	set_active_npc_direction NORTH
	script_command_02
	end_script
	ret

Func_2e2f6:
	xor a
	start_script
	script_command_01
	check_event EVENT_FREED_STEVE
	script_jump_if_b0z .ows_2e319
	check_event EVENT_SET_UNTIL_MAP_RELOAD_2
	script_jump_if_b0nz .ows_2e311
	print_npc_text Text0e57
	give_booster_packs BoosterList_cccd
	print_npc_text Text0e58
	script_jump .ows_2e314
.ows_2e311
	print_npc_text Text0e59
.ows_2e314
	set_active_npc_direction NORTH
	script_command_02
	end_script
	ret
.ows_2e319
	check_event EVENT_SET_UNTIL_MAP_RELOAD_2
	script_jump_if_b0nz .ows_2e32a
	print_npc_text Text0e5a
	give_booster_packs BoosterList_ccd1
	print_npc_text Text0e5b
	script_jump .ows_2e32d
.ows_2e32a
	print_npc_text Text0e5c
.ows_2e32d
	set_active_npc_direction NORTH
	script_command_02
	end_script
	ret

Func_2e332:
	ld a, $13
	ld [wScriptNPC], a
	ld hl, $9de
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	check_event EVENT_GOT_STARMIE_COIN
	script_jump_if_b0z .ows_2e352
	print_npc_text Text0e5d
	script_command_02
	end_script
	ret
.ows_2e352
	check_event EVENT_TALKED_TO_KRISTIN
	script_jump_if_b0z .ows_2e35f
	set_event EVENT_TALKED_TO_KRISTIN
	print_npc_text Text0e5e
	script_jump .ows_2e362
.ows_2e35f
	print_npc_text Text0e5f
.ows_2e362
	ask_question Text0e60, TRUE
	script_jump_if_b0z .ows_2e372
	print_npc_text Text0e61
	script_command_02
	start_duel GLITTERING_SCALES_DECK_ID, MUSIC_MATCHSTART_1
	end_script
	ret
.ows_2e372
	print_npc_text Text0e62
	script_command_02
	end_script
	ret

Func_2e378:
	xor a
	start_script
	script_command_01
	check_event EVENT_SET_UNTIL_MAP_RELOAD_2
	script_jump_if_b0nz .ows_2e38e
	print_npc_text Text0e63
	give_booster_packs BoosterList_ccd5
	print_npc_text Text0e64
	script_jump .ows_2e391
.ows_2e38e
	print_npc_text Text0e65
.ows_2e391
	script_command_02
	end_script
	ret

Func_2e394:
	ld a, $14
	ld [wScriptNPC], a
	ld hl, $9df
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	check_event EVENT_FREED_STEVE
	script_jump_if_b0z .ows_2e3b4
	print_npc_text Text0e66
	script_command_02
	end_script
	ret
.ows_2e3b4
	check_event EVENT_TALKED_TO_HEATHER
	script_jump_if_b0z .ows_2e3c1
	set_event EVENT_TALKED_TO_HEATHER
	print_npc_text Text0e67
	script_jump .ows_2e3c4
.ows_2e3c1
	print_npc_text Text0e68
.ows_2e3c4
	ask_question Text0e69, TRUE
	script_jump_if_b0z .ows_2e3d4
	print_npc_text Text0e6a
	script_command_02
	start_duel STEADY_INCREASE_DECK_ID, MUSIC_MATCHSTART_1
	end_script
	ret
.ows_2e3d4
	print_npc_text Text0e6b
	script_command_02
	end_script
	ret

Func_2e3da:
	xor a
	start_script
	script_command_01
	check_event EVENT_SET_UNTIL_MAP_RELOAD_2
	script_jump_if_b0nz .ows_2e3f0
	print_npc_text Text0e6c
	give_booster_packs BoosterList_ccd8
	print_npc_text Text0e6d
	script_jump .ows_2e3f3
.ows_2e3f0
	print_npc_text Text0e6e
.ows_2e3f3
	script_command_02
	end_script
	ret

Func_2e3f6:
	ld a, $0d
	farcall GetEventValue
	jr z, .asm_2e409
	ld a, $ed
	farcall GetEventValue
	jr nz, .asm_2e409
	scf
	ccf
	ret
.asm_2e409
	scf
	ret

Func_2e40b:
	ld a, $2f
	ld [wScriptNPC], a
	ld hl, $a29
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	check_event EVENT_TALKED_TO_GR2_SCIENCE_GRASS_CLUB
	script_jump_if_b0z .ows_2e430
	set_event EVENT_TALKED_TO_GR2_SCIENCE_GRASS_CLUB
	spin_active_npc 770
	print_npc_text Text0e6f
	script_jump .ows_2e433
.ows_2e430
	print_npc_text Text0e70
.ows_2e433
	ask_question Text0e71, TRUE
	script_jump_if_b0z .ows_2e443
	print_npc_text Text0e72
	script_command_02
	start_duel GREAT_ROCKET2_DECK_ID, MUSIC_DITTY_1
	end_script
	ret
.ows_2e443
	print_npc_text Text0e73
	script_command_02
	end_script
	ret

Func_2e449:
	xor a
	start_script
	script_command_01
	check_event EVENT_SET_UNTIL_MAP_RELOAD_2
	script_jump_if_b0nz .ows_2e46b
	set_event EVENT_SET_UNTIL_MAP_RELOAD_1
	reset_event EVENT_TALKED_TO_NIKKI
	reset_event EVENT_TALKED_TO_BRITTANY
	reset_event EVENT_TALKED_TO_DAVID
	reset_event EVENT_TALKED_TO_JOSEPH
	reset_event EVENT_TALKED_TO_ISHIHARA
	set_var VAR_02, $02
	print_npc_text Text0e74
	give_booster_packs BoosterList_cd44
	script_jump .ows_2e471
.ows_2e46b
	print_npc_text Text0e75
	script_command_02
	end_script
	ret
.ows_2e471
	set_event EVENT_GOT_GR_COIN_PIECE_TOP_RIGHT
	print_npc_text Text0e76
	give_coin COIN_GR_START + COIN_GR_PIECE2
	check_event EVENT_GOT_GR_COIN
	print_variable_npc_text Text0e77, Text0e78
	script_command_02
	get_player_direction
	compare_loaded_var $00
	script_jump_if_b0z .ows_2e48b
	set_player_direction WEST
	animate_player_movement $81, $02
.ows_2e48b
	move_active_npc NPCMovement_2e495
	wait_for_player_animation
	unload_npc NPC_GR_2
	play_song_next MUSIC_CLUB_1
	end_script
	ret
NPCMovement_2e495:
	db SOUTH, MOVE_7
	db $ff

Func_2e498:
	ld a, $05
	farcall GetEventValue
	jr z, .asm_2e4b5
	ld a, $0d
	farcall GetEventValue
	jr nz, .asm_2e4b5
	ld a, $0f
	farcall GetVarValue
	cp $06
	jr nz, .asm_2e4b5
	scf
	ccf
	ret
.asm_2e4b5
	scf
	ret

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
	npc NPC_JOSEPH, 6, 1, SOUTH, Func_2e62a
	db $ff

ScienceClubEntrance_NPCInteractions:
	npc_script NPC_JOSEPH, Func_2e5d0
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

Func_2e5d0:
	ld a, $17
	ld [wScriptNPC], a
	ld hl, $9e2
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	check_event EVENT_SET_UNTIL_MAP_RELOAD_1
	script_jump_if_b0z .ows_2e624
	check_event EVENT_TALKED_TO_JOSEPH
	script_jump_if_b0z .ows_2e60c
	set_event EVENT_TALKED_TO_JOSEPH
	print_npc_text Text106c
	check_event EVENT_GOT_ODDISH_COIN
	script_jump_if_b0nz .ows_2e606
	get_var VAR_0F
	compare_loaded_var $07
	script_jump_if_b0z .ows_2e606
	print_npc_text Text106d
	script_jump .ows_2e627
.ows_2e606
	print_npc_text Text106e
	script_jump .ows_2e627
.ows_2e60c
	check_event EVENT_GOT_ODDISH_COIN
	script_jump_if_b0nz .ows_2e61e
	get_var VAR_0F
	compare_loaded_var $07
	script_jump_if_b0z .ows_2e61e
	print_npc_text Text106f
	script_jump .ows_2e627
.ows_2e61e
	print_npc_text Text1070
	script_jump .ows_2e627
.ows_2e624
	print_npc_text Text1071
.ows_2e627
	script_command_02
	end_script
	ret

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
	npc NPC_DAVID, 9, 6, EAST, Func_2e80d
	npc NPC_ERIK, 4, 9, EAST, Func_2e80d
	npc NPC_IMAKUNI_BLACK, 1, 10, WEST, Func_2e822
	npc NPC_SCIENCE_CLUB_MAN, 3, 9, WEST, Func_2e8d1
	npc NPC_SCIENCE_CLUB_GLASSES_KID, 13, 4, SOUTH, Func_2e8d1
	npc NPC_SCIENCE_CLUB_TECH, 7, 9, WEST, Func_2e8d1
	npc NPC_CLERK_BATTLE_CENTER, 2, 2, SOUTH, $0
	npc NPC_CLERK_GIFT_CENTER, 4, 2, SOUTH, $0
	db $ff

ScienceClubLobby_NPCInteractions:
	npc_script NPC_DAVID, Func_2e76e
	npc_script NPC_ERIK, Func_2e7e3
	npc_script NPC_IMAKUNI_BLACK, Func_3c30c
	npc_script NPC_SCIENCE_CLUB_MAN, Func_2e831
	npc_script NPC_SCIENCE_CLUB_GLASSES_KID, Func_2e862
	npc_script NPC_SCIENCE_CLUB_TECH, Func_2e8a0
	db $ff

ScienceClubLobby_OWInteractions:
	ow_script 8, 2, PCMenu
	ow_script 9, 2, PCMenu
	ow_script 2, 4, Func_3c1b9
	ow_script 4, 4, Func_3c2d9
	ow_script 12, 2, Func_401ce
	ow_script 13, 2, Func_401e4
	ow_script 14, 2, Func_401fa
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
	npc_script NPC_DAVID, Func_2e7c7
	npc_script NPC_IMAKUNI_BLACK, Script_FinishedImakuniBlackDuel
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

Func_2e76e:
	ld a, $16
	ld [wScriptNPC], a
	ld hl, $9e1
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	check_event EVENT_SET_UNTIL_MAP_RELOAD_1
	script_jump_if_b0z .ows_2e7ae
	check_event EVENT_TALKED_TO_DAVID
	script_jump_if_b0z .ows_2e795
	set_event EVENT_TALKED_TO_DAVID
	print_npc_text Text1072
	script_jump .ows_2e798
.ows_2e795
	print_npc_text Text1073
.ows_2e798
	ask_question Text1074, TRUE
	script_jump_if_b0z .ows_2e7a8
	print_npc_text Text1075
	script_command_02
	start_duel NATURAL_SCIENCE_DECK_ID, MUSIC_MATCHSTART_1
	end_script
	ret
.ows_2e7a8
	print_npc_text Text1076
	script_command_02
	end_script
	ret
.ows_2e7ae
	print_npc_text Text1077
	ask_question Text1074, TRUE
	script_jump_if_b0z .ows_2e7c1
	print_npc_text Text1075
	script_command_02
	start_duel NATURAL_SCIENCE_DECK_ID, MUSIC_MATCHSTART_1
	end_script
	ret
.ows_2e7c1
	print_npc_text Text1076
	script_command_02
	end_script
	ret

Func_2e7c7:
	xor a
	start_script
	script_command_01
	check_event EVENT_SET_UNTIL_MAP_RELOAD_2
	script_jump_if_b0nz .ows_2e7dd
	print_npc_text Text1078
	give_booster_packs BoosterList_cce3
	print_npc_text Text1079
	script_jump .ows_2e7e0
.ows_2e7dd
	print_npc_text Text107a
.ows_2e7e0
	script_command_02
	end_script
	ret

Func_2e7e3:
	ld a, $18
	ld [wScriptNPC], a
	ld hl, $9e3
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	check_event EVENT_SET_UNTIL_MAP_RELOAD_1
	script_jump_if_b0z .ows_2e805
	print_npc_text Text107b
	set_active_npc_direction EAST
	script_command_02
	end_script
	ret
.ows_2e805
	print_npc_text Text107c
	set_active_npc_direction EAST
	script_command_02
	end_script
	ret

Func_2e80d:
	ld a, $ed
	farcall GetEventValue
	jr nz, .asm_2e81f
	ld a, $0d
	farcall GetEventValue
	jr z, .asm_2e81f
	scf
	ret
.asm_2e81f
	scf
	ccf
	ret

Func_2e822:
	ld a, $25
	farcall GetVarValue
	cp $07
	jr z, .asm_2e82e
	scf
	ret
.asm_2e82e
	scf
	ccf
	ret

Func_2e831:
	ld a, $75
	ld [wScriptNPC], a
	ld hl, $a3a
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	check_event EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE
	script_jump_if_b0z .ows_2e85c
	check_event EVENT_MIDORIS_ROOM_CAGE_STATE
	script_jump_if_b0z .ows_2e856
	print_npc_text Text107d
	script_jump .ows_2e85f
.ows_2e856
	print_npc_text Text107e
	script_jump .ows_2e85f
.ows_2e85c
	print_npc_text Text107f
.ows_2e85f
	script_command_02
	end_script
	ret

Func_2e862:
	ld a, $77
	ld [wScriptNPC], a
	ld hl, $a4f
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	check_event EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE
	script_jump_if_b0z .ows_2e88d
	check_event EVENT_GOT_GR_COIN
	script_jump_if_b0z .ows_2e887
	print_npc_text Text1080
	script_jump .ows_2e89d
.ows_2e887
	print_npc_text Text1081
	script_jump .ows_2e89d
.ows_2e88d
	check_event EVENT_91
	script_jump_if_b0z .ows_2e89a
	set_event EVENT_91
	print_npc_text Text1082
	script_jump .ows_2e89d
.ows_2e89a
	print_npc_text Text1083
.ows_2e89d
	script_command_02
	end_script
	ret

Func_2e8a0:
	ld a, $78
	ld [wScriptNPC], a
	ld hl, $a4a
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	check_event EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE
	script_jump_if_b0z .ows_2e8cb
	check_event EVENT_GOT_GR_COIN
	script_jump_if_b0z .ows_2e8c5
	print_npc_text Text1084
	script_jump .ows_2e8ce
.ows_2e8c5
	print_npc_text Text1085
	script_jump .ows_2e8ce
.ows_2e8cb
	print_npc_text Text1086
.ows_2e8ce
	script_command_02
	end_script
	ret

Func_2e8d1:
	ld a, $ed
	farcall GetEventValue
	jr nz, .asm_2e8e4
	ld a, $0d
	farcall GetEventValue
	jr z, .asm_2e8e4
	scf
	ccf
	ret
.asm_2e8e4
	scf
	ret

ScienceClub_MapHeader:
	db MAP_GFX_SCIENCE_CLUB
	dba ScienceClub_MapScripts
	db MUSIC_CLUB_3

ScienceClub_StepEvents:
	map_exit 6, 15, MAP_SCIENCE_CLUB_ENTRANCE, 4, 1, SOUTH
	map_exit 7, 15, MAP_SCIENCE_CLUB_ENTRANCE, 5, 1, SOUTH
	db $ff

ScienceClub_NPCs:
	npc NPC_RICK, 2, 2, NORTH, Func_2ea87
	npc NPC_DAVID, 10, 2, NORTH, Func_2ec07
	npc NPC_JOSEPH, 6, 5, WEST, Func_2ec07
	npc NPC_ERIK, 3, 8, EAST, Func_2ec07
	npc NPC_GR_2, 6, 8, SOUTH, Func_2eca9
	db $ff

ScienceClub_NPCInteractions:
	npc_script NPC_RICK, Func_2e9c7
	npc_script NPC_DAVID, Func_2ea94
	npc_script NPC_JOSEPH, Func_2eaef
	npc_script NPC_ERIK, Func_2eba5
	npc_script NPC_GR_2, Func_2ec1c
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
	npc_script NPC_RICK, Func_2ea4b
	npc_script NPC_DAVID, Func_2ead1
	npc_script NPC_JOSEPH, Func_2eb6d
	npc_script NPC_ERIK, Func_2ebeb
	npc_script NPC_GR_2, Func_2ec5a
	db $ff


Func_2e9c7:
	ld a, $15
	ld [wScriptNPC], a
	ld hl, $9e0
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	check_event EVENT_GODAS_ROOM_CAGE_STATE
	script_jump_if_b0z .ows_2ea23
	compare_var VAR_01, $03
	script_jump_if_b0nz .ows_2ea05
	compare_var VAR_01, $02
	script_jump_if_b0nz .ows_2ea05
	compare_var VAR_01, $01
	script_jump_if_b0nz .ows_2e9fd
	set_event EVENT_TALKED_TO_RICK
	inc_var VAR_01
	print_npc_text Text1034
	script_jump .ows_2ea0b
.ows_2e9fd
	inc_var VAR_01
	print_npc_text Text1035
	script_jump .ows_2ea0b
.ows_2ea05
	set_var VAR_01, $03
	print_npc_text Text1036
.ows_2ea0b
	ask_question Text1037, TRUE
	script_jump_if_b0z .ows_2ea1b
	print_npc_text Text1038
	script_command_02
	start_duel DARK_SCIENCE_DECK_ID, MUSIC_MATCHSTART_2
	end_script
	ret
.ows_2ea1b
	print_npc_text Text1039
	set_active_npc_direction NORTH
	script_command_02
	end_script
	ret
.ows_2ea23
	check_event EVENT_TALKED_TO_RICK
	script_jump_if_b0z .ows_2ea30
	set_event EVENT_TALKED_TO_RICK
	print_npc_text Text103a
	script_jump .ows_2ea33
.ows_2ea30
	print_npc_text Text103b
.ows_2ea33
	ask_question Text1037, TRUE
	script_jump_if_b0z .ows_2ea43
	print_npc_text Text103c
	script_command_02
	start_duel DARK_SCIENCE_DECK_ID, MUSIC_MATCHSTART_2
	end_script
	ret
.ows_2ea43
	print_npc_text Text103d
	set_active_npc_direction NORTH
	script_command_02
	end_script
	ret

Func_2ea4b:
	xor a
	start_script
	script_command_01
	check_event EVENT_GODAS_ROOM_CAGE_STATE
	script_jump_if_b0z .ows_2ea6e
	check_event EVENT_SET_UNTIL_MAP_RELOAD_2
	script_jump_if_b0nz .ows_2ea66
	print_npc_text Text103e
	give_booster_packs BoosterList_ccdb
	print_npc_text Text103f
	script_jump .ows_2ea69
.ows_2ea66
	print_npc_text Text1040
.ows_2ea69
	set_active_npc_direction NORTH
	script_command_02
	end_script
	ret
.ows_2ea6e
	check_event EVENT_SET_UNTIL_MAP_RELOAD_2
	script_jump_if_b0nz .ows_2ea7f
	print_npc_text Text1041
	give_booster_packs BoosterList_ccdf
	print_npc_text Text1042
	script_jump .ows_2ea82
.ows_2ea7f
	print_npc_text Text1043
.ows_2ea82
	set_active_npc_direction NORTH
	script_command_02
	end_script
	ret

Func_2ea87:
	ld a, $ba
	farcall GetEventValue
	jr z, .asm_2ea92
	scf
	ccf
	ret
.asm_2ea92
	scf
	ret

Func_2ea94:
	ld a, $16
	ld [wScriptNPC], a
	ld hl, $9e1
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	check_event EVENT_TALKED_TO_DAVID
	script_jump_if_b0z .ows_2eab6
	set_event EVENT_TALKED_TO_DAVID
	print_npc_text Text1044
	script_jump .ows_2eab9
.ows_2eab6
	print_npc_text Text1045
.ows_2eab9
	ask_question Text1046, TRUE
	script_jump_if_b0z .ows_2eac9
	print_npc_text Text1047
	script_command_02
	start_duel NATURAL_SCIENCE_DECK_ID, MUSIC_MATCHSTART_1
	end_script
	ret
.ows_2eac9
	print_npc_text Text1048
	set_active_npc_direction NORTH
	script_command_02
	end_script
	ret

Func_2ead1:
	xor a
	start_script
	script_command_01
	check_event EVENT_SET_UNTIL_MAP_RELOAD_2
	script_jump_if_b0nz .ows_2eae7
	print_npc_text Text1049
	give_booster_packs BoosterList_cce3
	print_npc_text Text104a
	script_jump .ows_2eaea
.ows_2eae7
	print_npc_text Text104b
.ows_2eaea
	set_active_npc_direction NORTH
	script_command_02
	end_script
	ret

Func_2eaef:
	ld a, $17
	ld [wScriptNPC], a
	ld hl, $9e2
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	check_event EVENT_MIDORIS_ROOM_CAGE_STATE
	script_jump_if_b0z .ows_2eb47
	check_event EVENT_GOT_STARMIE_COIN
	script_jump_if_b0z .ows_2eb21
	check_event EVENT_TALKED_TO_JOSEPH
	script_jump_if_b0z .ows_2eb1b
	set_event EVENT_TALKED_TO_JOSEPH
	print_npc_text Text104c
	script_jump .ows_2eb1e
.ows_2eb1b
	print_npc_text Text104d
.ows_2eb1e
	script_command_02
	end_script
	ret
.ows_2eb21
	check_event EVENT_TALKED_TO_JOSEPH
	script_jump_if_b0z .ows_2eb2e
	set_event EVENT_TALKED_TO_JOSEPH
	print_npc_text Text104e
	script_jump .ows_2eb31
.ows_2eb2e
	print_npc_text Text104f
.ows_2eb31
	ask_question Text1050, TRUE
	script_jump_if_b0z .ows_2eb41
	print_npc_text Text1051
	script_command_02
	start_duel POISONOUS_SWAMP_DECK_ID, MUSIC_MATCHSTART_1
	end_script
	ret
.ows_2eb41
	print_npc_text Text1052
	script_command_02
	end_script
	ret
.ows_2eb47
	check_event EVENT_TALKED_TO_JOSEPH
	script_jump_if_b0z .ows_2eb54
	set_event EVENT_TALKED_TO_JOSEPH
	print_npc_text Text1053
	script_jump .ows_2eb57
.ows_2eb54
	print_npc_text Text1054
.ows_2eb57
	ask_question Text1050, TRUE
	script_jump_if_b0z .ows_2eb67
	print_npc_text Text1051
	script_command_02
	start_duel POISONOUS_SWAMP_DECK_ID, MUSIC_MATCHSTART_1
	end_script
	ret
.ows_2eb67
	print_npc_text Text1052
	script_command_02
	end_script
	ret

Func_2eb6d:
	xor a
	start_script
	script_command_01
	check_event EVENT_MIDORIS_ROOM_CAGE_STATE
	script_jump_if_b0z .ows_2eb8e
	check_event EVENT_SET_UNTIL_MAP_RELOAD_2
	script_jump_if_b0nz .ows_2eb88
	print_npc_text Text1055
	give_booster_packs BoosterList_cce7
	print_npc_text Text1056
	script_jump .ows_2eb8b
.ows_2eb88
	print_npc_text Text1057
.ows_2eb8b
	script_command_02
	end_script
	ret
.ows_2eb8e
	check_event EVENT_SET_UNTIL_MAP_RELOAD_2
	script_jump_if_b0nz .ows_2eb9f
	print_npc_text Text1055
	give_booster_packs BoosterList_cce7
	print_npc_text Text1058
	script_jump .ows_2eba2
.ows_2eb9f
	print_npc_text Text1057
.ows_2eba2
	script_command_02
	end_script
	ret

Func_2eba5:
	ld a, $18
	ld [wScriptNPC], a
	ld hl, $9e3
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	check_event EVENT_GOT_GR_COIN
	script_jump_if_b0z .ows_2ebc5
	print_npc_text Text1059
	script_command_02
	end_script
	ret
.ows_2ebc5
	check_event EVENT_TALKED_TO_ERIK
	script_jump_if_b0z .ows_2ebd2
	set_event EVENT_TALKED_TO_ERIK
	print_npc_text Text105a
	script_jump .ows_2ebd5
.ows_2ebd2
	print_npc_text Text105b
.ows_2ebd5
	ask_question Text105c, TRUE
	script_jump_if_b0z .ows_2ebe5
	print_npc_text Text105d
	script_command_02
	start_duel GATHERING_NIDORAN_DECK_ID, MUSIC_MATCHSTART_1
	end_script
	ret
.ows_2ebe5
	print_npc_text Text105e
	script_command_02
	end_script
	ret

Func_2ebeb:
	xor a
	start_script
	script_command_01
	check_event EVENT_SET_UNTIL_MAP_RELOAD_2
	script_jump_if_b0nz .ows_2ec01
	print_npc_text Text105f
	give_booster_packs BoosterList_cceb
	print_npc_text Text1060
	script_jump .ows_2ec04
.ows_2ec01
	print_npc_text Text1061
.ows_2ec04
	script_command_02
	end_script
	ret

Func_2ec07:
	ld a, $0d
	farcall GetEventValue
	jr z, .asm_2ec1a
	ld a, $ed
	farcall GetEventValue
	jr nz, .asm_2ec1a
	scf
	ccf
	ret
.asm_2ec1a
	scf
	ret

Func_2ec1c:
	ld a, $2f
	ld [wScriptNPC], a
	ld hl, $a29
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	check_event EVENT_TALKED_TO_GR2_SCIENCE_GRASS_CLUB
	script_jump_if_b0z .ows_2ec41
	set_event EVENT_TALKED_TO_GR2_SCIENCE_GRASS_CLUB
	spin_active_npc 770
	print_npc_text Text1062
	script_jump .ows_2ec44
.ows_2ec41
	print_npc_text Text1063
.ows_2ec44
	ask_question Text1064, TRUE
	script_jump_if_b0z .ows_2ec54
	print_npc_text Text1065
	script_command_02
	start_duel GREAT_ROCKET2_DECK_ID, MUSIC_DITTY_1
	end_script
	ret
.ows_2ec54
	print_npc_text Text1066
	script_command_02
	end_script
	ret

Func_2ec5a:
	xor a
	start_script
	script_command_01
	check_event EVENT_SET_UNTIL_MAP_RELOAD_2
	script_jump_if_b0nz .ows_2ec7c
	set_event EVENT_SET_UNTIL_MAP_RELOAD_1
	reset_event EVENT_TALKED_TO_NIKKI
	reset_event EVENT_TALKED_TO_BRITTANY
	reset_event EVENT_TALKED_TO_DAVID
	reset_event EVENT_TALKED_TO_JOSEPH
	reset_event EVENT_TALKED_TO_ISHIHARA
	set_var VAR_02, $02
	print_npc_text Text1067
	give_booster_packs BoosterList_cd44
	script_jump .ows_2ec82
.ows_2ec7c
	print_npc_text Text1068
	script_command_02
	end_script
	ret
.ows_2ec82
	set_event EVENT_GOT_GR_COIN_PIECE_TOP_RIGHT
	print_npc_text Text1069
	give_coin COIN_GR_START + COIN_GR_PIECE2
	check_event EVENT_GOT_GR_COIN
	print_variable_npc_text Text106a, Text106b
	script_command_02
	get_player_direction
	compare_loaded_var $00
	script_jump_if_b0z .ows_2ec9c
	set_player_direction EAST
	animate_player_movement $83, $02
.ows_2ec9c
	move_active_npc NPCMovement_2eca6
	wait_for_player_animation
	unload_npc NPC_GR_2
	play_song_next MUSIC_CLUB_3
	end_script
	ret
NPCMovement_2eca6:
	db SOUTH, MOVE_6
	db $ff

Func_2eca9:
	ld a, $05
	farcall GetEventValue
	jr z, .asm_2ecc6
	ld a, $0d
	farcall GetEventValue
	jr nz, .asm_2ecc6
	ld a, $0f
	farcall GetVarValue
	cp $07
	jr nz, .asm_2ecc6
	scf
	ccf
	ret
.asm_2ecc6
	scf
	ret

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
	npc NPC_JOSHUA, 8, 6, WEST, Func_2ef5f
	npc NPC_WATER_CLUB_LASS, 11, 1, WEST, $0
	npc NPC_IMAKUNI_BLACK, 1, 10, WEST, Func_2ef9f
	npc NPC_WATER_CLUB_PAPPY, 12, 11, EAST, $0
	npc NPC_WATER_CLUB_LONGHAIRED_LASS, 4, 9, SOUTH, $0
	npc NPC_CLERK_BATTLE_CENTER, 2, 2, SOUTH, $0
	npc NPC_CLERK_GIFT_CENTER, 4, 2, SOUTH, $0
	db $ff

WaterClubLobby_NPCInteractions:
	npc_script NPC_JOSHUA, Func_2eeea
	npc_script NPC_WATER_CLUB_LASS, Func_2ef74
	npc_script NPC_IMAKUNI_BLACK, Func_3c30c
	npc_script NPC_WATER_CLUB_PAPPY, Func_2efae
	npc_script NPC_WATER_CLUB_LONGHAIRED_LASS, Func_2efe1
	db $ff

WaterClubLobby_OWInteractions:
	ow_script 8, 2, PCMenu
	ow_script 9, 2, PCMenu
	ow_script 2, 4, Func_3c1b9
	ow_script 4, 4, Func_3c2d9
	ow_script 12, 2, Func_40210
	ow_script 13, 2, Func_40226
	ow_script 14, 2, Func_4023c
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
	npc_script NPC_JOSHUA, Func_2ef43
	npc_script NPC_IMAKUNI_BLACK, Script_FinishedImakuniBlackDuel
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

Func_2eeea:
	ld a, $1b
	ld [wScriptNPC], a
	ld hl, $9e5
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	check_event EVENT_SET_UNTIL_MAP_RELOAD_1
	script_jump_if_b0z .ows_2ef2a
	check_event EVENT_TALKED_TO_JOSHUA
	script_jump_if_b0z .ows_2ef11
	set_event EVENT_TALKED_TO_JOSHUA
	print_npc_text Text087b
	script_jump .ows_2ef14
.ows_2ef11
	print_npc_text Text087c
.ows_2ef14
	ask_question Text087d, TRUE
	script_jump_if_b0z .ows_2ef24
	print_npc_text Text087e
	script_command_02
	start_duel CONSERVING_WATER_DECK_ID, MUSIC_MATCHSTART_1
	end_script
	ret
.ows_2ef24
	print_npc_text Text087f
	script_command_02
	end_script
	ret
.ows_2ef2a
	print_npc_text Text0880
	ask_question Text087d, TRUE
	script_jump_if_b0z .ows_2ef3d
	print_npc_text Text087e
	script_command_02
	start_duel CONSERVING_WATER_DECK_ID, MUSIC_MATCHSTART_1
	end_script
	ret
.ows_2ef3d
	print_npc_text Text087f
	script_command_02
	end_script
	ret

Func_2ef43:
	xor a
	start_script
	script_command_01
	check_event EVENT_SET_UNTIL_MAP_RELOAD_2
	script_jump_if_b0nz .ows_2ef59
	print_npc_text Text0881
	give_booster_packs BoosterList_ccf2
	print_npc_text Text0882
	script_jump .ows_2ef5c
.ows_2ef59
	print_npc_text Text0883
.ows_2ef5c
	script_command_02
	end_script
	ret

Func_2ef5f:
	ld a, $ed
	farcall GetEventValue
	jr nz, .asm_2ef71
	ld a, $07
	farcall GetEventValue
	jr z, .asm_2ef71
	scf
	ret
.asm_2ef71
	scf
	ccf
	ret

Func_2ef74:
	ld a, $7b
	ld [wScriptNPC], a
	ld hl, $a36
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	compare_var VAR_25, $08
	script_jump_if_b0nz .ows_2ef99
	script_callfar Script_3c2f0
	print_npc_text Text0884
	script_jump .ows_2ef9c
.ows_2ef99
	print_npc_text Text0885
.ows_2ef9c
	script_command_02
	end_script
	ret

Func_2ef9f:
	ld a, $25
	farcall GetVarValue
	cp $08
	jr z, .asm_2efab
	scf
	ret
.asm_2efab
	scf
	ccf
	ret

Func_2efae:
	ld a, $79
	ld [wScriptNPC], a
	ld hl, $a3b
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	check_event EVENT_GOT_GR_COIN
	script_jump_if_b0z .ows_2efdb
	check_event EVENT_GOT_STARMIE_COIN
	script_jump_if_b0z .ows_2efd5
	print_npc_text Text0886
	set_active_npc_direction EAST
	script_jump .ows_2efde
.ows_2efd5
	print_npc_text Text0887
	script_jump .ows_2efde
.ows_2efdb
	print_npc_text Text0888
.ows_2efde
	script_command_02
	end_script
	ret

Func_2efe1:
	ld a, $7a
	ld [wScriptNPC], a
	ld hl, $a4b
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	check_event EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE
	script_jump_if_b0z .ows_2f00c
	check_event EVENT_GOT_GR_COIN
	script_jump_if_b0z .ows_2f006
	print_npc_text Text0889
	script_jump .ows_2f00f
.ows_2f006
	print_npc_text Text088a
	script_jump .ows_2f00f
.ows_2f00c
	print_npc_text Text088b
.ows_2f00f
	script_command_02
	end_script
	ret

WaterClub_MapHeader:
	db MAP_GFX_WATER_CLUB
	dba WaterClub_MapScripts
	db MUSIC_CLUB_1

WaterClub_StepEvents:
	map_exit 6, 15, MAP_WATER_CLUB_ENTRANCE, 4, 1, SOUTH
	map_exit 7, 15, MAP_WATER_CLUB_ENTRANCE, 5, 1, SOUTH
	db $ff

WaterClub_NPCs:
	npc NPC_AMY_LOUNGE, 11, 2, SOUTH, Func_2f36d
	npc NPC_JOSHUA, 10, 4, SOUTH, Func_2f36d
	npc NPC_SARA, 4, 9, EAST, Func_2f478
	npc NPC_AMANDA, 11, 10, WEST, Func_2f478
	npc NPC_AMY, 4, 6, SOUTH, Func_2f1ed
	npc NPC_GR_3, 8, 6, SOUTH, Func_2f4f2
	db $ff

WaterClub_NPCInteractions:
	npc_script NPC_AMY_LOUNGE, Func_2f1fa
	npc_script NPC_JOSHUA, Func_2f2cf
	npc_script NPC_SARA, Func_2f382
	npc_script NPC_AMANDA, Func_2f3f1
	npc_script NPC_AMY, Func_2f1d2
	npc_script NPC_GR_3, Func_2f485
	db $ff

WaterClub_OWInteractions:
	ow_script 12, 3, Func_2f1fa
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
	npc_script NPC_AMY_LOUNGE, Func_2f28a
	npc_script NPC_JOSHUA, Func_2f335
	npc_script NPC_SARA, Func_2f3d5
	npc_script NPC_AMANDA, Func_2f44f
	npc_script NPC_GR_3, Func_2f4d9
	db $ff

Script_2f127:
	set_event EVENT_SET_UNTIL_MAP_RELOAD_1
	set_event EVENT_EE
	reset_event EVENT_TALKED_TO_JOSHUA
	reset_event EVENT_TALKED_TO_KEN
	reset_event EVENT_TALKED_TO_ADAM
	reset_event EVENT_TALKED_TO_GR3_WATER_CLUB
	script_command_64 $05
	print_npc_text Text0833
	script_command_02
	set_active_npc_direction WEST
	do_frames 60
	script_command_01
	play_sfx SFX_29
	print_npc_text_instant Text0834
	script_command_67 $05, $1e
	do_frames 60
	fade_out $01, TRUE
	wait_for_fade
	script_command_68
	play_sfx SFX_0F
	script_command_02
	unload_npc NPC_CAPTURED_AMY
	unload_npc NPC_CAPTURED_SARA
	unload_npc NPC_CAPTURED_AMANDA
	load_npc NPC_AMY, 9, 5, SOUTH
	load_npc NPC_SARA, 8, 5, SOUTH
	load_npc NPC_AMANDA, 10, 5, SOUTH
	set_player_position_and_direction 8, 7, NORTH
	load_tilemap TILEMAP_02A, $02, $04
	do_frames 28
	fade_in $01, TRUE
	wait_for_fade
	script_command_01
	do_frames 30
	get_player_direction
	compare_loaded_var $00
	script_jump_if_b0z .ows_2f182
	set_player_direction WEST
	animate_player_movement $81, $02
.ows_2f182
	move_active_npc NPCMovement_2f197
	wait_for_player_animation
	set_active_npc_direction NORTH
	print_npc_text Text0835
	script_command_02
	move_active_npc NPCMovement_2f19a
	wait_for_player_animation
	unload_npc NPC_GR_3
	play_song_next MUSIC_CLUB_2
	script_jump Script_2f19d

NPCMovement_2f197:
	db SOUTH, MOVE_2
	db $ff

NPCMovement_2f19a:
	db SOUTH, MOVE_5
	db $ff

Script_2f19d:
	set_active_npc NPC_AMY, DialogAmyText
	animate_player_movement $00, $01
	wait_for_player_animation
	script_command_01
	print_npc_text Text0836
	give_deck VENGEFUL_ANTI_GR3_DECK_ID
	script_jump_if_b1nz .ows_2f1b8
	play_song MUSIC_BOOSTER_PACK
	print_text Text0837
	wait_song
	resume_song
	script_jump .ows_2f1c5

.ows_2f1b8
	print_npc_text Text0838
	play_song MUSIC_BOOSTER_PACK
	print_text Text0839
	wait_song
	resume_song
	print_npc_text Text083a
.ows_2f1c5
	set_event EVENT_GOT_STARMIE_COIN
	print_npc_text Text083b
	give_coin COIN_STARMIE
	print_npc_text Text083c
	script_command_02
	end_script
	ret

Func_2f1d2:
	ld a, $19
	ld [wScriptNPC], a
	ld hl, $9e4
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	print_npc_text Text083d
	script_command_02
	end_script
	ret

Func_2f1ed:
	ld a, $ed
	farcall GetEventValue
	jr nz, .asm_2f1f7
	scf
	ret
.asm_2f1f7
	scf
	ccf
	ret

Func_2f1fa:
	ld a, $1a
	ld [wScriptNPC], a
	ld hl, $9e4
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	ld a, [wPlayerOWObject]
	farcall GetOWObjectTilePosition
	ld a, e
	cp $02
	ret z
	ld a, $07
	farcall GetEventValue
	ret z
	xor a
	start_script
	script_command_01
	check_event EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE
	script_jump_if_b0z .ows_2f264
	check_event EVENT_FREED_STEVE
	script_jump_if_b0z .ows_2f23e
	check_event EVENT_TALKED_TO_AMY
	script_jump_if_b0z .ows_2f238
	set_event EVENT_TALKED_TO_AMY
	print_npc_text Text083e
	script_jump .ows_2f23b
.ows_2f238
	print_npc_text Text083f
.ows_2f23b
	script_command_02
	end_script
	ret
.ows_2f23e
	check_event EVENT_TALKED_TO_AMY
	script_jump_if_b0z .ows_2f24b
	set_event EVENT_TALKED_TO_AMY
	print_npc_text Text0840
	script_jump .ows_2f24e
.ows_2f24b
	print_npc_text Text0841
.ows_2f24e
	ask_question Text0842, TRUE
	script_jump_if_b0z .ows_2f25e
	print_npc_text Text0843
	script_command_02
	start_duel RAIN_DANCE_CONFUSION_DECK_ID, MUSIC_MATCHSTART_2
	end_script
	ret
.ows_2f25e
	print_npc_text Text0844
	script_command_02
	end_script
	ret
.ows_2f264
	check_event EVENT_TALKED_TO_AMY
	script_jump_if_b0z .ows_2f271
	set_event EVENT_TALKED_TO_AMY
	print_npc_text Text0845
	script_jump .ows_2f274
.ows_2f271
	print_npc_text Text0846
.ows_2f274
	ask_question Text0842, TRUE
	script_jump_if_b0z .ows_2f284
	print_npc_text Text0843
	script_command_02
	start_duel RAIN_DANCE_CONFUSION_DECK_ID, MUSIC_MATCHSTART_2
	end_script
	ret
.ows_2f284
	print_npc_text Text0844
	script_command_02
	end_script
	ret

Func_2f28a:
	xor a
	start_script
	script_command_01
	check_event EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE
	script_jump_if_b0z .ows_2f2ab
	check_event EVENT_SET_UNTIL_MAP_RELOAD_2
	script_jump_if_b0nz .ows_2f2a5
	print_npc_text Text0847
	give_booster_packs BoosterList_ccee
	print_npc_text Text0848
	script_jump .ows_2f2a8
.ows_2f2a5
	print_npc_text Text0849
.ows_2f2a8
	script_command_02
	end_script
	ret
.ows_2f2ab
	check_event EVENT_SET_UNTIL_MAP_RELOAD_2
	script_jump_if_b0nz .ows_2f2c9
	print_npc_text Text0847
	give_booster_packs BoosterList_ccee
	check_event EVENT_35
	script_jump_if_b0z .ows_2f2c3
	set_event EVENT_35
	print_npc_text Text084a
	script_jump .ows_2f2cc
.ows_2f2c3
	print_npc_text Text084b
	script_jump .ows_2f2cc
.ows_2f2c9
	print_npc_text Text084c
.ows_2f2cc
	script_command_02
	end_script
	ret

Func_2f2cf:
	ld a, $1b
	ld [wScriptNPC], a
	ld hl, $9e5
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	check_event EVENT_GODAS_ROOM_CAGE_STATE
	script_jump_if_b0z .ows_2f30f
	check_event EVENT_TALKED_TO_JOSHUA
	script_jump_if_b0z .ows_2f2f6
	set_event EVENT_TALKED_TO_JOSHUA
	print_npc_text Text084d
	script_jump .ows_2f2f9
.ows_2f2f6
	print_npc_text Text084e
.ows_2f2f9
	ask_question Text084f, TRUE
	script_jump_if_b0z .ows_2f309
	print_npc_text Text0850
	script_command_02
	start_duel CONSERVING_WATER_DECK_ID, MUSIC_MATCHSTART_1
	end_script
	ret
.ows_2f309
	print_npc_text Text0851
	script_command_02
	end_script
	ret
.ows_2f30f
	check_event EVENT_TALKED_TO_JOSHUA
	script_jump_if_b0z .ows_2f31c
	set_event EVENT_TALKED_TO_JOSHUA
	print_npc_text Text0852
	script_jump .ows_2f31f
.ows_2f31c
	print_npc_text Text0853
.ows_2f31f
	ask_question Text084f, TRUE
	script_jump_if_b0z .ows_2f32f
	print_npc_text Text0854
	script_command_02
	start_duel ENERGY_REMOVAL_DECK_ID, MUSIC_MATCHSTART_1
	end_script
	ret
.ows_2f32f
	print_npc_text Text0855
	script_command_02
	end_script
	ret

Func_2f335:
	xor a
	start_script
	script_command_01
	check_event EVENT_GODAS_ROOM_CAGE_STATE
	script_jump_if_b0z .ows_2f356
	check_event EVENT_SET_UNTIL_MAP_RELOAD_2
	script_jump_if_b0nz .ows_2f350
	print_npc_text Text0856
	give_booster_packs BoosterList_ccf2
	print_npc_text Text0857
	script_jump .ows_2f353
.ows_2f350
	print_npc_text Text0858
.ows_2f353
	script_command_02
	end_script
	ret
.ows_2f356
	check_event EVENT_SET_UNTIL_MAP_RELOAD_2
	script_jump_if_b0nz .ows_2f367
	print_npc_text Text0859
	give_booster_packs BoosterList_ccf6
	print_npc_text Text085a
	script_jump .ows_2f36a
.ows_2f367
	print_npc_text Text085b
.ows_2f36a
	script_command_02
	end_script
	ret

Func_2f36d:
	ld a, $07
	farcall GetEventValue
	jr z, .asm_2f380
	ld a, $ed
	farcall GetEventValue
	jr nz, .asm_2f380
	scf
	ccf
	ret
.asm_2f380
	scf
	ret

Func_2f382:
	ld a, $1c
	ld [wScriptNPC], a
	ld hl, $9e6
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	check_event EVENT_SET_UNTIL_MAP_RELOAD_1
	script_jump_if_b0nz .ows_2f3af
	check_event EVENT_TALKED_TO_SARA
	script_jump_if_b0z .ows_2f3a9
	set_event EVENT_TALKED_TO_SARA
	print_npc_text Text085c
	script_jump .ows_2f3ac
.ows_2f3a9
	print_npc_text Text085d
.ows_2f3ac
	script_command_02
	end_script
	ret
.ows_2f3af
	check_event EVENT_TALKED_TO_SARA
	script_jump_if_b0z .ows_2f3bc
	set_event EVENT_TALKED_TO_SARA
	print_npc_text Text085e
	script_jump .ows_2f3bf
.ows_2f3bc
	print_npc_text Text085f
.ows_2f3bf
	ask_question Text0860, TRUE
	script_jump_if_b0z .ows_2f3cf
	print_npc_text Text0861
	script_command_02
	start_duel SPLASHING_ABOUT_DECK_ID, MUSIC_MATCHSTART_1
	end_script
	ret
.ows_2f3cf
	print_npc_text Text0862
	script_command_02
	end_script
	ret

Func_2f3d5:
	xor a
	start_script
	script_command_01
	check_event EVENT_SET_UNTIL_MAP_RELOAD_2
	script_jump_if_b0nz .ows_2f3eb
	print_npc_text Text0863
	give_booster_packs BoosterList_ccfa
	print_npc_text Text0864
	script_jump .ows_2f3ee
.ows_2f3eb
	print_npc_text Text0865
.ows_2f3ee
	script_command_02
	end_script
	ret

Func_2f3f1:
	ld a, $1d
	ld [wScriptNPC], a
	ld hl, $9e7
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	check_event EVENT_FREED_STEVE
	script_jump_if_b0z .ows_2f429
	check_event EVENT_SET_UNTIL_MAP_RELOAD_1
	script_jump_if_b0nz .ows_2f423
	check_event EVENT_TALKED_TO_AMANDA
	script_jump_if_b0z .ows_2f41d
	set_event EVENT_TALKED_TO_AMANDA
	print_npc_text Text0866
	script_jump .ows_2f420
.ows_2f41d
	print_npc_text Text0867
.ows_2f420
	script_command_02
	end_script
	ret
.ows_2f423
	print_npc_text Text0868
	script_command_02
	end_script
	ret
.ows_2f429
	check_event EVENT_TALKED_TO_AMANDA
	script_jump_if_b0z .ows_2f436
	set_event EVENT_TALKED_TO_AMANDA
	print_npc_text Text0869
	script_jump .ows_2f439
.ows_2f436
	print_npc_text Text086a
.ows_2f439
	ask_question Text086b, TRUE
	script_jump_if_b0z .ows_2f449
	print_npc_text Text086c
	script_command_02
	start_duel BEACH_DECK_ID, MUSIC_MATCHSTART_1
	end_script
	ret
.ows_2f449
	print_npc_text Text086d
	script_command_02
	end_script
	ret

Func_2f44f:
	xor a
	start_script
	script_command_01
	check_event EVENT_SET_UNTIL_MAP_RELOAD_2
	script_jump_if_b0nz .ows_2f472
	print_npc_text Text086e
	give_booster_packs BoosterList_ccfe
	check_event EVENT_36
	script_jump_if_b0z .ows_2f46c
	set_event EVENT_36
	print_npc_text Text086f
	script_jump .ows_2f475
.ows_2f46c
	print_npc_text Text0870
	script_jump .ows_2f475
.ows_2f472
	print_npc_text Text0871
.ows_2f475
	script_command_02
	end_script
	ret

Func_2f478:
	ld a, $07
	farcall GetEventValue
	jr z, .asm_2f483
	scf
	ccf
	ret
.asm_2f483
	scf
	ret

Func_2f485:
	ld a, $30
	ld [wScriptNPC], a
	ld hl, $a2a
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	check_event EVENT_TALKED_TO_GR3_WATER_CLUB
	script_jump_if_b0z .ows_2f4c0
	set_event EVENT_TALKED_TO_GR3_WATER_CLUB
	print_npc_text Text0872
	script_command_02
	set_active_npc_direction WEST
	scroll_to_position $00, $ff
	do_frames 30
	script_command_01
	print_npc_text Text0873
	script_command_02
	scroll_to_position $08, $ff
	scroll_to_player
	get_player_opposite_direction
	restore_active_npc_direction
	do_frames 30
	script_command_01
	print_npc_text Text0874
	script_jump .ows_2f4c3
.ows_2f4c0
	print_npc_text Text0875
.ows_2f4c3
	ask_question Text0876, TRUE
	script_jump_if_b0z .ows_2f4d3
	print_npc_text Text0877
	script_command_02
	start_duel GREAT_ROCKET3_DECK_ID, MUSIC_DITTY_1
	end_script
	ret
.ows_2f4d3
	print_npc_text Text0878
	script_command_02
	end_script
	ret

Func_2f4d9:
	xor a
	start_script
	script_command_01
	check_event EVENT_SET_UNTIL_MAP_RELOAD_2
	script_jump_if_b0nz .ows_2f4ec
	print_npc_text Text0879
	give_booster_packs BoosterList_cd48
	script_jump Script_2f127
.ows_2f4ec
	print_npc_text Text087a
	script_command_02
	end_script
	ret

Func_2f4f2:
	ld a, $07
	farcall GetEventValue
	jr z, .asm_2f4fc
	scf
	ret
.asm_2f4fc
	scf
	ccf
	ret

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
	npc NPC_FIRE_CLUB_PUNK_GUY, 8, 4, NORTH, $0
	npc NPC_IMAKUNI_BLACK, 1, 10, WEST, Func_2f76f
	npc NPC_FIRE_CLUB_MARTIAL_ARTIST, 10, 9, NORTH, $0
	npc NPC_FIRE_CLUB_GAL, 5, 8, SOUTH, $0
	npc NPC_CLERK_BATTLE_CENTER, 2, 2, SOUTH, $0
	npc NPC_CLERK_GIFT_CENTER, 4, 2, SOUTH, $0
	db $ff

FireClubLobby_NPCInteractions:
	npc_script NPC_FIRE_CLUB_PUNK_GUY, Func_2f709
	npc_script NPC_IMAKUNI_BLACK, Func_3c30c
	npc_script NPC_FIRE_CLUB_MARTIAL_ARTIST, Func_2f77e
	npc_script NPC_FIRE_CLUB_GAL, Func_2f7a4
	db $ff

FireClubLobby_OWInteractions:
	ow_script 8, 2, PCMenu
	ow_script 9, 2, PCMenu
	ow_script 2, 4, Func_3c1b9
	ow_script 4, 4, Func_3c2d9
	ow_script 12, 2, Func_40252
	ow_script 13, 2, Func_40268
	ow_script 14, 2, Func_4027e
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

Func_2f709:
	ld a, $7c
	ld [wScriptNPC], a
	ld hl, $a56
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	check_event EVENT_TRADED_CARDS_FIRE_CLUB
	script_jump_if_b0z .ows_2f769
	check_event EVENT_TALKED_TO_TRADE_NPC_FIRE_CLUB
	script_jump_if_b0z .ows_2f730
	set_event EVENT_TALKED_TO_TRADE_NPC_FIRE_CLUB
	print_npc_text Text0c74
	script_jump .ows_2f733
.ows_2f730
	print_npc_text Text0c75
.ows_2f733
	ask_question TradeCardsPromptText, TRUE
	script_jump_if_b0nz .ows_2f740
	print_npc_text Text0c76
	script_jump .ows_2f76c
.ows_2f740
	get_card_count_in_collection_and_decks FLAREON_LV28
	script_jump_if_b0z .ows_2f74c
	print_npc_text Text0c77
	script_jump .ows_2f76c
.ows_2f74c
	get_card_count_in_collection FLAREON_LV28
	script_jump_if_b0z .ows_2f758
	print_npc_text Text0c78
	script_jump .ows_2f76c
.ows_2f758
	print_npc_text Text0c79
	receive_card MEOWTH_LV14
	take_card FLAREON_LV28
	set_event EVENT_TRADED_CARDS_FIRE_CLUB
	print_npc_text Text0c7a
	script_jump .ows_2f76c
.ows_2f769
	print_npc_text Text0c7b
.ows_2f76c
	script_command_02
	end_script
	ret

Func_2f76f:
	ld a, $25
	farcall GetVarValue
	cp $09
	jr z, .asm_2f77b
	scf
	ret
.asm_2f77b
	scf
	ccf
	ret

Func_2f77e:
	ld a, $7d
	ld [wScriptNPC], a
	ld hl, $a55
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	check_event EVENT_GOT_GR_COIN
	script_jump_if_b0z .ows_2f79e
	print_npc_text Text0c7c
	script_jump .ows_2f7a1
.ows_2f79e
	print_npc_text Text0c7d
.ows_2f7a1
	script_command_02
	end_script
	ret

Func_2f7a4:
	ld a, $7e
	ld [wScriptNPC], a
	ld hl, $a37
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	check_event EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE
	script_jump_if_b0z .ows_2f7c4
	print_npc_text Text0c7e
	script_jump .ows_2f7c7
.ows_2f7c4
	print_npc_text Text0c7f
.ows_2f7c7
	script_command_02
	end_script
	ret

FireClub_MapHeader:
	db MAP_GFX_FIRE_CLUB
	dba FireClub_MapScripts
	db MUSIC_CLUB_3

FireClub_StepEvents:
	map_exit 6, 15, MAP_FIRE_CLUB_ENTRANCE, 4, 1, SOUTH
	map_exit 7, 15, MAP_FIRE_CLUB_ENTRANCE, 5, 1, SOUTH
	db $ff

FireClub_NPCs:
	npc NPC_KEN, 7, 2, SOUTH, $0
	npc NPC_JOHN, 6, 9, SOUTH, $0
	npc NPC_ADAM, 5, 7, SOUTH, $0
	npc NPC_JONATHAN, 10, 5, SOUTH, $0
	npc NPC_GR_3, 7, 5, SOUTH, Func_2fc29
	db $ff

FireClub_NPCInteractions:
	npc_script NPC_KEN, Func_2f926
	npc_script NPC_JOHN, Func_2fa25
	npc_script NPC_ADAM, Func_2faa1
	npc_script NPC_JONATHAN, Func_2fb4e
	npc_script NPC_GR_3, Func_2fbd3
	db $ff

FireClub_OWInteractions:
	ow_script 7, 12, Func_2fcad
	ow_script 6, 12, Func_2fcb7
	ow_script 5, 12, Func_2fcc1
	ow_script 8, 12, Func_2fccb
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
	npc_script NPC_KEN, Func_2f9ed
	npc_script NPC_JOHN, Func_2fa85
	npc_script NPC_ADAM, Func_2fb32
	npc_script NPC_JONATHAN, Func_2fbb7
	npc_script NPC_GR_3, Func_2fc0e
	db $ff

Script_2f8f8:
	set_active_npc NPC_KEN, DialogKenText
	script_command_01
	set_active_npc_direction NORTH
	do_frames 60
	print_npc_text Text0c29
	script_command_02
	do_frames 60
	set_player_position 7, 6
	move_player NPCMovement_2f923, TRUE
	scroll_to_position $03, $05
	wait_for_player_animation
	scroll_to_player
	do_frames 30
	script_command_01
	set_event EVENT_GOT_CHARMANDER_COIN
	print_npc_text Text0c2a
	give_coin COIN_CHARMANDER
	print_npc_text Text0c2b
	script_command_02
	end_script
	ret

NPCMovement_2f923:
	db SOUTH, MOVE_3
	db $ff

Func_2f926:
	ld a, $1e
	ld [wScriptNPC], a
	ld hl, $9ec
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	check_event EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE
	script_jump_if_b0z .ows_2f9c7
	check_event EVENT_GODAS_ROOM_CAGE_STATE
	script_jump_if_b0z .ows_2f9a1
	check_event EVENT_FREED_STEVE
	script_jump_if_b0z .ows_2f97b
	check_event EVENT_SET_UNTIL_MAP_RELOAD_1
	script_jump_if_b0z .ows_2f96f
	check_event EVENT_GOT_CHARMANDER_COIN
	script_jump_if_b0z .ows_2f975
	check_event EVENT_TALKED_TO_KEN
	script_jump_if_b0z .ows_2f965
	set_event EVENT_TALKED_TO_KEN
	check_event EVENT_GOT_STARMIE_COIN
	print_variable_npc_text Text0c2c, Text0c2d
	script_jump .ows_2f96c
.ows_2f965
	check_event EVENT_GOT_STARMIE_COIN
	print_variable_npc_text Text0c2e, Text0c2f
.ows_2f96c
	script_command_02
	end_script
	ret
.ows_2f96f
	print_npc_text Text0c30
	script_command_02
	end_script
	ret
.ows_2f975
	print_npc_text Text0c31
	script_command_02
	end_script
	ret
.ows_2f97b
	check_event EVENT_TALKED_TO_KEN
	script_jump_if_b0z .ows_2f988
	set_event EVENT_TALKED_TO_KEN
	print_npc_text Text0c32
	script_jump .ows_2f98b
.ows_2f988
	print_npc_text Text0c33
.ows_2f98b
	ask_question Text0c34, TRUE
	script_jump_if_b0z .ows_2f99b
	print_npc_text Text0c35
	script_command_02
	start_duel GO_ARCANINE_DECK_ID, MUSIC_MATCHSTART_2
	end_script
	ret
.ows_2f99b
	print_npc_text Text0c36
	script_command_02
	end_script
	ret
.ows_2f9a1
	check_event EVENT_TALKED_TO_KEN
	script_jump_if_b0z .ows_2f9ae
	set_event EVENT_TALKED_TO_KEN
	print_npc_text Text0c37
	script_jump .ows_2f9b1
.ows_2f9ae
	print_npc_text Text0c38
.ows_2f9b1
	ask_question Text0c34, TRUE
	script_jump_if_b0z .ows_2f9c1
	print_npc_text Text0c35
	script_command_02
	start_duel GO_ARCANINE_DECK_ID, MUSIC_MATCHSTART_2
	end_script
	ret
.ows_2f9c1
	print_npc_text Text0c39
	script_command_02
	end_script
	ret
.ows_2f9c7
	check_event EVENT_TALKED_TO_KEN
	script_jump_if_b0z .ows_2f9d4
	set_event EVENT_TALKED_TO_KEN
	print_npc_text Text0c3a
	script_jump .ows_2f9d7
.ows_2f9d4
	print_npc_text Text0c38
.ows_2f9d7
	ask_question Text0c34, TRUE
	script_jump_if_b0z .ows_2f9e7
	print_npc_text Text0c35
	script_command_02
	start_duel GO_ARCANINE_DECK_ID, MUSIC_MATCHSTART_2
	end_script
	ret
.ows_2f9e7
	print_npc_text Text0c39
	script_command_02
	end_script
	ret

Func_2f9ed:
	xor a
	start_script
	script_command_01
	check_event EVENT_GODAS_ROOM_CAGE_STATE
	script_jump_if_b0z .ows_2fa0e
	check_event EVENT_SET_UNTIL_MAP_RELOAD_2
	script_jump_if_b0nz .ows_2fa08
	print_npc_text Text0c3b
	give_booster_packs BoosterList_cd02
	print_npc_text Text0c3c
	script_jump .ows_2fa0b
.ows_2fa08
	print_npc_text Text0c3d
.ows_2fa0b
	script_command_02
	end_script
	ret
.ows_2fa0e
	check_event EVENT_SET_UNTIL_MAP_RELOAD_2
	script_jump_if_b0nz .ows_2fa1f
	print_npc_text Text0c3e
	give_booster_packs BoosterList_cd06
	print_npc_text Text0c3f
	script_jump .ows_2fa22
.ows_2fa1f
	print_npc_text Text0c40
.ows_2fa22
	script_command_02
	end_script
	ret

Func_2fa25:
	ld a, $1f
	ld [wScriptNPC], a
	ld hl, $9ed
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	check_event EVENT_FREED_STEVE
	script_jump_if_b0z .ows_2fa5f
	check_event EVENT_SET_UNTIL_MAP_RELOAD_1
	script_jump_if_b0z .ows_2fa53
	check_event EVENT_GOT_CHARMANDER_COIN
	script_jump_if_b0z .ows_2fa59
	check_event EVENT_GOT_STARMIE_COIN
	print_variable_npc_text Text0c41, Text0c42
	script_command_02
	end_script
	ret
.ows_2fa53
	print_npc_text Text0c43
	script_command_02
	end_script
	ret
.ows_2fa59
	print_npc_text Text0c44
	script_command_02
	end_script
	ret
.ows_2fa5f
	check_event EVENT_TALKED_TO_JOHN
	script_jump_if_b0z .ows_2fa6c
	set_event EVENT_TALKED_TO_JOHN
	print_npc_text Text0c45
	script_jump .ows_2fa6f
.ows_2fa6c
	print_npc_text Text0c46
.ows_2fa6f
	ask_question Text0c47, TRUE
	script_jump_if_b0z .ows_2fa7f
	print_npc_text Text0c48
	script_command_02
	start_duel FLAME_FESTIVAL_DECK_ID, MUSIC_MATCHSTART_1
	end_script
	ret
.ows_2fa7f
	print_npc_text Text0c49
	script_command_02
	end_script
	ret

Func_2fa85:
	xor a
	start_script
	script_command_01
	check_event EVENT_SET_UNTIL_MAP_RELOAD_2
	script_jump_if_b0nz .ows_2fa9b
	print_npc_text Text0c4a
	give_booster_packs BoosterList_cd0a
	print_npc_text Text0c4b
	script_jump .ows_2fa9e
.ows_2fa9b
	print_npc_text Text0c4c
.ows_2fa9e
	script_command_02
	end_script
	ret

Func_2faa1:
	ld a, $20
	ld [wScriptNPC], a
	ld hl, $9ee
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	check_event EVENT_FREED_STEVE
	script_jump_if_b0z .ows_2fb0c
	check_event EVENT_SET_UNTIL_MAP_RELOAD_1
	script_jump_if_b0z .ows_2fae0
	check_event EVENT_GOT_CHARMANDER_COIN
	script_jump_if_b0z .ows_2fae6
	check_event EVENT_TALKED_TO_ADAM
	script_jump_if_b0z .ows_2fad6
	set_event EVENT_TALKED_TO_ADAM
	check_event EVENT_GOT_STARMIE_COIN
	print_variable_npc_text Text0c4d, Text0c4e
	script_jump .ows_2fadd
.ows_2fad6
	check_event EVENT_GOT_STARMIE_COIN
	print_variable_npc_text Text0c4f, Text0c50
.ows_2fadd
	script_command_02
	end_script
	ret
.ows_2fae0
	print_npc_text Text0c51
	script_command_02
	end_script
	ret
.ows_2fae6
	check_event EVENT_TALKED_TO_ADAM
	script_jump_if_b0z .ows_2faf3
	set_event EVENT_TALKED_TO_ADAM
	print_npc_text Text0c52
	script_jump .ows_2faf6
.ows_2faf3
	print_npc_text Text0c53
.ows_2faf6
	ask_question Text0c54, TRUE
	script_jump_if_b0z .ows_2fb06
	print_npc_text Text0c55
	script_command_02
	start_duel ELECTRIC_CURRENT_SHOCK_DECK_ID, MUSIC_MATCHSTART_1
	end_script
	ret
.ows_2fb06
	print_npc_text Text0c56
	script_command_02
	end_script
	ret
.ows_2fb0c
	check_event EVENT_TALKED_TO_ADAM
	script_jump_if_b0z .ows_2fb19
	set_event EVENT_TALKED_TO_ADAM
	print_npc_text Text0c57
	script_jump .ows_2fb1c
.ows_2fb19
	print_npc_text Text0c53
.ows_2fb1c
	ask_question Text0c54, TRUE
	script_jump_if_b0z .ows_2fb2c
	print_npc_text Text0c55
	script_command_02
	start_duel ELECTRIC_CURRENT_SHOCK_DECK_ID, MUSIC_MATCHSTART_1
	end_script
	ret
.ows_2fb2c
	print_npc_text Text0c56
	script_command_02
	end_script
	ret

Func_2fb32:
	xor a
	start_script
	script_command_01
	check_event EVENT_SET_UNTIL_MAP_RELOAD_2
	script_jump_if_b0nz .ows_2fb48
	print_npc_text Text0c58
	give_booster_packs BoosterList_cd0e
	print_npc_text Text0c59
	script_jump .ows_2fb4b
.ows_2fb48
	print_npc_text Text0c5a
.ows_2fb4b
	script_command_02
	end_script
	ret

Func_2fb4e:
	ld a, $21
	ld [wScriptNPC], a
	ld hl, $9ef
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	check_event EVENT_SET_UNTIL_MAP_RELOAD_1
	script_jump_if_b0z .ows_2fb8b
	check_event EVENT_GOT_CHARMANDER_COIN
	script_jump_if_b0z .ows_2fb91
	check_event EVENT_GOT_STARMIE_COIN
	script_jump_if_b0z .ows_2fb78
	print_npc_text Text0c5b
	script_jump .ows_2fb88
.ows_2fb78
	check_event EVENT_TALKED_TO_JONATHAN
	script_jump_if_b0z .ows_2fb85
	set_event EVENT_TALKED_TO_JONATHAN
	print_npc_text Text0c5c
	script_jump .ows_2fb88
.ows_2fb85
	print_npc_text Text0c5d
.ows_2fb88
	script_command_02
	end_script
	ret
.ows_2fb8b
	print_npc_text Text0c5e
	script_command_02
	end_script
	ret
.ows_2fb91
	check_event EVENT_TALKED_TO_JONATHAN
	script_jump_if_b0z .ows_2fb9e
	set_event EVENT_TALKED_TO_JONATHAN
	print_npc_text Text0c5f
	script_jump .ows_2fba1
.ows_2fb9e
	print_npc_text Text0c60
.ows_2fba1
	ask_question Text0c61, TRUE
	script_jump_if_b0z .ows_2fbb1
	print_npc_text Text0c62
	script_command_02
	start_duel IMMORTAL_FLAME_DECK_ID, MUSIC_MATCHSTART_1
	end_script
	ret
.ows_2fbb1
	print_npc_text Text0c63
	script_command_02
	end_script
	ret

Func_2fbb7:
	xor a
	start_script
	script_command_01
	check_event EVENT_SET_UNTIL_MAP_RELOAD_2
	script_jump_if_b0nz .ows_2fbcd
	print_npc_text Text0c64
	give_booster_packs BoosterList_cd11
	print_npc_text Text0c65
	script_jump .ows_2fbd0
.ows_2fbcd
	print_npc_text Text0c66
.ows_2fbd0
	script_command_02
	end_script
	ret

Func_2fbd3:
	ld a, $30
	ld [wScriptNPC], a
	ld hl, $a2a
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	check_event EVENT_TALKED_TO_GR3_WATER_CLUB
	script_jump_if_b0z .ows_2fbf5
	set_event EVENT_TALKED_TO_GR3_WATER_CLUB
	print_npc_text Text0c67
	script_jump .ows_2fbf8
.ows_2fbf5
	print_npc_text Text0c68
.ows_2fbf8
	ask_question Text0c69, TRUE
	script_jump_if_b0z .ows_2fc08
	print_npc_text Text0c6a
	script_command_02
	start_duel GREAT_ROCKET3_DECK_ID, MUSIC_DITTY_1
	end_script
	ret
.ows_2fc08
	print_npc_text Text0c6b
	script_command_02
	end_script
	ret

Func_2fc0e:
	xor a
	start_script
	script_command_01
	check_event EVENT_SET_UNTIL_MAP_RELOAD_2
	script_jump_if_b0nz .ows_2fc23
	reset_event EVENT_TALKED_TO_ADAM
	print_npc_text Text0c6c
	give_booster_packs BoosterList_cd48
	script_jump Script_2fc3e

.ows_2fc23
	print_npc_text Text0c6d
	script_command_02
	end_script
	ret

Func_2fc29:
	ld a, $07
	farcall GetEventValue
	jr z, .asm_2fc3c
	ld a, $06
	farcall GetEventValue
	jr nz, .asm_2fc3c
	scf
	ccf
	ret
.asm_2fc3c
	scf
	ret

Script_2fc3e:
	script_command_64 $09
	set_event EVENT_GOT_GR_COIN_PIECE_BOTTOM_LEFT
	print_npc_text Text0c6e
	give_coin COIN_GR_START + COIN_GR_PIECE3
	check_event EVENT_GOT_GR_COIN
	print_variable_npc_text Text0c6f, Text0c70
	set_event EVENT_SET_UNTIL_MAP_RELOAD_1
	reset_event EVENT_TALKED_TO_ADAM
	reset_event EVENT_TALKED_TO_JONATHAN
	print_npc_text Text0c71
	script_command_02
	set_scroll_state $02
	get_player_direction
	compare_loaded_var $03
	script_jump_if_b0z .ows_2fc65
	set_player_direction NORTH
	animate_player_movement $82, $02
.ows_2fc65
	move_active_npc NPCMovement_2fca1
	scroll_to_position $03, $07
	wait_for_player_animation
	do_frames 60
	script_command_01
	play_sfx SFX_29
	print_npc_text_instant Text0c72
	script_command_67 $04, $1e
	do_frames 60
	fade_out $01, TRUE
	wait_for_fade
	script_command_68
	play_sfx SFX_0F
	script_command_02
	load_tilemap TILEMAP_02E, $05, $0b
	load_tilemap TILEMAP_02F, $05, $07
	do_frames 28
	fade_in $01, TRUE
	wait_for_fade
	script_command_01
	print_npc_text Text0c73
	script_command_02
	move_active_npc NPCMovement_2fcaa
	wait_for_player_animation
	unload_npc NPC_GR_3
	play_song_next MUSIC_CLUB_3
	script_jump Script_2f8f8

NPCMovement_2fca1:
	db EAST, MOVE_3
	db SOUTH, MOVE_7
	db WEST, MOVE_3
	db NORTH, MOVE_0
	db $ff

NPCMovement_2fcaa:
	db SOUTH, MOVE_4
	db $ff

Func_2fcad:
	ld a, $06
	farcall GetEventValue
	ret nz
	jp Func_2f926

Func_2fcb7:
	ld a, $06
	farcall GetEventValue
	ret nz
	jp Func_2fa25

Func_2fcc1:
	ld a, $06
	farcall GetEventValue
	ret nz
	jp Func_2faa1

Func_2fccb:
	ld a, $06
	farcall GetEventValue
	ret nz
	jp Func_2fb4e

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
	npc NPC_POKEMON_DOME_FAT_GUY, 8, 3, NORTH, Func_2fe1d
	db $ff

PokemonDomeEntrance_NPCInteractions:
	npc_script NPC_POKEMON_DOME_FAT_GUY, Func_2fda3
	db $ff

PokemonDomeEntrance_OWInteractions:
	ow_script 4, 2, PCMenu
	ow_script 5, 2, PCMenu
	ow_script 9, 1, Func_2fe2a
	ow_script 10, 1, Func_2fe2a
	ow_script 1, 2, Func_4035a
	ow_script 2, 2, Func_40370
	ow_script 3, 2, Func_40386
	ow_script 1, 5, Func_4039c
	ow_script 2, 5, Func_403b2
	ow_script 3, 5, Func_403c8
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

Func_2fda3:
	ld a, $b2
	ld [wScriptNPC], a
	ld hl, $9f9
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	check_event EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE
	script_jump_if_b0z .ows_2fdfa
	check_event EVENT_FREED_ROD
	script_jump_if_b0z .ows_2fdf4
	check_event EVENT_FREED_JACK
	script_jump_if_b0z .ows_2fde3
	check_event EVENT_FREED_COURTNEY
	script_jump_if_b0z .ows_2fddd
	check_event EVENT_FREED_STEVE
	script_jump_if_b0z .ows_2fdd7
	print_npc_text Text102a
	script_command_02
	end_script
	ret
.ows_2fdd7
	print_npc_text Text102b
	script_command_02
	end_script
	ret
.ows_2fddd
	print_npc_text Text102c
	script_command_02
	end_script
	ret
.ows_2fde3
	check_event EVENT_FREED_COURTNEY
	script_jump_if_b0z .ows_2fdee
	print_npc_text Text102d
	script_command_02
	end_script
	ret
.ows_2fdee
	print_npc_text Text102e
	script_command_02
	end_script
	ret
.ows_2fdf4
	print_npc_text Text102f
	script_command_02
	end_script
	ret
.ows_2fdfa
	check_event EVENT_SET_UNTIL_MAP_RELOAD_1
	script_jump_if_b0z .ows_2fe17
	get_var VAR_0D
	compare_loaded_var $02
	script_jump_if_b0nz .ows_2fe11
	compare_loaded_var $03
	script_jump_if_b0nz .ows_2fe11
	print_npc_text Text1030
	script_command_02
	end_script
	ret
.ows_2fe11
	print_npc_text Text1031
	script_command_02
	end_script
	ret
.ows_2fe17
	print_npc_text Text1032
	script_command_02
	end_script
	ret

Func_2fe1d:
	ld a, $0b
	farcall GetEventValue
	jr nz, .asm_2fe27
	scf
	ret
.asm_2fe27
	scf
	ccf
	ret

Func_2fe2a:
	ld a, $00
	ld [wScriptNPC], a
	ld hl, $9f8
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	print_npc_text Text1033
	script_command_02
	end_script
	ret

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
