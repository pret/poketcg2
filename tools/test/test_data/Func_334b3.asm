Func_334b3:
	ld a, $ca
	farcall GetEventValue
	jr nz, .asm_334f5
	xor a
	start_script
	script_command_01
	check_event EVENT_INSERTED_RIGHT_COIN_IN_FIGHTING_FORT_DOOR
	script_jump_if_b0z .ows_334f0
	print_text Text0be2
	check_event EVENT_GOT_PSYDUCK_COIN
	script_jump_if_b0nz .ows_334f3
	ask_question Text0be3, TRUE
	script_jump_if_b0z .ows_334f3
	set_event EVENT_INSERTED_RIGHT_COIN_IN_FIGHTING_FORT_DOOR
	check_event EVENT_FIGHTING_FORT_ENTRANCE_DOOR_STATE
	script_jump_if_b0nz .ows_334e0
	unload_npc NPC_RED_FORT_COIN
	script_jump .ows_334f6
; 0x334e0
.ows_334e0
	print_text Text0be4
	load_palette PALETTE_186
	play_sfx SFX_02
	load_npc NPC_BLUE_FORT_COIN, 5, 7, SOUTH
	script_jump .ows_334f3
; 0x334f0
.ows_334f0
	print_text Text0be5
.ows_334f3
	script_command_02
	end_script
; 0x334f5
; gap from 0x334f5 to 0x334f6
.asm_334f5
	ret
.ows_334f6
	script_command_64 $18
	script_command_02
	play_sfx SFX_0F
	load_tilemap TILEMAP_094, $04, $07
	end_script
; 0x33501
	ret
; 0x33502