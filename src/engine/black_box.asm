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
	cp16bc_long de
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
	cp16bc_long de
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
; actually redundant, as ExcludePromoCardsFromHLAndUpdateLengthCount
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
