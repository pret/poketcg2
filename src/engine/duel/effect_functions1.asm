; unreferenced
Poison50PercentOrNoEffect:
	ldtx de, PoisonInflictionCheckText
	call TossCoin_Bank1a
	jr c, PoisonEffect
	jp SetNoEffectFromStatus

Poison50PercentEffect:
	ldtx de, PoisonInflictionCheckText
	call TossCoin_Bank1a
	ret nc

PoisonEffect:
	lb bc, CNF_SLP_PRZ, POISONED
	jr QueueStatusCondition

DoublePoisonEffect:
	lb bc, CNF_SLP_PRZ, DOUBLE_POISONED
	jr QueueStatusCondition

Paralysis50PercentOrNoEffect:
	ldtx de, ParalysisInflictionCheckText
	call TossCoin_Bank1a
	jr c, ParalysisEffect
	jp SetNoEffectFromStatus

Paralysis50PercentEffect:
	ldtx de, ParalysisInflictionCheckText
	call TossCoin_Bank1a
	ret nc

ParalysisEffect:
	lb bc, PSN_DBLPSN, PARALYZED
	jr QueueStatusCondition

Confusion50PercentOrNoEffect:
	ldtx de, ConfusionInflictionCheckText
	call TossCoin_Bank1a
	jr c, ConfusionEffect
	jp SetNoEffectFromStatus

Confusion50PercentEffect:
	ldtx de, ConfusionInflictionCheckText
	call TossCoin_Bank1a
	ret nc

ConfusionEffect:
	lb bc, PSN_DBLPSN, CONFUSED
	jr QueueStatusCondition

Sleep50PercentOrNoEffect:
	ldtx de, SleepInflictionCheckText
	call TossCoin_Bank1a
	jr c, SleepEffect
	jp SetNoEffectFromStatus

Sleep50PercentEffect:
	ldtx de, SleepInflictionCheckText
	call TossCoin_Bank1a
	ret nc

SleepEffect:
	lb bc, PSN_DBLPSN, ASLEEP
	jr QueueStatusCondition

QueueStatusCondition:
	bank1call _QueueStatusCondition
	ret

TossCoin_Bank1a:
	call TossCoin
	ret

TossCoinATimes_Bank1a:
	call TossCoinATimes
	ret

	ret ; stray ret

SetIsDamageToSelf:
	ld a, TRUE
	ld [wIsDamageToSelf], a
	ret

UnsetIsDamageToSelf:
	xor a
	ld [wIsDamageToSelf], a
	ret

Serial_TossCoin:
	ld a, 1
;	fallthrough

; input:
; - a = number of coin flips
; - de = text ID
; output:
; - a = number of heads
Serial_TossCoinATimes:
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

; sets wcd0d to TRUE
; still not sure what wcd0d is, might have something to do
; with syncing with the Link Opponent in specific effect commands
Func_6808d:
	ld a, TRUE
	ld [wcd0d], a
	or a
	ret

SetNoEffectFromStatus:
	ld a, EFFECT_FAILED_NO_EFFECT
	ld [wEffectFailed], a
	ret

SetWasUnsuccessful:
	ld a, EFFECT_FAILED_UNSUCCESSFUL
	ld [wEffectFailed], a
	ret

ShuffleCardsInDeck:
	call ExchangeRNG
	farcall PlayDeckShuffleAnimation
	bank1call ShuffleDeck
	ret

; return carry if Player is the Turn Duelist
IsPlayerTurn:
	ld a, DUELVARS_DUELIST_TYPE
	get_turn_duelist_var
	cp DUELIST_TYPE_PLAYER
	jr z, .player
	or a
	ret
.player
	scf
	ret

; Stores information about the attack damage for AI purposes
; taking into account poison damage between turns.
; if target poisoned
;	[wAIMinDamage] <- [wDamage]
;	[wAIMaxDamage] <- [wDamage]
; else
;	[wAIMinDamage] <- [wDamage] + d
;	[wAIMaxDamage] <- [wDamage] + e
;	[wDamage]      <- [wDamage] + a
UpdateExpectedAIDamage_AccountForPoison:
	push af
	ld a, DUELVARS_ARENA_CARD_STATUS
	call GetNonTurnDuelistVariable
	and POISONED | DOUBLE_POISONED
	jr z, UpdateExpectedAIDamage.skip_push_af
	pop af
	ld a, [wDamage]
	ld [wAIMinDamage], a
	ld [wAIMaxDamage], a
	ret

; Sets some variables for AI use
;	[wAIMinDamage] <- [wDamage] + d
;	[wAIMaxDamage] <- [wDamage] + e
;	[wDamage]      <- [wDamage] + a
UpdateExpectedAIDamage:
	push af

.skip_push_af
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

; Stores information about the attack damage for AI purposes
; [wDamage]      <- a (average amount of damage)
; [wAIMinDamage] <- d (minimum)
; [wAIMaxDamage] <- e (maximum)
SetExpectedAIDamage:
	ld [wDamage], a
	xor a
	ld [wDamage + 1], a
	ld a, d
	ld [wAIMinDamage], a
	ld a, e
	ld [wAIMaxDamage], a
	ret

DrawPlayAreaScreenToShowChanges:
	ldh [hTempPlayAreaLocation_ff9d], a
	bank1call SetupPlayAreaScreen
	bank1call PrintPlayAreaCardList_EnableLCD
	bank1call InitAndPrintPlayAreaCardInformationAndLocation_WithTextBox
	ret

; deal damage to all the turn holder's benched Pokemon
; input: a = amount of damage to deal to each Pokemon
DealDamageToAllBenchedPokemon:
	ld e, a
	ld d, $00
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	ld c, a
	ld b, PLAY_AREA_ARENA
	jr .skip_to_bench
.loop
	push bc
	call DealDamageToPlayAreaPokemon_RegularAnim
	pop bc
.skip_to_bench
	inc b
	dec c
	jr nz, .loop
	ret

; handles effects which make it so that a specific attack next turn
; has boosted attack (either double or triple damage)
; always assumes that the second attack is the one being boosted
; input:
; - a = SUBSTATUS1_NEXT_TURN_DOUBLE_DAMAGE or SUBSTATUS1_NEXT_TURN_TRIPLE_DAMAGE
SetAttackDoubleOrTripleDamageNextTurn:
	call ApplySubstatus1ToAttackingCardAndSetCountdown
	; load card's data to copy attack's name
	ld hl, wTempCardID_ccc2
	ld e, [hl]
	inc hl
	ld d, [hl]
	call LoadCardDataToBuffer2_FromCardID
	ld hl, wLoadedCard2Atk2Name
	ld e, [hl]
	inc hl
	ld d, [hl]
	; store attack name's ID in duelist variable
	ld a, DUELVARS_ATTACK_NAME
	get_turn_duelist_var
	ld [hl], e
	inc hl
	ld [hl], d
	ret

; apply a status condition of type 1 identified by register a to the target
ApplySubstatus1ToAttackingCard:
	push af
	ld a, DUELVARS_ARENA_CARD_SUBSTATUS1
	get_turn_duelist_var
	pop af
	ld [hli], a
	ret

; apply a status condition of type 2 identified by register a to the target,
; unless prevented by wNoDamageOrEffect
ApplySubstatus2ToDefendingCard:
; if defending card is Clefairy Doll, don't apply substatus
	push af
	call SwapTurn
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call GetCardIDFromDeckIndex
	call SwapTurn
	cp16 CLEFAIRY_DOLL
	jr z, .clefairy_doll

	bank1call CheckNoDamageOrEffect
	jr c, .no_damage_or_effect
	ld a, DUELVARS_ARENA_CARD_SUBSTATUS2
	call GetNonTurnDuelistVariable
	pop af
	ld [hl], a
	ld l, DUELVARS_ARENA_CARD_LAST_TURN_SUBSTATUS2
	ld [hl], a
	ret

.no_damage_or_effect
	pop af
	push hl
	bank1call DrawDuelMainScene
	pop hl
	ld a, l
	or h
	call nz, DrawWideTextBox_PrintText
	ret

.clefairy_doll
	pop af
	ret

; [wDamage] += a
; also updates wAIMaxDamage and wAIMinDamage
AddToDamage:
	push hl
	ld hl, wDamage
	add [hl]
	ld [hli], a
	ld [wAIMaxDamage], a
	ld [wAIMinDamage], a
	ld a, 0
	adc [hl]
	ld [hl], a
	pop hl
	ret

SetDefiniteDamageAndSetUnaffectedByWR:
	call SetDefiniteDamage
	ld hl, wDamage + 1
	set UNAFFECTED_BY_WEAKNESS_RESISTANCE_F, [hl]
	ret

; overwrites in wDamage, wAIMinDamage and wAIMaxDamage
; with the value in a.
SetDefiniteDamage:
	ld [wDamage], a
	ld [wAIMinDamage], a
	ld [wAIMaxDamage], a
	xor a
	ld [wDamage + 1], a
	ret

; overwrites wAIMinDamage and wAIMaxDamage
; with value in wDamage.
SetDefiniteAIDamage:
	ld a, [wDamage]
	ld [wAIMinDamage], a
	ld [wAIMaxDamage], a
	ret

; returns in a some random occupied Play Area location
; in Turn Duelist's Play Area.
PickRandomPlayAreaCard:
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	call Random
	or a
	ret nz
	; if Arena card is chosen, remove residual flag
	ld hl, wLoadedAttackCategory
	res RESIDUAL_F, [hl]
	ret

CreateNonTurnDuelistArenaEnergyCardList:
	call SwapTurn
	xor a ; PLAY_AREA_ARENA
	call CreateArenaOrBenchEnergyCardList
	call SwapTurn
	ret

; lists all Fire energies on card in [hTempPlayAreaLocation_ff9d]
; considers Energy Burn and Rainbow energies
; returns list sorted by ID in wDuelTempList,
; and carry set if list is empty
GetListOfFireEnergiesFromPlayAreaCard:
	; first check if energy donor has Energy Burn
	ldh a, [hTempPlayAreaLocation_ff9d]
	add DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call GetCardIDFromDeckIndex
	cp16 CHARIZARD_LV76
	jr z, .has_energy_burn
	cp16 CHARIZARD_ALT_LV76
	jr z, .has_energy_burn
.no_energy_burn
	ldh a, [hTempPlayAreaLocation_ff9d]
	add CARD_LOCATION_ARENA
	ld [wce01], a
	ld a, TYPE_ENERGY_FIRE
	jr CreateListOfEnergyAttachedToPlayAreaCard
.has_energy_burn
	; can it use its Pkmn Power?
	ldh a, [hTempPlayAreaLocation_ff9d]
	bank1call CheckIsIncapableOfUsingPkmnPower
	jr c, .no_energy_burn
	; has active Energy Burn, can transfer any energy
	ldh a, [hTempPlayAreaLocation_ff9d]
	call CreateArenaOrBenchEnergyCardList
	ret

; creates in wDuelTempList list of attached Fire Energy cards
; that are attached to the Turn Duelist's Arena card.
CreateListOfFireEnergyAttachedToArena:
	ld a, TYPE_ENERGY_FIRE
	; fallthrough

; creates in wDuelTempList a list of cards that
; are in the Arena of the same type as input a.
; this is called to list Energy cards of a specific type
; that are attached to the Arena Pokemon.
; input:
;	a = TYPE_ENERGY_* constant
; output:
;	a = number of cards in list;
;	wDuelTempList filled with cards, terminated by $ff
;   carry set if no cards in list
CreateListOfEnergyAttachedToArena:
	push af
	ld a, CARD_LOCATION_ARENA
	ld [wce01], a
	pop af
;	fallthrough

CreateListOfEnergyAttachedToPlayAreaCard:
	ld b, a
	ld c, 0
	ld de, wDuelTempList
	ld a, DUELVARS_CARD_LOCATIONS
	get_turn_duelist_var
.loop
	ld a, [hl]
	push hl
	ld hl, wce01
	cp [hl]
	pop hl
	jr nz, .next
	push de
	ld a, l
	call GetCardIDFromDeckIndex
	cp16 RAINBOW_ENERGY
	jr nz, .not_rainbow
	pop de
	jr .add_card
.not_rainbow
	call GetCardType
	pop de
	cp b
	jr nz, .next
.add_card
	ld a, l
	ld [de], a
	inc de
	inc c
.next
	inc l
	ld a, l
	cp DECK_SIZE
	jr c, .loop

	ld a, $ff
	ld [de], a
	ld a, c
	push af
	bank1call SortCardsInDuelTempListByID
	pop af
	or a
	ret nz

	; has no cards
	scf
	ret

; creates a list of all basic cards attached to a given
; play area Pokémon, if none are found then carry set is returned
; input:
; - b = PLAY_AREA_* constant
; output:
; - wDuelTempList = list of cards found
; - carry set if list is empty
CreateListOfBasicEnergyCardsAttachedToPlayAreaCard:
	ld a, b
	or CARD_LOCATION_PLAY_AREA
	ld c, a
	ld de, wDuelTempList
	ld a, DUELVARS_CARD_LOCATIONS
	get_turn_duelist_var
.loop
	ld a, [hl]
	cp c
	jr nz, .next_card
	ld a, l
	call LoadCardDataToBuffer1_FromDeckIndex
	ld a, [wLoadedCard1Type]
	bit TYPE_ENERGY_F, a
	jr z, .next_card ; is not energy
	cp TYPE_ENERGY_DOUBLE_COLORLESS
	jr nc, .next_card ; is not basic
	; is basic energy card
	ld a, l
	ld [de], a
	inc de
.next_card
	inc l
	ld a, l
	cp DECK_SIZE
	jr c, .loop
	ld a, $ff ; terminating byte
	ld [de], a

	; any card in list?
	ld a, [wDuelTempList + 0]
	cp $ff
	jr z, .empty
	or a
	ret
.empty
	scf
	ret

; prints the text "<X> devolved to <Y>!" with
; the proper card names and levels.
; input:
;	d = deck index of the lower stage card
;	e = deck index of card that was devolved
PrintDevolvedCardNameAndLevelText:
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

	inc bc ; wTxRam2_b
	xor a
	ld [bc], a
	inc bc
	ld [bc], a

	ld a, d
	call LoadCardDataToBuffer1_FromDeckIndex
	ld a, 18
	call CopyCardNameAndLevel
	ld [hl], $00
	ldtx hl, PokemonDevolvedToText
	call DrawWideTextBox_WaitForInput
	pop de
	ret

; input:
; - a = PLAY_AREA_* constant of Bench Pokémon to switch to
HandleSwitchDefendingPokemonEffect:
	ld e, a
	cp $ff
	ret z ; none selected

	push de
	call HandleNoDamageOrEffect
	pop de
	ret c ; no effect

; attack was successful, switch Defending Pokemon
	ld a, e
	ld [wForcedSwitchPlayAreaLocation], a
	call SwapTurn
	call SwapArenaWithBenchPokemon
	call SwapTurn

	xor a
	ld [wccc5], a
	ld [wDuelDisplayedScreen], a
	ret

; called by attack effects that can target any card in the Play Area
; and the target chosen is the Arena card
; in this case, the residual flag needs to be reset and No Damage/Effect
; substatus needs to be handled
; return carry and zero damage output if Arena card is unaffected by attack
PreparePlayAreaAttackAgainstArena:
	ld hl, wLoadedAttackCategory
	res RESIDUAL_F, [hl]
	call SwapTurn
	bank1call HandleNoDamageOrEffectSubstatus
	call SwapTurn
	ret nc ; unaffected
	xor a
	call SetDefiniteDamage
	scf
	ret

; returns carry if Defending has No Damage or Effect
; if so, print its appropriate text.
HandleNoDamageOrEffect:
	call SwapTurn
	xor a
	ld [wTempPlayAreaLocation_cceb], a
	bank1call HandleTransparency
	call SwapTurn
	bank1call CheckNoDamageOrEffect
	ret nc
	ld a, l
	or h
	call nz, DrawWideTextBox_PrintText
	ld a, [wDuelDisplayedScreen]
	cp DUEL_MAIN_SCENE
	jr z, .skip_input_wait
	call WaitForWideTextBoxInput
.skip_input_wait
	scf
	ret

; adds damage given in register a to current damage
; if duelist gets heads
AddDamageIfHeads:
	ld l, a
	ld h, $00
	push hl
	call LoadTxRam3
	ldtx de, DamageCheckIfHeadsPlusDamageText
	call TossCoin_Bank1a
	pop hl
	ret nc ; return if tails
	ld a, l
	call AddToDamage
	ret

; applies HP recovery on Pokemon after an attack
; with HP recovery effect, and handles its animation.
; input:
;	de = HP amount to recover
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

; returns carry if Play Area has no damage counters.
CheckIfPlayAreaHasAnyDamage:
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	ld d, a
	ld e, PLAY_AREA_ARENA
.loop_play_area
	call GetCardDamageAndMaxHP
	or a
	ret nz ; found damage
	inc e
	dec d
	jr nz, .loop_play_area
	; no damage found
	scf
	ret

CreatePokemonCardListFromDiscardPile:
	bank1call IsBlackHoleRuleActive
	ret c ; Black Hole active

	ld a, DUELVARS_NUMBER_OF_CARDS_IN_DISCARD_PILE
	get_turn_duelist_var
	ld b, a
	add DUELVARS_DECK_CARDS
	ld l, a
	ld de, wDuelTempList
	inc b
	jr .next_card
.loop_discard_pile
	ld a, [hl]
	call LoadCardDataToBuffer2_FromDeckIndex
	ld a, [wLoadedCard2Type]
	cp TYPE_ENERGY
	jr nc, .next_card
	; is Pkmn, add card to list
	ld a, [hl]
	ld [de], a
	inc de
.next_card
	dec l
	dec b
	jr nz, .loop_discard_pile
	ld a, $ff ; terminating byte
	ld [de], a

	; check if got any cards in list
	ld a, [wDuelTempList]
	cp $ff
	jr z, .no_cards
	or a
	ret
.no_cards
	ldtx hl, NoPokemonInDiscardPileText
	scf
	ret

; makes a list in wDuelTempList with the deck indices
; of Basic Pokémon cards found in Turn Duelist's Discard Pile.
; returns carry set if no such cards found, or if
; Black Hole special rule is active
CreateBasicPkmnCardListFromDiscardPile:
	bank1call IsBlackHoleRuleActive
	ret c ; cannot access Discard Pile

	ld a, DUELVARS_NUMBER_OF_CARDS_IN_DISCARD_PILE
	get_turn_duelist_var
	ld b, a
	add DUELVARS_DECK_CARDS
	ld l, a
	ld de, wDuelTempList
	inc b
	jr .next_card
.loop_discard_pile
	ld a, [hl]
	call LoadCardDataToBuffer2_FromDeckIndex
	ld a, [wLoadedCard2Type]
	cp TYPE_ENERGY
	jr nc, .next_card
	ld a, [wLoadedCard2Stage]
	or a
	jr nz, .next_card
	; Basic Pkmn card, add it to wDuelTempList
	ld a, [hl]
	ld [de], a
	inc de
.next_card
	dec l
	dec b
	jr nz, .loop_discard_pile
	ld a, $ff ; terminating byte
	ld [de], a

	ld a, [wDuelTempList]
	cp $ff
	jr z, .empty_list
	or a
	ret
.empty_list
	ldtx hl, NoBasicPokemonInDiscardPileText
	scf
	ret

; makes a list in wDuelTempList with the deck indices
; of Trainer cards found in Turn Duelist's Discard Pile.
; returns carry set if no Trainer cards found, or if
; Black Hole special rule is active
CreateTrainerCardListFromDiscardPile:
	bank1call IsBlackHoleRuleActive
	ret c ; Black Hole active

; get number of cards in Discard Pile
; and have hl point to the end of the
; Discard Pile list in wOpponentDeckCards.
	ld a, DUELVARS_NUMBER_OF_CARDS_IN_DISCARD_PILE
	get_turn_duelist_var
	ld b, a
	add DUELVARS_DECK_CARDS
	ld l, a

	ld de, wDuelTempList
	inc b
	jr .next_card

.check_trainer
	ld a, [hl]
	call LoadCardDataToBuffer2_FromDeckIndex
	ld a, [wLoadedCard2Type]
	cp TYPE_TRAINER
	jr nz, .next_card

	ld a, [hl]
	ld [de], a
	inc de

.next_card
	dec l
	dec b
	jr nz, .check_trainer

	ld a, $ff ; terminating byte
	ld [de], a
	ld a, [wDuelTempList]
	cp $ff
	jr z, .no_trainers
	or a
	ret
.no_trainers
	ldtx hl, NoTrainerCardsInDiscardPileText
	scf
	ret

; makes a list in wDuelTempList with the deck indices
; of all special energy cards found in Turn Duelist's Discard Pile.
; unreferenced
UnreferencedCreateEnergyCardListFromDiscardPile_OnlySpecial:
	ld c, $2
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

; return carry if non-turn duelist does
; not have benched Pokémon
CheckNonTurnDuelistHasBench:
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	call GetNonTurnDuelistVariable
	ldtx hl, EffectNoBenchedPokemonText
	cp 2
	ret

; return carry if turn duelist does
; not have benched Pokémon
CheckIfTurnDuelistHasBench:
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	ldtx hl, EffectNoBenchedPokemonText
	cp 2
	ret

; returns carry if Pokémon in Play Area location
; in [hTempPlayAreaLocation_ff9d] already used its
; Pkmn Power this turn or if it's otherwise incapable
; of using it
; input:
; - [hTempPlayAreaLocation_ff9d] = PLAY_AREA_* location
; output:
; - hl = text ID of reason why it cannot use it
CheckIfCanUsePkmnPowerThisTurn:
	ldh a, [hTempPlayAreaLocation_ff9d]
	ldh [hTemp_ffa0], a
	add DUELVARS_ARENA_CARD_FLAGS
	get_turn_duelist_var
	and USED_PKMN_POWER_THIS_TURN
	jr nz, .already_used
	ldh a, [hTempPlayAreaLocation_ff9d]
	bank1call CheckIsIncapableOfUsingPkmnPower
	ret
.already_used
	ldtx hl, OnlyOncePerTurnText
	scf
	ret

SetUsedPkmnPowerThisTurnFlag:
	ldh a, [hTemp_ffa0]
	add DUELVARS_ARENA_CARD_FLAGS
	get_turn_duelist_var
	set USED_PKMN_POWER_THIS_TURN_F, [hl]
	ret

; input:
; - a = SUBSTATUS1_* constant
ApplySubstatus1ToAttackingCardAndSetCountdown:
	call ApplySubstatus1ToAttackingCard
	
	; set turn countdown to %01
	ld a, DUELVARS_ARENA_CARD_SUBSTATUS3
	get_turn_duelist_var
	set SUBSTATUS3_TURN_COUNTDOWN_LO_F, [hl]
	res SUBSTATUS3_TURN_COUNTDOWN_HI_F, [hl]
	ret

; check if turn-holder's arena card
; is affected by substatus given in a
; if yes, then it cannot use this attack
; input:
; - a = SUBSTATUS1_* constant
CheckIfHasSubstatusThatPreventsUsingAttack:
	ld e, a
	ld a, DUELVARS_ARENA_CARD_SUBSTATUS1
	get_turn_duelist_var
	cp e
	jr z, .cannot_use
	or a
	ret
.cannot_use
	ldtx hl, CannotUseThisTurnText
	scf
	ret

; handles the Player selection of attack
; to use, i.e. Amnesia or Metronome on.
; returns carry if none selected.
; outputs:
;	d = card index of defending card
;	e = attack index selected
HandleDefendingPokemonAttackSelection:
	bank1call DrawDuelMainScene
	call SwapTurn
	xor a
	ldh [hCurSelectionItem], a

.start
	bank1call PrintAndLoadAttacksToDuelTempList
	push af
	ldh a, [hCurSelectionItem]
	ld hl, .menu_parameters
	call InitializeMenuParameters
	pop af

	ld [wNumScrollMenuItems], a
	call EnableLCD
.loop_input
	call DoFrame
	ldh a, [hKeysPressed]
	bit B_PAD_B, a
	jr nz, .set_carry
	and PAD_START
	jr nz, .open_atk_page
	call HandleMenuInput
	jr nc, .loop_input
	cp -1
	jr z, .loop_input

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

.set_carry
	call SwapTurn
	scf
	ret

.open_atk_page
	ldh a, [hCurScrollMenuItem]
	ldh [hCurSelectionItem], a
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call LoadCardDataToBuffer1_FromDeckIndex
	bank1call OpenAttackPage
	call SwapTurn
	bank1call DrawDuelMainScene
	call SwapTurn
	jr .start

.menu_parameters
	db 1, 13 ; cursor x, cursor y
	db 2 ; y displacement between items
	db 2 ; number of items
	db SYM_CURSOR_R ; cursor tile number
	db SYM_SPACE ; tile behind cursor
	dw NULL ; function pointer if non-0

; loads in hl the pointer to attack's name.
; input:
;	d = deck index of card
; 	e = attack index (0 = first attack, 1 = second attack)
GetAttackName:
	ld a, d
	call LoadCardDataToBuffer1_FromDeckIndex
	ld hl, wLoadedCard1Atk1Name
	inc e
	dec e
	jr z, .load_name
	ld hl, wLoadedCard1Atk2Name
.load_name
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ret

; returns carry if Defending Pokemon has no attacks
CheckIfDefendingCardHasAnyAttacks:
	call SwapTurn
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call LoadCardDataToBuffer2_FromDeckIndex
	ld a, [wLoadedCard2Atk1Category]
	cp POKEMON_POWER
	jr nz, .has_attack
	ld hl, wLoadedCard2Atk2Name
	ld a, [hli]
	or [hl]
	jr nz, .has_attack
; has no attack
	call SwapTurn
	ldtx hl, NoAttacksMayBeChosenText
	scf
	ret
.has_attack
	call SwapTurn
	or a
	ret

; overwrites HP and Stage data of the card that was
; devolved in the Play Area to the values of new card.
; if the damage exceeds HP of pre-evolution,
; then HP is set to zero.
; input:
;	a = card index of pre-evolved card
UpdateDevolvedCardHPAndStage:
	push bc
	push de
	push af
	ldh a, [hTempPlayAreaLocation_ff9d]
	ld e, a
	call GetCardDamageAndMaxHP
	ld b, a ; store damage

	; set this card index to duelist's Play Area
	ld a, e
	add DUELVARS_ARENA_CARD
	get_turn_duelist_var
	pop af
	ld [hl], a

	; set this card location to Play Area
	call LoadCardDataToBuffer2_FromDeckIndex
	ld a, [hl]
	ld l, a ; card location
	ldh a, [hTempPlayAreaLocation_ff9d]
	or CARD_LOCATION_PLAY_AREA
	ld [hl], a

	ld a, e
	add DUELVARS_ARENA_CARD_HP
	ld l, a
	ld a, [wLoadedCard2HP]
	sub b ; subtract damage from new HP
	jr nc, .got_hp
	; damage exceeds HP
	xor a ; 0 HP
.got_hp
	ld [hl], a
	ld a, e
; overwrite card stage
	add DUELVARS_ARENA_CARD_STAGE
	ld l, a
	ld a, [wLoadedCard2Stage]
	ld [hl], a
	pop de
	pop bc
	ret

; reset various status after devolving card.
ResetDevolvedCardStatus:
	ldh a, [hTempPlayAreaLocation_ff9d]
	or a
	jr nz, .skip_clear_status
	call ClearAllStatusConditions
.skip_clear_status
; reset changed color status
	ldh a, [hTempPlayAreaLocation_ff9d]
	add DUELVARS_ARENA_CARD_CHANGED_TYPE
	get_turn_duelist_var
	ld [hl], $00
; reset flags
	ldh a, [hTempPlayAreaLocation_ff9d]
	add DUELVARS_ARENA_CARD_FLAGS
	ld l, a
	ld [hl], $00
	ret

; prompts the Player with a Yes/No question
; whether to quit the screen, even though
; they can select more cards from list.
; [hCurSelectionItem] holds number of cards
; that were already selected by the Player.
; input:
;	- a = total number of cards that can be selected
; output:
;	- carry set if "No" was selected
AskWhetherToQuitSelectingCards:
	ld hl, hCurSelectionItem
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
	call UpdateTempDuelistCardIDsAndClearTwoTurnDuelVars
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

; returns in a the card index of energy card
; attached to Defending Pokemon
; that is to be discarded by the AI for an effect.
; outputs -1 is none was found.
; output:
;	a = deck index of attached energy card chosen
_AIPickEnergyCardToDiscardFromDefendingPokemon:
	call SwapTurn
	ld e, PLAY_AREA_ARENA
	call GetPlayAreaCardAttachedEnergies

	xor a ; PLAY_AREA_ARENA
	call CreateArenaOrBenchEnergyCardList
	jr nc, .has_energy
	; no energy, return
	ld a, -1
	jr .done

.has_energy
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call LoadCardDataToBuffer1_FromDeckIndex
	ld e, COLORLESS
	ld a, [wAttachedEnergies + COLORLESS]
	or a
	jr nz, .pick_color ; has colorless attached?

	; no colorless energy attached.
	; if it's colorless Pokemon, just
	; pick any energy card at random...
	ld a, [wLoadedCard1Type]
	cp COLORLESS
	jr nc, .choose_random

	; ...if not, check if it has its
	; own color energy attached.
	; if it doesn't, pick at random.
	ld e, a
	ld d, $00
	ld hl, wAttachedEnergies
	add hl, de
	ld a, [hl]
	or a
	jr z, .choose_random

.pick_color
; pick attached card with same color as e
	ld hl, wDuelTempList
.loop_energy
	ld a, [hli]
	cp $ff
	jr z, .choose_random
	call LoadCardDataToBuffer2_FromDeckIndex
	ld a, [wLoadedCard2Type]
	and TYPE_PKMN
	cp e
	jr nz, .loop_energy
	dec hl

.done_chosen
	ld a, [hl]
.done
	call SwapTurn
	ret
.choose_random
	call CountCardsInDuelTempList
	ld hl, wDuelTempList
	call ShuffleCards
	jr .done_chosen

; handles AI logic to pick attack for Amnesia
AIPickAttackForAmnesia:
; load Defending Pokemon attacks
	call SwapTurn
	ld e, PLAY_AREA_ARENA
	call GetPlayAreaCardAttachedEnergies
	bank1call HandleEnergyBurn
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	ld d, a
	call LoadCardDataToBuffer2_FromDeckIndex
; if has no attack 1 name, return
	ld hl, wLoadedCard2Atk1Name
	ld a, [hli]
	or [hl]
	jr z, .chosen

; if Defending Pokemon has enough energy for second attack, choose it
	ld e, SECOND_ATTACK
	bank1call CheckIfEnoughEnergiesForGivenAttack
	jr nc, .chosen
; otherwise if first attack isn't a Pkmn Power, choose it instead.
	ld e, FIRST_ATTACK_OR_PKMN_POWER
	ld a, [wLoadedCard2Atk1Category]
	cp POKEMON_POWER
	jr nz, .chosen
; if it is a Pkmn Power, choose second attack.
	ld e, SECOND_ATTACK
.chosen
	ld a, e
	ldh [hTemp_ffa0], a
	call SwapTurn
	ret

; handles screen for player to select a bench Pokémon
; on opponent's side, and outputs selection in [hTemp_ffa0]
; if opponent has no bench Pokémon then return carry
HandlePlayerSelectOppBenchPkmn:
	ld a, $ff
	ldh [hTemp_ffa0], a
	call CheckNonTurnDuelistHasBench
	ret c ; no bench
	ldtx hl, ChooseBenchedPokemonToGiveDamageText
	call DrawWideTextBox_WaitForInput
	call SwapTurn
	bank1call HasAlivePokemonInBench
.loop_input
	bank1call OpenPlayAreaScreenForSelection
	jr c, .loop_input
	ldh a, [hTempPlayAreaLocation_ff9d]
	ldh [hTemp_ffa0], a
	call SwapTurn
	ret

; same as HandlePlayerSelectOppBenchPkmn but
; includes all Play Area cards
HandlePlayerSelectOppPlayAreaPkmn:
	ldtx hl, ChoosePokemonToGiveDamageText
	call DrawWideTextBox_WaitForInput
	call SwapTurn
	bank1call HasAlivePokemonInPlayArea
.select_pkmn
	bank1call OpenPlayAreaScreenForSelection
	jr c, .select_pkmn
	call SwapTurn
	ldh [hTemp_ffa0], a
	ret

; Return in a the PLAY_AREA_* of the non-turn holder's Pokemon card in bench with the lowest (remaining) HP.
; if multiple cards are tied for the lowest HP, the one with the highest PLAY_AREA_* is returned.
AIFindTargetForBenchAttack:
	call SwapTurn
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	ld c, a
	ld b, PLAY_AREA_ARENA
	lb de, PLAY_AREA_BENCH_1, 255
	ld a, DUELVARS_BENCH1_CARD_HP
	get_turn_duelist_var
	jr .start
; find Play Area location with least amount of HP
.loop_bench
	ld a, e
	cp [hl]
	jr c, .next ; skip if HP is higher
	ld e, [hl]
	ld d, b

.next
	inc hl
.start
	inc b
	dec c
	jr nz, .loop_bench
	ld a, d
	call SwapTurn
	ret

; attempts to find a suitable Play Area target for an attack on player's side
; if Arena card is unaffected by attacks, attempt to target Bench
; if Aurora Veil is active, target Arena card instead
; else, just find card with lowest remaining HP in whole Play Area
; outputs selection (PLAY_AREA_*) in a
AIFindTargetForPlayAreaAttack:
	; if Arena card is unaffected, check Bench instead
	call SwapTurn
	bank1call HandleNoDamageOrEffectSubstatus
	jr c, .arena_card_unaffected
	; try checking if can damage Bench
	ld a, PLAY_AREA_BENCH_1
	ldh [hTempPlayAreaLocation_ff9d], a
	bank1call CheckArticunoAuroraVeil
	jr c, .target_arena
	; find Play Area target with lowest remaining HP
	xor a
	ld [wNoDamageOrEffect], a
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	ld c, a
	lb de, PLAY_AREA_ARENA, 255
	ld b, PLAY_AREA_ARENA
	ld a, DUELVARS_ARENA_CARD_HP
	get_turn_duelist_var
.loop_play_area
	ld a, e
	cp [hl]
	jr c, .next_play_area
	ld e, [hl]
	ld d, b
.next_play_area
	inc hl
	inc b
	dec c
	jr nz, .loop_play_area
	ld a, d ; Play Area card with lowest remaining HP
	call SwapTurn
	ret

.arena_card_unaffected
	xor a
	ld [wNoDamageOrEffect], a
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	cp 2
	jr c, .target_arena
	; find Bench card with lowest remaining HP
	call SwapTurn
	jp AIFindTargetForBenchAttack

.target_arena
	; output PLAY_AREA_ARENA
	call SwapTurn
	xor a
	ld [wNoDamageOrEffect], a
	ret

; loads wTxRam2 and wTxRam2_b:
; [wTxRam2]   <- wLoadedCard1Name
; [wTxRam2_b] <- input color as text symbol
; input:
;	a = type (color) constant
LoadCardNameAndInputColor:
	add a
	ld e, a
	ld d, $00
	ld hl, .ColorToTextSymbol
	add hl, de

; load wTxRam2 with card's name
	ld de, wTxRam2
	ld a, [wLoadedCard1Name]
	ld [de], a
	inc de
	ld a, [wLoadedCard1Name + 1]
	ld [de], a

; load wTxRam2_b with .ColorToTextSymbol
	inc de
	ld a, [hli]
	ld [de], a
	inc de
	ld a, [hli]
	ld [de], a
	ret

.ColorToTextSymbol:
	tx FireSymbolText
	tx GrassSymbolText
	tx LightningSymbolText
	tx WaterSymbolText
	tx FightingSymbolText
	tx PsychicSymbolText

DrawSymbolOnPlayAreaCursor:
	ld c, a
	add a
	add c
	add 2
	; a = 3*a + 2
	ld c, a
	ld a, b
	ld b, 0
	call WriteByteToBGMap0
	ret

; unreferenced
Func_6873c:
	ldtx hl, IncompleteText
	call DrawWideTextBox_WaitForInput
	ret

PlayAreaSelectionMenuParameters:
	db 0, 0 ; cursor x, cursor y
	db 3 ; y displacement between items
	db MAX_PLAY_AREA_POKEMON ; number of items
	db SYM_CURSOR_R ; cursor tile number
	db SYM_SPACE ; tile behind cursor
	dw NULL ; function pointer if non-0

BenchSelectionMenuParameters:
	db 0, 3 ; cursor x, cursor y
	db 3 ; y displacement between items
	db MAX_PLAY_AREA_POKEMON ; number of items
	db SYM_CURSOR_R ; cursor tile number
	db SYM_SPACE ; tile behind cursor
	dw NULL ; function pointer if non-0

SpitPoison_AIEffect:
	ld a, 10 / 2
	lb de, 0, 10
	call SetExpectedAIDamage
	ret

; If heads, defending Pokemon becomes poisoned
SpitPoison_Poison50PercentEffect:
	ldtx de, PoisonInflictionCheckText
	call TossCoin_Bank1a
	jp c, PoisonEffect
	ld a, ATK_ANIM_SPIT_POISON_SUCCESS
	ld [wLoadedAttackAnimation], a
	call SetNoEffectFromStatus
	ret

EkansWrapEffect:
	call Paralysis50PercentEffect
	ret

TerrorStrike_InitialEffect:
	call Func_6808d
	ret

; outputs in hTemp_ffa0 the result of the coin toss (0 = tails, 1 = heads).
; in case it was heads, stores in hTempPlayAreaLocation_ffa1
; the PLAY_AREA_* location of the Bench Pokemon that was selected for switch.
TerrorStrike_50PercentSelectSwitchPokemon:
	xor a ; PLAY_AREA_ARENA
	ldh [hTemp_ffa0], a
	call CheckNonTurnDuelistHasBench
	ret c ; no bench

; toss coin and store whether it was tails (0) or heads (1) in hTemp_ffa0.
; return if it was tails.
	ldtx de, IfHeadsSwitchOutOpponentsActivePokemonText
	call Serial_TossCoin
	ldh [hTemp_ffa0], a
	ret nc

	call HandleMandatorySwitchSelection
	ldh a, [hTempPlayAreaLocation_ff9d]
	ldh [hTempPlayAreaLocation_ffa1], a
	ret

; if coin toss at hTemp_ffa0 was heads and it's possible,
; switch the Defending Pokemon
TerrorStrike_SwitchDefendingPokemon:
	ldh a, [hTemp_ffa0]
	or a
	ret z
	ldh a, [hTempPlayAreaLocation_ffa1]
	call HandleSwitchDefendingPokemonEffect
	ret

PoisonFang_AIEffect:
	ld a, 10
	lb de, 10, 10
	call UpdateExpectedAIDamage_AccountForPoison
	ret

PoisonFang_PoisonEffect:
	call PoisonEffect
	ret

WeepinbellPoisonPowder_AIEffect:
	ld a, 10 / 2
	lb de, 0, 10
	call UpdateExpectedAIDamage_AccountForPoison
	ret

