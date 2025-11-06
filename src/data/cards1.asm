BulbasaurLv12Card:
	db TYPE_PKMN_GRASS ; type
	dw $c430 ; gfx
	tx BulbasaurName ; name
	db CIRCLE ; rarity
	db BULBASAUR_DECK ; real set
	db BEGINNING_POKEMON ; in-game set
	dw BULBASAUR_LV12
	db 40 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy COLORLESS, 1 ; energies
	tx TackleName ; name
	dw NONE ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_NORMAL ; category
	dw NONE ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_HIT ; animation

	; attack 2
	energy GRASS, 2 ; energies
	tx RazorLeafName ; name
	dw NONE ; description
	dw NONE ; description (cont)
	db 30 ; damage
	db DAMAGE_NORMAL ; category
	dw NONE ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_RAZOR_LEAF ; animation

	db 1 ; retreat cost
	db WR_FIRE ; weakness
	db NONE ; resistance
	tx SeedName ; category
	db DEX_BULBASAUR ; Pokedex number
	db FALSE ; is Dark
	db 12 ; level
	length 0.7 ; length
	weight 6.9 ; weight
	tx BulbasaurLv12Description ; description
	db NONE | HAS_EVOLUTION ; AI info

BulbasaurLv13Card:
	db TYPE_PKMN_GRASS ; type
	dw $538 ; gfx
	tx BulbasaurName ; name
	db CIRCLE ; rarity
	db BASE_SET ; real set
	db TEAM_ROCKETS_AMBITION ; in-game set
	dw BULBASAUR_LV13
	db 40 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy GRASS, 2 ; energies
	tx LeechSeedName ; name
	tx LeechSeedDescription ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_NORMAL ; category
	dw BulbasaurLv13LeechSeedEffectCommands ; effect commands
	db NONE ; flags 1
	db HEAL_USER  ; flags 2
	db NONE ; flags 3
	db 1 ; ?
	db ATK_ANIM_DRAIN ; animation

	; attack 2
	energy 0 ; energies
	dw NONE ; name
	dw NONE ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db DAMAGE_NORMAL ; category
	dw NONE ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_NONE ; animation

	db 1 ; retreat cost
	db WR_FIRE ; weakness
	db NONE ; resistance
	tx SeedName ; category
	db DEX_BULBASAUR ; Pokedex number
	db FALSE ; is Dark
	db 13 ; level
	length 0.7 ; length
	weight 6.9 ; weight
	tx BulbasaurLv13Description ; description
	db NONE | HAS_EVOLUTION ; AI info

BulbasaurLv15Card:
	db TYPE_PKMN_GRASS ; type
	dw $713b ; gfx
	tx BulbasaurName ; name
	db DIAMOND ; rarity
	db EXPANSION_SHEET ; real set
	db SKY_FLYING_POKEMON ; in-game set
	dw BULBASAUR_LV15
	db 50 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy COLORLESS, 1 ; energies
	tx FirstAidName ; name
	tx FirstAidDescription ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db RESIDUAL ; category
	dw BulbasaurLv15FirstAidEffectCommands ; effect commands
	db NONE ; flags 1
	db HEAL_USER  ; flags 2
	db FLAG_3_BIT_2  ; flags 3
	db 1 ; ?
	db ATK_ANIM_RECOVER ; animation

	; attack 2
	energy GRASS, 1 ; energies
	tx PoisonSeedName ; name
	tx InflictPoisonDescription ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db DAMAGE_NORMAL ; category
	dw BulbasaurLv15PoisonSeedEffectCommands ; effect commands
	db INFLICT_POISON  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_POISON_SEED ; animation

	db 1 ; retreat cost
	db WR_FIRE ; weakness
	db NONE ; resistance
	tx SeedName ; category
	db DEX_BULBASAUR ; Pokedex number
	db FALSE ; is Dark
	db 15 ; level
	length 0.7 ; length
	weight 6.9 ; weight
	tx BulbasaurLv15Description ; description
	db NONE | HAS_EVOLUTION ; AI info

IvysaurLv20Card:
	db TYPE_PKMN_GRASS ; type
	dw $5a1 ; gfx
	tx IvysaurName ; name
	db DIAMOND ; rarity
	db BASE_SET ; real set
	db PSYCHIC_BATTLE ; in-game set
	dw IVYSAUR_LV20
	db 60 ; hp
	db STAGE1 ; stage
	tx BulbasaurName ; pre-evo name

	; attack 1
	energy GRASS, 1, COLORLESS, 2 ; energies
	tx VineWhipName ; name
	dw NONE ; description
	dw NONE ; description (cont)
	db 30 ; damage
	db DAMAGE_NORMAL ; category
	dw NONE ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_WHIP ; animation

	; attack 2
	energy GRASS, 3 ; energies
	tx PoisonPowderName ; name
	tx InflictPoisonDescription ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_NORMAL ; category
	dw IvysaurLv20PoisonPowderEffectCommands ; effect commands
	db INFLICT_POISON  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_POWDER_HIT_POISON ; animation

	db 1 ; retreat cost
	db WR_FIRE ; weakness
	db NONE ; resistance
	tx SeedName ; category
	db DEX_IVYSAUR ; Pokedex number
	db FALSE ; is Dark
	db 20 ; level
	length 1.0 ; length
	weight 13.0 ; weight
	tx IvysaurLv20Description ; description
	db NONE | HAS_EVOLUTION ; AI info

IvysaurLv26Card:
	db TYPE_PKMN_GRASS ; type
	dw $c000 ; gfx
	tx IvysaurName ; name
	db DIAMOND ; rarity
	db BULBASAUR_DECK ; real set
	db BEGINNING_POKEMON ; in-game set
	dw IVYSAUR_LV26
	db 70 ; hp
	db STAGE1 ; stage
	tx BulbasaurName ; pre-evo name

	; attack 1
	energy GRASS, 2 ; energies
	tx LeechSeedAltName ; name
	tx IvysaursLeechSeedDescription ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_NORMAL ; category
	dw IvysaurLv26LeechSeedAltEffectCommands ; effect commands
	db NONE ; flags 1
	db HEAL_USER  ; flags 2
	db NONE ; flags 3
	db 1 ; ?
	db ATK_ANIM_DRAIN ; animation

	; attack 2
	energy GRASS, 2, COLORLESS, 1 ; energies
	tx VineWhipAltName ; name
	dw NONE ; description
	dw NONE ; description (cont)
	db 40 ; damage
	db DAMAGE_NORMAL ; category
	dw NONE ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_WHIP ; animation

	db 2 ; retreat cost
	db WR_FIRE ; weakness
	db NONE ; resistance
	tx SeedName ; category
	db DEX_IVYSAUR ; Pokedex number
	db FALSE ; is Dark
	db 26 ; level
	length 1.0 ; length
	weight 13.0 ; weight
	tx IvysaurLv26Description ; description
	db NONE | HAS_EVOLUTION ; AI info

DarkIvysaurCard:
	db TYPE_PKMN_GRASS ; type
	dw $c5d7 ; gfx
	tx DarkIvysaurName ; name
	db DIAMOND ; rarity
	db GB ; real set
	db TEAM_ROCKETS_AMBITION ; in-game set
	dw DARK_IVYSAUR
	db 50 ; hp
	db STAGE1 ; stage
	tx BulbasaurName ; pre-evo name

	; attack 1
	energy 0 ; energies
	tx VinePullName ; name
	tx VinePullDescription ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db POKEMON_POWER ; category
	dw DarkIvysaurVinePullEffectCommands ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_VINE_PULL ; animation

	; attack 2
	energy GRASS, 2 ; energies
	tx FuryStrikesName ; name
	tx FuryStrikesDescription ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db RESIDUAL ; category
	dw DarkIvysaurFuryStrikesEffectCommands ; effect commands
	db DAMAGE_TO_OPPONENT_BENCH  ; flags 1
	db FLAG_2_BIT_6  ; flags 2
	db FLAG_3_BIT_2  ; flags 3
	db 3 ; ?
	db ATK_ANIM_FURY_STRIKES ; animation

	db 2 ; retreat cost
	db WR_FIRE ; weakness
	db NONE ; resistance
	tx SeedName ; category
	db DEX_IVYSAUR ; Pokedex number
	db TRUE ; is Dark
	db 16 ; level
	length 1.0 ; length
	weight 13.0 ; weight
	tx DarkIvysaurDescription ; description
	db NONE | HAS_EVOLUTION ; AI info

VenusaurLv64Card:
	db TYPE_PKMN_GRASS ; type
	dw $618 ; gfx
	tx VenusaurName ; name
	db STAR ; rarity
	db GB ; real set
	db PROMOTIONAL ; in-game set
	dw VENUSAUR_LV64
	db 100 ; hp
	db STAGE2 ; stage
	tx IvysaurName ; pre-evo name

	; attack 1
	energy 0 ; energies
	tx SolarPowerName ; name
	tx SolarPowerDescription ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db POKEMON_POWER ; category
	dw VenusaurLv64SolarPowerEffectCommands ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_SOLAR_POWER ; animation

	; attack 2
	energy GRASS, 4 ; energies
	tx MegaDrainName ; name
	tx MegaDrainDescription ; description
	dw NONE ; description (cont)
	db 40 ; damage
	db DAMAGE_NORMAL ; category
	dw VenusaurLv64MegaDrainEffectCommands ; effect commands
	db NONE ; flags 1
	db HEAL_USER  ; flags 2
	db NONE ; flags 3
	db 2 ; ?
	db ATK_ANIM_DRAIN ; animation

	db 2 ; retreat cost
	db WR_FIRE ; weakness
	db NONE ; resistance
	tx SeedName ; category
	db DEX_VENUSAUR ; Pokedex number
	db FALSE ; is Dark
	db 64 ; level
	length 2.0 ; length
	weight 100.0 ; weight
	tx VenusaurLv64Description ; description
	db NONE ; AI info

VenusaurLv67Card:
	db TYPE_PKMN_GRASS ; type
	dw $6b3 ; gfx
	tx VenusaurName ; name
	db STAR ; rarity
	db BASE_SET ; real set
	db LEGENDARY_POWER ; in-game set
	dw VENUSAUR_LV67
	db 100 ; hp
	db STAGE2 ; stage
	tx IvysaurName ; pre-evo name

	; attack 1
	energy 0 ; energies
	tx EnergyTransName ; name
	tx EnergyTransDescription ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db POKEMON_POWER ; category
	dw VenusaurLv67EnergyTransEffectCommands ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_PKMN_POWER_1 ; animation

	; attack 2
	energy GRASS, 4 ; energies
	tx SolarbeamName ; name
	dw NONE ; description
	dw NONE ; description (cont)
	db 60 ; damage
	db DAMAGE_NORMAL ; category
	dw NONE ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_BEAM ; animation

	db 2 ; retreat cost
	db WR_FIRE ; weakness
	db NONE ; resistance
	tx SeedName ; category
	db DEX_VENUSAUR ; Pokedex number
	db FALSE ; is Dark
	db 67 ; level
	length 2.0 ; length
	weight 100.0 ; weight
	tx VenusaurLv67Description ; description
	db NONE ; AI info

VenusaurAltLv67Card:
	db TYPE_PKMN_GRASS ; type
	dw $a3f7 ; gfx
	tx VenusaurName ; name
	db STAR ; rarity
	db PRO ; real set
	db PROMOTIONAL ; in-game set
	dw VENUSAUR_ALT_LV67
	db 100 ; hp
	db STAGE2 ; stage
	tx IvysaurName ; pre-evo name

	; attack 1
	energy 0 ; energies
	tx EnergyTransName ; name
	tx EnergyTransDescription ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db POKEMON_POWER ; category
	dw VenusaurAltLv67EnergyTransEffectCommands ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_PKMN_POWER_1 ; animation

	; attack 2
	energy GRASS, 4 ; energies
	tx SolarbeamName ; name
	dw NONE ; description
	dw NONE ; description (cont)
	db 60 ; damage
	db DAMAGE_NORMAL ; category
	dw NONE ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_BEAM ; animation

	db 2 ; retreat cost
	db WR_FIRE ; weakness
	db NONE ; resistance
	tx SeedName ; category
	db DEX_VENUSAUR ; Pokedex number
	db FALSE ; is Dark
	db 67 ; level
	length 2.0 ; length
	weight 100.0 ; weight
	tx VenusaurLv67Description ; description
	db NONE ; AI info

DarkVenusaurCard:
	db TYPE_PKMN_GRASS ; type
	dw $c6bb ; gfx
	tx DarkVenusaurName ; name
	db STAR ; rarity
	db GB ; real set
	db TEAM_ROCKETS_AMBITION ; in-game set
	dw DARK_VENUSAUR
	db 70 ; hp
	db STAGE2 ; stage
	tx DarkIvysaurName ; pre-evo name

	; attack 1
	energy GRASS, 3 ; energies
	tx HorridPollenName ; name
	tx HorridPollenDescription ; description
	dw NONE ; description (cont)
	db 30 ; damage
	db DAMAGE_NORMAL ; category
	dw DarkVenusaurHorridPollenEffectCommands ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_POWDER_EFFECT_CHANCE ; animation

	; attack 2
	energy 0 ; energies
	dw NONE ; name
	dw NONE ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db DAMAGE_NORMAL ; category
	dw NONE ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_NONE ; animation

	db 2 ; retreat cost
	db WR_FIRE ; weakness
	db NONE ; resistance
	tx SeedName ; category
	db DEX_VENUSAUR ; Pokedex number
	db TRUE ; is Dark
	db 37 ; level
	length 2.0 ; length
	weight 100.0 ; weight
	tx DarkVenusaurDescription ; description
	db NONE ; AI info

CaterpieCard:
	db TYPE_PKMN_GRASS ; type
	dw $71c ; gfx
	tx CaterpieName ; name
	db CIRCLE ; rarity
	db BASE_SET ; real set
	db LEGENDARY_POWER ; in-game set
	dw CATERPIE
	db 40 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy GRASS, 1 ; energies
	tx StringShotName ; name
	tx MayInflictParalysisDescription ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_NORMAL ; category
	dw CaterpieStringShotEffectCommands ; effect commands
	db INFLICT_PARALYSIS  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_STRING_SHOT ; animation

	; attack 2
	energy 0 ; energies
	dw NONE ; name
	dw NONE ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db DAMAGE_NORMAL ; category
	dw NONE ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_NONE ; animation

	db 1 ; retreat cost
	db WR_FIRE ; weakness
	db NONE ; resistance
	tx WormName ; category
	db DEX_CATERPIE ; Pokedex number
	db FALSE ; is Dark
	db 13 ; level
	length 0.3 ; length
	weight 2.9 ; weight
	tx CaterpieDescription ; description
	db AI_INFO_UNK_03 | HAS_EVOLUTION ; AI info

MetapodLv20Card:
	db TYPE_PKMN_GRASS ; type
	dw $7278 ; gfx
	tx MetapodName ; name
	db DIAMOND ; rarity
	db EXPANSION_SHEET ; real set
	db PSYCHIC_BATTLE ; in-game set
	dw METAPOD_LV20
	db 70 ; hp
	db STAGE1 ; stage
	tx CaterpieName ; pre-evo name

	; attack 1
	energy 0 ; energies
	tx GreenShieldName ; name
	tx GreenShieldDescription ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db POKEMON_POWER ; category
	dw MetapodLv20GreenShieldEffectCommands ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_NONE ; animation

	; attack 2
	energy GRASS, 2 ; energies
	tx MysteriousPowerName ; name
	tx MayInflictConfusionDescription ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_NORMAL ; category
	dw MetapodLv20MysteriousPowerEffectCommands ; effect commands
	db INFLICT_CONFUSION  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_POWDER_EFFECT_CHANCE ; animation

	db 2 ; retreat cost
	db WR_FIRE ; weakness
	db NONE ; resistance
	tx CocoonName ; category
	db DEX_METAPOD ; Pokedex number
	db FALSE ; is Dark
	db 20 ; level
	length 0.7 ; length
	weight 9.9 ; weight
	tx MetapodLv20Description ; description
	db NONE | HAS_EVOLUTION ; AI info

MetapodLv21Card:
	db TYPE_PKMN_GRASS ; type
	dw $785 ; gfx
	tx MetapodName ; name
	db DIAMOND ; rarity
	db BASE_SET ; real set
	db LEGENDARY_POWER ; in-game set
	dw METAPOD_LV21
	db 70 ; hp
	db STAGE1 ; stage
	tx CaterpieName ; pre-evo name

	; attack 1
	energy COLORLESS, 2 ; energies
	tx StiffenName ; name
	tx PreventDamageCardEffectDescription ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db RESIDUAL ; category
	dw MetapodLv21StiffenEffectCommands ; effect commands
	db NONE ; flags 1
	db NULLIFY_OR_WEAKEN_ATTACK  ; flags 2
	db FLAG_3_BIT_2  ; flags 3
	db 0 ; ?
	db ATK_ANIM_NONE ; animation

	; attack 2
	energy GRASS, 2 ; energies
	tx StunSporeName ; name
	tx MayInflictParalysisDescription ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_NORMAL ; category
	dw MetapodLv21StunSporeEffectCommands ; effect commands
	db INFLICT_PARALYSIS  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_POWDER_EFFECT_CHANCE ; animation

	db 2 ; retreat cost
	db WR_FIRE ; weakness
	db NONE ; resistance
	tx CocoonName ; category
	db DEX_METAPOD ; Pokedex number
	db FALSE ; is Dark
	db 21 ; level
	length 0.7 ; length
	weight 9.9 ; weight
	tx MetapodLv21Description ; description
	db NONE | HAS_EVOLUTION ; AI info

ButterfreeCard:
	db TYPE_PKMN_GRASS ; type
	dw $800 ; gfx
	tx ButterfreeName ; name
	db DIAMOND ; rarity
	db JUNGLE ; real set
	db LEGENDARY_POWER ; in-game set
	dw BUTTERFREE
	db 70 ; hp
	db STAGE2 ; stage
	tx MetapodName ; pre-evo name

	; attack 1
	energy COLORLESS, 2 ; energies
	tx WhirlwindName ; name
	tx WhirlwindDescription ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_NORMAL ; category
	dw ButterfreeWhirlwindEffectCommands ; effect commands
	db NONE ; flags 1
	db SWITCH_OPPONENT_POKEMON  ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_WHIRLWIND ; animation

	; attack 2
	energy GRASS, 4 ; energies
	tx MegaDrainName ; name
	tx MegaDrainDescription ; description
	dw NONE ; description (cont)
	db 40 ; damage
	db DAMAGE_NORMAL ; category
	dw ButterfreeMegaDrainEffectCommands ; effect commands
	db NONE ; flags 1
	db HEAL_USER  ; flags 2
	db NONE ; flags 3
	db 2 ; ?
	db ATK_ANIM_DRAIN ; animation

	db 0 ; retreat cost
	db WR_FIRE ; weakness
	db WR_FIGHTING ; resistance
	tx ButterflyName ; category
	db DEX_BUTTERFREE ; Pokedex number
	db FALSE ; is Dark
	db 28 ; level
	length 1.1 ; length
	weight 32.0 ; weight
	tx ButterfreeDescription ; description
	db NONE ; AI info

WeedleLv12Card:
	db TYPE_PKMN_GRASS ; type
	dw $8a5 ; gfx
	tx WeedleName ; name
	db CIRCLE ; rarity
	db BASE_SET ; real set
	db BEGINNING_POKEMON ; in-game set
	dw WEEDLE_LV12
	db 40 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy GRASS, 1 ; energies
	tx PoisonStingName ; name
	tx MayInflictPoisonDescription ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_NORMAL ; category
	dw WeedleLv12PoisonStingEffectCommands ; effect commands
	db INFLICT_POISON  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_NEEDLES ; animation

	; attack 2
	energy 0 ; energies
	dw NONE ; name
	dw NONE ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db DAMAGE_NORMAL ; category
	dw NONE ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_NONE ; animation

	db 1 ; retreat cost
	db WR_FIRE ; weakness
	db NONE ; resistance
	tx HairyBugName ; category
	db DEX_WEEDLE ; Pokedex number
	db FALSE ; is Dark
	db 12 ; level
	length 0.3 ; length
	weight 3.2 ; weight
	tx WeedleLv12Description ; description
	db AI_INFO_UNK_03 | HAS_EVOLUTION ; AI info

WeedleLv15Card:
	db TYPE_PKMN_GRASS ; type
	dw $730b ; gfx
	tx WeedleName ; name
	db CIRCLE ; rarity
	db EXPANSION_SHEET ; real set
	db PSYCHIC_BATTLE ; in-game set
	dw WEEDLE_LV15
	db 50 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy COLORLESS, 1 ; energies
	tx PeckName ; name
	dw NONE ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_NORMAL ; category
	dw NONE ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_HIT ; animation

	; attack 2
	energy GRASS, 1 ; energies
	tx PoisonHornName ; name
	tx InflictPoisonDescription ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db DAMAGE_NORMAL ; category
	dw WeedleLv15PoisonHornEffectCommands ; effect commands
	db INFLICT_POISON  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_POISON_SEED ; animation

	db 1 ; retreat cost
	db WR_FIRE ; weakness
	db NONE ; resistance
	tx HairyBugName ; category
	db DEX_WEEDLE ; Pokedex number
	db FALSE ; is Dark
	db 15 ; level
	length 0.3 ; length
	weight 3.2 ; weight
	tx WeedleLv15Description ; description
	db NONE | HAS_EVOLUTION ; AI info

KakunaLv20Card:
	db TYPE_PKMN_GRASS ; type
	dw $73d0 ; gfx
	tx KakunaName ; name
	db DIAMOND ; rarity
	db EXPANSION_SHEET ; real set
	db PSYCHIC_BATTLE ; in-game set
	dw KAKUNA_LV20
	db 60 ; hp
	db STAGE1 ; stage
	tx WeedleName ; pre-evo name

	; attack 1
	energy 0 ; energies
	tx PoisonFluidName ; name
	tx PoisonFluidDescription ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db POKEMON_POWER ; category
	dw KakunaLv20PoisonFluidEffectCommands ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_POISON_SEED ; animation

	; attack 2
	energy COLORLESS, 1 ; energies
	tx RolloutName ; name
	dw NONE ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_NORMAL ; category
	dw NONE ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_HIT ; animation

	db 2 ; retreat cost
	db WR_FIRE ; weakness
	db NONE ; resistance
	tx CocoonName ; category
	db DEX_KAKUNA ; Pokedex number
	db FALSE ; is Dark
	db 20 ; level
	length 0.6 ; length
	weight 10.0 ; weight
	tx KakunaLv20Description ; description
	db NONE | HAS_EVOLUTION ; AI info

KakunaLv23Card:
	db TYPE_PKMN_GRASS ; type
	dw $90e ; gfx
	tx KakunaName ; name
	db DIAMOND ; rarity
	db BASE_SET ; real set
	db BEGINNING_POKEMON ; in-game set
	dw KAKUNA_LV23
	db 80 ; hp
	db STAGE1 ; stage
	tx WeedleName ; pre-evo name

	; attack 1
	energy COLORLESS, 2 ; energies
	tx StiffenName ; name
	tx PreventDamageCardEffectDescription ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db RESIDUAL ; category
	dw KakunaLv23StiffenEffectCommands ; effect commands
	db NONE ; flags 1
	db NULLIFY_OR_WEAKEN_ATTACK  ; flags 2
	db FLAG_3_BIT_2  ; flags 3
	db 0 ; ?
	db ATK_ANIM_NONE ; animation

	; attack 2
	energy GRASS, 2 ; energies
	tx PoisonPowderName  ; name
	tx MayInflictPoisonDescription ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_NORMAL ; category
	dw KakunaLv23PoisonPowderEffectCommands ; effect commands
	db INFLICT_POISON  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_POWDER_EFFECT_CHANCE ; animation

	db 2 ; retreat cost
	db WR_FIRE ; weakness
	db NONE ; resistance
	tx CocoonName ; category
	db DEX_KAKUNA ; Pokedex number
	db FALSE ; is Dark
	db 23 ; level
	length 0.6 ; length
	weight 10.0 ; weight
	tx KakunaLv23Description ; description
	db NONE | HAS_EVOLUTION ; AI info

BeedrillCard:
	db TYPE_PKMN_GRASS ; type
	dw $977 ; gfx
	tx BeedrillName ; name
	db STAR ; rarity
	db BASE_SET ; real set
	db BEGINNING_POKEMON ; in-game set
	dw BEEDRILL
	db 80 ; hp
	db STAGE2 ; stage
	tx KakunaName ; pre-evo name

	; attack 1
	energy COLORLESS, 3 ; energies
	tx TwineedleName ; name
	tx Do30DamageNumberOfHeadsDescription ; description
	dw NONE ; description (cont)
	db 30 ; damage
	db DAMAGE_X ; category
	dw BeedrillTwineedleEffectCommands ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_NEEDLES ; animation

	; attack 2
	energy GRASS, 3 ; energies
	tx PoisonStingName ; name
	tx MayInflictPoisonDescription ; description
	dw NONE ; description (cont)
	db 40 ; damage
	db DAMAGE_NORMAL ; category
	dw BeedrillPoisonStingEffectCommands ; effect commands
	db INFLICT_POISON  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_NEEDLES ; animation

	db 0 ; retreat cost
	db WR_FIRE ; weakness
	db WR_FIGHTING ; resistance
	tx PoisonBeeName ; category
	db DEX_BEEDRILL ; Pokedex number
	db FALSE ; is Dark
	db 32 ; level
	length 1.0 ; length
	weight 29.5 ; weight
	tx BeedrillDescription ; description
	db NONE ; AI info

EkansLv10Card:
	db TYPE_PKMN_GRASS ; type
	dw $9e2 ; gfx
	tx EkansName ; name
	db CIRCLE ; rarity
	db FOSSIL ; real set
	db ISLAND_OF_FOSSIL ; in-game set
	dw EKANS_LV10
	db 40 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy GRASS, 1 ; energies
	tx SpitPoisonName ; name
	tx MayInflictPoisonDescription ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db DAMAGE_NORMAL ; category
	dw EkansLv10SpitPoisonEffectCommands ; effect commands
	db INFLICT_POISON  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_SPIT_POISON ; animation

	; attack 2
	energy GRASS, 1, COLORLESS, 1 ; energies
	tx WrapName ; name
	tx MayInflictParalysisDescription ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_NORMAL ; category
	dw EkansLv10WrapEffectCommands ; effect commands
	db INFLICT_PARALYSIS  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_HIT ; animation

	db 1 ; retreat cost
	db WR_PSYCHIC ; weakness
	db NONE ; resistance
	tx SnakeName ; category
	db DEX_EKANS ; Pokedex number
	db FALSE ; is Dark
	db 10 ; level
	length 2.0 ; length
	weight 6.9 ; weight
	tx EkansLv10Description ; description
	db AI_INFO_UNK_03 | HAS_EVOLUTION ; AI info

EkansLv15Card:
	db TYPE_PKMN_GRASS ; type
	dw $6000 ; gfx
	tx EkansName ; name
	db CIRCLE ; rarity
	db TEAM_ROCKET ; real set
	db WE_ARE_TEAM_ROCKET ; in-game set
	dw EKANS_LV15
	db 50 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy COLORLESS, 1 ; energies
	tx BiteName ; name
	dw NONE ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_NORMAL ; category
	dw NONE ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_HIT ; animation

	; attack 2
	energy GRASS, 2 ; energies
	tx PoisonStingName ; name
	tx MayInflictPoisonAltDescription ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_NORMAL ; category
	dw EkansLv15PoisonStingEffectCommands ; effect commands
	db INFLICT_POISON  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_POISON_NEEDLE ; animation

	db 1 ; retreat cost
	db WR_PSYCHIC ; weakness
	db NONE ; resistance
	tx SnakeName ; category
	db DEX_EKANS ; Pokedex number
	db FALSE ; is Dark
	db 15 ; level
	length 2.0 ; length
	weight 6.9 ; weight
	tx EkansLv15Description ; description
	db NONE | HAS_EVOLUTION ; AI info

ArbokLv27Card:
	db TYPE_PKMN_GRASS ; type
	dw $a5b ; gfx
	tx ArbokName ; name
	db DIAMOND ; rarity
	db FOSSIL ; real set
	db PSYCHIC_BATTLE ; in-game set
	dw ARBOK_LV27
	db 60 ; hp
	db STAGE1 ; stage
	tx EkansName ; pre-evo name

	; attack 1
	energy GRASS, 1 ; energies
	tx TerrorStrikeName ; name
	tx TerrorStrikeDescription ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_NORMAL ; category
	dw ArbokLv27TerrorStrikeEffectCommands ; effect commands
	db NONE ; flags 1
	db SWITCH_OPPONENT_POKEMON  ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_TERROR_STRIKE ; animation

	; attack 2
	energy GRASS, 2, COLORLESS, 1 ; energies
	tx PoisonFangName ; name
	tx InflictPoisonDescription ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_NORMAL ; category
	dw ArbokLv27PoisonFangEffectCommands ; effect commands
	db INFLICT_POISON  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_POISON_FANG ; animation

	db 2 ; retreat cost
	db WR_PSYCHIC ; weakness
	db NONE ; resistance
	tx CobraName ; category
	db DEX_ARBOK ; Pokedex number
	db FALSE ; is Dark
	db 27 ; level
	length 3.5 ; length
	weight 65.0 ; weight
	tx ArbokLv27Description ; description
	db NONE ; AI info

ArbokLv30Card:
	db TYPE_PKMN_GRASS ; type
	dw $8daf ; gfx
	tx ArbokName ; name
	db STAR ; rarity
	db EXPANSION_SHEET ; real set
	db ISLAND_OF_FOSSIL ; in-game set
	dw ARBOK_LV30
	db 60 ; hp
	db STAGE1 ; stage
	tx EkansName ; pre-evo name

	; attack 1
	energy GRASS, 1, COLORLESS, 1 ; energies
	tx WrapName ; name
	tx MayInflictParalysisAltDescription ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_NORMAL ; category
	dw ArbokLv30WrapEffectCommands ; effect commands
	db INFLICT_PARALYSIS  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_HIT ; animation

	; attack 2
	energy GRASS, 3 ; energies
	tx DeadlyPoisonName ; name
	tx DeadlyPoisonDescription ; description
	dw NONE ; description (cont)
	db 30 ; damage
	db DAMAGE_PLUS ; category
	dw ArbokLv30DeadlyPoisonEffectCommands ; effect commands
	db INFLICT_POISON  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_POISON_FANG ; animation

	db 2 ; retreat cost
	db WR_PSYCHIC ; weakness
	db NONE ; resistance
	tx CobraName ; category
	db DEX_ARBOK ; Pokedex number
	db FALSE ; is Dark
	db 30 ; level
	length 3.5 ; length
	weight 65.0 ; weight
	tx ArbokLv30Description ; description
	db NONE ; AI info

DarkArbokCard:
	db TYPE_PKMN_GRASS ; type
	dw $6075 ; gfx
	tx DarkArbokName ; name
	db STAR ; rarity
	db TEAM_ROCKET ; real set
	db WE_ARE_TEAM_ROCKET ; in-game set
	dw DARK_ARBOK
	db 60 ; hp
	db STAGE1 ; stage
	tx EkansName ; pre-evo name

	; attack 1
	energy GRASS, 2 ; energies
	tx StareName ; name
	tx StareDescription ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db RESIDUAL ; category
	dw DarkArbokStareEffectCommands ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db SPECIAL_AI_HANDLING | FLAG_3_BIT_2  ; flags 3
	db 0 ; ?
	db ATK_ANIM_STARE ; animation

	; attack 2
	energy GRASS, 3 ; energies
	tx PoisonVaporName ; name
	tx PoisonVaporDescription ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_NORMAL ; category
	dw DarkArbokPoisonVaporEffectCommands ; effect commands
	db INFLICT_POISON  ; flags 1
	db NONE ; flags 2
	db FLAG_3_BIT_2  ; flags 3
	db 0 ; ?
	db ATK_ANIM_POISON_VAPOR ; animation

	db 2 ; retreat cost
	db WR_PSYCHIC ; weakness
	db NONE ; resistance
	tx CobraName ; category
	db DEX_ARBOK ; Pokedex number
	db TRUE ; is Dark
	db 25 ; level
	length 3.5 ; length
	weight 65.0 ; weight
	tx DarkArbokDescription ; description
	db NONE ; AI info

NidoranFLv12Card:
	db TYPE_PKMN_GRASS ; type
	dw $75ac ; gfx
	tx NidoranFName ; name
	db CIRCLE ; rarity
	db EXPANSION_SHEET ; real set
	db PSYCHIC_BATTLE ; in-game set
	dw NIDORANF_LV12
	db 50 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy COLORLESS, 1 ; energies
	tx TailWhipName ; name
	tx TailWhipDescription ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db DAMAGE_NORMAL ; category
	dw NidoranFLv12TailWhipEffectCommands ; effect commands
	db NONE ; flags 1
	db NULLIFY_OR_WEAKEN_ATTACK  ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_TAIL_WHIP ; animation

	; attack 2
	energy GRASS, 1 ; energies
	tx PoisonStingName ; name
	tx MayInflictPoisonAltDescription ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_NORMAL ; category
	dw NidoranFLv12PoisonStingEffectCommands ; effect commands
	db INFLICT_POISON  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_POISON_NEEDLE ; animation

	db 1 ; retreat cost
	db WR_PSYCHIC ; weakness
	db NONE ; resistance
	tx PoisonStingName ; category
	db DEX_NIDORAN_F ; Pokedex number
	db FALSE ; is Dark
	db 12 ; level
	length 0.4 ; length
	weight 7.0 ; weight
	tx NidoranFLv12Description ; description
	db NONE | HAS_EVOLUTION ; AI info

NidoranFLv13Card:
	db TYPE_PKMN_GRASS ; type
	dw $ae2 ; gfx
	tx NidoranFName ; name
	db CIRCLE ; rarity
	db JUNGLE ; real set
	db LEGENDARY_POWER ; in-game set
	dw NIDORANF_LV13
	db 60 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy GRASS, 1 ; energies
	tx FurySwipesName ; name
	tx FurySwipes10DamageDescription ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_X ; category
	dw NidoranFLv13FurySwipesEffectCommands ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_MULTIPLE_SLASH ; animation

	; attack 2
	energy GRASS, 2 ; energies
	tx CallForFamilyName ; name
	tx CallForFamilyNidoranDescription ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db RESIDUAL ; category
	dw NidoranFLv13CallForFamilyEffectCommands ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db SPECIAL_AI_HANDLING | FLAG_3_BIT_2  ; flags 3
	db 0 ; ?
	db ATK_ANIM_GLOW_EFFECT ; animation

	db 1 ; retreat cost
	db WR_PSYCHIC ; weakness
	db NONE ; resistance
	tx PoisonStingName ; category
	db DEX_NIDORAN_F ; Pokedex number
	db FALSE ; is Dark
	db 13 ; level
	length 0.4 ; length
	weight 7.0 ; weight
	tx NidoranFLv13Description ; description
	db AI_INFO_UNK_03 | HAS_EVOLUTION ; AI info

NidorinaLv22Card:
	db TYPE_PKMN_GRASS ; type
	dw $8e87 ; gfx
	tx NidorinaName ; name
	db DIAMOND ; rarity
	db EXPANSION_SHEET ; real set
	db PSYCHIC_BATTLE ; in-game set
	dw NIDORINA_LV22
	db 60 ; hp
	db STAGE1 ; stage
	tx NidoranFName ; pre-evo name

	; attack 1
	energy GRASS, 2 ; energies
	tx StrengthInNumbersName ; name
	tx StrengthInNumbersDescription ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_PLUS ; category
	dw NidorinaLv22StrengthInNumbersEffectCommands ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_HIT ; animation

	; attack 2
	energy GRASS, 2, COLORLESS, 1 ; energies
	tx FurySwipesName ; name
	tx FurySwipes30DamageDescription ; description
	dw NONE ; description (cont)
	db 30 ; damage
	db DAMAGE_X ; category
	dw NidorinaLv22FurySwipesEffectCommands ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_MULTIPLE_SLASH ; animation

	db 2 ; retreat cost
	db WR_PSYCHIC ; weakness
	db NONE ; resistance
	tx PoisonStingName ; category
	db DEX_NIDORINA ; Pokedex number
	db FALSE ; is Dark
	db 22 ; level
	length 0.8 ; length
	weight 20.0 ; weight
	tx NidorinaLv22Description ; description
	db NONE | HAS_EVOLUTION ; AI info

NidorinaLv24Card:
	db TYPE_PKMN_GRASS ; type
	dw $b4d ; gfx
	tx NidorinaName ; name
	db DIAMOND ; rarity
	db JUNGLE ; real set
	db LEGENDARY_POWER ; in-game set
	dw NIDORINA_LV24
	db 70 ; hp
	db STAGE1 ; stage
	tx NidoranFName ; pre-evo name

	; attack 1
	energy GRASS, 1 ; energies
	tx SupersonicName ; name
	tx MayInflictConfusionAltDescription ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db DAMAGE_NORMAL ; category
	dw NidorinaLv24SupersonicEffectCommands ; effect commands
	db INFLICT_CONFUSION  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_SUPERSONIC ; animation

	; attack 2
	energy GRASS, 1, COLORLESS, 2 ; energies
	tx DoubleKickName ; name
	tx Do30DamageNumberOfHeadsDescription ; description
	dw NONE ; description (cont)
	db 30 ; damage
	db DAMAGE_X ; category
	dw NidorinaLv24DoubleKickEffectCommands ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_LEG_SWEEP ; animation

	db 1 ; retreat cost
	db WR_PSYCHIC ; weakness
	db NONE ; resistance
	tx PoisonStingName ; category
	db DEX_NIDORINA ; Pokedex number
	db FALSE ; is Dark
	db 24 ; level
	length 0.8 ; length
	weight 20.0 ; weight
	tx NidorinaLv24Description ; description
	db NONE | HAS_EVOLUTION ; AI info

NidoqueenCard:
	db TYPE_PKMN_GRASS ; type
	dw $bbe ; gfx
	tx NidoqueenName ; name
	db STAR ; rarity
	db JUNGLE ; real set
	db ISLAND_OF_FOSSIL ; in-game set
	dw NIDOQUEEN
	db 90 ; hp
	db STAGE2 ; stage
	tx NidorinaName ; pre-evo name

	; attack 1
	energy GRASS, 1, COLORLESS, 1 ; energies
	tx BoyfriendsName ; name
	tx BoyfriendsDescription ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_PLUS ; category
	dw NidoqueenBoyfriendsEffectCommands ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_BOYFRIENDS ; animation

	; attack 2
	energy GRASS, 2, COLORLESS, 2 ; energies
	tx MegaPunchName ; name
	dw NONE ; description
	dw NONE ; description (cont)
	db 50 ; damage
	db DAMAGE_NORMAL ; category
	dw NONE ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_MEGA_PUNCH ; animation

	db 3 ; retreat cost
	db WR_PSYCHIC ; weakness
	db NONE ; resistance
	tx DrillName ; category
	db DEX_NIDOQUEEN ; Pokedex number
	db FALSE ; is Dark
	db 43 ; level
	length 1.3 ; length
	weight 60.0 ; weight
	tx NidoqueenDescription ; description
	db NONE ; AI info

