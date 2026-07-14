AIDecideSpecialEvolutions:
	ld a, [wOpponentDeckID]
	cp ELECTRIC_SELFDESTRUCT_DECK_ID
	jp z, .ElectricSelfdestructDeck
	cp PSYCHIC_ELITE_DECK_ID
	jp z, .PsychicEliteDeck
	cp PUPPET_MASTER_DECK_ID
	jp z, .PuppetMasterDeck
	cp MAX_ENERGY_DECK_ID
	jp z, .MaxEnergyDeck
	cp GATHERING_NIDORAN_DECK_ID
	jp z, .GatheringNidoranDeck
	cp RAIN_DANCE_CONFUSION_DECK_ID
	jp z, .RainDanceConfusionDeck
	cp GO_ARCANINE_DECK_ID
	jp z, .GoArcanineDeck
	cp GREAT_ROCKET4_DECK_ID
	jp z, .GreatRocket4Deck
	cp LEGENDARY_FOSSIL_DECK_ID
	jp z, .LegendaryFossilDeck
	cp GREAT_DRAGON_DECK_ID
	jr z, .GreatDragonDeck
	cp DANGEROUS_BENCH_DECK_ID
	jp z, .DangerousBenchDeck
	cp QUICK_ATTACK_DECK_ID
	jp z, .QuickAttackDeck
	cp ROCK_BLAST_DECK_ID
	jp z, .RockBlastDeck
	cp RUNNING_WILD_DECK_ID
	jp z, .RunningWildDeck
	cp BAD_DREAM_DECK_ID
	jp z, .BadDreamDeck
	cp POKEMON_POWER_DECK_ID
	jp z, .PokemonPowerDeck
	cp SUDDEN_GROWTH_DECK_ID
	jp z, .SuddenGrowthDeck
	cp BAD_GUYS_DECK_ID
	jp z, .BadGuysDeck
	cp STOP_LIFE_DECK_ID
	jp z, .ChokeDeck
	cp SCORCHER_DECK_ID
	jp z, .IncinerateDeck
	cp TSUNAMI_STARTER_DECK_ID
	jp z, .SmashDeck
	cp SMASH_TO_MINCEMEAT_DECK_ID
	jp z, .ThrowOutDeck
	cp RONALDS_PSYCHIC_DECK_ID
	jp z, .RonaldsPsychicDeck
	cp EVERYBODYS_FRIEND_DECK_ID
	jp z, .EverybodysFriendDeck
	cp IMMORTAL_POKEMON_DECK_ID
	jp z, .ImmortalPokemonDeck
	cp TORRENTIAL_FLOOD_DECK_ID
	jp z, .TorrentialFloodDeck
	cp TRAINER_IMPRISON_DECK_ID
	jp z, .TrainerImprisonDeck

.standard_score:
	ld a, AI_SCORE_NEUTRAL
	ret

.GreatDragonDeck:
	ld hl, wLoadedCard2ID
	cphl DRAGONAIR
	jp z, .dragonair_great_dragon_deck
	jr .standard_score

; Magnemite: +10;
; Voltorb: dismiss if >= 5 own Pokémon in play, +10 otherwise;
; Doduo: dismiss if >= 30 HP, +10 otherwise;
; others (non-existent): neutral
.ElectricSelfdestructDeck:
	ld hl, wLoadedCard2ID
	cphl MAGNEMITE_LV13
	jr z, .encourage_electric_selfdestruct_deck
	cphl MAGNEMITE_LV15
	jr z, .encourage_electric_selfdestruct_deck
	cphl VOLTORB_LV8
	jr z, .voltorb
	cphl DODUO_LV10
	jp nz, .standard_score
; Doduo
	ldh a, [hTempPlayAreaLocation_ff9d]
	add DUELVARS_ARENA_CARD_HP
	get_turn_duelist_var
	cp 30
	jr c, .encourage_electric_selfdestruct_deck
	jr .dismiss_electric_selfdestruct_deck
.voltorb
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	cp 5
	jr c, .encourage_electric_selfdestruct_deck
.dismiss_electric_selfdestruct_deck
	xor a
	ret
.encourage_electric_selfdestruct_deck
	ld a, AI_SCORE_NEUTRAL + 10
	ret

; Alakazam line: +10;
; others: neutral
.PsychicEliteDeck:
	ld hl, wLoadedCard2ID
	cphl ABRA_LV14
	jr z, .encourage_psychic_elite_deck
	cphl KADABRA_LV39
	jp nz, .standard_score
.encourage_psychic_elite_deck
	ld a, AI_SCORE_NEUTRAL + 10
	ret