WeepinbellPoisonPowder_Poison50PercentEffect:
	call Poison50PercentEffect
	ret

VictreebelLure_AssertPokemonInBench:
	call CheckNonTurnDuelistHasBench
	ret

; return in hTempPlayAreaLocation_ffa1 the PLAY_AREA_* location
; of the Bench Pokemon that was selected for switch
VictreebelLure_SelectSwitchPokemon:
	ldtx hl, SelectBenchedPokemonToSwitchWithActiveText
	call DrawWideTextBox_WaitForInput
	call SwapTurn
	bank1call HasAlivePokemonInBench
.select_pokemon
	bank1call OpenPlayAreaScreenForSelection
	jr c, .select_pokemon
	ldh a, [hTempPlayAreaLocation_ff9d]
	ldh [hTemp_ffa0], a
	call SwapTurn
	ret

; Return in hTemp_ffa0 the PLAY_AREA_* of the non-turn holder's Pokemon card in bench with the lowest (remaining) HP.
; if multiple cards are tied for the lowest HP, the one with the highest PLAY_AREA_* is returned.
VictreebelLure_GetBenchPokemonWithLowestHP:
	call AIFindTargetForBenchAttack
	ldh [hTemp_ffa0], a
	ret

; Defending Pokemon is swapped out for the one with the PLAY_AREA_* at hTemp_ffa0
; unless an effect or Pkmn Power prevents it.
VictreebelLure_SwitchDefendingPokemon:
	call SwapTurn
	ldh a, [hTemp_ffa0]
	ld e, a
	bank1call HandlePlayAreaCardNoDamageOrEffect
	call nc, SwapArenaWithBenchPokemon
	call SwapTurn
	xor a
	ld [wDuelDisplayedScreen], a
	ret

; If heads, defending Pokemon can't retreat next turn
AcidEffect:
	ldtx de, AcidCheckText
	call TossCoin_Bank1a
	ret nc
	ld a, SUBSTATUS2_ACID
	call ApplySubstatus2ToDefendingCard
	ret

IronGripEffect:
	call Paralysis50PercentEffect
	ret

StringShotEffect:
	call Paralysis50PercentEffect
	ret

GloomPoisonPowder_AIEffect:
	ld a, 10
	lb de, 10, 10
	call UpdateExpectedAIDamage_AccountForPoison
	ret

GloomPoisonPowder_PoisonEffect:
	call PoisonEffect
	ret

; Defending Pokemon and user become confused
FoulOdorEffect:
	call ConfusionEffect
	call SwapTurn
	call ConfusionEffect
	call SwapTurn
	ret

; If heads, prevent all damage done to user next turn
KakunaStiffenEffect:
	ldtx de, IfHeadsNoDamageNextTurnText
	call TossCoin_Bank1a
	jp nc, SetWasUnsuccessful
	ld a, ATK_ANIM_PROTECT
	ld [wLoadedAttackAnimation], a
	ld a, SUBSTATUS1_NO_DAMAGE_STIFFEN
	call ApplySubstatus1ToAttackingCard
	ret

KakunaPoisonPowder_AIEffect:
	ld a, 10 / 2
	lb de, 0, 10
	call UpdateExpectedAIDamage_AccountForPoison
	ret

KakunaPoisonPowder_PoisonEffect:
	call Poison50PercentEffect
	ret

GolbatLv29LeechLifeEffect:
	ld hl, wDealtDamage
	ld e, [hl]
	inc hl
	ld d, [hl]
	call ApplyAndAnimateHPRecovery
	ret

VenonatStunSpore:
	call Paralysis50PercentEffect
	ret

VenonatLeechLifeEffect:
	ld hl, wDealtDamage
	ld e, [hl]
	inc hl
	ld d, [hl]
	call ApplyAndAnimateHPRecovery
	ret

SwordsDanceEffect:
	ld a, SUBSTATUS1_NEXT_TURN_DOUBLE_DAMAGE
	call SetAttackDoubleOrTripleDamageNextTurn
	ret

ZubatSupersonicEffect:
	call Confusion50PercentOrNoEffect
	ret

ZubatLeechLifeEffect:
	ld hl, wDealtDamage
	ld e, [hl]
	inc hl
	ld d, [hl]
	call ApplyAndAnimateHPRecovery
	ret

Twineedle_AIEffect:
	ld a, 60 / 2
	lb de, 0, 60
	call SetExpectedAIDamage
	ret

; Flip 2 coins; deal 30x number of heads
Twineedle_MultiplierEffect:
	ld hl, 30
	call LoadTxRam3
	ldtx de, DamageCheckXDamageTimesHeadsText
	ld a, 2
	call TossCoinATimes_Bank1a
	ld e, a
	add a
	add e
	call ATimes10
	call SetDefiniteDamage
	ret

BeedrillPoisonSting_AIEffect:
	ld a, 10 / 2
	lb de, 0, 10
	call UpdateExpectedAIDamage_AccountForPoison
	ret

BeedrillPoisonSting_Poison50PercentEffect:
	call Poison50PercentEffect
	ret

ExeggcuteHypnosisEffect:
	call SleepEffect
	ret

ExeggcuteLeechSeedEffect:
	ld hl, wDealtDamage
	ld a, [hli]
	or [hl]
	ret z ; return if no damage dealt
	ld de, 10
	call ApplyAndAnimateHPRecovery
	ret

FoulGas_AIEffect:
	ld a, 10 / 2
	lb de, 0, 10
	jp UpdateExpectedAIDamage

; If heads, defending Pokemon becomes poisoned. If tails, defending Pokemon becomes confused
FoulGas_PoisonOrConfusionEffect:
	ldtx de, PoisonedIfHeadsConfusedIfTailsText
	call TossCoin_Bank1a
	jp c, PoisonEffect
	jp ConfusionEffect

; an exact copy of KakunaStiffenEffect
; If heads, prevent all damage done to user next turn
MetapodStiffenEffect:
	ldtx de, IfHeadsNoDamageNextTurnText
	call TossCoin_Bank1a
	jp nc, SetWasUnsuccessful
	ld a, ATK_ANIM_PROTECT
	ld [wLoadedAttackAnimation], a
	ld a, SUBSTATUS1_NO_DAMAGE_STIFFEN
	call ApplySubstatus1ToAttackingCard
	ret

MetapodStunSporeEffect:
	call Paralysis50PercentEffect
	ret

OddishStunSporeEffect:
	call Paralysis50PercentEffect
	ret

; returns carry if no cards in Deck or if
; Play Area is full already.
Sprout_CheckDeckAndPlayArea:
	farcall CheckIfDeckIsEmpty
	ret c ; return if no cards in deck
	farcall CheckIfHasSpaceInBench
	ret

Sprout_PlayerSelectEffect:
	call CreateDeckCardList
	ldtx hl, ChooseAnOddishFromDeckText
	ldtx bc, EffectTargetOddishText
	ld de, DEX_ODDISH
	ld a, CARDSEARCH_POKEDEX_NUMBER
	farcall LookForCardsInDeck
	jr c, .got_selection
	ldtx hl, ChooseAnOddishText
	ldtx de, DuelistDeckText
	farcall SelectCardSearchTarget
.got_selection
	ldh [hTemp_ffa0], a
	ret

Sprout_AISelectEffect:
	ld de, DEX_ODDISH
	ld a, CARDSEARCH_POKEDEX_NUMBER
	farcall SetCardSearchFuncParams
	call CreateDeckCardList
	ld hl, wDuelTempList
.loop
	ld a, [hli]
	ldh [hTemp_ffa0], a
	cp $ff
	ret z
	farcall ExecuteCardSearchFunc
	jr nc, .loop
	ret

Sprout_PutInPlayAreaEffect:
	ldh a, [hTemp_ffa0]
	cp $ff
	jr z, .shuffle
	call SearchCardInDeckAndAddToHand
	call AddCardToHand
	call PutHandPokemonCardInPlayArea
	call IsPlayerTurn
	jr c, .shuffle
	; display card on screen
	ldh a, [hTemp_ffa0]
	ldtx hl, PlacedOnBenchText
	bank1call DisplayCardDetailScreen
.shuffle
	call ShuffleCardsInDeck
	ret

Teleport_CheckBench:
	call CheckIfTurnDuelistHasBench
	ret

Teleport_PlayerSelectEffect:
	ldtx hl, SelectBenchedPokemonToSwitchWithActiveText
	call DrawWideTextBox_WaitForInput
	bank1call HasAlivePokemonInBench
.loop
	bank1call OpenPlayAreaScreenForSelection
	jr c, .loop
	ldh a, [hTempPlayAreaLocation_ff9d]
	ldh [hTemp_ffa0], a
	ret

; selects a random card from the bench to switch to
Teleport_AISelectEffect:
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	call Random
	ldh [hTemp_ffa0], a
	ret

Teleport_SwitchEffect:
	ldh a, [hTemp_ffa0]
	ld e, a
	call SwapArenaWithBenchPokemon
	xor a
	ld [wDuelDisplayedScreen], a
	ret

BigEggsplosion_AIEffect:
	ldh a, [hTempPlayAreaLocation_ff9d]
	ld e, a
	call GetPlayAreaCardAttachedEnergies
	ld a, [wTotalAttachedEnergies]
	call SetDamageToATimes20
	inc h
	jr nz, .capped
	ld l, 255
.capped
	; sets max damage as (num energy cards) * 20
	ld a, l
	ld [wAIMaxDamage], a
	; sets expected damage as half max amount
	srl a ; /2
	ld [wDamage], a
	; sets min damage as 0
	xor a
	ld [wAIMinDamage], a
	ret

; Flip coins equal to attached energies; deal 20x number of heads
BigEggsplosion_MultiplierEffect:
	ld e, PLAY_AREA_ARENA
	call GetPlayAreaCardAttachedEnergies
	ld hl, 20
	call LoadTxRam3
	ld a, [wTotalAttachedEnergies]
	ldtx de, DamageCheckXDamageTimesHeadsText
	call TossCoinATimes_Bank1a
;	fallthrough

; set damage to 20*a. Also return result in hl
SetDamageToATimes20:
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

Thrash_AIEffect:
	ld a, (30 + 40) / 2
	lb de, 30, 40
	call SetExpectedAIDamage
	ret

; If heads 10 more damage; if tails, 10 damage to itself
Thrash_ModifierEffect:
	ldtx de, IfHeadPlus10IfTails10ToYourselfText
	call TossCoin_Bank1a
	ldh [hTemp_ffa0], a
	ret nc
	ld a, 10
	call AddToDamage
	ret

Thrash_RecoilEffect:
	ldh a, [hTemp_ffa0]
	or a
	ret nz
	ld a, 10
	call DealRecoilDamageToSelf
	ret

Toxic_AIEffect:
	ld a, 20
	lb de, 20, 20
	jp UpdateExpectedAIDamage

; Defending Pokémon becomes double poisoned (takes 20 damage per turn rather than 10)
Toxic_DoublePoisonEffect:
	call DoublePoisonEffect
	ret

BoyfriendsEffect:
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	ld c, PLAY_AREA_ARENA
.loop
	ld a, [hl]
	cp $ff
	jr z, .done
	; is this card Nidoking?
	call GetCardIDFromDeckIndex
	ld a, e
	cp LOW(NIDOKING)
	jr nz, .next
	ld a, d
	cp HIGH(NIDOKING)
	jr nz, .next
	inc c
.next
	inc hl
	jr .loop
.done
; c holds number of Nidoking found in Play Area
	ld a, c
	add a
	call ATimes10
	call AddToDamage ; adds 2 * 10 * c
	ret

NidoranFFurySwipes_AIEffect:
	ld a, 30 / 2
	lb de, 0, 30
	call SetExpectedAIDamage
	ret

NidoranFFurySwipes_MultiplierEffect:
	ld hl, 10
	call LoadTxRam3
	ldtx de, DamageCheckXDamageTimesHeadsText
	ld a, 3
	call TossCoinATimes_Bank1a
	call ATimes10
	call SetDefiniteDamage
	ret

NidoranFCallForFamily_CheckDeckAndPlayArea:
	farcall CheckIfDeckIsEmpty
	ret c ; return if no cards in deck
	farcall CheckIfHasSpaceInBench
	ret

NidoranFCallForFamily_PlayerSelectEffect:
	call CreateDeckCardList
	ldtx hl, ChooseNidoranFromDeckText
	ldtx bc, EffectTargetNidoranMNidoranFText
	ld a, CARDSEARCH_NIDORAN
	farcall LookForCardsInDeck
	jr c, .got_selection
	ldtx hl, ChooseNidoranText
	ldtx de, DuelistDeckText
	farcall SelectCardSearchTarget
.got_selection
	ldh [hTemp_ffa0], a
	ret

NidoranFCallForFamily_AISelectEffect:
	ld a, CARDSEARCH_NIDORAN
	farcall SetCardSearchFuncParams
	call CreateDeckCardList
	ld hl, wDuelTempList
.loop
	ld a, [hli]
	ldh [hTemp_ffa0], a
	cp $ff
	ret z
	farcall ExecuteCardSearchFunc
	jr nc, .loop
	ret

NidoranFCallForFamily_PutInPlayAreaEffect:
	ldh a, [hTemp_ffa0]
	cp $ff
	jr z, .shuffle
	call SearchCardInDeckAndAddToHand
	call AddCardToHand
	call PutHandPokemonCardInPlayArea
	call IsPlayerTurn
	jr c, .shuffle
	; display card on screen
	ldh a, [hTemp_ffa0]
	ldtx hl, PlacedOnBenchText
	bank1call DisplayCardDetailScreen
.shuffle
	call ShuffleCardsInDeck
	ret

HornHazard_AIEffect:
	ld a, 30
	lb de, 0, 30
	call SetExpectedAIDamage
	ret

HornHazard_NoDamage50PercentEffect:
	ldtx de, DamageCheckIfTailsNoDamageText
	call TossCoin_Bank1a
	jr c, .heads
	xor a
	call SetDefiniteDamage
	call SetWasUnsuccessful
	ret
.heads
	ld a, ATK_ANIM_HIT
	ld [wLoadedAttackAnimation], a
	ret

NidorinaSupersonicEffect:
	call Confusion50PercentOrNoEffect
	ret

NidorinaDoubleKick_AIEffect:
	ld a, 60 / 2
	lb de, 0, 60
	call SetExpectedAIDamage
	ret

NidorinaDoubleKick_MultiplierEffect:
	ld hl, 30
	call LoadTxRam3
	ldtx de, DamageCheckXDamageTimesHeadsText
	ld a, 2
	call TossCoinATimes_Bank1a
	ld e, a
	add a
	add e
	call ATimes10
	call SetDefiniteDamage
	ret

NidorinoDoubleKick_AIEffect:
	ld a, 60 / 2
	lb de, 0, 60
	call SetExpectedAIDamage
	ret

NidorinoDoubleKick_MultiplierEffect:
	ld hl, 30
	call LoadTxRam3
	ldtx de, DamageCheckXDamageTimesHeadsText
	ld a, 2
	call TossCoinATimes_Bank1a
	ld e, a
	add a
	add e
	call ATimes10
	call SetDefiniteDamage
	ret

ButterfreeWhirlwind_CheckBench:
	call HandleMandatorySwitchSelection
	ldh a, [hTempPlayAreaLocation_ff9d]
	ldh [hTemp_ffa0], a
	ret

ButterfreeWhirlwind_SwitchEffect:
	ldh a, [hTemp_ffa0]
	call HandleSwitchDefendingPokemonEffect
	ret

ButterfreeMegaDrainEffect:
	ld hl, wDealtDamage
	ld a, [hli]
	ld h, [hl]
	ld l, a
	srl h
	rr l
	bit 0, l
	jr z, .asm_68b02
	ldtx de, DoneText
	add hl, de
.asm_68b02
	ld e, l
	ld d, h
	call ApplyAndAnimateHPRecovery
	ret

ParasSporeEffect:
	call SleepEffect
	ret

ParasectSporeEffect:
	call SleepEffect
	ret

WeedlePoisonSting_AIEffect:
	ld a, 10 / 2
	lb de, 0, 10
	call UpdateExpectedAIDamage_AccountForPoison
	ret

WeedlePoisonSting_Poison50PercentEffect:
	call Poison50PercentEffect
	ret

IvysaurPoisonPowder_AIEffect:
	ld a, 10
	lb de, 10, 10
	call UpdateExpectedAIDamage_AccountForPoison
	ret

IvysaurPoisonPowder_PoisonEffect:
	call PoisonEffect
	ret

BulbasaurLeechSeedEffect:
	ld hl, wDealtDamage
	ld a, [hli]
	or [hl]
	ret z ; return if no damage dealt
	ld de, 10
	call ApplyAndAnimateHPRecovery
	ret

VenusaurEnergyTrans_CheckPlayArea:
	jr CheckIfGrassEnergyInPlayArea

VenusaurEnergyTrans_PrintProcedure:
	jr PrintProcedureForEnergyTrans

VenusaurEnergyTrans_TransferEffect:
	jr EnergyTransEffect

VenusaurEnergyTrans_AIEffect:
	jp EnergyTransAITransfer

; returns carry if no Grass Energy (or Rainbow energy)
; found in turn duelist's Play Area
CheckIfGrassEnergyInPlayArea:
	ldh a, [hTempPlayAreaLocation_ff9d]
	ldh [hTemp_ffa0], a
	ldh a, [hTempPlayAreaLocation_ff9d]
	bank1call CheckIsIncapableOfUsingPkmnPower
	ret c ; cannot use Pkmn Power

; search in Play Area for at least 1 Grass Energy type
	ld a, DUELVARS_CARD_LOCATIONS
	get_turn_duelist_var
.loop_deck
	ld a, [hl]
	and CARD_LOCATION_PLAY_AREA
	jr z, .next
	push hl
	ld a, l
	call GetCardIDFromDeckIndex
	pop hl
	cp16 GRASS_ENERGY
	jr z, .found
	cp16 RAINBOW_ENERGY
	jr z, .found
.next
	inc l
	ld a, l
	cp DECK_SIZE
	jr c, .loop_deck

; none found
	ldtx hl, NoGrassEnergyText
	scf
	ret

.found
	or a
	ret

PrintProcedureForEnergyTrans:
	ldtx hl, ProcedureForEnergyTransferText
	bank1call DrawWholeScreenTextBox
	or a
	ret

EnergyTransEffect:
	ld a, DUELVARS_DUELIST_TYPE
	get_turn_duelist_var
	cp DUELIST_TYPE_PLAYER
	jr z, .player
; not player
	bank1call SetupPlayAreaScreen
	bank1call PrintPlayAreaCardList_EnableLCD
	ret

.player
	xor a
	ldh [hCurSelectionItem], a
	bank1call SetupPlayAreaScreen

.draw_play_area
	bank1call PrintPlayAreaCardList_EnableLCD
	push af
	ldh a, [hCurSelectionItem]
	ld hl, PlayAreaSelectionMenuParameters
	call InitializeMenuParameters
	pop af
	ld [wNumScrollMenuItems], a

; handle the action of taking a Grass Energy card
.loop_input_take
	call DoFrame
	call HandleMenuInput
	jr nc, .loop_input_take
	cp -1 ; b press?
	ret z

; a press
	ldh [hTempPlayAreaLocation_ffa1], a
	ldh [hCurSelectionItem], a
	call CheckIfCardHasGrassOrRainbowEnergyAttached
	jr c, .play_sfx ; no Grass attached

	ldh [hAIEnergyTransEnergyCard], a
	ldh a, [hAIEnergyTransEnergyCard] ; useless
	; temporarily take card away to draw Play Area
	call AddCardToHand
	bank1call PrintPlayAreaCardList_EnableLCD
	ldh a, [hTempPlayAreaLocation_ffa1]
	ld e, a
	ldh a, [hAIEnergyTransEnergyCard]
	; give card back
	call PutHandCardInPlayArea

	; draw Grass/Rainbow symbol near cursor
	ldh a, [hAIEnergyTransEnergyCard]
	ld b, SYM_GRASS
	call GetCardIDFromDeckIndex
	cp16 GRASS_ENERGY
	jr z, .got_symbol
	ld b, SYM_RAINBOW
.got_symbol
	ldh a, [hTempPlayAreaLocation_ffa1]
	call DrawSymbolOnPlayAreaCursor

; handle the action of placing a Grass Energy card
.loop_input_put
	call DoFrame
	call HandleMenuInput
	jr nc, .loop_input_put
	cp -1 ; b press?
	jr z, .remove_symbol

; a press
	ldh [hCurSelectionItem], a
	ldh [hAIEnergyTransPlayAreaLocation], a
	ld a, OPPACTION_6B15
	call SetOppAction_SerialSendDuelData
	ldh a, [hAIEnergyTransPlayAreaLocation]
	ld e, a
	ldh a, [hAIEnergyTransEnergyCard]
	; give card being held to this Pokemon
	call AddCardToHand
	call PutHandCardInPlayArea

.remove_symbol
	ldh a, [hTempPlayAreaLocation_ffa1]
	ld b, SYM_SPACE
	call DrawSymbolOnPlayAreaCursor
	call EraseCursor
	jr .draw_play_area

.play_sfx
	call PlaySFX_InvalidChoice
	jr .loop_input_take

EnergyTransAITransfer:
	ldh a, [hAIEnergyTransPlayAreaLocation]
	ld e, a
	ldh a, [hAIEnergyTransEnergyCard]
	call AddCardToHand
	call PutHandCardInPlayArea
	bank1call PrintPlayAreaCardList_EnableLCD
	ret

; returns carry if no Grass/Rainbow Energy cards
; attached to card in Play Area location of a.
; input:
;	a = PLAY_AREA_* of location to check
CheckIfCardHasGrassOrRainbowEnergyAttached:
	or CARD_LOCATION_PLAY_AREA
	ld e, a

	ld bc, RAINBOW_ENERGY
	call .CheckIfHasEnergy
	ret nc ; has Rainbow energy

	ld bc, GRASS_ENERGY
.CheckIfHasEnergy:
	ld a, DUELVARS_CARD_LOCATIONS
	get_turn_duelist_var
.loop
	ld a, [hl]
	cp e
	jr nz, .next
	push de
	push hl
	ld a, l
	call GetCardIDFromDeckIndex
	ld a, d
	cp b
	jr nz, .not_equal
	ld a, e
	cp c
.not_equal
	pop hl
	pop de
	jr z, .no_carry
.next
	inc l
	ld a, l
	cp DECK_SIZE
	jr c, .loop
	scf
	ret
.no_carry
	ld a, l
	or a
	ret

VenusaurAltEnergyTrans_CheckPlayArea:
	jp CheckIfGrassEnergyInPlayArea

VenusaurAltEnergyTrans_PrintProcedure:
	jp PrintProcedureForEnergyTrans

VenusaurAltEnergyTrans_TransferEffect:
	jp EnergyTransEffect

VenusaurAltEnergyTrans_AIEffect:
	jr EnergyTransAITransfer

NastyGooEffect:
	call Paralysis50PercentEffect
	ret

GrimerMinimizeEffect:
	ld a, SUBSTATUS1_REDUCE_BY_20
	call ApplySubstatus1ToAttackingCard
	ret

ToxicGasEffect:
	scf
	ret

Sludge_AIEffect:
	ld a, 10 / 2
	lb de, 0, 10
	call UpdateExpectedAIDamage_AccountForPoison
	ret

Sludge_Poison50PercentEffect:
	call Poison50PercentEffect
	ret

BellsproutCallForFamily_CheckDeckAndPlayArea:
	farcall CheckIfDeckIsEmpty
	ret c ; return if no cards in deck
	farcall CheckIfHasSpaceInBench
	ret

BellsproutCallForFamily_PlayerSelectEffect:
	call CreateDeckCardList
	ldtx hl, ChooseABellsproutFromDeckText
	ldtx bc, EffectTargetBellsproutText
	ld de, DEX_BELLSPROUT
	ld a, CARDSEARCH_POKEDEX_NUMBER
	farcall LookForCardsInDeck
	jr c, .got_selection
	ldtx hl, ChooseABellsproutText
	ldtx de, DuelistDeckText
	farcall SelectCardSearchTarget
.got_selection
	ldh [hTemp_ffa0], a
	ret

BellsproutCallForFamily_AISelectEffect:
	ld de, DEX_BELLSPROUT
	ld a, CARDSEARCH_POKEDEX_NUMBER
	farcall SetCardSearchFuncParams
	call CreateDeckCardList
	ld hl, wDuelTempList
.loop
	ld a, [hli]
	ldh [hTemp_ffa0], a
	cp $ff
	ret z
	farcall ExecuteCardSearchFunc
	jr nc, .loop
	ret

BellsproutCallForFamily_PutInPlayAreaEffect:
	ldh a, [hTemp_ffa0]
	cp $ff
	jr z, .shuffle
	call SearchCardInDeckAndAddToHand
	call AddCardToHand
	call PutHandPokemonCardInPlayArea
	call IsPlayerTurn
	jr c, .shuffle
	ldh a, [hTemp_ffa0]
	ldtx hl, PlacedOnBenchText
	bank1call DisplayCardDetailScreen
.shuffle
	call ShuffleCardsInDeck
	ret

WeezingSmog_AIEffect:
	ld a, 10 / 2
	lb de, 0, 10
	call UpdateExpectedAIDamage_AccountForPoison
	ret

WeezingSmog_Poison50PercentEffect:
	call Poison50PercentEffect
	ret

WeezingSelfdestructEffect:
	ld a, 60
	call DealRecoilDamageToSelf
	call SetIsDamageToSelf
	ld a, 10
	call DealDamageToAllBenchedPokemon
	call SwapTurn
	call UnsetIsDamageToSelf
	ld a, 10
	call DealDamageToAllBenchedPokemon
	call SwapTurn
	ret

Shift_OncePerTurnCheck:
	jp CheckIfCanUsePkmnPowerThisTurn

Shift_PlayerSelectEffect:
.loop
	ldtx hl, ChoosePokemonToColorChangeText
	ldh a, [hTemp_ffa0]
	or $80
	farcall HandleColorChangeScreen
	ldh [hTempPlayAreaLocation_ffa1], a
	ret c ; cancelled

; check whether the color selected is valid
	; look in Turn Duelist's Play Area
	call .CheckColorInPlayArea
	ret nc
	; look in NonTurn Duelist's Play Area
	call SwapTurn
	call .CheckColorInPlayArea
	call SwapTurn
	ret nc
	; not found in either Duelist's Play Area
	ldtx hl, UnableToSelectText
	call DrawWideTextBox_WaitForInput
	jr .loop ; loop back to start

; checks in input color in a exists in Turn Duelist's Play Area
; returns carry if not found.
.CheckColorInPlayArea:
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	ld c, a
	ld b, PLAY_AREA_ARENA
.loop_play_area
	push bc
	ld a, b
	bank1call GetPlayAreaCardColor
	pop bc
	ld hl, hTempPlayAreaLocation_ffa1
	cp [hl]
	ret z ; found
	inc b
	dec c
	jr nz, .loop_play_area
	; not found
	scf
	ret

Shift_ChangeColorEffect:
	call SetUsedPkmnPowerThisTurnFlag
	ldh a, [hTemp_ffa0]
	add DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call LoadCardDataToBuffer1_FromDeckIndex

	ldh a, [hTemp_ffa0]
	add DUELVARS_ARENA_CARD_CHANGED_TYPE
	ld l, a
	ldh a, [hTempPlayAreaLocation_ffa1]
	or HAS_CHANGED_COLOR
	ld [hl], a
	call LoadCardNameAndInputColor
	ldtx hl, ChangedTheColorOfPokemonToColorText
	call DrawWideTextBox_WaitForInput
	ret

VenomPowder_AIEffect:
	ld a, 10 / 2
	lb de, 0, 10
	jp UpdateExpectedAIDamage

VenomPowder_PoisonConfusion50PercentEffect:
	ldtx de, VenomPowderCheckText
	call TossCoin_Bank1a
	ret nc ; return if tails

; heads
	call PoisonEffect
	call ConfusionEffect
	ret c
	ld a, CONFUSED | POISONED
	ld [wNoEffectFromWhichStatus], a
	ret

BindEffect:
	call Paralysis50PercentEffect
	ret

TangelaPoisonPowder_AIEffect:
	ld a, 10 / 2
	lb de, 0, 10
	call UpdateExpectedAIDamage_AccountForPoison
	ret

TangelaPoisonPowder_PoisonEffect:
	call PoisonEffect
	ret

Heal_OncePerTurnCheck:
	call CheckIfCanUsePkmnPowerThisTurn
	ret c
	call CheckIfPlayAreaHasAnyDamage
	ldtx hl, NoPokemonWithDamageCountersText
	ret

Heal_RemoveDamageEffect:
	ldtx de, HealSuccessCheckText
	call TossCoin_Bank1a
	ldh [hTempPlayAreaLocation_ffa1], a
	jr nc, .done

	ld a, DUELVARS_DUELIST_TYPE
	get_turn_duelist_var
	cp DUELIST_TYPE_LINK_OPP
	jr z, .link_opp
	and DUELIST_TYPE_AI_OPP
	jr nz, .done

; player
	ldtx hl, ChoosePokemonToRemoveDamageCounterFromText
	call DrawWideTextBox_WaitForInput
	bank1call HasAlivePokemonInPlayArea
.loop_input
	bank1call OpenPlayAreaScreenForSelection
	jr c, .loop_input
	ldh a, [hTempPlayAreaLocation_ff9d]
	ldh [hPlayAreaEffectTarget], a
	ld e, a
	call GetCardDamageAndMaxHP
	or a
	jr z, .loop_input ; has no damage counters
	ldh a, [hTempPlayAreaLocation_ff9d]
	call SerialSend8Bytes
	jr .done

.link_opp
	call LoadSymbolsFont
	call LoadDuelCardSymbolTiles
	call SerialRecv8Bytes
	ldh [hPlayAreaEffectTarget], a

.done
; flag Pkmn Power as being used regardless of coin outcome
	call SetUsedPkmnPowerThisTurnFlag
	ldh a, [hTempPlayAreaLocation_ffa1]
	or a
	ret z ; return if coin was tails

	ldh a, [hPlayAreaEffectTarget]
	add DUELVARS_ARENA_CARD_HP
	get_turn_duelist_var
	add 10 ; remove 1 damage counter
	ld [hl], a
	ldh a, [hPlayAreaEffectTarget]
	call DrawPlayAreaScreenToShowChanges
	call ExchangeRNG
	ret

PetalDance_AIEffect:
	ld a, 120 / 2
	lb de, 0, 120
	call SetExpectedAIDamage
	ret

PetalDance_MultiplierEffect:
	ld hl, 40
	call LoadTxRam3
	ldtx de, DamageCheckXDamageTimesHeadsText
	ld a, 3
	call TossCoinATimes_Bank1a
	add a
	add a
	call ATimes10
	; a = 4 * 10 * heads
	call SetDefiniteDamage
	call SwapTurn
	call ConfusionEffect
	call SwapTurn
	ret

TangelaStunSporeEffect:
	call Paralysis50PercentEffect
	ret

PoisonWhip_AIEffect:
	ld a, 10
	lb de, 10, 10
	call UpdateExpectedAIDamage_AccountForPoison
	ret

PoisonWhip_PoisonEffect:
	call PoisonEffect
	ret

SolarPower_CheckUse:
	call CheckIfCanUsePkmnPowerThisTurn
	ret c

; return carry if none of the Arena cards have status conditions
	ld a, DUELVARS_ARENA_CARD_STATUS
	get_turn_duelist_var
	or a
	jr nz, .has_status
	ld a, DUELVARS_ARENA_CARD_STATUS
	call GetNonTurnDuelistVariable
	or a
	jr nz, .has_status
	ldtx hl, NotAffectedByStatusText
	scf
.has_status
	ret

SolarPower_RemoveStatusEffect:
	ld a, ATK_ANIM_HEAL_BOTH_SIDES
	ld [wLoadedAttackAnimation], a
	farcall ResetAttackAnimationIsPlaying
	ldh a, [hTempPlayAreaLocation_ff9d]
	ld b, a
	ld c, $00
	ldh a, [hWhoseTurn]
	ld h, a
	farcall PlayAttackAnimation
	farcall WaitAttackAnimation

	call SetUsedPkmnPowerThisTurnFlag

	ld a, DUELVARS_ARENA_CARD_STATUS
	get_turn_duelist_var
	ld [hl], NO_STATUS
	ld a, DUELVARS_ARENA_CARD_STATUS
	call GetNonTurnDuelistVariable
	ld [hl], NO_STATUS
	bank1call DrawDuelHUDs
	ret

VenusaurMegaDrainEffect:
	ld hl, wDealtDamage
	ld a, [hli]
	ld h, [hl]
	ld l, a
	srl h
	rr l
	bit 0, l
	jr z, .rounded
	; round up to nearest 10
	ld de, 10 / 2
	add hl, de
.rounded
	ld e, l
	ld d, h
	call ApplyAndAnimateHPRecovery
	ret

; applies the damage bonus for attacks that get bonus
; from extra Water/Rainbow energy cards.
; this bonus is always 10 more damage for each extra Water energy
; and is always capped at a maximum of 20 damage.
; input:
;	b = number of Water energy cards needed for paying Energy Cost
;	c = number of colorless energy cards needed for paying Energy Cost
ApplyExtraWaterEnergy10DamageBonus:
	call CalculateExtraWaterEnergiesForDamageBonus
	call ApplyCalculatedWaterEnergyBonusToDamage
	ret

; same as ApplyExtraWaterEnergy10DamageBonus but does 20 more damage
; for each extra Water energy instead of 10
; input:
;	b = number of Water energy cards needed for paying Energy Cost
;	c = number of colorless energy cards needed for paying Energy Cost
ApplyExtraWaterEnergy20DamageBonus:
	call CalculateExtraWaterEnergiesForDamageBonus
	add a ; *2
	call ApplyCalculatedWaterEnergyBonusToDamage
	ret

; input:
;	b = number of Water energy cards needed for paying Energy Cost
;	c = number of colorless energy cards needed for paying Energy Cost
; output:
;	a = how many Water/Rainbow energies to apply to the bonus damage
CalculateExtraWaterEnergiesForDamageBonus:
	ld a, [wMetronomeEnergyCost]
	or a
	jr z, .not_metronome
	ld c, a ; amount of colorless needed for Metronome
	ld b, 0 ; no Water energy needed for Metronome

.not_metronome
	push bc
	ldh a, [hTempPlayAreaLocation_ff9d]
	ld e, a
	call GetPlayAreaCardAttachedEnergies
	ld a, [wAttachedEnergies + RAINBOW]
	ld hl, wAttachedEnergies + WATER
	add [hl]
	ld e, a
	ld a, [wTotalAttachedEnergies]
	sub e
	ld d, a
	pop bc
	; e = number of Water/Rainbow energies
	; d = number of all other energies

	; check if non-Water/Rainbow energies
	; satisfies colorless requirements
	ld a, d
	sub c
	jr nc, .got_extra_energies
	; it doesn't, so some Water/Rainbow energies
	; are subtracted from e
	add e
	ld e, a
.got_extra_energies
	ld a, e
	sub b
	jr c, .no_bonus
; a holds number of water energy not payed for energy cost
	cp 3
	jr c, .less_than_3
	ld a, 2 ; cap this to 2 for bonus effect
.less_than_3
	ret
.no_bonus
	xor a
	ret

; input:
;	a = how many Water/Rainbow energies to apply to the bonus damage
ApplyCalculatedWaterEnergyBonusToDamage:
	call ATimes10
	call AddToDamage
	ld a, [wDamage]
	ld [wAIMinDamage], a
	ld [wAIMaxDamage], a
	ret

OmastarWaterGunEffect:
	lb bc, 1, 1
	jr ApplyExtraWaterEnergy10DamageBonus

OmastarSpikeCannon_AIEffect:
	ld a, 60 / 2
	lb de, 0, 60
	call SetExpectedAIDamage
	ret

OmastarSpikeCannon_MultiplierEffect:
	ld hl, 30
	call LoadTxRam3
	ld a, 2
	ldtx de, DamageCheckXDamageTimesHeadsText
	call TossCoinATimes_Bank1a
	ld e, a
	add a
	add e
	call ATimes10
	call SetDefiniteDamage ; 3 * 10 * heads
	ret

Clairvoyance_CheckUse:
	ldh a, [hTempPlayAreaLocation_ff9d]
	ldh [hTemp_ffa0], a
	ldh a, [hTempPlayAreaLocation_ff9d] ; unnecessary
	bank1call CheckIsIncapableOfUsingPkmnPower
	ret

Clairvoyance_CheckHandEffect:
	call IsPlayerTurn
	ret nc ; not player's turn
	bank1call OpenNonTurnHolderHandScreen_Simple
	ret

OmanyteWaterGunEffect:
	lb bc, 1, 0
	jp ApplyExtraWaterEnergy10DamageBonus

WartortleWithdrawEffect:
	ldtx de, IfHeadsNoDamageNextTurnText
	call TossCoin_Bank1a
	jp nc, SetWasUnsuccessful
	ld a, ATK_ANIM_PROTECT
	ld [wLoadedAttackAnimation], a
	ld a, SUBSTATUS1_NO_DAMAGE_WITHDRAW
	call ApplySubstatus1ToAttackingCard
	ret

BlastoiseRainDanceEffect:
	scf
	ret

BlastoiseHydroPumpEffect:
	lb bc, 3, 0
	jp ApplyExtraWaterEnergy10DamageBonus

BlastoiseAltRainDanceEffect:
	scf
	ret

BlastoiseAltHydroPumpEffect:
	jr BlastoiseHydroPumpEffect

BubblebeamEffect:
	call Paralysis50PercentEffect
	ret

KinglerFlail_AIEffect:
	ldh a, [hTempPlayAreaLocation_ff9d]
	jr CalculateKinglerFlailDamage
KinglerFlail_HPCheck:
	xor a ; PLAY_AREA_ARENA
CalculateKinglerFlailDamage:
	ld e, a
	call GetCardDamageAndMaxHP
	call SetDefiniteDamage
	ret

; returns carry if no cards in Deck
; or if Play Area is full already.
KrabbyCallForFamily_CheckDeckAndPlayArea:
	farcall CheckIfDeckIsEmpty
	ret c ; return if no cards in deck
	farcall CheckIfHasSpaceInBench
	ret

KrabbyCallForFamily_PlayerSelectEffect:
	call CreateDeckCardList
	ldtx hl, ChooseAKrabbyFromDeckText
	ldtx bc, EffectTargetKrabbyText
	ld de, DEX_KRABBY
	ld a, CARDSEARCH_POKEDEX_NUMBER
	farcall LookForCardsInDeck
	jr c, .got_selection
	ldtx hl, ChooseAKrabbyText
	ldtx de, DuelistDeckText
	farcall SelectCardSearchTarget
.got_selection
	ldh [hTemp_ffa0], a
	ret

KrabbyCallForFamily_AISelectEffect:
	ld de, DEX_KRABBY
	ld a, CARDSEARCH_POKEDEX_NUMBER
	farcall SetCardSearchFuncParams
	call CreateDeckCardList
	ld hl, wDuelTempList
