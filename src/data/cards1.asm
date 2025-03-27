BulbasaurLv12Card:
	db TYPE_PKMN_GRASS ; type
	dw $c430 ; gfx
	tx BulbasaurName ; name
	db CIRCLE ; rarity
	db TEAM_ROCKETS_AMBITION ; set
	db 0 ; ?
	dw BULBASAUR_LV12
	db 40 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy COLORLESS, 1 ; energies
	tx Text1305 ; name
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
	tx Text1306 ; name
	dw NONE ; description
	dw NONE ; description (cont)
	db 30 ; damage
	db DAMAGE_NORMAL ; category
	dw NONE ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_242 ; animation

	db 1 ; retreat cost
	db WR_FIRE ; weakness
	db NONE ; resistance
	tx Text1307 ; category
	db DEX_BULBASAUR ; Pokedex number
	db FALSE ; is Dark
	db 12 ; level
	length 0.7 ; length
	weight 6.9 ; weight
	tx BulbasaurDescription1 ; description
	db NONE | HAS_EVOLUTION ; AI info

BulbasaurLv13Card:
	db TYPE_PKMN_GRASS ; type
	dw $538 ; gfx
	tx BulbasaurName ; name
	db CIRCLE ; rarity
	db BEGINNING_POKEMON ; set
	db 6 ; ?
	dw BULBASAUR_LV13
	db 40 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy GRASS, 2 ; energies
	tx Text1309 ; name
	tx Text130a ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_NORMAL ; category
	dw $414a ; effect commands
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
	tx Text1307 ; category
	db DEX_BULBASAUR ; Pokedex number
	db FALSE ; is Dark
	db 13 ; level
	length 0.7 ; length
	weight 6.9 ; weight
	tx BulbasaurDescription2 ; description
	db NONE | HAS_EVOLUTION ; AI info

BulbasaurLv15Card:
	db TYPE_PKMN_GRASS ; type
	dw $713b ; gfx
	tx BulbasaurName ; name
	db DIAMOND ; rarity
	db SKY_FLYING_POKEMON ; set
	db 4 ; ?
	dw BULBASAUR_LV15
	db 50 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy COLORLESS, 1 ; energies
	tx Text130c ; name
	tx Text130d ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db RESIDUAL ; category
	dw $4c11 ; effect commands
	db NONE ; flags 1
	db HEAL_USER  ; flags 2
	db FLAG_3_BIT_2  ; flags 3
	db 1 ; ?
	db ATK_ANIM_RECOVER ; animation

	; attack 2
	energy GRASS, 1 ; energies
	tx Text130e ; name
	tx Text130f ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db DAMAGE_NORMAL ; category
	dw $4c19 ; effect commands
	db INFLICT_POISON  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_231 ; animation

	db 1 ; retreat cost
	db WR_FIRE ; weakness
	db NONE ; resistance
	tx Text1307 ; category
	db DEX_BULBASAUR ; Pokedex number
	db FALSE ; is Dark
	db 15 ; level
	length 0.7 ; length
	weight 6.9 ; weight
	tx BulbasaurDescription3 ; description
	db NONE | HAS_EVOLUTION ; AI info

IvysaurLv20Card:
	db TYPE_PKMN_GRASS ; type
	dw $5a1 ; gfx
	tx IvysaurName ; name
	db DIAMOND ; rarity
	db BEGINNING_POKEMON ; set
	db 3 ; ?
	dw IVYSAUR_LV20
	db 60 ; hp
	db STAGE1 ; stage
	tx BulbasaurName ; pre-evo name

	; attack 1
	energy GRASS, 1, COLORLESS, 2 ; energies
	tx Text1312 ; name
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
	tx Text1313 ; name
	tx Text130f ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_NORMAL ; category
	dw $4142 ; effect commands
	db INFLICT_POISON  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_POWDER_HIT_POISON ; animation

	db 1 ; retreat cost
	db WR_FIRE ; weakness
	db NONE ; resistance
	tx Text1307 ; category
	db DEX_IVYSAUR ; Pokedex number
	db FALSE ; is Dark
	db 20 ; level
	length 1.0 ; length
	weight 13.0 ; weight
	tx IvysaurDescription1 ; description
	db NONE | HAS_EVOLUTION ; AI info

IvysaurLv26Card:
	db TYPE_PKMN_GRASS ; type
	dw $c000 ; gfx
	tx IvysaurName ; name
	db DIAMOND ; rarity
	db TEAM_ROCKETS_AMBITION ; set
	db 0 ; ?
	dw IVYSAUR_LV26
	db 70 ; hp
	db STAGE1 ; stage
	tx BulbasaurName ; pre-evo name

	; attack 1
	energy GRASS, 2 ; energies
	tx Text1315 ; name
	tx Text1316 ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_NORMAL ; category
	dw $5267 ; effect commands
	db NONE ; flags 1
	db HEAL_USER  ; flags 2
	db NONE ; flags 3
	db 1 ; ?
	db ATK_ANIM_DRAIN ; animation

	; attack 2
	energy GRASS, 2, COLORLESS, 1 ; energies
	tx Text1317 ; name
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
	tx Text1307 ; category
	db DEX_IVYSAUR ; Pokedex number
	db FALSE ; is Dark
	db 26 ; level
	length 1.0 ; length
	weight 13.0 ; weight
	tx IvysaurDescription2 ; description
	db NONE | HAS_EVOLUTION ; AI info

DarkIvysaurCard:
	db TYPE_PKMN_GRASS ; type
	dw $c5d7 ; gfx
	tx DarkIvysaurName ; name
	db DIAMOND ; rarity
	db GB ; set
	db 6 ; ?
	dw DARK_IVYSAUR
	db 50 ; hp
	db STAGE1 ; stage
	tx BulbasaurName ; pre-evo name

	; attack 1
	energy 0 ; energies
	tx Text131a ; name
	tx Text131b ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db POKEMON_POWER ; category
	dw $5339 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_244 ; animation

	; attack 2
	energy GRASS, 2 ; energies
	tx Text131c ; name
	tx Text131d ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db RESIDUAL ; category
	dw $533e ; effect commands
	db DAMAGE_TO_OPPONENT_BENCH  ; flags 1
	db FLAG_2_BIT_6  ; flags 2
	db FLAG_3_BIT_2  ; flags 3
	db 3 ; ?
	db ATK_ANIM_245 ; animation

	db 2 ; retreat cost
	db WR_FIRE ; weakness
	db NONE ; resistance
	tx Text1307 ; category
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
	db GB ; set
	db 7 ; ?
	dw VENUSAUR_LV64
	db 100 ; hp
	db STAGE2 ; stage
	tx IvysaurName ; pre-evo name

	; attack 1
	energy 0 ; energies
	tx Text1320 ; name
	tx Text1321 ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db POKEMON_POWER ; category
	dw $41da ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_SOLAR_POWER ; animation

	; attack 2
	energy GRASS, 4 ; energies
	tx Text1322 ; name
	tx Text1323 ; description
	dw NONE ; description (cont)
	db 40 ; damage
	db DAMAGE_NORMAL ; category
	dw $41e2 ; effect commands
	db NONE ; flags 1
	db HEAL_USER  ; flags 2
	db NONE ; flags 3
	db 2 ; ?
	db ATK_ANIM_DRAIN ; animation

	db 2 ; retreat cost
	db WR_FIRE ; weakness
	db NONE ; resistance
	tx Text1307 ; category
	db DEX_VENUSAUR ; Pokedex number
	db FALSE ; is Dark
	db 64 ; level
	length 2.0 ; length
	weight 100.0 ; weight
	tx VenusaurDescription1 ; description
	db NONE ; AI info

VenusaurLv67Card:
	db TYPE_PKMN_GRASS ; type
	dw $6b3 ; gfx
	tx VenusaurName ; name
	db STAR ; rarity
	db BEGINNING_POKEMON ; set
	db 1 ; ?
	dw VENUSAUR_LV67
	db 100 ; hp
	db STAGE2 ; stage
	tx IvysaurName ; pre-evo name

	; attack 1
	energy 0 ; energies
	tx Text1325 ; name
	tx Text1326 ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db POKEMON_POWER ; category
	dw $414f ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_PKMN_POWER_1 ; animation

	; attack 2
	energy GRASS, 4 ; energies
	tx Text1327 ; name
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
	tx Text1307 ; category
	db DEX_VENUSAUR ; Pokedex number
	db FALSE ; is Dark
	db 67 ; level
	length 2.0 ; length
	weight 100.0 ; weight
	tx VenusaurDescription2 ; description
	db NONE ; AI info

VenusaurAltLv67Card:
	db TYPE_PKMN_GRASS ; type
	dw $a3f7 ; gfx
	tx VenusaurName ; name
	db STAR ; rarity
	db PRO ; set
	db 7 ; ?
	dw VENUSAUR_ALT_LV67
	db 100 ; hp
	db STAGE2 ; stage
	tx IvysaurName ; pre-evo name

	; attack 1
	energy 0 ; energies
	tx Text1325 ; name
	tx Text1326 ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db POKEMON_POWER ; category
	dw $415d ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_PKMN_POWER_1 ; animation

	; attack 2
	energy GRASS, 4 ; energies
	tx Text1327 ; name
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
	tx Text1307 ; category
	db DEX_VENUSAUR ; Pokedex number
	db FALSE ; is Dark
	db 67 ; level
	length 2.0 ; length
	weight 100.0 ; weight
	tx VenusaurDescription2 ; description
	db NONE ; AI info

DarkVenusaurCard:
	db TYPE_PKMN_GRASS ; type
	dw $c6bb ; gfx
	tx DarkVenusaurName ; name
	db STAR ; rarity
	db GB ; set
	db 6 ; ?
	dw DARK_VENUSAUR
	db 70 ; hp
	db STAGE2 ; stage
	tx DarkIvysaurName ; pre-evo name

	; attack 1
	energy GRASS, 3 ; energies
	tx Text132a ; name
	tx Text132b ; description
	dw NONE ; description (cont)
	db 30 ; damage
	db DAMAGE_NORMAL ; category
	dw $5343 ; effect commands
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
	tx Text1307 ; category
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
	db BEGINNING_POKEMON ; set
	db 1 ; ?
	dw CATERPIE
	db 40 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy GRASS, 1 ; energies
	tx Text132e ; name
	tx Text132f ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_NORMAL ; category
	dw $4043 ; effect commands
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
	tx Text1330 ; category
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
	db SKY_FLYING_POKEMON ; set
	db 3 ; ?
	dw METAPOD_LV20
	db 70 ; hp
	db STAGE1 ; stage
	tx CaterpieName ; pre-evo name

	; attack 1
	energy 0 ; energies
	tx Text1333 ; name
	tx Text1334 ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db POKEMON_POWER ; category
	dw $4c2b ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_NONE ; animation

	; attack 2
	energy GRASS, 2 ; energies
	tx Text1335 ; name
	tx Text1336 ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_NORMAL ; category
	dw $4c30 ; effect commands
	db INFLICT_CONFUSION  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_POWDER_EFFECT_CHANCE ; animation

	db 2 ; retreat cost
	db WR_FIRE ; weakness
	db NONE ; resistance
	tx Text1337 ; category
	db DEX_METAPOD ; Pokedex number
	db FALSE ; is Dark
	db 20 ; level
	length 0.7 ; length
	weight 9.9 ; weight
	tx MetapodDescription1 ; description
	db NONE | HAS_EVOLUTION ; AI info

MetapodLv21Card:
	db TYPE_PKMN_GRASS ; type
	dw $785 ; gfx
	tx MetapodName ; name
	db DIAMOND ; rarity
	db BEGINNING_POKEMON ; set
	db 1 ; ?
	dw METAPOD_LV21
	db 70 ; hp
	db STAGE1 ; stage
	tx CaterpieName ; pre-evo name

	; attack 1
	energy COLORLESS, 2 ; energies
	tx Text1339 ; name
	tx Text133a ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db RESIDUAL ; category
	dw $40a2 ; effect commands
	db NONE ; flags 1
	db NULLIFY_OR_WEAKEN_ATTACK  ; flags 2
	db FLAG_3_BIT_2  ; flags 3
	db 0 ; ?
	db ATK_ANIM_NONE ; animation

	; attack 2
	energy GRASS, 2 ; energies
	tx Text133b ; name
	tx Text132f ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_NORMAL ; category
	dw $40a7 ; effect commands
	db INFLICT_PARALYSIS  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_POWDER_EFFECT_CHANCE ; animation

	db 2 ; retreat cost
	db WR_FIRE ; weakness
	db NONE ; resistance
	tx Text1337 ; category
	db DEX_METAPOD ; Pokedex number
	db FALSE ; is Dark
	db 21 ; level
	length 0.7 ; length
	weight 9.9 ; weight
	tx MetapodDescription2 ; description
	db NONE | HAS_EVOLUTION ; AI info

ButterfreeCard:
	db TYPE_PKMN_GRASS ; type
	dw $800 ; gfx
	tx ButterfreeName ; name
	db DIAMOND ; rarity
	db LEGENDARY_POWER ; set
	db 1 ; ?
	dw BUTTERFREE
	db 70 ; hp
	db STAGE2 ; stage
	tx MetapodName ; pre-evo name

	; attack 1
	energy COLORLESS, 2 ; energies
	tx Text133e ; name
	tx Text133f ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_NORMAL ; category
	dw $4120 ; effect commands
	db NONE ; flags 1
	db SWITCH_OPPONENT_POKEMON  ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_WHIRLWIND ; animation

	; attack 2
	energy GRASS, 4 ; energies
	tx Text1322 ; name
	tx Text1323 ; description
	dw NONE ; description (cont)
	db 40 ; damage
	db DAMAGE_NORMAL ; category
	dw $412b ; effect commands
	db NONE ; flags 1
	db HEAL_USER  ; flags 2
	db NONE ; flags 3
	db 2 ; ?
	db ATK_ANIM_DRAIN ; animation

	db 0 ; retreat cost
	db WR_FIRE ; weakness
	db WR_FIGHTING ; resistance
	tx Text1340 ; category
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
	db BEGINNING_POKEMON ; set
	db 0 ; ?
	dw WEEDLE_LV12
	db 40 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy GRASS, 1 ; energies
	tx Text1343 ; name
	tx Text1344 ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_NORMAL ; category
	dw $413a ; effect commands
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
	tx Text1345 ; category
	db DEX_WEEDLE ; Pokedex number
	db FALSE ; is Dark
	db 12 ; level
	length 0.3 ; length
	weight 3.2 ; weight
	tx WeedleDescription1 ; description
	db AI_INFO_UNK_03 | HAS_EVOLUTION ; AI info

WeedleLv15Card:
	db TYPE_PKMN_GRASS ; type
	dw $730b ; gfx
	tx WeedleName ; name
	db CIRCLE ; rarity
	db SKY_FLYING_POKEMON ; set
	db 3 ; ?
	dw WEEDLE_LV15
	db 50 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy COLORLESS, 1 ; energies
	tx Text1347 ; name
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
	tx Text1348 ; name
	tx Text130f ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db DAMAGE_NORMAL ; category
	dw $4c35 ; effect commands
	db INFLICT_POISON  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_231 ; animation

	db 1 ; retreat cost
	db WR_FIRE ; weakness
	db NONE ; resistance
	tx Text1345 ; category
	db DEX_WEEDLE ; Pokedex number
	db FALSE ; is Dark
	db 15 ; level
	length 0.3 ; length
	weight 3.2 ; weight
	tx WeedleDescription2 ; description
	db NONE | HAS_EVOLUTION ; AI info

KakunaLv20Card:
	db TYPE_PKMN_GRASS ; type
	dw $73d0 ; gfx
	tx KakunaName ; name
	db DIAMOND ; rarity
	db SKY_FLYING_POKEMON ; set
	db 3 ; ?
	dw KAKUNA_LV20
	db 60 ; hp
	db STAGE1 ; stage
	tx WeedleName ; pre-evo name

	; attack 1
	energy 0 ; energies
	tx Text134b ; name
	tx Text134c ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db POKEMON_POWER ; category
	dw $4c3d ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_231 ; animation

	; attack 2
	energy COLORLESS, 1 ; energies
	tx Text134d ; name
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
	tx Text1337 ; category
	db DEX_KAKUNA ; Pokedex number
	db FALSE ; is Dark
	db 20 ; level
	length 0.6 ; length
	weight 10.0 ; weight
	tx KakunaDescription1 ; description
	db NONE | HAS_EVOLUTION ; AI info

KakunaLv23Card:
	db TYPE_PKMN_GRASS ; type
	dw $90e ; gfx
	tx KakunaName ; name
	db DIAMOND ; rarity
	db BEGINNING_POKEMON ; set
	db 0 ; ?
	dw KAKUNA_LV23
	db 80 ; hp
	db STAGE1 ; stage
	tx WeedleName ; pre-evo name

	; attack 1
	energy COLORLESS, 2 ; energies
	tx Text1339 ; name
	tx Text133a ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db RESIDUAL ; category
	dw $4055 ; effect commands
	db NONE ; flags 1
	db NULLIFY_OR_WEAKEN_ATTACK  ; flags 2
	db FLAG_3_BIT_2  ; flags 3
	db 0 ; ?
	db ATK_ANIM_NONE ; animation

	; attack 2
	energy GRASS, 2 ; energies
	tx Text1313 ; name
	tx Text1344 ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_NORMAL ; category
	dw $405a ; effect commands
	db INFLICT_POISON  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_POWDER_EFFECT_CHANCE ; animation

	db 2 ; retreat cost
	db WR_FIRE ; weakness
	db NONE ; resistance
	tx Text1337 ; category
	db DEX_KAKUNA ; Pokedex number
	db FALSE ; is Dark
	db 23 ; level
	length 0.6 ; length
	weight 10.0 ; weight
	tx KakunaDescription2 ; description
	db NONE | HAS_EVOLUTION ; AI info

BeedrillCard:
	db TYPE_PKMN_GRASS ; type
	dw $977 ; gfx
	tx BeedrillName ; name
	db STAR ; rarity
	db BEGINNING_POKEMON ; set
	db 0 ; ?
	dw BEEDRILL
	db 80 ; hp
	db STAGE2 ; stage
	tx KakunaName ; pre-evo name

	; attack 1
	energy COLORLESS, 3 ; energies
	tx Text1351 ; name
	tx Text1352 ; description
	dw NONE ; description (cont)
	db 30 ; damage
	db DAMAGE_X ; category
	dw $4080 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_NEEDLES ; animation

	; attack 2
	energy GRASS, 3 ; energies
	tx Text1343 ; name
	tx Text1344 ; description
	dw NONE ; description (cont)
	db 40 ; damage
	db DAMAGE_NORMAL ; category
	dw $4088 ; effect commands
	db INFLICT_POISON  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_NEEDLES ; animation

	db 0 ; retreat cost
	db WR_FIRE ; weakness
	db WR_FIGHTING ; resistance
	tx Text1353 ; category
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
	db ISLAND_OF_FOSSIL ; set
	db 2 ; ?
	dw EKANS_LV10
	db 40 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy GRASS, 1 ; energies
	tx Text1356 ; name
	tx Text1344 ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db DAMAGE_NORMAL ; category
	dw $4000 ; effect commands
	db INFLICT_POISON  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_SPIT_POISON ; animation

	; attack 2
	energy GRASS, 1, COLORLESS, 1 ; energies
	tx Text1357 ; name
	tx Text132f ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_NORMAL ; category
	dw $4008 ; effect commands
	db INFLICT_PARALYSIS  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_HIT ; animation

	db 1 ; retreat cost
	db WR_PSYCHIC ; weakness
	db NONE ; resistance
	tx Text1358 ; category
	db DEX_EKANS ; Pokedex number
	db FALSE ; is Dark
	db 10 ; level
	length 2.0 ; length
	weight 6.9 ; weight
	tx EkansDescription1 ; description
	db AI_INFO_UNK_03 | HAS_EVOLUTION ; AI info

EkansLv15Card:
	db TYPE_PKMN_GRASS ; type
	dw $6000 ; gfx
	tx EkansName ; name
	db CIRCLE ; rarity
	db PSYCHIC_BATTLE ; set
	db 5 ; ?
	dw EKANS_LV15
	db 50 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy COLORLESS, 1 ; energies
	tx Text135a ; name
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
	tx Text1343 ; name
	tx Text135b ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_NORMAL ; category
	dw $4998 ; effect commands
	db INFLICT_POISON  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_49 ; animation

	db 1 ; retreat cost
	db WR_PSYCHIC ; weakness
	db NONE ; resistance
	tx Text1358 ; category
	db DEX_EKANS ; Pokedex number
	db FALSE ; is Dark
	db 15 ; level
	length 2.0 ; length
	weight 6.9 ; weight
	tx EkansDescription2 ; description
	db NONE | HAS_EVOLUTION ; AI info

ArbokLv27Card:
	db TYPE_PKMN_GRASS ; type
	dw $a5b ; gfx
	tx ArbokName ; name
	db DIAMOND ; rarity
	db ISLAND_OF_FOSSIL ; set
	db 3 ; ?
	dw ARBOK_LV27
	db 60 ; hp
	db STAGE1 ; stage
	tx EkansName ; pre-evo name

	; attack 1
	energy GRASS, 1 ; energies
	tx Text135e ; name
	tx Text135f ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_NORMAL ; category
	dw $400d ; effect commands
	db NONE ; flags 1
	db SWITCH_OPPONENT_POKEMON  ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_240 ; animation

	; attack 2
	energy GRASS, 2, COLORLESS, 1 ; energies
	tx Text1360 ; name
	tx Text130f ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_NORMAL ; category
	dw $401b ; effect commands
	db INFLICT_POISON  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_POISON_FANG ; animation

	db 2 ; retreat cost
	db WR_PSYCHIC ; weakness
	db NONE ; resistance
	tx Text1361 ; category
	db DEX_ARBOK ; Pokedex number
	db FALSE ; is Dark
	db 27 ; level
	length 3.5 ; length
	weight 65.0 ; weight
	tx ArbokDescription1 ; description
	db NONE ; AI info

ArbokLv30Card:
	db TYPE_PKMN_GRASS ; type
	dw $8daf ; gfx
	tx ArbokName ; name
	db STAR ; rarity
	db SKY_FLYING_POKEMON ; set
	db 2 ; ?
	dw ARBOK_LV30
	db 60 ; hp
	db STAGE1 ; stage
	tx EkansName ; pre-evo name

	; attack 1
	energy GRASS, 1, COLORLESS, 1 ; energies
	tx Text1357 ; name
	tx Text1363 ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_NORMAL ; category
	dw $4f41 ; effect commands
	db INFLICT_PARALYSIS  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_HIT ; animation

	; attack 2
	energy GRASS, 3 ; energies
	tx Text1364 ; name
	tx Text1365 ; description
	dw NONE ; description (cont)
	db 30 ; damage
	db DAMAGE_PLUS ; category
	dw $4f46 ; effect commands
	db INFLICT_POISON  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_POISON_FANG ; animation

	db 2 ; retreat cost
	db WR_PSYCHIC ; weakness
	db NONE ; resistance
	tx Text1361 ; category
	db DEX_ARBOK ; Pokedex number
	db FALSE ; is Dark
	db 30 ; level
	length 3.5 ; length
	weight 65.0 ; weight
	tx ArbokDescription2 ; description
	db NONE ; AI info

DarkArbokCard:
	db TYPE_PKMN_GRASS ; type
	dw $6075 ; gfx
	tx DarkArbokName ; name
	db STAR ; rarity
	db PSYCHIC_BATTLE ; set
	db 5 ; ?
	dw DARK_ARBOK
	db 60 ; hp
	db STAGE1 ; stage
	tx EkansName ; pre-evo name

	; attack 1
	energy GRASS, 2 ; energies
	tx Text1368 ; name
	tx Text1369 ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db RESIDUAL ; category
	dw $49a0 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db SPECIAL_AI_HANDLING | FLAG_3_BIT_2  ; flags 3
	db 0 ; ?
	db ATK_ANIM_206 ; animation

	; attack 2
	energy GRASS, 3 ; energies
	tx Text136a ; name
	tx Text136b ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_NORMAL ; category
	dw $49b1 ; effect commands
	db INFLICT_POISON  ; flags 1
	db NONE ; flags 2
	db FLAG_3_BIT_2  ; flags 3
	db 0 ; ?
	db ATK_ANIM_190 ; animation

	db 2 ; retreat cost
	db WR_PSYCHIC ; weakness
	db NONE ; resistance
	tx Text1361 ; category
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
	db SKY_FLYING_POKEMON ; set
	db 3 ; ?
	dw NIDORANF_LV12
	db 50 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy COLORLESS, 1 ; energies
	tx Text136e ; name
	tx Text136f ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db DAMAGE_NORMAL ; category
	dw $4c59 ; effect commands
	db NONE ; flags 1
	db NULLIFY_OR_WEAKEN_ATTACK  ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_201 ; animation

	; attack 2
	energy GRASS, 1 ; energies
	tx Text1343 ; name
	tx Text135b ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_NORMAL ; category
	dw $4c5e ; effect commands
	db INFLICT_POISON  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_49 ; animation

	db 1 ; retreat cost
	db WR_PSYCHIC ; weakness
	db NONE ; resistance
	tx Text1343 ; category
	db DEX_NIDORAN_F ; Pokedex number
	db FALSE ; is Dark
	db 12 ; level
	length 0.4 ; length
	weight 7.0 ; weight
	tx NidoranFDescription1 ; description
	db NONE | HAS_EVOLUTION ; AI info

NidoranFLv13Card:
	db TYPE_PKMN_GRASS ; type
	dw $ae2 ; gfx
	tx NidoranFName ; name
	db CIRCLE ; rarity
	db LEGENDARY_POWER ; set
	db 1 ; ?
	dw NIDORANF_LV13
	db 60 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy GRASS, 1 ; energies
	tx Text1371 ; name
	tx Text1372 ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_X ; category
	dw $40ed ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_MULTIPLE_SLASH ; animation

	; attack 2
	energy GRASS, 2 ; energies
	tx Text1373 ; name
	tx Text1374 ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db RESIDUAL ; category
	dw $40f5 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db SPECIAL_AI_HANDLING | FLAG_3_BIT_2  ; flags 3
	db 0 ; ?
	db ATK_ANIM_GLOW_EFFECT ; animation

	db 1 ; retreat cost
	db WR_PSYCHIC ; weakness
	db NONE ; resistance
	tx Text1343 ; category
	db DEX_NIDORAN_F ; Pokedex number
	db FALSE ; is Dark
	db 13 ; level
	length 0.4 ; length
	weight 7.0 ; weight
	tx NidoranFDescription2 ; description
	db AI_INFO_UNK_03 | HAS_EVOLUTION ; AI info

NidorinaLv22Card:
	db TYPE_PKMN_GRASS ; type
	dw $8e87 ; gfx
	tx NidorinaName ; name
	db DIAMOND ; rarity
	db SKY_FLYING_POKEMON ; set
	db 3 ; ?
	dw NIDORINA_LV22
	db 60 ; hp
	db STAGE1 ; stage
	tx NidoranFName ; pre-evo name

	; attack 1
	energy GRASS, 2 ; energies
	tx Text1377 ; name
	tx Text1378 ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_PLUS ; category
	dw $4f5e ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_HIT ; animation

	; attack 2
	energy GRASS, 2, COLORLESS, 1 ; energies
	tx Text1371 ; name
	tx Text1379 ; description
	dw NONE ; description (cont)
	db 30 ; damage
	db DAMAGE_X ; category
	dw $4f66 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_MULTIPLE_SLASH ; animation

	db 2 ; retreat cost
	db WR_PSYCHIC ; weakness
	db NONE ; resistance
	tx Text1343 ; category
	db DEX_NIDORINA ; Pokedex number
	db FALSE ; is Dark
	db 22 ; level
	length 0.8 ; length
	weight 20.0 ; weight
	tx NidorinaDescription1 ; description
	db NONE | HAS_EVOLUTION ; AI info

NidorinaLv24Card:
	db TYPE_PKMN_GRASS ; type
	dw $b4d ; gfx
	tx NidorinaName ; name
	db DIAMOND ; rarity
	db LEGENDARY_POWER ; set
	db 1 ; ?
	dw NIDORINA_LV24
	db 70 ; hp
	db STAGE1 ; stage
	tx NidoranFName ; pre-evo name

	; attack 1
	energy GRASS, 1 ; energies
	tx Text137b ; name
	tx Text137c ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db DAMAGE_NORMAL ; category
	dw $410b ; effect commands
	db INFLICT_CONFUSION  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_SUPERSONIC ; animation

	; attack 2
	energy GRASS, 1, COLORLESS, 2 ; energies
	tx Text137d ; name
	tx Text1352 ; description
	dw NONE ; description (cont)
	db 30 ; damage
	db DAMAGE_X ; category
	dw $4110 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_182 ; animation

	db 1 ; retreat cost
	db WR_PSYCHIC ; weakness
	db NONE ; resistance
	tx Text1343 ; category
	db DEX_NIDORINA ; Pokedex number
	db FALSE ; is Dark
	db 24 ; level
	length 0.8 ; length
	weight 20.0 ; weight
	tx NidorinaDescription2 ; description
	db NONE | HAS_EVOLUTION ; AI info

NidoqueenCard:
	db TYPE_PKMN_GRASS ; type
	dw $bbe ; gfx
	tx NidoqueenName ; name
	db STAR ; rarity
	db LEGENDARY_POWER ; set
	db 2 ; ?
	dw NIDOQUEEN
	db 90 ; hp
	db STAGE2 ; stage
	tx NidorinaName ; pre-evo name

	; attack 1
	energy GRASS, 1, COLORLESS, 1 ; energies
	tx Text1380 ; name
	tx Text1381 ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_PLUS ; category
	dw $40e8 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_BOYFRIENDS ; animation

	; attack 2
	energy GRASS, 2, COLORLESS, 2 ; energies
	tx Text1382 ; name
	dw NONE ; description
	dw NONE ; description (cont)
	db 50 ; damage
	db DAMAGE_NORMAL ; category
	dw NONE ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_176 ; animation

	db 3 ; retreat cost
	db WR_PSYCHIC ; weakness
	db NONE ; resistance
	tx Text1383 ; category
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
	db BEGINNING_POKEMON ; set
	db 0 ; ?
	dw NIDORANM_LV20
	db 40 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy GRASS, 1 ; energies
	tx Text1386 ; name
	tx Text1387 ; description
	dw NONE ; description (cont)
	db 30 ; damage
	db DAMAGE_NORMAL ; category
	dw $4103 ; effect commands
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
	tx Text1343 ; category
	db DEX_NIDORAN_M ; Pokedex number
	db FALSE ; is Dark
	db 20 ; level
	length 0.5 ; length
	weight 9.0 ; weight
	tx NidoranMDescription1 ; description
	db AI_INFO_UNK_03 | HAS_EVOLUTION ; AI info