; Drowzee: neutral
; Slowpoke: -5 if any Clefairy Doll in discard pile, neutral otherwise;
.PuppetMasterDeck:
	ld hl, wLoadedCard2ID
	cphl SLOWPOKE_LV18
	jp nz, .standard_score ; Drowzee
	ld de, CLEFAIRY_DOLL
	ld a, CARD_LOCATION_DISCARD_PILE
	call FindCardIDInLocation
	jp nc, .standard_score
	ld a, AI_SCORE_NEUTRAL - 5
	ret

; Exeggcute: +5;
; others: neutral
.MaxEnergyDeck:
	ld hl, wLoadedCard2ID
	cphl EXEGGCUTE
	jp nz, .standard_score
	ld a, AI_SCORE_NEUTRAL + 5
	ret

; active: neutral
; benched: +10
.GatheringNidoranDeck:
	ldh a, [hTempPlayAreaLocation_ff9d]
	or a
	jp z, .standard_score
	ld a, AI_SCORE_NEUTRAL + 10
	ret

; +10
.RainDanceConfusionDeck:
.QuickAttackDeck:
.RockBlastDeck:
.RunningWildDeck:
.EverybodysFriendDeck:
	ld a, AI_SCORE_NEUTRAL + 10
	ret

; Growlithe: neutral
; others:
;   expectation: -28 if already evolved, +10 otherwise;
;   reality: neutral
.GoArcanineDeck:
	ld hl, wLoadedCard2ID
; bug, should be:
	; cphl SEEL_LV12
	; ld de, DEWGONG_LV42
	; jr z, .dewgong_or_dodrio
	; cphl DODUO_LV10
	; ld de, DODRIO_LV28
	; jp nz, .standard_score
; .dewgong_or_dodrio
	; ld b, PLAY_AREA_ARENA
	; call FindCardIDInTurnDuelistsPlayArea
	cphl DEWGONG_LV42
	jr z, .dewgong_or_dodrio
	cphl DODRIO_LV28
	jp nz, .standard_score
.dewgong_or_dodrio
	ld e, [hl]
	inc hl
	ld d, [hl]
	ld b, PLAY_AREA_ARENA
	call FindCardIDInTurnDuelistsPlayArea
	jp nc, .encourage_go_arcanine_deck
	ld a, AI_SCORE_NEUTRAL - 28
	ret
.encourage_go_arcanine_deck
	ld a, AI_SCORE_NEUTRAL + 10
	ret

; Drowzee: neutral if active, -10 if benched
; others: neutral
.GreatRocket4Deck:
	ld hl, wLoadedCard2ID
	cphl DROWZEE_LV10
	jp nz, .standard_score
	ldh a, [hTempPlayAreaLocation_ff9d]
	or a
	jp z, .standard_score
	ld a, AI_SCORE_NEUTRAL - 10
	ret

; Fossil: +10
; Voltorb: neutral
.LegendaryFossilDeck:
	ld hl, wLoadedCard2ID
	cphl MYSTERIOUS_FOSSIL
	jp nz, .standard_score
	ld a, AI_SCORE_NEUTRAL + 10
	ret

; Dark Dragonair:
;   +10 if
;        active with >= 4 Energy attached to it
;     OR (<= 3 own Pokémon in play AND no basic cards in hand);
;   -10 otherwise;
; others: neutral
.DangerousBenchDeck:
	ld hl, wLoadedCard2ID
	cphl DARK_DRAGONAIR
	jp nz, .standard_score
	ldh a, [hTempPlayAreaLocation_ff9d]
	or a
	jr nz, .tally_dangerous_bench_deck
	ld e, a
	call GetPlayAreaCardAttachedEnergies
	ld a, [wTotalAttachedEnergies]
	cp 4
	jr nc, .encourage_dangerous_bench_deck
.tally_dangerous_bench_deck
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	cp 3
	jr nc, .discourage_dangerous_bench_deck
	farcall CountNumberOfBasicPokemonInHand
	or a
	jr nz, .discourage_dangerous_bench_deck
.encourage_dangerous_bench_deck
	ld a, AI_SCORE_NEUTRAL + 10
	ret
.discourage_dangerous_bench_deck
	ld a, AI_SCORE_NEUTRAL - 10
	ret

