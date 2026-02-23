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

.StandardScore:
	ld a, 128
	ret

.GreatDragonDeck:
	ld hl, wLoadedCard2ID
	cphl DRAGONAIR
	jp z, .dragonair_rod
	jr .StandardScore

; Magnemite: 128 + 10;
; Voltorb: dismiss if 5+ own Pokémon in play, 128 + 10 otherwise;
; Doduo: dismiss if 30+ HP, 128 + 10 otherwise;
; others (non-existent, fallback): 128
.ElectricSelfdestructDeck:
	ld hl, wLoadedCard2ID
	cphl MAGNEMITE_LV13
	jr z, .encourage_isaac
	cphl MAGNEMITE_LV15
	jr z, .encourage_isaac
	cphl VOLTORB_LV8
	jr z, .voltorb_isaac
	cphl DODUO_LV10
	jp nz, .StandardScore
; Doduo
	ldh a, [hTempPlayAreaLocation_ff9d]
	add DUELVARS_ARENA_CARD_HP
	get_turn_duelist_var
	cp 30
	jr c, .encourage_isaac
	jr .dismiss_isaac
.voltorb_isaac
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	cp 5
	jr c, .encourage_isaac
.dismiss_isaac
	xor a
	ret
.encourage_isaac
	ld a, 138
	ret

; Alakazam line: 128 + 10;
; others: 128
.PsychicEliteDeck:
	ld hl, wLoadedCard2ID
	cphl ABRA_LV14
	jr z, .encourage_murray
	cphl KADABRA_LV39
	jp nz, .StandardScore
.encourage_murray
	ld a, 138
	ret

; Drowzee: 128
; Slowpoke: 128 - 5 if any Clefairy Doll in discard pile, 128 otherwise;
.PuppetMasterDeck:
	ld hl, wLoadedCard2ID
	cphl SLOWPOKE_LV18
	jp nz, .StandardScore ; Drowzee
	ld de, CLEFAIRY_DOLL
	ld a, CARD_LOCATION_DISCARD_PILE
	call FindCardIDInLocation
	jp nc, .StandardScore
	ld a, 123
	ret

; Exeggcute: 128 + 5;
; others: 128
.MaxEnergyDeck:
	ld hl, wLoadedCard2ID
	cphl EXEGGCUTE
	jp nz, .StandardScore
	ld a, 133
	ret

; active: 128
; benched: 128 + 10
.GatheringNidoranDeck:
	ldh a, [hTempPlayAreaLocation_ff9d]
	or a
	jp z, .StandardScore
	ld a, 138
	ret

; 138
.RainDanceConfusionDeck:
.QuickAttackDeck:
.RockBlastDeck:
.RunningWildDeck:
.EverybodysFriendDeck:
	ld a, 138
	ret

; Growlithe: 128
; others:
;   expectation: 128 - 28 if already evolved, 128 + 10 otherwise;
;   reality: 128
.GoArcanineDeck:
	ld hl, wLoadedCard2ID
	cphl DEWGONG_LV42
	jr z, .dewgong_dodrio_ken
	cphl DODRIO_LV28
	jp nz, .StandardScore
.dewgong_dodrio_ken
	ld e, [hl]
	inc hl
	ld d, [hl]
	ld b, PLAY_AREA_ARENA
	call FindCardIDInTurnDuelistsPlayArea
	jp nc, .encourage_ken
	ld a, 100
	ret
.encourage_ken
	ld a, 138
	ret

; Drowzee: 128 if active, 118 if benched
; others: 128
.GreatRocket4Deck:
	ld hl, wLoadedCard2ID
	cphl DROWZEE_LV10
	jp nz, .StandardScore
	ldh a, [hTempPlayAreaLocation_ff9d]
	or a
	jp z, .StandardScore
	ld a, 118
	ret

; Fossil: 128 + 10
; Voltorb: 128
.LegendaryFossilDeck:
	ld hl, wLoadedCard2ID
	cphl MYSTERIOUS_FOSSIL
	jp nz, .StandardScore
	ld a, 138
	ret

