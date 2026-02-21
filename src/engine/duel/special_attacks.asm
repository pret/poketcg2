HandleSpecialAIAttacks:
	ldh a, [hTempPlayAreaLocation_ff9d]
	add DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call GetCardIDFromDeckIndex
	cp16 NIDORANF_LV13
	jp z, .NidoranFCallForFamily
	cp16 ODDISH_LV8
	jp z, .CallForFamily
	cp16 BELLSPROUT_LV11
	jp z, .CallForFamily
	cp16 EXEGGUTOR
	jp z, .Teleport
	cp16 SCYTHER_LV25
	jp z, .SwordsDanceAndFocusEnergy
	cp16 KRABBY_LV20
	jp z, .CallForFamily
	cp16 VAPOREON_LV29
	jp z, .SwordsDanceAndFocusEnergy
	cp16 ELECTRODE_LV42
	jp z, .ChainLightning
	cp16 MAROWAK_LV26
	jp z, .CallForFriend
	cp16 MEW_LV23
	jp z, .DevolutionBeam
	cp16 JIGGLYPUFF_LV13
	jp z, .FriendshipSong
	cp16 PORYGON_LV12
	jp z, .PorygonLv12
	cp16 MEWTWO_ALT_LV60
	jp z, .EnergyAbsorption
	cp16 MEWTWO_LV60
	jp z, .EnergyAbsorption
	cp16 NINETALES_LV35
	jp z, .MixUp
	cp16 ZAPDOS_LV68
	jp z, .BigThunder
	cp16 KANGASKHAN_LV40
	jp z, .FetchAndDizziness
	cp16 DUGTRIO_LV36
	jp z, .Earthquake
	cp16 ELECTRODE_LV35
	jp z, .EnergySpike
	cp16 GOLDUCK_LV27
	jp z, .HyperBeam
	cp16 DRAGONAIR
	jp z, .HyperBeam
	cp16 DEWGONG_LV24
	jp z, .Rest
	cp16 PSYDUCK_LV16
	jp z, .FetchAndDizziness
	cp16 DARK_GOLDUCK
	jp z, .ThirdEye
	cp16 KINGLER_LV33
	jp z, .SaltWater
	cp16 MOLTRES_LV37
	jp z, .DryUp
	cp16 VULPIX_LV13
	jp z, .FireFox
	cp16 DARK_ELECTRODE
	jp z, .EnergyBomb
	cp16 ZAPDOS_LV28
	jp z, .ZapdosLv28
	cp16 PIKACHU_LV13
	jp z, .Recharge
	cp16 RAICHU_LV32
	jp z, .ShortCircuit
	cp16 ALAKAZAM_LV45
	jp z, .TransDamage
	cp16 HAUNTER_LV26
	jp z, .Poltergeist
	cp16 GASTLY_LV8
	jp z, .DestinyBond
	cp16 WEEPINBELL_LV23
	jp z, .Regeneration
	cp16 GRAVELER_LV28
	jp z, .Earthquake
	cp16 MACHOP_LV18
	jp z, .FocusedOneShot
	cp16 PARAS_LV15
	jp z, .CallForFamily
	cp16 NIDORANM_LV22
	jp z, .SwordsDanceAndFocusEnergy
	cp16 SQUIRTLE_LV15
	jp z, .WaterPower
	cp16 RHYDON_LV37
	jp z, .MountainBreaker
	cp16 STARYU_LV17
	jp z, .StrangeBeam
	cp16 GROWLITHE_LV16
	jp z, .ErrandRunning
	cp16 RAPIDASH_LV30
	jp z, .KickAway
	cp16 MEOWTH_LV14
	jp z, .ClearProfit
	cp16 MAGNETON_LV30
	jp z, .Microwave
	cp16 MAGIKARP_LV6
	jp z, .RapidEvolution
	cp16 VENOMOTH_LV22
	jp z, .StirUpTwister
	cp16 DARK_WEEZING
	jp z, .MassExplosion
	cp16 DARK_ARBOK
	jp z, .Stare
	cp16 HUNGRY_SNORLAX
	jp z, .HungrySnorlax
	cp16 DARK_MAGNETON
	jp z, .MagneticLines
	cp16 DARK_RAPIDASH
	jp z, .FlamePillar
	cp16 MAGMAR_LV27
	jp z, .BurningFire
	cp16 DARK_CHARIZARD
	jp z, .ContinuousFireball
	cp16 DARK_VAPOREON
	jp z, .HyperBeam
	cp16 GOLEM_LV37
	jp z, .RockBlast
	cp16 DARK_MACHOKE
	jp z, .DragOff
	cp16 DARK_MACHAMP
	jp z, .Fling
	cp16 DARK_ALAKAZAM
	jp z, .TeleportBlast
	cp16 MEWTWO_LV30
	jp z, .EnergyControl
	cp16 ABRA_LV14
	jp z, .Vanish
	cp16 SLOWPOKE_LV16
	jp z, .AfternoonNap
	cp16 MANKEY_LV14
	jp z, .MankeyLv14
	cp16 PIDGEOTTO_LV38
	jp z, .Twister
	cp16 PORYGON_LV18
	jp z, .PorygonLv18Confusion2
	cp16 COOL_PORYGON
	jp z, .TextureMagic
	cp16 MEWTWO_LV67
	jp z, .CompleteRecovery
	cp16 DARK_NINETALES
	jp z, .Perplex
	cp16 POLIWRATH_LV48
	jp z, .HyperBeam
	cp16 SLOWBRO_LV35
	jp z, .BigYawn

.ZeroScore:
	xor a
	ret

; 128 + (slots available in bench) if any cards of the same Pokémon in deck pile
; dismiss otherwise
.CallForFamily:
	call LoadCardDataToBuffer1_FromCardID
	ld a, [wLoadedCard1PokedexNumber]
	ld e, a
	ld d, $00
	ld a, CARDSEARCH_POKEDEX_NUMBER
	farcall SetCardSearchFuncParams
	call CreateDeckCardList
	jr c, .ZeroScore
	ld hl, wDuelTempList
