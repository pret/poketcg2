MACRO start_script
	call Func_33f2
ENDM

MACRO run_command
	db \1_index
ENDM

	const_def
	const ScriptCommand_00_index ; $00
	const ScriptCommand_01_index ; $01
	const ScriptCommand_02_index ; $02
	const ScriptCommand_03_index ; $03
	const ScriptCommand_04_index ; $04
	const ScriptCommand_05_index ; $05
	const ScriptCommand_06_index ; $06
	const ScriptCommand_07_index ; $07
	const ScriptCommand_08_index ; $08
	const ScriptCommand_09_index ; $09
	const ScriptCommand_0A_index ; $0a
	const ScriptCommand_0B_index ; $0b
	const ScriptCommand_0C_index ; $0c
	const ScriptCommand_0D_index ; $0d
	const ScriptCommand_0E_index ; $0e
	const ScriptCommand_0F_index ; $0f
	const ScriptCommand_10_index ; $10
	const ScriptCommand_11_index ; $11
	const ScriptCommand_12_index ; $12
	const ScriptCommand_13_index ; $13
	const ScriptCommand_14_index ; $14
	const ScriptCommand_15_index ; $15
	const ScriptCommand_16_index ; $16
	const ScriptCommand_17_index ; $17
	const ScriptCommand_18_index ; $18
	const ScriptCommand_19_index ; $19
	const ScriptCommand_1A_index ; $1a
	const ScriptCommand_1B_index ; $1b
	const ScriptCommand_1C_index ; $1c
	const ScriptCommand_1D_index ; $1d
	const ScriptCommand_1E_index ; $1e
	const ScriptCommand_1F_index ; $1f
	const ScriptCommand_20_index ; $20
	const ScriptCommand_21_index ; $21
	const ScriptCommand_22_index ; $22
	const ScriptCommand_23_index ; $23
	const ScriptCommand_24_index ; $24
	const ScriptCommand_25_index ; $25
	const ScriptCommand_26_index ; $26
	const ScriptCommand_27_index ; $27
	const ScriptCommand_28_index ; $28
	const ScriptCommand_29_index ; $29
	const ScriptCommand_2A_index ; $2a
	const ScriptCommand_2B_index ; $2b
	const ScriptCommand_2C_index ; $2c
	const ScriptCommand_2D_index ; $2d
	const ScriptCommand_2E_index ; $2e
	const ScriptCommand_2F_index ; $2f
	const ScriptCommand_30_index ; $30
	const ScriptCommand_31_index ; $31
	const ScriptCommand_32_index ; $32
	const ScriptCommand_33_index ; $33
	const ScriptCommand_34_index ; $34
	const ScriptCommand_35_index ; $35
	const ScriptCommand_36_index ; $36
	const ScriptCommand_37_index ; $37
	const ScriptCommand_38_index ; $38
	const ScriptCommand_39_index ; $39
	const ScriptCommand_3A_index ; $3a
	const ScriptCommand_3B_index ; $3b
	const ScriptCommand_3C_index ; $3c
	const ScriptCommand_3D_index ; $3d
	const ScriptCommand_3E_index ; $3e
	const ScriptCommand_3F_index ; $3f
	const ScriptCommand_40_index ; $40
	const ScriptCommand_41_index ; $41
	const ScriptCommand_42_index ; $42
	const ScriptCommand_43_index ; $43
	const ScriptCommand_44_index ; $44
	const ScriptCommand_45_index ; $45
	const ScriptCommand_46_index ; $46
	const ScriptCommand_47_index ; $47
	const ScriptCommand_48_index ; $48
	const ScriptCommand_49_index ; $49
	const ScriptCommand_4A_index ; $4a
	const ScriptCommand_4B_index ; $4b
	const ScriptCommand_4C_index ; $4c
	const ScriptCommand_4D_index ; $4d
	const ScriptCommand_4E_index ; $4e
	const ScriptCommand_4F_index ; $4f
	const ScriptCommand_50_index ; $50
	const ScriptCommand_51_index ; $51
	const ScriptCommand_52_index ; $52
	const ScriptCommand_53_index ; $53
	const ScriptCommand_54_index ; $54
	const ScriptCommand_55_index ; $55
	const ScriptCommand_56_index ; $56
	const ScriptCommand_57_index ; $57
	const ScriptCommand_58_index ; $58
	const ScriptCommand_59_index ; $59
	const ScriptCommand_5A_index ; $5a
	const ScriptCommand_5B_index ; $5b
	const ScriptCommand_5C_index ; $5c
	const ScriptCommand_5D_index ; $5d
	const ScriptCommand_5E_index ; $5e
	const ScriptCommand_5F_index ; $5f
	const ScriptCommand_60_index ; $60
	const ScriptCommand_61_index ; $61
	const ScriptCommand_62_index ; $62
	const ScriptCommand_63_index ; $63
	const ScriptCommand_64_index ; $64
	const ScriptCommand_65_index ; $65
	const ScriptCommand_66_index ; $66
	const ScriptCommand_67_index ; $67
	const ScriptCommand_68_index ; $68
	const ScriptCommand_69_index ; $69
	const ScriptCommand_6A_index ; $6a
	const ScriptCommand_6B_index ; $6b
	const ScriptCommand_6C_index ; $6c
	const ScriptCommand_6D_index ; $6d
	const ScriptCommand_6E_index ; $6e
	const ScriptCommand_6F_index ; $6f
	const ScriptCommand_70_index ; $70
	const ScriptCommand_71_index ; $71
	const ScriptCommand_72_index ; $72
	const ScriptCommand_73_index ; $73
	const ScriptCommand_74_index ; $74
	const ScriptCommand_75_index ; $75
	const ScriptCommand_76_index ; $76
	const ScriptCommand_77_index ; $77
	const ScriptCommand_78_index ; $78
	const ScriptCommand_79_index ; $79
	const ScriptCommand_7A_index ; $7a
	const ScriptCommand_7B_index ; $7b
	const ScriptCommand_7C_index ; $7c
	const ScriptCommand_7D_index ; $7d

