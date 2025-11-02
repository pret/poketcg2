DebugNop:
	ret

; copies the deck pointed to by de to wPlayerDeck or wOpponentDeck (depending on whose turn it is)
CopyDeckData:
	ld hl, wPlayerDeck
	ldh a, [hWhoseTurn]
	cp PLAYER_TURN
	jr z, .copy_deck_data
	ld hl, wOpponentDeck
.copy_deck_data
	; start by putting a terminator at the end of the deck
	push hl
	ld bc, DECK_SIZE_BYTES - 2
	add hl, bc
	xor a
	ld [hli], a
	ld [hl], a
	pop hl
	push hl
.next_card
	ld a, [de]
	inc de
	ld b, a
	or a
	jr z, .done
.card_quantity_loop
	ld a, [de]
	inc de
	ld [hli], a
	ld a, [de]
	ld [hli], a
	dec de
	dec b
	jr nz, .card_quantity_loop
	inc de
	inc de
	jr .next_card
.done
	pop hl
	ld bc, DECK_SIZE_BYTES - 2
	add hl, bc
	ld a, [hli]
	or [hl]
	jr z, .fail
	inc hl
	ld a, [hli]
	or [hl]
	jr nz, .fail
	ret
.fail
	debug_nop
	scf
	ret

; return, in register a, the amount of prizes that the turn holder has not yet drawn
CountPrizes::
	push hl
	ld a, DUELVARS_PRIZES
	get_turn_duelist_var
	ld l, a
	xor a
.count_loop
	rr l
	adc $00
	inc l
	dec l
	jr nz, .count_loop
	pop hl
	ret

; draw a card from the turn holder's deck, saving its location as CARD_LOCATION_JUST_DRAWN.
; returns carry if deck is empty, nc if a card was successfully drawn.
; AddCardToHand is meant to be called next (unless this function returned carry).
DrawCardFromDeck::
	push hl
	ld a, DUELVARS_NUMBER_OF_CARDS_NOT_IN_DECK
	get_turn_duelist_var
	cp DECK_SIZE
	jr nc, .empty_deck
	inc a
	ld [hl], a ; increment number of cards not in deck
	add DUELVARS_DECK_CARDS - 1 ; point to top card in the deck
	ld l, a
	ld a, [hl] ; grab card number (0-59) from wPlayerDeckCards or wOpponentDeckCards array
	ld l, a
	ld [hl], CARD_LOCATION_JUST_DRAWN ; temporarily write to corresponding card location variable
	pop hl
	or a
	ret
.empty_deck
	pop hl
	scf
	ret

; add a card to the top of the turn holder's deck
; the card is identified by register a, which contains the deck index (0-59) of the card
ReturnCardToDeck::
	push hl
	call CheckDeckIndexRange
	push af
	ld a, DUELVARS_NUMBER_OF_CARDS_NOT_IN_DECK
	get_turn_duelist_var
	dec a
	ld [hl], a ; decrement number of cards not in deck
	add DUELVARS_DECK_CARDS
	ld l, a ; point to top deck card
	pop af
	ld [hl], a ; set top deck card
	ld l, a
	ld [hl], CARD_LOCATION_DECK
	ld a, l
	pop hl
	ret

; search a card in the turn holder's deck, extract it, and set its location to
; CARD_LOCATION_JUST_DRAWN. AddCardToHand is meant to be called next.
; the card is identified by register a, which contains the deck index (0-59) of the card.
SearchCardInDeckAndAddToHand::
	push af
	push hl
	push de
	push bc
	call CheckDeckIndexRange
	ld c, a
	ld a, DUELVARS_NUMBER_OF_CARDS_NOT_IN_DECK
	get_turn_duelist_var
	ld a, DECK_SIZE
	sub [hl]
	inc [hl] ; increment number of cards not in deck
	ld b, a ; DECK_SIZE - [DUELVARS_NUMBER_OF_CARDS_NOT_IN_DECK] (number of cards in deck)
	ld l, c
	set CARD_LOCATION_JUST_DRAWN_F, [hl]
	ld l, DUELVARS_DECK_CARDS + DECK_SIZE - 1
	ld e, l
	ld d, h ; hl = de = DUELVARS_DECK_CARDS + DECK_SIZE - 1 (last card)
	inc b
	jr .match
.loop
	ld a, [hld]
	cp c
	jr z, .match
	ld [de], a
	dec de
.match
	dec b
	jr nz, .loop
	pop bc
	pop de
	pop hl
	pop af
	ret

; adds a card to the turn holder's hand and increments the number of cards in the hand
; the card is identified by register a, which contains the deck index (0-59) of the card
AddCardToHand::
	push af
	push hl
	push de
	call CheckDeckIndexRange
	ld e, a
	ld l, a
	ldh a, [hWhoseTurn]
	ld h, a
	; write CARD_LOCATION_HAND into the location of this card
	ld [hl], CARD_LOCATION_HAND
	; increment number of cards in hand
	ld l, DUELVARS_NUMBER_OF_CARDS_IN_HAND
	inc [hl]
	; add card to hand
	ld a, DUELVARS_HAND - 1
	add [hl]
	ld l, a
	ld [hl], e
	pop de
	pop hl
	pop af
	ret

; removes a card from the turn holder's hand and decrements the number of cards in the hand
; the card is identified by register a, which contains the deck index (0-59) of the card
RemoveCardFromHand::
	push af
	push hl
	push bc
	push de
	call CheckDeckIndexRange
	ld c, a
	ld a, DUELVARS_NUMBER_OF_CARDS_IN_HAND
	get_turn_duelist_var
	or a
	jr z, .done ; done if no cards in hand
	ld b, a ; number of cards in hand
	ld l, DUELVARS_HAND
	ld e, l
	ld d, h
.next_card
	ld a, [hli]
	cp c
	jr nz, .no_match
	push hl
	ld l, DUELVARS_NUMBER_OF_CARDS_IN_HAND
	dec [hl]
	ld l, c
	set 6, [hl] ; XXX
	pop hl
	jr .done_card
.no_match
	ld [de], a ; keep any card that doesn't match in the player's hand
	inc de
.done_card
	dec b
	jr nz, .next_card
.done
	pop de
	pop bc
	pop hl
	pop af
	ret

Func_0ffa::
	push bc
	push de
	ld c, a
	call GetCardIDFromDeckIndex
	cp16 RECYCLE_ENERGY
	ld a, c
	pop de
	pop bc
	jr nz, PutCardInDiscardPile
	push bc
	ld c, a
	ld a, [wSpecialRule]
	cp BLACK_HOLE
	ld a, c
	pop bc
	jr z, PutCardInDiscardPile
	jr AddCardToHand

; moves a card to the turn holder's discard pile, as long as it is in the hand
; the card is identified by register a, which contains the deck index (0-59) of the card
MoveHandCardToDiscardPile::
	call CheckDeckIndexRange
	get_turn_duelist_var
	ld a, [hl]
	and $ff ^ CARD_LOCATION_JUST_DRAWN
	cp CARD_LOCATION_HAND
	ret nz ; return if card not in hand
	ld a, l
	call RemoveCardFromHand
;	fallthrough

; puts the turn holder's card with the deck index (0-59) given in a into the discard pile
PutCardInDiscardPile::
	push af
	push hl
	push de
	call CheckDeckIndexRange
	get_turn_duelist_var
	ld [hl], CARD_LOCATION_DISCARD_PILE
	ld e, l
	ld l, DUELVARS_NUMBER_OF_CARDS_IN_DISCARD_PILE
	inc [hl]
	ld a, DUELVARS_DECK_CARDS - 1
	add [hl]
	ld l, a
	ld [hl], e ; save card to DUELVARS_DECK_CARDS + [DUELVARS_NUMBER_OF_CARDS_IN_DISCARD_PILE]
	pop de
	pop hl
	pop af
	ret

; search a card in the turn holder's discard pile, extract it, and set its location to
; CARD_LOCATION_JUST_DRAWN. AddCardToHand is meant to be called next.
; the card is identified by register a, which contains the deck index (0-59) of the card
MoveDiscardPileCardToHand::
	push hl
	push de
	push bc
	call CheckDeckIndexRange
	get_turn_duelist_var
	set CARD_LOCATION_JUST_DRAWN_F, [hl]
	ld b, l
	ld l, DUELVARS_NUMBER_OF_CARDS_IN_DISCARD_PILE
	ld a, [hl]
	or a
	jr z, .done ; done if no cards in discard pile
	ld c, a
	dec [hl] ; decrement number of cards in discard pile
	ld l, DUELVARS_DECK_CARDS
	ld e, l
	ld d, h ; de = hl = DUELVARS_DECK_CARDS