; Gastly: +10;
; Haunter Lv.17: neutral;
; Haunter Lv.22: -10;
; Drowzee:
;   +10 if any other Drowzee is in play OR Bench is full;
;   -10 otherwise
.BadDreamDeck:
	ld hl, wLoadedCard2ID
	cphl GASTLY_LV13
	jr z, .encourage_bad_dream_deck
	cphl HAUNTER_LV22
	jr z, .discourage_bad_dream_deck
	cphl DROWZEE_LV10
	jp nz, .standard_score
	ld de, DROWZEE_LV10
	ld b, PLAY_AREA_ARENA
	farcall CountCardIDInTurnDuelistPlayArea
	cp 2
	jr c, .discourage_bad_dream_deck
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	call GetNonTurnDuelistVariable
	cp 6
	jr nz, .discourage_bad_dream_deck
.encourage_bad_dream_deck
	ld a, AI_SCORE_NEUTRAL + 10
	ret
.discourage_bad_dream_deck
	ld a, AI_SCORE_NEUTRAL - 10
	ret

; Meowth: -10 if >= 7 cards in hand, +10 otherwise;
; others: neutral
.PokemonPowerDeck:
	ld hl, wLoadedCard2ID
	cphl MEOWTH_LV14
	jp nz, .standard_score
	ld a, DUELVARS_NUMBER_OF_CARDS_IN_HAND
	get_turn_duelist_var
	cp 7
	jr c, .discourage_pokemon_power_deck
	ld a, AI_SCORE_NEUTRAL + 10
	ret
.discourage_pokemon_power_deck
	ld a, AI_SCORE_NEUTRAL - 10
	ret

; Dratini: +2;
; Clefairy: +10;
; Dark Dragonair: +10 if >= 2 Dark Clefable in play, -10 otherwise
.SuddenGrowthDeck:
	ld hl, wLoadedCard2ID
	cphl DRATINI_LV12
	jr z, .mid_score_sudden_growth_deck
	cphl CLEFAIRY_LV15
	jr z, .higher_score_sudden_growth_deck
	cphl DARK_DRAGONAIR
	jp nz, .standard_score
	ld de, DARK_CLEFABLE
	ld b, PLAY_AREA_ARENA
	farcall CountCardIDInTurnDuelistPlayArea
	cp 2
	jr c, .lower_score_sudden_growth_deck
.higher_score_sudden_growth_deck
	ld a, AI_SCORE_NEUTRAL + 10
	ret
.lower_score_sudden_growth_deck
	ld a, AI_SCORE_NEUTRAL - 10
	ret
.mid_score_sudden_growth_deck
	ld a, AI_SCORE_NEUTRAL + 2
	ret

; Oddish: -28 if any Dark Gloom already, neutral otherwise;
; Slowpoke:
;   +12 if none other than Slowpoke is in play;
;   else, for n = number of Dark Slowbro in play,
;     n = 0: +12 if >= 2 Psychic Energy attached to Slowpoke;
;     n = 1: +12 if towards using Reel In;
;   -28 otherwise
; others: neutral
.BadGuysDeck:
	ld hl, wLoadedCard2ID
	cphl ODDISH_LV21
	jr z, .oddish_bad_guys_deck
	cphl SLOWPOKE_LV16
	jr z, .slowpoke_bad_guys_deck
	jp .standard_score

.oddish_bad_guys_deck
	ld de, DARK_GLOOM
	ld b, PLAY_AREA_BENCH_1
	call FindCardIDInTurnDuelistsPlayArea
	jp nc, .standard_score

.discourage_bad_guys_deck
	ld a, AI_SCORE_NEUTRAL - 28
	ret

.encourage_bad_guys_deck
	ld a, AI_SCORE_NEUTRAL + 12
	ret

.slowpoke_bad_guys_deck
	ld de, DARK_SLOWBRO
	ld b, PLAY_AREA_ARENA
	farcall CountCardIDInTurnDuelistPlayArea
	or a
	jr nz, .has_dark_slowbro
	ldh a, [hTempPlayAreaLocation_ff9d]
	ld e, a
	call GetPlayAreaCardAttachedEnergies
	ld a, [wAttachedEnergies + PSYCHIC]
	cp 2
	jr nc, .encourage_bad_guys_deck
	jr .check_non_slowpoke
.has_dark_slowbro
	cp 1
	jr nz, .check_non_slowpoke
	farcall AIDecide_ReelIn_BadGuysDeck
	jr c, .encourage_bad_guys_deck
.check_non_slowpoke
	ld de, SLOWPOKE_LV16
	ld b, PLAY_AREA_ARENA
	farcall CountCardIDInTurnDuelistPlayArea
	ld b, a
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	cp b
	jr z, .encourage_bad_guys_deck
	jr .discourage_bad_guys_deck

