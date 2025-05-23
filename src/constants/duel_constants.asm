DEF MAX_BENCH_POKEMON     EQU 5
DEF MAX_PLAY_AREA_POKEMON EQU 6 ; arena + bench
DEF MAX_SMALL_BENCH_PLAY_AREA_POKEMON EQU 4 ; arena + bench
DEF MAX_HP                EQU 120
DEF HP_BAR_LENGTH         EQU MAX_HP / 10

DEF STARTING_HAND_SIZE EQU 7

; hWhoseTurn constants
DEF PLAYER_TURN   EQUS "HIGH(wPlayerDuelVariables)"
DEF OPPONENT_TURN EQUS "HIGH(wOpponentDuelVariables)"

; wDuelType constants
DEF DUELTYPE_LINK     EQU $1
DEF DUELTYPE_PRACTICE EQU $80
; for normal duels (vs AI), wDuelType is $80 + [wOpponentDeckID]

; wDuelFinished constants
DEF DUEL_NOT_FINISHED EQU $0
DEF TURN_PLAYER_WON   EQU $1
DEF TURN_PLAYER_LOST  EQU $2
DEF TURN_PLAYER_TIED  EQU $3

; wDuelResult constants
DEF DUEL_WIN  EQU $0
DEF DUEL_LOSS EQU $1

