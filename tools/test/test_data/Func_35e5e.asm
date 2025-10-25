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
; 0x35e7b
.ows_35e7b
	print_npc_text Text0bf4
	script_command_02
	end_script
; 0x35e80
; gap from 0x35e80 to 0x35e81
	ret
.ows_35e81
	check_event EVENT_SET_UNTIL_MAP_RELOAD_2
	script_jump_if_b0nz .ows_35e92
	print_npc_text Text0bf5
	give_booster_packs BoosterList_cd86
	print_npc_text Text0bf6
	script_jump .ows_35e95
; 0x35e92
.ows_35e92
	print_npc_text Text0bf7
.ows_35e95
	script_command_02
	end_script
; 0x35e97
; gap from 0x35e97 to 0x35e98
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
; 0x35ee4
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
; 0x35f10
; gap from 0x35f10 to 0x35f11
	ret
NPCMovement_35f11:
	db SOUTH, MOVE_5
	db $ff
; 0x35f14