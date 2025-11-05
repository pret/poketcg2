SECTION "Bank 1a@400b", ROMX[$400b], BANK[$1a]

Func_6800b:
	ld de, $ff
	call TossCoin_Bank1a
	ret nc

Func_68012:
	ld bc, $f80
	jr Func_68061

Func_68017:
	ld bc, $fc0
	jr Func_68061

Func_6801c:
	ld de, $fd
	call TossCoin_Bank1a
	jr c, Func_6802e
	jp Func_68094

Func_68027:
	ld de, $fd
	call TossCoin_Bank1a
	ret nc

Func_6802e:
	ld bc, $f003
	jr Func_68061

Func_68033:
	ld de, $102
	call TossCoin_Bank1a
	jr c, Func_68045
	jp Func_68094

Func_6803e:
	ld de, $102
	call TossCoin_Bank1a
	ret nc

Func_68045:
	ld bc, $f001
	jr Func_68061

Func_6804a:
	ld de, $fe
	call TossCoin_Bank1a
	jr c, Func_6805c
	jp Func_68094

Func_68055:
	ld de, $fe
	call TossCoin_Bank1a
	ret nc

Func_6805c:
	ld bc, $f002
	jr Func_68061

Func_68061:
	bank1call Func_6470
	ret
; 0x68065

TossCoin_Bank1a:
	call TossCoin
	ret
; 0x68069

Func_68069:
	call TossCoinATimes
	ret
	ret
; 0x6806e

Func_6806e:
	ld a, $01
	ld [wIsDamageToSelf], a
	ret
; 0x68074

Func_68074:
	xor a
	ld [wIsDamageToSelf], a
	ret
; 0x68079

; input:
; - de = text ID

Func_68079:
	ld a, 1
;	fallthrough

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
; 0x6808d

Func_6808d:
	ld a, $01
	ld [wcd0d], a
	or a
	ret
; 0x68094

Func_68094:
	ld a, $01
	ld [wEffectFailed], a
	ret
; 0x6809a

Func_6809a:
	ld a, $02
	ld [wEffectFailed], a
	ret
; 0x680a0

Func_680a0:
	call ExchangeRNG
	farcall Func_24958
	bank1call ShuffleDeck
	ret
; 0x680ab

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
; 0x680b6

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
; 0x680dd

Func_680dd:
	ld [wDamage], a
	xor a
	ld [$ccca], a
	ld a, d
	ld [wAIMinDamage], a
	ld a, e
	ld [wAIMaxDamage], a
	ret
; 0x680ed

Func_680ed:
	ldh [hTempPlayAreaLocation_ff9d], a
	bank1call Func_5c30
	bank1call PrintPlayAreaCardList_EnableLCD
	bank1call Func_5c23
	ret
; 0x680f9

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
; 0x6810e

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
; 0x68127

Func_68127:
	push af
	ld a, DUELVARS_ARENA_CARD_SUBSTATUS1
	get_turn_duelist_var
	pop af
	ld [hli], a
	ret
; 0x6812e

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
; 0x68163

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
; 0x68175

Func_68175:
	call Func_6817e
	ld hl, $ccca
	set 7, [hl]
	ret
; 0x6817e

Func_6817e:
	ld [wDamage], a
	ld [wAIMinDamage], a
	ld [wAIMaxDamage], a
	xor a
	ld [$ccca], a
	ret
; 0x6818c

Func_6818c:
	ld a, [wDamage]
	ld [wAIMinDamage], a
	ld [wAIMaxDamage], a
	ret
; 0x68196

Func_68196:
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	call Random
	or a
	ret nz
	ld hl, wLoadedAttackCategory
	res 7, [hl]
	ret
; 0x681a4

Func_681a4:
	call SwapTurn
	xor a
	call CreateArenaOrBenchEnergyCardList
	call SwapTurn
	ret
; 0x681af

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
	ld [$ce01], a
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
	ld [$ce01], a
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
	ld hl, $ce01
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
; 0x6822e

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
; 0x68262

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
	ld hl, $20b
	call DrawWideTextBox_WaitForInput
	pop de
	ret
; 0x6828a

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
; 0x682a9

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
; 0x682be

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
; 0x682e0

Func_682e0:
	ld l, a
	ld h, $00
	push hl
	call LoadTxRam3
	ld de, $112
	call TossCoin_Bank1a
	pop hl
	ret nc
	ld a, l
	call Func_68163
	ret
; 0x682f4

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
; 0x68335

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
; 0x68346

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
; 0x6837a

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
; 0x683b4

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
; 0x683e8

SECTION "Bank 1a@43ec", ROMX[$43ec], BANK[$1a]

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
; 0x6843b

Func_6843b:
	ld a, $f5
	call GetNonTurnDuelistVariable
	ld hl, $c0
	cp $02
	ret
; 0x68446

Func_68446:
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	ld hl, $c0
	cp $02
	ret
; 0x6844f

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
; 0x68465

Func_68465:
	ldh a, [hTemp_ffa0]
	add DUELVARS_ARENA_CARD_FLAGS
	get_turn_duelist_var
	set 5, [hl]
	ret
; 0x6846d

Func_6846d:
	call Func_68127
	ld a, DUELVARS_ARENA_CARD_SUBSTATUS3
	get_turn_duelist_var
	set 4, [hl]
	res 5, [hl]
	ret
; 0x68478

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
; 0x68486

Func_68486:
	bank1call DrawDuelMainScene
	call SwapTurn
	xor a
	ldh [$ffb2], a
.asm_6848f
	bank1call PrintAndLoadAttacksToDuelTempList
	push af
	ldh a, [$ffb2]
	ld hl, $44e7
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
	ldh [$ffb2], a
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call LoadCardDataToBuffer1_FromDeckIndex
	bank1call OpenAttackPage
	call SwapTurn
	bank1call DrawDuelMainScene
	call SwapTurn
	jr .asm_6848f
; 0x684e7

SECTION "Bank 1a@44ef", ROMX[$44ef], BANK[$1a]

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
; 0x68501

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
; 0x68525

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
; 0x68556

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
; 0x6856d

Func_6856d:
	ld hl, $ffb2
	sub [hl]
	ld l, a
	ld h, $00
	call LoadTxRam3
	ld hl, $20d
	call YesOrNoMenuWithText
	ret
; 0x6857e

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
; 0x685dd

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
	ld a, [$cc2f]
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
; 0x68633

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
; 0x68665

Func_68665:
	ld a, $ff
	ldh [hTemp_ffa0], a
	call Func_6843b
	ret c
	ld hl, $170
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
; 0x68686

Func_68686:
	ld hl, $171
	call DrawWideTextBox_WaitForInput
	call SwapTurn
	bank1call HasAlivePokemonInPlayArea
.asm_68692
	bank1call OpenPlayAreaScreenForSelection
	jr c, .asm_68692
	call SwapTurn
	ldh [hTemp_ffa0], a
	ret
; 0x6869d

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
; 0x686be

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
; 0x68708

Func_68708:
	add a
	ld e, a
	ld d, $00
	ld hl, $4723
	add hl, de
	ld de, wTxRam2
	ld a, [wLoadedCard1Name]
	ld [de], a
	inc de
	ld a, [$cc36]
	ld [de], a
	inc de
	ld a, [hli]
	ld [de], a
	inc de
	ld a, [hli]
	ld [de], a
	ret
; 0x68723

SECTION "Bank 1a@472f", ROMX[$472f], BANK[$1a]

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
; 0x6873c

SECTION "Bank 1a@4753", ROMX[$4753], BANK[$1a]

Func_68753:
	ld a, $05
	ld de, $a
	call Func_680dd
	ret
; 0x6875c

Func_6875c:
	ld de, $ff
	call TossCoin_Bank1a
	jp c, Func_68012
	ld a, $8c
	ld [wLoadedAttackAnimation], a
	call Func_68094
	ret
; 0x6876e

Func_6876e:
	call Func_68027
	ret
; 0x68772

Func_68772:
	call Func_6808d
	ret
; 0x68776

Func_68776:
	xor a
	ldh [hTemp_ffa0], a
	call Func_6843b
	ret c
	ld de, $10a
	call Func_68079
	ldh [hTemp_ffa0], a
	ret nc
	call HandleMandatorySwitchSelection
	ldh a, [hTempPlayAreaLocation_ff9d]
	ldh [hTempPlayAreaLocation_ffa1], a
	ret
; 0x6878e

Func_6878e:
	ldh a, [hTemp_ffa0]
	or a
	ret z
	ldh a, [hTempPlayAreaLocation_ffa1]
	call Func_6828a
	ret
; 0x68798

Func_68798:
	ld a, $0a
	ld de, $a0a
	call Func_680b6
	ret
; 0x687a1

Func_687a1:
	call Func_68012
	ret
; 0x687a5

Func_687a5:
	ld a, $05
	ld de, $a
	call Func_680b6
	ret
; 0x687ae

Func_687ae:
	call Func_6800b
	ret
; 0x687b2

Func_687b2:
	call Func_6843b
	ret
; 0x687b6

Func_687b6:
	ld hl, $164
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
; 0x687cf

Func_687cf:
	call Func_6869d
	ldh [hTemp_ffa0], a
	ret
; 0x687d5

Func_687d5:
	call SwapTurn
	ldh a, [hTemp_ffa0]
	ld e, a
	bank1call Func_6f49
	call nc, SwapArenaWithBenchPokemon
	call SwapTurn
	xor a
	ld [wDuelDisplayedScreen], a
	ret
; 0x687e9

Func_687e9:
	ld de, $115
	call TossCoin_Bank1a
	ret nc
	ld a, $09
	call Func_6812e
	ret
; 0x687f6

Func_687f6:
	call Func_68027
	ret
; 0x687fa

Func_687fa:
	call Func_68027
	ret
; 0x687fe

Func_687fe:
	ld a, $0a
	ld de, $a0a
	call Func_680b6
	ret
; 0x68807

Func_68807:
	call Func_68012
	ret
; 0x6880b

Func_6880b:
	call Func_68045
	call SwapTurn
	call Func_68045
	call SwapTurn
	ret
; 0x68818

Func_68818:
	ld de, $110
	call TossCoin_Bank1a
	jp nc, Func_6809a
	ld a, $4f
	ld [wLoadedAttackAnimation], a
	ld a, $14
	call Func_68127
	ret
; 0x6882c

Func_6882c:
	ld a, $05
	ld de, $a
	call Func_680b6
	ret
; 0x68835

Func_68835:
	call Func_6800b
	ret
; 0x68839

Func_68839:
	ld hl, wDealtDamage
	ld e, [hl]
	inc hl
	ld d, [hl]
	call ApplyAndAnimateHPRecovery
	ret
; 0x68843

Func_68843:
	call Func_68027
	ret
; 0x68847

Func_68847:
	ld hl, wDealtDamage
	ld e, [hl]
	inc hl
	ld d, [hl]
	call ApplyAndAnimateHPRecovery
	ret
; 0x68851

Func_68851:
	ld a, $1e
	call Func_6810e
	ret
; 0x68857

Func_68857:
	call Func_68033
	ret
; 0x6885b

Func_6885b:
	ld hl, wDealtDamage
	ld e, [hl]
	inc hl
	ld d, [hl]
	call ApplyAndAnimateHPRecovery
	ret
; 0x68865

Func_68865:
	ld a, $1e
	ld de, $3c
	call Func_680dd
	ret
; 0x6886e

Func_6886e:
	ld hl, $1e
	call LoadTxRam3
	ld de, $113
	ld a, $02
	call Func_68069
	ld e, a
	add a
	add e
	call ATimes10
	call Func_6817e
	ret
; 0x68886

Func_68886:
	ld a, $05
	ld de, $a
	call Func_680b6
	ret
; 0x6888f

Func_6888f:
	call Func_6800b
	ret
; 0x68893

Func_68893:
	call Func_6805c
	ret
; 0x68897

Func_68897:
	ld hl, wDealtDamage
	ld a, [hli]
	or [hl]
	ret z
	ld de, $a
	call ApplyAndAnimateHPRecovery
	ret
; 0x688a4

Func_688a4:
	ld a, $05
	ld de, $a
	jp Func_680cb
; 0x688ac

Func_688ac:
	ld de, $11a
	call TossCoin_Bank1a
	jp c, Func_68012
	jp Func_68045
; 0x688b8

Func_688b8:
	ld de, $110
	call TossCoin_Bank1a
	jp nc, Func_6809a
	ld a, $4f
	ld [wLoadedAttackAnimation], a
	ld a, $14
	call Func_68127
	ret
; 0x688cc

Func_688cc:
	call Func_68027
	ret
; 0x688d0

Func_688d0:
	call Func_68027
	ret
; 0x688d4

Func_688d4:
	farcall Func_2435f
	ret c
	farcall Func_24369
	ret
; 0x688de

Func_688de:
	call CreateDeckCardList
	ld hl, $17d
	ld bc, $197
	ld de, $2b
	ld a, $05
	farcall Func_24c9d
	jr c, .asm_688fc
	ld hl, $17e
	ld de, $b0
	farcall Func_24df8
.asm_688fc
	ldh [hTemp_ffa0], a
	ret
; 0x688ff

Func_688ff:
	ld de, $2b
	ld a, $05
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
; 0x6891b

Func_6891b:
	ldh a, [hTemp_ffa0]
	cp $ff
	jr z, .asm_68937
	call SearchCardInDeckAndAddToHand
	call AddCardToHand
	call PutHandPokemonCardInPlayArea
	call Func_680ab
	jr c, .asm_68937
	ldh a, [hTemp_ffa0]
	ld hl, $63
	bank1call DisplayCardDetailScreen
.asm_68937
	call Func_680a0
	ret
; 0x6893b

Func_6893b:
	call Func_68446
	ret
; 0x6893f

Func_6893f:
	ld hl, $164
	call DrawWideTextBox_WaitForInput
	bank1call HasAlivePokemonInBench
.asm_68948
	bank1call OpenPlayAreaScreenForSelection
	jr c, .asm_68948
	ldh a, [hTempPlayAreaLocation_ff9d]
	ldh [hTemp_ffa0], a
	ret
; 0x68952

Func_68952:
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	call Random
	ldh [hTemp_ffa0], a
	ret
; 0x6895b

Func_6895b:
	ldh a, [hTemp_ffa0]
	ld e, a
	call SwapArenaWithBenchPokemon
	xor a
	ld [wDuelDisplayedScreen], a
	ret
; 0x68966

Func_68966:
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
; 0x68985

Func_68985:
	ld e, $00
	call GetPlayAreaCardAttachedEnergies
	ld hl, $14
	call LoadTxRam3
	ld a, [wTotalAttachedEnergies]
	ld de, $113
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
	ld [$ccca], a
	ret