; wPlayerDuelVariables or wOpponentDuelVariables constants
DEF DUELVARS_CARD_LOCATIONS                   EQUS "LOW(wPlayerCardLocations)"               ; 00
DEF DUELVARS_PRIZE_CARDS                      EQUS "LOW(wPlayerPrizeCards)"                  ; 3c
DEF DUELVARS_HAND                             EQUS "LOW(wPlayerHand)"                        ; 42
DEF DUELVARS_DECK_CARDS                       EQUS "LOW(wPlayerDeckCards)"                   ; 7e
DEF DUELVARS_NUMBER_OF_CARDS_NOT_IN_DECK      EQUS "LOW(wPlayerNumberOfCardsNotInDeck)"      ; ba
DEF DUELVARS_ARENA_CARD                       EQUS "LOW(wPlayerArenaCard)"                   ; bb
DEF DUELVARS_BENCH                            EQUS "LOW(wPlayerBench)"                       ; bc
DEF DUELVARS_ARENA_CARD_FLAGS                 EQUS "LOW(wPlayerArenaCardFlags)"              ; c2
DEF DUELVARS_ARENA_CARD_HP                    EQUS "LOW(wPlayerArenaCardHP)"                 ; c8
DEF DUELVARS_BENCH1_CARD_HP                   EQUS "LOW(wPlayerBench1CardHP)"                ; c9
DEF DUELVARS_BENCH2_CARD_HP                   EQUS "LOW(wPlayerBench2CardHP)"                ; ca
DEF DUELVARS_BENCH3_CARD_HP                   EQUS "LOW(wPlayerBench3CardHP)"                ; cb
DEF DUELVARS_BENCH4_CARD_HP                   EQUS "LOW(wPlayerBench4CardHP)"                ; cc
DEF DUELVARS_BENCH5_CARD_HP                   EQUS "LOW(wPlayerBench5CardHP)"                ; cd
DEF DUELVARS_ARENA_CARD_STAGE                 EQUS "LOW(wPlayerArenaCardStage)"              ; ce
DEF DUELVARS_BENCH1_CARD_STAGE                EQUS "LOW(wPlayerBench1CardStage)"             ; cf
DEF DUELVARS_BENCH2_CARD_STAGE                EQUS "LOW(wPlayerBench2CardStage)"             ; d0
DEF DUELVARS_BENCH3_CARD_STAGE                EQUS "LOW(wPlayerBench3CardStage)"             ; d1
DEF DUELVARS_BENCH4_CARD_STAGE                EQUS "LOW(wPlayerBench4CardStage)"             ; d2
DEF DUELVARS_BENCH5_CARD_STAGE                EQUS "LOW(wPlayerBench5CardStage)"             ; d3
DEF DUELVARS_ARENA_CARD_CHANGED_TYPE          EQUS "LOW(wPlayerArenaCardChangedType)"        ; d4
DEF DUELVARS_BENCH1_CARD_CHANGED_COLOR        EQUS "LOW(wPlayerBench1CardChangedType)"       ; d5
DEF DUELVARS_BENCH2_CARD_CHANGED_COLOR        EQUS "LOW(wPlayerBench2CardChangedType)"       ; d6
DEF DUELVARS_BENCH3_CARD_CHANGED_COLOR        EQUS "LOW(wPlayerBench3CardChangedType)"       ; d7
DEF DUELVARS_BENCH4_CARD_CHANGED_COLOR        EQUS "LOW(wPlayerBench4CardChangedType)"       ; d8
DEF DUELVARS_BENCH5_CARD_CHANGED_COLOR        EQUS "LOW(wPlayerBench5CardChangedType)"       ; d9
DEF DUELVARS_ARENA_CARD_ATTACHED_DEFENDER     EQUS "LOW(wPlayerArenaCardAttachedDefender)"   ; da
DEF DUELVARS_BENCH1_CARD_ATTACHED_DEFENDER    EQUS "LOW(wPlayerBench1CardAttachedDefender)"  ; db
DEF DUELVARS_BENCH2_CARD_ATTACHED_DEFENDER    EQUS "LOW(wPlayerBench2CardAttachedDefender)"  ; dc
DEF DUELVARS_BENCH3_CARD_ATTACHED_DEFENDER    EQUS "LOW(wPlayerBench3CardAttachedDefender)"  ; dd
DEF DUELVARS_BENCH4_CARD_ATTACHED_DEFENDER    EQUS "LOW(wPlayerBench4CardAttachedDefender)"  ; de
DEF DUELVARS_BENCH5_CARD_ATTACHED_DEFENDER    EQUS "LOW(wPlayerBench5CardAttachedDefender)"  ; df
DEF DUELVARS_ARENA_CARD_ATTACHED_PLUSPOWER    EQUS "LOW(wPlayerArenaCardAttachedPluspower)"  ; e0
DEF DUELVARS_BENCH1_CARD_ATTACHED_PLUSPOWER   EQUS "LOW(wPlayerBench1CardAttachedPluspower)" ; e1
DEF DUELVARS_BENCH2_CARD_ATTACHED_PLUSPOWER   EQUS "LOW(wPlayerBench2CardAttachedPluspower)" ; e2
DEF DUELVARS_BENCH3_CARD_ATTACHED_PLUSPOWER   EQUS "LOW(wPlayerBench3CardAttachedPluspower)" ; e3
DEF DUELVARS_BENCH4_CARD_ATTACHED_PLUSPOWER   EQUS "LOW(wPlayerBench4CardAttachedPluspower)" ; e4
DEF DUELVARS_BENCH5_CARD_ATTACHED_PLUSPOWER   EQUS "LOW(wPlayerBench5CardAttachedPluspower)" ; e5
DEF DUELVARS_ARENA_CARD_FOOD_COUNTERS         EQUS "LOW(wPlayerArenaCardFoodCounters)"       ; e6
DEF DUELVARS_BENCH1_CARD_FOOD_COUNTERS        EQUS "LOW(wPlayerBench1FoodCounters)"          ; e7
DEF DUELVARS_BENCH2_CARD_FOOD_COUNTERS        EQUS "LOW(wPlayerBench2FoodCounters)"          ; e8
DEF DUELVARS_BENCH3_CARD_FOOD_COUNTERS        EQUS "LOW(wPlayerBench3FoodCounters)"          ; e9
DEF DUELVARS_BENCH4_CARD_FOOD_COUNTERS        EQUS "LOW(wPlayerBench4FoodCounters)"          ; ea
DEF DUELVARS_BENCH5_CARD_FOOD_COUNTERS        EQUS "LOW(wPlayerBench5FoodCounters)"          ; eb
DEF DUELVARS_ARENA_CARD_STATUS                EQUS "LOW(wPlayerArenaCardStatus)"             ; ec
DEF DUELVARS_ARENA_CARD_SUBSTATUS1            EQUS "LOW(wPlayerArenaCardSubstatus1)"         ; ed
DEF DUELVARS_ARENA_CARD_SUBSTATUS2            EQUS "LOW(wPlayerArenaCardSubstatus2)"         ; ee
DEF DUELVARS_ARENA_CARD_CHANGED_WEAKNESS      EQUS "LOW(wPlayerArenaCardChangedWeakness)"    ; ef
DEF DUELVARS_ARENA_CARD_CHANGED_RESISTANCE    EQUS "LOW(wPlayerArenaCardChangedResistance)"  ; f0
DEF DUELVARS_ARENA_CARD_SUBSTATUS3            EQUS "LOW(wPlayerArenaCardSubstatus3)"         ; f1
DEF DUELVARS_PRIZES                           EQUS "LOW(wPlayerPrizes)"                      ; f2
DEF DUELVARS_NUMBER_OF_CARDS_IN_DISCARD_PILE  EQUS "LOW(wPlayerNumberOfCardsInDiscardPile)"  ; f3
DEF DUELVARS_NUMBER_OF_CARDS_IN_HAND          EQUS "LOW(wPlayerNumberOfCardsInHand)"         ; f4
DEF DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA   EQUS "LOW(wPlayerNumberOfPokemonInPlayArea)"   ; f5
DEF DUELVARS_DUELIST_TYPE                     EQUS "LOW(wPlayerDuelistType)"                 ; f6
DEF DUELVARS_ARENA_CARD_DISABLED_ATTACK_INDEX EQUS "LOW(wPlayerArenaCardDisabledAttackIndex)" ; f7
DEF DUELVARS_ARENA_CARD_LAST_TURN_DAMAGE      EQUS "LOW(wPlayerArenaCardLastTurnDamage)"     ; f8
DEF DUELVARS_ARENA_CARD_LAST_TURN_STATUS      EQUS "LOW(wPlayerArenaCardLastTurnStatus)"     ; fa
DEF DUELVARS_ARENA_CARD_LAST_TURN_SUBSTATUS2  EQUS "LOW(wPlayerArenaCardLastTurnSubstatus2)" ; fb
DEF DUELVARS_ARENA_CARD_LAST_TURN_CHANGE_WEAK EQUS "LOW(wPlayerArenaCardLastTurnChangeWeak)" ; fc
DEF DUELVARS_ARENA_CARD_LAST_TURN_EFFECT      EQUS "LOW(wPlayerArenaCardLastTurnEffect)"     ; fd
DEF DUELVARS_UNK_FE                           EQUS "LOW(wPlayerUnkfe)"                       ; fe

