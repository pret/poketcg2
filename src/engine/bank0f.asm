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
	ld a, NPC_GR_BLIMP
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

	ld a, NPC_GR_BLIMP
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
	ld a, NPC_GR_BLIMP
	farcall SetOWObjectTargetPosition
	pop bc
.loop
	push bc
	ld a, 3
	call WaitAFrames
	farcall MoveOWObjectToTargetPosition
	pop bc
	; override direction
	ld a, NPC_GR_BLIMP
	farcall _SetOWObjectDirection
	jr c, .loop
	ret

.DoGRShipBeamAnimation:
	ld a, SFX_8B
	call PlaySFX
	ld a, NPC_GR_BLIMP
	farcall GetOWObjectPosition
	ld a, e
	add $10
	ld e, a
	ld a, d
	sub $04
	ld d, a
	ld a, NPC_GR_BLIMP_BEAM
	ld b, SOUTH
	farcall LoadOWObject
	call WaitForOWObjectAnimation
	ld a, NPC_GR_BLIMP_BEAM
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

Func_3c1b9:
	ld a, $64
	ld [wScriptNPC], a
	ld hl, $a5a
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	ld a, $02
	ld [wDuelTheme], a
	jr Func_3c1d0.asm_3c1e5

Func_3c1d0:
	ld a, $68
	ld [wScriptNPC], a
	ld hl, $a5a
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	ld a, $1f
	ld [wDuelTheme], a
.asm_3c1e5
	xor a
	start_script
	script_command_01
	print_npc_text BattleCenterWelcomeText
	ask_question BattleCenterBeginPromptText, TRUE
	script_jump_if_b0z .ows_3c20b
	play_song MUSIC_CARDPOP
	script_command_64 $1c
	script_command_02
	link_duel
	script_jump_if_b1nz .ows_3c204
	script_call .ows_3c211
	script_jump .ows_3c20b
.ows_3c204
	script_command_01
	print_npc_text BattleCenterThankYouText
	script_jump .ows_3c20e
.ows_3c20b
	print_npc_text BattleCenterComeAgainText
.ows_3c20e
	script_command_02
	end_script
	ret
.ows_3c211
	script_command_01
	check_event EVENT_SET_UNTIL_MAP_RELOAD_2
	script_jump_if_b0nz .ows_3c242
	script_call Script_3c2c1
	print_npc_text BattleCenterWinRewardsText
	check_event EVENT_GOT_MACHAMP_COIN
	script_jump_if_b0z .ows_3c234
	check_event EVENT_GOT_GR_COIN
	script_jump_if_b0z .ows_3c22e
	give_booster_packs BoosterList_ce17
	script_jump .ows_3c237
.ows_3c22e
	give_booster_packs BoosterList_ce1c
	script_jump .ows_3c237
.ows_3c234
	give_booster_packs BoosterList_ce21
.ows_3c237
	script_call .ows_3c25f
	script_call Script_3c290
	script_jump .ows_3c25e
.ows_3c242
	print_npc_text BattleCenterLoseRewardsText
	check_event EVENT_GOT_MACHAMP_COIN
	script_jump_if_b0z .ows_3c25b
	check_event EVENT_GOT_GR_COIN
	script_jump_if_b0z .ows_3c255
	give_booster_packs BoosterList_ce26
	script_jump .ows_3c25e
.ows_3c255
	give_booster_packs BoosterList_ce29
	script_jump .ows_3c25e
.ows_3c25b
	give_booster_packs BoosterList_ce2c
.ows_3c25e
	script_ret
.ows_3c25f
	quit_script
; 0x3c260

SECTION "Bank f@4290", ROMX[$4290], BANK[$f]

Script_3c290:
	quit_script
; 0x3c291

SECTION "Bank f@42c1", ROMX[$42c1], BANK[$f]

Script_3c2c1:
	check_event EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE
	script_jump_if_b0nz .ows_3c2d8
	get_var VAR_20
	compare_loaded_var $0a
	script_jump_if_b1z .ows_3c2d8
	inc_var VAR_20
	get_var VAR_20
	compare_loaded_var $05
	script_jump_if_b0z .ows_3c2d8
	script_command_64 $0f
.ows_3c2d8
	script_ret

Func_3c2d9:
	ld a, $f2
	farcall ZeroOutEventValue
	farcall Func_1d9be
	ld a, $f2
	farcall GetEventValue
	jr z, .asm_3c2ef
	farcall PlayCurrentSong
.asm_3c2ef
	ret

Script_3c2f0:
	get_var VAR_21
	compare_loaded_var $00
	script_jump_if_b0z .ows_3c30b
	check_event EVENT_GOT_GR_COIN
	script_jump_if_b0z .ows_3c305
	set_var VAR_21, $01
	set_var VAR_25, $09
	script_jump .ows_3c30b

.ows_3c305
	set_var VAR_21, $03
	set_var VAR_25, $09
.ows_3c30b
	script_retfar

Func_3c30c:
	ld a, $05
	ld [wScriptNPC], a
	ld hl, $a2f
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	get_var VAR_21
	compare_loaded_var $02
	script_jump_if_b1nz .ows_3c333
	script_jump_if_b0nz .ows_3c37f
	compare_loaded_var $03
	script_jump_if_b0nz Script_3c3a5
	script_jump Script_3c3ae
.ows_3c333
	set_var VAR_21, $02
	set_var VAR_25, $0f
	print_npc_text ImakuniBlackCardlessFirstCardPopText
	card_pop SCRIPTED_CARD_POP_IMAKUNI
	print_npc_text ImakuniBlackCardlessAfterFirstCardPopSaveText
	quit_script
	ld a, $03
	farcall MaxOutEventValue
	farcall Func_ea30
	ld a, $03
	farcall ZeroOutEventValue
	ld a, $01
	start_script
	play_sfx SFX_56
	print_text SavedDataText
	print_npc_text ImakuniBlackCardlessAfterFirstCardPopResultText
	script_command_02
	get_player_direction
	compare_loaded_var $02
	script_jump_if_b0z .ows_3c36b
	set_player_direction WEST
	animate_player_movement $81, $02
.ows_3c36b
	move_active_npc NPCMovement_3c492
	wait_for_player_animation
	unload_npc NPC_IMAKUNI_BLACK
	end_script
	ld a, $00
	ld [wd582], a
	ld a, [wNextMusic]
	farcall PlayAfterCurrentSong
	ret
.ows_3c37f
	set_var VAR_25, $0f
	print_npc_text ImakuniBlackCardlessAfterFirstCardPopRepeatText
	script_command_02
	get_player_direction
	compare_loaded_var $02
	script_jump_if_b0z .ows_3c391
	set_player_direction WEST
	animate_player_movement $81, $02
.ows_3c391
	move_active_npc NPCMovement_3c492
	wait_for_player_animation
	unload_npc NPC_IMAKUNI_BLACK
	end_script
; 0x3c398

SECTION "Bank f@43a5", ROMX[$43a5], BANK[$f]

Script_3c3a5:
	set_var VAR_21, $04
	print_npc_text ImakuniBlackWantsToDuelFirstEncounterText
	script_jump Script_3c3b4

Script_3c3ae:
	print_npc_text ImakuniBlackWantsToDuelRepeatText
	script_jump Script_3c3b4

Script_3c3b4:
	ask_question ImakuniBlackDuelPromptText, TRUE
	script_jump_if_b0z .ows_3c3c4
	print_npc_text ImakuniBlackDuelStartText
	script_command_02
	start_duel WEIRD_DECK_ID, MUSIC_MATCHSTART_1
	end_script
	ret

.ows_3c3c4
	print_npc_text ImakuniBlackDeclinedDuelText
	script_command_02
	end_script
	ret

Script_FinishedImakuniBlackDuel:
	xor a
	start_script
	script_command_01
	set_var VAR_25, $0f
	check_event EVENT_SET_UNTIL_MAP_RELOAD_2
	script_jump_if_b0nz .player_lost
	inc_var VAR_IMAKUNI_BLACK_WIN_COUNT
	get_var VAR_IMAKUNI_BLACK_WIN_COUNT
	compare_loaded_var IMAKUNI_THRESHOLD_3 + 1
	script_jump_if_b1nz .sequences
	set_var VAR_IMAKUNI_BLACK_WIN_COUNT, IMAKUNI_THRESHOLD_3 + 1
.sequences
	compare_loaded_var IMAKUNI_THRESHOLD_1
	script_jump_if_b1nz .sequence_win
	script_jump_if_b0nz .sequence_three_wins
	compare_loaded_var IMAKUNI_THRESHOLD_2
	script_jump_if_b0nz .sequence_six_wins
	compare_loaded_var IMAKUNI_THRESHOLD_3
	script_jump_if_b0nz .sequence_nine_wins
	script_jump .sequence_many_wins

.sequence_win
	script_call .win
	script_jump .bye

.sequence_three_wins
	script_call .three_wins
	script_jump .bye

.sequence_six_wins
	script_call .six_wins
	script_jump .bye

.sequence_nine_wins
	script_call .nine_wins
	script_jump .bye

.sequence_many_wins
	script_call .many_wins
	script_jump .bye

.player_lost
	print_npc_text ImakuniBlackPlayerLostText
.bye
	print_npc_text ImakuniBlackByeText
	script_command_02
	get_player_direction
	compare_loaded_var SOUTH
	script_jump_if_b0z .exit
	set_player_direction WEST
	animate_player_movement $81, $02
.exit
	move_active_npc NPCMovement_3c492
	wait_for_player_animation
	unload_npc NPC_IMAKUNI_BLACK
	end_script
	ld a, 0
	ld [wd582], a
	ld a, [wNextMusic]
	farcall PlayAfterCurrentSong
	ret

.win
	print_npc_text ImakuniBlackPlayerWonNormalText
	give_booster_packs BoosterList_cddd
	script_ret

.three_wins
	print_npc_text ImakuniBlackPlayerWon3Text
	give_card FARFETCHD_ALT_LV20
	show_card_received_screen FARFETCHD_ALT_LV20
	script_ret

.six_wins
	print_npc_text ImakuniBlackPlayerWon6Text
	give_card IMAKUNI_CARD
	show_card_received_screen IMAKUNI_CARD
	script_ret

.nine_wins
	print_npc_text ImakuniBlackPlayerWon9Text
	get_random 2
	compare_loaded_var 0
	script_jump_if_b0z .nine_wins_prize_imakuni
; prize farfetch'd
	give_card FARFETCHD_ALT_LV20
	show_card_received_screen FARFETCHD_ALT_LV20
	script_ret
.nine_wins_prize_imakuni
	give_card IMAKUNI_CARD
	show_card_received_screen IMAKUNI_CARD
	script_ret

.many_wins
	print_npc_text ImakuniBlackPlayerWonManyText
	get_var VAR_IMAKUNI_BLACK_WIN_COUNT
	compare_loaded_var IMAKUNI_THRESHOLD_2
	script_jump_if_b1nz .boosters_1
	compare_loaded_var IMAKUNI_THRESHOLD_3
	script_jump_if_b1nz .boosters_2
	script_jump .boosters_3

.boosters_1
	give_booster_packs BoosterList_cde3
	script_ret

.boosters_2
	give_booster_packs BoosterList_cde9
	script_ret

.boosters_3
	give_booster_packs BoosterList_cdf0
	script_ret

NPCMovement_3c492:
	db NORTH, MOVE_3
	db EAST, MOVE_14
	db $ff

Script_3c497:
	set_var VAR_26, $0f
	print_npc_text Text12d3
	card_pop SCRIPTED_RARE_CARD_POP_IMAKUNI
	print_npc_text Text12d4
	quit_script
; 0x3c4a3

SECTION "Bank f@44e0", ROMX[$44e0], BANK[$f]

Func_3c4e0:
	ld a, $b1
	ld [wScriptNPC], a
	ld hl, $a2f
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	get_var VAR_23
	compare_loaded_var $00
	script_jump_if_b0nz .ows_3c50b
	check_event EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE
	script_jump_if_b0nz .ows_3c514
	get_random $14
	compare_loaded_var $00
	script_jump_if_b0z .ows_3c514
	script_jump Script_3c497
.ows_3c50b
	set_var VAR_23, $01
	print_npc_text Text12d6
	script_jump .ows_3c517
.ows_3c514
	print_npc_text Text12d7
.ows_3c517
	ask_question Text12d8, TRUE
	script_jump_if_b0z .ows_3c527
	print_npc_text Text12d9
	script_command_02
	start_duel STRANGE_DECK_ID, MUSIC_MATCHSTART_1
	end_script
	ret
.ows_3c527
	print_npc_text Text12da
	script_command_02
	end_script
	ret

Func_3c52d:
	xor a
	start_script
	script_command_01
	set_var VAR_26, $0f
	check_event EVENT_SET_UNTIL_MAP_RELOAD_2
	script_jump_if_b0nz .ows_3c574
	inc_var VAR_24
	get_var VAR_24
	compare_loaded_var $0a
	script_jump_if_b1nz .ows_3c546
	set_var VAR_24, $0a
.ows_3c546
	compare_loaded_var $03
	script_jump_if_b0nz .ows_3c558
	compare_loaded_var $06
	script_jump_if_b0nz .ows_3c55f
	compare_loaded_var $09
	script_jump_if_b0nz .ows_3c566
	script_jump .ows_3c56d
.ows_3c558
	script_call .ows_3c597
	script_jump .ows_3c577
.ows_3c55f
	script_call .ows_3c5a4
	script_jump .ows_3c577
.ows_3c566
	script_call .ows_3c5b1
	script_jump .ows_3c577
.ows_3c56d
	script_call .ows_3c5ce
	script_jump .ows_3c577
.ows_3c574
	print_npc_text Text12db
.ows_3c577
	script_command_02
	get_player_direction
	compare_loaded_var $00
	script_jump_if_b0z .ows_3c583
	set_player_direction EAST
	animate_player_movement $83, $02
.ows_3c583
	move_active_npc NPCMovement_3c5fe
	wait_for_player_animation
	unload_npc NPC_IMAKUNI_RED
	end_script
	ld a, $00
	ld [wd582], a
	ld a, [wNextMusic]
	farcall PlayAfterCurrentSong
	ret
.ows_3c597
	print_npc_text Text12dc
	give_card SLOWPOKE_LV9
	show_card_received_screen SLOWPOKE_LV9
	print_npc_text Text12dd
	script_ret
.ows_3c5a4
	print_npc_text Text12de
	give_card IMAKUNI_CARD
	show_card_received_screen IMAKUNI_CARD
	print_npc_text Text12df
	script_ret
.ows_3c5b1
	print_npc_text Text12e0
	get_random $02
	compare_loaded_var $00
	script_jump_if_b0z .ows_3c5c4
	give_card SLOWPOKE_LV9
	show_card_received_screen SLOWPOKE_LV9
	script_jump .ows_3c5ca
.ows_3c5c4
	give_card IMAKUNI_CARD
	show_card_received_screen IMAKUNI_CARD
.ows_3c5ca
	print_npc_text Text12e1
	script_ret
.ows_3c5ce
	print_npc_text Text12e2
	get_var VAR_24
	compare_loaded_var $03
	script_jump_if_b1nz .ows_3c5e5
	compare_loaded_var $06
	script_jump_if_b1nz .ows_3c5eb
	compare_loaded_var $09
	script_jump_if_b1nz .ows_3c5f1
	script_jump .ows_3c5f7
.ows_3c5e5
	give_booster_packs BoosterList_cdf8
	script_jump .ows_3c5fa
.ows_3c5eb
	give_booster_packs BoosterList_cdfe
	script_jump .ows_3c5fa
.ows_3c5f1
	give_booster_packs BoosterList_ce05
	script_jump .ows_3c5fa
.ows_3c5f7
	give_booster_packs BoosterList_ce0d
.ows_3c5fa
	print_npc_text Text12e3
	script_ret
NPCMovement_3c5fe:
	db SOUTH, MOVE_5
	db EAST, MOVE_3
	db $ff

	MasonLaboratoryComputerRoom_MapHeader:
	db MAP_GFX_MASON_LABORATORY_COMPUTER_ROOM
	dba MasonLaboratoryComputerRoom_MapScripts
	db MUSIC_OVERWORLD

MasonLaboratoryComputerRoom_StepEvents:
	map_exit 0, 5, MAP_MASON_LABORATORY_MAIN, 12, 5, WEST
	map_exit 0, 6, MAP_MASON_LABORATORY_MAIN, 12, 6, WEST
	db $ff

MasonLaboratoryComputerRoom_NPCs:
	npc NPC_LAB_TECH_AUTO_DECK_MACHINE_1, 4, 3, SOUTH, $0
	npc NPC_LAB_TECH_DECK_SAVE_MACHINE, 7, 3, SOUTH, $0
	npc NPC_LAB_TECH_COMPUTER_ROOM, 3, 8, NORTH, $0
	npc NPC_LAB_TECH_AUTO_DECK_MACHINE_2, 7, 9, EAST, $0
	db $ff

MasonLaboratoryComputerRoom_NPCInteractions:
	npc_script NPC_LAB_TECH_AUTO_DECK_MACHINE_1, Func_3c739
	npc_script NPC_LAB_TECH_DECK_SAVE_MACHINE, Func_3c75f
	npc_script NPC_LAB_TECH_COMPUTER_ROOM, Func_3c77a
	npc_script NPC_LAB_TECH_AUTO_DECK_MACHINE_2, Func_3c7ab
	db $ff

MasonLaboratoryComputerRoom_OWInteractions:
	ow_script 2, 3, Func_3c6c3
	ow_script 3, 3, Func_3c6c3
	ow_script 8, 10, Func_3c6e8
	ow_script 9, 10, Func_3c6e8
	ow_script 8, 3, Func_3c715
	ow_script 9, 3, Func_3c715
	db $ff

MasonLaboratoryComputerRoom_MapScripts:
	dbw $06, Func_3c689
	dbw $08, Func_3c6b3
	dbw $07, Func_3c690
	dbw $02, Func_3c697
	db $ff

Func_3c689:
	ld hl, MasonLaboratoryComputerRoom_StepEvents
	call Func_324d
	ret

Func_3c690:
	ld hl, MasonLaboratoryComputerRoom_NPCs
	call Func_3205
	ret

Func_3c697:
	ld a, $10
	farcall GetEventValue
	jr z, .asm_3c6b1
	ld a, $ba
	ld b, $03
	farcall SetOWObjectDirection
	ld bc, $8
	ld de, $707
	farcall Func_12c0ce
.asm_3c6b1
	scf
	ret

Func_3c6b3:
	ld hl, MasonLaboratoryComputerRoom_NPCInteractions
	call Func_328c
	jr nc, .asm_3c6c1
	ld hl, MasonLaboratoryComputerRoom_OWInteractions
	call Func_32bf
.asm_3c6c1
	scf
	ret

Func_3c6c3:
	xor a
	start_script
	script_command_01
	print_text Text0eec
	ask_question Text0eed, TRUE
	script_jump_if_b0z .ows_3c6e5
	script_command_02
	end_script
	call PauseSong
	ld a, $07
	call PlaySong
	xor a
	farcall Func_1e855
	call ResumeSong
	ret
.ows_3c6e5
	script_command_02
	end_script
	ret

Func_3c6e8:
	ld a, $10
	farcall GetEventValue
	ret z
	xor a
	start_script
	script_command_01
	print_text Text0eee
	ask_question Text0eed, TRUE
	script_jump_if_b0z .ows_3c712
	script_command_02
	end_script
	call PauseSong
	ld a, $07
	call PlaySong
	ld a, $01
	farcall Func_1e855
	call ResumeSong
	ret
.ows_3c712
	script_command_02
	end_script
	ret

Func_3c715:
	xor a
	start_script
	script_command_01
	print_text Text0ef0
	ask_question Text0ef1, TRUE
	script_jump_if_b0z .ows_3c736
	script_command_02
	end_script
	call PauseSong
	ld a, $07
	call PlaySong
	farcall Func_1e849
	call ResumeSong
	ret
.ows_3c736
	script_command_02
	end_script
	ret

Func_3c739:
	ld a, $b7
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
	script_jump_if_b0z .ows_3c759
	print_npc_text Text0ef2
	script_jump .ows_3c75c
.ows_3c759
	print_npc_text Text0ef3
.ows_3c75c
	script_command_02
	end_script
	ret

Func_3c75f:
	ld a, $b8
	ld [wScriptNPC], a
	ld hl, $a4a
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	print_npc_text Text0ef4
	script_command_02
	end_script
	ret

Func_3c77a:
	ld a, $b9
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
	script_jump_if_b0z .ows_3c7a5
	check_event EVENT_SHORT_GR_ISLAND_FLYOVER_SEQUENCE
	script_jump_if_b0z .ows_3c79f
	print_npc_text Text0ef5
	script_jump .ows_3c7a8
.ows_3c79f
	print_npc_text Text0ef6
	script_jump .ows_3c7a8
.ows_3c7a5
	print_npc_text Text0ef7
.ows_3c7a8
	script_command_02
	end_script
	ret

Func_3c7ab:
	ld a, $ba
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
	script_jump_if_b0z .ows_3c7d6
	check_event EVENT_GOT_GOLBAT_COIN
	script_jump_if_b0z .ows_3c7d0
	print_npc_text Text0ef8
	script_jump .ows_3c7d9
.ows_3c7d0
	print_npc_text Text0ef9
	script_jump .ows_3c7d9
.ows_3c7d6
	print_npc_text Text0efa
.ows_3c7d9
	script_command_02
	end_script
	ret

MasonLaboratoryTrainingRoom_MapHeader:
	db MAP_GFX_MASON_LABORATORY_TRAINING_ROOM
	dba MasonLaboratoryTrainingRoom_MapScripts
	db MUSIC_OVERWORLD

MasonLaboratoryTrainingRoom_StepEvents:
	map_exit 13, 11, MAP_MASON_LABORATORY_MAIN, 1, 5, EAST
	map_exit 13, 12, MAP_MASON_LABORATORY_MAIN, 1, 6, EAST
	db $ff

MasonLaboratoryTrainingRoom_NPCs:
	npc NPC_AARON, 11, 2, NORTH, $0
	npc NPC_LAB_TECH_TRAINING_ROOM, 10, 11, EAST, $0
	db $ff

MasonLaboratoryTrainingRoom_NPCInteractions:
	npc_script NPC_AARON, Func_3c84c
	npc_script NPC_LAB_TECH_TRAINING_ROOM, Func_3ca4d
	db $ff