; 0x689ac

Func_689ac:
	ld a, $23
	ld de, LoadSymbolsFont
	call Func_680dd
	ret
; 0x689b5

Func_689b5:
	ld de, $108
	call TossCoin_Bank1a
	ldh [hTemp_ffa0], a
	ret nc
	ld a, $0a
	call Func_68163
	ret
; 0x689c4

Func_689c4:
	ldh a, [hTemp_ffa0]
	or a
	ret nz
	ld a, $0a
	call DealRecoilDamageToSelf
	ret
; 0x689ce

Func_689ce:
	ld a, $14
	ld de, $1414
	jp Func_680cb
; 0x689d6

Func_689d6:
	call Func_68017
	ret
; 0x689da

Func_689da:
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
; 0x689fe

Func_689fe:
	ld a, $0f
	ld de, $1e
	call Func_680dd
	ret
; 0x68a07

Func_68a07:
	ld hl, $a
	call LoadTxRam3
	ld de, $113
	ld a, $03
	call Func_68069
	call ATimes10
	call Func_6817e
	ret
; 0x68a1c

Func_68a1c:
	farcall Func_2435f
	ret c
	farcall Func_24369
	ret
; 0x68a26

Func_68a26:
	call CreateDeckCardList
	ld hl, $181
	ld bc, $196
	ld a, $01
	farcall Func_24c9d
	jr c, .asm_68a41
	ld hl, $182
	ld de, $b0
	farcall Func_24df8
.asm_68a41
	ldh [hTemp_ffa0], a
	ret
; 0x68a44

Func_68a44:
	ld a, $01
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
; 0x68a5d

Func_68a5d:
	ldh a, [hTemp_ffa0]
	cp $ff
	jr z, .asm_68a79
	call SearchCardInDeckAndAddToHand
	call AddCardToHand
	call PutHandPokemonCardInPlayArea
	call Func_680ab
	jr c, .asm_68a79
	ldh a, [hTemp_ffa0]
	ld hl, $63
	bank1call DisplayCardDetailScreen
.asm_68a79
	call Func_680a0
	ret
; 0x68a7d

Func_68a7d:
	ld a, $1e
	ld de, $1e
	call Func_680dd
	ret
; 0x68a86

Func_68a86:
	ld de, $105
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
; 0x68a9c

Func_68a9c:
	call Func_68033
	ret
; 0x68aa0

Func_68aa0:
	ld a, $1e
	ld de, $3c
	call Func_680dd
	ret
; 0x68aa9

Func_68aa9:
	ld hl, $1e
	call LoadTxRam3
	ld de, $113
	ld a, $02
	call Func_68069
	ld e, a
	add a
	add e
	call ATimes10
	call Func_6817e
	ret
; 0x68ac1

Func_68ac1:
	ld a, $1e
	ld de, $3c
	call Func_680dd
	ret
; 0x68aca

Func_68aca:
	ld hl, $1e
	call LoadTxRam3
	ld de, $113
	ld a, $02
	call Func_68069
	ld e, a
	add a
	add e
	call ATimes10
	call Func_6817e
	ret
; 0x68ae2

Func_68ae2:
	call HandleMandatorySwitchSelection
	ldh a, [hTempPlayAreaLocation_ff9d]
	ldh [hTemp_ffa0], a
	ret
; 0x68aea

Func_68aea:
	ldh a, [hTemp_ffa0]
	call Func_6828a
	ret
; 0x68af0

Func_68af0:
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
; 0x68b08

Func_68b08:
	call Func_6805c
	ret
; 0x68b0c

Func_68b0c:
	call Func_6805c
	ret
; 0x68b10

Func_68b10:
	ld a, $05
	ld de, $a
	call Func_680b6
	ret
; 0x68b19

Func_68b19:
	call Func_6800b
	ret
; 0x68b1d

Func_68b1d:
	ld a, $0a
	ld de, $a0a
	call Func_680b6
	ret
; 0x68b26

Func_68b26:
	call Func_68012
	ret
; 0x68b2a

Func_68b2a:
	ld hl, wDealtDamage
	ld a, [hli]
	or [hl]
	ret z
	ld de, $a
	call ApplyAndAnimateHPRecovery
	ret
; 0x68b37

Func_68b37:
	jr Func_68b40

Func_68b39:
	jr Func_68b79

Func_68b3b:
	jr Func_68b81

Func_68b3d:
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
	ld hl, $184
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
	ldh [$ffb2], a
	bank1call Func_5c30
.asm_68b95
	bank1call PrintPlayAreaCardList_EnableLCD
	push af
	ldh a, [$ffb2]
	ld hl, $4743
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
	ldh [$ffb2], a
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
	ldh [$ffb2], a
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
; 0x68c14

Func_68c14:
	ldh a, [hAIEnergyTransPlayAreaLocation]
	ld e, a
	ldh a, [hTempRetreatCostCards]
	call AddCardToHand
	call PutHandCardInPlayArea
	bank1call PrintPlayAreaCardList_EnableLCD
	ret
; 0x68c23

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
; 0x68c52

Func_68c52:
	jp Func_68b40
; 0x68c55

Func_68c55:
	jp Func_68b79
; 0x68c58

Func_68c58:
	jp Func_68b81
; 0x68c5b

Func_68c5b:
	jr Func_68c14
; 0x68c5d

Func_68c5d:
	call Func_68027
	ret
; 0x68c61

Func_68c61:
	ld a, $18
	call Func_68127
	ret
; 0x68c67

Func_68c67:
	scf
	ret
; 0x68c69

Func_68c69:
	ld a, $05
	ld de, $a
	call Func_680b6
	ret
; 0x68c72

Func_68c72:
	call Func_6800b
	ret
; 0x68c76

Func_68c76:
	farcall Func_2435f
	ret c
	farcall Func_24369
	ret
; 0x68c80

Func_68c80:
	call CreateDeckCardList
	ld hl, $185
	ld bc, $198
	ld de, $45
	ld a, $05
	farcall Func_24c9d
	jr c, .asm_68c9e
	ld hl, $186
	ld de, $b0
	farcall Func_24df8
.asm_68c9e
	ldh [hTemp_ffa0], a
	ret
; 0x68ca1

Func_68ca1:
	ld de, $45
	ld a, $05
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
; 0x68cbd

Func_68cbd:
	ldh a, [hTemp_ffa0]
	cp $ff
	jr z, .asm_68cd9
	call SearchCardInDeckAndAddToHand
	call AddCardToHand
	call PutHandPokemonCardInPlayArea
	call Func_680ab
	jr c, .asm_68cd9
	ldh a, [hTemp_ffa0]
	ld hl, $63
	bank1call DisplayCardDetailScreen
.asm_68cd9
	call Func_680a0
	ret
; 0x68cdd

Func_68cdd:
	ld a, $05
	ld de, $a
	call Func_680b6
	ret
; 0x68ce6

Func_68ce6:
	call Func_6800b
	ret
; 0x68cea

Func_68cea:
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
; 0x68d06

Func_68d06:
	jp Func_6844f
; 0x68d09

Func_68d09:
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
	ld hl, $46
	call DrawWideTextBox_WaitForInput
	jr .asm_68d09
; 0x68d2d

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
; 0x68d44

Func_68d44:
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
	ld hl, $16c
	call DrawWideTextBox_WaitForInput
	ret
; 0x68d63

Func_68d63:
	ld a, $05
	ld de, $a
	jp Func_680cb
; 0x68d6b

Func_68d6b:
	ld de, $103
	call TossCoin_Bank1a
	ret nc
	call Func_68012
	call Func_68045
	ret c
	ld a, $81
	ld [wNoEffectFromWhichStatus], a
	ret
; 0x68d7f

Func_68d7f:
	call Func_68027
	ret
; 0x68d83

Func_68d83:
	ld a, $05
	ld de, $a
	call Func_680b6
	ret
; 0x68d8c

Func_68d8c:
	call Func_68012
	ret
; 0x68d90

Func_68d90:
	call Func_6844f
	ret c
	call Func_68335
	ld hl, $b5
	ret
; 0x68d9b

Func_68d9b:
	ld de, $10b
	call TossCoin_Bank1a
	ldh [hTempPlayAreaLocation_ffa1], a
	jr nc, .asm_68ddb
	ld a, DUELVARS_DUELIST_TYPE
	get_turn_duelist_var
	cp $01
	jr z, .asm_68dd0
	and $80
	jr nz, .asm_68ddb
	ld hl, $187
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
; 0x68df3

Func_68df3:
	ld a, $3c
	ld de, $78
	call Func_680dd
	ret
; 0x68dfc

Func_68dfc:
	ld hl, $28
	call LoadTxRam3
	ld de, $113
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
; 0x68e1c

Func_68e1c:
	call Func_68027
	ret
; 0x68e20

Func_68e20:
	ld a, $0a
	ld de, $a0a
	call Func_680b6
	ret
; 0x68e29

Func_68e29:
	call Func_68012
	ret
; 0x68e2d

Func_68e2d:
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
; 0x68e44

Func_68e44:
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
; 0x68e70

Func_68e70:
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
; 0x68e88

Func_68e88:
	call Func_68e97
	call Func_68ec8
	ret
; 0x68e8f

Func_68e8f:
	call Func_68e97
	add a
	call Func_68ec8
	ret
; 0x68e97

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
	ld a, [$cc30]
	ld hl, $cc2c
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
; 0x68ec8

Func_68ec8:
	call ATimes10
	call Func_68163
	ld a, [wDamage]
	ld [wAIMinDamage], a
	ld [wAIMaxDamage], a
	ret
; 0x68ed8

Func_68ed8:
	ld bc, $101
	jr Func_68e88
; 0x68edd

Func_68edd:
	ld a, $1e
	ld de, $3c
	call Func_680dd
	ret
; 0x68ee6

Func_68ee6:
	ld hl, $1e
	call LoadTxRam3
	ld a, $02
	ld de, $113
	call Func_68069
	ld e, a
	add a
	add e
	call ATimes10
	call Func_6817e
	ret
; 0x68efe

Func_68efe:
	ldh a, [hTempPlayAreaLocation_ff9d]
	ldh [hTemp_ffa0], a
	ldh a, [hTempPlayAreaLocation_ff9d]
	bank1call CheckIsIncapableOfUsingPkmnPower
	ret
; 0x68f08

Func_68f08:
	call Func_680ab
	ret nc
	bank1call Func_43d9
	ret
; 0x68f10

Func_68f10:
	ld bc, $100
	jp Func_68e88
; 0x68f16

Func_68f16:
	ld de, $110
	call TossCoin_Bank1a
	jp nc, Func_6809a
	ld a, $4f
	ld [wLoadedAttackAnimation], a
	ld a, $15
	call Func_68127
	ret
; 0x68f2a

Func_68f2a:
	scf
	ret
; 0x68f2c

Func_68f2c:
	ld bc, $300
	jp Func_68e88
; 0x68f32

Func_68f32:
	scf
	ret
; 0x68f34

Func_68f34:
	jr Func_68f2c
; 0x68f36

Func_68f36:
	call Func_68027
	ret
; 0x68f3a

Func_68f3a:
	ldh a, [hTempPlayAreaLocation_ff9d]
	jr Func_68f3f

Func_68f3e:
	xor a
;	fallthrough

Func_68f3f:
	ld e, a
	call GetCardDamageAndMaxHP
	call Func_6817e
	ret
; 0x68f47

Func_68f47:
	farcall Func_2435f
	ret c
	farcall Func_24369
	ret
; 0x68f51

Func_68f51:
	call CreateDeckCardList
	ld hl, $179
	ld bc, $199
	ld de, $62
	ld a, $05
	farcall Func_24c9d
	jr c, .asm_68f6f
	ld hl, $17f
	ld de, $b0
	farcall Func_24df8
.asm_68f6f
	ldh [hTemp_ffa0], a
	ret
; 0x68f72

Func_68f72:
	ld de, $62
	ld a, $05
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
; 0x68f8e

Func_68f8e:
	ldh a, [hTemp_ffa0]
	cp $ff
	jr z, .asm_68faa
	call SearchCardInDeckAndAddToHand
	call AddCardToHand
	call PutHandPokemonCardInPlayArea
	call Func_680ab
	jr c, .asm_68faa
	ldh a, [hTemp_ffa0]
	ld hl, $63
	bank1call DisplayCardDetailScreen
.asm_68faa
	call Func_680a0
	ret
; 0x68fae

Func_68fae:
	ldh a, [hTempPlayAreaLocation_ff9d]
	jr Func_68fb3

Func_68fb2:
	xor a
;	fallthrough

Func_68fb3:
	ld e, a
	call GetCardDamageAndMaxHP
	call Func_6817e
	ret
; 0x68fbb

Func_68fbb:
	ld a, $f1
	call GetNonTurnDuelistVariable
	set 2, [hl]
	ret
; 0x68fc3

Func_68fc3:
	ld a, $0f
	ld de, $1e
	call Func_680dd
	ret
; 0x68fcc

Func_68fcc:
	ld hl, $a
	call LoadTxRam3
	ld de, $113
	ld a, $03
	call Func_68069
	call ATimes10
	call Func_6817e
	ret
; 0x68fe1

Func_68fe1:
	call Func_68027
	ret
; 0x68fe5

Func_68fe5:
	jp Func_6a87d
; 0x68fe8

Func_68fe8:
	jp Func_6a877
; 0x68feb

Func_68feb:
	jp Func_6a8a5
; 0x68fee

Func_68fee:
	ld bc, $101
	jp Func_68e88
; 0x68ff4

Func_68ff4:
	ld de, $11b
	call TossCoin_Bank1a
	ret nc
	ld a, $52
	ld [wLoadedAttackAnimation], a
	ld a, $11
	call Func_68127
	ret
; 0x69006

Func_69006:
	call Func_68033
	ret
; 0x6900a

Func_6900a:
	ld de, $110
	call TossCoin_Bank1a
	jp nc, Func_6809a
	ld a, $4f
	ld [wLoadedAttackAnimation], a
	ld a, $16
	call Func_68127
	ret
; 0x6901e

Func_6901e:
	ld a, $14
	ld de, $a1e
	call Func_680dd
	ret
; 0x69027

Func_69027:
	ld a, $14
	call Func_682e0
	ret
; 0x6902d

Func_6902d:
	ld bc, $201
	jp Func_68e88
; 0x69033

Func_69033:
	call Func_68027
	ret
; 0x69037

