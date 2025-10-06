; AI card retreat score bonus
; when the AI retreat routine runs through the Bench to choose
; a Pokemon to switch to, it looks up in this list and if
; a card ID matches, applies a retreat score bonus to this card.
; positive (negative) means more (less) likely to switch to this card.
MACRO ai_retreat
	dw \1       ; card ID
	db $80 + \2 ; retreat score (ranges between -128 and 127)
ENDM

; AI card energy attach score bonus
; when the AI energy attachment routine runs through the Play Area to choose
; a Pokemon to attach an energy card, it looks up in this list and if
; a card ID matches, skips this card if the maximum number of energy
; cards attached has been reached. If it hasn't been reached, additionally
; applies a positive (or negative) AI score to attach energy to this card.
MACRO ai_energy
	dw \1       ; card ID
	db \2       ; maximum number of attached cards
	db $80 + \3 ; energy score (ranges between -128 and 127)
ENDM

DeckAIPointerTable::
	dw AIActionTable_ScriptedSamPracticeDeck    ; SAMS_PRACTICE_DECK_ID
	dw AIActionTable_GeneralDecks               ; PLAYER_PRACTICE_DECK_ID
	dw AIActionTable_GeneralDecks               ; STARTER_DECK_ID
	dw AIActionTable_GeneralDecks               ; SWEAT_ANTI_GR1_DECK_ID
	dw AIActionTable_GeneralDecks               ; GIVE_IN_ANTI_GR2_DECK_ID
	dw AIActionTable_GeneralDecks               ; VENGEFUL_ANTI_GR3_DECK_ID
	dw AIActionTable_GeneralDecks               ; UNFORGIVING_ANTI_GR4_DECK_ID
	dw AIActionTable_GeneralDecks               ; UNUSED_SAMS_PRACTICE_DECK_ID
	dw AIActionTable_GeneralDecks               ; AARON_PRACTICE_DECK1_ID
	dw AIActionTable_AaronStep1Deck             ; AARONS_STEP1_DECK_ID
	dw AIActionTable_GeneralDecks               ; AARON_PRACTICE_DECK2_ID
	dw AIActionTable_AaronStep2Deck             ; AARONS_STEP2_DECK_ID
	dw AIActionTable_GeneralDecks               ; AARON_PRACTICE_DECK3_ID
	dw AIActionTable_AaronStep3Deck             ; AARONS_STEP3_DECK_ID
	dw AIActionTable_GeneralDecks               ; BRICK_WALK_DECK_ID
	dw AIActionTable_GeneralDecks               ; BENCH_TRAP_DECK_ID
	dw AIActionTable_SkySparkDeck               ; SKY_SPARK_DECK_ID
	dw AIActionTable_ElectricSelfdestructDeck   ; ELECTRIC_SELFDESTRUCT_DECK_ID
	dw AIActionTable_GeneralDecks               ; OVERFLOW_DECK_ID
	dw AIActionTable_GeneralDecks               ; TRIPLE_ZAPDOS_DECK_ID
	dw AIActionTable_GeneralDecks               ; I_LOVE_PIKACHU_DECK_ID
	dw AIActionTable_GeneralDecks               ; TEN_THOUSAND_VOLTS_DECK_ID
	dw AIActionTable_HandOverGRDeck             ; HAND_OVER_GR_DECK_ID
	dw AIActionTable_PsychicEliteDeck           ; PSYCHIC_ELITE_DECK_ID
	dw AIActionTable_GeneralDecks               ; PSYCHOKINESIS_DECK_ID
	dw AIActionTable_GeneralDecks               ; PHANTOM_DECK_ID
	dw AIActionTable_PuppetMasterDeck           ; PUPPET_MASTER_DECK_ID
	dw AIActionTable_Even3YearsOnARockDeck      ; EVEN3_YEARS_ON_A_ROCK_DECK_ID
	dw AIActionTable_GeneralDecks               ; ROLLING_STONE_DECK_ID
	dw AIActionTable_GeneralDecks               ; GREAT_EARTHQUAKE_DECK_ID
	dw AIActionTable_GeneralDecks               ; AWESOME_FOSSIL_DECK_ID
	dw AIActionTable_RagingBillowOfFistsDeck    ; RAGING_BILLOW_OF_FISTS_DECK_ID
	dw AIActionTable_GeneralDecks               ; YOU_CAN_DO_IT_MACHOP_DECK_ID
	dw AIActionTable_GeneralDecks               ; NEW_MACHOKE_DECK_ID
	dw AIActionTable_SkilledWarriorDeck         ; SKILLED_WARRIOR_DECK_ID
	dw AIActionTable_GeneralDecks               ; I_LOVE_TO_FIGHT_DECK_ID
	dw AIActionTable_MaxEnergyDeck              ; MAX_ENERGY_DECK_ID
	dw AIActionTable_GeneralDecks               ; REMAINING_GREEN_DECK_ID
	dw AIActionTable_GeneralDecks               ; POISON_CURSE_DECK_ID
	dw AIActionTable_GeneralDecks               ; GLITTERING_SCALES_DECK_ID
	dw AIActionTable_GeneralDecks               ; STEADY_INCREASE_DECK_ID
	dw AIActionTable_DarkScienceDeck            ; DARK_SCIENCE_DECK_ID
	dw AIActionTable_GeneralDecks               ; NATURAL_SCIENCE_DECK_ID
	dw AIActionTable_GeneralDecks               ; POISONOUS_SWAMP_DECK_ID
	dw AIActionTable_GeneralDecks               ; GATHERING_NIDORAN_DECK_ID
	dw AIActionTable_RainDanceConfusionDeck     ; RAIN_DANCE_CONFUSION_DECK_ID
	dw AIActionTable_GeneralDecks               ; CONSERVING_WATER_DECK_ID
	dw AIActionTable_GeneralDecks               ; ENERGY_REMOVAL_DECK_ID
	dw AIActionTable_SplashingAboutDeck         ; SPLASHING_ABOUT_DECK_ID
	dw AIActionTable_BeachDeck                  ; BEACH_DECK_ID
	dw AIActionTable_GoArcanineDeck             ; GO_ARCANINE_DECK_ID
	dw AIActionTable_GeneralDecks               ; FLAME_FESTIVAL_DECK_ID
	dw AIActionTable_GeneralDecks               ; IMMORTAL_FLAME_DECK_ID
	dw AIActionTable_GeneralDecks               ; ELECTRIC_CURRENT_SHOCK_DECK_ID
	dw AIActionTable_GreatRocket4Deck           ; GREAT_ROCKET4_DECK_ID
	dw AIActionTable_GreatRocket1Deck           ; GREAT_ROCKET1_DECK_ID
	dw AIActionTable_GreatRocket2Deck           ; GREAT_ROCKET2_DECK_ID
	dw AIActionTable_GreatRocket3Deck           ; GREAT_ROCKET3_DECK_ID
	dw AIActionTable_GrandFireDeck              ; GRAND_FIRE_DECK_ID
	dw AIActionTable_LegendaryFossilDeck        ; LEGENDARY_FOSSIL_DECK_ID
	dw AIActionTable_WaterLegendDeck            ; WATER_LEGEND_DECK_ID
	dw AIActionTable_GreatDragonDeck            ; GREAT_DRAGON_DECK_ID
	dw AIActionTable_GeneralDecks               ; BUG_COLLECTING_DECK_ID
	dw AIActionTable_GeneralDecks               ; DEMONIC_FOREST_DECK_ID
	dw AIActionTable_GeneralDecks               ; STICKY_POISON_GAS_DECK_ID
	dw AIActionTable_MadPetalsDeck              ; MAD_PETALS_DECK_ID
	dw AIActionTable_DangerousBenchDeck         ; DANGEROUS_BENCH_DECK_ID
	dw AIActionTable_GeneralDecks               ; CHAIN_LIGHTNING_BY_PIKACHU_DECK_ID
	dw AIActionTable_GeneralDecks               ; THIS_IS_THE_POWER_OF_ELECTRICITY_DECK_ID
	dw AIActionTable_QuickAttackDeck            ; QUICK_ATTACK_DECK_ID
	dw AIActionTable_CompleteCombustionDeck     ; COMPLETE_COMBUSTION_DECK_ID
	dw AIActionTable_GeneralDecks               ; FIREBALL_DECK_ID
	dw AIActionTable_GeneralDecks               ; EEVEE_SHOWDOWN_DECK_ID
	dw AIActionTable_GazeUponThePowerOfFireDeck ; GAZE_UPON_THE_POWER_OF_FIRE_DECK_ID
	dw AIActionTable_GeneralDecks               ; WHIRLPOOL_SHOWER_DECK_ID
	dw AIActionTable_GeneralDecks               ; PARALYZED_PARALYZED_DECK_ID
	dw AIActionTable_GeneralDecks               ; BENCH_CALL_DECK_ID
	dw AIActionTable_WaterStreamDeck            ; WATER_STREAM_DECK_ID
	dw AIActionTable_GeneralDecks               ; ROCK_BLAST_DECK_ID
	dw AIActionTable_GeneralDecks               ; FULL_STRENGTH_DECK_ID
	dw AIActionTable_RunningWildDeck            ; RUNNING_WILD_DECK_ID
	dw AIActionTable_GeneralDecks               ; DIRECT_HIT_DECK_ID
	dw AIActionTable_GeneralDecks               ; SUPERDESTRUCTIVE_POWER_DECK_ID
	dw AIActionTable_GeneralDecks               ; BAD_DREAM_DECK_ID
	dw AIActionTable_GeneralDecks               ; POKEMON_POWER_DECK_ID
	dw AIActionTable_SpiritedAwayDeck           ; SPIRITED_AWAY_DECK_ID
	dw AIActionTable_SnorlaxGuardDeck           ; SNORLAX_GUARD_DECK_ID
	dw AIActionTable_EyeOfTheStormDeck          ; EYE_OF_THE_STORM_DECK_ID
	dw AIActionTable_SuddenGrowthDeck           ; SUDDEN_GROWTH_DECK_ID
	dw AIActionTable_VeryRareCardDeck           ; VERY_RARE_CARD_DECK_ID
	dw AIActionTable_BadGuysDeck                ; BAD_GUYS_DECK_ID
	dw AIActionTable_PoisonMistDeck             ; POISON_MIST_DECK_ID
	dw AIActionTable_UltraRemovalDeck           ; ULTRA_REMOVAL_DECK_ID
	dw AIActionTable_PsychicBattleDeck          ; PSYCHIC_BATTLE_DECK_ID
	dw AIActionTable_StopLifeDeck               ; STOP_LIFE_DECK_ID
	dw AIActionTable_ScorcherDeck               ; SCORCHER_DECK_ID
	dw AIActionTable_TsunamiStarterDeck         ; TSUNAMI_STARTER_DECK_ID
	dw AIActionTable_SmashToMincemeatDeck       ; SMASH_TO_MINCEMEAT_DECK_ID
	dw AIActionTable_GeneralDecks               ; TEST_YOUR_LUCK_DECK_ID
	dw AIActionTable_GeneralDecks               ; PROTOHISTORIC_DECK_ID
	dw AIActionTable_TextureTuner7Deck          ; TEXTURE_TUNER7_DECK_ID
	dw AIActionTable_ColorlessEnergyDeck        ; COLORLESS_ENERGY_DECK_ID
	dw AIActionTable_PowerfulPokemonDeck        ; POWERFUL_POKEMON_DECK_ID
	dw AIActionTable_GeneralDecks               ; WEIRD_DECK_ID
	dw AIActionTable_GeneralDecks               ; STRANGE_DECK_ID
	dw AIActionTable_GeneralDecks               ; RONALDS_UNCOOL_DECK_ID
	dw AIActionTable_GeneralDecks               ; RONALDS_GRX_DECK_ID
	dw AIActionTable_GeneralDecks               ; RONALDS_POWER_DECK_ID
	dw AIActionTable_RonaldsPsychicDeck         ; RONALDS_PSYCHIC_DECK_ID
	dw AIActionTable_RonaldsUltraDeck           ; RONALDS_ULTRA_DECK_ID
	dw AIActionTable_EverybodysFriendDeck       ; EVERYBODYS_FRIEND_DECK_ID
	dw AIActionTable_ImmortalPokemonDeck        ; IMMORTAL_POKEMON_DECK_ID
	dw AIActionTable_TorrentialFloodDeck        ; TORRENTIAL_FLOOD_DECK_ID
	dw AIActionTable_TrainerImprisonDeck        ; TRAINER_IMPRISON_DECK_ID
	dw AIActionTable_BlazingFlameDeck           ; BLAZING_FLAME_DECK_ID
	dw AIActionTable_DamageChaosDeck            ; DAMAGE_CHAOS_DECK_ID
	dw AIActionTable_BigThunderDeck             ; BIG_THUNDER_DECK_ID
	dw AIActionTable_PowerOfDarknessDeck        ; POWER_OF_DARKNESS_DECK_ID
	dw AIActionTable_PoisonStormDeck            ; POISON_STORM_DECK_ID
	dw AIActionTable_GeneralDecks
	dw AIActionTable_GeneralDecks
	dw AIActionTable_140f4

AIActionTable_140f4:
	dw .do_turn
	dw .do_turn
	dw .start_duel
	dw .forced_switch
	dw .ko_switch
	dw .take_prize
	dw .update_portrait

.do_turn:
	call AIDecidePlayPokemonCard
	call AIDecideWhetherToRetreat_ConsiderStatus
	jr nc, .asm_1411b
	call AIDecideBenchPokemonToSwitchTo
	call Func_167e5
	call AIDecideWhetherToRetreat_ConsiderStatus
	jr nc, .asm_1411b
	call AIDecideBenchPokemonToSwitchTo
	call Func_167e5
.asm_1411b
	call AIProcessAndTryToPlayEnergy
	call AIProcessAndTryToUseAttack
	ret c ; used attack
	ld a, OPPACTION_FINISH_NO_ATTACK
	farcall AIMakeDecision
	ret

.start_duel:
	call AIPlayInitialBasicCards
	ret

.forced_switch:
	call AIDecideBenchPokemonToSwitchTo
	ret

.ko_switch:
	call AIDecideBenchPokemonToSwitchTo
	ret

.take_prize:
	call AIPickPrizeCards
	ret

.update_portrait:
	xor a
	ld [wcd78], a
	ret

; input:
; - [hl] = pointer table of AI card lists
StoreAICardListPointers:
	ld e, [hl]
	inc hl
	ld d, [hl]
	inc hl
	push hl
	ld hl, wAICardListAvoidPrize
	ld [hl], e
	inc hl
	ld [hl], d
	pop hl
	ld e, [hl]
	inc hl
	ld d, [hl]
	inc hl
	push hl
	ld hl, wAICardListArenaPriority
	ld [hl], e
	inc hl
	ld [hl], d
	pop hl
	ld e, [hl]
	inc hl
	ld d, [hl]
	inc hl
	push hl
	ld hl, wAICardListBenchPriority
	ld [hl], e
	inc hl
	ld [hl], d
	pop hl
	ld e, [hl]
	inc hl
	ld d, [hl]
	inc hl
	push hl
	ld hl, wAICardListPlayFromHandPriority
	ld [hl], e
	inc hl
	ld [hl], d
	pop hl
	ld e, [hl]
	inc hl
	ld d, [hl]
	ld hl, wAICardListEnergyBonus
	ld [hl], e
	inc hl
	ld [hl], d
	ret

Func_14178:
	xor a
	ld [wd032], a
	call AIDecideBenchPokemonToSwitchTo
	ret

AIActionTable_GeneralDecks:
	dw .do_turn
	dw .do_turn
	dw .start_duel
	dw .forced_switch
	dw .ko_switch
	dw .take_prize
	dw .update_portrait

.do_turn
	farcall AIMainTurnLogic
	ret

.start_duel
	call InitAIDuelVars
	call AIPlayInitialBasicCards
	ret

.forced_switch
	call Func_14178
	ret

.ko_switch
	call Func_14178
	ret

.take_prize
	call AIPickPrizeCards
	ret

.update_portrait
	farcall AIUpdatePortrait
	ret

AIActionTable_HandOverGRDeck:
AIActionTable_SkilledWarriorDeck:
	dw .do_turn
	dw .do_turn
	dw .start_duel
	dw .forced_switch
	dw .ko_switch
	dw .take_prize
	dw .update_portrait

.do_turn
	farcall AIDoTurn_GeneralNoRetreat
	ret

.start_duel
	call InitAIDuelVars
	call AIPlayInitialBasicCards
	ret

.forced_switch
	call Func_14178
	ret

.ko_switch
	call Func_14178
	ret

.take_prize
	call AIPickPrizeCards
	ret

.update_portrait
	farcall AIUpdatePortrait
	ret

AIActionTable_ScriptedSamPracticeDeck:
	dw .do_turn
	dw .do_turn
	dw .start_duel
	dw .forced_switch
	dw .ko_switch
	dw .take_prize
	dw .update_portrait

.do_turn
	ld a, [wIsPracticeDuel]
	or a
	jr nz, .is_practice_duel_1
	farcall AIMainTurnLogic
	ret
.is_practice_duel_1
	farcall IsAISamPracticeScriptedTurn
	jr nc, .scripted_1
; not scripted, use AI main turn logic
	farcall AIMainTurnLogic
	ret
.scripted_1 ; use scripted actions instead
	farcall AISamPerformScriptedTurn
	ret

.start_duel
	farcall SetSamsStartingPlayArea
	ret

.forced_switch
	ld a, [wIsPracticeDuel]
	or a
	jr nz, .is_practice_duel_2
	call Func_14178
	ret
.is_practice_duel_2
	farcall IsAISamPracticeScriptedTurn
	jr nc, .scripted_2
	call Func_14178
	ret
.scripted_2
	call PickRandomBenchPokemon
	ret

.ko_switch
	ld a, [wIsPracticeDuel]
	or a
	jr nz, .is_practice_duel_3
	call Func_14178
	ret
.is_practice_duel_3
	farcall IsAISamPracticeScriptedTurn
	jr nc, .scripted_3
	call Func_14178
	ret
.scripted_3
	farcall GetPlayAreaLocationOfGoldeen
	ret

.take_prize
	farcall AITakePrizeCardInOrder
	ret

.update_portrait
	farcall AIUpdatePortrait
	ret

AIActionTable_AaronStep1Deck:
	dw .do_turn
	dw .do_turn
	dw .start_duel
	dw .forced_switch
	dw .ko_switch
	dw .take_prize
	dw .update_portrait

.do_turn
	farcall IsAIAaronStepScriptedTurn
	jr nc, .scripted
	farcall AIMainTurnLogic
	ret
.scripted
	farcall AIAaronStep1PerformScriptedTurn
	ret

.start_duel
	farcall SetAaronStep1StartingPlayArea
	ret

.forced_switch
	call Func_14178
	ret

.ko_switch
	call Func_14178
	ret

.take_prize
	farcall AITakePrizeCardInOrder
	ret

.update_portrait
	farcall AIUpdatePortrait
	ret

AIActionTable_AaronStep2Deck:
	dw .do_turn
	dw .do_turn
	dw .start_duel
	dw .forced_switch
	dw .ko_switch
	dw .take_prize
	dw .update_portrait

.do_turn
	farcall IsAIAaronStepScriptedTurn
	jr nc, .scripted
	farcall AIMainTurnLogic
	ret
.scripted
	farcall AIAaronStep2PerformScriptedTurn
	ret

.start_duel
	farcall SetAaronStep2StartingPlayArea
	ret

.forced_switch
	call Func_14178
	ret

.ko_switch
	call Func_14178
	ret

.take_prize
	farcall AITakePrizeCardInOrder
	ret

.update_portrait
	farcall AIUpdatePortrait
	ret

AIActionTable_AaronStep3Deck:
	dw .do_turn
	dw .do_turn
	dw .start_duel
	dw .forced_switch
	dw .ko_switch
	dw .take_prize
	dw .update_portrait

.do_turn
	ld a, [wAIPeekedPrizes]
	or a
	jr nz, .not_scripted
	farcall IsAIAaronStepScriptedTurn
	jr nc, .scripted
.not_scripted
	farcall AIMainTurnLogic
	ret
.scripted
	farcall AIAaronStep3PerformScriptedTurn
	ret

.start_duel
	farcall SetAaronStep3StartingPlayArea
	ret

.forced_switch
	call Func_14178
	ret

.ko_switch
	call Func_14178
	ret

.take_prize
	farcall AITakePrizeCardInOrder
	ret

.update_portrait
	farcall AIUpdatePortrait
	ret

AIActionTable_SkySparkDeck:
	dw .do_turn
	dw .do_turn
	dw .start_duel
	dw .forced_switch
	dw .ko_switch
	dw .take_prize
	dw .update_portrait

.do_turn
	farcall AIMainTurnLogic
	ret

.start_duel
	call InitAIDuelVars
	call .StoreListPointers
	farcall SetUpBossStartingHandAndDeck
	call TrySetUpBossStartingPlayArea
	ret nc
	call AIPlayInitialBasicCards
	ret

.forced_switch
	call Func_14178
	ret

.ko_switch
	call Func_14178
	ret

.take_prize
	call AIPickPrizeCards
	ret

.update_portrait
	farcall AIUpdatePortrait
	ret

.list_arena
	dw VOLTORB_LV13
	dw PIDGEY_LV10
	dw SPEAROW_LV9
	dw PIKACHU_LV14
	dw ZAPDOS_LV40
	dw NULL ; end

.list_bench
.list_play_from_hand
	dw PIKACHU_LV14
	dw ZAPDOS_LV40
	dw SPEAROW_LV9
	dw VOLTORB_LV13
	dw PIDGEY_LV10
	dw NULL ; end

; unreferenced
	ai_retreat ZAPDOS_LV40, -1
	dw NULL ; end

.list_energy
	ai_energy PIKACHU_LV14,   3, +1
	ai_energy RAICHU_LV45,    4, +1
	ai_energy DARK_RAICHU,    3, +1
	ai_energy VOLTORB_LV13,   1, +0
	ai_energy DARK_ELECTRODE, 2, +0
	ai_energy ZAPDOS_LV40,    4, +0
	ai_energy PIDGEY_LV10,    3, +0
	ai_energy PIDGEOTTO_LV36, 3, +0
	ai_energy SPEAROW_LV9,    3, +0
	ai_energy FEAROW_LV24,    3, +0
	dw NULL ; end

.list_prize
	dw PIKACHU_LV14
	dw NULL ; end

.StoreListPointers:
	ld hl, .CardListPointerTable
	call StoreAICardListPointers
	ret

.CardListPointerTable:
	dw .list_prize
	dw .list_arena
	dw .list_bench
	dw .list_play_from_hand
	dw .list_energy

AIActionTable_ElectricSelfdestructDeck:
	dw .do_turn
	dw .do_turn
	dw .start_duel
	dw .forced_switch
	dw .ko_switch
	dw .take_prize
	dw .update_portrait

.do_turn
	farcall AIMainTurnLogic
	ret

.start_duel
	call InitAIDuelVars
	call .StoreListPointers
	farcall SetUpBossStartingHandAndDeck
	call TrySetUpBossStartingPlayArea
	ret nc
	call AIPlayInitialBasicCards
	ret

.forced_switch
	call Func_14178
	ret

.ko_switch
	call Func_14178
	ret

.take_prize
	call AIPickPrizeCards
	ret

.update_portrait
	farcall AIUpdatePortrait
	ret

.list_arena
.list_bench
	dw ELECTABUZZ_LV35
	dw DODUO_LV10
	dw VOLTORB_LV8
	dw MAGNEMITE_LV13
	dw MAGNEMITE_LV15
	dw ZAPDOS_LV40
	dw NULL ; end

.list_play_from_hand
	dw MAGNEMITE_LV13
	dw MAGNEMITE_LV15
	dw VOLTORB_LV8
	dw ELECTABUZZ_LV35
	dw DODUO_LV10
	dw ZAPDOS_LV40
	dw NULL ; end

; unreferenced
	ai_retreat MAGNEMITE_LV15, -2
	dw NULL ; end

.list_energy
	ai_energy MAGNEMITE_LV13,  2, +1
	ai_energy MAGNEMITE_LV15,  2, +1
	ai_energy MAGNETON_LV28,   3, +1
	ai_energy VOLTORB_LV8,     2, +1
	ai_energy ELECTRODE_LV35,  3, +0
	ai_energy ELECTABUZZ_LV35, 3, +0
	ai_energy ZAPDOS_LV40,     4, +0
	ai_energy DODUO_LV10,      1, +0
	ai_energy DODRIO_LV25,     3, +0
	dw NULL ; end

.list_prize
	dw DEFENDER
	dw NULL ; end

.StoreListPointers:
	ld hl, .CardListPointerTable
	call StoreAICardListPointers
	ret

.CardListPointerTable:
	dw .list_prize
	dw .list_arena
	dw .list_bench
	dw .list_play_from_hand
	dw .list_energy

AIActionTable_PsychicEliteDeck:
	dw .do_turn
	dw .do_turn
	dw .start_duel
	dw .forced_switch
	dw .ko_switch
	dw .take_prize
	dw .update_portrait

.do_turn
	farcall AIMainTurnLogic
	ret

.start_duel
	call InitAIDuelVars
	call .StoreListPointers
	farcall SetUpBossStartingHandAndDeck
	call TrySetUpBossStartingPlayArea
	ret nc
	call AIPlayInitialBasicCards
	ret

.forced_switch
	call Func_14178
	ret

.ko_switch
	call Func_14178
	ret

.take_prize
	call AIPickPrizeCards
	ret

.update_portrait
	farcall AIUpdatePortrait
	ret

.list_arena
	dw GASTLY_LV13
	dw CHANSEY_LV55
	dw MEWTWO_LV60
	dw MR_MIME_LV28
	dw MR_MIME_LV20
	dw ABRA_LV14
	dw NULL ; end

.list_bench
.list_play_from_hand
	dw ABRA_LV14
	dw GASTLY_LV13
	dw MEWTWO_LV60
	dw MR_MIME_LV28
	dw CHANSEY_LV55
	dw NULL ; end

; unreferenced
	ai_retreat HAUNTER_LV26,  +1
	ai_retreat MEWTWO_LV60,   +1
	ai_retreat ABRA_LV14,     -5
	ai_retreat KADABRA_LV39,  -5
	ai_retreat ALAKAZAM_LV42, -8
	ai_retreat MR_MIME_LV20,  -8
	ai_retreat CHANSEY_LV55,  -8
	dw NULL ; end

.list_energy
	ai_energy ABRA_LV14,     1, -1
	ai_energy KADABRA_LV39,  3, -1
	ai_energy ALAKAZAM_LV42, 3, -1
	ai_energy GASTLY_LV13,   2, +0
	ai_energy HAUNTER_LV26,  2, -2
	ai_energy MR_MIME_LV20,  2, -3
	ai_energy MR_MIME_LV28,  2, +0
	ai_energy MEWTWO_LV60,   3, +0
	ai_energy CHANSEY_LV55,  4, -2
	dw NULL ; end

.list_prize
	dw MR_MIME_LV20
	dw NULL ; end

.StoreListPointers:
	ld hl, .CardListPointerTable
	call StoreAICardListPointers
	ret

.CardListPointerTable:
	dw .list_prize
	dw .list_arena
	dw .list_bench
	dw .list_play_from_hand
	dw .list_energy

AIActionTable_PuppetMasterDeck:
	dw .do_turn
	dw .do_turn
	dw .start_duel
	dw .forced_switch
	dw .ko_switch
	dw .take_prize
	dw .update_portrait

.do_turn
	farcall AIMainTurnLogic
	ret

.start_duel
	call InitAIDuelVars
	call .StoreListPointers
	call TrySetUpBossStartingPlayArea
	ret nc
	call AIPlayInitialBasicCards
	ret

.forced_switch
	call Func_14178
	ret

.ko_switch
	call Func_14178
	ret

.take_prize
	call AIPickPrizeCards
	ret

.update_portrait
	farcall AIUpdatePortrait
	ret

.list_arena
	dw SLOWPOKE_LV18
	dw MR_MIME_LV28
	dw DROWZEE_LV12
	dw NULL ; end

.list_bench
.list_play_from_hand
	dw DROWZEE_LV12
	dw MR_MIME_LV28
	dw SLOWPOKE_LV18
	dw NULL ; end

; unreferenced
	ai_retreat DROWZEE_LV12, -5
	ai_retreat HYPNO_LV30,   -8
	ai_retreat SLOWBRO_LV26, -5
	dw NULL ; end

.list_energy
	ai_energy SLOWPOKE_LV18, 2, +0
	ai_energy SLOWBRO_LV26,  2, -1
	ai_energy DROWZEE_LV12,  2, +2
	ai_energy HYPNO_LV30,    2, +4
	ai_energy MR_MIME_LV28,  2, +0
	dw NULL ; end

.StoreListPointers:
	ld hl, wAICardListArenaPriority
	ld de, .list_arena
	ld [hl], e
	inc hl
	ld [hl], d
	ld hl, wAICardListBenchPriority
	ld de, .list_bench
	ld [hl], e
	inc hl
	ld [hl], d
	ld hl, wAICardListPlayFromHandPriority
	ld de, .list_play_from_hand
	ld [hl], e
	inc hl
	ld [hl], d
	ld hl, wAICardListEnergyBonus
	ld de, .list_energy
	ld [hl], e
	inc hl
	ld [hl], d
	ret

AIActionTable_Even3YearsOnARockDeck:
	dw .do_turn
	dw .do_turn
	dw .start_duel
	dw .forced_switch
	dw .ko_switch
	dw .take_prize
	dw .update_portrait

.do_turn
	farcall AIMainTurnLogic
	ret

.start_duel
	call InitAIDuelVars
	call .StoreListPointers
	farcall SetUpBossStartingHandAndDeck
	call TrySetUpBossStartingPlayArea
	ret nc
	call AIPlayInitialBasicCards
	ret

.forced_switch
	call Func_14178
	ret

.ko_switch
	call Func_14178
	ret

.take_prize
	call AIPickPrizeCards
	ret

.update_portrait
	farcall AIUpdatePortrait
	ret

.list_arena
	dw ONIX_LV25
	dw CUBONE_LV13
	dw RHYHORN
	dw GEODUDE_LV16
	dw NULL ; end

.list_bench
.list_play_from_hand
	dw RHYHORN
	dw GEODUDE_LV16
	dw CUBONE_LV13
	dw ONIX_LV25
	dw NULL ; end

; unreferenced
	ai_retreat GEODUDE_LV16, -2
	dw NULL ; end

.list_energy
	ai_energy GEODUDE_LV16,  2, +0
	ai_energy GRAVELER_LV28, 2, +0
	ai_energy ONIX_LV25,     2, +0
	ai_energy CUBONE_LV13,   2, +0
	ai_energy MAROWAK_LV32,  3, -1
	ai_energy RHYHORN,       3, +0
	ai_energy RHYDON_LV48,   4, +0
	dw NULL ; end

.list_prize
	dw GAMBLER
	dw NULL ; end

.StoreListPointers:
	ld hl, .CardListPointerTable
	call StoreAICardListPointers
	ret

.CardListPointerTable:
	dw .list_prize
	dw .list_arena
	dw .list_bench
	dw .list_play_from_hand
	dw .list_energy

AIActionTable_RagingBillowOfFistsDeck:
	dw .do_turn
	dw .do_turn
	dw .start_duel
	dw .forced_switch
	dw .ko_switch
	dw .take_prize
	dw .update_portrait

.do_turn
	farcall AIMainTurnLogic
	ret

.start_duel
	call InitAIDuelVars
	call .StoreListPointers
	farcall SetUpBossStartingHandAndDeck
	call TrySetUpBossStartingPlayArea
	ret nc
	call AIPlayInitialBasicCards
	ret

.forced_switch
	call Func_14178
	ret

.ko_switch
	call Func_14178
	ret

.take_prize
	call AIPickPrizeCards
	ret

.update_portrait
	farcall AIUpdatePortrait
	ret

.list_arena
	dw LICKITUNG_LV20
	dw KANGASKHAN_LV38
	dw HITMONCHAN_LV33
	dw HITMONLEE_LV23
	dw MACHOP_LV18
	dw MACHOP_LV24
	dw MR_MIME_LV20
	dw NULL ; end

.list_bench
.list_play_from_hand
	dw MACHOP_LV18
	dw MACHOP_LV24
	dw HITMONCHAN_LV33
	dw HITMONLEE_LV23
	dw LICKITUNG_LV20
	dw KANGASKHAN_LV38
	dw NULL ; end

; unreferenced
	ai_retreat MR_MIME_LV20, -28
	dw NULL ; end

.list_energy
	ai_energy MACHOP_LV18,     3, +0
	ai_energy MACHOP_LV24,     3, +0
	ai_energy MACHOKE_LV24,    3, +0
	ai_energy MACHOKE_LV40,    4, +0
	ai_energy MACHAMP_LV54,    4, +0
	ai_energy HITMONLEE_LV23,  3, +0
	ai_energy HITMONCHAN_LV33, 3, +0
	ai_energy MR_MIME_LV20,    2, -8
	ai_energy LICKITUNG_LV20,  2, +0
	ai_energy KANGASKHAN_LV38, 3, +0
	dw NULL ; end

.list_prize
	dw MR_MIME_LV20
	dw NULL ; end

.StoreListPointers:
	ld hl, .CardListPointerTable
	call StoreAICardListPointers
	ret

.CardListPointerTable:
	dw .list_prize
	dw .list_arena
	dw .list_bench
	dw .list_play_from_hand
	dw .list_energy

AIActionTable_MaxEnergyDeck:
	dw .do_turn
	dw .do_turn
	dw .start_duel
	dw .forced_switch
	dw .ko_switch
	dw .take_prize
	dw .update_portrait

.do_turn
	farcall AIMainTurnLogic
	ret

.start_duel
	call InitAIDuelVars
	call .StoreListPointers
	farcall SetUpBossStartingHandAndDeck
	call TrySetUpBossStartingPlayArea
	ret nc
	call AIPlayInitialBasicCards
	ret

.forced_switch
	call Func_14178
	ret

.ko_switch
	call Func_14178
	ret

.take_prize
	call AIPickPrizeCards
	ret

.update_portrait
	farcall AIUpdatePortrait
	ret

