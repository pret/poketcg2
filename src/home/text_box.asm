
; copy c bytes of data from de to hl
; if LCD on, copy during h-blank only
SafeCopyDataDEtoHL:
	ldh a, [hLCDC]       ;
	bit B_LCDC_ENABLE, a ;
	jr nz, .lcd_on       ; assert that LCD is on
.lcd_off_loop
	ld a, [de]
	inc de
	ld [hli], a
	dec c
	jr nz, .lcd_off_loop
	ret
.lcd_on
	jp HblankCopyDataDEtoHL

; returns v*BGMap0 + TILEMAP_WIDTH * e + d in hl.
; used to map coordinates at de to a BGMap0 address.
DECoordToBGMap0Address:
	ld l, e
	ld h, $0
	add hl, hl
	add hl, hl
	add hl, hl
	add hl, hl
	add hl, hl
	ld a, l
	add d
	ld l, a
	ld a, h
	adc HIGH(v0BGMap0)
	ld h, a
	ret

; Apply SCX and SCY correction to xy coordinates at de
AdjustCoordinatesForBGScroll::
	push af
	ldh a, [hSCX]
	rra
	rra
	rra
	and $1f
	add d
	ld d, a
	ldh a, [hSCY]
	rra
	rra
	rra
	and $1f
	add e
	ld e, a
	pop af
	ret

; Draws a bxc text box at de printing a name in the left side of the top border.
; The name's text id must be at hl when this function is called.
; Mostly used to print text boxes for talked-to NPCs, but occasionally used in duels as well.
DrawLabeledTextBox::
	push de
	push bc
	push hl
	; top left tile of the box
	ld hl, wc000
	ld a, TX_SYMBOL
	ld [hli], a
	ld a, SYM_BOX_TOP_L
	ld [hli], a
	; white tile before the text
	ldfw a, " "
	ld [hli], a
	; text label
	ld e, l
	ld d, h
	pop hl
	call CopyText
	ld hl, wc000 + 3
	call GetTextLengthInTiles
	ld [wcd5c], a
	ld l, e
	ld h, d
	; white tile after the text
	ld a, TX_HALF2FULL
	ld [hli], a
	ldfw a, " "
	ld [hli], a
	pop de
	push de
	ld a, d
	sub b
	sub $4
	ld b, a
.draw_top_border_line_loop
	ld a, TX_SYMBOL
	ld [hli], a
	ld a, SYM_BOX_TOP
	ld [hli], a
	dec b
	jr nz, .draw_top_border_line_loop

.draw_top_border_right_tile
	ld a, TX_SYMBOL
	ld [hli], a
	ld a, SYM_BOX_TOP_R
	ld [hli], a
	ld [hl], TX_END
	pop bc
	pop de
	push de
	push bc
	call InitTextPrinting
	ld hl, wc000
	call ProcessText
	pop bc
	pop de
	ld a, [wConsole]
	cp CONSOLE_CGB
	jr z, .cgb
; DMG or SGB
	inc e
	call DECoordToBGMap0Address
	; top border done, draw the rest of the text box
	jr ContinueDrawingTextBoxDMGorSGB

.cgb
	call DECoordToBGMap0Address
	push hl
	push de
	call CopyCurrentLineAttrCGB
	pop de
	pop hl
	push bc
	push hl
	push de
	ld a, [wcd5c]
	cpl
	inc a
	ld c, a
	ld b, a
	ld e, l
	ld d, h
	ld hl, wc000
	xor a
.asm_1c8b
	ld [hli], a
	dec c
	jr nz, .asm_1c8b
	ld hl, wc000
	inc de
	inc de
	call BankswitchVRAM1
	call SafeCopyDataHLtoDE
	call BankswitchVRAM0
	pop de
	pop hl
	ld bc, $20
	add hl, bc
	pop bc
	inc e
	jp ContinueDrawingTextBoxCGB

