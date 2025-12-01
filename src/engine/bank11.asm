; hl = card list
TakeOutCardsInHLFromCollection:
	push af
	push de
	push hl
.loop_cards
	ld a, [hli]
	ld e, a
	ld a, [hli]
	ld d, a
	or e
	jr z, .done
	call RemoveCardFromCollection
	jr .loop_cards
.done
	pop hl
	pop de
	pop af
	ret

; for a card list in hl,
; reset carry if all cards are identical
; set carry if it's empty or has different cards
CheckIfAllIdenticalCardsInHL:
	push bc
	push de
	push hl
	ld a, [hli]
	ld e, a
	ld a, [hli]
	ld d, a
	or e
	jr z, .empty_or_different
.loop_cards
	ld a, [hli]
	ld c, a
	ld a, [hli]
	ld b, a
	or c
	jr z, .all_identical
	ld a, d
	cp b
	jr c, .skip_low
	jr nz, .skip_low
	ld a, e
	cp c
.skip_low
	jr nz, .empty_or_different
	jr .loop_cards

.empty_or_different
	scf
	jr .done
.all_identical
	scf
	ccf
.done
	pop hl
	pop de
	pop bc
	ret

; counts number of cards in
; $0000 terminated list in hl
; output:
;  a = number of cards
CountCardsInHL:
	push bc
	push hl
	xor a
	ld c, a
.loop
	ld a, [hli]
	ld b, a
	ld a, [hli]
	or b
	jr z, .done
	inc c
	jr .loop
.done
	ld a, c
	pop hl
	pop bc
	ret

; input:
;  hl = card list
;  de = card ID to search for
; output:
;  carry set if not found
;  a = index in list if found
SearchCardInListInHL:
	push bc
	push de
	push hl
	xor a
.loop_cards
	push af
	ld a, [hli]
	ld c, a
	ld a, [hli]
	ld b, a
	or c
	jr z, .not_found
	ld a, d
	cp b
	jr c, .not_equal
	jr nz, .not_equal
	ld a, e
	cp c
.not_equal
	jr z, .found
	pop af
	inc a
	jr .loop_cards
.not_found
	pop af
	xor a
	scf
	jr .done
.found
	pop af
	scf
	ccf
.done
	pop hl
	pop de
	pop bc
	ret

; SearchCardInListInHL[a:]
; input:
;  hl = card list
;  de = card ID to search for
;  a = offset
; output:
;  carry set if not found
;  a = index in list if found
SearchCardInListInHL_Offset:
	push hl
	sla a
	add l
	ld l, a
	jr nc, .search
	inc h
.search
	call SearchCardInListInHL
	pop hl
	ret

; check if card list in hl has a valid evo line and nothing else
; (1 card each as follows)
; return evo-stage flags in a:
;   0: BASIC, STAGE1, STAGE2
;   1: BASIC, STAGE1
;   2: BASIC, STAGE2
;   3: STAGE1, STAGE2
; set carry if invalid
CheckIfEvoLineInHL:
	call CountCardsInHL
	cp 2
	jr z, .two_or_three
	cp 3
	jr z, .two_or_three
; otherwise invalid
	scf
	ret

.two_or_three
	push bc
	push de
	push hl
	push hl
; init buffer
	xor a
	ld hl, wTempBlackBoxInputEvoLine
REPT 2 * NUM_REGULAR_EVO_STAGES
	ld [hli], a
	ENDR

	pop hl
.loop_cards
	ld a, [hli]
	ld e, a
	ld a, [hli]
	ld d, a
	or e
	jr z, .check_evo_combo
	call LoadCardDataToBuffer1_FromCardID
	ld a, [wLoadedCard1Type]
	cp TYPE_ENERGY
	jp nc, .invalid
; pkmn
	push hl
	ld hl, wTempBlackBoxInputBasic
	ld a, [wLoadedCard1Stage]
	sla a
	add l
	ld l, a
	jr nc, .store_in_buffer
	inc h
.store_in_buffer
	ld a, [hli]
	ld c, a
	ld a, [hld]
	or c
	push hl
	pop bc
	pop hl
	jp nz, .invalid ; the same stage already exists
	ld a, e
	ld [bc], a
	inc bc
	ld a, d
	ld [bc], a
	jr .loop_cards

.check_evo_combo
	ld hl, wTempBlackBoxInputBasic
	ld a, [hli]
	ld e, a
	ld a, [hli]
	ld d, a
	or e
	jp z, .no_basic_input
	ld a, [hli] ; wTempBlackBoxInputStage1
	ld e, a
	ld a, [hli]
	ld d, a
	or e
	jr z, .basic_and_stage2
	ld a, [hli] ; wTempBlackBoxInputStage2
	ld e, a
	ld a, [hli]
	ld d, a
	or e
	jr z, .basic_and_stage1

; BASIC | STAGE1 | STAGE2
	ld hl, wTempBlackBoxInputBasic
	ld a, [hli]
	ld e, a
	ld a, [hli]
	ld d, a
	call ListUniqueEvoCardsFromDE
	jp nc, .invalid
	ld a, [hli] ; wTempBlackBoxInputStage1
	ld e, a
	ld a, [hli]
	ld d, a
	push hl
	ld hl, wDuelTempList
	call SearchCardInListInHL
	pop hl
	jp c, .invalid
	call ListUniqueEvoCardsFromDE
	jp nc, .invalid
	ld a, [hli] ; wTempBlackBoxInputStage2
	ld e, a
	ld d, [hl]
	ld hl, wDuelTempList
	call SearchCardInListInHL
	jr c, .invalid
	xor a ; 0 instead of (BASIC | STAGE1 | STAGE2)
	jr .valid

.basic_and_stage1
	ld hl, wTempBlackBoxInputBasic
	ld a, [hli]
	ld e, a
	ld a, [hli]
	ld d, a
	call ListUniqueEvoCardsFromDE
	jr nc, .invalid
	ld a, [hli] ; wTempBlackBoxInputStage1
	ld e, a
	ld d, [hl]
	ld hl, wDuelTempList
	call SearchCardInListInHL
	jr c, .invalid
	ld a, BASIC | STAGE1
	jr .valid

.basic_and_stage2
	ld hl, wTempBlackBoxInputBasic
	ld a, [hli]
	ld e, a
	ld a, [hli]
	ld d, a
	call ListUniqueEvoCardsFromDE
	jr nc, .invalid
	inc hl
	inc hl
	ld a, [hli] ; wTempBlackBoxInputStage2
	ld e, a
	ld d, [hl]
	call LoadCardDataToBuffer1_FromCardID
	ld a, [wLoadedCard1PreEvoName]
	ld c, a
	ld a, [wLoadedCard1PreEvoName + 1]
	ld b, a
	ld hl, wDuelTempList
.loop_lookup
	ld a, [hli]
	ld e, a
	ld a, [hli]
	ld d, a
	or e
	jr z, .invalid
	call LoadCardDataToBuffer1_FromCardID
	ld a, [wLoadedCard1Name]
	ld e, a
	ld a, [wLoadedCard1Name + 1]
	ld d, a
	ld a, d
	cp b
	jr c, .next_lookup
	jr nz, .next_lookup
	ld a, e
	cp c
.next_lookup
	jr nz, .loop_lookup
	ld a, BASIC | STAGE2
	jr .valid

.no_basic_input
	ld hl, wTempBlackBoxInputStage1
	ld a, [hli]
	ld e, a
	ld a, [hli]
	ld d, a
	call ListUniqueEvoCardsFromDE
	jr nc, .invalid
	ld a, [hli] ; wTempBlackBoxInputStage2
	ld e, a
	ld d, [hl]
	ld hl, wDuelTempList
	call SearchCardInListInHL
	jr c, .invalid
	ld a, STAGE1 | STAGE2

.valid
	scf
	ccf
	jr .done
.invalid
	scf
.done
	pop hl
	pop de
	pop bc
	ret

; unreferenced?
; compare card lists in bc and hl
; clear carry if equal
; set carry if different
CheckIfListsInBCAndHLAreEqual:
	push bc
	push de
	push hl
	call CheckIfListInBCIsSubsetOfListInHL
	jr c, .different
	call CountCardsInHL
	ld e, a
	ld l, c
	ld h, b
	call CountCardsInHL
	cp e
	jr nz, .different
	scf
	ccf
	jr .done
.different
	scf
.done
	pop hl
	pop de
	pop bc
	ret

; return in a the most frequent type in card list in hl
; with rng as tiebreaker
; set carry for TYPE_PKMN_FIRE (= 0)
GetMostFrequentPkmnTypeInHL:
	push bc
	push de
	push hl
	push hl
; init buffer
	xor a
	ld hl, wNumBlackBoxInputPkmnPerType
REPT NUM_PKMN_TYPES - 1
	ld [hli], a
	ENDR
	ld [hl], a

	pop hl
.loop_cards
	ld a, [hli]
	ld e, a
	ld a, [hli]
	ld d, a
	or e
	jr z, .check_count
	call LoadCardDataToBuffer1_FromCardID
	ld a, [wLoadedCard1Type]
	cp TYPE_PKMN
	jr nc, .loop_cards
	ld de, wNumBlackBoxInputPkmnPerType
	add e
	ld e, a
	jr nc, .incr_count
	inc d
.incr_count
	ld a, [de]
	inc a
	ld [de], a
	jr .loop_cards

.check_count
	ld de, 0
	ld c, 0
	ld hl, wNumBlackBoxInputPkmnPerType
.loop_check_count
	ld a, [hli]
	cp d
	jr c, .next_type
	jr nz, .get_type_and_count
; tie
	call UpdateRNGSources
	srl a
	jr c, .next_type
	ld e, c
	jr .next_type

.get_type_and_count
	ld d, a
	ld e, c
.next_type
	inc c
	ld a, c
	cp NUM_PKMN_TYPES
	jr nz, .loop_check_count

; got most frequent type
	ld a, e
	or a
	jr nz, .done
; set carry for TYPE_PKMN_FIRE
	scf
.done
	pop hl
	pop de
	pop bc
	ret

; return in a the number of unique pkmn types in the card list in hl
CountUniquePkmnTypesInHL:
	push bc
	push de
	push hl