MasonLaboratoryTrainingRoom_MapScripts:
	dbw $06, Func_3c817
	dbw $08, Func_3c825
	dbw $09, Func_3c82d
	dbw $07, Func_3c81e
	db $ff

Func_3c817:
	ld hl, MasonLaboratoryTrainingRoom_StepEvents
	call Func_324d
	ret

Func_3c81e:
	ld hl, MasonLaboratoryTrainingRoom_NPCs
	call Func_3205
	ret

Func_3c825:
	ld hl, MasonLaboratoryTrainingRoom_NPCInteractions
	call Func_328c
	scf
	ret

Func_3c82d:
	ld hl, MasonLaboratoryTrainingRoom_AfterDuelScripts
	ld a, $3b
	farcall GetVarValue
	call Func_344c
	scf
	ret

MasonLaboratoryTrainingRoom_AfterDuelScripts:
	npc_script NPC_MINT, Func_3c931
	npc_script NPC_DR_MASON, Func_3c97e
	npc_script NPC_RONALD, Func_3c9cb
	npc_script NPC_ISHIHARA, Func_3ca28
	db $ff

Func_3c84c:
	ld a, $07
	ld [wScriptNPC], a
	ld hl, $9d2
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	get_var VAR_27
	compare_loaded_var $04
	script_jump_if_b0nz .ows_3c87f
	script_jump_if_b1z .ows_3c88a
	compare_loaded_var $00
	script_jump_if_b0z .ows_3c879
	set_var VAR_27, $01
	print_npc_text Text0f3a
	script_jump .ows_3c890
.ows_3c879
	print_npc_text Text0f3b
	script_jump .ows_3c890
.ows_3c87f
	check_event EVENT_GOT_MACHAMP_COIN
	script_jump_if_b0nz .ows_3c879
	print_npc_text Text0f3c
	script_jump .ows_3c890
.ows_3c88a
	var_sub VAR_27, $05
	print_npc_text Text0f3d
.ows_3c890
	get_var VAR_27
	compare_loaded_var $03
	script_jump_if_b0nz .ows_3c8cb
	script_jump_if_b1z .ows_3c8e7
	compare_loaded_var $02
	script_jump_if_b0nz .ows_3c8b3
	print_npc_text Text0f3e
	quit_script
	ld a, $02
	ld b, $00
	farcall Func_121e1
	jr c, .asm_3c90a
	or a
	jp z, Func_3c917
	jr .asm_3c90a
.ows_3c8b3
	print_npc_text Text0f3f
	quit_script
	ld a, $03
	ld b, $00
	farcall Func_121e1
	jr c, .asm_3c90a
	or a
	jp z, Func_3c917
	dec a
	jp z, Func_3c964
	jr .asm_3c90a
.ows_3c8cb
	print_npc_text Text0f3f
	quit_script
	ld a, $04
	ld b, $00
	farcall Func_121e1
	jr c, .asm_3c90a
	or a
	jp z, Func_3c917
	dec a
	jp z, Func_3c964
	dec a
	jp z, Func_3c9b1
	jr .asm_3c90a
.ows_3c8e7
	check_event EVENT_GOT_MACHAMP_COIN
	script_jump_if_b0nz .ows_3c8cb
	print_npc_text Text0f40
	quit_script
	ld a, $05
	ld b, $00
	farcall Func_121e1
	jr c, .asm_3c90a
	cp $01
	jp c, Func_3c917
	jp z, Func_3c964
	cp $03
	jp c, Func_3c9b1
	jp z, Func_3ca02
.asm_3c90a
	ld a, $01
	start_script
	print_npc_text Text0f41
	set_active_npc_direction NORTH
	script_command_02
	end_script
	ret

Func_3c917:
	ld a, $01
	start_script
	print_npc_text Text0f42
	script_command_02
	script_call Script_3ca68
	script_command_01
	print_npc_text Text0f43
	script_command_02
	set_var VAR_3B, $01
	start_duel AARONS_STEP1_DECK_ID, MUSIC_MATCHSTART_1
	end_script
	ret

Func_3c931:
	xor a
	start_script
	script_command_01
	check_event EVENT_SET_UNTIL_MAP_RELOAD_2
	script_jump_if_b0nz .ows_3c951
	get_var VAR_27
	compare_loaded_var $02
	script_jump_if_b1z .ows_3c945
	set_var VAR_27, $02
.ows_3c945
	print_npc_text Text0f44
	give_booster_packs BoosterList_cc9e
	print_npc_text Text0f45
	script_jump .ows_3c954
.ows_3c951
	print_npc_text Text0f46
.ows_3c954
	script_command_02
	move_active_npc NPCMovement_3c95f
	wait_for_player_animation
	set_active_npc_position_and_direction 11, 2, NORTH
	end_script
	ret
NPCMovement_3c95f:
	db EAST, MOVE_4
	db NORTH, MOVE_2
	db $ff

Func_3c964:
	ld a, $01
	start_script
	print_npc_text Text0f47
	script_command_02
	script_call Script_3cab1
	script_command_01
	print_npc_text Text0f48
	script_command_02
	set_var VAR_3B, $02
	start_duel AARONS_STEP2_DECK_ID, MUSIC_MATCHSTART_1
	end_script
	ret

Func_3c97e:
	xor a
	start_script
	script_command_01
	check_event EVENT_SET_UNTIL_MAP_RELOAD_2
	script_jump_if_b0nz .ows_3c99e
	get_var VAR_27
	compare_loaded_var $03
	script_jump_if_b1z .ows_3c992
	set_var VAR_27, $03
.ows_3c992
	print_npc_text Text0f49
	give_booster_packs BoosterList_cca1
	print_npc_text Text0f45
	script_jump .ows_3c9a1
.ows_3c99e
	print_npc_text Text0f4a
.ows_3c9a1
	script_command_02
	move_active_npc NPCMovement_3c9ac
	wait_for_player_animation
	set_active_npc_position_and_direction 11, 2, NORTH
	end_script
	ret
NPCMovement_3c9ac:
	db NORTH, MOVE_1
	db EAST, MOVE_6
	db $ff

Func_3c9b1:
	ld a, $01
	start_script
	print_npc_text Text0f4b
	script_command_02
	script_call Script_3cb06
	script_command_01
	print_npc_text Text0f4c
	script_command_02
	set_var VAR_3B, $03
	start_duel AARONS_STEP3_DECK_ID, MUSIC_MATCHSTART_1
	end_script
	ret

Func_3c9cb:
	xor a
	start_script
	script_command_01
	check_event EVENT_SET_UNTIL_MAP_RELOAD_2
	script_jump_if_b0nz .ows_3c9ef
	get_var VAR_27
	compare_loaded_var $04
	script_jump_if_b1z .ows_3c9df
	set_var VAR_27, $04
.ows_3c9df
	print_npc_text Text0f4d
	give_booster_packs BoosterList_cca4
	check_event EVENT_GOT_MACHAMP_COIN
	print_variable_npc_text Text0f4e, Text0f4f
	script_jump .ows_3c9f2
.ows_3c9ef
	print_npc_text Text0f50
.ows_3c9f2
	script_command_02
	move_active_npc NPCMovement_3c9fd
	wait_for_player_animation
	set_active_npc_position_and_direction 11, 2, NORTH
	end_script
	ret
NPCMovement_3c9fd:
	db NORTH, MOVE_1
	db EAST, MOVE_6
	db $ff

Func_3ca02:
	ld a, $01
	start_script
	print_npc_text Text0f51
	script_command_02
	script_call Script_3cb4b
	script_command_01
	print_npc_text Text0f52
	script_command_02
	set_var VAR_3B, $04
	get_random $02
	compare_loaded_var $00
	script_jump_if_b0z .ows_3ca23
	start_duel BRICK_WALK_DECK_ID, MUSIC_MATCHSTART_1
	end_script
	ret
.ows_3ca23
	start_duel BENCH_TRAP_DECK_ID, MUSIC_MATCHSTART_1
	end_script
	ret

Func_3ca28:
	xor a
	start_script
	script_command_01
	check_event EVENT_SET_UNTIL_MAP_RELOAD_2
	script_jump_if_b0nz .ows_3ca3e
	print_npc_text Text0f53
	give_booster_packs BoosterList_cca7
	print_npc_text Text0f54
	script_jump .ows_3ca41
.ows_3ca3e
	print_npc_text Text0f55
.ows_3ca41
	script_command_02
	move_active_npc NPCMovement_3ca48
	wait_for_player_animation
	end_script
	ret
NPCMovement_3ca48:
	db EAST, MOVE_4
	db NORTH, MOVE_0
	db $ff

Func_3ca4d:
	ld a, $bb
	ld [wScriptNPC], a
	ld hl, $a4a
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	print_npc_text Text0f56
	script_command_02
	end_script
	ret

Script_3ca68:
	get_player_direction
	compare_loaded_var $03
	script_jump_if_b0nz .ows_3ca81
	compare_loaded_var $00
	script_jump_if_b0nz .ows_3ca7a
	move_player NPCMovement_3ca94, TRUE
	script_jump .ows_3ca85
.ows_3ca7a
	move_player NPCMovement_3ca9b, TRUE
	script_jump .ows_3ca85
.ows_3ca81
	move_player NPCMovement_3caa6, TRUE
.ows_3ca85
	move_npc NPC_AARON, NPCMovement_3ca8b
	wait_for_player_animation
	script_ret
NPCMovement_3ca8b:
	db WEST, MOVE_2
	db SOUTH, MOVE_5
	db WEST, MOVE_2
	db SOUTH, MOVE_0
	db $ff
NPCMovement_3ca94:
	db SOUTH, MOVE_8
	db WEST, MOVE_3
	db NORTH, MOVE_0
	db $ff
NPCMovement_3ca9b:
	db SOUTH, MOVE_3
	db WEST, MOVE_1
	db SOUTH, MOVE_4
	db WEST, MOVE_3
	db NORTH, MOVE_0
	db $ff
NPCMovement_3caa6:
	db SOUTH, MOVE_6
	db WEST, MOVE_2
	db SOUTH, MOVE_2
	db WEST, MOVE_3
	db NORTH, MOVE_0
	db $ff

Script_3cab1:
	get_player_direction
	compare_loaded_var $03
	script_jump_if_b0nz .ows_3caca
	compare_loaded_var $00
	script_jump_if_b0nz .ows_3cac3
	move_player NPCMovement_3cadd, TRUE
	script_jump .ows_3cace
.ows_3cac3
	move_player NPCMovement_3cae8, TRUE
	script_jump .ows_3cace
.ows_3caca
	move_player NPCMovement_3caf7, TRUE
.ows_3cace
	move_npc NPC_AARON, NPCMovement_3cad4
	wait_for_player_animation
	script_ret
NPCMovement_3cad4:
	db WEST, MOVE_2
	db SOUTH, MOVE_4
	db WEST, MOVE_5
	db SOUTH, MOVE_1
	db $ff
NPCMovement_3cadd:
	db SOUTH, MOVE_8
	db WEST, MOVE_1
	db SOUTH, MOVE_1
	db WEST, MOVE_5
	db NORTH, MOVE_1
	db $ff
NPCMovement_3cae8:
	db SOUTH, MOVE_3
	db WEST, MOVE_1
	db SOUTH, MOVE_4
	db WEST, MOVE_1
	db SOUTH, MOVE_1
	db WEST, MOVE_5
	db NORTH, MOVE_1
	db $ff
NPCMovement_3caf7:
	db SOUTH, MOVE_5
	db WEST, MOVE_2
	db SOUTH, MOVE_3
	db WEST, MOVE_1
	db SOUTH, MOVE_1
	db WEST, MOVE_5
	db NORTH, MOVE_1
	db $ff

Script_3cb06:
	get_player_direction
	compare_loaded_var $03
	script_jump_if_b0nz .ows_3cb1f
	compare_loaded_var $00
	script_jump_if_b0nz .ows_3cb18
	move_player NPCMovement_3cb32, TRUE
	script_jump .ows_3cb23
.ows_3cb18
	move_player NPCMovement_3cb39, TRUE
	script_jump .ows_3cb23
.ows_3cb1f
	move_player NPCMovement_3cb40, TRUE
.ows_3cb23
	move_npc NPC_AARON, NPCMovement_3cb29
	wait_for_player_animation
	script_ret
NPCMovement_3cb29:
	db WEST, MOVE_2
	db NORTH, MOVE_1
	db WEST, MOVE_5
	db SOUTH, MOVE_1
	db $ff
NPCMovement_3cb32:
	db SOUTH, MOVE_4
	db WEST, MOVE_6
	db NORTH, MOVE_1
	db $ff
NPCMovement_3cb39:
	db SOUTH, MOVE_3
	db WEST, MOVE_7
	db NORTH, MOVE_1
	db $ff
NPCMovement_3cb40:
	db SOUTH, MOVE_2
	db WEST, MOVE_1
	db SOUTH, MOVE_2
	db WEST, MOVE_7
	db NORTH, MOVE_1
	db $ff

Script_3cb4b:
	get_player_direction
	compare_loaded_var $03
	script_jump_if_b0nz .ows_3cb64
	compare_loaded_var $00
	script_jump_if_b0nz .ows_3cb5d
	move_player NPCMovement_3cb73, TRUE
	script_jump .ows_3cb68
.ows_3cb5d
	move_player NPCMovement_3cb7a, TRUE
	script_jump .ows_3cb68
.ows_3cb64
	move_player NPCMovement_3cb81, TRUE
.ows_3cb68
	move_npc NPC_AARON, NPCMovement_3cb6e
	wait_for_player_animation
	script_ret
NPCMovement_3cb6e:
	db WEST, MOVE_4
	db SOUTH, MOVE_0
	db $ff
NPCMovement_3cb73:
	db SOUTH, MOVE_3
	db WEST, MOVE_3
	db NORTH, MOVE_0
	db $ff
NPCMovement_3cb7a:
	db SOUTH, MOVE_2
	db WEST, MOVE_4
	db NORTH, MOVE_0
	db $ff
NPCMovement_3cb81:
	db SOUTH, MOVE_3
	db WEST, MOVE_5
	db NORTH, MOVE_0
	db $ff

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
	dbw $06, Func_3cbf4
	dbw $02, Func_3cbfb
	dbw $0b, Func_3cc37
	dbw $01, Func_3cbd4
	dbw $10, Func_3cbe4
	db $ff

Func_3cbd4:
	ld a, $08
	farcall GetEventValue
	jr nz, .asm_3cbe1
	ld a, $14
	ld [wNextMusic], a
.asm_3cbe1
	scf
	ccf
	ret

Func_3cbe4:
	call Func_3cc53
	jr nc, .asm_3cbeb
	scf
	ret
.asm_3cbeb
	ld a, $0f
	farcall PlayAfterCurrentSong
	scf
	ccf
	ret

Func_3cbf4:
	ld hl, LightningClubEntrance_StepEvents
	call Func_324d
	ret

Func_3cbfb:
	ld a, $ed
	farcall GetEventValue
	jr nz, .asm_3cc0b
	ld a, $08
	farcall GetEventValue
	jr nz, .asm_3cc35
.asm_3cc0b
	ld bc, $c
	ld de, $100
	farcall Func_12c0ce
	call Func_3cc53
	jr c, .asm_3cc35
	ld hl, $a2b
	call LoadTxRam2
	ld a, $0a
	ld [wd582], a
	ld a, $0d
	ld [wd592], a
	ld hl, $40a4
	ld a, l
	ld [wd593], a
	ld a, h
	ld [$d594], a
.asm_3cc35
	scf
	ret

Func_3cc37:
	ld a, $03
	farcall GetEventValue
	jr z, .asm_3cc51
	ld a, $03
	farcall ClearOWObject
	ld a, $03
	farcall ZeroOutEventValue
	ld a, [wNextMusic]
	ld [wCurMusic], a
.asm_3cc51
	scf
	ret

Func_3cc53:
	ld a, $04
	farcall GetVarValue
	cp $02
	jr c, .asm_3cc5f
	scf
	ret
.asm_3cc5f
	scf
	ccf
	ret

LightningClubLobby_MapHeader:
	db MAP_GFX_LIGHTNING_CLUB_LOBBY
	dba LightningClubLobby_MapScripts
	db MUSIC_OVERWORLD

LightningClubLobby_StepEvents:
	map_exit 15, 6, MAP_LIGHTNING_CLUB_ENTRANCE, 1, 3, EAST
	map_exit 15, 7, MAP_LIGHTNING_CLUB_ENTRANCE, 1, 4, EAST
	db $ff

LightningClubLobby_NPCs:
	npc NPC_JENNIFER, 9, 8, EAST, Func_3cdb1
	npc NPC_BRANDON, 9, 6, EAST, Func_3cdb1
	npc NPC_LIGHTNING_CLUB_LASS, 11, 2, NORTH, $0
	npc NPC_LIGHTNING_CLUB_PUNK_KID, 9, 4, SOUTH, $0
	npc NPC_LIGHTNING_CLUB_LONGHAIRED_LASS, 5, 6, EAST, Func_3ce9b
	npc NPC_LIGHTNING_CLUB_GR_LASS, 5, 6, EAST, Func_3cea8
	npc NPC_LIGHTNING_CLUB_BRO, 8, 9, WEST, $0
	npc NPC_CLERK_BATTLE_CENTER, 2, 2, SOUTH, $0
	npc NPC_CLERK_GIFT_CENTER, 4, 2, SOUTH, $0
	db $ff

LightningClubLobby_NPCInteractions:
	npc_script NPC_JENNIFER, Func_3cd4b
	npc_script NPC_BRANDON, Func_3cd7e
	npc_script NPC_LIGHTNING_CLUB_LASS, Func_3cdc6
	npc_script NPC_LIGHTNING_CLUB_PUNK_KID, Func_3ce39
	npc_script NPC_LIGHTNING_CLUB_LONGHAIRED_LASS, Func_3ce6a
	npc_script NPC_LIGHTNING_CLUB_GR_LASS, Func_3ce6a
	npc_script NPC_LIGHTNING_CLUB_BRO, Func_3ceb5
	db $ff

LightningClubLobby_OWInteractions:
	ow_script 8, 2, PCMenu
	ow_script 9, 2, PCMenu
	ow_script 2, 4, Func_3c1b9
	ow_script 4, 4, Func_3c2d9
	ow_script 12, 2, Func_40294
	ow_script 13, 2, Func_402aa
	ow_script 14, 2, Func_402c0
	db $ff

LightningClubLobby_MapScripts:
	dbw $06, Func_3cd2b
	dbw $08, Func_3cd3b
	dbw $07, Func_3cd32
	dbw $01, Func_3cd1b
	db $ff

Func_3cd1b:
	ld a, $08
	farcall GetEventValue
	jr nz, .asm_3cd28
	ld a, $14
	ld [wNextMusic], a
.asm_3cd28
	scf
	ccf
	ret

Func_3cd2b:
	ld hl, LightningClubLobby_StepEvents
	call Func_324d
	ret

Func_3cd32:
	ld hl, LightningClubLobby_NPCs
	call Func_3205
	scf
	ccf
	ret

Func_3cd3b:
	ld hl, LightningClubLobby_NPCInteractions
	call Func_328c
	jr nc, .asm_3cd49
	ld hl, LightningClubLobby_OWInteractions
	call Func_32bf
.asm_3cd49
	scf
	ret

Func_3cd4b:
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
	check_event EVENT_SET_UNTIL_MAP_RELOAD_1
	script_jump_if_b0z .ows_3cd78
	check_event EVENT_TALKED_TO_JENNIFER
	script_jump_if_b0z .ows_3cd72
	set_event EVENT_TALKED_TO_JENNIFER
	print_npc_text Text0b4f
	script_jump .ows_3cd7b
.ows_3cd72
	print_npc_text Text0b50
	script_jump .ows_3cd7b
.ows_3cd78
	print_npc_text Text0b51
.ows_3cd7b
	script_command_02
	end_script
	ret

Func_3cd7e:
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
	check_event EVENT_SET_UNTIL_MAP_RELOAD_1
	script_jump_if_b0z .ows_3cdab
	check_event EVENT_TALKED_TO_BRANDON
	script_jump_if_b0z .ows_3cda5
	set_event EVENT_TALKED_TO_BRANDON
	print_npc_text Text0b52
	script_jump .ows_3cdae
.ows_3cda5
	print_npc_text Text0b53
	script_jump .ows_3cdae
.ows_3cdab
	print_npc_text Text0b54
.ows_3cdae
	script_command_02
	end_script
	ret

Func_3cdb1:
	ld a, $ed
	farcall GetEventValue
	jr nz, .asm_3cdc3
	ld a, $08
	farcall GetEventValue
	jr z, .asm_3cdc3
	scf
	ret
.asm_3cdc3
	scf
	ccf
	ret

Func_3cdc6:
	ld a, $7f
	ld [wScriptNPC], a
	ld hl, $a36
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	check_event EVENT_TRADED_CARDS_LIGHTNING_CLUB
	script_jump_if_b0z .ows_3ce33
	check_event EVENT_TALKED_TO_TRADE_NPC_LIGHTNING_CLUB
	script_jump_if_b0z .ows_3cded
	set_event EVENT_TALKED_TO_TRADE_NPC_LIGHTNING_CLUB
	print_npc_text Text0b55
	script_jump .ows_3cdf0
.ows_3cded
	print_npc_text Text0b56
.ows_3cdf0
	ask_question TradeCardsPromptText, TRUE
	script_jump_if_b0nz .ows_3cdfd
	print_npc_text Text0b57
	script_jump .ows_3ce36
.ows_3cdfd
	get_card_count_in_collection_and_decks VOLTORB_LV10
	compare_loaded_var $04
	script_jump_if_b1z .ows_3ce0b
	print_npc_text Text0b58
	script_jump .ows_3ce36
.ows_3ce0b
	get_card_count_in_collection VOLTORB_LV10
	compare_loaded_var $04
	script_jump_if_b1z .ows_3ce19
	print_npc_text Text0b59
	script_jump .ows_3ce36
.ows_3ce19
	print_npc_text Text0b5a
	receive_card PIKACHU_ALT_LV16
	take_card VOLTORB_LV10
	take_card VOLTORB_LV10
	take_card VOLTORB_LV10
	take_card VOLTORB_LV10
	set_event EVENT_TRADED_CARDS_LIGHTNING_CLUB
	print_npc_text Text0b5b
	script_jump .ows_3ce36
