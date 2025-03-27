MachokeLv24Card:
	db TYPE_PKMN_FIGHTING ; type
	dw $9239 ; gfx
	tx MachokeName ; name
	db DIAMOND ; rarity
	db EXPANSION_SHEET ; real set
	db ISLAND_OF_FOSSIL ; in-game set
	dw MACHOKE_LV24
	db 60 ; hp
	db STAGE1 ; stage
	tx MachopName ; pre-evo name

	; attack 1
	energy FIGHTING, 1, COLORLESS, 1 ; energies
	tx Text168a ; name
	tx Text1363 ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_NORMAL ; category
	dw EffectCommands_58fe4 ; effect commands
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
	dw EffectCommands_58fe9 ; effect commands
	db DAMAGE_TO_OPPONENT_BENCH  ; flags 1
	db FLAG_2_BIT_6  ; flags 2
	db FLAG_3_BIT_2  ; flags 3
	db 0 ; ?
	db ATK_ANIM_226 ; animation

	db 2 ; retreat cost
	db WR_PSYCHIC ; weakness
	db NONE ; resistance
	tx Text1682 ; category
	db DEX_MACHOKE ; Pokedex number
	db FALSE ; is Dark
	db 24 ; level
	length 1.5 ; length
	weight 70.5 ; weight
	tx MachokeDescription1 ; description
	db NONE | HAS_EVOLUTION ; AI info

MachokeLv28Card:
	db TYPE_PKMN_FIGHTING ; type
	dw $8417 ; gfx
	tx MachokeName ; name
	db DIAMOND ; rarity
	db EXPANSION_SHEET ; real set
	db SKY_FLYING_POKEMON ; in-game set
	dw MACHOKE_LV28
	db 70 ; hp
	db STAGE1 ; stage
	tx MachopName ; pre-evo name

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
	dw EffectCommands_58e28 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_PUNCH ; animation

	db 2 ; retreat cost
	db WR_PSYCHIC ; weakness
	db NONE ; resistance
	tx Text1682 ; category
	db DEX_MACHOKE ; Pokedex number
	db FALSE ; is Dark
	db 28 ; level
	length 1.5 ; length
	weight 70.5 ; weight
	tx MachokeDescription2 ; description
	db NONE | HAS_EVOLUTION ; AI info

MachokeLv40Card:
	db TYPE_PKMN_FIGHTING ; type
	dw $3b7a ; gfx
	tx MachokeName ; name
	db DIAMOND ; rarity
	db BASE_SET ; real set
	db BEGINNING_POKEMON ; in-game set
	dw MACHOKE_LV40
	db 80 ; hp
	db STAGE1 ; stage
	tx MachopName ; pre-evo name

	; attack 1
	energy FIGHTING, 2, COLORLESS, 1 ; energies
	tx Text1691 ; name
	tx Text1692 ; description
	dw NONE ; description (cont)
	db 50 ; damage
	db DAMAGE_MINUS ; category
	dw EffectCommands_585f0 ; effect commands
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
	dw EffectCommands_585f8 ; effect commands
	db LOW_RECOIL  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 20 ; ?
	db ATK_ANIM_HIT_RECOIL ; animation

	db 3 ; retreat cost
	db WR_PSYCHIC ; weakness
	db NONE ; resistance
	tx Text1682 ; category
	db DEX_MACHOKE ; Pokedex number
	db FALSE ; is Dark
	db 40 ; level
	length 1.5 ; length
	weight 70.5 ; weight
	tx MachokeDescription3 ; description
	db NONE | HAS_EVOLUTION ; AI info

DarkMachokeCard:
	db TYPE_PKMN_FIGHTING ; type
	dw $6a4f ; gfx
	tx DarkMachokeName ; name
	db DIAMOND ; rarity
	db TEAM_ROCKET ; real set
	db WE_ARE_TEAM_ROCKET ; in-game set
	dw DARK_MACHOKE
	db 60 ; hp
	db STAGE1 ; stage
	tx MachopName ; pre-evo name

	; attack 1
	energy FIGHTING, 2, COLORLESS, 1 ; energies
	tx Text1696 ; name
	tx Text1697 ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db RESIDUAL ; category
	dw EffectCommands_58ae1 ; effect commands
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
	dw EffectCommands_58aef ; effect commands
	db NONE ; flags 1
	db SWITCH_OPPONENT_POKEMON  ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_PUNCH ; animation

	db 2 ; retreat cost
	db WR_PSYCHIC ; weakness
	db NONE ; resistance
	tx Text1682 ; category
	db DEX_MACHOKE ; Pokedex number
	db TRUE ; is Dark
	db 28 ; level
	length 1.5 ; length
	weight 70.5 ; weight
	tx DarkMachokeDescription ; description
	db NONE | HAS_EVOLUTION ; AI info

MachampLv54Card:
	db TYPE_PKMN_FIGHTING ; type
	dw $92a2 ; gfx
	tx MachampName ; name
	db STAR ; rarity
	db EXPANSION_SHEET ; real set
	db PROMOTIONAL ; in-game set
	dw MACHAMP_LV54
	db 90 ; hp
	db STAGE2 ; stage
	tx MachokeName ; pre-evo name

	; attack 1
	energy FIGHTING, 2 ; energies
	tx Text169b ; name
	tx Text169c ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_PLUS ; category
	dw EffectCommands_58ffd ; effect commands
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
	dw EffectCommands_59005 ; effect commands
	db NONE ; flags 1
	db SWITCH_OPPONENT_POKEMON  ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_176 ; animation

	db 3 ; retreat cost
	db WR_PSYCHIC ; weakness
	db NONE ; resistance
	tx Text1682 ; category
	db DEX_MACHAMP ; Pokedex number
	db FALSE ; is Dark
	db 54 ; level
	length 1.6 ; length
	weight 130.0 ; weight
	tx MachampDescription1 ; description
	db NONE ; AI info

MachampLv67Card:
	db TYPE_PKMN_FIGHTING ; type
	dw $3be3 ; gfx
	tx MachampName ; name
	db STAR ; rarity
	db BASE_SET ; real set
	db BEGINNING_POKEMON ; in-game set
	dw MACHAMP_LV67
	db 100 ; hp
	db STAGE2 ; stage
	tx MachokeName ; pre-evo name

	; attack 1
	energy 0 ; energies
	tx Text169f ; name
	tx Text16a0 ; description
	tx Text16a1 ; description (cont)
	db 0 ; damage
	db POKEMON_POWER ; category
	dw EffectCommands_585be ; effect commands
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
	db DEX_MACHAMP ; Pokedex number
	db FALSE ; is Dark
	db 67 ; level
	length 1.6 ; length
	weight 130.0 ; weight
	tx MachampDescription2 ; description
	db NONE ; AI info

DarkMachampCard:
	db TYPE_PKMN_FIGHTING ; type
	dw $6ac6 ; gfx
	tx DarkMachampName ; name
	db STAR ; rarity
	db TEAM_ROCKET ; real set
	db WE_ARE_TEAM_ROCKET ; in-game set
	dw DARK_MACHAMP
	db 70 ; hp
	db STAGE2 ; stage
	tx DarkMachokeName ; pre-evo name

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
	dw EffectCommands_58afa ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db SPECIAL_AI_HANDLING  ; flags 3
	db 0 ; ?
	db ATK_ANIM_MIRROR_MOVE ; animation

	db 3 ; retreat cost
	db WR_PSYCHIC ; weakness
	db NONE ; resistance
	tx Text1682 ; category
	db DEX_MACHAMP ; Pokedex number
	db TRUE ; is Dark
	db 30 ; level
	length 1.6 ; length
	weight 130.0 ; weight
	tx DarkMachampDescription ; description
	db NONE ; AI info

GeodudeLv15Card:
	db TYPE_PKMN_FIGHTING ; type
	dw $7b8c ; gfx
	tx GeodudeName ; name
	db CIRCLE ; rarity
	db EXPANSION_SHEET ; real set
	db LEGENDARY_POWER ; in-game set
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
	dw EffectCommands_58ceb ; effect commands
	db NONE ; flags 1
	db NULLIFY_OR_WEAKEN_ATTACK  ; flags 2
	db FLAG_3_BIT_2  ; flags 3
	db 0 ; ?
	db ATK_ANIM_PROTECT ; animation

	db 1 ; retreat cost
	db WR_GRASS ; weakness
	db NONE ; resistance
	tx Text16ab ; category
	db DEX_GEODUDE ; Pokedex number
	db FALSE ; is Dark
	db 15 ; level
	length 0.4 ; length
	weight 20.0 ; weight
	tx GeodudeDescription1 ; description
	db NONE | HAS_EVOLUTION ; AI info

GeodudeLv16Card:
	db TYPE_PKMN_FIGHTING ; type
	dw $3c4c ; gfx
	tx GeodudeName ; name
	db CIRCLE ; rarity
	db FOSSIL ; real set
	db SKY_FLYING_POKEMON ; in-game set
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
	dw EffectCommands_585a4 ; effect commands
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
	db DEX_GEODUDE ; Pokedex number
	db FALSE ; is Dark
	db 16 ; level
	length 0.4 ; length
	weight 20.0 ; weight
	tx GeodudeDescription2 ; description
	db AI_INFO_UNK_03 | HAS_EVOLUTION ; AI info

GravelerLv27Card:
	db TYPE_PKMN_FIGHTING ; type
	dw $93dd ; gfx
	tx GravelerName ; name
	db DIAMOND ; rarity
	db EXPANSION_SHEET ; real set
	db PSYCHIC_BATTLE ; in-game set
	dw GRAVELER_LV27
	db 60 ; hp
	db STAGE1 ; stage
	tx GeodudeName ; pre-evo name

	; attack 1
	energy FIGHTING, 2, COLORLESS, 1 ; energies
	tx Text16b1 ; name
	tx Text16b2 ; description
	dw NONE ; description (cont)
	db 30 ; damage
	db DAMAGE_NORMAL ; category
	dw EffectCommands_5902d ; effect commands
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
	db DEX_GRAVELER ; Pokedex number
	db FALSE ; is Dark
	db 27 ; level
	length 1.0 ; length
	weight 105.0 ; weight
	tx GravelerDescription1 ; description
	db NONE | HAS_EVOLUTION ; AI info

GravelerLv28Card:
	db TYPE_PKMN_FIGHTING ; type
	dw $84e0 ; gfx
	tx GravelerName ; name
	db DIAMOND ; rarity
	db EXPANSION_SHEET ; real set
	db SKY_FLYING_POKEMON ; in-game set
	dw GRAVELER_LV28
	db 60 ; hp
	db STAGE1 ; stage
	tx GeodudeName ; pre-evo name

	; attack 1
	energy FIGHTING, 2 ; energies
	tx Text16b4 ; name
	tx Text16b5 ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_X ; category
	dw EffectCommands_58e30 ; effect commands
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
	dw EffectCommands_58e38 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db SPECIAL_AI_HANDLING  ; flags 3
	db 0 ; ?
	db ATK_ANIM_3 ; animation

	db 2 ; retreat cost
	db WR_GRASS ; weakness
	db NONE ; resistance
	tx Text16ab ; category
	db DEX_GRAVELER ; Pokedex number
	db FALSE ; is Dark
	db 28 ; level
	length 1.0 ; length
	weight 105.0 ; weight
	tx GravelerDescription2 ; description
	db NONE | HAS_EVOLUTION ; AI info

GravelerLv29Card:
	db TYPE_PKMN_FIGHTING ; type
	dw $3cb5 ; gfx
	tx GravelerName ; name
	db DIAMOND ; rarity
	db FOSSIL ; real set
	db LEGENDARY_POWER ; in-game set
	dw GRAVELER_LV29
	db 60 ; hp
	db STAGE1 ; stage
	tx GeodudeName ; pre-evo name

	; attack 1
	energy FIGHTING, 2 ; energies
	tx Text16a9 ; name
	tx Text16b8 ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db RESIDUAL ; category
	dw EffectCommands_58602 ; effect commands
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
	db DEX_GRAVELER ; Pokedex number
	db FALSE ; is Dark
	db 29 ; level
	length 1.0 ; length
	weight 105.0 ; weight
	tx GravelerDescription3 ; description
	db NONE | HAS_EVOLUTION ; AI info

GolemLv36Card:
	db TYPE_PKMN_FIGHTING ; type
	dw $3d1e ; gfx
	tx GolemName ; name
	db DIAMOND ; rarity
	db FOSSIL ; real set
	db ISLAND_OF_FOSSIL ; in-game set
	dw GOLEM_LV36
	db 80 ; hp
	db STAGE2 ; stage
	tx GravelerName ; pre-evo name

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
	dw EffectCommands_585fd ; effect commands
	db HIGH_RECOIL  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 100 ; ?
	db ATK_ANIM_BIG_SELFDESTRUCTION ; animation

	db 4 ; retreat cost
	db WR_GRASS ; weakness
	db NONE ; resistance
	tx Text16bd ; category
	db DEX_GOLEM ; Pokedex number
	db FALSE ; is Dark
	db 36 ; level
	length 1.4 ; length
	weight 300.0 ; weight
	tx GolemDescription1 ; description
	db NONE ; AI info

GolemLv37Card:
	db TYPE_PKMN_FIGHTING ; type
	dw $9446 ; gfx
	tx GolemName ; name
	db STAR ; rarity
	db EXPANSION_SHEET ; real set
	db PROMOTIONAL ; in-game set
	dw GOLEM_LV37
	db 80 ; hp
	db STAGE2 ; stage
	tx GravelerName ; pre-evo name

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
	dw EffectCommands_5903b ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db SPECIAL_AI_HANDLING | FLAG_3_BIT_2  ; flags 3
	db 0 ; ?
	db ATK_ANIM_175 ; animation

	db 3 ; retreat cost
	db WR_GRASS ; weakness
	db NONE ; resistance
	tx Text16bd ; category
	db DEX_GOLEM ; Pokedex number
	db FALSE ; is Dark
	db 37 ; level
	length 1.4 ; length
	weight 300.0 ; weight
	tx GolemDescription2 ; description
	db NONE ; AI info

OnixLv12Card:
	db TYPE_PKMN_FIGHTING ; type
	dw $3d87 ; gfx
	tx OnixName ; name
	db CIRCLE ; rarity
	db BASE_SET ; real set
	db BEGINNING_POKEMON ; in-game set
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
	dw EffectCommands_585ac ; effect commands
	db NONE ; flags 1
	db NULLIFY_OR_WEAKEN_ATTACK  ; flags 2
	db FLAG_3_BIT_2  ; flags 3
	db 0 ; ?
	db ATK_ANIM_PROTECT ; animation

	db 3 ; retreat cost
	db WR_GRASS ; weakness
	db NONE ; resistance
	tx Text16c5 ; category
	db DEX_ONIX ; Pokedex number
	db FALSE ; is Dark
	db 12 ; level
	length 8.8 ; length
	weight 210.0 ; weight
	tx OnixDescription1 ; description
	db NONE ; AI info

OnixLv25Card:
	db TYPE_PKMN_FIGHTING ; type
	dw $8772 ; gfx
	tx OnixName ; name
	db DIAMOND ; rarity
	db EXPANSION_SHEET ; real set
	db TEAM_ROCKETS_AMBITION ; in-game set
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
	dw EffectCommands_58e8f ; effect commands
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
	dw EffectCommands_58e94 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_174 ; animation

	db 2 ; retreat cost
	db WR_GRASS ; weakness
	db NONE ; resistance
	tx Text16c5 ; category
	db DEX_ONIX ; Pokedex number
	db FALSE ; is Dark
	db 25 ; level
	length 8.8 ; length
	weight 210.0 ; weight
	tx OnixDescription2 ; description
	db NONE ; AI info

CuboneLv13Card:
	db TYPE_PKMN_FIGHTING ; type
	dw $3df0 ; gfx
	tx CuboneName ; name
	db CIRCLE ; rarity
	db JUNGLE ; real set
	db SKY_FLYING_POKEMON ; in-game set
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
	dw EffectCommands_585cd ; effect commands
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
	dw EffectCommands_585d2 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db BOOST_IF_TAKEN_DAMAGE  ; flags 3
	db 0 ; ?
	db ATK_ANIM_HIT ; animation

	db 1 ; retreat cost
	db WR_GRASS ; weakness
	db WR_LIGHTNING ; resistance
	tx Text16cd ; category
	db DEX_CUBONE ; Pokedex number
	db FALSE ; is Dark
	db 13 ; level
	length 0.4 ; length
	weight 6.5 ; weight
	tx CuboneDescription1 ; description
	db AI_INFO_UNK_03 | HAS_EVOLUTION ; AI info

CuboneLv14Card:
	db TYPE_PKMN_FIGHTING ; type
	dw $9869 ; gfx
	tx CuboneName ; name
	db CIRCLE ; rarity
	db EXPANSION_SHEET ; real set
	db LEGENDARY_POWER ; in-game set
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
	dw EffectCommands_590c6 ; effect commands
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
	db DEX_CUBONE ; Pokedex number
	db FALSE ; is Dark
	db 14 ; level
	length 0.4 ; length
	weight 6.5 ; weight
	tx CuboneDescription2 ; description
	db NONE | HAS_EVOLUTION ; AI info

MarowakLv26Card:
	db TYPE_PKMN_FIGHTING ; type
	dw $3e59 ; gfx
	tx MarowakName ; name
	db DIAMOND ; rarity
	db JUNGLE ; real set
	db SKY_FLYING_POKEMON ; in-game set
	dw MAROWAK_LV26
	db 60 ; hp
	db STAGE1 ; stage
	tx CuboneName ; pre-evo name

	; attack 1
	energy FIGHTING, 2 ; energies
	tx Text16d3 ; name
	tx Text1352 ; description
	dw NONE ; description (cont)
	db 30 ; damage
	db DAMAGE_X ; category
	dw EffectCommands_585da ; effect commands
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
	dw EffectCommands_585e2 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db SPECIAL_AI_HANDLING | FLAG_3_BIT_2  ; flags 3
	db 0 ; ?
	db ATK_ANIM_GLOW_EFFECT ; animation

	db 1 ; retreat cost
	db WR_GRASS ; weakness
	db WR_LIGHTNING ; resistance
	tx Text16d6 ; category
	db DEX_MAROWAK ; Pokedex number
	db FALSE ; is Dark
	db 26 ; level
	length 1.0 ; length
	weight 45.0 ; weight
	tx MarowakDescription1 ; description
	db NONE ; AI info

MarowakLv32Card:
	db TYPE_PKMN_FIGHTING ; type
	dw $3ec2 ; gfx
	tx MarowakName ; name
	db DIAMOND ; rarity
	db GB ; real set
	db LEGENDARY_POWER ; in-game set
	dw MAROWAK_LV32
	db 70 ; hp
	db STAGE1 ; stage
	tx CuboneName ; pre-evo name

	; attack 1
	energy FIGHTING, 1, COLORLESS, 1 ; energies
	tx Text16d8 ; name
	tx Text16d9 ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_NORMAL ; category
	dw EffectCommands_58644 ; effect commands
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
	dw EffectCommands_58649 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db SPECIAL_AI_HANDLING | FLAG_3_BIT_2  ; flags 3
	db 0 ; ?
	db ATK_ANIM_CRY ; animation

	db 2 ; retreat cost
	db WR_GRASS ; weakness
	db WR_LIGHTNING ; resistance
	tx Text16d6 ; category
	db DEX_MAROWAK ; Pokedex number
	db FALSE ; is Dark
	db 32 ; level
	length 1.0 ; length
	weight 45.0 ; weight
	tx MarowakDescription2 ; description
	db NONE ; AI info

