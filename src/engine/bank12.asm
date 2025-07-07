; returns carry if number of turns
; the AI has taken >= 5.
; used to know whether AI Sam is still
; doing scripted turns.
IsAISamPracticeScriptedTurn:
	ld a, [wDuelTurns]
	srl a
	cp 5
	ccf
	ret

; sets the number of prizes to 2
; and places Seel and Goldeen from the hand to the Play Area
SetSamsStartingPlayArea:
	ld a, 2
	ld [wDuelInitialPrizes], a
	call CreateHandCardList
	ld hl, wDuelTempList
.loop_hand
	ld a, [hli]
	ldh [hTempCardIndex_ff98], a
	cp $ff
	ret z
	call GetCardIDFromDeckIndex
	cp16 SEEL_LV12
	jr nz, .check_goldeen
	call .PlaceInPlayArea
	jr .loop_hand
.check_goldeen
	cp16 GOLDEEN
	jr nz, .loop_hand
.PlaceInPlayArea:
	ldh a, [hTempCardIndex_ff98]
	call PutHandPokemonCardInPlayArea
	ret

; outputs in a Play Area location of Goldeen in the Bench.
; If not found, just output PLAY_AREA_BENCH_1.
GetPlayAreaLocationOfGoldeen:
	ld de, GOLDEEN
	ld b, PLAY_AREA_BENCH_1
	farcall FindCardIDInTurnDuelistsPlayArea
	cp $ff
	jr nz, .found
	ld a, PLAY_AREA_BENCH_1
.found
	ldh [hTempPlayAreaLocation_ff9d], a
	ret

AITakePrizeCardInOrder:
	ld a, [wNumberPrizeCardsToTake]
	ld b, a
.loop_prize_cards
	call .TakeNextPrize
	ld a, DUELVARS_PRIZES
	get_turn_duelist_var
	or a
	jr z, .took_all_prizes
	dec b
	jr nz, .loop_prize_cards
.took_all_prizes
	ret

.TakeNextPrize:
	ld a, DUELVARS_PRIZES
	get_turn_duelist_var
	ld d, $1
	ld e, 0
	ld c, a
.loop_search
	ld a, c
	and d
	jr nz, .found_prize
	sla d
	inc e
	jr .loop_search
.found_prize
	; unset bit
	ld a, c
	sub d
	ld [hl], a
	; take prize card to hand
	ld a, e
	add DUELVARS_PRIZE_CARDS
	get_turn_duelist_var
	call AddCardToHand
	ret

AISamPerformScriptedTurn:
	ld a, [wDuelTurns]
	srl a
	ld hl, .scripted_actions_list
	call JumpToFunctionInTable
	; output is an attack to use
	ld [wSelectedAttack], a

; always attack with Arena card
; if it's unusable end turn without attacking.
	xor a ; PLAY_AREA_ARENA
	ldh [hTempPlayAreaLocation_ff9d], a
	farcall CheckIfSelectedAttackIsUnusable
	jr c, .unusable
	farcall AITryUseAttack
	ret
.unusable
	ld a, OPPACTION_FINISH_NO_ATTACK
	farcall AIMakeDecision
	ret

.scripted_actions_list
	dw .turn_1
	dw .turn_2
	dw .turn_3
	dw .turn_4
	dw .turn_5

.turn_1
	ld de, SEEL_LV12
	ld bc, WATER_ENERGY
	farcall AIAttachEnergyInHandToCardInPlayArea
	xor a ; FIRST_ATTACK_OR_PKMN_POWER
	ret

.turn_2
	ld de, POTION
	farcall LookForCardIDInHandList
	ldh [hTempCardIndex_ff9f], a
	ld a, OPPACTION_PLAY_TRAINER
	farcall AIMakeDecision
	xor a ; PLAY_AREA_ARENA
	ldh [hTemp_ffa0], a
	ld a, 20
	ldh [hTempPlayAreaLocation_ffa1], a
	ld a, OPPACTION_EXECUTE_TRAINER_EFFECTS
	farcall AIMakeDecision
	ld de, GOLDEEN
	ld bc, WATER_ENERGY
	farcall AIAttachEnergyInHandToCardInPlayArea
	xor a ; FIRST_ATTACK_OR_PKMN_POWER
	ret

.turn_3
	ld de, GOLDEEN
	ld b, PLAY_AREA_ARENA
	farcall FindCardIDInTurnDuelistsPlayArea
	ldh [hTempPlayAreaLocation_ffa1], a
	ld de, SEAKING
	farcall LookForCardIDInHandList
	ldh [hTemp_ffa0], a
	ldh [hTempCardIndex_ff9f], a
	ld a, OPPACTION_EVOLVE_PKMN
	farcall AIMakeDecision
	ldh a, [hTempPlayAreaLocation_ff9d]
	ldh [hTemp_ffa0], a
	ld a, OPPACTION_UNK_18
	farcall AIMakeDecision
	ld de, SEAKING
	ld bc, WATER_ENERGY
	farcall AIAttachEnergyInHandToCardInPlayArea
	ld a, SECOND_ATTACK
	ret

.turn_4
	ld de, POTION
	farcall LookForCardIDInHandList
	ldh [hTempCardIndex_ff9f], a
	ld a, OPPACTION_PLAY_TRAINER
	farcall AIMakeDecision
	xor a ; PLAY_AREA_ARENA
	ldh [hTemp_ffa0], a
	ld a, 20
	ldh [hTempPlayAreaLocation_ffa1], a
	ld a, OPPACTION_EXECUTE_TRAINER_EFFECTS
	farcall AIMakeDecision
	ld a, SECOND_ATTACK
	ret

.turn_5
	ld de, STARYU_LV15
	farcall LookForCardIDInHandList
	ldh [hTemp_ffa0], a
	ldh [hTempCardIndex_ff9f], a
	ld a, OPPACTION_PLAY_BASIC_PKMN
	farcall AIMakeDecision
	ldh a, [hTempPlayAreaLocation_ff9d]
	ldh [hTemp_ffa0], a
	ld a, OPPACTION_UNK_18
	farcall AIMakeDecision
	ld de, STARYU_LV15
	ld bc, WATER_ENERGY
	farcall AIAttachEnergyInHandToCardInPlayArea
	ld a, SECOND_ATTACK
	ret

SetAaronStep1StartingPlayArea:
	ld a, 4
	ld [wDuelInitialPrizes], a
	ld de, HITMONCHAN_LV33
	farcall LookForCardIDInHandList
	call PutHandPokemonCardInPlayArea
	ld de, BULBASAUR_LV12
	farcall LookForCardIDInHandList
	call PutHandPokemonCardInPlayArea
	ret

AIAaronStep1PerformScriptedTurn:
	ld a, [wDuelTurns]
	srl a
	ld hl, .scripted_actions_list
	call JumpToFunctionInTable
	; output is an attack to use
	ld [wSelectedAttack], a

; always attack with Arena card
; if it's unusable end turn without attacking.
	xor a ; PLAY_AREA_ARENA
	ldh [hTempPlayAreaLocation_ff9d], a
	farcall CheckIfSelectedAttackIsUnusable
	jr c, .unusable
	farcall AITryUseAttack
	ret
.unusable
	ld a, OPPACTION_FINISH_NO_ATTACK
	farcall AIMakeDecision
	ret

.scripted_actions_list
	dw .turn_1

.turn_1
	ld de, HITMONCHAN_LV33
	ld bc, FIGHTING_ENERGY
	farcall AIAttachEnergyInHandToCardInPlayArea
	xor a ; FIRST_ATTACK_OR_PKMN_POWER
	ret

SetAaronStep2StartingPlayArea:
	ld a, 4
	ld [wDuelInitialPrizes], a
	ld de, GRIMER_LV10
	farcall LookForCardIDInHandList
	call PutHandPokemonCardInPlayArea
	ld de, RATTATA_LV9
	farcall LookForCardIDInHandList
	call PutHandPokemonCardInPlayArea
	ret

AIAaronStep2PerformScriptedTurn:
	ld a, [wDuelTurns]
	srl a
	ld hl, .scripted_actions_list
	call JumpToFunctionInTable
	; output is an attack to use
	ld [wSelectedAttack], a

; always attack with Arena card
; if it's unusable end turn without attacking.
	xor a ; PLAY_AREA_ARENA
	ldh [hTempPlayAreaLocation_ff9d], a
	farcall CheckIfSelectedAttackIsUnusable
	jr c, .unusable
	farcall AITryUseAttack
	ret
.unusable
	ld a, OPPACTION_FINISH_NO_ATTACK
	farcall AIMakeDecision
	ret

.scripted_actions_list
	dw .turn_1
	dw .turn_2

.turn_1
	ld de, GRIMER_LV10
	ld bc, GRASS_ENERGY
	farcall AIAttachEnergyInHandToCardInPlayArea
	xor a ; FIRST_ATTACK_OR_PKMN_POWER
	ret

.turn_2
	ld de, ODDISH_LV8
	farcall LookForCardIDInHandList
	ldh [hTemp_ffa0], a
	ldh [hTempCardIndex_ff9f], a
	ld a, OPPACTION_PLAY_BASIC_PKMN
	farcall AIMakeDecision
	ldh a, [hTempPlayAreaLocation_ff9d]
	ldh [hTemp_ffa0], a
	ld a, OPPACTION_UNK_18
	farcall AIMakeDecision
	ld de, GRIMER_LV10
	ld bc, GRASS_ENERGY
	farcall AIAttachEnergyInHandToCardInPlayArea
	ld a, DUELVARS_ARENA_CARD_STATUS
	call GetNonTurnDuelistVariable
	or a
	ret z ; statused
	ld a, SECOND_ATTACK
	ret

SetAaronStep3StartingPlayArea:
	ld a, 4
	ld [wDuelInitialPrizes], a
	xor a
	ld [wAIPeekedPrizes], a
	ld de, CHANSEY_LV55
	farcall LookForCardIDInHandList
	call PutHandPokemonCardInPlayArea
	ld de, ABRA_LV10
	farcall LookForCardIDInHandList
	call PutHandPokemonCardInPlayArea
	ret

AIAaronStep3PerformScriptedTurn:
	ld a, [wDuelTurns]
	srl a
	ld hl, .scripted_actions_list
	call JumpToFunctionInTable
	; output is an attack to use
	ld [wSelectedAttack], a

; always attack with Arena card
; if it's unusable end turn without attacking.
	xor a ; PLAY_AREA_ARENA
	ldh [hTempPlayAreaLocation_ff9d], a
	farcall CheckIfSelectedAttackIsUnusable
	jr c, .unusable
	farcall AITryUseAttack
	ret
.end_turn_without_attacking
	add sp, $2
.unusable
	ld a, OPPACTION_FINISH_NO_ATTACK
	farcall AIMakeDecision
	ret

.scripted_actions_list
	dw .turn_1
	dw .turn_2
	dw .turn_3
	dw .turn_4
	dw .turn_5

.turn_1
	ld de, CHANSEY_LV55
	ld bc, DOUBLE_COLORLESS_ENERGY
	farcall AIAttachEnergyInHandToCardInPlayArea
	xor a ; FIRST_ATTACK_OR_PKMN_POWER
	ret

.turn_2
	ld de, CHANSEY_LV55
	farcall LookForCardIDInHandList
	ldh [hTemp_ffa0], a
	ldh [hTempCardIndex_ff9f], a
	ld a, OPPACTION_PLAY_BASIC_PKMN
	farcall AIMakeDecision
	ldh a, [hTempPlayAreaLocation_ff9d]
	ldh [hTemp_ffa0], a
	ld a, OPPACTION_UNK_18
	farcall AIMakeDecision
	ld de, POKEMON_BREEDER
	farcall LookForCardIDInHandList
	ldh [hTempCardIndex_ff9f], a
	ld a, OPPACTION_PLAY_TRAINER
	farcall AIMakeDecision
	ld de, ALAKAZAM_LV42
	farcall LookForCardIDInHandList
	ldh [hTemp_ffa0], a
	ld de, ABRA_LV10
	ld b, PLAY_AREA_BENCH_1
	farcall FindCardIDInTurnDuelistsPlayArea
	ldh [hTempPlayAreaLocation_ffa1], a
	push af
	ld a, OPPACTION_EXECUTE_TRAINER_EFFECTS
	farcall AIMakeDecision
	ld a, [wcd15]
	ldh [hTempCardIndex_ff9f], a
	pop af
	ldh [hTemp_ffa0], a
	ld [wTempAIPokemonCard], a
	ld a, OPPACTION_UNK_18
	farcall AIMakeDecision
	call AIHandlePkmnPowersWhenPlayingPkmnFromHand
	ld a, OPPACTION_UNK_19
	farcall AIMakeDecision
	farcall HandleAIDamageSwap
	ld de, CHANSEY_LV55
	ld bc, DOUBLE_COLORLESS_ENERGY
	farcall AIAttachEnergyInHandToCardInPlayArea
	xor a ; PLAY_AREA_ARENA
	farcall CheckIfCanDamageDefendingPokemon
	jp nc, .end_turn_without_attacking ; can't damage
	ld a, SECOND_ATTACK
	ret

.turn_3
	call .CheckIfPlayerUsedProfessorOak
	jp c, .unscripted ; player used Professor Oak
	farcall HandleAIDamageSwap
	ld de, POKEMON_CENTER
	farcall LookForCardIDInHandList
	ldh [hTempCardIndex_ff9f], a
	ld a, OPPACTION_PLAY_TRAINER
	farcall AIMakeDecision
	ld a, OPPACTION_EXECUTE_TRAINER_EFFECTS
	farcall AIMakeDecision
	ld de, ALAKAZAM_LV42
	ld bc, PSYCHIC_ENERGY
	farcall AIAttachEnergyInHandToCardInPlayArea
	xor a ; PLAY_AREA_ARENA
	farcall CheckIfCanDamageDefendingPokemon
	jp nc, .end_turn_without_attacking ; can't damage
	ld a, SECOND_ATTACK
	ret

.turn_4
	call .CheckIfPlayerUsedProfessorOak
	jp c, .unscripted ; player used Professor Oak
	ld de, CHANSEY_LV55
	ld b, PLAY_AREA_BENCH_1
	farcall FindCardIDInTurnDuelistsPlayArea
	jr nc, .unscripted
	farcall HandleAIDamageSwap
	ld de, ALAKAZAM_LV42
	ld bc, PSYCHIC_ENERGY
	farcall AIAttachEnergyInHandToCardInPlayArea
	xor a ; PLAY_AREA_ARENA
	farcall CheckIfCanDamageDefendingPokemon
	jp nc, .end_turn_without_attacking ; can't damage
	ld a, SECOND_ATTACK
	ret

.turn_5
	call .CheckIfPlayerUsedProfessorOak
	jr c, .unscripted ; player used Professor Oak
	farcall HandleAIDamageSwap
	call CheckIfAnyPlayAreaPokemonHasDamage
	jr nc, .asm_4839b
	ld de, SCOOP_UP
	farcall LookForCardIDInHandList
	ldh [hTempCardIndex_ff9f], a
	ld de, CHANSEY_LV55
	ld b, PLAY_AREA_BENCH_1
	farcall FindCardIDInTurnDuelistsPlayArea
	jr nc, .unscripted
	ldh [hTemp_ffa0], a
	ld a, OPPACTION_PLAY_TRAINER
	farcall AIMakeDecision
	ld a, OPPACTION_EXECUTE_TRAINER_EFFECTS
	farcall AIMakeDecision
	ld de, CHANSEY_LV55
	farcall LookForCardIDInHandList
	ldh [hTemp_ffa0], a
	ldh [hTempCardIndex_ff9f], a
	ld a, OPPACTION_PLAY_BASIC_PKMN
	farcall AIMakeDecision
	ldh a, [hTempPlayAreaLocation_ff9d]
	ldh [hTemp_ffa0], a
	ld a, OPPACTION_UNK_18
	farcall AIMakeDecision
	farcall HandleAIDamageSwap
.asm_4839b
	ld de, ALAKAZAM_LV42
	ld bc, PSYCHIC_ENERGY
	farcall AIAttachEnergyInHandToCardInPlayArea
	xor a ; PLAY_AREA_ARENA
	farcall CheckIfCanDamageDefendingPokemon
	jp nc, .end_turn_without_attacking ; can't damage
	ld a, SECOND_ATTACK
	ret

.unscripted
	; set rest of the duel as unscripted
	ld a, $01
	ld [wAIPeekedPrizes], a
	call AIMainTurnLogic
	add sp, $02
	ret

.CheckIfPlayerUsedProfessorOak:
	call SwapTurn
	ld de, PROFESSOR_OAK
	ld a, CARD_LOCATION_DISCARD_PILE
	farcall FindCardIDInLocation
	call SwapTurn
	ret

IsAIAaronStepScriptedTurn:
	ld a, [wOpponentDeckID]
	cp AARONS_STEP1_DECK_ID
	jr z, .step1
	cp AARONS_STEP2_DECK_ID
	jr z, .step2
	cp AARONS_STEP3_DECK_ID
	jr z, .step3
	scf
	ret
.step1
	ld a, [wDuelTurns]
	srl a
	cp 1
	ccf
	ret
.step2
	ld a, [wDuelTurns]
	srl a
	cp 2
	ccf
	ret
.step3
	ld a, [wDuelTurns]
	srl a
	cp 5
	ccf
	ret

AIDoTurn_GeneralNoPkmnPowers:
; initialize variables
	call InitAITurnVars
; process Trainer cards
; phase 1, 2, 4 and 5.
	ld a, AI_TRAINER_CARD_PHASE_01
	farcall AIProcessHandTrainerCards
	ld a, AI_TRAINER_CARD_PHASE_02
	farcall AIProcessHandTrainerCards
	ld a, AI_TRAINER_CARD_PHASE_04
	farcall AIProcessHandTrainerCards
	ld a, AI_TRAINER_CARD_PHASE_05
	farcall AIProcessHandTrainerCards
