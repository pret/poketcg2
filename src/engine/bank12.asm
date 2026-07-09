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
	ld a, OPPACTION_PROCESS_PLAYED_PKMN
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
	ld a, OPPACTION_PROCESS_PLAYED_PKMN
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
	ld a, OPPACTION_PROCESS_PLAYED_PKMN
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
	ld a, OPPACTION_PROCESS_PLAYED_PKMN
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
	ld a, OPPACTION_PROCESS_PLAYED_PKMN
	farcall AIMakeDecision
	call AIHandlePkmnPowersWhenPlayingPkmnFromHand
	ld a, OPPACTION_PROCESS_TRIGGERED_PKMN_POWER
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
	ld a, OPPACTION_PROCESS_PLAYED_PKMN
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

AIDecide_MoonStone_RonaldsUltraDeck:
	call CountPrizes
	cp 4
	jr c, .prefer_pidgeot_line
	call .CheckFearowLine
	ret c
	call .CheckPidgeotLine
	ret
.prefer_pidgeot_line
	call .CheckPidgeotLine
	ret c
	call .CheckFearowLine
	ret

.CheckFearowLine:
	ld bc, SPEAROW_LV13
	ld de, FEAROW_LV27
	farcall LookForEvoCardInDeck_GivenPreevoInHandOrPlayArea
	ret

.CheckPidgeotLine:
	ld bc, PIDGEY_LV10
	ld de, PIDGEOTTO_LV38
	farcall LookForEvoCardInDeck_GivenPreevoInHandOrPlayArea
	ret c
	ld bc, PIDGEOTTO_LV38
	ld de, PIDGEOT_LV40
	farcall LookForEvoCardInDeck_GivenPreevoInHandOrPlayArea
	ret

AIDecide_PokemonTrader_RonaldsUltraDeck:
	ld bc, PIDGEY_LV10
	ld de, PIDGEOTTO_LV38
	farcall LookForEvoCardInDeck_GivenPreevoInHandOrPlayArea
	jr c, .found
	ld bc, PIDGEOTTO_LV38
	ld de, PIDGEOT_LV40
	farcall LookForEvoCardInDeck_GivenPreevoInHandOrPlayArea
	jr c, .found
	ld de, PIDGEY_LV10
	ld bc, PIDGEOTTO_LV38
	farcall LookForCardIDInDeck_GivenCardIDInHand
	ld de, PIDGEOTTO_LV38
	jr c, .found
	ld de, PIDGEOTTO_LV38
	ld bc, PIDGEOT_LV40
	farcall LookForCardIDInDeck_GivenCardIDInHand
	ld de, PIDGEOT_LV40
	jr c, .found
	ld bc, SPEAROW_LV13
	ld de, FEAROW_LV27
	farcall LookForEvoCardInDeck_GivenPreevoInHandOrPlayArea
	jr c, .found
	ld de, SPEAROW_LV13
	ld bc, FEAROW_LV27
	farcall LookForCardIDInDeck_GivenCardIDInHand
	ld de, FEAROW_LV27
	ret nc

.found
	ld [wTempAIMultiTargetCardDeckIndex1], a
	call FindDifferentPokemonCardInHand
	ret

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
	ld b, AI_SCORE_NEUTRAL
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
	ld b, AI_SCORE_NEUTRAL - 5
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
	ld b, AI_SCORE_NEUTRAL + 2
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
	ld b, AI_SCORE_NEUTRAL + 5
	jp .got_score

.asm_4895d
	ld b, AI_SCORE_NEUTRAL - 20
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
	ld b, AI_SCORE_NEUTRAL + 10
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
	call FindCardIDInBenchWithEnoughEnergy
	jr c, .asm_489bc
	ld de, IVYSAUR_LV26
	call FindCardIDInBenchWithEnoughEnergy
	jp nc, .asm_489c1 ; can be jr
	; Venomoth and Ivysaur can already use
	; all their attacks
.asm_489bc
	ld b, AI_SCORE_NEUTRAL + 5
	jp .got_score

.asm_489c1
	ld b, AI_SCORE_NEUTRAL - 28
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
	call FindCardIDInBenchWithEnoughEnergy
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
	call FindCardIDInBenchWithEnoughEnergy
	jp nc, .default_score ; Weezing still needs energy
	farcall CountNumberOfSetUpBenchPokemon
	cp 2
	jp c, .default_score
	; at least 2 set up bench Pokémon
	ld b, AI_SCORE_NEUTRAL + 25
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
	call FindCardIDInBenchWithEnoughEnergy
	jp nc, .asm_48a5b ; Arcanine still needs energy
	xor a
	ld [wd032], a
.asm_48a56
	ld b, AI_SCORE_NEUTRAL + 13
	jp .got_score

.asm_48a5b
	ld b, AI_SCORE_NEUTRAL - 28
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
	call FindCardIDInBenchWithEnoughEnergy
	jr c, .asm_48a9d
	ld de, CHARIZARD_ALT_LV76
	call FindCardIDInBenchWithEnoughEnergy
	jp nc, .default_score
	; Charizard can already use all attacks
	xor a
	ld [wd032], a
.asm_48a9d
	ld b, AI_SCORE_NEUTRAL + 13
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
	call FindCardIDInBenchWithEnoughEnergy
	jr c, .asm_48adf
	ld de, DARK_VILEPLUME
	call FindCardIDInBenchWithEnoughEnergy
	jp c, .default_score
	; Vileplume can already use all attacks
	xor a
	ld [wd032], a
.asm_48adf
	ld b, AI_SCORE_NEUTRAL + 13
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
	ld b, AI_SCORE_NEUTRAL + 13
	jp .got_score
.asm_48b1d
	ld b, AI_SCORE_NEUTRAL - 8
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
	call FindCardIDInBenchWithEnoughEnergy
	jp nc, .default_score
	xor a
	ld [wd032], a
.asm_48b57
	ld b, AI_SCORE_NEUTRAL + 13
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
	ld b, AI_SCORE_NEUTRAL + 13
	jp .got_score
.asm_48b9f
	ld b, AI_SCORE_NEUTRAL - 8
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
	call FindCardIDInBenchWithEnoughEnergy
	jr nc, .asm_48be5
	ld b, PLAY_AREA_BENCH_1
	ld de, DROWZEE_LV10
	farcall FindCardIDInTurnDuelistsPlayArea
	jr nc, .asm_48be5
	xor a
	ld [wd032], a
.asm_48be0
	ld b, AI_SCORE_NEUTRAL + 13
	jp .got_score
.asm_48be5
	ld b, AI_SCORE_NEUTRAL - 8
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
	call FindCardIDInBenchWithEnoughEnergy
	jp nc, .default_score
	xor a
	ld [wd032], a
.asm_48c1f
	ld b, AI_SCORE_NEUTRAL + 13
	jp .got_score

.UltraRemovalDeck:
	farcall CheckIfHasRainDanceActive
	jp nc, .default_score
	ldh a, [hTempPlayAreaLocation_ff9d]
	or a
	jp z, .default_score
	; Rain Dance is active and this
	; card is not Arena card
	ld b, AI_SCORE_NEUTRAL - 50
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
	call FindCardIDInBenchWithEnoughEnergy
	jp nc, .default_score
	xor a
	ld [wd032], a
.asm_48c75
	ld b, AI_SCORE_NEUTRAL + 13
	jp .got_score

.dark_dragonair
	ld b, AI_SCORE_NEUTRAL + 3
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
	call FindCardIDInBenchWithEnoughEnergy
	jp nc, .default_score
	xor a
	ld [wd032], a
.asm_48cc1
	ld b, AI_SCORE_NEUTRAL + 13
	jp .got_score

.dark_charizard
	call FindDarkCharizardToAttachEnergy
	jp nc, .default_score
	ld b, a
	ldh a, [hTempPlayAreaLocation_ff9d]
	cp b
	jr z, .asm_48cd7
	ld b, AI_SCORE_NEUTRAL - 28
	jp .got_score
.asm_48cd7
	ld b, AI_SCORE_NEUTRAL + 3
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
	ld b, AI_SCORE_NEUTRAL + 13
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
	call FindCardIDInBenchWithEnoughEnergy
	jp nc, .default_score
	xor a
	ld [wd032], a
.asm_48d3e
	ld b, AI_SCORE_NEUTRAL + 13
	jp .got_score

.chansey_lv55
	ldh a, [hTempPlayAreaLocation_ff9d]
	ld e, a
	ld de, DARK_MACHAMP
	call FindCardIDInBenchWithEnoughEnergy
	jp nc, .default_score
	farcall CountNumberOfSetUpBenchPokemon
	cp 2
	jp c, .default_score
	ld b, AI_SCORE_NEUTRAL + 4
	jp .got_score

.TestYourLuckDeck:
	ldh a, [hTempPlayAreaLocation_ff9d]
	add DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call GetCardIDFromDeckIndex
	cp16 MOLTRES_LV35
	jp nz, .default_score
	ld b, AI_SCORE_NEUTRAL + 5
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
	ld a, AI_SCORE_NEUTRAL - 28
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
	ld b, AI_SCORE_NEUTRAL - 28
	jp .got_score
.asm_48e00
	ld b, AI_SCORE_NEUTRAL + 13
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
	ld b, AI_SCORE_NEUTRAL + 3
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
	ld b, AI_SCORE_NEUTRAL + 5
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
	ld b, AI_SCORE_NEUTRAL + 13
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
	ld b, AI_SCORE_NEUTRAL + 13
	jp .got_score
.asm_48ea2
	ld b, AI_SCORE_NEUTRAL - 28
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
	ld b, AI_SCORE_NEUTRAL + 13
	jp .got_score
.asm_48eec
	ld b, AI_SCORE_NEUTRAL - 8
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
	ld a, AI_SCORE_NEUTRAL
	ret

.SteadyIncreaseDeck:
	xor a ; PLAY_AREA_ARENA
	ldh [hTempPlayAreaLocation_ff9d], a
	farcall CheckIfDefendingPokemonCanKnockOut
	jr nc, .default
	; can KO defending card
	ld a, AI_SCORE_NEUTRAL + 3
	ret

.GreatDragonDeck
	ld a, [wPreviousAIFlags]
	and AI_FLAG_UNK_5
	jr z, .default
	ld a, AI_SCORE_NEUTRAL + 10
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
	ld a, AI_SCORE_NEUTRAL - 58
	ret
.at_least_8_psychic_energy_cards
	ld a, AI_SCORE_NEUTRAL + 10
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
	farcall CanArenaCardUseNonResidualAttack
	jr c, .asm_48f81 ; can use non-Residual
.asm_48f7b
	call SwapTurn
	ld a, AI_SCORE_NEUTRAL
	ret
.asm_48f81
	call SwapTurn
	ld a, AI_SCORE_NEUTRAL + 10
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
	ld a, AI_SCORE_NEUTRAL - 58
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
	ld a, AI_SCORE_NEUTRAL + 10
	ret

.kadabra_lv39
	ld de, ALAKAZAM_LV42
	ld b, PLAY_AREA_BENCH_1
	farcall FindCardIDInTurnDuelistsPlayArea
	jp c, .default
	; Alakazam is not in Bench
	ld a, AI_SCORE_NEUTRAL + 10
	ret

.mr_mime_lv28
	ld a, DUELVARS_ARENA_CARD_HP
	get_turn_duelist_var
	cp 20 + 1
	jp nc, .default
	; Mr. Mime has <= 20 HP remaining
	ld a, AI_SCORE_NEUTRAL + 10
	ret

.BigThunderDeck:
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call GetCardIDFromDeckIndex
	cp16 ZAPDOS_LV68
	jp z, .default
	ld de, ZAPDOS_LV68
	call FindCardIDInBenchWithEnoughEnergy
	jp nc, .default
	; another Zapdos in Bench has enough energy cards
	ld a, AI_SCORE_NEUTRAL + 10
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
	farcall IsCardIDInHandOrPlayArea
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
	farcall IsCardIDInHandOrPlayArea
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
	farcall LookForEvoCardInDeck_GivenPreevoInPlayArea
	jp c, AITryUseTheBossWayToSearchCard
	ld bc, BULBASAUR_LV12
	ld de, DARK_IVYSAUR
	farcall LookForEvoCardInDeck_GivenPreevoInPlayArea
	jp c, AITryUseTheBossWayToSearchCard
	ld bc, DRATINI_LV10
	ld de, DARK_DRAGONAIR
	farcall LookForEvoCardInDeck_GivenPreevoInPlayArea
	jp c, AITryUseTheBossWayToSearchCard
	ret

.use_pokemon_trader_instead_1
	; otherwise try using Pokémon Trader instead
	ld bc, DARK_IVYSAUR
	ld de, DARK_VENUSAUR
	farcall LookForEvoCardInDeck_GivenPreevoInPlayArea
	ld de, DARK_VENUSAUR
	jp c, AITryUsePokemonTraderToSearchCard
	ld bc, BULBASAUR_LV12
	ld de, DARK_IVYSAUR
	farcall LookForEvoCardInDeck_GivenPreevoInPlayArea
	ld de, DARK_IVYSAUR
	jp c, AITryUsePokemonTraderToSearchCard
	ld bc, DRATINI_LV10
	ld de, DARK_DRAGONAIR
	farcall LookForEvoCardInDeck_GivenPreevoInPlayArea
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
	farcall IsCardIDInHandOrPlayArea
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
	farcall LookForEvoCardInDeck_GivenPreevoInPlayArea
	jp c, AITryUseTheBossWayToSearchCard
	ld bc, CHARMANDER_LV9
	ld de, DARK_CHARMELEON
	farcall LookForEvoCardInDeck_GivenPreevoInPlayArea
	jp c, AITryUseTheBossWayToSearchCard
	ld bc, CLEFAIRY_LV15
	ld de, DARK_CLEFABLE
	farcall LookForEvoCardInDeck_GivenPreevoInPlayArea
	jp c, AITryUseTheBossWayToSearchCard
	ret

.use_pokemon_trader_instead_2
	; otherwise try using Pokémon Trader instead
	ld bc, DARK_CHARMELEON
	ld de, DARK_CHARIZARD
	farcall LookForEvoCardInDeck_GivenPreevoInPlayArea
	ld de, DARK_CHARIZARD
	jp c, AITryUsePokemonTraderToSearchCard
	ld bc, CHARMANDER_LV9
	ld de, DARK_CHARMELEON
	farcall LookForEvoCardInDeck_GivenPreevoInPlayArea
	ld de, DARK_CHARMELEON
	jp c, AITryUsePokemonTraderToSearchCard
	ld bc, CLEFAIRY_LV15
	ld de, DARK_CLEFABLE
	farcall LookForEvoCardInDeck_GivenPreevoInPlayArea
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
	farcall IsCardIDInHandOrPlayArea
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
	farcall LookForEvoCardInDeck_GivenPreevoInPlayArea
	jp c, AITryUseTheBossWayToSearchCard
	ld bc, SQUIRTLE_LV8
	ld de, DARK_WARTORTLE
	farcall LookForEvoCardInDeck_GivenPreevoInPlayArea
	jp c, AITryUseTheBossWayToSearchCard
	ld bc, CLEFAIRY_LV15
	ld de, DARK_CLEFABLE
	farcall LookForEvoCardInDeck_GivenPreevoInPlayArea
	jp c, AITryUseTheBossWayToSearchCard
	ret

.use_pokemon_trader_instead_3
	; otherwise try using Pokémon Trader instead
	ld bc, DARK_WARTORTLE
	ld de, DARK_BLASTOISE
	farcall LookForEvoCardInDeck_GivenPreevoInPlayArea
	ld de, DARK_BLASTOISE
	jp c, AITryUsePokemonTraderToSearchCard
	ld bc, SQUIRTLE_LV8
	ld de, DARK_WARTORTLE
	farcall LookForEvoCardInDeck_GivenPreevoInPlayArea
	ld de, DARK_WARTORTLE
	jp c, AITryUsePokemonTraderToSearchCard
	ld bc, CLEFAIRY_LV15
	ld de, DARK_CLEFABLE
	farcall LookForEvoCardInDeck_GivenPreevoInPlayArea
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
	farcall IsCardIDInHandOrPlayArea
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
	farcall LookForEvoCardInDeck_GivenPreevoInPlayArea
	jp c, AITryUseTheBossWayToSearchCard
	ld bc, MACHOP_LV20
	ld de, DARK_MACHOKE
	farcall LookForEvoCardInDeck_GivenPreevoInPlayArea
	jp c, AITryUseTheBossWayToSearchCard
	ld bc, CLEFAIRY_LV15
	ld de, DARK_CLEFABLE
	farcall LookForEvoCardInDeck_GivenPreevoInPlayArea
	jp c, AITryUseTheBossWayToSearchCard
	ret

.use_pokemon_trader_instead_4
	; otherwise try using Pokémon Trader instead
	ld bc, DARK_MACHOKE
	ld de, DARK_MACHAMP
	farcall LookForEvoCardInDeck_GivenPreevoInPlayArea
	ld de, DARK_MACHAMP
	jp c, AITryUsePokemonTraderToSearchCard
	ld bc, MACHOP_LV20
	ld de, DARK_MACHOKE
	farcall LookForEvoCardInDeck_GivenPreevoInPlayArea
	ld de, DARK_MACHOKE
	jp c, AITryUsePokemonTraderToSearchCard
	ld bc, CLEFAIRY_LV15
	ld de, DARK_CLEFABLE
	farcall LookForEvoCardInDeck_GivenPreevoInPlayArea
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
	call CanUseEvolutionaryLight
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
	call CanUseEvolutionaryLight
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
	farcall LookForEvoCardInDeck_GivenPreevoInPlayArea
	jp c, AITryUseTheBossWayToSearchCard
	ld bc, PSYDUCK_LV16
	ld de, DARK_GOLDUCK
	farcall LookForEvoCardInDeck_GivenPreevoInPlayArea
	jp c, AITryUseTheBossWayToSearchCard
	ld bc, DRATINI_LV12
	ld de, DARK_DRAGONAIR
	farcall LookForEvoCardInDeck_GivenPreevoInPlayArea
	jp c, AITryUseTheBossWayToSearchCard
	ret

.use_pokemon_trader_instead_5
	; otherwise try using Pokémon Trader instead
	ld bc, CLEFAIRY_LV15
	ld de, DARK_CLEFABLE
	farcall LookForEvoCardInDeck_GivenPreevoInPlayArea
	ld de, DARK_CLEFABLE
	jp c, AITryUsePokemonTraderToSearchCard
	ld bc, PSYDUCK_LV16
	ld de, DARK_GOLDUCK
	farcall LookForEvoCardInDeck_GivenPreevoInPlayArea
	ld de, DARK_GOLDUCK
	jp c, AITryUsePokemonTraderToSearchCard
	ld bc, DRATINI_LV12
	ld de, DARK_DRAGONAIR
	farcall LookForEvoCardInDeck_GivenPreevoInPlayArea
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
	call CanUseEvolutionaryLight
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

AIDecide_GustOfWind_StopLifeDeck:
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
	call IsArenaOrBenchPokemonStage2
	jr c, .asm_49672
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	ld d, a
	ld e, PLAY_AREA_BENCH_1
.loop_bench_2
	ld a, e
	push de
	call IsArenaOrBenchPokemonStage2
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

; Biruritchi AI
; return carry if turn holder's pkmn at location in a is stage 2 evolution
IsArenaOrBenchPokemonStage2:
	add DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call LoadCardDataToBuffer2_FromDeckIndex
	ld a, [wLoadedCard2Stage]
	cp STAGE2
	ccf
	ret

AIDecide_Switch_StopLifeDeck:
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call GetCardIDFromDeckIndex
	cp16 DARK_VENUSAUR
	jr z, .dark_venusaur
	cp16 KANGASKHAN_LV40
	jr z, .kangaskhan
	or a
	ret

.dark_venusaur
	; if Dark Venusaur has at least 3 energies...
	ld e, PLAY_AREA_ARENA
	call GetPlayAreaCardAttachedEnergies
	ld a, [wTotalAttachedEnergies]
	cp 3
	jr c, .less_than_3_energies
	; ...and is statused, switch
	ld a, DUELVARS_ARENA_CARD_STATUS
	get_turn_duelist_var
	or a
	jr nz, .switch
	jr .not_statused