DarkMarowakCard:
	db TYPE_PKMN_FIGHTING ; type
	dw $c800 ; gfx
	tx DarkMarowakName ; name
	db DIAMOND ; rarity
	db GB ; real set
	db TEAM_ROCKETS_AMBITION ; in-game set
	dw DARK_MAROWAK
	db 60 ; hp
	db STAGE1 ; stage
	tx CuboneName ; pre-evo name

	; attack 1
	energy FIGHTING, 2 ; energies
	tx Text16de ; name
	tx Text16df ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_NORMAL ; category
	dw EffectCommands_59327 ; effect commands
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
	db DEX_MAROWAK ; Pokedex number
	db TRUE ; is Dark
	db 27 ; level
	length 1.0 ; length
	weight 45.0 ; weight
	tx DarkMarowakDescription ; description
	db NONE ; AI info

HitmonleeLv23Card:
	db TYPE_PKMN_FIGHTING ; type
	dw $88d2 ; gfx
	tx HitmonleeName ; name
	db STAR ; rarity
	db EXPANSION_SHEET ; real set
	db LEGENDARY_POWER ; in-game set
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
	dw EffectCommands_58eab ; effect commands
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
	dw EffectCommands_58eb3 ; effect commands
	db INFLICT_PARALYSIS  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_182 ; animation

	db 1 ; retreat cost
	db WR_PSYCHIC ; weakness
	db NONE ; resistance
	tx Text1687 ; category
	db DEX_HITMONLEE ; Pokedex number
	db FALSE ; is Dark
	db 23 ; level
	length 1.5 ; length
	weight 49.8 ; weight
	tx HitmonleeDescription1 ; description
	db NONE ; AI info

HitmonleeLv30Card:
	db TYPE_PKMN_FIGHTING ; type
	dw $3f2b ; gfx
	tx HitmonleeName ; name
	db STAR ; rarity
	db FOSSIL ; real set
	db SKY_FLYING_POKEMON ; in-game set
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
	dw EffectCommands_58617 ; effect commands
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
	db DEX_HITMONLEE ; Pokedex number
	db FALSE ; is Dark
	db 30 ; level
	length 1.5 ; length
	weight 49.8 ; weight
	tx HitmonleeDescription2 ; description
	db NONE ; AI info

HitmonchanLv23Card:
	db TYPE_PKMN_FIGHTING ; type
	dw $893b ; gfx
	tx HitmonchanName ; name
	db STAR ; rarity
	db EXPANSION_SHEET ; real set
	db SKY_FLYING_POKEMON ; in-game set
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
	dw EffectCommands_58eb8 ; effect commands
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
	db DEX_HITMONCHAN ; Pokedex number
	db FALSE ; is Dark
	db 23 ; level
	length 1.4 ; length
	weight 50.2 ; weight
	tx HitmonchanDescription1 ; description
	db NONE ; AI info

HitmonchanLv33Card:
	db TYPE_PKMN_FIGHTING ; type
	dw $3f94 ; gfx
	tx HitmonchanName ; name
	db STAR ; rarity
	db BASE_SET ; real set
	db BEGINNING_POKEMON ; in-game set
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
	db DEX_HITMONCHAN ; Pokedex number
	db FALSE ; is Dark
	db 33 ; level
	length 1.4 ; length
	weight 50.2 ; weight
	tx HitmonchanDescription2 ; description
	db NONE ; AI info

RhyhornCard:
	db TYPE_PKMN_FIGHTING ; type
	dw $4000 ; gfx
	tx RhyhornName ; name
	db CIRCLE ; rarity
	db JUNGLE ; real set
	db LEGENDARY_POWER ; in-game set
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
	dw EffectCommands_58612 ; effect commands
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
	db DEX_RHYHORN ; Pokedex number
	db FALSE ; is Dark
	db 18 ; level
	length 1.0 ; length
	weight 115.0 ; weight
	tx RhyhornDescription ; description
	db NONE | HAS_EVOLUTION ; AI info

RhydonLv37Card:
	db TYPE_PKMN_FIGHTING ; type
	dw $993b ; gfx
	tx RhydonName ; name
	db STAR ; rarity
	db EXPANSION_SHEET ; real set
	db PSYCHIC_BATTLE ; in-game set
	dw RHYDON_LV37
	db 80 ; hp
	db STAGE1 ; stage
	tx RhyhornName ; pre-evo name

	; attack 1
	energy FIGHTING, 1 ; energies
	tx Text16f5 ; name
	tx Text16f6 ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_NORMAL ; category
	dw EffectCommands_590e7 ; effect commands
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
	dw EffectCommands_590ef ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_HIT ; animation

	db 3 ; retreat cost
	db WR_GRASS ; weakness
	db WR_LIGHTNING ; resistance
	tx Text1383 ; category
	db DEX_RHYDON ; Pokedex number
	db FALSE ; is Dark
	db 37 ; level
	length 1.9 ; length
	weight 120.0 ; weight
	tx RhydonDescription1 ; description
	db NONE ; AI info

RhydonLv48Card:
	db TYPE_PKMN_FIGHTING ; type
	dw $4069 ; gfx
	tx RhydonName ; name
	db DIAMOND ; rarity
	db JUNGLE ; real set
	db LEGENDARY_POWER ; in-game set
	dw RHYDON_LV48
	db 100 ; hp
	db STAGE1 ; stage
	tx RhyhornName ; pre-evo name

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
	dw EffectCommands_58607 ; effect commands
	db LOW_RECOIL  ; flags 1
	db SWITCH_OPPONENT_POKEMON  ; flags 2
	db NONE ; flags 3
	db 20 ; ?
	db ATK_ANIM_HIT_RECOIL ; animation

	db 3 ; retreat cost
	db WR_GRASS ; weakness
	db WR_LIGHTNING ; resistance
	tx Text1383 ; category
	db DEX_RHYDON ; Pokedex number
	db FALSE ; is Dark
	db 48 ; level
	length 1.9 ; length
	weight 120.0 ; weight
	tx RhydonDescription2 ; description
	db NONE ; AI info

KabutoLv9Card:
	db TYPE_PKMN_FIGHTING ; type
	dw $40d2 ; gfx
	tx KabutoName ; name
	db CIRCLE ; rarity
	db FOSSIL ; real set
	db ISLAND_OF_FOSSIL ; in-game set
	dw KABUTO_LV9
	db 30 ; hp
	db STAGE1 ; stage
	tx MysteriousFossilName ; pre-evo name

	; attack 1
	energy 0 ; energies
	tx Text16fd ; name
	tx Text16fe ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db POKEMON_POWER ; category
	dw EffectCommands_585c3 ; effect commands
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
	db DEX_KABUTO ; Pokedex number
	db FALSE ; is Dark
	db 9 ; level
	length 0.5 ; length
	weight 11.5 ; weight
	tx KabutoDescription1 ; description
	db AI_INFO_UNK_03 | HAS_EVOLUTION ; AI info

KabutoLv22Card:
	db TYPE_PKMN_FIGHTING ; type
	dw $8b05 ; gfx
	tx KabutoName ; name
	db DIAMOND ; rarity
	db EXPANSION_SHEET ; real set
	db WE_ARE_TEAM_ROCKET ; in-game set
	dw KABUTO_LV22
	db 50 ; hp
	db STAGE1 ; stage
	tx MysteriousFossilName ; pre-evo name

	; attack 1
	energy 0 ; energies
	tx Text1700 ; name
	tx Text1701 ; description
	tx Text15aa ; description (cont)
	db 0 ; damage
	db POKEMON_POWER ; category
	dw EffectCommands_58edd ; effect commands
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
	dw EffectCommands_58ee8 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_SLASH ; animation

	db 1 ; retreat cost
	db WR_GRASS ; weakness
	db NONE ; resistance
	tx Text14f2 ; category
	db DEX_KABUTO ; Pokedex number
	db FALSE ; is Dark
	db 22 ; level
	length 0.5 ; length
	weight 11.5 ; weight
	tx KabutoDescription2 ; description
	db NONE | HAS_EVOLUTION ; AI info

KabutopsCard:
	db TYPE_PKMN_FIGHTING ; type
	dw $413b ; gfx
	tx KabutopsName ; name
	db STAR ; rarity
	db FOSSIL ; real set
	db PSYCHIC_BATTLE ; in-game set
	dw KABUTOPS
	db 60 ; hp
	db STAGE2 ; stage
	tx KabutoName ; pre-evo name

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
	dw EffectCommands_585c8 ; effect commands
	db NONE ; flags 1
	db HEAL_USER  ; flags 2
	db NONE ; flags 3
	db 2 ; ?
	db ATK_ANIM_DRAIN ; animation

	db 1 ; retreat cost
	db WR_GRASS ; weakness
	db NONE ; resistance
	tx Text14f2 ; category
	db DEX_KABUTOPS ; Pokedex number
	db FALSE ; is Dark
	db 30 ; level
	length 1.3 ; length
	weight 40.5 ; weight
	tx KabutopsDescription ; description
	db NONE ; AI info

AerodactylLv28Card:
	db TYPE_PKMN_FIGHTING ; type
	dw $41a4 ; gfx
	tx AerodactylName ; name
	db STAR ; rarity
	db FOSSIL ; real set
	db WE_ARE_TEAM_ROCKET ; in-game set
	dw AERODACTYL_LV28
	db 60 ; hp
	db STAGE1 ; stage
	tx MysteriousFossilName ; pre-evo name

	; attack 1
	energy 0 ; energies
	tx Text170a ; name
	tx Text170b ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db POKEMON_POWER ; category
	dw EffectCommands_58637 ; effect commands
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
	db DEX_AERODACTYL ; Pokedex number
	db FALSE ; is Dark
	db 28 ; level
	length 1.8 ; length
	weight 59.0 ; weight
	tx AerodactylDescription1 ; description
	db AI_INFO_BENCH_UTILITY ; AI info

AerodactylLv30Card:
	db TYPE_PKMN_FIGHTING ; type
	dw $8b6e ; gfx
	tx AerodactylName ; name
	db DIAMOND ; rarity
	db EXPANSION_SHEET ; real set
	db ISLAND_OF_FOSSIL ; in-game set
	dw AERODACTYL_LV30
	db 70 ; hp
	db STAGE1 ; stage
	tx MysteriousFossilName ; pre-evo name

	; attack 1
	energy COLORLESS, 1 ; energies
	tx Text137b ; name
	tx Text1336 ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db DAMAGE_NORMAL ; category
	dw EffectCommands_58ef0 ; effect commands
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
	dw EffectCommands_58ef5 ; effect commands
	db LOW_RECOIL  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 10 ; ?
	db ATK_ANIM_HIT_RECOIL ; animation

	db 1 ; retreat cost
	db WR_GRASS ; weakness
	db WR_FIGHTING ; resistance
	tx Text170c ; category
	db DEX_AERODACTYL ; Pokedex number
	db FALSE ; is Dark
	db 30 ; level
	length 1.8 ; length
	weight 59.0 ; weight
	tx AerodactylDescription2 ; description
	db NONE ; AI info

AbraLv8Card:
	db TYPE_PKMN_PSYCHIC ; type
	dw $7b23 ; gfx
	tx AbraName ; name
	db CIRCLE ; rarity
	db EXPANSION_SHEET ; real set
	db SKY_FLYING_POKEMON ; in-game set
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
	dw EffectCommands_58cda ; effect commands
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
	db DEX_ABRA ; Pokedex number
	db FALSE ; is Dark
	db 8 ; level
	length 0.9 ; length
	weight 19.5 ; weight
	tx AbraDescription1 ; description
	db NONE | HAS_EVOLUTION ; AI info

AbraLv10Card:
	db TYPE_PKMN_PSYCHIC ; type
	dw $421b ; gfx
	tx AbraName ; name
	db CIRCLE ; rarity
	db BASE_SET ; real set
	db LEGENDARY_POWER ; in-game set
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
	dw EffectCommands_58450 ; effect commands
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
	db DEX_ABRA ; Pokedex number
	db FALSE ; is Dark
	db 10 ; level
	length 0.9 ; length
	weight 19.5 ; weight
	tx AbraDescription2 ; description
	db NONE | HAS_EVOLUTION ; AI info

AbraLv14Card:
	db TYPE_PKMN_PSYCHIC ; type
	dw $649b ; gfx
	tx AbraName ; name
	db CIRCLE ; rarity
	db TEAM_ROCKET ; real set
	db WE_ARE_TEAM_ROCKET ; in-game set
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
	dw EffectCommands_58a34 ; effect commands
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
	dw EffectCommands_58a3f ; effect commands
	db INFLICT_PARALYSIS  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_27 ; animation

	db 1 ; retreat cost
	db WR_PSYCHIC ; weakness
	db NONE ; resistance
	tx Text1505 ; category
	db DEX_ABRA ; Pokedex number
	db FALSE ; is Dark
	db 14 ; level
	length 0.9 ; length
	weight 19.5 ; weight
	tx AbraDescription3 ; description
	db NONE | HAS_EVOLUTION ; AI info

KadabraLv38Card:
	db TYPE_PKMN_PSYCHIC ; type
	dw $4286 ; gfx
	tx KadabraName ; name
	db DIAMOND ; rarity
	db BASE_SET ; real set
	db LEGENDARY_POWER ; in-game set
	dw KADABRA_LV38
	db 60 ; hp
	db STAGE1 ; stage
	tx AbraName ; pre-evo name

	; attack 1
	energy PSYCHIC, 2 ; energies
	tx Text1573 ; name
	tx Text171a ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db RESIDUAL ; category
	dw EffectCommands_58578 ; effect commands
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
	db DEX_KADABRA ; Pokedex number
	db FALSE ; is Dark
	db 38 ; level
	length 1.3 ; length
	weight 56.5 ; weight
	tx KadabraDescription1 ; description
	db NONE | HAS_EVOLUTION ; AI info

KadabraLv39Card:
	db TYPE_PKMN_PSYCHIC ; type
	dw $9163 ; gfx
	tx KadabraName ; name
	db STAR ; rarity
	db EXPANSION_SHEET ; real set
	db SKY_FLYING_POKEMON ; in-game set
	dw KADABRA_LV39
	db 60 ; hp
	db STAGE1 ; stage
	tx AbraName ; pre-evo name

	; attack 1
	energy PSYCHIC, 2 ; energies
	tx Text171c ; name
	tx Text171d ; description
	dw NONE ; description (cont)
	db 30 ; damage
	db DAMAGE_NORMAL ; category
	dw EffectCommands_58fbe ; effect commands
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
	dw EffectCommands_58fc6 ; effect commands
	db NONE ; flags 1
	db NULLIFY_OR_WEAKEN_ATTACK  ; flags 2
	db FLAG_3_BIT_2  ; flags 3
	db 0 ; ?
	db ATK_ANIM_166 ; animation

	db 3 ; retreat cost
	db WR_PSYCHIC ; weakness
	db NONE ; resistance
	tx Text1505 ; category
	db DEX_KADABRA ; Pokedex number
	db FALSE ; is Dark
	db 39 ; level
	length 1.3 ; length
	weight 56.5 ; weight
	tx KadabraDescription2 ; description
	db NONE | HAS_EVOLUTION ; AI info

DarkKadabraCard:
	db TYPE_PKMN_PSYCHIC ; type
	dw $6504 ; gfx
	tx DarkKadabraName ; name
	db DIAMOND ; rarity
	db TEAM_ROCKET ; real set
	db WE_ARE_TEAM_ROCKET ; in-game set
	dw DARK_KADABRA
	db 50 ; hp
	db STAGE1 ; stage
	tx AbraName ; pre-evo name

	; attack 1
	energy 0 ; energies
	tx Text1722 ; name
	tx Text1723 ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db POKEMON_POWER ; category
	dw EffectCommands_58a44 ; effect commands
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
	dw EffectCommands_58a4f ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_PSYCHIC_HIT ; animation

	db 2 ; retreat cost
	db WR_PSYCHIC ; weakness
	db NONE ; resistance
	tx Text1505 ; category
	db DEX_KADABRA ; Pokedex number
	db TRUE ; is Dark
	db 24 ; level
	length 1.3 ; length
	weight 56.5 ; weight
	tx DarkKadabraDescription ; description
	db NONE | HAS_EVOLUTION ; AI info

AlakazamLv42Card:
	db TYPE_PKMN_PSYCHIC ; type
	dw $42fb ; gfx
	tx AlakazamName ; name
	db STAR ; rarity
	db BASE_SET ; real set
	db ISLAND_OF_FOSSIL ; in-game set
	dw ALAKAZAM_LV42
	db 80 ; hp
	db STAGE2 ; stage
	tx KadabraName ; pre-evo name

	; attack 1
	energy 0 ; energies
	tx Text1728 ; name
	tx Text1729 ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db POKEMON_POWER ; category
	dw EffectCommands_584d3 ; effect commands
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
	dw EffectCommands_584de ; effect commands
	db INFLICT_CONFUSION  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_CONFUSE_RAY ; animation

	db 3 ; retreat cost
	db WR_PSYCHIC ; weakness
	db NONE ; resistance
	tx Text1505 ; category
	db DEX_ALAKAZAM ; Pokedex number
	db FALSE ; is Dark
	db 42 ; level
	length 1.5 ; length
	weight 48.0 ; weight
	tx AlakazamDescription1 ; description
	db NONE ; AI info

AlakazamLv45Card:
	db TYPE_PKMN_PSYCHIC ; type
	dw $91d0 ; gfx
	tx AlakazamName ; name
	db STAR ; rarity
	db EXPANSION_SHEET ; real set
	db PROMOTIONAL ; in-game set
	dw ALAKAZAM_LV45
	db 90 ; hp
	db STAGE2 ; stage
	tx KadabraName ; pre-evo name

	; attack 1
	energy PSYCHIC, 2 ; energies
	tx Text171c ; name
	tx Text171d ; description
	dw NONE ; description (cont)
	db 30 ; damage
	db DAMAGE_NORMAL ; category
	dw EffectCommands_58fcb ; effect commands
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
	dw EffectCommands_58fd3 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db SPECIAL_AI_HANDLING  ; flags 3
	db 0 ; ?
	db ATK_ANIM_225 ; animation

	db 3 ; retreat cost
	db WR_PSYCHIC ; weakness
	db NONE ; resistance
	tx Text1505 ; category
	db DEX_ALAKAZAM ; Pokedex number
	db FALSE ; is Dark
	db 45 ; level
	length 1.5 ; length
	weight 48.0 ; weight
	tx AlakazamDescription2 ; description
	db NONE ; AI info

DarkAlakazamCard:
	db TYPE_PKMN_PSYCHIC ; type
	dw $656d ; gfx
	tx DarkAlakazamName ; name
	db STAR ; rarity
	db TEAM_ROCKET ; real set
	db WE_ARE_TEAM_ROCKET ; in-game set
	dw DARK_ALAKAZAM
	db 60 ; hp
	db STAGE2 ; stage
	tx DarkKadabraName ; pre-evo name

	; attack 1
	energy PSYCHIC, 2, COLORLESS, 1 ; energies
	tx Text172f ; name
	tx Text1730 ; description
	dw NONE ; description (cont)
	db 30 ; damage
	db DAMAGE_NORMAL ; category
	dw EffectCommands_58a57 ; effect commands
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
	dw EffectCommands_58a65 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_PSYCHIC_HIT ; animation

	db 3 ; retreat cost
	db WR_PSYCHIC ; weakness
	db NONE ; resistance
	tx Text1505 ; category
	db DEX_ALAKAZAM ; Pokedex number
	db TRUE ; is Dark
	db 30 ; level
	length 1.5 ; length
	weight 48.0 ; weight
	tx DarkAlakazamDescription ; description
	db NONE ; AI info

SlowpokeLv9Card:
	db TYPE_PKMN_PSYCHIC ; type
	dw $4364 ; gfx
	tx SlowpokeName ; name
	db PROMOSTAR ; rarity
	db PRO ; real set
	db PROMOTIONAL ; in-game set
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
	dw EffectCommands_5856a ; effect commands
	db NONE ; flags 1
	db FLAG_2_BIT_6  ; flags 2
	db NONE ; flags 3
	db 2 ; ?
	db ATK_ANIM_AMNESIA ; animation

	db 1 ; retreat cost
	db WR_PSYCHIC ; weakness
	db NONE ; resistance
	tx Text1733 ; category
	db DEX_SLOWPOKE ; Pokedex number
	db FALSE ; is Dark
	db 9 ; level
	length 1.2 ; length
	weight 36.0 ; weight
	tx SlowpokeDescription1 ; description
	db AI_INFO_UNK_03 | HAS_EVOLUTION ; AI info

