SECTION "Bank a@7c4f", ROMX[$7c4f], BANK[$a]

; de = text ID
Func_2bc4f:
	ld hl, wd548
	ld [hl], e
	inc hl
	ld [hl], d

	ld a, $ff ; all decks
	farcall DrawDeckSelectionMenu
	xor a
.asm_2bc5c
	ld hl, .MenuParameters
	call InitializeMenuParameters
	ld hl, wd548
	ld a, [hli]
	ld h, [hl]
	ld l, a
	call DrawWideTextBox_PrintText
.loop_input
	call DoFrame
	farcall Func_8fb9
	jr c, .asm_2bc5c
	call HandleMenuInput
	jp nc, .loop_input ; can be jr
	ldh a, [hCurScrollMenuItem]
	cp $ff
	jr nz, .selected_deck
	; player canceled selection
	scf
	ret
.selected_deck
	ld [wCurDeck], a
	farcall CheckIfCurDeckIsEmpty
	jp nc, .valid ; can be jr
	; deck is empty
	farcall Func_9215
	jr .asm_2bc5c

.valid
	ld a, [wCurDeck]
	or a
	ret

.MenuParameters:
	db 1, 2 ; cursor x, cursor y
	db 3 ; y displacement between items
	db NUM_DECKS ; number of items
	db SYM_CURSOR_R ; cursor tile number
	db SYM_SPACE ; tile behind cursor
	dw NULL ; function pointer if non-0
; 0x2bc9f
