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
	ld a, MUSIC_HERE_COMES_GR
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

	; do GR Blimp movement
	ld a, NPC_GR_BLIMP
	lb de, 160, 48
	ld b, WEST
	farcall LoadOWObject
	lb de, 120, 48
	ld b, WEST
	call .MoveGRBlimp
	call .DoGRBlimpBeamAnimation
	lb de, 120, 16
	ld b, WEST
	call .MoveGRBlimp
	call .DoGRBlimpBeamAnimation
	lb de, 88, 24
	ld b, WEST
	call .MoveGRBlimp
	call .DoGRBlimpBeamAnimation

	ld a, $01
	farcall ShowProloguePortraitAndText_WithFade

	; load player object in map
	ld a, [wPlayerOWObject]
	lb de, 68, 68
	ld b, SOUTH
	farcall LoadOWObject
	lb de, 64, 48
	ld b, WEST
	call .MoveGRBlimp

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
	call .DoGRBlimpBeamAnimation

	; more GR Blimp movement
	lb de, 32, 64
	ld b, WEST
	call .MoveGRBlimp
	call .DoGRBlimpBeamAnimation
	lb de, 48, 88
	ld b, EAST
	call .MoveGRBlimp
	call .DoGRBlimpBeamAnimation
	lb de, 104, 80
	ld b, EAST
	call .MoveGRBlimp
	call .DoGRBlimpBeamAnimation
	lb de, 80, 92
	ld b, WEST
	call .MoveGRBlimp
	lb de, 80, 120
	ld b, EAST
	call .MoveGRBlimp

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
	lb de, 68, 68
	ld b, SOUTH
	farcall LoadOWObject
	ld a, 30
	call WaitAFrames
	ld a, SFX_PLAYER_WALK_MAP
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
	ld a, SFX_WARP
	call PlaySFX
	ret

; b = direction
; de = target position
.MoveGRBlimp:
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

.DoGRBlimpBeamAnimation:
	ld a, SFX_GR_BLIMP_TRACTOR_BEAM
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
	ld b, TRUE
	farcall _SetOWObjectAnimStruct1Flag2
	lb de, 36, 104
	farcall SetOWObjectTargetPosition
.loop_wait_1
	call DoFrame
	farcall MoveOWObjectToTargetPosition
	jr c, .loop_wait_1
	ld a, [wPlayerOWObject]
	lb de, 12, 104
	farcall SetOWObjectTargetPosition
.loop_wait_2
	call DoFrame
	farcall MoveOWObjectToTargetPosition
	jr c, .loop_wait_2
	ret

Script_TCGBattleCenterClerk:
	ld a, NPC_CLERK_BATTLE_CENTER
	ld [wScriptNPC], a
	ldtx hl, DialogReceptionistText
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [wScriptNPCName + 1], a
	ld a, MUSIC_DUEL_THEME_CLUB_MEMBER
	ld [wDuelTheme], a
	jr Script_BattleCenter

Script_GRBattleCenterClerk:
	ld a, NPC_GR_CLERK_BATTLE_CENTER
	ld [wScriptNPC], a
	ldtx hl, DialogReceptionistText
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [wScriptNPCName + 1], a
	ld a, MUSIC_DUEL_THEME_GR_MEMBER
	ld [wDuelTheme], a
; fallthrough

Script_BattleCenter:
	xor a
	start_script
	start_dialog
	print_npc_text BattleCenterWelcomeText
	ask_question BattleCenterBeginPromptText, TRUE
	script_jump_if_b0z .ows_3c20b
	play_song MUSIC_CARD_POP
	send_mail $1c
	end_dialog
	link_duel
	script_jump_if_b1nz .ows_3c204
	script_call .ows_3c211
	script_jump .ows_3c20b
.ows_3c204
	start_dialog
	print_npc_text BattleCenterThankYouText
	script_jump .ows_3c20e
.ows_3c20b
	print_npc_text BattleCenterComeAgainText
.ows_3c20e
	end_dialog
	end_script
	ret
.ows_3c211
	start_dialog
	check_event EVENT_SET_UNTIL_MAP_RELOAD_2
	script_jump_if_b0nz .ows_3c242
	script_call .ows_3c2c1
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
	script_call .ows_3c290
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
	call EnableSRAM
	ld a, [sLinkDuelCounter]
	ld c, a
	ld a, [sLinkDuelCounter + 1]
	ld b, a
	call DisableSRAM
	cp16bc_long 50
	jr z, .asm_3c280
	ld a, $01
	start_script
	script_ret
.asm_3c280
	ld a, $01
	start_script
	set_event EVENT_GOT_RAICHU_COIN
	print_npc_text BattleCenter50WinsRewardsText
	give_coin COIN_RAICHU
	print_npc_text BattleCenterAppreciateContinuedSupportText
	script_ret
.ows_3c290
	quit_script
	call EnableSRAM
	ld a, [sLinkDuelCounter]
	ld c, a
	ld a, [sLinkDuelCounter + 1]
	ld b, a
	call DisableSRAM
	cp16bc_long 100
	jr z, .asm_3c2b1
	ld a, $01
	start_script
	script_ret
.asm_3c2b1
	ld a, $01
	start_script
	set_event EVENT_GOT_LUGIA_COIN
	print_npc_text BattleCenter100WinsRewardsText
	give_coin COIN_LUGIA
	print_npc_text BattleCenterAppreciateContinuedSupportText
	script_ret
.ows_3c2c1
	check_event EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE
	script_jump_if_b0nz .ows_3c2d8
	get_var VAR_TIMES_WON_LINK_DUEL_FOR_GRAND_MASTER_CUP
	compare_loaded_var MAX_NUM_LINK_DUEL_WINS_FOR_GRAND_MASTER_CUP
	script_jump_if_b1z .ows_3c2d8
	inc_var VAR_TIMES_WON_LINK_DUEL_FOR_GRAND_MASTER_CUP
	get_var VAR_TIMES_WON_LINK_DUEL_FOR_GRAND_MASTER_CUP
	compare_loaded_var 5
	script_jump_if_b0z .ows_3c2d8
	send_mail $0f
.ows_3c2d8
	script_ret

Script_GiftCenter:
	ld a, EVENT_F2
	farcall ZeroOutEventValue
	farcall GiftCenter
	ld a, EVENT_F2
	farcall GetEventValue
	jr z, .done
	farcall PlayCurrentSong
.done
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
	ld a, NPC_IMAKUNI_BLACK
	ld [wScriptNPC], a
	ldtx hl, DialogImakuniText
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [wScriptNPCName + 1], a
	xor a
	start_script
	start_dialog
	get_var VAR_21
	compare_loaded_var $02
	script_jump_if_b1nz .ows_3c333
	script_jump_if_b0nz .ows_3c37f
	compare_loaded_var $03
	script_jump_if_b0nz .ows_3c3a5
	script_jump .ows_3c3ae
.ows_3c333
	set_var VAR_21, $02
	set_var VAR_25, $0f
	print_npc_text ImakuniBlackCardlessFirstCardPopText
	card_pop SCRIPTED_CARD_POP_IMAKUNI
	print_npc_text ImakuniBlackCardlessAfterFirstCardPopSaveText
	quit_script
	ld a, EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE_DUMMY
	farcall MaxOutEventValue
	farcall _SaveGame
	ld a, EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE_DUMMY
	farcall ZeroOutEventValue
	ld a, $01
	start_script
	play_sfx SFX_SAVE_GAME
	print_text SavedDataText
	print_npc_text ImakuniBlackCardlessAfterFirstCardPopResultText
	end_dialog
	get_player_direction
	compare_loaded_var SOUTH
	script_jump_if_b0z .ows_3c36b
	set_player_direction WEST
	animate_player_movement $81, $02
.ows_3c36b
	move_active_npc NPCMovement_3c492
	wait_for_player_animation
	unload_npc NPC_IMAKUNI_BLACK
	end_script
	ld a, OWMODE_IDLE
	ld [wOverworldMode], a
	ld a, [wNextMusic]
	farcall PlayAfterCurrentSong
	ret
.ows_3c37f
	set_var VAR_25, $0f
	print_npc_text ImakuniBlackCardlessAfterFirstCardPopRepeatText
	end_dialog
	get_player_direction
	compare_loaded_var SOUTH
	script_jump_if_b0z .ows_3c391
	set_player_direction WEST
	animate_player_movement $81, $02
.ows_3c391
	move_active_npc NPCMovement_3c492
	wait_for_player_animation
	unload_npc NPC_IMAKUNI_BLACK
	end_script
	ld a, OWMODE_IDLE
	ld [wOverworldMode], a
	ld a, [wNextMusic]
	farcall PlayAfterCurrentSong
	ret
.ows_3c3a5
	set_var VAR_21, $04
	print_npc_text ImakuniBlackWantsToDuelFirstEncounterText
	script_jump .ows_3c3b4
.ows_3c3ae
	print_npc_text ImakuniBlackWantsToDuelRepeatText
	script_jump .ows_3c3b4
.ows_3c3b4
	ask_question ImakuniBlackDuelPromptText, TRUE
	script_jump_if_b0z .ows_3c3c4
	print_npc_text ImakuniBlackDuelStartText
	end_dialog
	start_duel WEIRD_DECK_ID, MUSIC_MATCH_START_MEMBER
	end_script
	ret
.ows_3c3c4
	print_npc_text ImakuniBlackDeclinedDuelText
	end_dialog
	end_script
	ret

Script_ImakuniBlackAfterDuel:
	xor a
	start_script
	start_dialog
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
	end_dialog
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
	ld a, OWMODE_IDLE
	ld [wOverworldMode], a
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
	ld a, EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE_DUMMY
	farcall MaxOutEventValue
	farcall _SaveGame
	ld a, EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE_DUMMY
	farcall ZeroOutEventValue
	ld a, $01
	start_script
	play_sfx SFX_SAVE_GAME
	print_text SavedDataText
	print_npc_text Text12d5
	end_dialog
	get_player_direction
	compare_loaded_var NORTH
	script_jump_if_b0z .ows_3c4cc
	set_player_direction EAST
	animate_player_movement $83, $02
.ows_3c4cc
	move_active_npc NPCMovement_3c5fe
	wait_for_player_animation
	unload_npc NPC_IMAKUNI_RED
	end_script
	ld a, OWMODE_IDLE
	ld [wOverworldMode], a
	ld a, [wNextMusic]
	farcall PlayAfterCurrentSong
	ret

Func_3c4e0:
	ld a, NPC_IMAKUNI_RED
	ld [wScriptNPC], a
	ldtx hl, DialogImakuniText
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [wScriptNPCName + 1], a
	xor a
	start_script
	start_dialog
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
	end_dialog
	start_duel STRANGE_DECK_ID, MUSIC_MATCH_START_MEMBER
	end_script
	ret
.ows_3c527
	print_npc_text Text12da
	end_dialog
	end_script
	ret

Func_3c52d:
	xor a
	start_script
	start_dialog
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
	end_dialog
	get_player_direction
	compare_loaded_var NORTH
	script_jump_if_b0z .ows_3c583
	set_player_direction EAST
	animate_player_movement $83, $02
.ows_3c583
	move_active_npc NPCMovement_3c5fe
	wait_for_player_animation
	unload_npc NPC_IMAKUNI_RED
	end_script
	ld a, OWMODE_IDLE
	ld [wOverworldMode], a
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
	npc NPC_LAB_TECH_AUTO_DECK_MACHINE_1, 4, 3, SOUTH, NULL
	npc NPC_LAB_TECH_DECK_SAVE_MACHINE, 7, 3, SOUTH, NULL
	npc NPC_LAB_TECH_COMPUTER_ROOM, 3, 8, NORTH, NULL
	npc NPC_LAB_TECH_AUTO_DECK_MACHINE_2, 7, 9, EAST, NULL
	db $ff

MasonLaboratoryComputerRoom_NPCInteractions:
	npc_script NPC_LAB_TECH_AUTO_DECK_MACHINE_1, Func_3c739
	npc_script NPC_LAB_TECH_DECK_SAVE_MACHINE, Func_3c75f
	npc_script NPC_LAB_TECH_COMPUTER_ROOM, Func_3c77a
	npc_script NPC_LAB_TECH_AUTO_DECK_MACHINE_2, Func_3c7ab
	db $ff

MasonLaboratoryComputerRoom_OWInteractions:
	ow_script 2,  3, Script_AutoDeckMachine1
	ow_script 3,  3, Script_AutoDeckMachine1
	ow_script 8, 10, Script_AutoDeckMachine2
	ow_script 9, 10, Script_AutoDeckMachine2
	ow_script 8,  3, Script_DeckSaveMachine
	ow_script 9,  3, Script_DeckSaveMachine
	db $ff

MasonLaboratoryComputerRoom_MapScripts:
	dbw OWMODE_STEP_EVENT, Func_3c689
	dbw OWMODE_INTERACT, Func_3c6b3
	dbw OWMODE_NPC_POSITION, Func_3c690
	dbw OWMODE_WARP_FADE_IN_PRELOAD, Func_3c697
	db $ff

Func_3c689:
	ld hl, MasonLaboratoryComputerRoom_StepEvents
	call ExecutePlayerCoordScript
	ret

Func_3c690:
	ld hl, MasonLaboratoryComputerRoom_NPCs
	call LoadNPCs
	ret

Func_3c697:
	ld a, EVENT_GOT_GOLBAT_COIN
	farcall GetEventValue
	jr z, .asm_3c6b1
	ld a, NPC_LAB_TECH_AUTO_DECK_MACHINE_2
	ld b, WEST
	farcall SetOWObjectDirection
	ld bc, TILEMAP_008
	lb de, 7, 7
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

Script_AutoDeckMachine1:
	xor a
	start_script
	start_dialog
	print_text ItsAutoDeckMachine1Text
	ask_question AutoDeckMachine1PromptText, TRUE
	script_jump_if_b0z .cancel
	end_dialog
	end_script
	call PauseSong
	ld a, MUSIC_DECK_MACHINE
	call PlaySong
	xor a ; TCG_ISLAND
	farcall AutoDeckMachine
	call ResumeSong
	ret
.cancel
	end_dialog
	end_script
	ret

Script_AutoDeckMachine2:
	ld a, EVENT_GOT_GOLBAT_COIN
	farcall GetEventValue
	ret z
	xor a
	start_script
	start_dialog
	print_text ItsAutoDeckMachine2Text
	ask_question AutoDeckMachine1PromptText, TRUE
	script_jump_if_b0z .cancel
	end_dialog
	end_script
	call PauseSong
	ld a, MUSIC_DECK_MACHINE
	call PlaySong
	ld a, GR_ISLAND
	farcall AutoDeckMachine
	call ResumeSong
	ret
.cancel
	end_dialog
	end_script
	ret

Script_DeckSaveMachine:
	xor a
	start_script
	start_dialog
	print_text ItsDeckSaveMachineText
	ask_question DeckSaveMachinePromptText, TRUE
	script_jump_if_b0z .cancel
	end_dialog
	end_script
	call PauseSong
	ld a, MUSIC_DECK_MACHINE
	call PlaySong
	farcall Func_1e849
	call ResumeSong
	ret
.cancel
	end_dialog
	end_script
	ret

Func_3c739:
	ld a, NPC_LAB_TECH_AUTO_DECK_MACHINE_1
	ld [wScriptNPC], a
	ldtx hl, DialogTechText
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [wScriptNPCName + 1], a
	xor a
	start_script
	start_dialog
	check_event EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE
	script_jump_if_b0z .ows_3c759
	print_npc_text Text0ef2
	script_jump .ows_3c75c
.ows_3c759
	print_npc_text Text0ef3
.ows_3c75c
	end_dialog
	end_script
	ret

Func_3c75f:
	ld a, NPC_LAB_TECH_DECK_SAVE_MACHINE
	ld [wScriptNPC], a
	ldtx hl, DialogTechText
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [wScriptNPCName + 1], a
	xor a
	start_script
	start_dialog
	print_npc_text Text0ef4
	end_dialog
	end_script
	ret

Func_3c77a:
	ld a, NPC_LAB_TECH_COMPUTER_ROOM
	ld [wScriptNPC], a
	ldtx hl, DialogTechText
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [wScriptNPCName + 1], a
	xor a
	start_script
	start_dialog
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
	end_dialog
	end_script
	ret

Func_3c7ab:
	ld a, NPC_LAB_TECH_AUTO_DECK_MACHINE_2
	ld [wScriptNPC], a
	ldtx hl, DialogTechText
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [wScriptNPCName + 1], a
	xor a
	start_script
	start_dialog
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
	end_dialog
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
	npc NPC_AARON, 11, 2, NORTH, NULL
	npc NPC_LAB_TECH_TRAINING_ROOM, 10, 11, EAST, NULL
	db $ff

MasonLaboratoryTrainingRoom_NPCInteractions:
	npc_script NPC_AARON, Func_3c84c
	npc_script NPC_LAB_TECH_TRAINING_ROOM, Func_3ca4d
	db $ff

MasonLaboratoryTrainingRoom_MapScripts:
	dbw OWMODE_STEP_EVENT, Func_3c817
	dbw OWMODE_INTERACT, Func_3c825
	dbw OWMODE_AFTER_DUEL, Func_3c82d
	dbw OWMODE_NPC_POSITION, Func_3c81e
	db $ff

Func_3c817:
	ld hl, MasonLaboratoryTrainingRoom_StepEvents
	call ExecutePlayerCoordScript
	ret

Func_3c81e:
	ld hl, MasonLaboratoryTrainingRoom_NPCs
	call LoadNPCs
	ret

Func_3c825:
	ld hl, MasonLaboratoryTrainingRoom_NPCInteractions
	call Func_328c
	scf
	ret

Func_3c82d:
	ld hl, MasonLaboratoryTrainingRoom_AfterDuelScripts
	ld a, VAR_3B
	farcall GetVarValue
	call ExecuteNPCScript
	scf
	ret

; use VAR_3B instead of npc id
MasonLaboratoryTrainingRoom_AfterDuelScripts:
	npc_script AARON_STEP_1, Func_3c931
	npc_script AARON_STEP_2, Func_3c97e
	npc_script AARON_STEP_3, Func_3c9cb
	npc_script AARON_STEP_4, Func_3ca28
	db $ff

Func_3c84c:
	ld a, NPC_AARON
	ld [wScriptNPC], a
	ldtx hl, DialogAaronText
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [wScriptNPCName + 1], a
	xor a
	start_script
	start_dialog
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
	farcall HandlePopupMenu
	jr c, .asm_3c90a
	or a
	jp z, Func_3c917
	jr .asm_3c90a
.ows_3c8b3
	print_npc_text Text0f3f
	quit_script
	ld a, $03
	ld b, $00
	farcall HandlePopupMenu
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
	farcall HandlePopupMenu
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
	farcall HandlePopupMenu
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
	end_dialog
	end_script
	ret

Func_3c917:
	ld a, $01
	start_script
	print_npc_text Text0f42
	end_dialog
	script_call Script_3ca68
	start_dialog
	print_npc_text Text0f43
	end_dialog
	set_var VAR_3B, AARON_STEP_1
	start_duel AARONS_STEP1_DECK_ID, MUSIC_MATCH_START_MEMBER
	end_script
	ret

Func_3c931:
	xor a
	start_script
	start_dialog
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
	end_dialog
	move_active_npc .NPCMovement_3c95f
	wait_for_player_animation
	set_active_npc_position_and_direction 11, 2, NORTH
	end_script
	ret
.NPCMovement_3c95f:
	db EAST, MOVE_4
	db NORTH, MOVE_2
	db $ff

Func_3c964:
	ld a, $01
	start_script
	print_npc_text Text0f47
	end_dialog
	script_call Script_3cab1
	start_dialog
	print_npc_text Text0f48
	end_dialog
	set_var VAR_3B, AARON_STEP_2
	start_duel AARONS_STEP2_DECK_ID, MUSIC_MATCH_START_MEMBER
	end_script
	ret

Func_3c97e:
	xor a
	start_script
	start_dialog
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
	end_dialog
	move_active_npc .NPCMovement_3c9ac
	wait_for_player_animation
	set_active_npc_position_and_direction 11, 2, NORTH
	end_script
	ret
.NPCMovement_3c9ac:
	db NORTH, MOVE_1
	db EAST, MOVE_6
	db $ff

Func_3c9b1:
	ld a, $01
	start_script
	print_npc_text Text0f4b
	end_dialog
	script_call Script_3cb06
	start_dialog
	print_npc_text Text0f4c
	end_dialog
	set_var VAR_3B, AARON_STEP_3
	start_duel AARONS_STEP3_DECK_ID, MUSIC_MATCH_START_MEMBER
	end_script
	ret

Func_3c9cb:
	xor a
	start_script
	start_dialog
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
	end_dialog
	move_active_npc .NPCMovement_3c9fd
	wait_for_player_animation
	set_active_npc_position_and_direction 11, 2, NORTH
	end_script
	ret
.NPCMovement_3c9fd:
	db NORTH, MOVE_1
	db EAST, MOVE_6
	db $ff

Func_3ca02:
	ld a, $01
	start_script
	print_npc_text Text0f51
	end_dialog
	script_call Script_3cb4b
	start_dialog
	print_npc_text Text0f52
	end_dialog
	set_var VAR_3B, AARON_STEP_4
	get_random $02
	compare_loaded_var $00
	script_jump_if_b0z .ows_3ca23
	start_duel BRICK_WALK_DECK_ID, MUSIC_MATCH_START_MEMBER
	end_script
	ret
.ows_3ca23
	start_duel BENCH_TRAP_DECK_ID, MUSIC_MATCH_START_MEMBER
	end_script
	ret

Func_3ca28:
	xor a
	start_script
	start_dialog
	check_event EVENT_SET_UNTIL_MAP_RELOAD_2
	script_jump_if_b0nz .ows_3ca3e
	print_npc_text Text0f53
	give_booster_packs BoosterList_cca7
	print_npc_text Text0f54
	script_jump .ows_3ca41
.ows_3ca3e
	print_npc_text Text0f55
.ows_3ca41
	end_dialog
	move_active_npc .NPCMovement_3ca48
	wait_for_player_animation
	end_script
	ret
.NPCMovement_3ca48:
	db EAST, MOVE_4
	db NORTH, MOVE_0
	db $ff

Func_3ca4d:
	ld a, NPC_LAB_TECH_TRAINING_ROOM
	ld [wScriptNPC], a
	ldtx hl, DialogTechText
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [wScriptNPCName + 1], a
	xor a
	start_script
	start_dialog
	print_npc_text Text0f56
	end_dialog
	end_script
	ret

Script_3ca68:
	get_player_direction
	compare_loaded_var WEST
	script_jump_if_b0nz .ows_3ca81
	compare_loaded_var NORTH
	script_jump_if_b0nz .ows_3ca7a
	move_player .NPCMovement_3ca94, TRUE
	script_jump .ows_3ca85
.ows_3ca7a
	move_player .NPCMovement_3ca9b, TRUE
	script_jump .ows_3ca85
.ows_3ca81
	move_player .NPCMovement_3caa6, TRUE
.ows_3ca85
	move_npc NPC_AARON, .NPCMovement_3ca8b
	wait_for_player_animation
	script_ret
.NPCMovement_3ca8b:
	db WEST, MOVE_2
	db SOUTH, MOVE_5
	db WEST, MOVE_2
	db SOUTH, MOVE_0
	db $ff
.NPCMovement_3ca94:
	db SOUTH, MOVE_8
	db WEST, MOVE_3
	db NORTH, MOVE_0
	db $ff
.NPCMovement_3ca9b:
	db SOUTH, MOVE_3
	db WEST, MOVE_1
	db SOUTH, MOVE_4
	db WEST, MOVE_3
	db NORTH, MOVE_0
	db $ff
.NPCMovement_3caa6:
	db SOUTH, MOVE_6
	db WEST, MOVE_2
	db SOUTH, MOVE_2
	db WEST, MOVE_3
	db NORTH, MOVE_0
	db $ff

