Func_68000:
	ldtx de, PoisonInflictionCheckText
	call TossCoin_Bank1a
	jr c, Func_68012
	jp Func_68094

Func_6800b:
	ldtx de, PoisonInflictionCheckText
	call TossCoin_Bank1a
	ret nc

Func_68012:
	ld bc, $f80
	jr Func_68061

Func_68017:
	ld bc, $fc0
	jr Func_68061

Func_6801c:
	ldtx de, ParalysisInflictionCheckText
	call TossCoin_Bank1a
	jr c, Func_6802e
	jp Func_68094

Func_68027:
	ldtx de, ParalysisInflictionCheckText
	call TossCoin_Bank1a
	ret nc

Func_6802e:
	ld bc, $f003
	jr Func_68061

Func_68033:
	ldtx de, ConfusionInflictionCheckText
	call TossCoin_Bank1a
	jr c, Func_68045
	jp Func_68094

Func_6803e:
	ldtx de, ConfusionInflictionCheckText
	call TossCoin_Bank1a
	ret nc

Func_68045:
	ld bc, $f001
	jr Func_68061

Func_6804a:
	ldtx de, SleepInflictionCheckText
	call TossCoin_Bank1a
	jr c, Func_6805c
	jp Func_68094

Func_68055:
	ldtx de, SleepInflictionCheckText
	call TossCoin_Bank1a
	ret nc

Func_6805c:
	ld bc, $f002
	jr Func_68061

Func_68061:
	bank1call Func_6470
	ret

; de - text pointer. displayed during coin toss
TossCoin_Bank1a:
	call TossCoin
	ret

; a - number of coins to toss
; de - text diplayed while tossing
Func_68069:
	call TossCoinATimes
	ret
	ret

Func_6806e:
	ld a, $01
	ld [wIsDamageToSelf], a
	ret

Func_68074:
	xor a
	ld [wIsDamageToSelf], a
	ret

; input:
; - de = text ID
Func_68079:
	ld a, 1
;	fallthrough


; a - number of coins to toss
; de - text diplayed while tossing
; returns: the number of heads in a and in wCoinTossNumHeads, and carry if at least one heads
Func_6807b:
	push hl
	push de
	push af
	ld a, OPPACTION_TOSS_COIN_A_TIMES
	call SetOppAction_SerialSendDuelData
	pop af
	pop de
	pop hl
	call SerialSend8Bytes
	call TossCoinATimes
	ret

Func_6808d:
	ld a, $01
	ld [wcd0d], a
	or a
	ret

Func_68094:
	ld a, $01
	ld [wEffectFailed], a
	ret

Func_6809a:
	ld a, $02
	ld [wEffectFailed], a
	ret

Func_680a0:
	call ExchangeRNG
	farcall Func_24958
	bank1call ShuffleDeck
	ret

Func_680ab:
	ld a, DUELVARS_DUELIST_TYPE
	get_turn_duelist_var
	cp $00
	jr z, .asm_680b4
	or a
	ret
.asm_680b4
	scf
	ret

Func_680b6:
	push af
	ld a, $ec
	call GetNonTurnDuelistVariable
	and $c0
	jr z, Func_680cc
	pop af
	ld a, [wDamage]
	ld [wAIMinDamage], a
	ld [wAIMaxDamage], a
	ret

Func_680cb:
	push af
;	fallthrough

Func_680cc:
	ld hl, wDamage
	ld a, [hl]
	add d
	ld [wAIMinDamage], a
	ld a, [hl]
	add e
	ld [wAIMaxDamage], a
	pop af
	add [hl]
	ld [hl], a
	ret

; a - loaded indo wDamage
; d - loaded into wAIMinDamage
; e - loaded into wAIMaxDamage
Func_680dd:
	ld [wDamage], a
	xor a
	ld [wDamage + 1], a
	ld a, d
	ld [wAIMinDamage], a
	ld a, e
	ld [wAIMaxDamage], a
	ret

Func_680ed:
	ldh [hTempPlayAreaLocation_ff9d], a
	bank1call Func_5c30
	bank1call PrintPlayAreaCardList_EnableLCD
	bank1call Func_5c23
	ret

Func_680f9:
	ld e, a
	ld d, $00
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	ld c, a
	ld b, $00
	jr .asm_68109
.asm_68104
	push bc
	call DealDamageToPlayAreaPokemon_RegularAnim
	pop bc
.asm_68109
	inc b
	dec c
	jr nz, .asm_68104
	ret

Func_6810e:
	call Func_6846d
	ld hl, wTempCardID_ccc2
	ld e, [hl]
	inc hl
	ld d, [hl]
	call LoadCardDataToBuffer2_FromCardID
	ld hl, wLoadedCard2Atk2Name
	ld e, [hl]
	inc hl
	ld d, [hl]
	ld a, DUELVARS_UNK_FE
	get_turn_duelist_var
	ld [hl], e
	inc hl
	ld [hl], d
	ret

Func_68127:
	push af
	ld a, DUELVARS_ARENA_CARD_SUBSTATUS1
	get_turn_duelist_var
	pop af
	ld [hli], a
	ret

Func_6812e:
	push af
	call SwapTurn
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call GetCardIDFromDeckIndex
	call SwapTurn
	cp16 CLEFAIRY_DOLL
	jr z, .asm_68161
	bank1call CheckNoDamageOrEffect
	jr c, .asm_68155
	ld a, $ee
	call GetNonTurnDuelistVariable
	pop af
	ld [hl], a
	ld l, $fb
	ld [hl], a
	ret
.asm_68155
	pop af
	push hl
	bank1call DrawDuelMainScene
	pop hl
	ld a, l
	or h
	call nz, DrawWideTextBox_PrintText
	ret
.asm_68161
	pop af
	ret

Func_68163:
	push hl
	ld hl, wDamage
	add [hl]
	ld [hli], a
	ld [wAIMaxDamage], a
	ld [wAIMinDamage], a
	ld a, $00
	adc [hl]
	ld [hl], a
	pop hl
	ret

Func_68175:
	call Func_6817e
	ld hl, wDamage + 1
	set 7, [hl]
	ret

Func_6817e:
	ld [wDamage], a
	ld [wAIMinDamage], a
	ld [wAIMaxDamage], a
	xor a
	ld [wDamage + 1], a
	ret

Func_6818c:
	ld a, [wDamage]
	ld [wAIMinDamage], a
	ld [wAIMaxDamage], a
	ret

Func_68196:
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	call Random
	or a
	ret nz
	ld hl, wLoadedAttackCategory
	res 7, [hl]
	ret

Func_681a4:
	call SwapTurn
	xor a
	call CreateArenaOrBenchEnergyCardList
	call SwapTurn
	ret

Func_681af:
	ldh a, [hTempPlayAreaLocation_ff9d]
	add DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call GetCardIDFromDeckIndex
	cp16 CHARIZARD_LV76
	jr z, .asm_681d6
	cp16 CHARIZARD_ALT_LV76
	jr z, .asm_681d6
.asm_681cb
	ldh a, [hTempPlayAreaLocation_ff9d]
	add $10
	ld [wce01], a
	ld a, $08
	jr Func_681ec
.asm_681d6
	ldh a, [hTempPlayAreaLocation_ff9d]
	bank1call CheckIsIncapableOfUsingPkmnPower
	jr c, .asm_681cb
	ldh a, [hTempPlayAreaLocation_ff9d]
	call CreateArenaOrBenchEnergyCardList
	ret

Func_681e3:
	ld a, $08

Func_681e5:
	push af
	ld a, $10
	ld [wce01], a
	pop af

Func_681ec:
	ld b, a
	ld c, $00
	ld de, wDuelTempList
	ld a, DUELVARS_CARD_LOCATIONS
	get_turn_duelist_var
.asm_681f5
	ld a, [hl]
	push hl
	ld hl, wce01
	cp [hl]
	pop hl
	jr nz, .asm_6821b
	push de
	ld a, l
	call GetCardIDFromDeckIndex
	cp16 RAINBOW_ENERGY
	jr nz, .asm_68210
	pop de
	jr .asm_68217
.asm_68210
	call GetCardType
	pop de
	cp b
	jr nz, .asm_6821b
.asm_68217
	ld a, l
	ld [de], a
	inc de
	inc c
.asm_6821b
	inc l
	ld a, l
	cp $3c
	jr c, .asm_681f5
	ld a, $ff
	ld [de], a
	ld a, c
	push af
	bank1call SortCardsInDuelTempListByID
	pop af
	or a
	ret nz
	scf
	ret

Func_6822e:
	ld a, b
	or $10
	ld c, a
	ld de, wDuelTempList
	ld a, DUELVARS_CARD_LOCATIONS
	get_turn_duelist_var
.asm_68238
	ld a, [hl]
	cp c
	jr nz, .asm_6824e
	ld a, l
	call LoadCardDataToBuffer1_FromDeckIndex
	ld a, [wLoadedCard1Type]
	bit 3, a
	jr z, .asm_6824e
	cp $0e
	jr nc, .asm_6824e
	ld a, l
	ld [de], a
	inc de
.asm_6824e
	inc l
	ld a, l
	cp $3c
	jr c, .asm_68238
	ld a, $ff
	ld [de], a
	ld a, [wDuelTempList]
	cp $ff
	jr z, .asm_68260
	or a
	ret
.asm_68260
	scf
	ret

Func_68262:
	push de
	ld a, e
	call LoadCardDataToBuffer1_FromDeckIndex
	ld bc, wTxRam2
	ld hl, wLoadedCard1Name
	ld a, [hli]
	ld [bc], a
	inc bc
	ld a, [hl]
	ld [bc], a
	inc bc
	xor a
	ld [bc], a
	inc bc
	ld [bc], a
	ld a, d
	call LoadCardDataToBuffer1_FromDeckIndex
	ld a, $12
	call CopyCardNameAndLevel
	ld [hl], $00
	ldtx hl, PokemonDevolvedToText
	call DrawWideTextBox_WaitForInput
	pop de
	ret

Func_6828a:
	ld e, a
	cp $ff
	ret z
	push de
	call Func_682be
	pop de
	ret c
	ld a, e
	ld [wccef], a
	call SwapTurn
	call SwapArenaWithBenchPokemon
	call SwapTurn
	xor a
	ld [wccc5], a
	ld [wDuelDisplayedScreen], a
	ret

Func_682a9:
	ld hl, wLoadedAttackCategory
	res 7, [hl]
	call SwapTurn
	bank1call HandleNoDamageOrEffectSubstatus
	call SwapTurn
	ret nc
	xor a
	call Func_6817e
	scf
	ret

Func_682be:
	call SwapTurn
	xor a
	ld [wTempPlayAreaLocation_cceb], a
	bank1call Func_7038
	call SwapTurn
	bank1call CheckNoDamageOrEffect
	ret nc
	ld a, l
	or h
	call nz, DrawWideTextBox_PrintText
	ld a, [wDuelDisplayedScreen]
	cp $01
	jr z, .asm_682de
	call WaitForWideTextBoxInput
.asm_682de
	scf
	ret

Func_682e0:
	ld l, a
	ld h, $00
	push hl
	call LoadTxRam3
	ldtx de, DamageCheckIfHeadsPlusDamageText
	call TossCoin_Bank1a
	pop hl
	ret nc
	ld a, l
	call Func_68163
	ret

; applies HP recovery on Pokemon after an attack
; with HP recovery effect, and handles its animation.
; input:
;	d = damage effectiveness
;	e = HP amount to recover
ApplyAndAnimateHPRecovery:
	push de
	ld hl, wccbd
	ld [hl], e
	inc hl
	ld [hl], d

; get Arena card's damage
	ld e, PLAY_AREA_ARENA
	call GetCardDamageAndMaxHP
	pop de
	or a
	ret z ; return if no damage

; load correct animation
	push de
	ld a, ATK_ANIM_HEAL
	ld [wLoadedAttackAnimation], a
	farcall ResetAttackAnimationIsPlaying

	ldh a, [hWhoseTurn]
	ld h, a
	lb bc, PLAY_AREA_ARENA, $1 ; arrow
	farcall PlayAttackAnimation

; compare HP to be restored with max HP
; if HP to be restored would cause HP to
; be larger than max HP, cap it accordingly
	ld e, PLAY_AREA_ARENA
	call GetCardDamageAndMaxHP
	ld b, $00
	pop de
	ld a, DUELVARS_ARENA_CARD_HP
	get_turn_duelist_var
	add e
	ld e, a
	ld a, 0
	adc d
	ld d, a
	; de = damage dealt + current HP
	; bc = max HP of card
	call CompareDEtoBC
	jr c, .skip_cap
	; cap de to value in bc
	ld e, c
	ld d, b

.skip_cap
	ld [hl], e ; apply new HP to arena card
	farcall WaitAttackAnimation
	ret

Func_68335:
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	ld d, a
	ld e, $00
.asm_6833b
	call GetCardDamageAndMaxHP
	or a
	ret nz
	inc e
	dec d
	jr nz, .asm_6833b
	scf
	ret

Func_68346:
	bank1call IsBlackHoleRuleActive
	ret c
	ld a, DUELVARS_NUMBER_OF_CARDS_IN_DISCARD_PILE
	get_turn_duelist_var
	ld b, a
	add $7e
	ld l, a
	ld de, wDuelTempList
	inc b
	jr .asm_68365
.asm_68357
	ld a, [hl]
	call LoadCardDataToBuffer2_FromDeckIndex
	ld a, [wLoadedCard2Type]
	cp $08
	jr nc, .asm_68365
	ld a, [hl]
	ld [de], a
	inc de
.asm_68365
	dec l
	dec b
	jr nz, .asm_68357
	ld a, $ff
	ld [de], a
	ld a, [wDuelTempList]
	cp $ff
	jr z, .asm_68375
	or a
	ret
.asm_68375
	ld hl, $c2
	scf
	ret

Func_6837a:
	bank1call IsBlackHoleRuleActive
	ret c
	ld a, DUELVARS_NUMBER_OF_CARDS_IN_DISCARD_PILE
	get_turn_duelist_var
	ld b, a
	add $7e
	ld l, a
	ld de, wDuelTempList
	inc b
	jr .asm_6839f
.asm_6838b
	ld a, [hl]
	call LoadCardDataToBuffer2_FromDeckIndex
	ld a, [wLoadedCard2Type]
	cp $08
	jr nc, .asm_6839f
	ld a, [wLoadedCard2Stage]
	or a
	jr nz, .asm_6839f
	ld a, [hl]
	ld [de], a
	inc de
.asm_6839f
	dec l
	dec b
	jr nz, .asm_6838b
	ld a, $ff
	ld [de], a
	ld a, [wDuelTempList]
	cp $ff
	jr z, .asm_683af
	or a
	ret
.asm_683af
	ld hl, $c1
	scf
	ret

Func_683b4:
	bank1call IsBlackHoleRuleActive
	ret c
	ld a, DUELVARS_NUMBER_OF_CARDS_IN_DISCARD_PILE
	get_turn_duelist_var
	ld b, a
	add $7e
	ld l, a
	ld de, wDuelTempList
	inc b
	jr .asm_683d3
.asm_683c5
	ld a, [hl]
	call LoadCardDataToBuffer2_FromDeckIndex
	ld a, [wLoadedCard2Type]
	cp $10
	jr nz, .asm_683d3
	ld a, [hl]
	ld [de], a
	inc de
.asm_683d3
	dec l
	dec b
	jr nz, .asm_683c5
	ld a, $ff
	ld [de], a
	ld a, [wDuelTempList]
	cp $ff
	jr z, .asm_683e3
	or a
	ret
.asm_683e3
	ld hl, $ce
	scf
	ret

Func_683e8:
	ld c, $02
	jr CreateEnergyCardListFromDiscardPile

; makes a list in wDuelTempList with the deck indices
; of all basic energy cards found in Turn Duelist's Discard Pile.
CreateEnergyCardListFromDiscardPile_OnlyBasic:
	ld c, $1
	jr CreateEnergyCardListFromDiscardPile

; makes a list in wDuelTempList with the deck indices
; of all energy cards (including Double Colorless)
; found in Turn Duelist's Discard Pile.
CreateEnergyCardListFromDiscardPile_AllEnergy:
	ld c, $0
;	fallthrough

; makes a list in wDuelTempList with the deck indices
; of energy cards found in Turn Duelist's Discard Pile.
; if (c == $0), all energy cards are included;
; if (c == $1), only basic energy cards are included.
; otherwise, only special energy cards are included.
; returns carry if no energy cards were found.
CreateEnergyCardListFromDiscardPile:
; get number of cards in Discard Pile
; and have hl point to the end of the
; Discard Pile list in wOpponentDeckCards.
	bank1call IsBlackHoleRuleActive
	ret c ; no Discard Pile

	ld a, DUELVARS_NUMBER_OF_CARDS_IN_DISCARD_PILE
	get_turn_duelist_var
	ld b, a
	add DUELVARS_DECK_CARDS
	ld l, a

	ld de, wDuelTempList
	inc b
	jr .next_card

.check_energy
	ld a, [hl]
	call LoadCardDataToBuffer2_FromDeckIndex
	ld a, [wLoadedCard2Type]
	and TYPE_ENERGY
	jr z, .next_card

	; if (c == $0), then we include all energy cards
	ld a, c
	or a
	jr z, .copy

	; if (c == $1), then only include basic energy cards
	cp $01
	jr z, .only_basic

	; otherwise, we only include special energy cards
	ld a, [wLoadedCard2Type]
	cp TYPE_ENERGY_DOUBLE_COLORLESS
	jr nc, .copy
	jr .next_card

.only_basic
	ld a, [wLoadedCard2Type]
	cp TYPE_ENERGY_DOUBLE_COLORLESS
	jr nc, .next_card

.copy
	ld a, [hl]
	ld [de], a
	inc de

; goes through Discard Pile list
; in wOpponentDeckCards in descending order.
.next_card
	dec l
	dec b
	jr nz, .check_energy

; terminating byte on wDuelTempList
	ld a, $ff
	ld [de], a

; check if any energy card was found
; by checking whether the first byte
; in wDuelTempList is $ff.
; if none were found, return carry.
	ld a, [wDuelTempList]
	cp $ff
	jr z, .set_carry
	or a
	ret

.set_carry
	scf
	ret

Func_6843b:
	ld a, $f5
	call GetNonTurnDuelistVariable
	ld hl, $c0
	cp $02
	ret

Func_68446:
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	ld hl, $c0
	cp $02
	ret

Func_6844f:
	ldh a, [hTempPlayAreaLocation_ff9d]
	ldh [hTemp_ffa0], a
	add DUELVARS_ARENA_CARD_FLAGS
	get_turn_duelist_var
	and $20
	jr nz, .asm_68460
	ldh a, [hTempPlayAreaLocation_ff9d]
	bank1call CheckIsIncapableOfUsingPkmnPower
	ret
.asm_68460
	ld hl, $d5
	scf
	ret

Func_68465:
	ldh a, [hTemp_ffa0]
	add DUELVARS_ARENA_CARD_FLAGS
	get_turn_duelist_var
	set 5, [hl]
	ret

Func_6846d:
	call Func_68127
	ld a, DUELVARS_ARENA_CARD_SUBSTATUS3
	get_turn_duelist_var
	set 4, [hl]
	res 5, [hl]
	ret

Func_68478:
	ld e, a
	ld a, DUELVARS_ARENA_CARD_SUBSTATUS1
	get_turn_duelist_var
	cp e
	jr z, .asm_68481
	or a
	ret
.asm_68481
	ld hl, $e5
	scf
	ret

Func_68486:
	bank1call DrawDuelMainScene
	call SwapTurn
	xor a
	ldh [hffb2], a
.asm_6848f
	bank1call PrintAndLoadAttacksToDuelTempList
	push af
	ldh a, [hffb2]
	ld hl, Data_684e7
	call InitializeMenuParameters
	pop af
	ld [wNumScrollMenuItems], a
	call EnableLCD
.asm_684a2
	call DoFrame
	ldh a, [hKeysPressed]
	bit 1, a
	jr nz, .asm_684ca
	and $08
	jr nz, .asm_684cf
	call HandleMenuInput
	jr nc, .asm_684a2
	cp $ff
	jr z, .asm_684a2
	ldh a, [hCurScrollMenuItem]
	add a
	ld e, a
	ld d, $00
	ld hl, wDuelTempList
	add hl, de
	ld d, [hl]
	inc hl
	ld e, [hl]
	call SwapTurn
	or a
	ret
.asm_684ca
	call SwapTurn
	scf
	ret
.asm_684cf
	ldh a, [hCurScrollMenuItem]
	ldh [hffb2], a
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call LoadCardDataToBuffer1_FromDeckIndex
	bank1call OpenAttackPage
	call SwapTurn
	bank1call DrawDuelMainScene
	call SwapTurn
	jr .asm_6848f


Data_684e7:
	db $01
	db $0d
	db $02
	db $02
	db $0f
	db $00
	db $00
	db $00

Func_684ef:
	ld a, d
	call LoadCardDataToBuffer1_FromDeckIndex
	ld hl, wLoadedCard1Atk1Name
	inc e
	dec e
	jr z, .asm_684fd
	ld hl, wLoadedCard1Atk2Name
.asm_684fd
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ret

Func_68501:
	call SwapTurn
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call LoadCardDataToBuffer2_FromDeckIndex
	ld a, [wLoadedCard2Atk1Category]
	cp $04
	jr nz, .asm_68520
	ld hl, wLoadedCard2Atk2Name
	ld a, [hli]
	or [hl]
	jr nz, .asm_68520
	call SwapTurn
	ld hl, $cf
	scf
	ret
.asm_68520
	call SwapTurn
	or a
	ret

Func_68525:
	push bc
	push de
	push af
	ldh a, [hTempPlayAreaLocation_ff9d]
	ld e, a
	call GetCardDamageAndMaxHP
	ld b, a
	ld a, e
	add DUELVARS_ARENA_CARD
	get_turn_duelist_var
	pop af
	ld [hl], a
	call LoadCardDataToBuffer2_FromDeckIndex
	ld a, [hl]
	ld l, a
	ldh a, [hTempPlayAreaLocation_ff9d]
	or $10
	ld [hl], a
	ld a, e
	add $c8
	ld l, a
	ld a, [wLoadedCard2HP]
	sub b
	jr nc, .asm_6854a
	xor a
.asm_6854a
	ld [hl], a
	ld a, e
	add $ce
	ld l, a
	ld a, [wLoadedCard2Stage]
	ld [hl], a
	pop de
	pop bc
	ret

Func_68556:
	ldh a, [hTempPlayAreaLocation_ff9d]
	or a
	jr nz, .asm_6855e
	call ClearAllStatusConditions
.asm_6855e
	ldh a, [hTempPlayAreaLocation_ff9d]
	add DUELVARS_ARENA_CARD_CHANGED_TYPE
	get_turn_duelist_var
	ld [hl], $00
	ldh a, [hTempPlayAreaLocation_ff9d]
	add $c2
	ld l, a
	ld [hl], $00
	ret

Func_6856d:
	ld hl, hffb2
	sub [hl]
	ld l, a
	ld h, $00
	call LoadTxRam3
	ldtx hl, MaySelectMoreCardsButQuitPromptText
	call YesOrNoMenuWithText
	ret

; handles the selection of a Bench Pokémon
; due to an effect that forces a switch
; if no Bench, output $ff
; output:
; - [hTempPlayAreaLocation_ff9d]: selected PLAY_AREA_* value
HandleMandatorySwitchSelection:
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	call GetNonTurnDuelistVariable
	cp 2
	jr nc, .has_bench
; no Bench
	ld a, $ff
	ldh [hTempPlayAreaLocation_ff9d], a
	ret
.has_bench
	ld a, DUELVARS_DUELIST_TYPE
	call GetNonTurnDuelistVariable
	cp DUELIST_TYPE_LINK_OPP
	jr z, .link_opp
	cp DUELIST_TYPE_PLAYER
	jr z, .player

; ai
	call SwapTurn
	call AIDoAction_ForcedSwitch
	call SwapTurn
	ld a, [wPlayerAttackingAttackIndex]
	ld e, a
	ld a, [wPlayerAttackingCardIndex]
	ld d, a
	ld hl, wPlayerAttackingCardID
	ld a, [hli]
	ld h, [hl]
	ld l, a
	call CopyAttackDataAndDamage_FromCardID
	call Func_14e5
	ret

.player
	ldtx hl, SelectBenchedPokemonToSwitchWithActiveText
	call DrawWideTextBox_WaitForInput
	call SwapTurn
	bank1call HasAlivePokemonInBench
.select_pkmn
	bank1call OpenPlayAreaScreenForSelection
	jr c, .select_pkmn ; mandatory
	call SwapTurn
	ret

.link_opp
	ld a, OPPACTION_FORCE_SWITCH_ACTIVE
	call SetOppAction_SerialSendDuelData
.loop_wait_link_opp_decision
	call SerialRecvByte
	jr nc, .got_link_opp_decision
	halt
	nop
	jr .loop_wait_link_opp_decision
.got_link_opp_decision
	ldh [hTempPlayAreaLocation_ff9d], a
	ret

Func_685dd:
	call SwapTurn
	ld e, $00
	call GetPlayAreaCardAttachedEnergies
	xor a
	call CreateArenaOrBenchEnergyCardList
	jr nc, .asm_685ef
	ld a, $ff
	jr .asm_68624
.asm_685ef
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call LoadCardDataToBuffer1_FromDeckIndex
	ld e, $06
	ld a, [wAttachedEnergies + 6]
	or a
	jr nz, .asm_6860f
	ld a, [wLoadedCard1Type]
	cp $06
	jr nc, .asm_68628
	ld e, a
	ld d, $00
	ld hl, wAttachedEnergies
	add hl, de
	ld a, [hl]
	or a
	jr z, .asm_68628
.asm_6860f
	ld hl, wDuelTempList
.asm_68612
	ld a, [hli]
	cp $ff
	jr z, .asm_68628
	call LoadCardDataToBuffer2_FromDeckIndex
	ld a, [wLoadedCard2Type]
	and $07
	cp e
	jr nz, .asm_68612
	dec hl
.asm_68623
	ld a, [hl]
.asm_68624
	call SwapTurn
	ret
.asm_68628
	call CountCardsInDuelTempList
	ld hl, wDuelTempList
	call ShuffleCards
	jr .asm_68623

Func_68633:
	call SwapTurn
	ld e, $00
	call GetPlayAreaCardAttachedEnergies
	bank1call HandleEnergyBurn
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	ld d, a
	call LoadCardDataToBuffer2_FromDeckIndex
	ld hl, wLoadedCard2Atk1Name
	ld a, [hli]
	or [hl]
	jr z, .asm_6865e
	ld e, $01
	bank1call CheckIfEnoughEnergiesToAttack.CheckEnergy
	jr nc, .asm_6865e
	ld e, $00
	ld a, [wLoadedCard2Atk1Category]
	cp $04
	jr nz, .asm_6865e
	ld e, $01
.asm_6865e
	ld a, e
	ldh [hTemp_ffa0], a
	call SwapTurn
	ret

Func_68665:
	ld a, $ff
	ldh [hTemp_ffa0], a
	call Func_6843b
	ret c
	ldtx hl, ChooseBenchedPokemonToGiveDamageText
	call DrawWideTextBox_WaitForInput
	call SwapTurn
	bank1call HasAlivePokemonInBench
.asm_68679
	bank1call OpenPlayAreaScreenForSelection
	jr c, .asm_68679
	ldh a, [hTempPlayAreaLocation_ff9d]
	ldh [hTemp_ffa0], a
	call SwapTurn
	ret

Func_68686:
	ldtx hl, ChoosePokemonToGiveDamageText
	call DrawWideTextBox_WaitForInput
	call SwapTurn
	bank1call HasAlivePokemonInPlayArea
.asm_68692
	bank1call OpenPlayAreaScreenForSelection
	jr c, .asm_68692
	call SwapTurn
	ldh [hTemp_ffa0], a
	ret

Func_6869d:
	call SwapTurn
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	ld c, a
	ld b, $00
	ld de, $1ff
	ld a, DUELVARS_BENCH1_CARD_HP
	get_turn_duelist_var
	jr .asm_686b5
.asm_686ae
	ld a, e
	cp [hl]
	jr c, .asm_686b4
	ld e, [hl]
	ld d, b
.asm_686b4
	inc hl
.asm_686b5
	inc b
	dec c
	jr nz, .asm_686ae
	ld a, d
	call SwapTurn
	ret

Func_686be:
	call SwapTurn
	bank1call HandleNoDamageOrEffectSubstatus
	jr c, .asm_686ef
	ld a, $01
	ldh [hTempPlayAreaLocation_ff9d], a
	bank1call CheckArticunoAuroraVeil
	jr c, .asm_68700
	xor a
	ld [wNoDamageOrEffect], a
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	ld c, a
	ld de, $ff
	ld b, $00
	ld a, DUELVARS_ARENA_CARD_HP
	get_turn_duelist_var
.asm_686df
	ld a, e
	cp [hl]
	jr c, .asm_686e5
	ld e, [hl]
	ld d, b
.asm_686e5
	inc hl
	inc b
	dec c
	jr nz, .asm_686df
	ld a, d
	call SwapTurn
	ret
.asm_686ef
	xor a
	ld [wNoDamageOrEffect], a
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	cp $02
	jr c, .asm_68700
	call SwapTurn
	jp Func_6869d
.asm_68700
	call SwapTurn
	xor a
	ld [wNoDamageOrEffect], a
	ret

Func_68708:
	add a
	ld e, a
	ld d, $00
	ld hl, Data_68723
	add hl, de
	ld de, wTxRam2
	ld a, [wLoadedCard1Name]
	ld [de], a
	inc de
	ld a, [wLoadedCard1Name + 1]
	ld [de], a
	inc de
	ld a, [hli]
	ld [de], a
	inc de
	ld a, [hli]
	ld [de], a
	ret

Data_68723: ; text pointers?
	db $49, $00
	db $48, $00
	db $4b, $00
	db $4a, $00
	db $4c, $00
	db $4d, $00

Func_6872f:
	ld c, a
	add a
	add c
	add $02
	ld c, a
	ld a, b
	ld b, $00
	call WriteByteToBGMap0
	ret

Func_6873c:
	ldtx hl, IncompleteText
	call DrawWideTextBox_WaitForInput
	ret

Data_68743:
	db $00
	db $00
	db $03
	db $06
	db $0f
	db $00
	db $00
	db $00
	db $00
	db $03
	db $03
	db $06
	db $0f
	db $00
	db $00
	db $00

EkansLv10SpitPoison_AI:
	ld a, 5
	lb de, 0, 10
	call Func_680dd
	ret

EkansLv10SpitPoison_BeforeDamage:
	ldtx de, PoisonInflictionCheckText
	call TossCoin_Bank1a
	jp c, Func_68012
	ld a, $8c
	ld [wLoadedAttackAnimation], a
	call Func_68094
	ret

EkansLv10Wrap_BeforeDamage:
	call Func_68027
	ret

ArbokLv27TerrorStrike_InitialEffect1:
	call Func_6808d
	ret

ArbokLv27TerrorStrike_RequireSelection:
	xor a
	ldh [hTemp_ffa0], a
	call Func_6843b
	ret c
	ldtx de, IfHeadsSwitchOutOpponentsActivePokemonText
	call Func_68079
	ldh [hTemp_ffa0], a
	ret nc
	call HandleMandatorySwitchSelection
	ldh a, [hTempPlayAreaLocation_ff9d]
	ldh [hTempPlayAreaLocation_ffa1], a
	ret

ArbokLv27TerrorStrike_AfterDamage:
	ldh a, [hTemp_ffa0]
	or a
	ret z
	ldh a, [hTempPlayAreaLocation_ffa1]
	call Func_6828a
	ret

ArbokLv27PoisonFang_AI:
	ld a, $0a
	ld de, $a0a
	call Func_680b6
	ret

ArbokLv27PoisonFang_BeforeDamage:
	call Func_68012
	ret

WeepinbellLv28PoisonPowder_AI:
	ld a, $05
	ld de, $a
	call Func_680b6
	ret

WeepinbellLv28PoisonPowder_BeforeDamage:
	call Func_6800b
	ret

VictreebelLure_InitialEffect1:
	call Func_6843b
	ret

VictreebelLure_RequireSelection:
	ldtx hl, SelectBenchedPokemonToSwitchWithActiveText
	call DrawWideTextBox_WaitForInput
	call SwapTurn
	bank1call HasAlivePokemonInBench
