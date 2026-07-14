AIProcessHandTrainerCards:
	ld [wAITrainerCardPhase], a
; create hand list in wDuelTempList and wTempHandCardList.
	call CreateHandCardList
	ld hl, wDuelTempList
	ld de, wTempHandCardList
	call .CopyList

	ld hl, wTempHandCardList
.loop_hand
	ld a, [hli]
	ld [wAITrainerCardToPlay], a
	cp $ff
	ret z

	push hl
	ld hl, AITrainerCardLogic
.loop_data
	xor a
	ld [wCurrentAIFlags], a
	ld a, [hli]
	cp $ff
	jp z, .pop_hl

; compare input to first byte in data and continue if equal.
	push af
	ld a, [wAITrainerCardPhase]
	ld d, a
	pop af
	cp d
	jp nz, .inc_hl_by_6

	ld a, [hli]
	ld [wAITrainerLogicCard + 0], a
	ld a, [hli]
	ld [wAITrainerLogicCard + 1], a
	ld a, [wAITrainerCardToPlay]
	call GetCardIDFromDeckIndex
	cp16 SWITCH
	jr nz, .skip_switch_check

	ld a, [wPreviousAIFlags]
	and AI_FLAG_USED_SWITCH
	jr nz, .inc_hl_by_4

.skip_switch_check
; compare hand card to second byte in data and continue if equal.
	ld a, [wAITrainerLogicCard + 0]
	cp e
	jr nz, .inc_hl_by_4
	ld a, [wAITrainerLogicCard + 1]
	cp d
	jr nz, .inc_hl_by_4

; found Trainer card
	push hl
	push de
	ld a, [wAITrainerCardToPlay]
	ldh [hDuelActionCardIndex], a

; if Headache effects prevent playing card
; move on to the next item in list.
	bank1call CheckCantUseTrainerDueToEffect
	jp c, .next_in_data

	bank1call LoadNonPokemonCardEffectCommands
	ld a, EFFECTCMDTYPE_INITIAL_EFFECT_1
	call TryExecuteEffectCommandFunction
	jp c, .next_in_data

	farcall StubbedAIChooseRandomlyNotToDoAction
	jr c, .next_in_data

; call routine to decide whether to play Trainer card
	pop de
	pop hl
	push hl
	call CallIndirect
	pop hl
	jr nc, .inc_hl_by_4

; routine returned carry, which means
; this card should be played.
	inc hl
	inc hl
	ld [wAITrainerCardArgs + 0], a

; show Play Trainer Card screen
	push de
	push hl
	ld a, [wAITrainerCardToPlay]
	ldh [hDuelActionCardIndex], a
	ld a, OPPACTION_PLAY_TRAINER
	farcall AIMakeDecision
	pop hl
	pop de
	jr c, .inc_hl_by_2

; execute the effects of the Trainer card
	push hl
	call CallIndirect
	pop hl
	jr c, .set_carry

	inc hl
	inc hl
	ld a, [wPreviousAIFlags]
	ld b, a
	ld a, [wCurrentAIFlags]
	or b
	ld [wPreviousAIFlags], a
	pop hl
	and AI_FLAG_MODIFIED_HAND
	jp z, .loop_hand

; the hand was modified during the Trainer effect
; so it needs to be re-listed again and
; looped from the top.
	call CreateHandCardList
	ld hl, wDuelTempList
	ld de, wTempHandCardList
	call .CopyList
	ld hl, wTempHandCardList
; clear the AI_FLAG_MODIFIED_HAND flag
	ld a, [wPreviousAIFlags]
	and ~AI_FLAG_MODIFIED_HAND
	ld [wPreviousAIFlags], a
	jp .loop_hand

.inc_hl_by_6
	inc hl
	inc hl
.inc_hl_by_4
	inc hl
	inc hl
.inc_hl_by_2
	inc hl
	inc hl
	jp .loop_data

.next_in_data
	pop de
	pop hl
	inc hl
	inc hl
	inc hl
	inc hl
	jp .loop_data

.pop_hl
	pop hl
	jp .loop_hand

.set_carry
	pop hl
	scf
	ret

; copies $ff-terminated list from hl to de
.CopyList:
	ld a, [hli]
	ld [de], a
	cp $ff
	ret z
	inc de
	jr .CopyList

; returns hl = floor(hl / 10)
CalculateWordTensDigit:
	push bc
	push de
	ld bc, -10
	ld de, -1
.loop
	inc de
	add hl, bc
	jr c, .loop
	ld h, d
	ld l, e
	pop de
	pop bc
	ret

; returns a = floor(b / a)
CalculateBDividedByA_Bank08:
	push bc
	ld c, a
	ld a, b
	ld b, c
	ld c, 0
.loop
	sub b
	jr c, .done
	inc c
	jr .loop
.done
	ld a, c
	pop bc
	ret

; makes AI use Potion card.
AIPlay_Potion:
	ld a, [wAITrainerCardToPlay]
	ldh [hDuelActionCardIndex], a
	ld a, [wAITrainerCardArgs + 0]
	ldh [hDuelActionArgs + 0], a
	ld e, a
	call GetCardDamageAndMaxHP
	cp 20
	jr c, .play_card
	ld a, 20
.play_card
	ldh [hDuelActionArgs + 1], a
	ld a, OPPACTION_EXECUTE_TRAINER_EFFECTS
	farcall AIMakeDecision
	ret

; if AI doesn't decide to retreat this card,
; check if defending Pokémon can KO active card
; next turn after using Potion.
; if it cannot, return carry.
; also take into account whether attack is high recoil.
AIDecide_Potion_Phase07:
	farcall AIDecideWhetherToRetreat_ConsiderStatus
	jr c, .no_carry

	; Quick Attack and Big Thunder deck AIs have
	; specific logic in other Trainer phases
	ld a, [wOpponentDeckID]
	cp QUICK_ATTACK_DECK_ID
	jr z, .no_carry
	cp BIG_THUNDER_DECK_ID
	jr z, .no_carry
	farcall AICheckIfAttackIsHighRecoil
	jr c, .no_carry
	ld a, 20
	farcall CheckIfHealingPreventsKOByDefendingPokemon
	ret nc ; doesn't avoid KO

; return carry
	xor a
	scf
	ret
.no_carry
	or a
	ret

; finds a card in Play Area to use Potion on.
; output:
;	a = card to use Potion on;
;	carry set if Potion should be used.
AIDecide_Potion_Phase10:
	ld a, [wOpponentDeckID]
	cp QUICK_ATTACK_DECK_ID
	jp z, .QuickAttackDeck
	cp BIG_THUNDER_DECK_ID
	jp z, .no_carry
	ld a, 20
	farcall CheckIfHealingPreventsKOByDefendingPokemon
	jr nc, .count_prizes
	; avoids Arena KO, don't play it on this Trainer Phase
	or a
	ret

.count_prizes
; using Potion on active card does not prevent a KO.
; if player is at last prize, start loop with active card.
; otherwise start loop at first bench Pokémon.
	call SwapTurn
	call CountPrizes
	call SwapTurn
	dec a
	jr z, .start_from_active
	ld e, PLAY_AREA_BENCH_1
	jr .loop
.start_from_active
	ld e, PLAY_AREA_ARENA
.loop
	ld a, DUELVARS_ARENA_CARD
	add e
	get_turn_duelist_var
	cp $ff
	ret z
	call .CheckIfHasAttackWithBoostIfTakenDamageFlag
	jr c, .has_boost_damage
	call GetCardDamageAndMaxHP
	cp 20 ; if damage >= 20
	jr nc, .found
.has_boost_damage
	inc e
	jr .loop

; a card was found, now to check if it's active or benched.
.found
	ld a, e
	or a
	jr z, .active_card

; bench card
; if player is on last prize card then use Potion
; otherwise only 70% chance to use Potion
	push de
	call SwapTurn
	call CountPrizes
	call SwapTurn
	dec a
	or a
	jr z, .no_random_chance
	; 70% chance to use Potion
	ld a, 10
	call Random
	cp 3
.no_random_chance
	pop de
	jr c, .no_carry
	ld a, e
	scf
	ret

; return carry for active card if not High Recoil.
.active_card
	push de
	farcall AICheckIfAttackIsHighRecoil
	pop de
	jr c, .no_carry
	ld a, e
	scf
	ret
.no_carry
	or a
	ret

; return carry if either of the attacks are usable
; and have the BOOST_IF_TAKEN_DAMAGE effect.
.CheckIfHasAttackWithBoostIfTakenDamageFlag:
	push de
	xor a ; FIRST_ATTACK_OR_PKMN_POWER
	ld [wSelectedAttack], a
	farcall CheckIfSelectedAttackIsUnusable
	jr c, .second_attack
	ld a, ATTACK_FLAG3_ADDRESS | BOOST_IF_TAKEN_DAMAGE_F
	call CheckLoadedAttackFlag
	jr c, .true
.second_attack
	ld a, SECOND_ATTACK
	ld [wSelectedAttack], a
	farcall CheckIfSelectedAttackIsUnusable
	jr c, .false
	ld a, ATTACK_FLAG3_ADDRESS | BOOST_IF_TAKEN_DAMAGE_F
	call CheckLoadedAttackFlag
	jr c, .true
.false
	pop de
	or a
	ret
.true
	pop de
	scf
	ret

; Quick Attack AI opponent will only heal Play Area card if:
; - is Dark Jolteon and its remaining HP is below 30
; - is Dark Raichu  and its remaining HP is below 50
.QuickAttackDeck:
	ld e, PLAY_AREA_ARENA
.loop_play_area
	ld a, e
	add DUELVARS_ARENA_CARD
	get_turn_duelist_var
	cp $ff
	ret z
	push de
	call GetCardIDFromDeckIndex
	cp16 DARK_JOLTEON
	ld c, 30
	jr z, .dark_jolteon_or_dark_raichu
	cp16 DARK_RAICHU
	ld c, 50
	jr z, .dark_jolteon_or_dark_raichu
.next_play_area_card
	pop de
	inc e
	jr .loop_play_area
.dark_jolteon_or_dark_raichu
	pop de
	ld a, e
	add DUELVARS_ARENA_CARD_HP
	get_turn_duelist_var
	cp c ; is remaining HP < c?
	push de
	jr nc, .next_play_area_card
	; yes, then heal
	pop de
	ld a, e
	scf
	ret

AIDecide_Potion_Phase11:
	ld a, [wOpponentDeckID]
	cp BIG_THUNDER_DECK_ID
	jp z, .big_thunder_deck
	or a
	ret
.big_thunder_deck
	farcall AIDecide_Potion_BigThunderDeck
	ret

; makes AI use Super Potion card.
AIPlay_SuperPotion:
	ld a, [wAITrainerCardToPlay]
	ldh [hDuelActionCardIndex], a
	ld a, [wAITrainerCardArgs + 0]
	ldh [hDuelActionArgs + 1], a
	farcall AIPickEnergyCardToDiscard
	ldh [hDuelActionArgs + 0], a
	ld a, [wAITrainerCardArgs + 0]
	ld e, a
	call GetCardDamageAndMaxHP
	cp 40
	jr c, .play_card
	ld a, 40
.play_card
	ldh [hDuelActionArgs + 2], a
	ld a, OPPACTION_EXECUTE_TRAINER_EFFECTS
	farcall AIMakeDecision
	ret

; if AI doesn't decide to retreat this card and card has
; any energy cards attached, check if defending Pokémon can KO
; active card next turn after using Super Potion.
; if it cannot, return carry.
; also take into account whether attack is high recoil.
AIDecide_SuperPotion_Phase08:
	farcall AIDecideWhetherToRetreat_ConsiderStatus
	jr c, .no_carry

	; Big Thunder deck AI will be processed in another phase
	ld a, [wOpponentDeckID]
	cp BIG_THUNDER_DECK_ID
	jr z, .no_carry

	farcall AICheckIfAttackIsHighRecoil
	jr c, .no_carry

	; if Arena card has no energies, exit
	ld e, PLAY_AREA_ARENA
	call .CheckIfHasEnergies
	ret nc

	ld a, 40
	farcall CheckIfHealingPreventsKOByDefendingPokemon
	ret nc
	xor a
	scf
	ret
.no_carry
	or a
	ret

; returns carry if card has energies attached.
.CheckIfHasEnergies:
	call GetPlayAreaCardAttachedEnergies
	ld a, [wTotalAttachedEnergies]
	or a
	ret z ; no energies
	scf
	ret

; finds a card in Play Area to use Super Potion on.
; output:
;	a = card to use Super Potion on;
;	carry set if Super Potion should be used.
AIDecide_SuperPotion_Phase11:
	; Big Thunder deck AI has specific logic
	ld a, [wOpponentDeckID]
	cp BIG_THUNDER_DECK_ID
	jp z, .no_carry
	ld a, 40
	farcall CheckIfHealingPreventsKOByDefendingPokemon
	jr nc, .count_prizes
	; avoids Arena KO, don't play it on this Trainer Phase
	or a
	ret

.count_prizes
; using Super Potion on active card does not prevent a KO.
; if player is at last prize, start loop with active card.
; otherwise start loop at first bench Pokémon.
	call SwapTurn
	call CountPrizes
	call SwapTurn
	dec a
	jr z, .start_from_active
	ld e, PLAY_AREA_BENCH_1
	jr .loop

; find Play Area Pokémon with more than 30 damage.
; skip Pokémon if it doesn't have any energy attached,
; has a BOOST_IF_TAKEN_DAMAGE attack,
; or if discarding makes any of its attacks unusable.
.start_from_active
	ld e, PLAY_AREA_ARENA
.loop
	ld a, DUELVARS_ARENA_CARD
	add e
	get_turn_duelist_var
	cp $ff
	ret z
	ld d, a
	call .CheckIfHasEnergies
	jr nc, .next
	call .CheckIfHasAttackWithBoostIfTakenDamageFlag
	jr c, .next
	call .CheckIfDiscardingMakesAttacksUnusable
	jr c, .next
	call GetCardDamageAndMaxHP
	cp 40 ; if damage >= 40
	jr nc, .found
.next
	inc e
	jr .loop

; a card was found, now to check if it's active or benched.
.found
	ld a, e
	or a
	jr z, .active_card

; bench card
; if player is on last prize card then use Super Potion
; otherwise only 70% chance to use Super Potion
	push de
	call SwapTurn
	call CountPrizes
	call SwapTurn
	dec a
	or a
	jr z, .no_random_chance
	; 70% chance to use Super Potion
	ld a, 10
	call Random
	cp 3
.no_random_chance
	pop de
	jr c, .no_carry
	ld a, e
	scf
	ret

; return carry for active card if not High Recoil.
.active_card
	push de
	farcall AICheckIfAttackIsHighRecoil
	pop de
	jr c, .no_carry
	ld a, e
	scf
	ret
.no_carry
	or a
	ret

; returns carry if card has energies attached.
.CheckIfHasEnergies:
	call GetPlayAreaCardAttachedEnergies
	ld a, [wTotalAttachedEnergies]
	or a
	ret z
	scf
	ret

; return carry if either of the attacks are usable
; and have the BOOST_IF_TAKEN_DAMAGE effect.
.CheckIfHasAttackWithBoostIfTakenDamageFlag:
	push de
	xor a ; FIRST_ATTACK_OR_PKMN_POWER
	ld [wSelectedAttack], a
	farcall CheckIfSelectedAttackIsUnusable
	jr c, .second_attack_1
	ld a, ATTACK_FLAG3_ADDRESS | BOOST_IF_TAKEN_DAMAGE_F
	call CheckLoadedAttackFlag
	jr c, .true_1
.second_attack_1
	ld a, SECOND_ATTACK
	ld [wSelectedAttack], a
	farcall CheckIfSelectedAttackIsUnusable
	jr c, .false_1
	ld a, ATTACK_FLAG3_ADDRESS | BOOST_IF_TAKEN_DAMAGE_F
	call CheckLoadedAttackFlag
	jr c, .true_1
.false_1
	pop de
	or a
	ret
.true_1
	pop de
	scf
	ret

; returns carry if discarding energy card renders any attack unusable,
; given that they have enough energy to be used before discarding.
.CheckIfDiscardingMakesAttacksUnusable:
	push de
	xor a ; FIRST_ATTACK_OR_PKMN_POWER
	ld [wSelectedAttack], a
	ld a, e
	ldh [hTempPlayAreaLocation_ff9d], a
	farcall CheckEnergyNeededForAttack
	jr c, .second_attack_2
	farcall CheckEnergyNeededForAttackAfterDiscard
	jr c, .true_2

.second_attack_2
	pop de
	push de
	ld a, SECOND_ATTACK
	ld [wSelectedAttack], a
	ld a, e
	ldh [hTempPlayAreaLocation_ff9d], a
	farcall CheckEnergyNeededForAttack
	jr c, .false_2
	farcall CheckEnergyNeededForAttackAfterDiscard
	jr c, .true_2

.false_2
	pop de
	or a
	ret

.true_2
	pop de
	scf
	ret

AIDecide_SuperPotion_Phase13:
	ld a, [wOpponentDeckID]
	cp BIG_THUNDER_DECK_ID
	jp z, .big_thunder_deck
	or a
	ret
.big_thunder_deck
	farcall AIDecide_SuperPotion_BigThunderDeck
	ret

AIPlay_Defender:
	ld a, [wAITrainerCardToPlay]
	ldh [hDuelActionCardIndex], a
	; AI always attaches a Defender card to the Active Pokémon.
	xor a ; PLAY_AREA_ARENA
	ldh [hDuelActionArgs + 0], a
	ld a, OPPACTION_EXECUTE_TRAINER_EFFECTS
	farcall AIMakeDecision
	ret

AIDecide_Defender_Phase13:
	; skip if Arena card is Mr. Mime lv28
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call GetCardIDFromDeckIndex
	cp16 MR_MIME_LV28
	ret z

	; if will use Professor Oak, use it regardless
	ld de, PROFESSOR_OAK
	farcall LookForCardIDInHandList
	jr nc, .no_professor_oak
	call AIDecide_ProfessorOak
	ret c
.no_professor_oak
	; skip if already has Defender attached
	ld a, DUELVARS_ARENA_CARD_ATTACHED_DEFENDER
	get_turn_duelist_var
	or a
	ret nz

	; specific logic for some deck AIs
	ld a, [wOpponentDeckID]
	cp RUNNING_WILD_DECK_ID
	jr z, .RunningWildDeck
	cp BIG_THUNDER_DECK_ID
	jp z, .BigThunderDeck

	; if can KO defending card, don't use
	farcall CheckIfArenaCardCanKnockOutDefendingCard_CheckHand
	jr c, .no_carry

	; if Arena card is KO'd by poison damage, don't use
	farcall CheckIfPoisonDamageKOsArenaPkmn
	jr c, .no_carry

	; if Defending card doesn't KO Arena card, don't use
	farcall CheckIfAnyDefendingPokemonAttackDealsSameDamageAsHP
	jr nc, .no_carry
	call SwapTurn
	farcall CheckIfSelectedAttackIsUnusable
	call SwapTurn
	jr c, .no_carry

	ld a, [wSelectedAttack]
	farcall EstimateDamage_FromDefendingPokemon
	ld a, [wDamage]
	ld [wd082], a
	ld d, a

; load in a the attack that was not selected,
; and check if it is useable.
	ld a, [wSelectedAttack]
	ld b, a
	ld a, SECOND_ATTACK
	sub b
	ld [wSelectedAttack], a
	push de
	call SwapTurn
	farcall CheckIfSelectedAttackIsUnusable
	call SwapTurn
	pop de
	jr c, .switch_back

; the other attack is useable.
; compare its damage to the selected attack.
	ld a, [wSelectedAttack]
	push de
	farcall EstimateDamage_FromDefendingPokemon
	pop de
	ld a, [wDamage]
	cp d
	jr nc, .subtract

; in case the non-selected attack is useable
; and deals less damage than the selected attack,
; switch back to the other attack.
.switch_back
	ld a, [wSelectedAttack]
	ld b, a
	ld a, SECOND_ATTACK
	sub b
	ld [wSelectedAttack], a
	ld a, [wd082]
	ld [wDamage], a

; now the selected attack is the one that deals
; the most damage of the two (and is useable).
; if subtracting damage by using Defender
; still prevents a KO, return carry.
.subtract
	ld a, [wDamage]
	sub 20
	ld d, a
	ld a, DUELVARS_ARENA_CARD_HP
	get_turn_duelist_var
	sub d
	jr c, .no_carry
	jr z, .no_carry
.set_carry
	scf
	ret
.no_carry
	or a
	ret

.RunningWildDeck:
	; if Arena card is Dark Primeape...
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call GetCardIDFromDeckIndex
	cp16 DARK_PRIMEAPE
	jr nz, .no_carry
	; ...and it's confused....
	ld a, DUELVARS_ARENA_CARD_STATUS
	get_turn_duelist_var
	and CNF_SLP_PRZ
	cp CONFUSED
	jr nz, .no_carry
	; ...and its remaining HP is 40 or more...
	ld a, DUELVARS_ARENA_CARD_HP
	get_turn_duelist_var
	cp 40
	jr c, .no_carry
	; ...use Defender
	scf
	ret

.BigThunderDeck:
	; if Ditto is the only card in play, use
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call GetCardIDFromDeckIndex
	cp16 DITTO
	jr nz, .not_ditto
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	cp 1
	jr z, .set_carry
.not_ditto
	; if can KO defending card, don't use
	farcall CheckIfArenaCardCanKnockOutDefendingCard_CheckHand
	jr c, .no_carry

	; if Arena card is KO'd by poison damage, don't use
	farcall CheckIfPoisonDamageKOsArenaPkmn
	jr c, .no_carry

	; if maximum damage that Defending card that inflict
	; is less than 30, then don't use
	farcall GetHighestDamageFromDefendingPokemon
	cp 30
	jr c, .no_carry
	; if this damage KO's Arena card even with Defender, don't use
	push af
	ld a, DUELVARS_ARENA_CARD_HP
	get_turn_duelist_var
	add 20
	pop bc
	sub b
	jr c, .no_carry
	jr z, .no_carry
	; otherwise, use
	jr nc, .set_carry

AIDecide_Defender_Phase14:
	; skip if already has Defender attached
	ld a, DUELVARS_ARENA_CARD_ATTACHED_DEFENDER
	get_turn_duelist_var
	or a
	ret nz

	; if Arena card is KO'd by poison damage, don't use
	farcall CheckIfPoisonDamageKOsArenaPkmn
	jr c, .no_carry_1

	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	ld d, a
	ld a, [wSelectedAttack]
	ld e, a
	call CopyAttackDataAndDamage_FromDeckIndex

	; Running Wild deck AI doesn't use Defender in this phase
	ld a, [wOpponentDeckID]
	cp RUNNING_WILD_DECK_ID
	jr z, .no_carry_1

	; BlazingFlame deck AI has specific logic
	cp BLAZING_FLAME_DECK_ID
	jr z, .BlazingFlameDeck

	; Big Thunder deck AI doesn't use Defender in this phase
	cp BIG_THUNDER_DECK_ID
	jr z, .no_carry_1

	; if no recoil, then don't use
	ld a, ATTACK_FLAG1_ADDRESS | HIGH_RECOIL_F
	call CheckLoadedAttackFlag
	jr c, .recoil
	ld a, ATTACK_FLAG1_ADDRESS | LOW_RECOIL_F
	call CheckLoadedAttackFlag
	jr c, .recoil
.no_carry_1
	or a
	ret

.recoil
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call LoadCardDataToBuffer2_FromDeckIndex
	ld a, [wSelectedAttack]
	or a
	jr nz, .second_attack
; first attack
	ld a, [wLoadedCard2Atk1EffectParam]
	jr .check_weak
.second_attack
	ld a, [wLoadedCard2Atk2EffectParam]

; double recoil damage if card is weak to its own color.
.check_weak
	ld d, a
	push de
	bank1call GetArenaCardColor
	call TranslateColorToWR
	ld b, a
	bank1call GetArenaCardWeakness
	and b
	pop de
	jr z, .check_resist
	sla d

; subtract 30 from recoil damage if card resists its own color.
; if this yields a negative number, return no carry.
.check_resist
	push de
	bank1call GetArenaCardColor
	call TranslateColorToWR
	ld b, a
	bank1call GetArenaCardResistance
	and b
	pop de
	jr z, .subtract
	ld a, d
	sub 30
	jr c, .no_carry_2
	ld d, a

; subtract damage prevented by Defender.
; if damage still knocks out card, return no carry.
; if damage does not knock out, return carry.
.subtract
	ld a, d
	or a
	jr z, .no_carry_2
	sub 20
	ld d, a
	ld a, DUELVARS_ARENA_CARD_HP
	get_turn_duelist_var
	sub d
	jr c, .no_carry_2
	jr z, .no_carry_2
	scf
	ret
.no_carry_2
	or a
	ret

.BlazingFlameDeck:
	ld a, ATTACK_FLAG1_ADDRESS | LOW_RECOIL_F
	call CheckLoadedAttackFlag
	ret

AIPlay_PlusPower:
	ld a, [wCurrentAIFlags]
	or AI_FLAG_USED_PLUSPOWER
	ld [wCurrentAIFlags], a
	ld a, [wAITrainerCardArgs + 0]
	ld [wAIPlusPowerAttack], a
	ld a, [wAITrainerCardToPlay]
	ldh [hDuelActionCardIndex], a
	ld a, OPPACTION_EXECUTE_TRAINER_EFFECTS
	farcall AIMakeDecision
	ret

AIDecide_PlusPower_Phase13:
	; if defending card is under effect of Destiny Bond, don't use
	ld a, DUELVARS_ARENA_CARD_SUBSTATUS1
	call GetNonTurnDuelistVariable
	cp SUBSTATUS1_DESTINY_BOND
	ret z

	farcall IsPlayerArenaCardImmune
	ccf
	ret nc

	; Quick Attack deck AI doesn't use PlusPower in this phase
	ld a, [wOpponentDeckID]
	cp QUICK_ATTACK_DECK_ID
	jr z, .no_carry

	; if Arena card already KO's, don't use
	farcall CheckIfArenaCardCanKnockOutDefendingCard_CheckHand
	jr c, .no_carry

	; if defending card is not Mr Mime lv28
	; and AI will use Professor Oak, then use PlusPower
	call SwapTurn
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call GetCardIDFromDeckIndex
	call SwapTurn
	cp16 MR_MIME_LV28
	jr z, .else
	ld de, PROFESSOR_OAK
	farcall LookForCardIDInHandList
	jr nc, .else
	call AIDecide_ProfessorOak
	jr nc, .else
	ld a, $ff ; no chosen attack in this case
	scf
	ret

.else
	xor a ; FIRST_ATTACK_OR_PKMN_POWER
	ld [wSelectedAttack], a
	call .CheckAttackWithPlusPower
	jr c, .first_atk_kos_with_pluspower
	ld a, SECOND_ATTACK
	ld [wSelectedAttack], a
	call .CheckAttackWithPlusPower
	jr c, .second_atk_kos_with_pluspower

.no_carry
	or a
	ret
.first_atk_kos_with_pluspower
	call .MrMimeDamageCheck
	jr nc, .no_carry
	xor a ; FIRST_ATTACK_OR_PKMN_POWER
	scf
	ret

.second_atk_kos_with_pluspower
	call .MrMimeDamageCheck
	jr nc, .no_carry
	ld a, SECOND_ATTACK
	scf
	ret

; return carry if attack is useable and KOs
; defending Pokémon with PlusPower boost.
.CheckAttackWithPlusPower:
	farcall CheckIfSelectedAttackIsUnusable
	jr c, .unusable
	ld a, [wSelectedAttack]
	farcall EstimateDamage_VersusDefendingCard
	ld a, DUELVARS_ARENA_CARD_HP
	call GetNonTurnDuelistVariable
	ld b, a
	ld hl, wDamage
	sub [hl]
	jr c, .no_carry
	jr z, .no_carry
	; temporarily decrement pluspowers attached
	ld a, DUELVARS_ARENA_CARD_ATTACHED_PLUSPOWER
	get_turn_duelist_var
	inc [hl]
	push bc
	ld a, [wSelectedAttack]
	farcall EstimateDamage_VersusDefendingCard
	pop bc
	; restore pluspowers attached
	ld a, DUELVARS_ARENA_CARD_ATTACHED_PLUSPOWER
	get_turn_duelist_var
	dec [hl]
	ld a, [wDamage]
	ld c, a
	ld a, b
	sub c
	ret c
	ret nz
	scf
	ret
.unusable
	or a
	ret

; returns carry if PlusPower boost does
; not exceed 30 damage when facing Mr. Mime.
.MrMimeDamageCheck:
	ld a, [wDamage]
	add 10 ; add PlusPower boost
	cp 30 ; no danger in preventing damage
	ret c
	call SwapTurn
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call GetCardIDFromDeckIndex
	call SwapTurn
	cp16 MR_MIME_LV28
	ret z
; damage is >= 30 but not Mr. Mime
	scf
	ret

AIDecide_PlusPower_Phase14:
	; if defending card is under effect of Destiny Bond, don't use
	ld a, DUELVARS_ARENA_CARD_SUBSTATUS1
	call GetNonTurnDuelistVariable
	cp SUBSTATUS1_DESTINY_BOND
	ret z

	farcall IsPlayerArenaCardImmune
	ccf
	ret nc

	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	ld d, a
	ld a, [wSelectedAttack]
	ld e, a
	call CopyAttackDataAndDamage_FromDeckIndex

	; if is a bench damaging attack, don't use
	ld a, ATTACK_FLAG1_ADDRESS | DAMAGE_TO_OPPONENT_BENCH_F
	call CheckLoadedAttackFlag
	jr c, .no_carry

	xor a ; PLAY_AREA_ARENA
	ldh [hTempPlayAreaLocation_ff9d], a

	; if is any of the following decks,
	; don't use except for Quick Attack deck
	ld a, [wOpponentDeckID]
	cp GO_ARCANINE_DECK_ID
	jr z, .no_carry
	cp LEGENDARY_FOSSIL_DECK_ID
	jr z, .no_carry
	cp QUICK_ATTACK_DECK_ID
	jp z, .QuickAttackDeck
	cp WATER_STREAM_DECK_ID
	jr z, .no_carry
	cp PSYCHIC_BATTLE_DECK_ID
	jr z, .no_carry
	cp STOP_LIFE_DECK_ID
	jr z, .no_carry
	cp TSUNAMI_STARTER_DECK_ID
	jr z, .no_carry
	cp EVERYBODYS_FRIEND_DECK_ID
	jr z, .no_carry
	cp POISON_STORM_DECK_ID
	jr z, .no_carry

	; if can attack can KO, don't use
	call .CheckAttackDoesntKO
	jr nc, .no_carry
	call .Func_207ed
	jr nc, .no_carry
	call .MrMimeDamageCheck
	jr nc, .no_carry
	scf
	ret
.no_carry
	or a
	ret

; returns carry if PlusPower boost does
; not exceed 30 damage when facing Mr. Mime.
.MrMimeDamageCheck:
	ld a, [wDamage]
	add 10 ; add PlusPower boost
	cp 30 ; no danger in preventing damage
	ret c
	call SwapTurn
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call GetCardIDFromDeckIndex
	call SwapTurn
	cp16 MR_MIME_LV28
	ret z
; damage is >= 30 but not Mr. Mime
	scf
	ret

; returns carry if selected attack cannot KO
.CheckAttackDoesntKO:
	farcall CheckIfSelectedAttackIsUnusable
	jr c, .unusable
	ld a, [wSelectedAttack]
	farcall EstimateDamage_VersusDefendingCard
	ld a, DUELVARS_ARENA_CARD_HP
	call GetNonTurnDuelistVariable
	ld hl, wDamage
	sub [hl]
	jr c, .no_carry
	jr z, .no_carry
	scf
	ret
.unusable
	or a
	ret

.Func_207ed:
	ld a, [wAIMinDamage]
	farcall DiscountPoisonFromDamage
	cp 10
	jr c, .unusable
	; 30% chance to use PlusPower
	ld a, 10
	call Random
	cp 3
	ret

.QuickAttackDeck:
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call GetCardIDFromDeckIndex
	cp16 DARK_JOLTEON
	jr z, .dark_jolteon_or_dark_raichu
	cp16 DARK_RAICHU
	jr nz, .no_carry
.dark_jolteon_or_dark_raichu
	call .CheckAttackDoesntKO
	jr nc, .no_carry
	; doesn't KO, check if is usable
	farcall CheckIfSelectedAttackIsUnusable
	jp c, .no_carry
	; is usable, estimate damage
	ld a, [wSelectedAttack]
	farcall EstimateDamage_VersusDefendingCard
	; if min damage is non-0 and can damage Mr. Mime
	; after PlusPower boost, use PlusPower
	ld a, [wAIMinDamage]
	cp 10
	jp c, .no_carry
	call .MrMimeDamageCheck
	jp nc, .no_carry
	scf
	ret

AIPlay_Switch:
	ld a, [wCurrentAIFlags]
	or AI_FLAG_USED_SWITCH
	ld [wCurrentAIFlags], a
	ld a, [wAITrainerCardToPlay]
	ldh [hDuelActionCardIndex], a
	ld a, [wAITrainerCardArgs + 0]
	ldh [hDuelActionArgs + 0], a
	ld a, OPPACTION_EXECUTE_TRAINER_EFFECTS
	farcall AIMakeDecision
	xor a
	ld [wAIRetreatScore], a
	ret

AIDecide_Switch_Phase09:
; check if AI can already play an energy card from hand to retreat
	ld a, [wAIPlayEnergyCardForRetreat]
	or a
	jr z, .asm_20876

; can't play energy card from hand to retreat
; compare number of energy cards attached to retreat cost
	xor a ; PLAY_AREA_ARENA
	ldh [hTempPlayAreaLocation_ff9d], a
	call GetPlayAreaCardRetreatCost
	push af
	xor a ; PLAY_AREA_ARENA
	call CreateArenaOrBenchEnergyCardList
	ld b, a
	pop af
	sub b
	; jump if cards attached > retreat cost
	jr c, .check_status
	cp 2
	; jump if retreat cost is 2 more energy cards
	; than the number of cards attached
	jr nc, .switch
	jr .check_status

.asm_20876
	farcall IswD035Zero
	ret nc
.check_status
	; use Switch if Arena card is statused
	ld a, DUELVARS_ARENA_CARD_STATUS
	get_turn_duelist_var
	and CNF_SLP_PRZ
	jr nz, .switch

	; use Switch if retreat cost is 3 or more
	xor a ; PLAY_AREA_ARENA
	ldh [hTempPlayAreaLocation_ff9d], a
	call GetPlayAreaCardRetreatCost
	cp 3
	jr nc, .switch

	; use Switch if not enough energies for retreat cost
	push af
	xor a ; PLAY_AREA_ARENA
	call CreateArenaOrBenchEnergyCardList
	pop bc
	cp b
	jr c, .switch
	ret

.switch
	farcall AIDecideBenchPokemonToSwitchTo
	ccf
	ret

AIDecide_Switch_Phase16:
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	dec a
	jr z, .no_carry

	farcall IswD035Zero
	ret nc

	ld a, [wOpponentDeckID]
	cp GO_ARCANINE_DECK_ID
	jp z, .GoArcanineDeck
	cp GRAND_FIRE_DECK_ID
	jp z, .GrandFireDeck
	cp LEGENDARY_FOSSIL_DECK_ID
	jp z, .LegendaryFossilDeck
	cp GREAT_DRAGON_DECK_ID
	jp z, .GreatDragonDeck
	cp POISON_MIST_DECK_ID
	jp z, .PoisonMistDeck
	cp ULTRA_REMOVAL_DECK_ID
	jp z, .UltraRemovalDeck
	cp PSYCHIC_BATTLE_DECK_ID
	jp z, .PsychicBattleDeck
	cp STOP_LIFE_DECK_ID
	jp z, .StopLifeDeck
	cp SCORCHER_DECK_ID
	jp z, .ScorcherDeck
	cp TSUNAMI_STARTER_DECK_ID
	jp z, .TsunamiStarterDeck
	cp SMASH_TO_MINCEMEAT_DECK_ID
	jp z, .SmashToMincemeatDeck
	cp POWERFUL_POKEMON_DECK_ID
	jp z, .PowerfulPokemonDeck
	cp EVERYBODYS_FRIEND_DECK_ID
	jp z, .EverybodysFriendDeck
	cp IMMORTAL_POKEMON_DECK_ID
	jp z, .ImmortalPokemonDeck
	cp TORRENTIAL_FLOOD_DECK_ID
	jp z, .TorrentialFloodDeck
	cp  BLAZING_FLAME_DECK_ID
	jp z, .BlazingFlameDeck
.no_carry
	or a
	ret

.switch
	farcall AIDecideBenchPokemonToSwitchTo
	ccf
	ret

.GoArcanineDeck:
	; if Arena card has no status, don't use
	ld a, DUELVARS_ARENA_CARD_STATUS
	get_turn_duelist_var
	or a
	jr z, .no_carry
	; is poisoned, exit if retreat cost is 0
	and POISONED
	jr z, .not_poisoned
	xor a ; PLAY_AREA_ARENA
	ldh [hTempPlayAreaLocation_ff9d], a
	call GetPlayAreaCardRetreatCost
	or a
	ret z
