Func_41233:
	ld a, $06
	ld [wScriptNPC], a
	ld hl, $9d1
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	check_event EVENT_TALKED_TO_SAM
	script_jump_if_b0nz .ows_412f8
	print_npc_text Text0f13
	end_script
; 0x41251
; gap from 0x41251 to 0x412f8
	ld a, $01
	ld b, $00
	farcall Func_121e1
	jr c, .asm_41264
	or a
	jr z, .asm_4126b
	dec a
	jr z, .asm_4128d
	dec a
	jr z, .asm_412b2
.asm_41264
	xor a
	start_script
	script_jump .ows_412bd
; 0x4126b
; gap from 0x4126b to 0x412bd
.asm_4126b
	xor a
	start_script
	print_npc_text Text0f14
	ask_question Text0f15, TRUE
	script_jump_if_b0z .ows_41287
	script_command_02
	set_active_npc_direction EAST
	script_call .ows_41499
	set_event EVENT_EF
	start_duel SAMS_PRACTICE_DECK_ID, MUSIC_MATCHSTART_1
	end_script
; 0x41286
; gap from 0x41286 to 0x41287
	ret
.ows_41287
	print_npc_text Text0f16
	script_jump .ows_412bd
; 0x4128d
; gap from 0x4128d to 0x412bd
.asm_4128d
	xor a
	start_script
	print_npc_text Text0f17
	ask_question Text0f15, TRUE
	script_jump_if_b0z .ows_412ac
	script_command_02
	set_active_npc_direction EAST
	script_call .ows_4151b
	script_command_01
	print_npc_text Text0f18
	script_command_02
	start_duel UNUSED_SAMS_PRACTICE_DECK_ID, MUSIC_MATCHSTART_1
	end_script
; 0x412ab
; gap from 0x412ab to 0x412ac
	ret
.ows_412ac
	print_npc_text Text0f19
	script_jump .ows_412bd
; 0x412b2
; gap from 0x412b2 to 0x412bd
.asm_412b2
	xor a
	start_script
	script_call .ows_41408
	print_npc_text Text0f16
.ows_412bd
	script_command_02
	end_script
; 0x412bf
; gap from 0x412bf to 0x412f8
; 0x412bf
; gap from 0x412bf to 0x412f8
	ret
; 0x412c0