.asm_687c2
	bank1call OpenPlayAreaScreenForSelection
	jr c, .asm_687c2
	ldh a, [hTempPlayAreaLocation_ff9d]
	ldh [hTemp_ffa0], a
	call SwapTurn
	ret

VictreebelLure_AISelection:
	call Func_6869d
	ldh [hTemp_ffa0], a
	ret

VictreebelLure_AfterDamage:
	call SwapTurn
	ldh a, [hTemp_ffa0]
	ld e, a
	bank1call Func_6f49
	call nc, SwapArenaWithBenchPokemon
	call SwapTurn
	xor a
	ld [wDuelDisplayedScreen], a
	ret

VictreebelAcid_BeforeDamage:
	ldtx de, AcidCheckText
	call TossCoin_Bank1a
	ret nc
	ld a, $09
	call Func_6812e
	ret

PinsirLv24Irongrip_BeforeDamage:
	call Func_68027
	ret

CaterpieStringShot_BeforeDamage:
	call Func_68027
	ret

GloomPoisonPowder_AI:
	ld a, $0a
	ld de, $a0a
	call Func_680b6
	ret

GloomPoisonPowder_BeforeDamage:
	call Func_68012
	ret

GloomFoulOdor_BeforeDamage:
	call Func_68045
	call SwapTurn
	call Func_68045
	call SwapTurn
	ret

KakunaLv23Stiffen_BeforeDamage:
	ldtx de, IfHeadsNoDamageNextTurnText
	call TossCoin_Bank1a
	jp nc, Func_6809a
	ld a, $4f
	ld [wLoadedAttackAnimation], a
	ld a, $14
	call Func_68127
	ret

KakunaLv23PoisonPowder_AI:
	ld a, $05
	ld de, $a
	call Func_680b6
	ret

KakunaLv23PoisonPowder_BeforeDamage:
	call Func_6800b
	ret

GolbatLv29LeechLife_AfterDamage:
	ld hl, wDealtDamage
	ld e, [hl]
	inc hl
	ld d, [hl]
	call ApplyAndAnimateHPRecovery
	ret

VenonatLv12StunSpore_BeforeDamage:
	call Func_68027
	ret

VenonatLv12LeechLife_AfterDamage:
	ld hl, wDealtDamage
	ld e, [hl]
	inc hl
	ld d, [hl]
	call ApplyAndAnimateHPRecovery
	ret

ScytherLv25SwordsDance_BeforeDamage:
	ld a, $1e
	call Func_6810e
	ret

ZubatLv10Supersonic_BeforeDamage:
	call Func_68033
	ret

ZubatLv10LeechLife_AfterDamage:
	ld hl, wDealtDamage
	ld e, [hl]
	inc hl
	ld d, [hl]
	call ApplyAndAnimateHPRecovery
	ret

BeedrillTwineedle_AI:
	ld a, 30
	lb de, 0, 60
	call Func_680dd
	ret

BeedrillTwineedle_BeforeDamage:
	ld hl, $1e
	call LoadTxRam3
	ldtx de, DamageCheckXDamageTimesHeadsText
	ld a, $02
	call Func_68069
	ld e, a
	add a
	add e
	call ATimes10
	call Func_6817e
	ret

BeedrillPoisonSting_AI:
	ld a, $05
	ld de, $a
	call Func_680b6
	ret

BeedrillPoisonSting_BeforeDamage:
	call Func_6800b
	ret

ExeggcuteHypnosisMove_BeforeDamage:
	call Func_6805c
	ret

ExeggcuteLeechSeedAlt_AfterDamage:
	ld hl, wDealtDamage
	ld a, [hli]
	or [hl]
	ret z
	ld de, $a
	call ApplyAndAnimateHPRecovery
	ret

KoffingLv13FoulGas_AI:
	ld a, $05
	ld de, $a
	jp Func_680cb

KoffingLv13FoulGas_BeforeDamage:
	ldtx de, PoisonedIfHeadsConfusedIfTailsText
	call TossCoin_Bank1a
	jp c, Func_68012
	jp Func_68045

MetapodLv21Stiffen_BeforeDamage:
	ldtx de, IfHeadsNoDamageNextTurnText
	call TossCoin_Bank1a
	jp nc, Func_6809a
	ld a, $4f
	ld [wLoadedAttackAnimation], a
	ld a, $14
	call Func_68127
	ret

MetapodLv21StunSpore_BeforeDamage:
	call Func_68027
	ret

OddishLv8StunSpore_BeforeDamage:
	call Func_68027
	ret

OddishLv8Sprout_InitialEffect1:
	farcall Func_2435f
	ret c
	farcall Func_24369
	ret

OddishLv8Sprout_RequireSelection:
	call CreateDeckCardList
	ldtx hl, ChooseAnOddishFromDeckText
	ldtx bc, EffectTargetOddishText
	ld de, DEX_ODDISH
	ld a, CARDSEARCH_POKEDEX_NUMBER
	farcall Func_24c9d
	jr c, .asm_688fc
	ldtx hl, ChooseAnOddishText
	ldtx de, DuelistDeckText
	farcall Func_24df8
.asm_688fc
	ldh [hTemp_ffa0], a
	ret

OddishLv8Sprout_AISelection:
	ld de, DEX_ODDISH
	ld a, CARDSEARCH_POKEDEX_NUMBER
	farcall SetCardSearchFuncParams
	call CreateDeckCardList
	ld hl, wDuelTempList
.asm_6890e
	ld a, [hli]
	ldh [hTemp_ffa0], a
	cp $ff
	ret z
	farcall ExecuteCardSearchFunc
	jr nc, .asm_6890e
	ret

OddishLv8Sprout_AfterDamage:
	ldh a, [hTemp_ffa0]
	cp $ff
	jr z, .asm_68937
	call SearchCardInDeckAndAddToHand
	call AddCardToHand
	call PutHandPokemonCardInPlayArea
	call Func_680ab
	jr c, .asm_68937
	ldh a, [hTemp_ffa0]
	ldtx hl, PlacedOnBenchText
	bank1call DisplayCardDetailScreen
.asm_68937
	call Func_680a0
	ret

ExeggutorTeleport_InitialEffect1:
	call Func_68446
	ret

ExeggutorTeleport_RequireSelection:
	ldtx hl, SelectBenchedPokemonToSwitchWithActiveText
	call DrawWideTextBox_WaitForInput
	bank1call HasAlivePokemonInBench
.asm_68948
	bank1call OpenPlayAreaScreenForSelection
	jr c, .asm_68948
	ldh a, [hTempPlayAreaLocation_ff9d]
	ldh [hTemp_ffa0], a
	ret

ExeggutorTeleport_AISelection:
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	call Random
	ldh [hTemp_ffa0], a
	ret

ExeggutorTeleport_AfterDamage:
	ldh a, [hTemp_ffa0]
	ld e, a
	call SwapArenaWithBenchPokemon
	xor a
	ld [wDuelDisplayedScreen], a
	ret

ExeggutorBigEggsplosion_AI:
	ldh a, [hTempPlayAreaLocation_ff9d]
	ld e, a
	call GetPlayAreaCardAttachedEnergies
	ld a, [wTotalAttachedEnergies]
	call Func_68999
	inc h
	jr nz, .asm_68977
	ld l, $ff
.asm_68977
	ld a, l
	ld [wAIMaxDamage], a
	srl a
	ld [wDamage], a
	xor a
	ld [wAIMinDamage], a
	ret

ExeggutorBigEggsplosion_BeforeDamage:
	ld e, $00
	call GetPlayAreaCardAttachedEnergies
	ld hl, $14
	call LoadTxRam3
	ld a, [wTotalAttachedEnergies]
	ldtx de, DamageCheckXDamageTimesHeadsText
	call Func_68069

Func_68999:
	ld l, a
	ld h, $00
	ld e, l
	ld d, h
	add hl, hl
	add hl, hl
	add hl, de
	add hl, hl
	add hl, hl
	ld a, l
	ld [wDamage], a
	ld a, h
	ld [wDamage + 1], a
	ret

NidokingThrash_AI:
	ld a, 35
	ld de, LoadSymbolsFont
	call Func_680dd
	ret

NidokingThrash_BeforeDamage:
	ldtx de, IfHeadPlus10IfTails10ToYourselfText
	call TossCoin_Bank1a
	ldh [hTemp_ffa0], a
	ret nc
	ld a, $0a
	call Func_68163
	ret

NidokingThrash_AfterDamage:
	ldh a, [hTemp_ffa0]
	or a
	ret nz
	ld a, $0a
	call DealRecoilDamageToSelf
	ret

NidokingToxic_AI:
	ld a, $14
	ld de, $1414
	jp Func_680cb

NidokingToxic_BeforeDamage:
	call Func_68017
	ret

NidoqueenBoyfriends_BeforeDamage:
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	ld c, $00
.asm_689df
	ld a, [hl]
	cp $ff
	jr z, .asm_689f5
	call GetCardIDFromDeckIndex
	ld a, e
	cp $2d
	jr nz, .asm_689f2
	ld a, d
	cp $00
	jr nz, .asm_689f2
	inc c
.asm_689f2
	inc hl
	jr .asm_689df
.asm_689f5
	ld a, c
	add a
	call ATimes10
	call Func_68163
	ret

NidoranFLv13FurySwipes_AI:
	ld a, 15
	lb de, 0, 30
	call Func_680dd
	ret

NidoranFLv13FurySwipes_BeforeDamage:
	ld hl, $a
	call LoadTxRam3
	ldtx de, DamageCheckXDamageTimesHeadsText
	ld a, $03
	call Func_68069
	call ATimes10
	call Func_6817e
	ret

NidoranFLv13CallForFamily_InitialEffect1:
	farcall Func_2435f
	ret c
	farcall Func_24369
	ret

NidoranFLv13CallForFamily_RequireSelection:
	call CreateDeckCardList
	ldtx hl, ChooseNidoranFromDeckText
	ldtx bc, EffectTargetNidoranMNidoranFText
	ld a, CARDSEARCH_NIDORAN
	farcall Func_24c9d
	jr c, .asm_68a41
	ldtx hl, ChooseNidoranText
	ldtx de, DuelistDeckText
	farcall Func_24df8
.asm_68a41
	ldh [hTemp_ffa0], a
	ret

NidoranFLv13CallForFamily_AISelection:
	ld a, CARDSEARCH_NIDORAN
	farcall SetCardSearchFuncParams
	call CreateDeckCardList
	ld hl, wDuelTempList
.asm_68a50
	ld a, [hli]
	ldh [hTemp_ffa0], a
	cp $ff
	ret z
	farcall ExecuteCardSearchFunc
	jr nc, .asm_68a50
	ret

NidoranFLv13CallForFamily_AfterDamage:
	ldh a, [hTemp_ffa0]
	cp $ff
	jr z, .asm_68a79
	call SearchCardInDeckAndAddToHand
	call AddCardToHand
	call PutHandPokemonCardInPlayArea
	call Func_680ab
	jr c, .asm_68a79
	ldh a, [hTemp_ffa0]
	ldtx hl, PlacedOnBenchText
	bank1call DisplayCardDetailScreen
.asm_68a79
	call Func_680a0
	ret

NidoranMLv20HornHazard_AI:
	ld a, 30
	lb de, 0, 30
	call Func_680dd
	ret

NidoranMLv20HornHazard_BeforeDamage:
	ldtx de, DamageCheckIfTailsNoDamageText
	call TossCoin_Bank1a
	jr c, .asm_68a96
	xor a
	call Func_6817e
	call Func_6809a
	ret
.asm_68a96
	ld a, $01
	ld [wLoadedAttackAnimation], a
	ret

NidorinaLv24Supersonic_BeforeDamage:
	call Func_68033
	ret

NidorinaLv24DoubleKick_AI:
	ld a, 30
	lb de, 0, 60
	call Func_680dd
	ret

NidorinaLv24DoubleKick_BeforeDamage:
	ld hl, $1e
	call LoadTxRam3
	ldtx de, DamageCheckXDamageTimesHeadsText
	ld a, $02
	call Func_68069
	ld e, a
	add a
	add e
	call ATimes10
	call Func_6817e
	ret

NidorinoLv25DoubleKick_AI:
	ld a, 30
	lb de, 0, 60
	call Func_680dd
	ret

NidorinoLv25DoubleKick_BeforeDamage:
	ld hl, $1e
	call LoadTxRam3
	ldtx de, DamageCheckXDamageTimesHeadsText
	ld a, $02
	call Func_68069
	ld e, a
	add a
	add e
	call ATimes10
	call Func_6817e
	ret

ButterfreeWhirlwind_RequireSelection:
	call HandleMandatorySwitchSelection
	ldh a, [hTempPlayAreaLocation_ff9d]
	ldh [hTemp_ffa0], a
	ret

ButterfreeWhirlwind_AfterDamage:
	ldh a, [hTemp_ffa0]
	call Func_6828a
	ret

ButterfreeMegaDrain_AfterDamage:
	ld hl, wDealtDamage
	ld a, [hli]
	ld h, [hl]
	ld l, a
	srl h
	rr l
	bit 0, l
	jr z, .asm_68b02
	ld de, $5
	add hl, de
.asm_68b02
	ld e, l
	ld d, h
	call ApplyAndAnimateHPRecovery
	ret

ParasLv8Spore_BeforeDamage:
	call Func_6805c
	ret

ParasectLv28Spore_BeforeDamage:
	call Func_6805c
	ret

WeedleLv12PoisonSting_AI:
	ld a, $05
	ld de, $a
	call Func_680b6
	ret

WeedleLv12PoisonSting_BeforeDamage:
	call Func_6800b
	ret

IvysaurLv20PoisonPowder_AI:
	ld a, $0a
	ld de, $a0a
	call Func_680b6
	ret

IvysaurLv20PoisonPowder_BeforeDamage:
	call Func_68012
	ret

BulbasaurLv13LeechSeed_AfterDamage:
	ld hl, wDealtDamage
	ld a, [hli]
	or [hl]
	ret z
	ld de, $a
	call ApplyAndAnimateHPRecovery
	ret

VenusaurLv67EnergyTrans_InitialEffect2:
	jr Func_68b40

VenusaurLv67EnergyTrans_RequireSelection:
	jr Func_68b79

VenusaurLv67EnergyTrans_BeforeDamage:
	jr Func_68b81

VenusaurLv67EnergyTrans_Unk11:
	jp Func_68c14

Func_68b40:
	ldh a, [hTempPlayAreaLocation_ff9d]
	ldh [hTemp_ffa0], a
	ldh a, [hTempPlayAreaLocation_ff9d]
	bank1call CheckIsIncapableOfUsingPkmnPower
	ret c
	ld a, DUELVARS_CARD_LOCATIONS
	get_turn_duelist_var
.asm_68b4d
	ld a, [hl]
	and $10
	jr z, .asm_68b6c
	push hl
	ld a, l
	call GetCardIDFromDeckIndex
	pop hl
	cp16 GRASS_ENERGY
	jr z, .asm_68b77
	cp16 RAINBOW_ENERGY
	jr z, .asm_68b77
.asm_68b6c
	inc l
	ld a, l
	cp $3c
	jr c, .asm_68b4d
	ld hl, $d9
	scf
	ret
.asm_68b77
	or a
	ret

Func_68b79:
	ldtx hl, ProcedureForEnergyTransferText
	bank1call Func_5475
	or a
	ret

Func_68b81:
	ld a, DUELVARS_DUELIST_TYPE
	get_turn_duelist_var
	cp $00
	jr z, .asm_68b8f
	bank1call Func_5c30
	bank1call PrintPlayAreaCardList_EnableLCD
	ret
.asm_68b8f
	xor a
	ldh [hffb2], a
	bank1call Func_5c30
.asm_68b95
	bank1call PrintPlayAreaCardList_EnableLCD
	push af
	ldh a, [hffb2]
	ld hl, Data_68743
	call InitializeMenuParameters
	pop af
	ld [wNumScrollMenuItems], a
.asm_68ba5
	call DoFrame
	call HandleMenuInput
	jr nc, .asm_68ba5
	cp $ff
	ret z
	ldh [hTempPlayAreaLocation_ffa1], a
	ldh [hffb2], a
	call Func_68c23
	jr c, .asm_68c0f
	ldh [hTempRetreatCostCards], a
	ldh a, [hTempRetreatCostCards]
	call AddCardToHand
	bank1call PrintPlayAreaCardList_EnableLCD
	ldh a, [hTempPlayAreaLocation_ffa1]
	ld e, a
	ldh a, [hTempRetreatCostCards]
	call PutHandCardInPlayArea
	ldh a, [hTempRetreatCostCards]
	ld b, $02
	call GetCardIDFromDeckIndex
	cp16 GRASS_ENERGY
	jr z, .asm_68bde
	ld b, $08
.asm_68bde
	ldh a, [hTempPlayAreaLocation_ffa1]
	call Func_6872f
.asm_68be3
	call DoFrame
	call HandleMenuInput
	jr nc, .asm_68be3
	cp $ff
	jr z, .asm_68c03
	ldh [hffb2], a
	ldh [hAIEnergyTransPlayAreaLocation], a
	ld a, $16
	call SetOppAction_SerialSendDuelData
	ldh a, [hAIEnergyTransPlayAreaLocation]
	ld e, a
	ldh a, [hTempRetreatCostCards]
	call AddCardToHand
	call PutHandCardInPlayArea
.asm_68c03
	ldh a, [hTempPlayAreaLocation_ffa1]
	ld b, $00
	call Func_6872f
	call EraseCursor
	jr .asm_68b95
.asm_68c0f
	call Func_3071
	jr .asm_68ba5

Func_68c14:
	ldh a, [hAIEnergyTransPlayAreaLocation]
	ld e, a
	ldh a, [hTempRetreatCostCards]
	call AddCardToHand
	call PutHandCardInPlayArea
	bank1call PrintPlayAreaCardList_EnableLCD
	ret

Func_68c23:
	or $10
	ld e, a
	ld bc, $a
	call Func_68c30
	ret nc
	ld bc, $1

Func_68c30:
	ld a, DUELVARS_CARD_LOCATIONS
	get_turn_duelist_var
.asm_68c33
	ld a, [hl]
	cp e
	jr nz, .asm_68c47
	push de
	push hl
	ld a, l
	call GetCardIDFromDeckIndex
	ld a, d
	cp b
	jr nz, .asm_68c43
	ld a, e
	cp c
.asm_68c43
	pop hl
	pop de
	jr z, .asm_68c4f
.asm_68c47
	inc l
	ld a, l
	cp $3c
	jr c, .asm_68c33
	scf
	ret
.asm_68c4f
	ld a, l
	or a
	ret

VenusaurAltLv67EnergyTrans_InitialEffect2:
	jp Func_68b40

VenusaurAltLv67EnergyTrans_RequireSelection:
	jp Func_68b79

VenusaurAltLv67EnergyTrans_BeforeDamage:
	jp Func_68b81

VenusaurAltLv67EnergyTrans_Unk11:
	jr Func_68c14

GrimerLv17NastyGoo_BeforeDamage:
	call Func_68027
	ret

GrimerLv17Minimize_BeforeDamage:
	ld a, $18
	call Func_68127
	ret

MukToxicGas_InitialEffect1:
	scf
	ret

MukSludgeMove_AI:
	ld a, $05
	ld de, $a
	call Func_680b6
	ret

MukSludgeMove_BeforeDamage:
	call Func_6800b
	ret

BellsproutLv11CallForFamily_InitialEffect1:
	farcall Func_2435f
	ret c
	farcall Func_24369
	ret

BellsproutLv11CallForFamily_RequireSelection:
	call CreateDeckCardList
	ldtx hl, ChooseABellsproutFromDeckText
	ldtx bc, EffectTargetBellsproutText
	ld de, DEX_BELLSPROUT
	ld a, CARDSEARCH_POKEDEX_NUMBER
	farcall Func_24c9d
	jr c, .asm_68c9e
	ldtx hl, ChooseABellsproutText
	ldtx de, DuelistDeckText
	farcall Func_24df8
.asm_68c9e
	ldh [hTemp_ffa0], a
	ret

BellsproutLv11CallForFamily_AISelection:
	ld de, DEX_BELLSPROUT
	ld a, CARDSEARCH_POKEDEX_NUMBER
	farcall SetCardSearchFuncParams
	call CreateDeckCardList
	ld hl, wDuelTempList
.asm_68cb0
	ld a, [hli]
	ldh [hTemp_ffa0], a
	cp $ff
	ret z
	farcall ExecuteCardSearchFunc
	jr nc, .asm_68cb0
	ret

BellsproutLv11CallForFamily_AfterDamage:
	ldh a, [hTemp_ffa0]
	cp $ff
	jr z, .asm_68cd9
	call SearchCardInDeckAndAddToHand
	call AddCardToHand
	call PutHandPokemonCardInPlayArea
	call Func_680ab
	jr c, .asm_68cd9
	ldh a, [hTemp_ffa0]
	ldtx hl, PlacedOnBenchText
	bank1call DisplayCardDetailScreen
.asm_68cd9
	call Func_680a0
	ret

WeezingLv27Smog_AI:
	ld a, $05
	ld de, $a
	call Func_680b6
	ret

WeezingLv27Smog_BeforeDamage:
	call Func_6800b
	ret

WeezingLv27Selfdestruct_AfterDamage:
	ld a, $3c
	call DealRecoilDamageToSelf
	call Func_6806e
	ld a, $0a
	call Func_680f9
	call SwapTurn
	call Func_68074
	ld a, $0a
	call Func_680f9
	call SwapTurn
	ret

VenomothLv28Shift_InitialEffect2:
	jp Func_6844f

VenomothLv28Shift_RequireSelection:
.asm_68d09
	ld hl, $169
	ldh a, [hTemp_ffa0]
	or $80
	farcall Func_24ebf
	ldh [hTempPlayAreaLocation_ffa1], a
	ret c
	call Func_68d2d
	ret nc
	call SwapTurn
	call Func_68d2d
	call SwapTurn
	ret nc
	ldtx hl, UnableToSelectText
	call DrawWideTextBox_WaitForInput
	jr .asm_68d09

Func_68d2d:
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	ld c, a
	ld b, $00
.asm_68d33
	push bc
	ld a, b
	bank1call GetPlayAreaCardColor
	pop bc
	ld hl, hTempPlayAreaLocation_ffa1
	cp [hl]
	ret z
	inc b
	dec c
	jr nz, .asm_68d33
	scf
	ret

VenomothLv28Shift_BeforeDamage:
	call Func_68465
	ldh a, [hTemp_ffa0]
	add DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call LoadCardDataToBuffer1_FromDeckIndex
	ldh a, [hTemp_ffa0]
	add $d4
	ld l, a
	ldh a, [hTempPlayAreaLocation_ffa1]
	or $80
	ld [hl], a
	call Func_68708
	ldtx hl, ChangedTheColorOfPokemonToColorText
	call DrawWideTextBox_WaitForInput
	ret

VenomothLv28VenomPowder_AI:
	ld a, $05
	ld de, $a
	jp Func_680cb

VenomothLv28VenomPowder_BeforeDamage:
	ldtx de, VenomPowderCheckText
	call TossCoin_Bank1a
	ret nc
	call Func_68012
	call Func_68045
	ret c
	ld a, $81
	ld [wNoEffectFromWhichStatus], a
	ret

TangelaLv8Bind_BeforeDamage:
	call Func_68027
	ret

TangelaLv8PoisonPowder_AI:
	ld a, $05
	ld de, $a
	call Func_680b6
	ret

TangelaLv8PoisonPowder_BeforeDamage:
	call Func_68012
	ret

VileplumeHeal_InitialEffect2:
	call Func_6844f
	ret c
	call Func_68335
	ld hl, $b5
	ret

VileplumeHeal_BeforeDamage:
	ldtx de, HealSuccessCheckText
	call TossCoin_Bank1a
	ldh [hTempPlayAreaLocation_ffa1], a
	jr nc, .asm_68ddb
	ld a, DUELVARS_DUELIST_TYPE
	get_turn_duelist_var
	cp $01
	jr z, .asm_68dd0
	and $80
	jr nz, .asm_68ddb
	ldtx hl, ChoosePokemonToRemoveDamageCounterFromText
	call DrawWideTextBox_WaitForInput
	bank1call HasAlivePokemonInPlayArea
.asm_68db9
	bank1call OpenPlayAreaScreenForSelection
	jr c, .asm_68db9
	ldh a, [hTempPlayAreaLocation_ff9d]
	ldh [hTempRetreatCostCards], a
	ld e, a
	call GetCardDamageAndMaxHP
	or a
	jr z, .asm_68db9
	ldh a, [hTempPlayAreaLocation_ff9d]
	call SerialSend8Bytes
	jr .asm_68ddb
.asm_68dd0
	call LoadSymbolsFont
	call LoadDuelCardSymbolTiles
	call SerialRecv8Bytes
	ldh [hTempRetreatCostCards], a
.asm_68ddb
	call Func_68465
	ldh a, [hTempPlayAreaLocation_ffa1]
	or a
	ret z
	ldh a, [hTempRetreatCostCards]
	add DUELVARS_ARENA_CARD_HP
	get_turn_duelist_var
	add $0a
	ld [hl], a
	ldh a, [hTempRetreatCostCards]
	call Func_680ed
	call ExchangeRNG
	ret

VileplumePetalDance_AI:
	ld a, 60
	lb de, 0, 120
	call Func_680dd
	ret

VileplumePetalDance_BeforeDamage:
	ld hl, $28
	call LoadTxRam3
	ldtx de, DamageCheckXDamageTimesHeadsText
	ld a, $03
	call Func_68069
	add a
	add a
	call ATimes10
	call Func_6817e
	call SwapTurn
	call Func_68045
	call SwapTurn
	ret

TangelaLv12StunSpore_BeforeDamage:
	call Func_68027
	ret

TangelaLv12PoisonWhip_AI:
	ld a, $0a
	ld de, $a0a
	call Func_680b6
	ret

TangelaLv12PoisonWhip_BeforeDamage:
	call Func_68012
	ret

VenusaurLv64SolarPower_InitialEffect2:
	call Func_6844f
	ret c
	ld a, DUELVARS_ARENA_CARD_STATUS
	get_turn_duelist_var
	or a
	jr nz, .asm_68e43
	ld a, $ec
	call GetNonTurnDuelistVariable
	or a
	jr nz, .asm_68e43
	ld hl, $be
	scf
.asm_68e43
	ret

VenusaurLv64SolarPower_BeforeDamage:
	ld a, $8e
	ld [wLoadedAttackAnimation], a
	farcall ResetAttackAnimationIsPlaying
	ldh a, [hTempPlayAreaLocation_ff9d]
	ld b, a
	ld c, $00
	ldh a, [hWhoseTurn]
	ld h, a
	farcall PlayAttackAnimation
	farcall WaitAttackAnimation
	call Func_68465
	ld a, DUELVARS_ARENA_CARD_STATUS
	get_turn_duelist_var
	ld [hl], $00
	ld a, $ec
	call GetNonTurnDuelistVariable
	ld [hl], $00
	bank1call DrawDuelHUDs
	ret

VenusaurLv64MegaDrain_AfterDamage:
	ld hl, wDealtDamage
	ld a, [hli]
	ld h, [hl]
	ld l, a
	srl h
	rr l
	bit 0, l
	jr z, .asm_68e82
	ld de, $5
	add hl, de
.asm_68e82
	ld e, l
	ld d, h
	call ApplyAndAnimateHPRecovery
	ret

Func_68e88:
	call Func_68e97
	call Func_68ec8
	ret

Func_68e8f:
	call Func_68e97
	add a
	call Func_68ec8
	ret

Func_68e97:
	ld a, [wMetronomeEnergyCost]
	or a
	jr z, .asm_68ea0
	ld c, a
	ld b, $00
.asm_68ea0
	push bc
	ldh a, [hTempPlayAreaLocation_ff9d]
	ld e, a
	call GetPlayAreaCardAttachedEnergies
	ld a, [wAttachedEnergies + 7]
	ld hl, wAttachedEnergies + 3
	add [hl]
	ld e, a
	ld a, [wTotalAttachedEnergies]
	sub e
	ld d, a
	pop bc
	ld a, d
	sub c
	jr nc, .asm_68ebb
	add e
	ld e, a
.asm_68ebb
	ld a, e
	sub b
	jr c, .asm_68ec6
	cp $03
	jr c, .asm_68ec5
	ld a, $02
.asm_68ec5
	ret
.asm_68ec6
	xor a
	ret

Func_68ec8:
	call ATimes10
	call Func_68163
	ld a, [wDamage]
	ld [wAIMinDamage], a
	ld [wAIMaxDamage], a
	ret

OmastarLv32WaterGun_BeforeDamage:
	ld bc, $101
	jr Func_68e88

OmastarLv32SpikeCannon_AI:
	ld a, 30
	lb de, 0, 60
	call Func_680dd
	ret

OmastarLv32SpikeCannon_BeforeDamage:
	ld hl, $1e
	call LoadTxRam3
	ld a, $02
	ldtx de, DamageCheckXDamageTimesHeadsText
	call Func_68069
	ld e, a
	add a
	add e
	call ATimes10
	call Func_6817e
	ret

OmanyteLv19Clairvoyance_InitialEffect2:
	ldh a, [hTempPlayAreaLocation_ff9d]
	ldh [hTemp_ffa0], a
	ldh a, [hTempPlayAreaLocation_ff9d]
	bank1call CheckIsIncapableOfUsingPkmnPower
	ret

OmanyteLv19Clairvoyance_BeforeDamage:
	call Func_680ab
	ret nc
	bank1call Func_43d9
	ret

OmanyteLv19WaterGun_BeforeDamage:
	ld bc, $100
	jp Func_68e88

WartortleLv22Withdraw_BeforeDamage:
	ldtx de, IfHeadsNoDamageNextTurnText
	call TossCoin_Bank1a
	jp nc, Func_6809a
	ld a, $4f
	ld [wLoadedAttackAnimation], a
	ld a, $15
	call Func_68127
	ret

BlastoiseLv52RainDance_InitialEffect1:
	scf
	ret

BlastoiseLv52HydroPump_BeforeDamage:
	ld bc, $300
	jp Func_68e88

BlastoiseAltLv52RainDance_InitialEffect1:
	scf
	ret

BlastoiseAltLv52HydroPump_BeforeDamage:
	jr BlastoiseLv52HydroPump_BeforeDamage

GyaradosBubblebeam_BeforeDamage:
	call Func_68027
	ret

KinglerLv27Flail_AI:
	ldh a, [hTempPlayAreaLocation_ff9d]
	jr Func_68f3f

KinglerLv27Flail_BeforeDamage:
	xor a
;	fallthrough

Func_68f3f:
	ld e, a
	call GetCardDamageAndMaxHP
	call Func_6817e
	ret

KrabbyLv20CallForFamily_InitialEffect1:
	farcall Func_2435f
	ret c
	farcall Func_24369
	ret

KrabbyLv20CallForFamily_RequireSelection:
	call CreateDeckCardList
	ldtx hl, ChooseAKrabbyFromDeckText
	ldtx bc, EffectTargetKrabbyText
	ld de, DEX_KRABBY
	ld a, CARDSEARCH_POKEDEX_NUMBER
	farcall Func_24c9d
	jr c, .asm_68f6f
	ldtx hl, ChooseAKrabbyText
	ldtx de, DuelistDeckText
	farcall Func_24df8
.asm_68f6f
	ldh [hTemp_ffa0], a
	ret

KrabbyLv20CallForFamily_AISelection:
	ld de, DEX_KRABBY
	ld a, CARDSEARCH_POKEDEX_NUMBER
	farcall SetCardSearchFuncParams
	call CreateDeckCardList
	ld hl, wDuelTempList
.asm_68f81
	ld a, [hli]
	ldh [hTemp_ffa0], a
	cp $ff
	ret z
	farcall ExecuteCardSearchFunc
	jr nc, .asm_68f81
	ret

KrabbyLv20CallForFamily_AfterDamage:
	ldh a, [hTemp_ffa0]
	cp $ff
	jr z, .asm_68faa
	call SearchCardInDeckAndAddToHand
	call AddCardToHand
	call PutHandPokemonCardInPlayArea
	call Func_680ab
	jr c, .asm_68faa
	ldh a, [hTemp_ffa0]
	ldtx hl, PlacedOnBenchText
	bank1call DisplayCardDetailScreen
.asm_68faa
	call Func_680a0
	ret

