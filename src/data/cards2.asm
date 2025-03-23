MachokeLv24Card:
	db TYPE_PKMN_FIGHTING ; type
	dw $9239 ; gfx
	tx Text1689 ; name
	db DIAMOND ; rarity
	db SKY_FLYING_POKEMON ; set
	db 2 ; ?
	dw MACHOKE_LV24
	db 60 ; hp
	db STAGE1 ; stage
	tx Text167e ; pre-evo name

	; attack 1
	energy FIGHTING, 1, COLORLESS, 1 ; energies
	tx Text168a ; name
	tx Text1363 ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_NORMAL ; category
	dw $4fe4 ; effect commands
	db INFLICT_PARALYSIS  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_HIT_EFFECT ; animation

	; attack 2
	energy COLORLESS, 3 ; energies
	tx Text168b ; name
	tx Text168c ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db RESIDUAL ; category
	dw $4fe9 ; effect commands
	db DAMAGE_TO_OPPONENT_BENCH  ; flags 1
	db FLAG_2_BIT_6  ; flags 2
	db FLAG_3_BIT_2  ; flags 3
	db 0 ; ?
	db ATK_ANIM_226 ; animation

	db 2 ; retreat cost
	db WR_PSYCHIC ; weakness
	db NONE ; resistance
	tx Text1682 ; category
	db 67 ; Pokedex number
	db 0 ; ?
	db 24 ; level
	length 1.5 ; length
	weight 70.5 ; weight
	tx Text168d ; description
	db NONE | HAS_EVOLUTION ; AI info

MachokeLv28Card:
	db TYPE_PKMN_FIGHTING ; type
	dw $8417 ; gfx
	tx Text1689 ; name
	db DIAMOND ; rarity
	db SKY_FLYING_POKEMON ; set
	db 4 ; ?
	dw MACHOKE_LV28
	db 70 ; hp
	db STAGE1 ; stage
	tx Text167e ; pre-evo name

	; attack 1
	energy FIGHTING, 2 ; energies
	tx Text168e ; name
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

	; attack 2
	energy FIGHTING, 3 ; energies
	tx Text168f ; name
	tx Text15e2 ; description
	dw NONE ; description (cont)
	db 30 ; damage
	db DAMAGE_PLUS ; category
	dw $4e28 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_PUNCH ; animation

	db 2 ; retreat cost
	db WR_PSYCHIC ; weakness
	db NONE ; resistance
	tx Text1682 ; category
	db 67 ; Pokedex number
	db 0 ; ?
	db 28 ; level
	length 1.5 ; length
	weight 70.5 ; weight
	tx Text1690 ; description
	db NONE | HAS_EVOLUTION ; AI info

MachokeLv40Card:
	db TYPE_PKMN_FIGHTING ; type
	dw $3b7a ; gfx
	tx Text1689 ; name
	db DIAMOND ; rarity
	db BEGINNING_POKEMON ; set
	db 0 ; ?
	dw MACHOKE_LV40
	db 80 ; hp
	db STAGE1 ; stage
	tx Text167e ; pre-evo name

	; attack 1
	energy FIGHTING, 2, COLORLESS, 1 ; energies
	tx Text1691 ; name
	tx Text1692 ; description
	dw NONE ; description (cont)
	db 50 ; damage
	db DAMAGE_MINUS ; category
	dw $45f0 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_HIT ; animation

	; attack 2
	energy FIGHTING, 2, COLORLESS, 2 ; energies
	tx Text1693 ; name
	tx Text1497 ; description
	dw NONE ; description (cont)
	db 60 ; damage
	db DAMAGE_NORMAL ; category
	dw $45f8 ; effect commands
	db LOW_RECOIL  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 20 ; ?
	db ATK_ANIM_HIT_RECOIL ; animation

	db 3 ; retreat cost
	db WR_PSYCHIC ; weakness
	db NONE ; resistance
	tx Text1682 ; category
	db 67 ; Pokedex number
	db 0 ; ?
	db 40 ; level
	length 1.5 ; length
	weight 70.5 ; weight
	tx Text1694 ; description
	db NONE | HAS_EVOLUTION ; AI info

DarkMachokeCard:
	db TYPE_PKMN_FIGHTING ; type
	dw $6a4f ; gfx
	tx Text1695 ; name
	db DIAMOND ; rarity
	db PSYCHIC_BATTLE ; set
	db 5 ; ?
	dw DARK_MACHOKE
	db 60 ; hp
	db STAGE1 ; stage
	tx Text167e ; pre-evo name

	; attack 1
	energy FIGHTING, 2, COLORLESS, 1 ; energies
	tx Text1696 ; name
	tx Text1697 ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db RESIDUAL ; category
	dw $4ae1 ; effect commands
	db NONE ; flags 1
	db SWITCH_OPPONENT_POKEMON  ; flags 2
	db SPECIAL_AI_HANDLING | FLAG_3_BIT_2  ; flags 3
	db 0 ; ?
	db ATK_ANIM_HIT ; animation

	; attack 2
	energy FIGHTING, 2, COLORLESS, 1 ; energies
	tx Text1698 ; name
	tx Text14a7 ; description
	dw NONE ; description (cont)
	db 30 ; damage
	db DAMAGE_NORMAL ; category
	dw $4aef ; effect commands
	db NONE ; flags 1
	db SWITCH_OPPONENT_POKEMON  ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_PUNCH ; animation

	db 2 ; retreat cost
	db WR_PSYCHIC ; weakness
	db NONE ; resistance
	tx Text1682 ; category
	db 67 ; Pokedex number
	db 1 ; ?
	db 28 ; level
	length 1.5 ; length
	weight 70.5 ; weight
	tx Text1699 ; description
	db NONE | HAS_EVOLUTION ; AI info

MachampLv54Card:
	db TYPE_PKMN_FIGHTING ; type
	dw $92a2 ; gfx
	tx Text169a ; name
	db STAR ; rarity
	db SKY_FLYING_POKEMON ; set
	db 7 ; ?
	dw MACHAMP_LV54
	db 90 ; hp
	db STAGE2 ; stage
	tx Text1689 ; pre-evo name

	; attack 1
	energy FIGHTING, 2 ; energies
	tx Text169b ; name
	tx Text169c ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_PLUS ; category
	dw $4ffd ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_HIT ; animation

	; attack 2
	energy FIGHTING, 2, COLORLESS, 2 ; energies
	tx Text169d ; name
	tx Text14a7 ; description
	dw NONE ; description (cont)
	db 50 ; damage
	db DAMAGE_NORMAL ; category
	dw $5005 ; effect commands
	db NONE ; flags 1
	db SWITCH_OPPONENT_POKEMON  ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_176 ; animation

	db 3 ; retreat cost
	db WR_PSYCHIC ; weakness
	db NONE ; resistance
	tx Text1682 ; category
	db 68 ; Pokedex number
	db 0 ; ?
	db 54 ; level
	length 1.6 ; length
	weight 130.0 ; weight
	tx Text169e ; description
	db NONE ; AI info

MachampLv67Card:
	db TYPE_PKMN_FIGHTING ; type
	dw $3be3 ; gfx
	tx Text169a ; name
	db STAR ; rarity
	db BEGINNING_POKEMON ; set
	db 0 ; ?
	dw MACHAMP_LV67
	db 100 ; hp
	db STAGE2 ; stage
	tx Text1689 ; pre-evo name

	; attack 1
	energy 0 ; energies
	tx Text169f ; name
	tx Text16a0 ; description
	tx Text16a1 ; description (cont)
	db 0 ; damage
	db POKEMON_POWER ; category
	dw $45be ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_GLOW_EFFECT ; animation

	; attack 2
	energy FIGHTING, 3, COLORLESS, 1 ; energies
	tx Text16a2 ; name
	dw NONE ; description
	dw NONE ; description (cont)
	db 60 ; damage
	db DAMAGE_NORMAL ; category
	dw NONE ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_SEISMIC_TOSS ; animation

	db 3 ; retreat cost
	db WR_PSYCHIC ; weakness
	db NONE ; resistance
	tx Text1682 ; category
	db 68 ; Pokedex number
	db 0 ; ?
	db 67 ; level
	length 1.6 ; length
	weight 130.0 ; weight
	tx Text16a3 ; description
	db NONE ; AI info

DarkMachampCard:
	db TYPE_PKMN_FIGHTING ; type
	dw $6ac6 ; gfx
	tx Text16a4 ; name
	db STAR ; rarity
	db PSYCHIC_BATTLE ; set
	db 5 ; ?
	dw DARK_MACHAMP
	db 70 ; hp
	db STAGE2 ; stage
	tx Text1695 ; pre-evo name

	; attack 1
	energy FIGHTING, 2 ; energies
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
	energy FIGHTING, 3, COLORLESS, 1 ; energies
	tx Text16a5 ; name
	tx Text16a6 ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db DAMAGE_NORMAL ; category
	dw $4afa ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db SPECIAL_AI_HANDLING  ; flags 3
	db 0 ; ?
	db ATK_ANIM_MIRROR_MOVE ; animation

	db 3 ; retreat cost
	db WR_PSYCHIC ; weakness
	db NONE ; resistance
	tx Text1682 ; category
	db 68 ; Pokedex number
	db 1 ; ?
	db 30 ; level
	length 1.6 ; length
	weight 130.0 ; weight
	tx Text16a7 ; description
	db NONE ; AI info

GeodudeLv15Card:
	db TYPE_PKMN_FIGHTING ; type
	dw $7b8c ; gfx
	tx Text16a8 ; name
	db CIRCLE ; rarity
	db SKY_FLYING_POKEMON ; set
	db 1 ; ?
	dw GEODUDE_LV15
	db 50 ; hp
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
	energy FIGHTING, 1, COLORLESS, 1 ; energies
	tx Text16a9 ; name
	tx Text16aa ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db RESIDUAL ; category
	dw $4ceb ; effect commands
	db NONE ; flags 1
	db NULLIFY_OR_WEAKEN_ATTACK  ; flags 2
	db FLAG_3_BIT_2  ; flags 3
	db 0 ; ?
	db ATK_ANIM_PROTECT ; animation

	db 1 ; retreat cost
	db WR_GRASS ; weakness
	db NONE ; resistance
	tx Text16ab ; category
	db 74 ; Pokedex number
	db 0 ; ?
	db 15 ; level
	length 0.4 ; length
	weight 20.0 ; weight
	tx Text16ac ; description
	db NONE | HAS_EVOLUTION ; AI info

GeodudeLv16Card:
	db TYPE_PKMN_FIGHTING ; type
	dw $3c4c ; gfx
	tx Text16a8 ; name
	db CIRCLE ; rarity
	db ISLAND_OF_FOSSIL ; set
	db 4 ; ?
	dw GEODUDE_LV16
	db 50 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy FIGHTING, 1, COLORLESS, 1 ; energies
	tx Text16ad ; name
	tx Text16ae ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_X ; category
	dw $45a4 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_STONE_BARRAGE ; animation

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
	tx Text16ab ; category
	db 74 ; Pokedex number
	db 0 ; ?
	db 16 ; level
	length 0.4 ; length
	weight 20.0 ; weight
	tx Text16af ; description
	db AI_INFO_UNK_03 | HAS_EVOLUTION ; AI info

GravelerLv27Card:
	db TYPE_PKMN_FIGHTING ; type
	dw $93dd ; gfx
	tx Text16b0 ; name
	db DIAMOND ; rarity
	db SKY_FLYING_POKEMON ; set
	db 3 ; ?
	dw GRAVELER_LV27
	db 60 ; hp
	db STAGE1 ; stage
	tx Text16a8 ; pre-evo name

	; attack 1
	energy FIGHTING, 2, COLORLESS, 1 ; energies
	tx Text16b1 ; name
	tx Text16b2 ; description
	dw NONE ; description (cont)
	db 30 ; damage
	db DAMAGE_NORMAL ; category
	dw $502d ; effect commands
	db DAMAGE_TO_OPPONENT_BENCH  ; flags 1
	db NONE ; flags 2
	db FLAG_3_BIT_2  ; flags 3
	db 0 ; ?
	db ATK_ANIM_175 ; animation

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
	db WR_GRASS ; weakness
	db NONE ; resistance
	tx Text16ab ; category
	db 75 ; Pokedex number
	db 0 ; ?
	db 27 ; level
	length 1.0 ; length
	weight 105.0 ; weight
	tx Text16b3 ; description
	db NONE | HAS_EVOLUTION ; AI info

GravelerLv28Card:
	db TYPE_PKMN_FIGHTING ; type
	dw $84e0 ; gfx
	tx Text16b0 ; name
	db DIAMOND ; rarity
	db SKY_FLYING_POKEMON ; set
	db 4 ; ?
	dw GRAVELER_LV28
	db 60 ; hp
	db STAGE1 ; stage
	tx Text16a8 ; pre-evo name

	; attack 1
	energy FIGHTING, 2 ; energies
	tx Text16b4 ; name
	tx Text16b5 ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_X ; category
	dw $4e30 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_STONE_BARRAGE ; animation

	; attack 2
	energy FIGHTING, 3 ; energies
	tx Text165d ; name
	tx Text16b6 ; description
	dw NONE ; description (cont)
	db 50 ; damage
	db DAMAGE_NORMAL ; category
	dw $4e38 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db SPECIAL_AI_HANDLING  ; flags 3
	db 0 ; ?
	db ATK_ANIM_3 ; animation

	db 2 ; retreat cost
	db WR_GRASS ; weakness
	db NONE ; resistance
	tx Text16ab ; category
	db 75 ; Pokedex number
	db 0 ; ?
	db 28 ; level
	length 1.0 ; length
	weight 105.0 ; weight
	tx Text16b7 ; description
	db NONE | HAS_EVOLUTION ; AI info

GravelerLv29Card:
	db TYPE_PKMN_FIGHTING ; type
	dw $3cb5 ; gfx
	tx Text16b0 ; name
	db DIAMOND ; rarity
	db ISLAND_OF_FOSSIL ; set
	db 1 ; ?
	dw GRAVELER_LV29
	db 60 ; hp
	db STAGE1 ; stage
	tx Text16a8 ; pre-evo name

	; attack 1
	energy FIGHTING, 2 ; energies
	tx Text16a9 ; name
	tx Text16b8 ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db RESIDUAL ; category
	dw $4602 ; effect commands
	db NONE ; flags 1
	db NULLIFY_OR_WEAKEN_ATTACK  ; flags 2
	db FLAG_3_BIT_2  ; flags 3
	db 0 ; ?
	db ATK_ANIM_PROTECT ; animation

	; attack 2
	energy FIGHTING, 2, COLORLESS, 1 ; energies
	tx Text16b9 ; name
	dw NONE ; description
	dw NONE ; description (cont)
	db 40 ; damage
	db DAMAGE_NORMAL ; category
	dw NONE ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_174 ; animation

	db 2 ; retreat cost
	db WR_GRASS ; weakness
	db NONE ; resistance
	tx Text16ab ; category
	db 75 ; Pokedex number
	db 0 ; ?
	db 29 ; level
	length 1.0 ; length
	weight 105.0 ; weight
	tx Text16ba ; description
	db NONE | HAS_EVOLUTION ; AI info

GolemLv36Card:
	db TYPE_PKMN_FIGHTING ; type
	dw $3d1e ; gfx
	tx Text16bb ; name
	db DIAMOND ; rarity
	db ISLAND_OF_FOSSIL ; set
	db 2 ; ?
	dw GOLEM_LV36
	db 80 ; hp
	db STAGE2 ; stage
	tx Text16b0 ; pre-evo name

	; attack 1
	energy FIGHTING, 3, COLORLESS, 1 ; energies
	tx Text16bc ; name
	dw NONE ; description
	dw NONE ; description (cont)
	db 60 ; damage
	db DAMAGE_NORMAL ; category
	dw NONE ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_ROCK_THROW ; animation

	; attack 2
	energy FIGHTING, 4 ; energies
	tx Text142f ; name
	tx Text1606 ; description
	dw NONE ; description (cont)
	db 100 ; damage
	db DAMAGE_NORMAL ; category
	dw $45fd ; effect commands
	db HIGH_RECOIL  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 100 ; ?
	db ATK_ANIM_BIG_SELFDESTRUCTION ; animation

	db 4 ; retreat cost
	db WR_GRASS ; weakness
	db NONE ; resistance
	tx Text16bd ; category
	db 76 ; Pokedex number
	db 0 ; ?
	db 36 ; level
	length 1.4 ; length
	weight 300.0 ; weight
	tx Text16be ; description
	db NONE ; AI info

GolemLv37Card:
	db TYPE_PKMN_FIGHTING ; type
	dw $9446 ; gfx
	tx Text16bb ; name
	db STAR ; rarity
	db SKY_FLYING_POKEMON ; set
	db 7 ; ?
	dw GOLEM_LV37
	db 80 ; hp
	db STAGE2 ; stage
	tx Text16b0 ; pre-evo name

	; attack 1
	energy COLORLESS, 2 ; energies
	tx Text134d ; name
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
	energy FIGHTING, 3 ; energies
	tx Text16bf ; name
	tx Text16c0 ; description
	tx Text16c1 ; description (cont)
	db 0 ; damage
	db RESIDUAL ; category
	dw $503b ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db SPECIAL_AI_HANDLING | FLAG_3_BIT_2  ; flags 3
	db 0 ; ?
	db ATK_ANIM_175 ; animation

	db 3 ; retreat cost
	db WR_GRASS ; weakness
	db NONE ; resistance
	tx Text16bd ; category
	db 76 ; Pokedex number
	db 0 ; ?
	db 37 ; level
	length 1.4 ; length
	weight 300.0 ; weight
	tx Text16c2 ; description
	db NONE ; AI info

OnixLv12Card:
	db TYPE_PKMN_FIGHTING ; type
	dw $3d87 ; gfx
	tx Text16c3 ; name
	db CIRCLE ; rarity
	db BEGINNING_POKEMON ; set
	db 0 ; ?
	dw ONIX_LV12
	db 90 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy FIGHTING, 1 ; energies
	tx Text16b9 ; name
	dw NONE ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_NORMAL ; category
	dw NONE ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_174 ; animation

	; attack 2
	energy FIGHTING, 2 ; energies
	tx Text16a9 ; name
	tx Text16c4 ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db RESIDUAL ; category
	dw $45ac ; effect commands
	db NONE ; flags 1
	db NULLIFY_OR_WEAKEN_ATTACK  ; flags 2
	db FLAG_3_BIT_2  ; flags 3
	db 0 ; ?
	db ATK_ANIM_PROTECT ; animation

	db 3 ; retreat cost
	db WR_GRASS ; weakness
	db NONE ; resistance
	tx Text16c5 ; category
	db 95 ; Pokedex number
	db 0 ; ?
	db 12 ; level
	length 8.8 ; length
	weight 210.0 ; weight
	tx Text16c6 ; description
	db NONE ; AI info

OnixLv25Card:
	db TYPE_PKMN_FIGHTING ; type
	dw $8772 ; gfx
	tx Text16c3 ; name
	db DIAMOND ; rarity
	db SKY_FLYING_POKEMON ; set
	db 6 ; ?
	dw ONIX_LV25
	db 70 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy FIGHTING, 1 ; energies
	tx Text1439 ; name
	tx Text1363 ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_NORMAL ; category
	dw $4e8f ; effect commands
	db INFLICT_PARALYSIS  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_HIT_EFFECT ; animation

	; attack 2
	energy FIGHTING, 2 ; energies
	tx Text16c7 ; name
	tx Text16c8 ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_NORMAL ; category
	dw $4e94 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_174 ; animation

	db 2 ; retreat cost
	db WR_GRASS ; weakness
	db NONE ; resistance
	tx Text16c5 ; category
	db 95 ; Pokedex number
	db 0 ; ?
	db 25 ; level
	length 8.8 ; length
	weight 210.0 ; weight
	tx Text16c9 ; description
	db NONE ; AI info

CuboneLv13Card:
	db TYPE_PKMN_FIGHTING ; type
	dw $3df0 ; gfx
	tx Text16ca ; name
	db CIRCLE ; rarity
	db LEGENDARY_POWER ; set
	db 4 ; ?
	dw CUBONE_LV13
	db 40 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy COLORLESS, 1 ; energies
	tx Text16cb ; name
	tx Text16cc ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db DAMAGE_NORMAL ; category
	dw $45cd ; effect commands
	db NONE ; flags 1
	db NULLIFY_OR_WEAKEN_ATTACK  ; flags 2
	db NONE ; flags 3
	db 10 ; ?
	db ATK_ANIM_CRY ; animation

	; attack 2
	energy FIGHTING, 2 ; energies
	tx Text14c1 ; name
	tx Text14c2 ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_PLUS ; category
	dw $45d2 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db BOOST_IF_TAKEN_DAMAGE  ; flags 3
	db 0 ; ?
	db ATK_ANIM_HIT ; animation

	db 1 ; retreat cost
	db WR_GRASS ; weakness
	db WR_LIGHTNING ; resistance
	tx Text16cd ; category
	db 104 ; Pokedex number
	db 0 ; ?
	db 13 ; level
	length 0.4 ; length
	weight 6.5 ; weight
	tx Text16ce ; description
	db AI_INFO_UNK_03 | HAS_EVOLUTION ; AI info

CuboneLv14Card:
	db TYPE_PKMN_FIGHTING ; type
	dw $9869 ; gfx
	tx Text16ca ; name
	db CIRCLE ; rarity
	db SKY_FLYING_POKEMON ; set
	db 1 ; ?
	dw CUBONE_LV14
	db 40 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy FIGHTING, 1 ; energies
	tx Text16cf ; name
	tx Text16d0 ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db DAMAGE_NORMAL ; category
	dw $50c6 ; effect commands
	db DAMAGE_TO_OPPONENT_BENCH  ; flags 1
	db FLAG_2_BIT_6  ; flags 2
	db FLAG_3_BIT_2  ; flags 3
	db 3 ; ?
	db ATK_ANIM_BONEMERANG ; animation

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
	tx Text16cd ; category
	db 104 ; Pokedex number
	db 0 ; ?
	db 14 ; level
	length 0.4 ; length
	weight 6.5 ; weight
	tx Text16d1 ; description
	db NONE | HAS_EVOLUTION ; AI info

MarowakLv26Card:
	db TYPE_PKMN_FIGHTING ; type
	dw $3e59 ; gfx
	tx Text16d2 ; name
	db DIAMOND ; rarity
	db LEGENDARY_POWER ; set
	db 4 ; ?
	dw MAROWAK_LV26
	db 60 ; hp
	db STAGE1 ; stage
	tx Text16ca ; pre-evo name

	; attack 1
	energy FIGHTING, 2 ; energies
	tx Text16d3 ; name
	tx Text1352 ; description
	dw NONE ; description (cont)
	db 30 ; damage
	db DAMAGE_X ; category
	dw $45da ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_BONEMERANG ; animation

	; attack 2
	energy FIGHTING, 2, COLORLESS, 1 ; energies
	tx Text16d4 ; name
	tx Text16d5 ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db RESIDUAL ; category
	dw $45e2 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db SPECIAL_AI_HANDLING | FLAG_3_BIT_2  ; flags 3
	db 0 ; ?
	db ATK_ANIM_GLOW_EFFECT ; animation

	db 1 ; retreat cost
	db WR_GRASS ; weakness
	db WR_LIGHTNING ; resistance
	tx Text16d6 ; category
	db 105 ; Pokedex number
	db 0 ; ?
	db 26 ; level
	length 1.0 ; length
	weight 45.0 ; weight
	tx Text16d7 ; description
	db NONE ; AI info

MarowakLv32Card:
	db TYPE_PKMN_FIGHTING ; type
	dw $3ec2 ; gfx
	tx Text16d2 ; name
	db DIAMOND ; rarity
	db GB ; set
	db 1 ; ?
	dw MAROWAK_LV32
	db 70 ; hp
	db STAGE1 ; stage
	tx Text16ca ; pre-evo name

	; attack 1
	energy FIGHTING, 1, COLORLESS, 1 ; energies
	tx Text16d8 ; name
	tx Text16d9 ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_NORMAL ; category
	dw $4644 ; effect commands
	db NONE ; flags 1
	db NULLIFY_OR_WEAKEN_ATTACK  ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_BONEMERANG ; animation

	; attack 2
	energy FIGHTING, 3 ; energies
	tx Text16da ; name
	tx Text16db ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db RESIDUAL ; category
	dw $4649 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db SPECIAL_AI_HANDLING | FLAG_3_BIT_2  ; flags 3
	db 0 ; ?
	db ATK_ANIM_CRY ; animation

	db 2 ; retreat cost
	db WR_GRASS ; weakness
	db WR_LIGHTNING ; resistance
	tx Text16d6 ; category
	db 105 ; Pokedex number
	db 0 ; ?
	db 32 ; level
	length 1.0 ; length
	weight 45.0 ; weight
	tx Text16dc ; description
	db NONE ; AI info

