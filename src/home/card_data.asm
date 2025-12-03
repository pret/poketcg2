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
; hl = card_gfx_index
; de = where to load the card gfx to
; bc are supposed to be $30 (number of tiles of a card gfx) and TILE_SIZE respectively
; card_gfx_index = (<Name>CardGfx - CardGraphics) / 8  (using absolute ROM addresses)
; also copies the card's palette to wCardPalette
LoadCardGfx::
	ldh a, [hBankROM]
	push af
	call LoadCardPalettes
	call CopyGfxData
	pop af
	call BankswitchROM
	ret

Func_2dc4::
	ldh a, [hBankROM]
	push af
	call LoadCardPalettes
	ld a, l
	ld [wcde5 + 0], a
	ld a, h
	ld [wcde5 + 1], a
	ld hl, wCardAttrMap
	lb bc, $30, 0
.loop_copy
	ld a, [hl]
	and $3f
	ld [hli], a
	push hl
	push bc
	add c
	ld l, a
	ld h, $00
	add hl, hl
	add hl, hl
	add hl, hl
	add hl, hl ; *TILE_SIZE
	ld a, [wcde5 + 0]
	add l
	ld l, a
	ld a, [wcde5 + 1]
	adc h
	ld h, a
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

LoadCardPalettes:
	push bc
	push de
	push hl
	ld a, h
	srl a
	srl a
	srl a ; /8
	add BANK(CardGraphics)
	call BankswitchROM
	pop hl
	add hl, hl
	add hl, hl
	add hl, hl ; *8
	res 7, h
	set 6, h ; $4000 ≤ hl ≤ $7fff
	ld b, 3 palettes + $30 ; palettes + attributes
	ld de, wCardPalettes
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