.next_card
	ld a, [hli]
	cp b
	jr z, .match
	ld [de], a
	inc de
.match
	dec c
	jr nz, .next_card
	ld a, b
.done
	pop bc
	pop de
	pop hl
	ret

; return in the z flag whether turn holder's prize a (0-7) has been drawn or not
; z: drawn, nz: not drawn
CheckPrizeTaken:
	ld e, a
	ld d, 0
	ld hl, PowersOf2
	add hl, de
	ld a, [hl]
	ld e, a
	cpl
	ld d, a
	ld a, DUELVARS_PRIZES
	get_turn_duelist_var
	and e
	ret

PowersOf2:
	db $01, $02, $04, $08, $10, $20, $40, $80

; fill wDuelTempList with the turn holder's remaining deck cards (their 0-59 deck indexes)
; return carry if the turn holder has no cards left in the deck
CreateDeckCardList::
	ld a, DUELVARS_NUMBER_OF_CARDS_NOT_IN_DECK
	get_turn_duelist_var
	cp DECK_SIZE
	jr nc, .no_cards_left_in_deck
	ld a, DECK_SIZE
	sub [hl]
	ld c, a
	ld b, a ; c = b = DECK_SIZE - [DUELVARS_NUMBER_OF_CARDS_NOT_IN_DECK]
	ld a, [hl]
	add DUELVARS_DECK_CARDS
	ld l, a ; l = DUELVARS_DECK_CARDS + [DUELVARS_NUMBER_OF_CARDS_NOT_IN_DECK]
	inc b
	ld de, wDuelTempList
	jr .begin_loop
.next_card
	ld a, [hli]
	ld [de], a
	inc de
.begin_loop
	dec b
	jr nz, .next_card
	ld a, $ff ; $ff-terminated
	ld [de], a
	ld a, c
	or a
	ret
.no_cards_left_in_deck
	ld a, $ff
	ld [wDuelTempList], a
	scf
	ret

; fill wDuelTempList with the turn holder's energy cards
; in the arena or in a bench slot (their 0-59 deck indexes).
; if a == 0: search in CARD_LOCATION_ARENA
; if a != 0: search in CARD_LOCATION_BENCH_[A]
; return carry if no energy cards were found
CreateArenaOrBenchEnergyCardList::
	or CARD_LOCATION_PLAY_AREA
	ld c, a
	ld b, $00
	ld de, wDuelTempList
	ld a, DUELVARS_CARD_LOCATIONS
	get_turn_duelist_var
.next_card_loop
	ld a, [hl]
	cp c
	jr nz, .skip_card ; jump if not in specified play area location
	ld a, l
	call LoadCardDataToBuffer2_FromDeckIndex
	ld a, [wLoadedCard2Type]
	and 1 << TYPE_ENERGY_F
	jr z, .skip_card ; jump if Pokemon or trainer card
	ld a, l
	ld [de], a ; add to wDuelTempList
	inc de
	inc b
.skip_card
	inc l
	ld a, l
	cp DECK_SIZE
	jr c, .next_card_loop
	; all cards checked
	ld a, $ff
	ld [de], a
	ld a, b
	or a
	ret nz
	scf
	ret

; fill wDuelTempList with the turn holder's hand cards (their 0-59 deck indexes)
; return carry if the turn holder has no cards in hand
; and outputs in a number of cards.
CreateHandCardList::
	call FindLastCardInHand
	inc b
	jr .skip_card

.check_next_card_loop
	ld a, [hld]
	push hl
	ld l, a
	bit CARD_LOCATION_JUST_DRAWN_F, [hl]
	pop hl
	jr nz, .skip_card
	ld [de], a
	inc de

.skip_card
	dec b
	jr nz, .check_next_card_loop
	ld a, $ff ; $ff-terminated
	ld [de], a
	ld l, DUELVARS_NUMBER_OF_CARDS_IN_HAND
	ld a, [hl]
	or a
	ret nz
	scf
	ret

; returns:
; b = turn holder's number of cards in hand (DUELVARS_NUMBER_OF_CARDS_IN_HAND)
; hl = pointer to turn holder's last (newest) card in DUELVARS_HAND
; de = wDuelTempList
FindLastCardInHand::
	ldh a, [hWhoseTurn]
	ld h, a
	ld l, DUELVARS_NUMBER_OF_CARDS_IN_HAND
	ld b, [hl]
	ld a, DUELVARS_HAND - 1
	add [hl]
	ld l, a
	ld de, wDuelTempList
	ret

; shuffles the deck by swapping the position of each card with the position of another random card
; input:
   ; a  = how many cards to shuffle
   ; hl = DUELVARS_DECK_CARDS + [DUELVARS_NUMBER_OF_CARDS_NOT_IN_DECK]
ShuffleCards::
	cp 1
	ret c ; return if less than 2 cards in deck
	push hl
	push de
	push bc
	ld c, a
	ld b, a
	ld e, l
	ld d, h
.shuffle_next_card_loop
	push bc
	push de
	ld a, c
	call Random
	add e
	ld e, a
	ld a, $0
	adc d
	ld d, a
	ld a, [de]
	ld b, [hl]
	ld [hl], a
	ld a, b
	ld [de], a
	pop de
	pop bc
	inc hl
	dec b
	jr nz, .shuffle_next_card_loop
	pop bc
	pop de
	pop hl
	ret

; returns, in register de, the id of the card with the deck index (0-59) specified by register a
; preserves af and hl
GetCardIDFromDeckIndex::
	push af
	push hl
	call _GetCardIDFromDeckIndex
	ld e, [hl]
	inc hl
	ld d, [hl]
	pop hl
	pop af
	ret

; checks whether deck index in a
; is within range of deck size
CheckDeckIndexRange:
	push hl
	ld hl, wDeckSize
	cp [hl]
	jr c, .within_range
	; outside range
	debug_nop
	xor a
.within_range
	pop hl
	ret

; remove card c from wDuelTempList (it contains a $ff-terminated list of deck indexes)
; returns carry if no matches were found.
RemoveCardFromDuelTempList::
	push hl
	push de
	push bc
	call CheckDeckIndexRange
	ld hl, wDuelTempList
	ld e, l
	ld d, h
	ld c, a
	ld b, $00
.next
	ld a, [hli]
	cp $ff
	jr z, .end_of_list
	cp c
	jr z, .match
	ld [de], a
	inc de
	inc b
.match
	jr .next
.end_of_list
	ld [de], a
	ld a, b
	or a
	jr nz, .done
	scf
.done
	pop bc
	pop de
	pop hl
	ret

; return the number of cards in wDuelTempList in a
CountCardsInDuelTempList::
	push hl
	push bc
	ld hl, wDuelTempList
	ld b, -1
.loop
	inc b
	ld a, [hli]
	cp $ff
	jr nz, .loop
	ld a, b
	pop bc
	pop hl
	ret

; returns, in register hl, a pointer to the id of the card with the deck index (0-59) specified in register a
_GetCardIDFromDeckIndex::
	push de
	call CheckDeckIndexRange
	add a
	ld e, a
	ld d, $0
	ld hl, wPlayerDeck
	ldh a, [hWhoseTurn]
	cp PLAYER_TURN
	jr z, .load_card_from_deck
	ld hl, wOpponentDeck
.load_card_from_deck
	add hl, de
	pop de
	ret

; load data of card with deck index a (0-59) to wLoadedCard1
LoadCardDataToBuffer1_FromDeckIndex::
	push hl
	push de
	push bc
	push af
	call GetCardIDFromDeckIndex
	call LoadCardDataToBuffer1_FromCardID
	pop af
	ld hl, wLoadedCard1
	farcall ConvertSpecialTrainerCardToPokemon
	pop bc
	pop de
	pop hl
	ret

; load data of card with deck index a (0-59) to wLoadedCard2
LoadCardDataToBuffer2_FromDeckIndex::
	push hl
	push de
	push bc
	push af
	call GetCardIDFromDeckIndex
	call LoadCardDataToBuffer2_FromCardID
	pop af
	ld hl, wLoadedCard2
	farcall ConvertSpecialTrainerCardToPokemon
	pop bc
	pop de
	pop hl
	ret