NidoranMLv22Card:
	db TYPE_PKMN_GRASS ; type
	dw $7675 ; gfx
	tx NidoranMName ; name
	db CIRCLE ; rarity
	db SKY_FLYING_POKEMON ; set
	db 3 ; ?
	dw NIDORANM_LV22
	db 50 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy COLORLESS, 1 ; energies
	tx Text1389 ; name
	tx Text138a ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db RESIDUAL ; category
	dw $4c66 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db SPECIAL_AI_HANDLING | FLAG_3_BIT_2  ; flags 3
	db 0 ; ?
	db ATK_ANIM_GLOW_EFFECT ; animation

	; attack 2
	energy GRASS, 1, COLORLESS, 1 ; energies
	tx Text138b ; name
	tx Text138c ; description
	dw NONE ; description (cont)
	db 40 ; damage
	db DAMAGE_NORMAL ; category
	dw $4c6b ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_HIT ; animation

	db 1 ; retreat cost
	db WR_PSYCHIC ; weakness
	db NONE ; resistance
	tx Text1343 ; category
	db DEX_NIDORAN_M ; Pokedex number
	db FALSE ; is Dark
	db 22 ; level
	length 0.5 ; length
	weight 9.0 ; weight
	tx NidoranMDescription2 ; description
	db NONE | HAS_EVOLUTION ; AI info

NidorinoLv23Card:
	db TYPE_PKMN_GRASS ; type
	dw $8ef0 ; gfx
	tx NidorinoName ; name
	db DIAMOND ; rarity
	db SKY_FLYING_POKEMON ; set
	db 3 ; ?
	dw NIDORINO_LV23
	db 60 ; hp
	db STAGE1 ; stage
	tx NidoranMName ; pre-evo name

	; attack 1
	energy GRASS, 2 ; energies
	tx Text138f ; name
	tx Text1390 ; description
	dw NONE ; description (cont)
	db 60 ; damage
	db DAMAGE_NORMAL ; category
	dw $4f6e ; effect commands
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
	tx Text1343 ; category
	db DEX_NIDORINO ; Pokedex number
	db FALSE ; is Dark
	db 23 ; level
	length 0.9 ; length
	weight 19.5 ; weight
	tx NidorinoDescription1 ; description
	db NONE | HAS_EVOLUTION ; AI info

NidorinoLv25Card:
	db TYPE_PKMN_GRASS ; type
	dw $c92 ; gfx
	tx NidorinoName ; name
	db DIAMOND ; rarity
	db BEGINNING_POKEMON ; set
	db 0 ; ?
	dw NIDORINO_LV25
	db 60 ; hp
	db STAGE1 ; stage
	tx NidoranMName ; pre-evo name

	; attack 1
	energy GRASS, 1, COLORLESS, 2 ; energies
	tx Text137d ; name
	tx Text1352 ; description
	dw NONE ; description (cont)
	db 30 ; damage
	db DAMAGE_X ; category
	dw $4118 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_182 ; animation

	; attack 2
	energy GRASS, 2, COLORLESS, 2 ; energies
	tx Text1392 ; name
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
	tx Text1343 ; category
	db DEX_NIDORINO ; Pokedex number
	db FALSE ; is Dark
	db 25 ; level
	length 0.9 ; length
	weight 19.5 ; weight
	tx NidorinoDescription2 ; description
	db NONE | HAS_EVOLUTION ; AI info

NidokingCard:
	db TYPE_PKMN_GRASS ; type
	dw $cfb ; gfx
	tx NidokingName ; name
	db STAR ; rarity
	db BEGINNING_POKEMON ; set
	db 1 ; ?
	dw NIDOKING
	db 90 ; hp
	db STAGE2 ; stage
	tx NidorinoName ; pre-evo name

	; attack 1
	energy GRASS, 1, COLORLESS, 2 ; energies
	tx Text1395 ; name
	tx Text1396 ; description
	dw NONE ; description (cont)
	db 30 ; damage
	db DAMAGE_PLUS ; category
	dw $40d5 ; effect commands
	db LOW_RECOIL  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_MULTIPLE_SLASH ; animation

	; attack 2
	energy GRASS, 3 ; energies
	tx Text1397 ; name
	tx Text1398 ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_NORMAL ; category
	dw $40e0 ; effect commands
	db INFLICT_POISON  ; flags 1
	db FLAG_2_BIT_6  ; flags 2
	db NONE ; flags 3
	db 2 ; ?
	db ATK_ANIM_TOXIC ; animation

	db 3 ; retreat cost
	db WR_PSYCHIC ; weakness
	db NONE ; resistance
	tx Text1383 ; category
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
	db PSYCHIC_BATTLE ; set
	db 6 ; ?
	dw ZUBAT_LV9
	db 40 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy COLORLESS, 1 ; energies
	tx Text139b ; name
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
	tx Text135a ; name
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
	tx Text139c ; category
	db DEX_ZUBAT ; Pokedex number
	db FALSE ; is Dark
	db 9 ; level
	length 0.8 ; length
	weight 7.5 ; weight
	tx ZubatDescription1 ; description
	db NONE | HAS_EVOLUTION ; AI info

ZubatLv10Card:
	db TYPE_PKMN_GRASS ; type
	dw $d64 ; gfx
	tx ZubatName ; name
	db CIRCLE ; rarity
	db ISLAND_OF_FOSSIL ; set
	db 2 ; ?
	dw ZUBAT_LV10
	db 40 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy COLORLESS, 2 ; energies
	tx Text137b ; name
	tx Text137c ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db DAMAGE_NORMAL ; category
	dw $4076 ; effect commands
	db INFLICT_CONFUSION  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_SUPERSONIC ; animation

	; attack 2
	energy GRASS, 1, COLORLESS, 1 ; energies
	tx Text139e ; name
	tx Text139f ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_NORMAL ; category
	dw $407b ; effect commands
	db NONE ; flags 1
	db HEAL_USER  ; flags 2
	db NONE ; flags 3
	db 3 ; ?
	db ATK_ANIM_DRAIN ; animation

	db 0 ; retreat cost
	db WR_PSYCHIC ; weakness
	db WR_FIGHTING ; resistance
	tx Text139c ; category
	db DEX_ZUBAT ; Pokedex number
	db FALSE ; is Dark
	db 10 ; level
	length 0.8 ; length
	weight 7.5 ; weight
	tx ZubatDescription2 ; description
	db NONE | HAS_EVOLUTION ; AI info

ZubatLv12Card:
	db TYPE_PKMN_GRASS ; type
	dw $7800 ; gfx
	tx ZubatName ; name
	db CIRCLE ; rarity
	db SKY_FLYING_POKEMON ; set
	db 4 ; ?
	dw ZUBAT_LV12
	db 40 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy COLORLESS, 1 ; energies
	tx Text135a ; name
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
	tx Text13a1 ; name
	tx Text1336 ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_NORMAL ; category
	dw $4c96 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_215 ; animation

	db 0 ; retreat cost
	db WR_PSYCHIC ; weakness
	db WR_FIGHTING ; resistance
	tx Text139c ; category
	db DEX_ZUBAT ; Pokedex number
	db FALSE ; is Dark
	db 12 ; level
	length 0.8 ; length
	weight 7.5 ; weight
	tx ZubatDescription3 ; description
	db NONE | HAS_EVOLUTION ; AI info

GolbatLv25Card:
	db TYPE_PKMN_GRASS ; type
	dw $7869 ; gfx
	tx GolbatName ; name
	db DIAMOND ; rarity
	db SKY_FLYING_POKEMON ; set
	db 2 ; ?
	dw GOLBAT_LV25
	db 50 ; hp
	db STAGE1 ; stage
	tx ZubatName ; pre-evo name

	; attack 1
	energy GRASS, 2, COLORLESS, 1 ; energies
	tx Text139e ; name
	tx Text13a4 ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_NORMAL ; category
	dw $4c9b ; effect commands
	db NONE ; flags 1
	db HEAL_USER  ; flags 2
	db NONE ; flags 3
	db 3 ; ?
	db ATK_ANIM_DRAIN ; animation

	; attack 2
	energy GRASS, 1, COLORLESS, 3 ; energies
	tx Text13a5 ; name
	tx Text13a6 ; description
	dw NONE ; description (cont)
	db 60 ; damage
	db DAMAGE_NORMAL ; category
	dw $4ca0 ; effect commands
	db LOW_RECOIL  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_BIG_HIT ; animation

	db 1 ; retreat cost
	db WR_PSYCHIC ; weakness
	db WR_FIGHTING ; resistance
	tx Text139c ; category
	db DEX_GOLBAT ; Pokedex number
	db FALSE ; is Dark
	db 25 ; level
	length 1.6 ; length
	weight 55.0 ; weight
	tx GolbatDescription1 ; description
	db NONE ; AI info

GolbatLv29Card:
	db TYPE_PKMN_GRASS ; type
	dw $dcd ; gfx
	tx GolbatName ; name
	db DIAMOND ; rarity
	db ISLAND_OF_FOSSIL ; set
	db 4 ; ?
	dw GOLBAT_LV29
	db 60 ; hp
	db STAGE1 ; stage
	tx ZubatName ; pre-evo name

	; attack 1
	energy COLORLESS, 3 ; energies
	tx Text13a8 ; name
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
	tx Text139e ; name
	tx Text139f ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_NORMAL ; category
	dw $4062 ; effect commands
	db NONE ; flags 1
	db HEAL_USER  ; flags 2
	db NONE ; flags 3
	db 3 ; ?
	db ATK_ANIM_DRAIN ; animation

	db 0 ; retreat cost
	db WR_PSYCHIC ; weakness
	db WR_FIGHTING ; resistance
	tx Text139c ; category
	db DEX_GOLBAT ; Pokedex number
	db FALSE ; is Dark
	db 29 ; level
	length 1.6 ; length
	weight 55.0 ; weight
	tx GolbatDescription2 ; description
	db NONE ; AI info

DarkGolbatCard:
	db TYPE_PKMN_GRASS ; type
	dw $614b ; gfx
	tx DarkGolbatName ; name
	db STAR ; rarity
	db PSYCHIC_BATTLE ; set
	db 6 ; ?
	dw DARK_GOLBAT
	db 50 ; hp
	db STAGE1 ; stage
	tx ZubatName ; pre-evo name

	; attack 1
	energy 0 ; energies
	tx Text13ab ; name
	tx Text13ac ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db POKEMON_POWER ; category
	dw $49b9 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_151 ; animation

	; attack 2
	energy GRASS, 2 ; energies
	tx Text13ad ; name
	tx Text13ae ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db RESIDUAL ; category
	dw $49c4 ; effect commands
	db DAMAGE_TO_OPPONENT_BENCH  ; flags 1
	db FLAG_2_BIT_6  ; flags 2
	db FLAG_3_BIT_2  ; flags 3
	db 0 ; ?
	db ATK_ANIM_HIT ; animation

	db 0 ; retreat cost
	db WR_PSYCHIC ; weakness
	db WR_FIGHTING ; resistance
	tx Text139c ; category
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
	db LEGENDARY_POWER ; set
	db 2 ; ?
	dw ODDISH_LV8
	db 50 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy GRASS, 1 ; energies
	tx Text133b ; name
	tx Text132f ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_NORMAL ; category
	dw $40ac ; effect commands
	db INFLICT_PARALYSIS  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_POWDER_EFFECT_CHANCE ; animation

	; attack 2
	energy GRASS, 2 ; energies
	tx Text13b1 ; name
	tx Text13b2 ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db RESIDUAL ; category
	dw $40b1 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db SPECIAL_AI_HANDLING | FLAG_3_BIT_2  ; flags 3
	db 0 ; ?
	db ATK_ANIM_GLOW_EFFECT ; animation

	db 1 ; retreat cost
	db WR_FIRE ; weakness
	db NONE ; resistance
	tx Text13b3 ; category
	db DEX_ODDISH ; Pokedex number
	db FALSE ; is Dark
	db 8 ; level
	length 0.5 ; length
	weight 5.4 ; weight
	tx OddishDescription1 ; description
	db NONE | HAS_EVOLUTION ; AI info

OddishLv21Card:
	db TYPE_PKMN_GRASS ; type
	dw $61bc ; gfx
	tx OddishName ; name
	db CIRCLE ; rarity
	db PSYCHIC_BATTLE ; set
	db 6 ; ?
	dw ODDISH_LV21
	db 50 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy GRASS, 1 ; energies
	tx Text13b5 ; name
	tx Text13b6 ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db DAMAGE_NORMAL ; category
	dw $49d5 ; effect commands
	db INFLICT_SLEEP  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_SPORE ; animation

	; attack 2
	energy GRASS, 1 ; energies
	tx Text1313 ; name
	tx Text130f ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db DAMAGE_NORMAL ; category
	dw $49da ; effect commands
	db INFLICT_POISON  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_POISON_POWDER ; animation

	db 1 ; retreat cost
	db WR_FIRE ; weakness
	db NONE ; resistance
	tx Text13b3 ; category
	db DEX_ODDISH ; Pokedex number
	db FALSE ; is Dark
	db 21 ; level
	length 0.5 ; length
	weight 5.4 ; weight
	tx OddishDescription2 ; description
	db NONE | HAS_EVOLUTION ; AI info

GloomCard:
	db TYPE_PKMN_GRASS ; type
	dw $e9f ; gfx
	tx GloomName ; name
	db DIAMOND ; rarity
	db LEGENDARY_POWER ; set
	db 2 ; ?
	dw GLOOM
	db 60 ; hp
	db STAGE1 ; stage
	tx OddishName ; pre-evo name

	; attack 1
	energy GRASS, 1 ; energies
	tx Text1313 ; name
	tx Text130f ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db DAMAGE_NORMAL ; category
	dw $4048 ; effect commands
	db INFLICT_POISON  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_POISON_POWDER ; animation

	; attack 2
	energy GRASS, 2 ; energies
	tx Text13b9 ; name
	tx Text13ba ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_NORMAL ; category
	dw $4050 ; effect commands
	db INFLICT_CONFUSION  ; flags 1
	db FLAG_2_BIT_7  ; flags 2
	db NONE ; flags 3
	db 1 ; ?
	db ATK_ANIM_FOUL_ODOR ; animation

	db 1 ; retreat cost
	db WR_FIRE ; weakness
	db NONE ; resistance
	tx Text13b3 ; category
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
	db PSYCHIC_BATTLE ; set
	db 6 ; ?
	dw DARK_GLOOM
	db 50 ; hp
	db STAGE1 ; stage
	tx OddishName ; pre-evo name

	; attack 1
	energy 0 ; energies
	tx Text13bd ; name
	tx Text13be ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db POKEMON_POWER ; category
	dw $49e2 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_186 ; animation

	; attack 2
	energy GRASS, 2 ; energies
	tx Text1313 ; name
	tx Text130f ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_NORMAL ; category
	dw $49ea ; effect commands
	db INFLICT_POISON  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_60 ; animation

	db 2 ; retreat cost
	db WR_FIRE ; weakness
	db NONE ; resistance
	tx Text13b3 ; category
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
	db LEGENDARY_POWER ; set
	db 2 ; ?
	dw VILEPLUME
	db 80 ; hp
	db STAGE2 ; stage
	tx GloomName ; pre-evo name

	; attack 1
	energy 0 ; energies
	tx Text13c1 ; name
	tx Text13c2 ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db POKEMON_POWER ; category
	dw $41bd ; effect commands
	db NONE ; flags 1
	db HEAL_USER  ; flags 2
	db NONE ; flags 3
	db 1 ; ?
	db ATK_ANIM_PKMN_POWER_1 ; animation

	; attack 2
	energy GRASS, 3 ; energies
	tx Text13c3 ; name
	tx Text13c4 ; description
	dw NONE ; description (cont)
	db 40 ; damage
	db DAMAGE_X ; category
	dw $41c5 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_PETAL_DANCE ; animation

	db 2 ; retreat cost
	db WR_FIRE ; weakness
	db NONE ; resistance
	tx Text13c5 ; category
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
	db PSYCHIC_BATTLE ; set
	db 6 ; ?
	dw DARK_VILEPLUME
	db 60 ; hp
	db STAGE2 ; stage
	tx DarkGloomName ; pre-evo name

	; attack 1
	energy 0 ; energies
	tx Text13c8 ; name
	tx Text13c9 ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db POKEMON_POWER ; category
	dw $49f2 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_NONE ; animation

	; attack 2
	energy GRASS, 3 ; energies
	tx Text13ca ; name
	tx Text13cb ; description
	dw NONE ; description (cont)
	db 30 ; damage
	db DAMAGE_X ; category
	dw $49f7 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_PETAL_DANCE ; animation

	db 2 ; retreat cost
	db WR_FIRE ; weakness
	db NONE ; resistance
	tx Text13c5 ; category
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
	db LEGENDARY_POWER ; set
	db 3 ; ?
	dw PARAS_LV8
	db 40 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy COLORLESS, 2 ; energies
	tx Text13ce ; name
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
	tx Text13cf ; name
	tx Text13b6 ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db DAMAGE_NORMAL ; category
	dw $4130 ; effect commands
	db INFLICT_SLEEP  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_SPORE ; animation

	db 1 ; retreat cost
	db WR_FIRE ; weakness
	db NONE ; resistance
	tx Text13d0 ; category
	db DEX_PARAS ; Pokedex number
	db FALSE ; is Dark
	db 8 ; level
	length 0.3 ; length
	weight 5.4 ; weight
	tx ParasDescription1 ; description
	db NONE | HAS_EVOLUTION ; AI info

ParasLv15Card:
	db TYPE_PKMN_GRASS ; type
	dw $78d6 ; gfx
	tx ParasName ; name
	db CIRCLE ; rarity
	db SKY_FLYING_POKEMON ; set
	db 1 ; ?
	dw PARAS_LV15
	db 50 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy COLORLESS, 1 ; energies
	tx Text13ce ; name
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
	tx Text13d2 ; name
	tx Text13d3 ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db RESIDUAL ; category
	dw $4ca8 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db SPECIAL_AI_HANDLING | FLAG_3_BIT_2  ; flags 3
	db 0 ; ?
	db ATK_ANIM_GLOW_EFFECT ; animation

	db 1 ; retreat cost
	db WR_FIRE ; weakness
	db NONE ; resistance
	tx Text13d0 ; category
	db DEX_PARAS ; Pokedex number
	db FALSE ; is Dark
	db 15 ; level
	length 0.3 ; length
	weight 5.4 ; weight
	tx ParasDescription2 ; description
	db NONE | HAS_EVOLUTION ; AI info

ParasectLv28Card:
	db TYPE_PKMN_GRASS ; type
	dw $1000 ; gfx
	tx ParasectName ; name
	db DIAMOND ; rarity
	db LEGENDARY_POWER ; set
	db 3 ; ?
	dw PARASECT_LV28
	db 60 ; hp
	db STAGE1 ; stage
	tx ParasName ; pre-evo name

	; attack 1
	energy GRASS, 2 ; energies
	tx Text13cf ; name
	tx Text13b6 ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db DAMAGE_NORMAL ; category
	dw $4135 ; effect commands
	db INFLICT_SLEEP  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_SPORE ; animation

	; attack 2
	energy COLORLESS, 3 ; energies
	tx Text13d6 ; name
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
	tx Text13d0 ; category
	db DEX_PARASECT ; Pokedex number
	db FALSE ; is Dark
	db 28 ; level
	length 1.0 ; length
	weight 29.5 ; weight
	tx ParasectDescription1 ; description
	db NONE ; AI info

ParasectLv29Card:
	db TYPE_PKMN_GRASS ; type
	dw $793f ; gfx
	tx ParasectName ; name
	db DIAMOND ; rarity
	db SKY_FLYING_POKEMON ; set
	db 1 ; ?
	dw PARASECT_LV29
	db 60 ; hp
	db STAGE1 ; stage
	tx ParasName ; pre-evo name

	; attack 1
	energy GRASS, 2 ; energies
	tx Text13d8 ; name
	tx Text130f ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_NORMAL ; category
	dw $4cb6 ; effect commands
	db INFLICT_POISON  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_POWDER_HIT_POISON ; animation

	; attack 2
	energy GRASS, 2, COLORLESS, 1 ; energies
	tx Text139e ; name
	tx Text13a4 ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_NORMAL ; category
	dw $4cbe ; effect commands
	db NONE ; flags 1
	db HEAL_USER  ; flags 2
	db NONE ; flags 3
	db 3 ; ?
	db ATK_ANIM_DRAIN ; animation

	db 2 ; retreat cost
	db WR_FIRE ; weakness
	db NONE ; resistance
	tx Text13d0 ; category
	db DEX_PARASECT ; Pokedex number
	db FALSE ; is Dark
	db 29 ; level
	length 1.0 ; length
	weight 29.5 ; weight
	tx ParasectDescription2 ; description
	db NONE ; AI info

VenonatLv12Card:
	db TYPE_PKMN_GRASS ; type
	dw $106f ; gfx
	tx VenonatName ; name
	db CIRCLE ; rarity
	db LEGENDARY_POWER ; set
	db 3 ; ?
	dw VENONAT_LV12
	db 40 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy GRASS, 1 ; energies
	tx Text133b ; name
	tx Text132f ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_NORMAL ; category
	dw $4067 ; effect commands
	db INFLICT_PARALYSIS  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_POWDER_EFFECT_CHANCE ; animation

	; attack 2
	energy GRASS, 1, COLORLESS, 1 ; energies
	tx Text139e ; name
	tx Text139f ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_NORMAL ; category
	dw $406c ; effect commands
	db NONE ; flags 1
	db HEAL_USER  ; flags 2
	db NONE ; flags 3
	db 3 ; ?
	db ATK_ANIM_DRAIN ; animation

	db 1 ; retreat cost
	db WR_FIRE ; weakness
	db NONE ; resistance
	tx Text13db ; category
	db DEX_VENONAT ; Pokedex number
	db FALSE ; is Dark
	db 12 ; level
	length 1.0 ; length
	weight 30.0 ; weight
	tx VenonatDescription1 ; description
	db AI_INFO_UNK_03 | HAS_EVOLUTION ; AI info

VenonatLv15Card:
	db TYPE_PKMN_GRASS ; type
	dw $9000 ; gfx
	tx VenonatName ; name
	db CIRCLE ; rarity
	db SKY_FLYING_POKEMON ; set
	db 0 ; ?
	dw VENONAT_LV15
	db 50 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy COLORLESS, 1 ; energies
	tx Text13dd ; name
	tx Text13de ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db DAMAGE_NORMAL ; category
	dw $4f84 ; effect commands
	db NONE ; flags 1
	db NULLIFY_OR_WEAKEN_ATTACK  ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_AMNESIA ; animation

	; attack 2
	energy GRASS, 2 ; energies
	tx Text13df ; name
	tx Text1336 ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_NORMAL ; category
	dw $4f92 ; effect commands
	db INFLICT_CONFUSION  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_169 ; animation

	db 1 ; retreat cost
	db WR_FIRE ; weakness
	db NONE ; resistance
	tx Text13db ; category
	db DEX_VENONAT ; Pokedex number
	db FALSE ; is Dark
	db 15 ; level
	length 1.0 ; length
	weight 30.0 ; weight
	tx VenonatDescription2 ; description
	db NONE | HAS_EVOLUTION ; AI info

VenomothLv22Card:
	db TYPE_PKMN_GRASS ; type
	dw $833b ; gfx
	tx VenomothName ; name
	db CIRCLE ; rarity
	db SKY_FLYING_POKEMON ; set
	db 3 ; ?
	dw VENOMOTH_LV22
	db 60 ; hp
	db STAGE1 ; stage
	tx VenonatName ; pre-evo name

	; attack 1
	energy GRASS, 2 ; energies
	tx Text13e2 ; name
	tx Text13e3 ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_NORMAL ; category
	dw $4e0e ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db SPECIAL_AI_HANDLING  ; flags 3
	db 0 ; ?
	db ATK_ANIM_WHIRLWIND ; animation

	; attack 2
	energy GRASS, 2, COLORLESS, 1 ; energies
	tx Text13e4 ; name
	tx Text13e5 ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_NORMAL ; category
	dw $4e19 ; effect commands
	db INFLICT_POISON | INFLICT_PARALYSIS  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_POWDER_HIT_POISON ; animation

	db 0 ; retreat cost
	db WR_FIRE ; weakness
	db WR_FIGHTING ; resistance
	tx Text13e6 ; category
	db DEX_VENOMOTH ; Pokedex number
	db FALSE ; is Dark
	db 22 ; level
	length 1.5 ; length
	weight 12.5 ; weight
	tx VenomothDescription1 ; description
	db NONE ; AI info

VenomothLv28Card:
	db TYPE_PKMN_GRASS ; type
	dw $10d8 ; gfx
	tx VenomothName ; name
	db STAR ; rarity
	db LEGENDARY_POWER ; set
	db 0 ; ?
	dw VENOMOTH_LV28
	db 70 ; hp
	db STAGE1 ; stage
	tx VenonatName ; pre-evo name

	; attack 1
	energy 0 ; energies
	tx Text13e8 ; name
	tx Text13e9 ; description
	tx Text13ea ; description (cont)
	db 0 ; damage
	db POKEMON_POWER ; category
	dw $419d ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_PKMN_POWER_1 ; animation

	; attack 2
	energy GRASS, 2 ; energies
	tx Text13eb ; name
	tx Text13ec ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_NORMAL ; category
	dw $41a8 ; effect commands
	db INFLICT_POISON | INFLICT_CONFUSION  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_POWDER_EFFECT_CHANCE ; animation

	db 0 ; retreat cost
	db WR_FIRE ; weakness
	db WR_FIGHTING ; resistance
	tx Text13e6 ; category
	db DEX_VENOMOTH ; Pokedex number
	db FALSE ; is Dark
	db 28 ; level
	length 1.5 ; length
	weight 12.5 ; weight
	tx VenomothDescription2 ; description
	db NONE ; AI info

BellsproutLv10Card:
	db TYPE_PKMN_GRASS ; type
	dw $930b ; gfx
	tx BellsproutName ; name
	db CIRCLE ; rarity
	db SKY_FLYING_POKEMON ; set
	db 4 ; ?
	dw BELLSPROUT_LV10
	db 40 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy COLORLESS, 1 ; energies
	tx Text13ef ; name
	tx Text133a ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db RESIDUAL ; category
	dw $5010 ; effect commands
	db NONE ; flags 1
	db NULLIFY_OR_WEAKEN_ATTACK  ; flags 2
	db FLAG_3_BIT_2  ; flags 3
	db 0 ; ?
	db ATK_ANIM_PROTECT ; animation

	; attack 2
	energy GRASS, 1 ; energies
	tx Text133b ; name
	tx Text1363 ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_NORMAL ; category
	dw $5015 ; effect commands
	db INFLICT_PARALYSIS  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_59 ; animation

	db 1 ; retreat cost
	db WR_FIRE ; weakness
	db NONE ; resistance
	tx Text13c5 ; category
	db DEX_BELLSPROUT ; Pokedex number
	db FALSE ; is Dark
	db 10 ; level
	length 0.7 ; length
	weight 4.0 ; weight
	tx BellsproutDescription1 ; description
	db NONE | HAS_EVOLUTION ; AI info

BellsproutLv11Card:
	db TYPE_PKMN_GRASS ; type
	dw $1141 ; gfx
	tx BellsproutName ; name
	db CIRCLE ; rarity
	db LEGENDARY_POWER ; set
	db 2 ; ?
	dw BELLSPROUT_LV11
	db 40 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy GRASS, 1 ; energies
	tx Text1317 ; name
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
	tx Text1373 ; name
	tx Text13f1 ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db RESIDUAL ; category
	dw $4182 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db SPECIAL_AI_HANDLING | FLAG_3_BIT_2  ; flags 3
	db 0 ; ?
	db ATK_ANIM_GLOW_EFFECT ; animation

	db 1 ; retreat cost
	db WR_FIRE ; weakness
	db NONE ; resistance
	tx Text13c5 ; category
	db DEX_BELLSPROUT ; Pokedex number
	db FALSE ; is Dark
	db 11 ; level
	length 0.7 ; length
	weight 4.0 ; weight
	tx BellsproutDescription2 ; description
	db AI_INFO_UNK_03 | HAS_EVOLUTION ; AI info

WeepinbellLv23Card:
	db TYPE_PKMN_GRASS ; type
	dw $9374 ; gfx
	tx WeepinbellName ; name
	db DIAMOND ; rarity
	db SKY_FLYING_POKEMON ; set
	db 4 ; ?
	dw WEEPINBELL_LV23
	db 60 ; hp
	db STAGE1 ; stage
	tx BellsproutName ; pre-evo name

	; attack 1
	energy GRASS, 1 ; energies
	tx Text13f4 ; name
	tx Text13f5 ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db RESIDUAL ; category
	dw $501a ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db SPECIAL_AI_HANDLING | FLAG_3_BIT_2  ; flags 3
	db 0 ; ?
	db ATK_ANIM_RECOVER ; animation

	; attack 2
	energy GRASS, 2 ; energies
	tx Text13f6 ; name
	tx Text13f7 ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_NORMAL ; category
	dw $501f ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_GOO ; animation

	db 1 ; retreat cost
	db WR_FIRE ; weakness
	db NONE ; resistance
	tx Text13f8 ; category
	db DEX_WEEPINBELL ; Pokedex number
	db FALSE ; is Dark
	db 23 ; level
	length 1.0 ; length
	weight 6.4 ; weight
	tx WeepinbellDescription1 ; description
	db NONE | HAS_EVOLUTION ; AI info