.loop_call_for_family_search
	ld a, [hli]
	cp $ff
	jr z, .ZeroScore
	farcall ExecuteCardSearchFunc
	jr nc, .loop_call_for_family_search
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	inc a
	ld hl, wMaxNumPlayAreaPokemon
	cp [hl]
	jr nc, .ZeroScore
	dec a
	ld b, a
	ld a, MAX_BENCH_POKEMON
	sub b
	add 128
	ret

; 128 + (slots available in bench) if any Nidoran M/F cards in deck pile
; dismiss otherwise
.NidoranFCallForFamily:
	ld de, NIDORANM_LV20
	ld a, CARD_LOCATION_DECK
	call FindCardIDInLocation
	jr c, .found_nidoran
	ld de, NIDORANM_LV22
	ld a, CARD_LOCATION_DECK
	call FindCardIDInLocation
	jr c, .found_nidoran
	ld de, NIDORANF_LV12
	ld a, CARD_LOCATION_DECK
	call FindCardIDInLocation
	jr c, .found_nidoran
	ld de, NIDORANF_LV13
	ld a, CARD_LOCATION_DECK
	call FindCardIDInLocation
	jr nc, .ZeroScore
.found_nidoran
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	ld hl, wMaxNumPlayAreaPokemon
	cp [hl]
	jr nc, .ZeroScore
	ld b, a
	ld a, MAX_PLAY_AREA_POKEMON
	sub b
	add 128
	ret

; 128 + (slots available in bench) if any of the 4 Fighting basic Pokémon in deck pile
; (not updated since TCG1; not accounting for TCG2 deck configurations)
; dismiss otherwise
.CallForFriend:
	ld de, GEODUDE_LV16
	ld a, CARD_LOCATION_DECK
	call FindCardIDInLocation
	jr c, .found_fighting_card
	ld de, ONIX_LV12
	ld a, CARD_LOCATION_DECK
	call FindCardIDInLocation
	jr c, .found_fighting_card
	ld de, CUBONE_LV13
	ld a, CARD_LOCATION_DECK
	call FindCardIDInLocation
	jr c, .found_fighting_card
	ld de, RHYHORN
	ld a, CARD_LOCATION_DECK
	call FindCardIDInLocation
	jr c, .found_fighting_card
	jp .ZeroScore
.found_fighting_card
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	inc a
	ld hl, wMaxNumPlayAreaPokemon
	cp [hl]
	jp nc, .ZeroScore
	dec a
	ld b, a
	ld a, MAX_BENCH_POKEMON
	sub b
	add 128
	ret

; 128 + (slots available in bench) if any basic Pokémon in deck pile
; dismiss otherwise
.FriendshipSong:
	call CheckIfAnyBasicPokemonInDeck
	jp nc, .ZeroScore
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	ld hl, wMaxNumPlayAreaPokemon
	cp [hl]
	jp nc, .ZeroScore
	ld b, a
	ld a, MAX_PLAY_AREA_POKEMON
	sub b
	add 128
	ret

; 128 + 10 if in a retreating situation
; dismiss otherwise
.Teleport:
	farcall AIDecideWhetherToRetreat_ConsiderStatus
	jp nc, .ZeroScore
	ld a, 138
	ret

; dismiss if the other attack is ready for damage output,
; 128 + 5 otherwise
.SwordsDanceAndFocusEnergy:
	ld a, [wAICannotDamage]
	or a
	jr nz, .swords_dance_focus_energy_success
	ld a, SECOND_ATTACK
	ld [wSelectedAttack], a
	farcall CheckIfSelectedAttackIsUnusable
	jr c, .swords_dance_focus_energy_success
	ld a, SECOND_ATTACK
	farcall EstimateDamage_VersusDefendingCard
	ld a, [wDamage]
	or a
	jp nz, .ZeroScore
.swords_dance_focus_energy_success
	ld a, 133
	ret

; dismiss if Invisible Wall is active or the other attack is ready for damage output,
; 128 + 5 otherwise
.WaterPower:
	farcall CheckIfDefendingPkmnIsMrMimeLv28AndHasActivePkmnPower
	jp c, .ZeroScore
	ld a, [wAICannotDamage]
	or a
	jr nz, .water_power_success
	ld a, SECOND_ATTACK
	ld [wSelectedAttack], a
	farcall CheckIfSelectedAttackIsUnusable
	jr c, .water_power_success
	ld a, SECOND_ATTACK
	farcall EstimateDamage_VersusDefendingCard
	ld a, [wDamage]
	or a
	jp nz, .ZeroScore
.water_power_success
	ld a, 133
	ret

; dismiss if own Benched Pokémon would take damage,
; 128 + 2 otherwise
.ChainLightning:
	call SwapTurn
	bank1call GetArenaCardColor
	call SwapTurn
	ld b, a
	ld a, DUELVARS_BENCH
	get_turn_duelist_var
.loop_chain_lightning_bench
	ld a, [hli]
	cp $ff
	jr z, .chain_lightning_success
	push bc
	call GetCardIDFromDeckIndex
	call GetCardType
	pop bc
	cp b
	jr nz, .loop_chain_lightning_bench
	jp .ZeroScore
.chain_lightning_success
	ld a, 130
	ret

; 128 + 5 if KOing any in player's area,
; dismiss otherwise;
; Ronald: also 128 + 5 if
;   Mew has 20+ HP remaining,
;   Gengar Lv.40 is on his Bench, and
;   no Pokémon Power locks
.DevolutionBeam:
	ld a, [wOpponentDeckID]
	cp RONALDS_PSYCHIC_DECK_ID
	jr z, .devolution_beam_ronald
	call LookForCardThatIsKnockedOutOnDevolution
	jp nc, .ZeroScore

.devolution_beam_success
	ld a, 133
	ret

.devolution_beam_ronald
	call LookForCardThatIsKnockedOutOnDevolution
	jr c, .devolution_beam_success
