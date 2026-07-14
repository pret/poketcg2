; -50 if no viable targets
HandleSpreadAIAttacks:
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call GetCardIDFromDeckIndex
	cp16 DARK_IVYSAUR
	ld b, SECOND_ATTACK
	jp z, .check_viable_target
	cp16 DARK_ARBOK
	ld b, SECOND_ATTACK
	jp z, .check_viable_target
	cp16 DARK_GOLBAT
	ld b, SECOND_ATTACK
	jp z, .check_viable_target
	cp16 DARK_STARMIE
	ld b, SECOND_ATTACK
	jp z, .check_viable_target
	cp16 ARTICUNO_LV35
	ld b, SECOND_ATTACK
	jp z, .check_viable_target
	cp16 ARTICUNO_LV37
	ld b, SECOND_ATTACK
	jp z, .check_viable_target
	cp16 PIKACHU_LV14
	ld b, FIRST_ATTACK_OR_PKMN_POWER
	jp z, .check_viable_target
	cp16 RAICHU_LV45
	ld b, FIRST_ATTACK_OR_PKMN_POWER
	jp z, .check_viable_target
	cp16 DARK_RAICHU
	ld b, FIRST_ATTACK_OR_PKMN_POWER
	jp z, .check_viable_target
	cp16 MAGNEMITE_LV15
	ld b, SECOND_ATTACK
	jp z, .check_viable_target
	cp16 ZAPDOS_LV40
	ld b, FIRST_ATTACK_OR_PKMN_POWER
	jp z, .check_viable_target
	cp16 DIGLETT_LV15
	ld b, FIRST_ATTACK_OR_PKMN_POWER
	jp z, .check_viable_target
	cp16 DUGTRIO_LV40
	ld b, SECOND_ATTACK
	jp z, .check_viable_target
	cp16 MACHOKE_LV24
	ld b, SECOND_ATTACK
	jp z, .FocusBlast
	cp16 GRAVELER_LV27
	ld b, FIRST_ATTACK_OR_PKMN_POWER
	jp z, .check_viable_target
	cp16 CUBONE_LV14
	ld b, FIRST_ATTACK_OR_PKMN_POWER
	jp z, .check_viable_target
	cp16 DARK_MAROWAK
	ld b, FIRST_ATTACK_OR_PKMN_POWER
	jp z, .check_viable_target
	cp16 HITMONLEE_LV30
	ld b, FIRST_ATTACK_OR_PKMN_POWER
	jr z, .check_viable_target
	cp16 HITMONCHAN_LV23
	ld b, FIRST_ATTACK_OR_PKMN_POWER
	jr z, .check_viable_target
	cp16 ABRA_LV8
	ld b, FIRST_ATTACK_OR_PKMN_POWER
	jr z, .check_viable_target
	cp16 GENGAR_LV38
	ld b, SECOND_ATTACK
	jr z, .check_viable_target
	cp16 DARK_GENGAR
	ld b, SECOND_ATTACK
	jr z, .check_viable_target
	cp16 HYPNO_LV36
	ld b, SECOND_ATTACK
	jr z, .check_viable_target
	cp16 MEWTWO_LV30
	ld b, SECOND_ATTACK
	jr z, .Telekinesis
	cp16 PIDGEOT_LV38
	ld b, FIRST_ATTACK_OR_PKMN_POWER
	jr z, .check_viable_target
	cp16 MEOWTH_LV10
	ld b, FIRST_ATTACK_OR_PKMN_POWER
	jr z, .check_viable_target
	cp16 MEOWTH_LV13
	ld b, FIRST_ATTACK_OR_PKMN_POWER
	jr z, .check_viable_target
	cp16 SEADRA_LV26
	jr z, .WaterBomb

.standard_score
	ld a, AI_SCORE_NEUTRAL
	ret

.check_viable_target
	ld a, [wSelectedAttack]
	cp b
	jr nz, .standard_score
	call IsPlayerArenaCardImmuneAndNoBenchedPokemon
	jr nc, .standard_score

.discourage
	ld a, AI_SCORE_NEUTRAL - 50
	ret

; +10 if any KO or weakness target
.FocusBlast
	ld a, [wSelectedAttack]
	cp b
	jr nz, .standard_score
	call IsPlayerArenaCardImmuneAndNoBenchedPokemon
	jr c, .discourage
	call AILookForFocusBlastTargetToKO
	jr c, .encourage
	farcall AILookForBenchTargetWeakToArenaColor
	jr c, .encourage
	call AIChooseFocusBlastTarget
	jr nc, .discourage
	ld a, AI_SCORE_NEUTRAL
	ret

.encourage
	ld a, AI_SCORE_NEUTRAL + 10
	ret

; handle spread damage by extra Water energy
.WaterBomb
	call IsPlayerArenaCardImmuneAndNoBenchedPokemon
	jr c, .discourage
	farcall IsPlayerArenaCardImmune
	jr nc, .standard_score_2
	ld e, PLAY_AREA_ARENA
	call GetPlayAreaCardAttachedEnergies
	ld a, [wAttachedEnergies + WATER]
	cp 3
	jr c, .discourage

.standard_score_2
	ld a, AI_SCORE_NEUTRAL
	ret

; handle Invisible Wall
.Telekinesis
	ld a, [wSelectedAttack]
	cp b
	jr nz, .standard_score
	call IsPlayerArenaCardImmuneAndNoBenchedPokemon
	jr c, .discourage
	call SwapTurn
	ld de, MR_MIME_LV28
	ld b, PLAY_AREA_ARENA
	farcall CountCardIDInTurnDuelistPlayArea
	ld b, a
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	call SwapTurn
	cp b
	jr nz, .standard_score
	jr .discourage