NidoranMLv20Card:
	db TYPE_PKMN_GRASS ; type
	dw $c27 ; gfx
	tx NidoranMName ; name
	db CIRCLE ; rarity
	db BASE_SET ; real set
	db BEGINNING_POKEMON ; in-game set
	dw NIDORANM_LV20
	db 40 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy GRASS, 1 ; energies
	tx HornHazardName ; name
	tx IfTailsDoNothingDescription ; description
	dw NONE ; description (cont)
	db 30 ; damage
	db DAMAGE_NORMAL ; category
	dw NidoranMLv20HornHazardEffectCommands ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_NONE ; animation

	; attack 2
	energy 0 ; energies
	dw NONE ; name
	dw NONE ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db DAMAGE_NORMAL ; category
	dw NONE ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_NONE ; animation

	db 1 ; retreat cost
	db WR_PSYCHIC ; weakness
	db NONE ; resistance
	tx PoisonStingName ; category
	db DEX_NIDORAN_M ; Pokedex number
	db FALSE ; is Dark
	db 20 ; level
	length 0.5 ; length
	weight 9.0 ; weight
	tx NidoranMLv20Description ; description
	db AI_INFO_UNK_03 | HAS_EVOLUTION ; AI info

NidoranMLv22Card:
	db TYPE_PKMN_GRASS ; type
	dw $7675 ; gfx
	tx NidoranMName ; name
	db CIRCLE ; rarity
	db EXPANSION_SHEET ; real set
	db PSYCHIC_BATTLE ; in-game set
	dw NIDORANM_LV22
	db 50 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy COLORLESS, 1 ; energies
	tx FocusEnergyName ; name
	tx FocusEnergyHornRushDescription ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db RESIDUAL ; category
	dw NidoranMLv22FocusEnergyEffectCommands ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db SPECIAL_AI_HANDLING | FLAG_3_BIT_2  ; flags 3
	db 0 ; ?
	db ATK_ANIM_GLOW_EFFECT ; animation

	; attack 2
	energy GRASS, 1, COLORLESS, 1 ; energies
	tx HornRushName ; name
	tx IfTailsDoNothingAltDescription ; description
	dw NONE ; description (cont)
	db 40 ; damage
	db DAMAGE_NORMAL ; category
	dw NidoranMLv22HornRushEffectCommands ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_HIT ; animation

	db 1 ; retreat cost
	db WR_PSYCHIC ; weakness
	db NONE ; resistance
	tx PoisonStingName ; category
	db DEX_NIDORAN_M ; Pokedex number
	db FALSE ; is Dark
	db 22 ; level
	length 0.5 ; length
	weight 9.0 ; weight
	tx NidoranMLv22Description ; description
	db NONE | HAS_EVOLUTION ; AI info

NidorinoLv23Card:
	db TYPE_PKMN_GRASS ; type
	dw $8ef0 ; gfx
	tx NidorinoName ; name
	db DIAMOND ; rarity
	db EXPANSION_SHEET ; real set
	db PSYCHIC_BATTLE ; in-game set
	dw NIDORINO_LV23
	db 60 ; hp
	db STAGE1 ; stage
	tx NidoranMName ; pre-evo name

	; attack 1
	energy GRASS, 2 ; energies
	tx SwiftLungeName ; name
	tx SwiftLungeDescription ; description
	dw NONE ; description (cont)
	db 60 ; damage
	db DAMAGE_NORMAL ; category
	dw NidorinoLv23SwiftLungeEffectCommands ; effect commands
	db LOW_RECOIL  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_QUICK_ATTACK ; animation

	; attack 2
	energy 0 ; energies
	dw NONE ; name
	dw NONE ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db DAMAGE_NORMAL ; category
	dw NONE ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_NONE ; animation

	db 1 ; retreat cost
	db WR_PSYCHIC ; weakness
	db NONE ; resistance
	tx PoisonStingName ; category
	db DEX_NIDORINO ; Pokedex number
	db FALSE ; is Dark
	db 23 ; level
	length 0.9 ; length
	weight 19.5 ; weight
	tx NidorinoLv23Description ; description
	db NONE | HAS_EVOLUTION ; AI info

NidorinoLv25Card:
	db TYPE_PKMN_GRASS ; type
	dw $c92 ; gfx
	tx NidorinoName ; name
	db DIAMOND ; rarity
	db BASE_SET ; real set
	db BEGINNING_POKEMON ; in-game set
	dw NIDORINO_LV25
	db 60 ; hp
	db STAGE1 ; stage
	tx NidoranMName ; pre-evo name

	; attack 1
	energy GRASS, 1, COLORLESS, 2 ; energies
	tx DoubleKickName ; name
	tx Do30DamageNumberOfHeadsDescription ; description
	dw NONE ; description (cont)
	db 30 ; damage
	db DAMAGE_X ; category
	dw NidorinoLv25DoubleKickEffectCommands ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_LEG_SWEEP ; animation

	; attack 2
	energy GRASS, 2, COLORLESS, 2 ; energies
	tx HornDrillName ; name
	dw NONE ; description
	dw NONE ; description (cont)
	db 50 ; damage
	db DAMAGE_NORMAL ; category
	dw NONE ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_DRILL ; animation

	db 1 ; retreat cost
	db WR_PSYCHIC ; weakness
	db NONE ; resistance
	tx PoisonStingName ; category
	db DEX_NIDORINO ; Pokedex number
	db FALSE ; is Dark
	db 25 ; level
	length 0.9 ; length
	weight 19.5 ; weight
	tx NidorinoLv25Description ; description
	db NONE | HAS_EVOLUTION ; AI info

NidokingCard:
	db TYPE_PKMN_GRASS ; type
	dw $cfb ; gfx
	tx NidokingName ; name
	db STAR ; rarity
	db BASE_SET ; real set
	db LEGENDARY_POWER ; in-game set
	dw NIDOKING
	db 90 ; hp
	db STAGE2 ; stage
	tx NidorinoName ; pre-evo name

	; attack 1
	energy GRASS, 1, COLORLESS, 2 ; energies
	tx ThrashName ; name
	tx ThrashDescription ; description
	dw NONE ; description (cont)
	db 30 ; damage
	db DAMAGE_PLUS ; category
	dw NidokingThrashEffectCommands ; effect commands
	db LOW_RECOIL  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_MULTIPLE_SLASH ; animation

	; attack 2
	energy GRASS, 3 ; energies
	tx ToxicName ; name
	tx ToxicDescription ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_NORMAL ; category
	dw NidokingToxicEffectCommands ; effect commands
	db INFLICT_POISON  ; flags 1
	db FLAG_2_BIT_6  ; flags 2
	db NONE ; flags 3
	db 2 ; ?
	db ATK_ANIM_TOXIC ; animation

	db 3 ; retreat cost
	db WR_PSYCHIC ; weakness
	db NONE ; resistance
	tx DrillName ; category
	db DEX_NIDOKING ; Pokedex number
	db FALSE ; is Dark
	db 48 ; level
	length 1.4 ; length
	weight 62.0 ; weight
	tx NidokingDescription ; description
	db NONE ; AI info

ZubatLv9Card:
	db TYPE_PKMN_GRASS ; type
	dw $60e2 ; gfx
	tx ZubatName ; name
	db CIRCLE ; rarity
	db TEAM_ROCKET ; real set
	db TEAM_ROCKETS_AMBITION ; in-game set
	dw ZUBAT_LV9
	db 40 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy COLORLESS, 1 ; energies
	tx RamName ; name
	dw NONE ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_NORMAL ; category
	dw NONE ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_HIT ; animation

	; attack 2
	energy GRASS, 1, COLORLESS, 1 ; energies
	tx BiteName ; name
	dw NONE ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_NORMAL ; category
	dw NONE ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_HIT ; animation

	db 0 ; retreat cost
	db WR_PSYCHIC ; weakness
	db WR_FIGHTING ; resistance
	tx BatName ; category
	db DEX_ZUBAT ; Pokedex number
	db FALSE ; is Dark
	db 9 ; level
	length 0.8 ; length
	weight 7.5 ; weight
	tx ZubatLv9Description ; description
	db NONE | HAS_EVOLUTION ; AI info

ZubatLv10Card:
	db TYPE_PKMN_GRASS ; type
	dw $d64 ; gfx
	tx ZubatName ; name
	db CIRCLE ; rarity
	db FOSSIL ; real set
	db ISLAND_OF_FOSSIL ; in-game set
	dw ZUBAT_LV10
	db 40 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy COLORLESS, 2 ; energies
	tx SupersonicName ; name
	tx MayInflictConfusionAltDescription ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db DAMAGE_NORMAL ; category
	dw ZubatLv10SupersonicEffectCommands ; effect commands
	db INFLICT_CONFUSION  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_SUPERSONIC ; animation

	; attack 2
	energy GRASS, 1, COLORLESS, 1 ; energies
	tx LeechLifeName ; name
	tx LeechLifeDescription ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_NORMAL ; category
	dw ZubatLv10LeechLifeEffectCommands ; effect commands
	db NONE ; flags 1
	db HEAL_USER  ; flags 2
	db NONE ; flags 3
	db 3 ; ?
	db ATK_ANIM_DRAIN ; animation

	db 0 ; retreat cost
	db WR_PSYCHIC ; weakness
	db WR_FIGHTING ; resistance
	tx BatName ; category
	db DEX_ZUBAT ; Pokedex number
	db FALSE ; is Dark
	db 10 ; level
	length 0.8 ; length
	weight 7.5 ; weight
	tx ZubatLv10Description ; description
	db NONE | HAS_EVOLUTION ; AI info

ZubatLv12Card:
	db TYPE_PKMN_GRASS ; type
	dw $7800 ; gfx
	tx ZubatName ; name
	db CIRCLE ; rarity
	db EXPANSION_SHEET ; real set
	db SKY_FLYING_POKEMON ; in-game set
	dw ZUBAT_LV12
	db 40 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy COLORLESS, 1 ; energies
	tx BiteName ; name
	dw NONE ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_NORMAL ; category
	dw NONE ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_HIT ; animation

	; attack 2
	energy GRASS, 1, COLORLESS, 1 ; energies
	tx SuspiciousSoundwaveName ; name
	tx MayInflictConfusionDescription ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_NORMAL ; category
	dw ZubatLv12SuspiciousSoundwaveEffectCommands ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_SUSPICIOUS_SOUNDWAVE ; animation

	db 0 ; retreat cost
	db WR_PSYCHIC ; weakness
	db WR_FIGHTING ; resistance
	tx BatName ; category
	db DEX_ZUBAT ; Pokedex number
	db FALSE ; is Dark
	db 12 ; level
	length 0.8 ; length
	weight 7.5 ; weight
	tx ZubatLv12Description ; description
	db NONE | HAS_EVOLUTION ; AI info

GolbatLv25Card:
	db TYPE_PKMN_GRASS ; type
	dw $7869 ; gfx
	tx GolbatName ; name
	db DIAMOND ; rarity
	db EXPANSION_SHEET ; real set
	db ISLAND_OF_FOSSIL ; in-game set
	dw GOLBAT_LV25
	db 50 ; hp
	db STAGE1 ; stage
	tx ZubatName ; pre-evo name

	; attack 1
	energy GRASS, 2, COLORLESS, 1 ; energies
	tx LeechLifeName ; name
	tx LeechLifeAltDescription ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_NORMAL ; category
	dw GolbatLv25LeechLifeEffectCommands ; effect commands
	db NONE ; flags 1
	db HEAL_USER  ; flags 2
	db NONE ; flags 3
	db 3 ; ?
	db ATK_ANIM_DRAIN ; animation

	; attack 2
	energy GRASS, 1, COLORLESS, 3 ; energies
	tx NosediveName ; name
	tx NosediveDescription ; description
	dw NONE ; description (cont)
	db 60 ; damage
	db DAMAGE_NORMAL ; category
	dw GolbatLv25NosediveEffectCommands ; effect commands
	db LOW_RECOIL  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_BIG_HIT ; animation

	db 1 ; retreat cost
	db WR_PSYCHIC ; weakness
	db WR_FIGHTING ; resistance
	tx BatName ; category
	db DEX_GOLBAT ; Pokedex number
	db FALSE ; is Dark
	db 25 ; level
	length 1.6 ; length
	weight 55.0 ; weight
	tx GolbatLv25Description ; description
	db NONE ; AI info

GolbatLv29Card:
	db TYPE_PKMN_GRASS ; type
	dw $dcd ; gfx
	tx GolbatName ; name
	db DIAMOND ; rarity
	db FOSSIL ; real set
	db SKY_FLYING_POKEMON ; in-game set
	dw GOLBAT_LV29
	db 60 ; hp
	db STAGE1 ; stage
	tx ZubatName ; pre-evo name

	; attack 1
	energy COLORLESS, 3 ; energies
	tx WingAttackName ; name
	dw NONE ; description
	dw NONE ; description (cont)
	db 30 ; damage
	db DAMAGE_NORMAL ; category
	dw NONE ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_HIT ; animation

	; attack 2
	energy GRASS, 2, COLORLESS, 1 ; energies
	tx LeechLifeName ; name
	tx LeechLifeDescription ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_NORMAL ; category
	dw GolbatLv29LeechLifeEffectCommands ; effect commands
	db NONE ; flags 1
	db HEAL_USER  ; flags 2
	db NONE ; flags 3
	db 3 ; ?
	db ATK_ANIM_DRAIN ; animation

	db 0 ; retreat cost
	db WR_PSYCHIC ; weakness
	db WR_FIGHTING ; resistance
	tx BatName ; category
	db DEX_GOLBAT ; Pokedex number
	db FALSE ; is Dark
	db 29 ; level
	length 1.6 ; length
	weight 55.0 ; weight
	tx GolbatLv29Description ; description
	db NONE ; AI info

DarkGolbatCard:
	db TYPE_PKMN_GRASS ; type
	dw $614b ; gfx
	tx DarkGolbatName ; name
	db STAR ; rarity
	db TEAM_ROCKET ; real set
	db TEAM_ROCKETS_AMBITION ; in-game set
	dw DARK_GOLBAT
	db 50 ; hp
	db STAGE1 ; stage
	tx ZubatName ; pre-evo name

	; attack 1
	energy 0 ; energies
	tx SneakAttackName ; name
	tx SneakAttackDescription ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db POKEMON_POWER ; category
	dw DarkGolbatSneakAttackEffectCommands ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_SNEAK_ATTACK ; animation

	; attack 2
	energy GRASS, 2 ; energies
	tx FlitterName ; name
	tx FlitterDescription ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db RESIDUAL ; category
	dw DarkGolbatFlitterEffectCommands ; effect commands
	db DAMAGE_TO_OPPONENT_BENCH  ; flags 1
	db FLAG_2_BIT_6  ; flags 2
	db FLAG_3_BIT_2  ; flags 3
	db 0 ; ?
	db ATK_ANIM_HIT ; animation

	db 0 ; retreat cost
	db WR_PSYCHIC ; weakness
	db WR_FIGHTING ; resistance
	tx BatName ; category
	db DEX_GOLBAT ; Pokedex number
	db TRUE ; is Dark
	db 25 ; level
	length 1.6 ; length
	weight 55.0 ; weight
	tx DarkGolbatDescription ; description
	db NONE ; AI info

OddishLv8Card:
	db TYPE_PKMN_GRASS ; type
	dw $e36 ; gfx
	tx OddishName ; name
	db CIRCLE ; rarity
	db JUNGLE ; real set
	db ISLAND_OF_FOSSIL ; in-game set
	dw ODDISH_LV8
	db 50 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy GRASS, 1 ; energies
	tx StunSporeName ; name
	tx MayInflictParalysisDescription ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_NORMAL ; category
	dw OddishLv8StunSporeEffectCommands ; effect commands
	db INFLICT_PARALYSIS  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_POWDER_EFFECT_CHANCE ; animation

	; attack 2
	energy GRASS, 2 ; energies
	tx SproutName ; name
	tx SproutDescription ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db RESIDUAL ; category
	dw OddishLv8SproutEffectCommands ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db SPECIAL_AI_HANDLING | FLAG_3_BIT_2  ; flags 3
	db 0 ; ?
	db ATK_ANIM_GLOW_EFFECT ; animation

	db 1 ; retreat cost
	db WR_FIRE ; weakness
	db NONE ; resistance
	tx WeedName ; category
	db DEX_ODDISH ; Pokedex number
	db FALSE ; is Dark
	db 8 ; level
	length 0.5 ; length
	weight 5.4 ; weight
	tx OddishLv8Description ; description
	db NONE | HAS_EVOLUTION ; AI info

OddishLv21Card:
	db TYPE_PKMN_GRASS ; type
	dw $61bc ; gfx
	tx OddishName ; name
	db CIRCLE ; rarity
	db TEAM_ROCKET ; real set
	db TEAM_ROCKETS_AMBITION ; in-game set
	dw ODDISH_LV21
	db 50 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy GRASS, 1 ; energies
	tx SleepPowderName ; name
	tx InflictSleepDescription ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db DAMAGE_NORMAL ; category
	dw OddishLv21SleepPowderEffectCommands ; effect commands
	db INFLICT_SLEEP  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_SPORE ; animation

	; attack 2
	energy GRASS, 1 ; energies
	tx PoisonPowderName  ; name
	tx InflictPoisonDescription ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db DAMAGE_NORMAL ; category
	dw OddishLv21PoisonPowderEffectCommands ; effect commands
	db INFLICT_POISON  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_POISON_POWDER ; animation

	db 1 ; retreat cost
	db WR_FIRE ; weakness
	db NONE ; resistance
	tx WeedName ; category
	db DEX_ODDISH ; Pokedex number
	db FALSE ; is Dark
	db 21 ; level
	length 0.5 ; length
	weight 5.4 ; weight
	tx OddishLv21Description ; description
	db NONE | HAS_EVOLUTION ; AI info

GloomCard:
	db TYPE_PKMN_GRASS ; type
	dw $e9f ; gfx
	tx GloomName ; name
	db DIAMOND ; rarity
	db JUNGLE ; real set
	db ISLAND_OF_FOSSIL ; in-game set
	dw GLOOM
	db 60 ; hp
	db STAGE1 ; stage
	tx OddishName ; pre-evo name

	; attack 1
	energy GRASS, 1 ; energies
	tx PoisonPowderName  ; name
	tx InflictPoisonDescription ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db DAMAGE_NORMAL ; category
	dw GloomPoisonPowderEffectCommands ; effect commands
	db INFLICT_POISON  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_POISON_POWDER ; animation

	; attack 2
	energy GRASS, 2 ; energies
	tx FoulOdorName ; name
	tx FoulOdorDescription ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_NORMAL ; category
	dw GloomFoulOdorEffectCommands ; effect commands
	db INFLICT_CONFUSION  ; flags 1
	db FLAG_2_BIT_7  ; flags 2
	db NONE ; flags 3
	db 1 ; ?
	db ATK_ANIM_FOUL_ODOR ; animation

	db 1 ; retreat cost
	db WR_FIRE ; weakness
	db NONE ; resistance
	tx WeedName ; category
	db DEX_GLOOM ; Pokedex number
	db FALSE ; is Dark
	db 22 ; level
	length 0.8 ; length
	weight 8.6 ; weight
	tx GloomDescription ; description
	db NONE | HAS_EVOLUTION ; AI info

DarkGloomCard:
	db TYPE_PKMN_GRASS ; type
	dw $6225 ; gfx
	tx DarkGloomName ; name
	db DIAMOND ; rarity
	db TEAM_ROCKET ; real set
	db TEAM_ROCKETS_AMBITION ; in-game set
	dw DARK_GLOOM
	db 50 ; hp
	db STAGE1 ; stage
	tx OddishName ; pre-evo name

	; attack 1
	energy 0 ; energies
	tx PollenStenchName ; name
	tx PollenStenchDescription ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db POKEMON_POWER ; category
	dw DarkGloomPollenStenchEffectCommands ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_POLLEN_STENCH ; animation

	; attack 2
	energy GRASS, 2 ; energies
	tx PoisonPowderName  ; name
	tx InflictPoisonDescription ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_NORMAL ; category
	dw DarkGloomPoisonPowderEffectCommands ; effect commands
	db INFLICT_POISON  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_POISONPOWDER ; animation

	db 2 ; retreat cost
	db WR_FIRE ; weakness
	db NONE ; resistance
	tx WeedName ; category
	db DEX_GLOOM ; Pokedex number
	db TRUE ; is Dark
	db 21 ; level
	length 0.8 ; length
	weight 8.6 ; weight
	tx DarkGloomDescription ; description
	db NONE | HAS_EVOLUTION ; AI info

VileplumeCard:
	db TYPE_PKMN_GRASS ; type
	dw $f08 ; gfx
	tx VileplumeName ; name
	db STAR ; rarity
	db JUNGLE ; real set
	db ISLAND_OF_FOSSIL ; in-game set
	dw VILEPLUME
	db 80 ; hp
	db STAGE2 ; stage
	tx GloomName ; pre-evo name

	; attack 1
	energy 0 ; energies
	tx HealName ; name
	tx HealDescription ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db POKEMON_POWER ; category
	dw VileplumeHealEffectCommands ; effect commands
	db NONE ; flags 1
	db HEAL_USER  ; flags 2
	db NONE ; flags 3
	db 1 ; ?
	db ATK_ANIM_PKMN_POWER_1 ; animation

	; attack 2
	energy GRASS, 3 ; energies
	tx PetalDanceName ; name
	tx PetalDanceDescription ; description
	dw NONE ; description (cont)
	db 40 ; damage
	db DAMAGE_X ; category
	dw VileplumePetalDanceEffectCommands ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_PETAL_DANCE ; animation

	db 2 ; retreat cost
	db WR_FIRE ; weakness
	db NONE ; resistance
	tx FlowerName ; category
	db DEX_VILEPLUME ; Pokedex number
	db FALSE ; is Dark
	db 35 ; level
	length 1.2 ; length
	weight 18.6 ; weight
	tx VileplumeDescription ; description
	db NONE ; AI info

DarkVileplumeCard:
	db TYPE_PKMN_GRASS ; type
	dw $628e ; gfx
	tx DarkVileplumeName ; name
	db STAR ; rarity
	db TEAM_ROCKET ; real set
	db TEAM_ROCKETS_AMBITION ; in-game set
	dw DARK_VILEPLUME
	db 60 ; hp
	db STAGE2 ; stage
	tx DarkGloomName ; pre-evo name

	; attack 1
	energy 0 ; energies
	tx HayFeverName ; name
	tx HayFeverDescription ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db POKEMON_POWER ; category
	dw DarkVileplumeHayFeverEffectCommands ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_NONE ; animation

	; attack 2
	energy GRASS, 3 ; energies
	tx PetalWhirlwindName ; name
	tx PetalWhirlwindDescription ; description
	dw NONE ; description (cont)
	db 30 ; damage
	db DAMAGE_X ; category
	dw DarkVileplumePetalWhirlwindEffectCommands ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_PETAL_DANCE ; animation

	db 2 ; retreat cost
	db WR_FIRE ; weakness
	db NONE ; resistance
	tx FlowerName ; category
	db DEX_VILEPLUME ; Pokedex number
	db TRUE ; is Dark
	db 29 ; level
	length 1.2 ; length
	weight 18.6 ; weight
	tx DarkVileplumeDescription ; description
	db NONE ; AI info

ParasLv8Card:
	db TYPE_PKMN_GRASS ; type
	dw $f71 ; gfx
	tx ParasName ; name
	db CIRCLE ; rarity
	db JUNGLE ; real set
	db PSYCHIC_BATTLE ; in-game set
	dw PARAS_LV8
	db 40 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy COLORLESS, 2 ; energies
	tx ScratchName ; name
	dw NONE ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_NORMAL ; category
	dw NONE ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_SLASH ; animation

	; attack 2
	energy GRASS, 2 ; energies
	tx SporeName ; name
	tx InflictSleepDescription ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db DAMAGE_NORMAL ; category
	dw ParasLv8SporeEffectCommands ; effect commands
	db INFLICT_SLEEP  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_SPORE ; animation

	db 1 ; retreat cost
	db WR_FIRE ; weakness
	db NONE ; resistance
	tx MushroomName ; category
	db DEX_PARAS ; Pokedex number
	db FALSE ; is Dark
	db 8 ; level
	length 0.3 ; length
	weight 5.4 ; weight
	tx ParasLv8Description ; description
	db NONE | HAS_EVOLUTION ; AI info

ParasLv15Card:
	db TYPE_PKMN_GRASS ; type
	dw $78d6 ; gfx
	tx ParasName ; name
	db CIRCLE ; rarity
	db EXPANSION_SHEET ; real set
	db LEGENDARY_POWER ; in-game set
	dw PARAS_LV15
	db 50 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy COLORLESS, 1 ; energies
	tx ScratchName ; name
	dw NONE ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_NORMAL ; category
	dw NONE ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_SLASH ; animation

	; attack 2
	energy GRASS, 1 ; energies
	tx ScatterSporesName ; name
	tx ScatterSporesDescription ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db RESIDUAL ; category
	dw ParasLv15ScatterSporesEffectCommands ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db SPECIAL_AI_HANDLING | FLAG_3_BIT_2  ; flags 3
	db 0 ; ?
	db ATK_ANIM_GLOW_EFFECT ; animation

	db 1 ; retreat cost
	db WR_FIRE ; weakness
	db NONE ; resistance
	tx MushroomName ; category
	db DEX_PARAS ; Pokedex number
	db FALSE ; is Dark
	db 15 ; level
	length 0.3 ; length
	weight 5.4 ; weight
	tx ParasLv15Description ; description
	db NONE | HAS_EVOLUTION ; AI info

ParasectLv28Card:
	db TYPE_PKMN_GRASS ; type
	dw $1000 ; gfx
	tx ParasectName ; name
	db DIAMOND ; rarity
	db JUNGLE ; real set
	db PSYCHIC_BATTLE ; in-game set
	dw PARASECT_LV28
	db 60 ; hp
	db STAGE1 ; stage
	tx ParasName ; pre-evo name

	; attack 1
	energy GRASS, 2 ; energies
	tx SporeName ; name
	tx InflictSleepDescription ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db DAMAGE_NORMAL ; category
	dw ParasectLv28SporeEffectCommands ; effect commands
	db INFLICT_SLEEP  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_SPORE ; animation

	; attack 2
	energy COLORLESS, 3 ; energies
	tx SlashName ; name
	dw NONE ; description
	dw NONE ; description (cont)
	db 30 ; damage
	db DAMAGE_NORMAL ; category
	dw NONE ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_SLASH ; animation

	db 1 ; retreat cost
	db WR_FIRE ; weakness
	db NONE ; resistance
	tx MushroomName ; category
	db DEX_PARASECT ; Pokedex number
	db FALSE ; is Dark
	db 28 ; level
	length 1.0 ; length
	weight 29.5 ; weight
	tx ParasectLv28Description ; description
	db NONE ; AI info

ParasectLv29Card:
	db TYPE_PKMN_GRASS ; type
	dw $793f ; gfx
	tx ParasectName ; name
	db DIAMOND ; rarity
	db EXPANSION_SHEET ; real set
	db LEGENDARY_POWER ; in-game set
	dw PARASECT_LV29
	db 60 ; hp
	db STAGE1 ; stage
	tx ParasName ; pre-evo name

	; attack 1
	energy GRASS, 2 ; energies
	tx ToxicSporeName ; name
	tx InflictPoisonDescription ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_NORMAL ; category
	dw ParasectLv29ToxicSporeEffectCommands ; effect commands
	db INFLICT_POISON  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_POWDER_HIT_POISON ; animation

	; attack 2
	energy GRASS, 2, COLORLESS, 1 ; energies
	tx LeechLifeName ; name
	tx LeechLifeAltDescription ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_NORMAL ; category
	dw ParasectLv29LeechLifeEffectCommands ; effect commands
	db NONE ; flags 1
	db HEAL_USER  ; flags 2
	db NONE ; flags 3
	db 3 ; ?
	db ATK_ANIM_DRAIN ; animation

	db 2 ; retreat cost
	db WR_FIRE ; weakness
	db NONE ; resistance
	tx MushroomName ; category
	db DEX_PARASECT ; Pokedex number
	db FALSE ; is Dark
	db 29 ; level
	length 1.0 ; length
	weight 29.5 ; weight
	tx ParasectLv29Description ; description
	db NONE ; AI info

VenonatLv12Card:
	db TYPE_PKMN_GRASS ; type
	dw $106f ; gfx
	tx VenonatName ; name
	db CIRCLE ; rarity
	db JUNGLE ; real set
	db PSYCHIC_BATTLE ; in-game set
	dw VENONAT_LV12
	db 40 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy GRASS, 1 ; energies
	tx StunSporeName ; name
	tx MayInflictParalysisDescription ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_NORMAL ; category
	dw VenonatLv12StunSporeEffectCommands ; effect commands
	db INFLICT_PARALYSIS  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_POWDER_EFFECT_CHANCE ; animation

	; attack 2
	energy GRASS, 1, COLORLESS, 1 ; energies
	tx LeechLifeName ; name
	tx LeechLifeDescription ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_NORMAL ; category
	dw VenonatLv12LeechLifeEffectCommands ; effect commands
	db NONE ; flags 1
	db HEAL_USER  ; flags 2
	db NONE ; flags 3
	db 3 ; ?
	db ATK_ANIM_DRAIN ; animation

	db 1 ; retreat cost
	db WR_FIRE ; weakness
	db NONE ; resistance
	tx InsectName ; category
	db DEX_VENONAT ; Pokedex number
	db FALSE ; is Dark
	db 12 ; level
	length 1.0 ; length
	weight 30.0 ; weight
	tx VenonatLv12Description ; description
	db AI_INFO_UNK_03 | HAS_EVOLUTION ; AI info

VenonatLv15Card:
	db TYPE_PKMN_GRASS ; type
	dw $9000 ; gfx
	tx VenonatName ; name
	db CIRCLE ; rarity
	db EXPANSION_SHEET ; real set
	db BEGINNING_POKEMON ; in-game set
	dw VENONAT_LV15
	db 50 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy COLORLESS, 1 ; energies
	tx DisableName ; name
	tx DisableDescription ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db DAMAGE_NORMAL ; category
	dw VenonatLv15DisableEffectCommands ; effect commands
	db NONE ; flags 1
	db NULLIFY_OR_WEAKEN_ATTACK  ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_AMNESIA ; animation

	; attack 2
	energy GRASS, 2 ; energies
	tx PsybeamName ; name
	tx MayInflictConfusionDescription ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_NORMAL ; category
	dw VenonatLv15PsybeamEffectCommands ; effect commands
	db INFLICT_CONFUSION  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_PSYBEAM ; animation

	db 1 ; retreat cost
	db WR_FIRE ; weakness
	db NONE ; resistance
	tx InsectName ; category
	db DEX_VENONAT ; Pokedex number
	db FALSE ; is Dark
	db 15 ; level
	length 1.0 ; length
	weight 30.0 ; weight
	tx VenonatLv15Description ; description
	db NONE | HAS_EVOLUTION ; AI info

VenomothLv22Card:
	db TYPE_PKMN_GRASS ; type
	dw $833b ; gfx
	tx VenomothName ; name
	db CIRCLE ; rarity
	db EXPANSION_SHEET ; real set
	db PSYCHIC_BATTLE ; in-game set
	dw VENOMOTH_LV22
	db 60 ; hp
	db STAGE1 ; stage
	tx VenonatName ; pre-evo name

	; attack 1
	energy GRASS, 2 ; energies
	tx StirUpTwisterName ; name
	tx StirUpTwisterDescription ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_NORMAL ; category
	dw VenomothLv22StirUpTwisterEffectCommands ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db SPECIAL_AI_HANDLING  ; flags 3
	db 0 ; ?
	db ATK_ANIM_WHIRLWIND ; animation

	; attack 2
	energy GRASS, 2, COLORLESS, 1 ; energies
	tx RainbowPowderName ; name
	tx RainbowPowderDescription ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_NORMAL ; category
	dw VenomothLv22RainbowPowderEffectCommands ; effect commands
	db INFLICT_POISON | INFLICT_PARALYSIS  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_POWDER_HIT_POISON ; animation

	db 0 ; retreat cost
	db WR_FIRE ; weakness
	db WR_FIGHTING ; resistance
	tx PoisonMothName ; category
	db DEX_VENOMOTH ; Pokedex number
	db FALSE ; is Dark
	db 22 ; level
	length 1.5 ; length
	weight 12.5 ; weight
	tx VenomothLv22Description ; description
	db NONE ; AI info

VenomothLv28Card:
	db TYPE_PKMN_GRASS ; type
	dw $10d8 ; gfx
	tx VenomothName ; name
	db STAR ; rarity
	db JUNGLE ; real set
	db BEGINNING_POKEMON ; in-game set
	dw VENOMOTH_LV28
	db 70 ; hp
	db STAGE1 ; stage
	tx VenonatName ; pre-evo name

	; attack 1
	energy 0 ; energies
	tx ShiftName ; name
	tx ShiftDescription ; description
	tx ShiftDescriptionCont ; description (cont)
	db 0 ; damage
	db POKEMON_POWER ; category
	dw VenomothLv28ShiftEffectCommands ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_PKMN_POWER_1 ; animation

	; attack 2
	energy GRASS, 2 ; energies
	tx VenomPowderName ; name
	tx VenomPowderDescription ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_NORMAL ; category
	dw VenomothLv28VenomPowderEffectCommands ; effect commands
	db INFLICT_POISON | INFLICT_CONFUSION  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_POWDER_EFFECT_CHANCE ; animation

	db 0 ; retreat cost
	db WR_FIRE ; weakness
	db WR_FIGHTING ; resistance
	tx PoisonMothName ; category
	db DEX_VENOMOTH ; Pokedex number
	db FALSE ; is Dark
	db 28 ; level
	length 1.5 ; length
	weight 12.5 ; weight
	tx VenomothLv28Description ; description
	db NONE ; AI info

BellsproutLv10Card:
	db TYPE_PKMN_GRASS ; type
	dw $930b ; gfx
	tx BellsproutName ; name
	db CIRCLE ; rarity
	db EXPANSION_SHEET ; real set
	db SKY_FLYING_POKEMON ; in-game set
	dw BELLSPROUT_LV10
	db 40 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy COLORLESS, 1 ; energies
	tx SwayName ; name
	tx PreventDamageCardEffectDescription ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db RESIDUAL ; category
	dw BellsproutLv10SwayEffectCommands ; effect commands
	db NONE ; flags 1
	db NULLIFY_OR_WEAKEN_ATTACK  ; flags 2
	db FLAG_3_BIT_2  ; flags 3
	db 0 ; ?
	db ATK_ANIM_PROTECT ; animation

	; attack 2
	energy GRASS, 1 ; energies
	tx StunSporeName ; name
	tx MayInflictParalysisAltDescription ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_NORMAL ; category
	dw BellsproutLv10StunSporeEffectCommands ; effect commands
	db INFLICT_PARALYSIS  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_STUN_SPORE ; animation

	db 1 ; retreat cost
	db WR_FIRE ; weakness
	db NONE ; resistance
	tx FlowerName ; category
	db DEX_BELLSPROUT ; Pokedex number
	db FALSE ; is Dark
	db 10 ; level
	length 0.7 ; length
	weight 4.0 ; weight
	tx BellsproutLv10Description ; description
	db NONE | HAS_EVOLUTION ; AI info

BellsproutLv11Card:
	db TYPE_PKMN_GRASS ; type
	dw $1141 ; gfx
	tx BellsproutName ; name
	db CIRCLE ; rarity
	db JUNGLE ; real set
	db ISLAND_OF_FOSSIL ; in-game set
	dw BELLSPROUT_LV11
	db 40 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy GRASS, 1 ; energies
	tx VineWhipAltName ; name
	dw NONE ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_NORMAL ; category
	dw NONE ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_WHIP ; animation

	; attack 2
	energy GRASS, 1 ; energies
	tx CallForFamilyName ; name
	tx CallForFamilyBellsproutDescription ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db RESIDUAL ; category
	dw BellsproutLv11CallForFamilyEffectCommands ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db SPECIAL_AI_HANDLING | FLAG_3_BIT_2  ; flags 3
	db 0 ; ?
	db ATK_ANIM_GLOW_EFFECT ; animation

	db 1 ; retreat cost
	db WR_FIRE ; weakness
	db NONE ; resistance
	tx FlowerName ; category
	db DEX_BELLSPROUT ; Pokedex number
	db FALSE ; is Dark
	db 11 ; level
	length 0.7 ; length
	weight 4.0 ; weight
	tx BellsproutLv11Description ; description
	db AI_INFO_UNK_03 | HAS_EVOLUTION ; AI info

WeepinbellLv23Card:
	db TYPE_PKMN_GRASS ; type
	dw $9374 ; gfx
	tx WeepinbellName ; name
	db DIAMOND ; rarity
	db EXPANSION_SHEET ; real set
	db SKY_FLYING_POKEMON ; in-game set
	dw WEEPINBELL_LV23
	db 60 ; hp
	db STAGE1 ; stage
	tx BellsproutName ; pre-evo name

	; attack 1
	energy GRASS, 1 ; energies
	tx RegenerationName ; name
	tx RegenerationDescription ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db RESIDUAL ; category
	dw WeepinbellLv23RegenerationEffectCommands ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db SPECIAL_AI_HANDLING | FLAG_3_BIT_2  ; flags 3
	db 0 ; ?
	db ATK_ANIM_RECOVER ; animation

	; attack 2
	energy GRASS, 2 ; energies
	tx DissolveName ; name
	tx DissolveDescription ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_NORMAL ; category
	dw WeepinbellLv23DissolveEffectCommands ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_GOO ; animation

	db 1 ; retreat cost
	db WR_FIRE ; weakness
	db NONE ; resistance
	tx FlycatcherName ; category
	db DEX_WEEPINBELL ; Pokedex number
	db FALSE ; is Dark
	db 23 ; level
	length 1.0 ; length
	weight 6.4 ; weight
	tx WeepinbellLv23Description ; description
	db NONE | HAS_EVOLUTION ; AI info

WeepinbellLv28Card:
	db TYPE_PKMN_GRASS ; type
	dw $11aa ; gfx
	tx WeepinbellName ; name
	db DIAMOND ; rarity
	db JUNGLE ; real set
	db ISLAND_OF_FOSSIL ; in-game set
	dw WEEPINBELL_LV28
	db 70 ; hp
	db STAGE1 ; stage
	tx BellsproutName ; pre-evo name

	; attack 1
	energy GRASS, 1 ; energies
	tx PoisonPowderName  ; name
	tx MayInflictPoisonDescription ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_NORMAL ; category
	dw WeepinbellLv28PoisonPowderEffectCommands ; effect commands
	db INFLICT_POISON  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_POWDER_EFFECT_CHANCE ; animation

	; attack 2
	energy GRASS, 2 ; energies
	tx RazorLeafName ; name
	dw NONE ; description
	dw NONE ; description (cont)
	db 30 ; damage
	db DAMAGE_NORMAL ; category
	dw NONE ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_RAZOR_LEAF ; animation

	db 1 ; retreat cost
	db WR_FIRE ; weakness
	db NONE ; resistance
	tx FlycatcherName ; category
	db DEX_WEEPINBELL ; Pokedex number
	db FALSE ; is Dark
	db 28 ; level
	length 1.0 ; length
	weight 6.4 ; weight
	tx WeepinbellLv28Description ; description
	db NONE | HAS_EVOLUTION ; AI info