DarkMarowakCard:
	db TYPE_PKMN_FIGHTING ; type
	dw $c800 ; gfx
	tx Text16dd ; name
	db DIAMOND ; rarity
	db GB ; set
	db 6 ; ?
	dw DARK_MAROWAK
	db 60 ; hp
	db STAGE1 ; stage
	tx Text16ca ; pre-evo name

	; attack 1
	energy FIGHTING, 2 ; energies
	tx Text16de ; name
	tx Text16df ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_NORMAL ; category
	dw $5327 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db FLAG_3_BIT_2  ; flags 3
	db 0 ; ?
	db ATK_ANIM_254 ; animation

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
	tx Text16d6 ; category
	db 105 ; Pokedex number
	db 1 ; ?
	db 27 ; level
	length 1.0 ; length
	weight 45.0 ; weight
	tx Text16e0 ; description
	db NONE ; AI info

HitmonleeLv23Card:
	db TYPE_PKMN_FIGHTING ; type
	dw $88d2 ; gfx
	tx Text16e1 ; name
	db STAR ; rarity
	db SKY_FLYING_POKEMON ; set
	db 1 ; ?
	dw HITMONLEE_LV23
	db 50 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy FIGHTING, 2 ; energies
	tx Text137d ; name
	tx Text1352 ; description
	dw NONE ; description (cont)
	db 30 ; damage
	db DAMAGE_X ; category
	dw $4eab ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_182 ; animation

	; attack 2
	energy FIGHTING, 2, COLORLESS, 1 ; energies
	tx Text16e2 ; name
	tx Text1363 ; description
	dw NONE ; description (cont)
	db 30 ; damage
	db DAMAGE_NORMAL ; category
	dw $4eb3 ; effect commands
	db INFLICT_PARALYSIS  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_182 ; animation

	db 1 ; retreat cost
	db WR_PSYCHIC ; weakness
	db NONE ; resistance
	tx Text1687 ; category
	db 106 ; Pokedex number
	db 0 ; ?
	db 23 ; level
	length 1.5 ; length
	weight 49.8 ; weight
	tx Text16e3 ; description
	db NONE ; AI info

HitmonleeLv30Card:
	db TYPE_PKMN_FIGHTING ; type
	dw $3f2b ; gfx
	tx Text16e1 ; name
	db STAR ; rarity
	db ISLAND_OF_FOSSIL ; set
	db 4 ; ?
	dw HITMONLEE_LV30
	db 60 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy FIGHTING, 2 ; energies
	tx Text16e4 ; name
	tx Text16e5 ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db RESIDUAL ; category
	dw $4617 ; effect commands
	db DAMAGE_TO_OPPONENT_BENCH  ; flags 1
	db FLAG_2_BIT_6  ; flags 2
	db FLAG_3_BIT_2  ; flags 3
	db 3 ; ?
	db ATK_ANIM_STRETCH_KICK ; animation

	; attack 2
	energy FIGHTING, 3 ; energies
	tx Text16e6 ; name
	dw NONE ; description
	dw NONE ; description (cont)
	db 50 ; damage
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
	tx Text1687 ; category
	db 106 ; Pokedex number
	db 0 ; ?
	db 30 ; level
	length 1.5 ; length
	weight 49.8 ; weight
	tx Text16e7 ; description
	db NONE ; AI info

HitmonchanLv23Card:
	db TYPE_PKMN_FIGHTING ; type
	dw $893b ; gfx
	tx Text16e8 ; name
	db STAR ; rarity
	db SKY_FLYING_POKEMON ; set
	db 4 ; ?
	dw HITMONCHAN_LV23
	db 50 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy FIGHTING, 1 ; energies
	tx Text16e9 ; name
	tx Text16ea ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_NORMAL ; category
	dw $4eb8 ; effect commands
	db DAMAGE_TO_OPPONENT_BENCH  ; flags 1
	db NONE ; flags 2
	db FLAG_3_BIT_2  ; flags 3
	db 0 ; ?
	db ATK_ANIM_PUNCH ; animation

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
	db WR_PSYCHIC ; weakness
	db NONE ; resistance
	tx Text1686 ; category
	db 107 ; Pokedex number
	db 0 ; ?
	db 23 ; level
	length 1.4 ; length
	weight 50.2 ; weight
	tx Text16eb ; description
	db NONE ; AI info

HitmonchanLv33Card:
	db TYPE_PKMN_FIGHTING ; type
	dw $3f94 ; gfx
	tx Text16e8 ; name
	db STAR ; rarity
	db BEGINNING_POKEMON ; set
	db 0 ; ?
	dw HITMONCHAN_LV33
	db 70 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy FIGHTING, 1 ; energies
	tx Text16ec ; name
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
	energy FIGHTING, 2, COLORLESS, 1 ; energies
	tx Text16ed ; name
	dw NONE ; description
	dw NONE ; description (cont)
	db 40 ; damage
	db DAMAGE_NORMAL ; category
	dw NONE ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_176 ; animation

	db 2 ; retreat cost
	db WR_PSYCHIC ; weakness
	db NONE ; resistance
	tx Text1686 ; category
	db 107 ; Pokedex number
	db 0 ; ?
	db 33 ; level
	length 1.4 ; length
	weight 50.2 ; weight
	tx Text16ee ; description
	db NONE ; AI info

RhyhornCard:
	db TYPE_PKMN_FIGHTING ; type
	dw $4000 ; gfx
	tx Text16ef ; name
	db CIRCLE ; rarity
	db LEGENDARY_POWER ; set
	db 1 ; ?
	dw RHYHORN
	db 70 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy COLORLESS, 1 ; energies
	tx Text16f0 ; name
	tx Text16f1 ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db DAMAGE_NORMAL ; category
	dw $4612 ; effect commands
	db NONE ; flags 1
	db NULLIFY_OR_WEAKEN_ATTACK  ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_NONE ; animation

	; attack 2
	energy FIGHTING, 1, COLORLESS, 2 ; energies
	tx Text1564 ; name
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

	db 3 ; retreat cost
	db WR_GRASS ; weakness
	db WR_LIGHTNING ; resistance
	tx Text16f2 ; category
	db 111 ; Pokedex number
	db 0 ; ?
	db 18 ; level
	length 1.0 ; length
	weight 115.0 ; weight
	tx Text16f3 ; description
	db NONE | HAS_EVOLUTION ; AI info

RhydonLv37Card:
	db TYPE_PKMN_FIGHTING ; type
	dw $993b ; gfx
	tx Text16f4 ; name
	db STAR ; rarity
	db SKY_FLYING_POKEMON ; set
	db 3 ; ?
	dw RHYDON_LV37
	db 80 ; hp
	db STAGE1 ; stage
	tx Text16ef ; pre-evo name

	; attack 1
	energy FIGHTING, 1 ; energies
	tx Text16f5 ; name
	tx Text16f6 ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_NORMAL ; category
	dw $50e7 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db SPECIAL_AI_HANDLING | FLAG_3_BIT_2  ; flags 3
	db 0 ; ?
	db ATK_ANIM_HIT ; animation

	; attack 2
	energy FIGHTING, 3 ; energies
	tx Text16f7 ; name
	tx Text15e2 ; description
	dw NONE ; description (cont)
	db 30 ; damage
	db DAMAGE_PLUS ; category
	dw $50ef ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_HIT ; animation

	db 3 ; retreat cost
	db WR_GRASS ; weakness
	db WR_LIGHTNING ; resistance
	tx Text1383 ; category
	db 112 ; Pokedex number
	db 0 ; ?
	db 37 ; level
	length 1.9 ; length
	weight 120.0 ; weight
	tx Text16f8 ; description
	db NONE ; AI info

RhydonLv48Card:
	db TYPE_PKMN_FIGHTING ; type
	dw $4069 ; gfx
	tx Text16f4 ; name
	db DIAMOND ; rarity
	db LEGENDARY_POWER ; set
	db 1 ; ?
	dw RHYDON_LV48
	db 100 ; hp
	db STAGE1 ; stage
	tx Text16ef ; pre-evo name

	; attack 1
	energy FIGHTING, 1, COLORLESS, 2 ; energies
	tx Text1564 ; name
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
	energy FIGHTING, 4 ; energies
	tx Text16f9 ; name
	tx Text16fa ; description
	dw NONE ; description (cont)
	db 50 ; damage
	db DAMAGE_NORMAL ; category
	dw $4607 ; effect commands
	db LOW_RECOIL  ; flags 1
	db SWITCH_OPPONENT_POKEMON  ; flags 2
	db NONE ; flags 3
	db 20 ; ?
	db ATK_ANIM_HIT_RECOIL ; animation

	db 3 ; retreat cost
	db WR_GRASS ; weakness
	db WR_LIGHTNING ; resistance
	tx Text1383 ; category
	db 112 ; Pokedex number
	db 0 ; ?
	db 48 ; level
	length 1.9 ; length
	weight 120.0 ; weight
	tx Text16fb ; description
	db NONE ; AI info

KabutoLv9Card:
	db TYPE_PKMN_FIGHTING ; type
	dw $40d2 ; gfx
	tx Text16fc ; name
	db CIRCLE ; rarity
	db ISLAND_OF_FOSSIL ; set
	db 2 ; ?
	dw KABUTO_LV9
	db 30 ; hp
	db STAGE1 ; stage
	tx Text15a3 ; pre-evo name

	; attack 1
	energy 0 ; energies
	tx Text16fd ; name
	tx Text16fe ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db POKEMON_POWER ; category
	dw $45c3 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
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

	db 1 ; retreat cost
	db WR_GRASS ; weakness
	db NONE ; resistance
	tx Text14f2 ; category
	db 140 ; Pokedex number
	db 0 ; ?
	db 9 ; level
	length 0.5 ; length
	weight 11.5 ; weight
	tx Text16ff ; description
	db AI_INFO_UNK_03 | HAS_EVOLUTION ; AI info

KabutoLv22Card:
	db TYPE_PKMN_FIGHTING ; type
	dw $8b05 ; gfx
	tx Text16fc ; name
	db DIAMOND ; rarity
	db SKY_FLYING_POKEMON ; set
	db 5 ; ?
	dw KABUTO_LV22
	db 50 ; hp
	db STAGE1 ; stage
	tx Text15a3 ; pre-evo name

	; attack 1
	energy 0 ; energies
	tx Text1700 ; name
	tx Text1701 ; description
	tx Text15aa ; description (cont)
	db 0 ; damage
	db POKEMON_POWER ; category
	dw $4edd ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_GLOW_EFFECT ; animation

	; attack 2
	energy COLORLESS, 2 ; energies
	tx Text1702 ; name
	tx Text1703 ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_PLUS ; category
	dw $4ee8 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_SLASH ; animation

	db 1 ; retreat cost
	db WR_GRASS ; weakness
	db NONE ; resistance
	tx Text14f2 ; category
	db 140 ; Pokedex number
	db 0 ; ?
	db 22 ; level
	length 0.5 ; length
	weight 11.5 ; weight
	tx Text1704 ; description
	db NONE | HAS_EVOLUTION ; AI info

KabutopsCard:
	db TYPE_PKMN_FIGHTING ; type
	dw $413b ; gfx
	tx Text1705 ; name
	db STAR ; rarity
	db ISLAND_OF_FOSSIL ; set
	db 3 ; ?
	dw KABUTOPS
	db 60 ; hp
	db STAGE2 ; stage
	tx Text16fc ; pre-evo name

	; attack 1
	energy FIGHTING, 2 ; energies
	tx Text1706 ; name
	dw NONE ; description
	dw NONE ; description (cont)
	db 30 ; damage
	db DAMAGE_NORMAL ; category
	dw NONE ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_TEAR ; animation

	; attack 2
	energy FIGHTING, 4 ; energies
	tx Text1707 ; name
	tx Text1323 ; description
	dw NONE ; description (cont)
	db 40 ; damage
	db DAMAGE_NORMAL ; category
	dw $45c8 ; effect commands
	db NONE ; flags 1
	db HEAL_USER  ; flags 2
	db NONE ; flags 3
	db 2 ; ?
	db ATK_ANIM_DRAIN ; animation

	db 1 ; retreat cost
	db WR_GRASS ; weakness
	db NONE ; resistance
	tx Text14f2 ; category
	db 141 ; Pokedex number
	db 0 ; ?
	db 30 ; level
	length 1.3 ; length
	weight 40.5 ; weight
	tx Text1708 ; description
	db NONE ; AI info

AerodactylLv28Card:
	db TYPE_PKMN_FIGHTING ; type
	dw $41a4 ; gfx
	tx Text1709 ; name
	db STAR ; rarity
	db ISLAND_OF_FOSSIL ; set
	db 5 ; ?
	dw AERODACTYL_LV28
	db 60 ; hp
	db STAGE1 ; stage
	tx Text15a3 ; pre-evo name

	; attack 1
	energy 0 ; energies
	tx Text170a ; name
	tx Text170b ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db POKEMON_POWER ; category
	dw $4637 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_PKMN_POWER_1 ; animation

	; attack 2
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

	db 2 ; retreat cost
	db WR_GRASS ; weakness
	db WR_FIGHTING ; resistance
	tx Text170c ; category
	db 142 ; Pokedex number
	db 0 ; ?
	db 28 ; level
	length 1.8 ; length
	weight 59.0 ; weight
	tx Text170d ; description
	db AI_INFO_BENCH_UTILITY ; AI info

AerodactylLv30Card:
	db TYPE_PKMN_FIGHTING ; type
	dw $8b6e ; gfx
	tx Text1709 ; name
	db DIAMOND ; rarity
	db SKY_FLYING_POKEMON ; set
	db 2 ; ?
	dw AERODACTYL_LV30
	db 70 ; hp
	db STAGE1 ; stage
	tx Text15a3 ; pre-evo name

	; attack 1
	energy COLORLESS, 1 ; energies
	tx Text137b ; name
	tx Text1336 ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db DAMAGE_NORMAL ; category
	dw $4ef0 ; effect commands
	db INFLICT_CONFUSION  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_77 ; animation

	; attack 2
	energy COLORLESS, 3 ; energies
	tx Text170e ; name
	tx Text170f ; description
	dw NONE ; description (cont)
	db 40 ; damage
	db DAMAGE_NORMAL ; category
	dw $4ef5 ; effect commands
	db LOW_RECOIL  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 10 ; ?
	db ATK_ANIM_HIT_RECOIL ; animation

	db 1 ; retreat cost
	db WR_GRASS ; weakness
	db WR_FIGHTING ; resistance
	tx Text170c ; category
	db 142 ; Pokedex number
	db 0 ; ?
	db 30 ; level
	length 1.8 ; length
	weight 59.0 ; weight
	tx Text1710 ; description
	db NONE ; AI info

AbraLv8Card:
	db TYPE_PKMN_PSYCHIC ; type
	dw $7b23 ; gfx
	tx Text1711 ; name
	db CIRCLE ; rarity
	db SKY_FLYING_POKEMON ; set
	db 4 ; ?
	dw ABRA_LV8
	db 30 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy PSYCHIC, 1 ; energies
	tx Text1712 ; name
	tx Text1713 ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db RESIDUAL ; category
	dw $4cda ; effect commands
	db DAMAGE_TO_OPPONENT_BENCH  ; flags 1
	db FLAG_2_BIT_6  ; flags 2
	db FLAG_3_BIT_2  ; flags 3
	db 0 ; ?
	db ATK_ANIM_169 ; animation

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
	db WR_PSYCHIC ; weakness
	db NONE ; resistance
	tx Text1505 ; category
	db 63 ; Pokedex number
	db 0 ; ?
	db 8 ; level
	length 0.9 ; length
	weight 19.5 ; weight
	tx Text1714 ; description
	db NONE | HAS_EVOLUTION ; AI info

AbraLv10Card:
	db TYPE_PKMN_PSYCHIC ; type
	dw $421b ; gfx
	tx Text1711 ; name
	db CIRCLE ; rarity
	db BEGINNING_POKEMON ; set
	db 1 ; ?
	dw ABRA_LV10
	db 30 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy PSYCHIC, 1 ; energies
	tx Text1505 ; name
	tx Text132f ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_NORMAL ; category
	dw $4450 ; effect commands
	db INFLICT_PARALYSIS  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_PSYCHIC_HIT ; animation

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
	db WR_PSYCHIC ; weakness
	db NONE ; resistance
	tx Text1505 ; category
	db 63 ; Pokedex number
	db 0 ; ?
	db 10 ; level
	length 0.9 ; length
	weight 19.5 ; weight
	tx Text1715 ; description
	db NONE | HAS_EVOLUTION ; AI info

AbraLv14Card:
	db TYPE_PKMN_PSYCHIC ; type
	dw $649b ; gfx
	tx Text1711 ; name
	db CIRCLE ; rarity
	db PSYCHIC_BATTLE ; set
	db 5 ; ?
	dw ABRA_LV14
	db 40 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy PSYCHIC, 1 ; energies
	tx Text1716 ; name
	tx Text1717 ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db RESIDUAL ; category
	dw $4a34 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db SPECIAL_AI_HANDLING | FLAG_3_BIT_2  ; flags 3
	db 0 ; ?
	db ATK_ANIM_210 ; animation

	; attack 2
	energy PSYCHIC, 1 ; energies
	tx Text1505 ; name
	tx Text1363 ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_NORMAL ; category
	dw $4a3f ; effect commands
	db INFLICT_PARALYSIS  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_27 ; animation

	db 1 ; retreat cost
	db WR_PSYCHIC ; weakness
	db NONE ; resistance
	tx Text1505 ; category
	db 63 ; Pokedex number
	db 0 ; ?
	db 14 ; level
	length 0.9 ; length
	weight 19.5 ; weight
	tx Text1718 ; description
	db NONE | HAS_EVOLUTION ; AI info

KadabraLv38Card:
	db TYPE_PKMN_PSYCHIC ; type
	dw $4286 ; gfx
	tx Text1719 ; name
	db DIAMOND ; rarity
	db BEGINNING_POKEMON ; set
	db 1 ; ?
	dw KADABRA_LV38
	db 60 ; hp
	db STAGE1 ; stage
	tx Text1711 ; pre-evo name

	; attack 1
	energy PSYCHIC, 2 ; energies
	tx Text1573 ; name
	tx Text171a ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db RESIDUAL ; category
	dw $4578 ; effect commands
	db NONE ; flags 1
	db DISCARD_ENERGY  ; flags 2
	db FLAG_3_BIT_2  ; flags 3
	db 3 ; ?
	db ATK_ANIM_RECOVER ; animation

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

	db 3 ; retreat cost
	db WR_PSYCHIC ; weakness
	db NONE ; resistance
	tx Text1505 ; category
	db 64 ; Pokedex number
	db 0 ; ?
	db 38 ; level
	length 1.3 ; length
	weight 56.5 ; weight
	tx Text171b ; description
	db NONE | HAS_EVOLUTION ; AI info

KadabraLv39Card:
	db TYPE_PKMN_PSYCHIC ; type
	dw $9163 ; gfx
	tx Text1719 ; name
	db STAR ; rarity
	db SKY_FLYING_POKEMON ; set
	db 4 ; ?
	dw KADABRA_LV39
	db 60 ; hp
	db STAGE1 ; stage
	tx Text1711 ; pre-evo name

	; attack 1
	energy PSYCHIC, 2 ; energies
	tx Text171c ; name
	tx Text171d ; description
	dw NONE ; description (cont)
	db 30 ; damage
	db DAMAGE_NORMAL ; category
	dw $4fbe ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_PSYCHIC_HIT ; animation

	; attack 2
	energy PSYCHIC, 3 ; energies
	tx Text171e ; name
	tx Text171f ; description
	dw NONE ; description (cont)
	db 30 ; damage
	db DAMAGE_NORMAL ; category
	dw $4fc6 ; effect commands
	db NONE ; flags 1
	db NULLIFY_OR_WEAKEN_ATTACK  ; flags 2
	db FLAG_3_BIT_2  ; flags 3
	db 0 ; ?
	db ATK_ANIM_166 ; animation

	db 3 ; retreat cost
	db WR_PSYCHIC ; weakness
	db NONE ; resistance
	tx Text1505 ; category
	db 64 ; Pokedex number
	db 0 ; ?
	db 39 ; level
	length 1.3 ; length
	weight 56.5 ; weight
	tx Text1720 ; description
	db NONE | HAS_EVOLUTION ; AI info

DarkKadabraCard:
	db TYPE_PKMN_PSYCHIC ; type
	dw $6504 ; gfx
	tx Text1721 ; name
	db DIAMOND ; rarity
	db PSYCHIC_BATTLE ; set
	db 5 ; ?
	dw DARK_KADABRA
	db 50 ; hp
	db STAGE1 ; stage
	tx Text1711 ; pre-evo name

	; attack 1
	energy 0 ; energies
	tx Text1722 ; name
	tx Text1723 ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db POKEMON_POWER ; category
	dw $4a44 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_GLOW_EFFECT ; animation

	; attack 2
	energy PSYCHIC, 2 ; energies
	tx Text1724 ; name
	tx Text1725 ; description
	dw NONE ; description (cont)
	db 30 ; damage
	db DAMAGE_NORMAL ; category
	dw $4a4f ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_PSYCHIC_HIT ; animation

	db 2 ; retreat cost
	db WR_PSYCHIC ; weakness
	db NONE ; resistance
	tx Text1505 ; category
	db 64 ; Pokedex number
	db 1 ; ?
	db 24 ; level
	length 1.3 ; length
	weight 56.5 ; weight
	tx Text1726 ; description
	db NONE | HAS_EVOLUTION ; AI info

AlakazamLv42Card:
	db TYPE_PKMN_PSYCHIC ; type
	dw $42fb ; gfx
	tx Text1727 ; name
	db STAR ; rarity
	db BEGINNING_POKEMON ; set
	db 2 ; ?
	dw ALAKAZAM_LV42
	db 80 ; hp
	db STAGE2 ; stage
	tx Text1719 ; pre-evo name

	; attack 1
	energy 0 ; energies
	tx Text1728 ; name
	tx Text1729 ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db POKEMON_POWER ; category
	dw $44d3 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_PKMN_POWER_1 ; animation

	; attack 2
	energy PSYCHIC, 3 ; energies
	tx Text1470 ; name
	tx Text137c ; description
	dw NONE ; description (cont)
	db 30 ; damage
	db DAMAGE_NORMAL ; category
	dw $44de ; effect commands
	db INFLICT_CONFUSION  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_CONFUSE_RAY ; animation

	db 3 ; retreat cost
	db WR_PSYCHIC ; weakness
	db NONE ; resistance
	tx Text1505 ; category
	db 65 ; Pokedex number
	db 0 ; ?
	db 42 ; level
	length 1.5 ; length
	weight 48.0 ; weight
	tx Text172a ; description
	db NONE ; AI info

AlakazamLv45Card:
	db TYPE_PKMN_PSYCHIC ; type
	dw $91d0 ; gfx
	tx Text1727 ; name
	db STAR ; rarity
	db SKY_FLYING_POKEMON ; set
	db 7 ; ?
	dw ALAKAZAM_LV45
	db 90 ; hp
	db STAGE2 ; stage
	tx Text1719 ; pre-evo name

	; attack 1
	energy PSYCHIC, 2 ; energies
	tx Text171c ; name
	tx Text171d ; description
	dw NONE ; description (cont)
	db 30 ; damage
	db DAMAGE_NORMAL ; category
	dw $4fcb ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_PSYCHIC_HIT ; animation

	; attack 2
	energy PSYCHIC, 3 ; energies
	tx Text172b ; name
	tx Text172c ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db DAMAGE_NORMAL ; category
	dw $4fd3 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db SPECIAL_AI_HANDLING  ; flags 3
	db 0 ; ?
	db ATK_ANIM_225 ; animation

	db 3 ; retreat cost
	db WR_PSYCHIC ; weakness
	db NONE ; resistance
	tx Text1505 ; category
	db 65 ; Pokedex number
	db 0 ; ?
	db 45 ; level
	length 1.5 ; length
	weight 48.0 ; weight
	tx Text172d ; description
	db NONE ; AI info