.kangaskhan
	; if Kangaskhan has less than 3 energies...
	ld e, PLAY_AREA_ARENA
	call GetPlayAreaCardAttachedEnergies
	ld a, [wTotalAttachedEnergies]
	cp 3
	ret nc
	; ...and has a benched Dark Venusaur with energy, switch to it
	ld de, DARK_VENUSAUR
	call FindCardIDInBenchWithEnoughEnergy
	ret

.not_statused
	; Dark Venusaur has 3 or more energies and not statused
	; if it cannot use its attacks...
	farcall CanArenaCardUseNonResidualAttack
	ccf
	ret nc
	; ...try switching to a benched Scyther
	ld de, SCYTHER_LV25
	ld b, PLAY_AREA_BENCH_1
	farcall FindCardIDInTurnDuelistsPlayArea
	ret

.switch
	farcall AIDecideBenchPokemonToSwitchTo
	ccf
	ret

.less_than_3_energies
	; Dark Venusaur has less than 3 energies
	; do nothing if no set up Pokémon in Bench
	farcall CountNumberOfSetUpBenchPokemon
	ret nc
	; otherwise switch to a bench Pokémon
	; with at least 50 score
	farcall AIDecideBenchPokemonToSwitchTo
	ccf
	ret nc
	push af
	ld a, 50
	cp e
	pop bc
	ld a, b
	ret

; +70 if
;      the same card isn't in play yet but has positive type match-up
;   OR can be ready with Energy in hand while active Pokémon isn't;
; neutral if the same card isn't in play yet and has neutral type match-up;
; -30 otherwise
PowerfulPokemonDeckAIEvaluateBasicCards:
	ld a, [wLoadedCard1ID]
	ld e, a
	ld a, [wLoadedCard1ID + 1]
	ld d, a
	ld b, PLAY_AREA_ARENA
	push de
	farcall FindCardIDInTurnDuelistsPlayArea
	pop de
	jr nc, .not_found

.check_arena
	xor a ; PLAY_AREA_ARENA, FIRST_ATTACK_OR_PKMN_POWER
	ldh [hTempPlayAreaLocation_ff9d], a
	ld [wSelectedAttack], a
	farcall CheckIfSelectedAttackIsUnusable
	jr nc, .discourage
	ld a, SECOND_ATTACK
	ld [wSelectedAttack], a
	farcall CheckIfSelectedAttackIsUnusable
	jr nc, .discourage
	farcall AIProcessButDontPlayEnergy
	jr c, .discourage

	call CreateHandCardList
	ld a, [wTempAIPokemonCard]
	call .GetEnergyFlag
	ld hl, wDuelTempList
	farcall CheckEnergyFlagsNeededInList
	jr c, .encourage

.discourage
	ld a, AI_SCORE_BASIC_POKEMON - 30
	ret

.not_found
	call SwapTurn
	push de
	bank1call GetArenaCardWeakness
	pop de
	call SwapTurn
	cp WR_FIRE
	jr z, .prefer_fire
	cp WR_WATER
	jr z, .prefer_water
	cp WR_LIGHTNING
	jr z, .prefer_lightning
	cp WR_FIGHTING
	jr z, .prefer_fighting
	cp WR_PSYCHIC
	jr nz, .neutral
; prefer psychic
	cp16 JYNX_LV27
	jr nz, .check_arena
	jr .encourage
.prefer_fighting
	cp16 HITMONCHAN_LV33
	jr nz, .check_arena
	jr .encourage
.prefer_lightning
	cp16 ELECTABUZZ_LV35
	jr nz, .check_arena
	jr .encourage
.prefer_water
	cp16 LAPRAS_LV31
	jr nz, .check_arena
	jr .encourage
.prefer_fire
	cp16 MAGMAR_LV31
	jp nz, .check_arena

.encourage
	ld a, AI_SCORE_BASIC_POKEMON + 70
	ret

.neutral
	ld a, AI_SCORE_BASIC_POKEMON
	ret

.GetEnergyFlag:
	call GetCardIDFromDeckIndex
	cp16 MAGMAR_LV31
	ld a, FIRE_F
	ret z
	cp16 LAPRAS_LV31
	ld a, WATER_F
	ret z
	cp16 ELECTABUZZ_LV35
	ld a, LIGHTNING_F
	ret z
	cp16 HITMONCHAN_LV33
	ld a, FIGHTING_F
	ret z
	ld a, PSYCHIC_F
	ret

AIDecide_EnergySearch_PowerfulPokemonDeck:
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call GetCardIDFromDeckIndex
	cp16 MAGMAR_LV31
	ld a, 2
	ld bc, FIRE_ENERGY
	jr z, .check_energy_attached
	cp16 LAPRAS_LV31
	ld a, 2
	ld bc, WATER_ENERGY
	jr z, .check_energy_attached
	cp16 ELECTABUZZ_LV35
	ld a, 2
	ld bc, LIGHTNING_ENERGY
	jr z, .check_energy_attached
	cp16 HITMONCHAN_LV33
	ld a, 1
	ld bc, FIGHTING_ENERGY
	jr z, .check_energy_attached
; Jynx
	ld a, 1
	ld bc, PSYCHIC_ENERGY

.check_energy_attached
	ld d, a
	ld e, PLAY_AREA_ARENA
	call GetPlayAreaCardAttachedEnergies
	ld a, [wTotalAttachedEnergies]
	cp d
	ret nc
	ld d, b
	ld e, c
	push de
	farcall LookForCardIDInHandList
	pop de
	ccf
	ret nc
	ld a, CARD_LOCATION_DECK
	farcall FindCardIDInLocation
	ret

; return carry if player's card is weak to pkmn at location in a
; input:
; a = PLAY_AREA_* constant
; output:
; a = WR_* constant of player's card's weakness
IsDefendingPokemonWeakToArenaOrBenchPokemon:
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

AIDecide_Switch_PowerfulPokemonDeck:
	; if Arena card can KO defending card, skip
	farcall CheckIfArenaCardCanKnockOutDefendingCard_CheckHand
	ccf
	ret nc

	; if Defending card is weak to Arena, only switch if
	; arena card will be KO'd next turn
	xor a
	call IsDefendingPokemonWeakToArenaOrBenchPokemon
	jr c, .switch_if_defending_can_ko
	; not weak to Arena card
	; find a Pokémon in Play Area that can use an attack
	; and that the Defending card is weak to
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	ld d, a
	ld e, PLAY_AREA_BENCH_1
.loop_bench
	ld a, e
	push de
	call IsDefendingPokemonWeakToArenaOrBenchPokemon
	pop de
	jr nc, .next
	ld a, e
	ldh [hTempPlayAreaLocation_ff9d], a
	xor a ; FIRST_ATTACK_OR_PKMN_POWER
	ld [wSelectedAttack], a
	push de
	farcall CheckIfSelectedAttackIsUnusable
	pop de
	jr c, .next
	; found, switch to it
	ld a, e
	scf
	ret
.next
	inc e
	ld a, e
	cp d
	jr nz, .loop_bench

	; none found, switch if Arena card is weak to Defending card
	farcall CheckIfArenaCardIsWeakToDefendingCard
	jr c, .switch
.switch_if_defending_can_ko
	xor a ; PLAY_AREA_ARENA
	ldh [hTempPlayAreaLocation_ff9d], a
	farcall CheckIfDefendingPokemonCanKnockOut
	ret nc
.switch
	farcall AIDecideBenchPokemonToSwitchTo
	ccf
	ret

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

AIDecide_Switch_ScorcherDeck:
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call GetCardIDFromDeckIndex
	cp16 DARK_CHARIZARD
	jr z, .dark_charizard
	cp16 KANGASKHAN_LV40
	jr z, .kangaskhan
	cp16 DARK_CLEFABLE
	jr z, .dark_clefable
	or a
	ret

.dark_charizard
	; does Dark Charizard have 2 or more energies?
	ld e, PLAY_AREA_ARENA
	call GetPlayAreaCardAttachedEnergies
	ld a, [wTotalAttachedEnergies]
	cp 2
	jr c, .less_than_2_energies
	; yes, if Magmar is in Play Area...
	ld de, MAGMAR_LV31
	ld b, PLAY_AREA_BENCH_1
	farcall FindCardIDInTurnDuelistsPlayArea
	jr nc, .else
	; ...and it can KO the Defending Pokémon...
	ldh [hTempPlayAreaLocation_ff9d], a
	farcall CheckIfAnyAttackKnocksOutDefendingCard
	jr nc, .else
	; ...and that attack is usable...
	farcall CheckIfSelectedAttackIsUnusable
	jr c, .else
	; ...then use Switch and switch to Magmar
	ldh a, [hTempPlayAreaLocation_ff9d]
	scf
	ret
.else
	; else, use Switch if is statused
	ld a, DUELVARS_ARENA_CARD_STATUS
	get_turn_duelist_var
	or a
	jr nz, .switch
	jr .not_statused

.kangaskhan
	; use Switch on Kangaskhan if it has less than 3 energies
	; and there is a Dark Charizard in the Bench
	ld e, PLAY_AREA_ARENA
	call GetPlayAreaCardAttachedEnergies
	ld a, [wTotalAttachedEnergies]
	cp 3
	ret nc
	ld de, DARK_CHARIZARD
	call FindCardIDInBenchWithEnoughEnergy
	ret

.not_statused
	; if Dark Charizard cannot use an attack...
	farcall CanArenaCardUseNonResidualAttack
	ccf
	ret nc
	; ...then switch to a Magmar in Bench
	ld de, MAGMAR_LV31
	ld b, PLAY_AREA_BENCH_1
	farcall FindCardIDInTurnDuelistsPlayArea
	ret

.dark_clefable
	; if Dark Clefable is Arena card, use Switch
	; to switch to a Dark Charizard in Bench
	ld de, DARK_CHARIZARD
	call FindCardIDInBenchWithEnoughEnergy
	ret

.switch
	farcall AIDecideBenchPokemonToSwitchTo
	ccf
	ret

.less_than_2_energies
	; Dark Charizard has fewer than 2 energies attached
	; switch to a Bench card with enough switch score
	farcall CountNumberOfSetUpBenchPokemon
	ret nc
	farcall AIDecideBenchPokemonToSwitchTo
	ccf
	ret nc
	push af
	ld a, 50
	cp e
	pop bc
	ld a, b
	ret

AIDecide_EnergyRetrieval_ScorcherDeck:
	farcall CountBasicEnergyCardsInHand
	ret nc

; find discard card
	call CreateHandCardList
	ld hl, wDuelTempList
	ld de, wTempCardCollection
.loop_copy
	ld a, [hli]
	ld [de], a
	inc de
	cp $ff
	jr nz, .loop_copy

	ld hl, wTempCardCollection
.loop_hand_cards
	ld a, [hl]
	cp $ff
	jp z, .no_carry
	push hl
	call GetCardIDFromDeckIndex
; try some pkmn
	cp16 KANGASKHAN_LV40
	jr nz, .try_bill
	ld de, KANGASKHAN_LV40
	ld b, PLAY_AREA_ARENA
	farcall FindCardIDInTurnDuelistsPlayArea
	jr c, .found_discard_card
	ld de, DARK_CHARIZARD
	ld b, PLAY_AREA_ARENA
	farcall FindCardIDInTurnDuelistsPlayArea
	jr c, .found_discard_card
.try_bill
	cp16 BILL
	jr nz, .try_bills_teleporter
	ld a, DUELVARS_NUMBER_OF_CARDS_NOT_IN_DECK
	get_turn_duelist_var
	cp DECK_SIZE - 11
	jr nc, .found_discard_card
.try_bills_teleporter
	cp16 BILLS_TELEPORTER
	jr nz, .try_magmar
	ld a, DUELVARS_NUMBER_OF_CARDS_NOT_IN_DECK
	get_turn_duelist_var
	cp DECK_SIZE - 13
	jr nc, .found_discard_card
.try_magmar
	cp16 MAGMAR_LV31
	jr nz, .try_other_trainers
	ld de, MAGMAR_LV31
	ld b, PLAY_AREA_ARENA
	farcall FindCardIDInTurnDuelistsPlayArea
	jr c, .found_discard_card
.try_other_trainers
	cp16 SWITCH
	jr z, .found_discard_card
	cp16 DEFENDER
	jr z, .found_discard_card
	cp16 ENERGY_RETRIEVAL
	jr z, .found_discard_card
	cp16 POKEMON_TRADER
	jr z, .found_discard_card
	cp16 THE_BOSSS_WAY
	jr z, .found_discard_card
; next card
	pop hl
	inc hl
	jp .loop_hand_cards

.found_discard_card
	pop hl
	ld a, [hl]
	scf
	ret

.no_carry
	or a
	ret

Func_49a73:
	ld e, PLAY_AREA_ARENA
	call SwapTurn
	call GetPlayAreaCardAttachedEnergies
	call SwapTurn
	ld a, [wTotalAttachedEnergies]
	ld [wTempAICount3], a
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
	farcall CheckIfAnyAttackCanKO
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
	ld hl, wTempAICount3
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
	farcall CheckIfAnyAttackCanKO
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

AIDecide_GustOfWind_TsunamiStarterDeck:
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

AIDecide_Switch_TsunamiStarterDeck:
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call GetCardIDFromDeckIndex
	cp16 DARK_BLASTOISE
	jr z, .dark_blastoise
	cp16 LAPRAS_LV31
	jr z, .lapras
	cp16 DARK_CLEFABLE
	jr z, .dark_clefable
	or a
	ret

.dark_blastoise
	; does Dark Blastoise have at least 2 energies?
	ld e, PLAY_AREA_ARENA
	call GetPlayAreaCardAttachedEnergies
	ld a, [wTotalAttachedEnergies]
	cp 2
	jr c, .less_than_2_energies
	; no, is it statused?
	ld a, DUELVARS_ARENA_CARD_STATUS
	get_turn_duelist_var
	or a
	jr nz, .statused
	jr .not_statused

.lapras
	; switch Lapras to a benched Dark Blastoise with energy
	ld de, DARK_BLASTOISE
	call FindCardIDInBenchWithEnoughEnergy
	ret

.not_statused
	; Dark Blastoise has at least 2 energies and not statused
	; can it use any attack?
	farcall CanArenaCardUseNonResidualAttack
	ccf
	ret nc
	; no, switch to a Scyther in the Bench
	ld de, SCYTHER_LV25
	ld b, PLAY_AREA_BENCH_1
	farcall FindCardIDInTurnDuelistsPlayArea
	ret

.dark_clefable
	; switch Dark Clefable to a benched Dark Blastoise with energy
	ld de, DARK_BLASTOISE
	call FindCardIDInBenchWithEnoughEnergy
	ret

.statused
	; Dark Blastoise has at least 2 energies and is statused
	; switch to a viable bench Pokémon
	farcall AIDecideBenchPokemonToSwitchTo
	ccf
	ret

.less_than_2_energies
	; Dark Blastoise has less than 2 energies
	; use Switch to switch to a Benched Pokémon with enough score
	farcall CountNumberOfSetUpBenchPokemon
	ret nc
	farcall AIDecideBenchPokemonToSwitchTo
	ccf
	ret nc
	push af
	ld a, 50
	cp e
	pop bc
	ld a, b
	ret

AIDecide_GustOfWind_SmashToMincemeatDeck:
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call GetCardIDFromDeckIndex
	cp16 DARK_MACHAMP
	jr z, .dark_machamp_arena
	or a
	ret

.dark_machamp_arena
	xor a ; PLAY_AREA_ARENA
	ldh [hTempPlayAreaLocation_ff9d], a
	inc a ; SECOND_ATTACK
	ld [wSelectedAttack], a
	farcall CheckIfSelectedAttackIsUnusable
	ccf
	ret nc

; ready for Fling
	ld e, PLAY_AREA_ARENA
	call SwapTurn
	call GetPlayAreaCardAttachedEnergies
	call SwapTurn
	ld a, [wTotalAttachedEnergies]
	cp 3
	jr nc, .check_defending_pkmn_evo_stage
; find Gust+Fling target (>= 3 energy) from bench
	farcall FindBenchCardWithAtLeast3AttachedEnergies
	ret c

.check_defending_pkmn_evo_stage
	xor a ; PLAY_AREA_ARENA
	call SwapTurn
	call IsArenaOrBenchPokemonStage2
	call SwapTurn
	ccf
	ret nc ; stage 2 evo with >= 3 energy, so just Fling

; find Gust+Fling target (stage 2 evo) from bench
	call SwapTurn
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	ld d, a
	ld e, PLAY_AREA_BENCH_1
.loop_player_bench
	ld a, e
	push de
	call IsArenaOrBenchPokemonStage2
	pop de
	jr c, .found_bench_stage2_target
	inc e
	ld a, e
	cp d
	jr nz, .loop_player_bench

; target not found
	call SwapTurn
	or a
	ret

.found_bench_stage2_target
	call SwapTurn
	ld a, e
	scf
	ret

AIDecide_Switch_SmashToMincemeatDeck:
	; does the player have Bench?
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	call GetNonTurnDuelistVariable
	cp 1
	jr z, .last_pkmn_or_last_prize
	; yes, is the player on last prize card?
	; this is most likely a bug and is supposed
	; to check the prize count of AI instead
	call SwapTurn
	call CountPrizes
	call SwapTurn
	cp 1
	jr nz, .not_last_prize_card

.last_pkmn_or_last_prize
	; player either is on last Pokémon or last prize card
	; is Defending card Mr. Mime lv28?
	call SwapTurn
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call GetCardIDFromDeckIndex
	call SwapTurn
	cp16 MR_MIME_LV28
	jr z, .mr_mime
	; no, use Switch to bring out a Chansey than can use Double-Edge
	ld de, CHANSEY_LV55
	call FindCardIDInBenchWithEnoughEnergy
	ret
.mr_mime
	; yes, use Switch to bring out a Machop or Clefairy
	ld de, MACHOP_LV20
	ld b, PLAY_AREA_BENCH_1
	farcall FindCardIDInTurnDuelistsPlayArea
	ret c
	ld de, CLEFAIRY_LV15
	ld b, PLAY_AREA_BENCH_1
	farcall FindCardIDInTurnDuelistsPlayArea
	ret

.not_last_prize_card
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call GetCardIDFromDeckIndex
	cp16 DARK_MACHAMP
	jr z, .dark_machamp
	cp16 KANGASKHAN_LV40
	jr z, .kangaskhan
	cp16 DARK_CLEFABLE
	jr z, .dark_clefable
	or a
	ret

.dark_machamp
	; does Dark Machamp have at least 4 energies?
	ld e, PLAY_AREA_ARENA
	call GetPlayAreaCardAttachedEnergies
	ld a, [wTotalAttachedEnergies]
	cp 4
	jr c, .less_than_4_energies
	; yes, if is statused, use Switch
	ld a, DUELVARS_ARENA_CARD_STATUS
	get_turn_duelist_var
	or a
	jr nz, .switch
	jr .not_statused

.kangaskhan
	; use Switch on Kangaskhan if it has less than 3 energies
	; and there is a Dark Machamp in the Bench
	ld e, PLAY_AREA_ARENA
	call GetPlayAreaCardAttachedEnergies
	ld a, [wTotalAttachedEnergies]
	cp 3
	ret nc
	ld de, DARK_MACHAMP
	call FindCardIDInBenchWithEnoughEnergy
	ret

.not_statused
	; Dark Machamp has enough energies and not statused
	; can it use its attacks?
	farcall CanArenaCardUseNonResidualAttack
	ccf
	ret nc
	; no, use Switch to bring out benched Chansey
	ld de, CHANSEY_LV55
	ld b, PLAY_AREA_BENCH_1
	farcall FindCardIDInTurnDuelistsPlayArea
	ret

.dark_clefable
	; switch Dark Clefable to a benched Dark Machamp with energy
	ld de, DARK_MACHAMP
	call FindCardIDInBenchWithEnoughEnergy
	ret