.not_poisoned
	; if is Arcanine, use Switch
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call GetCardIDFromDeckIndex
	cp16 ARCANINE_LV45
	jr z, .switch

	; if defending Pokémon can KO, use Switch
	xor a ; PLAY_AREA_ARENA
	ldh [hTempPlayAreaLocation_ff9d], a
	farcall CheckIfDefendingPokemonCanKnockOut
	jr c, .switch

	; if there's an Arcanine in bench with enough energy, use Switch
	ld de, ARCANINE_LV45
	farcall FindCardIDInBenchWithEnoughEnergy
	ret c
	; if there's a Dewgong in bench with enough energy, use Switch
	ld de, DEWGONG_LV42
	farcall FindCardIDInBenchWithEnoughEnergy
	ret

.GrandFireDeck:
.LegendaryFossilDeck:
	; if Arena card has no status, don't use
	ld a, DUELVARS_ARENA_CARD_STATUS
	get_turn_duelist_var
	or a
	jr z, .no_carry

	; if retreat cost is 2 or more, use Switch
	xor a
	ldh [hTempPlayAreaLocation_ff9d], a
	call GetPlayAreaCardRetreatCost
	cp 2
	jr nc, .switch
	jr .no_carry

.GreatDragonDeck:
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call GetCardIDFromDeckIndex
	cp16 CHARIZARD_LV76
	jr z, .charizard
	cp16 CHARIZARD_ALT_LV76
	jr z, .charizard
	cp16 KANGASKHAN_LV40
	jp nz, .no_carry

; kangaskhan
	; if there's a Charizard in bench with enough energy, use Switch
	ld de, CHARIZARD_LV76
	farcall FindCardIDInBenchWithEnoughEnergy
	ret c
	ld de, CHARIZARD_ALT_LV76
	farcall FindCardIDInBenchWithEnoughEnergy
	ret c
	jp .no_carry

.charizard
	; if Charizard has no status, don't use
	ld a, DUELVARS_ARENA_CARD_STATUS
	get_turn_duelist_var
	or a
	ret z

	; exit if not under an effect that prevents retreat
	bank1call CheckUnableToRetreatDueToEffect
	jp c, .no_carry ; bug, should be jp nc

	; use Switch to switch to a benched Scyther that can attack, if any
	ld a, [wCurrentAIFlags]
	or AI_FLAG_UNK_5
	ld [wCurrentAIFlags], a
	ld de, SCYTHER_LV25
	ld b, PLAY_AREA_BENCH_1
	farcall FindCardIDInTurnDuelistsPlayArea
	jp nc, .switch
	ret

.PoisonMistDeck:
	farcall AIDecide_Switch_PoisonMistDeck
	ret

.UltraRemovalDeck:
	farcall AIDecide_Switch_UltraRemovalDeck
	ret

.PsychicBattleDeck:
	farcall AIDecide_Switch_PsychicBattleDeck
	ret

.StopLifeDeck:
	farcall AIDecide_Switch_StopLifeDeck
	ret

.ScorcherDeck:
	farcall AIDecide_Switch_ScorcherDeck
	ret

.TsunamiStarterDeck:
	farcall AIDecide_Switch_TsunamiStarterDeck
	ret

.SmashToMincemeatDeck:
	farcall AIDecide_Switch_SmashToMincemeatDeck
	ret

.PowerfulPokemonDeck:
	farcall AIDecide_Switch_PowerfulPokemonDeck
	ret

.EverybodysFriendDeck:
	farcall AIDecide_Switch_EverybodysFriendDeck
	ret

.ImmortalPokemonDeck:
	farcall AIDecide_Switch_ImmortalPokemonDeck
	ret

.TorrentialFloodDeck:
	farcall AIDecide_Switch_TorrentialFloodDeck
	ret

.BlazingFlameDeck:
	farcall AIDecide_Switch_BlazingFlameDeck
	ret

AIPlay_GustOfWind:
	ld a, [wCurrentAIFlags]
	or AI_FLAG_USED_GUST_OF_WIND
	ld [wCurrentAIFlags], a
	ld a, [wAITrainerCardToPlay]
	ldh [hDuelActionCardIndex], a
	ld a, [wAITrainerCardArgs + 0]
	ldh [hDuelActionArgs + 0], a
	ld a, OPPACTION_EXECUTE_TRAINER_EFFECTS
	farcall AIMakeDecision
	ret

AIDecide_GustOfWind:
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	call GetNonTurnDuelistVariable
	dec a
	ret z ; no bench cards

; if used Gust Of Wind already,
; do not use it again.
	ld a, [wPreviousAIFlags]
	and AI_FLAG_USED_GUST_OF_WIND
	ret nz

	; a = PLAY_AREA_ARENA
	farcall CanArenaCardUseNonResidualAttack
	ret nc ; cannot use non-residual attack

	farcall CheckIfArenaCardCanKnockOutDefendingCard_CheckHand
	jr c, .no_carry ; Arena can KO

	ld a, [wOpponentDeckID]
	cp STOP_LIFE_DECK_ID
	jp z, .StopLifeDeck
	cp TSUNAMI_STARTER_DECK_ID
	jp z, .TsunamiStarterDeck
	cp SMASH_TO_MINCEMEAT_DECK_ID
	jp z, .SmashToMincemeatDeck

	; don't consider switching if Mew lv23
	; or Mewtwo lv53 is the Arena card
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call GetCardIDFromDeckIndex
	cp16 MEW_LV23
	jr z, .no_carry
	cp16 MEWTWO_LV53
	jr z, .no_carry

	call FindBenchCardThatCanBeKnockedOut
	ret c ; found card to switch in Bench

	ld a, [wOpponentDeckID]
	cp POISON_MIST_DECK_ID
	jp z, .PoisonMistDeck
	cp ULTRA_REMOVAL_DECK_ID
	jp z, .UltraRemovalDeck
	cp PSYCHIC_BATTLE_DECK_ID
	jp z, .PsychicBattleDeck

	xor a ; PLAY_AREA_ARENA
	ldh [hTempPlayAreaLocation_ff9d], a
	call .CheckIfArenaCardCanPotentiallyDamageDefendingCard
	jr c, .check_bench_energy ; Arena card cannot damage

	; skip if current arena card's color is
	; the defending card's weakness
	bank1call GetArenaCardColor
	call TranslateColorToWR
	ld b, a
	call SwapTurn
	bank1call GetArenaCardWeakness
	call SwapTurn
	and b
	jr nz, .no_carry

; check weakness
	call .FindBenchCardWithWeakness
	ret nc ; no bench card weak to arena card
	scf
	ret ; found bench card weak to arena card

.no_carry
	or a
	ret

; being here means AI's arena card cannot damage player's arena card

; first check if there is a card in player's bench that
; has no attached energy cards and that the AI can damage
.check_bench_energy
	; return carry if there's a bench card with weakness
	call .FindBenchCardWithWeakness
	ret c

	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	call GetNonTurnDuelistVariable
	ld d, a
	ld e, PLAY_AREA_BENCH_1 - 1
; loop through bench and check attached energy cards
.loop_1
	inc e
	dec d
	jr z, .check_bench_hp
	call SwapTurn
	call GetPlayAreaCardAttachedEnergies
	call SwapTurn
	ld a, [wTotalAttachedEnergies]
	or a
	jr nz, .loop_1 ; skip if has energy attached
	call CheckIfCanDamageBenchedCard
	jr nc, .loop_1
	ld a, e
	scf
	ret

.check_bench_hp
	ld a, $ff
	ld [wd082], a
	xor a
	ld [wd084], a
	ld e, a
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	call GetNonTurnDuelistVariable
	ld d, a

; find bench card with least amount of available HP
.loop_2
	inc e
	dec d
	jr z, .check_found
	ld a, e
	add DUELVARS_ARENA_CARD_HP
	call GetNonTurnDuelistVariable
	ld b, a
	ld a, [wd082]
	inc b
	cp b
	jr c, .loop_2
	call CheckIfCanDamageBenchedCard
	jr nc, .loop_2
	dec b
	ld a, b
	ld [wd082], a
	ld a, e
	ld [wd084], a
	jr .loop_2

.check_found
	ld a, [wd084]
	or a
	jr z, .no_carry
; a card was found
	scf
	ret

.check_can_damage
	push bc
	push hl
	xor a ; PLAY_AREA_ARENA
	farcall CheckIfCanDamageDefendingPokemon
	pop hl
	pop bc
	jr nc, .loop_bench
	ld a, c
	scf
	ret

; returns carry if any of the player's
; benched cards is weak to color in b
; and has a way to damage it
.FindBenchCardWithWeakness:
	ld a, DUELVARS_BENCH
	call GetNonTurnDuelistVariable
	ld c, PLAY_AREA_BENCH_1 - 1
.loop_bench
	inc c
	ld a, [hli]
	cp $ff
	jr z, .no_carry
	call SwapTurn
	call LoadCardDataToBuffer1_FromDeckIndex
	call SwapTurn
	ld a, [wLoadedCard1Weakness]
	and b
	jr nz, .check_can_damage
	jr .loop_bench

.PoisonMistDeck:
	farcall AIDecide_GustOfWind_PoisonMistDeck
	ret

.UltraRemovalDeck:
	farcall AIDecide_GustOfWind_UltraRemovalDeck
	ret

.PsychicBattleDeck:
	farcall AIDecide_GustOfWind_PsychicBattleDeck
	ret nc
	cp $ff
	jp z, .check_bench_energy
	scf
	ret

.StopLifeDeck:
	farcall AIDecide_GustOfWind_StopLifeDeck
	ret

.TsunamiStarterDeck:
	farcall AIDecide_GustOfWind_TsunamiStarterDeck
	ret

.SmashToMincemeatDeck:
	farcall AIDecide_GustOfWind_SmashToMincemeatDeck
	ret

; returns nc if Arena card can potentially damage
; the current Defending card
.CheckIfArenaCardCanPotentiallyDamageDefendingCard:
	xor a ; FIRST_ATTACK_OR_PKMN_POWER
	ld [wSelectedAttack], a
	call .CheckIfCanPotentiallyDamage
	jr c, .second_attack
	ret
.second_attack
	ld a, SECOND_ATTACK
	ld [wSelectedAttack], a
	call .CheckIfCanPotentiallyDamage
	jr c, .cannot_damage
	ret
.cannot_damage
	scf
	ret

.CheckIfCanPotentiallyDamage:
	ld a, [wSelectedAttack]
	ld e, a
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	ld d, a
	call CopyAttackDataAndDamage_FromDeckIndex
	ld a, [wLoadedAttackCategory]
	cp POKEMON_POWER
	jr z, .is_pkmn_power
	ld a, ATTACK_FLAG2_ADDRESS | NULLIFY_OR_WEAKEN_ATTACK_F
	call CheckLoadedAttackFlag
	jr c, .nullify_or_weaken_atk
	ld a, [wDamage]
	or a
	ret z ; no damage
.nullify_or_weaken_atk
	ld a, [wSelectedAttack]
	farcall EstimateDamage_VersusDefendingCard
	ld a, [wAIMaxDamage]
	or a
	ret nz ; can damage
.is_pkmn_power
	; cannot damage or is Pkmn Power
	scf
	ret

; returns carry if there is a player's bench card that
; the opponent's current active card can KO
FindBenchCardThatCanBeKnockedOut:
	ld a, DUELVARS_BENCH
	call GetNonTurnDuelistVariable
	ld e, PLAY_AREA_BENCH_1

.loop
	ld a, [hli]
	cp $ff
	ret z

; overwrite the player's active card and its HP
; with the current bench card that is being checked
	push hl
	push de
	ld b, a
	ld a, DUELVARS_ARENA_CARD
	call GetNonTurnDuelistVariable
	push af
	ld [hl], b ; temporarily replace Arena card
	ld a, e
	add DUELVARS_ARENA_CARD_HP
	call GetNonTurnDuelistVariable
	ld b, a
	ld a, DUELVARS_ARENA_CARD_HP
	call GetNonTurnDuelistVariable
	push af
	ld [hl], b ; temporarily replace Arena card HP

	xor a ; PLAY_AREA_ARENA
	ldh [hTempPlayAreaLocation_ff9d], a
	call CheckIfAnyAttackCanKO
	jr nc, .next_bench_card
	farcall CheckIfSelectedAttackIsUnusable
	jr nc, .can_potentially_ko
	farcall LookForEnergyNeededForAttackInHand
	jr c, .can_potentially_ko

; the following two local routines can be condensed into one
; since they both revert the player's arena card
.next_bench_card
	ld a, DUELVARS_ARENA_CARD_HP
	call GetNonTurnDuelistVariable
	pop af
	ld [hl], a
	ld a, DUELVARS_ARENA_CARD
	call GetNonTurnDuelistVariable
	pop af
	ld [hl], a
	pop de
	inc e
	pop hl
	jr .loop

.can_potentially_ko
	ld a, DUELVARS_ARENA_CARD_HP
	call GetNonTurnDuelistVariable
	pop af
	ld [hl], a
	ld a, DUELVARS_ARENA_CARD
	call GetNonTurnDuelistVariable
	pop af
	ld [hl], a
	pop de
	ld a, e
	pop hl
	scf
	ret

; e = PLAY_AREA_* constant
CheckIfAnyAttackCanKO:
	xor a ; FIRST_ATTACK_OR_PKMN_POWER
	call .CheckIfAttackCanKO
	ret c
	ld a, SECOND_ATTACK
.CheckIfAttackCanKO:
	push de
	farcall EstimateDamage_VersusDefendingCard
	pop de
	ld a, DUELVARS_ARENA_CARD_HP
	add e
	call GetNonTurnDuelistVariable
	ld hl, wDamage
	sub [hl]
	ret c ; can KO
	ret nz ; cannot KO
	; can KO
	scf
	ret

CheckIfCanDamageBenchedCard:
	push bc
	push de
	push hl
	ld a, e
	add DUELVARS_ARENA_CARD
	call GetNonTurnDuelistVariable
	ld b, a
	ld a, DUELVARS_ARENA_CARD
	call GetNonTurnDuelistVariable
	push af
	ld [hl], b ; temporarily replace Arena card
	ld a, e
	add DUELVARS_ARENA_CARD_HP
	call GetNonTurnDuelistVariable
	ld b, a
	ld a, DUELVARS_ARENA_CARD_HP
	call GetNonTurnDuelistVariable
	push af
	ld [hl], b ; temporarily replace Arena card HP
	xor a ; PLAY_AREA_ARENA
	farcall CheckIfCanDamageDefendingPokemon
	jr c, .return_with_carry
; return with no carry
	ld a, DUELVARS_ARENA_CARD_HP
	call GetNonTurnDuelistVariable
	pop af
	ld [hl], a
	ld a, DUELVARS_ARENA_CARD
	call GetNonTurnDuelistVariable
	pop af
	ld [hl], a
	pop hl
	pop de
	pop bc
	or a
	ret
.return_with_carry
	ld a, DUELVARS_ARENA_CARD_HP
	call GetNonTurnDuelistVariable
	pop af
	ld [hl], a
	ld a, DUELVARS_ARENA_CARD
	call GetNonTurnDuelistVariable
	pop af
	ld [hl], a
	pop hl
	pop de
	pop bc
	scf
	ret

AIPlay_Bill:
	ld a, [wAITrainerCardToPlay]
	ldh [hDuelActionCardIndex], a
	ld a, OPPACTION_EXECUTE_TRAINER_EFFECTS
	farcall AIMakeDecision
	ret

; return carry if cards in deck > 11
AIDecide_Bill:
	ld a, DUELVARS_NUMBER_OF_CARDS_NOT_IN_DECK
	get_turn_duelist_var
	cp DECK_SIZE - 11
	ret

AIPlay_EnergyRemoval:
	ld a, [wAITrainerCardToPlay]
	ldh [hDuelActionCardIndex], a
	ld a, [wAITrainerCardArgs + 0]
	ldh [hDuelActionArgs + 0], a
	ld a, [wAITrainerCardArgs + 1]
	ldh [hDuelActionArgs + 1], a
	ld a, OPPACTION_EXECUTE_TRAINER_EFFECTS
	farcall AIMakeDecision
	ret

AIDecide_EnergyRemoval:
	ld a, [wOpponentDeckID]
	cp ELECTRIC_SELFDESTRUCT_DECK_ID
	jp z, .ElectricSelfdestructDeck
	cp QUICK_ATTACK_DECK_ID
	jp z, .QuickAttackDeck
	cp FIREBALL_DECK_ID
	jp z, .FireballDeck
	cp WHIRLPOOL_SHOWER_DECK_ID
	jp z, .WhirlpoolShowerDeck
	cp RUNNING_WILD_DECK_ID
	jp z, .RunningWildDeck
	cp SPIRITED_AWAY_DECK_ID
	jp z, .SpiritedAwayDeck
	cp BIG_THUNDER_DECK_ID
	jp z, .BigThunderDeck

	farcall CheckIfArenaCardCanKnockOutDefendingCard_CheckHand
	jr nc, .cannot_ko

	; start checking from the bench
	ld a, PLAY_AREA_BENCH_1
	ld [wTempAITargetPokemonCardDeckIndex], a
	jr .check_bench_energy
.cannot_ko
	; start checking from the arena card
	xor a ; PLAY_AREA_ARENA
	ld [wTempAITargetPokemonCardDeckIndex], a

; loop each card and check if it has enough energy to use any attack
; if it does, then proceed to pick an energy card to remove
.check_bench_energy
	call SwapTurn
	ld a, [wTempAITargetPokemonCardDeckIndex]
	ld e, a
.loop_1
	ld a, DUELVARS_ARENA_CARD
	add e
	get_turn_duelist_var
	cp $ff
	jr z, .default

	ld d, a
	call .CheckIfHasAnyEnergyCardTargets
	jr nc, .next_1
	call .CheckIfNotEnoughEnergyToAttack
	jr nc, .pick_energy ; jump if enough energy to attack
.next_1
	inc e
	jr .loop_1

.pick_energy
; a play area card was picked to remove energy
; store the picked energy card to remove in wAITrainerCardArgs[1]
; and set carry
	ld a, e
	push af
	farcall PickAttachedEnergyCardToRemove
	ld [wAITrainerCardArgs + 1], a
	pop af
	call SwapTurn
	scf
	ret

; if no card in player's Play Area was found with enough energy
; to attack, just pick an energy card from player's active card
; (in case the AI cannot KO it this turn)
.default
	ld a, [wTempAITargetPokemonCardDeckIndex]
	or a
	jr nz, .check_bench_damage ; not active card
	call .CheckIfHasAnyEnergyCardTargets
	jr c, .pick_energy

; lastly, check what attack on player's Play Area is highest damaging
; and pick an energy card attached to that Pokemon to remove
.check_bench_damage
	xor a
	ld [wd082], a
	ld [wd084], a
	ld e, PLAY_AREA_BENCH_1
.loop_2
	ld a, DUELVARS_ARENA_CARD
	add e
	get_turn_duelist_var
	cp $ff
	jr z, .found_damage

	ld d, a
	call .CheckIfHasAnyEnergyCardTargets
	jr nc, .next_2
	call .FindHighestDamagingAttack
.next_2
	inc e
	jr .loop_2

.found_damage
	ld a, [wd084]
	or a
	jr z, .no_carry ; skip if none found
	ld e, a
	jr .pick_energy
.no_carry
	call SwapTurn
	or a
	ret

; returns carry if this card has any energy cards attached
.CheckIfHasAnyEnergyCardTargets:
	farcall CountEnergyRemovalEnergyCardTargets
	or a
	ret z ; no targets
	scf
	ret

.CheckIfNotEnoughEnergyToAttack:
	push de
	xor a ; FIRST_ATTACK_OR_PKMN_POWER
	ld [wSelectedAttack], a
	ld a, e
	ldh [hTempPlayAreaLocation_ff9d], a
	farcall CheckEnergyNeededForAttack
	jr nc, .enough_energy
	pop de

	push de
	ld a, SECOND_ATTACK
	ld [wSelectedAttack], a
	ld a, e
	ldh [hTempPlayAreaLocation_ff9d], a
	farcall CheckEnergyNeededForAttack
	jr nc, .check_surplus
	pop de

; neither attack has enough energy
	scf
	ret

.enough_energy
	pop de
	or a
	ret

; first attack doesn't have enough energy (or is just a Pokemon Power)
; but second attack has enough energy to be used
; check if there's surplus energy for attack and, if so, return carry
.check_surplus
	farcall CanRemovingEnergyReduceDamage
	pop de
	ccf
	ret

; stores in wd082 the highest damaging attack
; for the card in play area location in e
; and stores this card's location in wd084
.FindHighestDamagingAttack:
	push de
	ld a, e
	ldh [hTempPlayAreaLocation_ff9d], a

	xor a ; FIRST_ATTACK_OR_PKMN_POWER
	farcall EstimateDamage_VersusDefendingCard
	ld a, [wDamage]
	or a
	jr z, .skip_1
	ld e, a
	ld a, [wd082]
	cp e
	jr nc, .skip_1
	ld a, e
	ld [wd082], a ; store this damage value
	pop de
	ld a, e
	ld [wd084], a ; store this location
	jr .second_attack

.skip_1
	pop de

.second_attack
	push de
	ld a, e
	ldh [hTempPlayAreaLocation_ff9d], a

	ld a, SECOND_ATTACK
	farcall EstimateDamage_VersusDefendingCard
	ld a, [wDamage]
	or a
	jr z, .skip_2
	ld e, a
	ld a, [wd082]
	cp e
	jr nc, .skip_2
	ld a, e
	ld [wd082], a ; store this damage value
	pop de
	ld a, e
	ld [wd084], a ; store this location
	ret
.skip_2
	pop de
	ret

.ElectricSelfdestructDeck:
	; if can KO player's Arena card, start in Bench
	farcall CheckIfArenaCardCanKnockOutDefendingCard_CheckHand
	jr c, .asm_20d74
	; otherwise start from Arena
	xor a ; PLAY_AREA_ARENA
	jr .asm_20d76
.asm_20d74
	ld a, PLAY_AREA_BENCH_1
.asm_20d76
	ld c, a
	ld [wd082], a

	; try to find a Pokémon with Double Colorless first
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	call GetNonTurnDuelistVariable
	ld b, a
.asm_20d80
	ld a, c
	cp b
	jr z, .asm_20d9d
	push bc
	call SwapTurn
	ld b, $00 ; unused
	farcall FindDoubleColorlessAttachedToCard
	call SwapTurn
	pop bc
	jr c, .dce_found
	inc c
	jr .asm_20d80
.dce_found
	; found, target it
	ld [wAITrainerCardArgs + 1], a
	ld a, c
	scf
	ret

.asm_20d9d
	; did we start in the Arena?
	ld a, [wd082]
	or a
	ret nz
	; yes, then check if Arena card has at least 2 energy cards to discard
	ld e, PLAY_AREA_ARENA
	call SwapTurn
	farcall CountEnergyRemovalEnergyCardTargets
	call SwapTurn
	cp 2
	ccf
	ret nc
	; has >= 2 target energies
	ld a, DUELVARS_ARENA_CARD_HP
	call GetNonTurnDuelistVariable
	ld b, a
	push bc
	ld a, DUELVARS_ARENA_CARD
	call GetNonTurnDuelistVariable
	call SwapTurn
	call LoadCardDataToBuffer1_FromDeckIndex
	call SwapTurn
	ld a, [wLoadedCard1HP]
	farcall ConvertHPToCounters
	pop bc
	call CalculateBDividedByA_Bank08
	; a = (hp / total hp) * 10
	cp 8 ; 80%
	ccf
	ret nc
	; has >= 80% max HP
	call SwapTurn
	xor a ; PLAY_AREA_ARENA
	farcall PickAttachedEnergyCardToRemove
	call SwapTurn
	ld [wAITrainerCardArgs + 1], a
	xor a
	scf
	ret

.QuickAttackDeck:
.RunningWildDeck:
	; if can KO player's Arena card, start from Bench
	farcall CheckIfArenaCardCanKnockOutDefendingCard_CheckHand
	ld b, PLAY_AREA_BENCH_1
	jr c, .asm_20df1
	; otherwise start from Arena card
	ld b, PLAY_AREA_ARENA
.asm_20df1
	; try to find a DCE, and if it is found, target it
	farcall FindDoubleColorlessAttachedToPlayerPokemonInPlayArea
	jr c, .asm_20e36

	; none found, if can KO Arena, exit now
	farcall CheckIfArenaCardCanKnockOutDefendingCard_CheckHand
	jr nc, .asm_20dff
.asm_20dfd
	or a
	ret
.asm_20dff
	; does player's Arena card have energy cards to remove?
	ld e, PLAY_AREA_ARENA
	call SwapTurn
	farcall CountEnergyRemovalEnergyCardTargets
	call SwapTurn
	or a
	ret z
	; yes, is it over half HP?
	call SwapTurn
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call LoadCardDataToBuffer2_FromDeckIndex
	ld a, [wLoadedCard2HP]
	ld b, a ; max HP
	ld a, DUELVARS_ARENA_CARD_HP
	get_turn_duelist_var
	call SwapTurn
	sla a ; double it
	cp b
	jr c, .asm_20dfd
	; has at least 50% max HP
	call SwapTurn
	xor a ; PLAY_AREA_ARENA
	farcall PickAttachedEnergyCardToRemove
	call SwapTurn
	ld [wAITrainerCardArgs + 1], a
	xor a
	scf
	ret
.asm_20e36
	ld [wAITrainerCardArgs + 1], a
	ld a, b
	scf
	ret

.FireballDeck:
	; only consider player's Arena card, so if
	; AI can KO it, then don't use
	farcall CheckIfArenaCardCanKnockOutDefendingCard_CheckHand
	jr nc, .asm_20e44
.asm_20e42
	or a
	ret
.asm_20e44
	; does player's Arena card have energy cards to remove?
	ld e, PLAY_AREA_ARENA
	call SwapTurn
	farcall CountEnergyRemovalEnergyCardTargets
	call SwapTurn
	or a
	ret z

	; yes, check its damage output
	xor a ; PLAY_AREA_ARENA
	ldh [hTempPlayAreaLocation_ff9d], a
	; a = FIRST_ATTACK_OR_PKMN_POWER
	call .Func_20e72
	jr c, .asm_20e61
	ld a, SECOND_ATTACK
	call .Func_20e72
	jr c, .asm_20e42

.asm_20e61
	call SwapTurn
	xor a ; PLAY_AREA_ARENA
	farcall PickAttachedEnergyCardToRemove
	call SwapTurn
	ld [wAITrainerCardArgs + 1], a
	xor a
	scf
	ret

; returns carry if player's Arena card can deal 50 or more damage
; and removing energy would reduce or prevent that damage
.Func_20e72:
	ld [wSelectedAttack], a
	call SwapTurn
	farcall EstimateDamage_VersusDefendingCard
	ld a, [wDamage]
	cp 50
	jr c, .under_50_damage
	farcall CanRemovingEnergyReduceDamage
	call SwapTurn
	ret
.under_50_damage
	call SwapTurn
	or a
	ret

.WhirlpoolShowerDeck:
	; only consider player's Arena card, so if
	; AI can KO it, then don't use
	farcall CheckIfArenaCardCanKnockOutDefendingCard_CheckHand
	jr nc, .asm_20e98
	or a
	ret
.asm_20e98
	; does player's Arena card have energy cards to remove?
	ld e, PLAY_AREA_ARENA
	call SwapTurn
	farcall CountEnergyRemovalEnergyCardTargets
	call SwapTurn
	or a
	ret z

	; yes, check AI's Arena card
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call GetCardIDFromDeckIndex
	cp16 DARK_VAPOREON
	jr z, .dark_vaporeon_or_dark_starmie
	cp16 DARK_STARMIE
	jr nz, .not_dark_vaporeon_or_dark_starmie
.dark_vaporeon_or_dark_starmie
	; has Dark Vaporeon or Dark Starmie as Arena Pokémon
	; if its second attack is usable already, exit
	xor a
	ldh [hTempPlayAreaLocation_ff9d], a
	ld a, SECOND_ATTACK
	ld [wSelectedAttack], a
	farcall CheckIfSelectedAttackIsUnusable
	ret nc
.not_dark_vaporeon_or_dark_starmie
	; just pick a card to discard
	call SwapTurn
	xor a ; PLAY_AREA_ARENA
	farcall PickAttachedEnergyCardToRemove
	call SwapTurn
	ld [wAITrainerCardArgs + 1], a
	xor a
	scf
	ret

.SpiritedAwayDeck:
	; only consider player's Arena card, so if
	; AI can KO it, then don't use
	farcall CheckIfArenaCardCanKnockOutDefendingCard_CheckHand
	jr nc, .asm_20ee6
	or a
	ret
.asm_20ee6
	; does player's Arena card have energy cards to remove?
	ld e, PLAY_AREA_ARENA
	call SwapTurn
	farcall CountEnergyRemovalEnergyCardTargets
	call SwapTurn
	or a
	ret z

	; yes, pick one to discard
	call SwapTurn
	xor a
	farcall PickAttachedEnergyCardToRemove
	call SwapTurn
	ld [wAITrainerCardArgs + 1], a
	xor a
	scf
	ret

.BigThunderDeck:
	farcall AIDecide_EnergyRemoval_BigThunderDeck
	ret

AIPlay_SuperEnergyRemoval:
	ld a, [wAITrainerCardToPlay]
	ldh [hDuelActionCardIndex], a
	ld a, [wAITrainerCardArgs + 0]
	ldh [hDuelActionArgs + 0], a
	ld a, [wAITrainerCardArgs + 1]
	ldh [hDuelActionArgs + 1], a
	ld a, [wAITrainerCardArgs + 2]
	ldh [hDuelActionArgs + 2], a
	ld a, [wAITrainerCardArgs + 3]
	ldh [hDuelActionArgs + 3], a
	ld a, [wAITrainerCardArgs + 4]
	ldh [hDuelActionArgs + 4], a
	ld a, $ff
	ldh [hDuelActionArgs + 5], a
	ld a, OPPACTION_EXECUTE_TRAINER_EFFECTS
	farcall AIMakeDecision
	ret

AIDecide_SuperEnergyRemoval:
	ld e, PLAY_AREA_BENCH_1
.loop_1
; first find a Pokémon in Play Area card with an energy card
; to discard for card effect (any energy except Rainbow and Double Colorless)
; return immediately if none found
	ld a, DUELVARS_ARENA_CARD
	add e
	get_turn_duelist_var
	cp $ff
	jr z, .exit

	ld d, a
	push de
	call .LookForNonRainbowAndNonDoubleColorless
	pop de
	jr c, .found_energy_card
	inc e
	jr .loop_1

; returns carry if an energy card other than Rainbow or Double Colorless
; is found attached to the card in play area location e
.LookForNonRainbowAndNonDoubleColorless:
	ld a, e
	call CreateArenaOrBenchEnergyCardList
	ld hl, wDuelTempList
.loop_2
	ld a, [hli]
	cp $ff
	ret z
	call GetCardIDFromDeckIndex
	cp16 RAINBOW_ENERGY
	jr z, .loop_2
	cp16 DOUBLE_COLORLESS_ENERGY
	jr z, .loop_2
	scf
	ret
.exit
	or a
	ret

; card in Play Area location e was found
.found_energy_card
	ld a, e
	ld [wTempAITargetPokemonCardDeckIndex], a

; check if the current active card can KO player's card
; if it's possible to KO, then do not consider the player's
; active card to remove its attached energy
	farcall CheckIfArenaCardCanKnockOutDefendingCard_CheckHand
	jr nc, .cannot_ko
	call SwapTurn
	ld e, PLAY_AREA_BENCH_1
	jr .loop_3
.cannot_ko
	call SwapTurn
	ld e, PLAY_AREA_ARENA

; loop each card and check if it has enough energy to use any attack
; if it does, then proceed to pick energy cards to remove
.loop_3
	ld a, DUELVARS_ARENA_CARD
	add e
	get_turn_duelist_var
	cp $ff
	jr z, .no_carry
	ld d, a
	call .CheckIfFewerThanTwoEnergyCards
	jr c, .next_1
	call .CheckIfNotEnoughEnergyToAttack
	jr nc, .found_card ; jump if enough energy to attack
.next_1
	inc e
	jr .loop_3

.found_card
; a play area card was picked to remove energy
; if this is not the Arena Card, then check
; entire bench to pick the highest damage
	ld a, e
	or a
	jr nz, .check_bench_damage

; store the picked energy card to remove in wAITrainerCardArgs[1]
; and set carry
.pick_energy
	ld [wAITrainerCardArgs + 2], a
	farcall PickTwoAttachedEnergyCards
	ld [wAITrainerCardArgs + 3], a
	ld a, b
	ld [wAITrainerCardArgs + 4], a
	call SwapTurn
	ld a, [wTempAITargetPokemonCardDeckIndex]
	push af
	farcall AIPickEnergyCardToDiscard
	ld [wAITrainerCardArgs + 1], a
	pop af
	scf
	ret

; check what attack on player's Play Area is highest damaging
; and pick an energy card attached to that Pokemon to remove
.check_bench_damage
	xor a
	ld [wd082], a
	ld [wd084], a
	ld e, PLAY_AREA_BENCH_1
.loop_4
	ld a, DUELVARS_ARENA_CARD
	add e
	get_turn_duelist_var
	cp $ff
	jr z, .found_damage

	ld d, a
	call .CheckIfFewerThanTwoEnergyCards
	jr c, .next_2
	call .CheckIfNotEnoughEnergyToAttack
	jr c, .next_2
	call .FindHighestDamagingAttack
.next_2
	inc e
	jr .loop_4

.found_damage
	ld a, [wd084]
	or a
	jr z, .no_carry
	jr .pick_energy
.no_carry
	call SwapTurn
	or a
	ret

; returns carry if the number of energy cards attached
; is fewer than 2, or if all energy combined yields
; fewer than 2 energy
.CheckIfFewerThanTwoEnergyCards:
	call GetPlayAreaCardAttachedEnergies
	ld a, [wTotalAttachedEnergies]
	cp 2
	ret c ; return if fewer than 2 attached cards

; count all energy attached
; i.e. colored energy card = 1
; and double colorless energy card = 2
	xor a
	ld b, NUM_COLORED_TYPES
	ld hl, wAttachedEnergies
.loop_5
	add [hl]
	inc hl
	dec b
	jr nz, .loop_5
	; bug, this is copied straight from TCG1, where the only way
	; to have colorless energies is from Double Colorless Energy
	; but in TCG2 there are other cards that provide a single colorless energy
	ld b, [hl] ; colorless
	srl b
	add b
	cp 2
	ret

; returns carry if this card does not
; have enough energy for either of its attacks
.CheckIfNotEnoughEnergyToAttack:
	push de
	xor a ; FIRST_ATTACK_OR_PKMN_POWER
	ld [wSelectedAttack], a
	ld a, e
	ldh [hTempPlayAreaLocation_ff9d], a
	farcall CheckEnergyNeededForAttack
	jr nc, .enough_energy
	pop de

	push de
	ld a, SECOND_ATTACK
	ld [wSelectedAttack], a
	ld a, e
	ldh [hTempPlayAreaLocation_ff9d], a
	farcall CheckEnergyNeededForAttack
	jr nc, .check_surplus
	pop de

; neither attack has enough energy
	scf
	ret

.enough_energy
	pop de
	or a
	ret

; first attack doesn't have enough energy (or is just a Pokemon Power)
; but second attack has enough energy to be used
; check if there's surplus energy for attack and, if so,
; return carry if this surplus energy is at least 2
.check_surplus
	farcall CanRemovingEnergyReduceDamage
	cp 2
	jr c, .enough_energy
	pop de
	scf
	ret

; stores in wd082 the highest damaging attack
; for the card in play area location in e
; and stores this card's location in wd084
.FindHighestDamagingAttack:
	push de
	ld a, e
	ldh [hTempPlayAreaLocation_ff9d], a

	xor a ; FIRST_ATTACK_OR_PKMN_POWER
	farcall EstimateDamage_VersusDefendingCard
	ld a, [wDamage]
	or a
	jr z, .skip_1
	ld e, a
	ld a, [wd082]
	cp e
	jr nc, .skip_1
	ld a, e
	ld [wd082], a ; store this damage value
	pop de
	ld a, e
	ld [wd084], a ; store this location
	jr .second_attack

.skip_1
	pop de

.second_attack
	push de
	ld a, e
	ldh [hTempPlayAreaLocation_ff9d], a

	ld a, SECOND_ATTACK
	farcall EstimateDamage_VersusDefendingCard
	ld a, [wDamage]
	or a
	jr z, .skip_2
	ld e, a
	ld a, [wd082]
	cp e
	jr nc, .skip_2
	ld a, e
	ld [wd082], a ; store this damage value
	pop de
	ld a, e
	ld [wd084], a ; store this location
	ret
.skip_2
	pop de
	ret