Func_69037:
	ld e, $00
	call GetPlayAreaCardAttachedEnergies
	ld a, [$cc2c]
	ld hl, $cc30
	add [hl]
	ld hl, $cd
	cp $01
	ret c
	call GetCardDamageAndMaxHP
	ld hl, $b6
	cp $0a
	ret
; 0x69052

Func_69052:
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
; 0x69065

Func_69065:
	ld a, $0b
	call Func_681e5
	ld a, [wDuelTempList]
	ldh [hTemp_ffa0], a
	ret
; 0x69070

Func_69070:
	ldh a, [hTemp_ffa0]
	call Func_0ffa
	ret
; 0x69076

Func_69076:
	ld e, $00
	call GetCardDamageAndMaxHP
	ld e, a
	ld d, $00
	call ApplyAndAnimateHPRecovery
	ret
; 0x69082

Func_69082:
	call Func_68027
	ret
; 0x69086

Func_69086:
	call Func_68027
	ret
; 0x6908a

Func_6908a:
	ld de, $110
	call TossCoin_Bank1a
	jp nc, Func_6809a
	ld a, $4f
	ld [wLoadedAttackAnimation], a
	ld a, $15
	call Func_68127
	ret
; 0x6909e

Func_6909e:
	ld a, $01
	call Func_6812e
	ret
; 0x690a4

Func_690a4:
	call Func_68033
	ret
; 0x690a8

Func_690a8:
	ld a, $0a
	ld de, $a0a
	call Func_680b6
	ret
; 0x690b1

Func_690b1:
	call Func_68012
	ret
; 0x690b5

Func_690b5:
	call Func_68501
	ret
; 0x690b9

Func_690b9:
	call Func_690c3
	ret
; 0x690bd

Func_690bd:
	call Func_68633
	ret
; 0x690c1

Func_690c1:
	jr Func_690d0

Func_690c3:
	ld hl, $17b
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
	ld hl, $19f
	call DrawWideTextBox_WaitForInput
	call SwapTurn
	ret
; 0x69109

Func_69109:
	ld a, $1e
	ld de, $3c
	call Func_680dd
	ret
; 0x69112

Func_69112:
	ld hl, $1e
	call LoadTxRam3
	ld de, $113
	ld a, $02
	call Func_68069
	ld e, a
	add a
	add e
	call ATimes10
	call Func_6817e
	ret
; 0x6912a

Func_6912a:
	ld bc, $201
	jp Func_68e88
; 0x69130

Func_69130:
	jp Func_6a87d
; 0x69133

Func_69133:
	jp Func_6a877
; 0x69136

Func_69136:
	jp Func_6a8a5
; 0x69139

Func_69139:
	ld bc, $100
	jp Func_68e88
; 0x6913f

Func_6913f:
	ld a, $1e
	ld de, $1e
	call Func_680dd
	ret
	ret
; 0x69149

Func_69149:
	ld a, $05
	ld [wLoadedAttackAnimation], a
	ld de, $10d
	call TossCoin_Bank1a
	jp c, Func_6802e
	xor a
	ld [wLoadedAttackAnimation], a
	call Func_6817e
	call Func_6809a
	ret
; 0x69162

Func_69162:
	ld a, $1e
	ld de, $3c
	call Func_680dd
	ret
; 0x6916b

Func_6916b:
	ld hl, $1e
	call LoadTxRam3
	ld de, $113
	ld a, $02
	call Func_68069
	ld e, a
	add a
	add e
	call ATimes10
	call Func_6817e
	ret
; 0x69183

Func_69183:
	call Func_68027
	ret
; 0x69187

Func_69187:
	ld de, $109
	call TossCoin_Bank1a
	ldh [hTemp_ffa0], a
	ret
; 0x69190

Func_69190:
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
; 0x691aa

Func_691aa:
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
; 0x691c4

Func_691c4:
	ldh a, [hTemp_ffa0]
	or a
	ret nz
	ld hl, $165
	call DrawWideTextBox_WaitForInput
	bank1call HasAlivePokemonInBench
	bank1call OpenPlayAreaScreenForSelection
	ldh a, [hTempPlayAreaLocation_ff9d]
	ldh [hTempPlayAreaLocation_ffa1], a
	ret
; 0x691d9

Func_691d9:
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
; 0x691ff

Func_691ff:
	ld bc, $100
	jp Func_68e88
; 0x69205

Func_69205:
	call Func_6803e
	ret
; 0x69209

Func_69209:
	scf
	ret
; 0x6920b

Func_6920b:
	ld de, $fd
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
; 0x69250

Func_69250:
	xor a
	call Func_6817e
	ret
; 0x69255

Func_69255:
	call SwapTurn
	call Func_68196
	ld b, a
	ld de, $28
	call DealDamageToPlayAreaPokemon_RegularAnim
	call SwapTurn
	ret
; 0x69266

Func_69266:
	ld a, $1e
	call Func_6810e
	ret
; 0x6926c

Func_6926c:
	call Func_681e3
	xor a
	bank1call DisplayEnergyDiscardMenu
	bank1call HandleAttachedEnergyMenuInput
	ldh a, [hTempCardIndex_ff98]
	ldh [hTemp_ffa0], a
	ret
; 0x6927b

Func_6927b:
	ld e, $00
	call Func_69283
	cp $01
	ret
; 0x69283

Func_69283:
	call GetPlayAreaCardAttachedEnergies
	ld a, [wAttachedEnergies]
	ld hl, $cc30
	add [hl]
	ld hl, $cb
	ret
; 0x69291

Func_69291:
	call Func_681e3
	ld a, [wDuelTempList]
	ldh [hTemp_ffa0], a
	ret
; 0x6929a

Func_6929a:
	jp Func_6927b
; 0x6929d

Func_6929d:
	jp Func_6926c
; 0x692a0

Func_692a0:
	jp Func_69291
; 0x692a3

Func_692a3:
	ldh a, [hTemp_ffa0]
	call Func_0ffa
	ret
; 0x692a9

Func_692a9:
	ld a, $1e
	call DealRecoilDamageToSelf
	ret
; 0x692af

Func_692af:
	ld a, $14
	ld de, $a1e
	call Func_680dd
	ret
; 0x692b8

Func_692b8:
	ld a, $14
	call Func_682e0
	ret
; 0x692be

Func_692be:
	ld e, $00
	call Func_69283
	cp $02
	ret
; 0x692c6

Func_692c6:
	ld hl, $176
	call DrawWideTextBox_WaitForInput
	xor a
	ldh [$ffb2], a
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
	ldh a, [$ffb2]
	cp $02
	ret nc
	bank1call UpdateAttachedEnergyMenu
	jr .asm_692d6
; 0x692ee

Func_692ee:
	call Func_69291
	ld a, [$c511]
	ldh [hTempPlayAreaLocation_ffa1], a
	ret
; 0x692f7

Func_692f7:
	ldh a, [hTemp_ffa0]
	call Func_0ffa
	ldh a, [hTempPlayAreaLocation_ffa1]
	call Func_0ffa
	ret
; 0x69302

Func_69302:
	ldh a, [hTempPlayAreaLocation_ff9d]
	jr Func_69307

Func_69306:
	xor a
;	fallthrough

Func_69307:
	ld e, a
	call GetCardDamageAndMaxHP
	call Func_68163
	ret
; 0x6930f

Func_6930f:
	ld a, $19
	ld de, $141e
	call Func_680dd
	ret
; 0x69318

Func_69318:
	ld a, $0a
	call Func_682e0
	ret
; 0x6931e

Func_6931e:
	ld de, $11b
	call TossCoin_Bank1a
	ret nc
	ld a, $52
	ld [wLoadedAttackAnimation], a
	ld a, $11
	call Func_68127
	ret
; 0x69330

Func_69330:
	call Func_6843b
	ret
; 0x69334

Func_69334:
	ld hl, $164
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
; 0x6934d

Func_6934d:
	call Func_6869d
	ldh [hTemp_ffa0], a
	ret
; 0x69353

Func_69353:
	call SwapTurn
	ldh a, [hTemp_ffa0]
	ld e, a
	bank1call Func_6f49
	call nc, SwapArenaWithBenchPokemon
	call SwapTurn
	xor a
	ld [wDuelDisplayedScreen], a
	ret
; 0x69367

Func_69367:
	jp Func_6927b
; 0x6936a

Func_6936a:
	jp Func_6926c
; 0x6936d

Func_6936d:
	jp Func_69291
; 0x69370

Func_69370:
	ldh a, [hTemp_ffa0]
	call Func_0ffa
	ret
; 0x69376

Func_69376:
	jp Func_6927b
; 0x69379

Func_69379:
	jp Func_6926c
; 0x6937c

Func_6937c:
	jp Func_69291
; 0x6937f

Func_6937f:
	ldh a, [hTemp_ffa0]
	call Func_0ffa
	ret
; 0x69385

Func_69385:
	call SwapTurn
	farcall Func_2435f
	call SwapTurn
	ret c
	jp Func_6927b
; 0x69393

Func_69393:
	ld hl, $177
	call DrawWideTextBox_WaitForInput
	xor a
	ldh [$ffb2], a
	call Func_681e3
	xor a
	bank1call DisplayEnergyDiscardMenu
	xor a
	ld [wAttachedEnergyMenuDenominator], a
.asm_693a7
	ldh a, [$ffb2]
	ld [wAttachedEnergyMenuNumerator], a
	bank1call HandleAttachedEnergyMenuInput
	jr c, .asm_693c8
	farcall Func_24350
	ldh a, [hTempCardIndex_ff98]
	ld [hl], a
	call RemoveCardFromDuelTempList
	jr c, .asm_693c8
	ldh a, [$ffb2]
	cp $0f
	jr nc, .asm_693c8
	bank1call UpdateAttachedEnergyMenu
	jr .asm_693a7
.asm_693c8
	farcall Func_24350
	ld [hl], $ff
	ldh a, [$ffb2]
	cp $02
	ret
; 0x693d3

Func_693d3:
	ld a, $ff
	ldh [hTemp_ffa0], a
	ret
; 0x693d8

Func_693d8:
	ld hl, hTemp_ffa0
.asm_693db
	ld a, [hli]
	cp $ff
	jr z, .asm_693e5
	call Func_0ffa
	jr .asm_693db
.asm_693e5
	ret
; 0x693e6

Func_693e6:
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
	ld hl, $205
	call DrawWideTextBox_PrintText
	call SwapTurn
	ret
; 0x6941b

Func_6941b:
	ld a, $50
	ld de, $50
	call Func_680dd
	ret
; 0x69424

Func_69424:
	ld de, $10d
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
; 0x6943a

Func_6943a:
	ld a, $14
	ld de, $a1e
	call Func_680dd
	ret
; 0x69443

Func_69443:
	ld a, $14
	call Func_682e0
	ret
; 0x69449

Func_69449:
	jp Func_6927b
; 0x6944c

Func_6944c:
	jp Func_6926c
; 0x6944f

Func_6944f:
	jp Func_69291
; 0x69452

Func_69452:
	ldh a, [hTemp_ffa0]
	call Func_0ffa
	ret
; 0x69458

Func_69458:
	jp Func_6927b
; 0x6945b

Func_6945b:
	jp Func_6926c
; 0x6945e

Func_6945e:
	jp Func_69291
; 0x69461

Func_69461:
	ldh a, [hTemp_ffa0]
	call Func_0ffa
	ret
; 0x69467

Func_69467:
	ld a, $01
	call Func_6812e
	ret
; 0x6946d

Func_6946d:
	ld a, $05
	ld de, $a
	call Func_680b6
	ret
; 0x69476

Func_69476:
	call Func_6800b
	ret
; 0x6947a

Func_6947a:
	jp Func_6927b
; 0x6947d

Func_6947d:
	jp Func_6926c
; 0x69480

Func_69480:
	jp Func_69291
; 0x69483

Func_69483:
	ldh a, [hTemp_ffa0]
	call Func_0ffa
	ret
; 0x69489

Func_69489:
	scf
	ret
; 0x6948b

Func_6948b:
	jr Func_69493

Func_6948d:
	jr Func_694a0

Func_6948f:
	jr Func_694e5

Func_69491:
	jr Func_694d7

Func_69493:
	xor a
	call CreateArenaOrBenchEnergyCardList
	call CountCardsInDuelTempList
	ld hl, $ca
	cp $02
	ret

Func_694a0:
	ld hl, $178
	call DrawWideTextBox_WaitForInput
	xor a
	ldh [$ffb2], a
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
	ldh a, [$ffb2]
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
; 0x694f1

SECTION "Bank 1a@550c", ROMX[$550c], BANK[$1a]

Func_6950c:
	scf
	ret
; 0x6950e

Func_6950e:
	jp Func_69493
; 0x69511

Func_69511:
	jr Func_694a0
; 0x69513

Func_69513:
	jr Func_694e5
; 0x69515

Func_69515:
	jr Func_694d7
; 0x69517

Func_69517:
	call Func_6803e
	ret
; 0x6951b

Func_6951b:
	ldh a, [hTempPlayAreaLocation_ff9d]
	jr Func_69520

Func_6951f:
	xor a
;	fallthrough

Func_69520:
	ld e, a
	call GetCardDamageAndMaxHP
	call Func_68163
	ret
; 0x69528

Func_69528:
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
; 0x6953f

Func_6953f:
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
	ldh [$ffb2], a
	push bc
	ld hl, $1a6
	call DrawWideTextBox_WaitForInput
	call Func_680a0
	call CreateDeckCardList
	pop bc
	ldh a, [$ffb2]
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
; 0x69592

Func_69592:
	call LoadCardDataToBuffer2_FromDeckIndex
	ld a, [wLoadedCard2Type]
	cp $08
	ret
; 0x6959b

Func_6959b:
	ld a, $28
	ld de, $50
	call Func_680dd
	ret
; 0x695a4

Func_695a4:
	ld hl, $a
	call LoadTxRam3
	ld de, $113
	ld a, $08
	call Func_68069
	call ATimes10
	call Func_6817e
	ret
; 0x695b9

Func_695b9:
	scf
	ret
; 0x695bb

Func_695bb:
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
	ld hl, $20c
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
	ldh [$ffb2], a
	ld d, $84
	ld a, [wDuelistType]
	cp $00
	jr z, .asm_69609
	ld d, $85
.asm_69609
	ld a, d
	ld [wLoadedAttackAnimation], a
	ldh a, [$ffb2]
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
	ldh a, [$ffb2]
	ld l, a
	ld h, $00
	call LoadTxRam3
	ld hl, $1a5
	call DrawWideTextBox_WaitForInput
	call Func_680a0
	ret
; 0x69667

Func_69667:
	ld a, $46
	ld de, $46
	call Func_680dd
	ret
; 0x69670