DarkAlakazamCard:
	db TYPE_PKMN_PSYCHIC ; type
	dw $656d ; gfx
	tx Text172e ; name
	db STAR ; rarity
	db PSYCHIC_BATTLE ; set
	db 5 ; ?
	dw DARK_ALAKAZAM
	db 60 ; hp
	db STAGE2 ; stage
	tx Text1721 ; pre-evo name

	; attack 1
	energy PSYCHIC, 2, COLORLESS, 1 ; energies
	tx Text172f ; name
	tx Text1730 ; description
	dw NONE ; description (cont)
	db 30 ; damage
	db DAMAGE_NORMAL ; category
	dw $4a57 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db SPECIAL_AI_HANDLING  ; flags 3
	db 0 ; ?
	db ATK_ANIM_211 ; animation

	; attack 2
	energy PSYCHIC, 3 ; energies
	tx Text1724 ; name
	tx Text1608 ; description
	dw NONE ; description (cont)
	db 40 ; damage
	db DAMAGE_NORMAL ; category
	dw $4a65 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_PSYCHIC_HIT ; animation

	db 3 ; retreat cost
	db WR_PSYCHIC ; weakness
	db NONE ; resistance
	tx Text1505 ; category
	db 65 ; Pokedex number
	db 1 ; ?
	db 30 ; level
	length 1.5 ; length
	weight 48.0 ; weight
	tx Text1731 ; description
	db NONE ; AI info

SlowpokeLv9Card:
	db TYPE_PKMN_PSYCHIC ; type
	dw $4364 ; gfx
	tx Text1732 ; name
	db PROMOSTAR ; rarity
	db PRO ; set
	db 7 ; ?
	dw SLOWPOKE_LV9
	db 40 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy COLORLESS, 1 ; energies
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
	energy PSYCHIC, 2 ; energies
	tx Text1518 ; name
	tx Text1519 ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db DAMAGE_NORMAL ; category
	dw $456a ; effect commands
	db NONE ; flags 1
	db FLAG_2_BIT_6  ; flags 2
	db NONE ; flags 3
	db 2 ; ?
	db ATK_ANIM_AMNESIA ; animation

	db 1 ; retreat cost
	db WR_PSYCHIC ; weakness
	db NONE ; resistance
	tx Text1733 ; category
	db 79 ; Pokedex number
	db 0 ; ?
	db 9 ; level
	length 1.2 ; length
	weight 36.0 ; weight
	tx Text1734 ; description
	db AI_INFO_UNK_03 | HAS_EVOLUTION ; AI info

SlowpokeLv16Card:
	db TYPE_PKMN_PSYCHIC ; type
	dw $65da ; gfx
	tx Text1732 ; name
	db CIRCLE ; rarity
	db PSYCHIC_BATTLE ; set
	db 6 ; ?
	dw SLOWPOKE_LV16
	db 50 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy COLORLESS, 1 ; energies
	tx Text1735 ; name
	tx Text1736 ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db RESIDUAL ; category
	dw $4a6d ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db SPECIAL_AI_HANDLING | FLAG_3_BIT_2  ; flags 3
	db 0 ; ?
	db ATK_ANIM_GLOW_EFFECT ; animation

	; attack 2
	energy PSYCHIC, 1 ; energies
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

	db 1 ; retreat cost
	db WR_PSYCHIC ; weakness
	db NONE ; resistance
	tx Text1733 ; category
	db 79 ; Pokedex number
	db 0 ; ?
	db 16 ; level
	length 1.2 ; length
	weight 36.0 ; weight
	tx Text1737 ; description
	db NONE | HAS_EVOLUTION ; AI info

SlowpokeLv18Card:
	db TYPE_PKMN_PSYCHIC ; type
	dw $43e9 ; gfx
	tx Text1732 ; name
	db CIRCLE ; rarity
	db ISLAND_OF_FOSSIL ; set
	db 2 ; ?
	dw SLOWPOKE_LV18
	db 50 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy COLORLESS, 1 ; energies
	tx Text1738 ; name
	tx Text1739 ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db RESIDUAL ; category
	dw $454b ; effect commands
	db NONE ; flags 1
	db HEAL_USER  ; flags 2
	db FLAG_3_BIT_2  ; flags 3
	db 1 ; ?
	db ATK_ANIM_NONE ; animation

	; attack 2
	energy PSYCHIC, 2 ; energies
	tx Text173a ; name
	tx Text173b ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db RESIDUAL ; category
	dw $4556 ; effect commands
	db NONE ; flags 1
	db DISCARD_ENERGY  ; flags 2
	db FLAG_3_BIT_2  ; flags 3
	db 2 ; ?
	db ATK_ANIM_GLOW_EFFECT ; animation

	db 1 ; retreat cost
	db WR_PSYCHIC ; weakness
	db NONE ; resistance
	tx Text1733 ; category
	db 79 ; Pokedex number
	db 0 ; ?
	db 18 ; level
	length 1.2 ; length
	weight 36.0 ; weight
	tx Text173c ; description
	db NONE | HAS_EVOLUTION ; AI info

SlowbroLv26Card:
	db TYPE_PKMN_PSYCHIC ; type
	dw $4456 ; gfx
	tx Text173d ; name
	db DIAMOND ; rarity
	db ISLAND_OF_FOSSIL ; set
	db 2 ; ?
	dw SLOWBRO_LV26
	db 60 ; hp
	db STAGE1 ; stage
	tx Text1732 ; pre-evo name

	; attack 1
	energy 0 ; energies
	tx Text173e ; name
	tx Text173f ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db POKEMON_POWER ; category
	dw $453b ; effect commands
	db NONE ; flags 1
	db FLAG_2_BIT_6  ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_PKMN_POWER_1 ; animation

	; attack 2
	energy PSYCHIC, 2 ; energies
	tx Text1505 ; name
	tx Text132f ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_NORMAL ; category
	dw $4546 ; effect commands
	db INFLICT_PARALYSIS  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_PSYCHIC_HIT ; animation

	db 1 ; retreat cost
	db WR_PSYCHIC ; weakness
	db NONE ; resistance
	tx Text1740 ; category
	db 80 ; Pokedex number
	db 0 ; ?
	db 26 ; level
	length 1.6 ; length
	weight 78.5 ; weight
	tx Text1741 ; description
	db AI_INFO_BENCH_UTILITY ; AI info

SlowbroLv35Card:
	db TYPE_PKMN_PSYCHIC ; type
	dw $9518 ; gfx
	tx Text173d ; name
	db CIRCLE ; rarity
	db SKY_FLYING_POKEMON ; set
	db 4 ; ?
	dw SLOWBRO_LV35
	db 90 ; hp
	db STAGE1 ; stage
	tx Text1732 ; pre-evo name

	; attack 1
	energy PSYCHIC, 1 ; energies
	tx Text1742 ; name
	tx Text1743 ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db DAMAGE_NORMAL ; category
	dw $5060 ; effect commands
	db INFLICT_SLEEP  ; flags 1
	db NONE ; flags 2
	db SPECIAL_AI_HANDLING | FLAG_3_BIT_2  ; flags 3
	db 0 ; ?
	db ATK_ANIM_234 ; animation

	; attack 2
	energy PSYCHIC, 2 ; energies
	tx Text1744 ; name
	tx Text1745 ; description
	dw NONE ; description (cont)
	db 30 ; damage
	db DAMAGE_NORMAL ; category
	dw $5068 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_235 ; animation

	db 3 ; retreat cost
	db WR_PSYCHIC ; weakness
	db NONE ; resistance
	tx Text1740 ; category
	db 80 ; Pokedex number
	db 0 ; ?
	db 35 ; level
	length 1.6 ; length
	weight 78.5 ; weight
	tx Text1746 ; description
	db NONE ; AI info

DarkSlowbroCard:
	db TYPE_PKMN_PSYCHIC ; type
	dw $6661 ; gfx
	tx Text1747 ; name
	db STAR ; rarity
	db PSYCHIC_BATTLE ; set
	db 6 ; ?
	dw DARK_SLOWBRO
	db 60 ; hp
	db STAGE1 ; stage
	tx Text1732 ; pre-evo name

	; attack 1
	energy 0 ; energies
	tx Text1748 ; name
	tx Text1749 ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db POKEMON_POWER ; category
	dw $4a7b ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_191 ; animation

	; attack 2
	energy PSYCHIC, 2 ; energies
	tx Text174a ; name
	tx Text138c ; description
	dw NONE ; description (cont)
	db 40 ; damage
	db DAMAGE_NORMAL ; category
	dw $4a86 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_HIT ; animation

	db 2 ; retreat cost
	db WR_PSYCHIC ; weakness
	db NONE ; resistance
	tx Text1740 ; category
	db 80 ; Pokedex number
	db 1 ; ?
	db 27 ; level
	length 1.6 ; length
	weight 78.5 ; weight
	tx Text174b ; description
	db NONE ; AI info

GastlyLv8Card:
	db TYPE_PKMN_PSYCHIC ; type
	dw $44d1 ; gfx
	tx Text174c ; name
	db CIRCLE ; rarity
	db BEGINNING_POKEMON ; set
	db 0 ; ?
	dw GASTLY_LV8
	db 30 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy PSYCHIC, 1 ; energies
	tx Text174d ; name
	tx Text174e ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db DAMAGE_NORMAL ; category
	dw $446b ; effect commands
	db INFLICT_SLEEP  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_SLEEPING_GAS ; animation

	; attack 2
	energy PSYCHIC, 1, COLORLESS, 1 ; energies
	tx Text174f ; name
	tx Text1750 ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db RESIDUAL ; category
	dw $4470 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db SPECIAL_AI_HANDLING | FLAG_3_BIT_2  ; flags 3
	db 3 ; ?
	db ATK_ANIM_GLOW_EFFECT ; animation

	db 0 ; retreat cost
	db NONE ; weakness
	db WR_FIGHTING ; resistance
	tx Text1751 ; category
	db 92 ; Pokedex number
	db 0 ; ?
	db 8 ; level
	length 1.3 ; length
	weight 0.1 ; weight
	tx Text1752 ; description
	db NONE | HAS_EVOLUTION ; AI info

GastlyLv13Card:
	db TYPE_PKMN_PSYCHIC ; type
	dw $9585 ; gfx
	tx Text174c ; name
	db CIRCLE ; rarity
	db SKY_FLYING_POKEMON ; set
	db 2 ; ?
	dw GASTLY_LV13
	db 40 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy COLORLESS, 1 ; energies
	tx Text1753 ; name
	tx Text1754 ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db RESIDUAL ; category
	dw $506d ; effect commands
	db NONE ; flags 1
	db FLAG_2_BIT_6  ; flags 2
	db FLAG_3_BIT_2  ; flags 3
	db 1 ; ?
	db ATK_ANIM_193 ; animation

	; attack 2
	energy PSYCHIC, 1, COLORLESS, 1 ; energies
	tx Text1755 ; name
	tx Text1336 ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_NORMAL ; category
	dw $5072 ; effect commands
	db INFLICT_CONFUSION  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_229 ; animation

	db 0 ; retreat cost
	db NONE ; weakness
	db WR_FIGHTING ; resistance
	tx Text1751 ; category
	db 92 ; Pokedex number
	db 0 ; ?
	db 13 ; level
	length 1.3 ; length
	weight 0.1 ; weight
	tx Text1756 ; description
	db NONE | HAS_EVOLUTION ; AI info

GastlyLv17Card:
	db TYPE_PKMN_PSYCHIC ; type
	dw $453a ; gfx
	tx Text174c ; name
	db DIAMOND ; rarity
	db ISLAND_OF_FOSSIL ; set
	db 3 ; ?
	dw GASTLY_LV17
	db 50 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy PSYCHIC, 1 ; energies
	tx Text1757 ; name
	tx Text132f ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_NORMAL ; category
	dw $4481 ; effect commands
	db INFLICT_PARALYSIS  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_GOO ; animation

	; attack 2
	energy PSYCHIC, 2 ; energies
	tx Text1758 ; name
	tx Text1759 ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db RESIDUAL ; category
	dw $4486 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db SPECIAL_AI_HANDLING | FLAG_3_BIT_2  ; flags 3
	db 10 ; ?
	db ATK_ANIM_ENERGY_CONVERSION ; animation

	db 0 ; retreat cost
	db NONE ; weakness
	db WR_FIGHTING ; resistance
	tx Text1751 ; category
	db 92 ; Pokedex number
	db 0 ; ?
	db 17 ; level
	length 1.3 ; length
	weight 0.1 ; weight
	tx Text175a ; description
	db AI_INFO_UNK_03 | HAS_EVOLUTION ; AI info

HaunterLv17Card:
	db TYPE_PKMN_PSYCHIC ; type
	dw $45a3 ; gfx
	tx Text175b ; name
	db STAR ; rarity
	db ISLAND_OF_FOSSIL ; set
	db 3 ; ?
	dw HAUNTER_LV17
	db 50 ; hp
	db STAGE1 ; stage
	tx Text174c ; pre-evo name

	; attack 1
	energy 0 ; energies
	tx Text175c ; name
	tx Text175d ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db POKEMON_POWER ; category
	dw $449e ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_PKMN_POWER_1 ; animation

	; attack 2
	energy PSYCHIC, 1, COLORLESS, 1 ; energies
	tx Text175e ; name
	tx Text13b6 ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_NORMAL ; category
	dw $44a3 ; effect commands
	db INFLICT_SLEEP  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_NIGHTMARE ; animation

	db 0 ; retreat cost
	db NONE ; weakness
	db WR_FIGHTING ; resistance
	tx Text1751 ; category
	db 93 ; Pokedex number
	db 0 ; ?
	db 17 ; level
	length 1.6 ; length
	weight 0.1 ; weight
	tx Text175f ; description
	db NONE | HAS_EVOLUTION ; AI info

HaunterLv22Card:
	db TYPE_PKMN_PSYCHIC ; type
	dw $460c ; gfx
	tx Text175b ; name
	db DIAMOND ; rarity
	db BEGINNING_POKEMON ; set
	db 0 ; ?
	dw HAUNTER_LV22
	db 60 ; hp
	db STAGE1 ; stage
	tx Text174c ; pre-evo name

	; attack 1
	energy PSYCHIC, 1 ; energies
	tx Text1416 ; name
	tx Text13b6 ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db DAMAGE_NORMAL ; category
	dw $4494 ; effect commands
	db INFLICT_SLEEP  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_HYPNOSIS ; animation

	; attack 2
	energy PSYCHIC, 2 ; energies
	tx Text1760 ; name
	tx Text1761 ; description
	dw NONE ; description (cont)
	db 50 ; damage
	db DAMAGE_NORMAL ; category
	dw $4499 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_PSYCHIC_HIT ; animation

	db 1 ; retreat cost
	db NONE ; weakness
	db WR_FIGHTING ; resistance
	tx Text1751 ; category
	db 93 ; Pokedex number
	db 0 ; ?
	db 22 ; level
	length 1.6 ; length
	weight 0.1 ; weight
	tx Text175f ; description
	db NONE | HAS_EVOLUTION ; AI info

HaunterLv25Card:
	db TYPE_PKMN_PSYCHIC ; type
	dw $9657 ; gfx
	tx Text175b ; name
	db STAR ; rarity
	db SKY_FLYING_POKEMON ; set
	db 4 ; ?
	dw HAUNTER_LV25
	db 60 ; hp
	db STAGE1 ; stage
	tx Text174c ; pre-evo name

	; attack 1
	energy PSYCHIC, 1 ; energies
	tx Text1762 ; name
	tx Text1336 ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db DAMAGE_NORMAL ; category
	dw $5084 ; effect commands
	db INFLICT_CONFUSION  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_192 ; animation

	; attack 2
	energy PSYCHIC, 2 ; energies
	tx Text1763 ; name
	tx Text1764 ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_PLUS ; category
	dw $5089 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_PSYCHIC_HIT ; animation

	db 1 ; retreat cost
	db NONE ; weakness
	db WR_FIGHTING ; resistance
	tx Text1751 ; category
	db 93 ; Pokedex number
	db 0 ; ?
	db 25 ; level
	length 1.6 ; length
	weight 0.1 ; weight
	tx Text1765 ; description
	db NONE | HAS_EVOLUTION ; AI info

HaunterLv26Card:
	db TYPE_PKMN_PSYCHIC ; type
	dw $95ee ; gfx
	tx Text175b ; name
	db DIAMOND ; rarity
	db SKY_FLYING_POKEMON ; set
	db 2 ; ?
	dw HAUNTER_LV26
	db 70 ; hp
	db STAGE1 ; stage
	tx Text174c ; pre-evo name

	; attack 1
	energy PSYCHIC, 1 ; energies
	tx Text1766 ; name
	tx Text1767 ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_X ; category
	dw $5077 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db SPECIAL_AI_HANDLING  ; flags 3
	db 0 ; ?
	db ATK_ANIM_PSYCHIC_HIT ; animation

	; attack 2
	energy PSYCHIC, 2 ; energies
	tx Text1768 ; name
	tx Text1769 ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_NORMAL ; category
	dw $507f ; effect commands
	db INFLICT_SLEEP | INFLICT_CONFUSION  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_NIGHTMARE ; animation

	db 1 ; retreat cost
	db NONE ; weakness
	db WR_FIGHTING ; resistance
	tx Text1751 ; category
	db 93 ; Pokedex number
	db 0 ; ?
	db 26 ; level
	length 1.6 ; length
	weight 0.1 ; weight
	tx Text1765 ; description
	db NONE | HAS_EVOLUTION ; AI info

DarkHaunterCard:
	db TYPE_PKMN_PSYCHIC ; type
	dw $c640 ; gfx
	tx Text176a ; name
	db DIAMOND ; rarity
	db GB ; set
	db 6 ; ?
	dw DARK_HAUNTER
	db 60 ; hp
	db STAGE1 ; stage
	tx Text174c ; pre-evo name

	; attack 1
	energy PSYCHIC, 2 ; energies
	tx Text176b ; name
	tx Text176c ; description
	dw NONE ; description (cont)
	db 30 ; damage
	db DAMAGE_NORMAL ; category
	dw $52e0 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db FLAG_3_BIT_2  ; flags 3
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
	db NONE ; weakness
	db WR_FIGHTING ; resistance
	tx Text1751 ; category
	db 93 ; Pokedex number
	db 1 ; ?
	db 23 ; level
	length 1.6 ; length
	weight 0.1 ; weight
	tx Text176d ; description
	db NONE | HAS_EVOLUTION ; AI info

GengarLv38Card:
	db TYPE_PKMN_PSYCHIC ; type
	dw $4675 ; gfx
	tx Text176e ; name
	db STAR ; rarity
	db ISLAND_OF_FOSSIL ; set
	db 2 ; ?
	dw GENGAR_LV38
	db 80 ; hp
	db STAGE2 ; stage
	tx Text175b ; pre-evo name

	; attack 1
	energy 0 ; energies
	tx Text176f ; name
	tx Text1770 ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db POKEMON_POWER ; category
	dw $4455 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_PKMN_POWER_1 ; animation

	; attack 2
	energy PSYCHIC, 3 ; energies
	tx Text1771 ; name
	tx Text15d5 ; description
	dw NONE ; description (cont)
	db 30 ; damage
	db DAMAGE_NORMAL ; category
	dw $4460 ; effect commands
	db DAMAGE_TO_OPPONENT_BENCH  ; flags 1
	db NONE ; flags 2
	db FLAG_3_BIT_2  ; flags 3
	db 10 ; ?
	db ATK_ANIM_DARK_MIND ; animation

	db 1 ; retreat cost
	db NONE ; weakness
	db WR_FIGHTING ; resistance
	tx Text1772 ; category
	db 94 ; Pokedex number
	db 0 ; ?
	db 38 ; level
	length 1.5 ; length
	weight 40.5 ; weight
	tx Text1773 ; description
	db AI_INFO_BENCH_UTILITY ; AI info

GengarLv40Card:
	db TYPE_PKMN_PSYCHIC ; type
	dw $96c8 ; gfx
	tx Text176e ; name
	db STAR ; rarity
	db SKY_FLYING_POKEMON ; set
	db 7 ; ?
	dw GENGAR_LV40
	db 80 ; hp
	db STAGE2 ; stage
	tx Text175b ; pre-evo name

	; attack 1
	energy 0 ; energies
	tx Text1774 ; name
	tx Text1775 ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db POKEMON_POWER ; category
	dw $5091 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_GLOW_EFFECT ; animation

	; attack 2
	energy PSYCHIC, 3 ; energies
	tx Text1776 ; name
	tx Text1769 ; description
	dw NONE ; description (cont)
	db 30 ; damage
	db DAMAGE_NORMAL ; category
	dw $509c ; effect commands
	db INFLICT_SLEEP | INFLICT_CONFUSION  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_NIGHTMARE ; animation

	db 2 ; retreat cost
	db NONE ; weakness
	db WR_FIGHTING ; resistance
	tx Text1772 ; category
	db 94 ; Pokedex number
	db 0 ; ?
	db 40 ; level
	length 1.5 ; length
	weight 40.5 ; weight
	tx Text1777 ; description
	db NONE ; AI info

DarkGengarCard:
	db TYPE_PKMN_PSYCHIC ; type
	dw $ca31 ; gfx
	tx Text1778 ; name
	db STAR ; rarity
	db GB ; set
	db 6 ; ?
	dw DARK_GENGAR
	db 70 ; hp
	db STAGE2 ; stage
	tx Text176a ; pre-evo name

	; attack 1
	energy 0 ; energies
	tx Text1779 ; name
	tx Text177a ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db POKEMON_POWER ; category
	dw $52e8 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_GLOW_EFFECT ; animation

	; attack 2
	energy PSYCHIC, 2 ; energies
	tx Text177b ; name
	tx Text177c ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db RESIDUAL ; category
	dw $52f0 ; effect commands
	db NONE ; flags 1
	db FLAG_2_BIT_6  ; flags 2
	db FLAG_3_BIT_2  ; flags 3
	db 1 ; ?
	db ATK_ANIM_253 ; animation

	db 2 ; retreat cost
	db NONE ; weakness
	db WR_FIGHTING ; resistance
	tx Text1772 ; category
	db 94 ; Pokedex number
	db 1 ; ?
	db 33 ; level
	length 1.5 ; length
	weight 40.5 ; weight
	tx Text177d ; description
	db NONE ; AI info

DrowzeeLv10Card:
	db TYPE_PKMN_PSYCHIC ; type
	dw $66d2 ; gfx
	tx Text177e ; name
	db CIRCLE ; rarity
	db PSYCHIC_BATTLE ; set
	db 6 ; ?
	dw DROWZEE_LV10
	db 50 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy 0 ; energies
	tx Text177f ; name
	tx Text1780 ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db POKEMON_POWER ; category
	dw $4a8e ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_HYPNOSIS ; animation

	; attack 2
	energy PSYCHIC, 1, COLORLESS, 1 ; energies
	tx Text175e ; name
	tx Text13b6 ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_NORMAL ; category
	dw $4a96 ; effect commands
	db INFLICT_SLEEP  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_NIGHTMARE ; animation

	db 1 ; retreat cost
	db WR_PSYCHIC ; weakness
	db NONE ; resistance
	tx Text1781 ; category
	db 96 ; Pokedex number
	db 0 ; ?
	db 10 ; level
	length 1.0 ; length
	weight 32.4 ; weight
	tx Text1782 ; description
	db NONE | HAS_EVOLUTION ; AI info

DrowzeeLv12Card:
	db TYPE_PKMN_PSYCHIC ; type
	dw $46e6 ; gfx
	tx Text177e ; name
	db CIRCLE ; rarity
	db BEGINNING_POKEMON ; set
	db 0 ; ?
	dw DROWZEE_LV12
	db 50 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
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

	; attack 2
	energy PSYCHIC, 2 ; energies
	tx Text1470 ; name
	tx Text137c ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_NORMAL ; category
	dw $44c1 ; effect commands
	db INFLICT_CONFUSION  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_CONFUSE_RAY ; animation

	db 1 ; retreat cost
	db WR_PSYCHIC ; weakness
	db NONE ; resistance
	tx Text1781 ; category
	db 96 ; Pokedex number
	db 0 ; ?
	db 12 ; level
	length 1.0 ; length
	weight 32.4 ; weight
	tx Text1783 ; description
	db AI_INFO_UNK_03 | HAS_EVOLUTION ; AI info