VictreebelCard:
	db TYPE_PKMN_GRASS ; type
	dw $1213 ; gfx
	tx VictreebelName ; name
	db STAR ; rarity
	db JUNGLE ; real set
	db ISLAND_OF_FOSSIL ; in-game set
	dw VICTREEBEL
	db 80 ; hp
	db STAGE2 ; stage
	tx WeepinbellName ; pre-evo name

	; attack 1
	energy GRASS, 1 ; energies
	tx LureName ; name
	tx LureDescription ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db RESIDUAL ; category
	dw VictreebelLureEffectCommands ; effect commands
	db NONE ; flags 1
	db SWITCH_OPPONENT_POKEMON  ; flags 2
	db FLAG_3_BIT_2  ; flags 3
	db 0 ; ?
	db ATK_ANIM_LURE ; animation

	; attack 2
	energy GRASS, 2 ; energies
	tx AcidName ; name
	tx AcidDescription ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_NORMAL ; category
	dw VictreebelAcidEffectCommands ; effect commands
	db NONE ; flags 1
	db FLAG_2_BIT_6  ; flags 2
	db NONE ; flags 3
	db 1 ; ?
	db ATK_ANIM_GOO ; animation

	db 2 ; retreat cost
	db WR_FIRE ; weakness
	db NONE ; resistance
	tx FlycatcherName ; category
	db DEX_VICTREEBEL ; Pokedex number
	db FALSE ; is Dark
	db 42 ; level
	length 1.7 ; length
	weight 15.5 ; weight
	tx VictreebelDescription ; description
	db NONE ; AI info

GrimerLv10Card:
	db TYPE_PKMN_GRASS ; type
	dw $62f7 ; gfx
	tx GrimerName ; name
	db CIRCLE ; rarity
	db TEAM_ROCKET ; real set
	db WE_ARE_TEAM_ROCKET ; in-game set
	dw GRIMER_LV10
	db 40 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy GRASS, 1 ; energies
	tx PoisonGasName ; name
	tx InflictPoisonDescription ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db DAMAGE_NORMAL ; category
	dw GrimerLv10PoisonGasEffectCommands ; effect commands
	db INFLICT_POISON  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_POISON_GAS_COPY ; animation

	; attack 2
	energy GRASS, 2 ; energies
	tx StickyHandsName ; name
	tx StickyHandsDescription ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_PLUS ; category
	dw GrimerLv10StickyHandsEffectCommands ; effect commands
	db INFLICT_PARALYSIS  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_STICKY_HANDS ; animation

	db 1 ; retreat cost
	db WR_PSYCHIC ; weakness
	db NONE ; resistance
	tx SludgeCategoryName ; category
	db DEX_GRIMER ; Pokedex number
	db FALSE ; is Dark
	db 10 ; level
	length 0.9 ; length
	weight 30.0 ; weight
	tx GrimerLv10Description ; description
	db NONE | HAS_EVOLUTION ; AI info

GrimerLv17Card:
	db TYPE_PKMN_GRASS ; type
	dw $127c ; gfx
	tx GrimerName ; name
	db CIRCLE ; rarity
	db FOSSIL ; real set
	db ISLAND_OF_FOSSIL ; in-game set
	dw GRIMER_LV17
	db 50 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy COLORLESS, 1 ; energies
	tx NastyGooName ; name
	tx MayInflictParalysisDescription ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_NORMAL ; category
	dw GrimerLv17NastyGooEffectCommands ; effect commands
	db INFLICT_PARALYSIS  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_GOO ; animation

	; attack 2
	energy GRASS, 1 ; energies
	tx MinimizeName ; name
	tx MinimizeDescription ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db RESIDUAL ; category
	dw GrimerLv17MinimizeEffectCommands ; effect commands
	db NONE ; flags 1
	db NULLIFY_OR_WEAKEN_ATTACK  ; flags 2
	db FLAG_3_BIT_2  ; flags 3
	db 0 ; ?
	db ATK_ANIM_PROTECT ; animation

	db 1 ; retreat cost
	db WR_PSYCHIC ; weakness
	db NONE ; resistance
	tx SludgeCategoryName ; category
	db DEX_GRIMER ; Pokedex number
	db FALSE ; is Dark
	db 17 ; level
	length 0.9 ; length
	weight 30.0 ; weight
	tx GrimerLv17Description ; description
	db AI_INFO_UNK_03 | HAS_EVOLUTION ; AI info

MukCard:
	db TYPE_PKMN_GRASS ; type
	dw $12e5 ; gfx
	tx MukName ; name
	db STAR ; rarity
	db FOSSIL ; real set
	db ISLAND_OF_FOSSIL ; in-game set
	dw MUK
	db 70 ; hp
	db STAGE1 ; stage
	tx GrimerName ; pre-evo name

	; attack 1
	energy 0 ; energies
	tx ToxicGasName ; name
	tx ToxicGasDescription ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db POKEMON_POWER ; category
	dw MukToxicGasEffectCommands ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_PKMN_POWER_1 ; animation

	; attack 2
	energy GRASS, 3 ; energies
	tx SludgeMoveName ; name
	tx MayInflictPoisonDescription ; description
	dw NONE ; description (cont)
	db 30 ; damage
	db DAMAGE_NORMAL ; category
	dw MukSludgeMoveEffectCommands ; effect commands
	db INFLICT_POISON  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_GOO ; animation

	db 2 ; retreat cost
	db WR_PSYCHIC ; weakness
	db NONE ; resistance
	tx SludgeCategoryName ; category
	db DEX_MUK ; Pokedex number
	db FALSE ; is Dark
	db 34 ; level
	length 1.2 ; length
	weight 30.0 ; weight
	tx MukDescription ; description
	db NONE ; AI info

DarkMukCard:
	db TYPE_PKMN_GRASS ; type
	dw $6360 ; gfx
	tx DarkMukName ; name
	db DIAMOND ; rarity
	db TEAM_ROCKET ; real set
	db WE_ARE_TEAM_ROCKET ; in-game set
	dw DARK_MUK
	db 60 ; hp
	db STAGE1 ; stage
	tx GrimerName ; pre-evo name

	; attack 1
	energy 0 ; energies
	tx StickyGooName ; name
	tx StickyGooDescription ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db POKEMON_POWER ; category
	dw DarkMukStickyGooEffectCommands ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_NONE ; animation

	; attack 2
	energy GRASS, 2 ; energies
	tx SludgePunchName ; name
	tx InflictPoisonDescription ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_NORMAL ; category
	dw DarkMukSludgePunchEffectCommands ; effect commands
	db INFLICT_POISON  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_SLUDGE_PUNCH ; animation

	db 2 ; retreat cost
	db WR_PSYCHIC ; weakness
	db NONE ; resistance
	tx SludgeCategoryName ; category
	db DEX_MUK ; Pokedex number
	db TRUE ; is Dark
	db 25 ; level
	length 1.2 ; length
	weight 30.0 ; weight
	tx DarkMukDescription ; description
	db NONE ; AI info

ExeggcuteCard:
	db TYPE_PKMN_GRASS ; type
	dw $134e ; gfx
	tx ExeggcuteName ; name
	db CIRCLE ; rarity
	db JUNGLE ; real set
	db LEGENDARY_POWER ; in-game set
	dw EXEGGCUTE
	db 50 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy PSYCHIC, 1 ; energies
	tx HypnosisMoveName ; name
	tx InflictSleepDescription ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db DAMAGE_NORMAL ; category
	dw ExeggcuteHypnosisMoveEffectCommands ; effect commands
	db INFLICT_SLEEP  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_HYPNOSIS ; animation

	; attack 2
	energy GRASS, 2 ; energies
	tx LeechSeedAltName ; name
	tx LeechSeedDescription ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_NORMAL ; category
	dw ExeggcuteLeechSeedAltEffectCommands ; effect commands
	db NONE ; flags 1
	db HEAL_USER  ; flags 2
	db NONE ; flags 3
	db 1 ; ?
	db ATK_ANIM_DRAIN ; animation

	db 1 ; retreat cost
	db WR_FIRE ; weakness
	db NONE ; resistance
	tx EggName ; category
	db DEX_EXEGGCUTE ; Pokedex number
	db FALSE ; is Dark
	db 14 ; level
	length 0.4 ; length
	weight 2.5 ; weight
	tx ExeggcuteDescription ; description
	db AI_INFO_ENCOURAGE_EVO | HAS_EVOLUTION ; AI info

ExeggutorCard:
	db TYPE_PKMN_GRASS ; type
	dw $13cf ; gfx
	tx ExeggutorName ; name
	db DIAMOND ; rarity
	db JUNGLE ; real set
	db LEGENDARY_POWER ; in-game set
	dw EXEGGUTOR
	db 80 ; hp
	db STAGE1 ; stage
	tx ExeggcuteName ; pre-evo name

	; attack 1
	energy PSYCHIC, 1 ; energies
	tx TeleportName ; name
	tx TeleportDescription ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db RESIDUAL ; category
	dw ExeggutorTeleportEffectCommands ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db SPECIAL_AI_HANDLING | FLAG_3_BIT_2  ; flags 3
	db 0 ; ?
	db ATK_ANIM_TELEPORT ; animation

	; attack 2
	energy COLORLESS, 1 ; energies
	tx BigEggsplosionName ; name
	tx BigEggsplosionDescription ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_X ; category
	dw ExeggutorBigEggsplosionEffectCommands ; effect commands
	db NONE ; flags 1
	db ATTACHED_ENERGY_BOOST  ; flags 2
	db NONE ; flags 3
	db 3 ; ?
	db ATK_ANIM_BIG_HIT ; animation

	db 3 ; retreat cost
	db WR_FIRE ; weakness
	db NONE ; resistance
	tx CoconutName ; category
	db DEX_EXEGGUTOR ; Pokedex number
	db FALSE ; is Dark
	db 35 ; level
	length 2.0 ; length
	weight 120.0 ; weight
	tx ExeggutorDescription ; description
	db NONE ; AI info

KoffingLv12Card:
	db TYPE_PKMN_GRASS ; type
	dw $63c9 ; gfx
	tx KoffingName ; name
	db CIRCLE ; rarity
	db TEAM_ROCKET ; real set
	db TEAM_ROCKETS_AMBITION ; in-game set
	dw KOFFING_LV12
	db 40 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy COLORLESS, 1 ; energies
	tx TackleName ; name
	dw NONE ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_NORMAL ; category
	dw NONE ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_HIT ; animation

	; attack 2
	energy GRASS, 1, COLORLESS, 1 ; energies
	tx PoisonGasName ; name
	tx MayInflictPoisonAltDescription ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_NORMAL ; category
	dw KoffingLv12PoisonGasEffectCommands ; effect commands
	db INFLICT_POISON  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_POISON_GAS ; animation

	db 1 ; retreat cost
	db WR_PSYCHIC ; weakness
	db NONE ; resistance
	tx PoisonGasName ; category
	db DEX_KOFFING ; Pokedex number
	db FALSE ; is Dark
	db 12 ; level
	length 0.6 ; length
	weight 1.0 ; weight
	tx KoffingLv12Description ; description
	db NONE | HAS_EVOLUTION ; AI info

KoffingLv13Card:
	db TYPE_PKMN_GRASS ; type
	dw $143e ; gfx
	tx KoffingName ; name
	db CIRCLE ; rarity
	db BASE_SET ; real set
	db PSYCHIC_BATTLE ; in-game set
	dw KOFFING_LV13
	db 50 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy GRASS, 2 ; energies
	tx FoulGasName ; name
	tx FoulGasDescription ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_NORMAL ; category
	dw KoffingLv13FoulGasEffectCommands ; effect commands
	db INFLICT_POISON | INFLICT_CONFUSION  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_FOUL_GAS ; animation

	; attack 2
	energy 0 ; energies
	dw NONE ; name
	dw NONE ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db DAMAGE_NORMAL ; category
	dw NONE ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_NONE ; animation

	db 1 ; retreat cost
	db WR_PSYCHIC ; weakness
	db NONE ; resistance
	tx PoisonGasName ; category
	db DEX_KOFFING ; Pokedex number
	db FALSE ; is Dark
	db 13 ; level
	length 0.6 ; length
	weight 1.0 ; weight
	tx KoffingLv13Description ; description
	db NONE | HAS_EVOLUTION ; AI info

KoffingLv14Card:
	db TYPE_PKMN_GRASS ; type
	dw $c069 ; gfx
	tx KoffingName ; name
	db CIRCLE ; rarity
	db BULBASAUR_DECK ; real set
	db ISLAND_OF_FOSSIL ; in-game set
	dw KOFFING_LV14
	db 50 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy GRASS, 1 ; energies
	tx PoisonGasName ; name
	tx MayInflictPoisonAltDescription ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_NORMAL ; category
	dw KoffingLv14PoisonGasEffectCommands ; effect commands
	db INFLICT_POISON  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_POISON_GAS ; animation

	; attack 2
	energy GRASS, 2 ; energies
	tx ConfusionGasName ; name
	tx MayInflictConfusionDescription ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_NORMAL ; category
	dw KoffingLv14ConfusionGasEffectCommands ; effect commands
	db INFLICT_CONFUSION  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_FOUL_GAS ; animation

	db 1 ; retreat cost
	db WR_PSYCHIC ; weakness
	db NONE ; resistance
	tx PoisonGasName ; category
	db DEX_KOFFING ; Pokedex number
	db FALSE ; is Dark
	db 14 ; level
	length 0.6 ; length
	weight 1.0 ; weight
	tx KoffingLv14Description ; description
	db NONE | HAS_EVOLUTION ; AI info

WeezingLv26Card:
	db TYPE_PKMN_GRASS ; type
	dw $98d2 ; gfx
	tx WeezingName ; name
	db STAR ; rarity
	db EXPANSION_SHEET ; real set
	db SKY_FLYING_POKEMON ; in-game set
	dw WEEZING_LV26
	db 60 ; hp
	db STAGE1 ; stage
	tx KoffingName ; pre-evo name

	; attack 1
	energy 0 ; energies
	tx PoisonMistName ; name
	tx PoisonMistDescription ; description
	tx PoisonMistDescriptionCont ; description (cont)
	db 0 ; damage
	db POKEMON_POWER ; category
	dw WeezingLv26PoisonMistEffectCommands ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_GLOW_EFFECT ; animation

	; attack 2
	energy GRASS, 3 ; energies
	tx GasExplosionName ; name
	tx GasExplosionDescription ; description
	dw NONE ; description (cont)
	db 40 ; damage
	db DAMAGE_NORMAL ; category
	dw WeezingLv26GasExplosionEffectCommands ; effect commands
	db LOW_RECOIL  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 30 ; ?
	db ATK_ANIM_GAS_EXPLOSION ; animation

	db 2 ; retreat cost
	db WR_PSYCHIC ; weakness
	db NONE ; resistance
	tx PoisonGasName ; category
	db DEX_WEEZING ; Pokedex number
	db FALSE ; is Dark
	db 26 ; level
	length 1.2 ; length
	weight 9.5 ; weight
	tx WeezingLv26Description ; description
	db NONE ; AI info

WeezingLv27Card:
	db TYPE_PKMN_GRASS ; type
	dw $14a7 ; gfx
	tx WeezingName ; name
	db DIAMOND ; rarity
	db FOSSIL ; real set
	db ISLAND_OF_FOSSIL ; in-game set
	dw WEEZING_LV27
	db 60 ; hp
	db STAGE1 ; stage
	tx KoffingName ; pre-evo name

	; attack 1
	energy GRASS, 2 ; energies
	tx SmogName ; name
	tx MayInflictPoisonDescription ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_NORMAL ; category
	dw WeezingLv27SmogEffectCommands ; effect commands
	db INFLICT_POISON  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_SMOG ; animation

	; attack 2
	energy GRASS, 2, COLORLESS, 1 ; energies
	tx SelfdestructName ; name
	tx Selfdestruct60DamageDescription ; description
	dw NONE ; description (cont)
	db 60 ; damage
	db DAMAGE_NORMAL ; category
	dw WeezingLv27SelfdestructEffectCommands ; effect commands
	db HIGH_RECOIL  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 60 ; ?
	db ATK_ANIM_SELFDESTRUCT ; animation

	db 1 ; retreat cost
	db WR_PSYCHIC ; weakness
	db NONE ; resistance
	tx PoisonGasName ; category
	db DEX_WEEZING ; Pokedex number
	db FALSE ; is Dark
	db 27 ; level
	length 1.2 ; length
	weight 9.5 ; weight
	tx WeezingLv27Description ; description
	db NONE ; AI info

DarkWeezingCard:
	db TYPE_PKMN_GRASS ; type
	dw $6432 ; gfx
	tx DarkWeezingName ; name
	db STAR ; rarity
	db TEAM_ROCKET ; real set
	db TEAM_ROCKETS_AMBITION ; in-game set
	dw DARK_WEEZING
	db 60 ; hp
	db STAGE1 ; stage
	tx KoffingName ; pre-evo name

	; attack 1
	energy GRASS, 1, COLORLESS, 1 ; energies
	tx MassExplosionName ; name
	tx MassExplosionDescription ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_X ; category
	dw DarkWeezingMassExplosionEffectCommands ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db SPECIAL_AI_HANDLING  ; flags 3
	db 0 ; ?
	db ATK_ANIM_MASS_EXPLOSION ; animation

	; attack 2
	energy GRASS, 3 ; energies
	tx StunGasName ; name
	tx StunGasDescription ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_NORMAL ; category
	dw DarkWeezingStunGasEffectCommands ; effect commands
	db INFLICT_POISON | INFLICT_PARALYSIS  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_POISON_GAS ; animation

	db 1 ; retreat cost
	db WR_PSYCHIC ; weakness
	db NONE ; resistance
	tx PoisonGasName ; category
	db DEX_WEEZING ; Pokedex number
	db TRUE ; is Dark
	db 24 ; level
	length 1.2 ; length
	weight 9.5 ; weight
	tx DarkWeezingDescription ; description
	db NONE ; AI info

TangelaLv8Card:
	db TYPE_PKMN_GRASS ; type
	dw $151e ; gfx
	tx TangelaName ; name
	db DIAMOND ; rarity
	db BASE_SET ; real set
	db BEGINNING_POKEMON ; in-game set
	dw TANGELA_LV8
	db 50 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy GRASS, 1, COLORLESS, 1 ; energies
	tx BindName ; name
	tx MayInflictParalysisDescription ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_NORMAL ; category
	dw TangelaLv8BindEffectCommands ; effect commands
	db INFLICT_PARALYSIS  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_HIT ; animation

	; attack 2
	energy GRASS, 3 ; energies
	tx PoisonPowderName  ; name
	tx InflictPoisonDescription ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_NORMAL ; category
	dw TangelaLv8PoisonPowderEffectCommands ; effect commands
	db INFLICT_POISON  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_POWDER_HIT_POISON ; animation

	db 2 ; retreat cost
	db WR_FIRE ; weakness
	db NONE ; resistance
	tx VineName ; category
	db DEX_TANGELA ; Pokedex number
	db FALSE ; is Dark
	db 8 ; level
	length 1.0 ; length
	weight 35.0 ; weight
	tx TangelaLv8Description ; description
	db NONE ; AI info

TangelaLv12Card:
	db TYPE_PKMN_GRASS ; type
	dw $1593 ; gfx
	tx TangelaName ; name
	db DIAMOND ; rarity
	db GB ; real set
	db PSYCHIC_BATTLE ; in-game set
	dw TANGELA_LV12
	db 50 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy GRASS, 1 ; energies
	tx StunSporeName ; name
	tx MayInflictParalysisDescription ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_NORMAL ; category
	dw TangelaLv12StunSporeEffectCommands ; effect commands
	db INFLICT_PARALYSIS  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_POWDER_EFFECT_CHANCE ; animation

	; attack 2
	energy GRASS, 2, COLORLESS, 1 ; energies
	tx PoisonWhipName ; name
	tx InflictPoisonDescription ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_NORMAL ; category
	dw TangelaLv12PoisonWhipEffectCommands ; effect commands
	db INFLICT_POISON  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_POISON_WHIP ; animation

	db 2 ; retreat cost
	db WR_FIRE ; weakness
	db NONE ; resistance
	tx VineName ; category
	db DEX_TANGELA ; Pokedex number
	db FALSE ; is Dark
	db 12 ; level
	length 1.0 ; length
	weight 35.0 ; weight
	tx TangelaLv12Description ; description
	db NONE ; AI info

ScytherLv23Card:
	db TYPE_PKMN_GRASS ; type
	dw $9ba2 ; gfx
	tx ScytherName ; name
	db STAR ; rarity
	db EXPANSION_SHEET ; real set
	db LEGENDARY_POWER ; in-game set
	dw SCYTHER_LV23
	db 60 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy GRASS, 2 ; energies
	tx SlashingStrikeName ; name
	tx SlashingStrikeDescription ; description
	dw NONE ; description (cont)
	db 40 ; damage
	db DAMAGE_NORMAL ; category
	dw ScytherLv23SlashingStrikeEffectCommands ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_HIT ; animation

	; attack 2
	energy 0 ; energies
	dw NONE ; name
	dw NONE ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db DAMAGE_NORMAL ; category
	dw NONE ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_NONE ; animation

	db 1 ; retreat cost
	db WR_FIRE ; weakness
	db WR_FIGHTING ; resistance
	tx MantisName ; category
	db DEX_SCYTHER ; Pokedex number
	db FALSE ; is Dark
	db 23 ; level
	length 1.5 ; length
	weight 56.0 ; weight
	tx ScytherLv23Description ; description
	db NONE ; AI info

ScytherLv25Card:
	db TYPE_PKMN_GRASS ; type
	dw $15fc ; gfx
	tx ScytherName ; name
	db STAR ; rarity
	db JUNGLE ; real set
	db WE_ARE_TEAM_ROCKET ; in-game set
	dw SCYTHER_LV25
	db 70 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy GRASS, 1 ; energies
	tx SwordsDanceName ; name
	tx SwordsDanceDescription ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db RESIDUAL ; category
	dw ScytherLv25SwordsDanceEffectCommands ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db SPECIAL_AI_HANDLING | FLAG_3_BIT_2  ; flags 3
	db 0 ; ?
	db ATK_ANIM_GLOW_EFFECT ; animation

	; attack 2
	energy COLORLESS, 3 ; energies
	tx SlashName ; name
	dw NONE ; description
	dw NONE ; description (cont)
	db 30 ; damage
	db DAMAGE_NORMAL ; category
	dw NONE ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_SLASH ; animation

	db 0 ; retreat cost
	db WR_FIRE ; weakness
	db WR_FIGHTING ; resistance
	tx MantisName ; category
	db DEX_SCYTHER ; Pokedex number
	db FALSE ; is Dark
	db 25 ; level
	length 1.5 ; length
	weight 56.0 ; weight
	tx ScytherLv25Description ; description
	db NONE ; AI info

PinsirLv15Card:
	db TYPE_PKMN_GRASS ; type
	dw $7ecf ; gfx
	tx PinsirName ; name
	db DIAMOND ; rarity
	db EXPANSION_SHEET ; real set
	db TEAM_ROCKETS_AMBITION ; in-game set
	dw PINSIR_LV15
	db 50 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy GRASS, 1 ; energies
	tx SlicingThrowName ; name
	tx IfHeadsDo10DamageDescription ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_PLUS ; category
	dw PinsirLv15SlicingThrowEffectCommands ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_HIT ; animation

	; attack 2
	energy COLORLESS, 3 ; energies
	tx SlashName ; name
	dw NONE ; description
	dw NONE ; description (cont)
	db 30 ; damage
	db DAMAGE_NORMAL ; category
	dw NONE ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_SLASH ; animation

	db 1 ; retreat cost
	db WR_FIRE ; weakness
	db NONE ; resistance
	tx StagbeetleName ; category
	db DEX_PINSIR ; Pokedex number
	db FALSE ; is Dark
	db 15 ; level
	length 1.5 ; length
	weight 55.0 ; weight
	tx PinsirLv15Description ; description
	db NONE ; AI info

PinsirLv24Card:
	db TYPE_PKMN_GRASS ; type
	dw $1665 ; gfx
	tx PinsirName ; name
	db STAR ; rarity
	db JUNGLE ; real set
	db ISLAND_OF_FOSSIL ; in-game set
	dw PINSIR_LV24
	db 60 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy GRASS, 2 ; energies
	tx IrongripName ; name
	tx MayInflictParalysisDescription ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_NORMAL ; category
	dw PinsirLv24IrongripEffectCommands ; effect commands
	db INFLICT_PARALYSIS  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_HIT_EFFECT ; animation

	; attack 2
	energy GRASS, 2, COLORLESS, 2 ; energies
	tx GuillotineName ; name
	dw NONE ; description
	dw NONE ; description (cont)
	db 50 ; damage
	db DAMAGE_NORMAL ; category
	dw NONE ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_GUILLOTINE ; animation

	db 1 ; retreat cost
	db WR_FIRE ; weakness
	db NONE ; resistance
	tx StagbeetleName ; category
	db DEX_PINSIR ; Pokedex number
	db FALSE ; is Dark
	db 24 ; level
	length 1.5 ; length
	weight 55.0 ; weight
	tx PinsirLv24Description ; description
	db NONE ; AI info

CharmanderLv9Card:
	db TYPE_PKMN_FIRE ; type
	dw $59aa ; gfx
	tx CharmanderName ; name
	db CIRCLE ; rarity
	db TEAM_ROCKET ; real set
	db WE_ARE_TEAM_ROCKET ; in-game set
	dw CHARMANDER_LV9
	db 40 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy 0 ; energies
	tx GatherFireName ; name
	tx GatherFireDescription ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db POKEMON_POWER ; category
	dw CharmanderLv9GatherFireEffectCommands ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_GLOW_EFFECT ; animation

	; attack 2
	energy FIRE, 1 ; energies
	tx FireTailName ; name
	dw NONE ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_NORMAL ; category
	dw NONE ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_BIG_FLAME ; animation

	db 1 ; retreat cost
	db WR_WATER ; weakness
	db NONE ; resistance
	tx LizardName ; category
	db DEX_CHARMANDER ; Pokedex number
	db FALSE ; is Dark
	db 9 ; level
	length 0.6 ; length
	weight 8.5 ; weight
	tx CharmanderLv9Description ; description
	db NONE | HAS_EVOLUTION ; AI info

CharmanderLv10Card:
	db TYPE_PKMN_FIRE ; type
	dw $16ce ; gfx
	tx CharmanderName ; name
	db CIRCLE ; rarity
	db BASE_SET ; real set
	db BEGINNING_POKEMON ; in-game set
	dw CHARMANDER_LV10
	db 50 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy COLORLESS, 1 ; energies
	tx ScratchName ; name
	dw NONE ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_NORMAL ; category
	dw NONE ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_SLASH ; animation

	; attack 2
	energy FIRE, 1, COLORLESS, 1 ; energies
	tx EmberName ; name
	tx DiscardOneFireEnergyDescription ; description
	dw NONE ; description (cont)
	db 30 ; damage
	db DAMAGE_NORMAL ; category
	dw CharmanderLv10EmberEffectCommands ; effect commands
	db NONE ; flags 1
	db DISCARD_ENERGY  ; flags 2
	db NONE ; flags 3
	db 3 ; ?
	db ATK_ANIM_SMALL_FLAME ; animation

	db 1 ; retreat cost
	db WR_WATER ; weakness
	db NONE ; resistance
	tx LizardName ; category
	db DEX_CHARMANDER ; Pokedex number
	db FALSE ; is Dark
	db 10 ; level
	length 0.6 ; length
	weight 8.5 ; weight
	tx CharmanderLv10Description ; description
	db AI_INFO_UNK_05 | HAS_EVOLUTION ; AI info

CharmanderLv12Card:
	db TYPE_PKMN_FIRE ; type
	dw $71a6 ; gfx
	tx CharmanderName ; name
	db DIAMOND ; rarity
	db EXPANSION_SHEET ; real set
	db PSYCHIC_BATTLE ; in-game set
	dw CHARMANDER_LV12
	db 50 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy COLORLESS, 1 ; energies
	tx GrowlName ; name
	tx GrowlDescription ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db DAMAGE_NORMAL ; category
	dw CharmanderLv12GrowlEffectCommands ; effect commands
	db NONE ; flags 1
	db NULLIFY_OR_WEAKEN_ATTACK  ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_SUPERSONIC ; animation

	; attack 2
	energy FIRE, 2 ; energies
	tx FireTailName ; name
	dw NONE ; description
	dw NONE ; description (cont)
	db 30 ; damage
	db DAMAGE_NORMAL ; category
	dw NONE ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_BIG_FLAME ; animation

	db 1 ; retreat cost
	db WR_WATER ; weakness
	db NONE ; resistance
	tx LizardName ; category
	db DEX_CHARMANDER ; Pokedex number
	db FALSE ; is Dark
	db 12 ; level
	length 0.6 ; length
	weight 8.5 ; weight
	tx CharmanderLv12Description ; description
	db NONE | HAS_EVOLUTION ; AI info

CharmeleonCard:
	db TYPE_PKMN_FIRE ; type
	dw $173d ; gfx
	tx CharmeleonName ; name
	db DIAMOND ; rarity
	db BASE_SET ; real set
	db BEGINNING_POKEMON ; in-game set
	dw CHARMELEON
	db 80 ; hp
	db STAGE1 ; stage
	tx CharmanderName ; pre-evo name

	; attack 1
	energy COLORLESS, 3 ; energies
	tx SlashName ; name
	dw NONE ; description
	dw NONE ; description (cont)
	db 30 ; damage
	db DAMAGE_NORMAL ; category
	dw NONE ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_SLASH ; animation

	; attack 2
	energy FIRE, 2, COLORLESS, 1 ; energies
	tx FlamethrowerName ; name
	tx DiscardOneFireEnergyDescription ; description
	dw NONE ; description (cont)
	db 50 ; damage
	db DAMAGE_NORMAL ; category
	dw CharmeleonFlamethrowerEffectCommands ; effect commands
	db NONE ; flags 1
	db DISCARD_ENERGY  ; flags 2
	db NONE ; flags 3
	db 3 ; ?
	db ATK_ANIM_BIG_FLAME ; animation

	db 1 ; retreat cost
	db WR_WATER ; weakness
	db NONE ; resistance
	tx FlameName ; category
	db DEX_CHARMELEON ; Pokedex number
	db FALSE ; is Dark
	db 32 ; level
	length 1.1 ; length
	weight 19.0 ; weight
	tx CharmeleonDescription ; description
	db AI_INFO_ENCOURAGE_EVO | HAS_EVOLUTION ; AI info

DarkCharmeleonCard:
	db TYPE_PKMN_FIRE ; type
	dw $5a13 ; gfx
	tx DarkCharmeleonName ; name
	db DIAMOND ; rarity
	db TEAM_ROCKET ; real set
	db WE_ARE_TEAM_ROCKET ; in-game set
	dw DARK_CHARMELEON
	db 50 ; hp
	db STAGE1 ; stage
	tx CharmanderName ; pre-evo name

	; attack 1
	energy COLORLESS, 2 ; energies
	tx TailSlapName ; name
	dw NONE ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_NORMAL ; category
	dw NONE ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_TAIL_SLAP ; animation

	; attack 2
	energy FIRE, 3 ; energies
	tx FireballName ; name
	tx FireballDescription ; description
	dw NONE ; description (cont)
	db 70 ; damage
	db DAMAGE_NORMAL ; category
	dw DarkCharmeleonFireballEffectCommands ; effect commands
	db NONE ; flags 1
	db DISCARD_ENERGY  ; flags 2
	db NONE ; flags 3
	db 3 ; ?
	db ATK_ANIM_FIREBALL ; animation

	db 2 ; retreat cost
	db WR_WATER ; weakness
	db NONE ; resistance
	tx FlameName ; category
	db DEX_CHARMELEON ; Pokedex number
	db TRUE ; is Dark
	db 23 ; level
	length 1.1 ; length
	weight 19.0 ; weight
	tx DarkCharmeleonDescription ; description
	db NONE | HAS_EVOLUTION ; AI info

CharizardLv76Card:
	db TYPE_PKMN_FIRE ; type
	dw $1800 ; gfx
	tx CharizardName ; name
	db STAR ; rarity
	db BASE_SET ; real set
	db BEGINNING_POKEMON ; in-game set
	dw CHARIZARD_LV76
	db 120 ; hp
	db STAGE2 ; stage
	tx CharmeleonName ; pre-evo name

	; attack 1
	energy 0 ; energies
	tx EnergyBurnName ; name
	tx EnergyBurnDescription ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db POKEMON_POWER ; category
	dw CharizardLv76EnergyBurnEffectCommands ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_PKMN_POWER_1 ; animation

	; attack 2
	energy FIRE, 4 ; energies
	tx FireSpinName ; name
	tx FireSpinDescription ; description
	dw NONE ; description (cont)
	db 100 ; damage
	db DAMAGE_NORMAL ; category
	dw CharizardLv76FireSpinEffectCommands ; effect commands
	db NONE ; flags 1
	db DISCARD_ENERGY  ; flags 2
	db NONE ; flags 3
	db 6 ; ?
	db ATK_ANIM_FIRE_SPIN ; animation

	db 3 ; retreat cost
	db WR_WATER ; weakness
	db WR_FIGHTING ; resistance
	tx FlameName ; category
	db DEX_CHARIZARD ; Pokedex number
	db FALSE ; is Dark
	db 76 ; level
	length 1.7 ; length
	weight 90.5 ; weight
	tx CharizardDescription ; description
	db NONE ; AI info

CharizardAltLv76Card:
	db TYPE_PKMN_FIRE ; type
	dw $a468 ; gfx
	tx CharizardName ; name
	db STAR ; rarity
	db PRO ; real set
	db PROMOTIONAL ; in-game set
	dw CHARIZARD_ALT_LV76
	db 120 ; hp
	db STAGE2 ; stage
	tx CharmeleonName ; pre-evo name

	; attack 1
	energy 0 ; energies
	tx EnergyBurnName ; name
	tx EnergyBurnDescription ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db POKEMON_POWER ; category
	dw CharizardAltLv76EnergyBurnEffectCommands ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_PKMN_POWER_1 ; animation

	; attack 2
	energy FIRE, 4 ; energies
	tx FireSpinName ; name
	tx FireSpinDescription ; description
	dw NONE ; description (cont)
	db 100 ; damage
	db DAMAGE_NORMAL ; category
	dw CharizardAltLv76FireSpinEffectCommands ; effect commands
	db NONE ; flags 1
	db DISCARD_ENERGY  ; flags 2
	db NONE ; flags 3
	db 6 ; ?
	db ATK_ANIM_FIRE_SPIN ; animation

	db 3 ; retreat cost
	db WR_WATER ; weakness
	db WR_FIGHTING ; resistance
	tx FlameName ; category
	db DEX_CHARIZARD ; Pokedex number
	db FALSE ; is Dark
	db 76 ; level
	length 1.7 ; length
	weight 90.5 ; weight
	tx CharizardAltDescription ; description
	db NONE ; AI info

DarkCharizardCard:
	db TYPE_PKMN_FIRE ; type
	dw $5a7c ; gfx
	tx DarkCharizardName ; name
	db STAR ; rarity
	db TEAM_ROCKET ; real set
	db WE_ARE_TEAM_ROCKET ; in-game set
	dw DARK_CHARIZARD
	db 80 ; hp
	db STAGE2 ; stage
	tx DarkCharmeleonName ; pre-evo name

	; attack 1
	energy COLORLESS, 1 ; energies
	tx NailFlickName ; name
	dw NONE ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_NORMAL ; category
	dw NONE ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_HIT ; animation

	; attack 2
	energy FIRE, 2 ; energies
	tx ContinuousFireballName ; name
	tx ContinuousFireballDescription ; description
	dw NONE ; description (cont)
	db 50 ; damage
	db DAMAGE_X ; category
	dw DarkCharizardContinuousFireballEffectCommands ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db SPECIAL_AI_HANDLING  ; flags 3
	db 0 ; ?
	db ATK_ANIM_CONTINUOUS_FIREBALL ; animation

	db 3 ; retreat cost
	db WR_WATER ; weakness
	db WR_FIGHTING ; resistance
	tx FlameName ; category
	db DEX_CHARIZARD ; Pokedex number
	db TRUE ; is Dark
	db 38 ; level
	length 1.7 ; length
	weight 90.5 ; weight
	tx DarkCharizardDescription ; description
	db NONE ; AI info

VulpixLv11Card:
	db TYPE_PKMN_FIRE ; type
	dw $1869 ; gfx
	tx VulpixName ; name
	db CIRCLE ; rarity
	db BASE_SET ; real set
	db BEGINNING_POKEMON ; in-game set
	dw VULPIX_LV11
	db 50 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy FIRE, 2 ; energies
	tx ConfuseRayName ; name
	tx MayInflictConfusionDescription ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_NORMAL ; category
	dw VulpixLv11ConfuseRayEffectCommands ; effect commands
	db INFLICT_CONFUSION  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_CONFUSE_RAY ; animation

	; attack 2
	energy 0 ; energies
	dw NONE ; name
	dw NONE ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db DAMAGE_NORMAL ; category
	dw NONE ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_NONE ; animation

	db 1 ; retreat cost
	db WR_WATER ; weakness
	db NONE ; resistance
	tx FoxName ; category
	db DEX_VULPIX ; Pokedex number
	db FALSE ; is Dark
	db 11 ; level
	length 0.6 ; length
	weight 9.9 ; weight
	tx VulpixLv11Description ; description
	db AI_INFO_ENCOURAGE_EVO | HAS_EVOLUTION ; AI info

VulpixLv13Card:
	db TYPE_PKMN_FIRE ; type
	dw $8f59 ; gfx
	tx VulpixName ; name
	db CIRCLE ; rarity
	db EXPANSION_SHEET ; real set
	db PSYCHIC_BATTLE ; in-game set
	dw VULPIX_LV13
	db 50 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy FIRE, 2 ; energies
	tx FoxFireName ; name
	tx FoxFireDescription ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_NORMAL ; category
	dw VulpixLv13FoxFireEffectCommands ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db SPECIAL_AI_HANDLING | FLAG_3_BIT_2  ; flags 3
	db 0 ; ?
	db ATK_ANIM_SMALL_FLAME ; animation

	; attack 2
	energy 0 ; energies
	dw NONE ; name
	dw NONE ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db DAMAGE_NORMAL ; category
	dw NONE ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_NONE ; animation

	db 1 ; retreat cost
	db WR_WATER ; weakness
	db NONE ; resistance
	tx FoxName ; category
	db DEX_VULPIX ; Pokedex number
	db FALSE ; is Dark
	db 13 ; level
	length 0.6 ; length
	weight 9.9 ; weight
	tx VulpixLv13Description ; description
	db NONE | HAS_EVOLUTION ; AI info

NinetalesLv32Card:
	db TYPE_PKMN_FIRE ; type
	dw $18d2 ; gfx
	tx NinetalesName ; name
	db STAR ; rarity
	db BASE_SET ; real set
	db BEGINNING_POKEMON ; in-game set
	dw NINETALES_LV32
	db 80 ; hp
	db STAGE1 ; stage
	tx VulpixName ; pre-evo name

	; attack 1
	energy COLORLESS, 2 ; energies
	tx LureAltName ; name
	tx LureDescription ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db RESIDUAL ; category
	dw NinetalesLv32LureAltEffectCommands ; effect commands
	db NONE ; flags 1
	db SWITCH_OPPONENT_POKEMON  ; flags 2
	db FLAG_3_BIT_2  ; flags 3
	db 0 ; ?
	db ATK_ANIM_LURE ; animation

	; attack 2
	energy FIRE, 4 ; energies
	tx FireBlastName ; name
	tx DiscardOneFireEnergyDescription ; description
	dw NONE ; description (cont)
	db 80 ; damage
	db DAMAGE_NORMAL ; category
	dw NinetalesLv32FireBlastEffectCommands ; effect commands
	db NONE ; flags 1
	db DISCARD_ENERGY  ; flags 2
	db NONE ; flags 3
	db 3 ; ?
	db ATK_ANIM_FIRE_SPIN ; animation

	db 1 ; retreat cost
	db WR_WATER ; weakness
	db NONE ; resistance
	tx FoxName ; category
	db DEX_NINETALES ; Pokedex number
	db FALSE ; is Dark
	db 32 ; level
	length 1.1 ; length
	weight 19.9 ; weight
	tx NinetalesLv32Description ; description
	db NONE ; AI info