; init buffer
	farcall ZeroOutBytes_wd606

.loop_cards
	ld a, [hli]
	ld e, a
	ld a, [hli]
	ld d, a
	or e
	jr z, .count_types
	call LoadCardDataToBuffer1_FromCardID
	ld a, [wLoadedCard1Type]
	cp TYPE_PKMN
	jr nc, .loop_cards
; pkmn, set type bit
	farcall SetBit_wd606
	jr .loop_cards

.count_types
	xor a
	ld c, a
.loop_count_types
	farcall CheckBit_wd606
	jr z, .next_bit
	inc c
.next_bit
	inc a
	cp NUM_PKMN_TYPES
	jr nz, .loop_count_types
; got type counts
	ld a, c
	pop hl
	pop de
	pop bc
	ret

; create in wDuelTempList a list of unique cards that matches
; both b = TYPE_* and c = rarity
; and return the list length in a
ListUniqueCardsOfTheSameTypeAndRarity:
	push bc
	push de
	push hl
	ld de, GRASS_ENERGY
	ld hl, wDuelTempList
	xor a
	push af
.loop_cards
	call LoadCardDataToBuffer1_FromCardID
	ld a, [wLoadedCard1Type]
	cp b
	jr nz, .check_bounds
	ld a, [wLoadedCard1Rarity]
	cp c
	jr nz, .check_bounds
; match, append it and incr length counter
	pop af
	inc a
	push af
	ld a, e
	ld [hli], a
	ld a, d
	ld [hli], a
.check_bounds
	ld a, d
	cp HIGH(NUM_CARDS)
	jr c, .next_card
	jr nz, .next_card
	ld a, e
	cp LOW(NUM_CARDS)
.next_card
	inc de
	jr nz, .loop_cards
; done, append $0000 terminator
	xor a
	ld [hli], a
	ld [hl], a
	pop af
	pop hl
	pop de
	pop bc
	ret

; appends card ID in de to list in hl
AppendCardToListInHL:
	push af
	push bc
	push hl
.loop_cards
	ld a, [hli]
	ld c, a
	ld a, [hli]
	ld b, a
	or c
	jr nz, .loop_cards
	inc hl
	xor a
	ld [hld], a ; terminating byte
	ld [hld], a ;
	ld a, d
	ld [hld], a ; card ID
	ld [hl], e  ;
	pop hl
	pop bc
	pop af
	ret

; for a card in de,
; create in wDuelTempList a list of its unique evo cards
; also return carry if at least 1
ListUniqueEvoCardsFromDE:
	push bc
	push de
	push hl
	farcall _ListUniqueEvoCardsFromDE
	pop hl
	pop de
	pop bc
	ret

; for a card in de,
; create in wDuelTempList a list of its unique pre-evo cards
; also set carry if at least 1
ListUniquePreEvoCardsFromDE:
	push bc
	push de
	push hl
	call LoadCardDataToBuffer1_FromCardID
	ld hl, wLoadedCard1PreEvoName
	ld a, [hli]
	ld c, a
	ld b, [hl]
	ld hl, wDuelTempList
	ld de, GRASS_ENERGY - 1 ; 0
.loop_cards
	inc de
	push hl
	push de
	call LoadCardDataToBuffer1_FromCardID
	jr c, .exit
	ld a, [wLoadedCard1Type]
	cp TYPE_ENERGY
	jr nc, .next_card
	ld hl, wLoadedCard1Name
	ld a, c
	cp [hl]
	jr nz, .next_card
	inc hl
	ld a, b
	cp [hl]
	jr nz, .next_card
; found pre-evo
	pop de
	pop hl
	ld a, e
	ld [hli], a
	ld a, d
	ld [hli], a
	jr .loop_cards
.next_card
	pop de
	pop hl
	jr .loop_cards

.exit
	pop de
	pop hl
; append $0000 terminator
	xor a
	ld [hli], a
	ld [hl], a
	ld hl, wDuelTempList
	ld a, [hli]
	or [hl]
	pop hl
	pop de
	pop bc
	ret z ; empty
; not empty
	scf
	ret

; for a card in de,
; create in wDuelTempList a list of unique cards of the same name
; also return carry if at least 1 (i.e. always)
ListUniqueCardsOfTheSameName:
	push bc
	push de
	push hl
	call LoadCardDataToBuffer1_FromCardID
	ld hl, wLoadedCard1Name
	ld a, [hli]
	ld c, a
	ld b, [hl]
	ld hl, wDuelTempList
	ld de, GRASS_ENERGY - 1 ; 0
.loop_cards
	inc de
	push hl
	push de
	call LoadCardDataToBuffer1_FromCardID
	jr c, .exit
	ld a, [wLoadedCard1Type]
	cp TYPE_ENERGY
	jr nc, .next_card
	ld hl, wLoadedCard1Name
	ld a, c
	cp [hl]
	jr nz, .next_card
	inc hl
	ld a, b
	cp [hl]
	jr nz, .next_card
; found the same name
	pop de
	pop hl
	ld a, e
	ld [hli], a
	ld a, d
	ld [hli], a
	jr .loop_cards
.next_card
	pop de
	pop hl
	jr .loop_cards

.exit
	pop de
	pop hl
; append $0000 terminator
	xor a
	ld [hli], a
	ld [hl], a
	ld hl, wDuelTempList
	ld a, [hli]
	or [hl]
	pop hl
	pop de
	pop bc
	ret z ; empty, impossible
; not empty
	scf
	ret

; unreferenced?
; a = rarity, hl = card list
; return in a the count of cards of that rarity in hl
CountCardsOfRarityOfAInHL:
	push bc
	push de
	push hl
	ld b, a
	ld c, 0
.loop_cards
	ld a, [hli]
	ld e, a
	ld a, [hli]
	ld d, a
	or e
	jr z, .done
	call LoadCardDataToBuffer1_FromCardID
	ld a, [wLoadedCard1Rarity]
	cp b
	jr nz, .loop_cards
	inc c
	jr .loop_cards

.done
	ld a, c
	pop hl
	pop de
	pop bc
	ret

; for a card list in hl,
; reset carry if all cards have the same rarity
; set carry if it's empty or has different rarities
CheckIfAllIdenticalRarityInHL:
	push bc
	push de
	push hl
	ld c, a
	ld a, [hli]
	ld e, a
	ld a, [hld]
	ld d, a
	or e
	jr z, .empty_or_different
.loop_cards
	ld a, [hli]
	ld e, a
	ld a, [hli]
	ld d, a
	or e
	jr z, .all_identical_rarity
	call LoadCardDataToBuffer1_FromCardID
	ld a, [wLoadedCard1Rarity]
	cp c
	jr nz, .empty_or_different
	jr .loop_cards

.empty_or_different
	scf
	jr .done
.all_identical_rarity
	scf
	ccf
.done
	pop hl
	pop de
	pop bc
	ret

; if a card in de is in the list in hl,
; drop the first occurrence of it and shift the rest
; else (i.e. not found) set carry
RemoveCardFromListInHL:
	push bc
	push de
	push hl
.loop_cards
	ld a, [hli]
	ld c, a
	ld a, [hli]
	ld b, a
	or c
	jr z, .not_found
	ld a, d
	cp b
	jr c, .next_card
	jr nz, .next_card
	ld a, e
	cp c
.next_card
	jr nz, .loop_cards

; found
.loop_shift
	ld a, [hli]
	ld e, a
	ld a, [hld]
	ld d, a
	dec hl
	dec hl
	ld a, e
	ld [hli], a
	ld a, d
	ld [hli], a
	or e
	inc hl
	inc hl
	jr nz, .loop_shift
; ensure the $0000 terminator (redundant?)
	xor a
	dec hl
	ld [hld], a
	ld [hl], a
	scf
	ccf
	jr .done

.not_found
	scf
.done
	pop hl
	pop de
	pop bc
	ret

; compare two card lists in bc and hl
; if bc is a subset of hl (dupes apply), reset carry
; else set carry
; e.g. whether black box input contains blackbox_promo recipes
CheckIfListInBCIsSubsetOfListInHL:
	push bc
	push de
	push hl
; init buffer
	farcall ZeroOutBytes_wd606

.loop_list_bc
	ld a, [bc]
	ld e, a
	inc bc
	ld a, [bc]
	ld d, a
	inc bc
	or e
	jr z, .exit
	ld a, -1
.loop_list_hl
	inc a
	call SearchCardInListInHL_Offset
	jr c, .not_found
; found, set index bit
	farcall CheckBit_wd606
	jr nz, .loop_list_hl
	farcall SetBit_wd606
	jr .loop_list_bc

.exit
	scf
	ccf
	jr .done
.not_found
	scf
.done
	pop hl
	pop de
	pop bc
	ret

; for each card in bc,
; drop the first occurence of it in hl and shift the rest
; set carry if not found
RemoveCardsInBCFromHL:
	push af
	push bc
	push de
	push hl
.loop_remove
	ld a, [bc]
	ld e, a
	inc bc
	ld a, [bc]
	inc bc
	ld d, a
	or e
	jr z, .done
	call RemoveCardFromListInHL
	jr .loop_remove

.done
	pop hl
	pop de
	pop bc
	pop af
	ret

; filters card list in hl
; based on rarity in c and value in b:
;    $0: only pkmn
;    $1: only trainers
;  > $1: only energy
; input:
;  b = filter option
;  c = card rarity
; output:
;  wDuelTempList = filtered list
;  a = number of cards in filtered list
FilterCardListInHL:
	push bc
	push de
	push hl
	xor a
	push af
	ld a, LOW(wDuelTempList)
	ld [wFilteredListPtr + 0], a
	ld a, HIGH(wDuelTempList)
	ld [wFilteredListPtr + 1], a
.loop_cards
	ld a, [hli]
	ld e, a
	ld a, [hli]
	ld d, a
	or e
	jr z, .done
	call LoadCardDataToBuffer1_FromCardID
	ld a, [wLoadedCard1Rarity]
	cp c
	jr nz, .loop_cards
	ld a, b
	cp FILTER_ONLY_TRAINER
	jr z, .only_trainers
	jr nc, .only_energy