.list_arena
	dw BULBASAUR_LV12
	dw CATERPIE
	dw EXEGGCUTE
	dw NULL ; end

.list_bench
.list_play_from_hand
	dw EXEGGCUTE
	dw BULBASAUR_LV12
	dw CATERPIE
	dw NULL ; end

; unreferenced
	ai_retreat VENUSAUR_LV67, -8
	ai_retreat EXEGGCUTE,     -2
	ai_retreat EXEGGUTOR,     +2
	dw NULL ; end

.list_energy
	ai_energy BULBASAUR_LV12, 2, +0
	ai_energy IVYSAUR_LV26,   3, +0
	ai_energy VENUSAUR_LV67,  4, +0
	ai_energy CATERPIE,       1, +0
	ai_energy METAPOD_LV20,   2, +0
	ai_energy BUTTERFREE,     4, +0
	ai_energy EXEGGCUTE,      2, +0
	ai_energy EXEGGUTOR,      6, +0
	dw NULL ; end

.list_prize
	dw VENUSAUR_LV67
	dw NULL ; end

.StoreListPointers:
	ld hl, .CardListPointerTable
	call StoreAICardListPointers
	ret

.CardListPointerTable:
	dw .list_prize
	dw .list_arena
	dw .list_bench
	dw .list_play_from_hand
	dw .list_energy

AIActionTable_DarkScienceDeck:
	dw .do_turn
	dw .do_turn
	dw .start_duel
	dw .forced_switch
	dw .ko_switch
	dw .take_prize
	dw .update_portrait

.do_turn
	farcall AIMainTurnLogic
	ret

.start_duel
	call InitAIDuelVars
	call .StoreListPointers
	farcall SetUpBossStartingHandAndDeck
	call TrySetUpBossStartingPlayArea
	ret nc
	call AIPlayInitialBasicCards
	ret

.forced_switch
	call Func_14178
	ret

.ko_switch
	call Func_14178
	ret

.take_prize
	call AIPickPrizeCards
	ret

.update_portrait
	farcall AIUpdatePortrait
	ret

.list_arena
	dw ZUBAT_LV12
	dw GRIMER_LV10
	dw EKANS_LV15
	dw CHANSEY_LV55
	dw KOFFING_LV13
	dw NULL ; end

.list_bench
.list_play_from_hand
	dw KOFFING_LV13
	dw EKANS_LV15
	dw ZUBAT_LV12
	dw GRIMER_LV10
	dw CHANSEY_LV55
	dw NULL ; end

; unreferenced
	ai_retreat WEEZING_LV26, -2
	ai_retreat KOFFING_LV13, -2
	dw NULL ; end

.list_energy
	ai_energy EKANS_LV15,   2,  +0
	ai_energy ARBOK_LV30,   3,  +0
	ai_energy ZUBAT_LV12,   2,  +0
	ai_energy GRIMER_LV10,  2,  +0
	ai_energy KOFFING_LV13, 2,  -1
	ai_energy WEEZING_LV26, 3,  -1
	ai_energy CHANSEY_LV55, 4, -28
	dw NULL ; end

.list_prize
	dw WEEZING_LV26
	dw NULL ; end

.StoreListPointers:
	ld hl, .CardListPointerTable
	call StoreAICardListPointers
	ret

.CardListPointerTable:
	dw .list_prize
	dw .list_arena
	dw .list_bench
	dw .list_play_from_hand
	dw .list_energy

AIActionTable_RainDanceConfusionDeck:
	dw .do_turn
	dw .do_turn
	dw .start_duel
	dw .forced_switch
	dw .ko_switch
	dw .take_prize
	dw .update_portrait

.do_turn
	farcall AIMainTurnLogic
	ret

.start_duel
	call InitAIDuelVars
	call .StoreListPointers
	farcall SetUpBossStartingHandAndDeck
	call TrySetUpBossStartingPlayArea
	ret nc
	call AIPlayInitialBasicCards
	ret

.forced_switch
	call Func_14178
	ret

.ko_switch
	call Func_14178
	ret

.take_prize
	call AIPickPrizeCards
	ret

.update_portrait
	farcall AIUpdatePortrait
	ret

.list_arena
	dw LAPRAS_LV31
	dw SEEL_LV10
	dw SQUIRTLE_LV15
	dw SQUIRTLE_LV16
	dw NULL ; end

.list_bench
.list_play_from_hand
	dw SQUIRTLE_LV16
	dw SQUIRTLE_LV15
	dw LAPRAS_LV31
	dw SEEL_LV10
	dw NULL ; end

; unreferenced
	ai_retreat SQUIRTLE_LV15,  -2
	ai_retreat SQUIRTLE_LV16,  -2
	ai_retreat WARTORTLE_LV22, -2
	dw NULL ; end

.list_energy
	ai_energy SQUIRTLE_LV15,  1, +0
	ai_energy SQUIRTLE_LV16,  2, +0
	ai_energy WARTORTLE_LV22, 3, +0
	ai_energy BLASTOISE_LV52, 5, +1
	ai_energy SEEL_LV10,      2, +0
	ai_energy DEWGONG_LV24,   3, +0
	ai_energy LAPRAS_LV31,    3, +0
	dw NULL ; end

.list_prize
	dw BLASTOISE_LV52
	dw NULL ; end

.StoreListPointers:
	ld hl, .CardListPointerTable
	call StoreAICardListPointers
	ret

.CardListPointerTable:
	dw .list_prize
	dw .list_arena
	dw .list_bench
	dw .list_play_from_hand
	dw .list_energy

AIActionTable_SplashingAboutDeck:
	dw .do_turn
	dw .do_turn
	dw .start_duel
	dw .forced_switch
	dw .ko_switch
	dw .take_prize
	dw .update_portrait

.do_turn
	farcall AIMainTurnLogic
	ret

.start_duel
	call InitAIDuelVars
	call .StoreListPointers
	call AIPlayInitialBasicCards
	ret

.forced_switch
	call Func_14178
	ret

.ko_switch
	call Func_14178
	ret

.take_prize
	call AIPickPrizeCards
	ret

.update_portrait
	farcall AIUpdatePortrait
	ret

.list_energy
	ai_energy SQUIRTLE_LV14,  2, +0
	ai_energy WARTORTLE_LV24, 2, +0
	ai_energy POLIWAG_LV13,   2, +0
	ai_energy HORSEA_LV20,    2, +0
	ai_energy SEADRA_LV23,    3, +0
	ai_energy SEADRA_LV26,    3, +0
	ai_energy LAPRAS_LV24,    2, +0
	ai_energy VAPOREON_LV42,  4, +0
	ai_energy EEVEE_LV12,     2, +0
	dw NULL ; end

.StoreListPointers:
	ld hl, wAICardListEnergyBonus
	ld de, .list_energy
	ld [hl], e
	inc hl
	ld [hl], d
	ret

AIActionTable_BeachDeck:
	dw .do_turn
	dw .do_turn
	dw .start_duel
	dw .forced_switch
	dw .ko_switch
	dw .take_prize
	dw .update_portrait

.do_turn
	farcall AIMainTurnLogic
	ret

.start_duel
	call InitAIDuelVars
	call .StoreListPointers
	call AIPlayInitialBasicCards
	ret

.forced_switch
	call Func_14178
	ret

.ko_switch
	call Func_14178
	ret

.take_prize
	call AIPickPrizeCards
	ret

.update_portrait
	farcall AIUpdatePortrait
	ret

.list_energy
	ai_energy TENTACOOL,     1, +0
	ai_energy TENTACRUEL,    2, +0
	ai_energy SHELLDER_LV16, 2, +0
	ai_energy CLOYSTER,      2, +0
	ai_energy KRABBY_LV17,   3, +0
	ai_energy KINGLER_LV33,  1, +0
	ai_energy STARYU_LV17,   2, +0
	ai_energy STARMIE,       3, +0
	dw NULL ; end

.StoreListPointers:
	ld hl, wAICardListEnergyBonus
	ld de, .list_energy
	ld [hl], e
	inc hl
	ld [hl], d
	ret

AIActionTable_GoArcanineDeck:
	dw .do_turn
	dw .do_turn
	dw .start_duel
	dw .forced_switch
	dw .ko_switch
	dw .take_prize
	dw .update_portrait

.do_turn
	farcall AIMainTurnLogic
	ret

.start_duel
	call InitAIDuelVars
	call .StoreListPointers
	farcall SetUpBossStartingHandAndDeck
	call TrySetUpBossStartingPlayArea
	ret nc
	call AIPlayInitialBasicCards
	ret

.forced_switch
	call Func_14178
	ret

.ko_switch
	call Func_14178
	ret

.take_prize
	call AIPickPrizeCards
	ret

.update_portrait
	farcall AIUpdatePortrait
	ret

.list_arena
	dw MAGMAR_LV31
	dw DODUO_LV10
	dw HITMONCHAN_LV23
	dw HITMONCHAN_LV33
	dw SEEL_LV12
	dw GROWLITHE_LV12
	dw GROWLITHE_LV18
	dw NULL ; end

.list_bench
.list_play_from_hand
	dw MAGMAR_LV31
	dw DODUO_LV10
	dw GROWLITHE_LV12
	dw GROWLITHE_LV18
	dw HITMONCHAN_LV33
	dw HITMONCHAN_LV23
	dw SEEL_LV12
	dw NULL ; end

; unreferenced
	ai_retreat GROWLITHE_LV12, -2
	ai_retreat GROWLITHE_LV18, -2
	ai_retreat DODUO_LV10,     -1
	ai_retreat DODRIO_LV28,    -2
	dw NULL ; end

.list_energy
	ai_energy GROWLITHE_LV12,  2, +1
	ai_energy GROWLITHE_LV18,  2, +1
	ai_energy ARCANINE_LV45,   4, +1
	ai_energy MAGMAR_LV31,     1, +1
	ai_energy SEEL_LV12,       1, +0
	ai_energy DEWGONG_LV42,    4, +0
	ai_energy HITMONCHAN_LV23, 1, +0
	ai_energy HITMONCHAN_LV33, 3, -1
	ai_energy DODUO_LV10,      1, +0
	ai_energy DODRIO_LV28,     3, -1
	dw NULL ; end

.list_prize
	dw GROWLITHE_LV12
	dw GROWLITHE_LV18
	dw ARCANINE_LV45
	dw MAGMAR_LV31
	dw NULL ; end

.StoreListPointers:
	ld hl, .CardListPointerTable
	call StoreAICardListPointers
	ret

.CardListPointerTable:
	dw .list_prize
	dw .list_arena
	dw .list_bench
	dw .list_play_from_hand
	dw .list_energy

AIActionTable_GreatRocket4Deck:
	dw .do_turn
	dw .do_turn
	dw .start_duel
	dw .forced_switch
	dw .ko_switch
	dw .take_prize
	dw .update_portrait

.do_turn
	farcall AIMainTurnLogic
	ret

.start_duel
	call InitAIDuelVars
	call .StoreListPointers
	farcall SetUpBossStartingHandAndDeck
	call TrySetUpBossStartingPlayArea
	ret nc
	call AIPlayInitialBasicCards
	ret

.forced_switch
	call Func_14178
	ret

.ko_switch
	call Func_14178
	ret

.take_prize
	call AIPickPrizeCards
	ret

.update_portrait
	farcall AIUpdatePortrait
	ret

.list_arena
	dw JYNX_LV18
	dw JYNX_LV27
	dw PSYDUCK_LV16
	dw MEW_LV23
	dw DROWZEE_LV12
	dw HORSEA_LV20
	dw KRABBY_LV17
	dw DROWZEE_LV10
	dw NULL ; end

.list_bench
.list_play_from_hand
	dw KRABBY_LV17
	dw HORSEA_LV20
	dw PSYDUCK_LV16
	dw MEW_LV23
	dw JYNX_LV18
	dw JYNX_LV27
	dw DROWZEE_LV12
	dw DROWZEE_LV10
	dw NULL ; end

; unreferenced
	ai_retreat DROWZEE_LV10, -8
	dw NULL ; end

.list_energy
	ai_energy PSYDUCK_LV16, 1, +0
	ai_energy DARK_GOLDUCK, 3, +0
	ai_energy KRABBY_LV17,  3, +0
	ai_energy KINGLER_LV33, 4, +0
	ai_energy HORSEA_LV20,  3, +0
	ai_energy SEADRA_LV26,  4, +0
	ai_energy DROWZEE_LV10, 2, -3
	ai_energy DROWZEE_LV12, 3, +0
	ai_energy DARK_HYPNO,   3, +0
	ai_energy JYNX_LV18,    2, +0
	ai_energy JYNX_LV27,    2, +0
	ai_energy MEW_LV23,     2, +0
	dw NULL ; end

.list_prize
	dw FULL_HEAL
	dw NULL ; end

.StoreListPointers:
	ld hl, .CardListPointerTable
	call StoreAICardListPointers
	ret

.CardListPointerTable:
	dw .list_prize
	dw .list_arena
	dw .list_bench
	dw .list_play_from_hand
	dw .list_energy

AIActionTable_GreatRocket1Deck:
	dw .do_turn
	dw .do_turn
	dw .start_duel
	dw .forced_switch
	dw .ko_switch
	dw .take_prize
	dw .update_portrait

.do_turn
	farcall AIMainTurnLogic
	ret

.start_duel
	call InitAIDuelVars
	call .StoreListPointers
	farcall SetUpBossStartingHandAndDeck
	call TrySetUpBossStartingPlayArea
	ret nc
	call AIPlayInitialBasicCards
	ret

.forced_switch
	call Func_14178
	ret

.ko_switch
	call Func_14178
	ret

.take_prize
	call AIPickPrizeCards
	ret

.update_portrait
	farcall AIUpdatePortrait
	ret

.list_arena
	dw POLIWAG_LV15
	dw LAPRAS_LV24
	dw PIKACHU_LV5
	dw MAGNEMITE_LV12
	dw VOLTORB_LV13
	dw KANGASKHAN_LV36
	dw SEEL_LV10
	dw MAGNEMITE_LV15
	dw NULL ; end

.list_bench
.list_play_from_hand
	dw MAGNEMITE_LV15
	dw POLIWAG_LV15
	dw SEEL_LV10
	dw KANGASKHAN_LV36
	dw LAPRAS_LV24
	dw VOLTORB_LV13
	dw MAGNEMITE_LV12
	dw PIKACHU_LV5
	dw NULL ; end

; unreferenced
	ai_retreat MAGNEMITE_LV12, -1
	ai_retreat MAGNEMITE_LV15, -2
	dw NULL ; end

.list_energy
	ai_energy VOLTORB_LV13,    1, +0
	ai_energy ELECTRODE_LV42,  4, +0
	ai_energy MAGNEMITE_LV12,  3, +0
	ai_energy MAGNEMITE_LV15,  1, +0
	ai_energy PIKACHU_LV5,     2, +0
	ai_energy POLIWAG_LV15,    2, +0
	ai_energy POLIWHIRL_LV30,  3, +0
	ai_energy POLIWRATH_LV40,  5, +0
	ai_energy SEEL_LV10,       3, +0
	ai_energy DEWGONG_LV24,    5, +0
	ai_energy LAPRAS_LV24,     3, +0
	ai_energy KANGASKHAN_LV36, 3, +1
	dw NULL ; end

.list_prize
	dw SWITCH
	dw NULL ; end

.StoreListPointers:
	ld hl, .CardListPointerTable
	call StoreAICardListPointers
	ret

.CardListPointerTable:
	dw .list_prize
	dw .list_arena
	dw .list_bench
	dw .list_play_from_hand
	dw .list_energy

AIActionTable_GreatRocket2Deck:
	dw .do_turn
	dw .do_turn
	dw .start_duel
	dw .forced_switch
	dw .ko_switch
	dw .take_prize
	dw .update_portrait

.do_turn
	farcall AIMainTurnLogic
	ret

.start_duel
	call InitAIDuelVars
	call .StoreListPointers
	farcall SetUpBossStartingHandAndDeck
	call TrySetUpBossStartingPlayArea
	ret nc
	call AIPlayInitialBasicCards
	ret

.forced_switch
	call Func_14178
	ret

.ko_switch
	call Func_14178
	ret

.take_prize
	call AIPickPrizeCards
	ret

.update_portrait
	farcall AIUpdatePortrait
	ret

.list_arena
	dw ONIX_LV25
	dw GEODUDE_LV15
	dw PINSIR_LV15
	dw DIGLETT_LV8
	dw DIGLETT_LV15
	dw PARAS_LV8
	dw SANDSHREW_LV12
	dw EKANS_LV10
	dw EKANS_LV15
	dw NULL ; end

.list_bench
.list_play_from_hand
	dw EKANS_LV10
	dw EKANS_LV15
	dw SANDSHREW_LV12
	dw PARAS_LV8
	dw DIGLETT_LV8
	dw DIGLETT_LV15
	dw ONIX_LV25
	dw GEODUDE_LV15
	dw PINSIR_LV15
	dw NULL ; end

; unreferenced
	ai_retreat EKANS_LV10,     -2
	ai_retreat EKANS_LV15,     -2
	ai_retreat PARAS_LV8,      -2
	ai_retreat SANDSHREW_LV12, -1
	ai_retreat DIGLETT_LV8,    -1
	ai_retreat DIGLETT_LV15,   -1
	dw NULL ; end

.list_energy
	ai_energy EKANS_LV10,     2, +0
	ai_energy EKANS_LV15,     2, +0
	ai_energy DARK_ARBOK,     4, +0
	ai_energy PARAS_LV8,      4, +0
	ai_energy PARASECT_LV29,  4, +0
	ai_energy PINSIR_LV15,    3, +0
	ai_energy SANDSHREW_LV12, 1, +0
	ai_energy SANDSLASH_LV33, 3, +0
	ai_energy SANDSLASH_LV35, 3, +0
	ai_energy DIGLETT_LV8,    2, +0
	ai_energy DIGLETT_LV15,   2, +0
	ai_energy DARK_DUGTRIO,   2, +0
	ai_energy GEODUDE_LV15,   2, +0
	ai_energy ONIX_LV25,      2, +0
	dw NULL ; end

.list_prize
	dw DARK_ARBOK
	dw NULL ; end

.StoreListPointers:
	ld hl, .CardListPointerTable
	call StoreAICardListPointers
	ret

.CardListPointerTable:
	dw .list_prize
	dw .list_arena
	dw .list_bench
	dw .list_play_from_hand
	dw .list_energy

AIActionTable_GreatRocket3Deck:
	dw .do_turn
	dw .do_turn
	dw .start_duel
	dw .forced_switch
	dw .ko_switch
	dw .take_prize
	dw .update_portrait

.do_turn
	farcall AIMainTurnLogic
	ret

.start_duel
	call InitAIDuelVars
	call .StoreListPointers
	farcall SetUpBossStartingHandAndDeck
	call TrySetUpBossStartingPlayArea
	ret nc
	call AIPlayInitialBasicCards
	ret

.forced_switch
	call Func_14178
	ret

.ko_switch
	call Func_14178
	ret

.take_prize
	call AIPickPrizeCards
	ret

.update_portrait
	farcall AIUpdatePortrait
	ret

.list_arena
	dw MAGMAR_LV18
	dw TANGELA_LV12
	dw PINSIR_LV24
	dw MOLTRES_LV37
	dw ODDISH_LV8
	dw CHARMANDER_LV12
	dw EXEGGCUTE
	dw NULL ; end

.list_bench
.list_play_from_hand
	dw EXEGGCUTE
	dw CHARMANDER_LV12
	dw ODDISH_LV8
	dw MAGMAR_LV18
	dw TANGELA_LV12
	dw PINSIR_LV24
	dw MOLTRES_LV37
	dw NULL ; end

; unreferenced
	ai_retreat EXEGGCUTE, -3
	dw NULL ; end

.list_energy
	ai_energy ODDISH_LV8,       2, +0
	ai_energy DARK_GLOOM,       2, +0
	ai_energy DARK_VILEPLUME,   3, +0
	ai_energy EXEGGCUTE,        3, +0
	ai_energy EXEGGUTOR,       28, +1
	ai_energy TANGELA_LV12,     3, +0
	ai_energy PINSIR_LV24,      4, +0
	ai_energy CHARMANDER_LV12,  2, +0
	ai_energy CHARMELEON,       5, +0
	ai_energy DARK_CHARMELEON,  5, +0
	ai_energy MAGMAR_LV18,      2, +0
	ai_energy MOLTRES_LV37,     4, +0
	dw NULL ; end

.list_prize
	dw EXEGGCUTE
	dw EXEGGUTOR
	dw NULL ; end

.StoreListPointers:
	ld hl, .CardListPointerTable
	call StoreAICardListPointers
	ret

.CardListPointerTable:
	dw .list_prize
	dw .list_arena
	dw .list_bench
	dw .list_play_from_hand
	dw .list_energy

AIActionTable_GrandFireDeck:
	dw .do_turn
	dw .do_turn
	dw .start_duel
	dw .forced_switch
	dw .ko_switch
	dw .take_prize
	dw .update_portrait

.do_turn
	farcall AIMainTurnLogic
	ret

.start_duel
	call InitAIDuelVars
	call .StoreListPointers
	farcall SetUpBossStartingHandAndDeck
	call TrySetUpBossStartingPlayArea
	ret nc
	call AIPlayInitialBasicCards
	ret

.forced_switch
	call Func_14178
	ret

.ko_switch
	call Func_14178
	ret

.take_prize
	call AIPickPrizeCards
	ret

.update_portrait
	farcall AIUpdatePortrait
	ret

.list_arena
	dw MAGMAR_LV31
	dw PONYTA_LV8
	dw VULPIX_LV11
	dw VULPIX_LV13
	dw MOLTRES_LV37
	dw MOLTRES_LV40
	dw NULL ; end

.list_bench
	dw MAGMAR_LV31
	dw VULPIX_LV13
	dw VULPIX_LV11
	dw PONYTA_LV8
	dw MOLTRES_LV37
	dw NULL ; end

.list_play_from_hand
	dw MOLTRES_LV40
	dw VULPIX_LV13
	dw VULPIX_LV11
	dw PONYTA_LV8
	dw MAGMAR_LV31
	dw MOLTRES_LV37
	dw NULL ; end

; unreferenced
	ai_retreat MOLTRES_LV40,   -2
	ai_retreat MOLTRES_LV37,   -2
	ai_retreat PONYTA_LV8,     -3
	ai_retreat RAPIDASH_LV33,  +1
	ai_retreat VULPIX_LV11,    -3
	ai_retreat VULPIX_LV13,    -3
	ai_retreat NINETALES_LV35, +1
	dw NULL ; end

.list_energy
	ai_energy MOLTRES_LV40,   3, -3
	ai_energy MOLTRES_LV37,   4, -3
	ai_energy PONYTA_LV8,     2, +2
	ai_energy RAPIDASH_LV33,  3, +1
	ai_energy VULPIX_LV11,    2, +2
	ai_energy VULPIX_LV13,    2, +2
	ai_energy NINETALES_LV35, 3, +1
	ai_energy MAGMAR_LV31,    1, +2
	dw NULL ; end

.list_prize
	dw MOLTRES_LV40
	dw NULL ; end

.StoreListPointers:
	ld hl, .CardListPointerTable
	call StoreAICardListPointers
	ret

.CardListPointerTable:
	dw .list_prize
	dw .list_arena
	dw .list_bench
	dw .list_play_from_hand
	dw .list_energy

AIActionTable_LegendaryFossilDeck:
	dw .do_turn
	dw .do_turn
	dw .start_duel
	dw .forced_switch
	dw .ko_switch
	dw .take_prize
	dw .update_portrait

.do_turn
	farcall AIDoTurn_GeneralNoPkmnPowers
	ret

.start_duel
	call InitAIDuelVars
	call .StoreListPointers
	farcall SetUpBossStartingHandAndDeck
	call TrySetUpBossStartingPlayArea
	ret nc
	call AIPlayInitialBasicCards
	ret

.forced_switch
	call Func_14178
	ret

.ko_switch
	call Func_14178
	ret

.take_prize
	call AIPickPrizeCards
	ret

.update_portrait
	farcall AIUpdatePortrait
	ret

.list_arena
	dw ELECTABUZZ_LV35
	dw VOLTORB_LV13
	dw ZAPDOS_LV28
	dw ZAPDOS_LV68
	dw NULL ; end

.list_bench
.list_play_from_hand
	dw VOLTORB_LV13
	dw ELECTABUZZ_LV35
	dw ZAPDOS_LV28
	dw NULL ; end

; unreferenced
	ai_retreat AERODACTYL_LV28, -3
	ai_retreat ZAPDOS_LV68,     -2
	ai_retreat ZAPDOS_LV28,     -2
	ai_retreat VOLTORB_LV13,    -1
	dw NULL ; end

.list_energy
	ai_energy VOLTORB_LV13,    1, +0
	ai_energy ELECTRODE_LV35,  2, +0
	ai_energy ELECTABUZZ_LV35, 2, +0
	ai_energy ZAPDOS_LV28,     4, -1
	ai_energy ZAPDOS_LV68,     3, -1
	ai_energy AERODACTYL_LV28, 3, +0
	dw NULL ; end

.list_prize
	dw ZAPDOS_LV68
	dw NULL ; end

.StoreListPointers:
	ld hl, .CardListPointerTable
	call StoreAICardListPointers
	ret

.CardListPointerTable:
	dw .list_prize
	dw .list_arena
	dw .list_bench
	dw .list_play_from_hand
	dw .list_energy

AIActionTable_WaterLegendDeck:
	dw .do_turn
	dw .do_turn
	dw .start_duel
	dw .forced_switch
	dw .ko_switch
	dw .take_prize
	dw .update_portrait

.do_turn
	farcall AIMainTurnLogic
	ret

.start_duel
	call InitAIDuelVars
	call .StoreListPointers
	farcall SetUpBossStartingHandAndDeck
	call TrySetUpBossStartingPlayArea
	ret nc
	call AIPlayInitialBasicCards
	ret

.forced_switch
	call Func_14178
	ret

.ko_switch
	call Func_14178
	ret

.take_prize
	call AIPickPrizeCards
	ret

.update_portrait
	farcall AIUpdatePortrait
	ret

.list_arena
	dw CHANSEY_LV40
	dw JYNX_LV18
	dw LAPRAS_LV31
	dw KRABBY_LV17
	dw ARTICUNO_LV34
	dw MAGIKARP_LV6
	dw ARTICUNO_LV37
	dw NULL ; end

.list_bench
.list_play_from_hand
	dw MAGIKARP_LV6
	dw ARTICUNO_LV34
	dw KRABBY_LV17
	dw LAPRAS_LV31
	dw JYNX_LV18
	dw CHANSEY_LV40
	dw NULL ; end

; unreferenced
	ai_retreat MAGIKARP_LV6,  -2
	ai_retreat ARTICUNO_LV37, -5
	dw NULL ; end

.list_energy
	ai_energy KRABBY_LV17,   3, +0
	ai_energy KINGLER_LV33,  4, +0
	ai_energy MAGIKARP_LV6,  3, +1
	ai_energy DARK_GYARADOS, 3, +0
	ai_energy LAPRAS_LV31,   3, +0
	ai_energy ARTICUNO_LV34, 4, +1
	ai_energy ARTICUNO_LV37, 0, -8
	ai_energy JYNX_LV18,     2, +0
	ai_energy CHANSEY_LV40,  3, -2
	dw NULL ; end

.list_prize
	dw ARTICUNO_LV37
	dw NULL ; end

.StoreListPointers:
	ld hl, .CardListPointerTable
	call StoreAICardListPointers
	ret

.CardListPointerTable:
	dw .list_prize
	dw .list_arena
	dw .list_bench
	dw .list_play_from_hand
	dw .list_energy

AIActionTable_GreatDragonDeck:
	dw .do_turn
	dw .do_turn
	dw .start_duel
	dw .forced_switch
	dw .ko_switch
	dw .take_prize
	dw .update_portrait

.do_turn
	farcall AIMainTurnLogic
	ret

.start_duel
	call InitAIDuelVars
	call .StoreListPointers
	farcall SetUpBossStartingHandAndDeck
	call TrySetUpBossStartingPlayArea
	ret nc
	call AIPlayInitialBasicCards
	ret

.forced_switch
	call Func_14178
	ret

.ko_switch
	call Func_14178
	ret

.take_prize
	call AIPickPrizeCards
	ret

.update_portrait
	farcall AIUpdatePortrait
	ret

.list_arena
	dw KANGASKHAN_LV40
	dw SCYTHER_LV25
	dw DRATINI_LV10
	dw DRATINI_LV12
	dw CHARMANDER_LV9
	dw CHARMANDER_LV10
	dw NULL ; end

.list_bench
.list_play_from_hand
	dw DRATINI_LV10
	dw DRATINI_LV12
	dw CHARMANDER_LV9
	dw CHARMANDER_LV10
	dw SCYTHER_LV25
	dw KANGASKHAN_LV40
	dw NULL ; end

; unreferenced
	ai_retreat DRATINI_LV10,    -2
	ai_retreat DRATINI_LV12,    -2
	ai_retreat CHARMANDER_LV9,  -4
	ai_retreat CHARMANDER_LV10, -5
	ai_retreat CHARMELEON,      -3
	dw NULL ; end

.list_energy
	ai_energy CHARMANDER_LV9,     3, +1
	ai_energy CHARMANDER_LV10,    3, +1
	ai_energy CHARMELEON,         4, +1
	ai_energy CHARIZARD_LV76,     6, +1
	ai_energy CHARIZARD_ALT_LV76, 6, +1
	ai_energy DRATINI_LV10,       2, +0
	ai_energy DRATINI_LV12,       2, +0
	ai_energy DRAGONAIR,          4, +1
	ai_energy DARK_DRAGONAIR,     3, -1
	ai_energy DRAGONITE_LV41,     3, +0
	ai_energy KANGASKHAN_LV40,    4, -8
	ai_energy SCYTHER_LV25,       3, +0
	dw NULL ; end

.list_prize
	dw DRAGONITE_LV41
	dw NULL ; end

.StoreListPointers:
	ld hl, .CardListPointerTable
	call StoreAICardListPointers
	ret

.CardListPointerTable:
	dw .list_prize
	dw .list_arena
	dw .list_bench
	dw .list_play_from_hand
	dw .list_energy

AIActionTable_MadPetalsDeck:
	dw .do_turn
	dw .do_turn
	dw .start_duel
	dw .forced_switch
	dw .ko_switch
	dw .take_prize
	dw .update_portrait

.do_turn
	farcall AIMainTurnLogic
	ret

.start_duel
	call InitAIDuelVars
	call .StoreListPointers
	farcall SetUpBossStartingHandAndDeck
	call TrySetUpBossStartingPlayArea
	ret nc
	call AIPlayInitialBasicCards
	ret

.forced_switch
	call Func_14178
	ret

.ko_switch
	call Func_14178
	ret

.take_prize
	call AIPickPrizeCards
	ret

.update_portrait
	farcall AIUpdatePortrait
	ret

.list_arena
	dw KANGASKHAN_LV40
	dw SCYTHER_LV25
	dw ODDISH_LV21
	dw SQUIRTLE_LV16
	dw NULL ; end

.list_bench
.list_play_from_hand
	dw ODDISH_LV21
	dw SQUIRTLE_LV16
	dw SCYTHER_LV25
	dw KANGASKHAN_LV40
	dw NULL ; end

; unreferenced
	ai_retreat ODDISH_LV21,    -3
	ai_retreat GLOOM,          -2
	ai_retreat DARK_GLOOM,     -3
	ai_retreat SQUIRTLE_LV16,  -2
	ai_retreat WARTORTLE_LV22, -1
	dw NULL ; end

.list_energy
	ai_energy ODDISH_LV21,     2, +1
	ai_energy GLOOM,           2, +1
	ai_energy DARK_GLOOM,      2, +1
	ai_energy VILEPLUME,       3, +1
	ai_energy DARK_VILEPLUME,  3, +1
	ai_energy SCYTHER_LV25,    3, +0
	ai_energy SQUIRTLE_LV16,   2, +0
	ai_energy WARTORTLE_LV22,  3, +0
	ai_energy KANGASKHAN_LV40, 4, -5
	dw NULL ; end

.list_prize
	dw KANGASKHAN_LV40
	dw NULL ; end

.StoreListPointers:
	ld hl, .CardListPointerTable
	call StoreAICardListPointers
	ret

.CardListPointerTable:
	dw .list_prize
	dw .list_arena
	dw .list_bench
	dw .list_play_from_hand
	dw .list_energy

AIActionTable_DangerousBenchDeck:
	dw .do_turn
	dw .do_turn
	dw .start_duel
	dw .forced_switch
	dw .ko_switch
	dw .take_prize
	dw .update_portrait

.do_turn
	farcall AIMainTurnLogic
	ret

.start_duel
	call InitAIDuelVars
	call .StoreListPointers
	call TrySetUpBossStartingPlayArea
	ret nc
	call AIPlayInitialBasicCards
	ret

.forced_switch
	call Func_14178
	ret

.ko_switch
	call Func_14178
	ret

.take_prize
	call AIPickPrizeCards
	ret

.update_portrait
	farcall AIUpdatePortrait
	ret

.list_arena
	dw HUNGRY_SNORLAX
	dw SNORLAX_LV20
	dw SNORLAX_LV35
	dw PIKACHU_LV14
	dw ZAPDOS_LV40
	dw DRATINI_LV12
	dw NULL ; end

.list_bench
.list_play_from_hand
	dw DRATINI_LV12
	dw PIKACHU_LV14
	dw ZAPDOS_LV40
	dw SNORLAX_LV35
	dw SNORLAX_LV20
	dw HUNGRY_SNORLAX
	dw NULL ; end

.StoreListPointers:
	ld hl, wAICardListArenaPriority
	ld de, .list_arena
	ld [hl], e
	inc hl
	ld [hl], d
	ld hl, wAICardListBenchPriority
	ld de, .list_bench
	ld [hl], e
	inc hl
	ld [hl], d
	ld hl, wAICardListPlayFromHandPriority
	ld de, .list_play_from_hand
	ld [hl], e
	inc hl
	ld [hl], d
	ret

AIActionTable_QuickAttackDeck:
	dw .do_turn
	dw .do_turn
	dw .start_duel
	dw .forced_switch
	dw .ko_switch
	dw .take_prize
	dw .update_portrait