DEF NUM_SCRIPT_COMMANDS EQU const_value

; Script Macros

MACRO end_script
	run_command ScriptCommand_00
ENDM

MACRO script_command_01
	run_command ScriptCommand_01
ENDM

MACRO script_command_02
	run_command ScriptCommand_02
ENDM

MACRO print_text
	run_command ScriptCommand_03
	tx \1 ; text
ENDM

MACRO print_variable_text
	run_command ScriptCommand_04
	tx \1 ; text 1
	tx \2 ; text 2
ENDM

MACRO print_npc_text
	run_command ScriptCommand_05
	tx \1 ; text
ENDM

MACRO print_variable_npc_text
	run_command ScriptCommand_06
	tx \1 ; text 1
	tx \2 ; text 2
ENDM

MACRO ask_question
	run_command ScriptCommand_07
	tx \1 ; text
	db \2 ; 0: default "yes", 1: default "no"
ENDM

MACRO script_jump
	run_command ScriptCommand_08
	dw \1 ; script
ENDM

MACRO script_jump_if_b0nz
	run_command ScriptCommand_09
	dw \1 ; script
ENDM

MACRO script_jump_if_b0z
	run_command ScriptCommand_0A
	dw \1 ; script
ENDM

MACRO script_jump_if_b1nz
	run_command ScriptCommand_0B
	dw \1 ; script
ENDM

MACRO script_jump_if_b1z
	run_command ScriptCommand_0C
	dw \1 ; script
ENDM

MACRO compare_loaded_var
	run_command ScriptCommand_0D
	db \1 ; value to compare
ENDM

MACRO set_event
	run_command ScriptCommand_0E
	db \1 ; event to set
ENDM

MACRO reset_event
	run_command ScriptCommand_0F
	db \1 ; event to reset
ENDM

MACRO check_event
	run_command ScriptCommand_10
	db \1 ; event to check
ENDM