SlowpokeLv16Card:
	db TYPE_PKMN_PSYCHIC ; type
	dw $65da ; gfx
	tx SlowpokeName ; name
	db CIRCLE ; rarity
	db TEAM_ROCKET ; real set
	db TEAM_ROCKETS_AMBITION ; in-game set
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
	dw EffectCommands_58a6d ; effect commands
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
	db DEX_SLOWPOKE ; Pokedex number
	db FALSE ; is Dark
	db 16 ; level
	length 1.2 ; length
	weight 36.0 ; weight
	tx SlowpokeDescription2 ; description
	db NONE | HAS_EVOLUTION ; AI info

SlowpokeLv18Card:
	db TYPE_PKMN_PSYCHIC ; type
	dw $43e9 ; gfx
	tx SlowpokeName ; name
	db CIRCLE ; rarity
	db FOSSIL ; real set
	db ISLAND_OF_FOSSIL ; in-game set
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
	dw EffectCommands_5854b ; effect commands
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
	dw EffectCommands_58556 ; effect commands
	db NONE ; flags 1
	db DISCARD_ENERGY  ; flags 2
	db FLAG_3_BIT_2  ; flags 3
	db 2 ; ?
	db ATK_ANIM_GLOW_EFFECT ; animation

	db 1 ; retreat cost
	db WR_PSYCHIC ; weakness
	db NONE ; resistance
	tx Text1733 ; category
	db DEX_SLOWPOKE ; Pokedex number
	db FALSE ; is Dark
	db 18 ; level
	length 1.2 ; length
	weight 36.0 ; weight
	tx SlowpokeDescription3 ; description
	db NONE | HAS_EVOLUTION ; AI info

SlowbroLv26Card:
	db TYPE_PKMN_PSYCHIC ; type
	dw $4456 ; gfx
	tx SlowbroName ; name
	db DIAMOND ; rarity
	db FOSSIL ; real set
	db ISLAND_OF_FOSSIL ; in-game set
	dw SLOWBRO_LV26
	db 60 ; hp
	db STAGE1 ; stage
	tx SlowpokeName ; pre-evo name

	; attack 1
	energy 0 ; energies
	tx Text173e ; name
	tx Text173f ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db POKEMON_POWER ; category
	dw EffectCommands_5853b ; effect commands
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
	dw EffectCommands_58546 ; effect commands
	db INFLICT_PARALYSIS  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_PSYCHIC_HIT ; animation

	db 1 ; retreat cost
	db WR_PSYCHIC ; weakness
	db NONE ; resistance
	tx Text1740 ; category
	db DEX_SLOWBRO ; Pokedex number
	db FALSE ; is Dark
	db 26 ; level
	length 1.6 ; length
	weight 78.5 ; weight
	tx SlowbroDescription1 ; description
	db AI_INFO_BENCH_UTILITY ; AI info

SlowbroLv35Card:
	db TYPE_PKMN_PSYCHIC ; type
	dw $9518 ; gfx
	tx SlowbroName ; name
	db CIRCLE ; rarity
	db EXPANSION_SHEET ; real set
	db SKY_FLYING_POKEMON ; in-game set
	dw SLOWBRO_LV35
	db 90 ; hp
	db STAGE1 ; stage
	tx SlowpokeName ; pre-evo name

	; attack 1
	energy PSYCHIC, 1 ; energies
	tx Text1742 ; name
	tx Text1743 ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db DAMAGE_NORMAL ; category
	dw EffectCommands_59060 ; effect commands
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
	dw EffectCommands_59068 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_235 ; animation

	db 3 ; retreat cost
	db WR_PSYCHIC ; weakness
	db NONE ; resistance
	tx Text1740 ; category
	db DEX_SLOWBRO ; Pokedex number
	db FALSE ; is Dark
	db 35 ; level
	length 1.6 ; length
	weight 78.5 ; weight
	tx SlowbroDescription2 ; description
	db NONE ; AI info

DarkSlowbroCard:
	db TYPE_PKMN_PSYCHIC ; type
	dw $6661 ; gfx
	tx DarkSlowbroName ; name
	db STAR ; rarity
	db TEAM_ROCKET ; real set
	db TEAM_ROCKETS_AMBITION ; in-game set
	dw DARK_SLOWBRO
	db 60 ; hp
	db STAGE1 ; stage
	tx SlowpokeName ; pre-evo name

	; attack 1
	energy 0 ; energies
	tx Text1748 ; name
	tx Text1749 ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db POKEMON_POWER ; category
	dw EffectCommands_58a7b ; effect commands
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
	dw EffectCommands_58a86 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_HIT ; animation

	db 2 ; retreat cost
	db WR_PSYCHIC ; weakness
	db NONE ; resistance
	tx Text1740 ; category
	db DEX_SLOWBRO ; Pokedex number
	db TRUE ; is Dark
	db 27 ; level
	length 1.6 ; length
	weight 78.5 ; weight
	tx DarkSlowbroDescription ; description
	db NONE ; AI info

GastlyLv8Card:
	db TYPE_PKMN_PSYCHIC ; type
	dw $44d1 ; gfx
	tx GastlyName ; name
	db CIRCLE ; rarity
	db BASE_SET ; real set
	db BEGINNING_POKEMON ; in-game set
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
	dw EffectCommands_5846b ; effect commands
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
	dw EffectCommands_58470 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db SPECIAL_AI_HANDLING | FLAG_3_BIT_2  ; flags 3
	db 3 ; ?
	db ATK_ANIM_GLOW_EFFECT ; animation

	db 0 ; retreat cost
	db NONE ; weakness
	db WR_FIGHTING ; resistance
	tx Text1751 ; category
	db DEX_GASTLY ; Pokedex number
	db FALSE ; is Dark
	db 8 ; level
	length 1.3 ; length
	weight 0.1 ; weight
	tx GastlyDescription1 ; description
	db NONE | HAS_EVOLUTION ; AI info

GastlyLv13Card:
	db TYPE_PKMN_PSYCHIC ; type
	dw $9585 ; gfx
	tx GastlyName ; name
	db CIRCLE ; rarity
	db EXPANSION_SHEET ; real set
	db ISLAND_OF_FOSSIL ; in-game set
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
	dw EffectCommands_5906d ; effect commands
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
	dw EffectCommands_59072 ; effect commands
	db INFLICT_CONFUSION  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_229 ; animation

	db 0 ; retreat cost
	db NONE ; weakness
	db WR_FIGHTING ; resistance
	tx Text1751 ; category
	db DEX_GASTLY ; Pokedex number
	db FALSE ; is Dark
	db 13 ; level
	length 1.3 ; length
	weight 0.1 ; weight
	tx GastlyDescription2 ; description
	db NONE | HAS_EVOLUTION ; AI info

GastlyLv17Card:
	db TYPE_PKMN_PSYCHIC ; type
	dw $453a ; gfx
	tx GastlyName ; name
	db DIAMOND ; rarity
	db FOSSIL ; real set
	db PSYCHIC_BATTLE ; in-game set
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
	dw EffectCommands_58481 ; effect commands
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
	dw EffectCommands_58486 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db SPECIAL_AI_HANDLING | FLAG_3_BIT_2  ; flags 3
	db 10 ; ?
	db ATK_ANIM_ENERGY_CONVERSION ; animation

	db 0 ; retreat cost
	db NONE ; weakness
	db WR_FIGHTING ; resistance
	tx Text1751 ; category
	db DEX_GASTLY ; Pokedex number
	db FALSE ; is Dark
	db 17 ; level
	length 1.3 ; length
	weight 0.1 ; weight
	tx GastlyDescription3 ; description
	db AI_INFO_UNK_03 | HAS_EVOLUTION ; AI info

HaunterLv17Card:
	db TYPE_PKMN_PSYCHIC ; type
	dw $45a3 ; gfx
	tx HaunterName ; name
	db STAR ; rarity
	db FOSSIL ; real set
	db PSYCHIC_BATTLE ; in-game set
	dw HAUNTER_LV17
	db 50 ; hp
	db STAGE1 ; stage
	tx GastlyName ; pre-evo name

	; attack 1
	energy 0 ; energies
	tx Text175c ; name
	tx Text175d ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db POKEMON_POWER ; category
	dw EffectCommands_5849e ; effect commands
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
	dw EffectCommands_584a3 ; effect commands
	db INFLICT_SLEEP  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_NIGHTMARE ; animation

	db 0 ; retreat cost
	db NONE ; weakness
	db WR_FIGHTING ; resistance
	tx Text1751 ; category
	db DEX_HAUNTER ; Pokedex number
	db FALSE ; is Dark
	db 17 ; level
	length 1.6 ; length
	weight 0.1 ; weight
	tx HaunterDescription1 ; description
	db NONE | HAS_EVOLUTION ; AI info

HaunterLv22Card:
	db TYPE_PKMN_PSYCHIC ; type
	dw $460c ; gfx
	tx HaunterName ; name
	db DIAMOND ; rarity
	db BASE_SET ; real set
	db BEGINNING_POKEMON ; in-game set
	dw HAUNTER_LV22
	db 60 ; hp
	db STAGE1 ; stage
	tx GastlyName ; pre-evo name

	; attack 1
	energy PSYCHIC, 1 ; energies
	tx Text1416 ; name
	tx Text13b6 ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db DAMAGE_NORMAL ; category
	dw EffectCommands_58494 ; effect commands
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
	dw EffectCommands_58499 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_PSYCHIC_HIT ; animation

	db 1 ; retreat cost
	db NONE ; weakness
	db WR_FIGHTING ; resistance
	tx Text1751 ; category
	db DEX_HAUNTER ; Pokedex number
	db FALSE ; is Dark
	db 22 ; level
	length 1.6 ; length
	weight 0.1 ; weight
	tx HaunterDescription1 ; description
	db NONE | HAS_EVOLUTION ; AI info

HaunterLv25Card:
	db TYPE_PKMN_PSYCHIC ; type
	dw $9657 ; gfx
	tx HaunterName ; name
	db STAR ; rarity
	db EXPANSION_SHEET ; real set
	db SKY_FLYING_POKEMON ; in-game set
	dw HAUNTER_LV25
	db 60 ; hp
	db STAGE1 ; stage
	tx GastlyName ; pre-evo name

	; attack 1
	energy PSYCHIC, 1 ; energies
	tx Text1762 ; name
	tx Text1336 ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db DAMAGE_NORMAL ; category
	dw EffectCommands_59084 ; effect commands
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
	dw EffectCommands_59089 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_PSYCHIC_HIT ; animation

	db 1 ; retreat cost
	db NONE ; weakness
	db WR_FIGHTING ; resistance
	tx Text1751 ; category
	db DEX_HAUNTER ; Pokedex number
	db FALSE ; is Dark
	db 25 ; level
	length 1.6 ; length
	weight 0.1 ; weight
	tx HaunterDescription2 ; description
	db NONE | HAS_EVOLUTION ; AI info

HaunterLv26Card:
	db TYPE_PKMN_PSYCHIC ; type
	dw $95ee ; gfx
	tx HaunterName ; name
	db DIAMOND ; rarity
	db EXPANSION_SHEET ; real set
	db ISLAND_OF_FOSSIL ; in-game set
	dw HAUNTER_LV26
	db 70 ; hp
	db STAGE1 ; stage
	tx GastlyName ; pre-evo name

	; attack 1
	energy PSYCHIC, 1 ; energies
	tx Text1766 ; name
	tx Text1767 ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_X ; category
	dw EffectCommands_59077 ; effect commands
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
	dw EffectCommands_5907f ; effect commands
	db INFLICT_SLEEP | INFLICT_CONFUSION  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_NIGHTMARE ; animation

	db 1 ; retreat cost
	db NONE ; weakness
	db WR_FIGHTING ; resistance
	tx Text1751 ; category
	db DEX_HAUNTER ; Pokedex number
	db FALSE ; is Dark
	db 26 ; level
	length 1.6 ; length
	weight 0.1 ; weight
	tx HaunterDescription2 ; description
	db NONE | HAS_EVOLUTION ; AI info

DarkHaunterCard:
	db TYPE_PKMN_PSYCHIC ; type
	dw $c640 ; gfx
	tx DarkHaunterName ; name
	db DIAMOND ; rarity
	db GB ; real set
	db TEAM_ROCKETS_AMBITION ; in-game set
	dw DARK_HAUNTER
	db 60 ; hp
	db STAGE1 ; stage
	tx GastlyName ; pre-evo name

	; attack 1
	energy PSYCHIC, 2 ; energies
	tx Text176b ; name
	tx Text176c ; description
	dw NONE ; description (cont)
	db 30 ; damage
	db DAMAGE_NORMAL ; category
	dw EffectCommands_592e0 ; effect commands
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
	db DEX_HAUNTER ; Pokedex number
	db TRUE ; is Dark
	db 23 ; level
	length 1.6 ; length
	weight 0.1 ; weight
	tx DarkHaunterDescription ; description
	db NONE | HAS_EVOLUTION ; AI info

GengarLv38Card:
	db TYPE_PKMN_PSYCHIC ; type
	dw $4675 ; gfx
	tx GengarName ; name
	db STAR ; rarity
	db FOSSIL ; real set
	db ISLAND_OF_FOSSIL ; in-game set
	dw GENGAR_LV38
	db 80 ; hp
	db STAGE2 ; stage
	tx HaunterName ; pre-evo name

	; attack 1
	energy 0 ; energies
	tx Text176f ; name
	tx Text1770 ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db POKEMON_POWER ; category
	dw EffectCommands_58455 ; effect commands
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
	dw EffectCommands_58460 ; effect commands
	db DAMAGE_TO_OPPONENT_BENCH  ; flags 1
	db NONE ; flags 2
	db FLAG_3_BIT_2  ; flags 3
	db 10 ; ?
	db ATK_ANIM_DARK_MIND ; animation

	db 1 ; retreat cost
	db NONE ; weakness
	db WR_FIGHTING ; resistance
	tx Text1772 ; category
	db DEX_GENGAR ; Pokedex number
	db FALSE ; is Dark
	db 38 ; level
	length 1.5 ; length
	weight 40.5 ; weight
	tx GengarDescription1 ; description
	db AI_INFO_BENCH_UTILITY ; AI info

GengarLv40Card:
	db TYPE_PKMN_PSYCHIC ; type
	dw $96c8 ; gfx
	tx GengarName ; name
	db STAR ; rarity
	db EXPANSION_SHEET ; real set
	db PROMOTIONAL ; in-game set
	dw GENGAR_LV40
	db 80 ; hp
	db STAGE2 ; stage
	tx HaunterName ; pre-evo name

	; attack 1
	energy 0 ; energies
	tx Text1774 ; name
	tx Text1775 ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db POKEMON_POWER ; category
	dw EffectCommands_59091 ; effect commands
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
	dw EffectCommands_5909c ; effect commands
	db INFLICT_SLEEP | INFLICT_CONFUSION  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_NIGHTMARE ; animation

	db 2 ; retreat cost
	db NONE ; weakness
	db WR_FIGHTING ; resistance
	tx Text1772 ; category
	db DEX_GENGAR ; Pokedex number
	db FALSE ; is Dark
	db 40 ; level
	length 1.5 ; length
	weight 40.5 ; weight
	tx GengarDescription2 ; description
	db NONE ; AI info

DarkGengarCard:
	db TYPE_PKMN_PSYCHIC ; type
	dw $ca31 ; gfx
	tx DarkGengarName ; name
	db STAR ; rarity
	db GB ; real set
	db TEAM_ROCKETS_AMBITION ; in-game set
	dw DARK_GENGAR
	db 70 ; hp
	db STAGE2 ; stage
	tx DarkHaunterName ; pre-evo name

	; attack 1
	energy 0 ; energies
	tx Text1779 ; name
	tx Text177a ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db POKEMON_POWER ; category
	dw EffectCommands_592e8 ; effect commands
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
	dw EffectCommands_592f0 ; effect commands
	db NONE ; flags 1
	db FLAG_2_BIT_6  ; flags 2
	db FLAG_3_BIT_2  ; flags 3
	db 1 ; ?
	db ATK_ANIM_253 ; animation

	db 2 ; retreat cost
	db NONE ; weakness
	db WR_FIGHTING ; resistance
	tx Text1772 ; category
	db DEX_GENGAR ; Pokedex number
	db TRUE ; is Dark
	db 33 ; level
	length 1.5 ; length
	weight 40.5 ; weight
	tx DarkGengarDescription ; description
	db NONE ; AI info

DrowzeeLv10Card:
	db TYPE_PKMN_PSYCHIC ; type
	dw $66d2 ; gfx
	tx DrowzeeName ; name
	db CIRCLE ; rarity
	db TEAM_ROCKET ; real set
	db TEAM_ROCKETS_AMBITION ; in-game set
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
	dw EffectCommands_58a8e ; effect commands
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
	dw EffectCommands_58a96 ; effect commands
	db INFLICT_SLEEP  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_NIGHTMARE ; animation

	db 1 ; retreat cost
	db WR_PSYCHIC ; weakness
	db NONE ; resistance
	tx Text1781 ; category
	db DEX_DROWZEE ; Pokedex number
	db FALSE ; is Dark
	db 10 ; level
	length 1.0 ; length
	weight 32.4 ; weight
	tx DrowzeeDescription1 ; description
	db NONE | HAS_EVOLUTION ; AI info

DrowzeeLv12Card:
	db TYPE_PKMN_PSYCHIC ; type
	dw $46e6 ; gfx
	tx DrowzeeName ; name
	db CIRCLE ; rarity
	db BASE_SET ; real set
	db BEGINNING_POKEMON ; in-game set
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
	dw EffectCommands_584c1 ; effect commands
	db INFLICT_CONFUSION  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_CONFUSE_RAY ; animation

	db 1 ; retreat cost
	db WR_PSYCHIC ; weakness
	db NONE ; resistance
	tx Text1781 ; category
	db DEX_DROWZEE ; Pokedex number
	db FALSE ; is Dark
	db 12 ; level
	length 1.0 ; length
	weight 32.4 ; weight
	tx DrowzeeDescription2 ; description
	db AI_INFO_UNK_03 | HAS_EVOLUTION ; AI info

HypnoLv30Card:
	db TYPE_PKMN_PSYCHIC ; type
	dw $9731 ; gfx
	tx HypnoName ; name
	db DIAMOND ; rarity
	db EXPANSION_SHEET ; real set
	db ISLAND_OF_FOSSIL ; in-game set
	dw HYPNO_LV30
	db 60 ; hp
	db STAGE1 ; stage
	tx DrowzeeName ; pre-evo name

	; attack 1
	energy 0 ; energies
	tx Text1785 ; name
	tx Text1786 ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db POKEMON_POWER ; category
	dw EffectCommands_590a1 ; effect commands
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
	dw EffectCommands_590a6 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_PSYCHIC_HIT ; animation

	db 1 ; retreat cost
	db WR_PSYCHIC ; weakness
	db NONE ; resistance
	tx Text1781 ; category
	db DEX_HYPNO ; Pokedex number
	db FALSE ; is Dark
	db 30 ; level
	length 1.6 ; length
	weight 75.6 ; weight
	tx HypnoDescription1 ; description
	db NONE ; AI info