.do_turn
	farcall AIMainTurnLogic
	ret

.start_duel
	call InitAIDuelVars
	call .StoreListPointers
	farcall SetUpBossStartingHandAndDeck
	call TrySetUpBossStartingPlayArea
	ret nc
	call AIPlayInitialBasicCards
	ret

.forced_switch
	call Func_14178
	ret

.ko_switch
	call Func_14178
	ret

.take_prize
	call AIPickPrizeCards
	ret

.update_portrait
	farcall AIUpdatePortrait
	ret

.list_arena
	dw VOLTORB_LV13
	dw DODUO_LV10
	dw EEVEE_LV9
	dw PIKACHU_LV14
	dw PIKACHU_LV5
	dw NULL ; end

.list_bench
.list_play_from_hand
	dw EEVEE_LV9
	dw PIKACHU_LV5
	dw PIKACHU_LV14
	dw VOLTORB_LV13
	dw DODUO_LV10
	dw NULL ; end

; unreferenced
	ai_retreat PIKACHU_LV5,  -1
	ai_retreat PIKACHU_LV14, -1
	ai_retreat EEVEE_LV9,    -1
	dw NULL ; end

.list_energy
	ai_energy PIKACHU_LV5,  2, +0
	ai_energy PIKACHU_LV14, 2, +0
	ai_energy DARK_RAICHU,  3, +0
	ai_energy VOLTORB_LV13, 1, +1
	ai_energy DARK_JOLTEON, 3, +0
	ai_energy DODUO_LV10,   1, +1
	ai_energy EEVEE_LV9,    2, +1
	dw NULL ; end

.list_prize
	dw DARK_JOLTEON
	dw DARK_RAICHU
	dw NULL ; end

.StoreListPointers:
	ld hl, .CardListPointerTable
	call StoreAICardListPointers
	ret

.CardListPointerTable:
	dw .list_prize
	dw .list_arena
	dw .list_bench
	dw .list_play_from_hand
	dw .list_energy

AIActionTable_CompleteCombustionDeck:
	dw .do_turn
	dw .do_turn
	dw .start_duel
	dw .forced_switch
	dw .ko_switch
	dw .take_prize
	dw .update_portrait

.do_turn
	farcall AIMainTurnLogic
	ret

.start_duel
	call InitAIDuelVars
	call .StoreListPointers
	call TrySetUpBossStartingPlayArea
	ret nc
	call AIPlayInitialBasicCards
	ret

.forced_switch
	call Func_14178
	ret

.ko_switch
	call Func_14178
	ret

.take_prize
	call AIPickPrizeCards
	ret

.update_portrait
	farcall AIUpdatePortrait
	ret

.list_arena
	dw KANGASKHAN_LV40
	dw MEOWTH_LV14
	dw GROWLITHE_LV12
	dw PONYTA_LV15
	dw MAGMAR_LV27
	dw NULL; end

.list_bench
	dw MAGMAR_LV27
	dw PONYTA_LV15
	dw GROWLITHE_LV12
	dw MEOWTH_LV14
	dw KANGASKHAN_LV40
	dw NULL; end

.StoreListPointers:
	ld hl, wAICardListArenaPriority
	ld de, .list_arena
	ld [hl], e
	inc hl
	ld [hl], d
	ld hl, wAICardListBenchPriority
	ld de, .list_bench
	ld [hl], e
	inc hl
	ld [hl], d
	ret

AIActionTable_GazeUponThePowerOfFireDeck:
	dw .do_turn
	dw .do_turn
	dw .start_duel
	dw .forced_switch
	dw .ko_switch
	dw .take_prize
	dw .update_portrait

.do_turn
	farcall AIMainTurnLogic
	ret

.start_duel
	call InitAIDuelVars
	call .StoreListPointers
	farcall SetUpBossStartingHandAndDeck
	call TrySetUpBossStartingPlayArea
	ret nc
	call AIPlayInitialBasicCards
	ret

.forced_switch
	call Func_14178
	ret

.ko_switch
	call Func_14178
	ret

.take_prize
	call AIPickPrizeCards
	ret

.update_portrait
	farcall AIUpdatePortrait
	ret

.list_arena
	dw MAGMAR_LV31
	dw CHARMANDER_LV9
	dw PONYTA_LV8
	dw VULPIX_LV11
	dw NULL ; end

.list_bench
.list_play_from_hand
	dw VULPIX_LV11
	dw PONYTA_LV8
	dw CHARMANDER_LV9
	dw MAGMAR_LV31
	dw NULL ; end

; unreferenced
	ai_retreat CHARMANDER_LV9, -3
	ai_retreat VULPIX_LV11,    -3
	ai_retreat PONYTA_LV8,     -3
	dw NULL ; end

.list_energy
	ai_energy CHARMANDER_LV9,  1, +0
	ai_energy DARK_CHARMELEON, 3, +1
	ai_energy VULPIX_LV11,     2, +0
	ai_energy DARK_NINETALES,  3, +1
	ai_energy PONYTA_LV8,      1, +0
	ai_energy RAPIDASH_LV33,   3, +1
	ai_energy MAGMAR_LV31,     2, +0
	dw NULL ; end

.list_prize
	dw MAGMAR_LV31
	dw NULL ; end

.StoreListPointers:
	ld hl, .CardListPointerTable
	call StoreAICardListPointers
	ret

.CardListPointerTable:
	dw .list_prize
	dw .list_arena
	dw .list_bench
	dw .list_play_from_hand
	dw .list_energy

AIActionTable_WaterStreamDeck:
	dw .do_turn
	dw .do_turn
	dw .start_duel
	dw .forced_switch
	dw .ko_switch
	dw .take_prize
	dw .update_portrait

.do_turn
	farcall AIMainTurnLogic
	ret

.start_duel
	call InitAIDuelVars
	call .StoreListPointers
	farcall SetUpBossStartingHandAndDeck
	call TrySetUpBossStartingPlayArea
	ret nc
	call AIPlayInitialBasicCards
	ret

.forced_switch
	call Func_14178
	ret

.ko_switch
	call Func_14178
	ret

.take_prize
	call AIPickPrizeCards
	ret

.update_portrait
	farcall AIUpdatePortrait
	ret

.list_arena
	dw LAPRAS_LV31
	dw STARYU_LV15
	dw GOLDEEN
	dw ARTICUNO_LV34
	dw NULL ; end

.list_bench
.list_play_from_hand
	dw STARYU_LV15
	dw ARTICUNO_LV34
	dw GOLDEEN
	dw LAPRAS_LV31
	dw NULL ; end

; unreferenced
	ai_retreat GOLDEEN, -1
	dw NULL ; end

.list_energy
	ai_energy GOLDEEN,       1, +0
	ai_energy SEAKING,       2, +0
	ai_energy STARYU_LV15,   1, +0
	ai_energy DARK_STARMIE,  2, +0
	ai_energy LAPRAS_LV31,   3, +0
	ai_energy ARTICUNO_LV34, 4, +0
	dw NULL ; end

.list_prize
	dw LAPRAS_LV31
	dw NULL ; end

.StoreListPointers:
	ld hl, .CardListPointerTable
	call StoreAICardListPointers
	ret

.CardListPointerTable:
	dw .list_prize
	dw .list_arena
	dw .list_bench
	dw .list_play_from_hand
	dw .list_energy

AIActionTable_RunningWildDeck:
	dw .do_turn
	dw .do_turn
	dw .start_duel
	dw .forced_switch
	dw .ko_switch
	dw .take_prize
	dw .update_portrait

.do_turn
	farcall AIMainTurnLogic
	ret

.start_duel
	call InitAIDuelVars
	call .StoreListPointers
	farcall SetUpBossStartingHandAndDeck
	call TrySetUpBossStartingPlayArea
	ret nc
	call AIPlayInitialBasicCards
	ret

.forced_switch
	call Func_14178
	ret

.ko_switch
	call Func_14178
	ret

.take_prize
	call AIPickPrizeCards
	ret

.update_portrait
	farcall AIUpdatePortrait
	ret

.list_arena
	dw KANGASKHAN_LV40
	dw SCYTHER_LV25
	dw CUBONE_LV14
	dw MANKEY_LV14
	dw NULL ; end

.list_bench
.list_play_from_hand
	dw CUBONE_LV14
	dw MANKEY_LV14
	dw SCYTHER_LV25
	dw KANGASKHAN_LV40
	dw NULL ; end

; unreferenced
	ai_retreat MANKEY_LV14,   -1
	ai_retreat DARK_PRIMEAPE, +1
	ai_retreat CUBONE_LV14,   -1
	ai_retreat DARK_MAROWAK,  +1
	dw NULL ; end

.list_energy
	ai_energy SCYTHER_LV25,    3, +0
	ai_energy MANKEY_LV14,     2, +0
	ai_energy DARK_PRIMEAPE,   2, +1
	ai_energy CUBONE_LV14,     2, +0
	ai_energy DARK_MAROWAK,    2, +1
	ai_energy KANGASKHAN_LV40, 4, -5
	dw NULL ; end

.list_prize
	dw KANGASKHAN_LV40
	dw NULL ; end

.StoreListPointers:
	ld hl, .CardListPointerTable
	call StoreAICardListPointers
	ret

.CardListPointerTable:
	dw .list_prize
	dw .list_arena
	dw .list_bench
	dw .list_play_from_hand
	dw .list_energy

AIActionTable_SpiritedAwayDeck:
	dw .do_turn
	dw .do_turn
	dw .start_duel
	dw .forced_switch
	dw .ko_switch
	dw .take_prize
	dw .update_portrait

.do_turn
	farcall AIMainTurnLogic
	ret

.start_duel
	call InitAIDuelVars
	call .StoreListPointers
	farcall SetUpBossStartingHandAndDeck
	call TrySetUpBossStartingPlayArea
	ret nc
	call AIPlayInitialBasicCards
	ret

.forced_switch
	call Func_14178
	ret

.ko_switch
	call Func_14178
	ret

.take_prize
	call AIPickPrizeCards
	ret

.update_portrait
	farcall AIUpdatePortrait
	ret

.list_arena
	dw KANGASKHAN_LV40
	dw SLOWPOKE_LV16
	dw MR_MIME_LV28
	dw GASTLY_LV17
	dw NULL ; end

.list_bench
.list_play_from_hand
	dw GASTLY_LV17
	dw MR_MIME_LV28
	dw SLOWPOKE_LV16
	dw KANGASKHAN_LV40
	dw NULL ; end

; unreferenced
	ai_retreat GASTLY_LV17, -1
	dw NULL ; end

.list_energy
	ai_energy GASTLY_LV17,     2, +0
	ai_energy DARK_HAUNTER,    2, +0
	ai_energy DARK_GENGAR,     3, +0
	ai_energy SLOWPOKE_LV16,   1, +3
	ai_energy MR_MIME_LV28,    2, +0
	ai_energy KANGASKHAN_LV40, 4, -5
	dw NULL ; end

.list_prize
	dw SLOWPOKE_LV16
	dw NULL ; end

.StoreListPointers:
	ld hl, .CardListPointerTable
	call StoreAICardListPointers
	ret

.CardListPointerTable:
	dw .list_prize
	dw .list_arena
	dw .list_bench
	dw .list_play_from_hand
	dw .list_energy

AIActionTable_SnorlaxGuardDeck:
	dw .do_turn
	dw .do_turn
	dw .start_duel
	dw .forced_switch
	dw .ko_switch
	dw .take_prize
	dw .update_portrait

.do_turn
	farcall AIMainTurnLogic
	ret

.start_duel
	call InitAIDuelVars
	call .StoreListPointers
	farcall SetUpBossStartingHandAndDeck
	call TrySetUpBossStartingPlayArea
	ret nc
	call AIPlayInitialBasicCards
	ret

.forced_switch
	call Func_14178
	ret

.ko_switch
	call Func_14178
	ret

.take_prize
	call AIPickPrizeCards
	ret

.update_portrait
	farcall AIUpdatePortrait
	ret

.list_arena
	dw KANGASKHAN_LV40
	dw LICKITUNG_LV26
	dw CHANSEY_LV55
	dw SNORLAX_LV35
	dw NULL ; end

.list_bench
.list_play_from_hand
	dw SNORLAX_LV35
	dw LICKITUNG_LV26
	dw KANGASKHAN_LV40
	dw CHANSEY_LV55
	dw NULL ; end

; unreferenced
	ai_retreat SNORLAX_LV35, +1
	dw NULL ; end

.list_energy
	ai_energy LICKITUNG_LV26,  2, +0
	ai_energy CHANSEY_LV55,    4, +0
	ai_energy KANGASKHAN_LV40, 4, +0
	ai_energy SNORLAX_LV35,    4, +1
	dw NULL ; end

.list_prize
	dw SNORLAX_LV35
	dw NULL ; end

.StoreListPointers:
	ld hl, .CardListPointerTable
	call StoreAICardListPointers
	ret

.CardListPointerTable:
	dw .list_prize
	dw .list_arena
	dw .list_bench
	dw .list_play_from_hand
	dw .list_energy

AIActionTable_EyeOfTheStormDeck:
	dw .do_turn
	dw .do_turn
	dw .start_duel
	dw .forced_switch
	dw .ko_switch
	dw .take_prize
	dw .update_portrait

.do_turn
	farcall AIMainTurnLogic
	ret

.start_duel
	call InitAIDuelVars
	call .StoreListPointers
	farcall SetUpBossStartingHandAndDeck
	call TrySetUpBossStartingPlayArea
	ret nc
	call AIPlayInitialBasicCards
	ret

.forced_switch
	call Func_14178
	ret

.ko_switch
	call Func_14178
	ret

.take_prize
	call AIPickPrizeCards
	ret

.update_portrait
	farcall AIUpdatePortrait
	ret

.list_arena
	dw TAUROS_LV35
	dw PIDGEY_LV10
	dw SPEAROW_LV13
	dw FLYING_PIKACHU_LV12
	dw FLYING_PIKACHU_ALT_LV12
	dw NULL ; end

.list_bench
.list_play_from_hand
	dw PIDGEY_LV10
	dw SPEAROW_LV13
	dw TAUROS_LV35
	dw FLYING_PIKACHU_LV12
	dw FLYING_PIKACHU_ALT_LV12
	dw NULL ; end

; unreferenced
	ai_retreat PIDGEOTTO_LV38, +1
	ai_retreat PIDGEOT_LV40,   +1
	ai_retreat FEAROW_LV27,    +1
	dw NULL ; end

.list_energy
	ai_energy PIDGEY_LV10,             2, +0
	ai_energy PIDGEOTTO_LV38,          3, +0
	ai_energy PIDGEOT_LV40,            4, +1
	ai_energy SPEAROW_LV13,            3, +0
	ai_energy FEAROW_LV27,             4, +1
	ai_energy TAUROS_LV35,             2, +0
	ai_energy FLYING_PIKACHU_LV12,     3, +0
	ai_energy FLYING_PIKACHU_ALT_LV12, 3, +0
	dw NULL ; end

.list_prize
	dw GUST_OF_WIND
	dw NULL ; end

.StoreListPointers:
	ld hl, .CardListPointerTable
	call StoreAICardListPointers
	ret

.CardListPointerTable:
	dw .list_prize
	dw .list_arena
	dw .list_bench
	dw .list_play_from_hand
	dw .list_energy

AIActionTable_SuddenGrowthDeck:
	dw .do_turn
	dw .do_turn
	dw .start_duel
	dw .forced_switch
	dw .ko_switch
	dw .take_prize
	dw .update_portrait

.do_turn
	farcall AIMainTurnLogic
	ret

.start_duel
	call InitAIDuelVars
	call .StoreListPointers
	farcall SetUpBossStartingHandAndDeck
	call TrySetUpBossStartingPlayArea
	ret nc
	call AIPlayInitialBasicCards
	ret

.forced_switch
	call Func_14178
	ret

.ko_switch
	call Func_14178
	ret

.take_prize
	call AIPickPrizeCards
	ret

.update_portrait
	farcall AIUpdatePortrait
	ret

.list_arena
	dw ONIX_LV25
	dw HITMONCHAN_LV23
	dw JIGGLYPUFF_LV13
	dw CLEFAIRY_LV15
	dw DRATINI_LV12
	dw NULL ; end

.list_bench
.list_play_from_hand
	dw DRATINI_LV12
	dw CLEFAIRY_LV15
	dw HITMONCHAN_LV23
	dw ONIX_LV25
	dw JIGGLYPUFF_LV13
	dw NULL ; end

; unreferenced
	ai_retreat DRATINI_LV12,    -5
	ai_retreat DARK_DRAGONAIR,  -3
	ai_retreat CLEFAIRY_LV15,   -5
	ai_retreat JIGGLYPUFF_LV13, -5
	dw NULL ; end

.list_energy
	ai_energy ONIX_LV25,       1, +0
	ai_energy HITMONCHAN_LV23, 1, +0
	ai_energy CLEFAIRY_LV15,   3, +1
	ai_energy DARK_CLEFABLE,   4, +0
	ai_energy JIGGLYPUFF_LV13, 1, +0
	ai_energy DRATINI_LV12,    3, +1
	ai_energy DARK_DRAGONAIR,  4, +0
	ai_energy DARK_DRAGONITE,  5, +0
	dw NULL ; end

.list_prize
	dw GUST_OF_WIND
	dw NULL ; end

.StoreListPointers:
	ld hl, .CardListPointerTable
	call StoreAICardListPointers
	ret

.CardListPointerTable:
	dw .list_prize
	dw .list_arena
	dw .list_bench
	dw .list_play_from_hand
	dw .list_energy

AIActionTable_VeryRareCardDeck:
	dw .do_turn
	dw .do_turn
	dw .start_duel
	dw .forced_switch
	dw .ko_switch
	dw .take_prize
	dw .update_portrait

.do_turn
	farcall AIMainTurnLogic
	ret

.start_duel
	call InitAIDuelVars
	call .StoreListPointers
	farcall SetUpBossStartingHandAndDeck
	call AIPlayInitialBasicCards
	ret

.forced_switch
	call Func_14178
	ret

.ko_switch
	call Func_14178
	ret

.take_prize
	call AIPickPrizeCards
	ret

.update_portrait
	farcall AIUpdatePortrait
	ret

.list_energy
	ai_energy MAGIKARP_LV10,            2, +0
	ai_energy GYARADOS,                 4, +0
	ai_energy MARILL,                   3, +0
	ai_energy SURFING_PIKACHU_LV13,     2, +0
	ai_energy SURFING_PIKACHU_ALT_LV13, 2, +0
	ai_energy ELECTABUZZ_LV20,          2, +0
	ai_energy JIGGLYPUFF_LV12,          1, +0
	ai_energy MEOWTH_LV14,              1, +0
	ai_energy DARK_PERSIAN_ALT_LV28,    2, +0
	ai_energy FARFETCHD_ALT_LV20,       3, +0
	ai_energy KANGASKHAN_LV38,          3, +0
	ai_energy COOL_PORYGON,             3, +0
	dw NULL ; end

.list_prize
	dw SURFING_PIKACHU_LV13
	dw SURFING_PIKACHU_ALT_LV13
	dw NULL ; end

.StoreListPointers:
	ld hl, wAICardListAvoidPrize
	ld de, .list_prize
	ld [hl], e
	inc hl
	ld [hl], d
	ld hl, wAICardListEnergyBonus
	ld de, .list_energy
	ld [hl], e
	inc hl
	ld [hl], d
	ret

AIActionTable_BadGuysDeck:
	dw .do_turn
	dw .do_turn
	dw .start_duel
	dw .forced_switch
	dw .ko_switch
	dw .take_prize
	dw .update_portrait

.do_turn
	farcall AIMainTurnLogic
	ret

.start_duel
	call InitAIDuelVars
	call .StoreListPointers
	farcall SetUpBossStartingHandAndDeck
	call TrySetUpBossStartingPlayArea
	ret nc
	call AIPlayInitialBasicCards
	ret

.forced_switch
	call Func_14178
	ret

.ko_switch
	call Func_14178
	ret

.take_prize
	call AIPickPrizeCards
	ret

.update_portrait
	farcall AIUpdatePortrait
	ret

.list_arena
	dw ODDISH_LV21
	dw SLOWPOKE_LV16
	dw CHARMANDER_LV9
	dw PSYDUCK_LV16
	dw NULL ; end

.list_bench
.list_play_from_hand
	dw ODDISH_LV21
	dw PSYDUCK_LV16
	dw CHARMANDER_LV9
	dw SLOWPOKE_LV16
	dw NULL ; end

; unreferenced
	ai_retreat CHARMANDER_LV9, -1
	ai_retreat PSYDUCK_LV16,   -3
	ai_retreat DARK_GOLDUCK,   +2
	dw NULL ; end

.list_energy
	ai_energy ODDISH_LV21,     1, +1
	ai_energy DARK_GLOOM,      2, -1
	ai_energy CHARMANDER_LV9,  1, +1
	ai_energy DARK_CHARMELEON, 3, +0
	ai_energy PSYDUCK_LV16,    1, +1
	ai_energy DARK_GOLDUCK,    3, +1
	ai_energy SLOWPOKE_LV16,   1, +0
	ai_energy DARK_SLOWBRO,    2, -1
	dw NULL ; end

.list_prize
	dw PSYDUCK_LV16
	dw DARK_GOLDUCK
	dw NULL ; end

.StoreListPointers:
	ld hl, .CardListPointerTable
	call StoreAICardListPointers
	ret

.CardListPointerTable:
	dw .list_prize
	dw .list_arena
	dw .list_bench
	dw .list_play_from_hand
	dw .list_energy

AIActionTable_PoisonMistDeck:
	dw .do_turn
	dw .do_turn
	dw .start_duel
	dw .forced_switch
	dw .ko_switch
	dw .take_prize
	dw .update_portrait

.do_turn
	farcall AIMainTurnLogic
	ret

.start_duel
	call InitAIDuelVars
	call .StoreListPointers
	farcall SetUpBossStartingHandAndDeck
	call TrySetUpBossStartingPlayArea
	ret nc
	call AIPlayInitialBasicCards
	ret

.forced_switch
	call Func_14178
	ret

.ko_switch
	call Func_14178
	ret

.take_prize
	call AIPickPrizeCards
	ret

.update_portrait
	farcall AIUpdatePortrait
	ret

.list_arena
	dw GRIMER_LV10
	dw SCYTHER_LV25
	dw KOFFING_LV14
	dw MR_MIME_LV20
	dw NULL ; end

.list_bench
.list_play_from_hand
	dw KOFFING_LV14
	dw GRIMER_LV10
	dw SCYTHER_LV25
	dw MR_MIME_LV20
	dw NULL ; end

; unreferenced
	ai_retreat MR_MIME_LV20, -28
	ai_retreat KOFFING_LV14,  -2
	ai_retreat WEEZING_LV26,  -5
	dw NULL ; end

.list_energy
	ai_energy SCYTHER_LV25, 3, +0
	ai_energy GRIMER_LV10,  2, +0
	ai_energy DARK_MUK,     2, +0
	ai_energy KOFFING_LV14, 2, +0
	ai_energy WEEZING_LV26, 3, -1
	ai_energy MR_MIME_LV20, 2, +0
	dw NULL ; end

.list_prize
	dw MR_MIME_LV20
	dw WEEZING_LV26
	dw NULL ; end

.StoreListPointers:
	ld hl, .CardListPointerTable
	call StoreAICardListPointers
	ret

.CardListPointerTable:
	dw .list_prize
	dw .list_arena
	dw .list_bench
	dw .list_play_from_hand
	dw .list_energy

AIActionTable_UltraRemovalDeck:
	dw .do_turn
	dw .do_turn
	dw .start_duel
	dw .forced_switch
	dw .ko_switch
	dw .take_prize
	dw .update_portrait

.do_turn
	farcall AIMainTurnLogic
	ret

.start_duel
	call InitAIDuelVars
	call .StoreListPointers
	farcall SetUpBossStartingHandAndDeck
	call TrySetUpBossStartingPlayArea
	ret nc
	call AIPlayInitialBasicCards
	ret

.forced_switch
	call Func_14178
	ret

.ko_switch
	call Func_14178
	ret

.take_prize
	call AIPickPrizeCards
	ret

.update_portrait
	farcall AIUpdatePortrait
	ret

.list_arena
	dw SQUIRTLE_LV8
	dw PSYDUCK_LV15
	dw NULL ; end

.list_bench
.list_play_from_hand
	dw PSYDUCK_LV15
	dw SQUIRTLE_LV8
	dw NULL ; end

; unreferenced
	ai_retreat PSYDUCK_LV15, -2
	dw NULL ; end

.list_energy
	ai_energy SQUIRTLE_LV8,   2, +0
	ai_energy WARTORTLE_LV22, 3, +0
	ai_energy BLASTOISE_LV52, 5, +0
	ai_energy PSYDUCK_LV15,   2, +1
	ai_energy GOLDUCK_LV27,   3, +1
	dw NULL ; end

.list_prize
	dw ENERGY_REMOVAL
	dw SUPER_ENERGY_REMOVAL
	dw NULL ; end

.StoreListPointers:
	ld hl, .CardListPointerTable
	call StoreAICardListPointers
	ret

.CardListPointerTable:
	dw .list_prize
	dw .list_arena
	dw .list_bench
	dw .list_play_from_hand
	dw .list_energy

AIActionTable_PsychicBattleDeck:
	dw .do_turn
	dw .do_turn
	dw .start_duel
	dw .forced_switch
	dw .ko_switch
	dw .take_prize
	dw .update_portrait

.do_turn
	farcall AIMainTurnLogic
	ret

.start_duel
	call InitAIDuelVars
	call .StoreListPointers
	farcall SetUpBossStartingHandAndDeck
	call TrySetUpBossStartingPlayArea
	ret nc
	call AIPlayInitialBasicCards
	ret

.forced_switch
	call Func_14178
	ret

.ko_switch
	call Func_14178
	ret

.take_prize
	call AIPickPrizeCards
	ret

.update_portrait
	farcall AIUpdatePortrait
	ret

.list_arena
	dw HITMONCHAN_LV33
	dw SANDSHREW_LV12
	dw MR_MIME_LV28
	dw MEWTWO_LV53
	dw NULL ; end

.list_bench
.list_play_from_hand
	dw SANDSHREW_LV12
	dw HITMONCHAN_LV33
	dw MEWTWO_LV53
	dw MR_MIME_LV28
	dw NULL ; end

; unreferenced
	ai_retreat SANDSHREW_LV12, -1
	dw NULL ; end

.list_energy
	ai_energy MR_MIME_LV28,    2, +0
	ai_energy MEWTWO_LV53,     2, +0
	ai_energy SANDSHREW_LV12,  1, +0
	ai_energy SANDSLASH_LV33,  4, +0
	ai_energy HITMONCHAN_LV33, 3, +0
	dw NULL ; end

.list_prize
	dw SWITCH
	dw GUST_OF_WIND
	dw NULL ; end

.StoreListPointers:
	ld hl, .CardListPointerTable
	call StoreAICardListPointers
	ret

.CardListPointerTable:
	dw .list_prize
	dw .list_arena
	dw .list_bench
	dw .list_play_from_hand
	dw .list_energy

AIActionTable_StopLifeDeck:
	dw .do_turn
	dw .do_turn
	dw .start_duel
	dw .forced_switch
	dw .ko_switch
	dw .take_prize
	dw .update_portrait

.do_turn
	farcall AIMainTurnLogic
	ret

.start_duel
	call InitAIDuelVars
	call .StoreListPointers
	farcall SetUpBossStartingHandAndDeck
	call TrySetUpBossStartingPlayArea
	ret nc
	call AIPlayInitialBasicCards
	ret

.forced_switch
	call Func_14178
	ret

.ko_switch
	call Func_14178
	ret

.take_prize
	call AIPickPrizeCards
	ret

.update_portrait
	farcall AIUpdatePortrait
	ret

.list_arena
	dw KANGASKHAN_LV40
	dw SCYTHER_LV25
	dw BULBASAUR_LV12
	dw DRATINI_LV10
	dw MR_MIME_LV20
	dw NULL ; end

.list_bench
.list_play_from_hand
	dw BULBASAUR_LV12
	dw DRATINI_LV10
	dw SCYTHER_LV25
	dw KANGASKHAN_LV40
	dw NULL ; end

; unreferenced
	ai_retreat BULBASAUR_LV12,  -5
	ai_retreat DARK_IVYSAUR,    -5
	ai_retreat DARK_VENUSAUR,   -3
	ai_retreat DRATINI_LV10,    -3
	ai_retreat DARK_DRAGONAIR,  -3
	ai_retreat MR_MIME_LV20,   -28
	dw NULL ; end

.list_energy
	ai_energy BULBASAUR_LV12,  2,  +0
	ai_energy DARK_IVYSAUR,    2,  +0
	ai_energy DARK_VENUSAUR,   3,  +0
	ai_energy DRATINI_LV10,    2,  +0
	ai_energy DARK_DRAGONAIR,  3,  -3
	ai_energy SCYTHER_LV25,    3,  +0
	ai_energy KANGASKHAN_LV40, 4,  -5
	ai_energy MR_MIME_LV20,    0, -28
	dw NULL ; end

.list_prize
	dw MR_MIME_LV20
	dw NULL ; end

.StoreListPointers:
	ld hl, .CardListPointerTable
	call StoreAICardListPointers
	ret

.CardListPointerTable:
	dw .list_prize
	dw .list_arena
	dw .list_bench
	dw .list_play_from_hand
	dw .list_energy

AIActionTable_ScorcherDeck:
	dw .do_turn
	dw .do_turn
	dw .start_duel
	dw .forced_switch
	dw .ko_switch
	dw .take_prize
	dw .update_portrait

.do_turn
	farcall AIMainTurnLogic
	ret

.start_duel
	call InitAIDuelVars
	call .StoreListPointers
	farcall SetUpBossStartingHandAndDeck
	call TrySetUpBossStartingPlayArea
	ret nc
	call AIPlayInitialBasicCards
	ret

.forced_switch
	call Func_14178
	ret

.ko_switch
	call Func_14178
	ret

.take_prize
	call AIPickPrizeCards
	ret

.update_portrait
	farcall AIUpdatePortrait
	ret

.list_arena
	dw KANGASKHAN_LV40
	dw MAGMAR_LV31
	dw CHARMANDER_LV9
	dw CLEFAIRY_LV15
	dw MR_MIME_LV20
	dw NULL ; end

.list_bench
.list_play_from_hand
	dw CHARMANDER_LV9
	dw CLEFAIRY_LV15
	dw MAGMAR_LV31
	dw KANGASKHAN_LV40
	dw NULL ; end

; unreferenced
	ai_retreat CHARMANDER_LV9,   -3
	ai_retreat DARK_CHARMELEON,  -3
	ai_retreat CLEFAIRY_LV15,    -5
	ai_retreat DARK_CLEFABLE,    -3
	ai_retreat MR_MIME_LV20,    -28
	dw NULL ; end

.list_energy
	ai_energy CHARMANDER_LV9,  1,  +1
	ai_energy DARK_CHARMELEON, 3,  +1
	ai_energy DARK_CHARIZARD,  5,  +2
	ai_energy CLEFAIRY_LV15,   2,  -2
	ai_energy DARK_CLEFABLE,   3,  -2
	ai_energy MAGMAR_LV31,     2,  +0
	ai_energy KANGASKHAN_LV40, 4,  -5
	ai_energy MR_MIME_LV20,    0, -28
	dw NULL ; end

.list_prize
	dw MR_MIME_LV20
	dw NULL ; end

.StoreListPointers:
	ld hl, .CardListPointerTable
	call StoreAICardListPointers
	ret

.CardListPointerTable:
	dw .list_prize
	dw .list_arena
	dw .list_bench
	dw .list_play_from_hand
	dw .list_energy

AIActionTable_TsunamiStarterDeck:
	dw .do_turn
	dw .do_turn
	dw .start_duel
	dw .forced_switch
	dw .ko_switch
	dw .take_prize
	dw .update_portrait

.do_turn
	farcall AIMainTurnLogic
	ret

.start_duel
	call InitAIDuelVars
	call .StoreListPointers
	farcall SetUpBossStartingHandAndDeck
	call TrySetUpBossStartingPlayArea
	ret nc
	call AIPlayInitialBasicCards
	ret

.forced_switch
	call Func_14178
	ret

.ko_switch
	call Func_14178
	ret

.take_prize
	call AIPickPrizeCards
	ret

.update_portrait
	farcall AIUpdatePortrait
	ret

.list_arena
	dw LAPRAS_LV31
	dw SCYTHER_LV25
	dw SQUIRTLE_LV8
	dw CLEFAIRY_LV15
	dw MR_MIME_LV20
	dw NULL ; end

.list_bench
.list_play_from_hand
	dw SQUIRTLE_LV8
	dw CLEFAIRY_LV15
	dw LAPRAS_LV31
	dw SCYTHER_LV25
	dw NULL ; end

; unreferenced
	ai_retreat SQUIRTLE_LV8,    -3
	ai_retreat DARK_WARTORTLE,  -3
	ai_retreat CLEFAIRY_LV15,   -5
	ai_retreat DARK_CLEFABLE,   -3
	ai_retreat MR_MIME_LV20,   -28
	dw NULL ; end

.list_energy
	ai_energy SQUIRTLE_LV8,   2,  +1
	ai_energy DARK_WARTORTLE, 2,  +1
	ai_energy DARK_BLASTOISE, 4,  +2
	ai_energy CLEFAIRY_LV15,  2,  -2
	ai_energy DARK_CLEFABLE,  3,  -2
	ai_energy LAPRAS_LV31,    3,  +0
	ai_energy SCYTHER_LV25,   3,  -8
	ai_energy MR_MIME_LV20,   0, -28
	dw NULL ; end

.list_prize
	dw MR_MIME_LV20
	dw NULL ; end

.StoreListPointers:
	ld hl, .CardListPointerTable
	call StoreAICardListPointers
	ret

.CardListPointerTable:
	dw .list_prize
	dw .list_arena
	dw .list_bench
	dw .list_play_from_hand
	dw .list_energy

AIActionTable_SmashToMincemeatDeck:
	dw .do_turn
	dw .do_turn
	dw .start_duel
	dw .forced_switch
	dw .ko_switch
	dw .take_prize
	dw .update_portrait