; only pkmn
	ld a, [wLoadedCard1Type]
	cp TYPE_ENERGY
	jr nc, .loop_cards
	jr .append_card
.only_trainers
	ld a, [wLoadedCard1Type]
	cp TYPE_TRAINER
	jr nz, .loop_cards
	jr .append_card
.only_energy
	ld a, [wLoadedCard1Type]
	cp TYPE_ENERGY
	jr c, .loop_cards
	cp TYPE_TRAINER
	jr z, .loop_cards
	jr .append_card

.append_card
; writes this card ID to the next entry in the list
	push hl
	ld a, [wFilteredListPtr + 0]
	ld l, a
	ld a, [wFilteredListPtr + 1]
	ld h, a
	ld a, e
	ld [hli], a
	ld a, d
	ld [hli], a
	ld a, l
	ld [wFilteredListPtr + 0], a
	ld a, h
	ld [wFilteredListPtr + 1], a
	pop hl
	pop af
	inc a
	push af
	jr .loop_cards

.done
; add terminating bytes
	ld a, [wFilteredListPtr + 0]
	ld l, a
	ld a, [wFilteredListPtr + 1]
	ld h, a
	xor a
	ld [hli], a
	ld [hl], a
	pop af
	pop hl
	pop de
	pop bc
	ret

; shuffle card list in hl by running
; random card swapping algorithm 40 times
ShuffleCardsInHL:
	push af
	push bc
	push de
	push hl
	call CountCardsInHL
	or a
	jr z, .done ; no cards in list
	ld b, a
	ld c, 40

.loop
	push bc
	push hl
	ld e, l
	ld d, h

; pick 2 random cards from list
; then swap them
	ld a, b
	call Random
	sla a
	add l
	ld l, a
	jr nc, .no_carry1
	inc h
.no_carry1
	ld a, b
	call Random
	sla a
	add e
	ld e, a
	jr nc, .no_carry2
	inc d
.no_carry2
	ld b, [hl]
	ld a, [de]
	ld [hl], a
	ld a, b
	ld [de], a
	inc hl
	inc de
	ld b, [hl]
	ld a, [de]
	ld [hl], a
	ld a, b
	ld [de], a
	pop hl
	pop bc
	dec c
	jr nz, .loop

.done
	pop hl
	pop de
	pop bc
	pop af
	ret

; unreferenced
; countif( (card list in hl), (real card set constant in a) )
CountCardsFromRealSetOfAInHL:
	push bc
	push de
	push hl
	ld b, a
	ld c, 0
.loop_cards
	ld a, [hli]
	ld e, a
	ld a, [hli]
	ld d, a
	or e
	jr z, .done
	call LoadCardDataToBuffer1_FromCardID
	ld a, [wLoadedCard1RealSet]
	cp b
	jr nz, .loop_cards
	inc c
	jr .loop_cards
.done
	ld a, c
	pop hl
	pop de
	pop bc
	ret

; countif( (card list in hl), (card set constant in a) )
; often with a = PROMOTIONAL
CountCardsFromSetOfAInHL:
	push bc
	push de
	push hl
	ld b, a
	ld c, 0
.loop_cards
	ld a, [hli]
	ld e, a
	ld a, [hli]
	ld d, a
	or e
	jr z, .done
	call LoadCardDataToBuffer1_FromCardID
	ld a, [wLoadedCard1Set]
	cp b
	jr nz, .loop_cards
	inc c
	jr .loop_cards
.done
	ld a, c
	pop hl
	pop de
	pop bc
	ret

_ChooseTitleScreenCards:
	push af
	push bc
	push de
	push hl
	push hl
	xor a
	ld [hli], a
	ld [hld], a
	xor a ; unnecessary
	ld [wIntroCardsRepeatsAllowed], a

	call EnableSRAM
	ld hl, sDeck1
	ld c, NUM_DECKS + 1
.loop_decks
	ld a, [hli]
	ld e, a
	ld a, [hld]
	or e
	jr nz, .got_deck
	ld de, DECK_COMPRESSED_STRUCT_SIZE
	add hl, de
	dec c
	jr nz, .loop_decks

; no decks in memory,
; use the default cards
	call DisableSRAM
	ld hl, .DefaultIntroCards
	pop de
	ld bc, 2 * 9
	call CopyDataHLtoDE_SaveRegisters
	jp .done

.got_deck
	call DisableSRAM

	bank1call LoadPlayerDeck
	xor a
	ld [wPlayerDeck + $78], a ; terminating bytes
	ld [wPlayerDeck + $79], a ; for wPlayerDeck
	pop hl

	ld a, NUM_TITLE_SCREEN_CARDS
	ld [wRemainingIntroCards], a
.star_pkmn
	push hl
	ld hl, wPlayerDeck
	lb bc, FILTER_ONLY_PKMN, STAR
	call FilterCardListInHL
	pop hl
	ld b, a
	or a
	jr z, .diamond_pkmn
	ld c, $00
	call .AppendCards
.diamond_pkmn
	push hl
	ld hl, wPlayerDeck
	lb bc, FILTER_ONLY_PKMN, DIAMOND
	call FilterCardListInHL
	pop hl
	ld b, a
	or a
	jr z, .circle_pkmn
	ld c, $00
	call .AppendCards
.circle_pkmn
	push hl
	ld hl, wPlayerDeck
	lb bc, FILTER_ONLY_PKMN, CIRCLE
	call FilterCardListInHL
	pop hl
	ld b, a
	or a
	jr z, .star_trainers
	ld c, $00
	call .AppendCards
.star_trainers
	push hl
	ld hl, wPlayerDeck
	lb bc, FILTER_ONLY_TRAINER, STAR
	call FilterCardListInHL
	pop hl
	ld b, a
	or a
	jr z, .diamond_trainers
	ld c, $00
	call .AppendCards
.diamond_trainers
	push hl
	ld hl, wPlayerDeck
	lb bc, FILTER_ONLY_TRAINER, DIAMOND
	call FilterCardListInHL
	pop hl
	ld b, a
	or a
	jr z, .circle_trainers
	ld c, $00
	call .AppendCards
.circle_trainers
	push hl
	ld hl, wPlayerDeck
	lb bc, FILTER_ONLY_TRAINER, CIRCLE
	call FilterCardListInHL
	pop hl
	ld b, a
	or a
	jr z, .star_energy
	ld c, $00
	call ShuffleCardsInHL
	call .AppendCards
.star_energy
	push hl
	ld hl, wPlayerDeck
	lb bc, FILTER_ONLY_ENERGY, STAR
	call FilterCardListInHL
	pop hl
	ld b, a
	or a
	jr z, .diamond_energy
	ld c, $00
	call .AppendCards
.diamond_energy
	push hl
	ld hl, wPlayerDeck
	lb bc, FILTER_ONLY_ENERGY, DIAMOND
	call FilterCardListInHL
	pop hl
	ld b, a
	or a
	jr z, .circle_energy
	ld c, $00
	call .AppendCards
.circle_energy
	push hl
	ld hl, wPlayerDeck
	lb bc, FILTER_ONLY_ENERGY, CIRCLE
	call FilterCardListInHL
	pop hl
	ld b, a
	or a
	jr z, .allow_duplicates
	ld c, $00
	call .AppendCards
.allow_duplicates
	ld a, TRUE
	ld [wIntroCardsRepeatsAllowed], a
	ld a, [wRemainingIntroCards]
	or a
	jp nz, .star_pkmn
.done
	pop hl
	pop de
	pop bc
	pop af
	ret

.AppendCards:
	; shuffle card list
	push hl
	ld hl, wDuelTempList
	call ShuffleCardsInHL
	pop hl

.loop_cards
	push hl
	ld hl, wDuelTempList
	ld a, c
	sla a
	add l
	ld l, a
	jr nc, .no_carry
	inc h
.no_carry
	ld a, [hli]
	ld e, a
	ld d, [hl]
	pop hl
	call .TryAppend
	inc c
	ld a, c
	cp b
	jr nz, .loop_cards
	ret

.TryAppend:
; appends if wIntroCardsRepeatsAllowed != 0
; or otherwise, if card is not in list already
	ld a, [wRemainingIntroCards]
	or a
	ret z
	ld a, [wIntroCardsRepeatsAllowed]
	or a
	jr nz, .append
	call SearchCardInListInHL
	jr c, .append
	ret
.append
	call AppendCardToListInHL
	ld a, [wRemainingIntroCards]
	dec a
	ld [wRemainingIntroCards], a
	ret

.DefaultIntroCards:
	dw BULBASAUR_LV12
	dw CHARMANDER_LV9
	dw SQUIRTLE_LV16
	dw PIKACHU_LV13
	dw DARK_MACHOKE
	dw MEW_LV23
	dw MEOWTH_LV13
	dw HERE_COMES_TEAM_ROCKET
	dw $0000

MACRO blackbox_promo
	dw \1 ; recipe pointer
	db \2 ; whether locked to post-game (EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE)
	dw \3 ; output promo card id
ENDM

MACRO blackbox_promo_recipe
	REPT _NARG
		dw \1 ; input card id
		SHIFT
	ENDR
	dw 0 ; end of list
ENDM

BlackboxPromoCards:
	blackbox_promo .dugtrio_lv40, FALSE, DUGTRIO_LV40
	blackbox_promo .mankey_alt_lv7, TRUE, MANKEY_ALT_LV7
	blackbox_promo .diglett_lv16, TRUE, DIGLETT_LV16
	blackbox_promo .moltres_lv40, FALSE, MOLTRES_LV40
	blackbox_promo .arcanine_lv34, TRUE, ARCANINE_LV34
