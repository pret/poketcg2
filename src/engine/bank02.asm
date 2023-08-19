SECTION "Bank 2@4f10", ROMX[$4f10], BANK[$2]

Func_8f10:
	call EnableSRAM
	xor a
	ld hl, $b7a3
	ld [hli], a
	inc a
	ld [hli], a
	ld [hli], a
	ld [hl], a
	ld [$b7a1], a
	call DisableSRAM

	xor a
	ld [wTileMapFill], a
	call EmptyScreen
	call ZeroObjectPositions
	ld a, $01
	ld [wVBlankOAMCopyToggle], a
	call LoadSymbolsFont
	call LoadDuelCardSymbolTiles
	farcall LoadHandCardsIcon
	bank1call SetDefaultPalettes
	ld de, $3cbf
	call SetupText
	ret
; 0x8f45

SECTION "Bank 2@5c26", ROMX[$5c26], BANK[$2]

; clears a bytes in hl
ClearBytesInHL:
	push af
	push bc
	push hl
	ld b, a
	xor a
.loop
	ld [hli], a
	dec b
	jr nz, .loop
	pop hl
	pop bc
	pop af
	ret
; 0x9c33
