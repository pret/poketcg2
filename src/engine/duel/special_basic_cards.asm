AIDecideSpecialBasicCards:
	ld a, [wOpponentDeckID]
	cp BRICK_WALK_DECK_ID
	jp z, .BrickWalkDeck
	cp ELECTRIC_SELFDESTRUCT_DECK_ID
	jp z, .ElectricSelfdestructDeck
	cp PSYCHIC_ELITE_DECK_ID
	jp z, .PsychicEliteDeck
	cp RAGING_BILLOW_OF_FISTS_DECK_ID
	jp z, .RagingBillowOfFistsDeck
	cp GO_ARCANINE_DECK_ID
	jp z, .GoArcanineDeck
	cp GRAND_FIRE_DECK_ID
	jr z, .GrandFireDeck
	cp LEGENDARY_FOSSIL_DECK_ID
	jr z, .LegendaryFossilDeck
	cp WATER_LEGEND_DECK_ID
	jr z, .WaterLegendDeck
	cp SUDDEN_GROWTH_DECK_ID
	jp z, .SuddenGrowthDeck
	cp STOP_LIFE_DECK_ID
	jp z, .ChokeDeck
	cp SCORCHER_DECK_ID
	jp z, .IncinerateDeck
	cp TSUNAMI_STARTER_DECK_ID
	jp z, .SmashDeck
	cp SMASH_TO_MINCEMEAT_DECK_ID
	jp z, .ThrowOutDeck
	cp POWERFUL_POKEMON_DECK_ID
	jp z, .PowerfulPokemonDeck
	cp EVERYBODYS_FRIEND_DECK_ID
	jp z, .EverybodysFriendDeck
	cp IMMORTAL_POKEMON_DECK_ID
	jp z, .ImmortalPokemonDeck
	cp TORRENTIAL_FLOOD_DECK_ID
	jp z, .TorrentialFloodDeck ; can be jr
	cp TRAINER_IMPRISON_DECK_ID
	jp z, .TrainerImprisonDeck
	cp BIG_THUNDER_DECK_ID
	jp z, .BigThunderDeck

.standard_score
	ld a, 130
	ret

; legendary birds
.GrandFireDeck:
.LegendaryFossilDeck:
.WaterLegendDeck:
.TorrentialFloodDeck:
	ld hl, wLoadedCard1ID
	cphl ARTICUNO_LV37
	jr z, .articuno_lv37
	cphl MOLTRES_LV40
	jr z, .molters_lv40
	cphl ZAPDOS_LV68
	jr z, .zapdos_lv68
	jr .standard_score

.articuno_lv37
	; if has low number of Play Area cards,
	; just give Articuno lv37 a standard score
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	cp 2
	jr c, .standard_score ; < 2 Play Area Pokémon

	; otherwise, discourage playing it if
	; AI can KO arena card, or Defending cannot damage,
	; or if it decides it will retreat this turn
	farcall CheckIfArenaCardCanKnockOutDefendingCard
	jr c, .discourage_legendary_birds
	call CheckIfPokemonCanUseNonResidualAttack
	jr nc, .discourage_legendary_birds
	farcall AIDecideWhetherToRetreat_ConsiderStatus
	jr c, .discourage_legendary_birds

	; discourage if Defending card is already statused
	ld a, DUELVARS_ARENA_CARD_STATUS
	call GetNonTurnDuelistVariable
	or a
	jr nz, .discourage_legendary_birds

	; give standard score if number of Play Area
	; cards is 5, but skip this check if
	; Defending card has a Pkmn Power
	call SwapTurn
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	ld d, a
	ld e, PLAY_AREA_ARENA
	call CopyAttackDataAndDamage_FromDeckIndex
	call SwapTurn
	ld a, [wLoadedAttackCategory]
	cp POKEMON_POWER
	jr z, .skip_play_area_check
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	cp 5
	jr nc, .standard_score ; >= 5 Play Area Pokémon
.skip_play_area_check
	; discourage if Pkmn Powers are disabled
	bank1call CheckGoopGasAttackAndToxicGasActive
	jr c, .discourage_legendary_birds

	; discourage if Defending card is Snorlax lv20
	ld a, DUELVARS_ARENA_CARD
	call GetNonTurnDuelistVariable
	call SwapTurn
	call GetCardIDFromDeckIndex
	call SwapTurn
	cp16 SNORLAX_LV20
	jr z, .discourage_legendary_birds

	; encourage playing Articuno
	ld a, 200
	ret