Script_3cab1:
	get_player_direction
	compare_loaded_var WEST
	script_jump_if_b0nz .ows_3caca
	compare_loaded_var NORTH
	script_jump_if_b0nz .ows_3cac3
	move_player .NPCMovement_3cadd, TRUE
	script_jump .ows_3cace
.ows_3cac3
	move_player .NPCMovement_3cae8, TRUE
	script_jump .ows_3cace
.ows_3caca
	move_player .NPCMovement_3caf7, TRUE
.ows_3cace
	move_npc NPC_AARON, .NPCMovement_3cad4
	wait_for_player_animation
	script_ret
.NPCMovement_3cad4:
	db WEST, MOVE_2
	db SOUTH, MOVE_4
	db WEST, MOVE_5
	db SOUTH, MOVE_1
	db $ff
.NPCMovement_3cadd:
	db SOUTH, MOVE_8
	db WEST, MOVE_1
	db SOUTH, MOVE_1
	db WEST, MOVE_5
	db NORTH, MOVE_1
	db $ff
.NPCMovement_3cae8:
	db SOUTH, MOVE_3
	db WEST, MOVE_1
	db SOUTH, MOVE_4
	db WEST, MOVE_1
	db SOUTH, MOVE_1
	db WEST, MOVE_5
	db NORTH, MOVE_1
	db $ff
.NPCMovement_3caf7:
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
	compare_loaded_var WEST
	script_jump_if_b0nz .ows_3cb1f
	compare_loaded_var NORTH
	script_jump_if_b0nz .ows_3cb18
	move_player .NPCMovement_3cb32, TRUE
	script_jump .ows_3cb23
.ows_3cb18
	move_player .NPCMovement_3cb39, TRUE
	script_jump .ows_3cb23
.ows_3cb1f
	move_player .NPCMovement_3cb40, TRUE
.ows_3cb23
	move_npc NPC_AARON, .NPCMovement_3cb29
	wait_for_player_animation
	script_ret
.NPCMovement_3cb29:
	db WEST, MOVE_2
	db NORTH, MOVE_1
	db WEST, MOVE_5
	db SOUTH, MOVE_1
	db $ff
.NPCMovement_3cb32:
	db SOUTH, MOVE_4
	db WEST, MOVE_6
	db NORTH, MOVE_1
	db $ff
.NPCMovement_3cb39:
	db SOUTH, MOVE_3
	db WEST, MOVE_7
	db NORTH, MOVE_1
	db $ff
.NPCMovement_3cb40:
	db SOUTH, MOVE_2
	db WEST, MOVE_1
	db SOUTH, MOVE_2
	db WEST, MOVE_7
	db NORTH, MOVE_1
	db $ff

Script_3cb4b:
	get_player_direction
	compare_loaded_var WEST
	script_jump_if_b0nz .ows_3cb64
	compare_loaded_var NORTH
	script_jump_if_b0nz .ows_3cb5d
	move_player .NPCMovement_3cb73, TRUE
	script_jump .ows_3cb68
.ows_3cb5d
	move_player .NPCMovement_3cb7a, TRUE
	script_jump .ows_3cb68
.ows_3cb64
	move_player .NPCMovement_3cb81, TRUE
.ows_3cb68
	move_npc NPC_AARON, .NPCMovement_3cb6e
	wait_for_player_animation
	script_ret
.NPCMovement_3cb6e:
	db WEST, MOVE_4
	db SOUTH, MOVE_0
	db $ff
.NPCMovement_3cb73:
	db SOUTH, MOVE_3
	db WEST, MOVE_3
	db NORTH, MOVE_0
	db $ff
.NPCMovement_3cb7a:
	db SOUTH, MOVE_2
	db WEST, MOVE_4
	db NORTH, MOVE_0
	db $ff
.NPCMovement_3cb81:
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
	dbw OWMODE_STEP_EVENT, Func_3cbf4
	dbw OWMODE_WARP_FADE_IN_PRELOAD, Func_3cbfb
	dbw OWMODE_CONTINUE_OW, Func_3cc37
	dbw OWMODE_MUSIC_PRELOAD, Func_3cbd4
	dbw OWMODE_MUSIC_POSTLOAD, Func_3cbe4
	db $ff

Func_3cbd4:
	ld a, EVENT_GOT_PIKACHU_COIN
	farcall GetEventValue
	jr nz, .asm_3cbe1
	ld a, MUSIC_HERE_COMES_GR
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
	ld a, MUSIC_RONALD
	farcall PlayAfterCurrentSong
	scf
	ccf
	ret

Func_3cbf4:
	ld hl, LightningClubEntrance_StepEvents
	call ExecutePlayerCoordScript
	ret

Func_3cbfb:
	ld a, EVENT_SET_UNTIL_MAP_RELOAD_1
	farcall GetEventValue
	jr nz, .asm_3cc0b
	ld a, EVENT_GOT_PIKACHU_COIN
	farcall GetEventValue
	jr nz, .asm_3cc35
.asm_3cc0b
	ld bc, TILEMAP_00C
	lb de, 1, 0
	farcall Func_12c0ce
	call Func_3cc53
	jr c, .asm_3cc35
	ldtx hl, DialogGR4Text
	call LoadTxRam2
	ld a, OWMODE_SCRIPT
	ld [wOverworldMode], a
	ld a, BANK(Func_340a4)
	ld [wOverworldScriptBank], a
	ld hl, Func_340a4
	ld a, l
	ld [wOverworldScriptPointer], a
	ld a, h
	ld [wOverworldScriptPointer + 1], a
.asm_3cc35
	scf
	ret

Func_3cc37:
	ld a, EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE_DUMMY
	farcall GetEventValue
	jr z, .asm_3cc51
	ld a, NPC_RONALD
	farcall ClearOWObject
	ld a, EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE_DUMMY
	farcall ZeroOutEventValue
	ld a, [wNextMusic]
	ld [wCurMusic], a
.asm_3cc51
	scf
	ret

Func_3cc53:
	ld a, VAR_TIMES_MET_RONALD
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
	npc NPC_LIGHTNING_CLUB_LASS, 11, 2, NORTH, NULL
	npc NPC_LIGHTNING_CLUB_PUNK_KID, 9, 4, SOUTH, NULL
	npc NPC_LIGHTNING_CLUB_LONGHAIRED_LASS, 5, 6, EAST, Func_3ce9b
	npc NPC_LIGHTNING_CLUB_GR_LASS, 5, 6, EAST, Func_3cea8
	npc NPC_LIGHTNING_CLUB_BRO, 8, 9, WEST, NULL
	npc NPC_CLERK_BATTLE_CENTER, 2, 2, SOUTH, NULL
	npc NPC_CLERK_GIFT_CENTER, 4, 2, SOUTH, NULL
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
	ow_script 2, 4, Script_TCGBattleCenterClerk
	ow_script 4, 4, Script_GiftCenter
	ow_script 12, 2, Script_LightningPokemonBook
	ow_script 13, 2, Script_LightningPokemonDeckBuildingBook
	ow_script 14, 2, Script_BirdPokemonBook
	db $ff

LightningClubLobby_MapScripts:
	dbw OWMODE_STEP_EVENT, Func_3cd2b
	dbw OWMODE_INTERACT, Func_3cd3b
	dbw OWMODE_NPC_POSITION, Func_3cd32
	dbw OWMODE_MUSIC_PRELOAD, Func_3cd1b
	db $ff

Func_3cd1b:
	ld a, EVENT_GOT_PIKACHU_COIN
	farcall GetEventValue
	jr nz, .asm_3cd28
	ld a, MUSIC_HERE_COMES_GR
	ld [wNextMusic], a
.asm_3cd28
	scf
	ccf
	ret

Func_3cd2b:
	ld hl, LightningClubLobby_StepEvents
	call ExecutePlayerCoordScript
	ret

Func_3cd32:
	ld hl, LightningClubLobby_NPCs
	call LoadNPCs
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
	ld a, NPC_JENNIFER
	ld [wScriptNPC], a
	ldtx hl, DialogJenniferText
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [wScriptNPCName + 1], a
	xor a
	start_script
	start_dialog
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
	end_dialog
	end_script
	ret

Func_3cd7e:
	ld a, NPC_BRANDON
	ld [wScriptNPC], a
	ldtx hl, DialogBrandonText
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [wScriptNPCName + 1], a
	xor a
	start_script
	start_dialog
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
	end_dialog
	end_script
	ret

Func_3cdb1:
	ld a, EVENT_SET_UNTIL_MAP_RELOAD_1
	farcall GetEventValue
	jr nz, .asm_3cdc3
	ld a, EVENT_GOT_PIKACHU_COIN
	farcall GetEventValue
	jr z, .asm_3cdc3
	scf
	ret
.asm_3cdc3
	scf
	ccf
	ret

Func_3cdc6:
	ld a, NPC_LIGHTNING_CLUB_LASS
	ld [wScriptNPC], a
	ldtx hl, DialogLassText
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [wScriptNPCName + 1], a
	xor a
	start_script
	start_dialog
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
	end_dialog
	end_script
	ret

Func_3ce39:
	ld a, NPC_LIGHTNING_CLUB_PUNK_KID
	ld [wScriptNPC], a
	ldtx hl, DialogPunkKidText
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [wScriptNPCName + 1], a
	xor a
	start_script
	start_dialog
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
	end_dialog
	end_script
	ret

Func_3ce6a:
	ld a, NPC_LIGHTNING_CLUB_LONGHAIRED_LASS
	ld [wScriptNPC], a
	ldtx hl, DialogLonghairedKidText
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [wScriptNPCName + 1], a
	xor a
	start_script
	start_dialog
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
	end_dialog
	end_script
	ret

Func_3ce9b:
	ld a, EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE
	farcall GetEventValue
	jr z, .asm_3cea5
	scf
	ret
.asm_3cea5
	scf
	ccf
	ret

Func_3cea8:
	ld a, EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE
	farcall GetEventValue
	jr nz, .asm_3ceb2
	scf
	ret
.asm_3ceb2
	scf
	ccf
	ret

Func_3ceb5:
	ld a, NPC_LIGHTNING_CLUB_BRO
	ld [wScriptNPC], a
	ldtx hl, DialogBroText
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [wScriptNPCName + 1], a
	xor a
	start_script
	start_dialog
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
	end_dialog
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
	npc NPC_CLERK_BATTLE_CENTER, 2, 2, SOUTH, NULL
	npc NPC_CLERK_GIFT_CENTER, 4, 2, SOUTH, NULL
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
	ow_script 2, 4, Script_TCGBattleCenterClerk
	ow_script 4, 4, Script_GiftCenter
	ow_script 12, 2, Script_PlantlikePokemonBook
	ow_script 13, 2, Script_GrassPokemonBreederBook
	ow_script 14, 2, Script_GrassPokemonDeckBuildingBook
	db $ff

GrassClubLobby_MapScripts:
	dbw OWMODE_STEP_EVENT, Func_3cfa8
	dbw OWMODE_INTERACT, Func_3cfb8
	dbw OWMODE_NPC_POSITION, Func_3cfaf
	dbw OWMODE_AFTER_DUEL, Func_3cfc8
	dbw OWMODE_MUSIC_PRELOAD, Func_3cf98
	db $ff

Func_3cf98:
	ld a, EVENT_GOT_GR_COIN_PIECE_TOP_RIGHT
	farcall GetEventValue
	jr nz, .asm_3cfa5
	ld a, MUSIC_HERE_COMES_GR
	ld [wNextMusic], a
.asm_3cfa5
	scf
	ccf
	ret

Func_3cfa8:
	ld hl, GrassClubLobby_StepEvents
	call ExecutePlayerCoordScript
	ret

Func_3cfaf:
	ld hl, GrassClubLobby_NPCs
	call LoadNPCs
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
	call ExecuteNPCScript
	scf
	ret

GrassClubLobby_AfterDuelScripts:
	npc_script NPC_BRITTANY, Func_3d02b
	db $ff

Func_3cfd8:
	ld a, NPC_BRITTANY
	ld [wScriptNPC], a
	ldtx hl, DialogBrittanyText
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [wScriptNPCName + 1], a
	xor a
	start_script
	start_dialog
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
	end_dialog
	start_duel REMAINING_GREEN_DECK_ID, MUSIC_MATCH_START_MEMBER
	end_script
	ret
.ows_3d023
	print_npc_text Text0e7f
	set_active_npc_direction WEST
	end_dialog
	end_script
	ret

Func_3d02b:
	xor a
	start_script
	start_dialog
	check_event EVENT_SET_UNTIL_MAP_RELOAD_2
	script_jump_if_b0nz .ows_3d05c
	print_npc_text Text0e80
	give_booster_packs BoosterList_cccd
	check_event EVENT_GOT_ODDISH_COIN
	script_jump_if_b0z .ows_3d056
	check_event EVENT_BEAT_BRITTANY
	script_jump_if_b0z .ows_3d050
	set_event EVENT_BEAT_BRITTANY
	set_var VAR_ISHIHARA_STATE, ISHIHARA_HELPING_NIKKI
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
	end_dialog
	end_script
	ret

Func_3d064:
	ld a, NPC_KRISTIN
	ld [wScriptNPC], a
	ldtx hl, DialogKristinText
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [wScriptNPCName + 1], a
	xor a
	start_script
	start_dialog
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
	end_dialog
	end_script
	ret
.ows_3d0a2
	print_npc_text Text0e89
	end_dialog
	end_script
	ret

Func_3d0a8:
	ld a, NPC_HEATHER
	ld [wScriptNPC], a
	ldtx hl, DialogHeatherText
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [wScriptNPCName + 1], a
	xor a
	start_script
	start_dialog
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
	end_dialog
	end_script
	ret
.ows_3d0e6
	print_npc_text Text0e8e
	end_dialog
	end_script
	ret

Func_3d0ec:
	ld a, EVENT_SET_UNTIL_MAP_RELOAD_1
	farcall GetEventValue
	jr nz, .asm_3d0fe
	ld a, EVENT_GOT_GR_COIN_PIECE_TOP_RIGHT
	farcall GetEventValue
	jr z, .asm_3d0fe
	scf
	ret
.asm_3d0fe
	scf
	ccf
	ret

Func_3d101:
	ld a, NPC_GRASS_CLUB_GRANNY
	ld [wScriptNPC], a
	ldtx hl, DialogGrannyText
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [wScriptNPCName + 1], a
	xor a
	start_script
	start_dialog
	check_event EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE
	script_jump_if_b0z .ows_3d121
	print_npc_text Text0e8f
	script_jump .ows_3d124
.ows_3d121
	print_npc_text Text0e90
.ows_3d124
	end_dialog
	end_script
	ret

Func_3d127:
	ld a, NPC_GRASS_CLUB_LASS
	ld [wScriptNPC], a
	ldtx hl, DialogLassText
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [wScriptNPCName + 1], a
	xor a
	start_script
	start_dialog
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
	end_dialog
	end_script
	ret

Func_3d158:
	ld a, NPC_GRASS_CLUB_CAPPED_LASS
	ld [wScriptNPC], a
	ldtx hl, DialogCappedKidText
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [wScriptNPCName + 1], a
	xor a
	start_script
	start_dialog
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
	end_dialog
	end_script
	ret

Func_3d189:
	ld a, EVENT_SET_UNTIL_MAP_RELOAD_1
	farcall GetEventValue
	jr nz, .asm_3d19c
	ld a, EVENT_GOT_GR_COIN_PIECE_TOP_RIGHT
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
	npc NPC_CLERK_TCG_CHALLENGE_HALL_ENTRANCE, 3, 1, SOUTH, NULL
	db $ff

TcgChallengeHallEntrance_NPCInteractions:
	npc_script NPC_CLERK_TCG_CHALLENGE_HALL_ENTRANCE, Script_TCGChallengeHallEntranceClerk
	db $ff

TcgChallengeHallEntrance_MapScripts:
	dbw OWMODE_STEP_EVENT, Func_3d259
	dbw OWMODE_INTERACT, Func_3d269
	dbw OWMODE_NPC_POSITION, Func_3d260
	dbw OWMODE_MUSIC_PRELOAD, Func_3d1f6
	dbw OWMODE_WARP_FADE_OUT_PRELOAD, Func_3d210
	db $ff

Func_3d1f6:
	ld a, VAR_TCG_CHALLENGE_CUP_STATE
	farcall GetVarValue
	cp CHALLENGE_CUP_1_START
	jr z, .active
	cp CHALLENGE_CUP_2_START
	jr z, .active
	cp CHALLENGE_CUP_3_START
	jr nz, .inactive
.active
	ld a, MUSIC_CHALLENGE_HALL
	ld [wNextMusic], a
.inactive
	scf
	ccf
	ret

Func_3d210:
	ld a, [wTempPrevMap]
	cp OVERWORLD_MAP_TCG
	jr nz, .done
	ld a, VAR_TCG_CHALLENGE_CUP_STATE
	farcall GetVarValue
	cp CHALLENGE_CUP_1_START
	jr z, .active
	cp CHALLENGE_CUP_2_START
	jr z, .active
	cp CHALLENGE_CUP_3_START
	jr nz, .done
.active
	ld a, VAR_TCG_CHALLENGE_CUP_RESULT
	farcall GetVarValue
	cp CHALLENGE_CUP_RESULT_WON
	push af
	ld a, VAR_TCG_CHALLENGE_CUP_RESULT
	farcall ZeroOutVarValue
	pop af
	jr nz, .done
; cup winner, so switch the cup state from start to end
; by incrementing if cup 1, 2
; or by (verbosely) decremmenting if cup 3
; due to the constants' ordering
	ld a, VAR_TCG_CHALLENGE_CUP_STATE
	farcall GetVarValue
	cp CHALLENGE_CUP_3_START
	jr z, .won_cup3
	inc a
	ld c, a
	ld a, VAR_TCG_CHALLENGE_CUP_STATE
	farcall SetVarValue
	jr .done
.won_cup3
	ld a, VAR_TCG_CHALLENGE_CUP_STATE
	ld c, CHALLENGE_CUP_3_UNLOCKED
	farcall SetVarValue
.done
	scf
	ret

Func_3d259:
	ld hl, TcgChallengeHallEntrance_StepEvents
	call ExecutePlayerCoordScript
	ret

Func_3d260:
	ld hl, TcgChallengeHallEntrance_NPCs
	call LoadNPCs
	scf
	ccf
	ret

Func_3d269:
	ld hl, TcgChallengeHallEntrance_NPCInteractions
	call Func_328c
	scf
	ret

Script_TCGChallengeHallEntranceClerk:
	ld a, NPC_CLERK_TCG_CHALLENGE_HALL_ENTRANCE
	ld [wScriptNPC], a
	ldtx hl, DialogReceptionistText
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [wScriptNPCName + 1], a
	xor a
	start_script
	start_dialog
	get_var VAR_TCG_CHALLENGE_CUP_RESULT
	compare_loaded_var CHALLENGE_CUP_RESULT_NONE
	script_jump_if_b0z .tcg_cup_played
	get_var VAR_TCG_CHALLENGE_CUP_STATE
	compare_loaded_var CHALLENGE_CUP_3_UNLOCKED
	script_jump_if_b0nz .tcg_cup3_inactive
	script_jump_if_b1z .tcg_cup3_active
	compare_loaded_var CHALLENGE_CUP_2_START
	script_jump_if_b0nz .tcg_cup2_active
	script_jump_if_b1z .tcg_cup2_over
	compare_loaded_var CHALLENGE_CUP_1_START
	script_jump_if_b0nz .tcg_cup1_active
	script_jump_if_b1z .tcg_cup1_over
	print_npc_text TCGChallengeHallEntranceClerkNoCardsText
	script_jump .done
.tcg_cup1_active
	print_npc_text TCGChallengeHallEntranceClerkTCGCup1ActiveText
	script_jump .done
.tcg_cup1_over
	print_npc_text TCGChallengeHallEntranceClerkTCGCup1OverText
	script_jump .done
.tcg_cup2_active
	print_npc_text TCGChallengeHallEntranceClerkTCGCup2ActiveText
	script_jump .done
.tcg_cup2_over
	print_npc_text TCGChallengeHallEntranceClerkTCGCup2OverText
	script_jump .done
.tcg_cup3_inactive
	print_npc_text TCGChallengeHallEntranceClerkTCGCup3InactiveText
	script_jump .done
.tcg_cup3_active
	print_npc_text TCGChallengeHallEntranceClerkTCGCup3ActiveText
	script_jump .done
.tcg_cup_played
	print_npc_text TCGChallengeHallEntranceClerkTCGCupPlayedText
.done
	end_dialog
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
	npc NPC_TCG_CHALLENGE_HALL_CHAP, 10, 4, SOUTH, NULL
	npc NPC_CUP_HOST, 7, 9, EAST, TcgChallengeHallLobby_DisappearDuringTCGCups
	npc NPC_TCG_CHALLENGE_HALL_PUNK, 5, 6, EAST, TcgChallengeHallLobby_DisappearDuringTCGCups
	npc NPC_TCG_CHALLENGE_HALL_PAPPY, 4, 9, EAST, TcgChallengeHallLobby_AppearDuringTCGCups
	npc NPC_TCG_CHALLENGE_HALL_TECH, 9, 10, NORTH, TcgChallengeHallLobby_AppearDuringTCGCups
	npc NPC_TCG_CHALLENGE_HALL_GIRL, 13, 9, WEST, TcgChallengeHallLobby_AppearDuringTCGCups
	npc NPC_CLERK_BATTLE_CENTER, 2, 2, SOUTH, NULL
	npc NPC_CLERK_GIFT_CENTER, 4, 2, SOUTH, NULL
	db $ff

TcgChallengeHallLobby_NPCInteractions:
	npc_script NPC_TCG_CHALLENGE_HALL_CHAP, Func_3d3c0
	npc_script NPC_CUP_HOST, Script_CupHostTCGLobby
	npc_script NPC_TCG_CHALLENGE_HALL_PUNK, Func_3d511
	npc_script NPC_TCG_CHALLENGE_HALL_PAPPY, Func_3d539
	npc_script NPC_TCG_CHALLENGE_HALL_TECH, Func_3d56d
	npc_script NPC_TCG_CHALLENGE_HALL_GIRL, Func_3d588
	db $ff

TcgChallengeHallLobby_OWInteractions:
	ow_script 8, 2, PCMenu
	ow_script 9, 2, PCMenu
	ow_script 2, 4, Script_TCGBattleCenterClerk
	ow_script 4, 4, Script_GiftCenter
	ow_script 12, 2, Script_ColorlessPokemonBook
	ow_script 13, 2, Script_CardPopBook
	ow_script 14, 2, Script_EnergyCardColorsBook
	db $ff

TcgChallengeHallLobby_MapScripts:
	dbw OWMODE_STEP_EVENT, Func_3d3a0
	dbw OWMODE_INTERACT, Func_3d3b0
	dbw OWMODE_NPC_POSITION, Func_3d3a7
	dbw OWMODE_MUSIC_PRELOAD, Func_3d386
	db $ff

Func_3d386:
	ld a, VAR_TCG_CHALLENGE_CUP_STATE
	farcall GetVarValue
	cp CHALLENGE_CUP_1_START
	jr z, .active
	cp CHALLENGE_CUP_2_START
	jr z, .active
	cp CHALLENGE_CUP_3_START
	jr nz, .inactive
.active
	ld a, MUSIC_CHALLENGE_HALL
	ld [wNextMusic], a
.inactive
	scf
	ccf
	ret

Func_3d3a0:
	ld hl, TcgChallengeHallLobby_StepEvents
	call ExecutePlayerCoordScript
	ret

