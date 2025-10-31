; Fill a bxc rectangle at de and at sp-$26,
; using tile a and the subsequent ones in the following pattern:
; | a+0*l+0*h | a+0*l+1*h | a+0*l+2*h |
; | a+1*l+0*h | a+1*l+1*h | a+1*l+2*h |
; | a+2*l+0*h | a+2*l+1*h | a+2*l+2*h |
FillRectangle::
	push de
	push af
	push hl
	add sp, -TILEMAP_WIDTH
	call DECoordToBGMap0Address
.next_row
	push hl
	push bc
	ld hl, sp+$25
	ld d, [hl]
	ld hl, sp+$27
	ld a, [hl]
	ld hl, sp+$4
	push hl
.next_tile
	ld [hli], a
	add d
	dec b
	jr nz, .next_tile
	pop de
	pop bc
	pop hl
	push hl
	push bc
	ld c, b
	ld b, 0
	call SafeCopyDataDEtoHL
	ld hl, sp+$24
	ld a, [hl]
	ld hl, sp+$27
	add [hl]
	ld [hl], a
	pop bc
	pop de
	ld hl, TILEMAP_WIDTH
	add hl, de
	dec c
	jr nz, .next_row
	add sp, $24
	pop de
	ret

; loads the four tiles of the card set 2 icon constant provided in register a
; returns carry if the specified set does not have an icon
LoadCardSet2Tiles::
	add $2
	ld e, a
	ld d, 0
	ld hl, .tile_offsets
	add hl, de
	ld a, [hl]
	cp -1
	ccf
	ret z
	ld l, a
	ld h, 0
	add hl, hl
	add hl, hl
	add hl, hl
	add hl, hl
	ld de, $3dd0 ; DuelOtherGraphics + $1d tiles
	add hl, de
	ld de, v0Tiles1 + $7c tiles
	ld b, $04
	call CopyFontsOrDuelGraphicsTiles
	or a
	ret

.tile_offsets
	db  8 ; GB
	db -1 ; PRO
	db -1 ; BASE_SET
	db  0 ; JUNGLE
	db  4 ; FOSSIL
	db 12 ; TEAM_ROCKET
	db 16 ; EXPANSION_SHEET
	db 20 ; GYM_HEROES
	db 24 ; BULBASAUR_DECK
	db 28 ; SQUIRTLE_DECK

; loads the Deck and Hand icons for the "Draw X card(s) from the deck." screen
LoadDuelDrawCardsScreenTiles::
	ld hl, $49b0 ; DuelOtherGraphics + $29 tiles
	ld de, v0Tiles1 + $74 tiles
	ld b, $08
	jp CopyFontsOrDuelGraphicsTiles

; load the face down basic / stage1 / stage2 card images shown in the check Pokemon screens
LoadDuelFaceDownCardTiles::
	ld b, $10
	jr LoadDuelCheckPokemonScreenTiles.got_num_tiles

; same as LoadDuelFaceDownCardTiles, plus also load the ACT / BPx tiles
LoadDuelCheckPokemonScreenTiles::
	ld b, $24
;	fallthrough

.got_num_tiles
	ld hl, $4000
	ld de, v0Tiles1 + $50 tiles
	call CopyFontsOrDuelGraphicsTiles
	bank1call Func_6c12
	ret

; loads the 8 tiles that make up the border of the main duel menu as well as the border
; of a large card picture (displayed after drawing the card or placing it in the arena).
LoadCardOrDuelMenuBorderTiles::
	ld hl, $4930 ; DuelOtherGraphics + $15 tiles
	ld de, v0Tiles1 + $50 tiles
	ld b, $08
	jr CopyFontsOrDuelGraphicsTiles

; loads the graphics of a card type header, used to display a picture of a card after drawing it
; or placing it in the arena. register e determines which header (TRAINER, ENERGY, PoKéMoN)
LoadCardTypeHeaderTiles::
	ld d, a
	ld e, 0
	ld hl, $34d0 ; DuelCardHeaderGraphics - $4000
	add hl, de
	ld de, v0Tiles1 + $60 tiles
	ld b, $10
	call CopyFontsOrDuelGraphicsTiles
	bank1call $6c1d
	ret

; loads the symbols that are displayed near the names of a list of cards in the hand or discard pile
LoadDuelCardSymbolTiles::
	ld hl, $37d0 ; DuelCgbSymbolGraphics - $4000
	ld de, v0Tiles1 + $50 tiles
	ld b, $30
	jr CopyFontsOrDuelGraphicsTiles

; loads the symbols for Stage 1 Pkmn card, Stage 2 Pkmn card, and Trainer card.
; unlike LoadDuelCardSymbolTiles excludes the symbols for Basic Pkmn and all energies.
LoadDuelCardSymbolTiles2::
	ld hl, $3810 ; DuelCgbSymbolGraphics + $4 tiles - $4000
	ld de, v0Tiles1 + $54 tiles
	ld b, $c
	jr CopyFontsOrDuelGraphicsTiles