; Dratini:
;   -28 if any Dark Dragonair in play;
;   +12 if benched AND no Dark Dragonair yet;
;   neutral if active AND no Dark Dragonair yet;
; others: neutral
.ChokeDeck:
	ld hl, wLoadedCard2ID
	cphl DRATINI_LV10
	jp nz, .standard_score
	ld de, DARK_DRAGONAIR
	ld b, PLAY_AREA_ARENA
	call FindCardIDInTurnDuelistsPlayArea
	jr c, .discourage_choke_deck
	ldh a, [hTempPlayAreaLocation_ff9d]
	or a
	jp z, .standard_score
	ld a, AI_SCORE_NEUTRAL + 12
	ret
.discourage_choke_deck
	ld a, AI_SCORE_NEUTRAL - 28
	ret

; Clefairy:
;   -28 if Dark Charizard isn't ready OR any Dark Clefable is in play;
;   neutral otherwise
; others: neutral
.IncinerateDeck:
	ld hl, wLoadedCard2ID
	cphl CLEFAIRY_LV15
	jp nz, .standard_score
	ld de, DARK_CHARIZARD
	farcall CheckCardIDInPlayAreaThatCanUseAttacks
	jp nc, .discourage_incinerate_deck
	ld de, DARK_CLEFABLE
	ld b, PLAY_AREA_ARENA
	call FindCardIDInTurnDuelistsPlayArea
	jp nc, .standard_score
.discourage_incinerate_deck
	ld a, AI_SCORE_NEUTRAL - 28
	ret

; Clefairy:
;   -28 if Dark Blastoise isn't ready OR any Dark Clefable is in play;
;   neutral otherwise
; others: neutral
.SmashDeck:
	ld hl, wLoadedCard2ID
	cphl CLEFAIRY_LV15
	jp nz, .standard_score
	ld de, DARK_BLASTOISE
	farcall CheckCardIDInPlayAreaThatCanUseAttacks
	jp nc, .discourage_biruritchi_water
	ld de, DARK_CLEFABLE
	ld b, PLAY_AREA_ARENA
	call FindCardIDInTurnDuelistsPlayArea
	jp nc, .standard_score
.discourage_biruritchi_water
	ld a, AI_SCORE_NEUTRAL - 28
	ret

; Clefairy:
;   -28 if Dark Machamp isn't ready OR any Dark Clefable is in play;
;   neutral otherwise
; others: neutral
.ThrowOutDeck:
	ld hl, wLoadedCard2ID
	cphl CLEFAIRY_LV15
	jp nz, .standard_score
	ld de, DARK_MACHAMP
	farcall CheckCardIDInPlayAreaThatCanUseAttacks
	jp nc, .discourage_throw_out_deck
	ld de, DARK_CLEFABLE
	ld b, PLAY_AREA_ARENA
	call FindCardIDInTurnDuelistsPlayArea
	jp nc, .standard_score
.discourage_throw_out_deck
	ld a, AI_SCORE_NEUTRAL - 28
	ret

; Gastly: neutral
; Haunter: -28 if any Gengar in play, neutral otherwise;
; Dratini: +12;
; Dark Dragonair:
;   -28 if any Dark Dragonite OR >= 5 Pokémon in play,
;   neutral otherwise
.RonaldsPsychicDeck:
	ld hl, wLoadedCard2ID
	cphl HAUNTER_LV26
	jr z, .haunter
	cphl DARK_DRAGONAIR
	jr z, .dark_dragonair_ronalds_psychic_deck
	cphl DRATINI_LV10
	jr z, .encourage_ronalds_psychic_deck
	jp .standard_score

.haunter
	ld de, GENGAR_LV40
	ld b, PLAY_AREA_ARENA
	call FindCardIDInTurnDuelistsPlayArea
	jp nc, .standard_score

.discourage_ronalds_psychic_deck
	ld a, AI_SCORE_NEUTRAL - 28
	ret

.encourage_ronalds_psychic_deck
	ld a, AI_SCORE_NEUTRAL + 12
	ret

.dark_dragonair_ronalds_psychic_deck
	ld de, DARK_DRAGONITE
	ld b, PLAY_AREA_ARENA
	call FindCardIDInTurnDuelistsPlayArea
	jr c, .discourage_ronalds_psychic_deck
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	cp 5
	jr nc, .discourage_ronalds_psychic_deck
	jp .standard_score