.switch
	farcall AIDecideBenchPokemonToSwitchTo
	ccf
	ret

.less_than_4_energies
	; Dark Machamp has less than 4 energies
	; use Switch to switch to a Benched Pokémon with enough score
	farcall CountNumberOfSetUpBenchPokemon
	ret nc
	farcall AIDecideBenchPokemonToSwitchTo
	ccf
	ret nc
	push af
	ld a, 50
	cp e
	pop bc
	ld a, b
	ret

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

; load selected attack from Pokémon in hTempPlayAreaLocation_ff9d,
; gets an energy card to discard and subsequently
; check if there is enough energy to execute the selected attack
; after removing that attached energy card.
; input:
;	[hTempPlayAreaLocation_ff9d] = location of Pokémon card
;	[wSelectedAttack]            = selected attack to examine
; output:
;	b = basic energy still needed
;	c = colorless energy still needed
;	e = output of ConvertColorToEnergyCardID, or $0 if not an attack
;	carry set if no attack
;	       OR if it's a Pokémon Power
;	       OR if not enough energy for attack
CheckEnergyNeededForAttackAfterDiscard:
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
	jr z, .no_attack
	ld a, [wLoadedAttackCategory]
	cp POKEMON_POWER
	jr nz, .is_attack
.no_attack
	lb bc, 0, 0
	ld e, c
	scf
	ret

.is_attack
	ldh a, [hTempPlayAreaLocation_ff9d]
	farcall AIPickEnergyCardToDiscard
	call GetCardIDFromDeckIndex
	cp16 DOUBLE_COLORLESS_ENERGY
	jr z, .double_colorless
	cp16 POTION_ENERGY
	jr z, .single_colorless
	cp16 FULLHEAL_ENERGY
	jr z, .single_colorless
	cp16 RECYCLE_ENERGY
	jr z, .single_colorless
	cp16 RAINBOW_ENERGY
	jr nz, .not_special_energy
	; bug, should be RAINBOW + 1
	; in this case it will decrement a colorless energy instead
	ld de, RAINBOW

.not_special_energy
; decrease respective attached energy by 1.
	ld hl, wAttachedEnergies
	dec de
	add hl, de
	dec [hl]
	ld hl, wTotalAttachedEnergies
	dec [hl]
	jr .decremented_energy

.double_colorless
; decrease attached colorless by 2.
	ld hl, wAttachedEnergies + COLORLESS
	dec [hl]
	dec [hl]
	ld hl, wTotalAttachedEnergies
	dec [hl]
	dec [hl]
	jr .decremented_energy

.single_colorless
; decrease attached colorless by 1.
	ld hl, wAttachedEnergies + COLORLESS
	dec [hl]
	ld hl, wTotalAttachedEnergies
	dec [hl]

.decremented_energy
	ldh a, [hTempPlayAreaLocation_ff9d]
	ld e, a
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
	farcall CheckIfEnoughParticularAttachedEnergy
	ld a, [de]
	farcall CheckIfEnoughParticularAttachedEnergy
	inc de
	dec c
	jr nz, .loop

	ld a, [de]
	swap a
	and $0f
	ld b, a ; colorless energy still needed

	; subtract amount of attached Rainbow energies
	; from total needed amount
	ld hl, wAttachedEnergies + RAINBOW
	ld a, [hl]
	or a
	jr z, .no_rainbow_energy
	ld a, [wTempLoadedAttackEnergyNeededAmount]
	sub [hl]
	jr nc, .got_needed_amount
	xor a
.got_needed_amount
	ld [wTempLoadedAttackEnergyNeededAmount], a

.no_rainbow_energy
	ld a, [wTempLoadedAttackEnergyCost]
	ld hl, wTempLoadedAttackEnergyNeededAmount
	sub [hl]
	ld c, a ; basic energy still needed
	ld a, [wTotalAttachedEnergies]
	sub c
	sub b
	jr c, .not_enough_energy
	ld a, [wTempLoadedAttackEnergyNeededAmount]
	or a
	ret z

; being here means the energy cost isn't satisfied,
; including with colorless energy
	xor a
.not_enough_energy
	cpl
	inc a
	ld c, a ; colorless energy still needed
	ld a, [wTempLoadedAttackEnergyNeededAmount]
	ld b, a ; basic energy still needed
	ld a, [wTempLoadedAttackEnergyNeededType]
	farcall ConvertColorToEnergyCardID
	scf
	ret

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
; output:
; - a = play area location of Pokémon found
FindCardIDInBenchWithEnoughEnergy:
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

; return carry and the deck index if
; Pokémon in Play Area has a specific energy card attached
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

; return carry if
; >= 17 cards remaining in deck pile
; AND (
;      <= 5 cards in hand
;   OR ready for Do the Wave but <= 4 pkmn in play
; )
AIDecide_ProfessorOak_EverybodysFriendDeck:
	; if has 16 or fewer cards remaining in deck, don't use
	ld a, DUELVARS_NUMBER_OF_CARDS_NOT_IN_DECK
	get_turn_duelist_var
	cp DECK_SIZE - 16
	ret nc

	; if has less than 6 cards in hand, use
	ld a, DUELVARS_NUMBER_OF_CARDS_IN_HAND
	get_turn_duelist_var
	cp 6
	ret c

	; if doesn't have Wigglytuff in play that can use
	; its attacks, then don't use...
	ld de, WIGGLYTUFF_LV36
	call CheckCardIDInPlayAreaThatCanUseAttacks
	ret nc
	; ...otherwise use if number of Pokémon in play
	; is less than 5
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	cp 5
	ret

AIDecide_ComputerSearch_EverybodysFriendDeck:
	ld a, DUELVARS_NUMBER_OF_CARDS_IN_HAND
	get_turn_duelist_var
	cp 6
	jr nc, .target_wigglytuff

	ld de, PROFESSOR_OAK
	farcall IsCardIDInDeckAndNotInHand
	jr c, .find_discard_cards

.target_wigglytuff
	ld bc, JIGGLYPUFF_LV14
	ld de, WIGGLYTUFF_LV36
	farcall LookForEvoCardInDeck_GivenPreevoInPlayArea
	jr c, .find_discard_cards

	ld de, PLUSPOWER
	ld a, CARD_LOCATION_DISCARD_PILE
	farcall FindCardIDInLocation
	jr nc, .check_scoop_up_in_discard_pile
	push af
	farcall $8, $4692 ; AIDecide_PlusPower1
	pop bc
	ld a, b
	jr c, .find_discard_cards

.check_scoop_up_in_discard_pile
	ld de, SCOOP_UP
	ld a, CARD_LOCATION_DISCARD_PILE
	farcall FindCardIDInLocation
	ret nc

	push af
	xor a ; PLAY_AREA_ARENA
	ldh [hTempPlayAreaLocation_ff9d], a
	farcall CheckIfDefendingPokemonCanKnockOut
	pop bc
	ld a, b
	jr c, .find_discard_cards ; unnecessary jump

.find_discard_cards
	ld [wTempAISingleTargetCardDeckIndex_2], a
	ld a, $ff
	ld [wTempAIComputerSearchFirstDiscardDeckIndex], a

	ld de, COMPUTER_SEARCH
	call LookForCardIDInHandList_IgnoreTrainerCardToPlay
	call c, .store_discard_cards

	call AIDecide_ProfessorOak_EverybodysFriendDeck
	jr c, .try_scoop_up
	ld de, PROFESSOR_OAK
	farcall LookForCardIDInHandList
	call c, .store_discard_cards

.try_scoop_up
	call AIDecide_ScoopUp_EverybodysFriendDeck
	jr c, .try_item_finder
	ld de, SCOOP_UP
	farcall LookForCardIDInHandList
	call c, .store_discard_cards

.try_item_finder
	call AIDecide_ItemFinder_EverybodysFriendDeck
	jr c, .try_switch
	ld de, ITEMFINDER
	farcall LookForCardIDInHandList
	call c, .store_discard_cards

.try_switch
	call AIDecide_Switch_EverybodysFriendDeck
	jr c, .try_gust_of_wind
	ld de, SWITCH
	farcall LookForCardIDInHandList
	call c, .store_discard_cards

.try_gust_of_wind
	farcall AIDecide_GustOfWind
	jr c, .try_energy_retrieval
	ld de, GUST_OF_WIND
	farcall LookForCardIDInHandList
	call c, .store_discard_cards

.try_energy_retrieval
	farcall $8, $566e ; AIDecide_EnergyRetrieval
	jr c, .try_pluspower
	ld de, ENERGY_RETRIEVAL
	farcall LookForCardIDInHandList
	call c, .store_discard_cards

.try_pluspower
	farcall $8, $4692 ; AIDecide_PlusPower1
	jr c, .no_carry
	ld de, PLUSPOWER
	farcall LookForCardIDInHandList
	call c, .store_discard_cards

.no_carry
	or a
	ret

.store_discard_cards
	push af
	ld a, [wTempAIComputerSearchFirstDiscardDeckIndex]
	cp $ff
	jr nz, .latter_discard_card
	pop af
	ld [wTempAIComputerSearchFirstDiscardDeckIndex], a
	ret

.latter_discard_card
	pop af
	ld [wTempAIMultiTargetCardDeckIndex2], a
	ld a, [wTempAIComputerSearchFirstDiscardDeckIndex]
	ld [wTempAIMultiTargetCardDeckIndex1], a
	ld a, $ff
	ld [wTempAIMultiTargetCardDeckIndex3], a
; success
	add sp, $2 ; exit
	ld a, [wTempAISingleTargetCardDeckIndex_2]
	scf
	ret

AIDecide_Switch_EverybodysFriendDeck:
	; switch if Arena card is statused
	ld a, DUELVARS_ARENA_CARD_STATUS
	get_turn_duelist_var
	or a
	jr nz, .switch

	; if Arena card is not Wigglytuff and
	; there's a benched Wigglytuff with enough energy
	; then switch to it
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call GetCardIDFromDeckIndex
	cp16 WIGGLYTUFF_LV36
	ret z ; skip if not Wigglytuff
	ld de, WIGGLYTUFF_LV36
	call FindCardIDInBenchWithEnoughEnergy
	ret
.switch
	farcall AIDecideBenchPokemonToSwitchTo
	ccf
	ret

AIDecide_ScoopUp_EverybodysFriendDeck:
	farcall CheckIfArenaCardCanKnockOutDefendingCard_CheckHand
	jr c, .check_bench

	ld e, PLAY_AREA_ARENA
	ld a, DUELVARS_ARENA_CARD_HP
	get_turn_duelist_var
	cp 30 + 1
	jr c, .found_low_hp

.check_bench
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	ld d, a
	ld e, PLAY_AREA_BENCH_1
.loop_bench
	ld a, e
	add DUELVARS_ARENA_CARD_HP
	get_turn_duelist_var
	cp 30 + 1
	jr c, .found_low_hp
	inc e
	ld a, e
	cp d
	jr nz, .loop_bench

; no low HP pkmn
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call GetCardIDFromDeckIndex
	cp16 WIGGLYTUFF_LV36
	ret z
	ld de, WIGGLYTUFF_LV36
	call FindCardIDInBenchWithEnoughEnergy
	ret nc
; ready for Do the Wave
	ld [wTempAIMultiTargetCardDeckIndex1], a
	xor a
	scf
	ret

.found_low_hp
	ld a, $ff
	ld [wTempAIMultiTargetCardDeckIndex1], a
	ld a, e ; PLAY_AREA_*
	or a
	jr nz, .set_carry
; scoop up arena card
	push de
	farcall AIDecideBenchPokemonToSwitchTo
	pop de
	ld [wTempAIMultiTargetCardDeckIndex1], a
	ld a, e
	jr nc, .set_carry

; no carry
	or a
	ret

.set_carry
	scf
	ret

AIDecide_ItemFinder_EverybodysFriendDeck:
; target pluspower
	ld de, PLUSPOWER
	ld a, CARD_LOCATION_DISCARD_PILE
	farcall FindCardIDInLocation
	jr nc, .target_scoop_up
	push af
	farcall $8, $4692 ; AIDecide_PlusPower1
	pop bc
	jr c, .find_discard_cards

.target_scoop_up
	ld de, SCOOP_UP
	ld a, CARD_LOCATION_DISCARD_PILE
	farcall FindCardIDInLocation
	ret nc
	push af
	call AIDecide_ScoopUp_EverybodysFriendDeck
	pop bc
	ret nc

.find_discard_cards
	ld a, b
	ld [wTempAISingleTargetCardDeckIndex_2], a
	ld a, $ff
	ld [wTempAIItemFinderFirstDiscardDeckIndex], a
; try dupe itemfinder
	ld de, ITEMFINDER
	call LookForCardIDInHandList_IgnoreTrainerCardToPlay
	call c, .store_discard_cards
; try professor oak
	call AIDecide_ProfessorOak_EverybodysFriendDeck
	jr c, .try_scoop_up
	ld de, PROFESSOR_OAK
	farcall LookForCardIDInHandList
	call c, .store_discard_cards
.try_scoop_up
	call AIDecide_ScoopUp_EverybodysFriendDeck
	jr c, .try_switch
	ld de, SCOOP_UP
	farcall LookForCardIDInHandList
	call c, .store_discard_cards
.try_switch
	call AIDecide_Switch_EverybodysFriendDeck
	jr c, .try_gust_of_wind
	ld de, SWITCH
	farcall LookForCardIDInHandList
	call c, .store_discard_cards
.try_gust_of_wind
	farcall AIDecide_GustOfWind
	jr c, .try_energy_retrieval
	ld de, GUST_OF_WIND
	farcall LookForCardIDInHandList
	call c, .store_discard_cards
.try_energy_retrieval
	farcall $8, $566e ; AIDecide_EnergyRetrieval
	jr c, .try_pluspower
	ld de, ENERGY_RETRIEVAL
	farcall LookForCardIDInHandList
	call c, .store_discard_cards
.try_pluspower
	farcall $8, $4692 ; AIDecide_PlusPower1
	jr c, .no_carry
	ld de, PLUSPOWER
	farcall LookForCardIDInHandList
	call c, .store_discard_cards

.no_carry
	or a
	ret

.store_discard_cards
	push af
	ld a, [wTempAIItemFinderFirstDiscardDeckIndex]
	cp $ff
	jr nz, .latter_discard_card
	pop af
	ld [wTempAIItemFinderFirstDiscardDeckIndex], a
	ret

.latter_discard_card
	pop af
	ld [wTempAIMultiTargetCardDeckIndex2], a
	ld a, [wTempAIItemFinderFirstDiscardDeckIndex]
	ld [wTempAIMultiTargetCardDeckIndex1], a
	ld a, $ff
	ld [wTempAIMultiTargetCardDeckIndex3], a
; success
	add sp, $2 ; exit
	ld a, [wTempAISingleTargetCardDeckIndex_2]
	scf
	ret

; input:
; de = card ID
; output:
; a = deck index and carry if found
LookForCardIDInHandList_IgnoreTrainerCardToPlay:
	push de
	call CreateHandCardList
	pop bc
	ld hl, wDuelTempList
.loop_hand_cards
	ld a, [hli]
	cp $ff
	ret z
	push hl
	ld hl, wAITrainerCardToPlay
	cp [hl]
	pop hl
	jr z, .loop_hand_cards
	ldh [hTempCardIndex_ff98], a
	push bc
	call GetCardIDFromDeckIndex
	pop bc
	ld a, d
	cp b
	jr nz, .loop_hand_cards
	ld a, e
	cp c
	jr nz, .loop_hand_cards
; found
	ldh a, [hTempCardIndex_ff98]
	scf
	ret

; +10 if
;       not KOing with Psyshock
;   AND Abra in KO range
;   AND >= 2 of {Kadabra, Alakazam, Mr. Mime, Scyther} on his Bench;
; -28 otherwise
ImmortalPokemonDeckAIEvaluateVanish:
	farcall CheckIfArenaCardCanKnockOutDefendingCard
	jr nc, .check_abra

.discourage
	ld a, AI_SCORE_NEUTRAL - 28
	ret

.check_abra
	farcall CheckIfDefendingPokemonCanKnockOut
	jr nc, .discourage

; tally bench
	ld de, KADABRA_LV39
	ld b, PLAY_AREA_BENCH_1
	farcall CountCardIDInTurnDuelistPlayArea
	push af
	ld de, ALAKAZAM_LV42
	ld b, PLAY_AREA_BENCH_1
	farcall CountCardIDInTurnDuelistPlayArea
	pop bc
	add b
	push af
	ld de, MR_MIME_LV28
	ld b, PLAY_AREA_BENCH_1
	farcall CountCardIDInTurnDuelistPlayArea
	pop bc
	add b
	push af
	ld de, SCYTHER_LV25
	ld b, PLAY_AREA_ARENA
	farcall CountCardIDInTurnDuelistPlayArea
	pop bc
	add b
	cp 2
	jr c, .discourage

; encourage
	ld a, AI_SCORE_NEUTRAL + 10
	ret

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
	farcall Serial_TossCoin
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
	farcall CheckReelInEvoLineTarget
	call c, .TryAddCardToList
	ld bc, SLOWPOKE_LV16
	ld de, DARK_SLOWBRO
	farcall CheckReelInEvoLineTarget
	call c, .TryAddCardToList
	ld bc, DROWZEE_LV10
	ld de, DARK_HYPNO
	farcall CheckReelInEvoLineTarget
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
	farcall AIDecide_ReelIn_BadGuysDeck
	ret

; finds card with highest number of attached energies
; and, in case of tie, outputs the card with highest
; remaining HP
; input:
; - e = PLAY_AREA_* constant to start looking from (PLAY_AREA_ARENA or PLAY_AREA_BENCH_1)
; output:
; - a = PLAY_AREA_* constant chosen
Func_4a3dc:
	xor a
	ld d, MAX_PLAY_AREA_POKEMON * 2
	ld hl, wTempPlayAreaList
.loop_clear
	ld [hli], a
	dec d
	jr nz, .loop_clear

	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	cp e
	jr nz, .tally
; a = e = 1: starting with PLAY_AREA_BENCH_1 but no benched pkmn
; so return PLAY_AREA_ARENA
	xor a
	ret

.tally
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
	ld hl, wTempPlayAreaEnergyList
	add hl, bc
	ld [hli], a ; num attached energies
	ld [hl], $ff ; terminating byte
	ld a, e
	add DUELVARS_ARENA_CARD_HP
	get_turn_duelist_var
	ld hl, wTempPlayAreaHPList
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
	ld hl, wTempPlayAreaEnergyList
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
	ld hl, wTempPlayAreaHPList
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

; de = card ID
; return a = number of cards in hand with that card ID
; set carry if not found
CountCardIDInHand:
	push de
	call CreateHandCardList
	pop de

	ld b, 0
	ld hl, wDuelTempList
.loop_hand_cards
	ld a, [hli]
	cp $ff
	jr z, .tally
	push de
	push bc
	push hl
	call GetCardIDFromDeckIndex
	pop hl
	pop bc
	ld c, d
	ld a, e
	pop de
	cp e
	jr nz, .loop_hand_cards
	ld a, c
	cp d
	jr nz, .loop_hand_cards
	inc b
	jr .loop_hand_cards

.tally
	ld a, b
	or a
	jr z, .not_found
	ret

.not_found
	scf
	ret

; de = card ID
; return a = number of cards in discard pile with that card ID
; set carry if not found
CountCardIDInDiscardPile:
	push de
	bank1call CreateDiscardPileCardList
	pop de
	ld b, 0
	ld hl, wDuelTempList
.loop_discard_pile_cards
	ld a, [hli]
	cp $ff
	jr z, .tally
	push de
	push bc
	push hl
	call GetCardIDFromDeckIndex
	pop hl
	pop bc
	ld c, d
	ld a, e
	pop de
	cp e
	jr nz, .loop_discard_pile_cards
	ld a, c
	cp d
	jr nz, .loop_discard_pile_cards
	inc b
	jr .loop_discard_pile_cards

.tally
	ld a, b
	or a
	jr z, .not_found
	ret

.not_found
	scf
	ret