; check Pokémon Power locks, and
; search for Gengar Lv.40 in own Play Area to devolve
; for reusing Power of Darkness on next turn
	bank1call CheckGoopGasAttackAndToxicGasActive
	jp c, .ZeroScore
	ld de, GENGAR_LV40
	ld b, PLAY_AREA_BENCH_1
	call FindCardIDInTurnDuelistsPlayArea.loop_play_area
	jp nc, .ZeroScore
	add DUELVARS_ARENA_CARD_HP
	get_turn_duelist_var
	cp 10 + 1
	jp c, .ZeroScore
	jr .devolution_beam_success

; dismiss if confused;
; set score based on k = number of own viable Benched Pokémon
;   k < 2:  128 + 1 for Conversion 1, 128 + 2 for Conversion 2
;   k >= 2: 128 + 2 for Conversion 1, 128 + 1 for Conversion 2
; Michael:
;   k = 0:  128 - 28 for Conversion 1
.PorygonLv12:
	ld a, DUELVARS_ARENA_CARD_STATUS
	get_turn_duelist_var
	and CNF_SLP_PRZ
	cp CONFUSED
	jp z, .ZeroScore

	ld a, [wSelectedAttack]
	or a
	jr nz, .porygon_lv12_conversion2

; Conversion 1
	call CountNumberOfSetUpBenchPokemon
	or a
	jr z, .porygon_lv12_no_set_up_bench
	cp 2
	jr c, .porygon_lv12_lower_score
	ld a, 130
	ret

.porygon_lv12_conversion2:
	call CountNumberOfSetUpBenchPokemon
	cp 2
	jr nc, .porygon_lv12_lower_score
	ld a, 130
	ret

.porygon_lv12_lower_score
	ld a, 129
	ret

.porygon_lv12_no_set_up_bench
	ld a, [wOpponentDeckID]
	cp YOU_CAN_DO_IT_MACHOP_DECK_ID
	jr nz, .porygon_lv12_lower_score
; Michael
	ld a, 100
	ret

; 128 + 2 if any Psychic Energy in own discard pile
; dismiss otherwise
.EnergyAbsorption:
	ld de, PSYCHIC_ENERGY
	ld a, CARD_LOCATION_DISCARD_PILE
	call FindCardIDInLocation
	jp nc, .ZeroScore
	ld a, 130
	ret

; dismiss if player has no cards in hand;
; John:
;   128 + 5 with 1/4 chance when player has 4+ cards in hand,
;   128 + 1 otherwise;
; other AIs:
;   128 + 3 with 1/3 chance,
;   dismiss with 1/3 chance, and
;   scan player's hand with 1/3 chance, where
;     128 + 3 if
;       player has 2- Pokémon in play and 2+ basic Pokémon in hand, or
;       player has any Evolution cards in hand compatible with their Pokémon in play,
;     dismiss otherwise
.MixUp:
	ld a, [wOpponentDeckID]
	cp FLAME_FESTIVAL_DECK_ID
	jr z, .mix_up_john

	ld a, DUELVARS_NUMBER_OF_CARDS_IN_HAND
	call GetNonTurnDuelistVariable
	or a
	ret z

	ld a, 3
	call Random
	or a
	jr z, .encourage_mix_up
	dec a
	ret z
	call SwapTurn
	call CreateHandCardList
	call SwapTurn
	or a
	ret z
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	call GetNonTurnDuelistVariable
	cp 3
	jr nc, .mix_up_check_play_area

	ld hl, wDuelTempList
	ld b, 0
.loop_mix_up_hand
	ld a, [hli]
	cp $ff
	jr z, .tally_basic_cards
	call SwapTurn
	call LoadCardDataToBuffer2_FromDeckIndex
	call SwapTurn
	ld a, [wLoadedCard2Type]
	cp TYPE_ENERGY
	jr nc, .loop_mix_up_hand
	ld a, [wLoadedCard2Stage]
	or a
	jr nz, .loop_mix_up_hand
; basic Pokémon card
	inc b
	jr .loop_mix_up_hand

.tally_basic_cards
	ld a, b
	cp 2
	jr nc, .encourage_mix_up

.mix_up_check_play_area
	ld a, DUELVARS_ARENA_CARD
	call GetNonTurnDuelistVariable
.loop_mix_up_play_area
	ld a, [hli]
	cp $ff
	jp z, .ZeroScore
	push hl
	call SwapTurn
	call CheckIfPokemonEvolutionIsFoundInHand
	call SwapTurn
	pop hl
	jr nc, .loop_mix_up_play_area

.encourage_mix_up
	ld a, 131
	ret

.mix_up_john
	ld a, DUELVARS_NUMBER_OF_CARDS_IN_HAND
	call GetNonTurnDuelistVariable
	cp 4
	jr c, .low_mix_up_score_john
	ld a, 4
	call Random
	or a
	jr nz, .low_mix_up_score_john
	ld a, 133
	ret

.low_mix_up_score_john
	ld a, 129
	ret

; always 128 + 3
.BigThunder:
	ld a, 131
	ret

; dismiss if 9- cards remaining in deck pile
.FetchAndDizziness:
	ld a, DUELVARS_NUMBER_OF_CARDS_NOT_IN_DECK
	get_turn_duelist_var
	cp DECK_SIZE - 9
	jp nc, .ZeroScore
	ld a, 128
	ret

; dismiss if KOing enough number of own Benched Pokémon for player to win
.Earthquake:
	ld a, DUELVARS_BENCH
	get_turn_duelist_var

	lb de, 0, PLAY_AREA_BENCH_1 - 1
.loop_earthquake
	inc e
	ld a, [hli]
	cp $ff
	jr z, .count_prizes
	ld a, e
	add DUELVARS_ARENA_CARD_HP
	get_turn_duelist_var
	cp 20
	jr nc, .loop_earthquake
	inc d
	jr .loop_earthquake

.count_prizes
	push de
	call CountPrizes
	pop de
	cp d
	jp c, .ZeroScore
	jp z, .ZeroScore
	ld a, 128
	ret