; evolve a turn holder's Pokemon card in the play area slot determined by hTempPlayAreaLocation_ff9d
; into another turn holder's Pokemon card identifier by its deck index (0-59) in hTempCardIndex_ff98.
; return nc if evolution was successful.
EvolvePokemonCardIfPossible::
	; first make sure the attempted evolution is viable
	ldh a, [hTempCardIndex_ff98]
	ld d, a
	ldh a, [hTempPlayAreaLocation_ff9d]
	ld e, a
	call CheckIfCanEvolveInto
	ret c ; return if it's not capable of evolving into the selected Pokemon
;	fallthrough

; evolve a turn holder's Pokemon card in the play area slot determined by hTempPlayAreaLocation_ff9d
; into another turn holder's Pokemon card identifier by its deck index (0-59) in hTempCardIndex_ff98.
EvolvePokemonCard:
; place the evolved Pokemon card in the play area location of the pre-evolved Pokemon card
	ldh a, [hTempPlayAreaLocation_ff9d]
	ld e, a
	add DUELVARS_ARENA_CARD
	get_turn_duelist_var
	ld [wPreEvolutionPokemonCard], a ; save pre-evolved Pokemon card into wPreEvolutionPokemonCard
	call LoadCardDataToBuffer2_FromDeckIndex
	ldh a, [hTempCardIndex_ff98]
	ld [hl], a
	call LoadCardDataToBuffer1_FromDeckIndex
	ldh a, [hTempCardIndex_ff98]
	call PutHandCardInPlayArea
	; update the Pokemon's HP with the difference
	ldh a, [hTempPlayAreaLocation_ff9d] ; derp
	ld a, e
	add DUELVARS_ARENA_CARD_HP
	get_turn_duelist_var
	ld a, [wLoadedCard2HP]
	ld c, a
	ld a, [wLoadedCard1HP]
	sub c
	add [hl]
	ld [hl], a
	; reset status (if in arena) and set the flag that prevents it from evolving again this turn
	ld a, e
	add DUELVARS_ARENA_CARD_FLAGS
	ld l, a
	ld [hl], $00
	ld a, e
	add DUELVARS_ARENA_CARD_CHANGED_TYPE
	ld l, a
	ld [hl], $00
	ld a, e
	or a
	call z, ClearAllStatusConditions
	; set the new evolution stage of the card
	ldh a, [hTempPlayAreaLocation_ff9d]
	add DUELVARS_ARENA_CARD_STAGE
	get_turn_duelist_var
	ld a, [wLoadedCard1Stage]
	ld [hl], a
	or a
	ret

; never executed
	scf
	ret

; check if the turn holder's Pokemon card at e can evolve into the turn holder's Pokemon card d.
; e is the play area location offset (PLAY_AREA_*) of the Pokemon trying to evolve.
; d is the deck index (0-59) of the Pokemon card that was selected to be the evolution target.
; return carry if can't evolve, plus nz if the reason for it is the card was played this turn.
CheckIfCanEvolveInto::
	push de
	ld a, e
	add DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call LoadCardDataToBuffer2_FromDeckIndex
	ld a, d
	call LoadCardDataToBuffer1_FromDeckIndex
	ld a, [wLoadedCard1Type]
	cp TYPE_ENERGY
	jr nc, .cant_evolve
	ld hl, wLoadedCard2Name
	ld de, wLoadedCard1PreEvoName
	ld a, [de]
	cp [hl]
	jr nz, .cant_evolve ; jump if they are incompatible to evolve
	inc de
	inc hl
	ld a, [de]
	cp [hl]
	jr nz, .cant_evolve ; jump if they are incompatible to evolve
	pop de
	ld a, e
	add DUELVARS_ARENA_CARD_FLAGS
	get_turn_duelist_var
	and CAN_EVOLVE_THIS_TURN
	jr nz, .can_evolve
	; if the card trying to evolve was played this turn, it can't evolve
	ld a, $01
	or a
	scf
	ret
.can_evolve
	or a
	ret
.cant_evolve
	pop de
	xor a
	scf
	ret

; check if the turn holder's Pokemon card at e can evolve this turn, and is a basic
; Pokemon card that whose second stage evolution is the turn holder's Pokemon card d.
; e is the play area location offset (PLAY_AREA_*) of the Pokemon trying to evolve.
; d is the deck index (0-59) of the Pokemon card that was selected to be the evolution target.
; return carry if not basic to stage 2 evolution, or if evolution not possible this turn.
CheckIfCanEvolveInto_BasicToStage2:
	ld a, e
	add DUELVARS_ARENA_CARD_FLAGS
	get_turn_duelist_var
	and CAN_EVOLVE_THIS_TURN
	jr nz, .can_evolve
	jr .cant_evolve
.can_evolve
	ld a, e
	add DUELVARS_ARENA_CARD
	ld l, a
	ld a, [hl]
	call LoadCardDataToBuffer2_FromDeckIndex
	ld a, d
	call LoadCardDataToBuffer1_FromDeckIndex
	ld a, [wLoadedCard1]
	cp $08
	jr nc, .cant_evolve
	ld a, [wLoadedCard1Stage]
	cp $02
	jr nz, .cant_evolve
	ld hl, wLoadedCard1PreEvoName
	ld e, [hl]
	inc hl
	ld d, [hl]
	call LoadCardDataToBuffer1_FromName
	ld hl, wLoadedCard2Name
	ld de, wLoadedCard1PreEvoName
	ld a, [de]
	cp [hl]
	jr nz, .cant_evolve
	inc de
	inc hl
	ld a, [de]
	cp [hl]
	jr nz, .cant_evolve
	or a
	ret
.cant_evolve
	xor a
	scf
	ret

; clear the status, all substatuses, and temporary duelvars of the turn holder's
; arena Pokemon. called when sending a new Pokemon into the arena.
; does not reset Headache, since it targets a player rather than a Pokemon.
ClearAllStatusConditions::
	push hl
	ldh a, [hWhoseTurn]
	ld h, a
	xor a
	ld l, DUELVARS_ARENA_CARD_STATUS
	ld [hl], a ; NO_STATUS
	ld l, DUELVARS_ARENA_CARD_SUBSTATUS1
	ld [hl], a
	ld l, DUELVARS_ARENA_CARD_SUBSTATUS2
	ld [hl], a
	ld l, DUELVARS_ARENA_CARD_CHANGED_WEAKNESS
	ld [hl], a
	ld l, DUELVARS_ARENA_CARD_CHANGED_RESISTANCE
	ld [hl], a
	ld l, DUELVARS_ARENA_CARD_SUBSTATUS3
	res 4, [hl]
	res 5, [hl]
	ld l, DUELVARS_ARENA_CARD_DISABLED_ATTACK_INDEX
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld [hl], a
	pop hl
	ret

; Removes a Pokemon card from the hand and places it in the arena or first available bench slot.
; If the Pokemon is placed in the arena, the status conditions of the player's arena card are zeroed.
; input:
   ; a = deck index of the card
; return carry if there is no room for more Pokemon
PutHandPokemonCardInPlayArea::
	push af
	call CheckDeckIndexRange
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	push hl
	ld hl, wMaxNumPlayAreaPokemon ; max play area pokemon ?
	cp [hl]
	pop hl
	jr nc, .already_max_pkmn_in_play
	inc [hl]
	ld e, a ; play area offset to place card
	pop af
	push af
	call PutHandCardInPlayArea
	ld a, e
	add DUELVARS_ARENA_CARD
	ld l, a
	pop af
	ld [hl], a ; set card in arena or benchx
	call LoadCardDataToBuffer2_FromDeckIndex
	ld a, DUELVARS_ARENA_CARD_HP
	add e
	ld l, a
	ld a, [wLoadedCard2HP]
	ld [hl], a ; set card's HP
	ld a, DUELVARS_ARENA_CARD_FLAGS
	add e
	ld l, a
	ld [hl], $0
	ld a, DUELVARS_ARENA_CARD_CHANGED_TYPE
	add e
	ld l, a
	ld [hl], $0
	ld a, DUELVARS_ARENA_CARD_ATTACHED_PLUSPOWER
	add e
	ld l, a
	ld [hl], $0
	ld a, DUELVARS_ARENA_CARD_ATTACHED_DEFENDER
	add e
	ld l, a
	ld [hl], $0
	ld a, $e6
	add e
	ld l, a
	ld [hl], $0
	ld a, DUELVARS_ARENA_CARD_STAGE
	add e
	ld l, a
	ld a, [wLoadedCard2Stage]
	ld [hl], a ; set card's evolution stage
	ld a, e
	or a
	call z, ClearAllStatusConditions ; only call if Pokemon is being placed in the arena
	ld a, e
	or a
	ret