WeepinbellLv28Card:
	db TYPE_PKMN_GRASS ; type
	dw $11aa ; gfx
	tx WeepinbellName ; name
	db DIAMOND ; rarity
	db LEGENDARY_POWER ; set
	db 2 ; ?
	dw WEEPINBELL_LV28
	db 70 ; hp
	db STAGE1 ; stage
	tx BellsproutName ; pre-evo name

	; attack 1
	energy GRASS, 1 ; energies
	tx Text1313 ; name
	tx Text1344 ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_NORMAL ; category
	dw $4023 ; effect commands
	db INFLICT_POISON  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_POWDER_EFFECT_CHANCE ; animation

	; attack 2
	energy GRASS, 2 ; energies
	tx Text1306 ; name
	dw NONE ; description
	dw NONE ; description (cont)
	db 30 ; damage
	db DAMAGE_NORMAL ; category
	dw NONE ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_242 ; animation

	db 1 ; retreat cost
	db WR_FIRE ; weakness
	db NONE ; resistance
	tx Text13f8 ; category
	db DEX_WEEPINBELL ; Pokedex number
	db FALSE ; is Dark
	db 28 ; level
	length 1.0 ; length
	weight 6.4 ; weight
	tx WeepinbellDescription2 ; description
	db NONE | HAS_EVOLUTION ; AI info

VictreebelCard:
	db TYPE_PKMN_GRASS ; type
	dw $1213 ; gfx
	tx VictreebelName ; name
	db STAR ; rarity
	db LEGENDARY_POWER ; set
	db 2 ; ?
	dw VICTREEBEL
	db 80 ; hp
	db STAGE2 ; stage
	tx WeepinbellName ; pre-evo name

	; attack 1
	energy GRASS, 1 ; energies
	tx Text13fc ; name
	tx Text13fd ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db RESIDUAL ; category
	dw $402b ; effect commands
	db NONE ; flags 1
	db SWITCH_OPPONENT_POKEMON  ; flags 2
	db FLAG_3_BIT_2  ; flags 3
	db 0 ; ?
	db ATK_ANIM_LURE ; animation

	; attack 2
	energy GRASS, 2 ; energies
	tx Text13fe ; name
	tx Text13ff ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_NORMAL ; category
	dw $4039 ; effect commands
	db NONE ; flags 1
	db FLAG_2_BIT_6  ; flags 2
	db NONE ; flags 3
	db 1 ; ?
	db ATK_ANIM_GOO ; animation

	db 2 ; retreat cost
	db WR_FIRE ; weakness
	db NONE ; resistance
	tx Text13f8 ; category
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
	db PSYCHIC_BATTLE ; set
	db 5 ; ?
	dw GRIMER_LV10
	db 40 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy GRASS, 1 ; energies
	tx Text1402 ; name
	tx Text130f ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db DAMAGE_NORMAL ; category
	dw $49ff ; effect commands
	db INFLICT_POISON  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_191 ; animation

	; attack 2
	energy GRASS, 2 ; energies
	tx Text1403 ; name
	tx Text1404 ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_PLUS ; category
	dw $4a07 ; effect commands
	db INFLICT_PARALYSIS  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_64 ; animation

	db 1 ; retreat cost
	db WR_PSYCHIC ; weakness
	db NONE ; resistance
	tx Text1405 ; category
	db DEX_GRIMER ; Pokedex number
	db FALSE ; is Dark
	db 10 ; level
	length 0.9 ; length
	weight 30.0 ; weight
	tx GrimerDescription1 ; description
	db NONE | HAS_EVOLUTION ; AI info

GrimerLv17Card:
	db TYPE_PKMN_GRASS ; type
	dw $127c ; gfx
	tx GrimerName ; name
	db CIRCLE ; rarity
	db ISLAND_OF_FOSSIL ; set
	db 2 ; ?
	dw GRIMER_LV17
	db 50 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy COLORLESS, 1 ; energies
	tx Text1407 ; name
	tx Text132f ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_NORMAL ; category
	dw $416b ; effect commands
	db INFLICT_PARALYSIS  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_GOO ; animation

	; attack 2
	energy GRASS, 1 ; energies
	tx Text1408 ; name
	tx Text1409 ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db RESIDUAL ; category
	dw $4170 ; effect commands
	db NONE ; flags 1
	db NULLIFY_OR_WEAKEN_ATTACK  ; flags 2
	db FLAG_3_BIT_2  ; flags 3
	db 0 ; ?
	db ATK_ANIM_PROTECT ; animation

	db 1 ; retreat cost
	db WR_PSYCHIC ; weakness
	db NONE ; resistance
	tx Text1405 ; category
	db DEX_GRIMER ; Pokedex number
	db FALSE ; is Dark
	db 17 ; level
	length 0.9 ; length
	weight 30.0 ; weight
	tx GrimerDescription2 ; description
	db AI_INFO_UNK_03 | HAS_EVOLUTION ; AI info

MukCard:
	db TYPE_PKMN_GRASS ; type
	dw $12e5 ; gfx
	tx MukName ; name
	db STAR ; rarity
	db ISLAND_OF_FOSSIL ; set
	db 2 ; ?
	dw MUK
	db 70 ; hp
	db STAGE1 ; stage
	tx GrimerName ; pre-evo name

	; attack 1
	energy 0 ; energies
	tx Text140c ; name
	tx Text140d ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db POKEMON_POWER ; category
	dw $4175 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_PKMN_POWER_1 ; animation

	; attack 2
	energy GRASS, 3 ; energies
	tx Text140e ; name
	tx Text1344 ; description
	dw NONE ; description (cont)
	db 30 ; damage
	db DAMAGE_NORMAL ; category
	dw $417a ; effect commands
	db INFLICT_POISON  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_GOO ; animation

	db 2 ; retreat cost
	db WR_PSYCHIC ; weakness
	db NONE ; resistance
	tx Text1405 ; category
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
	db PSYCHIC_BATTLE ; set
	db 5 ; ?
	dw DARK_MUK
	db 60 ; hp
	db STAGE1 ; stage
	tx GrimerName ; pre-evo name

	; attack 1
	energy 0 ; energies
	tx Text1411 ; name
	tx Text1412 ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db POKEMON_POWER ; category
	dw $4a0f ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_NONE ; animation

	; attack 2
	energy GRASS, 2 ; energies
	tx Text1413 ; name
	tx Text130f ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_NORMAL ; category
	dw $4a14 ; effect commands
	db INFLICT_POISON  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_178 ; animation

	db 2 ; retreat cost
	db WR_PSYCHIC ; weakness
	db NONE ; resistance
	tx Text1405 ; category
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
	db LEGENDARY_POWER ; set
	db 1 ; ?
	dw EXEGGCUTE
	db 50 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy PSYCHIC, 1 ; energies
	tx Text1416 ; name
	tx Text13b6 ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db DAMAGE_NORMAL ; category
	dw $4090 ; effect commands
	db INFLICT_SLEEP  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_HYPNOSIS ; animation

	; attack 2
	energy GRASS, 2 ; energies
	tx Text1315 ; name
	tx Text130a ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_NORMAL ; category
	dw $4095 ; effect commands
	db NONE ; flags 1
	db HEAL_USER  ; flags 2
	db NONE ; flags 3
	db 1 ; ?
	db ATK_ANIM_DRAIN ; animation

	db 1 ; retreat cost
	db WR_FIRE ; weakness
	db NONE ; resistance
	tx Text1417 ; category
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
	db LEGENDARY_POWER ; set
	db 1 ; ?
	dw EXEGGUTOR
	db 80 ; hp
	db STAGE1 ; stage
	tx ExeggcuteName ; pre-evo name

	; attack 1
	energy PSYCHIC, 1 ; energies
	tx Text141a ; name
	tx Text141b ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db RESIDUAL ; category
	dw $40bf ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db SPECIAL_AI_HANDLING | FLAG_3_BIT_2  ; flags 3
	db 0 ; ?
	db ATK_ANIM_210 ; animation

	; attack 2
	energy COLORLESS, 1 ; energies
	tx Text141c ; name
	tx Text141d ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_X ; category
	dw $40cd ; effect commands
	db NONE ; flags 1
	db ATTACHED_ENERGY_BOOST  ; flags 2
	db NONE ; flags 3
	db 3 ; ?
	db ATK_ANIM_BIG_HIT ; animation

	db 3 ; retreat cost
	db WR_FIRE ; weakness
	db NONE ; resistance
	tx Text141e ; category
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
	db PSYCHIC_BATTLE ; set
	db 6 ; ?
	dw KOFFING_LV12
	db 40 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy COLORLESS, 1 ; energies
	tx Text1305 ; name
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
	tx Text1402 ; name
	tx Text135b ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_NORMAL ; category
	dw $4a1c ; effect commands
	db INFLICT_POISON  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_51 ; animation

	db 1 ; retreat cost
	db WR_PSYCHIC ; weakness
	db NONE ; resistance
	tx Text1402 ; category
	db DEX_KOFFING ; Pokedex number
	db FALSE ; is Dark
	db 12 ; level
	length 0.6 ; length
	weight 1.0 ; weight
	tx KoffingDescription1 ; description
	db NONE | HAS_EVOLUTION ; AI info

KoffingLv13Card:
	db TYPE_PKMN_GRASS ; type
	dw $143e ; gfx
	tx KoffingName ; name
	db CIRCLE ; rarity
	db BEGINNING_POKEMON ; set
	db 3 ; ?
	dw KOFFING_LV13
	db 50 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy GRASS, 2 ; energies
	tx Text1422 ; name
	tx Text1423 ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_NORMAL ; category
	dw $409a ; effect commands
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
	tx Text1402 ; category
	db DEX_KOFFING ; Pokedex number
	db FALSE ; is Dark
	db 13 ; level
	length 0.6 ; length
	weight 1.0 ; weight
	tx KoffingDescription2 ; description
	db NONE | HAS_EVOLUTION ; AI info

KoffingLv14Card:
	db TYPE_PKMN_GRASS ; type
	dw $c069 ; gfx
	tx KoffingName ; name
	db CIRCLE ; rarity
	db TEAM_ROCKETS_AMBITION ; set
	db 2 ; ?
	dw KOFFING_LV14
	db 50 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy GRASS, 1 ; energies
	tx Text1402 ; name
	tx Text135b ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_NORMAL ; category
	dw $526c ; effect commands
	db INFLICT_POISON  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_51 ; animation

	; attack 2
	energy GRASS, 2 ; energies
	tx Text1425 ; name
	tx Text1336 ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_NORMAL ; category
	dw $5274 ; effect commands
	db INFLICT_CONFUSION  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_FOUL_GAS ; animation

	db 1 ; retreat cost
	db WR_PSYCHIC ; weakness
	db NONE ; resistance
	tx Text1402 ; category
	db DEX_KOFFING ; Pokedex number
	db FALSE ; is Dark
	db 14 ; level
	length 0.6 ; length
	weight 1.0 ; weight
	tx KoffingDescription3 ; description
	db NONE | HAS_EVOLUTION ; AI info

WeezingLv26Card:
	db TYPE_PKMN_GRASS ; type
	dw $98d2 ; gfx
	tx WeezingName ; name
	db STAR ; rarity
	db SKY_FLYING_POKEMON ; set
	db 4 ; ?
	dw WEEZING_LV26
	db 60 ; hp
	db STAGE1 ; stage
	tx KoffingName ; pre-evo name

	; attack 1
	energy 0 ; energies
	tx Text1428 ; name
	tx Text1429 ; description
	tx Text142a ; description (cont)
	db 0 ; damage
	db POKEMON_POWER ; category
	dw $50da ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_GLOW_EFFECT ; animation

	; attack 2
	energy GRASS, 3 ; energies
	tx Text142b ; name
	tx Text142c ; description
	dw NONE ; description (cont)
	db 40 ; damage
	db DAMAGE_NORMAL ; category
	dw $50e2 ; effect commands
	db LOW_RECOIL  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 30 ; ?
	db ATK_ANIM_195 ; animation

	db 2 ; retreat cost
	db WR_PSYCHIC ; weakness
	db NONE ; resistance
	tx Text1402 ; category
	db DEX_WEEZING ; Pokedex number
	db FALSE ; is Dark
	db 26 ; level
	length 1.2 ; length
	weight 9.5 ; weight
	tx WeezingDescription1 ; description
	db NONE ; AI info

WeezingLv27Card:
	db TYPE_PKMN_GRASS ; type
	dw $14a7 ; gfx
	tx WeezingName ; name
	db DIAMOND ; rarity
	db ISLAND_OF_FOSSIL ; set
	db 2 ; ?
	dw WEEZING_LV27
	db 60 ; hp
	db STAGE1 ; stage
	tx KoffingName ; pre-evo name

	; attack 1
	energy GRASS, 2 ; energies
	tx Text142e ; name
	tx Text1344 ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_NORMAL ; category
	dw $4190 ; effect commands
	db INFLICT_POISON  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_SMOG ; animation

	; attack 2
	energy GRASS, 2, COLORLESS, 1 ; energies
	tx Text142f ; name
	tx Text1430 ; description
	dw NONE ; description (cont)
	db 60 ; damage
	db DAMAGE_NORMAL ; category
	dw $4198 ; effect commands
	db HIGH_RECOIL  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 60 ; ?
	db ATK_ANIM_SELFDESTRUCT ; animation

	db 1 ; retreat cost
	db WR_PSYCHIC ; weakness
	db NONE ; resistance
	tx Text1402 ; category
	db DEX_WEEZING ; Pokedex number
	db FALSE ; is Dark
	db 27 ; level
	length 1.2 ; length
	weight 9.5 ; weight
	tx WeezingDescription2 ; description
	db NONE ; AI info

DarkWeezingCard:
	db TYPE_PKMN_GRASS ; type
	dw $6432 ; gfx
	tx DarkWeezingName ; name
	db STAR ; rarity
	db PSYCHIC_BATTLE ; set
	db 6 ; ?
	dw DARK_WEEZING
	db 60 ; hp
	db STAGE1 ; stage
	tx KoffingName ; pre-evo name

	; attack 1
	energy GRASS, 1, COLORLESS, 1 ; energies
	tx Text1433 ; name
	tx Text1434 ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_X ; category
	dw $4a24 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db SPECIAL_AI_HANDLING  ; flags 3
	db 0 ; ?
	db ATK_ANIM_194 ; animation

	; attack 2
	energy GRASS, 3 ; energies
	tx Text1435 ; name
	tx Text1436 ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_NORMAL ; category
	dw $4a2f ; effect commands
	db INFLICT_POISON | INFLICT_PARALYSIS  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_51 ; animation

	db 1 ; retreat cost
	db WR_PSYCHIC ; weakness
	db NONE ; resistance
	tx Text1402 ; category
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
	db BEGINNING_POKEMON ; set
	db 0 ; ?
	dw TANGELA_LV8
	db 50 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy GRASS, 1, COLORLESS, 1 ; energies
	tx Text1439 ; name
	tx Text132f ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_NORMAL ; category
	dw $41b0 ; effect commands
	db INFLICT_PARALYSIS  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_HIT ; animation

	; attack 2
	energy GRASS, 3 ; energies
	tx Text1313 ; name
	tx Text130f ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_NORMAL ; category
	dw $41b5 ; effect commands
	db INFLICT_POISON  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_POWDER_HIT_POISON ; animation

	db 2 ; retreat cost
	db WR_FIRE ; weakness
	db NONE ; resistance
	tx Text143a ; category
	db DEX_TANGELA ; Pokedex number
	db FALSE ; is Dark
	db 8 ; level
	length 1.0 ; length
	weight 35.0 ; weight
	tx TangelaDescription1 ; description
	db NONE ; AI info

TangelaLv12Card:
	db TYPE_PKMN_GRASS ; type
	dw $1593 ; gfx
	tx TangelaName ; name
	db DIAMOND ; rarity
	db GB ; set
	db 3 ; ?
	dw TANGELA_LV12
	db 50 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy GRASS, 1 ; energies
	tx Text133b ; name
	tx Text132f ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_NORMAL ; category
	dw $41cd ; effect commands
	db INFLICT_PARALYSIS  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_POWDER_EFFECT_CHANCE ; animation

	; attack 2
	energy GRASS, 2, COLORLESS, 1 ; energies
	tx Text143c ; name
	tx Text130f ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_NORMAL ; category
	dw $41d2 ; effect commands
	db INFLICT_POISON  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_POISON_WHIP ; animation

	db 2 ; retreat cost
	db WR_FIRE ; weakness
	db NONE ; resistance
	tx Text143a ; category
	db DEX_TANGELA ; Pokedex number
	db FALSE ; is Dark
	db 12 ; level
	length 1.0 ; length
	weight 35.0 ; weight
	tx TangelaDescription2 ; description
	db NONE ; AI info

ScytherLv23Card:
	db TYPE_PKMN_GRASS ; type
	dw $9ba2 ; gfx
	tx ScytherName ; name
	db STAR ; rarity
	db SKY_FLYING_POKEMON ; set
	db 1 ; ?
	dw SCYTHER_LV23
	db 60 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy GRASS, 2 ; energies
	tx Text143f ; name
	tx Text1440 ; description
	dw NONE ; description (cont)
	db 40 ; damage
	db DAMAGE_NORMAL ; category
	dw $511c ; effect commands
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
	tx Text1441 ; category
	db DEX_SCYTHER ; Pokedex number
	db FALSE ; is Dark
	db 23 ; level
	length 1.5 ; length
	weight 56.0 ; weight
	tx ScytherDescription1 ; description
	db NONE ; AI info

ScytherLv25Card:
	db TYPE_PKMN_GRASS ; type
	dw $15fc ; gfx
	tx ScytherName ; name
	db STAR ; rarity
	db LEGENDARY_POWER ; set
	db 5 ; ?
	dw SCYTHER_LV25
	db 70 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy GRASS, 1 ; energies
	tx Text1443 ; name
	tx Text1444 ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db RESIDUAL ; category
	dw $4071 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db SPECIAL_AI_HANDLING | FLAG_3_BIT_2  ; flags 3
	db 0 ; ?
	db ATK_ANIM_GLOW_EFFECT ; animation

	; attack 2
	energy COLORLESS, 3 ; energies
	tx Text13d6 ; name
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
	tx Text1441 ; category
	db DEX_SCYTHER ; Pokedex number
	db FALSE ; is Dark
	db 25 ; level
	length 1.5 ; length
	weight 56.0 ; weight
	tx ScytherDescription2 ; description
	db NONE ; AI info

PinsirLv15Card:
	db TYPE_PKMN_GRASS ; type
	dw $7ecf ; gfx
	tx PinsirName ; name
	db DIAMOND ; rarity
	db SKY_FLYING_POKEMON ; set
	db 6 ; ?
	dw PINSIR_LV15
	db 50 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy GRASS, 1 ; energies
	tx Text1447 ; name
	tx Text1448 ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_PLUS ; category
	dw $4d3d ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_HIT ; animation

	; attack 2
	energy COLORLESS, 3 ; energies
	tx Text13d6 ; name
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
	tx Text1449 ; category
	db DEX_PINSIR ; Pokedex number
	db FALSE ; is Dark
	db 15 ; level
	length 1.5 ; length
	weight 55.0 ; weight
	tx PinsirDescription1 ; description
	db NONE ; AI info

PinsirLv24Card:
	db TYPE_PKMN_GRASS ; type
	dw $1665 ; gfx
	tx PinsirName ; name
	db STAR ; rarity
	db LEGENDARY_POWER ; set
	db 2 ; ?
	dw PINSIR_LV24
	db 60 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy GRASS, 2 ; energies
	tx Text144b ; name
	tx Text132f ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_NORMAL ; category
	dw $403e ; effect commands
	db INFLICT_PARALYSIS  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_HIT_EFFECT ; animation

	; attack 2
	energy GRASS, 2, COLORLESS, 2 ; energies
	tx Text144c ; name
	dw NONE ; description
	dw NONE ; description (cont)
	db 50 ; damage
	db DAMAGE_NORMAL ; category
	dw NONE ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_243 ; animation

	db 1 ; retreat cost
	db WR_FIRE ; weakness
	db NONE ; resistance
	tx Text1449 ; category
	db DEX_PINSIR ; Pokedex number
	db FALSE ; is Dark
	db 24 ; level
	length 1.5 ; length
	weight 55.0 ; weight
	tx PinsirDescription2 ; description
	db NONE ; AI info

CharmanderLv9Card:
	db TYPE_PKMN_FIRE ; type
	dw $59aa ; gfx
	tx CharmanderName ; name
	db CIRCLE ; rarity
	db PSYCHIC_BATTLE ; set
	db 5 ; ?
	dw CHARMANDER_LV9
	db 40 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy 0 ; energies
	tx Text144f ; name
	tx Text1450 ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db POKEMON_POWER ; category
	dw $48d8 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_GLOW_EFFECT ; animation

	; attack 2
	energy FIRE, 1 ; energies
	tx Text1451 ; name
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
	tx Text1452 ; category
	db DEX_CHARMANDER ; Pokedex number
	db FALSE ; is Dark
	db 9 ; level
	length 0.6 ; length
	weight 8.5 ; weight
	tx CharmanderDescription1 ; description
	db NONE | HAS_EVOLUTION ; AI info

CharmanderLv10Card:
	db TYPE_PKMN_FIRE ; type
	dw $16ce ; gfx
	tx CharmanderName ; name
	db CIRCLE ; rarity
	db BEGINNING_POKEMON ; set
	db 0 ; ?
	dw CHARMANDER_LV10
	db 50 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy COLORLESS, 1 ; energies
	tx Text13ce ; name
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
	tx Text1454 ; name
	tx Text1455 ; description
	dw NONE ; description (cont)
	db 30 ; damage
	db DAMAGE_NORMAL ; category
	dw $4397 ; effect commands
	db NONE ; flags 1
	db DISCARD_ENERGY  ; flags 2
	db NONE ; flags 3
	db 3 ; ?
	db ATK_ANIM_SMALL_FLAME ; animation

	db 1 ; retreat cost
	db WR_WATER ; weakness
	db NONE ; resistance
	tx Text1452 ; category
	db DEX_CHARMANDER ; Pokedex number
	db FALSE ; is Dark
	db 10 ; level
	length 0.6 ; length
	weight 8.5 ; weight
	tx CharmanderDescription2 ; description
	db AI_INFO_UNK_05 | HAS_EVOLUTION ; AI info

CharmanderLv12Card:
	db TYPE_PKMN_FIRE ; type
	dw $71a6 ; gfx
	tx CharmanderName ; name
	db DIAMOND ; rarity
	db SKY_FLYING_POKEMON ; set
	db 3 ; ?
	dw CHARMANDER_LV12
	db 50 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy COLORLESS, 1 ; energies
	tx Text1457 ; name
	tx Text1458 ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db DAMAGE_NORMAL ; category
	dw $4c21 ; effect commands
	db NONE ; flags 1
	db NULLIFY_OR_WEAKEN_ATTACK  ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_SUPERSONIC ; animation

	; attack 2
	energy FIRE, 2 ; energies
	tx Text1451 ; name
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
	tx Text1452 ; category
	db DEX_CHARMANDER ; Pokedex number
	db FALSE ; is Dark
	db 12 ; level
	length 0.6 ; length
	weight 8.5 ; weight
	tx CharmanderDescription3 ; description
	db NONE | HAS_EVOLUTION ; AI info

CharmeleonCard:
	db TYPE_PKMN_FIRE ; type
	dw $173d ; gfx
	tx CharmeleonName ; name
	db DIAMOND ; rarity
	db BEGINNING_POKEMON ; set
	db 0 ; ?
	dw CHARMELEON
	db 80 ; hp
	db STAGE1 ; stage
	tx CharmanderName ; pre-evo name

	; attack 1
	energy COLORLESS, 3 ; energies
	tx Text13d6 ; name
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
	tx Text145b ; name
	tx Text1455 ; description
	dw NONE ; description (cont)
	db 50 ; damage
	db DAMAGE_NORMAL ; category
	dw $43ef ; effect commands
	db NONE ; flags 1
	db DISCARD_ENERGY  ; flags 2
	db NONE ; flags 3
	db 3 ; ?
	db ATK_ANIM_BIG_FLAME ; animation

	db 1 ; retreat cost
	db WR_WATER ; weakness
	db NONE ; resistance
	tx Text145c ; category
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
	db PSYCHIC_BATTLE ; set
	db 5 ; ?
	dw DARK_CHARMELEON
	db 50 ; hp
	db STAGE1 ; stage
	tx CharmanderName ; pre-evo name

	; attack 1
	energy COLORLESS, 2 ; energies
	tx Text145f ; name
	dw NONE ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_NORMAL ; category
	dw NONE ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_200 ; animation

	; attack 2
	energy FIRE, 3 ; energies
	tx Text1460 ; name
	tx Text1461 ; description
	dw NONE ; description (cont)
	db 70 ; damage
	db DAMAGE_NORMAL ; category
	dw $48e3 ; effect commands
	db NONE ; flags 1
	db DISCARD_ENERGY  ; flags 2
	db NONE ; flags 3
	db 3 ; ?
	db ATK_ANIM_158 ; animation

	db 2 ; retreat cost
	db WR_WATER ; weakness
	db NONE ; resistance
	tx Text145c ; category
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
	db BEGINNING_POKEMON ; set
	db 0 ; ?
	dw CHARIZARD_LV76
	db 120 ; hp
	db STAGE2 ; stage
	tx CharmeleonName ; pre-evo name

	; attack 1
	energy 0 ; energies
	tx Text1464 ; name
	tx Text1465 ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db POKEMON_POWER ; category
	dw $43fd ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_PKMN_POWER_1 ; animation

	; attack 2
	energy FIRE, 4 ; energies
	tx Text1466 ; name
	tx Text1467 ; description
	dw NONE ; description (cont)
	db 100 ; damage
	db DAMAGE_NORMAL ; category
	dw $4402 ; effect commands
	db NONE ; flags 1
	db DISCARD_ENERGY  ; flags 2
	db NONE ; flags 3
	db 6 ; ?
	db ATK_ANIM_FIRE_SPIN ; animation

	db 3 ; retreat cost
	db WR_WATER ; weakness
	db WR_FIGHTING ; resistance
	tx Text145c ; category
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
	db PRO ; set
	db 7 ; ?
	dw CHARIZARD_ALT_LV76
	db 120 ; hp
	db STAGE2 ; stage
	tx CharmeleonName ; pre-evo name

	; attack 1
	energy 0 ; energies
	tx Text1464 ; name
	tx Text1465 ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db POKEMON_POWER ; category
	dw $4410 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_PKMN_POWER_1 ; animation

	; attack 2
	energy FIRE, 4 ; energies
	tx Text1466 ; name
	tx Text1467 ; description
	dw NONE ; description (cont)
	db 100 ; damage
	db DAMAGE_NORMAL ; category
	dw $4415 ; effect commands
	db NONE ; flags 1
	db DISCARD_ENERGY  ; flags 2
	db NONE ; flags 3
	db 6 ; ?
	db ATK_ANIM_FIRE_SPIN ; animation

	db 3 ; retreat cost
	db WR_WATER ; weakness
	db WR_FIGHTING ; resistance
	tx Text145c ; category
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
	db PSYCHIC_BATTLE ; set
	db 5 ; ?
	dw DARK_CHARIZARD
	db 80 ; hp
	db STAGE2 ; stage
	tx DarkCharmeleonName ; pre-evo name

	; attack 1
	energy COLORLESS, 1 ; energies
	tx Text146b ; name
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
	tx Text146c ; name
	tx Text146d ; description
	dw NONE ; description (cont)
	db 50 ; damage
	db DAMAGE_X ; category
	dw $48f4 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db SPECIAL_AI_HANDLING  ; flags 3
	db 0 ; ?
	db ATK_ANIM_159 ; animation

	db 3 ; retreat cost
	db WR_WATER ; weakness
	db WR_FIGHTING ; resistance
	tx Text145c ; category
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
	db BEGINNING_POKEMON ; set
	db 0 ; ?
	dw VULPIX_LV11
	db 50 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy FIRE, 2 ; energies
	tx Text1470 ; name
	tx Text1336 ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_NORMAL ; category
	dw $4423 ; effect commands
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
	tx Text1471 ; category
	db DEX_VULPIX ; Pokedex number
	db FALSE ; is Dark
	db 11 ; level
	length 0.6 ; length
	weight 9.9 ; weight
	tx VulpixDescription1 ; description
	db AI_INFO_ENCOURAGE_EVO | HAS_EVOLUTION ; AI info

VulpixLv13Card:
	db TYPE_PKMN_FIRE ; type
	dw $8f59 ; gfx
	tx VulpixName ; name
	db CIRCLE ; rarity
	db SKY_FLYING_POKEMON ; set
	db 3 ; ?
	dw VULPIX_LV13
	db 50 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy FIRE, 2 ; energies
	tx Text1473 ; name
	tx Text1474 ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_NORMAL ; category
	dw $4f79 ; effect commands
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
	tx Text1471 ; category
	db DEX_VULPIX ; Pokedex number
	db FALSE ; is Dark
	db 13 ; level
	length 0.6 ; length
	weight 9.9 ; weight
	tx VulpixDescription2 ; description
	db NONE | HAS_EVOLUTION ; AI info

NinetalesLv32Card:
	db TYPE_PKMN_FIRE ; type
	dw $18d2 ; gfx
	tx NinetalesName ; name
	db STAR ; rarity
	db BEGINNING_POKEMON ; set
	db 0 ; ?
	dw NINETALES_LV32
	db 80 ; hp
	db STAGE1 ; stage
	tx VulpixName ; pre-evo name

	; attack 1
	energy COLORLESS, 2 ; energies
	tx Text1477 ; name
	tx Text13fd ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db RESIDUAL ; category
	dw $437b ; effect commands
	db NONE ; flags 1
	db SWITCH_OPPONENT_POKEMON  ; flags 2
	db FLAG_3_BIT_2  ; flags 3
	db 0 ; ?
	db ATK_ANIM_LURE ; animation

	; attack 2
	energy FIRE, 4 ; energies
	tx Text1478 ; name
	tx Text1455 ; description
	dw NONE ; description (cont)
	db 80 ; damage
	db DAMAGE_NORMAL ; category
	dw $4389 ; effect commands
	db NONE ; flags 1
	db DISCARD_ENERGY  ; flags 2
	db NONE ; flags 3
	db 3 ; ?
	db ATK_ANIM_FIRE_SPIN ; animation

	db 1 ; retreat cost
	db WR_WATER ; weakness
	db NONE ; resistance
	tx Text1471 ; category
	db DEX_NINETALES ; Pokedex number
	db FALSE ; is Dark
	db 32 ; level
	length 1.1 ; length
	weight 19.9 ; weight
	tx NinetalesDescription1 ; description
	db NONE ; AI info

