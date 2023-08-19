SECTION "Bank 9@409a", ROMX[$409a], BANK[$9]

; return carry if saved duel checksum
; in SRAM is not valid
CheckSavedDuelChecksum:
	call EnableSRAM
	ld hl, sSavedDuel
	ld a, [sSavedDuelChecksum + $2]
	call DisableSRAM
	cp $01
	jr nz, .continue
	scf
	ret

.continue
	call EnableSRAM
	push de
	ld a, [hli] ; sSavedDuel
	or a
	jr z, .set_carry
	lb de, $23, $45
	ld bc, $352
	ld a, [hl] ; sSavedDuelChecksum
	sub e
	ld e, a
	inc hl
	ld a, [hl]
	xor d
	ld d, a
	inc hl
	inc hl
	; hl = sSavedDuelData
.loop_data
	ld a, [hl]
	add e
	ld e, a
	ld a, [hli]
	xor d
	ld d, a
	dec bc
	ld a, c
	or b
	jr nz, .loop_data
	ld a, e
	or d
	jr z, .no_carry
.set_carry
	scf
.no_carry
	call DisableSRAM
	pop de
	ret

ClearSavedDuel:
	call EnableSRAM
	ld hl, sSavedDuel
	xor a
	ld [hli], a
	ld [hli], a
	ld [hl], a
	call DisableSRAM
	ret
; 0x240e6

SECTION "Bank 9@5934", ROMX[$5934], BANK[$9]

; a = deck ID
LoadDeckIDData:
	ld [wcc16], a
	ld c, a
	ld hl, DeckIDData
.loop_find
	ld a, [hl]
	cp $ff
	jr z, .not_found
	cp c
	jr z, .found
	ld de, 12
	add hl, de
	jr .loop_find
.not_found
	scf
	ret

.found
	inc hl
	ld a, [hli]
	ld [wOpponentDeckName + 0], a
	ld a, [hli]
	ld [wOpponentDeckName + 1], a
	ld a, [hli]
	ld [wOpponentName + 0], a
	ld a, [hli]
	ld [wOpponentName + 1], a
	ld a, [hli]
	ld [wcc12], a
	ld a, [hli]
	ld [wcc15], a
	ld a, [hli]
	ld [wcc10], a
	ld a, [hli]
	ld [wcd0e], a
	ld a, [hli]
	ld [wcc17], a
	ld a, [hli]
	ld [wcd0f], a
	ld a, [hli]
	ld [wcc18], a
	or a
	ret