; 128 + 3 if any Lightning Energy in deck pile, and in an Energy-attachment situation;
; dismiss otherwise
.EnergySpike:
	ld a, CARD_LOCATION_DECK
	ld de, LIGHTNING_ENERGY
	call FindCardIDInLocation
	jp nc, .ZeroScore
	farcall AIProcessButDontPlayEnergy_SkipEvolution
	jp nc, .ZeroScore
	ld a, 131
	ret

; 128 + 3 if any removable Energy attached to the defender;
; 128 otherwise
.HyperBeam:
	call SwapTurn
	ld e, PLAY_AREA_ARENA
	farcall CountNumberOfNonRecycleEnergyCardsAttached
	call CreateArenaOrBenchEnergyCardList
	call SwapTurn
	or a
	jr z, .hyper_beam_neutral
	ld a, 131
	ret
.hyper_beam_neutral
	ld a, 128
	ret

; Amy:
;   128 + 5 if Dewgong has 20- HP remaining,
;   dismiss otherwise;
; other AIs:
;   dismiss if the defender has has Dream Eater,
;   128 + 5 if Dewgong is in KO range but not in OHKO range (60 damage),
;   128 otherwise
.Rest:
	ld a, [wOpponentDeckID]
	cp RAIN_DANCE_CONFUSION_DECK_ID
	jr z, .rest_amy

	ld a, DUELVARS_ARENA_CARD
	call GetNonTurnDuelistVariable
	call SwapTurn
	call GetCardIDFromDeckIndex
	call SwapTurn
	cp16 HAUNTER_LV22
	jp z, .ZeroScore
	farcall CheckIfDefendingPokemonCanKnockOut
	jr nc, .rest_neutral
	cp 60
	jr nc, .rest_neutral
	ld a, 133
	ret

.rest_neutral
	ld a, 128
	ret

.rest_amy
	ld a, DUELVARS_ARENA_CARD_HP
	get_turn_duelist_var
	cp 30
	jp nc, .ZeroScore
	ld a, 133
	ret

; Toshiron:
;   128 + 6 if 12+ cards remaining in deck pile and 3- non-draw cards in hand,
;   dismiss otherwise;
; other AIs:
;   128 + 6 if 15+ cards remaining in deck pile and Dark Golduck in KO range,
;   dismiss otherwise
.ThirdEye:
	ld a, [wOpponentDeckID]
	cp TRAINER_IMPRISON_DECK_ID
	jr z, .third_eye_toshiron

	ld a, DUELVARS_NUMBER_OF_CARDS_NOT_IN_DECK
	get_turn_duelist_var
	cp DECK_SIZE - 14
	jp nc, .ZeroScore
	farcall CheckIfDefendingPokemonCanKnockOut
	jp nc, .ZeroScore
	ld a, 134
	ret

.third_eye_toshiron
	ld a, DUELVARS_NUMBER_OF_CARDS_NOT_IN_DECK
	get_turn_duelist_var
	cp DECK_SIZE - 11
	jp nc, .ZeroScore
	farcall CountNonDrawEngineCardsInHand
	cp 4
	jp nc, .ZeroScore
	ld a, 134
	ret

; 128 + 1 if
;   5+ cards including any Water Energy remaining in deck pile, and
;   Kingler needs more Water Energy and is out of KO range;
; dismiss otherwise
.SaltWater:
	ld a, DUELVARS_NUMBER_OF_CARDS_NOT_IN_DECK
	get_turn_duelist_var
	cp DECK_SIZE - 4
	jp nc, .ZeroScore
	ld e, PLAY_AREA_ARENA
	call GetPlayAreaCardAttachedEnergies
	ld a, [wAttachedEnergies + WATER]
	cp 4
	jp nc, .ZeroScore
	farcall CheckIfDefendingPokemonCanKnockOut
	jp c, .ZeroScore
	ld a, CARD_LOCATION_DECK
	ld de, WATER_ENERGY
	call FindCardIDInLocation
	jp nc, .ZeroScore
	ld a, 129
	ret

; 128 + 1 if any viable targets,
; dismiss otherwise
.DryUp:
	farcall IsPlayerArenaCardImmuneAndNoBenchedPokemon
	jp c, .ZeroScore
	farcall CheckIfPlayerHasAuroraVeilActive
	ld d, 1 ; number of possible targets
	jr c, .dry_up_check_immunity_arena
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	call GetNonTurnDuelistVariable
	ld d, a
.dry_up_check_immunity_arena
	push de
	farcall IsPlayerArenaCardImmune
	pop de
	jr nc, .dry_up_start_with_arena
; the defender is immune
	call SwapTurn
	ld e, PLAY_AREA_BENCH_1
	jr .loop_dry_up_play_area
.dry_up_start_with_arena
	call SwapTurn
	ld e, PLAY_AREA_ARENA
.loop_dry_up_play_area
	push de
	call GetPlayAreaCardAttachedEnergies
	pop de
	ld a, [wAttachedEnergies + WATER]
	or a
	jr nz, .dry_up_success
	inc e
	ld a, e
	cp d
	jr nz, .loop_dry_up_play_area

; no viable targets
	call SwapTurn
	jp .ZeroScore

.dry_up_success
	call SwapTurn
	ld a, 129
	ret

; John: always 128 + 3;
; other AIs:
;   128 + 3 if in a gusting situation;
;   128 - 50 if the defender is immune, without Benched Pokémon;
;   128 otherwise
.FireFox:
	ld a, [wOpponentDeckID]
	cp FLAME_FESTIVAL_DECK_ID
	jr z, .encourage_firefox
	farcall Func_209fc
	jr c, .encourage_firefox
	farcall IsPlayerArenaCardImmune
	jr nc, .firefox_neutral
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	call GetNonTurnDuelistVariable
	cp 1
	jr z, .discourage_firefox

.firefox_neutral
	ld a, 128
	ret

.encourage_firefox
	ld a, 131
	ret

.discourage_firefox
	ld a, 78
	ret

; 128 + 4 if Dark Electrode is in KO range;
; dismiss otherwise
.EnergyBomb:
	farcall CheckIfDefendingPokemonCanKnockOut
	jp nc, .ZeroScore
	ld a, 134
	ret