.do_turn
	farcall AIMainTurnLogic
	ret

.start_duel
	call InitAIDuelVars
	call .StoreListPointers
	farcall SetUpBossStartingHandAndDeck
	call TrySetUpBossStartingPlayArea
	ret nc
	call AIPlayInitialBasicCards
	ret

.forced_switch
	call Func_14178
	ret

.ko_switch
	call Func_14178
	ret

.take_prize
	call AIPickPrizeCards
	ret

.update_portrait
	farcall AIUpdatePortrait
	ret

.list_arena
	dw KANGASKHAN_LV40
	dw CHANSEY_LV55
	dw MACHOP_LV20
	dw CLEFAIRY_LV15
	dw MR_MIME_LV20
	dw NULL ; end

.list_bench
.list_play_from_hand
	dw MACHOP_LV20
	dw CLEFAIRY_LV15
	dw CHANSEY_LV55
	dw KANGASKHAN_LV40
	dw NULL ; end

; unreferenced
	ai_retreat MACHOP_LV20,    -3
	ai_retreat DARK_MACHOKE,   -3
	ai_retreat DARK_MACHAMP,   -2
	ai_retreat CLEFAIRY_LV15,  -5
	ai_retreat DARK_CLEFABLE,  -3
	ai_retreat CHANSEY_LV55,   -5
	ai_retreat MR_MIME_LV20,  -28
	dw NULL ; end

.list_energy
	ai_energy MACHOP_LV20,     2,  +1
	ai_energy DARK_MACHOKE,    3,  +1
	ai_energy DARK_MACHAMP,    4,  +2
	ai_energy CLEFAIRY_LV15,   2,  -2
	ai_energy DARK_CLEFABLE,   3,  -2
	ai_energy KANGASKHAN_LV40, 4,  -5
	ai_energy CHANSEY_LV55,    4,  -4
	ai_energy MR_MIME_LV20,    0, -28
	dw NULL ; end

.list_prize
	dw MR_MIME_LV20
	dw NULL ; end

.StoreListPointers:
	ld hl, .CardListPointerTable
	call StoreAICardListPointers
	ret

.CardListPointerTable:
	dw .list_prize
	dw .list_arena
	dw .list_bench
	dw .list_play_from_hand
	dw .list_energy

AIActionTable_TextureTuner7Deck:
	dw .do_turn
	dw .do_turn
	dw .start_duel
	dw .forced_switch
	dw .ko_switch
	dw .take_prize
	dw .update_portrait

.do_turn
	farcall AIMainTurnLogic
	ret

.start_duel
	call InitAIDuelVars
	call .StoreListPointers
	farcall SetUpBossStartingHandAndDeck
	call TrySetUpBossStartingPlayArea
	ret nc
	call AIPlayInitialBasicCards
	ret

.forced_switch
	call Func_14178
	ret

.ko_switch
	call Func_14178
	ret

.take_prize
	call AIPickPrizeCards
	ret

.update_portrait
	farcall AIUpdatePortrait
	ret

.list_arena
	dw PORYGON_LV18
	dw PORYGON_LV12
	dw COOL_PORYGON
	dw SCYTHER_LV25
	dw VENONAT_LV12
	dw ZUBAT_LV12
	dw NULL ; end

.list_bench
.list_play_from_hand
	dw COOL_PORYGON
	dw PORYGON_LV18
	dw PORYGON_LV12
	dw ZUBAT_LV12
	dw VENONAT_LV12
	dw SCYTHER_LV25
	dw NULL ; end

; unreferenced
	ai_retreat ZUBAT_LV12,   -1
	ai_retreat VENONAT_LV12, -1
	dw NULL ; end

.list_energy
	ai_energy ZUBAT_LV12,    2, +0
	ai_energy GOLBAT_LV29,   3, +0
	ai_energy VENONAT_LV12,  2, +0
	ai_energy VENOMOTH_LV22, 3, +0
	ai_energy SCYTHER_LV25,  3, +0
	ai_energy PORYGON_LV12,  2, +0
	ai_energy PORYGON_LV18,  2, +0
	ai_energy COOL_PORYGON,  3, +0
	dw NULL ; end

.list_prize
	dw PORYGON_LV12
	dw PORYGON_LV18
	dw COOL_PORYGON
	dw NULL ; end

.StoreListPointers:
	ld hl, .CardListPointerTable
	call StoreAICardListPointers
	ret

.CardListPointerTable:
	dw .list_prize
	dw .list_arena
	dw .list_bench
	dw .list_play_from_hand
	dw .list_energy

AIActionTable_ColorlessEnergyDeck:
	dw .do_turn
	dw .do_turn
	dw .start_duel
	dw .forced_switch
	dw .ko_switch
	dw .take_prize
	dw .update_portrait

.do_turn
	farcall AIMainTurnLogic
	ret

.start_duel
	call InitAIDuelVars
	call .StoreListPointers
	farcall SetUpBossStartingHandAndDeck
	call TrySetUpBossStartingPlayArea
	ret nc
	call AIPlayInitialBasicCards
	ret

.forced_switch
	call Func_14178
	ret

.ko_switch
	call Func_14178
	ret

.take_prize
	call AIPickPrizeCards
	ret

.update_portrait
	farcall AIUpdatePortrait
	ret

.list_arena
	dw SPEAROW_LV9
	dw SPEAROW_LV13
	dw SPEAROW_LV12
	dw DRATINI_LV10
	dw EEVEE_LV12
	dw NULL ; end

.list_bench
.list_play_from_hand
	dw EEVEE_LV12
	dw DRATINI_LV10
	dw SPEAROW_LV9
	dw SPEAROW_LV13
	dw SPEAROW_LV12
	dw NULL ; end

; unreferenced
	ai_retreat EEVEE_LV12,     -1
	ai_retreat DRATINI_LV10,   -1
	ai_retreat DRAGONITE_LV45, -8
	dw NULL ; end

.list_energy
	ai_energy FLAREON_LV22,   3, +0
	ai_energy DARK_VAPOREON,  4, +0
	ai_energy JOLTEON_LV24,   4, +0
	ai_energy SPEAROW_LV9,    2, +0
	ai_energy SPEAROW_LV12,   1, +0
	ai_energy SPEAROW_LV13,   3, +0
	ai_energy FEAROW_LV24,    3, +0
	ai_energy FEAROW_LV27,    4, +0
	ai_energy EEVEE_LV12,     2, +0
	ai_energy DRATINI_LV10,   2, +0
	ai_energy DRAGONAIR,      4, +0
	ai_energy DRAGONITE_LV43, 3, +0
	ai_energy DRAGONITE_LV45, 4, +0
	dw NULL ; end

.list_prize
	dw EEVEE_LV12
	dw NULL ; end

.StoreListPointers:
	ld hl, .CardListPointerTable
	call StoreAICardListPointers
	ret

.CardListPointerTable:
	dw .list_prize
	dw .list_arena
	dw .list_bench
	dw .list_play_from_hand
	dw .list_energy

AIActionTable_PowerfulPokemonDeck:
	dw .do_turn
	dw .do_turn
	dw .start_duel
	dw .forced_switch
	dw .ko_switch
	dw .take_prize
	dw .update_portrait

.do_turn
	farcall AIMainTurnLogic
	ret

.start_duel
	call InitAIDuelVars
	call .StoreListPointers
	farcall SetUpBossStartingHandAndDeck
	call TrySetUpStartingPlayArea_PowerfulPokemonDeck
	ret nc
	call AIPlayInitialBasicCards
	ret

.forced_switch
	call Func_14178
	ret

.ko_switch
	call Func_14178
	ret

.take_prize
	call AIPickPrizeCards
	ret

.update_portrait
	farcall AIUpdatePortrait
	ret

.list_arena
	dw MAGMAR_LV31
	dw JYNX_LV27
	dw ELECTABUZZ_LV35
	dw LAPRAS_LV31
	dw HITMONCHAN_LV33
	dw NULL ; end

.list_bench
.list_play_from_hand
	dw MAGMAR_LV31
	dw JYNX_LV27
	dw ELECTABUZZ_LV35
	dw LAPRAS_LV31
	dw HITMONCHAN_LV33
	dw NULL ; end

; unreferenced
	ai_retreat MAGMAR_LV31, +0
	dw NULL ; end

.list_energy
	ai_energy MAGMAR_LV31,     2, +0
	ai_energy LAPRAS_LV31,     2, +0
	ai_energy ELECTABUZZ_LV35, 2, +0
	ai_energy HITMONCHAN_LV33, 1, +0
	ai_energy JYNX_LV27,       2, +0
	dw NULL ; end

.list_prize
	dw SWITCH
	dw NULL ; end

.StoreListPointers:
	ld hl, .CardListPointerTable
	call StoreAICardListPointers
	ret

.CardListPointerTable:
	dw .list_prize
	dw .list_arena
	dw .list_bench
	dw .list_play_from_hand
	dw .list_energy

AIActionTable_RonaldsPsychicDeck:
	dw .do_turn
	dw .do_turn
	dw .start_duel
	dw .forced_switch
	dw .ko_switch
	dw .take_prize
	dw .update_portrait

.do_turn
	farcall AIMainTurnLogic
	ret

.start_duel
	call InitAIDuelVars
	call .StoreListPointers
	farcall SetUpBossStartingHandAndDeck
	call TrySetUpBossStartingPlayArea
	ret nc
	call AIPlayInitialBasicCards
	ret

.forced_switch
	call Func_14178
	ret

.ko_switch
	call Func_14178
	ret

.take_prize
	call AIPickPrizeCards
	ret

.update_portrait
	farcall AIUpdatePortrait
	ret

.list_arena
	dw KANGASKHAN_LV40
	dw DRATINI_LV10
	dw GASTLY_LV13
	dw MEWTWO_LV67
	dw MEW_LV23
	dw NULL ; end

.list_bench
.list_play_from_hand
	dw DRATINI_LV10
	dw GASTLY_LV13
	dw MEW_LV23
	dw MEWTWO_LV67
	dw KANGASKHAN_LV40
	dw NULL ; end

; unreferenced
	ai_retreat DARK_DRAGONAIR, -2
	dw NULL ; end

.list_energy
	ai_energy GASTLY_LV13,     2, +0
	ai_energy HAUNTER_LV26,    2, +0
	ai_energy GENGAR_LV40,     3, +0
	ai_energy MEWTWO_LV67,     3, +0
	ai_energy MEW_LV23,        2, +0
	ai_energy KANGASKHAN_LV40, 4, +0
	ai_energy DRATINI_LV10,    2, +0
	ai_energy DARK_DRAGONAIR,  3, +0
	ai_energy DARK_DRAGONITE,  4, +0
	dw NULL ; end

.list_prize
	dw GENGAR_LV40
	dw MEW_LV23
	dw NULL ; end

.StoreListPointers:
	ld hl, .CardListPointerTable
	call StoreAICardListPointers
	ret

.CardListPointerTable:
	dw .list_prize
	dw .list_arena
	dw .list_bench
	dw .list_play_from_hand
	dw .list_energy

AIActionTable_RonaldsUltraDeck:
	dw .do_turn
	dw .do_turn
	dw .start_duel
	dw .forced_switch
	dw .ko_switch
	dw .take_prize
	dw .update_portrait

.do_turn
	farcall AIMainTurnLogic
	ret

.start_duel
	call InitAIDuelVars
	call .StoreListPointers
	farcall SetUpBossStartingHandAndDeck
	call TrySetUpBossStartingPlayArea
	ret nc
	call AIPlayInitialBasicCards
	ret

.forced_switch
	call Func_14178
	ret

.ko_switch
	call Func_14178
	ret

.take_prize
	call AIPickPrizeCards
	ret

.update_portrait
	farcall AIUpdatePortrait
	ret

.list_arena
	dw SPEAROW_LV13
	dw FARFETCHD_LV20
	dw PIDGEY_LV10
	dw NULL ; end

.list_bench
.list_play_from_hand
	dw SPEAROW_LV13
	dw PIDGEY_LV10
	dw FARFETCHD_LV20
	dw NULL ; end

; unreferenced
	ai_retreat PIDGEY_LV10, -1
	dw NULL ; end

.list_energy
	ai_energy PIDGEY_LV10,    2, +0
	ai_energy PIDGEOTTO_LV38, 2, +0
	ai_energy PIDGEOT_LV40,   3, +1
	ai_energy SPEAROW_LV13,   3, +0
	ai_energy FEAROW_LV27,    4, +0
	ai_energy FARFETCHD_LV20, 3, +0
	dw NULL ; end

.list_prize
	dw PIDGEOTTO_LV38
	dw PIDGEOT_LV40
	dw NULL ; end

.StoreListPointers:
	ld hl, .CardListPointerTable
	call StoreAICardListPointers
	ret

.CardListPointerTable:
	dw .list_prize
	dw .list_arena
	dw .list_bench
	dw .list_play_from_hand
	dw .list_energy

AIActionTable_EverybodysFriendDeck:
	dw .do_turn
	dw .do_turn
	dw .start_duel
	dw .forced_switch
	dw .ko_switch
	dw .take_prize
	dw .update_portrait

.do_turn
	farcall AIMainTurnLogic
	ret

.start_duel
	call InitAIDuelVars
	call .StoreListPointers
	farcall SetUpBossStartingHandAndDeck
	call TrySetUpBossStartingPlayArea
	ret nc
	call AIPlayInitialBasicCards
	ret

.forced_switch
	call Func_14178
	ret

.ko_switch
	call Func_14178
	ret

.take_prize
	call AIPickPrizeCards
	ret

.update_portrait
	farcall AIUpdatePortrait
	ret

.list_arena
	dw MAGMAR_LV31
	dw HITMONCHAN_LV33
	dw SCYTHER_LV25
	dw JIGGLYPUFF_LV14
	dw NULL ; end

.list_bench
.list_play_from_hand
	dw JIGGLYPUFF_LV14
	dw SCYTHER_LV25
	dw MAGMAR_LV31
	dw HITMONCHAN_LV33
	dw NULL ; end

; unreferenced
	ai_retreat JIGGLYPUFF_LV14, -8
	ai_retreat WIGGLYTUFF_LV36, -2
	dw NULL ; end

.list_energy
	ai_energy JIGGLYPUFF_LV14, 3, +1
	ai_energy WIGGLYTUFF_LV36, 3, +2
	ai_energy SCYTHER_LV25,    3, +0
	ai_energy MAGMAR_LV31,     2, +0
	ai_energy HITMONCHAN_LV33, 3, +0
	dw NULL ; end

.list_prize
	dw JIGGLYPUFF_LV14
	dw WIGGLYTUFF_LV36
	dw NULL ; end

.StoreListPointers:
	ld hl, .CardListPointerTable
	call StoreAICardListPointers
	ret

.CardListPointerTable:
	dw .list_prize
	dw .list_arena
	dw .list_bench
	dw .list_play_from_hand
	dw .list_energy

AIActionTable_ImmortalPokemonDeck:
	dw .do_turn
	dw .do_turn
	dw .start_duel
	dw .forced_switch
	dw .ko_switch
	dw .take_prize
	dw .update_portrait

.do_turn
	farcall AIMainTurnLogic
	ret

.start_duel
	call InitAIDuelVars
	call .StoreListPointers
	farcall SetUpBossStartingHandAndDeck
	call TrySetUpBossStartingPlayArea
	ret nc
	call AIPlayInitialBasicCards
	ret

.forced_switch
	call Func_14178
	ret

.ko_switch
	call Func_14178
	ret

.take_prize
	call AIPickPrizeCards
	ret

.update_portrait
	farcall AIUpdatePortrait
	ret

.list_arena
	dw SCYTHER_LV25
	dw CHANSEY_LV55
	dw MR_MIME_LV28
	dw TENTACOOL
	dw ABRA_LV14
	dw MR_MIME_LV20
	dw NULL ; end

.list_bench
	dw ABRA_LV14
	dw MR_MIME_LV28
	dw SCYTHER_LV25
	dw CHANSEY_LV55
	dw NULL ; end

.list_play_from_hand
	dw MR_MIME_LV20
	dw ABRA_LV14
	dw MR_MIME_LV28
	dw SCYTHER_LV25
	dw CHANSEY_LV55
	dw TENTACOOL
	dw NULL ; end

; unreferenced
	ai_retreat MR_MIME_LV20,  -28
	ai_retreat TENTACOOL,     -28
	ai_retreat ALAKAZAM_LV42, -28
	ai_retreat ABRA_LV14,      -8
	ai_retreat CHANSEY_LV55,   -8
	dw NULL ; end

.list_energy
	ai_energy ABRA_LV14,     1,  +1
	ai_energy KADABRA_LV39,  3,  +1
	ai_energy ALAKAZAM_LV42, 3,  +0
	ai_energy MR_MIME_LV28,  2,  +1
	ai_energy MR_MIME_LV20,  2,  -8
	ai_energy TENTACOOL,     0, -28
	ai_energy SCYTHER_LV25,  3,  -8
	ai_energy CHANSEY_LV55,  4,  +0
	dw NULL ; end

.list_prize
	dw MR_MIME_LV20
	dw NULL ; end

.StoreListPointers:
	ld hl, .CardListPointerTable
	call StoreAICardListPointers
	ret

.CardListPointerTable:
	dw .list_prize
	dw .list_arena
	dw .list_bench
	dw .list_play_from_hand
	dw .list_energy

AIActionTable_TorrentialFloodDeck:
	dw .do_turn
	dw .do_turn
	dw .start_duel
	dw .forced_switch
	dw .ko_switch
	dw .take_prize
	dw .update_portrait

.do_turn
	farcall AIMainTurnLogic
	ret

.start_duel
	call InitAIDuelVars
	call .StoreListPointers
	farcall SetUpBossStartingHandAndDeck
	call TrySetUpBossStartingPlayArea
	ret nc
	call AIPlayInitialBasicCards
	ret

.forced_switch
	call Func_14178
	ret

.ko_switch
	call Func_14178
	ret

.take_prize
	call AIPickPrizeCards
	ret

.update_portrait
	farcall AIUpdatePortrait
	ret

.list_arena
	dw LAPRAS_LV31
	dw ARTICUNO_LV35
	dw SQUIRTLE_LV14
	dw ARTICUNO_LV37
	dw NULL ; end

.list_bench
	dw SQUIRTLE_LV14
	dw LAPRAS_LV31
	dw ARTICUNO_LV35
	dw NULL ; end

.list_play_from_hand
	dw SQUIRTLE_LV14
	dw LAPRAS_LV31
	dw ARTICUNO_LV37
	dw ARTICUNO_LV35
	dw NULL ; end

; unreferenced
	ai_retreat SQUIRTLE_LV14,  -5
	ai_retreat WARTORTLE_LV24, -3
	dw NULL ; end

.list_energy
	ai_energy SQUIRTLE_LV14,  2, +0
	ai_energy WARTORTLE_LV24, 2, +0
	ai_energy BLASTOISE_LV52, 5, +0
	ai_energy ARTICUNO_LV35,  4, +0
	ai_energy ARTICUNO_LV37,  3, +0
	ai_energy LAPRAS_LV31,    3, +0
	dw NULL ; end

.list_prize
	dw WARTORTLE_LV24
	dw BLASTOISE_LV52
	dw NULL ; end

.StoreListPointers:
	ld hl, .CardListPointerTable
	call StoreAICardListPointers
	ret

.CardListPointerTable:
	dw .list_prize
	dw .list_arena
	dw .list_bench
	dw .list_play_from_hand
	dw .list_energy

AIActionTable_TrainerImprisonDeck:
	dw .do_turn
	dw .do_turn
	dw .start_duel
	dw .forced_switch
	dw .ko_switch
	dw .take_prize
	dw .update_portrait

.do_turn
	farcall AIMainTurnLogic
	ret

.start_duel
	call InitAIDuelVars
	call .StoreListPointers
	farcall SetUpBossStartingHandAndDeck
	call TrySetUpBossStartingPlayArea
	ret nc
	call AIPlayInitialBasicCards
	ret

.forced_switch
	call Func_14178
	ret

.ko_switch
	call Func_14178
	ret

.take_prize
	call AIPickPrizeCards
	ret

.update_portrait
	farcall AIUpdatePortrait
	ret

.list_arena
	dw PSYDUCK_LV15
	dw GASTLY_LV13
	dw ODDISH_LV21
	dw MR_MIME_LV20
	dw NULL ; end

.list_bench
.list_play_from_hand
	dw ODDISH_LV21
	dw GASTLY_LV13
	dw PSYDUCK_LV15
	dw NULL ; end

; unreferenced
	ai_retreat MR_MIME_LV20,   -28
	ai_retreat ODDISH_LV21,    -28
	ai_retreat DARK_GLOOM,     -28
	ai_retreat DARK_VILEPLUME, -28
	dw NULL ; end

.list_energy
	ai_energy GASTLY_LV13,    2,  +0
	ai_energy HAUNTER_LV26,   3,  +0
	ai_energy HAUNTER_LV25,   3,  +0
	ai_energy MR_MIME_LV20,   0,  -8
	ai_energy ODDISH_LV21,    0, -28
	ai_energy DARK_GLOOM,     0, -28
	ai_energy DARK_VILEPLUME, 0, -28
	ai_energy PSYDUCK_LV15,   1,  +0
	ai_energy DARK_GOLDUCK,   3,  +0
	dw NULL ; end

.list_prize
	dw MR_MIME_LV20
	dw NULL ; end

.StoreListPointers:
	ld hl, .CardListPointerTable
	call StoreAICardListPointers
	ret

.CardListPointerTable:
	dw .list_prize
	dw .list_arena
	dw .list_bench
	dw .list_play_from_hand
	dw .list_energy

AIActionTable_BlazingFlameDeck:
	dw .do_turn
	dw .do_turn
	dw .start_duel
	dw .forced_switch
	dw .ko_switch
	dw .take_prize
	dw .update_portrait

.do_turn
	farcall AIMainTurnLogic
	ret

.start_duel
	call InitAIDuelVars
	call .StoreListPointers
	farcall SetUpBossStartingHandAndDeck
	call TrySetUpBossStartingPlayArea
	ret nc
	call AIPlayInitialBasicCards
	ret

.forced_switch
	call Func_14178
	ret

.ko_switch
	call Func_14178
	ret

.take_prize
	call AIPickPrizeCards
	ret

.update_portrait
	farcall AIUpdatePortrait
	ret

.list_arena
	dw MAGMAR_LV31
	dw GROWLITHE_LV18
	dw VULPIX_LV13
	dw NULL ; end

.list_bench
.list_play_from_hand
	dw GROWLITHE_LV18
	dw VULPIX_LV13
	dw MAGMAR_LV31
	dw NULL ; end

; unreferenced
	ai_retreat GROWLITHE_LV18, -2
	ai_retreat VULPIX_LV13,    -1
	dw NULL ; end

.list_energy
	ai_energy VULPIX_LV13,    2, +0
	ai_energy NINETALES_LV32, 6, +0
	ai_energy GROWLITHE_LV18, 2, +0
	ai_energy ARCANINE_LV34,  4, +0
	ai_energy ARCANINE_LV45,  4, +0
	ai_energy MAGMAR_LV31,    2, -3
	dw NULL ; end

.list_prize
	dw MAGMAR_LV31
	dw NULL ; end

.StoreListPointers:
	ld hl, .CardListPointerTable
	call StoreAICardListPointers
	ret

.CardListPointerTable:
	dw .list_prize
	dw .list_arena
	dw .list_bench
	dw .list_play_from_hand
	dw .list_energy

AIActionTable_DamageChaosDeck:
	dw .do_turn
	dw .do_turn
	dw .start_duel
	dw .forced_switch
	dw .ko_switch
	dw .take_prize
	dw .update_portrait

.do_turn
	farcall AIMainTurnLogic
	ret

.start_duel
	call InitAIDuelVars
	call .StoreListPointers
	farcall SetUpBossStartingHandAndDeck
	call TrySetUpBossStartingPlayArea
	ret nc
	call AIPlayInitialBasicCards
	ret

.forced_switch
	call Func_14178
	ret

.ko_switch
	call Func_14178
	ret

.take_prize
	call AIPickPrizeCards
	ret

.update_portrait
	farcall AIUpdatePortrait
	ret

.list_arena
	dw JYNX_LV27
	dw EXEGGCUTE
	dw CLEFAIRY_LV15
	dw GASTLY_LV13
	dw GASTLY_LV17
	dw NULL ; end

.list_bench
.list_play_from_hand
	dw GASTLY_LV13
	dw GASTLY_LV17
	dw EXEGGCUTE
	dw CLEFAIRY_LV15
	dw JYNX_LV27
	dw NULL ; end

; unreferenced
	ai_retreat DARK_GENGAR, -28
	dw NULL ; end

.list_energy
	ai_energy EXEGGCUTE,      3, +0
	ai_energy EXEGGUTOR,     12, +0
	ai_energy GASTLY_LV13,    2, +0
	ai_energy GASTLY_LV17,    2, +0
	ai_energy DARK_HAUNTER,   3, +0
	ai_energy DARK_GENGAR,    3, -1
	ai_energy JYNX_LV27,      2, +0
	ai_energy CLEFAIRY_LV15,  2, +0
	ai_energy DARK_CLEFABLE,  3, +0
	dw NULL ; end

.list_prize
	dw DARK_HAUNTER
	dw DARK_GENGAR
	dw NULL ; end

.StoreListPointers:
	ld hl, .CardListPointerTable
	call StoreAICardListPointers
	ret

.CardListPointerTable:
	dw .list_prize
	dw .list_arena
	dw .list_bench
	dw .list_play_from_hand
	dw .list_energy

AIActionTable_BigThunderDeck:
	dw .do_turn
	dw .do_turn
	dw .start_duel
	dw .forced_switch
	dw .ko_switch
	dw .take_prize
	dw .update_portrait

.do_turn
	farcall AIMainTurnLogic
	ret

.start_duel
	call InitAIDuelVars
	call .StoreListPointers
	farcall SetUpBossStartingHandAndDeck
	call TrySetUpStartingPlayArea_BigThunderDeck
	ret nc
	call AIPlayInitialBasicCards
	ret

.forced_switch
	call Func_14178
	ret

.ko_switch
	call Func_14178
	ret

.take_prize
	call AIPickPrizeCards
	ret

.update_portrait
	farcall AIUpdatePortrait
	ret

.list_arena
	dw ZAPDOS_LV68
	dw CHANSEY_LV55
	dw DITTO
	dw NULL ; end

.list_bench
	dw NULL ; end

.list_play_from_hand
	dw ZAPDOS_LV68
	dw CHANSEY_LV55
	dw DITTO
	dw NULL ; end

; unreferenced
	ai_retreat DITTO,        -1
	ai_retreat CHANSEY_LV55, -1
	dw NULL ; end

.list_energy
	ai_energy ZAPDOS_LV68,  4, +10
	ai_energy DITTO,        4,  +3
	ai_energy CHANSEY_LV55, 4,  +3
	dw NULL ; end

.list_prize
	dw ZAPDOS_LV68
	dw NULL ; end

.StoreListPointers:
	ld hl, .CardListPointerTable
	call StoreAICardListPointers
	ret

.CardListPointerTable:
	dw .list_prize
	dw .list_arena
	dw .list_bench
	dw .list_play_from_hand
	dw .list_energy

AIActionTable_PowerOfDarknessDeck:
	dw .do_turn
	dw .do_turn
	dw .start_duel
	dw .forced_switch
	dw .ko_switch
	dw .take_prize
	dw .update_portrait

.do_turn
	farcall AIMainTurnLogic
	ret

.start_duel
	call InitAIDuelVars
	call .StoreListPointers
	farcall SetUpBossStartingHandAndDeck
	call TrySetUpBossStartingPlayArea
	ret nc
	call AIPlayInitialBasicCards
	ret

.forced_switch
	call Func_14178
	ret

.ko_switch
	call Func_14178
	ret

.take_prize
	call AIPickPrizeCards
	ret

.update_portrait
	farcall AIUpdatePortrait
	ret

.list_arena
	dw KANGASKHAN_LV40
	dw PSYDUCK_LV16
	dw DRATINI_LV12
	dw CLEFAIRY_LV15
	dw GRS_MEWTWO
	dw NULL ; end

.list_bench
.list_play_from_hand
	dw PSYDUCK_LV16
	dw DRATINI_LV12
	dw CLEFAIRY_LV15
	dw GRS_MEWTWO
	dw KANGASKHAN_LV40
	dw NULL ; end

; unreferenced
	ai_retreat GRS_MEWTWO, -28
	dw NULL ; end

.list_energy
	ai_energy PSYDUCK_LV16,    2, +0
	ai_energy DARK_GOLDUCK,    4, +0
	ai_energy GRS_MEWTWO,      2, -8
	ai_energy CLEFAIRY_LV15,   2, +0
	ai_energy DARK_CLEFABLE,   3, +0
	ai_energy KANGASKHAN_LV40, 4, -5
	ai_energy DRATINI_LV12,    2, +0
	ai_energy DARK_DRAGONAIR,  3, +0
	dw NULL ; end

.list_prize
	dw GRS_MEWTWO
	dw NULL ; end

.StoreListPointers:
	ld hl, .CardListPointerTable
	call StoreAICardListPointers
	ret

.CardListPointerTable:
	dw .list_prize
	dw .list_arena
	dw .list_bench
	dw .list_play_from_hand
	dw .list_energy

AIActionTable_PoisonStormDeck:
	dw .do_turn
	dw .do_turn
	dw .start_duel
	dw .forced_switch
	dw .ko_switch
	dw .take_prize
	dw .update_portrait

.do_turn
	farcall AIMainTurnLogic
	ret

.start_duel
	call InitAIDuelVars
	call .StoreListPointers
	farcall SetUpBossStartingHandAndDeck
	call TrySetUpStartingPlayArea_PoisonStormDeck
	ret nc
	call AIPlayInitialBasicCards
	ret

.forced_switch
	call Func_14178
	ret

.ko_switch
	call Func_14178
	ret

.take_prize
	call AIPickPrizeCards
	ret

.update_portrait
	farcall AIUpdatePortrait
	ret

.list_arena
	dw WEEDLE_LV15
	dw KANGASKHAN_LV40
	dw MAGMAR_LV31
	dw CHARMANDER_LV10
	dw SCYTHER_LV25
	dw NULL ; end

.list_bench
.list_play_from_hand
	dw CHARMANDER_LV10
	dw SCYTHER_LV25
	dw MAGMAR_LV31
	dw WEEDLE_LV15
	dw KANGASKHAN_LV40
	dw NULL ; end

; unreferenced
	ai_retreat SCYTHER_LV25, +1
	dw NULL ; end

.list_energy
	ai_energy WEEDLE_LV15,     2, +0
	ai_energy SCYTHER_LV25,    3, +0
	ai_energy CHARMANDER_LV10, 3, +0
	ai_energy CHARMELEON,      4, +0
	ai_energy MAGMAR_LV31,     2, +0
	ai_energy KANGASKHAN_LV40, 4, +0
	dw NULL ; end

.list_prize
	dw WEEDLE_LV15
	dw MAGMAR_LV31
	dw NULL ; end

.StoreListPointers:
	ld hl, .CardListPointerTable
	call StoreAICardListPointers
	ret

.CardListPointerTable:
	dw .list_prize
	dw .list_arena
	dw .list_bench
	dw .list_play_from_hand
	dw .list_energy

; returns carry if card ID in de is NULL ; end
; de = card ID
CheckIfCardIDIsZero_Bank5:
	push af
	xor a
	cp d
	jr nz, .false
	cp e
	jr nz, .false
	pop af
	scf
	ret
.false
	pop af
	or a
	ret

; converts HP in a to number of equivalent damage counters
; input:
;	a = HP
; output:
;	a = number of damage counters
ConvertHPToCounters:
	push bc
	ld c, 0
.loop
	sub 10
	jr c, .done
	inc c
	jr .loop
.done
	ld a, c
	pop bc
	ret

; returns in a the result of
; dividing b by a, rounded down
; input:
;	a = divisor
;	b = dividend
CalculateBDividedByA_Bank5:
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

InitAIDuelVars:
	ld a, wAIDuelVarsEnd - wAIDuelVars
	ld hl, wAIDuelVars
	farcall ClearNBytesFromHL
	ld a, 5
	ld [wAIPokedexCounter], a
	ld a, $ff
	ld [wAIPeekedPrizes], a
	ret

; runs AIDecideWhetherToRetreat but
; disregards the status of Arena card
AIDecideWhetherToRetreat_IgnoreStatus:
	xor a
	ld [wAIRetreatConsiderStatus], a
	jr AIDecideWhetherToRetreat

; runs AIDecideWhetherToRetreat and
; takes into account the status of Arena card
AIDecideWhetherToRetreat_ConsiderStatus:
	ld a, TRUE
	ld [wAIRetreatConsiderStatus], a
;	fallthrough

; determine AI score for retreating
; return carry if AI decides to retreat
AIDecideWhetherToRetreat:
	ld a, [wGotHeadsFromConfusionCheckDuringRetreat]
	or a
	jp nz, .no_carry
	xor a
	ld [wAIPlayEnergyCardForRetreat], a
	call LoadDefendingPokemonColorWRAndPrizeCards

	farcall AIDeckSpecificRetreatLogic
	ld [wAIScore], a
	ld a, [wd032]
	or a
	jr z, .check_status
	; add wd032 * 8 to score
	srl a
	srl a
	sla a ; *8
	call AIEncourage

.check_status
	ld a, [wAIRetreatConsiderStatus]
	or a
	jr z, .skip_status_check
	ld a, DUELVARS_ARENA_CARD_STATUS
	get_turn_duelist_var
	or a
	jr z, .skip_status_check ; no status
	and DOUBLE_POISONED
	jr z, .check_cnf ; no poison
	ld a, 2
	call AIEncourage
.check_cnf
	ld a, [hl]
	and CNF_SLP_PRZ
	cp CONFUSED
	jr nz, .skip_status_check
	; confused
	ld a, 1
	call AIEncourage
	; if it's Dark Primeape, discourage
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call GetCardIDFromDeckIndex
	cp16 DARK_PRIMEAPE
	jr nz, .skip_status_check
	ld a, 5
	call AIDiscourage