NinetalesLv35Card:
	db TYPE_PKMN_FIRE ; type
	dw $193b ; gfx
	tx NinetalesName ; name
	db STAR ; rarity
	db GB ; set
	db 3 ; ?
	dw NINETALES_LV35
	db 80 ; hp
	db STAGE1 ; stage
	tx VulpixName ; pre-evo name

	; attack 1
	energy FIRE, 2 ; energies
	tx Text147a ; name
	tx Text147b ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db RESIDUAL ; category
	dw $4430 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db SPECIAL_AI_HANDLING | FLAG_3_BIT_2  ; flags 3
	db 0 ; ?
	db ATK_ANIM_GLOW_EFFECT ; animation

	; attack 2
	energy FIRE, 3 ; energies
	tx Text147c ; name
	tx Text147d ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_X ; category
	dw $4438 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_FIRE_SPIN ; animation

	db 1 ; retreat cost
	db WR_WATER ; weakness
	db NONE ; resistance
	tx Text1471 ; category
	db DEX_NINETALES ; Pokedex number
	db FALSE ; is Dark
	db 35 ; level
	length 1.1 ; length
	weight 19.9 ; weight
	tx NinetalesDescription2 ; description
	db NONE ; AI info

DarkNinetalesCard:
	db TYPE_PKMN_FIRE ; type
	dw $c8d2 ; gfx
	tx DarkNinetalesName ; name
	db STAR ; rarity
	db GB ; set
	db 6 ; ?
	dw DARK_NINETALES
	db 60 ; hp
	db STAGE1 ; stage
	tx VulpixName ; pre-evo name

	; attack 1
	energy FIRE, 1 ; energies
	tx Text1480 ; name
	tx Text1481 ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db RESIDUAL ; category
	dw $531a ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db SPECIAL_AI_HANDLING | FLAG_3_BIT_2  ; flags 3
	db 0 ; ?
	db ATK_ANIM_249 ; animation

	; attack 2
	energy FIRE, 2, COLORLESS, 1 ; energies
	tx Text1482 ; name
	tx Text1483 ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_X ; category
	dw $531f ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_250 ; animation

	db 0 ; retreat cost
	db WR_WATER ; weakness
	db NONE ; resistance
	tx Text1471 ; category
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
	db SQUIRTLE_DECK ; set
	db 0 ; ?
	dw GROWLITHE_LV12
	db 40 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy COLORLESS, 1 ; energies
	tx Text1486 ; name
	tx Text138c ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_NORMAL ; category
	dw $529b ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_HIT ; animation

	; attack 2
	energy FIRE, 1, COLORLESS, 1 ; energies
	tx Text1454 ; name
	tx Text1455 ; description
	dw NONE ; description (cont)
	db 30 ; damage
	db DAMAGE_NORMAL ; category
	dw $52a3 ; effect commands
	db NONE ; flags 1
	db DISCARD_ENERGY  ; flags 2
	db NONE ; flags 3
	db 3 ; ?
	db ATK_ANIM_SMALL_FLAME ; animation

	db 1 ; retreat cost
	db WR_WATER ; weakness
	db NONE ; resistance
	tx Text1487 ; category
	db DEX_GROWLITHE ; Pokedex number
	db FALSE ; is Dark
	db 12 ; level
	length 0.7 ; length
	weight 19.0 ; weight
	tx GrowlitheDescription1 ; description
	db NONE | HAS_EVOLUTION ; AI info

GrowlitheLv16Card:
	db TYPE_PKMN_FIRE ; type
	dw $90fa ; gfx
	tx GrowlitheName ; name
	db CIRCLE ; rarity
	db SKY_FLYING_POKEMON ; set
	db 6 ; ?
	dw GROWLITHE_LV16
	db 50 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy COLORLESS, 2 ; energies
	tx Text1489 ; name
	tx Text148a ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db RESIDUAL ; category
	dw $4f9f ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db SPECIAL_AI_HANDLING | FLAG_3_BIT_2  ; flags 3
	db 0 ; ?
	db ATK_ANIM_GLOW_EFFECT ; animation

	; attack 2
	energy FIRE, 1, COLORLESS, 1 ; energies
	tx Text1454 ; name
	tx Text148b ; description
	dw NONE ; description (cont)
	db 30 ; damage
	db DAMAGE_NORMAL ; category
	dw $4fb0 ; effect commands
	db NONE ; flags 1
	db DISCARD_ENERGY  ; flags 2
	db NONE ; flags 3
	db 3 ; ?
	db ATK_ANIM_BIG_FLAME ; animation

	db 1 ; retreat cost
	db WR_WATER ; weakness
	db NONE ; resistance
	tx Text1487 ; category
	db DEX_GROWLITHE ; Pokedex number
	db FALSE ; is Dark
	db 16 ; level
	length 0.7 ; length
	weight 19.0 ; weight
	tx GrowlitheDescription2 ; description
	db NONE | HAS_EVOLUTION ; AI info

GrowlitheLv18Card:
	db TYPE_PKMN_FIRE ; type
	dw $19ac ; gfx
	tx GrowlitheName ; name
	db DIAMOND ; rarity
	db BEGINNING_POKEMON ; set
	db 3 ; ?
	dw GROWLITHE_LV18
	db 60 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy FIRE, 1, COLORLESS, 1 ; energies
	tx Text148d ; name
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
	tx Text1487 ; category
	db DEX_GROWLITHE ; Pokedex number
	db FALSE ; is Dark
	db 18 ; level
	length 0.7 ; length
	weight 19.0 ; weight
	tx GrowlitheDescription3 ; description
	db NONE | HAS_EVOLUTION ; AI info

ArcanineLv34Card:
	db TYPE_PKMN_FIRE ; type
	dw $1a15 ; gfx
	tx ArcanineName ; name
	db PROMOSTAR ; rarity
	db PRO ; set
	db 7 ; ?
	dw ARCANINE_LV34
	db 70 ; hp
	db STAGE1 ; stage
	tx GrowlitheName ; pre-evo name

	; attack 1
	energy COLORLESS, 2 ; energies
	tx Text1490 ; name
	tx Text1491 ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_PLUS ; category
	dw $4352 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_QUICK_ATTACK ; animation

	; attack 2
	energy FIRE, 2 ; energies
	tx Text1492 ; name
	tx Text1493 ; description
	dw NONE ; description (cont)
	db 40 ; damage
	db DAMAGE_PLUS ; category
	dw $435a ; effect commands
	db NONE ; flags 1
	db DISCARD_ENERGY  ; flags 2
	db BOOST_IF_TAKEN_DAMAGE  ; flags 3
	db 6 ; ?
	db ATK_ANIM_FIRE_SPIN ; animation

	db 1 ; retreat cost
	db WR_WATER ; weakness
	db NONE ; resistance
	tx Text1494 ; category
	db DEX_ARCANINE ; Pokedex number
	db FALSE ; is Dark
	db 34 ; level
	length 1.9 ; length
	weight 155.0 ; weight
	tx ArcanineDescription1 ; description
	db NONE ; AI info

ArcanineLv35Card:
	db TYPE_PKMN_FIRE ; type
	dw $c1a4 ; gfx
	tx ArcanineName ; name
	db STAR ; rarity
	db SQUIRTLE_DECK ; set
	db 0 ; ?
	dw ARCANINE_LV35
	db 70 ; hp
	db STAGE1 ; stage
	tx GrowlitheName ; pre-evo name

	; attack 1
	energy FIRE, 2, COLORLESS, 1 ; energies
	tx Text1496 ; name
	tx Text1497 ; description
	dw NONE ; description (cont)
	db 50 ; damage
	db DAMAGE_NORMAL ; category
	dw $52b1 ; effect commands
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
	tx Text1494 ; category
	db DEX_ARCANINE ; Pokedex number
	db FALSE ; is Dark
	db 35 ; level
	length 1.9 ; length
	weight 155.0 ; weight
	tx ArcanineDescription2 ; description
	db NONE ; AI info

ArcanineLv45Card:
	db TYPE_PKMN_FIRE ; type
	dw $1a82 ; gfx
	tx ArcanineName ; name
	db STAR ; rarity
	db BEGINNING_POKEMON ; set
	db 1 ; ?
	dw ARCANINE_LV45
	db 100 ; hp
	db STAGE1 ; stage
	tx GrowlitheName ; pre-evo name

	; attack 1
	energy FIRE, 2, COLORLESS, 1 ; energies
	tx Text145b ; name
	tx Text1455 ; description
	dw NONE ; description (cont)
	db 50 ; damage
	db DAMAGE_NORMAL ; category
	dw $433f ; effect commands
	db NONE ; flags 1
	db DISCARD_ENERGY  ; flags 2
	db NONE ; flags 3
	db 3 ; ?
	db ATK_ANIM_BIG_FLAME ; animation

	; attack 2
	energy FIRE, 2, COLORLESS, 2 ; energies
	tx Text1496 ; name
	tx Text1499 ; description
	dw NONE ; description (cont)
	db 80 ; damage
	db DAMAGE_NORMAL ; category
	dw $434d ; effect commands
	db LOW_RECOIL  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 30 ; ?
	db ATK_ANIM_HIT_RECOIL ; animation

	db 3 ; retreat cost
	db WR_WATER ; weakness
	db NONE ; resistance
	tx Text1494 ; category
	db DEX_ARCANINE ; Pokedex number
	db FALSE ; is Dark
	db 45 ; level
	length 1.9 ; length
	weight 155.0 ; weight
	tx ArcanineDescription3 ; description
	db NONE ; AI info

PonytaLv8Card:
	db TYPE_PKMN_FIRE ; type
	dw $94af ; gfx
	tx PonytaName ; name
	db CIRCLE ; rarity
	db SKY_FLYING_POKEMON ; set
	db 4 ; ?
	dw PONYTA_LV8
	db 40 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy COLORLESS, 1 ; energies
	tx Text149c ; name
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
	tx Text149d ; name
	tx Text149e ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_NORMAL ; category
	dw $504f ; effect commands
	db NONE ; flags 1
	db DISCARD_ENERGY  ; flags 2
	db NONE ; flags 3
	db 2 ; ?
	db ATK_ANIM_SMALL_FLAME ; animation

	db 0 ; retreat cost
	db WR_WATER ; weakness
	db NONE ; resistance
	tx Text149f ; category
	db DEX_PONYTA ; Pokedex number
	db FALSE ; is Dark
	db 8 ; level
	length 1.0 ; length
	weight 30.0 ; weight
	tx PonytaDescription1 ; description
	db NONE | HAS_EVOLUTION ; AI info

PonytaLv10Card:
	db TYPE_PKMN_FIRE ; type
	dw $1aeb ; gfx
	tx PonytaName ; name
	db CIRCLE ; rarity
	db BEGINNING_POKEMON ; set
	db 0 ; ?
	dw PONYTA_LV10
	db 40 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy COLORLESS, 2 ; energies
	tx Text149c ; name
	dw NONE ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_NORMAL ; category
	dw NONE ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_182 ; animation

	; attack 2
	energy FIRE, 2 ; energies
	tx Text1451 ; name
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
	tx Text149f ; category
	db DEX_PONYTA ; Pokedex number
	db FALSE ; is Dark
	db 10 ; level
	length 1.0 ; length
	weight 30.0 ; weight
	tx PonytaDescription2 ; description
	db NONE | HAS_EVOLUTION ; AI info

PonytaLv15Card:
	db TYPE_PKMN_FIRE ; type
	dw $5ae5 ; gfx
	tx PonytaName ; name
	db CIRCLE ; rarity
	db PSYCHIC_BATTLE ; set
	db 5 ; ?
	dw PONYTA_LV15
	db 50 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy FIRE, 1, COLORLESS, 1 ; energies
	tx Text1454 ; name
	tx Text1455 ; description
	dw NONE ; description (cont)
	db 30 ; damage
	db DAMAGE_NORMAL ; category
	dw $4905 ; effect commands
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
	tx Text149f ; category
	db DEX_PONYTA ; Pokedex number
	db FALSE ; is Dark
	db 15 ; level
	length 1.0 ; length
	weight 30.0 ; weight
	tx PonytaDescription3 ; description
	db NONE | HAS_EVOLUTION ; AI info

RapidashLv30Card:
	db TYPE_PKMN_FIRE ; type
	dw $7bf9 ; gfx
	tx RapidashName ; name
	db DIAMOND ; rarity
	db SKY_FLYING_POKEMON ; set
	db 4 ; ?
	dw RAPIDASH_LV30
	db 60 ; hp
	db STAGE1 ; stage
	tx PonytaName ; pre-evo name

	; attack 1
	energy FIRE, 1 ; energies
	tx Text14a4 ; name
	tx Text14a5 ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_PLUS ; category
	dw $4cf0 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db SPECIAL_AI_HANDLING  ; flags 3
	db 0 ; ?
	db ATK_ANIM_FIRE_SPIN ; animation

	; attack 2
	energy COLORLESS, 2 ; energies
	tx Text14a6 ; name
	tx Text14a7 ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_NORMAL ; category
	dw $4cfe ; effect commands
	db NONE ; flags 1
	db SWITCH_OPPONENT_POKEMON  ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_HIT ; animation

	db 0 ; retreat cost
	db WR_WATER ; weakness
	db NONE ; resistance
	tx Text149f ; category
	db DEX_RAPIDASH ; Pokedex number
	db FALSE ; is Dark
	db 30 ; level
	length 1.7 ; length
	weight 95.0 ; weight
	tx RapidashDescription1 ; description
	db NONE ; AI info

RapidashLv33Card:
	db TYPE_PKMN_FIRE ; type
	dw $1b66 ; gfx
	tx RapidashName ; name
	db DIAMOND ; rarity
	db LEGENDARY_POWER ; set
	db 0 ; ?
	dw RAPIDASH_LV33
	db 70 ; hp
	db STAGE1 ; stage
	tx PonytaName ; pre-evo name

	; attack 1
	energy COLORLESS, 2 ; energies
	tx Text14a9 ; name
	tx Text14aa ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_PLUS ; category
	dw $436e ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_HIT ; animation

	; attack 2
	energy FIRE, 2, COLORLESS, 1 ; energies
	tx Text14ab ; name
	tx Text14ac ; description
	dw NONE ; description (cont)
	db 30 ; damage
	db DAMAGE_NORMAL ; category
	dw $4376 ; effect commands
	db NONE ; flags 1
	db NULLIFY_OR_WEAKEN_ATTACK | FLAG_2_BIT_6  ; flags 2
	db FLAG_3_BIT_2  ; flags 3
	db 0 ; ?
	db ATK_ANIM_QUICK_ATTACK ; animation

	db 0 ; retreat cost
	db WR_WATER ; weakness
	db NONE ; resistance
	tx Text149f ; category
	db DEX_RAPIDASH ; Pokedex number
	db FALSE ; is Dark
	db 33 ; level
	length 1.7 ; length
	weight 95.0 ; weight
	tx RapidashDescription2 ; description
	db NONE ; AI info

DarkRapidashCard:
	db TYPE_PKMN_FIRE ; type
	dw $5b4e ; gfx
	tx DarkRapidashName ; name
	db CIRCLE ; rarity
	db PSYCHIC_BATTLE ; set
	db 5 ; ?
	dw DARK_RAPIDASH
	db 60 ; hp
	db STAGE1 ; stage
	tx PonytaName ; pre-evo name

	; attack 1
	energy COLORLESS, 2 ; energies
	tx Text14af ; name
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
	tx Text14b0 ; name
	tx Text14b1 ; description
	dw NONE ; description (cont)
	db 30 ; damage
	db DAMAGE_NORMAL ; category
	dw $4913 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db SPECIAL_AI_HANDLING | FLAG_3_BIT_2  ; flags 3
	db 0 ; ?
	db ATK_ANIM_160 ; animation

	db 0 ; retreat cost
	db WR_WATER ; weakness
	db NONE ; resistance
	tx Text149f ; category
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
	db SQUIRTLE_DECK ; set
	db 1 ; ?
	dw MAGMAR_LV18
	db 50 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy FIRE, 1 ; energies
	tx Text14b4 ; name
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
	tx Text142e ; name
	tx Text135b ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_NORMAL ; category
	dw $52b6 ; effect commands
	db INFLICT_POISON  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_51 ; animation

	db 1 ; retreat cost
	db WR_WATER ; weakness
	db NONE ; resistance
	tx Text14b5 ; category
	db DEX_MAGMAR ; Pokedex number
	db FALSE ; is Dark
	db 18 ; level
	length 1.3 ; length
	weight 44.5 ; weight
	tx MagmarDescription1 ; description
	db NONE ; AI info

MagmarLv24Card:
	db TYPE_PKMN_FIRE ; type
	dw $1beb ; gfx
	tx MagmarName ; name
	db DIAMOND ; rarity
	db BEGINNING_POKEMON ; set
	db 2 ; ?
	dw MAGMAR_LV24
	db 50 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy FIRE, 2 ; energies
	tx Text14b4 ; name
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
	tx Text145b ; name
	tx Text1455 ; description
	dw NONE ; description (cont)
	db 50 ; damage
	db DAMAGE_NORMAL ; category
	dw $43d4 ; effect commands
	db NONE ; flags 1
	db DISCARD_ENERGY  ; flags 2
	db NONE ; flags 3
	db 3 ; ?
	db ATK_ANIM_BIG_FLAME ; animation

	db 2 ; retreat cost
	db WR_WATER ; weakness
	db NONE ; resistance
	tx Text14b5 ; category
	db DEX_MAGMAR ; Pokedex number
	db FALSE ; is Dark
	db 24 ; level
	length 1.3 ; length
	weight 44.5 ; weight
	tx MagmarDescription2 ; description
	db NONE ; AI info

MagmarLv27Card:
	db TYPE_PKMN_FIRE ; type
	dw $9c3d ; gfx
	tx MagmarName ; name
	db CIRCLE ; rarity
	db SKY_FLYING_POKEMON ; set
	db 4 ; ?
	dw MAGMAR_LV27
	db 60 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy FIRE, 1 ; energies
	tx Text14b8 ; name
	tx Text14b9 ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_PLUS ; category
	dw $5124 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db SPECIAL_AI_HANDLING  ; flags 3
	db 0 ; ?
	db ATK_ANIM_FIRE_SPIN ; animation

	; attack 2
	energy FIRE, 2, COLORLESS, 1 ; energies
	tx Text14ba ; name
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
	tx Text14b5 ; category
	db DEX_MAGMAR ; Pokedex number
	db FALSE ; is Dark
	db 27 ; level
	length 1.3 ; length
	weight 44.5 ; weight
	tx MagmarDescription3 ; description
	db NONE ; AI info

MagmarLv31Card:
	db TYPE_PKMN_FIRE ; type
	dw $1c54 ; gfx
	tx MagmarName ; name
	db DIAMOND ; rarity
	db ISLAND_OF_FOSSIL ; set
	db 5 ; ?
	dw MAGMAR_LV31
	db 70 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy FIRE, 1 ; energies
	tx Text14bc ; name
	tx Text14bd ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_NORMAL ; category
	dw $43e2 ; effect commands
	db NONE ; flags 1
	db NULLIFY_OR_WEAKEN_ATTACK  ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_DARK_GAS ; animation

	; attack 2
	energy FIRE, 2 ; energies
	tx Text142e ; name
	tx Text1344 ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_NORMAL ; category
	dw $43e7 ; effect commands
	db INFLICT_POISON  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_SMOG ; animation

	db 1 ; retreat cost
	db WR_WATER ; weakness
	db NONE ; resistance
	tx Text14b5 ; category
	db DEX_MAGMAR ; Pokedex number
	db FALSE ; is Dark
	db 31 ; level
	length 1.3 ; length
	weight 44.5 ; weight
	tx MagmarDescription4 ; description
	db AI_INFO_UNK_03 ; AI info

FlareonLv22Card:
	db TYPE_PKMN_FIRE ; type
	dw $1cbd ; gfx
	tx FlareonName ; name
	db DIAMOND ; rarity
	db GB ; set
	db 3 ; ?
	dw FLAREON_LV22
	db 60 ; hp
	db STAGE1 ; stage
	tx EeveeName ; pre-evo name

	; attack 1
	energy COLORLESS, 3 ; energies
	tx Text135a ; name
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
	tx Text14c1 ; name
	tx Text14c2 ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_PLUS ; category
	dw $4428 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db BOOST_IF_TAKEN_DAMAGE  ; flags 3
	db 0 ; ?
	db ATK_ANIM_HIT ; animation

	db 1 ; retreat cost
	db WR_WATER ; weakness
	db NONE ; resistance
	tx Text148d ; category
	db DEX_FLAREON ; Pokedex number
	db FALSE ; is Dark
	db 22 ; level
	length 0.9 ; length
	weight 25.0 ; weight
	tx FlareonDescription1 ; description
	db NONE ; AI info

FlareonLv28Card:
	db TYPE_PKMN_FIRE ; type
	dw $1d26 ; gfx
	tx FlareonName ; name
	db STAR ; rarity
	db LEGENDARY_POWER ; set
	db 1 ; ?
	dw FLAREON_LV28
	db 70 ; hp
	db STAGE1 ; stage
	tx EeveeName ; pre-evo name

	; attack 1
	energy COLORLESS, 2 ; energies
	tx Text1490 ; name
	tx Text1491 ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_PLUS ; category
	dw $43be ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_QUICK_ATTACK ; animation

	; attack 2
	energy FIRE, 2, COLORLESS, 2 ; energies
	tx Text145b ; name
	tx Text1455 ; description
	dw NONE ; description (cont)
	db 60 ; damage
	db DAMAGE_NORMAL ; category
	dw $43c6 ; effect commands
	db NONE ; flags 1
	db DISCARD_ENERGY  ; flags 2
	db NONE ; flags 3
	db 3 ; ?
	db ATK_ANIM_BIG_FLAME ; animation

	db 1 ; retreat cost
	db WR_WATER ; weakness
	db NONE ; resistance
	tx Text148d ; category
	db DEX_FLAREON ; Pokedex number
	db FALSE ; is Dark
	db 28 ; level
	length 0.9 ; length
	weight 25.0 ; weight
	tx FlareonDescription2 ; description
	db NONE ; AI info

DarkFlareonCard:
	db TYPE_PKMN_FIRE ; type
	dw $5bb7 ; gfx
	tx DarkFlareonName ; name
	db DIAMOND ; rarity
	db PSYCHIC_BATTLE ; set
	db 5 ; ?
	dw DARK_FLAREON
	db 50 ; hp
	db STAGE1 ; stage
	tx EeveeName ; pre-evo name

	; attack 1
	energy COLORLESS, 1 ; energies
	tx Text14c1 ; name
	tx Text14c2 ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_PLUS ; category
	dw $491e ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_HIT ; animation

	; attack 2
	energy FIRE, 2 ; energies
	tx Text14c6 ; name
	tx Text14c7 ; description
	dw NONE ; description (cont)
	db 30 ; damage
	db DAMAGE_PLUS ; category
	dw $4926 ; effect commands
	db NONE ; flags 1
	db DISCARD_ENERGY  ; flags 2
	db NONE ; flags 3
	db 2 ; ?
	db ATK_ANIM_BIG_FLAME ; animation

	db 1 ; retreat cost
	db WR_WATER ; weakness
	db NONE ; resistance
	tx Text148d ; category
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
	db ISLAND_OF_FOSSIL ; set
	db 1 ; ?
	dw MOLTRES_LV35
	db 70 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy FIRE, 1 ; energies
	tx Text14ca ; name
	tx Text14cb ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db RESIDUAL ; category
	dw $43a5 ; effect commands
	db NONE ; flags 1
	db FLAG_2_BIT_5  ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_GLOW_EFFECT ; animation

	; attack 2
	energy FIRE, 4 ; energies
	tx Text14cc ; name
	tx Text1387 ; description
	dw NONE ; description (cont)
	db 80 ; damage
	db DAMAGE_NORMAL ; category
	dw $43b6 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_NONE ; animation

	db 2 ; retreat cost
	db NONE ; weakness
	db WR_FIGHTING ; resistance
	tx Text145c ; category
	db DEX_MOLTRES ; Pokedex number
	db FALSE ; is Dark
	db 35 ; level
	length 2.0 ; length
	weight 60.0 ; weight
	tx MoltresDescription1 ; description
	db NONE ; AI info

MoltresLv37Card:
	db TYPE_PKMN_FIRE ; type
	dw $8cd3 ; gfx
	tx MoltresName ; name
	db STAR ; rarity
	db SKY_FLYING_POKEMON ; set
	db 6 ; ?
	dw MOLTRES_LV37
	db 80 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy FIRE, 2 ; energies
	tx Text14ce ; name
	tx Text14cf ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db RESIDUAL ; category
	dw $4f1d ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db SPECIAL_AI_HANDLING | FLAG_3_BIT_2  ; flags 3
	db 0 ; ?
	db ATK_ANIM_223 ; animation

	; attack 2
	energy FIRE, 3, COLORLESS, 1 ; energies
	tx Text14d0 ; name
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
	tx Text145c ; category
	db DEX_MOLTRES ; Pokedex number
	db FALSE ; is Dark
	db 37 ; level
	length 2.0 ; length
	weight 60.0 ; weight
	tx MoltresDescription2 ; description
	db NONE ; AI info

MoltresLv40Card:
	db TYPE_PKMN_FIRE ; type
	dw $1df8 ; gfx
	tx MoltresName ; name
	db STAR ; rarity
	db GB ; set
	db 7 ; ?
	dw MOLTRES_LV40
	db 100 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy 0 ; energies
	tx Text14d2 ; name
	tx Text14d3 ; description
	tx Text14d4 ; description (cont)
	db 0 ; damage
	db POKEMON_POWER ; category
	dw $4440 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_FIREGIVER ; animation

	; attack 2
	energy FIRE, 3 ; energies
	tx Text14cc ; name
	tx Text1387 ; description
	dw NONE ; description (cont)
	db 70 ; damage
	db DAMAGE_NORMAL ; category
	dw $4448 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_NONE ; animation

	db 2 ; retreat cost
	db NONE ; weakness
	db WR_FIGHTING ; resistance
	tx Text145c ; category
	db DEX_MOLTRES ; Pokedex number
	db FALSE ; is Dark
	db 40 ; level
	length 2.0 ; length
	weight 60.0 ; weight
	tx MoltresDescription2 ; description
	db NONE ; AI info

SquirtleLv8Card:
	db TYPE_PKMN_WATER ; type
	dw $1e61 ; gfx
	tx SquirtleName ; name
	db CIRCLE ; rarity
	db BEGINNING_POKEMON ; set
	db 2 ; ?
	dw SQUIRTLE_LV8
	db 40 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy WATER, 1 ; energies
	tx Text14d6 ; name
	tx Text132f ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_NORMAL ; category
	dw $42a8 ; effect commands
	db INFLICT_PARALYSIS  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_BUBBLES ; animation

	; attack 2
	energy WATER, 1, COLORLESS, 1 ; energies
	tx Text14d7 ; name
	tx Text133a ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db RESIDUAL ; category
	dw $42ad ; effect commands
	db NONE ; flags 1
	db NULLIFY_OR_WEAKEN_ATTACK  ; flags 2
	db FLAG_3_BIT_2  ; flags 3
	db 0 ; ?
	db ATK_ANIM_NONE ; animation

	db 1 ; retreat cost
	db WR_LIGHTNING ; weakness
	db NONE ; resistance
	tx Text14d8 ; category
	db DEX_SQUIRTLE ; Pokedex number
	db FALSE ; is Dark
	db 8 ; level
	length 0.5 ; length
	weight 9.0 ; weight
	tx SquirtleDescription1 ; description
	db AI_INFO_UNK_05 | HAS_EVOLUTION ; AI info

SquirtleLv14Card:
	db TYPE_PKMN_WATER ; type
	dw $be5c ; gfx
	tx SquirtleName ; name
	db CIRCLE ; rarity
	db SQUIRTLE_DECK ; set
	db 1 ; ?
	dw SQUIRTLE_LV14
	db 50 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy WATER, 1 ; energies
	tx Text135a ; name
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
	tx Text14da ; name
	dw NONE ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_NORMAL ; category
	dw NONE ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_241 ; animation

	db 1 ; retreat cost
	db WR_LIGHTNING ; weakness
	db NONE ; resistance
	tx Text14d8 ; category
	db DEX_SQUIRTLE ; Pokedex number
	db FALSE ; is Dark
	db 14 ; level
	length 0.5 ; length
	weight 9.0 ; weight
	tx SquirtleDescription2 ; description
	db NONE | HAS_EVOLUTION ; AI info

SquirtleLv15Card:
	db TYPE_PKMN_WATER ; type
	dw $720f ; gfx
	tx SquirtleName ; name
	db DIAMOND ; rarity
	db SKY_FLYING_POKEMON ; set
	db 4 ; ?
	dw SQUIRTLE_LV15
	db 50 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy WATER, 1 ; energies
	tx Text14dc ; name
	tx Text14dd ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db RESIDUAL ; category
	dw $4c26 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db SPECIAL_AI_HANDLING | FLAG_3_BIT_2  ; flags 3
	db 0 ; ?
	db ATK_ANIM_GLOW_EFFECT ; animation

	; attack 2
	energy COLORLESS, 1 ; energies
	tx Text14de ; name
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
	tx Text14d8 ; category
	db DEX_SQUIRTLE ; Pokedex number
	db FALSE ; is Dark
	db 15 ; level
	length 0.5 ; length
	weight 9.0 ; weight
	tx SquirtleDescription3 ; description
	db NONE | HAS_EVOLUTION ; AI info

SquirtleLv16Card:
	db TYPE_PKMN_WATER ; type
	dw $5c20 ; gfx
	tx SquirtleName ; name
	db CIRCLE ; rarity
	db PSYCHIC_BATTLE ; set
	db 5 ; ?
	dw SQUIRTLE_LV16
	db 50 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy COLORLESS, 2 ; energies
	tx Text14e0 ; name
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
	tx Text14d8 ; category
	db DEX_SQUIRTLE ; Pokedex number
	db FALSE ; is Dark
	db 16 ; level
	length 0.5 ; length
	weight 9.0 ; weight
	tx SquirtleDescription4 ; description
	db NONE | HAS_EVOLUTION ; AI info