HypnoLv30Card:
	db TYPE_PKMN_PSYCHIC ; type
	dw $9731 ; gfx
	tx Text1784 ; name
	db DIAMOND ; rarity
	db SKY_FLYING_POKEMON ; set
	db 2 ; ?
	dw HYPNO_LV30
	db 60 ; hp
	db STAGE1 ; stage
	tx Text177e ; pre-evo name

	; attack 1
	energy 0 ; energies
	tx Text1785 ; name
	tx Text1786 ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db POKEMON_POWER ; category
	dw $50a1 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_NONE ; animation

	; attack 2
	energy PSYCHIC, 2 ; energies
	tx Text1724 ; name
	tx Text1608 ; description
	dw NONE ; description (cont)
	db 30 ; damage
	db DAMAGE_NORMAL ; category
	dw $50a6 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_PSYCHIC_HIT ; animation

	db 1 ; retreat cost
	db WR_PSYCHIC ; weakness
	db NONE ; resistance
	tx Text1781 ; category
	db 97 ; Pokedex number
	db 0 ; ?
	db 30 ; level
	length 1.6 ; length
	weight 75.6 ; weight
	tx Text1787 ; description
	db NONE ; AI info

HypnoLv36Card:
	db TYPE_PKMN_PSYCHIC ; type
	dw $474f ; gfx
	tx Text1784 ; name
	db STAR ; rarity
	db ISLAND_OF_FOSSIL ; set
	db 0 ; ?
	dw HYPNO_LV36
	db 90 ; hp
	db STAGE1 ; stage
	tx Text177e ; pre-evo name

	; attack 1
	energy PSYCHIC, 1 ; energies
	tx Text1788 ; name
	tx Text1789 ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db RESIDUAL ; category
	dw $44a8 ; effect commands
	db NONE ; flags 1
	db FLAG_2_BIT_5  ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_GLOW_EFFECT ; animation

	; attack 2
	energy PSYCHIC, 3 ; energies
	tx Text1771 ; name
	tx Text15d5 ; description
	dw NONE ; description (cont)
	db 30 ; damage
	db DAMAGE_NORMAL ; category
	dw $44b6 ; effect commands
	db DAMAGE_TO_OPPONENT_BENCH  ; flags 1
	db NONE ; flags 2
	db FLAG_3_BIT_2  ; flags 3
	db 10 ; ?
	db ATK_ANIM_DARK_MIND ; animation

	db 2 ; retreat cost
	db WR_PSYCHIC ; weakness
	db NONE ; resistance
	tx Text1781 ; category
	db 97 ; Pokedex number
	db 0 ; ?
	db 36 ; level
	length 1.6 ; length
	weight 75.6 ; weight
	tx Text178a ; description
	db NONE ; AI info

DarkHypnoCard:
	db TYPE_PKMN_PSYCHIC ; type
	dw $675b ; gfx
	tx Text178b ; name
	db STAR ; rarity
	db PSYCHIC_BATTLE ; set
	db 6 ; ?
	dw DARK_HYPNO
	db 60 ; hp
	db STAGE1 ; stage
	tx Text177e ; pre-evo name

	; attack 1
	energy PSYCHIC, 1 ; energies
	tx Text178c ; name
	dw NONE ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_NORMAL ; category
	dw NONE ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_177 ; animation

	; attack 2
	energy PSYCHIC, 2, COLORLESS, 1 ; energies
	tx Text178d ; name
	tx Text178e ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_X ; category
	dw $4a9b ; effect commands
	db NONE ; flags 1
	db FLAG_2_BIT_6  ; flags 2
	db NONE ; flags 3
	db 1 ; ?
	db ATK_ANIM_165 ; animation

	db 2 ; retreat cost
	db WR_PSYCHIC ; weakness
	db NONE ; resistance
	tx Text1781 ; category
	db 97 ; Pokedex number
	db 1 ; ?
	db 26 ; level
	length 1.6 ; length
	weight 75.6 ; weight
	tx Text178f ; description
	db NONE ; AI info

MrMimeLv20Card:
	db TYPE_PKMN_PSYCHIC ; type
	dw $7e58 ; gfx
	tx Text1790 ; name
	db STAR ; rarity
	db SKY_FLYING_POKEMON ; set
	db 5 ; ?
	dw MR_MIME_LV20
	db 50 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy 0 ; energies
	tx Text1791 ; name
	tx Text1792 ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db POKEMON_POWER ; category
	dw $4d30 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_NONE ; animation

	; attack 2
	energy PSYCHIC, 1, COLORLESS, 1 ; energies
	tx Text1793 ; name
	tx Text1794 ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_X ; category
	dw $4d35 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_HIT ; animation

	db 1 ; retreat cost
	db WR_PSYCHIC ; weakness
	db NONE ; resistance
	tx Text1795 ; category
	db 122 ; Pokedex number
	db 0 ; ?
	db 20 ; level
	length 1.3 ; length
	weight 54.5 ; weight
	tx Text1796 ; description
	db NONE ; AI info

MrMimeLv28Card:
	db TYPE_PKMN_PSYCHIC ; type
	dw $4800 ; gfx
	tx Text1790 ; name
	db STAR ; rarity
	db LEGENDARY_POWER ; set
	db 3 ; ?
	dw MR_MIME_LV28
	db 40 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy 0 ; energies
	tx Text1797 ; name
	tx Text1798 ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db POKEMON_POWER ; category
	dw $44c6 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_GLOW_EFFECT ; animation

	; attack 2
	energy PSYCHIC, 1, COLORLESS, 1 ; energies
	tx Text1799 ; name
	tx Text179a ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_PLUS ; category
	dw $44cb ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_PSYCHIC_HIT ; animation

	db 1 ; retreat cost
	db WR_PSYCHIC ; weakness
	db NONE ; resistance
	tx Text1795 ; category
	db 122 ; Pokedex number
	db 0 ; ?
	db 28 ; level
	length 1.3 ; length
	weight 54.5 ; weight
	tx Text179b ; description
	db AI_INFO_UNK_03 ; AI info

JynxLv18Card:
	db TYPE_PKMN_PSYCHIC ; type
	dw $89a4 ; gfx
	tx Text179c ; name
	db STAR ; rarity
	db SKY_FLYING_POKEMON ; set
	db 5 ; ?
	dw JYNX_LV18
	db 50 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy WATER, 1 ; energies
	tx Text179d ; name
	tx Text1363 ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_NORMAL ; category
	dw $4ec6 ; effect commands
	db INFLICT_PARALYSIS  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_181 ; animation

	; attack 2
	energy WATER, 2 ; energies
	tx Text179e ; name
	tx Text1596 ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_NORMAL ; category
	dw $4ecb ; effect commands
	db INFLICT_SLEEP  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_222 ; animation

	db 1 ; retreat cost
	db WR_PSYCHIC ; weakness
	db NONE ; resistance
	tx Text179f ; category
	db 124 ; Pokedex number
	db 0 ; ?
	db 18 ; level
	length 1.4 ; length
	weight 40.6 ; weight
	tx Text17a0 ; description
	db NONE ; AI info

JynxLv23Card:
	db TYPE_PKMN_PSYCHIC ; type
	dw $4869 ; gfx
	tx Text179c ; name
	db DIAMOND ; rarity
	db BEGINNING_POKEMON ; set
	db 2 ; ?
	dw JYNX_LV23
	db 70 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy PSYCHIC, 1 ; energies
	tx Text14e8 ; name
	tx Text1587 ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_X ; category
	dw $4589 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_203 ; animation

	; attack 2
	energy PSYCHIC, 2, COLORLESS, 1 ; energies
	tx Text1799 ; name
	tx Text179a ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_PLUS ; category
	dw $4591 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_PSYCHIC_HIT ; animation

	db 2 ; retreat cost
	db WR_PSYCHIC ; weakness
	db NONE ; resistance
	tx Text179f ; category
	db 124 ; Pokedex number
	db 0 ; ?
	db 23 ; level
	length 1.4 ; length
	weight 40.6 ; weight
	tx Text17a1 ; description
	db NONE ; AI info

JynxLv27Card:
	db TYPE_PKMN_PSYCHIC ; type
	dw $c13b ; gfx
	tx Text179c ; name
	db DIAMOND ; rarity
	db TEAM_ROCKETS_AMBITION ; set
	db 0 ; ?
	dw JYNX_LV27
	db 70 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
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

	; attack 2
	energy PSYCHIC, 1, COLORLESS, 1 ; energies
	tx Text14e8 ; name
	tx Text1628 ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_X ; category
	dw $528b ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_203 ; animation

	db 2 ; retreat cost
	db WR_PSYCHIC ; weakness
	db NONE ; resistance
	tx Text179f ; category
	db 124 ; Pokedex number
	db 0 ; ?
	db 27 ; level
	length 1.4 ; length
	weight 40.6 ; weight
	tx Text17a2 ; description
	db NONE ; AI info

MewtwoLv30Card:
	db TYPE_PKMN_PSYCHIC ; type
	dw $a069 ; gfx
	tx Text17a3 ; name
	db STAR ; rarity
	db PRO ; set
	db 7 ; ?
	dw MEWTWO_LV30
	db 60 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy PSYCHIC, 1 ; energies
	tx Text1615 ; name
	tx Text17a4 ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db RESIDUAL ; category
	dw $51c7 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db SPECIAL_AI_HANDLING | FLAG_3_BIT_2  ; flags 3
	db 0 ; ?
	db ATK_ANIM_GLOW_EFFECT ; animation

	; attack 2
	energy PSYCHIC, 3 ; energies
	tx Text17a5 ; name
	tx Text17a6 ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db RESIDUAL ; category
	dw $51d5 ; effect commands
	db DAMAGE_TO_OPPONENT_BENCH  ; flags 1
	db FLAG_2_BIT_6  ; flags 2
	db FLAG_3_BIT_2  ; flags 3
	db 2 ; ?
	db ATK_ANIM_PSYCHIC_HIT ; animation

	db 2 ; retreat cost
	db WR_PSYCHIC ; weakness
	db NONE ; resistance
	tx Text17a7 ; category
	db 150 ; Pokedex number
	db 0 ; ?
	db 30 ; level
	length 2.0 ; length
	weight 122.0 ; weight
	tx Text17a8 ; description
	db NONE ; AI info

MewtwoLv53Card:
	db TYPE_PKMN_PSYCHIC ; type
	dw $48d2 ; gfx
	tx Text17a3 ; name
	db STAR ; rarity
	db BEGINNING_POKEMON ; set
	db 5 ; ?
	dw MEWTWO_LV53
	db 60 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy PSYCHIC, 1, COLORLESS, 1 ; energies
	tx Text1509 ; name
	tx Text150a ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_PLUS ; category
	dw $4506 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_PSYCHIC_HIT ; animation

	; attack 2
	energy PSYCHIC, 2 ; energies
	tx Text1795 ; name
	tx Text17a9 ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db RESIDUAL ; category
	dw $450e ; effect commands
	db NONE ; flags 1
	db NULLIFY_OR_WEAKEN_ATTACK | DISCARD_ENERGY  ; flags 2
	db FLAG_3_BIT_2  ; flags 3
	db 2 ; ?
	db ATK_ANIM_BARRIER ; animation

	db 3 ; retreat cost
	db WR_PSYCHIC ; weakness
	db NONE ; resistance
	tx Text17a7 ; category
	db 150 ; Pokedex number
	db 0 ; ?
	db 53 ; level
	length 2.0 ; length
	weight 122.0 ; weight
	tx Text17aa ; description
	db NONE ; AI info

MewtwoLv54Card:
	db TYPE_PKMN_PSYCHIC ; type
	dw $8124 ; gfx
	tx Text17a3 ; name
	db STAR ; rarity
	db SKY_FLYING_POKEMON ; set
	db 1 ; ?
	dw MEWTWO_LV54
	db 80 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy PSYCHIC, 1 ; energies
	tx Text17ab ; name
	tx Text17ac ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_X ; category
	dw $4d6d ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_PSYCHIC_HIT ; animation

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
	db WR_PSYCHIC ; weakness
	db NONE ; resistance
	tx Text17a7 ; category
	db 150 ; Pokedex number
	db 0 ; ?
	db 54 ; level
	length 2.0 ; length
	weight 122.0 ; weight
	tx Text17ad ; description
	db NONE ; AI info

MewtwoLv60Card:
	db TYPE_PKMN_PSYCHIC ; type
	dw $493b ; gfx
	tx Text17a3 ; name
	db PROMOSTAR ; rarity
	db PRO ; set
	db 7 ; ?
	dw MEWTWO_LV60
	db 70 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy PSYCHIC, 1 ; energies
	tx Text17ae ; name
	tx Text17af ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db RESIDUAL ; category
	dw $452d ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db SPECIAL_AI_HANDLING | FLAG_3_BIT_2  ; flags 3
	db 0 ; ?
	db ATK_ANIM_GLOW_EFFECT ; animation

	; attack 2
	energy PSYCHIC, 2, COLORLESS, 1 ; energies
	tx Text17b0 ; name
	dw NONE ; description
	dw NONE ; description (cont)
	db 40 ; damage
	db DAMAGE_NORMAL ; category
	dw NONE ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_PSYCHIC_HIT ; animation

	db 2 ; retreat cost
	db WR_PSYCHIC ; weakness
	db NONE ; resistance
	tx Text17a7 ; category
	db 150 ; Pokedex number
	db 0 ; ?
	db 60 ; level
	length 2.0 ; length
	weight 122.0 ; weight
	tx Text17b1 ; description
	db NONE ; AI info

MewtwoAltLv60Card:
	db TYPE_PKMN_PSYCHIC ; type
	dw $49a4 ; gfx
	tx Text17a3 ; name
	db PROMOSTAR ; rarity
	db PRO ; set
	db 7 ; ?
	dw MEWTWO_ALT_LV60
	db 70 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy PSYCHIC, 1 ; energies
	tx Text17ae ; name
	tx Text17af ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db RESIDUAL ; category
	dw $451f ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db SPECIAL_AI_HANDLING | FLAG_3_BIT_2  ; flags 3
	db 0 ; ?
	db ATK_ANIM_GLOW_EFFECT ; animation

	; attack 2
	energy PSYCHIC, 2, COLORLESS, 1 ; energies
	tx Text17b0 ; name
	dw NONE ; description
	dw NONE ; description (cont)
	db 40 ; damage
	db DAMAGE_NORMAL ; category
	dw NONE ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_PSYCHIC_HIT ; animation

	db 2 ; retreat cost
	db WR_PSYCHIC ; weakness
	db NONE ; resistance
	tx Text17a7 ; category
	db 150 ; Pokedex number
	db 0 ; ?
	db 60 ; level
	length 2.0 ; length
	weight 122.0 ; weight
	tx Text17b1 ; description
	db NONE ; AI info

MewtwoLv67Card:
	db TYPE_PKMN_PSYCHIC ; type
	dw $9e27 ; gfx
	tx Text17a3 ; name
	db STAR ; rarity
	db SKY_FLYING_POKEMON ; set
	db 3 ; ?
	dw MEWTWO_LV67
	db 80 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy PSYCHIC, 2 ; energies
	tx Text17b2 ; name
	tx Text17b3 ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db RESIDUAL ; category
	dw $5161 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db SPECIAL_AI_HANDLING | FLAG_3_BIT_2  ; flags 3
	db 0 ; ?
	db ATK_ANIM_RECOVER ; animation

	; attack 2
	energy PSYCHIC, 2, COLORLESS, 1 ; energies
	tx Text17b4 ; name
	tx Text17b5 ; description
	dw NONE ; description (cont)
	db 30 ; damage
	db DAMAGE_NORMAL ; category
	dw $5169 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_PSYCHIC_HIT ; animation

	db 3 ; retreat cost
	db WR_PSYCHIC ; weakness
	db NONE ; resistance
	tx Text17a7 ; category
	db 150 ; Pokedex number
	db 0 ; ?
	db 67 ; level
	length 2.0 ; length
	weight 122.0 ; weight
	tx Text17b6 ; description
	db NONE ; AI info

GrsMewtwoCard:
	db TYPE_PKMN_PSYCHIC ; type
	dw $c56e ; gfx
	tx Text17b7 ; name
	db STAR ; rarity
	db GB ; set
	db 7 ; ?
	dw GRS_MEWTWO
	db 70 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy 0 ; energies
	tx Text17b8 ; name
	tx Text17b9 ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db POKEMON_POWER ; category
	dw $532c ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_NONE ; animation

	; attack 2
	energy PSYCHIC, 2 ; energies
	tx Text17ba ; name
	tx Text17bb ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_PLUS ; category
	dw $5331 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_PSYCHIC_HIT ; animation

	db 2 ; retreat cost
	db WR_PSYCHIC ; weakness
	db NONE ; resistance
	tx Text17a7 ; category
	db 150 ; Pokedex number
	db 0 ; ?
	db 35 ; level
	length 2.0 ; length
	weight 122.0 ; weight
	tx Text17bc ; description
	db NONE ; AI info

MewLv8Card:
	db TYPE_PKMN_PSYCHIC ; type
	dw $4a23 ; gfx
	tx Text17bd ; name
	db PROMOSTAR ; rarity
	db PRO ; set
	db 7 ; ?
	dw MEW_LV8
	db 40 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy 0 ; energies
	tx Text17be ; name
	tx Text17bf ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db POKEMON_POWER ; category
	dw $44fc ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_PKMN_POWER_1 ; animation

	; attack 2
	energy PSYCHIC, 1 ; energies
	tx Text1505 ; name
	tx Text1363 ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_NORMAL ; category
	dw $4501 ; effect commands
	db INFLICT_PARALYSIS  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_PSYCHIC_HIT ; animation

	db 1 ; retreat cost
	db WR_PSYCHIC ; weakness
	db NONE ; resistance
	tx Text17c0 ; category
	db 151 ; Pokedex number
	db 0 ; ?
	db 8 ; level
	length 0.4 ; length
	weight 4.0 ; weight
	tx Text17c1 ; description
	db AI_INFO_UNK_03 ; AI info

MewLv15Card:
	db TYPE_PKMN_PSYCHIC ; type
	dw $4a8c ; gfx
	tx Text17bd ; name
	db STAR ; rarity
	db GB ; set
	db 7 ; ?
	dw MEW_LV15
	db 50 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy PSYCHIC, 1, COLORLESS, 1 ; energies
	tx Text17c2 ; name
	tx Text17c3 ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db DAMAGE_NORMAL ; category
	dw $4599 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_HIT_EFFECT ; animation

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
	db WR_PSYCHIC ; weakness
	db NONE ; resistance
	tx Text17c0 ; category
	db 151 ; Pokedex number
	db 0 ; ?
	db 15 ; level
	length 0.4 ; length
	weight 4.0 ; weight
	tx Text17c4 ; description
	db NONE ; AI info

MewLv23Card:
	db TYPE_PKMN_PSYCHIC ; type
	dw $4af5 ; gfx
	tx Text17bd ; name
	db STAR ; rarity
	db ISLAND_OF_FOSSIL ; set
	db 3 ; ?
	dw MEW_LV23
	db 50 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy PSYCHIC, 1 ; energies
	tx Text17c5 ; name
	tx Text17c6 ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_X ; category
	dw $44e3 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_PSYCHIC_HIT ; animation

	; attack 2
	energy PSYCHIC, 2 ; energies
	tx Text17c7 ; name
	tx Text17c8 ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db RESIDUAL ; category
	dw $44eb ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db SPECIAL_AI_HANDLING | FLAG_3_BIT_2  ; flags 3
	db 0 ; ?
	db ATK_ANIM_NONE ; animation

	db 1 ; retreat cost
	db WR_PSYCHIC ; weakness
	db NONE ; resistance
	tx Text17c0 ; category
	db 151 ; Pokedex number
	db 0 ; ?
	db 23 ; level
	length 0.4 ; length
	weight 4.0 ; weight
	tx Text17c9 ; description
	db AI_INFO_UNK_08 ; AI info

PidgeyLv8Card:
	db TYPE_PKMN_COLORLESS ; type
	dw $4b5e ; gfx
	tx Text17ca ; name
	db CIRCLE ; rarity
	db BEGINNING_POKEMON ; set
	db 3 ; ?
	dw PIDGEY_LV8
	db 40 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy COLORLESS, 2 ; energies
	tx Text133e ; name
	tx Text133f ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_NORMAL ; category
	dw $485d ; effect commands
	db NONE ; flags 1
	db SWITCH_OPPONENT_POKEMON  ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_WHIRLWIND ; animation

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
	db WR_FIGHTING ; resistance
	tx Text17cb ; category
	db 16 ; Pokedex number
	db 0 ; ?
	db 8 ; level
	length 0.3 ; length
	weight 1.8 ; weight
	tx Text17cc ; description
	db AI_INFO_ENCOURAGE_EVO | HAS_EVOLUTION ; AI info

PidgeyLv10Card:
	db TYPE_PKMN_COLORLESS ; type
	dw $743f ; gfx
	tx Text17ca ; name
	db CIRCLE ; rarity
	db SKY_FLYING_POKEMON ; set
	db 4 ; ?
	dw PIDGEY_LV10
	db 50 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy COLORLESS, 1 ; energies
	tx Text17cd ; name
	dw NONE ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_NORMAL ; category
	dw NONE ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_WHIRLWIND ; animation

	; attack 2
	energy COLORLESS, 2 ; energies
	tx Text1490 ; name
	tx Text15e2 ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_PLUS ; category
	dw $4c42 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_QUICK_ATTACK ; animation

	db 1 ; retreat cost
	db WR_LIGHTNING ; weakness
	db WR_FIGHTING ; resistance
	tx Text17cb ; category
	db 16 ; Pokedex number
	db 0 ; ?
	db 10 ; level
	length 0.3 ; length
	weight 1.8 ; weight
	tx Text17ce ; description
	db NONE | HAS_EVOLUTION ; AI info

PidgeottoLv36Card:
	db TYPE_PKMN_COLORLESS ; type
	dw $4bc7 ; gfx
	tx Text17cf ; name
	db DIAMOND ; rarity
	db BEGINNING_POKEMON ; set
	db 4 ; ?
	dw PIDGEOTTO_LV36
	db 60 ; hp
	db STAGE1 ; stage
	tx Text17ca ; pre-evo name

	; attack 1
	energy COLORLESS, 2 ; energies
	tx Text133e ; name
	tx Text133f ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_NORMAL ; category
	dw $47fa ; effect commands
	db NONE ; flags 1
	db SWITCH_OPPONENT_POKEMON  ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_WHIRLWIND ; animation

	; attack 2
	energy COLORLESS, 3 ; energies
	tx Text17d0 ; name
	tx Text17d1 ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db DAMAGE_NORMAL ; category
	dw $4805 ; effect commands
	db NONE ; flags 1
	db FLAG_2_BIT_6  ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_MIRROR_MOVE ; animation

	db 1 ; retreat cost
	db WR_LIGHTNING ; weakness
	db WR_FIGHTING ; resistance
	tx Text17d2 ; category
	db 17 ; Pokedex number
	db 0 ; ?
	db 36 ; level
	length 1.1 ; length
	weight 30.0 ; weight
	tx Text17d3 ; description
	db NONE | HAS_EVOLUTION ; AI info

