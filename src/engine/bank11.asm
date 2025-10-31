Func_44000:
	push af
	push de
	push hl
.asm_44003
	ld a, [hli]
	ld e, a
	ld a, [hli]
	ld d, a
	or e
	jr z, .asm_4400f
	call RemoveCardFromCollection
	jr .asm_44003
.asm_4400f
	pop hl
	pop de
	pop af
	ret

Func_44013:
	push bc
	push de
	push hl
	ld a, [hli]
	ld e, a
	ld a, [hli]
	ld d, a
	or e
	jr z, .asm_44030
.asm_4401d
	ld a, [hli]
	ld c, a
	ld a, [hli]
	ld b, a
	or c
	jr z, .asm_44033
	ld a, d
	cp b
	jr c, .asm_4402c
	jr nz, .asm_4402c
	ld a, e
	cp c
.asm_4402c
	jr nz, .asm_44030
	jr .asm_4401d
.asm_44030
	scf
	jr .asm_44035
.asm_44033
	scf
	ccf
.asm_44035
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
	jr z, .asm_44046
	inc c
	jr .loop
.asm_44046
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

Func_44070:
	push hl
	sla a
	add l
	ld l, a
	jr nc, .asm_44078
	inc h
.asm_44078
	call SearchCardInListInHL
	pop hl
	ret

Func_4407d:
	call CountCardsInHL
	cp $02
	jr z, .asm_4408a
	cp $03
	jr z, .asm_4408a
	scf
	ret
.asm_4408a
	push bc
	push de
	push hl
	push hl
	xor a
	ld hl, $d57c
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld [hli], a
	pop hl
.asm_44099
	ld a, [hli]
	ld e, a
	ld a, [hli]
	ld d, a
	or e
	jr z, .asm_440ca
	call LoadCardDataToBuffer1_FromCardID
	ld a, [wLoadedCard1Type]
	cp $08
	jp nc, .asm_4418a
	push hl
	ld hl, $d57c
	ld a, [wLoadedCard1Stage]
	sla a
	add l
	ld l, a
	jr nc, .asm_440b9
	inc h
.asm_440b9
	ld a, [hli]
	ld c, a
	ld a, [hld]
	or c
	push hl
	pop bc
	pop hl
	jp nz, .asm_4418a
	ld a, e
	ld [bc], a
	inc bc
	ld a, d
	ld [bc], a
	jr .asm_44099
.asm_440ca
	ld hl, $d57c
	ld a, [hli]
	ld e, a
	ld a, [hli]
	ld d, a
	or e
	jp z, .asm_4416d
	ld a, [hli]
	ld e, a
	ld a, [hli]
	ld d, a
	or e
	jr z, .asm_4412e
	ld a, [hli]
	ld e, a
	ld a, [hli]
	ld d, a
	or e
	jr z, .asm_44113
	ld hl, $d57c
	ld a, [hli]
	ld e, a
	ld a, [hli]
	ld d, a
	call Func_4427f
	jp nc, .asm_4418a
	ld a, [hli]
	ld e, a
	ld a, [hli]
	ld d, a
	push hl
	ld hl, wDuelTempList
	call SearchCardInListInHL
	pop hl
	jp c, .asm_4418a
	call Func_4427f
	jp nc, .asm_4418a
	ld a, [hli]
	ld e, a
	ld d, [hl]
	ld hl, wDuelTempList
	call SearchCardInListInHL
	jr c, .asm_4418a
	xor a
	jr .asm_44186
.asm_44113
	ld hl, $d57c
	ld a, [hli]
	ld e, a
	ld a, [hli]
	ld d, a
	call Func_4427f
	jr nc, .asm_4418a
	ld a, [hli]
	ld e, a
	ld d, [hl]
	ld hl, wDuelTempList
	call SearchCardInListInHL
	jr c, .asm_4418a
	ld a, $01
	jr .asm_44186
.asm_4412e
	ld hl, $d57c
	ld a, [hli]
	ld e, a
	ld a, [hli]
	ld d, a
	call Func_4427f
	jr nc, .asm_4418a
	inc hl
	inc hl
	ld a, [hli]
	ld e, a
	ld d, [hl]
	call LoadCardDataToBuffer1_FromCardID
	ld a, [wLoadedCard1PreEvoName]
	ld c, a
	ld a, [$cc3f]
	ld b, a
	ld hl, wDuelTempList
.asm_4414d
	ld a, [hli]
	ld e, a
	ld a, [hli]
	ld d, a
	or e
	jr z, .asm_4418a
	call LoadCardDataToBuffer1_FromCardID
	ld a, [wLoadedCard1Name]
	ld e, a
	ld a, [$cc36]
	ld d, a
	ld a, d
	cp b
	jr c, .asm_44167
	jr nz, .asm_44167
	ld a, e
	cp c
.asm_44167
	jr nz, .asm_4414d
	ld a, $02
	jr .asm_44186
.asm_4416d
	ld hl, $d57e
	ld a, [hli]
	ld e, a
	ld a, [hli]
	ld d, a
	call Func_4427f
	jr nc, .asm_4418a
	ld a, [hli]
	ld e, a
	ld d, [hl]
	ld hl, wDuelTempList
	call SearchCardInListInHL
	jr c, .asm_4418a
	ld a, $03