.ows_3ce33
	print_npc_text Text0b5c
.ows_3ce36
	script_command_02
	end_script
	ret

Func_3ce39:
	ld a, $80
	ld [wScriptNPC], a
	ld hl, $a52
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	check_event EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE
	script_jump_if_b0z .ows_3ce64
	check_event EVENT_FREED_ROD
	script_jump_if_b0z .ows_3ce5e
	print_npc_text Text0b5d
	script_jump .ows_3ce67
.ows_3ce5e
	print_npc_text Text0b5e
	script_jump .ows_3ce67
.ows_3ce64
	print_npc_text Text0b5f
.ows_3ce67
	script_command_02
	end_script
	ret

Func_3ce6a:
	ld a, $81
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
	script_jump_if_b0z .ows_3ce95
	check_event EVENT_GOT_GR_COIN
	script_jump_if_b0z .ows_3ce8f
	print_npc_text Text0b60
	script_jump .ows_3ce98
.ows_3ce8f
	print_npc_text Text0b61
	script_jump .ows_3ce98
.ows_3ce95
	print_npc_text Text0b62
.ows_3ce98
	script_command_02
	end_script
	ret

Func_3ce9b:
	ld a, $01
	farcall GetEventValue
	jr z, .asm_3cea5
	scf
	ret
.asm_3cea5
	scf
	ccf
	ret

Func_3cea8:
	ld a, $01
	farcall GetEventValue
	jr nz, .asm_3ceb2
	scf
	ret
.asm_3ceb2
	scf
	ccf
	ret

Func_3ceb5:
	ld a, $82
	ld [wScriptNPC], a
	ld hl, $a35
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	check_event EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE
	script_jump_if_b0z .ows_3cee0
	check_event EVENT_GOT_GR_COIN
	script_jump_if_b0z .ows_3ceda
	print_npc_text Text0b63
	script_jump .ows_3cee3
.ows_3ceda
	print_npc_text Text0b64
	script_jump .ows_3cee3
.ows_3cee0
	print_npc_text Text0b65
.ows_3cee3
	script_command_02
	end_script
	ret

GrassClubLobby_MapHeader:
	db MAP_GFX_GRASS_CLUB_LOBBY
	dba GrassClubLobby_MapScripts
	db MUSIC_OVERWORLD

GrassClubLobby_StepEvents:
	map_exit 15, 6, MAP_GRASS_CLUB_ENTRANCE, 1, 3, EAST
	map_exit 15, 7, MAP_GRASS_CLUB_ENTRANCE, 1, 4, EAST
	db $ff

GrassClubLobby_NPCs:
	npc NPC_BRITTANY, 7, 9, WEST, Func_3d0ec
	npc NPC_KRISTIN, 6, 6, EAST, Func_3d0ec
	npc NPC_HEATHER, 10, 8, EAST, Func_3d0ec
	npc NPC_GRASS_CLUB_GRANNY, 3, 10, EAST, Func_3d189
	npc NPC_GRASS_CLUB_LASS, 11, 4, SOUTH, Func_3d189
	npc NPC_GRASS_CLUB_CAPPED_LASS, 7, 8, WEST, Func_3d189
	npc NPC_CLERK_BATTLE_CENTER, 2, 2, SOUTH, $0
	npc NPC_CLERK_GIFT_CENTER, 4, 2, SOUTH, $0
	db $ff

GrassClubLobby_NPCInteractions:
	npc_script NPC_BRITTANY, Func_3cfd8
	npc_script NPC_KRISTIN, Func_3d064
	npc_script NPC_HEATHER, Func_3d0a8
	npc_script NPC_GRASS_CLUB_GRANNY, Func_3d101
	npc_script NPC_GRASS_CLUB_LASS, Func_3d127
	npc_script NPC_GRASS_CLUB_CAPPED_LASS, Func_3d158
	db $ff

GrassClubLobby_OWInteractions:
	ow_script 8, 2, PCMenu
	ow_script 9, 2, PCMenu
	ow_script 2, 4, Func_3c1b9
	ow_script 4, 4, Func_3c2d9
	ow_script 12, 2, Func_4018c
	ow_script 13, 2, Func_401a2
	ow_script 14, 2, Func_401b8
	db $ff

GrassClubLobby_MapScripts:
	dbw $06, Func_3cfa8
	dbw $08, Func_3cfb8
	dbw $07, Func_3cfaf
	dbw $09, Func_3cfc8
	dbw $01, Func_3cf98
	db $ff

Func_3cf98:
	ld a, $0d
	farcall GetEventValue
	jr nz, .asm_3cfa5
	ld a, $14
	ld [wNextMusic], a
.asm_3cfa5
	scf
	ccf
	ret

Func_3cfa8:
	ld hl, GrassClubLobby_StepEvents
	call Func_324d
	ret

Func_3cfaf:
	ld hl, GrassClubLobby_NPCs
	call Func_3205
	scf
	ccf
	ret

Func_3cfb8:
	ld hl, GrassClubLobby_NPCInteractions
	call Func_328c
	jr nc, .asm_3cfc6
	ld hl, GrassClubLobby_OWInteractions
	call Func_32bf
.asm_3cfc6
	scf
	ret

Func_3cfc8:
	ld hl, GrassClubLobby_AfterDuelScripts
	ld a, [wScriptNPC]
	call Func_344c
	scf
	ret

GrassClubLobby_AfterDuelScripts:
	npc_script NPC_BRITTANY, Func_3d02b
	db $ff

Func_3cfd8:
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
	check_event EVENT_GOT_ODDISH_COIN
	script_jump_if_b0z .ows_3d010
	check_event EVENT_BEAT_BRITTANY
	script_jump_if_b0z .ows_3d00a
	check_event EVENT_TALKED_TO_BRITTANY
	script_jump_if_b0z .ows_3d004
	set_event EVENT_TALKED_TO_BRITTANY
	print_npc_text Text0e79
	script_jump .ows_3d013
.ows_3d004
	print_npc_text Text0e7a
	script_jump .ows_3d013
.ows_3d00a
	print_npc_text Text0e7b
	script_jump .ows_3d013
.ows_3d010
	print_npc_text Text0e7c
.ows_3d013
	ask_question Text0e7d, TRUE
	script_jump_if_b0z .ows_3d023
	print_npc_text Text0e7e
	script_command_02
	start_duel REMAINING_GREEN_DECK_ID, MUSIC_MATCHSTART_1
	end_script
	ret
.ows_3d023
	print_npc_text Text0e7f
	set_active_npc_direction WEST
	script_command_02
	end_script
	ret

Func_3d02b:
	xor a
	start_script
	script_command_01
	check_event EVENT_SET_UNTIL_MAP_RELOAD_2
	script_jump_if_b0nz .ows_3d05c
	print_npc_text Text0e80
	give_booster_packs BoosterList_cccd
	check_event EVENT_GOT_ODDISH_COIN
	script_jump_if_b0z .ows_3d056
	check_event EVENT_BEAT_BRITTANY
	script_jump_if_b0z .ows_3d050
	set_event EVENT_BEAT_BRITTANY
	set_var VAR_02, $01
	print_npc_text Text0e81
	script_jump .ows_3d05f
.ows_3d050
	print_npc_text Text0e82
	script_jump .ows_3d05f
.ows_3d056
	print_npc_text Text0e83
	script_jump .ows_3d05f
.ows_3d05c
	print_npc_text Text0e84
.ows_3d05f
	set_active_npc_direction WEST
	script_command_02
	end_script
	ret

Func_3d064:
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
	check_event EVENT_SET_UNTIL_MAP_RELOAD_1
	script_jump_if_b0z .ows_3d0a2
	check_event EVENT_GOT_ODDISH_COIN
	script_jump_if_b0z .ows_3d09c
	check_event EVENT_TALKED_TO_KRISTIN
	script_jump_if_b0z .ows_3d096
	set_event EVENT_TALKED_TO_KRISTIN
	print_npc_text Text0e85
	give_booster_packs BoosterList_ccd5
	print_npc_text Text0e86
	script_jump .ows_3d09f
.ows_3d096
	print_npc_text Text0e87
	script_jump .ows_3d09f
.ows_3d09c
	print_npc_text Text0e88
.ows_3d09f
	script_command_02
	end_script
	ret
.ows_3d0a2
	print_npc_text Text0e89
	script_command_02
	end_script
	ret

Func_3d0a8:
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
	check_event EVENT_SET_UNTIL_MAP_RELOAD_1
	script_jump_if_b0z .ows_3d0e6
	check_event EVENT_GOT_ODDISH_COIN
	script_jump_if_b0z .ows_3d0e0
	check_event EVENT_TALKED_TO_HEATHER
	script_jump_if_b0z .ows_3d0da
	set_event EVENT_TALKED_TO_HEATHER
	print_npc_text Text0e8a
	give_booster_packs BoosterList_ccd8
	print_npc_text Text0e8b
	script_jump .ows_3d0e3
.ows_3d0da
	print_npc_text Text0e8c
	script_jump .ows_3d0e3
.ows_3d0e0
	print_npc_text Text0e8d
.ows_3d0e3
	script_command_02
	end_script
	ret
.ows_3d0e6
	print_npc_text Text0e8e
	script_command_02
	end_script
	ret

Func_3d0ec:
	ld a, $ed
	farcall GetEventValue
	jr nz, .asm_3d0fe
	ld a, $0d
	farcall GetEventValue
	jr z, .asm_3d0fe
	scf
	ret
.asm_3d0fe
	scf
	ccf
	ret

Func_3d101:
	ld a, $72
	ld [wScriptNPC], a
	ld hl, $a3f
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	check_event EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE
	script_jump_if_b0z .ows_3d121
	print_npc_text Text0e8f
	script_jump .ows_3d124
.ows_3d121
	print_npc_text Text0e90
.ows_3d124
	script_command_02
	end_script
	ret

Func_3d127:
	ld a, $73
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
	script_jump_if_b0z .ows_3d152
	check_event EVENT_GOT_GR_COIN
	script_jump_if_b0z .ows_3d14c
	print_npc_text Text0e91
	script_jump .ows_3d155
.ows_3d14c
	print_npc_text Text0e92
	script_jump .ows_3d155
.ows_3d152
	print_npc_text Text0e93
.ows_3d155
	script_command_02
	end_script
	ret

Func_3d158:
	ld a, $74
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
	script_jump_if_b0z .ows_3d183
	check_event EVENT_GOT_GR_COIN
	script_jump_if_b0z .ows_3d17d
	print_npc_text Text0e94
	script_jump .ows_3d186
.ows_3d17d
	print_npc_text Text0e95
	script_jump .ows_3d186
.ows_3d183
	print_npc_text Text0e96
.ows_3d186
	script_command_02
	end_script
	ret

Func_3d189:
	ld a, $ed
	farcall GetEventValue
	jr nz, .asm_3d19c
	ld a, $0d
	farcall GetEventValue
	jr z, .asm_3d19c
	scf
	ccf
	ret
.asm_3d19c
	scf
	ret

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
	npc NPC_CLERK_TCG_CHALLENGE_HALL_ENTRANCE, 3, 1, SOUTH, $0
	db $ff

TcgChallengeHallEntrance_NPCInteractions:
	npc_script NPC_CLERK_TCG_CHALLENGE_HALL_ENTRANCE, Func_3d271
	db $ff

TcgChallengeHallEntrance_MapScripts:
	dbw $06, Func_3d259
	dbw $08, Func_3d269
	dbw $07, Func_3d260
	dbw $01, Func_3d1f6
	dbw $04, Func_3d210
	db $ff

Func_3d1f6:
	ld a, $28
	farcall GetVarValue
	cp $01
	jr z, .asm_3d208
	cp $03
	jr z, .asm_3d208
	cp $06
	jr nz, .asm_3d20d
.asm_3d208
	ld a, $0b
	ld [wNextMusic], a
.asm_3d20d
	scf
	ccf
	ret

Func_3d210:
	ld a, [wd585]
	cp $00
	jr nz, .asm_3d257
	ld a, $28
	farcall GetVarValue
	cp $01
	jr z, .asm_3d229
	cp $03
	jr z, .asm_3d229
	cp $06
	jr nz, .asm_3d257
.asm_3d229
	ld a, $2b
	farcall GetVarValue
	cp $01
	push af
	ld a, $2b
	farcall ZeroOutVarValue
	pop af
	jr nz, .asm_3d257
	ld a, $28
	farcall GetVarValue
	cp $06
	jr z, .asm_3d24f
	inc a
	ld c, a
	ld a, $28
	farcall SetVarValue
	jr .asm_3d257
.asm_3d24f
	ld a, $28
	ld c, $05
	farcall SetVarValue
.asm_3d257
	scf
	ret

Func_3d259:
	ld hl, TcgChallengeHallEntrance_StepEvents
	call Func_324d
	ret

Func_3d260:
	ld hl, TcgChallengeHallEntrance_NPCs
	call Func_3205
	scf
	ccf
	ret

Func_3d269:
	ld hl, TcgChallengeHallEntrance_NPCInteractions
	call Func_328c
	scf
	ret

Func_3d271:
	ld a, $8a
	ld [wScriptNPC], a
	ld hl, $a5a
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	get_var VAR_2B
	compare_loaded_var $00
	script_jump_if_b0z .ows_3d2d1
	get_var VAR_28
	compare_loaded_var $05
	script_jump_if_b0nz .ows_3d2c5
	script_jump_if_b1z .ows_3d2cb
	compare_loaded_var $03
	script_jump_if_b0nz .ows_3d2b9
	script_jump_if_b1z .ows_3d2bf
	compare_loaded_var $01
	script_jump_if_b0nz .ows_3d2ad
	script_jump_if_b1z .ows_3d2b3
	print_npc_text Text098a
	script_jump .ows_3d2d4
.ows_3d2ad
	print_npc_text Text098b
	script_jump .ows_3d2d4
.ows_3d2b3
	print_npc_text Text098c
	script_jump .ows_3d2d4
.ows_3d2b9
	print_npc_text Text098d
	script_jump .ows_3d2d4
.ows_3d2bf
	print_npc_text Text098e
	script_jump .ows_3d2d4
.ows_3d2c5
	print_npc_text Text098f
	script_jump .ows_3d2d4
.ows_3d2cb
	print_npc_text Text0990
	script_jump .ows_3d2d4
.ows_3d2d1
	print_npc_text Text0991
.ows_3d2d4
	script_command_02
	end_script
	ret

TcgChallengeHallLobby_MapHeader:
	db MAP_GFX_TCG_CHALLENGE_HALL_LOBBY
	dba TcgChallengeHallLobby_MapScripts
	db MUSIC_OVERWORLD

TcgChallengeHallLobby_StepEvents:
	map_exit 15, 6, MAP_TCG_CHALLENGE_HALL_ENTRANCE, 1, 3, EAST
	map_exit 15, 7, MAP_TCG_CHALLENGE_HALL_ENTRANCE, 1, 4, EAST
	db $ff

TcgChallengeHallLobby_NPCs:
	npc NPC_TCG_CHALLENGE_HALL_CHAP, 10, 4, SOUTH, $0
	npc NPC_CUP_HOST, 7, 9, EAST, Func_3d5a3
	npc NPC_TCG_CHALLENGE_HALL_PUNK, 5, 6, EAST, Func_3d5a3
	npc NPC_TCG_CHALLENGE_HALL_PAPPY, 4, 9, EAST, Func_3d5ba
	npc NPC_TCG_CHALLENGE_HALL_TECH, 9, 10, NORTH, Func_3d5ba
	npc NPC_TCG_CHALLENGE_HALL_GIRL, 13, 9, WEST, Func_3d5ba
	npc NPC_CLERK_BATTLE_CENTER, 2, 2, SOUTH, $0
	npc NPC_CLERK_GIFT_CENTER, 4, 2, SOUTH, $0
	db $ff

TcgChallengeHallLobby_NPCInteractions:
	npc_script NPC_TCG_CHALLENGE_HALL_CHAP, Func_3d3c0
	npc_script NPC_CUP_HOST, Func_3d4e9
	npc_script NPC_TCG_CHALLENGE_HALL_PUNK, Func_3d511
	npc_script NPC_TCG_CHALLENGE_HALL_PAPPY, Func_3d539
	npc_script NPC_TCG_CHALLENGE_HALL_TECH, Func_3d56d
	npc_script NPC_TCG_CHALLENGE_HALL_GIRL, Func_3d588
	db $ff

TcgChallengeHallLobby_OWInteractions:
	ow_script 8, 2, PCMenu
	ow_script 9, 2, PCMenu
	ow_script 2, 4, Func_3c1b9
	ow_script 4, 4, Func_3c2d9
	ow_script 12, 2, Func_40318
	ow_script 13, 2, Func_4032e
	ow_script 14, 2, Func_40344
	db $ff

TcgChallengeHallLobby_MapScripts:
	dbw $06, Func_3d3a0
	dbw $08, Func_3d3b0
	dbw $07, Func_3d3a7
	dbw $01, Func_3d386
	db $ff

Func_3d386:
	ld a, $28
	farcall GetVarValue
	cp $01
	jr z, .asm_3d398
	cp $03
	jr z, .asm_3d398
	cp $06
	jr nz, .asm_3d39d
.asm_3d398
	ld a, $0b
	ld [wNextMusic], a
.asm_3d39d
	scf
	ccf
	ret

Func_3d3a0:
	ld hl, TcgChallengeHallLobby_StepEvents
	call Func_324d
	ret

Func_3d3a7:
	ld hl, TcgChallengeHallLobby_NPCs
	call Func_3205
	scf
	ccf
	ret

Func_3d3b0:
	ld hl, TcgChallengeHallLobby_NPCInteractions
	call Func_328c
	jr nc, .asm_3d3be
	ld hl, TcgChallengeHallLobby_OWInteractions
	call Func_32bf
.asm_3d3be
	scf
	ret

Func_3d3c0:
	ld a, $8b
	ld [wScriptNPC], a
	ld hl, $a33
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	check_event EVENT_TRADED_CARDS_TCG_CHALLENGE_HALL
	script_jump_if_b0nz .ows_3d3ee
	check_event EVENT_B1
	script_jump_if_b0nz .ows_3d43b
	check_event EVENT_B2
	script_jump_if_b0nz .ows_3d493
	check_event EVENT_SET_UNTIL_MAP_RELOAD_1
	print_variable_npc_text Text0992, Text0993
	script_command_02
	end_script
	ret
.ows_3d3ee
	check_event EVENT_TALKED_TO_TRADE_NPC_TCG_CHALLENGE_HALL
	script_jump_if_b0z .ows_3d3fb
	set_event EVENT_TALKED_TO_TRADE_NPC_TCG_CHALLENGE_HALL
	print_npc_text Text0994
	script_jump .ows_3d3fe
.ows_3d3fb
	print_npc_text Text0995
.ows_3d3fe
	ask_question TradeCardsPromptText, TRUE
	script_jump_if_b0nz .ows_3d40b
	print_npc_text Text0996
	script_jump .ows_3d438
.ows_3d40b
	get_card_count_in_collection_and_decks GRAVELER_LV29
	script_jump_if_b0z .ows_3d417
	print_npc_text Text0997
	script_jump .ows_3d438
.ows_3d417
	get_card_count_in_collection GRAVELER_LV29
	script_jump_if_b0z .ows_3d423
	print_npc_text Text0998
	script_jump .ows_3d438
.ows_3d423
	print_npc_text Text0999
	receive_card WIGGLYTUFF_LV36
	take_card GRAVELER_LV29
	give_card WIGGLYTUFF_LV36
	set_event EVENT_TRADED_CARDS_TCG_CHALLENGE_HALL
	set_event EVENT_F3
	reset_event EVENT_TALKED_TO_TRADE_NPC_TCG_CHALLENGE_HALL
	print_npc_text Text099a
.ows_3d438
	script_command_02
	end_script
	ret
.ows_3d43b
	check_event EVENT_F3
	script_jump_if_b0z .ows_3d48d
	check_event EVENT_TALKED_TO_TRADE_NPC_TCG_CHALLENGE_HALL
	script_jump_if_b0z .ows_3d44d
	set_event EVENT_TALKED_TO_TRADE_NPC_TCG_CHALLENGE_HALL
	print_npc_text Text099b
	script_jump .ows_3d450
.ows_3d44d
	print_npc_text Text099c
.ows_3d450
	ask_question TradeCardsPromptText, TRUE
	script_jump_if_b0nz .ows_3d45d
	print_npc_text Text099d
	script_jump .ows_3d490
.ows_3d45d
	get_card_count_in_collection_and_decks OMANYTE_LV19
	script_jump_if_b0z .ows_3d469
	print_npc_text Text099e
	script_jump .ows_3d490
.ows_3d469
	get_card_count_in_collection OMANYTE_LV19
	script_jump_if_b0z .ows_3d475
	print_npc_text Text099f
	script_jump .ows_3d490
.ows_3d475
	print_npc_text Text09a0
	receive_card LAPRAS_LV31
	take_card OMANYTE_LV19
	give_card LAPRAS_LV31
	set_event EVENT_B1
	set_event EVENT_F3
	reset_event EVENT_TALKED_TO_TRADE_NPC_TCG_CHALLENGE_HALL
	print_npc_text Text09a1
	script_jump .ows_3d490
.ows_3d48d
	print_npc_text Text09a2
.ows_3d490
	script_command_02
	end_script
	ret
.ows_3d493
	check_event EVENT_F3
	script_jump_if_b0z .ows_3d4e3
	check_event EVENT_TALKED_TO_TRADE_NPC_TCG_CHALLENGE_HALL
	script_jump_if_b0z .ows_3d4a5
	set_event EVENT_TALKED_TO_TRADE_NPC_TCG_CHALLENGE_HALL
	print_npc_text Text09a3
	script_jump .ows_3d4a8
.ows_3d4a5
	print_npc_text Text09a4
.ows_3d4a8
	ask_question TradeCardsPromptText, TRUE
	script_jump_if_b0nz .ows_3d4b5
	print_npc_text Text09a5
	script_jump .ows_3d4e6
.ows_3d4b5
	get_card_count_in_collection_and_decks HAUNTER_LV17
	script_jump_if_b0z .ows_3d4c1
	print_npc_text Text09a6
	script_jump .ows_3d4e6
.ows_3d4c1
	get_card_count_in_collection HAUNTER_LV17
	script_jump_if_b0z .ows_3d4cd
	print_npc_text Text09a7
	script_jump .ows_3d4e6
