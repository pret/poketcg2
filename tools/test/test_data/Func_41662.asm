Func_41662:
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
	get_var VAR_2B
	compare_loaded_var $01
	script_jump_if_b0nz .ows_416ac
	script_jump_if_b1z .ows_416b2
	get_var VAR_28
	compare_loaded_var $06
	script_jump_if_b0nz .ows_41699
	compare_loaded_var $03
	script_jump_if_b0nz .ows_41693
	print_npc_text Text094e
	script_jump .ows_416b8
; 0x41693
.ows_41693
	print_npc_text Text094f
	script_jump .ows_416b8
; 0x41699
.ows_41699
	quit_script
; 0x4169a
; gap from 0x4169a to 0x416ac
	farcall Func_f027
	call LoadTxRam2
	ld a, $01
	start_script
	print_npc_text Text0950
	script_jump .ows_416b8
; 0x416ac
.ows_416ac
	print_npc_text Text0951
	script_jump .ows_416da
; 0x416b2
.ows_416b2
	print_npc_text Text0952
	script_jump .ows_416da
; 0x416b8
.ows_416b8
	ask_question Text0953, TRUE
	script_jump_if_b0z .ows_416d7
	print_npc_text Text0954
	script_command_02
	get_player_direction
	compare_loaded_var $00
	script_jump_if_b0nz .ows_416d0
	move_player NPCMovement_416f8, TRUE
	script_jump .ows_416dd
; 0x416d0
.ows_416d0
	move_player NPCMovement_416fd, TRUE
	script_jump .ows_416dd
; 0x416d7
.ows_416d7
	print_npc_text Text0955
.ows_416da
	script_command_02
	end_script
; 0x416dc
; gap from 0x416dc to 0x416dd
; 0x416dc
; gap from 0x416dc to 0x416dd
	ret
.ows_416dd
	move_active_npc NPCMovement_416ec
	wait_for_player_animation
	move_player NPCMovement_41700, TRUE
	move_active_npc NPCMovement_416f3
	wait_for_player_animation
	script_jump .ows_4177f
; 0x416ec
NPCMovement_416ec:
	db NORTH, MOVE_2
	db EAST, MOVE_1
	db WEST, MOVE_0
	db $ff
NPCMovement_416f3:
	db WEST, MOVE_1
	db SOUTH, MOVE_2
	db $ff
NPCMovement_416f8:
	db EAST, MOVE_1
	db NORTH, MOVE_3
	db $ff
NPCMovement_416fd:
	db NORTH, MOVE_4
	db $ff
NPCMovement_41700:
	db NORTH, MOVE_2
	db EAST, MOVE_1
	db $ff
; gap from 0x41705 to 0x4177f
; 0x41705