AIPlay_PokemonBreeder:
	ld a, [wAITrainerCardToPlay]
	ldh [hDuelActionCardIndex], a
	ld a, [wAITrainerCardArgs + 0]
	ldh [hDuelActionArgs + 1], a
	ld a, [wAITrainerCardArgs + 1]
	ldh [hDuelActionArgs + 0], a
	ld a, OPPACTION_EXECUTE_TRAINER_EFFECTS
	farcall AIMakeDecision
	ld a, [wcd15]
	cp $ff
	ret z
	ldh [hDuelActionCardIndex], a
	ld [wTempAIPokemonCard], a
	ld a, [wAITrainerCardArgs + 0]
	ldh [hDuelActionArgs + 0], a
	ld a, OPPACTION_PROCESS_PLAYED_PKMN
	farcall AIMakeDecision
	ld a, [wcd18]
	or a
	ret z
	farcall AIHandlePkmnPowersWhenPlayingPkmnFromHand
	ld a, OPPACTION_PROCESS_TRIGGERED_PKMN_POWER
	farcall AIMakeDecision
	ret

AIDecide_PokemonBreeder:
	bank1call IsPrehistoricPowerActive
	jp c, .dont_use

	ld a, [wOpponentDeckID]
	cp GREAT_DRAGON_DECK_ID
	jp z, .GreatDragonDeck
	cp MAD_PETALS_DECK_ID
	jp z, .MadPetalsDeck
	cp ROCK_BLAST_DECK_ID
	jp z, .RockBlastDeck
	cp BAD_DREAM_DECK_ID
	jp z, .BadDreamDeck
	cp SPIRITED_AWAY_DECK_ID
	jp z, .SpiritedAwayDeck
	cp IMMORTAL_POKEMON_DECK_ID
	jp z, .ImmortalPokemonDeck
	cp TORRENTIAL_FLOOD_DECK_ID
	jp z, .TorrentialFloodDeck

	ld a, 7
	ld hl, wd084
	farcall ClearNBytesFromHL

	xor a
	ld [wd082], a
	call CreateHandCardList
	ld hl, wDuelTempList
.loop_hand_1
	ld a, [hli]
	cp $ff
	jp z, .not_found_in_hand

; check if card in hand is any of the following
; stage 2 Pokemon cards
	ld d, a
	push de
	call GetCardIDFromDeckIndex
	cp16 VENUSAUR_LV64
	jr z, .found
	cp16 VENUSAUR_LV67
	jr z, .found
	cp16 BLASTOISE_LV52
	jr z, .found
	cp16 VILEPLUME
	jr z, .found
	cp16 ALAKAZAM_LV42
	jr z, .found
	cp16 GENGAR_LV38
	jr z, .found
	pop de
	jr .loop_hand_1

.found
	pop de
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	push hl
	get_turn_duelist_var
	pop hl
	ld c, a
	ld e, PLAY_AREA_ARENA

; check Play Area for card that can evolve into
; the picked stage 2 Pokemon
.loop_play_area_1
	push hl
	push bc
	push de
	call CheckIfCanEvolveInto_BasicToStage2
	pop de
	call nc, .CalculateFitness
	pop bc
	pop hl
	inc e
	dec c
	jr nz, .loop_play_area_1
	jr .loop_hand_1

; calculates a fitness score for this Pokémon
; formula is ((remaining HP) << 4) | (energies attached)
; (this means that the main characteristic to compare with other
; candidates is remaining HP, and the number of energy cards
; are used to break a tie)
.CalculateFitness:
	ld a, DUELVARS_ARENA_CARD_HP
	add e
	get_turn_duelist_var
	farcall ConvertHPToCounters
	swap a
	ld b, a

; count number of energy cards attached and keep
; the lowest 4 bits (capped at 15)
	call GetPlayAreaCardAttachedEnergies
	ld a, [wTotalAttachedEnergies]
	cp 16
	jr c, .not_maxed_out
	ld a, 15
.not_maxed_out
	or b

; 4 high bits of a = HP counters Pokemon still has
; 4 low  bits of a = number of energy cards attached

; store this score in wd084 + PLAY_AREA*
	ld hl, wd084
	ld c, e
	ld b, $00
	add hl, bc
	ld [hl], a

; store the deck index of stage 2 Pokemon in wTempAITargetPokemonCardDeckIndex + PLAY_AREA*
	ld hl, wTempAITargetPokemonCardDeckIndex
	add hl, bc
	ld [hl], d

; increase wd082 by one
	ld hl, wd082
	inc [hl]
	ret

.not_found_in_hand
	ld a, [wd082]
	or a
	jr z, .check_evolution_and_dragonite

; an evolution has been found before
	xor a
	ld [wd082], a
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	ld c, a
	ld e, PLAY_AREA_ARENA
	ld d, $00

; find highest score in wd084
.loop_score_1
	ld hl, wd084
	add hl, de
	ld a, [wd082]
	cp [hl]
	jr nc, .not_higher

; store this score to wd082
	ld a, [hl]
	ld [wd082], a
; store this Play Area location to wd083
	ld a, e
	ld [wd083], a

.not_higher
	inc e
	dec c
	jr nz, .loop_score_1

; store the deck index of the stage 2 card
; that has been decided in wAITrainerCardArgs[1],
; return the Play Area location of card
; to evolve in a and return carry
	ld a, [wd083]
	ld e, a
	ld hl, wTempAITargetPokemonCardDeckIndex
	add hl, de
	ld a, [hl]
	ld [wAITrainerCardArgs + 1], a
	ld a, [wd083]
	scf
	ret

.check_evolution_and_dragonite
	ld a, 7
	ld hl, wd084
	farcall ClearNBytesFromHL

	xor a
	ld [wd082], a
	call CreateHandCardList
	ld hl, wDuelTempList
	push hl
.loop_hand_2
	pop hl
	ld a, [hli]
	cp $ff
	jr z, .check_evolution_found

	push hl
	push af
	call GetCardIDFromDeckIndex
	call GetCardType
	pop de
	cp TYPE_ENERGY
	jr nc, .loop_hand_2
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	ld c, a
	ld e, PLAY_AREA_ARENA

.loop_play_area_2
; check if evolution is possible
	push bc
	push de
	call CheckIfCanEvolveInto_BasicToStage2
	pop de
	call nc, .HandleDragoniteLv41Evolution
	call nc, .CalculateFitness

; not possible to evolve or returned carry
; when handling DragoniteLv41 evolution
	pop bc
	inc e
	dec c
	jr nz, .loop_play_area_2
	jr .loop_hand_2

.check_evolution_found
	ld a, [wd082]
	or a
	jr nz, .evolution_was_found
; no evolution was found before
	or a
	ret

.evolution_was_found
	xor a
	ld [wd082], a
	ld a, $ff
	ld [wd083], a
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	ld c, a
	ld e, PLAY_AREA_ARENA
	ld d, $00

; find highest score in wd084 with at least
; 2 energy cards attached
.loop_score_2
	ld hl, wd084
	add hl, de
	ld a, [wd082]
	cp [hl]
	jr nc, .next_score

; take the lower 4 bits (total energy cards)
; and skip if less than 2
	ld a, [hl]
	ld b, a
	and %00001111
	cp 2
	jr c, .next_score

; has at least 2 energy cards
; store the score in wd082
	ld a, b
	ld [wd082], a
; store this Play Area location to wd083
	ld a, e
	ld [wd083], a

.next_score
	inc e
	dec c
	jr nz, .loop_score_2

	ld a, [wd083]
	cp $ff
	jr z, .dont_use

; a card to evolve was found
; store the deck index of the stage 2 card
; that has been decided in wAITrainerCardArgs[1],
; return the Play Area location of card
; to evolve in a and return carry
	ld e, a
	ld hl, wTempAITargetPokemonCardDeckIndex
	add hl, de
	ld a, [hl]
	ld [wAITrainerCardArgs + 1], a
	ld a, [wd083]
	scf
	ret

.dont_use
	or a
	ret

.GreatDragonDeck:
	; check if Charizard is in hand
	ld de, CHARIZARD_LV76
	farcall LookForCardIDInHandList
	jr c, .found_charizard
	ld de, CHARIZARD_ALT_LV76
	farcall LookForCardIDInHandList
	ret nc ; no Charizard
.found_charizard
	; found, only evolve Charmanders in Bench
	ld [wAITrainerCardArgs + 1], a
	ld de, CHARMANDER_LV10
	ld b, PLAY_AREA_BENCH_1
	farcall FindCardIDInTurnDuelistsPlayArea
	ret c
	ld de, CHARMANDER_LV9
	ld b, PLAY_AREA_BENCH_1
	farcall FindCardIDInTurnDuelistsPlayArea
	ret

.MadPetalsDeck:
	; check for Oddish in Play Area
	ld de, ODDISH_LV21
	ld b, PLAY_AREA_ARENA
	farcall FindCardIDInTurnDuelistsPlayArea
	ret nc
	ld [wd082], a
	; got an Oddish, check cards in hand

	; if no Gloom and has Vileplume, play it
	ld de, GLOOM
	farcall LookForCardIDInHandList
	jr c, .has_gloom
	ld de, VILEPLUME
	farcall LookForCardIDInHandList
	jr c, .asm_212a4
.has_gloom
	; if no Dark Gloom and has Dark Vileplume, play it
	ld de, DARK_GLOOM
	farcall LookForCardIDInHandList
	ccf
	ret nc
	ld de, DARK_VILEPLUME
	farcall LookForCardIDInHandList
	ccf
	ret nc
.asm_212a4
	ld [wAITrainerCardArgs + 1], a
	ld a, [wd082]
	scf
	ret

.RockBlastDeck:
	; has Geodude in Play Area?
	ld de, GEODUDE_LV16
	ld b, PLAY_AREA_ARENA
	farcall FindCardIDInTurnDuelistsPlayArea
	ret nc
	; yes, how many energies does it have?
	ld [wd082], a
	ld e, a
	call GetPlayAreaCardAttachedEnergies
	ld a, [wTotalAttachedEnergies]
	cp 3
	ccf
	ret nc
	; has at least 3, is there Golem in hand?
	ld de, GOLEM_LV37
	farcall LookForCardIDInHandList
	ret nc
	; yes, play it
	ld [wAITrainerCardArgs + 1], a
	ld a, [wd082]
	scf
	ret

.BadDreamDeck:
	; has Gastly in Play Area?
	ld de, GASTLY_LV13
	ld b, PLAY_AREA_ARENA
	farcall FindCardIDInTurnDuelistsPlayArea
	ret nc
	; yes, has Haunter in Play Area?
	ld [wd082], a
	ld de, HAUNTER_LV22
	ld b, PLAY_AREA_ARENA
	farcall FindCardIDInTurnDuelistsPlayArea
	ret nc
	; yes, has Gengar in hand?
	ld de, GENGAR_LV40
	farcall LookForCardIDInHandList
	ret nc
	; yes, then evolve Gastly into Gengar
	ld [wAITrainerCardArgs + 1], a
	ld a, [wd082]
	scf
	ret

.SpiritedAwayDeck:
	; has Gastly in Play Area?
	ld de, GASTLY_LV17
	ld b, PLAY_AREA_ARENA
	farcall FindCardIDInTurnDuelistsPlayArea
	ret nc
	; yes, how many energies does it have?
	ld [wd082], a
	ld e, a
	call GetPlayAreaCardAttachedEnergies
	ld a, [wTotalAttachedEnergies]
	cp 2
	ccf
	ret nc
	; has at least 2, is there Dark Gengar in hand?
	ld de, DARK_GENGAR
	farcall LookForCardIDInHandList
	ret nc
	; yes, play it
	ld [wAITrainerCardArgs + 1], a
	ld a, [wd082]
	scf
	ret

.ImmortalPokemonDeck:
	; already has Alakazam in Play Area?
	ld de, ALAKAZAM_LV42
	ld b, PLAY_AREA_ARENA
	farcall FindCardIDInTurnDuelistsPlayArea
	ccf
	ret nc
	; nope, find an Abra in Play Area
	ld de, ABRA_LV14
	ld b, PLAY_AREA_ARENA
	farcall FindCardIDInTurnDuelistsPlayArea
	ret nc
	; Abra found
	ld [wd082], a
	; do we have an Alakazam in hand to play?
	ld de, ALAKAZAM_LV42
	farcall LookForCardIDInHandList
	ret nc
	; yes, play it
	ld [wAITrainerCardArgs + 1], a
	ld a, [wd082]
	scf
	ret

.TorrentialFloodDeck:
	; has Squirtle in Play Area?
	ld de, SQUIRTLE_LV14
	ld b, PLAY_AREA_ARENA
	farcall FindCardIDInTurnDuelistsPlayArea
	ret nc
	; yes, do we have a Blastoise in hand to play?
	ld [wd082], a
	ld de, BLASTOISE_LV52
	farcall LookForCardIDInHandList
	ret nc
	; yes, play it
	ld [wAITrainerCardArgs + 1], a
	ld a, [wd082]
	scf
	ret

; return carry if card is evolving to DragoniteLv41 and if
; - the card that is evolving is not Arena card and
;   number of damage counters in Play Area is under 8;
; - the card that is evolving is Arena card and has under 5
;   damage counters or has less than 3 energy cards attached.
.HandleDragoniteLv41Evolution:
	push af
	push bc
	push de
	push hl
	push de

; check card ID
	ld a, d
	call GetCardIDFromDeckIndex
	cp16 DRAGONITE_LV41
	pop de
	jr nz, .no_carry

; check card Play Area location
	ld a, e
	or a
	jr z, .active_card_dragonite

; the card that is evolving is not active card
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	ld b, a
	ld c, 0

; count damage counters in Play Area
.loop_play_area_damage
	dec b
	ld e, b
	push bc
	call GetCardDamageAndMaxHP
	pop bc
	farcall ConvertHPToCounters
	add c
	ld c, a

	ld a, b
	or a
	jr nz, .loop_play_area_damage

; compare number of total damage counters
; with 7, if less or equal to that, set carry
	ld a, 7
	cp c
	jr c, .no_carry
	jr .set_carry

.active_card_dragonite
; the card that is evolving is active card
; compare number of this card's damage counters
; with 5, if less than that, set carry
	ld e, PLAY_AREA_ARENA
	call GetCardDamageAndMaxHP
	cp 5
	jr c, .set_carry

; compare number of this card's attached energy cards
; with 3, if less than that, set carry
	xor a ; PLAY_AREA_ARENA
	call CreateArenaOrBenchEnergyCardList
	cp 3
	jr c, .set_carry
	jr .no_carry

.no_carry
	pop hl
	pop de
	pop bc
	pop af
	ret

.set_carry
	pop hl
	pop de
	pop bc
	pop af
	scf
	ret

AIPlay_ProfessorOak:
	ld a, [wCurrentAIFlags]
	or AI_FLAG_USED_PROFESSOR_OAK | AI_FLAG_MODIFIED_HAND
	ld [wCurrentAIFlags], a
	ld a, [wAITrainerCardToPlay]
	ldh [hDuelActionCardIndex], a
	ld a, OPPACTION_EXECUTE_TRAINER_EFFECTS
	farcall AIMakeDecision
	ret

AIDecide_ProfessorOak:
; return if cards in deck <= 6
	ld a, DUELVARS_NUMBER_OF_CARDS_NOT_IN_DECK
	get_turn_duelist_var
	cp DECK_SIZE - 6
	ret nc

	; has more than 7 cards in deck
	ld a, [wOpponentDeckID]
	cp ELECTRIC_SELFDESTRUCT_DECK_ID
	jp z, .ElectricSelfdestructDeck
	cp RAIN_DANCE_CONFUSION_DECK_ID
	jp z, .RainDanceConfusionDeck
	cp GO_ARCANINE_DECK_ID
	jp z, .GoArcanineDeck
	cp GRAND_FIRE_DECK_ID
	jp z, .GrandFireDeck
	cp LEGENDARY_FOSSIL_DECK_ID
	jp z, .LegendaryFossilDeck
	cp QUICK_ATTACK_DECK_ID
	jp z, .QuickAttackDeck
	cp GAZE_UPON_THE_POWER_OF_FIRE_DECK_ID
	jp z, .GazeUponThePowerOfFireDeck
	cp WATER_STREAM_DECK_ID
	jp z, .WaterStreamDeck
	cp RUNNING_WILD_DECK_ID
	jp z, .RunningWildDeck
	cp BAD_DREAM_DECK_ID
	jp z, .BadDreamDeck
	cp SPIRITED_AWAY_DECK_ID
	jp z, .SpiritedAwayDeck
	cp EYE_OF_THE_STORM_DECK_ID
	jp z, .EyeOfTheStormDeck
	cp SUDDEN_GROWTH_DECK_ID
	jp z, .SuddenGrowthDeck
	cp BAD_GUYS_DECK_ID
	jp z, .BadGuysDeck
	cp ULTRA_REMOVAL_DECK_ID
	jp z, .UltraRemovalDeck
	cp PSYCHIC_BATTLE_DECK_ID
	jp z, .PsychicBattleDeck
	cp EVERYBODYS_FRIEND_DECK_ID
	jp z, .EverybodysFriendDeck
	cp TORRENTIAL_FLOOD_DECK_ID
	jp z, .TorrentialFloodDeck
	cp TRAINER_IMPRISON_DECK_ID
	jp z, .TrainerImprisonDeck
	cp BLAZING_FLAME_DECK_ID
	jp z, .BlazingFlameDeck

; generic deck AI logic for Professor Oak

	; do not play if cards in deck <= 14
	ld a, [hl]
	cp DECK_SIZE - 14
	ret nc

; initialize score
	ld a, 30
	ld [wAIProfessorOakScore], a

	ld a, DUELVARS_NUMBER_OF_CARDS_IN_HAND
	get_turn_duelist_var
	cp 4
	jr nc, .at_least_4_hand_cards
	; < 4 hand cards, encourage
	ld a, [wAIProfessorOakScore]
	add 50
	ld [wAIProfessorOakScore], a
	jr .check_energy_cards
.at_least_4_hand_cards
	cp 9
	jr c, .check_energy_cards
	; >= 9 hand cards, discourage
	ld a, [wAIProfessorOakScore]
	sub 30
	ld [wAIProfessorOakScore], a

.check_energy_cards
	bank1call CreateEnergyCardListFromHand
	jr nc, .handle_blastoise
	; no energy cards, encourage
	ld a, [wAIProfessorOakScore]
	add 40
	ld [wAIProfessorOakScore], a

.handle_blastoise
	; is there Muk in play?
	ld de, MUK
	bank1call CountPokemonWithActivePkmnPowerInBothPlayAreas
	jr c, .encourage_once
	; if not, does AI have Blastoise lv52 in play?
	ld de, BLASTOISE_LV52
	bank1call CountTurnDuelistPokemonWithActivePkmnPower
	jr nc, .encourage_once
	; if yes, does AI have any Water Energy cards in hand?
	ld de, WATER_ENERGY
	farcall LookForCardIDInHand
	jr nc, .encourage_once
	; nope, then encourage twice
	ld a, [wAIProfessorOakScore]
	add 10
	ld [wAIProfessorOakScore], a
.encourage_once
	ld a, [wAIProfessorOakScore]
	add 10
	ld [wAIProfessorOakScore], a

; loops through hand cards and encourages
; if it finds any Basic Pokémon cards
	call CreateHandCardList
	ld hl, wDuelTempList
.loop_hand
	ld a, [hli]
	cp $ff
	jr z, .check_evolutions

	; skip card if it's an Energy card
	call LoadCardDataToBuffer1_FromDeckIndex
	ld a, [wLoadedCard1Type]
	cp TYPE_ENERGY
	jr nc, .loop_hand

	; skip card if it's not Basic
	ld a, [wLoadedCard1Stage]
	or a
	jr nz, .loop_hand

	; has a Basic card, encourage
	ld a, [wAIProfessorOakScore]
	sub 10
	ld [wAIProfessorOakScore], a

.check_evolutions
	xor a
	ld [wTempAITargetPokemonCardDeckIndex], a
	ld [wTempAITargetNonPokemonCardDeckIndex], a

	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	ld d, a
	ld e, PLAY_AREA_ARENA
.loop_play_area
	push de
	call .LookForEvolution
	pop de
	jr nc, .not_in_hand
	; there's a card in hand that can evolve it
	ld a, TRUE
	ld [wTempAITargetPokemonCardDeckIndex], a
.not_in_hand
	; check if a card that can evolve was found at all
	; if yes, then set wTempAITargetNonPokemonCardDeckIndex to TRUE
	ld a, [wd084]
	cp TRUE
	jr nz, .next_play_area
	ld a, TRUE
	ld [wTempAITargetNonPokemonCardDeckIndex], a

.next_play_area
	inc e
	dec d
	jr nz, .loop_play_area

	; if an evolution card was found...
	ld a, [wTempAITargetNonPokemonCardDeckIndex]
	or a
	jr z, .check_score
	; ...but that card is not in the hand...
	ld a, [wTempAITargetPokemonCardDeckIndex]
	or a
	jr nz, .check_score
	; ...add to the score
	ld a, [wAIProfessorOakScore]
	add 10
	ld [wAIProfessorOakScore], a

.check_score
	; only use Professor Oak if score is >= 60
	ld a, [wAIProfessorOakScore]
	ld b, 60
	cp b
	jr nc, .set_carry
	or a
	ret

.set_carry
	scf
	ret

; return carry if there's a card in the hand that
; can evolve the card in Play Area location in e.
; sets wd084 to TRUE if any card is found that can
; evolve regardless of card location.
.LookForEvolution:
	xor a
	ld [wd084], a
	ld d, 0 ; deck index

; loop through all cards to check if there's
; a card that can evolve this Pokemon.
.loop_find_evolution
	farcall CheckIfEvolvesInto
	jr nc, .can_evolve
.evolution_not_in_hand
	inc d
	ld a, DECK_SIZE
	cp d
	jr nz, .loop_find_evolution
	; no evolutions found in hand
	or a
	ret

; a card was found that can evolve, set wd084 to TRUE
; and if the card is in the hand, return carry.
; otherwise resume looping through all cards
.can_evolve
	ld a, TRUE
	ld [wd084], a
	ld a, DUELVARS_CARD_LOCATIONS
	add d
	get_turn_duelist_var
	cp CARD_LOCATION_HAND
	jr nz, .evolution_not_in_hand
	; is in hand
	scf
	ret

.ElectricSelfdestructDeck:
	; don't use if has 5 or more cards in hand
	ld a, DUELVARS_NUMBER_OF_CARDS_IN_HAND
	get_turn_duelist_var
	cp 5
	ret nc

	; if any of the following cards are in hand, don't use
	ld de, MAGNEMITE_LV13
	farcall LookForCardIDInHand
	ret nc
	ld de, MAGNEMITE_LV15
	farcall LookForCardIDInHand
	ret nc
	ld de, VOLTORB_LV8
	farcall LookForCardIDInHand
	ret

.RainDanceConfusionDeck:
	; bug, checking hands cards instead of cards not in deck
	ld a, DUELVARS_NUMBER_OF_CARDS_IN_HAND
	get_turn_duelist_var
	ld a, [hl] ; unnecessary
	cp 43
	ret nc ; has at least 43 cards in hand

	; are the any energy cards in hand?
	farcall CountEnergyCardsInHand
	jr c, .asm_21560
	; yes, are there 2 or more Pokémon in Play Area?
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	cp 2
	jr c, .asm_21560
	; yes, is there at least 5 cards in hand?
	ld a, DUELVARS_NUMBER_OF_CARDS_IN_HAND
	get_turn_duelist_var
	cp 5
	ret nc ; yes, don't use

.asm_21560
	farcall AIDecide_ProfessorOak_RainDanceConfusionDeck
	ret

.GoArcanineDeck:
	; bug, checking hands cards instead of cards not in deck
	ld a, DUELVARS_NUMBER_OF_CARDS_IN_HAND
	get_turn_duelist_var
	ld a, [hl]
	cp 41
	jr nc, .asm_21589

	; if has 8 or more cards in hand, don't use
	ld a, DUELVARS_NUMBER_OF_CARDS_IN_HAND
	get_turn_duelist_var
	cp 8
	ret nc

	; if doesn't have Moltres lv40 in hand, use
	push af
	ld de, MOLTRES_LV40
	farcall LookForCardIDInHandList
	pop bc
	jr nc, .asm_2159a
	; Moltres is in hand, if has 5 or fewer cards
	; in hand, don't use
	ld a, 5
	cp b
	ret nc
	; if has no Basic Pokemon in hand, use
	farcall CountNumberOfBasicPokemonInHand
	or a
	jr z, .asm_2159a

.asm_21589
	; bug, checking hands cards instead of cards not in deck
	ld a, DUELVARS_NUMBER_OF_CARDS_IN_HAND
	get_turn_duelist_var
	ld a, [hl]
	cp 45
	ret nc

	; if has less than 5 cards in hand and no energies, use
	ld a, DUELVARS_NUMBER_OF_CARDS_IN_HAND
	get_turn_duelist_var
	cp 5
	ret nc
	bank1call CreateEnergyCardListFromHand
	ret nc
.asm_2159a
	scf
	ret

.GrandFireDeck:
; if any of the following cards are in hand, don't use
	ld de, MOLTRES_LV40
	farcall LookForCardIDInHandList
	jr c, .asm_215c7
	ld de, RAPIDASH_LV33
	farcall LookForCardIDInHandList
	jr c, .asm_215c7
	ld de, NINETALES_LV35
	farcall LookForCardIDInHandList
	jr c, .asm_215c7

	; if at least 3 energy cards in hand, don't use
	farcall CountEnergyCardsInHand
	cp 3
	jr nc, .asm_215c7
	; otherwise, if player has less than 6 cards in hand, use
	ld a, DUELVARS_NUMBER_OF_CARDS_IN_HAND
	call GetNonTurnDuelistVariable
	cp 6
	ret ; carry if < 6
.asm_215c7
	or a
	ret

.LegendaryFossilDeck:
	; if has less than 4 cards in hand, use
	ld a, DUELVARS_NUMBER_OF_CARDS_IN_HAND
	get_turn_duelist_var
	cp 4
	ret

.QuickAttackDeck:
.RunningWildDeck:
	; if has less than 5 cards in hand, use
	ld a, DUELVARS_NUMBER_OF_CARDS_IN_HAND
	get_turn_duelist_var
	cp $05
	ret

.GazeUponThePowerOfFireDeck:
.WaterStreamDeck:
	; if has at least 23 decks left in deck...
	ld a, DUELVARS_NUMBER_OF_CARDS_NOT_IN_DECK
	get_turn_duelist_var
	cp DECK_SIZE - 24
	jr nc, .asm_215e2
	; ...and has less than 5 cards in hand, use
	ld a, DUELVARS_NUMBER_OF_CARDS_IN_HAND
	get_turn_duelist_var
	cp 5
	ret

.asm_215e2
	; otherwise use if less than 4 cards in hand
	ld a, DUELVARS_NUMBER_OF_CARDS_IN_HAND
	get_turn_duelist_var
	cp 4
	ret

.BadDreamDeck:
	; if has less than 5 cards in hand, use
	ld a, DUELVARS_NUMBER_OF_CARDS_IN_HAND
	get_turn_duelist_var
	cp 5
	ret c
	; if has 11 or more cards in hand, don't use
	cp 11
	ret nc

	; hand cards >= 5 and < 11
	; do not use if any of the following cards are in hand
	ld de, GASTLY_LV13
	farcall LookForCardIDInHandList
	jr c, .asm_2160e
	ld de, HAUNTER_LV22
	farcall LookForCardIDInHandList
	jr c, .asm_2160e
	ld de, DROWZEE_LV10
	farcall LookForCardIDInHandList
	jr c, .asm_2160e
	; if none of them are in hand, then use
	scf
	ret
.asm_2160e
	or a
	ret

.SpiritedAwayDeck:
	; if less than 8 cards in hand, use
	ld a, DUELVARS_NUMBER_OF_CARDS_IN_HAND
	get_turn_duelist_var
	cp 8
	ret

.EyeOfTheStormDeck:
	farcall ColorlessAltarAIDecideProfessorOak
	ret

.SuddenGrowthDeck:
	farcall AIDecide_ItemFinder_SuddenGrowthDeck_TargetProfessorOak
	ret

.BadGuysDeck:
	farcall AIDecide_ProfessorOak_BadGuysDeck
	ret

.UltraRemovalDeck:
	farcall AIDecide_ProfessorOak_UltraRemovalDeck
	ret

.PsychicBattleDeck:
	farcall AIDecide_ProfessorOak_PsychicBattleDeck
	ret

.EverybodysFriendDeck:
	farcall AIDecide_ProfessorOak_EverybodysFriendDeck
	ret

.TorrentialFloodDeck:
	farcall AIDecide_ProfessorOak_TorrentialFloodDeck
	ret

.TrainerImprisonDeck:
	farcall AIDecide_ProfessorOak_TrainerImprisonDeck
	ret

.BlazingFlameDeck:
	farcall AIDecide_ProfessorOak_BlazingFlameDeck
	ret

AIPlay_EnergyRetrieval:
	ld a, [wCurrentAIFlags]
	or AI_FLAG_MODIFIED_HAND
	ld [wCurrentAIFlags], a
	ld a, [wAITrainerCardToPlay]
	ldh [hDuelActionCardIndex], a
	ld a, [wAITrainerCardArgs + 0]
	ldh [hDuelActionArgs + 0], a
	ld a, [wAITrainerCardArgs + 1]
	ldh [hDuelActionArgs + 1], a
	ld a, [wAITrainerCardArgs + 2]
	ldh [hDuelActionArgs + 2], a
	cp $ff
	jr z, .asm_21667
	ld a, $ff
	ldh [hDuelActionArgs + 3], a
.asm_21667
	ld a, OPPACTION_EXECUTE_TRAINER_EFFECTS
	farcall AIMakeDecision
	ret

AIDecide_EnergyRetrieval:
	ld a, [wOpponentDeckID]
	cp ELECTRIC_SELFDESTRUCT_DECK_ID
	jp z, .ElectricSelfdestructDeck
	cp MAX_ENERGY_DECK_ID
	jp z, .MaxEnergyDeck
	cp RAIN_DANCE_CONFUSION_DECK_ID
	jp z, .RainDanceConfusionDeck
	cp ELECTRIC_CURRENT_SHOCK_DECK_ID
	jp z, .ElectricCurrentShockDeck
	cp STICKY_POISON_GAS_DECK_ID
	jp z, .StickyPoisonGasDeck
	cp EEVEE_SHOWDOWN_DECK_ID
	jp z, .EeveeShowdownDeck
	cp WHIRLPOOL_SHOWER_DECK_ID
	jp z, .WhirlpoolShowerDeck
	cp PARALYZED_PARALYZED_DECK_ID
	jp z, .ParalyzedParalyzedDeck
	cp BENCH_CALL_DECK_ID
	jp z, .BenchCallDeck
	cp FULL_STRENGTH_DECK_ID
	jp z, .FullStrengthDeck
	cp EYE_OF_THE_STORM_DECK_ID
	jp z, .EyeOfTheStormDeck
	cp BAD_GUYS_DECK_ID
	jp z, .BadGuysDeck
	cp PSYCHIC_BATTLE_DECK_ID
	jp z, .PsychicBattleDeck
	cp SCORCHER_DECK_ID
	jp z, .ScorcherDeck
	cp PROTOHISTORIC_DECK_ID
	jp z, .ProtohistoricDeck
	cp TEXTURE_TUNER7_DECK_ID
	jp z, .TextureTuner7Deck
	cp RONALDS_PSYCHIC_DECK_ID
	jp z, .RonaldsPsychicDeck
	cp TORRENTIAL_FLOOD_DECK_ID
	jp z, .TorrentialFloodDeck
	cp BLAZING_FLAME_DECK_ID
	jp z, .BlazingFlameDeck
	cp DAMAGE_CHAOS_DECK_ID
	jp z, .DamageChaosDeck
	cp BIG_THUNDER_DECK_ID
	jp z, .BigThunderDeck
	cp POWER_OF_DARKNESS_DECK_ID
	jp z, .PowerOfDarknessDeck

; return no carry if no cards in hand
	farcall CountBasicEnergyCardsInHand
	ret nc

.continue:
; find a duplicate card in hand to discard,
; if none found, don't play Energy Retrieval
	call CreateHandCardList
	ld hl, wDuelTempList
	farcall FindDuplicateCards_IgnoreTrainerCardToPlay
	jp c, .no_carry

	push af
	ld a, [wOpponentDeckID]
	cp PHANTOM_DECK_ID
	jr z, .prioritize_discard_non_pkmn
	cp SKILLED_WARRIOR_DECK_ID
	jr z, .prioritize_discard_non_pkmn
	cp GO_ARCANINE_DECK_ID
	jr z, .prioritize_discard_non_pkmn
	cp DANGEROUS_BENCH_DECK_ID
	jp z, .DangerousBenchDeck
	cp THIS_IS_THE_POWER_OF_ELECTRICITY_DECK_ID
	jp z, .ThisIsThePowerOfElectricityDeck
	cp QUICK_ATTACK_DECK_ID
	jp z, .QuickAttackDeck
	cp DIRECT_HIT_DECK_ID
	jr z, .prioritize_discard_non_pkmn
	cp TEST_YOUR_LUCK_DECK_ID
	jp z, .TestYourLuckDeck
	cp EVERYBODYS_FRIEND_DECK_ID
	jp z, .EverybodysFriendDeck
	jr .generic_logic

.prioritize_discard_non_pkmn
	; is there a non-Pkmn duplicate card?
	ld a, [wTempAITargetNonPokemonCardDeckIndex]
	cp $ff
	jr z, .generic_logic
	; yes, choose it instead
	pop af
	ld a, [wTempAITargetNonPokemonCardDeckIndex]
	push af

.generic_logic
	pop af
	ld [wd082], a
	ld a, CARD_LOCATION_DISCARD_PILE
	farcall CreateBasicEnergyCardListInLocation
	jp c, .no_carry

; some basic energy cards were found in Discard Pile
	ld a, $ff
	ld [wAITrainerCardArgs + 1], a
	ld [wAITrainerCardArgs + 2], a
	ld [wAITrainerCardArgs + 3], a

	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	ld d, a
	ld e, PLAY_AREA_ARENA

; first check if there are useful energy cards in the list
; and choose them for retrieval first
.loop_play_area
	push de
	ld a, e
	farcall CheckIfPlayAreaCardNeedsNoEnergyForAttacks
	pop de
	jr c, .next_play_area
	ld a, DUELVARS_ARENA_CARD
	add e
	push de
	get_turn_duelist_var
	call LoadCardDataToBuffer1_FromDeckIndex
	pop de

; load this card's ID in wTempCardID_d0a3
; and this card's Type in wTempCardType
	ld a, [wLoadedCard1ID + 0]
	ld [wTempCardID_d0a3 + 0], a
	ld a, [wLoadedCard1ID + 1]
	ld [wTempCardID_d0a3 + 1], a
	ld a, [wLoadedCard1Type]
	or TYPE_ENERGY
	ld [wTempCardType], a

; loop the energy cards in the Discard Pile
; and check if they are useful for this Pokemon
	ld hl, wDuelTempList
.loop_energy_cards_1
	ld a, [hli]
	cp $ff
	jr z, .next_play_area

	ld b, a
	push hl
	farcall CheckIfEnergyIsUseful
	pop hl
	jr nc, .loop_energy_cards_1

	ld a, [wAITrainerCardArgs + 1]
	cp $ff
	jr nz, .second_energy_1

; check if there were already chosen cards,
; if this is the second chosen card, return carry

; first energy card found
	ld a, b
	ld [wAITrainerCardArgs + 1], a
	call RemoveCardFromList
	jr .next_play_area
.second_energy_1
	ld a, b
	ld [wAITrainerCardArgs + 2], a
	jr .set_carry

.next_play_area
	inc e
	dec d
	jr nz, .loop_play_area

; next, if there are still energy cards left to choose,
; loop through the energy cards again and select
; them in order.
	ld hl, wDuelTempList
.loop_energy_cards_2
	ld a, [hli]
	cp $ff
	jr z, .check_chosen
	ld b, a
	ld a, [wAITrainerCardArgs + 1]
	cp $ff
	jr nz, .second_energy_2
	ld a, b
	ld [wAITrainerCardArgs + 1], a
	call RemoveCardFromList
	jr .loop_energy_cards_2

.second_energy_2
	ld a, b
	ld [wAITrainerCardArgs + 2], a
	jr .set_carry

; will set carry if at least one has been chosen
.check_chosen
	ld a, [wAITrainerCardArgs + 1]
	cp $ff
	jr nz, .set_carry
.no_carry
	or a
	ret

.set_carry
	ld a, [wd082]
	scf
	ret

.ElectricSelfdestructDeck:
	; don't use if has at least 3 energies in hand
	farcall CountEnergyCardsInHand
	cp 3
	ret nc
	jp .continue