.asm_44186
	scf
	ccf
	jr .asm_4418b
.asm_4418a
	scf
.asm_4418b
	pop hl
	pop de
	pop bc
	ret
; 0x4418f

SECTION "Bank 11@41ac", ROMX[$41ac], BANK[$11]

Func_441ac:
	push bc
	push de
	push hl
	push hl
	xor a
	ld hl, wd561
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld [hl], a
	pop hl
.asm_441bc
	ld a, [hli]
	ld e, a
	ld a, [hli]
	ld d, a
	or e
	jr z, .asm_441da
	call LoadCardDataToBuffer1_FromCardID
	ld a, [wLoadedCard1Type]
	cp $07
	jr nc, .asm_441bc
	ld de, wd561
	add e
	ld e, a
	jr nc, .asm_441d5
	inc d
.asm_441d5
	ld a, [de]
	inc a
	ld [de], a
	jr .asm_441bc
.asm_441da
	ld de, $0
	ld c, $00
	ld hl, wd561
.asm_441e2
	ld a, [hli]
	cp d
	jr c, .asm_441f4
	jr nz, .asm_441f2
	call UpdateRNGSources
	srl a
	jr c, .asm_441f4
	ld e, c
	jr .asm_441f4
.asm_441f2
	ld d, a
	ld e, c
.asm_441f4
	inc c
	ld a, c
	cp $07
	jr nz, .asm_441e2
	ld a, e
	or a
	jr nz, .asm_441ff
	scf
.asm_441ff
	pop hl
	pop de
	pop bc
	ret

Func_44203:
	push bc
	push de
	push hl
	farcall ZeroOutBytes_wd606
.asm_4420a
	ld a, [hli]
	ld e, a
	ld a, [hli]
	ld d, a
	or e
	jr z, .asm_44221
	call LoadCardDataToBuffer1_FromCardID
	ld a, [wLoadedCard1Type]
	cp $07
	jr nc, .asm_4420a
	farcall SetBit_wd606
	jr .asm_4420a
.asm_44221
	xor a
	ld c, a
.asm_44223
	farcall CheckBit_wd606
	jr z, .asm_4422a
	inc c
.asm_4422a
	inc a
	cp $07
	jr nz, .asm_44223
	ld a, c
	pop hl
	pop de
	pop bc
	ret

Func_44234:
	push bc
	push de
	push hl
	ld de, $1
	ld hl, wDuelTempList
	xor a
	push af
.asm_4423f
	call LoadCardDataToBuffer1_FromCardID
	ld a, [wLoadedCard1Type]
	cp b
	jr nz, .asm_44255
	ld a, [wLoadedCard1Rarity]
	cp c
	jr nz, .asm_44255
	pop af
	inc a
	push af
	ld a, e
	ld [hli], a
	ld a, d
	ld [hli], a
.asm_44255
	ld a, d
	cp $01
	jr c, .asm_4425f
	jr nz, .asm_4425f
	ld a, e
	cp $bd
.asm_4425f
	inc de
	jr nz, .asm_4423f
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

Func_4427f:
	push bc
	push de
	push hl
	farcall Func_260e7
	pop hl
	pop de
	pop bc
	ret

Func_4428a:
	push bc
	push de
	push hl
	call LoadCardDataToBuffer1_FromCardID
	ld hl, wLoadedCard1PreEvoName
	ld a, [hli]
	ld c, a
	ld b, [hl]
	ld hl, wDuelTempList
	ld de, $0
.asm_4429c
	inc de
	push hl
	push de
	call LoadCardDataToBuffer1_FromCardID
	jr c, .asm_442c3
	ld a, [wLoadedCard1Type]
	cp $08
	jr nc, .asm_442bf
	ld hl, wLoadedCard1Name
	ld a, c
	cp [hl]
	jr nz, .asm_442bf
	inc hl
	ld a, b
	cp [hl]
	jr nz, .asm_442bf
	pop de
	pop hl
	ld a, e
	ld [hli], a
	ld a, d
	ld [hli], a
	jr .asm_4429c
.asm_442bf
	pop de
	pop hl
	jr .asm_4429c
.asm_442c3
	pop de
	pop hl
	xor a
	ld [hli], a
	ld [hl], a
	ld hl, wDuelTempList
	ld a, [hli]
	or [hl]
	pop hl
	pop de
	pop bc
	ret z
	scf
	ret

Func_442d3:
	push bc
	push de
	push hl
	call LoadCardDataToBuffer1_FromCardID
	ld hl, wLoadedCard1Name
	ld a, [hli]
	ld c, a
	ld b, [hl]
	ld hl, wDuelTempList
	ld de, $0
.asm_442e5
	inc de
	push hl
	push de
	call LoadCardDataToBuffer1_FromCardID
	jr c, .asm_4430c
	ld a, [wLoadedCard1Type]
	cp $08
	jr nc, .asm_44308
	ld hl, wLoadedCard1Name
	ld a, c
	cp [hl]
	jr nz, .asm_44308
	inc hl
	ld a, b
	cp [hl]
	jr nz, .asm_44308
	pop de
	pop hl
	ld a, e
	ld [hli], a
	ld a, d
	ld [hli], a
	jr .asm_442e5
