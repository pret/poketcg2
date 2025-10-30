; wait for VBlankHandler to finish unless lcd is off
WaitForVBlank::
	push hl
	ldh a, [hLCDC]
	bit B_LCDC_ENABLE, a
	jr z, .lcd_off
	ld hl, wVBlankCounter
	ld a, [hl]
.wait_vblank
	halt
	nop
	cp [hl]
	jr z, .wait_vblank
.lcd_off
	pop hl
	ret

; turn LCD on
EnableLCD::
	ldh a, [hLCDC]       ;
	bit B_LCDC_ENABLE, a ;
	ret nz               ; assert that LCD is off
	or LCDC_ON           ;
	ldh [hLCDC], a       ;
	ldh [rLCDC], a       ; turn LCD on
	ld a, FLUSH_ALL_PALS
	ldh [hFlushPaletteFlags], a
	ret

; wait for vblank, then turn LCD off
DisableLCD::
	ldh a, [rLCDC]       ;
	bit B_LCDC_ENABLE, a ;
	ret z                ; assert that LCD is on
	ldh a, [rIE]
	ld [wIE], a
	res B_IE_VBLANK, a   ;
	ldh [rIE], a         ; disable vblank interrupt
.wait_vblank
	ldh a, [rLY]         ;
	cp LY_VBLANK + 1     ;
	jr nz, .wait_vblank  ; wait for vblank
	ldh a, [rLCDC]       ;
	and LOW(~LCDC_ON)    ;
	ldh [rLCDC], a       ;
	ldh a, [hLCDC]       ;
	and LOW(~LCDC_ON)    ;
	ldh [hLCDC], a       ; turn LCD off
	xor a
	ldh [rBGP], a
	ldh [rOBP0], a
	ldh [rOBP1], a
	ld a, [wIE]
	ldh [rIE], a
	ret

; set OBJ size: 8x8
Set_OBJ_8x8::
	ldh a, [hLCDC]
	and ~LCDC_OBJ_16
	ldh [hLCDC], a
	ret

; set OBJ size: 8x16
Set_OBJ_8x16::
	ldh a, [hLCDC]
	or LCDC_OBJ_16
	ldh [hLCDC], a
	ret

; set Window Display on
SetWindowOn::
	ldh a, [hLCDC]
	or LCDC_WIN_ON
	ldh [hLCDC], a
	ret

; set Window Display off
SetWindowOff::
	ldh a, [hLCDC]
	and ~LCDC_WIN_ON
	ldh [hLCDC], a
	ret