.MaxEnergyDeck:
	; exit if has Grass energy in hand
	ld de, GRASS_ENERGY
	farcall CountCardIDInHand
	jr nc, .no_carry
	; do we have energy cards in Discard Pile?
	ld a, CARD_LOCATION_DISCARD_PILE
	farcall CreateBasicEnergyCardListInLocation
	jr c, .no_carry
	; yes, choose top 2 cards
	ld a, [wDuelTempList + 0]
	ld [wAITrainerCardArgs + 1], a
	ld a, [wDuelTempList + 1]
	ld [wAITrainerCardArgs + 2], a

	; choose a card to discard from hand

	; check duplicated Metapod card
	ld de, METAPOD_LV20
	farcall CheckIfHandHasRepeatedCard
	ret c
	; check duplicated Ivysaur card
	ld de, IVYSAUR_LV26
	farcall CheckIfHandHasRepeatedCard
	ret c
	; check duplicated Venusaur card
	ld de, VENUSAUR_LV67
	farcall CheckIfHandHasRepeatedCard
	ret c

	; not found, check for an unusable evolution instead
	farcall FindUnusableEvolutionCardInHand
	ret nc
	; choose it, except if it's an Exeggutor
	push af
	call GetCardIDFromDeckIndex
	cp16 EXEGGUTOR
	pop bc
	ret z
	; not Exeggutor
	ld a, b
	scf
	ret

.RainDanceConfusionDeck:
	; do we have energy cards in Discard Pile?
	ld a, CARD_LOCATION_DISCARD_PILE
	farcall CreateBasicEnergyCardListInLocation
	jr c, .no_carry
	; yes, choose top 2 cards
	; but if only 1 is found, then exit
	ld a, [wDuelTempList + 0]
	ld [wAITrainerCardArgs + 1], a
	ld a, [wDuelTempList + 1]
	ld [wAITrainerCardArgs + 2], a
	cp $ff
	jr z, .no_carry

	; do we have energy cards in hand?
	bank1call CreateEnergyCardListFromHand
	jr c, .no_energies_in_hand
	; yes we do, only play Energy Retrieval if Blastoise is in Play Area
	ld de, BLASTOISE_LV52
	ld b, PLAY_AREA_ARENA
	farcall FindCardIDInTurnDuelistsPlayArea
	jp nc, .no_carry
.no_energies_in_hand
	; if has more than 1 copy of Professor Oak, then
	; discard it and use Energy Retrieval
	ld de, PROFESSOR_OAK
	farcall CheckIfHandHasRepeatedCard
	ret c
	; otherwise, has at least 18 cards in deck?
	ld a, DUELVARS_NUMBER_OF_CARDS_NOT_IN_DECK
	get_turn_duelist_var
	cp DECK_SIZE - 18
	jr c, .gte_18_cards
	; has less than 18 cards in deck
	; discard Professor Oak in hand, if any
	; and use Energy Retrieval
	ld de, PROFESSOR_OAK
	farcall LookForCardIDInHandList
	ret c

.gte_18_cards
	; if no Pokémon has damage counters
	; discard a Potion, if any, and use Energy Retrieval
	farcall CheckIfAnyPlayAreaPokemonHasDamage
	jr c, .got_damage
	ld de, POTION
	farcall LookForCardIDInHandList
	ret c
.got_damage
	; try discarding Switch in hand
	ld de, SWITCH
	farcall LookForCardIDInHandList
	ret c

	; try discarding the following Pokémon cards
	; in hand if they are in Play Area already
	ld de, DEWGONG_LV24
	farcall IsCardIDInHandAndPlayArea
	ret c
	ld de, SEEL_LV10
	farcall IsCardIDInHandAndPlayArea
	ret c
	ld de, LAPRAS_LV31
	farcall IsCardIDInHandAndPlayArea
	ret c

	; at this point only consider using Energy Retrieval
	; if Blastoise is in Play Area
	ld de, BLASTOISE_LV52
	ld b, PLAY_AREA_ARENA
	farcall FindCardIDInTurnDuelistsPlayArea
	ret nc ; no Blastoise

	; got Blastoise, try discarding Pokémon Breeder in hand
	ld de, POKEMON_BREEDER
	farcall LookForCardIDInHandList
	ret c

.ElectricCurrentShockDeck:
	; at this point only consider using Energy Retrieval
	; if no (basic) energy cards in hand
	farcall CountBasicEnergyCardsInHand
	jp nc, .no_carry ; has energies
	; no energy cards in hand
	; try discarding a Switch or Gust of Wind in hand
	; (note: at this point Switch is not in hand since
	; it would have been discarded above)
	ld de, SWITCH
	farcall LookForCardIDInHandList
	jr c, .asm_218cb
	ld de, GUST_OF_WIND
	farcall LookForCardIDInHandList
	jr c, .asm_218cb

	; finally try discarding a duplicated Non-Pkmn card in hand
	call CreateHandCardList
	ld hl, wDuelTempList
	farcall FindDuplicateCards_IgnoreTrainerCardToPlay
	jp c, .no_carry
	push af
	ld a, [wTempAITargetNonPokemonCardDeckIndex]
	ld b, a
	pop af
	cp b
	ret z
.asm_218cb
	push af
	jp .generic_logic

.StickyPoisonGasDeck:
	; if already has energies in hand, exit
	farcall CountBasicEnergyCardsInHand
	jp nc, .no_carry

	; is Muk in play?
	ld de, MUK
	ld b, PLAY_AREA_ARENA
	farcall FindCardIDInTurnDuelistsPlayArea
	jr c, .muk_is_in_play
	ld de, MUK
	ld b, PLAY_AREA_ARENA
	call SwapTurn
	farcall FindCardIDInTurnDuelistsPlayArea
	call SwapTurn
	jr nc, .no_muk_in_play
.muk_is_in_play
	; is Goop Gas Attack in hand?
	ld de, GOOP_GAS_ATTACK
	farcall LookForCardIDInHandList
	jr nc, .no_muk_in_play ; no
	; yes, use it for discard
	push af
	jp .generic_logic

.no_muk_in_play
	; find a duplicated non-Pkmn card to discard
	call CreateHandCardList
	ld hl, wDuelTempList
	farcall FindDuplicateCards_IgnoreTrainerCardToPlay
	jp c, .no_carry
	push af
	ld a, [wTempAITargetNonPokemonCardDeckIndex]
	ld b, a
	pop af
	cp b
	jp z, .no_carry
	push af
	jp .generic_logic

.DangerousBenchDeck:
.EverybodysFriendDeck:
	; only use Energy Retrieval if there's a duplicated non-Pkmn card to discard
	ld a, [wTempAITargetNonPokemonCardDeckIndex]
	cp $ff
	jr z, .asm_21929
	pop af
	ld a, [wTempAITargetNonPokemonCardDeckIndex]
	push af
	jp .generic_logic
.asm_21929
	pop af
	or a
	ret

.ThisIsThePowerOfElectricityDeck:
.QuickAttackDeck:
.TestYourLuckDeck:
	; only use Energy Retrieval if there's a duplicated non-Pkmn card to discard
	ld a, [wTempAITargetNonPokemonCardDeckIndex]
	ld b, a
	pop af
	cp b
	ret z
	push af
	jp .generic_logic

.EeveeShowdownDeck:
	; if already has energies in hand, exit
	farcall CountBasicEnergyCardsInHand
	jp nc, .no_carry

	; try discarding a Switch or Pokémon Trader card in hand
	ld de, SWITCH
	farcall LookForCardIDInHandList
	jr c, .asm_21965
	ld de, POKEMON_TRADER
	farcall LookForCardIDInHandList
	jr c, .asm_21965

	; find a duplicated non-Pkmn card to discard
	call CreateHandCardList
	ld hl, wDuelTempList
	farcall FindDuplicateCards_IgnoreTrainerCardToPlay
	jp c, .no_carry
	push af
	ld a, [wTempAITargetNonPokemonCardDeckIndex]
	ld b, a
	pop af
	cp b
	ret z
.asm_21965
	push af
	jp .generic_logic

.WhirlpoolShowerDeck:
.ParalyzedParalyzedDeck:
	; if already has energies in hand, exit
	farcall CountBasicEnergyCardsInHand
	jp nc, .no_carry

	; try discarding a Switch or Pokéball card in hand
	ld de, SWITCH
	farcall LookForCardIDInHandList
	jr c, .asm_21997
	ld de, POKEBALL
	farcall LookForCardIDInHandList
	jr c, .asm_21997

	; find a duplicated non-Pkmn card to discard
	call CreateHandCardList
	ld hl, wDuelTempList
	farcall FindDuplicateCards_IgnoreTrainerCardToPlay
	jp c, .no_carry
	push af
	ld a, [wTempAITargetNonPokemonCardDeckIndex]
	ld b, a
	pop af
	cp b
	ret z
.asm_21997
	push af
	jp .generic_logic

.BenchCallDeck:
	; if already has energies in hand, exit
	farcall CountBasicEnergyCardsInHand
	jp nc, .no_carry

	; try discarding a Pokémon Flute or Gust of Wind card in hand
	ld de, POKEMON_FLUTE
	farcall LookForCardIDInHandList
	jr c, .asm_219c9
	ld de, GUST_OF_WIND
	farcall LookForCardIDInHandList
	jr c, .asm_219c9

	; find a duplicated non-Pkmn card to discard
	call CreateHandCardList
	ld hl, wDuelTempList
	farcall FindDuplicateCards_IgnoreTrainerCardToPlay
	jp c, .no_carry
	push af
	ld a, [wTempAITargetNonPokemonCardDeckIndex]
	ld b, a
	pop af
	cp b
	ret z
.asm_219c9
	push af
	jp .generic_logic

.FullStrengthDeck:
	; if already has energies in hand, exit
	farcall CountBasicEnergyCardsInHand
	ret nc

	; try discarding any of the following cards
	; if they are repeated in hand
	ld de, THE_BOSSS_WAY
	farcall CheckIfHandHasRepeatedCard
	jr c, .asm_21a07
	ld de, POKEMON_TRADER
	farcall CheckIfHandHasRepeatedCard
	jr c, .asm_21a07
	ld de, SWITCH
	farcall CheckIfHandHasRepeatedCard
	jr c, .asm_21a07
	ld de, DARK_FEAROW
	farcall CheckIfHandHasRepeatedCard
	jr c, .asm_21a07
	ld de, DARK_MACHOKE
	farcall CheckIfHandHasRepeatedCard
	jr c, .asm_21a07
	ld de, DARK_MACHAMP
	farcall CheckIfHandHasRepeatedCard
	ret nc
.asm_21a07
	push af
	jp .generic_logic

.EyeOfTheStormDeck:
	farcall AIDecide_EnergyRetrieval_EyeOfTheStormDeck
	ret

.BadGuysDeck:
	farcall AIDecide_EnergyRetrieval_BadGuysDeck_PickDiscardCard
	ret nc
	push af
	jp .generic_logic

.PsychicBattleDeck:
	farcall AIDecide_EnergyRetrieval_PsychicBattleDeck
	ret nc
	push af
	jp .generic_logic

.ScorcherDeck:
	farcall AIDecide_EnergyRetrieval_ScorcherDeck
	ret nc
	push af
	jp .generic_logic

.ProtohistoricDeck:
	farcall SearchHandForEvoCardAlreadyInTurnDuelistPlayArea
	ret nc
	push af
	jp .generic_logic

.TextureTuner7Deck:
	; try selecting a hand card that is already in Play Area
	farcall IsSameCardInHandAndPlayArea
	jr c, .asm_21a4f
	; otherwise try discarding a non-Pkmn hand card
	call CreateHandCardList
	ld hl, wDuelTempList
	farcall FindDuplicateCards_IgnoreTrainerCardToPlay
	jp c, .no_carry
	push af
	ld a, [wTempAITargetNonPokemonCardDeckIndex]
	ld b, a
	pop af
	cp b
	ret z
.asm_21a4f
	push af
	jp .generic_logic

.RonaldsPsychicDeck:
	farcall AIDecide_EnergyRetrieval_RonaldsPsychicDeck
	ret nc
	push af
	jp .generic_logic

.TorrentialFloodDeck:
	; if has no energies in hand, continue
	farcall CountBasicEnergyCardsInHand
	jp c, .continue
	; otherwise, only continue if Blastoise is in Play Area
	ld de, BLASTOISE_LV52
	ld b, PLAY_AREA_ARENA
	farcall FindCardIDInTurnDuelistsPlayArea
	jp c, .continue
	ret

.BlazingFlameDeck:
	farcall AIDecide_EnergyRetrieval_BlazingFlameDeck
	ret

.DamageChaosDeck:
	farcall AIDecide_EnergyRetrieval_DamageChaosDeck
	ret nc
	push af
	jp .generic_logic

.BigThunderDeck:
	farcall AIDecide_EnergyRetrieval_BigThunderDeck
	ret

.PowerOfDarknessDeck:
	farcall AIDecide_EnergyRetrieval_PowerOfDarknessDeck
	ret nc
	push af
	jp .generic_logic

; remove an element from the list
; and shortens it accordingly
; input:
;   hl = pointer to element after the one to remove
RemoveCardFromList:
	push de
	ld d, h
	ld e, l
	dec hl
	push hl
.loop_remove
	ld a, [de]
	ld [hli], a
	cp $ff
	jr z, .done_remove
	inc de
	jr .loop_remove
.done_remove
	pop hl
	pop de
	ret

AIPlay_SuperEnergyRetrieval:
	ld a, [wCurrentAIFlags]
	or AI_FLAG_MODIFIED_HAND
	ld [wCurrentAIFlags], a
	ld a, [wAITrainerCardToPlay]
	ldh [hDuelActionCardIndex], a
	ld a, [wAITrainerCardArgs + 0]
	ldh [hDuelActionArgs + 0], a
	ld a, [wAITrainerCardArgs + 1]
	ldh [hDuelActionArgs + 1], a
	ld a, [wAITrainerCardArgs + 2]
	ldh [hDuelActionArgs + 2], a
	ld a, [wAITrainerCardArgs + 3]
	ldh [hDuelActionArgs + 3], a
	cp $ff
	jr z, .asm_21ad8
	ld a, [wAITrainerCardArgs + 4]
	ldh [hDuelActionArgs + 4], a
	cp $ff
	jr z, .asm_21ad8
	ld a, [wAITrainerCardArgs + 5]
	ldh [hDuelActionArgs + 5], a
	cp $ff
	jr z, .asm_21ad8
	ld a, $ff
	ldh [hDuelActionArgs + 6], a
.asm_21ad8
	ld a, OPPACTION_EXECUTE_TRAINER_EFFECTS
	farcall AIMakeDecision
	ret

AIDecide_SuperEnergyRetrieval:
	ld a, [wOpponentDeckID]
	cp RONALDS_UNCOOL_DECK_ID
	jp z, .RonaldsUncoolDeck

; return no carry if no cards in hand
	bank1call CreateEnergyCardListFromHand
	jp nc, .no_carry

; find duplicate cards in hand
	call CreateHandCardList
	ld hl, wDuelTempList
	farcall FindDuplicateCards_IgnoreTrainerCardToPlay
	jp c, .no_carry

; remove the duplicate card in hand
; and run the hand check again
	ld [wd082], a
	ld hl, wDuelTempList
	call FindAndRemoveCardFromList
	farcall FindDuplicateCards_IgnoreTrainerCardToPlay
	jp c, .no_carry
	ld [wd084], a

	ld a, CARD_LOCATION_DISCARD_PILE
	farcall CreateBasicEnergyCardListInLocation
	jp c, .no_carry

; some basic energy cards were found in Discard Pile
	ld a, $ff
	ld [wAITrainerCardArgs + 2], a
	ld [wAITrainerCardArgs + 3], a
	ld [wAITrainerCardArgs + 4], a
	ld [wAITrainerCardArgs + 5], a
	ld [wAITrainerCardArgs + 6], a

	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	ld d, a
	ld e, PLAY_AREA_ARENA

; first check if there are useful energy cards in the list
; and choose them for retrieval first
.loop_play_area
	push de
	ld a, e
	farcall CheckIfPlayAreaCardNeedsNoEnergyForAttacks
	pop de
	jr c, .next_play_area
	ld a, DUELVARS_ARENA_CARD
	add e
	push de
	get_turn_duelist_var
	call LoadCardDataToBuffer1_FromDeckIndex
	pop de
; load this card's ID in wTempCardID_d0a3
; and this card's Type in wTempCardType
	ld a, [wLoadedCard1ID + 0]
	ld [wTempCardID_d0a3 + 0], a
	ld a, [wLoadedCard1ID + 1]
	ld [wTempCardID_d0a3 + 1], a
	ld a, [wLoadedCard1Type]
	or TYPE_ENERGY
	ld [wTempCardType], a

; loop the energy cards in the Discard Pile
; and check if they are useful for this Pokemon
	ld hl, wDuelTempList
.loop_energy_cards_1
	ld a, [hli]
	cp $ff
	jr z, .next_play_area

	ld b, a
	push hl
	farcall CheckIfEnergyIsUseful
	pop hl
	jr nc, .loop_energy_cards_1

; first energy
	ld a, [wAITrainerCardArgs + 2]
	cp $ff
	jr nz, .second_energy_1
	ld a, b
	ld [wAITrainerCardArgs + 2], a
	call RemoveCardFromList
	jr .next_play_area
.second_energy_1
	ld a, [wAITrainerCardArgs + 3]
	cp $ff
	jr nz, .third_energy_1
	ld a, b
	ld [wAITrainerCardArgs + 3], a
	call RemoveCardFromList
	jr .next_play_area
.third_energy_1
	ld a, [wAITrainerCardArgs + 4]
	cp $ff
	jr nz, .fourth_energy_1
	ld a, b
	ld [wAITrainerCardArgs + 4], a
	call RemoveCardFromList
	jr .next_play_area
.fourth_energy_1
	ld a, b
	ld [wAITrainerCardArgs + 5], a
	jr .set_carry

.next_play_area
	inc e
	dec d
	jr nz, .loop_play_area

; next, if there are still energy cards left to choose,
; loop through the energy cards again and select
; them in order.
	ld hl, wDuelTempList
.loop_energy_cards_2
	ld a, [hli]
	cp $ff
	jr z, .check_chosen
	ld b, a
	ld a, [wAITrainerCardArgs + 2]
	cp $ff
	jr nz, .second_energy_2
	ld a, b

; first energy
	ld [wAITrainerCardArgs + 2], a
	call RemoveCardFromList
	jr .loop_energy_cards_2

.second_energy_2
	ld a, [wAITrainerCardArgs + 3]
	cp $ff
	jr nz, .third_energy_2
	ld a, b
	ld [wAITrainerCardArgs + 3], a
	call RemoveCardFromList
	jr .loop_energy_cards_2

.third_energy_2
	ld a, [wAITrainerCardArgs + 4]
	cp $ff
	jr nz, .fourth_energy_2
	ld a, b
	ld [wAITrainerCardArgs + 4], a
	call RemoveCardFromList
	jr .loop_energy_cards_2

.fourth_energy_2
	ld a, b
	ld [wAITrainerCardArgs + 5], a
	jr .set_carry

; will set carry if at least one has been chosen
.check_chosen
	ld a, [wAITrainerCardArgs + 2]
	cp $ff
	jr nz, .set_carry

.no_carry
	or a
	ret
.set_carry
	ld a, [wd084]
	ld [wAITrainerCardArgs + 1], a
	ld a, [wd082]
	scf
	ret

.RonaldsUncoolDeck:
	; if has at least 3 energies in hand, exit
	farcall CountEnergyCardsInHand
	cp 3
	ret nc

	; pick a duplicated non-Pkmn card to discard from hand
	call CreateHandCardList
	ld hl, wDuelTempList
	farcall FindDuplicateCards_IgnoreTrainerCardToPlay
	jp c, .no_carry
	ld hl, wTempAITargetNonPokemonCardDeckIndex
	cp [hl]
	jr z, .no_carry
	ld [wd082], a
	; pick another duplicated non-Pkmn card to discard from hand
	ld hl, wDuelTempList
	call FindAndRemoveCardFromList
	farcall FindDuplicateCards_IgnoreTrainerCardToPlay
	jp c, .no_carry
	ld hl, wTempAITargetNonPokemonCardDeckIndex
	cp [hl]
	jr z, .no_carry
	ld [wd084], a

	; both cards to discard were found
	; do we have 4 targets in Discard Pile?
	ld a, CARD_LOCATION_DISCARD_PILE
	farcall CreateBasicEnergyCardListInLocation
	cp 4
	jr c, .no_carry ; less than 4

	; yes, do we have at least 6?
	cp 6
	jr c, .less_than_6
	; we have at least 6
	ld a, 4 + 1
.less_than_6
	ld b, a
	ld c, 0 ; how many cards chosen
	ld de, wDuelTempList
	ld hl, wAITrainerCardArgs + 1
.loop_choose_discard_energies
	ld a, [de]
	inc de
	ld [hli], a
	cp $ff
	jr z, .set_carry
	inc c
	ld a, c
	cp b
	jr nz, .loop_choose_discard_energies
	ld a, $ff
	ld [hl], a
	jr .set_carry

; finds the card with deck index a in list hl,
; and removes it from the list.
; the card HAS to exist in the list, since this
; routine does not check for the terminating byte $ff!
; input:
;   a  = card deck index to look
;   hl = pointer to list of cards
FindAndRemoveCardFromList:
	push hl
	ld b, a
.loop
	ld a, [hli]
	cp b
	jr nz, .loop
	call RemoveCardFromList
	pop hl
	ret

AIPlay_PokemonCenter:
	ld a, [wAITrainerCardToPlay]
	ldh [hDuelActionCardIndex], a
	ld a, OPPACTION_EXECUTE_TRAINER_EFFECTS
	farcall AIMakeDecision
	ret

AIDecide_PokemonCenter:
; return if active Pokemon can KO player's card.
	farcall CheckIfArenaCardCanKnockOutDefendingCard_CheckHand
	jr c, .no_carry

	ld a, [wOpponentDeckID]
	cp IMMORTAL_POKEMON_DECK_ID
	jr z, .ImmortalPokemonDeck

	xor a
	ld [wd082], a
	ld [wd084], a
	ld [wTempAITargetPokemonCardDeckIndex], a
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	ld d, a
	ld e, PLAY_AREA_ARENA
.loop_play_area
	ld a, DUELVARS_ARENA_CARD
	add e
	get_turn_duelist_var
	call LoadCardDataToBuffer1_FromDeckIndex

; get this Pokemon's current HP in number of counters
; and add it to the total.
	ld a, [wLoadedCard1HP]
	farcall ConvertHPToCounters
	ld b, a
	ld a, [wd082]
	add b
	ld [wd082], a

; get this Pokemon's current damage counters
; and add it to the total.
	call GetCardDamageAndMaxHP
	farcall ConvertHPToCounters
	ld b, a
	ld a, [wd084]
	add b
	ld [wd084], a

; get this Pokemon's number of attached energy cards
; and add it to the total.
; if there's overflow, return no carry.
	call GetPlayAreaCardAttachedEnergies
	ld a, [wTotalAttachedEnergies]
	ld b, a
	ld a, [wTempAITargetPokemonCardDeckIndex]
	add b
	jr c, .no_carry
	ld [wTempAITargetPokemonCardDeckIndex], a

	inc e
	dec d
	jr nz, .loop_play_area

; if (number of damage counters / 2) < (total energy cards attached)
; return no carry.
	ld a, [wd084]
	srl a
	ld hl, wTempAITargetPokemonCardDeckIndex
	cp [hl]
	jr c, .no_carry

; if (number of HP counters * 6 / 10) >= (number of damage counters)
; return no carry.
	ld a, [wd082]
	ld l, a
	ld h, 6
	call HtimesL
	call CalculateWordTensDigit
	ld a, l
	ld hl, wd084
	cp [hl]
	jr nc, .no_carry

	scf
	ret

.no_carry
	or a
	ret

.ImmortalPokemonDeck:
	farcall AIDecide_PokemonCenter_ImmortalPokemonDeck
	ret

AIPlay_ImposterProfessorOak:
	ld a, [wAITrainerCardToPlay]
	ldh [hDuelActionCardIndex], a
	ld a, OPPACTION_EXECUTE_TRAINER_EFFECTS
	farcall AIMakeDecision
	ret

AIDecide_ImposterProfessorOak:
	ld a, [wOpponentDeckID]
	cp VERY_RARE_CARD_DECK_ID
	jr z, .VeryRareCardDeck
	; Weird Deck always uses it
	cp WEIRD_DECK_ID
	jr z, .set_carry
	cp STRANGE_DECK_ID
	jr z, .StrangeDeck

	ld a, DUELVARS_NUMBER_OF_CARDS_NOT_IN_DECK
	call GetNonTurnDuelistVariable
	cp DECK_SIZE - 14
	jr c, .more_than_14_cards

; if player has less than 14 cards in deck, only
; set carry if number of cards in their hands < 6
	ld a, DUELVARS_NUMBER_OF_CARDS_IN_HAND
	call GetNonTurnDuelistVariable
	cp 6
	jr c, .set_carry
.no_carry
	or a
	ret

; if player has more than 14 cards in deck, only
; set carry if number of cards in their hands >= 9
.more_than_14_cards
	ld a, DUELVARS_NUMBER_OF_CARDS_IN_HAND
	call GetNonTurnDuelistVariable
	cp 9
	jr c, .no_carry
.set_carry
	scf
	ret

.VeryRareCardDeck:
.StrangeDeck:
	; if wd033 != 0, use Imposter Professor Oak
	ld a, [wd033]
	or a
	jr nz, .set_carry
	; otherwise, use if player has at least 7 cards in hand
	ld a, DUELVARS_NUMBER_OF_CARDS_IN_HAND
	call GetNonTurnDuelistVariable
	cp 7
	jr c, .no_carry
	jr .set_carry

AIPlay_EnergySearch:
	ld a, [wAITrainerCardToPlay]
	ldh [hDuelActionCardIndex], a
	ld a, [wAITrainerCardArgs + 0]
	ldh [hDuelActionArgs + 0], a
	ld a, OPPACTION_EXECUTE_TRAINER_EFFECTS
	farcall AIMakeDecision
	ret

AIDecide_EnergySearch:
	ld a, [wOpponentDeckID]
	cp AARONS_STEP1_DECK_ID
	jr z, .AaronsStep1Deck
	cp AARONS_STEP2_DECK_ID
	jr z, .AaronsStep2Deck
	cp AARONS_STEP3_DECK_ID
	jp z, .AaronsStep3Deck
	cp POWERFUL_POKEMON_DECK_ID
	jp z, .PowerfulPokemonDeck

; generic logic
	farcall CreateEnergyCardListFromHand_OnlyBasicOrRecycleEnergy
	jr c, .asm_21d60 ; no energy in hand
	call .CheckForUsefulEnergyCards
	jr c, .asm_21d60
.no_carry
	or a
	ret
.asm_21d60
	ld a, CARD_LOCATION_DECK
	farcall CreateBasicEnergyCardListInLocation
	jr c, .no_carry ; no energy in deck
	call .CheckForUsefulEnergyCards
	jr c, .asm_21d6f
	scf
	ret
.asm_21d6f
	ld a, [wDuelTempList + 0]
	scf
	ret

.AaronsStep1Deck:
	; searches for energy that has less in hand
	ld de, FIGHTING_ENERGY
	farcall CountCardIDInHand
	push af
	ld de, GRASS_ENERGY
	farcall CountCardIDInHand
	pop bc
	cp b
	jr c, .has_less_grass_energy
	ld de, FIGHTING_ENERGY
	jr .find_energy_in_deck
.has_less_grass_energy
	ld de, GRASS_ENERGY
.find_energy_in_deck
	ld a, CARD_LOCATION_DECK
	farcall FindCardIDInLocation
	ret

.AaronsStep2Deck:
	; searches for energy that has less in hand
	ld de, PSYCHIC_ENERGY
	farcall CountCardIDInHand
	push af
	ld de, GRASS_ENERGY
	farcall CountCardIDInHand
	pop bc
	cp b
	jr c, .has_less_grass_energy
	ld de, PSYCHIC_ENERGY
	jr .find_energy_in_deck

	; unreachable
	ld de, GRASS_ENERGY
	ld a, CARD_LOCATION_DECK
	farcall FindCardIDInLocation
	ret

.AaronsStep3Deck:
	; searches for a Psychic energy in deck
	ld de, PSYCHIC_ENERGY
	ld a, CARD_LOCATION_DECK
	farcall FindCardIDInLocation
	ret

.PowerfulPokemonDeck:
	farcall AIDecide_EnergySearch_PowerfulPokemonDeck
	ret

; return carry if cards in wDuelTempList are not
; useful to any of the Play Area Pokemon
.CheckForUsefulEnergyCards:
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	ld d, a
	ld e, PLAY_AREA_ARENA
.loop_play_area
	push de
	ld a, e
	farcall CheckIfPlayAreaCardNeedsNoEnergyForAttacks
	pop de
	jr c, .next_play_area
	ld a, DUELVARS_ARENA_CARD
	add e
	push de
	get_turn_duelist_var
; store ID and type of card
	call LoadCardDataToBuffer1_FromDeckIndex
	pop de
	ld a, [wLoadedCard1ID + 0]
	ld [wTempCardID_d0a3 + 0], a
	ld a, [wLoadedCard1ID + 1]
	ld [wTempCardID_d0a3 + 1], a
	ld a, [wLoadedCard1Type]
	or TYPE_ENERGY
	ld [wTempCardType], a

; look in list for a useful energy,
; is any is found return no carry.
	ld hl, wDuelTempList
.loop_energy
	ld a, [hli]
	cp $ff
	jr z, .none_found
	ld b, a
	farcall CheckIfEnergyIsUseful
	jr nc, .loop_energy
	ld a, b
	or a
	ret
.none_found
	scf
	ret
.next_play_area
	inc e
	ld a, e
	cp d
	jr nz, .loop_play_area
	or a
	ret

; checks whether there are useful energies
; only for Fire and Lightning type Pokemon cards
; in Play Area. If none found, return carry.
; ported from TCG1, unreferenced
UnreferencedCheckUsefulFireOrLightningEnergy:
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	ld d, a
	ld e, PLAY_AREA_ARENA
.loop_play_area
	ld a, DUELVARS_ARENA_CARD
	add e
	push de
	get_turn_duelist_var

; get card's ID and Type
	call GetCardIDFromDeckIndex
	ld a, e
	ld [wTempCardID_d0a3 + 0], a
	ld a, d
	ld [wTempCardID_d0a3 + 1], a
	call LoadCardDataToBuffer1_FromCardID
	pop de
	ld a, [wLoadedCard1Type]
	or TYPE_ENERGY

; only do check if the Pokemon's type
; is either Fire or Lightning
	cp TYPE_ENERGY_FIRE
	jr z, .asm_21e35
	cp TYPE_ENERGY_LIGHTNING
	jr nz, .next_play_area
.asm_21e35
; loop each energy card in list
	ld [wTempCardType], a
	ld hl, wDuelTempList
.loop_energy
	ld a, [hli]
	cp $ff
	jr z, .next_play_area

; if this energy card is useful,
; return no carry.
	ld b, a
	push hl
	farcall CheckIfEnergyIsUseful
	pop hl
	jr nc, .loop_energy

	ld a, b
	or a
	ret

.next_play_area
	inc e
	ld a, e
	cp d
	jr nz, .loop_play_area

; no card was found to be useful
; for Fire/Lightning type Pokemon card.
	scf
	ret

; checks whether there are useful energies
; only for Grass type Pokemon cards
; in Play Area. If none found, return carry.
; ported from TCG1, unreferenced
UnreferencedCheckUsefulGrassEnergy:
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	ld d, a
	ld e, PLAY_AREA_ARENA
.loop_play_area
	ld a, DUELVARS_ARENA_CARD
	add e
	push de
	get_turn_duelist_var

; get card's ID and Type
	call GetCardIDFromDeckIndex
	ld a, e
	ld [wTempCardID_d0a3 + 0], a
	ld a, d
	ld [wTempCardID_d0a3 + 1], a
	call LoadCardDataToBuffer1_FromCardID
	pop de
	ld a, [wLoadedCard1Type]
	or TYPE_ENERGY

; only do check if the Pokemon's type is Grass
	cp TYPE_ENERGY_GRASS
	jr nz, .next_play_area

; loop each energy card in list
	ld [wTempCardType], a
	ld hl, wDuelTempList
.loop_energy
	ld a, [hli]
	cp $ff
	jr z, .next_play_area

; if this energy card is useful,
; return no carry.
	ld b, a
	push hl
	farcall CheckIfEnergyIsUseful
	pop hl
	jr nc, .loop_energy

; no card was found to be useful
; for Grass type Pokemon card.
	ld a, b
	or a
	ret

.next_play_area
	inc e
	ld a, e
	cp d
	jr nz, .loop_play_area
	scf
	ret

AIPlay_Pokedex:
	ld a, [wAITrainerCardToPlay]
	ldh [hDuelActionCardIndex], a
	ld a, [wAITrainerCardArgs + 1]
	ldh [hDuelActionArgs + 0], a
	ld a, [wAITrainerCardArgs + 2]
	ldh [hDuelActionArgs + 1], a
	ld a, [wAITrainerCardArgs + 3]
	ldh [hDuelActionArgs + 2], a
	ld a, [wAITrainerCardArgs + 4]
	ldh [hDuelActionArgs + 3], a
	ld a, [wAITrainerCardArgs + 5]
	ldh [hDuelActionArgs + 4], a
	ld a, $ff
	ldh [hDuelActionArgs + 5], a
	ld a, OPPACTION_EXECUTE_TRAINER_EFFECTS
	farcall AIMakeDecision
	ret

AIDecide_Pokedex:
; return if counter hasn't reached 6 yet
	ld a, [wAIPokedexCounter]
	cp 5 + 1
	jr c, .no_carry

; return no carry if number of cards in deck <= 4
	ld a, DUELVARS_NUMBER_OF_CARDS_NOT_IN_DECK
	get_turn_duelist_var
	cp DECK_SIZE - 4
	jr nc, .no_carry

; has a 3 in 10 chance of actually playing card
	ld a, 10
	call Random
	cp 3
	jr c, .pick_cards

.no_carry
	or a
	ret

.pick_cards
	; reset counter
	xor a
	ld [wAIPokedexCounter], a

	ld a, DUELVARS_NUMBER_OF_CARDS_NOT_IN_DECK
	get_turn_duelist_var
	add DUELVARS_DECK_CARDS
	ld l, a
	lb de, $00, $00
	ld b, 5

; run through 5 of the remaining cards in deck
.next_card
	ld a, [hli]
	ld c, a
	call .GetCardType

; load this card's deck index and type in memory
; wd084 = card types
; wTempAITargetPokemonCardDeckIndex = card deck indices
	push hl
	ld hl, wd084
	add hl, de
	ld [hl], a
	ld hl, wTempAITargetPokemonCardDeckIndex
	add hl, de
	ld [hl], c
	pop hl

	inc e
	dec b
	jr nz, .next_card

; terminate the wd084 list
	ld a, $ff
	ld [wd084 + 5], a

; the AI always orders the cards in the following way:
; Pokémon -> Trainer -> Energy
	ld de, wAITrainerCardArgs + 1
	ld hl, wd084
	ld c, $ff
	ld b, $00

.loop_pkmn_cards
	inc c
	ld a, [hli]
	cp $ff
	jr z, .find_trainers
	cp TYPE_ENERGY
	jr nc, .loop_pkmn_cards
	; is Pkmn card
	push hl
	ld hl, wTempAITargetPokemonCardDeckIndex
	add hl, bc
	ld a, [hl]
	pop hl
	ld [de], a
	inc de
	jr .loop_pkmn_cards

.find_trainers
	ld hl, wd084
	ld c, -1
	ld b, $00
.loop_trainers
	inc c
	ld a, [hli]
	cp $ff
	jr z, .find_energies
	cp TYPE_TRAINER
	jr nz, .loop_trainers
	; is Trainer card
	push hl
	ld hl, wTempAITargetPokemonCardDeckIndex
	add hl, bc
	ld a, [hl]
	pop hl
	ld [de], a
	inc de
	jr .loop_trainers

.find_energies
	ld hl, wd084
	ld c, -1
	ld b, $00
.loop_energies
	inc c
	ld a, [hli]
	cp $ff
	jr z, .done
	and TYPE_ENERGY
	jr z, .loop_energies
	; is Energy card
	push hl
	ld hl, wTempAITargetPokemonCardDeckIndex
	add hl, bc
	ld a, [hl]
	pop hl
	ld [de], a
	inc de
	jr .loop_energies

.done
	scf
	ret

.GetCardType:
	push bc
	push de
	call GetCardIDFromDeckIndex
	call GetCardType
	pop de
	pop bc
	ret

AIPlay_FullHeal:
	ld a, [wAITrainerCardToPlay]
	ldh [hDuelActionCardIndex], a
	ld a, OPPACTION_EXECUTE_TRAINER_EFFECTS
	farcall AIMakeDecision
	ret

AIDecide_FullHeal:
	; the following logic is weird and seems to be buggy
	farcall AIDecideWhetherToRetreat_IgnoreStatus
	jr nc, .continue
	; AI wants to retreat, can it (disregarding status effect)?
	farcall CheckIfArenaCardCanRetreat
	ccf
	ret nc ; can retreat
	; no, can it pay energy cost to retreat with hand card?
	ld a, [wAIPlayEnergyCardForRetreat]
	or a
	jr z, .continue ; no
	; don't use Full Heal
	or a
	ret