.ows_3d4cd
	print_npc_text Text09a8
	receive_card BILLS_COMPUTER
	take_card HAUNTER_LV17
	give_card BILLS_COMPUTER
	set_event EVENT_B2
	set_event EVENT_SET_UNTIL_MAP_RELOAD_1
	print_npc_text Text09a9
	script_jump .ows_3d4e6
.ows_3d4e3
	print_npc_text Text09aa
.ows_3d4e6
	script_command_02
	end_script
	ret

Func_3d4e9:
	ld a, $8c
	ld [wScriptNPC], a
	ld hl, $a5b
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	get_var VAR_28
	compare_loaded_var $00
	script_jump_if_b0z .ows_3d50b
	print_npc_text Text09ab
	script_jump .ows_3d50e
.ows_3d50b
	print_npc_text Text09ac
.ows_3d50e
	script_command_02
	end_script
	ret

Func_3d511:
	ld a, $8d
	ld [wScriptNPC], a
	ld hl, $a57
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	get_var VAR_28
	compare_loaded_var $00
	script_jump_if_b0z .ows_3d533
	print_npc_text Text09ad
	script_jump .ows_3d536
.ows_3d533
	print_npc_text Text09ae
.ows_3d536
	script_command_02
	end_script
	ret

Func_3d539:
	ld a, $8f
	ld [wScriptNPC], a
	ld hl, $a3c
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	get_var VAR_2B
	compare_loaded_var $02
	script_jump_if_b0nz .ows_3d561
	get_var VAR_28
	compare_loaded_var $06
	print_variable_npc_text Text09af, Text09b0
	script_jump .ows_3d56a
.ows_3d561
	get_var VAR_28
	compare_loaded_var $06
	print_variable_npc_text Text09b1, Text09b2
.ows_3d56a
	script_command_02
	end_script
	ret

Func_3d56d:
	ld a, $90
	ld [wScriptNPC], a
	ld hl, $a4a
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	print_npc_text Text09b3
	script_command_02
	end_script
	ret

Func_3d588:
	ld a, $91
	ld [wScriptNPC], a
	ld hl, $a4c
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	print_npc_text Text09b4
	script_command_02
	end_script
	ret

Func_3d5a3:
	ld a, $28
	farcall GetVarValue
	cp $01
	jr z, .asm_3d5b8
	cp $03
	jr z, .asm_3d5b8
	cp $06
	jr z, .asm_3d5b8
	scf
	ccf
	ret
.asm_3d5b8
	scf
	ret

Func_3d5ba:
	ld a, $28
	farcall GetVarValue
	cp $01
	jr z, .asm_3d5ce
	cp $03
	jr z, .asm_3d5ce
	cp $06
	jr z, .asm_3d5ce
	scf
	ret
.asm_3d5ce
	scf
	ccf
	ret

PokemonDome_MapHeader:
	db MAP_GFX_POKEMON_DOME
	dba PokemonDome_MapScripts
	db MUSIC_OVERWORLD

PokemonDome_StepEvents:
	map_exit 7, 15, MAP_POKEMON_DOME_ENTRANCE, 11, 1, SOUTH
	map_exit 8, 15, MAP_POKEMON_DOME_ENTRANCE, 12, 1, SOUTH
	db $ff

PokemonDome_NPCs:
	npc NPC_COURTNEY, 3, 6, EAST, Func_3d7e2
	npc NPC_STEVE, 9, 6, EAST, Func_3d889
	npc NPC_JACK, 12, 6, WEST, Func_3d92c
	npc NPC_ROD, 6, 6, SOUTH, Func_3d9b1
	npc NPC_GR_5, 7, 8, SOUTH, Func_3d9fc
	npc NPC_TCG_CUP_CLERK_LEFT, 7, 4, SOUTH, Func_3daf0
	npc NPC_TCG_CUP_CLERK_RIGHT, 8, 4, SOUTH, Func_3daf0
	npc NPC_POKEMON_DOME_GR_LASS, 4, 12, EAST, Func_3daf0
	npc NPC_POKEMON_DOME_YOUNGSTER, 9, 8, SOUTH, Func_3daf0
	npc NPC_POKEMON_DOME_SWIMMER, 2, 5, EAST, Func_3daf0
	db $ff

PokemonDome_NPCInteractions:
	npc_script NPC_COURTNEY, Func_3d768
	npc_script NPC_STEVE, Func_3d805
	npc_script NPC_JACK, Func_3d8ac
	npc_script NPC_ROD, Func_3d94f
	npc_script NPC_GR_5, Func_3d9d4
	npc_script NPC_TCG_CUP_CLERK_LEFT, Func_3da09
	npc_script NPC_TCG_CUP_CLERK_RIGHT, Func_3da09
	npc_script NPC_POKEMON_DOME_GR_LASS, Func_3da6c
	npc_script NPC_POKEMON_DOME_YOUNGSTER, Func_3da97
	npc_script NPC_POKEMON_DOME_SWIMMER, Func_3dabf
	db $ff

PokemonDome_OWInteractions:
	ow_script 7, 1, Func_3db13
	ow_script 8, 1, Func_3db13
	db $ff

PokemonDome_MapScripts:
	dbw $06, Func_3d6ba
	dbw $08, Func_3d740
	dbw $09, Func_3d750
	dbw $07, Func_3d6c1
	dbw $02, Func_3d6ca
	dbw $04, Func_3d719
	dbw $0f, Func_3d734
	dbw $01, Func_3d67b
	db $ff

Func_3d67b:
	ld a, $01
	farcall GetEventValue
	jr nz, .asm_3d6a1
	ld a, $c2
	farcall GetEventValue
	jr nz, .asm_3d69a
	ld a, $0b
	farcall GetEventValue
	jr nz, .asm_3d6b7
	ld a, $14
	ld [wNextMusic], a
	jr .asm_3d6b7
.asm_3d69a
	ld a, $0a
	ld [wNextMusic], a
	jr .asm_3d6b7
.asm_3d6a1
	ld a, $0d
	farcall GetVarValue
	cp $02
	jr c, .asm_3d6b7
	cp $04
	jr c, .asm_3d69a
	ld a, $ed
	farcall GetEventValue
	jr nz, .asm_3d69a
.asm_3d6b7
	scf
	ccf
	ret

Func_3d6ba:
	ld hl, PokemonDome_StepEvents
	call Func_324d
	ret

Func_3d6c1:
	ld hl, PokemonDome_NPCs
	call Func_3205
	scf
	ccf
	ret

Func_3d6ca:
	ld bc, $37
	ld de, $700
	farcall Func_12c0ce
	ld a, [wd584]
	cp $25
	jr z, .asm_3d6dd
	scf
	ret
.asm_3d6dd
	ld a, $01
	farcall GetEventValue
	jr nz, .asm_3d6fc
	ld a, $0a
	ld [wd582], a
	ld a, $0f
	ld [wd592], a
	ld hl, $5c4a
	ld a, l
	ld [wd593], a
	ld a, h
	ld [$d594], a
	jr .asm_3d711
.asm_3d6fc
	ld a, $0a
	ld [wd582], a
	ld a, $0f
	ld [wd592], a
	ld hl, $5c8e
	ld a, l
	ld [wd593], a
	ld a, h
	ld [$d594], a
.asm_3d711
	ld a, $00
	call Func_338f
	scf
	ccf
	ret

Func_3d719:
	ld a, [wd585]
	cp $25
	jr z, .asm_3d722
	scf
	ret
.asm_3d722
	ld a, $01
	farcall GetEventValue
	jr nz, .asm_3d72c
	scf
	ret
.asm_3d72c
	ld a, $00
	call Func_33a3
	scf
	ccf
	ret

Func_3d734:
	ld a, [wd585]
	cp $25
	jr z, .asm_3d73d
	scf
	ret
.asm_3d73d
	scf
	ccf
	ret

Func_3d740:
	ld hl, PokemonDome_NPCInteractions
	call Func_328c
	jr nc, .asm_3d74e
	ld hl, PokemonDome_OWInteractions
	call Func_32bf
.asm_3d74e
	scf
	ret

Func_3d750:
	ld hl, PokemonDome_AfterDuelScripts
	ld a, [wScriptNPC]
	call Func_344c
	scf
	ret

PokemonDome_AfterDuelScripts:
	npc_script NPC_COURTNEY, Func_3d7c6
	npc_script NPC_STEVE, Func_3d86d
	npc_script NPC_JACK, Func_3d910
	db $ff

Func_3d768:
	ld a, $2a
	ld [wScriptNPC], a
	ld hl, $9f5
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	check_event EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE
	script_jump_if_b0z .ows_3d7b3
	check_event EVENT_FREED_ROD
	script_jump_if_b0z .ows_3d7ad
	check_event EVENT_BB
	script_jump_if_b0z .ows_3d794
	set_event EVENT_BB
	print_npc_text Text0fe8
	script_jump .ows_3d797
.ows_3d794
	print_npc_text Text0fe9
.ows_3d797
	ask_question Text0fea, TRUE
	script_jump_if_b0z .ows_3d7a7
	print_npc_text Text0feb
	script_command_02
	start_duel GRAND_FIRE_DECK_ID, MUSIC_MATCHSTART_3
	end_script
	ret
.ows_3d7a7
	print_npc_text Text0fec
	script_command_02
	end_script
	ret
.ows_3d7ad
	print_npc_text Text0fed
	script_command_02
	end_script
	ret
.ows_3d7b3
	check_event EVENT_BB
	script_jump_if_b0z .ows_3d7c0
	set_event EVENT_BB
	print_npc_text Text0fee
	script_jump .ows_3d7c3
.ows_3d7c0
	print_npc_text Text0fef
.ows_3d7c3
	script_command_02
	end_script
	ret

Func_3d7c6:
	xor a
	start_script
	script_command_01
	check_event EVENT_SET_UNTIL_MAP_RELOAD_2
	script_jump_if_b0nz .ows_3d7dc
	print_npc_text Text0ff0
	give_booster_packs BoosterList_cdc1
	print_npc_text Text0ff1
	script_jump .ows_3d7df
.ows_3d7dc
	print_npc_text Text0ff2
.ows_3d7df
	script_command_02
	end_script
	ret

Func_3d7e2:
	ld a, $bf
	farcall GetEventValue
	jr z, .asm_3d803
	ld a, $ed
	farcall GetEventValue
	jr nz, .asm_3d803
	ld a, $0d
	farcall GetVarValue
	cp $02
	jr z, .asm_3d803
	cp $03
	jr z, .asm_3d803
	scf
	ccf
	ret
.asm_3d803
	scf
	ret

Func_3d805:
	ld a, $2b
	ld [wScriptNPC], a
	ld hl, $9f4
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	check_event EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE
	script_jump_if_b0z .ows_3d854
	check_event EVENT_FREED_ROD
	script_jump_if_b0z .ows_3d84a
	check_event EVENT_BC
	script_jump_if_b0z .ows_3d831
	set_event EVENT_BC
	print_npc_text Text0ff3
	script_jump .ows_3d834
.ows_3d831
	print_npc_text Text0ff4
.ows_3d834
	ask_question Text0ff5, TRUE
	script_jump_if_b0z .ows_3d844
	print_npc_text Text0ff6
	script_command_02
	start_duel LEGENDARY_FOSSIL_DECK_ID, MUSIC_MATCHSTART_3
	end_script
	ret
.ows_3d844
	print_npc_text Text0ff7
	script_command_02
	end_script
	ret
.ows_3d84a
	check_event EVENT_BEAT_GRAND_MASTER_CUP
	print_variable_npc_text Text0ff8, Text0ff9
	script_command_02
	end_script
	ret
.ows_3d854
	check_event EVENT_BC
	script_jump_if_b0z .ows_3d861
	set_event EVENT_BC
	print_npc_text Text0ffa
	script_jump .ows_3d86a
.ows_3d861
	get_var VAR_0D
	compare_loaded_var $00
	print_variable_npc_text Text0ffb, Text0ffc
.ows_3d86a
	script_command_02
	end_script
	ret

Func_3d86d:
	xor a
	start_script
	script_command_01
	check_event EVENT_SET_UNTIL_MAP_RELOAD_2
	script_jump_if_b0nz .ows_3d883
	print_npc_text Text0ffd
	give_booster_packs BoosterList_cdc6
	print_npc_text Text0ffe
	script_jump .ows_3d886
.ows_3d883
	print_npc_text Text0fff
.ows_3d886
	script_command_02
	end_script
	ret

Func_3d889:
	ld a, $c0
	farcall GetEventValue
	jr z, .asm_3d8aa
	ld a, $ed
	farcall GetEventValue
	jr nz, .asm_3d8aa
	ld a, $0d
	farcall GetVarValue
	cp $02
	jr z, .asm_3d8aa
	cp $03
	jr z, .asm_3d8aa
	scf
	ccf
	ret
.asm_3d8aa
	scf
	ret

Func_3d8ac:
	ld a, $2c
	ld [wScriptNPC], a
	ld hl, $9f6
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	check_event EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE
	script_jump_if_b0z .ows_3d8f7
	check_event EVENT_FREED_ROD
	script_jump_if_b0z .ows_3d8f1
	check_event EVENT_BD
	script_jump_if_b0z .ows_3d8d8
	set_event EVENT_BD
	print_npc_text Text1000
	script_jump .ows_3d8db
.ows_3d8d8
	print_npc_text Text1001
.ows_3d8db
	ask_question Text1002, TRUE
	script_jump_if_b0z .ows_3d8eb
	print_npc_text Text1003
	script_command_02
	start_duel WATER_LEGEND_DECK_ID, MUSIC_MATCHSTART_3
	end_script
	ret
.ows_3d8eb
	print_npc_text Text1004
	script_command_02
	end_script
	ret
.ows_3d8f1
	print_npc_text Text1005
	script_command_02
	end_script
	ret
.ows_3d8f7
	check_event EVENT_BD
	script_jump_if_b0z .ows_3d904
	set_event EVENT_BD
	print_npc_text Text1006
	script_jump .ows_3d90d
.ows_3d904
	get_var VAR_0D
	compare_loaded_var $00
	print_variable_npc_text Text1007, Text1008
.ows_3d90d
	script_command_02
	end_script
	ret

Func_3d910:
	xor a
	start_script
	script_command_01
	check_event EVENT_SET_UNTIL_MAP_RELOAD_2
	script_jump_if_b0nz .ows_3d926
	print_npc_text Text1009
	give_booster_packs BoosterList_cdca
	print_npc_text Text100a
	script_jump .ows_3d929
.ows_3d926
	print_npc_text Text100b
.ows_3d929
	script_command_02
	end_script
	ret

Func_3d92c:
	ld a, $c1
	farcall GetEventValue
	jr z, .asm_3d94d
	ld a, $ed
	farcall GetEventValue
	jr nz, .asm_3d94d
	ld a, $0d
	farcall GetVarValue
	cp $02
	jr z, .asm_3d94d
	cp $03
	jr z, .asm_3d94d
	scf
	ccf
	ret
.asm_3d94d
	scf
	ret

Func_3d94f:
	ld a, $2d
	ld [wScriptNPC], a
	ld hl, $9f7
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	check_event EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE
	script_jump_if_b0z .ows_3d998
	check_event EVENT_BEAT_GRAND_MASTER_CUP
	script_jump_if_b0z .ows_3d981
	check_event EVENT_ENTERED_GRAND_MASTER_CUP
	script_jump_if_b0z .ows_3d97b
	set_event EVENT_ENTERED_GRAND_MASTER_CUP
	print_npc_text Text100c
	script_jump .ows_3d984
.ows_3d97b
	print_npc_text Text100d
	script_jump .ows_3d984
.ows_3d981
	print_npc_text Text100e
.ows_3d984
	ask_question Text100f, TRUE
	script_jump_if_b0z .ows_3d992
	print_npc_text Text1010
	script_command_02
	script_jump Script_3db41
.ows_3d992
	print_npc_text Text1011
	script_command_02
	end_script
	ret
.ows_3d998
	check_event EVENT_ENTERED_GRAND_MASTER_CUP
	script_jump_if_b0z .ows_3d9a5
	set_event EVENT_ENTERED_GRAND_MASTER_CUP
	print_npc_text Text1012
	script_jump .ows_3d9ae
.ows_3d9a5
	get_var VAR_0D
	compare_loaded_var $00
	print_variable_npc_text Text1013, Text1014
.ows_3d9ae
	script_command_02
	end_script
	ret

Func_3d9b1:
	ld a, $c2
	farcall GetEventValue
	jr z, .asm_3d9d2
	ld a, $ed
	farcall GetEventValue
	jr nz, .asm_3d9d2
	ld a, $0d
	farcall GetVarValue
	cp $02
	jr z, .asm_3d9d2
	cp $03
	jr z, .asm_3d9d2
	scf
	ccf
	ret
.asm_3d9d2
	scf
	ret

Func_3d9d4:
	ld a, $32
	ld [wScriptNPC], a
	ld hl, $a2c
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	check_event EVENT_TALKED_TO_GR5_POKEMON_DOME
	script_jump_if_b0z .ows_3d9f6
	set_event EVENT_TALKED_TO_GR5_POKEMON_DOME
	print_npc_text Text1015
	script_jump .ows_3d9f9
.ows_3d9f6
	print_npc_text Text1016
.ows_3d9f9
	script_command_02
	end_script
	ret

Func_3d9fc:
	ld a, $0b
	farcall GetEventValue
	jr z, .asm_3da06
	scf
	ret
.asm_3da06
	scf
	ccf
	ret

Func_3da09:
	ld a, $92
	ld [wScriptNPC], a
	ld hl, $a5a
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	get_var VAR_0D
	compare_loaded_var $05
	script_jump_if_b1z .ows_3da48
	compare_loaded_var $02
	script_jump_if_b0z .ows_3da31
	set_var VAR_0D, $03
	script_call Script_3dcbb
.ows_3da31
	print_npc_text Text1017
	script_call Script_3dd1d
	print_npc_text Text1018
	script_call Script_3dd3a
	print_npc_text Text1018
	print_npc_text Text1019
	script_jump .ows_3da52
.ows_3da48
	compare_loaded_var $06
	print_variable_npc_text Text101a, Text101b
	script_jump .ows_3da69
.ows_3da52
	ask_question Text101c, TRUE
	script_jump_if_b0z .ows_3da66
	set_var VAR_0D, $04
	set_var VAR_20, $00
	print_npc_text Text101d
	script_command_02
	script_jump Script_3dbde
.ows_3da66
	print_npc_text Text101e
.ows_3da69
	script_command_02
	end_script
	ret

Func_3da6c:
	ld a, $d5
	ld [wScriptNPC], a
	ld hl, $a45
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	print_npc_text Text101f
	get_var VAR_0D
	compare_loaded_var $05
	script_jump_if_b1z .ows_3da91
	print_npc_text Text1020
	script_jump .ows_3da94
.ows_3da91
	print_npc_text Text1021
.ows_3da94
	script_command_02
	end_script
	ret

Func_3da97:
	ld a, $d6
	ld [wScriptNPC], a
	ld hl, $a30
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	get_var VAR_0D
	compare_loaded_var $05
	script_jump_if_b1z .ows_3dab9
	print_npc_text Text1022
	script_jump .ows_3dabc
.ows_3dab9
	print_npc_text Text1023
.ows_3dabc
	script_command_02
	end_script
	ret

Func_3dabf:
	ld a, $d7
	ld [wScriptNPC], a
	ld hl, $a4d
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	get_var VAR_0D
	compare_loaded_var $05
	script_jump_if_b0nz .ows_3dae4
	script_jump_if_b1z .ows_3daea
	print_npc_text Text1024
	script_jump .ows_3daed
.ows_3dae4
	print_npc_text Text1025
	script_jump .ows_3daed
.ows_3daea
	print_npc_text Text1026
.ows_3daed
	script_command_02
	end_script
	ret

Func_3daf0:
	ld a, $01
	farcall GetEventValue
	jr z, .asm_3db11
	ld a, $0d
	farcall GetVarValue
	cp $02
	jr c, .asm_3db11
	cp $04
	jr c, .asm_3db0e
	ld a, $ed
	farcall GetEventValue
	jr z, .asm_3db11
.asm_3db0e
	scf
	ccf
	ret
.asm_3db11
	scf
	ret

Func_3db13:
	xor a
	start_script
	check_event EVENT_GOT_GR_COIN
	script_jump_if_b0z .ows_3db30
	set_active_npc NPC_GR_5, DialogGR5Text
	move_active_npc NPCMovement_3db3b
	wait_for_player_animation
	script_command_01
	print_npc_text Text1027
	script_command_02
	move_active_npc NPCMovement_3db3e
	wait_for_player_animation
	end_script
	jr .asm_3db36
.ows_3db30
	script_command_01
	print_text DoorsAreShutText
	script_command_02
	end_script
.asm_3db36
	farcall Func_c199
	ret
NPCMovement_3db3b:
	db NORTH, MOVE_4
	db $ff
NPCMovement_3db3e:
	db SOUTH, MOVE_4
	db $ff

Script_3db41:
	get_player_direction
	compare_loaded_var $00
	script_jump_if_b0nz .ows_3db5a
	compare_loaded_var $03
	script_jump_if_b0nz .ows_3db53
	move_player NPCMovement_3dbac, TRUE
	script_jump .ows_3db5e

.ows_3db53
	move_player NPCMovement_3dbb1, TRUE
	script_jump .ows_3db5e

.ows_3db5a
	move_player NPCMovement_3dbb4, TRUE
.ows_3db5e
	wait_for_player_animation
	scroll_to_position $ff, $00
	move_npc NPC_ROD, NPCMovement_3dbbc
	move_npc NPC_STEVE, NPCMovement_3dbc3
	wait_for_player_animation
	do_frames 30
	play_sfx SFX_0F
	load_tilemap TILEMAP_038, $07, $00
	do_frames 30
	move_npc NPC_ROD, NPCMovement_3dbca
	move_npc NPC_STEVE, NPCMovement_3dbca
	move_npc NPC_COURTNEY, NPCMovement_3dbcd
	move_npc NPC_JACK, NPCMovement_3dbd4
	wait_for_player_animation
	move_npc NPC_COURTNEY, NPCMovement_3dbdb
	move_npc NPC_JACK, NPCMovement_3dbdb
	move_player NPCMovement_3dbb9, TRUE
	wait_for_player_animation
	do_frames 60
	play_sfx SFX_0F
	load_tilemap TILEMAP_037, $07, $00
	do_frames 30
	end_script
	ld a, $25
	ld de, $70e
	ld b, $00
	farcall Func_d3c4
	ret