PidgeottoLv38Card:
	db TYPE_PKMN_COLORLESS ; type
	dw $8d46 ; gfx
	tx Text17cf ; name
	db DIAMOND ; rarity
	db SKY_FLYING_POKEMON ; set
	db 3 ; ?
	dw PIDGEOTTO_LV38
	db 60 ; hp
	db STAGE1 ; stage
	tx Text17ca ; pre-evo name

	; attack 1
	energy COLORLESS, 2 ; energies
	tx Text17d4 ; name
	tx Text17d5 ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_NORMAL ; category
	dw $4f34 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db SPECIAL_AI_HANDLING  ; flags 3
	db 0 ; ?
	db ATK_ANIM_WHIRLWIND ; animation

	; attack 2
	energy COLORLESS, 3 ; energies
	tx Text15d8 ; name
	tx Text17d6 ; description
	dw NONE ; description (cont)
	db 30 ; damage
	db DAMAGE_NORMAL ; category
	dw $4f39 ; effect commands
	db NONE ; flags 1
	db NULLIFY_OR_WEAKEN_ATTACK  ; flags 2
	db FLAG_3_BIT_2  ; flags 3
	db 0 ; ?
	db ATK_ANIM_AGILITY_PROTECT ; animation

	db 0 ; retreat cost
	db WR_LIGHTNING ; weakness
	db WR_FIGHTING ; resistance
	tx Text17d2 ; category
	db 17 ; Pokedex number
	db 0 ; ?
	db 38 ; level
	length 1.1 ; length
	weight 30.0 ; weight
	tx Text17d7 ; description
	db NONE | HAS_EVOLUTION ; AI info

PidgeotLv38Card:
	db TYPE_PKMN_COLORLESS ; type
	dw $4c30 ; gfx
	tx Text17d8 ; name
	db STAR ; rarity
	db GB ; set
	db 3 ; ?
	dw PIDGEOT_LV38
	db 80 ; hp
	db STAGE2 ; stage
	tx Text17cf ; pre-evo name

	; attack 1
	energy COLORLESS, 3 ; energies
	tx Text17d9 ; name
	tx Text17da ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db RESIDUAL ; category
	dw $48be ; effect commands
	db DAMAGE_TO_OPPONENT_BENCH  ; flags 1
	db FLAG_2_BIT_6  ; flags 2
	db FLAG_3_BIT_2  ; flags 3
	db 2 ; ?
	db ATK_ANIM_WHIRLWIND_ZIGZAG ; animation

	; attack 2
	energy COLORLESS, 4 ; energies
	tx Text17db ; name
	tx Text17dc ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_NORMAL ; category
	dw $48c3 ; effect commands
	db NONE ; flags 1
	db SWITCH_OPPONENT_POKEMON  ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_GLOW_EFFECT ; animation

	db 1 ; retreat cost
	db WR_LIGHTNING ; weakness
	db WR_FIGHTING ; resistance
	tx Text17d2 ; category
	db 18 ; Pokedex number
	db 0 ; ?
	db 38 ; level
	length 1.5 ; length
	weight 39.5 ; weight
	tx Text17dd ; description
	db NONE ; AI info

PidgeotLv40Card:
	db TYPE_PKMN_COLORLESS ; type
	dw $4c99 ; gfx
	tx Text17d8 ; name
	db STAR ; rarity
	db LEGENDARY_POWER ; set
	db 4 ; ?
	dw PIDGEOT_LV40
	db 80 ; hp
	db STAGE2 ; stage
	tx Text17cf ; pre-evo name

	; attack 1
	energy COLORLESS, 2 ; energies
	tx Text13a8 ; name
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
	energy COLORLESS, 3 ; energies
	tx Text17de ; name
	tx Text17df ; description
	dw NONE ; description (cont)
	db 30 ; damage
	db DAMAGE_NORMAL ; category
	dw $47f5 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_WHIRLWIND ; animation

	db 0 ; retreat cost
	db WR_LIGHTNING ; weakness
	db WR_FIGHTING ; resistance
	tx Text17d2 ; category
	db 18 ; Pokedex number
	db 0 ; ?
	db 40 ; level
	length 1.5 ; length
	weight 39.5 ; weight
	tx Text17e0 ; description
	db NONE ; AI info

RattataLv9Card:
	db TYPE_PKMN_COLORLESS ; type
	dw $4d02 ; gfx
	tx Text17e1 ; name
	db CIRCLE ; rarity
	db BEGINNING_POKEMON ; set
	db 0 ; ?
	dw RATTATA_LV9
	db 30 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy COLORLESS, 1 ; energies
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
	db WR_FIGHTING ; weakness
	db WR_PSYCHIC ; resistance
	tx Text15c9 ; category
	db 19 ; Pokedex number
	db 0 ; ?
	db 9 ; level
	length 0.3 ; length
	weight 3.5 ; weight
	tx Text17e2 ; description
	db AI_INFO_UNK_03 | HAS_EVOLUTION ; AI info

RattataLv12Card:
	db TYPE_PKMN_COLORLESS ; type
	dw $6b2f ; gfx
	tx Text17e1 ; name
	db CIRCLE ; rarity
	db PSYCHIC_BATTLE ; set
	db 5 ; ?
	dw RATTATA_LV12
	db 40 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy 0 ; energies
	tx Text17e3 ; name
	tx Text17e4 ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db POKEMON_POWER ; category
	dw $4b02 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_GLOW_EFFECT ; animation

	; attack 2
	energy COLORLESS, 1 ; energies
	tx Text1490 ; name
	tx Text1448 ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_PLUS ; category
	dw $4b0a ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_QUICK_ATTACK ; animation

	db 0 ; retreat cost
	db WR_FIGHTING ; weakness
	db WR_PSYCHIC ; resistance
	tx Text15c9 ; category
	db 19 ; Pokedex number
	db 0 ; ?
	db 12 ; level
	length 0.3 ; length
	weight 3.5 ; weight
	tx Text17e5 ; description
	db NONE | HAS_EVOLUTION ; AI info

RattataLv15Card:
	db TYPE_PKMN_COLORLESS ; type
	dw $74c2 ; gfx
	tx Text17e1 ; name
	db CIRCLE ; rarity
	db SKY_FLYING_POKEMON ; set
	db 4 ; ?
	dw RATTATA_LV15
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
	db ATK_ANIM_HIT ; animation

	; attack 2
	energy COLORLESS, 1 ; energies
	tx Text136e ; name
	tx Text136f ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db DAMAGE_NORMAL ; category
	dw $4c4a ; effect commands
	db NONE ; flags 1
	db NULLIFY_OR_WEAKEN_ATTACK  ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_201 ; animation

	db 1 ; retreat cost
	db WR_FIGHTING ; weakness
	db WR_PSYCHIC ; resistance
	tx Text15c9 ; category
	db 19 ; Pokedex number
	db 0 ; ?
	db 15 ; level
	length 0.3 ; length
	weight 3.5 ; weight
	tx Text17e6 ; description
	db NONE | HAS_EVOLUTION ; AI info

RaticateCard:
	db TYPE_PKMN_COLORLESS ; type
	dw $4d6d ; gfx
	tx Text17e7 ; name
	db DIAMOND ; rarity
	db BEGINNING_POKEMON ; set
	db 0 ; ?
	dw RATICATE
	db 60 ; hp
	db STAGE1 ; stage
	tx Text17e1 ; pre-evo name

	; attack 1
	energy COLORLESS, 1 ; energies
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

	; attack 2
	energy COLORLESS, 3 ; energies
	tx Text17e8 ; name
	tx Text17e9 ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db DAMAGE_NORMAL ; category
	dw $488e ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_HIT ; animation

	db 1 ; retreat cost
	db WR_FIGHTING ; weakness
	db WR_PSYCHIC ; resistance
	tx Text15c9 ; category
	db 20 ; Pokedex number
	db 0 ; ?
	db 41 ; level
	length 0.7 ; length
	weight 18.5 ; weight
	tx Text17ea ; description
	db AI_INFO_UNK_03 ; AI info

DarkRaticateCard:
	db TYPE_PKMN_COLORLESS ; type
	dw $6b98 ; gfx
	tx Text17eb ; name
	db CIRCLE ; rarity
	db PSYCHIC_BATTLE ; set
	db 5 ; ?
	dw DARK_RATICATE
	db 50 ; hp
	db STAGE1 ; stage
	tx Text17e1 ; pre-evo name

	; attack 1
	energy COLORLESS, 2 ; energies
	tx Text15cb ; name
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
	energy COLORLESS, 3 ; energies
	tx Text17ec ; name
	tx Text138c ; description
	dw NONE ; description (cont)
	db 50 ; damage
	db DAMAGE_NORMAL ; category
	dw $4b12 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_HIT ; animation

	db 1 ; retreat cost
	db WR_FIGHTING ; weakness
	db WR_PSYCHIC ; resistance
	tx Text15c9 ; category
	db 20 ; Pokedex number
	db 1 ; ?
	db 25 ; level
	length 0.7 ; length
	weight 18.5 ; weight
	tx Text17ed ; description
	db NONE ; AI info

SpearowLv9Card:
	db TYPE_PKMN_COLORLESS ; type
	dw $c2eb ; gfx
	tx Text17ee ; name
	db CIRCLE ; rarity
	db SQUIRTLE_DECK ; set
	db 1 ; ?
	dw SPEAROW_LV9
	db 40 ; hp
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
	energy COLORLESS, 2 ; energies
	tx Text13a8 ; name
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
	db WR_LIGHTNING ; weakness
	db WR_FIGHTING ; resistance
	tx Text17cb ; category
	db 21 ; Pokedex number
	db 0 ; ?
	db 9 ; level
	length 0.3 ; length
	weight 2.0 ; weight
	tx Text17ef ; description
	db NONE | HAS_EVOLUTION ; AI info

SpearowLv12Card:
	db TYPE_PKMN_COLORLESS ; type
	dw $818f ; gfx
	tx Text17ee ; name
	db CIRCLE ; rarity
	db SKY_FLYING_POKEMON ; set
	db 3 ; ?
	dw SPEAROW_LV12
	db 40 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy COLORLESS, 1 ; energies
	tx Text17f0 ; name
	tx Text1587 ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_X ; category
	dw $4dcd ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_MULTIPLE_SLASH ; animation

	; attack 2
	energy COLORLESS, 1 ; energies
	tx Text17cd ; name
	dw NONE ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_NORMAL ; category
	dw NONE ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_WHIRLWIND ; animation

	db 0 ; retreat cost
	db WR_LIGHTNING ; weakness
	db WR_FIGHTING ; resistance
	tx Text17cb ; category
	db 21 ; Pokedex number
	db 0 ; ?
	db 12 ; level
	length 0.3 ; length
	weight 2.0 ; weight
	tx Text17f1 ; description
	db NONE | HAS_EVOLUTION ; AI info

SpearowLv13Card:
	db TYPE_PKMN_COLORLESS ; type
	dw $4dd6 ; gfx
	tx Text17ee ; name
	db CIRCLE ; rarity
	db LEGENDARY_POWER ; set
	db 4 ; ?
	dw SPEAROW_LV13
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
	energy COLORLESS, 3 ; energies
	tx Text17d0 ; name
	tx Text17d1 ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db DAMAGE_NORMAL ; category
	dw $4751 ; effect commands
	db NONE ; flags 1
	db FLAG_2_BIT_6  ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_MIRROR_MOVE ; animation

	db 0 ; retreat cost
	db WR_LIGHTNING ; weakness
	db WR_FIGHTING ; resistance
	tx Text17cb ; category
	db 21 ; Pokedex number
	db 0 ; ?
	db 13 ; level
	length 0.3 ; length
	weight 2.0 ; weight
	tx Text17f2 ; description
	db AI_INFO_UNK_03 | HAS_EVOLUTION ; AI info

FearowLv24Card:
	db TYPE_PKMN_COLORLESS ; type
	dw $81f8 ; gfx
	tx Text17f3 ; name
	db DIAMOND ; rarity
	db SKY_FLYING_POKEMON ; set
	db 4 ; ?
	dw FEAROW_LV24
	db 60 ; hp
	db STAGE1 ; stage
	tx Text17ee ; pre-evo name

	; attack 1
	energy COLORLESS, 2 ; energies
	tx Text1490 ; name
	tx Text15e2 ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_PLUS ; category
	dw $4dd5 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_QUICK_ATTACK ; animation

	; attack 2
	energy COLORLESS, 3 ; energies
	tx Text17f4 ; name
	tx Text138c ; description
	dw NONE ; description (cont)
	db 50 ; damage
	db DAMAGE_NORMAL ; category
	dw $4ddd ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_DRILL ; animation

	db 0 ; retreat cost
	db WR_LIGHTNING ; weakness
	db WR_FIGHTING ; resistance
	tx Text17f5 ; category
	db 22 ; Pokedex number
	db 0 ; ?
	db 24 ; level
	length 1.2 ; length
	weight 38.0 ; weight
	tx Text17f6 ; description
	db NONE ; AI info

FearowLv27Card:
	db TYPE_PKMN_COLORLESS ; type
	dw $4e87 ; gfx
	tx Text17f3 ; name
	db DIAMOND ; rarity
	db LEGENDARY_POWER ; set
	db 3 ; ?
	dw FEAROW_LV27
	db 70 ; hp
	db STAGE1 ; stage
	tx Text17ee ; pre-evo name

	; attack 1
	energy COLORLESS, 3 ; energies
	tx Text14ab ; name
	tx Text14ac ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_NORMAL ; category
	dw $476b ; effect commands
	db NONE ; flags 1
	db NULLIFY_OR_WEAKEN_ATTACK  ; flags 2
	db FLAG_3_BIT_2  ; flags 3
	db 0 ; ?
	db ATK_ANIM_QUICK_ATTACK ; animation

	; attack 2
	energy COLORLESS, 4 ; energies
	tx Text17f7 ; name
	dw NONE ; description
	dw NONE ; description (cont)
	db 40 ; damage
	db DAMAGE_NORMAL ; category
	dw NONE ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_DRILL ; animation

	db 0 ; retreat cost
	db WR_LIGHTNING ; weakness
	db WR_FIGHTING ; resistance
	tx Text17f5 ; category
	db 22 ; Pokedex number
	db 0 ; ?
	db 27 ; level
	length 1.2 ; length
	weight 38.0 ; weight
	tx Text17f8 ; description
	db NONE ; AI info

DarkFearowCard:
	db TYPE_PKMN_COLORLESS ; type
	dw $c93b ; gfx
	tx Text17f9 ; name
	db DIAMOND ; rarity
	db GB ; set
	db 6 ; ?
	dw DARK_FEAROW
	db 60 ; hp
	db STAGE1 ; stage
	tx Text17ee ; pre-evo name

	; attack 1
	energy COLORLESS, 1 ; energies
	tx Text17fa ; name
	tx Text17fb ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db RESIDUAL ; category
	dw $5308 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db SPECIAL_AI_HANDLING | FLAG_3_BIT_2  ; flags 3
	db 0 ; ?
	db ATK_ANIM_GLOW_EFFECT ; animation

	; attack 2
	energy COLORLESS, 2 ; energies
	tx Text17fc ; name
	tx Text17fd ; description
	dw NONE ; description (cont)
	db 40 ; damage
	db DAMAGE_NORMAL ; category
	dw $530d ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_246 ; animation

	db 0 ; retreat cost
	db WR_LIGHTNING ; weakness
	db WR_FIGHTING ; resistance
	tx Text17f5 ; category
	db 22 ; Pokedex number
	db 1 ; ?
	db 25 ; level
	length 1.2 ; length
	weight 38.0 ; weight
	tx Text17fe ; description
	db NONE ; AI info

ClefairyLv14Card:
	db TYPE_PKMN_COLORLESS ; type
	dw $4f10 ; gfx
	tx Text17ff ; name
	db STAR ; rarity
	db BEGINNING_POKEMON ; set
	db 3 ; ?
	dw CLEFAIRY_LV14
	db 40 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy COLORLESS, 1 ; energies
	tx Text1595 ; name
	tx Text174e ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db DAMAGE_NORMAL ; category
	dw $481f ; effect commands
	db INFLICT_SLEEP  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_SING ; animation

	; attack 2
	energy COLORLESS, 3 ; energies
	tx Text1800 ; name
	tx Text1801 ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db RESIDUAL ; category
	dw $4824 ; effect commands
	db NONE ; flags 1
	db FLAG_2_BIT_5  ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_NONE ; animation

	db 1 ; retreat cost
	db WR_FIGHTING ; weakness
	db WR_PSYCHIC ; resistance
	tx Text1802 ; category
	db 35 ; Pokedex number
	db 0 ; ?
	db 14 ; level
	length 0.6 ; length
	weight 7.5 ; weight
	tx Text1803 ; description
	db AI_INFO_ENCOURAGE_EVO | HAS_EVOLUTION ; AI info

ClefairyLv15Card:
	db TYPE_PKMN_COLORLESS ; type
	dw $76de ; gfx
	tx Text17ff ; name
	db DIAMOND ; rarity
	db SKY_FLYING_POKEMON ; set
	db 1 ; ?
	dw CLEFAIRY_LV15
	db 50 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy COLORLESS, 1 ; energies
	tx Text1804 ; name
	tx Text13fd ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db RESIDUAL ; category
	dw $4c73 ; effect commands
	db NONE ; flags 1
	db SWITCH_OPPONENT_POKEMON  ; flags 2
	db FLAG_3_BIT_2  ; flags 3
	db 0 ; ?
	db ATK_ANIM_212 ; animation

	; attack 2
	energy COLORLESS, 2 ; energies
	tx Text1805 ; name
	tx Text13b6 ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_NORMAL ; category
	dw $4c81 ; effect commands
	db INFLICT_SLEEP  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_213 ; animation

	db 1 ; retreat cost
	db WR_FIGHTING ; weakness
	db WR_PSYCHIC ; resistance
	tx Text1802 ; category
	db 35 ; Pokedex number
	db 0 ; ?
	db 15 ; level
	length 0.6 ; length
	weight 7.5 ; weight
	tx Text1806 ; description
	db NONE | HAS_EVOLUTION ; AI info

ClefableCard:
	db TYPE_PKMN_COLORLESS ; type
	dw $4f79 ; gfx
	tx Text1807 ; name
	db STAR ; rarity
	db LEGENDARY_POWER ; set
	db 2 ; ?
	dw CLEFABLE
	db 70 ; hp
	db STAGE1 ; stage
	tx Text17ff ; pre-evo name

	; attack 1
	energy COLORLESS, 1 ; energies
	tx Text1800 ; name
	tx Text1801 ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db RESIDUAL ; category
	dw $47e5 ; effect commands
	db NONE ; flags 1
	db FLAG_2_BIT_5  ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_NONE ; animation

	; attack 2
	energy COLORLESS, 2 ; energies
	tx Text1408 ; name
	tx Text1808 ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db RESIDUAL ; category
	dw $47f0 ; effect commands
	db NONE ; flags 1
	db NULLIFY_OR_WEAKEN_ATTACK  ; flags 2
	db FLAG_3_BIT_2  ; flags 3
	db 20 ; ?
	db ATK_ANIM_PROTECT ; animation

	db 2 ; retreat cost
	db WR_FIGHTING ; weakness
	db WR_PSYCHIC ; resistance
	tx Text1802 ; category
	db 36 ; Pokedex number
	db 0 ; ?
	db 34 ; level
	length 1.3 ; length
	weight 40.0 ; weight
	tx Text1809 ; description
	db NONE ; AI info

DarkClefableCard:
	db TYPE_PKMN_COLORLESS ; type
	dw $c724 ; gfx
	tx Text180a ; name
	db STAR ; rarity
	db GB ; set
	db 6 ; ?
	dw DARK_CLEFABLE
	db 70 ; hp
	db STAGE1 ; stage
	tx Text17ff ; pre-evo name

	; attack 1
	energy 0 ; energies
	tx Text180b ; name
	tx Text180c ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db POKEMON_POWER ; category
	dw $52d3 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_NONE ; animation

	; attack 2
	energy COLORLESS, 3 ; energies
	tx Text180d ; name
	tx Text180e ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_NORMAL ; category
	dw $52d8 ; effect commands
	db INFLICT_SLEEP  ; flags 1
	db NONE ; flags 2
	db FLAG_3_BIT_2  ; flags 3
	db 0 ; ?
	db ATK_ANIM_247 ; animation

	db 2 ; retreat cost
	db WR_FIGHTING ; weakness
	db WR_PSYCHIC ; resistance
	tx Text1802 ; category
	db 36 ; Pokedex number
	db 1 ; ?
	db 33 ; level
	length 1.3 ; length
	weight 40.0 ; weight
	tx Text180f ; description
	db NONE ; AI info

JigglypuffLv12Card:
	db TYPE_PKMN_COLORLESS ; type
	dw $5000 ; gfx
	tx Text1810 ; name
	db PROMOSTAR ; rarity
	db PRO ; set
	db 7 ; ?
	dw JIGGLYPUFF_LV12
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
	dw $4841 ; effect commands
	db NONE ; flags 1
	db HEAL_USER  ; flags 2
	db FLAG_3_BIT_2  ; flags 3
	db 1 ; ?
	db ATK_ANIM_RECOVER ; animation

	; attack 2
	energy COLORLESS, 3 ; energies
	tx Text1811 ; name
	tx Text1497 ; description
	dw NONE ; description (cont)
	db 40 ; damage
	db DAMAGE_NORMAL ; category
	dw $4849 ; effect commands
	db LOW_RECOIL  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 20 ; ?
	db ATK_ANIM_HIT_RECOIL ; animation

	db 1 ; retreat cost
	db WR_FIGHTING ; weakness
	db WR_PSYCHIC ; resistance
	tx Text1812 ; category
	db 39 ; Pokedex number
	db 0 ; ?
	db 12 ; level
	length 0.5 ; length
	weight 5.5 ; weight
	tx Text1813 ; description
	db NONE | HAS_EVOLUTION ; AI info

JigglypuffLv13Card:
	db TYPE_PKMN_COLORLESS ; type
	dw $5069 ; gfx
	tx Text1810 ; name
	db CIRCLE ; rarity
	db GB ; set
	db 3 ; ?
	dw JIGGLYPUFF_LV13
	db 50 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy COLORLESS, 1 ; energies
	tx Text1814 ; name
	tx Text1815 ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db RESIDUAL ; category
	dw $48cb ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db SPECIAL_AI_HANDLING | FLAG_3_BIT_2  ; flags 3
	db 0 ; ?
	db ATK_ANIM_NONE ; animation

	; attack 2
	energy COLORLESS, 2 ; energies
	tx Text1816 ; name
	tx Text1817 ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_NORMAL ; category
	dw $48d3 ; effect commands
	db NONE ; flags 1
	db NULLIFY_OR_WEAKEN_ATTACK  ; flags 2
	db FLAG_3_BIT_2  ; flags 3
	db 10 ; ?
	db ATK_ANIM_EXPAND ; animation

	db 1 ; retreat cost
	db WR_FIGHTING ; weakness
	db WR_PSYCHIC ; resistance
	tx Text1812 ; category
	db 39 ; Pokedex number
	db 0 ; ?
	db 13 ; level
	length 0.5 ; length
	weight 5.5 ; weight
	tx Text1818 ; description
	db NONE | HAS_EVOLUTION ; AI info

JigglypuffLv14Card:
	db TYPE_PKMN_COLORLESS ; type
	dw $50d2 ; gfx
	tx Text1810 ; name
	db CIRCLE ; rarity
	db LEGENDARY_POWER ; set
	db 1 ; ?
	dw JIGGLYPUFF_LV14
	db 60 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy COLORLESS, 1 ; energies
	tx Text1819 ; name
	tx Text13b6 ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db DAMAGE_NORMAL ; category
	dw $483c ; effect commands
	db INFLICT_SLEEP  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_LULLABY ; animation

	; attack 2
	energy COLORLESS, 2 ; energies
	tx Text14de ; name
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
	db WR_FIGHTING ; weakness
	db WR_PSYCHIC ; resistance
	tx Text1812 ; category
	db 39 ; Pokedex number
	db 0 ; ?
	db 14 ; level
	length 0.5 ; length
	weight 5.5 ; weight
	tx Text181a ; description
	db NONE | HAS_EVOLUTION ; AI info

WigglytuffLv36Card:
	db TYPE_PKMN_COLORLESS ; type
	dw $513b ; gfx
	tx Text181b ; name
	db STAR ; rarity
	db LEGENDARY_POWER ; set
	db 1 ; ?
	dw WIGGLYTUFF_LV36
	db 80 ; hp
	db STAGE1 ; stage
	tx Text1810 ; pre-evo name

	; attack 1
	energy COLORLESS, 1 ; energies
	tx Text1819 ; name
	tx Text13b6 ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db DAMAGE_NORMAL ; category
	dw $482f ; effect commands
	db INFLICT_SLEEP  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_LULLABY ; animation

	; attack 2
	energy COLORLESS, 3 ; energies
	tx Text181c ; name
	tx Text181d ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_PLUS ; category
	dw $4834 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_HIT ; animation

	db 2 ; retreat cost
	db WR_FIGHTING ; weakness
	db WR_PSYCHIC ; resistance
	tx Text1812 ; category
	db 40 ; Pokedex number
	db 0 ; ?
	db 36 ; level
	length 1.0 ; length
	weight 12.0 ; weight
	tx Text181e ; description
	db NONE ; AI info