.asm_44308
	pop de
	pop hl
	jr .asm_442e5
.asm_4430c
	pop de
	pop hl
	xor a
	ld [hli], a
	ld [hl], a
	ld hl, wDuelTempList
	ld a, [hli]
	or [hl]
	pop hl
	pop de
	pop bc
	ret z
	scf
	ret
; 0x4431c

SECTION "Bank 11@433a", ROMX[$433a], BANK[$11]

Func_4433a:
	push bc
	push de
	push hl
	ld c, a
	ld a, [hli]
	ld e, a
	ld a, [hld]
	ld d, a
	or e
	jr z, .asm_44357
.asm_44345
	ld a, [hli]
	ld e, a
	ld a, [hli]
	ld d, a
	or e
	jr z, .asm_4435a
	call LoadCardDataToBuffer1_FromCardID
	ld a, [wLoadedCard1Rarity]
	cp c
	jr nz, .asm_44357
	jr .asm_44345
.asm_44357
	scf
	jr .asm_4435c
.asm_4435a
	scf
	ccf
.asm_4435c
	pop hl
	pop de
	pop bc
	ret

Func_44360:
	push bc
	push de
	push hl
.asm_44363
	ld a, [hli]
	ld c, a
	ld a, [hli]
	ld b, a
	or c
	jr z, .asm_4438b
	ld a, d
	cp b
	jr c, .asm_44372
	jr nz, .asm_44372
	ld a, e
	cp c
.asm_44372
	jr nz, .asm_44363
.asm_44374
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
	jr nz, .asm_44374
	xor a
	dec hl
	ld [hld], a
	ld [hl], a
	scf
	ccf
	jr .asm_4438c
.asm_4438b
	scf
.asm_4438c
	pop hl
	pop de
	pop bc
	ret

Func_44390:
	push bc
	push de
	push hl
	farcall ZeroOutBytes_wd606
.asm_44397
	ld a, [bc]
	ld e, a
	inc bc
	ld a, [bc]
	ld d, a
	inc bc
	or e
	jr z, .asm_443b4
	ld a, $ff
.asm_443a2
	inc a
	call Func_44070
	jr c, .asm_443b8
	farcall CheckBit_wd606
	jr nz, .asm_443a2
	farcall SetBit_wd606
	jr .asm_44397
.asm_443b4
	scf
	ccf
	jr .asm_443b9
.asm_443b8
	scf
.asm_443b9
	pop hl
	pop de
	pop bc
	ret

Func_443bd:
	push af
	push bc
	push de
	push hl
.asm_443c1
	ld a, [bc]
	ld e, a
	inc bc
	ld a, [bc]
	inc bc
	ld d, a
	or e
	jr z, .asm_443cf
	call Func_44360
	jr .asm_443c1
.asm_443cf
	pop hl
	pop de
	pop bc
	pop af
	ret
; 0x443d4

SECTION "Bank 11@43d4", ROMX[$43d4], BANK[$11]

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
	cp $01
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

Func_44481:
	push bc
	push de
	push hl
	ld b, a
	ld c, $00
.asm_44487
	ld a, [hli]
	ld e, a
	ld a, [hli]
	ld d, a
	or e
	jr z, .asm_4449a
	call LoadCardDataToBuffer1_FromCardID
	ld a, [wLoadedCard1RealSet]
	cp b
	jr nz, .asm_44487
	inc c
	jr .asm_44487
.asm_4449a
	ld a, c
	pop hl
	pop de
	pop bc
	ret

Func_4449f:
	push bc
	push de
	push hl
	ld b, a
	ld c, $00
.asm_444a5
	ld a, [hli]
	ld e, a
	ld a, [hli]
	ld d, a
	or e
	jr z, .asm_444b8
	call LoadCardDataToBuffer1_FromCardID
	ld a, [wLoadedCard1Set]
	cp b
	jr nz, .asm_444a5
	inc c
	jr .asm_444a5
.asm_444b8
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
	ld hl, sDeck1Name
	ld c, $05
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
	lb bc, $0, STAR
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
	lb bc, $0, DIAMOND
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
	lb bc, $0, CIRCLE
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
	lb bc, $1, STAR
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
	lb bc, $1, DIAMOND
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
	lb bc, $1, CIRCLE
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
	lb bc, $2, STAR
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
	lb bc, $2, DIAMOND
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
	lb bc, $2, CIRCLE
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
	dw \1 ; recipe
	db \2 ; post-game flag
	dw \3 ; output
ENDM

BlackboxPromoCards:
	blackbox_promo .dugtrio_lv40, FALSE, DUGTRIO_LV40
	blackbox_promo .mankey_alt_lv7, TRUE, MANKEY_ALT_LV7
	blackbox_promo .diglett_lv16, TRUE, DIGLETT_LV16
	blackbox_promo .moltres_lv40, FALSE, MOLTRES_LV40
	blackbox_promo .arcanine_lv34, TRUE, ARCANINE_LV34
	blackbox_promo .nonpromo_charizard_lv76, FALSE, CHARIZARD_LV76 ; bug, should be CHARIZARD_ALT_LV76
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
	blackbox_promo .nonpromo_dragonite_lv45, TRUE, DRAGONITE_LV45 ; bug, should be DRAGONITE_LV43, though listed in .OtherPromoCards instead
	blackbox_promo .meowth_lv14, FALSE, MEOWTH_LV14
	blackbox_promo .hungry_snorlax, TRUE, HUNGRY_SNORLAX
	blackbox_promo .cool_porygon, TRUE, COOL_PORYGON
	dw 0 ; end