Func_3d3a7:
	ld hl, TcgChallengeHallLobby_NPCs
	call LoadNPCs
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
	ld a, NPC_TCG_CHALLENGE_HALL_CHAP
	ld [wScriptNPC], a
	ldtx hl, DialogChap2Text
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [wScriptNPCName + 1], a
	xor a
	start_script
	start_dialog
	check_event EVENT_TRADED_CARDS_TCG_CHALLENGE_HALL
	script_jump_if_b0nz .ows_3d3ee
	check_event EVENT_B1
	script_jump_if_b0nz .ows_3d43b
	check_event EVENT_B2
	script_jump_if_b0nz .ows_3d493
	check_event EVENT_SET_UNTIL_MAP_RELOAD_1
	print_variable_npc_text Text0992, Text0993
	end_dialog
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
	end_dialog
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
	end_dialog
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
	end_dialog
	end_script
	ret

Script_CupHostTCGLobby:
	ld a, NPC_CUP_HOST
	ld [wScriptNPC], a
	ldtx hl, DialogCupHostText
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [wScriptNPCName + 1], a
	xor a
	start_script
	start_dialog
	get_var VAR_TCG_CHALLENGE_CUP_STATE
	compare_loaded_var CHALLENGE_CUP_DEAD
	script_jump_if_b0z .tcg_cup_unlocked
	print_npc_text TCGChallengeHallLobbyCupHostNoCardsText
	script_jump .done
.tcg_cup_unlocked
	print_npc_text TCGChallengeHallLobbyCupHostStandbyText
.done
	end_dialog
	end_script
	ret

Func_3d511:
	ld a, NPC_TCG_CHALLENGE_HALL_PUNK
	ld [wScriptNPC], a
	ldtx hl, DialogPunkText
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [wScriptNPCName + 1], a
	xor a
	start_script
	start_dialog
	get_var VAR_TCG_CHALLENGE_CUP_STATE
	compare_loaded_var CHALLENGE_CUP_DEAD
	script_jump_if_b0z .ows_3d533
	print_npc_text Text09ad
	script_jump .ows_3d536
.ows_3d533
	print_npc_text Text09ae
.ows_3d536
	end_dialog
	end_script
	ret

Func_3d539:
	ld a, NPC_TCG_CHALLENGE_HALL_PAPPY
	ld [wScriptNPC], a
	ldtx hl, DialogPappy2Text
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [wScriptNPCName + 1], a
	xor a
	start_script
	start_dialog
	get_var VAR_TCG_CHALLENGE_CUP_RESULT
	compare_loaded_var CHALLENGE_CUP_RESULT_LOST
	script_jump_if_b0nz .ows_3d561
	get_var VAR_TCG_CHALLENGE_CUP_STATE
	compare_loaded_var CHALLENGE_CUP_3_START
	print_variable_npc_text Text09af, Text09b0
	script_jump .ows_3d56a
.ows_3d561
	get_var VAR_TCG_CHALLENGE_CUP_STATE
	compare_loaded_var CHALLENGE_CUP_3_START
	print_variable_npc_text Text09b1, Text09b2
.ows_3d56a
	end_dialog
	end_script
	ret

Func_3d56d:
	ld a, NPC_TCG_CHALLENGE_HALL_TECH
	ld [wScriptNPC], a
	ldtx hl, DialogTechText
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [wScriptNPCName + 1], a
	xor a
	start_script
	start_dialog
	print_npc_text Text09b3
	end_dialog
	end_script
	ret

Func_3d588:
	ld a, NPC_TCG_CHALLENGE_HALL_GIRL
	ld [wScriptNPC], a
	ldtx hl, DialogCappedKidText
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [wScriptNPCName + 1], a
	xor a
	start_script
	start_dialog
	print_npc_text Text09b4
	end_dialog
	end_script
	ret

TcgChallengeHallLobby_DisappearDuringTCGCups:
	ld a, VAR_TCG_CHALLENGE_CUP_STATE
	farcall GetVarValue
	cp CHALLENGE_CUP_1_START
	jr z, .disappear
	cp CHALLENGE_CUP_2_START
	jr z, .disappear
	cp CHALLENGE_CUP_3_START
	jr z, .disappear
	scf
	ccf
	ret
.disappear
	scf
	ret

TcgChallengeHallLobby_AppearDuringTCGCups:
	ld a, VAR_TCG_CHALLENGE_CUP_STATE
	farcall GetVarValue
	cp CHALLENGE_CUP_1_START
	jr z, .appear
	cp CHALLENGE_CUP_2_START
	jr z, .appear
	cp CHALLENGE_CUP_3_START
	jr z, .appear
	scf
	ret
.appear
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
	npc NPC_COURTNEY, 3, 6, EAST, PokemonDome_CourtneyAppearanceCheck
	npc NPC_STEVE, 9, 6, EAST, PokemonDome_SteveAppearanceCheck
	npc NPC_JACK, 12, 6, WEST, PokemonDome_JackAppearanceCheck
	npc NPC_ROD, 6, 6, SOUTH, PokemonDome_RodAppearanceCheck
	npc NPC_GR_5, 7, 8, SOUTH, PokemonDome_DisappearAfterGRCoin
	npc NPC_TCG_CUP_CLERK_LEFT, 7, 4, SOUTH, PokemonDome_AppearDuringGrandMasterCup
	npc NPC_TCG_CUP_CLERK_RIGHT, 8, 4, SOUTH, PokemonDome_AppearDuringGrandMasterCup
	npc NPC_POKEMON_DOME_GR_LASS, 4, 12, EAST, PokemonDome_AppearDuringGrandMasterCup
	npc NPC_POKEMON_DOME_YOUNGSTER, 9, 8, SOUTH, PokemonDome_AppearDuringGrandMasterCup
	npc NPC_POKEMON_DOME_SWIMMER, 2, 5, EAST, PokemonDome_AppearDuringGrandMasterCup
	db $ff

PokemonDome_NPCInteractions:
	npc_script NPC_COURTNEY, Script_Courtney
	npc_script NPC_STEVE, Script_Steve
	npc_script NPC_JACK, Script_Jack
	npc_script NPC_ROD, Script_Rod
	npc_script NPC_GR_5, Script_GR5_PokemonDome
	npc_script NPC_TCG_CUP_CLERK_LEFT, Script_GrandMasterCupClerk
	npc_script NPC_TCG_CUP_CLERK_RIGHT, Script_GrandMasterCupClerk
	npc_script NPC_POKEMON_DOME_GR_LASS, Script_PokemonDomeGRLass
	npc_script NPC_POKEMON_DOME_YOUNGSTER, Script_PokemonDomeYoungster
	npc_script NPC_POKEMON_DOME_SWIMMER, Script_PokemonDomeSwimmer
	db $ff

PokemonDome_OWInteractions:
	ow_script 7, 1, Script_PokemonDomeArenaDoors
	ow_script 8, 1, Script_PokemonDomeArenaDoors
	db $ff

PokemonDome_MapScripts:
	dbw OWMODE_STEP_EVENT, Func_3d6ba
	dbw OWMODE_INTERACT, Func_3d740
	dbw OWMODE_AFTER_DUEL, Func_3d750
	dbw OWMODE_NPC_POSITION, Func_3d6c1
	dbw OWMODE_WARP_FADE_IN_PRELOAD, Func_3d6ca
	dbw OWMODE_WARP_FADE_OUT_PRELOAD, Func_3d719
	dbw OWMODE_WARP_END_SFX, Func_3d734
	dbw OWMODE_MUSIC_PRELOAD, Func_3d67b
	db $ff

Func_3d67b:
	ld a, EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE
	farcall GetEventValue
	jr nz, .check_grand_master_cup
	ld a, EVENT_FREED_ROD
	farcall GetEventValue
	jr nz, .cup_active
	ld a, EVENT_GOT_GR_COIN
	farcall GetEventValue
	jr nz, .done
; under gr control
	ld a, MUSIC_HERE_COMES_GR
	ld [wNextMusic], a
	jr .done
.cup_active
	ld a, MUSIC_POKEMON_DOME
	ld [wNextMusic], a
	jr .done
.check_grand_master_cup
	ld a, VAR_GRAND_MASTER_CUP_STATE
	farcall GetVarValue
	cp GRAND_MASTER_CUP_ACTIVE
	jr c, .done
	cp GRAND_MASTER_CUP_PLAYING
	jr c, .cup_active
	ld a, EVENT_SET_UNTIL_MAP_RELOAD_1
	farcall GetEventValue
	jr nz, .cup_active
.done
	scf
	ccf
	ret

Func_3d6ba:
	ld hl, PokemonDome_StepEvents
	call ExecutePlayerCoordScript
	ret

Func_3d6c1:
	ld hl, PokemonDome_NPCs
	call LoadNPCs
	scf
	ccf
	ret

Func_3d6ca:
	ld bc, TILEMAP_037
	lb de, 7, 0
	farcall Func_12c0ce
	ld a, [wPrevMap]
	cp MAP_POKEMON_DOME_BACK
	jr z, .cup_played
	scf
	ret
.cup_played
	ld a, EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE
	farcall GetEventValue
	jr nz, .after_grand_master_cup
; after final cup
	ld a, OWMODE_SCRIPT
	ld [wOverworldMode], a
	ld a, BANK(Script_RodAfterFinalCup)
	ld [wOverworldScriptBank], a
	ld hl, Script_RodAfterFinalCup
	ld a, l
	ld [wOverworldScriptPointer], a
	ld a, h
	ld [wOverworldScriptPointer + 1], a
	jr .loaded_ow_script
.after_grand_master_cup
	ld a, OWMODE_SCRIPT
	ld [wOverworldMode], a
	ld a, BANK(Script_GrandMasterCupClerkAfterTournament)
	ld [wOverworldScriptBank], a
	ld hl, Script_GrandMasterCupClerkAfterTournament
	ld a, l
	ld [wOverworldScriptPointer], a
	ld a, h
	ld [wOverworldScriptPointer + 1], a
.loaded_ow_script
	ld a, $00
	call Func_338f
	scf
	ccf
	ret

Func_3d719:
	ld a, [wTempPrevMap]
	cp MAP_POKEMON_DOME_BACK
	jr z, .cup_played
	scf
	ret
.cup_played
	ld a, EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE
	farcall GetEventValue
	jr nz, .after_grand_master_cup
	scf
	ret
.after_grand_master_cup
	ld a, $00
	call Func_33a3
	scf
	ccf
	ret

Func_3d734:
	ld a, [wTempPrevMap]
	cp MAP_POKEMON_DOME_BACK
	jr z, .silent
	scf
	ret
.silent
	scf
	ccf
	ret

Func_3d740:
	ld hl, PokemonDome_NPCInteractions
	call Func_328c
	jr nc, .done
	ld hl, PokemonDome_OWInteractions
	call Func_32bf
.done
	scf
	ret

Func_3d750:
	ld hl, PokemonDome_AfterDuelScripts
	ld a, [wScriptNPC]
	call ExecuteNPCScript
	scf
	ret

PokemonDome_AfterDuelScripts:
	npc_script NPC_COURTNEY, Script_CourtneyAfterDuel
	npc_script NPC_STEVE, Script_SteveAfterDuel
	npc_script NPC_JACK, Script_JackAfterDuel
	db $ff

Script_Courtney:
	ld a, NPC_COURTNEY
	ld [wScriptNPC], a
	ldtx hl, DialogCourtneyText
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [wScriptNPCName + 1], a
	xor a
	start_script
	start_dialog
	check_event EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE
	script_jump_if_b0z .postgame
	check_event EVENT_FREED_ROD
	script_jump_if_b0z .final_cup
	check_event EVENT_TALKED_TO_COURTNEY_POKEMON_DOME
	script_jump_if_b0z .repeat
	set_event EVENT_TALKED_TO_COURTNEY_POKEMON_DOME
	print_npc_text CourtneyWantsToDuelInitialText
	script_jump .duel_prompt
.repeat
	print_npc_text CourtneyWantsToDuelRepeatText
.duel_prompt
	ask_question CourtneyDuelPromptText, TRUE
	script_jump_if_b0z .declined
	print_npc_text CourtneyDuelStartText
	end_dialog
	start_duel GRAND_FIRE_DECK_ID, MUSIC_MATCH_START_GRAND_MASTER
	end_script
	ret
.declined
	print_npc_text CourtneyDeclinedDuelText
	end_dialog
	end_script
	ret
.final_cup
	print_npc_text CourtneyReadyForFinalCupText
	end_dialog
	end_script
	ret
.postgame
	check_event EVENT_TALKED_TO_COURTNEY_POKEMON_DOME
	script_jump_if_b0z .postgame_repeat
	set_event EVENT_TALKED_TO_COURTNEY_POKEMON_DOME
	print_npc_text CourtneyPostgameInitialText
	script_jump .postgame_done
.postgame_repeat
	print_npc_text CourtneyPostgameRepeatText
.postgame_done
	end_dialog
	end_script
	ret

Script_CourtneyAfterDuel:
	xor a
	start_script
	start_dialog
	check_event EVENT_SET_UNTIL_MAP_RELOAD_2
	script_jump_if_b0nz .player_lost
	print_npc_text CourtneyPlayerWon1Text
	give_booster_packs BoosterList_Courtney
	print_npc_text CourtneyPlayerWon2Text
	script_jump .done
.player_lost
	print_npc_text CourtneyPlayerLostText
.done
	end_dialog
	end_script
	ret

PokemonDome_CourtneyAppearanceCheck:
	ld a, EVENT_FREED_COURTNEY
	farcall GetEventValue
	jr z, .disappear
	ld a, EVENT_SET_UNTIL_MAP_RELOAD_1
	farcall GetEventValue
	jr nz, .disappear
	ld a, VAR_GRAND_MASTER_CUP_STATE
	farcall GetVarValue
	cp GRAND_MASTER_CUP_ACTIVE
	jr z, .disappear
	cp GRAND_MASTER_CUP_ACTIVE_PRIZES_SET
	jr z, .disappear
	scf
	ccf
	ret
.disappear
	scf
	ret

Script_Steve:
	ld a, NPC_STEVE
	ld [wScriptNPC], a
	ldtx hl, DialogSteveText
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [wScriptNPCName + 1], a
	xor a
	start_script
	start_dialog
	check_event EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE
	script_jump_if_b0z .postgame
	check_event EVENT_FREED_ROD
	script_jump_if_b0z .final_cup
	check_event EVENT_TALKED_TO_STEVE_POKEMON_DOME
	script_jump_if_b0z .repeat
	set_event EVENT_TALKED_TO_STEVE_POKEMON_DOME
	print_npc_text SteveWantsToDuelInitialText
	script_jump .duel_prompt
.repeat
	print_npc_text SteveWantsToDuelRepeatText
.duel_prompt
	ask_question SteveDuelPromptText, TRUE
	script_jump_if_b0z .declined
	print_npc_text SteveDuelStartText
	end_dialog
	start_duel LEGENDARY_FOSSIL_DECK_ID, MUSIC_MATCH_START_GRAND_MASTER
	end_script
	ret
.declined
	print_npc_text SteveDeclinedDuelText
	end_dialog
	end_script
	ret
.final_cup
	check_event EVENT_WON_FINAL_CUP
	print_variable_npc_text SteveReadyForFinalCupText, SteveReadyForNextFinalCupText
	end_dialog
	end_script
	ret
.postgame
	check_event EVENT_TALKED_TO_STEVE_POKEMON_DOME
	script_jump_if_b0z .postgame_repeat
	set_event EVENT_TALKED_TO_STEVE_POKEMON_DOME
	print_npc_text StevePostgameInitialText
	script_jump .postgame_done
.postgame_repeat
	get_var VAR_GRAND_MASTER_CUP_STATE
	compare_loaded_var NONE
	print_variable_npc_text StevePostgameRepeatText, SteveGrandMasterCupPlayedText
.postgame_done
	end_dialog
	end_script
	ret

Script_SteveAfterDuel:
	xor a
	start_script
	start_dialog
	check_event EVENT_SET_UNTIL_MAP_RELOAD_2
	script_jump_if_b0nz .player_lost
	print_npc_text StevePlayerWon1Text
	give_booster_packs BoosterList_Steve
	print_npc_text StevePlayerWon2Text
	script_jump .done
.player_lost
	print_npc_text StevePlayerLostText
.done
	end_dialog
	end_script
	ret

PokemonDome_SteveAppearanceCheck:
	ld a, EVENT_FREED_STEVE
	farcall GetEventValue
	jr z, .disappear
	ld a, EVENT_SET_UNTIL_MAP_RELOAD_1
	farcall GetEventValue
	jr nz, .disappear
	ld a, VAR_GRAND_MASTER_CUP_STATE
	farcall GetVarValue
	cp GRAND_MASTER_CUP_ACTIVE
	jr z, .disappear
	cp GRAND_MASTER_CUP_ACTIVE_PRIZES_SET
	jr z, .disappear
	scf
	ccf
	ret
.disappear
	scf
	ret

Script_Jack:
	ld a, NPC_JACK
	ld [wScriptNPC], a
	ldtx hl, DialogJackText
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [wScriptNPCName + 1], a
	xor a
	start_script
	start_dialog
	check_event EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE
	script_jump_if_b0z .postgame
	check_event EVENT_FREED_ROD
	script_jump_if_b0z .final_cup
	check_event EVENT_TALKED_TO_JACK_POKEMON_DOME
	script_jump_if_b0z .repeat
	set_event EVENT_TALKED_TO_JACK_POKEMON_DOME
	print_npc_text JackWantsToDuelInitialText
	script_jump .duel_prompt
.repeat
	print_npc_text JackWantsToDuelRepeatText
.duel_prompt
	ask_question JackDuelPromptText, TRUE
	script_jump_if_b0z .declined
	print_npc_text JackDuelStartText
	end_dialog
	start_duel WATER_LEGEND_DECK_ID, MUSIC_MATCH_START_GRAND_MASTER
	end_script
	ret
.declined
	print_npc_text JackDeclinedDuelText
	end_dialog
	end_script
	ret
.final_cup
	print_npc_text JackReadyForFinalCupText
	end_dialog
	end_script
	ret
.postgame
	check_event EVENT_TALKED_TO_JACK_POKEMON_DOME
	script_jump_if_b0z .postgame_repeat
	set_event EVENT_TALKED_TO_JACK_POKEMON_DOME
	print_npc_text JackPostgameInitialText
	script_jump .postgame_done
.postgame_repeat
	get_var VAR_GRAND_MASTER_CUP_STATE
	compare_loaded_var NONE
	print_variable_npc_text JackPostgameRepeatText, JackGrandMasterCupPlayedText
.postgame_done
	end_dialog
	end_script
	ret

Script_JackAfterDuel:
	xor a
	start_script
	start_dialog
	check_event EVENT_SET_UNTIL_MAP_RELOAD_2
	script_jump_if_b0nz .player_lost
	print_npc_text JackPlayerWon1Text
	give_booster_packs BoosterList_Jack
	print_npc_text JackPlayerWon2Text
	script_jump .done
.player_lost
	print_npc_text JackPlayerLostText
.done
	end_dialog
	end_script
	ret

PokemonDome_JackAppearanceCheck:
	ld a, EVENT_FREED_JACK
	farcall GetEventValue
	jr z, .disappear
	ld a, EVENT_SET_UNTIL_MAP_RELOAD_1
	farcall GetEventValue
	jr nz, .disappear
	ld a, VAR_GRAND_MASTER_CUP_STATE
	farcall GetVarValue
	cp GRAND_MASTER_CUP_ACTIVE
	jr z, .disappear
	cp GRAND_MASTER_CUP_ACTIVE_PRIZES_SET
	jr z, .disappear
	scf
	ccf
	ret
.disappear
	scf
	ret

Script_Rod:
	ld a, NPC_ROD
	ld [wScriptNPC], a
	ldtx hl, DialogRodText
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [wScriptNPCName + 1], a
	xor a
	start_script
	start_dialog
	check_event EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE
	script_jump_if_b0z .postgame
	check_event EVENT_WON_FINAL_CUP
	script_jump_if_b0z .final_cup_again
	check_event EVENT_ENTERED_GRAND_MASTER_CUP
	script_jump_if_b0z .repeat
	set_event EVENT_ENTERED_GRAND_MASTER_CUP
	print_npc_text RodWantsToStartFinalCupInitialText
	script_jump .enter_prompt
.repeat
	print_npc_text RodWantsToStartFinalCupRepeatText
	script_jump .enter_prompt
.final_cup_again
	print_npc_text RodWantsToStartNextFinalCupText
.enter_prompt
	ask_question FinalCupEnterPrompt, TRUE
	script_jump_if_b0z .declined
	print_npc_text RodFinalCupEnterAcceptedPrompt
	end_dialog
	script_jump Script_MoveGrandMastersAndPlayerIntoFinalCup
.declined
	print_npc_text RodFinalCupEnterDeclinedPrompt
	end_dialog
	end_script
	ret
.postgame
	check_event EVENT_ENTERED_GRAND_MASTER_CUP
	script_jump_if_b0z .check_cup_state
	set_event EVENT_ENTERED_GRAND_MASTER_CUP
	print_npc_text RodPostgameInitialText
	script_jump .done
.check_cup_state
	get_var VAR_GRAND_MASTER_CUP_STATE
	compare_loaded_var NONE
	print_variable_npc_text RodPostgameRepeatText, RodGrandMasterCupPlayedText
.done
	end_dialog
	end_script
	ret

PokemonDome_RodAppearanceCheck:
	ld a, EVENT_FREED_ROD
	farcall GetEventValue
	jr z, .disappear
	ld a, EVENT_SET_UNTIL_MAP_RELOAD_1
	farcall GetEventValue
	jr nz, .disappear
	ld a, VAR_GRAND_MASTER_CUP_STATE
	farcall GetVarValue
	cp GRAND_MASTER_CUP_ACTIVE
	jr z, .disappear
	cp GRAND_MASTER_CUP_ACTIVE_PRIZES_SET
	jr z, .disappear
	scf
	ccf
	ret
.disappear
	scf
	ret

Script_GR5_PokemonDome:
	ld a, NPC_GR_5
	ld [wScriptNPC], a
	ldtx hl, DialogGR5Text
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [wScriptNPCName + 1], a
	xor a
	start_script
	start_dialog
	check_event EVENT_TALKED_TO_GR5_POKEMON_DOME
	script_jump_if_b0z .repeat
	set_event EVENT_TALKED_TO_GR5_POKEMON_DOME
	print_npc_text PokemonDomeGR5PreachInitialText
	script_jump .done
.repeat
	print_npc_text PokemonDomeGR5PreachRepeatText
.done
	end_dialog
	end_script
	ret

PokemonDome_DisappearAfterGRCoin:
	ld a, EVENT_GOT_GR_COIN
	farcall GetEventValue
	jr z, .appear
	scf
	ret
.appear
	scf
	ccf
	ret

Script_GrandMasterCupClerk:
	ld a, NPC_TCG_CUP_CLERK_LEFT
	ld [wScriptNPC], a
	ldtx hl, DialogReceptionistText
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [wScriptNPCName + 1], a
	xor a
	start_script
	start_dialog
	get_var VAR_GRAND_MASTER_CUP_STATE
	compare_loaded_var GRAND_MASTER_CUP_PLAYED
	script_jump_if_b1z .cup_played
	compare_loaded_var GRAND_MASTER_CUP_ACTIVE
	script_jump_if_b0z .prizes_set
	set_var VAR_GRAND_MASTER_CUP_STATE, GRAND_MASTER_CUP_ACTIVE_PRIZES_SET
	script_call Script_SetGrandMasterCupPrizes
.prizes_set
	print_npc_text GrandMasterCupClerkWelcomeText
	script_call Script_LoadFirstTwoGrandMasterCupPrizeCardNames
	print_npc_text GrandMasterCupClerkPrizesText
	script_call Script_LoadLastTwoGrandMasterCupPrizeCardNames
	print_npc_text GrandMasterCupClerkPrizesText
	print_npc_text GrandMasterCupClerkInviteText
	script_jump .enter_prompt
.cup_played
	compare_loaded_var GRAND_MASTER_CUP_RESULT_LOST
	print_variable_npc_text GrandMasterCupClerkPlayerLostText, GrandMasterCupClerkPlayerWonGrandFinalText
	script_jump .done