.loop
	ld a, [hli]
	ldh [hTemp_ffa0], a
	cp $ff
	ret z
	farcall ExecuteCardSearchFunc
	jr nc, .loop
	ret

KrabbyCallForFamily_PutInPlayAreaEffect:
	ldh a, [hTemp_ffa0]
	cp $ff
	jr z, .shuffle
	call SearchCardInDeckAndAddToHand
	call AddCardToHand
	call PutHandPokemonCardInPlayArea
	call IsPlayerTurn
	jr c, .shuffle
	ldh a, [hTemp_ffa0]
	ldtx hl, PlacedOnBenchText
	bank1call DisplayCardDetailScreen
.shuffle
	call ShuffleCardsInDeck
	ret

MagikarpFlail_AIEffect:
	ldh a, [hTempPlayAreaLocation_ff9d]
	jr CalculateMagikarpFlailDamage
MagikarpFlail_HPCheck:
	xor a
CalculateMagikarpFlailDamage:
	ld e, a
	call GetCardDamageAndMaxHP
	call SetDefiniteDamage
	ret

HeadacheEffect:
	ld a, DUELVARS_ARENA_CARD_SUBSTATUS3
	call GetNonTurnDuelistVariable
	set SUBSTATUS3_HEADACHE_F, [hl]
	ret

PsyduckFurySwipes_AIEffect:
	ld a, 30 / 2
	lb de, 0, 30
	call SetExpectedAIDamage
	ret

PsyduckFurySwipes_MultiplierEffect:
	ld hl, 10
	call LoadTxRam3
	ldtx de, DamageCheckXDamageTimesHeadsText
	ld a, 3
	call TossCoinATimes_Bank1a
	call ATimes10
	call SetDefiniteDamage
	ret

GolduckPsyshockEffect:
	call Paralysis50PercentEffect
	ret

GolduckHyperBeam_PlayerSelectEffect:
	jp HandleDiscardEnergyFromDefendingCardPlayerSelection

GolduckHyperBeam_AISelectEffect:
	jp AIPickEnergyCardToDiscardFromDefendingPokemon

GolduckHyperBeam_DiscardEffect:
	jp DiscardEnergyEffect

SeadraWaterGunEffect:
	lb bc, 1, 1
	jp ApplyExtraWaterEnergy10DamageBonus

SeadraAgilityEffect:
	ldtx de, IfHeadsDoNotReceiveDamageOrEffectText
	call TossCoin_Bank1a
	ret nc ; return if tails
	ld a, ATK_ANIM_AGILITY_PROTECT
	ld [wLoadedAttackAnimation], a
	ld a, SUBSTATUS1_AGILITY
	call ApplySubstatus1ToAttackingCard
	ret

ShellderSupersonicEffect:
	call Confusion50PercentOrNoEffect
	ret

HideInShellEffect:
	ldtx de, IfHeadsNoDamageNextTurnText
	call TossCoin_Bank1a
	jp nc, SetWasUnsuccessful
	ld a, ATK_ANIM_PROTECT
	ld [wLoadedAttackAnimation], a
	ld a, SUBSTATUS1_NO_DAMAGE_HIDE_IN_SHELL
	call ApplySubstatus1ToAttackingCard
	ret

VaporeonQuickAttack_AIEffect:
	ld a, (10 + 30) / 2
	lb de, 10, 30
	call SetExpectedAIDamage
	ret

VaporeonQuickAttack_DamageBoostEffect:
	ld a, 20
	call AddDamageIfHeads
	ret

VaporeonWaterGunEffect:
	lb bc, 2, 1
	jp ApplyExtraWaterEnergy10DamageBonus

DewgongIceBeamEffect:
	call Paralysis50PercentEffect
	ret

; returns carry if Arena card has no Water/Rainbow Energy attached
; or if it doesn't have any damage counters.
StarmieRecover_CheckEnergyHP:
	ld e, PLAY_AREA_ARENA
	call GetPlayAreaCardAttachedEnergies
	ld a, [wAttachedEnergies + WATER]
	ld hl, wAttachedEnergies + RAINBOW
	add [hl]
	ldtx hl, NotEnoughWaterEnergyText
	cp 1
	ret c ; return if not enough energy
	call GetCardDamageAndMaxHP
	ldtx hl, NoDamageCountersText
	cp 10
	ret ; return carry if no damage

StarmieRecover_PlayerSelectEffect:
	ld a, TYPE_ENERGY_WATER
	call CreateListOfEnergyAttachedToArena
	xor a ; PLAY_AREA_ARENA
	bank1call DisplayEnergyDiscardMenu
.loop_input
	bank1call HandleAttachedEnergyMenuInput
	jr c, .loop_input
	ldh a, [hTempCardIndex_ff98]
	ldh [hTemp_ffa0], a ; store card chosen
	ret

StarmieRecover_AISelectEffect:
	ld a, TYPE_ENERGY_WATER
	call CreateListOfEnergyAttachedToArena
	ld a, [wDuelTempList] ; pick first card
	ldh [hTemp_ffa0], a
	ret

StarmieRecover_DiscardEffect:
	ldh a, [hTemp_ffa0]
	call DiscardCard
	ret

StarmieRecover_HealEffect:
	ld e, PLAY_AREA_ARENA
	call GetCardDamageAndMaxHP
	ld e, a ; all damage for recovery
	ld d, 0
	call ApplyAndAnimateHPRecovery
	ret

StarFreezeEffect:
	call Paralysis50PercentEffect
	ret

SquirtleBubbleEffect:
	call Paralysis50PercentEffect
	ret

SquirtleWithdrawEffect:
	ldtx de, IfHeadsNoDamageNextTurnText
	call TossCoin_Bank1a
	jp nc, SetWasUnsuccessful
	ld a, ATK_ANIM_PROTECT
	ld [wLoadedAttackAnimation], a
	ld a, SUBSTATUS1_NO_DAMAGE_WITHDRAW
	call ApplySubstatus1ToAttackingCard
	ret

HorseaSmokescreenEffect:
	ld a, SUBSTATUS2_SMOKESCREEN
	call ApplySubstatus2ToDefendingCard
	ret

TentacruelSupersonicEffect:
	call Confusion50PercentOrNoEffect
	ret

JellyfishSting_AIEffect:
	ld a, 10
	lb de, 10, 10
	call UpdateExpectedAIDamage_AccountForPoison
	ret

JellyfishSting_PoisonEffect:
	call PoisonEffect
	ret

PoliwhirlAmnesia_CheckAttacks:
	call CheckIfDefendingCardHasAnyAttacks
	ret

PoliwhirlAmnesia_PlayerSelectEffect:
	call PlayerPickAttackForAmnesia
	ret

PoliwhirlAmnesia_AISelectEffect:
	call AIPickAttackForAmnesia
	ret

PoliwhirlAmnesia_DisableEffect:
	jr ApplyAmnesiaToAttack

PlayerPickAttackForAmnesia:
	ldtx hl, ChooseAttackToDisableNextOppTurnText
	call DrawWideTextBox_WaitForInput
	call HandleDefendingPokemonAttackSelection
	ld a, e
	ldh [hTemp_ffa0], a
	ret

; applies the Amnesia effect on the defending Pokemon,
; for the attack index in hTemp_ffa0.
ApplyAmnesiaToAttack:
	ld a, SUBSTATUS2_AMNESIA
ApplyAmnesiaToAttack_GotSubstatus:
	call ApplySubstatus2ToDefendingCard
	ld a, [wNoDamageOrEffect]
	or a
	ret nz ; no effect

; set selected attack as disabled
	ld a, DUELVARS_ARENA_CARD_DISABLED_ATTACK_INDEX
	call GetNonTurnDuelistVariable
	ldh a, [hTemp_ffa0]
	ld [hl], a

	ld l, DUELVARS_ARENA_CARD_LAST_TURN_EFFECT
	ld [hl], LAST_TURN_EFFECT_AMNESIA

	call IsPlayerTurn
	ret c ; return if Player

; the rest of the routine if for Opponent
; to announce which attack was used for Amnesia.
	ld a, ATK_ANIM_AMNESIA
	ld [wLoadedAttackAnimation], a
	call SwapTurn
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	ld d, a
	ldh a, [hTemp_ffa0]
	ld e, a
	call GetAttackName
	call LoadTxRam2
	ldtx hl, DisabledNextTurnText
	call DrawWideTextBox_WaitForInput
	call SwapTurn
	ret

PoliwhirlDoubleslap_AIEffect:
	ld a, 60 / 2
	lb de, 0, 60
	call SetExpectedAIDamage
	ret

PoliwhirlDoubleslap_MultiplierEffect:
	ld hl, 30
	call LoadTxRam3
	ldtx de, DamageCheckXDamageTimesHeadsText
	ld a, 2
	call TossCoinATimes_Bank1a
	ld e, a
	add a
	add e
	call ATimes10
	call SetDefiniteDamage
	ret

PoliwrathWaterGunEffect:
	lb bc, 2, 1
	jp ApplyExtraWaterEnergy10DamageBonus

PoliwrathWhirlpool_PlayerSelectEffect:
	jp HandleDiscardEnergyFromDefendingCardPlayerSelection

PoliwrathWhirlpool_AISelectEffect:
	jp AIPickEnergyCardToDiscardFromDefendingPokemon

PoliwrathWhirlpool_DiscardEffect:
	jp DiscardEnergyEffect

PoliwagWaterGunEffect:
	lb bc, 1, 0
	jp ApplyExtraWaterEnergy10DamageBonus

Clamp_AIEffect:
	ld a, 30
	lb de, 0, 30
	call SetExpectedAIDamage
	ret

	ret ; stray ret

Clamp_Successful50PercentEffect:
	ld a, ATK_ANIM_HIT_EFFECT
	ld [wLoadedAttackAnimation], a
	ldtx de, AttackSuccessCheckText
	call TossCoin_Bank1a
	jp c, ParalysisEffect
; unsuccessful
	xor a ; ATK_ANIM_NONE
	ld [wLoadedAttackAnimation], a
	call SetDefiniteDamage
	call SetWasUnsuccessful
	ret

CloysterSpikeCannon_AIEffect:
	ld a, 60 / 2
	lb de, 0, 60
	call SetExpectedAIDamage
	ret

CloysterSpikeCannon_MultiplierEffect:
	ld hl, 30
	call LoadTxRam3
	ldtx de, DamageCheckXDamageTimesHeadsText
	ld a, 2
	call TossCoinATimes_Bank1a
	ld e, a
	add a
	add e
	call ATimes10
	call SetDefiniteDamage
	ret

FreezeDryEffect:
	call Paralysis50PercentEffect
	ret

Blizzard_BenchDamage50PercentEffect:
	ldtx de, DamageToOppBenchIfHeadsDamageToYoursIfTailsText
	call TossCoin_Bank1a
	ldh [hTemp_ffa0], a ; store coin result
	ret

Blizzard_BenchDamageEffect:
	ldh a, [hTemp_ffa0]
	or a
	jr nz, .opp_bench

; own bench
	call SetIsDamageToSelf
	ld a, 10
	call DealDamageToAllBenchedPokemon
	ret

.opp_bench
	call SwapTurn
	ld a, 10
	call DealDamageToAllBenchedPokemon
	call SwapTurn
	ret

; return carry if can't use Cowardice
Cowardice_CheckUseAndBench:
	ldh a, [hTempPlayAreaLocation_ff9d]
	ldh [hTemp_ffa0], a
	bank1call CheckIsIncapableOfUsingPkmnPower
	ret c ; return if cannot use

	call CheckIfTurnDuelistHasBench
	ret c ; return if no bench

	ldh a, [hTempPlayAreaLocation_ff9d]
	add DUELVARS_ARENA_CARD_FLAGS
	get_turn_duelist_var
	ldtx hl, CannotBeUsedInTurnWhichWasPlayedText
	and CAN_EVOLVE_THIS_TURN
	scf
	ret z ; return if was played this turn

	or a
	ret

Cowardice_PlayerSelectEffect:
	ldh a, [hTemp_ffa0]
	or a
	ret nz ; return if not Arena card
	ldtx hl, SelectPokemonToPlaceInTheArenaText
	call DrawWideTextBox_WaitForInput
	bank1call HasAlivePokemonInBench
	bank1call OpenPlayAreaScreenForSelection
	ldh a, [hTempPlayAreaLocation_ff9d]
	ldh [hTempPlayAreaLocation_ffa1], a
	ret

Cowardice_ReturnToHandEffect:
	ldh a, [hTemp_ffa0]
	add DUELVARS_ARENA_CARD
	get_turn_duelist_var

; put card in Discard Pile temporarily, so that
; all cards attached are discarded as well.
	push af
	ldh a, [hTemp_ffa0]
	ld e, a
	call MovePlayAreaCardToDiscardPile

; if card was in Arena, swap selected Bench
; Pokemon with Arena, otherwise skip.
	ldh a, [hTemp_ffa0]
	or a
	jr nz, .skip_switch
	ldh a, [hTempPlayAreaLocation_ffa1]
	ld e, a
	call SwapArenaWithBenchPokemon

.skip_switch
; move card back to Hand from Discard Pile
; and adjust Play Area
	pop af
	call MoveDiscardPileCardToHand
	call AddCardToHand
	call ShiftAllPokemonToFirstPlayAreaSlots

	xor a
	ld [wDuelDisplayedScreen], a
	ret

LaprasWaterGunEffect:
	lb bc, 1, 0
	jp ApplyExtraWaterEnergy10DamageBonus

LaprasConfuseRayEffect:
	call Confusion50PercentEffect
	ret

Quickfreeze_InitialEffect:
	scf
	ret

Quickfreeze_Paralysis50PercentEffect:
	ldtx de, ParalysisInflictionCheckText
	call TossCoin_Bank1a
	jr c, .heads

; tails
	call SetWasUnsuccessful
	bank1call DrawDuelMainScene
	bank1call PrintFailedEffectText
	call WaitForWideTextBoxInput
	ret

.heads
	farcall ResetAttackAnimationIsPlaying
	ld a, DUELVARS_ARENA_CARD_LAST_TURN_STATUS
	get_turn_duelist_var
	push af
	push hl
	call ParalysisEffect
	ldh a, [hTempPlayAreaLocation_ff9d]
	ld b, a
	ld c, $00
	ldh a, [hWhoseTurn]
	ld h, a
	farcall PlayAttackAnimation
	farcall PlayStatusConditionQueueAnimations
	farcall WaitAttackAnimation
	bank1call ApplyStatusConditionQueue
	bank1call DrawDuelHUDs
	call PrintFailedEffectText
	call c, WaitForWideTextBoxInput
	pop hl
	pop af
	ld [hl], a
	ret

IceBreath_ZeroDamage:
	xor a
	call SetDefiniteDamage
	ret

IceBreath_RandomPokemonDamageEffect:
	call SwapTurn
	call PickRandomPlayAreaCard
	ld b, a
	ld de, 40
	call DealDamageToPlayAreaPokemon_RegularAnim
	call SwapTurn
	ret

FocusEnergyEffect:
	ld a, SUBSTATUS1_NEXT_TURN_DOUBLE_DAMAGE
	call SetAttackDoubleOrTripleDamageNextTurn
	ret

PlayerPickFireEnergyCardToDiscard:
	call CreateListOfFireEnergyAttachedToArena
	xor a ; PLAY_AREA_ARENA
	bank1call DisplayEnergyDiscardMenu
	bank1call HandleAttachedEnergyMenuInput
	ldh a, [hTempCardIndex_ff98]
	ldh [hTemp_ffa0], a
	ret

; returns carry if Arena card has no Fire/Rainbow Energy cards
CheckIfArenaCardHasFireOrRainbowEnergy:
	ld e, PLAY_AREA_ARENA
	call GetNumberOfAttachedFireAndRainbowEnergy
	cp 1
	ret

; returns number of Fire/Rainbow cards attached to Play Area card
; input:
; - e = location to check, i.e. PLAY_AREA_*
; output:
; - a = number of Fire + Rainbow energies
GetNumberOfAttachedFireAndRainbowEnergy:
	call GetPlayAreaCardAttachedEnergies
	ld a, [wAttachedEnergies + FIRE]
	ld hl, wAttachedEnergies + RAINBOW
	add [hl]
	ldtx hl, NotEnoughFireEnergyText
	ret

AIPickFireEnergyCardToDiscard:
	call CreateListOfFireEnergyAttachedToArena
	ld a, [wDuelTempList]
	ldh [hTemp_ffa0], a ; pick first in list
	ret

ArcanineFlamethrower_CheckEnergy:
	jp CheckIfArenaCardHasFireOrRainbowEnergy

ArcanineFlamethrower_PlayerSelectEffect:
	jp PlayerPickFireEnergyCardToDiscard

ArcanineFlamethrower_AISelectEffect:
	jp AIPickFireEnergyCardToDiscard

ArcanineFlamethrower_DiscardEffect:
	ldh a, [hTemp_ffa0]
	call DiscardCard
	ret

ArcanineLv45TakeDownEffect:
	ld a, 30
	call DealRecoilDamageToSelf
	ret

ArcanineQuickAttack_AIEffect:
	ld a, (10 + 30) / 2
	lb de, 10, 30
	call SetExpectedAIDamage
	ret

ArcanineQuickAttack_DamageBoostEffect:
	ld a, 20
	call AddDamageIfHeads
	ret

; return carry if has less than 2 Fire Energy cards
FlamesOfRage_CheckEnergy:
	ld e, PLAY_AREA_ARENA
	call GetNumberOfAttachedFireAndRainbowEnergy
	cp 2
	ret

FlamesOfRage_PlayerSelectEffect:
	ldtx hl, ChooseAndDiscard2FireEnergyCardsText
	call DrawWideTextBox_WaitForInput

	xor a
	ldh [hCurSelectionItem], a
	call CreateListOfFireEnergyAttachedToArena
	xor a ; PLAY_AREA_ARENA
	bank1call DisplayEnergyDiscardMenu
.loop_input
	bank1call HandleAttachedEnergyMenuInput
	ret c
	farcall GetNextPositionInTempList
	ldh a, [hTempCardIndex_ff98]
	ld [hl], a
	call RemoveCardFromDuelTempList
	ldh a, [hCurSelectionItem]
	cp 2
	ret nc ; return when 2 have been chosen
	bank1call UpdateAttachedEnergyMenu
	jr .loop_input

FlamesOfRage_AISelectEffect:
	call AIPickFireEnergyCardToDiscard
	ld a, [wDuelTempList + 1]
	ldh [hTempList + 1], a
	ret

FlamesOfRage_DiscardEffect:
	ldh a, [hTempList]
	call DiscardCard
	ldh a, [hTempList + 1]
	call DiscardCard
	ret

FlamesOfRage_AIEffect:
	ldh a, [hTempPlayAreaLocation_ff9d]
	jr CalculateFlamesOfRageDamage
FlamesOfRage_DamageBoostEffect:
	xor a ; PLAY_AREA_ARENA
CalculateFlamesOfRageDamage:
	ld e, a
	call GetCardDamageAndMaxHP
	call AddToDamage
	ret

RapidashStomp_AIEffect:
	ld a, (20 + 30) / 2
	lb de, 20, 30
	call SetExpectedAIDamage
	ret

RapidashStomp_DamageBoostEffect:
	ld a, 10
	call AddDamageIfHeads
	ret

RapidashAgilityEffect:
	ldtx de, IfHeadsDoNotReceiveDamageOrEffectText
	call TossCoin_Bank1a
	ret nc ; return if tails
	ld a, ATK_ANIM_AGILITY_PROTECT
	ld [wLoadedAttackAnimation], a
	ld a, SUBSTATUS1_AGILITY
	call ApplySubstatus1ToAttackingCard
	ret

; returns carry if Opponent has no Pokemon in bench
NinetalesLure_CheckBench:
	call CheckNonTurnDuelistHasBench
	ret

NinetalesLure_PlayerSelectEffect:
	ldtx hl, SelectBenchedPokemonToSwitchWithActiveText
	call DrawWideTextBox_WaitForInput
	call SwapTurn
	bank1call HasAlivePokemonInBench
.loop_input
	bank1call OpenPlayAreaScreenForSelection
	jr c, .loop_input
	ldh a, [hTempPlayAreaLocation_ff9d]
	ldh [hTemp_ffa0], a
	call SwapTurn
	ret

NinetalesLure_AISelectEffect:
	call AIFindTargetForBenchAttack
	ldh [hTemp_ffa0], a
	ret

NinetalesLure_SwitchEffect:
	call SwapTurn
	ldh a, [hTemp_ffa0]
	ld e, a
	bank1call HandlePlayAreaCardNoDamageOrEffect
	call nc, SwapArenaWithBenchPokemon
	call SwapTurn
	xor a
	ld [wDuelDisplayedScreen], a
	ret

FireBlast_CheckEnergy:
	jp CheckIfArenaCardHasFireOrRainbowEnergy

FireBlast_PlayerSelectEffect:
	jp PlayerPickFireEnergyCardToDiscard

FireBlast_AISelectEffect:
	jp AIPickFireEnergyCardToDiscard

FireBlast_DiscardEffect:
	ldh a, [hTemp_ffa0]
	call DiscardCard
	ret

CharmanderEmber_CheckEnergy:
	jp CheckIfArenaCardHasFireOrRainbowEnergy

CharmanderEmber_PlayerSelectEffect:
	jp PlayerPickFireEnergyCardToDiscard

CharmanderEmber_AISelectEffect:
	jp AIPickFireEnergyCardToDiscard

CharmanderEmber_DiscardEffect:
	ldh a, [hTemp_ffa0]
	call DiscardCard
	ret

; return carry if opponent has no deck cards
; or if no Fire energy cards
Wildfire_CheckDeckAndEnergy:
	call SwapTurn
	farcall CheckIfDeckIsEmpty
	call SwapTurn
	ret c
	jp CheckIfArenaCardHasFireOrRainbowEnergy

Wildfire_PlayerSelectEffect:
	ldtx hl, DiscardOppDeckAsManyFireEnergyCardsText
	call DrawWideTextBox_WaitForInput

	xor a
	ldh [hCurSelectionItem], a
	call CreateListOfFireEnergyAttachedToArena
	xor a ; PLAY_AREA_ARENA
	bank1call DisplayEnergyDiscardMenu

; show list to Player and for each card selected to discard,
; add it to hTempList (up to a maximum of 15)
; this will be the output used by Wildfire_DiscardEnergyEffect.
	xor a
	ld [wAttachedEnergyMenuDenominator], a
.loop
	ldh a, [hCurSelectionItem]
	ld [wAttachedEnergyMenuNumerator], a
	bank1call HandleAttachedEnergyMenuInput
	jr c, .done
	farcall GetNextPositionInTempList
	ldh a, [hTempCardIndex_ff98]
	ld [hl], a
	call RemoveCardFromDuelTempList
	jr c, .done
	ldh a, [hCurSelectionItem]
	cp 15
	jr nc, .done
	bank1call UpdateAttachedEnergyMenu
	jr .loop

.done
; return carry if no cards were discarded
	farcall GetNextPositionInTempList
	ld [hl], $ff
	ldh a, [hCurSelectionItem]
	cp 2
	ret

Wildfire_AISelectEffect:
; AI always chooses 0 cards to discard
	ld a, $ff
	ldh [hTempList + 0], a
	ret

Wildfire_DiscardEnergyEffect:
	ld hl, hTempList
.loop_discard
	ld a, [hli]
	cp $ff
	jr z, .done
	call DiscardCard
	jr .loop_discard
.done
	ret

Wildfire_DiscardDeckEffect:
	ld c, -1
	ld hl, hTempList
.loop_find_end
	inc c
	ld a, [hli]
	cp $ff
	jr nz, .loop_find_end

	; if number of cards to discard is larger
	; than actual cards in deck, cap it
	ld b, $00
	call SwapTurn
	ld a, DUELVARS_NUMBER_OF_CARDS_NOT_IN_DECK
	get_turn_duelist_var
	ld a, DECK_SIZE
	sub [hl]
	cp c
	jr nc, .capped
	ld c, a
.capped
	push bc
	inc c
	jr .start_discard
.loop_discard
	; discard top card from deck
	call DrawCardFromDeck
	call nc, PutCardInDiscardPile
.start_discard
	dec c
	jr nz, .loop_discard

	pop hl
	call LoadTxRam3
	ldtx hl, DiscardedCardsFromDeckText
	call DrawWideTextBox_PrintText
	call SwapTurn
	ret

MoltresLv35DiveBomb_AIEffect:
	ld a, 80
	lb de, 0, 80
	call SetExpectedAIDamage
	ret

MoltresLv35DiveBomb_Success50PercentEffect:
	ldtx de, AttackSuccessCheckText
	call TossCoin_Bank1a
	jr c, .heads
; tails
	xor a
	call SetDefiniteDamage
	call SetWasUnsuccessful
	ret
.heads
	ld a, ATK_ANIM_DIVE_BOMB
	ld [wLoadedAttackAnimation], a
	ret

FlareonQuickAttack_AIEffect:
	ld a, (10 + 30) / 2
	lb de, 10, 30
	call SetExpectedAIDamage
	ret

FlareonQuickAttack_DamageBoostEffect:
	ld a, 20
	call AddDamageIfHeads
	ret

FlareonFlamethrower_CheckEnergy:
	jp CheckIfArenaCardHasFireOrRainbowEnergy

FlareonFlamethrower_PlayerSelectEffect:
	jp PlayerPickFireEnergyCardToDiscard

FlareonFlamethrower_AISelectEffect:
	jp AIPickFireEnergyCardToDiscard

FlareonFlamethrower_DiscardEffect:
	ldh a, [hTemp_ffa0]
	call DiscardCard
	ret

MagmarFlamethrower_CheckEnergy:
	jp CheckIfArenaCardHasFireOrRainbowEnergy

MagmarFlamethrower_PlayerSelectEffect:
	jp PlayerPickFireEnergyCardToDiscard

MagmarFlamethrower_AISelectEffect:
	jp AIPickFireEnergyCardToDiscard

MagmarFlamethrower_DiscardEffect:
	ldh a, [hTemp_ffa0]
	call DiscardCard
	ret

MagmarSmokescreenEffect:
	ld a, SUBSTATUS2_SMOKESCREEN
	call ApplySubstatus2ToDefendingCard
	ret

MagmarLv31Smog_AIEffect:
	ld a, 10 / 2
	lb de, 0, 10
	call UpdateExpectedAIDamage_AccountForPoison
	ret

MagmarLv31Smog_Poison50PercentEffect:
	call Poison50PercentEffect
	ret

CharmeleonFlamethrower_CheckEnergy:
	jp CheckIfArenaCardHasFireOrRainbowEnergy

CharmeleonFlamethrower_PlayerSelectEffect:
	jp PlayerPickFireEnergyCardToDiscard

CharmeleonFlamethrower_AISelectEffect:
	jp AIPickFireEnergyCardToDiscard

CharmeleonFlamethrower_DiscardEffect:
	ldh a, [hTemp_ffa0]
	call DiscardCard
	ret

CharizardEnergyBurnEffect:
	scf
	ret

CharizardFireSpin_CheckEnergy:
	jr CheckIfArenaCardHasAtLeast2FireOrRainbowEnergyCards

CharizardFireSpin_PlayerSelectEffect:
	jr HandlePlayerSelect2CardsInDuelTempList

CharizardFireSpin_DiscardEffect:
	jr Discard2CardsFromTempList

CharizardFireSpin_AISelectEffect:
	jr AISelect2EnergyCardsAttachedToArena

; return carry if has less than 2 Fire Energy cards
CheckIfArenaCardHasAtLeast2FireOrRainbowEnergyCards:
	xor a ; PLAY_AREA_ARENA
	call CreateArenaOrBenchEnergyCardList
	call CountCardsInDuelTempList
	ldtx hl, NotEnoughEnergyCardsText
	cp 2
	ret

HandlePlayerSelect2CardsInDuelTempList:
	ldtx hl, ChooseAndDiscard2EnergyCardsText
	call DrawWideTextBox_WaitForInput

	xor a
	ldh [hCurSelectionItem], a
	xor a ; PLAY_AREA_ARENA
	call CreateArenaOrBenchEnergyCardList
	xor a ; PLAY_AREA_ARENA
	bank1call DisplayEnergyDiscardMenu

	ld a, 2
	ld [wAttachedEnergyMenuDenominator], a
.loop_input
	bank1call HandleAttachedEnergyMenuInput
	ret c
	farcall GetNextPositionInTempList
	ldh a, [hTempCardIndex_ff98]
	ld [hl], a
	ld hl, wAttachedEnergyMenuNumerator
	inc [hl]
	ldh a, [hCurSelectionItem]
	cp 2
	jr nc, .done
	ldh a, [hTempCardIndex_ff98]
	call RemoveCardFromDuelTempList
	bank1call UpdateAttachedEnergyMenu
	jr .loop_input
.done
	or a
	ret

AISelect2EnergyCardsAttachedToArena:
	xor a ; PLAY_AREA_ARENA
	call CreateArenaOrBenchEnergyCardList
	ld hl, wDuelTempList
	ld a, [hli]
	ldh [hTempList], a
	ld a, [hl]
	ldh [hTempList + 1], a
	ret

; discards first 2 cards in hTempList
Discard2CardsFromTempList:
	ld hl, hTempList
	ld a, [hli]
	call DiscardCard
	ld a, [hli]
	call DiscardCard
	ret

; returns carry if Pkmn Power cannot be used
; or if Arena card is not Charizard.
; unreferenced
EnergyBurnCheck_Unreferenced:
	xor a ; PLAY_AREA_ARENA
	bank1call CheckIsIncapableOfUsingPkmnPower
	ret c
	ld a, DUELVARS_ARENA_CARD
	push de
	get_turn_duelist_var
	call GetCardIDFromDeckIndex
	cp16 CHARIZARD_LV76
	pop de
	jr nz, .not_charizard
	or a
	ret
.not_charizard
	scf
	ret

CharizardAltEnergyBurnEffect:
	scf
	ret

CharizardAltFireSpin_CheckEnergy:
	jp CheckIfArenaCardHasAtLeast2FireOrRainbowEnergyCards

CharizardAltFireSpin_PlayerSelectEffect:
	jr HandlePlayerSelect2CardsInDuelTempList

CharizardAltFireSpin_DiscardEffect:
	jr Discard2CardsFromTempList

CharizardAltFireSpin_AISelectEffect:
	jr AISelect2EnergyCardsAttachedToArena

VulpixConfuseRayEffect:
	call Confusion50PercentEffect
	ret

FlareonRage_AIEffect:
	ldh a, [hTempPlayAreaLocation_ff9d]
	jr CalculateFlareonRageDamage
FlareonRage_DamageBoostEffect:
	xor a ; PLAY_AREA_ARENA
CalculateFlareonRageDamage:
	ld e, a
	call GetCardDamageAndMaxHP
	call AddToDamage
	ret

; returns carry if opponent has no deck or hand cards
MixUp_CheckHandAndDeck:
	call SwapTurn
	farcall CheckIfDeckIsEmpty
	jr c, .done
	ld a, DUELVARS_NUMBER_OF_CARDS_IN_HAND
	get_turn_duelist_var
	or a
	jr nz, .done
	ldtx hl, NoCardsInHandText
	scf
.done
	call SwapTurn
	ret

MixUp_ShuffleCardsEffect:
	call SwapTurn
	call CreateHandCardList
	bank1call SortCardsInDuelTempListByID

; first go through Hand to place
; all Pkmn cards in it in the Deck.
	ld hl, wDuelTempList
	ld c, $00
.loop_hand
	ld a, [hl]
	cp $ff
	jr z, .done_hand
	call .CheckIfCardIsPkmnCard
	jr nc, .next_hand
	; found Pkmn card, place in deck
	inc c
	ld a, [hl]
	call RemoveCardFromHand
	call ReturnCardToDeck
.next_hand
	inc hl
	jr .loop_hand

.done_hand
	ld a, c
	ldh [hCurSelectionItem], a
	push bc
	ldtx hl, AffectedByMixUpText
	call DrawWideTextBox_WaitForInput

	call ShuffleCardsInDeck
	call CreateDeckCardList
	pop bc
	ldh a, [hCurSelectionItem]
	or a
	jr z, .done ; if no cards were removed from Hand, return

; c holds the number of cards that were placed in the Deck.
; now pick Pkmn cards from the Deck to place in Hand.
	ld hl, wDuelTempList
.loop_deck
	ld a, [hl]
	call .CheckIfCardIsPkmnCard
	jr nc, .next_deck_card
	dec c
	ld a, [hl]
	call SearchCardInDeckAndAddToHand
	call AddCardToHand
.next_deck_card
	inc hl
	ld a, c
	or a
	jr nz, .loop_deck
.done
	call SwapTurn
	ret

; returns carry if card index in a is Pkmn card
.CheckIfCardIsPkmnCard:
	call LoadCardDataToBuffer2_FromDeckIndex
	ld a, [wLoadedCard2Type]
	cp TYPE_ENERGY
	ret

DancingEmbers_AIEffect:
	ld a, 80 / 2
	lb de, 0, 80
	call SetExpectedAIDamage
	ret

DancingEmbers_MultiplierEffect:
	ld hl, 10
	call LoadTxRam3
	ldtx de, DamageCheckXDamageTimesHeadsText
	ld a, 8
	call TossCoinATimes_Bank1a
	call ATimes10
	call SetDefiniteDamage
	ret

Firegiver_InitialEffect:
	scf
	ret

Firegiver_AddToHandEffect:
; fill wDuelTempList with all Fire Energy card
; deck indices that are in the Deck.
	ld a, DUELVARS_CARD_LOCATIONS
	get_turn_duelist_var
	ld de, wDuelTempList
	ld c, 0
.loop_cards
	ld a, [hl]
	cp CARD_LOCATION_DECK
	jr nz, .next
	push hl
	push de
	ld a, l
	call GetCardIDFromDeckIndex
	call GetCardType
	pop de
	pop hl
	cp TYPE_ENERGY_FIRE
	jr nz, .next
	ld a, l
	ld [de], a
	inc de
	inc c
.next
	inc l
	ld a, l
	cp DECK_SIZE
	jr c, .loop_cards
	ld a, $ff
	ld [de], a

; check how many were found
	ld a, c
	or a
	jr nz, .found
	ldtx hl, ThereWasNoFireEnergyText
	call DrawWideTextBox_WaitForInput
	call ShuffleCardsInDeck
	ret

.found
; pick a random number between 1 and 4,
; up to the maximum number of Fire Energy
; cards that were found.
	ld a, 4
	call Random
	inc a
	cp c
	jr c, .ok
	ld a, c

.ok
	ldh [hCurSelectionItem], a
; load correct attack animation depending
; on what side the effect is from.
	ld d, ATK_ANIM_FIREGIVER_PLAYER
	ld a, [wDuelistType]
	cp DUELIST_TYPE_PLAYER
	jr z, .player_1
	ld d, ATK_ANIM_FIREGIVER_OPP
.player_1
	ld a, d
	ld [wLoadedAttackAnimation], a

; start loop for adding Energy cards to hand
	ldh a, [hCurSelectionItem]
	ld c, a
	ld hl, wDuelTempList
.loop_energy
	push hl
	push bc
	farcall ResetAttackAnimationIsPlaying
	lb bc, PLAY_AREA_ARENA, $0
	ldh a, [hWhoseTurn]
	ld h, a
	farcall PlayAttackAnimation
	farcall WaitAttackAnimation

; load correct coordinates to update the number of cards
; in hand and deck during animation.
	lb bc, 18, 7 ; x, y for hand number
	ld e, 3 ; y for deck number
	ld a, [wLoadedAttackAnimation]
	cp ATK_ANIM_FIREGIVER_PLAYER
	jr z, .player_2
	lb bc, 4, 5 ; x, y for hand number
	ld e, 10 ; y for deck number

.player_2
; update and print number of cards in hand
	ld a, DUELVARS_NUMBER_OF_CARDS_IN_HAND
	get_turn_duelist_var
	inc a
	bank1call WriteTwoDigitNumberInTxSymbolFormat
; update and print number of cards in deck
	ld a, DUELVARS_NUMBER_OF_CARDS_NOT_IN_DECK
	get_turn_duelist_var
	ld a, DECK_SIZE - 1
	sub [hl]
	ld c, e
	bank1call WriteTwoDigitNumberInTxSymbolFormat
	pop bc
	pop hl

; load Fire Energy card index and add to hand
	ld a, [hli]
	call SearchCardInDeckAndAddToHand
	call AddCardToHand
	dec c
	jr nz, .loop_energy

; load the number of cards added to hand and print text
	ldh a, [hCurSelectionItem]
	ld l, a
	ld h, $00
	call LoadTxRam3
	ldtx hl, DrewFireEnergyFromDeckText
	call DrawWideTextBox_WaitForInput
	call ShuffleCardsInDeck
	ret

MoltresLv37DiveBomb_AIEffect:
	ld a, 70
	lb de, 0, 70
	call SetExpectedAIDamage
	ret

MoltresLv37DiveBomb_Success50PercentEffect:
	ldtx de, AttackSuccessCheckText
	call TossCoin_Bank1a
	jr c, .heads
; tails
	xor a
	call SetDefiniteDamage
	call SetWasUnsuccessful
	ret
.heads
	ld a, ATK_ANIM_DIVE_BOMB
	ld [wLoadedAttackAnimation], a
	ret

; output in de the number of energy cards
; attached to the Defending Pokemon times 10.
; used for attacks that deal 10x number of energy
; cards attached to the Defending card.
GetEnergyAttachedMultiplierDamage:
	call SwapTurn
	ld a, DUELVARS_CARD_LOCATIONS
	get_turn_duelist_var

	ld c, 0
.loop
	ld a, [hl]
	cp CARD_LOCATION_ARENA
	jr nz, .next
	; is in Arena
	ld a, l
	call GetCardIDFromDeckIndex
	call GetCardType
	and TYPE_ENERGY
	jr z, .next
	; is Energy attached to Arena card
	inc c
.next
	inc l
	ld a, l
	cp DECK_SIZE
	jr c, .loop

	call SwapTurn
	ld l, c
	ld h, 0
	ld b, 0
	add hl, hl ; hl =  2 * c
	add hl, hl ; hl =  4 * c
	add hl, bc ; hl =  5 * c
	add hl, hl ; hl = 10 * c
	ld e, l
	ld d, h
	ret

; returns carry if Arena card has no Psychic/Rainbow Energy cards
; output:
; - a = number of Psychic + Rainbow energies
CheckIfArenaCardHasPsychicOrRainbowEnergy:
	ld e, PLAY_AREA_ARENA
	call GetPlayAreaCardAttachedEnergies
	ld a, [wAttachedEnergies + PSYCHIC]
	ld hl, wAttachedEnergies + RAINBOW
	add [hl]
	ldtx hl, NotEnoughPsychicEnergyText
	cp 1
	ret

; draws list of Energy Cards in Discard Pile
; for Player to select from.
; the Player can select up to 2 cards from the list.
; these cards are given in $ff-terminated list
; in hTempList.
HandleEnergyCardsInDiscardPileSelection:
	push hl
	xor a
	ldh [hCurSelectionItem], a
	call CreateEnergyCardListFromDiscardPile_AllEnergy
	pop hl
	jr c, .finish

	call DrawWideTextBox_WaitForInput