NinetalesLv35Card:
	db TYPE_PKMN_FIRE ; type
	dw $193b ; gfx
	tx NinetalesName ; name
	db STAR ; rarity
	db GB ; real set
	db PSYCHIC_BATTLE ; in-game set
	dw NINETALES_LV35
	db 80 ; hp
	db STAGE1 ; stage
	tx VulpixName ; pre-evo name

	; attack 1
	energy FIRE, 2 ; energies
	tx MixUpName ; name
	tx MixUpDescription ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db RESIDUAL ; category
	dw NinetalesLv35MixUpEffectCommands ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db SPECIAL_AI_HANDLING | FLAG_3_BIT_2  ; flags 3
	db 0 ; ?
	db ATK_ANIM_GLOW_EFFECT ; animation

	; attack 2
	energy FIRE, 3 ; energies
	tx DancingEmbersName ; name
	tx DancingEmbersDescription ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_X ; category
	dw NinetalesLv35DancingEmbersEffectCommands ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_FIRE_SPIN ; animation

	db 1 ; retreat cost
	db WR_WATER ; weakness
	db NONE ; resistance
	tx FoxName ; category
	db DEX_NINETALES ; Pokedex number
	db FALSE ; is Dark
	db 35 ; level
	length 1.1 ; length
	weight 19.9 ; weight
	tx NinetalesLv35Description ; description
	db NONE ; AI info

DarkNinetalesCard:
	db TYPE_PKMN_FIRE ; type
	dw $c8d2 ; gfx
	tx DarkNinetalesName ; name
	db STAR ; rarity
	db GB ; real set
	db TEAM_ROCKETS_AMBITION ; in-game set
	dw DARK_NINETALES
	db 60 ; hp
	db STAGE1 ; stage
	tx VulpixName ; pre-evo name

	; attack 1
	energy FIRE, 1 ; energies
	tx PerplexName ; name
	tx PerplexDescription ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db RESIDUAL ; category
	dw DarkNinetalesPerplexEffectCommands ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db SPECIAL_AI_HANDLING | FLAG_3_BIT_2  ; flags 3
	db 0 ; ?
	db ATK_ANIM_PERPLEX ; animation

	; attack 2
	energy FIRE, 2, COLORLESS, 1 ; energies
	tx NineTailsName ; name
	tx NineTailsDescription ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_X ; category
	dw DarkNinetalesNineTailsEffectCommands ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_NINE_TAILS ; animation

	db 0 ; retreat cost
	db WR_WATER ; weakness
	db NONE ; resistance
	tx FoxName ; category
	db DEX_NINETALES ; Pokedex number
	db TRUE ; is Dark
	db 28 ; level
	length 1.1 ; length
	weight 19.9 ; weight
	tx DarkNinetalesDescription ; description
	db NONE ; AI info

GrowlitheLv12Card:
	db TYPE_PKMN_FIRE ; type
	dw $c0d2 ; gfx
	tx GrowlitheName ; name
	db DIAMOND ; rarity
	db SQUIRTLE_DECK ; real set
	db BEGINNING_POKEMON ; in-game set
	dw GROWLITHE_LV12
	db 40 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy COLORLESS, 1 ; energies
	tx LungeName ; name
	tx IfTailsDoNothingAltDescription ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_NORMAL ; category
	dw GrowlitheLv12LungeEffectCommands ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_HIT ; animation

	; attack 2
	energy FIRE, 1, COLORLESS, 1 ; energies
	tx EmberName ; name
	tx DiscardOneFireEnergyDescription ; description
	dw NONE ; description (cont)
	db 30 ; damage
	db DAMAGE_NORMAL ; category
	dw GrowlitheLv12EmberEffectCommands ; effect commands
	db NONE ; flags 1
	db DISCARD_ENERGY  ; flags 2
	db NONE ; flags 3
	db 3 ; ?
	db ATK_ANIM_SMALL_FLAME ; animation

	db 1 ; retreat cost
	db WR_WATER ; weakness
	db NONE ; resistance
	tx PuppyName ; category
	db DEX_GROWLITHE ; Pokedex number
	db FALSE ; is Dark
	db 12 ; level
	length 0.7 ; length
	weight 19.0 ; weight
	tx GrowlitheLv12Description ; description
	db NONE | HAS_EVOLUTION ; AI info

GrowlitheLv16Card:
	db TYPE_PKMN_FIRE ; type
	dw $90fa ; gfx
	tx GrowlitheName ; name
	db CIRCLE ; rarity
	db EXPANSION_SHEET ; real set
	db TEAM_ROCKETS_AMBITION ; in-game set
	dw GROWLITHE_LV16
	db 50 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy COLORLESS, 2 ; energies
	tx ErrandRunningName ; name
	tx ErrandRunningDescription ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db RESIDUAL ; category
	dw GrowlitheLv16ErrandRunningEffectCommands ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db SPECIAL_AI_HANDLING | FLAG_3_BIT_2  ; flags 3
	db 0 ; ?
	db ATK_ANIM_GLOW_EFFECT ; animation

	; attack 2
	energy FIRE, 1, COLORLESS, 1 ; energies
	tx EmberName ; name
	tx DiscardOneFireEnergyAltDescription ; description
	dw NONE ; description (cont)
	db 30 ; damage
	db DAMAGE_NORMAL ; category
	dw GrowlitheLv16EmberEffectCommands ; effect commands
	db NONE ; flags 1
	db DISCARD_ENERGY  ; flags 2
	db NONE ; flags 3
	db 3 ; ?
	db ATK_ANIM_BIG_FLAME ; animation

	db 1 ; retreat cost
	db WR_WATER ; weakness
	db NONE ; resistance
	tx PuppyName ; category
	db DEX_GROWLITHE ; Pokedex number
	db FALSE ; is Dark
	db 16 ; level
	length 0.7 ; length
	weight 19.0 ; weight
	tx GrowlitheLv16Description ; description
	db NONE | HAS_EVOLUTION ; AI info

GrowlitheLv18Card:
	db TYPE_PKMN_FIRE ; type
	dw $19ac ; gfx
	tx GrowlitheName ; name
	db DIAMOND ; rarity
	db BASE_SET ; real set
	db PSYCHIC_BATTLE ; in-game set
	dw GROWLITHE_LV18
	db 60 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy FIRE, 1, COLORLESS, 1 ; energies
	tx FlareName ; name
	dw NONE ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_NORMAL ; category
	dw NONE ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_SMALL_FLAME ; animation

	; attack 2
	energy 0 ; energies
	dw NONE ; name
	dw NONE ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db DAMAGE_NORMAL ; category
	dw NONE ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_NONE ; animation

	db 1 ; retreat cost
	db WR_WATER ; weakness
	db NONE ; resistance
	tx PuppyName ; category
	db DEX_GROWLITHE ; Pokedex number
	db FALSE ; is Dark
	db 18 ; level
	length 0.7 ; length
	weight 19.0 ; weight
	tx GrowlitheLv18Description ; description
	db NONE | HAS_EVOLUTION ; AI info

ArcanineLv34Card:
	db TYPE_PKMN_FIRE ; type
	dw $1a15 ; gfx
	tx ArcanineName ; name
	db PROMOSTAR ; rarity
	db PRO ; real set
	db PROMOTIONAL ; in-game set
	dw ARCANINE_LV34
	db 70 ; hp
	db STAGE1 ; stage
	tx GrowlitheName ; pre-evo name

	; attack 1
	energy COLORLESS, 2 ; energies
	tx QuickAttackName ; name
	tx QuickAttackDescription ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_PLUS ; category
	dw ArcanineLv34QuickAttackEffectCommands ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_QUICK_ATTACK ; animation

	; attack 2
	energy FIRE, 2 ; energies
	tx FlamesOfRageName ; name
	tx FlamesOfRageDescription ; description
	dw NONE ; description (cont)
	db 40 ; damage
	db DAMAGE_PLUS ; category
	dw ArcanineLv34FlamesOfRageEffectCommands ; effect commands
	db NONE ; flags 1
	db DISCARD_ENERGY  ; flags 2
	db BOOST_IF_TAKEN_DAMAGE  ; flags 3
	db 6 ; ?
	db ATK_ANIM_FIRE_SPIN ; animation

	db 1 ; retreat cost
	db WR_WATER ; weakness
	db NONE ; resistance
	tx LegendaryName ; category
	db DEX_ARCANINE ; Pokedex number
	db FALSE ; is Dark
	db 34 ; level
	length 1.9 ; length
	weight 155.0 ; weight
	tx ArcanineLv34Description ; description
	db NONE ; AI info

ArcanineLv35Card:
	db TYPE_PKMN_FIRE ; type
	dw $c1a4 ; gfx
	tx ArcanineName ; name
	db STAR ; rarity
	db SQUIRTLE_DECK ; real set
	db BEGINNING_POKEMON ; in-game set
	dw ARCANINE_LV35
	db 70 ; hp
	db STAGE1 ; stage
	tx GrowlitheName ; pre-evo name

	; attack 1
	energy FIRE, 2, COLORLESS, 1 ; energies
	tx TakeDownName ; name
	tx Do20DamageToSelfDescription ; description
	dw NONE ; description (cont)
	db 50 ; damage
	db DAMAGE_NORMAL ; category
	dw ArcanineLv35TakeDownEffectCommands ; effect commands
	db LOW_RECOIL  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 20 ; ?
	db ATK_ANIM_HIT_RECOIL ; animation

	; attack 2
	energy 0 ; energies
	dw NONE ; name
	dw NONE ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db DAMAGE_NORMAL ; category
	dw NONE ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_NONE ; animation

	db 2 ; retreat cost
	db WR_WATER ; weakness
	db NONE ; resistance
	tx LegendaryName ; category
	db DEX_ARCANINE ; Pokedex number
	db FALSE ; is Dark
	db 35 ; level
	length 1.9 ; length
	weight 155.0 ; weight
	tx ArcanineLv35Description ; description
	db NONE ; AI info

ArcanineLv45Card:
	db TYPE_PKMN_FIRE ; type
	dw $1a82 ; gfx
	tx ArcanineName ; name
	db STAR ; rarity
	db BASE_SET ; real set
	db LEGENDARY_POWER ; in-game set
	dw ARCANINE_LV45
	db 100 ; hp
	db STAGE1 ; stage
	tx GrowlitheName ; pre-evo name

	; attack 1
	energy FIRE, 2, COLORLESS, 1 ; energies
	tx FlamethrowerName ; name
	tx DiscardOneFireEnergyDescription ; description
	dw NONE ; description (cont)
	db 50 ; damage
	db DAMAGE_NORMAL ; category
	dw ArcanineLv45FlamethrowerEffectCommands ; effect commands
	db NONE ; flags 1
	db DISCARD_ENERGY  ; flags 2
	db NONE ; flags 3
	db 3 ; ?
	db ATK_ANIM_BIG_FLAME ; animation

	; attack 2
	energy FIRE, 2, COLORLESS, 2 ; energies
	tx TakeDownName ; name
	tx Do30DamageToSelfDescription ; description
	dw NONE ; description (cont)
	db 80 ; damage
	db DAMAGE_NORMAL ; category
	dw ArcanineLv45TakeDownEffectCommands ; effect commands
	db LOW_RECOIL  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 30 ; ?
	db ATK_ANIM_HIT_RECOIL ; animation

	db 3 ; retreat cost
	db WR_WATER ; weakness
	db NONE ; resistance
	tx LegendaryName ; category
	db DEX_ARCANINE ; Pokedex number
	db FALSE ; is Dark
	db 45 ; level
	length 1.9 ; length
	weight 155.0 ; weight
	tx ArcanineLv45Description ; description
	db NONE ; AI info

PonytaLv8Card:
	db TYPE_PKMN_FIRE ; type
	dw $94af ; gfx
	tx PonytaName ; name
	db CIRCLE ; rarity
	db EXPANSION_SHEET ; real set
	db SKY_FLYING_POKEMON ; in-game set
	dw PONYTA_LV8
	db 40 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy COLORLESS, 1 ; energies
	tx SmashKickName ; name
	dw NONE ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_NORMAL ; category
	dw NONE ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_HIT ; animation

	; attack 2
	energy FIRE, 1 ; energies
	tx FireworksName ; name
	tx FireworksDescription ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_NORMAL ; category
	dw PonytaLv8FireworksEffectCommands ; effect commands
	db NONE ; flags 1
	db DISCARD_ENERGY  ; flags 2
	db NONE ; flags 3
	db 2 ; ?
	db ATK_ANIM_SMALL_FLAME ; animation

	db 0 ; retreat cost
	db WR_WATER ; weakness
	db NONE ; resistance
	tx FireHorseName ; category
	db DEX_PONYTA ; Pokedex number
	db FALSE ; is Dark
	db 8 ; level
	length 1.0 ; length
	weight 30.0 ; weight
	tx PonytaLv8Description ; description
	db NONE | HAS_EVOLUTION ; AI info

PonytaLv10Card:
	db TYPE_PKMN_FIRE ; type
	dw $1aeb ; gfx
	tx PonytaName ; name
	db CIRCLE ; rarity
	db BASE_SET ; real set
	db BEGINNING_POKEMON ; in-game set
	dw PONYTA_LV10
	db 40 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy COLORLESS, 2 ; energies
	tx SmashKickName ; name
	dw NONE ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_NORMAL ; category
	dw NONE ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_LEG_SWEEP ; animation

	; attack 2
	energy FIRE, 2 ; energies
	tx FireTailName ; name
	dw NONE ; description
	dw NONE ; description (cont)
	db 30 ; damage
	db DAMAGE_NORMAL ; category
	dw NONE ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_BIG_FLAME ; animation

	db 1 ; retreat cost
	db WR_WATER ; weakness
	db NONE ; resistance
	tx FireHorseName ; category
	db DEX_PONYTA ; Pokedex number
	db FALSE ; is Dark
	db 10 ; level
	length 1.0 ; length
	weight 30.0 ; weight
	tx PonytaLv10Description ; description
	db NONE | HAS_EVOLUTION ; AI info

PonytaLv15Card:
	db TYPE_PKMN_FIRE ; type
	dw $5ae5 ; gfx
	tx PonytaName ; name
	db CIRCLE ; rarity
	db TEAM_ROCKET ; real set
	db WE_ARE_TEAM_ROCKET ; in-game set
	dw PONYTA_LV15
	db 50 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy FIRE, 1, COLORLESS, 1 ; energies
	tx EmberName ; name
	tx DiscardOneFireEnergyDescription ; description
	dw NONE ; description (cont)
	db 30 ; damage
	db DAMAGE_NORMAL ; category
	dw PonytaLv15EmberEffectCommands ; effect commands
	db NONE ; flags 1
	db DISCARD_ENERGY  ; flags 2
	db NONE ; flags 3
	db 3 ; ?
	db ATK_ANIM_SMALL_FLAME ; animation

	; attack 2
	energy 0 ; energies
	dw NONE ; name
	dw NONE ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db DAMAGE_NORMAL ; category
	dw NONE ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_NONE ; animation

	db 1 ; retreat cost
	db WR_WATER ; weakness
	db NONE ; resistance
	tx FireHorseName ; category
	db DEX_PONYTA ; Pokedex number
	db FALSE ; is Dark
	db 15 ; level
	length 1.0 ; length
	weight 30.0 ; weight
	tx PonytaLv15Description ; description
	db NONE | HAS_EVOLUTION ; AI info

RapidashLv30Card:
	db TYPE_PKMN_FIRE ; type
	dw $7bf9 ; gfx
	tx RapidashName ; name
	db DIAMOND ; rarity
	db EXPANSION_SHEET ; real set
	db SKY_FLYING_POKEMON ; in-game set
	dw RAPIDASH_LV30
	db 60 ; hp
	db STAGE1 ; stage
	tx PonytaName ; pre-evo name

	; attack 1
	energy FIRE, 1 ; energies
	tx FlameInfernoName ; name
	tx FlameInfernoDescription ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_PLUS ; category
	dw RapidashLv30FlameInfernoEffectCommands ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db SPECIAL_AI_HANDLING  ; flags 3
	db 0 ; ?
	db ATK_ANIM_FIRE_SPIN ; animation

	; attack 2
	energy COLORLESS, 2 ; energies
	tx KickAwayName ; name
	tx SwitchWithBenchedMonDescription ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_NORMAL ; category
	dw RapidashLv30KickAwayEffectCommands ; effect commands
	db NONE ; flags 1
	db SWITCH_OPPONENT_POKEMON  ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_HIT ; animation

	db 0 ; retreat cost
	db WR_WATER ; weakness
	db NONE ; resistance
	tx FireHorseName ; category
	db DEX_RAPIDASH ; Pokedex number
	db FALSE ; is Dark
	db 30 ; level
	length 1.7 ; length
	weight 95.0 ; weight
	tx RapidashLv30Description ; description
	db NONE ; AI info

RapidashLv33Card:
	db TYPE_PKMN_FIRE ; type
	dw $1b66 ; gfx
	tx RapidashName ; name
	db DIAMOND ; rarity
	db JUNGLE ; real set
	db BEGINNING_POKEMON ; in-game set
	dw RAPIDASH_LV33
	db 70 ; hp
	db STAGE1 ; stage
	tx PonytaName ; pre-evo name

	; attack 1
	energy COLORLESS, 2 ; energies
	tx StompName ; name
	tx StompDescription ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_PLUS ; category
	dw RapidashLv33StompEffectCommands ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_HIT ; animation

	; attack 2
	energy FIRE, 2, COLORLESS, 1 ; energies
	tx AgilityName ; name
	tx AgilityDescription ; description
	dw NONE ; description (cont)
	db 30 ; damage
	db DAMAGE_NORMAL ; category
	dw RapidashLv33AgilityEffectCommands ; effect commands
	db NONE ; flags 1
	db NULLIFY_OR_WEAKEN_ATTACK | FLAG_2_BIT_6  ; flags 2
	db FLAG_3_BIT_2  ; flags 3
	db 0 ; ?
	db ATK_ANIM_QUICK_ATTACK ; animation

	db 0 ; retreat cost
	db WR_WATER ; weakness
	db NONE ; resistance
	tx FireHorseName ; category
	db DEX_RAPIDASH ; Pokedex number
	db FALSE ; is Dark
	db 33 ; level
	length 1.7 ; length
	weight 95.0 ; weight
	tx RapidashLv33Description ; description
	db NONE ; AI info

DarkRapidashCard:
	db TYPE_PKMN_FIRE ; type
	dw $5b4e ; gfx
	tx DarkRapidashName ; name
	db CIRCLE ; rarity
	db TEAM_ROCKET ; real set
	db WE_ARE_TEAM_ROCKET ; in-game set
	dw DARK_RAPIDASH
	db 60 ; hp
	db STAGE1 ; stage
	tx PonytaName ; pre-evo name

	; attack 1
	energy COLORLESS, 2 ; energies
	tx RearKickName ; name
	dw NONE ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_NORMAL ; category
	dw NONE ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_HIT ; animation

	; attack 2
	energy FIRE, 2 ; energies
	tx FlamePillarName ; name
	tx FlamePillarDescription ; description
	dw NONE ; description (cont)
	db 30 ; damage
	db DAMAGE_NORMAL ; category
	dw DarkRapidashFlamePillarEffectCommands ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db SPECIAL_AI_HANDLING | FLAG_3_BIT_2  ; flags 3
	db 0 ; ?
	db ATK_ANIM_FLAME_PILLAR ; animation

	db 0 ; retreat cost
	db WR_WATER ; weakness
	db NONE ; resistance
	tx FireHorseName ; category
	db DEX_RAPIDASH ; Pokedex number
	db TRUE ; is Dark
	db 24 ; level
	length 1.7 ; length
	weight 95.0 ; weight
	tx DarkRapidashDescription ; description
	db NONE ; AI info

MagmarLv18Card:
	db TYPE_PKMN_FIRE ; type
	dw $c4a5 ; gfx
	tx MagmarName ; name
	db DIAMOND ; rarity
	db SQUIRTLE_DECK ; real set
	db LEGENDARY_POWER ; in-game set
	dw MAGMAR_LV18
	db 50 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy FIRE, 1 ; energies
	tx FirePunchName ; name
	dw NONE ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_NORMAL ; category
	dw NONE ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_FIRE_PUNCH ; animation

	; attack 2
	energy FIRE, 2 ; energies
	tx SmogName ; name
	tx MayInflictPoisonAltDescription ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_NORMAL ; category
	dw MagmarLv18SmogEffectCommands ; effect commands
	db INFLICT_POISON  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_POISON_GAS ; animation

	db 1 ; retreat cost
	db WR_WATER ; weakness
	db NONE ; resistance
	tx SpitfireName ; category
	db DEX_MAGMAR ; Pokedex number
	db FALSE ; is Dark
	db 18 ; level
	length 1.3 ; length
	weight 44.5 ; weight
	tx MagmarLv18Description ; description
	db NONE ; AI info

MagmarLv24Card:
	db TYPE_PKMN_FIRE ; type
	dw $1beb ; gfx
	tx MagmarName ; name
	db DIAMOND ; rarity
	db BASE_SET ; real set
	db ISLAND_OF_FOSSIL ; in-game set
	dw MAGMAR_LV24
	db 50 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy FIRE, 2 ; energies
	tx FirePunchName ; name
	dw NONE ; description
	dw NONE ; description (cont)
	db 30 ; damage
	db DAMAGE_NORMAL ; category
	dw NONE ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_FIRE_PUNCH ; animation

	; attack 2
	energy FIRE, 2, COLORLESS, 1 ; energies
	tx FlamethrowerName ; name
	tx DiscardOneFireEnergyDescription ; description
	dw NONE ; description (cont)
	db 50 ; damage
	db DAMAGE_NORMAL ; category
	dw MagmarLv24FlamethrowerEffectCommands ; effect commands
	db NONE ; flags 1
	db DISCARD_ENERGY  ; flags 2
	db NONE ; flags 3
	db 3 ; ?
	db ATK_ANIM_BIG_FLAME ; animation

	db 2 ; retreat cost
	db WR_WATER ; weakness
	db NONE ; resistance
	tx SpitfireName ; category
	db DEX_MAGMAR ; Pokedex number
	db FALSE ; is Dark
	db 24 ; level
	length 1.3 ; length
	weight 44.5 ; weight
	tx MagmarLv24Description ; description
	db NONE ; AI info

MagmarLv27Card:
	db TYPE_PKMN_FIRE ; type
	dw $9c3d ; gfx
	tx MagmarName ; name
	db CIRCLE ; rarity
	db EXPANSION_SHEET ; real set
	db SKY_FLYING_POKEMON ; in-game set
	dw MAGMAR_LV27
	db 60 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy FIRE, 1 ; energies
	tx BurningFireName ; name
	tx BurningFireDescription ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_PLUS ; category
	dw MagmarLv27BurningFireEffectCommands ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db SPECIAL_AI_HANDLING  ; flags 3
	db 0 ; ?
	db ATK_ANIM_FIRE_SPIN ; animation

	; attack 2
	energy FIRE, 2, COLORLESS, 1 ; energies
	tx MagmaPunchName ; name
	dw NONE ; description
	dw NONE ; description (cont)
	db 40 ; damage
	db DAMAGE_NORMAL ; category
	dw NONE ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_FIRE_PUNCH ; animation

	db 2 ; retreat cost
	db WR_WATER ; weakness
	db NONE ; resistance
	tx SpitfireName ; category
	db DEX_MAGMAR ; Pokedex number
	db FALSE ; is Dark
	db 27 ; level
	length 1.3 ; length
	weight 44.5 ; weight
	tx MagmarLv27Description ; description
	db NONE ; AI info

MagmarLv31Card:
	db TYPE_PKMN_FIRE ; type
	dw $1c54 ; gfx
	tx MagmarName ; name
	db DIAMOND ; rarity
	db FOSSIL ; real set
	db WE_ARE_TEAM_ROCKET ; in-game set
	dw MAGMAR_LV31
	db 70 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy FIRE, 1 ; energies
	tx SmokescreenName ; name
	tx SmokescreenDescription ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_NORMAL ; category
	dw MagmarLv31SmokescreenEffectCommands ; effect commands
	db NONE ; flags 1
	db NULLIFY_OR_WEAKEN_ATTACK  ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_DARK_GAS ; animation

	; attack 2
	energy FIRE, 2 ; energies
	tx SmogName ; name
	tx MayInflictPoisonDescription ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_NORMAL ; category
	dw MagmarLv31SmogEffectCommands ; effect commands
	db INFLICT_POISON  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_SMOG ; animation

	db 1 ; retreat cost
	db WR_WATER ; weakness
	db NONE ; resistance
	tx SpitfireName ; category
	db DEX_MAGMAR ; Pokedex number
	db FALSE ; is Dark
	db 31 ; level
	length 1.3 ; length
	weight 44.5 ; weight
	tx MagmarLv31Description ; description
	db AI_INFO_UNK_03 ; AI info

FlareonLv22Card:
	db TYPE_PKMN_FIRE ; type
	dw $1cbd ; gfx
	tx FlareonName ; name
	db DIAMOND ; rarity
	db GB ; real set
	db PSYCHIC_BATTLE ; in-game set
	dw FLAREON_LV22
	db 60 ; hp
	db STAGE1 ; stage
	tx EeveeName ; pre-evo name

	; attack 1
	energy COLORLESS, 3 ; energies
	tx BiteName ; name
	dw NONE ; description
	dw NONE ; description (cont)
	db 30 ; damage
	db DAMAGE_NORMAL ; category
	dw NONE ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_HIT ; animation

	; attack 2
	energy COLORLESS, 3 ; energies
	tx RageName ; name
	tx RageDescription ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_PLUS ; category
	dw FlareonLv22RageEffectCommands ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db BOOST_IF_TAKEN_DAMAGE  ; flags 3
	db 0 ; ?
	db ATK_ANIM_HIT ; animation

	db 1 ; retreat cost
	db WR_WATER ; weakness
	db NONE ; resistance
	tx FlareName ; category
	db DEX_FLAREON ; Pokedex number
	db FALSE ; is Dark
	db 22 ; level
	length 0.9 ; length
	weight 25.0 ; weight
	tx FlareonLv22Description ; description
	db NONE ; AI info

FlareonLv28Card:
	db TYPE_PKMN_FIRE ; type
	dw $1d26 ; gfx
	tx FlareonName ; name
	db STAR ; rarity
	db JUNGLE ; real set
	db LEGENDARY_POWER ; in-game set
	dw FLAREON_LV28
	db 70 ; hp
	db STAGE1 ; stage
	tx EeveeName ; pre-evo name

	; attack 1
	energy COLORLESS, 2 ; energies
	tx QuickAttackName ; name
	tx QuickAttackDescription ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_PLUS ; category
	dw FlareonLv28QuickAttackEffectCommands ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_QUICK_ATTACK ; animation

	; attack 2
	energy FIRE, 2, COLORLESS, 2 ; energies
	tx FlamethrowerName ; name
	tx DiscardOneFireEnergyDescription ; description
	dw NONE ; description (cont)
	db 60 ; damage
	db DAMAGE_NORMAL ; category
	dw FlareonLv28FlamethrowerEffectCommands ; effect commands
	db NONE ; flags 1
	db DISCARD_ENERGY  ; flags 2
	db NONE ; flags 3
	db 3 ; ?
	db ATK_ANIM_BIG_FLAME ; animation

	db 1 ; retreat cost
	db WR_WATER ; weakness
	db NONE ; resistance
	tx FlareName ; category
	db DEX_FLAREON ; Pokedex number
	db FALSE ; is Dark
	db 28 ; level
	length 0.9 ; length
	weight 25.0 ; weight
	tx FlareonLv28Description ; description
	db NONE ; AI info

DarkFlareonCard:
	db TYPE_PKMN_FIRE ; type
	dw $5bb7 ; gfx
	tx DarkFlareonName ; name
	db DIAMOND ; rarity
	db TEAM_ROCKET ; real set
	db WE_ARE_TEAM_ROCKET ; in-game set
	dw DARK_FLAREON
	db 50 ; hp
	db STAGE1 ; stage
	tx EeveeName ; pre-evo name

	; attack 1
	energy COLORLESS, 1 ; energies
	tx RageName ; name
	tx RageDescription ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_PLUS ; category
	dw DarkFlareonRageEffectCommands ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_HIT ; animation

	; attack 2
	energy FIRE, 2 ; energies
	tx PlayingWithFireName ; name
	tx PlayingWithFireDescription ; description
	dw NONE ; description (cont)
	db 30 ; damage
	db DAMAGE_PLUS ; category
	dw DarkFlareonPlayingWithFireEffectCommands ; effect commands
	db NONE ; flags 1
	db DISCARD_ENERGY  ; flags 2
	db NONE ; flags 3
	db 2 ; ?
	db ATK_ANIM_BIG_FLAME ; animation

	db 1 ; retreat cost
	db WR_WATER ; weakness
	db NONE ; resistance
	tx FlareName ; category
	db DEX_FLAREON ; Pokedex number
	db TRUE ; is Dark
	db 23 ; level
	length 0.9 ; length
	weight 25.0 ; weight
	tx DarkFlareonDescription ; description
	db NONE ; AI info

MoltresLv35Card:
	db TYPE_PKMN_FIRE ; type
	dw $1d8f ; gfx
	tx MoltresName ; name
	db STAR ; rarity
	db FOSSIL ; real set
	db LEGENDARY_POWER ; in-game set
	dw MOLTRES_LV35
	db 70 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy FIRE, 1 ; energies
	tx WildfireName ; name
	tx WildfireDescription ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db RESIDUAL ; category
	dw MoltresLv35WildfireEffectCommands ; effect commands
	db NONE ; flags 1
	db FLAG_2_BIT_5  ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_GLOW_EFFECT ; animation

	; attack 2
	energy FIRE, 4 ; energies
	tx DiveBombName ; name
	tx IfTailsDoNothingDescription ; description
	dw NONE ; description (cont)
	db 80 ; damage
	db DAMAGE_NORMAL ; category
	dw MoltresLv35DiveBombEffectCommands ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_NONE ; animation

	db 2 ; retreat cost
	db NONE ; weakness
	db WR_FIGHTING ; resistance
	tx FlameName ; category
	db DEX_MOLTRES ; Pokedex number
	db FALSE ; is Dark
	db 35 ; level
	length 2.0 ; length
	weight 60.0 ; weight
	tx MoltresLv35Description ; description
	db NONE ; AI info

MoltresLv37Card:
	db TYPE_PKMN_FIRE ; type
	dw $8cd3 ; gfx
	tx MoltresName ; name
	db STAR ; rarity
	db EXPANSION_SHEET ; real set
	db TEAM_ROCKETS_AMBITION ; in-game set
	dw MOLTRES_LV37
	db 80 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy FIRE, 2 ; energies
	tx DryUpName ; name
	tx DryUpDescription ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db RESIDUAL ; category
	dw MoltresLv37DryUpEffectCommands ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db SPECIAL_AI_HANDLING | FLAG_3_BIT_2  ; flags 3
	db 0 ; ?
	db ATK_ANIM_DRY_UP ; animation

	; attack 2
	energy FIRE, 3, COLORLESS, 1 ; energies
	tx FireWingDescription ; name
	dw NONE ; description
	dw NONE ; description (cont)
	db 50 ; damage
	db DAMAGE_NORMAL ; category
	dw NONE ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_DIVE_BOMB ; animation

	db 1 ; retreat cost
	db NONE ; weakness
	db WR_FIGHTING ; resistance
	tx FlameName ; category
	db DEX_MOLTRES ; Pokedex number
	db FALSE ; is Dark
	db 37 ; level
	length 2.0 ; length
	weight 60.0 ; weight
	tx MoltresSharedDescription ; description
	db NONE ; AI info

MoltresLv40Card:
	db TYPE_PKMN_FIRE ; type
	dw $1df8 ; gfx
	tx MoltresName ; name
	db STAR ; rarity
	db GB ; real set
	db PROMOTIONAL ; in-game set
	dw MOLTRES_LV40
	db 100 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy 0 ; energies
	tx FiregiverName ; name
	tx FiregiverDescription ; description
	tx FiregiverDescriptionCont ; description (cont)
	db 0 ; damage
	db POKEMON_POWER ; category
	dw MoltresLv40FiregiverEffectCommands ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_FIREGIVER ; animation

	; attack 2
	energy FIRE, 3 ; energies
	tx DiveBombName ; name
	tx IfTailsDoNothingDescription ; description
	dw NONE ; description (cont)
	db 70 ; damage
	db DAMAGE_NORMAL ; category
	dw MoltresLv40DiveBombEffectCommands ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_NONE ; animation

	db 2 ; retreat cost
	db NONE ; weakness
	db WR_FIGHTING ; resistance
	tx FlameName ; category
	db DEX_MOLTRES ; Pokedex number
	db FALSE ; is Dark
	db 40 ; level
	length 2.0 ; length
	weight 60.0 ; weight
	tx MoltresSharedDescription ; description
	db NONE ; AI info

SquirtleLv8Card:
	db TYPE_PKMN_WATER ; type
	dw $1e61 ; gfx
	tx SquirtleName ; name
	db CIRCLE ; rarity
	db BASE_SET ; real set
	db ISLAND_OF_FOSSIL ; in-game set
	dw SQUIRTLE_LV8
	db 40 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy WATER, 1 ; energies
	tx BubbleName ; name
	tx MayInflictParalysisDescription ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_NORMAL ; category
	dw SquirtleLv8BubbleEffectCommands ; effect commands
	db INFLICT_PARALYSIS  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_BUBBLES ; animation

	; attack 2
	energy WATER, 1, COLORLESS, 1 ; energies
	tx WithdrawName ; name
	tx PreventDamageCardEffectDescription ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db RESIDUAL ; category
	dw SquirtleLv8WithdrawEffectCommands ; effect commands
	db NONE ; flags 1
	db NULLIFY_OR_WEAKEN_ATTACK  ; flags 2
	db FLAG_3_BIT_2  ; flags 3
	db 0 ; ?
	db ATK_ANIM_NONE ; animation

	db 1 ; retreat cost
	db WR_LIGHTNING ; weakness
	db NONE ; resistance
	tx TinyTurtleName ; category
	db DEX_SQUIRTLE ; Pokedex number
	db FALSE ; is Dark
	db 8 ; level
	length 0.5 ; length
	weight 9.0 ; weight
	tx SquirtleLv8Description ; description
	db AI_INFO_UNK_05 | HAS_EVOLUTION ; AI info

SquirtleLv14Card:
	db TYPE_PKMN_WATER ; type
	dw $be5c ; gfx
	tx SquirtleName ; name
	db CIRCLE ; rarity
	db SQUIRTLE_DECK ; real set
	db LEGENDARY_POWER ; in-game set
	dw SQUIRTLE_LV14
	db 50 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy WATER, 1 ; energies
	tx BiteName ; name
	dw NONE ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_NORMAL ; category
	dw NONE ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_HIT ; animation

	; attack 2
	energy WATER, 1, COLORLESS, 1 ; energies
	tx SkullBashName ; name
	dw NONE ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_NORMAL ; category
	dw NONE ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_SKULL_BASH ; animation

	db 1 ; retreat cost
	db WR_LIGHTNING ; weakness
	db NONE ; resistance
	tx TinyTurtleName ; category
	db DEX_SQUIRTLE ; Pokedex number
	db FALSE ; is Dark
	db 14 ; level
	length 0.5 ; length
	weight 9.0 ; weight
	tx SquirtleLv14Description ; description
	db NONE | HAS_EVOLUTION ; AI info

SquirtleLv15Card:
	db TYPE_PKMN_WATER ; type
	dw $720f ; gfx
	tx SquirtleName ; name
	db DIAMOND ; rarity
	db EXPANSION_SHEET ; real set
	db SKY_FLYING_POKEMON ; in-game set
	dw SQUIRTLE_LV15
	db 50 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy WATER, 1 ; energies
	tx WaterPowerName ; name
	tx WaterPowerDescription ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db RESIDUAL ; category
	dw SquirtleLv15WaterPowerEffectCommands ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db SPECIAL_AI_HANDLING | FLAG_3_BIT_2  ; flags 3
	db 0 ; ?
	db ATK_ANIM_GLOW_EFFECT ; animation

	; attack 2
	energy COLORLESS, 1 ; energies
	tx PoundName ; name
	dw NONE ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_NORMAL ; category
	dw NONE ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_HIT ; animation

	db 1 ; retreat cost
	db WR_LIGHTNING ; weakness
	db NONE ; resistance
	tx TinyTurtleName ; category
	db DEX_SQUIRTLE ; Pokedex number
	db FALSE ; is Dark
	db 15 ; level
	length 0.5 ; length
	weight 9.0 ; weight
	tx SquirtleLv15Description ; description
	db NONE | HAS_EVOLUTION ; AI info

SquirtleLv16Card:
	db TYPE_PKMN_WATER ; type
	dw $5c20 ; gfx
	tx SquirtleName ; name
	db CIRCLE ; rarity
	db TEAM_ROCKET ; real set
	db WE_ARE_TEAM_ROCKET ; in-game set
	dw SQUIRTLE_LV16
	db 50 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy COLORLESS, 2 ; energies
	tx ShellAttackName ; name
	dw NONE ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_NORMAL ; category
	dw NONE ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_HIT ; animation

	; attack 2
	energy 0 ; energies
	dw NONE ; name
	dw NONE ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db DAMAGE_NORMAL ; category
	dw NONE ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_NONE ; animation

	db 1 ; retreat cost
	db WR_LIGHTNING ; weakness
	db NONE ; resistance
	tx TinyTurtleName ; category
	db DEX_SQUIRTLE ; Pokedex number
	db FALSE ; is Dark
	db 16 ; level
	length 0.5 ; length
	weight 9.0 ; weight
	tx SquirtleLv16Description ; description
	db NONE | HAS_EVOLUTION ; AI info

WartortleLv22Card:
	db TYPE_PKMN_WATER ; type
	dw $1f28 ; gfx
	tx WartortleName ; name
	db DIAMOND ; rarity
	db BASE_SET ; real set
	db ISLAND_OF_FOSSIL ; in-game set
	dw WARTORTLE_LV22
	db 70 ; hp
	db STAGE1 ; stage
	tx SquirtleName ; pre-evo name

	; attack 1
	energy WATER, 1, COLORLESS, 1 ; energies
	tx WithdrawName ; name
	tx PreventDamageCardEffectDescription ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db RESIDUAL ; category
	dw WartortleLv22WithdrawEffectCommands ; effect commands
	db NONE ; flags 1
	db NULLIFY_OR_WEAKEN_ATTACK  ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_NONE ; animation

	; attack 2
	energy WATER, 1, COLORLESS, 2 ; energies
	tx BiteName ; name
	dw NONE ; description
	dw NONE ; description (cont)
	db 40 ; damage
	db DAMAGE_NORMAL ; category
	dw NONE ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_HIT ; animation

	db 1 ; retreat cost
	db WR_LIGHTNING ; weakness
	db NONE ; resistance
	tx TurtleName ; category
	db DEX_WARTORTLE ; Pokedex number
	db FALSE ; is Dark
	db 22 ; level
	length 1.0 ; length
	weight 22.5 ; weight
	tx WartortleLv22Description ; description
	db AI_INFO_ENCOURAGE_EVO | HAS_EVOLUTION ; AI info

