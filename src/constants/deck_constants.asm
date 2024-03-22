MACRO deck_const
	IF const_value >= 2
		DEF \1_ID EQU const_value - 2
	ENDC
	const \1
ENDM

; Both *_DECK and *_DECK_ID constants are defined here.
; *_DECK constants are to be used with LoadDeck and related routines.
; *_DECK_ID constants are specific to be loaded into wOpponentDeckID.
; Always, *_DECK_ID = *_DECK - 2. UNKNOWN_POISON_STORM_DECK_ID,
; GB1_STRANGE_PSYSHOCK_DECK_ID and UNKNOWN_SAMS_PRACTICE_DECK_ID do not exist.
	const_def
	deck_const UNKNOWN_POISON_STORM_DECK             ; $00
	deck_const GB1_STRANGE_PSYSHOCK_DECK             ; $01
	deck_const UNKNOWN_SAMS_PRACTICE_DECK            ; $02
	deck_const PLAYER_PRACTICE_DECK                  ; $03
	deck_const STARTER_DECK                          ; $04
	deck_const SWEAT_ANTI_GR1_DECK                   ; $05
	deck_const GIVE_IN_ANTI_GR2_DECK                 ; $06
	deck_const VENGEFUL_ANTI_GR3_DECK                ; $07
	deck_const UNFORGIVING_ANTI_GR4_DECK             ; $08
	deck_const SAMS_PRACTICE_DECK                    ; $09
	deck_const AARON_PRACTICE_DECK1                  ; $0a
	deck_const AARONS_STEP1_DECK                     ; $0b
	deck_const AARON_PRACTICE_DECK2                  ; $0c
	deck_const AARONS_STEP2_DECK                     ; $0d
	deck_const AARON_PRACTICE_DECK3                  ; $0e
	deck_const AARONS_STEP3_DECK                     ; $0f
	deck_const BRICK_WALK_DECK                       ; $10
	deck_const BENCH_TRAP_DECK                       ; $11
	deck_const SKY_SPARK_DECK                        ; $12
	deck_const ELECTRIC_SELFDESTRUCT_DECK            ; $13
	deck_const OVERFLOW_DECK                         ; $14
	deck_const TRIPLE_ZAPDOS_DECK                    ; $15
	deck_const I_LOVE_PIKACHU_DECK                   ; $16
	deck_const TEN_THOUSAND_VOLTS_DECK               ; $17
	deck_const HAND_OVER_GR_DECK                     ; $18
	deck_const PSYCHIC_ELITE_DECK                    ; $19
	deck_const PSYCHOKINESIS_DECK                    ; $1a
	deck_const PHANTOM_DECK                          ; $1b
	deck_const PUPPET_MASTER_DECK                    ; $1c
	deck_const EVEN3_YEARS_ON_A_ROCK_DECK            ; $1d
	deck_const ROLLING_STONE_DECK                    ; $1e
	deck_const GREAT_EARTHQUAKE_DECK                 ; $1f
	deck_const AWESOME_FOSSIL_DECK                   ; $20
	deck_const RAGING_BILLOW_OF_FISTS_DECK           ; $21
	deck_const YOU_CAN_DO_IT_MACHOP_DECK             ; $22
	deck_const NEW_MACHOKE_DECK                      ; $23
	deck_const SKILLED_WARRIOR_DECK                  ; $24
	deck_const I_LOVE_TO_FIGHT_DECK                  ; $25
	deck_const MAX_ENERGY_DECK                       ; $26
	deck_const REMAINING_GREEN_DECK                  ; $27
	deck_const POISON_CURSE_DECK                     ; $28
	deck_const GLITTERING_SCALES_DECK                ; $29
	deck_const STEADY_INCREASE_DECK                  ; $2a
	deck_const DARK_SCIENCE_DECK                     ; $2b
	deck_const NATURAL_SCIENCE_DECK                  ; $2c
	deck_const POISONOUS_SWAMP_DECK                  ; $2d
	deck_const GATHERING_NIDORAN_DECK                ; $2e
	deck_const RAIN_DANCE_CONFUSION_DECK             ; $2f
	deck_const CONSERVING_WATER_DECK                 ; $30
	deck_const ENERGY_REMOVAL_DECK                   ; $31
	deck_const SPLASHING_ABOUT_DECK                  ; $32
	deck_const BEACH_DECK                            ; $33
	deck_const GO_ARCANINE_DECK                      ; $34
	deck_const FLAME_FESTIVAL_DECK                   ; $35
	deck_const IMMORTAL_FLAME_DECK                   ; $36
	deck_const ELECTRIC_CURRENT_SHOCK_DECK           ; $37
	deck_const GREAT_ROCKET4_DECK                    ; $38
	deck_const GREAT_ROCKET1_DECK                    ; $39
	deck_const GREAT_ROCKET2_DECK                    ; $3a
	deck_const GREAT_ROCKET3_DECK                    ; $3b
	deck_const GRAND_FIRE_DECK                       ; $3c
	deck_const LEGENDARY_FOSSIL_DECK                 ; $3d
	deck_const WATER_LEGEND_DECK                     ; $3e
	deck_const GREAT_DRAGON_DECK                     ; $3f
	deck_const BUG_COLLECTING_DECK                   ; $40
	deck_const DEMONIC_FOREST_DECK                   ; $41
	deck_const STICKY_POISON_GAS_DECK                ; $42
	deck_const MAD_PETALS_DECK                       ; $43
	deck_const DANGEROUS_BENCH_DECK                  ; $44
	deck_const CHAIN_LIGHTNING_BY_PIKACHU_DECK       ; $45
	deck_const THIS_IS_THE_POWER_OF_ELECTRICITY_DECK ; $46
	deck_const QUICK_ATTACK_DECK                     ; $47
	deck_const COMPLETE_COMBUSTION_DECK              ; $48
	deck_const FIREBALL_DECK                         ; $49
	deck_const EEVEE_SHOWDOWN_DECK                   ; $4a
	deck_const GAZE_UPON_THE_POWER_OF_FIRE_DECK      ; $4b
	deck_const WHIRLPOOL_SHOWER_DECK                 ; $4c
	deck_const PARALYZED_PARALYZED_DECK              ; $4d
	deck_const BENCH_CALL_DECK                       ; $4e
	deck_const WATER_STREAM_DECK                     ; $4f
	deck_const ROCK_BLAST_DECK                       ; $50
	deck_const FULL_STRENGTH_DECK                    ; $51
	deck_const RUNNING_WILD_DECK                     ; $52
	deck_const DIRECT_HIT_DECK                       ; $53
	deck_const SUPERDESTRUCTIVE_POWER_DECK           ; $54
	deck_const BAD_DREAM_DECK                        ; $55
	deck_const POKEMON_POWER_DECK                    ; $56
	deck_const SPIRITED_AWAY_DECK                    ; $57
	deck_const SNORLAX_GUARD_DECK                    ; $58
	deck_const EYE_OF_THE_STORM_DECK                 ; $59
	deck_const SUDDEN_GROWTH_DECK                    ; $5a
	deck_const VERY_RARE_CARD_DECK                   ; $5b
	deck_const BAD_GUYS_DECK                         ; $5c
	deck_const POISON_MIST_DECK                      ; $5d
	deck_const ULTRA_REMOVAL_DECK                    ; $5e
	deck_const PSYCHIC_BATTLE_DECK                   ; $5f
	deck_const STOP_LIFE_DECK                        ; $60
	deck_const SCORCHER_DECK                         ; $61
	deck_const TSUNAMI_STARTER_DECK                  ; $62
	deck_const SMASH_TO_MINCEMEAT_DECK               ; $63
	deck_const TEST_YOUR_LUCK_DECK                   ; $64
	deck_const PROTOHISTORIC_DECK                    ; $65
	deck_const TEXTURE_TUNER7_DECK                   ; $66
	deck_const COLORLESS_ENERGY_DECK                 ; $67
	deck_const POWERFUL_POKEMON_DECK                 ; $68
	deck_const WEIRD_DECK                            ; $69
	deck_const STRANGE_DECK                          ; $6a
	deck_const RONALDS_UNCOOL_DECK                   ; $6b
	deck_const RONALDS_GRX_DECK                      ; $6c
	deck_const RONALDS_POWER_DECK                    ; $6d
	deck_const RONALDS_PSYCHIC_DECK                  ; $6e
	deck_const RONALDS_ULTRA_DECK                    ; $6f
	deck_const EVERYBODYS_FRIEND_DECK                ; $70
	deck_const IMMORTAL_POKEMON_DECK                 ; $71
	deck_const TORRENTIAL_FLOOD_DECK                 ; $72
	deck_const TRAINER_IMPRISON_DECK                 ; $73
	deck_const BLAZING_FLAME_DECK                    ; $74
	deck_const DAMAGE_CHAOS_DECK                     ; $75
	deck_const BIG_THUNDER_DECK                      ; $76
	deck_const POWER_OF_DARKNESS_DECK                ; $77
	deck_const POISON_STORM_DECK                     ; $78
	deck_const DECK_7269                             ; $79
DEF NUM_DECK_IDS EQU const_value - 3