.loop
; draws Discard Pile screen and textbox,
; and handles Player input
	bank1call InitAndDrawCardListScreenLayout
	ldtx hl, ChooseAnEnergyCardText
	ldtx de, DuelistDiscardPileText
	bank1call SetCardListHeaderAndInfoText
	bank1call DisplayCardList
	jr nc, .selected

; Player is trying to exit screen,
; but can select up to 2 cards total.
; prompt Player to confirm exiting screen.
	ld a, 2
	call AskWhetherToQuitSelectingCards
	jr c, .loop
	jr .finish

.selected
; a card was selected, so add it to list
	farcall GetNextPositionInTempList
	ldh a, [hTempCardIndex_ff98]
	ld [hl], a
	call RemoveCardFromDuelTempList
	or a
	jr z, .finish ; no more cards?
	ldh a, [hCurSelectionItem]
	cp 2
	jr c, .loop ; already selected 2 cards?

.finish
; place terminating byte on list
	farcall GetNextPositionInTempList
	ld [hl], $ff
	or a
	ret

AbraLv10PsyshockEffect:
	call Paralysis50PercentEffect
	ret

; returns carry if Pkmn Power cannot be used, and
; sets the correct text in hl for failure.
Curse_CheckDamageAndBench:
	call CheckIfCanUsePkmnPowerThisTurn
	ret c

; fail if Opponent only has 1 Pokemon in Play Area
	call SwapTurn
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	call SwapTurn
	ldtx hl, CannotUseSinceTheresOnly1PokemonText
	cp 2
	jr c, .set_carry

; fail if Opponent has no damage counters
	call SwapTurn
	call CheckIfPlayAreaHasAnyDamage
	call SwapTurn
	ldtx hl, NoPokemonWithDamageCountersText
	ret nc
.set_carry
	scf
	ret

Curse_PlayerSelectEffect:
	ldtx hl, ProcedureForCurseText
	bank1call DrawWholeScreenTextBox
	call SwapTurn
	xor a
	ldh [hCurSelectionItem], a
	bank1call SetupPlayAreaScreen
.start
	bank1call PrintPlayAreaCardList_EnableLCD
	push af
	ldh a, [hCurSelectionItem]
	ld hl, PlayAreaSelectionMenuParameters
	call InitializeMenuParameters
	pop af
	ld [wNumScrollMenuItems], a

; first pick a target to take 1 damage counter from.
.loop_input_first
	call DoFrame
	call HandleMenuInput
	jr nc, .loop_input_first
	cp $ff
	jr z, .cancel
	ldh [hCurSelectionItem], a
	ldh [hTempPlayAreaLocation_ffa1], a
	call GetCardDamageAndMaxHP
	or a
	jr nz, .picked_first
	; play sfx
	call PlaySFX_InvalidChoice
	jr .loop_input_first

.picked_first
; give 10 HP to card selected, draw the scene,
; then immediately revert this.
	ldh a, [hTempPlayAreaLocation_ffa1]
	add DUELVARS_ARENA_CARD_HP
	get_turn_duelist_var
	push af
	push hl
	add 10
	ld [hl], a
	bank1call PrintPlayAreaCardList_EnableLCD
	pop hl
	pop af
	ld [hl], a

; draw damage counter on cursor
	ldh a, [hTempPlayAreaLocation_ffa1]
	ld b, SYM_HP_NOK
	call DrawSymbolOnPlayAreaCursor

; handle input to pick the target to receive the damage counter.
.loop_input_second
	call DoFrame
	call HandleMenuInput
	jr nc, .loop_input_second
	ldh [hPlayAreaEffectTarget], a
	cp $ff
	jr nz, .a_press ; was a pressed?

; b press
; erase the damage counter symbol
; and loop back up again.
	ldh a, [hTempPlayAreaLocation_ffa1]
	ld b, SYM_SPACE
	call DrawSymbolOnPlayAreaCursor
	call EraseCursor
	jr .start

.a_press
	ld hl, hTempPlayAreaLocation_ffa1
	cp [hl]
	jr z, .loop_input_second ; same as first?
; a different Pokemon was picked,
; so store this Play Area location
; and erase the damage counter in the cursor.
	ldh a, [hTempPlayAreaLocation_ffa1]
	ld b, SYM_SPACE
	call DrawSymbolOnPlayAreaCursor
	call EraseCursor
	call SwapTurn
	or a
	ret

.cancel
; return carry if operation was cancelled.
	call SwapTurn
	scf
	ret

Curse_TransferDamageEffect:
; set Pkmn Power as used
	call SetUsedPkmnPowerThisTurnFlag

; figure out the type of duelist that used Curse.
; if it was the player, no need to draw the Play Area screen.
	call SwapTurn
	ld a, DUELVARS_DUELIST_TYPE
	call GetNonTurnDuelistVariable
	cp DUELIST_TYPE_PLAYER
	jr z, .vs_player

; vs. opponent
	bank1call SetupPlayAreaScreen
.vs_player
; transfer the damage counter to the targets that were selected.
	ldh a, [hPlayAreaEffectTarget]
	add DUELVARS_ARENA_CARD_HP
	get_turn_duelist_var
	sub 10
	ld [hl], a
	ldh a, [hTempPlayAreaLocation_ffa1]
	add DUELVARS_ARENA_CARD_HP
	ld l, a
	ld a, 10
	add [hl]
	ld [hl], a

	bank1call PrintPlayAreaCardList_EnableLCD
	ld a, DUELVARS_DUELIST_TYPE
	call GetNonTurnDuelistVariable
	cp DUELIST_TYPE_PLAYER
	jr z, .done
; vs. opponent
	ldh a, [hPlayAreaEffectTarget]
	ldh [hTempPlayAreaLocation_ff9d], a
	bank1call InitAndPrintPlayAreaCardInformationAndLocation_WithTextBox

.done
	ldh a, [hPlayAreaEffectTarget]
	bank1call LoadPlayAreaCardID_ToTempNonTurnDuelistCardID
	ldh a, [hPlayAreaEffectTarget]
	add DUELVARS_ARENA_CARD_HP
	get_turn_duelist_var
	call PrintKnockedOutIfHLZero
	call c, WaitForWideTextBoxInput
	call SwapTurn
	call ExchangeRNG
	bank1call HandleDestinyBondAndBetweenTurnKnockOuts
	ret

GengarDarkMind_PlayerSelectEffect:
	call HandlePlayerSelectOppBenchPkmn
	ret

GengarDarkMind_AISelectEffect:
	ld a, $ff
	ldh [hTemp_ffa0], a
	call CheckNonTurnDuelistHasBench
	ret c ; no bench
; just pick Pokemon with lowest remaining HP.
	call AIFindTargetForBenchAttack
	ldh [hTemp_ffa0], a
	ret

GengarDarkMind_DamageBenchEffect:
	ldh a, [hTemp_ffa0]
	cp $ff
	ret z ; no target chosen
	call SwapTurn
	ld b, a
	ld de, 10
	call DealDamageToPlayAreaPokemon_RegularAnim
	call SwapTurn
	ret

SleepingGasEffect:
	call Sleep50PercentOrNoEffect
	ret

DestinyBond_CheckEnergy:
	jp CheckIfArenaCardHasPsychicOrRainbowEnergy

DestinyBond_PlayerSelectEffect:
; handle input and display of Energy card list
	ld a, TYPE_ENERGY_PSYCHIC
	call CreateListOfEnergyAttachedToArena
	xor a ; PLAY_AREA_ARENA
	bank1call DisplayEnergyDiscardMenu
	bank1call HandleAttachedEnergyMenuInput
	ret c
	ldh a, [hTempCardIndex_ff98]
	ldh [hTemp_ffa0], a
	ret

DestinyBond_AISelectEffect:
; pick first card in list
	ld a, TYPE_ENERGY_PSYCHIC
	call CreateListOfEnergyAttachedToArena
	ld a, [wDuelTempList]
	ldh [hTemp_ffa0], a
	ret

DestinyBond_DiscardEffect:
	ldh a, [hTemp_ffa0]
	call DiscardCard
	ret

DestinyBond_DestinyBondEffect:
	ld a, SUBSTATUS1_DESTINY_BOND
	call ApplySubstatus1ToAttackingCard
	ret

LickEffect:
	call Paralysis50PercentEffect
	ret

EnergyConversion_CheckEnergy:
	call CreateEnergyCardListFromDiscardPile_AllEnergy
	ldtx hl, NoEnergyCardsInDiscardPileText
	ret

EnergyConversion_PlayerSelectEffect:
	ldtx hl, Choose2EnergyCardsFromDiscardPileForHandText
	call HandleEnergyCardsInDiscardPileSelection
	ret

EnergyConversion_AISelectEffect:
	call CreateEnergyCardListFromDiscardPile_AllEnergy
	ld hl, wDuelTempList
	ld de, hTempList
	ld c, 2
; select the first two energy cards found in Discard Pile
.loop
	ld a, [hli]
	cp $ff
	jr z, .done
	ld [de], a
	inc de
	dec c
	jr nz, .loop
.done
	ld a, $ff
	ld [de], a
	ret

EnergyConversion_AddToHandEffect:
; damage itself
	ld a, 10
	call DealRecoilDamageToSelf

; loop cards that were chosen
; until $ff is reached,
; and move them to the hand.
	ld hl, hTempList
	ld de, wDuelTempList
.loop_cards
	ld a, [hli]
	ld [de], a
	inc de
	cp $ff
	jr z, .done
	call MoveDiscardPileCardToHand
	call AddCardToHand
	jr .loop_cards

.done
	call IsPlayerTurn
	ret c
	bank1call DisplayCardListDetails
	ret

HaunterHypnosisEffect:
	call SleepEffect
	ret

; return carry if Defending Pokemon is not asleep
DreamEaterEffect:
	ld a, DUELVARS_ARENA_CARD_STATUS
	call GetNonTurnDuelistVariable
	and CNF_SLP_PRZ
	cp ASLEEP
	ret z
; not asleep, set carry and load text
	ldtx hl, OpponentIsNotAsleepText
	scf
	ret

TransparencyEffect:
	scf
	ret

HaunterNightmareEffect:
	call SleepEffect
	ret

; returns carry if neither the Turn Duelist or
; the non-Turn Duelist have any deck cards.
Prophecy_CheckDeck:
	ld a, DUELVARS_NUMBER_OF_CARDS_NOT_IN_DECK
	get_turn_duelist_var
	cp DECK_SIZE
	jr c, .no_carry
	ld a, DUELVARS_NUMBER_OF_CARDS_NOT_IN_DECK
	call GetNonTurnDuelistVariable
	cp DECK_SIZE
	jr c, .no_carry
	ldtx hl, NoCardsLeftInTheDeckText
	scf
	ret
.no_carry
	or a
	ret

Prophecy_PlayerSelectEffect:
.start
	ldtx hl, ProcedureForProphecyText
	bank1call DrawWholeScreenTextBox
.select_deck
	bank1call DrawDuelMainScene
	ldtx hl, SelectTargetDeckYoursOppsText
	call TwoItemHorizontalMenu
	ldh a, [hKeysHeld]
	and PAD_B
	jr nz, .start ; loop back to start

	ldh a, [hCurScrollMenuItem]
	ldh [hTempList], a ; store selection in first position in list
	or a
	jr z, .turn_duelist

; non-turn duelist
	ld a, DUELVARS_NUMBER_OF_CARDS_NOT_IN_DECK
	call GetNonTurnDuelistVariable
	cp DECK_SIZE
	jr nc, .select_deck ; no cards, go back to deck selection
	call SwapTurn
	call HandleProphecyScreen
	call SwapTurn
	ret

.turn_duelist
	ld a, DUELVARS_NUMBER_OF_CARDS_NOT_IN_DECK
	get_turn_duelist_var
	cp DECK_SIZE
	jr nc, .select_deck ; no cards, go back to deck selection
	call HandleProphecyScreen
	ret

Prophecy_AISelectEffect:
; AI doesn't ever choose this attack
; so this it does no sorting.
	ld a, $ff
	ldh [hTemp_ffa0], a
	ret

Prophecy_ReorderDeckEffect:
	ld hl, hTempList
	ld a, [hli]
	or a
	jr z, .ReorderCards ; turn duelist's deck
	cp $ff
	ret z

	; non-turn duelist's deck
	call SwapTurn
	call .ReorderCards
	call SwapTurn
	ret

.ReorderCards:
	ld c, 0
; add selected cards to hand in the specified order
.loop_add_hand
	ld a, [hli]
	cp $ff
	jr z, .dec_hl
	call SearchCardInDeckAndAddToHand
	inc c
	jr .loop_add_hand

.dec_hl
; go to last card that was in the list
	dec hl
	dec hl

.loop_return_deck
; return the cards to the top of the deck
	ld a, [hld]
	call ReturnCardToDeck
	dec c
	jr nz, .loop_return_deck
	call IsPlayerTurn
	ret c
	; print text in case it was the opponent
	ldtx hl, RearrangedDuelistsDeckText
	call DrawWideTextBox_WaitForInput
	ret

; draw and handle Player selection for reordering
; the top 3 cards of Deck.
; the resulting list is output in order in hTempList.
HandleProphecyScreen:
	ld a, DUELVARS_NUMBER_OF_CARDS_NOT_IN_DECK
	get_turn_duelist_var
	ld b, a
	ld a, DECK_SIZE
	sub [hl] ; a = number of cards in deck

; store in c the number of cards that will be reordered.
; this number is 3, unless the deck as fewer cards than
; that in which case it will be the number of cards remaining.
	ld c, 3
	cp c
	jr nc, .got_number_cards
	ld c, a ; store number of remaining cards in c
.got_number_cards
	ld a, c
	inc a
	ld [wNumberOfCardsToOrder], a

; store in wDuelTempList the cards
; at top of Deck to be reordered.
	ld a, b
	add DUELVARS_DECK_CARDS
	ld l, a
	ld de, wDuelTempList
.loop_top_cards
	ld a, [hli]
	ld [de], a
	inc de
	dec c
	jr nz, .loop_top_cards
	ld a, $ff ; terminating byte
	ld [de], a

.start
	call CountCardsInDuelTempList
	ld b, a
	ld a, 1 ; start at 1
	ldh [hCurSelectionItem], a

; initialize buffer ahead in wDuelTempList.
	ld hl, wDuelTempList + 10
	xor a
.loop_init_buffer
	ld [hli], a
	dec b
	jr nz, .loop_init_buffer
	ld [hl], $ff

	bank1call InitAndDrawCardListScreenLayout
	ldtx hl, ChooseTheOrderOfTheCardsText
	ldtx de, DuelistDeckText
	bank1call SetCardListHeaderAndInfoText
	bank1call PrintSortNumberInCardList_SetPointer

.loop_selection
	bank1call DisplayCardList
	jr c, .clear

; first check if this card was already selected
	ldh a, [hCurScrollMenuItem]
	ld e, a
	ld d, $00
	ld hl, wDuelTempList + 10
	add hl, de
	ld a, [hl]
	or a
	jr nz, .loop_selection ; already chosen

; being here means card hasn't been selected yet,
; so add its order number to buffer and increment
; the sort number for the next card.
	ldh a, [hCurSelectionItem]
	ld [hl], a
	inc a
	ldh [hCurSelectionItem], a
	bank1call PrintSortNumberInCardList_CallFromPointer
	ldh a, [hCurSelectionItem]
	ld hl, wNumberOfCardsToOrder
	cp [hl]
	jr c, .loop_selection ; still more cards

; confirm that the ordering has been completed
	call EraseCursor
	ldtx hl, IsThisOKText
	call YesOrNoMenuWithText_LeftAligned
	jr c, .start ; if not, return back to beginning of selection

; write in hTempList the card list
; in order that was selected.
	ld hl, wDuelTempList + 10
	ld de, wDuelTempList
	ld c, 0
.loop_order
	ld a, [hli]
	cp $ff
	jr z, .done
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
	jr .loop_order
; now hTempList has the list of card deck indices
; in the order selected to be place on top of the deck.

.done
	ld b, $00
	ld hl, hTempList + 1
	add hl, bc
	ld [hl], $ff ; terminating byte
	or a
	ret

.clear
; check if any reordering was done.
	ld hl, hCurSelectionItem
	ld a, [hl]
	cp 1
	jr z, .loop_selection ; none done, go back
; clear the order that was selected thus far.
	dec a
	ld [hl], a
	ld c, a
	ld hl, wDuelTempList + 10
.loop_clear
	ld a, [hli]
	cp c
	jr nz, .loop_clear
	; clear this byte
	dec hl
	ld [hl], $00
	bank1call PrintSortNumberInCardList_CallFromPointer
	jr .loop_selection

HypnoDarkMind_PlayerSelectEffect:
	call HandlePlayerSelectOppBenchPkmn
	ret

HypnoDarkMind_AISelectEffect:
	ld a, $ff
	ldh [hTemp_ffa0], a
	call CheckNonTurnDuelistHasBench
	ret c ; no bench
; just pick Pokemon with lowest remaining HP.
	call AIFindTargetForBenchAttack
	ldh [hTemp_ffa0], a
	ret

HypnoDarkMind_DamageBenchEffect:
	ldh a, [hTemp_ffa0]
	cp $ff
	ret z ; no target chosen
	call SwapTurn
	ld b, a
	ld de, 10
	call DealDamageToPlayAreaPokemon_RegularAnim
	call SwapTurn
	ret

DrowzeeConfuseRayEffect:
	call Confusion50PercentEffect
	ret

InvisibleWallEffect:
	scf
	ret

MrMimeMeditateEffect:
; add damage counters of Defending card to damage
	call SwapTurn
	ld e, PLAY_AREA_ARENA
	call GetCardDamageAndMaxHP
	call SwapTurn
	call AddToDamage
	ret

; returns carry if Damage Swap cannot be used.
DamageSwap_CheckDamage:
	ldh a, [hTempPlayAreaLocation_ff9d]
	ldh [hTemp_ffa0], a
	call CheckIfPlayAreaHasAnyDamage
	jr c, .no_damage
	ldh a, [hTempPlayAreaLocation_ff9d]
	bank1call CheckIsIncapableOfUsingPkmnPower
	ret
.no_damage
	ldtx hl, NoPokemonWithDamageCountersText
	scf
	ret

DamageSwap_SelectAndSwapEffect:
	ld a, DUELVARS_DUELIST_TYPE
	get_turn_duelist_var
	cp DUELIST_TYPE_PLAYER
	jr z, .player
; non-player
	bank1call SetupPlayAreaScreen
	bank1call PrintPlayAreaCardList_EnableLCD
	ret

.player
	ldtx hl, ProcedureForDamageSwapText
	bank1call DrawWholeScreenTextBox
	xor a
	ldh [hCurSelectionItem], a
	bank1call SetupPlayAreaScreen

.start
	bank1call PrintPlayAreaCardList_EnableLCD
	push af
	ldh a, [hCurSelectionItem]
	ld hl, PlayAreaSelectionMenuParameters
	call InitializeMenuParameters
	pop af
	ld [wNumScrollMenuItems], a

; handle selection of Pokemon to take damage from
.loop_input_first
	call DoFrame
	call HandleMenuInput
	jr nc, .loop_input_first
	cp $ff
	ret z ; quit when B button is pressed

	ldh [hTempPlayAreaLocation_ffa1], a
	ldh [hCurSelectionItem], a

; if card has no damage, play sfx and return to start
	call GetCardDamageAndMaxHP
	or a
	jr z, .no_damage

; take damage away temporarily to draw UI.
	ldh a, [hTempPlayAreaLocation_ffa1]
	add DUELVARS_ARENA_CARD_HP
	get_turn_duelist_var
	push af
	push hl
	add 10
	ld [hl], a
	bank1call PrintPlayAreaCardList_EnableLCD
	pop hl
	pop af
	ld [hl], a

; draw damage counter in cursor
	ldh a, [hTempPlayAreaLocation_ffa1]
	ld b, SYM_HP_NOK
	call DrawSymbolOnPlayAreaCursor

; handle selection of Pokemon to give damage to
.loop_input_second
	call DoFrame
	call HandleMenuInput
	jr nc, .loop_input_second
	; if B is pressed, return damage counter
	; to card that it was taken from
	cp $ff
	jr z, .update_ui

; try to give the card selected the damage counter
; if it would KO, ignore it.
	ldh [hPlayAreaEffectTarget], a
	ldh [hCurSelectionItem], a
	call TryGiveDamageCounter_DamageSwap
	jr c, .loop_input_second

	ld a, OPPACTION_6B15
	call SetOppAction_SerialSendDuelData

.update_ui
	ldh a, [hTempPlayAreaLocation_ffa1]
	ld b, SYM_SPACE
	call DrawSymbolOnPlayAreaCursor
	call EraseCursor
	jr .start

.no_damage
	call PlaySFX_InvalidChoice
	jr .loop_input_first

; tries to give damage counter to hPlayAreaEffectTarget,
; and if successful updates UI screen.
DamageSwap_SwapEffect:
	call TryGiveDamageCounter_DamageSwap
	ret c
	bank1call PrintPlayAreaCardList_EnableLCD
	or a
	ret

; tries to give the damage counter to the target
; chosen by the Player (hPlayAreaEffectTarget).
; if the damage counter would KO card, then do
; not give the damage counter and return carry.
TryGiveDamageCounter_DamageSwap:
	ldh a, [hTempPlayAreaLocation_ffa1]
	ld l, a
	ldh a, [hPlayAreaEffectTarget]
	cp l
	ret z ; both targets are the same, exit
	add DUELVARS_ARENA_CARD_HP
	get_turn_duelist_var
	sub 10
	jr z, .set_carry ; would bring HP to zero?
; has enough HP to receive a damage counter
	ld [hl], a
	ldh a, [hTempPlayAreaLocation_ffa1]
	add DUELVARS_ARENA_CARD_HP
	ld l, a
	ld a, 10
	add [hl]
	ld [hl], a
	or a
	ret
.set_carry
	scf
	ret

AlakazamConfuseRayEffect:
	call Confusion50PercentEffect
	ret

Psywave_AIEffect:
	call Psywave_DamageMultiplierEffect
	jp SetDefiniteAIDamage

Psywave_DamageMultiplierEffect:
	call GetEnergyAttachedMultiplierDamage
	ld hl, wDamage
	ld [hl], e
	inc hl
	ld [hl], d
	ret

; returns carry if neither Duelist has evolved Pokemon.
DevolutionBeam_CheckPlayArea:
	call CheckIfTurnDuelistHasEvolvedCards
	ret nc
	call SwapTurn
	call CheckIfTurnDuelistHasEvolvedCards
	call SwapTurn
	ldtx hl, NoEvolvedPokemonText
	ret

; returns carry of Player cancelled selection.
; otherwise, output in hTemp_ffa0 which Play Area
; was selected ($0 = own Play Area, $1 = opp. Play Area)
; and in hTempPlayAreaLocation_ffa1 selected card.
DevolutionBeam_PlayerSelectEffect:
	ldtx hl, ProcedureForDevolutionBeamText
	bank1call DrawWholeScreenTextBox

.start
	bank1call DrawDuelMainScene
	ldtx hl, SelectTargetPlayAreaYoursOppsText
	call TwoItemHorizontalMenu
	ldh a, [hKeysHeld]
	and PAD_B
	jr nz, .set_carry

; a Play Area was selected
	ldh a, [hCurScrollMenuItem]
	or a
	jr nz, .opp_chosen

; player chosen
	call HandleEvolvedCardSelection
	jr c, .start

	xor a
.store_selection
	ld hl, hTemp_ffa0
	ld [hli], a ; store which Duelist Play Area selected
	ldh a, [hTempPlayAreaLocation_ff9d]
	ld [hl], a ; store which card selected
	or a
	ret

.opp_chosen
	call SwapTurn
	call HandleEvolvedCardSelection
	call SwapTurn
	jr c, .start
	ld a, $01
	jr .store_selection

.set_carry
	scf
	ret

DevolutionBeam_AISelectEffect:
	ld a, $01 ; always choose player's side
	ldh [hTemp_ffa0], a
	call SwapTurn
	call FindFirstNonBasicCardInPlayArea
	call SwapTurn
	jr c, .found
	xor a
	ldh [hTemp_ffa0], a
	call FindFirstNonBasicCardInPlayArea
.found
	ldh [hTempPlayAreaLocation_ffa1], a
	ret

DevolutionBeam_LoadAnimation:
	xor a ; ATK_ANIM_NONE
	ld [wLoadedAttackAnimation], a
	ret

DevolutionBeam_DevolveEffect:
	ldh a, [hTemp_ffa0]
	or a
	jr z, .DevolvePokemon
	cp $ff
	ret z

; opponent's Play Area
	ldh a, [hTempPlayAreaLocation_ffa1]
	or a
	jr nz, .skip_handle_no_damage_effect
	call HandleNoDamageOrEffect
	jr c, .unaffected
.skip_handle_no_damage_effect
	call SwapTurn
	call .DevolvePokemon
	call SwapTurn
.unaffected
	ret

.DevolvePokemon:
	farcall ResetAttackAnimationIsPlaying
	ld a, ATK_ANIM_DEVOLUTION_BEAM
	ld [wLoadedAttackAnimation], a
	ldh a, [hTempPlayAreaLocation_ffa1]
	ld b, a
	ld c, $00
	ldh a, [hWhoseTurn]
	ld h, a
	farcall PlayAttackAnimation
	farcall WaitAttackAnimation

; load selected card's data
	ldh a, [hTempPlayAreaLocation_ffa1]
	ldh [hTempPlayAreaLocation_ff9d], a
	ld [wTempPlayAreaLocation_cceb], a
	add DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call LoadCardDataToBuffer1_FromDeckIndex

; check if card is affected
	ld a, [wLoadedCard1ID]
	ld [wTempNonTurnDuelistCardID], a
	ld a, [wLoadedCard1ID + 1]
	ld [wTempNonTurnDuelistCardID + 1], a
	ld de, 0
	ldh a, [hTempPlayAreaLocation_ff9d]
	or a
	jr nz, .skip_substatus_check
	bank1call HandleNoDamageOrEffectSubstatus
	jr c, .check_no_damage_effect
.skip_substatus_check
	bank1call HandleTransparency
.check_no_damage_effect
	bank1call CheckNoDamageOrEffect
	jr nc, .devolve
	call DrawWideTextBox_WaitForInput
	ret

.devolve
	ldh a, [hTempPlayAreaLocation_ffa1]
	ldh [hTempPlayAreaLocation_ff9d], a
	add DUELVARS_ARENA_CARD
	get_turn_duelist_var
	bank1call GetCardOneStageBelow
	call PrintDevolvedCardNameAndLevelText

	ld a, d
	call UpdateDevolvedCardHPAndStage
	call ResetDevolvedCardStatus

; add the evolved card to the hand
	ld a, e
	call AddCardToHand

; check if this devolution KO's card
	ldh a, [hTempPlayAreaLocation_ffa1]
	call PrintPlayAreaCardKnockedOutIfNoHP

	xor a
	ld [wDuelDisplayedScreen], a
	ret

; returns carry if Turn Duelist
; has no Stage1 or Stage2 cards in Play Area.
CheckIfTurnDuelistHasEvolvedCards:
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	ld d, h
	ld e, DUELVARS_ARENA_CARD_STAGE
.loop
	ld a, [hli]
	cp $ff
	jr z, .set_carry
	ld a, [de]
	inc de
	or a
	jr z, .loop ; is Basic Stage
	ret
.set_carry
	scf
	ret

; handles Player selection of an evolved card in Play Area.
; returns carry if Player cancelled operation.
HandleEvolvedCardSelection:
	bank1call HasAlivePokemonInPlayArea
.loop
	bank1call OpenPlayAreaScreenForSelection
	ret c
	ldh a, [hTempPlayAreaLocation_ff9d]
	add DUELVARS_ARENA_CARD_STAGE
	get_turn_duelist_var
	or a
	jr z, .loop ; if Basic, loop
	ret

; finds first occurrence in Play Area
; of Stage 1 or 2 card, and outputs its
; Play Area location in a, with carry set.
; if none found, don't return carry set.
FindFirstNonBasicCardInPlayArea:
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	ld c, a

	ld b, PLAY_AREA_ARENA
	ld l, DUELVARS_ARENA_CARD_STAGE
.loop
	ld a, [hli]
	or a
	jr nz, .not_basic
	inc b
	dec c
	jr nz, .loop
	or a
	ret
.not_basic
	ld a, b
	scf
	ret

NeutralizingShieldEffect:
	scf
	ret

MewPsyshockEffect:
	call Paralysis50PercentEffect
	ret

Psychic_AIEffect:
	call Psychic_DamageBoostEffect
	jp SetDefiniteAIDamage

Psychic_DamageBoostEffect:
	call GetEnergyAttachedMultiplierDamage
	ld hl, wDamage
	ld a, e
	add [hl]
	ld [hli], a
	ld a, d
	adc [hl]
	ld [hl], a
	ret

Barrier_CheckEnergy:
	jp CheckIfArenaCardHasPsychicOrRainbowEnergy

Barrier_PlayerSelectEffect:
	ld a, TYPE_ENERGY_PSYCHIC
	call CreateListOfEnergyAttachedToArena
	xor a ; PLAY_AREA_ARENA
	bank1call DisplayEnergyDiscardMenu
	bank1call HandleAttachedEnergyMenuInput
	ret c
	ldh a, [hTempCardIndex_ff98]
	ldh [hTemp_ffa0], a
	ret

Barrier_AISelectEffect:
; AI picks the first energy in list
	ld a, TYPE_ENERGY_PSYCHIC
	call CreateListOfEnergyAttachedToArena
	ld a, [wDuelTempList]
	ldh [hTemp_ffa0], a
	ret

Barrier_DiscardEffect:
	ldh a, [hTemp_ffa0]
	call DiscardCard
	ret

Barrier_BarrierEffect:
	ld a, SUBSTATUS1_BARRIER
	call ApplySubstatus1ToAttackingCard
	ret

MewtwoAltEnergyAbsorption_CheckDiscardPile:
	call CreateEnergyCardListFromDiscardPile_AllEnergy
	ldtx hl, NoEnergyCardsInDiscardPileText
	ret

MewtwoAltEnergyAbsorption_PlayerSelectEffect:
	ldtx hl, Choose2EnergyCardsFromDiscardPileToAttachText
	call HandleEnergyCardsInDiscardPileSelection
	ret

MewtwoAltEnergyAbsorption_AISelectEffect:
; AI picks first 2 energy cards
	call CreateEnergyCardListFromDiscardPile_AllEnergy
	ld hl, wDuelTempList
	ld de, hTempList
	ld c, 2
.loop
	ld a, [hli]
	cp $ff
	jr z, .done
	ld [de], a
	inc de
	dec c
	jr nz, .loop
.done
	ld a, $ff ; terminating byte
	ld [de], a
	ret

MewtwoAltEnergyAbsorption_AddToHandEffect:
	ld hl, hTempList
.asm_69c9d
	ld a, [hli]
	cp $ff
	ret z
	push hl
	call MoveDiscardPileCardToHand
	get_turn_duelist_var
	ld [hl], CARD_LOCATION_ARENA
	pop hl
	jr .asm_69c9d

MewtwoEnergyAbsorption_CheckDiscardPile:
	call CreateEnergyCardListFromDiscardPile_AllEnergy
	ldtx hl, NoEnergyCardsInDiscardPileText
	ret

MewtwoEnergyAbsorption_PlayerSelectEffect:
	ldtx hl, Choose2EnergyCardsFromDiscardPileToAttachText
	call HandleEnergyCardsInDiscardPileSelection
	ret

MewtwoEnergyAbsorption_AISelectEffect:
; AI picks first 2 energy cards
	call CreateEnergyCardListFromDiscardPile_AllEnergy
	ld hl, wDuelTempList
	ld de, hTempList
	ld c, 2
.loop
	ld a, [hli]
	cp $ff
	jr z, .done
	ld [de], a
	inc de
	dec c
	jr nz, .loop
.done
	ld a, $ff ; terminating byte
	ld [de], a
	ret

MewtwoEnergyAbsorption_AddToHandEffect:
	ld hl, hTempList
.loop
	ld a, [hli]
	cp $ff
	ret z
	push hl
	call MoveDiscardPileCardToHand
	get_turn_duelist_var
	ld [hl], CARD_LOCATION_ARENA
	pop hl
	jr .loop

; returns carry if Strange Behavior cannot be used.
StrangeBehavior_CheckDamage:
; does Play Area have any damage counters?
	ldh a, [hTempPlayAreaLocation_ff9d]
	ldh [hTemp_ffa0], a
	call CheckIfPlayAreaHasAnyDamage
	ldtx hl, NoPokemonWithDamageCountersText
	jr c, .set_carry
; can Slowbro receive any damage counters without KO-ing?
	ldh a, [hTempPlayAreaLocation_ff9d]
	add DUELVARS_ARENA_CARD_HP
	get_turn_duelist_var
	ldtx hl, CannotUseBecauseItWillBeKnockedOutText
	cp 10 + 10
	jr c, .set_carry
; can Pkmn Power be used?
	ldh a, [hTempPlayAreaLocation_ff9d]
	bank1call CheckIsIncapableOfUsingPkmnPower
	ret

.set_carry
	scf
	ret

StrangeBehavior_SelectAndSwapEffect:
	ld a, DUELVARS_DUELIST_TYPE
	get_turn_duelist_var
	cp DUELIST_TYPE_PLAYER
	jr z, .player

; not player
	bank1call SetupPlayAreaScreen
	bank1call PrintPlayAreaCardList_EnableLCD
	ret

.player
	ldtx hl, ProcedureForStrangeBehaviorText
	bank1call DrawWholeScreenTextBox

	xor a
	ldh [hCurSelectionItem], a
	bank1call SetupPlayAreaScreen
.start
	bank1call PrintPlayAreaCardList_EnableLCD
	push af
	ldh a, [hCurSelectionItem]
	ld hl, PlayAreaSelectionMenuParameters
	call InitializeMenuParameters
	pop af

	ld [wNumScrollMenuItems], a
.loop_input
	call DoFrame
	call HandleMenuInput
	jr nc, .loop_input
	cp -1
	ret z ; return when B button is pressed

	ldh [hCurSelectionItem], a
	ldh [hTempPlayAreaLocation_ffa1], a
	ld hl, hTemp_ffa0
	cp [hl]
	jr z, .play_sfx ; can't select Slowbro itself

	call GetCardDamageAndMaxHP
	or a
	jr z, .play_sfx ; can't select card without damage

	call TryGiveDamageCounter_StrangeBehavior
	jr c, .play_sfx
	ld a, OPPACTION_6B15
	call SetOppAction_SerialSendDuelData
	jr .start

.play_sfx
	call PlaySFX_InvalidChoice
	jr .loop_input

StrangeBehavior_SwapEffect:
	call TryGiveDamageCounter_StrangeBehavior
	ret c
	bank1call PrintPlayAreaCardList_EnableLCD
	or a
	ret

; tries to give the damage counter to the target
; chosen by the Player (hTemp_ffa0).
; if the damage counter would KO card, then do
; not give the damage counter and return carry.
TryGiveDamageCounter_StrangeBehavior:
	ldh a, [hTemp_ffa0]
	add DUELVARS_ARENA_CARD_HP
	get_turn_duelist_var
	sub 10
	jr z, .set_carry  ; would bring HP to zero?
; has enough HP to receive a damage counter
	ld [hl], a
	ldh a, [hTempPlayAreaLocation_ffa1]
	add DUELVARS_ARENA_CARD_HP
	ld l, a
	ld a, 10
	add [hl]
	ld [hl], a
	or a
	ret
.set_carry
	scf
	ret

SlowbroPsyshockEffect:
	call Paralysis50PercentEffect
	ret

SpacingOut_CheckDamage:
	ld e, PLAY_AREA_ARENA
	call GetCardDamageAndMaxHP
	ldtx hl, NoDamageCountersText
	cp 10
	ret

SpacingOut_Success50PercentEffect:
	ldtx de, AttackSuccessCheckText
	call TossCoin_Bank1a
	ldh [hTemp_ffa0], a
	jp nc, SetWasUnsuccessful
	ld a, ATK_ANIM_RECOVER
	ld [wLoadedAttackAnimation], a
	ret

SpacingOut_HealEffect:
	ldh a, [hTemp_ffa0]
	or a
	ret z ; coin toss was tails
	ld de, 10
	call ApplyAndAnimateHPRecovery
	ret

; sets carry if no Trainer cards in the Discard Pile.
Scavenge_CheckDiscardPile:
	call CheckIfArenaCardHasPsychicOrRainbowEnergy
	ret c
	call CreateTrainerCardListFromDiscardPile
	ldtx hl, NoTrainerCardsInDiscardPileText
	ret

Scavenge_PlayerSelectEnergyEffect:
	ld a, TYPE_ENERGY_PSYCHIC
	call CreateListOfEnergyAttachedToArena
	xor a ; PLAY_AREA_ARENA
	bank1call DisplayEnergyDiscardMenu
	bank1call HandleAttachedEnergyMenuInput
	ret c
	ldh a, [hTempCardIndex_ff98]
	ldh [hTemp_ffa0], a
	or a
	ret

Scavenge_AISelectEffect:
; AI picks first Energy card in list
	ld a, TYPE_ENERGY_PSYCHIC
	call CreateListOfEnergyAttachedToArena
	ld a, [wDuelTempList]
	ldh [hTemp_ffa0], a
; AI picks first Trainer card in list
	call CreateTrainerCardListFromDiscardPile
	ld a, [wDuelTempList]
	ldh [hTempPlayAreaLocation_ffa1], a
	ret

Scavenge_DiscardEffect:
	ldh a, [hTemp_ffa0]
	call DiscardCard
	ret

Scavenge_PlayerSelectTrainerEffect:
	call CreateTrainerCardListFromDiscardPile
	bank1call InitAndDrawCardListScreenLayout_WithSelectCheckMenu
	ldtx hl, PleaseSelectCardText
	ldtx de, DuelistDiscardPileText
	bank1call SetCardListHeaderAndInfoText
.loop_input
	bank1call DisplayCardList
	jr c, .loop_input
	ldh a, [hTempCardIndex_ff98]
	ldh [hTempPlayAreaLocation_ffa1], a
	ret

Scavenge_AddToHandEffect:
	ldh a, [hTempPlayAreaLocation_ffa1]
	call MoveDiscardPileCardToHand
	call AddCardToHand
	call IsPlayerTurn
	ret c
	ldh a, [hTempPlayAreaLocation_ffa1]
	ldtx hl, WasPlacedInTheHandText
	bank1call DisplayCardDetailScreen
	ret

SlowpokeAmnesia_CheckAttacks:
	call CheckIfDefendingCardHasAnyAttacks
	ret

SlowpokeAmnesia_PlayerSelectEffect:
	call PlayerPickAttackForAmnesia
	ret

SlowpokeAmnesia_AISelectEffect:
	call AIPickAttackForAmnesia
	ret

SlowpokeAmnesia_DisableEffect:
	call ApplyAmnesiaToAttack
	ret