; play Pokemon from hand
	farcall AIDecidePlayPokemonCard
	ret c ; return if turn ended
; process Trainer cards
; phase 7 and 8
	ld a, AI_TRAINER_CARD_PHASE_07
	farcall AIProcessHandTrainerCards
	ld a, AI_TRAINER_CARD_PHASE_08
	farcall AIProcessHandTrainerCards

	call AIProcessRetreat

; process Trainer cards
; phase 10 and 11
	ld a, AI_TRAINER_CARD_PHASE_10
	farcall AIProcessHandTrainerCards
	ld a, AI_TRAINER_CARD_PHASE_11
	farcall AIProcessHandTrainerCards

	call AITryPlayEnergyCard
	farcall AIDecidePlayPokemonCard
	ret c ; return if turn ended
	call AITryPlayEnergyCard

; process Trainer cards
; phase 13 and 15
	ld a, AI_TRAINER_CARD_PHASE_13
	farcall AIProcessHandTrainerCards
	ld a, AI_TRAINER_CARD_PHASE_15
	farcall AIProcessHandTrainerCards
; if used Professor Oak, process new hand
; if not, then proceed to attack.
	ld a, [wPreviousAIFlags]
	and AI_FLAG_USED_PROFESSOR_OAK
	jr z, .try_attack
	ld a, AI_TRAINER_CARD_PHASE_01
	farcall AIProcessHandTrainerCards
	ld a, AI_TRAINER_CARD_PHASE_02
	farcall AIProcessHandTrainerCards
	ld a, AI_TRAINER_CARD_PHASE_04
	farcall AIProcessHandTrainerCards
	farcall AIDecidePlayPokemonCard
	ret c ; return if turn ended
	ld a, AI_TRAINER_CARD_PHASE_05
	farcall AIProcessHandTrainerCards
	ld a, AI_TRAINER_CARD_PHASE_07
	farcall AIProcessHandTrainerCards
	ld a, AI_TRAINER_CARD_PHASE_08
	farcall AIProcessHandTrainerCards
	call AIProcessRetreat
	ld a, AI_TRAINER_CARD_PHASE_10
	farcall AIProcessHandTrainerCards
	ld a, AI_TRAINER_CARD_PHASE_11
	farcall AIProcessHandTrainerCards
	call AITryPlayEnergyCard
	farcall AIDecidePlayPokemonCard
	ret c ; return if turn ended
	call AITryPlayEnergyCard
	ld a, AI_TRAINER_CARD_PHASE_13
	farcall AIProcessHandTrainerCards
	; skip AI_TRAINER_CARD_PHASE_15

.try_attack
	ld a, AI_ENERGY_TRANS_TO_BENCH
	farcall HandleAIEnergyTrans
	farcall AIProcessAndTryToUseAttack
	ret c ; return if turn ended
	ld a, OPPACTION_FINISH_NO_ATTACK
	farcall AIMakeDecision
	ret

AITryPlayEnergyCard:
	ld a, [wAlreadyPlayedEnergy]
	or a
	ret nz
	farcall AIProcessAndTryToPlayEnergy
	ret

; handle AI routines for a whole turn
AIMainTurnLogic:
; initialize variables
	call InitAITurnVars
	ld a, AI_TRAINER_CARD_PHASE_01
	farcall AIProcessHandTrainerCards
	ret c
	farcall HandleAIAntiMewtwoDeckStrategy
	jp nc, .try_attack
; handle Pkmn Powers
	farcall HandleAIRainDanceEnergy
	farcall HandleAIDamageSwap
	farcall HandleAIPkmnPowers
	ret c ; return if turn ended
	farcall HandleAICowardice
	call HandleAIDarkPokemonSearchStrategies
; process Trainer cards
; phase 2 through 4.
	ld a, AI_TRAINER_CARD_PHASE_02
	farcall AIProcessHandTrainerCards
	ld a, AI_TRAINER_CARD_PHASE_03
	farcall AIProcessHandTrainerCards
	ld a, AI_TRAINER_CARD_PHASE_04
	farcall AIProcessHandTrainerCards
; play Pokemon from hand
	farcall AIDecidePlayPokemonCard
	ret c ; return if turn ended

	farcall HandleAIMagnet
	farcall HandleAIDamageSwap
	farcall HandleAICowardice

; process Trainer cards
; phase 5 through 8.
	ld a, AI_TRAINER_CARD_PHASE_05
	farcall AIProcessHandTrainerCards
	ld a, AI_TRAINER_CARD_PHASE_06
	farcall AIProcessHandTrainerCards
	ld a, AI_TRAINER_CARD_PHASE_07
	farcall AIProcessHandTrainerCards
	ld a, AI_TRAINER_CARD_PHASE_08
	farcall AIProcessHandTrainerCards

	call AIProcessRetreat
	farcall HandleAIRebirth

; process Trainer cards
; phase 10 through 12.
	ld a, AI_TRAINER_CARD_PHASE_10
	farcall AIProcessHandTrainerCards
	ld a, AI_TRAINER_CARD_PHASE_11
	farcall AIProcessHandTrainerCards
	ld a, AI_TRAINER_CARD_PHASE_12
	farcall AIProcessHandTrainerCards

	call AITryPlayEnergyCard
	farcall AIDecidePlayPokemonCard
	ret c ; return if turn ended
	call AITryPlayEnergyCard
	farcall HandleAIMagnet
	farcall HandleAIPkmnPowers
	ret c ; return if turn ended
	farcall AIDecidePlayPokemonCard
	ret c ; return if turn ended
	call AITryPlayEnergyCard
	farcall HandleAIRainDanceEnergy
	ld a, AI_ENERGY_TRANS_ATTACK
	farcall HandleAIEnergyTrans
; process Trainer cards phases 13 and 15
	ld a, AI_TRAINER_CARD_PHASE_13
	farcall AIProcessHandTrainerCards
	ld a, AI_TRAINER_CARD_PHASE_15
	farcall AIProcessHandTrainerCards
; if used Professor Oak, process new hand
; if not, then proceed to attack.
	ld a, [wPreviousAIFlags]
	and AI_FLAG_USED_PROFESSOR_OAK
	jp z, .try_attack
	ld a, AI_TRAINER_CARD_PHASE_01
	farcall AIProcessHandTrainerCards
	ret c ; return if turn ended
	call HandleAIDarkPokemonSearchStrategies
	ld a, AI_TRAINER_CARD_PHASE_02
	farcall AIProcessHandTrainerCards
	ld a, AI_TRAINER_CARD_PHASE_03
	farcall AIProcessHandTrainerCards
	ld a, AI_TRAINER_CARD_PHASE_04
	farcall AIProcessHandTrainerCards
	farcall AIDecidePlayPokemonCard
	ret c ; return if turn ended
	ld a, AI_TRAINER_CARD_PHASE_05
	farcall AIProcessHandTrainerCards
	ld a, AI_TRAINER_CARD_PHASE_06
	farcall AIProcessHandTrainerCards
	ld a, AI_TRAINER_CARD_PHASE_07
	farcall AIProcessHandTrainerCards
	ld a, AI_TRAINER_CARD_PHASE_08
	farcall AIProcessHandTrainerCards
	call AIProcessRetreat
	farcall HandleAIRebirth
	ld a, AI_TRAINER_CARD_PHASE_10
	farcall AIProcessHandTrainerCards
	ld a, AI_TRAINER_CARD_PHASE_11
	farcall AIProcessHandTrainerCards
	ld a, AI_TRAINER_CARD_PHASE_12
	farcall AIProcessHandTrainerCards
	call AITryPlayEnergyCard
	farcall AIDecidePlayPokemonCard
	ret c ; return if turn ended
	call AITryPlayEnergyCard
	farcall HandleAIDamageSwap
	farcall HandleAIPkmnPowers
	ret c ; return if turn ended
	farcall AIDecidePlayPokemonCard
	ret c ; return if turn ended
	call AITryPlayEnergyCard
	farcall HandleAIRainDanceEnergy
	farcall HandleAICowardice
	ld a, AI_ENERGY_TRANS_ATTACK
	farcall HandleAIEnergyTrans
	ld a, AI_TRAINER_CARD_PHASE_13
	farcall AIProcessHandTrainerCards
	; skip AI_TRAINER_CARD_PHASE_15

.try_attack
	ld a, AI_ENERGY_TRANS_TO_BENCH
	farcall HandleAIEnergyTrans

	farcall HandleAITrickery
	farcall HandleAIPrehistoricDreamAndPoisonMist

	ld a, AI_TRAINER_CARD_PHASE_17
	farcall AIProcessHandTrainerCards
	ld a, [wd033]
	cp $02
	jr z, .finish_wo_attack
; attack if possible, if not,
; finish turn without attacking.
	farcall AIProcessAndTryToUseAttack
	ret c ; return if AI attacked
.finish_wo_attack
	ld a, OPPACTION_FINISH_NO_ATTACK
	farcall AIMakeDecision
	ret

; handles AI retreating logic
AIProcessRetreat:
	ld a, [wAIRetreatedThisTurn]
	or a
	ret nz ; return, already retreated this turn

	farcall AIDecideBenchPokemonToSwitchTo
	ret c ; return if no Bench Pokemon

; store Play Area to retreat to
	ld [wAIPlayAreaCardToSwitch], a

; if AI can use Switch from hand, use it instead...
	ld a, AI_TRAINER_CARD_PHASE_16
	farcall AIProcessHandTrainerCards

	ld a, [wPreviousAIFlags]
	and AI_FLAG_UNK_5
	jr nz, .asm_48632
	ld a, [wPreviousAIFlags]
	and AI_FLAG_USED_SWITCH
	jr nz, .asm_4865c

.asm_48632
	bank1call CheckUnableToRetreatDueToEffect
	ret c ; unable to retreat
	farcall AIDecideWhetherToRetreat_ConsiderStatus
	ret nc
	ld a, TRUE
	ld [wAIRetreatedThisTurn], a
	ld a, [wPreviousAIFlags]
	and AI_FLAG_UNK_5
	jr nz, .asm_48670
	ld a, AI_TRAINER_CARD_PHASE_09
	farcall AIProcessHandTrainerCards
	ld a, [wPreviousAIFlags]
	and AI_FLAG_USED_SWITCH
	jr nz, .used_switch
	ld a, [wAIPlayAreaCardToSwitch]
	farcall Func_167e5
	ret

.asm_4865c
	ld a, TRUE
	ld [wAIRetreatedThisTurn], a
.used_switch
; if AI used switch, unset its AI flag
	ld a, [wPreviousAIFlags]
	and ~AI_FLAG_USED_SWITCH ; clear Switch flag
	ld [wPreviousAIFlags], a

	ld a, AI_ENERGY_TRANS_RETREAT
	farcall HandleAIEnergyTrans
	ret

.asm_48670
	farcall AIDecideBenchPokemonToSwitchTo
	ret c ; no Bench Pokémon
	farcall Func_167e5
	ret

AIDoTurn_GeneralNoRetreat:
; initialize variables
	call InitAITurnVars
	ld a, AI_TRAINER_CARD_PHASE_01
	farcall AIProcessHandTrainerCards
	ret c ; return if turn ended
	farcall HandleAIAntiMewtwoDeckStrategy
	jp nc, .try_attack
; handle Pkmn Powers
	farcall HandleAIRainDanceEnergy
	farcall HandleAIDamageSwap
	farcall HandleAIPkmnPowers
	ret c ; return if turn ended
	farcall HandleAICowardice
	call HandleAIDarkPokemonSearchStrategies
; process Trainer cards
; phase 2 through 4.
	ld a, AI_TRAINER_CARD_PHASE_02
	farcall AIProcessHandTrainerCards
	ld a, AI_TRAINER_CARD_PHASE_03
	farcall AIProcessHandTrainerCards
	ld a, AI_TRAINER_CARD_PHASE_04
	farcall AIProcessHandTrainerCards
; play Pokemon from hand
	farcall AIDecidePlayPokemonCard
	ret c ; return if turn ended

	farcall HandleAIMagnet
	farcall HandleAIDamageSwap
	farcall HandleAICowardice

; process Trainer cards
; phase 5 through 12.
	ld a, AI_TRAINER_CARD_PHASE_05
	farcall AIProcessHandTrainerCards
	ld a, AI_TRAINER_CARD_PHASE_06
	farcall AIProcessHandTrainerCards
	ld a, AI_TRAINER_CARD_PHASE_07
	farcall AIProcessHandTrainerCards
	ld a, AI_TRAINER_CARD_PHASE_08
	farcall AIProcessHandTrainerCards
	ld a, AI_TRAINER_CARD_PHASE_10
	farcall AIProcessHandTrainerCards
	ld a, AI_TRAINER_CARD_PHASE_11
	farcall AIProcessHandTrainerCards
	ld a, AI_TRAINER_CARD_PHASE_12
	farcall AIProcessHandTrainerCards

	call AITryPlayEnergyCard
	farcall AIDecidePlayPokemonCard
	ret c ; return if turn ended
	call AITryPlayEnergyCard
	farcall HandleAIMagnet
	farcall HandleAIPkmnPowers
	ret c ; return if turn ended
	farcall AIDecidePlayPokemonCard
	ret c ; return if turn ended
	call AITryPlayEnergyCard
	farcall HandleAIRainDanceEnergy
	ld a, AI_ENERGY_TRANS_ATTACK
	farcall HandleAIEnergyTrans
; process Trainer cards phases 13 and 15
	ld a, AI_TRAINER_CARD_PHASE_13
	farcall AIProcessHandTrainerCards
	ld a, AI_TRAINER_CARD_PHASE_15
	farcall AIProcessHandTrainerCards
; if used Professor Oak, process new hand
; if not, then proceed to attack.
	ld a, [wPreviousAIFlags]
	and AI_FLAG_USED_PROFESSOR_OAK
	jr z, .try_attack
	ld a, AI_TRAINER_CARD_PHASE_01
	farcall AIProcessHandTrainerCards
	ret c ; return if turn ended
	call HandleAIDarkPokemonSearchStrategies
	ld a, AI_TRAINER_CARD_PHASE_02
	farcall AIProcessHandTrainerCards
	ld a, AI_TRAINER_CARD_PHASE_03
	farcall AIProcessHandTrainerCards
	ld a, AI_TRAINER_CARD_PHASE_04
	farcall AIProcessHandTrainerCards
	farcall AIDecidePlayPokemonCard
	ret c ; return if turn ended
	ld a, AI_TRAINER_CARD_PHASE_05
	farcall AIProcessHandTrainerCards
	ld a, AI_TRAINER_CARD_PHASE_06
	farcall AIProcessHandTrainerCards
	ld a, AI_TRAINER_CARD_PHASE_07
	farcall AIProcessHandTrainerCards
	ld a, AI_TRAINER_CARD_PHASE_08
	farcall AIProcessHandTrainerCards
	ld a, AI_TRAINER_CARD_PHASE_10
	farcall AIProcessHandTrainerCards
	ld a, AI_TRAINER_CARD_PHASE_11
	farcall AIProcessHandTrainerCards
	ld a, AI_TRAINER_CARD_PHASE_12
	farcall AIProcessHandTrainerCards
	call AITryPlayEnergyCard
	farcall AIDecidePlayPokemonCard
	ret c ; return if turn ended
	call AITryPlayEnergyCard
	farcall HandleAIDamageSwap
	farcall HandleAIPkmnPowers
	ret c ; return if turn ended
	farcall AIDecidePlayPokemonCard
	ret c ; return if turn ended
	call AITryPlayEnergyCard
	farcall HandleAIRainDanceEnergy
	farcall HandleAICowardice
	ld a, AI_ENERGY_TRANS_ATTACK
	farcall HandleAIEnergyTrans
	ld a, AI_TRAINER_CARD_PHASE_13
	farcall AIProcessHandTrainerCards
	; skip AI_TRAINER_CARD_PHASE_15

.try_attack
	ld a, AI_ENERGY_TRANS_TO_BENCH
	farcall HandleAIEnergyTrans

	farcall HandleAITrickery
	farcall HandleAIPrehistoricDreamAndPoisonMist

	ld a, AI_TRAINER_CARD_PHASE_17
	farcall AIProcessHandTrainerCards
	ld a, [wd033]
	cp $02
	jr z, .finish_wo_attack
; attack if possible, if not,
; finish turn without attacking.
	farcall AIProcessAndTryToUseAttack
	ret c ; return if turn ended
.finish_wo_attack
	ld a, OPPACTION_FINISH_NO_ATTACK
	farcall AIMakeDecision
	ret
; 0x487c7

SECTION "Bank 12@4856", ROMX[$4856], BANK[$12]