.dugtrio_lv40
	dw DUGTRIO_LV36, HITMONLEE_LV30, HITMONCHAN_LV23
	dw 0
.mankey_alt_lv7
	dw HITMONLEE_LV30, HITMONCHAN_LV23
	dw 0
.diglett_lv16
	dw DUGTRIO_LV36, DARK_DUGTRIO
	dw 0
.moltres_lv40
	dw NINETALES_LV32, DARK_NINETALES, MOLTRES_LV35
	dw 0
.arcanine_lv34
	dw NINETALES_LV32, ARCANINE_LV45
	dw 0
.nonpromo_charizard_lv76
	dw DARK_CHARIZARD, DARK_NINETALES
	dw 0
.pikachu_lv13
	dw RAICHU_LV40, RAICHU_LV45, RAICHU_LV32, DARK_RAICHU
	dw 0
.pikachu_lv16
	dw RAICHU_LV40, RAICHU_LV45, RAICHU_LV32
	dw 0
.zapdos_lv68
	dw RAICHU_LV40, DARK_RAICHU, ZAPDOS_LV64
	dw 0
.pikachu_alt_lv16
	dw ELECTRODE_LV35, ELECTRODE_LV42, MAGNETON_LV28, MAGNETON_LV35
	dw 0
.electabuzz_lv20
	dw ELECTABUZZ_LV35, MAGNETON_LV30, MAGNETON_LV28, MAGNETON_LV35
	dw 0
.articuno_lv37
	dw POLIWRATH_LV40, KINGLER_LV33, ARTICUNO_LV35
	dw 0
.magikarp_lv10
	dw GYARADOS, DARK_GYARADOS
	dw 0
.blastoise_alt_lv52
	dw DARK_BLASTOISE, DARK_GYARADOS
	dw 0
.venusaur_alt_lv67
	dw DARK_VILEPLUME, DARK_VENUSAUR
	dw 0
.grs_mewtwo
	dw MEW_LV23, MEWTWO_LV53, MEWTWO_LV67
	dw 0
.mewtwo_alt_lv60
	dw MEW_LV23, MEWTWO_LV67
	dw 0
.mewtwo_lv60
	dw MEW_LV23, MEWTWO_LV53
	dw 0
.mewtwo_lv30
	dw MEWTWO_LV53, MEWTWO_LV67
	dw 0
.slowpoke_lv9
	dw ALAKAZAM_LV42, GENGAR_LV38, MR_MIME_LV28
	dw 0
.super_energy_retrieval
	dw POLIWRATH_LV40, DRAGONAIR
	dw 0
.dark_persian_alt_lv28
	dw CHANSEY_LV55, CLEFABLE, WIGGLYTUFF_LV36
	dw 0
.jigglypuff_lv12
	dw CHANSEY_LV55, CLEFAIRY_LV14
	dw 0
.kangaskhan_lv38
	dw KANGASKHAN_LV40, DRAGONAIR
	dw 0
.farfetchd_alt_lv20
	dw PIDGEOT_LV38, CLEFAIRY_LV14, DITTO
	dw 0
.dragonite_lv41
	dw DRAGONITE_LV45, DARK_DRAGONITE, DRAGONAIR
	dw 0
.nonpromo_dragonite_lv45
	dw DRAGONITE_LV45, DARK_DRAGONITE, DRAGONITE_LV41
	dw 0
.meowth_lv14
	dw DITTO, SNORLAX_LV20
	dw 0
.hungry_snorlax
	dw SNORLAX_LV20, SNORLAX_LV35
	dw 0
.cool_porygon
	dw DITTO, CLEFABLE
	dw 0

OtherPromoCards:
	dw VENUSAUR_LV64
	dw MARILL
	dw OMASTAR_LV36
	dw GOLEM_LV37
	dw MACHAMP_LV54
	dw ALAKAZAM_LV45
	dw GENGAR_LV40
	dw MEWTWO_LV30 ; weird, also in BlackboxPromoCards
	dw MEW_LV15
	dw MEW_LV8
	dw SURFING_PIKACHU_LV13
	dw SURFING_PIKACHU_ALT_LV13
	dw FLYING_PIKACHU_LV12
	dw FLYING_PIKACHU_ALT_LV12
	dw DRAGONITE_LV43 ; weird if BlackboxPromoCards weren't bugged
	dw TOGEPI
	dw LUGIA
	dw HERE_COMES_TEAM_ROCKET
	dw IMAKUNI_CARD
	dw COMPUTER_ERROR
	dw 0

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
	ld [$d578], a
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
	ld a, [$d578]
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
	ld a, [$d556]
	ld l, a
	ld a, [$d557]
	ld h, a
	call LoadTxRam2
	ld a, l
	ld [wTxRam2_b], a
	ld a, h
	ld [$cdd9], a
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
	ld a, MUSIC_MATCHSTART_2
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
	ld a, MUSIC_MATCHSTART_2
	ld [wDuelStartTheme], a
	ld hl, wd583
	set 1, [hl]
	ret