Func_69670:
	ld de, $10d
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
; 0x69686

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
; 0x696b4

Func_696b4:
	ld e, $00
	call GetPlayAreaCardAttachedEnergies
	ld a, [$cc2e]
	ld hl, $cc30
	add [hl]
	ld hl, $cc
	cp $01
	ret
; 0x696c6

Func_696c6:
	push hl
	xor a
	ldh [$ffb2], a
	call CreateEnergyCardListFromDiscardPile_AllEnergy
	pop hl
	jr c, .asm_69700
	call DrawWideTextBox_WaitForInput
.asm_696d3
	bank1call InitAndDrawCardListScreenLayout
	ld hl, $18b
	ld de, $ad
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
	ldh a, [$ffb2]
	cp $02
	jr c, .asm_696d3
.asm_69700
	farcall Func_24350
	ld [hl], $ff
	or a
	ret
; 0x69708

Func_69708:
	call Func_68027
	ret
; 0x6970c

Func_6970c:
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
; 0x6972f

Func_6972f:
	ld hl, $188
	bank1call Func_5475
	call SwapTurn
	xor a
	ldh [$ffb2], a
	bank1call Func_5c30
.asm_6973e
	bank1call PrintPlayAreaCardList_EnableLCD
	push af
	ldh a, [$ffb2]
	ld hl, $4743
	call InitializeMenuParameters
	pop af
	ld [wNumScrollMenuItems], a
.asm_6974e
	call DoFrame
	call HandleMenuInput
	jr nc, .asm_6974e
	cp $ff
	jr z, .asm_697af
	ldh [$ffb2], a
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
; 0x697b4

Func_697b4:
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
; 0x69804

Func_69804:
	call Func_68665
	ret
; 0x69808

Func_69808:
	ld a, $ff
	ldh [hTemp_ffa0], a
	call Func_6843b
	ret c
	call Func_6869d
	ldh [hTemp_ffa0], a
	ret
; 0x69816

Func_69816:
	ldh a, [hTemp_ffa0]
	cp $ff
	ret z
	call SwapTurn
	ld b, a
	ld de, $a
	call DealDamageToPlayAreaPokemon_RegularAnim
	call SwapTurn
	ret
; 0x69829

Func_69829:
	call Func_6804a
	ret
; 0x6982d

Func_6982d:
	jp Func_696b4
; 0x69830

Func_69830:
	ld a, $0d
	call Func_681e5
	xor a
	bank1call DisplayEnergyDiscardMenu
	bank1call HandleAttachedEnergyMenuInput
	ret c
	ldh a, [hTempCardIndex_ff98]
	ldh [hTemp_ffa0], a
	ret
; 0x69842

Func_69842:
	ld a, $0d
	call Func_681e5
	ld a, [wDuelTempList]
	ldh [hTemp_ffa0], a
	ret
; 0x6984d

Func_6984d:
	ldh a, [hTemp_ffa0]
	call Func_0ffa
	ret
; 0x69853

Func_69853:
	ld a, $1b
	call Func_68127
	ret
; 0x69859

Func_69859:
	call Func_68027
	ret
; 0x6985d

Func_6985d:
	call CreateEnergyCardListFromDiscardPile_AllEnergy
	ld hl, $b8
	ret
; 0x69864

Func_69864:
	ld hl, $18a
	call Func_696c6
	ret
; 0x6986b

Func_6986b:
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
; 0x69884

Func_69884:
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
; 0x698a6

Func_698a6:
	call Func_6805c
	ret
; 0x698aa

Func_698aa:
	ld a, $ec
	call GetNonTurnDuelistVariable
	and $0f
	cp $02
	ret z
	ld hl, $de
	scf
	ret
; 0x698b9

Func_698b9:
	scf
	ret
; 0x698bb

Func_698bb:
	call Func_6805c
	ret
; 0x698bf

Func_698bf:
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
; 0x698d6

Func_698d6:
.asm_698d6
	ld hl, $18c
	bank1call Func_5475
.asm_698dc
	bank1call DrawDuelMainScene
	ld hl, $194
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
; 0x69910

Func_69910:
	ld a, $ff
	ldh [hTemp_ffa0], a
	ret
; 0x69915

Func_69915:
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
	ld hl, $217
	call DrawWideTextBox_WaitForInput
	ret
; 0x6994a

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
	ld [$cd1f], a
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
	ldh [$ffb2], a
	ld hl, $c51a
	xor a
.asm_69978
	ld [hli], a
	dec b
	jr nz, .asm_69978
	ld [hl], $ff
	bank1call InitAndDrawCardListScreenLayout
	ld hl, $18d
	ld de, $b0
	bank1call SetCardListHeaderAndInfoText
	bank1call Func_53bc
.asm_6998d
	bank1call DisplayCardList
	jr c, .asm_699e3
	ldh a, [hCurScrollMenuItem]
	ld e, a
	ld d, $00
	ld hl, $c51a
	add hl, de
	ld a, [hl]
	or a
	jr nz, .asm_6998d
	ldh a, [$ffb2]
	ld [hl], a
	inc a
	ldh [$ffb2], a
	bank1call Func_53cb
	ldh a, [$ffb2]
	ld hl, $cd1f
	cp [hl]
	jr c, .asm_6998d
	call EraseCursor
	ld hl, $2f
	call YesOrNoMenuWithText_LeftAligned
	jr c, .asm_6996c
	ld hl, $c51a
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
	ld hl, $ffb2
	ld a, [hl]
	cp $01
	jr z, .asm_6998d
	dec a
	ld [hl], a
	ld c, a
	ld hl, $c51a
.asm_699f1
	ld a, [hli]
	cp c
	jr nz, .asm_699f1
	dec hl
	ld [hl], $00
	bank1call Func_53cb
	jr .asm_6998d
; 0x699fd

Func_699fd:
	call Func_68665
	ret
; 0x69a01

Func_69a01:
	ld a, $ff
	ldh [hTemp_ffa0], a
	call Func_6843b
	ret c
	call Func_6869d
	ldh [hTemp_ffa0], a
	ret
; 0x69a0f

Func_69a0f:
	ldh a, [hTemp_ffa0]
	cp $ff
	ret z
	call SwapTurn
	ld b, a
	ld de, $a
	call DealDamageToPlayAreaPokemon_RegularAnim
	call SwapTurn
	ret
; 0x69a22

Func_69a22:
	call Func_6803e
	ret
; 0x69a26

Func_69a26:
	scf
	ret
; 0x69a28

Func_69a28:
	call SwapTurn
	ld e, $00
	call GetCardDamageAndMaxHP
	call SwapTurn
	call Func_68163
	ret
; 0x69a37

Func_69a37:
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
; 0x69a4b

Func_69a4b:
	ld a, DUELVARS_DUELIST_TYPE
	get_turn_duelist_var
	cp $00
	jr z, .asm_69a59
	bank1call Func_5c30
	bank1call PrintPlayAreaCardList_EnableLCD
	ret
.asm_69a59
	ld hl, $18e
	bank1call Func_5475
	xor a
	ldh [$ffb2], a
	bank1call Func_5c30
.asm_69a65
	bank1call PrintPlayAreaCardList_EnableLCD
	push af
	ldh a, [$ffb2]
	ld hl, $4743
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
	ldh [$ffb2], a
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
	ldh [$ffb2], a
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
; 0x69acc

Func_69acc:
	call Func_69ad5
	ret c
	bank1call PrintPlayAreaCardList_EnableLCD
	or a
	ret
; 0x69ad5

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
; 0x69af1

Func_69af1:
	call Func_6803e
	ret
; 0x69af5

Func_69af5:
	call Func_69afb
	jp Func_6818c
; 0x69afb

Func_69afb:
	call Func_69686
	ld hl, wDamage
	ld [hl], e
	inc hl
	ld [hl], d
	ret
; 0x69b05

Func_69b05:
	call Func_69bf6
	ret nc
	call SwapTurn
	call Func_69bf6
	call SwapTurn
	ld hl, $c6
	ret
; 0x69b16

Func_69b16:
	ld hl, $18f
	bank1call Func_5475
.asm_69b1c
	bank1call DrawDuelMainScene
	ld hl, $195
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
; 0x69b50

Func_69b50:
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
; 0x69b68

Func_69b68:
	xor a
	ld [wLoadedAttackAnimation], a
	ret
; 0x69b6d

Func_69b6d:
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
	ld a, [$cc3b]
	ld [$ccd7], a
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
; 0x69bf6

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
; 0x69c09

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
; 0x69c19

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
; 0x69c2e

Func_69c2e:
	scf
	ret
; 0x69c30

Func_69c30:
	call Func_68027
	ret
; 0x69c34

Func_69c34:
	call Func_69c3a
	jp Func_6818c
; 0x69c3a

Func_69c3a:
	call Func_69686
	ld hl, wDamage
	ld a, e
	add [hl]
	ld [hli], a
	ld a, d
	adc [hl]
	ld [hl], a
	ret
; 0x69c47

Func_69c47:
	jp Func_696b4
; 0x69c4a

Func_69c4a:
	ld a, $0d
	call Func_681e5
	xor a
	bank1call DisplayEnergyDiscardMenu
	bank1call HandleAttachedEnergyMenuInput
	ret c
	ldh a, [hTempCardIndex_ff98]
	ldh [hTemp_ffa0], a
	ret
; 0x69c5c

Func_69c5c:
	ld a, $0d
	call Func_681e5
	ld a, [wDuelTempList]
	ldh [hTemp_ffa0], a
	ret
; 0x69c67

Func_69c67:
	ldh a, [hTemp_ffa0]
	call Func_0ffa
	ret
; 0x69c6d

Func_69c6d:
	ld a, $19
	call Func_68127
	ret
; 0x69c73

Func_69c73:
	call CreateEnergyCardListFromDiscardPile_AllEnergy
	ld hl, $b8
	ret
; 0x69c7a

Func_69c7a:
	ld hl, $189
	call Func_696c6
	ret
; 0x69c81

Func_69c81:
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
; 0x69c9a

Func_69c9a:
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
; 0x69cab

Func_69cab:
	call CreateEnergyCardListFromDiscardPile_AllEnergy
	ld hl, $b8
	ret
; 0x69cb2

Func_69cb2:
	ld hl, $189
	call Func_696c6
	ret
; 0x69cb9

Func_69cb9:
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
; 0x69cd2

Func_69cd2:
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
; 0x69ce3

Func_69ce3:
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
; 0x69d03

Func_69d03:
	ld a, DUELVARS_DUELIST_TYPE
	get_turn_duelist_var
	cp $00
	jr z, .asm_69d11
	bank1call Func_5c30
	bank1call PrintPlayAreaCardList_EnableLCD
	ret
.asm_69d11
	ld hl, $190
	bank1call Func_5475
	xor a
	ldh [$ffb2], a
	bank1call Func_5c30
.asm_69d1d
	bank1call PrintPlayAreaCardList_EnableLCD
	push af
	ldh a, [$ffb2]
	ld hl, $4743
	call InitializeMenuParameters
	pop af
	ld [wNumScrollMenuItems], a
.asm_69d2d
	call DoFrame
	call HandleMenuInput
	jr nc, .asm_69d2d
	cp $ff
	ret z
	ldh [$ffb2], a
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
; 0x69d59

Func_69d59:
	call Func_69d62
	ret c
	bank1call PrintPlayAreaCardList_EnableLCD
	or a
	ret
; 0x69d62

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
; 0x69d79

Func_69d79:
	call Func_68027
	ret
; 0x69d7d

Func_69d7d:
	ld e, $00
	call GetCardDamageAndMaxHP
	ld hl, $b6
	cp $0a
	ret
; 0x69d88

Func_69d88:
	ld de, $10d
	call TossCoin_Bank1a
	ldh [hTemp_ffa0], a
	jp nc, Func_6809a
	ld a, $58
	ld [wLoadedAttackAnimation], a
	ret
; 0x69d99

Func_69d99:
	ldh a, [hTemp_ffa0]
	or a
	ret z
	ld de, $a
	call ApplyAndAnimateHPRecovery
	ret
; 0x69da4

Func_69da4:
	call Func_696b4
	ret c
	call Func_683b4
	ld hl, $ce
	ret
; 0x69daf

Func_69daf:
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
; 0x69dc2

Func_69dc2:
	ld a, $0d
	call Func_681e5
	ld a, [wDuelTempList]
	ldh [hTemp_ffa0], a
	call Func_683b4
	ld a, [wDuelTempList]
	ldh [hTempPlayAreaLocation_ffa1], a
	ret
; 0x69dd5

Func_69dd5:
	ldh a, [hTemp_ffa0]
	call Func_0ffa
	ret
; 0x69ddb

Func_69ddb:
	call Func_683b4
	bank1call Func_5221
	ld hl, $b4
	ld de, $ad
	bank1call SetCardListHeaderAndInfoText
.asm_69dea
	bank1call DisplayCardList
	jr c, .asm_69dea
	ldh a, [hTempCardIndex_ff98]
	ldh [hTempPlayAreaLocation_ffa1], a
	ret
; 0x69df4

Func_69df4:
	ldh a, [hTempPlayAreaLocation_ffa1]
	call MoveDiscardPileCardToHand
	call AddCardToHand
	call Func_680ab
	ret c
	ldh a, [hTempPlayAreaLocation_ffa1]
	ld hl, $200
	bank1call DisplayCardDetailScreen
	ret
; 0x69e09

Func_69e09:
	call Func_68501
	ret
; 0x69e0d

Func_69e0d:
	call Func_690c3
	ret
; 0x69e11

Func_69e11:
	call Func_68633
	ret
; 0x69e15

Func_69e15:
	call Func_690d0
	ret
; 0x69e19

Func_69e19:
	call Func_696b4
	ret c
	call GetCardDamageAndMaxHP
	ld hl, $b6
	cp $0a
	ret
; 0x69e26

Func_69e26:
	ld a, $0d
	call Func_681e5
	xor a
	bank1call DisplayEnergyDiscardMenu
	bank1call HandleAttachedEnergyMenuInput
	ret c
	ldh a, [hTempCardIndex_ff98]
	ldh [hTemp_ffa0], a
	ret
; 0x69e38

Func_69e38:
	ld a, $0d
	call Func_681e5
	ld a, [wDuelTempList]
	ldh [hTemp_ffa0], a
	ret
; 0x69e43

Func_69e43:
	ldh a, [hTemp_ffa0]
	call Func_0ffa
	ret
; 0x69e49

Func_69e49:
	ld e, $00
	call GetCardDamageAndMaxHP
	ld e, a
	ld d, $00
	call ApplyAndAnimateHPRecovery
	ret
; 0x69e55