AIDeckSpecificEnergyLogic:
	ldh a, [hTempPlayAreaLocation_ff9d]
	push af
	ld a, [wOpponentDeckID]
	cp PHANTOM_DECK_ID
	jp z, .PhantomDeck
	cp AWESOME_FOSSIL_DECK_ID
	jp z, .AwesomeFossilDeck
	cp MAX_ENERGY_DECK_ID
	jp z, .MaxEnergyDeck
	cp GLITTERING_SCALES_DECK_ID
	jp z, .GlitteringScalesDeck
	cp DARK_SCIENCE_DECK_ID
	jp z, .DarkScienceDeck
	cp IMMORTAL_FLAME_DECK_ID
	jp z, .ImmortalFlameDeck
	cp GREAT_ROCKET3_DECK_ID
	jp z, .GreatRocket3Deck
	cp GREAT_DRAGON_DECK_ID
	jp z, .GreatDragonDeck
	cp MAD_PETALS_DECK_ID
	jp z, .MadPetalsDeck
	cp COMPLETE_COMBUSTION_DECK_ID
	jp z, .CompleteCombustionDeck
	cp RUNNING_WILD_DECK_ID
	jp z, .RunningWildDeck
	cp DIRECT_HIT_DECK_ID
	jp z, .DirectHitDeck
	cp BAD_DREAM_DECK_ID
	jp z, .BadDreamDeck
	cp SPIRITED_AWAY_DECK_ID
	jp z, .SpiritedAwayDeck
	cp ULTRA_REMOVAL_DECK_ID
	jp z, .UltraRemovalDeck
	cp STOP_LIFE_DECK_ID
	jp z, .StopLifeDeck
	cp SCORCHER_DECK_ID
	jp z, .ScorcherDeck
	cp TSUNAMI_STARTER_DECK_ID
	jp z, .TsunamiStarterDeck
	cp SMASH_TO_MINCEMEAT_DECK_ID
	jp z, .SmashToMincemeatDeck
	cp TEST_YOUR_LUCK_DECK_ID
	jp z, .TestYourLuckDeck
	cp POWERFUL_POKEMON_DECK_ID
	jp z, .PowerfulPokemonDeck
	cp RONALDS_UNCOOL_DECK_ID
	jp z, .RonaldsUncoolDeck
	cp RONALDS_POWER_DECK_ID
	jp z, .RonaldsPowerDeck
	cp RONALDS_PSYCHIC_DECK_ID
	jp z, .RonaldsPsychicDeck
	cp EVERYBODYS_FRIEND_DECK_ID
	jp z, .EverybodysFriendDeck
	cp IMMORTAL_POKEMON_DECK_ID
	jp z, .ImmortalPokemonDeck
	cp BLAZING_FLAME_DECK_ID
	jp z, .BlazingFlameDeck
	cp BIG_THUNDER_DECK_ID
	jp z, .BigThunderDeck
	cp POWER_OF_DARKNESS_DECK_ID
	jp z, .PowerOfDarknessDeck
	cp POISON_STORM_DECK_ID
	jp z, .PoisonStormDeck

.default_score
	ld b, $80
.got_score
	pop af
	ldh [hTempPlayAreaLocation_ff9d], a
	ld a, b
	ret

.PhantomDeck:
	ldh a, [hTempPlayAreaLocation_ff9d]
	add DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call GetCardIDFromDeckIndex
	cp16 WIGGLYTUFF_LV36
	jr nz, .default_score
	; is Wigglytuff
	xor a
	ld e, a
	call GetPlayAreaCardAttachedEnergies
	ld a, [wTotalAttachedEnergies]
	or a
	jr z, .default_score
	; has energy cards
	ld b, $7b
	jr .got_score

.AwesomeFossilDeck:
	ldh a, [hTempPlayAreaLocation_ff9d]
	add DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call GetCardIDFromDeckIndex
	cp16 KANGASKHAN_LV40
	jr z, .kangaskhan_lv40_awesome_fossil
	cp16 SNORLAX_LV20
	jr nz, .default_score

; snorlax lv20
	ld b, $82
	jr .got_score

.kangaskhan_lv40_awesome_fossil
	farcall Func_4c605
	jr c, .asm_48958
	ld e, PLAY_AREA_ARENA
	call GetPlayAreaCardAttachedEnergies
	ld a, [wTotalAttachedEnergies]
	or a
	jr z, .asm_48958
	farcall CountNumberOfSetUpBenchPokemon
	cp 2
	jp c, .asm_4895d ; can be jr
	; at least 2 set up bench Pokémon
	xor a
	ld [wd032], a
.asm_48958
	ld b, $85
	jp .got_score

.asm_4895d
	ld b, $6c
	jp .got_score

.MaxEnergyDeck:
.GreatRocket3Deck:
	ldh a, [hTempPlayAreaLocation_ff9d]
	or a
	jr nz, .default_score
	add DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call GetCardIDFromDeckIndex
	cp16 EXEGGUTOR
	jp nz, .default_score
	ld b, $8a
	jp .got_score

.GlitteringScalesDeck:
	ldh a, [hTempPlayAreaLocation_ff9d]
	add DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call GetCardIDFromDeckIndex
	cp16 KANGASKHAN_LV40
	jr z, .kangaskhan_lv40_glittering_scales
	cp16 CHANSEY_LV55
	jp nz, .default_score

; chansey lv55
	ldh a, [hTempPlayAreaLocation_ff9d]
	ld e, a
	call GetPlayAreaCardAttachedEnergies
	ld a, [wTotalAttachedEnergies]
	or a
	jr z, .asm_489bc ; has no energy cards
	ldh a, [hTempPlayAreaLocation_ff9d]
	or a
	jr nz, .asm_489c1
	; is Arena card
	ld de, VENOMOTH_LV28
	call CheckIfPokemonInBenchHasEnoughEnergy
	jr c, .asm_489bc
	ld de, IVYSAUR_LV26
	call CheckIfPokemonInBenchHasEnoughEnergy
	jp nc, .asm_489c1 ; can be jr
	; Venomoth and Ivysaur can already use
	; all their attacks
.asm_489bc
	ld b, $85
	jp .got_score

.asm_489c1
	ld b, $64
	jp .got_score

.kangaskhan_lv40_glittering_scales
	farcall Func_4c605
	jr c, .asm_489bc
	ldh a, [hTempPlayAreaLocation_ff9d]
	ld e, a
	call GetPlayAreaCardAttachedEnergies
	ld a, [wTotalAttachedEnergies]
	or a
	jr z, .asm_489bc
	; at least 1 energy card
	ldh a, [hTempPlayAreaLocation_ff9d]
	or a
	jr nz, .asm_489c1
	; is Arena card
	ld de, VENOMOTH_LV28
	call CheckIfPokemonInBenchHasEnoughEnergy
	jr nc, .asm_489c1 ; Venomoth still needs energy
	farcall CountNumberOfSetUpBenchPokemon
	cp 2
	jr c, .asm_489c1
	; at least 2 set up bench Pokémon
	xor a
	ld [wd032], a
	jr .asm_489bc

.DarkScienceDeck:
	ldh a, [hTempPlayAreaLocation_ff9d]
	or a
	jp nz, .default_score
	add DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call GetCardIDFromDeckIndex
	cp16 CHANSEY_LV55
	jp nz, .default_score

; chansey lv55
	ld de, WEEZING_LV26
	call CheckIfPokemonInBenchHasEnoughEnergy
	jp nc, .default_score ; Weezing still needs energy
	farcall CountNumberOfSetUpBenchPokemon
	cp 2
	jp c, .default_score
	; at least 2 set up bench Pokémon
	ld b, $99
	jp .got_score

.ImmortalFlameDeck:
	ldh a, [hTempPlayAreaLocation_ff9d]
	or a
	jp nz, .default_score
	; Arena card
	add DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call GetCardIDFromDeckIndex
	cp16 KANGASKHAN_LV40
	jp nz, .default_score

; kangaskhan lv40
	farcall Func_4c605
	jr c, .asm_48a56
	ld e, PLAY_AREA_ARENA
	call GetPlayAreaCardAttachedEnergies
	ld a, [wTotalAttachedEnergies]
	or a
	jr z, .asm_48a56 ; no energy cards
	ld de, ARCANINE_LV35
	call CheckIfPokemonInBenchHasEnoughEnergy
	jp nc, .asm_48a5b ; Arcanine still needs energy
	xor a
	ld [wd032], a
.asm_48a56
	ld b, $8d
	jp .got_score

.asm_48a5b
	ld b, $64
	jp .got_score

.GreatDragonDeck:
	ldh a, [hTempPlayAreaLocation_ff9d]
	or a
	jp nz, .default_score
	; Arena card
	add DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call GetCardIDFromDeckIndex
	cp16 KANGASKHAN_LV40
	jp nz, .default_score

; kangaskhan lv40
	farcall Func_4c605
	jr c, .asm_48a9d
	ld e, PLAY_AREA_ARENA
	call GetPlayAreaCardAttachedEnergies
	ld a, [wTotalAttachedEnergies]
	or a
	jr z, .asm_48a9d
	; at least 1 energy
	ld de, CHARIZARD_LV76
	call CheckIfPokemonInBenchHasEnoughEnergy
	jr c, .asm_48a9d
	ld de, CHARIZARD_ALT_LV76
	call CheckIfPokemonInBenchHasEnoughEnergy
	jp nc, .default_score
	; Charizard can already use all attacks
	xor a
	ld [wd032], a
.asm_48a9d
	ld b, $8d
	jp .got_score

.MadPetalsDeck:
	ldh a, [hTempPlayAreaLocation_ff9d]
	or a
	jp nz, .default_score
	add DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call GetCardIDFromDeckIndex
	cp16 KANGASKHAN_LV40
	jp nz, .default_score

; kangaskhan lv40
	farcall Func_4c605
	jr c, .asm_48adf
	ld e, PLAY_AREA_ARENA
	call GetPlayAreaCardAttachedEnergies
	ld a, [wTotalAttachedEnergies]
	or a
	jr z, .asm_48adf
	; at least 1 energy
	ld de, VILEPLUME
	call CheckIfPokemonInBenchHasEnoughEnergy
	jr c, .asm_48adf
	ld de, DARK_VILEPLUME
	call CheckIfPokemonInBenchHasEnoughEnergy
	jp c, .default_score
	; Vileplume can already use all attacks
	xor a
	ld [wd032], a
.asm_48adf
	ld b, $8d
	jp .got_score

.CompleteCombustionDeck:
.RonaldsPowerDeck:
.RonaldsPsychicDeck:
.PoisonStormDeck:
	ldh a, [hTempPlayAreaLocation_ff9d]
	or a
	jp nz, .default_score
	; Arena card
	add DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call GetCardIDFromDeckIndex
	cp16 KANGASKHAN_LV40
	jp nz, .default_score

; kangaskhan lv40
	farcall Func_4c605
	jr c, .asm_48b18
	ld e, PLAY_AREA_ARENA
	call GetPlayAreaCardAttachedEnergies
	ld a, [wTotalAttachedEnergies]
	or a
	jr z, .asm_48b18
	farcall CountNumberOfSetUpBenchPokemon
	cp 2
	jr c, .asm_48b1d
	xor a
	ld [wd032], a
.asm_48b18
	ld b, $8d
	jp .got_score
.asm_48b1d
	ld b, $78
	jp .got_score

.RunningWildDeck:
	ldh a, [hTempPlayAreaLocation_ff9d]
	or a
	jp nz, .default_score
	; Arena card
	add DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call GetCardIDFromDeckIndex
	cp16 KANGASKHAN_LV40
	jp nz, .default_score

; kangaskhan lv40
	farcall Func_4c605
	jr c, .asm_48b57
	ld e, PLAY_AREA_ARENA
	call GetPlayAreaCardAttachedEnergies
	ld a, [wTotalAttachedEnergies]
	or a
	jr z, .asm_48b57
	ld de, DARK_MAROWAK
	call CheckIfPokemonInBenchHasEnoughEnergy
	jp nc, .default_score
	xor a
	ld [wd032], a
.asm_48b57
	ld b, $8d
	jp .got_score

.DirectHitDeck:
	ldh a, [hTempPlayAreaLocation_ff9d]
	or a
	jp nz, .default_score
	; Arena card
	add DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call GetCardIDFromDeckIndex
	cp16 KANGASKHAN_LV40
	jr z, .kangaskhan_lv40_or_psyduck_lv16
	cp16 PSYDUCK_LV16
	jp nz, .default_score

.kangaskhan_lv40_or_psyduck_lv16
	farcall Func_4c605
	jr c, .asm_48b9a
	ld e, PLAY_AREA_ARENA
	call GetPlayAreaCardAttachedEnergies
	ld a, [wTotalAttachedEnergies]
	or a
	jr z, .asm_48b9a
	farcall CountNumberOfSetUpBenchPokemon
	cp 2
	jr c, .asm_48b9f
	xor a
	ld [wd032], a
.asm_48b9a
	ld b, $8d
	jp .got_score
.asm_48b9f
	ld b, $78
	jp .got_score

.BadDreamDeck:
	jp .default_score

; unreachable
	ldh a, [hTempPlayAreaLocation_ff9d]
	or a
	jp nz, .default_score
	add DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call GetCardIDFromDeckIndex
	cp16 KANGASKHAN_LV40
	jp nz, .default_score
	xor a
	ld e, a
	call GetPlayAreaCardAttachedEnergies
	ld a, [wTotalAttachedEnergies]
	or a
	jr z, .asm_48be0
	ld de, HAUNTER_LV22
	call CheckIfPokemonInBenchHasEnoughEnergy
	jr nc, .asm_48be5
	ld b, PLAY_AREA_BENCH_1
	ld de, DROWZEE_LV10
	farcall FindCardIDInTurnDuelistsPlayArea
	jr nc, .asm_48be5
	xor a
	ld [wd032], a
.asm_48be0
	ld b, $8d
	jp .got_score
.asm_48be5
	ld b, $78
	jp .got_score

.SpiritedAwayDeck:
	ldh a, [hTempPlayAreaLocation_ff9d]
	or a
	jp nz, .default_score
	add DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call GetCardIDFromDeckIndex
	cp16 KANGASKHAN_LV40
	jp nz, .default_score
	farcall Func_4c605
	jr c, .asm_48c1f
	ld e, PLAY_AREA_ARENA
	call GetPlayAreaCardAttachedEnergies
	ld a, [wTotalAttachedEnergies]
	or a
	jr z, .asm_48c1f
	ld de, DARK_HAUNTER
	call CheckIfPokemonInBenchHasEnoughEnergy
	jp nc, .default_score
	xor a
	ld [wd032], a
.asm_48c1f
	ld b, $8d
	jp .got_score

.UltraRemovalDeck:
	farcall CheckIfHasRainDanceActive
	jp nc, .default_score
	ldh a, [hTempPlayAreaLocation_ff9d]
	or a
	jp z, .default_score
	; Rain Dance is active and this
	; card is not Arena card
	ld b, $4e
	jp .got_score

.StopLifeDeck:
	ldh a, [hTempPlayAreaLocation_ff9d]
	or a
	jp nz, .default_score
	add DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call GetCardIDFromDeckIndex
	cp16 DARK_DRAGONAIR
	jr z, .dark_dragonair

; kangaskhan lv40
	cp16 KANGASKHAN_LV40
	jp nz, .default_score
	farcall Func_4c605
	jr c, .asm_48c75
	ld e, PLAY_AREA_ARENA
	call GetPlayAreaCardAttachedEnergies
	ld a, [wTotalAttachedEnergies]
	or a
	jr z, .asm_48c75
	ld de, DARK_VENUSAUR
	call CheckIfPokemonInBenchHasEnoughEnergy
	jp nc, .default_score
	xor a
	ld [wd032], a
.asm_48c75
	ld b, $8d
	jp .got_score

.dark_dragonair
	ld b, $83
	jp .got_score

.ScorcherDeck:
	ldh a, [hTempPlayAreaLocation_ff9d]
	add DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call GetCardIDFromDeckIndex
	cp16 KANGASKHAN_LV40
	jr z, .kangaskhan_lv40_scorcher
	cp16 DARK_CHARIZARD
	jr z, .dark_charizard
	jp .default_score

.kangaskhan_lv40_scorcher
	ldh a, [hTempPlayAreaLocation_ff9d]
	or a
	jp nz, .default_score
	ld e, a
	call GetPlayAreaCardAttachedEnergies
	ld a, [wTotalAttachedEnergies]
	or a
	jr z, .asm_48cc1
	farcall Func_4c605
	jr c, .asm_48cc1
	ld de, DARK_CHARIZARD
	call CheckIfPokemonInBenchHasEnoughEnergy
	jp nc, .default_score
	xor a
	ld [wd032], a
.asm_48cc1
	ld b, $8d
	jp .got_score

.dark_charizard
	call FindDarkCharizardToAttachEnergy
	jp nc, .default_score
	ld b, a
	ldh a, [hTempPlayAreaLocation_ff9d]
	cp b
	jr z, .asm_48cd7
	ld b, $64
	jp .got_score
.asm_48cd7
	ld b, $83
	jp .got_score

.TsunamiStarterDeck:
	ldh a, [hTempPlayAreaLocation_ff9d]
	add DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call GetCardIDFromDeckIndex
	cp16 SCYTHER_LV25
	jp nz, .default_score
	ld a, TYPE_PKMN_LIGHTNING
	farcall CheckIfPlayerHasPokemonOfType
	jp nc, .default_score
	ld b, $8d
	jp .got_score

.SmashToMincemeatDeck:
	ldh a, [hTempPlayAreaLocation_ff9d]
	add DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call GetCardIDFromDeckIndex
	cp16 CHANSEY_LV55
	jr z, .chansey_lv55
	cp16 KANGASKHAN_LV40
	jp nz, .default_score

; kangaskhan lv40
	ldh a, [hTempPlayAreaLocation_ff9d]
	or a
	jp nz, .default_score
	farcall Func_4c605
	jr c, .asm_48d3e
	ld e, PLAY_AREA_ARENA
	call GetPlayAreaCardAttachedEnergies
	ld a, [wTotalAttachedEnergies]
	or a
	jr z, .asm_48d3e
	ld de, DARK_MACHAMP
	call CheckIfPokemonInBenchHasEnoughEnergy
	jp nc, .default_score
	xor a
	ld [wd032], a
.asm_48d3e
	ld b, $8d
	jp .got_score

.chansey_lv55
	ldh a, [hTempPlayAreaLocation_ff9d]
	ld e, a
	ld de, DARK_MACHAMP
	call CheckIfPokemonInBenchHasEnoughEnergy
	jp nc, .default_score
	farcall CountNumberOfSetUpBenchPokemon
	cp 2
	jp c, .default_score
	ld b, $84
	jp .got_score

.TestYourLuckDeck:
	ldh a, [hTempPlayAreaLocation_ff9d]
	add DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call GetCardIDFromDeckIndex
	cp16 MOLTRES_LV35
	jp nz, .default_score
	ld b, $85
	jp .got_score

.PowerfulPokemonDeck:
	ldh a, [hTempPlayAreaLocation_ff9d]
	or a
	jp nz, .default_score
	add DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call GetCardIDFromDeckIndex
	cp16 ELECTABUZZ_LV35
	jp z, .electabuzz_lv35 ; can be jr
	cp16 HITMONCHAN_LV33
	jp z, .hitmonchan_lv33 ; can be jr
	cp16 JYNX_LV27
	jp nz, .default_score