.already_max_pkmn_in_play
	pop af
	scf
	ret

; Removes a card from the hand and changes its location to arena or bench. Given that
; DUELVARS_ARENA_CARD or DUELVARS_BENCH aren't affected, this function is meant for energy and trainer cards.
; input:
   ; a = deck index of the card
   ; e = play area location offset (PLAY_AREA_*)
; returns:
   ; a = CARD_LOCATION_PLAY_AREA + e
PutHandCardInPlayArea::
	call RemoveCardFromHand
	get_turn_duelist_var
	ld a, e
	or CARD_LOCATION_PLAY_AREA
	ld [hl], a
	ret

Func_12fc::
	ld a, [wSpecialRule]
	cp ENERGY_RETURN
	jr nz, MovePlayAreaCardToDiscardPile
	call EmptyPlayAreaSlot
	ld l, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	dec [hl]
	ld l, DUELVARS_CARD_LOCATIONS
.asm_130b
	ld a, e
	or CARD_LOCATION_ARENA
	cp [hl]
	jr nz, .asm_132c
	push de
	ld a, l
	call GetCardIDFromDeckIndex
	call GetCardType
	cp TYPE_ENERGY
	jr c, .asm_1321
	cp TYPE_TRAINER - 1
	jr c, .asm_1327
.asm_1321
	ld a, l
	call Func_0ffa
	jr .asm_132b
.asm_1327
	ld a, l
	call AddCardToHand
.asm_132b
	pop de
.asm_132c
	inc l
	ld a, l
	cp DECK_SIZE
	jr c, .asm_130b
	ret

; move the Pokemon card of the turn holder in the
; PLAY_AREA_* location given in e to the discard pile
MovePlayAreaCardToDiscardPile::
	call EmptyPlayAreaSlot
	ld l, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	dec [hl]
	ld l, DUELVARS_CARD_LOCATIONS
.next_card
	ld a, e
	or CARD_LOCATION_PLAY_AREA
	cp [hl]
	jr nz, .not_in_location
	push de
	ld a, l
	call Func_0ffa
	pop de
.not_in_location
	inc l
	ld a, l
	cp DECK_SIZE
	jr c, .next_card
	ret

; init a turn holder's play area slot to empty
; which slot (arena or benchx) is determined by the play area location offset (PLAY_AREA_*) in e
EmptyPlayAreaSlot:
	ldh a, [hWhoseTurn]
	ld h, a
	ld d, -1
	ld a, DUELVARS_ARENA_CARD
	call .init_duelvar
	ld d, 0
	ld a, DUELVARS_ARENA_CARD_HP
	call .init_duelvar
	ld a, DUELVARS_ARENA_CARD_STAGE
	call .init_duelvar
	ld a, DUELVARS_ARENA_CARD_CHANGED_TYPE
	call .init_duelvar
	ld a, DUELVARS_ARENA_CARD_ATTACHED_DEFENDER
	call .init_duelvar
	ld a, DUELVARS_ARENA_CARD_ATTACHED_PLUSPOWER
	call .init_duelvar
	ld a, $e6
.init_duelvar
	add e
	ld l, a
	ld [hl], d
	ret

; shift play area Pokemon of both players to the first available play area (arena + benchx) slots
ShiftAllPokemonToFirstPlayAreaSlots::
	call ShiftTurnPokemonToFirstPlayAreaSlots
	call SwapTurn
	call ShiftTurnPokemonToFirstPlayAreaSlots
	call SwapTurn
	ret

; shift play area Pokemon of the turn holder to the first available play area (arena + benchx) slots
ShiftTurnPokemonToFirstPlayAreaSlots:
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	lb de, PLAY_AREA_ARENA, PLAY_AREA_ARENA
.next_play_area_slot
	bit 7, [hl]
	jr nz, .empty_slot
	call SwapPlayAreaPokemon
	inc e
.empty_slot
	inc hl
	inc d
	ld a, d
	cp MAX_PLAY_AREA_POKEMON
	jr nz, .next_play_area_slot
	ret

; swap the data of the turn holder's arena Pokemon card with the
; data of the turn holder's Pokemon card in play area e.
; reset the status and all substatuses of the arena Pokemon before swapping.
; e is the play area location offset of the bench Pokemon (PLAY_AREA_*).
SwapArenaWithBenchPokemon::
	push de
	call ClearAllStatusConditions
	ld d, PLAY_AREA_ARENA
	call SwapPlayAreaPokemon
	pop de
	ret

; swap the data of the turn holder's Pokemon card in play area d with the
; data of the turn holder's Pokemon card in play area e.
; d and e are play area location offsets (PLAY_AREA_*).
SwapPlayAreaPokemon::
	push bc
	push de
	push hl
	ld a, e
	cp d
	jr z, .done
	ldh a, [hWhoseTurn]
	ld h, a
	ld b, a
	ld a, DUELVARS_ARENA_CARD
	call .swap_duelvar
	ld a, DUELVARS_ARENA_CARD_HP
	call .swap_duelvar
	ld a, DUELVARS_ARENA_CARD_FLAGS
	call .swap_duelvar
	ld a, DUELVARS_ARENA_CARD_STAGE
	call .swap_duelvar
	ld a, DUELVARS_ARENA_CARD_CHANGED_TYPE
	call .swap_duelvar
	ld a, DUELVARS_ARENA_CARD_ATTACHED_PLUSPOWER
	call .swap_duelvar
	ld a, DUELVARS_ARENA_CARD_ATTACHED_DEFENDER
	call .swap_duelvar
	ld a, $e6
	call .swap_duelvar
	set CARD_LOCATION_PLAY_AREA_F, d
	set CARD_LOCATION_PLAY_AREA_F, e
	ld l, DUELVARS_CARD_LOCATIONS
.update_card_locations_loop
	; update card locations of the two swapped cards
	ld a, [hl]
	cp e
	jr nz, .next1
	ld a, d
	jr .update_location
.next1
	cp d
	jr nz, .next2
	ld a, e
.update_location
	ld [hl], a
.next2
	inc l
	ld a, l
	cp DECK_SIZE
	jr c, .update_card_locations_loop
.done
	pop hl
	pop de
	pop bc
	ret

.swap_duelvar
	ld c, a
	add e ; play area location offset of card 1
	ld l, a
	ld a, c
	add d ; play area location offset of card 2
	ld c, a
	ld a, [bc]
	push af
	ld a, [hl]
	ld [bc], a
	pop af
	ld [hl], a
	ret

; Find which and how many energy cards are attached to the turn holder's Pokemon card in the arena,
; or a Pokemon card in the bench, depending on the value of register e.
; input: e = location to check, i.e. PLAY_AREA_*
; Feedback is returned in wAttachedEnergies and wTotalAttachedEnergies.
GetPlayAreaCardAttachedEnergies::
	push hl
	push de
	push bc
	xor a
	ld c, NUM_TYPES
	ld hl, wAttachedEnergies
.zero_energies_loop
	ld [hli], a
	dec c
	jr nz, .zero_energies_loop
	ld a, CARD_LOCATION_PLAY_AREA
	or e ; if e is non-0, a bench location is checked instead
	ld e, a
	ldh a, [hWhoseTurn]
	ld h, a
	ld l, DUELVARS_CARD_LOCATIONS
	ld c, DECK_SIZE
.next_card
	ld a, [hl]
	cp e
	jr nz, .not_in_requested_location

	push hl
	push de
	push bc
	ld a, l
	call LoadCardDataToBuffer2_FromDeckIndex
	ld a, [wLoadedCard2Type]
	bit TYPE_ENERGY_F, a
	jr z, .not_an_energy_card
	and TYPE_PKMN ; zero bit 3 to extract the type
	ld e, a
	ld d, $0
	ld hl, wAttachedEnergies
	add hl, de
	inc [hl] ; increment the number of energy cards of this type
	cp COLORLESS
	jr c, .not_colorless
	jr z, .colorless
	ld a, [wLoadedCard2ID]
	cp LOW(RAINBOW_ENERGY)
	jr nz, .not_rainbow
	ld a, [wLoadedCard2ID + 1]
	cp HIGH(RAINBOW_ENERGY)
	jr z, .not_an_energy_card