; dismiss if player has only 1 prize remaining;
; 128 - 2 otherwise
.ZapdosLv28:
	call SwapTurn
	call CountPrizes
	call SwapTurn
	cp 2
	jp c, .ZeroScore
	ld a, 126
	ret

; 128 + 2 if
;   Pikachu is out of KO range, and
;   there's any Lightning Energy in deck pile;
; dismiss otherwise
.Recharge:
	xor a
	ldh [hTempPlayAreaLocation_ff9d], a
	farcall CheckIfDefendingPokemonCanKnockOut
	jp c, .ZeroScore
	ld de, LIGHTNING_ENERGY
	ld a, CARD_LOCATION_DECK
	call FindCardIDInLocation
	jp nc, .ZeroScore
	ld a, 130
	ret

; dismiss if no viable targets;
; 128 + (number of viable targets);
; 128 + 5 if KOing any
.ShortCircuit:
	call AILookForShortCircuitTargetToKO
	jr c, .short_circuit_to_ko
	call AIChooseShortCircuitTarget
	ld a, b
	or a
	jp z, .ZeroScore
	add 128
	ret
.short_circuit_to_ko
	ld a, 133
	ret

; dismiss if KOing with Psycho Panic;
; else,
;   128 + (damage counters on Alakazam) if Alakazam is in KO range;
;   else,
;     128 + 10 if
;       player has no Benched Pokémon or 2+ prizes remaining, and
;       KOing with Trans Damage;
;     dismiss otherwise
.TransDamage:
; check Psycho Panic
	xor a ; FIRST_ATTACK_OR_PKMN_POWER, PLAY_AREA_ARENA
	ldh [hTempPlayAreaLocation_ff9d], a
	farcall EstimateDamage_VersusDefendingCard
	ld a, DUELVARS_ARENA_CARD_HP
	call GetNonTurnDuelistVariable
	ld hl, wDamage
	sub [hl]
	jp c, .ZeroScore
	jp z, .ZeroScore

	farcall CheckIfDefendingPokemonCanKnockOut
	jr nc, .trans_damage_count_player_pokemon_and_prizes

; Alakazam is in KO range
	ld a, DUELVARS_ARENA_CARD_HP
	get_turn_duelist_var
	ld b, a
	ld a, 90
	sub b
	farcall ConvertHPToCounters
	add 128
	ret

.trans_damage_count_player_pokemon_and_prizes
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	call GetNonTurnDuelistVariable
	cp 1
	jr z, .trans_damage_check_ko
	call CountPrizes
	cp 1
	jp nz, .ZeroScore

.trans_damage_check_ko
	ld a, DUELVARS_ARENA_CARD_HP
	get_turn_duelist_var
	ld b, a
	ld a, 90
	sub b
	push af
	ld a, DUELVARS_ARENA_CARD_HP
	call GetNonTurnDuelistVariable
	ld b, a
	pop af
	cp b
	jp c, .ZeroScore
	ld a, 138
	ret

; dismiss if player has no cards in hand;
; 128 + 5 if player has 6+ cards in hand;
; 128 + 1 otherwise
.Poltergeist:
	ld a, DUELVARS_NUMBER_OF_CARDS_IN_HAND
	call GetNonTurnDuelistVariable
	or a
	ret z
	cp 6
	jr nc, .higher_poltergeist_score
	ld a, 129
	ret
.higher_poltergeist_score
	ld a, 133
	ret

; 128 + 5 if Gastly is in KO range;
; dismiss otherwise
.DestinyBond:
	xor a
	ldh [hTempPlayAreaLocation_ff9d], a
	farcall CheckIfDefendingPokemonCanKnockOut
	jp nc, .ZeroScore
	ld a, 133
	ret

; 128 + 5 if
;   Weepinbell is in KO range,
;   Bellsprout goes out of KO range after that, and
;   not KOing with Dissolve;
; dismiss otherwise
.Regeneration:
	xor a ; PLAY_AREA_ARENA
	ldh [hTempPlayAreaLocation_ff9d], a
	farcall CheckIfDefendingPokemonCanKnockOut
	jp nc, .ZeroScore
	cp 40
	jp nc, .ZeroScore
	farcall CheckIfArenaCardCanKnockOutDefendingCard
	jp c, .ZeroScore
	ld a, 133
	ret

; 128 + 5 if
;   not ready for damage output, or
;   the defender has 70+ HP remaining;
; dismiss otherwise
.FocusedOneShot:
	ld a, [wAICannotDamage]
	or a
	jr nz, .machop_cannot_damage
	ld a, SECOND_ATTACK
	ld [wSelectedAttack], a
	farcall CheckIfSelectedAttackIsUnusable
	jr c, .machop_cannot_damage
	ld a, SECOND_ATTACK
	farcall EstimateDamage_VersusDefendingCard
	ld a, [wDamage]
	or a
	jp nz, .ZeroScore

.machop_cannot_damage
	ld a, DUELVARS_ARENA_CARD_HP
	call GetNonTurnDuelistVariable
	cp 70
	jp c, .ZeroScore
	ld a, 133
	ret

; dismiss if 9- cards remaining in deck pile;
; 128 if 40+ cards remaining in deck pile;
; else
;   128 + 10 if no basic Energy in hand;
;   128 - 1 if any basic Energy in hand
.MountainBreaker:
	ld a, DUELVARS_NUMBER_OF_CARDS_NOT_IN_DECK
	get_turn_duelist_var
	cp DECK_SIZE - 9
	jp nc, .ZeroScore
	cp DECK_SIZE - 39
	jr c, .mountain_breaker_neutral
	farcall CountBasicEnergyCardsInHand
	jr nc, .discourage_mountain_breaker
	ld a, 138
	ret
.mountain_breaker_neutral
	ld a, 128
	ret
.discourage_mountain_breaker
	ld a, 127
	ret