.discourage_legendary_birds
	ld a, 40
	ret

.molters_lv40
	; discourage if Pkmn Powers are disabled
	bank1call CheckGoopGasAttackAndToxicGasActive
	jr c, .discourage_legendary_birds

	; discourage if has low deck card count
	ld a, DUELVARS_NUMBER_OF_CARDS_NOT_IN_DECK
	get_turn_duelist_var
	cp DECK_SIZE - 4
	jr nc, .discourage_legendary_birds ; cards in deck <= 4
	jp .standard_score

.zapdos_lv68
	; discourage if Pkmn Powers are disabled
	bank1call CheckGoopGasAttackAndToxicGasActive
	jr c, .discourage_legendary_birds

	; discourage if AI has a number of Play Area cards
	; greater than or equal to the player
	; (that is, the odds of Zapdos lv68 hitting own
	; Play Area is greater than or equal to 50%)
	call SwapTurn
	farcall CountPlayAreaPokemonExcludingTrainerPokemon
	call SwapTurn
	push af
	farcall CountPlayAreaPokemonExcludingTrainerPokemon
	pop bc
	cp b
	jr nc, .discourage_legendary_birds
	jp .standard_score

; unreferenced
	ld hl, wLoadedCard1ID
	cphl ELECTABUZZ_LV35
	jr z, .asm_29f3b
	cphl DODUO_LV10
	jr z, .asm_29f3b
	cphl ZAPDOS_LV40
	jr z, .asm_29f4c
	jp nz, .standard_score
.asm_29f3b
	ld e, [hl]
	inc hl
	ld d, [hl]
	ld b, PLAY_AREA_ARENA
	farcall CountCardIDInTurnDuelistPlayArea
	cp 2
	jp c, .standard_score
	ld a, 40
	ret
.asm_29f4c
	ld e, [hl]
	inc hl
	ld d, [hl]
	ld b, PLAY_AREA_ARENA
	call FindCardIDInTurnDuelistsPlayArea
	jp nc, .standard_score
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	cp 1
	jp z, .standard_score
	ld a, 40
	ret

.PsychicEliteDeck:
	ld hl, wLoadedCard1ID
	cphl CHANSEY_LV55
	jr z, .chansey_lv55
	cphl MR_MIME_LV20
	jp nz, .standard_score

; mr. mime lv20
	; discourage if Defending card is not resistant to Psychic
	call SwapTurn
	bank1call GetArenaCardResistance
	call SwapTurn
	and WR_PSYCHIC
	jr z, .discourage_mr_mime_lv20_murray ; not resistant to Psychic

	; Defending card is resistant to Psychic,
	; give standard score if there's already
	; a Mr. Mime in the Bench
	ld de, MR_MIME_LV20
	ld b, PLAY_AREA_BENCH_1
	call FindCardIDInTurnDuelistsPlayArea
	jp c, .standard_score
	; otherwise discourage if Pkmn Powers are disabled
	bank1call CheckGoopGasAttackAndToxicGasActive
	jr c, .discourage_mr_mime_lv20_murray

.encourage_if_has_space_in_bench
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	ld hl, wMaxNumPlayAreaPokemon
	cp [hl]
	jr z, .discourage_mr_mime_lv20_murray ; has no space in Bench
	ld a, 200
	ret
.discourage_mr_mime_lv20_murray
	ld a, 100
	ret

.chansey_lv55
	; if no Alakazam lv42 in Play Area, give standard score
	farcall FindAlakazamLv42WithActivePkmnPowerInPlayArea
	jp nc, .standard_score
	; otherwise encourage if there are no targets
	; for Alakazam's lv42 Damage Swap
	farcall HandleAIDamageSwap.FindTargets
	jr c, .encourage_if_has_space_in_bench
	; if there are any targets, give standard score
	jp .standard_score

.RagingBillowOfFistsDeck:
	ld hl, wLoadedCard1ID
	cphl MR_MIME_LV20
	jp nz, .standard_score