CountNumberOfBasicPokemonInHandOrPlayArea:
	xor a
	ld [wTempAI], a
	call CreateHandCardList
	ld hl, wDuelTempList
	call CountNumberOfBasicPokemonInListInHL
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call CountNumberOfBasicPokemonInListInHL
	ld a, [wTempAI]
	ret

; hl = wDuelTempList, (*ArenaCard + *Bench), etc.
CountNumberOfBasicPokemonInListInHL:
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
	call CountNumberOfBasicPokemonInListInHL
	ld a, [wTempAI]
	ret

; return carry and deck index of hand card if
; card id in de is found in both hand and own play area
IsCardIDInHandAndPlayArea:
	push de
	ld b, PLAY_AREA_ARENA
	farcall FindCardIDInTurnDuelistsPlayArea
	pop de
	ret nc
	farcall LookForCardIDInHandList
	ret

AIDecide_PokemonTrader_RonaldsPsychicDeck:
	ld bc, GASTLY_LV13
	ld de, HAUNTER_LV26
	farcall LookForEvoCardInDeck_GivenPreevoInHandOrPlayArea
	jr c, .find_trade_pkmn
	ld de, GASTLY_LV13
	ld bc, HAUNTER_LV26
	farcall LookForCardIDInDeck_GivenCardIDInHand
	ld de, HAUNTER_LV26
	jr c, .find_trade_pkmn
	ld bc, HAUNTER_LV26
	ld de, GENGAR_LV40
	farcall LookForEvoCardInDeck_GivenPreevoInHandOrPlayArea
	jr c, .find_trade_pkmn
	ld de, HAUNTER_LV26
	ld bc, GENGAR_LV40
	farcall LookForCardIDInDeck_GivenCardIDInHand
	ld de, GENGAR_LV40
	jr c, .find_trade_pkmn
	ld bc, DRATINI_LV10
	ld de, DARK_DRAGONAIR
	farcall LookForEvoCardInDeck_GivenPreevoInHandOrPlayArea
	jr c, .find_trade_pkmn
	ld de, DRATINI_LV10
	ld bc, DARK_DRAGONAIR
	farcall LookForCardIDInDeck_GivenCardIDInHand
	ld de, DARK_DRAGONAIR
	jr c, .find_trade_pkmn
	ld bc, DARK_DRAGONAIR
	ld de, DARK_DRAGONITE
	farcall LookForEvoCardInDeck_GivenPreevoInHandOrPlayArea
	jr c, .find_trade_pkmn
	ld de, DARK_DRAGONAIR
	ld bc, DARK_DRAGONITE
	farcall LookForCardIDInDeck_GivenCardIDInHand
	ld de, DARK_DRAGONITE
	ret nc

.find_trade_pkmn
	ld [wTempAIMultiTargetCardDeckIndex1], a
	call FindDifferentPokemonCardInHand
	ret

AIDecide_EnergyRetrieval_RonaldsPsychicDeck:
	farcall CountBasicEnergyCardsInHand
	ret nc

	call AIDecide_PokemonTrader_RonaldsPsychicDeck
	jr c, .find_discard_card
; discard pkmn trader
	ld de, POKEMON_TRADER
	farcall LookForCardIDInHandList
	ret c

.find_discard_card
	call CreateHandCardList
	ld hl, wDuelTempList
	farcall FindDuplicateCards_IgnoreTrainerCardToPlay
	ccf
	ret

AIDecide_MoonStone_ColorlessEnergyDeck:
	ld bc, DRATINI_LV10
	ld de, DRAGONAIR
	farcall LookForEvoCardInDeck_GivenPreevoInPlayArea
	ret c
	ld bc, DRAGONAIR
	ld de, DRAGONITE_LV43
	farcall LookForEvoCardInDeck_GivenPreevoInPlayArea
	ret c
	ld bc, DRAGONAIR
	ld de, DRAGONITE_LV45
	farcall LookForEvoCardInDeck_GivenPreevoInPlayArea
	ret c
	ld bc, SPEAROW_LV9
	ld de, FEAROW_LV24
	farcall LookForEvoCardInDeck_GivenPreevoInPlayArea
	ret c
	ld bc, SPEAROW_LV12
	ld de, FEAROW_LV24
	farcall LookForEvoCardInDeck_GivenPreevoInPlayArea
	ret c
	ld bc, SPEAROW_LV13
	ld de, FEAROW_LV24
	farcall LookForEvoCardInDeck_GivenPreevoInPlayArea
	ret c
	ld bc, SPEAROW_LV9
	ld de, FEAROW_LV27
	farcall LookForEvoCardInDeck_GivenPreevoInPlayArea
	ret c
	ld bc, SPEAROW_LV12
	ld de, FEAROW_LV27
	farcall LookForEvoCardInDeck_GivenPreevoInPlayArea
	ret c
	ld bc, SPEAROW_LV13
	ld de, FEAROW_LV27
	farcall LookForEvoCardInDeck_GivenPreevoInPlayArea
	ret

AIDecide_PokemonTrader_ColorlessEnergyDeck:
	call CountNumberOfBasicPokemonInHand
	or a
	jr nz, .prefer_evolution
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	cp 1
	jr nz, .prefer_evolution

; no basic pkmn in hand AND no benched pkmn
; target basic pkmn
	ld de, DRATINI_LV10
	ld a, CARD_LOCATION_DECK
	farcall FindCardIDInLocation
	ld de, DRATINI_LV10
	jr c, .find_trade_pkmn
	ld de, EEVEE_LV12
	ld a, CARD_LOCATION_DECK
	farcall FindCardIDInLocation
	ld de, EEVEE_LV12
	jr c, .find_trade_pkmn
	ld de, SPEAROW_LV9
	ld a, CARD_LOCATION_DECK
	farcall FindCardIDInLocation
	ld de, SPEAROW_LV9
	jr c, .find_trade_pkmn
	ld de, SPEAROW_LV12
	ld a, CARD_LOCATION_DECK
	farcall FindCardIDInLocation
	ld de, SPEAROW_LV12
	jr c, .find_trade_pkmn
	ld de, SPEAROW_LV13
	ld a, CARD_LOCATION_DECK
	farcall FindCardIDInLocation
	ld de, SPEAROW_LV13
	ret nc
.find_trade_pkmn
	ld [wTempAIMultiTargetCardDeckIndex1], a
	call FindDifferentPokemonCardInHand
	ret

.prefer_evolution
; find trade card first
	call FindUnusableEvolutionCardInHand
	ret nc
	ld [wTempAIMultiTargetCardDeckIndex2], a

; find target
	ld bc, DRAGONAIR
	ld de, DRAGONITE_LV43
	farcall LookForEvoCardInDeck_GivenPreevoInHandOrPlayArea
	jp c, .found_target_evo
	ld bc, DRAGONAIR
	ld de, DRAGONITE_LV45
	farcall LookForEvoCardInDeck_GivenPreevoInHandOrPlayArea
	jp c, .found_target_evo
	ld bc, DRATINI_LV10
	ld de, DRAGONAIR
	farcall LookForEvoCardInDeck_GivenPreevoInHandOrPlayArea
	jp c, .found_target_evo

; target eeveelutions
; bug: compares with type constants instead of WR_* constants
	call SwapTurn
	bank1call GetArenaCardWeakness
	call SwapTurn
	cp FIRE ; should be WR_FIRE
	jr z, .unused_target_flareon
	cp WATER ; should be WR_WATER
	jr z, .unused_target_dark_vaporeon
	cp LIGHTNING ; should be WR_LIGHTNING
	jr z, .unused_target_jolteon
	jr .target_fearow

.unused_target_flareon
	ld bc, EEVEE_LV12
	ld de, FLAREON_LV22
	farcall LookForEvoCardInDeck_GivenPreevoInHandOrPlayArea
	jr c, .found_target_evo
	jr .target_fearow
.unused_target_dark_vaporeon
	ld bc, EEVEE_LV12
	ld de, DARK_VAPOREON
	farcall LookForEvoCardInDeck_GivenPreevoInHandOrPlayArea
	jr c, .found_target_evo
	jr .target_fearow
.unused_target_jolteon
	ld bc, EEVEE_LV12
	ld de, JOLTEON_LV24
	farcall LookForEvoCardInDeck_GivenPreevoInHandOrPlayArea
	jr c, .found_target_evo

.target_fearow
	ld bc, SPEAROW_LV9
	ld de, FEAROW_LV24
	farcall LookForEvoCardInDeck_GivenPreevoInHandOrPlayArea
	jr c, .found_target_evo
	ld bc, SPEAROW_LV12
	ld de, FEAROW_LV24
	farcall LookForEvoCardInDeck_GivenPreevoInHandOrPlayArea
	jr c, .found_target_evo
	ld bc, SPEAROW_LV13
	ld de, FEAROW_LV24
	farcall LookForEvoCardInDeck_GivenPreevoInHandOrPlayArea
	jr c, .found_target_evo
	ld bc, SPEAROW_LV9
	ld de, FEAROW_LV27
	farcall LookForEvoCardInDeck_GivenPreevoInHandOrPlayArea
	jr c, .found_target_evo
	ld bc, SPEAROW_LV12
	ld de, FEAROW_LV27
	farcall LookForEvoCardInDeck_GivenPreevoInHandOrPlayArea
	jr c, .found_target_evo
	ld bc, SPEAROW_LV13
	ld de, FEAROW_LV27
	farcall LookForEvoCardInDeck_GivenPreevoInHandOrPlayArea
	ret nc

.found_target_evo
	ld [wTempAIMultiTargetCardDeckIndex1], a
	ld a, [wTempAIMultiTargetCardDeckIndex2]
	scf
	ret

AIDecide_ComputerSearch_ImmortalPokemonDeck:
	ld de, PSYCHIC_ENERGY
	call CountCardIDInHand
	cp 3
	ccf
	ret nc

; get 2 of >= 3 psychic energy cards in hand to discard
	ld a, $ff
	ld [wTempAIMultiTargetCardDeckIndex1], a
	ld [wTempAIMultiTargetCardDeckIndex2], a
	bank1call CreateEnergyCardListFromHand
	ld hl, wDuelTempList
.loop_energy_cards
	ld a, [hl]
	cp $ff
	ret z
	push hl
	call GetCardIDFromDeckIndex
	pop hl
	cp16 PSYCHIC_ENERGY
	jr nz, .next ; dce
	ld a, [wTempAIMultiTargetCardDeckIndex1]
	cp $ff
	ld a, [hl]
	jr z, .next_store_first
	ld [wTempAIMultiTargetCardDeckIndex2], a
	jr .target_abra
.next_store_first
	ld [wTempAIMultiTargetCardDeckIndex1], a
.next
	inc hl
	jr .loop_energy_cards

.target_abra
	ld de, KADABRA_LV39
	farcall IsCardIDInHandOrPlayArea
	jr nc, .target_kadabra_1
	ld de, ALAKAZAM_LV42
	farcall IsCardIDInHandOrPlayArea
	jr nc, .target_kadabra_1
	ld de, MR_MIME_LV28
	farcall IsCardIDInHandOrPlayArea
	jr c, .target_kadabra_1
	ld de, MR_MIME_LV20
	farcall IsCardIDInHandOrPlayArea
	jr c, .target_kadabra_1
	ld de, ABRA_LV14
	farcall IsCardIDInDeckAndNotInHandOrPlayArea
	ret c

.target_kadabra_1
	ld de, ABRA_LV14
	farcall IsCardIDInHandOrPlayArea
	jr nc, .target_alakazam
	ld de, ALAKAZAM_LV42
	farcall IsCardIDInHandOrPlayArea
	jr c, .target_alakazam
	ld de, KADABRA_LV39
	farcall IsCardIDInDeckAndNotInHandOrPlayArea
	ret c

.target_alakazam
	ld de, KADABRA_LV39
	farcall IsCardIDInHandOrPlayArea
	jr nc, .target_mr_mime_lv20
	ld de, ALAKAZAM_LV42
	farcall IsCardIDInDeckAndNotInHandOrPlayArea
	ret c

.target_mr_mime_lv20
	ld de, ALAKAZAM_LV42
	farcall IsCardIDInHandOrPlayArea
	jr nc, .target_mr_mime_lv28
	ld de, MR_MIME_LV28
	farcall IsCardIDInHandOrPlayArea
	jr c, .target_mr_mime_lv28
	ld de, MR_MIME_LV20
	farcall IsCardIDInDeckAndNotInHandOrPlayArea
	ret c

.target_mr_mime_lv28
	ld de, ALAKAZAM_LV42
	farcall IsCardIDInHandOrPlayArea
	jr nc, .target_kadabra_2
	ld de, MR_MIME_LV20
	farcall IsCardIDInHandOrPlayArea
	jr nc, .target_kadabra_2
	ld de, MR_MIME_LV28
	farcall IsCardIDInDeckAndNotInHandOrPlayArea
	ret c

.target_kadabra_2
	ld de, ABRA_LV14
	farcall IsCardIDInHandOrPlayArea
	jr nc, .target_chansey
	ld de, ALAKAZAM_LV42
	farcall IsCardIDInHandOrPlayArea
	jr nc, .target_chansey
	ld de, MR_MIME_LV28
	farcall IsCardIDInHandOrPlayArea
	jr nc, .target_chansey
	ld de, MR_MIME_LV20
	farcall IsCardIDInHandOrPlayArea
	jr nc, .target_chansey
	ld de, KADABRA_LV39
	farcall IsCardIDInDeckAndNotInHandOrPlayArea
	ret c

.target_chansey
	ld de, ALAKAZAM_LV42
	farcall IsCardIDInHandOrPlayArea
	jr nc, .target_scyther
	ld de, MR_MIME_LV28
	farcall IsCardIDInHandOrPlayArea
	jr nc, .target_scyther
	ld de, MR_MIME_LV20
	farcall IsCardIDInHandOrPlayArea
	jr nc, .target_scyther
	ld de, CHANSEY_LV55
	farcall IsCardIDInDeckAndNotInHandOrPlayArea
	ret c

.target_scyther
	ld de, ALAKAZAM_LV42
	farcall IsCardIDInHandOrPlayArea
	jr nc, .target_tentacool
	ld de, MR_MIME_LV28
	farcall IsCardIDInHandOrPlayArea
	jr nc, .target_tentacool
	ld de, MR_MIME_LV20
	farcall IsCardIDInHandOrPlayArea
	jr nc, .target_tentacool
	ld de, CHANSEY_LV55
	farcall IsCardIDInHandOrPlayArea
	jr nc, .target_tentacool
	ld de, SCYTHER_LV25
	farcall IsCardIDInDeckAndNotInHandOrPlayArea
	ret c

.target_tentacool
	ld de, ALAKAZAM_LV42
	farcall IsCardIDInHandOrPlayArea
	ret nc
	ld de, MR_MIME_LV28
	farcall IsCardIDInHandOrPlayArea
	ret nc
	ld de, MR_MIME_LV20
	farcall IsCardIDInHandOrPlayArea
	ret nc
	ld de, SCYTHER_LV25
	farcall IsCardIDInHandOrPlayArea
	ret nc
	ld de, CHANSEY_LV55
	farcall IsCardIDInHandOrPlayArea
	ret nc
	ld de, TENTACOOL
	farcall IsCardIDInDeckAndNotInHandOrPlayArea
	ret

AIDecide_PokemonTrader_ImmortalPokemonDeck:
	ld de, KADABRA_LV39
	farcall IsCardIDInHandOrPlayArea
	jr nc, .target_alakazam
	ld de, ALAKAZAM_LV42
	farcall IsCardIDInHandOrPlayArea
	jr nc, .target_alakazam
	ld de, MR_MIME_LV28
	farcall IsCardIDInHandOrPlayArea
	jr c, .target_alakazam
	ld de, MR_MIME_LV20
	farcall IsCardIDInHandOrPlayArea
	jr c, .target_alakazam
; target abra
	ld de, ABRA_LV14
	farcall IsCardIDInDeckAndNotInHandOrPlayArea
	jr nc, .target_alakazam
; find trade card
	ld [wTempAIMultiTargetCardDeckIndex1], a
	ld de, TENTACOOL
	farcall LookForCardIDInHandList
	ret c
	ld de, SCYTHER_LV25
	farcall LookForCardIDInHandList
	ret c
	ld de, CHANSEY_LV55
	farcall LookForCardIDInHandList
	ret c

.target_alakazam
	ld de, KADABRA_LV39
	farcall IsCardIDInHandOrPlayArea
	jr nc, .target_kadabra_1
	ld de, ALAKAZAM_LV42
	farcall IsCardIDInDeckAndNotInHandOrPlayArea
	jr nc, .target_kadabra_1
; find trade card
	ld [wTempAIMultiTargetCardDeckIndex1], a
	ld de, TENTACOOL
	farcall LookForCardIDInHandList
	ret c
	ld de, SCYTHER_LV25
	farcall LookForCardIDInHandList
	ret c
	ld de, CHANSEY_LV55
	farcall LookForCardIDInHandList
	ret c
	ld de, ABRA_LV14
	farcall LookForCardIDInHandList
	ret c
	ld de, MR_MIME_LV28
	farcall LookForCardIDInHandList
	ret c
	ld de, MR_MIME_LV20
	farcall LookForCardIDInHandList
	ret c

.target_kadabra_1
	ld de, ABRA_LV14
	farcall IsCardIDInHandOrPlayArea
	jr nc, .target_mr_mime_lv20
	ld de, ALAKAZAM_LV42
	farcall IsCardIDInHandOrPlayArea
	jr c, .target_mr_mime_lv20
	ld de, KADABRA_LV39
	farcall IsCardIDInDeckAndNotInHandOrPlayArea
	jr nc, .target_mr_mime_lv20
; find trade card
	ld [wTempAIMultiTargetCardDeckIndex1], a
	ld de, TENTACOOL
	farcall LookForCardIDInHandList
	ret c
	ld de, SCYTHER_LV25
	farcall LookForCardIDInHandList
	ret c
	ld de, CHANSEY_LV55
	farcall LookForCardIDInHandList
	ret c
	ld de, MR_MIME_LV28
	farcall LookForCardIDInHandList
	ret c
	ld de, MR_MIME_LV20
	farcall LookForCardIDInHandList
	ret c

.target_mr_mime_lv20
	ld de, ALAKAZAM_LV42
	farcall IsCardIDInHandOrPlayArea
	jr nc, .target_mr_mime_lv28
	ld de, MR_MIME_LV20
	farcall IsCardIDInDeckAndNotInHandOrPlayArea
	jr nc, .target_mr_mime_lv28
; find trade card
	ld [wTempAIMultiTargetCardDeckIndex1], a
	ld de, TENTACOOL
	farcall LookForCardIDInHandList
	ret c
	ld de, SCYTHER_LV25
	farcall LookForCardIDInHandList
	ret c
	ld de, CHANSEY_LV55
	farcall LookForCardIDInHandList
	ret c
	ld de, KADABRA_LV39
	farcall LookForCardIDInHandList
	ret c
	ld de, ABRA_LV14
	farcall LookForCardIDInHandList
	ret c
	ld de, MR_MIME_LV28
	farcall LookForCardIDInHandList
	ret c

.target_mr_mime_lv28
	ld de, ALAKAZAM_LV42
	farcall IsCardIDInHandOrPlayArea
	jr nc, .target_kadabra_2
	ld de, MR_MIME_LV20
	farcall IsCardIDInHandOrPlayArea
	jr nc, .target_kadabra_2
	ld de, MR_MIME_LV28
	farcall IsCardIDInDeckAndNotInHandOrPlayArea
	jr nc, .target_kadabra_2
; find trade card
	ld [wTempAIMultiTargetCardDeckIndex1], a
	ld de, TENTACOOL
	farcall LookForCardIDInHandList
	ret c
	ld de, SCYTHER_LV25
	farcall LookForCardIDInHandList
	ret c
	ld de, CHANSEY_LV55
	farcall LookForCardIDInHandList
	ret c
	ld de, KADABRA_LV39
	farcall LookForCardIDInHandList
	ret c
	ld de, ABRA_LV14
	farcall LookForCardIDInHandList
	ret c