Func_69e55:
	ld a, $0a
	ld de, $14
	call Func_680dd
	ret
; 0x69e5e

Func_69e5e:
	ld hl, $a
	call LoadTxRam3
	ld de, $113
	ld a, $02
	call Func_68069
	call ATimes10
	call Func_6817e
	ret
; 0x69e73

Func_69e73:
	call SwapTurn
	ld e, $00
	call GetCardDamageAndMaxHP
	call SwapTurn
	call Func_68163
	ret
; 0x69e82

Func_69e82:
	ld a, $0a
	ld de, $14
	call Func_680dd
	ret
; 0x69e8b

Func_69e8b:
	ld a, $0a
	call Func_6817e
	call UpdateRNGSources
	and $07
	ldh [hTemp_ffa0], a
	ld hl, $5e9d
	jp JumpToFunctionInTable
; 0x69e9d

SECTION "Bank 1a@5ec0", ROMX[$5ec0], BANK[$1a]

Func_69ec0:
	ldh a, [hTemp_ffa0]
	cp $04
	ret nz
	ld de, $a
	call ApplyAndAnimateHPRecovery
	ret
; 0x69ecc

Func_69ecc:
	ld a, $0a
	ld de, $64
	call Func_680dd
	ret
; 0x69ed5

Func_69ed5:
	xor a
	ldh [hTemp_ffa0], a
.asm_69ed8
	ld de, $107
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
; 0x69ef8

Func_69ef8:
	ld a, $13
	call Func_68127
	ret
; 0x69efe

Func_69efe:
	ld a, $1e
	ld de, $3c
	call Func_680dd
	ret
; 0x69f07

Func_69f07:
	ld hl, $14
	call LoadTxRam3
	ld de, $113
	ld a, $03
	call Func_68069
	add a
	call ATimes10
	call Func_6817e
	ret
; 0x69f1d

Func_69f1d:
	ld de, $104
	call TossCoin_Bank1a
	ret c
	ld a, $29
	ld [wLoadedAttackAnimation], a
	call SwapTurn
	call Func_68045
	call SwapTurn
	ret
; 0x69f33

Func_69f33:
	scf
	ret
; 0x69f35

Func_69f35:
	scf
	ret
; 0x69f37

Func_69f37:
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
; 0x69f4f

Func_69f4f:
	ld a, $03
	call Func_6812e
	ret
; 0x69f55

Func_69f55:
	ldh a, [hTempPlayAreaLocation_ff9d]
	jr Func_69f5a

Func_69f59:
	xor a
;	fallthrough

Func_69f5a:
	ld e, a
	call GetCardDamageAndMaxHP
	call Func_68163
	ret
; 0x69f62

Func_69f62:
	ld a, $1e
	ld de, $3c
	call Func_680dd
	ret
; 0x69f6b

Func_69f6b:
	ld hl, $1e
	call LoadTxRam3
	ld de, $113
	ld a, $02
	call Func_68069
	ld e, a
	add a
	add e
	call ATimes10
	call Func_6817e
	ret
; 0x69f83

Func_69f83:
	farcall Func_2435f
	ret c
	farcall Func_24369
	ret
; 0x69f8d

Func_69f8d:
	call CreateDeckCardList
	ld hl, $17c
	ld bc, $19a
	ld a, $02
	farcall Func_24c9d
	jr c, .asm_69fa8
	ld hl, $183
	ld de, $b0
	farcall Func_24df8
.asm_69fa8
	ldh [hTemp_ffa0], a
	ret
; 0x69fab

Func_69fab:
	ld a, $02
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
; 0x69fc4

Func_69fc4:
	ldh a, [hTemp_ffa0]
	cp $ff
	jr z, .asm_69fe0
	call SearchCardInDeckAndAddToHand
	call AddCardToHand
	call PutHandPokemonCardInPlayArea
	call Func_680ab
	jr c, .asm_69fe0
	ldh a, [hTemp_ffa0]
	ld hl, $63
	bank1call DisplayCardDetailScreen
.asm_69fe0
	call Func_680a0
	ret
; 0x69fe4

Func_69fe4:
	ldh a, [hTempPlayAreaLocation_ff9d]
	call Func_69fed
	jp Func_6818c
; 0x69fec

Func_69fec:
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
; 0x6a003

Func_6a003:
	ld a, $14
	call DealRecoilDamageToSelf
	ret
; 0x6a009

Func_6a009:
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
; 0x6a025

Func_6a025:
	ld a, $13
	call Func_68127
	ret
; 0x6a02b

Func_6a02b:
	call HandleMandatorySwitchSelection
	ldh a, [hTempPlayAreaLocation_ff9d]
	ldh [hTemp_ffa0], a
	ret
; 0x6a033

Func_6a033:
	ld a, $14
	call DealRecoilDamageToSelf
	call Func_68074
	ldh a, [hTemp_ffa0]
	call Func_6828a
	ret
; 0x6a041

Func_6a041:
	ld de, $11c
	call TossCoin_Bank1a
	jp nc, Func_6809a
	ld a, $74
	ld [wLoadedAttackAnimation], a
	ld a, $06
	call Func_6812e
	ret
; 0x6a055

Func_6a055:
	call Func_6843b
	ret
; 0x6a059

Func_6a059:
	call Func_68665
	ret
; 0x6a05d

Func_6a05d:
	call Func_6869d
	ldh [hTemp_ffa0], a
	ret
; 0x6a063

Func_6a063:
	call SwapTurn
	ldh a, [hTemp_ffa0]
	ld b, a
	ld de, $14
	call DealDamageToPlayAreaPokemon_RegularAnim
	call SwapTurn
	ret
; 0x6a073

Func_6a073:
	ld a, $02
	call Func_6812e
	ret
; 0x6a079

Func_6a079:
	ld a, $1e
	ld de, $3c
	call Func_680dd
	ret
; 0x6a082

Func_6a082:
	ld hl, $14
	call LoadTxRam3
	ld de, $113
	ld a, $03
	call Func_68069
	add a
	call ATimes10
	call Func_6817e
	ret
; 0x6a098

Func_6a098:
	call Func_6806e
	ld a, $0a
	call Func_680f9
	ret
; 0x6a0a1

Func_6a0a1:
	scf
	ret
; 0x6a0a3

Func_6a0a3:
	jp Func_6844f
; 0x6a0a6

Func_6a0a6:
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
	ld hl, $19c
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
	ld hl, $19d
	call DrawWideTextBox_WaitForInput
	ret
; 0x6a0f9

Func_6a0f9:
	ld de, $11c
	call TossCoin_Bank1a
	ret nc
	ld a, $ff
	ld [wLoadedAttackAnimation], a
	ld a, $0b
	call Func_6812e
	ret
; 0x6a10b

Func_6a10b:
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
; 0x6a12c

Func_6a12c:
	call SwapTurn
	call Func_6a151
	call SwapTurn
	call Func_6a151
	ld hl, $1a0
	call DrawWideTextBox_WaitForInput
	bank1call HasAlivePokemonInPlayArea
	bank1call OpenPlayAreaScreenForSelection
	call SwapTurn
	bank1call HasAlivePokemonInPlayArea
	bank1call OpenPlayAreaScreenForSelection
	call SwapTurn
	ret
; 0x6a151

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
; 0x6a190

Func_6a190:
	call Func_68027
	ret
; 0x6a194

Func_6a194:
	ld a, $23
	ld de, LoadSymbolsFont
	call Func_680dd
	ret
; 0x6a19d

Func_6a19d:
	ld de, $108
	call TossCoin_Bank1a
	ldh [hTemp_ffa0], a
	ret nc
	ld a, $0a
	call Func_68163
	ret
; 0x6a1ac

Func_6a1ac:
	ldh a, [hTemp_ffa0]
	or a
	ret nz
	ld a, $0a
	call DealRecoilDamageToSelf
	ret
; 0x6a1b6

Func_6a1b6:
	ld a, $1a
	call Func_68127
	ret
; 0x6a1bc

Func_6a1bc:
	ld a, $14
	ld de, $a1e
	call Func_680dd
	ret
; 0x6a1c5

Func_6a1c5:
	ld hl, $14
	call LoadTxRam3
	ld de, $112
	call TossCoin_Bank1a
	ret nc
	ld a, $14
	call Func_68163
	ret
; 0x6a1d8

Func_6a1d8:
	call Func_68027
	ret
; 0x6a1dc

Func_6a1dc:
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
; 0x6a1f8

Func_6a1f8:
	ld hl, $1e
	call LoadTxRam3
	ld de, $10c
	call TossCoin_Bank1a
	ldh [hTemp_ffa0], a
	ret
; 0x6a207

Func_6a207:
	ld hl, $1e
	call LoadTxRam3
	ldh a, [hTemp_ffa0]
	or a
	ret nz
	ld a, $1e
	call DealRecoilDamageToSelf
	ret
; 0x6a217

Func_6a217:
	xor a
	call CreateArenaOrBenchEnergyCardList
	ld hl, wDuelTempList
.asm_6a21e
	ld a, [hli]
	cp $ff
	ret z
	call Func_0ffa
	jr .asm_6a21e
; 0x6a227

Func_6a227:
	ld a, $01
	ldh [$ffb2], a
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
; 0x6a28f

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
; 0x6a2bb

Func_6a2bb:
	ld a, $14
	ld de, $a1e
	call Func_680dd
	ret
; 0x6a2c4

Func_6a2c4:
	ld a, $14
	call Func_682e0
	ret
; 0x6a2ca

Func_6a2ca:
	ld a, $28
	ld de, $50
	call Func_680dd
	ret
; 0x6a2d3

Func_6a2d3:
	ld hl, $14
	call LoadTxRam3
	ld de, $113
	ld a, $04
	call Func_68069
	add a
	call ATimes10
	call Func_6817e
	ret
; 0x6a2e9

Func_6a2e9:
	call Func_68027
	ret
; 0x6a2ed

Func_6a2ed:
	jr Func_6a2f1

Func_6a2ef:
	jr Func_6a2fa

Func_6a2f1:
	ld a, $1e
	ld de, $1e
	call Func_680dd
	ret

Func_6a2fa:
	ld de, $10d
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
; 0x6a318

Func_6a318:
	call Func_68027
	ret
; 0x6a31c

Func_6a31c:
	jr Func_6a2f1
; 0x6a31e

Func_6a31e:
	jr Func_6a2fa
; 0x6a320

Func_6a320:
	ld hl, $a
	call LoadTxRam3
	ld de, $10c
	call TossCoin_Bank1a
	ldh [hTemp_ffa0], a
	ret
; 0x6a32f

Func_6a32f:
	ld hl, $a
	call LoadTxRam3
	ldh a, [hTemp_ffa0]
	or a
	ret nz
	ld a, $0a
	call DealRecoilDamageToSelf
	ret
; 0x6a33f

Func_6a33f:
	call Func_68665
	ret
; 0x6a343

Func_6a343:
	ld a, $ff
	ldh [hTemp_ffa0], a
	call Func_6843b
	ret c
	call Func_6869d
	ldh [hTemp_ffa0], a
	ret
; 0x6a351

Func_6a351:
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
; 0x6a366

Func_6a366:
	ld a, $17
	call Func_6812e
	ret
; 0x6a36c

Func_6a36c:
	call Func_68027
	ret
; 0x6a370

Func_6a370:
	ld a, $17
	call Func_6812e
	ret
; 0x6a376

Func_6a376:
	call Func_68027
	ret
; 0x6a37a

Func_6a37a:
	ld a, $0a
	call Func_6817e
	call SwapTurn
	bank1call GetArenaCardColor
	call SwapTurn
	ldh [$ffb2], a
	cp $06
	ret z
	call SwapTurn
	call Func_6a3a0
	call SwapTurn
	call Func_6806e
	call Func_6a3a0
	call Func_68074
	ret
; 0x6a3a0

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
	ldh a, [$ffb2]
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
; 0x6a3c0

Func_6a3c0:
	ld de, $11b
	call TossCoin_Bank1a
	ret nc
	ld a, $52
	ld [wLoadedAttackAnimation], a
	ld a, $11
	call Func_68127
	ret
; 0x6a3d2

Func_6a3d2:
	ld hl, $1e
	call LoadTxRam3
	ld de, $10c
	call TossCoin_Bank1a
	ldh [hTemp_ffa0], a
	ret
; 0x6a3e1

Func_6a3e1:
	ld hl, $1e
	call LoadTxRam3
	ldh a, [hTemp_ffa0]
	or a
	ret nz
	ld a, $1e
	call DealRecoilDamageToSelf
	ret
; 0x6a3f1

Func_6a3f1:
	ld a, $ff
	ldh [hTemp_ffa0], a
	call Func_6843b
	ret c
	call SwapTurn
	ld hl, $172
	call DrawWideTextBox_WaitForInput
	xor a
	ldh [$ffb2], a
	ld [$cdf8], a
	bank1call Func_5c30
;	fallthrough

Func_6a40b:
.asm_6a40b
	bank1call PrintPlayAreaCardList_EnableLCD
	push af
	ld a, [$cdf8]
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
	ld [$cdf8], a
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
	ldh a, [$ffb2]
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
	ldh a, [$ffb2]
	or a
	jr z, .asm_6a40b
	dec a
	ldh [$ffb2], a
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
	ld [$cdf8], a
	jp Func_6a40b
; 0x6a48b

Func_6a48b:
	inc a
	ld c, a
	ldh a, [$ffb2]
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
; 0x6a49f

Func_6a49f:
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
; 0x6a4f7

Func_6a4f7:
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
; 0x6a511

Func_6a511:
	call Func_68027
	ret
; 0x6a515

Func_6a515:
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
; 0x6a531

Func_6a531:
	ld hl, $ccca
	set 7, [hl]
	ret
; 0x6a537

Func_6a537:
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
; 0x6a553

Func_6a553:
	scf
	ret
; 0x6a555

Func_6a555:
	call ExchangeRNG
	ld de, $1e
	call Func_6a562
	bank1call Func_6518
	ret
; 0x6a562

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
; 0x6a59a

Func_6a59a:
	call ExchangeRNG
	ld de, $46
	call Func_6a562
	ret
; 0x6a5a4

Func_6a5a4:
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
	ld hl, $1a4
	call DrawWideTextBox_WaitForInput
	xor a
	call Func_680ed
	ret
; 0x6a63b

Func_6a63b:
	ld hl, $ccca
	set 7, [hl]
	ret
; 0x6a641

Func_6a641:
	farcall Func_2435f
	ret
; 0x6a646