.not_rainbow
	dec [hl]
	dec hl
.colorless
	inc [hl] ; each colorless energy counts as two
.not_an_energy_card
.not_colorless
	pop bc
	pop de
	pop hl

.not_in_requested_location
	inc l
	dec c
	jr nz, .next_card
	; all 60 cards checked
	ld hl, wAttachedEnergies
	ld c, NUM_TYPES
	xor a
.sum_attached_energies_loop
	add [hl]
	inc hl
	dec c
	jr nz, .sum_attached_energies_loop
	ld [hl], a ; save to wTotalAttachedEnergies
	pop bc
	pop de
	pop hl
	ret

; returns in a how many times card de can be found in location b
; de = card id to search
; b = location to consider (CARD_LOCATION_*)
; h = PLAYER_TURN or OPPONENT_TURN
CountCardIDInLocation:
	push bc
	ld l, DUELVARS_CARD_LOCATIONS
	ld c, $0
.next_card
	ld a, [hl]
	cp b
	jr nz, .unmatching_card_location_or_ID
	ld a, l
	push hl
	call _GetCardIDFromDeckIndex
	ld a, [hli]
	cp e
	jr nz, .skip
	ld a, [hl]
	cp d
.skip
	pop hl
	jr nz, .unmatching_card_location_or_ID
	inc c
.unmatching_card_location_or_ID
	inc l
	ld a, l
	cp DECK_SIZE
	jr c, .next_card
	ld a, c
	pop bc
	ret

; returns [[hWhoseTurn] << 8 + a] in a and in [hl]
; i.e. duelvar a of the player whose turn it is
GetTurnDuelistVariable:
	ld l, a
	ldh a, [hWhoseTurn]
	ld h, a
	ld a, [hl]
	ret

; returns [([hWhoseTurn] ^ $1) << 8 + a] in a and in [hl]
; i.e. duelvar a of the player whose turn it is not
GetNonTurnDuelistVariable::
	ld l, a
	ldh a, [hWhoseTurn]
	ld h, OPPONENT_TURN
	cp PLAYER_TURN
	jr z, .ok
	ld h, PLAYER_TURN
.ok
	ld a, [hl]
	ret

; copies, given a card identified by register hl (card ID):
; - e into wSelectedAttack and d into hTempCardIndex_ff9f
; - Attack1 (if e == 0) or Attack2 (if e == 1) data into wLoadedAttack
; - Also from that attack, its Damage field into wDamage
; finally, clears wNoDamageOrEffect and wDealtDamage
CopyAttackDataAndDamage_FromCardID::
	push de
	push hl
	ld a, e
	ld [wSelectedAttack], a
	ld a, d
	ldh [hTempCardIndex_ff9f], a
	pop de
	call LoadCardDataToBuffer1_FromCardID
	pop de
	jr CopyAttackDataAndDamage

; copies, given a card identified by register d (0-59 deck index):
; - e into wSelectedAttack and d into hTempCardIndex_ff9f
; - Attack1 (if e == 0) or Attack2 (if e == 1) data into wLoadedAttack
; - Also from that attack, its Damage field into wDamage
; finally, clears wNoDamageOrEffect and wDealtDamage
CopyAttackDataAndDamage_FromDeckIndex::
	ld a, e
	ld [wSelectedAttack], a
	ld a, d
	ldh [hTempCardIndex_ff9f], a
	call LoadCardDataToBuffer1_FromDeckIndex
;	fallthrough

CopyAttackDataAndDamage:
	ld a, [wLoadedCard1ID]
	ld [wTempCardID_ccc2], a
	ld a, [wLoadedCard1ID + 1]
	ld [wTempCardID_ccc2 + 1], a
	ld hl, wLoadedCard1Atk1
	dec e
	jr nz, .got_atk
	ld hl, wLoadedCard1Atk2
.got_atk
	ld de, wLoadedAttack
	ld c, CARD_DATA_ATTACK2 - CARD_DATA_ATTACK1
.copy_loop
	ld a, [hli]
	ld [de], a
	inc de
	dec c
	jr nz, .copy_loop
	ld a, [wLoadedAttackDamage]
	ld hl, wDamage
	ld [hli], a
	xor a
	ld [hl], a
	ld [wNoDamageOrEffect], a
	ld hl, wDealtDamage
	ld [hli], a
	ld [hl], a
	ret

Func_14e5::
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	ldh [hTempCardIndex_ff9f], a
	call Func_14f1
	call ClearTwoTurnDuelVars
	ret

Func_14f1:
	xor a
	bank1call LoadPlayAreaCardID_ToTempTurnDuelistCardID
	call SwapTurn
	xor a
	bank1call LoadPlayAreaCardID_ToTempNonTurnDuelistCardID
	call SwapTurn
	ret

; zeroes temp variables that only last between each two-player turn.
; this is called when a Pokemon card is played or when an attack is used
ClearTwoTurnDuelVars::
	xor a
	ld [wccec], a
	ld [wEffectFunctionsFeedbackIndex], a
	ld [wEffectFailed], a
	ld [wIsDamageToSelf], a
	ld [wccef], a
	ld [wMetronomeEnergyCost], a
	ld [wNoEffectFromWhichStatus], a
	ld [wcd0a], a
	ld [wcd0c], a
	ld [wcd0d], a
	ld [wcd16], a
	ld hl, wDarkWaveAndDarknessVeilDamageModifiers
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld [hl], a
	bank1call ClearNonTurnTemporaryDuelvars_CopyStatus
	ld a, DUELVARS_ARENA_CARD_SUBSTATUS1
	call GetNonTurnDuelistVariable
	ld [wcd0b], a
	ret

; Use an attack (from DuelMenu_Attack) or a Pokemon Power (from DuelMenu_PkmnPower)
UseAttackOrPokemonPower::
	ld a, [wSelectedAttack]
	ld [wPlayerAttackingAttackIndex], a
	ldh a, [hTempCardIndex_ff9f]
	ld [wPlayerAttackingCardIndex], a
	ld a, [wTempCardID_ccc2]
	ld [wPlayerAttackingCardID], a
	ld a, [wTempCardID_ccc2 + 1]
	ld [wPlayerAttackingCardID + 1], a
	ld a, [wLoadedAttackCategory]
	cp POKEMON_POWER
	jp z, UsePokemonPower
	xor a ; PLAY_AREA_ARENA
	ldh [hTempPlayAreaLocation_ff9d], a
	call Func_14e5
	ld a, EFFECTCMDTYPE_INITIAL_EFFECT_1
	call TryExecuteEffectCommandFunction
	jp c, DrawWideTextBox_WaitForInput_ReturnCarry
	farcall $9, $4375 ; Func_24375
	call WaitForWideTextBoxInput
	call SendAttackDataToLinkOpponent
	bank1call $784a ; HandleSandAttackOrSmokescreenSubstatus ?
	jp c, ClearNonTurnTemporaryDuelvars_ResetCarry
	ld a, OPPACTION_USE_ATTACK
	call SetOppAction_SerialSendDuelData
	call CheckSelfConfusionDamage
	jp c, HandleConfusionDamageToSelf
	call ExchangeRNG
.asm_1580
	ld a, EFFECTCMDTYPE_INITIAL_EFFECT_2
	call TryExecuteEffectCommandFunction
	jr nc, .asm_159b
	ld a, [wcd16]
	or a
	jr z, .asm_1580
	ld a, $ff
	ldh [hTempCardIndex_ff9f], a
	ld a, OPPACTION_ATTACK_ANIM_AND_DAMAGE
	call SetOppAction_SerialSendDuelData
	call Func_1a1e
	or a
	ret
.asm_159b
	ld a, EFFECTCMDTYPE_DISCARD_ENERGY
	call TryExecuteEffectCommandFunction
	ld a, EFFECTCMDTYPE_REQUIRE_SELECTION
	call TryExecuteEffectCommandFunction
	ld a, OPPACTION_ATTACK_ANIM_AND_DAMAGE
	call SetOppAction_SerialSendDuelData
;	fallthrough