.target_kadabra_2
	ld de, ABRA_LV14
	farcall IsCardIDInHandOrPlayArea
	jr nc, .target_chansey
	ld de, ALAKAZAM_LV42
	farcall IsCardIDInHandOrPlayArea
	jr nc, .target_chansey
	ld de, MR_MIME_LV28
	farcall IsCardIDInHandOrPlayArea
	jr nc, .target_chansey
	ld de, MR_MIME_LV20
	farcall IsCardIDInHandOrPlayArea
	jr nc, .target_chansey
	ld de, KADABRA_LV39
	farcall IsCardIDInDeckAndNotInHandOrPlayArea
	jr nc, .target_chansey
; find trade card
	ld [wTempAIMultiTargetCardDeckIndex1], a
	ld de, TENTACOOL
	farcall LookForCardIDInHandList
	ret c
	ld de, SCYTHER_LV25
	farcall LookForCardIDInHandList
	ret c
	ld de, CHANSEY_LV55
	farcall LookForCardIDInHandList
	ret c

.target_chansey
	ld de, KADABRA_LV39
	farcall IsCardIDInHandOrPlayArea
	jr nc, .target_scyther
	ld de, ALAKAZAM_LV42
	farcall IsCardIDInHandOrPlayArea
	jr nc, .target_scyther
	ld de, MR_MIME_LV28
	farcall IsCardIDInHandOrPlayArea
	jr nc, .target_scyther
	ld de, MR_MIME_LV20
	farcall IsCardIDInHandOrPlayArea
	jr nc, .target_scyther
	ld de, CHANSEY_LV55
	farcall IsCardIDInDeckAndNotInHandOrPlayArea
	jr nc, .target_scyther
; find trade card
	ld [wTempAIMultiTargetCardDeckIndex1], a
	ld de, TENTACOOL
	farcall LookForCardIDInHandList
	ret c
	ld de, SCYTHER_LV25
	farcall LookForCardIDInHandList
	ret c
	ld de, ABRA_LV14
	farcall LookForCardIDInHandList
	ret c

.target_scyther
	ld de, ALAKAZAM_LV42
	farcall IsCardIDInHandOrPlayArea
	jr nc, .target_tentacool
	ld de, MR_MIME_LV28
	farcall IsCardIDInHandOrPlayArea
	jr nc, .target_tentacool
	ld de, MR_MIME_LV20
	farcall IsCardIDInHandOrPlayArea
	jr nc, .target_tentacool
	ld de, CHANSEY_LV55
	farcall IsCardIDInHandOrPlayArea
	jr nc, .target_tentacool
	ld de, SCYTHER_LV25
	farcall IsCardIDInDeckAndNotInHandOrPlayArea
	jr nc, .target_tentacool
; find trade card
	ld [wTempAIMultiTargetCardDeckIndex1], a
	ld de, TENTACOOL
	farcall LookForCardIDInHandList
	ret c
	ld de, KADABRA_LV39
	farcall LookForCardIDInHandList
	ret c
	ld de, ABRA_LV14
	farcall LookForCardIDInHandList
	ret c

.target_tentacool
	ld de, ALAKAZAM_LV42
	farcall IsCardIDInHandOrPlayArea
	ret nc
	ld de, MR_MIME_LV28
	farcall IsCardIDInHandOrPlayArea
	ret nc
	ld de, MR_MIME_LV20
	farcall IsCardIDInHandOrPlayArea
	ret nc
	ld de, SCYTHER_LV25
	farcall IsCardIDInHandOrPlayArea
	ret nc
	ld de, CHANSEY_LV55
	farcall IsCardIDInHandOrPlayArea
	ret nc
	ld de, TENTACOOL
	farcall IsCardIDInDeckAndNotInHandOrPlayArea
	ret nc
; find trade card
	ld [wTempAIMultiTargetCardDeckIndex1], a
	ld de, KADABRA_LV39
	farcall LookForCardIDInHandList
	ret c
	ld de, ABRA_LV14
	farcall LookForCardIDInHandList
	ret

AIDecide_PokemonCenter_ImmortalPokemonDeck:
	farcall CheckIfArenaCardCanRetreat
	jr c, .tally
	xor a
	ldh [hTempPlayAreaLocation_ff9d], a
	farcall CheckIfDefendingPokemonCanKnockOut
	jr nc, .tally
	call SwapTurn
	call CountPrizes
	call SwapTurn
	cp 4
	ret c

.tally
	call .TallyDamageCountersAndDiscardEnergy
	ld a, h
	or a
	jr nz, .discard_energy
	ld a, l
	cp 15
	ccf
	ret c

.discard_energy
	cp 4
	ret nc
	ld a, l
	cp 20
	ccf
	ret

.TallyDamageCountersAndDiscardEnergy:
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	ld d, a
	ld e, PLAY_AREA_ARENA
	lb hl, 0, 0
.loop_play_area
	call GetCardDamageAndMaxHP
	or a
	jr z, .next
	farcall ConvertHPToCounters
	add l
	ld l, a
	call GetPlayAreaCardAttachedEnergies
	ld a, [wTotalAttachedEnergies]
	add h
	ld h, a
.next
	inc e
	ld a, e
	cp d
	jr nz, .loop_play_area
; done
	ld a, l
	ret

; return carry and output three selected cards to
; {a, wTempAIMultiTargetCardDeckIndex1, wTempAIMultiTargetCardDeckIndex2}
; bug: may illegally allow any card
; fan-favourite cheating bug, too fitting for "immortal" deck by "magician"
AIDecide_NightlyGarbageRun_ImmortalPokemonDeck:
; init
	ld a, $ff
	ld [wTempAIMultiTargetCardDeckIndex1], a
	ld [wTempAIMultiTargetCardDeckIndex2], a
	ld [wTempAIMultiTargetCardDeckIndex3], a

	ld a, CARD_LOCATION_DISCARD_PILE
	ld de, MR_MIME_LV20
	farcall FindCardIDInLocation
	jr nc, .target_other_pkmn
	call .store_card

	ld a, CARD_LOCATION_DISCARD_PILE
	farcall CreateBasicEnergyCardListInLocation
	ld hl, wDuelTempList
	jr .loop_cards_in_discard_pile

.target_other_pkmn
	ld a, CARD_LOCATION_DISCARD_PILE
	ld de, ABRA_LV14
	farcall FindCardIDInLocation
	call c, .store_card
	ld a, CARD_LOCATION_DISCARD_PILE
	ld de, KADABRA_LV39
	farcall FindCardIDInLocation
	call c, .store_card
	ld a, CARD_LOCATION_DISCARD_PILE
	ld de, ALAKAZAM_LV42
	farcall FindCardIDInLocation
	call c, .store_card
	ld a, CARD_LOCATION_DISCARD_PILE
	ld de, SCYTHER_LV25
	farcall FindCardIDInLocation
	call c, .store_card
	ld a, CARD_LOCATION_DISCARD_PILE
	ld de, CHANSEY_LV55
	farcall FindCardIDInLocation
	call c, .store_card
	ld a, CARD_LOCATION_DISCARD_PILE
	ld de, TENTACOOL
	farcall FindCardIDInLocation
	call c, .store_card

; re-init
	ld a, $ff
	ld [wTempAIMultiTargetCardDeckIndex1], a
	ld [wTempAIMultiTargetCardDeckIndex2], a
	ld [wTempAIMultiTargetCardDeckIndex3], a

	ld a, CARD_LOCATION_DISCARD_PILE
	farcall CreateBasicEnergyCardListInLocation
	cp 6
	ccf
	jr nc, .target_any

	ld hl, wDuelTempList
.loop_cards_in_discard_pile
	ld a, [hli]
	cp $ff
	jr z, .shift
	call .store_card
	jr .loop_cards_in_discard_pile

.target_any
	ld a, DUELVARS_NUMBER_OF_CARDS_NOT_IN_DECK
	get_turn_duelist_var
	cp DECK_SIZE - 9
	ccf
	ret nc

; bug: lists all cards in discard pile here, illegally allowing any card
	bank1call CreateDiscardPileCardList
	ld hl, wDuelTempList
	jr .loop_cards_in_discard_pile