; 128 + 3 if the defender is a Lightning Pokémon,
; 128 otherwise
.StrangeBeam:
	call SwapTurn
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call LoadCardDataToBuffer2_FromDeckIndex
	call SwapTurn
	ld a, [wLoadedCard2Type]
	cp LIGHTNING
	jr z, .encourage_strange_beam
	ld a, 128
	ret
.encourage_strange_beam
	ld a, 131
	ret

; 128 + 3 if any Bill or Imposter Prof Oak in deck pile,
; 128 otherwise
.ErrandRunning:
	ld de, BILL
	ld a, CARD_LOCATION_DECK
	call FindCardIDInLocation
	jr c, .encourage_errand_running
	ld de, IMPOSTER_PROFESSOR_OAK
	ld a, CARD_LOCATION_DECK
	call FindCardIDInLocation
	jr c, .encourage_errand_running
	ld a, 128
	ret
.encourage_errand_running
	ld a, 131
	ret

; 1/2 chance each of 128 + {0 or 3}
.KickAway:
	ld a, 2
	call Random
	or a
	jr z, .kick_away_neutral
	ld a, 131
	ret
.kick_away_neutral
	ld a, 128
	ret

; Jes:
;   128 + 1 if 2+ own viable Benched Pokémon,
;   128 + 3 otherwise;
; Biruritchi (unused):
;   128 - 3 if 8+ cards in hand,
;   128 + 3 otherwise;
; for other AIs: 128 + 2
.ClearProfit:
	ld a, [wOpponentDeckID]
	cp COMPLETE_COMBUSTION_DECK_ID
	jr z, .clear_profit_jes
	cp STOP_LIFE_DECK_ID
	jr nz, .mid_clear_profit_score

; Biruritchi, unused
	ld a, DUELVARS_NUMBER_OF_CARDS_IN_HAND
	get_turn_duelist_var
	cp 8
	jr c, .higher_clear_profit_score
	ld a, 125
	ret

.clear_profit_jes
	call CountNumberOfSetUpBenchPokemon
	cp 2
	jr c, .higher_clear_profit_score
	ld a, 129
	ret

.higher_clear_profit_score
	ld a, 131
	ret

.mid_clear_profit_score
	ld a, 130
	ret

; dismiss if no viable targets,
; 128 + 2 otherwise
.Microwave:
	farcall IsPlayerArenaCardImmuneAndNoBenchedPokemon
	jp c, .ZeroScore
	ld a, 130
	ret

; 128 + 3 if any Dark Gyarados in deck pile,
; dismiss otherwise
; (only checking Dark Gyarados)
.RapidEvolution:
	ld de, DARK_GYARADOS
	ld a, CARD_LOCATION_DECK
	call FindCardIDInLocation
	jp nc, .ZeroScore
	ld a, 131
	ret

; 128 + 10 if player has 2+ prizes remaining, and Venomoth is out of KO range;
; else,
;   dismiss if 1+ Benched Pokémon, and none of them is viable;
;   128 otherwise
.StirUpTwister:
	xor a ; PLAY_AREA_ARENA
	ldh [hTempPlayAreaLocation_ff9d], a
	call SwapTurn
	call CountPrizes
	call SwapTurn
	cp 1
	jr z, .check_bench_stir_up_twister
	farcall CheckIfDefendingPokemonCanKnockOut
	jr nc, .encourage_stir_up_twister
.check_bench_stir_up_twister
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	cp 1
	jr z, .stir_up_twister_neutral
	call CountNumberOfSetUpBenchPokemon
	jp nc, .ZeroScore

.stir_up_twister_neutral
	ld a, 128
	ret

.encourage_stir_up_twister
	ld a, 138
	ret

; 128 + 3 if
;   2+ Weezing family in play, and
;   not KOing enough number of own Pokémon for player to win;
; dismiss otherwise
.MassExplosion:
	farcall AICountMassExplosion
	jp c, .ZeroScore
	cp 2
	jp c, .ZeroScore
	ld a, 131
	ret

; 128 + 10 if
;   no Pokémon Power locks yet, and
;   has any Pokémon in KO range or any special targets in play;
; 128 otherwise
; Miyuki: also consider any Goop Gas Attack in hand
; (AIChooseStareTarget already covers Muk)
.Stare:
	ld a, [wOpponentDeckID]
	cp STICKY_POISON_GAS_DECK_ID
	jr nz, .stare_find_target

; Miyuki
	ld de, MUK
	ld b, PLAY_AREA_BENCH_1
	call FindCardIDInTurnDuelistsPlayArea
	jr c, .stare_neutral
	ld de, GOOP_GAS_ATTACK
	call LookForCardIDInHandList
	jr c, .stare_neutral

.stare_find_target
	farcall IsPlayerArenaCardImmune
	ld a, PLAY_AREA_BENCH_1
	jr c, .stare_find_area
	xor a ; PLAY_AREA_ARENA
.stare_find_area
	ld d, 10
	call AIFindPlayAreaPkmnWithMinimumLeastRemainingHP
	ld a, 10
	cp d
	jr z, .encourage_stare
	farcall AIChooseStareTarget
	jr c, .encourage_stare

.stare_neutral
	ld a, 128
	ret

.encourage_stare
	ld a, 138
	ret

; dismiss if not Imakuni? or Tap
; Eat:
;   Imakuni?: dismiss if already 2 food counters, 128 + 13 otherwise
;   Tap: dismiss if Rollout is ready for damage output, 128 + 3 otherwise
; Rollout:
;   128 + 3 if doing damage, dismiss otherwise
.HungrySnorlax:
	ld a, [wOpponentDeckID]
	cp DANGEROUS_BENCH_DECK_ID
	jr z, .hungry_snorlax_tap
	cp WEIRD_DECK_ID
	jp nz, .ZeroScore

; Imakuni?
	ld a, [wSelectedAttack]
	or a
	jp nz, .Rollout
; Eat
	ld a, DUELVARS_ARENA_CARD_FOOD_COUNTERS
	get_turn_duelist_var
	cp 2
	jp nc, .ZeroScore
	ld a, 141
	ret

.hungry_snorlax_tap
	ld a, [wSelectedAttack]
	or a
	jp nz, .Rollout
