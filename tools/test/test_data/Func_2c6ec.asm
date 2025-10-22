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
	script_jump .ows_2c5f5
; 0x2c707
.ows_2c707
	print_npc_text Text0b1e
	script_command_02
	end_script
; 0x2c70c
; gap from 0x2c70c to 0x2c70d
	ret
.ows_2c70d
	check_event EVENT_SET_UNTIL_MAP_RELOAD_2
	script_jump_if_b0nz .ows_2c71e
	print_npc_text Text0b1f
	give_booster_packs $4d15
	print_npc_text Text0b20
	script_jump .ows_2c721
; 0x2c71e
.ows_2c71e
	print_npc_text Text0b21
.ows_2c721
	script_command_02
	end_script
; 0x2c723
; gap from 0x2c723 to 0x2c724
	ret
.ows_2c724
	check_event EVENT_SET_UNTIL_MAP_RELOAD_2
	script_jump_if_b0nz .ows_2c735
	print_npc_text Text0b22
	give_booster_packs $4d19
	print_npc_text Text0b23
	script_jump .ows_2c738
; 0x2c735
.ows_2c735
	print_npc_text Text0b24
.ows_2c738
	script_command_02
	end_script
; 0x2c73a
	ret
; 0x2c73b