PlayAttackAnimation_DealAttackDamage:
	call Func_14f1
	bank1call SetDarkWaveAndDarknessVeilDamageModifiers
	farcall ResetAttackAnimationIsPlaying
	ld a, [wLoadedAttackCategory]
	and RESIDUAL
	jr nz, .deal_damage
	call SwapTurn
	bank1call HandleNoDamageOrEffectSubstatus
	call SwapTurn
.deal_damage
	xor a ; PLAY_AREA_ARENA
	ldh [hTempPlayAreaLocation_ff9d], a
	ld a, EFFECTCMDTYPE_BEFORE_DAMAGE
	call TryExecuteEffectCommandFunction
	call ApplyDamageModifiers_DamageToTarget
	call Func_189d
	ld a, e
	or d
	jr z, .asm_15dc
	ld hl, wDealtDamage
	ld [hl], e
	inc hl
	ld [hl], d
.asm_15dc
	ld b, $0
	ld a, [wDamageEffectiveness]
	ld c, a
	ld a, DUELVARS_ARENA_CARD_HP
	call GetNonTurnDuelistVariable
	push de
	push hl
	farcall PlayAttackAnimation
	farcall $6, $4a19 ; PlayStatusConditionQueueAnimations
	farcall WaitAttackAnimation
	pop hl
	pop de
	call SubtractHP
	push hl
	bank1call DrawDuelHUDs
	pop hl
	call PrintKnockedOutIfHLZero
	jr Func_17fb

Func_17ed:
	call DrawWideTextBox_WaitForInput
	xor a
	ld hl, wDamage
	ld [hli], a
	ld [hl], a
;	fallthrough

Func_17fb:
	ld a, [wNoDamageOrEffect]
	push af
	ld hl, wTempNonTurnDuelistCardID
	ld e, [hl]
	inc hl
	ld d, [hl]
	push hl
	push de
	ld a, EFFECTCMDTYPE_AFTER_DAMAGE
	call TryExecuteEffectCommandFunction
	pop de
	pop hl
	ld [hl], d
	dec hl
	ld [hl], e
	pop af
	ld [wNoDamageOrEffect], a
	bank1call $7352 ; Func_7352
	bank1call $64a5 ; Func_64a5
	call Func_1bb4
	bank1call $6b1f ; Func_6b1f
	bank1call Func_6518
	or a
	ret

DrawWideTextBox_WaitForInput_ReturnCarry:
	call DrawWideTextBox_WaitForInput
;	fallthrough

ReturnCarry:
	scf
	ret

ClearNonTurnTemporaryDuelvars_ResetCarry:
	bank1call ClearNonTurnTemporaryDuelvars
	or a
	ret

; called when attacker deals damage to itself due to confusion
; display the corresponding animation and deal 20 damage to self
HandleConfusionDamageToSelf:
	bank1call $7742 ; Func_7742
	jr c, .asm_164a
	ld de, 20 ; damage
.asm_164a
	push de
	bank1call DrawDuelMainScene
	pop hl
	push hl
	call LoadTxRam3
	ldtx hl, DamageToSelfDueToConfusionText
	call DrawWideTextBox_PrintText
	ld a, ATK_ANIM_CONFUSION_HIT
	ld [wLoadedAttackAnimation], a
	pop hl
	ld a, l
	call DealConfusionDamageToSelf
	call Func_1bb4
	bank1call Func_6518
	bank1call ClearNonTurnTemporaryDuelvars
	or a
	ret

; use Pokemon Power
UsePokemonPower:
	call ClearTwoTurnDuelVars
	farcall ResetAttackAnimationIsPlaying
	ld a, EFFECTCMDTYPE_INITIAL_EFFECT_2
	call TryExecuteEffectCommandFunction
	jr c, DrawWideTextBox_WaitForInput_ReturnCarry
	ld a, [wcd0d]
	or a
	jr z, .asm_1687
	ld a, OPPACTION_UNK_0C
	call SetOppAction_SerialSendDuelData
.asm_1687
	ld a, EFFECTCMDTYPE_REQUIRE_SELECTION
	call TryExecuteEffectCommandFunction
	jr c, ReturnCarry
	ld a, OPPACTION_USE_PKMN_POWER
	call SetOppAction_SerialSendDuelData
	call ExchangeRNG
	ld a, OPPACTION_EXECUTE_PKMN_POWER_EFFECT
	call SetOppAction_SerialSendDuelData
	ld a, EFFECTCMDTYPE_BEFORE_DAMAGE
	call TryExecuteEffectCommandFunction
	ld a, OPPACTION_DUEL_MAIN_SCENE
	call SetOppAction_SerialSendDuelData
	ret

; called by UseAttackOrPokemonPower (on an attack only)
; in a link duel, it's used to send the other game data about the
; attack being in use, triggering a call to OppAction_BeginUseAttack in the receiver
SendAttackDataToLinkOpponent:
	ld a, [wccec]
	or a
	ret nz
	ldh a, [hTemp_ffa0]
	push af
	ldh a, [hTempCardIndex_ff9f]
	push af
	ld a, $1
	ld [wccec], a
	ld a, [wPlayerAttackingCardIndex]
	ldh [hTempCardIndex_ff9f], a
	ld a, [wPlayerAttackingAttackIndex]
	ldh [hTemp_ffa0], a
	ld a, OPPACTION_BEGIN_ATTACK
	call SetOppAction_SerialSendDuelData
	call ExchangeRNG
	pop af
	ldh [hTempCardIndex_ff9f], a
	pop af
	ldh [hTemp_ffa0], a
	ret

Func_189d:
	ld a, [wLoadedAttackCategory]
	bit RESIDUAL_F, a
	ret nz
	ld a, [wNoDamageOrEffect]
	or a
	ret nz
	ld a, e
	or d
	jr nz, .asm_1700
	ld a, DUELVARS_ARENA_CARD_SUBSTATUS2
	call GetNonTurnDuelistVariable
	or a
	jr nz, .asm_1700
	ld a, [wEffectFunctionsFeedbackIndex]
	or a
	ret z
	ld b, a
	xor a
	call GetNonTurnDuelistVariable
	ld c, h
	ld hl, wEffectFunctionsFeedback
.asm_16f4
	ld a, [hli]
	inc hl
	inc hl
	cp c
	jr z, .asm_1700
	dec b
	dec b
	dec b
	jr nz, .asm_16f4
	ret
.asm_1700
	push de
	call SwapTurn
	xor a
	ld [wTempPlayAreaLocation_cceb], a
	bank1call $7038 ; HandleTransparency
	call SwapTurn
	pop de
	ret nc
	push hl
	bank1call DrawDuelMainScene
	pop hl
	call DrawWideTextBox_PrintText
	ld a, DUELVARS_ARENA_CARD_SUBSTATUS2
	call GetNonTurnDuelistVariable
	ld [hl], $0
	ld de, 0
	ret

; return carry and 1 into wGotHeadsFromConfusionCheck if damage will be dealt to oneself due to confusion
CheckSelfConfusionDamage:
	xor a
	ld [wGotHeadsFromConfusionCheck], a
	ld a, DUELVARS_ARENA_CARD_STATUS
	get_turn_duelist_var
	and CNF_SLP_PRZ
	cp CONFUSED
	jr z, .confused
	or a
	ret
.confused
	ld de, $117 ; ConfusionCheckDamageText
	call TossCoin
	jr c, .no_confusion_damage
	ld a, 1
	ld [wGotHeadsFromConfusionCheck], a
	scf
	ret
.no_confusion_damage
	or a
	ret

; Make turn holder deal A damage to self due to recoil (e.g. Thrash, Selfdestruct)
; display recoil animation
DealRecoilDamageToSelf:
	push af
	ld a, ATK_ANIM_RECOIL_HIT
	ld [wLoadedAttackAnimation], a
	pop af
;	fallthrough