; returns carry if Arena card has no Psychic/Rainbow Energy attached
; or if it doesn't have any damage counters.
KadabraRecover_CheckEnergyHP:
	call CheckIfArenaCardHasPsychicOrRainbowEnergy
	ret c
	call GetCardDamageAndMaxHP
	ldtx hl, NoDamageCountersText
	cp 10
	ret

KadabraRecover_PlayerSelectEffect:
	ld a, TYPE_ENERGY_PSYCHIC
	call CreateListOfEnergyAttachedToArena
	xor a ; PLAY_AREA_ARENA
	bank1call DisplayEnergyDiscardMenu
	bank1call HandleAttachedEnergyMenuInput
	ret c
	ldh a, [hTempCardIndex_ff98]
	ldh [hTemp_ffa0], a ; store card chosen
	ret

KadabraRecover_AISelectEffect:
	ld a, TYPE_ENERGY_PSYCHIC
	call CreateListOfEnergyAttachedToArena
	ld a, [wDuelTempList] ; pick first card
	ldh [hTemp_ffa0], a
	ret

KadabraRecover_DiscardEffect:
	ldh a, [hTemp_ffa0]
	call DiscardCard
	ret

KadabraRecover_HealEffect:
	ld e, PLAY_AREA_ARENA
	call GetCardDamageAndMaxHP
	ld e, a ; all damage for recovery
	ld d, 0
	call ApplyAndAnimateHPRecovery
	ret

JynxDoubleslap_AIEffect:
	ld a, 20 / 2
	lb de, 0, 20
	call SetExpectedAIDamage
	ret

JynxDoubleslap_MultiplierEffect:
	ld hl, 10
	call LoadTxRam3
	ldtx de, DamageCheckXDamageTimesHeadsText
	ld a, 2
	call TossCoinATimes_Bank1a
	call ATimes10
	call SetDefiniteDamage
	ret

JynxMeditateEffect:
; add damage counters of Defending card to damage
	call SwapTurn
	ld e, PLAY_AREA_ARENA
	call GetCardDamageAndMaxHP
	call SwapTurn
	call AddToDamage
	ret

MysteryAttack_AIEffect:
	ld a, 10
	lb de, 0, 20
	call SetExpectedAIDamage
	ret

MysteryAttack_RandomEffect:
	ld a, 10
	call SetDefiniteDamage

; chooses a random effect from 8 possible options.
	call UpdateRNGSources
	and %111
	ldh [hTemp_ffa0], a
	ld hl, .random_effect
	jp JumpToFunctionInTable

.random_effect
	dw ParalysisEffect
	dw PoisonEffect
	dw SleepEffect
	dw ConfusionEffect
	dw .recover
	dw .no_effect
	dw .more_damage
	dw .no_damage

.more_damage
	ld a, 20
	call SetDefiniteDamage
	ret

.no_damage
	ld a, ATK_ANIM_GLOW_EFFECT
	ld [wLoadedAttackAnimation], a
	xor a
	call SetDefiniteDamage
	call SetNoEffectFromStatus
;	fallthrough

.recover
; this will actually activate recovery effect afterwards
; for this command do nothing

.no_effect
	ret

MysteryAttack_RecoverEffect:
; in case the 5th option was chosen for random effect,
; trigger recovery effect for 10 HP.
	ldh a, [hTemp_ffa0]
	cp 4
	ret nz
	ld de, 10
	call ApplyAndAnimateHPRecovery
	ret

GeodudeStoneBarrage_AIEffect:
	ld a, 10
	lb de, 0, 100
	call SetExpectedAIDamage
	ret

GeodudeStoneBarrage_MultiplierEffect:
	xor a
	ldh [hTemp_ffa0], a
.loop_coin_toss
	ldtx de, FlipUntilTails10DamageTimesHeadsText
	xor a
	call TossCoinATimes_Bank1a
	jr nc, .tails
	ld hl, hTemp_ffa0
	inc [hl] ; increase heads count
	jr .loop_coin_toss

.tails
; store resulting damage
	ldh a, [hTemp_ffa0]
	ld l, a
	ld h, 10
	call HtimesL
	ld de, wDamage
	ld a, l
	ld [de], a
	inc de
	ld a, h
	ld [de], a
	ret

OnixHardenEffect:
	ld a, SUBSTATUS1_PREVENT_LESS_THAN_40
	call ApplySubstatus1ToAttackingCard
	ret

PrimeapeFurySwipes_AIEffect:
	ld a, 60 / 2
	lb de, 0, 60
	call SetExpectedAIDamage
	ret

PrimeapeFurySwipes_MultiplierEffect:
	ld hl, 20
	call LoadTxRam3
	ldtx de, DamageCheckXDamageTimesHeadsText
	ld a, 3
	call TossCoinATimes_Bank1a
	add a
	call ATimes10
	call SetDefiniteDamage
	ret

TantrumEffect:
	ldtx de, IfTailsYourPokemonBecomesConfusedText
	call TossCoin_Bank1a
	ret c ; return if heads
; confuse Pokemon
	ld a, ATK_ANIM_MULTIPLE_SLASH
	ld [wLoadedAttackAnimation], a
	call SwapTurn
	call ConfusionEffect
	call SwapTurn
	ret

StrikesBackEffect:
	scf
	ret

KabutoArmorEffect:
	scf
	ret

AbsorbEffect:
	ld hl, wDealtDamage
	ld a, [hli]
	ld h, [hl]
	ld l, a
	srl h
	rr l
	bit 0, l
	jr z, .rounded
	; round up to nearest 10
	ld de, 5
	add hl, de
.rounded
	ld e, l
	ld d, h
	call ApplyAndAnimateHPRecovery
	ret

CuboneSnivelEffect:
	ld a, SUBSTATUS2_REDUCE_BY_20
	call ApplySubstatus2ToDefendingCard
	ret

CuboneRage_AIEffect:
	ldh a, [hTempPlayAreaLocation_ff9d]
	jr CalculateCuboneRageDamage
CuboneRage_DamageBoostEffect:
	xor a ; PLAY_AREA_ARENA
CalculateCuboneRageDamage:
	ld e, a
	call GetCardDamageAndMaxHP
	call AddToDamage
	ret

Bonemerang_AIEffect:
	ld a, 60 / 2
	lb de, 0, 60
	call SetExpectedAIDamage
	ret

Bonemerang_MultiplierEffect:
	ld hl, 30
	call LoadTxRam3
	ldtx de, DamageCheckXDamageTimesHeadsText
	ld a, 2
	call TossCoinATimes_Bank1a
	ld e, a
	add a ; a = 2 * heads
	add e ; a = 3 * heads
	call ATimes10
	call SetDefiniteDamage
	ret

; returns carry if can't add Pokemon from deck
MarowakCallForFamily_CheckDeckAndPlayArea:
	farcall CheckIfDeckIsEmpty
	ret c ; return if no cards in deck
	farcall CheckIfHasSpaceInBench
	ret

MarowakCallForFamily_PlayerSelectEffect:
	call CreateDeckCardList
	ldtx hl, ChooseBasicFightingPokemonFromDeckText
	ldtx bc, EffectTargetFightingPokemonText
	ld a, CARDSEARCH_BASIC_FIGHTING_POKEMON
	farcall LookForCardsInDeck
	jr c, .got_selection
	ldtx hl, ChooseBasicFightingPokemonText
	ldtx de, DuelistDeckText
	farcall SelectCardSearchTarget
.got_selection
	ldh [hTemp_ffa0], a
	ret

MarowakCallForFamily_AISelectEffect:
	ld a, CARDSEARCH_BASIC_FIGHTING_POKEMON
	farcall SetCardSearchFuncParams
	call CreateDeckCardList
	ld hl, wDuelTempList
.loop
	ld a, [hli]
	ldh [hTemp_ffa0], a
	cp $ff
	ret z
	farcall ExecuteCardSearchFunc
	jr nc, .loop
	ret

MarowakCallForFamily_PutInPlayAreaEffect:
	ldh a, [hTemp_ffa0]
	cp $ff
	jr z, .shuffle
	call SearchCardInDeckAndAddToHand
	call AddCardToHand
	call PutHandPokemonCardInPlayArea
	call IsPlayerTurn
	jr c, .shuffle
	ldh a, [hTemp_ffa0]
	ldtx hl, PlacedOnBenchText
	bank1call DisplayCardDetailScreen
.shuffle
	call ShuffleCardsInDeck
	ret

KarateChop_AIEffect:
	ldh a, [hTempPlayAreaLocation_ff9d]
	call CalculateKarateChopDamage
	jp SetDefiniteAIDamage
KarateChop_DamageSubtractionEffect:
	xor a ; PLAY_AREA_ARENA
CalculateKarateChopDamage:
	ld e, a
	call GetCardDamageAndMaxHP
	ld e, a
	ld hl, wDamage
	ld a, [hl]
	sub e
	ld [hli], a
	ld a, [hl]
	sbc 0
	ld [hl], a
	rla
	ret nc
; cap it to 0 damage
	xor a
	call SetDefiniteDamage
	ret

SubmissionEffect:
	ld a, 20
	call DealRecoilDamageToSelf
	ret

GolemSelfdestructEffect:
	ld a, 100
	call DealRecoilDamageToSelf
	call SetIsDamageToSelf
	ld a, 20
	call DealDamageToAllBenchedPokemon
	call SwapTurn
	call UnsetIsDamageToSelf
	ld a, 20
	call DealDamageToAllBenchedPokemon
	call SwapTurn
	ret

GravelerHardenEffect:
	ld a, SUBSTATUS1_PREVENT_LESS_THAN_40
	call ApplySubstatus1ToAttackingCard
	ret

Ram_SelectSwitchEffect:
	call HandleMandatorySwitchSelection
	ldh a, [hTempPlayAreaLocation_ff9d]
	ldh [hTemp_ffa0], a
	ret

Ram_RecoilSwitchEffect:
	ld a, 20
	call DealRecoilDamageToSelf
	call UnsetIsDamageToSelf
	ldh a, [hTemp_ffa0]
	call HandleSwitchDefendingPokemonEffect
	ret

LeerEffect:
	ldtx de, IfHeadsOpponentCannotAttackText
	call TossCoin_Bank1a
	jp nc, SetWasUnsuccessful
	ld a, ATK_ANIM_LEER
	ld [wLoadedAttackAnimation], a
	ld a, SUBSTATUS2_LEER
	call ApplySubstatus2ToDefendingCard
	ret

StretchKick_CheckBench:
	call CheckNonTurnDuelistHasBench
	ret

StretchKick_PlayerSelectEffect:
	call HandlePlayerSelectOppBenchPkmn
	ret

StretchKick_AISelectEffect:
	call AIFindTargetForBenchAttack
	ldh [hTemp_ffa0], a
	ret

StretchKick_BenchDamageEffect:
	call SwapTurn
	ldh a, [hTemp_ffa0]
	ld b, a
	ld de, 20
	call DealDamageToPlayAreaPokemon_RegularAnim
	call SwapTurn
	ret

SandshrewSandAttackEffect:
	ld a, SUBSTATUS2_SAND_ATTACK
	call ApplySubstatus2ToDefendingCard
	ret

SandslashFurySwipes_AIEffect:
	ld a, 60 / 2
	lb de, 0, 60
	call SetExpectedAIDamage
	ret

SandslashFurySwipes_MultiplierEffect:
	ld hl, 20
	call LoadTxRam3
	ldtx de, DamageCheckXDamageTimesHeadsText
	ld a, 3
	call TossCoinATimes_Bank1a
	add a
	call ATimes10
	call SetDefiniteDamage
	ret

DugtrioEarthquakeEffect:
	call SetIsDamageToSelf
	ld a, 10
	call DealDamageToAllBenchedPokemon
	ret

PrehistoricPowerEffect:
	scf
	ret

MankeyPeek_OncePerTurnCheck:
	jp CheckIfCanUsePkmnPowerThisTurn

MankeyPeek_SelectEffect:
; set Pkmn Power used flag
	call SetUsedPkmnPowerThisTurnFlag

	ld a, DUELVARS_DUELIST_TYPE
	get_turn_duelist_var
	cp DUELIST_TYPE_LINK_OPP
	jr z, .link_opp
	and DUELIST_TYPE_AI_OPP
	jr nz, .ai_opp

; player
	call FinishQueuedAnimations
	call HandlePeekSelection
	ldh [hAIPkmnPowerEffectParam], a
	call SerialSend8Bytes
	ret

.link_opp
	call SerialRecv8Bytes
	ldh [hAIPkmnPowerEffectParam], a

.ai_opp
	ldh a, [hAIPkmnPowerEffectParam]
	bit AI_PEEK_TARGET_HAND_F, a
	jr z, .prize_or_deck
	and (~AI_PEEK_TARGET_HAND & $ff) ; unset bit to get deck index
; if masked value is higher than $40, then it means
; that AI chose to look at Player's deck.
; all deck indices will be smaller than $40.
	cp $40
	jr c, .hand
	ldh a, [hAIPkmnPowerEffectParam]
	jr .prize_or_deck

.hand
; AI chose to look at random card in hand,
; so display it to the Player on screen.
	call SwapTurn
	ldtx hl, PeekWasUsedToLookInYourHandText
	bank1call DisplayCardDetailScreen
	call SwapTurn
	ret

.prize_or_deck
; AI chose either a prize card or Player's top deck card,
; so show Play Area and draw cursor appropriately.
	call FinishQueuedAnimations
	call SwapTurn
	ldh a, [hAIPkmnPowerEffectParam]
	xor $80
	call DrawAIPeekScreen
	call SwapTurn
	ldtx hl, CardPeekWasUsedOnText
	call DrawWideTextBox_WaitForInput
	ret

BoneAttackEffect:
	ldtx de, IfHeadsOpponentCannotAttackText
	call TossCoin_Bank1a
	ret nc ; tails
	ld a, ATK_ANIM_BONE_ATTACK
	ld [wLoadedAttackAnimation], a
	ld a, SUBSTATUS2_BONE_ATTACK
	call ApplySubstatus2ToDefendingCard
	ret

; return carry if neither Play Area
; has room for more Bench Pokemon
; or if both decks are empty
Wail_BenchAndDeckCheck:
	farcall CheckIfDeckIsEmpty
	jr nc, .has_deck_cards
	call SwapTurn
	farcall CheckIfDeckIsEmpty
	call SwapTurn
	ret c
.has_deck_cards
	farcall CheckIfHasSpaceInBench
	ret nc
	call SwapTurn
	farcall CheckIfHasSpaceInBench
	call SwapTurn
	ret

Wail_FillBenchEffect:
	call SwapTurn
	call .FillBench
	call SwapTurn
	call .FillBench

; display both Play Areas
	ldtx hl, BasicPokemonWasPlacedOnEachBenchText
	call DrawWideTextBox_WaitForInput
	bank1call HasAlivePokemonInPlayArea
	bank1call OpenPlayAreaScreenForSelection
	call SwapTurn
	bank1call HasAlivePokemonInPlayArea
	bank1call OpenPlayAreaScreenForSelection
	call SwapTurn
	ret

.FillBench:
	call CreateDeckCardList
	ret c
	ld hl, wDuelTempList
	call ShuffleCards

; if no more space in the Bench, then return.
.check_bench
	push hl
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	ld hl, wMaxNumPlayAreaPokemon
	cp [hl]
	pop hl
	jr nc, .done

; there's still space, so look for the next
; Basic Pokemon card to put in the Bench.
.loop
	ld a, [hli]
	ldh [hTempCardIndex_ff98], a
	cp $ff
	jr z, .done
	call LoadCardDataToBuffer2_FromDeckIndex
	ld a, [wLoadedCard2Type]
	cp TYPE_ENERGY
	jr nc, .loop ; is Pokemon card?
	ld a, [wLoadedCard2Stage]
	or a
	jr nz, .loop ; is Basic?
; place card in Bench
	push hl
	ldh a, [hTempCardIndex_ff98]
	call SearchCardInDeckAndAddToHand
	call AddCardToHand
	call PutHandPokemonCardInPlayArea
	pop hl
	jr .check_bench

.done
	call ShuffleCardsInDeck
	ret

ElectabuzzThundershockEffect:
	call Paralysis50PercentEffect
	ret

Thunderpunch_AIEffect:
	ld a, (30 + 40) / 2
	lb de, 30, 40
	call SetExpectedAIDamage
	ret

Thunderpunch_ModifierEffect:
	ldtx de, IfHeadPlus10IfTails10ToYourselfText
	call TossCoin_Bank1a
	ldh [hTemp_ffa0], a
	ret nc ; return if got tails
	ld a, 10
	call AddToDamage
	ret

Thunderpunch_RecoilEffect:
	ldh a, [hTemp_ffa0]
	or a
	ret nz ; return if got heads
	ld a, 10
	call DealRecoilDamageToSelf
	ret

LightScreenEffect:
	ld a, SUBSTATUS1_HALVE_DAMAGE
	call ApplySubstatus1ToAttackingCard
	ret

ElectabuzzQuickAttack_AIEffect:
	ld a, (10 + 30) / 2
	lb de, 10, 30
	call SetExpectedAIDamage
	ret

ElectabuzzQuickAttack_DamageBoostEffect:
	ld hl, 20
	call LoadTxRam3
	ldtx de, DamageCheckIfHeadsPlusDamageText
	call TossCoin_Bank1a
	ret nc
	ld a, 20
	call AddToDamage
	ret

MagnemiteThunderWaveEffect:
	call Paralysis50PercentEffect
	ret

MagnemiteSelfdestructEffect:
	ld a, 40
	call DealRecoilDamageToSelf

	call SetIsDamageToSelf
	ld a, 10
	call DealDamageToAllBenchedPokemon
	call SwapTurn
	call UnsetIsDamageToSelf
	ld a, 10
	call DealDamageToAllBenchedPokemon
	call SwapTurn
	ret

ZapdosThunder_Recoil50PercentEffect:
	ld hl, 30
	call LoadTxRam3
	ldtx de, IfTailsDamageToYourselfTooText
	call TossCoin_Bank1a
	ldh [hTemp_ffa0], a
	ret

ZapdosThunder_RecoilEffect:
	ld hl, 30
	call LoadTxRam3
	ldh a, [hTemp_ffa0]
	or a
	ret nz ; return if got heads
	ld a, 30
	call DealRecoilDamageToSelf
	ret

ZapdosThunderboltEffect:
	xor a ; PLAY_AREA_ARENA
	call CreateArenaOrBenchEnergyCardList
	ld hl, wDuelTempList
; put all energy cards in Discard Pile
.loop
	ld a, [hli]
	cp $ff
	ret z
	call DiscardCard
	jr .loop

ThunderstormEffect:
	ld a, 1
	ldh [hCurSelectionItem], a

	call SwapTurn
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	ld c, a
	ld b, 0
	ld e, b
	jr .next_pkmn

.check_damage
	push de
	push bc
	call .DisplayText
	ld de, NULL
	call SwapTurn
	call TossCoin_Bank1a
	call SwapTurn
	push af
	farcall GetNextPositionInTempList
	pop af
	ld [hl], a ; store result in list
	pop bc
	pop de
	jr c, .next_pkmn
	inc b ; increase number of tails

.next_pkmn
	inc e
	dec c
	jr nz, .check_damage

; all coins were tossed for each Benched Pokemon
	farcall GetNextPositionInTempList
	ld [hl], $ff
	ld a, b
	ldh [hTemp_ffa0], a
	call ResetAnimationQueue
	call SwapTurn

; tally recoil damage
	ldh a, [hTemp_ffa0]
	or a
	jr z, .skip_recoil
	; deal number of tails times 10 to self
	call ATimes10
	call DealRecoilDamageToSelf
.skip_recoil

; deal damage for Bench Pokemon that got heads
	call SwapTurn
	ld hl, hTempPlayAreaLocation_ffa1
	ld b, PLAY_AREA_BENCH_1
.loop_bench
	ld a, [hli]
	cp $ff
	jr z, .done
	or a
	jr z, .skip_damage ; skip if tails
	ld de, 20
	call DealDamageToPlayAreaPokemon_RegularAnim
.skip_damage
	inc b
	jr .loop_bench

.done
	call SwapTurn
	ret

; displays text for current Bench Pokemon,
; printing its Bench number and name.
.DisplayText:
	ld b, e
	ldtx hl, BenchText
	ld de, wDefaultText
	call CopyText
	ld a, TX_SYMBOL
	ld [de], a
	inc de
	ld a, SYM_0
	add b
	ld [de], a
	inc de
	ldfw a, " "
	ld [de], a
	inc de

	ld a, DUELVARS_ARENA_CARD
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

JolteonQuickAttack_AIEffect:
	ld a, (10 + 30) / 2
	lb de, 10, 30
	call SetExpectedAIDamage
	ret

JolteonQuickAttack_DamageBoostEffect:
	ld a, 20
	call AddDamageIfHeads
	ret

PinMissile_AIEffect:
	ld a, (20 * 4) / 2
	lb de, 0, 80
	call SetExpectedAIDamage
	ret

PinMissile_MultiplierEffect:
	ld hl, 20
	call LoadTxRam3
	ldtx de, DamageCheckXDamageTimesHeadsText
	ld a, 4
	call TossCoinATimes_Bank1a
	add a
	call ATimes10
	call SetDefiniteDamage
	ret

FlyingPikachuThundershockEffect:
	call Paralysis50PercentEffect
	ret

FlyingPikachuFly_AIEffect:
	jr FlyingPikachuFlyAIEffect

FlyingPikachuFly_Success50PercentEffect:
	jr FlyingPikachuFlySuccess50PercentEffect

FlyingPikachuFlyAIEffect:
	ld a, 30
	lb de, 0, 30
	call SetExpectedAIDamage
	ret

FlyingPikachuFlySuccess50PercentEffect:
	ldtx de, AttackSuccessCheckText
	call TossCoin_Bank1a
	jr c, .heads
; tails
	xor a
	ld [wLoadedAttackAnimation], a
	call SetDefiniteDamage
	call SetWasUnsuccessful
	ret
.heads
	ld a, ATK_ANIM_AGILITY_PROTECT
	ld [wLoadedAttackAnimation], a
	ld a, SUBSTATUS1_FLY
	call ApplySubstatus1ToAttackingCard
	ret

FlyingPikachuAltThundershockEffect:
	call Paralysis50PercentEffect
	ret

FlyingPikachuAltFly_AIEffect:
	jr FlyingPikachuFlyAIEffect

FlyingPikachuAltFly_Success50PercentEffect:
	jr FlyingPikachuFlySuccess50PercentEffect

ThunderJolt_Recoil50PercentEffect:
	ld hl, 10
	call LoadTxRam3
	ldtx de, IfTailsDamageToYourselfTooText
	call TossCoin_Bank1a
	ldh [hTemp_ffa0], a
	ret

ThunderJolt_RecoilEffect:
	ld hl, 10
	call LoadTxRam3
	ldh a, [hTemp_ffa0]
	or a
	ret nz
	ld a, 10
	call DealRecoilDamageToSelf
	ret

Spark_PlayerSelectEffect:
	call HandlePlayerSelectOppBenchPkmn
	ret

Spark_AISelectEffect:
	ld a, $ff
	ldh [hTemp_ffa0], a
	call CheckNonTurnDuelistHasBench
	ret c ; no bench
; AI always picks Pokemon with lowest HP remaining
	call AIFindTargetForBenchAttack
	ldh [hTemp_ffa0], a
	ret

Spark_BenchDamageEffect:
	ldh a, [hTemp_ffa0]
	cp $ff
	ret z
	call SwapTurn
	ldh a, [hTemp_ffa0]
	ld b, a
	ld de, 10
	call DealDamageToPlayAreaPokemon_RegularAnim
	call SwapTurn
	ret

PikachuLv16GrowlEffect:
	ld a, SUBSTATUS2_GROWL
	call ApplySubstatus2ToDefendingCard
	ret

PikachuLv16ThundershockEffect:
	call Paralysis50PercentEffect
	ret

PikachuAltLv16GrowlEffect:
	ld a, SUBSTATUS2_GROWL
	call ApplySubstatus2ToDefendingCard
	ret

PikachuAltLv16ThundershockEffect:
	call Paralysis50PercentEffect
	ret

ChainLightningEffect:
	ld a, 10
	call SetDefiniteDamage
	call SwapTurn
	bank1call GetArenaCardColor
	call SwapTurn
	ldh [hCurSelectionItem], a
	cp COLORLESS
	ret z ; don't damage if colorless

; opponent's Bench
	call SwapTurn
	call .DamageSameColorBench
	call SwapTurn

; own Bench
	call SetIsDamageToSelf
	call .DamageSameColorBench
	call UnsetIsDamageToSelf
	ret

.DamageSameColorBench:
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	ld e, a
	ld d, PLAY_AREA_ARENA
	jr .next_bench

.check_damage
	ld a, d
	bank1call GetPlayAreaCardColor
	ld c, a
	ldh a, [hCurSelectionItem]
	cp c
	jr nz, .next_bench ; skip if not same color
; apply damage to this Bench card
	push de
	ld b, d
	ld de, 10
	call DealDamageToPlayAreaPokemon_RegularAnim
	pop de

.next_bench
	inc d
	dec e
	jr nz, .check_damage
	ret

RaichuAgilityEffect:
	ldtx de, IfHeadsDoNotReceiveDamageOrEffectText
	call TossCoin_Bank1a
	ret nc ; skip if got tails
	ld a, ATK_ANIM_AGILITY_PROTECT
	ld [wLoadedAttackAnimation], a
	ld a, SUBSTATUS1_AGILITY
	call ApplySubstatus1ToAttackingCard
	ret

RaichuThunder_Recoil50PercentEffect:
	ld hl, 30
	call LoadTxRam3
	ldtx de, IfTailsDamageToYourselfTooText
	call TossCoin_Bank1a
	ldh [hTemp_ffa0], a
	ret

RaichuThunder_RecoilEffect:
	ld hl, 30
	call LoadTxRam3
	ldh a, [hTemp_ffa0]
	or a
	ret nz
	ld a, 30
	call DealRecoilDamageToSelf
	ret

Gigashock_PlayerSelectEffect:
	ld a, $ff
	ldh [hTempList], a
	call CheckNonTurnDuelistHasBench
	ret c ; no bench

	call SwapTurn
	ldtx hl, ChooseUpTo3BenchedPokemonToGiveDamageText
	call DrawWideTextBox_WaitForInput

; init number of items in list and cursor position
	xor a
	ldh [hCurSelectionItem], a
	ld [wCurGigashockItem], a
	bank1call SetupPlayAreaScreen
.start
	bank1call PrintPlayAreaCardList_EnableLCD
	push af
	ld a, [wCurGigashockItem]
	ld hl, BenchSelectionMenuParameters
	call InitializeMenuParameters
	pop af

; exclude Arena Pokemon from number of items
	dec a
	ld [wNumScrollMenuItems], a

.loop_input
	call DoFrame
	call HandleMenuInput
	jr nc, .loop_input
	cp -1
	jr z, .try_cancel

	ld [wCurGigashockItem], a
	call .CheckIfChosenAlready
	jr nc, .not_chosen
	; play SFX
	call PlaySFX_InvalidChoice
	jr .loop_input

.not_chosen
; mark this Play Area location
	ldh a, [hCurScrollMenuItem]
	inc a
	ld b, SYM_LIGHTNING
	call DrawSymbolOnPlayAreaCursor
; store it in the list of chosen Bench Pokemon
	farcall GetNextPositionInTempList
	ldh a, [hCurScrollMenuItem]
	inc a
	ld [hl], a

; check if 3 were chosen already
	ldh a, [hCurSelectionItem]
	ld c, a
	cp 3
	jr nc, .chosen ; check if already chose 3

	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	dec a
	cp c
	jr nz, .start ; if still more options available, loop back
	; fallthrough if no other options available to choose

.chosen
	ldh a, [hCurScrollMenuItem]
	inc a
	call DrawPlayAreaScreenToShowChanges
	ldh a, [hKeysPressed]
	and PAD_B
	jr nz, .try_cancel
	call SwapTurn
	farcall GetNextPositionInTempList
	ld [hl], $ff ; terminating byte
	ret

.try_cancel
	ldh a, [hCurSelectionItem]
	or a
	jr z, .start ; none selected, can safely loop back to start

; undo last selection made
	dec a
	ldh [hCurSelectionItem], a
	ld e, a
	ld d, $00
	ld hl, hTempList
	add hl, de
	ld a, [hl]

	push af
	ld b, SYM_SPACE
	call DrawSymbolOnPlayAreaCursor
	call EraseCursor
	pop af

	dec a
	ld [wCurGigashockItem], a
	jp .start

; returns carry if Bench Pokemon
; in register a was already chosen.
.CheckIfChosenAlready:
	inc a
	ld c, a
	ldh a, [hCurSelectionItem]
	ld b, a
	ld hl, hTempList
	inc b
	jr .next_check
.check_chosen
	ld a, [hli]
	cp c
	scf
	ret z ; return if chosen already
.next_check
	dec b
	jr nz, .check_chosen
	or a
	ret

Gigashock_AISelectEffect:
; if Bench has 3 Pokemon or less, no need for selection,
; since AI will choose them all.
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	call GetNonTurnDuelistVariable
	cp 1 + 4
	jr nc, .start_selection

; select them all
	ld hl, hTempList
	ld b, PLAY_AREA_ARENA
	jr .next_bench
.select_bench
	ld [hl], b
	inc hl
.next_bench
	inc b
	dec a
	jr nz, .select_bench
	ld [hl], $ff ; terminating byte
	ret

.start_selection
; has more than 3 Bench cards, proceed to sort them
; by lowest remaining HP to highest, and pick first 3.
	call SwapTurn
	dec a
	ld c, a
	ld b, PLAY_AREA_BENCH_1

; first select all of the Bench Pokemon and write to list
	ld hl, hTempList
.loop_all
	ld [hl], b
	inc hl
	inc b
	dec c
	jr nz, .loop_all
	ld [hl], $00 ; end list with $00

; then check each of the Bench Pokemon HP
; sort them from lowest remaining HP to highest.
	ld de, hTempList
.loop_outer
	ld a, [de]
	add DUELVARS_ARENA_CARD_HP
	get_turn_duelist_var
	ld c, a
	ld l, e
	ld h, d
	inc hl

.loop_inner
	ld a, [hli]
	or a
	jr z, .next ; reaching $00 means it's end of list

	push hl
	add DUELVARS_ARENA_CARD_HP
	get_turn_duelist_var
	pop hl
	cp c
	jr c, .loop_inner
	; a Bench Pokemon was found with less HP
	ld c, a ; store its HP

; switch the two
	dec hl
	ld b, [hl]
	ld a, [de]
	ld [hli], a
	ld a, b
	ld [de], a
	jr .loop_inner

.next
	inc de
	ld a, [de]
	or a
	jr nz, .loop_outer

; done
	ld a, $ff ; terminating byte
	ldh [hTempList + 3], a
	call SwapTurn
	ret

Gigashock_BenchDamageEffect:
	call SwapTurn
	ld hl, hTempList
.loop_selection
	ld a, [hli]
	cp $ff
	jr z, .done
	push hl
	ld b, a
	ld de, 10
	call DealDamageToPlayAreaPokemon_RegularAnim
	pop hl
	jr .loop_selection
.done
	call SwapTurn
	ret

MagnetonThunderWaveEffect:
	call Paralysis50PercentEffect
	ret

MagnetonLv28SelfdestructEffect:
	ld a, 80
	call DealRecoilDamageToSelf

; own bench
	call SetIsDamageToSelf
	ld a, 20
	call DealDamageToAllBenchedPokemon

; opponent's bench
	call SwapTurn
	call UnsetIsDamageToSelf
	ld a, 20
	call DealDamageToAllBenchedPokemon
	call SwapTurn
	ret

MagnetonSonicboom_UnaffectedByColorEffect:
	ld hl, wDamage + 1
	set UNAFFECTED_BY_WEAKNESS_RESISTANCE_F, [hl]
	ret

MagnetonLv35SelfdestructEffect:
	ld a, 100
	call DealRecoilDamageToSelf

; own bench
	call SetIsDamageToSelf
	ld a, 20
	call DealDamageToAllBenchedPokemon

; opponent's bench
	call SwapTurn
	call UnsetIsDamageToSelf
	ld a, 20
	call DealDamageToAllBenchedPokemon
	call SwapTurn
	ret

PealOfThunder_InitialEffect:
	scf
	ret

PealOfThunder_RandomlyDamageEffect:
	call ExchangeRNG
	ld de, 30 ; damage to inflict
	call RandomlyDamagePlayAreaPokemon
	bank1call HandleDestinyBondAndBetweenTurnKnockOuts
	ret

; randomly damages a Pokemon in play, except
; card that is in [hTempPlayAreaLocation_ff9d].
; plays thunder animation when Play Area is shown.
; input:
;	de = amount of damage to deal
RandomlyDamagePlayAreaPokemon:
.sample
	call UpdateRNGSources
	and 1
	jr nz, .opp_play_area

; own Play Area
	call SetIsDamageToSelf
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	call Random
	ld b, a
	; can't select Zapdos
	ldh a, [hTempPlayAreaLocation_ff9d]
	cp b
	jr z, .sample ; re-roll Pokemon to attack

.DoDamage:
	ld hl, wLoadedAttackCategory
	res RESIDUAL_F, [hl]
	ld a, ATK_ANIM_THUNDER_PLAY_AREA
	ld [wLoadedAttackAnimation], a
	call DealDamageToPlayAreaPokemon
	ret

.opp_play_area
	call UnsetIsDamageToSelf
	call SwapTurn
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	call Random
	ld b, a
	call .DoDamage
	call SwapTurn
	ret

BigThunderEffect:
	call ExchangeRNG
	ld de, 70 ; damage to inflict
	call RandomlyDamagePlayAreaPokemon
	ret

MagneticStormEffect:
	ld a, DUELVARS_CARD_LOCATIONS
	get_turn_duelist_var

; writes in wDuelTempList all deck indices
; of Energy cards attached to Pokemon
; in the Turn Duelist's Play Area.
	ld de, wDuelTempList
	ld c, 0
.loop_card_locations
	ld a, [hl]
	and CARD_LOCATION_PLAY_AREA
	jr z, .next_card_location

; is a card that is in the Play Area
	push hl
	push de
	push bc
	ld a, l
	call GetCardIDFromDeckIndex
	call GetCardType
	pop bc
	pop de
	pop hl
	and TYPE_ENERGY
	jr z, .next_card_location
; is an Energy card attached to Pokemon in Play Area
	ld a, l
	ld [de], a
	inc de
	inc c
.next_card_location
	inc l
	ld a, l
	cp DECK_SIZE
	jr c, .loop_card_locations
	ld a, $ff ; terminating byte
	ld [de], a

; divide number of energy cards
; by number of Pokemon in Play Area
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	ld b, a
	ld a, c
	ld c, -1
.loop_division
	inc c
	sub b
	jr nc, .loop_division
	; c = floor(a / b)

; evenly divides the Energy cards randomly
; to every Pokemon in the Play Area.
	push bc
	ld hl, wDuelTempList
	call CountCardsInDuelTempList
	call ShuffleCards
	ld d, c
	ld e, PLAY_AREA_ARENA
.start_attach
	ld c, d
	inc c
	jr .check_done
.attach_energy
	ld a, [hli]
	push hl
	push de
	push bc
	call AddCardToHand
	call PutHandCardInPlayArea
	pop bc
	pop de
	pop hl
.check_done
	dec c
	jr nz, .attach_energy
; go to next Pokemon in Play Area
	inc e ; next in Play Area
	dec b
	jr nz, .start_attach
	pop bc

	push hl
	ld hl, hTempList

; fill hTempList with PLAY_AREA_* locations
; that have Pokemon in them.
	push hl
	xor a
.loop_init
	ld [hli], a
	inc a
	cp b
	jr nz, .loop_init
	pop hl

; shuffle them and distribute
; the remaining cards in random order.
	ld a, b
	call ShuffleCards
	pop hl
	ld de, hTempList
.next_random_pokemon
	ld a, [hl]
	cp $ff
	jr z, .done
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
	jr .next_random_pokemon

.done
	bank1call DrawDuelMainScene
	bank1call DrawDuelHUDs
	ldtx hl, TheEnergyCardFromPlayAreaWasMovedText
	call DrawWideTextBox_WaitForInput
	xor a
	call DrawPlayAreaScreenToShowChanges
	ret

ElectrodeSonicboom_UnaffectedByColorEffect:
	ld hl, wDamage + 1
	set UNAFFECTED_BY_WEAKNESS_RESISTANCE_F, [hl]
	ret

EnergySpike_DeckCheck:
	farcall CheckIfDeckIsEmpty
	ret

EnergySpike_PlayerSelectEffect:
	call CreateDeckCardList
	ldtx hl, Choose1BasicEnergyCardFromDeckText
	ldtx bc, EffectTargetBasicEnergyText
	ld a, CARDSEARCH_BASIC_ENERGY
	farcall LookForCardsInDeck
	jr c, .got_selection
	ldtx hl, ChooseBasicEnergyCardText
	ldtx de, DuelistDeckText
	farcall SelectCardSearchTarget
.got_selection
	ldh [hTemp_ffa0], a
	cp $ff
	ret z ; no selection done

; a valid energy card was chosen, now
; select a Play Area Pokémon to receive it
	call EmptyScreen
	ldtx hl, ChoosePokemonToAttachEnergyCardText
	call DrawWideTextBox_WaitForInput
	bank1call HasAlivePokemonInPlayArea
.loop
	bank1call OpenPlayAreaScreenForSelection
	jr c, .loop
	ldh a, [hTempPlayAreaLocation_ff9d]
	ldh [hTempPlayAreaLocation_ffa1], a
	ret

EnergySpike_AISelectEffect:
; AI doesn't choose card here,
; instead this is handled in AISelectSpecialAttackParameters
	ld a, $ff
	ldh [hTemp_ffa0], a
	ret

EnergySpike_AttachEnergyEffect:
	ldh a, [hTemp_ffa0]
	cp $ff
	jr z, .done

; add card to hand and attach it to the selected Pokemon
	call SearchCardInDeckAndAddToHand
	call AddCardToHand
	ldh a, [hTempPlayAreaLocation_ffa1]
	ld e, a
	ldh a, [hTemp_ffa0]
	call PutHandCardInPlayArea
	call IsPlayerTurn
	jr c, .done

; not Player, so show detail screen
; and which Pokemon was chosen to attach Energy.
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
	ldtx hl, AttachedEnergyToPokemonText
	bank1call DisplayCardDetailScreen

.done
	call ShuffleCardsInDeck
	ret

JolteonDoubleKick_AIEffect:
	ld a, 40 / 2
	lb de, 0, 40
	call SetExpectedAIDamage
	ret

JolteonDoubleKick_MultiplierEffect:
	ld hl, 20
	call LoadTxRam3
	ldtx de, DamageCheckXDamageTimesHeadsText
	ld a, 2
	call TossCoinATimes_Bank1a
	add a
	call ATimes10
	call SetDefiniteDamage
	ret

StunNeedleEffect:
	call Paralysis50PercentEffect
	ret