; Abra: +12;
; Kadabra: -28 if any Alakazam in play, +12 otherwise;
; others (non-existent): neutral
.ImmortalPokemonDeck:
	ld hl, wLoadedCard2ID
	cphl ABRA_LV14
	jr z, .encourage_immortal_pokemon_deck
	cphl KADABRA_LV39
	jp nz, .standard_score
	ld de, ALAKAZAM_LV42
	ld b, PLAY_AREA_ARENA
	call FindCardIDInTurnDuelistsPlayArea
	jr c, .discourage_immortal_pokemon_deck
.encourage_immortal_pokemon_deck
	ld a, AI_SCORE_NEUTRAL + 12
	ret
.discourage_immortal_pokemon_deck
	ld a, AI_SCORE_NEUTRAL - 28
	ret

; Squirtle:
;   +12 if no Pokémon Breeder or Blastoise in hand,
;   -28 otherwise
; Wartortle:
;   +12 if no Pokémon Breeder in hand,
;   -28 if evolving Squirtle with Pokémon Breeder;
; others (non-existent): neutral
.TorrentialFloodDeck:
	ld hl, wLoadedCard2ID
	cphl SQUIRTLE_LV14
	jr z, .check_breeder_evo
	cphl WARTORTLE_LV24
	jp nz, .standard_score
	ld de, POKEMON_BREEDER
	call LookForCardIDInHandList
	jr nc, .encourage_torrential_flood_deck
	ld de, SQUIRTLE_LV14
	ld b, PLAY_AREA_ARENA
	call FindCardIDInTurnDuelistsPlayArea
	jr c, .discourage_torrential_flood_deck
.encourage_torrential_flood_deck
	ld a, AI_SCORE_NEUTRAL + 12
	ret
.check_breeder_evo
	ld de, POKEMON_BREEDER
	call LookForCardIDInHandList
	jr nc, .encourage_torrential_flood_deck
	ld de, BLASTOISE_LV52
	call LookForCardIDInHandList
	jr nc, .encourage_torrential_flood_deck
.discourage_torrential_flood_deck
	ld a, AI_SCORE_NEUTRAL - 28
	ret

; Oddish and Dark Gloom:
;   -28 if any other already evolved,
;   +12 otherwise;
; others: neutral
.TrainerImprisonDeck:
	ld hl, wLoadedCard2ID
	cphl ODDISH_LV21
	jr z, .oddish_trainer_imprison_deck
	cphl DARK_GLOOM
	jp nz, .standard_score
	ld de, DARK_VILEPLUME
	ld b, PLAY_AREA_ARENA
	call FindCardIDInTurnDuelistsPlayArea
	jr c, .discourage_trainer_imprison_deck
.encourage_trainer_imprison_deck
	ld a, AI_SCORE_NEUTRAL + 12
	ret
.oddish_trainer_imprison_deck
	ld de, DARK_GLOOM
	ld b, PLAY_AREA_ARENA
	call FindCardIDInTurnDuelistsPlayArea
	jr nc, .encourage_trainer_imprison_deck
.discourage_trainer_imprison_deck
	ld a, AI_SCORE_NEUTRAL - 28
	ret

; unchanged since TCG1
; +10 if
;       Muk isn't in play
;   AND (
;         Dragonair is Active with >= 50 damage and >= 3 Energy attached to it
;     OR (Dragonair is Benched AND >= 70 damage in total on own Pokémon in play)
;   );
; -10 otherwise
.dragonair_great_dragon_deck
	ldh a, [hTempPlayAreaLocation_ff9d]
	or a
	jr z, .dragonair_active

	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	ld b, a
	ld c, 0
.loop_dragonair_tally_damage
	dec b
	ld e, b
	push bc
	call GetCardDamageAndMaxHP
	pop bc
	add c
	ld c, a
	ld a, b
	or a
	jr nz, .loop_dragonair_tally_damage

	ld a, 70
	cp c
	jr c, .dragonair_check_muk

.lower_dragonair_score
	ld a, AI_SCORE_NEUTRAL - 10
	ret

; bug: should now use the lock-check function instead of this TCG1 code
.dragonair_check_muk
	ld de, MUK
	bank1call CountPokemonWithActivePkmnPowerInBothPlayAreas
	jr c, .lower_dragonair_score
	ld a, AI_SCORE_NEUTRAL + 10
	ret

.dragonair_active
	ld e, PLAY_AREA_ARENA
	call GetCardDamageAndMaxHP
	cp 50
	jr c, .lower_dragonair_score
	ld e, PLAY_AREA_ARENA
	call GetPlayAreaCardAttachedEnergies
	ld a, [wTotalAttachedEnergies]
	cp 3
	jr c, .lower_dragonair_score
	jr .dragonair_check_muk