.enter_prompt
	ask_question GrandMasterCupClerkEnterPromptText, TRUE
	script_jump_if_b0z .declined
	set_var VAR_GRAND_MASTER_CUP_STATE, GRAND_MASTER_CUP_PLAYING
	set_var VAR_TIMES_WON_LINK_DUEL_FOR_GRAND_MASTER_CUP, 0
	print_npc_text GrandMasterCupClerkEnterAcceptedText
	end_dialog
	script_jump Script_MovePlayerIntoGrandMasterCup
.declined
	print_npc_text GrandMasterCupClerkEnterDeclinedText
.done
	end_dialog
	end_script
	ret

Script_PokemonDomeGRLass:
	ld a, NPC_POKEMON_DOME_GR_LASS
	ld [wScriptNPC], a
	ldtx hl, DialogGRKidText
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [wScriptNPCName + 1], a
	xor a
	start_script
	start_dialog
	print_npc_text PokemonDomeGRLassSpectatorText
	get_var VAR_GRAND_MASTER_CUP_STATE
	compare_loaded_var GRAND_MASTER_CUP_PLAYED
	script_jump_if_b1z .cup_played
	print_npc_text PokemonDomeGRLassAnticipatingText
	script_jump .done
.cup_played
	print_npc_text PokemonDomeGRLassSpectatedText
.done
	end_dialog
	end_script
	ret

Script_PokemonDomeYoungster:
	ld a, NPC_POKEMON_DOME_YOUNGSTER
	ld [wScriptNPC], a
	ldtx hl, DialogLadText
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [wScriptNPCName + 1], a
	xor a
	start_script
	start_dialog
	get_var VAR_GRAND_MASTER_CUP_STATE
	compare_loaded_var GRAND_MASTER_CUP_PLAYED
	script_jump_if_b1z .cup_played
	print_npc_text PokemonDomeYoungsterSpectatorText
	script_jump .done
.cup_played
	print_npc_text PokemonDomeYoungsterSpectatedText
.done
	end_dialog
	end_script
	ret

Script_PokemonDomeSwimmer:
	ld a, NPC_POKEMON_DOME_SWIMMER
	ld [wScriptNPC], a
	ldtx hl, DialogSwimmerKidText
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [wScriptNPCName + 1], a
	xor a
	start_script
	start_dialog
	get_var VAR_GRAND_MASTER_CUP_STATE
	compare_loaded_var GRAND_MASTER_CUP_PLAYED
	script_jump_if_b0nz .player_won
	script_jump_if_b1z .player_lost
	print_npc_text PokemonDomeSwimmerSpectatorText
	script_jump .done
.player_won
	print_npc_text PokemonDomeSwimmerPlayerWonCupText
	script_jump .done
.player_lost
	print_npc_text PokemonDomeSwimmerPlayerLostCupText
.done
	end_dialog
	end_script
	ret

PokemonDome_AppearDuringGrandMasterCup:
	ld a, EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE
	farcall GetEventValue
	jr z, .disappear
	ld a, VAR_GRAND_MASTER_CUP_STATE
	farcall GetVarValue
	cp GRAND_MASTER_CUP_ACTIVE
	jr c, .disappear
	cp GRAND_MASTER_CUP_PLAYING
	jr c, .appear
	ld a, EVENT_SET_UNTIL_MAP_RELOAD_1
	farcall GetEventValue
	jr z, .disappear
.appear
	scf
	ccf
	ret
.disappear
	scf
	ret

Script_PokemonDomeArenaDoors:
	xor a
	start_script
	check_event EVENT_GOT_GR_COIN
	script_jump_if_b0z .no_gr5
	set_active_npc NPC_GR_5, DialogGR5Text
	move_active_npc .NPCMovement_3db3b
	wait_for_player_animation
	start_dialog
	print_npc_text PokemonDomeGR5SealedArenaDoorsText
	end_dialog
	move_active_npc .NPCMovement_3db3e
	wait_for_player_animation
	end_script
	jr .done
.no_gr5
	start_dialog
	print_text DoorsAreShutText
	end_dialog
	end_script
.done
	farcall OverworldResumeAndHandlePlayerMoveInput
	ret
.NPCMovement_3db3b:
	db NORTH, MOVE_4
	db $ff
.NPCMovement_3db3e:
	db SOUTH, MOVE_4
	db $ff

Script_MoveGrandMastersAndPlayerIntoFinalCup:
	get_player_direction
	compare_loaded_var NORTH
	script_jump_if_b0nz .ows_3db5a
	compare_loaded_var WEST
	script_jump_if_b0nz .ows_3db53
	move_player .NPCMovement_3dbac, TRUE
	script_jump .ows_3db5e
.ows_3db53
	move_player .NPCMovement_3dbb1, TRUE
	script_jump .ows_3db5e
.ows_3db5a
	move_player .NPCMovement_3dbb4, TRUE
.ows_3db5e
	wait_for_player_animation
	scroll_to_position $ff, $00
	move_npc NPC_ROD, .NPCMovement_3dbbc
	move_npc NPC_STEVE, .NPCMovement_3dbc3
	wait_for_player_animation
	do_frames 30
	play_sfx SFX_DOORS
	load_tilemap TILEMAP_038, 7, 0
	do_frames 30
	move_npc NPC_ROD, .NPCMovement_3dbca
	move_npc NPC_STEVE, .NPCMovement_3dbca
	move_npc NPC_COURTNEY, .NPCMovement_3dbcd
	move_npc NPC_JACK, .NPCMovement_3dbd4
	wait_for_player_animation
	move_npc NPC_COURTNEY, .NPCMovement_3dbdb
	move_npc NPC_JACK, .NPCMovement_3dbdb
	move_player .NPCMovement_3dbb9, TRUE
	wait_for_player_animation
	do_frames 60
	play_sfx SFX_DOORS
	load_tilemap TILEMAP_037, 7, 0
	do_frames 30
	end_script
	ld a, MAP_POKEMON_DOME_BACK
	lb de, 7, 14
	ld b, NORTH
	farcall SetWarpData
	ret
.NPCMovement_3dbac:
	db EAST, MOVE_1
	db NORTH, MOVE_0
	db $ff
.NPCMovement_3dbb1:
	db NORTH, MOVE_1
	db $ff
.NPCMovement_3dbb4:
	db EAST, MOVE_1
	db NORTH, MOVE_2
	db $ff
.NPCMovement_3dbb9:
	db NORTH, MOVE_6
	db $ff
.NPCMovement_3dbbc:
	db NORTH, MOVE_2
	db EAST, MOVE_1
	db NORTH, MOVE_3
	db $ff
.NPCMovement_3dbc3:
	db NORTH, MOVE_2
	db WEST, MOVE_1
	db NORTH, MOVE_3
	db $ff
.NPCMovement_3dbca:
	db NORTH, MOVE_2
	db $ff
.NPCMovement_3dbcd:
	db NORTH, MOVE_2
	db EAST, MOVE_4
	db NORTH, MOVE_1
	db $ff
.NPCMovement_3dbd4:
	db NORTH, MOVE_2
	db WEST, MOVE_4
	db NORTH, MOVE_1
	db $ff
.NPCMovement_3dbdb:
	db NORTH, MOVE_4
	db $ff

Script_MovePlayerIntoGrandMasterCup:
	get_player_x_position
	compare_loaded_var $08
	script_jump_if_b1z .ows_3dbff
	animate_npc_movement NPC_TCG_CUP_CLERK_RIGHT, $01, $01
	set_npc_direction NPC_TCG_CUP_CLERK_RIGHT, WEST
	get_player_direction
	compare_loaded_var NORTH
	script_jump_if_b0nz .ows_3dbf8
	move_player .NPCMovement_3dc38, TRUE
	script_jump .ows_3dc17
.ows_3dbf8
	move_player .NPCMovement_3dc3c, TRUE
	script_jump .ows_3dc17
.ows_3dbff
	animate_npc_movement NPC_TCG_CUP_CLERK_LEFT, $03, $01
	set_npc_direction NPC_TCG_CUP_CLERK_LEFT, EAST
	get_player_direction
	compare_loaded_var NORTH
	script_jump_if_b0nz .ows_3dc13
	move_player .NPCMovement_3dc41, TRUE
	script_jump .ows_3dc17
.ows_3dc13
	move_player .NPCMovement_3dc45, TRUE
.ows_3dc17
	wait_for_player_animation
	do_frames 30
	set_scroll_state $02
	play_sfx SFX_DOORS
	load_tilemap TILEMAP_038, 7, 0
	do_frames 30
	animate_player_movement $00, $01
	animate_player_movement $00, $01
	end_script
	ld a, MAP_POKEMON_DOME_BACK
	lb de, 6, 4
	ld b, EAST
	farcall SetWarpData
	ret
.NPCMovement_3dc38:
	db SOUTH, MOVE_1
	db EAST, MOVE_1
.NPCMovement_3dc3c:
	db EAST, MOVE_1
	db NORTH, MOVE_4
	db $ff
.NPCMovement_3dc41:
	db SOUTH, MOVE_1
	db WEST, MOVE_1
.NPCMovement_3dc45:
	db WEST, MOVE_1
	db NORTH, MOVE_4
	db $ff

Script_RodAfterFinalCup:
	ld a, NPC_ROD
	ld [wScriptNPC], a
	ldtx hl, DialogRodText
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [wScriptNPCName + 1], a
	ld a, EVENT_EE
	farcall GetEventValue
	jr z, .resume
	xor a
	start_script
	check_event EVENT_TALKED_TO_ROD_POKEMON_DOME
	script_jump_if_b0z .repeat
	set_event EVENT_TALKED_TO_ROD_POKEMON_DOME
	do_frames 30
	start_dialog
	print_npc_text RodIAmGrandMasterLeaderText
	end_dialog
	do_frames 15
	set_player_direction EAST
	do_frames 30
	set_player_direction WEST
	do_frames 30
	set_player_direction SOUTH
	do_frames 30
.repeat
	start_dialog
	print_npc_text RodRevisitPokemonDomeForNextFinalCupText
	end_dialog
	end_script
.resume
	ld a, OWMODE_IDLE
	ld [wOverworldMode], a
	ret

Script_GrandMasterCupClerkAfterTournament:
	ld a, NPC_TCG_CUP_CLERK_LEFT
	ld [wScriptNPC], a
	ldtx hl, DialogReceptionistText
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [wScriptNPCName + 1], a
	xor a
	start_script
	animate_active_npc_movement $03, $01
	set_active_npc_direction EAST
	move_player .NPCMovement_3dcb8, TRUE
	wait_for_player_animation
	animate_active_npc_movement $01, $01
	set_active_npc_direction SOUTH
	end_script
	ld a, OWMODE_IDLE
	ld [wOverworldMode], a
	ret
.NPCMovement_3dcb8:
	db SOUTH, MOVE_4
	db $ff

Script_SetGrandMasterCupPrizes:
; init
	set_var VAR_GRANDMASTERCUP_PRIZE_INDEX_0, $ff
	set_var VAR_GRANDMASTERCUP_PRIZE_INDEX_1, $ff
	set_var VAR_GRANDMASTERCUP_PRIZE_INDEX_2, $ff
	set_var VAR_GRANDMASTERCUP_PRIZE_INDEX_3, $ff
	quit_script
; set
	call .PickPrize
	ld a, VAR_GRANDMASTERCUP_PRIZE_INDEX_0
	farcall SetVarValue
	call .PickPrize
	ld a, VAR_GRANDMASTERCUP_PRIZE_INDEX_1
	farcall SetVarValue
	call .PickPrize
	ld a, VAR_GRANDMASTERCUP_PRIZE_INDEX_2
	farcall SetVarValue
	call .PickPrize
	ld a, VAR_GRANDMASTERCUP_PRIZE_INDEX_3
	farcall SetVarValue
	ld a, $01
	start_script
	script_ret

; return c = random prize index, while also ensuring no dupes
.PickPrize:
	ld a, NUM_GRANDMASTERCUP_PRIZE_POOL
	call Random
	ld c, a
	ld a, VAR_GRANDMASTERCUP_PRIZE_INDEX_0
	farcall GetVarValue
	cp c
	jr z, .PickPrize
	ld a, VAR_GRANDMASTERCUP_PRIZE_INDEX_1
	farcall GetVarValue
	cp c
	jr z, .PickPrize
	ld a, VAR_GRANDMASTERCUP_PRIZE_INDEX_2
	farcall GetVarValue
	cp c
	jr z, .PickPrize
	ld a, VAR_GRANDMASTERCUP_PRIZE_INDEX_3
	farcall GetVarValue
	cp c
	jr z, .PickPrize
	ret

Script_LoadFirstTwoGrandMasterCupPrizeCardNames:
	quit_script
	xor a ; GRANDMASTERCUP_PRIZE_0
	farcall GetGrandMasterCupPrizeCardName
	call LoadTxRam2
	ld a, GRANDMASTERCUP_PRIZE_1
	farcall GetGrandMasterCupPrizeCardName
	ld a, l
	ld [wTxRam2_b], a
	ld a, h
	ld [wTxRam2_b + 1], a
	ld a, $01
	start_script
	script_ret

Script_LoadLastTwoGrandMasterCupPrizeCardNames:
	quit_script
	ld a, GRANDMASTERCUP_PRIZE_2
	farcall GetGrandMasterCupPrizeCardName
	call LoadTxRam2
	ld a, GRANDMASTERCUP_PRIZE_3
	farcall GetGrandMasterCupPrizeCardName
	ld a, l
	ld [wTxRam2_b], a
	ld a, h
	ld [wTxRam2_b + 1], a
	ld a, $01
	start_script
	script_ret

PokemonDomeBack_MapHeader:
	db MAP_GFX_POKEMON_DOME_BACK
	dba PokemonDomeBack_MapScripts
	db MUSIC_POKEMON_DOME

PokemonDomeBack_StepEvents:
	map_exit 7, 15, MAP_POKEMON_DOME, 7, 1, SOUTH
	map_exit 8, 15, MAP_POKEMON_DOME, 8, 1, SOUTH
	db $ff

PokemonDomeBack_NPCs:
	npc NPC_COURTNEY, 7, 13, SOUTH, NULL
	npc NPC_STEVE, 8, 12, SOUTH, NULL
	npc NPC_JACK, 8, 13, SOUTH, NULL
	npc NPC_ROD, 7, 12, SOUTH, NULL
	npc NPC_CUP_HOST, 7, 2, SOUTH, PokemonDomeBack_AppearOnPostgame
	db $ff

PokemonDomeBack_MapScripts:
	dbw OWMODE_STEP_EVENT, Func_3dda8
	dbw OWMODE_AFTER_DUEL, PokemonDomeBack_AfterDuel
	dbw OWMODE_NPC_POSITION, Func_3ddaf
	dbw OWMODE_WARP_FADE_IN_PRELOAD, Func_3ddb8
	dbw OWMODE_WARP_FADE_OUT_PRELOAD, Func_3de67
	dbw OWMODE_CONTINUE_OW, Func_3de91
	dbw OWMODE_CONTINUE_DUEL, Func_3deca
	dbw OWMODE_WARP_END_SFX, Func_3de6f
	db $ff

Func_3dda8:
	ld hl, PokemonDomeBack_StepEvents
	call ExecutePlayerCoordScript
	ret

Func_3ddaf:
	ld hl, PokemonDomeBack_NPCs
	call LoadNPCs
	scf
	ccf
	ret

Func_3ddb8:
	ld a, EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE
	farcall GetEventValue
	jr nz, .grand_master_cup
; final cup
	ld a, NPC_CUP_HOST
	lb de, 8, 14
	ld b, NORTH
	farcall LoadOWObjectInMap
	farcall ResetOWObjectSpriteAnimFlag6
	ld a, NPC_CUP_HOST
	farcall SetOWObjectAsScrollTarget
	ld a, OWMODE_SCRIPT
	ld [wOverworldMode], a
	ld a, BANK(Script_FinalCupIntroAndRound1Start)
	ld [wOverworldScriptBank], a
	ld hl, Script_FinalCupIntroAndRound1Start
	ld a, l
	ld [wOverworldScriptPointer], a
	ld a, h
	ld [wOverworldScriptPointer + 1], a
	scf
	ret
.grand_master_cup
	ld bc, TILEMAP_0B9
	lb de, 5, 0
	farcall Func_12c0ce
	ld a, NPC_COURTNEY
	lb de, 3, 5
	ld b, EAST
	farcall SetOWObjectTilePositionAndDirection
	ld a, NPC_STEVE
	lb de, 3, 3
	ld b, EAST
	farcall SetOWObjectTilePositionAndDirection
	ld a, NPC_JACK
	lb de, 12, 5
	ld b, WEST
	farcall SetOWObjectTilePositionAndDirection
	ld a, NPC_ROD
	lb de, 12, 3
	ld b, WEST
	farcall SetOWObjectTilePositionAndDirection
	farcall SetGrandMasterCupOpponents
	farcall SetGrandMasterCupNPCMatchWinners
	ld a, VAR_GRANDMASTERCUP_ROUND1_NPC1_DECK_ID
	farcall GetVarValue
	farcall GetNPCByDeck_AdjustAmy_PokemonDome
	lb de, 9, 4
	ld b, WEST
	farcall LoadOWObjectInMap
	lb de, 6, 0
	farcall CalcOWScroll
	ld a, $02
	farcall SetOWScrollState
	ld a, OWMODE_SCRIPT
	ld [wOverworldMode], a
	ld a, BANK(Script_GrandMasterCupHost)
	ld [wOverworldScriptBank], a
	ld hl, Script_GrandMasterCupHost
	ld a, l
	ld [wOverworldScriptPointer], a
	ld a, h
	ld [wOverworldScriptPointer + 1], a
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

PokemonDomeBack_AfterDuel:
	ld a, EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE
	farcall GetEventValue
	jr z, .final_cup
; grand master cup
	jp Script_GrandMasterCupAfterDuel
.final_cup
	ld a, VAR_FINAL_CUP_PLAYED_ROUNDS
	farcall GetVarValue
	jp z, Script_FinalCupRound1AfterDuel
	dec a
	jp z, Script_FinalCupRound2AfterDuel
	dec a
	jp z, Script_FinalCupRound3AfterDuel
	jp Script_FinalCupRound4AfterDuel

Func_3de91:
	farcall OverworldResumeWithCurSong
	ld a, EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE
	farcall GetEventValue
	jr nz, .postgame

	call .FinalCup
	jr .done
.FinalCup:
	xor a
	start_script
	reset_event EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE_DUMMY
	get_var VAR_FINAL_CUP_PLAYED_ROUNDS
	compare_loaded_var 2
	script_jump_if_b1nz Script_FinalCupRound2Start
	script_jump_if_b0nz Script_FinalCupRound3Start
	script_jump Script_FinalCupRound4Start

.postgame
	call .GrandMasterCup
	jr .done
.GrandMasterCup:
	farcall InitAndLoadGrandMasterCupOpponentNames
	xor a
	start_script
	reset_event EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE_DUMMY
	script_jump Script_GrandMasterCupRound1Start

.done
	scf
	ccf
	ret

Func_3deca:
	ld a, EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE
	farcall GetEventValue
	ret z
	farcall InitAndLoadGrandMasterCupOpponentNames
	ret

Script_FinalCupIntroAndRound1Start:
	xor a
	start_script
	move_npc NPC_ROD, .NPCMovement_3df13
	move_npc NPC_COURTNEY, .NPCMovement_3df1e
	move_npc NPC_STEVE, .NPCMovement_3df2d
	move_npc NPC_JACK, .NPCMovement_3df36
	move_player .NPCMovement_3df0a, TRUE
	move_npc NPC_CUP_HOST, .NPCMovement_3df0a
	wait_for_player_animation
	do_frames 30
	set_scroll_state $02
	unload_npc NPC_CUP_HOST
	set_active_npc NPC_ROD, DialogRodText
	start_dialog
	print_npc_text RodFinalCupIntroAndRound1OpponentText
	end_dialog
	move_npc NPC_COURTNEY, .NPCMovement_3df3f
	wait_for_player_animation
	script_jump .round1
.NPCMovement_3df0a:
	db NORTH, MOVE_3
	db WEST, MOVE_3
	db NORTH, MOVE_7
	db EAST, MOVE_2
	db $ff
.NPCMovement_3df13:
	db NORTH, MOVE_1
	db WEST, MOVE_3
	db NORTH, MOVE_9
	db EAST, MOVE_3
	db SOUTH, MOVE_0
	db $ff
.NPCMovement_3df1e:
	db NORTH, MOVE_2
	db WEST, MOVE_3
	db NORTH, MOVE_5
	db EAST, MOVE_6
	db NORTH, MOVE_4
	db EAST, MOVE_1
	db WEST, MOVE_0
	db $ff
.NPCMovement_3df2d:
	db NORTH, MOVE_1
	db EAST, MOVE_3
	db NORTH, MOVE_7
	db WEST, MOVE_0
	db $ff
.NPCMovement_3df36:
	db NORTH, MOVE_2
	db EAST, MOVE_3
	db NORTH, MOVE_5
	db WEST, MOVE_0
	db $ff
.NPCMovement_3df3f:
	db WEST, MOVE_1
	db SOUTH, MOVE_2
	db WEST, MOVE_1
	db $ff
.round1
	set_var VAR_FINAL_CUP_PLAYED_ROUNDS, 0
	set_active_npc NPC_COURTNEY, DialogCourtneyText
	start_dialog
	print_npc_text CourtneyFinalCupDuelStartText
	end_dialog
	start_duel GRAND_FIRE_DECK_ID, MUSIC_MATCH_START_GRAND_MASTER
	end_script
	ret

Script_FinalCupRound1AfterDuel:
	xor a
	start_script
	start_dialog
	check_event EVENT_SET_UNTIL_MAP_RELOAD_2
	script_jump_if_b0nz .lost_round1
	print_npc_text CourtneyTournamentsPlayerWonText
	end_dialog
	move_active_npc .NPCMovement_3df81
	wait_for_player_animation
	set_active_npc NPC_ROD, DialogRodText
	start_dialog
	print_npc_text RodFinalCupRound1NextOpponentText
	end_dialog
	move_npc NPC_STEVE, .NPCMovement_3df8a
	wait_for_player_animation
	script_jump Script_FinalCupRound2Start
.lost_round1
	print_npc_text CourtneyFinalCupPlayerLostText
	end_dialog
	script_jump Script_FinalCupPlayerLost
.NPCMovement_3df81:
	db EAST, MOVE_1
	db NORTH, MOVE_2
	db EAST, MOVE_1
	db WEST, MOVE_0
	db $ff
.NPCMovement_3df8a:
	db WEST, MOVE_2
	db $ff

Script_FinalCupRound2Start:
	set_var VAR_FINAL_CUP_PLAYED_ROUNDS, 1
	set_active_npc NPC_STEVE, DialogSteveText
	start_dialog
	print_npc_text SteveFinalCupReadyToDuelText
	set_active_npc NPC_ROD, DialogRodText
.loop_prep
	print_npc_text RodFinalCupAreYourDecksReadyText
	ask_question DuelPrepPromptText, FALSE
	script_jump_if_b0z .start_duel
	end_dialog
	set_event EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE_DUMMY
	open_menu
	reset_event EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE_DUMMY
	start_dialog
	script_jump .loop_prep
.start_duel
	set_text_ram2 DialogSteveText
	print_npc_text RodFinalCupResumeRoundText
	set_active_npc NPC_STEVE, DialogSteveText
	print_npc_text SteveFinalCupDuelStartText
	end_dialog
	start_duel LEGENDARY_FOSSIL_DECK_ID, MUSIC_MATCH_START_GRAND_MASTER
	end_script
	ret

Script_FinalCupRound2AfterDuel:
	xor a
	start_script
	start_dialog
	check_event EVENT_SET_UNTIL_MAP_RELOAD_2
	script_jump_if_b0nz .lost_round2
	print_npc_text SteveTournamentsPlayerWonText
	end_dialog
	move_active_npc .NPCMovement_3dfed
	wait_for_player_animation
	set_active_npc NPC_ROD, DialogRodText
	start_dialog
	print_npc_text RodFinalCupRound2NextOpponentText
	end_dialog
	move_npc NPC_JACK, .NPCMovement_3dff2
	wait_for_player_animation
	script_jump Script_FinalCupRound3Start