HypnoLv36Card:
	db TYPE_PKMN_PSYCHIC ; type
	dw $474f ; gfx
	tx HypnoName ; name
	db STAR ; rarity
	db FOSSIL ; real set
	db BEGINNING_POKEMON ; in-game set
	dw HYPNO_LV36
	db 90 ; hp
	db STAGE1 ; stage
	tx DrowzeeName ; pre-evo name

	; attack 1
	energy PSYCHIC, 1 ; energies
	tx Text1788 ; name
	tx Text1789 ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db RESIDUAL ; category
	dw EffectCommands_584a8 ; effect commands
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
	dw EffectCommands_584b6 ; effect commands
	db DAMAGE_TO_OPPONENT_BENCH  ; flags 1
	db NONE ; flags 2
	db FLAG_3_BIT_2  ; flags 3
	db 10 ; ?
	db ATK_ANIM_DARK_MIND ; animation

	db 2 ; retreat cost
	db WR_PSYCHIC ; weakness
	db NONE ; resistance
	tx Text1781 ; category
	db DEX_HYPNO ; Pokedex number
	db FALSE ; is Dark
	db 36 ; level
	length 1.6 ; length
	weight 75.6 ; weight
	tx HypnoDescription2 ; description
	db NONE ; AI info

DarkHypnoCard:
	db TYPE_PKMN_PSYCHIC ; type
	dw $675b ; gfx
	tx DarkHypnoName ; name
	db STAR ; rarity
	db TEAM_ROCKET ; real set
	db TEAM_ROCKETS_AMBITION ; in-game set
	dw DARK_HYPNO
	db 60 ; hp
	db STAGE1 ; stage
	tx DrowzeeName ; pre-evo name

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
	dw EffectCommands_58a9b ; effect commands
	db NONE ; flags 1
	db FLAG_2_BIT_6  ; flags 2
	db NONE ; flags 3
	db 1 ; ?
	db ATK_ANIM_165 ; animation

	db 2 ; retreat cost
	db WR_PSYCHIC ; weakness
	db NONE ; resistance
	tx Text1781 ; category
	db DEX_HYPNO ; Pokedex number
	db TRUE ; is Dark
	db 26 ; level
	length 1.6 ; length
	weight 75.6 ; weight
	tx DarkHypnoDescription ; description
	db NONE ; AI info

MrMimeLv20Card:
	db TYPE_PKMN_PSYCHIC ; type
	dw $7e58 ; gfx
	tx MrMimeName ; name
	db STAR ; rarity
	db EXPANSION_SHEET ; real set
	db WE_ARE_TEAM_ROCKET ; in-game set
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
	dw EffectCommands_58d30 ; effect commands
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
	dw EffectCommands_58d35 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_HIT ; animation

	db 1 ; retreat cost
	db WR_PSYCHIC ; weakness
	db NONE ; resistance
	tx Text1795 ; category
	db DEX_MR__MIME ; Pokedex number
	db FALSE ; is Dark
	db 20 ; level
	length 1.3 ; length
	weight 54.5 ; weight
	tx MrMimeDescription1 ; description
	db NONE ; AI info

MrMimeLv28Card:
	db TYPE_PKMN_PSYCHIC ; type
	dw $4800 ; gfx
	tx MrMimeName ; name
	db STAR ; rarity
	db JUNGLE ; real set
	db PSYCHIC_BATTLE ; in-game set
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
	dw EffectCommands_584c6 ; effect commands
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
	dw EffectCommands_584cb ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_PSYCHIC_HIT ; animation

	db 1 ; retreat cost
	db WR_PSYCHIC ; weakness
	db NONE ; resistance
	tx Text1795 ; category
	db DEX_MR__MIME ; Pokedex number
	db FALSE ; is Dark
	db 28 ; level
	length 1.3 ; length
	weight 54.5 ; weight
	tx MrMimeDescription2 ; description
	db AI_INFO_UNK_03 ; AI info

JynxLv18Card:
	db TYPE_PKMN_PSYCHIC ; type
	dw $89a4 ; gfx
	tx JynxName ; name
	db STAR ; rarity
	db EXPANSION_SHEET ; real set
	db WE_ARE_TEAM_ROCKET ; in-game set
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
	dw EffectCommands_58ec6 ; effect commands
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
	dw EffectCommands_58ecb ; effect commands
	db INFLICT_SLEEP  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_222 ; animation

	db 1 ; retreat cost
	db WR_PSYCHIC ; weakness
	db NONE ; resistance
	tx Text179f ; category
	db DEX_JYNX ; Pokedex number
	db FALSE ; is Dark
	db 18 ; level
	length 1.4 ; length
	weight 40.6 ; weight
	tx JynxDescription1 ; description
	db NONE ; AI info

JynxLv23Card:
	db TYPE_PKMN_PSYCHIC ; type
	dw $4869 ; gfx
	tx JynxName ; name
	db DIAMOND ; rarity
	db BASE_SET ; real set
	db ISLAND_OF_FOSSIL ; in-game set
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
	dw EffectCommands_58589 ; effect commands
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
	dw EffectCommands_58591 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_PSYCHIC_HIT ; animation

	db 2 ; retreat cost
	db WR_PSYCHIC ; weakness
	db NONE ; resistance
	tx Text179f ; category
	db DEX_JYNX ; Pokedex number
	db FALSE ; is Dark
	db 23 ; level
	length 1.4 ; length
	weight 40.6 ; weight
	tx JynxDescription2 ; description
	db NONE ; AI info

JynxLv27Card:
	db TYPE_PKMN_PSYCHIC ; type
	dw $c13b ; gfx
	tx JynxName ; name
	db DIAMOND ; rarity
	db BULBASAUR_DECK ; real set
	db BEGINNING_POKEMON ; in-game set
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
	dw EffectCommands_5928b ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_203 ; animation

	db 2 ; retreat cost
	db WR_PSYCHIC ; weakness
	db NONE ; resistance
	tx Text179f ; category
	db DEX_JYNX ; Pokedex number
	db FALSE ; is Dark
	db 27 ; level
	length 1.4 ; length
	weight 40.6 ; weight
	tx JynxDescription3 ; description
	db NONE ; AI info

MewtwoLv30Card:
	db TYPE_PKMN_PSYCHIC ; type
	dw $a069 ; gfx
	tx MewtwoName ; name
	db STAR ; rarity
	db PRO ; real set
	db PROMOTIONAL ; in-game set
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
	dw EffectCommands_591c7 ; effect commands
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
	dw EffectCommands_591d5 ; effect commands
	db DAMAGE_TO_OPPONENT_BENCH  ; flags 1
	db FLAG_2_BIT_6  ; flags 2
	db FLAG_3_BIT_2  ; flags 3
	db 2 ; ?
	db ATK_ANIM_PSYCHIC_HIT ; animation

	db 2 ; retreat cost
	db WR_PSYCHIC ; weakness
	db NONE ; resistance
	tx Text17a7 ; category
	db DEX_MEWTWO ; Pokedex number
	db FALSE ; is Dark
	db 30 ; level
	length 2.0 ; length
	weight 122.0 ; weight
	tx MewtwoDescription1 ; description
	db NONE ; AI info

MewtwoLv53Card:
	db TYPE_PKMN_PSYCHIC ; type
	dw $48d2 ; gfx
	tx MewtwoName ; name
	db STAR ; rarity
	db BASE_SET ; real set
	db WE_ARE_TEAM_ROCKET ; in-game set
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
	dw EffectCommands_58506 ; effect commands
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
	dw EffectCommands_5850e ; effect commands
	db NONE ; flags 1
	db NULLIFY_OR_WEAKEN_ATTACK | DISCARD_ENERGY  ; flags 2
	db FLAG_3_BIT_2  ; flags 3
	db 2 ; ?
	db ATK_ANIM_BARRIER ; animation

	db 3 ; retreat cost
	db WR_PSYCHIC ; weakness
	db NONE ; resistance
	tx Text17a7 ; category
	db DEX_MEWTWO ; Pokedex number
	db FALSE ; is Dark
	db 53 ; level
	length 2.0 ; length
	weight 122.0 ; weight
	tx MewtwoDescription2 ; description
	db NONE ; AI info

MewtwoLv54Card:
	db TYPE_PKMN_PSYCHIC ; type
	dw $8124 ; gfx
	tx MewtwoName ; name
	db STAR ; rarity
	db EXPANSION_SHEET ; real set
	db LEGENDARY_POWER ; in-game set
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
	dw EffectCommands_58d6d ; effect commands
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
	db DEX_MEWTWO ; Pokedex number
	db FALSE ; is Dark
	db 54 ; level
	length 2.0 ; length
	weight 122.0 ; weight
	tx MewtwoDescription3 ; description
	db NONE ; AI info

MewtwoLv60Card:
	db TYPE_PKMN_PSYCHIC ; type
	dw $493b ; gfx
	tx MewtwoName ; name
	db PROMOSTAR ; rarity
	db PRO ; real set
	db PROMOTIONAL ; in-game set
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
	dw EffectCommands_5852d ; effect commands
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
	db DEX_MEWTWO ; Pokedex number
	db FALSE ; is Dark
	db 60 ; level
	length 2.0 ; length
	weight 122.0 ; weight
	tx MewtwoDescription4 ; description
	db NONE ; AI info

MewtwoAltLv60Card:
	db TYPE_PKMN_PSYCHIC ; type
	dw $49a4 ; gfx
	tx MewtwoName ; name
	db PROMOSTAR ; rarity
	db PRO ; real set
	db PROMOTIONAL ; in-game set
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
	dw EffectCommands_5851f ; effect commands
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
	db DEX_MEWTWO ; Pokedex number
	db FALSE ; is Dark
	db 60 ; level
	length 2.0 ; length
	weight 122.0 ; weight
	tx MewtwoDescription4 ; description
	db NONE ; AI info

MewtwoLv67Card:
	db TYPE_PKMN_PSYCHIC ; type
	dw $9e27 ; gfx
	tx MewtwoName ; name
	db STAR ; rarity
	db EXPANSION_SHEET ; real set
	db PSYCHIC_BATTLE ; in-game set
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
	dw EffectCommands_59161 ; effect commands
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
	dw EffectCommands_59169 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_PSYCHIC_HIT ; animation

	db 3 ; retreat cost
	db WR_PSYCHIC ; weakness
	db NONE ; resistance
	tx Text17a7 ; category
	db DEX_MEWTWO ; Pokedex number
	db FALSE ; is Dark
	db 67 ; level
	length 2.0 ; length
	weight 122.0 ; weight
	tx MewtwoDescription5 ; description
	db NONE ; AI info

GRsMewtwoCard:
	db TYPE_PKMN_PSYCHIC ; type
	dw $c56e ; gfx
	tx GRsMewtwoName ; name
	db STAR ; rarity
	db GB ; real set
	db PROMOTIONAL ; in-game set
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
	dw EffectCommands_5932c ; effect commands
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
	dw EffectCommands_59331 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_PSYCHIC_HIT ; animation

	db 2 ; retreat cost
	db WR_PSYCHIC ; weakness
	db NONE ; resistance
	tx Text17a7 ; category
	db DEX_MEWTWO ; Pokedex number
	db FALSE ; is Dark
	db 35 ; level
	length 2.0 ; length
	weight 122.0 ; weight
	tx GRsMewtwoDescription ; description
	db NONE ; AI info

MewLv8Card:
	db TYPE_PKMN_PSYCHIC ; type
	dw $4a23 ; gfx
	tx MewName ; name
	db PROMOSTAR ; rarity
	db PRO ; real set
	db PROMOTIONAL ; in-game set
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
	dw EffectCommands_584fc ; effect commands
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
	dw EffectCommands_58501 ; effect commands
	db INFLICT_PARALYSIS  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_PSYCHIC_HIT ; animation

	db 1 ; retreat cost
	db WR_PSYCHIC ; weakness
	db NONE ; resistance
	tx Text17c0 ; category
	db DEX_MEW ; Pokedex number
	db FALSE ; is Dark
	db 8 ; level
	length 0.4 ; length
	weight 4.0 ; weight
	tx MewDescription1 ; description
	db AI_INFO_UNK_03 ; AI info

MewLv15Card:
	db TYPE_PKMN_PSYCHIC ; type
	dw $4a8c ; gfx
	tx MewName ; name
	db STAR ; rarity
	db GB ; real set
	db PROMOTIONAL ; in-game set
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
	dw EffectCommands_58599 ; effect commands
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
	db DEX_MEW ; Pokedex number
	db FALSE ; is Dark
	db 15 ; level
	length 0.4 ; length
	weight 4.0 ; weight
	tx MewDescription2 ; description
	db NONE ; AI info

MewLv23Card:
	db TYPE_PKMN_PSYCHIC ; type
	dw $4af5 ; gfx
	tx MewName ; name
	db STAR ; rarity
	db FOSSIL ; real set
	db PSYCHIC_BATTLE ; in-game set
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
	dw EffectCommands_584e3 ; effect commands
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
	dw EffectCommands_584eb ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db SPECIAL_AI_HANDLING | FLAG_3_BIT_2  ; flags 3
	db 0 ; ?
	db ATK_ANIM_NONE ; animation

	db 1 ; retreat cost
	db WR_PSYCHIC ; weakness
	db NONE ; resistance
	tx Text17c0 ; category
	db DEX_MEW ; Pokedex number
	db FALSE ; is Dark
	db 23 ; level
	length 0.4 ; length
	weight 4.0 ; weight
	tx MewDescription3 ; description
	db AI_INFO_UNK_08 ; AI info

PidgeyLv8Card:
	db TYPE_PKMN_COLORLESS ; type
	dw $4b5e ; gfx
	tx PidgeyName ; name
	db CIRCLE ; rarity
	db BASE_SET ; real set
	db PSYCHIC_BATTLE ; in-game set
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
	dw EffectCommands_5885d ; effect commands
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
	db DEX_PIDGEY ; Pokedex number
	db FALSE ; is Dark
	db 8 ; level
	length 0.3 ; length
	weight 1.8 ; weight
	tx PidgeyDescription1 ; description
	db AI_INFO_ENCOURAGE_EVO | HAS_EVOLUTION ; AI info

PidgeyLv10Card:
	db TYPE_PKMN_COLORLESS ; type
	dw $743f ; gfx
	tx PidgeyName ; name
	db CIRCLE ; rarity
	db EXPANSION_SHEET ; real set
	db SKY_FLYING_POKEMON ; in-game set
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
	dw EffectCommands_58c42 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_QUICK_ATTACK ; animation

	db 1 ; retreat cost
	db WR_LIGHTNING ; weakness
	db WR_FIGHTING ; resistance
	tx Text17cb ; category
	db DEX_PIDGEY ; Pokedex number
	db FALSE ; is Dark
	db 10 ; level
	length 0.3 ; length
	weight 1.8 ; weight
	tx PidgeyDescription2 ; description
	db NONE | HAS_EVOLUTION ; AI info

PidgeottoLv36Card:
	db TYPE_PKMN_COLORLESS ; type
	dw $4bc7 ; gfx
	tx PidgeottoName ; name
	db DIAMOND ; rarity
	db BASE_SET ; real set
	db SKY_FLYING_POKEMON ; in-game set
	dw PIDGEOTTO_LV36
	db 60 ; hp
	db STAGE1 ; stage
	tx PidgeyName ; pre-evo name

	; attack 1
	energy COLORLESS, 2 ; energies
	tx Text133e ; name
	tx Text133f ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_NORMAL ; category
	dw EffectCommands_587fa ; effect commands
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
	dw EffectCommands_58805 ; effect commands
	db NONE ; flags 1
	db FLAG_2_BIT_6  ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_MIRROR_MOVE ; animation

	db 1 ; retreat cost
	db WR_LIGHTNING ; weakness
	db WR_FIGHTING ; resistance
	tx Text17d2 ; category
	db DEX_PIDGEOTTO ; Pokedex number
	db FALSE ; is Dark
	db 36 ; level
	length 1.1 ; length
	weight 30.0 ; weight
	tx PidgeottoDescription1 ; description
	db NONE | HAS_EVOLUTION ; AI info

PidgeottoLv38Card:
	db TYPE_PKMN_COLORLESS ; type
	dw $8d46 ; gfx
	tx PidgeottoName ; name
	db DIAMOND ; rarity
	db EXPANSION_SHEET ; real set
	db PSYCHIC_BATTLE ; in-game set
	dw PIDGEOTTO_LV38
	db 60 ; hp
	db STAGE1 ; stage
	tx PidgeyName ; pre-evo name

	; attack 1
	energy COLORLESS, 2 ; energies
	tx Text17d4 ; name
	tx Text17d5 ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_NORMAL ; category
	dw EffectCommands_58f34 ; effect commands
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
	dw EffectCommands_58f39 ; effect commands
	db NONE ; flags 1
	db NULLIFY_OR_WEAKEN_ATTACK  ; flags 2
	db FLAG_3_BIT_2  ; flags 3
	db 0 ; ?
	db ATK_ANIM_AGILITY_PROTECT ; animation

	db 0 ; retreat cost
	db WR_LIGHTNING ; weakness
	db WR_FIGHTING ; resistance
	tx Text17d2 ; category
	db DEX_PIDGEOTTO ; Pokedex number
	db FALSE ; is Dark
	db 38 ; level
	length 1.1 ; length
	weight 30.0 ; weight
	tx PidgeottoDescription2 ; description
	db NONE | HAS_EVOLUTION ; AI info

PidgeotLv38Card:
	db TYPE_PKMN_COLORLESS ; type
	dw $4c30 ; gfx
	tx PidgeotName ; name
	db STAR ; rarity
	db GB ; real set
	db PSYCHIC_BATTLE ; in-game set
	dw PIDGEOT_LV38
	db 80 ; hp
	db STAGE2 ; stage
	tx PidgeottoName ; pre-evo name

	; attack 1
	energy COLORLESS, 3 ; energies
	tx Text17d9 ; name
	tx Text17da ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db RESIDUAL ; category
	dw EffectCommands_588be ; effect commands
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
	dw EffectCommands_588c3 ; effect commands
	db NONE ; flags 1
	db SWITCH_OPPONENT_POKEMON  ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_GLOW_EFFECT ; animation

	db 1 ; retreat cost
	db WR_LIGHTNING ; weakness
	db WR_FIGHTING ; resistance
	tx Text17d2 ; category
	db DEX_PIDGEOT ; Pokedex number
	db FALSE ; is Dark
	db 38 ; level
	length 1.5 ; length
	weight 39.5 ; weight
	tx PidgeotDescription1 ; description
	db NONE ; AI info

PidgeotLv40Card:
	db TYPE_PKMN_COLORLESS ; type
	dw $4c99 ; gfx
	tx PidgeotName ; name
	db STAR ; rarity
	db JUNGLE ; real set
	db SKY_FLYING_POKEMON ; in-game set
	dw PIDGEOT_LV40
	db 80 ; hp
	db STAGE2 ; stage
	tx PidgeottoName ; pre-evo name

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
	dw EffectCommands_587f5 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_WHIRLWIND ; animation

	db 0 ; retreat cost
	db WR_LIGHTNING ; weakness
	db WR_FIGHTING ; resistance
	tx Text17d2 ; category
	db DEX_PIDGEOT ; Pokedex number
	db FALSE ; is Dark
	db 40 ; level
	length 1.5 ; length
	weight 39.5 ; weight
	tx PidgeotDescription2 ; description
	db NONE ; AI info

RattataLv9Card:
	db TYPE_PKMN_COLORLESS ; type
	dw $4d02 ; gfx
	tx RattataName ; name
	db CIRCLE ; rarity
	db BASE_SET ; real set
	db BEGINNING_POKEMON ; in-game set
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
	db DEX_RATTATA ; Pokedex number
	db FALSE ; is Dark
	db 9 ; level
	length 0.3 ; length
	weight 3.5 ; weight
	tx RattataDescription1 ; description
	db AI_INFO_UNK_03 | HAS_EVOLUTION ; AI info

RattataLv12Card:
	db TYPE_PKMN_COLORLESS ; type
	dw $6b2f ; gfx
	tx RattataName ; name
	db CIRCLE ; rarity
	db TEAM_ROCKET ; real set
	db WE_ARE_TEAM_ROCKET ; in-game set
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
	dw EffectCommands_58b02 ; effect commands
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
	dw EffectCommands_58b0a ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_QUICK_ATTACK ; animation

	db 0 ; retreat cost
	db WR_FIGHTING ; weakness
	db WR_PSYCHIC ; resistance
	tx Text15c9 ; category
	db DEX_RATTATA ; Pokedex number
	db FALSE ; is Dark
	db 12 ; level
	length 0.3 ; length
	weight 3.5 ; weight
	tx RattataDescription2 ; description
	db NONE | HAS_EVOLUTION ; AI info