Func_454bc:
	call Func_45488
	farcall LoadNPCDuelistDeck
	farcall LoadNPCDuelist
	ld a, [$d558]
	ld l, a
	ld a, [$d559]
	ld h, a
	call LoadTxRam2
	ld a, [$d556]
	ld l, a
	ld a, [$d557]
	ld h, a
	ld a, l
	ld [wTxRam2_b], a
	ld a, h
	ld [$cdd9], a
	ret

Func_454e3:
	call Func_45488
	farcall LoadNPCDuelistDeck
	farcall LoadNPCDuelist
	ld a, [$d556]
	ld l, a
	ld a, [$d557]
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
	ld a, [$d556]
	ld l, a
	ld a, [$d557]
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
; 0x4569f

Func_4569f:
	ld hl, wCurDeckCards
	call Func_44000
	ld a, $07
	call Func_4449f
	or a
	jr nz, .asm_456da
	call Func_44013
	jr c, .asm_456be
	call CountCardsInHL
	cp $02
	jr c, .asm_456be
	call Func_456de
	jr .asm_456dd
.asm_456be
	ld hl, wCurDeckCards
	call Func_4407d
	jr c, .asm_456cb
	call Func_457ea
	jr .asm_456dd
.asm_456cb
	ld a, $02
	ld hl, wCurDeckCards
	call Func_4433a
	jr c, .asm_456da
	call Func_45868
	jr .asm_456dd
.asm_456da
	call Func_458bf
.asm_456dd
	ret

Func_456de:
	ld hl, wCurDeckCards
	ld a, [hli]
	ld e, a
	ld a, [hld]
	ld d, a
	call LoadCardDataToBuffer1_FromCardID
	ld a, [wLoadedCard1Type]
	cp $08
	jr c, .asm_456f9
	cp $10
	jr z, .asm_456f9
	call Func_45bc3
	jp .asm_457e9
.asm_456f9
	call CountCardsInHL
	push af
	cp $05
	jr nz, .asm_45777
	ld a, [wLoadedCard1Rarity]
	cp $02
	jr c, .asm_45777
	pop af
	call Func_45aaa
	or a
	jr nz, .asm_45711
	jr .asm_4577e
.asm_45711
	call Func_4427f
	jr nc, .asm_45741
	ld hl, wDuelTempList
	call Func_45c07
	call Func_45c3d
	or a
	jr z, .asm_4577e
	call Random
	sla a
	add l
	ld l, a
	jr nc, .asm_4572c
	inc h
.asm_4572c
	ld a, [hli]
	ld e, a
	ld d, [hl]
	ld hl, wdd5f
	ld c, $03
.asm_45734
	ld a, e
	ld [hli], a
	ld a, d
	ld [hli], a
	dec c
	jr nz, .asm_45734
	xor a
	ld [hli], a
	ld [hl], a
	jp .asm_457e9
.asm_45741
	call LoadCardDataToBuffer1_FromCardID
	ld a, [wLoadedCard1Type]
	ld b, a
	ld c, $02
	call Func_44234
	ld hl, wDuelTempList
	call Func_45c07
	call Func_45c3d
	or a
	jr z, .asm_4577e
	call Random
	sla a
	add l
	ld l, a
	jr nc, .asm_45763
	inc h
.asm_45763
	ld a, [hli]
	ld e, a
	ld d, [hl]
	ld hl, wdd5f
	ld c, $05
.asm_4576b
	ld a, e
	ld [hli], a
	ld a, d
	ld [hli], a
	dec c
	jr nz, .asm_4576b
	xor a
	ld [hli], a
	ld [hl], a
	jr .asm_457e9
.asm_45777
	pop af
	call Func_45aaa
	or a
	jr nz, .asm_45790
.asm_4577e
	ld hl, wCurDeckCards
	ld a, [hli]
	ld e, a
	ld d, [hl]
	ld hl, wdd5f
	ld a, e
	ld [hli], a
	ld a, d
	ld [hli], a
	xor a
	ld [hli], a
	ld [hl], a
	jr .asm_457e9
.asm_45790
	call Func_4427f
	jr nc, .asm_457ba
	ld hl, wDuelTempList
	call Func_45c07
	call Func_45c3d
	or a
	jr z, .asm_4577e
	call Random
	sla a
	add l
	ld l, a
	jr nc, .asm_457ab
	inc h
.asm_457ab
	ld a, [hli]
	ld e, a
	ld d, [hl]
	ld hl, wdd5f
	ld a, e
	ld [hli], a
	ld a, d
	ld [hli], a
	xor a
	ld [hli], a
	ld [hl], a
	jr .asm_457e9
.asm_457ba
	call LoadCardDataToBuffer1_FromCardID
	ld a, [wLoadedCard1Type]
	ld b, a
	ld c, $02
	call Func_44234
	ld hl, wDuelTempList
	call Func_45c07
	call Func_45c3d
	or a
	jr z, .asm_4577e
	call Random
	sla a
	add l
	ld l, a
	jr nc, .asm_457dc
	inc h