; jynx lv27
	ld de, PSYCHIC_ENERGY
	jr .asm_48db1

.electabuzz_lv35
	ld de, LIGHTNING_ENERGY
	jr .asm_48db1

.hitmonchan_lv33
	ld de, FIGHTING_ENERGY
	jr .asm_48db1 ; useless jump

.asm_48db1
	farcall LookForCardIDInHandList
	jp c, .default_score
	ldh a, [hTempPlayAreaLocation_ff9d]
	add DUELVARS_ARENA_CARD_HP
	get_turn_duelist_var
	cp 40
	jr c, .asm_48dcb
	ld de, RAINBOW_ENERGY
	farcall LookForCardIDInHandList
	jp c, .default_score
.asm_48dcb
	ld a, $64
	jp .got_score

.RonaldsUncoolDeck:
	ldh a, [hTempPlayAreaLocation_ff9d]
	or a
	jp nz, .default_score
	add DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call GetCardIDFromDeckIndex
	cp16 CHANSEY_LV55
	jp nz, .default_score

; chansey lv55
	xor a
	ld e, a
	call GetPlayAreaCardAttachedEnergies
	ld a, [wTotalAttachedEnergies]
	cp 2
	jr c, .asm_48e00
	farcall CountNumberOfSetUpBenchPokemon
	cp 2
	jr nc, .asm_48e00
	ld b, $64
	jp .got_score
.asm_48e00
	ld b, $8d
	jp .got_score

.EverybodysFriendDeck:
	ldh a, [hTempPlayAreaLocation_ff9d]
	or a
	jp nz, .default_score
	add DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call GetCardIDFromDeckIndex
	cp16 WIGGLYTUFF_LV36
	jp nz, .default_score

; wigglytuff lv36
	ld a, SECOND_ATTACK
	ld [wSelectedAttack], a
	farcall CheckIfSelectedAttackIsUnusable
	jp nc, .default_score
	ld b, $83
	jp .got_score

.ImmortalPokemonDeck:
	ldh a, [hTempPlayAreaLocation_ff9d]
	add DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call GetCardIDFromDeckIndex
	cp16 SCYTHER_LV25
	jp nz, .default_score

; scyther lv25
	farcall CountEnergyCardsInHand
	cp 3
	jp c, .default_score
	ld b, $85
	jp .got_score

.BlazingFlameDeck:
	ldh a, [hTempPlayAreaLocation_ff9d]
	or a
	jp nz, .default_score
	add DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call GetCardIDFromDeckIndex
	cp16 MAGMAR_LV31
	jp nz, .default_score

; magmar lv31
	xor a
	ld e, a
	call GetPlayAreaCardAttachedEnergies
	ld a, [wTotalAttachedEnergies]
	or a
	jp nz, .default_score
	ld b, $8d
	jp .got_score

.BigThunderDeck:
	ldh a, [hTempPlayAreaLocation_ff9d]
	add DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call GetCardIDFromDeckIndex
	cp16 DITTO
	jr z, .ditto
	cp16 CHANSEY_LV55
	jp nz, .default_score

; chansey lv55
	call CheckIfHasDittoWithLessThan3Energies
	jr c, .asm_48ea2
.ditto
	call CheckIfHasZapdosLv68WithLessThan3Energies
	jr c, .asm_48ea2
	ld b, $8d
	jp .got_score
.asm_48ea2
	ld b, $64
	jp .got_score

.PowerOfDarknessDeck:
	ldh a, [hTempPlayAreaLocation_ff9d]
	or a
	jp nz, .default_score
	add DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call GetCardIDFromDeckIndex
	cp16 KANGASKHAN_LV40
	jr z, .kangaskhan_lv40_power_of_darkness
	cp16 GRS_MEWTWO
	jr z, .asm_48ee7
	jp .default_score

.kangaskhan_lv40_power_of_darkness
	farcall Func_4c605
	jr c, .asm_48ee7
	ld e, PLAY_AREA_ARENA
	call GetPlayAreaCardAttachedEnergies
	ld a, [wTotalAttachedEnergies]
	or a
	jr z, .asm_48ee7
	farcall CountNumberOfSetUpBenchPokemon
	cp 2
	jr c, .asm_48eec
	xor a
	ld [wd032], a
.asm_48ee7
	ld b, $8d
	jp .got_score
.asm_48eec
	ld b, $78
	jp .got_score

AIDeckSpecificRetreatLogic:
	ld a, [wOpponentDeckID]
	cp STEADY_INCREASE_DECK_ID
	jr z, .SteadyIncreaseDeck
	cp GREAT_DRAGON_DECK_ID
	jr z, .GreatDragonDeck
	cp SPIRITED_AWAY_DECK_ID
	jr z, .SpiritedAwayDeck
	cp PSYCHIC_BATTLE_DECK_ID
	jr z, .PsychicBattleDeck
	cp STOP_LIFE_DECK_ID
	jr z, .StopLifeDeck
	cp SCORCHER_DECK_ID
	jr z, .ScorcherDeck
	cp SMASH_TO_MINCEMEAT_DECK_ID
	jr z, .SmashToMincemeatDeck
	cp IMMORTAL_POKEMON_DECK_ID
	jp z, .ImmortalPokemonDeck
	cp BIG_THUNDER_DECK_ID
	jp z, .BigThunderDeck

.default
	ld a, $80
	ret

.SteadyIncreaseDeck:
	xor a ; PLAY_AREA_ARENA
	ldh [hTempPlayAreaLocation_ff9d], a
	farcall CheckIfDefendingPokemonCanKnockOut
	jr nc, .default
	; can KO defending card
	ld a, $83
	ret

.GreatDragonDeck
	ld a, [wPreviousAIFlags]
	and AI_FLAG_UNK_5
	jr z, .default
	ld a, $8a
	ret

.SpiritedAwayDeck:
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call GetCardIDFromDeckIndex
	cp16 SLOWPOKE_LV16
	jr nz, .default

; Arena card is Slowpoke lv16
	ld e, PLAY_AREA_ARENA
	call GetPlayAreaCardAttachedEnergies
	ld a, [wAttachedEnergies + PSYCHIC]
	cp 8
	jr nc, .at_least_8_psychic_energy_cards
	ld a, $46
	ret
.at_least_8_psychic_energy_cards
	ld a, $8a
	ret

.PsychicBattleDeck:
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call GetCardIDFromDeckIndex
	cp16 MR_MIME_LV28
	jr nz, .default

; Arena card is Mr. Mime lv28
	call SwapTurn
	xor a
	call CheckIfPokemonHasDamage
	jr c, .asm_48f7b ; defending card has damage
	xor a ; PLAY_AREA_ARENA
	farcall CheckIfCanDamageDefendingPokemon
	jr nc, .asm_48f7b ; can't damage Mr. Mime
	farcall CheckIfPokemonCanUseNonResidualAttack
	jr c, .asm_48f81 ; can use non-Residual
.asm_48f7b
	call SwapTurn
	ld a, $80
	ret
.asm_48f81
	call SwapTurn
	ld a, $8a
	ret

.StopLifeDeck:
.ScorcherDeck:
.SmashToMincemeatDeck:
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call GetCardIDFromDeckIndex
	cp16 KANGASKHAN_LV40
	jr nz, .default
; Arena card is Kangaskhan
	ld a, $46
	ret

.ImmortalPokemonDeck:
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call GetCardIDFromDeckIndex
	cp16 MR_MIME_LV28
	jr z, .mr_mime_lv28
	cp16 KADABRA_LV39
	jr z, .kadabra_lv39
	cp16 ABRA_LV14
	jp nz, .default

; abra lv14
	xor a ; PLAY_AREA_ARENA
	ldh [hTempPlayAreaLocation_ff9d], a
	farcall CheckIfDefendingPokemonCanKnockOut
	jp nc, .default
	; Abra can be KO'ed
	ld a, $8a
	ret

.kadabra_lv39
	ld de, ALAKAZAM_LV42
	ld b, PLAY_AREA_BENCH_1
	farcall FindCardIDInTurnDuelistsPlayArea
	jp c, .default
	; Alakazam is not in Bench
	ld a, $8a
	ret

.mr_mime_lv28
	ld a, DUELVARS_ARENA_CARD_HP
	get_turn_duelist_var
	cp 20 + 1
	jp nc, .default
	; Mr. Mime has <= 20 HP remaining
	ld a, $8a
	ret

.BigThunderDeck:
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call GetCardIDFromDeckIndex
	cp16 ZAPDOS_LV68
	jp z, .default
	ld de, ZAPDOS_LV68
	call CheckIfPokemonInBenchHasEnoughEnergy
	jp nc, .default
	; another Zapdos in Bench has enough energy cards
	ld a, $8a
	ret

; some Decks rely on using The Boss' Way and
; Dark Dragonair's Evolutionary Light together
; with Pokémon Trader to search cards in the deck
HandleAIDarkPokemonSearchStrategies:
	bank1call CheckCantUseTrainerDueToEffect
	ret c ; cannot use Trainer cards

	ld a, [wOpponentDeckID]
	cp STOP_LIFE_DECK_ID
	jr z, .StopLifeDeck
	cp SCORCHER_DECK_ID
	jp z, .ScorcherDeck
	cp TSUNAMI_STARTER_DECK_ID
	jp z, .TsunamiStarterDeck
	cp SMASH_TO_MINCEMEAT_DECK_ID
	jp z, .SmashToMincemeatDeck
	cp POWER_OF_DARKNESS_DECK_ID
	jp z, .PowerOfDarknessDeck
	ret

.StopLifeDeck:
	; if player has a Fire-type Pokémon, then
	; check if there's a Pokémon Trader in hand
	; and a Mr. Mime lv20 in deck to search
	ld a, TYPE_PKMN_FIRE
	farcall CheckIfPlayerHasPokemonOfType
	jr nc, .try_search_for_dratini ; no fire Pokémon
	ld de, POKEMON_TRADER
	farcall LookForCardIDInHandList
	jr nc, .try_search_for_dratini ; no Pokémon Trader in Hand
	; use Pokémon Trader if Mr. Mime lv20 is in Deck
	ld de, MR_MIME_LV20
	ld a, CARD_LOCATION_DECK
	farcall FindCardIDInLocation
	ld de, MR_MIME_LV20
	jp c, AITryUsePokemonTraderToSearchCard

.try_search_for_dratini
	ld de, DRATINI_LV10
	farcall CheckIfCardIDIsInHandOrPlayArea
	jr c, .try_search_for_bulbasaur ; has Dratini in Hand or Play Area
	ld de, DARK_DRAGONAIR
	ld b, PLAY_AREA_ARENA
	farcall FindCardIDInTurnDuelistsPlayArea
	jr c, .try_search_for_bulbasaur ; already has Dark Dragonair in play

	; doesn't have Dratini or Dragonair in play, attempt
	; to trade an unusable Evolution card
	; or a Pokémon card other than Bulbasaur in Hand
	call FindUnusableEvolutionCardInHand
	jr c, .trade_with_dratini ; has an unusable evolution in Hand
	ld de, BULBASAUR_LV12
	call FindDifferentPokemonCardInHand
	jr c, .trade_with_dratini ; has a Pokémon card in Hand other than Bulbasaur

	; otherwise just try to search any Evolution card
	; in Deck with The Boss' Way, then trade it with Dratini
	call FindAnyEvolutionCardInDeck
	ret nc ; no evolution cards in Deck
	push af
	call AITryUseTheBossWayToSearchCard
	pop bc
	ret c ; couldn't use The Boss' Way
	ld a, b
.trade_with_dratini
	ldh [hTemp_ffa0], a
	ld de, DRATINI_LV10
	ld a, CARD_LOCATION_DECK
	farcall FindCardIDInLocation
	jr nc, .try_search_for_bulbasaur ; no Dratini in Deck
	ldh [hTempPlayAreaLocation_ffa1], a
	jp AITryUsePokemonTraderToSearchCard_GotCardToTrade

.try_search_for_bulbasaur
	ld de, BULBASAUR_LV12
	farcall CheckIfCardIDIsInHandOrPlayArea
	jr c, .try_search_for_kangaskhan_or_scyther ; has Bulbasaur in Hand or Play Area
	ld de, DARK_IVYSAUR
	ld b, PLAY_AREA_ARENA
	farcall FindCardIDInTurnDuelistsPlayArea
	jr c, .try_search_for_kangaskhan_or_scyther ; has Dark Ivysaur in play
	ld de, DARK_VENUSAUR
	ld b, PLAY_AREA_ARENA
	farcall FindCardIDInTurnDuelistsPlayArea
	jr c, .try_search_for_kangaskhan_or_scyther ; has Dark Venusaur in play

	; doesn't have Bulbasaur, Dark Ivysaur or Dark Venusaur in play,
	; attempt to trade an unusable Evolution card
	; or a Pokémon card other than Dratini in Hand
	call FindUnusableEvolutionCardInHand
	jr c, .trade_with_bulbasaur ; has an unusable evolution in Hand
	ld de, DRATINI_LV10
	call FindDifferentPokemonCardInHand
	jr c, .trade_with_bulbasaur ; has a Pokémon card in Hand other than Dratini

	; otherwise just try to search any Evolution card
	; in Deck with The Boss' Way, then trade it with Bulbasaur
	call FindAnyEvolutionCardInDeck
	ret nc ; no evolution cards in Deck
	push af
	call AITryUseTheBossWayToSearchCard
	pop bc
	ret c ; couldn't use The Boss' Way
	ld a, b
.trade_with_bulbasaur
	ldh [hTemp_ffa0], a
	ld de, BULBASAUR_LV12
	ld a, CARD_LOCATION_DECK
	farcall FindCardIDInLocation
	jr nc, .try_search_for_kangaskhan_or_scyther ; no Bulbasaur in Deck
	ldh [hTempPlayAreaLocation_ffa1], a
	jp AITryUsePokemonTraderToSearchCard_GotCardToTrade

.try_search_for_kangaskhan_or_scyther
	; if has only 1 Pokémon in play and no Basic cards in Hand,
	; then attempt to trade for a Kangaskhan or Scyther in Deck
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	cp 1
	jr nz, .try_search_for_evolutions_1 ; more than 1 Pokémon in play
	call CountNumberOfBasicPokemonInHand
	or a
	jr nz, .try_search_for_evolutions_1 ; has Basic Pokémon card(s) in Hand
	call FindUnusableEvolutionCardInHand
	jr c, .trade_with_kangaskhan_or_scyther ; has an unusable Evolution card in Hand
	; try to search for an evolution card with The Boss' Way
	; to then trade for a Kangaskhan or Scyther
	call FindAnyEvolutionCardInDeck
	ret nc
	push af
	call AITryUseTheBossWayToSearchCard
	pop bc
	ret c
	ld a, b
.trade_with_kangaskhan_or_scyther
	ldh [hTemp_ffa0], a
	ld de, KANGASKHAN_LV40
	ld a, CARD_LOCATION_DECK
	farcall FindCardIDInLocation
	jr c, .asm_490ff
	ld de, SCYTHER_LV25
	ld a, CARD_LOCATION_DECK
	farcall FindCardIDInLocation
	jr nc, .try_search_for_evolutions_1
.asm_490ff
	ldh [hTempPlayAreaLocation_ffa1], a
	jp AITryUsePokemonTraderToSearchCard_GotCardToTrade

.try_search_for_evolutions_1
	; if Dark Dragonair is in play, then no need to search
	ld de, DARK_DRAGONAIR
	ld b, PLAY_AREA_ARENA
	farcall FindCardIDInTurnDuelistsPlayArea
	ret c ; has Dark Dragonair in play

	; if has The Boss' Way, use it to get a usable evolution
	ld de, THE_BOSSS_WAY
	farcall LookForCardIDInHandList
	jr nc, .use_pokemon_trader_instead_1
	ld bc, DARK_IVYSAUR
	ld de, DARK_VENUSAUR
	farcall FindUsableEvolutionInDeck
	jp c, AITryUseTheBossWayToSearchCard
	ld bc, BULBASAUR_LV12
	ld de, DARK_IVYSAUR
	farcall FindUsableEvolutionInDeck
	jp c, AITryUseTheBossWayToSearchCard
	ld bc, DRATINI_LV10
	ld de, DARK_DRAGONAIR
	farcall FindUsableEvolutionInDeck
	jp c, AITryUseTheBossWayToSearchCard
	ret

.use_pokemon_trader_instead_1
	; otherwise try using Pokémon Trader instead
	ld bc, DARK_IVYSAUR
	ld de, DARK_VENUSAUR
	farcall FindUsableEvolutionInDeck
	ld de, DARK_VENUSAUR
	jp c, AITryUsePokemonTraderToSearchCard
	ld bc, BULBASAUR_LV12
	ld de, DARK_IVYSAUR
	farcall FindUsableEvolutionInDeck
	ld de, DARK_IVYSAUR
	jp c, AITryUsePokemonTraderToSearchCard
	ld bc, DRATINI_LV10
	ld de, DARK_DRAGONAIR
	farcall FindUsableEvolutionInDeck
	ld de, DARK_DRAGONAIR
	jp c, AITryUsePokemonTraderToSearchCard
	ret

.ScorcherDeck:
	; if player has a Water-type Pokémon, then
	; check if there's a Pokémon Trader in hand
	; and a Mr. Mime lv20 in deck to search
	ld a, TYPE_PKMN_WATER
	farcall CheckIfPlayerHasPokemonOfType
	jr nc, .try_search_for_charmander ; no water Pokémon
	ld de, POKEMON_TRADER
	farcall LookForCardIDInHandList
	jr nc, .try_search_for_charmander ; no Pokémon Trader in Hand
	; use Pokémon Trader if Mr. Mime lv20 is in Deck
	ld de, MR_MIME_LV20
	ld a, CARD_LOCATION_DECK
	farcall FindCardIDInLocation
	ld de, MR_MIME_LV20
	jp c, AITryUsePokemonTraderToSearchCard

