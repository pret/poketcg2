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

; loads a player deck (sDeck*Cards) from SRAM to wPlayerDeck
; sCurrentlySelectedDeck determines which sDeck*Cards source (0-3)
LoadPlayerDeck:
	call EnableSRAM
	ld a, [sCurrentlySelectedDeck]
	ld l, a
	ld h, DECK_COMPRESSED_STRUCT_SIZE
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

SECTION "Bank 1@6897", ROMX[$6897], BANK[$1]

; writes the cards in de to hl
; in a compressed format
SaveDeckCards:
	push hl
	push de
	push bc
	ld a, 8
.loop
	push af
	inc hl
	ld c, 8
.loop_bits
	ld a, [de]
	inc de
	ld [hli], a
	ld a, [de]
	inc de
	rra
	rl b
	dec c
	jr nz, .loop_bits
	push hl
	push de
	ld de, -9
	add hl, de
	ld [hl], b
	pop de
	pop hl
	pop af
	dec a
	jr nz, .loop
	pop bc
	pop de
	pop hl
	ret

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