MagikarpLv8Flail_AI:
	ldh a, [hTempPlayAreaLocation_ff9d]
	jr Func_68fb3

MagikarpLv8Flail_BeforeDamage:
	xor a
;	fallthrough

Func_68fb3:
	ld e, a
	call GetCardDamageAndMaxHP
	call Func_6817e
	ret

PsyduckLv15Headache_BeforeDamage:
	ld a, $f1
	call GetNonTurnDuelistVariable
	set 2, [hl]
	ret

PsyduckLv15FurySwipes_AI:
	ld a, 15
	lb de, 0, 30
	call Func_680dd
	ret

PsyduckLv15FurySwipes_BeforeDamage:
	ld hl, $a
	call LoadTxRam3
	ldtx de, DamageCheckXDamageTimesHeadsText
	ld a, $03
	call Func_68069
	call ATimes10
	call Func_6817e
	ret

GolduckLv27Psyshock_BeforeDamage:
	call Func_68027
	ret

GolduckLv27HyperBeam_RequireSelection:
	jp Func_6a87d

GolduckLv27HyperBeam_AISelection:
	jp Func_6a877

GolduckLv27HyperBeam_AfterDamage:
	jp Func_6a8a5

SeadraLv23WaterGun_BeforeDamage:
	ld bc, $101
	jp Func_68e88

SeadraLv23Agility_BeforeDamage:
	ldtx de, IfHeadsDoNotReceiveDamageOrEffectText
	call TossCoin_Bank1a
	ret nc
	ld a, $52
	ld [wLoadedAttackAnimation], a
	ld a, $11
	call Func_68127
	ret

ShellderLv8Supersonic_BeforeDamage:
	call Func_68033
	ret

ShellderLv8HideInShell_BeforeDamage:
	ldtx de, IfHeadsNoDamageNextTurnText
	call TossCoin_Bank1a
	jp nc, Func_6809a
	ld a, $4f
	ld [wLoadedAttackAnimation], a
	ld a, $16
	call Func_68127
	ret

VaporeonLv42QuickAttack_AI:
	ld a, 20
	lb de, 10, 30
	call Func_680dd
	ret

VaporeonLv42QuickAttack_BeforeDamage:
	ld a, $14
	call Func_682e0
	ret

VaporeonLv42WaterGun_BeforeDamage:
	ld bc, $201
	jp Func_68e88

DewgongLv42IceBeam_BeforeDamage:
	call Func_68027
	ret

StarmieRecover_InitialEffect1:
	ld e, $00
	call GetPlayAreaCardAttachedEnergies
	ld a, [wAttachedEnergies + 3]
	ld hl, wAttachedEnergies + 7
	add [hl]
	ld hl, $cd
	cp $01
	ret c
	call GetCardDamageAndMaxHP
	ld hl, $b6
	cp $0a
	ret

StarmieRecover_InitialEffect2:
	ld a, $0b
	call Func_681e5
	xor a
	bank1call DisplayEnergyDiscardMenu
.asm_6905b
	bank1call HandleAttachedEnergyMenuInput
	jr c, .asm_6905b
	ldh a, [hTempCardIndex_ff98]
	ldh [hTemp_ffa0], a
	ret

StarmieRecover_AISelection:
	ld a, $0b
	call Func_681e5
	ld a, [wDuelTempList]
	ldh [hTemp_ffa0], a
	ret

StarmieRecover_DiscardEnergy:
	ldh a, [hTemp_ffa0]
	call Func_0ffa
	ret

StarmieRecover_AfterDamage:
	ld e, $00
	call GetCardDamageAndMaxHP
	ld e, a
	ld d, $00
	call ApplyAndAnimateHPRecovery
	ret

StarmieStarFreeze_BeforeDamage:
	call Func_68027
	ret

SquirtleLv8Bubble_BeforeDamage:
	call Func_68027
	ret

SquirtleLv8Withdraw_BeforeDamage:
	ldtx de, IfHeadsNoDamageNextTurnText
	call TossCoin_Bank1a
	jp nc, Func_6809a
	ld a, $4f
	ld [wLoadedAttackAnimation], a
	ld a, $15
	call Func_68127
	ret

HorseaLv19Smokescreen_BeforeDamage:
	ld a, $01
	call Func_6812e
	ret

TentacruelSupersonic_BeforeDamage:
	call Func_68033
	ret

TentacruelJellyfishSting_AI:
	ld a, $0a
	ld de, $a0a
	call Func_680b6
	ret

TentacruelJellyfishSting_BeforeDamage:
	call Func_68012
	ret

PoliwhirlLv28Amnesia_InitialEffect1:
	call Func_68501
	ret

PoliwhirlLv28Amnesia_InitialEffect2:
	call Func_690c3
	ret

PoliwhirlLv28Amnesia_AISelection:
	call Func_68633
	ret

PoliwhirlLv28Amnesia_BeforeDamage:
	jr Func_690d0

Func_690c3:
	ldtx hl, ChooseAttackToDisableNextOppTurnText
	call DrawWideTextBox_WaitForInput
	call Func_68486
	ld a, e
	ldh [hTemp_ffa0], a
	ret

Func_690d0:
	ld a, $04
;	fallthrough

Func_690d2:
	call Func_6812e
	ld a, [wNoDamageOrEffect]
	or a
	ret nz
	ld a, $f7
	call GetNonTurnDuelistVariable
	ldh a, [hTemp_ffa0]
	ld [hl], a
	ld l, $fd
	ld [hl], $02
	call Func_680ab
	ret c
	ld a, $55
	ld [wLoadedAttackAnimation], a
	call SwapTurn
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	ld d, a
	ldh a, [hTemp_ffa0]
	ld e, a
	call Func_684ef
	call LoadTxRam2
	ldtx hl, DisabledNextTurnText
	call DrawWideTextBox_WaitForInput
	call SwapTurn
	ret

PoliwhirlLv28DoubleSlap_AI:
	ld a, 30
	lb de, 0, 60
	call Func_680dd
	ret

PoliwhirlLv28DoubleSlap_BeforeDamage:
	ld hl, $1e
	call LoadTxRam3
	ldtx de, DamageCheckXDamageTimesHeadsText
	ld a, $02
	call Func_68069
	ld e, a
	add a
	add e
	call ATimes10
	call Func_6817e
	ret

PoliwrathLv48WaterGun_BeforeDamage:
	ld bc, $201
	jp Func_68e88

PoliwrathLv48Whirlpool_RequireSelection:
	jp Func_6a87d

PoliwrathLv48Whirlpool_AISelection:
	jp Func_6a877

PoliwrathLv48Whirlpool_AfterDamage:
	jp Func_6a8a5

PoliwagLv13WaterGun_BeforeDamage:
	ld bc, $100
	jp Func_68e88

CloysterClamp_AI:
	ld a, 30
	lb de, 0, 30
	call Func_680dd
	ret
	ret

CloysterClamp_BeforeDamage:
	ld a, $05
	ld [wLoadedAttackAnimation], a
	ldtx de, AttackSuccessCheckText
	call TossCoin_Bank1a
	jp c, Func_6802e
	xor a
	ld [wLoadedAttackAnimation], a
	call Func_6817e
	call Func_6809a
	ret

CloysterSpikeCannon_AI:
	ld a, 30
	lb de, 0, 60
	call Func_680dd
	ret

CloysterSpikeCannon_BeforeDamage:
	ld hl, $1e
	call LoadTxRam3
	ldtx de, DamageCheckXDamageTimesHeadsText
	ld a, $02
	call Func_68069
	ld e, a
	add a
	add e
	call ATimes10
	call Func_6817e
	ret

ArticunoLv35FreezeDry_BeforeDamage:
	call Func_68027
	ret

ArticunoLv35Blizzard_BeforeDamage:
	ldtx de, DamageToOppBenchIfHeadsDamageToYoursIfTailsText
	call TossCoin_Bank1a
	ldh [hTemp_ffa0], a
	ret

ArticunoLv35Blizzard_AfterDamage:
	ldh a, [hTemp_ffa0]
	or a
	jr nz, .asm_6919e
	call Func_6806e
	ld a, $0a
	call Func_680f9
	ret
.asm_6919e
	call SwapTurn
	ld a, $0a
	call Func_680f9
	call SwapTurn
	ret

TentacoolCowardice_InitialEffect2:
	ldh a, [hTempPlayAreaLocation_ff9d]
	ldh [hTemp_ffa0], a
	bank1call CheckIsIncapableOfUsingPkmnPower
	ret c
	call Func_68446
	ret c
	ldh a, [hTempPlayAreaLocation_ff9d]
	add DUELVARS_ARENA_CARD_FLAGS
	get_turn_duelist_var
	ld hl, $d7
	and $80
	scf
	ret z
	or a
	ret

TentacoolCowardice_RequireSelection:
	ldh a, [hTemp_ffa0]
	or a
	ret nz
	ldtx hl, SelectPokemonToPlaceInTheArenaText
	call DrawWideTextBox_WaitForInput
	bank1call HasAlivePokemonInBench
	bank1call OpenPlayAreaScreenForSelection
	ldh a, [hTempPlayAreaLocation_ff9d]
	ldh [hTempPlayAreaLocation_ffa1], a
	ret

TentacoolCowardice_BeforeDamage:
	ldh a, [hTemp_ffa0]
	add DUELVARS_ARENA_CARD
	get_turn_duelist_var
	push af
	ldh a, [hTemp_ffa0]
	ld e, a
	call MovePlayAreaCardToDiscardPile
	ldh a, [hTemp_ffa0]
	or a
	jr nz, .asm_691f0
	ldh a, [hTempPlayAreaLocation_ffa1]
	ld e, a
	call SwapArenaWithBenchPokemon
.asm_691f0
	pop af
	call MoveDiscardPileCardToHand
	call AddCardToHand
	call ShiftAllPokemonToFirstPlayAreaSlots
	xor a
	ld [wDuelDisplayedScreen], a
	ret

LaprasLv31WaterGun_BeforeDamage:
	ld bc, $100
	jp Func_68e88

LaprasLv31ConfuseRay_BeforeDamage:
	call Func_6803e
	ret

ArticunoLv37Quickfreeze_InitialEffect1:
	scf
	ret

ArticunoLv37Quickfreeze_PkmnPowerTrigger:
	ldtx de, ParalysisInflictionCheckText
	call TossCoin_Bank1a
	jr c, .asm_69220
	call Func_6809a
	bank1call DrawDuelMainScene
	bank1call Func_19e1
	call WaitForWideTextBoxInput
	ret
.asm_69220
	farcall ResetAttackAnimationIsPlaying
	ld a, DUELVARS_ARENA_CARD_LAST_TURN_STATUS
	get_turn_duelist_var
	push af
	push hl
	call Func_6802e
	ldh a, [hTempPlayAreaLocation_ff9d]
	ld b, a
	ld c, $00
	ldh a, [hWhoseTurn]
	ld h, a
	farcall PlayAttackAnimation
	farcall Func_18a19
	farcall WaitAttackAnimation
	bank1call Func_64a5
	bank1call DrawDuelHUDs
	call Func_19e1
	call c, WaitForWideTextBoxInput
	pop hl
	pop af
	ld [hl], a
	ret

ArticunoLv37IceBreath_BeforeDamage:
	xor a
	call Func_6817e
	ret

ArticunoLv37IceBreath_AfterDamage:
	call SwapTurn
	call Func_68196
	ld b, a
	ld de, $28
	call DealDamageToPlayAreaPokemon_RegularAnim
	call SwapTurn
	ret

VaporeonLv29FocusEnergy_BeforeDamage:
	ld a, $1e
	call Func_6810e
	ret

Func_6926c:
	call Func_681e3
	xor a
	bank1call DisplayEnergyDiscardMenu
	bank1call HandleAttachedEnergyMenuInput
	ldh a, [hTempCardIndex_ff98]
	ldh [hTemp_ffa0], a
	ret

Func_6927b:
	ld e, $00
	call Func_69283
	cp $01
	ret

Func_69283:
	call GetPlayAreaCardAttachedEnergies
	ld a, [wAttachedEnergies]
	ld hl, wAttachedEnergies + 7
	add [hl]
	ld hl, $cb
	ret

Func_69291:
	call Func_681e3
	ld a, [wDuelTempList]
	ldh [hTemp_ffa0], a
	ret

ArcanineLv45Flamethrower_InitialEffect1:
	jp Func_6927b

ArcanineLv45Flamethrower_InitialEffect2:
	jp Func_6926c

ArcanineLv45Flamethrower_AISelection:
	jp Func_69291

ArcanineLv45Flamethrower_DiscardEnergy:
	ldh a, [hTemp_ffa0]
	call Func_0ffa
	ret

ArcanineLv45TakeDown_AfterDamage:
	ld a, $1e
	call DealRecoilDamageToSelf
	ret

ArcanineLv34QuickAttack_AI:
	ld a, 20
	lb de, 10, 30
	call Func_680dd
	ret

ArcanineLv34QuickAttack_BeforeDamage:
	ld a, $14
	call Func_682e0
	ret

ArcanineLv34FlamesOfRage_InitialEffect1:
	ld e, $00
	call Func_69283
	cp $02
	ret

ArcanineLv34FlamesOfRage_InitialEffect2:
	ldtx hl, ChooseAndDiscard2FireEnergyCardsText
	call DrawWideTextBox_WaitForInput
	xor a
	ldh [hffb2], a
	call Func_681e3
	xor a
	bank1call DisplayEnergyDiscardMenu
.asm_692d6
	bank1call HandleAttachedEnergyMenuInput
	ret c
	farcall Func_24350
	ldh a, [hTempCardIndex_ff98]
	ld [hl], a
	call RemoveCardFromDuelTempList
	ldh a, [hffb2]
	cp $02
	ret nc
	bank1call UpdateAttachedEnergyMenu
	jr .asm_692d6

ArcanineLv34FlamesOfRage_AISelection:
	call Func_69291
	ld a, [wDuelTempList + 1]
	ldh [hTempPlayAreaLocation_ffa1], a
	ret

ArcanineLv34FlamesOfRage_DiscardEnergy:
	ldh a, [hTemp_ffa0]
	call Func_0ffa
	ldh a, [hTempPlayAreaLocation_ffa1]
	call Func_0ffa
	ret

ArcanineLv34FlamesOfRage_AI:
	ldh a, [hTempPlayAreaLocation_ff9d]
	jr Func_69307

ArcanineLv34FlamesOfRage_BeforeDamage:
	xor a
;	fallthrough

Func_69307:
	ld e, a
	call GetCardDamageAndMaxHP
	call Func_68163
	ret

RapidashLv33Stomp_AI:
	ld a, 25
	lb de, 20, 30
	call Func_680dd
	ret

RapidashLv33Stomp_BeforeDamage:
	ld a, $0a
	call Func_682e0
	ret

RapidashLv33Agility_BeforeDamage:
	ldtx de, IfHeadsDoNotReceiveDamageOrEffectText
	call TossCoin_Bank1a
	ret nc
	ld a, $52
	ld [wLoadedAttackAnimation], a
	ld a, $11
	call Func_68127
	ret

NinetalesLv32LureAlt_InitialEffect1:
	call Func_6843b
	ret

NinetalesLv32LureAlt_RequireSelection:
	ldtx hl, SelectBenchedPokemonToSwitchWithActiveText
	call DrawWideTextBox_WaitForInput
	call SwapTurn
	bank1call HasAlivePokemonInBench
.asm_69340
	bank1call OpenPlayAreaScreenForSelection
	jr c, .asm_69340
	ldh a, [hTempPlayAreaLocation_ff9d]
	ldh [hTemp_ffa0], a
	call SwapTurn
	ret

NinetalesLv32LureAlt_AISelection:
	call Func_6869d
	ldh [hTemp_ffa0], a
	ret

NinetalesLv32LureAlt_AfterDamage:
	call SwapTurn
	ldh a, [hTemp_ffa0]
	ld e, a
	bank1call Func_6f49
	call nc, SwapArenaWithBenchPokemon
	call SwapTurn
	xor a
	ld [wDuelDisplayedScreen], a
	ret

NinetalesLv32FireBlast_InitialEffect1:
	jp Func_6927b

NinetalesLv32FireBlast_InitialEffect2:
	jp Func_6926c

NinetalesLv32FireBlast_AISelection:
	jp Func_69291

NinetalesLv32FireBlast_DiscardEnergy:
	ldh a, [hTemp_ffa0]
	call Func_0ffa
	ret

CharmanderLv10Ember_InitialEffect1:
	jp Func_6927b

CharmanderLv10Ember_InitialEffect2:
	jp Func_6926c

CharmanderLv10Ember_AISelection:
	jp Func_69291

CharmanderLv10Ember_DiscardEnergy:
	ldh a, [hTemp_ffa0]
	call Func_0ffa
	ret

MoltresLv35Wildfire_InitialEffect1:
	call SwapTurn
	farcall Func_2435f
	call SwapTurn
	ret c
	jp Func_6927b

MoltresLv35Wildfire_InitialEffect2:
	ldtx hl, DiscardOppDeckAsManyFireEnergyCardsText
	call DrawWideTextBox_WaitForInput
	xor a
	ldh [hffb2], a
	call Func_681e3
	xor a
	bank1call DisplayEnergyDiscardMenu
	xor a
	ld [wAttachedEnergyMenuDenominator], a
.asm_693a7
	ldh a, [hffb2]
	ld [wAttachedEnergyMenuNumerator], a
	bank1call HandleAttachedEnergyMenuInput
	jr c, .asm_693c8
	farcall Func_24350
	ldh a, [hTempCardIndex_ff98]
	ld [hl], a
	call RemoveCardFromDuelTempList
	jr c, .asm_693c8
	ldh a, [hffb2]
	cp $0f
	jr nc, .asm_693c8
	bank1call UpdateAttachedEnergyMenu
	jr .asm_693a7
.asm_693c8
	farcall Func_24350
	ld [hl], $ff
	ldh a, [hffb2]
	cp $02
	ret

MoltresLv35Wildfire_AISelection:
	ld a, $ff
	ldh [hTemp_ffa0], a
	ret

MoltresLv35Wildfire_DiscardEnergy:
	ld hl, hTemp_ffa0
.asm_693db
	ld a, [hli]
	cp $ff
	jr z, .asm_693e5
	call Func_0ffa
	jr .asm_693db
.asm_693e5
	ret

MoltresLv35Wildfire_AfterDamage:
	ld c, $ff
	ld hl, hTemp_ffa0
.asm_693eb
	inc c
	ld a, [hli]
	cp $ff
	jr nz, .asm_693eb
	ld b, $00
	call SwapTurn
	ld a, DUELVARS_NUMBER_OF_CARDS_NOT_IN_DECK
	get_turn_duelist_var
	ld a, $3c
	sub [hl]
	cp c
	jr nc, .asm_69400
	ld c, a
.asm_69400
	push bc
	inc c
	jr .asm_6940a
.asm_69404
	call DrawCardFromDeck
	call nc, PutCardInDiscardPile
.asm_6940a
	dec c
	jr nz, .asm_69404
	pop hl
	call LoadTxRam3
	ldtx hl, DiscardedCardsFromDeckText
	call DrawWideTextBox_PrintText
	call SwapTurn
	ret

MoltresLv35DiveBomb_AI:
	ld a, 80
	lb de, 0, 80
	call Func_680dd
	ret

MoltresLv35DiveBomb_BeforeDamage:
	ldtx de, AttackSuccessCheckText
	call TossCoin_Bank1a
	jr c, .asm_69434
	xor a
	call Func_6817e
	call Func_6809a
	ret
.asm_69434
	ld a, $11
	ld [wLoadedAttackAnimation], a
	ret

FlareonLv28QuickAttack_AI:
	ld a, 20
	lb de, 10, 30
	call Func_680dd
	ret

FlareonLv28QuickAttack_BeforeDamage:
	ld a, $14
	call Func_682e0
	ret

FlareonLv28Flamethrower_InitialEffect1:
	jp Func_6927b

FlareonLv28Flamethrower_InitialEffect2:
	jp Func_6926c

FlareonLv28Flamethrower_AISelection:
	jp Func_69291

FlareonLv28Flamethrower_DiscardEnergy:
	ldh a, [hTemp_ffa0]
	call Func_0ffa
	ret

MagmarLv24Flamethrower_InitialEffect1:
	jp Func_6927b

MagmarLv24Flamethrower_InitialEffect2:
	jp Func_6926c

MagmarLv24Flamethrower_AISelection:
	jp Func_69291

MagmarLv24Flamethrower_DiscardEnergy:
	ldh a, [hTemp_ffa0]
	call Func_0ffa
	ret

MagmarLv31Smokescreen_BeforeDamage:
	ld a, $01
	call Func_6812e
	ret

MagmarLv31Smog_AI:
	ld a, $05
	ld de, $a
	call Func_680b6
	ret

MagmarLv31Smog_BeforeDamage:
	call Func_6800b
	ret

CharmeleonFlamethrower_InitialEffect1:
	jp Func_6927b

CharmeleonFlamethrower_InitialEffect2:
	jp Func_6926c

CharmeleonFlamethrower_AISelection:
	jp Func_69291

CharmeleonFlamethrower_DiscardEnergy:
	ldh a, [hTemp_ffa0]
	call Func_0ffa
	ret

CharizardLv76EnergyBurn_InitialEffect1:
	scf
	ret

CharizardLv76FireSpin_InitialEffect1:
	jr Func_69493

CharizardLv76FireSpin_InitialEffect2:
	jr Func_694a0

CharizardLv76FireSpin_DiscardEnergy:
	jr Func_694e5

CharizardLv76FireSpin_AISelection:
	jr Func_694d7

Func_69493:
	xor a
	call CreateArenaOrBenchEnergyCardList
	call CountCardsInDuelTempList
	ld hl, $ca
	cp $02
	ret

Func_694a0:
	ldtx hl, ChooseAndDiscard2EnergyCardsText
	call DrawWideTextBox_WaitForInput
	xor a
	ldh [hffb2], a
	xor a
	call CreateArenaOrBenchEnergyCardList
	xor a
	bank1call DisplayEnergyDiscardMenu
	ld a, $02
	ld [wAttachedEnergyMenuDenominator], a
.asm_694b6
	bank1call HandleAttachedEnergyMenuInput
	ret c
	farcall Func_24350
	ldh a, [hTempCardIndex_ff98]
	ld [hl], a
	ld hl, wAttachedEnergyMenuNumerator
	inc [hl]
	ldh a, [hffb2]
	cp $02
	jr nc, .asm_694d5
	ldh a, [hTempCardIndex_ff98]
	call RemoveCardFromDuelTempList
	bank1call UpdateAttachedEnergyMenu
	jr .asm_694b6
.asm_694d5
	or a
	ret

Func_694d7:
	xor a
	call CreateArenaOrBenchEnergyCardList
	ld hl, wDuelTempList
	ld a, [hli]
	ldh [hTemp_ffa0], a
	ld a, [hl]
	ldh [hTempPlayAreaLocation_ffa1], a
	ret

Func_694e5:
	ld hl, hTemp_ffa0
	ld a, [hli]
	call Func_0ffa
	ld a, [hli]
	call Func_0ffa
	ret

Func_694f1:
	xor a
	bank1call CheckIsIncapableOfUsingPkmnPower
	ret c
	ld a, $bb
	push de
	get_turn_duelist_var
	call GetCardIDFromDeckIndex
	cp16 CHARIZARD_LV76
	pop de
	jr nz, .asm_6950a
	or a
	ret
.asm_6950a
	scf
	ret

CharizardAltLv76EnergyBurn_InitialEffect1:
	scf
	ret

CharizardAltLv76FireSpin_InitialEffect1:
	jp Func_69493

CharizardAltLv76FireSpin_InitialEffect2:
	jr Func_694a0

CharizardAltLv76FireSpin_DiscardEnergy:
	jr Func_694e5

CharizardAltLv76FireSpin_AISelection:
	jr Func_694d7

VulpixLv11ConfuseRay_BeforeDamage:
	call Func_6803e
	ret

FlareonLv22Rage_AI:
	ldh a, [hTempPlayAreaLocation_ff9d]
	jr Func_69520

FlareonLv22Rage_BeforeDamage:
	xor a
;	fallthrough

Func_69520:
	ld e, a
	call GetCardDamageAndMaxHP
	call Func_68163
	ret

NinetalesLv35MixUp_InitialEffect1:
	call SwapTurn
	farcall Func_2435f
	jr c, .asm_6953b
	ld a, DUELVARS_NUMBER_OF_CARDS_IN_HAND
	get_turn_duelist_var
	or a
	jr nz, .asm_6953b
	ld hl, $ab
	scf
.asm_6953b
	call SwapTurn
	ret

NinetalesLv35MixUp_AfterDamage:
	call SwapTurn
	call CreateHandCardList
	bank1call SortCardsInDuelTempListByID
	ld hl, wDuelTempList
	ld c, $00
.asm_6954d
	ld a, [hl]
	cp $ff
	jr z, .asm_69562
	call Func_69592
	jr nc, .asm_6955f
	inc c
	ld a, [hl]
	call RemoveCardFromHand
	call ReturnCardToDeck
.asm_6955f
	inc hl
	jr .asm_6954d
.asm_69562
	ld a, c
	ldh [hffb2], a
	push bc
	ldtx hl, AffectedByMixUpText
	call DrawWideTextBox_WaitForInput
	call Func_680a0
	call CreateDeckCardList
	pop bc
	ldh a, [hffb2]
	or a
	jr z, .asm_6958e
	ld hl, wDuelTempList
.asm_6957b
	ld a, [hl]
	call Func_69592
	jr nc, .asm_69589
	dec c
	ld a, [hl]
	call SearchCardInDeckAndAddToHand
	call AddCardToHand
.asm_69589
	inc hl
	ld a, c
	or a
	jr nz, .asm_6957b
.asm_6958e
	call SwapTurn
	ret

Func_69592:
	call LoadCardDataToBuffer2_FromDeckIndex
	ld a, [wLoadedCard2Type]
	cp $08
	ret

NinetalesLv35DancingEmbers_AI:
	ld a, 40
	lb de, 0, 80
	call Func_680dd
	ret

NinetalesLv35DancingEmbers_BeforeDamage:
	ld hl, $a
	call LoadTxRam3
	ldtx de, DamageCheckXDamageTimesHeadsText
	ld a, $08
	call Func_68069
	call ATimes10
	call Func_6817e
	ret

MoltresLv40Firegiver_InitialEffect1:
	scf
	ret

MoltresLv40Firegiver_PkmnPowerTrigger:
	ld a, DUELVARS_CARD_LOCATIONS
	get_turn_duelist_var
	ld de, wDuelTempList
	ld c, $00
.asm_695c3
	ld a, [hl]
	cp $00
	jr nz, .asm_695db
	push hl
	push de
	ld a, l
	call GetCardIDFromDeckIndex
	call GetCardType
	pop de
	pop hl
	cp $08
	jr nz, .asm_695db
	ld a, l
	ld [de], a
	inc de
	inc c
.asm_695db
	inc l
	ld a, l
	cp $3c
	jr c, .asm_695c3
	ld a, $ff
	ld [de], a
	ld a, c
	or a
	jr nz, .asm_695f2
	ldtx hl, ThereWasNoFireEnergyText
	call DrawWideTextBox_WaitForInput
	call Func_680a0
	ret
.asm_695f2
	ld a, $04
	call Random
	inc a
	cp c
	jr c, .asm_695fc
	ld a, c
.asm_695fc
	ldh [hffb2], a
	ld d, $84
	ld a, [wDuelistType]
	cp $00
	jr z, .asm_69609
	ld d, $85
.asm_69609
	ld a, d
	ld [wLoadedAttackAnimation], a
	ldh a, [hffb2]
	ld c, a
	ld hl, wDuelTempList
.asm_69613
	push hl
	push bc
	farcall ResetAttackAnimationIsPlaying
	ld bc, $0
	ldh a, [hWhoseTurn]
	ld h, a
	farcall PlayAttackAnimation
	farcall WaitAttackAnimation
	ld bc, $1207
	ld e, $03
	ld a, [wLoadedAttackAnimation]
	cp $84
	jr z, .asm_69638
	ld bc, $405
	ld e, $0a
.asm_69638
	ld a, DUELVARS_NUMBER_OF_CARDS_IN_HAND
	get_turn_duelist_var
	inc a
	bank1call WriteTwoDigitNumberInTxSymbolFormat
	ld a, DUELVARS_NUMBER_OF_CARDS_NOT_IN_DECK
	get_turn_duelist_var
	ld a, $3b
	sub [hl]
	ld c, e
	bank1call WriteTwoDigitNumberInTxSymbolFormat
	pop bc
	pop hl
	ld a, [hli]
	call SearchCardInDeckAndAddToHand
	call AddCardToHand
	dec c
	jr nz, .asm_69613
	ldh a, [hffb2]
	ld l, a
	ld h, $00
	call LoadTxRam3
	ldtx hl, DrewFireEnergyFromDeckText
	call DrawWideTextBox_WaitForInput
	call Func_680a0
	ret

MoltresLv40DiveBomb_AI:
	ld a, 70
	lb de, 0, 70
	call Func_680dd
	ret

MoltresLv40DiveBomb_BeforeDamage:
	ldtx de, AttackSuccessCheckText
	call TossCoin_Bank1a
	jr c, .asm_69680
	xor a
	call Func_6817e
	call Func_6809a
	ret
.asm_69680
	ld a, $11
	ld [wLoadedAttackAnimation], a
	ret

Func_69686:
	call SwapTurn
	ld a, DUELVARS_CARD_LOCATIONS
	get_turn_duelist_var
	ld c, $00
.asm_6968e
	ld a, [hl]
	cp $10
	jr nz, .asm_6969f
	ld a, l
	call GetCardIDFromDeckIndex
	call GetCardType
	and $08
	jr z, .asm_6969f
	inc c
.asm_6969f
	inc l
	ld a, l
	cp $3c
	jr c, .asm_6968e
	call SwapTurn
	ld l, c
	ld h, $00
	ld b, $00
	add hl, hl
	add hl, hl
	add hl, bc
	add hl, hl
	ld e, l
	ld d, h
	ret

Func_696b4:
	ld e, $00
	call GetPlayAreaCardAttachedEnergies
	ld a, [wAttachedEnergies + 5]
	ld hl, wAttachedEnergies + 7
	add [hl]
	ld hl, $cc
	cp $01
	ret

; hl - text
Func_696c6:
	push hl
	xor a
	ldh [hffb2], a
	call CreateEnergyCardListFromDiscardPile_AllEnergy
	pop hl
	jr c, .asm_69700
	call DrawWideTextBox_WaitForInput
.asm_696d3
	bank1call InitAndDrawCardListScreenLayout
	ldtx hl, ChooseAnEnergyCardText
	ldtx de, DuelistDiscardPileText
	bank1call SetCardListHeaderAndInfoText
	bank1call DisplayCardList
	jr nc, .asm_696ed
	ld a, $02
	call Func_6856d
	jr c, .asm_696d3
	jr .asm_69700
.asm_696ed
	farcall Func_24350
	ldh a, [hTempCardIndex_ff98]
	ld [hl], a
	call RemoveCardFromDuelTempList
	or a
	jr z, .asm_69700
	ldh a, [hffb2]
	cp $02
	jr c, .asm_696d3
.asm_69700
	farcall Func_24350
	ld [hl], $ff
	or a
	ret

AbraLv10Psyshock_BeforeDamage:
	call Func_68027
	ret

GengarLv38Curse_InitialEffect2:
	call Func_6844f
	ret c
	call SwapTurn
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	call SwapTurn
	ld hl, $da
	cp $02
	jr c, .asm_6972d
	call SwapTurn
	call Func_68335
	call SwapTurn
	ld hl, $b5
	ret nc
.asm_6972d
	scf
	ret

GengarLv38Curse_RequireSelection:
	ldtx hl, ProcedureForCurseText
	bank1call Func_5475
	call SwapTurn
	xor a
	ldh [hffb2], a
	bank1call Func_5c30
.asm_6973e
	bank1call PrintPlayAreaCardList_EnableLCD
	push af
	ldh a, [hffb2]
	ld hl, Data_68743
	call InitializeMenuParameters
	pop af
	ld [wNumScrollMenuItems], a
.asm_6974e
	call DoFrame
	call HandleMenuInput
	jr nc, .asm_6974e
	cp $ff
	jr z, .asm_697af
	ldh [hffb2], a
	ldh [hTempPlayAreaLocation_ffa1], a
	call GetCardDamageAndMaxHP
	or a
	jr nz, .asm_69769
	call Func_3071
	jr .asm_6974e
