; load data of card with text id of name at de to wLoadedCard1
LoadCardDataToBuffer1_FromName:
	ld hl, CardPointers - $4000 + $2 ; skip first NULL pointer
	ld a, BANK(CardPointers)
	call BankpushROM
.find_card_loop
	ld a, [hli]
	or [hl]
	jr z, .done
	push hl
	ld a, [hld]
	ld l, [hl]
	ld h, a
	ld a, BANK(CardPointers)
	call BankpushROM
	ld bc, CARD_DATA_NAME
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	call BankpopROM
	ld a, l
	cp e
	jr nz, .no_match
	ld a, h
	cp d
.no_match
	pop hl
	inc hl
	jr nz, .find_card_loop
	dec hl
	ld a, [hld]
	ld l, [hl]
	ld h, a
	ld a, BANK(CardPointers)
	call BankpushROM
	ld de, wLoadedCard1
	ld b, PKMN_CARD_DATA_LENGTH
.copy_card_loop
	ld a, [hli]
	ld [de], a
	inc de
	dec b
	jr nz, .copy_card_loop
	call BankpopROM
	call BankpopROM
	ret
.done
	call BankpopROM
	debug_nop
	ret

; load data of card with id at de to wLoadedCard2
LoadCardDataToBuffer2_FromCardID::
	push hl
	ld hl, wLoadedCard2
	jr LoadCardDataToHL_FromCardID

; load data of card with id at de to wLoadedCard1
LoadCardDataToBuffer1_FromCardID::
	push hl
	ld hl, wLoadedCard1
;	fallthrough

LoadCardDataToHL_FromCardID:
	push de
	push bc
	push hl
	call GetCardPointer
	pop de
	jr c, .done
	ld a, BANK(CardPointers)
	call BankpushROM
	ld b, PKMN_CARD_DATA_LENGTH
.copy_card_data_loop
	ld a, [hli]
	ld [de], a
	inc de
	dec b
	jr nz, .copy_card_data_loop
	call BankpopROM
	or a
.done
	pop bc
	pop de
	pop hl
	ret

; return in a the type (TYPE_* constant) of the card with id at de
GetCardType::
	push hl
	call GetCardPointer
	jr c, .done
	ld a, BANK(CardPointers)
	call BankpushROM
	ld l, [hl]
	call BankpopROM
	ld a, l
	or a
.done
	pop hl
	ret

; returns nz if card ID given in de is a Dark Pokémon
CheckIfCardIDIsDarkPokemon::
	push hl
	push de
	call GetCardPointer
	jr c, .done
	ld a, BANK(CardPointers)
	call BankpushROM
	ld de, CARD_DATA_DARK
	add hl, de
	ld l, [hl]
	call BankpopROM
	ld a, l
	or a
.done
	pop de
	pop hl
	ret

; return in de the 2-byte text id of the name of the card with id at de
GetCardName::
	push hl
	call GetCardPointer
	jr c, .done
	ld a, BANK(CardPointers)
	call BankpushROM
	ld de, CARD_DATA_NAME
	add hl, de
	ld e, [hl]
	inc hl
	ld d, [hl]
	call BankpopROM
	or a
.done
	pop hl
	ret

; from the card id in de, returns type into a, rarity into b, and set into c
GetCardTypeRarityAndSet::
	push hl
	push de
	call GetCardPointer
	jr c, .done
	ld a, BANK(CardPointers)
	call BankpushROM
	ld e, [hl] ; CARD_DATA_TYPE
	ld bc, CARD_DATA_RARITY
	add hl, bc
	ld b, [hl] ; CARD_DATA_RARITY
	inc hl
	inc hl
	ld c, [hl] ; CARD_DATA_SET
	call BankpopROM
	ld a, e
	or a
.done
	pop de
	pop hl
	ret

; return at hl the pointer to the data of the card with id at de
; return carry if de was out of bounds, so no pointer was returned
GetCardPointer:
	push de
	push bc
	ld a, d
	or e
	jr z, .invalid
	cp16 NUM_CARDS + 1
	jr c, .valid
.invalid
	scf
	jr .done
.valid
	ld l, e
	ld h, d
	add hl, hl
	ld bc, CardPointers - $4000
	add hl, bc
	ld a, BANK(CardPointers)
	call BankpushROM
	ld a, [hli]
	ld h, [hl]
	ld l, a
	call BankpopROM
	or a
.done
	pop bc
	pop de
	ret

; input:
;   hl = card gfx index
;   de = destination
;   b = NUM_CARD_GFX_TILES
;   c = TILE_SIZE
; also set wCardPalette and wCardAttributes
LoadCardGfx::
	ldh a, [hBankROM]
	push af
	call LoadCardPalettesAndAttributes
	call CopyGfxData
	pop af
	call BankswitchROM
	ret

; LoadCardGfx but with printer-only alt tiles where appropriate
; based on CARD_GFX_CARD_ATTR_ALT_OFFSET
; see BuildPrintableCardPic
; input:
;   hl = card gfx index
;   de = destination
;   b = NUM_CARD_GFX_TILES
;   c = TILE_SIZE
LoadCardGfx_PrinterAlt::
	ldh a, [hBankROM]
	push af
	call LoadCardPalettesAndAttributes
	ld a, l
	ld [wCardGfxTileBase + 0], a
	ld a, h
	ld [wCardGfxTileBase + 1], a
	ld hl, wCardAttributes
	lb bc, NUM_CARD_GFX_TILES, 0
.loop_copy
	; mask offset
	; offset = 48 + (cur alt tile idx) - (cur tile idx) if has alt,
	; 0 otherwise
	ld a, [hl]
	and CARD_GFX_CARD_ATTR_ALT_OFFSET
	ld [hli], a
	push hl
	push bc
	add c ; += (cur tile idx)
	; a = 48 + (cur alt tile idx) if has alt,
	; (cur tile idx) otherwise
	; get source tile addr
	ld l, a
	ld h, $00
REPT 4 ; *= TILE_SIZE
	add hl, hl
ENDR
	ld a, [wCardGfxTileBase + 0]
	add l
	ld l, a
	ld a, [wCardGfxTileBase + 1]
	adc h
	ld h, a
	; copy tile
	ld b, TILE_SIZE
	call SafeCopyDataHLtoDE
	pop bc
	pop hl
	inc c
	dec b
	jr nz, .loop_copy

	pop af
	call BankswitchROM
	ret

; hl = card gfx index
; set up wCardPalettes and wCardAttributes, and
; return hl = card tile address
LoadCardPalettesAndAttributes:
	push bc
	push de
	push hl
	ld a, h
REPT 3 ; /= 8
	srl a
ENDR
	add BANK(CardGraphics)
	call BankswitchROM
	pop hl
REPT 3 ; *= 8
	add hl, hl
ENDR
	res 7, h
	set 6, h ; $4000 ≤ hl ≤ $7fff
	ld b, CARDGFXSTRUCT_HEADER_SIZE
	ld de, wCardGfxHeaderData
.loop_copy
	ld a, [hli]
	ld [de], a
	inc de
	dec b
	jr nz, .loop_copy
	pop de
	pop bc
	ret

; identical to CopyFontsOrDuelGraphicsTiles
CopyFontsOrDuelGraphicsTiles2:
	ld a, BANK(Fonts) ; BANK(DuelGraphics)
	call BankpushROM
	ld c, TILE_SIZE
	call CopyGfxData
	call BankpopROM
	ret