; Eat
	xor a ; PLAY_AREA_ARENA
	farcall CheckIfCanDamageDefendingPokemon
	jp c, .ZeroScore
	ld a, 131
	ret

.Rollout:
	xor a ; PLAY_AREA_ARENA
	farcall CheckIfCanDamageDefendingPokemon
	jr c, .rollout_success
	ld a, [wAIMaxDamage]
	or a
	jp z, .ZeroScore
.rollout_success
	ld a, 131
	ret

; always 128
.MagneticLines:
	ld a, 128
	ret

; dismiss if no Bench targets, and the defender is immune;
; 128 + 2 if
;   Dark Rapidash is in KO range, or
;   any Benched targets is in KO range of Flame Pillar;
; 128 otherwise
.FlamePillar:
	farcall IsPlayerArenaCardImmuneAndNoBenchedPokemon
	jp c, .ZeroScore
	farcall CheckIfDefendingPokemonCanKnockOut
	jr c, .encourage_flame_pillar
	ld a, PLAY_AREA_BENCH_1
	ld d, 10
	call AIFindPlayAreaPkmnWithMinimumLeastRemainingHP
	jr nc, .flame_pillar_neutral
	ld a, 10
	cp d
	jr z, .encourage_flame_pillar
.flame_pillar_neutral
	ld a, 128
	ret
.encourage_flame_pillar
	ld a, 130
	ret

; 128 + 4 if
;   Magmar is in KO range, and
;   Burning Fire does more damage (at max) than Magma Punch;
; 128 otherwise
.BurningFire:
	farcall CheckIfDefendingPokemonCanKnockOut
	jp nc, .burning_fire_neutral
	xor a
	ldh [hTempPlayAreaLocation_ff9d], a
	ld a, SECOND_ATTACK
	farcall EstimateDamage_VersusDefendingCard
	ld a, [wDamage]
	push af
	xor a ; FIRST_ATTACK_OR_PKMN_POWER
	farcall EstimateDamage_VersusDefendingCard
	ld a, [wAIMaxDamage]
	ld b, a
	pop af
	cp b
	jr c, .burning_fire_neutral
	ld a, 132
	ret
.burning_fire_neutral
	ld a, 128
	ret

; always 128
.ContinuousFireball:
	ld a, 128
	ret

; 128 + 5 if
;   any viable targets, and
;   Golem is in KO range or has 5+ Energy attached;
; 128 - 10 otherwise
.RockBlast:
	farcall IsPlayerArenaCardImmune
	jr nc, .rock_blast_is_golem_going_down
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	call GetNonTurnDuelistVariable
	cp 1
	jr z, .discourage_rock_blast
.rock_blast_is_golem_going_down
	xor a ; PLAY_AREA_ARENA
	ldh [hTempPlayAreaLocation_ff9d], a
	farcall CheckIfDefendingPokemonCanKnockOut
	jp c, .encourage_rock_blast
	ld e, PLAY_AREA_ARENA
	call GetPlayAreaCardAttachedEnergies
	ld a, [wTotalAttachedEnergies]
	cp 5
	jr nc, .encourage_rock_blast
.discourage_rock_blast
	ld a, 118
	ret
.encourage_rock_blast
	ld a, 133
	ret

; dismiss if KOing with Knock Back
; else,
;   128 + 5 if
;     KOing any with Drag Off, or
;     the defender is resistant to Dark Machoke's type;
;   dismiss otherwise
.DragOff:
	xor a ; PLAY_AREA_ARENA
	ldh [hTempPlayAreaLocation_ff9d], a
	ld a, SECOND_ATTACK
	farcall EstimateDamage_VersusDefendingCard
	ld a, DUELVARS_ARENA_CARD_HP
	call GetNonTurnDuelistVariable
	ld hl, wDamage
	sub [hl]
	jr z, .dark_machoke_check_energy
	jr nc, .drag_off_check_bench
.dark_machoke_check_energy
	farcall CheckIfSelectedAttackIsUnusable
	jp nc, .ZeroScore
.drag_off_check_bench
	farcall FindBenchCardThatCanBeKnockedOut
	jr c, .drag_off_success
	farcall CheckIfDefendingCardIsResistantToArenaCard
	jp nc, .ZeroScore
.drag_off_success
	ld a, 133
	ret

; 128 + 8 if the defender is resistant/weak (?) to Dark Machamp's type or has 70+ HP remaining;
; dismiss otherwise
.Fling:
	farcall CheckIfDefendingCardIsResistantToArenaCard
	jr c, .fling_success
	farcall CheckIfDefendingCardIsWeakToArenaCard
	jr c, .fling_success
	ld a, DUELVARS_ARENA_CARD
	call SwapTurn
	get_turn_duelist_var
	call LoadCardDataToBuffer2_FromDeckIndex
	call SwapTurn
	ld a, [wLoadedCard2HP]
	cp 70
	jp c, .ZeroScore
	ld b, a
	ld a, DUELVARS_ARENA_CARD_HP
	call GetNonTurnDuelistVariable
	cp b
	jp c, .ZeroScore
.fling_success
	ld a, 136
	ret

; always 128
.TeleportBlast:
	ld a, 128
	ret

; 128 + 2 if
;   player has any Benched Pokémon, and
;   their active Pokémon has any Energy attached to it;
; dismiss otherwise
.EnergyControl:
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	call GetNonTurnDuelistVariable
	cp 1
	jp z, .ZeroScore
	xor a ; PLAY_AREA_ARENA
	call SwapTurn
	farcall GetFirstBasicEnergyAttachedToPlayAreaCard
	call SwapTurn
	jp c, .ZeroScore
	ld a, 130
	ret