MACRO set_var
	run_command ScriptCommand_11
	db \1 ; var to set
	db \2 ; value to set it to
ENDM

MACRO get_var
	run_command ScriptCommand_12
	db \1 ; var to get
ENDM

MACRO inc_var
	run_command ScriptCommand_13
	db \1 ; var to inc
ENDM

MACRO dec_var
	run_command ScriptCommand_14
	db \1 ; var to dec
ENDM

MACRO load_npc
	run_command ScriptCommand_15
	db \1     ; npc to load
	db \2, \3 ; position
	db \4     ; direction
ENDM

MACRO unload_npc
	run_command ScriptCommand_16
	db \1 ; npc to unload
ENDM

MACRO set_player_direction
	run_command ScriptCommand_17
	db \1 ; direction
ENDM

MACRO set_active_npc_direction
	run_command ScriptCommand_18
	db \1 ; direction
ENDM

MACRO do_frames
	run_command ScriptCommand_19
	db \1 ; number of frames
ENDM

MACRO load_tilemap
	run_command ScriptCommand_1A
	dw \1     ; tilemap
	db \2, \3 ; position
ENDM

MACRO show_card_received_screen
	run_command ScriptCommand_1B
	dw \1 ; card
ENDM

MACRO set_player_position
	run_command ScriptCommand_1C
	db \1, \2 ; position
ENDM

MACRO set_active_npc_position
	run_command ScriptCommand_1D
	db \1, \2 ; position
ENDM

MACRO set_scroll_state
	run_command ScriptCommand_1E
	db \1 ; scroll state
ENDM

MACRO scroll_to_position
	run_command ScriptCommand_1F
	db \1, \2 ; position
ENDM

MACRO set_active_npc
	run_command ScriptCommand_20
	db \1 ; npc
	tx \2 ; npc name
ENDM

MACRO set_player_position_and_direction
	run_command ScriptCommand_21
	db \1, \2 ; position
	db \3     ; direction
ENDM

MACRO set_npc_position_and_direction
	run_command ScriptCommand_22
	db \1     ; npc
	db \2, \3 ; position
	db \4     ; direction
ENDM

MACRO fade_in
	run_command ScriptCommand_23
	db \1 ; VBlankCounter mask
	db \2 ; 0: fade from white, 1: fade from black
ENDM

MACRO fade_out
	run_command ScriptCommand_24
	db \1 ; VBlankCounter mask
	db \2 ; 0: fade to white, 1: fade to black
ENDM

MACRO set_npc_direction
	run_command ScriptCommand_25
	db \1 ; npc
	db \2 ; direction
ENDM

MACRO set_npc_position
	run_command ScriptCommand_26
	db \1     ; npc
	db \2, \3 ; position
ENDM

MACRO set_active_npc_position_and_direction
	run_command ScriptCommand_27
	db \1, \2 ; position
	db \3     ; direction
ENDM

MACRO animate_player_movement
	run_command ScriptCommand_28
	db \1 ; unknown
	db \2 ; unknown
ENDM

MACRO animate_npc_movement
	run_command ScriptCommand_29
	db \1 ; npc
	db \2 ; unknown
	db \3 ; unknown
ENDM

MACRO animate_active_npc_movement
	run_command ScriptCommand_2A
	db \1 ; unknown
	db \2 ; unknown
ENDM

MACRO move_player
	run_command ScriptCommand_2B
	dw \1 ; movement data ptr
	db \2 ; 0: don't animate, 1: animate
ENDM

MACRO move_npc
	run_command ScriptCommand_2C
	db \1 ; npc
	dw \2 ; movement data ptr
ENDM

MACRO move_active_npc
	run_command ScriptCommand_2D
	dw \1 ; movement data ptr
ENDM

MACRO start_duel
	run_command ScriptCommand_2E
	db \1 ; deck
	db \2 ; theme
ENDM

MACRO wait_for_player_animation
	run_command ScriptCommand_2F
ENDM

MACRO wait_for_fade
	run_command ScriptCommand_30
ENDM

