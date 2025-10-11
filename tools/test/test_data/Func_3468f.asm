Func_3468f:
	ld a, $32
	ld [wScriptNPC], a
	ld hl, $a2c
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	call StartScript
Script_346a3:
	script_command_01
	check_event EVENT_GOT_GR_COIN
	script_jump_if_b0z .ows_346c9
	check_event EVENT_TALKED_TO_GR5_TCG_AIRPORT
	script_jump_if_b0z .ows_346b6
	set_event EVENT_TALKED_TO_GR5_TCG_AIRPORT
	print_npc_text Text081f
	script_jump .ows_346b9
; 0x346b6
.ows_346b6
	print_npc_text Text0820
.ows_346b9
	script_command_02
	end_script
; 0x346bb
; gap from 0x346bb to 0x346c9
	ret
; 0x346bc