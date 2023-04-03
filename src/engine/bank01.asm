SECTION "Bank 1@563e", ROMX[$563e], BANK[$1]

ZeroObjectPositionsAndToggleOAMCopy:
	call ZeroObjectPositions
	ld a, $01
	ld [wVBlankOAMCopyToggle], a
	ret

SECTION "Bank 1@59f4", ROMX[$59f4], BANK[$1]

SetLineSeparation:
	ld [wLineSeparation], a
	ret

SetZeroLineSeparation:
	xor a
	jr SetLineSeparation
; 0x59fb

SECTION "Bank 1@610c", ROMX[$610c], BANK[$1]

LoadPlayerDeck:
	call EnableSRAM
	ld a, [sb7a0]
	ld l, a
	ld h, $60
	call HtimesL
	ld de, sDeck1Cards
	add hl, de
	ld e, l
	ld d, h
	ld hl, wPlayerDeck
	call LoadDeckFromSRAM
	call DisableSRAM
	ret
; 0x6128

SECTION "Bank 1@68bc", ROMX[$68bc], BANK[$1]

; loads deck saved in SRAM to hl
LoadDeckFromSRAM:
	push hl
	push de
	push bc
	ld a, $08
.loop_outer
	push af
	ld a, [de]
	inc de
	ld b, a
	ld c, 8 ; number of bits
.loop_inner
	ld a, [de]
	inc de
	ld [hli], a
	xor a
	rl b
	rla
	ld [hli], a
	dec c
	jr nz, .loop_inner
	pop af
	dec a
	jr nz, .loop_outer
	pop bc
	pop de
	pop hl
	ret
; 0x68da

SECTION "Bank 1@6bc8", ROMX[$6bc8], BANK[$1]

SetDefaultPalettes:
	call SetFontAndTextBoxFrameColor
	ld a, %11100100
	ld [wOBP0], a
	ld [wBGP], a
	ld a, $01 ; equivalent to FLUSH_ONE_PAL
	ldh [hFlushPaletteFlags], a
	ld hl, Pals_6f0b0 - $4000
	ld de, wObjectPalettesCGB
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