WartortleLv22Card:
	db TYPE_PKMN_WATER ; type
	dw $1f28 ; gfx
	tx WartortleName ; name
	db DIAMOND ; rarity
	db BEGINNING_POKEMON ; set
	db 2 ; ?
	dw WARTORTLE_LV22
	db 70 ; hp
	db STAGE1 ; stage
	tx SquirtleName ; pre-evo name

	; attack 1
	energy WATER, 1, COLORLESS, 1 ; energies
	tx Text14d7 ; name
	tx Text133a ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db RESIDUAL ; category
	dw $4207 ; effect commands
	db NONE ; flags 1
	db NULLIFY_OR_WEAKEN_ATTACK  ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_NONE ; animation

	; attack 2
	energy WATER, 1, COLORLESS, 2 ; energies
	tx Text135a ; name
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
	tx Text14e3 ; category
	db DEX_WARTORTLE ; Pokedex number
	db FALSE ; is Dark
	db 22 ; level
	length 1.0 ; length
	weight 22.5 ; weight
	tx WartortleDescription1 ; description
	db AI_INFO_ENCOURAGE_EVO | HAS_EVOLUTION ; AI info

WartortleLv24Card:
	db TYPE_PKMN_WATER ; type
	dw $c276 ; gfx
	tx WartortleName ; name
	db DIAMOND ; rarity
	db SQUIRTLE_DECK ; set
	db 1 ; ?
	dw WARTORTLE_LV24
	db 70 ; hp
	db STAGE1 ; stage
	tx SquirtleName ; pre-evo name

	; attack 1
	energy WATER, 1 ; energies
	tx Text14d6 ; name
	tx Text1363 ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_NORMAL ; category
	dw $52be ; effect commands
	db INFLICT_PARALYSIS  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_66 ; animation

	; attack 2
	energy WATER, 2 ; energies
	tx Text14e5 ; name
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
	tx Text14e3 ; category
	db DEX_WARTORTLE ; Pokedex number
	db FALSE ; is Dark
	db 24 ; level
	length 1.0 ; length
	weight 22.5 ; weight
	tx WartortleDescription2 ; description
	db AI_INFO_ENCOURAGE_EVO | HAS_EVOLUTION ; AI info

DarkWartortleCard:
	db TYPE_PKMN_WATER ; type
	dw $5c97 ; gfx
	tx DarkWartortleName ; name
	db DIAMOND ; rarity
	db PSYCHIC_BATTLE ; set
	db 5 ; ?
	dw DARK_WARTORTLE
	db 60 ; hp
	db STAGE1 ; stage
	tx SquirtleName ; pre-evo name

	; attack 1
	energy WATER, 1 ; energies
	tx Text14e8 ; name
	tx Text14e9 ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_X ; category
	dw $4937 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_203 ; animation

	; attack 2
	energy WATER, 1, COLORLESS, 1 ; energies
	tx Text14ea ; name
	tx Text14eb ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db RESIDUAL ; category
	dw $493f ; effect commands
	db NONE ; flags 1
	db FLAG_2_BIT_6  ; flags 2
	db FLAG_3_BIT_2  ; flags 3
	db 0 ; ?
	db ATK_ANIM_GLOW_EFFECT ; animation

	db 1 ; retreat cost
	db WR_LIGHTNING ; weakness
	db NONE ; resistance
	tx Text14e3 ; category
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
	db BEGINNING_POKEMON ; set
	db 1 ; ?
	dw BLASTOISE_LV52
	db 100 ; hp
	db STAGE2 ; stage
	tx WartortleName ; pre-evo name

	; attack 1
	energy 0 ; energies
	tx Text14ee ; name
	tx Text14ef ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db POKEMON_POWER ; category
	dw $420c ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_PKMN_POWER_1 ; animation

	; attack 2
	energy WATER, 3 ; energies
	tx Text14f0 ; name
	tx Text14f1 ; description
	dw NONE ; description (cont)
	db 40 ; damage
	db DAMAGE_PLUS ; category
	dw $4211 ; effect commands
	db NONE ; flags 1
	db ATTACHED_ENERGY_BOOST  ; flags 2
	db NONE ; flags 3
	db 2 ; ?
	db ATK_ANIM_HYDRO_PUMP ; animation

	db 3 ; retreat cost
	db WR_LIGHTNING ; weakness
	db NONE ; resistance
	tx Text14f2 ; category
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
	db PRO ; set
	db 7 ; ?
	dw BLASTOISE_ALT_LV52
	db 100 ; hp
	db STAGE2 ; stage
	tx WartortleName ; pre-evo name

	; attack 1
	energy 0 ; energies
	tx Text14ee ; name
	tx Text14ef ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db POKEMON_POWER ; category
	dw $4219 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_PKMN_POWER_1 ; animation

	; attack 2
	energy WATER, 3 ; energies
	tx Text14f0 ; name
	tx Text14f1 ; description
	dw NONE ; description (cont)
	db 40 ; damage
	db DAMAGE_PLUS ; category
	dw $421e ; effect commands
	db NONE ; flags 1
	db ATTACHED_ENERGY_BOOST  ; flags 2
	db NONE ; flags 3
	db 2 ; ?
	db ATK_ANIM_HYDRO_PUMP ; animation

	db 3 ; retreat cost
	db WR_LIGHTNING ; weakness
	db NONE ; resistance
	tx Text14f2 ; category
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
	db PSYCHIC_BATTLE ; set
	db 5 ; ?
	dw DARK_BLASTOISE
	db 70 ; hp
	db STAGE2 ; stage
	tx DarkWartortleName ; pre-evo name

	; attack 1
	energy WATER, 2 ; energies
	tx Text14f6 ; name
	tx Text14f7 ; description
	dw NONE ; description (cont)
	db 30 ; damage
	db DAMAGE_PLUS ; category
	dw $4944 ; effect commands
	db NONE ; flags 1
	db ATTACHED_ENERGY_BOOST  ; flags 2
	db NONE ; flags 3
	db 2 ; ?
	db ATK_ANIM_HYDRO_PUMP ; animation

	; attack 2
	energy WATER, 1, COLORLESS, 2 ; energies
	tx Text14f8 ; name
	tx Text14f9 ; description
	dw NONE ; description (cont)
	db 40 ; damage
	db DAMAGE_NORMAL ; category
	dw $494c ; effect commands
	db LOW_RECOIL  ; flags 1
	db NULLIFY_OR_WEAKEN_ATTACK  ; flags 2
	db NONE ; flags 3
	db 10 ; ?
	db ATK_ANIM_205 ; animation

	db 2 ; retreat cost
	db WR_LIGHTNING ; weakness
	db NONE ; resistance
	tx Text14f2 ; category
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
	db ISLAND_OF_FOSSIL ; set
	db 2 ; ?
	dw PSYDUCK_LV15
	db 50 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy PSYCHIC, 1 ; energies
	tx Text14fc ; name
	tx Text14fd ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db RESIDUAL ; category
	dw $4249 ; effect commands
	db NONE ; flags 1
	db FLAG_2_BIT_6  ; flags 2
	db FLAG_3_BIT_2  ; flags 3
	db 2 ; ?
	db ATK_ANIM_GLOW_EFFECT ; animation

	; attack 2
	energy WATER, 1 ; energies
	tx Text1371 ; name
	tx Text1372 ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_X ; category
	dw $424e ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_MULTIPLE_SLASH ; animation

	db 1 ; retreat cost
	db WR_LIGHTNING ; weakness
	db NONE ; resistance
	tx Text14fe ; category
	db DEX_PSYDUCK ; Pokedex number
	db FALSE ; is Dark
	db 15 ; level
	length 0.8 ; length
	weight 19.6 ; weight
	tx PsyduckDescription1 ; description
	db AI_INFO_UNK_03 | HAS_EVOLUTION ; AI info

PsyduckLv16Card:
	db TYPE_PKMN_WATER ; type
	dw $5da5 ; gfx
	tx PsyduckName ; name
	db CIRCLE ; rarity
	db PSYCHIC_BATTLE ; set
	db 6 ; ?
	dw PSYDUCK_LV16
	db 50 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy PSYCHIC, 1 ; energies
	tx Text1500 ; name
	tx Text1501 ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db RESIDUAL ; category
	dw $4954 ; effect commands
	db DRAW_CARD  ; flags 1
	db NONE ; flags 2
	db SPECIAL_AI_HANDLING | FLAG_3_BIT_2  ; flags 3
	db 0 ; ?
	db ATK_ANIM_GLOW_EFFECT ; animation

	; attack 2
	energy WATER, 1, COLORLESS, 1 ; energies
	tx Text1502 ; name
	tx Text14f1 ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_PLUS ; category
	dw $495c ; effect commands
	db NONE ; flags 1
	db ATTACHED_ENERGY_BOOST  ; flags 2
	db NONE ; flags 3
	db 2 ; ?
	db ATK_ANIM_WATER_GUN ; animation

	db 1 ; retreat cost
	db WR_LIGHTNING ; weakness
	db NONE ; resistance
	tx Text14fe ; category
	db DEX_PSYDUCK ; Pokedex number
	db FALSE ; is Dark
	db 16 ; level
	length 0.8 ; length
	weight 19.6 ; weight
	tx PsyduckDescription2 ; description
	db NONE | HAS_EVOLUTION ; AI info

GolduckLv27Card:
	db TYPE_PKMN_WATER ; type
	dw $20f2 ; gfx
	tx GolduckName ; name
	db DIAMOND ; rarity
	db ISLAND_OF_FOSSIL ; set
	db 4 ; ?
	dw GOLDUCK_LV27
	db 70 ; hp
	db STAGE1 ; stage
	tx PsyduckName ; pre-evo name

	; attack 1
	energy PSYCHIC, 1 ; energies
	tx Text1505 ; name
	tx Text132f ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_NORMAL ; category
	dw $4256 ; effect commands
	db INFLICT_PARALYSIS  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_PSYCHIC_HIT ; animation

	; attack 2
	energy WATER, 2, COLORLESS, 1 ; energies
	tx Text1506 ; name
	tx Text1507 ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_NORMAL ; category
	dw $425b ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db SPECIAL_AI_HANDLING  ; flags 3
	db 0 ; ?
	db ATK_ANIM_HYPER_BEAM ; animation

	db 1 ; retreat cost
	db WR_LIGHTNING ; weakness
	db NONE ; resistance
	tx Text14fe ; category
	db DEX_GOLDUCK ; Pokedex number
	db FALSE ; is Dark
	db 27 ; level
	length 1.7 ; length
	weight 76.6 ; weight
	tx GolduckDescription1 ; description
	db AI_INFO_UNK_03 ; AI info

GolduckLv28Card:
	db TYPE_PKMN_WATER ; type
	dw $9089 ; gfx
	tx GolduckName ; name
	db STAR ; rarity
	db SKY_FLYING_POKEMON ; set
	db 2 ; ?
	dw GOLDUCK_LV28
	db 70 ; hp
	db STAGE1 ; stage
	tx PsyduckName ; pre-evo name

	; attack 1
	energy PSYCHIC, 1, COLORLESS, 1 ; energies
	tx Text1509 ; name
	tx Text150a ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_PLUS ; category
	dw $4f97 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_PSYCHIC_HIT ; animation

	; attack 2
	energy WATER, 2, COLORLESS, 1 ; energies
	tx Text150b ; name
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
	tx Text14fe ; category
	db DEX_GOLDUCK ; Pokedex number
	db FALSE ; is Dark
	db 28 ; level
	length 1.7 ; length
	weight 76.6 ; weight
	tx GolduckDescription2 ; description
	db NONE ; AI info

DarkGolduckCard:
	db TYPE_PKMN_WATER ; type
	dw $5e0e ; gfx
	tx DarkGolduckName ; name
	db DIAMOND ; rarity
	db PSYCHIC_BATTLE ; set
	db 6 ; ?
	dw DARK_GOLDUCK
	db 60 ; hp
	db STAGE1 ; stage
	tx PsyduckName ; pre-evo name

	; attack 1
	energy PSYCHIC, 1 ; energies
	tx Text150e ; name
	tx Text150f ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db RESIDUAL ; category
	dw $4964 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db SPECIAL_AI_HANDLING | FLAG_3_BIT_2  ; flags 3
	db 0 ; ?
	db ATK_ANIM_GLOW_EFFECT ; animation

	; attack 2
	energy PSYCHIC, 2, COLORLESS, 1 ; energies
	tx Text1510 ; name
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
	tx Text14fe ; category
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
	db BEGINNING_POKEMON ; set
	db 2 ; ?
	dw POLIWAG_LV13
	db 40 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy WATER, 1 ; energies
	tx Text1502 ; name
	tx Text1513 ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_PLUS ; category
	dw $42ed ; effect commands
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
	tx Text1514 ; category
	db DEX_POLIWAG ; Pokedex number
	db FALSE ; is Dark
	db 13 ; level
	length 0.6 ; length
	weight 12.4 ; weight
	tx PoliwagDescription1 ; description
	db AI_INFO_UNK_03 | HAS_EVOLUTION ; AI info

PoliwagLv15Card:
	db TYPE_PKMN_WATER ; type
	dw $79ae ; gfx
	tx PoliwagName ; name
	db CIRCLE ; rarity
	db SKY_FLYING_POKEMON ; set
	db 4 ; ?
	dw POLIWAG_LV15
	db 50 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy WATER, 1 ; energies
	tx Text14d6 ; name
	tx Text1363 ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_NORMAL ; category
	dw $4cc3 ; effect commands
	db INFLICT_PARALYSIS  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_66 ; animation

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
	tx Text1514 ; category
	db DEX_POLIWAG ; Pokedex number
	db FALSE ; is Dark
	db 15 ; level
	length 0.6 ; length
	weight 12.4 ; weight
	tx PoliwagDescription2 ; description
	db NONE | HAS_EVOLUTION ; AI info

PoliwhirlLv28Card:
	db TYPE_PKMN_WATER ; type
	dw $21d8 ; gfx
	tx PoliwhirlName ; name
	db DIAMOND ; rarity
	db BEGINNING_POKEMON ; set
	db 4 ; ?
	dw POLIWHIRL_LV28
	db 60 ; hp
	db STAGE1 ; stage
	tx PoliwagName ; pre-evo name

	; attack 1
	energy WATER, 2 ; energies
	tx Text1518 ; name
	tx Text1519 ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db DAMAGE_NORMAL ; category
	dw $42c4 ; effect commands
	db NONE ; flags 1
	db NULLIFY_OR_WEAKEN_ATTACK  ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_AMNESIA ; animation

	; attack 2
	energy WATER, 2, COLORLESS, 1 ; energies
	tx Text14e8 ; name
	tx Text1352 ; description
	dw NONE ; description (cont)
	db 30 ; damage
	db DAMAGE_X ; category
	dw $42d2 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_203 ; animation

	db 1 ; retreat cost
	db WR_GRASS ; weakness
	db NONE ; resistance
	tx Text1514 ; category
	db DEX_POLIWHIRL ; Pokedex number
	db FALSE ; is Dark
	db 28 ; level
	length 1.0 ; length
	weight 20.0 ; weight
	tx PoliwhirlDescription1 ; description
	db NONE | HAS_EVOLUTION ; AI info

PoliwhirlLv30Card:
	db TYPE_PKMN_WATER ; type
	dw $7a17 ; gfx
	tx PoliwhirlName ; name
	db DIAMOND ; rarity
	db SKY_FLYING_POKEMON ; set
	db 2 ; ?
	dw POLIWHIRL_LV30
	db 70 ; hp
	db STAGE1 ; stage
	tx PoliwagName ; pre-evo name

	; attack 1
	energy WATER, 2 ; energies
	tx Text151b ; name
	tx Text151c ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db DAMAGE_NORMAL ; category
	dw $4cc8 ; effect commands
	db INFLICT_SLEEP | INFLICT_CONFUSION  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_232 ; animation

	; attack 2
	energy WATER, 1, COLORLESS, 2 ; energies
	tx Text151d ; name
	tx Text1363 ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_NORMAL ; category
	dw $4ccd ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_HIT_EFFECT ; animation

	db 1 ; retreat cost
	db WR_GRASS ; weakness
	db NONE ; resistance
	tx Text1514 ; category
	db DEX_POLIWHIRL ; Pokedex number
	db FALSE ; is Dark
	db 30 ; level
	length 1.0 ; length
	weight 20.0 ; weight
	tx PoliwhirlDescription2 ; description
	db NONE | HAS_EVOLUTION ; AI info

PoliwrathLv40Card:
	db TYPE_PKMN_WATER ; type
	dw $7a86 ; gfx
	tx PoliwrathName ; name
	db STAR ; rarity
	db SKY_FLYING_POKEMON ; set
	db 2 ; ?
	dw POLIWRATH_LV40
	db 80 ; hp
	db STAGE2 ; stage
	tx PoliwhirlName ; pre-evo name

	; attack 1
	energy WATER, 2 ; energies
	tx Text1382 ; name
	dw NONE ; description
	dw NONE ; description (cont)
	db 30 ; damage
	db DAMAGE_NORMAL ; category
	dw NONE ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_176 ; animation

	; attack 2
	energy WATER, 3 ; energies
	tx Text14f0 ; name
	tx Text14f1 ; description
	dw NONE ; description (cont)
	db 40 ; damage
	db DAMAGE_PLUS ; category
	dw $4cd2 ; effect commands
	db NONE ; flags 1
	db ATTACHED_ENERGY_BOOST  ; flags 2
	db NONE ; flags 3
	db 2 ; ?
	db ATK_ANIM_HYDRO_PUMP ; animation

	db 2 ; retreat cost
	db WR_GRASS ; weakness
	db NONE ; resistance
	tx Text1514 ; category
	db DEX_POLIWRATH ; Pokedex number
	db FALSE ; is Dark
	db 40 ; level
	length 1.3 ; length
	weight 54.0 ; weight
	tx PoliwrathDescription1 ; description
	db NONE ; AI info

PoliwrathLv48Card:
	db TYPE_PKMN_WATER ; type
	dw $2241 ; gfx
	tx PoliwrathName ; name
	db STAR ; rarity
	db BEGINNING_POKEMON ; set
	db 4 ; ?
	dw POLIWRATH_LV48
	db 90 ; hp
	db STAGE2 ; stage
	tx PoliwhirlName ; pre-evo name

	; attack 1
	energy WATER, 2, COLORLESS, 1 ; energies
	tx Text1502 ; name
	tx Text1513 ; description
	dw NONE ; description (cont)
	db 30 ; damage
	db DAMAGE_PLUS ; category
	dw $42da ; effect commands
	db NONE ; flags 1
	db ATTACHED_ENERGY_BOOST  ; flags 2
	db NONE ; flags 3
	db 2 ; ?
	db ATK_ANIM_WATER_GUN ; animation

	; attack 2
	energy WATER, 2, COLORLESS, 2 ; energies
	tx Text1521 ; name
	tx Text1507 ; description
	dw NONE ; description (cont)
	db 40 ; damage
	db DAMAGE_NORMAL ; category
	dw $42e2 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db SPECIAL_AI_HANDLING  ; flags 3
	db 0 ; ?
	db ATK_ANIM_WHIRLPOOL ; animation

	db 3 ; retreat cost
	db WR_GRASS ; weakness
	db NONE ; resistance
	tx Text1514 ; category
	db DEX_POLIWRATH ; Pokedex number
	db FALSE ; is Dark
	db 48 ; level
	length 1.3 ; length
	weight 54.0 ; weight
	tx PoliwrathDescription2 ; description
	db NONE ; AI info

TentacoolCard:
	db TYPE_PKMN_WATER ; type
	dw $22aa ; gfx
	tx TentacoolName ; name
	db CIRCLE ; rarity
	db ISLAND_OF_FOSSIL ; set
	db 1 ; ?
	dw TENTACOOL
	db 30 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy 0 ; energies
	tx Text1524 ; name
	tx Text1525 ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db POKEMON_POWER ; category
	dw $4312 ; effect commands
	db NONE ; flags 1
	db FLAG_2_BIT_6  ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_PKMN_POWER_1 ; animation

	; attack 2
	energy WATER, 1 ; energies
	tx Text13fe ; name
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
	tx Text1526 ; category
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
	db ISLAND_OF_FOSSIL ; set
	db 1 ; ?
	dw TENTACRUEL
	db 60 ; hp
	db STAGE1 ; stage
	tx TentacoolName ; pre-evo name

	; attack 1
	energy WATER, 1 ; energies
	tx Text137b ; name
	tx Text137c ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db DAMAGE_NORMAL ; category
	dw $42b7 ; effect commands
	db INFLICT_CONFUSION  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_SUPERSONIC ; animation

	; attack 2
	energy WATER, 2 ; energies
	tx Text1529 ; name
	tx Text130f ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_NORMAL ; category
	dw $42bc ; effect commands
	db INFLICT_POISON  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_MULTIPLE_SLASH ; animation

	db 0 ; retreat cost
	db WR_LIGHTNING ; weakness
	db NONE ; resistance
	tx Text1526 ; category
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
	db SKY_FLYING_POKEMON ; set
	db 4 ; ?
	dw SEEL_LV10
	db 50 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy COLORLESS, 1 ; energies
	tx Text1457 ; name
	tx Text152c ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db DAMAGE_NORMAL ; category
	dw $4e70 ; effect commands
	db NONE ; flags 1
	db NULLIFY_OR_WEAKEN_ATTACK  ; flags 2
	db NONE ; flags 3
	db 10 ; ?
	db ATK_ANIM_SUPERSONIC ; animation

	; attack 2
	energy WATER, 2 ; energies
	tx Text152d ; name
	tx Text1363 ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_NORMAL ; category
	dw $4e75 ; effect commands
	db INFLICT_PARALYSIS  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_31 ; animation

	db 1 ; retreat cost
	db WR_LIGHTNING ; weakness
	db NONE ; resistance
	tx Text152e ; category
	db DEX_SEEL ; Pokedex number
	db FALSE ; is Dark
	db 10 ; level
	length 1.1 ; length
	weight 90.0 ; weight
	tx SeelDescription1 ; description
	db NONE | HAS_EVOLUTION ; AI info

SeelLv12Card:
	db TYPE_PKMN_WATER ; type
	dw $23c8 ; gfx
	tx SeelName ; name
	db CIRCLE ; rarity
	db BEGINNING_POKEMON ; set
	db 0 ; ?
	dw SEEL_LV12
	db 60 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy WATER, 1 ; energies
	tx Text1530 ; name
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
	tx Text152e ; category
	db DEX_SEEL ; Pokedex number
	db FALSE ; is Dark
	db 12 ; level
	length 1.1 ; length
	weight 90.0 ; weight
	tx SeelDescription2 ; description
	db AI_INFO_UNK_03 | HAS_EVOLUTION ; AI info

DewgongLv24Card:
	db TYPE_PKMN_WATER ; type
	dw $869c ; gfx
	tx DewgongName ; name
	db DIAMOND ; rarity
	db SKY_FLYING_POKEMON ; set
	db 4 ; ?
	dw DEWGONG_LV24
	db 60 ; hp
	db STAGE1 ; stage
	tx SeelName ; pre-evo name

	; attack 1
	energy COLORLESS, 2 ; energies
	tx Text1533 ; name
	tx Text1534 ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db RESIDUAL ; category
	dw $4e7a ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db SPECIAL_AI_HANDLING | FLAG_3_BIT_2  ; flags 3
	db 0 ; ?
	db ATK_ANIM_239 ; animation

	; attack 2
	energy WATER, 3 ; energies
	tx Text1535 ; name
	tx Text1336 ; description
	dw NONE ; description (cont)
	db 30 ; damage
	db DAMAGE_NORMAL ; category
	dw $4e82 ; effect commands
	db INFLICT_CONFUSION  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_172 ; animation

	db 2 ; retreat cost
	db WR_LIGHTNING ; weakness
	db NONE ; resistance
	tx Text152e ; category
	db DEX_DEWGONG ; Pokedex number
	db FALSE ; is Dark
	db 24 ; level
	length 1.7 ; length
	weight 120.0 ; weight
	tx DewgongDescription1 ; description
	db NONE ; AI info

DewgongLv42Card:
	db TYPE_PKMN_WATER ; type
	dw $2431 ; gfx
	tx DewgongName ; name
	db STAR ; rarity
	db BEGINNING_POKEMON ; set
	db 0 ; ?
	dw DEWGONG_LV42
	db 80 ; hp
	db STAGE1 ; stage
	tx SeelName ; pre-evo name

	; attack 1
	energy WATER, 2, COLORLESS, 1 ; energies
	tx Text1537 ; name
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
	tx Text152d ; name
	tx Text132f ; description
	dw NONE ; description (cont)
	db 30 ; damage
	db DAMAGE_NORMAL ; category
	dw $428d ; effect commands
	db INFLICT_PARALYSIS  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_BEAM ; animation

	db 3 ; retreat cost
	db WR_LIGHTNING ; weakness
	db NONE ; resistance
	tx Text152e ; category
	db DEX_DEWGONG ; Pokedex number
	db FALSE ; is Dark
	db 42 ; level
	length 1.7 ; length
	weight 120.0 ; weight
	tx DewgongDescription2 ; description
	db NONE ; AI info

ShellderLv8Card:
	db TYPE_PKMN_WATER ; type
	dw $249a ; gfx
	tx ShellderName ; name
	db CIRCLE ; rarity
	db ISLAND_OF_FOSSIL ; set
	db 1 ; ?
	dw SHELLDER_LV8
	db 30 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy WATER, 1 ; energies
	tx Text137b ; name
	tx Text137c ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db DAMAGE_NORMAL ; category
	dw $4273 ; effect commands
	db INFLICT_CONFUSION  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_SUPERSONIC ; animation

	; attack 2
	energy WATER, 1 ; energies
	tx Text153a ; name
	tx Text133a ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db RESIDUAL ; category
	dw $4278 ; effect commands
	db NONE ; flags 1
	db NULLIFY_OR_WEAKEN_ATTACK  ; flags 2
	db FLAG_3_BIT_2  ; flags 3
	db 0 ; ?
	db ATK_ANIM_NONE ; animation

	db 1 ; retreat cost
	db WR_LIGHTNING ; weakness
	db NONE ; resistance
	tx Text153b ; category
	db DEX_SHELLDER ; Pokedex number
	db FALSE ; is Dark
	db 8 ; level
	length 0.3 ; length
	weight 4.0 ; weight
	tx ShellderDescription1 ; description
	db AI_INFO_UNK_03 | HAS_EVOLUTION ; AI info

ShellderLv16Card:
	db TYPE_PKMN_WATER ; type
	dw $8705 ; gfx
	tx ShellderName ; name
	db CIRCLE ; rarity
	db SKY_FLYING_POKEMON ; set
	db 3 ; ?
	dw SHELLDER_LV16
	db 50 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy WATER, 1, COLORLESS, 1 ; energies
	tx Text153d ; name
	tx Text153e ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_PLUS ; category
	dw $4e87 ; effect commands
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
	tx Text153b ; category
	db DEX_SHELLDER ; Pokedex number
	db FALSE ; is Dark
	db 16 ; level
	length 0.3 ; length
	weight 4.0 ; weight
	tx ShellderDescription2 ; description
	db NONE | HAS_EVOLUTION ; AI info

CloysterCard:
	db TYPE_PKMN_WATER ; type
	dw $2523 ; gfx
	tx CloysterName ; name
	db DIAMOND ; rarity
	db ISLAND_OF_FOSSIL ; set
	db 1 ; ?
	dw CLOYSTER
	db 50 ; hp
	db STAGE1 ; stage
	tx ShellderName ; pre-evo name

	; attack 1
	energy WATER, 2 ; energies
	tx Text1541 ; name
	tx Text1542 ; description
	dw NONE ; description (cont)
	db 30 ; damage
	db DAMAGE_NORMAL ; category
	dw $42f5 ; effect commands
	db INFLICT_PARALYSIS  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_NONE ; animation

	; attack 2
	energy WATER, 2 ; energies
	tx Text1543 ; name
	tx Text1352 ; description
	dw NONE ; description (cont)
	db 30 ; damage
	db DAMAGE_X ; category
	dw $42fd ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_NEEDLES ; animation

	db 2 ; retreat cost
	db WR_LIGHTNING ; weakness
	db NONE ; resistance
	tx Text153b ; category
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
	db SKY_FLYING_POKEMON ; set
	db 3 ; ?
	dw KRABBY_LV17
	db 40 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy WATER, 1 ; energies
	tx Text14d6 ; name
	tx Text1363 ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_NORMAL ; category
	dw $4e99 ; effect commands
	db INFLICT_PARALYSIS  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_66 ; animation

	; attack 2
	energy WATER, 1, COLORLESS, 2 ; energies
	tx Text1546 ; name
	dw NONE ; description
	dw NONE ; description (cont)
	db 30 ; damage
	db DAMAGE_NORMAL ; category
	dw NONE ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_243 ; animation

	db 1 ; retreat cost
	db WR_LIGHTNING ; weakness
	db NONE ; resistance
	tx Text1547 ; category
	db DEX_KRABBY ; Pokedex number
	db FALSE ; is Dark
	db 17 ; level
	length 0.4 ; length
	weight 6.5 ; weight
	tx KrabbyDescription1 ; description
	db NONE | HAS_EVOLUTION ; AI info

KrabbyLv20Card:
	db TYPE_PKMN_WATER ; type
	dw $258c ; gfx
	tx KrabbyName ; name
	db CIRCLE ; rarity
	db ISLAND_OF_FOSSIL ; set
	db 0 ; ?
	dw KRABBY_LV20
	db 50 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy WATER, 1 ; energies
	tx Text1373 ; name
	tx Text1549 ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db RESIDUAL ; category
	dw $4233 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db SPECIAL_AI_HANDLING | FLAG_3_BIT_2  ; flags 3
	db 0 ; ?
	db ATK_ANIM_GLOW_EFFECT ; animation

	; attack 2
	energy WATER, 1, COLORLESS, 1 ; energies
	tx Text154a ; name
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
	tx Text1547 ; category
	db DEX_KRABBY ; Pokedex number
	db FALSE ; is Dark
	db 20 ; level
	length 0.4 ; length
	weight 6.5 ; weight
	tx KrabbyDescription2 ; description
	db NONE | HAS_EVOLUTION ; AI info