MACRO get_card_count_in_collection_and_decks
	run_command ScriptCommand_31
	dw \1 ; card
ENDM

MACRO get_card_count_in_collection
	run_command ScriptCommand_32
	dw \1 ; card
ENDM

MACRO give_card
	run_command ScriptCommand_33
	dw \1 ; card
ENDM

MACRO take_card
	run_command ScriptCommand_34
	dw \1 ; card
ENDM

MACRO npc_ask_question
	run_command ScriptCommand_35
	tx \1 ; text
	db \2 ; 0: default "yes", 1: default "no"
ENDM

MACRO get_player_direction
	run_command ScriptCommand_36
ENDM

MACRO compare_var
	run_command ScriptCommand_37
	db \1 ; var
	db \2 ; value to compare
ENDM

MACRO get_active_npc_direction
	run_command ScriptCommand_38
ENDM

MACRO scroll_to_active_npc
	run_command ScriptCommand_39
ENDM

MACRO scroll_to_player
	run_command ScriptCommand_3A
ENDM

MACRO scroll_to_npc
	run_command ScriptCommand_3B
	db \1 ; npc
ENDM

MACRO spin_active_npc
	run_command ScriptCommand_3C
	dw \1 ; number of frames
ENDM

MACRO restore_active_npc_direction
	run_command ScriptCommand_3D
ENDM

MACRO spin_active_npc_reverse
	run_command ScriptCommand_3E
	dw \1 ; number of frames
ENDM

MACRO reset_npc_flag6
	run_command ScriptCommand_3F
	db \1 ; npc
ENDM

MACRO set_npc_flag6
	run_command ScriptCommand_40
	db \1 ; npc
ENDM

MACRO duel_requirement_check
	run_command ScriptCommand_41
	db \1 ; duel requirement
ENDM

MACRO get_active_npc_opposite_direction
	run_command ScriptCommand_42
ENDM

MACRO get_player_opposite_direction
	run_command ScriptCommand_43
ENDM

MACRO play_sfx
	run_command ScriptCommand_44
	db \1 ; sfx
ENDM

MACRO play_sfx_and_wait
	run_command ScriptCommand_45
	db \1 ; sfx
ENDM

MACRO set_text_ram2
	run_command ScriptCommand_46
	tx \1 ; text
ENDM

MACRO set_variable_text_ram2
	run_command ScriptCommand_47
	tx \1 ; text 1
	tx \2 ; text 2
ENDM

MACRO wait_for_npc_animation
	run_command ScriptCommand_48
	db \1 ; npc
ENDM

MACRO get_player_x_position
	run_command ScriptCommand_49
ENDM

MACRO get_player_y_position
	run_command ScriptCommand_4A
ENDM

MACRO restore_npc_direction
	run_command ScriptCommand_4B
	db \1 ; npc
ENDM

MACRO spin_npc
	run_command ScriptCommand_4C
	db \1 ; npc
	dw \2 ; number of frames
ENDM

MACRO spin_npc_reverse
	run_command ScriptCommand_4D
	db \1 ; npc
	dw \2 ; number of frames
ENDM

MACRO push_var
	run_command ScriptCommand_4E
ENDM

MACRO pop_var
	run_command ScriptCommand_4F
ENDM

; call conditions
DEF b0nz EQU 1
DEF b0z  EQU 2
DEF b1nz EQU 3
DEF b1z  EQU 4

MACRO script_call
	run_command ScriptCommand_50
	IF _NARG > 1
		dw \2 ; script
		db \1 ; condition
	ELSE
		dw \1 ; script
		db 0  ; no condition
	ENDC
ENDM

MACRO script_ret
	run_command ScriptCommand_51
ENDM

MACRO give_coin
	run_command ScriptCommand_52
	db \1 ; coin
ENDM

MACRO backup_active_npc
	run_command ScriptCommand_53
ENDM

MACRO load_player
	run_command ScriptCommand_54
	db \1, \2 ; position
	db \3     ; direction
ENDM