TailWagEffect:
	ldtx de, IfHeadsOpponentCannotAttackText
	call TossCoin_Bank1a
	jp nc, SetWasUnsuccessful
	ld a, ATK_ANIM_TAIL_WHIP
	ld [wLoadedAttackAnimation], a
	ld a, SUBSTATUS2_TAIL_WAG
	call ApplySubstatus2ToDefendingCard
	ret

EeveeQuickAttack_AIEffect:
	ld a, (10 + 30) / 2
	lb de, 10, 30
	call SetExpectedAIDamage
	ret

EeveeQuickAttack_DamageBoostEffect:
	ld a, 20
	call AddDamageIfHeads
	ret

SpearowMirrorMove_AIEffect:
	jp MirrorMove_AIEffect

SpearowMirrorMove_InitialEffect1:
	jp MirrorMove_InitialEffect1

SpearowMirrorMove_InitialEffect2:
	jp MirrorMove_InitialEffect2

SpearowMirrorMove_PlayerSelection:
	jp MirrorMove_PlayerSelection

SpearowMirrorMove_AISelection:
	jp MirrorMove_AISelection

SpearowMirrorMove_SwitchDefendingPkmn:
	jp MirrorMove_SwitchDefendingPkmn

SpearowMirrorMove_BeforeDamage:
	jp MirrorMove_BeforeDamage

SpearowMirrorMove_AfterDamage:
	jp MirrorMove_AfterDamage

FearowAgilityEffect:
	ldtx de, IfHeadsDoNotReceiveDamageOrEffectText
	call TossCoin_Bank1a
	ret nc
	ld a, ATK_ANIM_AGILITY_PROTECT
	ld [wLoadedAttackAnimation], a
	ld a, SUBSTATUS1_AGILITY
	call ApplySubstatus1ToAttackingCard
	ret

; return carry if cannot use Step In
StepIn_BenchCheck:
	call CheckIfCanUsePkmnPowerThisTurn
	ret c
	ldh a, [hTempPlayAreaLocation_ff9d]
	ldh [hTemp_ffa0], a
	or a
	ret nz ; is Arena card already
	ldtx hl, CanOnlyBeUsedOnTheBenchText
	scf
	ret

StepIn_SwitchEffect:
	call SetUsedPkmnPowerThisTurnFlag
	ldh a, [hTemp_ffa0]
	ld e, a
	call SwapArenaWithBenchPokemon
	ret

DragoniteLv45Slam_AIEffect:
	ld a, (40 * 2) / 2
	lb de, 0, 80
	call SetExpectedAIDamage
	ret

DragoniteLv45Slam_MultiplierEffect:
	ld hl, 40
	call LoadTxRam3
	ldtx de, DamageCheckXDamageTimesHeadsText
	ld a, 2
	call TossCoinATimes_Bank1a
	add a
	add a
	call ATimes10
	call SetDefiniteDamage
	ret

ThickSkinnedEffect:
	scf
	ret

SnorlaxBodySlamEffect:
	call Paralysis50PercentEffect
	ret

FarfetchdLeekSlap_AIEffect:
	ld a, 30
	lb de, 0, 30
	call SetExpectedAIDamage
	ret

; return carry if already used attack in this duel
FarfetchdLeekSlap_OncePerDuelCheck:
; can only use attack if it was never used before this duel
	ld a, DUELVARS_ARENA_CARD_FLAGS
	get_turn_duelist_var
	and USED_LEEK_SLAP_THIS_DUEL
	ret z
	ldtx hl, CannotBeUsedTwiceText
	scf
	ret

FarfetchdLeekSlap_SetUsedThisDuelFlag:
	ld a, DUELVARS_ARENA_CARD_FLAGS
	get_turn_duelist_var
	set USED_LEEK_SLAP_THIS_DUEL_F, [hl]
	ret

FarfetchdLeekSlap_NoDamage50PercentEffect:
	ldtx de, DamageCheckIfTailsNoDamageText
	call TossCoin_Bank1a
	ret c
	xor a ; 0 damage
	call SetDefiniteDamage
	ret

Fetch_CheckDeck:
	farcall CheckIfDeckIsEmpty
	ret

Fetch_DrawCardEffect:
	ldtx hl, Draw1CardFromTheDeckText
	call DrawWideTextBox_WaitForInput
	farcall DisplayDrawOneCardScreen
	call DrawCardFromDeck
	ret c ; return if deck is empty
	call AddCardToHand
	call LoadCardDataToBuffer1_FromDeckIndex
	ld a, [wDuelistType]
	cp DUELIST_TYPE_PLAYER
	ret nz
	; show card on screen if it was Player
	bank1call OpenCardPage_FromHand
	ret

CometPunch_AIEffect:
	ld a, (20 * 4) / 2
	lb de, 0, 80
	call SetExpectedAIDamage
	ret

CometPunch_MultiplierEffect:
	ld hl, 20
	call LoadTxRam3
	ldtx de, DamageCheckXDamageTimesHeadsText
	ld a, 4
	call TossCoinATimes_Bank1a
	add a
	call ATimes10
	call SetDefiniteDamage
	ret

TaurosStomp_AIEffect:
	ld a, (20 + 30) / 2
	lb de, 20, 30
	call SetExpectedAIDamage
	ret

TaurosStomp_DamageBoostEffect:
	ld a, 10
	call AddDamageIfHeads
	ret

Rampage_AIEffect:
	ldh a, [hTempPlayAreaLocation_ff9d]
CalculateRampageDamage:
	ld e, a
	call GetCardDamageAndMaxHP
	call AddToDamage
	ret
Rampage_Confusion50PercentEffect:
	xor a
	call CalculateRampageDamage
	ldtx de, IfTailsYourPokemonBecomesConfusedText
	call TossCoin_Bank1a
	ret c ; heads
	call SwapTurn
	call ConfusionEffect
	call SwapTurn
	ret

DoduoFuryAttack_AIEffect:
	ld a, (10 * 2) / 2
	lb de, 0, 20
	call SetExpectedAIDamage
	ret

DoduoFuryAttack_MultiplierEffect:
	ld hl, 10
	call LoadTxRam3
	ld a, 2
	ldtx de, DamageCheckXDamageTimesHeadsText
	call TossCoinATimes_Bank1a
	call ATimes10
	call SetDefiniteDamage
	ret

RetreatAidEffect:
	scf
	ret

DodrioRage_AIEffect:
	ldh a, [hTempPlayAreaLocation_ff9d]
	jr CalculateDodrioRageDamage
DodrioRage_DamageBoostEffect:
	xor a
CalculateDodrioRageDamage:
	ld e, a
	call GetCardDamageAndMaxHP
	call AddToDamage
	ret

PayDayEffect:
	ldtx de, IfHeadsDraw1CardFromDeckText
	call TossCoin_Bank1a
	ret nc ; tails
	ldtx hl, Draw1CardFromTheDeckText
	call DrawWideTextBox_WaitForInput
	farcall DisplayDrawOneCardScreen
	call DrawCardFromDeck
	ret c ; empty deck
	call AddCardToHand
	call LoadCardDataToBuffer1_FromDeckIndex
	ld a, [wDuelistType]
	cp DUELIST_TYPE_PLAYER
	ret nz
	; show card on screen if it was Player
	bank1call OpenCardPage_FromHand
	ret

DragonairSlam_AIEffect:
	ld a, (30 * 2) / 2
	lb de, 0, 60
	call SetExpectedAIDamage
	ret

DragonairSlam_MultiplierEffect:
	ld hl, 30
	call LoadTxRam3
	ld a, 2
	ldtx de, DamageCheckXDamageTimesHeadsText
	call TossCoinATimes_Bank1a
	ld e, a
	add a
	add e
	call ATimes10
	call SetDefiniteDamage
	ret

DragonairHyperBeam_PlayerSelectEffect:
	jr HandleDiscardEnergyFromDefendingCardPlayerSelection

DragonairHyperBeam_AISelectEffect:
	jr AIPickEnergyCardToDiscardFromDefendingPokemon

DragonairHyperBeam_DiscardEffect:
	jr DiscardEnergyEffect

AIPickEnergyCardToDiscardFromDefendingPokemon:
	call _AIPickEnergyCardToDiscardFromDefendingPokemon
	ldh [hTemp_ffa0], a
	ret

; handles player selection for attacks that discard
; an energy card attached to the defending card
; outputs selection in [hTemp_ffa0]
; if defending Pokémon has no energy, then output -1 instead
HandleDiscardEnergyFromDefendingCardPlayerSelection:
	call SwapTurn
	; nothing to select if Arena card has no energy
	xor a ; PLAY_AREA_ARENA
	call CreateArenaOrBenchEnergyCardList
	jr c, .no_energies

	; prompt player to select energy
	ldtx hl, ChooseEnergyCardFromOppActiveToDiscardText
	call DrawWideTextBox_WaitForInput

	; handle selection
	xor a ; PLAY_AREA_ARENA
	bank1call DisplayEnergyDiscardMenu
.loop
	bank1call HandleAttachedEnergyMenuInput
	jr c, .loop
	call SwapTurn
	ldh a, [hTempCardIndex_ff98]
	ldh [hTemp_ffa0], a
	ret

.no_energies
	call SwapTurn
	ld a, -1
	ldh [hTemp_ffa0], a
	ret

; discards an energy due to an attack's effect
; selection is expected to be in [hTemp_ffa0]
DiscardEnergyEffect:
	; check if energy card was chosen to discard
	ldh a, [hTemp_ffa0]
	cp -1
	ret z ; return if none selected

	call HandleNoDamageOrEffect
	ret c ; return if attack had no effect

	; discard Defending card's energy
	call SwapTurn
	ldh a, [hTemp_ffa0]
	call DiscardCard
	ld a, DUELVARS_ARENA_CARD_LAST_TURN_EFFECT
	get_turn_duelist_var
	ld [hl], LAST_TURN_EFFECT_DISCARD_ENERGY
	call SwapTurn
	ret

; return carry if Defending Pokemon has no attacks
ClefableMetronome_CheckAttacks:
	ld a, 1
	ld [wMetronomeEnergyCost], a
	call CheckIfDefendingCardHasAnyAttacks
	ret

ClefableMetronome_AISelectEffect:
	call HandleAIMetronomeEffect
	ret

ClefableMetronome_UseAttackEffect:
	ld a, 1 ; energy cost of this attack
	call HandlePlayerMetronomeEffect
	ret

ClefableMinimizeEffect:
	ld a, SUBSTATUS1_REDUCE_BY_20
	call ApplySubstatus1ToAttackingCard
	ret

HurricaneEffect:
	call HandleNoDamageOrEffect
	ret c ; is unaffected

	ld a, DUELVARS_ARENA_CARD_HP
	call GetNonTurnDuelistVariable
	or a
	ret z ; return if Pokemon was KO'd

; look at all the card locations and put all cards
; that are in the Arena in the hand.
	call SwapTurn
	ld a, DUELVARS_CARD_LOCATIONS
	get_turn_duelist_var
.loop_locations
	ld a, [hl]
	cp CARD_LOCATION_ARENA
	jr nz, .next_card
	; card in Arena found, put in hand
	ld a, l
	call AddCardToHand
.next_card
	inc l
	ld a, l
	cp DECK_SIZE
	jr c, .loop_locations

; empty the Arena card slot
	ld l, DUELVARS_ARENA_CARD
	ld a, [hl]
	ld [hl], $ff
	ld l, DUELVARS_ARENA_CARD_HP
	ld [hl], 0
	ld l, DUELVARS_ARENA_CARD_ATTACHED_DEFENDER
	ld [hl], 0
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

PidgeottoWhirlwind_SelectEffect:
	call HandleMandatorySwitchSelection
	ldh a, [hTempPlayAreaLocation_ff9d]
	ldh [hTemp_ffa0], a
	ret

PidgeottoWhirlwind_SwitchEffect:
	ldh a, [hTemp_ffa0]
	call HandleSwitchDefendingPokemonEffect
	ret

PidgeottoMirrorMove_AIEffect:
	jp MirrorMove_AIEffect

PidgeottoMirrorMove_InitialEffect1:
	jp MirrorMove_InitialEffect1

PidgeottoMirrorMove_InitialEffect2:
	jp MirrorMove_InitialEffect2

PidgeottoMirrorMove_PlayerSelection:
	jp MirrorMove_PlayerSelection

PidgeottoMirrorMove_AISelection:
	jp MirrorMove_AISelection

PidgeottoMirrorMove_SwitchDefendingPkmn:
	jp MirrorMove_SwitchDefendingPkmn

PidgeottoMirrorMove_BeforeDamage:
	jp MirrorMove_BeforeDamage

PidgeottoMirrorMove_AfterDamage:
	jp MirrorMove_AfterDamage

ClefairySingEffect:
	call Sleep50PercentOrNoEffect
	ret

ClefairyMetronome_CheckAttacks:
	ld a, 3
	ld [wMetronomeEnergyCost], a
	call CheckIfDefendingCardHasAnyAttacks
	ret

ClefairyMetronome_AISelectEffect:
	call HandleAIMetronomeEffect
	ret

ClefairyMetronome_UseAttackEffect:
	ld a, 3 ; energy cost of this attack
;	fallthrough

; handles Metronome selection, and validates
; whether it can use the selected attack.
; if unsuccessful, returns carry.
; input:
;	a = amount of colorless energy needed for Metronome
HandlePlayerMetronomeEffect:
	ld [wMetronomeEnergyCost], a
	ldtx hl, ChooseOppAttackForMetronomeText
	call DrawWideTextBox_WaitForInput
.select_attack
	call HandleDefendingPokemonAttackSelection
	jr c, .select_attack

; store this attack as selected attack to use
	ld hl, wMetronomeSelectedAttack
	ld [hl], d
	inc hl
	ld [hl], e

; compare selected attack's name with
; the attack that is loaded, which is Metronome.
; if equal, then cannot select it.
; (i.e. cannot use Metronome with Metronome.)
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
	jr nz, .try_use
	inc hl
	ld a, d
	cp [hl]
	jr nz, .try_use
	; cannot select Metronome
	ldtx hl, UnableToSelectText
	call DrawWideTextBox_WaitForInput
	jr .select_attack

.try_use
; run the attack checks to determine
; whether it can be used.
	ld a, EFFECTCMDTYPE_INITIAL_EFFECT_1
	call TryExecuteEffectCommandFunction
	jr nc, .initial_effect_2
	; some requirement is not met
	call DrawWideTextBox_WaitForInput
	ld a, TRUE
	ld [wMetronomeAttackCannotBeUsed], a
	call .UseAttack
	scf
	ret

.initial_effect_2
; run initial effect 2 where player selection
; happens for some attacks
	ld a, EFFECTCMDTYPE_INITIAL_EFFECT_2
	call TryExecuteEffectCommandFunction
	jr c, .initial_effect_2

.UseAttack:
	call SendAttackDataToLinkOpponent
	ld a, OPPACTION_USE_METRONOME_ATTACK
	call SetOppAction_SerialSendDuelData
	ld hl, wMetronomeSelectedAttack
	ld d, [hl]
	inc hl
	ld e, [hl]
	ld a, [wMetronomeEnergyCost]
	ld c, a
	ld a, [wMetronomeAttackCannotBeUsed]
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

; does nothing for AI.
HandleAIMetronomeEffect:
	ret

WigglytuffLullabyEffect:
	call SleepEffect
	ret

DoTheWaveEffect:
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	dec a ; don't count arena card
	call ATimes10
	call AddToDamage
	ret

JigglypuffLullabyEffect:
	call SleepEffect
	ret

; return carry if no damage counters
JigglypuffFirstAid_DamageCheck:
	ld e, PLAY_AREA_ARENA
	call GetCardDamageAndMaxHP
	ldtx hl, NoDamageCountersText
	cp 10
	ret

JigglypuffFirstAid_HealEffect:
	ld de, 10
	call ApplyAndAnimateHPRecovery
	ret

JigglypuffDoubleEdgeEffect:
	ld a, 20
	call DealRecoilDamageToSelf
	ret

PounceEffect:
	ld a, SUBSTATUS2_POUNCE
	call ApplySubstatus2ToDefendingCard
	ret

TongueWrapEffect:
	call Paralysis50PercentEffect
	ret

LickitungSupersonicEffect:
	call Confusion50PercentOrNoEffect
	ret

PidgeyWhirlwind_SelectEffect:
	call HandleMandatorySwitchSelection
	ldh a, [hTempPlayAreaLocation_ff9d]
	ldh [hTemp_ffa0], a
	ret

PidgeyWhirlwind_SwitchEffect:
	ldh a, [hTemp_ffa0]
	call HandleSwitchDefendingPokemonEffect
	ret

PorygonLv12Conversion1_WeaknessCheck:
	jr CheckIfDefendingCardHasWeakness

PorygonLv12Conversion1_PlayerSelectEffect:
	jr HandleConversion1PlayerSelection

PorygonLv12Conversion1_AISelectEffect:
	jp AISelectConversionColor

PorygonLv12Conversion1_ChangeWeaknessEffect:
	jr ChangeDefendingCardsWeakness

; return carry if Defending card has no weakness
CheckIfDefendingCardHasWeakness:
	call SwapTurn
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call LoadCardDataToBuffer2_FromDeckIndex
	call SwapTurn
	ld a, [wLoadedCard2Weakness]
	or a
	ret nz
	ldtx hl, NoWeaknessText
	scf
	ret

HandleConversion1PlayerSelection:
	ldtx hl, ChooseWeaknessToConversion1Text
	xor a ; PLAY_AREA_ARENA
	farcall HandleColorChangeScreen
	ldh [hTemp_ffa0], a
	ret

; change Defending card's weakness given in [hTemp_ffa0]
ChangeDefendingCardsWeakness:
	ldh a, [hTemp_ffa0]
	cp $ff
	ret z
	call HandleNoDamageOrEffect
	ret c ; is unaffected

; apply changed weakness
	ld a, DUELVARS_ARENA_CARD_CHANGED_WEAKNESS
	call GetNonTurnDuelistVariable
	ldh a, [hTemp_ffa0]
	call TranslateColorToWR
	ld [hl], a
	ld l, DUELVARS_ARENA_CARD_LAST_TURN_CHANGE_WEAK
	ld [hl], a
	ld l, DUELVARS_ARENA_CARD_LAST_TURN_EFFECT
	ld [hl], LAST_TURN_EFFECT_CHANGE_WEAKNESS

; print text box
	call SwapTurn
	ldtx hl, ChangedTheWeaknessOfPokemonToColorText
	call PrintChangedCardWRText
	call SwapTurn

; apply substatus
	ld a, SUBSTATUS2_CONVERSION2
	call ApplySubstatus2ToDefendingCard
	ret

PorygonLv12Conversion2_ResistanceCheck:
	jr CheckIfAttackingCardHasResistance

PorygonLv12Conversion2_PlayerSelectEffect:
	jr HandleConversion2PlayerSelection

PorygonLv12Conversion2_AISelectEffect:
	jr AISelectConversion2Color

PorygonLv12Conversion2_ChangeResistanceEffect:
	jr ChangeAttackingCardsResistance

; return carry if Attacking card has no resistance
CheckIfAttackingCardHasResistance:
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call LoadCardDataToBuffer2_FromDeckIndex
	ld a, [wLoadedCard2Resistance]
	or a
	ret nz
	ldtx hl, NoResistanceText
	scf
	ret

HandleConversion2PlayerSelection:
	ldtx hl, ChooseResistanceToConversion2Text
	ld a, $80
	farcall HandleColorChangeScreen
	ldh [hTemp_ffa0], a
	ret

AISelectConversion2Color:
; AI will choose Defending Pokemon's color
; unless it is colorless.
	call SwapTurn
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call LoadCardDataToBuffer1_FromDeckIndex
	call SwapTurn
	ld a, [wLoadedCard1Type]
	cp COLORLESS
	jr z, .is_colorless
	ldh [hTemp_ffa0], a
	ret
.is_colorless
	call SwapTurn
	call AISelectConversionColor
	call SwapTurn
	ret

; change Attacking card's resistance given in [hTemp_ffa0]
ChangeAttackingCardsResistance:
	ldh a, [hTemp_ffa0]
	cp $ff
	ret z
; apply changed resistance
	ld a, DUELVARS_ARENA_CARD_CHANGED_RESISTANCE
	get_turn_duelist_var
	ldh a, [hTemp_ffa0]
	call TranslateColorToWR
	ld [hl], a
	ldtx hl, ChangedTheResistanceOfPokemonToColorText
;	fallthrough
PrintChangedCardWRText:
	push hl
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call LoadCardDataToBuffer1_FromDeckIndex
	ldh a, [hTemp_ffa0]
	call LoadCardNameAndInputColor
	pop hl
	call DrawWideTextBox_PrintText
	ret

; handles AI logic for selecting a new color
; for weakness/resistance.
; - if within the context of Conversion1, looks
; in own Bench for a non-colorless card that can attack.
; - if within the context of Conversion2, looks
; in Player's Bench for a non-colorless card that can attack.
AISelectConversionColor:
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	ld d, a
	ld e, PLAY_AREA_ARENA
	jr .next_pkmn_atk

; look for a non-colorless Bench Pokemon
; that has enough energy to use an attack.
.loop_atk
	push de
	call GetPlayAreaCardAttachedEnergies
	ld a, e
	add DUELVARS_ARENA_CARD
	get_turn_duelist_var
	ld d, a
	call LoadCardDataToBuffer1_FromDeckIndex
	ld a, [wLoadedCard1Type]
	cp COLORLESS
	jr z, .skip_pkmn_atk ; skip colorless Pokemon
	ld e, FIRST_ATTACK_OR_PKMN_POWER
	bank1call CheckIfEnoughEnergiesForGivenAttack
	jr nc, .found
	ld e, SECOND_ATTACK
	bank1call CheckIfEnoughEnergiesForGivenAttack
	jr nc, .found
.skip_pkmn_atk
	pop de
.next_pkmn_atk
	inc e
	dec d
	jr nz, .loop_atk

; none found in Bench.
; next, look for a non-colorless Bench Pokemon
; that has any Energy cards attached.
	ld d, e ; number of Play Area Pokemon
	ld e, PLAY_AREA_ARENA
	jr .next_pkmn_energy

.loop_energy
	push de
	call GetPlayAreaCardAttachedEnergies
	ld a, [wTotalAttachedEnergies]
	or a
	jr z, .skip_pkmn_energy
	ld a, e
	add DUELVARS_ARENA_CARD
	get_turn_duelist_var
	ld d, a
	call LoadCardDataToBuffer1_FromDeckIndex
	ld a, [wLoadedCard1Type]
	cp COLORLESS
	jr nz, .found
.skip_pkmn_energy
	pop de
.next_pkmn_energy
	inc e
	dec d
	jr nz, .loop_energy

; otherwise, just select a random energy.
	ld a, NUM_COLORED_TYPES
	call Random
	ldh [hTemp_ffa0], a
	ret

.found
	pop de
	ld a, [wLoadedCard1Type]
	and TYPE_PKMN
	ldh [hTemp_ffa0], a
	ret

ScrunchEffect:
	ldtx de, IfHeadsNoDamageNextTurnText
	call TossCoin_Bank1a
	jp nc, SetWasUnsuccessful
	ld a, ATK_ANIM_SCRUNCH
	ld [wLoadedAttackAnimation], a
	ld a, SUBSTATUS1_NO_DAMAGE_SCRUNCH
	call ApplySubstatus1ToAttackingCard
	ret

ChanseyDoubleEdgeEffect:
	ld a, 80
	call DealRecoilDamageToSelf
	ret

SuperFangEffect:
	ld a, DUELVARS_ARENA_CARD_HP
	call GetNonTurnDuelistVariable
	srl a
	bit 0, a
	jr z, .rounded
	; round up
	add 5
.rounded
	call SetDefiniteDamage
	ret

; return carry if no Pokemon in Bench
; unused in-game
TrainerCardAsPokemon_BenchCheck:
	ldh a, [hTempPlayAreaLocation_ff9d]
	ldh [hTemp_ffa0], a
	call CheckIfTurnDuelistHasBench
	ret

; unused in-game
TrainerCardAsPokemon_PlayerSelectSwitch:
	ldh a, [hTemp_ffa0]
	or a
	ret nz ; no need to switch if it's not Arena card

	ldtx hl, SelectPokemonToPlaceInTheArenaText
	call DrawWideTextBox_WaitForInput
	bank1call HasAlivePokemonInBench
	bank1call OpenPlayAreaScreenForSelection
	ldh a, [hTempPlayAreaLocation_ff9d]
	ldh [hTempPlayAreaLocation_ffa1], a
	ret

; unused in-game
TrainerCardAsPokemon_DiscardEffect:
	ldh a, [hTemp_ffa0]
	ld e, a
	call DiscardPlayAreaCard
	ldh a, [hTemp_ffa0]
	or a
	jr nz, .shift_cards
	ldh a, [hTempPlayAreaLocation_ffa1]
	ld e, a
	call SwapArenaWithBenchPokemon
.shift_cards
	call ShiftAllPokemonToFirstPlayAreaSlots
	ret

HealingWind_InitialEffect:
	scf
	ret

HealingWind_PlayAreaHealEffect:
; play initial animation
	ldh a, [hTempPlayAreaLocation_ff9d]
	ld b, a
	ld c, $00
	ldh a, [hWhoseTurn]
	ld h, a
	farcall PlayAttackAnimation
	farcall WaitAttackAnimation
	farcall ResetAttackAnimationIsPlaying
	ld a, ATK_ANIM_HEALING_WIND_PLAY_AREA
	ld [wLoadedAttackAnimation], a

	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	ld d, a
	ld e, PLAY_AREA_ARENA
.loop_play_area
	push de
	ld a, e
	ldh [hTempPlayAreaLocation_ff9d], a
	call GetCardDamageAndMaxHP
	or a
	jr z, .next_pkmn ; skip if no damage

; if less than 20 damage, cap recovery at 10 damage
	ld de, 20
	cp e
	jr nc, .heal
	ld e, a

.heal
; add HP to this card
	ldh a, [hTempPlayAreaLocation_ff9d]
	add DUELVARS_ARENA_CARD_HP
	get_turn_duelist_var
	add e
	ld [hl], a

; play heal animation
	ldh a, [hTempPlayAreaLocation_ff9d]
	ld b, a
	ld c, $01
	ldh a, [hWhoseTurn]
	ld h, a
	farcall PlayAttackAnimation
	farcall WaitAttackAnimation
.next_pkmn
	pop de
	inc e
	dec d
	jr nz, .loop_play_area
	ret

DragoniteLv41Slam_AIEffect:
	ld a, (30 * 2) / 2
	lb de, 0, 60
	call SetExpectedAIDamage
	ret

DragoniteLv41Slam_MultiplierEffect:
	ld hl, 30
	call LoadTxRam3
	ldtx de, DamageCheckXDamageTimesHeadsText
	ld a, 2
	call TossCoinATimes_Bank1a
	ld c, a
	add a
	add c
	call ATimes10
	call SetDefiniteDamage
	ret

CopyPlayAreaHPToBackup_Unreferenced:
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	ld c, a
	ld l, DUELVARS_ARENA_CARD_HP
	ld de, wBackupPlayerAreaHP
.loop
	ld a, [hli]
	ld [de], a
	inc de
	dec c
	jr nz, .loop
	ret

CopyPlayAreaHPFromBackup_Unreferenced:
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	ld c, a
	ld l, DUELVARS_ARENA_CARD_HP
	ld de, wBackupPlayerAreaHP
.loop
	ld a, [de]
	inc de
	ld [hli], a
	dec c
	jr nz, .loop
	ret

CatPunchEffect:
	call SwapTurn
	call PickRandomPlayAreaCard
	ld b, a
	ld a, ATK_ANIM_CAT_PUNCH_PLAY_AREA
	ld [wLoadedAttackAnimation], a
	ld de, 20
	call DealDamageToPlayAreaPokemon
	call SwapTurn
	ret

Morph_CheckDeck:
	farcall CheckIfDeckIsEmpty
	ret

Morph_TransformEffect:
	call ExchangeRNG
	call .PickRandomBasicPokemonFromDeck
	jr nc, .successful
	ldtx hl, AttackUnsuccessfulText
	call DrawWideTextBox_WaitForInput
	ret

.successful
	ld a, DUELVARS_ARENA_CARD_STAGE
	get_turn_duelist_var
	or a
	jr z, .skip_discard_stage_below