; mr. mime lv20
	; discourage if already has Mr. Mime in Bench
	ld de, MR_MIME_LV20
	ld b, PLAY_AREA_BENCH_1
	call FindCardIDInTurnDuelistsPlayArea
	jp c, .discourage_mr_mime_lv20_mitch ; can be jr

	; discourage if has no space in Play Area
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	ld hl, wMaxNumPlayAreaPokemon
	cp [hl]
	jp z, .discourage_mr_mime_lv20_mitch ; can be jr

	; discourage if Pkmn Powers are disabled
	bank1call CheckGoopGasAttackAndToxicGasActive
	jp c, .discourage_mr_mime_lv20_mitch ; can be jr

	; encourage if Defending Pokémon is resistant
	; to the current Arena card
	farcall CheckIfDefendingCardIsResistantToArenaCard
	jr c, .encourage_mr_mime_lv20_mitch

	; encourage if current Arena card is weak
	; to the Defending Pokémon
	farcall CheckIfArenaCardIsWeakToDefendingCard
	jr c, .encourage_mr_mime_lv20_mitch
	; otherwise discourage playing Mr. Mime
.discourage_mr_mime_lv20_mitch
	ld a, 40
	ret
.encourage_mr_mime_lv20_mitch
	ld a, 200
	ret

.GoArcanineDeck:
	ld hl, wLoadedCard1ID
	cphl GROWLITHE_LV18
	jr z, .discourage_if_has_more_than_1_in_play
	cphl GROWLITHE_LV12
	jr z, .discourage_if_has_more_than_1_in_play
	cphl MAGMAR_LV31
	jr z, .discourage_if_has_more_than_1_in_play
	cphl SEEL_LV12
	jr z, .discourage_if_has_more_than_1_in_play
	cphl HITMONCHAN_LV33
	jr z, .hitmonchan_lv33
	cphl HITMONCHAN_LV23
	jr z, .discourage_if_has_more_than_1_in_play
	cphl DODUO_LV10
	jp nz, .standard_score

.discourage_if_has_more_than_1_in_play
	ld e, [hl]
	inc hl
	ld d, [hl]
	ld b, PLAY_AREA_ARENA
	farcall CountCardIDInTurnDuelistPlayArea
	cp 2
	jp c, .standard_score ; < 2 in Play Area
	ld a, 40
	ret

.hitmonchan_lv33
	; discourage if already has Hitmonchan lv33 in play
	; and it is not the only Pokémon in Play Area
	ld e, [hl]
	inc hl
	ld d, [hl]
	ld b, PLAY_AREA_ARENA
	call FindCardIDInTurnDuelistsPlayArea
	jp nc, .standard_score ; no Hitmonchan in play
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	cp 1
	jp z, .standard_score ; no other Pokémon in play
	ld a, 40
	ret

.SuddenGrowthDeck:
	ld hl, wLoadedCard1ID
	cphl ONIX_LV25
	jr z, .onix_lv25_or_hitmonchan_lv23
	cphl HITMONCHAN_LV23
	jp nz, .standard_score

.onix_lv25_or_hitmonchan_lv23
	; count number of Onix lv25 and Hitmonchan lv23
	; in play, and if less than 3, give standard score
	ld de, ONIX_LV25
	ld b, PLAY_AREA_ARENA
	farcall CountCardIDInTurnDuelistPlayArea
	push af
	ld de, HITMONCHAN_LV23
	ld b, PLAY_AREA_ARENA
	farcall CountCardIDInTurnDuelistPlayArea
	ld b, a
	pop af
	add b
	cp 3
	jp c, .standard_score ; < 3
	; if exactly 1 in play, give standard score
	; this is impossible since at this stage
	; at least 3 Onix and Hitmonchan are in play
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	cp 1
	jp z, .standard_score
	; discourage playing it
	ld a, 40
	ret

.ChokeDeck:
	ld hl, wLoadedCard1ID
	cphl KANGASKHAN_LV40
	jr z, .kangaskhan_lv40_or_dratini_lv10
	cphl DRATINI_LV10
	jr z, .kangaskhan_lv40_or_dratini_lv10
	cphl BULBASAUR_LV12
	jr z, .bulbasaur_lv12
	cphl MR_MIME_LV20
	jp nz, .standard_score

; mr. mime
	; encourage Mr. Mime lv20 if player
	; has a Fire Pokémon in play
	ld de, MR_MIME_LV20
	ld b, PLAY_AREA_BENCH_1
	call FindCardIDInTurnDuelistsPlayArea
	jr c, .discourage_unless_only_1_pkmn_in_play_choke_deck ; has Mr. Mime in Bench
	ld a, TYPE_PKMN_FIRE
	farcall CheckIfPlayerHasPokemonOfType
	jr nc, .discourage_unless_only_1_pkmn_in_play_choke_deck
	ld a, 200
	ret