.try_search_for_charmander
	ld de, CHARMANDER_LV9
	farcall CheckIfCardIDIsInHandOrPlayArea
	jr c, .try_search_for_kangaskhan_magmar_or_mr_mime ; has Charmander in Hand or Play Area
	ld de, DARK_CHARMELEON
	ld b, PLAY_AREA_ARENA
	farcall FindCardIDInTurnDuelistsPlayArea ; already has Dark Charmeleon in play
	jr c, .try_search_for_kangaskhan_magmar_or_mr_mime
	ld de, DARK_CHARIZARD
	ld b, PLAY_AREA_ARENA
	farcall FindCardIDInTurnDuelistsPlayArea ; already has Dark Charizard in play
	jr c, .try_search_for_kangaskhan_magmar_or_mr_mime

	; doesn't have Charmander, Dark Charmeleon or Dark Charizard in play,
	; attempt to trade an unusable Evolution card
	; or a Pokémon card other than Dark Charmeleon in Hand
	call FindUnusableEvolutionCardInHand
	jr c, .trade_with_charmander ; has an unusable evolution in Hand
	ld de, DARK_CHARMELEON
	call FindDifferentPokemonCardInHand
	jr c, .trade_with_charmander ; has a Pokémon card in Hand other than Dark Charmeleon

	; otherwise just try to search any Evolution card
	; in Deck with The Boss' Way, then trade it with Charmander
	call FindAnyEvolutionCardInDeck
	ret nc ; no evolution cards in Deck
	push af
	call AITryUseTheBossWayToSearchCard
	pop bc
	ret c ; couldn't use The Boss' Way
	ld a, b
.trade_with_charmander
	ldh [hTemp_ffa0], a
	ld de, CHARMANDER_LV9
	ld a, CARD_LOCATION_DECK
	farcall FindCardIDInLocation
	jr nc, .try_search_for_kangaskhan_magmar_or_mr_mime ; no Charmander in Deck
	ldh [hTempPlayAreaLocation_ffa1], a
	jp AITryUsePokemonTraderToSearchCard_GotCardToTrade

.try_search_for_kangaskhan_magmar_or_mr_mime
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	cp 1
	jr nz, .try_search_for_evolutions_2 ; more than 1 Pokémon in play
	call CountNumberOfBasicPokemonInHand
	or a
	jr nz, .try_search_for_evolutions_2 ; has Basic Pokémon card(s) in Hand
	call FindUnusableEvolutionCardInHand
	jr c, .trade_with_kangaskhan_magmar_or_mr_mime ; has an unusable Evolution card in Hand
	; try to search for an evolution card with The Boss' Way
	; to then trade for a Kangaskhan, Magmar or Mr. Mime
	call FindAnyEvolutionCardInDeck
	ret nc
	push af
	call AITryUseTheBossWayToSearchCard
	pop bc
	ret c
	ld a, b
.trade_with_kangaskhan_magmar_or_mr_mime
	ldh [hTemp_ffa0], a
	ld de, KANGASKHAN_LV40
	ld a, CARD_LOCATION_DECK
	farcall FindCardIDInLocation
	jr c, .asm_49219
	ld de, MAGMAR_LV31
	ld a, CARD_LOCATION_DECK
	farcall FindCardIDInLocation
	jr c, .asm_49219
	ld de, MR_MIME_LV20
	ld a, CARD_LOCATION_DECK
	farcall FindCardIDInLocation
	jr nc, .try_search_for_evolutions_2
.asm_49219
	ldh [hTempPlayAreaLocation_ffa1], a
	jp AITryUsePokemonTraderToSearchCard_GotCardToTrade

.try_search_for_evolutions_2
	; if has The Boss' Way, use it to get a usable evolution
	ld de, THE_BOSSS_WAY
	farcall LookForCardIDInHandList
	jr nc, .use_pokemon_trader_instead_2
	ld bc, DARK_CHARMELEON
	ld de, DARK_CHARIZARD
	farcall FindUsableEvolutionInDeck
	jp c, AITryUseTheBossWayToSearchCard
	ld bc, CHARMANDER_LV9
	ld de, DARK_CHARMELEON
	farcall FindUsableEvolutionInDeck
	jp c, AITryUseTheBossWayToSearchCard
	ld bc, CLEFAIRY_LV15
	ld de, DARK_CLEFABLE
	farcall FindUsableEvolutionInDeck
	jp c, AITryUseTheBossWayToSearchCard
	ret

.use_pokemon_trader_instead_2
	; otherwise try using Pokémon Trader instead
	ld bc, DARK_CHARMELEON
	ld de, DARK_CHARIZARD
	farcall FindUsableEvolutionInDeck
	ld de, DARK_CHARIZARD
	jp c, AITryUsePokemonTraderToSearchCard
	ld bc, CHARMANDER_LV9
	ld de, DARK_CHARMELEON
	farcall FindUsableEvolutionInDeck
	ld de, DARK_CHARMELEON
	jp c, AITryUsePokemonTraderToSearchCard
	ld bc, CLEFAIRY_LV15
	ld de, DARK_CLEFABLE
	farcall FindUsableEvolutionInDeck
	ld de, DARK_CLEFABLE
	jp c, AITryUsePokemonTraderToSearchCard
	ret

.TsunamiStarterDeck:
	; if player has a Lightning-type Pokémon, then
	; check if there's a Pokémon Trader in hand
	; and a Mr. Mime lv20 in deck to search
	ld a, TYPE_PKMN_LIGHTNING
	farcall CheckIfPlayerHasPokemonOfType
	jr nc, .try_search_for_squirtle ; no lightning Pokémon
	ld de, POKEMON_TRADER
	farcall LookForCardIDInHandList
	jr nc, .try_search_for_squirtle ; no Pokémon Trader in Hand
	; use Pokémon Trader if Mr. Mime lv20 is in Deck
	ld de, MR_MIME_LV20
	ld a, CARD_LOCATION_DECK
	farcall FindCardIDInLocation
	ld de, MR_MIME_LV20
	jp c, AITryUsePokemonTraderToSearchCard

.try_search_for_squirtle
	ld de, SQUIRTLE_LV8
	farcall CheckIfCardIDIsInHandOrPlayArea
	jr c, .try_search_for_scyther_mr_mime_or_lapras ; has Squirtle in Hand or Play Area
	ld de, DARK_WARTORTLE
	ld b, PLAY_AREA_ARENA
	farcall FindCardIDInTurnDuelistsPlayArea
	jr c, .try_search_for_scyther_mr_mime_or_lapras ; already has Dark Wartortle in play
	ld de, DARK_BLASTOISE
	ld b, PLAY_AREA_ARENA
	farcall FindCardIDInTurnDuelistsPlayArea
	jr c, .try_search_for_scyther_mr_mime_or_lapras ; already has Dark Blastoise in play

	; doesn't have Squirtle, Dark Wartortle or Dark Blastoise in play,
	; attempt to trade an unusable Evolution card
	; or a Pokémon card other than Dark Wartortle in Hand
	call FindUnusableEvolutionCardInHand
	jr c, .trade_with_squirtle ; has an unusable evolution in Hand
	ld de, DARK_WARTORTLE
	call FindDifferentPokemonCardInHand
	jr c, .trade_with_squirtle ; has a Pokémon card in Hand other than Dark Wartortle

	; otherwise just try to search any Evolution card
	; in Deck with The Boss' Way, then trade it with Squirtle
	call FindAnyEvolutionCardInDeck
	ret nc ; no evolution cards in Deck
	push af
	call AITryUseTheBossWayToSearchCard
	pop bc
	ret c ; couldn't use The Boss' Way
	ld a, b
.trade_with_squirtle
	ldh [hTemp_ffa0], a
	ld de, SQUIRTLE_LV8
	ld a, CARD_LOCATION_DECK
	farcall FindCardIDInLocation
	jr nc, .try_search_for_scyther_mr_mime_or_lapras ; no Squirtle in Deck
	ldh [hTempPlayAreaLocation_ffa1], a
	jp AITryUsePokemonTraderToSearchCard_GotCardToTrade

.try_search_for_scyther_mr_mime_or_lapras
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	cp 1
	jr nz, .try_search_for_evolutions_3 ; more than 1 Pokémon in play
	call CountNumberOfBasicPokemonInHand
	or a
	jr nz, .try_search_for_evolutions_3 ; has Basic Pokémon card(s) in Hand
	call FindUnusableEvolutionCardInHand
	jr c, .trade_with_scyther_mr_mime_or_lapras ; has an unusable Evolution card in Hand
	; try to search for an evolution card with The Boss' Way
	; to then trade for a Scyther, Mr. Mime or Lapras
	call FindAnyEvolutionCardInDeck
	ret nc
	push af
	call AITryUseTheBossWayToSearchCard
	pop bc
	ret c
	ld a, b
.trade_with_scyther_mr_mime_or_lapras
	ldh [hTemp_ffa0], a
	ld de, SCYTHER_LV25
	ld a, CARD_LOCATION_DECK
	farcall FindCardIDInLocation
	jr c, .asm_49329
	ld de, MR_MIME_LV20
	ld a, CARD_LOCATION_DECK
	farcall FindCardIDInLocation
	jr c, .asm_49329
	ld de, LAPRAS_LV31
	ld a, CARD_LOCATION_DECK
	farcall FindCardIDInLocation
	jr nc, .try_search_for_evolutions_3
.asm_49329
	ldh [hTempPlayAreaLocation_ffa1], a
	jp AITryUsePokemonTraderToSearchCard_GotCardToTrade

.try_search_for_evolutions_3
	; if has The Boss' Way, use it to get a usable evolution
	ld de, THE_BOSSS_WAY
	farcall LookForCardIDInHandList
	jr nc, .use_pokemon_trader_instead_3
	ld bc, DARK_WARTORTLE
	ld de, DARK_BLASTOISE
	farcall FindUsableEvolutionInDeck
	jp c, AITryUseTheBossWayToSearchCard
	ld bc, SQUIRTLE_LV8
	ld de, DARK_WARTORTLE
	farcall FindUsableEvolutionInDeck
	jp c, AITryUseTheBossWayToSearchCard
	ld bc, CLEFAIRY_LV15
	ld de, DARK_CLEFABLE
	farcall FindUsableEvolutionInDeck
	jp c, AITryUseTheBossWayToSearchCard
	ret

.use_pokemon_trader_instead_3
	; otherwise try using Pokémon Trader instead
	ld bc, DARK_WARTORTLE
	ld de, DARK_BLASTOISE
	farcall FindUsableEvolutionInDeck
	ld de, DARK_BLASTOISE
	jp c, AITryUsePokemonTraderToSearchCard
	ld bc, SQUIRTLE_LV8
	ld de, DARK_WARTORTLE
	farcall FindUsableEvolutionInDeck
	ld de, DARK_WARTORTLE
	jp c, AITryUsePokemonTraderToSearchCard
	ld bc, CLEFAIRY_LV15
	ld de, DARK_CLEFABLE
	farcall FindUsableEvolutionInDeck
	ld de, DARK_CLEFABLE
	jp c, AITryUsePokemonTraderToSearchCard
	ret

.SmashToMincemeatDeck:
	; if player has a Fighting-type or Psychic-type Pokémon, then
	; check if there's a Pokémon Trader in hand
	; and a Mr. Mime lv20 in deck to search
	ld a, TYPE_PKMN_FIGHTING
	farcall CheckIfPlayerHasPokemonOfType
	jr c, .try_search_for_mr_mime ; has fighting Pokémon
	ld a, TYPE_PKMN_PSYCHIC
	farcall CheckIfPlayerHasPokemonOfType
	jr nc, .try_search_for_machop ; no psychic Pokémon
.try_search_for_mr_mime
	ld de, POKEMON_TRADER
	farcall LookForCardIDInHandList
	jr nc, .try_search_for_machop ; no Pokémon Trader in Hand
	; use Pokémon Trader if Mr. Mime lv20 is in Deck
	ld de, MR_MIME_LV20
	ld a, CARD_LOCATION_DECK
	farcall FindCardIDInLocation
	ld de, MR_MIME_LV20
	jp c, AITryUsePokemonTraderToSearchCard

.try_search_for_machop
	ld de, MACHOP_LV20
	farcall CheckIfCardIDIsInHandOrPlayArea
	jr c, .try_search_for_kangaskhan_magmar_or_chansey ; has Machop in Hand or Play Area
	ld de, DARK_MACHOKE
	ld b, PLAY_AREA_ARENA
	farcall FindCardIDInTurnDuelistsPlayArea ; already has Dark Machoke in play
	jr c, .try_search_for_kangaskhan_magmar_or_chansey
	ld de, DARK_MACHAMP
	ld b, PLAY_AREA_ARENA
	farcall FindCardIDInTurnDuelistsPlayArea ; already has Dark Machamp in play
	jr c, .try_search_for_kangaskhan_magmar_or_chansey

	; doesn't have Machop, Dark Machoke or Dark Machamp in play,
	; attempt to trade an unusable Evolution card
	; or a Pokémon card other than Dark Machoke in Hand
	call FindUnusableEvolutionCardInHand
	jr c, .trade_with_machop ; has an unusable evolution in Hand
	ld de, DARK_MACHOKE
	call FindDifferentPokemonCardInHand
	jr c, .trade_with_machop ; has a Pokémon card in Hand other than Dark Machoke

	; otherwise just try to search any Evolution card
	; in Deck with The Boss' Way, then trade it with Machop
	call FindAnyEvolutionCardInDeck
	ret nc ; no evolution cards in Deck
	push af
	call AITryUseTheBossWayToSearchCard
	pop bc
	ret c ; couldn't use The Boss' Way
	ld a, b
.trade_with_machop
	ldh [hTemp_ffa0], a
	ld de, MACHOP_LV20
	ld a, CARD_LOCATION_DECK
	farcall FindCardIDInLocation
	jr nc, .try_search_for_kangaskhan_magmar_or_chansey ; no Machop in Deck
	ldh [hTempPlayAreaLocation_ffa1], a
	jp AITryUsePokemonTraderToSearchCard_GotCardToTrade

.try_search_for_kangaskhan_magmar_or_chansey
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	cp 1
	jr nz, .try_search_for_evolutions_4 ; more than 1 Pokémon in play
	call CountNumberOfBasicPokemonInHand
	or a
	jr nz, .try_search_for_evolutions_4 ; has Basic Pokémon card(s) in Hand
	call FindUnusableEvolutionCardInHand
	jr c, .trade_with_kangaskhan_magmar_or_chansey ; has an unusable Evolution card in Hand
	; try to search for an evolution card with The Boss' Way
	; to then trade for a Kangaskhan or Chansey
	call FindAnyEvolutionCardInDeck
	ret nc
	push af
	call AITryUseTheBossWayToSearchCard
	pop bc
	ret c
	ld a, b
.trade_with_kangaskhan_magmar_or_chansey
	ldh [hTemp_ffa0], a
	ld de, KANGASKHAN_LV40
	ld a, CARD_LOCATION_DECK
	farcall FindCardIDInLocation
	jr c, .asm_49436
	ld de, CHANSEY_LV55
	ld a, CARD_LOCATION_DECK
	farcall FindCardIDInLocation
	jr nc, .try_search_for_evolutions_4
.asm_49436
	ldh [hTempPlayAreaLocation_ffa1], a
	jp AITryUsePokemonTraderToSearchCard_GotCardToTrade

.try_search_for_evolutions_4
	; if has The Boss' Way, use it to get a usable evolution
	ld de, THE_BOSSS_WAY
	farcall LookForCardIDInHandList
	jr nc, .use_pokemon_trader_instead_4
	ld bc, DARK_MACHOKE
	ld de, DARK_MACHAMP
	farcall FindUsableEvolutionInDeck
	jp c, AITryUseTheBossWayToSearchCard
	ld bc, MACHOP_LV20
	ld de, DARK_MACHOKE
	farcall FindUsableEvolutionInDeck
	jp c, AITryUseTheBossWayToSearchCard
	ld bc, CLEFAIRY_LV15
	ld de, DARK_CLEFABLE
	farcall FindUsableEvolutionInDeck
	jp c, AITryUseTheBossWayToSearchCard
	ret

.use_pokemon_trader_instead_4
	; otherwise try using Pokémon Trader instead
	ld bc, DARK_MACHOKE
	ld de, DARK_MACHAMP
	farcall FindUsableEvolutionInDeck
	ld de, DARK_MACHAMP
	jp c, AITryUsePokemonTraderToSearchCard
	ld bc, MACHOP_LV20
	ld de, DARK_MACHOKE
	farcall FindUsableEvolutionInDeck
	ld de, DARK_MACHOKE
	jp c, AITryUsePokemonTraderToSearchCard
	ld bc, CLEFAIRY_LV15
	ld de, DARK_CLEFABLE
	farcall FindUsableEvolutionInDeck
	ld de, DARK_CLEFABLE
	jp c, AITryUsePokemonTraderToSearchCard
	ret

.PowerOfDarknessDeck:
	ld de, POKEMON_TRADER
	farcall LookForCardIDInHandList
	jp nc, .try_search_for_evolutions_5 ; no Pokémon Trader in Hand
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	cp 1
	jp nz, .try_search_for_evolutions_5 ; more than 1 Pokémon in play
	call CountNumberOfBasicPokemonInHand
	or a
	jp nz, .try_search_for_evolutions_5 ; has Basic Pokémon card(s) in Hand
	call FindUnusableEvolutionCardInHand
	jr c, .asm_494d0 ; has an unusable Evolution card in Hand
	call Func_4bd72
	jr nc, .find_any_evolution_card_to_trade
	call Func_495dd
	jr nc, .asm_494d0
.find_any_evolution_card_to_trade
	; try to search for an evolution card with The Boss' Way
	; to then trade for a specific Basic card
	call FindAnyEvolutionCardInDeck
	ret nc
	push af
	call AITryUseTheBossWayToSearchCard
	pop bc
	ret c
	ld a, b