.continue
	; if player's card can KO it next turn, don't bother using Full Heal
	farcall CheckIfDefendingPokemonCanKnockOut
	ccf
	ret nc

	ld a, [wOpponentDeckID]
	cp BAD_DREAM_DECK_ID
	jp z, .BadDreamDeck

	ld a, DUELVARS_ARENA_CARD_STATUS
	get_turn_duelist_var

	; skip if no status on arena card
	or a
	jr z, .no_carry

	and CNF_SLP_PRZ
	cp PARALYZED
	jr z, .paralyzed
	cp ASLEEP
	jr z, .asleep
	cp CONFUSED
	jr z, .confused
	; if either PSN or DBLPSN, fallthrough

.set_carry
	scf
	ret

.asleep
	; don't use if Slowbro lv35 is the Arena card
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call GetCardIDFromDeckIndex
	cp16 SLOWBRO_LV35
	jr z, .no_carry

; set carry if any of the following
; cards are in the player's Play Area.
	ld de, GASTLY_LV8
	ld b, PLAY_AREA_ARENA
	call SwapTurn
	farcall FindCardIDInTurnDuelistsPlayArea
	call SwapTurn
	jr c, .set_carry
	ld de, GASTLY_LV17
	ld b, PLAY_AREA_ARENA
	call SwapTurn
	farcall FindCardIDInTurnDuelistsPlayArea
	call SwapTurn
	jr c, .set_carry
	ld de, HAUNTER_LV22
	ld b, PLAY_AREA_ARENA
	call SwapTurn
	farcall FindCardIDInTurnDuelistsPlayArea
	call SwapTurn
	jr c, .set_carry

; otherwise fallthrough

.paralyzed
; if Scoop Up is in hand and decided to be played, skip.
	ld de, SCOOP_UP
	farcall LookForCardIDInHandList
	jr nc, .no_scoop_up_prz
	call AIDecide_ScoopUp
	jr c, .no_carry

.no_scoop_up_prz
; return no carry if Arena card
; cannot damage the defending Pokémon

; this is a bug, since CheckIfCanDamageDefendingPokemon
; also takes into account whether card is paralyzed
	xor a
	farcall CheckIfCanDamageDefendingPokemon
	jr nc, .no_carry

; if it can play an energy card to retreat, set carry.
	ld a, [wAIPlayEnergyCardForRetreat]
	or a
	jr nz, .set_carry

; if not, check whether it's a card it would rather retreat,
; and if it isn't, set carry.
	farcall AIDecideWhetherToRetreat_ConsiderStatus
	jr nc, .set_carry

.no_carry
	or a
	ret

.confused
; if Scoop Up is in hand and decided to be played, skip.
	ld de, SCOOP_UP
	farcall LookForCardIDInHandList
	jr nc, .no_scoop_up_cnf
	call AIDecide_ScoopUp
	jr c, .no_carry

.no_scoop_up_cnf
; if card can damage defending Pokemon...
	xor a ; PLAY_AREA_ARENA
	farcall CheckIfCanDamageDefendingPokemon
	jr nc, .no_carry
; ...and can play an energy card to retreat, set carry.
	ld a, [wAIPlayEnergyCardForRetreat]
	or a
	jp nz, .set_carry
; if not, return no carry.
	jr .no_carry

.BadDreamDeck:
	; if player's Arena card isn't asleep, don't use Full Heal
	ld a, DUELVARS_ARENA_CARD_STATUS
	call GetNonTurnDuelistVariable
	and CNF_SLP_PRZ
	cp ASLEEP
	jr nz, .no_carry
	; otherwise, if opponent's Arena card is statused, use Full Heal
	ld a, DUELVARS_ARENA_CARD_STATUS
	get_turn_duelist_var
	or a
	jp nz, .set_carry
	ret

AIPlay_MrFuji:
	ld a, [wAITrainerCardToPlay]
	ldh [hDuelActionCardIndex], a
	ld a, [wAITrainerCardArgs + 0]
	ldh [hDuelActionArgs + 0], a
	ld a, OPPACTION_EXECUTE_TRAINER_EFFECTS
	farcall AIMakeDecision
	ret

AIDecide_MrFuji:
	ld a, [wOpponentDeckID]
	cp WATER_STREAM_DECK_ID
	jp z, .WaterStreamDeck
	cp RONALDS_ULTRA_DECK_ID
	jp z, .RonaldsUltraDeck

.generic_logic
	ld a, $ff
	ld [wd082], a
	ld [wd084], a

; if just one Pokemon in Play Area, skip.
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	cp 1
	ret z

	dec a
	ld d, a
	ld e, PLAY_AREA_BENCH_1

.loop_bench
	ld a, DUELVARS_ARENA_CARD
	add e
	get_turn_duelist_var
	call LoadCardDataToBuffer1_FromDeckIndex

	ld a, [wLoadedCard1HP]
	ld b, a

	; skip if zero damage counters
	call GetCardDamageAndMaxHP
	farcall ConvertHPToCounters
	or a
	jr z, .next

; a = damage counters
; b = max HP
	call CalculateBDividedByA_Bank08
	cp 20
	jr nc, .next

; here, HP left in counters is less than twice
; the number of damage counters, that is:
; remaining HP < 1/3 max HP

; if value is less than the one found before, store this one.
	ld hl, wd084
	cp [hl]
	jr nc, .next
	ld [hl], a
	ld a, e
	ld [wd082], a
.next
	inc e
	dec d
	jr nz, .loop_bench

	ld a, [wd082]
	cp $ff
	ret z

	scf
	ret

.WaterStreamDeck:
	; if no Pokémon in Play Area, skip
	; bug, this should test how many are in Bench instead
	; (this isn't ever a problem because MrFuji_BenchCheck prevents
	; this code from running without a bench)
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	or a
	ret z

	ld d, a ; num of Play Area Pokémon, should be 1 less
	ld e, PLAY_AREA_BENCH_1
.asm_220a9
	; if has energies attached...
	call GetPlayAreaCardAttachedEnergies
	ld a, [wTotalAttachedEnergies]
	or a
	jr z, .asm_220bd
	; ...and 20 or fewer HP remaining...
	ld a, e
	add DUELVARS_ARENA_CARD_HP
	get_turn_duelist_var
	cp 20 + 1
	jr nc, .asm_220bd ; > 20 remaining HP
	; ...use Mr. Fuji on this Pokémon card
	ld a, e
	scf
	ret
.asm_220bd
	inc e
	ld a, e
	cp d
	jr nz, .asm_220a9
	or a
	ret

.RonaldsUltraDeck:
	; if has more than 19 deck cards, skip
	ld a, DUELVARS_NUMBER_OF_CARDS_NOT_IN_DECK
	get_turn_duelist_var
	cp DECK_SIZE - 19
	jr nc, .has_19_or_less_deck_cards
.asm_220cb
	or a
	ret
.has_19_or_less_deck_cards
	; if has 5 or more Play Area Pokémon, then use Mr. Fuji
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	cp 5
	jr c, .asm_220cb
	jp .generic_logic

AIPlay_ScoopUp:
	ld a, [wAITrainerCardToPlay]
	ldh [hDuelActionCardIndex], a
	ld a, [wAITrainerCardArgs + 0]
	ldh [hDuelActionArgs + 0], a
	ld a, [wAITrainerCardArgs + 1]
	ldh [hDuelActionArgs + 1], a
	ld a, OPPACTION_EXECUTE_TRAINER_EFFECTS
	farcall AIMakeDecision
	ret

AIDecide_ScoopUp:
	xor a ; PLAY_AREA_ARENA
	ldh [hTempPlayAreaLocation_ff9d], a

; if only one Pokemon in Play Area, skip.
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	cp 2
	jr c, .no_carry

; handle some decks differently
	ld a, [wOpponentDeckID]
	cp PSYCHIC_ELITE_DECK_ID
	jp z, .PsychicEliteDeck
	cp RAGING_BILLOW_OF_FISTS_DECK_ID
	jp z, .RagingBillowOfFistsDeck
	cp GRAND_FIRE_DECK_ID
	jp z, .GrandFireDeck
	cp WATER_LEGEND_DECK_ID
	jr z, .WaterLegendDeck
	cp FIREBALL_DECK_ID
	jp z, .FireballDeck
	cp TEXTURE_TUNER7_DECK_ID
	jp z, .TextureTuner7Deck
	cp EVERYBODYS_FRIEND_DECK_ID
	jp z, .EverybodysFriendDeck
	cp BIG_THUNDER_DECK_ID
	jp z, .BigThunderDeck

; if it can KO the defending Pokemon this turn,
; return no carry.
	farcall CheckIfArenaCardCanKnockOutDefendingCard_CheckHand
	jr c, .no_carry

	; if not poisoned...
	ld a, DUELVARS_ARENA_CARD_STATUS
	get_turn_duelist_var
	push af
	and POISONED
	pop bc
	ld a, b
	jr nz, .is_psn_or_cannot_retreat
	; ...and not paralyzed/asleep...
	and CNF_SLP_PRZ
	cp PARALYZED
	jr z, .is_psn_or_cannot_retreat
	cp ASLEEP
	jr z, .is_psn_or_cannot_retreat
	; ...and has enough energies to retreat...
	xor a
	ldh [hTempPlayAreaLocation_ff9d], a
	call GetPlayAreaCardRetreatCost
	ld b, a
	xor a
	push bc
	call CreateArenaOrBenchEnergyCardList
	pop bc
	cp b
	jr c, .is_psn_or_cannot_retreat
	; ...then don't use Scoop Up

.no_carry
	or a
	ret

.is_psn_or_cannot_retreat
; store damage and total HP left
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call LoadCardDataToBuffer1_FromDeckIndex
	ld a, [wLoadedCard1HP]
	farcall ConvertHPToCounters
	ld d, a

; skip if card has no damage counters.
	ld e, PLAY_AREA_ARENA
	call GetCardDamageAndMaxHP
	or a
	jr z, .no_carry

; if (total damage / total HP counters) < 7
; return carry.
; (this corresponds to damage counters
; being under 70% of the max HP)
	ld b, a
	ld a, d
	call CalculateBDividedByA_Bank08
	cp 7
	jr c, .no_carry

; store Pokemon to switch to in wAITrainerCardArgs[1] and set carry.
.decide_switch
	farcall AIDecideBenchPokemonToSwitchTo
	jr c, .no_carry
	ld [wAITrainerCardArgs + 1], a
	xor a
	scf
	ret

.WaterLegendDeck:
	; if less than 3 Pokémon in play, skip
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	cp 3
	jr c, .no_carry
	; is there an Articuno lv37 in Bench?
	ld de, ARTICUNO_LV37
	ld b, PLAY_AREA_BENCH_1
	farcall FindCardIDInTurnDuelistsPlayArea
	jr c, .has_benched_articuno
	; no, is Arena card Articuno lv37 or Chansey lv40?
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call GetCardIDFromDeckIndex
	cp16 ARTICUNO_LV37
	jr z, .arena_articuno_or_chansey
	cp16 CHANSEY_LV40
	jr nz, .no_carry
.arena_articuno_or_chansey
	; yes, can it KO the player's card?
	farcall CheckIfArenaCardCanKnockOutDefendingCard_CheckHand
	jr c, .no_carry
	; no, can the player KO it next turn?
	farcall CheckIfDefendingPokemonCanKnockOut
	jr nc, .no_carry
	; yes, then use Scoop Up
	jr .decide_switch

.has_benched_articuno
	; check if it's worth Scooping up Benched Articuno
	; is the player's Arena card Snorlax lv20?
	push af
	ld a, DUELVARS_ARENA_CARD
	call GetNonTurnDuelistVariable
	call SwapTurn
	call GetCardIDFromDeckIndex
	call SwapTurn
	cp16 SNORLAX_LV20
	pop bc
	jp z, .no_carry
	; no, does Articuno have any energies?
	ld a, b
.use_scoop_up_if_no_energies
	push af
	call CreateArenaOrBenchEnergyCardList
	pop bc
	ld a, b
	jr c, .got_no_energies
	jp .no_carry
.got_no_energies
	; no energies, use Scoop Up on it
	push af
	ld a, $ff
	ld [wAITrainerCardArgs + 1], a
	pop af
	scf
	ret

.PsychicEliteDeck:
	farcall AIDecide_ScoopUp_PsychicEliteDeck
	ret

.RagingBillowOfFistsDeck:
	; use Scoop Up on a benched Mr. Mime lv20
	; if the player's card is weak to Arena card
	; or Arena card is not resistant to defending card
	farcall CheckIfDefendingCardIsWeakToArenaCard
	jr c, .asm_221f4
	farcall CheckIfArenaCardIsResistantToDefendingCard
	jp nc, .no_carry
.asm_221f4
	ld de, MR_MIME_LV20
	ld b, PLAY_AREA_BENCH_1
	farcall FindCardIDInTurnDuelistsPlayArea
	jp nc, .no_carry
	ret

.GrandFireDeck:
	; use Scoop Up on a benched Moltres lv40 if it has no energies
	ld de, MOLTRES_LV40
	ld b, PLAY_AREA_BENCH_1
	farcall FindCardIDInTurnDuelistsPlayArea
	jr c, .use_scoop_up_if_no_energies
	jp .no_carry

.FireballDeck:
	; will try to use Scoop Up on card with least remaining HP
	; if it has <= 20 HP left
	xor a ; PLAY_AREA_ARENA
	farcall FindPlayAreaCardWithLeastRemainingHP
	ret nc
	ld e, a
	; if has more than 20 HP, skip
	ld a, d
	cp 20 + 1
	ret nc
	; will use Scoop Up if it's Benched
	ld a, e
	or a
	scf
	ret nz
	; is the Arena card, can it KO the player's card?
	farcall CheckIfArenaCardCanKnockOutDefendingCard_CheckHand
	jp c, .no_carry
	; no, use Scoop Up
	jp .decide_switch

.TextureTuner7Deck:
	; skip if num of Pokémon in Play Area is <= 4
	ld a, [hl]
	cp 4
	ccf
	ret nc
	; find benched card with least remaining HP
	ld a, PLAY_AREA_BENCH_1
	farcall FindPlayAreaCardWithLeastRemainingHP
	ret nc
	ld e, a
	; if has more than 20 HP, skip
	ld a, d
	cp 20 + 1
	ret nc
	; use Scoop Up on it
	ld a, $ff
	ld [wAITrainerCardArgs + 1], a
	ld a, e
	scf
	ret

.EverybodysFriendDeck:
	farcall AIDecide_ScoopUp_EverybodysFriendDeck
	ret

.BigThunderDeck:
	farcall AIDecide_ScoopUp_BigThunderDeck
	ret

AIPlay_Maintenance:
	ld a, [wCurrentAIFlags]
	or AI_FLAG_MODIFIED_HAND
	ld [wCurrentAIFlags], a
	ld a, [wAITrainerCardToPlay]
	ldh [hDuelActionCardIndex], a
	ld a, [wAITrainerCardArgs + 1]
	ldh [hDuelActionArgs + 0], a
	ld a, [wAITrainerCardArgs + 2]
	ldh [hDuelActionArgs + 1], a
	ld a, OPPACTION_EXECUTE_TRAINER_EFFECTS
	farcall AIMakeDecision
	ret

AIDecide_Maintenance:
; skip if number of cars in hand < 4.
	ld a, DUELVARS_NUMBER_OF_CARDS_IN_HAND
	get_turn_duelist_var
	cp 4
	jr c, .no_carry

; list out all the hand cards and remove
; wAITrainerCardToPlay from list. Then find any duplicate cards.
; (removing Maintenance is unnecessary here)
	call CreateHandCardList
	ld hl, wDuelTempList
	ld a, [wAITrainerCardToPlay]
	call FindAndRemoveCardFromList
; if duplicates are not found, return no carry.
	farcall FindDuplicateCards_IgnoreTrainerCardToPlay
	jp c, .no_carry

; store the first duplicate card and remove it from the list.
; run duplicate check again.
	ld [wAITrainerCardArgs + 1], a
	ld hl, wDuelTempList
	call FindAndRemoveCardFromList
; if duplicates are not found, return no carry.
	farcall FindDuplicateCards_IgnoreTrainerCardToPlay
	jp c, .no_carry

; store the second duplicate card and return carry.
	ld [wAITrainerCardArgs + 2], a
	scf
	ret

.no_carry
	or a
	ret

AIPlay_Recycle:
	ld a, [wAITrainerCardToPlay]
	ldh [hDuelActionCardIndex], a
	ldtx de, TrainerCardSuccessCheckText
	bank1call TossCoin
	jr nc, .tails
	ld a, [wAITrainerCardArgs + 0]
	ldh [hDuelActionArgs + 0], a
	jr .asm_222b2
.tails
	ld a, $ff
	ldh [hDuelActionArgs + 0], a
.asm_222b2
	ld a, OPPACTION_EXECUTE_TRAINER_EFFECTS
	farcall AIMakeDecision
	ret

AIDecide_Recycle:
; no use checking if no cards in Discard Pile
	bank1call CreateDiscardPileCardList
	jr c, .no_carry

	ld a, $ff
	ld [wd084 + 0], a
	ld [wd084 + 1], a
	ld [wd084 + 2], a
	ld [wd084 + 3], a
	ld [wd084 + 4], a

; oversight, only Beach deck runs Recycle
; but none of the following cards are present in the deck
; this list is taken straight from TCG1 and is unmodified

	ld hl, wDuelTempList
.loop_discard_pile
	ld a, [hli]
	cp $ff
	jr z, .pick_most_important_card
	ld b, a
	call GetCardIDFromDeckIndex

	; 1: Double Colorless Energy
	cp16 DOUBLE_COLORLESS_ENERGY
	jr nz, .check_chansey
	ld a, b
	ld [wd084], a
	jr .loop_discard_pile

.check_chansey
	; 2: Chansey
	cp16 CHANSEY_LV55
	jr nz, .check_tauros
	ld a, b
	ld [wd084 + 1], a
	jr .loop_discard_pile

.check_tauros
	; 3: Tauros
	cp16 TAUROS_LV32
	jr nz, .check_jigglypuff
	ld a, b
	ld [wd084 + 2], a
	jr .loop_discard_pile

.check_jigglypuff
	; 4: Jigglypuff
	cp16 JIGGLYPUFF_LV12
	jr nz, .loop_discard_pile
	ld a, b
	ld [wd084 + 3], a
	jr .loop_discard_pile

; loop through wd084 and set carry
; on the first that was found in Discard Pile.
; if none were found, return no carry.
.pick_most_important_card
	ld hl, wd084
	ld b, 5
.loop_find
	ld a, [hli]
	cp $ff
	jr nz, .set_carry
	dec b
	jr nz, .loop_find
.no_carry
	or a
	ret
.set_carry
	scf
	ret

AIPlay_Lass:
	ld a, [wCurrentAIFlags]
	or AI_FLAG_MODIFIED_HAND
	ld [wCurrentAIFlags], a
	ld a, [wAITrainerCardToPlay]
	ldh [hDuelActionCardIndex], a
	ld a, OPPACTION_EXECUTE_TRAINER_EFFECTS
	farcall AIMakeDecision
	ret

AIDecide_Lass:
; skip if player has less than 7 cards in hand
	ld a, DUELVARS_NUMBER_OF_CARDS_IN_HAND
	call GetNonTurnDuelistVariable
	cp 7
	jr c, .no_carry

; look for Trainer cards in hand (except for Lass)
; if any is found, return no carry.
; otherwise, return carry.
	call CreateHandCardList
	ld hl, wDuelTempList
.loop
	ld a, [hli]
	cp $ff
	jr z, .set_carry
	ld b, a
	push hl
	call LoadCardDataToBuffer1_FromDeckIndex
	ld hl, wLoadedCard1ID
	cphl LASS
	pop hl
	jr z, .loop
	ld a, [wLoadedCard1Type]
	cp TYPE_TRAINER
	jr nz, .loop
.no_carry
	or a
	ret
.set_carry
	scf
	ret

AIPlay_ItemFinder:
	ld a, [wCurrentAIFlags]
	or AI_FLAG_MODIFIED_HAND
	ld [wCurrentAIFlags], a
	ld a, [wAITrainerCardToPlay]
	ldh [hDuelActionCardIndex], a
	ld a, [wAITrainerCardArgs + 1]
	ldh [hDuelActionArgs + 0], a
	ld a, [wAITrainerCardArgs + 2]
	ldh [hDuelActionArgs + 1], a
	ld a, [wAITrainerCardArgs + 0]
	ldh [hDuelActionArgs + 2], a
	ld a, OPPACTION_EXECUTE_TRAINER_EFFECTS
	farcall AIMakeDecision
	ret

AIDecide_ItemFinder:
	ld a, [wOpponentDeckID]
	cp PUPPET_MASTER_DECK_ID
	jp z, .PuppetMasterDeck
	cp AWESOME_FOSSIL_DECK_ID
	jp z, .AwesomeFossilDeck
	cp RUNNING_WILD_DECK_ID
	jp z, .RunningWildDeck
	cp SPIRITED_AWAY_DECK_ID
	jp z, .SpiritedAwayDeck
	cp SNORLAX_GUARD_DECK_ID
	jp z, .SnorlaxGuardDeck
	cp SUDDEN_GROWTH_DECK_ID
	jp z, .SuddenGrowthDeck
	cp EVERYBODYS_FRIEND_DECK_ID
	jp z, .EverybodysFriendDeck