WigglytuffLv40Card:
	db TYPE_PKMN_COLORLESS ; type
	dw $7747 ; gfx
	tx Text181b ; name
	db STAR ; rarity
	db SKY_FLYING_POKEMON ; set
	db 4 ; ?
	dw WIGGLYTUFF_LV40
	db 90 ; hp
	db STAGE1 ; stage
	tx Text1810 ; pre-evo name

	; attack 1
	energy 0 ; energies
	tx Text181f ; name
	tx Text1820 ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db POKEMON_POWER ; category
	dw $4c86 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_238 ; animation

	; attack 2
	energy COLORLESS, 4 ; energies
	tx Text1816 ; name
	tx Text1821 ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_NORMAL ; category
	dw $4c91 ; effect commands
	db NONE ; flags 1
	db NULLIFY_OR_WEAKEN_ATTACK  ; flags 2
	db FLAG_3_BIT_2  ; flags 3
	db 10 ; ?
	db ATK_ANIM_EXPAND ; animation

	db 3 ; retreat cost
	db WR_FIGHTING ; weakness
	db WR_PSYCHIC ; resistance
	tx Text1812 ; category
	db 40 ; Pokedex number
	db 0 ; ?
	db 40 ; level
	length 1.0 ; length
	weight 12.0 ; weight
	tx Text1822 ; description
	db NONE ; AI info

MeowthLv10Card:
	db TYPE_PKMN_COLORLESS ; type
	dw $6c11 ; gfx
	tx Text1823 ; name
	db CIRCLE ; rarity
	db PSYCHIC_BATTLE ; set
	db 6 ; ?
	dw MEOWTH_LV10
	db 40 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy COLORLESS, 2 ; energies
	tx Text1824 ; name
	tx Text1825 ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db RESIDUAL ; category
	dw $4b1a ; effect commands
	db DAMAGE_TO_OPPONENT_BENCH  ; flags 1
	db FLAG_2_BIT_6  ; flags 2
	db FLAG_3_BIT_2  ; flags 3
	db 2 ; ?
	db ATK_ANIM_208 ; animation

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
	db WR_PSYCHIC ; resistance
	tx Text1826 ; category
	db 52 ; Pokedex number
	db 0 ; ?
	db 10 ; level
	length 0.4 ; length
	weight 4.2 ; weight
	tx Text1827 ; description
	db NONE | HAS_EVOLUTION ; AI info

MeowthLv13Card:
	db TYPE_PKMN_COLORLESS ; type
	dw $51a4 ; gfx
	tx Text1823 ; name
	db DIAMOND ; rarity
	db GB ; set
	db 5 ; ?
	dw MEOWTH_LV13
	db 50 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy COLORLESS, 2 ; energies
	tx Text1828 ; name
	tx Text1829 ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db RESIDUAL ; category
	dw $48b1 ; effect commands
	db DAMAGE_TO_OPPONENT_BENCH  ; flags 1
	db FLAG_2_BIT_6  ; flags 2
	db FLAG_3_BIT_2  ; flags 3
	db 2 ; ?
	db ATK_ANIM_CAT_PUNCH ; animation

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
	db WR_PSYCHIC ; resistance
	tx Text1826 ; category
	db 52 ; Pokedex number
	db 0 ; ?
	db 13 ; level
	length 0.4 ; length
	weight 4.2 ; weight
	tx Text182a ; description
	db NONE | HAS_EVOLUTION ; AI info

MeowthLv14Card:
	db TYPE_PKMN_COLORLESS ; type
	dw $9ef9 ; gfx
	tx Text1823 ; name
	db PROMOSTAR ; rarity
	db PRO ; set
	db 7 ; ?
	dw MEOWTH_LV14
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
	energy COLORLESS, 1 ; energies
	tx Text182b ; name
	tx Text182c ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db RESIDUAL ; category
	dw $5190 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db SPECIAL_AI_HANDLING | FLAG_3_BIT_2  ; flags 3
	db 0 ; ?
	db ATK_ANIM_GLOW_EFFECT ; animation

	db 1 ; retreat cost
	db WR_FIGHTING ; weakness
	db WR_PSYCHIC ; resistance
	tx Text1826 ; category
	db 52 ; Pokedex number
	db 0 ; ?
	db 14 ; level
	length 0.4 ; length
	weight 4.2 ; weight
	tx Text182d ; description
	db NONE | HAS_EVOLUTION ; AI info

MeowthLv15Card:
	db TYPE_PKMN_COLORLESS ; type
	dw $5211 ; gfx
	tx Text1823 ; name
	db CIRCLE ; rarity
	db LEGENDARY_POWER ; set
	db 2 ; ?
	dw MEOWTH_LV15
	db 50 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy COLORLESS, 2 ; energies
	tx Text182e ; name
	tx Text182f ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_NORMAL ; category
	dw $47cd ; effect commands
	db DRAW_CARD  ; flags 1
	db NONE ; flags 2
	db FLAG_3_BIT_2  ; flags 3
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
	db WR_PSYCHIC ; resistance
	tx Text1826 ; category
	db 52 ; Pokedex number
	db 0 ; ?
	db 15 ; level
	length 0.4 ; length
	weight 4.2 ; weight
	tx Text1830 ; description
	db NONE | HAS_EVOLUTION ; AI info

MeowthLv17Card:
	db TYPE_PKMN_COLORLESS ; type
	dw $c35c ; gfx
	tx Text1823 ; name
	db CIRCLE ; rarity
	db TEAM_ROCKETS_AMBITION ; set
	db 0 ; ?
	dw MEOWTH_LV17
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
	energy COLORLESS, 2 ; energies
	tx Text1371 ; name
	tx Text1372 ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_X ; category
	dw $5293 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_MULTIPLE_SLASH ; animation

	db 1 ; retreat cost
	db WR_FIGHTING ; weakness
	db WR_PSYCHIC ; resistance
	tx Text1826 ; category
	db 52 ; Pokedex number
	db 0 ; ?
	db 17 ; level
	length 0.4 ; length
	weight 4.2 ; weight
	tx Text1831 ; description
	db NONE | HAS_EVOLUTION ; AI info

PersianCard:
	db TYPE_PKMN_COLORLESS ; type
	dw $5280 ; gfx
	tx Text1832 ; name
	db DIAMOND ; rarity
	db LEGENDARY_POWER ; set
	db 2 ; ?
	dw PERSIAN
	db 70 ; hp
	db STAGE1 ; stage
	tx Text1823 ; pre-evo name

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
	energy COLORLESS, 3 ; energies
	tx Text1833 ; name
	tx Text1834 ; description
	dw NONE ; description (cont)
	db 30 ; damage
	db DAMAGE_NORMAL ; category
	dw $484e ; effect commands
	db NONE ; flags 1
	db NULLIFY_OR_WEAKEN_ATTACK  ; flags 2
	db NONE ; flags 3
	db 10 ; ?
	db ATK_ANIM_HIT ; animation

	db 0 ; retreat cost
	db WR_FIGHTING ; weakness
	db WR_PSYCHIC ; resistance
	tx Text1835 ; category
	db 53 ; Pokedex number
	db 0 ; ?
	db 25 ; level
	length 1.0 ; length
	weight 32.0 ; weight
	tx Text1836 ; description
	db NONE ; AI info

DarkPersianLv28Card:
	db TYPE_PKMN_COLORLESS ; type
	dw $6c7a ; gfx
	tx Text1837 ; name
	db CIRCLE ; rarity
	db PSYCHIC_BATTLE ; set
	db 6 ; ?
	dw DARK_PERSIAN_LV28
	db 60 ; hp
	db STAGE1 ; stage
	tx Text1823 ; pre-evo name

	; attack 1
	energy COLORLESS, 1 ; energies
	tx Text1838 ; name
	tx Text1839 ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db RESIDUAL ; category
	dw $4b2e ; effect commands
	db NONE ; flags 1
	db SWITCH_OPPONENT_POKEMON  ; flags 2
	db FLAG_3_BIT_2  ; flags 3
	db 0 ; ?
	db ATK_ANIM_LURE ; animation

	; attack 2
	energy COLORLESS, 2 ; energies
	tx Text183a ; name
	tx Text135b ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_NORMAL ; category
	dw $4b3f ; effect commands
	db INFLICT_POISON  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_POISON_FANG ; animation

	db 0 ; retreat cost
	db WR_FIGHTING ; weakness
	db WR_PSYCHIC ; resistance
	tx Text1835 ; category
	db 53 ; Pokedex number
	db 1 ; ?
	db 28 ; level
	length 1.0 ; length
	weight 32.0 ; weight
	tx Text183b ; description
	db NONE ; AI info

DarkPersianAltLv28Card:
	db TYPE_PKMN_COLORLESS ; type
	dw $9e90 ; gfx
	tx Text1837 ; name
	db CIRCLE ; rarity
	db PRO ; set
	db 7 ; ?
	dw DARK_PERSIAN_ALT_LV28
	db 60 ; hp
	db STAGE1 ; stage
	tx Text1823 ; pre-evo name

	; attack 1
	energy COLORLESS, 1 ; energies
	tx Text1838 ; name
	tx Text1839 ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db RESIDUAL ; category
	dw $5177 ; effect commands
	db NONE ; flags 1
	db SWITCH_OPPONENT_POKEMON  ; flags 2
	db FLAG_3_BIT_2  ; flags 3
	db 0 ; ?
	db ATK_ANIM_LURE ; animation

	; attack 2
	energy COLORLESS, 2 ; energies
	tx Text183a ; name
	tx Text135b ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_NORMAL ; category
	dw $5188 ; effect commands
	db INFLICT_POISON  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_POISON_FANG ; animation

	db 0 ; retreat cost
	db WR_FIGHTING ; weakness
	db WR_PSYCHIC ; resistance
	tx Text1835 ; category
	db 53 ; Pokedex number
	db 1 ; ?
	db 28 ; level
	length 1.0 ; length
	weight 32.0 ; weight
	tx Text183b ; description
	db NONE ; AI info

FarfetchdLv20Card:
	db TYPE_PKMN_COLORLESS ; type
	dw $52fb ; gfx
	tx Text183c ; name
	db DIAMOND ; rarity
	db BEGINNING_POKEMON ; set
	db 1 ; ?
	dw FARFETCHD_LV20
	db 50 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy COLORLESS, 1 ; energies
	tx Text183d ; name
	tx Text183e ; description
	dw NONE ; description (cont)
	db 30 ; damage
	db DAMAGE_NORMAL ; category
	dw $478a ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_WHIP ; animation

	; attack 2
	energy COLORLESS, 3 ; energies
	tx Text183f ; name
	dw NONE ; description
	dw NONE ; description (cont)
	db 30 ; damage
	db DAMAGE_NORMAL ; category
	dw NONE ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_POT_SMASH ; animation

	db 1 ; retreat cost
	db WR_LIGHTNING ; weakness
	db WR_FIGHTING ; resistance
	tx Text1840 ; category
	db 83 ; Pokedex number
	db 0 ; ?
	db 20 ; level
	length 0.8 ; length
	weight 15.0 ; weight
	tx Text1841 ; description
	db AI_INFO_UNK_03 ; AI info

FarfetchdAltLv20Card:
	db TYPE_PKMN_COLORLESS ; type
	dw $a13f ; gfx
	tx Text183c ; name
	db PROMOSTAR ; rarity
	db PRO ; set
	db 7 ; ?
	dw FARFETCHD_ALT_LV20
	db 50 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy COLORLESS, 1 ; energies
	tx Text183d ; name
	tx Text1842 ; description
	dw NONE ; description (cont)
	db 30 ; damage
	db DAMAGE_NORMAL ; category
	dw $51f9 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_WHIP ; animation

	; attack 2
	energy COLORLESS, 3 ; energies
	tx Text183f ; name
	dw NONE ; description
	dw NONE ; description (cont)
	db 30 ; damage
	db DAMAGE_NORMAL ; category
	dw NONE ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_POT_SMASH ; animation

	db 1 ; retreat cost
	db WR_LIGHTNING ; weakness
	db WR_FIGHTING ; resistance
	tx Text1840 ; category
	db 83 ; Pokedex number
	db 0 ; ?
	db 20 ; level
	length 0.8 ; length
	weight 15.0 ; weight
	tx Text1843 ; description
	db NONE ; AI info

DoduoLv8Card:
	db TYPE_PKMN_COLORLESS ; type
	dw $7c62 ; gfx
	tx Text1844 ; name
	db CIRCLE ; rarity
	db SKY_FLYING_POKEMON ; set
	db 4 ; ?
	dw DODUO_LV8
	db 40 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy COLORLESS, 1 ; energies
	tx Text1457 ; name
	tx Text1845 ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db DAMAGE_NORMAL ; category
	dw $4d09 ; effect commands
	db NONE ; flags 1
	db NULLIFY_OR_WEAKEN_ATTACK  ; flags 2
	db NONE ; flags 3
	db 10 ; ?
	db ATK_ANIM_SUPERSONIC ; animation

	; attack 2
	energy COLORLESS, 2 ; energies
	tx Text1347 ; name
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
	db WR_LIGHTNING ; weakness
	db WR_FIGHTING ; resistance
	tx Text1846 ; category
	db 84 ; Pokedex number
	db 0 ; ?
	db 8 ; level
	length 1.4 ; length
	weight 39.2 ; weight
	tx Text1847 ; description
	db NONE | HAS_EVOLUTION ; AI info

DoduoLv10Card:
	db TYPE_PKMN_COLORLESS ; type
	dw $536e ; gfx
	tx Text1844 ; name
	db CIRCLE ; rarity
	db BEGINNING_POKEMON ; set
	db 3 ; ?
	dw DODUO_LV10
	db 50 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy COLORLESS, 1 ; energies
	tx Text17f0 ; name
	tx Text1587 ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_X ; category
	dw $47b8 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_MULTIPLE_SLASH ; animation

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
	db WR_FIGHTING ; resistance
	tx Text1846 ; category
	db 84 ; Pokedex number
	db 0 ; ?
	db 10 ; level
	length 1.4 ; length
	weight 39.2 ; weight
	tx Text1848 ; description
	db AI_INFO_UNK_03 | HAS_EVOLUTION ; AI info

DodrioLv25Card:
	db TYPE_PKMN_COLORLESS ; type
	dw $7ccb ; gfx
	tx Text1849 ; name
	db DIAMOND ; rarity
	db SKY_FLYING_POKEMON ; set
	db 4 ; ?
	dw DODRIO_LV25
	db 60 ; hp
	db STAGE1 ; stage
	tx Text1844 ; pre-evo name

	; attack 1
	energy COLORLESS, 1 ; energies
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
	db ATK_ANIM_HIT ; animation

	; attack 2
	energy COLORLESS, 3 ; energies
	tx Text184a ; name
	tx Text164c ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_X ; category
	dw $4d0e ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_MULTIPLE_SLASH ; animation

	db 0 ; retreat cost
	db WR_LIGHTNING ; weakness
	db WR_FIGHTING ; resistance
	tx Text184b ; category
	db 85 ; Pokedex number
	db 0 ; ?
	db 25 ; level
	length 1.8 ; length
	weight 85.2 ; weight
	tx Text184c ; description
	db NONE ; AI info

DodrioLv28Card:
	db TYPE_PKMN_COLORLESS ; type
	dw $53d7 ; gfx
	tx Text1849 ; name
	db DIAMOND ; rarity
	db LEGENDARY_POWER ; set
	db 3 ; ?
	dw DODRIO_LV28
	db 70 ; hp
	db STAGE1 ; stage
	tx Text1844 ; pre-evo name

	; attack 1
	energy 0 ; energies
	tx Text184d ; name
	tx Text184e ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db POKEMON_POWER ; category
	dw $47c0 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_PKMN_POWER_1 ; animation

	; attack 2
	energy COLORLESS, 3 ; energies
	tx Text14c1 ; name
	tx Text14c2 ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_PLUS ; category
	dw $47c5 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db BOOST_IF_TAKEN_DAMAGE  ; flags 3
	db 0 ; ?
	db ATK_ANIM_BIG_HIT ; animation

	db 0 ; retreat cost
	db WR_LIGHTNING ; weakness
	db WR_FIGHTING ; resistance
	tx Text184b ; category
	db 85 ; Pokedex number
	db 0 ; ?
	db 28 ; level
	length 1.8 ; length
	weight 85.2 ; weight
	tx Text184f ; description
	db AI_INFO_BENCH_UTILITY ; AI info

LickitungLv20Card:
	db TYPE_PKMN_COLORLESS ; type
	dw $7d34 ; gfx
	tx Text1850 ; name
	db DIAMOND ; rarity
	db SKY_FLYING_POKEMON ; set
	db 2 ; ?
	dw LICKITUNG_LV20
	db 60 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy COLORLESS, 1 ; energies
	tx Text1851 ; name
	tx Text1363 ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db DAMAGE_NORMAL ; category
	dw $4d16 ; effect commands
	db INFLICT_PARALYSIS  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_198 ; animation

	; attack 2
	energy COLORLESS, 2 ; energies
	tx Text14a9 ; name
	tx Text1448 ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_PLUS ; category
	dw $4d1b ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_HIT ; animation

	db 2 ; retreat cost
	db WR_FIGHTING ; weakness
	db WR_PSYCHIC ; resistance
	tx Text1852 ; category
	db 108 ; Pokedex number
	db 0 ; ?
	db 20 ; level
	length 1.2 ; length
	weight 65.5 ; weight
	tx Text1853 ; description
	db NONE ; AI info

LickitungLv26Card:
	db TYPE_PKMN_COLORLESS ; type
	dw $5440 ; gfx
	tx Text1850 ; name
	db DIAMOND ; rarity
	db LEGENDARY_POWER ; set
	db 6 ; ?
	dw LICKITUNG_LV26
	db 90 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy COLORLESS, 1 ; energies
	tx Text1854 ; name
	tx Text132f ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_NORMAL ; category
	dw $4853 ; effect commands
	db INFLICT_PARALYSIS  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_GOO ; animation

	; attack 2
	energy COLORLESS, 2 ; energies
	tx Text137b ; name
	tx Text137c ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db DAMAGE_NORMAL ; category
	dw $4858 ; effect commands
	db INFLICT_CONFUSION  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_SUPERSONIC ; animation

	db 3 ; retreat cost
	db WR_FIGHTING ; weakness
	db WR_PSYCHIC ; resistance
	tx Text1852 ; category
	db 108 ; Pokedex number
	db 0 ; ?
	db 26 ; level
	length 1.2 ; length
	weight 65.5 ; weight
	tx Text1855 ; description
	db NONE ; AI info

ChanseyLv40Card:
	db TYPE_PKMN_COLORLESS ; type
	dw $7de7 ; gfx
	tx Text1856 ; name
	db DIAMOND ; rarity
	db SKY_FLYING_POKEMON ; set
	db 6 ; ?
	dw CHANSEY_LV40
	db 100 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy COLORLESS, 1 ; energies
	tx Text1595 ; name
	tx Text1596 ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db DAMAGE_NORMAL ; category
	dw $4d23 ; effect commands
	db INFLICT_SLEEP  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_LULLABY ; animation

	; attack 2
	energy COLORLESS, 3 ; energies
	tx Text1857 ; name
	tx Text1628 ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_X ; category
	dw $4d28 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_203 ; animation

	db 1 ; retreat cost
	db WR_FIGHTING ; weakness
	db WR_PSYCHIC ; resistance
	tx Text1417 ; category
	db 113 ; Pokedex number
	db 0 ; ?
	db 40 ; level
	length 1.1 ; length
	weight 34.6 ; weight
	tx Text1858 ; description
	db NONE ; AI info

ChanseyLv55Card:
	db TYPE_PKMN_COLORLESS ; type
	dw $54a9 ; gfx
	tx Text1856 ; name
	db STAR ; rarity
	db BEGINNING_POKEMON ; set
	db 0 ; ?
	dw CHANSEY_LV55
	db 120 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy COLORLESS, 2 ; energies
	tx Text1859 ; name
	tx Text133a ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db RESIDUAL ; category
	dw $4884 ; effect commands
	db NONE ; flags 1
	db NULLIFY_OR_WEAKEN_ATTACK  ; flags 2
	db FLAG_3_BIT_2  ; flags 3
	db 0 ; ?
	db ATK_ANIM_NONE ; animation

	; attack 2
	energy COLORLESS, 4 ; energies
	tx Text1811 ; name
	tx Text185a ; description
	dw NONE ; description (cont)
	db 80 ; damage
	db DAMAGE_NORMAL ; category
	dw $4889 ; effect commands
	db HIGH_RECOIL  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 80 ; ?
	db ATK_ANIM_HIT_RECOIL ; animation

	db 1 ; retreat cost
	db WR_FIGHTING ; weakness
	db WR_PSYCHIC ; resistance
	tx Text1417 ; category
	db 113 ; Pokedex number
	db 0 ; ?
	db 55 ; level
	length 1.1 ; length
	weight 34.6 ; weight
	tx Text185b ; description
	db AI_INFO_UNK_08 ; AI info

KangaskhanLv36Card:
	db TYPE_PKMN_COLORLESS ; type
	dw $99ba ; gfx
	tx Text185c ; name
	db DIAMOND ; rarity
	db SKY_FLYING_POKEMON ; set
	db 6 ; ?
	dw KANGASKHAN_LV36
	db 80 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy COLORLESS, 2 ; energies
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

	; attack 2
	energy COLORLESS, 3 ; energies
	tx Text185d ; name
	tx Text1589 ; description
	dw NONE ; description (cont)
	db 80 ; damage
	db DAMAGE_NORMAL ; category
	dw $50f7 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_200 ; animation

	db 3 ; retreat cost
	db WR_FIGHTING ; weakness
	db WR_PSYCHIC ; resistance
	tx Text185e ; category
	db 115 ; Pokedex number
	db 0 ; ?
	db 36 ; level
	length 2.2 ; length
	weight 80.0 ; weight
	tx Text185f ; description
	db NONE ; AI info

KangaskhanLv38Card:
	db TYPE_PKMN_COLORLESS ; type
	dw $a1b6 ; gfx
	tx Text185c ; name
	db PROMOSTAR ; rarity
	db PRO ; set
	db 7 ; ?
	dw KANGASKHAN_LV38
	db 80 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy COLORLESS, 1 ; energies
	tx Text1860 ; name
	tx Text1587 ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_X ; category
	dw $5204 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_PUNCH ; animation

	; attack 2
	energy COLORLESS, 3 ; energies
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

	db 3 ; retreat cost
	db WR_FIGHTING ; weakness
	db WR_PSYCHIC ; resistance
	tx Text185e ; category
	db 115 ; Pokedex number
	db 0 ; ?
	db 38 ; level
	length 2.2 ; length
	weight 80.0 ; weight
	tx Text1861 ; description
	db NONE ; AI info

KangaskhanLv40Card:
	db TYPE_PKMN_COLORLESS ; type
	dw $5512 ; gfx
	tx Text185c ; name
	db STAR ; rarity
	db LEGENDARY_POWER ; set
	db 1 ; ?
	dw KANGASKHAN_LV40
	db 90 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy COLORLESS, 1 ; energies
	tx Text1862 ; name
	tx Text1863 ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db RESIDUAL ; category
	dw $4798 ; effect commands
	db DRAW_CARD  ; flags 1
	db NONE ; flags 2
	db SPECIAL_AI_HANDLING | FLAG_3_BIT_2  ; flags 3
	db 0 ; ?
	db ATK_ANIM_GLOW_EFFECT ; animation

	; attack 2
	energy COLORLESS, 4 ; energies
	tx Text1864 ; name
	tx Text162d ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_X ; category
	dw $47a0 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_PUNCH ; animation

	db 3 ; retreat cost
	db WR_FIGHTING ; weakness
	db WR_PSYCHIC ; resistance
	tx Text185e ; category
	db 115 ; Pokedex number
	db 0 ; ?
	db 40 ; level
	length 2.2 ; length
	weight 80.0 ; weight
	tx Text1865 ; description
	db NONE ; AI info