.asm_494d0
	push af
	call Func_4bd72
	pop bc
	ld a, b
	ldh [hTemp_ffa0], a
	jr nc, .asm_49508
	ld de, GRS_MEWTWO
	ld a, CARD_LOCATION_DECK
	farcall FindCardIDInLocation
	jr c, .asm_49534
	ld de, PSYDUCK_LV16
	ld a, CARD_LOCATION_DECK
	farcall FindCardIDInLocation
	jr c, .asm_49534
	ld de, CLEFAIRY_LV15
	ld a, CARD_LOCATION_DECK
	farcall FindCardIDInLocation
	jr c, .asm_49534
	ld de, DRATINI_LV12
	ld a, CARD_LOCATION_DECK
	farcall FindCardIDInLocation
	jr c, .asm_49534
	jr .try_search_for_evolutions_5

.asm_49508
	ld de, GRS_MEWTWO
	ld a, CARD_LOCATION_DECK
	farcall FindCardIDInLocation
	jr c, .asm_49534
	ld de, DRATINI_LV12
	ld a, CARD_LOCATION_DECK
	farcall FindCardIDInLocation
	jr c, .asm_49534
	ld de, PSYDUCK_LV16
	ld a, CARD_LOCATION_DECK
	farcall FindCardIDInLocation
	jr c, .asm_49534
	ld de, CLEFAIRY_LV15
	ld a, CARD_LOCATION_DECK
	farcall FindCardIDInLocation
	jr nc, .try_search_for_evolutions_5
.asm_49534
	ldh [hTempPlayAreaLocation_ffa1], a
	jp AITryUsePokemonTraderToSearchCard_GotCardToTrade

.try_search_for_evolutions_5
	; if has The Boss' Way, use it to get a usable evolution
	ld de, THE_BOSSS_WAY
	farcall LookForCardIDInHandList
	jr nc, .use_pokemon_trader_instead_5
	ld bc, CLEFAIRY_LV15
	ld de, DARK_CLEFABLE
	farcall FindUsableEvolutionInDeck
	jp c, AITryUseTheBossWayToSearchCard
	ld bc, PSYDUCK_LV16
	ld de, DARK_GOLDUCK
	farcall FindUsableEvolutionInDeck
	jp c, AITryUseTheBossWayToSearchCard
	ld bc, DRATINI_LV12
	ld de, DARK_DRAGONAIR
	farcall FindUsableEvolutionInDeck
	jp c, AITryUseTheBossWayToSearchCard
	ret

.use_pokemon_trader_instead_5
	; otherwise try using Pokémon Trader instead
	ld bc, CLEFAIRY_LV15
	ld de, DARK_CLEFABLE
	farcall FindUsableEvolutionInDeck
	ld de, DARK_CLEFABLE
	jp c, AITryUsePokemonTraderToSearchCard
	ld bc, PSYDUCK_LV16
	ld de, DARK_GOLDUCK
	farcall FindUsableEvolutionInDeck
	ld de, DARK_GOLDUCK
	jp c, AITryUsePokemonTraderToSearchCard
	ld bc, DRATINI_LV12
	ld de, DARK_DRAGONAIR
	farcall FindUsableEvolutionInDeck
	ld de, DARK_DRAGONAIR
	jp c, AITryUsePokemonTraderToSearchCard
	ret

; AI tries to use The Boss' Way to search for card index given in a
; input:
; - a = deck index of card to search in Deck
AITryUseTheBossWayToSearchCard:
	ldh [hTemp_ffa0], a
	ld de, THE_BOSSS_WAY
	farcall LookForCardIDInHandList
	ccf
	ret c ; no The Boss' Way in Hand
	ld [wAITrainerCardToPlay], a
	jr AIUseTrainerCardToSearchCard

; AI tries to find a random Pokémon card in Hand different from
; card ID given in de to trade for a given card ID in the Deck
; then uses Pokémon Trader to trade cards
; input:
; - a = deck index of card to search in Deck
; - de = card ID in Hand to avoid trading
AITryUsePokemonTraderToSearchCard:
	ldh [hTempPlayAreaLocation_ffa1], a
	call FindDifferentPokemonCardInHand
	ccf
	ret c ; card in hand to trade not found
	ldh [hTemp_ffa0], a
AITryUsePokemonTraderToSearchCard_GotCardToTrade:
	ld de, POKEMON_TRADER
	farcall LookForCardIDInHandList
	ccf
	ret c ; no Pokémon Trader in Hand
	ld [wAITrainerCardToPlay], a
;	fallthrough

; uses a Trainer card to search for a card in Deck
; expects the Trainer card index to be in [wAITrainerCardToPlay]
AIUseTrainerCardToSearchCard:
	ld a, [wAITrainerCardToPlay]
	ldh [hTempCardIndex_ff9f], a
	bank1call LoadNonPokemonCardEffectCommands
	ld a, EFFECTCMDTYPE_INITIAL_EFFECT_1
	call TryExecuteEffectCommandFunction
	ret c
	ld a, OPPACTION_PLAY_TRAINER
	farcall AIMakeDecision
	ret c
	ld a, OPPACTION_EXECUTE_TRAINER_EFFECTS
	farcall AIMakeDecision
	or a
	ret

Func_495dd:
	call Func_4bd72
	ccf
	ret c
	ldh [hTempCardIndex_ff9f], a
	ld a, c
	ldh [hTemp_ffa0], a
	call FindAnyEvolutionCardInDeck
	ccf
	ret c ; evolution card not found
	ldh [hTempPlayAreaLocation_ffa1], a
	ld a, OPPACTION_USE_PKMN_POWER
	farcall AIMakeDecision
	ld a, OPPACTION_EXECUTE_PKMN_POWER_EFFECT
	farcall AIMakeDecision
	ld a, OPPACTION_DUEL_MAIN_SCENE
	farcall AIMakeDecision
	ldh a, [hTempPlayAreaLocation_ffa1]
	ret

Func_49603:
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call GetCardIDFromDeckIndex
	cp16 DARK_VENUSAUR
	jr z, .dark_venusaur_arena
	or a
	ret
.dark_venusaur_arena
	xor a ; FIRST_ATTACK_OR_PKMN_POWER
	ld [wSelectedAttack], a
	ldh [hTempPlayAreaLocation_ff9d], a
	farcall CheckIfSelectedAttackIsUnusable
	ccf
	ret nc ; Horrid Pollen is unusable

	call SwapTurn
	ld e, PLAY_AREA_ARENA
	call GetPlayAreaCardAttachedEnergies
	ld a, [wTotalAttachedEnergies]
	ld c, a
	ld b, PLAY_AREA_ARENA
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	ld d, a
	ld e, PLAY_AREA_BENCH_1
.loop_bench_1
	call GetPlayAreaCardAttachedEnergies
	ld a, [wTotalAttachedEnergies]
	cp c
	jr c, .next_bench_1 ; less than Arena or max
	jr z, .next_bench_1 ; same as Arena or max
	; has more attached energies
	ld c, a
	ld b, e
.next_bench_1
	inc e
	ld a, e
	cp d
	jr nz, .loop_bench_1

	call SwapTurn
	ld a, b
	or a
	jr z, .check_stage2
	; found a bench card with more energies attached
	scf
	ret
.check_stage2
	call SwapTurn
	xor a ; PLAY_AREA_ARENA
	call .CheckIfItsStage2
	jr c, .asm_49672
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	ld d, a
	ld e, PLAY_AREA_BENCH_1
.loop_bench_2
	ld a, e
	push de
	call .CheckIfItsStage2
	pop de
	jr nc, .next_bench_2
	call SwapTurn
	ld a, e
	scf
	ret
.next_bench_2
	inc e
	ld a, e
	cp d
	jr nz, .loop_bench_2

.asm_49672
	call SwapTurn
	farcall FindBenchCardThatCanBeKnockedOut
	ret

.CheckIfItsStage2:
	add DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call LoadCardDataToBuffer2_FromDeckIndex
	ld a, [wLoadedCard2Stage]
	cp STAGE2
	ccf
	; carry set if is Stage 2
	ret
; 0x49687

SECTION "Bank 12@582a", ROMX[$582a], BANK[$12]

; returns carry if player's card is weak to Arena Card
CheckIfDefendingPokemonIsWeakToArenaCard:
	bank1call GetPlayAreaCardColor
	call TranslateColorToWR
	push af
	call SwapTurn
	bank1call GetArenaCardWeakness
	call SwapTurn
	pop bc
	cp b
	jr z, .set_carry
	or a
	ret
.set_carry
	scf
	ret
; 0x49842

SECTION "Bank 12@5887", ROMX[$5887], BANK[$12]

; searches the Deck for any card that is an Evolution
; output:
; - a = deck index if found
; - carry set if found
FindAnyEvolutionCardInDeck:
	ld e, 0
.loop_deck
	ld a, DUELVARS_CARD_LOCATIONS
	add e
	get_turn_duelist_var
	cp CARD_LOCATION_DECK
	jr nz, .next_card ; not in Deck
	ld a, e
	push de
	call LoadCardDataToBuffer2_FromDeckIndex
	pop de
	ld a, [wLoadedCard2Type]
	cp TYPE_ENERGY
	jr nc, .next_card ; not Pokémon card
	ld a, [wLoadedCard2Stage]
	or a
	jr nz, .found_evolution_card
.next_card
	inc e
	ld a, e
	cp DECK_SIZE
	jr nz, .loop_deck
; no evolution cards found
	or a
	ret
.found_evolution_card
	ld a, e
	scf
	ret

FindPokemonInBenchWithDamageAndEnergyAttached:
	ld a, DUELVARS_BENCH
	get_turn_duelist_var
	ld e, PLAY_AREA_BENCH_1
.loop_bench
	ld a, [hli]
	cp $ff
	ret z ; no carry
	push de
	push hl
	ld a, e
	call CheckIfPokemonHasDamage
	pop hl
	pop de
	jr nc, .next ; has full HP
	call GetPlayAreaCardAttachedEnergies
	ld a, [wTotalAttachedEnergies]
	or a
	jr z, .next ; no energy attached
	ld a, e
	scf
	ret
.next
	inc e
	jr .loop_bench

; loops through Play Area to find any Dark Charizard
; if any is found that has more than 60 HP remaining
; and less than 5 energy cards attached, return carry set
; if more than 1 is found, only account for the card with
; more energy cards already attached
; output:
; - a = PLAY_AREA_* constant
; - carry set if found
FindDarkCharizardToAttachEnergy:
	xor a
	ld b, a ; 0
	ld e, a ; PLAY_AREA_ARENA
	ld c, -1
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
.loop_play_area
	ld a, [hli]
	cp $ff
	jr z, .done_loop
	push hl
	push de
	push bc
	call GetCardIDFromDeckIndex
	cp16 DARK_CHARIZARD
	pop bc
	pop de
	jr nz, .next_pokemon ; not Dark Charizard
	call GetPlayAreaCardAttachedEnergies
	ld a, [wTotalAttachedEnergies]
	cp 5
	jr nc, .next_pokemon ; has at least 5 energy cards
	ld d, a ; number of energy cards
	ld a, e
	or a
	jr z, .arena_and_without_energy
	add DUELVARS_ARENA_CARD_HP
	get_turn_duelist_var
	cp 60
	jr c, .next_pokemon ; less than 60 HP remaining
	ld a, c
	cp -1
	jr nz, .compare_with_old ; c != -1
	ld b, d ; number of energy cards
	ld c, e
	jr .next_pokemon
.compare_with_old
	ld a, b
	cp d
	jr nc, .next_pokemon ; old >= new
	; replace with new
	ld b, d
	ld c, e
.next_pokemon
	pop hl
	inc e
	jr .loop_play_area

.done_loop
	ld a, c
	cp -1
	jr z, .no_carry
	scf
	ret

.no_carry
	; none found
	or a
	ret

.arena_and_without_energy
	; Dark Charizard is Arena card and has no energy cards
	; return carry set
	pop hl
	scf
	ret
; 0x49925

SECTION "Bank 12@5a73", ROMX[$5a73], BANK[$12]

Func_49a73:
	ld e, PLAY_AREA_ARENA
	call SwapTurn
	call GetPlayAreaCardAttachedEnergies
	call SwapTurn
	ld a, [wTotalAttachedEnergies]
	ld [wd076], a
	ld a, DUELVARS_BENCH
	call GetNonTurnDuelistVariable
	ld e, PLAY_AREA_BENCH_1
.loop_bench
	ld a, [hli]
	cp $ff
	ret z ; done
	push hl
	push de
	; temporarily replace arena card index and HP
	ld b, a
	ld a, DUELVARS_ARENA_CARD
	call GetNonTurnDuelistVariable
	push af
	ld [hl], b ; deck index
	ld a, e
	add DUELVARS_ARENA_CARD_HP
	call GetNonTurnDuelistVariable
	ld b, a
	ld a, DUELVARS_ARENA_CARD_HP
	call GetNonTurnDuelistVariable
	push af
	ld [hl], b ; remaining HP
	xor a ; PLAY_AREA_ARENA
	ldh [hTempPlayAreaLocation_ff9d], a
	farcall FindBenchCardThatCanBeKnockedOut.CheckIfAnyAttackCanKO
	jr nc, .cannot_be_knocked_out
	farcall CheckIfSelectedAttackIsUnusable
	jr nc, .can_be_knocked_out
	farcall LookForEnergyNeededForAttackInHand
	jr c, .can_be_knocked_out
.cannot_be_knocked_out
	; restore arena card index and HP
	ld a, DUELVARS_ARENA_CARD_HP
	call GetNonTurnDuelistVariable
	pop af
	ld [hl], a
	ld a, DUELVARS_ARENA_CARD
	call GetNonTurnDuelistVariable
	pop af
	ld [hl], a
	pop de
.next_bench
	inc e
	pop hl
	jr .loop_bench

.can_be_knocked_out
	; restore arena card index and HP
	ld a, DUELVARS_ARENA_CARD_HP
	call GetNonTurnDuelistVariable
	pop af
	ld [hl], a
	ld a, DUELVARS_ARENA_CARD
	call GetNonTurnDuelistVariable
	pop af
	ld [hl], a
	pop de
	call SwapTurn
	call GetPlayAreaCardAttachedEnergies
	call SwapTurn
	ld a, [wTotalAttachedEnergies]
	ld hl, wd076
	cp [hl]
	jr z, .next_bench ; same number of attached energies
	jr c, .next_bench ; has less attached energies
	ld a, e
	pop hl
	scf
	ret

Func_49af6:
	ld a, DUELVARS_BENCH
	call GetNonTurnDuelistVariable
	ld e, PLAY_AREA_BENCH_1
.loop_bench
	ld a, [hli]
	cp $ff
	ret z ; done
	push hl
	push de
	; temporarily replace arena card index and HP
	ld b, a
	ld a, DUELVARS_ARENA_CARD
	call GetNonTurnDuelistVariable
	push af
	ld [hl], b
	ld a, e
	add DUELVARS_ARENA_CARD_HP
	call GetNonTurnDuelistVariable
	ld b, a
	ld a, DUELVARS_ARENA_CARD_HP
	call GetNonTurnDuelistVariable
	push af
	ld [hl], b
	xor a ; PLAY_AREA_ARENA
	ldh [hTempPlayAreaLocation_ff9d], a
	farcall FindBenchCardThatCanBeKnockedOut.CheckIfAnyAttackCanKO
	jr nc, .cannot_be_knocked_out
	farcall CheckIfSelectedAttackIsUnusable
	jr nc, .can_be_knocked_out
	farcall LookForEnergyNeededForAttackInHand
	jr c, .can_be_knocked_out
.cannot_be_knocked_out
	; restore arena card index and HP
	ld a, DUELVARS_ARENA_CARD_HP
	call GetNonTurnDuelistVariable
	pop af
	ld [hl], a
	ld a, DUELVARS_ARENA_CARD
	call GetNonTurnDuelistVariable
	pop af
	ld [hl], a
	pop de
.next_bench
	inc e
	pop hl
	jr .loop_bench

.can_be_knocked_out
	; restore arena card index and HP
	ld a, DUELVARS_ARENA_CARD_HP
	call GetNonTurnDuelistVariable
	pop af
	ld [hl], a
	ld a, DUELVARS_ARENA_CARD
	call GetNonTurnDuelistVariable
	pop af
	ld [hl], a
	pop de
	push de
	ld a, e
	add DUELVARS_ARENA_CARD
	call SwapTurn
	get_turn_duelist_var
	call LoadCardDataToBuffer2_FromDeckIndex
	call SwapTurn
	ld a, [wLoadedCard2Stage]
	or a
	pop de
	jr z, .next_bench ; is Basic card
	ld a, e
	pop hl
	scf
	ret

Func_49b69:
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call GetCardIDFromDeckIndex
	cp16 DARK_BLASTOISE
	jr z, .dark_blastoise_arena
	or a
	ret
.dark_blastoise_arena
	xor a ; FIRST_ATTACK_OR_PKMN_POWER
	ld [wSelectedAttack], a
	ldh [hTempPlayAreaLocation_ff9d], a
	farcall CheckIfSelectedAttackIsUnusable
	ccf
	ret nc ; Hydrocannon not usable
	call Func_49a73
	ret c
	call Func_49af6
	ret c
	farcall FindBenchCardThatCanBeKnockedOut
	ret
; 0x49b94

SECTION "Bank 12@5c04", ROMX[$5c04], BANK[$12]

Func_49c04:
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call GetCardIDFromDeckIndex
	cp16 DARK_MACHAMP
	jr z, .dark_machamp_arena
	or a
	ret