WartortleLv24Card:
	db TYPE_PKMN_WATER ; type
	dw $c276 ; gfx
	tx WartortleName ; name
	db DIAMOND ; rarity
	db SQUIRTLE_DECK ; real set
	db LEGENDARY_POWER ; in-game set
	dw WARTORTLE_LV24
	db 70 ; hp
	db STAGE1 ; stage
	tx SquirtleName ; pre-evo name

	; attack 1
	energy WATER, 1 ; energies
	tx BubbleName ; name
	tx MayInflictParalysisAltDescription ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_NORMAL ; category
	dw WartortleLv24BubbleEffectCommands ; effect commands
	db INFLICT_PARALYSIS  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_BUBBLES_COPY ; animation

	; attack 2
	energy WATER, 2 ; energies
	tx SurfName ; name
	dw NONE ; description
	dw NONE ; description (cont)
	db 30 ; damage
	db DAMAGE_NORMAL ; category
	dw NONE ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_WATER_JETS ; animation

	db 2 ; retreat cost
	db WR_LIGHTNING ; weakness
	db NONE ; resistance
	tx TurtleName ; category
	db DEX_WARTORTLE ; Pokedex number
	db FALSE ; is Dark
	db 24 ; level
	length 1.0 ; length
	weight 22.5 ; weight
	tx WartortleLv24Description ; description
	db AI_INFO_ENCOURAGE_EVO | HAS_EVOLUTION ; AI info

DarkWartortleCard:
	db TYPE_PKMN_WATER ; type
	dw $5c97 ; gfx
	tx DarkWartortleName ; name
	db DIAMOND ; rarity
	db TEAM_ROCKET ; real set
	db WE_ARE_TEAM_ROCKET ; in-game set
	dw DARK_WARTORTLE
	db 60 ; hp
	db STAGE1 ; stage
	tx SquirtleName ; pre-evo name

	; attack 1
	energy WATER, 1 ; energies
	tx DoubleSlapName ; name
	tx Do10DamageNumberOfHeadsDescription ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_X ; category
	dw DarkWartortleDoubleSlapEffectCommands ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_SLAP ; animation

	; attack 2
	energy WATER, 1, COLORLESS, 1 ; energies
	tx MirrorShellName ; name
	tx MirrorShellDescription ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db RESIDUAL ; category
	dw DarkWartortleMirrorShellEffectCommands ; effect commands
	db NONE ; flags 1
	db FLAG_2_BIT_6  ; flags 2
	db FLAG_3_BIT_2  ; flags 3
	db 0 ; ?
	db ATK_ANIM_GLOW_EFFECT ; animation

	db 1 ; retreat cost
	db WR_LIGHTNING ; weakness
	db NONE ; resistance
	tx TurtleName ; category
	db DEX_WARTORTLE ; Pokedex number
	db TRUE ; is Dark
	db 21 ; level
	length 1.0 ; length
	weight 22.5 ; weight
	tx DarkWartortleDescription ; description
	db NONE | HAS_EVOLUTION ; AI info

BlastoiseLv52Card:
	db TYPE_PKMN_WATER ; type
	dw $2000 ; gfx
	tx BlastoiseName ; name
	db STAR ; rarity
	db BASE_SET ; real set
	db LEGENDARY_POWER ; in-game set
	dw BLASTOISE_LV52
	db 100 ; hp
	db STAGE2 ; stage
	tx WartortleName ; pre-evo name

	; attack 1
	energy 0 ; energies
	tx RainDanceName ; name
	tx RainDanceDescription ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db POKEMON_POWER ; category
	dw BlastoiseLv52RainDanceEffectCommands ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_PKMN_POWER_1 ; animation

	; attack 2
	energy WATER, 3 ; energies
	tx HydroPumpName ; name
	tx Do20DamagePlus10WaterEnergyDescription ; description
	dw NONE ; description (cont)
	db 40 ; damage
	db DAMAGE_PLUS ; category
	dw BlastoiseLv52HydroPumpEffectCommands ; effect commands
	db NONE ; flags 1
	db ATTACHED_ENERGY_BOOST  ; flags 2
	db NONE ; flags 3
	db 2 ; ?
	db ATK_ANIM_HYDRO_PUMP ; animation

	db 3 ; retreat cost
	db WR_LIGHTNING ; weakness
	db NONE ; resistance
	tx ShellfishName ; category
	db DEX_BLASTOISE ; Pokedex number
	db FALSE ; is Dark
	db 52 ; level
	length 1.6 ; length
	weight 85.5 ; weight
	tx BlastoiseDescription ; description
	db NONE ; AI info

BlastoiseAltLv52Card:
	db TYPE_PKMN_WATER ; type
	dw $a4d1 ; gfx
	tx BlastoiseName ; name
	db STAR ; rarity
	db PRO ; real set
	db PROMOTIONAL ; in-game set
	dw BLASTOISE_ALT_LV52
	db 100 ; hp
	db STAGE2 ; stage
	tx WartortleName ; pre-evo name

	; attack 1
	energy 0 ; energies
	tx RainDanceName ; name
	tx RainDanceDescription ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db POKEMON_POWER ; category
	dw BlastoiseAltLv52RainDanceEffectCommands ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_PKMN_POWER_1 ; animation

	; attack 2
	energy WATER, 3 ; energies
	tx HydroPumpName ; name
	tx Do20DamagePlus10WaterEnergyDescription ; description
	dw NONE ; description (cont)
	db 40 ; damage
	db DAMAGE_PLUS ; category
	dw BlastoiseAltLv52HydroPumpEffectCommands ; effect commands
	db NONE ; flags 1
	db ATTACHED_ENERGY_BOOST  ; flags 2
	db NONE ; flags 3
	db 2 ; ?
	db ATK_ANIM_HYDRO_PUMP ; animation

	db 3 ; retreat cost
	db WR_LIGHTNING ; weakness
	db NONE ; resistance
	tx ShellfishName ; category
	db DEX_BLASTOISE ; Pokedex number
	db FALSE ; is Dark
	db 52 ; level
	length 1.6 ; length
	weight 85.5 ; weight
	tx BlastoiseAltDescription ; description
	db NONE ; AI info

DarkBlastoiseCard:
	db TYPE_PKMN_WATER ; type
	dw $5d3c ; gfx
	tx DarkBlastoiseName ; name
	db STAR ; rarity
	db TEAM_ROCKET ; real set
	db WE_ARE_TEAM_ROCKET ; in-game set
	dw DARK_BLASTOISE
	db 70 ; hp
	db STAGE2 ; stage
	tx DarkWartortleName ; pre-evo name

	; attack 1
	energy WATER, 2 ; energies
	tx HydrocannonName ; name
	tx HydrocannonDescription ; description
	dw NONE ; description (cont)
	db 30 ; damage
	db DAMAGE_PLUS ; category
	dw DarkBlastoiseHydrocannonEffectCommands ; effect commands
	db NONE ; flags 1
	db ATTACHED_ENERGY_BOOST  ; flags 2
	db NONE ; flags 3
	db 2 ; ?
	db ATK_ANIM_HYDRO_PUMP ; animation

	; attack 2
	energy WATER, 1, COLORLESS, 2 ; energies
	tx RocketTackleName ; name
	tx RocketTackleDescription ; description
	dw NONE ; description (cont)
	db 40 ; damage
	db DAMAGE_NORMAL ; category
	dw DarkBlastoiseRocketTackleEffectCommands ; effect commands
	db LOW_RECOIL  ; flags 1
	db NULLIFY_OR_WEAKEN_ATTACK  ; flags 2
	db NONE ; flags 3
	db 10 ; ?
	db ATK_ANIM_ROCKET_TACKLE ; animation

	db 2 ; retreat cost
	db WR_LIGHTNING ; weakness
	db NONE ; resistance
	tx ShellfishName ; category
	db DEX_BLASTOISE ; Pokedex number
	db TRUE ; is Dark
	db 28 ; level
	length 1.6 ; length
	weight 85.5 ; weight
	tx DarkBlastoiseDescription ; description
	db NONE ; AI info

PsyduckLv15Card:
	db TYPE_PKMN_WATER ; type
	dw $207d ; gfx
	tx PsyduckName ; name
	db CIRCLE ; rarity
	db FOSSIL ; real set
	db ISLAND_OF_FOSSIL ; in-game set
	dw PSYDUCK_LV15
	db 50 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy PSYCHIC, 1 ; energies
	tx HeadacheName ; name
	tx HeadacheDescription ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db RESIDUAL ; category
	dw PsyduckLv15HeadacheEffectCommands ; effect commands
	db NONE ; flags 1
	db FLAG_2_BIT_6  ; flags 2
	db FLAG_3_BIT_2  ; flags 3
	db 2 ; ?
	db ATK_ANIM_GLOW_EFFECT ; animation

	; attack 2
	energy WATER, 1 ; energies
	tx FurySwipesName ; name
	tx FurySwipes10DamageDescription ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_X ; category
	dw PsyduckLv15FurySwipesEffectCommands ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_MULTIPLE_SLASH ; animation

	db 1 ; retreat cost
	db WR_LIGHTNING ; weakness
	db NONE ; resistance
	tx DuckName ; category
	db DEX_PSYDUCK ; Pokedex number
	db FALSE ; is Dark
	db 15 ; level
	length 0.8 ; length
	weight 19.6 ; weight
	tx PsyduckLv15Description ; description
	db AI_INFO_UNK_03 | HAS_EVOLUTION ; AI info

PsyduckLv16Card:
	db TYPE_PKMN_WATER ; type
	dw $5da5 ; gfx
	tx PsyduckName ; name
	db CIRCLE ; rarity
	db TEAM_ROCKET ; real set
	db TEAM_ROCKETS_AMBITION ; in-game set
	dw PSYDUCK_LV16
	db 50 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy PSYCHIC, 1 ; energies
	tx DizzinessName ; name
	tx DizzinessDescription ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db RESIDUAL ; category
	dw PsyduckLv16DizzinessEffectCommands ; effect commands
	db DRAW_CARD  ; flags 1
	db NONE ; flags 2
	db SPECIAL_AI_HANDLING | FLAG_3_BIT_2  ; flags 3
	db 0 ; ?
	db ATK_ANIM_GLOW_EFFECT ; animation

	; attack 2
	energy WATER, 1, COLORLESS, 1 ; energies
	tx WaterGunName ; name
	tx Do20DamagePlus10WaterEnergyDescription ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_PLUS ; category
	dw PsyduckLv16WaterGunEffectCommands ; effect commands
	db NONE ; flags 1
	db ATTACHED_ENERGY_BOOST  ; flags 2
	db NONE ; flags 3
	db 2 ; ?
	db ATK_ANIM_WATER_GUN ; animation

	db 1 ; retreat cost
	db WR_LIGHTNING ; weakness
	db NONE ; resistance
	tx DuckName ; category
	db DEX_PSYDUCK ; Pokedex number
	db FALSE ; is Dark
	db 16 ; level
	length 0.8 ; length
	weight 19.6 ; weight
	tx PsyduckLv16Description ; description
	db NONE | HAS_EVOLUTION ; AI info

GolduckLv27Card:
	db TYPE_PKMN_WATER ; type
	dw $20f2 ; gfx
	tx GolduckName ; name
	db DIAMOND ; rarity
	db FOSSIL ; real set
	db SKY_FLYING_POKEMON ; in-game set
	dw GOLDUCK_LV27
	db 70 ; hp
	db STAGE1 ; stage
	tx PsyduckName ; pre-evo name

	; attack 1
	energy PSYCHIC, 1 ; energies
	tx PsyshockName ; name
	tx MayInflictParalysisDescription ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_NORMAL ; category
	dw GolduckLv27PsyshockEffectCommands ; effect commands
	db INFLICT_PARALYSIS  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_PSYCHIC_HIT ; animation

	; attack 2
	energy WATER, 2, COLORLESS, 1 ; energies
	tx HyperBeamName ; name
	tx HyperBeamDescription ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_NORMAL ; category
	dw GolduckLv27HyperBeamEffectCommands ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db SPECIAL_AI_HANDLING  ; flags 3
	db 0 ; ?
	db ATK_ANIM_HYPER_BEAM ; animation

	db 1 ; retreat cost
	db WR_LIGHTNING ; weakness
	db NONE ; resistance
	tx DuckName ; category
	db DEX_GOLDUCK ; Pokedex number
	db FALSE ; is Dark
	db 27 ; level
	length 1.7 ; length
	weight 76.6 ; weight
	tx GolduckLv27Description ; description
	db AI_INFO_UNK_03 ; AI info

GolduckLv28Card:
	db TYPE_PKMN_WATER ; type
	dw $9089 ; gfx
	tx GolduckName ; name
	db STAR ; rarity
	db EXPANSION_SHEET ; real set
	db ISLAND_OF_FOSSIL ; in-game set
	dw GOLDUCK_LV28
	db 70 ; hp
	db STAGE1 ; stage
	tx PsyduckName ; pre-evo name

	; attack 1
	energy PSYCHIC, 1, COLORLESS, 1 ; energies
	tx PsychicName ; name
	tx PsychicDescription ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_PLUS ; category
	dw GolduckLv28PsychicEffectCommands ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_PSYCHIC_HIT ; animation

	; attack 2
	energy WATER, 2, COLORLESS, 1 ; energies
	tx WaveSplashName ; name
	dw NONE ; description
	dw NONE ; description (cont)
	db 40 ; damage
	db DAMAGE_NORMAL ; category
	dw NONE ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_WHIRLPOOL ; animation

	db 2 ; retreat cost
	db WR_LIGHTNING ; weakness
	db NONE ; resistance
	tx DuckName ; category
	db DEX_GOLDUCK ; Pokedex number
	db FALSE ; is Dark
	db 28 ; level
	length 1.7 ; length
	weight 76.6 ; weight
	tx GolduckLv28Description ; description
	db NONE ; AI info

DarkGolduckCard:
	db TYPE_PKMN_WATER ; type
	dw $5e0e ; gfx
	tx DarkGolduckName ; name
	db DIAMOND ; rarity
	db TEAM_ROCKET ; real set
	db TEAM_ROCKETS_AMBITION ; in-game set
	dw DARK_GOLDUCK
	db 60 ; hp
	db STAGE1 ; stage
	tx PsyduckName ; pre-evo name

	; attack 1
	energy PSYCHIC, 1 ; energies
	tx ThirdEyeName ; name
	tx ThirdEyeDescription ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db RESIDUAL ; category
	dw DarkGolduckThirdEyeEffectCommands ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db SPECIAL_AI_HANDLING | FLAG_3_BIT_2  ; flags 3
	db 0 ; ?
	db ATK_ANIM_GLOW_EFFECT ; animation

	; attack 2
	energy PSYCHIC, 2, COLORLESS, 1 ; energies
	tx SuperPsyName ; name
	dw NONE ; description
	dw NONE ; description (cont)
	db 50 ; damage
	db DAMAGE_NORMAL ; category
	dw NONE ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_PSYCHIC_HIT ; animation

	db 2 ; retreat cost
	db WR_LIGHTNING ; weakness
	db NONE ; resistance
	tx DuckName ; category
	db DEX_GOLDUCK ; Pokedex number
	db TRUE ; is Dark
	db 23 ; level
	length 1.7 ; length
	weight 76.6 ; weight
	tx DarkGolduckDescription ; description
	db NONE ; AI info

PoliwagLv13Card:
	db TYPE_PKMN_WATER ; type
	dw $2161 ; gfx
	tx PoliwagName ; name
	db CIRCLE ; rarity
	db BASE_SET ; real set
	db ISLAND_OF_FOSSIL ; in-game set
	dw POLIWAG_LV13
	db 40 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy WATER, 1 ; energies
	tx WaterGunName ; name
	tx Do20DamagePlus10WaterEnergyAltDescription1 ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_PLUS ; category
	dw PoliwagLv13WaterGunEffectCommands ; effect commands
	db NONE ; flags 1
	db ATTACHED_ENERGY_BOOST  ; flags 2
	db NONE ; flags 3
	db 2 ; ?
	db ATK_ANIM_WATER_GUN ; animation

	; attack 2
	energy 0 ; energies
	dw NONE ; name
	dw NONE ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db DAMAGE_NORMAL ; category
	dw NONE ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_NONE ; animation

	db 1 ; retreat cost
	db WR_GRASS ; weakness
	db NONE ; resistance
	tx TadpoleName ; category
	db DEX_POLIWAG ; Pokedex number
	db FALSE ; is Dark
	db 13 ; level
	length 0.6 ; length
	weight 12.4 ; weight
	tx PoliwagLv13Description ; description
	db AI_INFO_UNK_03 | HAS_EVOLUTION ; AI info

PoliwagLv15Card:
	db TYPE_PKMN_WATER ; type
	dw $79ae ; gfx
	tx PoliwagName ; name
	db CIRCLE ; rarity
	db EXPANSION_SHEET ; real set
	db SKY_FLYING_POKEMON ; in-game set
	dw POLIWAG_LV15
	db 50 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy WATER, 1 ; energies
	tx BubbleName ; name
	tx MayInflictParalysisAltDescription ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_NORMAL ; category
	dw PoliwagLv15BubbleEffectCommands ; effect commands
	db INFLICT_PARALYSIS  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_BUBBLES_COPY ; animation

	; attack 2
	energy 0 ; energies
	dw NONE ; name
	dw NONE ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db DAMAGE_NORMAL ; category
	dw NONE ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_NONE ; animation

	db 1 ; retreat cost
	db WR_GRASS ; weakness
	db NONE ; resistance
	tx TadpoleName ; category
	db DEX_POLIWAG ; Pokedex number
	db FALSE ; is Dark
	db 15 ; level
	length 0.6 ; length
	weight 12.4 ; weight
	tx PoliwagLv15Description ; description
	db NONE | HAS_EVOLUTION ; AI info

PoliwhirlLv28Card:
	db TYPE_PKMN_WATER ; type
	dw $21d8 ; gfx
	tx PoliwhirlName ; name
	db DIAMOND ; rarity
	db BASE_SET ; real set
	db SKY_FLYING_POKEMON ; in-game set
	dw POLIWHIRL_LV28
	db 60 ; hp
	db STAGE1 ; stage
	tx PoliwagName ; pre-evo name

	; attack 1
	energy WATER, 2 ; energies
	tx AmnesiaName ; name
	tx AmnesiaDescription ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db DAMAGE_NORMAL ; category
	dw PoliwhirlLv28AmnesiaEffectCommands ; effect commands
	db NONE ; flags 1
	db NULLIFY_OR_WEAKEN_ATTACK  ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_AMNESIA ; animation

	; attack 2
	energy WATER, 2, COLORLESS, 1 ; energies
	tx DoubleSlapName ; name
	tx Do30DamageNumberOfHeadsDescription ; description
	dw NONE ; description (cont)
	db 30 ; damage
	db DAMAGE_X ; category
	dw PoliwhirlLv28DoubleSlapEffectCommands ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_SLAP ; animation

	db 1 ; retreat cost
	db WR_GRASS ; weakness
	db NONE ; resistance
	tx TadpoleName ; category
	db DEX_POLIWHIRL ; Pokedex number
	db FALSE ; is Dark
	db 28 ; level
	length 1.0 ; length
	weight 20.0 ; weight
	tx PoliwhirlLv28Description ; description
	db NONE | HAS_EVOLUTION ; AI info

PoliwhirlLv30Card:
	db TYPE_PKMN_WATER ; type
	dw $7a17 ; gfx
	tx PoliwhirlName ; name
	db DIAMOND ; rarity
	db EXPANSION_SHEET ; real set
	db ISLAND_OF_FOSSIL ; in-game set
	dw POLIWHIRL_LV30
	db 70 ; hp
	db STAGE1 ; stage
	tx PoliwagName ; pre-evo name

	; attack 1
	energy WATER, 2 ; energies
	tx TwiddleName ; name
	tx TwiddleDescription ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db DAMAGE_NORMAL ; category
	dw PoliwhirlLv30TwiddleEffectCommands ; effect commands
	db INFLICT_SLEEP | INFLICT_CONFUSION  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_TWIDDLE ; animation

	; attack 2
	energy WATER, 1, COLORLESS, 2 ; energies
	tx BodySlamName ; name
	tx MayInflictParalysisAltDescription ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_NORMAL ; category
	dw PoliwhirlLv30BodySlamEffectCommands ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_HIT_EFFECT ; animation

	db 1 ; retreat cost
	db WR_GRASS ; weakness
	db NONE ; resistance
	tx TadpoleName ; category
	db DEX_POLIWHIRL ; Pokedex number
	db FALSE ; is Dark
	db 30 ; level
	length 1.0 ; length
	weight 20.0 ; weight
	tx PoliwhirlLv30Description ; description
	db NONE | HAS_EVOLUTION ; AI info

PoliwrathLv40Card:
	db TYPE_PKMN_WATER ; type
	dw $7a86 ; gfx
	tx PoliwrathName ; name
	db STAR ; rarity
	db EXPANSION_SHEET ; real set
	db ISLAND_OF_FOSSIL ; in-game set
	dw POLIWRATH_LV40
	db 80 ; hp
	db STAGE2 ; stage
	tx PoliwhirlName ; pre-evo name

	; attack 1
	energy WATER, 2 ; energies
	tx MegaPunchName ; name
	dw NONE ; description
	dw NONE ; description (cont)
	db 30 ; damage
	db DAMAGE_NORMAL ; category
	dw NONE ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_MEGA_PUNCH ; animation

	; attack 2
	energy WATER, 3 ; energies
	tx HydroPumpName ; name
	tx Do20DamagePlus10WaterEnergyDescription ; description
	dw NONE ; description (cont)
	db 40 ; damage
	db DAMAGE_PLUS ; category
	dw PoliwrathLv40HydroPumpEffectCommands ; effect commands
	db NONE ; flags 1
	db ATTACHED_ENERGY_BOOST  ; flags 2
	db NONE ; flags 3
	db 2 ; ?
	db ATK_ANIM_HYDRO_PUMP ; animation

	db 2 ; retreat cost
	db WR_GRASS ; weakness
	db NONE ; resistance
	tx TadpoleName ; category
	db DEX_POLIWRATH ; Pokedex number
	db FALSE ; is Dark
	db 40 ; level
	length 1.3 ; length
	weight 54.0 ; weight
	tx PoliwrathLv40Description ; description
	db NONE ; AI info

PoliwrathLv48Card:
	db TYPE_PKMN_WATER ; type
	dw $2241 ; gfx
	tx PoliwrathName ; name
	db STAR ; rarity
	db BASE_SET ; real set
	db SKY_FLYING_POKEMON ; in-game set
	dw POLIWRATH_LV48
	db 90 ; hp
	db STAGE2 ; stage
	tx PoliwhirlName ; pre-evo name

	; attack 1
	energy WATER, 2, COLORLESS, 1 ; energies
	tx WaterGunName ; name
	tx Do20DamagePlus10WaterEnergyAltDescription1 ; description
	dw NONE ; description (cont)
	db 30 ; damage
	db DAMAGE_PLUS ; category
	dw PoliwrathLv48WaterGunEffectCommands ; effect commands
	db NONE ; flags 1
	db ATTACHED_ENERGY_BOOST  ; flags 2
	db NONE ; flags 3
	db 2 ; ?
	db ATK_ANIM_WATER_GUN ; animation

	; attack 2
	energy WATER, 2, COLORLESS, 2 ; energies
	tx WhirlpoolName ; name
	tx HyperBeamDescription ; description
	dw NONE ; description (cont)
	db 40 ; damage
	db DAMAGE_NORMAL ; category
	dw PoliwrathLv48WhirlpoolEffectCommands ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db SPECIAL_AI_HANDLING  ; flags 3
	db 0 ; ?
	db ATK_ANIM_WHIRLPOOL ; animation

	db 3 ; retreat cost
	db WR_GRASS ; weakness
	db NONE ; resistance
	tx TadpoleName ; category
	db DEX_POLIWRATH ; Pokedex number
	db FALSE ; is Dark
	db 48 ; level
	length 1.3 ; length
	weight 54.0 ; weight
	tx PoliwrathLv48Description ; description
	db NONE ; AI info

TentacoolCard:
	db TYPE_PKMN_WATER ; type
	dw $22aa ; gfx
	tx TentacoolName ; name
	db CIRCLE ; rarity
	db FOSSIL ; real set
	db LEGENDARY_POWER ; in-game set
	dw TENTACOOL
	db 30 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy 0 ; energies
	tx CowardiceName ; name
	tx CowardiceDescription ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db POKEMON_POWER ; category
	dw TentacoolCowardiceEffectCommands ; effect commands
	db NONE ; flags 1
	db FLAG_2_BIT_6  ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_PKMN_POWER_1 ; animation

	; attack 2
	energy WATER, 1 ; energies
	tx AcidName ; name
	dw NONE ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_NORMAL ; category
	dw NONE ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_GOO ; animation

	db 0 ; retreat cost
	db WR_LIGHTNING ; weakness
	db NONE ; resistance
	tx JellyfishName ; category
	db DEX_TENTACOOL ; Pokedex number
	db FALSE ; is Dark
	db 10 ; level
	length 0.9 ; length
	weight 45.5 ; weight
	tx TentacoolDescription ; description
	db AI_INFO_UNK_03 | HAS_EVOLUTION ; AI info

TentacruelCard:
	db TYPE_PKMN_WATER ; type
	dw $2313 ; gfx
	tx TentacruelName ; name
	db DIAMOND ; rarity
	db FOSSIL ; real set
	db LEGENDARY_POWER ; in-game set
	dw TENTACRUEL
	db 60 ; hp
	db STAGE1 ; stage
	tx TentacoolName ; pre-evo name

	; attack 1
	energy WATER, 1 ; energies
	tx SupersonicName ; name
	tx MayInflictConfusionAltDescription ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db DAMAGE_NORMAL ; category
	dw TentacruelSupersonicEffectCommands ; effect commands
	db INFLICT_CONFUSION  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_SUPERSONIC ; animation

	; attack 2
	energy WATER, 2 ; energies
	tx JellyfishStingName ; name
	tx InflictPoisonDescription ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_NORMAL ; category
	dw TentacruelJellyfishStingEffectCommands ; effect commands
	db INFLICT_POISON  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_MULTIPLE_SLASH ; animation

	db 0 ; retreat cost
	db WR_LIGHTNING ; weakness
	db NONE ; resistance
	tx JellyfishName ; category
	db DEX_TENTACRUEL ; Pokedex number
	db FALSE ; is Dark
	db 21 ; level
	length 1.6 ; length
	weight 55.0 ; weight
	tx TentacruelDescription ; description
	db NONE ; AI info

SeelLv10Card:
	db TYPE_PKMN_WATER ; type
	dw $862b ; gfx
	tx SeelName ; name
	db CIRCLE ; rarity
	db EXPANSION_SHEET ; real set
	db SKY_FLYING_POKEMON ; in-game set
	dw SEEL_LV10
	db 50 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy COLORLESS, 1 ; energies
	tx GrowlName ; name
	tx GrowlAltDescription1 ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db DAMAGE_NORMAL ; category
	dw SeelLv10GrowlEffectCommands ; effect commands
	db NONE ; flags 1
	db NULLIFY_OR_WEAKEN_ATTACK  ; flags 2
	db NONE ; flags 3
	db 10 ; ?
	db ATK_ANIM_SUPERSONIC ; animation

	; attack 2
	energy WATER, 2 ; energies
	tx IceBeamName ; name
	tx MayInflictParalysisAltDescription ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_NORMAL ; category
	dw SeelLv10IceBeamEffectCommands ; effect commands
	db INFLICT_PARALYSIS  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_ICE_BEAM ; animation

	db 1 ; retreat cost
	db WR_LIGHTNING ; weakness
	db NONE ; resistance
	tx SeaLionName ; category
	db DEX_SEEL ; Pokedex number
	db FALSE ; is Dark
	db 10 ; level
	length 1.1 ; length
	weight 90.0 ; weight
	tx SeelLv10Description ; description
	db NONE | HAS_EVOLUTION ; AI info

SeelLv12Card:
	db TYPE_PKMN_WATER ; type
	dw $23c8 ; gfx
	tx SeelName ; name
	db CIRCLE ; rarity
	db BASE_SET ; real set
	db BEGINNING_POKEMON ; in-game set
	dw SEEL_LV12
	db 60 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy WATER, 1 ; energies
	tx HeadbuttName ; name
	dw NONE ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_NORMAL ; category
	dw NONE ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_HIT ; animation

	; attack 2
	energy 0 ; energies
	dw NONE ; name
	dw NONE ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db DAMAGE_NORMAL ; category
	dw NONE ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_NONE ; animation

	db 1 ; retreat cost
	db WR_LIGHTNING ; weakness
	db NONE ; resistance
	tx SeaLionName ; category
	db DEX_SEEL ; Pokedex number
	db FALSE ; is Dark
	db 12 ; level
	length 1.1 ; length
	weight 90.0 ; weight
	tx SeelLv12Description ; description
	db AI_INFO_UNK_03 | HAS_EVOLUTION ; AI info

DewgongLv24Card:
	db TYPE_PKMN_WATER ; type
	dw $869c ; gfx
	tx DewgongName ; name
	db DIAMOND ; rarity
	db EXPANSION_SHEET ; real set
	db SKY_FLYING_POKEMON ; in-game set
	dw DEWGONG_LV24
	db 60 ; hp
	db STAGE1 ; stage
	tx SeelName ; pre-evo name

	; attack 1
	energy COLORLESS, 2 ; energies
	tx RestName ; name
	tx RestDescription ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db RESIDUAL ; category
	dw DewgongLv24RestEffectCommands ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db SPECIAL_AI_HANDLING | FLAG_3_BIT_2  ; flags 3
	db 0 ; ?
	db ATK_ANIM_REST ; animation

	; attack 2
	energy WATER, 3 ; energies
	tx AuroraWaveName ; name
	tx MayInflictConfusionDescription ; description
	dw NONE ; description (cont)
	db 30 ; damage
	db DAMAGE_NORMAL ; category
	dw DewgongLv24AuroraWaveEffectCommands ; effect commands
	db INFLICT_CONFUSION  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_AURORA_WAVE ; animation

	db 2 ; retreat cost
	db WR_LIGHTNING ; weakness
	db NONE ; resistance
	tx SeaLionName ; category
	db DEX_DEWGONG ; Pokedex number
	db FALSE ; is Dark
	db 24 ; level
	length 1.7 ; length
	weight 120.0 ; weight
	tx DewgongLv24Description ; description
	db NONE ; AI info

DewgongLv42Card:
	db TYPE_PKMN_WATER ; type
	dw $2431 ; gfx
	tx DewgongName ; name
	db STAR ; rarity
	db BASE_SET ; real set
	db BEGINNING_POKEMON ; in-game set
	dw DEWGONG_LV42
	db 80 ; hp
	db STAGE1 ; stage
	tx SeelName ; pre-evo name

	; attack 1
	energy WATER, 2, COLORLESS, 1 ; energies
	tx AuroraBeamName ; name
	dw NONE ; description
	dw NONE ; description (cont)
	db 50 ; damage
	db DAMAGE_NORMAL ; category
	dw NONE ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_BEAM ; animation

	; attack 2
	energy WATER, 2, COLORLESS, 2 ; energies
	tx IceBeamName ; name
	tx MayInflictParalysisDescription ; description
	dw NONE ; description (cont)
	db 30 ; damage
	db DAMAGE_NORMAL ; category
	dw DewgongLv42IceBeamEffectCommands ; effect commands
	db INFLICT_PARALYSIS  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_BEAM ; animation

	db 3 ; retreat cost
	db WR_LIGHTNING ; weakness
	db NONE ; resistance
	tx SeaLionName ; category
	db DEX_DEWGONG ; Pokedex number
	db FALSE ; is Dark
	db 42 ; level
	length 1.7 ; length
	weight 120.0 ; weight
	tx DewgongLv42Description ; description
	db NONE ; AI info

ShellderLv8Card:
	db TYPE_PKMN_WATER ; type
	dw $249a ; gfx
	tx ShellderName ; name
	db CIRCLE ; rarity
	db FOSSIL ; real set
	db LEGENDARY_POWER ; in-game set
	dw SHELLDER_LV8
	db 30 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy WATER, 1 ; energies
	tx SupersonicName ; name
	tx MayInflictConfusionAltDescription ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db DAMAGE_NORMAL ; category
	dw ShellderLv8SupersonicEffectCommands ; effect commands
	db INFLICT_CONFUSION  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_SUPERSONIC ; animation

	; attack 2
	energy WATER, 1 ; energies
	tx HideInShellName ; name
	tx PreventDamageCardEffectDescription ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db RESIDUAL ; category
	dw ShellderLv8HideInShellEffectCommands ; effect commands
	db NONE ; flags 1
	db NULLIFY_OR_WEAKEN_ATTACK  ; flags 2
	db FLAG_3_BIT_2  ; flags 3
	db 0 ; ?
	db ATK_ANIM_NONE ; animation

	db 1 ; retreat cost
	db WR_LIGHTNING ; weakness
	db NONE ; resistance
	tx BivalveName ; category
	db DEX_SHELLDER ; Pokedex number
	db FALSE ; is Dark
	db 8 ; level
	length 0.3 ; length
	weight 4.0 ; weight
	tx ShellderLv8Description ; description
	db AI_INFO_UNK_03 | HAS_EVOLUTION ; AI info

ShellderLv16Card:
	db TYPE_PKMN_WATER ; type
	dw $8705 ; gfx
	tx ShellderName ; name
	db CIRCLE ; rarity
	db EXPANSION_SHEET ; real set
	db PSYCHIC_BATTLE ; in-game set
	dw SHELLDER_LV16
	db 50 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy WATER, 1, COLORLESS, 1 ; energies
	tx WaterSpoutName ; name
	tx Do20DamagePlus10WaterEnergyAltDescription2 ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_PLUS ; category
	dw ShellderLv16WaterSpoutEffectCommands ; effect commands
	db NONE ; flags 1
	db ATTACHED_ENERGY_BOOST  ; flags 2
	db NONE ; flags 3
	db 2 ; ?
	db ATK_ANIM_WATER_GUN ; animation

	; attack 2
	energy 0 ; energies
	dw NONE ; name
	dw NONE ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db DAMAGE_NORMAL ; category
	dw NONE ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_NONE ; animation

	db 1 ; retreat cost
	db WR_LIGHTNING ; weakness
	db NONE ; resistance
	tx BivalveName ; category
	db DEX_SHELLDER ; Pokedex number
	db FALSE ; is Dark
	db 16 ; level
	length 0.3 ; length
	weight 4.0 ; weight
	tx ShellderLv16Description ; description
	db NONE | HAS_EVOLUTION ; AI info

CloysterCard:
	db TYPE_PKMN_WATER ; type
	dw $2523 ; gfx
	tx CloysterName ; name
	db DIAMOND ; rarity
	db FOSSIL ; real set
	db LEGENDARY_POWER ; in-game set
	dw CLOYSTER
	db 50 ; hp
	db STAGE1 ; stage
	tx ShellderName ; pre-evo name

	; attack 1
	energy WATER, 2 ; energies
	tx ClampName ; name
	tx ClampDescription ; description
	dw NONE ; description (cont)
	db 30 ; damage
	db DAMAGE_NORMAL ; category
	dw CloysterClampEffectCommands ; effect commands
	db INFLICT_PARALYSIS  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_NONE ; animation

	; attack 2
	energy WATER, 2 ; energies
	tx SpikeCannonName ; name
	tx Do30DamageNumberOfHeadsDescription ; description
	dw NONE ; description (cont)
	db 30 ; damage
	db DAMAGE_X ; category
	dw CloysterSpikeCannonEffectCommands ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_NEEDLES ; animation

	db 2 ; retreat cost
	db WR_LIGHTNING ; weakness
	db NONE ; resistance
	tx BivalveName ; category
	db DEX_CLOYSTER ; Pokedex number
	db FALSE ; is Dark
	db 25 ; level
	length 1.5 ; length
	weight 132.5 ; weight
	tx CloysterDescription ; description
	db NONE ; AI info

KrabbyLv17Card:
	db TYPE_PKMN_WATER ; type
	dw $8800 ; gfx
	tx KrabbyName ; name
	db CIRCLE ; rarity
	db EXPANSION_SHEET ; real set
	db PSYCHIC_BATTLE ; in-game set
	dw KRABBY_LV17
	db 40 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy WATER, 1 ; energies
	tx BubbleName ; name
	tx MayInflictParalysisAltDescription ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_NORMAL ; category
	dw KrabbyLv17BubbleEffectCommands ; effect commands
	db INFLICT_PARALYSIS  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_BUBBLES_COPY ; animation

	; attack 2
	energy WATER, 1, COLORLESS, 2 ; energies
	tx GuillotineAltName ; name
	dw NONE ; description
	dw NONE ; description (cont)
	db 30 ; damage
	db DAMAGE_NORMAL ; category
	dw NONE ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_GUILLOTINE ; animation

	db 1 ; retreat cost
	db WR_LIGHTNING ; weakness
	db NONE ; resistance
	tx RiverCrabName ; category
	db DEX_KRABBY ; Pokedex number
	db FALSE ; is Dark
	db 17 ; level
	length 0.4 ; length
	weight 6.5 ; weight
	tx KrabbyLv17Description ; description
	db NONE | HAS_EVOLUTION ; AI info

KrabbyLv20Card:
	db TYPE_PKMN_WATER ; type
	dw $258c ; gfx
	tx KrabbyName ; name
	db CIRCLE ; rarity
	db FOSSIL ; real set
	db BEGINNING_POKEMON ; in-game set
	dw KRABBY_LV20
	db 50 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy WATER, 1 ; energies
	tx CallForFamilyName ; name
	tx CallForFamilyKrabbyDescription ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db RESIDUAL ; category
	dw KrabbyLv20CallForFamilyEffectCommands ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db SPECIAL_AI_HANDLING | FLAG_3_BIT_2  ; flags 3
	db 0 ; ?
	db ATK_ANIM_GLOW_EFFECT ; animation

	; attack 2
	energy WATER, 1, COLORLESS, 1 ; energies
	tx IrongripAltName ; name
	dw NONE ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_NORMAL ; category
	dw NONE ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_HIT ; animation

	db 2 ; retreat cost
	db WR_LIGHTNING ; weakness
	db NONE ; resistance
	tx RiverCrabName ; category
	db DEX_KRABBY ; Pokedex number
	db FALSE ; is Dark
	db 20 ; level
	length 0.4 ; length
	weight 6.5 ; weight
	tx KrabbyLv20Description ; description
	db NONE | HAS_EVOLUTION ; AI info

KinglerLv27Card:
	db TYPE_PKMN_WATER ; type
	dw $25f9 ; gfx
	tx KinglerName ; name
	db DIAMOND ; rarity
	db FOSSIL ; real set
	db BEGINNING_POKEMON ; in-game set
	dw KINGLER_LV27
	db 60 ; hp
	db STAGE1 ; stage
	tx KrabbyName ; pre-evo name

	; attack 1
	energy WATER, 1 ; energies
	tx FlailName ; name
	tx FlailDescription ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_X ; category
	dw KinglerLv27FlailEffectCommands ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db BOOST_IF_TAKEN_DAMAGE  ; flags 3
	db 0 ; ?
	db ATK_ANIM_BIG_HIT ; animation

	; attack 2
	energy WATER, 2, COLORLESS, 1 ; energies
	tx CrabhammerName ; name
	dw NONE ; description
	dw NONE ; description (cont)
	db 40 ; damage
	db DAMAGE_NORMAL ; category
	dw NONE ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_HIT ; animation

	db 3 ; retreat cost
	db WR_LIGHTNING ; weakness
	db NONE ; resistance
	tx PincerName ; category
	db DEX_KINGLER ; Pokedex number
	db FALSE ; is Dark
	db 27 ; level
	length 1.3 ; length
	weight 60.0 ; weight
	tx KinglerLv27Description ; description
	db NONE ; AI info