.lost_round2
	print_npc_text SteveTournamentsPlayerLostText
	end_dialog
	script_jump Script_FinalCupPlayerLost
.NPCMovement_3dfed:
	db EAST, MOVE_2
	db WEST, MOVE_0
	db $ff
.NPCMovement_3dff2:
	db WEST, MOVE_1
	db NORTH, MOVE_2
	db WEST, MOVE_1
	db $ff

Script_FinalCupRound3Start:
	set_var VAR_FINAL_CUP_PLAYED_ROUNDS, 2
	set_active_npc NPC_JACK, DialogJackText
	start_dialog
	print_npc_text JackFinalCupReadyToDuelText
	set_active_npc NPC_ROD, DialogRodText
.loop_prep
	print_npc_text RodFinalCupAreYourDecksReadyText
	ask_question DuelPrepPromptText, FALSE
	script_jump_if_b0z .start_duel
	end_dialog
	set_event EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE_DUMMY
	open_menu
	reset_event EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE_DUMMY
	start_dialog
	script_jump .loop_prep
.start_duel
	set_text_ram2 DialogJackText
	print_npc_text RodFinalCupResumeRoundText
	set_active_npc NPC_JACK, DialogJackText
	print_npc_text JackFinalCupDuelStartText
	end_dialog
	start_duel WATER_LEGEND_DECK_ID, MUSIC_MATCH_START_GRAND_MASTER
	end_script
	ret

Script_FinalCupRound3AfterDuel:
	xor a
	start_script
	start_dialog
	check_event EVENT_SET_UNTIL_MAP_RELOAD_2
	script_jump_if_b0nz .lost_round3
	print_npc_text JackFinalCupPlayerWonText
	end_dialog
	move_active_npc .NPCMovement_3e059
	wait_for_player_animation
	set_active_npc NPC_ROD, DialogRodText
	start_dialog
	print_npc_text RodFinalCupRound3NextOpponentText
	end_dialog
	move_npc NPC_ROD, .NPCMovement_3e062
	wait_for_player_animation
	script_jump Script_FinalCupRound4Start
.lost_round3
	print_npc_text JackTournamentsPlayerLostText
	end_dialog
	script_jump Script_FinalCupPlayerLost
.NPCMovement_3e059:
	db EAST, MOVE_1
	db SOUTH, MOVE_2
	db EAST, MOVE_1
	db WEST, MOVE_0
	db $ff
.NPCMovement_3e062:
	db EAST, MOVE_3
	db SOUTH, MOVE_2
	db WEST, MOVE_1
	db $ff

Script_FinalCupRound4Start:
	set_var VAR_FINAL_CUP_PLAYED_ROUNDS, 3
	set_active_npc NPC_ROD, DialogRodText
	start_dialog
	print_npc_text RodFinalCupReadyToDuelText
.loop_prep
	print_npc_text RodFinalCupAreYourDecksReadyText
	ask_question DuelPrepPromptText, FALSE
	script_jump_if_b0z .start_duel
	end_dialog
	set_event EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE_DUMMY
	open_menu
	reset_event EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE_DUMMY
	start_dialog
	script_jump .loop_prep
.start_duel
	print_npc_text RodFinalCupDuelStartText
	end_dialog
	start_duel GREAT_DRAGON_DECK_ID, MUSIC_MATCH_START_GRAND_MASTER
	end_script
	ret

Script_FinalCupRound4AfterDuel:
	xor a
	start_script
	start_dialog
	check_event EVENT_SET_UNTIL_MAP_RELOAD_2
	script_jump_if_b0nz .lost_round4
	print_npc_text RodTournamentsPlayerWonText
	end_dialog
	script_jump .proceed_prizes
.lost_round4
	print_npc_text RodTournamentsPlayerLostText
	end_dialog
	move_active_npc .NPCMovement_3e0ad
	wait_for_player_animation
	script_jump Script_FinalCupPlayerLost
.NPCMovement_3e0ad:
	db NORTH, MOVE_2
	db WEST, MOVE_2
	db $ff
.proceed_prizes
	set_event EVENT_WON_FINAL_CUP
	set_event EVENT_SET_UNTIL_MAP_RELOAD_1
	move_active_npc .NPCMovement_3e0fe
	wait_for_player_animation
	set_player_direction NORTH
	start_dialog
	print_npc_text RodYouDeserveLegendaryCardsText
	quit_script
	farcall Func_1022a
	ld de, MOLTRES_LV40
	farcall Func_c646
	ld de, ZAPDOS_LV68
	farcall Func_c646
	ld de, ARTICUNO_LV37
	farcall Func_c646
	ld de, DRAGONITE_LV41
	farcall Func_c646
	farcall Func_10252
	call WaitPalFading
	ld a, $01
	start_script
	print_npc_text RodChallengeBiruritchiText
	end_dialog
	end_script
	ld a, MAP_POKEMON_DOME
	lb de, 7, 1
	ld b, SOUTH
	farcall SetWarpData
	ret
.NPCMovement_3e0fe:
	db NORTH, MOVE_2
	db WEST, MOVE_3
	db SOUTH, MOVE_1
	db $ff

Script_FinalCupPlayerLost:
	set_event EVENT_SET_UNTIL_MAP_RELOAD_1
	set_event EVENT_EE
	move_npc NPC_ROD, .NPCMovement_3e126
	wait_for_player_animation
	set_player_direction NORTH
	set_active_npc NPC_ROD, DialogRodText
	start_dialog
	print_npc_text RodYouDoNotDeserveLegendaryCardsText
	end_dialog
	end_script
	ld a, MAP_POKEMON_DOME
	lb de, 7, 1
	ld b, SOUTH
	farcall SetWarpData
	ret
.NPCMovement_3e126:
	db WEST, MOVE_1
	db SOUTH, MOVE_1
	db $ff

Script_GrandMasterCupHost:
	ld a, NPC_CUP_HOST
	ld [wScriptNPC], a
	ldtx hl, DialogCupHostText
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [wScriptNPCName + 1], a
	xor a
	start_script
	start_dialog
	set_var VAR_GRANDMASTERCUP_CURRENT_ROUND, 0
	print_npc_text CupHostGrandMasterCupIntroBracketRevealText
	end_dialog
	quit_script
	farcall InitAndLoadGrandMasterCupOpponentNames
	farcall SetupAndShowGrandMasterCupBracket
	ld a, $01
	start_script
	script_jump Script_GrandMasterCupRound1Start

Script_GrandMasterCupRound1Start:
	set_var VAR_GRANDMASTERCUP_CURRENT_ROUND, 1
	set_active_npc NPC_CUP_HOST, DialogCupHostText
	start_dialog
	print_npc_text CupHostGrandMasterCupRound1Text
	end_dialog
	move_active_npc .NPCMovement_3e1a9
	wait_for_player_animation
	start_dialog
	print_npc_text CupHostGrandMasterCupRound1CallPlayerText
	end_dialog
	move_active_npc .NPCMovement_3e1ae
	wait_for_player_animation
	quit_script
	farcall LoadGrandMasterCupCurOpponentLocationAndName
	ld a, $01
	start_script
	start_dialog
	print_npc_text CupHostGrandMasterCupRound1CallOpponentText
	end_dialog
	move_active_npc .NPCMovement_3e1b3
	wait_for_player_animation
	start_dialog
	print_npc_text CupHostGrandMasterCupRound1StartingText
; the only prep opportunity for the cup
.loop_prep
	print_npc_text CupHostGrandMasterCupAreYourDecksReadyText
	ask_question DuelPrepPromptText, FALSE
	script_jump_if_b0z .start_duel
	print_npc_text CupHostGrandMasterCupMakeYourPreparationsText
	end_dialog
	set_event EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE_DUMMY
	open_menu
	reset_event EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE_DUMMY
	start_dialog
	script_jump .loop_prep
.start_duel
	print_npc_text CupHostGrandMasterCupRound1DuelStartText
	end_dialog
	end_script
	farcall SetGrandMasterCupDuelParams
	ret
.NPCMovement_3e1a9:
	db WEST, MOVE_1
	db SOUTH, MOVE_0
	db $ff
.NPCMovement_3e1ae:
	db EAST, MOVE_3
	db SOUTH, MOVE_0
	db $ff
.NPCMovement_3e1b3:
	db WEST, MOVE_2
	db SOUTH, MOVE_0
	db $ff

Script_GrandMasterCupRound2Start:
	quit_script
	farcall SetupAndShowGrandMasterCupBracket
	ld a, VAR_GRANDMASTERCUP_CURRENT_ROUND
	ld c, 2
	farcall SetVarValue
	ld a, VAR_GRANDMASTERCUP_ROUND2_NPC1_DECK_ID
	farcall GetVarValue
	farcall GetNPCByDeck_AdjustAmy_PokemonDome
	lb de, 9, 4
	ld b, WEST
	farcall LoadOWObjectInMap
	ld a, $01
	start_script
	start_dialog
	print_npc_text CupHostGrandMasterCupRound2Text
	end_dialog
	move_active_npc .NPCMovement_3e20d
	wait_for_player_animation
	start_dialog
	print_npc_text CupHostGrandMasterCupRound2CallPlayerText
	end_dialog
	move_active_npc .NPCMovement_3e212
	wait_for_player_animation
	quit_script
	farcall LoadGrandMasterCupCurOpponentLocationAndName
	ld a, $01
	start_script
	start_dialog
	print_npc_text CupHostGrandMasterCupRound2CallOpponentText
	end_dialog
	move_active_npc .NPCMovement_3e217
	wait_for_player_animation
	start_dialog
	print_npc_text CupHostGrandMasterCupRound2DuelStartText
	end_dialog
	end_script
	farcall SetGrandMasterCupDuelParams
	ret
.NPCMovement_3e20d:
	db WEST, MOVE_1
	db SOUTH, MOVE_0
	db $ff
.NPCMovement_3e212:
	db EAST, MOVE_3
	db SOUTH, MOVE_0
	db $ff
.NPCMovement_3e217:
	db WEST, MOVE_2
	db SOUTH, MOVE_0
	db $ff

Script_GrandMasterCupFinalsStart:
	quit_script
	farcall SetupAndShowGrandMasterCupBracket
	ld a, VAR_GRANDMASTERCUP_CURRENT_ROUND
	ld c, 3
	farcall SetVarValue
	ld a, VAR_GRANDMASTERCUP_FINAL_NPC_DECK_ID
	farcall GetVarValue
	farcall GetNPCByDeck_AdjustAmy_PokemonDome
	lb de, 9, 4
	ld b, WEST
	farcall LoadOWObjectInMap
	ld a, $01
	start_script
	start_dialog
	print_npc_text CupHostGrandMasterCupFinalsText
	end_dialog
	move_active_npc .NPCMovement_3e295
	wait_for_player_animation
	start_dialog
	print_npc_text CupHostGrandMasterCupFinalsCallPlayerText
	end_dialog
	move_active_npc .NPCMovement_3e29a
	wait_for_player_animation
	start_dialog
	quit_script
	ld a, VAR_GRANDMASTERCUP_FINAL_NPC_DECK_ID
	farcall GetVarValue
	farcall GetNPCByDeck
	cp NPC_RONALD
	jr z, .ronald
	farcall LoadGrandMasterCupCurOpponentLocationAndName
	ld a, $01
	start_script
	print_npc_text CupHostGrandMasterCupFinalsCallOpponentClubMasterText
	script_jump .start_duel
.ronald
	ld a, $01
	start_script
	print_npc_text CupHostGrandMasterCupFinalsCallOpponentRonaldText
	set_active_npc NPC_RONALD, DialogRonaldText
	print_npc_text RonaldGrandMasterCupFinalsText
	set_active_npc NPC_CUP_HOST, DialogCupHostText
.start_duel
	end_dialog
	move_active_npc .NPCMovement_3e29f
	wait_for_player_animation
	start_dialog
	print_npc_text CupHostGrandMasterCupFinalsDuelStartText
	end_dialog
	end_script
	farcall SetGrandMasterCupDuelParams
	ret
.NPCMovement_3e295:
	db WEST, MOVE_1
	db SOUTH, MOVE_0
	db $ff
.NPCMovement_3e29a:
	db EAST, MOVE_3
	db SOUTH, MOVE_0
	db $ff
.NPCMovement_3e29f:
	db WEST, MOVE_2
	db SOUTH, MOVE_0
	db $ff

Script_GrandMasterCupAfterDuel:
	xor a
	start_script
	start_dialog
	get_var VAR_GRANDMASTERCUP_CURRENT_ROUND
	compare_loaded_var 3
	script_jump_if_b0nz .after_finals
	script_jump_if_b1z .after_grand_finals

; after round 1 or 2
	check_event EVENT_SET_UNTIL_MAP_RELOAD_2
	script_jump_if_b0nz .lost_rounds
; player won round 1 or 2
	quit_script
	ld a, VAR_GRANDMASTERCUP_CURRENT_ROUND
	farcall GetVarValue
	ld h, $00
	ld l, a
	call LoadTxRam3
	farcall LoadGrandMasterCupCurOpponentName
	ld a, $01
	start_script
	print_npc_text CupHostGrandMasterCupRoundsPlayerWonText
	end_dialog
	move_active_npc .NPCMovement_3e333
	wait_for_player_animation
	start_dialog
	print_npc_text CupHostGrandMasterCupRoundsOpponentEliminatedText
	end_dialog
	quit_script
	farcall GetGrandMasterCupCurOpponent
	farcall GetNPCByDeck_AdjustAmy_PokemonDome
	push af
	ld b, BANK(.NPCMovement_3e33f)
	ASSERT BANK(.NPCMovement_3e338) == BANK(.NPCMovement_3e33f)
	ld hl, .NPCMovement_3e33f
	farcall MoveNPC
	ld a, NPC_CUP_HOST
	ld hl, .NPCMovement_3e338
	farcall MoveNPC
	call Func_3340
	pop af
	farcall ClearOWObject
	ld a, $01
	start_script
	start_dialog
	print_npc_text CupHostGrandMasterCupSeeUpdatedBracketText
	end_dialog
	get_var VAR_GRANDMASTERCUP_CURRENT_ROUND
	compare_loaded_var 1
	script_jump_if_b0nz Script_GrandMasterCupRound2Start
	script_jump Script_GrandMasterCupFinalsStart
.lost_rounds
	quit_script
	ld a, VAR_GRANDMASTERCUP_CURRENT_ROUND
	farcall GetVarValue
	ld h, $00
	ld l, a
	call LoadTxRam3
	farcall LoadGrandMasterCupCurOpponentName
	ld a, $01
	start_script
	print_npc_text CupHostGrandMasterCupRoundsPlayerLost1Text
	print_npc_text CupHostGrandMasterCupRoundsPlayerLost2Text
	end_dialog
	script_jump Script_GrandMasterCupPlayerLost
.NPCMovement_3e333:
	db EAST, MOVE_2
	db SOUTH, MOVE_1
	db $ff
.NPCMovement_3e338:
	db NORTH, MOVE_1
	db WEST, MOVE_2,
	db SOUTH, MOVE_0,
	db $ff
.NPCMovement_3e33f:
	db EAST, MOVE_2
	db SOUTH, MOVE_8
	db $ff

.after_finals
	check_event EVENT_SET_UNTIL_MAP_RELOAD_2
	script_jump_if_b0nz .lost_finals
	print_npc_text CupHostGrandMasterCupFinalsPlayerWon1Text
	quit_script
	farcall SetupAndShowGrandMasterCupBracket
	ld a, $01
	start_script
	print_npc_text CupHostGrandMasterCupFinalsPlayerWon2Text
	end_dialog
	move_active_npc .NPCMovement_3e405
	wait_for_player_animation
	start_dialog
	quit_script
	farcall LoadGrandMasterCupCurOpponentName
	ld a, $01
	start_script
	print_npc_text CupHostGrandMasterCupFinalsOpponentEliminatedText
	quit_script
	ld a, VAR_GRANDMASTERCUP_FINAL_NPC_DECK_ID
	farcall GetVarValue
	farcall GetNPCByDeck
	cp NPC_RONALD
	jr nz, .finals_won_against_club_master
; won against Ronald
	ld a, $01
	start_script
	set_active_npc NPC_RONALD, DialogRonaldText
	print_npc_text RonaldGrandMasterCupFinalsPlayerWonText
	set_active_npc NPC_CUP_HOST, DialogCupHostText
	script_jump .finals_eliminate_opponent
.finals_won_against_club_master
	ld a, $01
	start_script
.finals_eliminate_opponent
	end_dialog
	quit_script
	farcall GetGrandMasterCupCurOpponent
	farcall GetNPCByDeck_AdjustAmy_PokemonDome
	push af
	ld b, BANK(.NPCMovement_3e411)
	ASSERT BANK(.NPCMovement_3e40a) == BANK(.NPCMovement_3e411)
	ld hl, .NPCMovement_3e411
	farcall MoveNPC
	ld a, NPC_CUP_HOST
	ld hl, .NPCMovement_3e40a
	farcall MoveNPC
	call Func_3340
	pop af
	farcall ClearOWObject
	ld a, $01
	start_script
	script_jump Script_GrandMasterCupGrandFinalsStart

.lost_finals
	quit_script
	farcall LoadGrandMasterCupCurOpponentName
	ld a, $01
	start_script
	print_npc_text CupHostGrandMasterCupFinalsPlayerLost1Text
	quit_script
	farcall SetupAndShowGrandMasterCupBracket
	ld a, $01
	start_script
	print_npc_text CupHostGrandMasterCupFinalsPlayerLost2Text
	quit_script
	ld a, VAR_GRANDMASTERCUP_FINAL_NPC_DECK_ID
	farcall GetVarValue
	farcall GetNPCByDeck
	cp NPC_RONALD
	jr nz, .finals_lost_to_club_master
; lost to Ronald
	ld a, $01
	start_script
	set_active_npc NPC_RONALD, DialogRonaldText
	print_npc_text RonaldGrandMasterCupFinalsPlayerLostText
	set_active_npc NPC_CUP_HOST, DialogCupHostText
	script_jump .finals_eliminate_player
.finals_lost_to_club_master
	ld a, $01
	start_script
.finals_eliminate_player
	end_dialog
	script_jump Script_GrandMasterCupPlayerLost
.NPCMovement_3e405:
	db EAST, MOVE_2
	db SOUTH, MOVE_1
	db $ff
.NPCMovement_3e40a:
	db NORTH, MOVE_1
	db WEST, MOVE_2
	db SOUTH, MOVE_0
	db $ff
.NPCMovement_3e411:
	db EAST, MOVE_2
	db SOUTH, MOVE_8
	db $ff

.after_grand_finals
	get_var VAR_GRANDMASTERCUP_GF_GRAND_MASTER_INDEX
	compare_loaded_var GRAND_MASTER_COURTNEY
	script_jump_if_b0nz Script_GrandMasterCupGrandFinalsVsCourtneyAfterDuel
	compare_loaded_var GRAND_MASTER_JACK
	script_jump_if_b1nz Script_GrandMasterCupGrandFinalsVsSteveAfterDuel
	script_jump_if_b0nz Script_GrandMasterCupGrandFinalsVsJackAfterDuel
	script_jump Script_GrandMasterCupGrandFinalsVsRodAfterDuel

Script_GrandMasterCupGrandFinalsStart:
	set_var VAR_GRANDMASTERCUP_CURRENT_ROUND, 4
	start_dialog
	print_npc_text CupHostGrandMasterCupGrandFinalsText
	end_dialog
	set_active_npc NPC_ROD, DialogRodText
	move_active_npc .NPCMovement_3e44e
	wait_for_player_animation
	start_dialog
	print_npc_text RodGrandMasterCupGrandFinalsBracketReveal1Text
	get_random NUM_GRAND_MASTERS
	compare_loaded_var GRAND_MASTER_COURTNEY
	script_jump_if_b0nz Script_GrandMasterCupGrandFinalsVsCourtney
	compare_loaded_var GRAND_MASTER_JACK
	script_jump_if_b1nz Script_GrandMasterCupGrandFinalsVsSteve
	script_jump_if_b0nz Script_GrandMasterCupGrandFinalsVsJack
	script_jump Script_GrandMasterCupGrandFinalsVsRod
.NPCMovement_3e44e:
	db NORTH, MOVE_1
	db WEST, MOVE_4
	db SOUTH, MOVE_0
	db $ff

Script_GrandMasterCupGrandFinalsVsCourtney:
	set_var VAR_GRANDMASTERCUP_GF_GRAND_MASTER_INDEX, GRAND_MASTER_COURTNEY
	set_text_ram2 DialogCourtneyText
	print_npc_text RodGrandMasterCupGrandFinalsBracketReveal2Text
	set_active_npc NPC_CUP_HOST, DialogCupHostText
	print_npc_text CupHostGrandMasterCupGrandFinalsCallCourtneyText
	end_dialog
	move_npc NPC_COURTNEY, .NPCMovement_3e484
	move_npc NPC_ROD, .NPCMovement_3e48d
	wait_for_player_animation
	start_dialog
	set_active_npc NPC_COURTNEY, DialogCourtneyText
	print_npc_text CourtneyGrandMasterCupGrandFinalsText
	set_active_npc NPC_CUP_HOST, DialogCupHostText
	print_npc_text CupHostGrandMasterCupGrandFinalsDuelStartText
	end_dialog
	start_duel GRAND_FIRE_DECK_ID, MUSIC_MATCH_START_GRAND_MASTER
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

Script_GrandMasterCupGrandFinalsVsCourtneyAfterDuel:
	set_active_npc NPC_COURTNEY, DialogCourtneyText
	check_event EVENT_SET_UNTIL_MAP_RELOAD_2
	script_jump_if_b0nz .lost_to_courtney
	print_npc_text CourtneyTournamentsPlayerWonText
	script_jump Script_GrandMasterCupChampion
.lost_to_courtney
	print_npc_text CourtneyGrandMasterCupGrandFinalsPlayerLostText
	set_active_npc NPC_CUP_HOST, DialogCupHostText
	set_text_ram2 DialogCourtneyText
	print_npc_text CupHostGrandMasterCupGrandFinalsPlayerLostText
	end_dialog
	script_jump Script_GrandMasterCupPlayerLost

Script_GrandMasterCupGrandFinalsVsSteve:
	set_var VAR_GRANDMASTERCUP_GF_GRAND_MASTER_INDEX, GRAND_MASTER_STEVE
	set_text_ram2 DialogSteveText
	print_npc_text RodGrandMasterCupGrandFinalsBracketReveal2Text
	set_active_npc NPC_CUP_HOST, DialogCupHostText
	print_npc_text CupHostGrandMasterCupGrandFinalsCallSteveText
	end_dialog
	move_npc NPC_STEVE, .NPCMovement_3e4e3
	move_npc NPC_ROD, .NPCMovement_3e4ee
	wait_for_player_animation
	start_dialog
	set_active_npc NPC_STEVE, DialogSteveText
	print_npc_text SteveGrandMasterCupGrandFinalsText
	set_active_npc NPC_CUP_HOST, DialogCupHostText
	print_npc_text CupHostGrandMasterCupGrandFinalsDuelStartText
	end_dialog
	start_duel LEGENDARY_FOSSIL_DECK_ID, MUSIC_MATCH_START_GRAND_MASTER
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

Script_GrandMasterCupGrandFinalsVsSteveAfterDuel:
	set_active_npc NPC_STEVE, DialogSteveText
	check_event EVENT_SET_UNTIL_MAP_RELOAD_2
	script_jump_if_b0nz .lost_to_steve
	print_npc_text SteveTournamentsPlayerWonText
	script_jump Script_GrandMasterCupChampion