; card location constants (DUELVARS_CARD_LOCATIONS)
DEF CARD_LOCATION_DECK         EQU $00
DEF CARD_LOCATION_HAND         EQU $01
DEF CARD_LOCATION_DISCARD_PILE EQU $02
DEF CARD_LOCATION_PRIZE        EQU $08
DEF CARD_LOCATION_ARENA        EQU $10
DEF CARD_LOCATION_BENCH_1      EQU $11
DEF CARD_LOCATION_BENCH_2      EQU $12
DEF CARD_LOCATION_BENCH_3      EQU $13
DEF CARD_LOCATION_BENCH_4      EQU $14
DEF CARD_LOCATION_BENCH_5      EQU $15

; card location flags (DUELVARS_CARD_LOCATIONS)
DEF CARD_LOCATION_PLAY_AREA_F  EQU 4 ; includes arena and bench
DEF CARD_LOCATION_PLAY_AREA    EQU 1 << CARD_LOCATION_PLAY_AREA_F
DEF CARD_LOCATION_JUST_DRAWN_F EQU 6
DEF CARD_LOCATION_JUST_DRAWN   EQU 1 << CARD_LOCATION_JUST_DRAWN_F

; play area location offsets (CARD_LOCATION_* - CARD_LOCATION_PLAY_AREA)
DEF PLAY_AREA_ARENA   EQU $0
DEF PLAY_AREA_BENCH_1 EQU $1
DEF PLAY_AREA_BENCH_2 EQU $2
DEF PLAY_AREA_BENCH_3 EQU $3
DEF PLAY_AREA_BENCH_4 EQU $4
DEF PLAY_AREA_BENCH_5 EQU $5

; duelist types (DUELVARS_DUELIST_TYPE)
DEF DUELIST_TYPE_PLAYER   EQU $00
DEF DUELIST_TYPE_LINK_OPP EQU $01
DEF DUELIST_TYPE_AI_OPP   EQU $80 ; $80 + [wOpponentDeckID]