KinglerLv33Card:
	db TYPE_PKMN_WATER ; type
	dw $9800 ; gfx
	tx KinglerName ; name
	db STAR ; rarity
	db EXPANSION_SHEET ; real set
	db PSYCHIC_BATTLE ; in-game set
	dw KINGLER_LV33
	db 80 ; hp
	db STAGE1 ; stage
	tx KrabbyName ; pre-evo name

	; attack 1
	energy WATER, 1 ; energies
	tx SaltWaterName ; name
	tx SaltWaterDescription ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db RESIDUAL ; category
	dw KinglerLv33SaltWaterEffectCommands ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db SPECIAL_AI_HANDLING | FLAG_3_BIT_2  ; flags 3
	db 0 ; ?
	db ATK_ANIM_GLOW_EFFECT ; animation

	; attack 2
	energy WATER, 4 ; energies
	tx DoubleEdgedPincersName ; name
	tx DoubleEdgedPincersDescription ; description
	dw NONE ; description (cont)
	db 80 ; damage
	db DAMAGE_NORMAL ; category
	dw KinglerLv33DoubleEdgedPincersEffectCommands ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_GUILLOTINE ; animation

	db 3 ; retreat cost
	db WR_LIGHTNING ; weakness
	db NONE ; resistance
	tx PincerName ; category
	db DEX_KINGLER ; Pokedex number
	db FALSE ; is Dark
	db 33 ; level
	length 1.3 ; length
	weight 60.0 ; weight
	tx KinglerLv33Description ; description
	db NONE ; AI info

HorseaLv19Card:
	db TYPE_PKMN_WATER ; type
	dw $2666 ; gfx
	tx HorseaName ; name
	db CIRCLE ; rarity
	db FOSSIL ; real set
	db ISLAND_OF_FOSSIL ; in-game set
	dw HORSEA_LV19
	db 40 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy WATER, 1 ; energies
	tx SmokescreenName ; name
	tx SmokescreenDescription ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_NORMAL ; category
	dw HorseaLv19SmokescreenEffectCommands ; effect commands
	db NONE ; flags 1
	db NULLIFY_OR_WEAKEN_ATTACK  ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_DARK_GAS ; animation

	; attack 2
	energy 0 ; energies
	dw NONE ; name
	dw NONE ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db DAMAGE_NORMAL ; category
	dw NONE ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_NONE ; animation

	db 0 ; retreat cost
	db WR_LIGHTNING ; weakness
	db NONE ; resistance
	tx DragonName ; category
	db DEX_HORSEA ; Pokedex number
	db FALSE ; is Dark
	db 19 ; level
	length 0.4 ; length
	weight 8.0 ; weight
	tx HorseaLv19Description ; description
	db AI_INFO_UNK_03 | HAS_EVOLUTION ; AI info

HorseaLv20Card:
	db TYPE_PKMN_WATER ; type
	dw $9a43 ; gfx
	tx HorseaName ; name
	db CIRCLE ; rarity
	db EXPANSION_SHEET ; real set
	db SKY_FLYING_POKEMON ; in-game set
	dw HORSEA_LV20
	db 40 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy COLORLESS, 1 ; energies
	tx HideName ; name
	tx HideDescription ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db RESIDUAL ; category
	dw HorseaLv20HideEffectCommands ; effect commands
	db NONE ; flags 1
	db NULLIFY_OR_WEAKEN_ATTACK  ; flags 2
	db FLAG_3_BIT_2  ; flags 3
	db 0 ; ?
	db ATK_ANIM_PROTECT ; animation

	; attack 2
	energy WATER, 1 ; energies
	tx WaterGunName ; name
	tx Do20DamagePlus10WaterEnergyAltDescription2 ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_PLUS ; category
	dw HorseaLv20WaterGunEffectCommands ; effect commands
	db NONE ; flags 1
	db ATTACHED_ENERGY_BOOST  ; flags 2
	db NONE ; flags 3
	db 2 ; ?
	db ATK_ANIM_WATER_GUN ; animation

	db 0 ; retreat cost
	db WR_LIGHTNING ; weakness
	db NONE ; resistance
	tx DragonName ; category
	db DEX_HORSEA ; Pokedex number
	db FALSE ; is Dark
	db 20 ; level
	length 0.4 ; length
	weight 8.0 ; weight
	tx HorseaLv20Description ; description
	db NONE | HAS_EVOLUTION ; AI info

SeadraLv23Card:
	db TYPE_PKMN_WATER ; type
	dw $26cf ; gfx
	tx SeadraName ; name
	db DIAMOND ; rarity
	db FOSSIL ; real set
	db ISLAND_OF_FOSSIL ; in-game set
	dw SEADRA_LV23
	db 60 ; hp
	db STAGE1 ; stage
	tx HorseaName ; pre-evo name

	; attack 1
	energy WATER, 1, COLORLESS, 1 ; energies
	tx WaterGunName ; name
	tx Do20DamagePlus10WaterEnergyDescription ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_PLUS ; category
	dw SeadraLv23WaterGunEffectCommands ; effect commands
	db NONE ; flags 1
	db ATTACHED_ENERGY_BOOST  ; flags 2
	db NONE ; flags 3
	db 2 ; ?
	db ATK_ANIM_WATER_GUN ; animation

	; attack 2
	energy WATER, 1, COLORLESS, 2 ; energies
	tx AgilityName ; name
	tx AgilityDescription ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_NORMAL ; category
	dw SeadraLv23AgilityEffectCommands ; effect commands
	db NONE ; flags 1
	db NULLIFY_OR_WEAKEN_ATTACK  ; flags 2
	db FLAG_3_BIT_2  ; flags 3
	db 0 ; ?
	db ATK_ANIM_QUICK_ATTACK ; animation

	db 1 ; retreat cost
	db WR_LIGHTNING ; weakness
	db NONE ; resistance
	tx DragonName ; category
	db DEX_SEADRA ; Pokedex number
	db FALSE ; is Dark
	db 23 ; level
	length 1.2 ; length
	weight 25.0 ; weight
	tx SeadraLv23Description ; description
	db NONE ; AI info

SeadraLv26Card:
	db TYPE_PKMN_WATER ; type
	dw $9aac ; gfx
	tx SeadraName ; name
	db STAR ; rarity
	db EXPANSION_SHEET ; real set
	db SKY_FLYING_POKEMON ; in-game set
	dw SEADRA_LV26
	db 70 ; hp
	db STAGE1 ; stage
	tx HorseaName ; pre-evo name

	; attack 1
	energy WATER, 2 ; energies
	tx WaterBombName ; name
	tx WaterBombDescription ; description
	tx WaterBombDescriptionCont ; description (cont)
	db 20 ; damage
	db DAMAGE_NORMAL ; category
	dw SeadraLv26WaterBombEffectCommands ; effect commands
	db DAMAGE_TO_OPPONENT_BENCH  ; flags 1
	db ATTACHED_ENERGY_BOOST  ; flags 2
	db FLAG_3_BIT_2  ; flags 3
	db 2 ; ?
	db ATK_ANIM_WATER_BOMB ; animation

	; attack 2
	energy 0 ; energies
	dw NONE ; name
	dw NONE ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db DAMAGE_NORMAL ; category
	dw NONE ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_NONE ; animation

	db 1 ; retreat cost
	db WR_LIGHTNING ; weakness
	db NONE ; resistance
	tx DragonName ; category
	db DEX_SEADRA ; Pokedex number
	db FALSE ; is Dark
	db 26 ; level
	length 1.2 ; length
	weight 25.0 ; weight
	tx SeadraLv26Description ; description
	db NONE ; AI info

GoldeenCard:
	db TYPE_PKMN_WATER ; type
	dw $2738 ; gfx
	tx GoldeenName ; name
	db CIRCLE ; rarity
	db JUNGLE ; real set
	db LEGENDARY_POWER ; in-game set
	dw GOLDEEN
	db 40 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy WATER, 1 ; energies
	tx HornAttackName ; name
	dw NONE ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_NORMAL ; category
	dw NONE ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_HIT ; animation

	; attack 2
	energy 0 ; energies
	dw NONE ; name
	dw NONE ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db DAMAGE_NORMAL ; category
	dw NONE ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_NONE ; animation

	db 0 ; retreat cost
	db WR_LIGHTNING ; weakness
	db NONE ; resistance
	tx GoldfishName ; category
	db DEX_GOLDEEN ; Pokedex number
	db FALSE ; is Dark
	db 12 ; level
	length 0.6 ; length
	weight 15.0 ; weight
	tx GoldeenDescription ; description
	db AI_INFO_UNK_05 | HAS_EVOLUTION ; AI info

SeakingCard:
	db TYPE_PKMN_WATER ; type
	dw $2800 ; gfx
	tx SeakingName ; name
	db DIAMOND ; rarity
	db JUNGLE ; real set
	db LEGENDARY_POWER ; in-game set
	dw SEAKING
	db 70 ; hp
	db STAGE1 ; stage
	tx GoldeenName ; pre-evo name

	; attack 1
	energy WATER, 1 ; energies
	tx HornAttackName ; name
	dw NONE ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_NORMAL ; category
	dw NONE ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_HIT ; animation

	; attack 2
	energy WATER, 1, COLORLESS, 1 ; energies
	tx WaterfallName ; name
	dw NONE ; description
	dw NONE ; description (cont)
	db 30 ; damage
	db DAMAGE_NORMAL ; category
	dw NONE ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_WATER_JETS ; animation

	db 1 ; retreat cost
	db WR_LIGHTNING ; weakness
	db NONE ; resistance
	tx GoldfishName ; category
	db DEX_SEAKING ; Pokedex number
	db FALSE ; is Dark
	db 28 ; level
	length 1.3 ; length
	weight 39.0 ; weight
	tx SeakingDescription ; description
	db NONE ; AI info

StaryuLv15Card:
	db TYPE_PKMN_WATER ; type
	dw $2869 ; gfx
	tx StaryuName ; name
	db CIRCLE ; rarity
	db BASE_SET ; real set
	db BEGINNING_POKEMON ; in-game set
	dw STARYU_LV15
	db 40 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy WATER, 1 ; energies
	tx SlapName ; name
	dw NONE ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_NORMAL ; category
	dw NONE ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_SLAP ; animation

	; attack 2
	energy 0 ; energies
	dw NONE ; name
	dw NONE ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db DAMAGE_NORMAL ; category
	dw NONE ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_NONE ; animation

	db 1 ; retreat cost
	db WR_LIGHTNING ; weakness
	db NONE ; resistance
	tx StarshapeName ; category
	db DEX_STARYU ; Pokedex number
	db FALSE ; is Dark
	db 15 ; level
	length 0.8 ; length
	weight 34.5 ; weight
	tx StaryuLv15Description ; description
	db AI_INFO_UNK_03 | HAS_EVOLUTION ; AI info

StaryuLv17Card:
	db TYPE_PKMN_WATER ; type
	dw $9b15 ; gfx
	tx StaryuName ; name
	db CIRCLE ; rarity
	db EXPANSION_SHEET ; real set
	db PSYCHIC_BATTLE ; in-game set
	dw STARYU_LV17
	db 50 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy WATER, 1 ; energies
	tx StrangeBeamName ; name
	tx StrangeBeamDescription ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_NORMAL ; category
	dw StaryuLv17StrangeBeamEffectCommands ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db SPECIAL_AI_HANDLING | FLAG_3_BIT_2  ; flags 3
	db 0 ; ?
	db ATK_ANIM_PSYBEAM ; animation

	; attack 2
	energy WATER, 1, COLORLESS, 1 ; energies
	tx SpinningAttackName ; name
	dw NONE ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_NORMAL ; category
	dw NONE ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_HIT ; animation

	db 1 ; retreat cost
	db WR_LIGHTNING ; weakness
	db NONE ; resistance
	tx StarshapeName ; category
	db DEX_STARYU ; Pokedex number
	db FALSE ; is Dark
	db 17 ; level
	length 0.8 ; length
	weight 34.5 ; weight
	tx StaryuLv17Description ; description
	db NONE | HAS_EVOLUTION ; AI info

StarmieCard:
	db TYPE_PKMN_WATER ; type
	dw $28d8 ; gfx
	tx StarmieName ; name
	db DIAMOND ; rarity
	db BASE_SET ; real set
	db BEGINNING_POKEMON ; in-game set
	dw STARMIE
	db 60 ; hp
	db STAGE1 ; stage
	tx StaryuName ; pre-evo name

	; attack 1
	energy WATER, 2 ; energies
	tx RecoverName ; name
	tx RecoverWaterDescription ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db RESIDUAL ; category
	dw StarmieRecoverEffectCommands ; effect commands
	db NONE ; flags 1
	db DISCARD_ENERGY  ; flags 2
	db FLAG_3_BIT_2  ; flags 3
	db 3 ; ?
	db ATK_ANIM_RECOVER ; animation

	; attack 2
	energy WATER, 1, COLORLESS, 2 ; energies
	tx StarFreezeName ; name
	tx MayInflictParalysisDescription ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_NORMAL ; category
	dw StarmieStarFreezeEffectCommands ; effect commands
	db INFLICT_PARALYSIS  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_BEAM ; animation

	db 1 ; retreat cost
	db WR_LIGHTNING ; weakness
	db NONE ; resistance
	tx MysteriousName ; category
	db DEX_STARMIE ; Pokedex number
	db FALSE ; is Dark
	db 28 ; level
	length 1.1 ; length
	weight 80.0 ; weight
	tx StarmieDescription ; description
	db NONE ; AI info

DarkStarmieCard:
	db TYPE_PKMN_WATER ; type
	dw $c869 ; gfx
	tx DarkStarmieName ; name
	db DIAMOND ; rarity
	db GB ; real set
	db TEAM_ROCKETS_AMBITION ; in-game set
	dw DARK_STARMIE
	db 60 ; hp
	db STAGE1 ; stage
	tx StaryuName ; pre-evo name

	; attack 1
	energy 0 ; energies
	tx RebirthName ; name
	tx RebirthDescription ; description
	tx RebirthDescriptionCont ; description (cont)
	db 0 ; damage
	db POKEMON_POWER ; category
	dw DarkStarmieRebirthEffectCommands ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_GLOW_EFFECT ; animation

	; attack 2
	energy WATER, 2 ; energies
	tx SpinningShowerName ; name
	tx SpinningShowerDescription ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db RESIDUAL ; category
	dw DarkStarmieSpinningShowerEffectCommands ; effect commands
	db DAMAGE_TO_OPPONENT_BENCH  ; flags 1
	db FLAG_2_BIT_6  ; flags 2
	db FLAG_3_BIT_2  ; flags 3
	db 3 ; ?
	db ATK_ANIM_SPINNING_SHOWER ; animation

	db 1 ; retreat cost
	db WR_LIGHTNING ; weakness
	db NONE ; resistance
	tx MysteriousName ; category
	db DEX_STARMIE ; Pokedex number
	db TRUE ; is Dark
	db 27 ; level
	length 1.1 ; length
	weight 80.0 ; weight
	tx DarkStarmieDescription ; description
	db NONE ; AI info

MagikarpLv6Card:
	db TYPE_PKMN_WATER ; type
	dw $5e77 ; gfx
	tx MagikarpName ; name
	db CIRCLE ; rarity
	db TEAM_ROCKET ; real set
	db WE_ARE_TEAM_ROCKET ; in-game set
	dw MAGIKARP_LV6
	db 30 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy COLORLESS, 1 ; energies
	tx FlopName ; name
	dw NONE ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_NORMAL ; category
	dw NONE ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_HIT ; animation

	; attack 2
	energy WATER, 3 ; energies
	tx RapidEvolutionName ; name
	tx RapidEvolutionDescription ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db RESIDUAL ; category
	dw MagikarpLv6RapidEvolutionEffectCommands ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db SPECIAL_AI_HANDLING | FLAG_3_BIT_2  ; flags 3
	db 0 ; ?
	db ATK_ANIM_GLOW_EFFECT ; animation

	db 1 ; retreat cost
	db WR_LIGHTNING ; weakness
	db NONE ; resistance
	tx FishName ; category
	db DEX_MAGIKARP ; Pokedex number
	db FALSE ; is Dark
	db 6 ; level
	length 0.9 ; length
	weight 10.0 ; weight
	tx MagikarpLv6Description ; description
	db NONE | HAS_EVOLUTION ; AI info

MagikarpLv8Card:
	db TYPE_PKMN_WATER ; type
	dw $2941 ; gfx
	tx MagikarpName ; name
	db DIAMOND ; rarity
	db BASE_SET ; real set
	db BEGINNING_POKEMON ; in-game set
	dw MAGIKARP_LV8
	db 30 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy COLORLESS, 1 ; energies
	tx TackleName ; name
	dw NONE ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_NORMAL ; category
	dw NONE ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_HIT ; animation

	; attack 2
	energy WATER, 1 ; energies
	tx FlailName ; name
	tx FlailDescription ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_X ; category
	dw MagikarpLv8FlailEffectCommands ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db BOOST_IF_TAKEN_DAMAGE  ; flags 3
	db 0 ; ?
	db ATK_ANIM_BIG_HIT ; animation

	db 1 ; retreat cost
	db WR_LIGHTNING ; weakness
	db NONE ; resistance
	tx FishName ; category
	db DEX_MAGIKARP ; Pokedex number
	db FALSE ; is Dark
	db 8 ; level
	length 0.9 ; length
	weight 10.0 ; weight
	tx MagikarpLv8Description ; description
	db AI_INFO_ENCOURAGE_EVO | HAS_EVOLUTION ; AI info

MagikarpLv10Card:
	db TYPE_PKMN_WATER ; type
	dw $a376 ; gfx
	tx MagikarpName ; name
	db PROMOSTAR ; rarity
	db PRO ; real set
	db PROMOTIONAL ; in-game set
	dw MAGIKARP_LV10
	db 30 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy WATER, 1 ; energies
	tx TrickleName ; name
	tx Plus10DamagePerHeadsDescription ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_X ; category
	dw MagikarpLv10TrickleEffectCommands ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_HIT ; animation

	; attack 2
	energy WATER, 2 ; energies
	tx DragonRageName ; name
	tx IfEitherTailsDoNothingDescription ; description
	dw NONE ; description (cont)
	db 50 ; damage
	db DAMAGE_NORMAL ; category
	dw MagikarpLv10DragonRageEffectCommands ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_DRAGON_RAGE ; animation

	db 1 ; retreat cost
	db WR_LIGHTNING ; weakness
	db NONE ; resistance
	tx FishName ; category
	db DEX_MAGIKARP ; Pokedex number
	db FALSE ; is Dark
	db 10 ; level
	length 0.9 ; length
	weight 10.0 ; weight
	tx MagikarpLv10Description ; description
	db NONE | HAS_EVOLUTION ; AI info

GyaradosCard:
	db TYPE_PKMN_WATER ; type
	dw $29aa ; gfx
	tx GyaradosName ; name
	db STAR ; rarity
	db BASE_SET ; real set
	db BEGINNING_POKEMON ; in-game set
	dw GYARADOS
	db 100 ; hp
	db STAGE1 ; stage
	tx MagikarpName ; pre-evo name

	; attack 1
	energy WATER, 3 ; energies
	tx DragonRageName ; name
	dw NONE ; description
	dw NONE ; description (cont)
	db 50 ; damage
	db DAMAGE_NORMAL ; category
	dw NONE ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_DRAGON_RAGE ; animation

	; attack 2
	energy WATER, 4 ; energies
	tx BubblebeamName ; name
	tx MayInflictParalysisDescription ; description
	dw NONE ; description (cont)
	db 40 ; damage
	db DAMAGE_NORMAL ; category
	dw GyaradosBubblebeamEffectCommands ; effect commands
	db INFLICT_PARALYSIS  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_BUBBLES ; animation

	db 3 ; retreat cost
	db WR_GRASS ; weakness
	db WR_FIGHTING ; resistance
	tx AtrociousName ; category
	db DEX_GYARADOS ; Pokedex number
	db FALSE ; is Dark
	db 41 ; level
	length 6.5 ; length
	weight 235.0 ; weight
	tx GyaradosDescription ; description
	db NONE ; AI info

DarkGyaradosCard:
	db TYPE_PKMN_WATER ; type
	dw $5ee0 ; gfx
	tx DarkGyaradosName ; name
	db STAR ; rarity
	db TEAM_ROCKET ; real set
	db WE_ARE_TEAM_ROCKET ; in-game set
	dw DARK_GYARADOS
	db 70 ; hp
	db STAGE1 ; stage
	tx MagikarpName ; pre-evo name

	; attack 1
	energy 0 ; energies
	tx FinalBeamName ; name
	tx FinalBeamDescription ; description
	tx FinalBeamDescriptionCont ; description (cont)
	db 0 ; damage
	db POKEMON_POWER ; category
	dw DarkGyaradosFinalBeamEffectCommands ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_PSYBEAM ; animation

	; attack 2
	energy WATER, 3 ; energies
	tx IceBeamName ; name
	tx MayInflictParalysisAltDescription ; description
	dw NONE ; description (cont)
	db 30 ; damage
	db DAMAGE_NORMAL ; category
	dw DarkGyaradosIceBeamEffectCommands ; effect commands
	db INFLICT_PARALYSIS  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_ICE_BEAM ; animation

	db 2 ; retreat cost
	db WR_GRASS ; weakness
	db WR_FIGHTING ; resistance
	tx AtrociousName ; category
	db DEX_GYARADOS ; Pokedex number
	db TRUE ; is Dark
	db 31 ; level
	length 6.5 ; length
	weight 235.0 ; weight
	tx DarkGyaradosDescription ; description
	db NONE ; AI info

LaprasLv24Card:
	db TYPE_PKMN_WATER ; type
	dw $8a2b ; gfx
	tx LaprasName ; name
	db STAR ; rarity
	db EXPANSION_SHEET ; real set
	db LEGENDARY_POWER ; in-game set
	dw LAPRAS_LV24
	db 60 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy COLORLESS, 1 ; energies
	tx SingName ; name
	tx MayInflictSleepDescription ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db DAMAGE_NORMAL ; category
	dw LaprasLv24SingEffectCommands ; effect commands
	db INFLICT_SLEEP  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_LULLABY ; animation

	; attack 2
	energy WATER, 2 ; energies
	tx SurfName ; name
	dw NONE ; description
	dw NONE ; description (cont)
	db 30 ; damage
	db DAMAGE_NORMAL ; category
	dw NONE ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_WATER_JETS ; animation

	db 1 ; retreat cost
	db WR_LIGHTNING ; weakness
	db NONE ; resistance
	tx TransportName ; category
	db DEX_LAPRAS ; Pokedex number
	db FALSE ; is Dark
	db 24 ; level
	length 2.5 ; length
	weight 220.0 ; weight
	tx LaprasLv24Description ; description
	db NONE ; AI info

LaprasLv31Card:
	db TYPE_PKMN_WATER ; type
	dw $2a17 ; gfx
	tx LaprasName ; name
	db STAR ; rarity
	db FOSSIL ; real set
	db SKY_FLYING_POKEMON ; in-game set
	dw LAPRAS_LV31
	db 80 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy WATER, 1 ; energies
	tx WaterGunName ; name
	tx Do20DamagePlus10WaterEnergyDescription ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_PLUS ; category
	dw LaprasLv31WaterGunEffectCommands ; effect commands
	db NONE ; flags 1
	db ATTACHED_ENERGY_BOOST  ; flags 2
	db NONE ; flags 3
	db 2 ; ?
	db ATK_ANIM_WATER_GUN ; animation

	; attack 2
	energy WATER, 2 ; energies
	tx ConfuseRayName ; name
	tx MayInflictConfusionAltDescription ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_NORMAL ; category
	dw LaprasLv31ConfuseRayEffectCommands ; effect commands
	db INFLICT_CONFUSION  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_CONFUSE_RAY ; animation

	db 2 ; retreat cost
	db WR_LIGHTNING ; weakness
	db NONE ; resistance
	tx TransportName ; category
	db DEX_LAPRAS ; Pokedex number
	db FALSE ; is Dark
	db 31 ; level
	length 2.5 ; length
	weight 220.0 ; weight
	tx LaprasLv31Description ; description
	db NONE ; AI info

VaporeonLv29Card:
	db TYPE_PKMN_WATER ; type
	dw $2a80 ; gfx
	tx VaporeonName ; name
	db DIAMOND ; rarity
	db GB ; real set
	db PSYCHIC_BATTLE ; in-game set
	dw VAPOREON_LV29
	db 60 ; hp
	db STAGE1 ; stage
	tx EeveeName ; pre-evo name

	; attack 1
	energy COLORLESS, 1 ; energies
	tx FocusEnergyName ; name
	tx FocusEnergyBiteDescription ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db RESIDUAL ; category
	dw VaporeonLv29FocusEnergyEffectCommands ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db SPECIAL_AI_HANDLING | FLAG_3_BIT_2  ; flags 3
	db 0 ; ?
	db ATK_ANIM_GLOW_EFFECT ; animation

	; attack 2
	energy COLORLESS, 3 ; energies
	tx BiteName ; name
	dw NONE ; description
	dw NONE ; description (cont)
	db 30 ; damage
	db DAMAGE_NORMAL ; category
	dw NONE ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_HIT ; animation

	db 1 ; retreat cost
	db WR_LIGHTNING ; weakness
	db NONE ; resistance
	tx BubbleJetName ; category
	db DEX_VAPOREON ; Pokedex number
	db FALSE ; is Dark
	db 29 ; level
	length 1.0 ; length
	weight 29.0 ; weight
	tx VaporeonLv29Description ; description
	db NONE ; AI info

VaporeonLv42Card:
	db TYPE_PKMN_WATER ; type
	dw $2ae9 ; gfx
	tx VaporeonName ; name
	db STAR ; rarity
	db JUNGLE ; real set
	db LEGENDARY_POWER ; in-game set
	dw VAPOREON_LV42
	db 80 ; hp
	db STAGE1 ; stage
	tx EeveeName ; pre-evo name

	; attack 1
	energy COLORLESS, 2 ; energies
	tx QuickAttackName ; name
	tx QuickAttackDescription ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_PLUS ; category
	dw VaporeonLv42QuickAttackEffectCommands ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_QUICK_ATTACK ; animation

	; attack 2
	energy WATER, 2, COLORLESS, 1 ; energies
	tx WaterGunName ; name
	tx Do20DamagePlus10WaterEnergyAltDescription1 ; description
	dw NONE ; description (cont)
	db 30 ; damage
	db DAMAGE_PLUS ; category
	dw VaporeonLv42WaterGunEffectCommands ; effect commands
	db NONE ; flags 1
	db ATTACHED_ENERGY_BOOST  ; flags 2
	db NONE ; flags 3
	db 2 ; ?
	db ATK_ANIM_WATER_GUN ; animation

	db 1 ; retreat cost
	db WR_LIGHTNING ; weakness
	db NONE ; resistance
	tx BubbleJetName ; category
	db DEX_VAPOREON ; Pokedex number
	db FALSE ; is Dark
	db 42 ; level
	length 1.0 ; length
	weight 29.0 ; weight
	tx VaporeonLv42Description ; description
	db NONE ; AI info

DarkVaporeonCard:
	db TYPE_PKMN_WATER ; type
	dw $5f49 ; gfx
	tx DarkVaporeonName ; name
	db DIAMOND ; rarity
	db TEAM_ROCKET ; real set
	db WE_ARE_TEAM_ROCKET ; in-game set
	dw DARK_VAPOREON
	db 60 ; hp
	db STAGE1 ; stage
	tx EeveeName ; pre-evo name

	; attack 1
	energy COLORLESS, 3 ; energies
	tx BiteName ; name
	dw NONE ; description
	dw NONE ; description (cont)
	db 30 ; damage
	db DAMAGE_NORMAL ; category
	dw NONE ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_HIT ; animation

	; attack 2
	energy WATER, 2, COLORLESS, 1 ; energies
	tx WhirlpoolName ; name
	tx WhirlpoolDescription ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_NORMAL ; category
	dw DarkVaporeonWhirlpoolEffectCommands ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db SPECIAL_AI_HANDLING  ; flags 3
	db 0 ; ?
	db ATK_ANIM_WHIRLPOOL ; animation

	db 1 ; retreat cost
	db WR_LIGHTNING ; weakness
	db NONE ; resistance
	tx BubbleJetName ; category
	db DEX_VAPOREON ; Pokedex number
	db TRUE ; is Dark
	db 28 ; level
	length 1.0 ; length
	weight 29.0 ; weight
	tx DarkVaporeonDescription ; description
	db NONE ; AI info

OmanyteLv19Card:
	db TYPE_PKMN_WATER ; type
	dw $2b52 ; gfx
	tx OmanyteName ; name
	db CIRCLE ; rarity
	db FOSSIL ; real set
	db ISLAND_OF_FOSSIL ; in-game set
	dw OMANYTE_LV19
	db 40 ; hp
	db STAGE1 ; stage
	tx MysteriousFossilName ; pre-evo name

	; attack 1
	energy 0 ; energies
	tx ClairvoyanceName ; name
	tx ClairvoyanceDescription ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db POKEMON_POWER ; category
	dw OmanyteLv19ClairvoyanceEffectCommands ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_PKMN_POWER_1 ; animation

	; attack 2
	energy WATER, 1 ; energies
	tx WaterGunName ; name
	tx Do20DamagePlus10WaterEnergyDescription ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_PLUS ; category
	dw OmanyteLv19WaterGunEffectCommands ; effect commands
	db NONE ; flags 1
	db ATTACHED_ENERGY_BOOST  ; flags 2
	db NONE ; flags 3
	db 2 ; ?
	db ATK_ANIM_WATER_GUN ; animation

	db 1 ; retreat cost
	db WR_GRASS ; weakness
	db NONE ; resistance
	tx SpiralName ; category
	db DEX_OMANYTE ; Pokedex number
	db FALSE ; is Dark
	db 19 ; level
	length 0.4 ; length
	weight 7.5 ; weight
	tx OmanyteLv19Description ; description
	db AI_INFO_BENCH_UTILITY | HAS_EVOLUTION ; AI info

OmanyteLv20Card:
	db TYPE_PKMN_WATER ; type
	dw $8a96 ; gfx
	tx OmanyteName ; name
	db DIAMOND ; rarity
	db EXPANSION_SHEET ; real set
	db WE_ARE_TEAM_ROCKET ; in-game set
	dw OMANYTE_LV20
	db 50 ; hp
	db STAGE1 ; stage
	tx MysteriousFossilName ; pre-evo name

	; attack 1
	energy 0 ; energies
	tx PrehistoricDreamName ; name
	tx PrehistoricDreamDescription ; description
	tx PowerCantBeUsedIfStatusDescription ; description (cont)
	db 0 ; damage
	db POKEMON_POWER ; category
	dw OmanyteLv20PrehistoricDreamEffectCommands ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_GLOW_EFFECT ; animation

	; attack 2
	energy COLORLESS, 2 ; energies
	tx RollingTackleName ; name
	dw NONE ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_NORMAL ; category
	dw NONE ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_HIT ; animation

	db 1 ; retreat cost
	db WR_GRASS ; weakness
	db NONE ; resistance
	tx SpiralName ; category
	db DEX_OMANYTE ; Pokedex number
	db FALSE ; is Dark
	db 20 ; level
	length 0.4 ; length
	weight 7.5 ; weight
	tx OmanyteSharedDescription ; description
	db NONE | HAS_EVOLUTION ; AI info

OmanyteLv22Card:
	db TYPE_PKMN_WATER ; type
	dw $9d55 ; gfx
	tx OmanyteName ; name
	db DIAMOND ; rarity
	db EXPANSION_SHEET ; real set
	db SKY_FLYING_POKEMON ; in-game set
	dw OMANYTE_LV22
	db 50 ; hp
	db STAGE1 ; stage
	tx MysteriousFossilName ; pre-evo name

	; attack 1
	energy 0 ; energies
	tx FossilGuidanceName ; name
	tx FossilGuidanceDescription ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db POKEMON_POWER ; category
	dw OmanyteLv22FossilGuidanceEffectCommands ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_GLOW_EFFECT ; animation

	; attack 2
	energy WATER, 2 ; energies
	tx SurfName ; name
	dw NONE ; description
	dw NONE ; description (cont)
	db 30 ; damage
	db DAMAGE_NORMAL ; category
	dw NONE ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_WATER_JETS ; animation

	db 1 ; retreat cost
	db WR_GRASS ; weakness
	db NONE ; resistance
	tx SpiralName ; category
	db DEX_OMANYTE ; Pokedex number
	db FALSE ; is Dark
	db 22 ; level
	length 0.4 ; length
	weight 7.5 ; weight
	tx OmanyteSharedDescription ; description
	db NONE | HAS_EVOLUTION ; AI info

OmastarLv32Card:
	db TYPE_PKMN_WATER ; type
	dw $2bbb ; gfx
	tx OmastarName ; name
	db DIAMOND ; rarity
	db FOSSIL ; real set
	db ISLAND_OF_FOSSIL ; in-game set
	dw OMASTAR_LV32
	db 70 ; hp
	db STAGE2 ; stage
	tx OmanyteName ; pre-evo name

	; attack 1
	energy WATER, 1, COLORLESS, 1 ; energies
	tx WaterGunName ; name
	tx Do20DamagePlus10WaterEnergyDescription ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_PLUS ; category
	dw OmastarLv32WaterGunEffectCommands ; effect commands
	db NONE ; flags 1
	db ATTACHED_ENERGY_BOOST  ; flags 2
	db NONE ; flags 3
	db 2 ; ?
	db ATK_ANIM_WATER_GUN ; animation

	; attack 2
	energy WATER, 2 ; energies
	tx SpikeCannonName ; name
	tx Do30DamageNumberOfHeadsDescription ; description
	dw NONE ; description (cont)
	db 30 ; damage
	db DAMAGE_X ; category
	dw OmastarLv32SpikeCannonEffectCommands ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_NEEDLES ; animation

	db 1 ; retreat cost
	db WR_GRASS ; weakness
	db NONE ; resistance
	tx SpiralName ; category
	db DEX_OMASTAR ; Pokedex number
	db FALSE ; is Dark
	db 32 ; level
	length 1.0 ; length
	weight 35.0 ; weight
	tx OmastarLv32Description ; description
	db NONE ; AI info

OmastarLv36Card:
	db TYPE_PKMN_WATER ; type
	dw $9dbe ; gfx
	tx OmastarName ; name
	db STAR ; rarity
	db EXPANSION_SHEET ; real set
	db PROMOTIONAL ; in-game set
	dw OMASTAR_LV36
	db 80 ; hp
	db STAGE2 ; stage
	tx OmanyteName ; pre-evo name

	; attack 1
	energy WATER, 1 ; energies
	tx TentacleGripName ; name
	tx TentacleGripDescription ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db RESIDUAL ; category
	dw OmastarLv36TentacleGripEffectCommands ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db SPECIAL_AI_HANDLING | FLAG_3_BIT_2  ; flags 3
	db 0 ; ?
	db ATK_ANIM_GLOW_EFFECT ; animation

	; attack 2
	energy WATER, 3 ; energies
	tx CorrosiveAcidName ; name
	tx CorrosiveAcidDescription ; description
	dw NONE ; description (cont)
	db 40 ; damage
	db DAMAGE_NORMAL ; category
	dw OmastarLv36CorrosiveAcidEffectCommands ; effect commands
	db INFLICT_PARALYSIS  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_STICKY_HANDS ; animation

	db 2 ; retreat cost
	db WR_GRASS ; weakness
	db NONE ; resistance
	tx SpiralName ; category
	db DEX_OMASTAR ; Pokedex number
	db FALSE ; is Dark
	db 36 ; level
	length 1.0 ; length
	weight 35.0 ; weight
	tx OmastarLv36Description ; description
	db NONE ; AI info

ArticunoLv34Card:
	db TYPE_PKMN_WATER ; type
	dw $8bf5 ; gfx
	tx ArticunoName ; name
	db STAR ; rarity
	db EXPANSION_SHEET ; real set
	db TEAM_ROCKETS_AMBITION ; in-game set
	dw ARTICUNO_LV34
	db 80 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy 0 ; energies
	tx AuroraVeilName ; name
	tx AuroraVeilDescription ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db POKEMON_POWER ; category
	dw ArticunoLv34AuroraVeilEffectCommands ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_NONE ; animation

	; attack 2
	energy WATER, 2, COLORLESS, 2 ; energies
	tx IceBeamName ; name
	tx MayInflictParalysisAltDescription ; description
	dw NONE ; description (cont)
	db 30 ; damage
	db DAMAGE_NORMAL ; category
	dw ArticunoLv34IceBeamEffectCommands ; effect commands
	db INFLICT_PARALYSIS  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_ICE_BEAM ; animation

	db 2 ; retreat cost
	db NONE ; weakness
	db WR_FIGHTING ; resistance
	tx FreezeName ; category
	db DEX_ARTICUNO ; Pokedex number
	db FALSE ; is Dark
	db 34 ; level
	length 1.7 ; length
	weight 55.4 ; weight
	tx ArticunoLv34Description ; description
	db NONE ; AI info

ArticunoLv35Card:
	db TYPE_PKMN_WATER ; type
	dw $2c3c ; gfx
	tx ArticunoName ; name
	db STAR ; rarity
	db FOSSIL ; real set
	db ISLAND_OF_FOSSIL ; in-game set
	dw ARTICUNO_LV35
	db 70 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy WATER, 3 ; energies
	tx FreezeDryName ; name
	tx MayInflictParalysisDescription ; description
	dw NONE ; description (cont)
	db 30 ; damage
	db DAMAGE_NORMAL ; category
	dw ArticunoLv35FreezeDryEffectCommands ; effect commands
	db INFLICT_PARALYSIS  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_BEAM ; animation

	; attack 2
	energy WATER, 4 ; energies
	tx BlizzardName ; name
	tx BlizzardDescription ; description
	dw NONE ; description (cont)
	db 50 ; damage
	db DAMAGE_NORMAL ; category
	dw ArticunoLv35BlizzardEffectCommands ; effect commands
	db DAMAGE_TO_OPPONENT_BENCH  ; flags 1
	db NONE ; flags 2
	db FLAG_3_BIT_2  ; flags 3
	db 10 ; ?
	db ATK_ANIM_BLIZZARD ; animation

	db 2 ; retreat cost
	db NONE ; weakness
	db WR_FIGHTING ; resistance
	tx FreezeName ; category
	db DEX_ARTICUNO ; Pokedex number
	db FALSE ; is Dark
	db 35 ; level
	length 1.7 ; length
	weight 55.4 ; weight
	tx ArticunoLv35Description ; description
	db NONE ; AI info

ArticunoLv37Card:
	db TYPE_PKMN_WATER ; type
	dw $2ca5 ; gfx
	tx ArticunoName ; name
	db STAR ; rarity
	db GB ; real set
	db PROMOTIONAL ; in-game set
	dw ARTICUNO_LV37
	db 100 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy 0 ; energies
	tx QuickfreezeName ; name
	tx QuickfreezeDescription ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db POKEMON_POWER ; category
	dw ArticunoLv37QuickfreezeEffectCommands ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_QUICKFREEZE ; animation

	; attack 2
	energy WATER, 3 ; energies
	tx IceBreathName ; name
	tx IceBreathDescription ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db RESIDUAL ; category
	dw ArticunoLv37IceBreathEffectCommands ; effect commands
	db DAMAGE_TO_OPPONENT_BENCH  ; flags 1
	db FLAG_2_BIT_6  ; flags 2
	db FLAG_3_BIT_2  ; flags 3
	db 3 ; ?
	db ATK_ANIM_WHIRLWIND_ZIGZAG ; animation

	db 2 ; retreat cost
	db NONE ; weakness
	db WR_FIGHTING ; resistance
	tx FreezeName ; category
	db DEX_ARTICUNO ; Pokedex number
	db FALSE ; is Dark
	db 37 ; level
	length 1.7 ; length
	weight 55.4 ; weight
	tx ArticunoLv37Description ; description
	db NONE ; AI info