Func_6a646:
	call CreateDeckCardList
	ld hl, $173
	ld bc, VBlankHandler
	ld a, $03
	farcall Func_24c9d
	jr c, .asm_6a661
	ld hl, $180
	ld de, $b0
	farcall Func_24df8
.asm_6a661
	ldh [hTemp_ffa0], a
	cp $ff
	ret z
	call EmptyScreen
	ld hl, $174
	call DrawWideTextBox_WaitForInput
	bank1call HasAlivePokemonInPlayArea
.asm_6a672
	bank1call OpenPlayAreaScreenForSelection
	jr c, .asm_6a672
	ldh a, [hTempPlayAreaLocation_ff9d]
	ldh [hTempPlayAreaLocation_ffa1], a
	ret
; 0x6a67c

Func_6a67c:
	ld a, $ff
	ldh [hTemp_ffa0], a
	ret
; 0x6a681

Func_6a681:
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
; 0x6a6b9

Func_6a6b9:
	ld a, $14
	ld de, $28
	call Func_680dd
	ret
; 0x6a6c2

Func_6a6c2:
	ld hl, $14
	call LoadTxRam3
	ld de, $113
	ld a, $02
	call Func_68069
	add a
	call ATimes10
	call Func_6817e
	ret
; 0x6a6d8

Func_6a6d8:
	call Func_68027
	ret
; 0x6a6dc

Func_6a6dc:
	ld de, $11c
	call TossCoin_Bank1a
	jp nc, Func_6809a
	ld a, $c9
	ld [wLoadedAttackAnimation], a
	ld a, $05
	call Func_6812e
	ret
; 0x6a6f0

Func_6a6f0:
	ld a, $14
	ld de, $a1e
	call Func_680dd
	ret
; 0x6a6f9

Func_6a6f9:
	ld a, $14
	call Func_682e0
	ret
; 0x6a6ff

Func_6a6ff:
	jp Func_6bcdf
; 0x6a702

Func_6a702:
	jp Func_6bcea
; 0x6a705

Func_6a705:
	jp Func_6bd10
; 0x6a708

Func_6a708:
	jp Func_6bd2c
; 0x6a70b

Func_6a70b:
	jp Func_6bd4b
; 0x6a70e

Func_6a70e:
	jp Func_6bd76
; 0x6a711

Func_6a711:
	jp Func_6bd85
; 0x6a714

Func_6a714:
	jp Func_6bde7
; 0x6a717

Func_6a717:
	ld de, $11b
	call TossCoin_Bank1a
	ret nc
	ld a, $52
	ld [wLoadedAttackAnimation], a
	ld a, $11
	call Func_68127
	ret
; 0x6a729

Func_6a729:
	call Func_6844f
	ret c
	ldh a, [hTempPlayAreaLocation_ff9d]
	ldh [hTemp_ffa0], a
	or a
	ret nz
	ld hl, $dc
	scf
	ret
; 0x6a738

Func_6a738:
	call Func_68465
	ldh a, [hTemp_ffa0]
	ld e, a
	call SwapArenaWithBenchPokemon
	ret
; 0x6a742

Func_6a742:
	ld a, $28
	ld de, $50
	call Func_680dd
	ret
; 0x6a74b

Func_6a74b:
	ld hl, $28
	call LoadTxRam3
	ld de, $113
	ld a, $02
	call Func_68069
	add a
	add a
	call ATimes10
	call Func_6817e
	ret
; 0x6a762

Func_6a762:
	scf
	ret
; 0x6a764

Func_6a764:
	call Func_68027
	ret
; 0x6a768

Func_6a768:
	ld a, $1e
	ld de, $1e
	call Func_680dd
	ret
; 0x6a771

Func_6a771:
	ld a, DUELVARS_ARENA_CARD_FLAGS
	get_turn_duelist_var
	and $40
	ret z
	ld hl, $d1
	scf
	ret
; 0x6a77c

Func_6a77c:
	ld a, DUELVARS_ARENA_CARD_FLAGS
	get_turn_duelist_var
	set 6, [hl]
	ret
; 0x6a782

Func_6a782:
	ld de, $105
	call TossCoin_Bank1a
	ret c
	xor a
	call Func_6817e
	ret
; 0x6a78e

Func_6a78e:
	farcall Func_2435f
	ret
; 0x6a793

Func_6a793:
	ld hl, $16d
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
; 0x6a7b1

Func_6a7b1:
	ld a, $28
	ld de, $50
	call Func_680dd
	ret
; 0x6a7ba

Func_6a7ba:
	ld hl, $14
	call LoadTxRam3
	ld de, $113
	ld a, $04
	call Func_68069
	add a
	call ATimes10
	call Func_6817e
	ret
; 0x6a7d0

Func_6a7d0:
	ld a, $19
	ld de, $141e
	call Func_680dd
	ret
; 0x6a7d9

Func_6a7d9:
	ld a, $0a
	call Func_682e0
	ret
; 0x6a7df

Func_6a7df:
	ldh a, [hTempPlayAreaLocation_ff9d]
;	fallthrough

Func_6a7e1:
	ld e, a
	call GetCardDamageAndMaxHP
	call Func_68163
	ret
; 0x6a7e9

Func_6a7e9:
	xor a
	call Func_6a7e1
	ld de, $104
	call TossCoin_Bank1a
	ret c
	call SwapTurn
	call Func_68045
	call SwapTurn
	ret
; 0x6a7fe

Func_6a7fe:
	ld a, $0a
	ld de, $14
	call Func_680dd
	ret
; 0x6a807

Func_6a807:
	ld hl, $a
	call LoadTxRam3
	ld a, $02
	ld de, $113
	call Func_68069
	call ATimes10
	call Func_6817e
	ret
; 0x6a81c

Func_6a81c:
	scf
	ret
; 0x6a81e

Func_6a81e:
	ldh a, [hTempPlayAreaLocation_ff9d]
	jr Func_6a823

Func_6a822:
	xor a
;	fallthrough

Func_6a823:
	ld e, a
	call GetCardDamageAndMaxHP
	call Func_68163
	ret
; 0x6a82b

Func_6a82b:
	ld de, $106
	call TossCoin_Bank1a
	ret nc
	ld hl, $16d
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
; 0x6a850

Func_6a850:
	ld a, $1e
	ld de, $3c
	call Func_680dd
	ret
; 0x6a859

Func_6a859:
	ld hl, $1e
	call LoadTxRam3
	ld a, $02
	ld de, $113
	call Func_68069
	ld e, a
	add a
	add e
	call ATimes10
	call Func_6817e
	ret
; 0x6a871

Func_6a871:
	jr Func_6a87d

Func_6a873:
	jr Func_6a877

Func_6a875:
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
	ld hl, $17a
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
; 0x6a8bf

Func_6a8bf:
	ld a, $01
	ld [wMetronomeEnergyCost], a
	call Func_68501
	ret
; 0x6a8c8

Func_6a8c8:
	call Func_6a9dd
	ret
; 0x6a8cc

Func_6a8cc:
	ld a, $01
	call Func_6a958
	ret
; 0x6a8d2

Func_6a8d2:
	ld a, $18
	call Func_68127
	ret
; 0x6a8d8

Func_6a8d8:
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
	ld hl, $19e
	call DrawWideTextBox_WaitForInput
	xor a
	ld [wDuelDisplayedScreen], a
	call SwapTurn
	ret
; 0x6a91f

Func_6a91f:
	call HandleMandatorySwitchSelection
	ldh a, [hTempPlayAreaLocation_ff9d]
	ldh [hTemp_ffa0], a
	ret
; 0x6a927

Func_6a927:
	ldh a, [hTemp_ffa0]
	call Func_6828a
	ret
; 0x6a92d

Func_6a92d:
	jp Func_6bcdf
; 0x6a930

Func_6a930:
	jp Func_6bcea
; 0x6a933

Func_6a933:
	jp Func_6bd10
; 0x6a936

Func_6a936:
	jp Func_6bd2c
; 0x6a939

Func_6a939:
	jp Func_6bd4b
; 0x6a93c

Func_6a93c:
	jp Func_6bd76
; 0x6a93f

Func_6a93f:
	jp Func_6bd85
; 0x6a942

Func_6a942:
	jp Func_6bde7
; 0x6a945

Func_6a945:
	call Func_6804a
	ret
; 0x6a949

Func_6a949:
	ld a, $03
	ld [wMetronomeEnergyCost], a
	call Func_68501
	ret
; 0x6a952

Func_6a952:
	call Func_6a9dd
	ret
; 0x6a956

Func_6a956:
	ld a, $03
;	fallthrough

Func_6a958:
	ld [wMetronomeEnergyCost], a
	ld hl, $191
	call DrawWideTextBox_WaitForInput
.asm_6a961
	call Func_68486
	jr c, .asm_6a961
	ld hl, $cdf9
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
	ld hl, $46
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
	ld hl, $cdf9
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
	ld a, [$ccd3]
	ld [$cc0e], a
	or a
	ret

Func_6a9dd:
	ret
; 0x6a9de

Func_6a9de:
	call Func_6805c
	ret
; 0x6a9e2

Func_6a9e2:
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	dec a
	call ATimes10
	call Func_68163
	ret
; 0x6a9ed

Func_6a9ed:
	call Func_6805c
	ret
; 0x6a9f1

Func_6a9f1:
	ld e, $00
	call GetCardDamageAndMaxHP
	ld hl, $b6
	cp $0a
	ret
; 0x6a9fc

Func_6a9fc:
	ld de, $a
	call ApplyAndAnimateHPRecovery
	ret
; 0x6aa03

Func_6aa03:
	ld a, $14
	call DealRecoilDamageToSelf
	ret
; 0x6aa09

Func_6aa09:
	ld a, $07
	call Func_6812e
	ret
; 0x6aa0f

Func_6aa0f:
	call Func_68027
	ret
; 0x6aa13

Func_6aa13:
	call Func_68033
	ret
; 0x6aa17

Func_6aa17:
	call HandleMandatorySwitchSelection
	ldh a, [hTempPlayAreaLocation_ff9d]
	ldh [hTemp_ffa0], a
	ret
; 0x6aa1f

Func_6aa1f:
	ldh a, [hTemp_ffa0]
	call Func_6828a
	ret
; 0x6aa25

Func_6aa25:
	jr Func_6aa2e

Func_6aa27:
	jr Func_6aa44

Func_6aa29:
	jp Func_6aae2

Func_6aa2c:
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
	ld hl, $16a
	call Func_6aad1
	call SwapTurn
	ld a, $08
	call Func_6812e
	ret
; 0x6aa7c

Func_6aa7c:
	jr Func_6aa84

Func_6aa7e:
	jr Func_6aa94

Func_6aa80:
	jr Func_6aaa0

Func_6aa82:
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
	ld hl, $16b

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
; 0x6aae2

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
; 0x6ab44

Func_6ab44:
	ld de, $110
	call TossCoin_Bank1a
	jp nc, Func_6809a
	ld a, $6b
	ld [wLoadedAttackAnimation], a
	ld a, $1c
	call Func_68127
	ret
; 0x6ab58

Func_6ab58:
	ld a, $50
	call DealRecoilDamageToSelf
	ret
; 0x6ab5e

Func_6ab5e:
	ld a, $c8
	call GetNonTurnDuelistVariable
	srl a
	bit 0, a
	jr z, .asm_6ab6b
	add $05
.asm_6ab6b
	call Func_6817e
	ret
; 0x6ab6f

Func_6ab6f:
	ldh a, [hTempPlayAreaLocation_ff9d]
	ldh [hTemp_ffa0], a
	call Func_68446
	ret
; 0x6ab77

Func_6ab77:
	ldh a, [hTemp_ffa0]
	or a
	ret nz
	ld hl, $165
	call DrawWideTextBox_WaitForInput
	bank1call HasAlivePokemonInBench
	bank1call OpenPlayAreaScreenForSelection
	ldh a, [hTempPlayAreaLocation_ff9d]
	ldh [hTempPlayAreaLocation_ffa1], a
	ret
; 0x6ab8c

Func_6ab8c:
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
; 0x6aba1

Func_6aba1:
	scf
	ret
; 0x6aba3

Func_6aba3:
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
; 0x6abf0

Func_6abf0:
	ld a, $1e
	ld de, $3c
	call Func_680dd
	ret
; 0x6abf9

Func_6abf9:
	ld hl, $1e
	call LoadTxRam3
	ld de, $113
	ld a, $02
	call Func_68069
	ld c, a
	add a
	add c
	call ATimes10
	call Func_6817e
	ret
; 0x6ac11

SECTION "Bank 1a@6c31", ROMX[$6c31], BANK[$1a]

Func_6ac31:
	call SwapTurn
	call Func_68196
	ld b, a
	ld a, $83
	ld [wLoadedAttackAnimation], a
	ld de, $14
	call DealDamageToPlayAreaPokemon
	call SwapTurn
	ret
; 0x6ac47

Func_6ac47:
	farcall Func_2435f
	ret
; 0x6ac4c

Func_6ac4c:
	call ExchangeRNG
	call Func_6acbc
	jr nc, .asm_6ac5b
	ld hl, $149
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
	ld hl, $163
	call DrawWideTextBox_WaitForInput
	xor a
	ld [wDuelDisplayedScreen], a
	ret
; 0x6acbc

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
; 0x6acf3

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
; 0x6ad1a

Func_6ad1a:
	call SwapTurn
	call Func_68196
	ld b, a
	ld de, $1e
	call DealDamageToPlayAreaPokemon_RegularAnim
	call SwapTurn
	ret
; 0x6ad2b

Func_6ad2b:
	ld a, $87
	ld [wLoadedAttackAnimation], a
	ret
; 0x6ad31

Func_6ad31:
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
; 0x6ad65

Func_6ad65:
	farcall Func_2435f
	ret c
	farcall Func_24369
	ret
; 0x6ad6f

Func_6ad6f:
	ld de, $10d
	call TossCoin_Bank1a
	jr c, Func_6ad7e

Func_6ad77:
	ld hl, $207
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
	ld hl, $208
	bank1call DisplayCardDetailScreen
	call Func_680a0
	ret
; 0x6adab

Func_6adab:
	ld a, $23
	call Func_68127
	ret
; 0x6adb1

Func_6adb1:
	call Func_6844f
	ret
; 0x6adb5

Func_6adb5:
	ld hl, $1a7
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
; 0x6ade0

Func_6ade0:
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
; 0x6ae00

Func_6ae00:
	ld a, $46
	ld de, $46
	call Func_680dd
	ret
; 0x6ae09

Func_6ae09:
	call Func_6808d
	call Func_6927b
	ret
; 0x6ae10