RattataLv15Card:
	db TYPE_PKMN_COLORLESS ; type
	dw $74c2 ; gfx
	tx RattataName ; name
	db CIRCLE ; rarity
	db EXPANSION_SHEET ; real set
	db SKY_FLYING_POKEMON ; in-game set
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
	dw EffectCommands_58c4a ; effect commands
	db NONE ; flags 1
	db NULLIFY_OR_WEAKEN_ATTACK  ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_201 ; animation

	db 1 ; retreat cost
	db WR_FIGHTING ; weakness
	db WR_PSYCHIC ; resistance
	tx Text15c9 ; category
	db DEX_RATTATA ; Pokedex number
	db FALSE ; is Dark
	db 15 ; level
	length 0.3 ; length
	weight 3.5 ; weight
	tx RattataDescription3 ; description
	db NONE | HAS_EVOLUTION ; AI info

RaticateCard:
	db TYPE_PKMN_COLORLESS ; type
	dw $4d6d ; gfx
	tx RaticateName ; name
	db DIAMOND ; rarity
	db BASE_SET ; real set
	db BEGINNING_POKEMON ; in-game set
	dw RATICATE
	db 60 ; hp
	db STAGE1 ; stage
	tx RattataName ; pre-evo name

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
	dw EffectCommands_5888e ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_HIT ; animation

	db 1 ; retreat cost
	db WR_FIGHTING ; weakness
	db WR_PSYCHIC ; resistance
	tx Text15c9 ; category
	db DEX_RATICATE ; Pokedex number
	db FALSE ; is Dark
	db 41 ; level
	length 0.7 ; length
	weight 18.5 ; weight
	tx RaticateDescription ; description
	db AI_INFO_UNK_03 ; AI info

DarkRaticateCard:
	db TYPE_PKMN_COLORLESS ; type
	dw $6b98 ; gfx
	tx DarkRaticateName ; name
	db CIRCLE ; rarity
	db TEAM_ROCKET ; real set
	db WE_ARE_TEAM_ROCKET ; in-game set
	dw DARK_RATICATE
	db 50 ; hp
	db STAGE1 ; stage
	tx RattataName ; pre-evo name

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
	dw EffectCommands_58b12 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_HIT ; animation

	db 1 ; retreat cost
	db WR_FIGHTING ; weakness
	db WR_PSYCHIC ; resistance
	tx Text15c9 ; category
	db DEX_RATICATE ; Pokedex number
	db TRUE ; is Dark
	db 25 ; level
	length 0.7 ; length
	weight 18.5 ; weight
	tx DarkRaticateDescription ; description
	db NONE ; AI info

SpearowLv9Card:
	db TYPE_PKMN_COLORLESS ; type
	dw $c2eb ; gfx
	tx SpearowName ; name
	db CIRCLE ; rarity
	db SQUIRTLE_DECK ; real set
	db LEGENDARY_POWER ; in-game set
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
	db DEX_SPEAROW ; Pokedex number
	db FALSE ; is Dark
	db 9 ; level
	length 0.3 ; length
	weight 2.0 ; weight
	tx SpearowDescription1 ; description
	db NONE | HAS_EVOLUTION ; AI info

SpearowLv12Card:
	db TYPE_PKMN_COLORLESS ; type
	dw $818f ; gfx
	tx SpearowName ; name
	db CIRCLE ; rarity
	db EXPANSION_SHEET ; real set
	db PSYCHIC_BATTLE ; in-game set
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
	dw EffectCommands_58dcd ; effect commands
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
	db DEX_SPEAROW ; Pokedex number
	db FALSE ; is Dark
	db 12 ; level
	length 0.3 ; length
	weight 2.0 ; weight
	tx SpearowDescription2 ; description
	db NONE | HAS_EVOLUTION ; AI info

SpearowLv13Card:
	db TYPE_PKMN_COLORLESS ; type
	dw $4dd6 ; gfx
	tx SpearowName ; name
	db CIRCLE ; rarity
	db JUNGLE ; real set
	db SKY_FLYING_POKEMON ; in-game set
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
	dw EffectCommands_58751 ; effect commands
	db NONE ; flags 1
	db FLAG_2_BIT_6  ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_MIRROR_MOVE ; animation

	db 0 ; retreat cost
	db WR_LIGHTNING ; weakness
	db WR_FIGHTING ; resistance
	tx Text17cb ; category
	db DEX_SPEAROW ; Pokedex number
	db FALSE ; is Dark
	db 13 ; level
	length 0.3 ; length
	weight 2.0 ; weight
	tx SpearowDescription3 ; description
	db AI_INFO_UNK_03 | HAS_EVOLUTION ; AI info

FearowLv24Card:
	db TYPE_PKMN_COLORLESS ; type
	dw $81f8 ; gfx
	tx FearowName ; name
	db DIAMOND ; rarity
	db EXPANSION_SHEET ; real set
	db SKY_FLYING_POKEMON ; in-game set
	dw FEAROW_LV24
	db 60 ; hp
	db STAGE1 ; stage
	tx SpearowName ; pre-evo name

	; attack 1
	energy COLORLESS, 2 ; energies
	tx Text1490 ; name
	tx Text15e2 ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_PLUS ; category
	dw EffectCommands_58dd5 ; effect commands
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
	dw EffectCommands_58ddd ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_DRILL ; animation

	db 0 ; retreat cost
	db WR_LIGHTNING ; weakness
	db WR_FIGHTING ; resistance
	tx Text17f5 ; category
	db DEX_FEAROW ; Pokedex number
	db FALSE ; is Dark
	db 24 ; level
	length 1.2 ; length
	weight 38.0 ; weight
	tx FearowDescription1 ; description
	db NONE ; AI info

FearowLv27Card:
	db TYPE_PKMN_COLORLESS ; type
	dw $4e87 ; gfx
	tx FearowName ; name
	db DIAMOND ; rarity
	db JUNGLE ; real set
	db PSYCHIC_BATTLE ; in-game set
	dw FEAROW_LV27
	db 70 ; hp
	db STAGE1 ; stage
	tx SpearowName ; pre-evo name

	; attack 1
	energy COLORLESS, 3 ; energies
	tx Text14ab ; name
	tx Text14ac ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_NORMAL ; category
	dw EffectCommands_5876b ; effect commands
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
	db DEX_FEAROW ; Pokedex number
	db FALSE ; is Dark
	db 27 ; level
	length 1.2 ; length
	weight 38.0 ; weight
	tx FearowDescription2 ; description
	db NONE ; AI info

DarkFearowCard:
	db TYPE_PKMN_COLORLESS ; type
	dw $c93b ; gfx
	tx DarkFearowName ; name
	db DIAMOND ; rarity
	db GB ; real set
	db TEAM_ROCKETS_AMBITION ; in-game set
	dw DARK_FEAROW
	db 60 ; hp
	db STAGE1 ; stage
	tx SpearowName ; pre-evo name

	; attack 1
	energy COLORLESS, 1 ; energies
	tx Text17fa ; name
	tx Text17fb ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db RESIDUAL ; category
	dw EffectCommands_59308 ; effect commands
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
	dw EffectCommands_5930d ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_246 ; animation

	db 0 ; retreat cost
	db WR_LIGHTNING ; weakness
	db WR_FIGHTING ; resistance
	tx Text17f5 ; category
	db DEX_FEAROW ; Pokedex number
	db TRUE ; is Dark
	db 25 ; level
	length 1.2 ; length
	weight 38.0 ; weight
	tx DarkFearowDescription ; description
	db NONE ; AI info

ClefairyLv14Card:
	db TYPE_PKMN_COLORLESS ; type
	dw $4f10 ; gfx
	tx ClefairyName ; name
	db STAR ; rarity
	db BASE_SET ; real set
	db PSYCHIC_BATTLE ; in-game set
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
	dw EffectCommands_5881f ; effect commands
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
	dw EffectCommands_58824 ; effect commands
	db NONE ; flags 1
	db FLAG_2_BIT_5  ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_NONE ; animation

	db 1 ; retreat cost
	db WR_FIGHTING ; weakness
	db WR_PSYCHIC ; resistance
	tx Text1802 ; category
	db DEX_CLEFAIRY ; Pokedex number
	db FALSE ; is Dark
	db 14 ; level
	length 0.6 ; length
	weight 7.5 ; weight
	tx ClefairyDescription1 ; description
	db AI_INFO_ENCOURAGE_EVO | HAS_EVOLUTION ; AI info

ClefairyLv15Card:
	db TYPE_PKMN_COLORLESS ; type
	dw $76de ; gfx
	tx ClefairyName ; name
	db DIAMOND ; rarity
	db EXPANSION_SHEET ; real set
	db LEGENDARY_POWER ; in-game set
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
	dw EffectCommands_58c73 ; effect commands
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
	dw EffectCommands_58c81 ; effect commands
	db INFLICT_SLEEP  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_213 ; animation

	db 1 ; retreat cost
	db WR_FIGHTING ; weakness
	db WR_PSYCHIC ; resistance
	tx Text1802 ; category
	db DEX_CLEFAIRY ; Pokedex number
	db FALSE ; is Dark
	db 15 ; level
	length 0.6 ; length
	weight 7.5 ; weight
	tx ClefairyDescription2 ; description
	db NONE | HAS_EVOLUTION ; AI info

ClefableCard:
	db TYPE_PKMN_COLORLESS ; type
	dw $4f79 ; gfx
	tx ClefableName ; name
	db STAR ; rarity
	db JUNGLE ; real set
	db ISLAND_OF_FOSSIL ; in-game set
	dw CLEFABLE
	db 70 ; hp
	db STAGE1 ; stage
	tx ClefairyName ; pre-evo name

	; attack 1
	energy COLORLESS, 1 ; energies
	tx Text1800 ; name
	tx Text1801 ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db RESIDUAL ; category
	dw EffectCommands_587e5 ; effect commands
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
	dw EffectCommands_587f0 ; effect commands
	db NONE ; flags 1
	db NULLIFY_OR_WEAKEN_ATTACK  ; flags 2
	db FLAG_3_BIT_2  ; flags 3
	db 20 ; ?
	db ATK_ANIM_PROTECT ; animation

	db 2 ; retreat cost
	db WR_FIGHTING ; weakness
	db WR_PSYCHIC ; resistance
	tx Text1802 ; category
	db DEX_CLEFABLE ; Pokedex number
	db FALSE ; is Dark
	db 34 ; level
	length 1.3 ; length
	weight 40.0 ; weight
	tx ClefableDescription ; description
	db NONE ; AI info

DarkClefableCard:
	db TYPE_PKMN_COLORLESS ; type
	dw $c724 ; gfx
	tx DarkClefableName ; name
	db STAR ; rarity
	db GB ; real set
	db TEAM_ROCKETS_AMBITION ; in-game set
	dw DARK_CLEFABLE
	db 70 ; hp
	db STAGE1 ; stage
	tx ClefairyName ; pre-evo name

	; attack 1
	energy 0 ; energies
	tx Text180b ; name
	tx Text180c ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db POKEMON_POWER ; category
	dw EffectCommands_592d3 ; effect commands
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
	dw EffectCommands_592d8 ; effect commands
	db INFLICT_SLEEP  ; flags 1
	db NONE ; flags 2
	db FLAG_3_BIT_2  ; flags 3
	db 0 ; ?
	db ATK_ANIM_247 ; animation

	db 2 ; retreat cost
	db WR_FIGHTING ; weakness
	db WR_PSYCHIC ; resistance
	tx Text1802 ; category
	db DEX_CLEFABLE ; Pokedex number
	db TRUE ; is Dark
	db 33 ; level
	length 1.3 ; length
	weight 40.0 ; weight
	tx DarkClefableDescription ; description
	db NONE ; AI info

JigglypuffLv12Card:
	db TYPE_PKMN_COLORLESS ; type
	dw $5000 ; gfx
	tx JigglypuffName ; name
	db PROMOSTAR ; rarity
	db PRO ; real set
	db PROMOTIONAL ; in-game set
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
	dw EffectCommands_58841 ; effect commands
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
	dw EffectCommands_58849 ; effect commands
	db LOW_RECOIL  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 20 ; ?
	db ATK_ANIM_HIT_RECOIL ; animation

	db 1 ; retreat cost
	db WR_FIGHTING ; weakness
	db WR_PSYCHIC ; resistance
	tx Text1812 ; category
	db DEX_JIGGLYPUFF ; Pokedex number
	db FALSE ; is Dark
	db 12 ; level
	length 0.5 ; length
	weight 5.5 ; weight
	tx JigglypuffDescription1 ; description
	db NONE | HAS_EVOLUTION ; AI info

JigglypuffLv13Card:
	db TYPE_PKMN_COLORLESS ; type
	dw $5069 ; gfx
	tx JigglypuffName ; name
	db CIRCLE ; rarity
	db GB ; real set
	db PSYCHIC_BATTLE ; in-game set
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
	dw EffectCommands_588cb ; effect commands
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
	dw EffectCommands_588d3 ; effect commands
	db NONE ; flags 1
	db NULLIFY_OR_WEAKEN_ATTACK  ; flags 2
	db FLAG_3_BIT_2  ; flags 3
	db 10 ; ?
	db ATK_ANIM_EXPAND ; animation

	db 1 ; retreat cost
	db WR_FIGHTING ; weakness
	db WR_PSYCHIC ; resistance
	tx Text1812 ; category
	db DEX_JIGGLYPUFF ; Pokedex number
	db FALSE ; is Dark
	db 13 ; level
	length 0.5 ; length
	weight 5.5 ; weight
	tx JigglypuffDescription2 ; description
	db NONE | HAS_EVOLUTION ; AI info

JigglypuffLv14Card:
	db TYPE_PKMN_COLORLESS ; type
	dw $50d2 ; gfx
	tx JigglypuffName ; name
	db CIRCLE ; rarity
	db JUNGLE ; real set
	db LEGENDARY_POWER ; in-game set
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
	dw EffectCommands_5883c ; effect commands
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
	db DEX_JIGGLYPUFF ; Pokedex number
	db FALSE ; is Dark
	db 14 ; level
	length 0.5 ; length
	weight 5.5 ; weight
	tx JigglypuffDescription3 ; description
	db NONE | HAS_EVOLUTION ; AI info

WigglytuffLv36Card:
	db TYPE_PKMN_COLORLESS ; type
	dw $513b ; gfx
	tx WigglytuffName ; name
	db STAR ; rarity
	db JUNGLE ; real set
	db LEGENDARY_POWER ; in-game set
	dw WIGGLYTUFF_LV36
	db 80 ; hp
	db STAGE1 ; stage
	tx JigglypuffName ; pre-evo name

	; attack 1
	energy COLORLESS, 1 ; energies
	tx Text1819 ; name
	tx Text13b6 ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db DAMAGE_NORMAL ; category
	dw EffectCommands_5882f ; effect commands
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
	dw EffectCommands_58834 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_HIT ; animation

	db 2 ; retreat cost
	db WR_FIGHTING ; weakness
	db WR_PSYCHIC ; resistance
	tx Text1812 ; category
	db DEX_WIGGLYTUFF ; Pokedex number
	db FALSE ; is Dark
	db 36 ; level
	length 1.0 ; length
	weight 12.0 ; weight
	tx WigglytuffDescription1 ; description
	db NONE ; AI info

WigglytuffLv40Card:
	db TYPE_PKMN_COLORLESS ; type
	dw $7747 ; gfx
	tx WigglytuffName ; name
	db STAR ; rarity
	db EXPANSION_SHEET ; real set
	db SKY_FLYING_POKEMON ; in-game set
	dw WIGGLYTUFF_LV40
	db 90 ; hp
	db STAGE1 ; stage
	tx JigglypuffName ; pre-evo name

	; attack 1
	energy 0 ; energies
	tx Text181f ; name
	tx Text1820 ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db POKEMON_POWER ; category
	dw EffectCommands_58c86 ; effect commands
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
	dw EffectCommands_58c91 ; effect commands
	db NONE ; flags 1
	db NULLIFY_OR_WEAKEN_ATTACK  ; flags 2
	db FLAG_3_BIT_2  ; flags 3
	db 10 ; ?
	db ATK_ANIM_EXPAND ; animation

	db 3 ; retreat cost
	db WR_FIGHTING ; weakness
	db WR_PSYCHIC ; resistance
	tx Text1812 ; category
	db DEX_WIGGLYTUFF ; Pokedex number
	db FALSE ; is Dark
	db 40 ; level
	length 1.0 ; length
	weight 12.0 ; weight
	tx WigglytuffDescription2 ; description
	db NONE ; AI info

MeowthLv10Card:
	db TYPE_PKMN_COLORLESS ; type
	dw $6c11 ; gfx
	tx MeowthName ; name
	db CIRCLE ; rarity
	db TEAM_ROCKET ; real set
	db TEAM_ROCKETS_AMBITION ; in-game set
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
	dw EffectCommands_58b1a ; effect commands
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
	db DEX_MEOWTH ; Pokedex number
	db FALSE ; is Dark
	db 10 ; level
	length 0.4 ; length
	weight 4.2 ; weight
	tx MeowthDescription1 ; description
	db NONE | HAS_EVOLUTION ; AI info

MeowthLv13Card:
	db TYPE_PKMN_COLORLESS ; type
	dw $51a4 ; gfx
	tx MeowthName ; name
	db DIAMOND ; rarity
	db GB ; real set
	db WE_ARE_TEAM_ROCKET ; in-game set
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
	dw EffectCommands_588b1 ; effect commands
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
	db DEX_MEOWTH ; Pokedex number
	db FALSE ; is Dark
	db 13 ; level
	length 0.4 ; length
	weight 4.2 ; weight
	tx MeowthDescription2 ; description
	db NONE | HAS_EVOLUTION ; AI info

MeowthLv14Card:
	db TYPE_PKMN_COLORLESS ; type
	dw $9ef9 ; gfx
	tx MeowthName ; name
	db PROMOSTAR ; rarity
	db PRO ; real set
	db PROMOTIONAL ; in-game set
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
	dw EffectCommands_59190 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db SPECIAL_AI_HANDLING | FLAG_3_BIT_2  ; flags 3
	db 0 ; ?
	db ATK_ANIM_GLOW_EFFECT ; animation

	db 1 ; retreat cost
	db WR_FIGHTING ; weakness
	db WR_PSYCHIC ; resistance
	tx Text1826 ; category
	db DEX_MEOWTH ; Pokedex number
	db FALSE ; is Dark
	db 14 ; level
	length 0.4 ; length
	weight 4.2 ; weight
	tx MeowthDescription3 ; description
	db NONE | HAS_EVOLUTION ; AI info

MeowthLv15Card:
	db TYPE_PKMN_COLORLESS ; type
	dw $5211 ; gfx
	tx MeowthName ; name
	db CIRCLE ; rarity
	db JUNGLE ; real set
	db ISLAND_OF_FOSSIL ; in-game set
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
	dw EffectCommands_587cd ; effect commands
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
	db DEX_MEOWTH ; Pokedex number
	db FALSE ; is Dark
	db 15 ; level
	length 0.4 ; length
	weight 4.2 ; weight
	tx MeowthDescription4 ; description
	db NONE | HAS_EVOLUTION ; AI info

MeowthLv17Card:
	db TYPE_PKMN_COLORLESS ; type
	dw $c35c ; gfx
	tx MeowthName ; name
	db CIRCLE ; rarity
	db BULBASAUR_DECK ; real set
	db BEGINNING_POKEMON ; in-game set
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
	dw EffectCommands_59293 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_MULTIPLE_SLASH ; animation

	db 1 ; retreat cost
	db WR_FIGHTING ; weakness
	db WR_PSYCHIC ; resistance
	tx Text1826 ; category
	db DEX_MEOWTH ; Pokedex number
	db FALSE ; is Dark
	db 17 ; level
	length 0.4 ; length
	weight 4.2 ; weight
	tx MeowthDescription5 ; description
	db NONE | HAS_EVOLUTION ; AI info