; bug, CHARIZARD_LV76 should be CHARIZARD_ALT_LV76
	blackbox_promo .nonpromo_charizard_lv76, FALSE, CHARIZARD_LV76
	blackbox_promo .pikachu_lv13, TRUE, PIKACHU_LV13
	blackbox_promo .pikachu_lv16, FALSE, PIKACHU_LV16
	blackbox_promo .zapdos_lv68, FALSE, ZAPDOS_LV68
	blackbox_promo .pikachu_alt_lv16, FALSE, PIKACHU_ALT_LV16
	blackbox_promo .electabuzz_lv20, TRUE, ELECTABUZZ_LV20
	blackbox_promo .articuno_lv37, FALSE, ARTICUNO_LV37
	blackbox_promo .magikarp_lv10, TRUE, MAGIKARP_LV10
	blackbox_promo .blastoise_alt_lv52, FALSE, BLASTOISE_ALT_LV52
	blackbox_promo .venusaur_alt_lv67, FALSE, VENUSAUR_ALT_LV67
	blackbox_promo .grs_mewtwo, TRUE, GRS_MEWTWO
	blackbox_promo .mewtwo_alt_lv60, FALSE, MEWTWO_ALT_LV60
	blackbox_promo .mewtwo_lv60, FALSE, MEWTWO_LV60
	blackbox_promo .mewtwo_lv30, TRUE, MEWTWO_LV30
	blackbox_promo .slowpoke_lv9, TRUE, SLOWPOKE_LV9
	blackbox_promo .super_energy_retrieval, TRUE, SUPER_ENERGY_RETRIEVAL
	blackbox_promo .dark_persian_alt_lv28, TRUE, DARK_PERSIAN_ALT_LV28
	blackbox_promo .jigglypuff_lv12, FALSE, JIGGLYPUFF_LV12
	blackbox_promo .kangaskhan_lv38, FALSE, KANGASKHAN_LV38
	blackbox_promo .farfetchd_alt_lv20, TRUE, FARFETCHD_ALT_LV20
	blackbox_promo .dragonite_lv41, FALSE, DRAGONITE_LV41
; bug, DRAGONITE_LV45 should be DRAGONITE_LV43
	blackbox_promo .nonpromo_dragonite_lv45, TRUE, DRAGONITE_LV45
	blackbox_promo .meowth_lv14, FALSE, MEOWTH_LV14
	blackbox_promo .hungry_snorlax, TRUE, HUNGRY_SNORLAX
	blackbox_promo .cool_porygon, TRUE, COOL_PORYGON
	dw 0 ; end

.dugtrio_lv40
	blackbox_promo_recipe DUGTRIO_LV36, HITMONLEE_LV30, HITMONCHAN_LV23
	.mankey_alt_lv7
	blackbox_promo_recipe HITMONLEE_LV30, HITMONCHAN_LV23
	.diglett_lv16
	blackbox_promo_recipe DUGTRIO_LV36, DARK_DUGTRIO
	.moltres_lv40
	blackbox_promo_recipe NINETALES_LV32, DARK_NINETALES, MOLTRES_LV35
	.arcanine_lv34
	blackbox_promo_recipe NINETALES_LV32, ARCANINE_LV45
	.nonpromo_charizard_lv76
	blackbox_promo_recipe DARK_CHARIZARD, DARK_NINETALES
	.pikachu_lv13
	blackbox_promo_recipe RAICHU_LV40, RAICHU_LV45, RAICHU_LV32, DARK_RAICHU
	.pikachu_lv16
	blackbox_promo_recipe RAICHU_LV40, RAICHU_LV45, RAICHU_LV32
	.zapdos_lv68
	blackbox_promo_recipe RAICHU_LV40, DARK_RAICHU, ZAPDOS_LV64
	.pikachu_alt_lv16
	blackbox_promo_recipe ELECTRODE_LV35, ELECTRODE_LV42, MAGNETON_LV28, MAGNETON_LV35
	.electabuzz_lv20
	blackbox_promo_recipe ELECTABUZZ_LV35, MAGNETON_LV30, MAGNETON_LV28, MAGNETON_LV35
	.articuno_lv37
	blackbox_promo_recipe POLIWRATH_LV40, KINGLER_LV33, ARTICUNO_LV35
	.magikarp_lv10
	blackbox_promo_recipe GYARADOS, DARK_GYARADOS
	.blastoise_alt_lv52
	blackbox_promo_recipe DARK_BLASTOISE, DARK_GYARADOS
	.venusaur_alt_lv67
	blackbox_promo_recipe DARK_VILEPLUME, DARK_VENUSAUR
	.grs_mewtwo
	blackbox_promo_recipe MEW_LV23, MEWTWO_LV53, MEWTWO_LV67
	.mewtwo_alt_lv60
	blackbox_promo_recipe MEW_LV23, MEWTWO_LV67
	.mewtwo_lv60
	blackbox_promo_recipe MEW_LV23, MEWTWO_LV53
	.mewtwo_lv30
	blackbox_promo_recipe MEWTWO_LV53, MEWTWO_LV67
	.slowpoke_lv9
	blackbox_promo_recipe ALAKAZAM_LV42, GENGAR_LV38, MR_MIME_LV28
	.super_energy_retrieval
	blackbox_promo_recipe POLIWRATH_LV40, DRAGONAIR
	.dark_persian_alt_lv28
	blackbox_promo_recipe CHANSEY_LV55, CLEFABLE, WIGGLYTUFF_LV36
	.jigglypuff_lv12
	blackbox_promo_recipe CHANSEY_LV55, CLEFAIRY_LV14
	.kangaskhan_lv38
	blackbox_promo_recipe KANGASKHAN_LV40, DRAGONAIR
	.farfetchd_alt_lv20
	blackbox_promo_recipe PIDGEOT_LV38, CLEFAIRY_LV14, DITTO
	.dragonite_lv41
	blackbox_promo_recipe DRAGONITE_LV45, DARK_DRAGONITE, DRAGONAIR
	; impossible, recipes mustn't require promos
.nonpromo_dragonite_lv45
	blackbox_promo_recipe DRAGONITE_LV45, DARK_DRAGONITE, DRAGONITE_LV41
	.meowth_lv14
	blackbox_promo_recipe DITTO, SNORLAX_LV20
	.hungry_snorlax
	blackbox_promo_recipe SNORLAX_LV20, SNORLAX_LV35
	.cool_porygon
	blackbox_promo_recipe DITTO, CLEFABLE
	
; phantoms, ishihara tradings, and game center prizes
; but a few exceptions
SpecialPromoCards:
	dw VENUSAUR_LV64
	dw MARILL
	dw OMASTAR_LV36
	dw GOLEM_LV37
	dw MACHAMP_LV54
	dw ALAKAZAM_LV45
	dw GENGAR_LV40
	dw MEWTWO_LV30 ; weird, out of the pattern
	dw MEW_LV15
	dw MEW_LV8
	dw SURFING_PIKACHU_LV13
	dw SURFING_PIKACHU_ALT_LV13
	dw FLYING_PIKACHU_LV12
	dw FLYING_PIKACHU_ALT_LV12
	dw DRAGONITE_LV43 ; weird, out of the pattern
	dw TOGEPI
	dw LUGIA
	dw HERE_COMES_TEAM_ROCKET
	dw IMAKUNI_CARD
	dw COMPUTER_ERROR
	dw 0
; 0x447b0

SECTION "Bank 11@4928", ROMX[$4928], BANK[$11]

; a = MUSIC_*
PlayAfterCurrentSong:
	ld b, a
	ld a, [wCurMusic]
	cp b
	jr nz, .play_song
	push bc
	call AssertSongFinished
	pop bc
	or a
	jr z, .play_song
	ret

.play_song
	ld a, b
	ld [wCurMusic], a
	ld [wdd04], a
	call PlaySong
	ret

PlayCurrentSong:
	ld a, [wCurMusic]
	call PlaySong
	ret

; WaitForSongToFinish but without push/pop af
WaitSong:
.loop
	call DoFrame
	call AssertSongFinished
	or a
	jr nz, .loop
	ret

InitMusicFadeOut:
	ld [wMusicFadeOutCounter], a
	ld [wMusicFadeOutDuration], a
	ld a, c
	ld [wMusicFadeOutVolume], a
	call SetVolume
	ret

TickMusicFadeOut:
	ld a, [wMusicFadeOutCounter]
	dec a
	ld [wMusicFadeOutCounter], a
	jr nz, .done
	ld a, [wMusicFadeOutDuration]
	ld [wMusicFadeOutCounter], a
	ld a, [wMusicFadeOutVolume]
	or a
	jr z, .done
	dec a
	ld [wMusicFadeOutVolume], a
	call SetVolume
.done
	ret

MusicFadeOut:
.loop
	call DoFrame
	call TickMusicFadeOut
	ld a, [wMusicFadeOutVolume]
	or a
	jr nz, .loop
	ret
; 0x4498c

SECTION "Bank 11@499e", ROMX[$499e], BANK[$11]

WaitForSFXToFinish::
.loop_wait
	call DoFrame
	call AssertSFXFinished
	or a
	jr nz, .loop_wait
	ret
; 0x449a8

SECTION "Bank 11@5301", ROMX[$5301], BANK[$11]

Func_45301:
	or a
	jr nz, .asm_4531b
	ld a, $2c
	ld [wRemainingIntroCards], a
	ld a, $b0
	ld [wFilteredListPtr], a
	ld a, $47
	ld [wFilteredListPtr+1], a
	ld a, VAR_28
	farcall GetVarValue
	jr .asm_45330
.asm_4531b
	ld a, $1b
	ld [wRemainingIntroCards], a
	ld a, $60
	ld [wFilteredListPtr], a
	ld a, $48
	ld [wFilteredListPtr+1], a
	ld a, VAR_30
	farcall GetVarValue
.asm_45330
	cp $03
	jr z, .asm_4533a
	jr nc, .asm_4533e
	ld a, $00
	jr .asm_45340
.asm_4533a
	ld a, $01
	jr .asm_45340
.asm_4533e
	ld a, $02
.asm_45340
	ld [wd578], a
	ld e, $03
	ld d, VAR_2D
	ld c, $ff
.asm_45349
	ld a, d
	farcall SetVarValue
	inc d
	dec e
	jr nz, .asm_45349
	ld c, $00
.asm_45354
	ld b, $01
	ld a, c
	or a
.asm_45358
	jr z, .asm_4535f
	sla b
	dec a
	jr .asm_45358
.asm_4535f
	call Func_45379
	call Func_453a3
	jr c, .asm_4535f
	push bc
	ld d, a
	ld a, VAR_2D
	add c
	ld c, d
	farcall SetVarValue
	pop bc
	inc c
	ld a, $03
	cp c
	jr nz, .asm_45354
	ret