.asm_69769
	ldh a, [hTempPlayAreaLocation_ffa1]
	add DUELVARS_ARENA_CARD_HP
	get_turn_duelist_var
	push af
	push hl
	add $0a
	ld [hl], a
	bank1call PrintPlayAreaCardList_EnableLCD
	pop hl
	pop af
	ld [hl], a
	ldh a, [hTempPlayAreaLocation_ffa1]
	ld b, $17
	call Func_6872f
.asm_69780
	call DoFrame
	call HandleMenuInput
	jr nc, .asm_69780
	ldh [hTempRetreatCostCards], a
	cp $ff
	jr nz, .asm_6979a
	ldh a, [hTempPlayAreaLocation_ffa1]
	ld b, $00
	call Func_6872f
	call EraseCursor
	jr .asm_6973e
.asm_6979a
	ld hl, hTempPlayAreaLocation_ffa1
	cp [hl]
	jr z, .asm_69780
	ldh a, [hTempPlayAreaLocation_ffa1]
	ld b, $00
	call Func_6872f
	call EraseCursor
	call SwapTurn
	or a
	ret
.asm_697af
	call SwapTurn
	scf
	ret

GengarLv38Curse_BeforeDamage:
	call Func_68465
	call SwapTurn
	ld a, $f6
	call GetNonTurnDuelistVariable
	cp $00
	jr z, .asm_697c6
	bank1call Func_5c30
.asm_697c6
	ldh a, [hTempRetreatCostCards]
	add DUELVARS_ARENA_CARD_HP
	get_turn_duelist_var
	sub $0a
	ld [hl], a
	ldh a, [hTempPlayAreaLocation_ffa1]
	add $c8
	ld l, a
	ld a, $0a
	add [hl]
	ld [hl], a
	bank1call PrintPlayAreaCardList_EnableLCD
	ld a, $f6
	call GetNonTurnDuelistVariable
	cp $00
	jr z, .asm_697ea
	ldh a, [hTempRetreatCostCards]
	ldh [hTempPlayAreaLocation_ff9d], a
	bank1call Func_5c23
.asm_697ea
	ldh a, [hTempRetreatCostCards]
	bank1call LoadPlayAreaCardID_ToTempNonTurnDuelistCardID
	ldh a, [hTempRetreatCostCards]
	add DUELVARS_ARENA_CARD_HP
	get_turn_duelist_var
	call PrintKnockedOutIfHLZero
	call c, WaitForWideTextBoxInput
	call SwapTurn
	call ExchangeRNG
	bank1call Func_6518
	ret

GengarLv38DarkMind_RequireSelection:
	call Func_68665
	ret

GengarLv38DarkMind_AISelection:
	ld a, $ff
	ldh [hTemp_ffa0], a
	call Func_6843b
	ret c
	call Func_6869d
	ldh [hTemp_ffa0], a
	ret

GengarLv38DarkMind_AfterDamage:
	ldh a, [hTemp_ffa0]
	cp $ff
	ret z
	call SwapTurn
	ld b, a
	ld de, $a
	call DealDamageToPlayAreaPokemon_RegularAnim
	call SwapTurn
	ret

GastlyLv8SleepingGas_BeforeDamage:
	call Func_6804a
	ret

GastlyLv8DestinyBond_InitialEffect1:
	jp Func_696b4

GastlyLv8DestinyBond_InitialEffect2:
	ld a, $0d
	call Func_681e5
	xor a
	bank1call DisplayEnergyDiscardMenu
	bank1call HandleAttachedEnergyMenuInput
	ret c
	ldh a, [hTempCardIndex_ff98]
	ldh [hTemp_ffa0], a
	ret

GastlyLv8DestinyBond_AISelection:
	ld a, $0d
	call Func_681e5
	ld a, [wDuelTempList]
	ldh [hTemp_ffa0], a
	ret

GastlyLv8DestinyBond_DiscardEnergy:
	ldh a, [hTemp_ffa0]
	call Func_0ffa
	ret

GastlyLv8DestinyBond_BeforeDamage:
	ld a, $1b
	call Func_68127
	ret

GastlyLv17Lick_BeforeDamage:
	call Func_68027
	ret

GastlyLv17EnergyConversion_InitialEffect1:
	call CreateEnergyCardListFromDiscardPile_AllEnergy
	ld hl, $b8
	ret

GastlyLv17EnergyConversion_RequireSelection:
	ldtx hl, Choose2EnergyCardsFromDiscardPileForHandText
	call Func_696c6
	ret

GastlyLv17EnergyConversion_AISelection:
	call CreateEnergyCardListFromDiscardPile_AllEnergy
	ld hl, wDuelTempList
	ld de, hTemp_ffa0
	ld c, $02
.asm_69876
	ld a, [hli]
	cp $ff
	jr z, .asm_69880
	ld [de], a
	inc de
	dec c
	jr nz, .asm_69876
.asm_69880
	ld a, $ff
	ld [de], a
	ret

GastlyLv17EnergyConversion_AfterDamage:
	ld a, $0a
	call DealRecoilDamageToSelf
	ld hl, hTemp_ffa0
	ld de, wDuelTempList
.asm_6988f
	ld a, [hli]
	ld [de], a
	inc de
	cp $ff
	jr z, .asm_6989e
	call MoveDiscardPileCardToHand
	call AddCardToHand
	jr .asm_6988f
.asm_6989e
	call Func_680ab
	ret c
	bank1call Func_49e8
	ret

HaunterLv22HypnosisMove_BeforeDamage:
	call Func_6805c
	ret

HaunterLv22DreamEater_InitialEffect1:
	ld a, $ec
	call GetNonTurnDuelistVariable
	and $0f
	cp $02
	ret z
	ld hl, $de
	scf
	ret

HaunterLv17Transparency_InitialEffect1:
	scf
	ret

HaunterLv17Nightmare_BeforeDamage:
	call Func_6805c
	ret

HypnoLv36Prophecy_InitialEffect1:
	ld a, DUELVARS_NUMBER_OF_CARDS_NOT_IN_DECK
	get_turn_duelist_var
	cp $3c
	jr c, .asm_698d4
	ld a, $ba
	call GetNonTurnDuelistVariable
	cp $3c
	jr c, .asm_698d4
	ld hl, $ba
	scf
	ret
.asm_698d4
	or a
	ret

HypnoLv36Prophecy_RequireSelection:
.asm_698d6
	ldtx hl, ProcedureForProphecyText
	bank1call Func_5475
.asm_698dc
	bank1call DrawDuelMainScene
	ldtx hl, SelectTargetDeckYoursOppsText
	call TwoItemHorizontalMenu
	ldh a, [hKeysHeld]
	and $02
	jr nz, .asm_698d6
	ldh a, [hCurScrollMenuItem]
	ldh [hTemp_ffa0], a
	or a
	jr z, .asm_69905
	ld a, $ba
	call GetNonTurnDuelistVariable
	cp $3c
	jr nc, .asm_698dc
	call SwapTurn
	call Func_6994a
	call SwapTurn
	ret
.asm_69905
	ld a, DUELVARS_NUMBER_OF_CARDS_NOT_IN_DECK
	get_turn_duelist_var
	cp $3c
	jr nc, .asm_698dc
	call Func_6994a
	ret

HypnoLv36Prophecy_AISelection:
	ld a, $ff
	ldh [hTemp_ffa0], a
	ret

HypnoLv36Prophecy_AfterDamage:
	ld hl, hTemp_ffa0
	ld a, [hli]
	or a
	jr z, Func_69929
	cp $ff
	ret z
	call SwapTurn
	call Func_69929
	call SwapTurn
	ret

Func_69929:
	ld c, $00
.asm_6992b
	ld a, [hli]
	cp $ff
	jr z, .asm_69936
	call SearchCardInDeckAndAddToHand
	inc c
	jr .asm_6992b
.asm_69936
	dec hl
	dec hl
.asm_69938
	ld a, [hld]
	call ReturnCardToDeck
	dec c
	jr nz, .asm_69938
	call Func_680ab
	ret c
	ldtx hl, RearrangedDuelistsDeckText
	call DrawWideTextBox_WaitForInput
	ret

Func_6994a:
	ld a, DUELVARS_NUMBER_OF_CARDS_NOT_IN_DECK
	get_turn_duelist_var
	ld b, a
	ld a, $3c
	sub [hl]
	ld c, $03
	cp c
	jr nc, .asm_69957
	ld c, a
.asm_69957
	ld a, c
	inc a
	ld [wcd1f], a
	ld a, b
	add $7e
	ld l, a
	ld de, wDuelTempList
.asm_69963
	ld a, [hli]
	ld [de], a
	inc de
	dec c
	jr nz, .asm_69963
	ld a, $ff
	ld [de], a
.asm_6996c
	call CountCardsInDuelTempList
	ld b, a
	ld a, $01
	ldh [hffb2], a
	ld hl, wDuelTempList + 10
	xor a
.asm_69978
	ld [hli], a
	dec b
	jr nz, .asm_69978
	ld [hl], $ff
	bank1call InitAndDrawCardListScreenLayout
	ldtx hl, ChooseTheOrderOfTheCardsText
	ldtx de, DuelistDeckText
	bank1call SetCardListHeaderAndInfoText
	bank1call Func_53bc
.asm_6998d
	bank1call DisplayCardList
	jr c, .asm_699e3
	ldh a, [hCurScrollMenuItem]
	ld e, a
	ld d, $00
	ld hl, wDuelTempList + 10
	add hl, de
	ld a, [hl]
	or a
	jr nz, .asm_6998d
	ldh a, [hffb2]
	ld [hl], a
	inc a
	ldh [hffb2], a
	bank1call Func_53cb
	ldh a, [hffb2]
	ld hl, wcd1f
	cp [hl]
	jr c, .asm_6998d
	call EraseCursor
	ld hl, $2f
	call YesOrNoMenuWithText_LeftAligned
	jr c, .asm_6996c
	ld hl, wDuelTempList + 10
	ld de, wDuelTempList
	ld c, $00
.asm_699c3
	ld a, [hli]
	cp $ff
	jr z, .asm_699d9
	push hl
	push bc
	ld c, a
	ld b, $00
	ld hl, hTemp_ffa0
	add hl, bc
	ld a, [de]
	ld [hl], a
	pop bc
	pop hl
	inc de
	inc c
	jr .asm_699c3
.asm_699d9
	ld b, $00
	ld hl, hTempPlayAreaLocation_ffa1
	add hl, bc
	ld [hl], $ff
	or a
	ret
.asm_699e3
	ld hl, hffb2
	ld a, [hl]
	cp $01
	jr z, .asm_6998d
	dec a
	ld [hl], a
	ld c, a
	ld hl, wDuelTempList + 10
.asm_699f1
	ld a, [hli]
	cp c
	jr nz, .asm_699f1
	dec hl
	ld [hl], $00
	bank1call Func_53cb
	jr .asm_6998d

HypnoLv36DarkMind_RequireSelection:
	call Func_68665
	ret

HypnoLv36DarkMind_AISelection:
	ld a, $ff
	ldh [hTemp_ffa0], a
	call Func_6843b
	ret c
	call Func_6869d
	ldh [hTemp_ffa0], a
	ret

HypnoLv36DarkMind_AfterDamage:
	ldh a, [hTemp_ffa0]
	cp $ff
	ret z
	call SwapTurn
	ld b, a
	ld de, $a
	call DealDamageToPlayAreaPokemon_RegularAnim
	call SwapTurn
	ret

DrowzeeLv12ConfuseRay_BeforeDamage:
	call Func_6803e
	ret

MrMimeLv28InvisibleWall_InitialEffect1:
	scf
	ret

MrMimeLv28Meditate_BeforeDamage:
	call SwapTurn
	ld e, $00
	call GetCardDamageAndMaxHP
	call SwapTurn
	call Func_68163
	ret

AlakazamLv42DamageSwap_InitialEffect2:
	ldh a, [hTempPlayAreaLocation_ff9d]
	ldh [hTemp_ffa0], a
	call Func_68335
	jr c, .asm_69a46
	ldh a, [hTempPlayAreaLocation_ff9d]
	bank1call CheckIsIncapableOfUsingPkmnPower
	ret
.asm_69a46
	ld hl, $b5
	scf
	ret

AlakazamLv42DamageSwap_BeforeDamage:
	ld a, DUELVARS_DUELIST_TYPE
	get_turn_duelist_var
	cp $00
	jr z, .asm_69a59
	bank1call Func_5c30
	bank1call PrintPlayAreaCardList_EnableLCD
	ret
.asm_69a59
	ldtx hl, ProcedureForDamageSwapText
	bank1call Func_5475
	xor a
	ldh [hffb2], a
	bank1call Func_5c30
.asm_69a65
	bank1call PrintPlayAreaCardList_EnableLCD
	push af
	ldh a, [hffb2]
	ld hl, Data_68743
	call InitializeMenuParameters
	pop af
	ld [wNumScrollMenuItems], a
.asm_69a75
	call DoFrame
	call HandleMenuInput
	jr nc, .asm_69a75
	cp $ff
	ret z
	ldh [hTempPlayAreaLocation_ffa1], a
	ldh [hffb2], a
	call GetCardDamageAndMaxHP
	or a
	jr z, .asm_69ac7
	ldh a, [hTempPlayAreaLocation_ffa1]
	add DUELVARS_ARENA_CARD_HP
	get_turn_duelist_var
	push af
	push hl
	add $0a
	ld [hl], a
	bank1call PrintPlayAreaCardList_EnableLCD
	pop hl
	pop af
	ld [hl], a
	ldh a, [hTempPlayAreaLocation_ffa1]
	ld b, $17
	call Func_6872f
.asm_69aa1
	call DoFrame
	call HandleMenuInput
	jr nc, .asm_69aa1
	cp $ff
	jr z, .asm_69abb
	ldh [hTempRetreatCostCards], a
	ldh [hffb2], a
	call Func_69ad5
	jr c, .asm_69aa1
	ld a, $16
	call SetOppAction_SerialSendDuelData
.asm_69abb
	ldh a, [hTempPlayAreaLocation_ffa1]
	ld b, $00
	call Func_6872f
	call EraseCursor
	jr .asm_69a65
.asm_69ac7
	call Func_3071
	jr .asm_69a75

AlakazamLv42DamageSwap_Unk11:
	call Func_69ad5
	ret c
	bank1call PrintPlayAreaCardList_EnableLCD
	or a
	ret

Func_69ad5:
	ldh a, [hTempPlayAreaLocation_ffa1]
	ld l, a
	ldh a, [hTempRetreatCostCards]
	cp l
	ret z
	add DUELVARS_ARENA_CARD_HP
	get_turn_duelist_var
	sub $0a
	jr z, .asm_69aef
	ld [hl], a
	ldh a, [hTempPlayAreaLocation_ffa1]
	add $c8
	ld l, a
	ld a, $0a
	add [hl]
	ld [hl], a
	or a
	ret
.asm_69aef
	scf
	ret

AlakazamLv42ConfuseRay_BeforeDamage:
	call Func_6803e
	ret

MewLv23Psywave_AI:
	call MewLv23Psywave_BeforeDamage
	jp Func_6818c

MewLv23Psywave_BeforeDamage:
	call Func_69686
	ld hl, wDamage
	ld [hl], e
	inc hl
	ld [hl], d
	ret

MewLv23DevolutionBeam_InitialEffect1:
	call Func_69bf6
	ret nc
	call SwapTurn
	call Func_69bf6
	call SwapTurn
	ld hl, $c6
	ret

MewLv23DevolutionBeam_InitialEffect2:
	ldtx hl, ProcedureForDevolutionBeamText
	bank1call Func_5475
.asm_69b1c
	bank1call DrawDuelMainScene
	ldtx hl, SelectTargetPlayAreaYoursOppsText
	call TwoItemHorizontalMenu
	ldh a, [hKeysHeld]
	and $02
	jr nz, .asm_69b4e
	ldh a, [hCurScrollMenuItem]
	or a
	jr nz, .asm_69b3f
	call Func_69c09
	jr c, .asm_69b1c
	xor a
.asm_69b36
	ld hl, hTemp_ffa0
	ld [hli], a
	ldh a, [hTempPlayAreaLocation_ff9d]
	ld [hl], a
	or a
	ret
.asm_69b3f
	call SwapTurn
	call Func_69c09
	call SwapTurn
	jr c, .asm_69b1c
	ld a, $01
	jr .asm_69b36
.asm_69b4e
	scf
	ret

MewLv23DevolutionBeam_AISelection:
	ld a, $01
	ldh [hTemp_ffa0], a
	call SwapTurn
	call Func_69c19
	call SwapTurn
	jr c, .asm_69b65
	xor a
	ldh [hTemp_ffa0], a
	call Func_69c19
.asm_69b65
	ldh [hTempPlayAreaLocation_ffa1], a
	ret

MewLv23DevolutionBeam_BeforeDamage:
	xor a
	ld [wLoadedAttackAnimation], a
	ret

MewLv23DevolutionBeam_AfterDamage:
	ldh a, [hTemp_ffa0]
	or a
	jr z, Func_69b89
	cp $ff
	ret z
	ldh a, [hTempPlayAreaLocation_ffa1]
	or a
	jr nz, .asm_69b7f
	call Func_682be
	jr c, .asm_69b88
.asm_69b7f
	call SwapTurn
	call Func_69b89
	call SwapTurn
.asm_69b88
	ret

Func_69b89:
	farcall ResetAttackAnimationIsPlaying
	ld a, $5d
	ld [wLoadedAttackAnimation], a
	ldh a, [hTempPlayAreaLocation_ffa1]
	ld b, a
	ld c, $00
	ldh a, [hWhoseTurn]
	ld h, a
	farcall PlayAttackAnimation
	farcall WaitAttackAnimation
	ldh a, [hTempPlayAreaLocation_ffa1]
	ldh [hTempPlayAreaLocation_ff9d], a
	ld [wTempPlayAreaLocation_cceb], a
	add DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call LoadCardDataToBuffer1_FromDeckIndex
	ld a, [wLoadedCard1ID]
	ld [wTempNonTurnDuelistCardID], a
	ld a, [wLoadedCard1ID + 1]
	ld [wTempNonTurnDuelistCardID + 1], a
	ld de, $0
	ldh a, [hTempPlayAreaLocation_ff9d]
	or a
	jr nz, .asm_69bc8
	bank1call HandleNoDamageOrEffectSubstatus
	jr c, .asm_69bcb
.asm_69bc8
	bank1call Func_7038
.asm_69bcb
	bank1call CheckNoDamageOrEffect
	jr nc, .asm_69bd4
	call DrawWideTextBox_WaitForInput
	ret
.asm_69bd4
	ldh a, [hTempPlayAreaLocation_ffa1]
	ldh [hTempPlayAreaLocation_ff9d], a
	add DUELVARS_ARENA_CARD
	get_turn_duelist_var
	bank1call GetCardOneStageBelow
	call Func_68262
	ld a, d
	call Func_68525
	call Func_68556
	ld a, e
	call AddCardToHand
	ldh a, [hTempPlayAreaLocation_ffa1]
	call PrintPlayAreaCardKnockedOutIfNoHP
	xor a
	ld [wDuelDisplayedScreen], a
	ret

Func_69bf6:
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	ld d, h
	ld e, $ce
.asm_69bfc
	ld a, [hli]
	cp $ff
	jr z, .asm_69c07
	ld a, [de]
	inc de
	or a
	jr z, .asm_69bfc
	ret
.asm_69c07
	scf
	ret

Func_69c09:
	bank1call HasAlivePokemonInPlayArea
.asm_69c0c
	bank1call OpenPlayAreaScreenForSelection
	ret c
	ldh a, [hTempPlayAreaLocation_ff9d]
	add DUELVARS_ARENA_CARD_STAGE
	get_turn_duelist_var
	or a
	jr z, .asm_69c0c
	ret

Func_69c19:
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	ld c, a
	ld b, $00
	ld l, $ce
.asm_69c21
	ld a, [hli]
	or a
	jr nz, .asm_69c2b
	inc b
	dec c
	jr nz, .asm_69c21
	or a
	ret
.asm_69c2b
	ld a, b
	scf
	ret

MewLv8NeutralShield_InitialEffect1:
	scf
	ret

MewLv8Psyshock_BeforeDamage:
	call Func_68027
	ret

MewtwoLv53Psychic_AI:
	call MewtwoLv53Psychic_BeforeDamage
	jp Func_6818c

MewtwoLv53Psychic_BeforeDamage:
	call Func_69686
	ld hl, wDamage
	ld a, e
	add [hl]
	ld [hli], a
	ld a, d
	adc [hl]
	ld [hl], a
	ret

MewtwoLv53Barrier_InitialEffect1:
	jp Func_696b4

MewtwoLv53Barrier_InitialEffect2:
	ld a, $0d
	call Func_681e5
	xor a
	bank1call DisplayEnergyDiscardMenu
	bank1call HandleAttachedEnergyMenuInput
	ret c
	ldh a, [hTempCardIndex_ff98]
	ldh [hTemp_ffa0], a
	ret

MewtwoLv53Barrier_AISelection:
	ld a, $0d
	call Func_681e5
	ld a, [wDuelTempList]
	ldh [hTemp_ffa0], a
	ret

MewtwoLv53Barrier_DiscardEnergy:
	ldh a, [hTemp_ffa0]
	call Func_0ffa
	ret

MewtwoLv53Barrier_BeforeDamage:
	ld a, $19
	call Func_68127
	ret

MewtwoAltLv60EnergyAbsorption_InitialEffect1:
	call CreateEnergyCardListFromDiscardPile_AllEnergy
	ld hl, $b8
	ret

MewtwoAltLv60EnergyAbsorption_RequireSelection:
	ldtx hl, Choose2EnergyCardsFromDiscardPileToAttachText
	call Func_696c6
	ret

MewtwoAltLv60EnergyAbsorption_AISelection:
	call CreateEnergyCardListFromDiscardPile_AllEnergy
	ld hl, wDuelTempList
	ld de, hTemp_ffa0
	ld c, $02
.asm_69c8c
	ld a, [hli]
	cp $ff
	jr z, .asm_69c96
	ld [de], a
	inc de
	dec c
	jr nz, .asm_69c8c
.asm_69c96
	ld a, $ff
	ld [de], a
	ret

MewtwoAltLv60EnergyAbsorption_AfterDamage:
	ld hl, hTemp_ffa0
.asm_69c9d
	ld a, [hli]
	cp $ff
	ret z
	push hl
	call MoveDiscardPileCardToHand
	get_turn_duelist_var
	ld [hl], $10
	pop hl
	jr .asm_69c9d

MewtwoLv60EnergyAbsorption_InitialEffect1:
	call CreateEnergyCardListFromDiscardPile_AllEnergy
	ld hl, $b8
	ret

MewtwoLv60EnergyAbsorption_RequireSelection:
	ldtx hl, Choose2EnergyCardsFromDiscardPileToAttachText
	call Func_696c6
	ret

MewtwoLv60EnergyAbsorption_AISelection:
	call CreateEnergyCardListFromDiscardPile_AllEnergy
	ld hl, wDuelTempList
	ld de, hTemp_ffa0
	ld c, $02
.asm_69cc4
	ld a, [hli]
	cp $ff
	jr z, .asm_69cce
	ld [de], a
	inc de
	dec c
	jr nz, .asm_69cc4
.asm_69cce
	ld a, $ff
	ld [de], a
	ret

MewtwoLv60EnergyAbsorption_AfterDamage:
	ld hl, hTemp_ffa0
.asm_69cd5
	ld a, [hli]
	cp $ff
	ret z
	push hl
	call MoveDiscardPileCardToHand
	get_turn_duelist_var
	ld [hl], $10
	pop hl
	jr .asm_69cd5

SlowbroLv26StrangeBehavior_InitialEffect2:
	ldh a, [hTempPlayAreaLocation_ff9d]
	ldh [hTemp_ffa0], a
	call Func_68335
	ld hl, $b5
	jr c, .asm_69d01
	ldh a, [hTempPlayAreaLocation_ff9d]
	add DUELVARS_ARENA_CARD_HP
	get_turn_duelist_var
	ld hl, $db
	cp $14
	jr c, .asm_69d01
	ldh a, [hTempPlayAreaLocation_ff9d]
	bank1call CheckIsIncapableOfUsingPkmnPower
	ret
.asm_69d01
	scf
	ret

SlowbroLv26StrangeBehavior_BeforeDamage:
	ld a, DUELVARS_DUELIST_TYPE
	get_turn_duelist_var
	cp $00
	jr z, .asm_69d11
	bank1call Func_5c30
	bank1call PrintPlayAreaCardList_EnableLCD
	ret
.asm_69d11
	ldtx hl, ProcedureForStrangeBehaviorText
	bank1call Func_5475
	xor a
	ldh [hffb2], a
	bank1call Func_5c30
.asm_69d1d
	bank1call PrintPlayAreaCardList_EnableLCD
	push af
	ldh a, [hffb2]
	ld hl, Data_68743
	call InitializeMenuParameters
	pop af
	ld [wNumScrollMenuItems], a
.asm_69d2d
	call DoFrame
	call HandleMenuInput
	jr nc, .asm_69d2d
	cp $ff
	ret z
	ldh [hffb2], a
	ldh [hTempPlayAreaLocation_ffa1], a
	ld hl, hTemp_ffa0
	cp [hl]
	jr z, .asm_69d54
	call GetCardDamageAndMaxHP
	or a
	jr z, .asm_69d54
	call Func_69d62
	jr c, .asm_69d54
	ld a, $16
	call SetOppAction_SerialSendDuelData
	jr .asm_69d1d
.asm_69d54
	call Func_3071
	jr .asm_69d2d

SlowbroLv26StrangeBehavior_Unk11:
	call Func_69d62
	ret c
	bank1call PrintPlayAreaCardList_EnableLCD
	or a
	ret

Func_69d62:
	ldh a, [hTemp_ffa0]
	add DUELVARS_ARENA_CARD_HP
	get_turn_duelist_var
	sub $0a
	jr z, .asm_69d77
	ld [hl], a
	ldh a, [hTempPlayAreaLocation_ffa1]
	add $c8
	ld l, a
	ld a, $0a
	add [hl]
	ld [hl], a
	or a
	ret
.asm_69d77
	scf
	ret

SlowbroLv26Psyshock_BeforeDamage:
	call Func_68027
	ret

SlowpokeLv18SpacingOut_InitialEffect1:
	ld e, $00
	call GetCardDamageAndMaxHP
	ld hl, $b6
	cp $0a
	ret

SlowpokeLv18SpacingOut_BeforeDamage:
	ldtx de, AttackSuccessCheckText
	call TossCoin_Bank1a
	ldh [hTemp_ffa0], a
	jp nc, Func_6809a
	ld a, $58
	ld [wLoadedAttackAnimation], a
	ret

SlowpokeLv18SpacingOut_AfterDamage:
	ldh a, [hTemp_ffa0]
	or a
	ret z
	ld de, $a
	call ApplyAndAnimateHPRecovery
	ret

SlowpokeLv18Scavenge_InitialEffect1:
	call Func_696b4
	ret c
	call Func_683b4
	ld hl, $ce
	ret

SlowpokeLv18Scavenge_InitialEffect2:
	ld a, $0d
	call Func_681e5
	xor a
	bank1call DisplayEnergyDiscardMenu
	bank1call HandleAttachedEnergyMenuInput
	ret c
	ldh a, [hTempCardIndex_ff98]
	ldh [hTemp_ffa0], a
	or a
	ret

SlowpokeLv18Scavenge_AISelection:
	ld a, $0d
	call Func_681e5
	ld a, [wDuelTempList]
	ldh [hTemp_ffa0], a
	call Func_683b4
	ld a, [wDuelTempList]
	ldh [hTempPlayAreaLocation_ffa1], a
	ret

SlowpokeLv18Scavenge_DiscardEnergy:
	ldh a, [hTemp_ffa0]
	call Func_0ffa
	ret

SlowpokeLv18Scavenge_RequireSelection:
	call Func_683b4
	bank1call Func_5221
	ldtx hl, PleaseSelectCardText
	ldtx de, DuelistDiscardPileText
	bank1call SetCardListHeaderAndInfoText
.asm_69dea
	bank1call DisplayCardList
	jr c, .asm_69dea
	ldh a, [hTempCardIndex_ff98]
	ldh [hTempPlayAreaLocation_ffa1], a
	ret

SlowpokeLv18Scavenge_AfterDamage:
	ldh a, [hTempPlayAreaLocation_ffa1]
	call MoveDiscardPileCardToHand
	call AddCardToHand
	call Func_680ab
	ret c
	ldh a, [hTempPlayAreaLocation_ffa1]
	ldtx hl, WasPlacedInTheHandText
	bank1call DisplayCardDetailScreen
	ret

SlowpokeLv9Amnesia_InitialEffect1:
	call Func_68501
	ret

SlowpokeLv9Amnesia_InitialEffect2:
	call Func_690c3
	ret

SlowpokeLv9Amnesia_AISelection:
	call Func_68633
	ret

SlowpokeLv9Amnesia_BeforeDamage:
	call Func_690d0
	ret

KadabraLv38Recover_InitialEffect1:
	call Func_696b4
	ret c
	call GetCardDamageAndMaxHP
	ld hl, $b6
	cp $0a
	ret

KadabraLv38Recover_InitialEffect2:
	ld a, $0d
	call Func_681e5
	xor a
	bank1call DisplayEnergyDiscardMenu
	bank1call HandleAttachedEnergyMenuInput
	ret c
	ldh a, [hTempCardIndex_ff98]
	ldh [hTemp_ffa0], a
	ret

KadabraLv38Recover_AISelection:
	ld a, $0d
	call Func_681e5
	ld a, [wDuelTempList]
	ldh [hTemp_ffa0], a
	ret

KadabraLv38Recover_DiscardEnergy:
	ldh a, [hTemp_ffa0]
	call Func_0ffa
	ret

KadabraLv38Recover_AfterDamage:
	ld e, $00
	call GetCardDamageAndMaxHP
	ld e, a
	ld d, $00
	call ApplyAndAnimateHPRecovery
	ret

JynxLv23DoubleSlap_AI:
	ld a, 10
	lb de, 0, 20
	call Func_680dd
	ret

JynxLv23DoubleSlap_BeforeDamage:
	ld hl, $a
	call LoadTxRam3
	ldtx de, DamageCheckXDamageTimesHeadsText
	ld a, $02
	call Func_68069
	call ATimes10
	call Func_6817e
	ret

JynxLv23Meditate_BeforeDamage:
	call SwapTurn
	ld e, $00
	call GetCardDamageAndMaxHP
	call SwapTurn
	call Func_68163
	ret

MewLv15MysteryAttack_AI:
	ld a, 10
	lb de, 0, 20
	call Func_680dd
	ret

MewLv15MysteryAttack_BeforeDamage:
	ld a, $0a
	call Func_6817e
	call UpdateRNGSources
	and $07
	ldh [hTemp_ffa0], a
	ld hl, .Data_69e9d
	jp JumpToFunctionInTable

.Data_69e9d:
	dw Func_6802e
	dw Func_68012
	dw Func_6805c
	dw Func_68045
	dw Func_69ebf
	dw Func_69ebf
	dw Func_69ead
	dw Func_69eb3

Func_69ead:
	ld a, $14
	call Func_6817e
	ret

Func_69eb3:
	ld a, $5b
	ld [wLoadedAttackAnimation], a
	xor a
	call Func_6817e
	call Func_68094

Func_69ebf:
	ret

MewLv15MysteryAttack_AfterDamage:
	ldh a, [hTemp_ffa0]
	cp $04
	ret nz
	ld de, $a
	call ApplyAndAnimateHPRecovery
	ret

GeodudeLv16StoneBarrage_AI:
	ld a, 10
	lb de, 0, 100
	call Func_680dd
	ret

GeodudeLv16StoneBarrage_BeforeDamage:
	xor a
	ldh [hTemp_ffa0], a
.asm_69ed8
	ldtx de, FlipUntilTails10DamageTimesHeadsText
	xor a
	call Func_68069
	jr nc, .asm_69ee7
	ld hl, hTemp_ffa0
	inc [hl]
	jr .asm_69ed8
.asm_69ee7
	ldh a, [hTemp_ffa0]
	ld l, a
	ld h, $0a
	call HtimesL
	ld de, wDamage
	ld a, l
	ld [de], a
	inc de
	ld a, h
	ld [de], a
	ret