PersianCard:
	db TYPE_PKMN_COLORLESS ; type
	dw $5280 ; gfx
	tx PersianName ; name
	db DIAMOND ; rarity
	db JUNGLE ; real set
	db ISLAND_OF_FOSSIL ; in-game set
	dw PERSIAN
	db 70 ; hp
	db STAGE1 ; stage
	tx MeowthName ; pre-evo name

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
	dw EffectCommands_5884e ; effect commands
	db NONE ; flags 1
	db NULLIFY_OR_WEAKEN_ATTACK  ; flags 2
	db NONE ; flags 3
	db 10 ; ?
	db ATK_ANIM_HIT ; animation

	db 0 ; retreat cost
	db WR_FIGHTING ; weakness
	db WR_PSYCHIC ; resistance
	tx Text1835 ; category
	db DEX_PERSIAN ; Pokedex number
	db FALSE ; is Dark
	db 25 ; level
	length 1.0 ; length
	weight 32.0 ; weight
	tx PersianDescription ; description
	db NONE ; AI info

DarkPersianLv28Card:
	db TYPE_PKMN_COLORLESS ; type
	dw $6c7a ; gfx
	tx DarkPersianName ; name
	db CIRCLE ; rarity
	db TEAM_ROCKET ; real set
	db TEAM_ROCKETS_AMBITION ; in-game set
	dw DARK_PERSIAN_LV28
	db 60 ; hp
	db STAGE1 ; stage
	tx MeowthName ; pre-evo name

	; attack 1
	energy COLORLESS, 1 ; energies
	tx Text1838 ; name
	tx Text1839 ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db RESIDUAL ; category
	dw EffectCommands_58b2e ; effect commands
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
	dw EffectCommands_58b3f ; effect commands
	db INFLICT_POISON  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_POISON_FANG ; animation

	db 0 ; retreat cost
	db WR_FIGHTING ; weakness
	db WR_PSYCHIC ; resistance
	tx Text1835 ; category
	db DEX_PERSIAN ; Pokedex number
	db TRUE ; is Dark
	db 28 ; level
	length 1.0 ; length
	weight 32.0 ; weight
	tx DarkPersianDescription ; description
	db NONE ; AI info

DarkPersianAltLv28Card:
	db TYPE_PKMN_COLORLESS ; type
	dw $9e90 ; gfx
	tx DarkPersianName ; name
	db CIRCLE ; rarity
	db PRO ; real set
	db PROMOTIONAL ; in-game set
	dw DARK_PERSIAN_ALT_LV28
	db 60 ; hp
	db STAGE1 ; stage
	tx MeowthName ; pre-evo name

	; attack 1
	energy COLORLESS, 1 ; energies
	tx Text1838 ; name
	tx Text1839 ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db RESIDUAL ; category
	dw EffectCommands_59177 ; effect commands
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
	dw EffectCommands_59188 ; effect commands
	db INFLICT_POISON  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_POISON_FANG ; animation

	db 0 ; retreat cost
	db WR_FIGHTING ; weakness
	db WR_PSYCHIC ; resistance
	tx Text1835 ; category
	db DEX_PERSIAN ; Pokedex number
	db TRUE ; is Dark
	db 28 ; level
	length 1.0 ; length
	weight 32.0 ; weight
	tx DarkPersianDescription ; description
	db NONE ; AI info

FarfetchdLv20Card:
	db TYPE_PKMN_COLORLESS ; type
	dw $52fb ; gfx
	tx FarfetchdName ; name
	db DIAMOND ; rarity
	db BASE_SET ; real set
	db LEGENDARY_POWER ; in-game set
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
	dw EffectCommands_5878a ; effect commands
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
	db DEX_FARFETCH_D ; Pokedex number
	db FALSE ; is Dark
	db 20 ; level
	length 0.8 ; length
	weight 15.0 ; weight
	tx FarfetchdDescription ; description
	db AI_INFO_UNK_03 ; AI info

FarfetchdAltLv20Card:
	db TYPE_PKMN_COLORLESS ; type
	dw $a13f ; gfx
	tx FarfetchdName ; name
	db PROMOSTAR ; rarity
	db PRO ; real set
	db PROMOTIONAL ; in-game set
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
	dw EffectCommands_591f9 ; effect commands
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
	db DEX_FARFETCH_D ; Pokedex number
	db FALSE ; is Dark
	db 20 ; level
	length 0.8 ; length
	weight 15.0 ; weight
	tx FarfetchdAltDescription ; description
	db NONE ; AI info

DoduoLv8Card:
	db TYPE_PKMN_COLORLESS ; type
	dw $7c62 ; gfx
	tx DoduoName ; name
	db CIRCLE ; rarity
	db EXPANSION_SHEET ; real set
	db SKY_FLYING_POKEMON ; in-game set
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
	dw EffectCommands_58d09 ; effect commands
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
	db DEX_DODUO ; Pokedex number
	db FALSE ; is Dark
	db 8 ; level
	length 1.4 ; length
	weight 39.2 ; weight
	tx DoduoDescription1 ; description
	db NONE | HAS_EVOLUTION ; AI info

DoduoLv10Card:
	db TYPE_PKMN_COLORLESS ; type
	dw $536e ; gfx
	tx DoduoName ; name
	db CIRCLE ; rarity
	db BASE_SET ; real set
	db PSYCHIC_BATTLE ; in-game set
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
	dw EffectCommands_587b8 ; effect commands
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
	db DEX_DODUO ; Pokedex number
	db FALSE ; is Dark
	db 10 ; level
	length 1.4 ; length
	weight 39.2 ; weight
	tx DoduoDescription2 ; description
	db AI_INFO_UNK_03 | HAS_EVOLUTION ; AI info

DodrioLv25Card:
	db TYPE_PKMN_COLORLESS ; type
	dw $7ccb ; gfx
	tx DodrioName ; name
	db DIAMOND ; rarity
	db EXPANSION_SHEET ; real set
	db SKY_FLYING_POKEMON ; in-game set
	dw DODRIO_LV25
	db 60 ; hp
	db STAGE1 ; stage
	tx DoduoName ; pre-evo name

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
	dw EffectCommands_58d0e ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_MULTIPLE_SLASH ; animation

	db 0 ; retreat cost
	db WR_LIGHTNING ; weakness
	db WR_FIGHTING ; resistance
	tx Text184b ; category
	db DEX_DODRIO ; Pokedex number
	db FALSE ; is Dark
	db 25 ; level
	length 1.8 ; length
	weight 85.2 ; weight
	tx DodrioDescription1 ; description
	db NONE ; AI info

DodrioLv28Card:
	db TYPE_PKMN_COLORLESS ; type
	dw $53d7 ; gfx
	tx DodrioName ; name
	db DIAMOND ; rarity
	db JUNGLE ; real set
	db PSYCHIC_BATTLE ; in-game set
	dw DODRIO_LV28
	db 70 ; hp
	db STAGE1 ; stage
	tx DoduoName ; pre-evo name

	; attack 1
	energy 0 ; energies
	tx Text184d ; name
	tx Text184e ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db POKEMON_POWER ; category
	dw EffectCommands_587c0 ; effect commands
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
	dw EffectCommands_587c5 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db BOOST_IF_TAKEN_DAMAGE  ; flags 3
	db 0 ; ?
	db ATK_ANIM_BIG_HIT ; animation

	db 0 ; retreat cost
	db WR_LIGHTNING ; weakness
	db WR_FIGHTING ; resistance
	tx Text184b ; category
	db DEX_DODRIO ; Pokedex number
	db FALSE ; is Dark
	db 28 ; level
	length 1.8 ; length
	weight 85.2 ; weight
	tx DodrioDescription2 ; description
	db AI_INFO_BENCH_UTILITY ; AI info

LickitungLv20Card:
	db TYPE_PKMN_COLORLESS ; type
	dw $7d34 ; gfx
	tx LickitungName ; name
	db DIAMOND ; rarity
	db EXPANSION_SHEET ; real set
	db ISLAND_OF_FOSSIL ; in-game set
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
	dw EffectCommands_58d16 ; effect commands
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
	dw EffectCommands_58d1b ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_HIT ; animation

	db 2 ; retreat cost
	db WR_FIGHTING ; weakness
	db WR_PSYCHIC ; resistance
	tx Text1852 ; category
	db DEX_LICKITUNG ; Pokedex number
	db FALSE ; is Dark
	db 20 ; level
	length 1.2 ; length
	weight 65.5 ; weight
	tx LickitungDescription1 ; description
	db NONE ; AI info

LickitungLv26Card:
	db TYPE_PKMN_COLORLESS ; type
	dw $5440 ; gfx
	tx LickitungName ; name
	db DIAMOND ; rarity
	db JUNGLE ; real set
	db TEAM_ROCKETS_AMBITION ; in-game set
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
	dw EffectCommands_58853 ; effect commands
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
	dw EffectCommands_58858 ; effect commands
	db INFLICT_CONFUSION  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_SUPERSONIC ; animation

	db 3 ; retreat cost
	db WR_FIGHTING ; weakness
	db WR_PSYCHIC ; resistance
	tx Text1852 ; category
	db DEX_LICKITUNG ; Pokedex number
	db FALSE ; is Dark
	db 26 ; level
	length 1.2 ; length
	weight 65.5 ; weight
	tx LickitungDescription2 ; description
	db NONE ; AI info

ChanseyLv40Card:
	db TYPE_PKMN_COLORLESS ; type
	dw $7de7 ; gfx
	tx ChanseyName ; name
	db DIAMOND ; rarity
	db EXPANSION_SHEET ; real set
	db TEAM_ROCKETS_AMBITION ; in-game set
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
	dw EffectCommands_58d23 ; effect commands
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
	dw EffectCommands_58d28 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_203 ; animation

	db 1 ; retreat cost
	db WR_FIGHTING ; weakness
	db WR_PSYCHIC ; resistance
	tx Text1417 ; category
	db DEX_CHANSEY ; Pokedex number
	db FALSE ; is Dark
	db 40 ; level
	length 1.1 ; length
	weight 34.6 ; weight
	tx ChanseyDescription1 ; description
	db NONE ; AI info

ChanseyLv55Card:
	db TYPE_PKMN_COLORLESS ; type
	dw $54a9 ; gfx
	tx ChanseyName ; name
	db STAR ; rarity
	db BASE_SET ; real set
	db BEGINNING_POKEMON ; in-game set
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
	dw EffectCommands_58884 ; effect commands
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
	dw EffectCommands_58889 ; effect commands
	db HIGH_RECOIL  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 80 ; ?
	db ATK_ANIM_HIT_RECOIL ; animation

	db 1 ; retreat cost
	db WR_FIGHTING ; weakness
	db WR_PSYCHIC ; resistance
	tx Text1417 ; category
	db DEX_CHANSEY ; Pokedex number
	db FALSE ; is Dark
	db 55 ; level
	length 1.1 ; length
	weight 34.6 ; weight
	tx ChanseyDescription2 ; description
	db AI_INFO_UNK_08 ; AI info

KangaskhanLv36Card:
	db TYPE_PKMN_COLORLESS ; type
	dw $99ba ; gfx
	tx KangaskhanName ; name
	db DIAMOND ; rarity
	db EXPANSION_SHEET ; real set
	db TEAM_ROCKETS_AMBITION ; in-game set
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
	dw EffectCommands_590f7 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_200 ; animation

	db 3 ; retreat cost
	db WR_FIGHTING ; weakness
	db WR_PSYCHIC ; resistance
	tx Text185e ; category
	db DEX_KANGASKHAN ; Pokedex number
	db FALSE ; is Dark
	db 36 ; level
	length 2.2 ; length
	weight 80.0 ; weight
	tx KangaskhanDescription1 ; description
	db NONE ; AI info

KangaskhanLv38Card:
	db TYPE_PKMN_COLORLESS ; type
	dw $a1b6 ; gfx
	tx KangaskhanName ; name
	db PROMOSTAR ; rarity
	db PRO ; real set
	db PROMOTIONAL ; in-game set
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
	dw EffectCommands_59204 ; effect commands
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
	db DEX_KANGASKHAN ; Pokedex number
	db FALSE ; is Dark
	db 38 ; level
	length 2.2 ; length
	weight 80.0 ; weight
	tx KangaskhanDescription2 ; description
	db NONE ; AI info

KangaskhanLv40Card:
	db TYPE_PKMN_COLORLESS ; type
	dw $5512 ; gfx
	tx KangaskhanName ; name
	db STAR ; rarity
	db JUNGLE ; real set
	db LEGENDARY_POWER ; in-game set
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
	dw EffectCommands_58798 ; effect commands
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
	dw EffectCommands_587a0 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_PUNCH ; animation

	db 3 ; retreat cost
	db WR_FIGHTING ; weakness
	db WR_PSYCHIC ; resistance
	tx Text185e ; category
	db DEX_KANGASKHAN ; Pokedex number
	db FALSE ; is Dark
	db 40 ; level
	length 2.2 ; length
	weight 80.0 ; weight
	tx KangaskhanDescription3 ; description
	db NONE ; AI info

TaurosLv32Card:
	db TYPE_PKMN_COLORLESS ; type
	dw $557b ; gfx
	tx TaurosName ; name
	db DIAMOND ; rarity
	db JUNGLE ; real set
	db WE_ARE_TEAM_ROCKET ; in-game set
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
	dw EffectCommands_587a8 ; effect commands
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
	dw EffectCommands_587b0 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db BOOST_IF_TAKEN_DAMAGE  ; flags 3
	db 0 ; ?
	db ATK_ANIM_RAMPAGE ; animation

	db 2 ; retreat cost
	db WR_FIGHTING ; weakness
	db WR_PSYCHIC ; resistance
	tx Text1869 ; category
	db DEX_TAUROS ; Pokedex number
	db FALSE ; is Dark
	db 32 ; level
	length 1.4 ; length
	weight 88.4 ; weight
	tx TaurosDescription1 ; description
	db NONE ; AI info

TaurosLv35Card:
	db TYPE_PKMN_COLORLESS ; type
	dw $9ca6 ; gfx
	tx TaurosName ; name
	db CIRCLE ; rarity
	db EXPANSION_SHEET ; real set
	db ISLAND_OF_FOSSIL ; in-game set
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
	dw EffectCommands_59132 ; effect commands
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
	db DEX_TAUROS ; Pokedex number
	db FALSE ; is Dark
	db 35 ; level
	length 1.4 ; length
	weight 88.4 ; weight
	tx TaurosDescription2 ; description
	db NONE ; AI info

DittoCard:
	db TYPE_PKMN_COLORLESS ; type
	dw $55e4 ; gfx
	tx DittoName ; name
	db STAR ; rarity
	db GB ; real set
	db PSYCHIC_BATTLE ; in-game set
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
	dw EffectCommands_588b6 ; effect commands
	db NONE ; flags 1
	db FLAG_2_BIT_6  ; flags 2
	db FLAG_3_BIT_2  ; flags 3
	db 3 ; ?
	db ATK_ANIM_GLOW_EFFECT ; animation

	db 1 ; retreat cost
	db WR_FIGHTING ; weakness
	db WR_PSYCHIC ; resistance
	tx Text1872 ; category
	db DEX_DITTO ; Pokedex number
	db FALSE ; is Dark
	db 19 ; level
	length 0.3 ; length
	weight 4.0 ; weight
	tx DittoDescription ; description
	db NONE ; AI info

EeveeLv5Card:
	db TYPE_PKMN_COLORLESS ; type
	dw $7f3c ; gfx
	tx EeveeName ; name
	db DIAMOND ; rarity
	db EXPANSION_SHEET ; real set
	db PSYCHIC_BATTLE ; in-game set
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
	dw EffectCommands_58d45 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_HIT ; animation

	db 0 ; retreat cost
	db WR_FIGHTING ; weakness
	db WR_PSYCHIC ; resistance
	tx Text1874 ; category
	db DEX_EEVEE ; Pokedex number
	db FALSE ; is Dark
	db 5 ; level
	length 0.3 ; length
	weight 6.5 ; weight
	tx EeveeDescription1 ; description
	db NONE | HAS_EVOLUTION ; AI info

EeveeLv9Card:
	db TYPE_PKMN_COLORLESS ; type
	dw $6ce3 ; gfx
	tx EeveeName ; name
	db CIRCLE ; rarity
	db TEAM_ROCKET ; real set
	db WE_ARE_TEAM_ROCKET ; in-game set
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
	dw EffectCommands_58b47 ; effect commands
	db NONE ; flags 1
	db NULLIFY_OR_WEAKEN_ATTACK  ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_DARK_GAS ; animation

	db 1 ; retreat cost
	db WR_FIGHTING ; weakness
	db WR_PSYCHIC ; resistance
	tx Text1874 ; category
	db DEX_EEVEE ; Pokedex number
	db FALSE ; is Dark
	db 9 ; level
	length 0.3 ; length
	weight 6.5 ; weight
	tx EeveeDescription2 ; description
	db NONE | HAS_EVOLUTION ; AI info

EeveeLv12Card:
	db TYPE_PKMN_COLORLESS ; type
	dw $566d ; gfx
	tx EeveeName ; name
	db CIRCLE ; rarity
	db JUNGLE ; real set
	db BEGINNING_POKEMON ; in-game set
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
	dw EffectCommands_58744 ; effect commands
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
	dw EffectCommands_58749 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_QUICK_ATTACK ; animation

	db 1 ; retreat cost
	db WR_FIGHTING ; weakness
	db WR_PSYCHIC ; resistance
	tx Text1874 ; category
	db DEX_EEVEE ; Pokedex number
	db FALSE ; is Dark
	db 12 ; level
	length 0.3 ; length
	weight 6.5 ; weight
	tx EeveeDescription3 ; description
	db AI_INFO_BENCH_UTILITY | HAS_EVOLUTION ; AI info

PorygonLv12Card:
	db TYPE_PKMN_COLORLESS ; type
	dw $56d6 ; gfx
	tx PorygonName ; name
	db DIAMOND ; rarity
	db BASE_SET ; real set
	db BEGINNING_POKEMON ; in-game set
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
	dw EffectCommands_58868 ; effect commands
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
	dw EffectCommands_58876 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db SPECIAL_AI_HANDLING | FLAG_3_BIT_2  ; flags 3
	db 0 ; ?
	db ATK_ANIM_GLOW_EFFECT ; animation

	db 1 ; retreat cost
	db WR_FIGHTING ; weakness
	db WR_PSYCHIC ; resistance
	tx Text187e ; category
	db DEX_PORYGON ; Pokedex number
	db FALSE ; is Dark
	db 12 ; level
	length 0.8 ; length
	weight 36.5 ; weight
	tx PorygonDescription1 ; description
	db NONE ; AI info

PorygonLv18Card:
	db TYPE_PKMN_COLORLESS ; type
	dw $8000 ; gfx
	tx PorygonName ; name
	db DIAMOND ; rarity
	db EXPANSION_SHEET ; real set
	db ISLAND_OF_FOSSIL ; in-game set
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
	dw EffectCommands_58d4d ; effect commands
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
	dw EffectCommands_58d55 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db SPECIAL_AI_HANDLING | FLAG_3_BIT_2  ; flags 3
	db 0 ; ?
	db ATK_ANIM_GLOW_EFFECT ; animation

	db 0 ; retreat cost
	db WR_FIGHTING ; weakness
	db WR_PSYCHIC ; resistance
	tx Text187e ; category
	db DEX_PORYGON ; Pokedex number
	db FALSE ; is Dark
	db 18 ; level
	length 0.8 ; length
	weight 36.5 ; weight
	tx PorygonDescription2 ; description
	db NONE ; AI info