; Make turn holder deal A damage to self due to confusion
; display animation at wLoadedAttackAnimation
DealConfusionDamageToSelf:
	ld hl, wDamage
	ld [hli], a
	ld [hl], 0
	ld a, [wNoDamageOrEffect]
	push af
	xor a
	ld [wNoDamageOrEffect], a
	ld a, $01
	ld [wIsDamageToSelf], a
	farcall ResetAttackAnimationIsPlaying
	ld hl, wTempNonTurnDuelistCardID
	ld e, [hl]
	inc hl
	ld d, [hl]
	push hl
	push de
	ld a, [wTempTurnDuelistCardID]
	ld [wTempNonTurnDuelistCardID], a
	ld a, [wTempTurnDuelistCardID + 1]
	ld [wTempNonTurnDuelistCardID + 1], a
	call ApplyDamageModifiers_DamageToSelf
	ld a, [wDamageEffectiveness]
	ld c, a
	ld b, $0
	ld a, DUELVARS_ARENA_CARD_HP
	get_turn_duelist_var
	farcall $6, $4a9c ; PlayAttackAnimation_DealAttackDamageSimple
	call PrintKnockedOutIfHLZero
	pop de
	pop hl
	ld [hl], d
	dec hl
	ld [hl], e
	pop af
	ld [wNoDamageOrEffect], a
	xor a
	ld [wIsDamageToSelf], a
	ret

; given a damage value at wDamage:
; - if the non-turn holder's arena card is weak to the turn holder's arena card color: double damage
; - if the non-turn holder's arena card resists the turn holder's arena card color: reduce damage by 30
; - also apply Pluspower, Defender, and other kinds of damage reduction accordingly
; return resulting damage in de
ApplyDamageModifiers_DamageToTarget:
	xor a
	ld [wDamageEffectiveness], a
	ld hl, wDamage
	ld a, [hli]
	or [hl]
	jr nz, .non_zero_damage
	ld de, 0
	ret
.non_zero_damage
	xor a ; PLAY_AREA_ARENA
	ldh [hTempPlayAreaLocation_ff9d], a
	ld d, [hl]
	dec hl
	ld e, [hl]
	bit 7, d
	jr z, .safe
	res 7, d ; cap at 2^15
	xor a
	ld [wDamageEffectiveness], a
	bank1call HandleDamageModifiersEffects
	jr .check_pluspower_and_defender
.safe
	bank1call HandleDamageModifiersEffects
	ld a, e
	or d
	ret z
	ldh a, [hTempPlayAreaLocation_ff9d]
	bank1call GetPlayAreaCardColor
	call TranslateColorToWR
	ld b, a
	bank1call CheckWhetherToApplyWeakness
	jr c, .not_weak
	call SwapTurn
	bank1call GetArenaCardWeakness
	call SwapTurn
	and b
	jr z, .not_weak
	sla e
	rl d
	ld hl, wDamageEffectiveness
	set WEAKNESS, [hl]
.not_weak
	bank1call CheckWhetherToApplyResistance
	jr c, .check_pluspower_and_defender
	call SwapTurn
	bank1call GetArenaCardResistance
	call SwapTurn
	and b
	jr z, .check_pluspower_and_defender ; jump if not resistant
	ld hl, -30
	ld a, [wSpecialRule]
	cp LOW_RESISTANCE
	jr nz, .asm_1801
	ld hl, -10
.asm_1801
	add hl, de
	ld e, l
	ld d, h
	ld hl, wDamageEffectiveness
	set RESISTANCE, [hl]
.check_pluspower_and_defender
	ld b, CARD_LOCATION_ARENA
	call ApplyAttachedPluspower
	call SwapTurn
	ld b, CARD_LOCATION_ARENA
	call ApplyAttachedDefender
	bank1call HandleDamageReduction
	bank1call $6c99 ; Func_6c99
	bit 7, d
	jr z, .no_underflow
	ld de, 0
.no_underflow
	call SwapTurn
	ret

; convert a color to its equivalent WR_* (weakness/resistance) value
TranslateColorToWR::
	push hl
	add LOW(InvertedPowersOf2)
	ld l, a
	ld a, HIGH(InvertedPowersOf2)
	adc $0
	ld h, a
	ld a, [hl]
	pop hl
	ret

InvertedPowersOf2:
	db $80, $40, $20, $10, $08, $04, $02, $01

; given a damage value at wDamage:
; - if the turn holder's arena card is weak to its own color: double damage
; - if the turn holder's arena card resists its own color: reduce damage by 30
; return resulting damage in de
ApplyDamageModifiers_DamageToSelf::
	xor a
	ld [wDamageEffectiveness], a
	ld hl, wDamage
	ld a, [hli]
	or [hl]
	or a
	jr z, .no_damage
	ld d, [hl]
	dec hl
	ld e, [hl]
	bank1call GetArenaCardColor
	call TranslateColorToWR
	ld b, a
	bank1call CheckWhetherToApplyWeakness
	jr c, .not_weak
	bank1call GetArenaCardWeakness
	and b
	jr z, .not_weak
	sla e
	rl d
	ld hl, wDamageEffectiveness
	set WEAKNESS, [hl]
.not_weak
	bank1call CheckWhetherToApplyResistance
	jr c, .not_resistant
	bank1call GetArenaCardResistance
	and b
	jr z, .not_resistant
	bank1call GetResistanceModifier
	add hl, de
	ld e, l
	ld d, h
	ld hl, wDamageEffectiveness
	set RESISTANCE, [hl]
.not_resistant
	ld b, CARD_LOCATION_ARENA
	call ApplyAttachedPluspower
	ld b, CARD_LOCATION_ARENA
	call ApplyAttachedDefender
	bit 7, d ; test for underflow
	ret z
.no_damage
	ld de, 0
	ret

; increases de by 10 points for each Pluspower found in location b
ApplyAttachedPluspower::
	push de
	ld a, b
	and $07
	add DUELVARS_ARENA_CARD_ATTACHED_PLUSPOWER
	get_turn_duelist_var
	ld l, a
	ld h, 10
	call HtimesL
	pop de
	add hl, de
	ld e, l
	ld d, h
	ret

; reduces de by 20 points for each Defender found in location b
ApplyAttachedDefender::
	push de
	ld a, b
	and $07
	add DUELVARS_ARENA_CARD_ATTACHED_DEFENDER
	get_turn_duelist_var
	ld l, a
	ld h, 20
	call HtimesL
	pop de
	ld a, e
	sub l
	ld e, a
	ld a, d
	sbc h
	ld d, a
	ret

; hl: address to subtract HP from
; de: how much HP to subtract (damage to deal)
; returns carry if the HP does not become 0 as a result
SubtractHP::
	push hl
	push de
	ld a, [hl]
	sub e
	ld [hl], a
	ld a, $0
	sbc d
	and $80
	jr z, .no_underflow
	ld [hl], 0
.no_underflow
	ld a, [hl]
	or a
	jr z, .zero
	scf
.zero
	pop de
	pop hl
	ret

; given a play area location offset in a, check if the turn holder's Pokemon card in
; that location has no HP left, and, if so, print that it was knocked out.
PrintPlayAreaCardKnockedOutIfNoHP::
	ld c, a
	add DUELVARS_ARENA_CARD_HP
	get_turn_duelist_var
	or a
	ret nz ; return if arena card has non-0 HP
	ld hl, wTempNonTurnDuelistCardID
	ld e, [hl]
	inc hl
	ld d, [hl]
	push hl
	push de
	ld a, c
	add DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call LoadCardDataToBuffer1_FromDeckIndex
	ld a, [wLoadedCard1ID]
	ld [wTempNonTurnDuelistCardID], a
	ld a, [wLoadedCard1ID + 1]
	ld [wTempNonTurnDuelistCardID + 1], a
	call PrintKnockedOut
	pop de
	pop hl
	ld [hl], d
	dec hl
	ld [hl], e
	scf
	ret

PrintKnockedOutIfHLZero::
	ld a, [hl] ; this is supposed to point to a remaining HP value after some form of damage calculation
	or a
	ret nz
;	fallthrough

; print in a text box that the Pokemon card at wTempNonTurnDuelistCardID
; was knocked out and wait 40 frames
PrintKnockedOut:
	ld hl, wTempNonTurnDuelistCardID
	ld e, [hl]
	inc hl
	ld d, [hl]
	call LoadCardDataToBuffer1_FromCardID
	ld hl, wLoadedCard1Name
	ld a, [hli]
	ld h, [hl]
	ld l, a
	call LoadTxRam2
	ldtx hl, WasKnockedOutText
	call DrawWideTextBox_PrintText
	ld a, 40
.wait_frames
	call DoFrame
	dec a
	jr nz, .wait_frames
	scf
	ret

; deal damage to turn holder's Pokemon card at play area location at b (PLAY_AREA_*).
; damage to deal is given in de.
; shows the defending player's play area screen when dealing the damage
; instead of the main duel interface with regular attack animation.
DealDamageToPlayAreaPokemon_RegularAnim:
	ld a, ATK_ANIM_BENCH_HIT
	ld [wLoadedAttackAnimation], a