TaurosLv32Card:
	db TYPE_PKMN_COLORLESS ; type
	dw $557b ; gfx
	tx Text1866 ; name
	db DIAMOND ; rarity
	db LEGENDARY_POWER ; set
	db 5 ; ?
	dw TAUROS_LV32
	db 60 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy COLORLESS, 2 ; energies
	tx Text14a9 ; name
	tx Text14aa ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_PLUS ; category
	dw $47a8 ; effect commands
	db NONE ; flags 1
	db FLAG_2_BIT_6  ; flags 2
	db NONE ; flags 3
	db 1 ; ?
	db ATK_ANIM_HIT ; animation

	; attack 2
	energy COLORLESS, 3 ; energies
	tx Text1867 ; name
	tx Text1868 ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_PLUS ; category
	dw $47b0 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db BOOST_IF_TAKEN_DAMAGE  ; flags 3
	db 0 ; ?
	db ATK_ANIM_RAMPAGE ; animation

	db 2 ; retreat cost
	db WR_FIGHTING ; weakness
	db WR_PSYCHIC ; resistance
	tx Text1869 ; category
	db 128 ; Pokedex number
	db 0 ; ?
	db 32 ; level
	length 1.4 ; length
	weight 88.4 ; weight
	tx Text186a ; description
	db NONE ; AI info

TaurosLv35Card:
	db TYPE_PKMN_COLORLESS ; type
	dw $9ca6 ; gfx
	tx Text1866 ; name
	db CIRCLE ; rarity
	db SKY_FLYING_POKEMON ; set
	db 2 ; ?
	dw TAUROS_LV35
	db 70 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy COLORLESS, 2 ; energies
	tx Text186b ; name
	tx Text186c ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_PLUS ; category
	dw $5132 ; effect commands
	db NONE ; flags 1
	db SWITCH_OPPONENT_POKEMON  ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_MULTIPLE_SLASH ; animation

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
	db WR_PSYCHIC ; resistance
	tx Text1869 ; category
	db 128 ; Pokedex number
	db 0 ; ?
	db 35 ; level
	length 1.4 ; length
	weight 88.4 ; weight
	tx Text186d ; description
	db NONE ; AI info

DittoCard:
	db TYPE_PKMN_COLORLESS ; type
	dw $55e4 ; gfx
	tx Text186e ; name
	db STAR ; rarity
	db GB ; set
	db 3 ; ?
	dw DITTO
	db 50 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
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

	; attack 2
	energy COLORLESS, 3 ; energies
	tx Text186f ; name
	tx Text1870 ; description
	tx Text1871 ; description (cont)
	db 0 ; damage
	db RESIDUAL ; category
	dw $48b6 ; effect commands
	db NONE ; flags 1
	db FLAG_2_BIT_6  ; flags 2
	db FLAG_3_BIT_2  ; flags 3
	db 3 ; ?
	db ATK_ANIM_GLOW_EFFECT ; animation

	db 1 ; retreat cost
	db WR_FIGHTING ; weakness
	db WR_PSYCHIC ; resistance
	tx Text1872 ; category
	db 132 ; Pokedex number
	db 0 ; ?
	db 19 ; level
	length 0.3 ; length
	weight 4.0 ; weight
	tx Text1873 ; description
	db NONE ; AI info

EeveeLv5Card:
	db TYPE_PKMN_COLORLESS ; type
	dw $7f3c ; gfx
	tx Text14c0 ; name
	db DIAMOND ; rarity
	db SKY_FLYING_POKEMON ; set
	db 3 ; ?
	dw EEVEE_LV5
	db 30 ; hp
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
	energy COLORLESS, 1 ; energies
	tx Text1486 ; name
	tx Text138c ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_NORMAL ; category
	dw $4d45 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_HIT ; animation

	db 0 ; retreat cost
	db WR_FIGHTING ; weakness
	db WR_PSYCHIC ; resistance
	tx Text1874 ; category
	db 133 ; Pokedex number
	db 0 ; ?
	db 5 ; level
	length 0.3 ; length
	weight 6.5 ; weight
	tx Text1875 ; description
	db NONE | HAS_EVOLUTION ; AI info

EeveeLv9Card:
	db TYPE_PKMN_COLORLESS ; type
	dw $6ce3 ; gfx
	tx Text14c0 ; name
	db CIRCLE ; rarity
	db PSYCHIC_BATTLE ; set
	db 5 ; ?
	dw EEVEE_LV9
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
	energy COLORLESS, 2 ; energies
	tx Text1646 ; name
	tx Text1876 ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_NORMAL ; category
	dw $4b47 ; effect commands
	db NONE ; flags 1
	db NULLIFY_OR_WEAKEN_ATTACK  ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_DARK_GAS ; animation

	db 1 ; retreat cost
	db WR_FIGHTING ; weakness
	db WR_PSYCHIC ; resistance
	tx Text1874 ; category
	db 133 ; Pokedex number
	db 0 ; ?
	db 9 ; level
	length 0.3 ; length
	weight 6.5 ; weight
	tx Text1877 ; description
	db NONE | HAS_EVOLUTION ; AI info

EeveeLv12Card:
	db TYPE_PKMN_COLORLESS ; type
	dw $566d ; gfx
	tx Text14c0 ; name
	db CIRCLE ; rarity
	db LEGENDARY_POWER ; set
	db 0 ; ?
	dw EEVEE_LV12
	db 50 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy COLORLESS, 1 ; energies
	tx Text136e ; name
	tx Text16f1 ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db DAMAGE_NORMAL ; category
	dw $4744 ; effect commands
	db NONE ; flags 1
	db NULLIFY_OR_WEAKEN_ATTACK  ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_NONE ; animation

	; attack 2
	energy COLORLESS, 2 ; energies
	tx Text1490 ; name
	tx Text1491 ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_PLUS ; category
	dw $4749 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_QUICK_ATTACK ; animation

	db 1 ; retreat cost
	db WR_FIGHTING ; weakness
	db WR_PSYCHIC ; resistance
	tx Text1874 ; category
	db 133 ; Pokedex number
	db 0 ; ?
	db 12 ; level
	length 0.3 ; length
	weight 6.5 ; weight
	tx Text1878 ; description
	db AI_INFO_BENCH_UTILITY | HAS_EVOLUTION ; AI info

PorygonLv12Card:
	db TYPE_PKMN_COLORLESS ; type
	dw $56d6 ; gfx
	tx Text1879 ; name
	db DIAMOND ; rarity
	db BEGINNING_POKEMON ; set
	db 0 ; ?
	dw PORYGON_LV12
	db 30 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy COLORLESS, 1 ; energies
	tx Text187a ; name
	tx Text187b ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db DAMAGE_NORMAL ; category
	dw $4868 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db SPECIAL_AI_HANDLING  ; flags 3
	db 0 ; ?
	db ATK_ANIM_GLOW_EFFECT ; animation

	; attack 2
	energy COLORLESS, 2 ; energies
	tx Text187c ; name
	tx Text187d ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db RESIDUAL ; category
	dw $4876 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db SPECIAL_AI_HANDLING | FLAG_3_BIT_2  ; flags 3
	db 0 ; ?
	db ATK_ANIM_GLOW_EFFECT ; animation

	db 1 ; retreat cost
	db WR_FIGHTING ; weakness
	db WR_PSYCHIC ; resistance
	tx Text187e ; category
	db 137 ; Pokedex number
	db 0 ; ?
	db 12 ; level
	length 0.8 ; length
	weight 36.5 ; weight
	tx Text187f ; description
	db NONE ; AI info

PorygonLv18Card:
	db TYPE_PKMN_COLORLESS ; type
	dw $8000 ; gfx
	tx Text1879 ; name
	db DIAMOND ; rarity
	db SKY_FLYING_POKEMON ; set
	db 2 ; ?
	dw PORYGON_LV18
	db 40 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy COLORLESS, 1 ; energies
	tx Text1880 ; name
	tx Text1881 ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_X ; category
	dw $4d4d ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_216 ; animation

	; attack 2
	energy COLORLESS, 2 ; energies
	tx Text187c ; name
	tx Text187d ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db RESIDUAL ; category
	dw $4d55 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db SPECIAL_AI_HANDLING | FLAG_3_BIT_2  ; flags 3
	db 0 ; ?
	db ATK_ANIM_GLOW_EFFECT ; animation

	db 0 ; retreat cost
	db WR_FIGHTING ; weakness
	db WR_PSYCHIC ; resistance
	tx Text187e ; category
	db 137 ; Pokedex number
	db 0 ; ?
	db 18 ; level
	length 0.8 ; length
	weight 36.5 ; weight
	tx Text1882 ; description
	db NONE ; AI info

PorygonLv20Card:
	db TYPE_PKMN_COLORLESS ; type
	dw $6d5a ; gfx
	tx Text1879 ; name
	db CIRCLE ; rarity
	db PSYCHIC_BATTLE ; set
	db 6 ; ?
	dw PORYGON_LV20
	db 40 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy COLORLESS, 1 ; energies
	tx Text187a ; name
	tx Text1883 ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db DAMAGE_NORMAL ; category
	dw $4b4c ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db SPECIAL_AI_HANDLING  ; flags 3
	db 0 ; ?
	db ATK_ANIM_GLOW_EFFECT ; animation

	; attack 2
	energy COLORLESS, 3 ; energies
	tx Text13df ; name
	tx Text1336 ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_NORMAL ; category
	dw $4b5a ; effect commands
	db INFLICT_CONFUSION  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_169 ; animation

	db 0 ; retreat cost
	db WR_FIGHTING ; weakness
	db WR_PSYCHIC ; resistance
	tx Text187e ; category
	db 137 ; Pokedex number
	db 0 ; ?
	db 20 ; level
	length 0.8 ; length
	weight 36.5 ; weight
	tx Text1884 ; description
	db NONE ; AI info

CoolPorygonCard:
	db TYPE_PKMN_COLORLESS ; type
	dw $9f62 ; gfx
	tx Text1885 ; name
	db PROMOSTAR ; rarity
	db PRO ; set
	db 7 ; ?
	dw COOL_PORYGON
	db 50 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy COLORLESS, 3 ; energies
	tx Text1886 ; name
	tx Text1887 ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db DAMAGE_NORMAL ; category
	dw $519b ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db SPECIAL_AI_HANDLING | FLAG_3_BIT_2  ; flags 3
	db 0 ; ?
	db ATK_ANIM_GLOW_EFFECT ; animation

	; attack 2
	energy COLORLESS, 3 ; energies
	tx Text1880 ; name
	tx Text1888 ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_X ; category
	dw $51a9 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_216 ; animation

	db 1 ; retreat cost
	db WR_FIGHTING ; weakness
	db WR_PSYCHIC ; resistance
	tx Text187e ; category
	db 137 ; Pokedex number
	db 0 ; ?
	db 15 ; level
	length 0.8 ; length
	weight 36.5 ; weight
	tx Text1882 ; description
	db NONE ; AI info

SnorlaxLv20Card:
	db TYPE_PKMN_COLORLESS ; type
	dw $573f ; gfx
	tx Text1889 ; name
	db STAR ; rarity
	db LEGENDARY_POWER ; set
	db 0 ; ?
	dw SNORLAX_LV20
	db 90 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy 0 ; energies
	tx Text188a ; name
	tx Text188b ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db POKEMON_POWER ; category
	dw $4780 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_GLOW_EFFECT ; animation

	; attack 2
	energy COLORLESS, 4 ; energies
	tx Text151d ; name
	tx Text132f ; description
	dw NONE ; description (cont)
	db 30 ; damage
	db DAMAGE_NORMAL ; category
	dw $4785 ; effect commands
	db INFLICT_PARALYSIS  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_BIG_HIT ; animation

	db 4 ; retreat cost
	db WR_FIGHTING ; weakness
	db WR_PSYCHIC ; resistance
	tx Text188c ; category
	db 143 ; Pokedex number
	db 0 ; ?
	db 20 ; level
	length 2.1 ; length
	weight 460.0 ; weight
	tx Text188d ; description
	db NONE ; AI info

SnorlaxLv35Card:
	db TYPE_PKMN_COLORLESS ; type
	dw $806f ; gfx
	tx Text1889 ; name
	db STAR ; rarity
	db SKY_FLYING_POKEMON ; set
	db 4 ; ?
	dw SNORLAX_LV35
	db 90 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy 0 ; energies
	tx Text188e ; name
	tx Text188f ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db POKEMON_POWER ; category
	dw $4d63 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_NONE ; animation

	; attack 2
	energy COLORLESS, 4 ; energies
	tx Text1890 ; name
	tx Text1891 ; description
	dw NONE ; description (cont)
	db 30 ; damage
	db DAMAGE_NORMAL ; category
	dw $4d68 ; effect commands
	db INFLICT_SLEEP  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_218 ; animation

	db 4 ; retreat cost
	db WR_FIGHTING ; weakness
	db WR_PSYCHIC ; resistance
	tx Text188c ; category
	db 143 ; Pokedex number
	db 0 ; ?
	db 35 ; level
	length 2.1 ; length
	weight 460.0 ; weight
	tx Text1892 ; description
	db NONE ; AI info

HungrySnorlaxCard:
	db TYPE_PKMN_COLORLESS ; type
	dw $a000 ; gfx
	tx Text1893 ; name
	db PROMOSTAR ; rarity
	db PRO ; set
	db 7 ; ?
	dw HUNGRY_SNORLAX
	db 100 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy COLORLESS, 1 ; energies
	tx Text1894 ; name
	tx Text1895 ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db RESIDUAL ; category
	dw $51b1 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db SPECIAL_AI_HANDLING | FLAG_3_BIT_2  ; flags 3
	db 0 ; ?
	db ATK_ANIM_GLOW_EFFECT ; animation

	; attack 2
	energy COLORLESS, 3 ; energies
	tx Text134d ; name
	tx Text1896 ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_PLUS ; category
	dw $51b9 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db SPECIAL_AI_HANDLING  ; flags 3
	db 0 ; ?
	db ATK_ANIM_HIT ; animation

	db 4 ; retreat cost
	db WR_FIGHTING ; weakness
	db WR_PSYCHIC ; resistance
	tx Text188c ; category
	db 143 ; Pokedex number
	db 0 ; ?
	db 50 ; level
	length 2.1 ; length
	weight 460.0 ; weight
	tx Text1897 ; description
	db NONE ; AI info

DratiniLv10Card:
	db TYPE_PKMN_COLORLESS ; type
	dw $5800 ; gfx
	tx Text1898 ; name
	db CIRCLE ; rarity
	db BEGINNING_POKEMON ; set
	db 1 ; ?
	dw DRATINI_LV10
	db 40 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
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
	db NONE ; weakness
	db WR_PSYCHIC ; resistance
	tx Text1558 ; category
	db 147 ; Pokedex number
	db 0 ; ?
	db 10 ; level
	length 1.8 ; length
	weight 3.3 ; weight
	tx Text1899 ; description
	db AI_INFO_ENCOURAGE_EVO | HAS_EVOLUTION ; AI info

DratiniLv12Card:
	db TYPE_PKMN_COLORLESS ; type
	dw $6dc9 ; gfx
	tx Text1898 ; name
	db CIRCLE ; rarity
	db PSYCHIC_BATTLE ; set
	db 6 ; ?
	dw DRATINI_LV12
	db 40 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy COLORLESS, 2 ; energies
	tx Text1357 ; name
	tx Text1363 ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_NORMAL ; category
	dw $4b5f ; effect commands
	db INFLICT_PARALYSIS  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_HIT_EFFECT ; animation

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
	db NONE ; weakness
	db WR_PSYCHIC ; resistance
	tx Text1558 ; category
	db 147 ; Pokedex number
	db 0 ; ?
	db 12 ; level
	length 1.8 ; length
	weight 3.3 ; weight
	tx Text189a ; description
	db NONE | HAS_EVOLUTION ; AI info

DragonairCard:
	db TYPE_PKMN_COLORLESS ; type
	dw $5869 ; gfx
	tx Text189b ; name
	db STAR ; rarity
	db BEGINNING_POKEMON ; set
	db 1 ; ?
	dw DRAGONAIR
	db 80 ; hp
	db STAGE1 ; stage
	tx Text1898 ; pre-evo name

	; attack 1
	energy COLORLESS, 3 ; energies
	tx Text189c ; name
	tx Text1352 ; description
	dw NONE ; description (cont)
	db 30 ; damage
	db DAMAGE_X ; category
	dw $47d2 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_HIT ; animation

	; attack 2
	energy COLORLESS, 4 ; energies
	tx Text1506 ; name
	tx Text1507 ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_NORMAL ; category
	dw $47da ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db SPECIAL_AI_HANDLING  ; flags 3
	db 0 ; ?
	db ATK_ANIM_HYPER_BEAM ; animation

	db 2 ; retreat cost
	db NONE ; weakness
	db WR_PSYCHIC ; resistance
	tx Text1558 ; category
	db 148 ; Pokedex number
	db 0 ; ?
	db 33 ; level
	length 4.0 ; length
	weight 16.5 ; weight
	tx Text189d ; description
	db NONE | HAS_EVOLUTION ; AI info

DarkDragonairCard:
	db TYPE_PKMN_COLORLESS ; type
	dw $6e32 ; gfx
	tx Text189e ; name
	db DIAMOND ; rarity
	db PSYCHIC_BATTLE ; set
	db 6 ; ?
	dw DARK_DRAGONAIR
	db 60 ; hp
	db STAGE1 ; stage
	tx Text1898 ; pre-evo name

	; attack 1
	energy 0 ; energies
	tx Text189f ; name
	tx Text18a0 ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db POKEMON_POWER ; category
	dw $4b64 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_GLOW_EFFECT ; animation

	; attack 2
	energy COLORLESS, 3 ; energies
	tx Text18a1 ; name
	tx Text15e2 ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_PLUS ; category
	dw $4b6f ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_200 ; animation

	db 2 ; retreat cost
	db NONE ; weakness
	db WR_PSYCHIC ; resistance
	tx Text1558 ; category
	db 148 ; Pokedex number
	db 1 ; ?
	db 28 ; level
	length 4.0 ; length
	weight 16.5 ; weight
	tx Text18a2 ; description
	db NONE | HAS_EVOLUTION ; AI info

DragoniteLv41Card:
	db TYPE_PKMN_COLORLESS ; type
	dw $58d2 ; gfx
	tx Text18a3 ; name
	db STAR ; rarity
	db GB ; set
	db 7 ; ?
	dw DRAGONITE_LV41
	db 100 ; hp
	db STAGE2 ; stage
	tx Text189b ; pre-evo name

	; attack 1
	energy 0 ; energies
	tx Text18a4 ; name
	tx Text18a5 ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db POKEMON_POWER ; category
	dw $48a1 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_HEALING_WIND ; animation

	; attack 2
	energy COLORLESS, 3 ; energies
	tx Text189c ; name
	tx Text1352 ; description
	dw NONE ; description (cont)
	db 30 ; damage
	db DAMAGE_X ; category
	dw $48a9 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_HIT ; animation

	db 2 ; retreat cost
	db NONE ; weakness
	db WR_FIGHTING ; resistance
	tx Text1558 ; category
	db 149 ; Pokedex number
	db 0 ; ?
	db 41 ; level
	length 2.2 ; length
	weight 210.0 ; weight
	tx Text18a6 ; description
	db NONE ; AI info

DragoniteLv43Card:
	db TYPE_PKMN_COLORLESS ; type
	dw $a30d ; gfx
	tx Text18a3 ; name
	db PROMOSTAR ; rarity
	db PRO ; set
	db 7 ; ?
	dw DRAGONITE_LV43
	db 90 ; hp
	db STAGE2 ; stage
	tx Text189b ; pre-evo name

	; attack 1
	energy 0 ; energies
	tx Text18a7 ; name
	tx Text18a8 ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db POKEMON_POWER ; category
	dw $5224 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_GLOW_EFFECT ; animation

	; attack 2
	energy COLORLESS, 3 ; energies
	tx Text18a9 ; name
	tx Text138c ; description
	dw NONE ; description (cont)
	db 60 ; damage
	db DAMAGE_NORMAL ; category
	dw $522f ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_QUICK_ATTACK ; animation

	db 2 ; retreat cost
	db NONE ; weakness
	db WR_FIGHTING ; resistance
	tx Text1558 ; category
	db 149 ; Pokedex number
	db 0 ; ?
	db 43 ; level
	length 2.2 ; length
	weight 210.0 ; weight
	tx Text18aa ; description
	db NONE ; AI info

DragoniteLv45Card:
	db TYPE_PKMN_COLORLESS ; type
	dw $5941 ; gfx
	tx Text18a3 ; name
	db STAR ; rarity
	db ISLAND_OF_FOSSIL ; set
	db 1 ; ?
	dw DRAGONITE_LV45
	db 100 ; hp
	db STAGE2 ; stage
	tx Text189b ; pre-evo name

	; attack 1
	energy 0 ; energies
	tx Text18ab ; name
	tx Text18ac ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db POKEMON_POWER ; category
	dw $4770 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_GLOW_EFFECT ; animation

	; attack 2
	energy COLORLESS, 4 ; energies
	tx Text189c ; name
	tx Text18ad ; description
	dw NONE ; description (cont)
	db 40 ; damage
	db DAMAGE_X ; category
	dw $4778 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_HIT ; animation

	db 1 ; retreat cost
	db NONE ; weakness
	db WR_FIGHTING ; resistance
	tx Text1558 ; category
	db 149 ; Pokedex number
	db 0 ; ?
	db 45 ; level
	length 2.2 ; length
	weight 210.0 ; weight
	tx Text18aa ; description
	db NONE ; AI info

DarkDragoniteCard:
	db TYPE_PKMN_COLORLESS ; type
	dw $6e9b ; gfx
	tx Text18ae ; name
	db STAR ; rarity
	db PSYCHIC_BATTLE ; set
	db 6 ; ?
	dw DARK_DRAGONITE
	db 70 ; hp
	db STAGE2 ; stage
	tx Text189e ; pre-evo name

	; attack 1
	energy 0 ; energies
	tx Text18af ; name
	tx Text18b0 ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db POKEMON_POWER ; category
	dw $4b77 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_GLOW_EFFECT ; animation

	; attack 2
	energy COLORLESS, 4 ; energies
	tx Text18b1 ; name
	tx Text138c ; description
	dw NONE ; description (cont)
	db 70 ; damage
	db DAMAGE_NORMAL ; category
	dw $4b82 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_200 ; animation

	db 2 ; retreat cost
	db NONE ; weakness
	db WR_FIGHTING ; resistance
	tx Text1558 ; category
	db 149 ; Pokedex number
	db 1 ; ?
	db 33 ; level
	length 2.2 ; length
	weight 210.0 ; weight
	tx Text18b2 ; description
	db NONE ; AI info

TogepiCard:
	db TYPE_PKMN_COLORLESS ; type
	dw $a5a5 ; gfx
	tx Text18b3 ; name
	db PROMOSTAR ; rarity
	db PRO ; set
	db 7 ; ?
	dw TOGEPI
	db 30 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy COLORLESS, 1 ; energies
	tx Text16cb ; name
	tx Text18b4 ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db DAMAGE_NORMAL ; category
	dw $5247 ; effect commands
	db NONE ; flags 1
	db NULLIFY_OR_WEAKEN_ATTACK  ; flags 2
	db NONE ; flags 3
	db 20 ; ?
	db ATK_ANIM_CRY ; animation

	; attack 2
	energy COLORLESS, 2 ; energies
	tx Text1800 ; name
	tx Text18b5 ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db RESIDUAL ; category
	dw $524c ; effect commands
	db NONE ; flags 1
	db FLAG_2_BIT_5  ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_NONE ; animation

	db 1 ; retreat cost
	db NONE ; weakness
	db WR_PSYCHIC ; resistance
	tx Text18b6 ; category
	db 175 ; Pokedex number
	db 0 ; ?
	db 8 ; level
	length 0.3 ; length
	weight 1.5 ; weight
	tx Text18b7 ; description
	db NONE ; AI info