MarillCard:
	db TYPE_PKMN_WATER ; type
	dw $a60e ; gfx
	tx MarillName ; name
	db PROMOSTAR ; rarity
	db PRO ; real set
	db PROMOTIONAL ; in-game set
	dw MARILL
	db 50 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy WATER, 2 ; energies
	tx WaterGunName ; name
	tx Do20DamagePlus10WaterEnergyAltDescription2 ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_PLUS ; category
	dw MarillWaterGunEffectCommands ; effect commands
	db NONE ; flags 1
	db ATTACHED_ENERGY_BOOST  ; flags 2
	db NONE ; flags 3
	db 2 ; ?
	db ATK_ANIM_WATER_GUN ; animation

	; attack 2
	energy 0 ; energies
	dw NONE ; name
	dw NONE ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db DAMAGE_NORMAL ; category
	dw NONE ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_NONE ; animation

	db 1 ; retreat cost
	db WR_LIGHTNING ; weakness
	db NONE ; resistance
	tx AquamouseName ; category
	db DEX_MARILL ; Pokedex number
	db FALSE ; is Dark
	db 17 ; level
	length 0.4 ; length
	weight 8.5 ; weight
	tx MarillDescription ; description
	db NONE ; AI info

PikachuLv5Card:
	db TYPE_PKMN_LIGHTNING ; type
	dw $7543 ; gfx
	tx PikachuName ; name
	db DIAMOND ; rarity
	db EXPANSION_SHEET ; real set
	db SKY_FLYING_POKEMON ; in-game set
	dw PIKACHU_LV5
	db 30 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy LIGHTNING, 1 ; energies
	tx ThundershockName ; name
	tx MayInflictParalysisAltDescription ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_NORMAL ; category
	dw PikachuLv5ThundershockEffectCommands ; effect commands
	db INFLICT_PARALYSIS  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_THUNDERSHOCK_COPY ; animation

	; attack 2
	energy LIGHTNING, 2 ; energies
	tx AgilityName ; name
	tx AgilityDescription ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_NORMAL ; category
	dw PikachuLv5AgilityEffectCommands ; effect commands
	db NONE ; flags 1
	db NULLIFY_OR_WEAKEN_ATTACK  ; flags 2
	db FLAG_3_BIT_2  ; flags 3
	db 0 ; ?
	db ATK_ANIM_AGILITY_PROTECT ; animation

	db 0 ; retreat cost
	db WR_FIGHTING ; weakness
	db NONE ; resistance
	tx MouseName ; category
	db DEX_PIKACHU ; Pokedex number
	db FALSE ; is Dark
	db 5 ; level
	length 0.4 ; length
	weight 6.0 ; weight
	tx PikachuLv5Description ; description
	db NONE | HAS_EVOLUTION ; AI info

PikachuLv12Card:
	db TYPE_PKMN_LIGHTNING ; type
	dw $2d0e ; gfx
	tx PikachuName ; name
	db CIRCLE ; rarity
	db BASE_SET ; real set
	db BEGINNING_POKEMON ; in-game set
	dw PIKACHU_LV12
	db 40 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy COLORLESS, 1 ; energies
	tx GnawName ; name
	dw NONE ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_NORMAL ; category
	dw NONE ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_HIT ; animation

	; attack 2
	energy LIGHTNING, 1, COLORLESS, 1 ; energies
	tx ThunderJoltName ; name
	tx ThunderJoltDescription ; description
	dw NONE ; description (cont)
	db 30 ; damage
	db DAMAGE_NORMAL ; category
	dw PikachuLv12ThunderJoltEffectCommands ; effect commands
	db LOW_RECOIL  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_THUNDERSHOCK ; animation

	db 1 ; retreat cost
	db WR_FIGHTING ; weakness
	db NONE ; resistance
	tx MouseName ; category
	db DEX_PIKACHU ; Pokedex number
	db FALSE ; is Dark
	db 12 ; level
	length 0.4 ; length
	weight 6.0 ; weight
	tx PikachuSharedDescription ; description
	db AI_INFO_UNK_03 | HAS_EVOLUTION ; AI info

PikachuLv13Card:
	db TYPE_PKMN_LIGHTNING ; type
	dw $a0d2 ; gfx
	tx PikachuName ; name
	db STAR ; rarity
	db PRO ; real set
	db PROMOTIONAL ; in-game set
	dw PIKACHU_LV13
	db 50 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy LIGHTNING, 1 ; energies
	tx RechargeName ; name
	tx RechargeDescription ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db RESIDUAL ; category
	dw PikachuLv13RechargeEffectCommands ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db SPECIAL_AI_HANDLING | FLAG_3_BIT_2  ; flags 3
	db 0 ; ?
	db ATK_ANIM_GLOW_EFFECT ; animation

	; attack 2
	energy LIGHTNING, 3 ; energies
	tx ThunderboltName ; name
	tx ThunderboltDescription ; description
	dw NONE ; description (cont)
	db 50 ; damage
	db DAMAGE_NORMAL ; category
	dw PikachuLv13ThunderboltEffectCommands ; effect commands
	db NONE ; flags 1
	db DISCARD_ENERGY  ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_THUNDERBOLT ; animation

	db 1 ; retreat cost
	db WR_FIGHTING ; weakness
	db NONE ; resistance
	tx MouseName ; category
	db DEX_PIKACHU ; Pokedex number
	db FALSE ; is Dark
	db 13 ; level
	length 0.4 ; length
	weight 6.0 ; weight
	tx PikachuLv13Description ; description
	db NONE | HAS_EVOLUTION ; AI info

PikachuLv14Card:
	db TYPE_PKMN_LIGHTNING ; type
	dw $2d77 ; gfx
	tx PikachuName ; name
	db CIRCLE ; rarity
	db JUNGLE ; real set
	db ISLAND_OF_FOSSIL ; in-game set
	dw PIKACHU_LV14
	db 50 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy LIGHTNING, 2 ; energies
	tx SparkName ; name
	tx Do10DamageToABenchedMonDescription ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_NORMAL ; category
	dw PikachuLv14SparkEffectCommands ; effect commands
	db DAMAGE_TO_OPPONENT_BENCH  ; flags 1
	db NONE ; flags 2
	db FLAG_3_BIT_2  ; flags 3
	db 10 ; ?
	db ATK_ANIM_THUNDER_WHOLE_SCREEN ; animation

	; attack 2
	energy 0 ; energies
	dw NONE ; name
	dw NONE ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db DAMAGE_NORMAL ; category
	dw NONE ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_NONE ; animation

	db 1 ; retreat cost
	db WR_FIGHTING ; weakness
	db NONE ; resistance
	tx MouseName ; category
	db DEX_PIKACHU ; Pokedex number
	db FALSE ; is Dark
	db 14 ; level
	length 0.4 ; length
	weight 6.0 ; weight
	tx PikachuLv14Description ; description
	db NONE | HAS_EVOLUTION ; AI info

PikachuLv16Card:
	db TYPE_PKMN_LIGHTNING ; type
	dw $2de0 ; gfx
	tx PikachuName ; name
	db PROMOSTAR ; rarity
	db PRO ; real set
	db PROMOTIONAL ; in-game set
	dw PIKACHU_LV16
	db 60 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy COLORLESS, 1 ; energies
	tx GrowlName ; name
	tx GrowlAltDescription1 ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db DAMAGE_NORMAL ; category
	dw PikachuLv16GrowlEffectCommands ; effect commands
	db NONE ; flags 1
	db NULLIFY_OR_WEAKEN_ATTACK  ; flags 2
	db NONE ; flags 3
	db 10 ; ?
	db ATK_ANIM_SUPERSONIC ; animation

	; attack 2
	energy LIGHTNING, 2 ; energies
	tx ThundershockName ; name
	tx MayInflictParalysisAltDescription ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_NORMAL ; category
	dw PikachuLv16ThundershockEffectCommands ; effect commands
	db INFLICT_PARALYSIS  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_THUNDERSHOCK ; animation

	db 1 ; retreat cost
	db WR_FIGHTING ; weakness
	db NONE ; resistance
	tx MouseName ; category
	db DEX_PIKACHU ; Pokedex number
	db FALSE ; is Dark
	db 16 ; level
	length 0.4 ; length
	weight 6.0 ; weight
	tx PikachuSharedDescription ; description
	db NONE | HAS_EVOLUTION ; AI info

PikachuAltLv16Card:
	db TYPE_PKMN_LIGHTNING ; type
	dw $2ea9 ; gfx
	tx PikachuName ; name
	db PROMOSTAR ; rarity
	db PRO ; real set
	db PROMOTIONAL ; in-game set
	dw PIKACHU_ALT_LV16
	db 60 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy COLORLESS, 1 ; energies
	tx GrowlName ; name
	tx GrowlAltDescription1 ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db DAMAGE_NORMAL ; category
	dw PikachuAltLv16GrowlEffectCommands ; effect commands
	db NONE ; flags 1
	db NULLIFY_OR_WEAKEN_ATTACK  ; flags 2
	db NONE ; flags 3
	db 10 ; ?
	db ATK_ANIM_SUPERSONIC ; animation

	; attack 2
	energy LIGHTNING, 2 ; energies
	tx ThundershockName ; name
	tx MayInflictParalysisAltDescription ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_NORMAL ; category
	dw PikachuAltLv16ThundershockEffectCommands ; effect commands
	db INFLICT_PARALYSIS  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_THUNDERSHOCK ; animation

	db 1 ; retreat cost
	db WR_FIGHTING ; weakness
	db NONE ; resistance
	tx MouseName ; category
	db DEX_PIKACHU ; Pokedex number
	db FALSE ; is Dark
	db 16 ; level
	length 0.4 ; length
	weight 6.0 ; weight
	tx PikachuSharedDescription ; description
	db NONE | HAS_EVOLUTION ; AI info

FlyingPikachuLv12Card:
	db TYPE_PKMN_LIGHTNING ; type
	dw $2f18 ; gfx
	tx FlyingPikachuName ; name
	db PROMOSTAR ; rarity
	db PRO ; real set
	db PROMOTIONAL ; in-game set
	dw FLYING_PIKACHU_LV12
	db 40 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy LIGHTNING, 1 ; energies
	tx ThundershockName ; name
	tx MayInflictParalysisAltDescription ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_NORMAL ; category
	dw FlyingPikachuLv12ThundershockEffectCommands ; effect commands
	db INFLICT_PARALYSIS  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_THUNDERSHOCK ; animation

	; attack 2
	energy COLORLESS, 3 ; energies
	tx FlyName ; name
	tx FlyDescription ; description
	dw NONE ; description (cont)
	db 30 ; damage
	db DAMAGE_NORMAL ; category
	dw FlyingPikachuLv12FlyEffectCommands ; effect commands
	db NONE ; flags 1
	db NULLIFY_OR_WEAKEN_ATTACK  ; flags 2
	db FLAG_3_BIT_2  ; flags 3
	db 0 ; ?
	db ATK_ANIM_QUICK_ATTACK ; animation

	db 1 ; retreat cost
	db NONE ; weakness
	db WR_FIGHTING ; resistance
	tx MouseName ; category
	db DEX_PIKACHU ; Pokedex number
	db FALSE ; is Dark
	db 12 ; level
	length 0.4 ; length
	weight 6.0 ; weight
	tx FlyingPikachuDescription ; description
	db AI_INFO_UNK_03 ; AI info

FlyingPikachuAltLv12Card:
	db TYPE_PKMN_LIGHTNING ; type
	dw $a53a ; gfx
	tx FlyingPikachuName ; name
	db PROMOSTAR ; rarity
	db PRO ; real set
	db PROMOTIONAL ; in-game set
	dw FLYING_PIKACHU_ALT_LV12
	db 40 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy LIGHTNING, 1 ; energies
	tx ThundershockName ; name
	tx MayInflictParalysisAltDescription ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_NORMAL ; category
	dw FlyingPikachuAltLv12ThundershockEffectCommands ; effect commands
	db INFLICT_PARALYSIS  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_THUNDERSHOCK ; animation

	; attack 2
	energy COLORLESS, 3 ; energies
	tx FlyName ; name
	tx FlyDescription ; description
	dw NONE ; description (cont)
	db 30 ; damage
	db DAMAGE_NORMAL ; category
	dw FlyingPikachuAltLv12FlyEffectCommands ; effect commands
	db NONE ; flags 1
	db NULLIFY_OR_WEAKEN_ATTACK  ; flags 2
	db FLAG_3_BIT_2  ; flags 3
	db 0 ; ?
	db ATK_ANIM_QUICK_ATTACK ; animation

	db 1 ; retreat cost
	db NONE ; weakness
	db WR_FIGHTING ; resistance
	tx MouseName ; category
	db DEX_PIKACHU ; Pokedex number
	db FALSE ; is Dark
	db 12 ; level
	length 0.4 ; length
	weight 6.0 ; weight
	tx FlyingPikachuDescription ; description
	db AI_INFO_UNK_03 ; AI info

SurfingPikachuLv13Card:
	db TYPE_PKMN_LIGHTNING ; type
	dw $3000 ; gfx
	tx SurfingPikachuName ; name
	db PROMOSTAR ; rarity
	db PRO ; real set
	db PROMOTIONAL ; in-game set
	dw SURFING_PIKACHU_LV13
	db 50 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy WATER, 2 ; energies
	tx SurfName ; name
	dw NONE ; description
	dw NONE ; description (cont)
	db 30 ; damage
	db DAMAGE_NORMAL ; category
	dw NONE ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_WATER_JETS ; animation

	; attack 2
	energy 0 ; energies
	dw NONE ; name
	dw NONE ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db DAMAGE_NORMAL ; category
	dw NONE ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_NONE ; animation

	db 1 ; retreat cost
	db WR_FIGHTING ; weakness
	db NONE ; resistance
	tx MouseName ; category
	db DEX_PIKACHU ; Pokedex number
	db FALSE ; is Dark
	db 13 ; level
	length 0.4 ; length
	weight 6.0 ; weight
	tx SurfingPikachuDescription ; description
	db NONE ; AI info

SurfingPikachuAltLv13Card:
	db TYPE_PKMN_LIGHTNING ; type
	dw $30ab ; gfx
	tx SurfingPikachuName ; name
	db PROMOSTAR ; rarity
	db PRO ; real set
	db PROMOTIONAL ; in-game set
	dw SURFING_PIKACHU_ALT_LV13
	db 50 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy WATER, 2 ; energies
	tx SurfName ; name
	dw NONE ; description
	dw NONE ; description (cont)
	db 30 ; damage
	db DAMAGE_NORMAL ; category
	dw NONE ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_WATER_JETS ; animation

	; attack 2
	energy 0 ; energies
	dw NONE ; name
	dw NONE ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db DAMAGE_NORMAL ; category
	dw NONE ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_NONE ; animation

	db 1 ; retreat cost
	db WR_FIGHTING ; weakness
	db NONE ; resistance
	tx MouseName ; category
	db DEX_PIKACHU ; Pokedex number
	db FALSE ; is Dark
	db 13 ; level
	length 0.4 ; length
	weight 6.0 ; weight
	tx SurfingPikachuDescription ; description
	db NONE ; AI info

RaichuLv32Card:
	db TYPE_PKMN_LIGHTNING ; type
	dw $8263 ; gfx
	tx RaichuName ; name
	db STAR ; rarity
	db EXPANSION_SHEET ; real set
	db SKY_FLYING_POKEMON ; in-game set
	dw RAICHU_LV32
	db 70 ; hp
	db STAGE1 ; stage
	tx PikachuName ; pre-evo name

	; attack 1
	energy LIGHTNING, 2 ; energies
	tx ShortCircuitName ; name
	tx ShortCircuitDescription ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db RESIDUAL ; category
	dw RaichuLv32ShortCircuitEffectCommands ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db SPECIAL_AI_HANDLING | FLAG_3_BIT_2  ; flags 3
	db 0 ; ?
	db ATK_ANIM_THUNDERSHOCK ; animation

	; attack 2
	energy LIGHTNING, 2, COLORLESS, 1 ; energies
	tx SparkingKickName ; name
	tx MayInflictParalysisAltDescription ; description
	dw NONE ; description (cont)
	db 30 ; damage
	db DAMAGE_NORMAL ; category
	dw RaichuLv32SparkingKickEffectCommands ; effect commands
	db INFLICT_PARALYSIS  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_SPARKING_KICK ; animation

	db 1 ; retreat cost
	db WR_FIGHTING ; weakness
	db NONE ; resistance
	tx MouseName ; category
	db DEX_RAICHU ; Pokedex number
	db FALSE ; is Dark
	db 32 ; level
	length 0.8 ; length
	weight 30.0 ; weight
	tx RaichuLv32Description ; description
	db NONE ; AI info

RaichuLv33Card:
	db TYPE_PKMN_LIGHTNING ; type
	dw $bf5a ; gfx
	tx RaichuName ; name
	db STAR ; rarity
	db BULBASAUR_DECK ; real set
	db BEGINNING_POKEMON ; in-game set
	dw RAICHU_LV33
	db 70 ; hp
	db STAGE1 ; stage
	tx PikachuName ; pre-evo name

	; attack 1
	energy COLORLESS, 2 ; energies
	tx QuickAttackName ; name
	tx QuickAttackAltDescription1 ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_PLUS ; category
	dw RaichuLv33QuickAttackEffectCommands ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_QUICK_ATTACK ; animation

	; attack 2
	energy LIGHTNING, 3 ; energies
	tx ThunderboltName ; name
	tx ThunderboltAltDescription1 ; description
	dw NONE ; description (cont)
	db 60 ; damage
	db DAMAGE_NORMAL ; category
	dw RaichuLv33ThunderboltEffectCommands ; effect commands
	db NONE ; flags 1
	db DISCARD_ENERGY  ; flags 2
	db NONE ; flags 3
	db 9 ; ?
	db ATK_ANIM_THUNDERBOLT ; animation

	db 1 ; retreat cost
	db WR_FIGHTING ; weakness
	db NONE ; resistance
	tx MouseName ; category
	db DEX_RAICHU ; Pokedex number
	db FALSE ; is Dark
	db 33 ; level
	length 0.8 ; length
	weight 30.0 ; weight
	tx RaichuLv33Description ; description
	db NONE ; AI info

RaichuLv40Card:
	db TYPE_PKMN_LIGHTNING ; type
	dw $311e ; gfx
	tx RaichuName ; name
	db STAR ; rarity
	db BASE_SET ; real set
	db PSYCHIC_BATTLE ; in-game set
	dw RAICHU_LV40
	db 80 ; hp
	db STAGE1 ; stage
	tx PikachuName ; pre-evo name

	; attack 1
	energy LIGHTNING, 1, COLORLESS, 2 ; energies
	tx AgilityName ; name
	tx AgilityDescription ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_NORMAL ; category
	dw RaichuLv40AgilityEffectCommands ; effect commands
	db NONE ; flags 1
	db NULLIFY_OR_WEAKEN_ATTACK  ; flags 2
	db FLAG_3_BIT_2  ; flags 3
	db 0 ; ?
	db ATK_ANIM_QUICK_ATTACK ; animation

	; attack 2
	energy LIGHTNING, 3, COLORLESS, 1 ; energies
	tx ThunderName ; name
	tx ThunderDescription ; description
	dw NONE ; description (cont)
	db 60 ; damage
	db DAMAGE_NORMAL ; category
	dw RaichuLv40ThunderEffectCommands ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_THUNDER ; animation

	db 1 ; retreat cost
	db WR_FIGHTING ; weakness
	db NONE ; resistance
	tx MouseName ; category
	db DEX_RAICHU ; Pokedex number
	db FALSE ; is Dark
	db 40 ; level
	length 0.8 ; length
	weight 30.0 ; weight
	tx RaichuSharedDescription ; description
	db NONE ; AI info

RaichuLv45Card:
	db TYPE_PKMN_LIGHTNING ; type
	dw $3187 ; gfx
	tx RaichuName ; name
	db STAR ; rarity
	db FOSSIL ; real set
	db ISLAND_OF_FOSSIL ; in-game set
	dw RAICHU_LV45
	db 90 ; hp
	db STAGE1 ; stage
	tx PikachuName ; pre-evo name

	; attack 1
	energy LIGHTNING, 4 ; energies
	tx GigashockName ; name
	tx GigashockDescription ; description
	dw NONE ; description (cont)
	db 30 ; damage
	db DAMAGE_NORMAL ; category
	dw RaichuLv45GigashockEffectCommands ; effect commands
	db DAMAGE_TO_OPPONENT_BENCH  ; flags 1
	db NONE ; flags 2
	db FLAG_3_BIT_2  ; flags 3
	db 10 ; ?
	db ATK_ANIM_THUNDER_WHOLE_SCREEN ; animation

	; attack 2
	energy 0 ; energies
	dw NONE ; name
	dw NONE ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db DAMAGE_NORMAL ; category
	dw NONE ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_NONE ; animation

	db 1 ; retreat cost
	db WR_FIGHTING ; weakness
	db NONE ; resistance
	tx MouseName ; category
	db DEX_RAICHU ; Pokedex number
	db FALSE ; is Dark
	db 45 ; level
	length 0.8 ; length
	weight 30.0 ; weight
	tx RaichuSharedDescription ; description
	db NONE ; AI info

DarkRaichuCard:
	db TYPE_PKMN_LIGHTNING ; type
	dw $c78d ; gfx
	tx DarkRaichuName ; name
	db STAR ; rarity
	db GB ; real set
	db TEAM_ROCKETS_AMBITION ; in-game set
	dw DARK_RAICHU
	db 70 ; hp
	db STAGE1 ; stage
	tx PikachuName ; pre-evo name

	; attack 1
	energy LIGHTNING, 3 ; energies
	tx SurpriseThunderName ; name
	tx SurpriseThunderDescription ; description
	dw NONE ; description (cont)
	db 30 ; damage
	db DAMAGE_NORMAL ; category
	dw DarkRaichuSurpriseThunderEffectCommands ; effect commands
	db DAMAGE_TO_OPPONENT_BENCH  ; flags 1
	db NONE ; flags 2
	db FLAG_3_BIT_2  ; flags 3
	db 0 ; ?
	db ATK_ANIM_SURPRISE_THUNDER ; animation

	; attack 2
	energy 0 ; energies
	dw NONE ; name
	dw NONE ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db DAMAGE_NORMAL ; category
	dw NONE ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_NONE ; animation

	db 1 ; retreat cost
	db WR_FIGHTING ; weakness
	db NONE ; resistance
	tx MouseName ; category
	db DEX_RAICHU ; Pokedex number
	db TRUE ; is Dark
	db 31 ; level
	length 0.8 ; length
	weight 30.0 ; weight
	tx DarkRaichuDescription ; description
	db NONE ; AI info

MagnemiteLv12Card:
	db TYPE_PKMN_LIGHTNING ; type
	dw $6f04 ; gfx
	tx MagnemiteName ; name
	db CIRCLE ; rarity
	db TEAM_ROCKET ; real set
	db WE_ARE_TEAM_ROCKET ; in-game set
	dw MAGNEMITE_LV12
	db 40 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy COLORLESS, 2 ; energies
	tx TackleName ; name
	dw NONE ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_NORMAL ; category
	dw NONE ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_HIT ; animation

	; attack 2
	energy LIGHTNING, 1, COLORLESS, 1 ; energies
	tx MagnetismName ; name
	tx MagnetismDescription ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_PLUS ; category
	dw MagnemiteLv12MagnetismEffectCommands ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_THUNDER_WAVE ; animation

	db 1 ; retreat cost
	db WR_FIGHTING ; weakness
	db NONE ; resistance
	tx MagnetCategoryName ; category
	db DEX_MAGNEMITE ; Pokedex number
	db FALSE ; is Dark
	db 12 ; level
	length 0.3 ; length
	weight 6.0 ; weight
	tx MagnemiteLv12Description ; description
	db NONE | HAS_EVOLUTION ; AI info

MagnemiteLv13Card:
	db TYPE_PKMN_LIGHTNING ; type
	dw $31f0 ; gfx
	tx MagnemiteName ; name
	db CIRCLE ; rarity
	db BASE_SET ; real set
	db PSYCHIC_BATTLE ; in-game set
	dw MAGNEMITE_LV13
	db 40 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy LIGHTNING, 1 ; energies
	tx ThunderWaveName ; name
	tx MayInflictParalysisDescription ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_NORMAL ; category
	dw MagnemiteLv13ThunderWaveEffectCommands ; effect commands
	db INFLICT_PARALYSIS  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_THUNDER_WAVE ; animation

	; attack 2
	energy LIGHTNING, 1, COLORLESS, 1 ; energies
	tx SelfdestructName ; name
	tx Selfdestruct40DamageDescription ; description
	dw NONE ; description (cont)
	db 40 ; damage
	db DAMAGE_NORMAL ; category
	dw MagnemiteLv13SelfdestructEffectCommands ; effect commands
	db HIGH_RECOIL  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 40 ; ?
	db ATK_ANIM_SELFDESTRUCT ; animation

	db 1 ; retreat cost
	db WR_FIGHTING ; weakness
	db NONE ; resistance
	tx MagnetCategoryName ; category
	db DEX_MAGNEMITE ; Pokedex number
	db FALSE ; is Dark
	db 13 ; level
	length 0.3 ; length
	weight 6.0 ; weight
	tx MagnemiteLv13Description ; description
	db AI_INFO_UNK_03 | HAS_EVOLUTION ; AI info

MagnemiteLv14Card:
	db TYPE_PKMN_LIGHTNING ; type
	dw $3271 ; gfx
	tx MagnemiteName ; name
	db CIRCLE ; rarity
	db GB ; real set
	db LEGENDARY_POWER ; in-game set
	dw MAGNEMITE_LV14
	db 40 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy COLORLESS, 1 ; energies
	tx TackleName ; name
	dw NONE ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_NORMAL ; category
	dw NONE ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_HIT ; animation

	; attack 2
	energy LIGHTNING, 1, COLORLESS, 1 ; energies
	tx MagneticStormName ; name
	tx MagneticStormDescription ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db RESIDUAL ; category
	dw MagnemiteLv14MagneticStormEffectCommands ; effect commands
	db NONE ; flags 1
	db FLAG_2_BIT_5  ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_MAGNETIC_STORM ; animation

	db 1 ; retreat cost
	db WR_FIGHTING ; weakness
	db NONE ; resistance
	tx MagnetCategoryName ; category
	db DEX_MAGNEMITE ; Pokedex number
	db FALSE ; is Dark
	db 14 ; level
	length 0.3 ; length
	weight 6.0 ; weight
	tx MagnemiteLv14Description ; description
	db AI_INFO_UNK_03 | HAS_EVOLUTION ; AI info

MagnemiteLv15Card:
	db TYPE_PKMN_LIGHTNING ; type
	dw $8559 ; gfx
	tx MagnemiteName ; name
	db CIRCLE ; rarity
	db EXPANSION_SHEET ; real set
	db SKY_FLYING_POKEMON ; in-game set
	dw MAGNEMITE_LV15
	db 40 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy 0 ; energies
	tx MagnetMoveName ; name
	tx MagnetMoveDescription ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db POKEMON_POWER ; category
	dw MagnemiteLv15MagnetMoveEffectCommands ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_GLOW_EFFECT ; animation

	; attack 2
	energy LIGHTNING, 1 ; energies
	tx SuperconductivityName ; name
	tx SuperconductivityDescription ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db RESIDUAL ; category
	dw MagnemiteLv15SuperconductivityEffectCommands ; effect commands
	db DAMAGE_TO_OPPONENT_BENCH  ; flags 1
	db FLAG_2_BIT_6  ; flags 2
	db FLAG_3_BIT_2  ; flags 3
	db 0 ; ?
	db ATK_ANIM_THUNDER_WAVE ; animation

	db 1 ; retreat cost
	db WR_FIGHTING ; weakness
	db NONE ; resistance
	tx MagnetCategoryName ; category
	db DEX_MAGNEMITE ; Pokedex number
	db FALSE ; is Dark
	db 15 ; level
	length 0.3 ; length
	weight 6.0 ; weight
	tx MagnemiteLv15Description ; description
	db NONE | HAS_EVOLUTION ; AI info

MagnetonLv28Card:
	db TYPE_PKMN_LIGHTNING ; type
	dw $32dc ; gfx
	tx MagnetonName ; name
	db STAR ; rarity
	db BASE_SET ; real set
	db PSYCHIC_BATTLE ; in-game set
	dw MAGNETON_LV28
	db 60 ; hp
	db STAGE1 ; stage
	tx MagnemiteName ; pre-evo name

	; attack 1
	energy LIGHTNING, 2, COLORLESS, 1 ; energies
	tx ThunderWaveName ; name
	tx MayInflictParalysisDescription ; description
	dw NONE ; description (cont)
	db 30 ; damage
	db DAMAGE_NORMAL ; category
	dw MagnetonLv28ThunderWaveEffectCommands ; effect commands
	db INFLICT_PARALYSIS  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_THUNDER_WAVE ; animation

	; attack 2
	energy LIGHTNING, 2, COLORLESS, 2 ; energies
	tx SelfdestructName ; name
	tx Selfdestruct80DamageDescription ; description
	dw NONE ; description (cont)
	db 80 ; damage
	db DAMAGE_NORMAL ; category
	dw MagnetonLv28SelfdestructEffectCommands ; effect commands
	db HIGH_RECOIL  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 80 ; ?
	db ATK_ANIM_BIG_SELFDESTRUCTION ; animation

	db 1 ; retreat cost
	db WR_FIGHTING ; weakness
	db NONE ; resistance
	tx MagnetCategoryName ; category
	db DEX_MAGNETON ; Pokedex number
	db FALSE ; is Dark
	db 28 ; level
	length 1.0 ; length
	weight 60.0 ; weight
	tx MagnetonSharedDescription ; description
	db NONE ; AI info

MagnetonLv30Card:
	db TYPE_PKMN_LIGHTNING ; type
	dw $85c2 ; gfx
	tx MagnetonName ; name
	db STAR ; rarity
	db EXPANSION_SHEET ; real set
	db LEGENDARY_POWER ; in-game set
	dw MAGNETON_LV30
	db 70 ; hp
	db STAGE1 ; stage
	tx MagnemiteName ; pre-evo name

	; attack 1
	energy LIGHTNING, 2, COLORLESS, 1 ; energies
	tx MicrowaveName ; name
	tx MicrowaveDescription ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db RESIDUAL ; category
	dw MagnetonLv30MicrowaveEffectCommands ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db SPECIAL_AI_HANDLING | FLAG_3_BIT_2  ; flags 3
	db 0 ; ?
	db ATK_ANIM_THUNDER_WAVE ; animation

	; attack 2
	energy 0 ; energies
	dw NONE ; name
	dw NONE ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db DAMAGE_NORMAL ; category
	dw NONE ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_NONE ; animation

	db 1 ; retreat cost
	db WR_FIGHTING ; weakness
	db NONE ; resistance
	tx MagnetCategoryName ; category
	db DEX_MAGNETON ; Pokedex number
	db FALSE ; is Dark
	db 30 ; level
	length 1.0 ; length
	weight 60.0 ; weight
	tx MagnetonLv30Description ; description
	db NONE ; AI info

MagnetonLv35Card:
	db TYPE_PKMN_LIGHTNING ; type
	dw $337d ; gfx
	tx MagnetonName ; name
	db STAR ; rarity
	db FOSSIL ; real set
	db SKY_FLYING_POKEMON ; in-game set
	dw MAGNETON_LV35
	db 80 ; hp
	db STAGE1 ; stage
	tx MagnemiteName ; pre-evo name

	; attack 1
	energy LIGHTNING, 1, COLORLESS, 1 ; energies
	tx SonicboomName ; name
	tx SonicboomDescription ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_NORMAL ; category
	dw MagnetonLv35SonicboomEffectCommands ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_TEAR ; animation

	; attack 2
	energy LIGHTNING, 4 ; energies
	tx SelfdestructName ; name
	tx Selfdestruct100DamageDescription ; description
	dw NONE ; description (cont)
	db 100 ; damage
	db DAMAGE_NORMAL ; category
	dw MagnetonLv35SelfdestructEffectCommands ; effect commands
	db HIGH_RECOIL  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 100 ; ?
	db ATK_ANIM_BIG_SELFDESTRUCTION ; animation

	db 2 ; retreat cost
	db WR_FIGHTING ; weakness
	db NONE ; resistance
	tx MagnetCategoryName ; category
	db DEX_MAGNETON ; Pokedex number
	db FALSE ; is Dark
	db 35 ; level
	length 1.0 ; length
	weight 60.0 ; weight
	tx MagnetonSharedDescription ; description
	db NONE ; AI info

DarkMagnetonCard:
	db TYPE_PKMN_LIGHTNING ; type
	dw $6f6d ; gfx
	tx DarkMagnetonName ; name
	db STAR ; rarity
	db TEAM_ROCKET ; real set
	db WE_ARE_TEAM_ROCKET ; in-game set
	dw DARK_MAGNETON
	db 60 ; hp
	db STAGE1 ; stage
	tx MagnemiteName ; pre-evo name

	; attack 1
	energy COLORLESS, 2 ; energies
	tx SonicboomName ; name
	tx SonicboomAltDescription ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_NORMAL ; category
	dw DarkMagnetonSonicboomEffectCommands ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_TEAR ; animation

	; attack 2
	energy LIGHTNING, 2 ; energies
	tx MagneticLinesName ; name
	tx MagneticLinesDescription ; description
	dw NONE ; description (cont)
	db 30 ; damage
	db DAMAGE_NORMAL ; category
	dw DarkMagnetonMagneticLinesEffectCommands ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db SPECIAL_AI_HANDLING  ; flags 3
	db 0 ; ?
	db ATK_ANIM_THUNDER_WAVE ; animation

	db 2 ; retreat cost
	db WR_FIGHTING ; weakness
	db NONE ; resistance
	tx MagnetCategoryName ; category
	db DEX_MAGNETON ; Pokedex number
	db TRUE ; is Dark
	db 26 ; level
	length 1.0 ; length
	weight 60.0 ; weight
	tx DarkMagnetonDescription ; description
	db NONE ; AI info

VoltorbLv8Card:
	db TYPE_PKMN_LIGHTNING ; type
	dw $8869 ; gfx
	tx VoltorbName ; name
	db CIRCLE ; rarity
	db EXPANSION_SHEET ; real set
	db SKY_FLYING_POKEMON ; in-game set
	dw VOLTORB_LV8
	db 30 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy LIGHTNING, 1 ; energies
	tx ThundershockName ; name
	tx MayInflictParalysisAltDescription ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_NORMAL ; category
	dw VoltorbLv8ThundershockEffectCommands ; effect commands
	db INFLICT_PARALYSIS  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_THUNDERSHOCK_COPY ; animation

	; attack 2
	energy LIGHTNING, 2 ; energies
	tx GroupSparkName ; name
	tx GroupSparkDescription ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_PLUS ; category
	dw VoltorbLv8GroupSparkEffectCommands ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_THUNDER_WHOLE_SCREEN ; animation

	db 0 ; retreat cost
	db WR_FIGHTING ; weakness
	db NONE ; resistance
	tx BallName ; category
	db DEX_VOLTORB ; Pokedex number
	db FALSE ; is Dark
	db 8 ; level
	length 0.5 ; length
	weight 10.4 ; weight
	tx VoltorbLv8Description ; description
	db NONE | HAS_EVOLUTION ; AI info

VoltorbLv10Card:
	db TYPE_PKMN_LIGHTNING ; type
	dw $33e6 ; gfx
	tx VoltorbName ; name
	db CIRCLE ; rarity
	db BASE_SET ; real set
	db ISLAND_OF_FOSSIL ; in-game set
	dw VOLTORB_LV10
	db 40 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy COLORLESS, 1 ; energies
	tx TackleName ; name
	dw NONE ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_NORMAL ; category
	dw NONE ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_HIT ; animation

	; attack 2
	energy 0 ; energies
	dw NONE ; name
	dw NONE ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db DAMAGE_NORMAL ; category
	dw NONE ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_NONE ; animation

	db 1 ; retreat cost
	db WR_FIGHTING ; weakness
	db NONE ; resistance
	tx BallName ; category
	db DEX_VOLTORB ; Pokedex number
	db FALSE ; is Dark
	db 10 ; level
	length 0.5 ; length
	weight 10.4 ; weight
	tx VoltorbLv10Description ; description
	db AI_INFO_UNK_05 | HAS_EVOLUTION ; AI info

VoltorbLv13Card:
	db TYPE_PKMN_LIGHTNING ; type
	dw $7000 ; gfx
	tx VoltorbName ; name
	db CIRCLE ; rarity
	db TEAM_ROCKET ; real set
	db WE_ARE_TEAM_ROCKET ; in-game set
	dw VOLTORB_LV13
	db 40 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy LIGHTNING, 1 ; energies
	tx SpeedBallName ; name
	dw NONE ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_NORMAL ; category
	dw NONE ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_HIT ; animation

	; attack 2
	energy 0 ; energies
	dw NONE ; name
	dw NONE ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db DAMAGE_NORMAL ; category
	dw NONE ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_NONE ; animation

	db 1 ; retreat cost
	db WR_FIGHTING ; weakness
	db NONE ; resistance
	tx BallName ; category
	db DEX_VOLTORB ; Pokedex number
	db FALSE ; is Dark
	db 13 ; level
	length 0.5 ; length
	weight 10.4 ; weight
	tx VoltorbLv13Description ; description
	db NONE | HAS_EVOLUTION ; AI info

ElectrodeLv35Card:
	db TYPE_PKMN_LIGHTNING ; type
	dw $3487 ; gfx
	tx ElectrodeName ; name
	db STAR ; rarity
	db GB ; real set
	db ISLAND_OF_FOSSIL ; in-game set
	dw ELECTRODE_LV35
	db 70 ; hp
	db STAGE1 ; stage
	tx VoltorbName ; pre-evo name

	; attack 1
	energy LIGHTNING, 2 ; energies
	tx SonicboomName ; name
	tx SonicboomDescription ; description
	dw NONE ; description (cont)
	db 30 ; damage
	db DAMAGE_NORMAL ; category
	dw ElectrodeLv35SonicboomEffectCommands ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_TEAR ; animation

	; attack 2
	energy LIGHTNING, 3 ; energies
	tx EnergySpikeName ; name
	tx EnergySpikeDescription ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db RESIDUAL ; category
	dw ElectrodeLv35EnergySpikeEffectCommands ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db SPECIAL_AI_HANDLING | FLAG_3_BIT_2  ; flags 3
	db 0 ; ?
	db ATK_ANIM_GLOW_EFFECT ; animation

	db 1 ; retreat cost
	db WR_FIGHTING ; weakness
	db NONE ; resistance
	tx BallName ; category
	db DEX_ELECTRODE ; Pokedex number
	db FALSE ; is Dark
	db 35 ; level
	length 1.2 ; length
	weight 66.6 ; weight
	tx ElectrodeLv35Description ; description
	db NONE ; AI info