.kangaskhan_lv40_or_dratini_lv10
	; discourage Kangaskhan and Dratini
	; if already has 1 in play and it's
	; not the only Pokémon
	ld e, [hl]
	inc hl
	ld d, [hl]
	ld b, PLAY_AREA_ARENA
	call FindCardIDInTurnDuelistsPlayArea
	jp nc, .standard_score

.discourage_unless_only_1_pkmn_in_play_choke_deck
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	cp 1
	jp z, .standard_score ; only 1 Pokémon in play
	ld a, 40
	ret

.bulbasaur_lv12
.charmander_lv9
.squirtle_lv8
.machop_lv20
	; encourage this Pokémon if has no other in play
	ld e, [hl]
	inc hl
	ld d, [hl]
	ld b, PLAY_AREA_ARENA
	call FindCardIDInTurnDuelistsPlayArea
	jr nc, .encourage_main_basic_pkmn_biruritchi
	jp .standard_score
.encourage_main_basic_pkmn_biruritchi
	ld a, 200
	ret

.IncinerateDeck:
	ld hl, wLoadedCard1ID
	cphl KANGASKHAN_LV40
	jr z, .kangaskhan_lv40_or_magmar_lv31
	cphl MAGMAR_LV31
	jr z, .kangaskhan_lv40_or_magmar_lv31
	cphl CLEFAIRY_LV15
	jr z, .clefairy_lv15_incinerate_deck
	cphl CHARMANDER_LV9
	jr z, .charmander_lv9
	cphl MR_MIME_LV20
	jp nz, .standard_score

; mr. mime
	ld de, MR_MIME_LV20
	ld b, PLAY_AREA_BENCH_1
	call FindCardIDInTurnDuelistsPlayArea
	jp c, .discourage_unless_only_1_pkmn_in_play_incinerate_deck
	ld a, TYPE_PKMN_WATER
	farcall CheckIfPlayerHasPokemonOfType
	jr nc, .discourage_unless_only_1_pkmn_in_play_incinerate_deck
	ld a, 200
	ret

.clefairy_lv15_incinerate_deck
	ld de, DARK_CHARIZARD
	farcall CheckCardIDInPlayAreaThatCanUseAttacks
	jp nc, .discourage_unless_only_1_pkmn_in_play_incinerate_deck
	jp .standard_score

.kangaskhan_lv40_or_magmar_lv31
	ld e, [hl]
	inc hl
	ld d, [hl]
	ld b, PLAY_AREA_ARENA
	call FindCardIDInTurnDuelistsPlayArea
	jp nc, .standard_score

.discourage_unless_only_1_pkmn_in_play_incinerate_deck
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	cp 1
	jp z, .standard_score
	ld a, 40
	ret

.SmashDeck:
	ld hl, wLoadedCard1ID
	cphl LAPRAS_LV31
	jr z, .lapras_lv31
	cphl CLEFAIRY_LV15
	jr z, .clefairy_lv15_smash_deck
	cphl SQUIRTLE_LV8
	jp z, .squirtle_lv8
	cphl MR_MIME_LV20
	jp nz, .standard_score

; mr. mime
	ld de, MR_MIME_LV20
	ld b, PLAY_AREA_BENCH_1
	call FindCardIDInTurnDuelistsPlayArea
	jp c, .discourage_unless_only_1_pkmn_in_play_smash_deck
	ld a, TYPE_PKMN_LIGHTNING
	farcall CheckIfPlayerHasPokemonOfType
	jr nc, .discourage_unless_only_1_pkmn_in_play_smash_deck
	ld a, 200
	ret

.clefairy_lv15_smash_deck
	ld de, DARK_BLASTOISE
	farcall CheckCardIDInPlayAreaThatCanUseAttacks
	jp nc, .discourage_unless_only_1_pkmn_in_play_smash_deck
	jp .standard_score

.lapras_lv31
	ld e, [hl]
	inc hl
	ld d, [hl]
	ld b, PLAY_AREA_ARENA
	call FindCardIDInTurnDuelistsPlayArea
	jp nc, .standard_score

.discourage_unless_only_1_pkmn_in_play_smash_deck
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	cp 1
	jp z, .standard_score
	ld a, 40
	ret

.ThrowOutDeck:
	ld hl, wLoadedCard1ID
	cphl KANGASKHAN_LV40
	jr z, .kangaskhan_lv40
	cphl CLEFAIRY_LV15
	jr z, .clefairy_lv15_throw_out_deck
	cphl MACHOP_LV20
	jp z, .machop_lv20
	cphl MR_MIME_LV20
	jp nz, .standard_score