OnixLv12Harden_BeforeDamage:
	ld a, $13
	call Func_68127
	ret

PrimeapeFurySwipes_AI:
	ld a, 30
	lb de, 0, 60
	call Func_680dd
	ret

PrimeapeFurySwipes_BeforeDamage:
	ld hl, $14
	call LoadTxRam3
	ldtx de, DamageCheckXDamageTimesHeadsText
	ld a, $03
	call Func_68069
	add a
	call ATimes10
	call Func_6817e
	ret

PrimeapeTantrum_BeforeDamage:
	ldtx de, IfTailsYourPokemonBecomesConfusedText
	call TossCoin_Bank1a
	ret c
	ld a, $29
	ld [wLoadedAttackAnimation], a
	call SwapTurn
	call Func_68045
	call SwapTurn
	ret

MachampLv67StrikesBack_InitialEffect1:
	scf
	ret

KabutoLv9KabutoArmor_InitialEffect1:
	scf
	ret

KabutopsAbsorb_AfterDamage:
	ld hl, wDealtDamage
	ld a, [hli]
	ld h, [hl]
	ld l, a
	srl h
	rr l
	bit 0, l
	jr z, .asm_69f49
	ld de, $5
	add hl, de
.asm_69f49
	ld e, l
	ld d, h
	call ApplyAndAnimateHPRecovery
	ret

CuboneLv13Snivel_BeforeDamage:
	ld a, $03
	call Func_6812e
	ret

CuboneLv13Rage_AI:
	ldh a, [hTempPlayAreaLocation_ff9d]
	jr Func_69f5a

CuboneLv13Rage_BeforeDamage:
	xor a
;	fallthrough

Func_69f5a:
	ld e, a
	call GetCardDamageAndMaxHP
	call Func_68163
	ret

MarowakLv26Bonemerang_AI:
	ld a, 30
	lb de, 0, 60
	call Func_680dd
	ret

MarowakLv26Bonemerang_BeforeDamage:
	ld hl, $1e
	call LoadTxRam3
	ldtx de, DamageCheckXDamageTimesHeadsText
	ld a, $02
	call Func_68069
	ld e, a
	add a
	add e
	call ATimes10
	call Func_6817e
	ret

MarowakLv26CallForFriend_InitialEffect1:
	farcall Func_2435f
	ret c
	farcall Func_24369
	ret

MarowakLv26CallForFriend_RequireSelection:
	call CreateDeckCardList
	ldtx hl, ChooseBasicFightingPokemonFromDeckText
	ldtx bc, EffectTargetFightingPokemonText
	ld a, CARDSEARCH_BASIC_FIGHTING_POKEMON
	farcall Func_24c9d
	jr c, .asm_69fa8
	ldtx hl, ChooseBasicFightingPokemonText
	ldtx de, DuelistDeckText
	farcall Func_24df8
.asm_69fa8
	ldh [hTemp_ffa0], a
	ret

MarowakLv26CallForFriend_AISelection:
	ld a, CARDSEARCH_BASIC_FIGHTING_POKEMON
	farcall SetCardSearchFuncParams
	call CreateDeckCardList
	ld hl, wDuelTempList
.asm_69fb7
	ld a, [hli]
	ldh [hTemp_ffa0], a
	cp $ff
	ret z
	farcall ExecuteCardSearchFunc
	jr nc, .asm_69fb7
	ret

MarowakLv26CallForFriend_AfterDamage:
	ldh a, [hTemp_ffa0]
	cp $ff
	jr z, .asm_69fe0
	call SearchCardInDeckAndAddToHand
	call AddCardToHand
	call PutHandPokemonCardInPlayArea
	call Func_680ab
	jr c, .asm_69fe0
	ldh a, [hTemp_ffa0]
	ldtx hl, PlacedOnBenchText
	bank1call DisplayCardDetailScreen
.asm_69fe0
	call Func_680a0
	ret

MachokeLv40KarateChop_AI:
	ldh a, [hTempPlayAreaLocation_ff9d]
	call Func_69fed
	jp Func_6818c

MachokeLv40KarateChop_BeforeDamage:
	xor a
;	fallthrough

Func_69fed:
	ld e, a
	call GetCardDamageAndMaxHP
	ld e, a
	ld hl, wDamage
	ld a, [hl]
	sub e
	ld [hli], a
	ld a, [hl]
	sbc $00
	ld [hl], a
	rla
	ret nc
	xor a
	call Func_6817e
	ret

MachokeLv40Submission_AfterDamage:
	ld a, $14
	call DealRecoilDamageToSelf
	ret

GolemLv36Selfdestruct_AfterDamage:
	ld a, $64
	call DealRecoilDamageToSelf
	call Func_6806e
	ld a, $14
	call Func_680f9
	call SwapTurn
	call Func_68074
	ld a, $14
	call Func_680f9
	call SwapTurn
	ret

GravelerLv29Harden_BeforeDamage:
	ld a, $13
	call Func_68127
	ret

RhydonLv48RamAlt_RequireSelection:
	call HandleMandatorySwitchSelection
	ldh a, [hTempPlayAreaLocation_ff9d]
	ldh [hTemp_ffa0], a
	ret

RhydonLv48RamAlt_AfterDamage:
	ld a, $14
	call DealRecoilDamageToSelf
	call Func_68074
	ldh a, [hTemp_ffa0]
	call Func_6828a
	ret

RhyhornLeer_BeforeDamage:
	ldtx de, IfHeadsOpponentCannotAttackText
	call TossCoin_Bank1a
	jp nc, Func_6809a
	ld a, $74
	ld [wLoadedAttackAnimation], a
	ld a, $06
	call Func_6812e
	ret

HitmonleeLv30StretchKick_InitialEffect1:
	call Func_6843b
	ret

HitmonleeLv30StretchKick_RequireSelection:
	call Func_68665
	ret

HitmonleeLv30StretchKick_AISelection:
	call Func_6869d
	ldh [hTemp_ffa0], a
	ret

HitmonleeLv30StretchKick_AfterDamage:
	call SwapTurn
	ldh a, [hTemp_ffa0]
	ld b, a
	ld de, $14
	call DealDamageToPlayAreaPokemon_RegularAnim
	call SwapTurn
	ret

SandshrewLv12SandAttack_BeforeDamage:
	ld a, $02
	call Func_6812e
	ret

SandslashLv33FurySwipes_AI:
	ld a, 30
	lb de, 0, 60
	call Func_680dd
	ret

SandslashLv33FurySwipes_BeforeDamage:
	ld hl, $14
	call LoadTxRam3
	ldtx de, DamageCheckXDamageTimesHeadsText
	ld a, $03
	call Func_68069
	add a
	call ATimes10
	call Func_6817e
	ret

DugtrioLv36Earthquake_AfterDamage:
	call Func_6806e
	ld a, $0a
	call Func_680f9
	ret

AerodactylLv28PrehistoricPower_InitialEffect1:
	scf
	ret

MankeyLv7Peek_InitialEffect2:
	jp Func_6844f

MankeyLv7Peek_BeforeDamage:
	call Func_68465
	ld a, DUELVARS_DUELIST_TYPE
	get_turn_duelist_var
	cp $01
	jr z, .asm_6a0c0
	and $80
	jr nz, .asm_6a0c5
	call FinishQueuedAnimations
	call HandlePeekSelection
	ldh [hTempPlayAreaLocation_ffa1], a
	call SerialSend8Bytes
	ret
.asm_6a0c0
	call SerialRecv8Bytes
	ldh [hTempPlayAreaLocation_ffa1], a
.asm_6a0c5
	ldh a, [hTempPlayAreaLocation_ffa1]
	bit 7, a
	jr z, .asm_6a0e2
	and $7f
	cp $40
	jr c, .asm_6a0d5
	ldh a, [hTempPlayAreaLocation_ffa1]
	jr .asm_6a0e2
.asm_6a0d5
	call SwapTurn
	ldtx hl, PeekWasUsedToLookInYourHandText
	bank1call DisplayCardDetailScreen
	call SwapTurn
	ret
.asm_6a0e2
	call FinishQueuedAnimations
	call SwapTurn
	ldh a, [hTempPlayAreaLocation_ffa1]
	xor $80
	call DrawAIPeekScreen
	call SwapTurn
	ldtx hl, CardPeekWasUsedOnText
	call DrawWideTextBox_WaitForInput
	ret

MarowakLv32BoneAttack_BeforeDamage:
	ldtx de, IfHeadsOpponentCannotAttackText
	call TossCoin_Bank1a
	ret nc
	ld a, $ff
	ld [wLoadedAttackAnimation], a
	ld a, $0b
	call Func_6812e
	ret

MarowakLv32Wail_InitialEffect1:
	farcall Func_2435f
	jr nc, .asm_6a11c
	call SwapTurn
	farcall Func_2435f
	call SwapTurn
	ret c
.asm_6a11c
	farcall Func_24369
	ret nc
	call SwapTurn
	farcall Func_24369
	call SwapTurn
	ret

MarowakLv32Wail_AfterDamage:
	call SwapTurn
	call Func_6a151
	call SwapTurn
	call Func_6a151
	ldtx hl, BasicPokemonWasPlacedOnEachBenchText
	call DrawWideTextBox_WaitForInput
	bank1call HasAlivePokemonInPlayArea
	bank1call OpenPlayAreaScreenForSelection
	call SwapTurn
	bank1call HasAlivePokemonInPlayArea
	bank1call OpenPlayAreaScreenForSelection
	call SwapTurn
	ret

Func_6a151:
	call CreateDeckCardList
	ret c
	ld hl, wDuelTempList
	call ShuffleCards
.asm_6a15b
	push hl
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	ld hl, wMaxNumPlayAreaPokemon
	cp [hl]
	pop hl
	jr nc, .asm_6a18c
.asm_6a166
	ld a, [hli]
	ldh [hTempCardIndex_ff98], a
	cp $ff
	jr z, .asm_6a18c
	call LoadCardDataToBuffer2_FromDeckIndex
	ld a, [wLoadedCard2Type]
	cp $08
	jr nc, .asm_6a166
	ld a, [wLoadedCard2Stage]
	or a
	jr nz, .asm_6a166
	push hl
	ldh a, [hTempCardIndex_ff98]
	call SearchCardInDeckAndAddToHand
	call AddCardToHand
	call PutHandPokemonCardInPlayArea
	pop hl
	jr .asm_6a15b
.asm_6a18c
	call Func_680a0
	ret

ElectabuzzLv35Thundershock_BeforeDamage:
	call Func_68027
	ret

ElectabuzzLv35Thunderpunch_AI:
	ld a, 35
	lb de, 30, 40
	call Func_680dd
	ret

ElectabuzzLv35Thunderpunch_BeforeDamage:
	ldtx de, IfHeadPlus10IfTails10ToYourselfText
	call TossCoin_Bank1a
	ldh [hTemp_ffa0], a
	ret nc
	ld a, $0a
	call Func_68163
	ret

ElectabuzzLv35Thunderpunch_AfterDamage:
	ldh a, [hTemp_ffa0]
	or a
	ret nz
	ld a, $0a
	call DealRecoilDamageToSelf
	ret

ElectabuzzLv20LightScreen_BeforeDamage:
	ld a, $1a
	call Func_68127
	ret

ElectabuzzLv20QuickAttack_AI:
	ld a, 20
	lb de, 10, 30
	call Func_680dd
	ret

ElectabuzzLv20QuickAttack_BeforeDamage:
	ld hl, $14
	call LoadTxRam3
	ldtx de, DamageCheckIfHeadsPlusDamageText
	call TossCoin_Bank1a
	ret nc
	ld a, $14
	call Func_68163
	ret

MagnemiteLv13ThunderWave_BeforeDamage:
	call Func_68027
	ret

MagnemiteLv13Selfdestruct_AfterDamage:
	ld a, $28
	call DealRecoilDamageToSelf
	call Func_6806e
	ld a, $0a
	call Func_680f9
	call SwapTurn
	call Func_68074
	ld a, $0a
	call Func_680f9
	call SwapTurn
	ret

ZapdosLv64Thunder_BeforeDamage:
	ld hl, $1e
	call LoadTxRam3
	ldtx de, IfTailsDamageToYourselfTooText
	call TossCoin_Bank1a
	ldh [hTemp_ffa0], a
	ret

ZapdosLv64Thunder_AfterDamage:
	ld hl, $1e
	call LoadTxRam3
	ldh a, [hTemp_ffa0]
	or a
	ret nz
	ld a, $1e
	call DealRecoilDamageToSelf
	ret

ZapdosLv64Thunderbolt_BeforeDamage:
	xor a
	call CreateArenaOrBenchEnergyCardList
	ld hl, wDuelTempList
.asm_6a21e
	ld a, [hli]
	cp $ff
	ret z
	call Func_0ffa
	jr .asm_6a21e

ZapdosLv40Thunderstorm_AfterDamage:
	ld a, $01
	ldh [hffb2], a
	call SwapTurn
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	ld c, a
	ld b, $00
	ld e, b
	jr .asm_6a254
.asm_6a237
	push de
	push bc
	call Func_6a28f
	ld de, $0
	call SwapTurn
	call TossCoin_Bank1a
	call SwapTurn
	push af
	farcall Func_24350
	pop af
	ld [hl], a
	pop bc
	pop de
	jr c, .asm_6a254
	inc b
.asm_6a254
	inc e
	dec c
	jr nz, .asm_6a237
	farcall Func_24350
	ld [hl], $ff
	ld a, b
	ldh [hTemp_ffa0], a
	call ResetAnimationQueue
	call SwapTurn
	ldh a, [hTemp_ffa0]
	or a
	jr z, .asm_6a272
	call ATimes10
	call DealRecoilDamageToSelf
.asm_6a272
	call SwapTurn
	ld hl, hTempPlayAreaLocation_ffa1
	ld b, $01
.asm_6a27a
	ld a, [hli]
	cp $ff
	jr z, .asm_6a28b
	or a
	jr z, .asm_6a288
	ld de, $14
	call DealDamageToPlayAreaPokemon_RegularAnim
.asm_6a288
	inc b
	jr .asm_6a27a
.asm_6a28b
	call SwapTurn
	ret

Func_6a28f:
	ld b, e
	ld hl, $4e
	ld de, wDefaultText
	call CopyText
	ld a, $05
	ld [de], a
	inc de
	ld a, $20
	add b
	ld [de], a
	inc de
	ld a, $70
	ld [de], a
	inc de
	ld a, $bb
	add b
	get_turn_duelist_var
	call LoadCardDataToBuffer2_FromDeckIndex
	ld hl, wLoadedCard2Name
	ld a, [hli]
	ld h, [hl]
	ld l, a
	call CopyText
	xor a
	ld [wDuelDisplayedScreen], a
	ret

JolteonLv29QuickAttack_AI:
	ld a, 20
	lb de, 10, 30
	call Func_680dd
	ret

JolteonLv29QuickAttack_BeforeDamage:
	ld a, $14
	call Func_682e0
	ret

JolteonLv29PinMissile_AI:
	ld a, 40
	lb de, 0, 80
	call Func_680dd
	ret

JolteonLv29PinMissile_BeforeDamage:
	ld hl, $14
	call LoadTxRam3
	ldtx de, DamageCheckXDamageTimesHeadsText
	ld a, $04
	call Func_68069
	add a
	call ATimes10
	call Func_6817e
	ret

FlyingPikachuLv12Thundershock_BeforeDamage:
	call Func_68027
	ret

FlyingPikachuLv12Fly_AI:
	jr Func_6a2f1

FlyingPikachuLv12Fly_BeforeDamage:
	jr Func_6a2fa

Func_6a2f1:
	ld a, 30
	lb de, 0, 30
	call Func_680dd
	ret

Func_6a2fa:
	ldtx de, AttackSuccessCheckText
	call TossCoin_Bank1a
	jr c, .asm_6a30d
	xor a
	ld [wLoadedAttackAnimation], a
	call Func_6817e
	call Func_6809a
	ret
.asm_6a30d
	ld a, $52
	ld [wLoadedAttackAnimation], a
	ld a, $12
	call Func_68127
	ret

FlyingPikachuAltLv12Thundershock_BeforeDamage:
	call Func_68027
	ret

FlyingPikachuAltLv12Fly_AI:
	jr Func_6a2f1

FlyingPikachuAltLv12Fly_BeforeDamage:
	jr Func_6a2fa

PikachuLv12ThunderJolt_BeforeDamage:
	ld hl, $a
	call LoadTxRam3
	ldtx de, IfTailsDamageToYourselfTooText
	call TossCoin_Bank1a
	ldh [hTemp_ffa0], a
	ret

PikachuLv12ThunderJolt_AfterDamage:
	ld hl, $a
	call LoadTxRam3
	ldh a, [hTemp_ffa0]
	or a
	ret nz
	ld a, $0a
	call DealRecoilDamageToSelf
	ret

PikachuLv14Spark_RequireSelection:
	call Func_68665
	ret

PikachuLv14Spark_AISelection:
	ld a, $ff
	ldh [hTemp_ffa0], a
	call Func_6843b
	ret c
	call Func_6869d
	ldh [hTemp_ffa0], a
	ret

PikachuLv14Spark_AfterDamage:
	ldh a, [hTemp_ffa0]
	cp $ff
	ret z
	call SwapTurn
	ldh a, [hTemp_ffa0]
	ld b, a
	ld de, $a
	call DealDamageToPlayAreaPokemon_RegularAnim
	call SwapTurn
	ret

PikachuLv16Growl_BeforeDamage:
	ld a, $17
	call Func_6812e
	ret

PikachuLv16Thundershock_BeforeDamage:
	call Func_68027
	ret

PikachuAltLv16Growl_BeforeDamage:
	ld a, $17
	call Func_6812e
	ret

PikachuAltLv16Thundershock_BeforeDamage:
	call Func_68027
	ret

ElectrodeLv42ChainLightning_AfterDamage:
	ld a, $0a
	call Func_6817e
	call SwapTurn
	bank1call GetArenaCardColor
	call SwapTurn
	ldh [hffb2], a
	cp $06
	ret z
	call SwapTurn
	call Func_6a3a0
	call SwapTurn
	call Func_6806e
	call Func_6a3a0
	call Func_68074
	ret

Func_6a3a0:
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	ld e, a
	ld d, $00
	jr .asm_6a3bb
.asm_6a3a8
	ld a, d
	bank1call GetPlayAreaCardColor
	ld c, a
	ldh a, [hffb2]
	cp c
	jr nz, .asm_6a3bb
	push de
	ld b, d
	ld de, $a
	call DealDamageToPlayAreaPokemon_RegularAnim
	pop de
.asm_6a3bb
	inc d
	dec e
	jr nz, .asm_6a3a8
	ret

RaichuLv40Agility_BeforeDamage:
	ldtx de, IfHeadsDoNotReceiveDamageOrEffectText
	call TossCoin_Bank1a
	ret nc
	ld a, $52
	ld [wLoadedAttackAnimation], a
	ld a, $11
	call Func_68127
	ret

RaichuLv40Thunder_BeforeDamage:
	ld hl, $1e
	call LoadTxRam3
	ldtx de, IfTailsDamageToYourselfTooText
	call TossCoin_Bank1a
	ldh [hTemp_ffa0], a
	ret

RaichuLv40Thunder_AfterDamage:
	ld hl, $1e
	call LoadTxRam3
	ldh a, [hTemp_ffa0]
	or a
	ret nz
	ld a, $1e
	call DealRecoilDamageToSelf
	ret

RaichuLv45Gigashock_RequireSelection:
	ld a, $ff
	ldh [hTemp_ffa0], a
	call Func_6843b
	ret c
	call SwapTurn
	ldtx hl, ChooseUpTo3BenchedPokemonToGiveDamageText
	call DrawWideTextBox_WaitForInput
	xor a
	ldh [hffb2], a
	ld [wcdf8], a
	bank1call Func_5c30
;	fallthrough

Func_6a40b:
.asm_6a40b
	bank1call PrintPlayAreaCardList_EnableLCD
	push af
	ld a, [wcdf8]
	ld hl, $474b
	call InitializeMenuParameters
	pop af
	dec a
	ld [wNumScrollMenuItems], a
.asm_6a41d
	call DoFrame
	call HandleMenuInput
	jr nc, .asm_6a41d
	cp $ff
	jr z, .asm_6a46a
	ld [wcdf8], a
	call Func_6a48b
	jr nc, .asm_6a436
	call Func_3071
	jr .asm_6a41d
.asm_6a436
	ldh a, [hCurScrollMenuItem]
	inc a
	ld b, $03
	call Func_6872f
	farcall Func_24350
	ldh a, [hCurScrollMenuItem]
	inc a
	ld [hl], a
	ldh a, [hffb2]
	ld c, a
	cp $03
	jr nc, .asm_6a454
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	dec a
	cp c
	jr nz, .asm_6a40b
.asm_6a454
	ldh a, [hCurScrollMenuItem]
	inc a
	call Func_680ed
	ldh a, [hKeysPressed]
	and $02
	jr nz, .asm_6a46a
	call SwapTurn
	farcall Func_24350
	ld [hl], $ff
	ret
.asm_6a46a
	ldh a, [hffb2]
	or a
	jr z, .asm_6a40b
	dec a
	ldh [hffb2], a
	ld e, a
	ld d, $00
	ld hl, hTemp_ffa0
	add hl, de
	ld a, [hl]
	push af
	ld b, $00
	call Func_6872f
	call EraseCursor
	pop af
	dec a
	ld [wcdf8], a
	jp Func_6a40b

Func_6a48b:
	inc a
	ld c, a
	ldh a, [hffb2]
	ld b, a
	ld hl, hTemp_ffa0
	inc b
	jr .asm_6a49a
.asm_6a496
	ld a, [hli]
	cp c
	scf
	ret z
.asm_6a49a
	dec b
	jr nz, .asm_6a496
	or a
	ret

RaichuLv45Gigashock_AISelection:
	ld a, $f5
	call GetNonTurnDuelistVariable
	cp $05
	jr nc, .asm_6a4b8
	ld hl, hTemp_ffa0
	ld b, $00
	jr .asm_6a4b1
.asm_6a4af
	ld [hl], b
	inc hl
.asm_6a4b1
	inc b
	dec a
	jr nz, .asm_6a4af
	ld [hl], $ff
	ret
.asm_6a4b8
	call SwapTurn
	dec a
	ld c, a
	ld b, $01
	ld hl, hTemp_ffa0
.asm_6a4c2
	ld [hl], b
	inc hl
	inc b
	dec c
	jr nz, .asm_6a4c2
	ld [hl], $00
	ld de, hTemp_ffa0
.asm_6a4cd
	ld a, [de]
	add DUELVARS_ARENA_CARD_HP
	get_turn_duelist_var
	ld c, a
	ld l, e
	ld h, d
	inc hl
.asm_6a4d5
	ld a, [hli]
	or a
	jr z, .asm_6a4ea
	push hl
	add DUELVARS_ARENA_CARD_HP
	get_turn_duelist_var
	pop hl
	cp c
	jr c, .asm_6a4d5
	ld c, a
	dec hl
	ld b, [hl]
	ld a, [de]
	ld [hli], a
	ld a, b
	ld [de], a
	jr .asm_6a4d5
.asm_6a4ea
	inc de
	ld a, [de]
	or a
	jr nz, .asm_6a4cd
	ld a, $ff
	ldh [hAIEnergyTransPlayAreaLocation], a
	call SwapTurn
	ret

RaichuLv45Gigashock_AfterDamage:
	call SwapTurn
	ld hl, hTemp_ffa0
.asm_6a4fd
	ld a, [hli]
	cp $ff
	jr z, .asm_6a50d
	push hl
	ld b, a
	ld de, $a
	call DealDamageToPlayAreaPokemon_RegularAnim
	pop hl
	jr .asm_6a4fd
.asm_6a50d
	call SwapTurn
	ret

MagnetonLv28ThunderWave_BeforeDamage:
	call Func_68027
	ret

MagnetonLv28Selfdestruct_AfterDamage:
	ld a, $50
	call DealRecoilDamageToSelf
	call Func_6806e
	ld a, $14
	call Func_680f9
	call SwapTurn
	call Func_68074
	ld a, $14
	call Func_680f9
	call SwapTurn
	ret

MagnetonLv35Sonicboom_BeforeDamage:
	ld hl, wDamage + 1
	set 7, [hl]
	ret

MagnetonLv35Selfdestruct_AfterDamage:
	ld a, $64
	call DealRecoilDamageToSelf
	call Func_6806e
	ld a, $14
	call Func_680f9
	call SwapTurn
	call Func_68074
	ld a, $14
	call Func_680f9
	call SwapTurn
	ret

ZapdosLv68PealOfThunder_InitialEffect1:
	scf
	ret

ZapdosLv68PealOfThunder_PkmnPowerTrigger:
	call ExchangeRNG
	ld de, $1e
	call Func_6a562
	bank1call Func_6518
	ret

Func_6a562:
.asm_6a562
	call UpdateRNGSources
	and $01
	jr nz, Func_6a586
	call Func_6806e
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	call Random
	ld b, a
	ldh a, [hTempPlayAreaLocation_ff9d]
	cp b
	jr z, .asm_6a562
;	fallthrough

Func_6a578:
	ld hl, wLoadedAttackCategory
	res 7, [hl]
	ld a, $82
	ld [wLoadedAttackAnimation], a
	call DealDamageToPlayAreaPokemon
	ret

Func_6a586:
	call Func_68074
	call SwapTurn
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	call Random
	ld b, a
	call Func_6a578
	call SwapTurn
	ret

ZapdosLv68BigThunder_AfterDamage:
	call ExchangeRNG
	ld de, $46
	call Func_6a562
	ret

MagnemiteLv14MagneticStorm_AfterDamage:
	ld a, DUELVARS_CARD_LOCATIONS
	get_turn_duelist_var
	ld de, wDuelTempList
	ld c, $00
.asm_6a5ac
	ld a, [hl]
	and $10
	jr z, .asm_6a5c6
	push hl
	push de
	push bc
	ld a, l
	call GetCardIDFromDeckIndex
	call GetCardType
	pop bc
	pop de
	pop hl
	and $08
	jr z, .asm_6a5c6
	ld a, l
	ld [de], a
	inc de
	inc c
.asm_6a5c6
	inc l
	ld a, l
	cp $3c
	jr c, .asm_6a5ac
	ld a, $ff
	ld [de], a
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	ld b, a
	ld a, c
	ld c, $ff
.asm_6a5d6
	inc c
	sub b
	jr nc, .asm_6a5d6
	push bc
	ld hl, wDuelTempList
	call CountCardsInDuelTempList
	call ShuffleCards
	ld d, c
	ld e, $00
.asm_6a5e7
	ld c, d
	inc c
	jr .asm_6a5f8
.asm_6a5eb
	ld a, [hli]
	push hl
	push de
	push bc
	call AddCardToHand
	call PutHandCardInPlayArea
	pop bc
	pop de
	pop hl
.asm_6a5f8
	dec c
	jr nz, .asm_6a5eb
	inc e
	dec b
	jr nz, .asm_6a5e7
	pop bc
	push hl
	ld hl, hTemp_ffa0
	push hl
	xor a
.asm_6a606
	ld [hli], a
	inc a
	cp b
	jr nz, .asm_6a606
	pop hl
	ld a, b
	call ShuffleCards
	pop hl
	ld de, hTemp_ffa0
.asm_6a614
	ld a, [hl]
	cp $ff
	jr z, .asm_6a62a
	push hl
	push de
	ld a, [de]
	ld e, a
	ld a, [hl]
	call AddCardToHand
	call PutHandCardInPlayArea
	pop de
	pop hl
	inc hl
	inc de
	jr .asm_6a614
.asm_6a62a
	bank1call DrawDuelMainScene
	bank1call DrawDuelHUDs
	ldtx hl, TheEnergyCardFromPlayAreaWasMovedText
	call DrawWideTextBox_WaitForInput
	xor a
	call Func_680ed
	ret

ElectrodeLv35Sonicboom_BeforeDamage:
	ld hl, wDamage + 1
	set 7, [hl]
	ret

ElectrodeLv35EnergySpike_InitialEffect1:
	farcall Func_2435f
	ret

ElectrodeLv35EnergySpike_RequireSelection:
	call CreateDeckCardList
	ldtx hl, Choose1BasicEnergyCardFromDeckText
	ldtx bc, EffectTargetBasicEnergyText
	ld a, CARDSEARCH_BASIC_ENERGY
	farcall Func_24c9d
	jr c, .asm_6a661
	ldtx hl, ChooseBasicEnergyCardText
	ldtx de, DuelistDeckText
	farcall Func_24df8
.asm_6a661
	ldh [hTemp_ffa0], a
	cp $ff
	ret z
	call EmptyScreen
	ldtx hl, ChoosePokemonToAttachEnergyCardText
	call DrawWideTextBox_WaitForInput
	bank1call HasAlivePokemonInPlayArea
.asm_6a672
	bank1call OpenPlayAreaScreenForSelection
	jr c, .asm_6a672
	ldh a, [hTempPlayAreaLocation_ff9d]
	ldh [hTempPlayAreaLocation_ffa1], a
	ret

ElectrodeLv35EnergySpike_AISelection:
	ld a, $ff
	ldh [hTemp_ffa0], a
	ret

ElectrodeLv35EnergySpike_AfterDamage:
	ldh a, [hTemp_ffa0]
	cp $ff
	jr z, .asm_6a6b5
	call SearchCardInDeckAndAddToHand
	call AddCardToHand
	ldh a, [hTempPlayAreaLocation_ffa1]
	ld e, a
	ldh a, [hTemp_ffa0]
	call PutHandCardInPlayArea
	call Func_680ab
	jr c, .asm_6a6b5
	ldh a, [hTempPlayAreaLocation_ffa1]
	add DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call LoadCardDataToBuffer1_FromDeckIndex
	ld hl, wLoadedCard1Name
	ld de, wTxRam2_b
	ld a, [hli]
	ld [de], a
	inc de
	ld a, [hli]
	ld [de], a
	ldh a, [hTemp_ffa0]
	ld hl, Zeroes
	bank1call DisplayCardDetailScreen
.asm_6a6b5
	call Func_680a0
	ret

JolteonLv24DoubleKick_AI:
	ld a, 20
	lb de, 0, 40
	call Func_680dd
	ret

JolteonLv24DoubleKick_BeforeDamage:
	ld hl, $14
	call LoadTxRam3
	ldtx de, DamageCheckXDamageTimesHeadsText
	ld a, $02
	call Func_68069
	add a
	call ATimes10
	call Func_6817e
	ret

JolteonLv24StunNeedle_BeforeDamage:
	call Func_68027
	ret

EeveeLv12TailWhip_BeforeDamage:
	ldtx de, IfHeadsOpponentCannotAttackText
	call TossCoin_Bank1a
	jp nc, Func_6809a
	ld a, $c9
	ld [wLoadedAttackAnimation], a
	ld a, $05
	call Func_6812e
	ret

EeveeLv12QuickAttack_AI:
	ld a, 20
	lb de, 10, 30
	call Func_680dd
	ret

EeveeLv12QuickAttack_BeforeDamage:
	ld a, $14
	call Func_682e0
	ret

SpearowLv13MirrorMove_AI:
	jp Func_6bcdf

SpearowLv13MirrorMove_InitialEffect1:
	jp Func_6bcea

SpearowLv13MirrorMove_InitialEffect2:
	jp Func_6bd10

SpearowLv13MirrorMove_RequireSelection:
	jp Func_6bd2c

SpearowLv13MirrorMove_AISelection:
	jp Func_6bd4b

SpearowLv13MirrorMove_AISwitchDefendingPkmn:
	jp Func_6bd76

SpearowLv13MirrorMove_BeforeDamage:
	jp Func_6bd85

SpearowLv13MirrorMove_AfterDamage:
	jp Func_6bde7

FearowLv27Agility_BeforeDamage:
	ldtx de, IfHeadsDoNotReceiveDamageOrEffectText
	call TossCoin_Bank1a
	ret nc
	ld a, $52
	ld [wLoadedAttackAnimation], a
	ld a, $11
	call Func_68127
	ret

DragoniteLv45StepIn_InitialEffect2:
	call Func_6844f
	ret c
	ldh a, [hTempPlayAreaLocation_ff9d]
	ldh [hTemp_ffa0], a
	or a
	ret nz
	ld hl, $dc
	scf
	ret

DragoniteLv45StepIn_BeforeDamage:
	call Func_68465
	ldh a, [hTemp_ffa0]
	ld e, a
	call SwapArenaWithBenchPokemon
	ret