.lost_to_steve
	print_npc_text SteveTournamentsPlayerLostText
	set_active_npc NPC_CUP_HOST, DialogCupHostText
	set_text_ram2 DialogSteveText
	print_npc_text CupHostGrandMasterCupGrandFinalsPlayerLostText
	end_dialog
	script_jump Script_GrandMasterCupPlayerLost

Script_GrandMasterCupGrandFinalsVsJack:
	set_var VAR_GRANDMASTERCUP_GF_GRAND_MASTER_INDEX, GRAND_MASTER_JACK
	set_text_ram2 DialogJackText
	print_npc_text RodGrandMasterCupGrandFinalsBracketReveal2Text
	set_active_npc NPC_CUP_HOST, DialogCupHostText
	print_npc_text CupHostGrandMasterCupGrandFinalsCallJackText
	end_dialog
	move_npc NPC_JACK, .NPCMovement_3e544
	move_npc NPC_ROD, .NPCMovement_3e54b
	wait_for_player_animation
	start_dialog
	set_active_npc NPC_JACK, DialogJackText
	print_npc_text JackGrandMasterCupGrandFinalsText
	set_active_npc NPC_CUP_HOST, DialogCupHostText
	print_npc_text CupHostGrandMasterCupGrandFinalsDuelStartText
	end_dialog
	start_duel WATER_LEGEND_DECK_ID, MUSIC_MATCH_START_GRAND_MASTER
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

Script_GrandMasterCupGrandFinalsVsJackAfterDuel:
	set_active_npc NPC_JACK, DialogJackText
	check_event EVENT_SET_UNTIL_MAP_RELOAD_2
	script_jump_if_b0nz .lost_to_jack
	print_npc_text JackGrandMasterCupGrandFinalsPlayerWonText
	script_jump Script_GrandMasterCupChampion
.lost_to_jack
	print_npc_text JackTournamentsPlayerLostText
	set_active_npc NPC_CUP_HOST, DialogCupHostText
	set_text_ram2 DialogJackText
	print_npc_text CupHostGrandMasterCupGrandFinalsPlayerLostText
	end_dialog
	script_jump Script_GrandMasterCupPlayerLost

Script_GrandMasterCupGrandFinalsVsRod:
	set_var VAR_GRANDMASTERCUP_GF_GRAND_MASTER_INDEX, GRAND_MASTER_ROD
	set_text_ram2 DialogRodText
	print_npc_text RodGrandMasterCupGrandFinalsBracketReveal2Text
	set_active_npc NPC_CUP_HOST, DialogCupHostText
	print_npc_text CupHostGrandMasterCupGrandFinalsCallRodText
	end_dialog
	move_npc NPC_ROD, .NPCMovement_3e59d
	wait_for_player_animation
	start_dialog
	set_active_npc NPC_ROD, DialogRodText
	print_npc_text RodGrandMasterCupGrandFinalsText
	set_active_npc NPC_CUP_HOST, DialogCupHostText
	print_npc_text CupHostGrandMasterCupGrandFinalsDuelStartText
	end_dialog
	start_duel GREAT_DRAGON_DECK_ID, MUSIC_MATCH_START_GRAND_MASTER
	end_script
	ret
.NPCMovement_3e59d:
	db EAST, MOVE_1
	db SOUTH, MOVE_2
	db WEST, MOVE_0
	db $ff

Script_GrandMasterCupGrandFinalsVsRodAfterDuel:
	set_active_npc NPC_ROD, DialogRodText
	check_event EVENT_SET_UNTIL_MAP_RELOAD_2
	script_jump_if_b0nz .lost_to_rod
	print_npc_text RodTournamentsPlayerWonText
	script_jump Script_GrandMasterCupChampion
.lost_to_rod
	print_npc_text RodTournamentsPlayerLostText
	set_active_npc NPC_CUP_HOST, DialogCupHostText
	set_text_ram2 DialogRodText
	print_npc_text CupHostGrandMasterCupGrandFinalsPlayerLostText
	end_dialog
	script_jump Script_GrandMasterCupPlayerLost

Script_GrandMasterCupChampion:
	set_event EVENT_WON_GRAND_MASTER_CUP
	set_var VAR_GRAND_MASTER_CUP_STATE, GRAND_MASTER_CUP_RESULT_WON
	set_event EVENT_SET_UNTIL_MAP_RELOAD_1
	set_active_npc NPC_CUP_HOST, DialogCupHostText
	print_npc_text CupHostGrandMasterCupGrandFinalsPlayerWonText
	play_song MUSIC_GRAND_MASTER_CUP_CHAMPION
	print_npc_text CupHostGrandMasterCupPlayerChampionText
	wait_song
	resume_song
	end_dialog
	move_active_npc .NPCMovement_3e658
	wait_for_player_animation
	set_player_direction NORTH
	start_dialog
	print_npc_text CupHostGrandMasterCupChampionPrizeSelectionText
	quit_script
	xor a
.loop_load_prizes
	farcall GetGrandMasterCupPrizeCardID
	farcall GetGrandMasterCupPrizeCardName
	farcall LoadGrandMasterCupPrizeCardData
	inc a
	cp NUM_GRANDMASTERCUP_PRIZE_CANDIDATES
	jr c, .loop_load_prizes
	farcall SelectGrandMasterCupPrizes
	push bc
	ld hl, wScriptNPCName
	ld a, [hli]
	ld d, [hl]
	ld e, a
	ldtx hl, CupHostGrandMasterCupChampionPrizesText
	farcall PrintScrollableText_WithTextBoxLabelVRAM0
	pop bc
	farcall Func_1022a
	push bc
	ld a, b
	farcall GetGrandMasterCupPrizeCardID
	ld e, c
	ld d, b
	farcall Func_c646
	pop bc
	ld a, c
	farcall GetGrandMasterCupPrizeCardID
	ld e, c
	ld d, b
	farcall Func_c646
	farcall Func_10252
	call WaitPalFading

	ld a, $01
	start_script
	check_event EVENT_GOT_ARBOK_COIN
	script_jump_if_b0z .repeat_champion
	print_npc_text CupHostGrandMasterCupFirstChampionRewardsText
	set_event EVENT_GOT_ARBOK_COIN
	give_coin COIN_ARBOK
	print_npc_text CupHostGrandMasterCupPlayerFirstChampionCongratsText
	script_jump .closing
.repeat_champion
	print_npc_text CupHostGrandMasterCupPlayerChampionCongratsText
.closing
	print_npc_text CupHostGrandMasterCupPlayerChampionClosingText
	end_dialog
	end_script
	ld a, MAP_POKEMON_DOME
	lb de, 7, 1
	ld b, SOUTH
	farcall SetWarpData
	ret
.NPCMovement_3e658:
	db WEST, MOVE_1
	db SOUTH, MOVE_1
	db $ff

Script_GrandMasterCupPlayerLost:
	set_var VAR_GRAND_MASTER_CUP_STATE, GRAND_MASTER_CUP_RESULT_LOST
	set_event EVENT_SET_UNTIL_MAP_RELOAD_1
	set_active_npc NPC_CUP_HOST, DialogCupHostText
	move_active_npc .NPCMovement_3e681
	wait_for_player_animation
	start_dialog
	print_npc_text CupHostGrandMasterCupPlayerLostEliminatedText
	end_dialog
	move_player .NPCMovement_3e686, TRUE
	wait_for_player_animation
	end_script
	ld a, MAP_POKEMON_DOME
	lb de, 7, 1
	ld b, SOUTH
	farcall SetWarpData
	ret
.NPCMovement_3e681:
	db WEST, MOVE_1
	db SOUTH, MOVE_1
	db $ff
.NPCMovement_3e686:
	db WEST, MOVE_2
	db SOUTH, MOVE_8
	db $ff

PokemonDomeBack_AppearOnPostgame:
	ld a, EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE
	farcall GetEventValue
	jr nz, .appear
	scf
	ret
.appear
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
	npc NPC_ISHIHARA, 6, 5, WEST, IshiharasVillaMain_IshiharaAppearanceCheck
	npc NPC_ISHIHARAS_VILLA_GR_GAL, 2, 2, NORTH, IshiharasVillaMain_DisappearIfInGRCastle
	db $ff

IshiharasVillaMain_NPCInteractions:
	npc_script NPC_ISHIHARA, Script_IshiharaAtVillaMain
	npc_script NPC_ISHIHARAS_VILLA_GR_GAL, Script_RuiAtVillaMain
	db $ff

IshiharasVillaMain_OWInteractions:
	ow_script 7, 2, PCMenu
	ow_script 8, 2, PCMenu
	db $ff

IshiharasVillaMain_MapScripts:
	dbw OWMODE_STEP_EVENT, Func_3e72a
	dbw OWMODE_INTERACT, Func_3e73a
	dbw OWMODE_AFTER_DUEL, Func_3e7bb
	dbw OWMODE_NPC_POSITION, Func_3e731
	dbw OWMODE_SAVE_PRELOAD, Func_3e74a
	dbw OWMODE_SAVE_POSTLOAD, Func_3e778
	dbw OWMODE_CONTINUE_OW, Func_3e787
	dbw OWMODE_MUSIC_PRELOAD, Func_3e704
	db $ff

Func_3e704:
	ld a, VAR_ISHIHARA_STATE
	farcall GetVarValue
	cp ISHIHARA_TRADE_3_DONE
	jr c, .asm_3e722
	jr z, .asm_3e71a
	ld a, EVENT_ISHIHARA_LOCATION_STATE
	farcall GetEventValue
	jr nz, .asm_3e722
	jr .asm_3e727
.asm_3e71a
	ld a, EVENT_ISHIHARA_CARD_TRADE_STATE
	farcall GetEventValue
	jr z, .asm_3e727
.asm_3e722
	ld a, MUSIC_GR_OVERWORLD
	ld [wNextMusic], a
.asm_3e727
	scf
	ccf
	ret

Func_3e72a:
	ld hl, IshiharasVillaMain_StepEvents
	call ExecutePlayerCoordScript
	ret

Func_3e731:
	ld hl, IshiharasVillaMain_NPCs
	call LoadNPCs
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
	ld a, EVENT_ISHIHARA_LOCATION_STATE
	farcall GetEventValue
	jr z, .skip_bit0
	pop af
	or $01
	push af
.skip_bit0
	ld a, EVENT_ISHIHARA_CARD_TRADE_STATE
	farcall GetEventValue
	jr z, .skip_bit1
	pop af
	or $02
	push af
.skip_bit1
	pop af
	or a
	jr z, .done
	ld c, a
	ld a, VAR_00
	farcall SetVarValue
	ld a, EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE_DUMMY
	farcall MaxOutEventValue
.done
	scf
	ccf
	ret

Func_3e778:
	ld a, EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE_DUMMY
	farcall ZeroOutEventValue
	ld a, VAR_00
	farcall ZeroOutVarValue
	scf
	ccf
	ret

Func_3e787:
	ld a, EVENT_ISHIHARA_LOCATION_STATE
	farcall ZeroOutEventValue
	ld a, VAR_00
	farcall GetVarValue
	bit 0, a
	push af
	call nz, .SetLocationFlag
	pop af
	bit 1, a
	call nz, .SetTradeFlag
	ld a, EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE_DUMMY
	farcall ZeroOutEventValue
	ld a, VAR_00
	farcall ZeroOutVarValue
	scf
	ret

.SetLocationFlag:
	ld a, EVENT_ISHIHARA_LOCATION_STATE
	farcall MaxOutEventValue
	ret

.SetTradeFlag:
	ld a, EVENT_ISHIHARA_CARD_TRADE_STATE
	farcall MaxOutEventValue
	ret

Func_3e7bb:
	call Script_IshiharaAfterDuel
	scf
	ret

Script_IshiharaAtVillaMain:
	ld a, EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE
	farcall GetEventValue
	jr z, .duel
	ld a, EVENT_TALKED_TO_ISHIHARA_POST_GAME
	farcall GetEventValue
	jr nz, .duel
	jp Script_IshiharaCongratsAtVillaMain
.duel
	jp Script_IshiharaDuel

IshiharasVillaMain_IshiharaAppearanceCheck:
	ld a, VAR_ISHIHARA_STATE
	farcall GetVarValue
	cp ISHIHARA_TRADE_7_DONE_COMPLETE
	jr c, .disappear
	ld a, EVENT_ISHIHARA_CARD_TRADE_STATE
	farcall GetEventValue
	jr nz, .disappear
	ld a, EVENT_ISHIHARA_LOCATION_STATE
	farcall GetEventValue
	jr nz, .disappear
	scf
	ccf
	ret
.disappear
	scf
	ret

Script_IshiharaDuel:
	ld a, NPC_ISHIHARA
	ld [wScriptNPC], a
	ldtx hl, DialogMrIshiharaText
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [wScriptNPCName + 1], a
	xor a
	start_script
	start_dialog
	get_player_opposite_direction
	restore_active_npc_direction
	check_event EVENT_TALKED_TO_ISHIHARA
	script_jump_if_b0z .repeat
	set_event EVENT_TALKED_TO_ISHIHARA
	print_npc_text IshiharaWantsToDuelInitialText
	script_jump .duel_prompt
.repeat
	print_npc_text IshiharaWantsToDuelRepeatText
.duel_prompt
	ask_question IshiharaDuelPromptText, TRUE
	script_jump_if_b0z .declined
	script_call Script_SeatPlayerAtIshiharaDuelTable
	print_npc_text IshiharaDuelStartText
	end_dialog
	start_duel VERY_RARE_CARD_DECK_ID, MUSIC_MATCH_START_MEMBER
	end_script
	ret
.declined
	print_npc_text IshiharaDeclinedDuelText
	end_dialog
	end_script
	ret

Script_IshiharaAfterDuel:
	xor a
	start_script
	start_dialog
	check_event EVENT_SET_UNTIL_MAP_RELOAD_2
	script_jump_if_b0nz .player_lost
	set_event EVENT_BATTLED_ISHIHARA
	print_npc_text IshiharaPlayerWon1Text
	give_booster_packs BoosterList_Ishihara
	print_npc_text IshiharaPlayerWon2Text
	script_jump .done
.player_lost
	print_npc_text IshiharaPlayerLostText
.done
	end_dialog
	end_script
	ret

Script_IshiharaCongratsAtVillaMain:
	ld a, NPC_ISHIHARA
	ld [wScriptNPC], a
	ldtx hl, DialogMrIshiharaText
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [wScriptNPCName + 1], a
	xor a
	start_script
	start_dialog
	get_player_opposite_direction
	restore_active_npc_direction
	set_event EVENT_TALKED_TO_ISHIHARA_POST_GAME
	print_npc_text IshiharaDefeatedBiruritchiCongratsText
	end_dialog
	end_script
	ret

Script_SeatPlayerAtIshiharaDuelTable:
	end_dialog
	set_active_npc_direction WEST
	get_player_direction
	compare_loaded_var NORTH
	script_jump_if_b0nz .ows_3e88f
	compare_loaded_var WEST
	script_jump_if_b0nz .ows_3e888
	move_player .NPCMovement_3e896, TRUE
	script_jump .ows_3e893
.ows_3e888
	move_player .NPCMovement_3e89f, TRUE
	script_jump .ows_3e893
.ows_3e88f
	move_player .NPCMovement_3e8a8, TRUE
.ows_3e893
	wait_for_player_animation
	start_dialog
	script_ret
.NPCMovement_3e896:
	db NORTH, MOVE_1
	db WEST, MOVE_3
	db SOUTH, MOVE_2
	db EAST, MOVE_0
	db $ff
.NPCMovement_3e89f:
	db SOUTH, MOVE_2
	db WEST, MOVE_4
	db NORTH, MOVE_2
	db EAST, MOVE_0
	db $ff
.NPCMovement_3e8a8:
	db SOUTH, MOVE_1
	db WEST, MOVE_3
	db NORTH, MOVE_2
	db EAST, MOVE_0
	db $ff

Script_RuiAtVillaMain:
	ld a, NPC_ISHIHARAS_VILLA_GR_GAL
	ld [wScriptNPC], a
	ldtx hl, DialogRuiText
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [wScriptNPCName + 1], a
	xor a
	start_script
	start_dialog
	print_npc_text RuiStudyingAtIshiharasVilla1Text
	get_player_opposite_direction
	restore_active_npc_direction
	print_npc_text RuiStudyingAtIshiharasVilla2Text
	end_dialog
	set_active_npc_direction NORTH
	end_script
	ret

IshiharasVillaMain_DisappearIfInGRCastle:
	ld a, EVENT_GR_CASTLE_ENTRANCE_DOOR_STATE
	farcall GetEventValue
	jr nz, .disappear
	scf
	ccf
	ret
.disappear
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
	npc NPC_ISHIHARA, 5, 4, SOUTH, IshiharasVillaLibrary_IshiharaAppearanceCheck
	npc NPC_ISHIHARAS_VILLA_GR_GAL, 4, 2, NORTH, IshiharasVillaLibrary_RuiAppearanceCheck
	db $ff

IshiharasVillaLibrary_NPCInteractions:
	npc_script NPC_ISHIHARA, Script_IshiharaAtVillaLibrary
	npc_script NPC_ISHIHARAS_VILLA_GR_GAL, Script_RuiAtVillaLibrary
	db $ff

IshiharasVillaLibrary_OWInteractions:
	ow_script 1, 2, Script_PhantomCardsBook
	ow_script 2, 2, Script_DarkPokemonBook
	ow_script 3, 2, Script_AugmentBasicPokemonBook
	ow_script 6, 2, Script_GRKingCardsBook
	ow_script 7, 2, Script_SpecialEnergyBook
	ow_script 8, 2, Script_GetCoinsBook
	db $ff

IshiharasVillaLibrary_MapScripts:
	dbw OWMODE_STEP_EVENT, Func_3e981
	dbw OWMODE_INTERACT, Func_3e991
	dbw OWMODE_NPC_POSITION, Func_3e988
	dbw OWMODE_SAVE_PRELOAD, Func_3e9a1
	dbw OWMODE_SAVE_POSTLOAD, Func_3e9cf
	dbw OWMODE_CONTINUE_OW, Func_3e9de
	dbw OWMODE_MUSIC_PRELOAD, Func_3e95b
	db $ff

Func_3e95b:
	ld a, VAR_ISHIHARA_STATE
	farcall GetVarValue
	cp ISHIHARA_TRADE_3_DONE
	jr c, .asm_3e979
	jr z, .asm_3e971
	ld a, EVENT_ISHIHARA_LOCATION_STATE
	farcall GetEventValue
	jr nz, .asm_3e979
	jr .asm_3e97e
.asm_3e971
	ld a, EVENT_ISHIHARA_CARD_TRADE_STATE
	farcall GetEventValue
	jr z, .asm_3e97e
.asm_3e979
	ld a, MUSIC_GR_OVERWORLD
	ld [wNextMusic], a
.asm_3e97e
	scf
	ccf
	ret

Func_3e981:
	ld hl, IshiharasVillaLibrary_StepEvents
	call ExecutePlayerCoordScript
	ret

Func_3e988:
	ld hl, IshiharasVillaLibrary_NPCs
	call LoadNPCs
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
	ld a, EVENT_ISHIHARA_LOCATION_STATE
	farcall GetEventValue
	jr z, .skip_bit0
	pop af
	or $01
	push af
.skip_bit0
	ld a, EVENT_ISHIHARA_CARD_TRADE_STATE
	farcall GetEventValue
	jr z, .skip_bit1
	pop af
	or $02
	push af
.skip_bit1
	pop af
	or a
	jr z, .done
	ld c, a
	ld a, VAR_00
	farcall SetVarValue
	ld a, EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE_DUMMY
	farcall MaxOutEventValue
.done
	scf
	ccf
	ret

Func_3e9cf:
	ld a, EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE_DUMMY
	farcall ZeroOutEventValue
	ld a, VAR_00
	farcall ZeroOutVarValue
	scf
	ccf
	ret

Func_3e9de:
	ld a, EVENT_ISHIHARA_LOCATION_STATE
	farcall ZeroOutEventValue
	ld a, VAR_00
	farcall GetVarValue
	bit 0, a
	push af
	call nz, .SetLocationFlag
	pop af
	bit 1, a
	call nz, .SetTradeFlag
	ld a, EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE_DUMMY
	farcall ZeroOutEventValue
	ld a, VAR_00
	farcall ZeroOutVarValue
	scf
	ret

.SetLocationFlag:
	ld a, EVENT_ISHIHARA_LOCATION_STATE
	farcall MaxOutEventValue
	ret

.SetTradeFlag:
	ld a, EVENT_ISHIHARA_CARD_TRADE_STATE
	farcall MaxOutEventValue
	ret

Script_IshiharaAtVillaLibrary:
	ld a, EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE
	farcall GetEventValue
	jr z, .asm_3ea25
	ld a, EVENT_TALKED_TO_ISHIHARA_POST_GAME
	farcall GetEventValue
	jr nz, .asm_3ea25
	jp Script_IshiharaCongratsAtVillaLibrary
.asm_3ea25
	ld a, EVENT_ISHIHARA_CARD_TRADE_STATE
	farcall GetEventValue
	jr z, .asm_3ea3b
	ld a, VAR_ISHIHARA_STATE
	farcall GetVarValue
	cp ISHIHARA_TALKED_AT_VILLA
	jp z, Script_IshiharaVillaWelcome
	jp Script_IshiharaTradeLaterAtVilla
.asm_3ea3b
	ld a, VAR_ISHIHARA_STATE
	farcall GetVarValue
	sub ISHIHARA_TRADE_3_DONE
	jp z, Script_IshiharaVillaWelcome ; ISHIHARA_TRADE_3_DONE
	dec a
	jp z, Script_IshiharaTrade4       ; ISHIHARA_TALKED_AT_VILLA
	dec a
	jp z, Script_IshiharaTrade5       ; ISHIHARA_TRADE_4_DONE
	dec a
	jp z, Script_IshiharaTrade6       ; ISHIHARA_TRADE_5_DONE
	jp Script_IshiharaTrade7          ; ISHIHARA_TRADE_6_DONE

IshiharasVillaLibrary_IshiharaAppearanceCheck:
	ld a, VAR_ISHIHARA_STATE
	farcall GetVarValue
	cp ISHIHARA_TRADE_3_DONE
	jr c, .disappear
	jr z, .asm_3ea6f
	cp ISHIHARA_TRADE_7_DONE_COMPLETE
	jr z, .asm_3ea79
	ld a, EVENT_ISHIHARA_LOCATION_STATE
	farcall GetEventValue
	jr nz, .disappear
	jr .appear
.asm_3ea6f
	ld a, EVENT_ISHIHARA_CARD_TRADE_STATE
	farcall GetEventValue
	jr nz, .disappear
	jr .appear
.asm_3ea79
	ld a, EVENT_ISHIHARA_CARD_TRADE_STATE
	farcall GetEventValue
	jr z, .disappear
.appear
	scf
	ccf
	ret
.disappear
	scf
	ret

Script_IshiharaVillaWelcome:
	ld a, NPC_ISHIHARA
	ld [wScriptNPC], a
	ldtx hl, DialogMrIshiharaText
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [wScriptNPCName + 1], a
	xor a
	start_script
	start_dialog
	check_event EVENT_ISHIHARA_CARD_TRADE_STATE
	script_jump_if_b0z .repeat
	set_var VAR_ISHIHARA_STATE, ISHIHARA_TALKED_AT_VILLA
	set_event EVENT_ISHIHARA_CARD_TRADE_STATE
	print_npc_text IshiharaMyVillaText
	script_jump .done
.repeat
	print_npc_text IshiharaVillaSeeYouLaterText
.done
	end_dialog
	end_script
	ret

Script_IshiharaTrade4:
	ld a, NPC_ISHIHARA
	ld [wScriptNPC], a
	ldtx hl, DialogMrIshiharaText
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [wScriptNPCName + 1], a
	xor a
	start_script
	start_dialog
	check_event EVENT_TALKED_TO_ISHIHARA
	script_jump_if_b0z .repeat
	set_event EVENT_TALKED_TO_ISHIHARA
	print_npc_text IshiharaWantsToTrade4InitialText
	script_jump .trade_prompt