; if this is a stage 1 Pokemon (in case it's used
; by Clefable's Metronome attack) then first discard
; the lower stage card.
	push hl
	xor a ; PLAY_AREA_ARENA
	ldh [hTempPlayAreaLocation_ff9d], a
	bank1call GetCardOneStageBelow
	ld a, d
	call PutCardInDiscardPile
	pop hl
	ld [hl], BASIC

.skip_discard_stage_below
; overwrite card ID
	ldh a, [hTempCardIndex_ff98]
	call GetCardIDFromDeckIndex
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	ldh [hTempCardIndex_ff98], a
	call _GetCardIDFromDeckIndex
	ld [hl], e
	inc hl
	ld [hl], d

; overwrite HP to new card's maximum HP
	ld e, PLAY_AREA_ARENA
	call GetCardDamageAndMaxHP
	ld a, DUELVARS_ARENA_CARD_HP
	get_turn_duelist_var
	ld [hl], c

; clear changed color and status
	ld l, DUELVARS_ARENA_CARD_CHANGED_TYPE
	ld [hl], $00
	call ClearAllStatusConditions

; load both card's names for printing text
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

; picks a random Pokemon in the Deck to morph.
; needs to be a Basic Pokemon that isn't Ditto
; returns carry if no Pokemon were found.
.PickRandomBasicPokemonFromDeck:
	call CreateDeckCardList
	ret c ; empty deck
	ld hl, wDuelTempList
	call ShuffleCards
.loop_deck
	ld a, [hli]
	ldh [hTempCardIndex_ff98], a
	cp $ff
	jr z, .set_carry
	call LoadCardDataToBuffer2_FromDeckIndex
	ld a, [wLoadedCard2Type]
	cp TYPE_ENERGY
	jr nc, .loop_deck ; skip non-Pokemon cards
	ld a, [wLoadedCard2Stage]
	or a
	jr nz, .loop_deck ; skip non-Basic cards
	push hl
	ld hl, wLoadedCard2ID
	cphl DITTO
	pop hl
	jr z, .loop_deck ; skip other Ditto cards
	ldh a, [hTempCardIndex_ff98]
	or a
	ret
.set_carry
	scf
	ret

; returns in a and [hTempCardIndex_ff98] the deck index
; of random Basic Pokemon card in deck.
; if none are found, return carry.
PickRandomBasicCardFromDeck:
	call CreateDeckCardList
	ret c ; return if empty deck
	ld hl, wDuelTempList
	call ShuffleCards
.loop_deck
	ld a, [hli]
	ldh [hTempCardIndex_ff98], a
	cp $ff
	jr z, .set_carry
	call LoadCardDataToBuffer2_FromDeckIndex
	ld a, [wLoadedCard2Type]
	cp TYPE_ENERGY
	jr nc, .loop_deck ; skip if not Pokemon card
	ld a, [wLoadedCard2Stage]
	or a
	jr nz, .loop_deck ; skip if not Basic stage
	ldh a, [hTempCardIndex_ff98]
	or a
	ret
.set_carry
	scf
	ret

SlicingWindEffect:
	call SwapTurn
	call PickRandomPlayAreaCard
	ld b, a
	ld de, 30
	call DealDamageToPlayAreaPokemon_RegularAnim
	call SwapTurn
	ret

Gale_LoadAnimation:
	ld a, ATK_ANIM_GALE
	ld [wLoadedAttackAnimation], a
	ret

Gale_SwitchEffect:
; skip switch effect if Defending card was
; knocked out and has Destiny Bond
	ld a, DUELVARS_ARENA_CARD_HP
	call GetNonTurnDuelistVariable
	or a
	jr nz, .has_hp
	ld a, DUELVARS_ARENA_CARD_SUBSTATUS1
	call GetNonTurnDuelistVariable
	cp SUBSTATUS1_DESTINY_BOND
	jr nz, .dont_switch_defending
	ret
.has_hp
	call CheckNonTurnDuelistHasBench
	jr c, .dont_switch_defending
; get random Bench location and swap
	dec a
	call Random
	inc a
	call HandleSwitchDefendingPokemonEffect

.dont_switch_defending
	call CheckIfTurnDuelistHasBench
	ret c ; return if no Bench Pokemon

; get random Bench location and swap
	dec a
	call Random
	inc a
	ld [wcd0a], a
	ld e, a
	call SwapArenaWithBenchPokemon
	xor a
	ld [wDuelDisplayedScreen], a
	ret

FriendshipSong_BenchCheck:
	farcall CheckIfDeckIsEmpty
	ret c ; return if no cards in deck
	farcall CheckIfHasSpaceInBench
	ret

FriendshipSong_AddToBench50PercentEffect:
	ldtx de, AttackSuccessCheckText
	call TossCoin_Bank1a
	jr c, .successful

.none_came_text
	ldtx hl, NoneCameText
	call DrawWideTextBox_WaitForInput
	ret

.successful
	call PickRandomBasicCardFromDeck
	jr nc, .put_in_bench
	ld a, ATK_ANIM_FRIENDSHIP_SONG
	farcall PlayAttackAnimationOverAttackingPokemon
	call .none_came_text
	call ShuffleCardsInDeck
	ret

.put_in_bench
	call SearchCardInDeckAndAddToHand
	call AddCardToHand
	call PutHandPokemonCardInPlayArea
	ld a, ATK_ANIM_FRIENDSHIP_SONG
	farcall PlayAttackAnimationOverAttackingPokemon
	ldh a, [hTempCardIndex_ff98]
	ldtx hl, CameToTheBenchText
	bank1call DisplayCardDetailScreen
	call ShuffleCardsInDeck
	ret

JigglypuffExpandEffect:
	ld a, SUBSTATUS1_REDUCE_BY_10
	call ApplySubstatus1ToAttackingCard
	ret

GatherFire_CheckUse:
	call CheckIfCanUsePkmnPowerThisTurn
	ret

GatherFire_PlayerSelectEffect:
	ldtx hl, ProcedureForGatherFireText
	bank1call DrawWholeScreenTextBox
	bank1call HasAlivePokemonInPlayArea
.loop
	bank1call OpenPlayAreaScreenForSelection
	ret c ; operation cancelled
	; is the same card as Charmander?
	ldh a, [hTempPlayAreaLocation_ff9d]
	ld e, a
	ldh a, [hTemp_ffa0]
	cp e
	jr z, .loop
	; not same Pokémon, transfer energy
	call GetListOfFireEnergiesFromPlayAreaCard
	jr c, .loop ; no cards

	; list was created, select one
	ldh a, [hTempPlayAreaLocation_ff9d]
	ldtx de, ChooseEnergyCardToRemoveText
	bank1call DisplayAttachedEnergyMenu
	bank1call HandleAttachedEnergyMenuInput
	ret c ; operation cancelled

	; store selection
	ldh a, [hTempCardIndex_ff98]
	ldh [hTempPlayAreaLocation_ffa1], a
	ret

GatherFire_TransferEnergyEffect:
	call SetUsedPkmnPowerThisTurnFlag
	ldh a, [hTemp_ffa0]
	ldh [hTempPlayAreaLocation_ff9d], a
	ld e, a
	or a
	jr z, .no_animation
	ld a, ATK_ANIM_PKMN_POWER_1
	ld [wLoadedAttackAnimation], a
.no_animation
	ldh a, [hTempPlayAreaLocation_ffa1]
	call AddCardToHand
	call PutHandCardInPlayArea
	ld a, [wLoadedAttackAnimation]
	farcall PlayAttackAnimationOverAttackingPokemon
	ret

Fireball_AIEffect:
	ld a, 70
	lb de, 0, 70
	call SetExpectedAIDamage
	ret

Fireball_CheckEnergy:
	call Func_6808d
	call CheckIfArenaCardHasFireOrRainbowEnergy
	ret

Fireball_AISuccess50PercentEffect:
	ldtx de, DamageCheckIfTailsNoDamageText
	call Serial_TossCoin
	ldh [hTemp_ffa0], a
	ret nc ; tails
	call AIPickFireEnergyCardToDiscard
	ldh [hTempPlayAreaLocation_ffa1], a
	ld a, $01
	ldh [hTemp_ffa0], a
	ret

Fireball_PlayerSuccess50PercentEffect:
	ldtx de, DamageCheckIfTailsNoDamageText
	call Serial_TossCoin
	ldh [hTemp_ffa0], a
	ret nc ; tails
.select_energy
	call PlayerPickFireEnergyCardToDiscard
	jr c, .select_energy
	ld a, $01
	ldh [hTemp_ffa0], a
	ldh a, [hTempCardIndex_ff98]
	ldh [hTempPlayAreaLocation_ffa1], a
	ret

Fireball_DiscardEffect:
	; if result was heads, discard card
	ldh a, [hTemp_ffa0]
	or a
	jr z, .not_successful
	ldh a, [hTempPlayAreaLocation_ffa1]
	jp DiscardCard
.not_successful
	; else set 0 damage and unsuccessful flag
	xor a
	ld [wLoadedAttackAnimation], a
	call SetDefiniteDamage ; 0 damage
	call SetWasUnsuccessful
	ret

ContinuousFireball_CheckEnergy:
	call Func_6808d
	call CheckIfArenaCardHasFireOrRainbowEnergy
	ret

ContinuousFireball_AIEffect:
	ld e, PLAY_AREA_ARENA
	call GetNumberOfAttachedFireAndRainbowEnergy
	ld l, a
	ld h, 50
	call HtimesL
	ld a, h
	or a
	jr z, .capped
	ld l, 255
.capped
	; sets max damage as (num fire energy) * 50
	ld a, l
	ld [wAIMaxDamage], a
	; sets expected damage as half max amount
	srl a ; /2
	ld [wDamage], a
	; sets min damage as 0
	xor a ; 0
	ld [wAIMinDamage], a
	ret

ContinuousFireball_AIMultiplierEffect:
	ld hl, 50
	call LoadTxRam3
	ld e, PLAY_AREA_ARENA
	call GetNumberOfAttachedFireAndRainbowEnergy
	ld hl, 50
	ldtx de, DamageCheckXDamageTimesHeadsText
	call Serial_TossCoinATimes
	ldh [hTemp_ffa0], a
	or a
	ret z ; no heads

	call CreateListOfFireEnergyAttachedToArena

	; cap number of heads to 14
	ldh a, [hTemp_ffa0]
	cp 15
	jr c, .capped
	ld a, 14
.capped
	ld c, a
	ld hl, wDuelTempList
	ld de, hTempList + 1
.loop_selection
	ld a, [hli]
	ld [de], a
	inc de
	dec c
	jr nz, .loop_selection
	ld a, $ff ; terminating byte
	ld [de], a
	ret

ContinuousFireball_PlayerMultiplierEffect:
	ld hl, 50
	call LoadTxRam3
	ld e, PLAY_AREA_ARENA
	call GetNumberOfAttachedFireAndRainbowEnergy
	ld hl, 50
	ldtx de, DamageCheckXDamageTimesHeadsText
	call Serial_TossCoinATimes
	ldh [hTemp_ffa0], a
	or a
	ret z ; no heads

	; cap number of heads to 14
	cp 16 ; bug, should be 15
	jr c, .capped
	ld a, 14
	ldh [hTemp_ffa0], a
.capped
	; select Fire energies to discard
	; start at hTempList + 1
	ld a, 1
	ldh [hCurSelectionItem], a

	call CreateListOfFireEnergyAttachedToArena
	xor a ; PLAY_AREA_ARENA
	bank1call DisplayEnergyDiscardMenu
	ldh a, [hTemp_ffa0]
	ld [wAttachedEnergyMenuDenominator], a
.loop_selection
	bank1call HandleAttachedEnergyMenuInput
	jr c, .loop_selection ; mandatory selection
	farcall GetNextPositionInTempList
	ldh a, [hTempCardIndex_ff98]
	ld [hl], a
	call RemoveCardFromDuelTempList
	ld hl, wAttachedEnergyMenuNumerator
	inc [hl]
	ld a, [wAttachedEnergyMenuDenominator]
	cp [hl]
	ret z ; no more energies to discard
	bank1call UpdateAttachedEnergyMenu
	jr .loop_selection

ContinuousFireball_DiscardEffect:
	; discard if any heads
	ld hl, hTemp_ffa0
	ld a, [hli]
	or a
	jr z, .no_discard
	ld c, a
.loop_discard
	ld a, [hli]
	call DiscardCard
	dec c
	jr nz, .loop_discard
.no_discard
	; set damage to num heads * 50
	ldh a, [hTemp_ffa0]
	ld l, a
	ld h, 50
	call HtimesL
	ld a, l
	ld [wDamage], a
	ld a, h
	ld [wDamage + 1], a
	ret

PonytaEmber_CheckEnergy:
	call CheckIfArenaCardHasFireOrRainbowEnergy
	ret

PonytaEmber_PlayerSelectEffect:
	call PlayerPickFireEnergyCardToDiscard
	ret

PonytaEmber_AISelectEffect:
	call AIPickFireEnergyCardToDiscard
	ret

PonytaEmber_DiscardEffect:
	ldh a, [hTemp_ffa0]
	jp DiscardCard

FlamePillar_AISelectEffect:
	; AI always selects "no"
	ld a, $01
	ldh [hTemp_ffa0], a
	ret

FlamePillar_PlayerSelectEffect:
	; default is "no"
	ld a, $01
	ldh [hTemp_ffa0], a

	; has any Fire/Rainbow energy?
	call CheckIfArenaCardHasFireOrRainbowEnergy
	jr c, .no_carry
	; does opponent have Bench?
	call CheckNonTurnDuelistHasBench
	jr c, .no_carry
	; prompt player if they want to discard
	ldtx hl, RemoveEnergyCardPromptText
	call YesOrNoMenuWithText
	ldh [hTemp_ffa0], a
	jr c, .no_carry

.select_energy
	call PlayerPickFireEnergyCardToDiscard
	jr c, .select_energy
	xor a
	ldh [hTemp_ffa0], a

	ldh a, [hTempCardIndex_ff98]
	ldh [hTempPlayAreaLocation_ffa1], a
.select_bench_pkmn
	call SwapTurn
	bank1call HasAlivePokemonInBench
	bank1call OpenPlayAreaScreenForSelection
	call SwapTurn
	jr c, .select_bench_pkmn
	ldh [hPlayAreaEffectTarget], a
.no_carry
	or a
	ret

FlamePillar_BenchDamageEffect:
	ldh a, [hTemp_ffa0]
	or a
	ret nz ; no damage to bench

	; first discard selected card
	ldh a, [hTempPlayAreaLocation_ffa1]
	call DiscardCard

	; then damage Bench Pokémon
	call SwapTurn
	ldh a, [hPlayAreaEffectTarget]
	ld b, a
	ld de, 10
	bank1call ApplyDarkWaveDamageBoost
	call DealDamageToPlayAreaPokemon_RegularAnim
	call SwapTurn
	ret

DarkFlareonRage_AIEffect:
	ldh a, [hTempPlayAreaLocation_ff9d]
	jr CalculateDarkFlareonRageDamage
DarkFlareonRage_DamageBoostEffect:
	xor a ; PLAY_AREA_ARENA
CalculateDarkFlareonRageDamage:
	ld e, a
	call GetCardDamageAndMaxHP
	call AddToDamage
	ret

PlayingWithFire_InitialEffect:
	call Func_6808d
	ret

PlayingWithFire_AIEffect:
	ld e, PLAY_AREA_ARENA
	call GetNumberOfAttachedFireAndRainbowEnergy
	cp 1
	jr c, .no_damage
	ld a, (30 + 50) / 2
	lb de, 30, 50
	call SetExpectedAIDamage
	ret
.no_damage
	ld a, 0
	lb de, 0, 0
	call SetExpectedAIDamage
	ret

PlayingWithFire_AISelectEffect:
	ld hl, 20
	call LoadTxRam3
	ldtx de, DamageCheckIfHeadsPlusDamageText
	call Serial_TossCoin
	ldh [hTemp_ffa0], a ; useless, this will be overwritten
	ret nc ; got tails
	call AIPickFireEnergyCardToDiscard
	ldh a, [hTemp_ffa0]
	ldh [hTempPlayAreaLocation_ffa1], a
	ld a, $01
	ldh [hTemp_ffa0], a
	ret

PlayingWithFire_PlayerSelectEffect:
	ld hl, 20
	call LoadTxRam3
	ldtx de, DamageCheckIfHeadsPlusDamageText
	call Serial_TossCoin
	ldh [hTemp_ffa0], a
	ret nc ; got tails

	; select Fire energy if any
	ld e, PLAY_AREA_ARENA
	call GetNumberOfAttachedFireAndRainbowEnergy
	cp 1
	jr c, .no_fire_energy
.select_energy
	call PlayerPickFireEnergyCardToDiscard
	jr c, .select_energy
	ldh a, [hTempCardIndex_ff98]
	jr .got_card
.no_fire_energy
	ld a, $ff
.got_card
	ldh [hTempPlayAreaLocation_ffa1], a
	ld a, $01
	ldh [hTemp_ffa0], a
	or a
	ret

PlayingWithFire_DiscardAndDamageBonusEffect:
	; did we get heads?
	ldh a, [hTemp_ffa0]
	or a
	ret z ; got tails
	; did we select a card to discard?
	ldh a, [hTempPlayAreaLocation_ffa1]
	cp $ff
	jr z, .no_damage
	call DiscardCard
	ld a, 20
	call AddToDamage
	ret

.no_damage
	xor a
	call SetDefiniteDamage
	call SetWasUnsuccessful
	ret

DarkWartortleDoubleslap_AIEffect:
	ld a, (10 * 2) / 2
	lb de, 0, 20
	call SetExpectedAIDamage
	ret

DarkWartortleDoubleslap_MultiplierEffect:
	ld hl, 10
	call LoadTxRam3
	ldtx de, DamageCheckXDamageTimesHeadsText
	ld a, 2
	call TossCoinATimes_Bank1a
	call ATimes10
	call SetDefiniteDamage
	ret

DarkWartortleMirrorShellEffect:
	ld a, SUBSTATUS1_MIRROR_SHELL
	call ApplySubstatus1ToAttackingCard
	ret

HydrocannonEffect:
	lb bc, 2, 0
	call ApplyExtraWaterEnergy20DamageBonus
	ret

RocketTackle_NoDamageCheckEffect:
	ldtx de, IfHeadsNoDamageNextTurnText
	call TossCoin_Bank1a
	ldh [hTemp_ffa0], a
	ret c ; got heads
	ld a, ATK_ANIM_ROCKET_TACKLE_NO_PROTECT
	ld [wLoadedAttackAnimation], a
	ret

RocketTackle_NoDamageEffect:
	; deal recoil damage
	ld de, 10
	bank1call ApplyDarkWaveDamageBoost
	ld a, e
	call DealRecoilDamageToSelf
	ldh a, [hTemp_ffa0]
	or a
	ret z ; got tails
	; if got heads, no damage next turn
	ld a, SUBSTATUS1_NO_DAMAGE_ROCKET_TACKLE
	call ApplySubstatus1ToAttackingCard
	ret

Dizziness_CheckDeck:
	farcall CheckIfDeckIsEmpty
	ret

Dizziness_DrawCardEffect:
	ldtx hl, Draw1CardFromTheDeckText
	call DrawWideTextBox_WaitForInput
	farcall DisplayDrawOneCardScreen
	call DrawCardFromDeck
	ret c
	call AddCardToHand
	call LoadCardDataToBuffer1_FromDeckIndex
	ld a, [wDuelistType]
	cp DUELIST_TYPE_PLAYER
	ret nz
	; show card on screen if it was Player
	bank1call OpenCardPage_FromHand
	ret

PsyduckWaterGunEffect:
	lb bc, 1, 1
	call ApplyExtraWaterEnergy10DamageBonus
	ret

ThirdEye_DeckAndEnergyCheck:
	farcall CheckIfDeckIsEmpty
	ret c ; return if no cards in deck
	ld e, PLAY_AREA_ARENA
	call GetPlayAreaCardAttachedEnergies
	ld a, [wTotalAttachedEnergies]
	or a
	ret nz ; has energy
	ldtx hl, NoEnergyCardsText
	scf
	ret

ThirdEye_AISelectEffect:
	xor a ; PLAY_AREA_ARENA
	call CreateArenaOrBenchEnergyCardList
	bank1call SortCardsInDuelTempListByID
	; select the first card in the list
	ld a, [wDuelTempList]
	ldh [hTemp_ffa0], a
	ret

ThirdEye_PlayerSelectEffect:
	xor a ; PLAY_AREA_ARENA
	call CreateArenaOrBenchEnergyCardList
	xor a ; PLAY_AREA_ARENA
	bank1call DisplayEnergyDiscardMenu
	bank1call HandleAttachedEnergyMenuInput
	ret c ; operation cancelled
	ldh a, [hTempCardIndex_ff98]
	ldh [hTemp_ffa0], a
	ret

ThirdEye_DiscardEffect:
	ldh a, [hTemp_ffa0]
	jp DiscardCard

ThirdEye_DrawCardsEffect:
	ld a, 3
	farcall DisplayDrawNCardsScreen
	ld c, 3
.loop_draw
	call DrawCardFromDeck
	jr c, .done
	ldh [hTempCardIndex_ff98], a
	call AddCardToHand
	call IsPlayerTurn
	jr nc, .dont_display_card
	push bc
	bank1call DisplayPlayerDrawCardScreen
	pop bc
.dont_display_card
	dec c
	jr nz, .loop_draw
.done
	ret

RapidEvolution_CheckEvolutionAndDeck:
	; check if it's Magikarp using this attack
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call GetCardIDFromDeckIndex
	cp16 MAGIKARP_LV6
	jr nz, .cannot_evolve
	; next check if deck is empty
	farcall CheckIfDeckIsEmpty
	ret
.cannot_evolve
	; not Magikarp, cannot use this to evolve
	ldtx hl, CannotEvolveText
	scf
	ret

RapidEvolution_PlayerSelectEffect:
	call CreateDeckCardList
	ldtx hl, ChooseEvolutionCardForMagikarpFromDeckText
	ldtx bc, EffectTargetGyaradosText
	ld de, DEX_GYARADOS
	ld a, CARDSEARCH_POKEDEX_NUMBER
	farcall LookForCardsInDeck
	jr c, .got_selection
	ldtx hl, ChooseAGyaradosText
	ldtx de, DuelistDeckText
	farcall SelectCardSearchTarget
.got_selection
	ldh [hTemp_ffa0], a
	ret

RapidEvolution_AISelectEffect:
	ld de, DEX_GYARADOS
	ld a, CARDSEARCH_POKEDEX_NUMBER
	farcall SetCardSearchFuncParams
	call CreateDeckCardList
	ld hl, wDuelTempList
.loop
	ld a, [hli]
	ldh [hTemp_ffa0], a
	cp $ff
	ret z
	farcall ExecuteCardSearchFunc
	jr nc, .loop
	ret

RapidEvolution_EvolveEffect:
	ldh a, [hTemp_ffa0]
	cp $ff
	jr z, .none_chosen
	; a Gyarados card was successfully chosen
	; play it as evolution to Magikarp
	ldh [hTempCardIndex_ff98], a
	call SearchCardInDeckAndAddToHand
	call AddCardToHand
	xor a
	ldh [hTempPlayAreaLocation_ff9d], a
	call EvolvePokemonCard
.none_chosen
	call ShuffleCardsInDeck
	ret

FinalBeamEffect:
	scf
	ret

DarkGyaradosIceBeamEffect:
	call Paralysis50PercentEffect
	ret

DarkVaporeonWhirlpool_PlayerSelectEffect:
	call HandleDiscardEnergyFromDefendingCardPlayerSelection
	ret

DarkVaporeonWhirlpool_AISelectEffect:
	call AIPickEnergyCardToDiscardFromDefendingPokemon
	ret

DarkVaporeonWhirlpool_DiscardEffect:
	call DiscardEnergyEffect
	ret

EkansPoisonSting_AIEffect:
	ld a, 10 / 2
	lb de, 0, 10
	call UpdateExpectedAIDamage_AccountForPoison
	ret

EkansPoisonSting_Poison50PercentEffect:
	ldtx de, PoisonInflictionCheckText
	call TossCoin_Bank1a
	jr nc, .tails
	call PoisonEffect
	ret
.tails
	ld a, ATK_ANIM_HIT
	ld [wLoadedAttackAnimation], a
	ret

Stare_AIEffect:
	ld a, 10
	call SetDefiniteDamageAndSetUnaffectedByWR
	ret

Stare_PlayerSelectEffect:
	call HandlePlayerSelectOppPlayAreaPkmn
	ret

Stare_AISelectEffect:
	jr AISelectStareTarget

Stare_BeforeDamageEffect:
	jr SetAttackAnimationToNoneAndResetResidualIfTargetIsArenaCard

Stare_DamageBenchEffect:
	ld de, 10
	jr DealStareDamage

; sets Arena card as Stare target
; used when Mirror Move is copying Stare attack
SetArenaCardAsStareTarget:
	xor a
	ldh [hTemp_ffa0], a
	ret

AISelectStareTarget:
	call AIFindTargetForPlayAreaAttack
	ldh [hTemp_ffa0], a
	ret

SetAttackAnimationToNoneAndResetResidualIfTargetIsArenaCard:
	xor a ; ATK_ANIM_NONE
	ld [wLoadedAttackAnimation], a
	ldh a, [hTemp_ffa0]
	or a
	ret nz ; is Bench
	ld hl, wLoadedAttackCategory
	res RESIDUAL_F, [hl]
	ret

; input:
; - de = damage to deal
; - [hTemp_ffa0] = target chosen
DealStareDamage:
	ldh a, [hTemp_ffa0]
	cp $ff
	ret z ; no target
	push de
	call SwapTurn
	ld e, a
	bank1call HandlePlayAreaCardNoDamageOrEffect
	call SwapTurn
	pop de
	ret c ; is unaffected

	; go through with attack
	ld a, ATK_ANIM_STARE_BENCH
	ld [wLoadedAttackAnimation], a
	call SwapTurn
	ldh a, [hTemp_ffa0]
	or a
	jr nz, .bench_target

; arena target
	ld a, DUELVARS_ARENA_CARD_LAST_TURN_EFFECT
	get_turn_duelist_var
	ld [hl], LAST_TURN_EFFECT_STARE
	ld a, ATK_ANIM_STARE
	ld [wLoadedAttackAnimation], a
.bench_target
	ldh a, [hTemp_ffa0]
	ld b, a
	bank1call ApplyDarkWaveDamageBoostIfTargetIsBench
	call DealDamageToPlayAreaPokemon
	ld a, [wNoDamageOrEffect]
	or a
	jr nz, .done ; no effect or damage
	ldh a, [hTemp_ffa0]
	add DUELVARS_ARENA_CARD_HP
	get_turn_duelist_var
	or a
	jr z, .done ; target was KO'd

	; set Stare flag
	ldh a, [hTemp_ffa0]
	add DUELVARS_ARENA_CARD_FLAGS
	get_turn_duelist_var
	set AFFECTED_BY_STARE_F, [hl]
	; reset changed type
	ldh a, [hTemp_ffa0]
	add DUELVARS_ARENA_CARD_CHANGED_TYPE
	ld l, a
	ld [hl], $00

.done
	call SwapTurn
	ret

PoisonVapor_PoisonEffect:
	call PoisonEffect
	ret

PoisonVapor_DamageBenchEffect:
	call SwapTurn
	ld de, 10
	bank1call ApplyDarkWaveDamageBoost
	ld a, e
	call DealDamageToAllBenchedPokemon
	call SwapTurn
	ret

SneakAttack_InitialEffect:
	scf
	ret

SneakAttack_PlayerSelectEffect:
	call SwapTurn
	bank1call HasAlivePokemonInPlayArea
.select_pkmn
	bank1call OpenPlayAreaScreenForSelection
	jr c, .select_pkmn ; mandatory selection
	ldh [hTemp_ffa0], a
	call SwapTurn
	ret

SneakAttack_DealDamageEffect:
	call SwapTurn
	ldh a, [hTemp_ffa0]
	ld b, a
	ld de, 10
	call DealDamageToPlayAreaPokemon_RegularAnim
	call SwapTurn
	bank1call HandleDestinyBondAndBetweenTurnKnockOuts
	ret

Flitter_AIEffect:
	ld a, 20
	call SetDefiniteDamageAndSetUnaffectedByWR
	ret

Flitter_PlayerSelectEffect:
	call HandlePlayerSelectOppPlayAreaPkmn
	ret

Flitter_AISelectEffect:
	call AIFindTargetForPlayAreaAttack
	ldh [hTemp_ffa0], a
	ret

Flitter_DamageArenaEffect:
	ldh a, [hTemp_ffa0]
	or a
	jr nz, .bench
	call PreparePlayAreaAttackAgainstArena
	ret c ; unaffected
	ld a, 20
	call SetDefiniteDamageAndSetUnaffectedByWR
	ret
.bench
	xor a ; ATK_ANIM_NONE
	ld [wLoadedAttackAnimation], a
	ret

Flitter_DamageBenchEffect:
	ldh a, [hTemp_ffa0]
	or a
	ret z ; Arena was chosen
	call SwapTurn
	ld b, a
	ld de, 20
	bank1call ApplyDarkWaveDamageBoost
	call DealDamageToPlayAreaPokemon_RegularAnim
	call SwapTurn
	ret

SleepPowderEffect:
	call SleepEffect
	ret

OddishPoisonPowder_AIEffect:
	ld a, 10
	lb de, 10, 10
	call UpdateExpectedAIDamage_AccountForPoison
	ret

OddishPoisonPowder_PoisonEffect:
	call PoisonEffect
	ret

PollenStench_CheckUse:
	call CheckIfCanUsePkmnPowerThisTurn
	ret

PollenStench_ConfusionEffect:
	call SetUsedPkmnPowerThisTurnFlag

	; toss coin: heads defending card is confused
	;            tails attacking card is confused
	ldtx de, ConfuseOppIfHeadsConfuseYourselfIfTailsText
	call TossCoin_Bank1a
	jr c, .got_heads

; got tails
	ld a, ATK_ANIM_POLLEN_STENCH_OWN_CONFUSION
	farcall PlayAttackAnimationOverAttackingPokemon
	call SwapTurn
	call ConfusionEffect
	call SwapTurn
	jr .animate

.got_heads
	ld a, ATK_ANIM_POLLEN_STENCH_CONFUSION
	farcall PlayAttackAnimationOverAttackingPokemon
	call ConfusionEffect

.animate
	farcall PlayStatusConditionQueueAnimations
	farcall WaitAttackAnimation

	; apply confusion status
	ld a, DUELVARS_ARENA_CARD_LAST_TURN_STATUS
	get_turn_duelist_var
	push af
	push hl
	bank1call ApplyStatusConditionQueue
	pop hl
	pop af
	ld [hl], a
	bank1call DrawDuelMainScene
	bank1call DrawDuelHUDs

	; print text if failed
	call PrintFailedEffectText
	call c, WaitForWideTextBoxInput
	ret

DarkGloomPoisonPowder_AIEffect:
	ld a, 10
	lb de, 10, 10
	call UpdateExpectedAIDamage_AccountForPoison
	ret

DarkGloomPoisonPowder_PoisonEffect:
	call PoisonEffect
	ret

HayFeverEffect:
	scf
	ret

PetalWhirlwindEffect_AIEffect:
	ld a, (30 * 3) / 2
	lb de, 0, 90
	call SetExpectedAIDamage
	ret

PetalWhirlwindEffect_MultiplierEffect:
	ld hl, 30
	call LoadTxRam3
	ld a, 3
	ldtx de, DamageCheckXDamageTimesHeadsText
	call TossCoinATimes_Bank1a
	ld e, a
	add a
	add e
	call ATimes10
	call SetDefiniteDamage

	; confuse attacking card if more than 2 heads
	ld a, e
	cp 2
	ret c
	call SwapTurn
	call ConfusionEffect
	call SwapTurn
	ret

GrimerPoisonGas_AIEffect:
	ld a, 10
	lb de, 10, 10
	call UpdateExpectedAIDamage_AccountForPoison
	ret

GrimerPoisonGas_PoisonEffect:
	call PoisonEffect
	ret

StickyHands_AIEffect:
	ld a, (10 + 30) / 2
	lb de, 10, 30
	call SetExpectedAIDamage
	ret

StickyHands_DamageBoostAndParalysisEffect:
	ldtx de, IfHeadsPlus20AndParalysisText
	call TossCoin_Bank1a
	ret nc ; got tails
	ld a, 20
	call AddToDamage
	call ParalysisEffect
	ret

StickyGooEffect:
	scf
	ret

SludgePunch_AIEffect:
	ld a, 30
	lb de, 30, 30
	call UpdateExpectedAIDamage_AccountForPoison
	ret

SludgePunch_PoisonEffect:
	call PoisonEffect
	ret

KoffingLv12PoisonGas_AIEffect:
	ld a, 10 / 2
	lb de, 0, 10
	call UpdateExpectedAIDamage_AccountForPoison
	ret

KoffingLv12PoisonGas_Poison50PercentEffect:
	call Poison50PercentEffect
	ret

MassExplosion_MultiplierEffect:
	ld e, 0
	call CountNumberOfKoffingOrWeezingInPlayArea
	call SwapTurn
	call CountNumberOfKoffingOrWeezingInPlayArea
	call SwapTurn
	ld a, e
	add a
	call ATimes10
	call SetDefiniteDamage
	ret

MassExplosion_DamageBenchEffect:
	call SwapTurn
	call HandleMassExplosionDamage
	call SwapTurn
	call SetIsDamageToSelf
	call HandleMassExplosionDamage
	call UnsetIsDamageToSelf
	ret

; adds to e the number of Koffing or (Dark) Weezing
; in turn holder's Play Area
CountNumberOfKoffingOrWeezingInPlayArea:
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	ld b, a
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
.loop_play_area
	ld a, [hli]
	cp $ff
	jr z, .next
	call LoadCardDataToBuffer1_FromDeckIndex
	ld a, [wLoadedCard1PokedexNumber]
	cp DEX_KOFFING
	jr z, .is_koffing_or_weezing
	cp DEX_WEEZING
	jr nz, .next
.is_koffing_or_weezing
	inc e
.next
	dec b
	jr nz, .loop_play_area
	ret

; handles damage done to Koffing and (Dark) Weezing due
; to Mass Explosion's effect
HandleMassExplosionDamage:
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	ld b, a
	ld c, PLAY_AREA_ARENA
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
.loop_play_area
	ld a, [hli]
	call LoadCardDataToBuffer1_FromDeckIndex
	ld a, [wLoadedCard1PokedexNumber]
	cp DEX_KOFFING
	jr z, .is_koffing_or_weezing
	cp DEX_WEEZING
	jr nz, .next
.is_koffing_or_weezing
	push hl
	push bc
	ld a, c
	bank1call LoadPlayAreaCardID_ToTempNonTurnDuelistCardID
	ld a, [wIsDamageToSelf]
	or a
	jr z, .damage_against_other_duelist
	call .CalculateDamageOrDamageSelf
	jr .asm_6b3bb
.damage_against_other_duelist
	call SwapTurn
	call .CalculateDamageOrDamageSelf
	call SwapTurn
.asm_6b3bb
	jr c, .skip_bench_hit
	ld a, ATK_ANIM_BENCH_HIT
	ld [wLoadedAttackAnimation], a
	call DealDamageToPlayAreaPokemon_GotPlayAreaLocation
.skip_bench_hit
	pop bc
	pop hl
.next
	inc c
	dec b
	jr nz, .loop_play_area
	ret

; if damage is done to attacker, then deal damage and return carry
; else, calculate damage against target and output it in de
; input:
; - c = PLAY_AREA_* location to damage
.CalculateDamageOrDamageSelf:
	ld de, 20
	ld a, c
	or a
	jr z, .arena
	ld b, PLAY_AREA_ARENA
	bank1call DamageCalculation
	or a
	ret

.arena
	ld a, [wIsDamageToSelf]
	jr nz, .self_damage
	ld a, c
	ld [wTempPlayAreaLocation_cceb], a
	xor a
	ld [wDamageEffectiveness], a
	ld b, PLAY_AREA_ARENA
	bank1call DamageCalculation_WeaknessAndResistance
	or a
	ret
.self_damage
	ld de, 20
	bank1call ApplyDarkWaveDamageBoost
	ld a, e
	call DealRecoilDamageToSelf
	scf
	ret

StunGasEffect:
	ldtx de, PoisonedIfHeadsParalyzedIfTailsText
	call TossCoin_Bank1a
	jr c, .poison
; paralyzes
	call ParalysisEffect
	ret
.poison
	call PoisonEffect
	ret

AbraVanish_CheckBench:
	call CheckIfTurnDuelistHasBench
	ret

AbraVanish_PlayerSelectEffect:
	ldtx hl, SelectPokemonToPlaceInTheArenaText
	call DrawWideTextBox_WaitForInput
	bank1call HasAlivePokemonInBench
.select_bench
	bank1call OpenPlayAreaScreenForSelection
	jr c, .select_bench ; mandatory selection
	ldh [hTemp_ffa0], a
	ret

AbraVanish_ReturnToDeckEffect:
	; discard all cards in the arena
	ld a, DUELVARS_CARD_LOCATIONS
	get_turn_duelist_var
.loop_cards
	ld a, [hl]
	cp CARD_LOCATION_ARENA
	jr nz, .next_card
	ld a, l
	call DiscardCard
.next_card
	inc l
	ld a, l
	cp DECK_SIZE
	jr c, .loop_cards

	; return attacking card to deck from the Discard Pile
	ld l, DUELVARS_ARENA_CARD
	ld a, [hl]
	call MoveDiscardPileCardToHand
	call ReturnCardToDeck

	; empty out arena card and zero HP
	ld [hl], $ff
	ld l, DUELVARS_ARENA_CARD_HP
	ld [hl], 0

	; switch in selected card to replace
	ldh a, [hTemp_ffa0]
	ld e, a
	call SwapArenaWithBenchPokemon
	call ShiftAllPokemonToFirstPlayAreaSlots
	call ShuffleCardsInDeck
	ret

AbraLv14PsyshockEffect:
	call Paralysis50PercentEffect
	ret

MatterExchange_CheckUseDeckAndHandCards:
	call CheckIfCanUsePkmnPowerThisTurn
	ret c
	farcall CheckIfDeckIsEmpty
	ret c ; return if no cards in deck
	ld a, DUELVARS_NUMBER_OF_CARDS_IN_HAND
	get_turn_duelist_var
	ldtx hl, NotEnoughCardsInHandText
	cp 1 ; return carry if no cards in hand
	ret

MatterExchange_PlayerSelectEffect:
	call CreateHandCardList
	bank1call InitAndDrawCardListScreenLayout_WithSelectCheckMenu
	bank1call DisplayCardList
	ret c ; operation cancelled
	ldh [hTempPlayAreaLocation_ffa1], a
	ret

MatterExchange_DiscardAndDrawEffect:
	call SetUsedPkmnPowerThisTurnFlag
	ldh a, [hTemp_ffa0]
	ldh [hTempPlayAreaLocation_ff9d], a
	or a
	jr z, .no_animation
	ld a, ATK_ANIM_PKMN_POWER_1
	ld [wLoadedAttackAnimation], a
.no_animation
	ld a, [wLoadedAttackAnimation]
	farcall PlayAttackAnimationOverAttackingPokemon

	; discard chosen card
	ldh a, [hTempPlayAreaLocation_ffa1]
	call RemoveCardFromHand
	call PutCardInDiscardPile

	; draw one card from deck
	ld a, 1
	farcall DisplayDrawNCardsScreen
	call DrawCardFromDeck
	ldh [hTempCardIndex_ff98], a
	call AddCardToHand
	call IsPlayerTurn
	ret nc
	bank1call DisplayPlayerDrawCardScreen
	ret

DarkKadabraMindShockEffect:
	ld hl, wDamage + 1
	set UNAFFECTED_BY_WEAKNESS_RESISTANCE_F, [hl]
	ret

TeleportBlast_PlayerSelectEffect:
	ld a, $ff
	ldh [hTemp_ffa0], a
	call CheckIfTurnDuelistHasBench
	ret c ; no bench

	; prompt player if they want to switch out
	ldtx hl, SwitchOutDarkAlakazamPromptText
	call YesOrNoMenuWithText
	ret c ; no selected

	; have player select Pokémon to switch in
	bank1call HasAlivePokemonInBench
.select_switch_in
	bank1call OpenPlayAreaScreenForSelection
	jr c, .select_switch_in
	ldh [hTemp_ffa0], a
	ret

TeleportBlast_AISelectEffect:
	; AI always selects "no"
	ld a, $ff
	ldh [hTemp_ffa0], a
	ret

TeleportBlast_BeforeDamageEffect:
	ldh a, [hTemp_ffa0]
	cp $ff
	ret nz ; has switching
	ld a, ATK_ANIM_PSYCHIC_HIT
	ld [wLoadedAttackAnimation], a
	ret

TeleportBlast_SwitchEffect:
	ldh a, [hTemp_ffa0]
	cp $ff
	ret z ; no switching

	; if KO'd defending card and it has Destiny Bond, don't switch
	ld a, DUELVARS_ARENA_CARD_HP
	call GetNonTurnDuelistVariable
	or a
	jr nz, .no_destiny_bond
	ld a, DUELVARS_ARENA_CARD_SUBSTATUS1
	call GetNonTurnDuelistVariable
	cp SUBSTATUS1_DESTINY_BOND
	ret z

.no_destiny_bond
	; if dealt no damage, skip switching
	ld hl, wDealtDamage
	ld a, [hli]
	or [hl]
	ret z ; no damage

	; actually do switching
	ldh a, [hTemp_ffa0]
	ld [wcd0a], a
	ld e, a
	call SwapArenaWithBenchPokemon
	xor a
	ld [wDuelDisplayedScreen], a
	ret

DarkAlakazamMindShockEffect:
	ld hl, wDamage + 1
	set UNAFFECTED_BY_WEAKNESS_RESISTANCE_F, [hl]
	ret

AfternoonNap_CheckDeck:
	farcall CheckIfDeckIsEmpty
	ret

AfternoonNap_PlayerSelectEffect:
	call CreateDeckCardList
	ldtx hl, ChooseAPsychicEnergyCardFromDeckText
	ldtx bc, EffectTargetPsychicEnergyText
	ld a, CARDSEARCH_PSYCHIC_ENERGY
	farcall LookForCardsInDeck
	jr c, .got_selection
	ldtx hl, ChooseAPsychicEnergyCardText
	ldtx de, DuelistDeckText
	farcall SelectCardSearchTarget
.got_selection
	ldh [hTemp_ffa0], a
	ret

AfternoonNap_AISelectEffect:
	ld a, CARDSEARCH_PSYCHIC_ENERGY
	farcall SetCardSearchFuncParams
	call CreateDeckCardList
	ld hl, wDuelTempList
.loop
	ld a, [hli]
	ldh [hTemp_ffa0], a
	cp $ff
	ret z
	farcall ExecuteCardSearchFunc
	jr nc, .loop
	ret

AfternoonNap_AttachEnergyEffect:
	ldh a, [hTemp_ffa0]
	cp $ff
	jr z, .no_selection
	; got card to attach
	call SearchCardInDeckAndAddToHand
	get_turn_duelist_var
	ld [hl], CARD_LOCATION_ARENA
.no_selection
	call ShuffleCardsInDeck
	ret

ReelIn_InitialEffect:
	scf
	ret

ReelIn_PlayerSelectEffect:
	call CreatePokemonCardListFromDiscardPile
	jr nc, .got_cards_to_select
	; no cards, output empty list
	call DrawWideTextBox_WaitForInput
	ld a, $ff
	ldh [hTempList], a
	ret

.got_cards_to_select
	xor a
	ldh [hCurSelectionItem], a
	ldtx hl, ChooseUpTo3PokemonCardsFromDiscardPileText
	call DrawWideTextBox_WaitForInput
.loop_selection
	bank1call InitAndDrawCardListScreenLayout_WithSelectCheckMenu
	ldtx hl, ChooseCardToPlaceInHandText
	ldtx de, DuelistDiscardPileText
	bank1call SetCardListHeaderAndInfoText
	bank1call DisplayCardList
	jr nc, .selected_card

	; trying to exit with more cards to select,
	; ask player if they still want to quit
	ld a, 3
	call AskWhetherToQuitSelectingCards
	jr c, .loop_selection
	jr .got_selection

.selected_card
	ldh a, [hTempCardIndex_ff98]
	get_turn_duelist_var
	farcall GetNextPositionInTempList
	ldh a, [hTempCardIndex_ff98]
	ld [hl], a
	call RemoveCardFromDuelTempList
	jr c, .got_selection
	ldh a, [hCurSelectionItem]
	cp 3
	jr c, .loop_selection
.got_selection
	farcall GetNextPositionInTempList
	ld [hl], $ff
	or a
	ret

ReelIn_AddToHandEffect:
	ld hl, hTempList
	ld de, wDuelTempList
	ld a, [hl]
	cp $ff
	jr nz, .loop_add_cards
	ret
	
.loop_add_cards
	; copy from hTempList to wDuelTempList
	ld a, [hli]
	ld [de], a
	inc de
	cp $ff
	jr z, .add_done
	; add card to hand
	call MoveDiscardPileCardToHand
	call AddCardToHand
	jr .loop_add_cards
.add_done
	call IsPlayerTurn
	jr c, .done
	bank1call DisplayCardListDetails
.done
	ret

FickleAttack_AIEffect:
	ld a, 40
	lb de, 0, 40
	call SetExpectedAIDamage
	ret

FickleAttack_NoDamage50PercentEffect:
	ldtx de, AttackSuccessCheckText
	call TossCoin_Bank1a
	ret c ; got heads
	xor a
	ld [wLoadedAttackAnimation], a
	call SetDefiniteDamage
	call SetWasUnsuccessful
	ret

LongDistanceHypnosis_CheckUse:
	call CheckIfCanUsePkmnPowerThisTurn
	ret

LongDistanceHypnosis_SleepEffect:
	call SetUsedPkmnPowerThisTurnFlag

	; toss coin: if heads, defending card is put to sleep
	;            it tails, own arena card is put to sleep
	ldtx de, LongDistanceHypnosisCheckText
	call TossCoin_Bank1a
	jr c, .heads

; tails
	ld a, ATK_ANIM_LONG_DISTANCE_HYPNOSIS_FAILED
	farcall PlayAttackAnimationOverAttackingPokemon
	call SwapTurn
	call SleepEffect
	call SwapTurn
	jr .play_animation

.heads
	ld a, ATK_ANIM_LONG_DISTANCE_HYPNOSIS_SUCCESS
	farcall PlayAttackAnimationOverAttackingPokemon
	call SleepEffect

.play_animation
	farcall PlayStatusConditionQueueAnimations
	farcall WaitAttackAnimation

	ld a, DUELVARS_ARENA_CARD_LAST_TURN_STATUS
	get_turn_duelist_var
	push af
	push hl
	bank1call ApplyStatusConditionQueue
	pop hl
	pop af
	ld [hl], a
	bank1call DrawDuelMainScene
	bank1call DrawDuelHUDs

	; print text if failed
	call PrintFailedEffectText
	call c, WaitForWideTextBoxInput
	ret

DrowzeeNightmareEffect:
	call SleepEffect
	ret

BenchManipulation_AIEffect:
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	call GetNonTurnDuelistVariable
	add a
	call ATimes10
	; sets max damage as (num bench cards) * 20
	ld [wAIMaxDamage], a
	; sets expected damage as half that
	srl a ; /2
	ld [wDamage], a
	; sets min damage as 0
	xor a
	ld [wAIMinDamage], a
	ret

BenchManipulation_CheckBench:
	call CheckNonTurnDuelistHasBench
	ret

BenchManipulation_MultiplierEffect:
	; don't do damage if Aurora Veil is active
	; on other duelist's side
	call SwapTurn
	ld a, PLAY_AREA_BENCH_1
	ld [wTempPlayAreaLocation_cceb], a
	bank1call CheckArticunoAuroraVeil
	call SwapTurn
	jr nc, .no_aurora_veil
	ret
.no_aurora_veil
	ld hl, 20
	call LoadTxRam3
	call SwapTurn
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	push hl
	dec a ; toss (num play area pkmn) - 1 coins
	ldtx de, DamageCheckXDamageTimesTailsText
	call TossCoinATimes_Bank1a
	pop hl
	call SwapTurn
	ld e, a ; num of heads
	ld a, [hl]
	dec a
	sub e
	; a = num of tails
	add a
	call ATimes10
	call SetDefiniteDamageAndSetUnaffectedByWR
	ret

DigUnder_AIEffect:
	ld a, 10
	call SetDefiniteDamageAndSetUnaffectedByWR
	ret

DigUnder_PlayerSelectEffect:
	call HandlePlayerSelectOppPlayAreaPkmn
	ret

DigUnder_AISelectEffect:
	call AIFindTargetForPlayAreaAttack
	ldh [hTemp_ffa0], a
	ret

DigUnder_ArenaDamageEffect:
	ldh a, [hTemp_ffa0]
	or a
	jr nz, .bench
	call PreparePlayAreaAttackAgainstArena
	ret c ; unaffected
	ld a, 10
	call SetDefiniteDamageAndSetUnaffectedByWR
	ret
.bench
	xor a
	ld [wLoadedAttackAnimation], a
	ret

DigUnder_BenchDamageEffect:
	ldh a, [hTemp_ffa0]
	or a
	ret z ; arena
	call SwapTurn
	ld b, a
	ld de, 10
	call DealDamageToPlayAreaPokemon_RegularAnim
	call SwapTurn
	ret

SinkholeEffect:
	scf
	ret

KnockDown_AIEffect:
	ld a, (20 + 40) / 2
	lb de, 20, 40
	call SetExpectedAIDamage
	ret

KnockDown_DamageBoostEffect:
	ld hl, 20
	call LoadTxRam3
	call SwapTurn
	ldtx de, DamageCheckIfTailsPlusDamageText
	call TossCoin_Bank1a
	call SwapTurn
	jr c, .heads
	ld a, 20
	call AddToDamage
.heads
	ret

Mischief_CheckDeck:
	call SwapTurn
	farcall CheckIfDeckIsEmpty
	call SwapTurn
	ret

Mischief_ShuffleDeckEffect:
	call SwapTurn
	call ShuffleCardsInDeck
	call SwapTurn
	ret

MankeyQuickAttack_AIEffect:
	ld a, (20 + 40) / 2
	lb de, 20, 40
	call SetExpectedAIDamage
	ret

MankeyQuickAttack_DamageBoostEffect:
	ld a, 20
	call AddDamageIfHeads
	ret

FrenzyEffect:
	scf
	ret

CalculateFrenziedAttackDamage:
	ld hl, wTempTurnDuelistCardID
	cphl DARK_PRIMEAPE
	jr nz, .no_damage_boost
	ld a, DUELVARS_ARENA_CARD_STATUS
	get_turn_duelist_var
	and CNF_SLP_PRZ
	cp CONFUSED
	jr nz, .no_damage_boost
	ld a, 30
	call AddToDamage
.no_damage_boost
	ret

FrenziedAttackEffect:
	call CalculateFrenziedAttackDamage
	call SwapTurn
	call ConfusionEffect
	call SwapTurn
	ret

DragOff_CheckBench:
	call CheckNonTurnDuelistHasBench
	ret

DragOff_PlayerSelectEffect:
	call SwapTurn
	bank1call HasAlivePokemonInBench
.select_bench
	bank1call OpenPlayAreaScreenForSelection
	jr c, .select_bench ; mandatory selection
	call SwapTurn
	ldh [hTemp_ffa0], a
	ret

DragOff_AISelectEffect:
	call AIFindTargetForBenchAttack
	ldh [hTemp_ffa0], a
	ret

DragOff_SwitchEffect:
	call SwapTurn
	ldh a, [hTemp_ffa0]
	ld e, a
	bank1call HandlePlayAreaCardNoDamageOrEffect
	jr nc, .switch
	xor a
	ld [wLoadedAttackAnimation], a
	call SetDefiniteDamage
	jr .done
.switch
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
	res RESIDUAL_F, [hl]
.done
	call SwapTurn
	xor a
	ld [wDuelDisplayedScreen], a
	ret

KnockBack_CheckBench:
	call HandleMandatorySwitchSelection
	ldh a, [hTempPlayAreaLocation_ff9d]
	ldh [hTemp_ffa0], a
	ret

KnockBack_SwitchEffect:
	ldh a, [hTemp_ffa0]
	call HandleSwitchDefendingPokemonEffect
	ret

DarkMachampFling_CheckBench:
	call CheckNonTurnDuelistHasBench
	ret

DarkMachampFling_ShuffleToDeckEffect:
	call HandleNoDamageOrEffect
	ret c ; no damage or effect

	call SwapTurn
	ld e, PLAY_AREA_ARENA
	bank1call HandlePlayAreaCardNoDamageOrEffect
	call SwapTurn
	ret c ; not affected

	; loop through all cards and return to deck
	; all cards that are in the Arena
	call SwapTurn
	ld a, DUELVARS_CARD_LOCATIONS
	get_turn_duelist_var
.loop_cards
	ld a, [hl]
	cp CARD_LOCATION_ARENA
	jr nz, .next_card
	ld a, l
	call ReturnCardToDeck
.next_card
	inc l
	ld a, l
	cp DECK_SIZE
	jr c, .loop_cards

	; empty out Arena card and zero HP
	ld l, DUELVARS_ARENA_CARD
	ld a, [hl]
	ld [hl], $ff
	ld l, DUELVARS_ARENA_CARD_HP
	ld [hl], 0

	call LoadCardDataToBuffer1_FromDeckIndex
	ld hl, wLoadedCard1Name
	ld a, [hli]
	ld h, [hl]
	ld l, a
	call LoadTxRam2
	ldtx hl, PokemonAndAllAttachedCardsWereReturnedToDeckText
	call DrawWideTextBox_WaitForInput
	call ShuffleCardsInDeck
	call SwapTurn
	ret

Trickery_CheckUseAndDeck:
	call CheckIfCanUsePkmnPowerThisTurn
	ret c
	farcall CheckIfDeckIsEmpty
	ret

Trickery_SwitchPrizeEffect:
	call SetUsedPkmnPowerThisTurnFlag

	ld a, DUELVARS_DUELIST_TYPE
	get_turn_duelist_var
	cp DUELIST_TYPE_LINK_OPP
	jr z, .link_opp
	and DUELIST_TYPE_AI_OPP
	jr nz, .ai_opp
	call FinishQueuedAnimations
	farcall HandlePrizeCardPlayerSelection
	ldh [hTempPlayAreaLocation_ffa1], a
	call SerialSend8Bytes
	jr .switch_cards
	ret

.link_opp
	call SerialRecv8Bytes
	ldh [hTempPlayAreaLocation_ffa1], a
.ai_opp
	call FinishQueuedAnimations
	call SwapTurn
	ldh a, [hTempPlayAreaLocation_ffa1]
	xor $80
	call DrawAIPeekScreen
	call SwapTurn
	ldtx hl, CardTrickeryWasUsedOnText
	call DrawWideTextBox_WaitForInput
.switch_cards
	ldh a, [hTempPlayAreaLocation_ffa1]
	and $0f
	add DUELVARS_PRIZE_CARDS
	get_turn_duelist_var
	ldh [hTempCardIndex_ff98], a
	call DrawCardFromDeck
	ld [hl], a
	ld l, a
	ld [hl], CARD_LOCATION_PRIZE
	ldh a, [hTempCardIndex_ff98]
	call ReturnCardToDeck
	ret

RattataQuickAttack_AIEffect:
	ld a, (10 + 20) / 2
	lb de, 10, 20
	call SetExpectedAIDamage
	ret

RattataQuickAttack_DamageBoostEffect:
	ld a, 10
	call AddDamageIfHeads
	ret

HyperFang_AIEffect:
	ld a, 50
	lb de, 0, 50
	call SetExpectedAIDamage
	ret

HyperFang_NoDamage50PercentEffect:
	ldtx de, AttackSuccessCheckText
	call TossCoin_Bank1a
	ret c ; heads
	xor a
	ld [wLoadedAttackAnimation], a
	call SetDefiniteDamage
	call SetWasUnsuccessful
	ret

CoinHurl_InitialEffect:
	call Func_6808d
	ret

CoinHurl_AIEffect:
	ld a, 20
	call SetDefiniteDamage
	ret

CoinHurl_PlayerSelectEffect:
	ldtx de, DamageCheckIfTailsNoDamageText
	call Serial_TossCoin
	ldh [hTemp_ffa0], a
	ret nc ; tails
	call SwapTurn
	bank1call HasAlivePokemonInPlayArea
.loop
	bank1call OpenPlayAreaScreenForSelection
	jr c, .loop ; mandatory selection
	call SwapTurn
	ldh [hTempPlayAreaLocation_ffa1], a
	ret

CoinHurl_AISelectEffect:
	ldtx de, DamageCheckIfTailsNoDamageText
	call Serial_TossCoin
	ldh [hTemp_ffa0], a
	ret nc ; tails
	call AIFindTargetForPlayAreaAttack
	ldh [hTempPlayAreaLocation_ffa1], a
	ret

CoinHurl_DamageArenaEffect:
	ldh a, [hTemp_ffa0]
	or a
	jr nz, .successful
; unsuccessful
	xor a
	ld [wLoadedAttackAnimation], a
	call SetWasUnsuccessful
	ret
.successful
	ldh a, [hTempPlayAreaLocation_ffa1]
	or a
	jr nz, .bench
	call PreparePlayAreaAttackAgainstArena
	ret c ; unaffected
	ld a, 20
	call SetDefiniteDamageAndSetUnaffectedByWR
	ret
.bench
	xor a
	ld [wLoadedAttackAnimation], a
	ret

CoinHurl_DamageBenchEffect:
	ldh a, [hTemp_ffa0]
	or a
	ret z ; unsuccessful
	ldh a, [hTempPlayAreaLocation_ffa1]
	or a
	ret z ; arena
	call SwapTurn
	ld b, a
	ld a, ATK_ANIM_COIN_HURL_BENCH
	ld [wLoadedAttackAnimation], a
	ld de, 20
	call DealDamageToPlayAreaPokemon
	call SwapTurn
	ret

DarkPersianFascinate_InitialEffect:
	jr FascinateInitialEffect

DarkPersianFascinate_PlayerSelectEffect:
	jr FascinatePlayerSelectEffect

DarkPersianFascinate_AISelectEffect:
	jr FascinateAISelectEffect

DarkPersianFascinate_LoadAnimation:
	jr FascinateLoadAnimation

DarkPersianFascinate_SwitchEffect:
	jr FascinateSwitchEffect

FascinateInitialEffect:
	call Func_6808d
	call CheckNonTurnDuelistHasBench
	ret

FascinateAISelectEffect:
	ldtx de, AttackSuccessCheckText
	call Serial_TossCoin
	ldh [hTemp_ffa0], a
	ret nc ; tails
	call AIFindTargetForBenchAttack
	ldh [hTempPlayAreaLocation_ffa1], a
	ret

FascinatePlayerSelectEffect:
	ldtx de, AttackSuccessCheckText
	call Serial_TossCoin
	ldh [hTemp_ffa0], a
	ret nc ; tails
	call SwapTurn
	bank1call HasAlivePokemonInBench
.loop
	bank1call OpenPlayAreaScreenForSelection
	jr c, .loop ; mandatory selection
	call SwapTurn
	ldh [hTempPlayAreaLocation_ffa1], a
	ret

FascinateLoadAnimation:
	ldh a, [hTemp_ffa0]
	or a
	ret nz
	; a = ATK_ANIM_NONE
	ld [wLoadedAttackAnimation], a
	call SetWasUnsuccessful
	ret

FascinateSwitchEffect:
	ldh a, [hTemp_ffa0]
	or a
	ret z ; not successful
	call SwapTurn
	ldh a, [hTempPlayAreaLocation_ffa1]
	ld e, a
	bank1call HandlePlayAreaCardNoDamageOrEffect
	jr c, .not_affected
	ldh a, [hTempPlayAreaLocation_ffa1]
	ld e, a
	call SwapArenaWithBenchPokemon
.not_affected
	call SwapTurn
	xor a
	ld [wDuelDisplayedScreen], a
	ret

PersianPoisonClaws_AIEffect:
	ld a, 10 / 2
	lb de, 0, 10
	call UpdateExpectedAIDamage_AccountForPoison
	ret

PersianPoisonClaws_Poison50PercentEffect:
	call Poison50PercentEffect
	ret

EeveeSandAttackEffect:
	ld a, SUBSTATUS2_SAND_ATTACK
	call ApplySubstatus2ToDefendingCard
	ret

PorygonLv20Conversion1_WeaknessCheck:
	call CheckIfDefendingCardHasWeakness
	ret

PorygonLv20Conversion1_PlayerSelectEffect:
	call HandleConversion1PlayerSelection
	ret

PorygonLv20Conversion1_AISelectEffect:
	call AISelectConversionColor
	ret

PorygonLv20Conversion1_ChangeWeaknessEffect:
	call ChangeDefendingCardsWeakness
	ret

PorygonPsybeamEffect:
	call Confusion50PercentEffect
	ret

DratiniWrapEffect:
	call Paralysis50PercentEffect
	ret

EvolutionaryLight_CheckUseAndDeck:
	call CheckIfCanUsePkmnPowerThisTurn
	ret c
	farcall CheckIfDeckIsEmpty
	ret

EvolutionaryLight_PlayerSelectEffect:
	call CreateDeckCardList
	ldtx hl, ChooseAnEvolutionCardFromDeckText
	ldtx bc, EffectTargetEvolutionCardText
	ld a, CARDSEARCH_EVOLUTION_POKEMON
	farcall LookForCardsInDeck
	jr c, .got_selection
	ldtx hl, ChooseAnEvolutionCardText
	ldtx de, DuelistDeckText
	farcall SelectCardSearchTarget
.got_selection
	ldh [hTempPlayAreaLocation_ffa1], a
	or a
	ret

EvolutionaryLight_AddToHandEffect:
	call SetUsedPkmnPowerThisTurnFlag

	; was a valid selection made?
	ldh a, [hTempPlayAreaLocation_ffa1]
	cp $ff
	jr z, .done

	; if so, then add it to the hand
	call SearchCardInDeckAndAddToHand
	call AddCardToHand
	call IsPlayerTurn
	jr c, .done

	; show it to the player
	ldh a, [hTempPlayAreaLocation_ffa1]
	ldtx hl, WasPlacedInTheHandText
	bank1call DisplayCardDetailScreen

.done
	call ShuffleCardsInDeck
	ret

TailStrike_AIEffect:
	ld a, (20 + 40) / 2
	lb de, 20, 40
	call SetExpectedAIDamage
	ret

TailStrike_DamageBoostEffect:
	ld a, 20
	call AddDamageIfHeads
	ret

SummonMinions_InitialEffect:
	scf
	ret

SummonMinions_PlayerSelectEffect:
	ld a, $ff
	ldh [hTemp_ffa0], a
	call CreateDeckCardList
	jr c, .no_cards_in_deck

	farcall CheckIfHasSpaceInBench
	jr nc, .has_space_in_bench

	call DrawWideTextBox_WaitForInput
	ldtx hl, NoTargetsButCheckDeckPromptText
	call YesOrNoMenuWithText_SetCursorToYes
	ret c ; "no" selected
	ld a, $ff
	ld [$cd20], a
	ldtx hl, ChooseBasicPokemonText
	ldtx de, DuelistDeckText
	farcall SelectCardSearchTarget
	ret

.no_cards_in_deck
	ldtx hl, NoCardsLeftInTheDeckText
	call DrawWideTextBox_WaitForInput
	ret

.has_space_in_bench
	ldtx hl, ChooseUpTo2BasicPokemonFromDeckText
	ldtx bc, EffectTargetBasicPokemonText
	ld a, CARDSEARCH_BASIC_POKEMON
	farcall LookForCardsInDeck
	ret c ; no basic pkmn

	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	ld a, [wMaxNumPlayAreaPokemon]
	sub [hl]
	cp 3
	jr c, .got_num_cards_to_pick
	ld a, 2
.got_num_cards_to_pick
	ld [wNumberOfCardsToOrder], a

	xor a
	ldh [hCurSelectionItem], a
.draw_list
	bank1call InitAndDrawCardListScreenLayout_WithSelectCheckMenu
	ldtx hl, ChooseBasicPokemonText
	ldtx de, DuelistDeckText
	bank1call SetCardListHeaderAndInfoText
.loop_input
	bank1call DisplayCardList
	jr nc, .check_is_basic
	ld a, [$cd20]
	or a
	jr nz, .finish

	; trying to exit
	ld a, [wNumberOfCardsToOrder]
	call AskWhetherToQuitSelectingCards
	jr c, .draw_list
	jr .finish

.check_is_basic
	ldh a, [hTempCardIndex_ff98]
	farcall ExecuteCardSearchFunc
	jr nc, .loop_input ; not basic
	; add it to hTempList
	farcall GetNextPositionInTempList
	ldh a, [hTempCardIndex_ff98]
	ld [hl], a
	call RemoveCardFromDuelTempList
	jr c, .finish
	ldh a, [hCurSelectionItem]
	ld hl, wNumberOfCardsToOrder
	cp [hl]
	jr c, .draw_list
.finish
	farcall GetNextPositionInTempList
	ld [hl], $ff ; terminating byte
	ret

SummonMinions_AddToHandEffect:
	ld hl, hTempList
.loop_add_to_hand
	ld a, [hli]
	ldh [hTempCardIndex_ff98], a
	cp $ff
	jr z, .finish
	push hl
	call SearchCardInDeckAndAddToHand
	call AddCardToHand
	call PutHandPokemonCardInPlayArea
	call IsPlayerTurn
	pop hl
	jr c, .loop_add_to_hand
	push hl
	ldh a, [hTempCardIndex_ff98]
	ldtx hl, PlacedInArenaText
	bank1call DisplayCardDetailScreen
	pop hl
	jr .loop_add_to_hand
.finish
	call ShuffleCardsInDeck
	ret

GiantTail_AIEffect:
	ld a, 70
	lb de, 0, 70
	call SetExpectedAIDamage
	ret

GiantTail_NoDamage50PercentEffect:
	ldtx de, AttackSuccessCheckText
	call TossCoin_Bank1a
	ret c ; heads
	xor a
	ld [wLoadedAttackAnimation], a
	call SetDefiniteDamage
	call SetWasUnsuccessful
	ret

MagnetismEffect:
	ld b, 0
	ld a, DUELVARS_BENCH
	get_turn_duelist_var
.loop_bench
	ld a, [hli]
	cp $ff
	jr z, .calculate_damage
	call LoadCardDataToBuffer2_FromDeckIndex
	ld a, [wLoadedCard2PokedexNumber]
	cp DEX_MAGNEMITE
	jr z, .is_magnemite_or_magneton
	cp DEX_MAGNETON
	jr nz, .loop_bench
.is_magnemite_or_magneton
	inc b
	jr .loop_bench
.calculate_damage
	ld a, b ; num Magnemite/Magneton in bench
	call ATimes10
	call AddToDamage
	ret

DarkMagnetonSonicboomEffect:
	ld hl, wDamage + 1
	set UNAFFECTED_BY_WEAKNESS_RESISTANCE_F, [hl]
	ret

MagneticLines_AISelectEffect:
	ld a, $ff
	ldh [hTemp_ffa0], a
	call CheckNonTurnDuelistHasBench
	ret c ; no bench
	call CreateBasicEnergyListAttachedToDefendingCard
	ret c ; no basic energy cards
	; just choose the first energy card
	; and give it to weakest bench Pokémon
	ld a, [wDuelTempList]
	ldh [hTemp_ffa0], a
	call AIFindTargetForBenchAttack
	ldh [hTempPlayAreaLocation_ffa1], a
	ret

MagneticLines_PlayerSelectEffect:
	ld a, $ff
	ldh [hTemp_ffa0], a
	call CheckNonTurnDuelistHasBench
	ret c ; no bench
	call CreateBasicEnergyListAttachedToDefendingCard
	ret c ; no basic energy cards

	; select an energy card
	call SwapTurn
	xor a ; PLAY_AREA_ARENA
	ldtx de, ChooseEnergyCardToRemoveText
	bank1call DisplayAttachedEnergyMenu
.select_energy
	bank1call HandleAttachedEnergyMenuInput
	jr c, .select_energy
	ldh a, [hTempCardIndex_ff98]
	ldh [hTemp_ffa0], a

	; select a Bench Pokémon to give it to
	bank1call HasAlivePokemonInBench
.select_bench_pkmn
	bank1call OpenPlayAreaScreenForSelection
	jr c, .select_bench_pkmn
	ldh [hTempPlayAreaLocation_ffa1], a
	call SwapTurn
	ret

MagneticLines_TransferEnergyEffect:
	ldh a, [hTemp_ffa0]
	cp $ff
	ret z ; no card to transfer
	call HandleNoDamageOrEffect
	ret c ; no effect
	call SwapTurn
	ldh a, [hTempPlayAreaLocation_ffa1]
	ld e, a
	bank1call HandlePlayAreaCardNoDamageOrEffect
	jr c, .done

	; add to hand then attach it to Bench card
	ldh a, [hTemp_ffa0]
	call AddCardToHand
	call PutHandCardInPlayArea
	call IsPlayerTurn
	jr c, .done

	; show it to the player
	ldh a, [hTempPlayAreaLocation_ffa1]
	call DrawPlayAreaScreenToShowChanges

.done
	call SwapTurn
	; interestingly we consider this as discarding energy
	; for purposes of Mirror Move
	ld a, DUELVARS_ARENA_CARD_LAST_TURN_EFFECT
	call GetNonTurnDuelistVariable
	ld [hl], LAST_TURN_EFFECT_DISCARD_ENERGY
	ret

; creates list of all Basic Energy cards attached
; to defending card, and returns carry if no cards are found
CreateBasicEnergyListAttachedToDefendingCard:
	call SwapTurn
	ld c, CARD_LOCATION_ARENA
	ld de, wDuelTempList
	ld a, DUELVARS_CARD_LOCATIONS
	get_turn_duelist_var
.loop_cards
	ld a, [hl]
	cp c
	jr nz, .next_card
	ld a, l
	call LoadCardDataToBuffer2_FromDeckIndex
	ld a, [wLoadedCard2Type]
	cp TYPE_ENERGY
	jr c, .next_card
	cp TYPE_ENERGY_DOUBLE_COLORLESS
	jr nc, .next_card
	ld a, l
	ld [de], a ; add card index
	inc de
.next_card
	inc l
	ld a, l
	cp DECK_SIZE
	jr c, .loop_cards
	ld a, $ff
	ld [de], a
	call SwapTurn
	ld a, [wDuelTempList]
	cp $ff
	jr z, .set_carry
	or a
	ret
.set_carry
	scf
	ret

EnergyBomb_CheckEnergy:
	ld e, PLAY_AREA_ARENA
	call GetPlayAreaCardAttachedEnergies
	ld a, [wTotalAttachedEnergies]
	or a
	ret nz
	; doesn't have any energies
	ldtx hl, NoEnergyCardsText
	scf
	ret

EnergyBomb_PlayerSelectEffect:
	call CheckIfTurnDuelistHasBench
	jr c, .no_bench
	ld a, DUELVARS_DUELIST_TYPE
	get_turn_duelist_var
	cp DUELIST_TYPE_PLAYER
	jr z, .player_selection
	cp DUELIST_TYPE_LINK_OPP
	jr z, .link_opp
	ret

.link_opp
	bank1call SetupPlayAreaScreen
	bank1call PrintPlayAreaCardList_EnableLCD
	call SerialRecv8Bytes
	ld a, d
	cp $ff
	ret z ; done
	ldh [hTemp_ffa0], a
	ld a, e
	ldh [hTempPlayAreaLocation_ffa1], a
	call TransferEnergyToPlayAreaPkmn
	jr .link_opp

.player_selection
	xor a ; PLAY_AREA_ARENA
	call CreateArenaOrBenchEnergyCardList
	jr c, .no_energies
	bank1call InitAndDrawCardListScreenLayout
	ldtx hl, PleaseSelectCardText
	ldtx de, EnergyCardText
	bank1call SetCardListHeaderAndInfoText
.select_energy
	bank1call DisplayCardList
	jr c, .select_energy
	ldh [hTemp_ffa0], a
	bank1call HasAlivePokemonInBench
.select_bench_pkmn
	bank1call OpenPlayAreaScreenForSelection
	jr c, .select_bench_pkmn
	ldh [hTempPlayAreaLocation_ffa1], a
	ld e, a
	ldh a, [hTemp_ffa0]
	ld d, a
	call SerialSend8Bytes
	call AddCardToHand
	call PutHandCardInPlayArea
	jr .player_selection

.no_energies
	; finish selection
	lb de, $ff, $ff
	call SerialSend8Bytes
	ret

.no_bench
	; discard all energies attached to Arena card
	xor a ; PLAY_AREA_ARENA
	call CreateArenaOrBenchEnergyCardList
	ld hl, wDuelTempList
.loop_discard
	ld a, [hli]
	cp $ff
	jr z, .done_discard
	call DiscardCard
	jr .loop_discard
.done_discard
	xor a
	call DrawPlayAreaScreenToShowChanges
	ret

TransferEnergyToPlayAreaPkmn:
	ldh a, [hTempPlayAreaLocation_ffa1]
	ld e, a
	ldh a, [hTemp_ffa0]
	call AddCardToHand
	call PutHandCardInPlayArea
	bank1call PrintPlayAreaCardList_EnableLCD
	ret

LightningFlashEffect:
	ld a, SUBSTATUS2_LIGHTNING_FLASH
	call ApplySubstatus2ToDefendingCard
	ret

ThunderAttack_Paralysis50PercentEffect:
	ldtx de, ThunderAttackCheckText
	call TossCoin_Bank1a
	ldh [hTemp_ffa0], a
	ret nc ; tails
	call ParalysisEffect
	ret

ThunderAttack_RecoilEffect:
	ldh a, [hTemp_ffa0]
	or a
	ret nz ; got heads
	ld a, 10
	call DealRecoilDamageToSelf
	ret

PoisonSeed_AIEffect:
	ld a, 10
	lb de, 10, 10
	call UpdateExpectedAIDamage_AccountForPoison
	ret

PoisonSeed_PoisonEffect:
	call PoisonEffect
	ret

MysteriousPowerEffect:
	call Confusion50PercentEffect
	ret

PoisonHorn_AIEffect:
	ld a, 10
	lb de, 10, 10
	call UpdateExpectedAIDamage_AccountForPoison
	ret

PoisonHorn_PoisonEffect:
	call PoisonEffect
	ret

PikachuLv5ThundershockEffect:
	call Paralysis50PercentEffect
	ret

NidoranFPoisonSting_AIEffect:
	ld a, 10 / 2
	lb de, 0, 10
	call UpdateExpectedAIDamage_AccountForPoison
	ret

NidoranFPoisonSting_Poison50PercentEffect:
	call Poison50PercentEffect
	ret

ShiningFingersEffect:
	call SleepEffect
	ret

SuspiciousSoundwaveEffect:
	call Confusion50PercentEffect
	ret

ToxicSpore_AIEffect:
	ld a, 20
	lb de, 20, 20
	call UpdateExpectedAIDamage_AccountForPoison
	ret

ToxicSpore_PoisonEffect:
	call PoisonEffect
	ret

PoliwagBubbleEffect:
	call Paralysis50PercentEffect
	ret

PoliwagBodySlamEffect:
	call Paralysis50PercentEffect
	ret

LickitungLickEffect:
	call Paralysis50PercentOrNoEffect
	ret

ChanseySingEffect:
	call Sleep50PercentOrNoEffect
	ret

SparkingKickEffect:
	call Paralysis50PercentEffect
	ret

SandshrewPoisonSting_AIEffect:
	ld a, 10 / 2
	lb de, 0, 10
	call UpdateExpectedAIDamage_AccountForPoison
	ret

SandshrewPoisonSting_Poison50PercentEffect:
	call Poison50PercentEffect
	ret

SeelIceBeamEffect:
	call Paralysis50PercentEffect
	ret

AuroraWaveEffect:
	call Confusion50PercentEffect
	ret

OnixBindEffect:
	call Paralysis50PercentEffect
	ret

KrabbyBubbleEffect:
	call Paralysis50PercentEffect
	ret

VoltorbThundershockEffect:
	call Paralysis50PercentEffect
	ret

RollingKickEffect:
	call Paralysis50PercentEffect
	ret

IcePunchEffect:
	call Paralysis50PercentEffect
	ret

ColdBreathEffect:
	call Sleep50PercentEffect
	ret

LaprasSingEffect:
	call Sleep50PercentOrNoEffect
	ret

AerodactylSupersonicEffect:
	call Confusion50PercentOrNoEffect
	ret

ArticunoIceBeamEffect:
	call Paralysis50PercentEffect
	ret

ArbokWrapEffect:
	call Paralysis50PercentEffect
	ret

VenonatPsybeamEffect:
	call Confusion50PercentEffect
	ret

WickedJabEffect:
	call Paralysis50PercentEffect
	ret

BellsproutStunSporeEffect:
	call Paralysis50PercentEffect
	ret

FadeToBlackEffect:
	call Confusion50PercentEffect
	ret

EerieLightEffect:
	call Confusion50PercentOrNoEffect
	ret

PersianAltPoisonClaws_AIEffect:
	ld a, 10 / 2
	lb de, 0, 10
	call UpdateExpectedAIDamage_AccountForPoison
	ret

PersianAltPoisonClaws_Poison50PercentEffect:
	call Poison50PercentEffect
	ret

KoffingLv14PoisonGas_AIEffect:
	ld a, 10 / 2
	lb de, 0, 10
	call UpdateExpectedAIDamage_AccountForPoison
	ret

KoffingLv14PoisonGas_Poison50PercentEffect:
	call Poison50PercentEffect
	ret

KoffingConfusionGasEffect:
	call Confusion50PercentEffect
	ret

ElectabuzzLv30ThundershockEffect:
	call Paralysis50PercentEffect
	ret

MagmarLv18Smog_AIEffect:
	ld a, 10 / 2
	lb de, 0, 10
	call UpdateExpectedAIDamage_AccountForPoison
	ret

MagmarLv18Smog_Poison50PercentEffect:
	call Poison50PercentEffect
	ret

WartortleBubbleEffect:
	call Paralysis50PercentEffect
	ret

; these are effect commands that Mirror Move uses
; in order to mimic last turn's attack.
; it covers all possible effect steps to perform its commands
; (i.e. selection for Amnesia and Energy discarding attacks, etc)

MirrorMove_AIEffect:
	ld a, DUELVARS_ARENA_CARD_LAST_TURN_DAMAGE
	get_turn_duelist_var
	ld a, [hl]
	ld [wAIMinDamage], a
	ld [wAIMaxDamage], a
	ret

MirrorMove_InitialEffect1:
	ld a, DUELVARS_ARENA_CARD_LAST_TURN_DAMAGE
	get_turn_duelist_var
	ld a, [hli] ; DUELVARS_ARENA_CARD_LAST_TURN_DAMAGE
	or [hl]     ;
	inc hl
	or [hl]     ; DUELVARS_ARENA_CARD_LAST_TURN_STATUS
	inc hl
	jr nz, .check_last_turn_effect
	ld a, [hli] ; DUELVARS_ARENA_CARD_LAST_TURN_SUBSTATUS2
	or a
	jr nz, .check_last_turn_effect
	inc hl
	ld a, [hl] ; DUELVARS_ARENA_CARD_LAST_TURN_CHANGE_WEAK
	or a
	jr nz, .check_last_turn_effect
	ldtx hl, YouDidNotReceiveAnAttackToMirrorMoveText
	scf
	ret

.check_last_turn_effect
	ld a, DUELVARS_ARENA_CARD_LAST_TURN_EFFECT
	get_turn_duelist_var
	cp LAST_TURN_EFFECT_DRY_UP
	jr z, .dry_up
	or a
	ret

.dry_up
	farcall MirrorMoveDryUpCheck
	ret

MirrorMove_InitialEffect2:
	ld a, $ff
	ldh [hTemp_ffa0], a
	ld a, DUELVARS_ARENA_CARD_LAST_TURN_EFFECT
	get_turn_duelist_var
	or a
	ret z ; no effect
	cp LAST_TURN_EFFECT_AMNESIA
	jr z, .pick_amnesia_attack
	cp LAST_TURN_EFFECT_DRY_UP
	jr z, .pick_dry_up_pkmn
	or a
	ret

.pick_amnesia_attack
	call PlayerPickAttackForAmnesia
	ret

.pick_dry_up_pkmn
	farcall MirrorMoveDryUpSelectArenaCard
	ret

MirrorMove_PlayerSelection:
	ld a, DUELVARS_ARENA_CARD_LAST_TURN_EFFECT
	get_turn_duelist_var
	or a
	ret z ; no effect
; handle Energy card discard effect
	cp LAST_TURN_EFFECT_DISCARD_ENERGY
	jr z, .discard_energy
	cp LAST_TURN_EFFECT_DRY_UP
	jr z, .dry_up
	cp LAST_TURN_EFFECT_STARE
	jr z, .stare
	ret

.discard_energy
	call HandleDiscardEnergyFromDefendingCardPlayerSelection
	ret

.dry_up
	farcall HandleDryUpPlayerSelection
	ret

.stare
	call SetArenaCardAsStareTarget
	ret

MirrorMove_AISelection:
	ld a, $ff
	ldh [hTemp_ffa0], a
	ld a, DUELVARS_ARENA_CARD_LAST_TURN_EFFECT
	get_turn_duelist_var
	or a
	ret z ; no effect
	cp LAST_TURN_EFFECT_DISCARD_ENERGY
	jr z, .discard_energy
	cp LAST_TURN_EFFECT_AMNESIA
	jr z, .pick_amnesia_attack
	cp LAST_TURN_EFFECT_DRY_UP
	jr z, .dry_up
	cp LAST_TURN_EFFECT_STARE
	jr z, .stare
	ret

.discard_energy
	call AIPickEnergyCardToDiscardFromDefendingPokemon
	ret

.pick_amnesia_attack
	call AIPickAttackForAmnesia
	ret

.dry_up
	farcall AISelectTargetForDryUp
	ret

.stare
	call AISelectStareTarget
	ret

MirrorMove_SwitchDefendingPkmn:
	ld a, DUELVARS_ARENA_CARD_LAST_TURN_EFFECT
	get_turn_duelist_var
	or a
	ret z ; no effect
	cp LAST_TURN_EFFECT_DRY_UP
	jr z, .dry_up
	ret

.dry_up
	farcall AISelectEnergiesForDryUp
	ret

MirrorMove_BeforeDamage:
	ld a, DUELVARS_ARENA_CARD_LAST_TURN_EFFECT
	get_turn_duelist_var

	cp LAST_TURN_EFFECT_AMNESIA
	jr z, .apply_amnesia

	cp LAST_TURN_EFFECT_TRANS_DAMAGE
	jr z, .trans_damage

	cp LAST_TURN_EFFECT_SWIFT
	jr z, .swift

	cp LAST_TURN_EFFECT_DRY_UP
	jr z, .dry_up

	cp LAST_TURN_EFFECT_STARE
	jr z, .stare

; check if there was last turn damage,
; and write it to wDamage.
	ld a, DUELVARS_ARENA_CARD_LAST_TURN_DAMAGE
	get_turn_duelist_var
	ld de, wDamage
	ld a, [hli]
	ld [de], a
	inc de
	ld a, [hld]
	ld [de], a
	or [hl]
	jr z, .no_damage
	ld a, ATK_ANIM_HIT
	ld [wLoadedAttackAnimation], a
.no_damage
	inc hl
	inc hl ; DUELVARS_ARENA_CARD_LAST_TURN_STATUS
	push hl
	ld a, DUELVARS_ARENA_CARD_STATUS
	call GetNonTurnDuelistVariable
	ld e, l
	ld d, h
	pop hl
	ld a, [hli]
	or a
	jr z, .no_status
	push hl
	push de
	call MirrorMove_ExecuteStatusEffect
	pop de
	pop hl
.no_status
; hl is at DUELVARS_ARENA_CARD_LAST_TURN_SUBSTATUS2
; apply substatus2 to defending card
	ld e, DUELVARS_ARENA_CARD_SUBSTATUS2
	ld a, [hli]
	ld [de], a
	ld e, DUELVARS_ARENA_CARD_LAST_TURN_SUBSTATUS2
	ld [de], a
	ret

.apply_amnesia
	ld a, DUELVARS_ARENA_CARD_LAST_TURN_SUBSTATUS2
	get_turn_duelist_var
	call ApplyAmnesiaToAttack_GotSubstatus
	ret

.trans_damage
	farcall PlayMirrorMoveTransDamageAnimation
	ret

.swift
	farcall PlayMirrorMoveSwiftAnimationAndZeroDamage
	ret

.dry_up
	farcall DryUpProcessArenaEffects
	ret

.stare
	call SetAttackAnimationToNoneAndResetResidualIfTargetIsArenaCard
	ret

MirrorMove_AfterDamage:
	ld a, [wNoDamageOrEffect]
	or a
	ret nz ; is unaffected
	ld a, DUELVARS_ARENA_CARD_LAST_TURN_EFFECT
	get_turn_duelist_var
	cp LAST_TURN_EFFECT_DISCARD_ENERGY
	jr z, .discard_energy

	cp LAST_TURN_EFFECT_DRY_UP
	jr z, .dry_up

	cp LAST_TURN_EFFECT_STARE
	jr z, .stare

	cp LAST_TURN_EFFECT_TWISTER
	jr z, .twister

	cp LAST_TURN_EFFECT_SPINNING_SHOWER
	jr z, .spinning_shower

	cp LAST_TURN_EFFECT_CHANGE_WEAKNESS
	jr z, .change_weakness

	cp LAST_TURN_EFFECT_SWIFT
	jr z, .swift

	cp LAST_TURN_EFFECT_TRANS_DAMAGE
	jr z, .trans_damage
	jr .done

.discard_energy
	call DiscardEnergyEffect
	jr .done

.dry_up
	farcall DiscardDryUpEnergies
	jr .done

.stare
	ld a, DUELVARS_ARENA_CARD_LAST_TURN_DAMAGE
	get_turn_duelist_var
	ld e, [hl]
	inc hl
	ld d, [hl]
	call DealStareDamage
	jr .done

.twister
	farcall TwisterEffect_SkipCoinToss
	jr .done

.spinning_shower
	farcall SpinningShower_AttackRandomPlayAreaCardsEffect.DiscardRandomArenaCardEnergy
	jr .done

.change_weakness
	call .ChangeWeakness
	jr .done

.swift
	farcall DealMirrorMoveSwiftDamage
	jr .done

.trans_damage
	farcall ApplyMirrorMoveTransDamageAttackDamage
	jr .done ; useless jump

.done
	ret

.ChangeWeakness:
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
	ret z ; defending Pokemon has no weakness to change

; apply same color weakness to Defending Pokemon
	ld c, [hl]
	ld a, DUELVARS_ARENA_CARD_CHANGED_WEAKNESS
	call GetNonTurnDuelistVariable
	ld [hl], c
	ld l, DUELVARS_ARENA_CARD_LAST_TURN_CHANGE_WEAK
	ld [hl], c
	ld l, DUELVARS_ARENA_CARD_LAST_TURN_EFFECT
	ld [hl], LAST_TURN_EFFECT_CHANGE_WEAKNESS
	ld l, DUELVARS_ARENA_CARD_LAST_TURN_SUBSTATUS2
	ld [hl], SUBSTATUS2_CONVERSION2
	ld l, DUELVARS_ARENA_CARD_SUBSTATUS2
	ld [hl], SUBSTATUS2_CONVERSION2

; print message of weakness color change
	ld a, c
	ld c, -1
.loop_color
	inc c
	rla
	jr nc, .loop_color
	ld a, c
	call SwapTurn
	push af
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call LoadCardDataToBuffer1_FromDeckIndex
	pop af
	call LoadCardNameAndInputColor
	ldtx hl, ChangedTheWeaknessOfPokemonToColorText
	call DrawWideTextBox_PrintText
	call SwapTurn
	ret

MirrorMove_ExecuteStatusEffect:
	ld c, a
	and PSN_DBLPSN
	jr z, .cnf_slp_prz
	ld b, a
	cp DOUBLE_POISONED
	push bc
	call z, DoublePoisonEffect
	pop bc
	ld a, b
	cp POISONED
	push bc
	call z, PoisonEffect
	pop bc
.cnf_slp_prz
	ld a, c
	and CNF_SLP_PRZ
	ret z
	cp CONFUSED
	jp z, ConfusionEffect
	cp ASLEEP
	jp z, SleepEffect
	cp PARALYZED
	jp z, ParalysisEffect
	ret