DragoniteLv45Slam_AI:
	ld a, 40
	lb de, 0, 80
	call Func_680dd
	ret

DragoniteLv45Slam_BeforeDamage:
	ld hl, $28
	call LoadTxRam3
	ldtx de, DamageCheckXDamageTimesHeadsText
	ld a, $02
	call Func_68069
	add a
	add a
	call ATimes10
	call Func_6817e
	ret

SnorlaxLv20ThickSkinned_InitialEffect1:
	scf
	ret

SnorlaxLv20BodySlam_BeforeDamage:
	call Func_68027
	ret

FarfetchdLv20LeekSlap_AI:
	ld a, 30
	lb de, 0, 30
	call Func_680dd
	ret

FarfetchdLv20LeekSlap_InitialEffect1:
	ld a, DUELVARS_ARENA_CARD_FLAGS
	get_turn_duelist_var
	and $40
	ret z
	ld hl, $d1
	scf
	ret

FarfetchdLv20LeekSlap_DiscardEnergy:
	ld a, DUELVARS_ARENA_CARD_FLAGS
	get_turn_duelist_var
	set 6, [hl]
	ret

FarfetchdLv20LeekSlap_BeforeDamage:
	ldtx de, DamageCheckIfTailsNoDamageText
	call TossCoin_Bank1a
	ret c
	xor a
	call Func_6817e
	ret

KangaskhanLv40Fetch_InitialEffect1:
	farcall Func_2435f
	ret

KangaskhanLv40Fetch_AfterDamage:
	ldtx hl, Draw1CardFromTheDeckText
	call DrawWideTextBox_WaitForInput
	farcall DisplayDrawOneCardScreen
	call DrawCardFromDeck
	ret c
	call AddCardToHand
	call LoadCardDataToBuffer1_FromDeckIndex
	ld a, [wDuelistType]
	cp $00
	ret nz
	bank1call OpenCardPage_FromHand
	ret

KangaskhanLv40CometPunch_AI:
	ld a, 40
	lb de, 0, 80
	call Func_680dd
	ret

KangaskhanLv40CometPunch_BeforeDamage:
	ld hl, $14
	call LoadTxRam3
	ldtx de, DamageCheckXDamageTimesHeadsText
	ld a, $04
	call Func_68069
	add a
	call ATimes10
	call Func_6817e
	ret

TaurosLv32Stomp_AI:
	ld a, 25
	lb de, 20, 30
	call Func_680dd
	ret

TaurosLv32Stomp_BeforeDamage:
	ld a, $0a
	call Func_682e0
	ret

TaurosLv32Rampage_AI:
	ldh a, [hTempPlayAreaLocation_ff9d]
;	fallthrough

Func_6a7e1:
	ld e, a
	call GetCardDamageAndMaxHP
	call Func_68163
	ret

TaurosLv32Rampage_BeforeDamage:
	xor a
	call Func_6a7e1
	ldtx de, IfTailsYourPokemonBecomesConfusedText
	call TossCoin_Bank1a
	ret c
	call SwapTurn
	call Func_68045
	call SwapTurn
	ret

DoduoLv10FuryAttack_AI:
	ld a, 10
	lb de, 0, 20
	call Func_680dd
	ret

DoduoLv10FuryAttack_BeforeDamage:
	ld hl, $a
	call LoadTxRam3
	ld a, $02
	ldtx de, DamageCheckXDamageTimesHeadsText
	call Func_68069
	call ATimes10
	call Func_6817e
	ret

DodrioLv28RetreatAid_InitialEffect1:
	scf
	ret

DodrioLv28Rage_AI:
	ldh a, [hTempPlayAreaLocation_ff9d]
	jr Func_6a823

DodrioLv28Rage_BeforeDamage:
	xor a
;	fallthrough

Func_6a823:
	ld e, a
	call GetCardDamageAndMaxHP
	call Func_68163
	ret

MeowthLv15PayDay_AfterDamage:
	ldtx de, IfHeadsDraw1CardFromDeckText
	call TossCoin_Bank1a
	ret nc
	ldtx hl, Draw1CardFromTheDeckText
	call DrawWideTextBox_WaitForInput
	farcall DisplayDrawOneCardScreen
	call DrawCardFromDeck
	ret c
	call AddCardToHand
	call LoadCardDataToBuffer1_FromDeckIndex
	ld a, [wDuelistType]
	cp $00
	ret nz
	bank1call OpenCardPage_FromHand
	ret

DragonairSlam_AI:
	ld a, 30
	lb de, 0, 60
	call Func_680dd
	ret

DragonairSlam_BeforeDamage:
	ld hl, $1e
	call LoadTxRam3
	ld a, $02
	ldtx de, DamageCheckXDamageTimesHeadsText
	call Func_68069
	ld e, a
	add a
	add e
	call ATimes10
	call Func_6817e
	ret

DragonairHyperBeam_RequireSelection:
	jr Func_6a87d

DragonairHyperBeam_AISelection:
	jr Func_6a877

DragonairHyperBeam_AfterDamage:
	jr Func_6a8a5

Func_6a877:
	call Func_685dd
	ldh [hTemp_ffa0], a
	ret

Func_6a87d:
	call SwapTurn
	xor a
	call CreateArenaOrBenchEnergyCardList
	jr c, .asm_6a89d
	ldtx hl, ChooseEnergyCardFromOppActiveToDiscardText
	call DrawWideTextBox_WaitForInput
	xor a
	bank1call DisplayEnergyDiscardMenu
.asm_6a890
	bank1call HandleAttachedEnergyMenuInput
	jr c, .asm_6a890
	call SwapTurn
	ldh a, [hTempCardIndex_ff98]
	ldh [hTemp_ffa0], a
	ret
.asm_6a89d
	call SwapTurn
	ld a, $ff
	ldh [hTemp_ffa0], a
	ret

Func_6a8a5:
	ldh a, [hTemp_ffa0]
	cp $ff
	ret z
	call Func_682be
	ret c
	call SwapTurn
	ldh a, [hTemp_ffa0]
	call Func_0ffa
	ld a, DUELVARS_ARENA_CARD_LAST_TURN_EFFECT
	get_turn_duelist_var
	ld [hl], $01
	call SwapTurn
	ret

ClefableMetronome_InitialEffect1:
	ld a, $01
	ld [wMetronomeEnergyCost], a
	call Func_68501
	ret

ClefableMetronome_AISelection:
	call Func_6a9dd
	ret

ClefableMetronome_InitialEffect2:
	ld a, $01
	call Func_6a958
	ret

ClefableMinimize_BeforeDamage:
	ld a, $18
	call Func_68127
	ret

PidgeotLv40Hurricane_AfterDamage:
	call Func_682be
	ret c
	ld a, $c8
	call GetNonTurnDuelistVariable
	or a
	ret z
	call SwapTurn
	ld a, DUELVARS_CARD_LOCATIONS
	get_turn_duelist_var
.asm_6a8e9
	ld a, [hl]
	cp $10
	jr nz, .asm_6a8f2
	ld a, l
	call AddCardToHand
.asm_6a8f2
	inc l
	ld a, l
	cp $3c
	jr c, .asm_6a8e9
	ld l, $bb
	ld a, [hl]
	ld [hl], $ff
	ld l, $c8
	ld [hl], $00
	ld l, $da
	ld [hl], $00
	call LoadCardDataToBuffer1_FromDeckIndex
	ld hl, wLoadedCard1Name
	ld a, [hli]
	ld h, [hl]
	ld l, a
	call LoadTxRam2
	ldtx hl, PokemonAndAllAttachedCardsReturnedToHandText
	call DrawWideTextBox_WaitForInput
	xor a
	ld [wDuelDisplayedScreen], a
	call SwapTurn
	ret

PidgeottoLv36Whirlwind_RequireSelection:
	call HandleMandatorySwitchSelection
	ldh a, [hTempPlayAreaLocation_ff9d]
	ldh [hTemp_ffa0], a
	ret

PidgeottoLv36Whirlwind_AfterDamage:
	ldh a, [hTemp_ffa0]
	call Func_6828a
	ret

PidgeottoLv36MirrorMove_AI:
	jp Func_6bcdf

PidgeottoLv36MirrorMove_InitialEffect1:
	jp Func_6bcea

PidgeottoLv36MirrorMove_InitialEffect2:
	jp Func_6bd10

PidgeottoLv36MirrorMove_RequireSelection:
	jp Func_6bd2c

PidgeottoLv36MirrorMove_AISelection:
	jp Func_6bd4b

PidgeottoLv36MirrorMove_AISwitchDefendingPkmn:
	jp Func_6bd76

PidgeottoLv36MirrorMove_BeforeDamage:
	jp Func_6bd85

PidgeottoLv36MirrorMove_AfterDamage:
	jp Func_6bde7

ClefairyLv14Sing_BeforeDamage:
	call Func_6804a
	ret

ClefairyLv14Metronome_InitialEffect1:
	ld a, $03
	ld [wMetronomeEnergyCost], a
	call Func_68501
	ret

ClefairyLv14Metronome_AISelection:
	call Func_6a9dd
	ret

ClefairyLv14Metronome_InitialEffect2:
	ld a, $03
;	fallthrough

Func_6a958:
	ld [wMetronomeEnergyCost], a
	ldtx hl, ChooseOppAttackForMetronomeText
	call DrawWideTextBox_WaitForInput
.asm_6a961
	call Func_68486
	jr c, .asm_6a961
	ld hl, wcdf9
	ld [hl], d
	inc hl
	ld [hl], e
	ld hl, wLoadedAttackName
	ld a, [hli]
	ld h, [hl]
	ld l, a
	push hl
	call SwapTurn
	call CopyAttackDataAndDamage_FromDeckIndex
	call SwapTurn
	pop de
	ld hl, wLoadedAttackName
	ld a, e
	cp [hl]
	jr nz, .asm_6a991
	inc hl
	ld a, d
	cp [hl]
	jr nz, .asm_6a991
	ldtx hl, UnableToSelectText
	call DrawWideTextBox_WaitForInput
	jr .asm_6a961
.asm_6a991
	ld a, $01
	call TryExecuteEffectCommandFunction
	jr nc, .asm_6a9a5
	call DrawWideTextBox_WaitForInput
	ld a, $01
	ld [wcd16], a
	call Func_6a9ac
	scf
	ret
.asm_6a9a5
	ld a, $02
	call TryExecuteEffectCommandFunction
	jr c, .asm_6a9a5

Func_6a9ac:
	call SendAttackDataToLinkOpponent
	ld a, $15
	call SetOppAction_SerialSendDuelData
	ld hl, wcdf9
	ld d, [hl]
	inc hl
	ld e, [hl]
	ld a, [wMetronomeEnergyCost]
	ld c, a
	ld a, [wcd16]
	call SerialSend8Bytes
	ldh a, [hTempCardIndex_ff9f]
	ld [wPlayerAttackingCardIndex], a
	ld a, [wSelectedAttack]
	ld [wPlayerAttackingAttackIndex], a
	ld a, [wTempCardID_ccc2]
	ld [wPlayerAttackingCardID], a
	ld a, [wTempCardID_ccc2 + 1]
	ld [wPlayerAttackingCardID + 1], a
	or a
	ret

Func_6a9dd:
	ret

WigglytuffLv36Lullaby_BeforeDamage:
	call Func_6805c
	ret

WigglytuffLv36DoTheWave_BeforeDamage:
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	dec a
	call ATimes10
	call Func_68163
	ret

JigglypuffLv14Lullaby_BeforeDamage:
	call Func_6805c
	ret

JigglypuffLv12FirstAid_InitialEffect1:
	ld e, $00
	call GetCardDamageAndMaxHP
	ld hl, $b6
	cp $0a
	ret

JigglypuffLv12FirstAid_AfterDamage:
	ld de, $a
	call ApplyAndAnimateHPRecovery
	ret

JigglypuffLv12DoubleEdge_AfterDamage:
	ld a, $14
	call DealRecoilDamageToSelf
	ret

PersianPounce_BeforeDamage:
	ld a, $07
	call Func_6812e
	ret

LickitungLv26TongueWrap_BeforeDamage:
	call Func_68027
	ret

LickitungLv26Supersonic_BeforeDamage:
	call Func_68033
	ret

PidgeyLv8Whirlwind_RequireSelection:
	call HandleMandatorySwitchSelection
	ldh a, [hTempPlayAreaLocation_ff9d]
	ldh [hTemp_ffa0], a
	ret

PidgeyLv8Whirlwind_AfterDamage:
	ldh a, [hTemp_ffa0]
	call Func_6828a
	ret

PorygonLv12Conversion1_InitialEffect1:
	jr Func_6aa2e

PorygonLv12Conversion1_InitialEffect2:
	jr Func_6aa44

PorygonLv12Conversion1_AISelection:
	jp Func_6aae2

PorygonLv12Conversion1_AfterDamage:
	jr Func_6aa4f

Func_6aa2e:
	call SwapTurn
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call LoadCardDataToBuffer2_FromDeckIndex
	call SwapTurn
	ld a, [wLoadedCard2Weakness]
	or a
	ret nz
	ld hl, $d2
	scf
	ret

Func_6aa44:
	ld hl, $167
	xor a
	farcall Func_24ebf
	ldh [hTemp_ffa0], a
	ret

Func_6aa4f:
	ldh a, [hTemp_ffa0]
	cp $ff
	ret z
	call Func_682be
	ret c
	ld a, $ef
	call GetNonTurnDuelistVariable
	ldh a, [hTemp_ffa0]
	call TranslateColorToWR
	ld [hl], a
	ld l, $fc
	ld [hl], a
	ld l, $fd
	ld [hl], $09
	call SwapTurn
	ldtx hl, ChangedTheWeaknessOfPokemonToColorText
	call Func_6aad1
	call SwapTurn
	ld a, $08
	call Func_6812e
	ret

PorygonLv12Conversion2_InitialEffect1:
	jr Func_6aa84

PorygonLv12Conversion2_InitialEffect2:
	jr Func_6aa94

PorygonLv12Conversion2_AISelection:
	jr Func_6aaa0

PorygonLv12Conversion2_AfterDamage:
	jr Func_6aac0

Func_6aa84:
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call LoadCardDataToBuffer2_FromDeckIndex
	ld a, [wLoadedCard2Resistance]
	or a
	ret nz
	ld hl, $d3
	scf
	ret

Func_6aa94:
	ld hl, $168
	ld a, $80
	farcall Func_24ebf
	ldh [hTemp_ffa0], a
	ret

Func_6aaa0:
	call SwapTurn
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call LoadCardDataToBuffer1_FromDeckIndex
	call SwapTurn
	ld a, [wLoadedCard1Type]
	cp $06
	jr z, .asm_6aab6
	ldh [hTemp_ffa0], a
	ret
.asm_6aab6
	call SwapTurn
	call Func_6aae2
	call SwapTurn
	ret

Func_6aac0:
	ldh a, [hTemp_ffa0]
	cp $ff
	ret z
	ld a, DUELVARS_ARENA_CARD_CHANGED_RESISTANCE
	get_turn_duelist_var
	ldh a, [hTemp_ffa0]
	call TranslateColorToWR
	ld [hl], a
	ldtx hl, ChangedTheResistanceOfPokemonToColorText
;	fallthrough

; hl - text
Func_6aad1:
	push hl
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call LoadCardDataToBuffer1_FromDeckIndex
	ldh a, [hTemp_ffa0]
	call Func_68708
	pop hl
	call DrawWideTextBox_PrintText
	ret

Func_6aae2:
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	ld d, a
	ld e, $00
	jr .asm_6ab0c
.asm_6aaea
	push de
	call GetPlayAreaCardAttachedEnergies
	ld a, e
	add DUELVARS_ARENA_CARD
	get_turn_duelist_var
	ld d, a
	call LoadCardDataToBuffer1_FromDeckIndex
	ld a, [wLoadedCard1Type]
	cp $06
	jr z, .asm_6ab0b
	ld e, $00
	bank1call CheckIfEnoughEnergiesToAttack.CheckEnergy
	jr nc, .asm_6ab3b
	ld e, $01
	bank1call CheckIfEnoughEnergiesToAttack.CheckEnergy
	jr nc, .asm_6ab3b
.asm_6ab0b
	pop de
.asm_6ab0c
	inc e
	dec d
	jr nz, .asm_6aaea
	ld d, e
	ld e, $00
	jr .asm_6ab2f
.asm_6ab15
	push de
	call GetPlayAreaCardAttachedEnergies
	ld a, [wTotalAttachedEnergies]
	or a
	jr z, .asm_6ab2e
	ld a, e
	add DUELVARS_ARENA_CARD
	get_turn_duelist_var
	ld d, a
	call LoadCardDataToBuffer1_FromDeckIndex
	ld a, [wLoadedCard1Type]
	cp $06
	jr nz, .asm_6ab3b
.asm_6ab2e
	pop de
.asm_6ab2f
	inc e
	dec d
	jr nz, .asm_6ab15
	ld a, $06
	call Random
	ldh [hTemp_ffa0], a
	ret
.asm_6ab3b
	pop de
	ld a, [wLoadedCard1Type]
	and $07
	ldh [hTemp_ffa0], a
	ret

ChanseyLv55Scrunch_BeforeDamage:
	ldtx de, IfHeadsNoDamageNextTurnText
	call TossCoin_Bank1a
	jp nc, Func_6809a
	ld a, $6b
	ld [wLoadedAttackAnimation], a
	ld a, $1c
	call Func_68127
	ret

ChanseyLv55DoubleEdge_AfterDamage:
	ld a, $50
	call DealRecoilDamageToSelf
	ret

RaticateSuperFang_BeforeDamage:
	ld a, $c8
	call GetNonTurnDuelistVariable
	srl a
	bit 0, a
	jr z, .asm_6ab6b
	add $05
.asm_6ab6b
	call Func_6817e
	ret

EffectCommands_58896_InitialEffect2:
	ldh a, [hTempPlayAreaLocation_ff9d]
	ldh [hTemp_ffa0], a
	call Func_68446
	ret

EffectCommands_58896_RequireSelection:
	ldh a, [hTemp_ffa0]
	or a
	ret nz
	ldtx hl, SelectPokemonToPlaceInTheArenaText
	call DrawWideTextBox_WaitForInput
	bank1call HasAlivePokemonInBench
	bank1call OpenPlayAreaScreenForSelection
	ldh a, [hTempPlayAreaLocation_ff9d]
	ldh [hTempPlayAreaLocation_ffa1], a
	ret

EffectCommands_58896_BeforeDamage:
	ldh a, [hTemp_ffa0]
	ld e, a
	call Func_12fc
	ldh a, [hTemp_ffa0]
	or a
	jr nz, .asm_6ab9d
	ldh a, [hTempPlayAreaLocation_ffa1]
	ld e, a
	call SwapArenaWithBenchPokemon
.asm_6ab9d
	call ShiftAllPokemonToFirstPlayAreaSlots
	ret

DragoniteLv41HealingWind_InitialEffect1:
	scf
	ret

DragoniteLv41HealingWind_PkmnPowerTrigger:
	ldh a, [hTempPlayAreaLocation_ff9d]
	ld b, a
	ld c, $00
	ldh a, [hWhoseTurn]
	ld h, a
	farcall PlayAttackAnimation
	farcall WaitAttackAnimation
	farcall ResetAttackAnimationIsPlaying
	ld a, $86
	ld [wLoadedAttackAnimation], a
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	ld d, a
	ld e, $00
.asm_6abc2
	push de
	ld a, e
	ldh [hTempPlayAreaLocation_ff9d], a
	call GetCardDamageAndMaxHP
	or a
	jr z, .asm_6abea
	ld de, $14
	cp e
	jr nc, .asm_6abd3
	ld e, a
.asm_6abd3
	ldh a, [hTempPlayAreaLocation_ff9d]
	add DUELVARS_ARENA_CARD_HP
	get_turn_duelist_var
	add e
	ld [hl], a
	ldh a, [hTempPlayAreaLocation_ff9d]
	ld b, a
	ld c, $01
	ldh a, [hWhoseTurn]
	ld h, a
	farcall PlayAttackAnimation
	farcall WaitAttackAnimation
.asm_6abea
	pop de
	inc e
	dec d
	jr nz, .asm_6abc2
	ret

DragoniteLv41Slam_AI:
	ld a, 30
	lb de, 0, 60
	call Func_680dd
	ret

DragoniteLv41Slam_BeforeDamage:
	ld hl, $1e
	call LoadTxRam3
	ldtx de, DamageCheckXDamageTimesHeadsText
	ld a, $02
	call Func_68069
	ld c, a
	add a
	add c
	call ATimes10
	call Func_6817e
	ret

Func_6ac11:
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	ld c, a
	ld l, $c8
	ld de, wcdfb
.asm_6ac1a
	ld a, [hli]
	ld [de], a
	inc de
	dec c
	jr nz, .asm_6ac1a
	ret

Func_6ac21:
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	ld c, a
	ld l, $c8
	ld de, wcdfb
.asm_6ac2a
	ld a, [de]
	inc de
	ld [hli], a
	dec c
	jr nz, .asm_6ac2a
	ret

MeowthLv13CatPunch_AfterDamage:
	call SwapTurn
	call Func_68196
	ld b, a
	ld a, $83
	ld [wLoadedAttackAnimation], a
	ld de, $14
	call DealDamageToPlayAreaPokemon
	call SwapTurn
	ret

DittoMorph_InitialEffect1:
	farcall Func_2435f
	ret

DittoMorph_AfterDamage:
	call ExchangeRNG
	call Func_6acbc
	jr nc, .asm_6ac5b
	ldtx hl, AttackUnsuccessfulText
	call DrawWideTextBox_WaitForInput
	ret
.asm_6ac5b
	ld a, DUELVARS_ARENA_CARD_STAGE
	get_turn_duelist_var
	or a
	jr z, .asm_6ac6f
	push hl
	xor a
	ldh [hTempPlayAreaLocation_ff9d], a
	bank1call GetCardOneStageBelow
	ld a, d
	call PutCardInDiscardPile
	pop hl
	ld [hl], $00
.asm_6ac6f
	ldh a, [hTempCardIndex_ff98]
	call GetCardIDFromDeckIndex
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	ldh [hTempCardIndex_ff98], a
	call _GetCardIDFromDeckIndex
	ld [hl], e
	inc hl
	ld [hl], d
	ld e, $00
	call GetCardDamageAndMaxHP
	ld a, DUELVARS_ARENA_CARD_HP
	get_turn_duelist_var
	ld [hl], c
	ld l, $d4
	ld [hl], $00
	call ClearAllStatusConditions
	ld hl, wTempTurnDuelistCardID
	ld e, [hl]
	inc hl
	ld d, [hl]
	call LoadCardDataToBuffer2_FromCardID
	ld hl, wLoadedCard2Name
	ld de, wTxRam2
	ld a, [hli]
	ld [de], a
	inc de
	ld a, [hl]
	ld [de], a
	inc de
	ldh a, [hTempCardIndex_ff98]
	call LoadCardDataToBuffer2_FromDeckIndex
	ld hl, wLoadedCard2Name
	ld a, [hli]
	ld [de], a
	inc de
	ld a, [hl]
	ld [de], a
	ldtx hl, MetamorphsToText
	call DrawWideTextBox_WaitForInput
	xor a
	ld [wDuelDisplayedScreen], a
	ret

Func_6acbc:
	call CreateDeckCardList
	ret c
	ld hl, wDuelTempList
	call ShuffleCards
.asm_6acc6
	ld a, [hli]
	ldh [hTempCardIndex_ff98], a
	cp $ff
	jr z, .asm_6acf1
	call LoadCardDataToBuffer2_FromDeckIndex
	ld a, [wLoadedCard2Type]
	cp $08
	jr nc, .asm_6acc6
	ld a, [wLoadedCard2Stage]
	or a
	jr nz, .asm_6acc6
	push hl
	ld hl, wLoadedCard2ID
	cphl DITTO
	pop hl
	jr z, .asm_6acc6
	ldh a, [hTempCardIndex_ff98]
	or a
	ret
.asm_6acf1
	scf
	ret

Func_6acf3:
	call CreateDeckCardList
	ret c
	ld hl, wDuelTempList
	call ShuffleCards
.asm_6acfd
	ld a, [hli]
	ldh [hTempCardIndex_ff98], a
	cp $ff
	jr z, .asm_6ad18
	call LoadCardDataToBuffer2_FromDeckIndex
	ld a, [wLoadedCard2Type]
	cp $08
	jr nc, .asm_6acfd
	ld a, [wLoadedCard2Stage]
	or a
	jr nz, .asm_6acfd
	ldh a, [hTempCardIndex_ff98]
	or a
	ret
.asm_6ad18
	scf
	ret

PidgeotLv38SlicingWing_AfterDamage:
	call SwapTurn
	call Func_68196
	ld b, a
	ld de, $1e
	call DealDamageToPlayAreaPokemon_RegularAnim
	call SwapTurn
	ret

PidgeotLv38Gale_BeforeDamage:
	ld a, $87
	ld [wLoadedAttackAnimation], a
	ret

PidgeotLv38Gale_AfterDamage:
	ld a, $c8
	call GetNonTurnDuelistVariable
	or a
	jr nz, .asm_6ad43
	ld a, $ed
	call GetNonTurnDuelistVariable
	cp $1b
	jr nz, .asm_6ad50
	ret
.asm_6ad43
	call Func_6843b
	jr c, .asm_6ad50
	dec a
	call Random
	inc a
	call Func_6828a
.asm_6ad50
	call Func_68446
	ret c
	dec a
	call Random
	inc a
	ld [wcd0a], a
	ld e, a
	call SwapArenaWithBenchPokemon
	xor a
	ld [wDuelDisplayedScreen], a
	ret

JigglypuffLv13FriendshipSong_InitialEffect1:
	farcall Func_2435f
	ret c
	farcall Func_24369
	ret

JigglypuffLv13FriendshipSong_AfterDamage:
	ldtx de, AttackSuccessCheckText
	call TossCoin_Bank1a
	jr c, Func_6ad7e

Func_6ad77:
	ldtx hl, NoneCameText
	call DrawWideTextBox_WaitForInput
	ret

Func_6ad7e:
	call Func_6acf3
	jr nc, .asm_6ad90
	ld a, $6a
	farcall Func_18a87
	call Func_6ad77
	call Func_680a0
	ret
.asm_6ad90
	call SearchCardInDeckAndAddToHand
	call AddCardToHand
	call PutHandPokemonCardInPlayArea
	ld a, $6a
	farcall Func_18a87
	ldh a, [hTempCardIndex_ff98]
	ldtx hl, CameToTheBenchText
	bank1call DisplayCardDetailScreen
	call Func_680a0
	ret

JigglypuffLv13Expand_AfterDamage:
	ld a, $23
	call Func_68127
	ret

CharmanderLv9GatherFire_InitialEffect2:
	call Func_6844f
	ret

CharmanderLv9GatherFire_RequireSelection:
	ldtx hl, ProcedureForGatherFireText
	bank1call Func_5475
	bank1call HasAlivePokemonInPlayArea
.asm_6adbe
	bank1call OpenPlayAreaScreenForSelection
	ret c
	ldh a, [hTempPlayAreaLocation_ff9d]
	ld e, a
	ldh a, [hTemp_ffa0]
	cp e
	jr z, .asm_6adbe
	call Func_681af
	jr c, .asm_6adbe
	ldh a, [hTempPlayAreaLocation_ff9d]
	ld de, $51
	bank1call DisplayAttachedEnergyMenu
	bank1call HandleAttachedEnergyMenuInput
	ret c
	ldh a, [hTempCardIndex_ff98]
	ldh [hTempPlayAreaLocation_ffa1], a
	ret

CharmanderLv9GatherFire_BeforeDamage:
	call Func_68465
	ldh a, [hTemp_ffa0]
	ldh [hTempPlayAreaLocation_ff9d], a
	ld e, a
	or a
	jr z, .asm_6adf0
	ld a, $5e
	ld [wLoadedAttackAnimation], a
.asm_6adf0
	ldh a, [hTempPlayAreaLocation_ffa1]
	call AddCardToHand
	call PutHandCardInPlayArea
	ld a, [wLoadedAttackAnimation]
	farcall Func_18a87
	ret

DarkCharmeleonFireball_AI:
	ld a, 70
	lb de, 0, 70
	call Func_680dd
	ret

DarkCharmeleonFireball_InitialEffect1:
	call Func_6808d
	call Func_6927b
	ret

DarkCharmeleonFireball_AISwitchDefendingPkmn:
	ldtx de, DamageCheckIfTailsNoDamageText
	call Func_68079
	ldh [hTemp_ffa0], a
	ret nc
	call Func_69291
	ldh [hTempPlayAreaLocation_ffa1], a
	ld a, $01
	ldh [hTemp_ffa0], a
	ret

DarkCharmeleonFireball_RequireSelection:
	ldtx de, DamageCheckIfTailsNoDamageText
	call Func_68079
	ldh [hTemp_ffa0], a
	ret nc
.asm_6ae2c
	call Func_6926c
	jr c, .asm_6ae2c
	ld a, $01
	ldh [hTemp_ffa0], a
	ldh a, [hTempCardIndex_ff98]
	ldh [hTempPlayAreaLocation_ffa1], a
	ret

DarkCharmeleonFireball_BeforeDamage:
	ldh a, [hTemp_ffa0]
	or a
	jr z, .asm_6ae44
	ldh a, [hTempPlayAreaLocation_ffa1]
	jp Func_0ffa
.asm_6ae44
	xor a
	ld [wLoadedAttackAnimation], a
	call Func_6817e
	call Func_6809a
	ret

DarkCharizardContinuousFireball_InitialEffect1:
	call Func_6808d
	call Func_6927b
	ret

DarkCharizardContinuousFireball_AI:
	ld e, $00
	call Func_69283
	ld l, a
	ld h, $32
	call HtimesL
	ld a, h
	or a
	jr z, .asm_6ae67
	ld l, $ff
.asm_6ae67
	ld a, l
	ld [wAIMaxDamage], a
	srl a
	ld [wDamage], a
	xor a
	ld [wAIMinDamage], a
	ret

DarkCharizardContinuousFireball_AISwitchDefendingPkmn:
	ld hl, $32
	call LoadTxRam3
	ld e, $00
	call Func_69283
	ld hl, $32
	ldtx de, DamageCheckXDamageTimesHeadsText
	call Func_6807b
	ldh [hTemp_ffa0], a
	or a
	ret z
	call Func_681e3
	ldh a, [hTemp_ffa0]
	cp $0f
	jr c, .asm_6ae98
	ld a, $0e
.asm_6ae98
	ld c, a
	ld hl, wDuelTempList
	ld de, hTempPlayAreaLocation_ffa1
.asm_6ae9f
	ld a, [hli]
	ld [de], a
	inc de
	dec c
	jr nz, .asm_6ae9f
	ld a, $ff
	ld [de], a
	ret

DarkCharizardContinuousFireball_RequireSelection:
	ld hl, $32
	call LoadTxRam3
	ld e, $00
	call Func_69283
	ld hl, $32
	ldtx de, DamageCheckXDamageTimesHeadsText
	call Func_6807b
	ldh [hTemp_ffa0], a
	or a
	ret z
	cp $10
	jr c, .asm_6aec9
	ld a, $0e
	ldh [hTemp_ffa0], a
.asm_6aec9
	ld a, $01
	ldh [hffb2], a
	call Func_681e3
	xor a
	bank1call DisplayEnergyDiscardMenu
	ldh a, [hTemp_ffa0]
	ld [wAttachedEnergyMenuDenominator], a
.asm_6aed9
	bank1call HandleAttachedEnergyMenuInput
	jr c, .asm_6aed9
	farcall Func_24350
	ldh a, [hTempCardIndex_ff98]
	ld [hl], a
	call RemoveCardFromDuelTempList
	ld hl, wAttachedEnergyMenuNumerator
	inc [hl]
	ld a, [wAttachedEnergyMenuDenominator]
	cp [hl]
	ret z
	bank1call UpdateAttachedEnergyMenu
	jr .asm_6aed9

DarkCharizardContinuousFireball_BeforeDamage:
	ld hl, hTemp_ffa0
	ld a, [hli]
	or a
	jr z, .asm_6af05
	ld c, a
.asm_6aefe
	ld a, [hli]
	call Func_0ffa
	dec c
	jr nz, .asm_6aefe