; no other decks uses Itemfinder, so this code is unreachable
; (in fact it is taken from TCG1's logic)

; look for Energy Removal in Discard Pile
	ld de, ENERGY_REMOVAL
	ld a, CARD_LOCATION_DISCARD_PILE
	farcall FindCardIDInLocation
	jr nc, .no_carry
; found, store this deck index
	ld [wd082], a

; before looking for cards to discard in hand,
; remove any Mr Mime and Pokemon Trader cards.
; this way these are guaranteed to not be discarded.
	call CreateHandCardList
	ld hl, wDuelTempList
.loop_hand
	ld a, [hli]
	cp $ff
	jr z, .choose_discard
	ld b, a
	call GetCardIDFromDeckIndex
	cp16 MR_MIME_LV28
	jr nz, .pkmn_trader
	call RemoveCardFromList
	jr .loop_hand
.pkmn_trader
	cp16 POKEMON_TRADER
	jr nz, .loop_hand
	call RemoveCardFromList
	jr .loop_hand

; choose cards to discard from hand.
.choose_discard
	ld hl, wDuelTempList

; do not discard wAITrainerCardToPlay
	ld a, [wAITrainerCardToPlay]
	call FindAndRemoveCardFromList
	farcall FindDuplicateCards_IgnoreTrainerCardToPlay
	jp c, .no_carry

; store the duplicate found in wAITrainerCardArgs[1] and
; remove it from the hand list.
	ld [wAITrainerCardArgs + 1], a
	ld hl, wDuelTempList
	call FindAndRemoveCardFromList
; find duplicates again, if not found, return no carry.
	farcall FindDuplicateCards_IgnoreTrainerCardToPlay
	jp c, .no_carry

; store the duplicate found in wAITrainerCardArgs[2].
; output the card to be recovered from the Discard Pile.
	ld [wAITrainerCardArgs + 2], a
	ld a, [wd082]
	scf
	ret

.no_carry
	or a
	ret

.PuppetMasterDeck:
	ld de, CLEFAIRY_DOLL
	ld a, CARD_LOCATION_DISCARD_PILE
	farcall FindCardIDInLocation
	jr nc, .asm_22473
	; found a Clefairy Doll in Discard Pile
	ld [wd082], a

	ld a, $ff
	ld [wAITrainerCardArgs + 1], a
	ld [wAITrainerCardArgs + 2], a
	ld de, DEFENDER
	farcall CheckIfHandHasRepeatedCard
	call c, .AddCardToDiscard
	ld de, PLUSPOWER
	farcall CheckIfHandHasRepeatedCard
	call c, .AddCardToDiscard
	ld de, SCOOP_UP
	farcall CheckIfHandHasRepeatedCard
	call c, .AddCardToDiscard
	ld de, MASTER_BALL
	farcall CheckIfHandHasRepeatedCard
	call c, .AddCardToDiscard
	; if has 4 or more energy cards in hand, discard 2
	farcall CountEnergyCardsInHand
	cp 4
	jr c, .asm_22473
	ld a, [wDuelTempList + 0]
	call .AddCardToDiscard
	ld a, [wDuelTempList + 1]
	call .AddCardToDiscard
.asm_22473
	or a
	ret

.AwesomeFossilDeck:
	; try get Mysterious Fossil from Discard Pile
	ld de, MYSTERIOUS_FOSSIL
	ld a, CARD_LOCATION_DISCARD_PILE
	farcall FindCardIDInLocation
	jr nc, .asm_224a7
	ld [wd082], a
	; found, do we have any of the following cards in hand?
	ld de, OMANYTE_LV20
	farcall LookForCardIDInHand
	jr nc, .asm_224a9
	ld de, KABUTO_LV9
	farcall LookForCardIDInHand
	jr nc, .asm_224a9
	ld de, KABUTO_LV22
	farcall LookForCardIDInHand
	jr nc, .asm_224a9
	ld de, AERODACTYL_LV30
	farcall LookForCardIDInHand
	jr nc, .asm_224a9
.asm_224a7
	or a
	ret
.asm_224a9
	; if has 3 or more energy cards in hand, discard 2
	farcall CountBasicEnergyCardsInHand
	cp 3
	jr c, .asm_224a7
	ld a, [wDuelTempList + 0]
	ld [wAITrainerCardArgs + 1], a
	ld a, [wDuelTempList + 1]
	ld [wAITrainerCardArgs + 2], a
	ld a, [wd082]
	scf
	ret

.RunningWildDeck:
	; look for the following cards, in order, in the Discard Pile
	ld de, DEFENDER
	ld a, CARD_LOCATION_DISCARD_PILE
	farcall FindCardIDInLocation
	jr c, .asm_224f9
	ld de, ENERGY_REMOVAL
	ld a, CARD_LOCATION_DISCARD_PILE
	farcall FindCardIDInLocation
	jr c, .asm_224f9
	ld de, IMAKUNI_CARD
	ld a, CARD_LOCATION_DISCARD_PILE
	farcall FindCardIDInLocation
	jr c, .asm_224f9
	ld de, BILL
	ld a, CARD_LOCATION_DISCARD_PILE
	farcall FindCardIDInLocation
	jr c, .asm_224f9
	ld de, PROFESSOR_OAK
	ld a, CARD_LOCATION_DISCARD_PILE
	farcall FindCardIDInLocation
	jr nc, .asm_22540
.asm_224f9
	; one of the Trainer cards listed was found
	ld [wd082], a
	ld a, $ff
	ld [wAITrainerCardArgs + 1], a
	ld [wAITrainerCardArgs + 2], a
	; try discarding any of the following duplicated cards in hand
	ld de, PROFESSOR_OAK
	farcall CheckIfHandHasRepeatedCard
	call c, .AddCardToDiscard
	ld de, BILL
	farcall CheckIfHandHasRepeatedCard
	call c, .AddCardToDiscard
	ld de, IMAKUNI_CARD
	farcall CheckIfHandHasRepeatedCard
	call c, .AddCardToDiscard
	ld de, ENERGY_REMOVAL
	farcall CheckIfHandHasRepeatedCard
	call c, .AddCardToDiscard
	; if has 4 or more energy cards in hand, discard 2
	farcall CountEnergyCardsInHand
	cp 4
	jr c, .asm_22540
	ld a, [wDuelTempList + 0]
	call .AddCardToDiscard
	ld a, [wDuelTempList + 1]
	call .AddCardToDiscard
.asm_22540
	or a
	ret

.SpiritedAwayDeck:
	; look for the following cards, in order, in the Discard Pile
	ld de, SUPER_ENERGY_REMOVAL
	ld a, CARD_LOCATION_DISCARD_PILE
	farcall FindCardIDInLocation
	jr c, .asm_22591
	ld de, ENERGY_REMOVAL
	ld a, CARD_LOCATION_DISCARD_PILE
	farcall FindCardIDInLocation
	jr c, .asm_22591
	ld de, BILL
	ld a, CARD_LOCATION_DISCARD_PILE
	farcall FindCardIDInLocation
	jr c, .asm_22591
	ld de, ENERGY_RETRIEVAL
	ld a, CARD_LOCATION_DISCARD_PILE
	farcall FindCardIDInLocation
	jr c, .asm_22591
	ld de, PROFESSOR_OAK
	ld a, CARD_LOCATION_DISCARD_PILE
	farcall FindCardIDInLocation
	jr c, .asm_22591
	ld de, POKEMON_BREEDER
	ld a, CARD_LOCATION_DISCARD_PILE
	farcall FindCardIDInLocation
	jr c, .asm_22591
	ld de, COMPUTER_SEARCH
	ld a, CARD_LOCATION_DISCARD_PILE
	farcall FindCardIDInLocation
	jr c, .asm_22591
.asm_2258f
	or a
	ret
.asm_22591
	; one of the Trainer cards listed was found
	ld [wd082], a
	; if has 3 or more energy cards in hand, discard 2
	farcall CountBasicEnergyCardsInHand
	cp 3
	jr c, .asm_2258f
	ld a, [wDuelTempList + 0]
	ld [wAITrainerCardArgs + 1], a
	ld a, [wDuelTempList + 1]
	ld [wAITrainerCardArgs + 2], a
	ld a, [wd082]
	scf
	ret

.SnorlaxGuardDeck:
	; look for the following cards, in order, in the Discard Pile
	ld de, SUPER_ENERGY_REMOVAL
	ld a, CARD_LOCATION_DISCARD_PILE
	farcall FindCardIDInLocation
	jr c, .asm_225ce
	ld de, ENERGY_REMOVAL
	ld a, CARD_LOCATION_DISCARD_PILE
	farcall FindCardIDInLocation
	jr c, .asm_225ce
	ld de, SWITCH
	ld a, CARD_LOCATION_DISCARD_PILE
	farcall FindCardIDInLocation
	jr nc, .asm_22629
.asm_225ce
	; one of the Trainer cards listed was found
	ld [wd082], a
	ld a, $ff
	ld [wAITrainerCardArgs + 1], a
	ld [wAITrainerCardArgs + 2], a
	; try discarding any of the following duplicated cards in hand
	ld de, SWITCH
	farcall CheckIfHandHasRepeatedCard
	call c, .AddCardToDiscard
	ld de, SCOOP_UP
	farcall CheckIfHandHasRepeatedCard
	call c, .AddCardToDiscard
	ld de, PLUSPOWER
	farcall CheckIfHandHasRepeatedCard
	call c, .AddCardToDiscard
	ld de, BILLS_TELEPORTER
	farcall CheckIfHandHasRepeatedCard
	call c, .AddCardToDiscard
	ld de, LICKITUNG_LV26
	farcall CheckIfHandHasRepeatedCard
	call c, .AddCardToDiscard
	ld de, CHANSEY_LV55
	farcall CheckIfHandHasRepeatedCard
	call c, .AddCardToDiscard
	ld de, KANGASKHAN_LV40
	farcall CheckIfHandHasRepeatedCard
	call c, .AddCardToDiscard
	ld de, SNORLAX_LV35
	farcall CheckIfHandHasRepeatedCard
	call c, .AddCardToDiscard
.asm_22629
	or a
	ret

.SuddenGrowthDeck:
	farcall AIDecide_ItemFinder_SuddenGrowthDeck
	ret

.EverybodysFriendDeck:
	farcall AIDecide_ItemFinder_EverybodysFriendDeck
	ret

; adds card index given in a to:
; - wAITrainerCardArgs[1] if it's the first discard card;
; - wAITrainerCardArgs[2] if it's the second discard card;
; in the latter case, the rest of the caller routine is skipped
.AddCardToDiscard:
	push af
	ld a, [wAITrainerCardArgs + 1]
	cp $ff
	jr nz, .choosing_second_card
	pop af
	ld [wAITrainerCardArgs + 1], a
	ret
.choosing_second_card
	pop af
	ld [wAITrainerCardArgs + 2], a
	; skip rest of caller's instructions
	add sp, $02
	ld a, [wd082]
	scf
	ret

AIPlay_Imakuni:
	ld a, [wAITrainerCardToPlay]
	ldh [hDuelActionCardIndex], a
	ld a, OPPACTION_EXECUTE_TRAINER_EFFECTS
	farcall AIMakeDecision
	ret

AIDecide_Imakuni:
	ld a, [wOpponentDeckID]
	cp RUNNING_WILD_DECK_ID
	jr z, .RunningWildDeck

; only sets carry if Active card is not confused.
	ld a, DUELVARS_ARENA_CARD_STATUS
	get_turn_duelist_var
	and CNF_SLP_PRZ
	cp CONFUSED
	jr z, .no_carry
	scf
	ret
.no_carry
	or a
	ret

.RunningWildDeck:
	; is Arena card Dark Primeape?
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call GetCardIDFromDeckIndex
	cp16 DARK_PRIMEAPE
	jr nz, .no_carry
	; yes, does it have at least 2 energies?
	ld e, PLAY_AREA_ARENA
	call GetPlayAreaCardAttachedEnergies
	ld a, [wTotalAttachedEnergies]
	cp 2
	jr c, .no_carry
	; yes, is it already confused?
	ld a, DUELVARS_ARENA_CARD_STATUS
	get_turn_duelist_var
	and CNF_SLP_PRZ
	cp CONFUSED
	jr z, .no_carry
	; no, use Imakuni?
	scf
	ret

AIPlay_Gambler:
	ld a, [wCurrentAIFlags]
	or AI_FLAG_MODIFIED_HAND
	ld [wCurrentAIFlags], a

	; the following decks use regular RNG
	ld a, [wOpponentDeckID]
	cp DARK_SCIENCE_DECK_ID
	jr z, .no_cheated_rng
	cp COLORLESS_ENERGY_DECK_ID
	jr z, .no_cheated_rng
	cp WEIRD_DECK_ID
	jr z, .no_cheated_rng

	; for all other decks, RNG is cheated to
	; always yield heads in the coin toss

	; backup RNG
	ld hl, wRNGVars
	ld a, [hli]
	ld [wd082], a
	ld a, [hli]
	ld [wd084], a
	ld a, [hl]
	ld [wTempAITargetPokemonCardDeckIndex], a

	; use cheated RNG
	ld a, $50
	ld [hld], a
	ld [hld], a
	ld [hl], a
	ld a, [wAITrainerCardToPlay]
	ldh [hDuelActionCardIndex], a
	ld a, OPPACTION_EXECUTE_TRAINER_EFFECTS
	farcall AIMakeDecision

	; restore RNG
	ld hl, wRNGVars
	ld a, [wd082]
	ld [hli], a
	ld a, [wd084]
	ld [hli], a
	ld a, [wTempAITargetPokemonCardDeckIndex]
	ld [hl], a
	or a
	ret

.no_cheated_rng
	ld a, [wAITrainerCardToPlay]
	ldh [hDuelActionCardIndex], a
	ld a, OPPACTION_EXECUTE_TRAINER_EFFECTS
	farcall AIMakeDecision
	ret

AIDecide_Gambler:
	ld a, [wOpponentDeckID]
	cp DARK_SCIENCE_DECK_ID
	jr z, .DarkScienceDeck
	cp COLORLESS_ENERGY_DECK_ID
	jr z, .ColorlessEnergyDeck
	cp WEIRD_DECK_ID
	jr z, .set_carry

; check if flag is set for Player using MewtwoLv53 only deck
	ld a, [wAIBarrierFlagCounter]
	and AI_MEWTWO_MILL
	jr z, .no_carry

; set carry if number of cards in deck <= 4.
; this is done to counteract the deck out strategy
; of MewtwoLv53 deck, by replenishing the deck with hand cards.
	ld a, DUELVARS_NUMBER_OF_CARDS_NOT_IN_DECK
	get_turn_duelist_var
	cp DECK_SIZE - 4
	jr nc, .set_carry
.no_carry
	or a
	ret

.DarkScienceDeck:
	; return carry if less than 3 cards in hand
	ld a, DUELVARS_NUMBER_OF_CARDS_IN_HAND
	get_turn_duelist_var
	cp 3
	ret

.ColorlessEnergyDeck:
	; return carry if less than 3 cards in hand
	ld a, DUELVARS_NUMBER_OF_CARDS_IN_HAND
	get_turn_duelist_var
	cp 3
	ret c
	; return carry if 14 or fewer cards in deck
	ld a, DUELVARS_NUMBER_OF_CARDS_NOT_IN_DECK
	get_turn_duelist_var
	cp DECK_SIZE - 14
	ccf
	ret

.set_carry
	scf
	ret

AIPlay_Revive:
	ld a, [wAITrainerCardToPlay]
	ldh [hDuelActionCardIndex], a
	ld a, [wAITrainerCardArgs + 0]
	ldh [hDuelActionArgs + 0], a
	ld a, OPPACTION_EXECUTE_TRAINER_EFFECTS
	farcall AIMakeDecision
	ret

AIDecide_Revive:
; skip if no cards in Discard Pile
	bank1call CreateDiscardPileCardList
	jr c, .no_carry

; skip if number of Pokemon cards in Play Area >= 4
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	cp 4
	jr c, .continue
.no_carry
	or a
	ret

.continue
	ld a, [wOpponentDeckID]
	cp I_LOVE_PIKACHU_DECK_ID
	jp z, .ILovePikachuDeck
	cp STICKY_POISON_GAS_DECK_ID
	jp z, .StickyPoisonGasDeck

; oversight, being here means AI is using Beach deck
; but none of the following cards are present in the deck
; this list is taken straight from TCG1 and is unmodified

	ld hl, wDuelTempList
.asm_2274a
	ld a, [hli]
	cp $ff
	jr z, .no_carry
	ld b, a
	call GetCardIDFromDeckIndex
	cp16 HITMONCHAN_LV33
	jr z, .set_carry
	cp16 HITMONLEE_LV30
	jr z, .set_carry
	cp16 TAUROS_LV32
	jr nz, .asm_2274a ; bug, these two lines should be swapped
	cp16 KANGASKHAN_LV40
	jr z, .set_carry ; bug, these two lines should be swapped

.set_carry
	ld a, b
	scf
	ret

.ILovePikachuDeck:
	ld a, CARD_LOCATION_DISCARD_PILE
	call ILovePikachuDeckSearchPokemonCardInLocation
	ret

.StickyPoisonGasDeck:
	; target a Charmander in Discard Pile
	ld de, CHARMANDER_LV10
	ld a, CARD_LOCATION_DISCARD_PILE
	farcall FindCardIDInLocation
	ret c

	; otherwise, target one of the following,
	; depending on the cards in hand
	ld de, GRIMER_LV10
	ld bc, MUK
	farcall LookForCardIDInDiscardPile_GivenCardIDInHand
	ret c
	ld de, KOFFING_LV12
	ld bc, DARK_WEEZING
	farcall LookForCardIDInDiscardPile_GivenCardIDInHand
	ret c
	ld de, EKANS_LV15
	ld bc, DARK_ARBOK
	farcall LookForCardIDInDiscardPile_GivenCardIDInHand
	ret

AIPlay_PokemonFlute:
	ld a, [wAITrainerCardToPlay]
	ldh [hDuelActionCardIndex], a
	ld a, [wAITrainerCardArgs + 0]
	ldh [hDuelActionArgs + 0], a
	ld a, OPPACTION_EXECUTE_TRAINER_EFFECTS
	farcall AIMakeDecision
	ret

AIDecide_PokemonFlute:
	call SwapTurn
	bank1call CreateDiscardPileCardList
	call SwapTurn
	jr c, .no_carry

; if player's Play Area is already full, skip.
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	call GetNonTurnDuelistVariable
	ld hl, wMaxNumPlayAreaPokemon
	cp [hl]
	jr nc, .no_carry

	ld a, [wOpponentDeckID] ; duplicated instruction
	ld a, [wOpponentDeckID]
	cp WEIRD_DECK_ID
	jr z, .WeirdDeck
	cp STRANGE_DECK_ID
	jr z, .StrangeDeck

	ld a, $ff
	ld [wd082], a
	ld [wd084], a

; find Basic stage Pokemon with lowest HP in Discard Pile
	ld hl, wDuelTempList
.loop_1
	ld a, [hli]
	cp $ff
	jr z, .check_result
	ld b, a
	call SwapTurn
	call LoadCardDataToBuffer1_FromDeckIndex
	call SwapTurn
; skip this card if it's not Pokemon card
	ld a, [wLoadedCard1Type]
	cp TYPE_ENERGY
	jr nc, .loop_1
; skip this card if it's not Basic Stage
	ld a, [wLoadedCard1Stage]
	or a ; BASIC
	jr nz, .loop_1

; compare this HP with one stored
	ld a, [wLoadedCard1HP]
	push hl
	ld hl, wd082
	cp [hl]
	pop hl
	jr nc, .loop_1
; if lower, store this one
	ld [wd082], a
	ld a, b
	ld [wd084], a
	jr .loop_1

.check_result
; if lowest HP found >= 50, return no carry
	ld a, [wd082]
	cp 50
	jr nc, .no_carry
; otherwise output its deck index in a and set carry.
	ld a, [wd084]
	scf
	ret
.no_carry
	or a
	ret

.StrangeDeck:
	; only use Pokémon Flute if Dark Hypno is
	; in Play Area and has energies for its attack
	ld de, DARK_HYPNO
	farcall CheckCardIDInPlayAreaThatCanUseAttacks
	jr nc, .no_carry
;	fallthrough

.WeirdDeck:
; look for any Basic Pokemon card
	ld hl, wDuelTempList
.loop_2
	ld a, [hli]
	cp $ff
	jr z, .no_carry
	ld b, a
	call SwapTurn
	call LoadCardDataToBuffer1_FromDeckIndex
	call SwapTurn
	ld a, [wLoadedCard1Type]
	cp TYPE_ENERGY
	jr nc, .loop_2
	ld a, [wLoadedCard1Stage]
	or a ; BASIC
	jr nz, .loop_2

; a Basic stage Pokemon was found, return carry
	ld a, b
	scf
	ret

AIPlay_ClefairyDollOrMysteriousFossil:
	ld a, [wAITrainerCardToPlay]
	ldh [hDuelActionCardIndex], a
	ld a, OPPACTION_EXECUTE_TRAINER_EFFECTS
	farcall AIMakeDecision
	ret

AIDecide_ClefairyDollOrMysteriousFossil:
; if has max number of Play Area Pokemon, skip
; (oversight, should use [wMaxNumPlayAreaPokemon] instead)
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	cp MAX_PLAY_AREA_POKEMON
	jr nc, .no_carry

; store number of Play Area Pokemon cards
	ld [wd082], a
	ld a, [wOpponentDeckID]
	cp PUPPET_MASTER_DECK_ID
	jp z, .PuppetMasterDeck
	cp LEGENDARY_FOSSIL_DECK_ID
	jp z, .LegendaryFossilDeck

; if the Arena card is Wigglytuff, return carry
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call GetCardIDFromDeckIndex
	cp16 WIGGLYTUFF_LV36
	jr z, .set_carry

; if number of Play Area Pokemon >= 4, return no carry
	ld a, [wd082]
	cp 4
	jr nc, .no_carry

.set_carry
	scf
	ret
.no_carry
	or a
	ret

.PuppetMasterDeck:
	; if Hypno lv30 is in Play Area and
	; can use its second attack, play Clefairy Doll
	ld de, HYPNO_LV30
	ld b, PLAY_AREA_BENCH_1
	farcall FindCardIDInTurnDuelistsPlayArea
	ret nc
	ldh [hTempPlayAreaLocation_ff9d], a
	ld a, SECOND_ATTACK
	ld [wSelectedAttack], a
	farcall CheckIfSelectedAttackIsUnusable
	ccf
	ret

.LegendaryFossilDeck:
	; if Aerodactyl lv28 is in Play Area, play Mysterious Fossil
	; bug, AI will never play Mysterious Fossil because
	; getting Aerodactyl in play otherwise is impossible
	; the intention is to reverse the logic and instead play
	; Mysterious Fossil if Aerodactyl is NOT in play yet
	ld de, AERODACTYL_LV28
	ld b, PLAY_AREA_ARENA
	farcall FindCardIDInTurnDuelistsPlayArea
	ret

AIPlay_Pokeball:
	ld a, [wAITrainerCardToPlay]
	ldh [hDuelActionCardIndex], a
	ldtx de, TrainerCardSuccessCheckText
	bank1call TossCoin
	ldh [hDuelActionArgs + 0], a
	jr nc, .tails
	ld a, [wAITrainerCardArgs + 0]
	ldh [hDuelActionArgs + 1], a
	jr .asm_228d1
.tails
	ld a, $ff
	ldh [hDuelActionArgs + 1], a
.asm_228d1
	ld a, OPPACTION_EXECUTE_TRAINER_EFFECTS
	farcall AIMakeDecision
	ret

AIDecide_Pokeball:
	ld a, [wOpponentDeckID]
	cp GRAND_FIRE_DECK_ID
	jp z, .GrandFireDeck ; Func_2291e
	cp TRIPLE_ZAPDOS_DECK_ID
	jp z, .TripleZapdosDeck ; Func_22965
	cp I_LOVE_PIKACHU_DECK_ID
	jp z, .ILovePikachuDeck ; .ILovePikachuDeck
	cp MAX_ENERGY_DECK_ID
	jp z, .MaxEnergyDeck ; .MaxEnergyDeck
	cp REMAINING_GREEN_DECK_ID
	jp z, .RemainingGreenDeck ; .RemainingGreenDeck
	cp GATHERING_NIDORAN_DECK_ID
	jp z, .GatheringNidoranDeck ; .GatheringNidoranDeck
	cp BUG_COLLECTING_DECK_ID
	jp z, .BugCollectingDeck ; .BugCollectingDeck
	cp COMPLETE_COMBUSTION_DECK_ID
	jp z, .CompleteCombustionDeck ; .CompleteCombustionDeck
	cp FIREBALL_DECK_ID
	jp z, .FireballDeck ; .FireballDeck
	cp WHIRLPOOL_SHOWER_DECK_ID
	jp z, .WhirlpoolShowerDeck ; .WhirlpoolShowerDeck
	cp PARALYZED_PARALYZED_DECK_ID
	jp z, .ParalyzedParalyzedDeck ; .ParalyzedParalyzedDeck
	cp ROCK_BLAST_DECK_ID
	jp z, .RockBlastDeck ; .RockBlastDeck
	cp BAD_DREAM_DECK_ID
	jp z, .BadDreamDeck ; .BadDreamDeck
	or a
	ret

.GrandFireDeck:
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	cp 2
	jr nc, .asm_22935
	; only 1 Pokémon in Play Area, try to look for Magmar
	ld de, MAGMAR_LV31
	ld a, CARD_LOCATION_DECK
	farcall FindCardIDInLocation
	ret c
	; none found, look for any Basic Pokémon
	farcall CheckIfAnyBasicPokemonInDeck
	ld a, e
	ret
.asm_22935
	; at least 2 Play Area Pokémon
	ld bc, PONYTA_LV8
	ld de, RAPIDASH_LV33
	farcall CheckReelInEvoLineTarget
	ret c
	ld bc, VULPIX_LV11
	ld de, NINETALES_LV35
	farcall CheckReelInEvoLineTarget
	ret c
	ld bc, VULPIX_LV13
	ld de, NINETALES_LV35
	farcall CheckReelInEvoLineTarget
	ret c

	; if has no energy cards in hand, look for Moltres lv40
	farcall CountEnergyCardsInHand
	ret nc
	ld de, MOLTRES_LV40
	ld a, CARD_LOCATION_DECK
	farcall FindCardIDInLocation
	ret

.TripleZapdosDeck:
	; look for Zapdos cards
	ld de, ZAPDOS_LV28
	ld a, CARD_LOCATION_DECK
	farcall FindCardIDInLocation
	ret c
	ld de, ZAPDOS_LV40
	ld a, CARD_LOCATION_DECK
	farcall FindCardIDInLocation
	ret c
	ld de, ZAPDOS_LV64
	ld a, CARD_LOCATION_DECK
	farcall FindCardIDInLocation
	ret c

	; none found, look for Voltorb/Dark Electrode
	; or Doduo/Dodrio
	ld bc, VOLTORB_LV8
	ld de, DARK_ELECTRODE
	farcall CheckReelInEvoLineTarget
	ret c
	ld bc, DODUO_LV8
	ld de, DODRIO_LV25
	farcall CheckReelInEvoLineTarget
	ret c

	; otherwise look for any Basic Pokémon card
	farcall CheckIfAnyBasicPokemonInDeck
	ld a, e
	ret

.ILovePikachuDeck:
	; if has 3 or more pokémon in Play Area, don't use Pokéball
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	cp 3
	jr c, .asm_229a8
.asm_229a6
	or a
	ret
.asm_229a8
	; if already has a Basic Pokémon in hand, don't use Pokéball
	farcall CountNumberOfBasicPokemonInHand
	or a
	jr nz, .asm_229a6
	; otherwise look for a Pokémon in order
	ld a, CARD_LOCATION_DECK
	call ILovePikachuDeckSearchPokemonCardInLocation
	ret

.MaxEnergyDeck:
	farcall CountNumberOfBasicPokemonInHandOrPlayArea
	cp 3
	jr nc, .asm_229f6

	; has less than 3 Pokémon in play/hand
	; is there a Bulbasaur in hand/Play Area?
	ld de, BULBASAUR_LV12
	farcall IsCardIDInHandOrPlayArea
	jr c, .asm_229d0
	; no, look for it in Deck
	ld de, BULBASAUR_LV12
	ld a, CARD_LOCATION_DECK
	farcall FindCardIDInLocation
	ret c
.asm_229d0
	; is there a Caterpie in hand/Play Area?
	ld de, CATERPIE
	farcall IsCardIDInHandOrPlayArea
	jr c, .asm_229e3
	; no, look for it in Deck
	ld de, CATERPIE
	ld a, CARD_LOCATION_DECK
	farcall FindCardIDInLocation
	ret c
.asm_229e3
	; is there a Exeggcute in hand/Play Area?
	ld de, EXEGGCUTE
	farcall IsCardIDInHandOrPlayArea
	jr c, .asm_229f6
	; no, look for it in Deck
	ld de, EXEGGCUTE
	ld a, CARD_LOCATION_DECK
	farcall FindCardIDInLocation
	ret c

.asm_229f6
	; has 3 or more Pokémon in play/hand or
	; none of the cards above were found
	ld bc, EXEGGCUTE
	ld de, EXEGGUTOR
	farcall CheckReelInEvoLineTarget
	ret c
	ld bc, CATERPIE
	ld de, METAPOD_LV20
	farcall LookForEvoCardInDeck_GivenPreevoInHandOrPlayArea
	ret c
	ld bc, METAPOD_LV20
	ld de, BUTTERFREE
	farcall LookForEvoCardInDeck_GivenPreevoInHandOrPlayArea
	ret c
	ld de, CATERPIE
	ld bc, METAPOD_LV20
	farcall LookForCardIDInDeck_GivenCardIDInHand
	ret c
	ld de, METAPOD_LV20
	ld bc, BUTTERFREE
	farcall LookForCardIDInDeck_GivenCardIDInHand
	ret c
	ld bc, BULBASAUR_LV12
	ld de, IVYSAUR_LV26
	farcall LookForEvoCardInDeck_GivenPreevoInHandOrPlayArea
	ret c
	ld bc, IVYSAUR_LV26
	ld de, VENUSAUR_LV67
	farcall LookForEvoCardInDeck_GivenPreevoInHandOrPlayArea
	ret c
	ld de, BULBASAUR_LV12
	ld bc, IVYSAUR_LV26
	farcall LookForCardIDInDeck_GivenCardIDInHand
	ret c
	ld de, IVYSAUR_LV26
	ld bc, VENUSAUR_LV67
	farcall LookForCardIDInDeck_GivenCardIDInHand
	ret

.RemainingGreenDeck:
	; use Pokéball on any Basic card in deck
	; if less than 6 Pokémon in play
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	cp 6
	jr c, .asm_22a62
	or a
	ret
.asm_22a62
	farcall CheckIfAnyBasicPokemonInDeck
	ld a, e
	ret

.GatheringNidoranDeck:
	ld bc, NIDORANM_LV22
	ld de, NIDORINO_LV23
	farcall LookForEvoCardInDeck_GivenPreevoInHandOrPlayArea
	ret c
	ld bc, NIDORANM_LV22
	ld de, NIDORINO_LV25
	farcall LookForEvoCardInDeck_GivenPreevoInHandOrPlayArea
	ret c
	ld bc, NIDORINO_LV23
	ld de, NIDOKING
	farcall LookForEvoCardInDeck_GivenPreevoInHandOrPlayArea
	ret c
	ld bc, NIDORINO_LV25
	ld de, NIDOKING
	farcall LookForEvoCardInDeck_GivenPreevoInHandOrPlayArea
	ret c
	ld de, NIDORANM_LV22
	ld bc, NIDORINO_LV23
	farcall LookForCardIDInDeck_GivenCardIDInHand
	ret c
	ld de, NIDORANM_LV22
	ld bc, NIDORINO_LV25
	farcall LookForCardIDInDeck_GivenCardIDInHand
	ret c
	ld de, NIDORINO_LV23
	ld bc, NIDOKING
	farcall LookForCardIDInDeck_GivenCardIDInHand
	ret c
	ld de, NIDORINO_LV25
	ld bc, NIDOKING
	farcall LookForCardIDInDeck_GivenCardIDInHand
	ret c
	ld bc, NIDORANF_LV12
	ld de, NIDORINA_LV22
	farcall LookForEvoCardInDeck_GivenPreevoInHandOrPlayArea
	ret c
	ld bc, NIDORANF_LV13
	ld de, NIDORINA_LV22
	farcall LookForEvoCardInDeck_GivenPreevoInHandOrPlayArea
	ret c
	ld bc, NIDORINA_LV22
	ld de, NIDOQUEEN
	farcall LookForEvoCardInDeck_GivenPreevoInHandOrPlayArea
	ret c
	ld de, NIDORANF_LV12
	ld bc, NIDORINA_LV22
	farcall LookForCardIDInDeck_GivenCardIDInHand
	ret c
	ld de, NIDORANF_LV13
	ld bc, NIDORINA_LV22
	farcall LookForCardIDInDeck_GivenCardIDInHand
	ret c
	ld de, NIDORINA_LV22
	ld bc, NIDOQUEEN
	farcall LookForCardIDInDeck_GivenCardIDInHand
	ret

.BugCollectingDeck:
	ld bc, BULBASAUR_LV15
	ld de, DARK_IVYSAUR
	farcall LookForEvoCardInDeck_GivenPreevoInHandOrPlayArea
	ret c
	ld bc, DARK_IVYSAUR
	ld de, DARK_VENUSAUR
	farcall LookForEvoCardInDeck_GivenPreevoInHandOrPlayArea
	ret c
	ld de, BULBASAUR_LV15
	ld bc, DARK_IVYSAUR
	farcall LookForCardIDInDeck_GivenCardIDInHand
	ret c
	ld de, DARK_IVYSAUR
	ld bc, DARK_VENUSAUR
	farcall LookForCardIDInDeck_GivenCardIDInHand
	ret

.CompleteCombustionDeck:
	ld de, MAGMAR_LV27
	ld a, CARD_LOCATION_DECK
	farcall FindCardIDInLocation
	ret c
	ld de, PONYTA_LV15
	ld a, CARD_LOCATION_DECK
	farcall FindCardIDInLocation
	ret c
	ld de, GROWLITHE_LV12
	ld a, CARD_LOCATION_DECK
	farcall FindCardIDInLocation
	ret c
	ld de, KANGASKHAN_LV40
	ld a, CARD_LOCATION_DECK
	farcall FindCardIDInLocation
	ret c
	ld de, MEOWTH_LV14
	ld a, CARD_LOCATION_DECK
	farcall FindCardIDInLocation
	ret

.FireballDeck:
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	cp 1
	jr nz, .asm_22b8f
	; only one Pokémon in play
	ld de, CHARMANDER_LV9
	ld a, CARD_LOCATION_DECK
	farcall FindCardIDInLocation
	ret c
	ld de, SQUIRTLE_LV16
	ld a, CARD_LOCATION_DECK
	farcall FindCardIDInLocation
	ret c
	ld de, MACHOP_LV24
	ld a, CARD_LOCATION_DECK
	farcall FindCardIDInLocation
	ret c
	ld de, DODUO_LV10
	ld a, CARD_LOCATION_DECK
	farcall FindCardIDInLocation
	ret

.asm_22b8f
	; at least 2 Pokémon in play
	ld bc, CHARMANDER_LV9
	ld de, DARK_CHARMELEON
	farcall LookForEvoCardInDeck_GivenPreevoInHandOrPlayArea
	ret c
	ld bc, DARK_CHARMELEON
	ld de, DARK_CHARIZARD
	farcall LookForEvoCardInDeck_GivenPreevoInHandOrPlayArea
	ret c
	ld de, CHARMANDER_LV9
	ld bc, DARK_CHARMELEON
	farcall LookForCardIDInDeck_GivenCardIDInHand
	ret c
	ld de, DARK_CHARMELEON
	ld bc, DARK_CHARIZARD
	farcall LookForCardIDInDeck_GivenCardIDInHand
	ret

.WhirlpoolShowerDeck:
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	cp 1
	jr nz, .asm_22be2
	; only one Pokémon in play
	ld de, STARYU_LV15
	ld a, CARD_LOCATION_DECK
	farcall FindCardIDInLocation
	ret c
	ld de, EEVEE_LV9
	ld bc, DARK_VAPOREON
	farcall LookForCardIDInDeck_GivenCardIDInHand
	ret c
	ld de, VOLTORB_LV10
	ld bc, ELECTRODE_LV42
	farcall LookForCardIDInDeck_GivenCardIDInHand
	ret

.asm_22be2
	; at least 2 Pokémon in play
	ld bc, EEVEE_LV9
	ld de, DARK_VAPOREON
	farcall LookForEvoCardInDeck_GivenPreevoInHandOrPlayArea
	ret c
	ld de, EEVEE_LV9
	ld bc, DARK_VAPOREON
	farcall LookForCardIDInDeck_GivenCardIDInHand
	ret

.ParalyzedParalyzedDeck:
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	cp 1
	jr nz, .asm_22c1f
	; only one Pokémon in play
	ld de, POLIWAG_LV15
	ld a, CARD_LOCATION_DECK
	farcall FindCardIDInLocation
	ret c
	ld de, SQUIRTLE_LV8
	ld bc, WARTORTLE_LV24
	farcall LookForCardIDInDeck_GivenCardIDInHand
	ret c
	ld de, MAGIKARP_LV6
	ld bc, DARK_GYARADOS
	farcall LookForCardIDInDeck_GivenCardIDInHand
	ret

.asm_22c1f
	; at least 2 Pokémon in play
	ld bc, MAGIKARP_LV6
	ld de, DARK_GYARADOS
	farcall LookForEvoCardInDeck_GivenPreevoInHandOrPlayArea
	ret c
	ld de, MAGIKARP_LV6
	ld bc, DARK_GYARADOS
	farcall LookForCardIDInDeck_GivenCardIDInHand
	ret

.RockBlastDeck:
	ld bc, GEODUDE_LV16
	ld de, GRAVELER_LV28
	farcall LookForEvoCardInDeck_GivenPreevoInHandOrPlayArea
	ret c
	ld bc, GRAVELER_LV28
	ld de, GOLEM_LV37
	farcall LookForEvoCardInDeck_GivenPreevoInHandOrPlayArea
	ret c
	ld bc, DIGLETT_LV15
	ld de, DARK_DUGTRIO
	farcall CheckReelInEvoLineTarget
	ret c
	farcall CheckIfAnyBasicPokemonInDeck
	ld a, e
	ret

.BadDreamDeck:
	ld de, HAUNTER_LV22
	ld a, CARD_LOCATION_DECK
	farcall FindCardIDInLocation
	ret c
	ld de, HAUNTER_LV17
	ld a, CARD_LOCATION_DECK
	farcall FindCardIDInLocation
	ret c
	ld de, DROWZEE_LV10
	ld a, CARD_LOCATION_DECK
	farcall FindCardIDInLocation
	ret c
	ld de, KANGASKHAN_LV40
	ld a, CARD_LOCATION_DECK
	farcall FindCardIDInLocation
	ret c
	ld de, GASTLY_LV13
	ld a, CARD_LOCATION_DECK
	farcall FindCardIDInLocation
	ret c
	ld de, GENGAR_LV40
	ld a, CARD_LOCATION_DECK
	farcall FindCardIDInLocation
	ret c
	ld de, DARK_HYPNO
	ld a, CARD_LOCATION_DECK
	farcall FindCardIDInLocation
	ret

; input:
; - a = CARD_LOCATION_* constant
ILovePikachuDeckSearchPokemonCardInLocation:
	ld [wd082], a
	ld de, FLYING_PIKACHU_LV12
	ld a, [wd082]
	farcall FindCardIDInLocation
	ret c
	ld de, FLYING_PIKACHU_ALT_LV12
	ld a, [wd082]
	farcall FindCardIDInLocation
	ret c
	ld de, PIKACHU_LV16
	ld a, [wd082]
	farcall FindCardIDInLocation
	ret c
	ld de, PIKACHU_ALT_LV16
	ld a, [wd082]
	farcall FindCardIDInLocation
	ret c
	ld de, PIKACHU_LV5
	ld a, [wd082]
	farcall FindCardIDInLocation
	ret c
	ld de, PIKACHU_LV13
	ld a, [wd082]
	farcall FindCardIDInLocation
	ret c
	ld de, SURFING_PIKACHU_LV13
	ld a, [wd082]
	farcall FindCardIDInLocation
	ret c
	ld de, SURFING_PIKACHU_ALT_LV13
	ld a, [wd082]
	farcall FindCardIDInLocation
	ret

AIPlay_ComputerSearch:
	ld a, [wCurrentAIFlags]
	or AI_FLAG_MODIFIED_HAND
	ld [wCurrentAIFlags], a
	ld a, [wAITrainerCardToPlay]
	ldh [hDuelActionCardIndex], a
	ld a, [wAITrainerCardArgs + 0]
	ldh [hDuelActionArgs + 2], a
	ld a, [wAITrainerCardArgs + 1]
	ldh [hDuelActionArgs + 0], a
	ld a, [wAITrainerCardArgs + 2]
	ldh [hDuelActionArgs + 1], a
	ld a, OPPACTION_EXECUTE_TRAINER_EFFECTS
	farcall AIMakeDecision
	ret

AIDecide_ComputerSearch:
; skip if number of cards in hand < 3
	ld a, DUELVARS_NUMBER_OF_CARDS_IN_HAND
	get_turn_duelist_var
	cp 3
	jr c, .no_carry

	ld a, [wOpponentDeckID]
	cp RAIN_DANCE_CONFUSION_DECK_ID
	jp z, .RainDanceConfusionDeck ; .RainDanceConfusionDeck
	cp LEGENDARY_FOSSIL_DECK_ID
	jp z, .LegendaryFossilDeck ; .LegendaryFossilDeck
	cp MAD_PETALS_DECK_ID
	jp z, .MadPetalsDeck ; .MadPetalsDeck
	cp SPIRITED_AWAY_DECK_ID
	jp z, .SpiritedAwayDeck ; .SpiritedAwayDeck
	cp EYE_OF_THE_STORM_DECK_ID
	jp z, .EyeOfTheStormDeck ; .EyeOfTheStormDeck
	cp SUDDEN_GROWTH_DECK_ID
	jp z, .SuddenGrowthDeck ; .SuddenGrowthDeck
	cp EVERYBODYS_FRIEND_DECK_ID
	jp z, .EverybodysFriendDeck ; .EverybodysFriendDeck
	cp IMMORTAL_POKEMON_DECK_ID
	jp z, .ImmortalPokemonDeck ; .ImmortalPokemonDeck
	cp TORRENTIAL_FLOOD_DECK_ID
	jp z, .TorrentialFloodDeck ; .TorrentialFloodDeck
.no_carry
	or a
	ret

.RainDanceConfusionDeck:
	farcall AIDecide_ComputerSearch_RainDanceConfusionDeck
	ret

.LegendaryFossilDeck:
	; if Mysterious Fossil in play/hand,
	; then look for an Aerodactyl in deck
	ld bc, MYSTERIOUS_FOSSIL
	ld de, AERODACTYL_LV28
	farcall LookForEvoCardInDeck_GivenPreevoInHandOrPlayArea
	ld b, a
	jr c, .asm_22d97

	; else, look for Pluspower instead
	ld de, PLUSPOWER
	farcall IsCardIDInDeckAndNotInHand
	jr nc, .asm_22d7b
	; found, target it if AI is going to use it this turn
	push af
	call AIDecide_PlusPower_Phase13
	pop bc
	jr c, .asm_22d97

.asm_22d7b
	; else, look for Professor Oak instead
	ld de, PROFESSOR_OAK
	farcall IsCardIDInDeckAndNotInHand
	jr nc, .asm_22d8b
	; found, target it if AI is going to use it this turn
	push af
	call AIDecide_ProfessorOak
	pop bc
	jr c, .asm_22d97

.asm_22d8b
	; else, look for Bill instead
	ld de, BILL
	farcall IsCardIDInDeckAndNotInHand
	ld b, a
	jr c, .asm_22d97
.asm_22d95
	or a
	ret

.asm_22d97
	; b = card to search in deck
	ld a, b
	ld [wd082], a

	; find 2 other Trainer cards in hand to discard
	call CreateHandCardList
	ld hl, wDuelTempList
	ld d, AI_SEARCH_ONLY_TRAINER
	ld a, [wAITrainerCardToPlay]
	ld e, a
	farcall TakeOutDifferentCardOfSpecificTypeFromListInHL
	jr nc, .asm_22d95
	ld [wAITrainerCardArgs + 1], a
	farcall TakeOutDifferentCardOfSpecificTypeFromListInHL
	jr nc, .asm_22d95
	ld [wAITrainerCardArgs + 2], a
	ld a, [wd082]
	scf
	ret

.MadPetalsDeck:
	farcall AIDecide_ComputerSearch_MadPetalsDeck_FindTarget
	ret nc
	ld [wd082], a

	; find 2 other Trainer cards in hand to discard
	call CreateHandCardList
	ld hl, wDuelTempList
	ld d, AI_SEARCH_ONLY_TRAINER
	ld a, [wAITrainerCardToPlay]
	ld e, a
	farcall TakeOutDifferentCardOfSpecificTypeFromListInHL
	jr nc, .asm_22de9
	ld [wAITrainerCardArgs + 1], a
	farcall TakeOutDifferentCardOfSpecificTypeFromListInHL
	jr nc, .asm_22df6
	ld [wAITrainerCardArgs + 2], a
	ld a, [wd082]
	scf
	ret

.asm_22de9
	; otherwise look for any Pokémon card in hand to discard
	ld d, AI_SEARCH_ONLY_PKMN
	ld e, NONE
	farcall TakeOutDifferentCardOfSpecificTypeFromListInHL
	jr nc, .asm_22e08
	ld [wAITrainerCardArgs + 1], a
.asm_22df6
	ld d, AI_SEARCH_ONLY_PKMN
	ld e, NONE
	farcall TakeOutDifferentCardOfSpecificTypeFromListInHL
	jr nc, .asm_22e08
	ld [wAITrainerCardArgs + 2], a
	ld a, [wd082]
	scf
	ret
.asm_22e08
	or a
	ret

.SpiritedAwayDeck:
	farcall AIDecide_ComputerSearch_SpiritedAwayDeck
	ret

.EyeOfTheStormDeck:
	farcall AIDecide_ComputerSearch_EyeOfTheStormDeck
	ret

.SuddenGrowthDeck:
	farcall AIDecide_ComputerSearch_SuddenGrowthDeck
	ret

.EverybodysFriendDeck:
	farcall AIDecide_ComputerSearch_EverybodysFriendDeck
	ret

.ImmortalPokemonDeck:
	farcall AIDecide_ComputerSearch_ImmortalPokemonDeck
	ret

.TorrentialFloodDeck:
	farcall AIDecide_ComputerSearch_TorrentialFloodDeck
	ret

AIPlay_PokemonTrader:
	ld a, [wAITrainerCardToPlay]
	ldh [hDuelActionCardIndex], a
	ld a, [wAITrainerCardArgs + 0]
	ldh [hDuelActionArgs + 0], a
	ld a, [wAITrainerCardArgs + 1]
	ldh [hDuelActionArgs + 1], a
	ld a, OPPACTION_EXECUTE_TRAINER_EFFECTS
	farcall AIMakeDecision
	ld a, $01
	ld [wd081], a
	ret

AIDecide_PokemonTrader:
	ld a, [wd081]
	or a
	ret nz
	ld a, [wOpponentDeckID]
	cp PSYCHIC_ELITE_DECK_ID
	jp z, .PsychicEliteDeck
	cp PSYCHOKINESIS_DECK_ID
	jp z, .PsychokinesisDeck
	cp GATHERING_NIDORAN_DECK_ID
	jp z, .GatheringNidoranDeck
	cp RAIN_DANCE_CONFUSION_DECK_ID
	jp z, .RainDanceConfusionDeck
	cp GO_ARCANINE_DECK_ID
	jp z, .GoArcanineDeck
	cp MAD_PETALS_DECK_ID
	jp z, .MadPetalsDeck
	cp DANGEROUS_BENCH_DECK_ID
	jp z, .DangerousBenchDeck
	cp EEVEE_SHOWDOWN_DECK_ID
	jp z, .EeveeShowdownDeck
	cp GAZE_UPON_THE_POWER_OF_FIRE_DECK_ID
	jp z, .GazeUponThePowerOfFireDeck
	cp BENCH_CALL_DECK_ID
	jp z, .BenchCallDeck
	cp WATER_STREAM_DECK_ID
	jp z, .WaterStreamDeck
	cp FULL_STRENGTH_DECK_ID
	jp z, .FullStrengthDeck
	cp DIRECT_HIT_DECK_ID
	jp z, .DirectHitDeck
	cp BAD_GUYS_DECK_ID
	jp z, .BadGuysDeck
	cp POISON_MIST_DECK_ID
	jp z, .PoisonMistDeck
	cp ULTRA_REMOVAL_DECK_ID
	jp z, .UltraRemovalDeck
	cp COLORLESS_ENERGY_DECK_ID
	jp z, .ColorlessEnergyDeck
	cp RONALDS_PSYCHIC_DECK_ID
	jp z, .RonaldsPsychicDeck
	cp RONALDS_ULTRA_DECK_ID
	jp z, .RonaldsUltraDeck
	cp IMMORTAL_POKEMON_DECK_ID
	jp z, .ImmortalPokemonDeck
	cp TORRENTIAL_FLOOD_DECK_ID
	jp z, .TorrentialFloodDeck
	cp TRAINER_IMPRISON_DECK_ID
	jp z, .TrainerImprisonDeck
	cp BLAZING_FLAME_DECK_ID
	jp z, .BlazingFlameDeck
	cp DAMAGE_CHAOS_DECK_ID
	jp z, .DamageChaosDeck
	cp BIG_THUNDER_DECK_ID
	jp z, .BigThunderDeck
	or a
	ret

.PsychicEliteDeck:
	ld bc, ABRA_LV14
	ld de, KADABRA_LV39
	farcall LookForEvoCardInDeck_GivenPreevoInHandOrPlayArea
	jr c, .asm_22f0e
	ld bc, KADABRA_LV39
	ld de, ALAKAZAM_LV42
	farcall LookForEvoCardInDeck_GivenPreevoInHandOrPlayArea
	jr c, .asm_22f0e
	ld de, ABRA_LV14
	ld bc, KADABRA_LV39
	farcall LookForCardIDInDeck_GivenCardIDInHand
	jr c, .asm_22f0e
	ld de, KADABRA_LV39
	ld bc, ALAKAZAM_LV42
	farcall LookForCardIDInDeck_GivenCardIDInHand
	jr c, .asm_22f0e
	ld de, MR_MIME_LV20
	farcall IsCardIDInHandOrPlayArea
	jr c, .asm_22f17
	ld de, MR_MIME_LV20
	ld a, CARD_LOCATION_DECK
	farcall FindCardIDInLocation
	jr nc, .asm_22f17
.asm_22f0e
	ld [wAITrainerCardArgs + 1], a
	farcall FindDuplicatePokemonCardsInHand
	jr c, .asm_22f19
.asm_22f17
	or a
	ret
.asm_22f19
	scf
	ret

.PsychokinesisDeck:
	ld bc, ABRA_LV8
	ld de, KADABRA_LV39
	farcall LookForEvoCardInDeck_GivenPreevoInHandOrPlayArea
	jr c, .asm_22f7b
	ld bc, KADABRA_LV39
	ld de, ALAKAZAM_LV45
	farcall LookForEvoCardInDeck_GivenPreevoInHandOrPlayArea
	jr c, .asm_22f7b
	ld de, ABRA_LV8
	ld bc, KADABRA_LV39
	farcall LookForCardIDInDeck_GivenCardIDInHand
	jr c, .asm_22f7b
	ld de, KADABRA_LV39
	ld bc, ALAKAZAM_LV45
	farcall LookForCardIDInDeck_GivenCardIDInHand
	jr c, .asm_22f7b
	ld bc, GASTLY_LV13
	ld de, HAUNTER_LV26
	farcall LookForEvoCardInDeck_GivenPreevoInHandOrPlayArea
	jr c, .asm_22f7b
	ld bc, HAUNTER_LV26
	ld de, GENGAR_LV40
	farcall LookForEvoCardInDeck_GivenPreevoInHandOrPlayArea
	jr c, .asm_22f7b
	ld de, GASTLY_LV13
	ld bc, HAUNTER_LV26
	farcall LookForCardIDInDeck_GivenCardIDInHand
	jr c, .asm_22f7b
	ld de, HAUNTER_LV26
	ld bc, GENGAR_LV40
	farcall LookForCardIDInDeck_GivenCardIDInHand
	jr nc, .asm_22f84
.asm_22f7b
	ld [wAITrainerCardArgs + 1], a
	farcall FindDuplicatePokemonCardsInHand
	jr c, .asm_22f86
.asm_22f84
	or a
	ret
.asm_22f86
	scf
	ret

.GatheringNidoranDeck:
	ld bc, NIDORANM_LV22
	ld de, NIDORINO_LV23
	farcall LookForEvoCardInDeck_GivenPreevoInHandOrPlayArea
	jp c, .asm_23033
	ld bc, NIDORANM_LV22
	ld de, NIDORINO_LV25
	farcall LookForEvoCardInDeck_GivenPreevoInHandOrPlayArea
	jp c, .asm_23033
	ld bc, NIDORINO_LV23
	ld de, NIDOKING
	farcall LookForEvoCardInDeck_GivenPreevoInHandOrPlayArea
	jp c, .asm_23033
	ld bc, NIDORINO_LV25
	ld de, NIDOKING
	farcall LookForEvoCardInDeck_GivenPreevoInHandOrPlayArea
	jr c, .asm_23033
	ld de, NIDORANM_LV22
	ld bc, NIDORINO_LV23
	farcall LookForCardIDInDeck_GivenCardIDInHand
	jr c, .asm_23033
	ld de, NIDORANM_LV22
	ld bc, NIDORINO_LV25
	farcall LookForCardIDInDeck_GivenCardIDInHand
	jr c, .asm_23033
	ld de, NIDORINO_LV23
	ld bc, NIDOKING
	farcall LookForCardIDInDeck_GivenCardIDInHand
	jr c, .asm_23033
	ld de, NIDORINO_LV25
	ld bc, NIDOKING
	farcall LookForCardIDInDeck_GivenCardIDInHand
	jr c, .asm_23033
	ld bc, NIDORANF_LV12
	ld de, NIDORINA_LV22
	farcall LookForEvoCardInDeck_GivenPreevoInHandOrPlayArea
	jr c, .asm_23033
	ld bc, NIDORANF_LV13
	ld de, NIDORINA_LV22
	farcall LookForEvoCardInDeck_GivenPreevoInHandOrPlayArea
	jr c, .asm_23033
	ld bc, NIDORINA_LV22
	ld de, NIDOQUEEN
	farcall LookForEvoCardInDeck_GivenPreevoInHandOrPlayArea
	jr c, .asm_23033
	ld de, NIDORANF_LV12
	ld bc, NIDORINA_LV22
	farcall LookForCardIDInDeck_GivenCardIDInHand
	jr c, .asm_23033
	ld de, NIDORANF_LV13
	ld bc, NIDORINA_LV22
	farcall LookForCardIDInDeck_GivenCardIDInHand
	jr c, .asm_23033
	ld de, NIDORINA_LV22
	ld bc, NIDOQUEEN
	farcall LookForCardIDInDeck_GivenCardIDInHand
	jr nc, .asm_2303c
.asm_23033
	ld [wAITrainerCardArgs + 1], a
	farcall FindDuplicatePokemonCardsInHand
	jr c, .asm_2303e
.asm_2303c
	or a
	ret
.asm_2303e
	scf
	ret

.RainDanceConfusionDeck:
	ld bc, SQUIRTLE_LV15
	ld de, WARTORTLE_LV22
	farcall LookForEvoCardInDeck_GivenPreevoInHandOrPlayArea
	jr c, .asm_23094
	ld bc, SQUIRTLE_LV16
	ld de, WARTORTLE_LV22
	farcall LookForEvoCardInDeck_GivenPreevoInHandOrPlayArea
	jr c, .asm_23094
	ld bc, WARTORTLE_LV22
	ld de, BLASTOISE_LV52
	farcall LookForEvoCardInDeck_GivenPreevoInHandOrPlayArea
	jr c, .asm_23094
	ld de, SQUIRTLE_LV15
	ld bc, WARTORTLE_LV22
	farcall LookForCardIDInDeck_GivenCardIDInHand
	jr c, .asm_23094
	ld de, SQUIRTLE_LV16
	ld bc, WARTORTLE_LV22
	farcall LookForCardIDInDeck_GivenCardIDInHand
	jr c, .asm_23094
	ld de, WARTORTLE_LV22
	ld bc, BLASTOISE_LV52
	farcall LookForCardIDInDeck_GivenCardIDInHand
	jr c, .asm_23094
	ld bc, SEEL_LV10
	ld de, DEWGONG_LV24
	farcall CheckReelInEvoLineTarget
	jr nc, .asm_230a3
.asm_23094
	ld [wAITrainerCardArgs + 1], a
	farcall FindDuplicatePokemonCardsInHand
	jr c, .asm_230a5
	farcall FindUnusableEvolutionCardInHand
	jr c, .asm_230a5
.asm_230a3
	or a
	ret
.asm_230a5
	scf
	ret

.GoArcanineDeck:
	ld de, MAGMAR_LV31
	farcall IsCardIDInHandOrPlayArea
	jr c, .asm_230bf
	ld a, CARD_LOCATION_DECK
	ld de, MAGMAR_LV31
	farcall FindCardIDInLocation
	ld de, MAGMAR_LV31
	jp c, .asm_231cc
.asm_230bf
	ld de, GROWLITHE_LV12
	farcall IsCardIDInHandOrPlayArea
	jr c, .asm_230e0
	ld de, GROWLITHE_LV18
	farcall IsCardIDInHandOrPlayArea
	jr c, .asm_230e0
	ld a, CARD_LOCATION_DECK
	ld de, GROWLITHE_LV12
	farcall FindCardIDInLocation
	ld de, GROWLITHE_LV12
	jp c, .asm_231cc
.asm_230e0
	ld de, GROWLITHE_LV18
	farcall IsCardIDInHandOrPlayArea
	jr c, .asm_23101
	ld de, GROWLITHE_LV12
	farcall IsCardIDInHandOrPlayArea
	jr c, .asm_23101
	ld a, CARD_LOCATION_DECK
	ld de, GROWLITHE_LV18
	farcall FindCardIDInLocation
	ld de, GROWLITHE_LV18
	jp c, .asm_231cc
.asm_23101
	ld bc, GROWLITHE_LV12
	ld de, ARCANINE_LV45
	farcall LookForEvoCardInDeck_GivenPreevoInHandOrPlayArea
	jp c, .asm_231cc
	ld bc, GROWLITHE_LV18
	ld de, ARCANINE_LV45
	farcall LookForEvoCardInDeck_GivenPreevoInHandOrPlayArea
	jp c, .asm_231cc
	ld de, GROWLITHE_LV12
	ld bc, ARCANINE_LV45
	farcall LookForCardIDInDeck_GivenCardIDInHand
	ld de, ARCANINE_LV45
	jp c, .asm_231cc
	ld de, GROWLITHE_LV18
	ld bc, ARCANINE_LV45
	farcall LookForCardIDInDeck_GivenCardIDInHand
	ld de, ARCANINE_LV45
	jp c, .asm_231cc
	ld de, DODUO_LV10
	farcall IsCardIDInHandOrPlayArea
	jr c, .asm_23152
	ld a, CARD_LOCATION_DECK
	ld de, DODUO_LV10
	farcall FindCardIDInLocation
	ld de, DODUO_LV10
	jr c, .asm_231cc
.asm_23152
	ld bc, DODUO_LV10
	ld de, DODRIO_LV28
	farcall LookForEvoCardInDeck_GivenPreevoInHandOrPlayArea
	jr c, .asm_231cc
	ld de, DODUO_LV10
	ld bc, DODRIO_LV28
	farcall LookForCardIDInDeck_GivenCardIDInHand
	ld de, DODRIO_LV28
	jr c, .asm_231cc
	ld de, HITMONCHAN_LV23
	farcall IsCardIDInHandOrPlayArea
	jr c, .asm_23184
	ld a, CARD_LOCATION_DECK
	ld de, HITMONCHAN_LV23
	farcall FindCardIDInLocation
	ld de, HITMONCHAN_LV23
	jr c, .asm_231cc
.asm_23184
	ld de, HITMONCHAN_LV33
	farcall IsCardIDInHandOrPlayArea
	jr c, .asm_2319b
	ld a, CARD_LOCATION_DECK
	ld de, HITMONCHAN_LV33
	farcall FindCardIDInLocation
	ld de, HITMONCHAN_LV33
	jr c, .asm_231cc
.asm_2319b
	ld de, SEEL_LV12
	farcall IsCardIDInHandOrPlayArea
	jr c, .asm_231b2
	ld a, CARD_LOCATION_DECK
	ld de, SEEL_LV12
	farcall FindCardIDInLocation
	ld de, SEEL_LV12
	jr c, .asm_231cc
.asm_231b2
	ld bc, SEEL_LV12
	ld de, DEWGONG_LV42
	farcall LookForEvoCardInDeck_GivenPreevoInHandOrPlayArea
	jr c, .asm_231cc
	ld de, SEEL_LV12
	ld bc, DEWGONG_LV42
	farcall LookForCardIDInDeck_GivenCardIDInHand
	ld de, DEWGONG_LV42
	ret nc
.asm_231cc
	ld [wAITrainerCardArgs + 1], a
	farcall FindDifferentPokemonCardInHand
	ret

.MadPetalsDeck:
	farcall AIDecide_PokemonTrader_MadPetalsDeck
	ret

.DangerousBenchDeck:
	; exit if has 4 or more Pokémon in play
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	cp 4
	ret nc
	; find a Pikachu in deck
	ld a, CARD_LOCATION_DECK
	ld de, PIKACHU_LV14
	farcall FindCardIDInLocation
	ret nc
	ld [wAITrainerCardArgs + 1], a
	; trade it with a repeated Dark Dragonite
	; or Dark Dragonair from hand
	ld de, DARK_DRAGONITE
	farcall CheckIfHandHasRepeatedCard
	ret c
	ld de, DARK_DRAGONAIR
	farcall CheckIfHandHasRepeatedCard
	ret

.EeveeShowdownDeck:
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	cp 1
	jr nz, .asm_23229
	; only has 1 Pokémon in play

	; if player doesn't have any Water Pokémon, search for Magmar
	ld a, TYPE_PKMN_WATER
	farcall CheckIfPlayerHasPokemonOfType
	jr c, .asm_2321b
	ld a, CARD_LOCATION_DECK
	ld de, MAGMAR_LV31
	farcall FindCardIDInLocation
	ld de, MAGMAR_LV31
	jr c, .asm_2326c
	jr .asm_2324d
.asm_2321b
	; if player does have any Water Pokémon, search for Electabuzz
	; bug, a is expected to have CARD_LOCATION_DECK, but it
	; holds garbage data from CheckIfPlayerHasPokemonOfType
	ld de, ELECTABUZZ_LV35
	farcall FindCardIDInLocation
	ld de, ELECTABUZZ_LV35
	jr c, .asm_2326c
	jr .asm_2325e

.asm_23229
	; if player doesn't have any Water Pokémon, search for Dark Flareon
	ld a, TYPE_PKMN_WATER
	farcall CheckIfPlayerHasPokemonOfType
	jr c, .asm_2323f
	ld bc, EEVEE_LV9
	ld de, DARK_FLAREON
	farcall LookForEvoCardInDeck_GivenPreevoInHandOrPlayArea
	jr c, .asm_2326c
	jr .asm_2324d
.asm_2323f
	; if player does have any Water Pokémon, search for Dark Jolteon
	ld bc, EEVEE_LV9
	ld de, DARK_JOLTEON
	farcall LookForEvoCardInDeck_GivenPreevoInHandOrPlayArea
	jr c, .asm_2326c
	jr .asm_2325e

.asm_2324d
	; search for Eevee in deck if Dark Flareon in hand
	ld de, EEVEE_LV9
	ld bc, DARK_FLAREON
	farcall LookForCardIDInDeck_GivenCardIDInHand
	ld de, DARK_FLAREON
	jp c, .asm_2326c
	ret
.asm_2325e
	; search for Eevee in deck if Dark Jolteon in hand
	ld de, EEVEE_LV9
	ld bc, DARK_JOLTEON
	farcall LookForCardIDInDeck_GivenCardIDInHand
	ld de, DARK_JOLTEON
	ret nc
.asm_2326c
	ld [wAITrainerCardArgs + 1], a
	farcall FindDifferentPokemonCardInHand
	ret

.GazeUponThePowerOfFireDeck:
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	cp 1
	jr z, .asm_23298
	; has more than 1 Pokémon in play
	ld bc, VULPIX_LV11
	ld de, DARK_NINETALES
	farcall LookForEvoCardInDeck_GivenPreevoInHandOrPlayArea
	jr c, .asm_232cf
	ld de, VULPIX_LV11
	ld bc, DARK_NINETALES
	farcall LookForCardIDInDeck_GivenCardIDInHand
	ld de, DARK_NINETALES
	jp c, .asm_232cf
	ret
.asm_23298
	; only has 1 Pokémon in play
	; find any of the following in deck, if not in hand
	ld a, $00 ; unused
	ld de, MAGMAR_LV31
	farcall IsCardIDInDeckAndNotInHand
	ld de, MAGMAR_LV31
	jr c, .asm_232cf
	ld a, $00 ; unused
	ld de, CHARMANDER_LV9
	farcall IsCardIDInDeckAndNotInHand
	ld de, CHARMANDER_LV9
	jr c, .asm_232cf
	ld a, $00 ; unused
	ld de, VULPIX_LV11
	farcall IsCardIDInDeckAndNotInHand
	ld de, VULPIX_LV11
	jr c, .asm_232cf
	ld a, $00 ; unused
	ld de, PONYTA_LV8
	farcall IsCardIDInDeckAndNotInHand
	ld de, PONYTA_LV8
	ret nc
.asm_232cf
	ld [wAITrainerCardArgs + 1], a
	farcall FindDifferentPokemonCardInHand
	ret

.BenchCallDeck:
	; exit if player's Arena card isn't Lightning
	call SwapTurn
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call LoadCardDataToBuffer2_FromDeckIndex
	call SwapTurn
	ld a, [wLoadedCard2Type]
	cp TYPE_PKMN_LIGHTNING
	jr z, .asm_232ec
	or a
	ret
.asm_232ec
	; player's Arena card is Lightning
	; look for any of the following cards in the deck
	ld a, CARD_LOCATION_DECK
	ld de, JYNX_LV18
	farcall FindCardIDInLocation
	ld de, JYNX_LV18
	jr c, .asm_2331f
	ld a, CARD_LOCATION_DECK
	ld de, TAUROS_LV35
	farcall FindCardIDInLocation
	ld de, TAUROS_LV35
	jr c, .asm_2331f
	ld de, SURFING_PIKACHU_LV13
	farcall FindCardIDInLocation
	ld de, SURFING_PIKACHU_LV13
	jr c, .asm_2331f
	ld de, SURFING_PIKACHU_ALT_LV13
	farcall FindCardIDInLocation
	ld de, SURFING_PIKACHU_ALT_LV13
	ret nc
.asm_2331f
	ld [wAITrainerCardArgs + 1], a
	farcall FindDifferentPokemonCardInHand
	ret

.WaterStreamDeck:
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	cp 1
	jr z, .asm_2335f

	; has more than 1 Pokémon in play
	; does the player have a Lightning type Pokémon?
	ld a, TYPE_PKMN_LIGHTNING
	farcall CheckIfPlayerHasPokemonOfType
	jr c, .asm_23352
	; no, look for Staryu/Dark Starmie
	ld bc, STARYU_LV15
	ld de, DARK_STARMIE
	farcall LookForEvoCardInDeck_GivenPreevoInHandOrPlayArea
	jr c, .asm_23396
	ld de, STARYU_LV15
	ld bc, DARK_STARMIE
	farcall LookForCardIDInDeck_GivenCardIDInHand
	ld de, DARK_STARMIE
	jr c, .asm_23396
	ret
.asm_23352
	; yes, look for Articuno
	ld de, ARTICUNO_LV34
	farcall IsCardIDInDeckAndNotInHandOrPlayArea
	ld de, ARTICUNO_LV34
	jr c, .asm_23396
	ret

.asm_2335f
	; only has 1 Pokémon in play
	ld a, CARD_LOCATION_DECK
	ld de, LAPRAS_LV31
	farcall FindCardIDInLocation
	ld de, LAPRAS_LV31
	jr c, .asm_23396
	ld a, CARD_LOCATION_DECK
	ld de, ARTICUNO_LV34
	farcall FindCardIDInLocation
	ld de, ARTICUNO_LV34
	jr c, .asm_23396
	ld a, CARD_LOCATION_DECK
	ld de, STARYU_LV15
	farcall FindCardIDInLocation
	ld de, STARYU_LV15
	jr c, .asm_23396
	ld a, CARD_LOCATION_DECK
	ld de, GOLDEEN
	farcall FindCardIDInLocation
	ld de, GOLDEEN
	ret nc
.asm_23396
	ld [wAITrainerCardArgs + 1], a
	farcall FindDifferentPokemonCardInHand
	ret

.FullStrengthDeck:
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	cp 1
	jr nz, .asm_233b3

	; only 1 Pokémon in play
	ld a, CARD_LOCATION_DECK
	ld de, ONIX_LV25
	farcall FindCardIDInLocation
	ld de, ONIX_LV25
	jr c, .asm_233d0
.asm_233b3
	; more than 1 Pokémon in play
	; or no Onix found in deck
	ld de, MACHOP_LV24
	ld bc, DARK_MACHOKE
	farcall LookForCardIDInDeck_GivenCardIDInHand
	ld de, DARK_MACHOKE
	jr c, .asm_233d0
	ld de, DARK_MACHOKE
	ld bc, DARK_MACHAMP
	farcall LookForCardIDInDeck_GivenCardIDInHand
	ld de, DARK_MACHAMP
	ret nc
.asm_233d0
	ld [wAITrainerCardArgs + 1], a
	farcall FindDifferentPokemonCardInHand
	ret

.DirectHitDeck:
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	cp 1
	jr nz, .asm_2341f
	; only 1 Pokémon in play
	; look for any of the following in the deck
	ld a, CARD_LOCATION_DECK
	ld de, KANGASKHAN_LV40
	farcall FindCardIDInLocation
	ld de, KANGASKHAN_LV40
	jr c, .asm_2344e
	ld a, CARD_LOCATION_DECK
	ld de, PSYDUCK_LV16
	farcall FindCardIDInLocation
	ld de, PSYDUCK_LV16
	jr c, .asm_2344e
	ld de, MEWTWO_LV30
	farcall FindCardIDInLocation
	ld de, MEWTWO_LV30
	jr c, .asm_2344e
	ld de, RATTATA_LV15
	farcall FindCardIDInLocation
	ld de, RATTATA_LV15
	jr c, .asm_2344e
	ld de, ABRA_LV8
	farcall FindCardIDInLocation
	ld de, ABRA_LV8
	jr c, .asm_2344e

.asm_2341f
	; more than 1 Pokémon in play
	; or none of the above found in deck
	ld bc, ABRA_LV8
	ld de, DARK_KADABRA
	farcall LookForEvoCardInDeck_GivenPreevoInHandOrPlayArea
	jr c, .asm_2344e
	ld bc, DARK_KADABRA
	ld de, DARK_ALAKAZAM
	farcall LookForEvoCardInDeck_GivenPreevoInHandOrPlayArea
	jr c, .asm_2344e
	ld bc, PSYDUCK_LV16
	ld de, DARK_GOLDUCK
	farcall LookForEvoCardInDeck_GivenPreevoInHandOrPlayArea
	jr c, .asm_2344e
	ld bc, RATTATA_LV15
	ld de, DARK_RATICATE
	farcall LookForEvoCardInDeck_GivenPreevoInHandOrPlayArea
	ret nc
.asm_2344e
	ld [wAITrainerCardArgs + 1], a
	farcall FindDifferentPokemonCardInHand
	ret

.BadGuysDeck:
	farcall AIDecide_PokemonTraderForEvo_BadGuysDeck
	ret

.PoisonMistDeck:
	farcall AIDecide_PokemonTrader_PoisonMistDeck
	ret

.UltraRemovalDeck:
	farcall AIDecide_PokemonTrader_UltraRemovalDeck
	ret

.ColorlessEnergyDeck:
	farcall AIDecide_PokemonTrader_ColorlessEnergyDeck
	ret

.RonaldsPsychicDeck:
	farcall AIDecide_PokemonTrader_RonaldsPsychicDeck
	ret

.RonaldsUltraDeck:
	farcall AIDecide_PokemonTrader_RonaldsUltraDeck
	ret

.ImmortalPokemonDeck:
	farcall AIDecide_PokemonTrader_ImmortalPokemonDeck
	ret

.TorrentialFloodDeck:
	farcall AIDecide_PokemonTrader_TorrentialFloodDeck
	ret

.TrainerImprisonDeck:
	farcall AIDecide_PokemonTrader_TrainerImprisonDeck
	ret

.BlazingFlameDeck:
	farcall AIDecide_PokemonTrader_BlazingFlameDeck
	ret

.DamageChaosDeck:
	farcall AIDecide_PokemonTrader_DamageChaosDeck
	ret

.BigThunderDeck:
	farcall AIDecide_PokemonTrader_BigThunderDeck
	ret

AIPlay_TheBosssWay:
	ld a, [wAITrainerCardToPlay]
	ldh [hDuelActionCardIndex], a
	ld a, [wAITrainerCardArgs + 0]
	ldh [hDuelActionArgs + 0], a
	ld a, $ff
	ldh [hDuelActionArgs + 1], a
	ld a, OPPACTION_EXECUTE_TRAINER_EFFECTS
	farcall AIMakeDecision
	ret

AIDecide_TheBosssWay:
	ld a, [wOpponentDeckID]
	cp GREAT_ROCKET2_DECK_ID
	jr z, .GreatRocket2Deck
	cp GREAT_ROCKET3_DECK_ID
	jr z, .GreatRocket3Deck
	cp DEMONIC_FOREST_DECK_ID
	jp z, .DemonicForestDeck
	cp DANGEROUS_BENCH_DECK_ID
	jp z, .DangerousBenchDeck
	cp FULL_STRENGTH_DECK_ID
	jp z, .FullStrengthDeck
	cp DIRECT_HIT_DECK_ID
	jp z, .DirectHitDeck
	cp SUDDEN_GROWTH_DECK_ID
	jp z, .SuddenGrowthDeck
	cp BAD_GUYS_DECK_ID
	jp z, .BadGuysDeck
	cp RONALDS_GRX_DECK_ID
	jp z, .RonaldsGRXDeck
	cp DAMAGE_CHAOS_DECK_ID
	jp z, .DamageChaosDeck
	or a
	ret

.GreatRocket2Deck:
	; search for Dark Arbok if any Ekans in play/hand
	ld bc, EKANS_LV10
	ld de, DARK_ARBOK
	farcall LookForEvoCardInDeck_GivenPreevoInHandOrPlayArea
	ret c
	ld bc, EKANS_LV15
	ld de, DARK_ARBOK
	farcall LookForEvoCardInDeck_GivenPreevoInHandOrPlayArea
	ret c
	; search for Dark Dugtrio if any Diglett in play/hand
	ld bc, DIGLETT_LV8
	ld de, DARK_DUGTRIO
	farcall LookForEvoCardInDeck_GivenPreevoInHandOrPlayArea
	ret c
	ld bc, DIGLETT_LV15
	ld de, DARK_DUGTRIO
	farcall LookForEvoCardInDeck_GivenPreevoInHandOrPlayArea
	ret c
	; otherwise search for Dark Arbok/Dark Dugtrio
	; if they are not in hand
	ld de, DARK_ARBOK
	farcall IsCardIDInDeckAndNotInHand
	ret c
	ld de, DARK_DUGTRIO
	farcall IsCardIDInDeckAndNotInHand
	ret

.GreatRocket3Deck:
	ld bc, CHARMANDER_LV12
	ld de, DARK_CHARMELEON
	farcall LookForEvoCardInDeck_GivenPreevoInHandOrPlayArea
	ret c
	ld bc, ODDISH_LV8
	ld de, DARK_GLOOM
	farcall LookForEvoCardInDeck_GivenPreevoInHandOrPlayArea
	ret c
	ld bc, DARK_GLOOM
	ld de, DARK_VILEPLUME
	farcall LookForEvoCardInDeck_GivenPreevoInHandOrPlayArea
	ret

.DemonicForestDeck:
	ld bc, BULBASAUR_LV15
	ld de, DARK_IVYSAUR
	farcall LookForEvoCardInDeck_GivenPreevoInHandOrPlayArea
	ret c
	ld bc, DARK_IVYSAUR
	ld de, DARK_VENUSAUR
	farcall LookForEvoCardInDeck_GivenPreevoInHandOrPlayArea
	ret

.DangerousBenchDeck:
	ld bc, DRATINI_LV12
	ld de, DARK_DRAGONAIR
	farcall LookForEvoCardInDeck_GivenPreevoInHandOrPlayArea
	ret c
	ld bc, PIKACHU_LV14
	ld de, DARK_RAICHU
	farcall LookForEvoCardInDeck_GivenPreevoInHandOrPlayArea
	ret c
	ld bc, DARK_DRAGONAIR
	ld de, DARK_DRAGONITE
	farcall LookForEvoCardInDeck_GivenPreevoInHandOrPlayArea
	ret

.FullStrengthDeck:
	ld bc, MACHOP_LV24
	ld de, DARK_MACHOKE
	farcall LookForEvoCardInDeck_GivenPreevoInHandOrPlayArea
	ret c
	ld bc, DARK_MACHOKE
	ld de, DARK_MACHAMP
	farcall LookForEvoCardInDeck_GivenPreevoInHandOrPlayArea
	ret

.DirectHitDeck:
	ld bc, ABRA_LV8
	ld de, DARK_KADABRA
	farcall LookForEvoCardInDeck_GivenPreevoInHandOrPlayArea
	ret c
	ld bc, DARK_KADABRA
	ld de, DARK_ALAKAZAM
	farcall LookForEvoCardInDeck_GivenPreevoInHandOrPlayArea
	ret c
	ld bc, PSYDUCK_LV16
	ld de, DARK_GOLDUCK
	farcall LookForEvoCardInDeck_GivenPreevoInHandOrPlayArea
	ret c
	ld bc, RATTATA_LV15
	ld de, DARK_RATICATE
	farcall LookForEvoCardInDeck_GivenPreevoInHandOrPlayArea
	ret

.SuddenGrowthDeck:
	ld bc, DRATINI_LV12
	ld de, DARK_DRAGONAIR
	farcall LookForEvoCardInDeck_GivenPreevoInHandOrPlayArea
	ret c
	ld bc, CLEFAIRY_LV15
	ld de, DARK_CLEFABLE
	farcall LookForEvoCardInDeck_GivenPreevoInHandOrPlayArea
	ret

.BadGuysDeck:
	farcall AIDecide_TheBosssWay_BadGuysDeck
	ret

.RonaldsGRXDeck:
	ld bc, ZUBAT_LV9
	ld de, DARK_GOLBAT
	farcall LookForEvoCardInDeck_GivenPreevoInHandOrPlayArea
	ret c
	ld bc, GRIMER_LV10
	ld de, DARK_MUK
	farcall LookForEvoCardInDeck_GivenPreevoInHandOrPlayArea
	ret c
	ld bc, RATTATA_LV12
	ld de, DARK_RATICATE
	farcall LookForEvoCardInDeck_GivenPreevoInHandOrPlayArea
	ret c
	ld bc, MEOWTH_LV10
	ld de, DARK_PERSIAN_LV28
	farcall LookForEvoCardInDeck_GivenPreevoInHandOrPlayArea
	ret c
;	bug, unintentional fallthrough

.DamageChaosDeck:
	farcall AIDecide_TheBosssWay_DamageChaosDeck
	ret

AIPlay_NightlyGarbageRun:
	ld a, [wAITrainerCardToPlay]
	ldh [hDuelActionCardIndex], a
	ld a, [wAITrainerCardArgs + 0]
	ldh [hDuelActionArgs + 0], a
	ld a, [wAITrainerCardArgs + 1]
	ldh [hDuelActionArgs + 1], a
	ld a, [wAITrainerCardArgs + 2]
	ldh [hDuelActionArgs + 2], a
	ld a, $ff
	ldh [hDuelActionArgs + 3], a
	ld a, OPPACTION_EXECUTE_TRAINER_EFFECTS
	farcall AIMakeDecision
	ret

AIDecide_NightlyGarbageRun:
	ld a, [wOpponentDeckID]
	cp PSYCHIC_ELITE_DECK_ID
	jp z, .PsychicEliteDeck
	cp GRAND_FIRE_DECK_ID
	jp z, .GrandFireDeck
	cp LEGENDARY_FOSSIL_DECK_ID
	jp z, .LegendaryFossilDeck
	cp GREAT_DRAGON_DECK_ID
	jp z, .GreatDragonDeck
	cp STICKY_POISON_GAS_DECK_ID
	jp z, .StickyPoisonGasDeck
	cp MAD_PETALS_DECK_ID
	jp z, .MadPetalsDeck
	cp COMPLETE_COMBUSTION_DECK_ID
	jp z, .CompleteCombustionDeck
	cp GAZE_UPON_THE_POWER_OF_FIRE_DECK_ID
	jp z, .GazeUponThePowerOfFireDeck
	cp SPIRITED_AWAY_DECK_ID
	jp z, .SpiritedAwayDeck
	cp SUDDEN_GROWTH_DECK_ID
	jp z, .SuddenGrowthDeck
	cp BAD_GUYS_DECK_ID
	jp z, .BadGuysDeck
	cp IMMORTAL_POKEMON_DECK_ID
	jp z, .ImmortalPokemonDeck
	or a
	ret

.PsychicEliteDeck:
	; if Abra/Kadabra/Alakazam are each in the Discard Pile
	; choose them as targets
	ld a, CARD_LOCATION_DISCARD_PILE
	ld de, ALAKAZAM_LV42
	farcall FindCardIDInLocation
	jr nc, .asm_23684
	ld [wAITrainerCardArgs + 2], a
	ld a, CARD_LOCATION_DISCARD_PILE
	ld de, KADABRA_LV39
	farcall FindCardIDInLocation
	jr nc, .asm_23684
	ld [wAITrainerCardArgs + 1], a
	ld a, CARD_LOCATION_DISCARD_PILE
	ld de, ABRA_LV14
	farcall FindCardIDInLocation
	ret c

.asm_23684
	; otherwise, if 3 or more energies in Discard Pile,
	; choose top 3 as targets
	ld a, CARD_LOCATION_DISCARD_PILE
	farcall CreateBasicEnergyCardListInLocation
	jr c, .asm_236ab
	cp 3
	jr c, .asm_236ab
	ld a, [wDuelTempList + 0]
	ld [wAITrainerCardArgs + 1], a
	ld a, [wDuelTempList + 1]
	ld [wAITrainerCardArgs + 2], a
	ld a, CARD_LOCATION_DISCARD_PILE
	ld de, MR_MIME_LV20
	farcall FindCardIDInLocation
	ret c
	ld a, [wDuelTempList + 2]
	scf
	ret
.asm_236ab
	or a
	ret

.GrandFireDeck:
	; if 3 or more energies in Discard Pile,
	; choose top 2 as targets
	ld a, CARD_LOCATION_DISCARD_PILE
	farcall CreateBasicEnergyCardListInLocation
	jr c, .asm_236d4
	cp 3
	jr c, .asm_236d4
	ld a, [wDuelTempList + 0]
	ld [wAITrainerCardArgs + 1], a
	ld a, [wDuelTempList + 1]
	ld [wAITrainerCardArgs + 2], a
	; additionally if there's a Moltres lv40,
	; choose it as final target
	ld a, CARD_LOCATION_DISCARD_PILE
	ld de, MOLTRES_LV40
	farcall FindCardIDInLocation
	ret c
	; otherwise choose third energy
	ld a, [wDuelTempList + 2]
	scf
	ret
.asm_236d4
	or a
	ret

.LegendaryFossilDeck:
	; if 3 or more energies in Discard Pile,
	; choose top 2 as targets
	ld a, CARD_LOCATION_DISCARD_PILE
	farcall CreateBasicEnergyCardListInLocation
	jr c, .asm_236fd
	cp $03
	jr c, .asm_236fd
	ld a, [wDuelTempList + 0]
	ld [wAITrainerCardArgs + 1], a
	ld a, [wDuelTempList + 1]
	ld [wAITrainerCardArgs + 2], a
	; additionally if there's a Zapdos lv68,
	; choose it as final target
	ld a, CARD_LOCATION_DISCARD_PILE
	ld de, ZAPDOS_LV68
	farcall FindCardIDInLocation
	ret c
	; otherwise choose third energy
	ld a, [wDuelTempList + 2]
	scf
	ret
.asm_236fd
	or a
	ret

.GreatDragonDeck:
	; if Charmander/Charmeleon/Charizard are each in the Discard Pile
	; choose them as targets
	ld a, CARD_LOCATION_DISCARD_PILE
	ld de, CHARIZARD_LV76
	farcall FindCardIDInLocation
	jr c, .asm_23722
	ld a, CARD_LOCATION_DISCARD_PILE
	ld de, CHARIZARD_ALT_LV76
	farcall FindCardIDInLocation
	jr c, .asm_23722
	ld a, CARD_LOCATION_DISCARD_PILE
	ld de, CHARMELEON
	farcall FindCardIDInLocation
	jr c, .asm_23722
	or a
	ret
.asm_23722
	ld a, $ff
	ld [wAITrainerCardArgs + 1], a
	ld [wAITrainerCardArgs + 2], a
	ld [wAITrainerCardArgs + 3], a
	ld a, CARD_LOCATION_DISCARD_PILE
	ld de, CHARIZARD_LV76
	farcall FindCardIDInLocation
	call c, .AddCardToShuffleToDeck
	ld a, CARD_LOCATION_DISCARD_PILE
	ld de, CHARIZARD_ALT_LV76
	farcall FindCardIDInLocation
	call c, .AddCardToShuffleToDeck
	ld a, CARD_LOCATION_DISCARD_PILE
	ld de, CHARMELEON
	farcall FindCardIDInLocation
	call c, .AddCardToShuffleToDeck
	jr c, .asm_23776
	ld a, CARD_LOCATION_DISCARD_PILE
	ld de, DRAGONITE_LV41
	farcall FindCardIDInLocation
	call c, .AddCardToShuffleToDeck
	jr c, .asm_23776
	ld a, CARD_LOCATION_DISCARD_PILE
	farcall CreateBasicEnergyCardListInLocation
	ld hl, wDuelTempList
.asm_2376a
	ld a, [hli]
	cp $ff
	jr z, .asm_23776
	push hl
	call .AddCardToShuffleToDeck
	pop hl
	jr nc, .asm_2376a
.asm_23776
	ld a, [wAITrainerCardArgs + 1]
	push af
	ld a, [wAITrainerCardArgs + 2]
	ld [wAITrainerCardArgs + 1], a
	ld a, [wAITrainerCardArgs + 3]
	ld [wAITrainerCardArgs + 2], a
	pop af
	scf
	ret

.StickyPoisonGasDeck:
	; if Ekans/Grimer/Koffing are each in the Discard Pile
	; choose them as targets
	ld a, CARD_LOCATION_DISCARD_PILE
	ld de, EKANS_LV15
	farcall FindCardIDInLocation
	jr c, .asm_237ac
	ld a, CARD_LOCATION_DISCARD_PILE
	ld de, GRIMER_LV10
	farcall FindCardIDInLocation
	jr c, .asm_237ac
	ld a, CARD_LOCATION_DISCARD_PILE
	ld de, KOFFING_LV12
	farcall FindCardIDInLocation
	jr c, .asm_237ac
	or a
	ret
.asm_237ac
	ld a, $ff
	ld [wAITrainerCardArgs + 1], a
	ld [wAITrainerCardArgs + 2], a
	ld [wAITrainerCardArgs + 3], a
	ld a, CARD_LOCATION_DISCARD_PILE
	ld de, EKANS_LV15
	farcall FindCardIDInLocation
	call c, .AddCardToShuffleToDeck
	ld a, CARD_LOCATION_DISCARD_PILE
	ld de, GRIMER_LV10
	farcall FindCardIDInLocation
	call c, .AddCardToShuffleToDeck
	ld a, CARD_LOCATION_DISCARD_PILE
	ld de, KOFFING_LV12
	farcall FindCardIDInLocation
	call c, .AddCardToShuffleToDeck
	jr c, .asm_2381c
	ld a, CARD_LOCATION_DISCARD_PILE
	ld de, DARK_ARBOK
	farcall FindCardIDInLocation
	call c, .AddCardToShuffleToDeck
	jr c, .asm_2381c
	ld a, CARD_LOCATION_DISCARD_PILE
	ld de, MUK
	farcall FindCardIDInLocation
	call c, .AddCardToShuffleToDeck
	jr c, .asm_2381c
	ld a, CARD_LOCATION_DISCARD_PILE
	ld de, DARK_WEEZING
	farcall FindCardIDInLocation
	call c, .AddCardToShuffleToDeck
	jr c, .asm_2381c
	ld a, CARD_LOCATION_DISCARD_PILE
	farcall CreateBasicEnergyCardListInLocation
	ld hl, wDuelTempList
.asm_23810
	ld a, [hli]
	cp $ff
	jr z, .asm_2381c
	push hl
	call .AddCardToShuffleToDeck
	pop hl
	jr nc, .asm_23810
.asm_2381c
	ld a, [wAITrainerCardArgs + 1]
	push af
	ld a, [wAITrainerCardArgs + 2]
	ld [wAITrainerCardArgs + 1], a
	ld a, [wAITrainerCardArgs + 3]
	ld [wAITrainerCardArgs + 2], a
	pop af
	scf
	ret

.MadPetalsDeck:
	ld a, $ff
	ld [wAITrainerCardArgs + 1], a
	ld [wAITrainerCardArgs + 2], a
	ld [wAITrainerCardArgs + 3], a
	ld a, CARD_LOCATION_DISCARD_PILE
	ld de, DARK_VILEPLUME
	farcall FindCardIDInLocation
	call c, .AddCardToShuffleToDeck
	ld a, CARD_LOCATION_DISCARD_PILE
	ld de, DARK_GLOOM
	farcall FindCardIDInLocation
	call c, .AddCardToShuffleToDeck
	ld a, CARD_LOCATION_DISCARD_PILE
	farcall CreateBasicEnergyCardListInLocation
	ld hl, wDuelTempList
.asm_2385b
	ld a, [hli]
	cp $ff
	jr z, .asm_23867
	push hl
	call .AddCardToShuffleToDeck
	pop hl
	jr nc, .asm_2385b
.asm_23867
	ld a, [wAITrainerCardArgs + 1]
	cp $ff
	ret z
	push af
	ld a, [wAITrainerCardArgs + 2]
	ld [wAITrainerCardArgs + 1], a
	ld a, [wAITrainerCardArgs + 3]
	ld [wAITrainerCardArgs + 2], a
	pop af
	scf
	ret

.CompleteCombustionDeck:
	; exit if no Magmar in Discard Pile
	ld a, CARD_LOCATION_DISCARD_PILE
	ld de, MAGMAR_LV27
	farcall FindCardIDInLocation
	ret nc

	ld a, $ff
	ld [wAITrainerCardArgs + 1], a
	ld [wAITrainerCardArgs + 2], a
	ld [wAITrainerCardArgs + 3], a
	ld a, CARD_LOCATION_DISCARD_PILE
	ld de, MAGMAR_LV27
	farcall FindCardIDInLocation
	call c, .AddCardToShuffleToDeck
	ld a, CARD_LOCATION_DISCARD_PILE
	farcall CreateBasicEnergyCardListInLocation
	ld hl, wDuelTempList
.asm_238a7
	ld a, [hli]
	cp $ff
	jr z, .asm_238b3
	push hl
	call .AddCardToShuffleToDeck
	pop hl
	jr nc, .asm_238a7
.asm_238b3
	ld a, [wAITrainerCardArgs + 1]
	cp $ff
	ret z
	push af
	ld a, [wAITrainerCardArgs + 2]
	ld [wAITrainerCardArgs + 1], a
	ld a, [wAITrainerCardArgs + 3]
	ld [wAITrainerCardArgs + 2], a
	pop af
	scf
	ret

.GazeUponThePowerOfFireDeck:
	; if 3 or more energies in Discard Pile,
	; choose top 2 as targets
	ld a, CARD_LOCATION_DISCARD_PILE
	farcall CreateBasicEnergyCardListInLocation
	jr c, .asm_238f0
	cp $03
	jr c, .asm_238f0
	ld a, [wDuelTempList + 0]
	ld [wAITrainerCardArgs + 1], a
	ld a, [wDuelTempList + 1]
	ld [wAITrainerCardArgs + 2], a
	; additionally if there's a Dark Ninetales,
	; choose it as final target
	ld a, CARD_LOCATION_DISCARD_PILE
	ld de, DARK_NINETALES
	farcall FindCardIDInLocation
	ret c
	; otherwise choose third energy
	ld a, [wDuelTempList + 2]
	scf
	ret
.asm_238f0
	or a
	ret

.SpiritedAwayDeck:
	ld a, $ff
	ld [wAITrainerCardArgs + 1], a
	ld [wAITrainerCardArgs + 2], a
	ld [wAITrainerCardArgs + 3], a
	ld a, CARD_LOCATION_DISCARD_PILE
	farcall CreateBasicEnergyCardListInLocation
	ld hl, wDuelTempList
.asm_23906
	ld a, [hli]
	cp $ff
	jr z, .asm_23914
	push hl
	call .AddCardToShuffleToDeck
	pop hl
	jr nc, .asm_23906
	jr .asm_23940
.asm_23914
	ld a, CARD_LOCATION_DISCARD_PILE
	ld de, DARK_GENGAR
	farcall FindCardIDInLocation
	call c, .AddCardToShuffleToDeck
	jr c, .asm_23940
	ld a, CARD_LOCATION_DISCARD_PILE
	ld de, DARK_HAUNTER
	farcall FindCardIDInLocation
	call c, .AddCardToShuffleToDeck
	jr c, .asm_23940
	ld a, CARD_LOCATION_DISCARD_PILE
	ld de, GASTLY_LV17
	farcall FindCardIDInLocation
	call c, .AddCardToShuffleToDeck
	jr c, .asm_23940
	or a
	ret
.asm_23940
	ld a, [wAITrainerCardArgs + 1]
	cp $ff
	ret z
	push af
	ld a, [wAITrainerCardArgs + 2]
	ld [wAITrainerCardArgs + 1], a
	ld a, [wAITrainerCardArgs + 3]
	ld [wAITrainerCardArgs + 2], a
	pop af
	scf
	ret

.SuddenGrowthDeck:
	ld a, $ff
	ld [wAITrainerCardArgs + 1], a
	ld [wAITrainerCardArgs + 2], a
	ld [wAITrainerCardArgs + 3], a
	ld a, CARD_LOCATION_DISCARD_PILE
	ld de, DRATINI_LV12
	farcall FindCardIDInLocation
	call c, .AddCardToShuffleToDeck
	ld a, CARD_LOCATION_DISCARD_PILE
	ld de, DARK_DRAGONAIR
	farcall FindCardIDInLocation
	call c, .AddCardToShuffleToDeck
	ld a, CARD_LOCATION_DISCARD_PILE
	ld de, DARK_DRAGONITE
	farcall FindCardIDInLocation
	call c, .AddCardToShuffleToDeck
	jr c, .asm_239b8
	ld a, CARD_LOCATION_DISCARD_PILE
	ld de, CLEFAIRY_LV15
	farcall FindCardIDInLocation
	call c, .AddCardToShuffleToDeck
	jr c, .asm_239b8
	ld a, CARD_LOCATION_DISCARD_PILE
	ld de, DARK_CLEFABLE
	farcall FindCardIDInLocation
	call c, .AddCardToShuffleToDeck
	jr c, .asm_239b8
	ld a, CARD_LOCATION_DISCARD_PILE
	farcall CreateBasicEnergyCardListInLocation
	ld hl, wDuelTempList
.asm_239ac
	ld a, [hli]
	cp $ff
	jr z, .asm_239b8
	push hl
	call .AddCardToShuffleToDeck
	pop hl
	jr nc, .asm_239ac
.asm_239b8
	ld a, [wAITrainerCardArgs + 1]
	cp $ff
	ret z
	push af
	ld a, [wAITrainerCardArgs + 2]
	ld [wAITrainerCardArgs + 1], a
	ld a, [wAITrainerCardArgs + 3]
	ld [wAITrainerCardArgs + 2], a
	cp $ff
	jr z, .asm_239d2
	pop af
	scf
	ret
.asm_239d2
	pop af
	or a
	ret

.BadGuysDeck:
	farcall AIDecide_NightlyGarbageRun_BadGuysDeck
	ret

.ImmortalPokemonDeck:
	farcall AIDecide_NightlyGarbageRun_ImmortalPokemonDeck
	ret

.AddCardToShuffleToDeck:
	ld b, a
	ld hl, wAITrainerCardArgs + 1
	ld a, $ff
	cp [hl]
	jr z, .asm_239f2
	inc hl
	cp [hl]
	jr z, .asm_239f2
	inc hl
	cp [hl]
	jr z, .asm_239f2
	scf
	ret
.asm_239f2
	ld [hl], b
	or a
	ret

AIPlay_FossilExcavation:
	ld a, [wCurrentAIFlags]
	or AI_FLAG_MODIFIED_HAND
	ld [wCurrentAIFlags], a
	ld a, [wAITrainerCardToPlay]
	ldh [hDuelActionCardIndex], a
	ld a, [wAITrainerCardArgs + 0]
	ldh [hDuelActionArgs + 0], a
	ld a, [wAITrainerCardArgs + 1]
	ldh [hDuelActionArgs + 1], a
	ld a, OPPACTION_EXECUTE_TRAINER_EFFECTS
	farcall AIMakeDecision
	ret

AIDecide_FossilExcavation:
	ld a, [wOpponentDeckID]
	cp LEGENDARY_FOSSIL_DECK_ID
	jp z, .LegendaryFossilDeck
	cp PROTOHISTORIC_DECK_ID
	jp z, .ProtohistoricDeck
	or a
	ret

.LegendaryFossilDeck:
.ProtohistoricDeck:
	; try targeting Mysterious Fossil in Discard Pile
	ld a, CARD_LOCATION_DISCARD_PILE
	ld de, MYSTERIOUS_FOSSIL
	farcall FindCardIDInLocation
	jr nc, .from_deck
	ld [wAITrainerCardArgs + 1], a
	ld a, $01
	ret
.from_deck
	; else, targeting Mysterious Fossil in Deck
	ld a, CARD_LOCATION_DECK
	ld de, MYSTERIOUS_FOSSIL
	farcall FindCardIDInLocation
	ret nc
	ld [wAITrainerCardArgs + 1], a
	xor a
	scf
	ret

AIPlay_Sleep:
	ld a, [wAITrainerCardToPlay]
	ldh [hDuelActionCardIndex], a
	ld a, OPPACTION_EXECUTE_TRAINER_EFFECTS
	farcall AIMakeDecision
	ret

AIDecide_Sleep:
	call SwapTurn
	bank1call CheckIfArenaCardIsProtectedFromStatusCondition
	call SwapTurn
	jr c, .no_carry
	ld a, [wOpponentDeckID]
	cp OVERFLOW_DECK_ID
	jp z, .OverflowDeck
	cp BAD_DREAM_DECK_ID
	jp z, .BadDreamDeck
.no_carry
	or a
	ret

.OverflowDeck:
	; only use if player's Arena card is not statused
	ld a, DUELVARS_ARENA_CARD_STATUS
	call GetNonTurnDuelistVariable
	or a
	jr nz, .no_carry
	scf
	ret

.BadDreamDeck:
	; only use if Arena card is Haunter lv22,
	; and player's Arena card is not already asleep
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call GetCardIDFromDeckIndex
	cp16 HAUNTER_LV22
	jr nz, .no_carry
	ld a, DUELVARS_ARENA_CARD_STATUS
	call GetNonTurnDuelistVariable
	and CNF_SLP_PRZ
	cp ASLEEP
	jr z, .no_carry
	scf
	ret

AIPlay_PokemonRecall:
	ld a, [wAITrainerCardToPlay]
	ldh [hDuelActionCardIndex], a
	ld a, [wAITrainerCardArgs + 0]
	ldh [hDuelActionArgs + 0], a
	ld a, $ff
	ldh [hDuelActionArgs + 1], a
	ld a, OPPACTION_EXECUTE_TRAINER_EFFECTS
	farcall AIMakeDecision
	ret

AIDecide_PokemonRecall:
	ld a, [wOpponentDeckID]
	cp OVERFLOW_DECK_ID
	jr z, .OverflowDeck
	cp PSYCHOKINESIS_DECK_ID
	jr z, .PsychokinesisDeck
	or a
	ret

.OverflowDeck:
	ld bc, MAGNEMITE_LV12
	ld de, MAGNETON_LV35
	farcall LookForCardIDInDiscardPile_GivenCardIDInHandOrPlayArea
	ret c
	ld bc, SPEAROW_LV13
	ld de, FEAROW_LV27
	farcall LookForCardIDInDiscardPile_GivenCardIDInHandOrPlayArea
	ret c
	ld bc, DODUO_LV10
	ld de, DODRIO_LV25
	farcall LookForCardIDInDiscardPile_GivenCardIDInHandOrPlayArea
	ret c
	ld bc, VOLTORB_LV8
	ld de, ELECTRODE_LV35
	farcall LookForCardIDInDiscardPile_GivenCardIDInHandOrPlayArea
	ret

.PsychokinesisDeck:
	ld bc, ABRA_LV8
	ld de, KADABRA_LV39
	farcall LookForCardIDInDiscardPile_GivenCardIDInHandOrPlayArea
	ret c
	ld bc, KADABRA_LV39
	ld de, ALAKAZAM_LV45
	farcall LookForCardIDInDiscardPile_GivenCardIDInHandOrPlayArea
	ret c
	ld bc, GASTLY_LV13
	ld de, HAUNTER_LV26
	farcall LookForCardIDInDiscardPile_GivenCardIDInHandOrPlayArea
	ret c
	ld bc, HAUNTER_LV26
	ld de, GENGAR_LV40
	farcall LookForCardIDInDiscardPile_GivenCardIDInHandOrPlayArea
	ret

AIPlay_MasterBall:
	ld a, [wAITrainerCardToPlay]
	ldh [hDuelActionCardIndex], a
	ld a, [wAITrainerCardArgs + 0]
	ldh [hDuelActionArgs + 0], a
	ld a, $ff
	ldh [hDuelActionArgs + 1], a
	ld a, OPPACTION_EXECUTE_TRAINER_EFFECTS
	farcall AIMakeDecision
	ret

AIDecide_MasterBall:
	; if 5 or fewer cards left in deck, skip
	ld a, DUELVARS_NUMBER_OF_CARDS_NOT_IN_DECK
	get_turn_duelist_var
	cp DECK_SIZE - 5
	ret nc

	ld a, [wOpponentDeckID]
	cp TRIPLE_ZAPDOS_DECK_ID
	jr z, .TripleZapdosDeck
	cp I_LOVE_PIKACHU_DECK_ID
	jr z, .ILovePikachuDeck
	cp PSYCHOKINESIS_DECK_ID
	jp z, .PsychokinesisDeck
	cp PUPPET_MASTER_DECK_ID
	jp z, .PuppetMasterDeck
	cp DARK_SCIENCE_DECK_ID
	jp z, .DarkScienceDeck
	cp GREAT_DRAGON_DECK_ID
	jp z, .GreatDragonDeck
	cp BUG_COLLECTING_DECK_ID
	jp z, .BugCollectingDeck
	cp DEMONIC_FOREST_DECK_ID
	jp z, .DemonicForestDeck
	cp STICKY_POISON_GAS_DECK_ID
	jp z, .StickyPoisonGasDeck
	cp CHAIN_LIGHTNING_BY_PIKACHU_DECK_ID
	jp z, .ChainLightningByPikachuDeck
	cp COMPLETE_COMBUSTION_DECK_ID
	jp z, .CompleteCombustionDeck
	cp BIG_THUNDER_DECK_ID
	jp z, .BigThunderDeck
	or a
	ret

.TripleZapdosDeck:
	; check if can get any of the following cards
	ld de, ZAPDOS_LV28
	farcall AITryMasterBall_GivenTarget
	ret c
	ld de, ZAPDOS_LV40
	farcall AITryMasterBall_GivenTarget
	ret c
	ld de, ZAPDOS_LV64
	farcall AITryMasterBall_GivenTarget
	ret c
	; else, get any card Pokémon card if possible
	farcall AITryMasterBall
	ret

.ILovePikachuDeck:
	; if AI has Pokéball in hand, then skip
	ld de, POKEBALL
	farcall LookForCardIDInHand
	jr nc, .asm_23b8c
.asm_23b8a
	or a
	ret
.asm_23b8c
	; continue if has less than 3 Pokémon in play
	; and if no basic Pokémon in hand
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	cp $03
	jr nc, .asm_23b8a
	farcall CountNumberOfBasicPokemonInHand
	or a
	jr nz, .asm_23b8a
	; try getting any one of the following cards
	ld de, FLYING_PIKACHU_LV12
	farcall AITryMasterBall_GivenTarget
	ret c
	ld de, FLYING_PIKACHU_ALT_LV12
	farcall AITryMasterBall_GivenTarget
	ret c
	ld de, PIKACHU_LV16
	farcall AITryMasterBall_GivenTarget
	ret c
	ld de, PIKACHU_ALT_LV16
	farcall AITryMasterBall_GivenTarget
	ret c
	ld de, PIKACHU_LV5
	farcall AITryMasterBall_GivenTarget
	ret c
	ld de, PIKACHU_LV13
	farcall AITryMasterBall_GivenTarget
	ret c
	ld de, SURFING_PIKACHU_LV13
	farcall AITryMasterBall_GivenTarget
	ret c
	ld de, SURFING_PIKACHU_ALT_LV13
	farcall AITryMasterBall_GivenTarget
	ret c
	; else, get any card Pokémon card if possible
	farcall AITryMasterBall
	ret

.PsychokinesisDeck:
	; get any card Pokémon card if possible
	farcall AITryMasterBall
	ret

.PuppetMasterDeck:
	; if has Drowzee in play/hand, try getting Hypno
	ld bc, DROWZEE_LV12
	ld de, HYPNO_LV30
	farcall LookForEvoCardInDeck_GivenPreevoInHandOrPlayArea
	jr nc, .asm_23bf8
	ld de, HYPNO_LV30
	farcall AITryMasterBall_GivenTarget
	ret c
.asm_23bf8
	; if has Slowpoke in play/hand, try getting Slowbro
	ld bc, SLOWPOKE_LV18
	ld de, SLOWBRO_LV26
	farcall LookForEvoCardInDeck_GivenPreevoInHandOrPlayArea
	ret nc
	ld de, SLOWBRO_LV26
	farcall AITryMasterBall_GivenTarget
	ret c
	; else, get any card Pokémon card if possible
	farcall AITryMasterBall
	ret

.DarkScienceDeck:
	; if has Koffing in play/hand, try getting Weezing
	ld bc, KOFFING_LV13
	ld de, WEEZING_LV26
	farcall LookForEvoCardInDeck_GivenPreevoInHandOrPlayArea
	jr nc, .asm_23c24
	ld de, WEEZING_LV26
	farcall AITryMasterBall_GivenTarget
	ret c
.asm_23c24
	; if has Ekans in play/hand, try getting Arbok
	ld bc, EKANS_LV15
	ld de, ARBOK_LV30
	farcall LookForEvoCardInDeck_GivenPreevoInHandOrPlayArea
	jr nc, .asm_23c38
	ld de, ARBOK_LV30
	farcall AITryMasterBall_GivenTarget
	ret c
.asm_23c38
	; else, try getting any one of the following cards
	ld de, GRIMER_LV10
	farcall AITryMasterBall_GivenTarget
	ret c
	ld de, KOFFING_LV13
	farcall AITryMasterBall_GivenTarget
	ret c
	ld de, EKANS_LV15
	farcall AITryMasterBall_GivenTarget
	ret c
	ld de, ZUBAT_LV12
	farcall AITryMasterBall_GivenTarget
	ret c
	ld de, CHANSEY_LV55
	farcall AITryMasterBall_GivenTarget
	ret

.GreatDragonDeck:
	; if has Dratini in play/hand, try getting Dark Dragonair
	ld bc, DRATINI_LV10
	ld de, DARK_DRAGONAIR
	farcall LookForEvoCardInDeck_GivenPreevoInHandOrPlayArea
	jr nc, .asm_23c74
	ld de, DARK_DRAGONAIR
	farcall AITryMasterBall_GivenTarget
	ret c
.asm_23c74
	ld bc, DRATINI_LV12
	ld de, DARK_DRAGONAIR
	farcall LookForEvoCardInDeck_GivenPreevoInHandOrPlayArea
	jr nc, .asm_23c88
	ld de, DARK_DRAGONAIR
	farcall AITryMasterBall_GivenTarget
	ret c
.asm_23c88
	; if has Charmeleon in play/hand, try getting Charizard
	ld bc, CHARMELEON
	ld de, CHARIZARD_LV76
	farcall LookForEvoCardInDeck_GivenPreevoInHandOrPlayArea
	jr nc, .asm_23c9c
	ld de, CHARIZARD_LV76
	farcall AITryMasterBall_GivenTarget
	ret c
.asm_23c9c
	ld bc, CHARMELEON
	ld de, CHARIZARD_ALT_LV76
	farcall LookForEvoCardInDeck_GivenPreevoInHandOrPlayArea
	jr nc, .asm_23cb0
	ld de, CHARIZARD_ALT_LV76
	farcall AITryMasterBall_GivenTarget
	ret c
.asm_23cb0
	; if has Charmander in play/hand, try getting Charmeleon
	ld bc, CHARMANDER_LV12
	ld de, CHARMELEON
	farcall LookForEvoCardInDeck_GivenPreevoInHandOrPlayArea
	jr nc, .asm_23cc4
	ld de, CHARMELEON
	farcall AITryMasterBall_GivenTarget
	ret c
.asm_23cc4
	ld bc, CHARMANDER_LV10
	ld de, CHARMELEON
	farcall LookForEvoCardInDeck_GivenPreevoInHandOrPlayArea
	ret nc
	ld de, CHARMELEON
	farcall AITryMasterBall_GivenTarget
	ret c
	; else, get any card Pokémon card if possible
	farcall AITryMasterBall
	ret

.BugCollectingDeck:
	; if has Weedle in play/hand, try getting Kakuna
	ld bc, WEEDLE_LV12
	ld de, KAKUNA_LV20
	farcall LookForEvoCardInDeck_GivenPreevoInHandOrPlayArea
	jr nc, .asm_23cf0
	ld de, KAKUNA_LV20
	farcall AITryMasterBall_GivenTarget
	ret c
.asm_23cf0
	; if has Venonat in play/hand, try getting Venomoth
	ld bc, VENONAT_LV12
	ld de, VENOMOTH_LV22
	farcall LookForEvoCardInDeck_GivenPreevoInHandOrPlayArea
	jr nc, .asm_23d04
	ld de, VENOMOTH_LV22
	farcall AITryMasterBall_GivenTarget
	ret c
.asm_23d04
	; if has Caterpie in play/hand, try getting Metapod
	ld bc, CATERPIE
	ld de, METAPOD_LV20
	farcall LookForEvoCardInDeck_GivenPreevoInHandOrPlayArea
	jr nc, .asm_23d18
	ld de, METAPOD_LV20
	farcall AITryMasterBall_GivenTarget
	ret c
.asm_23d18
	; if has Metapod in play/hand, try getting Butterfree
	ld bc, METAPOD_LV20
	ld de, BUTTERFREE
	farcall LookForEvoCardInDeck_GivenPreevoInHandOrPlayArea
	jr nc, .asm_23d2c
	ld de, BUTTERFREE
	farcall AITryMasterBall_GivenTarget
	ret c
.asm_23d2c
	; if has Meowth in play/hand, try getting Dark Persian
	ld bc, MEOWTH_LV10
	ld de, DARK_PERSIAN_LV28
	farcall LookForEvoCardInDeck_GivenPreevoInHandOrPlayArea
	ret nc
	ld de, DARK_PERSIAN_LV28
	farcall AITryMasterBall_GivenTarget
	ret c
	; else, get any card Pokémon card if possible
	farcall AITryMasterBall
	ret

.DemonicForestDeck:
	; try getting any one of the following cards
	ld de, DARK_IVYSAUR
	farcall AITryMasterBall_GivenTarget
	ret c
	ld de, DARK_VENUSAUR
	farcall AITryMasterBall_GivenTarget
	ret c
	ld de, BULBASAUR_LV15
	farcall AITryMasterBall_GivenTarget
	ret c
	; else, get any card Pokémon card if possible
	farcall AITryMasterBall
	ret

.StickyPoisonGasDeck:
	; if has Koffing in play/hand, try getting Dark Weezing
	ld bc, KOFFING_LV12
	ld de, DARK_WEEZING
	farcall LookForEvoCardInDeck_GivenPreevoInHandOrPlayArea
	jr nc, .asm_23d75
	ld de, DARK_WEEZING
	farcall AITryMasterBall_GivenTarget
	ret c
.asm_23d75
	; if has Grimer in play/hand, try getting Muk
	ld bc, GRIMER_LV10
	ld de, MUK
	farcall LookForEvoCardInDeck_GivenPreevoInHandOrPlayArea
	jr nc, .asm_23d89
	ld de, MUK
	farcall AITryMasterBall_GivenTarget
	ret c
.asm_23d89
	; if has Ekans in play/hand, try getting Dark Arbok
	ld bc, EKANS_LV15
	ld de, DARK_ARBOK
	farcall LookForEvoCardInDeck_GivenPreevoInHandOrPlayArea
	jr nc, .asm_23d9d
	ld de, DARK_ARBOK
	farcall AITryMasterBall_GivenTarget
	ret c
.asm_23d9d
	; else, try getting any one of the following cards
	ld de, KOFFING_LV12
	farcall AITryMasterBall_GivenTarget
	ret c
	ld de, GRIMER_LV10
	farcall AITryMasterBall_GivenTarget
	ret c
	ld de, EKANS_LV15
	farcall AITryMasterBall_GivenTarget
	ret c
	ld de, CHARMANDER_LV10
	farcall AITryMasterBall_GivenTarget
	ret c
	; else, get any card Pokémon card if possible
	farcall AITryMasterBall
	ret

.ChainLightningByPikachuDeck:
	farcall AIDecide_MasterBall_ChainLightningByPikachuDeck
	ret

.CompleteCombustionDeck:
	; try getting any one of the following cards
	ld de, MAGMAR_LV27
	farcall AITryMasterBall_GivenTarget
	ret c
	ld de, PONYTA_LV15
	farcall AITryMasterBall_GivenTarget
	ret c
	ld de, GROWLITHE_LV12
	farcall AITryMasterBall_GivenTarget
	ret c
	ld de, KANGASKHAN_LV40
	farcall AITryMasterBall_GivenTarget
	ret c
	ld de, MEOWTH_LV14
	farcall AITryMasterBall_GivenTarget
	ret c
	; else, get any card Pokémon card if possible
	farcall AITryMasterBall
	ret

.BigThunderDeck:
	farcall AIDecide_MasterBall_BigThunderDeck
	ret

AIPlay_BillsTeleporter:
	ld a, [wAITrainerCardToPlay]
	ldh [hDuelActionCardIndex], a
	ld a, OPPACTION_EXECUTE_TRAINER_EFFECTS
	farcall AIMakeDecision
	ret

AIDecide_BillsTeleporter:
	; only use if has more than 13 cards in deck
	ld a, DUELVARS_NUMBER_OF_CARDS_NOT_IN_DECK
	get_turn_duelist_var
	cp DECK_SIZE - 13
	ret

AIPlay_MoonStone:
	ld a, [wAITrainerCardToPlay]
	ldh [hDuelActionCardIndex], a
	ld a, [wAITrainerCardArgs + 0]
	ldh [hDuelActionArgs + 0], a
	ld a, OPPACTION_EXECUTE_TRAINER_EFFECTS
	farcall AIMakeDecision
	ret

AIDecide_MoonStone:
	; exit if has 4 or fewer cards in deck
	ld a, DUELVARS_NUMBER_OF_CARDS_NOT_IN_DECK
	get_turn_duelist_var
	cp DECK_SIZE - 4
	ret nc

	ld a, [wOpponentDeckID]
	cp HAND_OVER_GR_DECK_ID
	jr z, .HandOverGRDeck
	cp I_LOVE_TO_FIGHT_DECK_ID
	jr z, .ILoveToFightDeck
	cp EYE_OF_THE_STORM_DECK_ID
	jr z, .EyeOfTheStormDeck
	cp SUDDEN_GROWTH_DECK_ID
	jr z, .SuddenGrowthDeck
	cp COLORLESS_ENERGY_DECK_ID
	jr z, .ColorlessEnergyDeck
	cp RONALDS_ULTRA_DECK_ID
	jr z, .RonaldsUltraDeck
	or a
	ret

.HandOverGRDeck:
	ld bc, JIGGLYPUFF_LV13
	ld de, WIGGLYTUFF_LV36
	farcall LookForEvoCardInDeck_GivenPreevoInHandOrPlayArea
	ret

.ILoveToFightDeck:
	ld a, CARD_LOCATION_DECK
	ld de, DODRIO_LV28
	farcall FindCardIDInLocation
	ret

.EyeOfTheStormDeck:
	farcall AIDecide_MoonStone_EyeOfTheStormDeck
	ret

.SuddenGrowthDeck:
	ld bc, DRATINI_LV12
	ld de, DARK_DRAGONAIR
	farcall LookForEvoCardInDeck_GivenPreevoInHandOrPlayArea
	ret c
	ld bc, CLEFAIRY_LV15
	ld de, DARK_CLEFABLE
	farcall LookForEvoCardInDeck_GivenPreevoInHandOrPlayArea
	ret

.ColorlessEnergyDeck:
	farcall AIDecide_MoonStone_ColorlessEnergyDeck
	ret

.RonaldsUltraDeck:
	farcall AIDecide_MoonStone_RonaldsUltraDeck
	ret

AIPlay_TheRocketsTrap:
	ld a, [wAITrainerCardToPlay]
	ldh [hDuelActionCardIndex], a
	ld a, OPPACTION_EXECUTE_TRAINER_EFFECTS
	farcall AIMakeDecision
	ret

AIDecide_TheRocketsTrap:
	ld a, [wOpponentDeckID]
	cp RONALDS_ULTRA_DECK_ID
	jr z, .RonaldsUltraDeck

	; use if player's hand has 5 or more cards
	ld a, DUELVARS_NUMBER_OF_CARDS_IN_HAND
	call GetNonTurnDuelistVariable
	cp 5
	ccf
	ret

.RonaldsUltraDeck:
	; use if player's hand has 3 or more cards
	ld a, DUELVARS_NUMBER_OF_CARDS_IN_HAND
	call GetNonTurnDuelistVariable
	cp 3
	ccf
	ret

AIPlay_GoopGasAttack:
	ld a, [wAITrainerCardToPlay]
	ldh [hDuelActionCardIndex], a
	ld a, OPPACTION_EXECUTE_TRAINER_EFFECTS
	farcall AIMakeDecision
	ret

AIDecide_GoopGasAttack:
	ld a, [wOpponentDeckID]
	cp WEIRD_DECK_ID
	jr z, .use_if_has_valid_stare_target

	; skip if Muk is in play
	ld de, MUK
	ld b, PLAY_AREA_ARENA
	farcall FindCardIDInTurnDuelistsPlayArea
	jr nc, .use_if_has_valid_stare_target
	or a
	ret

.use_if_has_valid_stare_target
	farcall AIChooseStareTarget
	ret

AIPlay_ImposterOaksRevenge:
	ld a, [wAITrainerCardToPlay]
	ldh [hDuelActionCardIndex], a
	ld a, [wAITrainerCardArgs + 0]
	ldh [hDuelActionArgs + 0], a
	ld a, OPPACTION_EXECUTE_TRAINER_EFFECTS
	farcall AIMakeDecision
	ret

AIDecide_ImposterOaksRevenge:
	ld a, [wOpponentDeckID]
	cp EEVEE_SHOWDOWN_DECK_ID
	jr z, .EeveeShowdownDeck
	cp RONALDS_POWER_DECK_ID
	jr z, .RonaldsPowerDeck
.no_carry
	or a
	ret

.EeveeShowdownDeck:
	; if player has less than 5 cards, skip
	ld a, DUELVARS_NUMBER_OF_CARDS_IN_HAND
	call GetNonTurnDuelistVariable
	cp 5
	jr c, .no_carry
	; else, use if any of the following cards
	; are repeated in the hand
	ld de, SWITCH
	farcall CheckIfHandHasRepeatedCard
	ret c
	ld de, POKEMON_TRADER
	farcall CheckIfHandHasRepeatedCard
	ret c
	ld de, ENERGY_SEARCH
	farcall CheckIfHandHasRepeatedCard
	ret c
	ld de, ENERGY_RETRIEVAL
	farcall CheckIfHandHasRepeatedCard
	ret

.RonaldsPowerDeck:
	; if player has less than 5 cards, skip
	ld a, DUELVARS_NUMBER_OF_CARDS_IN_HAND
	call GetNonTurnDuelistVariable
	cp 5
	jr c, .no_carry
	; else, find if there's any repeated card in hand
	call CreateHandCardList
	ld hl, wDuelTempList
	farcall FindDuplicateCards_IgnoreTrainerCardToPlay
	jp c, .no_carry
	; prefer to discard a non-Pkmn card
	push af
	ld a, [wTempAITargetNonPokemonCardDeckIndex]
	cp $ff
	jr z, .asm_23f2d
	pop af
	ld a, [wTempAITargetNonPokemonCardDeckIndex]
	push af
.asm_23f2d
	pop af
	scf
	ret

AIPlay_Digger:
	ld a, [wAITrainerCardToPlay]
	ldh [hDuelActionCardIndex], a
	ld a, OPPACTION_EXECUTE_TRAINER_EFFECTS
	farcall AIMakeDecision
	ret

AIDecide_Digger:
	; always use Digger
	scf
	ret

AIPlay_ComputerError:
	ld a, [wAITrainerCardToPlay]
	ldh [hDuelActionCardIndex], a
	ld a, [wAITrainerCardArgs + 0]
	ldh [hDuelActionArgs + 0], a
	call SwapTurn
	farcall HandleComputerErrorPlayerSelection
	call SwapTurn
	ldh [hDuelActionArgs + 1], a
	ld a, OPPACTION_EXECUTE_TRAINER_EFFECTS
	farcall AIMakeDecision
	ld a, $02
	ld [wd033], a
	scf
	ret

AIDecide_ComputerError:
	ld a, [wOpponentDeckID]
	cp VERY_RARE_CARD_DECK_ID
	jr z, .VeryRareCardDeck
	cp STRANGE_DECK_ID
	jr z, .StrangeDeck
	cp RONALDS_POWER_DECK_ID
	jr z, .RonaldsPowerDeck
.no_carry
	or a
	ret

.VeryRareCardDeck:
	; if an attack can be used, then don't use Computer Error
	farcall AIProcessButDontUseAttack
	jr c, .no_carry
	; otherwise, if has 3 or more cards in hand, skip
	ld a, DUELVARS_NUMBER_OF_CARDS_IN_HAND
	get_turn_duelist_var
	cp 3
	ret nc
	; else, use Computer Error and draw 5 cards
	ld a, 5
	scf
	ret

.StrangeDeck:
	; always use Computer Error and draw 5 cards
	ld a, 5
	scf
	ret

.RonaldsPowerDeck:
	; if an attack can be used, then don't use Computer Error
	farcall AIProcessButDontUseAttack
	jr c, .no_carry
	; otherwise, if has 9 or fewer cards in deck, skip
	ld a, DUELVARS_NUMBER_OF_CARDS_NOT_IN_DECK
	get_turn_duelist_var
	cp DECK_SIZE - 9
	ret nc
	; else, use Computer Error and draw 5 cards
	ld a, 5
	scf
	ret

AIPlay_SuperScoopUp:
	ld a, [wAITrainerCardToPlay]
	ldh [hDuelActionCardIndex], a
	ld de, RHYDON_LV37
	bank1call TossCoin
	ldh [hDuelActionArgs + 0], a
	jr nc, .tails
	ld a, [wAITrainerCardArgs + 0]
	ldh [hDuelActionArgs + 1], a
	ld a, [wAITrainerCardArgs + 1]
	ldh [hDuelActionArgs + 2], a
	jr .asm_23fb5
.tails
	ld a, $ff
	ldh [hDuelActionArgs + 1], a
.asm_23fb5
	ld a, OPPACTION_EXECUTE_TRAINER_EFFECTS
	farcall AIMakeDecision
	ret

AIDecide_SuperScoopUp:
	; if has more than 1 Pokémon in play...
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	cp 1
	jr z, .no_carry
	; ...and Arena card cannot KO player's card...
	farcall CheckIfArenaCardCanKnockOutDefendingCard_CheckHand
	jr c, .no_carry
	; ...and player's card can KO Arena card...
	xor a
	ldh [hTempPlayAreaLocation_ff9d], a
	farcall CheckIfDefendingPokemonCanKnockOut
	jr nc, .no_carry

	; ..then try checking for a Bench Pokémon to switch to
	farcall AIDecideBenchPokemonToSwitchTo
	jr c, .no_carry
	; skip if score to retreat < 50
	ld a, e
	cp 50
	jr c, .no_carry
	; valid benched Pokémon, use Super Scoop Up on Arena card
	ld a, d
	ld [wAITrainerCardArgs + 1], a
	xor a
	scf
	ret
.no_carry
	or a
	ret