PorygonLv20Card:
	db TYPE_PKMN_COLORLESS ; type
	dw $6d5a ; gfx
	tx PorygonName ; name
	db CIRCLE ; rarity
	db TEAM_ROCKET ; real set
	db TEAM_ROCKETS_AMBITION ; in-game set
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
	dw EffectCommands_58b4c ; effect commands
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
	dw EffectCommands_58b5a ; effect commands
	db INFLICT_CONFUSION  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_169 ; animation

	db 0 ; retreat cost
	db WR_FIGHTING ; weakness
	db WR_PSYCHIC ; resistance
	tx Text187e ; category
	db DEX_PORYGON ; Pokedex number
	db FALSE ; is Dark
	db 20 ; level
	length 0.8 ; length
	weight 36.5 ; weight
	tx PorygonDescription3 ; description
	db NONE ; AI info

CoolPorygonCard:
	db TYPE_PKMN_COLORLESS ; type
	dw $9f62 ; gfx
	tx CoolPorygonName ; name
	db PROMOSTAR ; rarity
	db PRO ; real set
	db PROMOTIONAL ; in-game set
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
	dw EffectCommands_5919b ; effect commands
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
	dw EffectCommands_591a9 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_216 ; animation

	db 1 ; retreat cost
	db WR_FIGHTING ; weakness
	db WR_PSYCHIC ; resistance
	tx Text187e ; category
	db DEX_PORYGON ; Pokedex number
	db FALSE ; is Dark
	db 15 ; level
	length 0.8 ; length
	weight 36.5 ; weight
	tx PorygonDescription2 ; description
	db NONE ; AI info

SnorlaxLv20Card:
	db TYPE_PKMN_COLORLESS ; type
	dw $573f ; gfx
	tx SnorlaxName ; name
	db STAR ; rarity
	db JUNGLE ; real set
	db BEGINNING_POKEMON ; in-game set
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
	dw EffectCommands_58780 ; effect commands
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
	dw EffectCommands_58785 ; effect commands
	db INFLICT_PARALYSIS  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_BIG_HIT ; animation

	db 4 ; retreat cost
	db WR_FIGHTING ; weakness
	db WR_PSYCHIC ; resistance
	tx Text188c ; category
	db DEX_SNORLAX ; Pokedex number
	db FALSE ; is Dark
	db 20 ; level
	length 2.1 ; length
	weight 460.0 ; weight
	tx SnorlaxDescription1 ; description
	db NONE ; AI info

SnorlaxLv35Card:
	db TYPE_PKMN_COLORLESS ; type
	dw $806f ; gfx
	tx SnorlaxName ; name
	db STAR ; rarity
	db EXPANSION_SHEET ; real set
	db SKY_FLYING_POKEMON ; in-game set
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
	dw EffectCommands_58d63 ; effect commands
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
	dw EffectCommands_58d68 ; effect commands
	db INFLICT_SLEEP  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_218 ; animation

	db 4 ; retreat cost
	db WR_FIGHTING ; weakness
	db WR_PSYCHIC ; resistance
	tx Text188c ; category
	db DEX_SNORLAX ; Pokedex number
	db FALSE ; is Dark
	db 35 ; level
	length 2.1 ; length
	weight 460.0 ; weight
	tx SnorlaxDescription2 ; description
	db NONE ; AI info

HungrySnorlaxCard:
	db TYPE_PKMN_COLORLESS ; type
	dw $a000 ; gfx
	tx HungrySnorlaxName ; name
	db PROMOSTAR ; rarity
	db PRO ; real set
	db PROMOTIONAL ; in-game set
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
	dw EffectCommands_591b1 ; effect commands
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
	dw EffectCommands_591b9 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db SPECIAL_AI_HANDLING  ; flags 3
	db 0 ; ?
	db ATK_ANIM_HIT ; animation

	db 4 ; retreat cost
	db WR_FIGHTING ; weakness
	db WR_PSYCHIC ; resistance
	tx Text188c ; category
	db DEX_SNORLAX ; Pokedex number
	db FALSE ; is Dark
	db 50 ; level
	length 2.1 ; length
	weight 460.0 ; weight
	tx HungrySnorlaxDescription ; description
	db NONE ; AI info

DratiniLv10Card:
	db TYPE_PKMN_COLORLESS ; type
	dw $5800 ; gfx
	tx DratiniName ; name
	db CIRCLE ; rarity
	db BASE_SET ; real set
	db LEGENDARY_POWER ; in-game set
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
	db DEX_DRATINI ; Pokedex number
	db FALSE ; is Dark
	db 10 ; level
	length 1.8 ; length
	weight 3.3 ; weight
	tx DratiniDescription1 ; description
	db AI_INFO_ENCOURAGE_EVO | HAS_EVOLUTION ; AI info

DratiniLv12Card:
	db TYPE_PKMN_COLORLESS ; type
	dw $6dc9 ; gfx
	tx DratiniName ; name
	db CIRCLE ; rarity
	db TEAM_ROCKET ; real set
	db TEAM_ROCKETS_AMBITION ; in-game set
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
	dw EffectCommands_58b5f ; effect commands
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
	db DEX_DRATINI ; Pokedex number
	db FALSE ; is Dark
	db 12 ; level
	length 1.8 ; length
	weight 3.3 ; weight
	tx DratiniDescription2 ; description
	db NONE | HAS_EVOLUTION ; AI info

DragonairCard:
	db TYPE_PKMN_COLORLESS ; type
	dw $5869 ; gfx
	tx DragonairName ; name
	db STAR ; rarity
	db BASE_SET ; real set
	db LEGENDARY_POWER ; in-game set
	dw DRAGONAIR
	db 80 ; hp
	db STAGE1 ; stage
	tx DratiniName ; pre-evo name

	; attack 1
	energy COLORLESS, 3 ; energies
	tx Text189c ; name
	tx Text1352 ; description
	dw NONE ; description (cont)
	db 30 ; damage
	db DAMAGE_X ; category
	dw EffectCommands_587d2 ; effect commands
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
	dw EffectCommands_587da ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db SPECIAL_AI_HANDLING  ; flags 3
	db 0 ; ?
	db ATK_ANIM_HYPER_BEAM ; animation

	db 2 ; retreat cost
	db NONE ; weakness
	db WR_PSYCHIC ; resistance
	tx Text1558 ; category
	db DEX_DRAGONAIR ; Pokedex number
	db FALSE ; is Dark
	db 33 ; level
	length 4.0 ; length
	weight 16.5 ; weight
	tx DragonairDescription ; description
	db NONE | HAS_EVOLUTION ; AI info

DarkDragonairCard:
	db TYPE_PKMN_COLORLESS ; type
	dw $6e32 ; gfx
	tx DarkDragonairName ; name
	db DIAMOND ; rarity
	db TEAM_ROCKET ; real set
	db TEAM_ROCKETS_AMBITION ; in-game set
	dw DARK_DRAGONAIR
	db 60 ; hp
	db STAGE1 ; stage
	tx DratiniName ; pre-evo name

	; attack 1
	energy 0 ; energies
	tx Text189f ; name
	tx Text18a0 ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db POKEMON_POWER ; category
	dw EffectCommands_58b64 ; effect commands
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
	dw EffectCommands_58b6f ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_200 ; animation

	db 2 ; retreat cost
	db NONE ; weakness
	db WR_PSYCHIC ; resistance
	tx Text1558 ; category
	db DEX_DRAGONAIR ; Pokedex number
	db TRUE ; is Dark
	db 28 ; level
	length 4.0 ; length
	weight 16.5 ; weight
	tx DarkDragonairDescription ; description
	db NONE | HAS_EVOLUTION ; AI info

DragoniteLv41Card:
	db TYPE_PKMN_COLORLESS ; type
	dw $58d2 ; gfx
	tx DragoniteName ; name
	db STAR ; rarity
	db GB ; real set
	db PROMOTIONAL ; in-game set
	dw DRAGONITE_LV41
	db 100 ; hp
	db STAGE2 ; stage
	tx DragonairName ; pre-evo name

	; attack 1
	energy 0 ; energies
	tx Text18a4 ; name
	tx Text18a5 ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db POKEMON_POWER ; category
	dw EffectCommands_588a1 ; effect commands
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
	dw EffectCommands_588a9 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_HIT ; animation

	db 2 ; retreat cost
	db NONE ; weakness
	db WR_FIGHTING ; resistance
	tx Text1558 ; category
	db DEX_DRAGONITE ; Pokedex number
	db FALSE ; is Dark
	db 41 ; level
	length 2.2 ; length
	weight 210.0 ; weight
	tx DragoniteDescription1 ; description
	db NONE ; AI info

DragoniteLv43Card:
	db TYPE_PKMN_COLORLESS ; type
	dw $a30d ; gfx
	tx DragoniteName ; name
	db PROMOSTAR ; rarity
	db PRO ; real set
	db PROMOTIONAL ; in-game set
	dw DRAGONITE_LV43
	db 90 ; hp
	db STAGE2 ; stage
	tx DragonairName ; pre-evo name

	; attack 1
	energy 0 ; energies
	tx Text18a7 ; name
	tx Text18a8 ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db POKEMON_POWER ; category
	dw EffectCommands_59224 ; effect commands
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
	dw EffectCommands_5922f ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_QUICK_ATTACK ; animation

	db 2 ; retreat cost
	db NONE ; weakness
	db WR_FIGHTING ; resistance
	tx Text1558 ; category
	db DEX_DRAGONITE ; Pokedex number
	db FALSE ; is Dark
	db 43 ; level
	length 2.2 ; length
	weight 210.0 ; weight
	tx DragoniteDescription2 ; description
	db NONE ; AI info

DragoniteLv45Card:
	db TYPE_PKMN_COLORLESS ; type
	dw $5941 ; gfx
	tx DragoniteName ; name
	db STAR ; rarity
	db FOSSIL ; real set
	db LEGENDARY_POWER ; in-game set
	dw DRAGONITE_LV45
	db 100 ; hp
	db STAGE2 ; stage
	tx DragonairName ; pre-evo name

	; attack 1
	energy 0 ; energies
	tx Text18ab ; name
	tx Text18ac ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db POKEMON_POWER ; category
	dw EffectCommands_58770 ; effect commands
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
	dw EffectCommands_58778 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_HIT ; animation

	db 1 ; retreat cost
	db NONE ; weakness
	db WR_FIGHTING ; resistance
	tx Text1558 ; category
	db DEX_DRAGONITE ; Pokedex number
	db FALSE ; is Dark
	db 45 ; level
	length 2.2 ; length
	weight 210.0 ; weight
	tx DragoniteDescription2 ; description
	db NONE ; AI info

DarkDragoniteCard:
	db TYPE_PKMN_COLORLESS ; type
	dw $6e9b ; gfx
	tx DarkDragoniteName ; name
	db STAR ; rarity
	db TEAM_ROCKET ; real set
	db TEAM_ROCKETS_AMBITION ; in-game set
	dw DARK_DRAGONITE
	db 70 ; hp
	db STAGE2 ; stage
	tx DarkDragonairName ; pre-evo name

	; attack 1
	energy 0 ; energies
	tx Text18af ; name
	tx Text18b0 ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db POKEMON_POWER ; category
	dw EffectCommands_58b77 ; effect commands
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
	dw EffectCommands_58b82 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_200 ; animation

	db 2 ; retreat cost
	db NONE ; weakness
	db WR_FIGHTING ; resistance
	tx Text1558 ; category
	db DEX_DRAGONITE ; Pokedex number
	db TRUE ; is Dark
	db 33 ; level
	length 2.2 ; length
	weight 210.0 ; weight
	tx DarkDragoniteDescription ; description
	db NONE ; AI info

TogepiCard:
	db TYPE_PKMN_COLORLESS ; type
	dw $a5a5 ; gfx
	tx TogepiName ; name
	db PROMOSTAR ; rarity
	db PRO ; real set
	db PROMOTIONAL ; in-game set
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
	dw EffectCommands_59247 ; effect commands
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
	dw EffectCommands_5924c ; effect commands
	db NONE ; flags 1
	db FLAG_2_BIT_5  ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_NONE ; animation

	db 1 ; retreat cost
	db NONE ; weakness
	db WR_PSYCHIC ; resistance
	tx Text18b6 ; category
	db DEX_TOGEPI ; Pokedex number
	db FALSE ; is Dark
	db 8 ; level
	length 0.3 ; length
	weight 1.5 ; weight
	tx TogepiDescription ; description
	db NONE ; AI info

LugiaCard:
	db TYPE_PKMN_COLORLESS ; type
	dw $ca9a ; gfx
	tx LugiaName ; name
	db STAR ; rarity
	db GB ; real set
	db PROMOTIONAL ; in-game set
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
	dw EffectCommands_59348 ; effect commands
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
	db DEX_LUGIA ; Pokedex number
	db FALSE ; is Dark
	db 55 ; level
	length 5.2 ; length
	weight 216.0 ; weight
	tx LugiaDescription ; description
	db NONE ; AI info

GrassEnergyCard:
	db TYPE_ENERGY_GRASS ; type
	dw $0 ; gfx
	tx GrassEnergyName ; name
	db CIRCLE ; rarity
	db BASE_SET ; real set
	db ENERGY ; in-game set
	dw GRASS_ENERGY
	dw EffectCommands_5935e ; effect commands
	tx GrassEnergyDescription ; description
	dw NONE ; description (cont)

FireEnergyCard:
	db TYPE_ENERGY_FIRE ; type
	dw $93 ; gfx
	tx FireEnergyName ; name
	db CIRCLE ; rarity
	db BASE_SET ; real set
	db ENERGY ; in-game set
	dw FIRE_ENERGY
	dw EffectCommands_5935c ; effect commands
	tx FireEnergyDescription ; description
	dw NONE ; description (cont)

WaterEnergyCard:
	db TYPE_ENERGY_WATER ; type
	dw $122 ; gfx
	tx WaterEnergyName ; name
	db CIRCLE ; rarity
	db BASE_SET ; real set
	db ENERGY ; in-game set
	dw WATER_ENERGY
	dw EffectCommands_5935a ; effect commands
	tx WaterEnergyDescription ; description
	dw NONE ; description (cont)

LightningEnergyCard:
	db TYPE_ENERGY_LIGHTNING ; type
	dw $1b7 ; gfx
	tx LightningEnergyName ; name
	db CIRCLE ; rarity
	db BASE_SET ; real set
	db ENERGY ; in-game set
	dw LIGHTNING_ENERGY
	dw EffectCommands_59358 ; effect commands
	tx LightningEnergyDescription ; description
	dw NONE ; description (cont)

FightingEnergyCard:
	db TYPE_ENERGY_FIGHTING ; type
	dw $240 ; gfx
	tx FightingEnergyName ; name
	db CIRCLE ; rarity
	db BASE_SET ; real set
	db ENERGY ; in-game set
	dw FIGHTING_ENERGY
	dw EffectCommands_59356 ; effect commands
	tx FightingEnergyDescription ; description
	dw NONE ; description (cont)

PsychicEnergyCard:
	db TYPE_ENERGY_PSYCHIC ; type
	dw $2d7 ; gfx
	tx PsychicEnergyName ; name
	db CIRCLE ; rarity
	db BASE_SET ; real set
	db ENERGY ; in-game set
	dw PSYCHIC_ENERGY
	dw EffectCommands_59354 ; effect commands
	tx PsychicEnergyDescription ; description
	dw NONE ; description (cont)

DoubleColorlessEnergyCard:
	db TYPE_ENERGY_DOUBLE_COLORLESS ; type
	dw $366 ; gfx
	tx DoubleColorlessEnergyName ; name
	db DIAMOND ; rarity
	db BASE_SET ; real set
	db LEGENDARY_POWER ; in-game set
	dw DOUBLE_COLORLESS_ENERGY
	dw EffectCommands_59352 ; effect commands
	tx DoubleColorlessEnergyDescription ; description
	dw NONE ; description (cont)

PotionEnergyCard:
	db TYPE_ENERGY_UNUSED ; type
	dw $3fb ; gfx
	tx PotionEnergyName ; name
	db CIRCLE ; rarity
	db TEAM_ROCKET ; real set
	db WE_ARE_TEAM_ROCKET ; in-game set
	dw POTION_ENERGY
	dw EffectCommands_58bfa ; effect commands
	tx PotionEnergyDescription ; description
	tx PotionEnergyDescriptionCont ; description (cont)

FullhealEnergyCard:
	db TYPE_ENERGY_UNUSED ; type
	dw $466 ; gfx
	tx FullhealEnergyName ; name
	db CIRCLE ; rarity
	db TEAM_ROCKET ; real set
	db WE_ARE_TEAM_ROCKET ; in-game set
	dw FULLHEAL_ENERGY
	dw EffectCommands_58bff ; effect commands
	tx FullhealEnergyDescription ; description
	tx PotionEnergyDescriptionCont ; description (cont)

RainbowEnergyCard:
	db TYPE_ENERGY_UNUSED ; type
	dw $4cf ; gfx
	tx RainbowEnergyName ; name
	db STAR ; rarity
	db TEAM_ROCKET ; real set
	db WE_ARE_TEAM_ROCKET ; in-game set
	dw RAINBOW_ENERGY
	dw EffectCommands_58c04 ; effect commands
	tx RainbowEnergyDescription ; description
	dw NONE ; description (cont)

RecycleEnergyCard:
	db TYPE_ENERGY_UNUSED ; type
	dw $c9c8 ; gfx
	tx RecycleEnergyName ; name
	db DIAMOND ; rarity
	db GB ; real set
	db TEAM_ROCKETS_AMBITION ; in-game set
	dw RECYCLE_ENERGY
	dw EffectCommands_59350 ; effect commands
	tx RecycleEnergyDescription ; description
	dw NONE ; description (cont)

SuperPotionCard:
	db TYPE_TRAINER ; type
	dw $b325 ; gfx
	tx SuperPotionName ; name
	db DIAMOND ; rarity
	db BASE_SET ; real set
	db BEGINNING_POKEMON ; in-game set
	dw SUPER_POTION
	dw EffectCommands_59360 ; effect commands
	tx SuperPotionDescription ; description
	dw NONE ; description (cont)

ImakuniCardCard:
	db TYPE_TRAINER ; type
	dw $a93b ; gfx
	tx ImakuniCardName ; name
	db PROMOSTAR ; rarity
	db PRO ; real set
	db PROMOTIONAL ; in-game set
	dw IMAKUNI_CARD
	dw EffectCommands_5936b ; effect commands
	tx ImakuniCardDescription ; description
	dw NONE ; description (cont)

EnergyRemovalCard:
	db TYPE_TRAINER ; type
	dw $acbd ; gfx
	tx EnergyRemovalName ; name
	db CIRCLE ; rarity
	db BASE_SET ; real set
	db LEGENDARY_POWER ; in-game set
	dw ENERGY_REMOVAL
	dw EffectCommands_59370 ; effect commands
	tx EnergyRemovalDescription ; description
	dw NONE ; description (cont)

EnergyRetrievalCard:
	db TYPE_TRAINER ; type
	dw $ab72 ; gfx
	tx EnergyRetrievalName ; name
	db DIAMOND ; rarity
	db BASE_SET ; real set
	db BEGINNING_POKEMON ; in-game set
	dw ENERGY_RETRIEVAL
	dw EffectCommands_5937e ; effect commands
	tx EnergyRetrievalDescription ; description
	dw NONE ; description (cont)

EnergySearchCard:
	db TYPE_TRAINER ; type
	dw $ac4a ; gfx
	tx EnergySearchName ; name
	db CIRCLE ; rarity
	db FOSSIL ; real set
	db BEGINNING_POKEMON ; in-game set
	dw ENERGY_SEARCH
	dw EffectCommands_5938c ; effect commands
	tx EnergySearchDescription ; description
	dw NONE ; description (cont)