; load the Deck and the Discard Pile icons
LoadDeckAndDiscardPileIcons::
	ld hl, $3148
	ld de, $cb16
	ld c, $08
	call CopyFontsOrDuelGraphicsBytes
	ld hl, $47e0
	ld de, $8a00
	ld b, $0d
	call CopyFontsOrDuelGraphicsTiles
	ld hl, $4240
	ld a, [wConsole]
	cp CONSOLE_CGB
	jr z, .copy
	ld hl, $4510
.copy
	ld de, v0Tiles1 + $50 tiles
	ld b, $30
	jr CopyFontsOrDuelGraphicsTiles

; load the tiles for the [O] and [X] symbols used to display the results of a coin toss
LoadDuelCoinTossResultTiles::
	ld hl, $3108
	ld de, $cafe
	ld c, $08
	call CopyFontsOrDuelGraphicsBytes
	ld hl, $48b0 ; DuelOtherGraphics + $d tiles
	ld de, v0Tiles2 + $30 tiles
	ld b, $08
	jr CopyFontsOrDuelGraphicsTiles

; load the tiles of the text characters used with TX_SYMBOL
LoadSymbolsFont::
	ld hl, SymbolsFont - $4000
	ld de, v0Tiles2 ; destination
	ld b, $38 ; (DuelCardHeaderGraphics - SymbolsFont) / TILE_SIZE ; number of tiles
;	fallthrough

; if hl ≤ $3fff
;   copy b tiles from Gfx1:(hl+$4000) to de
; if $4000 ≤ hl ≤ $7fff
;   copy b tiles from Gfx2:hl to de
CopyFontsOrDuelGraphicsTiles::
	ld a, BANK(Fonts) ; BANK(DuelGraphics)
	call BankpushROM
	ld c, TILE_SIZE
	call CopyGfxData
	call BankpopROM
	ret

; this function copies gfx data into sram
Func_212f::
; loads symbols fonts to sGfxBuffer1
	ld hl, SymbolsFont - $4000
	ld de, sGfxBuffer1
	ld b, $30
	call CopyFontsOrDuelGraphicsTiles
; text box frame tiles
	ld hl, $4930 ; DuelOtherGraphics + $15 tiles
	ld de, sGfxBuffer1 + $30 tiles
	ld b, $8
	call CopyFontsOrDuelGraphicsTiles
	call GetCardSymbolData
	sub $d0
	ld l, a
	ld h, $00
	add hl, hl
	add hl, hl
	add hl, hl
	add hl, hl ; *16
	ld de, $3ad0 ; DuelDmgSgbSymbolGraphics - $4000
	add hl, de
	ld de, sGfxBuffer1 + $38 tiles
	ld b, $4
	call CopyFontsOrDuelGraphicsTiles
	ld hl, $3ad0 ; DuelDmgSgbSymbolGraphics - $4000
	ld de, sGfxBuffer4 + $10 tiles
	ld b, $30
	jr CopyFontsOrDuelGraphicsTiles

; load the graphics and draw the duel box message given a BOXMSG_* constant in a
DrawDuelBoxMessage::
	push af
	add a
	add a
	add a
	ld e, a
	ld d, 0
	ld hl, $3110
	add hl, de
	ld de, $cafe
	ld c, 8
	call CopyFontsOrDuelGraphicsBytes
	call BankswitchVRAM1
	ld a, 2
	ld hl, 0
	call Func_1eb1
	call BankswitchVRAM0
	pop af
	ld l, a
	ld h, 40 tiles / 4 ; boxes are 10x4 tiles
	call HtimesL
	add hl, hl
	add hl, hl
	; hl = a * 40 tiles
	ld de, $4a30 ; DuelBoxMessages
	add hl, de
	ld de, v0Tiles1 + $20 tiles
	ld b, 40
	call CopyFontsOrDuelGraphicsTiles
	ld a, $a0
	lb hl, 1, 10
;	fallthrough

Func_1eb1::
	lb bc, 10, 4
	lb de, 5, 4
	jp FillRectangle

; load the tiles for the latin, katakana, and hiragana fonts into VRAM
; from gfx/fonts/full_width/3.1bpp and gfx/fonts/full_width/4.1bpp
LoadFullWidthFontTiles::
	ld hl, FullWidthFonts + $4b5 tiles_1bpp - $4000
	ld a, BANK(Fonts) ; BANK(DuelGraphics)
	call BankpushROM
	push hl
	ld e, l
	ld d, h
	ld hl, v0Tiles0
	call Copy1bppTiles
	pop de
	ld hl, v0Tiles2
	call Copy1bppTiles
	ld hl, v0Tiles1
	call Copy1bppTiles
	call BankpopROM
	ret

; copy 128 1bpp tiles from de to hl as 2bpp
Copy1bppTiles::
	ld b, $80
.tile_loop
	ld c, TILE_SIZE_1BPP
.pixel_loop
	ld a, [de]
	inc de
	ld [hli], a
	ld [hli], a
	dec c
	jr nz, .pixel_loop
	dec b
	jr nz, .tile_loop
	ret

CopyFontsOrDuelGraphicsBytes::
	ld a, BANK(Fonts) ; BANK(DuelGraphics)
	call BankpushROM
.loop_copy
	ld a, [hli]
	ld [de], a
	inc de
	dec c
	jr nz, .loop_copy
	call BankpopROM
	ret