.skip_status_check
	xor a ; PLAY_AREA_ARENA
	ldh [hTempPlayAreaLocation_ff9d], a
	call CheckIfAnyAttackKnocksOutDefendingCard
	jr nc, .active_cant_ko_1
	call CheckIfSelectedAttackIsUnusable
	jp nc, .active_cant_use_atk
	farcall LookForEnergyNeededForAttackInHand
	jr nc, .active_cant_ko_1

.active_cant_use_atk
	ld a, 5
	call AIDiscourage
	ld a, [wAIOpponentPrizeCount]
	cp 2
	jr nc, .active_cant_ko_1
	ld a, 35
	call AIDiscourage

.active_cant_ko_1
	farcall CheckIfDefendingPokemonCanKnockOut
	jr nc, .defending_cant_ko
	ld a, 2
	call AIEncourage

	farcall CheckIfNotABossDeckID
	jr c, .check_resistance_1
	ld a, [wAIPlayerPrizeCount]
	cp 2
	jr nc, .check_prize_count
	ld a, TRUE
	ld [wAIPlayEnergyCardForRetreat], a

.defending_cant_ko
	farcall CheckIfNotABossDeckID
	jr c, .check_resistance_1
	ld a, [wAIPlayerPrizeCount]
	cp 2
	jr nc, .check_prize_count
	ld a, 2
	call AIEncourage

.check_prize_count
	ld a, [wAIOpponentPrizeCount]
	cp 2
	jr nc, .check_resistance_1
	ld a, 1
	call AIDiscourage

.check_resistance_1
	bank1call CheckIfDampeningShieldIsActive
	jp c, .check_ko_2
	bank1call GetArenaCardColor
	call TranslateColorToWR
	ld b, a
	ld a, [wAIPlayerResistance]
	and b
	jr z, .check_weakness_1
	ld a, 1
	call AIEncourage

; check bench for Pokémon that
; the defending card is not resistant to
; if one is found, skip AIDiscourage
	ld a, [wAIPlayerResistance]
	ld b, a
	ld a, DUELVARS_BENCH
	get_turn_duelist_var
.loop_resistance_1
	ld a, [hli]
	cp $ff
	jr z, .exit_loop_resistance_1
	call LoadCardDataToBuffer1_FromDeckIndex
	ld a, [wLoadedCard1Type]
	call TranslateColorToWR
	and b
	jr nz, .loop_resistance_1
	jr .check_weakness_1
.exit_loop_resistance_1
	ld a, 2
	call AIDiscourage

.check_weakness_1
	ld a, [wAIPlayerColor]
	ld b, a
	bank1call GetArenaCardWeakness
	and b
	jr z, .check_resistance_2
	ld a, 2
	call AIEncourage

; check bench for Pokémon that
; is not weak to defending Pokémon
; if one is found, skip AIDiscourage
	ld a, [wAIPlayerColor]
	ld b, a
	ld a, DUELVARS_BENCH
	get_turn_duelist_var
.loop_weakness_1
	ld a, [hli]
	cp $ff
	jr z, .exit_loop_weakness_1
	call LoadCardDataToBuffer1_FromDeckIndex
	ld a, [wLoadedCard1Weakness]
	and b
	jr nz, .loop_weakness_1
	jr .check_resistance_2
.exit_loop_weakness_1
	ld a, 3
	call AIDiscourage

.check_resistance_2
	ld a, [wAIPlayerColor]
	ld b, a
	bank1call GetArenaCardResistance
	and b
	jr z, .check_weakness_2
	ld a, 3
	call AIDiscourage

; check bench for Pokémon that
; is the defending Pokémon's weakness
; if none is found, skip AIEncourage
.check_weakness_2
	ld a, [wAIPlayerWeakness]
	ld b, a
	ld a, DUELVARS_BENCH
	get_turn_duelist_var
	ld e, PLAY_AREA_BENCH_1 - 1
.loop_weakness_2
	inc e
	ld a, [hli]
	cp $ff
	jr z, .check_resistance_3
	push de
	call LoadCardDataToBuffer1_FromDeckIndex
	ld a, [wLoadedCard1Type]
	call TranslateColorToWR
	pop de
	and b
	jr z, .loop_weakness_2
	ld a, 2
	call AIEncourage

	push de
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call GetCardIDFromDeckIndex
	cp16 PORYGON_LV12
	pop de
	jr nz, .check_weakness_3

; handle Porygon
	ld a, e
	farcall CheckIfCanDamageDefendingPokemon
	jr nc, .check_weakness_3
	ld a, 10
	call AIEncourage
	jr .check_resistance_3

.check_weakness_3
	bank1call GetArenaCardColor
	call TranslateColorToWR
	ld b, a
	ld a, [wAIPlayerWeakness]
	and b
	jr z, .check_resistance_3
	ld a, 3
	call AIDiscourage

; check bench for Pokémon that
; is resistant to defending Pokémon
; if none is found, skip AIEncourage
.check_resistance_3
	ld a, [wAIPlayerColor]
	ld b, a
	ld a, DUELVARS_BENCH
	get_turn_duelist_var
.loop_resistance_2
	ld a, [hli]
	cp $ff
	jr z, .check_ko_2
	call LoadCardDataToBuffer1_FromDeckIndex
	ld a, [wLoadedCard1Resistance]
	and b
	jr z, .loop_resistance_2
	ld a, 1
	call AIEncourage

; check bench for Pokémon that
; can KO defending Pokémon
; if none is found, skip AIEncourage
.check_ko_2
	ld a, DUELVARS_BENCH
	get_turn_duelist_var
	ld c, 0
.loop_ko_1
	inc c
	ld a, [hli]
	cp $ff
	jr z, .check_defending_id
	ld a, c
	ldh [hTempPlayAreaLocation_ff9d], a
	push hl
	push bc
	call CheckIfAnyAttackKnocksOutDefendingCard
	jr nc, .no_ko
	call CheckIfSelectedAttackIsUnusable
	jr nc, .success
	farcall LookForEnergyNeededForAttackInHand
	jr c, .success
.no_ko
	pop bc
	pop hl
	jr .loop_ko_1
.success
	pop bc
	pop hl
	ld a, 2
	call AIEncourage

; a bench Pokémon was found that can KO
; if this is a boss deck and it's at last prize card
; if arena Pokémon cannot KO, add to AI score
; and set wAIPlayEnergyCardForRetreat to $01

	ld a, [wAIOpponentPrizeCount]
	cp 2
	jr nc, .not_last_prize_card
	farcall CheckIfNotABossDeckID
	jr c, .check_defending_id

	xor a ; PLAY_AREA_ARENA
	ldh [hTempPlayAreaLocation_ff9d], a
	call CheckIfAnyAttackKnocksOutDefendingCard
	jr nc, .active_cant_ko_2
	call CheckIfSelectedAttackIsUnusable
	jr nc, .check_defending_id
.active_cant_ko_2
	ld a, 40
	call AIEncourage
	ld a, TRUE
	ld [wAIPlayEnergyCardForRetreat], a
	jr .check_defending_id

.not_last_prize_card
	; if retreat cost is 0, then encourage
	; if Arena card cannot KO
	xor a ; PLAY_AREA_ARENA
	ldh [hTempPlayAreaLocation_ff9d], a
	call GetPlayAreaCardRetreatCost
	or a
	jr nz, .check_defending_id
	; no retreat cost
	call CheckIfAnyAttackKnocksOutDefendingCard
	jr nc, .zero_retreat_cost_encourage
	call CheckIfSelectedAttackIsUnusable
	jr nc, .check_defending_id
.zero_retreat_cost_encourage
	ld a, 1
	call AIEncourage

.check_defending_id
	ld a, DUELVARS_ARENA_CARD
	call GetNonTurnDuelistVariable
	call SwapTurn
	call GetCardIDFromDeckIndex
	call SwapTurn
	cp16 MR_MIME_LV28
	jr z, .mr_mime_or_hitmonlee
	cp16 HITMONLEE_LV30
	jr nz, .check_haunter

; check bench if there's any Pokémon
; that can damage defending Pokémon
; this is done because of Mr. Mime's PKMN PWR
; and Hitmonlee's ability to attack Bench
.mr_mime_or_hitmonlee
	xor a
	farcall CheckIfCanDamageDefendingPokemon
	jr c, .check_haunter
	ld a, DUELVARS_BENCH
	get_turn_duelist_var
	ld c, 0
.loop_damage
	inc c
	ld a, [hli]
	cp $ff
	jr z, .check_haunter
	ld a, c
	push hl
	push bc
	farcall CheckIfCanDamageDefendingPokemon
	jr c, .can_damage
	pop bc
	pop hl
	jr .loop_damage
.can_damage
	pop bc
	pop hl
	ld a, 5
	call AIEncourage
	ld a, TRUE
	ld [wAIPlayEnergyCardForRetreat], a

.check_haunter
; if Defending card is asleep and there's a Haunter lv22
; in the Bench that can use its Sleep Eater attack,
; then encourage to capitalize on the sleep status
	ld a, DUELVARS_ARENA_CARD_STATUS
	call GetNonTurnDuelistVariable
	and CNF_SLP_PRZ
	cp ASLEEP
	jr z, .check_retreat_cost
	ld de, HAUNTER_LV22
	ld b, PLAY_AREA_BENCH_1
	farcall FindCardIDInTurnDuelistsPlayArea
	jr nc, .check_retreat_cost
	xor a ; PLAY_AREA_ARENA
	ldh [hTempPlayAreaLocation_ff9d], a
	ld a, SECOND_ATTACK
	ld [wSelectedAttack], a
	call CheckIfSelectedAttackIsUnusable
	jr c, .check_retreat_cost
	; can use Sleep Eater
	ld a, 5
	call AIEncourage
	ld a, TRUE
	ld [wAIPlayEnergyCardForRetreat], a

; subtract from wAIScore if retreat cost is larger than 1
; then check if any cards have at least half HP,
; are final evolutions and can use second attack in the bench
; and adds to wAIScore if the active Pokémon doesn't meet
; these conditions
.check_retreat_cost
	xor a ; PLAY_AREA_ARENA
	ldh [hTempPlayAreaLocation_ff9d], a
	call GetPlayAreaCardRetreatCost
	cp 2
	jr c, .one_or_none
	cp 3
	jr nc, .three_or_more
	; exactly two
	ld a, 1
	call AIDiscourage
	jr .one_or_none

.three_or_more
	ld a, 2
	call AIDiscourage

.one_or_none
	farcall CheckIfArenaCardIsFullyPowered
	jr c, .check_defending_can_ko
	farcall CountNumberOfSetUpBenchPokemon
	cp 2
	jr c, .check_defending_can_ko
	call AIEncourage
	jr .check_defending_can_ko

.trainer_pkmn_card
	pop de
	jr .loop_ko_2

; check bench for Pokémon that
; the defending Pokémon can't knock out
; if none is found, skip AIDiscourage
.check_defending_can_ko
	ld a, DUELVARS_BENCH
	get_turn_duelist_var
	ld e, 0
.loop_ko_2
	inc e
	ld a, [hli]
	cp $ff
	jr z, .exit_loop_ko
	push de
	call LoadCardDataToBuffer2_FromDeckIndex
	ld a, [wLoadedCard2ID + 0]
	ld e, a
	ld a, [wLoadedCard2ID + 1]
	ld d, a
	cp16 MYSTERIOUS_FOSSIL
	jr z, .trainer_pkmn_card
	cp16 CLEFAIRY_DOLL
	jr z, .trainer_pkmn_card
	pop de
	ld a, e
	ldh [hTempPlayAreaLocation_ff9d], a
	push de
	push hl
	farcall CheckIfDefendingPokemonCanKnockOut
	pop hl
	pop de
	jr c, .loop_ko_2
	jr .check_active_id
.exit_loop_ko
	ld a, 20
	call AIDiscourage

.check_active_id
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call GetCardIDFromDeckIndex
	cp16 MYSTERIOUS_FOSSIL
	jr z, .mysterious_fossil
	cp16 CLEFAIRY_DOLL
	jr z, .clefairy_doll

; if wAIScore is at least 131, set carry
	ld a, [wAIScore]
	cp 131
	jr nc, .set_carry
.no_carry
	or a
	ret
.set_carry
	scf
	ret

; set carry regardless if active card is
; either Mysterious Fossil or Clefairy Doll
; and there's a bench Pokémon who is not KO'd
; by defending Pokémon and can damage it
.clefairy_doll
	ld a, [wOpponentDeckID]
	cp PUPPET_MASTER_DECK_ID
	jr z, .no_carry
.mysterious_fossil
	ld e, 0
.loop_ko_3
	inc e
	ld a, e
	add DUELVARS_ARENA_CARD
	get_turn_duelist_var
	cp $ff
	jr z, .no_carry
	ld a, e
	ldh [hTempPlayAreaLocation_ff9d], a
	push de
	farcall CheckIfDefendingPokemonCanKnockOut
	pop de
	jr c, .loop_ko_3
	ld a, e
	push de
	farcall CheckIfCanDamageDefendingPokemon
	pop de
	jr nc, .loop_ko_3
	jr .set_carry

; given a list of card IDs sorted by preference in [de]
; play a Pkmn card from the hand (wDuelTempList) that is
; highest in that list
; returns carry if none of the cards in the list are found.
; returns number of Pokemon in Play Area in a.
PlayPkmnCardWithHighestPreference:
	ld a, [de]
	ld c, a
	inc de
	ld a, [de]
	ld b, a

; go in order of the list in bc and
; add first card that matches ID.
; returns carry if hand doesn't have any card in list.
.loop_id_list
	ld a, [bc]
	inc bc
	ld e, a
	ld a, [bc]
	inc bc
	ld d, a
	call CheckIfCardIDIsZero_Bank5
	jr c, .not_found
	farcall RemoveCardIDInList
	jr nc, .loop_id_list
	push hl
	call PutHandPokemonCardInPlayArea
	pop hl
	or a
	ret
.not_found
	scf
	ret

; play Pokemon cards from the hand to set the starting
; Play Area of Boss decks.
; each Boss deck has two ID lists in order of preference.
; one list is for the Arena card is the other is for the Bench cards.
; if Arena card could not be set (due to hand not having any card in its list)
; or if list is null, return carry and do not play any cards.
TrySetUpBossStartingPlayArea:
	ld de, wAICardListArenaPriority
	ld a, d
	or a
	jr z, .set_carry ; return if null

; pick Arena card
	call CreateHandCardList
	ld hl, wDuelTempList
	ld de, wAICardListArenaPriority
	call PlayPkmnCardWithHighestPreference
	ret c

; play Pokemon cards to Bench until there are
; a maximum of 3 cards in Play Area.
.loop
	ld de, wAICardListBenchPriority
	call PlayPkmnCardWithHighestPreference
	jr c, .done
	cp 3
	jr c, .loop

.done
	or a
	ret
.set_carry
	scf
	ret

TrySetUpStartingPlayArea_PowerfulPokemonDeck:
	ld de, wAICardListArenaPriority
	ld a, d
	or a
	jr z, .set_carry ; return if null

; copy hand list to wc000
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
	ld de, wAICardListArenaPriority
	call .PlayHighestPreferenceWithMatchingEnergyInHand
	jr nc, .play_bench
	ld de, wAICardListArenaPriority
	call PlayPkmnCardWithHighestPreference
	ret c
.play_bench
	ld de, wAICardListBenchPriority
	call .PlayHighestPreferenceWithMatchingEnergyInHand
	jr c, .done
	cp 3
	jr c, .play_bench

.done
	or a
	ret
.set_carry
	scf
	ret

; loops through list in [de], and for the first card found
; that has a matching energy card in the hand, play it from the hand
; if none is found, then returns carry
; input:
; - [de] = pointer to Arena/Bench card priority list
.PlayHighestPreferenceWithMatchingEnergyInHand:
	; load list pointer to bc
	ld a, [de]
	ld c, a
	inc de
	ld a, [de]
	ld b, a
.loop_list
	ld a, [bc]
	inc bc
	ld e, a
	ld a, [bc]
	inc bc
	ld d, a
	call CheckIfCardIDIsZero_Bank5
	jr c, .none_found
	call .CheckMatchingEnergyInHand
	jr nc, .loop_list
	farcall RemoveCardIDInList
	jr nc, .loop_list
	push hl
	call PutHandPokemonCardInPlayArea
	pop hl
	or a
	ret
.none_found
	scf
	ret

; input:
; - de = card ID
; output:
; - carry set if an energy card is found in the hand
; that matches the type of the card given in de
.CheckMatchingEnergyInHand:
	push hl
	push de
	push bc
	cp16 MAGMAR_LV31
	jr nz, .not_magmar
	ld de, FIRE_ENERGY
	jr .look_for_energy
.not_magmar
	cp16 LAPRAS_LV31
	jr nz, .not_lapras
	ld de, WATER_ENERGY
	jr .look_for_energy
.not_lapras
	cp16 ELECTABUZZ_LV35
	jr nz, .not_electabuzz
	ld de, LIGHTNING_ENERGY
	jr .look_for_energy
.not_electabuzz
	cp16 HITMONCHAN_LV33
	jr nz, .not_hitmonchan
	ld de, FIGHTING_ENERGY
	jr .look_for_energy
.not_hitmonchan
	ld de, PSYCHIC_ENERGY
.look_for_energy
	farcall LookForCardIDInHandList
	pop bc
	pop de
	pop hl
	ret

TrySetUpStartingPlayArea_BigThunderDeck:
	ld de, wAICardListArenaPriority
	ld a, d
	or a
	jr z, .set_carry ; return if null

	; play Arena card first, based on preference
	call CreateHandCardList
	ld hl, wDuelTempList
	ld de, wAICardListArenaPriority
	call PlayPkmnCardWithHighestPreference
	ret c

	; next check which card was placed in Arena
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call GetCardIDFromDeckIndex
	; if Zapdos lv68, we're done
	cp16 ZAPDOS_LV68
	jr z, .done
	; if Chansey lv55, try placing Ditto from hand
	cp16 CHANSEY_LV55
	jr z, .search_ditto
	; else, try placing a Chansey lv55 from hand
	ld de, CHANSEY_LV55
	farcall LookForCardIDInHandList
	jr c, .place_in_bench
	jr .done
.search_ditto
	ld de, DITTO
	farcall LookForCardIDInHandList
	jr c, .place_in_bench
	jr .done
.place_in_bench
	call PutHandPokemonCardInPlayArea

.done
	or a
	ret

.set_carry
	scf
	ret

TrySetUpStartingPlayArea_PoisonStormDeck:
	; check if has Double Colorless
	ld de, DOUBLE_COLORLESS_ENERGY
	farcall LookForCardIDInHandList
	jr nc, .no_scyther ; no Double Colorless
	; check if has Grass energy
	ld de, GRASS_ENERGY
	farcall LookForCardIDInHandList
	jr nc, .no_scyther ; no Grass energy
	; check if has Scyther lv25
	ld de, SCYTHER_LV25
	farcall LookForCardIDInHandList
	jr nc, .no_scyther
	; has all 3 cards, put Scyther in Arena
	call PutHandPokemonCardInPlayArea

	; now move on to the bench
	call CreateHandCardList
	ld hl, wDuelTempList
	jr .loop_place_bench

.no_scyther
	; doesn't have conditions to place Scyther in Arena
	; run through the list of card preferences
	ld de, wAICardListArenaPriority
	ld a, d
	or a
	jr z, .set_carry
	call CreateHandCardList
	ld hl, wDuelTempList
	ld de, wAICardListArenaPriority
	call PlayPkmnCardWithHighestPreference
	ret c
.loop_place_bench
	ld de, wAICardListBenchPriority
	call PlayPkmnCardWithHighestPreference
	jr c, .done
	cp 3
	jr c, .loop_place_bench

.done
	or a
	ret
.set_carry
	scf
	ret

; if player's turn and loaded attack is not a Pokémon Power OR
; if opponent's turn and wAITriedAttack == 0
; set wAIRetreatFlags's bit 7 flag
SetAIRetreatFlags:
	xor a
	ld [wAIRetreatFlags], a
	ld a, [wWhoseTurn]
	cp OPPONENT_TURN
	jr z, .opponent

; player
	ld a, [wLoadedAttackCategory]
	cp POKEMON_POWER
	ret z
	jr .set_flag

.opponent
	ld a, [wAITriedAttack]
	or a
	ret nz

.set_flag
	ld a, %10000000
	ld [wAIRetreatFlags], a
	ret

; calculates AI score for bench Pokémon
; returns in a and [hTempPlayAreaLocation_ff9d] the
; Play Area location of best card to switch to.
; returns carry if no Bench Pokemon.
AIDecideBenchPokemonToSwitchTo:
	xor a ; PLAY_AREA_ARENA
	ldh [hTempPlayAreaLocation_ff9d], a
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	cp 2
	ret c

; has at least 2 Pokémon in Play Area
	call SetAIRetreatFlags
	call LoadDefendingPokemonColorWRAndPrizeCards
	ld a, 50
	ld [wAIScore], a
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	ld b, a
	ld c, PLAY_AREA_ARENA
	push bc
	jp .store_score

.loop_play_area
	push bc
	ld a, c
	ldh [hTempPlayAreaLocation_ff9d], a
	ld a, 50
	ld [wAIScore], a

; check if card can KO defending Pokémon
; if it can, raise AI score
; if on last prize card, raise AI score again
	call CheckIfAnyAttackKnocksOutDefendingCard
	jr nc, .check_can_use_atks
	call CheckIfSelectedAttackIsUnusable
	jr nc, .asm_165bb
	farcall LookForEnergyNeededForAttackInHand
	jr nc, .check_can_use_atks
.asm_165bb
	ld a, 10
	call AIEncourage
	ld a, [wAIRetreatFlags]
	or %00000001
	ld [wAIRetreatFlags], a
	call CountPrizes
	cp 2
	jp nc, .check_defending_weak
	ld a, 10
	call AIEncourage

; calculates damage of both attacks
; to raise AI score accordingly
.check_can_use_atks
	xor a ; FIRST_ATTACK_OR_PKMN_POWER
	ld [wSelectedAttack], a
	call CheckIfSelectedAttackIsUnusable
	call nc, .HandleAttackDamageScore
	ld a, SECOND_ATTACK
	ld [wSelectedAttack], a
	call CheckIfSelectedAttackIsUnusable
	call nc, .HandleAttackDamageScore
	jr .check_energy_card

; adds to AI score depending on amount of damage
; it can inflict to the defending Pokémon
; AI score += floor(Damage / 10) + 1
.HandleAttackDamageScore
	ld a, [wSelectedAttack]
	call EstimateDamage_VersusDefendingCard
	ld a, [wDamage]
	call ConvertHPToCounters
	inc a
	call AIEncourage
	ret

; if an energy card that is needed is found in hand
; calculate damage of the move and raise AI score
; AI score += floor(Damage / 20)
.check_energy_card
	farcall LookForEnergyNeededInHand
	jr nc, .check_attached_energy
	ld a, [wSelectedAttack]
	call EstimateDamage_VersusDefendingCard
	ld a, [wDamage]
	call ConvertHPToCounters
	srl a
	call AIEncourage

; if no energies attached to card, lower AI score
.check_attached_energy
	ldh a, [hTempPlayAreaLocation_ff9d]
	ld e, a
	call GetPlayAreaCardAttachedEnergies
	ld a, [wTotalAttachedEnergies]
	or a
	jr nz, .check_mr_mime
	ld a, 1
	call AIDiscourage

; if can damage Mr Mime, raise AI score
.check_mr_mime
	call SwapTurn
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call LoadCardDataToBuffer2_FromDeckIndex
	call SwapTurn
	ld hl, wLoadedCard2ID
	cphl MR_MIME_LV28
	jr nz, .check_defending_weak
	xor a
	call EstimateDamage_VersusDefendingCard
	ld a, [wDamage]
	or a
	jr nz, .can_damage
	ld a, SECOND_ATTACK
	call EstimateDamage_VersusDefendingCard
	ld a, [wDamage]
	or a
	jr z, .check_defending_weak
.can_damage
	ld a, 5
	call AIEncourage

; if defending card is weak to this card, raise AI score
.check_defending_weak
	bank1call CheckIfDampeningShieldIsActive
	jp c, .check_retreat_cost
	ldh a, [hTempPlayAreaLocation_ff9d]
	add DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call LoadCardDataToBuffer1_FromDeckIndex
	ld a, [wLoadedCard1Type]
	call TranslateColorToWR
	ld c, a
	ld hl, wAIPlayerWeakness
	and [hl]
	jr z, .check_defending_resist
	ld a, 3
	call AIEncourage

; if defending card is resistant to this card, lower AI score
.check_defending_resist
	ld a, c
	ld hl, wAIPlayerResistance
	and [hl]
	jr z, .check_resistance
	ld a, 3
	call AIDiscourage

; if this card is resistant to defending Pokémon, raise AI score
.check_resistance
	ld a, [wAIPlayerColor]
	ld hl, wLoadedCard1Resistance
	and [hl]
	jr z, .check_weakness
	ld a, 2
	call AIEncourage

; if this card is weak to defending Pokémon, lower AI score
.check_weakness
	ld a, [wAIPlayerColor]
	ld hl, wLoadedCard1Weakness
	and [hl]
	jr z, .check_retreat_cost
	ld a, 4
	call AIDiscourage

; if this card's retreat cost < 2, raise AI score
; if this card's retreat cost > 2, lower AI score
.check_retreat_cost
	call GetPlayAreaCardRetreatCost
	cp 2
	jr c, .one_or_none
	jr z, .check_player_prize_count
	ld a, 1
	call AIDiscourage
	jr .check_player_prize_count
.one_or_none
	ld a, 1
	call AIEncourage

; if wAIRetreatFlags != $81
; if defending Pokémon can KO this card
; if player is not at last prize card, lower 3 from AI score
; if player is at last prize card, lower 10 from AI score
.check_player_prize_count
	ld a, [wAIRetreatFlags]
	cp %10000000 | %00000001
	jr z, .check_hp
	farcall CheckIfDefendingPokemonCanKnockOut
	jr nc, .check_hp
	ld e, 3
	ld a, [wAIPlayerPrizeCount]
	cp 1
	jr nz, .lower_score_1
	ld e, 10
.lower_score_1
	ld a, e
	call AIDiscourage

; if this card's HP is 0, make AI score 0
.check_hp
	ldh a, [hTempPlayAreaLocation_ff9d]
	add DUELVARS_ARENA_CARD_HP
	get_turn_duelist_var
	or a
	jr nz, .add_hp_score
	ld [wAIScore], a
	jp .store_score

; AI score += floor(HP/40)
.add_hp_score
	ld b, a
	ld a, 4
	call CalculateBDividedByA_Bank5
	call ConvertHPToCounters
	call AIEncourage

	ldh a, [hTempPlayAreaLocation_ff9d]
	add DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call GetCardIDFromDeckIndex
	cp16 MR_MIME_LV28
	jr z, .mr_mime

	; raise AI score if it's a MewLv8
	; and defending card is not basic stage
	cp16 MEW_LV8
	jr nz, .check_if_has_bench_utility
	ld a, DUELVARS_ARENA_CARD
	call GetNonTurnDuelistVariable
	call SwapTurn
	call LoadCardDataToBuffer2_FromDeckIndex
	call SwapTurn
	ld a, [wLoadedCard2Stage]
	or a
	jr z, .check_if_has_bench_utility
	ld a, 5
	call AIEncourage
	jr .check_if_has_bench_utility

.mr_mime
	; raise AI score if it's a Mr. Mime Lv28
	; and defending card doesn't have an attack
	; that can damage it
	xor a
	call EstimateDamage_FromDefendingPokemon
	ld a, [wDamage]
	or a
	jr z, .check_other_attack
	cp 30
	jr c, .check_if_has_bench_utility
.check_other_attack
	ld a, SECOND_ATTACK
	call EstimateDamage_FromDefendingPokemon
	ld a, [wDamage]
	or a
	jr z, .cannot_damage_mr_mime
	cp 30
	jr c, .check_if_has_bench_utility
.cannot_damage_mr_mime
	ld a, 5
	call AIEncourage

; if wLoadedCard1AIInfo == AI_INFO_BENCH_UTILITY,
; lower AI score
.check_if_has_bench_utility
	ldh a, [hTempPlayAreaLocation_ff9d]
	add DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call LoadCardDataToBuffer1_FromDeckIndex
	ld a, [wLoadedCard1AIInfo]
	cp AI_INFO_BENCH_UTILITY
	jr nz, .check_trainer_pokemon
	ld a, 2
	call AIDiscourage

; if card is Mysterious Fossil or Clefairy Doll,
; and deck isn't Puppet Master, lower AI score
.check_trainer_pokemon
	ld a, [wLoadedCard1ID + 0]
	ld e, a
	ld a, [wLoadedCard1ID + 1]
	ld d, a
	cp16 MYSTERIOUS_FOSSIL
	jr z, .mysterious_fossil_or_clefairy_doll
	cp16 CLEFAIRY_DOLL
	jr nz, .deck_specific_logic
.mysterious_fossil_or_clefairy_doll
	ld a, [wOpponentDeckID]
	cp PUPPET_MASTER_DECK_ID
	jr z, .deck_specific_logic
	ld a, 10
	call AIDiscourage

.deck_specific_logic
	ldh a, [hTempPlayAreaLocation_ff9d]
	add DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call GetCardIDFromDeckIndex
	farcall AIDeckSpecificBenchScore
	jr c, .asm_16794
	call AIEncourage
	jr .ai_score_bonus
.asm_16794
	call AIDiscourage

.ai_score_bonus
	ld c, e ; card ID
	ld b, d ;
	ld a, [wAICardListRetreatBonus + 1]
	or a
	jr z, .store_score
	ld h, a
	ld a, [wAICardListRetreatBonus + 0]
	ld l, a

.loop_ids
	ld a, [hli]
	ld e, a
	ld a, [hli]
	ld d, a
	call CheckIfCardIDIsZero_Bank5
	jr c, .store_score ; list is over
	ld a, d
	cp b
	jr nz, .next_id
	jr c, .store_score
	ld a, e
	cp c
	jr nz, .next_id
	ld a, [hl]
	cp $80
	jr c, .subtract_score
	sub $80
	call AIEncourage
	jr .next_id
.subtract_score
	push bc
	ld c, a
	ld a, $80
	sub c
	pop bc
	call AIDiscourage
.next_id
	inc hl
	jr .loop_ids

.store_score
	ldh a, [hTempPlayAreaLocation_ff9d]
	ld c, a
	ld b, $00
	ld hl, wPlayAreaAIScore
	add hl, bc
	ld a, [wAIScore]
	ld [hl], a
	pop bc
	inc c
	dec b
	jp nz, .loop_play_area
; done
	jp FindHighestBenchScore

Func_167e5:
	push af
	bank1call CheckUnableToRetreatDueToEffect
	jr nc, .able_to_retreat
	add sp, $02
	ret
.able_to_retreat
	ld a, [wAIPlayEnergyCardForRetreat]
	or a
	jr z, .dont_play_energy_card

; AI is allowed to play an energy card
; from the hand in order to provide
; the necessary energy for retreat cost

; check status
	ld a, DUELVARS_ARENA_CARD_STATUS
	get_turn_duelist_var
	and CNF_SLP_PRZ
	cp ASLEEP
	jp z, .dont_play_energy_card ; can be jr
	cp PARALYZED
	jp z, .dont_play_energy_card ; can be jr

; if an energy card hasn't been played yet,
; checks if the Pokémon needs just one more energy to retreat
; if it does, check if there are any energy cards in hand
; and if there are, play that energy card
	ld a, [wAlreadyPlayedEnergy]
	or a
	jr nz, .dont_play_energy_card
	call CreateArenaOrBenchEnergyCardList
	push af
	xor a ; PLAY_AREA_ARENA
	ldh [hTempPlayAreaLocation_ff9d], a
	call GetPlayAreaCardRetreatCost
	pop bc
	cp b
	jr c, .dont_play_energy_card
	jr z, .dont_play_energy_card
	; energy attached < retreat cost
	sub b
	cp 1
	jr nz, .dont_play_energy_card
	farcall CreateEnergyCardListFromHand_OnlyBasic
	jr nc, .asm_1682a
	farcall $12, $7f6d
	jr c, .dont_play_energy_card
.asm_1682a
	ld a, [wDuelTempList]
	ldh [hTemp_ffa0], a
	xor a ; PLAY_AREA_ARENA
	ldh [hTempPlayAreaLocation_ffa1], a
	ld a, OPPACTION_PLAY_ENERGY
	farcall AIMakeDecision

.dont_play_energy_card
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call GetCardIDFromDeckIndex
	cp16 MYSTERIOUS_FOSSIL
	jp z, .mysterious_fossil_or_clefairy_doll
	cp16 CLEFAIRY_DOLL
	jp z, .mysterious_fossil_or_clefairy_doll

; if card is Asleep or Paralyzed, set carry and exit
; else, load the status in hTemp_ffa0
	pop af
	ldh [hTempPlayAreaLocation_ffa1], a
	ld a, DUELVARS_ARENA_CARD_STATUS
	get_turn_duelist_var
	ld b, a
	and CNF_SLP_PRZ
	cp ASLEEP
	jp z, .set_carry
	cp PARALYZED
	jp z, .set_carry
	ld a, b
	ldh [hTemp_ffa0], a
	ld a, $ff
	ldh [hTempRetreatCostCards], a

; check energy required to retreat
; if the cost is 0, retreat right away
	xor a ; PLAY_AREA_ARENA
	ldh [hTempPlayAreaLocation_ff9d], a
	call GetPlayAreaCardRetreatCost
	ld [wTempCardRetreatCost], a
	or a
	jp z, .retreat

; if cost > 0 and number of energy cards attached == cost
; discard them all
	xor a ; PLAY_AREA_ARENA
	call CreateArenaOrBenchEnergyCardList
	ld e, PLAY_AREA_ARENA
	call GetPlayAreaCardAttachedEnergies
	ld a, [wTotalAttachedEnergies]
	ld c, a
	ld a, [wTempCardRetreatCost]
	cp c
	jr nz, .choose_energy_discard

	ld hl, hTempRetreatCostCards
	ld de, wDuelTempList
.loop_select_all_cards
	ld a, [de]
	inc de
	ld [hli], a
	cp $ff
	jr nz, .loop_select_all_cards
	jp .retreat