; status conditions (DUELVARS_ARENA_CARD_STATUS)
; two statuses can be combined if they are identified by a different nybble
DEF NO_STATUS       EQU $00
DEF CONFUSED        EQU $01
DEF ASLEEP          EQU $02
DEF PARALYZED       EQU $03
DEF POISONED        EQU $80
DEF DOUBLE_POISONED EQU $c0


DEF DOUBLE_POISONED_F EQU 6
DEF POISONED_F        EQU 7


DEF CNF_SLP_PRZ   EQU $0f ; confused, asleep or paralyzed
DEF PSN_DBLPSN    EQU $f0 ; poisoned or double poisoned
DEF PSN_DAMAGE    EQU 10
DEF DBLPSN_DAMAGE EQU 20

; substatus conditions (DUELVARS_ARENA_CARD_SUBSTATUS*)

; SUBSTATUS1 are checked on a defending Pokemon
DEF SUBSTATUS1_UNK_0D       EQU $0d
DEF SUBSTATUS1_AGILITY      EQU $11
DEF SUBSTATUS1_FLY          EQU $12
DEF SUBSTATUS1_HARDEN       EQU $13
DEF SUBSTATUS1_NO_DAMAGE_STIFFEN  EQU $14
DEF SUBSTATUS1_NO_DAMAGE_10 EQU $15
DEF SUBSTATUS1_NO_DAMAGE_11 EQU $16
DEF SUBSTATUS1_REDUCE_BY_20 EQU $18
DEF SUBSTATUS1_BARRIER      EQU $19
DEF SUBSTATUS1_HALVE_DAMAGE EQU $1a
DEF SUBSTATUS1_DESTINY_BOND EQU $1b
DEF SUBSTATUS1_NO_DAMAGE_17 EQU $1c
DEF SUBSTATUS1_NEXT_TURN_DOUBLE_DAMAGE EQU $1e
DEF SUBSTATUS1_REDUCE_BY_10 EQU $23
DEF SUBSTATUS1_UNK_25       EQU $25
DEF SUBSTATUS1_UNK_26       EQU $26
DEF SUBSTATUS1_UNK_27       EQU $27
DEF SUBSTATUS1_UNK_28       EQU $28
DEF SUBSTATUS1_DOUBLE_DAMAGE       EQU $29
DEF SUBSTATUS1_HIDE         EQU $2a
DEF SUBSTATUS1_USED_DRILL_DIVE EQU $30

; SUBSTATUS2 are checked on an attacking Pokemon
DEF SUBSTATUS2_SMOKESCREEN  EQU $01
DEF SUBSTATUS2_SAND_ATTACK  EQU $02
DEF SUBSTATUS2_REDUCE_BY_20 EQU $03
DEF SUBSTATUS2_AMNESIA      EQU $04
DEF SUBSTATUS2_TAIL_WAG     EQU $05
DEF SUBSTATUS2_LEER         EQU $06
DEF SUBSTATUS2_POUNCE       EQU $07
DEF SUBSTATUS2_CONVERSION2  EQU $08
DEF SUBSTATUS2_ACID         EQU $09
DEF SUBSTATUS2_BONE_ATTACK  EQU $0b
DEF SUBSTATUS2_ROCK_SEAL    EQU $0e
DEF SUBSTATUS2_DISABLE      EQU $0f
DEF SUBSTATUS2_GROWL        EQU $17

DEF SUBSTATUS3_THIS_TURN_DOUBLE_DAMAGE_F EQU 0
DEF SUBSTATUS3_HEADACHE_F                EQU 2
DEF SUBSTATUS3_SPOOKIFY_F                EQU 3
DEF SUBSTATUS3_UNK_4_F                   EQU 4
DEF SUBSTATUS3_UNK_5_F                   EQU 5
DEF SUBSTATUS3_UNK_6_F                   EQU 6
DEF SUBSTATUS3_PERPLEX_F                 EQU 7

; DUELVARS_ARENA_CARD_FLAGS constants
DEF PLAY_AREA_FLAG_UNK_1_F      EQU 1
DEF PLAY_AREA_FLAG_UNK_2_F      EQU 2
DEF PLAY_AREA_FLAG_UNK_3_F      EQU 3
DEF AFFECTED_BY_STARE_F         EQU 4
DEF USED_PKMN_POWER_THIS_TURN_F EQU 5
DEF USED_LEEK_SLAP_THIS_DUEL_F  EQU 6
DEF CAN_EVOLVE_THIS_TURN_F      EQU 7