NPCMovement_3dbac:
	db EAST, MOVE_1
	db NORTH, MOVE_0
	db $ff

NPCMovement_3dbb1:
	db NORTH, MOVE_1
	db $ff

NPCMovement_3dbb4:
	db EAST, MOVE_1
	db NORTH, MOVE_2
	db $ff

NPCMovement_3dbb9:
	db NORTH, MOVE_6
	db $ff

NPCMovement_3dbbc:
	db NORTH, MOVE_2
	db EAST, MOVE_1
	db NORTH, MOVE_3
	db $ff

NPCMovement_3dbc3:
	db NORTH, MOVE_2
	db WEST, MOVE_1
	db NORTH, MOVE_3
	db $ff

NPCMovement_3dbca:
	db NORTH, MOVE_2
	db $ff

NPCMovement_3dbcd:
	db NORTH, MOVE_2
	db EAST, MOVE_4
	db NORTH, MOVE_1
	db $ff

NPCMovement_3dbd4:
	db NORTH, MOVE_2
	db WEST, MOVE_4
	db NORTH, MOVE_1
	db $ff

NPCMovement_3dbdb:
	db NORTH, MOVE_4
	db $ff

Script_3dbde:
	get_player_x_position
	compare_loaded_var $08
	script_jump_if_b1z .ows_3dbff
	animate_npc_movement NPC_TCG_CUP_CLERK_RIGHT, $01, $01
	set_npc_direction NPC_TCG_CUP_CLERK_RIGHT, WEST
	get_player_direction
	compare_loaded_var $00
	script_jump_if_b0nz .ows_3dbf8
	move_player NPCMovement_3dc38, TRUE
	script_jump .ows_3dc17
.ows_3dbf8
	move_player NPCMovement_3dc3c, TRUE
	script_jump .ows_3dc17
.ows_3dbff
	animate_npc_movement NPC_TCG_CUP_CLERK_LEFT, $03, $01
	set_npc_direction NPC_TCG_CUP_CLERK_LEFT, EAST
	get_player_direction
	compare_loaded_var $00
	script_jump_if_b0nz .ows_3dc13
	move_player NPCMovement_3dc41, TRUE
	script_jump .ows_3dc17
.ows_3dc13
	move_player NPCMovement_3dc45, TRUE
.ows_3dc17
	wait_for_player_animation
	do_frames 30
	set_scroll_state $02
	play_sfx SFX_0F
	load_tilemap TILEMAP_038, $07, $00
	do_frames 30
	animate_player_movement $00, $01
	animate_player_movement $00, $01
	end_script
	ld a, $25
	ld de, $604
	ld b, $01
	farcall Func_d3c4
	ret
NPCMovement_3dc38:
	db SOUTH, MOVE_1
	db EAST, MOVE_1
NPCMovement_3dc3c:
	db EAST, MOVE_1
	db NORTH, MOVE_4
	db $ff
NPCMovement_3dc41:
	db SOUTH, MOVE_1
	db WEST, MOVE_1
NPCMovement_3dc45:
	db WEST, MOVE_1
	db NORTH, MOVE_4
	db $ff

SECTION "Bank f@5cbb", ROMX[$5cbb], BANK[$f]

Script_3dcbb:
	set_var VAR_10, $ff
	set_var VAR_11, $ff
	set_var VAR_12, $ff
	set_var VAR_13, $ff
	quit_script
; 0x3dcc8

SECTION "Bank f@5d1d", ROMX[$5d1d], BANK[$f]

Script_3dd1d:
	quit_script
; 0x3dd1e

SECTION "Bank f@5d3a", ROMX[$5d3a], BANK[$f]

Script_3dd3a:
	quit_script
; 0x3dd3b

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
	npc NPC_COURTNEY, 7, 13, SOUTH, $0
	npc NPC_STEVE, 8, 12, SOUTH, $0
	npc NPC_JACK, 8, 13, SOUTH, $0
	npc NPC_ROD, 7, 12, SOUTH, $0
	npc NPC_CUP_HOST, 7, 2, SOUTH, Func_3e68b
	db $ff

PokemonDomeBack_MapScripts:
	dbw $06, Func_3dda8
	dbw $09, Func_3de72
	dbw $07, Func_3ddaf
	dbw $02, Func_3ddb8
	dbw $04, Func_3de67
	dbw $0b, Func_3de91
	dbw $0e, Func_3deca
	dbw $0f, Func_3de6f
	db $ff

Func_3dda8:
	ld hl, PokemonDomeBack_StepEvents
	call Func_324d
	ret

Func_3ddaf:
	ld hl, PokemonDomeBack_NPCs
	call Func_3205
	scf
	ccf
	ret

Func_3ddb8:
	ld a, $01
	farcall GetEventValue
	jr nz, .asm_3ddec
	ld a, $8c
	ld de, $80e
	ld b, $00
	farcall LoadOWObjectInMap
	farcall ResetOWObjectSpriteAnimFlag6
	ld a, $8c
	farcall SetOWObjectAsScrollTarget
	ld a, $0a
	ld [wd582], a
	ld a, $0f
	ld [wd592], a
	ld hl, $5ed6
	ld a, l
	ld [wd593], a
	ld a, h
	ld [$d594], a
	scf
	ret
.asm_3ddec
	ld bc, $b9
	ld de, $500
	farcall Func_12c0ce
	ld a, $2a
	ld de, $305
	ld b, $01
	farcall Func_10f0f
	ld a, $2b
	ld de, $303
	ld b, $01
	farcall Func_10f0f
	ld a, $2c
	ld de, $c05
	ld b, $03
	farcall Func_10f0f
	ld a, $2d
	ld de, $c03
	ld b, $03
	farcall Func_10f0f
	farcall Func_45416
	farcall Func_454fa
	ld a, $14
	farcall GetVarValue
	farcall Func_45484
	ld de, $904
	ld b, $03
	farcall LoadOWObjectInMap
	ld de, $600
	farcall CalcOWScroll
	ld a, $02
	farcall SetOWScrollState
	ld a, $0a
	ld [wd582], a
	ld a, $0f
	ld [wd592], a
	ld hl, $612b
	ld a, l
	ld [wd593], a
	ld a, h
	ld [$d594], a
	ld a, $00
	call Func_338f
	scf
	ccf
	ret

Func_3de67:
	ld a, $00
	call Func_33a3
	scf
	ccf
	ret

Func_3de6f:
	scf
	ccf
	ret

Func_3de72:
	ld a, $01
	farcall GetEventValue
	jr z, .asm_3de7d
	jp Func_3e2a4
.asm_3de7d
	ld a, $0c
	farcall GetVarValue
	jp z, Func_3df57
	dec a
	jp z, Func_3dfc3
	dec a
	jp z, Func_3e02f
	jp Func_3e091

Func_3de91:
	farcall Func_c18f
	ld a, $01
	farcall GetEventValue
	jr nz, .asm_3deb5
	call .asm_3dea2
	jr .asm_3dec7
.asm_3dea2:
	xor a
	start_script
	reset_event EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE_DUMMY
	get_var VAR_0C
	compare_loaded_var $02
	script_jump_if_b1nz Script_3df8d
	script_jump_if_b0nz Script_3dff9
	script_jump Script_3e069
.asm_3deb5
	call .Func_3deba
	jr .asm_3dec7
.Func_3deba
	farcall Func_45573
	xor a
	start_script
	reset_event EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE_DUMMY
	script_jump Script_3e158
.asm_3dec7
	scf
	ccf
	ret

Func_3deca:
	ld a, $01
	farcall GetEventValue
	ret z
	farcall Func_45573
	ret

SECTION "Bank f@5f57", ROMX[$5f57], BANK[$f]

Func_3df57:
	xor a
	start_script
	script_command_01
	check_event EVENT_SET_UNTIL_MAP_RELOAD_2
	script_jump_if_b0nz .ows_3df7a
	print_npc_text Text0f9c
	script_command_02
	move_active_npc NPCMovement_3df81
	wait_for_player_animation
	set_active_npc NPC_ROD, DialogRodText
	script_command_01
	print_npc_text Text0f9d
	script_command_02
	move_npc NPC_STEVE, NPCMovement_3df8a
	wait_for_player_animation
	script_jump Script_3df8d
.ows_3df7a
	print_npc_text Text0f9e
	script_command_02
	script_jump Script_3e105
NPCMovement_3df81:
	db EAST, MOVE_1
	db NORTH, MOVE_2
	db EAST, MOVE_1
	db WEST, MOVE_0
	db $ff
NPCMovement_3df8a:
	db WEST, MOVE_2
	db $ff

Script_3df8d:
	set_var VAR_0C, $01
	set_active_npc NPC_STEVE, DialogSteveText
	script_command_01
	print_npc_text Text0f9f
	set_active_npc NPC_ROD, DialogRodText
.ows_3df9c
	print_npc_text Text0fa0
	ask_question DuelPrepPromptText, FALSE
	script_jump_if_b0z .ows_3dfb0
	script_command_02
	set_event EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE_DUMMY
	script_command_58
	reset_event EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE_DUMMY
	script_command_01
	script_jump .ows_3df9c
.ows_3dfb0
	set_text_ram2 DialogSteveText
	print_npc_text Text0fa1
	set_active_npc NPC_STEVE, DialogSteveText
	print_npc_text Text0fa2
	script_command_02
	start_duel LEGENDARY_FOSSIL_DECK_ID, MUSIC_MATCHSTART_3
	end_script
	ret

Func_3dfc3:
	xor a
	start_script
	script_command_01
	check_event EVENT_SET_UNTIL_MAP_RELOAD_2
	script_jump_if_b0nz .ows_3dfe6
	print_npc_text Text0fa3
	script_command_02
	move_active_npc NPCMovement_3dfed
	wait_for_player_animation
	set_active_npc NPC_ROD, DialogRodText
	script_command_01
	print_npc_text Text0fa4
	script_command_02
	move_npc NPC_JACK, NPCMovement_3dff2
	wait_for_player_animation
	script_jump Script_3dff9
.ows_3dfe6
	print_npc_text Text0fa5
	script_command_02
	script_jump Script_3e105
NPCMovement_3dfed:
	db EAST, MOVE_2
	db WEST, MOVE_0
	db $ff
NPCMovement_3dff2:
	db WEST, MOVE_1
	db NORTH, MOVE_2
	db WEST, MOVE_1
	db $ff
Script_3dff9:
	set_var VAR_0C, $02
	set_active_npc NPC_JACK, DialogJackText
	script_command_01
	print_npc_text Text0fa6
	set_active_npc NPC_ROD, DialogRodText
.ows_3e008
	print_npc_text Text0fa0
	ask_question DuelPrepPromptText, FALSE
	script_jump_if_b0z .ows_3e01c
	script_command_02
	set_event EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE_DUMMY
	script_command_58
	reset_event EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE_DUMMY
	script_command_01
	script_jump .ows_3e008
.ows_3e01c
	set_text_ram2 DialogJackText
	print_npc_text Text0fa1
	set_active_npc NPC_JACK, DialogJackText
	print_npc_text Text0fa7
	script_command_02
	start_duel WATER_LEGEND_DECK_ID, MUSIC_MATCHSTART_3
	end_script
	ret

Func_3e02f:
	xor a
	start_script
	script_command_01
	check_event EVENT_SET_UNTIL_MAP_RELOAD_2
	script_jump_if_b0nz .ows_3e052
	print_npc_text Text0fa8
	script_command_02
	move_active_npc NPCMovement_3e059
	wait_for_player_animation
	set_active_npc NPC_ROD, DialogRodText
	script_command_01
	print_npc_text Text0fa9
	script_command_02
	move_npc NPC_ROD, NPCMovement_3e062
	wait_for_player_animation
	script_jump Script_3e069
.ows_3e052
	print_npc_text Text0faa
	script_command_02
	script_jump Script_3e105
NPCMovement_3e059:
	db EAST, MOVE_1
	db SOUTH, MOVE_2
	db EAST, MOVE_1
	db WEST, MOVE_0
	db $ff
NPCMovement_3e062:
	db EAST, MOVE_3
	db SOUTH, MOVE_2
	db WEST, MOVE_1
	db $ff

Script_3e069:
	set_var VAR_0C, $03
	set_active_npc NPC_ROD, DialogRodText
	script_command_01
	print_npc_text Text0fab
.ows_3e074
	print_npc_text Text0fa0
	ask_question DuelPrepPromptText, FALSE
	script_jump_if_b0z .ows_3e088
	script_command_02
	set_event EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE_DUMMY
	script_command_58
	reset_event EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE_DUMMY
	script_command_01
	script_jump .ows_3e074
.ows_3e088
	print_npc_text Text0fac
	script_command_02
	start_duel GREAT_DRAGON_DECK_ID, MUSIC_MATCHSTART_3
	end_script
		ret
Func_3e091:
	xor a
	start_script
	script_command_01
	check_event EVENT_SET_UNTIL_MAP_RELOAD_2
	script_jump_if_b0nz .ows_3e0a2
	print_npc_text Text0fad
	script_command_02
	script_jump .ows_3e0b2
.ows_3e0a2
	print_npc_text Text0fae
	script_command_02
	move_active_npc .NPCMovement_3e0ad
	wait_for_player_animation
	script_jump Script_3e105
.NPCMovement_3e0ad:
	db NORTH, MOVE_2
	db WEST, MOVE_2
	db $ff
.ows_3e0b2
	set_event EVENT_BEAT_GRAND_MASTER_CUP
	set_event EVENT_SET_UNTIL_MAP_RELOAD_1
	move_active_npc NPCMovement_3e0fe
	wait_for_player_animation
	set_player_direction NORTH
	script_command_01
	print_npc_text Text0faf
	quit_script
	farcall Func_1022a
	ld de, $7b
	farcall Func_c646
	ld de, $e1
	farcall Func_c646
	ld de, $b9
	farcall Func_c646
	ld de, $183
	farcall Func_c646
	farcall Func_10252
	call WaitPalFading
	ld a, $01
	start_script
	print_npc_text Text0fb0
	script_command_02
	end_script
	ld a, $24
	ld de, $701
	ld b, $02
	farcall Func_d3c4
	ret
NPCMovement_3e0fe:
	db NORTH, MOVE_2
	db WEST, MOVE_3
	db SOUTH, MOVE_1
	db $ff
Script_3e105:
	set_event EVENT_SET_UNTIL_MAP_RELOAD_1
	set_event EVENT_EE
	move_npc NPC_ROD, NPCMovement_3e126
	wait_for_player_animation
	set_player_direction NORTH
	set_active_npc NPC_ROD, DialogRodText
	script_command_01
	print_npc_text Text0fb1
	script_command_02
	end_script
	ld a, $24
	ld de, $701
	ld b, $02
	farcall Func_d3c4
	ret

NPCMovement_3e126:
	db WEST, MOVE_1
	db SOUTH, MOVE_1
	db $ff

SECTION "Bank f@6158", ROMX[$6158], BANK[$f]

Script_3e158:
	set_var VAR_0E, $01
	set_active_npc NPC_CUP_HOST, DialogCupHostText
	script_command_01
	print_npc_text Text0fb3
	script_command_02
	move_active_npc NPCMovement_3e1a9
	wait_for_player_animation
	script_command_01
	print_npc_text Text0fb4
	script_command_02
	move_active_npc NPCMovement_3e1ae
	wait_for_player_animation
	quit_script
	farcall Func_454bc
	ld a, $01
	start_script
	script_command_01
	print_npc_text Text0fb5
	script_command_02
	move_active_npc NPCMovement_3e1b3
	wait_for_player_animation
	script_command_01
	print_npc_text Text0fb6
.ows_3e188
	print_npc_text Text0fb7
	ask_question DuelPrepPromptText, FALSE
	script_jump_if_b0z .ows_3e19f
	print_npc_text Text0fb8
	script_command_02
	set_event EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE_DUMMY
	script_command_58
	reset_event EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE_DUMMY
	script_command_01
	script_jump .ows_3e188
.ows_3e19f
	print_npc_text Text0fb9
	script_command_02
	end_script
	farcall Func_454ab
	ret
NPCMovement_3e1a9:
	db WEST, MOVE_1
	db SOUTH, MOVE_0
	db $ff
NPCMovement_3e1ae:
	db EAST, MOVE_3
	db SOUTH, MOVE_0
	db $ff
NPCMovement_3e1b3:
	db WEST, MOVE_2
	db SOUTH, MOVE_0
	db $ff

Script_3e1b8:
	quit_script
; 0x3e1b9

SECTION "Bank f@621c", ROMX[$621c], BANK[$f]

Script_3e21c:
	quit_script
; 0x3e21d

SECTION "Bank f@62a4", ROMX[$62a4], BANK[$f]

Func_3e2a4:
	xor a
	start_script
	script_command_01
	get_var VAR_0E
	compare_loaded_var $03
	script_jump_if_b0nz Script_3e344
	script_jump_if_b1z Script_3e416
	check_event EVENT_SET_UNTIL_MAP_RELOAD_2
	script_jump_if_b0nz .ows_3e313
	quit_script
	ld a, $0e
	farcall GetVarValue
	ld h, $00
	ld l, a
	call LoadTxRam3
	farcall Func_454e3
	ld a, $01
	start_script
	print_npc_text Text0fc4
	script_command_02
	move_active_npc NPCMovement_3e333
	wait_for_player_animation
	script_command_01
	print_npc_text Text0fc5
	script_command_02
	quit_script
	farcall Func_45488
	farcall Func_45484
	push af
	ld b, $0f
	ld hl, $633f
	farcall Func_10def
	ld a, $8c
	ld hl, $6338
	farcall Func_10def
	call Func_3340
	pop af
	farcall ClearOWObject
	ld a, $01
	start_script
	script_command_01
	print_npc_text Text0fc6
	script_command_02
	get_var VAR_0E
	compare_loaded_var $01
	script_jump_if_b0nz Script_3e1b8
	script_jump Script_3e21c
.ows_3e313
	quit_script
	ld a, $0e
	farcall GetVarValue
	ld h, $00
	ld l, a
	call LoadTxRam3
	farcall Func_454e3
	ld a, $01
	start_script
	print_npc_text Text0fc7
	print_npc_text Text0fc8
	script_command_02
	script_jump Script_3e65d
NPCMovement_3e333:
	db EAST, MOVE_2
	db SOUTH, MOVE_1
	db $ff

SECTION "Bank f@6344", ROMX[$6344], BANK[$f]

Script_3e344:
	check_event EVENT_SET_UNTIL_MAP_RELOAD_2
	script_jump_if_b0nz Script_3e3c0
	print_npc_text Text0fc9
	quit_script
; 0x3e34d

SECTION "Bank f@63c0", ROMX[$63c0], BANK[$f]

Script_3e3c0:
	quit_script
; 0x3e3c1

SECTION "Bank f@6416", ROMX[$6416], BANK[$f]

Script_3e416:
	get_var VAR_1F
	compare_loaded_var $00
	script_jump_if_b0nz .ows_3e494
	compare_loaded_var $02
	script_jump_if_b1nz .ows_3e4f5
	script_jump_if_b0nz .ows_3e552
	script_jump .ows_3e5a4

.ows_3e428
	set_var VAR_0E, $04
	script_command_01
	print_npc_text Text0fd0
	script_command_02
	set_active_npc NPC_ROD, DialogRodText
	move_active_npc .NPCMovement_3e44e
	wait_for_player_animation
	script_command_01
	print_npc_text Text0fd1
	get_random $04
	compare_loaded_var $00
	script_jump_if_b0nz .ows_3e455
	compare_loaded_var $02
	script_jump_if_b1nz .ows_3e4b4
	script_jump_if_b0nz .ows_3e515
	script_jump .ows_3e572

.NPCMovement_3e44e:
	db NORTH, MOVE_1
	db WEST, MOVE_4
	db SOUTH, MOVE_0
	db $ff

.ows_3e455
	set_var VAR_1F, $00
	set_text_ram2 DialogCourtneyText
	print_npc_text Text0fd2
	set_active_npc NPC_CUP_HOST, DialogCupHostText
	print_npc_text Text0fd3
	script_command_02
	move_npc NPC_COURTNEY, .NPCMovement_3e484
	move_npc NPC_ROD, .NPCMovement_3e48d
	wait_for_player_animation
	script_command_01
	set_active_npc NPC_COURTNEY, DialogCourtneyText
	print_npc_text Text0fd4
	set_active_npc NPC_CUP_HOST, DialogCupHostText
	print_npc_text Text0fd5
	script_command_02
	start_duel GRAND_FIRE_DECK_ID, MUSIC_MATCHSTART_3
	end_script
	ret

.NPCMovement_3e484:
	db SOUTH, MOVE_1
	db EAST, MOVE_6
	db NORTH, MOVE_2
	db WEST, MOVE_0
	db $ff

.NPCMovement_3e48d:
	db EAST, MOVE_4
	db SOUTH, MOVE_1
	db WEST, MOVE_0
	db $ff

.ows_3e494
	set_active_npc NPC_COURTNEY, DialogCourtneyText
	check_event EVENT_SET_UNTIL_MAP_RELOAD_2
	script_jump_if_b0nz .ows_3e4a3
	print_npc_text Text0f9c
	script_jump .ows_3e5c4

.ows_3e4a3
	print_npc_text Text0fd6
	set_active_npc NPC_CUP_HOST, DialogCupHostText
	set_text_ram2 DialogCourtneyText
	print_npc_text Text0fd7
	script_command_02
	script_jump Script_3e65d

.ows_3e4b4
	set_var VAR_1F, $01
	set_text_ram2 DialogSteveText
	print_npc_text Text0fd2
	set_active_npc NPC_CUP_HOST, DialogCupHostText
	print_npc_text Text0fd8
	script_command_02
	move_npc NPC_STEVE, .NPCMovement_3e4e3
	move_npc NPC_ROD, .NPCMovement_3e4ee
	wait_for_player_animation
	script_command_01
	set_active_npc NPC_STEVE, DialogSteveText
	print_npc_text Text0fd9
	set_active_npc NPC_CUP_HOST, DialogCupHostText
	print_npc_text Text0fd5
	script_command_02
	start_duel LEGENDARY_FOSSIL_DECK_ID, MUSIC_MATCHSTART_3
	end_script
	ret