.dark_machamp_arena
	xor a ; FIRST_ATTACK_OR_PKMN_POWER
	ldh [hTempPlayAreaLocation_ff9d], a
	inc a
	ld [wSelectedAttack], a
	farcall CheckIfSelectedAttackIsUnusable
	ccf
	ret nc ; Mega Punch is unusable
	ld e, PLAY_AREA_ARENA
	call SwapTurn
	call GetPlayAreaCardAttachedEnergies
	call SwapTurn
	ld a, [wTotalAttachedEnergies]
	cp 3
	jr nc, .asm_49c3a
	farcall Func_4c56b.FindBenchCardWithAtLeast3AttachedEnergies
	ret c
.asm_49c3a
	xor a
	call SwapTurn
	call Func_49603.CheckIfItsStage2
	call SwapTurn
	ccf
	ret nc
	call SwapTurn
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	ld d, a
	ld e, PLAY_AREA_BENCH_1
.asm_49c4f
	ld a, e
	push de
	call Func_49603.CheckIfItsStage2
	pop de
	jr c, .asm_49c61
	inc e
	ld a, e
	cp d
	jr nz, .asm_49c4f
	call SwapTurn
	or a
	ret
.asm_49c61
	call SwapTurn
	ld a, e
	scf
	ret
; 0x49c67

SECTION "Bank 12@5d29", ROMX[$5d29], BANK[$12]

; initializes some variables and sets value of wAIBarrierFlagCounter.
; if Player uses Barrier 3 times in a row, AI checks if Player's deck
; has only MewtwoLv53 Pokemon cards (running a MewtwoLv53 mill deck).
InitAITurnVars:
; increase Pokedex counter by 1
	ld a, [wAIPokedexCounter]
	inc a
	ld [wAIPokedexCounter], a

	xor a
	ld [wPreviousAIFlags], a
	ld [wAITriedAttack], a
	ld [wcddc], a
	ld [wAIRetreatedThisTurn], a
	ld [wd081], a

; checks if the Player used an attack last turn
; and if it was the second attack of their card.
	ld a, [wPlayerAttackingAttackIndex]
	cp $ff
	jr z, .check_flag
	or a
	jr z, .check_flag
	ld a, [wPlayerAttackingCardIndex]
	cp $ff
	jr z, .check_flag

; if the card is MewtwoLv53, it means the Player
; used its second attack, Barrier.
	call SwapTurn
	call GetCardIDFromDeckIndex
	call SwapTurn
	cp16 MEWTWO_LV53
	jr nz, .check_flag
	; Player used Barrier last turn

; check if flag was already set, if so,
; reset wAIBarrierFlagCounter to $80.
	ld a, [wAIBarrierFlagCounter]
	bit AI_MEWTWO_MILL_F, a
	jr nz, .set_flag

; if not, increase it by 1 and check if it exceeds 2.
	inc a
	ld [wAIBarrierFlagCounter], a
	cp 3
	jr c, .asm_49daf

; this means that the Player used Barrier
; at least 3 turns in a row.
; check if Player is running MewtwoLv53-only deck,
; if so, set wAIBarrierFlagCounter flag.
	ld a, DUELVARS_ARENA_CARD
	call GetNonTurnDuelistVariable
	call SwapTurn
	call GetCardIDFromDeckIndex
	call SwapTurn
	cp16 MEWTWO_LV53
	jr nz, .reset_1
	farcall CheckIfPlayerHasPokemonOtherThanMewtwoLv53
	jr nc, .set_flag
.reset_1
; reset wAIBarrierFlagCounter
	xor a
	ld [wAIBarrierFlagCounter], a
	jr .asm_49daf

.set_flag
	ld a, AI_MEWTWO_MILL
	ld [wAIBarrierFlagCounter], a
	jr .asm_49daf

.check_flag
; increase counter by 1 if flag is set
	ld a, [wAIBarrierFlagCounter]
	bit AI_MEWTWO_MILL_F, a
	jr z, .reset_2
	inc a
	ld [wAIBarrierFlagCounter], a
	jr .asm_49daf

.reset_2
; reset wAIBarrierFlagCounter
	xor a
	ld [wAIBarrierFlagCounter], a

.asm_49daf
	ld a, [wd033]
	or a
	jr z, .asm_49db9
	dec a
	ld [wd033], a
.asm_49db9
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	ld hl, wd034
	cp [hl]
	jr z, .asm_49dc9
	ld [hl], a
	xor a
	ld [wd035], a
	jr .done
.asm_49dc9
	ld hl, wd035
	inc [hl]
.done
	ret
; 0x49dce

SECTION "Bank 12@5eb3", ROMX[$5eb3], BANK[$12]

; return carry if Pokémon at play area location
; in hTempPlayAreaLocation_ff9d does not have
; energy required for the attack index in wSelectedAttack
; or has exactly the same amount of energy needed
; input:
;	[hTempPlayAreaLocation_ff9d] = play area location
;	[wSelectedAttack]         = attack index to check
; output:
;	a = number of extra energy cards attached
CheckIfNoSurplusEnergyForAttack:
	ldh a, [hTempPlayAreaLocation_ff9d]
	add DUELVARS_ARENA_CARD
	get_turn_duelist_var
	ld d, a
	ld a, [wSelectedAttack]
	ld e, a
	call CopyAttackDataAndDamage_FromDeckIndex
	ld hl, wLoadedAttackName
	ld a, [hli]
	or [hl]
	jr z, .not_attack
	ld a, [wLoadedAttackCategory]
	cp POKEMON_POWER
	jr nz, .is_attack
.not_attack
	scf
	ret

.is_attack
	ldh a, [hTempPlayAreaLocation_ff9d]
	ld e, a
	call GetPlayAreaCardAttachedEnergies
	bank1call HandleEnergyBurn
	xor a
	ld [wTempLoadedAttackEnergyCost], a
	ld [wTempLoadedAttackEnergyNeededAmount], a
	ld [wTempLoadedAttackEnergyNeededType], a
	ld hl, wAttachedEnergies
	ld de, wLoadedAttackEnergyCost
	ld b, 0
	ld c, (NUM_TYPES / 2) - 1
.loop
	; check all basic energy cards except colorless
	ld a, [de]
	swap a
	call CalculateParticularAttachedEnergyNeeded
	ld a, [de]
	call CalculateParticularAttachedEnergyNeeded
	inc de
	dec c
	jr nz, .loop

	; colorless
	ld a, [de]
	swap a
	and %00001111
	ld b, a
	ld hl, wTempLoadedAttackEnergyCost
	ld a, [wTotalAttachedEnergies]
	sub [hl]
	sub b
	ret c ; return if not enough energy

	or a
	ret nz ; return if surplus energy

	; exactly the amount of energy needed
	scf
	ret

; takes as input the energy cost of an attack for a
; particular energy, stored in the lower nibble of a
; if the attack costs some amount of this energy, the lower nibble of a != 0,
; and this amount is stored in wTempLoadedAttackEnergyCost
; also adds the amount of energy still needed
; to wTempLoadedAttackEnergyNeededAmount
; input:
;	a    = this energy cost of attack (lower nibble)
;	[hl] = attached energy
; output:
;	carry set if not enough of this energy type attached
CalculateParticularAttachedEnergyNeeded:
	and %00001111
	jr nz, .check
.done
	inc hl
	inc b
	ret

.check
	ld [wTempLoadedAttackEnergyCost], a
	push hl
	ld hl, wAttachedEnergies + RAINBOW
	add [hl]
	pop hl
	sub [hl]
	jr z, .done
	jr nc, .done
	push bc
	ld a, [wTempLoadedAttackEnergyCost]
	push hl
	ld hl, wAttachedEnergies + RAINBOW
	add [hl]
	pop hl
	ld b, a
	ld a, [hl]
	sub b
	pop bc
	ld [wTempLoadedAttackEnergyNeededAmount], a
	jr .done

; returns carry if there exists input card ID
; in Bench that can use all its attacks
; input:
; - de = card ID
CheckIfPokemonInBenchHasEnoughEnergy:
	ld a, DUELVARS_BENCH
	get_turn_duelist_var
	ld c, PLAY_AREA_BENCH_1 - 1
	push hl
.loop
	inc c
	pop hl
	ld a, [hli]
	cp $ff
	jr z, .no_carry
	push hl
	push de
	push bc
	call GetCardIDFromDeckIndex
	pop bc
	ld b, d
	ld a, e
	pop de
	cp e
	jr nz, .loop
	ld a, b
	cp d
	jr nz, .loop
	; same card ID found in bench
	ld a, c
	ldh [hTempPlayAreaLocation_ff9d], a
	call GetHighestAttackIndex
	ld [wSelectedAttack], a
	push bc
	push de
	push hl
	farcall CheckIfSelectedAttackIsUnusable
	pop hl
	pop de
	pop bc
	jr c, .loop
	; can use its highest index attack
	pop hl
	ld a, c
	scf
	ret
.no_carry
	or a
	ret

; inputs:
; - de = card ID
CheckCardIDInPlayAreaThatCanUseAttacks:
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	ld c, -1
	push hl
.loop_play_area
	inc c
	pop hl
	ld a, [hli]
	cp $ff
	jr z, .no_carry
	push hl
	push de
	push bc
	call GetCardIDFromDeckIndex
	pop bc
	ld b, d
	ld a, e
	pop de
	cp e
	jr nz, .loop_play_area
	ld a, b
	cp d
	jr nz, .loop_play_area
	; is same as input card iD
	ld a, c
	ldh [hTempPlayAreaLocation_ff9d], a
	call GetHighestAttackIndex
	ld [wSelectedAttack], a
	push bc
	push de
	push hl
	farcall CheckIfSelectedAttackIsUnusable
	pop hl
	pop de
	pop bc
	jr c, .loop_play_area
	; attack is usable
	pop hl
	ld a, c
	scf
	ret
.no_carry
	or a
	ret

; attempts to find a random Pokémon card in hand that is
; not same as card ID given by de, and outputs its deck index
; input:
; - de = card ID
; output:
; - a = deck index of card found
; - carry set if found
FindDifferentPokemonCardInHand:
	farcall LookForCardIDInHandList
	jr c, .not_in_hand
	ld a, $fe
.not_in_hand
	; create a shuffled list of Hand cards
	push af
	call CreateHandCardList
	ld hl, wDuelTempList
	call CountCardsInDuelTempList
	call ShuffleCards
	pop af

	; find first card that is not the one found by LookForCardIDInHandList
	; and that is a Pokémon card
	ld c, a
	ld hl, wDuelTempList
.loop_hand
	ld a, [hli]
	cp $ff
	jr z, .none_found
	cp c
	jr z, .loop_hand
	ld b, a
	call LoadCardDataToBuffer1_FromDeckIndex
	ld a, [wLoadedCard1Type]
	cp TYPE_ENERGY
	jr nc, .loop_hand
	ld a, b
	scf
	ret
.none_found
	or a
	ret
; 0x49fda

SECTION "Bank 12@5fda", ROMX[$5fda], BANK[$12]

; return carry if Pokémon in Play Area
; has a specific energy card attached
; input:
; - a = PLAY_AREA_* constant
; - de = energy card ID
CheckIfHasSpecificEnergyAttached:
	push de
	call CreateArenaOrBenchEnergyCardList
	pop de
	jr c, .no_carry
	ld hl, wDuelTempList
.loop_energy_cards
	ld a, [hli]
	cp $ff
	jr z, .no_carry
	ld b, a
	push hl
	push bc
	push de
	call GetCardIDFromDeckIndex
	ld c, e
	ld a, d
	pop de
	cp d
	jr nz, .next_card
	ld a, c
	cp e
	jr nz, .next_card
	pop bc
	pop hl
	ld a, b
	scf
	ret
.next_card
	pop bc
	pop hl
	jr .loop_energy_cards
.no_carry
	or a
	ret
; 0x4a005

SECTION "Bank 12@62a0", ROMX[$62a0], BANK[$12]

; returns carry if Alakazam lv42 is found in Play Area
; with Pkmn Power active and outputs its Play Area location
FindAlakazamLv42WithActivePkmnPowerInPlayArea:
	ld c, PLAY_AREA_ARENA
.loop_play_area
	ld a, DUELVARS_ARENA_CARD
	add c
	get_turn_duelist_var
	cp $ff
	ret z ; no more Play Area Pokémon

	ld b, a ; deck index
	push bc
	ld a, c
	bank1call CheckIsIncapableOfUsingPkmnPower
	jr c, .next_pokemon
	pop bc
	push bc
	ld a, b
	call GetCardIDFromDeckIndex
	cp16 ALAKAZAM_LV42
	jr z, .found

.next_pokemon
	pop bc
	inc c
	ld a, [wMaxNumPlayAreaPokemon]
	cp c
	jr nz, .loop_play_area
	or a
	ret

.found
	pop bc
	ld a, c
	scf
	ret

AIHandlePkmnPowersWhenPlayingPkmnFromHand:
	ld a, [wTempAIPokemonCard]
	call GetCardIDFromDeckIndex
	cp16 GENGAR_LV40
	jr z, .power_of_darkness
	cp16 DARK_GOLBAT
	jr z, .sneak_attack
	cp16 DARK_DRAGONITE
	jr z, .summon_minions
	cp16 DARK_SLOWBRO
	jr z, .reel_in
	ret

.power_of_darkness
	ldtx de, PowerOfDarknessCheckText
	farcall Func_68079
	ldh [hTemp_ffa0], a
	call SwapTurn
	ld e, PLAY_AREA_ARENA
	call Func_4a3dc
	call SwapTurn
	ldh [hTempPlayAreaLocation_ffa1], a
	ret

.sneak_attack
	xor a
	ld d, 10
	farcall AIFindPlayAreaPkmnWithMinimumLeastRemainingHP
	ldh [hTemp_ffa0], a
	ld a, 10
	cp d
	ret z ; will ko
	; won't KO
	; if Arena card has even number of damage counters,
	; then choose to attack Defending card instead
	; this behavior is strange and possibly a bug.
	; presumably, the intended behavior is to check
	; if defending card has only 10 HP left
	ld a, DUELVARS_ARENA_CARD_HP
	get_turn_duelist_var
	farcall ConvertHPToCounters
	srl a
	ret c ; odd number
	xor a ; PLAY_AREA_ARENA
	ldh [hTemp_ffa0], a
	ret

.summon_minions
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	cp 4
	jr c, .less_than_4
	jr z, .exactly_4
	; 4 or more
	xor a
	jr .got_number_summon_minions_pkmn
.exactly_4
	ld a, 1
	jr .got_number_summon_minions_pkmn
.less_than_4
	ld a, 2
.got_number_summon_minions_pkmn
	farcall AIChooseSummonMinionsCards
	ret

.reel_in
	ld a, $ff
	ldh [hTemp_ffa0], a
	ldh [hTempPlayAreaLocation_ffa1], a
	ldh [hPlayAreaEffectTarget], a
	ldh [$ffa5], a
	ld a, [wOpponentDeckID]
	cp BAD_GUYS_DECK_ID
	jr z, .BadGuysDeck
	cp STRANGE_DECK_ID
	jr z, .StrangeDeck
	ret

.StrangeDeck
	ld bc, PSYDUCK_LV16
	ld de, DARK_GOLDUCK
	farcall Func_39a8b
	call c, .TryAddCardToList
	ld bc, SLOWPOKE_LV16
	ld de, DARK_SLOWBRO
	farcall Func_39a8b
	call c, .TryAddCardToList
	ld bc, DROWZEE_LV10
	ld de, DARK_HYPNO
	farcall Func_39a8b
	call c, .TryAddCardToList
	ret c
	ld de, MR_MIME_LV20
	ld a, CARD_LOCATION_DISCARD_PILE
	farcall FindCardIDInLocation
	call c, .TryAddCardToList
	ret c
	ld de, MR_MIME_LV28
	ld a, CARD_LOCATION_DISCARD_PILE
	farcall FindCardIDInLocation
	call c, .TryAddCardToList
	ret c
	ld de, MEOWTH_LV13
	ld a, CARD_LOCATION_DISCARD_PILE
	farcall FindCardIDInLocation
	call c, .TryAddCardToList
	ret c
	ld de, MEOWTH_LV14
	ld a, CARD_LOCATION_DISCARD_PILE
	farcall FindCardIDInLocation
	call c, .TryAddCardToList
	ret

.TryAddCardToList:
	ld b, a
	ld c, 0
	ld hl, hTemp_ffa0
.asm_4a3bf
	ld a, [hl]
	cp $ff
	jr nz, .asm_4a3cc
	inc hl
	inc c
	cp 3
	jr nz, .asm_4a3bf
	scf
	ret
.asm_4a3cc
	ld a, b
	ld [hli], a
	inc c
	cp 3
	jr nz, .asm_4a3d5
	scf
	ret
.asm_4a3d5
	or a
	ret

.BadGuysDeck:
	farcall BadGuysDeckAIDecideReelIn
	ret

; finds card with highest number of attached energies
; and, in case of tie, outputs the card with highest
; remaining HP
; input:
; - e = PLAY_AREA_* constant to start looking from
; output:
; - a = PLAY_AREA_* constant chosen
Func_4a3dc:
	xor a
	ld d, MAX_PLAY_AREA_POKEMON * 2
	ld hl, wCurDeckCards
.loop_clear
	ld [hli], a
	dec d
	jr nz, .loop_clear

	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	cp e
	jr nz, .asm_4a3ee
	xor a
	ret
.asm_4a3ee
	ld d, a ; number of Pokémon in Play Area
	ld b, 0
.loop_play_area
	call GetPlayAreaCardAttachedEnergies
	ld a, [wTotalAttachedEnergies]
	cp b
	jr c, .not_max
	ld b, a ; max num attached energies
.not_max
	push bc
	ld c, e
	ld b, $00
	ld hl, wCurDeckCards
	add hl, bc
	ld [hli], a ; num attached energies
	ld [hl], $ff ; terminating byte
	ld a, e
	add DUELVARS_ARENA_CARD_HP
	get_turn_duelist_var
	ld hl, $d1ca
	add hl, bc
	pop bc
	ld [hl], a ; num remaining HP
	inc e
	ld a, e
	cp d
	jr nz, .loop_play_area

	xor a
	ld e, a
	ld d, a
	ld c, a