; Dark Dragonair:
;   128 + 10 if
;     active with 4+ Energy attached to it, or
;     3- own Pokémon in play with no basic cards in hand;
;   128 - 10 otherwise;
; others: 128
.DangerousBenchDeck:
	ld hl, wLoadedCard2ID
	cphl DARK_DRAGONAIR
	jp nz, .StandardScore
	ldh a, [hTempPlayAreaLocation_ff9d]
	or a
	jr nz, .tally_tap
	ld e, a
	call GetPlayAreaCardAttachedEnergies
	ld a, [wTotalAttachedEnergies]
	cp 4
	jr nc, .encourage_tap
.tally_tap
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	cp 3
	jr nc, .discourage_tap
	farcall CountNumberOfBasicPokemonInHand
	or a
	jr nz, .discourage_tap
.encourage_tap
	ld a, 138
	ret
.discourage_tap
	ld a, 118
	ret

; Gastly: 128 + 10;
; Haunter Lv.17: 128;
; Haunter Lv.22: 128 - 10;
; Drowzee:
;   128 + 10 if any other Drowzee is in play, or Bench is full;
;   128 - 10 otherwise
.BadDreamDeck:
	ld hl, wLoadedCard2ID
	cphl GASTLY_LV13
	jr z, .encourage_yosuke
	cphl HAUNTER_LV22
	jr z, .discourage_yosuke
	cphl DROWZEE_LV10
	jp nz, .StandardScore
	ld de, DROWZEE_LV10
	ld b, PLAY_AREA_ARENA
	farcall CountCardIDInTurnDuelistPlayArea
	cp 2
	jr c, .discourage_yosuke
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	call GetNonTurnDuelistVariable
	cp 6
	jr nz, .discourage_yosuke
.encourage_yosuke
	ld a, 138
	ret
.discourage_yosuke
	ld a, 118
	ret

; Meowth: 128 - 10 if 7+ cards in hand, 128 + 10 otherwise;
; others: 128
.PokemonPowerDeck:
	ld hl, wLoadedCard2ID
	cphl MEOWTH_LV14
	jp nz, .StandardScore
	ld a, DUELVARS_NUMBER_OF_CARDS_IN_HAND
	get_turn_duelist_var
	cp 7
	jr c, .discourage_ryoko
	ld a, 138
	ret
.discourage_ryoko
	ld a, 118
	ret

; Dratini: 128 + 2;
; Clefairy: 128 + 10;
; Dark Dragonair: 128 + 10 if 2+ Dark Clefable in play, 128 - 10 otherwise
.SuddenGrowthDeck:
	ld hl, wLoadedCard2ID
	cphl DRATINI_LV12
	jr z, .mid_samejima_score
	cphl CLEFAIRY_LV15
	jr z, .higher_samejima_score
	cphl DARK_DRAGONAIR
	jp nz, .StandardScore
	ld de, DARK_CLEFABLE
	ld b, PLAY_AREA_ARENA
	farcall CountCardIDInTurnDuelistPlayArea
	cp 2
	jr c, .lower_samejima_score
.higher_samejima_score
	ld a, 138
	ret
.lower_samejima_score
	ld a, 118
	ret
.mid_samejima_score
	ld a, 130
	ret

; Oddish: 128 - 28 if any Dark Gloom already, 128 otherwise;
; Slowpoke:
;   128 + 12 if none other than Slowpoke is in play;
;   else, for n = number of Dark Slowbro in play,
;     n = 0: 128 + 12 if 2+ Psychic Energy attached to it;
;     n = 1: 128 + 12 if towards using Reel In;
;   128 - 28 otherwise
; others: 128
.BadGuysDeck:
	ld hl, wLoadedCard2ID
	cphl ODDISH_LV21
	jr z, .oddish_kanzaki
	cphl SLOWPOKE_LV16
	jr z, .slowpoke_kanzaki
	jp .StandardScore

.oddish_kanzaki
	ld de, DARK_GLOOM
	ld b, PLAY_AREA_BENCH_1
	call FindCardIDInTurnDuelistsPlayArea
	jp nc, .StandardScore

.discourage_kanzaki
	ld a, 100
	ret

.encourage_kanzaki
	ld a, 140
	ret

.slowpoke_kanzaki
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
	jr nc, .encourage_kanzaki
	jr .check_non_slowpoke