.asm_6af05
	ldh a, [hTemp_ffa0]
	ld l, a
	ld h, $32
	call HtimesL
	ld a, l
	ld [wDamage], a
	ld a, h
	ld [wDamage + 1], a
	ret

PonytaLv15Ember_InitialEffect1:
	call Func_6927b
	ret

PonytaLv15Ember_InitialEffect2:
	call Func_6926c
	ret

PonytaLv15Ember_AISelection:
	call Func_69291
	ret

PonytaLv15Ember_DiscardEnergy:
	ldh a, [hTemp_ffa0]
	jp Func_0ffa

DarkRapidashFlamePillar_AISelection:
	ld a, $01
	ldh [hTemp_ffa0], a
	ret

DarkRapidashFlamePillar_RequireSelection:
	ld a, $01
	ldh [hTemp_ffa0], a
	call Func_6927b
	jr c, .asm_6af60
	call Func_6843b
	jr c, .asm_6af60
	ldtx hl, RemoveEnergyCardPromptText
	call YesOrNoMenuWithText
	ldh [hTemp_ffa0], a
	jr c, .asm_6af60
.asm_6af44
	call Func_6926c
	jr c, .asm_6af44
	xor a
	ldh [hTemp_ffa0], a
	ldh a, [hTempCardIndex_ff98]
	ldh [hTempPlayAreaLocation_ffa1], a
.asm_6af50
	call SwapTurn
	bank1call HasAlivePokemonInBench
	bank1call OpenPlayAreaScreenForSelection
	call SwapTurn
	jr c, .asm_6af50
	ldh [hTempRetreatCostCards], a
.asm_6af60
	or a
	ret

DarkRapidashFlamePillar_AfterDamage:
	ldh a, [hTemp_ffa0]
	or a
	ret nz
	ldh a, [hTempPlayAreaLocation_ffa1]
	call Func_0ffa
	call SwapTurn
	ldh a, [hTempRetreatCostCards]
	ld b, a
	ld de, $a
	bank1call Func_6f37
	call DealDamageToPlayAreaPokemon_RegularAnim
	call SwapTurn
	ret

DarkFlareonRage_AI:
	ldh a, [hTempPlayAreaLocation_ff9d]
	jr Func_6af83

DarkFlareonRage_BeforeDamage:
	xor a
;	fallthrough

Func_6af83:
	ld e, a
	call GetCardDamageAndMaxHP
	call Func_68163
	ret

DarkFlareonPlayingWithFire_InitialEffect1:
	call Func_6808d
	ret

DarkFlareonPlayingWithFire_AI:
	ld e, $00
	call Func_69283
	cp $01
	jr c, .asm_6afa1
	ld a, 40
	lb de, 30, 50
	call Func_680dd
	ret
.asm_6afa1
	ld a, 0
	lb de, 0, 0
	call Func_680dd
	ret

DarkFlareonPlayingWithFire_AISwitchDefendingPkmn:
	ld hl, $14
	call LoadTxRam3
	ldtx de, DamageCheckIfHeadsPlusDamageText
	call Func_68079
	ldh [hTemp_ffa0], a
	ret nc
	call Func_69291
	ldh a, [hTemp_ffa0]
	ldh [hTempPlayAreaLocation_ffa1], a
	ld a, $01
	ldh [hTemp_ffa0], a
	ret

DarkFlareonPlayingWithFire_RequireSelection:
	ld hl, $14
	call LoadTxRam3
	ldtx de, DamageCheckIfHeadsPlusDamageText
	call Func_68079
	ldh [hTemp_ffa0], a
	ret nc
	ld e, $00
	call Func_69283
	cp $01
	jr c, .asm_6afe6
.asm_6afdd
	call Func_6926c
	jr c, .asm_6afdd
	ldh a, [hTempCardIndex_ff98]
	jr .asm_6afe8
.asm_6afe6
	ld a, $ff
.asm_6afe8
	ldh [hTempPlayAreaLocation_ffa1], a
	ld a, $01
	ldh [hTemp_ffa0], a
	or a
	ret

DarkFlareonPlayingWithFire_BeforeDamage:
	ldh a, [hTemp_ffa0]
	or a
	ret z
	ldh a, [hTempPlayAreaLocation_ffa1]
	cp $ff
	jr z, .asm_6b003
	call Func_0ffa
	ld a, $14
	call Func_68163
	ret
.asm_6b003
	xor a
	call Func_6817e
	call Func_6809a
	ret

DarkWartortleDoubleSlap_AI:
	ld a, 10
	lb de, 0, 20
	call Func_680dd
	ret

DarkWartortleDoubleSlap_BeforeDamage:
	ld hl, $a
	call LoadTxRam3
	ldtx de, DamageCheckXDamageTimesHeadsText
	ld a, $02
	call Func_68069
	call ATimes10
	call Func_6817e
	ret

DarkWartortleMirrorShell_BeforeDamage:
	ld a, $24
	call Func_68127
	ret

DarkBlastoiseHydrocannon_BeforeDamage:
	ld bc, $200
	call Func_68e8f
	ret

DarkBlastoiseRocketTackle_BeforeDamage:
	ldtx de, IfHeadsNoDamageNextTurnText
	call TossCoin_Bank1a
	ldh [hTemp_ffa0], a
	ret c
	ld a, $cc
	ld [wLoadedAttackAnimation], a
	ret

DarkBlastoiseRocketTackle_AfterDamage:
	ld de, $a
	bank1call Func_6f37
	ld a, e
	call DealRecoilDamageToSelf
	ldh a, [hTemp_ffa0]
	or a
	ret z
	ld a, $25
	call Func_68127
	ret

PsyduckLv16Dizziness_InitialEffect1:
	farcall Func_2435f
	ret

PsyduckLv16Dizziness_AfterDamage:
	ldtx hl, Draw1CardFromTheDeckText
	call DrawWideTextBox_WaitForInput
	farcall DisplayDrawOneCardScreen
	call DrawCardFromDeck
	ret c
	call AddCardToHand
	call LoadCardDataToBuffer1_FromDeckIndex
	ld a, [wDuelistType]
	cp $00
	ret nz
	bank1call OpenCardPage_FromHand
	ret

PsyduckLv16WaterGun_BeforeDamage:
	ld bc, $101
	call Func_68e88
	ret

DarkGolduckThirdEye_InitialEffect1:
	farcall Func_2435f
	ret c
	ld e, $00
	call GetPlayAreaCardAttachedEnergies
	ld a, [wTotalAttachedEnergies]
	or a
	ret nz
	ld hl, $2e
	scf
	ret

DarkGolduckThirdEye_AISelection:
	xor a
	call CreateArenaOrBenchEnergyCardList
	bank1call SortCardsInDuelTempListByID
	ld a, [wDuelTempList]
	ldh [hTemp_ffa0], a
	ret

DarkGolduckThirdEye_InitialEffect2:
	xor a
	call CreateArenaOrBenchEnergyCardList
	xor a
	bank1call DisplayEnergyDiscardMenu
	bank1call HandleAttachedEnergyMenuInput
	ret c
	ldh a, [hTempCardIndex_ff98]
	ldh [hTemp_ffa0], a
	ret

DarkGolduckThirdEye_DiscardEnergy:
	ldh a, [hTemp_ffa0]
	jp Func_0ffa

DarkGolduckThirdEye_AfterDamage:
	ld a, $03
	farcall DisplayDrawNCardsScreen
	ld c, $03
.asm_6b0c2
	call DrawCardFromDeck
	jr c, .asm_6b0d9
	ldh [hTempCardIndex_ff98], a
	call AddCardToHand
	call Func_680ab
	jr nc, .asm_6b0d6
	push bc
	bank1call DisplayPlayerDrawCardScreen
	pop bc
.asm_6b0d6
	dec c
	jr nz, .asm_6b0c2
.asm_6b0d9
	ret

MagikarpLv6RapidEvolution_InitialEffect1:
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call GetCardIDFromDeckIndex
	cp16 MAGIKARP_LV6
	jr nz, .asm_6b0ef
	farcall Func_2435f
	ret
.asm_6b0ef
	ld hl, $eb
	scf
	ret

MagikarpLv6RapidEvolution_RequireSelection:
	call CreateDeckCardList
	ldtx hl, ChooseEvolutionCardForMagikarpFromDeckText
	ldtx bc, EffectTargetGyaradosText
	ld de, DEX_GYARADOS
	ld a, CARDSEARCH_POKEDEX_NUMBER
	farcall Func_24c9d
	jr c, .asm_6b112
	ldtx hl, ChooseAGyaradosText
	ldtx de, DuelistDeckText
	farcall Func_24df8
.asm_6b112
	ldh [hTemp_ffa0], a
	ret

MagikarpLv6RapidEvolution_AISelection:
	ld de, DEX_GYARADOS
	ld a, CARDSEARCH_POKEDEX_NUMBER
	farcall SetCardSearchFuncParams
	call CreateDeckCardList
	ld hl, wDuelTempList
.asm_6b124
	ld a, [hli]
	ldh [hTemp_ffa0], a
	cp $ff
	ret z
	farcall ExecuteCardSearchFunc
	jr nc, .asm_6b124
	ret

MagikarpLv6RapidEvolution_AfterDamage:
	ldh a, [hTemp_ffa0]
	cp $ff
	jr z, .asm_6b145
	ldh [hTempCardIndex_ff98], a
	call SearchCardInDeckAndAddToHand
	call AddCardToHand
	xor a
	ldh [hTempPlayAreaLocation_ff9d], a
	call EvolvePokemonCard
.asm_6b145
	call Func_680a0
	ret

DarkGyaradosFinalBeam_InitialEffect1:
	scf
	ret

DarkGyaradosIceBeam_BeforeDamage:
	call Func_68027
	ret

DarkVaporeonWhirlpool_RequireSelection:
	call Func_6a87d
	ret

DarkVaporeonWhirlpool_AISelection:
	call Func_6a877
	ret

DarkVaporeonWhirlpool_AfterDamage:
	call Func_6a8a5
	ret

EkansLv15PoisonSting_AI:
	ld a, $05
	ld de, $a
	call Func_680b6
	ret

EkansLv15PoisonSting_BeforeDamage:
	ldtx de, PoisonInflictionCheckText
	call TossCoin_Bank1a
	jr nc, .asm_6b170
	call Func_68012
	ret
.asm_6b170
	ld a, $01
	ld [wLoadedAttackAnimation], a
	ret

DarkArbokStare_AI:
	ld a, $0a
	call Func_68175
	ret

DarkArbokStare_RequireSelection:
	call Func_68686
	ret

DarkArbokStare_AISelection:
	jr Func_6b18d

DarkArbokStare_BeforeDamage:
	jr Func_6b193

DarkArbokStare_AfterDamage:
	ld de, $a
	jr Func_6b1a1

Func_6b189:
	xor a
	ldh [hTemp_ffa0], a
	ret

Func_6b18d:
	call Func_686be
	ldh [hTemp_ffa0], a
	ret

Func_6b193:
	xor a
	ld [wLoadedAttackAnimation], a
	ldh a, [hTemp_ffa0]
	or a
	ret nz
	ld hl, wLoadedAttackCategory
	res 7, [hl]
	ret

Func_6b1a1:
	ldh a, [hTemp_ffa0]
	cp $ff
	ret z
	push de
	call SwapTurn
	ld e, a
	bank1call Func_6f49
	call SwapTurn
	pop de
	ret c
	ld a, $91
	ld [wLoadedAttackAnimation], a
	call SwapTurn
	ldh a, [hTemp_ffa0]
	or a
	jr nz, .asm_6b1ca
	ld a, DUELVARS_ARENA_CARD_LAST_TURN_EFFECT
	get_turn_duelist_var
	ld [hl], $06
	ld a, $ce
	ld [wLoadedAttackAnimation], a
.asm_6b1ca
	ldh a, [hTemp_ffa0]
	ld b, a
	bank1call Func_6f34
	call DealDamageToPlayAreaPokemon
	ld a, [wNoDamageOrEffect]
	or a
	jr nz, .asm_6b1ef
	ldh a, [hTemp_ffa0]
	add DUELVARS_ARENA_CARD_HP
	get_turn_duelist_var
	or a
	jr z, .asm_6b1ef
	ldh a, [hTemp_ffa0]
	add DUELVARS_ARENA_CARD_FLAGS
	get_turn_duelist_var
	set 4, [hl]
	ldh a, [hTemp_ffa0]
	add $d4
	ld l, a
	ld [hl], $00
.asm_6b1ef
	call SwapTurn
	ret

DarkArbokPoisonVapor_BeforeDamage:
	call Func_68012
	ret

DarkArbokPoisonVapor_AfterDamage:
	call SwapTurn
	ld de, $a
	bank1call Func_6f37
	ld a, e
	call Func_680f9
	call SwapTurn
	ret

DarkGolbatSneakAttack_InitialEffect1:
	scf
	ret

DarkGolbatSneakAttack_RequireSelection:
	call SwapTurn
	bank1call HasAlivePokemonInPlayArea
.asm_6b210
	bank1call OpenPlayAreaScreenForSelection
	jr c, .asm_6b210
	ldh [hTemp_ffa0], a
	call SwapTurn
	ret

DarkGolbatSneakAttack_PkmnPowerTrigger:
	call SwapTurn
	ldh a, [hTemp_ffa0]
	ld b, a
	ld de, $a
	call DealDamageToPlayAreaPokemon_RegularAnim
	call SwapTurn
	bank1call Func_6518
	ret

DarkGolbatFlitter_AI:
	ld a, $14
	call Func_68175
	ret

DarkGolbatFlitter_RequireSelection:
	call Func_68686
	ret

DarkGolbatFlitter_AISelection:
	call Func_686be
	ldh [hTemp_ffa0], a
	ret

DarkGolbatFlitter_BeforeDamage:
	ldh a, [hTemp_ffa0]
	or a
	jr nz, .asm_6b24d
	call Func_682a9
	ret c
	ld a, $14
	call Func_68175
	ret
.asm_6b24d
	xor a
	ld [wLoadedAttackAnimation], a
	ret

DarkGolbatFlitter_AfterDamage:
	ldh a, [hTemp_ffa0]
	or a
	ret z
	call SwapTurn
	ld b, a
	ld de, $14
	bank1call Func_6f37
	call DealDamageToPlayAreaPokemon_RegularAnim
	call SwapTurn
	ret

OddishLv21SleepPowder_BeforeDamage:
	call Func_6805c
	ret

OddishLv21PoisonPowder_AI:
	ld a, $0a
	ld de, $a0a
	call Func_680b6
	ret

OddishLv21PoisonPowder_BeforeDamage:
	call Func_68012
	ret

DarkGloomPollenStench_InitialEffect2:
	call Func_6844f
	ret

DarkGloomPollenStench_BeforeDamage:
	call Func_68465
	ldtx de, ConfuseOppIfHeadsConfuseYourselfIfTailsText
	call TossCoin_Bank1a
	jr c, .asm_6b298
	ld a, $bc
	farcall Func_18a87
	call SwapTurn
	call Func_68045
	call SwapTurn
	jr .asm_6b2a1
.asm_6b298
	ld a, $bb
	farcall Func_18a87
	call Func_68045
.asm_6b2a1
	farcall Func_18a19
	farcall WaitAttackAnimation
	ld a, DUELVARS_ARENA_CARD_LAST_TURN_STATUS
	get_turn_duelist_var
	push af
	push hl
	bank1call Func_64a5
	pop hl
	pop af
	ld [hl], a
	bank1call DrawDuelMainScene
	bank1call DrawDuelHUDs
	call Func_19e1
	call c, WaitForWideTextBoxInput
	ret

DarkGloomPoisonPowder_AI:
	ld a, $0a
	ld de, $a0a
	call Func_680b6
	ret

DarkGloomPoisonPowder_BeforeDamage:
	call Func_68012
	ret

DarkVileplumeHayFever_InitialEffect1:
	scf
	ret

DarkVileplumePetalWhirlwind_AI:
	ld a, 45
	lb de, 0, 90
	call Func_680dd
	ret

DarkVileplumePetalWhirlwind_BeforeDamage:
	ld hl, $1e
	call LoadTxRam3
	ld a, $03
	ldtx de, DamageCheckXDamageTimesHeadsText
	call Func_68069
	ld e, a
	add a
	add e
	call ATimes10
	call Func_6817e
	ld a, e
	cp $02
	ret c
	call SwapTurn
	call Func_68045
	call SwapTurn
	ret

GrimerLv10PoisonGas_AI:
	ld a, $0a
	ld de, $a0a
	call Func_680b6
	ret

GrimerLv10PoisonGas_BeforeDamage:
	call Func_68012
	ret

GrimerLv10StickyHands_AI:
	ld a, 20
	lb de, 10, 30
	call Func_680dd
	ret

GrimerLv10StickyHands_BeforeDamage:
	ldtx de, IfHeadsPlus20AndParalysisText
	call TossCoin_Bank1a
	ret nc
	ld a, $14
	call Func_68163
	call Func_6802e
	ret

DarkMukStickyGoo_InitialEffect1:
	scf
	ret

DarkMukSludgePunch_AI:
	ld a, $1e
	ld de, $1e1e
	call Func_680b6
	ret

DarkMukSludgePunch_BeforeDamage:
	call Func_68012
	ret

KoffingLv12PoisonGas_AI:
	ld a, $05
	ld de, $a
	call Func_680b6
	ret

KoffingLv12PoisonGas_BeforeDamage:
	call Func_6800b
	ret

DarkWeezingMassExplosion_BeforeDamage:
	ld e, $00
	call Func_6b36a
	call SwapTurn
	call Func_6b36a
	call SwapTurn
	ld a, e
	add a
	call ATimes10
	call Func_6817e
	ret

DarkWeezingMassExplosion_AfterDamage:
	call SwapTurn
	call Func_6b389
	call SwapTurn
	call Func_6806e
	call Func_6b389
	call Func_68074
	ret

Func_6b36a:
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	ld b, a
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
.asm_6b371
	ld a, [hli]
	cp $ff
	jr z, .asm_6b385
	call LoadCardDataToBuffer1_FromDeckIndex
	ld a, [wLoadedCard1PokedexNumber]
	cp $6d
	jr z, .asm_6b384
	cp $6e
	jr nz, .asm_6b385
.asm_6b384
	inc e
.asm_6b385
	dec b
	jr nz, .asm_6b371
	ret

Func_6b389:
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	ld b, a
	ld c, $00
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
.asm_6b392
	ld a, [hli]
	call LoadCardDataToBuffer1_FromDeckIndex
	ld a, [wLoadedCard1PokedexNumber]
	cp $6d
	jr z, .asm_6b3a1
	cp $6e
	jr nz, .asm_6b3c7
.asm_6b3a1
	push hl
	push bc
	ld a, c
	bank1call LoadPlayAreaCardID_ToTempNonTurnDuelistCardID
	ld a, [wIsDamageToSelf]
	or a
	jr z, .asm_6b3b2
	call Func_6b3cc
	jr .asm_6b3bb
.asm_6b3b2
	call SwapTurn
	call Func_6b3cc
	call SwapTurn
.asm_6b3bb
	jr c, .asm_6b3c5
	ld a, $78
	ld [wLoadedAttackAnimation], a
	call DealDamageToPlayAreaPokemon.asm_192a
.asm_6b3c5
	pop bc
	pop hl
.asm_6b3c7
	inc c
	dec b
	jr nz, .asm_6b392
	ret

Func_6b3cc:
	ld de, $14
	ld a, c
	or a
	jr z, .asm_6b3da
	ld b, $00
	bank1call DamageCalculation
	or a
	ret
.asm_6b3da
	ld a, [wIsDamageToSelf]
	jr nz, .asm_6b3ee
	ld a, c
	ld [wTempPlayAreaLocation_cceb], a
	xor a
	ld [wDamageEffectiveness], a
	ld b, $00
	bank1call DamageCalculation.asm_6b5d
	or a
	ret
.asm_6b3ee
	ld de, $14
	bank1call Func_6f37
	ld a, e
	call DealRecoilDamageToSelf
	scf
	ret

DarkWeezingStunGas_BeforeDamage:
	ldtx de, PoisonedIfHeadsParalyzedIfTailsText
	call TossCoin_Bank1a
	jr c, .asm_6b406
	call Func_6802e
	ret
.asm_6b406
	call Func_68012
	ret

AbraLv14Vanish_InitialEffect1:
	call Func_68446
	ret

AbraLv14Vanish_RequireSelection:
	ldtx hl, SelectPokemonToPlaceInTheArenaText
	call DrawWideTextBox_WaitForInput
	bank1call HasAlivePokemonInBench
.asm_6b417
	bank1call OpenPlayAreaScreenForSelection
	jr c, .asm_6b417
	ldh [hTemp_ffa0], a
	ret

AbraLv14Vanish_AfterDamage:
	ld a, DUELVARS_CARD_LOCATIONS
	get_turn_duelist_var
.asm_6b422
	ld a, [hl]
	cp $10
	jr nz, .asm_6b42b
	ld a, l
	call Func_0ffa
.asm_6b42b
	inc l
	ld a, l
	cp $3c
	jr c, .asm_6b422
	ld l, $bb
	ld a, [hl]
	call MoveDiscardPileCardToHand
	call ReturnCardToDeck
	ld [hl], $ff
	ld l, $c8
	ld [hl], $00
	ldh a, [hTemp_ffa0]
	ld e, a
	call SwapArenaWithBenchPokemon
	call ShiftAllPokemonToFirstPlayAreaSlots
	call Func_680a0
	ret

AbraLv14Psyshock_BeforeDamage:
	call Func_68027
	ret

DarkKadabraMatterExchange_InitialEffect2:
	call Func_6844f
	ret c
	farcall Func_2435f
	ret c
	ld a, DUELVARS_NUMBER_OF_CARDS_IN_HAND
	get_turn_duelist_var
	ld hl, $bf
	cp $01
	ret

DarkKadabraMatterExchange_RequireSelection:
	call CreateHandCardList
	bank1call Func_5221
	bank1call DisplayCardList
	ret c
	ldh [hTempPlayAreaLocation_ffa1], a
	ret

DarkKadabraMatterExchange_BeforeDamage:
	call Func_68465
	ldh a, [hTemp_ffa0]
	ldh [hTempPlayAreaLocation_ff9d], a
	or a
	jr z, .asm_6b47f
	ld a, $5e
	ld [wLoadedAttackAnimation], a
.asm_6b47f
	ld a, [wLoadedAttackAnimation]
	farcall Func_18a87
	ldh a, [hTempPlayAreaLocation_ffa1]
	call RemoveCardFromHand
	call PutCardInDiscardPile
	ld a, $01
	farcall DisplayDrawNCardsScreen
	call DrawCardFromDeck
	ldh [hTempCardIndex_ff98], a
	call AddCardToHand
	call Func_680ab
	ret nc
	bank1call DisplayPlayerDrawCardScreen
	ret

DarkKadabraMindShock_BeforeDamage:
	ld hl, wDamage + 1
	set 7, [hl]
	ret

DarkAlakazamTeleportBlast_RequireSelection:
	ld a, $ff
	ldh [hTemp_ffa0], a
	call Func_68446
	ret c
	ldtx hl, SwitchOutDarkAlakazamPromptText
	call YesOrNoMenuWithText
	ret c
	bank1call HasAlivePokemonInBench
.asm_6b4bc
	bank1call OpenPlayAreaScreenForSelection
	jr c, .asm_6b4bc
	ldh [hTemp_ffa0], a
	ret

DarkAlakazamTeleportBlast_AISelection:
	ld a, $ff
	ldh [hTemp_ffa0], a
	ret

DarkAlakazamTeleportBlast_BeforeDamage:
	ldh a, [hTemp_ffa0]
	cp $ff
	ret nz
	ld a, $19
	ld [wLoadedAttackAnimation], a
	ret

DarkAlakazamTeleportBlast_AfterDamage:
	ldh a, [hTemp_ffa0]
	cp $ff
	ret z
	ld a, $c8
	call GetNonTurnDuelistVariable
	or a
	jr nz, .asm_6b4e9
	ld a, $ed
	call GetNonTurnDuelistVariable
	cp $1b
	ret z
.asm_6b4e9
	ld hl, wDealtDamage
	ld a, [hli]
	or [hl]
	ret z
	ldh a, [hTemp_ffa0]
	ld [wcd0a], a
	ld e, a
	call SwapArenaWithBenchPokemon
	xor a
	ld [wDuelDisplayedScreen], a
	ret

DarkAlakazamMindShock_BeforeDamage:
	ld hl, wDamage + 1
	set 7, [hl]
	ret

SlowpokeLv16AfternoonNap_InitialEffect1:
	farcall Func_2435f
	ret

SlowpokeLv16AfternoonNap_RequireSelection:
	call CreateDeckCardList
	ldtx hl, ChooseAPsychicEnergyCardFromDeckText
	ldtx bc, EffectTargetPsychicEnergyText
	ld a, CARDSEARCH_PSYCHIC_ENERGY
	farcall Func_24c9d
	jr c, .asm_6b523
	ldtx hl, ChooseAPsychicEnergyCardText
	ldtx de, DuelistDeckText
	farcall Func_24df8
.asm_6b523
	ldh [hTemp_ffa0], a
	ret

SlowpokeLv16AfternoonNap_AISelection:
	ld a, CARDSEARCH_PSYCHIC_ENERGY
	farcall SetCardSearchFuncParams
	call CreateDeckCardList
	ld hl, wDuelTempList
.asm_6b532
	ld a, [hli]
	ldh [hTemp_ffa0], a
	cp $ff
	ret z
	farcall ExecuteCardSearchFunc
	jr nc, .asm_6b532
	ret

SlowpokeLv16AfternoonNap_AfterDamage:
	ldh a, [hTemp_ffa0]
	cp $ff
	jr z, .asm_6b54b
	call SearchCardInDeckAndAddToHand
	get_turn_duelist_var
	ld [hl], $10
.asm_6b54b
	call Func_680a0
	ret

DarkSlowbroReelIn_InitialEffect1:
	scf
	ret

DarkSlowbroReelIn_RequireSelection:
	call Func_68346
	jr nc, .asm_6b55e
	call DrawWideTextBox_WaitForInput
	ld a, $ff
	ldh [hTemp_ffa0], a
	ret
.asm_6b55e
	xor a
	ldh [hffb2], a
	ldtx hl, ChooseUpTo3PokemonCardsFromDiscardPileText
	call DrawWideTextBox_WaitForInput
.asm_6b567
	bank1call Func_5221
	ldtx hl, ChooseCardToPlaceInHandText
	ldtx de, DuelistDiscardPileText
	bank1call SetCardListHeaderAndInfoText
	bank1call DisplayCardList
	jr nc, .asm_6b581
	ld a, $03
	call Func_6856d
	jr c, .asm_6b567
	jr .asm_6b596
.asm_6b581
	ldh a, [hTempCardIndex_ff98]
	get_turn_duelist_var
	farcall Func_24350
	ldh a, [hTempCardIndex_ff98]
	ld [hl], a
	call RemoveCardFromDuelTempList
	jr c, .asm_6b596
	ldh a, [hffb2]
	cp $03
	jr c, .asm_6b567
.asm_6b596
	farcall Func_24350
	ld [hl], $ff
	or a
	ret

DarkSlowbroReelIn_PkmnPowerTrigger:
	ld hl, hTemp_ffa0
	ld de, wDuelTempList
	ld a, [hl]
	cp $ff
	jr nz, .asm_6b5aa
	ret
.asm_6b5aa
	ld a, [hli]
	ld [de], a
	inc de
	cp $ff
	jr z, .asm_6b5b9
	call MoveDiscardPileCardToHand
	call AddCardToHand
	jr .asm_6b5aa
.asm_6b5b9
	call Func_680ab
	jr c, .asm_6b5c1
	bank1call Func_49e8
.asm_6b5c1
	ret

DarkSlowbroFickleAttack_AI:
	ld a, 40
	lb de, 0, 40
	call Func_680dd
	ret

DarkSlowbroFickleAttack_BeforeDamage:
	ldtx de, AttackSuccessCheckText
	call TossCoin_Bank1a
	ret c
	xor a
	ld [wLoadedAttackAnimation], a
	call Func_6817e
	call Func_6809a
	ret

DrowzeeLv10LongDistanceHypnosis_InitialEffect2:
	call Func_6844f
	ret

DrowzeeLv10LongDistanceHypnosis_BeforeDamage:
	call Func_68465
	ldtx de, LongDistanceHypnosisCheckText
	call TossCoin_Bank1a
	jr c, .asm_6b5fd
	ld a, $a3
	farcall Func_18a87
	call SwapTurn
	call Func_6805c
	call SwapTurn
	jr .asm_6b606
.asm_6b5fd
	ld a, $a2
	farcall Func_18a87
	call Func_6805c
.asm_6b606
	farcall Func_18a19
	farcall WaitAttackAnimation
	ld a, DUELVARS_ARENA_CARD_LAST_TURN_STATUS
	get_turn_duelist_var
	push af
	push hl
	bank1call Func_64a5
	pop hl
	pop af
	ld [hl], a
	bank1call DrawDuelMainScene
	bank1call DrawDuelHUDs
	call Func_19e1
	call c, WaitForWideTextBoxInput
	ret

DrowzeeLv10Nightmare_BeforeDamage:
	call Func_6805c
	ret

DarkHypnoBenchManipulation_AI:
	ld a, $f5
	call GetNonTurnDuelistVariable
	add a
	call ATimes10
	ld [wAIMaxDamage], a
	srl a
	ld [wDamage], a
	xor a
	ld [wAIMinDamage], a
	ret

DarkHypnoBenchManipulation_InitialEffect1:
	call Func_6843b
	ret

DarkHypnoBenchManipulation_BeforeDamage:
	call SwapTurn
	ld a, $01
	ld [wTempPlayAreaLocation_cceb], a
	bank1call CheckArticunoAuroraVeil
	call SwapTurn
	jr nc, .asm_6b655
	ret
.asm_6b655
	ld hl, $14
	call LoadTxRam3
	call SwapTurn
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	push hl
	dec a
	ldtx de, DamageCheckXDamageTimesTailsText
	call Func_68069
	pop hl
	call SwapTurn
	ld e, a
	ld a, [hl]
	dec a
	sub e
	add a
	call ATimes10
	call Func_68175
	ret

DiglettLv15DigUnder_AI:
	ld a, $0a
	call Func_68175
	ret

DiglettLv15DigUnder_RequireSelection:
	call Func_68686
	ret

DiglettLv15DigUnder_AISelection:
	call Func_686be
	ldh [hTemp_ffa0], a
	ret

DiglettLv15DigUnder_BeforeDamage:
	ldh a, [hTemp_ffa0]
	or a
	jr nz, .asm_6b698
	call Func_682a9
	ret c
	ld a, $0a
	call Func_68175
	ret
.asm_6b698
	xor a
	ld [wLoadedAttackAnimation], a
	ret

DiglettLv15DigUnder_AfterDamage:
	ldh a, [hTemp_ffa0]
	or a
	ret z
	call SwapTurn
	ld b, a
	ld de, $a
	call DealDamageToPlayAreaPokemon_RegularAnim
	call SwapTurn
	ret

DarkDugtrioSinkhole_InitialEffect1:
	scf
	ret

DarkDugtrioKnockDown_AI:
	ld a, 30
	lb de, 20, 40
	call Func_680dd
	ret

DarkDugtrioKnockDown_BeforeDamage:
	ld hl, $14
	call LoadTxRam3
	call SwapTurn
	ldtx de, DamageCheckIfTailsPlusDamageText
	call TossCoin_Bank1a
	call SwapTurn
	jr c, .asm_6b6d3
	ld a, $14
	call Func_68163
.asm_6b6d3
	ret

MankeyLv14Mischief_InitialEffect1:
	call SwapTurn
	farcall Func_2435f
	call SwapTurn
	ret

MankeyLv14Mischief_AfterDamage:
	call SwapTurn
	call Func_680a0
	call SwapTurn
	ret

MankeyLv14Anger_AI:
	ld a, 30
	lb de, 20, 40
	call Func_680dd
	ret

MankeyLv14Anger_BeforeDamage:
	ld a, $14
	call Func_682e0
	ret

DarkPrimeapeFrenzy_InitialEffect1:
	scf
	ret

DarkPrimeapeFrenziedAttack_AI:
	ld hl, wTempTurnDuelistCardID
	cphl DARK_PRIMEAPE
	jr nz, .asm_6b716
	ld a, DUELVARS_ARENA_CARD_STATUS
	get_turn_duelist_var
	and $0f
	cp $01
	jr nz, .asm_6b716
	ld a, $1e
	call Func_68163