DEF AFFECTED_BY_STARE           EQU 1 << AFFECTED_BY_STARE_F
DEF USED_PKMN_POWER_THIS_TURN   EQU 1 << USED_PKMN_POWER_THIS_TURN_F
DEF USED_LEEK_SLAP_THIS_DUEL    EQU 1 << USED_LEEK_SLAP_THIS_DUEL_F
DEF CAN_EVOLVE_THIS_TURN        EQU 1 << CAN_EVOLVE_THIS_TURN_F

; DUELVARS_ARENA_CARD_LAST_TURN_EFFECT constants
	const_def
	const LAST_TURN_EFFECT_NONE           ; $00
	const LAST_TURN_EFFECT_DISCARD_ENERGY ; $01
	const LAST_TURN_EFFECT_AMNESIA        ; $02

; *_CHANGED_COLOR constants
DEF HAS_CHANGED_COLOR_F EQU 7
DEF HAS_CHANGED_COLOR   EQU 1 << HAS_CHANGED_COLOR_F

; flag in wDamage + 1 that indicates
; whether damage is unaffected by Weakness/Resistance
DEF UNAFFECTED_BY_WEAKNESS_RESISTANCE_F EQU 7

; effect command constants (TryExecuteEffectCommandFunction)
; ordered by (roughly) execution time
DEF EFFECTCMDTYPE_INITIAL_EFFECT_1         EQU $01
DEF EFFECTCMDTYPE_INITIAL_EFFECT_2         EQU $02
DEF EFFECTCMDTYPE_DISCARD_ENERGY           EQU $06
DEF EFFECTCMDTYPE_REQUIRE_SELECTION        EQU $05
DEF EFFECTCMDTYPE_BEFORE_DAMAGE            EQU $03
DEF EFFECTCMDTYPE_AFTER_DAMAGE             EQU $04
DEF EFFECTCMDTYPE_AI_SELECTION             EQU $08
DEF EFFECTCMDTYPE_AI_SWITCH_DEFENDING_PKMN EQU $0a
DEF EFFECTCMDTYPE_PKMN_POWER_TRIGGER       EQU $07
DEF EFFECTCMDTYPE_AI                       EQU $09
DEF EFFECTCMDTYPE_UNK_11                   EQU $0b

; wDamageEffectiveness constants
DEF WEAKNESS   EQU 1
DEF RESISTANCE EQU 2

; wNoDamageOrEffect constants
DEF NO_DAMAGE_OR_EFFECT_AGILITY      EQU $01
DEF NO_DAMAGE_OR_EFFECT_BARRIER      EQU $02
DEF NO_DAMAGE_OR_EFFECT_FLY          EQU $03
DEF NO_DAMAGE_OR_EFFECT_TRANSPARENCY EQU $04
DEF NO_DAMAGE_OR_EFFECT_NSHIELD      EQU $05
DEF NO_DAMAGE_OR_EFFECT_HIDE         EQU $06

; OppAction_* constants (OppActionTable)
	const_def
	const OPPACTION_ERROR                     ; $00
	const OPPACTION_PLAY_BASIC_PKMN           ; $01
	const OPPACTION_EVOLVE_PKMN               ; $02
	const OPPACTION_PLAY_ENERGY               ; $03
	const OPPACTION_ATTEMPT_RETREAT           ; $04
	const OPPACTION_FINISH_NO_ATTACK          ; $05
	const OPPACTION_PLAY_TRAINER              ; $06
	const OPPACTION_EXECUTE_TRAINER_EFFECTS   ; $07
	const OPPACTION_BEGIN_ATTACK              ; $08
	const OPPACTION_USE_ATTACK                ; $09
	const OPPACTION_ATTACK_ANIM_AND_DAMAGE    ; $0a
	const OPPACTION_DRAW_CARD                 ; $0b
	const OPPACTION_UNK_0C                    ; $0c
	const OPPACTION_USE_PKMN_POWER            ; $0d
	const OPPACTION_EXECUTE_PKMN_POWER_EFFECT ; $0e
	const OPPACTION_FORCE_SWITCH_ACTIVE       ; $0f
	const OPPACTION_NO_ACTION_0F              ; $10
	const OPPACTION_NO_ACTION_10              ; $11
	const OPPACTION_TOSS_COIN_A_TIMES         ; $12
	const OPPACTION_6B30                      ; $13
	const OPPACTION_NO_ACTION_13              ; $14
	const OPPACTION_USE_METRONOME_ATTACK      ; $15
	const OPPACTION_6B15                      ; $16
	const OPPACTION_DUEL_MAIN_SCENE           ; $17
	const OPPACTION_UNK_18                    ; $18
	const OPPACTION_UNK_19                    ; $19
	const OPPACTION_UNK_1A                    ; $1a
	const OPPACTION_UNK_1B                    ; $1b
	const OPPACTION_UNK_1C                    ; $1c