.has_dark_slowbro
	cp 1
	jr nz, .check_non_slowpoke
	farcall BadGuysDeckAIDecideReelIn
	jr c, .encourage_kanzaki
.check_non_slowpoke
	ld de, SLOWPOKE_LV16
	ld b, PLAY_AREA_ARENA
	farcall CountCardIDInTurnDuelistPlayArea
	ld b, a
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	cp b
	jr z, .encourage_kanzaki
	jr .discourage_kanzaki

; Dratini:
;   128 - 28 if any Dark Dragonair in play;
;   128 + 12 if benched and no Dark Dragonair yet;
;   128 if active and no Dark Dragonair yet;
; others: 128
.ChokeDeck:
	ld hl, wLoadedCard2ID
	cphl DRATINI_LV10
	jp nz, .StandardScore
	ld de, DARK_DRAGONAIR
	ld b, PLAY_AREA_ARENA
	call FindCardIDInTurnDuelistsPlayArea
	jr c, .discourage_biruritchi_grass
	ldh a, [hTempPlayAreaLocation_ff9d]
	or a
	jp z, .StandardScore
	ld a, 140
	ret
.discourage_biruritchi_grass
	ld a, 100
	ret

; Clefairy:
;   128 - 28 if Dark Charizard isn't ready or any Dark Clefable is in play;
;   128 otherwise
; others: 128
.IncinerateDeck:
	ld hl, wLoadedCard2ID
	cphl CLEFAIRY_LV15
	jp nz, .StandardScore
	ld de, DARK_CHARIZARD
	farcall CheckCardIDInPlayAreaThatCanUseAttacks
	jp nc, .discourage_biruritchi_fire
	ld de, DARK_CLEFABLE
	ld b, PLAY_AREA_ARENA
	call FindCardIDInTurnDuelistsPlayArea
	jp nc, .StandardScore
.discourage_biruritchi_fire
	ld a, 100
	ret

; Clefairy:
;   128 - 28 if Dark Blastoise isn't ready or any Dark Clefable is in play;
;   128 otherwise
; others: 128
.SmashDeck:
	ld hl, wLoadedCard2ID
	cphl CLEFAIRY_LV15
	jp nz, .StandardScore
	ld de, DARK_BLASTOISE
	farcall CheckCardIDInPlayAreaThatCanUseAttacks
	jp nc, .discourage_biruritchi_water
	ld de, DARK_CLEFABLE
	ld b, PLAY_AREA_ARENA
	call FindCardIDInTurnDuelistsPlayArea
	jp nc, .StandardScore
.discourage_biruritchi_water
	ld a, 100
	ret

; Clefairy:
;   128 - 28 if Dark Machamp isn't ready or any Dark Clefable is in play;
;   128 otherwise
; others: 128
.ThrowOutDeck:
	ld hl, wLoadedCard2ID
	cphl CLEFAIRY_LV15
	jp nz, .StandardScore
	ld de, DARK_MACHAMP
	farcall CheckCardIDInPlayAreaThatCanUseAttacks
	jp nc, .discourage_biruritchi_fighting
	ld de, DARK_CLEFABLE
	ld b, PLAY_AREA_ARENA
	call FindCardIDInTurnDuelistsPlayArea
	jp nc, .StandardScore
.discourage_biruritchi_fighting
	ld a, 100
	ret

; Gastly: 128
; Haunter: 128 - 28 if any Gengar in play, 128 otherwise;
; Dratini: 128 + 12;
; Dark Dragonair:
;   128 - 28 if any Dark Dragonite or 5+ Pokémon in play,
;   128 otherwise
.RonaldsPsychicDeck:
	ld hl, wLoadedCard2ID
	cphl HAUNTER_LV26
	jr z, .haunter_ronald
	cphl DARK_DRAGONAIR
	jr z, .dark_dragonair_ronald
	cphl DRATINI_LV10
	jr z, .encourage_ronald
	jp .StandardScore

.haunter_ronald
	ld de, GENGAR_LV40
	ld b, PLAY_AREA_ARENA
	call FindCardIDInTurnDuelistsPlayArea
	jp nc, .StandardScore

.discourage_ronald
	ld a, 100
	ret

.encourage_ronald
	ld a, 140
	ret