Func_6ae10:
	ld de, $105
	call Func_68079
	ldh [hTemp_ffa0], a
	ret nc
	call Func_69291
	ldh [hTempPlayAreaLocation_ffa1], a
	ld a, $01
	ldh [hTemp_ffa0], a
	ret
; 0x6ae23

Func_6ae23:
	ld de, $105
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
; 0x6ae3a

Func_6ae3a:
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
; 0x6ae4f

Func_6ae4f:
	call Func_6808d
	call Func_6927b
	ret
; 0x6ae56

Func_6ae56:
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
; 0x6ae75

Func_6ae75:
	ld hl, $32
	call LoadTxRam3
	ld e, $00
	call Func_69283
	ld hl, $32
	ld de, $113
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
; 0x6aea9

Func_6aea9:
	ld hl, $32
	call LoadTxRam3
	ld e, $00
	call Func_69283
	ld hl, $32
	ld de, $113
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
	ldh [$ffb2], a
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
; 0x6aef6

Func_6aef6:
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
	ld [$ccca], a
	ret
; 0x6af16

Func_6af16:
	call Func_6927b
	ret
; 0x6af1a

Func_6af1a:
	call Func_6926c
	ret
; 0x6af1e

Func_6af1e:
	call Func_69291
	ret
; 0x6af22

Func_6af22:
	ldh a, [hTemp_ffa0]
	jp Func_0ffa
; 0x6af27

Func_6af27:
	ld a, $01
	ldh [hTemp_ffa0], a
	ret
; 0x6af2c

Func_6af2c:
	ld a, $01
	ldh [hTemp_ffa0], a
	call Func_6927b
	jr c, .asm_6af60
	call Func_6843b
	jr c, .asm_6af60
	ld hl, $1a8
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
; 0x6af62

Func_6af62:
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
; 0x6af7e

Func_6af7e:
	ldh a, [hTempPlayAreaLocation_ff9d]
	jr Func_6af83

Func_6af82:
	xor a
;	fallthrough

Func_6af83:
	ld e, a
	call GetCardDamageAndMaxHP
	call Func_68163
	ret
; 0x6af8b

Func_6af8b:
	call Func_6808d
	ret
; 0x6af8f

Func_6af8f:
	ld e, $00
	call Func_69283
	cp $01
	jr c, .asm_6afa1
	ld a, $28
	ld de, $1e32
	call Func_680dd
	ret
.asm_6afa1
	ld a, $00
	ld de, $0
	call Func_680dd
	ret
; 0x6afaa

Func_6afaa:
	ld hl, $14
	call LoadTxRam3
	ld de, $112
	call Func_68079
	ldh [hTemp_ffa0], a
	ret nc
	call Func_69291
	ldh a, [hTemp_ffa0]
	ldh [hTempPlayAreaLocation_ffa1], a
	ld a, $01
	ldh [hTemp_ffa0], a
	ret
; 0x6afc5

Func_6afc5:
	ld hl, $14
	call LoadTxRam3
	ld de, $112
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
; 0x6aff0

Func_6aff0:
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
; 0x6b00b

Func_6b00b:
	ld a, $0a
	ld de, $14
	call Func_680dd
	ret
; 0x6b014

Func_6b014:
	ld hl, $a
	call LoadTxRam3
	ld de, $113
	ld a, $02
	call Func_68069
	call ATimes10
	call Func_6817e
	ret
; 0x6b029

Func_6b029:
	ld a, $24
	call Func_68127
	ret
; 0x6b02f

Func_6b02f:
	ld bc, $200
	call Func_68e8f
	ret
; 0x6b036

Func_6b036:
	ld de, $110
	call TossCoin_Bank1a
	ldh [hTemp_ffa0], a
	ret c
	ld a, $cc
	ld [wLoadedAttackAnimation], a
	ret
; 0x6b045

Func_6b045:
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
; 0x6b059

Func_6b059:
	farcall Func_2435f
	ret
; 0x6b05e

Func_6b05e:
	ld hl, $16d
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
; 0x6b07c

Func_6b07c:
	ld bc, $101
	call Func_68e88
	ret
; 0x6b083

Func_6b083:
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
; 0x6b097

Func_6b097:
	xor a
	call CreateArenaOrBenchEnergyCardList
	bank1call SortCardsInDuelTempListByID
	ld a, [wDuelTempList]
	ldh [hTemp_ffa0], a
	ret
; 0x6b0a4

Func_6b0a4:
	xor a
	call CreateArenaOrBenchEnergyCardList
	xor a
	bank1call DisplayEnergyDiscardMenu
	bank1call HandleAttachedEnergyMenuInput
	ret c
	ldh a, [hTempCardIndex_ff98]
	ldh [hTemp_ffa0], a
	ret
; 0x6b0b5

Func_6b0b5:
	ldh a, [hTemp_ffa0]
	jp Func_0ffa
; 0x6b0ba

Func_6b0ba:
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
; 0x6b0da

Func_6b0da:
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
; 0x6b0f4

Func_6b0f4:
	call CreateDeckCardList
	ld hl, $1aa
	ld bc, $1ab
	ld de, $82
	ld a, $05
	farcall Func_24c9d
	jr c, .asm_6b112
	ld hl, $1ac
	ld de, $b0
	farcall Func_24df8
.asm_6b112
	ldh [hTemp_ffa0], a
	ret
; 0x6b115

Func_6b115:
	ld de, $82
	ld a, $05
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
; 0x6b131

Func_6b131:
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
; 0x6b149

Func_6b149:
	scf
	ret
; 0x6b14b

Func_6b14b:
	call Func_68027
	ret
; 0x6b14f

Func_6b14f:
	call Func_6a87d
	ret
; 0x6b153

Func_6b153:
	call Func_6a877
	ret
; 0x6b157

Func_6b157:
	call Func_6a8a5
	ret
; 0x6b15b

Func_6b15b:
	ld a, $05
	ld de, $a
	call Func_680b6
	ret
; 0x6b164

Func_6b164:
	ld de, $ff
	call TossCoin_Bank1a
	jr nc, .asm_6b170
	call Func_68012
	ret
.asm_6b170
	ld a, $01
	ld [wLoadedAttackAnimation], a
	ret
; 0x6b176

Func_6b176:
	ld a, $0a
	call Func_68175
	ret
; 0x6b17c

Func_6b17c:
	call Func_68686
	ret
; 0x6b180

Func_6b180:
	jr Func_6b18d

Func_6b182:
	jr Func_6b193

Func_6b184:
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
; 0x6b1f3

Func_6b1f3:
	call Func_68012
	ret
; 0x6b1f7

Func_6b1f7:
	call SwapTurn
	ld de, $a
	bank1call Func_6f37
	ld a, e
	call Func_680f9
	call SwapTurn
	ret
; 0x6b208

Func_6b208:
	scf
	ret
; 0x6b20a

Func_6b20a:
	call SwapTurn
	bank1call HasAlivePokemonInPlayArea
.asm_6b210
	bank1call OpenPlayAreaScreenForSelection
	jr c, .asm_6b210
	ldh [hTemp_ffa0], a
	call SwapTurn
	ret
; 0x6b21b

Func_6b21b:
	call SwapTurn
	ldh a, [hTemp_ffa0]
	ld b, a
	ld de, $a
	call DealDamageToPlayAreaPokemon_RegularAnim
	call SwapTurn
	bank1call Func_6518
	ret
; 0x6b22e

Func_6b22e:
	ld a, $14
	call Func_68175
	ret
; 0x6b234

Func_6b234:
	call Func_68686
	ret
; 0x6b238

Func_6b238:
	call Func_686be
	ldh [hTemp_ffa0], a
	ret
; 0x6b23e

Func_6b23e:
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
; 0x6b252

Func_6b252:
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
; 0x6b267

Func_6b267:
	call Func_6805c
	ret
; 0x6b26b

Func_6b26b:
	ld a, $0a
	ld de, $a0a
	call Func_680b6
	ret
; 0x6b274

Func_6b274:
	call Func_68012
	ret
; 0x6b278

Func_6b278:
	call Func_6844f
	ret
; 0x6b27c

Func_6b27c:
	call Func_68465
	ld de, $11e
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
; 0x6b2c1

Func_6b2c1:
	ld a, $0a
	ld de, $a0a
	call Func_680b6
	ret
; 0x6b2ca

Func_6b2ca:
	call Func_68012
	ret
; 0x6b2ce

Func_6b2ce:
	scf
	ret
; 0x6b2d0

Func_6b2d0:
	ld a, $2d
	ld de, $5a
	call Func_680dd
	ret
; 0x6b2d9

Func_6b2d9:
	ld hl, $1e
	call LoadTxRam3
	ld a, $03
	ld de, $113
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
; 0x6b2fe

Func_6b2fe:
	ld a, $0a
	ld de, $a0a
	call Func_680b6
	ret
; 0x6b307

Func_6b307:
	call Func_68012
	ret
; 0x6b30b

Func_6b30b:
	ld a, $14
	ld de, $a1e
	call Func_680dd
	ret
; 0x6b314

Func_6b314:
	ld de, $101
	call TossCoin_Bank1a
	ret nc
	ld a, $14
	call Func_68163
	call Func_6802e
	ret
; 0x6b324

Func_6b324:
	scf
	ret
; 0x6b326

Func_6b326:
	ld a, $1e
	ld de, $1e1e
	call Func_680b6
	ret
; 0x6b32f

Func_6b32f:
	call Func_68012
	ret
; 0x6b333

Func_6b333:
	ld a, $05
	ld de, $a
	call Func_680b6
	ret
; 0x6b33c

Func_6b33c:
	call Func_6800b
	ret
; 0x6b340

Func_6b340:
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
; 0x6b357

Func_6b357:
	call SwapTurn
	call Func_6b389
	call SwapTurn
	call Func_6806e
	call Func_6b389
	call Func_68074
	ret
; 0x6b36a

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
; 0x6b389

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
; 0x6b3cc

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
; 0x6b3fa

Func_6b3fa:
	ld de, $100
	call TossCoin_Bank1a
	jr c, .asm_6b406
	call Func_6802e
	ret
.asm_6b406
	call Func_68012
	ret
; 0x6b40a

Func_6b40a:
	call Func_68446
	ret
; 0x6b40e

Func_6b40e:
	ld hl, $165
	call DrawWideTextBox_WaitForInput
	bank1call HasAlivePokemonInBench
.asm_6b417
	bank1call OpenPlayAreaScreenForSelection
	jr c, .asm_6b417
	ldh [hTemp_ffa0], a
	ret
; 0x6b41f

Func_6b41f:
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
; 0x6b44d

Func_6b44d:
	call Func_68027
	ret
; 0x6b451

Func_6b451:
	call Func_6844f
	ret c
	farcall Func_2435f
	ret c
	ld a, DUELVARS_NUMBER_OF_CARDS_IN_HAND
	get_turn_duelist_var
	ld hl, $bf
	cp $01
	ret
; 0x6b463

Func_6b463:
	call CreateHandCardList
	bank1call Func_5221
	bank1call DisplayCardList
	ret c
	ldh [hTempPlayAreaLocation_ffa1], a
	ret
; 0x6b470

Func_6b470:
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
; 0x6b4a4

Func_6b4a4:
	ld hl, $ccca
	set 7, [hl]
	ret
; 0x6b4aa

Func_6b4aa:
	ld a, $ff
	ldh [hTemp_ffa0], a
	call Func_68446
	ret c
	ld hl, $1ae
	call YesOrNoMenuWithText
	ret c
	bank1call HasAlivePokemonInBench
.asm_6b4bc
	bank1call OpenPlayAreaScreenForSelection
	jr c, .asm_6b4bc
	ldh [hTemp_ffa0], a
	ret
; 0x6b4c4

Func_6b4c4:
	ld a, $ff
	ldh [hTemp_ffa0], a
	ret
; 0x6b4c9

Func_6b4c9:
	ldh a, [hTemp_ffa0]
	cp $ff
	ret nz
	ld a, $19
	ld [wLoadedAttackAnimation], a
	ret
; 0x6b4d4

Func_6b4d4:
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
; 0x6b4fd

Func_6b4fd:
	ld hl, $ccca
	set 7, [hl]
	ret
; 0x6b503

Func_6b503:
	farcall Func_2435f
	ret
; 0x6b508

Func_6b508:
	call CreateDeckCardList
	ld hl, $1af
	ld bc, $1b0
	ld a, $07
	farcall Func_24c9d
	jr c, .asm_6b523
	ld hl, $1b1
	ld de, $b0
	farcall Func_24df8
.asm_6b523
	ldh [hTemp_ffa0], a
	ret
; 0x6b526

Func_6b526:
	ld a, $07
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
; 0x6b53f

Func_6b53f:
	ldh a, [hTemp_ffa0]
	cp $ff
	jr z, .asm_6b54b
	call SearchCardInDeckAndAddToHand
	get_turn_duelist_var
	ld [hl], $10
.asm_6b54b
	call Func_680a0
	ret
; 0x6b54f

Func_6b54f:
	scf
	ret
; 0x6b551

Func_6b551:
	call Func_68346
	jr nc, .asm_6b55e
	call DrawWideTextBox_WaitForInput
	ld a, $ff
	ldh [hTemp_ffa0], a
	ret
.asm_6b55e
	xor a
	ldh [$ffb2], a
	ld hl, $1c4
	call DrawWideTextBox_WaitForInput
.asm_6b567
	bank1call Func_5221
	ld hl, $1e8
	ld de, $ad
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
	ldh a, [$ffb2]
	cp $03
	jr c, .asm_6b567
.asm_6b596
	farcall Func_24350
	ld [hl], $ff
	or a
	ret
; 0x6b59e

Func_6b59e:
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
; 0x6b5c2

Func_6b5c2:
	ld a, $28
	ld de, $28
	call Func_680dd
	ret
; 0x6b5cb

Func_6b5cb:
	ld de, $10d
	call TossCoin_Bank1a
	ret c
	xor a
	ld [wLoadedAttackAnimation], a
	call Func_6817e
	call Func_6809a
	ret
; 0x6b5dd

Func_6b5dd:
	call Func_6844f
	ret
; 0x6b5e1

Func_6b5e1:
	call Func_68465
	ld de, $11f
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
; 0x6b626

Func_6b626:
	call Func_6805c
	ret
; 0x6b62a

Func_6b62a:
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
; 0x6b640

Func_6b640:
	call Func_6843b
	ret
; 0x6b644

Func_6b644:
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
	ld de, $120
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
; 0x6b679

Func_6b679:
	ld a, $0a
	call Func_68175
	ret
; 0x6b67f

Func_6b67f:
	call Func_68686
	ret
; 0x6b683

Func_6b683:
	call Func_686be
	ldh [hTemp_ffa0], a
	ret