.NPCMovement_3e4e3:
	db EAST, MOVE_1
	db SOUTH, MOVE_3
	db EAST, MOVE_5
	db NORTH, MOVE_2
	db WEST, MOVE_0
	db $ff

.NPCMovement_3e4ee:
	db EAST, MOVE_4
	db SOUTH, MOVE_1
	db WEST, MOVE_0
	db $ff

.ows_3e4f5
	set_active_npc NPC_STEVE, DialogSteveText
	check_event EVENT_SET_UNTIL_MAP_RELOAD_2
	script_jump_if_b0nz .ows_3e504
	print_npc_text Text0fa3
	script_jump .ows_3e5c4

.ows_3e504
	print_npc_text Text0fa5
	set_active_npc NPC_CUP_HOST, DialogCupHostText
	set_text_ram2 DialogSteveText
	print_npc_text Text0fd7
	script_command_02
	script_jump Script_3e65d

.ows_3e515
	set_var VAR_1F, $02
	set_text_ram2 DialogJackText
	print_npc_text Text0fd2
	set_active_npc NPC_CUP_HOST, DialogCupHostText
	print_npc_text Text0fda
	script_command_02
	move_npc NPC_JACK, .NPCMovement_3e544
	move_npc NPC_ROD, .NPCMovement_3e54b
	wait_for_player_animation
	script_command_01
	set_active_npc NPC_JACK, DialogJackText
	print_npc_text Text0fdb
	set_active_npc NPC_CUP_HOST, DialogCupHostText
	print_npc_text Text0fd5
	script_command_02
	start_duel WATER_LEGEND_DECK_ID, MUSIC_MATCHSTART_3
	end_script
	ret

.NPCMovement_3e544:
	db WEST, MOVE_3
	db NORTH, MOVE_1
	db WEST, MOVE_0
	db $ff

.NPCMovement_3e54b:
	db EAST, MOVE_4
	db SOUTH, MOVE_1
	db WEST, MOVE_0
	db $ff

.ows_3e552
	set_active_npc NPC_JACK, DialogJackText
	check_event EVENT_SET_UNTIL_MAP_RELOAD_2
	script_jump_if_b0nz .ows_3e561
	print_npc_text Text0fdc
	script_jump .ows_3e5c4

.ows_3e561
	print_npc_text Text0faa
	set_active_npc NPC_CUP_HOST, DialogCupHostText
	set_text_ram2 DialogJackText
	print_npc_text Text0fd7
	script_command_02
	script_jump Script_3e65d

.ows_3e572
	set_var VAR_1F, $03
	set_text_ram2 DialogRodText
	print_npc_text Text0fd2
	set_active_npc NPC_CUP_HOST, DialogCupHostText
	print_npc_text Text0fdd
	script_command_02
	move_npc NPC_ROD, .NPCMovement_3e59d
	wait_for_player_animation
	script_command_01
	set_active_npc NPC_ROD, DialogRodText
	print_npc_text Text0fde
	set_active_npc NPC_CUP_HOST, DialogCupHostText
	print_npc_text Text0fd5
	script_command_02
	start_duel GREAT_DRAGON_DECK_ID, MUSIC_MATCHSTART_3
	end_script
	ret

.NPCMovement_3e59d:
	db EAST, MOVE_1
	db SOUTH, MOVE_2
	db WEST, MOVE_0
	db $ff

.ows_3e5a4
	set_active_npc NPC_ROD, DialogRodText
	check_event EVENT_SET_UNTIL_MAP_RELOAD_2
	script_jump_if_b0nz .ows_3e5b3
	print_npc_text Text0fad
	script_jump .ows_3e5c4

.ows_3e5b3
	print_npc_text Text0fae
	set_active_npc NPC_CUP_HOST, DialogCupHostText
	set_text_ram2 DialogRodText
	print_npc_text Text0fd7
	script_command_02
	script_jump Script_3e65d

.ows_3e5c4
	set_event EVENT_DB
	set_var VAR_0D, $05
	set_event EVENT_SET_UNTIL_MAP_RELOAD_1
	set_active_npc NPC_CUP_HOST, DialogCupHostText
	print_npc_text Text0fdf
	play_song MUSIC_DITTY6
	print_npc_text Text0fe0
	wait_song
	resume_song
	script_command_02
	move_active_npc NPCMovement_3e658
	wait_for_player_animation
	set_player_direction NORTH
	script_command_01
	print_npc_text Text0fe1
	quit_script

Func_3e5e5:
	xor a
.asm_3e5e6
	farcall Func_45676
	farcall Func_4568f
	farcall Func_1f7d4
	inc a
	cp $04
	jr c, .asm_3e5e6
	farcall Func_1f627
	push bc
	ld hl, wScriptNPCName
	ld a, [hli]
	ld d, [hl]
	ld e, a
	ld hl, $fe2
	farcall PrintScrollableText_WithTextBoxLabelVRAM0
	pop bc
	farcall Func_1022a
	push bc
	ld a, b
	farcall Func_45676
	ld e, c
	ld d, b
	farcall Func_c646
	pop bc
	ld a, c
	farcall Func_45676
	ld e, c
	ld d, b
	farcall Func_c646
	farcall Func_10252
	call WaitPalFading
	ld a, $01
	start_script
	check_event EVENT_GOT_ARBOK_COIN
	script_jump_if_b0z .ows_3e644
	print_npc_text Text0fe3
	set_event EVENT_GOT_ARBOK_COIN
	give_coin COIN_ARBOK
	print_npc_text Text0fe4
	script_jump .ows_3e647
.ows_3e644
	print_npc_text Text0fe5
.ows_3e647
	print_npc_text Text0fe6
	script_command_02
	end_script
	ld a, $24
	ld de, $701
	ld b, $02
	farcall Func_d3c4
	ret

NPCMovement_3e658:
	db WEST, MOVE_1
	db SOUTH, MOVE_1
	db $ff

Script_3e65d:
	set_var VAR_0D, $06
	set_event EVENT_SET_UNTIL_MAP_RELOAD_1
	set_active_npc NPC_CUP_HOST, DialogCupHostText
	move_active_npc NPCMovement_3e681
	wait_for_player_animation
	script_command_01
	print_npc_text Text0fe7
	script_command_02
	move_player NPCMovement_3e686, TRUE
	wait_for_player_animation
	end_script
	ld a, $24
	ld de, $701
	ld b, $02
	farcall Func_d3c4
	ret
NPCMovement_3e681:
	db WEST, MOVE_1
	db SOUTH, MOVE_1
	db $ff

NPCMovement_3e686:
	db WEST, MOVE_2
	db SOUTH, MOVE_8
	db $ff

Func_3e68b:
	ld a, $01
	farcall GetEventValue
	jr nz, .asm_3e695
	scf
	ret
.asm_3e695
	scf
	ccf
	ret

IshiharasVillaMain_MapHeader:
	db MAP_GFX_ISHIHARAS_VILLA_MAIN
	dba IshiharasVillaMain_MapScripts
	db MUSIC_ISHIHARA

IshiharasVillaMain_StepEvents:
	map_exit 4, 10, OVERWORLD_MAP_GR, 4, 4, SOUTH
	map_exit 5, 10, OVERWORLD_MAP_GR, 4, 4, SOUTH
	map_exit 4, 0, MAP_ISHIHARAS_VILLA_LIBRARY, 4, 7, NORTH
	map_exit 5, 0, MAP_ISHIHARAS_VILLA_LIBRARY, 5, 7, NORTH
	db $ff

IshiharasVillaMain_NPCs:
	npc NPC_ISHIHARA, 6, 5, WEST, Func_3e7d6
	npc NPC_ISHIHARAS_VILLA_GR_GAL, 2, 2, NORTH, Func_3e8d3
	db $ff

IshiharasVillaMain_NPCInteractions:
	npc_script NPC_ISHIHARA, Func_3e7c0
	npc_script NPC_ISHIHARAS_VILLA_GR_GAL, Func_3e8b1
	db $ff

IshiharasVillaMain_OWInteractions:
	ow_script 7, 2, PCMenu
	ow_script 8, 2, PCMenu
	db $ff

IshiharasVillaMain_MapScripts:
	dbw $06, Func_3e72a
	dbw $08, Func_3e73a
	dbw $09, Func_3e7bb
	dbw $07, Func_3e731
	dbw $0c, Func_3e74a
	dbw $0d, Func_3e778
	dbw $0b, Func_3e787
	dbw $01, Func_3e704
	db $ff

Func_3e704:
	ld a, $02
	farcall GetVarValue
	cp $05
	jr c, .asm_3e722
	jr z, .asm_3e71a
	ld a, $f5
	farcall GetEventValue
	jr nz, .asm_3e722
	jr .asm_3e727
.asm_3e71a
	ld a, $f4
	farcall GetEventValue
	jr z, .asm_3e727
.asm_3e722
	ld a, $15
	ld [wNextMusic], a
.asm_3e727
	scf
	ccf
	ret

Func_3e72a:
	ld hl, IshiharasVillaMain_StepEvents
	call Func_324d
	ret

Func_3e731:
	ld hl, IshiharasVillaMain_NPCs
	call Func_3205
	scf
	ccf
	ret

Func_3e73a:
	ld hl, IshiharasVillaMain_NPCInteractions
	call Func_32aa
	jr nc, .asm_3e748
	ld hl, IshiharasVillaMain_OWInteractions
	call Func_32bf
.asm_3e748
	scf
	ret

Func_3e74a:
	xor a
	push af
	ld a, $f5
	farcall GetEventValue
	jr z, .asm_3e758
	pop af
	or $01
	push af
.asm_3e758
	ld a, $f4
	farcall GetEventValue
	jr z, .asm_3e764
	pop af
	or $02
	push af
.asm_3e764
	pop af
	or a
	jr z, .asm_3e775
	ld c, a
	ld a, $00
	farcall SetVarValue
	ld a, $03
	farcall MaxOutEventValue
.asm_3e775
	scf
	ccf
	ret

Func_3e778:
	ld a, $03
	farcall ZeroOutEventValue
	ld a, $00
	farcall ZeroOutVarValue
	scf
	ccf
	ret

Func_3e787:
	ld a, $f5
	farcall ZeroOutEventValue
	ld a, $00
	farcall GetVarValue
	bit 0, a
	push af
	call nz, Func_3e7ad
	pop af
	bit 1, a
	call nz, Func_3e7b4
	ld a, $03
	farcall ZeroOutEventValue
	ld a, $00
	farcall ZeroOutVarValue
	scf
	ret

Func_3e7ad:
	ld a, $f5
	farcall MaxOutEventValue
	ret

Func_3e7b4:
	ld a, $f4
	farcall MaxOutEventValue
	ret

Func_3e7bb:
	call Func_3e836
	scf
	ret

Func_3e7c0:
	ld a, $01
	farcall GetEventValue
	jr z, .asm_3e7d3
	ld a, $97
	farcall GetEventValue
	jr nz, .asm_3e7d3
	jp Func_3e854
.asm_3e7d3
	jp Func_3e7f5

Func_3e7d6:
	ld a, $02
	farcall GetVarValue
	cp $0a
	jr c, .asm_3e7f3
	ld a, $f4
	farcall GetEventValue
	jr nz, .asm_3e7f3
	ld a, $f5
	farcall GetEventValue
	jr nz, .asm_3e7f3
	scf
	ccf
	ret
.asm_3e7f3
	scf
	ret

Func_3e7f5:
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
	get_player_opposite_direction
	restore_active_npc_direction
	check_event EVENT_TALKED_TO_ISHIHARA
	script_jump_if_b0z .ows_3e819
	set_event EVENT_TALKED_TO_ISHIHARA
	print_npc_text Text0ee2
	script_jump .ows_3e81c
.ows_3e819
	print_npc_text Text0ee3
.ows_3e81c
	ask_question Text0ee4, TRUE
	script_jump_if_b0z .ows_3e830
	script_call Script_3e873
	print_npc_text Text0ee5
	script_command_02
	start_duel VERY_RARE_CARD_DECK_ID, MUSIC_MATCHSTART_1
	end_script
	ret
.ows_3e830
	print_npc_text Text0ee6
	script_command_02
	end_script
	ret

Func_3e836:
	xor a
	start_script
	script_command_01
	check_event EVENT_SET_UNTIL_MAP_RELOAD_2
	script_jump_if_b0nz .ows_3e84e
	set_event EVENT_BATTLED_ISHIHARA
	print_npc_text Text0ee7
	give_booster_packs BoosterList_cdd3
	print_npc_text Text0ee8
	script_jump .ows_3e851
.ows_3e84e
	print_npc_text Text0ee9
.ows_3e851
	script_command_02
	end_script
	ret

Func_3e854:
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
	get_player_opposite_direction
	restore_active_npc_direction
	set_event EVENT_TALKED_TO_ISHIHARA_POST_GAME
	print_npc_text Text0eb4
	script_command_02
	end_script
	ret

Script_3e873:
	script_command_02
	set_active_npc_direction WEST
	get_player_direction
	compare_loaded_var $00
	script_jump_if_b0nz .ows_3e88f
	compare_loaded_var $03
	script_jump_if_b0nz .ows_3e888
	move_player NPCMovement_3e896, TRUE
	script_jump .ows_3e893

.ows_3e888
	move_player NPCMovement_3e89f, TRUE
	script_jump .ows_3e893

.ows_3e88f
	move_player NPCMovement_3e8a8, TRUE
.ows_3e893
	wait_for_player_animation
	script_command_01
	script_ret

NPCMovement_3e896:
	db NORTH, MOVE_1
	db WEST, MOVE_3
	db SOUTH, MOVE_2
	db EAST, MOVE_0
	db $ff

NPCMovement_3e89f:
	db SOUTH, MOVE_2
	db WEST, MOVE_4
	db NORTH, MOVE_2
	db EAST, MOVE_0
	db $ff

NPCMovement_3e8a8:
	db SOUTH, MOVE_1
	db WEST, MOVE_3
	db NORTH, MOVE_2
	db EAST, MOVE_0
	db $ff

Func_3e8b1:
	ld a, $dd
	ld [wScriptNPC], a
	ld hl, $a26
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	print_npc_text Text0eea
	get_player_opposite_direction
	restore_active_npc_direction
	print_npc_text Text0eeb
	script_command_02
	set_active_npc_direction NORTH
	end_script
	ret

Func_3e8d3:
	ld a, $ce
	farcall GetEventValue
	jr nz, .asm_3e8de
	scf
	ccf
	ret
.asm_3e8de
	scf
	ret

IshiharasVillaLibrary_MapHeader:
	db MAP_GFX_ISHIHARAS_VILLA_LIBRARY
	dba IshiharasVillaLibrary_MapScripts
	db MUSIC_ISHIHARA

IshiharasVillaLibrary_StepEvents:
	map_exit 4, 8, MAP_ISHIHARAS_VILLA_MAIN, 4, 1, SOUTH
	map_exit 5, 8, MAP_ISHIHARAS_VILLA_MAIN, 5, 1, SOUTH
	db $ff

IshiharasVillaLibrary_NPCs:
	npc NPC_ISHIHARA, 5, 4, SOUTH, Func_3ea55
	npc NPC_ISHIHARAS_VILLA_GR_GAL, 4, 2, NORTH, Func_3ecd5
	db $ff

IshiharasVillaLibrary_NPCInteractions:
	npc_script NPC_ISHIHARA, Func_3ea12
	npc_script NPC_ISHIHARAS_VILLA_GR_GAL, Func_3ec75
	db $ff

IshiharasVillaLibrary_OWInteractions:
	ow_script 1, 2, Func_403de
	ow_script 2, 2, Func_403f4
	ow_script 3, 2, Func_4040a
	ow_script 6, 2, Func_40420
	ow_script 7, 2, Func_40436
	ow_script 8, 2, Func_4044c
	db $ff

IshiharasVillaLibrary_MapScripts:
	dbw $06, Func_3e981
	dbw $08, Func_3e991
	dbw $07, Func_3e988
	dbw $0c, Func_3e9a1
	dbw $0d, Func_3e9cf
	dbw $0b, Func_3e9de
	dbw $01, Func_3e95b
	db $ff

Func_3e95b:
	ld a, $02
	farcall GetVarValue
	cp $05
	jr c, .asm_3e979
	jr z, .asm_3e971
	ld a, $f5
	farcall GetEventValue
	jr nz, .asm_3e979
	jr .asm_3e97e
.asm_3e971
	ld a, $f4
	farcall GetEventValue
	jr z, .asm_3e97e
.asm_3e979
	ld a, $15
	ld [wNextMusic], a
.asm_3e97e
	scf
	ccf
	ret

Func_3e981:
	ld hl, IshiharasVillaLibrary_StepEvents
	call Func_324d
	ret

Func_3e988:
	ld hl, IshiharasVillaLibrary_NPCs
	call Func_3205
	scf
	ccf
	ret

Func_3e991:
	ld hl, IshiharasVillaLibrary_NPCInteractions
	call Func_328c
	jr nc, .asm_3e99f
	ld hl, IshiharasVillaLibrary_OWInteractions
	call Func_32bf
.asm_3e99f
	scf
	ret

Func_3e9a1:
	xor a
	push af
	ld a, $f5
	farcall GetEventValue
	jr z, .asm_3e9af
	pop af
	or $01
	push af
.asm_3e9af
	ld a, $f4
	farcall GetEventValue
	jr z, .asm_3e9bb
	pop af
	or $02
	push af
.asm_3e9bb
	pop af
	or a
	jr z, .asm_3e9cc
	ld c, a
	ld a, $00
	farcall SetVarValue
	ld a, $03
	farcall MaxOutEventValue
.asm_3e9cc
	scf
	ccf
	ret

Func_3e9cf:
	ld a, $03
	farcall ZeroOutEventValue
	ld a, $00
	farcall ZeroOutVarValue
	scf
	ccf
	ret

Func_3e9de:
	ld a, $f5
	farcall ZeroOutEventValue
	ld a, $00
	farcall GetVarValue
	bit 0, a
	push af
	call nz, Func_3ea04
	pop af
	bit 1, a
	call nz, Func_3ea0b
	ld a, $03
	farcall ZeroOutEventValue
	ld a, $00
	farcall ZeroOutVarValue
	scf
	ret

Func_3ea04:
	ld a, $f5
	farcall MaxOutEventValue
	ret

Func_3ea0b:
	ld a, $f4
	farcall MaxOutEventValue
	ret

Func_3ea12:
	ld a, $01
	farcall GetEventValue
	jr z, .asm_3ea25
	ld a, $97
	farcall GetEventValue
	jr nz, .asm_3ea25
	jp Func_3ec58
.asm_3ea25
	ld a, $f4
	farcall GetEventValue
	jr z, .asm_3ea3b
	ld a, $02
	farcall GetVarValue
	cp $06
	jp z, Func_3ea86
	jp Func_3ec3d
.asm_3ea3b
	ld a, $02
	farcall GetVarValue
	sub $05
	jp z, Func_3ea86
	dec a
	jp z, Func_3eab1
	dec a
	jp z, Func_3eb14
	dec a
	jp z, Func_3eb77
	jp Func_3ebda

Func_3ea55:
	ld a, $02
	farcall GetVarValue
	cp $05
	jr c, .asm_3ea84
	jr z, .asm_3ea6f
	cp $0a
	jr z, .asm_3ea79
	ld a, $f5
	farcall GetEventValue
	jr nz, .asm_3ea84
	jr .asm_3ea81
.asm_3ea6f
	ld a, $f4
	farcall GetEventValue
	jr nz, .asm_3ea84
	jr .asm_3ea81
.asm_3ea79
	ld a, $f4
	farcall GetEventValue
	jr z, .asm_3ea84
.asm_3ea81
	scf
	ccf
	ret
.asm_3ea84
	scf
	ret

Func_3ea86:
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
	check_event EVENT_ISHIHARA_CARD_TRADE_STATE
	script_jump_if_b0z .ows_3eaab
	set_var VAR_02, $06
	set_event EVENT_ISHIHARA_CARD_TRADE_STATE
	print_npc_text Text0ebf
	script_jump .ows_3eaae
.ows_3eaab
	print_npc_text Text0ec0
.ows_3eaae
	script_command_02
	end_script
	ret

Func_3eab1:
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
	script_jump_if_b0z .ows_3ead3
	set_event EVENT_TALKED_TO_ISHIHARA
	print_npc_text Text0ec1
	script_jump .ows_3ead6
.ows_3ead3
	print_npc_text Text0ec2
.ows_3ead6
	ask_question TradeCardsPromptText, TRUE
	script_jump_if_b0nz .ows_3eae3
	print_npc_text Text0e9d
	script_jump .ows_3eb11
.ows_3eae3
	get_card_count_in_collection_and_decks MOLTRES_LV37
	script_jump_if_b0z .ows_3eaef
	print_npc_text Text0ec3
	script_jump .ows_3eb11
.ows_3eaef
	get_card_count_in_collection MOLTRES_LV37
	script_jump_if_b0z .ows_3eafb
	print_npc_text Text0ec4
	script_jump .ows_3eb11
.ows_3eafb
	print_npc_text Text0ec5
	print_text Text0ec6
	receive_card SURFING_PIKACHU_ALT_LV13
	take_card MOLTRES_LV37
	set_event EVENT_ISHIHARA_CARD_TRADE_STATE
	reset_event EVENT_TALKED_TO_ISHIHARA
	set_var VAR_02, $07
	print_npc_text Text0ec7
.ows_3eb11
	script_command_02
	end_script
	ret

Func_3eb14:
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
	script_jump_if_b0z .ows_3eb36
	set_event EVENT_TALKED_TO_ISHIHARA
	print_npc_text Text0ec8
	script_jump .ows_3eb39
.ows_3eb36
	print_npc_text Text0ec9
.ows_3eb39
	ask_question TradeCardsPromptText, TRUE
	script_jump_if_b0nz .ows_3eb46
	print_npc_text Text0e9d
	script_jump .ows_3eb74
.ows_3eb46
	get_card_count_in_collection_and_decks ARTICUNO_LV34
	script_jump_if_b0z .ows_3eb52
	print_npc_text Text0eca
	script_jump .ows_3eb74
.ows_3eb52
	get_card_count_in_collection ARTICUNO_LV34
	script_jump_if_b0z .ows_3eb5e
	print_npc_text Text0ecb
	script_jump .ows_3eb74
