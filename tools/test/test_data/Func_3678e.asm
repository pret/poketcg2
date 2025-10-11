Func_3678e:
	xor a
	call StartScript
Script_36792:
	script_command_01
	check_event EVENT_BEAT_MIWA
	script_jump_if_b0z .ows_367b1
	check_event EVENT_SET_UNTIL_MAP_RELOAD_2
	script_jump_if_b0nz .ows_367ab
	set_event EVENT_BEAT_MIWA
	print_npc_text Text1153
	give_booster_packs $4d92
	print_npc_text Text1154
	script_jump .ows_367c8
; 0x367ab
.ows_367ab
	print_npc_text Text1155
	script_command_02
	end_script
; 0x367b0
; gap from 0x367b0 to 0x367b1
	ret
.ows_367b1
	check_event EVENT_SET_UNTIL_MAP_RELOAD_2
	script_jump_if_b0nz .ows_367c2
	print_npc_text Text1156
	give_booster_packs $4d92
	print_npc_text Text1157
	script_jump .ows_367c5
; 0x367c2
.ows_367c2
	print_npc_text Text1158
.ows_367c5
	script_command_02
	end_script
; 0x367c7
; gap from 0x367c7 to 0x367c8
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
; 0x367e7
.ows_367e7
	set_var VAR_03, $03
	print_npc_text Text115b
	script_command_02
	script_call .ows_3680c
	script_command_01
	print_npc_text Text115c
	script_command_02
	script_call .ows_3663f
	end_script
; 0x367fc
; gap from 0x367fc to 0x367fd
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
; 0x3680b
; gap from 0x3680b to 0x3680c
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
	script_call .ows_36ba6
	script_ret
; 0x3682a
; gap from 0x3682a to 0x36ba6
; 0x3682a