DeckIDData:
	db PLAYER_PRACTICE_DECK_ID
	tx Text04d6 ; deck name
	tx Text04d5 ; opponent name
	db $05 ; ?
	db $02 ; ?
	db $00 ; ?
	db $00 ; ?
	db $02 ; ?
	db $12 ; ?
	db $00 ; ?

	db STARTER_DECK_ID
	tx Text0448 ; deck name
	tx Text04f6 ; opponent name
	db $00 ; ?
	db $00 ; ?
	db $00 ; ?
	db $00 ; ?
	db $00 ; ?
	db $00 ; ?
	db $00 ; ?

	db SWEAT_ANTI_GR1_DECK_ID
	tx Text044d ; deck name
	tx Text04f6 ; opponent name
	db $00 ; ?
	db $00 ; ?
	db $00 ; ?
	db $00 ; ?
	db $00 ; ?
	db $00 ; ?
	db $00 ; ?

	db GIVE_IN_ANTI_GR2_DECK_ID
	tx Text0466 ; deck name
	tx Text04f6 ; opponent name
	db $00 ; ?
	db $00 ; ?
	db $00 ; ?
	db $00 ; ?
	db $00 ; ?
	db $00 ; ?
	db $00 ; ?

	db VENGEFUL_ANTI_GR3_DECK_ID
	tx Text0449 ; deck name
	tx Text04f6 ; opponent name
	db $00 ; ?
	db $00 ; ?
	db $00 ; ?
	db $00 ; ?
	db $00 ; ?
	db $00 ; ?
	db $00 ; ?

	db UNFORGIVING_ANTI_GR4_DECK_ID
	tx Text0470 ; deck name
	tx Text04f6 ; opponent name
	db $00 ; ?
	db $00 ; ?
	db $00 ; ?
	db $00 ; ?
	db $00 ; ?
	db $00 ; ?
	db $00 ; ?

	db SAMS_PRACTICE_DECK_ID
	tx Text04f1 ; deck name
	tx Text04f6 ; opponent name
	db $00 ; ?
	db $00 ; ?
	db $00 ; ?
	db $00 ; ?
	db $00 ; ?
	db $00 ; ?
	db $00 ; ?

	db AARON_PRACTICE_DECK1_ID
	tx Text04d6 ; deck name
	tx Text04d5 ; opponent name
	db $05 ; ?
	db $02 ; ?
	db $00 ; ?
	db $00 ; ?
	db $02 ; ?
	db $12 ; ?
	db $00 ; ?

	db AARONS_STEP1_DECK_ID
	tx Text04af ; deck name
	tx Text04f6 ; opponent name
	db $00 ; ?
	db $00 ; ?
	db $00 ; ?
	db $00 ; ?
	db $00 ; ?
	db $00 ; ?
	db $00 ; ?

	db AARON_PRACTICE_DECK2_ID
	tx Text0433 ; deck name
	tx Text0432 ; opponent name
	db $06 ; ?
	db $04 ; ?
	db $00 ; ?
	db $00 ; ?
	db $02 ; ?
	db $12 ; ?
	db $00 ; ?

	db AARONS_STEP2_DECK_ID
	tx Text04b0 ; deck name
	tx Text04f6 ; opponent name
	db $00 ; ?
	db $00 ; ?
	db $00 ; ?
	db $00 ; ?
	db $00 ; ?
	db $00 ; ?
	db $00 ; ?

	db AARON_PRACTICE_DECK3_ID
	tx Text0434 ; deck name
	tx Text0432 ; opponent name
	db $06 ; ?
	db $04 ; ?
	db $00 ; ?
	db $00 ; ?
	db $02 ; ?
	db $12 ; ?
	db $00 ; ?

	db AARONS_STEP3_DECK_ID
	tx Text04b1 ; deck name
	tx Text04f6 ; opponent name
	db $00 ; ?
	db $00 ; ?
	db $00 ; ?
	db $00 ; ?
	db $00 ; ?
	db $00 ; ?
	db $00 ; ?

	db BRICK_WALK_DECK_ID
	tx Text0435 ; deck name
	tx Text0432 ; opponent name
	db $06 ; ?
	db $04 ; ?
	db $00 ; ?
	db $00 ; ?
	db $02 ; ?
	db $12 ; ?
	db $00 ; ?

	db BENCH_TRAP_DECK_ID
	tx Text043e ; deck name
	tx Text0432 ; opponent name
	db $06 ; ?
	db $04 ; ?
	db $00 ; ?
	db $00 ; ?
	db $02 ; ?
	db $12 ; ?
	db $00 ; ?

	db SKY_SPARK_DECK_ID
	tx Text044b ; deck name
	tx Text0432 ; opponent name
	db $06 ; ?
	db $04 ; ?
	db $00 ; ?
	db $00 ; ?
	db $02 ; ?
	db $12 ; ?
	db $00 ; ?

	db ELECTRIC_SELFDESTRUCT_DECK_ID
	tx Text049d ; deck name
	tx Text04a3 ; opponent name
	db $0a ; ?
	db $06 ; ?
	db $00 ; ?
	db $00 ; ?
	db $03 ; ?
	db $09 ; ?
	db $05 ; ?

	db OVERFLOW_DECK_ID
	tx Text04c1 ; deck name
	tx Text04a3 ; opponent name
	db $0a ; ?
	db $06 ; ?
	db $00 ; ?
	db $00 ; ?
	db $03 ; ?
	db $09 ; ?
	db $05 ; ?

	db TRIPLE_ZAPDOS_DECK_ID
	tx Text0481 ; deck name
	tx Text04a0 ; opponent name
	db $0c ; ?
	db $04 ; ?
	db $00 ; ?
	db $00 ; ?
	db $02 ; ?
	db $01 ; ?
	db $00 ; ?

	db I_LOVE_PIKACHU_DECK_ID
	tx Text04ad ; deck name
	tx Text04a0 ; opponent name
	db $0c ; ?
	db $04 ; ?
	db $00 ; ?
	db $00 ; ?
	db $02 ; ?
	db $01 ; ?
	db $05 ; ?

	db TEN_THOUSAND_VOLTS_DECK_ID
	tx Text04c4 ; deck name
	tx Text04e4 ; opponent name
	db $0b ; ?
	db $04 ; ?
	db $00 ; ?
	db $00 ; ?
	db $02 ; ?
	db $01 ; ?
	db $00 ; ?

	db HAND_OVER_GR_DECK_ID
	tx Text0426 ; deck name
	tx Text04aa ; opponent name
	db $0d ; ?
	db $04 ; ?
	db $00 ; ?
	db $00 ; ?
	db $02 ; ?
	db $01 ; ?
	db $00 ; ?

	db PSYCHIC_ELITE_DECK_ID
	tx Text0471 ; deck name
	tx Text04d4 ; opponent name
	db $0e ; ?
	db $06 ; ?
	db $00 ; ?
	db $00 ; ?
	db $03 ; ?
	db $0a ; ?
	db $06 ; ?

	db PSYCHOKINESIS_DECK_ID
	tx Text0453 ; deck name
	tx Text04d4 ; opponent name
	db $0e ; ?
	db $06 ; ?
	db $00 ; ?
	db $00 ; ?
	db $03 ; ?
	db $0a ; ?
	db $06 ; ?

	db PHANTOM_DECK_ID
	tx Text0496 ; deck name
	tx Text04ec ; opponent name
	db $0f ; ?
	db $04 ; ?
	db $00 ; ?
	db $00 ; ?
	db $02 ; ?
	db $02 ; ?
	db $00 ; ?

	db PUPPET_MASTER_DECK_ID
	tx Text046e ; deck name
	tx Text04bd ; opponent name
	db $11 ; ?
	db $04 ; ?
	db $00 ; ?
	db $00 ; ?
	db $02 ; ?
	db $02 ; ?
	db $00 ; ?

	db EVEN3_YEARS_ON_A_ROCK_DECK_ID
	tx Text045f ; deck name
	tx Text0491 ; opponent name
	db $10 ; ?
	db $04 ; ?
	db $00 ; ?
	db $00 ; ?
	db $02 ; ?
	db $02 ; ?
	db $00 ; ?

	db ROLLING_STONE_DECK_ID
	tx Text0438 ; deck name
	tx Text0493 ; opponent name
	db $12 ; ?
	db $06 ; ?
	db $00 ; ?
	db $00 ; ?
	db $03 ; ?
	db $0b ; ?
	db $07 ; ?

	db GREAT_EARTHQUAKE_DECK_ID
	tx Text04f3 ; deck name
	tx Text04de ; opponent name
	db $13 ; ?
	db $04 ; ?
	db $00 ; ?
	db $00 ; ?
	db $02 ; ?
	db $03 ; ?
	db $00 ; ?

	db AWESOME_FOSSIL_DECK_ID
	tx Text044f ; deck name
	tx Text04b8 ; opponent name
	db $14 ; ?
	db $04 ; ?
	db $00 ; ?
	db $00 ; ?
	db $02 ; ?
	db $03 ; ?
	db $00 ; ?

	db RAGING_BILLOW_OF_FISTS_DECK_ID
	tx Text0498 ; deck name
	tx Text049c ; opponent name
	db $15 ; ?
	db $04 ; ?
	db $00 ; ?
	db $00 ; ?
	db $02 ; ?
	db $03 ; ?
	db $00 ; ?

	db YOU_CAN_DO_IT_MACHOP_DECK_ID
	tx Text04b2 ; deck name
	tx Text04e0 ; opponent name
	db $16 ; ?
	db $06 ; ?
	db $00 ; ?
	db $00 ; ?
	db $03 ; ?
	db $0c ; ?
	db $0c ; ?

	db NEW_MACHOKE_DECK_ID
	tx Text0440 ; deck name
	tx Text04ce ; opponent name
	db $17 ; ?
	db $04 ; ?
	db $00 ; ?
	db $00 ; ?
	db $02 ; ?
	db $04 ; ?
	db $00 ; ?

	db SKILLED_WARRIOR_DECK_ID
	tx Text04b7 ; deck name
	tx Text04ce ; opponent name
	db $17 ; ?
	db $04 ; ?
	db $00 ; ?
	db $00 ; ?
	db $02 ; ?
	db $04 ; ?
	db $00 ; ?

	db I_LOVE_TO_FIGHT_DECK_ID
	tx Text046a ; deck name
	tx Text04a5 ; opponent name
	db $18 ; ?
	db $04 ; ?
	db $00 ; ?
	db $00 ; ?
	db $02 ; ?
	db $04 ; ?
	db $00 ; ?

	db MAX_ENERGY_DECK_ID
	tx Text04bb ; deck name
	tx Text04b5 ; opponent name
	db $19 ; ?
	db $04 ; ?
	db $00 ; ?
	db $00 ; ?
	db $02 ; ?
	db $04 ; ?
	db $00 ; ?

	db REMAINING_GREEN_DECK_ID
	tx Text042c ; deck name
	tx Text0489 ; opponent name
	db $1a ; ?
	db $06 ; ?
	db $00 ; ?
	db $00 ; ?
	db $03 ; ?
	db $0d ; ?
	db $02 ; ?

	db POISON_CURSE_DECK_ID
	tx Text0461 ; deck name
	tx Text0475 ; opponent name
	db $1b ; ?
	db $04 ; ?
	db $00 ; ?
	db $00 ; ?
	db $02 ; ?
	db $05 ; ?
	db $00 ; ?

	db GLITTERING_SCALES_DECK_ID
	tx Text045d ; deck name
	tx Text0475 ; opponent name
	db $1b ; ?
	db $04 ; ?
	db $00 ; ?
	db $00 ; ?
	db $02 ; ?
	db $05 ; ?
	db $02 ; ?

	db STEADY_INCREASE_DECK_ID
	tx Text043c ; deck name
	tx Text04b9 ; opponent name
	db $1c ; ?
	db $04 ; ?
	db $00 ; ?
	db $00 ; ?
	db $02 ; ?
	db $05 ; ?
	db $00 ; ?

	db DARK_SCIENCE_DECK_ID
	tx Text04b3 ; deck name
	tx Text04d7 ; opponent name
	db $1d ; ?
	db $04 ; ?
	db $00 ; ?
	db $00 ; ?
	db $02 ; ?
	db $05 ; ?
	db $00 ; ?

	db NATURAL_SCIENCE_DECK_ID
	tx Text04a6 ; deck name
	tx Text048a ; opponent name
	db $1e ; ?
	db $06 ; ?
	db $00 ; ?
	db $00 ; ?
	db $03 ; ?
	db $0e ; ?
	db $08 ; ?

	db POISONOUS_SWAMP_DECK_ID
	tx Text044a ; deck name
	tx Text04df ; opponent name
	db $20 ; ?
	db $04 ; ?
	db $00 ; ?
	db $00 ; ?
	db $02 ; ?
	db $06 ; ?
	db $00 ; ?

	db GATHERING_NIDORAN_DECK_ID
	tx Text045b ; deck name
	tx Text04a1 ; opponent name
	db $1f ; ?
	db $04 ; ?
	db $00 ; ?
	db $00 ; ?
	db $02 ; ?
	db $06 ; ?
	db $00 ; ?

	db RAIN_DANCE_CONFUSION_DECK_ID
	tx Text042f ; deck name
	tx Text04cc ; opponent name
	db $21 ; ?
	db $04 ; ?
	db $00 ; ?
	db $00 ; ?
	db $02 ; ?
	db $06 ; ?
	db $00 ; ?

	db CONSERVING_WATER_DECK_ID
	tx Text0431 ; deck name
	tx Text047d ; opponent name
	db $22 ; ?
	db $06 ; ?
	db $00 ; ?
	db $00 ; ?
	db $03 ; ?
	db $0f ; ?
	db $04 ; ?

	db ENERGY_REMOVAL_DECK_ID
	tx Text0460 ; deck name
	tx Text049a ; opponent name
	db $23 ; ?
	db $04 ; ?
	db $00 ; ?
	db $00 ; ?
	db $02 ; ?
	db $07 ; ?
	db $00 ; ?

	db SPLASHING_ABOUT_DECK_ID
	tx Text0480 ; deck name
	tx Text049a ; opponent name
	db $23 ; ?
	db $04 ; ?
	db $00 ; ?
	db $00 ; ?
	db $02 ; ?
	db $07 ; ?
	db $04 ; ?

	db BEACH_DECK_ID
	tx Text0467 ; deck name
	tx Text04d3 ; opponent name
	db $24 ; ?
	db $04 ; ?
	db $00 ; ?
	db $00 ; ?
	db $02 ; ?
	db $07 ; ?
	db $00 ; ?

	db GO_ARCANINE_DECK_ID
	tx Text045e ; deck name
	tx Text04dc ; opponent name
	db $25 ; ?
	db $04 ; ?
	db $00 ; ?
	db $00 ; ?
	db $02 ; ?
	db $07 ; ?
	db $00 ; ?

	db FLAME_FESTIVAL_DECK_ID
	tx Text046f ; deck name
	tx Text0474 ; opponent name
	db $26 ; ?
	db $06 ; ?
	db $00 ; ?
	db $00 ; ?
	db $03 ; ?
	db $10 ; ?
	db $03 ; ?

	db IMMORTAL_FLAME_DECK_ID
	tx Text0465 ; deck name
	tx Text04a2 ; opponent name
	db $27 ; ?
	db $04 ; ?
	db $00 ; ?
	db $00 ; ?
	db $02 ; ?
	db $08 ; ?
	db $00 ; ?

	db ELECTRIC_CURRENT_SHOCK_DECK_ID
	tx Text0463 ; deck name
	tx Text04cd ; opponent name
	db $29 ; ?
	db $04 ; ?
	db $00 ; ?
	db $00 ; ?
	db $02 ; ?
	db $08 ; ?
	db $00 ; ?

	db GREAT_ROCKET4_DECK_ID
	tx Text0459 ; deck name
	tx Text04f5 ; opponent name
	db $28 ; ?
	db $04 ; ?
	db $00 ; ?
	db $00 ; ?
	db $02 ; ?
	db $08 ; ?
	db $00 ; ?

	db GREAT_ROCKET1_DECK_ID
	tx Text0490 ; deck name
	tx Text042a ; opponent name
	db $3e ; ?
	db $06 ; ?
	db $00 ; ?
	db $00 ; ?
	db $1f ; ?
	db $16 ; ?
	db $01 ; ?

	db GREAT_ROCKET2_DECK_ID
	tx Text048d ; deck name
	tx Text0427 ; opponent name
	db $3b ; ?
	db $06 ; ?
	db $00 ; ?
	db $00 ; ?
	db $1f ; ?
	db $16 ; ?
	db $01 ; ?

	db GREAT_ROCKET3_DECK_ID
	tx Text048e ; deck name
	tx Text0428 ; opponent name
	db $3c ; ?
	db $06 ; ?
	db $00 ; ?
	db $00 ; ?
	db $1f ; ?
	db $16 ; ?
	db $01 ; ?

	db GRAND_FIRE_DECK_ID
	tx Text048f ; deck name
	tx Text0429 ; opponent name
	db $3d ; ?
	db $06 ; ?
	db $00 ; ?
	db $00 ; ?
	db $1f ; ?
	db $16 ; ?
	db $01 ; ?

	db LEGENDARY_FOSSIL_DECK_ID
	tx Text048b ; deck name
	tx Text04be ; opponent name
	db $2a ; ?
	db $06 ; ?
	db $00 ; ?
	db $00 ; ?
	db $04 ; ?
	db $11 ; ?
	db $03 ; ?

	db WATER_LEGEND_DECK_ID
	tx Text0458 ; deck name
	tx Text049e ; opponent name
	db $2b ; ?
	db $06 ; ?
	db $00 ; ?
	db $00 ; ?
	db $04 ; ?
	db $11 ; ?
	db $05 ; ?

	db GREAT_DRAGON_DECK_ID
	tx Text047c ; deck name
	tx Text0482 ; opponent name
	db $2c ; ?
	db $06 ; ?
	db $00 ; ?
	db $00 ; ?
	db $04 ; ?
	db $11 ; ?
	db $04 ; ?

	db BUG_COLLECTING_DECK_ID
	tx Text0450 ; deck name
	tx Text04ed ; opponent name
	db $2d ; ?
	db $06 ; ?
	db $00 ; ?
	db $00 ; ?
	db $04 ; ?
	db $11 ; ?
	db $00 ; ?

	db DEMONIC_FOREST_DECK_ID
	tx Text0447 ; deck name
	tx Text04d8 ; opponent name
	db $3f ; ?
	db $04 ; ?
	db $00 ; ?
	db $00 ; ?
	db $1f ; ?
	db $17 ; ?
	db $01 ; ?

	db STICKY_POISON_GAS_DECK_ID
	tx Text042e ; deck name
	tx Text04e3 ; opponent name
	db $40 ; ?
	db $04 ; ?
	db $00 ; ?
	db $00 ; ?
	db $1f ; ?
	db $17 ; ?
	db $01 ; ?

	db MAD_PETALS_DECK_ID
	tx Text045c ; deck name
	tx Text04da ; opponent name
	db $41 ; ?
	db $04 ; ?
	db $00 ; ?
	db $01 ; ?
	db $1f ; ?
	db $17 ; ?
	db $01 ; ?

	db DANGEROUS_BENCH_DECK_ID
	tx Text0445 ; deck name
	tx Text04dd ; opponent name
	db $42 ; ?
	db $06 ; ?
	db $01 ; ?
	db $00 ; ?
	db $20 ; ?
	db $1d ; ?
	db $08 ; ?

	db CHAIN_LIGHTNING_BY_PIKACHU_DECK_ID
	tx Text0441 ; deck name
	tx Text04a4 ; opponent name
	db $46 ; ?
	db $04 ; ?
	db $00 ; ?
	db $00 ; ?
	db $02 ; ?
	db $26 ; ?
	db $00 ; ?

	db THIS_IS_THE_POWER_OF_ELECTRICITY_DECK_ID
	tx Text04c5 ; deck name
	tx Text04f2 ; opponent name
	db $43 ; ?
	db $04 ; ?
	db $00 ; ?
	db $07 ; ?
	db $1f ; ?
	db $18 ; ?
	db $01 ; ?

	db QUICK_ATTACK_DECK_ID
	tx Text0456 ; deck name
	tx Text0479 ; opponent name
	db $44 ; ?
	db $04 ; ?
	db $00 ; ?
	db $02 ; ?
	db $1f ; ?
	db $18 ; ?
	db $01 ; ?

	db COMPLETE_COMBUSTION_DECK_ID
	tx Text0457 ; deck name
	tx Text0487 ; opponent name
	db $45 ; ?
	db $06 ; ?
	db $02 ; ?
	db $00 ; ?
	db $20 ; ?
	db $1e ; ?
	db $09 ; ?

	db FIREBALL_DECK_ID
	tx Text043f ; deck name
	tx Text049b ; opponent name
	db $47 ; ?
	db $04 ; ?
	db $00 ; ?
	db $00 ; ?
	db $1f ; ?
	db $19 ; ?
	db $01 ; ?

	db EEVEE_SHOWDOWN_DECK_ID
	tx Text04c6 ; deck name
	tx Text04e2 ; opponent name
	db $48 ; ?
	db $04 ; ?
	db $00 ; ?
	db $03 ; ?
	db $1f ; ?
	db $19 ; ?
	db $01 ; ?

	db GAZE_UPON_THE_POWER_OF_FIRE_DECK_ID
	tx Text0477 ; deck name
	tx Text0499 ; opponent name
	db $49 ; ?
	db $04 ; ?
	db $00 ; ?
	db $08 ; ?
	db $1f ; ?
	db $19 ; ?
	db $01 ; ?

	db WHIRLPOOL_SHOWER_DECK_ID
	tx Text0468 ; deck name
	tx Text04bc ; opponent name
	db $4a ; ?
	db $06 ; ?
	db $03 ; ?
	db $00 ; ?
	db $20 ; ?
	db $1f ; ?
	db $0a ; ?

	db PARALYZED_PARALYZED_DECK_ID
	tx Text0439 ; deck name
	tx Text04d9 ; opponent name
	db $4b ; ?
	db $04 ; ?
	db $00 ; ?
	db $04 ; ?
	db $1f ; ?
	db $1a ; ?
	db $01 ; ?

	db BENCH_CALL_DECK_ID
	tx Text04d1 ; deck name
	tx Text049f ; opponent name
	db $4c ; ?
	db $04 ; ?
	db $00 ; ?
	db $09 ; ?
	db $1f ; ?
	db $1a ; ?
	db $01 ; ?

	db WATER_STREAM_DECK_ID
	tx Text04c7 ; deck name
	tx Text0473 ; opponent name
	db $4d ; ?
	db $04 ; ?
	db $04 ; ?
	db $00 ; ?
	db $1f ; ?
	db $1a ; ?
	db $01 ; ?

	db ROCK_BLAST_DECK_ID
	tx Text047b ; deck name
	tx Text0483 ; opponent name
	db $4e ; ?
	db $06 ; ?
	db $05 ; ?
	db $00 ; ?
	db $20 ; ?
	db $20 ; ?
	db $0b ; ?

	db FULL_STRENGTH_DECK_ID
	tx Text04f4 ; deck name
	tx Text0494 ; opponent name
	db $4f ; ?
	db $04 ; ?
	db $00 ; ?
	db $0c ; ?
	db $1f ; ?
	db $1b ; ?
	db $01 ; ?

	db RUNNING_WILD_DECK_ID
	tx Text0451 ; deck name
	tx Text048c ; opponent name
	db $50 ; ?
	db $04 ; ?
	db $00 ; ?
	db $05 ; ?
	db $1f ; ?
	db $1b ; ?
	db $01 ; ?

	db DIRECT_HIT_DECK_ID
	tx Text0430 ; deck name
	tx Text0485 ; opponent name
	db $51 ; ?
	db $06 ; ?
	db $06 ; ?
	db $00 ; ?
	db $20 ; ?
	db $21 ; ?
	db $0c ; ?

	db SUPERDESTRUCTIVE_POWER_DECK_ID
	tx Text0454 ; deck name
	tx Text04db ; opponent name
	db $52 ; ?
	db $04 ; ?
	db $00 ; ?
	db $06 ; ?
	db $1f ; ?
	db $1c ; ?
	db $01 ; ?

	db BAD_DREAM_DECK_ID
	tx Text0452 ; deck name
	tx Text0492 ; opponent name
	db $53 ; ?
	db $04 ; ?
	db $07 ; ?
	db $00 ; ?
	db $1f ; ?
	db $1c ; ?
	db $01 ; ?

	db POKEMON_POWER_DECK_ID
	tx Text04ba ; deck name
	tx Text04e5 ; opponent name
	db $54 ; ?
	db $04 ; ?
	db $00 ; ?
	db $0a ; ?
	db $1f ; ?
	db $1c ; ?
	db $01 ; ?

	db SPIRITED_AWAY_DECK_ID
	tx Text04cb ; deck name
	tx Text04ee ; opponent name
	db $55 ; ?
	db $04 ; ?
	db $00 ; ?
	db $0d ; ?
	db $1f ; ?
	db $1c ; ?
	db $01 ; ?

	db SNORLAX_GUARD_DECK_ID
	tx Text043d ; deck name
	tx Text04d2 ; opponent name
	db $56 ; ?
	db $06 ; ?
	db $08 ; ?
	db $00 ; ?
	db $20 ; ?
	db $22 ; ?
	db $0d ; ?

	db EYE_OF_THE_STORM_DECK_ID
	tx Text0484 ; deck name
	tx Text04b6 ; opponent name
	db $57 ; ?
	db $06 ; ?
	db $00 ; ?
	db $0e ; ?
	db $20 ; ?
	db $23 ; ?
	db $0e ; ?

	db SUDDEN_GROWTH_DECK_ID
	tx Text044c ; deck name
	tx Text0478 ; opponent name
	db $58 ; ?
	db $06 ; ?
	db $00 ; ?
	db $0f ; ?
	db $20 ; ?
	db $23 ; ?
	db $0e ; ?

	db VERY_RARE_CARD_DECK_ID
	tx Text0443 ; deck name
	tx Text0497 ; opponent name
	db $59 ; ?
	db $06 ; ?
	db $00 ; ?
	db $10 ; ?
	db $20 ; ?
	db $23 ; ?
	db $0e ; ?

	db BAD_GUYS_DECK_ID
	tx Text045a ; deck name
	tx Text042d ; opponent name
	db $07 ; ?
	db $06 ; ?
	db $00 ; ?
	db $00 ; ?
	db $23 ; ?
	db $14 ; ?
	db $13 ; ?

	db POISON_MIST_DECK_ID
	tx Text0472 ; deck name
	tx Text0486 ; opponent name
	db $5a ; ?
	db $06 ; ?
	db $00 ; ?
	db $0b ; ?
	db $20 ; ?
	db $24 ; ?
	db $11 ; ?

	db ULTRA_REMOVAL_DECK_ID
	tx Text04ca ; deck name
	tx Text04f0 ; opponent name
	db $5b ; ?
	db $06 ; ?
	db $09 ; ?
	db $00 ; ?
	db $20 ; ?
	db $24 ; ?
	db $12 ; ?

	db PSYCHIC_BATTLE_DECK_ID
	tx Text047e ; deck name
	tx Text04f0 ; opponent name
	db $5b ; ?
	db $06 ; ?
	db $0a ; ?
	db $00 ; ?
	db $20 ; ?
	db $24 ; ?
	db $13 ; ?

	db STOP_LIFE_DECK_ID
	tx Text0495 ; deck name
	tx Text04f0 ; opponent name
	db $5b ; ?
	db $06 ; ?
	db $07 ; ?
	db $00 ; ?
	db $20 ; ?
	db $24 ; ?
	db $15 ; ?

	db SCORCHER_DECK_ID
	tx Text0437 ; deck name
	tx Text04c2 ; opponent name
	db $5c ; ?
	db $06 ; ?
	db $00 ; ?
	db $00 ; ?
	db $21 ; ?
	db $25 ; ?
	db $0f ; ?

	db TSUNAMI_STARTER_DECK_ID
	tx Text046d ; deck name
	tx Text04c2 ; opponent name
	db $5c ; ?
	db $06 ; ?
	db $00 ; ?
	db $00 ; ?
	db $21 ; ?
	db $25 ; ?
	db $0f ; ?

	db SMASH_TO_MINCEMEAT_DECK_ID
	tx Text044e ; deck name
	tx Text04c2 ; opponent name
	db $5c ; ?
	db $06 ; ?
	db $00 ; ?
	db $00 ; ?
	db $21 ; ?
	db $25 ; ?
	db $0f ; ?

	db TEST_YOUR_LUCK_DECK_ID
	tx Text0455 ; deck name
	tx Text04c2 ; opponent name
	db $5c ; ?
	db $06 ; ?
	db $00 ; ?
	db $00 ; ?
	db $21 ; ?
	db $25 ; ?
	db $0f ; ?

	db PROTOHISTORIC_DECK_ID
	tx Text043a ; deck name
	tx Text04c8 ; opponent name
	db $36 ; ?
	db $04 ; ?
	db $00 ; ?
	db $00 ; ?
	db $02 ; ?
	db $27 ; ?
	db $13 ; ?

	db TEXTURE_TUNER7_DECK_ID
	tx Text0446 ; deck name
	tx Text04b4 ; opponent name
	db $37 ; ?
	db $04 ; ?
	db $00 ; ?
	db $00 ; ?
	db $03 ; ?
	db $27 ; ?
	db $13 ; ?

	db COLORLESS_ENERGY_DECK_ID
	tx Text04a8 ; deck name
	tx Text04bf ; opponent name
	db $38 ; ?
	db $04 ; ?
	db $00 ; ?
	db $00 ; ?
	db $1f ; ?
	db $27 ; ?
	db $13 ; ?

	db POWERFUL_POKEMON_DECK_ID
	tx Text046b ; deck name
	tx Text04ef ; opponent name
	db $39 ; ?
	db $05 ; ?
	db $00 ; ?
	db $00 ; ?
	db $1f ; ?
	db $27 ; ?
	db $13 ; ?

	db WEIRD_DECK_ID
	tx Text0444 ; deck name
	tx Text0488 ; opponent name
	db $3a ; ?
	db $06 ; ?
	db $00 ; ?
	db $00 ; ?
	db $20 ; ?
	db $27 ; ?
	db $13 ; ?

	db STRANGE_DECK_ID
	tx Text0464 ; deck name
	tx Text047a ; opponent name
	db $08 ; ?
	db $06 ; ?
	db $00 ; ?
	db $00 ; ?
	db $10 ; ?
	db $13 ; ?
	db $0b ; ?

	db RONALDS_UNCOOL_DECK_ID
	tx Text0442 ; deck name
	tx Text047a ; opponent name
	db $09 ; ?
	db $06 ; ?
	db $00 ; ?
	db $00 ; ?
	db $24 ; ?
	db $13 ; ?
	db $13 ; ?

	db RONALDS_GRX_DECK_ID
	tx Text04e8 ; deck name
	tx Text04e6 ; opponent name
	db $04 ; ?
	db $06 ; ?
	db $00 ; ?
	db $00 ; ?
	db $0f ; ?
	db $15 ; ?
	db $16 ; ?

	db RONALDS_POWER_DECK_ID
	tx Text04e7 ; deck name
	tx Text042b ; opponent name
	db $5d ; ?
	db $06 ; ?
	db $00 ; ?
	db $00 ; ?
	db $0f ; ?
	db $16 ; ?
	db $16 ; ?

	db RONALDS_PSYCHIC_DECK_ID
	tx Text04eb ; deck name
	tx Text04e6 ; opponent name
	db $04 ; ?
	db $06 ; ?
	db $00 ; ?
	db $00 ; ?
	db $0f ; ?
	db $15 ; ?
	db $16 ; ?

	db RONALDS_ULTRA_DECK_ID
	tx Text04ea ; deck name
	tx Text04e6 ; opponent name
	db $04 ; ?
	db $06 ; ?
	db $00 ; ?
	db $00 ; ?
	db $0f ; ?
	db $15 ; ?
	db $16 ; ?

	db EVERYBODYS_FRIEND_DECK_ID
	tx Text04e9 ; deck name
	tx Text04e6 ; opponent name
	db $04 ; ?
	db $06 ; ?
	db $00 ; ?
	db $00 ; ?
	db $0f ; ?
	db $15 ; ?
	db $16 ; ?

	db IMMORTAL_POKEMON_DECK_ID
	tx Text0469 ; deck name
	tx Text047f ; opponent name
	db $2e ; ?
	db $06 ; ?
	db $00 ; ?
	db $00 ; ?
	db $20 ; ?
	db $28 ; ?
	db $17 ; ?

	db TORRENTIAL_FLOOD_DECK_ID
	tx Text0462 ; deck name
	tx Text04cf ; opponent name
	db $2f ; ?
	db $06 ; ?
	db $00 ; ?
	db $00 ; ?
	db $20 ; ?
	db $28 ; ?
	db $17 ; ?

	db TRAINER_IMPRISON_DECK_ID
	tx Text043b ; deck name
	tx Text04e1 ; opponent name
	db $30 ; ?
	db $06 ; ?
	db $00 ; ?
	db $00 ; ?
	db $20 ; ?
	db $28 ; ?
	db $17 ; ?

	db BLAZING_FLAME_DECK_ID
	tx Text04ae ; deck name
	tx Text04ab ; opponent name
	db $31 ; ?
	db $06 ; ?
	db $00 ; ?
	db $00 ; ?
	db $20 ; ?
	db $28 ; ?
	db $17 ; ?

	db DAMAGE_CHAOS_DECK_ID
	tx Text046c ; deck name
	tx Text04c3 ; opponent name
	db $32 ; ?
	db $06 ; ?
	db $00 ; ?
	db $00 ; ?
	db $20 ; ?
	db $28 ; ?
	db $17 ; ?

	db BIG_THUNDER_DECK_ID
	tx Text04a7 ; deck name
	tx Text0476 ; opponent name
	db $33 ; ?
	db $06 ; ?
	db $00 ; ?
	db $00 ; ?
	db $20 ; ?
	db $28 ; ?
	db $17 ; ?

	db POWER_OF_DARKNESS_DECK_ID
	tx Text04c0 ; deck name
	tx Text04a9 ; opponent name
	db $34 ; ?
	db $06 ; ?
	db $00 ; ?
	db $00 ; ?
	db $20 ; ?
	db $28 ; ?
	db $17 ; ?

	db POISON_STORM_DECK_ID
	tx Text0436 ; deck name
	tx Text04d0 ; opponent name
	db $35 ; ?
	db $06 ; ?
	db $00 ; ?
	db $00 ; ?
	db $20 ; ?
	db $28 ; ?
	db $17 ; ?

	db DECK_7269_ID
	tx Text04c9 ; deck name
	tx Text04ac ; opponent name
	db $5e ; ?
	db $06 ; ?
	db $00 ; ?
	db $00 ; ?
	db $20 ; ?
	db $28 ; ?
	db $17 ; ?

	db $ff ; end