;	fallthrough

; deal damage to turn holder's Pokemon card at play area location at b (PLAY_AREA_*).
; damage to deal is given in de.
; shows the defending player's play area screen when dealing the damage
; instead of the main duel interface.
; plays animation that is loaded in wLoadedAttackAnimation.
DealDamageToPlayAreaPokemon::
	xor a
	ld [wNoDamageOrEffect], a
	ld a, b
	ld [wTempPlayAreaLocation_cceb], a
	xor a
	ld [wDamageEffectiveness], a
	push hl
	push de
	push bc
	push de
	ld a, [wTempPlayAreaLocation_cceb]
	add DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call GetCardIDFromDeckIndex
	ld hl, wTempNonTurnDuelistCardID
	ld [hl], e
	inc hl
	ld [hl], d
	pop de
	ld a, [wLoadedAttackCategory]
	cp POKEMON_POWER
	jr z, .skip_defender
	ld a, [wTempPlayAreaLocation_cceb]
	or a ; cp PLAY_AREA_ARENA
	jr nz, .next
	bank1call HandleDamageModifiersEffects
	ld a, [wIsDamageToSelf]
	or a
	jr z, .turn_swapped
	ld b, CARD_LOCATION_ARENA
	call ApplyAttachedPluspower
	jr .next
.turn_swapped
	call SwapTurn
	ld b, CARD_LOCATION_ARENA
	call ApplyAttachedPluspower
	call SwapTurn
.next
	ld a, [wTempPlayAreaLocation_cceb]
	or CARD_LOCATION_PLAY_AREA
	ld b, a
	call ApplyAttachedDefender
.skip_defender
	ld a, [wTempPlayAreaLocation_cceb]
	or a ; cp PLAY_AREA_ARENA
	jr nz, .in_bench
	ld a, e
	or d
	jr z, .in_bench
	push de
	bank1call HandleNoDamageOrEffectSubstatus
	pop de
	bank1call HandleDamageReduction
	bank1call $6c99 ; Func_6c99
.in_bench
	bit 7, d
	jr z, .no_underflow
	ld de, 0
.no_underflow
	bank1call $6d87 ; Func_6d87
	bank1call $79fd ; Func_79fd
	ld a, [wTempPlayAreaLocation_cceb]
	or a ; cp PLAY_AREA_ARENA
	jr nz, .benched
	ld a, [wIsDamageToSelf]
	or a
	jr nz, .benched
	; if arena Pokemon, add damage at de to [wDealtDamage]
	ld hl, wDealtDamage
	ld a, e
	add [hl]
	ld [hli], a
	ld a, d
	adc [hl]
	ld [hl], a
	jr .benched
.benched
	ld a, [wTempPlayAreaLocation_cceb]
	ld b, a
	ld a, [wDamageEffectiveness]
	ld c, a
	ld a, [wTempPlayAreaLocation_cceb]
	add DUELVARS_ARENA_CARD_HP
	get_turn_duelist_var
	push af
	farcall $6, $4a9c ; PlayAttackAnimation_DealAttackDamageSimple
	pop af
	or a
	jr z, .skip_knocked_out
	push de
	call PrintKnockedOutIfHLZero
	pop de
.skip_knocked_out
	bank1call $6dad ; HandleStrikesBack_AgainstDamagingAttack
	pop bc
	pop de
	pop hl
	ret

Func_1bb4:
	call FinishQueuedAnimations
	bank1call DrawDuelMainScene
	bank1call DrawDuelHUDs
	xor a ; PLAY_AREA_ARENA
	ldh [hTempPlayAreaLocation_ff9d], a
	call Func_19e1
	call WaitForWideTextBoxInput
	call ExchangeRNG
	ret

; prints one of the ThereWasNoEffectFrom*Text if wEffectFailed contains EFFECT_FAILED_NO_EFFECT,
; and prints WasUnsuccessfulText if wEffectFailed contains EFFECT_FAILED_UNSUCCESSFUL
Func_19e1::
	ld a, [wEffectFailed]
	or a
	ret z
	cp $1
	jr z, .no_effect_from_status
	call Func_19fd
	ldtx hl, WasUnsuccessfulText
	call DrawWideTextBox_PrintText
	scf
	ret
.no_effect_from_status
	bank1call $66d0 ; PrintThereWasNoEffectFromStatusText
	call DrawWideTextBox_PrintText
	scf
	ret

Func_19fd:
	ldh a, [hTempPlayAreaLocation_ff9d]
	add DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call LoadCardDataToBuffer1_FromDeckIndex
	ld a, 18
	call CopyCardNameAndLevel
	; zero wTxRam2 so that the name & level text just loaded to wDefaultText is printed
	ld [hl], $0
	ld hl, $0000
	call LoadTxRam2
	ld hl, wLoadedAttackName
	ld de, $cdd8 ; wTxRam2_b
	ld a, [hli]
	ld [de], a
	inc de
	ld a, [hli]
	ld [de], a
	ret

Func_1a1e:
	bank1call ClearNonTurnTemporaryDuelvars
	call Func_19fd
	ld hl, $1a2
	jp DrawWideTextBox_WaitForInput

; return in a the retreat cost of the turn holder's arena or bench Pokemon
; given the PLAY_AREA_* value in hTempPlayAreaLocation_ff9d
GetPlayAreaCardRetreatCost::
	ldh a, [hTempPlayAreaLocation_ff9d]
	add DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call LoadCardDataToBuffer1_FromDeckIndex
	ld a, [wLoadedCard1RetreatCost]
	bank1call $75e7 ; GetLoadedCard1RetreatCost
	ret

; calculate damage and max HP of card at PLAY_AREA_* in e.
; input:
;	e = PLAY_AREA_* of card;
; output:
;	a = damage;
;	c = max HP.
GetCardDamageAndMaxHP::
	push hl
	push de
	ld a, DUELVARS_ARENA_CARD
	add e
	get_turn_duelist_var
	call LoadCardDataToBuffer2_FromDeckIndex
	pop de
	push de
	ld a, DUELVARS_ARENA_CARD_HP
	add e
	get_turn_duelist_var
	ld a, [wLoadedCard2HP]
	ld c, a
	sub [hl]
	pop de
	pop hl
	ret

; check if a flag of wLoadedAttack is set
; input:
   ; a = %fffffbbb, where
      ; fffff = flag address counting from wLoadedAttackFlag1
      ; bbb = flag bit
; return carry if the flag is set
CheckLoadedAttackFlag::
	push hl
	push de
	push bc
	ld c, a ; %fffffbbb
	and $07
	ld e, a
	ld d, $00
	ld hl, PowersOf2
	add hl, de
	ld b, [hl]
	ld a, c
	rra
	rra
	rra
	and $1f
	ld e, a ; %000fffff
	ld hl, wLoadedAttackFlag1
	add hl, de
	ld a, [hl]
	and b
	jr z, .done
	scf ; set carry if the attack has this flag set
.done
	pop bc
	pop de
	pop hl
	ret

; returns [hWhoseTurn] <-- ([hWhoseTurn] ^ $1)
;   As a side effect, this also returns a duelist variable in a similar manner to
;   GetNonTurnDuelistVariable, but this function appears to be
;   only called to swap the turn value.
SwapTurn::
	push af
	push hl
	call GetNonTurnDuelistVariable
	ld a, h
	ldh [hWhoseTurn], a
	pop hl
	pop af
	ret

; copy the TX_END-terminated player's name from sPlayerName to de
CopyPlayerName::
	call EnableSRAM
	ld hl, sPlayerName
.loop
	ld a, [hli]
	ld [de], a
	inc de
	or a ; TX_END
	jr nz, .loop
	dec de
	call DisableSRAM
	ret

; copy the opponent's name to de
; if text ID at wOpponentName is non-0, copy it from there
; else, if text at wc500 is non-0, copy if from there
; else, copy Player2Text
CopyOpponentName::
	ld hl, wOpponentName
	ld a, [hli]
	or [hl]
	jr z, .special_name
	ld a, [hld]
	ld l, [hl]
	ld h, a
	jp CopyText
.special_name
	ld hl, wNameBuffer
	ld a, [hl]
	or a
	jr z, .print_player2
	jr CopyPlayerName.loop
.print_player2
	ldtx hl, Player2Text
	jp CopyText