ElectrodeLv42Card:
	db TYPE_PKMN_LIGHTNING ; type
	dw $34f0 ; gfx
	tx ElectrodeName ; name
	db STAR ; rarity
	db JUNGLE ; real set
	db SKY_FLYING_POKEMON ; in-game set
	dw ELECTRODE_LV42
	db 90 ; hp
	db STAGE1 ; stage
	tx VoltorbName ; pre-evo name

	; attack 1
	energy COLORLESS, 2 ; energies
	tx TackleName ; name
	dw NONE ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_NORMAL ; category
	dw NONE ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_HIT ; animation

	; attack 2
	energy LIGHTNING, 3 ; energies
	tx ChainLightningName ; name
	tx ChainLightningDescription ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_NORMAL ; category
	dw ElectrodeLv42ChainLightningEffectCommands ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db SPECIAL_AI_HANDLING | FLAG_3_BIT_2  ; flags 3
	db 0 ; ?
	db ATK_ANIM_CHAIN_LIGHTNING ; animation

	db 1 ; retreat cost
	db WR_FIGHTING ; weakness
	db NONE ; resistance
	tx BallName ; category
	db DEX_ELECTRODE ; Pokedex number
	db FALSE ; is Dark
	db 42 ; level
	length 1.2 ; length
	weight 66.6 ; weight
	tx ElectrodeLv42Description ; description
	db NONE ; AI info

DarkElectrodeCard:
	db TYPE_PKMN_LIGHTNING ; type
	dw $7069 ; gfx
	tx DarkElectrodeName ; name
	db DIAMOND ; rarity
	db TEAM_ROCKET ; real set
	db WE_ARE_TEAM_ROCKET ; in-game set
	dw DARK_ELECTRODE
	db 60 ; hp
	db STAGE1 ; stage
	tx VoltorbName ; pre-evo name

	; attack 1
	energy COLORLESS, 1 ; energies
	tx RollingTackleName ; name
	dw NONE ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_NORMAL ; category
	dw NONE ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_HIT ; animation

	; attack 2
	energy LIGHTNING, 2 ; energies
	tx EnergyBombName ; name
	tx EnergyBombDescription ; description
	dw NONE ; description (cont)
	db 30 ; damage
	db DAMAGE_NORMAL ; category
	dw DarkElectrodeEnergyBombEffectCommands ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db SPECIAL_AI_HANDLING  ; flags 3
	db 0 ; ?
	db ATK_ANIM_HIT ; animation

	db 1 ; retreat cost
	db WR_FIGHTING ; weakness
	db NONE ; resistance
	tx BallName ; category
	db DEX_ELECTRODE ; Pokedex number
	db TRUE ; is Dark
	db 24 ; level
	length 1.2 ; length
	weight 66.6 ; weight
	tx DarkElectrodeDescription ; description
	db NONE ; AI info

ElectabuzzLv20Card:
	db TYPE_PKMN_LIGHTNING ; type
	dw $3559 ; gfx
	tx ElectabuzzName ; name
	db PROMOSTAR ; rarity
	db PRO ; real set
	db PROMOTIONAL ; in-game set
	dw ELECTABUZZ_LV20
	db 60 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy LIGHTNING, 1 ; energies
	tx LightScreenName ; name
	tx LightScreenDescription ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db RESIDUAL ; category
	dw ElectabuzzLv20LightScreenEffectCommands ; effect commands
	db NONE ; flags 1
	db NULLIFY_OR_WEAKEN_ATTACK  ; flags 2
	db FLAG_3_BIT_2  ; flags 3
	db 0 ; ?
	db ATK_ANIM_BARRIER ; animation

	; attack 2
	energy COLORLESS, 2 ; energies
	tx QuickAttackName ; name
	tx QuickAttackAltDescription1 ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_PLUS ; category
	dw ElectabuzzLv20QuickAttackEffectCommands ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_QUICK_ATTACK ; animation

	db 2 ; retreat cost
	db WR_FIGHTING ; weakness
	db NONE ; resistance
	tx ThunderJoltName ; category
	db DEX_ELECTABUZZ ; Pokedex number
	db FALSE ; is Dark
	db 20 ; level
	length 1.1 ; length
	weight 30.0 ; weight
	tx ElectabuzzLv20Description ; description
	db NONE ; AI info

ElectabuzzLv30Card:
	db TYPE_PKMN_LIGHTNING ; type
	dw $c20d ; gfx
	tx ElectabuzzName ; name
	db STAR ; rarity
	db BULBASAUR_DECK ; real set
	db BEGINNING_POKEMON ; in-game set
	dw ELECTABUZZ_LV30
	db 70 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy LIGHTNING, 2, COLORLESS, 1 ; energies
	tx ThundershockName ; name
	tx MayInflictParalysisAltDescription ; description
	dw NONE ; description (cont)
	db 30 ; damage
	db DAMAGE_NORMAL ; category
	dw ElectabuzzLv30ThundershockEffectCommands ; effect commands
	db INFLICT_PARALYSIS  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_THUNDERSHOCK_COPY ; animation

	; attack 2
	energy 0 ; energies
	dw NONE ; name
	dw NONE ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db DAMAGE_NORMAL ; category
	dw NONE ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_NONE ; animation

	db 2 ; retreat cost
	db WR_FIGHTING ; weakness
	db NONE ; resistance
	tx ThunderJoltName ; category
	db DEX_ELECTABUZZ ; Pokedex number
	db FALSE ; is Dark
	db 30 ; level
	length 1.1 ; length
	weight 30.0 ; weight
	tx ElectabuzzLv30Description ; description
	db NONE ; AI info

ElectabuzzLv35Card:
	db TYPE_PKMN_LIGHTNING ; type
	dw $35c2 ; gfx
	tx ElectabuzzName ; name
	db STAR ; rarity
	db BASE_SET ; real set
	db LEGENDARY_POWER ; in-game set
	dw ELECTABUZZ_LV35
	db 70 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy LIGHTNING, 1 ; energies
	tx ThundershockName ; name
	tx MayInflictParalysisDescription ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_NORMAL ; category
	dw ElectabuzzLv35ThundershockEffectCommands ; effect commands
	db INFLICT_PARALYSIS  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_THUNDERSHOCK ; animation

	; attack 2
	energy LIGHTNING, 1, COLORLESS, 1 ; energies
	tx ThunderpunchName ; name
	tx ThunderpunchDescription ; description
	dw NONE ; description (cont)
	db 30 ; damage
	db DAMAGE_PLUS ; category
	dw ElectabuzzLv35ThunderpunchEffectCommands ; effect commands
	db LOW_RECOIL  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_THUNDERPUNCH ; animation

	db 2 ; retreat cost
	db WR_FIGHTING ; weakness
	db NONE ; resistance
	tx ThunderJoltName ; category
	db DEX_ELECTABUZZ ; Pokedex number
	db FALSE ; is Dark
	db 35 ; level
	length 1.1 ; length
	weight 30.0 ; weight
	tx ElectabuzzLv35Description ; description
	db NONE ; AI info

JolteonLv24Card:
	db TYPE_PKMN_LIGHTNING ; type
	dw $3633 ; gfx
	tx JolteonName ; name
	db DIAMOND ; rarity
	db GB ; real set
	db PSYCHIC_BATTLE ; in-game set
	dw JOLTEON_LV24
	db 60 ; hp
	db STAGE1 ; stage
	tx EeveeName ; pre-evo name

	; attack 1
	energy COLORLESS, 2 ; energies
	tx DoubleKickName ; name
	tx Do20DamageNumberOfHeadsDescription ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_X ; category
	dw JolteonLv24DoubleKickEffectCommands ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_LEG_SWEEP ; animation

	; attack 2
	energy COLORLESS, 4 ; energies
	tx StunNeedleName ; name
	tx MayInflictParalysisDescription ; description
	dw NONE ; description (cont)
	db 30 ; damage
	db DAMAGE_NORMAL ; category
	dw JolteonLv24StunNeedleEffectCommands ; effect commands
	db INFLICT_PARALYSIS  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_NEEDLES ; animation

	db 1 ; retreat cost
	db WR_FIGHTING ; weakness
	db NONE ; resistance
	tx ThunderName ; category
	db DEX_JOLTEON ; Pokedex number
	db FALSE ; is Dark
	db 24 ; level
	length 0.8 ; length
	weight 24.5 ; weight
	tx JolteonLv24Description ; description
	db NONE ; AI info

JolteonLv29Card:
	db TYPE_PKMN_LIGHTNING ; type
	dw $369c ; gfx
	tx JolteonName ; name
	db STAR ; rarity
	db JUNGLE ; real set
	db LEGENDARY_POWER ; in-game set
	dw JOLTEON_LV29
	db 70 ; hp
	db STAGE1 ; stage
	tx EeveeName ; pre-evo name

	; attack 1
	energy COLORLESS, 2 ; energies
	tx QuickAttackName ; name
	tx QuickAttackAltDescription2 ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_PLUS ; category
	dw JolteonLv29QuickAttackEffectCommands ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_QUICK_ATTACK ; animation

	; attack 2
	energy LIGHTNING, 2, COLORLESS, 1 ; energies
	tx PinMissileName ; name
	tx PinMissileDescription ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_X ; category
	dw JolteonLv29PinMissileEffectCommands ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_NEEDLES ; animation

	db 1 ; retreat cost
	db WR_FIGHTING ; weakness
	db NONE ; resistance
	tx ThunderName ; category
	db DEX_JOLTEON ; Pokedex number
	db FALSE ; is Dark
	db 29 ; level
	length 0.8 ; length
	weight 24.5 ; weight
	tx JolteonLv29Description ; description
	db NONE ; AI info

DarkJolteonCard:
	db TYPE_PKMN_LIGHTNING ; type
	dw $70d2 ; gfx
	tx DarkJolteonName ; name
	db DIAMOND ; rarity
	db TEAM_ROCKET ; real set
	db WE_ARE_TEAM_ROCKET ; in-game set
	dw DARK_JOLTEON
	db 50 ; hp
	db STAGE1 ; stage
	tx EeveeName ; pre-evo name

	; attack 1
	energy LIGHTNING, 1 ; energies
	tx LightningFlashName ; name
	tx LightningFlashDescription ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_NORMAL ; category
	dw DarkJolteonLightningFlashEffectCommands ; effect commands
	db NONE ; flags 1
	db NULLIFY_OR_WEAKEN_ATTACK  ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_LIGHTNING_FLASH ; animation

	; attack 2
	energy LIGHTNING, 2, COLORLESS, 1 ; energies
	tx ThunderAttackName ; name
	tx ThunderAttackDescription ; description
	dw NONE ; description (cont)
	db 30 ; damage
	db DAMAGE_NORMAL ; category
	dw DarkJolteonThunderAttackEffectCommands ; effect commands
	db INFLICT_PARALYSIS  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_THUNDERSHOCK_COPY ; animation

	db 1 ; retreat cost
	db WR_FIGHTING ; weakness
	db NONE ; resistance
	tx ThunderName ; category
	db DEX_JOLTEON ; Pokedex number
	db TRUE ; is Dark
	db 23 ; level
	length 0.8 ; length
	weight 24.5 ; weight
	tx DarkJolteonDescription ; description
	db NONE ; AI info

ZapdosLv28Card:
	db TYPE_PKMN_LIGHTNING ; type
	dw $8c6a ; gfx
	tx ZapdosName ; name
	db STAR ; rarity
	db EXPANSION_SHEET ; real set
	db TEAM_ROCKETS_AMBITION ; in-game set
	dw ZAPDOS_LV28
	db 70 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy LIGHTNING, 3 ; energies
	tx RagingThunderName ; name
	tx RagingThunderDescription ; description
	dw NONE ; description (cont)
	db 50 ; damage
	db DAMAGE_NORMAL ; category
	dw ZapdosLv28RagingThunderEffectCommands ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db SPECIAL_AI_HANDLING | FLAG_3_BIT_2  ; flags 3
	db 0 ; ?
	db ATK_ANIM_THUNDERBOLT ; animation

	; attack 2
	energy LIGHTNING, 2, COLORLESS, 2 ; energies
	tx ThunderCrashName ; name
	tx ThunderCrashDescription ; description
	dw NONE ; description (cont)
	db 50 ; damage
	db DAMAGE_PLUS ; category
	dw ZapdosLv28ThunderCrashEffectCommands ; effect commands
	db LOW_RECOIL  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_THUNDERBOLT ; animation

	db 2 ; retreat cost
	db NONE ; weakness
	db WR_FIGHTING ; resistance
	tx ThunderJoltName ; category
	db DEX_ZAPDOS ; Pokedex number
	db FALSE ; is Dark
	db 28 ; level
	length 1.6 ; length
	weight 52.6 ; weight
	tx ZapdosLv28Description ; description
	db NONE ; AI info

ZapdosLv40Card:
	db TYPE_PKMN_LIGHTNING ; type
	dw $3705 ; gfx
	tx ZapdosName ; name
	db STAR ; rarity
	db FOSSIL ; real set
	db SKY_FLYING_POKEMON ; in-game set
	dw ZAPDOS_LV40
	db 80 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy LIGHTNING, 4 ; energies
	tx ThunderstormName ; name
	tx ThunderstormDescription ; description
	dw NONE ; description (cont)
	db 40 ; damage
	db DAMAGE_NORMAL ; category
	dw ZapdosLv40ThunderstormEffectCommands ; effect commands
	db LOW_RECOIL | DAMAGE_TO_OPPONENT_BENCH  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_THUNDERSTORM ; animation

	; attack 2
	energy 0 ; energies
	dw NONE ; name
	dw NONE ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db DAMAGE_NORMAL ; category
	dw NONE ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_NONE ; animation

	db 2 ; retreat cost
	db NONE ; weakness
	db WR_FIGHTING ; resistance
	tx ThunderJoltName ; category
	db DEX_ZAPDOS ; Pokedex number
	db FALSE ; is Dark
	db 40 ; level
	length 1.6 ; length
	weight 52.6 ; weight
	tx ZapdosLv40Description ; description
	db NONE ; AI info

ZapdosLv64Card:
	db TYPE_PKMN_LIGHTNING ; type
	dw $376e ; gfx
	tx ZapdosName ; name
	db STAR ; rarity
	db BASE_SET ; real set
	db BEGINNING_POKEMON ; in-game set
	dw ZAPDOS_LV64
	db 90 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy LIGHTNING, 3, COLORLESS, 1 ; energies
	tx ThunderName ; name
	tx ThunderDescription ; description
	dw NONE ; description (cont)
	db 60 ; damage
	db DAMAGE_NORMAL ; category
	dw ZapdosLv64ThunderEffectCommands ; effect commands
	db LOW_RECOIL  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_THUNDER ; animation

	; attack 2
	energy LIGHTNING, 4 ; energies
	tx ThunderboltName ; name
	tx ThunderboltAltDescription2 ; description
	dw NONE ; description (cont)
	db 100 ; damage
	db DAMAGE_NORMAL ; category
	dw ZapdosLv64ThunderboltEffectCommands ; effect commands
	db NONE ; flags 1
	db DISCARD_ENERGY  ; flags 2
	db NONE ; flags 3
	db 9 ; ?
	db ATK_ANIM_THUNDERBOLT ; animation

	db 3 ; retreat cost
	db NONE ; weakness
	db WR_FIGHTING ; resistance
	tx ThunderJoltName ; category
	db DEX_ZAPDOS ; Pokedex number
	db FALSE ; is Dark
	db 64 ; level
	length 1.6 ; length
	weight 52.6 ; weight
	tx ZapdosLv64Description ; description
	db NONE ; AI info

ZapdosLv68Card:
	db TYPE_PKMN_LIGHTNING ; type
	dw $3800 ; gfx
	tx ZapdosName ; name
	db STAR ; rarity
	db GB ; real set
	db PROMOTIONAL ; in-game set
	dw ZAPDOS_LV68
	db 100 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy 0 ; energies
	tx PealOfThunderName ; name
	tx PealOfThunderDescription ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db POKEMON_POWER ; category
	dw ZapdosLv68PealOfThunderEffectCommands ; effect commands
	db DAMAGE_TO_OPPONENT_BENCH  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_PEAL_OF_THUNDER ; animation

	; attack 2
	energy LIGHTNING, 3 ; energies
	tx BigThunderName ; name
	tx BigThunderDescription ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db RESIDUAL ; category
	dw ZapdosLv68BigThunderEffectCommands ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db SPECIAL_AI_HANDLING | FLAG_3_BIT_2  ; flags 3
	db 0 ; ?
	db ATK_ANIM_BIG_THUNDER ; animation

	db 2 ; retreat cost
	db NONE ; weakness
	db WR_FIGHTING ; resistance
	tx ThunderJoltName ; category
	db DEX_ZAPDOS ; Pokedex number
	db FALSE ; is Dark
	db 68 ; level
	length 1.6 ; length
	weight 52.6 ; weight
	tx ZapdosLv68Description ; description
	db NONE ; AI info

SandshrewLv12Card:
	db TYPE_PKMN_FIGHTING ; type
	dw $3869 ; gfx
	tx SandshrewName ; name
	db CIRCLE ; rarity
	db BASE_SET ; real set
	db LEGENDARY_POWER ; in-game set
	dw SANDSHREW_LV12
	db 40 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy FIGHTING, 1 ; energies
	tx SandAttackName ; name
	tx SmokescreenDescription ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_NORMAL ; category
	dw SandshrewLv12SandAttackEffectCommands ; effect commands
	db NONE ; flags 1
	db NULLIFY_OR_WEAKEN_ATTACK  ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_DARK_GAS ; animation

	; attack 2
	energy 0 ; energies
	dw NONE ; name
	dw NONE ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db DAMAGE_NORMAL ; category
	dw NONE ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_NONE ; animation

	db 1 ; retreat cost
	db WR_GRASS ; weakness
	db WR_LIGHTNING ; resistance
	tx MouseName ; category
	db DEX_SANDSHREW ; Pokedex number
	db FALSE ; is Dark
	db 12 ; level
	length 0.6 ; length
	weight 12.0 ; weight
	tx SandshrewLv12Description ; description
	db AI_INFO_UNK_03 | HAS_EVOLUTION ; AI info

SandshrewLv15Card:
	db TYPE_PKMN_FIGHTING ; type
	dw $82cc ; gfx
	tx SandshrewName ; name
	db CIRCLE ; rarity
	db EXPANSION_SHEET ; real set
	db SKY_FLYING_POKEMON ; in-game set
	dw SANDSHREW_LV15
	db 40 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy FIGHTING, 1 ; energies
	tx PoisonStingName ; name
	tx MayInflictPoisonAltDescription ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_NORMAL ; category
	dw SandshrewLv15PoisonStingEffectCommands ; effect commands
	db INFLICT_POISON  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_POISON_NEEDLE ; animation

	; attack 2
	energy FIGHTING, 1 ; energies
	tx SwiftName ; name
	tx SwiftDescription ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_NORMAL ; category
	dw SandshrewLv15SwiftEffectCommands ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db FLAG_3_BIT_2  ; flags 3
	db 0 ; ?
	db ATK_ANIM_SWIFT ; animation

	db 1 ; retreat cost
	db WR_GRASS ; weakness
	db WR_LIGHTNING ; resistance
	tx MouseName ; category
	db DEX_SANDSHREW ; Pokedex number
	db FALSE ; is Dark
	db 15 ; level
	length 0.6 ; length
	weight 12.0 ; weight
	tx SandshrewLv15Description ; description
	db NONE | HAS_EVOLUTION ; AI info

SandslashLv33Card:
	db TYPE_PKMN_FIGHTING ; type
	dw $38ea ; gfx
	tx SandslashName ; name
	db DIAMOND ; rarity
	db FOSSIL ; real set
	db LEGENDARY_POWER ; in-game set
	dw SANDSLASH_LV33
	db 70 ; hp
	db STAGE1 ; stage
	tx SandshrewName ; pre-evo name

	; attack 1
	energy COLORLESS, 2 ; energies
	tx SlashName ; name
	dw NONE ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_NORMAL ; category
	dw NONE ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_SLASH ; animation

	; attack 2
	energy FIGHTING, 2 ; energies
	tx FurySwipesName ; name
	tx FurySwipes20DamageDescription ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_X ; category
	dw SandslashLv33FurySwipesEffectCommands ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_MULTIPLE_SLASH ; animation

	db 1 ; retreat cost
	db WR_GRASS ; weakness
	db WR_LIGHTNING ; resistance
	tx MouseName ; category
	db DEX_SANDSLASH ; Pokedex number
	db FALSE ; is Dark
	db 33 ; level
	length 1.0 ; length
	weight 29.5 ; weight
	tx SandslashLv33Description ; description
	db NONE ; AI info

SandslashLv35Card:
	db TYPE_PKMN_FIGHTING ; type
	dw $8e18 ; gfx
	tx SandslashName ; name
	db DIAMOND ; rarity
	db EXPANSION_SHEET ; real set
	db SKY_FLYING_POKEMON ; in-game set
	dw SANDSLASH_LV35
	db 70 ; hp
	db STAGE1 ; stage
	tx SandshrewName ; pre-evo name

	; attack 1
	energy FIGHTING, 1 ; energies
	tx SandVeilName ; name
	tx PreventDamageCardEffectDescription ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db RESIDUAL ; category
	dw SandslashLv35SandVeilEffectCommands ; effect commands
	db NONE ; flags 1
	db NULLIFY_OR_WEAKEN_ATTACK  ; flags 2
	db FLAG_3_BIT_2  ; flags 3
	db 0 ; ?
	db ATK_ANIM_SAND_VEIL ; animation

	; attack 2
	energy FIGHTING, 3 ; energies
	tx RollingNeedleName ; name
	tx RollingNeedleDescription ; description
	dw NONE ; description (cont)
	db 40 ; damage
	db DAMAGE_PLUS ; category
	dw SandslashLv35RollingNeedleEffectCommands ; effect commands
	db LOW_RECOIL  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_HIT ; animation

	db 1 ; retreat cost
	db WR_GRASS ; weakness
	db WR_LIGHTNING ; resistance
	tx MouseName ; category
	db DEX_SANDSLASH ; Pokedex number
	db FALSE ; is Dark
	db 35 ; level
	length 1.0 ; length
	weight 29.5 ; weight
	tx SandslashLv35Description ; description
	db NONE ; AI info

DiglettLv8Card:
	db TYPE_PKMN_FIGHTING ; type
	dw $3961 ; gfx
	tx DiglettName ; name
	db CIRCLE ; rarity
	db BASE_SET ; real set
	db BEGINNING_POKEMON ; in-game set
	dw DIGLETT_LV8
	db 30 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy FIGHTING, 1 ; energies
	tx DigName ; name
	dw NONE ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_NORMAL ; category
	dw NONE ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_HIT ; animation

	; attack 2
	energy FIGHTING, 2 ; energies
	tx MudSlapName ; name
	dw NONE ; description
	dw NONE ; description (cont)
	db 30 ; damage
	db DAMAGE_NORMAL ; category
	dw NONE ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_HIT ; animation

	db 0 ; retreat cost
	db WR_GRASS ; weakness
	db WR_LIGHTNING ; resistance
	tx MoleName ; category
	db DEX_DIGLETT ; Pokedex number
	db FALSE ; is Dark
	db 8 ; level
	length 0.2 ; length
	weight 0.8 ; weight
	tx DiglettLv8Description ; description
	db AI_INFO_UNK_03 | HAS_EVOLUTION ; AI info

DiglettLv15Card:
	db TYPE_PKMN_FIGHTING ; type
	dw $6800 ; gfx
	tx DiglettName ; name
	db CIRCLE ; rarity
	db TEAM_ROCKET ; real set
	db WE_ARE_TEAM_ROCKET ; in-game set
	dw DIGLETT_LV15
	db 40 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy FIGHTING, 1 ; energies
	tx DigUnderName ; name
	tx DigUnderDescription ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db RESIDUAL ; category
	dw DiglettLv15DigUnderEffectCommands ; effect commands
	db DAMAGE_TO_OPPONENT_BENCH  ; flags 1
	db FLAG_2_BIT_6  ; flags 2
	db FLAG_3_BIT_2  ; flags 3
	db 0 ; ?
	db ATK_ANIM_HIT ; animation

	; attack 2
	energy FIGHTING, 1, COLORLESS, 1 ; energies
	tx ScratchName ; name
	dw NONE ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_NORMAL ; category
	dw NONE ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_HIT ; animation

	db 0 ; retreat cost
	db WR_GRASS ; weakness
	db WR_LIGHTNING ; resistance
	tx MoleName ; category
	db DEX_DIGLETT ; Pokedex number
	db FALSE ; is Dark
	db 15 ; level
	length 0.2 ; length
	weight 0.8 ; weight
	tx DiglettLv15Description ; description
	db NONE | HAS_EVOLUTION ; AI info

DiglettLv16Card:
	db TYPE_PKMN_FIGHTING ; type
	dw $a221 ; gfx
	tx DiglettName ; name
	db PROMOSTAR ; rarity
	db PRO ; real set
	db PROMOTIONAL ; in-game set
	dw DIGLETT_LV16
	db 50 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy COLORLESS, 1 ; energies
	tx PeckName ; name
	dw NONE ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_NORMAL ; category
	dw NONE ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_HIT ; animation

	; attack 2
	energy FIGHTING, 1, COLORLESS, 1 ; energies
	tx TripOverName ; name
	tx IfHeadsDo10DamageDescription ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_PLUS ; category
	dw DiglettLv16TripOverEffectCommands ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_HIT ; animation

	db 1 ; retreat cost
	db WR_GRASS ; weakness
	db WR_LIGHTNING ; resistance
	tx MoleName ; category
	db DEX_DIGLETT ; Pokedex number
	db FALSE ; is Dark
	db 16 ; level
	length 0.2 ; length
	weight 0.8 ; weight
	tx DiglettLv16Description ; description
	db NONE | HAS_EVOLUTION ; AI info

DugtrioLv36Card:
	db TYPE_PKMN_FIGHTING ; type
	dw $39ca ; gfx
	tx DugtrioName ; name
	db STAR ; rarity
	db BASE_SET ; real set
	db BEGINNING_POKEMON ; in-game set
	dw DUGTRIO_LV36
	db 70 ; hp
	db STAGE1 ; stage
	tx DiglettName ; pre-evo name

	; attack 1
	energy FIGHTING, 2, COLORLESS, 1 ; energies
	tx SlashName ; name
	dw NONE ; description
	dw NONE ; description (cont)
	db 40 ; damage
	db DAMAGE_NORMAL ; category
	dw NONE ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_SLASH ; animation

	; attack 2
	energy FIGHTING, 4 ; energies
	tx EarthquakeName ; name
	tx EarthquakeDescription ; description
	dw NONE ; description (cont)
	db 70 ; damage
	db DAMAGE_NORMAL ; category
	dw DugtrioLv36EarthquakeEffectCommands ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db SPECIAL_AI_HANDLING  ; flags 3
	db 0 ; ?
	db ATK_ANIM_HIT ; animation

	db 2 ; retreat cost
	db WR_GRASS ; weakness
	db WR_LIGHTNING ; resistance
	tx MoleName ; category
	db DEX_DUGTRIO ; Pokedex number
	db FALSE ; is Dark
	db 36 ; level
	length 0.7 ; length
	weight 33.3 ; weight
	tx DugtrioLv36Description ; description
	db NONE ; AI info

DugtrioLv40Card:
	db TYPE_PKMN_FIGHTING ; type
	dw $a298 ; gfx
	tx DugtrioName ; name
	db PROMOSTAR ; rarity
	db PRO ; real set
	db PROMOTIONAL ; in-game set
	dw DUGTRIO_LV40
	db 80 ; hp
	db STAGE1 ; stage
	tx DiglettName ; pre-evo name

	; attack 1
	energy 0 ; energies
	tx GoUndergroundName ; name
	tx GoUndergroundDescription ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db POKEMON_POWER ; category
	dw DugtrioLv40GoUndergroundEffectCommands ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_NONE ; animation

	; attack 2
	energy FIGHTING, 3 ; energies
	tx EarthWaveName ; name
	tx EarthWaveDescription ; description
	dw NONE ; description (cont)
	db 30 ; damage
	db DAMAGE_NORMAL ; category
	dw DugtrioLv40EarthWaveEffectCommands ; effect commands
	db DAMAGE_TO_OPPONENT_BENCH  ; flags 1
	db NONE ; flags 2
	db FLAG_3_BIT_2  ; flags 3
	db 0 ; ?
	db ATK_ANIM_HIT ; animation

	db 2 ; retreat cost
	db WR_GRASS ; weakness
	db WR_LIGHTNING ; resistance
	tx MoleName ; category
	db DEX_DUGTRIO ; Pokedex number
	db FALSE ; is Dark
	db 40 ; level
	length 0.7 ; length
	weight 33.3 ; weight
	tx DugtrioLv40Description ; description
	db NONE ; AI info

DarkDugtrioCard:
	db TYPE_PKMN_FIGHTING ; type
	dw $686d ; gfx
	tx DarkDugtrioName ; name
	db STAR ; rarity
	db TEAM_ROCKET ; real set
	db WE_ARE_TEAM_ROCKET ; in-game set
	dw DARK_DUGTRIO
	db 50 ; hp
	db STAGE1 ; stage
	tx DiglettName ; pre-evo name

	; attack 1
	energy 0 ; energies
	tx SinkholeName ; name
	tx SinkholeDescription ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db POKEMON_POWER ; category
	dw DarkDugtrioSinkholeEffectCommands ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_NONE ; animation

	; attack 2
	energy FIGHTING, 2 ; energies
	tx KnockDownName ; name
	tx KnockDownDescription ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_PLUS ; category
	dw DarkDugtrioKnockDownEffectCommands ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_HIT ; animation

	db 2 ; retreat cost
	db WR_GRASS ; weakness
	db WR_LIGHTNING ; resistance
	tx MoleName ; category
	db DEX_DUGTRIO ; Pokedex number
	db TRUE ; is Dark
	db 18 ; level
	length 0.7 ; length
	weight 33.3 ; weight
	tx DarkDugtrioDescription ; description
	db NONE ; AI info

MankeyLv7Card:
	db TYPE_PKMN_FIGHTING ; type
	dw $3a39 ; gfx
	tx MankeyName ; name
	db CIRCLE ; rarity
	db JUNGLE ; real set
	db ISLAND_OF_FOSSIL ; in-game set
	dw MANKEY_LV7
	db 30 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy 0 ; energies
	tx PeekName ; name
	tx PeekDescription ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db POKEMON_POWER ; category
	dw MankeyLv7PeekEffectCommands ; effect commands
	db NONE ; flags 1
	db FLAG_2_BIT_5  ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_PKMN_POWER_1 ; animation

	; attack 2
	energy COLORLESS, 1 ; energies
	tx ScratchName ; name
	dw NONE ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_NORMAL ; category
	dw NONE ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_SLASH ; animation

	db 0 ; retreat cost
	db WR_PSYCHIC ; weakness
	db NONE ; resistance
	tx PigMonkeyName ; category
	db DEX_MANKEY ; Pokedex number
	db FALSE ; is Dark
	db 7 ; level
	length 0.5 ; length
	weight 28.0 ; weight
	tx MankeyLv7Description ; description
	db AI_INFO_BENCH_UTILITY | HAS_EVOLUTION ; AI info

MankeyAltLv7Card:
	db TYPE_PKMN_FIGHTING ; type
	dw $a687 ; gfx
	tx MankeyName ; name
	db PROMOSTAR ; rarity
	db PRO ; real set
	db PROMOTIONAL ; in-game set
	dw MANKEY_ALT_LV7
	db 30 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy 0 ; energies
	tx PeekName ; name
	tx PeekDescription ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db POKEMON_POWER ; category
	dw MankeyAltLv7PeekEffectCommands ; effect commands
	db NONE ; flags 1
	db FLAG_2_BIT_5  ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_PKMN_POWER_1 ; animation

	; attack 2
	energy COLORLESS, 1 ; energies
	tx ScratchName ; name
	dw NONE ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_NORMAL ; category
	dw NONE ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_SLASH ; animation

	db 0 ; retreat cost
	db WR_PSYCHIC ; weakness
	db NONE ; resistance
	tx PigMonkeyName ; category
	db DEX_MANKEY ; Pokedex number
	db FALSE ; is Dark
	db 7 ; level
	length 0.5 ; length
	weight 28.0 ; weight
	tx MankeyLv7Description ; description
	db AI_INFO_BENCH_UTILITY | HAS_EVOLUTION ; AI info

MankeyLv14Card:
	db TYPE_PKMN_FIGHTING ; type
	dw $68d6 ; gfx
	tx MankeyName ; name
	db CIRCLE ; rarity
	db TEAM_ROCKET ; real set
	db WE_ARE_TEAM_ROCKET ; in-game set
	dw MANKEY_LV14
	db 40 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy COLORLESS, 1 ; energies
	tx MischiefName ; name
	tx MischiefDescription ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db RESIDUAL ; category
	dw MankeyLv14MischiefEffectCommands ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db SPECIAL_AI_HANDLING | FLAG_3_BIT_2  ; flags 3
	db 0 ; ?
	db ATK_ANIM_GLOW_EFFECT ; animation

	; attack 2
	energy FIGHTING, 1, COLORLESS, 1 ; energies
	tx AngerName ; name
	tx QuickAttackAltDescription1 ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_PLUS ; category
	dw MankeyLv14AngerEffectCommands ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_HIT ; animation

	db 0 ; retreat cost
	db WR_PSYCHIC ; weakness
	db NONE ; resistance
	tx PigMonkeyName ; category
	db DEX_MANKEY ; Pokedex number
	db FALSE ; is Dark
	db 14 ; level
	length 0.5 ; length
	weight 28.0 ; weight
	tx MankeyLv14Description ; description
	db NONE | HAS_EVOLUTION ; AI info

PrimeapeCard:
	db TYPE_PKMN_FIGHTING ; type
	dw $3aa8 ; gfx
	tx PrimeapeName ; name
	db DIAMOND ; rarity
	db JUNGLE ; real set
	db ISLAND_OF_FOSSIL ; in-game set
	dw PRIMEAPE
	db 70 ; hp
	db STAGE1 ; stage
	tx MankeyName ; pre-evo name

	; attack 1
	energy FIGHTING, 2 ; energies
	tx FurySwipesName ; name
	tx FurySwipes20DamageDescription ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_X ; category
	dw PrimeapeFurySwipesEffectCommands ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_MULTIPLE_SLASH ; animation

	; attack 2
	energy FIGHTING, 2, COLORLESS, 1 ; energies
	tx TantrumName ; name
	tx TantrumDescription ; description
	dw NONE ; description (cont)
	db 50 ; damage
	db DAMAGE_NORMAL ; category
	dw PrimeapeTantrumEffectCommands ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_RAMPAGE ; animation

	db 1 ; retreat cost
	db WR_PSYCHIC ; weakness
	db NONE ; resistance
	tx PigMonkeyName ; category
	db DEX_PRIMEAPE ; Pokedex number
	db FALSE ; is Dark
	db 35 ; level
	length 1.0 ; length
	weight 32.0 ; weight
	tx PrimeapeDescription ; description
	db NONE ; AI info

DarkPrimeapeCard:
	db TYPE_PKMN_FIGHTING ; type
	dw $6963 ; gfx
	tx DarkPrimeapeName ; name
	db DIAMOND ; rarity
	db TEAM_ROCKET ; real set
	db WE_ARE_TEAM_ROCKET ; in-game set
	dw DARK_PRIMEAPE
	db 60 ; hp
	db STAGE1 ; stage
	tx MankeyName ; pre-evo name

	; attack 1
	energy 0 ; energies
	tx FrenzyName ; name
	tx FrenzyDescription ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db POKEMON_POWER ; category
	dw DarkPrimeapeFrenzyEffectCommands ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_NONE ; animation

	; attack 2
	energy FIGHTING, 2 ; energies
	tx FrenziedAttackName ; name
	tx FrenziedAttackDescription ; description
	dw NONE ; description (cont)
	db 40 ; damage
	db DAMAGE_NORMAL ; category
	dw DarkPrimeapeFrenziedAttackEffectCommands ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_RAMPAGE ; animation

	db 1 ; retreat cost
	db WR_PSYCHIC ; weakness
	db NONE ; resistance
	tx PigMonkeyName ; category
	db DEX_PRIMEAPE ; Pokedex number
	db TRUE ; is Dark
	db 23 ; level
	length 1.0 ; length
	weight 32.0 ; weight
	tx DarkPrimeapeDescription ; description
	db NONE ; AI info

MachopLv18Card:
	db TYPE_PKMN_FIGHTING ; type
	dw $83a4 ; gfx
	tx MachopName ; name
	db CIRCLE ; rarity
	db EXPANSION_SHEET ; real set
	db SKY_FLYING_POKEMON ; in-game set
	dw MACHOP_LV18
	db 50 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy COLORLESS, 1 ; energies
	tx FocusedOneShotName ; name
	tx FocusedOneShotDescription ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db RESIDUAL ; category
	dw MachopLv18FocusedOneShotEffectCommands ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db SPECIAL_AI_HANDLING | FLAG_3_BIT_2  ; flags 3
	db 0 ; ?
	db ATK_ANIM_GLOW_EFFECT ; animation

	; attack 2
	energy FIGHTING, 1, COLORLESS, 1 ; energies
	tx CorkscrewPunchName ; name
	dw NONE ; description
	dw NONE ; description (cont)
	db 30 ; damage
	db DAMAGE_NORMAL ; category
	dw MachopLv18CorkscrewPunchEffectCommands ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_HIT ; animation

	db 1 ; retreat cost
	db WR_PSYCHIC ; weakness
	db NONE ; resistance
	tx SuperpowerName ; category
	db DEX_MACHOP ; Pokedex number
	db FALSE ; is Dark
	db 18 ; level
	length 0.8 ; length
	weight 19.5 ; weight
	tx MachopLv18Description ; description
	db NONE | HAS_EVOLUTION ; AI info

MachopLv20Card:
	db TYPE_PKMN_FIGHTING ; type
	dw $3b11 ; gfx
	tx MachopName ; name
	db CIRCLE ; rarity
	db BASE_SET ; real set
	db BEGINNING_POKEMON ; in-game set
	dw MACHOP_LV20
	db 50 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy FIGHTING, 1 ; energies
	tx LowKickName ; name
	dw NONE ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_NORMAL ; category
	dw NONE ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_HIT ; animation

	; attack 2
	energy 0 ; energies
	dw NONE ; name
	dw NONE ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db DAMAGE_NORMAL ; category
	dw NONE ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_NONE ; animation

	db 1 ; retreat cost
	db WR_PSYCHIC ; weakness
	db NONE ; resistance
	tx SuperpowerName ; category
	db DEX_MACHOP ; Pokedex number
	db FALSE ; is Dark
	db 20 ; level
	length 0.8 ; length
	weight 19.5 ; weight
	tx MachopLv20Description ; description
	db AI_INFO_UNK_05 | HAS_EVOLUTION ; AI info

MachopLv24Card:
	db TYPE_PKMN_FIGHTING ; type
	dw $69d2 ; gfx
	tx MachopName ; name
	db CIRCLE ; rarity
	db TEAM_ROCKET ; real set
	db WE_ARE_TEAM_ROCKET ; in-game set
	dw MACHOP_LV24
	db 50 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy COLORLESS, 2 ; energies
	tx PunchName ; name
	dw NONE ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_NORMAL ; category
	dw NONE ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_PUNCH ; animation

	; attack 2
	energy FIGHTING, 1, COLORLESS, 2 ; energies
	tx KickName ; name
	dw NONE ; description
	dw NONE ; description (cont)
	db 30 ; damage
	db DAMAGE_NORMAL ; category
	dw NONE ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_LEG_SWEEP ; animation

	db 1 ; retreat cost
	db WR_PSYCHIC ; weakness
	db NONE ; resistance
	tx SuperpowerName ; category
	db DEX_MACHOP ; Pokedex number
	db FALSE ; is Dark
	db 24 ; level
	length 0.8 ; length
	weight 19.5 ; weight
	tx MachopLv24Description ; description
	db NONE | HAS_EVOLUTION ; AI info