KinglerLv27Card:
	db TYPE_PKMN_WATER ; type
	dw $25f9 ; gfx
	tx KinglerName ; name
	db DIAMOND ; rarity
	db ISLAND_OF_FOSSIL ; set
	db 0 ; ?
	dw KINGLER_LV27
	db 60 ; hp
	db STAGE1 ; stage
	tx KrabbyName ; pre-evo name

	; attack 1
	energy WATER, 1 ; energies
	tx Text154d ; name
	tx Text154e ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_X ; category
	dw $422b ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db BOOST_IF_TAKEN_DAMAGE  ; flags 3
	db 0 ; ?
	db ATK_ANIM_BIG_HIT ; animation

	; attack 2
	energy WATER, 2, COLORLESS, 1 ; energies
	tx Text154f ; name
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
	tx Text1550 ; category
	db DEX_KINGLER ; Pokedex number
	db FALSE ; is Dark
	db 27 ; level
	length 1.3 ; length
	weight 60.0 ; weight
	tx KinglerDescription1 ; description
	db NONE ; AI info

KinglerLv33Card:
	db TYPE_PKMN_WATER ; type
	dw $9800 ; gfx
	tx KinglerName ; name
	db STAR ; rarity
	db SKY_FLYING_POKEMON ; set
	db 3 ; ?
	dw KINGLER_LV33
	db 80 ; hp
	db STAGE1 ; stage
	tx KrabbyName ; pre-evo name

	; attack 1
	energy WATER, 1 ; energies
	tx Text1552 ; name
	tx Text1553 ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db RESIDUAL ; category
	dw $50b0 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db SPECIAL_AI_HANDLING | FLAG_3_BIT_2  ; flags 3
	db 0 ; ?
	db ATK_ANIM_GLOW_EFFECT ; animation

	; attack 2
	energy WATER, 4 ; energies
	tx Text1554 ; name
	tx Text1555 ; description
	dw NONE ; description (cont)
	db 80 ; damage
	db DAMAGE_NORMAL ; category
	dw $50c1 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_243 ; animation

	db 3 ; retreat cost
	db WR_LIGHTNING ; weakness
	db NONE ; resistance
	tx Text1550 ; category
	db DEX_KINGLER ; Pokedex number
	db FALSE ; is Dark
	db 33 ; level
	length 1.3 ; length
	weight 60.0 ; weight
	tx KinglerDescription2 ; description
	db NONE ; AI info

HorseaLv19Card:
	db TYPE_PKMN_WATER ; type
	dw $2666 ; gfx
	tx HorseaName ; name
	db CIRCLE ; rarity
	db ISLAND_OF_FOSSIL ; set
	db 2 ; ?
	dw HORSEA_LV19
	db 40 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy WATER, 1 ; energies
	tx Text14bc ; name
	tx Text14bd ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_NORMAL ; category
	dw $42b2 ; effect commands
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
	tx Text1558 ; category
	db DEX_HORSEA ; Pokedex number
	db FALSE ; is Dark
	db 19 ; level
	length 0.4 ; length
	weight 8.0 ; weight
	tx HorseaDescription1 ; description
	db AI_INFO_UNK_03 | HAS_EVOLUTION ; AI info

HorseaLv20Card:
	db TYPE_PKMN_WATER ; type
	dw $9a43 ; gfx
	tx HorseaName ; name
	db CIRCLE ; rarity
	db SKY_FLYING_POKEMON ; set
	db 4 ; ?
	dw HORSEA_LV20
	db 40 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy COLORLESS, 1 ; energies
	tx Text155a ; name
	tx Text155b ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db RESIDUAL ; category
	dw $50ff ; effect commands
	db NONE ; flags 1
	db NULLIFY_OR_WEAKEN_ATTACK  ; flags 2
	db FLAG_3_BIT_2  ; flags 3
	db 0 ; ?
	db ATK_ANIM_PROTECT ; animation

	; attack 2
	energy WATER, 1 ; energies
	tx Text1502 ; name
	tx Text153e ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_PLUS ; category
	dw $5104 ; effect commands
	db NONE ; flags 1
	db ATTACHED_ENERGY_BOOST  ; flags 2
	db NONE ; flags 3
	db 2 ; ?
	db ATK_ANIM_WATER_GUN ; animation

	db 0 ; retreat cost
	db WR_LIGHTNING ; weakness
	db NONE ; resistance
	tx Text1558 ; category
	db DEX_HORSEA ; Pokedex number
	db FALSE ; is Dark
	db 20 ; level
	length 0.4 ; length
	weight 8.0 ; weight
	tx HorseaDescription2 ; description
	db NONE | HAS_EVOLUTION ; AI info

SeadraLv23Card:
	db TYPE_PKMN_WATER ; type
	dw $26cf ; gfx
	tx SeadraName ; name
	db DIAMOND ; rarity
	db ISLAND_OF_FOSSIL ; set
	db 2 ; ?
	dw SEADRA_LV23
	db 60 ; hp
	db STAGE1 ; stage
	tx HorseaName ; pre-evo name

	; attack 1
	energy WATER, 1, COLORLESS, 1 ; energies
	tx Text1502 ; name
	tx Text14f1 ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_PLUS ; category
	dw $4266 ; effect commands
	db NONE ; flags 1
	db ATTACHED_ENERGY_BOOST  ; flags 2
	db NONE ; flags 3
	db 2 ; ?
	db ATK_ANIM_WATER_GUN ; animation

	; attack 2
	energy WATER, 1, COLORLESS, 2 ; energies
	tx Text14ab ; name
	tx Text14ac ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_NORMAL ; category
	dw $426e ; effect commands
	db NONE ; flags 1
	db NULLIFY_OR_WEAKEN_ATTACK  ; flags 2
	db FLAG_3_BIT_2  ; flags 3
	db 0 ; ?
	db ATK_ANIM_QUICK_ATTACK ; animation

	db 1 ; retreat cost
	db WR_LIGHTNING ; weakness
	db NONE ; resistance
	tx Text1558 ; category
	db DEX_SEADRA ; Pokedex number
	db FALSE ; is Dark
	db 23 ; level
	length 1.2 ; length
	weight 25.0 ; weight
	tx SeadraDescription1 ; description
	db NONE ; AI info

SeadraLv26Card:
	db TYPE_PKMN_WATER ; type
	dw $9aac ; gfx
	tx SeadraName ; name
	db STAR ; rarity
	db SKY_FLYING_POKEMON ; set
	db 4 ; ?
	dw SEADRA_LV26
	db 70 ; hp
	db STAGE1 ; stage
	tx HorseaName ; pre-evo name

	; attack 1
	energy WATER, 2 ; energies
	tx Text155f ; name
	tx Text1560 ; description
	tx Text1561 ; description (cont)
	db 20 ; damage
	db DAMAGE_NORMAL ; category
	dw $510c ; effect commands
	db DAMAGE_TO_OPPONENT_BENCH  ; flags 1
	db ATTACHED_ENERGY_BOOST  ; flags 2
	db FLAG_3_BIT_2  ; flags 3
	db 2 ; ?
	db ATK_ANIM_161 ; animation

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
	tx Text1558 ; category
	db DEX_SEADRA ; Pokedex number
	db FALSE ; is Dark
	db 26 ; level
	length 1.2 ; length
	weight 25.0 ; weight
	tx SeadraDescription2 ; description
	db NONE ; AI info

GoldeenCard:
	db TYPE_PKMN_WATER ; type
	dw $2738 ; gfx
	tx GoldeenName ; name
	db CIRCLE ; rarity
	db LEGENDARY_POWER ; set
	db 1 ; ?
	dw GOLDEEN
	db 40 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy WATER, 1 ; energies
	tx Text1564 ; name
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
	tx Text1565 ; category
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
	db LEGENDARY_POWER ; set
	db 1 ; ?
	dw SEAKING
	db 70 ; hp
	db STAGE1 ; stage
	tx GoldeenName ; pre-evo name

	; attack 1
	energy WATER, 1 ; energies
	tx Text1564 ; name
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
	tx Text1568 ; name
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
	tx Text1565 ; category
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
	db BEGINNING_POKEMON ; set
	db 0 ; ?
	dw STARYU_LV15
	db 40 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy WATER, 1 ; energies
	tx Text156b ; name
	dw NONE ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_NORMAL ; category
	dw NONE ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_203 ; animation

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
	tx Text156c ; category
	db DEX_STARYU ; Pokedex number
	db FALSE ; is Dark
	db 15 ; level
	length 0.8 ; length
	weight 34.5 ; weight
	tx StaryuDescription1 ; description
	db AI_INFO_UNK_03 | HAS_EVOLUTION ; AI info

StaryuLv17Card:
	db TYPE_PKMN_WATER ; type
	dw $9b15 ; gfx
	tx StaryuName ; name
	db CIRCLE ; rarity
	db SKY_FLYING_POKEMON ; set
	db 3 ; ?
	dw STARYU_LV17
	db 50 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy WATER, 1 ; energies
	tx Text156e ; name
	tx Text156f ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_NORMAL ; category
	dw $5117 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db SPECIAL_AI_HANDLING | FLAG_3_BIT_2  ; flags 3
	db 0 ; ?
	db ATK_ANIM_169 ; animation

	; attack 2
	energy WATER, 1, COLORLESS, 1 ; energies
	tx Text1570 ; name
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
	tx Text156c ; category
	db DEX_STARYU ; Pokedex number
	db FALSE ; is Dark
	db 17 ; level
	length 0.8 ; length
	weight 34.5 ; weight
	tx StaryuDescription2 ; description
	db NONE | HAS_EVOLUTION ; AI info

StarmieCard:
	db TYPE_PKMN_WATER ; type
	dw $28d8 ; gfx
	tx StarmieName ; name
	db DIAMOND ; rarity
	db BEGINNING_POKEMON ; set
	db 0 ; ?
	dw STARMIE
	db 60 ; hp
	db STAGE1 ; stage
	tx StaryuName ; pre-evo name

	; attack 1
	energy WATER, 2 ; energies
	tx Text1573 ; name
	tx Text1574 ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db RESIDUAL ; category
	dw $4292 ; effect commands
	db NONE ; flags 1
	db DISCARD_ENERGY  ; flags 2
	db FLAG_3_BIT_2  ; flags 3
	db 3 ; ?
	db ATK_ANIM_RECOVER ; animation

	; attack 2
	energy WATER, 1, COLORLESS, 2 ; energies
	tx Text1575 ; name
	tx Text132f ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_NORMAL ; category
	dw $42a3 ; effect commands
	db INFLICT_PARALYSIS  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_BEAM ; animation

	db 1 ; retreat cost
	db WR_LIGHTNING ; weakness
	db NONE ; resistance
	tx Text1576 ; category
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
	db GB ; set
	db 6 ; ?
	dw DARK_STARMIE
	db 60 ; hp
	db STAGE1 ; stage
	tx StaryuName ; pre-evo name

	; attack 1
	energy 0 ; energies
	tx Text1579 ; name
	tx Text157a ; description
	tx Text157b ; description (cont)
	db 0 ; damage
	db POKEMON_POWER ; category
	dw $52f8 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_GLOW_EFFECT ; animation

	; attack 2
	energy WATER, 2 ; energies
	tx Text157c ; name
	tx Text157d ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db RESIDUAL ; category
	dw $5300 ; effect commands
	db DAMAGE_TO_OPPONENT_BENCH  ; flags 1
	db FLAG_2_BIT_6  ; flags 2
	db FLAG_3_BIT_2  ; flags 3
	db 3 ; ?
	db ATK_ANIM_251 ; animation

	db 1 ; retreat cost
	db WR_LIGHTNING ; weakness
	db NONE ; resistance
	tx Text1576 ; category
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
	db PSYCHIC_BATTLE ; set
	db 5 ; ?
	dw MAGIKARP_LV6
	db 30 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy COLORLESS, 1 ; energies
	tx Text1580 ; name
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
	tx Text1581 ; name
	tx Text1582 ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db RESIDUAL ; category
	dw $4975 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db SPECIAL_AI_HANDLING | FLAG_3_BIT_2  ; flags 3
	db 0 ; ?
	db ATK_ANIM_GLOW_EFFECT ; animation

	db 1 ; retreat cost
	db WR_LIGHTNING ; weakness
	db NONE ; resistance
	tx Text1583 ; category
	db DEX_MAGIKARP ; Pokedex number
	db FALSE ; is Dark
	db 6 ; level
	length 0.9 ; length
	weight 10.0 ; weight
	tx MagikarpDescription1 ; description
	db NONE | HAS_EVOLUTION ; AI info

MagikarpLv8Card:
	db TYPE_PKMN_WATER ; type
	dw $2941 ; gfx
	tx MagikarpName ; name
	db DIAMOND ; rarity
	db BEGINNING_POKEMON ; set
	db 0 ; ?
	dw MAGIKARP_LV8
	db 30 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy COLORLESS, 1 ; energies
	tx Text1305 ; name
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
	tx Text154d ; name
	tx Text154e ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_X ; category
	dw $4241 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db BOOST_IF_TAKEN_DAMAGE  ; flags 3
	db 0 ; ?
	db ATK_ANIM_BIG_HIT ; animation

	db 1 ; retreat cost
	db WR_LIGHTNING ; weakness
	db NONE ; resistance
	tx Text1583 ; category
	db DEX_MAGIKARP ; Pokedex number
	db FALSE ; is Dark
	db 8 ; level
	length 0.9 ; length
	weight 10.0 ; weight
	tx MagikarpDescription2 ; description
	db AI_INFO_ENCOURAGE_EVO | HAS_EVOLUTION ; AI info

MagikarpLv10Card:
	db TYPE_PKMN_WATER ; type
	dw $a376 ; gfx
	tx MagikarpName ; name
	db PROMOSTAR ; rarity
	db PRO ; set
	db 7 ; ?
	dw MAGIKARP_LV10
	db 30 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy WATER, 1 ; energies
	tx Text1586 ; name
	tx Text1587 ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_X ; category
	dw $5237 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_HIT ; animation

	; attack 2
	energy WATER, 2 ; energies
	tx Text1588 ; name
	tx Text1589 ; description
	dw NONE ; description (cont)
	db 50 ; damage
	db DAMAGE_NORMAL ; category
	dw $523f ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_DRAGON_RAGE ; animation

	db 1 ; retreat cost
	db WR_LIGHTNING ; weakness
	db NONE ; resistance
	tx Text1583 ; category
	db DEX_MAGIKARP ; Pokedex number
	db FALSE ; is Dark
	db 10 ; level
	length 0.9 ; length
	weight 10.0 ; weight
	tx MagikarpDescription3 ; description
	db NONE | HAS_EVOLUTION ; AI info

GyaradosCard:
	db TYPE_PKMN_WATER ; type
	dw $29aa ; gfx
	tx GyaradosName ; name
	db STAR ; rarity
	db BEGINNING_POKEMON ; set
	db 0 ; ?
	dw GYARADOS
	db 100 ; hp
	db STAGE1 ; stage
	tx MagikarpName ; pre-evo name

	; attack 1
	energy WATER, 3 ; energies
	tx Text1588 ; name
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
	tx Text158c ; name
	tx Text132f ; description
	dw NONE ; description (cont)
	db 40 ; damage
	db DAMAGE_NORMAL ; category
	dw $4226 ; effect commands
	db INFLICT_PARALYSIS  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_BUBBLES ; animation

	db 3 ; retreat cost
	db WR_GRASS ; weakness
	db WR_FIGHTING ; resistance
	tx Text158d ; category
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
	db PSYCHIC_BATTLE ; set
	db 5 ; ?
	dw DARK_GYARADOS
	db 70 ; hp
	db STAGE1 ; stage
	tx MagikarpName ; pre-evo name

	; attack 1
	energy 0 ; energies
	tx Text1590 ; name
	tx Text1591 ; description
	tx Text1592 ; description (cont)
	db 0 ; damage
	db POKEMON_POWER ; category
	dw $4983 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_169 ; animation

	; attack 2
	energy WATER, 3 ; energies
	tx Text152d ; name
	tx Text1363 ; description
	dw NONE ; description (cont)
	db 30 ; damage
	db DAMAGE_NORMAL ; category
	dw $4988 ; effect commands
	db INFLICT_PARALYSIS  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_31 ; animation

	db 2 ; retreat cost
	db WR_GRASS ; weakness
	db WR_FIGHTING ; resistance
	tx Text158d ; category
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
	db SKY_FLYING_POKEMON ; set
	db 1 ; ?
	dw LAPRAS_LV24
	db 60 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy COLORLESS, 1 ; energies
	tx Text1595 ; name
	tx Text1596 ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db DAMAGE_NORMAL ; category
	dw $4ed0 ; effect commands
	db INFLICT_SLEEP  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_LULLABY ; animation

	; attack 2
	energy WATER, 2 ; energies
	tx Text14e5 ; name
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
	tx Text1597 ; category
	db DEX_LAPRAS ; Pokedex number
	db FALSE ; is Dark
	db 24 ; level
	length 2.5 ; length
	weight 220.0 ; weight
	tx LaprasDescription1 ; description
	db NONE ; AI info

LaprasLv31Card:
	db TYPE_PKMN_WATER ; type
	dw $2a17 ; gfx
	tx LaprasName ; name
	db STAR ; rarity
	db ISLAND_OF_FOSSIL ; set
	db 4 ; ?
	dw LAPRAS_LV31
	db 80 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy WATER, 1 ; energies
	tx Text1502 ; name
	tx Text14f1 ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_PLUS ; category
	dw $431d ; effect commands
	db NONE ; flags 1
	db ATTACHED_ENERGY_BOOST  ; flags 2
	db NONE ; flags 3
	db 2 ; ?
	db ATK_ANIM_WATER_GUN ; animation

	; attack 2
	energy WATER, 2 ; energies
	tx Text1470 ; name
	tx Text137c ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_NORMAL ; category
	dw $4325 ; effect commands
	db INFLICT_CONFUSION  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_CONFUSE_RAY ; animation

	db 2 ; retreat cost
	db WR_LIGHTNING ; weakness
	db NONE ; resistance
	tx Text1597 ; category
	db DEX_LAPRAS ; Pokedex number
	db FALSE ; is Dark
	db 31 ; level
	length 2.5 ; length
	weight 220.0 ; weight
	tx LaprasDescription2 ; description
	db NONE ; AI info

VaporeonLv29Card:
	db TYPE_PKMN_WATER ; type
	dw $2a80 ; gfx
	tx VaporeonName ; name
	db DIAMOND ; rarity
	db GB ; set
	db 3 ; ?
	dw VAPOREON_LV29
	db 60 ; hp
	db STAGE1 ; stage
	tx EeveeName ; pre-evo name

	; attack 1
	energy COLORLESS, 1 ; energies
	tx Text1389 ; name
	tx Text159b ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db RESIDUAL ; category
	dw $433a ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db SPECIAL_AI_HANDLING | FLAG_3_BIT_2  ; flags 3
	db 0 ; ?
	db ATK_ANIM_GLOW_EFFECT ; animation

	; attack 2
	energy COLORLESS, 3 ; energies
	tx Text135a ; name
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
	tx Text159c ; category
	db DEX_VAPOREON ; Pokedex number
	db FALSE ; is Dark
	db 29 ; level
	length 1.0 ; length
	weight 29.0 ; weight
	tx VaporeonDescription1 ; description
	db NONE ; AI info

VaporeonLv42Card:
	db TYPE_PKMN_WATER ; type
	dw $2ae9 ; gfx
	tx VaporeonName ; name
	db STAR ; rarity
	db LEGENDARY_POWER ; set
	db 1 ; ?
	dw VAPOREON_LV42
	db 80 ; hp
	db STAGE1 ; stage
	tx EeveeName ; pre-evo name

	; attack 1
	energy COLORLESS, 2 ; energies
	tx Text1490 ; name
	tx Text1491 ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_PLUS ; category
	dw $427d ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_QUICK_ATTACK ; animation

	; attack 2
	energy WATER, 2, COLORLESS, 1 ; energies
	tx Text1502 ; name
	tx Text1513 ; description
	dw NONE ; description (cont)
	db 30 ; damage
	db DAMAGE_PLUS ; category
	dw $4285 ; effect commands
	db NONE ; flags 1
	db ATTACHED_ENERGY_BOOST  ; flags 2
	db NONE ; flags 3
	db 2 ; ?
	db ATK_ANIM_WATER_GUN ; animation

	db 1 ; retreat cost
	db WR_LIGHTNING ; weakness
	db NONE ; resistance
	tx Text159c ; category
	db DEX_VAPOREON ; Pokedex number
	db FALSE ; is Dark
	db 42 ; level
	length 1.0 ; length
	weight 29.0 ; weight
	tx VaporeonDescription2 ; description
	db NONE ; AI info

DarkVaporeonCard:
	db TYPE_PKMN_WATER ; type
	dw $5f49 ; gfx
	tx DarkVaporeonName ; name
	db DIAMOND ; rarity
	db PSYCHIC_BATTLE ; set
	db 5 ; ?
	dw DARK_VAPOREON
	db 60 ; hp
	db STAGE1 ; stage
	tx EeveeName ; pre-evo name

	; attack 1
	energy COLORLESS, 3 ; energies
	tx Text135a ; name
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
	tx Text1521 ; name
	tx Text15a0 ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_NORMAL ; category
	dw $498d ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db SPECIAL_AI_HANDLING  ; flags 3
	db 0 ; ?
	db ATK_ANIM_WHIRLPOOL ; animation

	db 1 ; retreat cost
	db WR_LIGHTNING ; weakness
	db NONE ; resistance
	tx Text159c ; category
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
	db ISLAND_OF_FOSSIL ; set
	db 2 ; ?
	dw OMANYTE_LV19
	db 40 ; hp
	db STAGE1 ; stage
	tx MysteriousFossilName ; pre-evo name

	; attack 1
	energy 0 ; energies
	tx Text15a4 ; name
	tx Text15a5 ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db POKEMON_POWER ; category
	dw $41f7 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_PKMN_POWER_1 ; animation

	; attack 2
	energy WATER, 1 ; energies
	tx Text1502 ; name
	tx Text14f1 ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_PLUS ; category
	dw $41ff ; effect commands
	db NONE ; flags 1
	db ATTACHED_ENERGY_BOOST  ; flags 2
	db NONE ; flags 3
	db 2 ; ?
	db ATK_ANIM_WATER_GUN ; animation

	db 1 ; retreat cost
	db WR_GRASS ; weakness
	db NONE ; resistance
	tx Text15a6 ; category
	db DEX_OMANYTE ; Pokedex number
	db FALSE ; is Dark
	db 19 ; level
	length 0.4 ; length
	weight 7.5 ; weight
	tx OmanyteDescription1 ; description
	db AI_INFO_BENCH_UTILITY | HAS_EVOLUTION ; AI info

OmanyteLv20Card:
	db TYPE_PKMN_WATER ; type
	dw $8a96 ; gfx
	tx OmanyteName ; name
	db DIAMOND ; rarity
	db SKY_FLYING_POKEMON ; set
	db 5 ; ?
	dw OMANYTE_LV20
	db 50 ; hp
	db STAGE1 ; stage
	tx MysteriousFossilName ; pre-evo name

	; attack 1
	energy 0 ; energies
	tx Text15a8 ; name
	tx Text15a9 ; description
	tx Text15aa ; description (cont)
	db 0 ; damage
	db POKEMON_POWER ; category
	dw $4ed5 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_GLOW_EFFECT ; animation

	; attack 2
	energy COLORLESS, 2 ; energies
	tx Text15ab ; name
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
	tx Text15a6 ; category
	db DEX_OMANYTE ; Pokedex number
	db FALSE ; is Dark
	db 20 ; level
	length 0.4 ; length
	weight 7.5 ; weight
	tx OmanyteDescription2 ; description
	db NONE | HAS_EVOLUTION ; AI info

OmanyteLv22Card:
	db TYPE_PKMN_WATER ; type
	dw $9d55 ; gfx
	tx OmanyteName ; name
	db DIAMOND ; rarity
	db SKY_FLYING_POKEMON ; set
	db 4 ; ?
	dw OMANYTE_LV22
	db 50 ; hp
	db STAGE1 ; stage
	tx MysteriousFossilName ; pre-evo name

	; attack 1
	energy 0 ; energies
	tx Text15ad ; name
	tx Text15ae ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db POKEMON_POWER ; category
	dw $5146 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_GLOW_EFFECT ; animation

	; attack 2
	energy WATER, 2 ; energies
	tx Text14e5 ; name
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
	tx Text15a6 ; category
	db DEX_OMANYTE ; Pokedex number
	db FALSE ; is Dark
	db 22 ; level
	length 0.4 ; length
	weight 7.5 ; weight
	tx OmanyteDescription2 ; description
	db NONE | HAS_EVOLUTION ; AI info

OmastarLv32Card:
	db TYPE_PKMN_WATER ; type
	dw $2bbb ; gfx
	tx OmastarName ; name
	db DIAMOND ; rarity
	db ISLAND_OF_FOSSIL ; set
	db 2 ; ?
	dw OMASTAR_LV32
	db 70 ; hp
	db STAGE2 ; stage
	tx OmanyteName ; pre-evo name

	; attack 1
	energy WATER, 1, COLORLESS, 1 ; energies
	tx Text1502 ; name
	tx Text14f1 ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_PLUS ; category
	dw $41e7 ; effect commands
	db NONE ; flags 1
	db ATTACHED_ENERGY_BOOST  ; flags 2
	db NONE ; flags 3
	db 2 ; ?
	db ATK_ANIM_WATER_GUN ; animation

	; attack 2
	energy WATER, 2 ; energies
	tx Text1543 ; name
	tx Text1352 ; description
	dw NONE ; description (cont)
	db 30 ; damage
	db DAMAGE_X ; category
	dw $41ef ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_NEEDLES ; animation

	db 1 ; retreat cost
	db WR_GRASS ; weakness
	db NONE ; resistance
	tx Text15a6 ; category
	db DEX_OMASTAR ; Pokedex number
	db FALSE ; is Dark
	db 32 ; level
	length 1.0 ; length
	weight 35.0 ; weight
	tx OmastarDescription1 ; description
	db NONE ; AI info

OmastarLv36Card:
	db TYPE_PKMN_WATER ; type
	dw $9dbe ; gfx
	tx OmastarName ; name
	db STAR ; rarity
	db SKY_FLYING_POKEMON ; set
	db 7 ; ?
	dw OMASTAR_LV36
	db 80 ; hp
	db STAGE2 ; stage
	tx OmanyteName ; pre-evo name

	; attack 1
	energy WATER, 1 ; energies
	tx Text15b1 ; name
	tx Text15b2 ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db RESIDUAL ; category
	dw $514e ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db SPECIAL_AI_HANDLING | FLAG_3_BIT_2  ; flags 3
	db 0 ; ?
	db ATK_ANIM_GLOW_EFFECT ; animation

	; attack 2
	energy WATER, 3 ; energies
	tx Text15b3 ; name
	tx Text15b4 ; description
	dw NONE ; description (cont)
	db 40 ; damage
	db DAMAGE_NORMAL ; category
	dw $5159 ; effect commands
	db INFLICT_PARALYSIS  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_64 ; animation

	db 2 ; retreat cost
	db WR_GRASS ; weakness
	db NONE ; resistance
	tx Text15a6 ; category
	db DEX_OMASTAR ; Pokedex number
	db FALSE ; is Dark
	db 36 ; level
	length 1.0 ; length
	weight 35.0 ; weight
	tx OmastarDescription2 ; description
	db NONE ; AI info

ArticunoLv34Card:
	db TYPE_PKMN_WATER ; type
	dw $8bf5 ; gfx
	tx ArticunoName ; name
	db STAR ; rarity
	db SKY_FLYING_POKEMON ; set
	db 6 ; ?
	dw ARTICUNO_LV34
	db 80 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy 0 ; energies
	tx Text15b7 ; name
	tx Text15b8 ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db POKEMON_POWER ; category
	dw $4efa ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_NONE ; animation

	; attack 2
	energy WATER, 2, COLORLESS, 2 ; energies
	tx Text152d ; name
	tx Text1363 ; description
	dw NONE ; description (cont)
	db 30 ; damage
	db DAMAGE_NORMAL ; category
	dw $4eff ; effect commands
	db INFLICT_PARALYSIS  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_31 ; animation

	db 2 ; retreat cost
	db NONE ; weakness
	db WR_FIGHTING ; resistance
	tx Text15b9 ; category
	db DEX_ARTICUNO ; Pokedex number
	db FALSE ; is Dark
	db 34 ; level
	length 1.7 ; length
	weight 55.4 ; weight
	tx ArticunoDescription1 ; description
	db NONE ; AI info

ArticunoLv35Card:
	db TYPE_PKMN_WATER ; type
	dw $2c3c ; gfx
	tx ArticunoName ; name
	db STAR ; rarity
	db ISLAND_OF_FOSSIL ; set
	db 2 ; ?
	dw ARTICUNO_LV35
	db 70 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy WATER, 3 ; energies
	tx Text15bb ; name
	tx Text132f ; description
	dw NONE ; description (cont)
	db 30 ; damage
	db DAMAGE_NORMAL ; category
	dw $4305 ; effect commands
	db INFLICT_PARALYSIS  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_BEAM ; animation

	; attack 2
	energy WATER, 4 ; energies
	tx Text15bc ; name
	tx Text15bd ; description
	dw NONE ; description (cont)
	db 50 ; damage
	db DAMAGE_NORMAL ; category
	dw $430a ; effect commands
	db DAMAGE_TO_OPPONENT_BENCH  ; flags 1
	db NONE ; flags 2
	db FLAG_3_BIT_2  ; flags 3
	db 10 ; ?
	db ATK_ANIM_BLIZZARD ; animation

	db 2 ; retreat cost
	db NONE ; weakness
	db WR_FIGHTING ; resistance
	tx Text15b9 ; category
	db DEX_ARTICUNO ; Pokedex number
	db FALSE ; is Dark
	db 35 ; level
	length 1.7 ; length
	weight 55.4 ; weight
	tx ArticunoDescription2 ; description
	db NONE ; AI info

ArticunoLv37Card:
	db TYPE_PKMN_WATER ; type
	dw $2ca5 ; gfx
	tx ArticunoName ; name
	db STAR ; rarity
	db GB ; set
	db 7 ; ?
	dw ARTICUNO_LV37
	db 100 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy 0 ; energies
	tx Text15bf ; name
	tx Text15c0 ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db POKEMON_POWER ; category
	dw $432a ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_QUICKFREEZE ; animation

	; attack 2
	energy WATER, 3 ; energies
	tx Text15c1 ; name
	tx Text15c2 ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db RESIDUAL ; category
	dw $4332 ; effect commands
	db DAMAGE_TO_OPPONENT_BENCH  ; flags 1
	db FLAG_2_BIT_6  ; flags 2
	db FLAG_3_BIT_2  ; flags 3
	db 3 ; ?
	db ATK_ANIM_WHIRLWIND_ZIGZAG ; animation

	db 2 ; retreat cost
	db NONE ; weakness
	db WR_FIGHTING ; resistance
	tx Text15b9 ; category
	db DEX_ARTICUNO ; Pokedex number
	db FALSE ; is Dark
	db 37 ; level
	length 1.7 ; length
	weight 55.4 ; weight
	tx ArticunoDescription3 ; description
	db NONE ; AI info