; mr. mime
	ld de, MR_MIME_LV20
	ld b, PLAY_AREA_BENCH_1
	call FindCardIDInTurnDuelistsPlayArea
	jp c, .discourage_unless_only_1_pkmn_in_play_throw_out_deck
	ld a, TYPE_PKMN_FIGHTING
	farcall CheckIfPlayerHasPokemonOfType
	jr c, .encourage_mr_mime_lv20_throw_out_deck
	ld a, TYPE_PKMN_PSYCHIC
	farcall CheckIfPlayerHasPokemonOfType
	jr nc, .discourage_unless_only_1_pkmn_in_play_throw_out_deck

.encourage_mr_mime_lv20_throw_out_deck
	ld a, 200
	ret

.clefairy_lv15_throw_out_deck
	ld de, DARK_MACHAMP
	farcall CheckCardIDInPlayAreaThatCanUseAttacks
	jp nc, .discourage_unless_only_1_pkmn_in_play_throw_out_deck
	jp .standard_score

.kangaskhan_lv40
	ld e, [hl]
	inc hl
	ld d, [hl]
	ld b, PLAY_AREA_ARENA
	call FindCardIDInTurnDuelistsPlayArea
	jp nc, .standard_score

.discourage_unless_only_1_pkmn_in_play_throw_out_deck
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	cp 1
	jp z, .standard_score
	ld a, 40
	ret

.PowerfulPokemonDeck:
	farcall AIQueenHandleBasicPokemon
	ret

.BrickWalkDeck:
.ElectricSelfdestructDeck: ; no Wigglytuff
.EverybodysFriendDeck:
	ld de, WIGGLYTUFF_LV36
	ld b, PLAY_AREA_ARENA
	call FindCardIDInTurnDuelistsPlayArea
	jp nc, .standard_score
	ld a, 200
	ret

.ImmortalPokemonDeck:
	ld hl, wLoadedCard1ID
	cphl TENTACOOL
	jp nz, .standard_score
	ld de, TENTACOOL
	ld b, PLAY_AREA_BENCH_1
	call FindCardIDInTurnDuelistsPlayArea
	jp c, .standard_score
	ld a, 200
	ret

.TrainerImprisonDeck:
	ld hl, wLoadedCard1ID
	cphl ODDISH_LV21
	jr z, .oddish_lv21
	cphl MR_MIME_LV20
	jp nz, .standard_score

; mr. mime
	ld de, MR_MIME_LV20
	ld b, PLAY_AREA_BENCH_1
	call FindCardIDInTurnDuelistsPlayArea
	jp c, .discourage_unless_only_1_pkmn_in_play_toshiron
	ld a, TYPE_PKMN_FIRE
	farcall CheckIfPlayerHasPokemonOfType
	jr nc, .discourage_unless_only_1_pkmn_in_play_toshiron
	ld a, 200
	ret

.oddish_lv21
	ld e, [hl]
	inc hl
	ld d, [hl]
	ld b, PLAY_AREA_ARENA
	call FindCardIDInTurnDuelistsPlayArea
	jp nc, .standard_score

.discourage_unless_only_1_pkmn_in_play_toshiron
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	cp 1
	jp z, .standard_score
	ld a, 40
	ret

.BigThunderDeck:
	ld hl, wLoadedCard1ID
	cphl ZAPDOS_LV68
	jr z, .zapdos_lv68_dee

; chansey, ditto
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	cp 2
	jr nc, .discourage_dee
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call GetCardIDFromDeckIndex
	cp16 ZAPDOS_LV68
	jr nz, .encourage_dee
	jr .check_hp_dee

.zapdos_lv68_dee
	ld de, ZAPDOS_LV68
	ld b, PLAY_AREA_ARENA
	farcall CountCardIDInTurnDuelistPlayArea
	or a
	jr z, .encourage_dee
	cp 2
	jr z, .discourage_dee
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call GetCardIDFromDeckIndex
	cp16 ZAPDOS_LV68
	jr nz, .discourage_dee

.check_hp_dee
	ld a, DUELVARS_ARENA_CARD_HP
	get_turn_duelist_var
	cp 60
	jr nc, .discourage_dee

.encourage_dee
	ld a, 200
	ret

.discourage_dee
	ld a, 40
	ret