Func_45379:
.asm_45379
	ld a, [wd578]
	ld d, a
	ld a, [wFilteredListPtr]
	ld l, a
	ld a, [wFilteredListPtr+1]
	ld h, a
	ld a, [wRemainingIntroCards]
	call Random
	sla a
	sla a
	add l
	ld l, a
	jr nc, .asm_45394
	inc h
.asm_45394
	push hl
	inc hl
	ld a, d
	add l
	ld l, a
	jr nc, .asm_4539c
	inc h
.asm_4539c
	ld a, [hl]
	pop hl
	and b
	jr z, .asm_45379
	ld a, [hl]
	ret

Func_453a3:
	ld d, a
	farcall LoadNPCDuelistDeck
	ld l, a
	ld e, VAR_2D
.asm_453ab
	ld a, e
	farcall GetVarValue
	cp $ff
	jr z, .asm_453bf
	farcall LoadNPCDuelistDeck
	inc e
	cp l
	jr nz, .asm_453ab
	ld a, d
	scf
	ret
.asm_453bf
	ld a, d
	scf
	ccf
	ret

Func_453c3:
	farcall LoadNPCDuelistDeck
	cp $1a
	jr nz, .asm_453cd
	ld a, $19
.asm_453cd
	ret

Func_453ce:
	ld a, VAR_2C
	farcall GetVarValue
	ld c, a
	dec c
	ld a, VAR_2D
	add c
	farcall GetVarValue
	farcall LoadNPCDuelistDeck
	farcall LoadNPCDuelist
	ld a, [wCurrentNPCDuelistData + NPC_DUELIST_STRUCT_DIALOG_NAME]
	ld l, a
	ld a, [wCurrentNPCDuelistData + NPC_DUELIST_STRUCT_DIALOG_NAME + 1]
	ld h, a
	call LoadTxRam2
	ld a, l
	ld [wTxRam2_b], a
	ld a, h
	ld [wTxRam2_b + 1], a
	ret

Func_453f9:
	ld a, VAR_2C
	farcall GetVarValue
	dec a
	ld c, a
	ld a, VAR_2D
	add c
	farcall GetVarValue
	ld [wNPCDuelDeckID], a
	ld a, MUSIC_MATCH_START_CLUB_MASTER
	ld [wDuelStartTheme], a
	ld hl, wd583
	set 1, [hl]
	ret

Func_45416:
	ld e, $07
	ld d, VAR_14
	ld c, $ff
.asm_4541c
	ld a, d
	farcall SetVarValue
	inc d
	dec e
	jr nz, .asm_4541c
	ld c, $00
.asm_45427
	ld b, $01
	ld a, c
	or a
.asm_4542b
	jr z, .asm_45432
	sla b
	dec a
	jr .asm_4542b
.asm_45432
	call Func_4544c
	call Func_45464
	jr c, .asm_45432
	push bc
	ld d, a
	ld a, VAR_14
	add c
	ld c, d
	farcall SetVarValue
	pop bc
	inc c
	ld a, $07
	cp c
	jr nz, .asm_45427
	ret

Func_4544c:
.asm_4544c
	ld hl, $48cc
	ld a, $09
	call Random
	sla a
	add l
	ld l, a
	jr nc, .asm_4545b
	inc h
.asm_4545b
	push hl
	inc hl
	ld a, [hl]
	pop hl
	and b
	jr z, .asm_4544c
	ld a, [hl]
	ret

Func_45464:
	ld d, a
	farcall LoadNPCDuelistDeck
	ld l, a
	ld e, VAR_14
.asm_4546c
	ld a, e
	farcall GetVarValue
	cp $ff
	jr z, .asm_45480
	farcall LoadNPCDuelistDeck
	inc e
	cp l
	jr nz, .asm_4546c
	ld a, d
	scf
	ret
.asm_45480
	ld a, d
	scf
	ccf
	ret

Func_45484:
	call Func_453c3
	ret

Func_45488:
	ld a, VAR_0E
	farcall GetVarValue
	cp $02
	jr z, .asm_4549c
	jr nc, .asm_454a4
	ld a, VAR_14
	farcall GetVarValue
	jr .asm_454aa
.asm_4549c
	ld a, VAR_1B
	farcall GetVarValue
	jr .asm_454aa
.asm_454a4
	ld a, VAR_1E
	farcall GetVarValue
.asm_454aa
	ret

Func_454ab:
	call Func_45488
	ld [wNPCDuelDeckID], a
	ld a, MUSIC_MATCH_START_CLUB_MASTER
	ld [wDuelStartTheme], a
	ld hl, wd583
	set 1, [hl]
	ret

Func_454bc:
	call Func_45488
	farcall LoadNPCDuelistDeck
	farcall LoadNPCDuelist
	ld a, [wCurrentNPCDuelistData + NPC_DUELIST_STRUCT_LOCATION_NAME]
	ld l, a
	ld a, [wCurrentNPCDuelistData + NPC_DUELIST_STRUCT_LOCATION_NAME + 1]
	ld h, a
	call LoadTxRam2
	ld a, [wCurrentNPCDuelistData + NPC_DUELIST_STRUCT_DIALOG_NAME]
	ld l, a
	ld a, [wCurrentNPCDuelistData + NPC_DUELIST_STRUCT_DIALOG_NAME + 1]
	ld h, a
	ld a, l
	ld [wTxRam2_b], a
	ld a, h
	ld [wTxRam2_b + 1], a
	ret

Func_454e3:
	call Func_45488
	farcall LoadNPCDuelistDeck
	farcall LoadNPCDuelist
	ld a, [wCurrentNPCDuelistData + NPC_DUELIST_STRUCT_DIALOG_NAME]
	ld l, a
	ld a, [wCurrentNPCDuelistData + NPC_DUELIST_STRUCT_DIALOG_NAME + 1]
	ld h, a
	call LoadTxRam2
	ret

Func_454fa:
	ld a, VAR_15
	farcall GetVarValue
	ld c, a
	call UpdateRNGSources
	rrca
	jr nc, .asm_4550e
	ld a, VAR_16
	farcall GetVarValue
	ld c, a
.asm_4550e
	ld a, VAR_1B
	farcall SetVarValue
	ld a, VAR_17
	farcall GetVarValue
	ld c, a
	call UpdateRNGSources
	rrca
	jr nc, .asm_45528
	ld a, VAR_18
	farcall GetVarValue
	ld c, a
.asm_45528
	ld a, VAR_1C
	farcall SetVarValue
	ld a, VAR_1A
	farcall GetVarValue
	ld c, a
	farcall LoadNPCDuelistDeck
	cp $03
	jr z, .asm_4554a
	call UpdateRNGSources
	rrca
	jr c, .asm_4554a
	ld a, VAR_19
	farcall GetVarValue
	ld c, a
.asm_4554a
	ld a, VAR_1D
	farcall SetVarValue
	ld a, VAR_1D
	farcall GetVarValue
	ld c, a
	farcall LoadNPCDuelistDeck
	cp $03
	jr z, .asm_4556c
	call UpdateRNGSources
	rrca
	jr c, .asm_4556c
	ld a, VAR_1C
	farcall GetVarValue
	ld c, a
.asm_4556c
	ld a, VAR_1E
	farcall SetVarValue
	ret

Func_45573:
	farcall Func_1ea00
	ld a, VAR_14
	ld c, $01
.asm_4557b
	push af
	push bc
	farcall GetVarValue
	farcall LoadNPCDuelistDeck
	farcall LoadNPCDuelist
	ld a, [wCurrentNPCDuelistData + NPC_DUELIST_STRUCT_DIALOG_NAME]
	ld l, a
	ld a, [wCurrentNPCDuelistData + NPC_DUELIST_STRUCT_DIALOG_NAME + 1]
	ld h, a
	pop bc
	ld a, c
	farcall Func_1e9ea
	inc c
	ld a, $08
	cp c
	jr z, .asm_455a1
	pop af
	inc a
	jr .asm_4557b
.asm_455a1
	pop af
	ret

Func_455a3:
	ld a, VAR_0E
	farcall GetVarValue
	cp $01
	jp c, .asm_45658
	jr z, .asm_455f0
	cp $02
	jr z, .asm_455c8
	ld a, EVENT_SET_UNTIL_MAP_RELOAD_2
	farcall GetEventValue
	ld c, $06
	jr z, .asm_455c2
	ld a, $01
	jr .asm_455c4
.asm_455c2
	ld a, $02
.asm_455c4
	farcall Func_1ea4c
.asm_455c8
	ld c, $04
	ld a, $01
	farcall Func_1ea4c
	ld c, $05
	ld a, $01
	farcall Func_1ea4c
	ld a, VAR_1C
	farcall GetVarValue
	ld c, a
	ld a, VAR_1E
	farcall GetVarValue
	cp c
	jr z, .asm_455f0
	ld c, $05
	ld a, $02
	farcall Func_1ea4c
.asm_455f0
	ld c, $00
	ld a, $01
	farcall Func_1ea4c
	ld c, $01
	ld a, $01
	farcall Func_1ea4c
	ld a, VAR_15
	farcall GetVarValue
	ld c, a
	ld a, VAR_1B
	farcall GetVarValue
	cp c
	jr z, .asm_45618
	ld c, $01
	ld a, $02
	farcall Func_1ea4c
.asm_45618
	ld c, $02
	ld a, $01
	farcall Func_1ea4c
	ld a, VAR_17
	farcall GetVarValue
	ld c, a
	ld a, VAR_1C
	farcall GetVarValue
	cp c
	jr z, .asm_45638
	ld c, $02
	ld a, $02
	farcall Func_1ea4c
.asm_45638
	ld c, $03
	ld a, $01
	farcall Func_1ea4c
	ld a, VAR_19
	farcall GetVarValue
	ld c, a
	ld a, VAR_1D
	farcall GetVarValue
	cp c
	jr z, .asm_45658
	ld c, $03
	ld a, $02
	farcall Func_1ea4c
.asm_45658
	farcall Func_1e984
	ret

Func_4565d:
	push bc
	push de
	push hl
	or a
	jr nz, .asm_45668
	ld a, [wPlayerOWObject]
	jr .asm_45672
