SECTION "Duel Core@563e", ROMX[$563e], BANK[$1]

ZeroObjectPositionsAndToggleOAMCopy:
	call ZeroObjectPositions
	ld a, $01
	ld [wVBlankOAMCopyToggle], a
	ret

SECTION "Duel Core@6bc8", ROMX[$6bc8], BANK[$1]

SetDefaultPalettes:
	call SetFontAndTextBoxFrameColor
	ld a, %11100100
	ld [wOBP0], a
	ld [wBGP], a
	ld a, $01 ; equivalent to FLUSH_ONE_PAL
	ldh [hFlushPaletteFlags], a
	ld hl, Pals_6f0b0 - $4000
	ld de, wcb2e
	ld c, CGB_PAL_SIZE
	call CopyFontsOrDuelGraphicsBytes
	call FlushAllPalettes
	ret

SetFontAndTextBoxFrameColor:
	ld a, $01
	ld [wTextBoxFrameType], a
	ld hl, Pals_6f0b0 - $4000
	ld de, wBackgroundPalettesCGB
	ld c, CGB_PAL_SIZE
	call CopyFontsOrDuelGraphicsBytes
	push de
	call EnableSRAM
	ld a, [sTextBoxFrameColor]
	call DisableSRAM
	inc a
	add a
	add a
	add a ; *CGB_PAL_SIZE
	ld e, a
	ld d, $00
	ld hl, Pals_6f0b0 - $4000
	add hl, de
	pop de
	ld c, CGB_PAL_SIZE
	call CopyFontsOrDuelGraphicsBytes
	ret