.asm_457dc
	ld a, [hli]
	ld e, a
	ld d, [hl]
	ld hl, wdd5f
	ld a, e
	ld [hli], a
	ld a, d
	ld [hli], a
	xor a
	ld [hli], a
	ld [hl], a
.asm_457e9
	ret

Func_457ea:
	call Func_45acb
	cp $01
	jr z, .asm_4580c
	jr nz, .asm_45825
	ld hl, $d57c
	ld a, [hli]
	ld e, a
	ld d, [hl]
	or d
	jr z, .asm_45801
	call Func_442d3
	jr .asm_4583c
.asm_45801
	ld hl, $d57e
	ld a, [hli]
	ld e, a
	ld d, [hl]
	call Func_4428a
	jr .asm_4583c
.asm_4580c
	ld hl, $d57e
	ld a, [hli]
	ld e, a
	ld d, [hl]
	or d
	jr z, .asm_4581a
	call Func_442d3
	jr .asm_4583c
.asm_4581a
	ld hl, $d57c
	ld a, [hli]
	ld e, a
	ld d, [hl]
	call Func_4427f
	jr .asm_4583c
.asm_45825
	ld hl, $d580
	ld a, [hli]
	ld e, a
	ld d, [hl]
	or d
	jr z, .asm_45833
	call Func_442d3
	jr .asm_4583c
.asm_45833
	ld hl, $d57e
	ld a, [hli]
	ld e, a
	ld d, [hl]
	call Func_4427f
.asm_4583c
	ld hl, wDuelTempList
	call Func_45c07
	call Func_45c3d
	or a
	jr z, .asm_45863
	call Random
	sla a
	add l
	ld l, a
	jr nc, .asm_45852
	inc h
.asm_45852
	ld a, [hli]
	ld e, a
	ld d, [hl]
	ld hl, wdd5f
.asm_45858
	ld a, e
	ld [hli], a
	ld a, d
	ld [hli], a
	dec c
	jr nz, .asm_45858
	xor a
	ld [hli], a
	ld [hl], a
.asm_45862
	ret
.asm_45863
	call Func_45bc3
	jr .asm_45862

Func_45868:
	xor a
	ld hl, wdd5f
	ld [hli], a
	ld [hl], a
	ld hl, BlackboxPromoCards
.asm_45871
	ld a, [hli]
	ld c, a
	ld a, [hli]
	ld b, a
	or c
	jr z, .asm_458aa
	push hl
	ld hl, wCurDeckCards
	call Func_44390
	pop hl
	jr c, .asm_458a5
	ld a, [hli]
	or a
	jr z, .asm_4588e
	ld a, EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE
	farcall GetEventValue
	jr z, .asm_458a6
.asm_4588e
	ld a, [hli]
	ld e, a
	ld a, [hld]
	ld d, a
	push hl
	ld hl, wdd5f
	call AppendCardToListInHL
	ld hl, wCurDeckCards
	call Func_443bd
	pop hl
	dec hl
	dec hl
	dec hl
	jr .asm_45871
.asm_458a5
	inc hl
.asm_458a6
	inc hl
	inc hl
	jr .asm_45871
.asm_458aa
	ld hl, wCurDeckCards
.asm_458ad
	ld a, [hli]
	ld e, a
	ld a, [hli]
	ld d, a
	or e
	jr z, .asm_458be
	push hl
	ld hl, wdd5f
	call AppendCardToListInHL
	pop hl
	jr .asm_458ad
.asm_458be
	ret

Func_458bf:
	xor a
	ld hl, wdd5f
	ld [hli], a
	ld [hl], a
	ld hl, wCurDeckCards
.asm_458c8
	ld a, [hli]
	ld e, a
	ld a, [hli]
	ld d, a
	or e
	jr z, .asm_458f1
	call LoadCardDataToBuffer1_FromCardID
	ld a, [wLoadedCard1Type]
	cp $08
	jr nc, .asm_458e7
	ld a, [wLoadedCard1Set]
	cp $07
	jr z, .asm_458e7
	ld a, [wLoadedCard1Rarity]
	cp $02
	jr c, .asm_458c8
.asm_458e7
	push hl
	ld hl, wdd5f
	call AppendCardToListInHL
	pop hl
	jr .asm_458c8
.asm_458f1
	ld hl, wCurDeckCards
	ld c, $00
.asm_458f6
	ld a, [hli]
	ld e, a
	ld a, [hli]
	ld d, a
	or e
	jr z, .asm_45923
	call LoadCardDataToBuffer1_FromCardID
	ld a, [wLoadedCard1Type]
	cp $08
	jr nc, .asm_458f6
	ld a, [wLoadedCard1Set]
	cp $07
	jr z, .asm_4591f
	ld a, [wLoadedCard1Rarity]
	cp $01
	jr z, .asm_4591a
	jr nc, .asm_4591f
	inc c
	jr .asm_458f6
.asm_4591a
	inc c
	inc c
	inc c
	jr .asm_458f6
.asm_4591f
	inc c
	inc c
	jr .asm_458f6