MarillCard:
	db TYPE_PKMN_WATER ; type
	dw $a60e ; gfx
	tx MarillName ; name
	db PROMOSTAR ; rarity
	db PRO ; set
	db 7 ; ?
	dw MARILL
	db 50 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy WATER, 2 ; energies
	tx Text1502 ; name
	tx Text153e ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_PLUS ; category
	dw $5257 ; effect commands
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
	tx Text15c5 ; category
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
	db SKY_FLYING_POKEMON ; set
	db 4 ; ?
	dw PIKACHU_LV5
	db 30 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy LIGHTNING, 1 ; energies
	tx Text15c8 ; name
	tx Text1363 ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_NORMAL ; category
	dw $4c4f ; effect commands
	db INFLICT_PARALYSIS  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_9 ; animation

	; attack 2
	energy LIGHTNING, 2 ; energies
	tx Text14ab ; name
	tx Text14ac ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_NORMAL ; category
	dw $4c54 ; effect commands
	db NONE ; flags 1
	db NULLIFY_OR_WEAKEN_ATTACK  ; flags 2
	db FLAG_3_BIT_2  ; flags 3
	db 0 ; ?
	db ATK_ANIM_AGILITY_PROTECT ; animation

	db 0 ; retreat cost
	db WR_FIGHTING ; weakness
	db NONE ; resistance
	tx Text15c9 ; category
	db DEX_PIKACHU ; Pokedex number
	db FALSE ; is Dark
	db 5 ; level
	length 0.4 ; length
	weight 6.0 ; weight
	tx PikachuDescription1 ; description
	db NONE | HAS_EVOLUTION ; AI info

PikachuLv12Card:
	db TYPE_PKMN_LIGHTNING ; type
	dw $2d0e ; gfx
	tx PikachuName ; name
	db CIRCLE ; rarity
	db BEGINNING_POKEMON ; set
	db 0 ; ?
	dw PIKACHU_LV12
	db 40 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy COLORLESS, 1 ; energies
	tx Text15cb ; name
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
	tx Text15cc ; name
	tx Text15cd ; description
	dw NONE ; description (cont)
	db 30 ; damage
	db DAMAGE_NORMAL ; category
	dw $46b4 ; effect commands
	db LOW_RECOIL  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_THUNDERSHOCK ; animation

	db 1 ; retreat cost
	db WR_FIGHTING ; weakness
	db NONE ; resistance
	tx Text15c9 ; category
	db DEX_PIKACHU ; Pokedex number
	db FALSE ; is Dark
	db 12 ; level
	length 0.4 ; length
	weight 6.0 ; weight
	tx PikachuDescription2 ; description
	db AI_INFO_UNK_03 | HAS_EVOLUTION ; AI info

PikachuLv13Card:
	db TYPE_PKMN_LIGHTNING ; type
	dw $a0d2 ; gfx
	tx PikachuName ; name
	db STAR ; rarity
	db PRO ; set
	db 7 ; ?
	dw PIKACHU_LV13
	db 50 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy LIGHTNING, 1 ; energies
	tx Text15cf ; name
	tx Text15d0 ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db RESIDUAL ; category
	dw $51e6 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db SPECIAL_AI_HANDLING | FLAG_3_BIT_2  ; flags 3
	db 0 ; ?
	db ATK_ANIM_GLOW_EFFECT ; animation

	; attack 2
	energy LIGHTNING, 3 ; energies
	tx Text15d1 ; name
	tx Text15d2 ; description
	dw NONE ; description (cont)
	db 50 ; damage
	db DAMAGE_NORMAL ; category
	dw $51f4 ; effect commands
	db NONE ; flags 1
	db DISCARD_ENERGY  ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_THUNDERBOLT ; animation

	db 1 ; retreat cost
	db WR_FIGHTING ; weakness
	db NONE ; resistance
	tx Text15c9 ; category
	db DEX_PIKACHU ; Pokedex number
	db FALSE ; is Dark
	db 13 ; level
	length 0.4 ; length
	weight 6.0 ; weight
	tx PikachuDescription3 ; description
	db NONE | HAS_EVOLUTION ; AI info

PikachuLv14Card:
	db TYPE_PKMN_LIGHTNING ; type
	dw $2d77 ; gfx
	tx PikachuName ; name
	db CIRCLE ; rarity
	db LEGENDARY_POWER ; set
	db 2 ; ?
	dw PIKACHU_LV14
	db 50 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy LIGHTNING, 2 ; energies
	tx Text15d4 ; name
	tx Text15d5 ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_NORMAL ; category
	dw $46bc ; effect commands
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
	tx Text15c9 ; category
	db DEX_PIKACHU ; Pokedex number
	db FALSE ; is Dark
	db 14 ; level
	length 0.4 ; length
	weight 6.0 ; weight
	tx PikachuDescription4 ; description
	db NONE | HAS_EVOLUTION ; AI info

PikachuLv16Card:
	db TYPE_PKMN_LIGHTNING ; type
	dw $2de0 ; gfx
	tx PikachuName ; name
	db PROMOSTAR ; rarity
	db PRO ; set
	db 7 ; ?
	dw PIKACHU_LV16
	db 60 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy COLORLESS, 1 ; energies
	tx Text1457 ; name
	tx Text152c ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db DAMAGE_NORMAL ; category
	dw $46c7 ; effect commands
	db NONE ; flags 1
	db NULLIFY_OR_WEAKEN_ATTACK  ; flags 2
	db NONE ; flags 3
	db 10 ; ?
	db ATK_ANIM_SUPERSONIC ; animation

	; attack 2
	energy LIGHTNING, 2 ; energies
	tx Text15c8 ; name
	tx Text1363 ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_NORMAL ; category
	dw $46cc ; effect commands
	db INFLICT_PARALYSIS  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_THUNDERSHOCK ; animation

	db 1 ; retreat cost
	db WR_FIGHTING ; weakness
	db NONE ; resistance
	tx Text15c9 ; category
	db DEX_PIKACHU ; Pokedex number
	db FALSE ; is Dark
	db 16 ; level
	length 0.4 ; length
	weight 6.0 ; weight
	tx PikachuDescription2 ; description
	db NONE | HAS_EVOLUTION ; AI info

PikachuAltLv16Card:
	db TYPE_PKMN_LIGHTNING ; type
	dw $2ea9 ; gfx
	tx PikachuName ; name
	db PROMOSTAR ; rarity
	db PRO ; set
	db 7 ; ?
	dw PIKACHU_ALT_LV16
	db 60 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy COLORLESS, 1 ; energies
	tx Text1457 ; name
	tx Text152c ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db DAMAGE_NORMAL ; category
	dw $46d1 ; effect commands
	db NONE ; flags 1
	db NULLIFY_OR_WEAKEN_ATTACK  ; flags 2
	db NONE ; flags 3
	db 10 ; ?
	db ATK_ANIM_SUPERSONIC ; animation

	; attack 2
	energy LIGHTNING, 2 ; energies
	tx Text15c8 ; name
	tx Text1363 ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_NORMAL ; category
	dw $46d6 ; effect commands
	db INFLICT_PARALYSIS  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_THUNDERSHOCK ; animation

	db 1 ; retreat cost
	db WR_FIGHTING ; weakness
	db NONE ; resistance
	tx Text15c9 ; category
	db DEX_PIKACHU ; Pokedex number
	db FALSE ; is Dark
	db 16 ; level
	length 0.4 ; length
	weight 6.0 ; weight
	tx PikachuDescription2 ; description
	db NONE | HAS_EVOLUTION ; AI info

FlyingPikachuLv12Card:
	db TYPE_PKMN_LIGHTNING ; type
	dw $2f18 ; gfx
	tx FlyingPikachuName ; name
	db PROMOSTAR ; rarity
	db PRO ; set
	db 7 ; ?
	dw FLYING_PIKACHU_LV12
	db 40 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy LIGHTNING, 1 ; energies
	tx Text15c8 ; name
	tx Text1363 ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_NORMAL ; category
	dw $469a ; effect commands
	db INFLICT_PARALYSIS  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_THUNDERSHOCK ; animation

	; attack 2
	energy COLORLESS, 3 ; energies
	tx Text15d8 ; name
	tx Text15d9 ; description
	dw NONE ; description (cont)
	db 30 ; damage
	db DAMAGE_NORMAL ; category
	dw $469f ; effect commands
	db NONE ; flags 1
	db NULLIFY_OR_WEAKEN_ATTACK  ; flags 2
	db FLAG_3_BIT_2  ; flags 3
	db 0 ; ?
	db ATK_ANIM_QUICK_ATTACK ; animation

	db 1 ; retreat cost
	db NONE ; weakness
	db WR_FIGHTING ; resistance
	tx Text15c9 ; category
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
	db PRO ; set
	db 7 ; ?
	dw FLYING_PIKACHU_ALT_LV12
	db 40 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy LIGHTNING, 1 ; energies
	tx Text15c8 ; name
	tx Text1363 ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_NORMAL ; category
	dw $46a7 ; effect commands
	db INFLICT_PARALYSIS  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_THUNDERSHOCK ; animation

	; attack 2
	energy COLORLESS, 3 ; energies
	tx Text15d8 ; name
	tx Text15d9 ; description
	dw NONE ; description (cont)
	db 30 ; damage
	db DAMAGE_NORMAL ; category
	dw $46ac ; effect commands
	db NONE ; flags 1
	db NULLIFY_OR_WEAKEN_ATTACK  ; flags 2
	db FLAG_3_BIT_2  ; flags 3
	db 0 ; ?
	db ATK_ANIM_QUICK_ATTACK ; animation

	db 1 ; retreat cost
	db NONE ; weakness
	db WR_FIGHTING ; resistance
	tx Text15c9 ; category
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
	db PRO ; set
	db 7 ; ?
	dw SURFING_PIKACHU_LV13
	db 50 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy WATER, 2 ; energies
	tx Text14e5 ; name
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
	tx Text15c9 ; category
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
	db PRO ; set
	db 7 ; ?
	dw SURFING_PIKACHU_ALT_LV13
	db 50 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy WATER, 2 ; energies
	tx Text14e5 ; name
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
	tx Text15c9 ; category
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
	db SKY_FLYING_POKEMON ; set
	db 4 ; ?
	dw RAICHU_LV32
	db 70 ; hp
	db STAGE1 ; stage
	tx PikachuName ; pre-evo name

	; attack 1
	energy LIGHTNING, 2 ; energies
	tx Text15de ; name
	tx Text15df ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db RESIDUAL ; category
	dw $4de5 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db SPECIAL_AI_HANDLING | FLAG_3_BIT_2  ; flags 3
	db 0 ; ?
	db ATK_ANIM_THUNDERSHOCK ; animation

	; attack 2
	energy LIGHTNING, 2, COLORLESS, 1 ; energies
	tx Text15e0 ; name
	tx Text1363 ; description
	dw NONE ; description (cont)
	db 30 ; damage
	db DAMAGE_NORMAL ; category
	dw $4df6 ; effect commands
	db INFLICT_PARALYSIS  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_184 ; animation

	db 1 ; retreat cost
	db WR_FIGHTING ; weakness
	db NONE ; resistance
	tx Text15c9 ; category
	db DEX_RAICHU ; Pokedex number
	db FALSE ; is Dark
	db 32 ; level
	length 0.8 ; length
	weight 30.0 ; weight
	tx RaichuDescription1 ; description
	db NONE ; AI info

RaichuLv33Card:
	db TYPE_PKMN_LIGHTNING ; type
	dw $bf5a ; gfx
	tx RaichuName ; name
	db STAR ; rarity
	db TEAM_ROCKETS_AMBITION ; set
	db 0 ; ?
	dw RAICHU_LV33
	db 70 ; hp
	db STAGE1 ; stage
	tx PikachuName ; pre-evo name

	; attack 1
	energy COLORLESS, 2 ; energies
	tx Text1490 ; name
	tx Text15e2 ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_PLUS ; category
	dw $5279 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_QUICK_ATTACK ; animation

	; attack 2
	energy LIGHTNING, 3 ; energies
	tx Text15d1 ; name
	tx Text15e3 ; description
	dw NONE ; description (cont)
	db 60 ; damage
	db DAMAGE_NORMAL ; category
	dw $5281 ; effect commands
	db NONE ; flags 1
	db DISCARD_ENERGY  ; flags 2
	db NONE ; flags 3
	db 9 ; ?
	db ATK_ANIM_THUNDERBOLT ; animation

	db 1 ; retreat cost
	db WR_FIGHTING ; weakness
	db NONE ; resistance
	tx Text15c9 ; category
	db DEX_RAICHU ; Pokedex number
	db FALSE ; is Dark
	db 33 ; level
	length 0.8 ; length
	weight 30.0 ; weight
	tx RaichuDescription2 ; description
	db NONE ; AI info

RaichuLv40Card:
	db TYPE_PKMN_LIGHTNING ; type
	dw $311e ; gfx
	tx RaichuName ; name
	db STAR ; rarity
	db BEGINNING_POKEMON ; set
	db 3 ; ?
	dw RAICHU_LV40
	db 80 ; hp
	db STAGE1 ; stage
	tx PikachuName ; pre-evo name

	; attack 1
	energy LIGHTNING, 1, COLORLESS, 2 ; energies
	tx Text14ab ; name
	tx Text14ac ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_NORMAL ; category
	dw $46e0 ; effect commands
	db NONE ; flags 1
	db NULLIFY_OR_WEAKEN_ATTACK  ; flags 2
	db FLAG_3_BIT_2  ; flags 3
	db 0 ; ?
	db ATK_ANIM_QUICK_ATTACK ; animation

	; attack 2
	energy LIGHTNING, 3, COLORLESS, 1 ; energies
	tx Text15e5 ; name
	tx Text15e6 ; description
	dw NONE ; description (cont)
	db 60 ; damage
	db DAMAGE_NORMAL ; category
	dw $46e5 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_THUNDER ; animation

	db 1 ; retreat cost
	db WR_FIGHTING ; weakness
	db NONE ; resistance
	tx Text15c9 ; category
	db DEX_RAICHU ; Pokedex number
	db FALSE ; is Dark
	db 40 ; level
	length 0.8 ; length
	weight 30.0 ; weight
	tx RaichuDescription3 ; description
	db NONE ; AI info

RaichuLv45Card:
	db TYPE_PKMN_LIGHTNING ; type
	dw $3187 ; gfx
	tx RaichuName ; name
	db STAR ; rarity
	db ISLAND_OF_FOSSIL ; set
	db 2 ; ?
	dw RAICHU_LV45
	db 90 ; hp
	db STAGE1 ; stage
	tx PikachuName ; pre-evo name

	; attack 1
	energy LIGHTNING, 4 ; energies
	tx Text15e8 ; name
	tx Text15e9 ; description
	dw NONE ; description (cont)
	db 30 ; damage
	db DAMAGE_NORMAL ; category
	dw $46ed ; effect commands
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
	tx Text15c9 ; category
	db DEX_RAICHU ; Pokedex number
	db FALSE ; is Dark
	db 45 ; level
	length 0.8 ; length
	weight 30.0 ; weight
	tx RaichuDescription3 ; description
	db NONE ; AI info

DarkRaichuCard:
	db TYPE_PKMN_LIGHTNING ; type
	dw $c78d ; gfx
	tx DarkRaichuName ; name
	db STAR ; rarity
	db GB ; set
	db 6 ; ?
	dw DARK_RAICHU
	db 70 ; hp
	db STAGE1 ; stage
	tx PikachuName ; pre-evo name

	; attack 1
	energy LIGHTNING, 3 ; energies
	tx Text15eb ; name
	tx Text15ec ; description
	dw NONE ; description (cont)
	db 30 ; damage
	db DAMAGE_NORMAL ; category
	dw $5315 ; effect commands
	db DAMAGE_TO_OPPONENT_BENCH  ; flags 1
	db NONE ; flags 2
	db FLAG_3_BIT_2  ; flags 3
	db 0 ; ?
	db ATK_ANIM_252 ; animation

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
	tx Text15c9 ; category
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
	db PSYCHIC_BATTLE ; set
	db 5 ; ?
	dw MAGNEMITE_LV12
	db 40 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy COLORLESS, 2 ; energies
	tx Text1305 ; name
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
	tx Text15ef ; name
	tx Text15f0 ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_PLUS ; category
	dw $4b8a ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_THUNDER_WAVE ; animation

	db 1 ; retreat cost
	db WR_FIGHTING ; weakness
	db NONE ; resistance
	tx Text15f1 ; category
	db DEX_MAGNEMITE ; Pokedex number
	db FALSE ; is Dark
	db 12 ; level
	length 0.3 ; length
	weight 6.0 ; weight
	tx MagnemiteDescription1 ; description
	db NONE | HAS_EVOLUTION ; AI info

MagnemiteLv13Card:
	db TYPE_PKMN_LIGHTNING ; type
	dw $31f0 ; gfx
	tx MagnemiteName ; name
	db CIRCLE ; rarity
	db BEGINNING_POKEMON ; set
	db 3 ; ?
	dw MAGNEMITE_LV13
	db 40 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy LIGHTNING, 1 ; energies
	tx Text15f3 ; name
	tx Text132f ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_NORMAL ; category
	dw $466e ; effect commands
	db INFLICT_PARALYSIS  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_THUNDER_WAVE ; animation

	; attack 2
	energy LIGHTNING, 1, COLORLESS, 1 ; energies
	tx Text142f ; name
	tx Text15f4 ; description
	dw NONE ; description (cont)
	db 40 ; damage
	db DAMAGE_NORMAL ; category
	dw $4673 ; effect commands
	db HIGH_RECOIL  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 40 ; ?
	db ATK_ANIM_SELFDESTRUCT ; animation

	db 1 ; retreat cost
	db WR_FIGHTING ; weakness
	db NONE ; resistance
	tx Text15f1 ; category
	db DEX_MAGNEMITE ; Pokedex number
	db FALSE ; is Dark
	db 13 ; level
	length 0.3 ; length
	weight 6.0 ; weight
	tx MagnemiteDescription2 ; description
	db AI_INFO_UNK_03 | HAS_EVOLUTION ; AI info

MagnemiteLv14Card:
	db TYPE_PKMN_LIGHTNING ; type
	dw $3271 ; gfx
	tx MagnemiteName ; name
	db CIRCLE ; rarity
	db GB ; set
	db 1 ; ?
	dw MAGNEMITE_LV14
	db 40 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy COLORLESS, 1 ; energies
	tx Text1305 ; name
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
	tx Text15f6 ; name
	tx Text15f7 ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db RESIDUAL ; category
	dw $471c ; effect commands
	db NONE ; flags 1
	db FLAG_2_BIT_5  ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_MAGNETIC_STORM ; animation

	db 1 ; retreat cost
	db WR_FIGHTING ; weakness
	db NONE ; resistance
	tx Text15f1 ; category
	db DEX_MAGNEMITE ; Pokedex number
	db FALSE ; is Dark
	db 14 ; level
	length 0.3 ; length
	weight 6.0 ; weight
	tx MagnemiteDescription3 ; description
	db AI_INFO_UNK_03 | HAS_EVOLUTION ; AI info

MagnemiteLv15Card:
	db TYPE_PKMN_LIGHTNING ; type
	dw $8559 ; gfx
	tx MagnemiteName ; name
	db CIRCLE ; rarity
	db SKY_FLYING_POKEMON ; set
	db 4 ; ?
	dw MAGNEMITE_LV15
	db 40 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy 0 ; energies
	tx Text15f9 ; name
	tx Text15fa ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db POKEMON_POWER ; category
	dw $4e3d ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_GLOW_EFFECT ; animation

	; attack 2
	energy LIGHTNING, 1 ; energies
	tx Text15fb ; name
	tx Text15fc ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db RESIDUAL ; category
	dw $4e4b ; effect commands
	db DAMAGE_TO_OPPONENT_BENCH  ; flags 1
	db FLAG_2_BIT_6  ; flags 2
	db FLAG_3_BIT_2  ; flags 3
	db 0 ; ?
	db ATK_ANIM_THUNDER_WAVE ; animation

	db 1 ; retreat cost
	db WR_FIGHTING ; weakness
	db NONE ; resistance
	tx Text15f1 ; category
	db DEX_MAGNEMITE ; Pokedex number
	db FALSE ; is Dark
	db 15 ; level
	length 0.3 ; length
	weight 6.0 ; weight
	tx MagnemiteDescription4 ; description
	db NONE | HAS_EVOLUTION ; AI info

MagnetonLv28Card:
	db TYPE_PKMN_LIGHTNING ; type
	dw $32dc ; gfx
	tx MagnetonName ; name
	db STAR ; rarity
	db BEGINNING_POKEMON ; set
	db 3 ; ?
	dw MAGNETON_LV28
	db 60 ; hp
	db STAGE1 ; stage
	tx MagnemiteName ; pre-evo name

	; attack 1
	energy LIGHTNING, 2, COLORLESS, 1 ; energies
	tx Text15f3 ; name
	tx Text132f ; description
	dw NONE ; description (cont)
	db 30 ; damage
	db DAMAGE_NORMAL ; category
	dw $46f8 ; effect commands
	db INFLICT_PARALYSIS  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_THUNDER_WAVE ; animation

	; attack 2
	energy LIGHTNING, 2, COLORLESS, 2 ; energies
	tx Text142f ; name
	tx Text15ff ; description
	dw NONE ; description (cont)
	db 80 ; damage
	db DAMAGE_NORMAL ; category
	dw $46fd ; effect commands
	db HIGH_RECOIL  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 80 ; ?
	db ATK_ANIM_BIG_SELFDESTRUCTION ; animation

	db 1 ; retreat cost
	db WR_FIGHTING ; weakness
	db NONE ; resistance
	tx Text15f1 ; category
	db DEX_MAGNETON ; Pokedex number
	db FALSE ; is Dark
	db 28 ; level
	length 1.0 ; length
	weight 60.0 ; weight
	tx MagnetonDescription1 ; description
	db NONE ; AI info

MagnetonLv30Card:
	db TYPE_PKMN_LIGHTNING ; type
	dw $85c2 ; gfx
	tx MagnetonName ; name
	db STAR ; rarity
	db SKY_FLYING_POKEMON ; set
	db 1 ; ?
	dw MAGNETON_LV30
	db 70 ; hp
	db STAGE1 ; stage
	tx MagnemiteName ; pre-evo name

	; attack 1
	energy LIGHTNING, 2, COLORLESS, 1 ; energies
	tx Text1601 ; name
	tx Text1602 ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db RESIDUAL ; category
	dw $4e5c ; effect commands
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
	tx Text15f1 ; category
	db DEX_MAGNETON ; Pokedex number
	db FALSE ; is Dark
	db 30 ; level
	length 1.0 ; length
	weight 60.0 ; weight
	tx MagnetonDescription2 ; description
	db NONE ; AI info

MagnetonLv35Card:
	db TYPE_PKMN_LIGHTNING ; type
	dw $337d ; gfx
	tx MagnetonName ; name
	db STAR ; rarity
	db ISLAND_OF_FOSSIL ; set
	db 4 ; ?
	dw MAGNETON_LV35
	db 80 ; hp
	db STAGE1 ; stage
	tx MagnemiteName ; pre-evo name

	; attack 1
	energy LIGHTNING, 1, COLORLESS, 1 ; energies
	tx Text1604 ; name
	tx Text1605 ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_NORMAL ; category
	dw $4702 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_TEAR ; animation

	; attack 2
	energy LIGHTNING, 4 ; energies
	tx Text142f ; name
	tx Text1606 ; description
	dw NONE ; description (cont)
	db 100 ; damage
	db DAMAGE_NORMAL ; category
	dw $470a ; effect commands
	db HIGH_RECOIL  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 100 ; ?
	db ATK_ANIM_BIG_SELFDESTRUCTION ; animation

	db 2 ; retreat cost
	db WR_FIGHTING ; weakness
	db NONE ; resistance
	tx Text15f1 ; category
	db DEX_MAGNETON ; Pokedex number
	db FALSE ; is Dark
	db 35 ; level
	length 1.0 ; length
	weight 60.0 ; weight
	tx MagnetonDescription1 ; description
	db NONE ; AI info

DarkMagnetonCard:
	db TYPE_PKMN_LIGHTNING ; type
	dw $6f6d ; gfx
	tx DarkMagnetonName ; name
	db STAR ; rarity
	db PSYCHIC_BATTLE ; set
	db 5 ; ?
	dw DARK_MAGNETON
	db 60 ; hp
	db STAGE1 ; stage
	tx MagnemiteName ; pre-evo name

	; attack 1
	energy COLORLESS, 2 ; energies
	tx Text1604 ; name
	tx Text1608 ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_NORMAL ; category
	dw $4b92 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_TEAR ; animation

	; attack 2
	energy LIGHTNING, 2 ; energies
	tx Text1609 ; name
	tx Text160a ; description
	dw NONE ; description (cont)
	db 30 ; damage
	db DAMAGE_NORMAL ; category
	dw $4b9a ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db SPECIAL_AI_HANDLING  ; flags 3
	db 0 ; ?
	db ATK_ANIM_THUNDER_WAVE ; animation

	db 2 ; retreat cost
	db WR_FIGHTING ; weakness
	db NONE ; resistance
	tx Text15f1 ; category
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
	db SKY_FLYING_POKEMON ; set
	db 4 ; ?
	dw VOLTORB_LV8
	db 30 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy LIGHTNING, 1 ; energies
	tx Text15c8 ; name
	tx Text1363 ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_NORMAL ; category
	dw $4e9e ; effect commands
	db INFLICT_PARALYSIS  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_9 ; animation

	; attack 2
	energy LIGHTNING, 2 ; energies
	tx Text160d ; name
	tx Text160e ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_PLUS ; category
	dw $4ea3 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_THUNDER_WHOLE_SCREEN ; animation

	db 0 ; retreat cost
	db WR_FIGHTING ; weakness
	db NONE ; resistance
	tx Text160f ; category
	db DEX_VOLTORB ; Pokedex number
	db FALSE ; is Dark
	db 8 ; level
	length 0.5 ; length
	weight 10.4 ; weight
	tx VoltorbDescription1 ; description
	db NONE | HAS_EVOLUTION ; AI info

VoltorbLv10Card:
	db TYPE_PKMN_LIGHTNING ; type
	dw $33e6 ; gfx
	tx VoltorbName ; name
	db CIRCLE ; rarity
	db BEGINNING_POKEMON ; set
	db 2 ; ?
	dw VOLTORB_LV10
	db 40 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy COLORLESS, 1 ; energies
	tx Text1305 ; name
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
	tx Text160f ; category
	db DEX_VOLTORB ; Pokedex number
	db FALSE ; is Dark
	db 10 ; level
	length 0.5 ; length
	weight 10.4 ; weight
	tx VoltorbDescription2 ; description
	db AI_INFO_UNK_05 | HAS_EVOLUTION ; AI info

VoltorbLv13Card:
	db TYPE_PKMN_LIGHTNING ; type
	dw $7000 ; gfx
	tx VoltorbName ; name
	db CIRCLE ; rarity
	db PSYCHIC_BATTLE ; set
	db 5 ; ?
	dw VOLTORB_LV13
	db 40 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy LIGHTNING, 1 ; energies
	tx Text1612 ; name
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
	tx Text160f ; category
	db DEX_VOLTORB ; Pokedex number
	db FALSE ; is Dark
	db 13 ; level
	length 0.5 ; length
	weight 10.4 ; weight
	tx VoltorbDescription3 ; description
	db NONE | HAS_EVOLUTION ; AI info

ElectrodeLv35Card:
	db TYPE_PKMN_LIGHTNING ; type
	dw $3487 ; gfx
	tx ElectrodeName ; name
	db STAR ; rarity
	db GB ; set
	db 2 ; ?
	dw ELECTRODE_LV35
	db 70 ; hp
	db STAGE1 ; stage
	tx VoltorbName ; pre-evo name

	; attack 1
	energy LIGHTNING, 2 ; energies
	tx Text1604 ; name
	tx Text1605 ; description
	dw NONE ; description (cont)
	db 30 ; damage
	db DAMAGE_NORMAL ; category
	dw $4721 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_TEAR ; animation

	; attack 2
	energy LIGHTNING, 3 ; energies
	tx Text1615 ; name
	tx Text1616 ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db RESIDUAL ; category
	dw $4729 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db SPECIAL_AI_HANDLING | FLAG_3_BIT_2  ; flags 3
	db 0 ; ?
	db ATK_ANIM_GLOW_EFFECT ; animation

	db 1 ; retreat cost
	db WR_FIGHTING ; weakness
	db NONE ; resistance
	tx Text160f ; category
	db DEX_ELECTRODE ; Pokedex number
	db FALSE ; is Dark
	db 35 ; level
	length 1.2 ; length
	weight 66.6 ; weight
	tx ElectrodeDescription1 ; description
	db NONE ; AI info

ElectrodeLv42Card:
	db TYPE_PKMN_LIGHTNING ; type
	dw $34f0 ; gfx
	tx ElectrodeName ; name
	db STAR ; rarity
	db LEGENDARY_POWER ; set
	db 4 ; ?
	dw ELECTRODE_LV42
	db 90 ; hp
	db STAGE1 ; stage
	tx VoltorbName ; pre-evo name

	; attack 1
	energy COLORLESS, 2 ; energies
	tx Text1305 ; name
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
	tx Text1618 ; name
	tx Text1619 ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_NORMAL ; category
	dw $46db ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db SPECIAL_AI_HANDLING | FLAG_3_BIT_2  ; flags 3
	db 0 ; ?
	db ATK_ANIM_CHAIN_LIGHTNING ; animation

	db 1 ; retreat cost
	db WR_FIGHTING ; weakness
	db NONE ; resistance
	tx Text160f ; category
	db DEX_ELECTRODE ; Pokedex number
	db FALSE ; is Dark
	db 42 ; level
	length 1.2 ; length
	weight 66.6 ; weight
	tx ElectrodeDescription2 ; description
	db NONE ; AI info