.repeat
	print_npc_text IshiharaWantsToTrade4RepeatText
.trade_prompt
	ask_question TradeCardsPromptText, TRUE
	script_jump_if_b0nz .count_cards
	print_npc_text IshiharaDeclinedTradeText
	script_jump .done
.count_cards
	get_card_count_in_collection_and_decks MOLTRES_LV37
	script_jump_if_b0z .count_cards_outside_decks
	print_npc_text IshiharaDoNotOwnMoltresLv37Text
	script_jump .done
.count_cards_outside_decks
	get_card_count_in_collection MOLTRES_LV37
	script_jump_if_b0z .start_trade
	print_npc_text IshiharaUsingAllMoltresLv37InDecksText
	script_jump .done
.start_trade
	print_npc_text IshiharaAcceptedTrade4Text
	print_text TradedMoltresForSurfingPikachuText
	receive_card SURFING_PIKACHU_ALT_LV13
	take_card MOLTRES_LV37
	set_event EVENT_ISHIHARA_CARD_TRADE_STATE
	reset_event EVENT_TALKED_TO_ISHIHARA
	set_var VAR_ISHIHARA_STATE, ISHIHARA_TRADE_4_DONE
	print_npc_text IshiharaThanksTradedMoltresLv37Text
.done
	end_dialog
	end_script
	ret

Script_IshiharaTrade5:
	ld a, NPC_ISHIHARA
	ld [wScriptNPC], a
	ldtx hl, DialogMrIshiharaText
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [wScriptNPCName + 1], a
	xor a
	start_script
	start_dialog
	check_event EVENT_TALKED_TO_ISHIHARA
	script_jump_if_b0z .repeat
	set_event EVENT_TALKED_TO_ISHIHARA
	print_npc_text IshiharaWantsToTrade5InitialText
	script_jump .trade_prompt
.repeat
	print_npc_text IshiharaWantsToTrade5RepeatText
.trade_prompt
	ask_question TradeCardsPromptText, TRUE
	script_jump_if_b0nz .count_cards
	print_npc_text IshiharaDeclinedTradeText
	script_jump .done
.count_cards
	get_card_count_in_collection_and_decks ARTICUNO_LV34
	script_jump_if_b0z .count_cards_outside_decks
	print_npc_text IshiharaDoNotOwnArticunoLv34Text
	script_jump .done
.count_cards_outside_decks
	get_card_count_in_collection ARTICUNO_LV34
	script_jump_if_b0z .start_trade
	print_npc_text IshiharaUsingAllArticunoLv34InDecksText
	script_jump .done
.start_trade
	print_npc_text IshiharaAcceptedTrade5Text
	print_text TradedArticunoLv34ForSurfingPikachuText
	receive_card SURFING_PIKACHU_LV13
	take_card ARTICUNO_LV34
	set_event EVENT_ISHIHARA_CARD_TRADE_STATE
	reset_event EVENT_TALKED_TO_ISHIHARA
	set_var VAR_ISHIHARA_STATE, ISHIHARA_TRADE_5_DONE
	print_npc_text IshiharaThanksTradedArticunoLv34Text
.done
	end_dialog
	end_script
	ret

Script_IshiharaTrade6:
	ld a, NPC_ISHIHARA
	ld [wScriptNPC], a
	ldtx hl, DialogMrIshiharaText
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [wScriptNPCName + 1], a
	xor a
	start_script
	start_dialog
	check_event EVENT_TALKED_TO_ISHIHARA
	script_jump_if_b0z .repeat
	set_event EVENT_TALKED_TO_ISHIHARA
	print_npc_text IshiharaWantsToTrade6InitialText
	script_jump .trade_prompt
.repeat
	print_npc_text IshiharaWantsToTrade6RepeatText
.trade_prompt
	ask_question TradeCardsPromptText, TRUE
	script_jump_if_b0nz .count_cards
	print_npc_text IshiharaDeclinedTradeText
	script_jump .done
.count_cards
	get_card_count_in_collection_and_decks ZAPDOS_LV40
	script_jump_if_b0z .count_cards_outside_decks
	print_npc_text IshiharaDoNotOwnZapdosLv40Text
	script_jump .done
.count_cards_outside_decks
	get_card_count_in_collection ZAPDOS_LV40
	script_jump_if_b0z .start_trade
	print_npc_text IshiharaUsingAllZapdosLv40InDecksText
	script_jump .done
.start_trade
	print_npc_text IshiharaAcceptedTrade6Text
	print_text TradedZapdosLv40ForFlyingPikachuText
	receive_card FLYING_PIKACHU_LV12
	take_card ZAPDOS_LV40
	set_event EVENT_ISHIHARA_CARD_TRADE_STATE
	reset_event EVENT_TALKED_TO_ISHIHARA
	set_var VAR_ISHIHARA_STATE, ISHIHARA_TRADE_6_DONE
	print_npc_text IshiharaThanksTradedZapdosLv40Text
.done
	end_dialog
	end_script
	ret

Script_IshiharaTrade7:
	ld a, NPC_ISHIHARA
	ld [wScriptNPC], a
	ldtx hl, DialogMrIshiharaText
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [wScriptNPCName + 1], a
	xor a
	start_script
	start_dialog
	check_event EVENT_TALKED_TO_ISHIHARA
	script_jump_if_b0z .repeat
	set_event EVENT_TALKED_TO_ISHIHARA
	print_npc_text IshiharaWantsToTrade7InitialText
	script_jump .trade_prompt
.repeat
	print_npc_text IshiharaWantsToTrade7RepeatText
.trade_prompt
	ask_question TradeCardsPromptText, TRUE
	script_jump_if_b0nz .count_cards
	print_npc_text IshiharaDeclinedTradeText
	script_jump .done
.count_cards
	get_card_count_in_collection_and_decks DARK_DRAGONITE
	script_jump_if_b0z .count_cards_outside_decks
	print_npc_text IshiharaDoNotOwnDarkDragoniteText
	script_jump .done
.count_cards_outside_decks
	get_card_count_in_collection DARK_DRAGONITE
	script_jump_if_b0z .start_trade
	print_npc_text IshiharaUsingAllDarkDragoniteInDecksText
	script_jump .done
.start_trade
	print_npc_text IshiharaAcceptedTrade7Text
	print_text TradedDarkDragoniteForBillsComputerText
	receive_card BILLS_COMPUTER
	take_card DARK_DRAGONITE
	set_event EVENT_ISHIHARA_CARD_TRADE_STATE
	reset_event EVENT_TALKED_TO_ISHIHARA
	set_var VAR_ISHIHARA_STATE, ISHIHARA_TRADE_7_DONE_COMPLETE
	print_npc_text IshiharaThanksTradedDarkDragoniteTradesCompleteText
.done
	end_dialog
	end_script
	ret

Script_IshiharaTradeLaterAtVilla:
	ld a, NPC_ISHIHARA
	ld [wScriptNPC], a
	ldtx hl, DialogMrIshiharaText
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [wScriptNPCName + 1], a
	xor a
	start_script
	start_dialog
	print_npc_text IshiharaAtVillaTradeLaterReadMyBooksText
	end_dialog
	end_script
	ret

Script_IshiharaCongratsAtVillaLibrary:
	ld a, NPC_ISHIHARA
	ld [wScriptNPC], a
	ldtx hl, DialogMrIshiharaText
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [wScriptNPCName + 1], a
	xor a
	start_script
	start_dialog
	set_event EVENT_TALKED_TO_ISHIHARA_POST_GAME
	print_npc_text IshiharaDefeatedBiruritchiCongratsText
	end_dialog
	end_script
	ret

Script_RuiAtVillaLibrary:
	ld a, NPC_ISHIHARAS_VILLA_GR_GAL
	ld [wScriptNPC], a
	ldtx hl, DialogRuiText
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [wScriptNPCName + 1], a
	xor a
	start_script
	start_dialog
	set_event EVENT_MET_GR_GAL_ISHIHARAS_VILLA
	get_player_opposite_direction
	restore_active_npc_direction
	print_npc_text RuiStudyingAtIshiharasVillaPostgameText
	end_dialog
	get_player_direction
	compare_loaded_var NORTH
	script_jump_if_b0z .skip_player_reposition
	set_player_direction EAST
	animate_player_movement $83, $02
.skip_player_reposition
	check_npc_loaded NPC_ISHIHARA
	script_jump_if_b1nz .no_ishihara
	move_active_npc .NPCMovement_3ecca
	wait_for_player_animation
	start_dialog
	print_npc_text RuiThanksIshiharaText
	set_active_npc NPC_ISHIHARA, DialogMrIshiharaText
	set_active_npc_direction WEST
	print_npc_text IshiharaGladToHelpRuiText
	set_active_npc NPC_ISHIHARAS_VILLA_GR_GAL, DialogRuiText
	print_npc_text RuiGoodbyeIshiharaText
	end_dialog
	move_active_npc .NPCMovement_3eccf
	wait_for_player_animation
	script_jump .done
.no_ishihara
	move_active_npc .NPCMovement_3ecd2
	wait_for_player_animation
.done
	unload_npc NPC_ISHIHARAS_VILLA_GR_GAL
	end_script
	ret
.NPCMovement_3ecca:
	db SOUTH, MOVE_2
	db EAST, MOVE_0
	db $ff
.NPCMovement_3eccf:
	db SOUTH, MOVE_5
	db $ff
.NPCMovement_3ecd2:
	db SOUTH, MOVE_7
	db $ff

IshiharasVillaLibrary_RuiAppearanceCheck:
	ld a, EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE
	farcall GetEventValue
	jr z, .disappear
	ld a, EVENT_MET_GR_GAL_ISHIHARAS_VILLA
	farcall GetEventValue
	jr nz, .disappear
	scf
	ccf
	ret
.disappear
	scf
	ret

GameCenterEntrance_MapHeader:
	db MAP_GFX_GAME_CENTER_ENTRANCE
	dba GameCenterEntrance_MapScripts
	db MUSIC_GAME_CENTER

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
	npc NPC_GR_CLERK_GAME_CENTER_PRIZE_DESK, 9, 2, SOUTH, NULL
	npc NPC_GR_CLERK_GAME_CENTER_CHIP_DESK, 2, 2, SOUTH, NULL
	npc NPC_CHIP_GIRL, 5, 2, SOUTH, NULL
	npc NPC_CHIP_SECURITY, 4, 9, EAST, NULL
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
	dbw OWMODE_STEP_EVENT, Func_3ed92
	dbw OWMODE_INTERACT, Func_3eda2
	dbw OWMODE_NPC_POSITION, Func_3ed99
	db $ff

Func_3ed92:
	ld hl, GameCenterEntrance_StepEvents
	call ExecutePlayerCoordScript
	ret

Func_3ed99:
	ld hl, GameCenterEntrance_NPCs
	call LoadNPCs
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
	ld a, NPC_GR_CLERK_GAME_CENTER_CHIP_DESK
	ld [wScriptNPC], a
	ldtx hl, DialogReceptionistText
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [wScriptNPCName + 1], a
	xor a
	start_script
	start_dialog
	print_npc_text GameCenterChipDeskWelcomeText
	get_game_center_chips
	compare_loaded_var_word 0
	script_jump_if_b0z .ows_3edfd
	get_game_center_banked_chips
	compare_loaded_var_word 0
	script_jump_if_b0z .ows_3ede0
	script_jump .ows_3ee0e
.ows_3ede0
	load_text_ram3
	print_npc_text GameCenterChipDeskDepositInfoText
	npc_ask_question GameCenterChipDeskDepositReturnPromptText, TRUE
	script_jump_if_b0z .ows_3edf7
	print_npc_text GameCenterChipDeskDepositReturnedText
	show_chips_hud
	withdraw_chips
	print_npc_text GameCenterChipDeskDepositReminderText
	hide_chips_hud
	script_jump .ows_3ee0e
.ows_3edf7
	print_npc_text GameCenterChipDeskComeAgainText
	script_jump .ows_3ee0e
.ows_3edfd
	load_text_ram3
	show_chips_hud
	npc_ask_question GameCenterChipDeskDepositPromptText, TRUE
	script_jump_if_b0z .ows_3ee0a
	deposit_chips
	print_npc_text GameCenterChipDeskDepositedText
.ows_3ee0a
	print_npc_text GameCenterChipDeskComeAgainText
	hide_chips_hud
.ows_3ee0e
	end_dialog
	end_script
	ret

Func_3ee11:
	ld a, NPC_CHIP_GIRL
	ld [wScriptNPC], a
	ldtx hl, DialogChipGirlText
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [wScriptNPCName + 1], a
	xor a
	start_script
	start_dialog
	check_event EVENT_GOT_CHIPS_FROM_GAME_CENTER_ATTENDANT
	script_jump_if_b0z .ows_3ee3e
	set_event EVENT_GOT_CHIPS_FROM_GAME_CENTER_ATTENDANT
	print_npc_text GameCenterChipGirlFirstServiceText
	print_text Received10ChipsText
	show_chips_hud
	give_chips 10
	print_npc_text GameCenterChipGirlNoticeText
	hide_chips_hud
	script_jump .ows_3ee80
.ows_3ee3e
	get_game_center_chips
	compare_loaded_var_word 0
	script_jump_if_b0z .ows_3ee7d
	get_game_center_banked_chips
	compare_loaded_var_word 0
	script_jump_if_b0z .ows_3ee7d
	quit_script
	ld a, [wPrevMap]
	cp MAP_GAME_CENTER_1
	jr nz, .asm_3ee67
	ld a, $01
	start_script
	print_npc_text GameCenterChipGirlRefillText
	show_chips_hud
	give_chips 10
	print_text Received10ChipsText
	hide_chips_hud
	script_jump .ows_3ee80
.asm_3ee67
	ld a, $01
	start_script
	print_npc_text GameCenterChipGirlWelcomeRefillText
	show_chips_hud
	give_chips 10
	print_text Received10ChipsText
	hide_chips_hud
	print_npc_text GameCenterChipGirlEnjoyText
	script_jump .ows_3ee80
.ows_3ee7d
	print_npc_text GameCenterChipGirlRefillReminderText
.ows_3ee80
	end_dialog
	end_script
	ret

Func_3ee83:
	ld a, NPC_CHIP_SECURITY
	ld [wScriptNPC], a
	ldtx hl, DialogChipSecurityText
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [wScriptNPCName + 1], a
	xor a
	start_script
	start_dialog
	print_npc_text GameCenterChipSecurityReminderText
	end_dialog
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
	ld a, NPC_CHIP_GIRL
	ld b, EAST
	farcall SetOWObjectDirection
	ld a, [wPlayerOWObject]
	ld b, WEST
	farcall SetOWObjectDirection
	call Func_3ee11
.asm_3eec2
	farcall OverworldResumeAndHandlePlayerMoveInput
	ret

Func_3eec7:
	farcall GetGameCenterChips
	ld a, b
	or c
	jr nz, .asm_3eed4
	farcall OverworldResumeAndHandlePlayerMoveInput
	ret
.asm_3eed4
	ld a, NPC_CHIP_SECURITY
	ld [wScriptNPC], a
	ldtx hl, DialogChipSecurityText
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [wScriptNPCName + 1], a
	xor a
	start_script
	start_dialog
	set_active_npc_direction EAST
	print_npc_text GameCenterChipSecurityWarningText
	end_dialog
	animate_player_movement $00, $01
	end_script
	ret

Func_3eef4:
	ld a, OWMODE_IDLE
	ld [wOverworldMode], a
	ret

GameCenterLobby_MapHeader:
	db MAP_GFX_GAME_CENTER_LOBBY
	dba GameCenterLobby_MapScripts
	db MUSIC_GAME_CENTER

GameCenterLobby_StepEvents:
	map_exit 13, 6, MAP_GAME_CENTER_ENTRANCE, 1, 6, EAST
	map_exit 13, 7, MAP_GAME_CENTER_ENTRANCE, 1, 6, EAST
	db $ff

GameCenterLobby_NPCs:
	npc NPC_GAME_CENTER_TECH, 10, 4, WEST, NULL
	npc NPC_GAME_CENTER_GR_LASS, 8, 9, EAST, NULL
	npc NPC_GAME_CENTER_GR_PAPPY, 3, 7, SOUTH, NULL
	npc NPC_IMAKUNI_RED, 12, 1, NORTH, Func_3f03d
	npc NPC_GR_CLERK_BATTLE_CENTER, 5, 2, SOUTH, NULL
	npc NPC_GR_CLERK_GIFT_CENTER, 8, 2, SOUTH, NULL
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
	ow_script 5, 4, Script_GRBattleCenterClerk
	ow_script 8, 4, Script_GiftCenter
	db $ff

GameCenterLobby_MapScripts:
	dbw OWMODE_STEP_EVENT, Func_3ef95
	dbw OWMODE_INTERACT, Func_3efa5
	dbw OWMODE_AFTER_DUEL, Func_3efb5
	dbw OWMODE_CONTINUE_OW, Func_3efba
	dbw OWMODE_NPC_POSITION, Func_3ef9c
	dbw OWMODE_MUSIC_POSTLOAD, Func_3ef80
	db $ff

Func_3ef80:
	ld a, VAR_26
	farcall GetVarValue
	cp $02
	jr z, .asm_3ef8c
	scf
	ret
.asm_3ef8c
	ld a, MUSIC_IMAKUNI_RED
	farcall PlayAfterCurrentSong
	scf
	ccf
	ret

Func_3ef95:
	ld hl, GameCenterLobby_StepEvents
	call ExecutePlayerCoordScript
	ret

Func_3ef9c:
	ld hl, GameCenterLobby_NPCs
	call LoadNPCs
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
	ld a, EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE_DUMMY
	farcall GetEventValue
	jr z, .asm_3efd4
	ld a, NPC_IMAKUNI_RED
	farcall ClearOWObject
	ld a, EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE_DUMMY
	farcall ZeroOutEventValue
	ld a, [wNextMusic]
	ld [wCurMusic], a
.asm_3efd4
	scf
	ret

Func_3efd6:
	ld a, NPC_GAME_CENTER_TECH
	ld [wScriptNPC], a
	ldtx hl, DialogTechText
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [wScriptNPCName + 1], a
	xor a
	start_script
	start_dialog
	print_npc_text Text0d87
	end_dialog
	end_script
	ret

Func_3eff1:
	ld a, NPC_GAME_CENTER_GR_LASS
	ld [wScriptNPC], a
	ldtx hl, DialogGRKidText
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [wScriptNPCName + 1], a
	xor a
	start_script
	start_dialog
	check_event EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE
	script_jump_if_b0z .ows_3f011
	print_npc_text Text0d88
	script_jump .ows_3f014
.ows_3f011
	print_npc_text Text0d89
.ows_3f014
	end_dialog
	end_script
	ret

Func_3f017:
	ld a, NPC_GAME_CENTER_GR_PAPPY
	ld [wScriptNPC], a
	ldtx hl, DialogPappy1Text
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [wScriptNPCName + 1], a
	xor a
	start_script
	start_dialog
	check_event EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE
	script_jump_if_b0z .ows_3f037
	print_npc_text Text0d8a
	script_jump .ows_3f03a
.ows_3f037
	print_npc_text Text0d8b
.ows_3f03a
	end_dialog
	end_script
	ret

Func_3f03d:
	ld a, VAR_26
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
	npc NPC_PAWN, 4, 4, SOUTH, NULL
	db $ff

CardDungeonPawn_NPCInteractions:
	npc_script NPC_PAWN, Script_Pawn
	db $ff

CardDungeonPawn_OWInteractions:
	ow_script 4, 1, Script_CardDungeonPawnDoors
	ow_script 5, 1, Script_CardDungeonPawnDoors
	db $ff

CardDungeonPawn_MapScripts:
	dbw OWMODE_STEP_EVENT, Func_3f093
	dbw OWMODE_INTERACT, Func_3f0a3
	dbw OWMODE_AFTER_DUEL, Func_3f0d4
	dbw OWMODE_NPC_POSITION, Func_3f09a
	dbw OWMODE_WARP_FADE_IN_PRELOAD, Func_3f0b3
	db $ff

Func_3f093:
	ld hl, CardDungeonPawn_StepEvents
	call ExecutePlayerCoordScript
	ret

Func_3f09a:
	ld hl, CardDungeonPawn_NPCs
	call LoadNPCs
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
	ld bc, TILEMAP_CARD_DUNGEON_PAWN_FRONT_DOORS_SHUT
	lb de, 4, 0
	farcall Func_12c0ce
	ld a, OWMODE_SCRIPT
	ld [wOverworldMode], a
	ld a, BANK(Func_3f1c6)
	ld [wOverworldScriptBank], a
	ld hl, Func_3f1c6
	ld a, l
	ld [wOverworldScriptPointer], a
	ld a, h
	ld [wOverworldScriptPointer + 1], a
	scf
	ret

Func_3f0d4:
	call Script_PawnAfterDuel
	scf
	ret

Script_Pawn:
	ld a, NPC_PAWN
	ld [wScriptNPC], a
	ldtx hl, DialogPawnText
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [wScriptNPCName + 1], a
	xor a
	start_script
	start_dialog
	get_var VAR_CARD_DUNGEON_PROGRESS
	compare_loaded_var 0
	script_jump_if_b0z .proceed
	show_chips_hud
	check_event EVENT_TALKED_TO_PAWN
	script_jump_if_b0z .duel_repeat
	set_event EVENT_TALKED_TO_PAWN
	print_npc_text PawnWantsToDuelInitialText
	script_jump .duel_prompt
.duel_repeat
	print_npc_text PawnWantsToDuelRepeatText
.duel_prompt
	ask_question PawnDuelPromptText, TRUE
	script_jump_if_b0z .quit_prompt
	print_text GameCenterCardDungeonBetPromptText
	quit_script
	ld a, POPUPMENU_CARD_DUNGEON_PAWN
	ld b, 0
	farcall HandlePopupMenu
; menu: bet 10, cancel
	jr c, .cancel
	or a
	jr nz, .cancel
	ld a, $01
	start_script
	script_jump .bet_start
.cancel
	ld a, $01
	start_script
	script_jump .quit_prompt
.bet_start
	take_chips CHIPS_BET_DUNGEON_10
	print_npc_text PawnDuelStartText
	hide_chips_hud
	end_dialog
	start_duel TEST_YOUR_LUCK_DECK_ID, MUSIC_MATCH_START_MEMBER
	end_script
	ret
.quit_prompt
	print_npc_text PawnDeclinedDuelText
	ask_question PawnQuitDuelPromptText, TRUE
	script_jump_if_b0nz .quit
	print_npc_text PawnResumeDuelText
	script_jump .duel_prompt
.quit
	set_var VAR_CARD_DUNGEON_PROGRESS, CARDDUNGEON_QUIT_OR_WITHDREW
	print_npc_text PawnPlayerQuitText
	hide_chips_hud
	end_dialog
	end_script
	jp CardDungeonPawn_SetWarp
.proceed
	print_npc_text PawnProceedRepeatText
	end_dialog
	end_script
	ret

Script_PawnAfterDuel:
	xor a
	start_script
	start_dialog
	check_event EVENT_SET_UNTIL_MAP_RELOAD_2
	script_jump_if_b0nz .player_lost
	print_npc_text PawnPlayerWon1Text
	show_chips_hud
	set_text_ram3 CHIPS_BET_DUNGEON_10 * 2
	print_text ReceivedXChipsText
	give_chips CHIPS_BET_DUNGEON_10 * 2
	print_npc_text PawnPlayerWon2Text
	hide_chips_hud
	script_jump .proceed
.player_lost
	set_var VAR_CARD_DUNGEON_PROGRESS, CARDDUNGEON_LOST
	print_npc_text PawnPlayerLostText
	end_dialog
	end_script
	jp CardDungeonPawn_SetWarp