MACRO unload_player
	run_command ScriptCommand_55
ENDM

MACRO give_booster_packs
	run_command ScriptCommand_56
	dw \1 ; booster data ptr
ENDM

MACRO get_random
	run_command ScriptCommand_57
	db \1 ; max (exclusive)
ENDM

MACRO script_command_58
	run_command ScriptCommand_58
ENDM

MACRO set_text_ram3
	run_command ScriptCommand_59
	dw \1 ; value
ENDM

MACRO quit_script
	run_command ScriptCommand_5A
ENDM

MACRO play_song
	run_command ScriptCommand_5B
	db \1 ; song
ENDM

MACRO resume_song
	run_command ScriptCommand_5C
ENDM

MACRO script_callfar
	run_command ScriptCommand_5D
	IF _NARG > 1
		dw \2       ; script
		db \1       ; bank
	ELSE
		dw \1       ; script
		db BANK(\1) ; bank
	ENDC
ENDM

MACRO script_retfar
	run_command ScriptCommand_5E
ENDM

MACRO card_pop
	run_command ScriptCommand_5F
	db \1 ; in-game Card Pop! event
ENDM

MACRO play_song_next
	run_command ScriptCommand_60
	db \1 ; song
ENDM

MACRO set_text_ram2b
	run_command ScriptCommand_61
	tx \1 ; text
ENDM

MACRO set_variable_text_ram2b
	run_command ScriptCommand_62
	tx \1 ; text 1
	tx \2 ; text 2
ENDM

MACRO replace_npc
	run_command ScriptCommand_63
	db \1 ; npc to unload
	db \2 ; npc to load
ENDM

MACRO script_command_64
	run_command ScriptCommand_64
	db \1
ENDM

MACRO check_npc_loaded
	run_command ScriptCommand_65
	db \1 ; npc
ENDM

MACRO give_deck
	run_command ScriptCommand_66
	db \1 ; deck
ENDM

MACRO script_command_67
	run_command ScriptCommand_67
	db \1
	db \2
ENDM

MACRO script_command_68
	run_command ScriptCommand_68
ENDM

MACRO print_npc_text_instant
	run_command ScriptCommand_69
	tx \1 ; text
ENDM

MACRO var_add
	run_command ScriptCommand_6A
	db \1 ; var
	db \2 ; value to add
ENDM

MACRO var_sub
	run_command ScriptCommand_6B
	db \1 ; var
	db \2 ; value to subtract
ENDM

MACRO receive_card
	run_command ScriptCommand_6C
	dw \1 ; card
ENDM

MACRO fetch_wda99
	run_command ScriptCommand_6D
ENDM

MACRO compare_loaded_var_word
	run_command ScriptCommand_6E
	dw \1 ; value to compare
ENDM

MACRO fetch_wda9b
	run_command ScriptCommand_6F
ENDM

MACRO game_center
	run_command ScriptCommand_70
ENDM

MACRO script_command_71
	run_command ScriptCommand_71
ENDM

MACRO script_command_72
	run_command ScriptCommand_72
	dw \1
ENDM

MACRO script_command_73
	run_command ScriptCommand_73
	dw \1
ENDM

MACRO load_text_ram3
	run_command ScriptCommand_74
ENDM

MACRO script_command_75
	run_command ScriptCommand_75
ENDM

MACRO script_command_76
	run_command ScriptCommand_76
ENDM

MACRO link_duel
	run_command ScriptCommand_77
ENDM

MACRO wait_song
	run_command ScriptCommand_78
ENDM

MACRO load_palette
	run_command ScriptCommand_79
	dw \1 ; palette
ENDM

MACRO set_sprite_frameset
	run_command ScriptCommand_7A
	db \1 ; npc
	dw \2 ; frameset
ENDM

MACRO wait_sfx
	run_command ScriptCommand_7B
ENDM

MACRO print_text_wide_textbox
	run_command ScriptCommand_7C
	tx \1 ; text
ENDM

MACRO wait_input
	run_command ScriptCommand_7D
ENDM