; if cost > 0 and number of energy cards attached > cost
; choose energy cards to discard according to color
.choose_energy_discard
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call GetCardIDFromDeckIndex
	ld a, e
	ld [wTempCardID_d0a3 + 0], a
	ld a, d
	ld [wTempCardID_d0a3 + 1], a
	call LoadCardDataToBuffer1_FromCardID
	ld a, [wLoadedCard1Type]
	or TYPE_ENERGY
	ld [wTempCardType], a
	ld a, [wTempCardRetreatCost]
	ld c, a

; first, look for and discard any Recycle energy cards
	ld hl, wDuelTempList
	ld de, hTempRetreatCostCards
.loop_select_recycle_energy
	ld a, [hli]
	cp $ff
	jr z, .check_dce
	ld [de], a
	push de
	call GetCardIDFromDeckIndex
	cp16 RECYCLE_ENERGY
	pop de
	jr nz, .loop_select_recycle_energy
	ld a, [de]
	call RemoveCardFromDuelTempList
	dec hl
	inc de
	dec c
	jr nz, .loop_select_recycle_energy
	jr .end_retreat_list

; next, look for and discard Double Colorless energy
; if retreat cost is >= 2
.check_dce
	ld hl, wDuelTempList
	call CountCardsInDuelTempList
	call ShuffleCards
.loop_select_dce
	ld a, c
	cp 2
	jr c, .check_non_useful_energy
	ld a, [hli]
	cp $ff
	jr z, .check_non_useful_energy
	ld [de], a
	push de
	call GetCardIDFromDeckIndex
	cp16 DOUBLE_COLORLESS_ENERGY
	pop de
	jr nz, .loop_select_dce
	ld a, [de]
	call RemoveCardFromDuelTempList
	dec hl
	inc de
	dec c
	dec c
	jr nz, .loop_select_dce
	jr .end_retreat_list