.asm_45668
	dec a
	add VAR_14
	farcall GetVarValue
	call Func_45484
.asm_45672
	pop hl
	pop de
	pop bc
	ret

Func_45676:
	push af
	push hl
	ld c, $10
	add c
	farcall GetVarValue
	ld hl, $48de
	sla a
	add l
	ld l, a
	jr nc, .asm_45689
	inc h
.asm_45689
	ld a, [hli]
	ld b, [hl]
	ld c, a
	pop hl
	pop af
	ret

Func_4568f:
	push af
	push bc
	push de
	call Func_45676
	ld e, c
	ld d, b
	farcall GetReceivingCardLongName
	pop de
	pop bc
	pop af
	ret

; calc black box output from input
ProcessBlackBoxInputAndOutput:
	ld hl, wCurDeckCards
	call TakeOutCardsInHLFromCollection
	ld a, PROMOTIONAL
	call CountCardsFromSetOfAInHL
	or a
	jr nz, .check_promo
; no promo
	call CheckIfAllIdenticalCardsInHL
	jr c, .check_evo_line ; empty or different
	call CountCardsInHL
	cp 2
	jr c, .check_evo_line ; only 1
; 2+ of a kind, nothing else
	call ProcessBlackBoxInputAndOutput_AllDupes
	jr .done

.check_evo_line
	ld hl, wCurDeckCards
	call CheckIfEvoLineInHL
	jr c, .check_rarity
; evo line
	call ProcessBlackBoxInputAndOutput_EvoLine
	jr .done

.check_rarity
	ld a, STAR
	ld hl, wCurDeckCards
	call CheckIfAllIdenticalRarityInHL
	jr c, .check_promo
; star cards
	call ProcessBlackBoxInputAndOutput_Stars
	jr .done

; has promo, or different cards of different rarities
.check_promo
	call ProcessBlackBoxInputAndOutput_Regular

.done
	ret

; 2+ of a kind, nothing else
ProcessBlackBoxInputAndOutput_AllDupes:
	ld hl, wCurDeckCards
	ld a, [hli]
	ld e, a
	ld a, [hld]
	ld d, a
	call LoadCardDataToBuffer1_FromCardID
	ld a, [wLoadedCard1Type]
	cp TYPE_ENERGY
	jr c, .non_energy
	cp TYPE_TRAINER
	jr z, .non_energy
; energy
	call ProcessBlackBoxInputAndOutput_ReturnAll
	jp .done

.non_energy
	call CountCardsInHL
	push af
	cp MAX_NUM_BLACK_BOX_INPUT
	jr nz, .not_five_or_nonstar
; 5 of a kind
	ld a, [wLoadedCard1Rarity]
	cp STAR
	jr c, .not_five_or_nonstar

; 5 of a kind & star+
; 50% super bonus : 50% whiff
	pop af
	call GetBlackBoxOutputBonusFlag
	or a
	jr nz, .output_super_bonus
	jr .whiffed_return_1

.output_super_bonus
	call ListUniqueEvoCardsFromDE
	jr nc, .output_super_bonus_no_evo
; has evo
; return 3 copies of a random card of the input's evo
; if no non-promo candidates, whiff
	ld hl, wDuelTempList
	call ExcludePromoCardsFromHLAndUpdateLengthCount
	call ExcludeSpecialPromoCardsFromHLAndUpdateLengthCount
	or a
	jr z, .whiffed_return_1
	call Random
	sla a
	add l
	ld l, a
	jr nc, .output_super_bonus_got_1_evo
	inc h
.output_super_bonus_got_1_evo
	ld a, [hli]
	ld e, a
	ld d, [hl]
	ld hl, wBlackBoxCardReceived
	ld c, 3
.loop_fill_3
	ld a, e
	ld [hli], a
	ld a, d
	ld [hli], a
	dec c
	jr nz, .loop_fill_3
; append $0000-terminator
	xor a
	ld [hli], a
	ld [hl], a
	jp .done

; no evo
; return 5 copies of a random star card of the input's type
; if no non-promo candidates, whiff
.output_super_bonus_no_evo
	call LoadCardDataToBuffer1_FromCardID
	ld a, [wLoadedCard1Type]
	ld b, a
	ld c, STAR
	call ListUniqueCardsOfTheSameTypeAndRarity
	ld hl, wDuelTempList
	call ExcludePromoCardsFromHLAndUpdateLengthCount
	call ExcludeSpecialPromoCardsFromHLAndUpdateLengthCount
	or a
	jr z, .whiffed_return_1
	call Random
	sla a
	add l
	ld l, a
	jr nc, .output_super_bonus_got_1_star
	inc h
.output_super_bonus_got_1_star
	ld a, [hli]
	ld e, a
	ld d, [hl]
	ld hl, wBlackBoxCardReceived
	ld c, 5
.loop_fill_5
	ld a, e
	ld [hli], a
	ld a, d
	ld [hli], a
	dec c
	jr nz, .loop_fill_5
; append $0000 terminator
	xor a
	ld [hli], a
	ld [hl], a
	jr .done

; (count)*10% bonus : otherwise whiff
.not_five_or_nonstar
	pop af
	call GetBlackBoxOutputBonusFlag
	or a
	jr nz, .output_bonus

.whiffed_return_1
	ld hl, wCurDeckCards
	ld a, [hli]
	ld e, a
	ld d, [hl]
	ld hl, wBlackBoxCardReceived
	ld a, e
	ld [hli], a
	ld a, d
	ld [hli], a
; append $0000 terminator
	xor a
	ld [hli], a
	ld [hl], a
	jr .done

.output_bonus
	call ListUniqueEvoCardsFromDE
	jr nc, .output_bonus_no_evo
; has evo
; return 1 copy of a random card of the input's evo
; if no non-promo candidates, whiff
	ld hl, wDuelTempList
	call ExcludePromoCardsFromHLAndUpdateLengthCount
	call ExcludeSpecialPromoCardsFromHLAndUpdateLengthCount
	or a
	jr z, .whiffed_return_1
	call Random
	sla a
	add l
	ld l, a
	jr nc, .output_bonus_got_1_evo
	inc h
.output_bonus_got_1_evo
	ld a, [hli]
	ld e, a
	ld d, [hl]
	ld hl, wBlackBoxCardReceived
	ld a, e
	ld [hli], a
	ld a, d
	ld [hli], a
; append $0000 terminator
	xor a
	ld [hli], a
	ld [hl], a
	jr .done

; no evo
; return 1 copy of a random star card of the input's type
; if no non-promo candidates, whiff
.output_bonus_no_evo
	call LoadCardDataToBuffer1_FromCardID
	ld a, [wLoadedCard1Type]
	ld b, a
	ld c, STAR
	call ListUniqueCardsOfTheSameTypeAndRarity
	ld hl, wDuelTempList
	call ExcludePromoCardsFromHLAndUpdateLengthCount
	call ExcludeSpecialPromoCardsFromHLAndUpdateLengthCount
	or a
	jr z, .whiffed_return_1
	call Random
	sla a
	add l
	ld l, a
	jr nc, .output_bonus_no_evo_got_1_star
	inc h
.output_bonus_no_evo_got_1_star
	ld a, [hli]
	ld e, a
	ld d, [hl]
	ld hl, wBlackBoxCardReceived
	ld a, e
	ld [hli], a
	ld a, d
	ld [hli], a
	xor a
	ld [hli], a
	ld [hl], a
.done
	ret

ProcessBlackBoxInputAndOutput_EvoLine:
	call GetBlackBoxEvoLineOutputCountAndScore
	cp 1
	jr z, .score_1
	jr nz, .score_0_or_2

; unreachable part
; list basic cards of the evo line
; glad this devolution-thingy doesn't exist!
	ld hl, wTempBlackBoxInputBasic
	ld a, [hli]
	ld e, a
	ld d, [hl]
	or d
	jr z, .no_basic_input
	call ListUniqueCardsOfTheSameName
	jr .output
.no_basic_input
	ld hl, wTempBlackBoxInputStage1
	ld a, [hli]
	ld e, a
	ld d, [hl]
	call ListUniquePreEvoCardsFromDE
	jr .output

; list stage1 cards of the evo line
.score_1
	ld hl, wTempBlackBoxInputStage1
	ld a, [hli]
	ld e, a
	ld d, [hl]
	or d
	jr z, .no_stage1_input
	call ListUniqueCardsOfTheSameName
	jr .output
.no_stage1_input
	ld hl, wTempBlackBoxInputBasic
	ld a, [hli]
	ld e, a
	ld d, [hl]
	call ListUniqueEvoCardsFromDE ; this may include both dark and non-dark
	jr .output

; list stage2 cards of the evo line
.score_0_or_2
	ld hl, wTempBlackBoxInputStage2
	ld a, [hli]
	ld e, a
	ld d, [hl]
	or d
	jr z, .no_stage2_input
	call ListUniqueCardsOfTheSameName
	jr .output
.no_stage2_input
	ld hl, wTempBlackBoxInputStage1
	ld a, [hli]
	ld e, a
	ld d, [hl]
	call ListUniqueEvoCardsFromDE

; return c copies of a random card from the list
; if no non-promo candidates, return all input cards
.output
	ld hl, wDuelTempList
	call ExcludePromoCardsFromHLAndUpdateLengthCount
	call ExcludeSpecialPromoCardsFromHLAndUpdateLengthCount
	or a
	jr z, .return_all
	call Random
	sla a
	add l
	ld l, a
	jr nc, .got_1_card
	inc h
.got_1_card
	ld a, [hli]
	ld e, a
	ld d, [hl]
	ld hl, wBlackBoxCardReceived
.loop_fill_c
	ld a, e
	ld [hli], a
	ld a, d
	ld [hli], a
	dec c
	jr nz, .loop_fill_c

; append $0000 terminator
	xor a
	ld [hli], a
	ld [hl], a
.done
	ret

.return_all
	call ProcessBlackBoxInputAndOutput_ReturnAll
	jr .done

; star cards of 2+ kinds
ProcessBlackBoxInputAndOutput_Stars:
; init output
	xor a
	ld hl, wBlackBoxCardReceived
	ld [hli], a
	ld [hl], a