.dark_dragonair_ronald
	ld de, DARK_DRAGONITE
	ld b, PLAY_AREA_ARENA
	call FindCardIDInTurnDuelistsPlayArea
	jr c, .discourage_ronald
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	cp 5
	jr nc, .discourage_ronald
	jp .StandardScore

; Abra: 128 + 12;
; Kadabra: 128 - 28 if any Alakazam in play, 128 + 12 otherwise;
; others (non-existent): 128
.ImmortalPokemonDeck:
	ld hl, wLoadedCard2ID
	cphl ABRA_LV14
	jr z, .encourage_magician
	cphl KADABRA_LV39
	jp nz, .StandardScore
	ld de, ALAKAZAM_LV42
	ld b, PLAY_AREA_ARENA
	call FindCardIDInTurnDuelistsPlayArea
	jr c, .discourage_magician
.encourage_magician
	ld a, 140
	ret
.discourage_magician
	ld a, 100
	ret

; Squirtle:
;   128 + 12 if no Pokémon Breeder or Blastoise in hand,
;   128 - 28 otherwise
; Wartortle:
;   128 + 12 if no Pokémon Breeder in hand,
;   128 - 28 if evolving Squirtle with Pokémon Breeder;
; others (non-existent): 128
.TorrentialFloodDeck:
	ld hl, wLoadedCard2ID
	cphl SQUIRTLE_LV14
	jr z, .check_breeder_evo
	cphl WARTORTLE_LV24
	jp nz, .StandardScore
	ld de, POKEMON_BREEDER
	call LookForCardIDInHandList
	jr nc, .encourage_yui
	ld de, SQUIRTLE_LV14
	ld b, PLAY_AREA_ARENA
	call FindCardIDInTurnDuelistsPlayArea
	jr c, .discourage_yui
.encourage_yui
	ld a, 140
	ret
.check_breeder_evo
	ld de, POKEMON_BREEDER
	call LookForCardIDInHandList
	jr nc, .encourage_yui
	ld de, BLASTOISE_LV52
	call LookForCardIDInHandList
	jr nc, .encourage_yui
.discourage_yui
	ld a, 100
	ret

; Oddish and Dark Gloom:
;   128 - 28 if any other already evolved,
;   128 + 12 otherwise;
; others: 128
.TrainerImprisonDeck:
	ld hl, wLoadedCard2ID
	cphl ODDISH_LV21
	jr z, .oddish_toshiron
	cphl DARK_GLOOM
	jp nz, .StandardScore
	ld de, DARK_VILEPLUME
	ld b, PLAY_AREA_ARENA
	call FindCardIDInTurnDuelistsPlayArea
	jr c, .discourage_toshiron
.encourage_toshiron
	ld a, 140
	ret
.oddish_toshiron
	ld de, DARK_GLOOM
	ld b, PLAY_AREA_ARENA
	call FindCardIDInTurnDuelistsPlayArea
	jr nc, .encourage_toshiron
.discourage_toshiron
	ld a, 100
	ret

; unchanged since TCG1
; 128 + 10 if
;   Muk isn't in play, and
;   Dragonair is
;     Active with 50+ damage taken and 3+ Energy attached to it, or
;     Benched, and total of 70+ damage on own Pokémon in play;
; 128 - 10 otherwise
.dragonair_rod:
	ldh a, [hTempPlayAreaLocation_ff9d]
	or a
	jr z, .dragonair_rod_active

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
	jr c, .dragonair_rod_check_muk

.lower_dragonair_score
	ld a, 118
	ret

; should now use the lock-check function instead of this TCG1 code
.dragonair_rod_check_muk
	ld de, MUK
	bank1call CountPokemonWithActivePkmnPowerInBothPlayAreas
	jr c, .lower_dragonair_score
	ld a, 138
	ret

.dragonair_rod_active
	ld e, PLAY_AREA_ARENA
	call GetCardDamageAndMaxHP
	cp 50
	jr c, .lower_dragonair_score
	ld e, PLAY_AREA_ARENA
	call GetPlayAreaCardAttachedEnergies
	ld a, [wTotalAttachedEnergies]
	cp 3
	jr c, .lower_dragonair_score
	jr .dragonair_rod_check_muk