.asm_6b716
	ret

DarkPrimeapeFrenziedAttack_BeforeDamage:
	call DarkPrimeapeFrenziedAttack_AI
	call SwapTurn
	call Func_68045
	call SwapTurn
	ret

DarkMachokeDragOff_InitialEffect1:
	call Func_6843b
	ret

DarkMachokeDragOff_RequireSelection:
	call SwapTurn
	bank1call HasAlivePokemonInBench
.asm_6b72e
	bank1call OpenPlayAreaScreenForSelection
	jr c, .asm_6b72e
	call SwapTurn
	ldh [hTemp_ffa0], a
	ret

DarkMachokeDragOff_AISelection:
	call Func_6869d
	ldh [hTemp_ffa0], a
	ret

DarkMachokeDragOff_BeforeDamage:
	call SwapTurn
	ldh a, [hTemp_ffa0]
	ld e, a
	bank1call Func_6f49
	jr nc, .asm_6b753
	xor a
	ld [wLoadedAttackAnimation], a
	call Func_6817e
	jr .asm_6b76b
.asm_6b753
	xor a
	ld [wcd0b], a
	call SwapArenaWithBenchPokemon
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call GetCardIDFromDeckIndex
	ld hl, wTempNonTurnDuelistCardID
	ld [hl], e
	inc hl
	ld [hl], d
	ld hl, wLoadedAttackCategory
	res 7, [hl]
.asm_6b76b
	call SwapTurn
	xor a
	ld [wDuelDisplayedScreen], a
	ret

DarkMachokeKnockBack_RequireSelection:
	call HandleMandatorySwitchSelection
	ldh a, [hTempPlayAreaLocation_ff9d]
	ldh [hTemp_ffa0], a
	ret

DarkMachokeKnockBack_AfterDamage:
	ldh a, [hTemp_ffa0]
	call Func_6828a
	ret

DarkMachampFlingAlt_InitialEffect1:
	call Func_6843b
	ret

DarkMachampFlingAlt_AfterDamage:
	call Func_682be
	ret c
	call SwapTurn
	ld e, $00
	bank1call Func_6f49
	call SwapTurn
	ret c
	call SwapTurn
	ld a, DUELVARS_CARD_LOCATIONS
	get_turn_duelist_var
.asm_6b79b
	ld a, [hl]
	cp $10
	jr nz, .asm_6b7a4
	ld a, l
	call ReturnCardToDeck
.asm_6b7a4
	inc l
	ld a, l
	cp $3c
	jr c, .asm_6b79b
	ld l, $bb
	ld a, [hl]
	ld [hl], $ff
	ld l, $c8
	ld [hl], $00
	call LoadCardDataToBuffer1_FromDeckIndex
	ld hl, wLoadedCard1Name
	ld a, [hli]
	ld h, [hl]
	ld l, a
	call LoadTxRam2
	ldtx hl, PokemonAndAllAttachedCardsWereReturnedToDeckText
	call DrawWideTextBox_WaitForInput
	call Func_680a0
	call SwapTurn
	ret

RattataLv12Trickery_InitialEffect2:
	call Func_6844f
	ret c
	farcall Func_2435f
	ret

RattataLv12Trickery_BeforeDamage:
	call Func_68465
	ld a, DUELVARS_DUELIST_TYPE
	get_turn_duelist_var
	cp $01
	jr z, .asm_6b7f2
	and $80
	jr nz, .asm_6b7f7
	call FinishQueuedAnimations
	farcall Func_8cee
	ldh [hTempPlayAreaLocation_ffa1], a
	call SerialSend8Bytes
	jr .asm_6b80d
	ret
.asm_6b7f2
	call SerialRecv8Bytes
	ldh [hTempPlayAreaLocation_ffa1], a
.asm_6b7f7
	call FinishQueuedAnimations
	call SwapTurn
	ldh a, [hTempPlayAreaLocation_ffa1]
	xor $80
	call DrawAIPeekScreen
	call SwapTurn
	ldtx hl, CardTrickeryWasUsedOnText
	call DrawWideTextBox_WaitForInput
.asm_6b80d
	ldh a, [hTempPlayAreaLocation_ffa1]
	and $0f
	add DUELVARS_PRIZE_CARDS
	get_turn_duelist_var
	ldh [hTempCardIndex_ff98], a
	call DrawCardFromDeck
	ld [hl], a
	ld l, a
	ld [hl], $08
	ldh a, [hTempCardIndex_ff98]
	call ReturnCardToDeck
	ret

RattataLv12QuickAttack_AI:
	ld a, 15
	lb de, 10, 20
	call Func_680dd
	ret

RattataLv12QuickAttack_BeforeDamage:
	ld a, $0a
	call Func_682e0
	ret

DarkRaticateHyperFang_AI:
	ld a, 50
	lb de, 0, 50
	call Func_680dd
	ret

DarkRaticateHyperFang_BeforeDamage:
	ldtx de, AttackSuccessCheckText
	call TossCoin_Bank1a
	ret c
	xor a
	ld [wLoadedAttackAnimation], a
	call Func_6817e
	call Func_6809a
	ret

MeowthLv10CoinHurl_InitialEffect1:
	call Func_6808d
	ret

MeowthLv10CoinHurl_AI:
	ld a, $14
	call Func_6817e
	ret

MeowthLv10CoinHurl_RequireSelection:
	ldtx de, DamageCheckIfTailsNoDamageText
	call Func_68079
	ldh [hTemp_ffa0], a
	ret nc
	call SwapTurn
	bank1call HasAlivePokemonInPlayArea
.asm_6b866
	bank1call OpenPlayAreaScreenForSelection
	jr c, .asm_6b866
	call SwapTurn
	ldh [hTempPlayAreaLocation_ffa1], a
	ret

MeowthLv10CoinHurl_AISwitchDefendingPkmn:
	ldtx de, DamageCheckIfTailsNoDamageText
	call Func_68079
	ldh [hTemp_ffa0], a
	ret nc
	call Func_686be
	ldh [hTempPlayAreaLocation_ffa1], a
	ret

MeowthLv10CoinHurl_BeforeDamage:
	ldh a, [hTemp_ffa0]
	or a
	jr nz, .asm_6b88d
	xor a
	ld [wLoadedAttackAnimation], a
	call Func_6809a
	ret
.asm_6b88d
	ldh a, [hTempPlayAreaLocation_ffa1]
	or a
	jr nz, .asm_6b89c
	call Func_682a9
	ret c
	ld a, $14
	call Func_68175
	ret
.asm_6b89c
	xor a
	ld [wLoadedAttackAnimation], a
	ret

MeowthLv10CoinHurl_AfterDamage:
	ldh a, [hTemp_ffa0]
	or a
	ret z
	ldh a, [hTempPlayAreaLocation_ffa1]
	or a
	ret z
	call SwapTurn
	ld b, a
	ld a, $d1
	ld [wLoadedAttackAnimation], a
	ld de, $14
	call DealDamageToPlayAreaPokemon
	call SwapTurn
	ret

DarkPersianLv28Fascinate_InitialEffect1:
	jr Func_6b8c6

DarkPersianLv28Fascinate_RequireSelection:
	jr Func_6b8dc

DarkPersianLv28Fascinate_AISelection:
	jr Func_6b8cd

DarkPersianLv28Fascinate_BeforeDamage:
	jr Func_6b8f6

DarkPersianLv28Fascinate_AfterDamage:
	jr Func_6b901

Func_6b8c6:
	call Func_6808d
	call Func_6843b
	ret

Func_6b8cd:
	ldtx de, AttackSuccessCheckText
	call Func_68079
	ldh [hTemp_ffa0], a
	ret nc
	call Func_6869d
	ldh [hTempPlayAreaLocation_ffa1], a
	ret

Func_6b8dc:
	ldtx de, AttackSuccessCheckText
	call Func_68079
	ldh [hTemp_ffa0], a
	ret nc
	call SwapTurn
	bank1call HasAlivePokemonInBench
.asm_6b8eb
	bank1call OpenPlayAreaScreenForSelection
	jr c, .asm_6b8eb
	call SwapTurn
	ldh [hTempPlayAreaLocation_ffa1], a
	ret

Func_6b8f6:
	ldh a, [hTemp_ffa0]
	or a
	ret nz
	ld [wLoadedAttackAnimation], a
	call Func_6809a
	ret

Func_6b901:
	ldh a, [hTemp_ffa0]
	or a
	ret z
	call SwapTurn
	ldh a, [hTempPlayAreaLocation_ffa1]
	ld e, a
	bank1call Func_6f49
	jr c, .asm_6b916
	ldh a, [hTempPlayAreaLocation_ffa1]
	ld e, a
	call SwapArenaWithBenchPokemon
.asm_6b916
	call SwapTurn
	xor a
	ld [wDuelDisplayedScreen], a
	ret

DarkPersianLv28PoisonClaws_AI:
	ld a, $05
	ld de, $a
	call Func_680b6
	ret

DarkPersianLv28PoisonClaws_BeforeDamage:
	call Func_6800b
	ret

EeveeLv9SandAttack_BeforeDamage:
	ld a, $02
	call Func_6812e
	ret

PorygonLv20Conversion1_InitialEffect1:
	call Func_6aa2e
	ret

PorygonLv20Conversion1_InitialEffect2:
	call Func_6aa44
	ret

PorygonLv20Conversion1_AISelection:
	call Func_6aae2
	ret

PorygonLv20Conversion1_AfterDamage:
	call Func_6aa4f
	ret

PorygonLv20Psybeam_BeforeDamage:
	call Func_6803e
	ret

DratiniLv12Wrap_BeforeDamage:
	call Func_68027
	ret

DarkDragonairEvolutionaryLight_InitialEffect2:
	call Func_6844f
	ret c
	farcall Func_2435f
	ret

DarkDragonairEvolutionaryLight_RequireSelection:
	call CreateDeckCardList
	ldtx hl, ChooseAnEvolutionCardFromDeckText
	ldtx bc, EffectTargetEvolutionCardText
	ld a, CARDSEARCH_EVOLUTION_POKEMON
	farcall Func_24c9d
	jr c, .asm_6b96d
	ldtx hl, ChooseAnEvolutionCardText
	ldtx de, DuelistDeckText
	farcall Func_24df8
.asm_6b96d
	ldh [hTempPlayAreaLocation_ffa1], a
	or a
	ret

DarkDragonairEvolutionaryLight_BeforeDamage:
	call Func_68465
	ldh a, [hTempPlayAreaLocation_ffa1]
	cp $ff
	jr z, .asm_6b98d
	call SearchCardInDeckAndAddToHand
	call AddCardToHand
	call Func_680ab
	jr c, .asm_6b98d
	ldh a, [hTempPlayAreaLocation_ffa1]
	ldtx hl, WasPlacedInTheHandText
	bank1call DisplayCardDetailScreen
.asm_6b98d
	call Func_680a0
	ret

DarkDragonairTailStrike_AI:
	ld a, 30
	lb de, 20, 40
	call Func_680dd
	ret

DarkDragonairTailStrike_BeforeDamage:
	ld a, $14
	call Func_682e0
	ret

DarkDragoniteSummonMinions_InitialEffect1:
	scf
	ret

DarkDragoniteSummonMinions_RequireSelection:
	ld a, $ff
	ldh [hTemp_ffa0], a
	call CreateDeckCardList
	jr c, .asm_6b9cb
	farcall Func_24369
	jr nc, .asm_6b9d2
	call DrawWideTextBox_WaitForInput
	ldtx hl, NoTargetsButCheckDeckPromptText
	call YesOrNoMenuWithText_SetCursorToYes
	ret c
	ld a, $ff
	ld [wcd20], a
	ldtx hl, ChooseBasicPokemonText
	ldtx de, DuelistDeckText
	farcall Func_24df8
	ret
.asm_6b9cb
	ldtx hl, NoCardsLeftInTheDeckText
	call DrawWideTextBox_WaitForInput
	ret
.asm_6b9d2
	ldtx hl, ChooseUpTo2BasicPokemonFromDeckText
	ldtx bc, EffectTargetBasicPokemonText
	ld a, CARDSEARCH_BASIC_POKEMON
	farcall Func_24c9d
	ret c
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	ld a, [wMaxNumPlayAreaPokemon]
	sub [hl]
	cp $03
	jr c, .asm_6b9ec
	ld a, $02
.asm_6b9ec
	ld [wcd1f], a
	xor a
	ldh [hffb2], a
.asm_6b9f2
	bank1call Func_5221
	ldtx hl, ChooseBasicPokemonText
	ldtx de, DuelistDeckText
	bank1call SetCardListHeaderAndInfoText
.asm_6b9fe
	bank1call DisplayCardList
	jr nc, .asm_6ba13
	ld a, [wcd20]
	or a
	jr nz, .asm_6ba2f
	ld a, [wcd1f]
	call Func_6856d
	jr c, .asm_6b9f2
	jr .asm_6ba2f
.asm_6ba13
	ldh a, [hTempCardIndex_ff98]
	farcall ExecuteCardSearchFunc
	jr nc, .asm_6b9fe
	farcall Func_24350
	ldh a, [hTempCardIndex_ff98]
	ld [hl], a
	call RemoveCardFromDuelTempList
	jr c, .asm_6ba2f
	ldh a, [hffb2]
	ld hl, wcd1f
	cp [hl]
	jr c, .asm_6b9f2
.asm_6ba2f
	farcall Func_24350
	ld [hl], $ff
	ret

DarkDragoniteSummonMinions_PkmnPowerTrigger:
	ld hl, hTemp_ffa0
.asm_6ba39
	ld a, [hli]
	ldh [hTempCardIndex_ff98], a
	cp $ff
	jr z, .asm_6ba5c
	push hl
	call SearchCardInDeckAndAddToHand
	call AddCardToHand
	call PutHandPokemonCardInPlayArea
	call Func_680ab
	pop hl
	jr c, .asm_6ba39
	push hl
	ldh a, [hTempCardIndex_ff98]
	ldtx hl, PlacedInArenaText
	bank1call DisplayCardDetailScreen
	pop hl
	jr .asm_6ba39
.asm_6ba5c
	call Func_680a0
	ret

DarkDragoniteGiantTail_AI:
	ld a, 70
	lb de, 0, 70
	call Func_680dd
	ret

DarkDragoniteGiantTail_BeforeDamage:
	ldtx de, AttackSuccessCheckText
	call TossCoin_Bank1a
	ret c
	xor a
	ld [wLoadedAttackAnimation], a
	call Func_6817e
	call Func_6809a
	ret

MagnemiteLv12Magnetism_BeforeDamage:
	ld b, $00
	ld a, DUELVARS_BENCH
	get_turn_duelist_var
.asm_6ba80
	ld a, [hli]
	cp $ff
	jr z, .asm_6ba96
	call LoadCardDataToBuffer2_FromDeckIndex
	ld a, [wLoadedCard2PokedexNumber]
	cp $51
	jr z, .asm_6ba93
	cp $52
	jr nz, .asm_6ba80
.asm_6ba93
	inc b
	jr .asm_6ba80
.asm_6ba96
	ld a, b
	call ATimes10
	call Func_68163
	ret

DarkMagnetonSonicboom_BeforeDamage:
	ld hl, wDamage + 1
	set 7, [hl]
	ret

DarkMagnetonMagneticLines_AISelection:
	ld a, $ff
	ldh [hTemp_ffa0], a
	call Func_6843b
	ret c
	call Func_6bb19
	ret c
	ld a, [wDuelTempList]
	ldh [hTemp_ffa0], a
	call Func_6869d
	ldh [hTempPlayAreaLocation_ffa1], a
	ret

DarkMagnetonMagneticLines_RequireSelection:
	ld a, $ff
	ldh [hTemp_ffa0], a
	call Func_6843b
	ret c
	call Func_6bb19
	ret c
	call SwapTurn
	xor a
	ld de, $51
	bank1call DisplayAttachedEnergyMenu
.asm_6bad1
	bank1call HandleAttachedEnergyMenuInput
	jr c, .asm_6bad1
	ldh a, [hTempCardIndex_ff98]
	ldh [hTemp_ffa0], a
	bank1call HasAlivePokemonInBench
.asm_6badd
	bank1call OpenPlayAreaScreenForSelection
	jr c, .asm_6badd
	ldh [hTempPlayAreaLocation_ffa1], a
	call SwapTurn
	ret

DarkMagnetonMagneticLines_AfterDamage:
	ldh a, [hTemp_ffa0]
	cp $ff
	ret z
	call Func_682be
	ret c
	call SwapTurn
	ldh a, [hTempPlayAreaLocation_ffa1]
	ld e, a
	bank1call Func_6f49
	jr c, .asm_6bb0e
	ldh a, [hTemp_ffa0]
	call AddCardToHand
	call PutHandCardInPlayArea
	call Func_680ab
	jr c, .asm_6bb0e
	ldh a, [hTempPlayAreaLocation_ffa1]
	call Func_680ed
.asm_6bb0e
	call SwapTurn
	ld a, $fd
	call GetNonTurnDuelistVariable
	ld [hl], $01
	ret

Func_6bb19:
	call SwapTurn
	ld c, $10
	ld de, wDuelTempList
	ld a, DUELVARS_CARD_LOCATIONS
	get_turn_duelist_var
.asm_6bb24
	ld a, [hl]
	cp c
	jr nz, .asm_6bb3a
	ld a, l
	call LoadCardDataToBuffer2_FromDeckIndex
	ld a, [wLoadedCard2Type]
	cp $08
	jr c, .asm_6bb3a
	cp $0e
	jr nc, .asm_6bb3a
	ld a, l
	ld [de], a
	inc de
.asm_6bb3a
	inc l
	ld a, l
	cp $3c
	jr c, .asm_6bb24
	ld a, $ff
	ld [de], a
	call SwapTurn
	ld a, [wDuelTempList]
	cp $ff
	jr z, .asm_6bb4f
	or a
	ret
.asm_6bb4f
	scf
	ret

DarkElectrodeEnergyBomb_InitialEffect1:
	ld e, $00
	call GetPlayAreaCardAttachedEnergies
	ld a, [wTotalAttachedEnergies]
	or a
	ret nz
	ld hl, $2e
	scf
	ret

DarkElectrodeEnergyBomb_BeforeDamage:
	call Func_68446
	jr c, .asm_6bbc1
	ld a, DUELVARS_DUELIST_TYPE
	get_turn_duelist_var
	cp $00
	jr z, .asm_6bb88
	cp $01
	jr z, .asm_6bb71
	ret
.asm_6bb71
	bank1call Func_5c30
	bank1call PrintPlayAreaCardList_EnableLCD
	call SerialRecv8Bytes
	ld a, d
	cp $ff
	ret z
	ldh [hTemp_ffa0], a
	ld a, e
	ldh [hTempPlayAreaLocation_ffa1], a
	call DarkElectrodeEnergyBomb_Unk11
	jr .asm_6bb71
.asm_6bb88
	xor a
	call CreateArenaOrBenchEnergyCardList
	jr c, .asm_6bbba
	bank1call InitAndDrawCardListScreenLayout
	ldtx hl, PleaseSelectCardText
	ldtx de, EnergyCardText
	bank1call SetCardListHeaderAndInfoText
.asm_6bb9a
	bank1call DisplayCardList
	jr c, .asm_6bb9a
	ldh [hTemp_ffa0], a
	bank1call HasAlivePokemonInBench
.asm_6bba4
	bank1call OpenPlayAreaScreenForSelection
	jr c, .asm_6bba4
	ldh [hTempPlayAreaLocation_ffa1], a
	ld e, a
	ldh a, [hTemp_ffa0]
	ld d, a
	call SerialSend8Bytes
	call AddCardToHand
	call PutHandCardInPlayArea
	jr .asm_6bb88
.asm_6bbba
	ld de, $ffff
	call SerialSend8Bytes
	ret
.asm_6bbc1
	xor a
	call CreateArenaOrBenchEnergyCardList
	ld hl, wDuelTempList
.asm_6bbc8
	ld a, [hli]
	cp $ff
	jr z, .asm_6bbd2
	call Func_0ffa
	jr .asm_6bbc8
.asm_6bbd2
	xor a
	call Func_680ed
	ret

DarkElectrodeEnergyBomb_Unk11:
	ldh a, [hTempPlayAreaLocation_ffa1]
	ld e, a
	ldh a, [hTemp_ffa0]
	call AddCardToHand
	call PutHandCardInPlayArea
	bank1call PrintPlayAreaCardList_EnableLCD
	ret

DarkJolteonLightningFlash_BeforeDamage:
	ld a, $0c
	call Func_6812e
	ret

DarkJolteonThunderAttack_BeforeDamage:
	ldtx de, ThunderAttackCheckText
	call TossCoin_Bank1a
	ldh [hTemp_ffa0], a
	ret nc
	call Func_6802e
	ret

DarkJolteonThunderAttack_AfterDamage:
	ldh a, [hTemp_ffa0]
	or a
	ret nz
	ld a, $0a
	call DealRecoilDamageToSelf
	ret

BulbasaurLv15PoisonSeed_AI:
	ld a, $0a
	ld de, $a0a
	call Func_680b6
	ret

BulbasaurLv15PoisonSeed_BeforeDamage:
	call Func_68012
	ret

MetapodLv20MysteriousPower_BeforeDamage:
	call Func_6803e
	ret

WeedleLv15PoisonHorn_AI:
	ld a, $0a
	ld de, $a0a
	call Func_680b6
	ret

WeedleLv15PoisonHorn_BeforeDamage:
	call Func_68012
	ret

PikachuLv5Thundershock_BeforeDamage:
	call Func_68027
	ret

NidoranFLv12PoisonSting_AI:
	ld a, $05
	ld de, $a
	call Func_680b6
	ret

NidoranFLv12PoisonSting_BeforeDamage:
	call Func_6800b
	ret

ClefairyLv15ShiningFingers_BeforeDamage:
	call Func_6805c
	ret

ZubatLv12SuspiciousSoundwave_BeforeDamage:
	call Func_6803e
	ret

ParasectLv29ToxicSpore_AI:
	ld a, $14
	ld de, $1414
	call Func_680b6
	ret

ParasectLv29ToxicSpore_BeforeDamage:
	call Func_68012
	ret

PoliwagLv15Bubble_BeforeDamage:
	call Func_68027
	ret

PoliwhirlLv30BodySlam_BeforeDamage:
	call Func_68027
	ret

LickitungLv20LickAlt_BeforeDamage:
	call Func_6801c
	ret

ChanseyLv40Sing_BeforeDamage:
	call Func_6804a
	ret

RaichuLv32SparkingKick_BeforeDamage:
	call Func_68027
	ret

SandshrewLv15PoisonSting_AI:
	ld a, $05
	ld de, $a
	call Func_680b6
	ret

SandshrewLv15PoisonSting_BeforeDamage:
	call Func_6800b
	ret

SeelLv10IceBeam_BeforeDamage:
	call Func_68027
	ret

DewgongLv24AuroraWave_BeforeDamage:
	call Func_6803e
	ret

OnixLv25Bind_BeforeDamage:
	call Func_68027
	ret

KrabbyLv17Bubble_BeforeDamage:
	call Func_68027
	ret

VoltorbLv8Thundershock_BeforeDamage:
	call Func_68027
	ret

HitmonleeLv23RollingKick_BeforeDamage:
	call Func_68027
	ret

JynxLv18IcePunch_BeforeDamage:
	call Func_68027
	ret

JynxLv18ColdBreath_BeforeDamage:
	call Func_68055
	ret

LaprasLv24Sing_BeforeDamage:
	call Func_6804a
	ret

AerodactylLv30Supersonic_BeforeDamage:
	call Func_68033
	ret

ArticunoLv34IceBeam_BeforeDamage:
	call Func_68027
	ret

ArbokLv30Wrap_BeforeDamage:
	call Func_68027
	ret

VenonatLv15Psybeam_BeforeDamage:
	call Func_6803e
	ret

MachokeLv24WickedJab_BeforeDamage:
	call Func_68027
	ret

BellsproutLv10StunSpore_BeforeDamage:
	call Func_68027
	ret

GastlyLv13FadeToBlack_BeforeDamage:
	call Func_6803e
	ret

HaunterLv25EerieLight_BeforeDamage:
	call Func_68033
	ret

DarkPersianAltLv28PoisonClaws_AI:
	ld a, $05
	ld de, $a
	call Func_680b6
	ret

DarkPersianAltLv28PoisonClaws_BeforeDamage:
	call Func_6800b
	ret

KoffingLv14PoisonGas_AI:
	ld a, $05
	ld de, $a
	call Func_680b6
	ret

KoffingLv14PoisonGas_BeforeDamage:
	call Func_6800b
	ret

KoffingLv14ConfusionGas_BeforeDamage:
	call Func_6803e
	ret

ElectabuzzLv30Thundershock_BeforeDamage:
	call Func_68027
	ret

MagmarLv18Smog_AI:
	ld a, $05
	ld de, $a
	call Func_680b6
	ret

MagmarLv18Smog_BeforeDamage:
	call Func_6800b
	ret

WartortleLv24Bubble_BeforeDamage:
	call Func_68027
	ret

Func_6bcdf:
	ld a, DUELVARS_ARENA_CARD_LAST_TURN_DAMAGE
	get_turn_duelist_var
	ld a, [hl]
	ld [wAIMinDamage], a
	ld [wAIMaxDamage], a
	ret

Func_6bcea:
	ld a, DUELVARS_ARENA_CARD_LAST_TURN_DAMAGE
	get_turn_duelist_var
	ld a, [hli]
	or [hl]
	inc hl
	or [hl]
	inc hl
	jr nz, .asm_6bd02
	ld a, [hli]
	or a
	jr nz, .asm_6bd02
	inc hl
	ld a, [hl]
	or a
	jr nz, .asm_6bd02
	ld hl, $d0
	scf
	ret
.asm_6bd02
	ld a, DUELVARS_ARENA_CARD_LAST_TURN_EFFECT
	get_turn_duelist_var
	cp $05
	jr z, .asm_6bd0b
	or a
	ret
.asm_6bd0b
	farcall Func_6521e
	ret

Func_6bd10:
	ld a, $ff
	ldh [hTemp_ffa0], a
	ld a, DUELVARS_ARENA_CARD_LAST_TURN_EFFECT
	get_turn_duelist_var
	or a
	ret z
	cp $02
	jr z, .asm_6bd23
	cp $05
	jr z, .asm_6bd27
	or a
	ret
.asm_6bd23
	call Func_690c3
	ret
.asm_6bd27
	farcall Func_65233
	ret

Func_6bd2c:
	ld a, DUELVARS_ARENA_CARD_LAST_TURN_EFFECT
	get_turn_duelist_var
	or a
	ret z
	cp $01
	jr z, .asm_6bd3e
	cp $05
	jr z, .asm_6bd42
	cp $06
	jr z, .asm_6bd47
	ret
.asm_6bd3e
	call Func_6a87d
	ret
.asm_6bd42
	farcall Func_65237
	ret
.asm_6bd47
	call Func_6b189
	ret

Func_6bd4b:
	ld a, $ff
	ldh [hTemp_ffa0], a
	ld a, DUELVARS_ARENA_CARD_LAST_TURN_EFFECT
	get_turn_duelist_var
	or a
	ret z
	cp $01
	jr z, .asm_6bd65
	cp $02
	jr z, .asm_6bd69
	cp $05
	jr z, .asm_6bd6d
	cp $06
	jr z, .asm_6bd72
	ret
.asm_6bd65
	call Func_6a877
	ret
.asm_6bd69
	call Func_68633
	ret
.asm_6bd6d
	farcall Func_65297
	ret
.asm_6bd72
	call Func_6b18d
	ret

Func_6bd76:
	ld a, DUELVARS_ARENA_CARD_LAST_TURN_EFFECT
	get_turn_duelist_var
	or a
	ret z
	cp $05
	jr z, .asm_6bd80
	ret
.asm_6bd80
	farcall Func_652d9
	ret

Func_6bd85:
	ld a, DUELVARS_ARENA_CARD_LAST_TURN_EFFECT
	get_turn_duelist_var
	cp $02
	jr z, .asm_6bdcd
	cp $03
	jr z, .asm_6bdd4
	cp $04
	jr z, .asm_6bdd9
	cp $05
	jr z, .asm_6bdde
	cp $06
	jr z, .asm_6bde3
	ld a, DUELVARS_ARENA_CARD_LAST_TURN_DAMAGE
	get_turn_duelist_var
	ld de, wDamage
	ld a, [hli]
	ld [de], a
	inc de
	ld a, [hld]
	ld [de], a
	or [hl]
	jr z, .asm_6bdaf
	ld a, $01
	ld [wLoadedAttackAnimation], a
.asm_6bdaf
	inc hl
	inc hl
	push hl
	ld a, $ec
	call GetNonTurnDuelistVariable
	ld e, l
	ld d, h
	pop hl
	ld a, [hli]
	or a
	jr z, .asm_6bdc5
	push hl
	push de
	call Func_6be91
	pop de
	pop hl
.asm_6bdc5
	ld e, $ee
	ld a, [hli]
	ld [de], a
	ld e, $fb
	ld [de], a
	ret
.asm_6bdcd
	ld a, DUELVARS_ARENA_CARD_LAST_TURN_SUBSTATUS2
	get_turn_duelist_var
	call Func_690d2
	ret
.asm_6bdd4
	farcall Func_656bd
	ret
.asm_6bdd9
	farcall Func_64cb6
	ret
.asm_6bdde
	farcall Func_65307
	ret
.asm_6bde3
	call Func_6b193
	ret

Func_6bde7:
	ld a, [wNoDamageOrEffect]
	or a
	ret nz
	ld a, DUELVARS_ARENA_CARD_LAST_TURN_EFFECT
	get_turn_duelist_var
	cp $01
	jr z, .asm_6be11
	cp $05
	jr z, .asm_6be16
	cp $06
	jr z, .asm_6be1c
	cp $07
	jr z, .asm_6be27
	cp $08
	jr z, .asm_6be2d
	cp $09
	jr z, .asm_6be33
	cp $04
	jr z, .asm_6be38
	cp $03
	jr z, .asm_6be3e
	jr .asm_6be44
.asm_6be11
	call Func_6a8a5
	jr .asm_6be44
.asm_6be16
	farcall Func_65323
	jr .asm_6be44
.asm_6be1c
	ld a, DUELVARS_ARENA_CARD_LAST_TURN_DAMAGE
	get_turn_duelist_var
	ld e, [hl]
	inc hl
	ld d, [hl]
	call Func_6b1a1
	jr .asm_6be44
.asm_6be27
	farcall Func_65398
	jr .asm_6be44
.asm_6be2d
	farcall Func_66a2e
	jr .asm_6be44
.asm_6be33
	call Func_6be45
	jr .asm_6be44
.asm_6be38
	farcall Func_64cce
	jr .asm_6be44
.asm_6be3e
	farcall Func_656e4
	jr .asm_6be44
.asm_6be44
	ret

Func_6be45:
	ld a, DUELVARS_ARENA_CARD_LAST_TURN_CHANGE_WEAK
	get_turn_duelist_var
	push hl
	call SwapTurn
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call LoadCardDataToBuffer2_FromDeckIndex
	call SwapTurn
	pop hl
	ld a, [wLoadedCard2Weakness]
	or a
	ret z
	ld c, [hl]
	ld a, $ef
	call GetNonTurnDuelistVariable
	ld [hl], c
	ld l, $fc
	ld [hl], c
	ld l, $fd
	ld [hl], $09
	ld l, $fb
	ld [hl], $08
	ld l, $ee
	ld [hl], $08
	ld a, c
	ld c, $ff
.asm_6be74
	inc c
	rla
	jr nc, .asm_6be74
	ld a, c
	call SwapTurn
	push af
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call LoadCardDataToBuffer1_FromDeckIndex
	pop af
	call Func_68708
	ldtx hl, ChangedTheWeaknessOfPokemonToColorText
	call DrawWideTextBox_PrintText
	call SwapTurn
	ret

Func_6be91:
	ld c, a
	and $f0
	jr z, .asm_6bea6
	ld b, a
	cp $c0
	push bc
	call z, Func_68017
	pop bc
	ld a, b
	cp $80
	push bc
	call z, Func_68012
	pop bc
.asm_6bea6
	ld a, c
	and $0f
	ret z
	cp $01
	jp z, Func_68045
	cp $02
	jp z, Func_6805c
	cp $03
	jp z, Func_6802e
	ret