ProfessorOakCard:
	db TYPE_TRAINER ; type
	dw $a6f0 ; gfx
	tx ProfessorOakName ; name
	db DIAMOND ; rarity
	db BASE_SET ; real set
	db BEGINNING_POKEMON ; in-game set
	dw PROFESSOR_OAK
	dw EffectCommands_59397 ; effect commands
	tx ProfessorOakDescription ; description
	dw NONE ; description (cont)

FossilExcavationCard:
	db TYPE_TRAINER ; type
	dw $bb4d ; gfx
	tx FossilExcavationName ; name
	db DIAMOND ; rarity
	db EXPANSION_SHEET ; real set
	db PSYCHIC_BATTLE ; in-game set
	dw FOSSIL_EXCAVATION
	dw EffectCommands_58d7d ; effect commands
	tx FossilExcavationDescription ; description
	dw NONE ; description (cont)

PotionCard:
	db TYPE_TRAINER ; type
	dw $b296 ; gfx
	tx PotionName ; name
	db CIRCLE ; rarity
	db BASE_SET ; real set
	db BEGINNING_POKEMON ; in-game set
	dw POTION
	dw EffectCommands_5939c ; effect commands
	tx PotionDescription ; description
	dw NONE ; description (cont)

GamblerCard:
	db TYPE_TRAINER ; type
	dw $b5b0 ; gfx
	tx GamblerName ; name
	db CIRCLE ; rarity
	db FOSSIL ; real set
	db PSYCHIC_BATTLE ; in-game set
	dw GAMBLER
	dw EffectCommands_593a7 ; effect commands
	tx GamblerDescription ; description
	dw NONE ; description (cont)

ReviveCard:
	db TYPE_TRAINER ; type
	dw $b449 ; gfx
	tx ReviveName ; name
	db DIAMOND ; rarity
	db BASE_SET ; real set
	db LEGENDARY_POWER ; in-game set
	dw REVIVE
	dw EffectCommands_59472 ; effect commands
	tx ReviveDescription ; description
	dw NONE ; description (cont)

MaxReviveCard:
	db TYPE_TRAINER ; type
	dw $bc2b ; gfx
	tx MaxReviveName ; name
	db DIAMOND ; rarity
	db EXPANSION_SHEET ; real set
	db WE_ARE_TEAM_ROCKET ; in-game set
	dw MAX_REVIVE
	dw EffectCommands_58d99 ; effect commands
	tx MaxReviveDescription ; description
	tx MaxReviveDescriptionCont ; description (cont)

SuperScoopUpCard:
	db TYPE_TRAINER ; type
	dw $bef1 ; gfx
	tx SuperScoopUpName ; name
	db CIRCLE ; rarity
	db BULBASAUR_DECK ; real set
	db TEAM_ROCKETS_AMBITION ; in-game set
	dw SUPER_SCOOP_UP
	dw EffectCommands_592c3 ; effect commands
	tx SuperScoopUpDescription ; description
	dw NONE ; description (cont)

DevolutionSprayCard:
	db TYPE_TRAINER ; type
	dw $b21d ; gfx
	tx DevolutionSprayName ; name
	db STAR ; rarity
	db BASE_SET ; real set
	db WE_ARE_TEAM_ROCKET ; in-game set
	dw DEVOLUTION_SPRAY
	dw EffectCommands_5947d ; effect commands
	tx DevolutionSprayDescription ; description
	dw NONE ; description (cont)

ItemfinderCard:
	db TYPE_TRAINER ; type
	dw $b14b ; gfx
	tx ItemfinderName ; name
	db STAR ; rarity
	db BASE_SET ; real set
	db ISLAND_OF_FOSSIL ; in-game set
	dw ITEMFINDER
	dw EffectCommands_593ac ; effect commands
	tx ItemfinderDescription ; description
	dw NONE ; description (cont)

ChallengeCard:
	db TYPE_TRAINER ; type
	dw $b6a2 ; gfx
	tx ChallengeName ; name
	db DIAMOND ; rarity
	db TEAM_ROCKET ; real set
	db TEAM_ROCKETS_AMBITION ; in-game set
	dw CHALLENGE
	dw EffectCommands_58c09 ; effect commands
	tx ChallengeDescription ; description
	tx ChallengeDescriptionCont ; description (cont)

SuperEnergyRetrievalCard:
	db TYPE_TRAINER ; type
	dw $abe1 ; gfx
	tx SuperEnergyRetrievalName ; name
	db PROMOSTAR ; rarity
	db PRO ; real set
	db PROMOTIONAL ; in-game set
	dw SUPER_ENERGY_RETRIEVAL
	dw EffectCommands_59493 ; effect commands
	tx SuperEnergyRetrievalDescription ; description
	dw NONE ; description (cont)

SuperEnergyRemovalCard:
	db TYPE_TRAINER ; type
	dw $ad40 ; gfx
	tx SuperEnergyRemovalName ; name
	db STAR ; rarity
	db BASE_SET ; real set
	db ISLAND_OF_FOSSIL ; in-game set
	dw SUPER_ENERGY_REMOVAL
	dw EffectCommands_59488 ; effect commands
	tx SuperEnergyRemovalDescription ; description
	dw NONE ; description (cont)

MoonStoneCard:
	db TYPE_TRAINER ; type
	dw $bbba ; gfx
	tx MoonStoneName ; name
	db STAR ; rarity
	db EXPANSION_SHEET ; real set
	db PSYCHIC_BATTLE ; in-game set
	dw MOON_STONE
	dw EffectCommands_58d8b ; effect commands
	tx MoonStoneDescription ; description
	dw NONE ; description (cont)

DefenderCard:
	db TYPE_TRAINER ; type
	dw $b0de ; gfx
	tx DefenderName ; name
	db DIAMOND ; rarity
	db BASE_SET ; real set
	db LEGENDARY_POWER ; in-game set
	dw DEFENDER
	dw EffectCommands_593b7 ; effect commands
	tx DefenderDescription ; description
	dw NONE ; description (cont)

GustOfWindCard:
	db TYPE_TRAINER ; type
	dw $b1b4 ; gfx
	tx GustOfWindName ; name
	db CIRCLE ; rarity
	db BASE_SET ; real set
	db LEGENDARY_POWER ; in-game set
	dw GUST_OF_WIND
	dw EffectCommands_594a1 ; effect commands
	tx GustOfWindDescription ; description
	dw NONE ; description (cont)

MysteriousFossilCard:
	db TYPE_TRAINER ; type
	dw $ab09 ; gfx
	tx MysteriousFossilName ; name
	db CIRCLE ; rarity
	db FOSSIL ; real set
	db ISLAND_OF_FOSSIL ; in-game set
	dw MYSTERIOUS_FOSSIL
	dw EffectCommands_593bf ; effect commands
	tx MysteriousFossilDescription ; description
	tx MysteriousFossilDescriptionCont ; description (cont)

FullHealCard:
	db TYPE_TRAINER ; type
	dw $b3d4 ; gfx
	tx FullHealName ; name
	db DIAMOND ; rarity
	db BASE_SET ; real set
	db BEGINNING_POKEMON ; in-game set
	dw FULL_HEAL
	dw EffectCommands_593c7 ; effect commands
	tx FullHealDescription ; description
	dw NONE ; description (cont)

ImposterOaksRevengeCard:
	db TYPE_TRAINER ; type
	dw $b711 ; gfx
	tx ImposterOaksRevengeName ; name
	db DIAMOND ; rarity
	db TEAM_ROCKET ; real set
	db TEAM_ROCKETS_AMBITION ; in-game set
	dw IMPOSTER_OAKS_REVENGE
	dw EffectCommands_58bbd ; effect commands
	tx ImposterOaksRevengeDescription ; description
	dw NONE ; description (cont)

ImposterProfessorOakCard:
	db TYPE_TRAINER ; type
	dw $a759 ; gfx
	tx ImposterProfessorOakName ; name
	db STAR ; rarity
	db BASE_SET ; real set
	db PSYCHIC_BATTLE ; in-game set
	dw IMPOSTER_PROFESSOR_OAK
	dw EffectCommands_593cf ; effect commands
	tx ImposterProfessorOakDescription ; description
	dw NONE ; description (cont)

SleepCard:
	db TYPE_TRAINER ; type
	dw $b780 ; gfx
	tx SleepName ; name
	db CIRCLE ; rarity
	db TEAM_ROCKET ; real set
	db TEAM_ROCKETS_AMBITION ; in-game set
	dw SLEEP
	dw EffectCommands_58bc8 ; effect commands
	tx SleepDescription ; description
	dw NONE ; description (cont)

ComputerErrorCard:
	db TYPE_TRAINER ; type
	dw $bdf3 ; gfx
	tx ComputerErrorName ; name
	db PROMOSTAR ; rarity
	db PRO ; real set
	db PROMOTIONAL ; in-game set
	dw COMPUTER_ERROR
	dw EffectCommands_58dc2 ; effect commands
	tx ComputerErrorDescription ; description
	dw NONE ; description (cont)

ComputerSearchCard:
	db TYPE_TRAINER ; type
	dw $af79 ; gfx
	tx ComputerSearchName ; name
	db STAR ; rarity
	db BASE_SET ; real set
	db ISLAND_OF_FOSSIL ; in-game set
	dw COMPUTER_SEARCH
	dw EffectCommands_593d4 ; effect commands
	tx ComputerSearchDescription ; description
	dw NONE ; description (cont)

DiggerCard:
	db TYPE_TRAINER ; type
	dw $b800 ; gfx
	tx DiggerName ; name
	db CIRCLE ; rarity
	db TEAM_ROCKET ; real set
	db TEAM_ROCKETS_AMBITION ; in-game set
	dw DIGGER
	dw EffectCommands_58bcd ; effect commands
	tx DiggerDescription ; description
	dw NONE ; description (cont)

ClefairyDollCard:
	db TYPE_TRAINER ; type
	dw $aa96 ; gfx
	tx ClefairyDollName ; name
	db STAR ; rarity
	db BASE_SET ; real set
	db ISLAND_OF_FOSSIL ; in-game set
	dw CLEFAIRY_DOLL
	dw EffectCommands_593e2 ; effect commands
	tx ClefairyDollDescription ; description
	tx ClefairyDollDescriptionCont ; description (cont)

MrFujiCard:
	db TYPE_TRAINER ; type
	dw $a869 ; gfx
	tx MrFujiName ; name
	db DIAMOND ; rarity
	db FOSSIL ; real set
	db SKY_FLYING_POKEMON ; in-game set
	dw MR_FUJI
	dw EffectCommands_593ea ; effect commands
	tx MrFujiDescription ; description
	dw NONE ; description (cont)

PluspowerCard:
	db TYPE_TRAINER ; type
	dw $b069 ; gfx
	tx PluspowerName ; name
	db DIAMOND ; rarity
	db BASE_SET ; real set
	db LEGENDARY_POWER ; in-game set
	dw PLUSPOWER
	dw EffectCommands_593f5 ; effect commands
	tx PluspowerDescription ; description
	dw NONE ; description (cont)

SwitchCard:
	db TYPE_TRAINER ; type
	dw $adb1 ; gfx
	tx SwitchName ; name
	db CIRCLE ; rarity
	db BASE_SET ; real set
	db BEGINNING_POKEMON ; in-game set
	dw SWITCH
	dw EffectCommands_593fa ; effect commands
	tx SwitchDescription ; description
	dw NONE ; description (cont)

ScoopUpCard:
	db TYPE_TRAINER ; type
	dw $af0a ; gfx
	tx ScoopUpName ; name
	db STAR ; rarity
	db BASE_SET ; real set
	db BEGINNING_POKEMON ; in-game set
	dw SCOOP_UP
	dw EffectCommands_59423 ; effect commands
	tx ScoopUpDescription ; description
	dw NONE ; description (cont)

PokemonTraderCard:
	db TYPE_TRAINER ; type
	dw $a9c4 ; gfx
	tx PokemonTraderName ; name
	db CIRCLE ; rarity
	db BASE_SET ; real set
	db LEGENDARY_POWER ; in-game set
	dw POKEMON_TRADER
	dw EffectCommands_5942e ; effect commands
	tx PokemonTraderDescription ; description
	tx PokemonTraderDescriptionCont ; description (cont)

PokemonRecallCard:
	db TYPE_TRAINER ; type
	dw $bd11 ; gfx
	tx PokemonRecallName ; name
	db STAR ; rarity
	db EXPANSION_SHEET ; real set
	db SKY_FLYING_POKEMON ; in-game set
	dw POKEMON_RECALL
	dw EffectCommands_58daf ; effect commands
	tx PokemonRecallDescription ; description
	dw NONE ; description (cont)

PokedexCard:
	db TYPE_TRAINER ; type
	dw $b000 ; gfx
	tx PokedexName ; name
	db DIAMOND ; rarity
	db BASE_SET ; real set
	db BEGINNING_POKEMON ; in-game set
	dw POKEDEX
	dw EffectCommands_5943c ; effect commands
	tx PokedexDescription ; description
	dw NONE ; description (cont)

PokemonCenterCard:
	db TYPE_TRAINER ; type
	dw $ae2e ; gfx
	tx PokemonCenterName ; name
	db DIAMOND ; rarity
	db BASE_SET ; real set
	db LEGENDARY_POWER ; in-game set
	dw POKEMON_CENTER
	dw EffectCommands_59405 ; effect commands
	tx PokemonCenterDescription ; description
	dw NONE ; description (cont)

PokemonBreederCard:
	db TYPE_TRAINER ; type
	dw $aa2d ; gfx
	tx PokemonBreederName ; name
	db STAR ; rarity
	db BASE_SET ; real set
	db LEGENDARY_POWER ; in-game set
	dw POKEMON_BREEDER
	dw EffectCommands_59418 ; effect commands
	tx PokemonBreederDescription ; description
	dw NONE ; description (cont)

PokemonFluteCard:
	db TYPE_TRAINER ; type
	dw $b53b ; gfx
	tx PokemonFluteName ; name
	db DIAMOND ; rarity
	db BASE_SET ; real set
	db SKY_FLYING_POKEMON ; in-game set
	dw POKEMON_FLUTE
	dw EffectCommands_5940d ; effect commands
	tx PokemonFluteDescription ; description
	dw NONE ; description (cont)

TheBosssWayCard:
	db TYPE_TRAINER ; type
	dw $b8a1 ; gfx
	tx TheBosssWayName ; name
	db DIAMOND ; rarity
	db TEAM_ROCKET ; real set
	db WE_ARE_TEAM_ROCKET ; in-game set
	dw THE_BOSSS_WAY
	dw EffectCommands_58bd2 ; effect commands
	tx TheBosssWayDescription ; description
	dw NONE ; description (cont)

GoopGasAttackCard:
	db TYPE_TRAINER ; type
	dw $b90c ; gfx
	tx GoopGasAttackName ; name
	db CIRCLE ; rarity
	db TEAM_ROCKET ; real set
	db TEAM_ROCKETS_AMBITION ; in-game set
	dw GOOP_GAS_ATTACK
	dw EffectCommands_58bdd ; effect commands
	tx GoopGasAttackDescription ; description
	dw NONE ; description (cont)

BillCard:
	db TYPE_TRAINER ; type
	dw $a800 ; gfx
	tx BillName ; name
	db CIRCLE ; rarity
	db BASE_SET ; real set
	db BEGINNING_POKEMON ; in-game set
	dw BILL
	dw EffectCommands_59447 ; effect commands
	tx BillDescription ; description
	dw NONE ; description (cont)

BillsTeleporterCard:
	db TYPE_TRAINER ; type
	dw $c3c5 ; gfx
	tx BillsTeleporterName ; name
	db CIRCLE ; rarity
	db BULBASAUR_DECK ; real set
	db TEAM_ROCKETS_AMBITION ; in-game set
	dw BILLS_TELEPORTER
	dw EffectCommands_592ce ; effect commands
	tx BillsTeleporterDescription ; description
	dw NONE ; description (cont)

BillsComputerCard:
	db TYPE_TRAINER ; type
	dw $bd7a ; gfx
	tx BillsComputerName ; name
	db CIRCLE ; rarity
	db EXPANSION_SHEET ; real set
	db PROMOTIONAL ; in-game set
	dw BILLS_COMPUTER
	dw EffectCommands_58dba ; effect commands
	tx BillsComputerDescription ; description
	tx BillsComputerDescriptionCont ; description (cont)

MasterBallCard:
	db TYPE_TRAINER ; type
	dw $bca6 ; gfx
	tx MasterBallName ; name
	db STAR ; rarity
	db EXPANSION_SHEET ; real set
	db SKY_FLYING_POKEMON ; in-game set
	dw MASTER_BALL
	dw EffectCommands_58da4 ; effect commands
	tx MasterBallDescription ; description
	dw NONE ; description (cont)

LassCard:
	db TYPE_TRAINER ; type
	dw $a8d2 ; gfx
	tx LassName ; name
	db STAR ; rarity
	db BASE_SET ; real set
	db PSYCHIC_BATTLE ; in-game set
	dw LASS
	dw EffectCommands_5944c ; effect commands
	tx LassDescription ; description
	dw NONE ; description (cont)

MaintenenceCard:
	db TYPE_TRAINER ; type
	dw $b4d2 ; gfx
	tx MaintenenceName ; name
	db DIAMOND ; rarity
	db BASE_SET ; real set
	db SKY_FLYING_POKEMON ; in-game set
	dw MAINTENENCE
	dw EffectCommands_59451 ; effect commands
	tx MaintenenceDescription ; description
	dw NONE ; description (cont)

PokeballCard:
	db TYPE_TRAINER ; type
	dw $ae9f ; gfx
	tx PokeballName ; name
	db CIRCLE ; rarity
	db JUNGLE ; real set
	db ISLAND_OF_FOSSIL ; in-game set
	dw POKEBALL
	dw EffectCommands_5945c ; effect commands
	tx PokeballDescription ; description
	dw NONE ; description (cont)

NightlyGarbageRunCard:
	db TYPE_TRAINER ; type
	dw $ba63 ; gfx
	tx NightlyGarbageRunName ; name
	db CIRCLE ; rarity
	db TEAM_ROCKET ; real set
	db TEAM_ROCKETS_AMBITION ; in-game set
	dw NIGHTLY_GARBAGE_RUN
	dw EffectCommands_58bef ; effect commands
	tx NightlyGarbageRunDescription ; description
	dw NONE ; description (cont)

RecycleCard:
	db TYPE_TRAINER ; type
	dw $b619 ; gfx
	tx RecycleName ; name
	db CIRCLE ; rarity
	db FOSSIL ; real set
	db PSYCHIC_BATTLE ; in-game set
	dw RECYCLE
	dw EffectCommands_59467 ; effect commands
	tx RecycleDescription ; description
	dw NONE ; description (cont)

RocketsSneakAttackCard:
	db TYPE_TRAINER ; type
	dw $b979 ; gfx
	tx RocketsSneakAttackName ; name
	db STAR ; rarity
	db TEAM_ROCKET ; real set
	db TEAM_ROCKETS_AMBITION ; in-game set
	dw ROCKETS_SNEAK_ATTACK
	dw EffectCommands_58be2 ; effect commands
	tx RocketsSneakAttackDescription ; description
	dw NONE ; description (cont)

HereComesTeamRocketCard:
	db TYPE_TRAINER ; type
	dw $b9ee ; gfx
	tx HereComesTeamRocketName ; name
	db RARITY_3 ; rarity
	db TEAM_ROCKET ; real set
	db PROMOTIONAL ; in-game set
	dw HERE_COMES_TEAM_ROCKET
	dw EffectCommands_58bea ; effect commands
	tx HereComesTeamRocketDescription ; description
	dw NONE ; description (cont)

TheRocketsTrapCard:
	db TYPE_TRAINER ; type
	dw $bae0 ; gfx
	tx TheRocketsTrapName ; name
	db STAR ; rarity
	db GYM_HEROES ; real set
	db TEAM_ROCKETS_AMBITION ; in-game set
	dw THE_ROCKETS_TRAP
	dw EffectCommands_58d75 ; effect commands
	tx TheRocketsTrapDescription ; description
	dw NONE ; description (cont)