DarkElectrodeCard:
	db TYPE_PKMN_LIGHTNING ; type
	dw $7069 ; gfx
	tx DarkElectrodeName ; name
	db DIAMOND ; rarity
	db PSYCHIC_BATTLE ; set
	db 5 ; ?
	dw DARK_ELECTRODE
	db 60 ; hp
	db STAGE1 ; stage
	tx VoltorbName ; pre-evo name

	; attack 1
	energy COLORLESS, 1 ; energies
	tx Text15ab ; name
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
	tx Text161c ; name
	tx Text161d ; description
	dw NONE ; description (cont)
	db 30 ; damage
	db DAMAGE_NORMAL ; category
	dw $4ba5 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db SPECIAL_AI_HANDLING  ; flags 3
	db 0 ; ?
	db ATK_ANIM_HIT ; animation

	db 1 ; retreat cost
	db WR_FIGHTING ; weakness
	db NONE ; resistance
	tx Text160f ; category
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
	db PRO ; set
	db 7 ; ?
	dw ELECTABUZZ_LV20
	db 60 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy LIGHTNING, 1 ; energies
	tx Text1620 ; name
	tx Text1621 ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db RESIDUAL ; category
	dw $4661 ; effect commands
	db NONE ; flags 1
	db NULLIFY_OR_WEAKEN_ATTACK  ; flags 2
	db FLAG_3_BIT_2  ; flags 3
	db 0 ; ?
	db ATK_ANIM_BARRIER ; animation

	; attack 2
	energy COLORLESS, 2 ; energies
	tx Text1490 ; name
	tx Text15e2 ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_PLUS ; category
	dw $4666 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_QUICK_ATTACK ; animation

	db 2 ; retreat cost
	db WR_FIGHTING ; weakness
	db NONE ; resistance
	tx Text15cc ; category
	db DEX_ELECTABUZZ ; Pokedex number
	db FALSE ; is Dark
	db 20 ; level
	length 1.1 ; length
	weight 30.0 ; weight
	tx ElectabuzzDescription1 ; description
	db NONE ; AI info

ElectabuzzLv30Card:
	db TYPE_PKMN_LIGHTNING ; type
	dw $c20d ; gfx
	tx ElectabuzzName ; name
	db STAR ; rarity
	db TEAM_ROCKETS_AMBITION ; set
	db 0 ; ?
	dw ELECTABUZZ_LV30
	db 70 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy LIGHTNING, 2, COLORLESS, 1 ; energies
	tx Text15c8 ; name
	tx Text1363 ; description
	dw NONE ; description (cont)
	db 30 ; damage
	db DAMAGE_NORMAL ; category
	dw $5286 ; effect commands
	db INFLICT_PARALYSIS  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_9 ; animation

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
	tx Text15cc ; category
	db DEX_ELECTABUZZ ; Pokedex number
	db FALSE ; is Dark
	db 30 ; level
	length 1.1 ; length
	weight 30.0 ; weight
	tx ElectabuzzDescription2 ; description
	db NONE ; AI info

ElectabuzzLv35Card:
	db TYPE_PKMN_LIGHTNING ; type
	dw $35c2 ; gfx
	tx ElectabuzzName ; name
	db STAR ; rarity
	db BEGINNING_POKEMON ; set
	db 1 ; ?
	dw ELECTABUZZ_LV35
	db 70 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy LIGHTNING, 1 ; energies
	tx Text15c8 ; name
	tx Text132f ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_NORMAL ; category
	dw $4651 ; effect commands
	db INFLICT_PARALYSIS  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_THUNDERSHOCK ; animation

	; attack 2
	energy LIGHTNING, 1, COLORLESS, 1 ; energies
	tx Text1624 ; name
	tx Text1625 ; description
	dw NONE ; description (cont)
	db 30 ; damage
	db DAMAGE_PLUS ; category
	dw $4656 ; effect commands
	db LOW_RECOIL  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_THUNDERPUNCH ; animation

	db 2 ; retreat cost
	db WR_FIGHTING ; weakness
	db NONE ; resistance
	tx Text15cc ; category
	db DEX_ELECTABUZZ ; Pokedex number
	db FALSE ; is Dark
	db 35 ; level
	length 1.1 ; length
	weight 30.0 ; weight
	tx ElectabuzzDescription3 ; description
	db NONE ; AI info

JolteonLv24Card:
	db TYPE_PKMN_LIGHTNING ; type
	dw $3633 ; gfx
	tx JolteonName ; name
	db DIAMOND ; rarity
	db GB ; set
	db 3 ; ?
	dw JOLTEON_LV24
	db 60 ; hp
	db STAGE1 ; stage
	tx EeveeName ; pre-evo name

	; attack 1
	energy COLORLESS, 2 ; energies
	tx Text137d ; name
	tx Text1628 ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_X ; category
	dw $4737 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_182 ; animation

	; attack 2
	energy COLORLESS, 4 ; energies
	tx Text1629 ; name
	tx Text132f ; description
	dw NONE ; description (cont)
	db 30 ; damage
	db DAMAGE_NORMAL ; category
	dw $473f ; effect commands
	db INFLICT_PARALYSIS  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_NEEDLES ; animation

	db 1 ; retreat cost
	db WR_FIGHTING ; weakness
	db NONE ; resistance
	tx Text15e5 ; category
	db DEX_JOLTEON ; Pokedex number
	db FALSE ; is Dark
	db 24 ; level
	length 0.8 ; length
	weight 24.5 ; weight
	tx JolteonDescription1 ; description
	db NONE ; AI info

JolteonLv29Card:
	db TYPE_PKMN_LIGHTNING ; type
	dw $369c ; gfx
	tx JolteonName ; name
	db STAR ; rarity
	db LEGENDARY_POWER ; set
	db 1 ; ?
	dw JOLTEON_LV29
	db 70 ; hp
	db STAGE1 ; stage
	tx EeveeName ; pre-evo name

	; attack 1
	energy COLORLESS, 2 ; energies
	tx Text1490 ; name
	tx Text162b ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_PLUS ; category
	dw $468a ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_QUICK_ATTACK ; animation

	; attack 2
	energy LIGHTNING, 2, COLORLESS, 1 ; energies
	tx Text162c ; name
	tx Text162d ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_X ; category
	dw $4692 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_NEEDLES ; animation

	db 1 ; retreat cost
	db WR_FIGHTING ; weakness
	db NONE ; resistance
	tx Text15e5 ; category
	db DEX_JOLTEON ; Pokedex number
	db FALSE ; is Dark
	db 29 ; level
	length 0.8 ; length
	weight 24.5 ; weight
	tx JolteonDescription2 ; description
	db NONE ; AI info

DarkJolteonCard:
	db TYPE_PKMN_LIGHTNING ; type
	dw $70d2 ; gfx
	tx DarkJolteonName ; name
	db DIAMOND ; rarity
	db PSYCHIC_BATTLE ; set
	db 5 ; ?
	dw DARK_JOLTEON
	db 50 ; hp
	db STAGE1 ; stage
	tx EeveeName ; pre-evo name

	; attack 1
	energy LIGHTNING, 1 ; energies
	tx Text1630 ; name
	tx Text1631 ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_NORMAL ; category
	dw $4bb0 ; effect commands
	db NONE ; flags 1
	db NULLIFY_OR_WEAKEN_ATTACK  ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_154 ; animation

	; attack 2
	energy LIGHTNING, 2, COLORLESS, 1 ; energies
	tx Text1632 ; name
	tx Text1633 ; description
	dw NONE ; description (cont)
	db 30 ; damage
	db DAMAGE_NORMAL ; category
	dw $4bb5 ; effect commands
	db INFLICT_PARALYSIS  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_9 ; animation

	db 1 ; retreat cost
	db WR_FIGHTING ; weakness
	db NONE ; resistance
	tx Text15e5 ; category
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
	db SKY_FLYING_POKEMON ; set
	db 6 ; ?
	dw ZAPDOS_LV28
	db 70 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy LIGHTNING, 3 ; energies
	tx Text1636 ; name
	tx Text1637 ; description
	dw NONE ; description (cont)
	db 50 ; damage
	db DAMAGE_NORMAL ; category
	dw $4f04 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db SPECIAL_AI_HANDLING | FLAG_3_BIT_2  ; flags 3
	db 0 ; ?
	db ATK_ANIM_THUNDERBOLT ; animation

	; attack 2
	energy LIGHTNING, 2, COLORLESS, 2 ; energies
	tx Text1638 ; name
	tx Text1639 ; description
	dw NONE ; description (cont)
	db 50 ; damage
	db DAMAGE_PLUS ; category
	dw $4f12 ; effect commands
	db LOW_RECOIL  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_THUNDERBOLT ; animation

	db 2 ; retreat cost
	db NONE ; weakness
	db WR_FIGHTING ; resistance
	tx Text15cc ; category
	db DEX_ZAPDOS ; Pokedex number
	db FALSE ; is Dark
	db 28 ; level
	length 1.6 ; length
	weight 52.6 ; weight
	tx ZapdosDescription1 ; description
	db NONE ; AI info

ZapdosLv40Card:
	db TYPE_PKMN_LIGHTNING ; type
	dw $3705 ; gfx
	tx ZapdosName ; name
	db STAR ; rarity
	db ISLAND_OF_FOSSIL ; set
	db 4 ; ?
	dw ZAPDOS_LV40
	db 80 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy LIGHTNING, 4 ; energies
	tx Text163b ; name
	tx Text163c ; description
	dw NONE ; description (cont)
	db 40 ; damage
	db DAMAGE_NORMAL ; category
	dw $4685 ; effect commands
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
	tx Text15cc ; category
	db DEX_ZAPDOS ; Pokedex number
	db FALSE ; is Dark
	db 40 ; level
	length 1.6 ; length
	weight 52.6 ; weight
	tx ZapdosDescription2 ; description
	db NONE ; AI info

ZapdosLv64Card:
	db TYPE_PKMN_LIGHTNING ; type
	dw $376e ; gfx
	tx ZapdosName ; name
	db STAR ; rarity
	db BEGINNING_POKEMON ; set
	db 0 ; ?
	dw ZAPDOS_LV64
	db 90 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy LIGHTNING, 3, COLORLESS, 1 ; energies
	tx Text15e5 ; name
	tx Text15e6 ; description
	dw NONE ; description (cont)
	db 60 ; damage
	db DAMAGE_NORMAL ; category
	dw $4678 ; effect commands
	db LOW_RECOIL  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_THUNDER ; animation

	; attack 2
	energy LIGHTNING, 4 ; energies
	tx Text15d1 ; name
	tx Text163e ; description
	dw NONE ; description (cont)
	db 100 ; damage
	db DAMAGE_NORMAL ; category
	dw $4680 ; effect commands
	db NONE ; flags 1
	db DISCARD_ENERGY  ; flags 2
	db NONE ; flags 3
	db 9 ; ?
	db ATK_ANIM_THUNDERBOLT ; animation

	db 3 ; retreat cost
	db NONE ; weakness
	db WR_FIGHTING ; resistance
	tx Text15cc ; category
	db DEX_ZAPDOS ; Pokedex number
	db FALSE ; is Dark
	db 64 ; level
	length 1.6 ; length
	weight 52.6 ; weight
	tx ZapdosDescription3 ; description
	db NONE ; AI info

ZapdosLv68Card:
	db TYPE_PKMN_LIGHTNING ; type
	dw $3800 ; gfx
	tx ZapdosName ; name
	db STAR ; rarity
	db GB ; set
	db 7 ; ?
	dw ZAPDOS_LV68
	db 100 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy 0 ; energies
	tx Text1640 ; name
	tx Text1641 ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db POKEMON_POWER ; category
	dw $470f ; effect commands
	db DAMAGE_TO_OPPONENT_BENCH  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_PEAL_OF_THUNDER ; animation

	; attack 2
	energy LIGHTNING, 3 ; energies
	tx Text1642 ; name
	tx Text1643 ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db RESIDUAL ; category
	dw $4717 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db SPECIAL_AI_HANDLING | FLAG_3_BIT_2  ; flags 3
	db 0 ; ?
	db ATK_ANIM_BIG_THUNDER ; animation

	db 2 ; retreat cost
	db NONE ; weakness
	db WR_FIGHTING ; resistance
	tx Text15cc ; category
	db DEX_ZAPDOS ; Pokedex number
	db FALSE ; is Dark
	db 68 ; level
	length 1.6 ; length
	weight 52.6 ; weight
	tx ZapdosDescription4 ; description
	db NONE ; AI info

SandshrewLv12Card:
	db TYPE_PKMN_FIGHTING ; type
	dw $3869 ; gfx
	tx SandshrewName ; name
	db CIRCLE ; rarity
	db BEGINNING_POKEMON ; set
	db 1 ; ?
	dw SANDSHREW_LV12
	db 40 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy FIGHTING, 1 ; energies
	tx Text1646 ; name
	tx Text14bd ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_NORMAL ; category
	dw $4625 ; effect commands
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
	tx Text15c9 ; category
	db DEX_SANDSHREW ; Pokedex number
	db FALSE ; is Dark
	db 12 ; level
	length 0.6 ; length
	weight 12.0 ; weight
	tx SandshrewDescription1 ; description
	db AI_INFO_UNK_03 | HAS_EVOLUTION ; AI info

SandshrewLv15Card:
	db TYPE_PKMN_FIGHTING ; type
	dw $82cc ; gfx
	tx SandshrewName ; name
	db CIRCLE ; rarity
	db SKY_FLYING_POKEMON ; set
	db 4 ; ?
	dw SANDSHREW_LV15
	db 40 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy FIGHTING, 1 ; energies
	tx Text1343 ; name
	tx Text135b ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_NORMAL ; category
	dw $4dfb ; effect commands
	db INFLICT_POISON  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_49 ; animation

	; attack 2
	energy FIGHTING, 1 ; energies
	tx Text1648 ; name
	tx Text1649 ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_NORMAL ; category
	dw $4e03 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db FLAG_3_BIT_2  ; flags 3
	db 0 ; ?
	db ATK_ANIM_219 ; animation

	db 1 ; retreat cost
	db WR_GRASS ; weakness
	db WR_LIGHTNING ; resistance
	tx Text15c9 ; category
	db DEX_SANDSHREW ; Pokedex number
	db FALSE ; is Dark
	db 15 ; level
	length 0.6 ; length
	weight 12.0 ; weight
	tx SandshrewDescription2 ; description
	db NONE | HAS_EVOLUTION ; AI info

SandslashLv33Card:
	db TYPE_PKMN_FIGHTING ; type
	dw $38ea ; gfx
	tx SandslashName ; name
	db DIAMOND ; rarity
	db ISLAND_OF_FOSSIL ; set
	db 1 ; ?
	dw SANDSLASH_LV33
	db 70 ; hp
	db STAGE1 ; stage
	tx SandshrewName ; pre-evo name

	; attack 1
	energy COLORLESS, 2 ; energies
	tx Text13d6 ; name
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
	tx Text1371 ; name
	tx Text164c ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_X ; category
	dw $462a ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_MULTIPLE_SLASH ; animation

	db 1 ; retreat cost
	db WR_GRASS ; weakness
	db WR_LIGHTNING ; resistance
	tx Text15c9 ; category
	db DEX_SANDSLASH ; Pokedex number
	db FALSE ; is Dark
	db 33 ; level
	length 1.0 ; length
	weight 29.5 ; weight
	tx SandslashDescription1 ; description
	db NONE ; AI info

SandslashLv35Card:
	db TYPE_PKMN_FIGHTING ; type
	dw $8e18 ; gfx
	tx SandslashName ; name
	db DIAMOND ; rarity
	db SKY_FLYING_POKEMON ; set
	db 4 ; ?
	dw SANDSLASH_LV35
	db 70 ; hp
	db STAGE1 ; stage
	tx SandshrewName ; pre-evo name

	; attack 1
	energy FIGHTING, 1 ; energies
	tx Text164e ; name
	tx Text133a ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db RESIDUAL ; category
	dw $4f4e ; effect commands
	db NONE ; flags 1
	db NULLIFY_OR_WEAKEN_ATTACK  ; flags 2
	db FLAG_3_BIT_2  ; flags 3
	db 0 ; ?
	db ATK_ANIM_236 ; animation

	; attack 2
	energy FIGHTING, 3 ; energies
	tx Text164f ; name
	tx Text1650 ; description
	dw NONE ; description (cont)
	db 40 ; damage
	db DAMAGE_PLUS ; category
	dw $4f53 ; effect commands
	db LOW_RECOIL  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_HIT ; animation

	db 1 ; retreat cost
	db WR_GRASS ; weakness
	db WR_LIGHTNING ; resistance
	tx Text15c9 ; category
	db DEX_SANDSLASH ; Pokedex number
	db FALSE ; is Dark
	db 35 ; level
	length 1.0 ; length
	weight 29.5 ; weight
	tx SandslashDescription2 ; description
	db NONE ; AI info

DiglettLv8Card:
	db TYPE_PKMN_FIGHTING ; type
	dw $3961 ; gfx
	tx DiglettName ; name
	db CIRCLE ; rarity
	db BEGINNING_POKEMON ; set
	db 0 ; ?
	dw DIGLETT_LV8
	db 30 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy FIGHTING, 1 ; energies
	tx Text1653 ; name
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
	tx Text1654 ; name
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
	tx Text1655 ; category
	db DEX_DIGLETT ; Pokedex number
	db FALSE ; is Dark
	db 8 ; level
	length 0.2 ; length
	weight 0.8 ; weight
	tx DiglettDescription1 ; description
	db AI_INFO_UNK_03 | HAS_EVOLUTION ; AI info

DiglettLv15Card:
	db TYPE_PKMN_FIGHTING ; type
	dw $6800 ; gfx
	tx DiglettName ; name
	db CIRCLE ; rarity
	db PSYCHIC_BATTLE ; set
	db 5 ; ?
	dw DIGLETT_LV15
	db 40 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy FIGHTING, 1 ; energies
	tx Text1657 ; name
	tx Text1658 ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db RESIDUAL ; category
	dw $4aa6 ; effect commands
	db DAMAGE_TO_OPPONENT_BENCH  ; flags 1
	db FLAG_2_BIT_6  ; flags 2
	db FLAG_3_BIT_2  ; flags 3
	db 0 ; ?
	db ATK_ANIM_HIT ; animation

	; attack 2
	energy FIGHTING, 1, COLORLESS, 1 ; energies
	tx Text13ce ; name
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
	tx Text1655 ; category
	db DEX_DIGLETT ; Pokedex number
	db FALSE ; is Dark
	db 15 ; level
	length 0.2 ; length
	weight 0.8 ; weight
	tx DiglettDescription2 ; description
	db NONE | HAS_EVOLUTION ; AI info

DiglettLv16Card:
	db TYPE_PKMN_FIGHTING ; type
	dw $a221 ; gfx
	tx DiglettName ; name
	db PROMOSTAR ; rarity
	db PRO ; set
	db 7 ; ?
	dw DIGLETT_LV16
	db 50 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy COLORLESS, 1 ; energies
	tx Text1347 ; name
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
	tx Text165a ; name
	tx Text1448 ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_PLUS ; category
	dw $520c ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_HIT ; animation

	db 1 ; retreat cost
	db WR_GRASS ; weakness
	db WR_LIGHTNING ; resistance
	tx Text1655 ; category
	db DEX_DIGLETT ; Pokedex number
	db FALSE ; is Dark
	db 16 ; level
	length 0.2 ; length
	weight 0.8 ; weight
	tx DiglettDescription3 ; description
	db NONE | HAS_EVOLUTION ; AI info

DugtrioLv36Card:
	db TYPE_PKMN_FIGHTING ; type
	dw $39ca ; gfx
	tx DugtrioName ; name
	db STAR ; rarity
	db BEGINNING_POKEMON ; set
	db 0 ; ?
	dw DUGTRIO_LV36
	db 70 ; hp
	db STAGE1 ; stage
	tx DiglettName ; pre-evo name

	; attack 1
	energy FIGHTING, 2, COLORLESS, 1 ; energies
	tx Text13d6 ; name
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
	tx Text165d ; name
	tx Text165e ; description
	dw NONE ; description (cont)
	db 70 ; damage
	db DAMAGE_NORMAL ; category
	dw $4632 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db SPECIAL_AI_HANDLING  ; flags 3
	db 0 ; ?
	db ATK_ANIM_HIT ; animation

	db 2 ; retreat cost
	db WR_GRASS ; weakness
	db WR_LIGHTNING ; resistance
	tx Text1655 ; category
	db DEX_DUGTRIO ; Pokedex number
	db FALSE ; is Dark
	db 36 ; level
	length 0.7 ; length
	weight 33.3 ; weight
	tx DugtrioDescription1 ; description
	db NONE ; AI info

DugtrioLv40Card:
	db TYPE_PKMN_FIGHTING ; type
	dw $a298 ; gfx
	tx DugtrioName ; name
	db PROMOSTAR ; rarity
	db PRO ; set
	db 7 ; ?
	dw DUGTRIO_LV40
	db 80 ; hp
	db STAGE1 ; stage
	tx DiglettName ; pre-evo name

	; attack 1
	energy 0 ; energies
	tx Text1660 ; name
	tx Text1661 ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db POKEMON_POWER ; category
	dw $5214 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_NONE ; animation

	; attack 2
	energy FIGHTING, 3 ; energies
	tx Text1662 ; name
	tx Text1663 ; description
	dw NONE ; description (cont)
	db 30 ; damage
	db DAMAGE_NORMAL ; category
	dw $5219 ; effect commands
	db DAMAGE_TO_OPPONENT_BENCH  ; flags 1
	db NONE ; flags 2
	db FLAG_3_BIT_2  ; flags 3
	db 0 ; ?
	db ATK_ANIM_HIT ; animation

	db 2 ; retreat cost
	db WR_GRASS ; weakness
	db WR_LIGHTNING ; resistance
	tx Text1655 ; category
	db DEX_DUGTRIO ; Pokedex number
	db FALSE ; is Dark
	db 40 ; level
	length 0.7 ; length
	weight 33.3 ; weight
	tx DugtrioDescription2 ; description
	db NONE ; AI info

DarkDugtrioCard:
	db TYPE_PKMN_FIGHTING ; type
	dw $686d ; gfx
	tx DarkDugtrioName ; name
	db STAR ; rarity
	db PSYCHIC_BATTLE ; set
	db 5 ; ?
	dw DARK_DUGTRIO
	db 50 ; hp
	db STAGE1 ; stage
	tx DiglettName ; pre-evo name

	; attack 1
	energy 0 ; energies
	tx Text1666 ; name
	tx Text1667 ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db POKEMON_POWER ; category
	dw $4ab7 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_NONE ; animation

	; attack 2
	energy FIGHTING, 2 ; energies
	tx Text1668 ; name
	tx Text1669 ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_PLUS ; category
	dw $4abc ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_HIT ; animation

	db 2 ; retreat cost
	db WR_GRASS ; weakness
	db WR_LIGHTNING ; resistance
	tx Text1655 ; category
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
	db LEGENDARY_POWER ; set
	db 2 ; ?
	dw MANKEY_LV7
	db 30 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy 0 ; energies
	tx Text166c ; name
	tx Text166d ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db POKEMON_POWER ; category
	dw $463c ; effect commands
	db NONE ; flags 1
	db FLAG_2_BIT_5  ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_PKMN_POWER_1 ; animation

	; attack 2
	energy COLORLESS, 1 ; energies
	tx Text13ce ; name
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
	tx Text166e ; category
	db DEX_MANKEY ; Pokedex number
	db FALSE ; is Dark
	db 7 ; level
	length 0.5 ; length
	weight 28.0 ; weight
	tx MankeyDescription1 ; description
	db AI_INFO_BENCH_UTILITY | HAS_EVOLUTION ; AI info

MankeyAltLv7Card:
	db TYPE_PKMN_FIGHTING ; type
	dw $a687 ; gfx
	tx MankeyName ; name
	db PROMOSTAR ; rarity
	db PRO ; set
	db 7 ; ?
	dw MANKEY_ALT_LV7
	db 30 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy 0 ; energies
	tx Text166c ; name
	tx Text166d ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db POKEMON_POWER ; category
	dw $525f ; effect commands
	db NONE ; flags 1
	db FLAG_2_BIT_5  ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_PKMN_POWER_1 ; animation

	; attack 2
	energy COLORLESS, 1 ; energies
	tx Text13ce ; name
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
	tx Text166e ; category
	db DEX_MANKEY ; Pokedex number
	db FALSE ; is Dark
	db 7 ; level
	length 0.5 ; length
	weight 28.0 ; weight
	tx MankeyDescription1 ; description
	db AI_INFO_BENCH_UTILITY | HAS_EVOLUTION ; AI info

MankeyLv14Card:
	db TYPE_PKMN_FIGHTING ; type
	dw $68d6 ; gfx
	tx MankeyName ; name
	db CIRCLE ; rarity
	db PSYCHIC_BATTLE ; set
	db 5 ; ?
	dw MANKEY_LV14
	db 40 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy COLORLESS, 1 ; energies
	tx Text1670 ; name
	tx Text1671 ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db RESIDUAL ; category
	dw $4ac4 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db SPECIAL_AI_HANDLING | FLAG_3_BIT_2  ; flags 3
	db 0 ; ?
	db ATK_ANIM_GLOW_EFFECT ; animation

	; attack 2
	energy FIGHTING, 1, COLORLESS, 1 ; energies
	tx Text1672 ; name
	tx Text15e2 ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_PLUS ; category
	dw $4acc ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_HIT ; animation

	db 0 ; retreat cost
	db WR_PSYCHIC ; weakness
	db NONE ; resistance
	tx Text166e ; category
	db DEX_MANKEY ; Pokedex number
	db FALSE ; is Dark
	db 14 ; level
	length 0.5 ; length
	weight 28.0 ; weight
	tx MankeyDescription2 ; description
	db NONE | HAS_EVOLUTION ; AI info

PrimeapeCard:
	db TYPE_PKMN_FIGHTING ; type
	dw $3aa8 ; gfx
	tx PrimeapeName ; name
	db DIAMOND ; rarity
	db LEGENDARY_POWER ; set
	db 2 ; ?
	dw PRIMEAPE
	db 70 ; hp
	db STAGE1 ; stage
	tx MankeyName ; pre-evo name

	; attack 1
	energy FIGHTING, 2 ; energies
	tx Text1371 ; name
	tx Text164c ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_X ; category
	dw $45b1 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_MULTIPLE_SLASH ; animation

	; attack 2
	energy FIGHTING, 2, COLORLESS, 1 ; energies
	tx Text1675 ; name
	tx Text1676 ; description
	dw NONE ; description (cont)
	db 50 ; damage
	db DAMAGE_NORMAL ; category
	dw $45b9 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_RAMPAGE ; animation

	db 1 ; retreat cost
	db WR_PSYCHIC ; weakness
	db NONE ; resistance
	tx Text166e ; category
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
	db PSYCHIC_BATTLE ; set
	db 5 ; ?
	dw DARK_PRIMEAPE
	db 60 ; hp
	db STAGE1 ; stage
	tx MankeyName ; pre-evo name

	; attack 1
	energy 0 ; energies
	tx Text1679 ; name
	tx Text167a ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db POKEMON_POWER ; category
	dw $4ad4 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_NONE ; animation

	; attack 2
	energy FIGHTING, 2 ; energies
	tx Text167b ; name
	tx Text167c ; description
	dw NONE ; description (cont)
	db 40 ; damage
	db DAMAGE_NORMAL ; category
	dw $4ad9 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_RAMPAGE ; animation

	db 1 ; retreat cost
	db WR_PSYCHIC ; weakness
	db NONE ; resistance
	tx Text166e ; category
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
	db SKY_FLYING_POKEMON ; set
	db 4 ; ?
	dw MACHOP_LV18
	db 50 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy COLORLESS, 1 ; energies
	tx Text167f ; name
	tx Text1680 ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db RESIDUAL ; category
	dw $4e1e ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db SPECIAL_AI_HANDLING | FLAG_3_BIT_2  ; flags 3
	db 0 ; ?
	db ATK_ANIM_GLOW_EFFECT ; animation

	; attack 2
	energy FIGHTING, 1, COLORLESS, 1 ; energies
	tx Text1681 ; name
	dw NONE ; description
	dw NONE ; description (cont)
	db 30 ; damage
	db DAMAGE_NORMAL ; category
	dw $4e23 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_HIT ; animation

	db 1 ; retreat cost
	db WR_PSYCHIC ; weakness
	db NONE ; resistance
	tx Text1682 ; category
	db DEX_MACHOP ; Pokedex number
	db FALSE ; is Dark
	db 18 ; level
	length 0.8 ; length
	weight 19.5 ; weight
	tx MachopDescription1 ; description
	db NONE | HAS_EVOLUTION ; AI info

MachopLv20Card:
	db TYPE_PKMN_FIGHTING ; type
	dw $3b11 ; gfx
	tx MachopName ; name
	db CIRCLE ; rarity
	db BEGINNING_POKEMON ; set
	db 0 ; ?
	dw MACHOP_LV20
	db 50 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy FIGHTING, 1 ; energies
	tx Text1684 ; name
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
	tx Text1682 ; category
	db DEX_MACHOP ; Pokedex number
	db FALSE ; is Dark
	db 20 ; level
	length 0.8 ; length
	weight 19.5 ; weight
	tx MachopDescription2 ; description
	db AI_INFO_UNK_05 | HAS_EVOLUTION ; AI info

MachopLv24Card:
	db TYPE_PKMN_FIGHTING ; type
	dw $69d2 ; gfx
	tx MachopName ; name
	db CIRCLE ; rarity
	db PSYCHIC_BATTLE ; set
	db 5 ; ?
	dw MACHOP_LV24
	db 50 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy COLORLESS, 2 ; energies
	tx Text1686 ; name
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
	tx Text1687 ; name
	dw NONE ; description
	dw NONE ; description (cont)
	db 30 ; damage
	db DAMAGE_NORMAL ; category
	dw NONE ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_182 ; animation

	db 1 ; retreat cost
	db WR_PSYCHIC ; weakness
	db NONE ; resistance
	tx Text1682 ; category
	db DEX_MACHOP ; Pokedex number
	db FALSE ; is Dark
	db 24 ; level
	length 0.8 ; length
	weight 19.5 ; weight
	tx MachopDescription3 ; description
	db NONE | HAS_EVOLUTION ; AI info