.proceed
	ask_question PawnProceedWithCardDungeonPromptText, TRUE
	script_jump_if_b0z .declined
	set_var VAR_CARD_DUNGEON_PROGRESS, CARDDUNGEON_BEAT_PAWN
	print_npc_text PawnProceedInitial1Text
	set_active_npc_direction NORTH
	play_sfx SFX_DOORS
	load_tilemap TILEMAP_CARD_DUNGEON_PAWN_BACK_DOORS_OPEN, 4, 0
	print_npc_text PawnProceedInitial2Text
	script_jump .done
.declined
	print_npc_text PawnDeclinedProceedingText
	ask_question PawnWithdrawFromCardDungeonPromptText, TRUE
	script_jump_if_b0z .proceed
	set_var VAR_CARD_DUNGEON_PROGRESS, CARDDUNGEON_QUIT_OR_WITHDREW
	print_npc_text PawnPlayerWithdrewText
	end_dialog
	end_script
	jp CardDungeonPawn_SetWarp
.done
	end_dialog
	end_script
	ret

CardDungeonPawn_SetWarp:
	ld a, MAP_GAME_CENTER_2
	lb de, 6, 3
	ld b, SOUTH
	farcall SetWarpData
	ret

Func_3f1c6:
	xor a
	start_script
	animate_player_movement $00, $01
	animate_player_movement $00, $01
	play_sfx SFX_DOORS
	load_tilemap TILEMAP_CARD_DUNGEON_PAWN_FRONT_DOORS_SHUT, 4, 7
	end_script
	ld a, OWMODE_IDLE
	ld [wOverworldMode], a
	ret

Script_CardDungeonPawnDoors:
	ld a, VAR_CARD_DUNGEON_PROGRESS
	farcall GetVarValue
	or a
	jr nz, .done
	xor a
	start_script
	start_dialog
	print_text DoorsAreShutText
	end_dialog
	end_script
.done
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
	npc NPC_KNIGHT, 4, 3, SOUTH, NULL
	db $ff

CardDungeonKnight_NPCInteractions:
	npc_script NPC_KNIGHT, Script_Knight
	db $ff

CardDungeonKnight_OWInteractions:
	ow_script 4, 1, Script_CardDungeonKnightDoors
	ow_script 5, 1, Script_CardDungeonKnightDoors
	db $ff

CardDungeonKnight_MapScripts:
	dbw OWMODE_STEP_EVENT, Func_3f239
	dbw OWMODE_INTERACT, Func_3f249
	dbw OWMODE_AFTER_DUEL, Func_3f27a
	dbw OWMODE_NPC_POSITION, Func_3f240
	dbw OWMODE_WARP_FADE_IN_PRELOAD, Func_3f259
	db $ff

Func_3f239:
	ld hl, CardDungeonKnight_StepEvents
	call ExecutePlayerCoordScript
	ret

Func_3f240:
	ld hl, CardDungeonKnight_NPCs
	call LoadNPCs
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
	ld bc, TILEMAP_CARD_DUNGEON_KNIGHT_FRONT_DOORS_SHUT
	lb de, 4, 0
	farcall Func_12c0ce
	ld a, OWMODE_SCRIPT
	ld [wOverworldMode], a
	ld a, BANK(Func_3f395)
	ld [wOverworldScriptBank], a
	ld hl, Func_3f395
	ld a, l
	ld [wOverworldScriptPointer], a
	ld a, h
	ld [wOverworldScriptPointer + 1], a
	scf
	ret

Func_3f27a:
	call Script_KnightAfterDuel
	scf
	ret

Script_Knight:
	ld a, NPC_KNIGHT
	ld [wScriptNPC], a
	ldtx hl, DialogKnightText
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [wScriptNPCName + 1], a
	xor a
	start_script
	start_dialog
	get_var VAR_CARD_DUNGEON_PROGRESS
	compare_loaded_var CARDDUNGEON_BEAT_PAWN
	script_jump_if_b0z .proceed_repeat
	show_chips_hud
	check_event EVENT_TALKED_TO_KNIGHT
	script_jump_if_b0z .duel_repeat
	set_event EVENT_TALKED_TO_KNIGHT
	print_npc_text KnightWantsToDuelInitialText
	script_jump .duel_prompt
.duel_repeat
	print_npc_text KnightWantsToDuelRepeatText
.duel_prompt
	ask_question KnightDuelPromptText, TRUE
	script_jump_if_b0z .quit_prompt
	print_text GameCenterCardDungeonBetPromptText
	quit_script
	ld a, POPUPMENU_CARD_DUNGEON_KNIGHT
	ld b, 0
	farcall HandlePopupMenu
; menu: bet 10, bet 20, cancel
	jr c, .cancel
	cp 1
	jr z, .bet_20
	jr nc, .cancel
; bet 10
	ld a, CHIPS_BET_DUNGEON_10
	jr .bet
.bet_20
	ld a, CHIPS_BET_DUNGEON_20
	jr .bet
.cancel
	ld a, $01
	start_script
	script_jump .quit_prompt
.bet
	ld h, 0
	ld l, a
	ld [wTempCardDungeonBet], a
	call LoadTxRam3
	ld c, l
	ld b, h
	farcall DecreaseChipsSmoothly
	ld a, $01
	start_script
	print_npc_text KnightDuelStartText
	hide_chips_hud
	end_dialog
	start_duel PROTOHISTORIC_DECK_ID, MUSIC_MATCH_START_MEMBER
	end_script
	ret
.quit_prompt
	print_npc_text KnightDeclinedDuelText
	ask_question KnightQuitDuelPromptText, TRUE
	script_jump_if_b0nz .quit
	print_npc_text KnightResumeDuelText
	script_jump .duel_prompt
.quit
	set_var VAR_CARD_DUNGEON_PROGRESS, CARDDUNGEON_QUIT_OR_WITHDREW
	print_npc_text KnightPlayerQuitText
	hide_chips_hud
	end_dialog
	end_script
	jp CardDungeonKnight_SetWarp
.proceed_repeat
	print_npc_text KnightProceedRepeatText
	end_dialog
	end_script
	ret

Script_KnightAfterDuel:
	xor a
	start_script
	start_dialog
	check_event EVENT_SET_UNTIL_MAP_RELOAD_2
	script_jump_if_b0nz .player_lost
	print_npc_text KnightPlayerWon1Text
	show_chips_hud
	quit_script
	ld a, [wTempCardDungeonBet]
	sla a
	ld h, 0
	ld l, a
	call LoadTxRam3
	ld c, l
	ld b, h
	ldtx hl, ReceivedXChipsText
	farcall PrintScrollableText_NoTextBoxLabelVRAM0
	farcall IncreaseChipsSmoothly
	ld a, $01
	start_script
	print_npc_text KnightPlayerWon2Text
	hide_chips_hud
	script_jump .proceed
.player_lost
	set_var VAR_CARD_DUNGEON_PROGRESS, CARDDUNGEON_LOST
	print_npc_text KnightPlayerLostText
	end_dialog
	end_script
	jp CardDungeonKnight_SetWarp
.proceed
	ask_question KnightProceedWithCardDungeonPromptText, TRUE
	script_jump_if_b0z .declined
	set_var VAR_CARD_DUNGEON_PROGRESS, CARDDUNGEON_BEAT_KNIGHT
	print_npc_text KnightProceedInitial1Text
	set_active_npc_direction NORTH
	play_sfx SFX_DOORS
	load_tilemap TILEMAP_CARD_DUNGEON_KNIGHT_BACK_DOORS_OPEN, 4, 0
	print_npc_text KnightProceedInitial2Text
	script_jump .done
.declined
	print_npc_text KnightDeclinedProceedingText
	ask_question KnightWithdrawFromCardDungeonPromptText, TRUE
	script_jump_if_b0z .proceed
	set_var VAR_CARD_DUNGEON_PROGRESS, CARDDUNGEON_QUIT_OR_WITHDREW
	print_npc_text KnightPlayerWithdrewText
	end_dialog
	end_script
	jp CardDungeonKnight_SetWarp
.done
	end_dialog
	end_script
	ret

CardDungeonKnight_SetWarp:
	ld a, MAP_GAME_CENTER_2
	lb de, 6, 3
	ld b, SOUTH
	farcall SetWarpData
	ret

Func_3f395:
	xor a
	start_script
	animate_player_movement $00, $01
	animate_player_movement $00, $01
	play_sfx SFX_DOORS
	load_tilemap TILEMAP_CARD_DUNGEON_KNIGHT_FRONT_DOORS_SHUT, 4, 7
	end_script
	ld a, OWMODE_IDLE
	ld [wOverworldMode], a
	ret

Script_CardDungeonKnightDoors:
	ld a, VAR_CARD_DUNGEON_PROGRESS
	farcall GetVarValue
	cp $01
	jr nz, .done
	xor a
	start_script
	start_dialog
	print_text DoorsAreShutText
	end_dialog
	end_script
.done
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
	npc NPC_ROOK, 5, 3, SOUTH, NULL
	db $ff

CardDungeonRook_NPCInteractions:
	npc_script NPC_ROOK, Script_Rook
	db $ff

CardDungeonRook_OWInteractions:
	ow_script 4, 1, Script_CardDungeonRookDoors
	ow_script 5, 1, Script_CardDungeonRookDoors
	db $ff

CardDungeonRook_MapScripts:
	dbw OWMODE_STEP_EVENT, Func_3f409
	dbw OWMODE_INTERACT, Func_3f419
	dbw OWMODE_AFTER_DUEL, Func_3f44a
	dbw OWMODE_NPC_POSITION, Func_3f410
	dbw OWMODE_WARP_FADE_IN_PRELOAD, Func_3f429
	db $ff

Func_3f409:
	ld hl, CardDungeonRook_StepEvents
	call ExecutePlayerCoordScript
	ret

Func_3f410:
	ld hl, CardDungeonRook_NPCs
	call LoadNPCs
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
	ld bc, TILEMAP_CARD_DUNGEON_ROOK_FRONT_DOORS_SHUT
	lb de, 4, 0
	farcall Func_12c0ce
	ld a, OWMODE_SCRIPT
	ld [wOverworldMode], a
	ld a, BANK(Func_3f57e)
	ld [wOverworldScriptBank], a
	ld hl, Func_3f57e
	ld a, l
	ld [wOverworldScriptPointer], a
	ld a, h
	ld [wOverworldScriptPointer + 1], a
	scf
	ret

Func_3f44a:
	call Script_RookAfterDuel
	scf
	ret

Script_Rook:
	ld a, NPC_ROOK
	ld [wScriptNPC], a
	ldtx hl, DialogRookText
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [wScriptNPCName + 1], a
	xor a
	start_script
	start_dialog
	get_var VAR_CARD_DUNGEON_PROGRESS
	compare_loaded_var CARDDUNGEON_BEAT_BISHOP
	script_jump_if_b0z .proceed_repeat
	show_chips_hud
	check_event EVENT_TALKED_TO_ROOK
	script_jump_if_b0z .duel_repeat
	set_event EVENT_TALKED_TO_ROOK
	print_npc_text RookWantsToDuelInitialText
	script_jump .duel_prompt
.duel_repeat
	print_npc_text RookWantsToDuelRepeatText
.duel_prompt
	ask_question RookDuelPromptText, TRUE
	script_jump_if_b0z .quit_prompt
.bet_start
	print_text GameCenterCardDungeonBetPromptText
	quit_script
	ld a, POPUPMENU_CARD_DUNGEON_ROOK
	ld b, 0
	farcall HandlePopupMenu
; menu: bet 30, bet 50, cancel
	jr c, .cancel
	cp 1
	jr z, .bet_50
	jr nc, .cancel
; bet 30
	ld a, CHIPS_BET_DUNGEON_30
	jr .bet_check
.bet_50
	ld a, CHIPS_BET_DUNGEON_50
	jr .bet_check
.cancel
	ld a, $01
	start_script
	script_jump .quit_prompt
.bet_check
	ld h, 0
	ld l, a
	ld [wTempCardDungeonBet], a
	call LoadTxRam3
	farcall GetGameCenterChips
	cp16bc_long hl
	jr nc, .bet
	ld a, $01
	start_script
	print_npc_text RookNotEnoughChipsText
	script_jump .bet_start
.bet
	ld c, l
	ld b, h
	farcall DecreaseChipsSmoothly
	ld a, $01
	start_script
	print_npc_text RookDuelStartText
	hide_chips_hud
	end_dialog
	start_duel COLORLESS_ENERGY_DECK_ID, MUSIC_MATCH_START_GR_LEADER
	end_script
	ret
.quit_prompt
	print_npc_text RookDeclinedDuelText
	ask_question RookQuitDuelPromptText, TRUE
	script_jump_if_b0nz .quit
	print_npc_text RookResumeDuelText
	script_jump .duel_prompt
.quit
	set_var VAR_CARD_DUNGEON_PROGRESS, CARDDUNGEON_QUIT_OR_WITHDREW
	print_npc_text RookPlayerQuitText
	hide_chips_hud
	end_dialog
	end_script
	jp Func_3f572
.proceed_repeat
	print_npc_text RookProceedRepeatText
	end_dialog
	end_script
	ret

Script_RookAfterDuel:
	xor a
	start_script
	start_dialog
	check_event EVENT_SET_UNTIL_MAP_RELOAD_2
	script_jump_if_b0nz .player_lost
	print_npc_text RookPlayerWon1Text
	show_chips_hud
	quit_script
	ld a, [wTempCardDungeonBet]
	sla a
	ld h, 0
	ld l, a
	call LoadTxRam3
	ld c, l
	ld b, h
	ldtx hl, ReceivedXChipsText
	farcall PrintScrollableText_NoTextBoxLabelVRAM0
	farcall IncreaseChipsSmoothly
	ld a, $01
	start_script
	print_npc_text RookPlayerWon2Text
	hide_chips_hud
	script_jump .proceed
.player_lost
	set_var VAR_CARD_DUNGEON_PROGRESS, CARDDUNGEON_LOST
	print_npc_text RookPlayerLostText
	end_dialog
	end_script
	jp Func_3f572
.proceed
	ask_question RookProceedWithCardDungeonPromptText, TRUE
	script_jump_if_b0z .declined
	set_var VAR_CARD_DUNGEON_PROGRESS, CARDDUNGEON_BEAT_ROOK
	print_npc_text RookProceedInitial1Text
	set_active_npc_direction NORTH
	play_sfx SFX_DOORS
	load_tilemap TILEMAP_CARD_DUNGEON_ROOK_BACK_DOORS_OPEN, 4, 0
	print_npc_text RookProceedInitial2Text
	script_jump .done
.declined
	print_npc_text RookDeclinedProceedingText
	ask_question RookWithdrawFromCardDungeonPromptText, TRUE
	script_jump_if_b0z .proceed
	set_var VAR_CARD_DUNGEON_PROGRESS, CARDDUNGEON_QUIT_OR_WITHDREW
	print_npc_text RookPlayerWithdrewText
	end_dialog
	end_script
	jp Func_3f572
.done
	end_dialog
	end_script
	ret

Func_3f572:
	ld a, MAP_GAME_CENTER_2
	lb de, 6, 3
	ld b, SOUTH
	farcall SetWarpData
	ret

Func_3f57e:
	xor a
	start_script
	animate_player_movement $00, $01
	animate_player_movement $00, $01
	play_sfx SFX_DOORS
	load_tilemap TILEMAP_CARD_DUNGEON_ROOK_FRONT_DOORS_SHUT, 4, 7
	end_script
	ld a, OWMODE_IDLE
	ld [wOverworldMode], a
	ret

Script_CardDungeonRookDoors:
	ld a, VAR_CARD_DUNGEON_PROGRESS
	farcall GetVarValue
	cp $03
	jr nz, .done
	xor a
	start_script
	start_dialog
	print_text DoorsAreShutText
	end_dialog
	end_script
.done
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
	npc NPC_WATER_FORT_GR_GRANNY, 2, 7, SOUTH, NULL
	npc NPC_WATER_FORT_GR_GAL, 5, 9, NORTH, NULL
	npc NPC_IMAKUNI_RED, 12, 1, NORTH, Func_3f7a6
	npc NPC_GR_CLERK_BATTLE_CENTER, 5, 2, SOUTH, NULL
	npc NPC_GR_CLERK_GIFT_CENTER, 8, 2, SOUTH, NULL
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
	ow_script 5, 4, Script_GRBattleCenterClerk
	ow_script 8, 4, Script_GiftCenter
	db $ff

WaterFortLobby_MapScripts:
	dbw OWMODE_STEP_EVENT, Func_3f650
	dbw OWMODE_INTERACT, Func_3f660
	dbw OWMODE_AFTER_DUEL, Func_3f670
	dbw OWMODE_CONTINUE_OW, Func_3f675
	dbw OWMODE_NPC_POSITION, Func_3f657
	dbw OWMODE_MUSIC_POSTLOAD, Func_3f63b
	db $ff

Func_3f63b:
	ld a, VAR_26
	farcall GetVarValue
	cp $08
	jr z, .asm_3f647
	scf
	ret
.asm_3f647
	ld a, MUSIC_IMAKUNI_RED
	farcall PlayAfterCurrentSong
	scf
	ccf
	ret

Func_3f650:
	ld hl, WaterFortLobby_StepEvents
	call ExecutePlayerCoordScript
	ret

Func_3f657:
	ld hl, WaterFortLobby_NPCs
	call LoadNPCs
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
	ld a, EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE_DUMMY
	farcall GetEventValue
	jr z, .asm_3f68f
	ld a, NPC_IMAKUNI_RED
	farcall ClearOWObject
	ld a, EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE_DUMMY
	farcall ZeroOutEventValue
	ld a, [wNextMusic]
	ld [wCurMusic], a
.asm_3f68f
	scf
	ret

Func_3f691:
	ld a, NPC_WATER_FORT_GLASSES_KID
	ld [wScriptNPC], a
	ldtx hl, DialogGlassesKid1Text
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [wScriptNPCName + 1], a
	xor a
	start_script
	start_dialog
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
	end_dialog
	end_script
	ret

Func_3f718:
	ld a, EVENT_TRADED_CARDS_WATER_FORT
	farcall GetEventValue
	jr z, .asm_3f732
	ld a, EVENT_SET_UNTIL_MAP_RELOAD_1
	farcall GetEventValue
	jr nz, .asm_3f732
	ld a, EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE
	farcall GetEventValue
	jr z, .asm_3f732
	scf
	ret
.asm_3f732
	scf
	ccf
	ret

Func_3f735:
	ld a, EVENT_TRADED_CARDS_WATER_FORT
	farcall GetEventValue
	jr z, .asm_3f74d
	ld a, EVENT_SET_UNTIL_MAP_RELOAD_1
	farcall GetEventValue
	jr nz, .asm_3f74d
	ld a, EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE
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
	ld a, NPC_WATER_FORT_GR_GRANNY
	ld [wScriptNPC], a
	ldtx hl, DialogGrannyText
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [wScriptNPCName + 1], a
	xor a
	start_script
	start_dialog
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
	end_dialog
	end_script
	ret

Func_3f780:
	ld a, NPC_WATER_FORT_GR_GAL
	ld [wScriptNPC], a
	ldtx hl, DialogGal2Text
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [wScriptNPCName + 1], a
	xor a
	start_script
	start_dialog
	check_event EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE
	script_jump_if_b0z .ows_3f7a0
	print_npc_text Text1261
	script_jump .ows_3f7a3
.ows_3f7a0
	print_npc_text Text1262
.ows_3f7a3
	end_dialog
	end_script
	ret

Func_3f7a6:
	ld a, VAR_26
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
	dbw OWMODE_STEP_EVENT, Func_3f7ff
	dbw OWMODE_INTERACT, Func_3f80f
	dbw OWMODE_NPC_POSITION, Func_3f806
	db $ff

Func_3f7ff:
	ld hl, FightingFortMaze19_StepEvents
	call ExecutePlayerCoordScript
	ret

Func_3f806:
	ld hl, FightingFortMaze19_NPCs
	call LoadNPCs
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
	start_dialog
	set_event EVENT_OPENED_CHEST_FIGHTING_FORT_5
	play_sfx SFX_OPEN_CHEST
	load_npc NPC_CHEST_OPENED, 5, 3, SOUTH
	unload_npc NPC_CHEST_CLOSED
	print_text OpenedTreasureBoxText
	give_booster_packs BoosterList_ce2f
	end_dialog
	end_script
	ret

Func_3f830:
	ld a, EVENT_OPENED_CHEST_FIGHTING_FORT_5
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
	start_dialog
	print_text TreasureBoxWasEmptyText
	end_dialog
	end_script
	call Func_3f858
	ret

Func_3f84b:
	ld a, EVENT_OPENED_CHEST_FIGHTING_FORT_5
	farcall GetEventValue
	jr z, .asm_3f856
	scf
	ccf
	ret
.asm_3f856
	scf
	ret

Func_3f858:
	ld a, VAR_3B
	farcall GetVarValue
	cp $03
	jr nz, .asm_3f87b
	ld a, [wMessageSpeedSetting]
	ld b, a
	ld a, [wTextBoxFrameColor]
	ld c, a
	cp16bc_bytes 0, 3
	jr nz, .asm_3f87b
	farcall Func_1352a
	ret
.asm_3f87b
	ld a, VAR_3B
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
	dbw OWMODE_STEP_EVENT, Func_3f8b6
	dbw OWMODE_INTERACT, Func_3f904
	dbw OWMODE_NPC_POSITION, Func_3f8bd
	dbw OWMODE_WARP_FADE_IN_PRELOAD, Func_3f8c6
	db $ff

Func_3f8b6:
	ld hl, FightingFortBasement_StepEvents
	call ExecutePlayerCoordScript
	ret

Func_3f8bd:
	ld hl, FightingFortBasement_NPCs
	call LoadNPCs
	scf
	ccf
	ret

Func_3f8c6:
	ld bc, $53
	ld a, $05
	farcall SetwD896
	ld a, [wPrevMap]
	cp MAP_FIGHTING_FORT
	jr nz, .asm_3f8d8
	scf
	ret
.asm_3f8d8
	ld a, OWMODE_SCRIPT
	ld [wOverworldMode], a
	ld a, BANK(Func_3f95e)
	ld [wOverworldScriptBank], a
	ld hl, Func_3f95e
	ld a, l
	ld [wOverworldScriptPointer], a
	ld a, h
	ld [wOverworldScriptPointer + 1], a
	ld a, [wPlayerOWObject]
	farcall ResetOWObjectFlag5_WithID
	lb de, 10, 15
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
	start_dialog
	set_event EVENT_OPENED_CHEST_FIGHTING_FORT_BASEMENT
	play_sfx SFX_OPEN_CHEST
	load_npc NPC_CHEST_OPENED, 1, 1, SOUTH
	unload_npc NPC_CHEST_CLOSED
	print_text OpenedTreasureBoxText
	receive_card FIGHTING_ENERGY
	end_dialog
	end_script
	ret

Func_3f925:
	ld a, EVENT_OPENED_CHEST_FIGHTING_FORT_BASEMENT
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
	start_dialog
	print_text TreasureBoxWasEmptyText
	end_dialog
	end_script
	ld a, $02
	farcall Func_30065
	ld a, [wPrevMap]
	cp MAP_FIGHTING_FORT
	ret z
	ld a, VAR_3B
	ld c, $00
	farcall SetVarValue
	ret

Func_3f951:
	ld a, EVENT_OPENED_CHEST_FIGHTING_FORT_BASEMENT
	farcall GetEventValue
	jr z, .asm_3f95c
	scf
	ccf
	ret
.asm_3f95c
	scf
	ret

Func_3f95e:
	ld a, [wPlayerOWObject]
	ld b, BANK(.NPCMovement_3f980)
	ld hl, .NPCMovement_3f980
	farcall MoveNPC
	call Func_3340
	ld a, [wPlayerOWObject]
	farcall SetOWObjectFlag5_WithID
	ld a, $01
	farcall SetOWScrollState
	ld a, OWMODE_IDLE
	ld [wOverworldMode], a
	ret
.NPCMovement_3f980:
	db SOUTH, RUN_2
	db $ff