.asm_45923
	xor a
	ld hl, wRemainingIntroCards
	ld [hli], a
	ld [hli], a
	ld [hl], a
	ld a, c
	cp $0b
	jr nc, .asm_459a9
	cp $06
	jr nc, .asm_45988
	cp $02
	jr nc, .asm_45965
	ld hl, wCurDeckCards
.asm_4593a
	ld a, [hli]
	ld e, a
	ld a, [hli]
	ld d, a
	or e
	jp z, .asm_45a9b
	call LoadCardDataToBuffer1_FromCardID
	ld a, [wLoadedCard1Type]
	cp $07
	jr nc, .asm_4593a
	ld a, [wLoadedCard1Set]
	cp $07
	jr z, .asm_4593a
	ld a, [wLoadedCard1Rarity]
	cp $02
	jp nc, .asm_4593a
	push hl
	ld hl, wdd5f
	call AppendCardToListInHL
	pop hl
	jr .asm_4593a
.asm_45965
	call Func_45b2d
	inc a
	ld c, a
	ld hl, wRemainingIntroCards
	ld a, $01
	ld [hl], a
	dec c
	jr z, .asm_459cb
	ld a, $03
	ld [hl], a
	dec c
	jr z, .asm_459cb
	xor a
	ld [hli], a
	ld a, $02
	ld [hl], a
	dec c
	jr z, .asm_459cb
	xor a
	ld [hli], a
	ld a, $01
	ld [hl], a
	jr .asm_459cb
.asm_45988
	call Func_45b2d
	inc a
	ld c, a
	ld hl, wRemainingIntroCards
	ld a, $05
	ld [hl], a
	dec c
	jr z, .asm_459cb
	xor a
	ld [hli], a
	ld a, $03
	ld [hl], a
	dec c
	jr z, .asm_459cb
	xor a
	ld [hli], a
	ld a, $01
	ld [hl], a
	dec c
	jr z, .asm_459cb
	inc [hl]
	jr .asm_459cb
.asm_459a9
	call Func_45b2d
	inc a
	ld c, a
	ld hl, $d578
	ld a, $03
	ld [hl], a
	dec c
	jr z, .asm_459cb
	xor a
	ld [hli], a
	ld a, $01
	ld [hl], a
	dec c
	jr z, .asm_459cb
	dec hl
	ld a, $03
	ld [hl], a
	dec c
	jr z, .asm_459cb
	xor a
	ld [hli], a
	ld a, $03
	ld [hl], a
.asm_459cb
	ld a, [wRemainingIntroCards]
	or a
	jr z, .asm_45a11
	ld bc, $1000
	ld hl, wCurDeckCards
	call Func_44203
	cp $05
	jr z, .asm_459e2
	call Func_441ac
	ld b, a
.asm_459e2
	call Func_44234
	ld hl, wDuelTempList
	call Func_45c07
	call Func_45c3d
	or a
	jp z, .asm_45a9c
	ld b, a
	ld a, [wRemainingIntroCards]
	ld c, a
.asm_459f7
	ld a, b
	call Random
	sla a
	ld hl, wDuelTempList
	add l
	ld l, a
	jr nc, .asm_45a05
	inc h
.asm_45a05
	ld a, [hli]
	ld e, a
	ld d, [hl]
	ld hl, wdd5f
	call AppendCardToListInHL
	dec c
	jr nz, .asm_459f7
.asm_45a11
	ld a, [$d578]
	or a
	jr z, .asm_45a56
	ld bc, $1001
	ld hl, wCurDeckCards
	call Func_44203
	cp $05
	jr z, .asm_45a28
	call Func_441ac
	ld b, a
.asm_45a28
	call Func_44234
	ld hl, wDuelTempList
	call Func_45c07
	call Func_45c3d
	or a
	jr z, .asm_45a9c
	ld b, a
	ld a, [$d578]
	ld c, a
.asm_45a3c
	ld a, b
	call Random
	sla a
	ld hl, wDuelTempList
	add l
	ld l, a
	jr nc, .asm_45a4a
	inc h
.asm_45a4a
	ld a, [hli]
	ld e, a
	ld d, [hl]
	ld hl, wdd5f
	call AppendCardToListInHL
	dec c
	jr nz, .asm_45a3c
.asm_45a56
	ld a, [$d579]
	or a
	jr z, .asm_45a9b
	ld bc, $1002
	ld hl, wCurDeckCards
	call Func_44203
	cp $05
	jr z, .asm_45a6d
	call Func_441ac
	ld b, a
.asm_45a6d
	call Func_44234
	ld hl, wDuelTempList
	call Func_45c07
	call Func_45c3d
	or a
	jr z, .asm_45a9c
	ld b, a
	ld a, [$d579]
	ld c, a
.asm_45a81
	ld a, b
	call Random
	sla a
	ld hl, wDuelTempList
	add l
	ld l, a
	jr nc, .asm_45a8f
	inc h
.asm_45a8f
	ld a, [hli]
	ld e, a
	ld d, [hl]
	ld hl, wdd5f
	call AppendCardToListInHL
	dec c
	jr nz, .asm_45a81
.asm_45a9b
	ret
.asm_45a9c
	call Func_45bc3
	ld hl, wdd5f
	ld de, $a
	call AppendCardToListInHL
	jr .asm_45a9b