; 0x6b689

Func_6b689:
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
; 0x6b69d

Func_6b69d:
	ldh a, [hTemp_ffa0]
	or a
	ret z
	call SwapTurn
	ld b, a
	ld de, $a
	call DealDamageToPlayAreaPokemon_RegularAnim
	call SwapTurn
	ret
; 0x6b6af

Func_6b6af:
	scf
	ret
; 0x6b6b1

Func_6b6b1:
	ld a, $1e
	ld de, $1428
	call Func_680dd
	ret
; 0x6b6ba

Func_6b6ba:
	ld hl, $14
	call LoadTxRam3
	call SwapTurn
	ld de, $121
	call TossCoin_Bank1a
	call SwapTurn
	jr c, .asm_6b6d3
	ld a, $14
	call Func_68163
.asm_6b6d3
	ret
; 0x6b6d4

Func_6b6d4:
	call SwapTurn
	farcall Func_2435f
	call SwapTurn
	ret
; 0x6b6df

Func_6b6df:
	call SwapTurn
	call Func_680a0
	call SwapTurn
	ret
; 0x6b6e9

Func_6b6e9:
	ld a, $1e
	ld de, $1428
	call Func_680dd
	ret
; 0x6b6f2

Func_6b6f2:
	ld a, $14
	call Func_682e0
	ret
; 0x6b6f8

Func_6b6f8:
	scf
	ret
; 0x6b6fa

Func_6b6fa:
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
; 0x6b717

Func_6b717:
	call Func_6b6fa
	call SwapTurn
	call Func_68045
	call SwapTurn
	ret
; 0x6b724

Func_6b724:
	call Func_6843b
	ret
; 0x6b728

Func_6b728:
	call SwapTurn
	bank1call HasAlivePokemonInBench
.asm_6b72e
	bank1call OpenPlayAreaScreenForSelection
	jr c, .asm_6b72e
	call SwapTurn
	ldh [hTemp_ffa0], a
	ret
; 0x6b739

Func_6b739:
	call Func_6869d
	ldh [hTemp_ffa0], a
	ret
; 0x6b73f

Func_6b73f:
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
; 0x6b773

Func_6b773:
	call HandleMandatorySwitchSelection
	ldh a, [hTempPlayAreaLocation_ff9d]
	ldh [hTemp_ffa0], a
	ret
; 0x6b77b

Func_6b77b:
	ldh a, [hTemp_ffa0]
	call Func_6828a
	ret
; 0x6b781

Func_6b781:
	call Func_6843b
	ret
; 0x6b785

Func_6b785:
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
	ld hl, $1fc
	call DrawWideTextBox_WaitForInput
	call Func_680a0
	call SwapTurn
	ret
; 0x6b7cc

Func_6b7cc:
	call Func_6844f
	ret c
	farcall Func_2435f
	ret
; 0x6b7d5

Func_6b7d5:
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
	ld hl, $1b2
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
; 0x6b823

Func_6b823:
	ld a, $0f
	ld de, $a14
	call Func_680dd
	ret
; 0x6b82c

Func_6b82c:
	ld a, $0a
	call Func_682e0
	ret
; 0x6b832

Func_6b832:
	ld a, $32
	ld de, $32
	call Func_680dd
	ret
; 0x6b83b

Func_6b83b:
	ld de, $10d
	call TossCoin_Bank1a
	ret c
	xor a
	ld [wLoadedAttackAnimation], a
	call Func_6817e
	call Func_6809a
	ret
; 0x6b84d

Func_6b84d:
	call Func_6808d
	ret
; 0x6b851

Func_6b851:
	ld a, $14
	call Func_6817e
	ret
; 0x6b857

Func_6b857:
	ld de, $105
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
; 0x6b871

Func_6b871:
	ld de, $105
	call Func_68079
	ldh [hTemp_ffa0], a
	ret nc
	call Func_686be
	ldh [hTempPlayAreaLocation_ffa1], a
	ret
; 0x6b880

Func_6b880:
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
; 0x6b8a1

Func_6b8a1:
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
; 0x6b8bc

Func_6b8bc:
	jr Func_6b8c6

Func_6b8be:
	jr Func_6b8dc

Func_6b8c0:
	jr Func_6b8cd

Func_6b8c2:
	jr Func_6b8f6

Func_6b8c4:
	jr Func_6b901

Func_6b8c6:
	call Func_6808d
	call Func_6843b
	ret

Func_6b8cd:
	ld de, $10d
	call Func_68079
	ldh [hTemp_ffa0], a
	ret nc
	call Func_6869d
	ldh [hTempPlayAreaLocation_ffa1], a
	ret

Func_6b8dc:
	ld de, $10d
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
; 0x6b91e

Func_6b91e:
	ld a, $05
	ld de, $a
	call Func_680b6
	ret
; 0x6b927

Func_6b927:
	call Func_6800b
	ret
; 0x6b92b

Func_6b92b:
	ld a, $02
	call Func_6812e
	ret
; 0x6b931

Func_6b931:
	call Func_6aa2e
	ret
; 0x6b935

Func_6b935:
	call Func_6aa44
	ret
; 0x6b939

Func_6b939:
	call Func_6aae2
	ret
; 0x6b93d

Func_6b93d:
	call Func_6aa4f
	ret
; 0x6b941

Func_6b941:
	call Func_6803e
	ret
; 0x6b945

Func_6b945:
	call Func_68027
	ret
; 0x6b949

Func_6b949:
	call Func_6844f
	ret c
	farcall Func_2435f
	ret
; 0x6b952

Func_6b952:
	call CreateDeckCardList
	ld hl, $1b3
	ld bc, $1b4
	ld a, $08
	farcall Func_24c9d
	jr c, .asm_6b96d
	ld hl, $1b5
	ld de, $b0
	farcall Func_24df8
.asm_6b96d
	ldh [hTempPlayAreaLocation_ffa1], a
	or a
	ret
; 0x6b971

Func_6b971:
	call Func_68465
	ldh a, [hTempPlayAreaLocation_ffa1]
	cp $ff
	jr z, .asm_6b98d
	call SearchCardInDeckAndAddToHand
	call AddCardToHand
	call Func_680ab
	jr c, .asm_6b98d
	ldh a, [hTempPlayAreaLocation_ffa1]
	ld hl, $200
	bank1call DisplayCardDetailScreen
.asm_6b98d
	call Func_680a0
	ret
; 0x6b991

Func_6b991:
	ld a, $1e
	ld de, $1428
	call Func_680dd
	ret
; 0x6b99a

Func_6b99a:
	ld a, $14
	call Func_682e0
	ret
; 0x6b9a0

Func_6b9a0:
	scf
	ret
; 0x6b9a2

Func_6b9a2:
	ld a, $ff
	ldh [hTemp_ffa0], a
	call CreateDeckCardList
	jr c, .asm_6b9cb
	farcall Func_24369
	jr nc, .asm_6b9d2
	call DrawWideTextBox_WaitForInput
	ld hl, $193
	call YesOrNoMenuWithText_SetCursorToYes
	ret c
	ld a, $ff
	ld [$cd20], a
	ld hl, $1c7
	ld de, $b0
	farcall Func_24df8
	ret
.asm_6b9cb
	ld hl, $ba
	call DrawWideTextBox_WaitForInput
	ret
.asm_6b9d2
	ld hl, $1c5
	ld bc, $1c6
	ld a, $0e
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
	ld [$cd1f], a
	xor a
	ldh [$ffb2], a
.asm_6b9f2
	bank1call Func_5221
	ld hl, $1c7
	ld de, $b0
	bank1call SetCardListHeaderAndInfoText
.asm_6b9fe
	bank1call DisplayCardList
	jr nc, .asm_6ba13
	ld a, [$cd20]
	or a
	jr nz, .asm_6ba2f
	ld a, [$cd1f]
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
	ldh a, [$ffb2]
	ld hl, $cd1f
	cp [hl]
	jr c, .asm_6b9f2
.asm_6ba2f
	farcall Func_24350
	ld [hl], $ff
	ret
; 0x6ba36

Func_6ba36:
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
	ld hl, $64
	bank1call DisplayCardDetailScreen
	pop hl
	jr .asm_6ba39
.asm_6ba5c
	call Func_680a0
	ret
; 0x6ba60

Func_6ba60:
	ld a, $46
	ld de, $46
	call Func_680dd
	ret
; 0x6ba69

Func_6ba69:
	ld de, $10d
	call TossCoin_Bank1a
	ret c
	xor a
	ld [wLoadedAttackAnimation], a
	call Func_6817e
	call Func_6809a
	ret
; 0x6ba7b

Func_6ba7b:
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
; 0x6ba9e

Func_6ba9e:
	ld hl, $ccca
	set 7, [hl]
	ret
; 0x6baa4

Func_6baa4:
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
; 0x6babb

Func_6babb:
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
; 0x6bae8

Func_6bae8:
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
; 0x6bb19

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
; 0x6bb51

Func_6bb51:
	ld e, $00
	call GetPlayAreaCardAttachedEnergies
	ld a, [wTotalAttachedEnergies]
	or a
	ret nz
	ld hl, $2e
	scf
	ret
; 0x6bb60

Func_6bb60:
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
	call Func_6bbd7
	jr .asm_6bb71
.asm_6bb88
	xor a
	call CreateArenaOrBenchEnergyCardList
	jr c, .asm_6bbba
	bank1call InitAndDrawCardListScreenLayout
	ld hl, $b4
	ld de, $21
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
; 0x6bbd7

Func_6bbd7:
	ldh a, [hTempPlayAreaLocation_ffa1]
	ld e, a
	ldh a, [hTemp_ffa0]
	call AddCardToHand
	call PutHandCardInPlayArea
	bank1call PrintPlayAreaCardList_EnableLCD
	ret
; 0x6bbe6

Func_6bbe6:
	ld a, $0c
	call Func_6812e
	ret
; 0x6bbec

Func_6bbec:
	ld de, $142
	call TossCoin_Bank1a
	ldh [hTemp_ffa0], a
	ret nc
	call Func_6802e
	ret
; 0x6bbf9

Func_6bbf9:
	ldh a, [hTemp_ffa0]
	or a
	ret nz
	ld a, $0a
	call DealRecoilDamageToSelf
	ret
; 0x6bc03

Func_6bc03:
	ld a, $0a
	ld de, $a0a
	call Func_680b6
	ret
; 0x6bc0c

Func_6bc0c:
	call Func_68012
	ret
; 0x6bc10

Func_6bc10:
	call Func_6803e
	ret
; 0x6bc14

Func_6bc14:
	ld a, $0a
	ld de, $a0a
	call Func_680b6
	ret
; 0x6bc1d

Func_6bc1d:
	call Func_68012
	ret
; 0x6bc21

Func_6bc21:
	call Func_68027
	ret
; 0x6bc25

Func_6bc25:
	ld a, $05
	ld de, $a
	call Func_680b6
	ret
; 0x6bc2e

Func_6bc2e:
	call Func_6800b
	ret
; 0x6bc32

Func_6bc32:
	call Func_6805c
	ret
; 0x6bc36

Func_6bc36:
	call Func_6803e
	ret
; 0x6bc3a

Func_6bc3a:
	ld a, $14
	ld de, $1414
	call Func_680b6
	ret
; 0x6bc43

Func_6bc43:
	call Func_68012
	ret
; 0x6bc47

Func_6bc47:
	call Func_68027
	ret
; 0x6bc4b

Func_6bc4b:
	call Func_68027
	ret
; 0x6bc4f

Func_6bc4f:
	call Func_6801c
	ret
; 0x6bc53

Func_6bc53:
	call Func_6804a
	ret
; 0x6bc57

Func_6bc57:
	call Func_68027
	ret
; 0x6bc5b

Func_6bc5b:
	ld a, $05
	ld de, $a
	call Func_680b6
	ret
; 0x6bc64

Func_6bc64:
	call Func_6800b
	ret
; 0x6bc68

Func_6bc68:
	call Func_68027
	ret
; 0x6bc6c

Func_6bc6c:
	call Func_6803e
	ret
; 0x6bc70

Func_6bc70:
	call Func_68027
	ret
; 0x6bc74

Func_6bc74:
	call Func_68027
	ret
; 0x6bc78

Func_6bc78:
	call Func_68027
	ret
; 0x6bc7c

Func_6bc7c:
	call Func_68027
	ret
; 0x6bc80

Func_6bc80:
	call Func_68027
	ret
; 0x6bc84

Func_6bc84:
	call Func_68055
	ret
; 0x6bc88

Func_6bc88:
	call Func_6804a
	ret
; 0x6bc8c

Func_6bc8c:
	call Func_68033
	ret
; 0x6bc90

Func_6bc90:
	call Func_68027
	ret
; 0x6bc94

Func_6bc94:
	call Func_68027
	ret
; 0x6bc98

Func_6bc98:
	call Func_6803e
	ret
; 0x6bc9c

Func_6bc9c:
	call Func_68027
	ret
; 0x6bca0

Func_6bca0:
	call Func_68027
	ret
; 0x6bca4

Func_6bca4:
	call Func_6803e
	ret
; 0x6bca8

Func_6bca8:
	call Func_68033
	ret
; 0x6bcac

Func_6bcac:
	ld a, $05
	ld de, $a
	call Func_680b6
	ret
; 0x6bcb5

Func_6bcb5:
	call Func_6800b
	ret
; 0x6bcb9

Func_6bcb9:
	ld a, $05
	ld de, $a
	call Func_680b6
	ret
; 0x6bcc2

Func_6bcc2:
	call Func_6800b
	ret
; 0x6bcc6

Func_6bcc6:
	call Func_6803e
	ret
; 0x6bcca

Func_6bcca:
	call Func_68027
	ret
; 0x6bcce

Func_6bcce:
	ld a, $05
	ld de, $a
	call Func_680b6
	ret
; 0x6bcd7

Func_6bcd7:
	call Func_6800b
	ret
; 0x6bcdb

Func_6bcdb:
	call Func_68027
	ret
; 0x6bcdf

Func_6bcdf:
	ld a, DUELVARS_ARENA_CARD_LAST_TURN_DAMAGE
	get_turn_duelist_var
	ld a, [hl]
	ld [wAIMinDamage], a
	ld [wAIMaxDamage], a
	ret
; 0x6bcea

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
; 0x6bd10

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
; 0x6bd2c

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
; 0x6bd4b

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
; 0x6bd76

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
; 0x6bd85

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
; 0x6bde7

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
; 0x6be45

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
	ld hl, $16a
	call DrawWideTextBox_PrintText
	call SwapTurn
	ret
; 0x6be91

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
; 0x6beba