; next, shuffle attached cards and discard energy cards
; that are not of the same type as the Pokémon
; the exception for this are cards that are needed for
; some attacks but are not of the same color as the Pokémon
; (i.e. Psyduck's Headache attack)
.check_non_useful_energy
	ld hl, wDuelTempList
	call CountCardsInDuelTempList
	call ShuffleCards
.loop_select_non_useful_energy
	ld a, [hli]
	cp $ff
	jr z, .discard_rest
	ld [de], a
	call CheckIfEnergyIsUseful
	jr c, .loop_select_non_useful_energy
	ld a, [de]
	call RemoveCardFromDuelTempList
	dec hl
	inc de
	dec c
	jr nz, .loop_select_non_useful_energy
	jr .end_retreat_list

; lastly, discard any card until
; cost requirement is met
.discard_rest
	ld hl, wDuelTempList
.loop_select_rest
	ld a, [hli]
	cp $ff
	jr z, .set_carry
	ld [de], a
	inc de
	push de
	call GetCardIDFromDeckIndex
	cp DOUBLE_COLORLESS_ENERGY ; bug, should be cp16 DOUBLE_COLORLESS_ENERGY
	pop de
	jr nz, .not_dce
	dec c
	jr z, .end_retreat_list
.not_dce
	dec c
	jr nz, .loop_select_rest

.end_retreat_list
	ld a, $ff
	ld [de], a

.retreat
	ld a, OPPACTION_ATTEMPT_RETREAT
	farcall AIMakeDecision
	xor a
	ld [wd032], a
	ret
.set_carry
	scf
	ret

; handle Mysterious Fossil and Clefairy Doll
; if there are bench Pokémon, use effect to discard card
; this is equivalent to using its Pokémon Power
.mysterious_fossil_or_clefairy_doll
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	cp 2
	jr nc, .has_bench
	; doesn't have any bench
	pop af
	jr .set_carry
.has_bench
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	ldh [hTempCardIndex_ff9f], a
	xor a ; PLAY_AREA_ARENA
	ldh [hTemp_ffa0], a
	ld a, OPPACTION_USE_PKMN_POWER
	farcall AIMakeDecision
	pop af
	ldh [hTempPlayAreaLocation_ffa1], a
	ld a, OPPACTION_EXECUTE_PKMN_POWER_EFFECT
	farcall AIMakeDecision
	ld a, OPPACTION_DUEL_MAIN_SCENE
	farcall AIMakeDecision
	or a
	ret

; copies an $ff-terminated list from hl to de.
; preserves bc
; input:
;	hl = address from which to start copying the data
;	de = where to copy the data
CopyListWithFFTerminatorFromHLToDE_Bank5:
	ld a, [hli]
	ld [de], a
	cp $ff
	ret z
	inc de
	jr CopyListWithFFTerminatorFromHLToDE_Bank5

; determine whether AI plays
; basic cards from hand
AIDecidePlayPokemonCard:
	call CreateHandCardList
	call SortTempHandByIDList
	ld hl, wDuelTempList
	ld de, wTempCardList
	call CopyListWithFFTerminatorFromHLToDE_Bank5
	ld hl, wTempCardList
.loop_hand_cards
	ld a, [hli]
	cp $ff
	jp z, AIDecideEvolution

	ld [wTempAIPokemonCard], a
	push hl
	call LoadCardDataToBuffer1_FromDeckIndex
	ld a, [wLoadedCard1Type]
	cp TYPE_ENERGY
	jp nc, .skip
	; skip non-pokemon cards

	ld a, [wLoadedCard1Stage]
	or a
	jp nz, .skip
	; skip non-basic pokemon

	farcall Func_29e02
	ld [wAIScore], a

	ld a, [wMaxNumPlayAreaPokemon]
	cp 4
	jr z, .small_bench
; normal conditions, if Play Area has more than 3 Pokémon,
; decrease AI score, else increase AI score
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	cp 4
	jr c, .has_space_in_bench
	ld a, 20
	call AIDiscourage
	jr .check_defending_can_ko

.small_bench
; small bench rules, if Play Area has more than 2 Pokémon,
; decrease AI score, else increase AI score
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	cp 3
	jr c, .has_space_in_bench
	ld a, 20
	call AIDiscourage
	jr .check_defending_can_ko

.has_space_in_bench
	ld a, 50
	call AIEncourage

; if defending Pokémon can KO active card, increase AI score
.check_defending_can_ko
	xor a ; PLAY_AREA_ARENA
	ldh [hTempPlayAreaLocation_ff9d], a
	farcall CheckIfDefendingPokemonCanKnockOut
	jr nc, .check_energy_cards
	ld a, 20
	call AIEncourage

; if energy cards are found in hand
; for this card's attacks, raise AI score
.check_energy_cards
	ld a, [wTempAIPokemonCard]
	farcall GetAttacksEnergyCostBits
	farcall CheckEnergyFlagsNeededInList
	jr nc, .check_evolution_hand
	ld a, 20
	call AIEncourage

; if evolution card is found in hand
; for this card, raise AI score
.check_evolution_hand
	ld a, [wTempAIPokemonCard]
	farcall CheckIfPokemonEvolutionIsFoundInHand
	jr nc, .check_evolution_deck
	ld a, 20
	call AIEncourage

; if evolution card is found in deck
; for this card, raise AI score
.check_evolution_deck
	ld a, [wTempAIPokemonCard]
	farcall $a, $5921 ; Func_29921 ; CheckForEvolutionInDeck
	jr nc, .check_score
	ld a, 10
	call AIEncourage

; if AI score is >= 180, play card from hand
.check_score
	ld a, [wAIScore]
	cp 180
	jr c, .skip
	ld a, [wTempAIPokemonCard]
	ldh [hTemp_ffa0], a
	call CheckIfCardCanBePlayed
	jr c, .skip
	ld a, OPPACTION_PLAY_BASIC_PKMN
	farcall AIMakeDecision
	ld a, [wTempAIPokemonCard]
	ldh [hTempCardIndex_ff9f], a
	ldh a, [hTempPlayAreaLocation_ff9d]
	ldh [hTemp_ffa0], a
	ld a, OPPACTION_UNK_18
	farcall AIMakeDecision
	ld a, [wcd18]
	or a
	jr z, .skip
	farcall AIHandlePkmnPowersWhenPlayingPkmnFromHand
	ld a, OPPACTION_UNK_19
	farcall AIMakeDecision
	jr c, .done
.skip
	pop hl
	jp .loop_hand_cards
.done
	pop hl
	ret

; determine whether AI evolves
; Pokémon in the Play Area
AIDecideEvolution:
	bank1call IsPrehistoricPowerActive
	jp c, .done ; skip if Prehistoric is active

	call CreateHandCardList
	ld hl, wDuelTempList
	ld de, wTempCardList
	call CopyListWithFFTerminatorFromHLToDE_Bank5
	ld hl, wTempCardList

.next_hand_card
	ld a, [hli]
	cp $ff
	jp z, .done
	ld [wTempAIPokemonCard], a

; load evolution data to buffer1
; skip if it's not a Pokémon card
; and if it's a basic stage card
	push hl
	ld a, [wTempAIPokemonCard] ; unnecessary
	call LoadCardDataToBuffer1_FromDeckIndex
	ld a, [wLoadedCard1Type]
	cp TYPE_ENERGY
	jp nc, .done_hand_card
	ld a, [wLoadedCard1Stage]
	or a
	jp z, .done_hand_card

; start looping Pokémon in Play Area
; to find a card to evolve
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	ld c, a
	ld b, 0
.next_bench_pokemon
	push bc
	ld e, b
	ld a, [wTempAIPokemonCard]
	ld d, a
	call CheckIfCanEvolveInto
	pop bc
	push bc
	jp c, .done_bench_pokemon

	ld a, b
	call Func_16af1
	jr nc, .done_bench_pokemon

	ld a, [wTempAI]
	ldh [hTempPlayAreaLocation_ffa1], a
	ld a, [wTempAIPokemonCard]
	ldh [hTemp_ffa0], a
	ld a, OPPACTION_EVOLVE_PKMN
	farcall AIMakeDecision
	ld a, [wTempAIPokemonCard]
	ldh [hTempCardIndex_ff9f], a
	ldh a, [hTempPlayAreaLocation_ff9d]
	ldh [hTemp_ffa0], a
	ld a, OPPACTION_UNK_18
	farcall AIMakeDecision
	ld a, [wcd18]
	or a
	jr z, .asm_16adf
	farcall AIHandlePkmnPowersWhenPlayingPkmnFromHand
	ld a, OPPACTION_UNK_19
	farcall AIMakeDecision
	jr c, .asm_16aee

.asm_16adf
	pop bc
	jr .done_hand_card
.done_bench_pokemon
	pop bc
	inc b
	dec c
	jp nz, .next_bench_pokemon
.done_hand_card
	pop hl
	jp .next_hand_card
.done
	or a
	ret

.asm_16aee
	pop bc
	pop hl
	ret

Func_16af1:
; store this Play Area location in wTempAI
; and initialize the AI score
	ld [wTempAI], a
	ldh [hTempPlayAreaLocation_ff9d], a
	farcall $a, $597a
	ld [wAIScore], a

; check if the card can use any attacks
; and if any of those attacks can KO
	xor a
	ld [wd07b], a
	ld [wSelectedAttack], a ; FIRST_ATTACK_OR_PKMN_POWER
	call CheckIfSelectedAttackIsUnusable
	jr nc, .can_attack
	ld a, SECOND_ATTACK
	ld [wSelectedAttack], a
	call CheckIfSelectedAttackIsUnusable
	jr c, .cant_attack_or_ko
.can_attack
	ld a, $01
	ld [wd061], a
	call CheckIfAnyAttackKnocksOutDefendingCard
	jr nc, .check_evolution_attacks
	call CheckIfSelectedAttackIsUnusable
	jr c, .check_evolution_attacks
	ld a, $01
	ld [wd063], a
	jr .check_evolution_attacks
.cant_attack_or_ko
	xor a
	ld [wd061], a
	ld [wd063], a

; check evolution to see if it can use any of its attacks:
; if it can, raise AI score;
; if it can't, decrease AI score and if an energy card that is needed
; can be played from the hand, raise AI score.
.check_evolution_attacks
	ld a, [wTempAI]
	add DUELVARS_ARENA_CARD
	get_turn_duelist_var
	push af
	ld a, [wTempAIPokemonCard]
	ld [hl], a
	ld a, [wTempAI]
	add DUELVARS_ARENA_CARD_HP
	get_turn_duelist_var
	push af
	ld a, [wTempAI]
	ld e, a
	call GetCardDamageAndMaxHP
	push af
	ld a, [wTempAIPokemonCard]
	push hl
	call LoadCardDataToBuffer2_FromDeckIndex
	pop hl
	ld a, [wLoadedCard2HP]
	pop bc
	sub b
	ld [hl], a
	xor a ; FIRST_ATTACK_OR_PKMN_POWER
	ld [wSelectedAttack], a
	call CheckIfSelectedAttackIsUnusable
	jr nc, .evolution_can_attack
	ld a, SECOND_ATTACK
	ld [wSelectedAttack], a
	call CheckIfSelectedAttackIsUnusable
	jr c, .evolution_cant_attack
.evolution_can_attack
	ld a, 5
	call AIEncourage
	jr .check_evolution_ko
.evolution_cant_attack
	ld a, [wd061]
	or a
	jr z, .check_evolution_ko
	ld a, 2
	call AIDiscourage
	ld a, [wAlreadyPlayedEnergy]
	or a
	jr nz, .check_evolution_ko
	farcall LookForEnergyNeededInHand
	jr nc, .check_evolution_ko
	ld a, 7
	call AIEncourage

; if it's an active card:
; if evolution can't KO but the current card can, lower AI score;
; if evolution can KO as well, raise AI score.
.check_evolution_ko
	ld a, [wd061]
	or a
	jr z, .check_defending_can_ko_evolution
	ld a, [wTempAI]
	or a
	jr nz, .check_defending_can_ko_evolution
	call CheckIfAnyAttackKnocksOutDefendingCard
	jr nc, .evolution_cant_ko
	call CheckIfSelectedAttackIsUnusable
	jr nc, .asm_16baa
	farcall LookForEnergyNeededForAttackInHand
	jr nc, .evolution_cant_ko
.asm_16baa
	ld a, 5
	call AIEncourage
	jr .check_defending_can_ko_evolution
.evolution_cant_ko
	ld a, [wd063]
	or a
	jr z, .check_defending_can_ko_evolution
	ld a, 20
	call AIDiscourage

; if defending Pokémon can KO evolution, lower AI score
.check_defending_can_ko_evolution
	ld a, [wTempAI]
	or a
	jr nz, .check_mr_mime
	xor a ; PLAY_AREA_ARENA
	ldh [hTempPlayAreaLocation_ff9d], a
	farcall CheckIfDefendingPokemonCanKnockOut
	jr nc, .check_mr_mime
	ld a, 10
	call AIDiscourage
	ld a, $01
	ld [wd07b], a

; if evolution can't damage player's Mr Mime, lower AI score
.check_mr_mime
	ld a, [wTempAIPokemonCard]
	call GetCardIDFromDeckIndex
	cp16 MUK
	jr z, .check_defending_can_ko
	ld a, [wTempAI]
	farcall $13, $4437
	jr c, .check_defending_can_ko
	ld a, 30
	call AIDiscourage

; if defending Pokémon can KO current card, raise AI score
.check_defending_can_ko
	ld a, [wTempAI]
	add DUELVARS_ARENA_CARD_HP
	get_turn_duelist_var
	pop af
	ld [hl], a
	ld a, [wTempAI]
	add DUELVARS_ARENA_CARD
	get_turn_duelist_var
	pop af
	ld [hl], a
	ld a, [wTempAI]
	or a
	jr nz, .check_2nd_stage_hand
	xor a ; PLAY_AREA_ARENA
	ldh [hTempPlayAreaLocation_ff9d], a
	farcall CheckIfDefendingPokemonCanKnockOut
	jr nc, .check_status
	; encourage unless it can KO the evolution as well
	ld a, [wd07b]
	or a
	jr nz, .check_status
	ld a, 5
	call AIEncourage

; if current card has a status condition, raise AI score
.check_status
	ld a, DUELVARS_ARENA_CARD_STATUS
	get_turn_duelist_var
	or a
	jr z, .check_2nd_stage_hand
	ld a, 4
	call AIEncourage

; if hand has 2nd stage card to evolve evolution card, raise AI score
.check_2nd_stage_hand
	ld a, [wTempAIPokemonCard]
	farcall CheckIfPokemonEvolutionIsFoundInHand
	jr nc, .check_2nd_stage_deck
	ld a, 2
	call AIEncourage
	jr .check_damage

; if deck has 2nd stage card to evolve evolution card, raise AI score
.check_2nd_stage_deck
	ld a, [wTempAIPokemonCard]
	farcall $a, $5921
	jr nc, .check_damage
	ld a, 1
	call AIEncourage

; decrease AI score proportional to damage
; AI score -= floor(Damage / 40)
.check_damage
	ld a, [wTempAI]
	ld e, a
	call GetCardDamageAndMaxHP
	or a
	jr z, .check_mysterious_fossil
	srl a
	srl a
	call ConvertHPToCounters
	call AIDiscourage

; if is Mysterious Fossil or
; wLoadedCard1AIInfo is AI_INFO_ENCOURAGE_EVO,
; raise AI score
.check_mysterious_fossil
	ld a, [wTempAI]
	add DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call LoadCardDataToBuffer1_FromDeckIndex
	ld hl, wLoadedCard1ID
	cphl MYSTERIOUS_FOSSIL
	jr z, .mysterious_fossil
	ld a, [wLoadedCard1AIInfo]
	; bug, should mask out HAS_EVOLUTION flag first
	cp AI_INFO_ENCOURAGE_EVO
	jr nz, .i_love_pikachu_deck
	ld a, 2
	call AIEncourage
	jr .i_love_pikachu_deck

.mysterious_fossil
	ld a, 5
	call AIEncourage

; in I Love Pikachu Deck, decrease AI score for evolving Pikachu
.i_love_pikachu_deck
	ld a, [wOpponentDeckID]
	cp I_LOVE_PIKACHU_DECK_ID
	jr nz, .check_score
	ld hl, wLoadedCard1ID
	cphl PIKACHU_LV5
	jr z, .pikachu
	cphl PIKACHU_LV13
	jr z, .pikachu
	cphl PIKACHU_LV16
	jr z, .pikachu
	cphl PIKACHU_ALT_LV16
	jr nz, .check_score
.pikachu
	ld a, 3
	call AIDiscourage

; if AI score >= 133, return carry
.check_score
	ld a, [wAIScore]
	cp 133
	ccf
	ret

; goes through $00 terminated list pointed
; by wAICardListPlayFromHandPriority and compares it to each card in hand.
; Sorts the hand in wDuelTempList so that the found card IDs
; are in the same order as the list pointed by de.
SortTempHandByIDList:
	ld a, [wAICardListPlayFromHandPriority + 1]
	or a
	ret z ; return if list is empty

; start going down the ID list
	ld d, a
	ld a, [wAICardListPlayFromHandPriority]
	ld e, a
	ld c, 0
.loop_list_id
; get this item's ID
; if $00, list has ended
	ld a, [de]
	ld b, a
	inc de
	ld a, [de]
	inc de
	push de
	ld e, b
	ld d, a
	call CheckIfCardIDIsZero_Bank5
	jr c, .done ; return when list is over
	ld hl, wDuelTempList
	ld b, 0
	add hl, bc

; search in the hand card list
.next_hand_card
	ld a, [hl]
	ldh [hTempCardIndex_ff98], a
	cp -1
	jr nz, .valid_card
	pop de
	jr .loop_list_id
.valid_card
	push bc
	push de
	call GetCardIDFromDeckIndex
	ld c, e
	ld a, d
	pop de
	cp d
	jr nz, .not_same
	ld a, c
	cp e
	jr nz, .not_same

; found
; swap this hand card with the spot
; in hand corresponding to c
	pop bc
	push bc
	push hl
	ld b, 0
	ld hl, wDuelTempList
	add hl, bc
	ld b, [hl]
	ldh a, [hTempCardIndex_ff98]
	ld [hl], a
	pop hl
	ld [hl], b
	pop bc
	inc c
	inc hl
	jr .next_hand_card
.not_same
	pop bc
	inc hl
	jr .next_hand_card
.done
	pop de
	ret
; 0x16d18

SECTION "Bank 5@6d31", ROMX[$6d31], BANK[$5]

; have AI choose an energy card to play, but do not play it.
; does not consider whether the cards have evolutions to be played.
; return carry if an energy card is chosen to use in any Play Area card,
; and if so, return its Play Area location in hTempPlayAreaLocation_ff9d.
AIProcessButDontPlayEnergy_SkipEvolution:
	ld a, AI_ENERGY_FLAG_DONT_PLAY | AI_ENERGY_FLAG_SKIP_EVOLUTION
	ld [wAIEnergyAttachLogicFlags], a

; backup wPlayAreaAIScore in wTempPlayAreaAIScore.
	ld de, wTempPlayAreaAIScore
	ld hl, wPlayAreaAIScore
	ld b, MAX_PLAY_AREA_POKEMON
.loop
	ld a, [hli]
	ld [de], a
	inc de
	dec b
	jr nz, .loop

	ld a, [wAIScore]
	ld [de], a

	jr AIProcessEnergyCards

; have AI choose an energy card to play, but do not play it.
; does not consider whether the cards have evolutions to be played.
; return carry if an energy card is chosen to use in any Bench card,
; and if so, return its Play Area location in hTempPlayAreaLocation_ff9d.
AIProcessButDontPlayEnergy_SkipEvolutionAndArena:
	ld a, AI_ENERGY_FLAG_DONT_PLAY | AI_ENERGY_FLAG_SKIP_EVOLUTION | AI_ENERGY_FLAG_SKIP_ARENA_CARD
	ld [wAIEnergyAttachLogicFlags], a

; backup wPlayAreaAIScore in wTempPlayAreaAIScore.
	ld de, wTempPlayAreaAIScore
	ld hl, wPlayAreaAIScore
	ld b, MAX_PLAY_AREA_POKEMON
.loop
	ld a, [hli]
	ld [de], a
	inc de
	dec b
	jr nz, .loop

	ld a, [wAIScore]
	ld [de], a

	jr AIProcessEnergyCards

; copies wTempPlayAreaAIScore to wPlayAreaAIScore
; and loads wAIScore with value in wTempAIScore.
; identical to RetrievePlayAreaAIScoreFromBackup2.
RetrievePlayAreaAIScoreFromBackup1:
	push af
	ld de, wPlayAreaAIScore
	ld hl, wTempPlayAreaAIScore
	ld b, MAX_PLAY_AREA_POKEMON
.loop
	ld a, [hli]
	ld [de], a
	inc de
	dec b
	jr nz, .loop
	ld a, [hl]
	ld [wAIScore], a
	pop af
	ret

; have AI decide whether to play energy card from hand
; and determine which card is best to attach it.
AIProcessAndTryToPlayEnergy:
	xor a
	ld [wAIEnergyAttachLogicFlags], a

.has_logic_flags
	bank1call CreateEnergyCardListFromHand
	jr nc, AIProcessEnergyCards

; no energy
	ld a, [wAIEnergyAttachLogicFlags]
	or a
	jr z, .exit
	jp RetrievePlayAreaAIScoreFromBackup1
.exit
	or a
	ret

; have AI decide whether to play energy card
; and determine which card is best to attach it.
AIProcessEnergyCards:
; initialize Play Area AI score
	ld a, $80
	ld b, MAX_PLAY_AREA_POKEMON
	ld hl, wPlayAreaEnergyAIScore
.loop
	ld [hli], a
	dec b
	jr nz, .loop

	farcall HandleAIEnergyScoringForRepeatedBenchPokemon

; start the main Play Area loop
	ld b, PLAY_AREA_ARENA
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	ld c, a

.loop_play_area
	push bc
	ld a, b
	ldh [hTempPlayAreaLocation_ff9d], a
	farcall AIDeckSpecificEnergyLogic
	ld [wAIScore], a
	ld a, $ff
	ld [wTempAI], a
	ld a, [wAIEnergyAttachLogicFlags]
	and AI_ENERGY_FLAG_SKIP_EVOLUTION
	jr nz, .check_venusaur

; check if energy needed is found in hand
; and if there's an evolution in hand or deck
; and if so, add to AI score
	call CreateHandCardList
	ldh a, [hTempPlayAreaLocation_ff9d]
	add DUELVARS_ARENA_CARD
	get_turn_duelist_var
	ld [wd061], a
	farcall GetAttacksEnergyCostBits
	ld hl, wDuelTempList
	farcall CheckEnergyFlagsNeededInList
	jp nc, .store_score
	ld a, [wd061]
	farcall CheckIfPokemonEvolutionIsFoundInHand
	jr nc, .check_venusaur
	ld [wTempAI], a ; store evolution card found
	ld a, 2
	call AIEncourage
	jr .check_venusaur ; useless jump

; if Energy Trans is active, add to AI score
.check_venusaur
	bank1call CheckGoopGasAttackAndToxicGasActive
	jr c, .check_if_active
	ld de, VENUSAUR_LV67
	bank1call CountTurnDuelistPokemonWithActivePkmnPower
	jr nc, .check_if_active
	ld a, 1
	call AIEncourage

.check_if_active
	ldh a, [hTempPlayAreaLocation_ff9d]
	or a
	jr nz, .bench

; arena
	ld a, [wAIBarrierFlagCounter]
	bit AI_MEWTWO_MILL_F, a
	jr z, .add_to_score

; subtract from score instead
; if Player is running MewtwoLv53 mill deck.
	ld a, 5
	call AIDiscourage
	jr .check_defending_can_ko

.add_to_score
	ld a, 4
	call AIEncourage

; lower AI score if poison/double poison
; will KO Pokémon between turns
; or if the defending Pokémon can KO
	ld a, DUELVARS_ARENA_CARD_HP
	get_turn_duelist_var
	call ConvertHPToCounters
	cp 3
	jr nc, .check_defending_can_ko
	; hp < 30
	cp 2
	jr z, .has_20_hp
	; hp = 10
	ld a, DUELVARS_ARENA_CARD_STATUS
	get_turn_duelist_var
	and POISONED
	jr z, .check_defending_can_ko
	jr .poison_will_ko
.has_20_hp
	ld a, DUELVARS_ARENA_CARD_STATUS
	get_turn_duelist_var
	and DOUBLE_POISONED
	jr z, .check_defending_can_ko
.poison_will_ko
	ld a, 10
	call AIDiscourage
	jr .check_bench
.check_defending_can_ko
	farcall CheckIfDefendingPokemonCanKnockOut
	jr nc, .ai_score_bonus
	ld a, 10
	call AIDiscourage

; if either poison will KO or defending Pokémon can KO,
; check if there are bench Pokémon, if there are not, add AI score
; otherwise, also add if player is on last prize card
.check_bench
	farcall CountPlayAreaPokemonExcludingTrainerPokemon
	dec a
	jr z, .last_pokemon
	call SwapTurn
	call CountPrizes
	call SwapTurn
	cp 1
	jr nz, .ai_score_bonus
.last_pokemon
	ld a, 6
	call AIEncourage
	jr .ai_score_bonus

.bench
; add score if the score calculated for Arena card is less than $85
	ld a, [wPlayAreaAIScore + PLAY_AREA_ARENA]
	cp $85
	jr nc, .check_bench_hp
	ld a, 4
	call AIEncourage

.check_bench_hp
; lower AI score by 3 - (bench HP)/10
; if bench HP < 30
	ldh a, [hTempPlayAreaLocation_ff9d]
	add DUELVARS_ARENA_CARD_HP
	get_turn_duelist_var
	call ConvertHPToCounters
	cp 3
	jr nc, .ai_score_bonus
; hp < 30
	ld b, a
	ld a, 3
	sub b
	call AIDiscourage

; check list in wAICardListEnergyBonus
.ai_score_bonus
	ld a, [wAICardListEnergyBonus + 1]
	or a
	jr z, .check_boss_deck ; is null
	ld h, a
	ld a, [wAICardListEnergyBonus]
	ld l, a

	push hl
	ldh a, [hTempPlayAreaLocation_ff9d]
	add DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call GetCardIDFromDeckIndex
	pop hl

.loop_id_list
	push de
	ld a, [hli]
	ld e, a
	ld c, a
	ld a, [hli]
	ld d, a
	ld b, a
	call CheckIfCardIDIsZero_Bank5
	pop de
	jp c, .check_boss_deck ; can be jr
	ld a, b
	cp d
	jr nz, .next_id
	ld a, c
	cp e
	jr nz, .next_id

	; number of attached energy cards
	ld a, [hli]
	ld b, a
	push de
	ldh a, [hTempPlayAreaLocation_ff9d]
	ld e, a
	call GetPlayAreaCardAttachedEnergies
	ld a, [wTotalAttachedEnergies]
	pop de
	cp b
	jr c, .check_id_score
	; already reached target number of energy cards
	ld a, 30
	call AIDiscourage
	jr .check_boss_deck

.check_id_score
	ld a, [hli]
	cp $80
	jr c, .decrease_score_1
	sub $80
	call AIEncourage
	jr .check_boss_deck

.decrease_score_1
	ld b, a
	ld a, $80
	sub b
	call AIDiscourage
	jr .check_boss_deck

.next_id
	inc hl
	inc hl
	jr .loop_id_list

.check_boss_deck
	farcall CheckIfNotABossDeckID
	jr c, .skip_boss_deck

	; applies wPlayAreaEnergyAIScore
	ldh a, [hTempPlayAreaLocation_ff9d]
	ld c, a
	ld b, $00
	ld hl, wPlayAreaEnergyAIScore
	add hl, bc
	ld a, [hl]
	cp $80
	jr c, .decrease_score_2
	sub $80
	call AIEncourage
	jr .skip_boss_deck

.decrease_score_2
	ld b, a
	ld a, $80
	sub b
	call AIDiscourage

.skip_boss_deck
	ld a, 1
	ld [wd07c], a

; add AI score for both attacks,
; according to their energy requirements.
	xor a ; first attack
	call DetermineAIScoreOfAttackEnergyRequirement
	ld a, SECOND_ATTACK
	call DetermineAIScoreOfAttackEnergyRequirement

; store bench score for this card.
.store_score
	ldh a, [hTempPlayAreaLocation_ff9d]
	ld c, a
	ld b, $00
	ld hl, wPlayAreaAIScore
	add hl, bc
	ld a, [wAIScore]
	ld [hl], a
	pop bc
	inc b
	dec c
	jp nz, .loop_play_area

; the Play Area loop is over and the score
; for each card has been calculated.
; now to determine the highest score.
	call FindPlayAreaCardWithHighestAIScore
	jp nc, .not_found

	ld a, [wAIEnergyAttachLogicFlags]
	or a
	jr z, .play_card
	scf
	jp RetrievePlayAreaAIScoreFromBackup1

.play_card
	bank1call CreateEnergyCardListFromHand
	jp AITryToPlayEnergyCard ; AITryToPlayEnergyCard

.not_found
	ld a, [wAIEnergyAttachLogicFlags]
	or a
	jr z, .no_carry
	jp RetrievePlayAreaAIScoreFromBackup1
.no_carry
	or a
	ret

; checks score related to selected attack,
; in order to determine whether to play energy card.
; the AI score is increased/decreased accordingly.
; input:
;	a = attack to check.
DetermineAIScoreOfAttackEnergyRequirement:
	ld [wSelectedAttack], a
	call CheckEnergyNeededForAttack
	jp c, .not_enough_energy
	ld a, ATTACK_FLAG2_ADDRESS | ATTACHED_ENERGY_BOOST_F
	call CheckLoadedAttackFlag
	jr c, .attached_energy_boost
	ld a, ATTACK_FLAG2_ADDRESS | DISCARD_ENERGY_F
	call CheckLoadedAttackFlag
	jr c, .discard_energy
	farcall Func_3926a
	jr c, .check_surplus_energy
	jp .check_evolution

.attached_energy_boost
	ld a, [wLoadedAttackEffectParam]
	cp MAX_ENERGY_BOOST_IS_LIMITED
	jr z, .check_surplus_energy

	; is MAX_ENERGY_BOOST_IS_NOT_LIMITED,
	; which is equal to 3, add to score.
	call AIEncourage
	jp .check_evolution

.check_surplus_energy
	farcall CheckIfNoSurplusEnergyForAttack
	jr c, .asm_166cd
	cp 3 ; check how much surplus energy
	jr c, .asm_166cd

.asm_166c5
	farcall Func_392db
	jr c, .asm_166cd
	ld a, 5
	call AIDiscourage
	jp .check_evolution

.asm_166cd
	ld a, 2
	call AIEncourage

; check whether attack has ATTACHED_ENERGY_BOOST flag
; and add to AI score if attaching another energy
; will KO defending Pokémon.
; add more to score if this is currently active Pokémon.
	ld a, ATTACK_FLAG2_ADDRESS | ATTACHED_ENERGY_BOOST_F
	call CheckLoadedAttackFlag
	jp nc, .check_evolution
	ld a, [wSelectedAttack]
	call EstimateDamage_VersusDefendingCard
	ld a, DUELVARS_ARENA_CARD_HP
	call GetNonTurnDuelistVariable
	ld hl, wDamage
	sub [hl]
	jp c, .check_evolution
	jp z, .check_evolution
	ld a, [wDamage]
	add 10 ; boost gained by attaching another energy card
	ld b, a
	ld a, DUELVARS_ARENA_CARD_HP
	call GetNonTurnDuelistVariable
	sub b
	jr c, .attaching_kos_player
	jp nz, .check_evolution

.attaching_kos_player
	ld a, 20
	call AIEncourage
	ldh a, [hTempPlayAreaLocation_ff9d]
	or a
	jp nz, .check_evolution
	ld a, 10
	call AIEncourage
	jp .check_evolution

; checks if there is surplus energy for attack
; that discards attached energy card.
; if current card is ZapdosLv64, don't add to score.
; if there is no surplus energy, encourage playing energy.
.discard_energy
	ld hl, wLoadedCard1ID
	cphl ZAPDOS_LV64
	jp z, .check_evolution
	farcall CheckIfNoSurplusEnergyForAttack
	jr c, .asm_166cd
	jr .asm_166c5

.not_enough_energy
	ld a, ATTACK_FLAG2_ADDRESS | FLAG_2_BIT_5_F
	call CheckLoadedAttackFlag
	jr nc, .check_color_needed
	ld a, 5
	call AIDiscourage
	ret

.check_color_needed
	push bc
	ld hl, wd07c
	ld a, [hl]
	call AIEncourage
	dec [hl]
	pop bc

; if the energy card color needed is in hand, increase AI score.
; if a colorless card is needed, increase AI score.
	ld a, b
	or a
	jr z, .check_colorless_needed
	call LookForCardIDInHand
	jr c, .check_colorless_needed
	ld a, 4
	call AIEncourage
	jr .check_total_needed
.check_colorless_needed
	ld a, c
	or a
	jr z, .check_evolution
	ld a, 3
	call AIEncourage

.check_total_needed
	; if only one energy card is needed for attack,
	; encourage playing energy card.
	ld a, b
	add c
	dec a
	jr z, .need_1_energy

	; if 2 energy cards are needed for attack,
	; encourage if it's Arena card
	dec a
	jr nz, .check_evolution
	ldh a, [hTempPlayAreaLocation_ff9d]
	or a
	jr nz, .check_evolution
	ld a, 3
	call AIEncourage

	; if only 2 colorless energy cards are needed
	; and has double colorless in hand, encourage
	ld a, 2
	cp c
	jr nz, .check_evolution
	ld de, DOUBLE_COLORLESS_ENERGY
	farcall LookForCardIDInHandList
	jr nc, .check_evolution
	ld a, 1
	call AIEncourage
	jr .check_if_can_ko

.need_1_energy
	ld a, 3
	call AIEncourage
	ldh a, [hTempPlayAreaLocation_ff9d]
	or a
	jr nz, .check_if_can_ko
	; encourage more if is Arena card
	ld a, 1
	call AIEncourage

.check_if_can_ko
; if the attack KOs player and this is the active card, add to AI score.
	ldh a, [hTempPlayAreaLocation_ff9d] ; useless
	ld a, [wSelectedAttack]
	call EstimateDamage_VersusDefendingCard
	ld a, DUELVARS_ARENA_CARD_HP
	call GetNonTurnDuelistVariable
	ld hl, wDamage
	sub [hl]
	jr z, .atk_kos_defending
	jr nc, .check_evolution
.atk_kos_defending
	ld a, 7
	call AIEncourage
	ldh a, [hTempPlayAreaLocation_ff9d]
	or a
	jr nz, .check_evolution
	; encourage more if is Arena card
	ld a, 20
	call AIEncourage

.check_evolution
	ld a, [wTempAI] ; evolution in hand
	cp $ff
	ret z

; temporarily replace this card with evolution in hand.
	ld b, a
	ldh a, [hTempPlayAreaLocation_ff9d]
	add DUELVARS_ARENA_CARD
	get_turn_duelist_var
	push af
	ld [hl], b

; check for energy still needed for evolution to attack.
; if FLAG_2_BIT_5 is not set, check what color is needed.
; if the energy card color needed is in hand, increase AI score.
; if a colorless card is needed, increase AI score.
	call CheckEnergyNeededForAttack
	jr nc, .done
	ld a, ATTACK_FLAG2_ADDRESS | FLAG_2_BIT_5_F
	call CheckLoadedAttackFlag
	jr c, .done
	ld a, b
	or a
	jr z, .check_colorless_needed_evo
	call LookForCardIDInHand
	jr c, .check_colorless_needed_evo
	ld a, 2
	call AIEncourage
	jr .done
.check_colorless_needed_evo
	ld a, c
	or a
	jr z, .done
	ld a, 1
	call AIEncourage

; recover the original card in the Play Area location.
.done
	ldh a, [hTempPlayAreaLocation_ff9d]
	add DUELVARS_ARENA_CARD
	get_turn_duelist_var
	pop af
	ld [hl], a
	ret

; returns in hTempPlayAreaLocation_ff9d the Play Area location
; of the card with the highest Play Area AI score, unless
; the highest score is below $85.
; if it succeeds in return a card location, set carry.
; if AI_ENERGY_FLAG_SKIP_ARENA_CARD is set in wAIEnergyAttachLogicFlags
; doesn't include the Arena card and there's no minimum score.
FindPlayAreaCardWithHighestAIScore:
	ld a, [wAIEnergyAttachLogicFlags]
	and AI_ENERGY_FLAG_SKIP_ARENA_CARD
	jr nz, .only_bench

	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	ld b, a
	ld c, PLAY_AREA_ARENA
	ld e, c
	ld d, c
	ld hl, wPlayAreaAIScore
; find highest Play Area AI score.
.loop_1
	ld a, [hli]
	cp e
	jr c, .next_1
	jr z, .next_1
	ld e, a ; overwrite highest score found
	ld d, c ; overwrite Play Area of highest score
.next_1
	inc c
	dec b
	jr nz, .loop_1

; if highest AI score is below $85, return no carry.
; else, store Play Area location and return carry.
	ld a, e
	cp $85
	jr c, .not_enough_score
	ld a, d
	ldh [hTempPlayAreaLocation_ff9d], a
	scf
	ret
.not_enough_score
	or a
	ret

; same as above but only check bench Pokémon scores.
.only_bench
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	dec a
	jr z, .no_carry

	ld b, a
	ld e, 0
	ld c, PLAY_AREA_BENCH_1
	ld d, c
	ld hl, wPlayAreaAIScore + 1
.loop_2
	ld a, [hli]
	cp e
	jr c, .next_2
	jr z, .next_2
	ld e, a ; overwrite highest score found
	ld d, c ; overwrite Play Area of highest score
.next_2
	inc c
	dec b
	jr nz, .loop_2

; in this case, there is no minimum threshold AI score.
	ld a, d
	ldh [hTempPlayAreaLocation_ff9d], a
	scf
	ret
.no_carry
	or a
	ret

; called after the AI has decided which card to attach
; energy from hand. AI does checks to determine whether
; this card needs more energy or not, and chooses the
; right energy card to play. If the card is played,
; return with carry flag set.
AITryToPlayEnergyCard:
; check if energy cards are still needed for attacks.
; if first attack doesn't need, test for the second attack.
	xor a
	ld [wTempAI], a
	ld [wSelectedAttack], a ; FIRST_ATTACK_OR_PKMN_POWER
	call CheckEnergyNeededForAttack
	jr nc, .second_attack
	ld a, b
	or a
	jr nz, .check_deck
	ld a, c
	or a
	jr nz, .check_deck

.second_attack
	ld a, SECOND_ATTACK
	ld [wSelectedAttack], a
	call CheckEnergyNeededForAttack
	jr nc, .check_discard_or_energy_boost
	ld a, b
	or a
	jr nz, .check_deck
	ld a, c
	or a
	jr nz, .check_deck

; neither attack needs energy cards to be used.
; check whether these attacks can be given
; extra energy cards for their effects.
.check_discard_or_energy_boost
	ld a, $01
	ld [wTempAI], a

; for both attacks, check if it has the effect of
; discarding energy cards or attached energy boost.
	xor a ; FIRST_ATTACK_OR_PKMN_POWER
	ld [wSelectedAttack], a
	call CheckEnergyNeededForAttack
	ld a, ATTACK_FLAG2_ADDRESS | ATTACHED_ENERGY_BOOST_F
	call CheckLoadedAttackFlag
	jr c, .energy_boost_or_discard_energy
	ld a, ATTACK_FLAG2_ADDRESS | DISCARD_ENERGY_F
	call CheckLoadedAttackFlag
	jr c, .energy_boost_or_discard_energy

	ld a, SECOND_ATTACK
	ld [wSelectedAttack], a
	call CheckEnergyNeededForAttack
	ld a, ATTACK_FLAG2_ADDRESS | ATTACHED_ENERGY_BOOST_F
	call CheckLoadedAttackFlag
	jr c, .energy_boost_or_discard_energy
	ld a, ATTACK_FLAG2_ADDRESS | DISCARD_ENERGY_F
	call CheckLoadedAttackFlag
	jr c, .energy_boost_or_discard_energy
	farcall Func_3920b
	jr c, .energy_boost_or_discard_energy

; if none of the attacks have those flags, do an additional
; check to ascertain whether evolution card needs energy
; to use second attack. Return if all these checks fail.
	farcall CheckIfEvolutionNeedsEnergyForAttack
	ret nc
	jr .check_deck

; for attacks that discard energy or get boost for
; additional energy cards, get the energy card ID required by attack.
; if it's ZapdosLv64's Thunderbolt attack, return.
.energy_boost_or_discard_energy
	farcall GetEnergyCardForDiscardOrEnergyBoostAttack
	ret nc

; check whether to play colorless in some decks
; or whether to play Potion Energy or Full Heal Energy
.check_deck
	call AICheckSpecialColorlessEnergyCards
	jp c, .play_energy_card

	ld a, b
	or a
	jr z, .colorless_energy

; in this case, Pokémon needs a specific basic energy card.
; look for basic energy card needed in hand and play it.
	call LookForCardIDInHand
	ldh [hTemp_ffa0], a
	jp nc, .play_energy_card

; it might be that there's no basic energy is not in hand,
; in which case play Rainbow Energy if remaining HP >= 40
	ldh a, [hTempPlayAreaLocation_ff9d]
	add DUELVARS_ARENA_CARD_HP
	get_turn_duelist_var
	cp 40
	jr c, .colorless_energy
	ld de, RAINBOW_ENERGY
	call LookForCardIDInHand
	ldh [hTemp_ffa0], a
	jr nc, .play_energy_card

; in this case Pokémon just needs colorless (any basic energy card).
.colorless_energy
	farcall Func_3934d
	jr c, .check_recycle_energy
	ld a, c
	or a
	jr z, .check_if_done
	cp 2
	jr c, .check_recycle_energy

	; needs two colorless
	bank1call CreateEnergyCardListFromHand
	ld hl, wDuelTempList
.loop_1
	ld a, [hli]
	cp $ff
	jr z, .check_recycle_energy
	ldh [hTemp_ffa0], a
	call GetCardIDFromDeckIndex
	cp16 DOUBLE_COLORLESS_ENERGY
	jr nz, .loop_1
	jr .play_energy_card

; if there's a Recycle Energy in hand, play it
.check_recycle_energy
	ld de, RECYCLE_ENERGY
	call LookForCardIDInHand
	ldh [hTemp_ffa0], a
	jr nc, .play_energy_card

; otherwise, try to play any Basic Energy card
	farcall CreateEnergyCardListFromHand_OnlyBasic
	ld a, [wDuelTempList]
	cp $ff
	jr z, .no_basic_energy
	ldh [hTemp_ffa0], a
	jr .play_energy_card

.no_basic_energy
	; create list with all energy cards and shuffle
	bank1call CreateEnergyCardListFromHand
	ld hl, wDuelTempList
	call CountCardsInDuelTempList
	call ShuffleCards

	; copy wDuelTempList to wc000
	ld hl, wDuelTempList
	ld de, wc000
.loop_copy_list
	ld a, [hli]
	ld [de], a
	inc de
	cp $ff
	jr nz, .loop_copy_list

	ld hl, wc000
.asm_171d6
	ld a, [hli]
	cp $ff
	jr z, .check_if_done
	ldh [hTemp_ffa0], a
	push hl
	farcall Func_4c25c
	pop hl
	jr nc, .play_energy_card
	cp -1
	jr nz, .asm_171d6

; plays energy card loaded in hTemp_ffa0 and sets carry flag.
.play_energy_card
	ldh a, [hTempPlayAreaLocation_ff9d]
	ldh [hTempPlayAreaLocation_ffa1], a
	ld a, OPPACTION_PLAY_ENERGY
	farcall AIMakeDecision
	scf
	ret

; wTempAI is 1 if the attack had a Discard/Energy Boost effect,
; and 0 otherwise. If 1, then return. If not one, check if
; there is still a second attack to check.
.check_if_done
	ld a, [wTempAI]
	or a
	jr z, .check_first_attack
	ret
.check_first_attack
	ld a, [wSelectedAttack]
	or a
	jp z, .second_attack
	ret

AICheckSpecialColorlessEnergyCards:
	ld a, [wSelectedAttack]
	push af
	push bc
	push de
	push hl
	call .PotionAndFullHealEnergy

	ld a, [wOpponentDeckID]
	cp MAX_ENERGY_DECK_ID
	jp z, .MaxEnergyDeck
	cp GREAT_ROCKET3_DECK_ID
	jp z, .GreatRocket3Deck
	cp GREAT_DRAGON_DECK_ID
	jp z, .GreatDragonDeck
	cp EVERYBODYS_FRIEND_DECK_ID
	jp z, .EverybodysFriendDeck
	cp POISON_STORM_DECK_ID
	jp z, .PoisonStormDeck

.done
	pop hl
	pop de
	pop bc
	pop af
	ld [wSelectedAttack], a
	or a
	ret

.PotionAndFullHealEnergy:
; Potion Energy
	ldh a, [hTempPlayAreaLocation_ff9d]
	or a
	ret nz
	ld a, 10
	farcall Func_39c8d
	call c, .MaybePickPotionEnergy
	ld a, DUELVARS_ARENA_CARD_STATUS
	get_turn_duelist_var
	or a
	call nz, .MaybePickFullHealEnergy
	ret

.MaybePickPotionEnergy:
	ld de, POTION
	call LookForCardIDInHand
	ret nc ; no Potion in hand
	ld de, SUPER_POTION
	call LookForCardIDInHand
	ret nc ; no Super Potion in hand
	add sp, $4
	ld de, POTION_ENERGY
	call LookForCardIDInHand
	jr c, .done
	ldh [hTemp_ffa0], a
	pop hl
	pop de
	pop bc
	pop af
	ld [wSelectedAttack], a
	scf
	ret

.MaybePickFullHealEnergy:
	ld a, [wOpponentDeckID]
	cp BAD_DREAM_DECK_ID
	jr z, .bad_dream_deck
	ld de, FULL_HEAL
	call LookForCardIDInHand
	ret nc ; no Full Heal in hand
.asm_17279
	add sp, $4
	call AIDecideWhetherToRetreat_IgnoreStatus
	jr nc, .asm_1728c
	farcall CheckIfArenaCardCanRetreat
	jr c, .done
	ld a, [wAIPlayEnergyCardForRetreat]
	or a
	jr nz, .done
.asm_1728c
	ld de, FULLHEAL_ENERGY
	call LookForCardIDInHand
	jr c, .done
	ldh [hTemp_ffa0], a
	pop hl
	pop de
	pop bc
	pop af
	ld [wSelectedAttack], a
	scf
	ret

.bad_dream_deck
	; skip if player's Arena card is asleep
	ld a, DUELVARS_ARENA_CARD_STATUS
	call GetNonTurnDuelistVariable
	and CNF_SLP_PRZ
	cp ASLEEP
	ret nz

	; this check is redundant, it's already done
	; before calling .MaybePickFullHealEnergy
	ld a, DUELVARS_ARENA_CARD_STATUS
	get_turn_duelist_var
	or a
	ret z
	jr .asm_17279

.GreatDragonDeck:
.PoisonStormDeck:
	call .GetArenaCardID
	cp16 CHARMANDER_LV9
	jr z, .only_play_if_has_no_colorless_attached
	cp16 CHARMANDER_LV10
	jr z, .only_play_if_has_no_colorless_attached
	cp16 DRATINI_LV10
	jr z, .only_play_if_has_no_colorless_attached
	jp .done

.EverybodysFriendDeck:
	call .GetArenaCardID
	cp16 JIGGLYPUFF_LV14
	jr z, .only_play_if_has_no_colorless_attached
	jp .done

	call .GetArenaCardID
	cp16 GROWLITHE_LV18
	jr z, .only_play_if_has_no_colorless_attached
	jp .done

	call .GetArenaCardID
	cp16 DRATINI_LV10
	jr z, .only_play_if_has_no_colorless_attached
	jp .done

.MaxEnergyDeck:
.GreatRocket3Deck:
	call .GetArenaCardID
	cp16 EXEGGUTOR
	jp nz, .done
	ld de, DOUBLE_COLORLESS_ENERGY
	call LookForCardIDInHand
	jp nc, .has_double_colorless_in_hand ; can be jr
	; pick first energy card in hand
	bank1call CreateEnergyCardListFromHand
	ld a, [wDuelTempList]
.has_double_colorless_in_hand
	ldh [hTemp_ffa0], a
	pop hl
	pop de
	pop bc
	pop af
	ld [wSelectedAttack], a
	scf
	ret

.only_play_if_has_no_colorless_attached
	ldh a, [hTempPlayAreaLocation_ff9d]
	ld e, a
	call GetPlayAreaCardAttachedEnergies
	ld a, [wAttachedEnergies + COLORLESS]
	or a
	jp nz, .done ; already has colorless
	ld de, DOUBLE_COLORLESS_ENERGY
	call LookForCardIDInHand
	jp c, .done ; has no Double Colorless in hand
	; pick double colorless
	ldh [hTemp_ffa0], a
	pop hl
	pop de
	pop bc
	pop af
	ld [wSelectedAttack], a
	scf
	ret

.GetArenaCardID:
	ldh a, [hTempPlayAreaLocation_ff9d]
	add DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call GetCardIDFromDeckIndex
	ret

Func_17356:
	push af
	ld a, [wSpecialRule]
	cp $01
	jr nz, .asm_173b4
	call SwapTurn
	bank1call GetArenaCardColor
	call SwapTurn
	cp $01
	jr nz, .asm_173b4
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call GetCardIDFromDeckIndex
	cp16 ODDISH_LV21
	jr z, .asm_173a0
	cp16 GLOOM
	jr z, .asm_17398
	cp16 DARK_GLOOM
	jr z, .asm_173a0
	ld a, $00
	call CheckLoadedAttackFlag
	jr c, .asm_173ad
	pop af
	ret
.asm_17398
	ld a, [wSelectedAttack]
	or a
	jr nz, .asm_173b4
	jr .asm_173a6
.asm_173a0
	ld a, [wSelectedAttack]
	or a
	jr z, .asm_173b4
.asm_173a6
	pop af
	sub $0a
	jp c, .asm_17451
	ret
.asm_173ad
	pop af
	sub $05
	jp c, .asm_17451
	ret
.asm_173b4
	call SwapTurn
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call GetCardIDFromDeckIndex
	call SwapTurn
	cp16 SNORLAX_LV20
	jr nz, .asm_17431
	xor a
	call SwapTurn
	bank1call CheckIsIncapableOfUsingPkmnPower
	call SwapTurn
	jr c, .asm_17431
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call GetCardIDFromDeckIndex
	cp16 BULBASAUR_LV15
	jr z, .asm_1742a
	cp16 WEEDLE_LV15
	jr z, .asm_1742a
	cp16 EKANS_LV10
	jr z, .asm_17421
	cp16 ODDISH_LV21
	jr z, .asm_1742a
	cp16 GLOOM
	jr z, .asm_17421
	cp16 DARK_GLOOM
	jr z, .asm_1742a
	ld a, $00
	call CheckLoadedAttackFlag
	jr c, .asm_173ad
	jr .asm_17431
.asm_17421
	ld a, [wSelectedAttack]
	or a
	jr nz, .asm_17431
	jp .asm_173a6
.asm_1742a
	ld a, [wSelectedAttack]
	or a
	jp nz, .asm_173a6
.asm_17431
	ld a, $ec
	call GetNonTurnDuelistVariable
	and $f0
	cp $c0
	jr nz, .asm_17442
.asm_1743c
	pop af
	sub $14
	jr c, .asm_17451
	ret
.asm_17442
	cp $80
	jr nz, .asm_17453
	bank1call Func_796b
	jr c, .asm_1743c
	pop af
	sub $0a
	jr c, .asm_17451
	ret
.asm_17451
	xor a
	ret
.asm_17453
	pop af
	ret

; have AI choose an attack to use, but do not execute it.
; return carry if an attack is chosen.
AIProcessButDontUseAttack:
	ld a, $01
	ld [wAIExecuteProcessedAttack], a

; backup wPlayAreaAIScore in wTempPlayAreaAIScore.
	ld de, wTempPlayAreaAIScore
	ld hl, wPlayAreaAIScore
	ld b, MAX_PLAY_AREA_POKEMON
.loop
	ld a, [hli]
	ld [de], a
	inc de
	dec b
	jr nz, .loop

; copies wAIScore to wTempAIScore
	ld a, [wAIScore]
	ld [de], a
	jr AIProcessAttacks

; copies wTempPlayAreaAIScore to wPlayAreaAIScore
; and loads wAIScore with value in wTempAIScore.
; identical to RetrievePlayAreaAIScoreFromBackup1.
RetrievePlayAreaAIScoreFromBackup2:
	push af
	ld de, wPlayAreaAIScore
	ld hl, wTempPlayAreaAIScore
	ld b, MAX_PLAY_AREA_POKEMON
.loop
	ld a, [hli]
	ld [de], a
	inc de
	dec b
	jr nz, .loop

	ld a, [hl]
	ld [wAIScore], a
	pop af
	ret

; have AI choose and execute an attack.
; return carry if an attack was chosen and attempted.
AIProcessAndTryToUseAttack:
	xor a
	ld [wAIExecuteProcessedAttack], a
	; fallthrough

; checks which of the Active card's attacks for AI to use.
; If any of the attacks has enough AI score to be used,
; AI will use it if wAIExecuteProcessedAttack is 0.
; in either case, return carry if an attack is chosen to be used.
AIProcessAttacks:
; if AI used Pluspower, load its attack index
	ld a, [wPreviousAIFlags]
	and AI_FLAG_USED_PLUSPOWER
	jr z, .no_pluspower
	ld a, [wAIPluspowerAttack]
	cp $02
	jr nc, .no_pluspower
	ld [wSelectedAttack], a
	jr .attack_chosen

.no_pluspower
; if Player is running MewtwoLv53 mill deck,
; skip attack if Barrier counter is 0.
	ld a, [wAIBarrierFlagCounter]
	cp AI_MEWTWO_MILL + 0
	jp z, .dont_attack

; determine AI score of both attacks.
	xor a ; FIRST_ATTACK_OR_PKMN_POWER
	call GetAIScoreOfAttack
	ld a, [wAIScore]
	ld [wFirstAttackAIScore], a
	ld a, SECOND_ATTACK
	call GetAIScoreOfAttack

; compare both attack scores
	ld c, SECOND_ATTACK
	ld a, [wFirstAttackAIScore]
	ld b, a
	ld a, [wAIScore]
	cp b
	jr nc, .check_score
	; first attack has higher score
	dec c
	ld a, b

; c holds the attack index chosen by AI,
; and a holds its AI score.
; first check if chosen attack has at least minimum score.
; then check if first attack is better than second attack
; in case the second one was chosen.
.check_score
	cp $50 ; minimum score to use attack
	jr c, .dont_attack
	; enough score, proceed

	ld a, c
	ld [wSelectedAttack], a
	or a
	jr z, .attack_chosen
	farcall CheckWhetherToSwitchToFirstAttack

.attack_chosen
; check whether to execute the attack chosen
	ld a, [wAIExecuteProcessedAttack]
	or a
	jr z, .execute

; set carry and reset Play Area AI score
; to the previous values.
	scf
	jp RetrievePlayAreaAIScoreFromBackup2

.execute
	ld a, AI_TRAINER_CARD_PHASE_14
	farcall AIProcessHandTrainerCards

; load this attack's damage output against
; the current Defending Pokemon.
	xor a ; PLAY_AREA_ARENA
	ldh [hTempPlayAreaLocation_ff9d], a
	ld a, [wSelectedAttack]
	call EstimateDamage_VersusDefendingCard
	ld a, [wDamage]

	or a
	jr z, .check_damage_bench
	; if damage is not 0, fallthrough

.can_damage
	xor a
	ld [wd032], a
	jr .use_attack

.check_damage_bench
; check if it can otherwise damage player's bench
	ld a, ATTACK_FLAG1_ADDRESS | DAMAGE_TO_OPPONENT_BENCH_F
	call CheckLoadedAttackFlag
	jr c, .can_damage

; cannot damage either Defending Pokemon or Bench
	ld hl, wd032
	inc [hl]

; return carry if attack is chosen
; and AI tries to use it.
.use_attack
	ld a, TRUE
	ld [wAITriedAttack], a
	farcall Func_4c65b
	call AITryUseAttack
	scf
	ret

.dont_attack
	ld a, [wAIExecuteProcessedAttack]
	or a
	jr z, .failed_to_use
; reset Play Area AI score
; to the previous values.
	jp RetrievePlayAreaAIScoreFromBackup2

; return no carry if no viable attack.
.failed_to_use
	ld hl, wd032
	inc [hl]
	or a
	ret

GetAIScoreOfAttack:
	ld [wSelectedAttack], a
	ld a, $50
	ld [wAIScore], a
	xor a ; PLAY_AREA_ARENA
	ldh [hTempPlayAreaLocation_ff9d], a
	call CheckIfSelectedAttackIsUnusable
	jr nc, .asm_17532
.asm_1752b
	xor a
	ld [wAIScore], a
	jp .asm_17969
.asm_17532
	xor a
	ld [wd05f], a
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call GetCardIDFromDeckIndex
	ld a, e
	ld [wTempTurnDuelistCardID], a
	ld a, d
	ld [$ccd5], a
	call SwapTurn
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call GetCardIDFromDeckIndex
	ld a, e
	ld [wTempNonTurnDuelistCardID], a
	ld a, d
	ld [$ccd7], a
	bank1call HandleNoDamageOrEffectSubstatus
	call SwapTurn
	jr nc, .asm_17581
	ld a, $01
	ld [wd05f], a
	ld a, [wSelectedAttack]
	call EstimateDamage_VersusDefendingCard
	ld a, $12
	call CheckLoadedAttackFlag
	jr c, .asm_17581
	ld a, [wLoadedAttackCategory]
	cp $04
	jr z, .asm_1752b
	and $80
	jr nz, .asm_17581
	ld a, $05
	call CheckLoadedAttackFlag
	jr nc, .asm_1752b
.asm_17581
	ld a, [wSelectedAttack]
	call EstimateDamage_VersusDefendingCard
	ld a, $c8
	call GetNonTurnDuelistVariable
	push af
	ld a, [wDamage]
	call Func_17356
	ld b, a
	pop af
	sub b
	jr c, .asm_1759c
	jr z, .asm_1759c
	jr .asm_175f6
.asm_1759c
	ld a, $14
	call AIEncourage
	ld a, $ed
	call GetNonTurnDuelistVariable
	cp $1b
	jr nz, .asm_175f6
	call SwapTurn
	call CountPrizes
	call SwapTurn
	cp $01
	jr nz, .asm_175be
	ld a, $32
	call AIDiscourage
	jr .asm_175f6
.asm_175be
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	cp $01
	jr nz, .asm_175cc
	ld a, $32
	call AIDiscourage
	jr .asm_175f6
.asm_175cc
	call CountPrizes
	cp $01
	jr nz, .asm_175da
	ld a, $0a
	call AIEncourage
	jr .asm_175f6
.asm_175da
	ld a, $f5
	call GetNonTurnDuelistVariable
	cp $01
	jr nz, .asm_175ea
	ld a, $0a
	call AIEncourage
	jr .asm_175f6
.asm_175ea
	ld a, DUELVARS_ARENA_CARD_HP
	get_turn_duelist_var
	cp $1e
	jr c, .asm_175f6
	ld a, $1e
	call AIDiscourage
.asm_175f6
	xor a
	ld [wd072], a
	ld a, [wDamage]
	ld [wTempAI], a
	call Func_17356
	or a
	jr z, .asm_1760e
	call ConvertHPToCounters
	call AIEncourage
	jr .asm_17643
.asm_1760e
	ld a, $01
	ld [wd072], a
	call AIDiscourage
	ld a, [$cccc]
	farcall $13, $4b6e
	or a
	jr z, .asm_17629
	ld a, $02
	call AIEncourage
	xor a
	ld [wd072], a
.asm_17629
	ld a, $05
	call CheckLoadedAttackFlag
	jr nc, .asm_17643
	ld a, $f5
	call GetNonTurnDuelistVariable
	or a
	jr z, .asm_17643
	farcall CheckIfPlayerHasAuroraVeilActive
	jr c, .asm_17643
	ld a, $02
	call AIEncourage
.asm_17643
	ld a, $04
	call CheckLoadedAttackFlag
	jr c, .asm_17652
	ld a, $06
	call CheckLoadedAttackFlag
	jp nc, .asm_17799
.asm_17652
	ld a, [wLoadedAttackEffectParam]
	or a
	jp z, .asm_17799
	ld [wDamage], a
	call ApplyDamageModifiers_DamageToSelf
	ld a, e
	call ConvertHPToCounters
	call AIDiscourage
	push de
	ld a, $06
	call CheckLoadedAttackFlag
	pop de
	jr c, .asm_1769d
	ld a, DUELVARS_ARENA_CARD_HP
	get_turn_duelist_var
	cp e
	jr c, .asm_17678
	jp nz, .asm_17799
.asm_17678
	ld a, $0a
	call AIDiscourage
	call SwapTurn
	call CountPrizes
	call SwapTurn
	cp $01
	jr nz, .asm_17691
	ld a, $1e
	call AIDiscourage
	jr .asm_1769d
.asm_17691
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	cp $01
	jr nz, .asm_1769d
	ld a, $1e
	call AIDiscourage
.asm_1769d
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	cp $02
	jr c, .asm_176af
	ld a, [wOpponentDeckID]
	cp $12
	jr z, .asm_176af
	cp $1c
	jr nz, .asm_17705
.asm_176af
	xor a
	ld [wAIScore], a
	jp .asm_17969
.asm_176b6
	ld a, $14
	call AIEncourage
	jp .asm_17969
	ld a, DUELVARS_NUMBER_OF_CARDS_NOT_IN_DECK
	get_turn_duelist_var
	cp $1f
	jr nc, .asm_17705
	ld e, $00
	call GetCardDamageAndMaxHP
	sla a
	cp c
	jr c, .asm_17705
	ld b, $00
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call GetCardIDFromDeckIndex
	cp16 MAGNEMITE_LV13
	jr z, .asm_176e3
	ld b, $0a
.asm_176e3
	ld a, $0a
	add b
	ld b, a
	ld a, $01
	call .Func_17769
	jr c, .asm_176af
	jr .asm_176b6
	call CountPrizes
	cp $04
	jr nc, .asm_176af
	ld b, $14
	call SwapTurn
	xor a
	call .Func_17769
	call SwapTurn
	jr c, .asm_176b6
.asm_17705
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call GetCardIDFromDeckIndex
	cp16 CHANSEY_LV55
	jr z, .asm_17731
	cp16 MAGNEMITE_LV13
	jr z, .asm_1772d
	cp16 WEEZING_LV27
	jr z, .asm_1772d
	ld b, $14
	jr .asm_17733
.asm_1772d
	ld b, $0a
	jr .asm_17733
.asm_17731
	ld b, $00
.asm_17733
	push bc
	call SwapTurn
	xor a
	call .Func_17769
	call SwapTurn
	pop bc
	jr c, .asm_17751
	push de
	ld a, $01
	call .Func_17769
	pop bc
	jr nc, .asm_17759
	xor a
	ld [wAIScore], a
	jp .asm_17969
.asm_17751
	ld a, $14
	call AIEncourage
	jp .asm_17969
.asm_17759
	push bc
	ld a, d
	or a
	jr z, .asm_17762
	dec a
	call AIDiscourage
.asm_17762
	pop bc
	ld a, b
	call AIEncourage
	jr .asm_17799

.Func_17769:
	ld d, a
	ld a, DUELVARS_BENCH
	get_turn_duelist_var
	ld e, $00
.asm_1776f
	inc e
	ld a, [hli]
	cp $ff
	jr z, .asm_17783
	ld a, e
	add $c8
	push hl
	get_turn_duelist_var
	pop hl
	cp b
	jr z, .asm_17780
	jr nc, .asm_1776f
.asm_17780
	inc d
	jr .asm_1776f
.asm_17783
	push de
	call SwapTurn
	call CountPrizes
	call SwapTurn
	pop de
	cp d
	jp c, .asm_17797 ; can be jr
	jp z, .asm_17797 ; can be jr
	or a
	ret
.asm_17797
	scf
	ret

.asm_17799
	ld a, [wSelectedAttack]
	push af
	farcall CheckIfDefendingPokemonCanKnockOut
	pop bc
	ld a, b
	ld [wSelectedAttack], a
	jr nc, .asm_177c5
	ld a, $05
	call AIEncourage
	ld a, [wd072]
	or a
	jr nz, .asm_177c0
	ld a, [wSelectedAttack]
	ld e, a
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	ld d, a
	call CopyAttackDataAndDamage_FromDeckIndex
	jr .asm_177e9
.asm_177c0
	ld a, $05
	call AIDiscourage
.asm_177c5
	ld a, [wSelectedAttack]
	ld e, a
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	ld d, a
	call CopyAttackDataAndDamage_FromDeckIndex
	ld a, $0b
	call CheckLoadedAttackFlag
	jr nc, .asm_177e9
	ld a, [wOpponentDeckID]
	cp $34
	jr z, .asm_177e9
	ld a, $01
	call AIDiscourage
	ld a, [wLoadedAttackEffectParam]
	call AIDiscourage
.asm_177e9
	ld a, $0e
	call CheckLoadedAttackFlag
	jr nc, .asm_177f6
	ld a, [wLoadedAttackEffectParam]
	call AIEncourage
.asm_177f6
	ld a, $0f
	call CheckLoadedAttackFlag
	jr nc, .asm_17803
	ld a, [wLoadedAttackEffectParam]
	call AIDiscourage
.asm_17803
	ld a, $0a
	call CheckLoadedAttackFlag
	jr nc, .asm_1780f
	ld a, $01
	call AIEncourage
.asm_1780f
	ld a, $07
	call CheckLoadedAttackFlag
	jr nc, .asm_1781b
	ld a, $01
	call AIEncourage
.asm_1781b
	ld a, $09
	call CheckLoadedAttackFlag
	jr nc, .asm_17857
	ld a, [wLoadedAttackEffectParam]
	cp $01
	jr z, .asm_17846
	ld a, [wTempAI]
	call ConvertHPToCounters
	ld b, a
	ld a, [wLoadedAttackEffectParam]
	cp $03
	jr z, .asm_1783c
	srl b
	jr nc, .asm_1783c
	inc b
.asm_1783c
	ld a, DUELVARS_ARENA_CARD_HP
	get_turn_duelist_var
	call ConvertHPToCounters
	cp b
	jr c, .asm_17846
	ld a, b
.asm_17846
	push af
	ld e, $00
	call GetCardDamageAndMaxHP
	call ConvertHPToCounters
	pop bc
	cp b
	jr c, .asm_17854
	ld a, b
.asm_17854
	call AIEncourage
.asm_17857
	ld a, $bb
	call GetNonTurnDuelistVariable
	call SwapTurn
	call GetCardIDFromDeckIndex
	call SwapTurn
	cp16 SNORLAX_LV20
	jp z, .asm_17916
	ld a, [wSpecialRule]
	cp $01
	jr nz, .asm_17885
	call SwapTurn
	bank1call GetArenaCardColor
	call SwapTurn
	cp $01
	jp z, .asm_17916
.asm_17885
	ld a, $ec
	call GetNonTurnDuelistVariable
	ld [wTempAI], a
	ld a, $00
	call CheckLoadedAttackFlag
	jr nc, .asm_178b2
	ld a, [wTempAI]
	and $c0
	jr z, .asm_178ad
	and $40
	jr z, .asm_178b2
	ld a, $0e
	call CheckLoadedAttackFlag
	jr nc, .asm_178b2
	ld a, $02
	call AIDiscourage
	jr .asm_178b2
.asm_178ad
	ld a, $02
	call AIEncourage
.asm_178b2
	ld a, $01
	call CheckLoadedAttackFlag
	jr nc, .asm_178c7
	ld a, [wTempAI]
	and $0f
	cp $02
	jr z, .asm_178c7
	ld a, $01
	call AIEncourage
.asm_178c7
	ld a, $02
	call CheckLoadedAttackFlag
	jr nc, .asm_178e3
	ld a, [wTempAI]
	and $0f
	cp $02
	jr z, .asm_178de
	ld a, $01
	call AIEncourage
	jr .asm_178e3
.asm_178de
	ld a, $01
	call AIDiscourage
.asm_178e3
	ld a, $03
	call CheckLoadedAttackFlag
	jr nc, .asm_17908
	ld a, [wTempAI]
	and $0f
	cp $02
	jr z, .asm_17903
	ld a, [wTempAI]
	and $0f
	cp $01
	jr z, .asm_17908
	ld a, $01
	call AIEncourage
	jr .asm_17908
.asm_17903
	ld a, $01
	call AIDiscourage
.asm_17908
	ld a, DUELVARS_ARENA_CARD_STATUS
	get_turn_duelist_var
	and $0f
	cp $01
	jr nz, .asm_17916
	ld a, $01
	call AIDiscourage
.asm_17916
	ld a, $11
	call CheckLoadedAttackFlag
	jr nc, .asm_17935
	farcall $a, $4dff
	cp $80
	jr c, .asm_1792c
	sub $80
	call AIEncourage
	jr .asm_17969
.asm_1792c
	ld b, a
	ld a, $80
	sub b
	call AIDiscourage
	jr .asm_17969
.asm_17935
	ld a, [wSelectedAttack]
	push af
	farcall $12, $74e4
	cp $80
	jr c, .asm_17948
	sub $80
	call AIEncourage
	jr .asm_1794f
.asm_17948
	ld b, a
	ld a, $80
	sub b
	call AIDiscourage
.asm_1794f
	pop af
	ld [wSelectedAttack], a
	farcall $13, $4063
	cp $80
	jr c, .asm_17962
	sub $80
	call AIEncourage
	jr .asm_17969
.asm_17962
	ld b, a
	ld a, $80
	sub b
	call AIDiscourage
.asm_17969
	ret

; return carry if card ID corresponding
; to the input deck index is listed in wAICardListAvoidPrize;
; input:
;	- a = deck index of card to check
CheckIfCardIDIsInList:
	ld b, a
	ld a, [wAICardListAvoidPrize + 1]
	or a
	ret z ; null
	push hl
	ld h, a
	ld a, [wAICardListAvoidPrize]
	ld l, a

	ld a, b
	call GetCardIDFromDeckIndex
	ld c, e
	ld b, d
.loop_id_list
	ld a, [hli]
	ld e, a
	ld a, [hli]
	ld d, a
	call CheckIfCardIDIsZero_Bank5
	jr c, .false
	ld a, e
	cp c
	jr nz, .loop_id_list
	ld a, d
	cp b
	jr nz, .loop_id_list

; true
	pop hl
	scf
	ret
.false
	pop hl
	or a
	ret

; returns carry if damage dealt from any of
; a card's attacks KOs defending Pokémon
; outputs index of the attack that KOs
; input:
;	[hTempPlayAreaLocation_ff9d] = location of attacking card to consider
; output:
;	[wSelectedAttack] = attack index that KOs
CheckIfAnyAttackKnocksOutDefendingCard:
	xor a ; first attack
	call .CheckAttack
	ret c
	ld a, SECOND_ATTACK
.CheckAttack:
	call EstimateDamage_VersusDefendingCard
	ld a, DUELVARS_ARENA_CARD_HP
	call GetNonTurnDuelistVariable
	ld hl, wDamage
	sub [hl]
	ret c
	ret nz
	scf
	ret
; 0x179aa

SECTION "Bank 5@79c2", ROMX[$79c2], BANK[$5]

; checks AI scores for all benched Pokémon
; returns the location of the card with highest score
; in a and [hTempPlayAreaLocation_ff9d]
FindHighestBenchScore:
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	ld b, a
	ld c, 0
	ld e, c
	ld d, c
	ld hl, wPlayAreaAIScore + 1
	jp .next ; can be jr

.loop
	ld a, [hli]
	cp e
	jr c, .next
	ld e, a
	ld d, c
.next
	inc c
	dec b
	jr nz, .loop

	ld a, d
	ldh [hTempPlayAreaLocation_ff9d], a
	or a
	ret

; adds a to wAIScore
; if there's overflow, it's capped at 255
; output:
;	a = a + wAIScore (capped at 255)
AIEncourage:
	push hl
	ld hl, wAIScore
	add [hl]
	jr nc, .no_cap
	ld a, 255
.no_cap
	ld [hl], a
	pop hl
	ret

; subs a from wAIScore
; if there's underflow, it's capped at 0
AIDiscourage:
	push hl
	push de
	ld e, a
	ld hl, wAIScore
	ld a, [hl]
	or a
	jr z, .done
	sub e
	ld [hl], a
	jr nc, .done
	ld [hl], 0
.done
	pop de
	pop hl
	ret

; loads defending Pokémon's weakness/resistance
; and the number of prize cards in both sides
LoadDefendingPokemonColorWRAndPrizeCards:
	call SwapTurn
	bank1call GetArenaCardColor
	call TranslateColorToWR
	ld [wAIPlayerColor], a
	bank1call GetArenaCardWeakness
	ld [wAIPlayerWeakness], a
	bank1call GetArenaCardResistance
	ld [wAIPlayerResistance], a
	call CountPrizes
	ld [wAIPlayerPrizeCount], a
	call SwapTurn
	call CountPrizes
	ld [wAIOpponentPrizeCount], a
	ret

; called when AI has chosen its attack.
; executes all effects and damage.
; handles AI choosing parameters for certain attacks as well.
AITryUseAttack:
	ld a, [wSelectedAttack]
	ldh [hTemp_ffa0], a
	ld e, a
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	ldh [hTempCardIndex_ff9f], a
	ld d, a
	call CopyAttackDataAndDamage_FromDeckIndex
	ld a, OPPACTION_BEGIN_ATTACK
	farcall AIMakeDecision
	ret c
	ld a, OPPACTION_USE_ATTACK
	farcall AIMakeDecision
	ret c

	farcall AISelectSpecialAttackParameters
	jr c, .has_params_for_attack

	ld a, [wSelectedAttack]
	ld e, a
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	ld d, a
	call CopyAttackDataAndDamage_FromDeckIndex
	ld a, EFFECTCMDTYPE_AI_SELECTION
	call TryExecuteEffectCommandFunction
	ld a, EFFECTCMDTYPE_AI_SWITCH_DEFENDING_PKMN
	call TryExecuteEffectCommandFunction
	jr .attack_animation_and_damage

.has_params_for_attack
	ld a, [wSelectedAttack]
	ld e, a
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	ld d, a
	call CopyAttackDataAndDamage_FromDeckIndex
.attack_animation_and_damage
	ld a, OPPACTION_ATTACK_ANIM_AND_DAMAGE
	farcall AIMakeDecision
	ret

; return carry if input energy card is useful to
; the Pokémon card ID in wTempCardID_d0a3
; used for knowing if a given energy card can be discarded
; from a given Pokémon card
; input:
;	a = energy card attached to Pokémon to check
;	[wTempCardType] = TYPE_ENERGY_* of given Pokémon
;	wTempCardID_d0a3 = card index of Pokémon card to check
CheckIfEnergyIsUseful:
	push hl
	push de
	push bc
	call GetCardIDFromDeckIndex

	; Recycle energy isn't useful
	cp16 RECYCLE_ENERGY
	jp z, .no_carry

	; Double Colorless and Rainbow energy are useful
	cp16 DOUBLE_COLORLESS_ENERGY
	jp z, .set_carry
	cp16 RAINBOW_ENERGY
	jp z, .set_carry

	; Pokémon in colorless, so all energies are useful
	ld a, [wTempCardType]
	cp TYPE_ENERGY_DOUBLE_COLORLESS
	jp z, .set_carry

	; check cards that have Psychic energy
	; as a useful energy for attack
	ld hl, wTempCardID_d0a3
	ld bc, PSYCHIC_ENERGY
	cphl EXEGGCUTE
	jp z, .compare_energy_id
	cphl EXEGGUTOR
	jp z, .compare_energy_id
	cphl PSYDUCK_LV15
	jp z, .compare_energy_id
	cphl PSYDUCK_LV16
	jp z, .compare_energy_id
	cphl GOLDUCK_LV27
	jp z, .compare_energy_id
	cphl GOLDUCK_LV28
	jr z, .compare_energy_id
	cphl DARK_GOLDUCK
	jr z, .compare_energy_id

	; check cards that have Water energy
	; as a useful energy for attack
	ld bc, WATER_ENERGY
	cphl SURFING_PIKACHU_LV13
	jr z, .compare_energy_id
	cphl SURFING_PIKACHU_ALT_LV13
	jr z, .compare_energy_id
	cphl JYNX_LV18
	jr z, .compare_energy_id

	; Eevee has a number of useful energy cards
	cphl EEVEE_LV9
	jr z, .check_eevee
	cphl EEVEE_LV5
	jr z, .check_eevee
	cphl EEVEE_LV12
	jr nz, .check_type
.check_eevee
	cp16 WATER_ENERGY
	jr z, .set_carry
	cp16 FIRE_ENERGY
	jr z, .set_carry
	cp16 LIGHTNING_ENERGY
	jr z, .set_carry

.check_type
	; if same type as Pokémon, is useful
	call GetCardType
	ld d, a
	ld a, [wTempCardType]
	cp d
	jr z, .set_carry

.no_carry
	; not useful
	pop bc
	pop de
	pop hl
	or a
	ret

.compare_energy_id
	ld a, c
	cp e
	jr nz, .check_type
	ld a, b
	cp d
	jr nz, .check_type

.set_carry
	; is useful
	pop bc
	pop de
	pop hl
	scf
	ret

; pick a random Pokemon in the bench.
; output:
;	- a = PLAY_AREA_* of Bench Pokemon picked.
PickRandomBenchPokemon:
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	dec a
	call Random
	inc a
	ret

AIPickPrizeCards:
	ld a, [wNumberPrizeCardsToTake]
	ld b, a
.loop
	push bc
	call .PickPrizeCard
	pop bc
	ld a, DUELVARS_PRIZES
	get_turn_duelist_var
	or a
	jr z, .done
	dec b
	jr nz, .loop
.done
	ret

.PickPrizeCard:
	ld a, DUELVARS_PRIZES
	get_turn_duelist_var
	push hl
	ld c, a

; choose a random prize card until
; one is found that isn't taken already.
.loop_pick_prize
	ld a, 6
	call Random
	ld e, a
	ld d, $00
	ld hl, .prize_flags
	add hl, de
	ld a, [hl]
	and c
	jr z, .loop_pick_prize ; no prize

; prize card was found
; remove this prize from wOpponentPrizes
	ld a, [hl]
	pop hl
	cpl
	and [hl]
	ld [hl], a

; add this prize card to the hand
	ld a, e
	add DUELVARS_PRIZE_CARDS
	get_turn_duelist_var
	call AddCardToHand
	bank1call TurnDuelistTakePrizes.Func_551d
	ret

.prize_flags
	db $1 << 0
	db $1 << 1
	db $1 << 2
	db $1 << 3
	db $1 << 4
	db $1 << 5
	db $1 << 6
	db $1 << 7

; routine for AI to play all Basic cards from its hand
; in the beginning of the Duel.
AIPlayInitialBasicCards:
	farcall AIPrioritizeStartingArenaCard
	ret c ; carry is never set here

	; play all Basic Pokémon cards in Play Area
	call CreateHandCardList
	ld hl, wDuelTempList
.loop_hand_cards
	ld a, [hli]
	ldh [hTempCardIndex_ff98], a
	cp $ff
	ret z
	call LoadCardDataToBuffer1_FromDeckIndex
	ld a, [wLoadedCard1Type]
	cp TYPE_ENERGY
	jr nc, .loop_hand_cards ; not Pokémon card
	ld a, [wLoadedCard1Stage]
	or a
	jr nz, .loop_hand_cards ; not Basic card
	push hl
	ldh a, [hTempCardIndex_ff98]
	call PutHandPokemonCardInPlayArea
	pop hl
	jr .loop_hand_cards

; returns carry if Pokémon at hTempPlayAreaLocation_ff9d
; can't use an attack or if that selected attack doesn't have enough energy
; input:
;	[hTempPlayAreaLocation_ff9d] = location of Pokémon card
;	[wSelectedAttack]         = selected attack to examine
CheckIfSelectedAttackIsUnusable:
	ldh a, [hTempPlayAreaLocation_ff9d]
	or a
	jr nz, .bench

	bank1call CheckIfArenaCardIsUnableToAttack
	ret c

	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	ld d, a
	ld a, [wSelectedAttack]
	ld e, a
	call CopyAttackDataAndDamage_FromDeckIndex
	bank1call HandleAmnesiaSubstatus
	ret c
	ld a, EFFECTCMDTYPE_INITIAL_EFFECT_1
	call TryExecuteEffectCommandFunction
	ret c

.bench
	call CheckEnergyNeededForAttack
	ret c ; can't be used
	ld a, ATTACK_FLAG2_ADDRESS | FLAG_2_BIT_5_F
	call CheckLoadedAttackFlag
	ret

; load selected attack from Pokémon in hTempPlayAreaLocation_ff9d
; and checks if there is enough energy to execute the selected attack
; input:
;	[hTempPlayAreaLocation_ff9d] = location of Pokémon card
;	[wSelectedAttack]         = selected attack to examine
; output:
;	b = basic energy still needed
;	c = colorless energy still needed
;	de = output of ConvertColorToEnergyCardID, or $0 if not an attack
;	carry set if no attack
;	       OR if it's a Pokémon Power
;	       OR if not enough energy for attack
CheckEnergyNeededForAttack:
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
	ld de, 0
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
	call CheckIfEnoughParticularAttachedEnergy
	ld a, [de]
	call CheckIfEnoughParticularAttachedEnergy
	inc de
	dec c
	jr nz, .loop

; running CheckIfEnoughParticularAttachedEnergy back to back like this
; overwrites the results of a previous call of this function,
; however, no attack in the game has energy requirements for two
; different energy types (excluding colorless), so this routine
; will always just return the result for one type of basic energy,
; while all others will necessarily have an energy cost of 0
; if attacks are added to the game with energy requirements of
; two different basic energy types, then this routine only accounts
; for the type with the highest index

	; colorless
	ld a, [de]
	swap a
	and %00001111
	ld b, a ; colorless energy still needed
	ld a, [wTempLoadedAttackEnergyCost]
	ld hl, wTempLoadedAttackEnergyNeededAmount
	sub [hl]
	ld c, a ; basic energy still needed
	ld a, [wTotalAttachedEnergies]
	sub c
	sub b
	jr c, .not_enough

	ld a, [wTempLoadedAttackEnergyNeededAmount]
	or a
	ret z

; being here means the energy cost isn't satisfied,
; including with colorless energy
	xor a
.not_enough
	cpl
	inc a
	ld c, a ; colorless energy still needed
	ld a, [wTempLoadedAttackEnergyNeededAmount]
	ld b, a ; basic energy still needed
	ld a, [wTempLoadedAttackEnergyNeededType]
	call ConvertColorToEnergyCardID
	scf
	ret

; takes as input the energy cost of an attack for a
; particular energy, stored in the lower nibble of a
; if the attack costs some amount of this energy, the lower nibble of a != 0,
; and this amount is stored in wTempLoadedAttackEnergyCost
; sets carry flag if not enough energy of this type attached
; input:
;	a    = this energy cost of attack (lower nibble)
;	[hl] = attached energy
; output:
;	carry set if not enough of this energy type attached
CheckIfEnoughParticularAttachedEnergy:
	and %00001111
	jr nz, .check
.has_enough
	inc hl
	inc b
	or a
	ret

.check
	ld [wTempLoadedAttackEnergyCost], a
	sub [hl]
	jr z, .has_enough
	jr c, .has_enough

	; not enough energy
	ld [wTempLoadedAttackEnergyNeededAmount], a
	ld a, b
	ld [wTempLoadedAttackEnergyNeededType], a

	push hl
	ld a, [wAttachedEnergies + RAINBOW]
	ld hl, wTempLoadedAttackEnergyNeededAmount
	cp [hl]
	pop hl
	jr nc, .got_rainbow_energy
	inc hl
	inc b
	scf
	ret
.got_rainbow_energy
	xor a
	ld [wTempLoadedAttackEnergyNeededAmount], a
	ld [wTempLoadedAttackEnergyNeededType], a
	jr .has_enough

; input:
;	a = energy type
; output:
;	a = energy card ID
ConvertColorToEnergyCardID:
	push hl
	add a
	ld e, a
	ld d, 0
	ld hl, .card_id
	add hl, de
	ld e, [hl]
	inc hl
	ld d, [hl]
	pop hl
	ret

.card_id
	dw FIRE_ENERGY
	dw GRASS_ENERGY
	dw LIGHTNING_ENERGY
	dw WATER_ENERGY
	dw FIGHTING_ENERGY
	dw PSYCHIC_ENERGY
	dw DOUBLE_COLORLESS_ENERGY

; return carry depending on card index in a:
;	- if energy card, return carry if no energy card has been played yet
;	- if basic Pokémon card, return carry if there's space in bench
;	- if evolution card, return carry if there's a Pokémon
;	  in Play Area it can evolve
;	- if trainer card, return carry if it can be used
; input:
;	a = card index to check
CheckIfCardCanBePlayed:
	ldh [hTempCardIndex_ff9f], a
	call LoadCardDataToBuffer1_FromDeckIndex
	ld a, [wLoadedCard1Type]
	cp TYPE_ENERGY
	jr c, .pokemon_card
	cp TYPE_TRAINER
	jr z, .trainer_card

; energy card
	ld a, [wAlreadyPlayedEnergy]
	or a
	ret z
	scf
	ret

.pokemon_card
	ld a, [wLoadedCard1Stage]
	or a
	jr nz, .evolution_card
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	ld hl, wMaxNumPlayAreaPokemon
	cp [hl]
	ccf
	ret

.evolution_card
	bank1call IsPrehistoricPowerActive
	ret c
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	ld c, a
	ld b, $00
.loop
	push bc
	ld e, b
	ldh a, [hTempCardIndex_ff9f]
	ld d, a
	call CheckIfCanEvolveInto
	pop bc
	ret nc
	inc b
	dec c
	jr nz, .loop
	scf
	ret

.trainer_card
	; bug, this seems like remnants from TCG1 code
	; a call is made in the middle of another routine
	; this seems like a branch that is never taken
	bank1call CheckCantUseTrainerDueToEffect
	ret c
	call $6968
	ld a, EFFECTCMDTYPE_INITIAL_EFFECT_1
	call TryExecuteEffectCommandFunction
	ret

; looks for card ID in hand and
; sets carry if a card wasn't found
; as opposed to LookForCardIDInHandList_Bank5
; this function doesn't create a list
; and preserves hl, de and bc
; input:
;	de = card ID
; output:
;	a = card deck index, if found
;	carry set if NOT found
LookForCardIDInHand:
	push hl
	push de
	push bc
	ld c, e
	ld b, d
	ld a, DUELVARS_NUMBER_OF_CARDS_IN_HAND
	get_turn_duelist_var
	ld e, a
	inc e
	ld l, DUELVARS_HAND
	jr .next

.loop
	push de
	ld a, [hli]
	call GetCardIDFromDeckIndex
	ld a, e
	cp c
	jr nz, .not_equal
	ld a, d
	cp b
	jr z, .no_carry
.not_equal
	pop de
.next
	dec e
	jr nz, .loop

	pop bc
	pop de
	pop hl
	scf
	ret

.no_carry
	pop de
	dec hl
	ld a, [hl]
	pop bc
	pop de
	pop hl
	or a
	ret

; stores in wDamage, wAIMinDamage and wAIMaxDamage the calculated damage
; done to the defending Pokémon by a given card and attack
; input:
;	a = attack index to take into account
;	[hTempPlayAreaLocation_ff9d] = location of attacking card to consider
EstimateDamage_VersusDefendingCard:
	ld [wSelectedAttack], a
	ld e, a
	ldh a, [hTempPlayAreaLocation_ff9d]
	add DUELVARS_ARENA_CARD
	get_turn_duelist_var
	ld d, a
	call CopyAttackDataAndDamage_FromDeckIndex
	ld a, [wLoadedAttackCategory]
	cp POKEMON_POWER
	jr nz, .is_attack

; is a Pokémon Power
; set wDamage, wAIMinDamage and wAIMaxDamage to zero
	ld hl, wDamage
	xor a
	ld [hli], a
	ld [hl], a
	ld [wAIMinDamage], a
	ld [wAIMaxDamage], a
	ld e, a
	ld d, a
	ret

.is_attack
; set wAIMinDamage and wAIMaxDamage to damage of attack
; these values take into account the range of damage
; that the attack can span (e.g. min and max number of hits)
	bank1call SetDarkWaveAndDarknessVeilDamageModifiers
	ld a, [wDamage]
	ld [wAIMinDamage], a
	ld [wAIMaxDamage], a
	ld a, EFFECTCMDTYPE_AI
	call TryExecuteEffectCommandFunction
	ld a, [wAIMinDamage]
	ld hl, wAIMaxDamage
	or [hl]
	jr nz, .calculation
	ld a, [wDamage]
	ld [wAIMinDamage], a
	ld [wAIMaxDamage], a

.calculation
; if temp. location is active, damage calculation can be done directly...
	ldh a, [hTempPlayAreaLocation_ff9d]
	or a
	jr z, CalculateDamage_VersusDefendingPokemon

; ...otherwise substatuses need to be temporarily reset to account
; for the switching, to obtain the right damage calculation...
	; reset substatus1
	ld a, DUELVARS_ARENA_CARD_SUBSTATUS1
	get_turn_duelist_var
	push af
	push hl
	ld [hl], $00
	; reset substatus2
	ld l, DUELVARS_ARENA_CARD_SUBSTATUS2
	ld a, [hl]
	push af
	push hl
	ld [hl], $00
	; reset changed resistance
	ld l, DUELVARS_ARENA_CARD_CHANGED_RESISTANCE
	ld a, [hl]
	push af
	push hl
	ld [hl], $00
	call CalculateDamage_VersusDefendingPokemon
; ...and subsequently recovered to continue the duel normally
	pop hl
	pop af
	ld [hl], a
	pop hl
	pop af
	ld [hl], a
	pop hl
	pop af
	ld [hl], a
	ret

; calculates the damage that will be dealt to the player's active card
; using the card that is located in hTempPlayAreaLocation_ff9d
; taking into account weakness/resistance/pluspowers/defenders/etc
; and outputs the result capped at a max of $ff
; input:
;	[wAIMinDamage] = base damage
;	[wAIMaxDamage] = base damage
;	[wDamage]      = base damage
;	[hTempPlayAreaLocation_ff9d] = turn holder's card location as the attacker
CalculateDamage_VersusDefendingPokemon:
	ld hl, wAIMinDamage
	call .Calculate
	ld hl, wAIMaxDamage
	call .Calculate
	ld hl, wDamage
.Calculate:
	ld e, [hl]
	ld a, [$ccca]
	ld d, a
	push hl

	; load this card's data
	ldh a, [hTempPlayAreaLocation_ff9d]
	bank1call LoadPlayAreaCardID_ToTempTurnDuelistCardID

	; load player's arena card data
	call SwapTurn
	xor a
	bank1call LoadPlayAreaCardID_ToTempNonTurnDuelistCardID
	push de
	bank1call HandleNoDamageOrEffectSubstatus
	pop de
	call SwapTurn

	jr nc, .vulnerable
	; invulnerable to damage
	ld de, 0
	jr .done
.vulnerable
	ldh a, [hTempPlayAreaLocation_ff9d]
	or a
	jr nz, .not_arena_card
	bank1call HandleDamageModifiersEffects
.not_arena_card
	; skips the weak/res checks if unaffected.
	bit UNAFFECTED_BY_WEAKNESS_RESISTANCE_F, d
	res UNAFFECTED_BY_WEAKNESS_RESISTANCE_F, d
	jr nz, .not_resistant

; handle weakness
	ldh a, [hTempPlayAreaLocation_ff9d]
	bank1call GetPlayAreaCardColor
	call TranslateColorToWR
	ld b, a
	bank1call CheckWhetherToApplyWeakness
	jr c, .not_weak
	call SwapTurn
	bank1call GetArenaCardWeakness
	call SwapTurn
	and b
	jr z, .not_weak
	; double de
	sla e
	rl d

.not_weak
; handle resistance
	bank1call CheckWhetherToApplyResistance
	jr c, .not_resistant
	call SwapTurn
	bank1call GetArenaCardResistance
	call SwapTurn
	and b
	jr z, .not_resistant
	bank1call GetResistanceModifier
	add hl, de
	ld e, l
	ld d, h

.not_resistant
	ld a, e
	or d
	jr nz, .apply_pluspower_and_defender
	call SwapTurn
	jr .handle_poison

.apply_pluspower_and_defender
	; apply pluspower and defender boosts
	ldh a, [hTempPlayAreaLocation_ff9d]
	add CARD_LOCATION_ARENA
	ld b, a
	call ApplyAttachedPluspower
	call SwapTurn
	ld b, CARD_LOCATION_ARENA
	call ApplyAttachedDefender
	bank1call HandleDamageReduction
	; test if de underflowed
	bit 7, d
	jr z, .handle_poison
	ld de, 0

.handle_poison
	bank1call GetPoisonDamage
	add e
	ld e, a
	ld a, $00
	adc d
	ld d, a
	call SwapTurn

.done
	pop hl
	ld [hl], e
	ld a, d
	or a
	ret z
	cp $80
	ret z
	; cap damage
	ld a, $ff
	ld [hl], a
	ret

; stores in wDamage, wAIMinDamage and wAIMaxDamage the calculated damage
; done to the Pokémon at hTempPlayAreaLocation_ff9d
; by the defending Pokémon, using the attack index at a
; input:
;	a = attack index
;	[hTempPlayAreaLocation_ff9d] = location of card to calculate
;	                               damage as the receiver
EstimateDamage_FromDefendingPokemon:
	call SwapTurn
	ld [wSelectedAttack], a
	ld e, a
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	ld d, a
	call CopyAttackDataAndDamage_FromDeckIndex
	call SwapTurn
	ld a, [wLoadedAttackCategory]
	cp POKEMON_POWER
	jr nz, .is_attack

; is a Pokémon Power
; set wDamage, wAIMinDamage and wAIMaxDamage to zero
	ld hl, wDamage
	xor a
	ld [hli], a
	ld [hl], a
	ld [wAIMinDamage], a
	ld [wAIMaxDamage], a
	ld e, a
	ld d, a
	ret

.is_attack
; set wAIMinDamage and wAIMaxDamage to damage of attack
; these values take into account the range of damage
; that the attack can span (e.g. min and max number of hits)
	bank1call SetDarkWaveAndDarknessVeilDamageModifiers
	ld a, [wDamage]
	ld [wAIMinDamage], a
	ld [wAIMaxDamage], a
	call SwapTurn
	ldh a, [hTempPlayAreaLocation_ff9d]
	push af
	xor a ; PLAY_AREA_ARENA
	ldh [hTempPlayAreaLocation_ff9d], a
	ld a, EFFECTCMDTYPE_AI
	call TryExecuteEffectCommandFunction
	pop af
	ldh [hTempPlayAreaLocation_ff9d], a
	call SwapTurn
	ld a, [wAIMinDamage]
	ld hl, wAIMaxDamage
	or [hl]
	jr nz, .calculation
	ld a, [wDamage]
	ld [wAIMinDamage], a
	ld [wAIMaxDamage], a

.calculation
; if temp. location is active, damage calculation can be done directly...
	ldh a, [hTempPlayAreaLocation_ff9d]
	or a
	jr z, CalculateDamage_FromDefendingPokemon

; ...otherwise substatuses need to be temporarily reset to account
; for the switching, to obtain the right damage calculation...
	ld a, DUELVARS_ARENA_CARD_SUBSTATUS1
	get_turn_duelist_var
	push af
	push hl
	ld [hl], $00
	; reset substatus2
	ld l, DUELVARS_ARENA_CARD_SUBSTATUS2
	ld a, [hl]
	push af
	push hl
	ld [hl], $00
	; reset changed resistance
	ld l, DUELVARS_ARENA_CARD_CHANGED_RESISTANCE
	ld a, [hl]
	push af
	push hl
	ld [hl], $00
	call CalculateDamage_FromDefendingPokemon
; ...and subsequently recovered to continue the duel normally
	pop hl
	pop af
	ld [hl], a
	pop hl
	pop af
	ld [hl], a
	pop hl
	pop af
	ld [hl], a
	ret

; similar to CalculateDamage_VersusDefendingPokemon but reversed,
; calculating damage of the defending Pokémon versus
; the card located in hTempPlayAreaLocation_ff9d
; taking into account weakness/resistance/pluspowers/defenders/etc
; and poison damage for two turns
; and outputs the result capped at a max of $ff
; input:
;	[wAIMinDamage] = base damage
;	[wAIMaxDamage] = base damage
;	[wDamage]      = base damage
;	[hTempPlayAreaLocation_ff9d] = location of card to calculate
;								 damage as the receiver
CalculateDamage_FromDefendingPokemon:
	ld hl, wAIMinDamage
	call .CalculateDamage
	ld hl, wAIMaxDamage
	call .CalculateDamage
	ld hl, wDamage
	; fallthrough

.CalculateDamage
	ld e, [hl]
	ld a, [wDamage + 1]
	ld d, a
	push hl

	; load player active card's data
	call SwapTurn
	xor a
	bank1call LoadPlayAreaCardID_ToTempTurnDuelistCardID
	call SwapTurn

	; load opponent's card data
	ldh a, [hTempPlayAreaLocation_ff9d]
	bank1call LoadPlayAreaCardID_ToTempNonTurnDuelistCardID

	call SwapTurn
	bank1call HandleDamageModifiersEffects
	bit UNAFFECTED_BY_WEAKNESS_RESISTANCE_F, d
	res UNAFFECTED_BY_WEAKNESS_RESISTANCE_F, d
	jr nz, .skip_weakness_resistance

; handle weakness
	bank1call GetArenaCardColor
	call TranslateColorToWR
	ld b, a
	bank1call CheckWhetherToApplyWeakness
	call SwapTurn
	jr c, .not_weak
	ldh a, [hTempPlayAreaLocation_ff9d]
	or a
	jr nz, .bench_weak
	ld a, DUELVARS_ARENA_CARD_CHANGED_WEAKNESS
	get_turn_duelist_var
	or a
	jr nz, .unchanged_weak

.bench_weak
	ldh a, [hTempPlayAreaLocation_ff9d]
	add DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call LoadCardDataToBuffer2_FromDeckIndex
	ld a, [wLoadedCard2Weakness]
.unchanged_weak
	and b
	jr z, .not_weak
	; double de
	sla e
	rl d

.not_weak
; handle resistance
	bank1call CheckWhetherToApplyResistance
	jr c, .not_resistant
	ldh a, [hTempPlayAreaLocation_ff9d]
	or a
	jr nz, .bench_res
	ld a, DUELVARS_ARENA_CARD_CHANGED_RESISTANCE
	get_turn_duelist_var
	or a
	jr nz, .unchanged_res

.bench_res
	ldh a, [hTempPlayAreaLocation_ff9d]
	add DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call LoadCardDataToBuffer2_FromDeckIndex
	ld a, [wLoadedCard2Resistance]
.unchanged_res
	and b
	jr z, .not_resistant
	bank1call GetResistanceModifier
	add hl, de
	ld e, l
	ld d, h

.not_resistant
	call SwapTurn

.skip_weakness_resistance
	ld a, e
	or d
	jr nz, .apply_pluspower_and_defender
	call SwapTurn
	jr .no_underflow

.apply_pluspower_and_defender
	ld b, CARD_LOCATION_ARENA
	call ApplyAttachedPluspower
	call SwapTurn
	ldh a, [hTempPlayAreaLocation_ff9d]
	add CARD_LOCATION_ARENA
	ld b, a
	call ApplyAttachedDefender
	ldh a, [hTempPlayAreaLocation_ff9d]
	or a
	jr nz, .skip_damage_reduction
	bank1call HandleDamageReduction
.skip_damage_reduction
	bit 7, d
	jr z, .no_underflow
	ld de, 0

.no_underflow
	ldh a, [hTempPlayAreaLocation_ff9d]
	or a
	jr nz, .done

	; add poison damage
	bank1call GetPoisonDamage
	add a
	add e
	ld e, a
	ld a, 0
	adc d
	ld d, a

.done
	pop hl
	ld [hl], e
	ld a, d
	or a
	ret z
	ld a, $ff
	ld [hl], a
	ret