Func_45aaa:
	push bc
	push hl
	dec a
	dec a
	ld hl, $5ac7
	add l
	ld l, a
	jr nc, .asm_45ab6
	inc h
.asm_45ab6
	ld c, [hl]
	ld a, $64
	call Random
	cp c
	jr c, .asm_45ac3
	ld a, $01
	jr .asm_45ac4
.asm_45ac3
	xor a
.asm_45ac4
	pop hl
	pop bc
	ret
; 0x45ac7

SECTION "Bank 11@5acb", ROMX[$5acb], BANK[$11]

Func_45acb:
	sla a
	push af
	ld hl, $5b0d
	add l
	ld l, a
	jr nc, .asm_45ad6
	inc h
.asm_45ad6
	ld a, [hli]
	ld c, a
	ld b, [hl]
	ld a, $64
	call Random
	cp c
	jr c, .asm_45b00
	cp b
	jr c, .asm_45af2
	pop af
	ld hl, $5b25
	add l
	ld l, a
	jr nc, .asm_45aed
	inc h
.asm_45aed
	ld a, [hli]
	ld c, a
	ld a, [hl]
	jr .asm_45b0c
.asm_45af2
	pop af
	ld hl, $5b1d
	add l
	ld l, a
	jr nc, .asm_45afb
	inc h
.asm_45afb
	ld a, [hli]
	ld c, a
	ld a, [hl]
	jr .asm_45b0c
.asm_45b00
	pop af
	ld hl, $5b15
	add l
	ld l, a
	jr nc, .asm_45b09
	inc h
.asm_45b09
	ld a, [hli]
	ld c, a
	ld a, [hl]
.asm_45b0c
	ret
; 0x45b0d

SECTION "Bank 11@5b2d", ROMX[$5b2d], BANK[$11]

Func_45b2d:
	push bc
	push de
	push hl
	sla a
	sla a
	ld hl, $5b5c
	add l
	ld l, a
	jr nc, .asm_45b3c
	inc h
.asm_45b3c
	ld a, [hli]
	ld c, a
	ld a, [hli]
	ld b, a
	ld a, [hli]
	ld e, a
	ld a, [hli]
	ld d, a
	ld l, $00
	ld a, $64
	call Random
	cp c
	jr c, .asm_45b57
	inc l
	cp b
	jr c, .asm_45b57
	inc l
	cp e
	jr c, .asm_45b57
	inc l
.asm_45b57
	ld a, l
	pop hl
	pop de
	pop bc
	ret
; 0x45b5c

SECTION "Bank 11@5b9c", ROMX[$5b9c], BANK[$11]

Func_45b9c:
	push af
	push bc
	push de
	push hl
	ld c, e
	ld b, d
	ld hl, OtherPromoCards
.asm_45ba5
	ld a, [hli]
	ld c, a
	ld a, [hli]
	ld b, a
	or c
	jr z, .asm_45bbc
	ld a, b
	cp d
	jr c, .asm_45bb4
	jr nz, .asm_45bb4
	ld a, c
	cp e
.asm_45bb4
	jr nz, .asm_45ba5
	pop hl
	pop de
	pop bc
	pop af
	scf
	ret
.asm_45bbc
	pop hl
	pop de
	pop bc
	pop af
	scf
	ccf
	ret
; 0x45bc3

SECTION "Bank 11@5bc3", ROMX[$5bc3], BANK[$11]

Func_45bc3:
	push af
	push bc
	push de
	push hl
	ld hl, wCurDeckCards
	ld de, wdd5f
	ld bc, $c
	call CopyDataHLtoDE_SaveRegisters
	pop hl
	pop de
	pop bc
	pop af
	ret
; 0x45bd8

SECTION "Bank 11@5c07", ROMX[$5c07], BANK[$11]

Func_45c07:
	push bc
	push de
	push hl
	xor a
	ld c, a
.asm_45c0c
	ld a, [hli]
	ld e, a
	ld a, [hld]
	ld d, a
	or e
	jr z, .asm_45c29
	call LoadCardDataToBuffer1_FromCardID
	ld a, [wLoadedCard1Set]
	cp $07
	jr nz, .asm_45c24
	push hl
	call Func_45c2e
	pop hl
	jr .asm_45c0c
.asm_45c24
	inc hl
	inc hl
	inc c
	jr .asm_45c0c
.asm_45c29
	ld a, c
	pop hl
	pop de
	pop bc
	ret

Func_45c2e:
.asm_45c2e
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
	jr .asm_45c2e

Func_45c3d:
	push bc
	push de
	push hl
	xor a
	ld c, a
.asm_45c42
	ld a, [hli]
	ld e, a
	ld a, [hld]
	ld d, a
	or e
	jr z, .asm_45c5a
	call Func_45b9c
	jr nc, .asm_45c55
	push hl
	call Func_45c5f
	pop hl
	jr .asm_45c42
.asm_45c55
	inc hl
	inc hl
	inc c
	jr .asm_45c42
.asm_45c5a
	ld a, c
	pop hl
	pop de
	pop bc
	ret

Func_45c5f:
.asm_45c5f
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
	jr .asm_45c5f

INCLUDE "engine/credits.asm"
