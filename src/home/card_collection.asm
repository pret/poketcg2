; return, in hl, the total amount of cards owned anywhere, including duplicates
GetAmountOfCardsOwned::
	push de
	push bc
	call EnableSRAM
	ld hl, 0
	ld de, sDeck1Cards
	ld c, NUM_DECKS
.next_deck
	ld a, [de]
	bit 0, a
	jr nz, .asm_1ac2
	inc de
	ld a, [de]
	dec de
	or a
	jr z, .skip_deck ; jump if deck empty
.asm_1ac2
	ld a, c
	ld bc, DECK_SIZE
	add hl, bc
	ld c, a
.skip_deck
	ld a, sDeck2Cards - sDeck1Cards
	add e
	ld e, a
	ld a, $0
	adc d
	ld d, a ; de = sDeck*Cards[x]
	dec c
	jr nz, .next_deck
	; hl = DECK_SIZE * (no. of non-empty decks)
	ld bc, CARD_COLLECTION_SIZE
	ld de, sCardCollection
.next_card
	push bc
	ld a, [de]
	bit CARD_NOT_OWNED_F, a
	jr nz, .skip_card
	ld c, a ; card count in sCardCollection
	ld b, $0
	add hl, bc
.skip_card
	pop bc
	inc de
	dec bc
	ld a, c
	or b
	jr nz, .next_card
	call DisableSRAM
	pop bc
	pop de
	ret

; return carry if the count in sCardCollection plus the count in each deck (sDeck*)
; of the card with id given in de is 0 (if card not owned).
; also return the count (total owned amount) in a.
GetCardCountInCollectionAndDecks::
	push hl
	push de
	push bc
	call EnableSRAM
	ld a, e
	ldh [hTempCardID_ff9b], a
	ld a, d
	ldh [hTempCardID_ff9b + 1], a
	ld c, $0
	ld hl, sCardCollection
	add hl, de
	bit CARD_NOT_OWNED_F, [hl]
	jr nz, .not_owned
	ld c, [hl] ; count in collection
.not_owned
	ld de, sDeck1Cards
	ld b, NUM_DECKS
.next_deck
	push de
	ld hl, wDuelTempList
	bank1call DecompressSRAMDeck
.next_card
	ld a, [hli]
	or [hl]
	dec hl
	jr z, .deck_done
	ldh a, [hTempCardID_ff9b]
	cp [hl]
	jr nz, .no_match
	ldh a, [hTempCardID_ff9b + 1]
	inc hl
	cp [hl]
	dec hl
	jr nz, .no_match
	inc c
.no_match
	inc hl
	inc hl
	jr .next_card
.deck_done
	pop de
	ld hl, sDeck2Cards - sDeck1Cards
	add hl, de
	ld e, l
	ld d, h
	dec b
	jr nz, .next_deck
	ld a, c
	call DisableSRAM
	pop bc
	pop de
	pop hl
	or a
	ret nz
	scf
	ret

; return carry if the count in sCardCollection of the card with id given in de is 0.
; also return the count (amount owned outside of decks) in a.
GetCardCountInCollection::
	push hl
	call EnableSRAM
	ld hl, sCardCollection
	add hl, de
	ld a, [hl]
	call DisableSRAM
	pop hl
	and CARD_COUNT_MASK
	ret nz
	scf
	ret

; add card with id given in de to sCardCollection, provided that
; the player has less than MAX_AMOUNT_OF_CARD (99) of them
AddCardToCollection::
	push hl
	push bc
	push de
	bank1call CreateTempCardCollection
	pop de
	call EnableSRAM
	ld hl, wTempCardCollection
	add hl, de
	ld a, [hl]
	and CARD_COUNT_MASK
	cp MAX_AMOUNT_OF_CARD
	jr nc, .already_max
	ld hl, sCardCollection
	add hl, de
	ld a, [hl]
	and CARD_COUNT_MASK
	inc a
	ld [hl], a
.already_max
	call DisableSRAM
	pop bc
	pop hl
	ret

; remove a card with id given in de from sCardCollection (decrement its count if non-0)
RemoveCardFromCollection::
	push hl
	call EnableSRAM
	ld hl, sCardCollection
	add hl, de
	ld a, [hl]
	and CARD_COUNT_MASK
	jr z, .zero
	dec a
	ld [hl], a
.zero
	call DisableSRAM
	pop hl
	ret

; return the amount of different cards that the player has collected in de
; return NUM_CARDS in bc, minus 1 for each unowned hidden promo card
;   (VENUSAUR_LV64, MEW_LV15, HERE_COMES_TEAM_ROCKET, and LUGIA)
GetCardAlbumProgress::
	push hl
	call EnableSRAM
	ld bc, NUM_CARDS
	ld hl, sCardCollection + VENUSAUR_LV64
	bit CARD_NOT_OWNED_F, [hl]
	jr z, .next1
	dec bc ; if VENUSAUR_LV64 not owned
.next1
	ld hl, sCardCollection + MEW_LV15
	bit CARD_NOT_OWNED_F, [hl]
	jr z, .next2
	dec bc ; if MEW_LV15 not owned
.next2
	ld hl, sCardCollection + HERE_COMES_TEAM_ROCKET
	bit CARD_NOT_OWNED_F, [hl]
	jr z, .next3
	dec bc ; if HERE_COMES_TEAM_ROCKET not owned
.next3
	ld hl, sCardCollection + LUGIA
	bit CARD_NOT_OWNED_F, [hl]
	jr z, .next4
	dec bc ; if LUGIA not owned
.next4
	push bc
	ld bc, NUM_CARDS + 1
	ld de, 0
	ld hl, sCardCollection
.next_card
	bit CARD_NOT_OWNED_F, [hl]
	jr nz, .skip
	inc de ; if this card owned
.skip
	inc hl
	dec bc
	ld a, c
	or b
	jr nz, .next_card
	pop bc
	pop hl
	call DisableSRAM
	ret

; frame function during Link Opponent's turn
; if opponent makes a decision, jump directly
; to the address in wLinkOpponentTurnReturnAddress
LinkOpponentTurnFrameFunction::
	ld a, [wSerialFlags]
	or a
	jr nz, .return
	call tcg1_Func_0e32
	ret nc
.return
	ld a, $09
	call BankswitchROM
	ld hl, wLinkOpponentTurnReturnAddress
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld sp, hl
	scf
	ret
