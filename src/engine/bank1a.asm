SECTION "Bank 1a@4065", ROMX[$4065], BANK[$1a]

TossCoin_Bank1a:
	call TossCoin
	ret
; 0x68069

SECTION "Bank 1a@4079", ROMX[$4079], BANK[$1a]

; input:
; - de = text ID
Func_68079:
	ld a, 1
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

SECTION "Bank 1a@409a", ROMX[$409a], BANK[$1a]

Func_6809a:
	ld a, $02
	ld [wEffectFailed], a
	ret
; 0x680a0

SECTION "Bank 1a@42f4", ROMX[$42f4], BANK[$1a]

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

SECTION "Bank 1a@457e", ROMX[$457e], BANK[$1a]

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
