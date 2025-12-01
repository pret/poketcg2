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