; shift {#1, #2, #3} to {a, #1, #2}
; no carry if selected no cards
.shift
	ld a, [wTempAIMultiTargetCardDeckIndex1]
	push af
	ld a, [wTempAIMultiTargetCardDeckIndex2]
	ld [wTempAIMultiTargetCardDeckIndex1], a
	ld a, [wTempAIMultiTargetCardDeckIndex3]
	ld [wTempAIMultiTargetCardDeckIndex2], a
	pop af
	cp $ff
	jr z, .no_carry
; success
	scf
	ret

.no_carry
	or a
	ret

; a = deck index
.store_card
	ld b, a
	push hl
	ld hl, wTempAIMultiTargetCardDeckIndex1
	ld a, $ff
	cp [hl]
	jr z, .store
	inc hl
	cp [hl]
	jr z, .store
	inc hl
	cp [hl]
	ld [hl], b
	pop hl
	add sp, $02 ; exit
	jr .shift

.store
	ld [hl], b
	pop hl
	ret

AIDecide_Switch_ImmortalPokemonDeck:
	ld de, ALAKAZAM_LV42
	ld b, PLAY_AREA_ARENA
	farcall CountCardIDInTurnDuelistPlayArea
	cp 1
	jr nz, .check_mr_mime
	; has 1 Alakazam in Play Area, is it the Arena card?
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call GetCardIDFromDeckIndex
	cp16 ALAKAZAM_LV42
	jr z, .alakazam_is_arena

.check_mr_mime
	; is Arena card Mr. Mime?
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call GetCardIDFromDeckIndex
	cp16 MR_MIME_LV20
	jr z, .mr_mime_is_arena
	; no, is Alakazam in Play Area?
	ld de, ALAKAZAM_LV42
	ld b, PLAY_AREA_BENCH_1
	farcall FindCardIDInTurnDuelistsPlayArea
	ret nc ; no, exit
	; is Mr. Mime is Play Area?
	ld de, MR_MIME_LV20
	ld b, PLAY_AREA_BENCH_1
	farcall FindCardIDInTurnDuelistsPlayArea
	ret nc ; no, exit

	; there's Mr. Mime lv20 and Alakazam in Play Area
	; if Play Area is Mr. Mime lv28 or Kadabra, consider switching
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call GetCardIDFromDeckIndex
	cp16 MR_MIME_LV28
	jr z, .switch_if_statused
	cp16 KADABRA_LV39
	jr z, .switch_if_statused
.not_statused
	or a
	ret
.switch_if_statused
	; switch to Kadabra or Mr. Mime lv28 if statused
	ld a, DUELVARS_ARENA_CARD_STATUS
	get_turn_duelist_var
	or a
	jr z, .not_statused
	call IsPlayerArenaCardImmune
	ret nc
	ld de, KADABRA_LV39
	call FindCardIDInBenchWithEnoughEnergy
	ret c
	ld de, MR_MIME_LV28
	call FindCardIDInBenchWithEnoughEnergy
	ret

.alakazam_is_arena
	; has 1 Alakazam in Play Area and is Arena card
	; try switching to a viable bench Pokémon
	; that isn't Mr. Mime lv20
	farcall AIDecideBenchPokemonToSwitchTo
	ccf
	ret nc
	push af
	ld a, 50
	cp e
	jr nc, .no_carry
	pop af
	push af
	add DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call GetCardIDFromDeckIndex
	cp16 MR_MIME_LV20
	jr z, .no_carry
	pop af
	ret
.no_carry
	pop af
	or a
	ret

.mr_mime_is_arena
	; Mr. Mime lv20 is Arena card
	; try switching to a viable bench Pokémon
	; that isn't Alakazam
	farcall AIDecideBenchPokemonToSwitchTo
	ccf
	ret nc
	push af
	ld a, 50
	cp e
	jr nc, .no_carry
	pop af
	push af
	add DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call GetCardIDFromDeckIndex
	cp16 ALAKAZAM_LV42
	jr z, .no_carry
	pop af
	ret

; return carry if the defending (player's arena) card is under
; no-damage-or-effect substatus
IsPlayerArenaCardImmune:
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
	xor a ; DAMAGE_NORMAL
	ld [wLoadedAttackCategory], a
	bank1call HandleNoDamageOrEffectSubstatus
	call SwapTurn
	ret

AIDecide_ProfessorOak_TorrentialFloodDeck:
	; if number of deck cards remaining is fewer than 16, don't use
	ld a, DUELVARS_NUMBER_OF_CARDS_NOT_IN_DECK
	get_turn_duelist_var
	cp DECK_SIZE - 16
	ret nc

	; if has at least 4 Water energies in hand, don't use
	ld de, WATER_ENERGY
	call CountCardIDInHand
	cp 4
	ret nc

	; if has 7 or more cards in hand, don't use
	ld a, DUELVARS_NUMBER_OF_CARDS_IN_HAND
	get_turn_duelist_var
	cp 7
	ret nc

	; check if has Blastoise in play
	push af
	ld de, BLASTOISE_LV52
	ld b, PLAY_AREA_ARENA
	farcall FindCardIDInTurnDuelistsPlayArea
	pop bc
	jr c, .has_blastoise
	; no Blastoise, use if less than 5 cards in hand
	ld a, b
	cp 5
	ret

.has_blastoise
	; has Blastoise in play, use if less
	; than 3 Water Energy cards in hand
	ld de, WATER_ENERGY
	call CountCardIDInHand
	cp 3
	ret

AIDecide_PokemonTrader_TorrentialFloodDeck:
	ld de, POKEMON_BREEDER
	farcall LookForCardIDInHandList
	jr nc, .target_blastoise_no_breeder
	ld bc, SQUIRTLE_LV14
	ld de, BLASTOISE_LV52
	farcall LookForEvoCardInDeck_GivenPreevoInPlayArea
	ld de, BLASTOISE_LV52
	jp c, .find_trade_pkmn

.target_blastoise_no_breeder
	ld bc, WARTORTLE_LV24
	ld de, BLASTOISE_LV52
	farcall LookForEvoCardInDeck_GivenPreevoInPlayArea
	ld de, BLASTOISE_LV52
	jp c, .find_trade_pkmn

	ld de, SQUIRTLE_LV14
	ld b, PLAY_AREA_ARENA
	farcall FindCardIDInTurnDuelistsPlayArea
	jr nc, .target_squirtle
	ld de, BLASTOISE_LV52
	farcall LookForCardIDInHandList
	jr nc, .target_other_basic_pkmn
	ld de, POKEMON_BREEDER
	farcall LookForCardIDInHandList
	jr c, .target_other_basic_pkmn
; target wartortle
	ld de, WARTORTLE_LV24
	ld a, CARD_LOCATION_DECK
	farcall FindCardIDInLocation
	ld de, BLASTOISE_LV52
	jr c, .find_trade_pkmn

.target_other_basic_pkmn
	ld de, BLASTOISE_LV52
	ld b, PLAY_AREA_ARENA
	farcall FindCardIDInTurnDuelistsPlayArea
	jr nc, .target_squirtle
	ld de, LAPRAS_LV31
	farcall IsCardIDInDeckAndNotInHandOrPlayArea
	ld de, SQUIRTLE_LV14
	jr c, .find_trade_pkmn
	ld de, ARTICUNO_LV35
	farcall IsCardIDInDeckAndNotInHandOrPlayArea
	ld de, SQUIRTLE_LV14
	jr c, .find_trade_pkmn
	ld de, ARTICUNO_LV37
	farcall IsCardIDInDeckAndNotInHandOrPlayArea
	ld de, SQUIRTLE_LV14
	jr c, .find_trade_pkmn

.target_squirtle
	ld de, SQUIRTLE_LV14
	ld b, PLAY_AREA_ARENA
	farcall FindCardIDInTurnDuelistsPlayArea
	ccf
	ret nc
	ld de, WARTORTLE_LV24
	ld b, PLAY_AREA_ARENA
	farcall FindCardIDInTurnDuelistsPlayArea
	ccf
	ret nc
	ld de, BLASTOISE_LV52
	ld b, PLAY_AREA_ARENA
	farcall FindCardIDInTurnDuelistsPlayArea
	ccf
	ret nc
	ld de, SQUIRTLE_LV14
	ld a, CARD_LOCATION_DECK
	farcall FindCardIDInLocation
	ld de, SQUIRTLE_LV14
	ret nc

.find_trade_pkmn
	ld [wTempAIMultiTargetCardDeckIndex1], a
	call FindDifferentPokemonCardInHand
	ret

AIDecide_Switch_TorrentialFloodDeck:
	; use Switch if AI wants to switch normally,
	; and retreat cost is 2 or more
	farcall AIDecideWhetherToRetreat_ConsiderStatus
	jr nc, .else
	xor a
	ldh [hTempPlayAreaLocation_ff9d], a
	call GetPlayAreaCardRetreatCost
	cp 2
	jr nc, .switch
.else
	; if Arena is weak to defending card,
	; switch to a benched Articuno with enough energies
	farcall CheckIfArenaCardIsWeakToDefendingCard
	ret nc
	ld de, ARTICUNO_LV35
	call FindCardIDInBenchWithEnoughEnergy
	ret c
	ld de, ARTICUNO_LV37
	call FindCardIDInBenchWithEnoughEnergy
	ret
.switch
	farcall AIDecideBenchPokemonToSwitchTo
	ccf
	ret

AIDecide_ComputerSearch_TorrentialFloodDeck:
	ld de, SQUIRTLE_LV14
	ld b, PLAY_AREA_ARENA
	farcall FindCardIDInTurnDuelistsPlayArea
	jr nc, .target_professor_oak
	ld de, BLASTOISE_LV52
	farcall LookForCardIDInHandList
	jr nc, .target_blastoise
	ld de, POKEMON_BREEDER
	farcall LookForCardIDInHandList
	jr c, .target_professor_oak

; target pkmn breeder
	ld de, POKEMON_BREEDER
	ld a, CARD_LOCATION_DECK
	farcall FindCardIDInLocation
	jr c, .find_discard_cards
	jr .target_professor_oak

.target_blastoise
	ld de, POKEMON_BREEDER
	farcall LookForCardIDInHandList
	jr nc, .target_professor_oak
	ld de, BLASTOISE_LV52
	ld a, CARD_LOCATION_DECK
	farcall FindCardIDInLocation
	jr c, .find_discard_cards

.target_professor_oak
	ld a, DUELVARS_NUMBER_OF_CARDS_IN_HAND
	get_turn_duelist_var
	cp 6
	jr nc, .target_energy_retrieval
	ld de, PROFESSOR_OAK
	ld a, CARD_LOCATION_DECK
	farcall FindCardIDInLocation
	jr c, .find_discard_cards

.target_energy_retrieval
	ld de, BLASTOISE_LV52
	ld b, PLAY_AREA_ARENA
	farcall FindCardIDInTurnDuelistsPlayArea
	ret nc
	ld de, WATER_ENERGY
	call CountCardIDInDiscardPile
	cp 2
	ccf
	ret nc
	ld de, ENERGY_RETRIEVAL
	ld a, CARD_LOCATION_DECK
	farcall FindCardIDInLocation
	ret nc

.find_discard_cards
	ld [wTempAISingleTargetCardDeckIndex_2], a
	ld a, $ff
	ld [wTempAIMultiTargetCardDeckIndex1], a
	ld [wTempAIMultiTargetCardDeckIndex2], a
	ld [wTempAIMultiTargetCardDeckIndex3], a
	ld de, COMPUTER_SEARCH
	call LookForCardIDInHandList_IgnoreTrainerCardToPlay
	call c, .store_discard_cards
	ld de, PROFESSOR_OAK
	farcall CheckIfHandHasRepeatedCard
	call c, .store_discard_cards
	ld de, SWITCH
	farcall CheckIfHandHasRepeatedCard
	call c, .store_discard_cards
	ld de, POKEMON_BREEDER
	farcall CheckIfHandHasRepeatedCard
	call c, .store_discard_cards
	ld de, POKEMON_TRADER
	farcall CheckIfHandHasRepeatedCard
	call c, .store_discard_cards
	ld de, POTION
	farcall CheckIfHandHasRepeatedCard
	call c, .store_discard_cards
	ld de, ENERGY_RETRIEVAL
	farcall CheckIfHandHasRepeatedCard
	call c, .store_discard_cards
	ld de, ARTICUNO_LV37
	farcall CheckIfHandHasRepeatedCard
	call c, .store_discard_cards
	ld de, ARTICUNO_LV35
	farcall CheckIfHandHasRepeatedCard
	call c, .store_discard_cards
	ld de, LAPRAS_LV31
	farcall CheckIfHandHasRepeatedCard
	call c, .store_discard_cards
	ld de, BLASTOISE_LV52
	farcall CheckIfHandHasRepeatedCard
	call c, .store_discard_cards
	ld de, WARTORTLE_LV24
	farcall CheckIfHandHasRepeatedCard
	call c, .store_discard_cards
	or a
	ret

.store_discard_cards
	push af
	ld a, [wTempAIMultiTargetCardDeckIndex1]
	cp $ff
	jr nz, .latter_discard_card
	pop af
	ld [wTempAIMultiTargetCardDeckIndex1], a
	ret

.latter_discard_card
	pop af
	ld [wTempAIMultiTargetCardDeckIndex2], a
; success
	add sp, $02 ; exit
	ld a, [wTempAISingleTargetCardDeckIndex_2]
	scf
	ret

CountNonDrawEngineCardsInHand:
	ld a, DUELVARS_NUMBER_OF_CARDS_IN_HAND
	get_turn_duelist_var
	push af
	ld de, PROFESSOR_OAK
	call CountCardIDInHand
	ld b, a
	pop af
	sub b
	push af
	ld de, BILL
	call CountCardIDInHand
	ld b, a
	pop af
	sub b
	push af
	ld de, BILLS_TELEPORTER
	call CountCardIDInHand
	ld b, a
	pop af
	sub b
	push af
	ld de, POKEMON_TRADER
	call CountCardIDInHand
	ld b, a
	pop af
	sub b
	ret

AIDecide_ProfessorOak_TrainerImprisonDeck:
	; if has 16 or fewer cards remaining in deck, don't use
	ld a, DUELVARS_NUMBER_OF_CARDS_NOT_IN_DECK
	get_turn_duelist_var
	cp DECK_SIZE - 16
	ret nc

	; count number of turns AI has played (half of wDuelTurns)
	ld a, [wDuelTurns]
	srl a
	cp 5
	jr c, .less_than_5_turns
	; has played at least 5 turns, don't use
	; if number of cards in hand is 5 or more
	ld a, DUELVARS_NUMBER_OF_CARDS_IN_HAND
	get_turn_duelist_var
	cp 4
	ret nc
.less_than_5_turns
	; copy hand card list to wc000
	call CreateHandCardList
	ld hl, wDuelTempList
	ld de, wc000
.loop_copy
	ld a, [hli]
	ld [de], a
	inc de
	cp $ff
	jr nz, .loop_copy
	ld hl, wc000

.loop_cards
	ld a, [hli]
	cp $ff
	jp z, .set_carry

	; if is Professor Oak, continue
	push hl
	call GetCardIDFromDeckIndex
	cp16 PROFESSOR_OAK
	jr z, .next_card

	; if is Pokémon Trader and it will be used,
	; then don't use Professor Oak
	cp16 POKEMON_TRADER
	jr nz, .not_pkmn_trader
	call AIDecide_PokemonTrader_TrainerImprisonDeck
	jr c, .no_carry
	jr .next_card
.not_pkmn_trader
	; if is any of the following cards, continue
	cp16 PSYCHIC_ENERGY
	jr z, .next_card
	cp16 FULLHEAL_ENERGY
	jr z, .next_card

	cp16 ODDISH_LV21
	jr z, .oddish_or_gloom
	cp16 DARK_GLOOM
	jr z, .oddish_or_gloom

	cp16 MR_MIME_LV20
	jr z, .next_card

	; if is Dark Golduck and Psyduck is in Play Area, don't use
	cp16 DARK_GOLDUCK
	jr nz, .haunter
	ld de, PSYDUCK_LV15
	ld b, PLAY_AREA_ARENA
	farcall FindCardIDInTurnDuelistsPlayArea
	jr c, .no_carry
	jr .next_card

.haunter
	; if is Haunter and Gastly is in Play Area, don't use
	cp16 HAUNTER_LV26
	jr nz, .no_carry
	ld de, GASTLY_LV13
	ld b, PLAY_AREA_ARENA
	farcall FindCardIDInTurnDuelistsPlayArea
	jr c, .no_carry
	jr .next_card

.oddish_or_gloom
	; if is Oddish or Dark Gloom and not
	; on the bench yet, then don't use
	ld b, PLAY_AREA_BENCH_1
	farcall FindCardIDInTurnDuelistsPlayArea
	jr c, .next_card
.no_carry
	; don't use Professor Oak
	pop hl
	or a
	ret
.next_card
	pop hl
	jp .loop_cards

.set_carry
	; use Professor Oak
	scf
	ret

AIDecide_PokemonTrader_TrainerImprisonDeck:
	ld bc, DARK_GLOOM
	ld de, DARK_VILEPLUME
	farcall LookForEvoCardInDeck_GivenPreevoInPlayArea
	ld de, DARK_GLOOM
	jr c, .asm_4b022
	ld de, DARK_VILEPLUME
	farcall LookForCardIDInHandList
	jr nc, .asm_4b012
	ld bc, ODDISH_LV21
	ld de, DARK_GLOOM
	farcall LookForEvoCardInDeck_GivenPreevoInPlayArea
	ld de, DARK_VILEPLUME
	jr c, .asm_4b022
.asm_4b012
	ld de, ODDISH_LV21
	ld bc, DARK_GLOOM
	farcall LookForCardIDInDeck_GivenCardIDInHand
	ld de, DARK_GLOOM
	jr c, .asm_4b022
	ret
.asm_4b022
	ld [wd097], a
	call FindDifferentPokemonCardInHand
	ret

AIDecideFoxfireTarget:
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
	jr nc, .no_carry ; enough energy
	ld a, b
	add c
	cp 2
	jr c, .no_carry ; only needs 1 energy
	ld a, SECOND_ATTACK
	ld [wSelectedAttack], a
	farcall CheckEnergyNeededForAttack
	jr nc, .no_carry ; enough energy
	ld a, b
	add c
	cp 2
	jr c, .no_carry ; only needs 1 energy
	; neither attack has enough energy
	; and both need at least 2 more energies
	scf
	ret

.no_carry
	or a
	ret

AIDecide_ProfessorOak_BlazingFlameDeck:
	; if 17 or fewer cards remaining in deck, don't use
	ld a, DUELVARS_NUMBER_OF_CARDS_NOT_IN_DECK
	get_turn_duelist_var
	cp DECK_SIZE - 17
	ret nc

	; check if has energy cards
	farcall CountEnergyCardsInHand
	jr c, .else
	; if yes, check how many Pokémon in Play Area
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	cp 1
	jr z, .else
	; if more than 1, don't use if has 5 or more hand cards
	ld a, DUELVARS_NUMBER_OF_CARDS_IN_HAND
	get_turn_duelist_var
	cp 5
	ret nc
.else
	; copy hand cards to wc000
	call CreateHandCardList
	ld hl, wDuelTempList
	ld de, wc000
.loop_copy
	ld a, [hli]
	ld [de], a
	inc de
	cp $ff
	jr nz, .loop_copy

	ld hl, wc000
.loop_cards
	ld a, [hli]
	cp $ff
	jp z, .set_carry
	push hl
	call GetCardIDFromDeckIndex

	; if is any of the following cards, continue
	cp16 PROFESSOR_OAK
	jp z, .next_card
	cp16 ENERGY_RETRIEVAL
	jp z, .next_card
	cp16 SWITCH
	jp z, .next_card

	; if is Potion and has any damage counters, don't use
	cp16 POTION
	jr nz, .computer_search
	call CheckIfAnyPlayAreaPokemonHasDamage
	jp c, .no_carry
	jp .next_card

.computer_search
	; if is Computer Search and has at least
	; 4 cards in hand, then don't use
	cp16 COMPUTER_SEARCH
	jr nz, .pkmn_trader
	ld a, DUELVARS_NUMBER_OF_CARDS_IN_HAND
	get_turn_duelist_var
	cp 4
	jr nc, .no_carry
	jr .next_card

.pkmn_trader
	; if is Pokémon Trader, and has Pkmn cards
	; in hand, then don't use
	cp16 POKEMON_TRADER
	jr nz, .fire_energy
	farcall CountNumberOfPkmnInPlayAreaAndInHand
	push af
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	pop bc
	cp b ; if different, it means that has hand Pkmn cards
	jr nz, .no_carry
	jr .next_card

.fire_energy
	; if is Fire Energy and has more than
	; 1 Pokémon in Play Area, don't use
	cp16 FIRE_ENERGY
	jr nz, .ninetales
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	cp 1
	jr nz, .no_carry
	jr .next_card

.ninetales
	; if is Ninetales and Vulpix is in Play Area, don't use
	cp16 NINETALES_LV32
	jr nz, .arcanine
	ld de, VULPIX_LV13
	ld b, PLAY_AREA_ARENA
	farcall FindCardIDInTurnDuelistsPlayArea
	jr c, .no_carry
	jr .next_card

.arcanine
	; if is Arcanine and Growlithe is in Play Area, don't use
	cp16 ARCANINE_LV34
	jr z, .is_arcanine
	cp16 ARCANINE_LV45
	jr nz, .not_arcanine
.is_arcanine
	ld de, GROWLITHE_LV18
	ld b, PLAY_AREA_ARENA
	farcall FindCardIDInTurnDuelistsPlayArea
	jr c, .no_carry
	jr .next_card

.not_arcanine
	; if is a Pokémon card not in Play Area, don't use
	ld b, PLAY_AREA_ARENA
	farcall FindCardIDInTurnDuelistsPlayArea
	jr c, .next_card
.no_carry
	; don't use Professor Oak
	pop hl
	or a
	ret

.next_card
	pop hl
	jp .loop_cards

.set_carry
	; use Professor Oak
	scf
	ret

AIDecide_PokemonTrader_BlazingFlameDeck:
	ld de, VULPIX_LV13
	ld b, PLAY_AREA_ARENA
	farcall FindCardIDInTurnDuelistsPlayArea
	jr nc, .target_arcanine
	ld e, a
	call GetPlayAreaCardAttachedEnergies
	ld a, [wTotalAttachedEnergies]
	cp 2
	jr c, .target_arcanine
	ld de, NINETALES_LV32
	farcall IsCardIDInDeckAndNotInHand
	ld de, NINETALES_LV32
	jp c, .find_trade_pkmn

.target_arcanine
	ld de, GROWLITHE_LV18
	ld b, PLAY_AREA_ARENA
	farcall FindCardIDInTurnDuelistsPlayArea
	jr nc, .find_vulpix_or_growlithe_with_most_energy
	ld e, a
	call GetPlayAreaCardAttachedEnergies
	ld a, [wTotalAttachedEnergies]
	cp 2
	jr c, .find_vulpix_or_growlithe_with_most_energy
	ld a, e
	call CheckIfPokemonHasDamage
	jr c, .prefer_arcanine_lv34
	ld de, ARCANINE_LV45
	ld b, PLAY_AREA_ARENA
	farcall FindCardIDInTurnDuelistsPlayArea
	jr nc, .check_damage_again
.prefer_arcanine_lv34
	ld de, ARCANINE_LV34
	farcall IsCardIDInDeckAndNotInHand
	ld de, ARCANINE_LV34
	jp c, .find_trade_pkmn
	ld de, ARCANINE_LV45
	farcall IsCardIDInDeckAndNotInHand
	ld de, ARCANINE_LV45
	jp c, .find_trade_pkmn
	jr .find_vulpix_or_growlithe_with_most_energy
.check_damage_again
	call CheckIfPokemonHasDamage
	jr nc, .prefer_arcanine_lv45
	ld de, ARCANINE_LV34
	ld b, PLAY_AREA_ARENA
	farcall FindCardIDInTurnDuelistsPlayArea
	jr nc, .find_vulpix_or_growlithe_with_most_energy
.prefer_arcanine_lv45
	ld de, ARCANINE_LV45
	farcall IsCardIDInDeckAndNotInHand
	ld de, ARCANINE_LV45
	jp c, .find_trade_pkmn
	ld de, ARCANINE_LV34
	farcall IsCardIDInDeckAndNotInHand
	ld de, ARCANINE_LV34
	jp c, .find_trade_pkmn

.find_vulpix_or_growlithe_with_most_energy
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	ld d, a
	ld e, PLAY_AREA_ARENA
	ld b, 0
	ld c, $ff
.loop_play_area
	ld a, e
	add DUELVARS_ARENA_CARD
	get_turn_duelist_var
	push bc
	push de
	call GetCardIDFromDeckIndex
	cp16 VULPIX_LV13
	jr z, .basic_pkmn_to_evolve
	cp16 GROWLITHE_LV18
	jr nz, .next_pop
.basic_pkmn_to_evolve
	pop de
	pop bc
	call GetPlayAreaCardAttachedEnergies
	ld a, [wTotalAttachedEnergies]
	cp b
	jr c, .next
	ld b, a
	ld c, e
	jr .next
.next_pop
	pop de
	pop bc
.next
	inc e
	ld a, e
	cp d
	jr nz, .loop_play_area
	ld a, c
	cp $ff
	jr z, .target_basic_pkmn

; found, target evo
	add DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call GetCardIDFromDeckIndex
	cp16 GROWLITHE_LV18
	jr z, .target_arcanine_2
	ld de, NINETALES_LV32
	farcall IsCardIDInDeckAndNotInHand
	ld de, NINETALES_LV32
	jr c, .find_trade_pkmn
.target_arcanine_2
	ld de, ARCANINE_LV45
	farcall IsCardIDInDeckAndNotInHand
	ld de, ARCANINE_LV45
	jr c, .find_trade_pkmn
	ld de, ARCANINE_LV34
	farcall IsCardIDInDeckAndNotInHand
	ld de, ARCANINE_LV34
	jr c, .find_trade_pkmn

.target_basic_pkmn
	ld de, VULPIX_LV13
	ld b, PLAY_AREA_ARENA
	farcall FindCardIDInTurnDuelistsPlayArea
	ccf
	ret nc
	ld de, GROWLITHE_LV18
	ld b, PLAY_AREA_ARENA
	farcall FindCardIDInTurnDuelistsPlayArea
	ccf
	ret nc
; 1/2 chance each of preferring vulpix or growlithe
	ld a, 2
	call Random
	or a
	jr z, .target_growlithe
	ld de, VULPIX_LV13
	farcall IsCardIDInDeckAndNotInHand
	ld de, VULPIX_LV13
	jr c, .find_trade_pkmn
.target_growlithe
	ld de, GROWLITHE_LV18
	farcall IsCardIDInDeckAndNotInHand
	ld de, GROWLITHE_LV18
	jr c, .find_trade_pkmn
	ret

.find_trade_pkmn
	ld [wTempAIMultiTargetCardDeckIndex1], a
	call FindDifferentPokemonCardInHand
	ret

AIDecide_Switch_BlazingFlameDeck:
	; if AI wants to retreat normally, use
	; Switch if retreat cost is 1 or more
	farcall AIDecideWhetherToRetreat_ConsiderStatus
	ret nc
	xor a
	ldh [hTempPlayAreaLocation_ff9d], a
	call GetPlayAreaCardRetreatCost
	or a
	jr nz, .switch
	; else, use Switch if is Confused/Sleeping/Paralyzed
	ld a, DUELVARS_ARENA_CARD_STATUS
	get_turn_duelist_var
	and CNF_SLP_PRZ
	or a
	ret z
.switch
	farcall AIDecideBenchPokemonToSwitchTo
	ccf
	ret

AIDecide_EnergyRetrieval_BlazingFlameDeck:
	ld de, FIRE_ENERGY
	call CountCardIDInHand
	ret nc

	ld a, CARD_LOCATION_DISCARD_PILE
	farcall CreateBasicEnergyCardListInLocation
	cp 2
	ccf
	ret nc

	ld a, [wDuelTempList]
	ld [wTempAIMultiTargetCardDeckIndex1], a
	ld a, [wDuelTempList + 1]
	ld [wTempAIMultiTargetCardDeckIndex2], a

; find discard card
	call CreateHandCardList
	ld hl, wDuelTempList
	ld de, wTempCardCollection
.loop_copy
	ld a, [hli]
	ld [de], a
	inc de
	cp $ff
	jr nz, .loop_copy

	ld hl, wTempCardCollection
.loop_hand_cards
	ld a, [hl]
	cp $ff
	jp z, .no_carry
	push hl
	call GetCardIDFromDeckIndex
	cp16 PROFESSOR_OAK
	jr nz, .try_other_trainers
	ld de, PROFESSOR_OAK
	farcall CheckIfHandHasRepeatedCard
	jp c, .found_discard_card
	ld a, DUELVARS_NUMBER_OF_CARDS_NOT_IN_DECK
	get_turn_duelist_var
	cp DECK_SIZE - 17
	jp nc, .found_discard_card
	jp .next_card
.try_other_trainers
	cp16 SWITCH
	jp z, .found_discard_card
	cp16 POTION
	jr nz, .try_ninetales
	call CheckIfAnyPlayAreaPokemonHasDamage
	jr c, .next_card
	jr .found_discard_card
.try_ninetales
	cp16 NINETALES_LV32
	jr nz, .try_arcanine
	ld de, VULPIX_LV13
	ld b, PLAY_AREA_ARENA
	farcall FindCardIDInTurnDuelistsPlayArea
	jr nc, .found_discard_card
	jr .next_card
.try_arcanine
	cp16 ARCANINE_LV34
	jr z, .check_growlithe_in_play
	cp16 ARCANINE_LV45
	jr nz, .try_other_pkmn
.check_growlithe_in_play
	ld de, GROWLITHE_LV18
	ld b, PLAY_AREA_ARENA
	farcall FindCardIDInTurnDuelistsPlayArea
	jr nc, .found_discard_card
	jr .next_card
.try_other_pkmn
	ld b, PLAY_AREA_ARENA
	push de
	farcall FindCardIDInTurnDuelistsPlayArea
	pop de
	jr c, .next_card
; try pkmn trader
	cp16 POKEMON_TRADER
	jr nz, .try_bill
	farcall CountNumberOfPkmnInPlayAreaAndInHand
	push af
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	pop bc
	cp b
	jr z, .found_discard_card
	jr .next_card
.try_bill
	cp16 BILL
	jr nz, .next_card
	ld a, DUELVARS_NUMBER_OF_CARDS_NOT_IN_DECK
	get_turn_duelist_var
	cp DECK_SIZE - 11
	jr nc, .found_discard_card

.next_card
	pop hl
	inc hl
	jp .loop_hand_cards

.found_discard_card
	pop hl
	ld a, [hl]
	scf
	ret

.no_carry
	or a
	ret

; a = PLAY_AREA_* location
Func_4b3d8:
	ldh [hTempPlayAreaLocation_ff9d], a
	xor a ; FIRST_ATTACK_OR_PKMN_POWER
	ld [wSelectedAttack], a
	call .CheckEnergyCost
	ret nc
	ld a, SECOND_ATTACK
	ld [wSelectedAttack], a

.CheckEnergyCost:
	farcall CheckEnergyNeededForAttack
	ccf
	ret c
	ld a, b
	add c
	or a
	ret nz
	scf
	ret

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
	ld [wTempAIEnergyCard], a
	push hl
	call GetCardIDFromDeckIndex
	cp16 DOUBLE_COLORLESS_ENERGY
	pop hl
	jr nz, .loop_energy_cards
	ld a, [wTempAIEnergyCard]
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

AIDeckSpecificAttackLogic:
	ld a, [wOpponentDeckID]
	cp TEN_THOUSAND_VOLTS_DECK_ID
	jr z, .TenThousandVoltsDeck
	cp PUPPET_MASTER_DECK_ID
	jp z, .PuppetMasterDeck
	cp STEADY_INCREASE_DECK_ID
	jp z, .SteadyIncreaseDeck
	cp DARK_SCIENCE_DECK_ID
	jp z, .DarkScienceDeck
	cp GREAT_DRAGON_DECK_ID
	jp z, .GreatDragonDeck
	cp BUG_COLLECTING_DECK_ID
	jp z, .BugCollectingDeck
	cp COMPLETE_COMBUSTION_DECK_ID
	jp z, .CompleteCombustionDeck
	cp WHIRLPOOL_SHOWER_DECK_ID
	jp z, .WhirlpoolShowerDeck
	cp SUPERDESTRUCTIVE_POWER_DECK_ID
	jp z, .SuperdestructivePowerDeck
	cp POKEMON_POWER_DECK_ID
	jp z, .PokemonPowerDeck
	cp SPIRITED_AWAY_DECK_ID
	jp z, .SpiritedAwayDeck
	cp EYE_OF_THE_STORM_DECK_ID
	jp z, .EyeOfTheStormDeck
	cp VERY_RARE_CARD_DECK_ID
	jp z, .VeryRareCardDeck
	cp BAD_GUYS_DECK_ID
	jp z, .BadGuysDeck
	cp POISON_MIST_DECK_ID
	jp z, .PoisonMistDeck
	cp PSYCHIC_BATTLE_DECK_ID
	jp z, .PsychicBattleDeck
	cp TSUNAMI_STARTER_DECK_ID
	jp z, .TsunamiStarterDeck
	cp PROTOHISTORIC_DECK_ID
	jp z, .ProtohistoricDeck
	cp COLORLESS_ENERGY_DECK_ID
	jp z, .ColorlessEnergyDeck
	cp IMMORTAL_POKEMON_DECK_ID
	jp z, .ImmortalPokemonDeck
	cp BLAZING_FLAME_DECK_ID
	jp z, .BlazingFlameDeck
	cp DAMAGE_CHAOS_DECK_ID
	jp z, .DamageChaosDeck
	cp BIG_THUNDER_DECK_ID
	jp z, .BigThunderDeck

.standard_score
	ld a, AI_SCORE_NEUTRAL
	ret

; Zapdos's Thunderbolt: +10 if in KO range of defending pkmn
.TenThousandVoltsDeck
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call GetCardIDFromDeckIndex
	cp16 ZAPDOS_LV64
	jr nz, .standard_score
	ld a, [wSelectedAttack]
	or a
	jr z, .standard_score
	xor a ; PLAY_AREA_ARENA
	ldh [hTempPlayAreaLocation_ff9d], a
	farcall CheckIfDefendingPokemonCanKnockOut
	jr nc, .standard_score
	ld a, AI_SCORE_NEUTRAL + 10
	ret

; Slowpoke's Scavenge:
; +10 if can retrieve Clefairy Doll;
; -10 otherwise
.PuppetMasterDeck
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call GetCardIDFromDeckIndex
	cp16 SLOWPOKE_LV18
	jr nz, .standard_score
	ld a, [wSelectedAttack]
	or a
	jr z, .standard_score
	ld de, CLEFAIRY_DOLL
	ld a, CARD_LOCATION_DISCARD_PILE
	farcall FindCardIDInLocation
	jr c, .encourage_scavenge
; discourage
	ld a, AI_SCORE_NEUTRAL - 10
	ret
.encourage_scavenge
	ld a, AI_SCORE_NEUTRAL + 10
	ret

; Call for Family variants:
; +5 if has <= 2 benched pkmn
.SteadyIncreaseDeck:
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call GetCardIDFromDeckIndex
	cp16 ODDISH_LV8
	jr z, .check_call_for_family
	cp16 PARAS_LV15
	jr z, .check_call_for_family
	cp16 BELLSPROUT_LV11
	jr nz, .standard_score
.check_call_for_family
	ld a, [wSelectedAttack]
	or a
	jr z, .standard_score
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	cp 4
	jr nc, .standard_score
	ld a, AI_SCORE_NEUTRAL + 5
	ret

; Grimer's Poison Gas:
; +5 if Poison Mist is active
.DarkScienceDeck:
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call GetCardIDFromDeckIndex
	cp16 GRIMER_LV10
	jp nz, .standard_score
	ld a, [wSelectedAttack]
	or a
	jp nz, .standard_score
	bank1call IsPoisonMistActive
	jp nc, .standard_score
	ld a, AI_SCORE_NEUTRAL + 5
	ret

; Charmeleon's Flamethrower: -5
.GreatDragonDeck:
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call GetCardIDFromDeckIndex
	cp16 CHARMELEON
	jp nz, .standard_score
	ld a, [wSelectedAttack]
	or a
	jp z, .standard_score
	ld a, AI_SCORE_NEUTRAL - 5
	ret

; Dark Persian's Fascinate
; expectation: encourage if has good gusting target
; reality: neutral anyway
.BugCollectingDeck:
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call GetCardIDFromDeckIndex
	cp16 DARK_PERSIAN_LV28
	jp nz, .standard_score
	ld a, [wSelectedAttack]
	or a
	jp nz, .standard_score
	farcall AIDecide_GustOfWind
	jp nc, .standard_score
	ld a, AI_SCORE_NEUTRAL
	ret

; Arcanine's Take Down: -4
.CompleteCombustionDeck:
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call GetCardIDFromDeckIndex
	cp16 ARCANINE_LV45
	jp nz, .standard_score
	ld a, [wSelectedAttack]
	or a
	jp z, .standard_score
	ld a, AI_SCORE_NEUTRAL - 4
	ret

; Dark Starmie's Spinning Shower: +12
.WhirlpoolShowerDeck:
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call GetCardIDFromDeckIndex
	cp16 DARK_STARMIE
	jp nz, .standard_score
	ld a, [wSelectedAttack]
	or a
	jp z, .standard_score
	ld a, AI_SCORE_NEUTRAL + 12
	ret

; Kadabra's Recover:
; +12 if no benched pkmn AND in KO range of defending pkmn;
; Dark Hypno's Bench Manipulation:
; +12 if player has >= 2 benched pkmn
.SuperdestructivePowerDeck:
.PokemonPowerDeck:
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call GetCardIDFromDeckIndex
	cp16 KADABRA_LV38
	jr z, .kadabra
	cp16 DARK_HYPNO
	jp nz, .standard_score
	ld a, [wSelectedAttack]
	or a
	jp z, .standard_score
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	call GetNonTurnDuelistVariable
	cp 3
	jp c, .standard_score
	ld a, AI_SCORE_NEUTRAL + 12
	ret
.kadabra
	ld a, [wSelectedAttack]
	or a
	jp nz, .standard_score
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	cp 1
	jp nz, .standard_score
	xor a ; PLAY_AREA_ARENA
	ldh [hTempPlayAreaLocation_ff9d], a
	farcall CheckIfDefendingPokemonCanKnockOut
	jp nc, .standard_score
	ld a, AI_SCORE_NEUTRAL + 12
	ret

; Dark Gengar: +5
.SpiritedAwayDeck:
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call GetCardIDFromDeckIndex
	cp16 DARK_GENGAR
	jp nz, .standard_score
	ld a, AI_SCORE_NEUTRAL + 5
	ret

; Pidgeot's Hurricane:
; +12 if against evolved pkmn OR against basic pkmn with >= 3 energy attached;
; -2 otherwise
.EyeOfTheStormDeck:
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call GetCardIDFromDeckIndex
	cp16 PIDGEOT_LV40
	jr z, .pidgeot
	jp .standard_score
.pidgeot
	ld a, [wSelectedAttack]
	or a
	jp z, .standard_score
	call SwapTurn
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call LoadCardDataToBuffer2_FromDeckIndex
	ld a, [wLoadedCard2Stage]
	or a
	jr nz, .encourage_hurricane
	ld e, PLAY_AREA_ARENA
	call GetPlayAreaCardAttachedEnergies
	ld a, [wTotalAttachedEnergies]
	cp 3
	jr nc, .encourage_hurricane
	call SwapTurn
	ld a, AI_SCORE_NEUTRAL - 2
	ret
.encourage_hurricane
	call SwapTurn
	ld a, AI_SCORE_NEUTRAL + 12
	ret

; Magikarp's Dragon Rage: +2
.VeryRareCardDeck:
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call GetCardIDFromDeckIndex
	cp16 MAGIKARP_LV10
	jr z, .magikarp
	jp .standard_score
.magikarp
	ld a, [wSelectedAttack]
	or a
	jp z, .standard_score
	ld a, AI_SCORE_NEUTRAL + 2
	ret

; Oddish's Sleep Powder:
; +2 if newly inflicts sleep
.BadGuysDeck:
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call GetCardIDFromDeckIndex
	cp16 ODDISH_LV21
	jr z, .oddish
	jp .standard_score
.oddish
	ld a, [wSelectedAttack]
	or a
	jp nz, .standard_score
	ld a, DUELVARS_ARENA_CARD_STATUS
	call GetNonTurnDuelistVariable
	and CNF_SLP_PRZ
	cp ASLEEP
	jp nz, .standard_score
	ld a, AI_SCORE_NEUTRAL + 2
	ret

; Grimer's Poison Gas:
; expectation: +5 if Poison Mist is active
; reality: +5 if against Poison Mist user
.PoisonMistDeck:
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call GetCardIDFromDeckIndex
	cp16 GRIMER_LV10
	jp nz, .standard_score
	ld a, [wSelectedAttack]
	or a
	jp nz, .standard_score
	ld a, DUELVARS_ARENA_CARD_FLAGS
	call GetNonTurnDuelistVariable
	and AFFECTED_BY_POISON_MIST
	jp z, .standard_score
	ld a, AI_SCORE_NEUTRAL + 5
	ret

; Mewtwo's Barrier: -10
.PsychicBattleDeck:
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call GetCardIDFromDeckIndex
	cp16 MEWTWO_LV53
	jp nz, .standard_score
	ld a, [wSelectedAttack]
	or a
	jp z, .standard_score
	ld a, AI_SCORE_NEUTRAL - 10
	ret

; Squirtle's Withdraw, Dark Blastoise's Rocket Tackle: -10
.TsunamiStarterDeck:
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call GetCardIDFromDeckIndex
	cp16 SQUIRTLE_LV8
	jr z, .squirtle_or_dark_blastoise
	cp16 DARK_BLASTOISE
	jp nz, .standard_score
.squirtle_or_dark_blastoise
	ld a, [wSelectedAttack]
	or a
	jp z, .standard_score
	ld a, AI_SCORE_NEUTRAL - 10
	ret

; Kangaskhan's Comet Punch:
; -10 if has <= 2 cards in hand or has no benched pkmn
.ProtohistoricDeck:
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call GetCardIDFromDeckIndex
	cp16 KANGASKHAN_LV40
	jp nz, .standard_score
	ld a, [wSelectedAttack]
	or a
	jp z, .standard_score
	ld a, DUELVARS_NUMBER_OF_CARDS_IN_HAND
	get_turn_duelist_var
	cp 3
	jr c, .discourage_comet_punch
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	cp 1
	jp nz, .standard_score
.discourage_comet_punch
	ld a, AI_SCORE_NEUTRAL - 10
	ret

; Fearow's Agility: +3
.ColorlessEnergyDeck:
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call GetCardIDFromDeckIndex
	cp16 FEAROW_LV27
	jp nz, .standard_score
	ld a, [wSelectedAttack]
	or a
	jp nz, .standard_score
	ld a, AI_SCORE_NEUTRAL + 3
	ret

; Chansey's Double-Edge:
; -20 if no Alakazam, or no Mr. Mime or Chansey on bench
.ImmortalPokemonDeck:
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call GetCardIDFromDeckIndex
	cp16 CHANSEY_LV55
	jp nz, .standard_score
	ld a, [wSelectedAttack]
	or a
	jp z, .standard_score
	ld de, ALAKAZAM_LV42
	ld b, PLAY_AREA_BENCH_1
	farcall FindCardIDInTurnDuelistsPlayArea
	jr nc, .discourage_double_edge
	ld de, MR_MIME_LV28
	ld b, PLAY_AREA_BENCH_1
	farcall FindCardIDInTurnDuelistsPlayArea
	jr c, .neutral_double_edge
	ld de, CHANSEY_LV55
	ld b, PLAY_AREA_BENCH_1
	farcall FindCardIDInTurnDuelistsPlayArea
	jr nc, .discourage_double_edge
.neutral_double_edge
	ld a, AI_SCORE_NEUTRAL
	ret
.discourage_double_edge
	ld a, AI_SCORE_NEUTRAL - 20
	ret

; Ninetales' Lure: +3 if has good target;
; Base Set Arcanine's Flamethrower:
;   +3 if defending pkmn has <= 50 HP remaining
;   (not considering damage changes);
; Promo Arcanine: for (Quick Attack, Flames of Rage),
;   (-5, +5) if has >= 2 damage counters on it;
;   (+5, -5) otherwise
.BlazingFlameDeck:
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call GetCardIDFromDeckIndex
	cp16 NINETALES_LV32
	jr z, .ninetales
	cp16 ARCANINE_LV45
	jr z, .BlazingFlameDeck_arcanine_lv45
	cp16 ARCANINE_LV34
	jp nz, .standard_score
	ld a, [wSelectedAttack]
	or a
	jp nz, .check_damage_counters
	ld e, PLAY_AREA_ARENA
	call GetCardDamageAndMaxHP
	cp 2
	jr c, .BlazingFlameDeck_encourage
.BlazingFlameDeck_discourage
	ld a, AI_SCORE_NEUTRAL - 5
	ret
.check_damage_counters
	ld e, PLAY_AREA_ARENA
	call GetCardDamageAndMaxHP
	cp 2
	jr c, .BlazingFlameDeck_discourage
.BlazingFlameDeck_encourage
	ld a, AI_SCORE_NEUTRAL + 5
	ret
.BlazingFlameDeck_arcanine_lv45
	ld a, [wSelectedAttack]
	or a
	jp nz, .standard_score
	ld a, DUELVARS_ARENA_CARD_HP
	call GetNonTurnDuelistVariable
	cp 50
	jp nc, .standard_score
	ld a, AI_SCORE_NEUTRAL + 3
	ret
.ninetales
	ld a, [wSelectedAttack]
	or a
	jp nz, .standard_score
	call AIChoosePlayerBenchPkmnWithNotEnoughEnergiesOrHighRetreatCost
	jp nc, .standard_score
	ld a, AI_SCORE_NEUTRAL + 3
	ret

; Dark Gengar: +5;
; Clefairy's Follow Me: +1 if has good target, and defending pkmn has any energy attached
.DamageChaosDeck:
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call GetCardIDFromDeckIndex
	cp16 DARK_GENGAR
	jr z, .encourage_dark_gengar
	cp16 CLEFAIRY_LV15
	jp nz, .standard_score
	ld a, [wSelectedAttack]
	or a
	jp nz, .standard_score
	ld e, PLAY_AREA_ARENA
	call SwapTurn
	call GetPlayAreaCardAttachedEnergies
	call SwapTurn
	ld a, [wTotalAttachedEnergies]
	or a
	jp z, .standard_score
	ld a, FIGHTING
	call AIChooseFollowMeTarget
	jp nc, .standard_score
	ld a, AI_SCORE_NEUTRAL + 1
	ret
.encourage_dark_gengar
	ld a, AI_SCORE_NEUTRAL + 5
	ret

; Chansey's Double-Edge: +12
.BigThunderDeck:
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call GetCardIDFromDeckIndex
	cp16 CHANSEY_LV55
	jp nz, .standard_score
	ld a, [wSelectedAttack]
	or a
	jp z, .standard_score
	ld a, AI_SCORE_NEUTRAL + 12
	ret

FindLeastUsefulPokemonInHand:
	call FindUnusableEvolutionCardInHand
	ret c
	farcall IsSameCardInHandAndPlayArea
	ret c
	farcall FindDuplicatePokemonCardsInHand
	ret c
	ld a, AI_SEARCH_2_ONLY_EVOLUTION_PKMN
	call PickRandomCardOfSpecificTypeFromHand
	ret c
	ld a, AI_SEARCH_2_ONLY_BASIC_PKMN
	call PickRandomCardOfSpecificTypeFromHand
	ret

; get a random card from hand that matches AI_SEARCH_2_ONLY_* in a,
; return carry and the deck index
; no carry and a = $ff if not found
; cf. PickRandomCardOfSpecificTypeFromDeck
PickRandomCardOfSpecificTypeFromHand:
	ld [wTempAISearchCriteria], a
	call CreateHandCardList
	ld hl, wDuelTempList
	call CountCardsInDuelTempList
	call ShuffleCards
	ld hl, wDuelTempList
.loop_hand_cards
	ld a, [hli]
	cp $ff
	ret z ; not found
	ldh [hTempCardIndex_ff98], a
	call GetCardIDFromDeckIndex
	call GetCardType
	cp TYPE_ENERGY
	jr c, .pkmn_card
	cp TYPE_TRAINER
	jr nz, .energy_card
; trainer
	ld a, [wTempAISearchCriteria]
	or a ; cp AI_SEARCH_2_ONLY_TRAINER
	jr nz, .loop_hand_cards
	jr .set_carry
.energy_card
	ld a, [wTempAISearchCriteria]
	cp AI_SEARCH_2_ONLY_ENERGY
	jr nz, .loop_hand_cards
	jr .set_carry
.pkmn_card
	ldh a, [hTempCardIndex_ff98]
	call LoadCardDataToBuffer2_FromDeckIndex
	ld a, [wLoadedCard2Stage]
	or a ; cp BASIC
	jr nz, .evo_card
; basic card
	ld a, [wTempAISearchCriteria]
	cp AI_SEARCH_2_ONLY_BASIC_PKMN
	jr nz, .loop_hand_cards
	jr .set_carry
.evo_card
	ld a, [wTempAISearchCriteria]
	cp AI_SEARCH_2_ONLY_EVOLUTION_PKMN
	jr nz, .loop_hand_cards
.set_carry
	ldh a, [hTempCardIndex_ff98]
	scf
	ret

; stray no carry
	or a
	ret

; DamageChaosDeckAI?
; no deck has all of
; {Switch, The Boss's Way, Pokemon Trader, Computer Search}
AIDecideEnergyRetrieval_4b973:
	farcall CountBasicEnergyCardsInHand
	ret nc
; find discard card
	ld de, SWITCH
	farcall LookForCardIDInHandList
	ret c
	ld de, THE_BOSSS_WAY
	farcall LookForCardIDInHandList
	ret c
	ld de, POKEMON_TRADER
	farcall LookForCardIDInHandList
	ret c
	ld de, COMPUTER_SEARCH
	farcall LookForCardIDInHandList
	ret c
	call FindLeastUsefulPokemonInHand
	ret

AIDecide_PokemonTrader_DamageChaosDeck:
	bank1call IsPrehistoricPowerActive
	jr c, .target_basic_pkmn
	ld de, DARK_GENGAR
	call IsEvoCardIDInDeckAndNotInHand_AIDecideEvolution
	jr c, .find_trade_pkmn
	ld de, DARK_HAUNTER
	call IsEvoCardIDInDeckAndNotInHand_AIDecideEvolution
	jr c, .find_trade_pkmn
	ld de, EXEGGUTOR
	call IsEvoCardIDInDeckAndNotInHand_AIDecideEvolution
	jr c, .find_trade_pkmn
	ld de, DARK_CLEFABLE
	call IsEvoCardIDInDeckAndNotInHand_AIDecideEvolution
	jr c, .find_trade_pkmn
.target_basic_pkmn
	ld de, GASTLY_LV17
	farcall IsCardIDInDeckAndNotInHandOrPlayArea
	jr c, .find_trade_pkmn
	ld de, GASTLY_LV13
	farcall IsCardIDInDeckAndNotInHandOrPlayArea
	jr c, .find_trade_pkmn
	ld de, EXEGGCUTE
	farcall IsCardIDInDeckAndNotInHandOrPlayArea
	jr c, .find_trade_pkmn
	ld de, CLEFAIRY_LV15
	farcall IsCardIDInDeckAndNotInHandOrPlayArea
	jr c, .find_trade_pkmn
	ld de, JYNX_LV27
	farcall IsCardIDInDeckAndNotInHandOrPlayArea
	ret nc

.find_trade_pkmn
	ld [wTempAIMultiTargetCardDeckIndex1], a
	call FindLeastUsefulPokemonInHand
	ret

; input:
; - de = card ID (evo card)
IsEvoCardIDInDeckAndNotInHand_AIDecideEvolution:
; this part is the same as farcall IsCardIDInDeckAndNotInHand
	push de
	farcall LookForCardIDInHandList
	pop de
	ccf
	ret nc ; is in hand
	ld a, CARD_LOCATION_DECK
	farcall FindCardIDInLocation
	ret nc ; not in deck

; is in deck and not in hand
	push af
	call .DecideEvolution
	pop bc
	ret nc
	ld a, b
	ret

.DecideEvolution:
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
	farcall AIDecideEvolution_GivenLocation
	pop de
	ret c
.next_pokemon
	inc e
	ld a, e
	cp d
	jr nz, .loop_play_area
; no carry
	or a
	ret

AIDecide_TheBosssWay_DamageChaosDeck:
	bank1call IsPrehistoricPowerActive
	ccf
	ret nc
	ld de, DARK_GENGAR
	call IsEvoCardIDInDeckAndNotInHand_AIDecideEvolution
	ret c
	ld de, DARK_HAUNTER
	call IsEvoCardIDInDeckAndNotInHand_AIDecideEvolution
	ret c
	ld de, DARK_CLEFABLE
	call IsEvoCardIDInDeckAndNotInHand_AIDecideEvolution
	ret

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

; outputs in a the maximum damage from
; its attacks that is useable
GetHighestDamageFromDefendingPokemon:
	xor a ; FIRST_ATTACK_OR_PKMN_POWER
	call .CheckAttack
	push af
	ld a, SECOND_ATTACK
	call .CheckAttack
	pop bc
	cp b ; is damage higher than first attack?
	ret nc ; if yes, return first attack's damage
	ld a, b ; if no, then return second attack's damage
	ret

.CheckAttack:
	ld [wSelectedAttack], a
	ldh a, [hTempPlayAreaLocation_ff9d]
	push af
	xor a ; PLAY_AREA_ARENA
	ldh [hTempPlayAreaLocation_ff9d], a
	call SwapTurn
	farcall CheckIfSelectedAttackIsUnusable
	call SwapTurn
	pop bc
	ld a, b
	ldh [hTempPlayAreaLocation_ff9d], a
	jr c, .zero ; is unusable
	ld a, [wSelectedAttack]
	farcall EstimateDamage_FromDefendingPokemon
	ld a, [wDamage]
	ret
.zero
	xor a
	ret

AIDecide_ComputerSearch_SpiritedAwayDeck:
	ld a, DUELVARS_NUMBER_OF_CARDS_IN_HAND
	get_turn_duelist_var
	cp 8
	jr nc, .skip_oak
	ld de, PROFESSOR_OAK
	ld a, CARD_LOCATION_DECK
	farcall FindCardIDInLocation
	jr c, .found_target
.skip_oak
	ld de, SUPER_ENERGY_REMOVAL
	ld a, CARD_LOCATION_DECK
	farcall FindCardIDInLocation
	jr c, .found_target
	ld de, ENERGY_REMOVAL
	ld a, CARD_LOCATION_DECK
	farcall FindCardIDInLocation
	jr c, .found_target
	ld de, POKEMON_BREEDER
	ld a, CARD_LOCATION_DECK
	farcall FindCardIDInLocation
	jr c, .found_target
	ld de, BILL
	ld a, CARD_LOCATION_DECK
	farcall FindCardIDInLocation
	jr c, .found_target
	ld de, ENERGY_RETRIEVAL
	ld a, CARD_LOCATION_DECK
	farcall FindCardIDInLocation
	jr c, .found_target
	ld de, DARK_GENGAR
	ld a, CARD_LOCATION_DECK
	farcall FindCardIDInLocation
	jr c, .found_target
	ld de, DARK_HAUNTER
	ld a, CARD_LOCATION_DECK
	farcall FindCardIDInLocation
	jr c, .found_target
	ld de, GASTLY_LV17
	ld a, CARD_LOCATION_DECK
	farcall FindCardIDInLocation
	jr c, .found_target
	ld de, MR_MIME_LV28
	ld a, CARD_LOCATION_DECK
	farcall FindCardIDInLocation
	jr c, .found_target
	ld de, KANGASKHAN_LV40
	ld a, CARD_LOCATION_DECK
	farcall FindCardIDInLocation
	jr c, .found_target
	ld de, SLOWPOKE_LV16
	ld a, CARD_LOCATION_DECK
	farcall FindCardIDInLocation
	jr c, .found_target

.no_carry
	or a
	ret

.found_target
	ld [wTempAISingleTargetCardDeckIndex_2], a
	call CreateHandCardList
	cp 3
	jr c, .no_carry
; set discard cards
	ld a, [wDuelTempList]
	ld [wTempAIMultiTargetCardDeckIndex1], a
	ld a, [wDuelTempList + 1]
	ld [wTempAIMultiTargetCardDeckIndex2], a
	ld a, [wTempAISingleTargetCardDeckIndex_2]
	scf
	ret

AIDecide_ComputerSearch_RainDanceConfusionDeck:
	ld de, BLASTOISE_LV52
	farcall LookForCardIDInHandList
	jr nc, .target_blastoise
	ld de, SQUIRTLE_LV15
	ld b, PLAY_AREA_ARENA
	farcall FindCardIDInTurnDuelistsPlayArea
	jr c, .target_blastoise
	ld de, SQUIRTLE_LV16
	ld b, PLAY_AREA_ARENA
	farcall FindCardIDInTurnDuelistsPlayArea
	jr c, .target_blastoise
	ld de, POKEMON_BREEDER
	farcall IsCardIDInDeckAndNotInHand
	jr c, .find_discard_cards
.target_blastoise
	ld de, WARTORTLE_LV22
	ld b, PLAY_AREA_ARENA
	farcall FindCardIDInTurnDuelistsPlayArea
	jr nc, .target_energy_retrieval
	ld de, POKEMON_TRADER
	farcall LookForCardIDInHandList
	jr c, .target_energy_retrieval
	ld de, BLASTOISE_LV52
	farcall IsCardIDInDeckAndNotInHand
	jr c, .find_discard_cards
.target_energy_retrieval
	ld de, BLASTOISE_LV52
	ld b, PLAY_AREA_ARENA
	farcall FindCardIDInTurnDuelistsPlayArea
	jr nc, .target_professor_oak_2
	ld a, CARD_LOCATION_DISCARD_PILE
	farcall CreateBasicEnergyCardListInLocation
	jr c, .target_professor_oak_1
	ld de, ENERGY_RETRIEVAL
	farcall IsCardIDInDeckAndNotInHand
	jr c, .find_discard_cards
.target_professor_oak_1
	ld a, DUELVARS_NUMBER_OF_CARDS_NOT_IN_DECK
	get_turn_duelist_var
	cp DECK_SIZE - 17
	jr nc, .target_professor_oak_2
	ld a, DUELVARS_NUMBER_OF_CARDS_IN_HAND
	get_turn_duelist_var
	cp 6
	jr nc, .target_professor_oak_2
	ld de, PROFESSOR_OAK
	farcall IsCardIDInDeckAndNotInHand
	jr c, .find_discard_cards
.target_professor_oak_2
	ld a, DUELVARS_NUMBER_OF_CARDS_NOT_IN_DECK
	get_turn_duelist_var
	cp DECK_SIZE - 17
	jr nc, .no_carry
	ld a, DUELVARS_NUMBER_OF_CARDS_IN_HAND
	get_turn_duelist_var
	cp 5
	jr nc, .no_carry
	ld de, PROFESSOR_OAK
	farcall IsCardIDInDeckAndNotInHand
	jr c, .find_discard_cards

.no_carry
	or a
	ret

.find_discard_cards
	ld [wTempAISingleTargetCardDeckIndex_2], a
	farcall AIDecide_ComputerSearch_RainDanceConfusionDeck_PickDiscardCards
	ld a, [wTempAISingleTargetCardDeckIndex_2]
	ret

; Big Thunder deck AI will try to find a Pokémon in Play Area
; with at least 20 damage to use Potion that isn't Chansey,
; unless player KO'ing Chansey would result in losing the duel
AIDecide_Potion_BigThunderDeck:
	; is Arena card Chansey?
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call GetCardIDFromDeckIndex
	cp16 CHANSEY_LV55
	jr nz, .find_non_chansey_pkmn

	; is Chansey, is it only card in Play Area?
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	cp 1
	jr z, .heal_chansey_if_has_damage

	; has Bench Pokémon, is player on last prize card?
	call SwapTurn
	call CountPrizes
	call SwapTurn
	cp 1
	jr nz, .find_non_chansey_pkmn

	; player is on last prize card, will Chansey be KO'd?
	xor a ; PLAY_AREA_ARENA
	ldh [hTempPlayAreaLocation_ff9d], a
	farcall CheckIfDefendingPokemonCanKnockOut
	jr nc, .find_non_chansey_pkmn
	; Chansey will be KO'd
.heal_chansey_if_has_damage
	; does Chansey have damage to heal?
	xor a ; PLAY_AREA_ARENA
	call CheckIfPokemonHasDamage
	cp 20
	jr c, .find_non_chansey_pkmn
	; heal it
	xor a ; Arena card
	scf
	ret

.find_non_chansey_pkmn
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	ld d, a
	ld e, PLAY_AREA_ARENA
.loop_play_area
	ld a, e
	cp d
	ret nc ; no healing
	; does this Pokémon have at least 20 damage?
	push de
	call CheckIfPokemonHasDamage
	pop de
	cp 20
	jr c, .next_play_area
	; skip if it's Chansey
	ld hl, wLoadedCard1ID
	cphl CHANSEY_LV55
	jr z, .next_play_area
	; at least 20 damage and not Chansey, heal it
	ld a, e
	scf
	ret
.next_play_area
	inc e
	jr .loop_play_area

; Big Thunder deck AI will check if Arena card is not Chansey,
; it has at least 40 damage, and has energy attached
; if true, then use Super Potion on it
AIDecide_SuperPotion_BigThunderDeck:
	; is Arena card Chansey?
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call GetCardIDFromDeckIndex
	cp16 CHANSEY_LV55
	ret z ; yes, skip

	; does it have 40 or more damage?
	xor a ; PLAY_AREA_ARENA
	call CheckIfPokemonHasDamage
	cp 40
	ccf
	ret nc ; less than 40, skip

	; does it have energies?
	ld e, PLAY_AREA_ARENA
	call GetPlayAreaCardAttachedEnergies
	ld a, [wTotalAttachedEnergies]
	or a
	ret z ; no, skip

	; yes, use it on Arena card
	xor a
	scf
	ret

; counts, in turn-holder's Play Area location given in e,
; the number of energy cards attached to that Play Area Pokémon
; that are not Recycle Energy, and outputs it in a
CountEnergyRemovalEnergyCardTargets:
	push hl
	push de
	push bc
	ld a, CARD_LOCATION_PLAY_AREA
	or e
	ld e, a
	ldh a, [hWhoseTurn]
	ld h, a
	ld l, DUELVARS_CARD_LOCATIONS
	ld d, 0
.loop_deck
	ld a, [hl]
	cp e
	jr nz, .next_card
	; this card is in the selected Play Area location
	push hl
	push de
	; is it a Recycle Energy?
	ld a, l
	call GetCardIDFromDeckIndex
	cp16 RECYCLE_ENERGY
	jr z, .skip ; yes
	; is it an energy card?
	call GetCardType
	bit TYPE_ENERGY_F, a
	jr z, .skip ; no
	; found potential target
	pop de
	inc d
	pop hl
	jr .next_card
.skip
	pop de
	pop hl
.next_card
	inc l
	ld a, l
	cp DECK_SIZE
	jr nz, .loop_deck
	ld a, d ; target count
	pop bc
	pop de
	pop hl
	ret

; get a random card from deck that matches AI_SEARCH_2_ONLY_* in a,
; return carry and the deck index
; no carry and a = $ff if not found
; cf. PickRandomCardOfSpecificTypeFromHand
PickRandomCardOfSpecificTypeFromDeck:
	ld [wTempAISearchCriteria], a
	call CreateDeckCardList
	ld hl, wDuelTempList
	call CountCardsInDuelTempList
	call ShuffleCards
	ld hl, wDuelTempList
.loop_deck_cards
	ld a, [hli]
	cp $ff
	ret z ; not found
	ldh [hTempCardIndex_ff98], a
	call GetCardIDFromDeckIndex
	call GetCardType
	cp TYPE_ENERGY
	jr c, .pkmn_card
	cp TYPE_TRAINER
	jr nz, .energy_card
; trainer
	ld a, [wTempAISearchCriteria]
	or a ; cp AI_SEARCH_2_ONLY_TRAINER
	jr nz, .loop_deck_cards
	jr .set_carry
.energy_card
	ld a, [wTempAISearchCriteria]
	cp AI_SEARCH_2_ONLY_ENERGY
	jr nz, .loop_deck_cards
	jr .set_carry
.pkmn_card
	ldh a, [hTempCardIndex_ff98]
	call LoadCardDataToBuffer2_FromDeckIndex
	ld a, [wLoadedCard2Stage]
	or a ; cp BASIC
	jr nz, .evo_card
	ld a, [wTempAISearchCriteria]
	cp AI_SEARCH_2_ONLY_BASIC_PKMN
	jr nz, .loop_deck_cards
	jr .set_carry
.evo_card
	ld a, [wTempAISearchCriteria]
	cp AI_SEARCH_2_ONLY_EVOLUTION_PKMN
	jr nz, .loop_deck_cards
.set_carry
	ldh a, [hTempCardIndex_ff98]
	scf
	ret

; stray no carry
	or a
	ret

; return carry and the deck index if
; turn holder's pkmn in play can use Evolutionary Light
CanUseEvolutionaryLight:
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
; run EvolutionaryLight_CheckUseAndDeck
	ld a, EFFECTCMDTYPE_INITIAL_EFFECT_2
	call TryExecuteEffectCommandFunction
	pop bc
	jr c, .next_pokemon
; EvolutionaryLight_CheckUseAndDeck passes
	ld a, c
	bank1call CheckIsIncapableOfUsingPkmnPower
	jr c, .next_pokemon
; can use
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
; can't use
	or a
	ret

; no deck has all of
; {Energy Retrieval, The Boss's Way, Pokeball, Pokemon Trader, Professor Oak}
AIDecideEnergyRetrieval_4bdb6:
	farcall CountBasicEnergyCardsInHand
	ret nc

; find discard card
	call CreateHandCardList
	ld hl, wDuelTempList
	ld de, wTempCardCollection
.loop_copy
	ld a, [hli]
	ld [de], a
	inc de
	cp $ff
	jr nz, .loop_copy

	ld hl, wTempCardCollection
.loop_hand_cards
	ld a, [hl]
	cp $ff
	jp z, .no_carry
	push hl
	call GetCardIDFromDeckIndex
; try dupe energy retrieval
	cp16 ENERGY_RETRIEVAL
	jr nz, .try_non_oak_trainers
	ld de, ENERGY_RETRIEVAL
	call LookForCardIDInHandList_IgnoreTrainerCardToPlay
	jr c, .carry
	jr .next_card
.try_non_oak_trainers
	cp16 SWITCH
	jr z, .carry
	cp16 THE_BOSSS_WAY
	jr z, .carry
	cp16 POKEBALL
	jr z, .carry
	cp16 POKEMON_TRADER
	jr nz, .try_pkmn_cards
	ld a, AI_SEARCH_2_ONLY_BASIC_PKMN
	call PickRandomCardOfSpecificTypeFromHand
	jr c, .next_card
	ld a, AI_SEARCH_2_ONLY_EVOLUTION_PKMN
	call PickRandomCardOfSpecificTypeFromHand
	jr nc, .carry
	jr .next_card
.try_pkmn_cards
	push de
	ld b, PLAY_AREA_ARENA
	farcall FindCardIDInTurnDuelistsPlayArea
	pop de
	jr c, .carry
; try dupe oak
	cp16 PROFESSOR_OAK
	jr nz, .next_card
	ld de, PROFESSOR_OAK
	farcall CheckIfHandHasRepeatedCard
	jp c, .carry ; can be jr
	ld a, DUELVARS_NUMBER_OF_CARDS_NOT_IN_DECK
	get_turn_duelist_var
	cp DECK_SIZE - 17
	jp nc, .carry ; can be jr
.next_card
	pop hl
	inc hl
	jp .loop_hand_cards
.carry
	pop hl
	ld a, [hl]
	scf
	ret

.no_carry
	or a
	ret

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

; search bench for specific pkmn with 10 HP remaining
; with not more than specific amount of energy attached
AIDecide_ScoopUp_PsychicEliteDeck:
	ld a, 1
	ld de, CHANSEY_LV55
	call .Find10HPTargetInBench
	ret c
	ld a, 1
	ld de, MR_MIME_LV20
	call .Find10HPTargetInBench
	ret c
	ld a, 1
	ld de, MR_MIME_LV28
	call .Find10HPTargetInBench
	ret c
	ld a, 5
	ld de, CHANSEY_LV55
	call .Find10HPTargetInBench
	ret c
	ld a, 5
	ld de, MR_MIME_LV20
	call .Find10HPTargetInBench
	ret c
	ld a, 5
	ld de, MR_MIME_LV28
	call .Find10HPTargetInBench
	ret

.Find10HPTargetInBench:
	ld [wTempAISearchCriteria], a
	ld a, DUELVARS_BENCH
	get_turn_duelist_var
	ld c, PLAY_AREA_BENCH_1
.loop_bench
	ld a, [hli]
	cp $ff
	ret z
	push hl
	push de
	push bc
	call GetCardIDFromDeckIndex
	pop bc
	ld a, e
	ld b, d
	pop de
	cp e
	jr nz, .next
	ld a, b
	cp d
	jr nz, .next
; found
	ld a, c
	add DUELVARS_ARENA_CARD_HP
	get_turn_duelist_var
	cp 10
	jr nz, .next
; 10 HP
	ld e, c
	call CountEnergyRemovalEnergyCardTargets
	ld hl, wTempAISearchCriteria
	cp [hl]
	jr z, .set_carry
	jr c, .set_carry
.next
	pop hl
	inc c
	jr .loop_bench
.set_carry
	pop hl
	ld a, c
	scf
	ret

CreateEnergyCardListFromHand_OnlyBasicOrRecycleEnergy:
	bank1call CreateEnergyCardListFromHand
	ret c ; no energy cards
	push hl
	push de
	push bc
	ld hl, wDuelTempList
.loop_cards
	ld a, [hli]
	cp $ff
	jr z, .check_empty
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
.check_empty
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

CreateEnergyCardListFromHand_IgnoreRainbowEnergy:
	bank1call CreateEnergyCardListFromHand
	ret c ; no energy cards
	push hl
	push de
	push de
	ld hl, wDuelTempList
.loop_cards
	ld a, [hli]
	cp $ff
	jr z, .check_empty
	push hl
	call GetCardIDFromDeckIndex
	pop hl
	cp16 RAINBOW_ENERGY
	jr nz, .loop_cards
; remove rainbow energy
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
.check_empty
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

; for Pokémon at [hTempPlayAreaLocation_ff9d] and its [wSelectedAttack],
; return carry if
;      no surplus energy
;   OR energy boost attack but only 1 or 2 extra energy attached
; no carry otherwise
CanRemovingEnergyReduceDamage:
	call CheckIfNoSurplusEnergyForAttack
	ret c

	push af
	ld a, ATTACK_FLAG2_ADDRESS | ATTACHED_ENERGY_BOOST_F
	call CheckLoadedAttackFlag
	jr c, .attached_energy_boost
	pop af
	ret

.attached_energy_boost
	pop af
	cp MAX_ENERGY_BOOST_IS_NOT_LIMITED
	ret