; Draws a bxc text box at de to print menu data in the overworld.
; Also used to print a text box during a duel.
; When talking to NPCs, DrawLabeledTextBox is used instead.
DrawRegularTextBox::
	ld a, [wConsole]
	cp CONSOLE_CGB
	jr z, DrawRegularTextBoxCGB
;	fallthrough

DrawRegularTextBoxDMG::
	call DECoordToBGMap0Address
	; top line (border) of the text box
	ld a, SYM_BOX_TOP
	lb de, SYM_BOX_TOP_L, SYM_BOX_TOP_R
	call CopyLine
;	fallthrough

; continue drawing a labeled or regular textbox on DMG or SGB:
; body and bottom line of either type of textbox
ContinueDrawingTextBoxDMGorSGB:
	dec c
	dec c
.draw_text_box_body_loop
	ld a, SYM_SPACE
	lb de, SYM_BOX_LEFT, SYM_BOX_RIGHT
	call CopyLine
	dec c
	jr nz, .draw_text_box_body_loop
	; bottom line (border) of the text box
	ld a, SYM_BOX_BOTTOM
	lb de, SYM_BOX_BTM_L, SYM_BOX_BTM_R
;	fallthrough

; copies b bytes of data to sp-$1f and to hl, and returns hl += TILEMAP_WIDTH
; d = value of byte 0
; e = value of byte b
; a = value of bytes [1, b-1]
; b is supposed to be TILEMAP_WIDTH or smaller, else the stack would get corrupted
CopyLine::
	add sp, -TILEMAP_WIDTH
	push hl
	push bc
	ld hl, sp+$4
	dec b
	dec b
	push hl
	ld [hl], d
	inc hl
.loop
	ld [hli], a
	dec b
	jr nz, .loop
	ld [hl], e
	pop de
	pop bc
	pop hl
	push hl
	push bc
	ld c, b
	ld b, $0
	call SafeCopyDataDEtoHL
	pop bc
	pop de
	; advance pointer TILEMAP_WIDTH positions and restore stack pointer
	ld hl, TILEMAP_WIDTH
	add hl, de
	add sp, TILEMAP_WIDTH
	ret

; DrawRegularTextBox branches here on CGB console
DrawRegularTextBoxCGB:
	call DECoordToBGMap0Address
	; top line (border) of the text box
	ld a, SYM_BOX_TOP
	lb de, SYM_BOX_TOP_L, SYM_BOX_TOP_R
	call CopyCurrentLineTilesAndAttrCGB
;	fallthrough

; continue drawing a labeled or regular textbox on CGB:
; body and bottom line of either type of textbox
ContinueDrawingTextBoxCGB:
	dec c
	dec c
.draw_text_box_body_loop
	ld a, SYM_SPACE
	lb de, SYM_BOX_LEFT, SYM_BOX_RIGHT
	push hl
	call CopyLine
	pop hl
	call BankswitchVRAM1
	ld a, [wTextBoxFrameType] ; on CGB, wTextBoxFrameType determines the palette and the other attributes
	ld e, a
	ld d, a
	xor a
	call CopyLine
	call BankswitchVRAM0
	dec c
	jr nz, .draw_text_box_body_loop
	; bottom line (border) of the text box
	ld a, SYM_BOX_BOTTOM
	lb de, SYM_BOX_BTM_L, SYM_BOX_BTM_R
	call CopyCurrentLineTilesAndAttrCGB
	ret

; d = id of top left tile
; e = id of top right tile
; a = id of rest of tiles
; Assumes b = SCREEN_WIDTH and that VRAM bank 0 is loaded
CopyCurrentLineTilesAndAttrCGB:
	push hl
	call CopyLine
	pop hl
;	fallthrough

CopyCurrentLineAttrCGB:
	call BankswitchVRAM1
	ld a, [wTextBoxFrameType] ; on CGB, wTextBoxFrameType determines the palette and the other attributes
	ld e, a
	ld d, a
	call CopyLine
	call BankswitchVRAM0
	ret