LugiaCard:
	db TYPE_PKMN_COLORLESS ; type
	dw $ca9a ; gfx
	tx Text18b8 ; name
	db STAR ; rarity
	db GB ; set
	db 7 ; ?
	dw LUGIA
	db 100 ; hp
	db BASIC ; stage
	dw NONE ; pre-evo name

	; attack 1
	energy COLORLESS, 3 ; energies
	tx Text18b9 ; name
	tx Text18ba ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_PLUS ; category
	dw $5348 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_23 ; animation

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
	db WR_PSYCHIC ; weakness
	db WR_FIGHTING ; resistance
	tx Text18bb ; category
	db 249 ; Pokedex number
	db 0 ; ?
	db 55 ; level
	length 5.2 ; length
	weight 216.0 ; weight
	tx Text18bc ; description
	db NONE ; AI info

GrassEnergyCard:
	db TYPE_ENERGY_GRASS ; type
	dw $0 ; gfx
	tx Text12ed ; name
	db CIRCLE ; rarity
	db BEGINNING_POKEMON ; set
	db 8 ; ?
	dw GRASS_ENERGY
	dw $535e ; effect commands
	tx Text12ee ; description
	dw NONE ; pre-evo name

FireEnergyCard:
	db TYPE_ENERGY_FIRE ; type
	dw $93 ; gfx
	tx Text12ef ; name
	db CIRCLE ; rarity
	db BEGINNING_POKEMON ; set
	db 8 ; ?
	dw FIRE_ENERGY
	dw $535c ; effect commands
	tx Text12f0 ; description
	dw NONE ; pre-evo name

WaterEnergyCard:
	db TYPE_ENERGY_WATER ; type
	dw $122 ; gfx
	tx Text12f1 ; name
	db CIRCLE ; rarity
	db BEGINNING_POKEMON ; set
	db 8 ; ?
	dw WATER_ENERGY
	dw $535a ; effect commands
	tx Text12f2 ; description
	dw NONE ; pre-evo name

LightningEnergyCard:
	db TYPE_ENERGY_LIGHTNING ; type
	dw $1b7 ; gfx
	tx Text12f3 ; name
	db CIRCLE ; rarity
	db BEGINNING_POKEMON ; set
	db 8 ; ?
	dw LIGHTNING_ENERGY
	dw $5358 ; effect commands
	tx Text12f4 ; description
	dw NONE ; pre-evo name

FightingEnergyCard:
	db TYPE_ENERGY_FIGHTING ; type
	dw $240 ; gfx
	tx Text12f5 ; name
	db CIRCLE ; rarity
	db BEGINNING_POKEMON ; set
	db 8 ; ?
	dw FIGHTING_ENERGY
	dw $5356 ; effect commands
	tx Text12f6 ; description
	dw NONE ; pre-evo name

PsychicEnergyCard:
	db TYPE_ENERGY_PSYCHIC ; type
	dw $2d7 ; gfx
	tx Text12f7 ; name
	db CIRCLE ; rarity
	db BEGINNING_POKEMON ; set
	db 8 ; ?
	dw PSYCHIC_ENERGY
	dw $5354 ; effect commands
	tx Text12f8 ; description
	dw NONE ; pre-evo name

DoubleColorlessEnergyCard:
	db TYPE_ENERGY_DOUBLE_COLORLESS ; type
	dw $366 ; gfx
	tx Text12f9 ; name
	db DIAMOND ; rarity
	db BEGINNING_POKEMON ; set
	db 1 ; ?
	dw DOUBLE_COLORLESS_ENERGY
	dw $5352 ; effect commands
	tx Text12fa ; description
	dw NONE ; pre-evo name

PotionEnergyCard:
	db TYPE_ENERGY_UNUSED ; type
	dw $3fb ; gfx
	tx Text12fb ; name
	db CIRCLE ; rarity
	db PSYCHIC_BATTLE ; set
	db 5 ; ?
	dw POTION_ENERGY
	dw $4bfa ; effect commands
	tx Text12fc ; description
	tx Text12fd ; description (cont)

FullhealEnergyCard:
	db TYPE_ENERGY_UNUSED ; type
	dw $466 ; gfx
	tx Text12fe ; name
	db CIRCLE ; rarity
	db PSYCHIC_BATTLE ; set
	db 5 ; ?
	dw FULLHEAL_ENERGY
	dw $4bff ; effect commands
	tx Text12ff ; description
	tx Text12fd ; description (cont)

RainbowEnergyCard:
	db TYPE_ENERGY_UNUSED ; type
	dw $4cf ; gfx
	tx Text1300 ; name
	db STAR ; rarity
	db PSYCHIC_BATTLE ; set
	db 5 ; ?
	dw RAINBOW_ENERGY
	dw $4c04 ; effect commands
	tx Text1301 ; description
	dw NONE ; pre-evo name

RecycleEnergyCard:
	db TYPE_ENERGY_UNUSED ; type
	dw $c9c8 ; gfx
	tx Text1302 ; name
	db DIAMOND ; rarity
	db GB ; set
	db 6 ; ?
	dw RECYCLE_ENERGY
	dw $5350 ; effect commands
	tx Text1303 ; description
	dw NONE ; pre-evo name

SuperPotionCard:
	db TYPE_TRAINER ; type
	dw $b325 ; gfx
	tx Text18bd ; name
	db DIAMOND ; rarity
	db BEGINNING_POKEMON ; set
	db 0 ; ?
	dw SUPER_POTION
	dw $5360 ; effect commands
	tx Text18be ; description
	dw NONE ; pre-evo name

ImakuniCardCard:
	db TYPE_TRAINER ; type
	dw $a93b ; gfx
	tx Text18bf ; name
	db PROMOSTAR ; rarity
	db PRO ; set
	db 7 ; ?
	dw IMAKUNI_CARD
	dw $536b ; effect commands
	tx Text18c0 ; description
	dw NONE ; pre-evo name

EnergyRemovalCard:
	db TYPE_TRAINER ; type
	dw $acbd ; gfx
	tx Text18c1 ; name
	db CIRCLE ; rarity
	db BEGINNING_POKEMON ; set
	db 1 ; ?
	dw ENERGY_REMOVAL
	dw $5370 ; effect commands
	tx Text18c2 ; description
	dw NONE ; pre-evo name

EnergyRetrievalCard:
	db TYPE_TRAINER ; type
	dw $ab72 ; gfx
	tx Text18c3 ; name
	db DIAMOND ; rarity
	db BEGINNING_POKEMON ; set
	db 0 ; ?
	dw ENERGY_RETRIEVAL
	dw $537e ; effect commands
	tx Text18c4 ; description
	dw NONE ; pre-evo name

EnergySearchCard:
	db TYPE_TRAINER ; type
	dw $ac4a ; gfx
	tx Text18c5 ; name
	db CIRCLE ; rarity
	db ISLAND_OF_FOSSIL ; set
	db 0 ; ?
	dw ENERGY_SEARCH
	dw $538c ; effect commands
	tx Text18c6 ; description
	dw NONE ; pre-evo name

ProfessorOakCard:
	db TYPE_TRAINER ; type
	dw $a6f0 ; gfx
	tx Text18c7 ; name
	db DIAMOND ; rarity
	db BEGINNING_POKEMON ; set
	db 0 ; ?
	dw PROFESSOR_OAK
	dw $5397 ; effect commands
	tx Text18c8 ; description
	dw NONE ; pre-evo name

FossilExcavationCard:
	db TYPE_TRAINER ; type
	dw $bb4d ; gfx
	tx Text18c9 ; name
	db DIAMOND ; rarity
	db SKY_FLYING_POKEMON ; set
	db 3 ; ?
	dw FOSSIL_EXCAVATION
	dw $4d7d ; effect commands
	tx Text18ca ; description
	dw NONE ; pre-evo name

PotionCard:
	db TYPE_TRAINER ; type
	dw $b296 ; gfx
	tx Text18cb ; name
	db CIRCLE ; rarity
	db BEGINNING_POKEMON ; set
	db 0 ; ?
	dw POTION
	dw $539c ; effect commands
	tx Text18cc ; description
	dw NONE ; pre-evo name

GamblerCard:
	db TYPE_TRAINER ; type
	dw $b5b0 ; gfx
	tx Text18cd ; name
	db CIRCLE ; rarity
	db ISLAND_OF_FOSSIL ; set
	db 3 ; ?
	dw GAMBLER
	dw $53a7 ; effect commands
	tx Text18ce ; description
	dw NONE ; pre-evo name

ReviveCard:
	db TYPE_TRAINER ; type
	dw $b449 ; gfx
	tx Text18cf ; name
	db DIAMOND ; rarity
	db BEGINNING_POKEMON ; set
	db 1 ; ?
	dw REVIVE
	dw $5472 ; effect commands
	tx Text18d0 ; description
	dw NONE ; pre-evo name

MaxReviveCard:
	db TYPE_TRAINER ; type
	dw $bc2b ; gfx
	tx Text18d1 ; name
	db DIAMOND ; rarity
	db SKY_FLYING_POKEMON ; set
	db 5 ; ?
	dw MAX_REVIVE
	dw $4d99 ; effect commands
	tx Text18d2 ; description
	tx Text18d3 ; description (cont)

SuperScoopUpCard:
	db TYPE_TRAINER ; type
	dw $bef1 ; gfx
	tx Text18d4 ; name
	db CIRCLE ; rarity
	db TEAM_ROCKETS_AMBITION ; set
	db 6 ; ?
	dw SUPER_SCOOP_UP
	dw $52c3 ; effect commands
	tx Text18d5 ; description
	dw NONE ; pre-evo name

DevolutionSprayCard:
	db TYPE_TRAINER ; type
	dw $b21d ; gfx
	tx Text18d6 ; name
	db STAR ; rarity
	db BEGINNING_POKEMON ; set
	db 5 ; ?
	dw DEVOLUTION_SPRAY
	dw $547d ; effect commands
	tx Text18d7 ; description
	dw NONE ; pre-evo name

ItemfinderCard:
	db TYPE_TRAINER ; type
	dw $b14b ; gfx
	tx Text18d8 ; name
	db STAR ; rarity
	db BEGINNING_POKEMON ; set
	db 2 ; ?
	dw ITEMFINDER
	dw $53ac ; effect commands
	tx Text18d9 ; description
	dw NONE ; pre-evo name

ChallengeCard:
	db TYPE_TRAINER ; type
	dw $b6a2 ; gfx
	tx Text18da ; name
	db DIAMOND ; rarity
	db PSYCHIC_BATTLE ; set
	db 6 ; ?
	dw CHALLENGE
	dw $4c09 ; effect commands
	tx Text18db ; description
	tx Text18dc ; description (cont)

SuperEnergyRetrievalCard:
	db TYPE_TRAINER ; type
	dw $abe1 ; gfx
	tx Text18dd ; name
	db PROMOSTAR ; rarity
	db PRO ; set
	db 7 ; ?
	dw SUPER_ENERGY_RETRIEVAL
	dw $5493 ; effect commands
	tx Text18de ; description
	dw NONE ; pre-evo name

SuperEnergyRemovalCard:
	db TYPE_TRAINER ; type
	dw $ad40 ; gfx
	tx Text18df ; name
	db STAR ; rarity
	db BEGINNING_POKEMON ; set
	db 2 ; ?
	dw SUPER_ENERGY_REMOVAL
	dw $5488 ; effect commands
	tx Text18e0 ; description
	dw NONE ; pre-evo name

MoonStoneCard:
	db TYPE_TRAINER ; type
	dw $bbba ; gfx
	tx Text18e1 ; name
	db STAR ; rarity
	db SKY_FLYING_POKEMON ; set
	db 3 ; ?
	dw MOON_STONE
	dw $4d8b ; effect commands
	tx Text18e2 ; description
	dw NONE ; pre-evo name

DefenderCard:
	db TYPE_TRAINER ; type
	dw $b0de ; gfx
	tx Text18e3 ; name
	db DIAMOND ; rarity
	db BEGINNING_POKEMON ; set
	db 1 ; ?
	dw DEFENDER
	dw $53b7 ; effect commands
	tx Text18e4 ; description
	dw NONE ; pre-evo name

GustOfWindCard:
	db TYPE_TRAINER ; type
	dw $b1b4 ; gfx
	tx Text18e5 ; name
	db CIRCLE ; rarity
	db BEGINNING_POKEMON ; set
	db 1 ; ?
	dw GUST_OF_WIND
	dw $54a1 ; effect commands
	tx Text18e6 ; description
	dw NONE ; pre-evo name

MysteriousFossilCard:
	db TYPE_TRAINER ; type
	dw $ab09 ; gfx
	tx Text15a3 ; name
	db CIRCLE ; rarity
	db ISLAND_OF_FOSSIL ; set
	db 2 ; ?
	dw MYSTERIOUS_FOSSIL
	dw $53bf ; effect commands
	tx Text18e7 ; description
	tx Text18e8 ; description (cont)

FullHealCard:
	db TYPE_TRAINER ; type
	dw $b3d4 ; gfx
	tx Text18e9 ; name
	db DIAMOND ; rarity
	db BEGINNING_POKEMON ; set
	db 0 ; ?
	dw FULL_HEAL
	dw $53c7 ; effect commands
	tx Text18ea ; description
	dw NONE ; pre-evo name

ImposterOaksRevengeCard:
	db TYPE_TRAINER ; type
	dw $b711 ; gfx
	tx Text18eb ; name
	db DIAMOND ; rarity
	db PSYCHIC_BATTLE ; set
	db 6 ; ?
	dw IMPOSTER_OAKS_REVENGE
	dw $4bbd ; effect commands
	tx Text18ec ; description
	dw NONE ; pre-evo name

ImposterProfessorOakCard:
	db TYPE_TRAINER ; type
	dw $a759 ; gfx
	tx Text18ed ; name
	db STAR ; rarity
	db BEGINNING_POKEMON ; set
	db 3 ; ?
	dw IMPOSTER_PROFESSOR_OAK
	dw $53cf ; effect commands
	tx Text18ee ; description
	dw NONE ; pre-evo name

SleepCard:
	db TYPE_TRAINER ; type
	dw $b780 ; gfx
	tx Text18ef ; name
	db CIRCLE ; rarity
	db PSYCHIC_BATTLE ; set
	db 6 ; ?
	dw SLEEP
	dw $4bc8 ; effect commands
	tx Text18f0 ; description
	dw NONE ; pre-evo name

ComputerErrorCard:
	db TYPE_TRAINER ; type
	dw $bdf3 ; gfx
	tx Text18f1 ; name
	db PROMOSTAR ; rarity
	db PRO ; set
	db 7 ; ?
	dw COMPUTER_ERROR
	dw $4dc2 ; effect commands
	tx Text18f2 ; description
	dw NONE ; pre-evo name

ComputerSearchCard:
	db TYPE_TRAINER ; type
	dw $af79 ; gfx
	tx Text18f3 ; name
	db STAR ; rarity
	db BEGINNING_POKEMON ; set
	db 2 ; ?
	dw COMPUTER_SEARCH
	dw $53d4 ; effect commands
	tx Text18f4 ; description
	dw NONE ; pre-evo name

DiggerCard:
	db TYPE_TRAINER ; type
	dw $b800 ; gfx
	tx Text18f5 ; name
	db CIRCLE ; rarity
	db PSYCHIC_BATTLE ; set
	db 6 ; ?
	dw DIGGER
	dw $4bcd ; effect commands
	tx Text18f6 ; description
	dw NONE ; pre-evo name

ClefairyDollCard:
	db TYPE_TRAINER ; type
	dw $aa96 ; gfx
	tx Text18f7 ; name
	db STAR ; rarity
	db BEGINNING_POKEMON ; set
	db 2 ; ?
	dw CLEFAIRY_DOLL
	dw $53e2 ; effect commands
	tx Text18f8 ; description
	tx Text18f9 ; description (cont)

MrFujiCard:
	db TYPE_TRAINER ; type
	dw $a869 ; gfx
	tx Text18fa ; name
	db DIAMOND ; rarity
	db ISLAND_OF_FOSSIL ; set
	db 4 ; ?
	dw MR_FUJI
	dw $53ea ; effect commands
	tx Text18fb ; description
	dw NONE ; pre-evo name

PluspowerCard:
	db TYPE_TRAINER ; type
	dw $b069 ; gfx
	tx Text18fc ; name
	db DIAMOND ; rarity
	db BEGINNING_POKEMON ; set
	db 1 ; ?
	dw PLUSPOWER
	dw $53f5 ; effect commands
	tx Text18fd ; description
	dw NONE ; pre-evo name

SwitchCard:
	db TYPE_TRAINER ; type
	dw $adb1 ; gfx
	tx Text18fe ; name
	db CIRCLE ; rarity
	db BEGINNING_POKEMON ; set
	db 0 ; ?
	dw SWITCH
	dw $53fa ; effect commands
	tx Text18ff ; description
	dw NONE ; pre-evo name

ScoopUpCard:
	db TYPE_TRAINER ; type
	dw $af0a ; gfx
	tx Text1900 ; name
	db STAR ; rarity
	db BEGINNING_POKEMON ; set
	db 0 ; ?
	dw SCOOP_UP
	dw $5423 ; effect commands
	tx Text1901 ; description
	dw NONE ; pre-evo name

PokemonTraderCard:
	db TYPE_TRAINER ; type
	dw $a9c4 ; gfx
	tx Text1902 ; name
	db CIRCLE ; rarity
	db BEGINNING_POKEMON ; set
	db 1 ; ?
	dw POKEMON_TRADER
	dw $542e ; effect commands
	tx Text1903 ; description
	tx Text1904 ; description (cont)

PokemonRecallCard:
	db TYPE_TRAINER ; type
	dw $bd11 ; gfx
	tx Text1905 ; name
	db STAR ; rarity
	db SKY_FLYING_POKEMON ; set
	db 4 ; ?
	dw POKEMON_RECALL
	dw $4daf ; effect commands
	tx Text1906 ; description
	dw NONE ; pre-evo name

PokedexCard:
	db TYPE_TRAINER ; type
	dw $b000 ; gfx
	tx Text1907 ; name
	db DIAMOND ; rarity
	db BEGINNING_POKEMON ; set
	db 0 ; ?
	dw POKEDEX
	dw $543c ; effect commands
	tx Text1908 ; description
	dw NONE ; pre-evo name

PokemonCenterCard:
	db TYPE_TRAINER ; type
	dw $ae2e ; gfx
	tx Text1909 ; name
	db DIAMOND ; rarity
	db BEGINNING_POKEMON ; set
	db 1 ; ?
	dw POKEMON_CENTER
	dw $5405 ; effect commands
	tx Text190a ; description
	dw NONE ; pre-evo name

PokemonBreederCard:
	db TYPE_TRAINER ; type
	dw $aa2d ; gfx
	tx Text190b ; name
	db STAR ; rarity
	db BEGINNING_POKEMON ; set
	db 1 ; ?
	dw POKEMON_BREEDER
	dw $5418 ; effect commands
	tx Text190c ; description
	dw NONE ; pre-evo name

PokemonFluteCard:
	db TYPE_TRAINER ; type
	dw $b53b ; gfx
	tx Text190d ; name
	db DIAMOND ; rarity
	db BEGINNING_POKEMON ; set
	db 4 ; ?
	dw POKEMON_FLUTE
	dw $540d ; effect commands
	tx Text190e ; description
	dw NONE ; pre-evo name

TheBosssWayCard:
	db TYPE_TRAINER ; type
	dw $b8a1 ; gfx
	tx Text190f ; name
	db DIAMOND ; rarity
	db PSYCHIC_BATTLE ; set
	db 5 ; ?
	dw THE_BOSSS_WAY
	dw $4bd2 ; effect commands
	tx Text1910 ; description
	dw NONE ; pre-evo name

GoopGasAttackCard:
	db TYPE_TRAINER ; type
	dw $b90c ; gfx
	tx Text1911 ; name
	db CIRCLE ; rarity
	db PSYCHIC_BATTLE ; set
	db 6 ; ?
	dw GOOP_GAS_ATTACK
	dw $4bdd ; effect commands
	tx Text1912 ; description
	dw NONE ; pre-evo name

BillCard:
	db TYPE_TRAINER ; type
	dw $a800 ; gfx
	tx Text1913 ; name
	db CIRCLE ; rarity
	db BEGINNING_POKEMON ; set
	db 0 ; ?
	dw BILL
	dw $5447 ; effect commands
	tx Text1914 ; description
	dw NONE ; pre-evo name

BillsTeleporterCard:
	db TYPE_TRAINER ; type
	dw $c3c5 ; gfx
	tx Text1915 ; name
	db CIRCLE ; rarity
	db TEAM_ROCKETS_AMBITION ; set
	db 6 ; ?
	dw BILLS_TELEPORTER
	dw $52ce ; effect commands
	tx Text1916 ; description
	dw NONE ; pre-evo name

BillsComputerCard:
	db TYPE_TRAINER ; type
	dw $bd7a ; gfx
	tx Text1917 ; name
	db CIRCLE ; rarity
	db SKY_FLYING_POKEMON ; set
	db 7 ; ?
	dw BILLS_COMPUTER
	dw $4dba ; effect commands
	tx Text1918 ; description
	tx Text1919 ; description (cont)

MasterBallCard:
	db TYPE_TRAINER ; type
	dw $bca6 ; gfx
	tx Text191a ; name
	db STAR ; rarity
	db SKY_FLYING_POKEMON ; set
	db 4 ; ?
	dw MASTER_BALL
	dw $4da4 ; effect commands
	tx Text191b ; description
	dw NONE ; pre-evo name

LassCard:
	db TYPE_TRAINER ; type
	dw $a8d2 ; gfx
	tx Text191c ; name
	db STAR ; rarity
	db BEGINNING_POKEMON ; set
	db 3 ; ?
	dw LASS
	dw $544c ; effect commands
	tx Text191d ; description
	dw NONE ; pre-evo name

MaintenenceCard:
	db TYPE_TRAINER ; type
	dw $b4d2 ; gfx
	tx Text191e ; name
	db DIAMOND ; rarity
	db BEGINNING_POKEMON ; set
	db 4 ; ?
	dw MAINTENENCE
	dw $5451 ; effect commands
	tx Text191f ; description
	dw NONE ; pre-evo name

PokeballCard:
	db TYPE_TRAINER ; type
	dw $ae9f ; gfx
	tx Text1920 ; name
	db CIRCLE ; rarity
	db LEGENDARY_POWER ; set
	db 2 ; ?
	dw POKEBALL
	dw $545c ; effect commands
	tx Text1921 ; description
	dw NONE ; pre-evo name

NightlyGarbageRunCard:
	db TYPE_TRAINER ; type
	dw $ba63 ; gfx
	tx Text1922 ; name
	db CIRCLE ; rarity
	db PSYCHIC_BATTLE ; set
	db 6 ; ?
	dw NIGHTLY_GARBAGE_RUN
	dw $4bef ; effect commands
	tx Text1923 ; description
	dw NONE ; pre-evo name

RecycleCard:
	db TYPE_TRAINER ; type
	dw $b619 ; gfx
	tx Text1924 ; name
	db CIRCLE ; rarity
	db ISLAND_OF_FOSSIL ; set
	db 3 ; ?
	dw RECYCLE
	dw $5467 ; effect commands
	tx Text1925 ; description
	dw NONE ; pre-evo name

RocketsSneakAttackCard:
	db TYPE_TRAINER ; type
	dw $b979 ; gfx
	tx Text1926 ; name
	db STAR ; rarity
	db PSYCHIC_BATTLE ; set
	db 6 ; ?
	dw ROCKETS_SNEAK_ATTACK
	dw $4be2 ; effect commands
	tx Text1927 ; description
	dw NONE ; pre-evo name

HereComesTeamRocketCard:
	db TYPE_TRAINER ; type
	dw $b9ee ; gfx
	tx Text1928 ; name
	db RARITY_3 ; rarity
	db PSYCHIC_BATTLE ; set
	db 7 ; ?
	dw HERE_COMES_TEAM_ROCKET
	dw $4bea ; effect commands
	tx Text1929 ; description
	dw NONE ; pre-evo name

TheRocketsTrapCard:
	db TYPE_TRAINER ; type
	dw $bae0 ; gfx
	tx Text192a ; name
	db STAR ; rarity
	db WE_ARE_TEAM_ROCKET ; set
	db 6 ; ?
	dw THE_ROCKETS_TRAP
	dw $4d75 ; effect commands
	tx Text192b ; description
	dw NONE ; pre-evo name