; check promo recipe
	ld hl, BlackboxPromoCards
.loop_promo_recipes
	ld a, [hli]
	ld c, a
	ld a, [hli]
	ld b, a
	or c
	jr z, .return_rest
	push hl
	ld hl, wCurDeckCards
	call CheckIfListInBCIsSubsetOfListInHL
	pop hl
	jr c, .next_promo_recipe
; input contains promo recipe, but is it locked to post-game?
	ld a, [hli] ; locked-to-post-game flag
	or a
	jr z, .valid_recipe
; check if post-game
	ld a, EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE
	farcall GetEventValue
	jr z, .next_promo_recipe_after_flag ; locked to post-game
; the current recipe is valid
; append it to output and remove the recipe cards from input
.valid_recipe
	ld a, [hli]
	ld e, a
	ld a, [hld]
	ld d, a
	push hl
	ld hl, wBlackBoxCardReceived
	call AppendCardToListInHL
	ld hl, wCurDeckCards
	call RemoveCardsInBCFromHL
; check the current recipe again
	pop hl
	dec hl
	dec hl
	dec hl
	jr .loop_promo_recipes
.next_promo_recipe
	inc hl
.next_promo_recipe_after_flag
	inc hl
	inc hl
	jr .loop_promo_recipes

.return_rest
	ld hl, wCurDeckCards
.loop_return
	ld a, [hli]
	ld e, a
	ld a, [hli]
	ld d, a
	or e
	jr z, .done
	push hl
	ld hl, wBlackBoxCardReceived
	call AppendCardToListInHL
	pop hl
	jr .loop_return
.done
	ret

; has promo, or different cards of different rarities
ProcessBlackBoxInputAndOutput_Regular:
; init output
	xor a
	ld hl, wBlackBoxCardReceived
	ld [hli], a
	ld [hl], a
; return all promo, star+, and non-pkmn cards
	ld hl, wCurDeckCards
.loop_cards_1
	ld a, [hli]
	ld e, a
	ld a, [hli]
	ld d, a
	or e
	jr z, .calc_score
	call LoadCardDataToBuffer1_FromCardID
	ld a, [wLoadedCard1Type]
	cp TYPE_ENERGY
	jr nc, .return_promo_and_star_and_nonpkmn
	ld a, [wLoadedCard1Set]
	cp PROMOTIONAL
	jr z, .return_promo_and_star_and_nonpkmn
	ld a, [wLoadedCard1Rarity]
	cp STAR
	jr c, .loop_cards_1
.return_promo_and_star_and_nonpkmn
	push hl
	ld hl, wBlackBoxCardReceived
	call AppendCardToListInHL
	pop hl
	jr .loop_cards_1

; input cards rarity score:
;   0 per non-pkmn
;   1 per circle pkmn
;   2 per promo/star+ pkmn
;   3 per diamond pkmn
.calc_score
	ld hl, wCurDeckCards
	ld c, 0
.loop_cards_2
	ld a, [hli]
	ld e, a
	ld a, [hli]
	ld d, a
	or e
	jr z, .check_score
	call LoadCardDataToBuffer1_FromCardID
	ld a, [wLoadedCard1Type]
	cp TYPE_ENERGY
	jr nc, .loop_cards_2 ; score0
	ld a, [wLoadedCard1Set]
	cp PROMOTIONAL
	jr z, .score2
	ld a, [wLoadedCard1Rarity]
	cp DIAMOND
	jr z, .score3
	jr nc, .score2
; score1
	inc c
	jr .loop_cards_2
.score3
	inc c
	inc c
	inc c
	jr .loop_cards_2
.score2
	inc c
	inc c
	jr .loop_cards_2

.check_score
; init buffer
	xor a
	ld hl, wBlackBoxOutputCountCircle
	ld [hli], a
	ld [hli], a
	ld [hl], a
	ld a, c
	cp 11
	jr nc, .scored_11_or_more
	cp 6
	jr nc, .scored_6_to_10
	cp 2
	jr nc, .scored_2_to_5

; input score = 0, 1
; return the circle pkmn as well
; (.return_promo_and_star_and_nonpkmn has already decided to return all non-pkmn cards)
	ld hl, wCurDeckCards
.loop_cards_3
	ld a, [hli]
	ld e, a
	ld a, [hli]
	ld d, a
	or e
	jp z, .done
	call LoadCardDataToBuffer1_FromCardID
	ld a, [wLoadedCard1Type]
	cp TYPE_PKMN
	jr nc, .loop_cards_3
	ld a, [wLoadedCard1Set]
	cp PROMOTIONAL
	jr z, .loop_cards_3 ; impossible
	ld a, [wLoadedCard1Rarity]
	cp STAR
	jp nc, .loop_cards_3 ; impossible
	push hl
	ld hl, wBlackBoxCardReceived
	call AppendCardToListInHL
	pop hl
	jr .loop_cards_3

; input score = [2, 5]
; for the index n = [0, 3] by rng check,
; output count (circle, star, diamond):
;   n = 0: 1, 0, 0
;   n = 1: 3, 0, 0
;   n = 2: 0, 2, 0
;   n = 3: 0, 0, 1
.scored_2_to_5
	call GetBlackBoxOutputIndex
	inc a
	ld c, a
	ld hl, wBlackBoxOutputCountCircle
	ld a, 1
	ld [hl], a
	dec c
	jr z, .output
	ld a, 3
	ld [hl], a
	dec c
	jr z, .output
	xor a
	ld [hli], a
	ld a, 2
	ld [hl], a
	dec c
	jr z, .output
	xor a
	ld [hli], a
	ld a, 1
	ld [hl], a
	jr .output

; input score = [6, 10]
; (particularly useful, as inputting 5 promo pkmn yields score 10)
; for the index n = [0, 3] by rng check,
; output count (circle, star, diamond):
;   n = 0: 5, 0, 0
;   n = 1: 0, 3, 0
;   n = 2: 0, 0, 1
;   n = 3: 0, 0, 2
.scored_6_to_10
	call GetBlackBoxOutputIndex
	inc a
	ld c, a
	ld hl, wBlackBoxOutputCountCircle
	ld a, 5
	ld [hl], a
	dec c
	jr z, .output
	xor a
	ld [hli], a
	ld a, 3
	ld [hl], a
	dec c
	jr z, .output
	xor a
	ld [hli], a
	ld a, 1
	ld [hl], a
	dec c
	jr z, .output
	inc [hl]
	jr .output

; input score = 11 or more
; for the index n = [0, 3] by rng check,
; output count (circle, star, diamond):
;   n = 0: 0, 3, 0
;   n = 1: 0, 0, 1
;   n = 2: 0, 3, 1
;   n = 3: 0, 0, 3
.scored_11_or_more
	call GetBlackBoxOutputIndex
	inc a
	ld c, a
	ld hl, wBlackBoxOutputCountDiamond
	ld a, 3
	ld [hl], a
	dec c
	jr z, .output
	xor a
	ld [hli], a
	ld a, 1
	ld [hl], a
	dec c
	jr z, .output
	dec hl
	ld a, 3
	ld [hl], a
	dec c
	jr z, .output
	xor a
	ld [hli], a
	ld a, 3
	ld [hl], a

; TYPE_TRAINER is the default card type in b
; so that inputting 5 cards of unique types can yields trainer card(s)
.output
	ld a, [wBlackBoxOutputCountCircle]
	or a
	jr z, .output_diamond

; output circle
	lb bc, TYPE_TRAINER, CIRCLE
	ld hl, wCurDeckCards
	call CountUniquePkmnTypesInHL
	cp MAX_NUM_BLACK_BOX_INPUT
	jr z, .list_circle
	call GetMostFrequentPkmnTypeInHL
	ld b, a
.list_circle
	call ListUniqueCardsOfTheSameTypeAndRarity
	ld hl, wDuelTempList
	call ExcludePromoCardsFromHLAndUpdateLengthCount
	call ExcludeSpecialPromoCardsFromHLAndUpdateLengthCount
	or a
	jp z, .return_all_and_bonus_rainbow_energy
	ld b, a
	ld a, [wBlackBoxOutputCountCircle]
	ld c, a
.loop_random_pick_circle
	ld a, b
	call Random
	sla a
	ld hl, wDuelTempList
	add l
	ld l, a
	jr nc, .append_circle
	inc h
.append_circle
	ld a, [hli]
	ld e, a
	ld d, [hl]
	ld hl, wBlackBoxCardReceived
	call AppendCardToListInHL
	dec c
	jr nz, .loop_random_pick_circle

.output_diamond
	ld a, [wBlackBoxOutputCountDiamond]
	or a
	jr z, .output_star
	lb bc, TYPE_TRAINER, DIAMOND
	ld hl, wCurDeckCards
	call CountUniquePkmnTypesInHL
	cp MAX_NUM_BLACK_BOX_INPUT
	jr z, .list_diamond
	call GetMostFrequentPkmnTypeInHL
	ld b, a
.list_diamond
	call ListUniqueCardsOfTheSameTypeAndRarity
	ld hl, wDuelTempList
	call ExcludePromoCardsFromHLAndUpdateLengthCount
	call ExcludeSpecialPromoCardsFromHLAndUpdateLengthCount
	or a
	jr z, .return_all_and_bonus_rainbow_energy
	ld b, a
	ld a, [wBlackBoxOutputCountDiamond]
	ld c, a
.loop_random_pick_diamond
	ld a, b
	call Random
	sla a
	ld hl, wDuelTempList
	add l
	ld l, a
	jr nc, .append_diamond
	inc h
.append_diamond
	ld a, [hli]
	ld e, a
	ld d, [hl]
	ld hl, wBlackBoxCardReceived
	call AppendCardToListInHL
	dec c
	jr nz, .loop_random_pick_diamond

.output_star
	ld a, [wBlackBoxOutputCountStar]
	or a
	jr z, .done
	lb bc, TYPE_TRAINER, STAR
	ld hl, wCurDeckCards
	call CountUniquePkmnTypesInHL
	cp MAX_NUM_BLACK_BOX_INPUT
	jr z, .list_star
	call GetMostFrequentPkmnTypeInHL
	ld b, a