.ows_3eb5e
	print_npc_text Text0ecc
	print_text Text0ecd
	receive_card SURFING_PIKACHU_LV13
	take_card ARTICUNO_LV34
	set_event EVENT_ISHIHARA_CARD_TRADE_STATE
	reset_event EVENT_TALKED_TO_ISHIHARA
	set_var VAR_02, $08
	print_npc_text Text0ece
.ows_3eb74
	script_command_02
	end_script
	ret

Func_3eb77:
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
	script_jump_if_b0z .ows_3eb99
	set_event EVENT_TALKED_TO_ISHIHARA
	print_npc_text Text0ecf
	script_jump .ows_3eb9c
.ows_3eb99
	print_npc_text Text0ed0
.ows_3eb9c
	ask_question TradeCardsPromptText, TRUE
	script_jump_if_b0nz .ows_3eba9
	print_npc_text Text0e9d
	script_jump .ows_3ebd7
.ows_3eba9
	get_card_count_in_collection_and_decks ZAPDOS_LV40
	script_jump_if_b0z .ows_3ebb5
	print_npc_text Text0ed1
	script_jump .ows_3ebd7
.ows_3ebb5
	get_card_count_in_collection ZAPDOS_LV40
	script_jump_if_b0z .ows_3ebc1
	print_npc_text Text0ed2
	script_jump .ows_3ebd7
.ows_3ebc1
	print_npc_text Text0ed3
	print_text Text0ed4
	receive_card FLYING_PIKACHU_LV12
	take_card ZAPDOS_LV40
	set_event EVENT_ISHIHARA_CARD_TRADE_STATE
	reset_event EVENT_TALKED_TO_ISHIHARA
	set_var VAR_02, $09
	print_npc_text Text0ed5
.ows_3ebd7
	script_command_02
	end_script
	ret

Func_3ebda:
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
	script_jump_if_b0z .ows_3ebfc
	set_event EVENT_TALKED_TO_ISHIHARA
	print_npc_text Text0ed6
	script_jump .ows_3ebff
.ows_3ebfc
	print_npc_text Text0ed7
.ows_3ebff
	ask_question TradeCardsPromptText, TRUE
	script_jump_if_b0nz .ows_3ec0c
	print_npc_text Text0e9d
	script_jump .ows_3ec3a
.ows_3ec0c
	get_card_count_in_collection_and_decks DARK_DRAGONITE
	script_jump_if_b0z .ows_3ec18
	print_npc_text Text0ed8
	script_jump .ows_3ec3a
.ows_3ec18
	get_card_count_in_collection DARK_DRAGONITE
	script_jump_if_b0z .ows_3ec24
	print_npc_text Text0ed9
	script_jump .ows_3ec3a
.ows_3ec24
	print_npc_text Text0eda
	print_text Text0edb
	receive_card BILLS_COMPUTER
	take_card DARK_DRAGONITE
	set_event EVENT_ISHIHARA_CARD_TRADE_STATE
	reset_event EVENT_TALKED_TO_ISHIHARA
	set_var VAR_02, $0a
	print_npc_text Text0edc
.ows_3ec3a
	script_command_02
	end_script
	ret

Func_3ec3d:
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
	print_npc_text Text0edd
	script_command_02
	end_script
	ret

Func_3ec58:
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
	end_script
	ret

Func_3ec75:
	ld a, $dd
	ld [wScriptNPC], a
	ld hl, $a26
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	set_event EVENT_MET_GR_GAL_ISHIHARAS_VILLA
	get_player_opposite_direction
	restore_active_npc_direction
	print_npc_text Text0ede
	script_command_02
	get_player_direction
	compare_loaded_var $00
	script_jump_if_b0z .ows_3ec9d
	set_player_direction EAST
	animate_player_movement $83, $02
.ows_3ec9d
	check_npc_loaded NPC_ISHIHARA
	script_jump_if_b1nz .ows_3ecc2
	move_active_npc NPCMovement_3ecca
	wait_for_player_animation
	script_command_01
	print_npc_text Text0edf
	set_active_npc NPC_ISHIHARA, DialogMrIshiharaText
	set_active_npc_direction WEST
	print_npc_text Text0ee0
	set_active_npc NPC_ISHIHARAS_VILLA_GR_GAL, DialogRuiText
	print_npc_text Text0ee1
	script_command_02
	move_active_npc NPCMovement_3eccf
	wait_for_player_animation
	script_jump .ows_3ecc6
.ows_3ecc2
	move_active_npc NPCMovement_3ecd2
	wait_for_player_animation
.ows_3ecc6
	unload_npc NPC_ISHIHARAS_VILLA_GR_GAL
	end_script
	ret
NPCMovement_3ecca:
	db SOUTH, MOVE_2
	db EAST, MOVE_0
	db $ff
NPCMovement_3eccf:
	db SOUTH, MOVE_5
	db $ff
NPCMovement_3ecd2:
	db SOUTH, MOVE_7
	db $ff

Func_3ecd5:
	ld a, $01
	farcall GetEventValue
	jr z, .asm_3ece8
	ld a, $83
	farcall GetEventValue
	jr nz, .asm_3ece8
	scf
	ccf
	ret
.asm_3ece8
	scf
	ret

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
	ow_script 5, 9, Func_3426f
	ow_script 6, 9, Func_3426f
	ow_script 6, 2, Func_3ee9e
	ow_script 5, 10, Func_3eec7
	ow_script 6, 10, Func_3eec7
	db $ff

GameCenterEntrance_NPCs:
	npc NPC_GR_CLERK_GAME_CENTER_PRIZE_DESK, 9, 2, SOUTH, $0
	npc NPC_GR_CLERK_GAME_CENTER_CHIP_DESK, 2, 2, SOUTH, $0
	npc NPC_CHIP_GIRL, 5, 2, SOUTH, $0
	npc NPC_CHIP_SECURITY, 4, 9, EAST, $0
	db $ff

GameCenterEntrance_NPCInteractions:
	npc_script NPC_CHIP_GIRL, Func_3ee11
	npc_script NPC_CHIP_SECURITY, Func_3ee83
	db $ff

GameCenterEntrance_OWInteractions:
	ow_script 9, 4, Func_3edb2
	ow_script 2, 4, Func_3edb7
	db $ff

GameCenterEntrance_MapScripts:
	dbw $06, Func_3ed92
	dbw $08, Func_3eda2
	dbw $07, Func_3ed99
	db $ff

Func_3ed92:
	ld hl, GameCenterEntrance_StepEvents
	call Func_324d
	ret

Func_3ed99:
	ld hl, GameCenterEntrance_NPCs
	call Func_3205
	scf
	ccf
	ret

Func_3eda2:
	ld hl, GameCenterEntrance_NPCInteractions
	call Func_328c
	jr nc, .asm_3edb0
	ld hl, GameCenterEntrance_OWInteractions
	call Func_32bf
.asm_3edb0
	scf
	ret

Func_3edb2:
	farcall Func_1d55d
	ret

Func_3edb7:
	ld a, $bf
	ld [wScriptNPC], a
	ld hl, $a5a
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	print_npc_text GameCenterChipDeskWelcomeText
	get_game_center_chips
	compare_loaded_var_word $0000
	script_jump_if_b0z .ows_3edfd
	get_game_center_banked_chips
	compare_loaded_var_word $0000
	script_jump_if_b0z .ows_3ede0
	script_jump .ows_3ee0e
.ows_3ede0
	load_text_ram3
	print_npc_text GameCenterChipDeskDepositInfoText
	npc_ask_question GameCenterChipDeskDepositReturnPromptText, TRUE
	script_jump_if_b0z .ows_3edf7
	print_npc_text GameCenterChipDeskDepositReturnedText
	game_center
	withdraw_chips
	print_npc_text GameCenterChipDeskDepositReminderText
	script_command_71
	script_jump .ows_3ee0e
.ows_3edf7
	print_npc_text GameCenterChipDeskComeAgainText
	script_jump .ows_3ee0e
.ows_3edfd
	load_text_ram3
	game_center
	npc_ask_question GameCenterChipDeskDepositPromptText, TRUE
	script_jump_if_b0z .ows_3ee0a
	deposit_chips
	print_npc_text GameCenterChipDeskDepositedText
.ows_3ee0a
	print_npc_text GameCenterChipDeskComeAgainText
	script_command_71
.ows_3ee0e
	script_command_02
	end_script
	ret

Func_3ee11:
	ld a, $c0
	ld [wScriptNPC], a
	ld hl, $9fa
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	check_event EVENT_GOT_CHIPS_FROM_GAME_CENTER_ATTENDANT
	script_jump_if_b0z .ows_3ee3e
	set_event EVENT_GOT_CHIPS_FROM_GAME_CENTER_ATTENDANT
	print_npc_text GameCenterChipGirlFirstServiceText
	print_text Received10ChipsText
	game_center
	give_chips 10
	print_npc_text GameCenterChipGirlNoticeText
	script_command_71
	script_jump .ows_3ee80
.ows_3ee3e
	get_game_center_chips
	compare_loaded_var_word $0000
	script_jump_if_b0z .ows_3ee7d
	get_game_center_banked_chips
	compare_loaded_var_word $0000
	script_jump_if_b0z .ows_3ee7d
	quit_script
	ld a, [wd584]
	cp $2d
	jr nz, .asm_3ee67
	ld a, $01
	start_script
	print_npc_text GameCenterChipGirlRefillText
	game_center
	give_chips 10
	print_text Received10ChipsText
	script_command_71
	script_jump .ows_3ee80
.asm_3ee67
	ld a, $01
	start_script
	print_npc_text GameCenterChipGirlWelcomeRefillText
	game_center
	give_chips 10
	print_text Received10ChipsText
	script_command_71
	print_npc_text GameCenterChipGirlEnjoyText
	script_jump .ows_3ee80
.ows_3ee7d
	print_npc_text GameCenterChipGirlRefillReminderText
.ows_3ee80
	script_command_02
	end_script
	ret

Func_3ee83:
	ld a, $c1
	ld [wScriptNPC], a
	ld hl, $9fb
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	print_npc_text GameCenterChipSecurityReminderText
	script_command_02
	end_script
	ret

Func_3ee9e:
	farcall GetGameCenterChips
	ld a, b
	or c
	jr nz, .asm_3eec2
	farcall GetGameCenterBankedChips
	ld a, b
	or c
	jr nz, .asm_3eec2
	ld a, $c0
	ld b, $01
	farcall SetOWObjectDirection
	ld a, [wPlayerOWObject]
	ld b, $03
	farcall SetOWObjectDirection
	call Func_3ee11
.asm_3eec2
	farcall Func_c199
	ret

Func_3eec7:
	farcall GetGameCenterChips
	ld a, b
	or c
	jr nz, .asm_3eed4
	farcall Func_c199
	ret
.asm_3eed4
	ld a, $c1
	ld [wScriptNPC], a
	ld hl, $9fb
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	set_active_npc_direction EAST
	print_npc_text GameCenterChipSecurityWarningText
	script_command_02
	animate_player_movement $00, $01
	end_script
	ret

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
	npc NPC_GAME_CENTER_TECH, 10, 4, WEST, $0
	npc NPC_GAME_CENTER_GR_LASS, 8, 9, EAST, $0
	npc NPC_GAME_CENTER_GR_PAPPY, 3, 7, SOUTH, $0
	npc NPC_IMAKUNI_RED, 12, 1, NORTH, Func_3f03d
	npc NPC_GR_CLERK_BATTLE_CENTER, 5, 2, SOUTH, $0
	npc NPC_GR_CLERK_GIFT_CENTER, 8, 2, SOUTH, $0
	db $ff

GameCenterLobby_NPCInteractions:
	npc_script NPC_GAME_CENTER_TECH, Func_3efd6
	npc_script NPC_GAME_CENTER_GR_LASS, Func_3eff1
	npc_script NPC_GAME_CENTER_GR_PAPPY, Func_3f017
	npc_script NPC_IMAKUNI_RED, Func_3c4e0
	db $ff

GameCenterLobby_OWInteractions:
	ow_script 1, 2, PCMenu
	ow_script 2, 2, PCMenu
	ow_script 5, 4, Func_3c1d0
	ow_script 8, 4, Func_3c2d9
	db $ff

GameCenterLobby_MapScripts:
	dbw $06, Func_3ef95
	dbw $08, Func_3efa5
	dbw $09, Func_3efb5
	dbw $0b, Func_3efba
	dbw $07, Func_3ef9c
	dbw $10, Func_3ef80
	db $ff

Func_3ef80:
	ld a, $26
	farcall GetVarValue
	cp $02
	jr z, .asm_3ef8c
	scf
	ret
.asm_3ef8c
	ld a, $24
	farcall PlayAfterCurrentSong
	scf
	ccf
	ret

Func_3ef95:
	ld hl, GameCenterLobby_StepEvents
	call Func_324d
	ret

Func_3ef9c:
	ld hl, GameCenterLobby_NPCs
	call Func_3205
	scf
	ccf
	ret

Func_3efa5:
	ld hl, GameCenterLobby_NPCInteractions
	call Func_328c
	jr nc, .asm_3efb3
	ld hl, GameCenterLobby_OWInteractions
	call Func_32bf
.asm_3efb3
	scf
	ret

Func_3efb5:
	call Func_3c52d
	scf
	ret

Func_3efba:
	ld a, $03
	farcall GetEventValue
	jr z, .asm_3efd4
	ld a, $b1
	farcall ClearOWObject
	ld a, $03
	farcall ZeroOutEventValue
	ld a, [wNextMusic]
	ld [wCurMusic], a
.asm_3efd4
	scf
	ret

Func_3efd6:
	ld a, $a9
	ld [wScriptNPC], a
	ld hl, $a4a
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	print_npc_text Text0d87
	script_command_02
	end_script
	ret

Func_3eff1:
	ld a, $aa
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
	script_jump_if_b0z .ows_3f011
	print_npc_text Text0d88
	script_jump .ows_3f014
.ows_3f011
	print_npc_text Text0d89
.ows_3f014
	script_command_02
	end_script
	ret

Func_3f017:
	ld a, $ab
	ld [wScriptNPC], a
	ld hl, $a3b
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	check_event EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE
	script_jump_if_b0z .ows_3f037
	print_npc_text Text0d8a
	script_jump .ows_3f03a
.ows_3f037
	print_npc_text Text0d8b
.ows_3f03a
	script_command_02
	end_script
	ret

Func_3f03d:
	ld a, $26
	farcall GetVarValue
	cp $02
	jr z, .asm_3f049
	scf
	ret
.asm_3f049
	scf
	ccf
	ret

CardDungeonPawn_MapHeader:
	db MAP_GFX_CARD_DUNGEON_PAWN
	dba CardDungeonPawn_MapScripts
	db MUSIC_FORT_3

CardDungeonPawn_StepEvents:
	map_exit 4, 0, MAP_CARD_DUNGEON_KNIGHT, 4, 8, NORTH
	map_exit 5, 0, MAP_CARD_DUNGEON_KNIGHT, 5, 8, NORTH
	db $ff

CardDungeonPawn_NPCs:
	npc NPC_PAWN, 4, 4, SOUTH, $0
	db $ff

CardDungeonPawn_NPCInteractions:
	npc_script NPC_PAWN, Func_3f0d9
	db $ff

CardDungeonPawn_OWInteractions:
	ow_script 4, 1, Func_3f1de
	ow_script 5, 1, Func_3f1de
	db $ff

CardDungeonPawn_MapScripts:
	dbw $06, Func_3f093
	dbw $08, Func_3f0a3
	dbw $09, Func_3f0d4
	dbw $07, Func_3f09a
	dbw $02, Func_3f0b3
	db $ff

Func_3f093:
	ld hl, CardDungeonPawn_StepEvents
	call Func_324d
	ret

Func_3f09a:
	ld hl, CardDungeonPawn_NPCs
	call Func_3205
	scf
	ccf
	ret

Func_3f0a3:
	ld hl, CardDungeonPawn_NPCInteractions
	call Func_328c
	jr nc, .asm_3f0b1
	ld hl, CardDungeonPawn_OWInteractions
	call Func_32bf
.asm_3f0b1
	scf
	ret

Func_3f0b3:
	ld bc, $43
	ld de, $400
	farcall Func_12c0ce
	ld a, $0a
	ld [wd582], a
	ld a, $0f
	ld [wd592], a
	ld hl, $71c6
	ld a, l
	ld [wd593], a
	ld a, h
	ld [$d594], a
	scf
	ret

Func_3f0d4:
	call Func_3f15d
	scf
	ret

Func_3f0d9:
	ld a, $5e
	ld [wScriptNPC], a
	ld hl, $9fc
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	get_var VAR_3A
	compare_loaded_var $00
	script_jump_if_b0z Script_3f157
	game_center
	check_event EVENT_TALKED_TO_PAWN
	script_jump_if_b0z .ows_3f103
	set_event EVENT_TALKED_TO_PAWN
	print_npc_text PawnWantsToDuelInitialText
	script_jump .ows_3f106
.ows_3f103
	print_npc_text PawnWantsToDuelRepeatText
.ows_3f106
	ask_question PawnDuelPromptText, TRUE
	script_jump_if_b0z .ows_3f13b
	print_text GameCenterCardDungeonBetPromptText
	quit_script
	ld a, $0a
	ld b, $00
	farcall Func_121e1
	jr c, .asm_3f126
	or a
	jr nz, .asm_3f126
	ld a, $01
	start_script
	script_jump .ows_3f12e
.asm_3f126
	ld a, $01
	start_script
	script_jump .ows_3f13b
.ows_3f12e
	take_chips 10
	print_npc_text PawnDuelStartText
	script_command_71
	script_command_02
	start_duel TEST_YOUR_LUCK_DECK_ID, MUSIC_MATCHSTART_1
	end_script
	ret
.ows_3f13b
	print_npc_text PawnDeclinedDuelText
	ask_question PawnQuitDuelPromptText, TRUE
	script_jump_if_b0nz .ows_3f14b
	print_npc_text PawnResumeDuelText
	script_jump .ows_3f106
.ows_3f14b
	set_var VAR_3A, $07
	print_npc_text PawnPlayerQuitText
	script_command_71
	script_command_02
	end_script

SECTION "Bank f@7157", ROMX[$7157], BANK[$f]

Script_3f157:
	print_npc_text PawnProceedRepeatText
	script_command_02
	end_script
	ret

Func_3f15d:
	xor a
	start_script
	script_command_01
	check_event EVENT_SET_UNTIL_MAP_RELOAD_2
	script_jump_if_b0nz .ows_3f17b
	print_npc_text PawnPlayerWon1Text
	game_center
	set_text_ram3 $0014
	print_text ReceivedXChipsText
	give_chips 20
	print_npc_text PawnPlayerWon2Text
	script_command_71
	script_jump .ows_3f186
.ows_3f17b
	set_var VAR_3A, $06
	print_npc_text PawnPlayerLostText
	script_command_02
	end_script
	jp Func_3f1ba
.ows_3f186
	ask_question PawnProceedWithCardDungeonPromptText, TRUE
	script_jump_if_b0z .ows_3f1a2
	set_var VAR_3A, $01
	print_npc_text PawnProceedInitial1Text
	set_active_npc_direction NORTH
	play_sfx SFX_0F
	load_tilemap TILEMAP_044, $04, $00
	print_npc_text PawnProceedInitial2Text
	script_jump .ows_3f1b7
.ows_3f1a2
	print_npc_text PawnDeclinedProceedingText
	ask_question PawnWithdrawFromCardDungeonPromptText, TRUE
	script_jump_if_b0z .ows_3f186
	set_var VAR_3A, $07
	print_npc_text PawnPlayerWithdrewText
	script_command_02
	end_script
	jp Func_3f1ba
.ows_3f1b7
	script_command_02
	end_script
	ret

Func_3f1ba:
	ld a, $2e
	ld de, $603
	ld b, $02
	farcall Func_d3c4
	ret
; 0x3f1c6

SECTION "Bank f@71de", ROMX[$71de], BANK[$f]

Func_3f1de:
	ld a, $3a
	farcall GetVarValue
	or a
	jr nz, .asm_3f1f1
	xor a
	start_script
	script_command_01
	print_text DoorsAreShutText
	script_command_02
	end_script
.asm_3f1f1
	ret

CardDungeonKnight_MapHeader:
	db MAP_GFX_CARD_DUNGEON_KNIGHT
	dba CardDungeonKnight_MapScripts
	db MUSIC_FORT_3

CardDungeonKnight_StepEvents:
	map_exit 4, 0, MAP_CARD_DUNGEON_BISHOP, 4, 8, NORTH
	map_exit 5, 0, MAP_CARD_DUNGEON_BISHOP, 5, 8, NORTH
	db $ff

CardDungeonKnight_NPCs:
	npc NPC_KNIGHT, 4, 3, SOUTH, $0
	db $ff

CardDungeonKnight_NPCInteractions:
	npc_script NPC_KNIGHT, Func_3f27f
	db $ff

CardDungeonKnight_OWInteractions:
	ow_script 4, 1, Func_3f3ad
	ow_script 5, 1, Func_3f3ad
	db $ff

CardDungeonKnight_MapScripts:
	dbw $06, Func_3f239
	dbw $08, Func_3f249
	dbw $09, Func_3f27a
	dbw $07, Func_3f240
	dbw $02, Func_3f259
	db $ff

Func_3f239:
	ld hl, CardDungeonKnight_StepEvents
	call Func_324d
	ret

Func_3f240:
	ld hl, CardDungeonKnight_NPCs
	call Func_3205
	scf
	ccf
	ret

Func_3f249:
	ld hl, CardDungeonKnight_NPCInteractions
	call Func_328c
	jr nc, .asm_3f257
	ld hl, CardDungeonKnight_OWInteractions
	call Func_32bf
.asm_3f257
	scf
	ret

Func_3f259:
	ld bc, $46
	ld de, $400
	farcall Func_12c0ce
	ld a, $0a
	ld [wd582], a
	ld a, $0f
	ld [wd592], a
	ld hl, $7395
	ld a, l
	ld [wd593], a
	ld a, h
	ld [$d594], a
	scf
	ret

Func_3f27a:
	call Func_3f317
	scf
	ret

Func_3f27f:
	ld a, $5f
	ld [wScriptNPC], a
	ld hl, $9fd
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	get_var VAR_3A
	compare_loaded_var $01
	script_jump_if_b0z .ows_3f311
	game_center
	check_event EVENT_TALKED_TO_KNIGHT
	script_jump_if_b0z .ows_3f2a9
	set_event EVENT_TALKED_TO_KNIGHT
	print_npc_text KnightWantsToDuelInitialText
	script_jump .ows_3f2ac
