MACRO ai_trainer_card_logic
	db \1 ; AI_TRAINER_CARD_PHASE_* constant
	dw \2 ; ID of trainer card
	dw \3 ; function for AI decision to play card
	dw \4 ; function for AI playing the card
ENDM

AITrainerCardLogic:
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_07, POTION,                 AIDecide_Potion_Phase07, AIPlay_Potion
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_10, POTION,                 $42d0, AIPlay_Potion
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_11, POTION,                 $439b, AIPlay_Potion
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_08, SUPER_POTION,           $43d0, $43aa
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_11, SUPER_POTION,           $43ff, $43aa
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_13, SUPER_POTION,           $44d4, $43aa
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_13, DEFENDER,               $44f2, $44e3
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_14, DEFENDER,               $45ef, $44e3
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_13, PLUSPOWER,              $4692, $4678
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_14, PLUSPOWER,              $4752, $4678
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_09, SWITCH,                 $485a, $483d
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_16, SWITCH,                 $489c, $483d
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_07, GUST_OF_WIND,           $49fc, $49e3
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_10, GUST_OF_WIND,           $49fc, $49e3
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_04, BILL,                   $4c3e, $4c32
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_05, ENERGY_REMOVAL,         $4c5a, $4c44
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_05, SUPER_ENERGY_REMOVAL,   $4f33, $4f0a
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_07, POKEMON_BREEDER,        $50b6, $507b
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_15, PROFESSOR_OAK,          $53d0, $53bc
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_10, ENERGY_RETRIEVAL,       $566e, $5643
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_11, SUPER_ENERGY_RETRIEVAL, $5adf, $5a9d
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_06, POKEMON_CENTER,         $5c65, $5c59
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_07, IMPOSTER_PROFESSOR_OAK, $5cee, $5ce2
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_12, ENERGY_SEARCH,          $5d3e, $5d2d
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_03, POKEDEX,                $5ebd, $5e94
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_07, FULL_HEAL,              $5f6f, $5f63
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_10, MR_FUJI,                $604f, $603e
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_10, SCOOP_UP,               $60ed, $60d7
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_02, MAINTENENCE,            $6269, $624b
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_03, RECYCLE,                $62b9, $629a
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_13, LASS,                   $6340, $632c
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_04, ITEMFINDER,             $6396, $6373
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_01, IMAKUNI_CARD,           $6659, $664d
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_01, GAMBLER,                $66e7, $6694
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_05, REVIVE,                 $672c, $671b
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_06, POKEMON_FLUTE,          $67c0, $67af
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_05, CLEFAIRY_DOLL,          $6864, $6858
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_05, MYSTERIOUS_FOSSIL,      $6864, $6858
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_02, POKEBALL,               $68d8, $68b7
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_02, COMPUTER_SEARCH,        $6d20, $6cfd
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_02, POKEMON_TRADER,         $6e43, $6e28
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_02, THE_BOSSS_WAY,          $74a7, $7492
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_04, NIGHTLY_GARBAGE_RUN,    $761d, $75fe
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_04, FOSSIL_EXCAVATION,      $7a13, $79f5
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_12, SLEEP,                  $7a4f, $7a43
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_02, POKEMON_RECALL,         $7aa5, $7a90
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_02, MASTER_BALL,            $7b1f, $7b0a
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_04, BILLS_TELEPORTER,       $7e05, $7df9
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_02, MOON_STONE,             $7e1c, $7e0b
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_08, THE_ROCKETS_TRAP,       $7e85, $7e79
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_17, GOOP_GAS_ATTACK,        $7eaa, $7e9e
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_07, IMPOSTER_OAKS_REVENGE,  $7ed4, $7ec3
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_01, DIGGER,                 $7f3c, $7f30
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_17, COMPUTER_ERROR,         $7f61, $7f3e
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_10, SUPER_SCOOP_UP,         $7fbc, $7f96
	db $ff

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
	ldh [hTempCardIndex_ff9f], a

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
	ld [wAITrainerCardParameter], a

; show Play Trainer Card screen
	push de
	push hl
	ld a, [wAITrainerCardToPlay]
	ldh [hTempCardIndex_ff9f], a
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
.loop_copy
	ld a, [hli]
	ld [de], a
	cp $ff
	ret z
	inc de
	jr .loop_copy
; 0x20270

SECTION "Bank 8@4290", ROMX[$4290], BANK[$8]

; makes AI use Potion card.
AIPlay_Potion:
	ld a, [wAITrainerCardToPlay]
	ldh [hTempCardIndex_ff9f], a
	ld a, [wAITrainerCardParameter]
	ldh [hTemp_ffa0], a
	ld e, a
	call GetCardDamageAndMaxHP
	cp 20
	jr c, .play_card
	ld a, 20