.loop_candidates
	push bc
	ld c, e
	ld b, $00
	ld hl, wCurDeckCards
	add hl, bc
	ld a, [hl]
	cp $ff
	jr z, .done
	pop bc
	cp b
	jr nz, .next_candidate ; not max
	; is the max number found
	push bc
	ld c, e
	ld b, $00
	ld hl, $d1ca
	add hl, bc
	ld a, [hl]
	pop bc
	cp c
	jr c, .next_candidate ; lower remaining HP
	jr z, .next_candidate ; same remaining HP
	; higher remaining HP
	ld c, a
	ld d, e
.next_candidate
	inc e
	jr nz, .loop_candidates
.done
	pop bc
	ld a, d ; output chosen card location
	ret
; 0x4a441

SECTION "Bank 12@64ae", ROMX[$64ae], BANK[$12]

CountNumberOfBasicPokemonInDuelTempList:
.loop
	ld a, [hli]
	cp $ff
	ret z
	call LoadCardDataToBuffer1_FromDeckIndex
	ld a, [wLoadedCard1Type]
	cp TYPE_ENERGY
	jr nc, .loop
	ld a, [wLoadedCard1Stage]
	or a
	jr nz, .loop
	ld a, [wTempAI]
	inc a
	ld [wTempAI], a
	jr .loop

; outputs in a the number of Basic Pokémon cards in Hand
CountNumberOfBasicPokemonInHand:
	xor a
	ld [wTempAI], a
	call CreateHandCardList
	ld hl, wDuelTempList
	call CountNumberOfBasicPokemonInDuelTempList
	ld a, [wTempAI]
	ret
; 0x4a4dc

SECTION "Bank 12@6cba", ROMX[$6cba], BANK[$12]

Func_4acba:
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call GetCardIDFromDeckIndex
	ld a, e
	ld [wTempTurnDuelistCardID + 0], a
	ld a, d
	ld [wTempTurnDuelistCardID + 1], a
	call SwapTurn
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call GetCardIDFromDeckIndex
	ld a, e
	ld [wTempNonTurnDuelistCardID + 0], a
	ld a, d
	ld [wTempNonTurnDuelistCardID + 1], a
	xor a
	ld [wLoadedAttackCategory], a
	bank1call HandleNoDamageOrEffectSubstatus
	call SwapTurn
	ret
; 0x4ace4

SECTION "Bank 12@7029", ROMX[$7029], BANK[$12]

AIDecideFirefoxTarget:
	farcall CheckIfArenaCardCanKnockOutDefendingCard
	jr nc, .cannot_ko
.no_carry
	xor a
	ret
.cannot_ko
	xor a ; PLAY_AREA_ARENA
	call SwapTurn
	farcall CheckIfCanDamageDefendingPokemon
	call SwapTurn
	jr nc, .no_carry ; cannot damage
	cp 20
	jr c, .no_carry
	call AIChoosePlayerBenchPkmnWithNotEnoughEnergiesOrHighRetreatCost
	jr nc, .no_carry
	; chose a target
	ret

AIChoosePlayerBenchPkmnWithNotEnoughEnergiesOrHighRetreatCost:
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	call GetNonTurnDuelistVariable
	cp 1
	ret z ; no Bench
	ld d, a
	ld e, PLAY_AREA_BENCH_1
	call SwapTurn
.loop_bench
	ld a, e
	ldh [hTempPlayAreaLocation_ff9d], a
	push de
	call .CheckIfNotEnoughEnergiesToAttack
	jr c, .chose_target
	call GetPlayAreaCardRetreatCost
	cp 2
	jr nc, .chose_target ; at least 2 energy retreat cost
	pop de
	inc e
	ld a, e
	cp d
	jr nz, .loop_bench
	call SwapTurn
	or a
	ret
.chose_target
	pop de
	call SwapTurn
	ld a, e
	scf
	ret

.CheckIfNotEnoughEnergiesToAttack:
	xor a ; FIRST_ATTACK_OR_PKMN_POWER
	ld [wSelectedAttack], a
	farcall CheckEnergyNeededForAttack
	jr nc, .asm_4b09b ; enough energy
	ld a, b
	add c
	cp 2
	jr c, .asm_4b09b ; only needs 1 energy
	ld a, SECOND_ATTACK
	ld [wSelectedAttack], a
	farcall CheckEnergyNeededForAttack
	jr nc, .asm_4b09b ; enough energy
	ld a, b
	add c
	cp 2
	jr c, .asm_4b09b ; only needs 1 energy
	; neither attack has enough energy
	; and both need at least 2 more energies
	scf
	ret

.asm_4b09b
	or a
	ret
; 0x4b09d

SECTION "Bank 12@73f3", ROMX[$73f3], BANK[$12]

; finds a Bench card in player's Play Area that:
; - is different type than input register a
; - doesn't have any energy cards
; - needs energy cards to use any of its attacks
; also finds the card that needs most energy cards
; return carry if such a target is found
; input:
; - a = color constant
; output:
; - a = PLAY_AREA_* constant of target
; - carry set if found a target
AIChooseFollowMeTarget:
	ld [wd079], a

	; save value of hTempPlayAreaLocation_ff9d in the stack
	ldh a, [hTempPlayAreaLocation_ff9d]
	push af
	call SwapTurn
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	ld d, a
	ld e, PLAY_AREA_BENCH_1
	lb bc, 0, PLAY_AREA_ARENA
.loop_play_area
	push bc
	ld a, e
	bank1call GetPlayAreaCardColor
	ld hl, wd079
	cp [hl]
	jr z, .skip_pkmn
	call GetPlayAreaCardAttachedEnergies
	ld a, [wTotalAttachedEnergies]
	or a
	jr nz, .skip_pkmn ; has energy cards
	ld a, e
	push de
	call CheckIfPlayAreaCardNeedsEnergyForAnyAttack
	pop de
	jr nc, .skip_pkmn ; doesn't need energy
	pop bc
	cp b
	jr c, .next_play_area_pkmn
	jr z, .next_play_area_pkmn
	ld b, a
	ld c, e
	jr .next_play_area_pkmn
.skip_pkmn
	pop bc
.next_play_area_pkmn
	inc e
	ld a, e
	cp d
	jr nz, .loop_play_area
	call SwapTurn
	pop af
	ldh [hTempPlayAreaLocation_ff9d], a
	ld a, c
	or a
	ret z
	scf
	ret

; input:
; - a = PLAY_AREA_* constant
CheckIfPlayAreaCardNeedsEnergyForAnyAttack:
	ldh [hTempPlayAreaLocation_ff9d], a
	xor a ; FIRST_ATTACK_OR_PKMN_POWER
	ld [wSelectedAttack], a
	farcall CheckEnergyNeededForAttack
	jr c, .got_num_energies_needed_1
	lb bc, 0, 0 ; doesn't need any energy
.got_num_energies_needed_1
	ld a, b
	add c
	push af
	ld a, SECOND_ATTACK
	ld [wSelectedAttack], a
	farcall CheckEnergyNeededForAttack
	jr c, .got_num_energies_needed_2
	lb bc, 0, 0 ; doesn't need any energy
.got_num_energies_needed_2
	ld a, b
	add c
	pop bc
	cp b
	jr nc, .carry_if_non_zero
	ld a, b
.carry_if_non_zero
	; a = max(a, b)
	or a
	ret z
	scf
	ret

; looks for Double Colorless energy attached to
; card in input register a
; if found, output its deck index and carry set
FindDoubleColorlessAttachedToCard:
	call CreateArenaOrBenchEnergyCardList
	ld hl, wDuelTempList
.loop_energy_cards
	ld a, [hli]
	cp $ff
	ret z ; no double colorless
	ld [wd072], a
	push hl
	call GetCardIDFromDeckIndex
	cp16 DOUBLE_COLORLESS_ENERGY
	pop hl
	jr nz, .loop_energy_cards
	ld a, [wd072]
	scf
	ret

; returns carry if Pokémon in Play Area location
; given by register does not have full HP
; input:
; - a = PLAY_AREA_* constant
CheckIfPokemonHasDamage:
	push af
	add DUELVARS_ARENA_CARD_HP
	get_turn_duelist_var
	ld b, a ; remaining HP
	pop af
	add DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call LoadCardDataToBuffer1_FromDeckIndex
	ld a, [wLoadedCard1HP]
	sub b
	or a
	ret z ; full HP, no carry
	scf
	ret

; returns carry if any Pokémon in
; turn-holder's Play Area has damage
CheckIfAnyPlayAreaPokemonHasDamage:
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	ld e, PLAY_AREA_ARENA
.loop_play_area
	ld a, [hli]
	cp $ff
	ret z ; no carry
	push de
	push hl
	ld a, e
	call CheckIfPokemonHasDamage
	pop hl
	pop de
	ret c ; return carry
	inc e
	jr .loop_play_area

CheckIfPlayerHasAuroraVeilActive:
	call SwapTurn
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call GetCardIDFromDeckIndex
	cp16 ARTICUNO_LV34
	jr nz, .not_active
	xor a
	bank1call CheckIsIncapableOfUsingPkmnPower
	jr c, .not_active
	call SwapTurn
	scf
	ret
.not_active
	call SwapTurn
	or a
	ret

AddDefenderDamageReductionOfPlayAreaPokemon:
	push af
	ld a, e
	add DUELVARS_ARENA_CARD_ATTACHED_DEFENDER
	call GetNonTurnDuelistVariable
	ld l, a
	ld h, 20
	call HtimesL
	pop af
	add l
	ret
; 0x4b4e4

SECTION "Bank 12@79f4", ROMX[$79f4], BANK[$12]

; input:
; - de = card ID
Func_4b9f4:
	push de
	farcall LookForCardIDInHandList
	pop de
	ccf
	ret nc ; found in Hand
	ld a, CARD_LOCATION_DECK
	farcall FindCardIDInLocation
	ret nc ; not found in Deck

	; card ID is in Deck and not in Hand
	push af
	call .Func_4ba0b
	pop bc
	ret nc
	ld a, b
	ret

.Func_4ba0b:
	ld [wTempAIPokemonCard], a
	bank1call IsPrehistoricPowerActive
	ccf
	ret nc ; Prehistoric Power is active
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	ld d, a
	ld e, PLAY_AREA_ARENA
.loop_play_area
	push de
	ld a, [wTempAIPokemonCard]
	ld d, a
	call CheckIfCanEvolveInto
	pop de
	jr c, .next_pokemon
	push de
	ld a, e
	farcall Func_16af1
	pop de
	ret c
.next_pokemon
	inc e
	ld a, e
	cp d
	jr nz, .loop_play_area
	or a
	ret
; 0x4ba33

SECTION "Bank 12@7a4d", ROMX[$7a4d], BANK[$12]

; input:
; - a = PLAY_AREA* location
; output:
; - a = deck index of Basic energy card, if any
; - carry set if no energies or no Basic energy cards attached
GetFirstBasicEnergyAttachedToPlayAreaCard:
	call CreateArenaOrBenchEnergyCardList
	ret c ; no energies
	ld hl, wDuelTempList
.loop_energies
	ld a, [hli]
	cp $ff
	jr z, .no_basic_energy
	push hl
	call GetCardIDFromDeckIndex
	pop hl
	cp16 DOUBLE_COLORLESS_ENERGY
	jr z, .loop_energies
	cp16 RAINBOW_ENERGY
	jr z, .loop_energies
	cp16 POTION_ENERGY
	jr z, .loop_energies
	cp16 FULLHEAL_ENERGY
	jr z, .loop_energies
	cp16 RECYCLE_ENERGY
	jr z, .loop_energies
	; found Basic energy
	dec hl
	ld a, [hl]
	or a
	ret
.no_basic_energy
	scf
	ret

CheckIfHasZapdosLv68WithLessThan3Energies:
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	ld e, PLAY_AREA_ARENA - 1
.loop_play_area
	inc e
	ld a, [hli]
	cp $ff
	ret z
	push de
	push hl
	call GetCardIDFromDeckIndex
	pop hl
	cp16 ZAPDOS_LV68
	pop de
	jr nz, .loop_play_area
	; is Zapdos lv68
	call GetPlayAreaCardAttachedEnergies
	ld a, [wTotalAttachedEnergies]
	cp 3
	jr nc, .loop_play_area
	scf
	ret

; returns carry if there's a Ditto in the Play Area
; that does not yet have 3 energy cards attached
CheckIfHasDittoWithLessThan3Energies:
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	ld e, PLAY_AREA_ARENA - 1
.loop_play_area
	inc e
	ld a, [hli]
	cp $ff
	ret z
	push de
	push hl
	call GetCardIDFromDeckIndex
	pop hl
	cp16 DITTO
	pop de
	jr nz, .loop_play_area
	; is Ditto
	call GetPlayAreaCardAttachedEnergies
	ld a, [wTotalAttachedEnergies]
	cp 3
	jr nc, .loop_play_area
	scf
	ret
; 0x4bae4

SECTION "Bank 12@7d72", ROMX[$7d72], BANK[$12]

Func_4bd72:
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	ld b, a
	ld c, PLAY_AREA_ARENA
.loop_play_area
	ld a, DUELVARS_ARENA_CARD
	add c
	get_turn_duelist_var
	ld [wd084], a
	call GetCardIDFromDeckIndex
	push bc
	cp16 DARK_DRAGONAIR
	jr nz, .next_pokemon ; not Dark Dragonair
	push bc
	ld a, c
	ldh [hTempPlayAreaLocation_ff9d], a
	ld a, [wd084]
	ld d, a
	ld e, FIRST_ATTACK_OR_PKMN_POWER
	call CopyAttackDataAndDamage_FromDeckIndex
	ld a, EFFECTCMDTYPE_INITIAL_EFFECT_2
	call TryExecuteEffectCommandFunction
	pop bc
	jr c, .next_pokemon
	ld a, c
	bank1call CheckIsIncapableOfUsingPkmnPower
	jr c, .next_pokemon
	; can use Evolutionary Light
	pop bc
	ld a, [wd084]
	scf
	ret
.next_pokemon
	pop bc
	inc c
	ld a, c
	cp b
	jr nz, .loop_play_area
	or a
	ret
; 0x4bdb6

SECTION "Bank 12@7e55", ROMX[$7e55], BANK[$12]

FindUnusableEvolutionCardInHand:
	call CreateHandCardList
	ld hl, wDuelTempList
.loop_hand_cards
	ld a, [hli]
	cp $ff
	ret z
	push hl
	ld d, a
	ld e, PLAY_AREA_ARENA
.loop_play_area
	farcall CheckIfEvolvesInto
	jr nc, .next_card ; is evolution of Play Area Pokémon
	inc e
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	cp e
	jr nz, .loop_play_area
	; doesn't evolve any card in Play Area
	ld a, [wLoadedCard1Type]
	cp TYPE_ENERGY
	jr nc, .next_card ; not a Pokémon card
	ld a, [wLoadedCard1Stage]
	or a
	jr z, .next_card ; is a Basic card
	pop hl
	ld a, d
	scf
	ret
.next_card
	pop hl
	jr .loop_hand_cards

CheckUseZapdosThunderboltInTenThousandVoltsDeck:
	ld a, [wOpponentDeckID]
	cp TEN_THOUSAND_VOLTS_DECK_ID
	jr z, .ten_thousand_volts_deck
.no_carry
	or a
	ret

.ten_thousand_volts_deck
; only use Zapdos' Thunderbolt if it would be
; knocked out in the next turn
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call GetCardIDFromDeckIndex
	cp16 ZAPDOS_LV64
	jr nz, .no_carry
	xor a ; PLAY_AREA_ARENA
	ldh [hTempPlayAreaLocation_ff9d], a
	farcall CheckIfDefendingPokemonCanKnockOut
	ret ; carry set if can KO
; 0x4bea5

SECTION "Bank 12@7f14", ROMX[$7f14], BANK[$12]

CreateEnergyCardListFromHand_OnlyBasic:
	bank1call CreateEnergyCardListFromHand
	ret c ; no energy cards
	push hl
	push de
	push bc
	ld hl, wDuelTempList
.loop_cards
	ld a, [hli]
	cp $ff
	jr z, .asm_4bf5f
	push hl
	call GetCardIDFromDeckIndex
	pop hl
	cp16 DOUBLE_COLORLESS_ENERGY
	jr z, .remove_card
	cp16 RAINBOW_ENERGY
	jr z, .remove_card
	cp16 POTION_ENERGY
	jr z, .remove_card
	cp16 FULLHEAL_ENERGY
	jr nz, .loop_cards
.remove_card
	push hl
	ld c, l
	ld b, h
	dec bc
.loop_remove
	ld a, [hli]
	ld [bc], a
	inc bc
	cp $ff
	jr nz, .loop_remove
	pop hl
	dec hl
	jr .loop_cards
.asm_4bf5f
	pop bc
	pop de
	pop hl
	ld a, [wDuelTempList]
	cp $ff
	jr z, .empty
; at least 1 card remaining
	or a
	ret
.empty
	scf
	ret
; 0x4bf6d

SECTION "Bank 12@7fa8", ROMX[$7fa8], BANK[$12]

; returns SECOND_ATTACK if card has a second attack
; otherwise returns FIRST_ATTACK_OR_PKMN_POWER
; input:
; - a = PLAY_AREA_* constant
GetHighestAttackIndex:
	push hl
	push de
	push bc
	add DUELVARS_ARENA_CARD
	get_turn_duelist_var
	ld d, a
	ld e, SECOND_ATTACK
	call CopyAttackDataAndDamage_FromDeckIndex
	ld hl, wLoadedAttackName
	ld a, [hli]
	or [hl]
	jr z, .no_second_attack
	pop bc
	pop de
	pop hl
	ld a, SECOND_ATTACK
	ret
.no_second_attack
	pop bc
	pop de
	pop hl
	xor a ; FIRST_ATTACK_OR_PKMN_POWER
	ret
; 0x4bfc6