.ows_3f2a9
	print_npc_text KnightWantsToDuelRepeatText
.ows_3f2ac
	ask_question KnightDuelPromptText, TRUE
	script_jump_if_b0z .ows_3f2f5
	print_text GameCenterCardDungeonBetPromptText
	quit_script
	ld a, $06
	ld b, $00
	farcall Func_121e1
	jr c, .asm_3f2cf
	cp $01
	jr z, .asm_3f2cb
	jr nc, .asm_3f2cf
	ld a, $0a
	jr .asm_3f2d7
.asm_3f2cb
	ld a, $14
	jr .asm_3f2d7
.asm_3f2cf
	ld a, $01
	start_script
	script_jump .ows_3f2f5
.asm_3f2d7
	ld h, $00
	ld l, a
	ld [$d615], a
	call LoadTxRam3
	ld c, l
	ld b, h
	farcall DecreaseChipsSmoothly
	ld a, $01
	start_script
	print_npc_text KnightDuelStartText
	script_command_71
	script_command_02
	start_duel PROTOHISTORIC_DECK_ID, MUSIC_MATCHSTART_1
	end_script
	ret
.ows_3f2f5
	print_npc_text KnightDeclinedDuelText
	ask_question KnightQuitDuelPromptText, TRUE
	script_jump_if_b0nz .ows_3f305
	print_npc_text KnightResumeDuelText
	script_jump .ows_3f2ac
.ows_3f305
	set_var VAR_3A, $07
	print_npc_text KnightPlayerQuitText
	script_command_71
	script_command_02
	end_script
	jp Func_3f389
.ows_3f311
	print_npc_text KnightProceedRepeatText
	script_command_02
	end_script
	ret

Func_3f317:
	xor a
	start_script
	script_command_01
	check_event EVENT_SET_UNTIL_MAP_RELOAD_2
	script_jump_if_b0nz .ows_3f34a
	print_npc_text KnightPlayerWon1Text
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
	print_npc_text KnightPlayerWon2Text
	script_command_71
	script_jump .ows_3f355
.ows_3f34a
	set_var VAR_3A, $06
	print_npc_text KnightPlayerLostText
	script_command_02
	end_script
	jp Func_3f389
.ows_3f355
	ask_question KnightProceedWithCardDungeonPromptText, TRUE
	script_jump_if_b0z .ows_3f371
	set_var VAR_3A, $02
	print_npc_text KnightProceedInitial1Text
	set_active_npc_direction NORTH
	play_sfx SFX_0F
	load_tilemap TILEMAP_047, $04, $00
	print_npc_text KnightProceedInitial2Text
	script_jump .ows_3f386
.ows_3f371
	print_npc_text KnightDeclinedProceedingText
	ask_question KnightWithdrawFromCardDungeonPromptText, TRUE
	script_jump_if_b0z .ows_3f355
	set_var VAR_3A, $07
	print_npc_text KnightPlayerWithdrewText
	script_command_02
	end_script
	jp Func_3f389
.ows_3f386
	script_command_02
	end_script
	ret

Func_3f389:
	ld a, $2e
	ld de, $603
	ld b, $02
	farcall Func_d3c4
	ret
; 0x3f395

SECTION "Bank f@73ad", ROMX[$73ad], BANK[$f]

Func_3f3ad:
	ld a, $3a
	farcall GetVarValue
	cp $01
	jr nz, .asm_3f3c1
	xor a
	start_script
	script_command_01
	print_text DoorsAreShutText
	script_command_02
	end_script
.asm_3f3c1
	ret

CardDungeonRook_MapHeader:
	db MAP_GFX_CARD_DUNGEON_ROOK
	dba CardDungeonRook_MapScripts
	db MUSIC_FORT_3

CardDungeonRook_StepEvents:
	map_exit 4, 0, MAP_CARD_DUNGEON_QUEEN, 4, 10, NORTH
	map_exit 5, 0, MAP_CARD_DUNGEON_QUEEN, 5, 10, NORTH
	db $ff

CardDungeonRook_NPCs:
	npc NPC_ROOK, 5, 3, SOUTH, $0
	db $ff

CardDungeonRook_NPCInteractions:
	npc_script NPC_ROOK, Func_3f44f
	db $ff

CardDungeonRook_OWInteractions:
	ow_script 4, 1, Func_3f596
	ow_script 5, 1, Func_3f596
	db $ff

CardDungeonRook_MapScripts:
	dbw $06, Func_3f409
	dbw $08, Func_3f419
	dbw $09, Func_3f44a
	dbw $07, Func_3f410
	dbw $02, Func_3f429
	db $ff

Func_3f409:
	ld hl, CardDungeonRook_StepEvents
	call Func_324d
	ret

Func_3f410:
	ld hl, CardDungeonRook_NPCs
	call Func_3205
	scf
	ccf
	ret

Func_3f419:
	ld hl, CardDungeonRook_NPCInteractions
	call Func_328c
	jr nc, .asm_3f427
	ld hl, CardDungeonRook_OWInteractions
	call Func_32bf
.asm_3f427
	scf
	ret

Func_3f429:
	ld bc, $4c
	ld de, $400
	farcall Func_12c0ce
	ld a, $0a
	ld [wd582], a
	ld a, $0f
	ld [wd592], a
	ld hl, $757e
	ld a, l
	ld [wd593], a
	ld a, h
	ld [$d594], a
	scf
	ret

Func_3f44a:
	call Func_3f500
	scf
	ret

Func_3f44f:
	ld a, $61
	ld [wScriptNPC], a
	ld hl, $9ff
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	get_var VAR_3A
	compare_loaded_var $03
	script_jump_if_b0z .ows_3f4fa
	game_center
	check_event EVENT_TALKED_TO_ROOK
	script_jump_if_b0z .ows_3f479
	set_event EVENT_TALKED_TO_ROOK
	print_npc_text RookWantsToDuelInitialText
	script_jump .ows_3f47c
.ows_3f479
	print_npc_text RookWantsToDuelRepeatText
.ows_3f47c
	ask_question RookDuelPromptText, TRUE
	script_jump_if_b0z .ows_3f4de
.ows_3f483
	print_text GameCenterCardDungeonBetPromptText
	quit_script
	ld a, $08
	ld b, $00
	farcall Func_121e1
	jr c, .asm_3f49f
	cp $01
	jr z, .asm_3f49b
	jr nc, .asm_3f49f
	ld a, $1e
	jr .asm_3f4a7
.asm_3f49b
	ld a, $32
	jr .asm_3f4a7
.asm_3f49f
	ld a, $01
	start_script
	script_jump .ows_3f4de
.asm_3f4a7
	ld h, $00
	ld l, a
	ld [$d615], a
	call LoadTxRam3
	farcall GetGameCenterChips
	ld a, b
	cp h
	jr c, .asm_3f4bc
	jr nz, .asm_3f4bc
	ld a, c
	cp l
.asm_3f4bc
	jr nc, .asm_3f4c9
	ld a, $01
	start_script
	print_npc_text RookNotEnoughChipsText
	script_jump .ows_3f483
.asm_3f4c9
	ld c, l
	ld b, h
	farcall DecreaseChipsSmoothly
	ld a, $01
	start_script
	print_npc_text RookDuelStartText
	script_command_71
	script_command_02
	start_duel COLORLESS_ENERGY_DECK_ID, MUSIC_DITTY_1
	end_script
	ret
.ows_3f4de
	print_npc_text RookDeclinedDuelText
	ask_question RookQuitDuelPromptText, TRUE
	script_jump_if_b0nz .ows_3f4ee
	print_npc_text RookResumeDuelText
	script_jump .ows_3f47c
.ows_3f4ee
	set_var VAR_3A, $07
	print_npc_text RookPlayerQuitText
	script_command_71
	script_command_02
	end_script
	jp Func_3f572
.ows_3f4fa
	print_npc_text RookProceedRepeatText
	script_command_02
	end_script
	ret

Func_3f500:
	xor a
	start_script
	script_command_01
	check_event EVENT_SET_UNTIL_MAP_RELOAD_2
	script_jump_if_b0nz .ows_3f533
	print_npc_text RookPlayerWon1Text
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
	print_npc_text RookPlayerWon2Text
	script_command_71
	script_jump .ows_3f53e
.ows_3f533
	set_var VAR_3A, $06
	print_npc_text RookPlayerLostText
	script_command_02
	end_script
	jp Func_3f572
.ows_3f53e
	ask_question RookProceedWithCardDungeonPromptText, TRUE
	script_jump_if_b0z .ows_3f55a
	set_var VAR_3A, $04
	print_npc_text RookProceedInitial1Text
	set_active_npc_direction NORTH
	play_sfx SFX_0F
	load_tilemap TILEMAP_04D, $04, $00
	print_npc_text RookProceedInitial2Text
	script_jump .ows_3f56f
.ows_3f55a
	print_npc_text RookDeclinedProceedingText
	ask_question RookWithdrawFromCardDungeonPromptText, TRUE
	script_jump_if_b0z .ows_3f53e
	set_var VAR_3A, $07
	print_npc_text RookPlayerWithdrewText
	script_command_02
	end_script
	jp Func_3f572
.ows_3f56f
	script_command_02
	end_script
	ret

Func_3f572:
	ld a, $2e
	ld de, $603
	ld b, $02
	farcall Func_d3c4
	ret
; 0x3f57e

SECTION "Bank f@7596", ROMX[$7596], BANK[$f]

Func_3f596:
	ld a, $3a
	farcall GetVarValue
	cp $03
	jr nz, .asm_3f5aa
	xor a
	start_script
	script_command_01
	print_text DoorsAreShutText
	script_command_02
	end_script
.asm_3f5aa
	ret

WaterFortLobby_MapHeader:
	db MAP_GFX_WATER_FORT_LOBBY
	dba WaterFortLobby_MapScripts
	db MUSIC_FORT_1

WaterFortLobby_StepEvents:
	map_exit 13, 6, MAP_WATER_FORT_ENTRANCE, 1, 3, EAST
	map_exit 13, 7, MAP_WATER_FORT_ENTRANCE, 1, 4, EAST
	db $ff

WaterFortLobby_NPCs:
	npc NPC_WATER_FORT_GLASSES_KID, 10, 10, WEST, Func_3f718
	npc NPC_WATER_FORT_GR_LAD, 10, 10, WEST, Func_3f735
	npc NPC_WATER_FORT_GR_GRANNY, 2, 7, SOUTH, $0
	npc NPC_WATER_FORT_GR_GAL, 5, 9, NORTH, $0
	npc NPC_IMAKUNI_RED, 12, 1, NORTH, Func_3f7a6
	npc NPC_GR_CLERK_BATTLE_CENTER, 5, 2, SOUTH, $0
	npc NPC_GR_CLERK_GIFT_CENTER, 8, 2, SOUTH, $0
	db $ff

WaterFortLobby_NPCInteractions:
	npc_script NPC_WATER_FORT_GLASSES_KID, Func_3f691
	npc_script NPC_WATER_FORT_GR_LAD, Func_3f691
	npc_script NPC_WATER_FORT_GR_GRANNY, Func_3f752
	npc_script NPC_WATER_FORT_GR_GAL, Func_3f780
	npc_script NPC_IMAKUNI_RED, Func_3c4e0
	db $ff

WaterFortLobby_OWInteractions:
	ow_script 1, 2, PCMenu
	ow_script 2, 2, PCMenu
	ow_script 5, 4, Func_3c1d0
	ow_script 8, 4, Func_3c2d9
	db $ff

WaterFortLobby_MapScripts:
	dbw $06, Func_3f650
	dbw $08, Func_3f660
	dbw $09, Func_3f670
	dbw $0b, Func_3f675
	dbw $07, Func_3f657
	dbw $10, Func_3f63b
	db $ff

Func_3f63b:
	ld a, $26
	farcall GetVarValue
	cp $08
	jr z, .asm_3f647
	scf
	ret
.asm_3f647
	ld a, $24
	farcall PlayAfterCurrentSong
	scf
	ccf
	ret

Func_3f650:
	ld hl, WaterFortLobby_StepEvents
	call Func_324d
	ret

Func_3f657:
	ld hl, WaterFortLobby_NPCs
	call Func_3205
	scf
	ccf
	ret

Func_3f660:
	ld hl, WaterFortLobby_NPCInteractions
	call Func_328c
	jr nc, .asm_3f66e
	ld hl, WaterFortLobby_OWInteractions
	call Func_32bf
.asm_3f66e
	scf
	ret

Func_3f670:
	call Func_3c52d
	scf
	ret

Func_3f675:
	ld a, $03
	farcall GetEventValue
	jr z, .asm_3f68f
	ld a, $b1
	farcall ClearOWObject
	ld a, $03
	farcall ZeroOutEventValue
	ld a, [wNextMusic]
	ld [wCurMusic], a
.asm_3f68f
	scf
	ret

Func_3f691:
	ld a, $42
	ld [wScriptNPC], a
	ld hl, $a4f
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	check_event EVENT_TRADED_CARDS_WATER_FORT
	script_jump_if_b0z .ows_3f6f5
	check_event EVENT_TALKED_TO_TRADE_NPC_WATER_FORT
	script_jump_if_b0z .ows_3f6b8
	set_event EVENT_TALKED_TO_TRADE_NPC_WATER_FORT
	print_npc_text Text1255
	script_jump .ows_3f6bb
.ows_3f6b8
	print_npc_text Text1256
.ows_3f6bb
	ask_question TradeCardsPromptText, TRUE
	script_jump_if_b0nz .ows_3f6c8
	print_npc_text Text1257
	script_jump .ows_3f715
.ows_3f6c8
	get_card_count_in_collection_and_decks DARK_BLASTOISE
	script_jump_if_b0z .ows_3f6d4
	print_npc_text Text1258
	script_jump .ows_3f715
.ows_3f6d4
	get_card_count_in_collection DARK_BLASTOISE
	script_jump_if_b0z .ows_3f6e0
	print_npc_text Text1259
	script_jump .ows_3f715
.ows_3f6e0
	print_npc_text Text125a
	receive_card BLASTOISE_ALT_LV52
	take_card DARK_BLASTOISE
	set_event EVENT_TRADED_CARDS_WATER_FORT
	set_event EVENT_SET_UNTIL_MAP_RELOAD_1
	reset_event EVENT_TALKED_TO_TRADE_NPC_WATER_FORT
	print_npc_text Text125b
	script_jump .ows_3f715
.ows_3f6f5
	check_event EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE
	script_jump_if_b0z .ows_3f700
.ows_3f6fa
	print_npc_text Text125c
	script_jump .ows_3f715
.ows_3f700
	check_event EVENT_SET_UNTIL_MAP_RELOAD_1
	script_jump_if_b0z .ows_3f6fa
	check_event EVENT_TALKED_TO_TRADE_NPC_WATER_FORT
	script_jump_if_b0z .ows_3f712
	set_event EVENT_TALKED_TO_TRADE_NPC_WATER_FORT
	print_npc_text Text125d
	script_jump .ows_3f715
.ows_3f712
	print_npc_text Text125e
.ows_3f715
	script_command_02
	end_script
	ret

Func_3f718:
	ld a, $b7
	farcall GetEventValue
	jr z, .asm_3f732
	ld a, $ed
	farcall GetEventValue
	jr nz, .asm_3f732
	ld a, $01
	farcall GetEventValue
	jr z, .asm_3f732
	scf
	ret
.asm_3f732
	scf
	ccf
	ret

Func_3f735:
	ld a, $b7
	farcall GetEventValue
	jr z, .asm_3f74d
	ld a, $ed
	farcall GetEventValue
	jr nz, .asm_3f74d
	ld a, $01
	farcall GetEventValue
	jr nz, .asm_3f74f
.asm_3f74d
	scf
	ret
.asm_3f74f
	scf
	ccf
	ret

Func_3f752:
	ld a, $a2
	ld [wScriptNPC], a
	ld hl, $a3f
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	check_event EVENT_GOT_PSYDUCK_COIN
	script_jump_if_b0nz .ows_3f774
	check_event EVENT_GOT_PSYDUCK_COIN
	script_jump_if_b0nz .ows_3f774
	script_jump .ows_3f77a
.ows_3f774
	print_npc_text Text125f
	script_jump .ows_3f77d
.ows_3f77a
	print_npc_text Text1260
.ows_3f77d
	script_command_02
	end_script
	ret

Func_3f780:
	ld a, $a3
	ld [wScriptNPC], a
	ld hl, $a38
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	check_event EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE
	script_jump_if_b0z .ows_3f7a0
	print_npc_text Text1261
	script_jump .ows_3f7a3
.ows_3f7a0
	print_npc_text Text1262
.ows_3f7a3
	script_command_02
	end_script
	ret

Func_3f7a6:
	ld a, $26
	farcall GetVarValue
	cp $08
	jr z, .asm_3f7b2
	scf
	ret
.asm_3f7b2
	scf
	ccf
	ret

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
	npc NPC_CHEST_CLOSED, 5, 3, SOUTH, Func_3f830
	npc NPC_CHEST_OPENED, 5, 3, SOUTH, Func_3f84b
	db $ff

FightingFortMaze19_NPCInteractions:
	npc_script NPC_CHEST_CLOSED, Func_3f817
	npc_script NPC_CHEST_OPENED, Func_3f83d
	db $ff

FightingFortMaze19_MapScripts:
	dbw $06, Func_3f7ff
	dbw $08, Func_3f80f
	dbw $07, Func_3f806
	db $ff

Func_3f7ff:
	ld hl, FightingFortMaze19_StepEvents
	call Func_324d
	ret

Func_3f806:
	ld hl, FightingFortMaze19_NPCs
	call Func_3205
	scf
	ccf
	ret

Func_3f80f:
	ld hl, FightingFortMaze19_NPCInteractions
	call Func_328c
	scf
	ret

Func_3f817:
	xor a
	start_script
	script_command_01
	set_event EVENT_OPENED_CHEST_FIGHTING_FORT_5
	play_sfx SFX_85
	load_npc NPC_CHEST_OPENED, 5, 3, SOUTH
	unload_npc NPC_CHEST_CLOSED
	print_text OpenedTreasureBoxText
	give_booster_packs BoosterList_ce2f
	script_command_02
	end_script
	ret

Func_3f830:
	ld a, $d7
	farcall GetEventValue
	jr nz, .asm_3f83b
	scf
	ccf
	ret
.asm_3f83b
	scf
	ret

Func_3f83d:
	xor a
	start_script
	script_command_01
	print_text TreasureBoxWasEmptyText
	script_command_02
	end_script
	call Func_3f858
	ret

Func_3f84b:
	ld a, $d7
	farcall GetEventValue
	jr z, .asm_3f856
	scf
	ccf
	ret
.asm_3f856
	scf
	ret

Func_3f858:
	ld a, $3b
	farcall GetVarValue
	cp $03
	jr nz, .asm_3f87b
	ld a, [wd9d5]
	ld b, a
	ld a, [wTextBoxFrameColor]
	ld c, a
	ld a, b
	cp $00
	jr c, .asm_3f874
	jr nz, .asm_3f874
	ld a, c
	cp $03
.asm_3f874
	jr nz, .asm_3f87b
	farcall Func_1352a
	ret
.asm_3f87b
	ld a, $3b
	ld c, $00
	farcall SetVarValue
	ret

FightingFortBasement_MapHeader:
	db MAP_GFX_FIGHTING_FORT_BASEMENT
	dba FightingFortBasement_MapScripts
	db MUSIC_FORT_3

FightingFortBasement_StepEvents:
	map_exit 1, 6, MAP_FIGHTING_FORT, 1, 4, SOUTH
	db $ff

FightingFortBasement_NPCs:
	npc NPC_CHEST_CLOSED, 1, 1, SOUTH, Func_3f925
	npc NPC_CHEST_OPENED, 1, 1, SOUTH, Func_3f951
	db $ff

FightingFortBasement_NPCInteractions:
	npc_script NPC_CHEST_CLOSED, Func_3f90c
	npc_script NPC_CHEST_OPENED, Func_3f932
	db $ff

FightingFortBasement_MapScripts:
	dbw $06, Func_3f8b6
	dbw $08, Func_3f904
	dbw $07, Func_3f8bd
	dbw $02, Func_3f8c6
	db $ff

Func_3f8b6:
	ld hl, FightingFortBasement_StepEvents
	call Func_324d
	ret

Func_3f8bd:
	ld hl, FightingFortBasement_NPCs
	call Func_3205
	scf
	ccf
	ret

Func_3f8c6:
	ld bc, $53
	ld a, $05
	farcall SetwD896
	ld a, [wd584]
	cp $51
	jr nz, .asm_3f8d8
	scf
	ret
.asm_3f8d8
	ld a, $0a
	ld [wd582], a
	ld a, $0f
	ld [wd592], a
	ld hl, $795e
	ld a, l
	ld [wd593], a
	ld a, h
	ld [$d594], a
	ld a, [wPlayerOWObject]
	farcall ResetOWObjectFlag5_WithID
	ld de, $a0f
	farcall SetOWObjectTilePosition
	ld de, $400
	farcall CalcOWScroll
	scf
	ret

Func_3f904:
	ld hl, FightingFortBasement_NPCInteractions
	call Func_328c
	scf
	ret

Func_3f90c:
	xor a
	start_script
	script_command_01
	set_event EVENT_OPENED_CHEST_FIGHTING_FORT_BASEMENT
	play_sfx SFX_85
	load_npc NPC_CHEST_OPENED, 1, 1, SOUTH
	unload_npc NPC_CHEST_CLOSED
	print_text OpenedTreasureBoxText
	receive_card FIGHTING_ENERGY
	script_command_02
	end_script
	ret

Func_3f925:
	ld a, $d8
	farcall GetEventValue
	jr nz, .asm_3f930
	scf
	ccf
	ret
.asm_3f930
	scf
	ret

Func_3f932:
	xor a
	start_script
	script_command_01
	print_text TreasureBoxWasEmptyText
	script_command_02
	end_script
	ld a, $02
	farcall Func_30065
	ld a, [wd584]
	cp $51
	ret z
	ld a, $3b
	ld c, $00
	farcall SetVarValue
	ret

Func_3f951:
	ld a, $d8
	farcall GetEventValue
	jr z, .asm_3f95c
	scf
	ccf
	ret
.asm_3f95c
	scf
	ret
; 0x3f95e