.play_card
	ldh [hTempPlayAreaLocation_ffa1], a
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
	ld a, [wOpponentDeckID]
	cp QUICK_ATTACK_DECK_ID
	jr z, .no_carry
	cp BIG_THUNDER_DECK_ID
	jr z, .no_carry
	farcall AICheckIfAttackIsHighRecoil
	jr c, .no_carry
	ld a, 20
	farcall Func_39c8d
	ret nc

; return carry
	xor a
	scf
	ret
.no_carry
	or a
	ret
; 0x202d0

SECTION "Bank 8@49fc", ROMX[$49fc], BANK[$8]

Func_209fc:
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	call GetNonTurnDuelistVariable
	dec a
	ret z ; no Bench

	ld a, [wPreviousAIFlags]
	and AI_FLAG_USED_GUST_OF_WIND
	ret nz ; used Gust of Wind

	; a = PLAY_AREA_ARENA
	farcall CheckIfPokemonCanUseNonResidualAttack
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
	call CheckIfArenaCardCanPotentiallyDamageDefendingCard
	jr c, .asm_20a79 ; Arena card cannot damage
	bank1call GetArenaCardColor
	call TranslateColorToWR
	ld b, a
	call SwapTurn
	bank1call GetArenaCardWeakness
	call SwapTurn
	and b
	jr nz, .no_carry
	call .Func_20ae8
	ret nc
	scf
	ret
.no_carry
	or a
	ret

.asm_20a79
	call .Func_20ae8
	ret c
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	call GetNonTurnDuelistVariable
	ld d, a
	ld e, PLAY_AREA_BENCH_1 - 1
.asm_20a85
	inc e
	dec d
	jr z, .asm_20aa0
	call SwapTurn
	call GetPlayAreaCardAttachedEnergies
	call SwapTurn
	ld a, [wTotalAttachedEnergies]
	or a
	jr nz, .asm_20a85
	call Func_20be6
	jr nc, .asm_20a85
	ld a, e
	scf
	ret
.asm_20aa0
	ld a, $ff
	ld [wd082], a
	xor a
	ld [wd084], a
	ld e, a
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	call GetNonTurnDuelistVariable
	ld d, a
.asm_20ab0
	inc e
	dec d
	jr z, .asm_20ad2
	ld a, e
	add DUELVARS_ARENA_CARD_HP
	call GetNonTurnDuelistVariable
	ld b, a
	ld a, [wd082]
	inc b
	cp b
	jr c, .asm_20ab0
	call Func_20be6
	jr nc, .asm_20ab0
	dec b
	ld a, b
	ld [wd082], a
	ld a, e
	ld [wd084], a
	jr .asm_20ab0
.asm_20ad2
	ld a, [wd084]
	or a
	jr z, .no_carry
	scf
	ret

.asm_20ada
	push bc
	push hl
	xor a
	farcall CheckIfCanDamageDefendingPokemon
	pop hl
	pop bc
	jr nc, .loop_bench
	ld a, c
	scf
	ret

.Func_20ae8:
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
	jr nz, .asm_20ada
	jr .loop_bench

.PoisonMistDeck:
	farcall Func_3a441
	ret

.UltraRemovalDeck:
	farcall Func_3a803
	ret

.PsychicBattleDeck:
	farcall Func_4c56b
	ret nc
	cp $ff
	jp z, .asm_20a79
	scf
	ret

.StopLifeDeck:
	farcall Func_49603
	ret

.TsunamiStarterDeck:
	farcall Func_49b69
	ret

.SmashToMincemeatDeck:
	farcall Func_49c04
	ret

; returns nc if Arena card can potentially damage
; the current Defending card
CheckIfArenaCardCanPotentiallyDamageDefendingCard:
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

FindBenchCardThatCanBeKnockedOut:
	ld a, DUELVARS_BENCH
	call GetNonTurnDuelistVariable
	ld e, PLAY_AREA_BENCH_1
.loop
	ld a, [hli]
	cp $ff
	ret z
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
	call .CheckIfAnyAttackCanKO
	jr nc, .next_bench_card
	farcall CheckIfSelectedAttackIsUnusable
	jr nc, .can_potentially_ko
	farcall LookForEnergyNeededForAttackInHand
	jr c, .can_potentially_ko
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
.CheckIfAnyAttackCanKO:
	xor a ; FIRST_ATTACK_OR_PKMN_POWER
	call .Func_20bd2
	ret c
	ld a, SECOND_ATTACK
.Func_20bd2:
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

Func_20be6:
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
; 0x20c32