; Magician:
;   128 + 10 if
;     not KOing with Psyshock,
;     Abra is in KO range, and
;     2+ of Kadabra, Alakazam, Mr. Mime, or Scyther on his Bench;
;   128 - 28 otherwise;
; other AIs:
;   128 + 7 if
;     3+ Benched Pokémon,
;     no non-Dark Kadabra cards in hand, and
;     Abra is in KO range;
;   dismiss otherwise
.Vanish:
	ld a, [wOpponentDeckID]
	cp IMMORTAL_POKEMON_DECK_ID
	jr z, .vanish_magician

	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	cp 3
	jp c, .ZeroScore
	ld de, KADABRA_LV38
	call LookForCardIDInHandList
	jp c, .ZeroScore
	ld de, KADABRA_LV39
	call LookForCardIDInHandList
	jp c, .ZeroScore
	xor a
	ldh [hTempPlayAreaLocation_ff9d], a
	farcall CheckIfDefendingPokemonCanKnockOut
	jp nc, .ZeroScore
	ld a, 135
	ret

.vanish_magician
	farcall AIMagicianHandleVanish
	ret

; Mami:
;   128 if no Benched Pokémon, or player has only 1 prizes remaining;
;   else,
;     dismiss if Slowpoke has 8+ Psychic Energy attached to it;
;     128 + 3 otherwise;
; Kanzaki:
;   dismiss if Slowpoke has 2+ Psychic Energy attached to it;
;   128 + 3 otherwise;
; other AIs:
;   dismiss if Slowpoke has any Psychic Energy attached to it;
;   128 + 3 otherwise
.AfternoonNap:
	ld a, [wOpponentDeckID]
	cp SPIRITED_AWAY_DECK_ID
	jr z, .afternoon_nap_mami
	cp BAD_GUYS_DECK_ID
	jr z, .afternoon_nap_kanzaki

	ld e, PLAY_AREA_ARENA
	call GetPlayAreaCardAttachedEnergies
	ld a, [wAttachedEnergies + PSYCHIC]
	or a
	jp nz, .ZeroScore

.encourage_afternoon_nap
	ld a, 131
	ret

.afternoon_nap_mami
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	cp 1
	jr z, .afternoon_nap_neutral
	call SwapTurn
	call CountPrizes
	call SwapTurn
	cp 1
	jr z, .afternoon_nap_neutral
	ld e, PLAY_AREA_ARENA
	call GetPlayAreaCardAttachedEnergies
	ld a, [wAttachedEnergies + PSYCHIC]
	cp 8
	jr c, .encourage_afternoon_nap
	jp .ZeroScore

.afternoon_nap_kanzaki
	ld e, PLAY_AREA_ARENA
	call GetPlayAreaCardAttachedEnergies
	ld a, [wAttachedEnergies + PSYCHIC]
	cp 2
	jr c, .encourage_afternoon_nap
	jp .ZeroScore

.afternoon_nap_neutral
	ld a, 128
	ret

; always 128 + 1
.MankeyLv14:
	ld a, 129
	ret

; Ronald: always 128 + 2;
; other AIs: always 128
.Twister:
	ld a, [wOpponentDeckID]
	cp RONALDS_ULTRA_DECK_ID
	jr z, .twister_ronald
	ld a, 128
	ret

.twister_ronald
	ld a, 130
	ret

; dismiss if confused or already resistant;
; 128 + 4 otherwise
.PorygonLv18Confusion2:
	ld a, DUELVARS_ARENA_CARD_STATUS
	get_turn_duelist_var
	and CNF_SLP_PRZ
	cp CONFUSED
	jp z, .ZeroScore

	farcall CheckIfArenaCardIsResistantToDefendingCard
	jp c, .ZeroScore
	ld a, 132
	ret

; dismiss if confused; else,
; 128 + 7 if
;   it's worth changing Resistance, or
;   with any own viable Benched Pokémon, it's worth changing Weakness;
; dismiss otherwise;
; non-Ishihara AIs also checks Colorless weakness (non-existent at that time)
.TextureMagic:
	ld a, DUELVARS_ARENA_CARD_STATUS
	get_turn_duelist_var
	and CNF_SLP_PRZ
	cp CONFUSED
	jp z, .ZeroScore

	farcall IsPlayerArenaCardImmune
	jr c, .is_cool_porygon_already_resistant
	call SwapTurn
	bank1call GetArenaCardWeakness
	call SwapTurn
	or a
	jr z, .is_cool_porygon_already_resistant

	ld a, [wOpponentDeckID]
	cp VERY_RARE_CARD_DECK_ID
	jr z, .texture_magic_check_bench

	call SwapTurn
	bank1call GetArenaCardWeakness
	call SwapTurn
	cp COLORLESS_F
	jr z, .is_cool_porygon_already_resistant

.texture_magic_check_bench
	call CountNumberOfSetUpBenchPokemon
	jr nc, .is_cool_porygon_already_resistant

	call AISelectSpecialAttackParameters.SelectAttackParameters
	ldh a, [hTempPlayAreaLocation_ffa1]
	cp $ff
	jr z, .is_cool_porygon_already_resistant
	call TranslateColorToWR
	push af
	call SwapTurn
	bank1call GetArenaCardWeakness
	call SwapTurn
	pop bc
	cp b
	jr nz, .texture_magic_success

.is_cool_porygon_already_resistant
	farcall CheckIfArenaCardIsResistantToDefendingCard
	jp c, .ZeroScore

.texture_magic_success
	ld a, 135
	ret

; dismiss if Mewtwo is out of KO range or KOing with Psycho Blast;
; 128 + 5 otherwise
.CompleteRecovery:
	xor a ; PLAY_AREA_ARENA
	ldh [hTempPlayAreaLocation_ff9d], a
	farcall CheckIfDefendingPokemonCanKnockOut
	jp nc, .ZeroScore
	farcall CheckIfArenaCardCanKnockOutDefendingCard
	jp c, .ZeroScore
	ld a, 133
	ret

; always 128 + 2
.Perplex:
	ld a, 130
	ret

; dismiss if Big Snore is available;
; 128 + 1 otherwise
.BigYawn:
	ld a, DUELVARS_ARENA_CARD_STATUS
	get_turn_duelist_var
	and CNF_SLP_PRZ
	cp ASLEEP
	jp z, .ZeroScore
	ld a, 129
	ret