DEF NUM_OPP_ACTIONS EQU const_value

; constants for PracticeDuelActionTable entries
	const_def 1
	const PRACTICEDUEL_DRAW_SEVEN_CARDS
	const PRACTICEDUEL_PLAY_DIGLETT
	const PRACTICEDUEL_PUT_NIDORANM_IN_BENCH
	const PRACTICEDUEL_VERIFY_INITIAL_PLAY
	const PRACTICEDUEL_DONE_PUTTING_ON_BENCH
	const PRACTICEDUEL_PRINT_TURN_INSTRUCTIONS
	const PRACTICEDUEL_VERIFY_PLAYER_TURN_ACTIONS
	const PRACTICEDUEL_REPEAT_INSTRUCTIONS
	const PRACTICEDUEL_PLAY_STARYU_FROM_BENCH
	const PRACTICEDUEL_REPLACE_KNOCKED_OUT_POKEMON

; wEffectFailed constants
DEF EFFECT_FAILED_NO_EFFECT    EQU $01
DEF EFFECT_FAILED_UNSUCCESSFUL EQU $02

; wAnimationQueue length
DEF ANIMATION_QUEUE_LENGTH EQU 7

DEF PRIZES_1    EQU $01
DEF PRIZES_2    EQU $02
DEF PRIZES_3    EQU $03
DEF PRIZES_4    EQU $04
DEF PRIZES_5    EQU $05
DEF PRIZES_6    EQU $06

; constants to use as input to LookForCardInDeck
	const_def
	const SEARCHEFFECT_CARD_ID        ; $0
	const SEARCHEFFECT_NIDORAN        ; $1
	const SEARCHEFFECT_BASIC_FIGHTING ; $2
	const SEARCHEFFECT_BASIC_ENERGY   ; $3
	const SEARCHEFFECT_POKEMON        ; $4

; special rule constants, stored in wSpecialRule
	const_def
	const NO_SPECIAL_RULE ; $0
	const CHLOROPHYLL     ; $1
	const THUNDER_CHARGE  ; $2
	const FLAME_ARMOR     ; $3
	const SMALL_BENCH     ; $4
	const RUNNING_WATER   ; $5
	const EARTH_POWER     ; $6
	const LOW_RESISTANCE  ; $7
	const ENERGY_RETURN   ; $8
	const TOUGH_ESCAPE    ; $9
	const BLACK_HOLE      ; $a

; constants to use as input to SetCardSearchFuncParams
	const_def
	const CARDSEARCH_CARD_ID                     ; $0
	const CARDSEARCH_NIDORAN                     ; $1
	const CARDSEARCH_BASIC_FIGHTING_POKEMON      ; $2
	const CARDSEARCH_BASIC_ENERGY                ; $3
	const CARDSEARCH_ANY_ENERGY                  ; $4
	const CARDSEARCH_POKEDEX_NUMBER              ; $5
	const CARDSEARCH_DARK_POKEMON                ; $6
	const CARDSEARCH_PSYCHIC_ENERGY              ; $7
	const CARDSEARCH_EVOLUTION_POKEMON           ; $8
	const CARDSEARCH_UNK_9                       ; $9
	const CARDSEARCH_TRAINER                     ; $a
	const CARDSEARCH_EVOLUTION_COLORLESS_POKEMON ; $b
	const CARDSEARCH_LIGHTNING_ENERGY            ; $c
	const CARDSEARCH_UNK_D                       ; $d
	const CARDSEARCH_BASIC_POKEMON               ; $e