.list_star
	call ListUniqueCardsOfTheSameTypeAndRarity
	ld hl, wDuelTempList
	call ExcludePromoCardsFromHLAndUpdateLengthCount
	call ExcludeSpecialPromoCardsFromHLAndUpdateLengthCount
	or a
	jr z, .return_all_and_bonus_rainbow_energy
	ld b, a
	ld a, [wBlackBoxOutputCountStar]
	ld c, a
.loop_random_pick_star
	ld a, b
	call Random
	sla a
	ld hl, wDuelTempList
	add l
	ld l, a
	jr nc, .append_star
	inc h
.append_star
	ld a, [hli]
	ld e, a
	ld d, [hl]
	ld hl, wBlackBoxCardReceived
	call AppendCardToListInHL
	dec c
	jr nz, .loop_random_pick_star

.done
	ret

.return_all_and_bonus_rainbow_energy
	call ProcessBlackBoxInputAndOutput_ReturnAll
	ld hl, wBlackBoxCardReceived
	ld de, RAINBOW_ENERGY
	call AppendCardToListInHL
	jr .done

; rng check [0, 99] for a = card count [2, 5]
; succeeds if > .cutoffs[a-2], return TRUE
; ((100 - .cutoffs[a-2])% chance)
; otherwise FALSE
GetBlackBoxOutputBonusFlag:
	push bc
	push hl
	dec a
	dec a
	ld hl, .cutoffs
	add l
	ld l, a
	jr nc, .call_random
	inc h
.call_random
	ld c, [hl]
	ld a, 100
	call Random
	cp c
	jr c, .fail
; pass
	ld a, TRUE
	jr .done
.fail
	xor a
.done
	pop hl
	pop bc
	ret

.cutoffs:
	db 80 ; 2
	db 70 ; 3
	db 60 ; 4
	db 50 ; 5

; evo-line flag input in a:
;   0: BASIC | STAGE1 | STAGE2,
;   1: BASIC | STAGE1,
;   2: BASIC | STAGE2,
;   3: STAGE1 | STAGE2
; rng check [0, 99] against .cutoffs[a],
; then get n such that rng < .cutoffs[a][n], otherwise n = 2
; output:
;   count c = .ValueTable_n[a][0],
;   score a = .ValueTable_n[a][1]
GetBlackBoxEvoLineOutputCountAndScore:
	sla a
	push af
	ld hl, .cutoffs
	add l
	ld l, a
	jr nc, .call_random
	inc h
.call_random
	ld a, [hli]
	ld c, a
	ld b, [hl]
	ld a, 100
	call Random
	cp c
	jr c, .table0
	cp b
	jr c, .table1

; table2
	pop af
	ld hl, .ValueTable2
	add l
	ld l, a
	jr nc, .get_from_table2
	inc h
.get_from_table2
	ld a, [hli]
	ld c, a
	ld a, [hl]
	jr .done

.table1
	pop af
	ld hl, .ValueTable1
	add l
	ld l, a
	jr nc, .get_from_table1
	inc h
.get_from_table1
	ld a, [hli]
	ld c, a
	ld a, [hl]
	jr .done

.table0
	pop af
	ld hl, .ValueTable0
	add l
	ld l, a
	jr nc, .get_from_table0
	inc h
.get_from_table0
	ld a, [hli]
	ld c, a
	ld a, [hl]

.done
	ret

; e.g. {20, 70} -> 20% table0 : 50% table1 : 30% table2
.cutoffs:
	db 40,  80 ; 0
	db 50, 100 ; 1
	db 40,  80 ; 2
	db 20,  70 ; 3

; output count, output score
.ValueTable0:
	db 3, 0 ; 0
	db 2, 0 ; 1
	db 2, 0 ; 2
	db 2, 0 ; 3
.ValueTable1:
	db 3, 1 ; 0
	db 2, 1 ; 1
	db 2, 1 ; 2
	db 2, 1 ; 3
.ValueTable2:
	db 3, 2 ; 0
	db 0, 0 ; 1, impossible
	db 2, 2 ; 2
	db 2, 1 ; 3

; for a = input score [0, 15],
; rng check [0, 99] against .cutoffs[a],
; get n such that rng < .cutoffs[a][n],
; then return n in a
GetBlackBoxOutputIndex:
	push bc
	push de
	push hl
	sla a
	sla a
	ld hl, .cutoffs
	add l
	ld l, a
	jr nc, .rng_check
	inc h
.rng_check
	ld a, [hli] ; cutoff 0
	ld c, a
	ld a, [hli] ; cutoff 1
	ld b, a
	ld a, [hli] ; cutoff 2
	ld e, a
	ld a, [hli] ; cutoff 3 (terminator)
	ld d, a     ; unused
	ld l, 0
	ld a, 100
	call Random
	cp c
	jr c, .done
	inc l
	cp b
	jr c, .done
	inc l
	cp e
	jr c, .done
	inc l

.done
	ld a, l
	pop hl
	pop de
	pop bc
	ret

; e.g. {20, 70, 90, 100} -> 20% : 50% : 20% : 10%
.cutoffs:
; section 0, fillers
	db 100, 100, 100, 100 ; $0
	db 100, 100, 100, 100 ; $1
; section 1
	db  50,  90,  98, 100 ; $2
	db  40,  90,  98, 100 ; $3
	db  30,  80,  95, 100 ; $4
	db  25,  75,  92, 100 ; $5
; section 2
	db  50,  90,  98, 100 ; $6
	db  40,  90,  98, 100 ; $7
	db  30,  80,  95, 100 ; $8
	db  25,  75,  92, 100 ; $9
	db  20,  70,  90, 100 ; $a
; section 3
	db  50,  90,  98, 100 ; $b
	db  40,  90,  98, 100 ; $c
	db  30,  80,  95, 100 ; $d
	db  25,  75,  92, 100 ; $e
	db  20,  70,  90, 100 ; $f

; return carry if card ID in de is found in SpecialPromoCards
CheckIfSpecialPromoCard:
	push af
	push bc
	push de
	push hl
	ld c, e
	ld b, d
	ld hl, SpecialPromoCards
.loop_cards
	ld a, [hli]
	ld c, a
	ld a, [hli]
	ld b, a
	or c
	jr z, .not_found
	ld a, b
	cp d
	jr c, .next_card
	jr nz, .next_card
	ld a, c
	cp e
.next_card
	jr nz, .loop_cards

; found
	pop hl
	pop de
	pop bc
	pop af
	scf
	ret

.not_found
	pop hl
	pop de
	pop bc
	pop af
	scf
	ccf
	ret

; put back all wCurDeckCards (i.e. input) to wBlackBoxCardReceived
ProcessBlackBoxInputAndOutput_ReturnAll:
	push af
	push bc
	push de
	push hl
	ld hl, wCurDeckCards
	ld de, wBlackBoxCardReceived
	ld bc, 2 * (MAX_NUM_BLACK_BOX_INPUT + 1)
	call CopyDataHLtoDE_SaveRegisters
	pop hl
	pop de
	pop bc
	pop af
	ret

; unreferenced & bugged
; intended to count SpecialPromoCards in card list in hl
; but just return a = 0
Stubbed_CountSpecialPromoCardsInHL:
	push bc
	push de
	push hl
	ld c, 0
.loop_cards_in_list
	ld a, [hli]
	ld e, a
	ld a, [hli]
	ld d, a
	or e
	jr z, .done
	push bc
	push hl
	ld hl, SpecialPromoCards
.loop_promo
	ld a, [hli]
	ld c, a
	ld a, [hli]
	ld b, a
	or c
	jr z, .next_card_in_list
	ld a, b
	cp d
	jr c, .next_promo
	jr nz, .next_promo
	ld a, c
	cp e
.next_promo
	jr nz, .loop_promo
	pop hl
	pop bc
	inc c
	jr .loop_cards_in_list
.next_card_in_list
	pop hl
	pop bc
	jr .loop_cards_in_list
.done
; bug, must use c
; ld a, c
	pop hl
	pop de
	pop bc
	ret

; drop promo cards from card list in hl and shift the rest
; and update the list length in a
ExcludePromoCardsFromHLAndUpdateLengthCount:
	push bc
	push de
	push hl
	xor a
	ld c, a
.loop_cards
	ld a, [hli]
	ld e, a
	ld a, [hld]
	ld d, a
	or e
	jr z, .done
	call LoadCardDataToBuffer1_FromCardID
	ld a, [wLoadedCard1Set]
	cp PROMOTIONAL
	jr nz, .not_promo
; found promo
	push hl
	call .ExcludePromo
	pop hl
	jr .loop_cards
.not_promo
	inc hl
	inc hl
	inc c
	jr .loop_cards
.done
	ld a, c
	pop hl
	pop de
	pop bc
	ret

.ExcludePromo:
	push hl
	inc hl
	inc hl
	ld a, [hli]
	ld e, a
	ld d, [hl]
	pop hl
	ld a, e
	ld [hli], a
	ld a, d
	ld [hli], a
	or e
	ret z
	jr .ExcludePromo

; drop SpecialPromoCards from card list in hl and shift the rest
; and update the list length in a
; actually reduntant, as ExcludePromoCardsFromHLAndUpdateLengthCount
; already handles them
ExcludeSpecialPromoCardsFromHLAndUpdateLengthCount:
	push bc
	push de
	push hl
	xor a
	ld c, a
.loop_cards
	ld a, [hli]
	ld e, a
	ld a, [hld]
	ld d, a
	or e
	jr z, .done
	call CheckIfSpecialPromoCard
	jr nc, .not_special_promo
; found special promo
	push hl
	call .ExcludeSpecialPromo
	pop hl
	jr .loop_cards
.not_special_promo
	inc hl
	inc hl
	inc c
	jr .loop_cards
.done
	ld a, c
	pop hl
	pop de
	pop bc
	ret

.ExcludeSpecialPromo:
	push hl
	inc hl
	inc hl
	ld a, [hli]
	ld e, a
	ld d, [hl]
	pop hl
	ld a, e
	ld [hli], a
	ld a, d
	ld [hli], a
	or e
	ret z
	jr .ExcludeSpecialPromo

INCLUDE "engine/credits.asm"
