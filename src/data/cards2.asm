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
	tx WickedJabName ; name
	tx MayInflictParalysisAltDescription ; description
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
	tx FocusBlastName ; name
	tx FocusBlastDescription ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db RESIDUAL ; category
	dw EffectCommands_58fe9 ; effect commands
	db DAMAGE_TO_OPPONENT_BENCH  ; flags 1
	db FLAG_2_BIT_6  ; flags 2
	db FLAG_3_BIT_2  ; flags 3
	db 0 ; ?
	db ATK_ANIM_FOCUS_BLAST ; animation

	db 2 ; retreat cost
	db WR_PSYCHIC ; weakness
	db NONE ; resistance
	tx SuperpowerName ; category
	db DEX_MACHOKE ; Pokedex number
	db FALSE ; is Dark
	db 24 ; level
	length 1.5 ; length
	weight 70.5 ; weight
	tx MachokeLv24Description ; description
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
	tx MegaKickName ; name
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

	; attack 2
	energy FIGHTING, 3 ; energies
	tx SteadyPunchName ; name
	tx QuickAttackAltDescription1 ; description
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
	tx SuperpowerName ; category
	db DEX_MACHOKE ; Pokedex number
	db FALSE ; is Dark
	db 28 ; level
	length 1.5 ; length
	weight 70.5 ; weight
	tx MachokeLv28Description ; description
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
	tx KarateChopName ; name
	tx KarateChopDescription ; description
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
	tx SubmissionName ; name
	tx Do20DamageToSelfDescription ; description
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
	tx SuperpowerName ; category
	db DEX_MACHOKE ; Pokedex number
	db FALSE ; is Dark
	db 40 ; level
	length 1.5 ; length
	weight 70.5 ; weight
	tx MachokeLv40Description ; description
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
	tx DragOffName ; name
	tx DragOffDescription ; description
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
	tx KnockBackName ; name
	tx SwitchWithBenchedMonDescription ; description
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
	tx SuperpowerName ; category
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
	tx SeethingAngerName ; name
	tx SeethingAngerDescription ; description
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
	tx FlingName ; name
	tx SwitchWithBenchedMonDescription ; description
	dw NONE ; description (cont)
	db 50 ; damage
	db DAMAGE_NORMAL ; category
	dw EffectCommands_59005 ; effect commands
	db NONE ; flags 1
	db SWITCH_OPPONENT_POKEMON  ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_MEGA_PUNCH ; animation

	db 3 ; retreat cost
	db WR_PSYCHIC ; weakness
	db NONE ; resistance
	tx SuperpowerName ; category
	db DEX_MACHAMP ; Pokedex number
	db FALSE ; is Dark
	db 54 ; level
	length 1.6 ; length
	weight 130.0 ; weight
	tx MachampLv54Description ; description
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
	tx StrikesBackName ; name
	tx StrikesBackDescription ; description
	tx StrikesBackDescriptionCont ; description (cont)
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
	tx SeismicTossName ; name
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
	tx SuperpowerName ; category
	db DEX_MACHAMP ; Pokedex number
	db FALSE ; is Dark
	db 67 ; level
	length 1.6 ; length
	weight 130.0 ; weight
	tx MachampLv67Description ; description
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
	energy FIGHTING, 3, COLORLESS, 1 ; energies
	tx FlingAltName ; name
	tx FlingDescription ; description
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
	tx SuperpowerName ; category
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
	energy FIGHTING, 1, COLORLESS, 1 ; energies
	tx HardenName ; name
	tx Harden20DamageDescription ; description
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
	tx RockName ; category
	db DEX_GEODUDE ; Pokedex number
	db FALSE ; is Dark
	db 15 ; level
	length 0.4 ; length
	weight 20.0 ; weight
	tx GeodudeLv15Description ; description
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
	tx StoneBarrageName ; name
	tx StoneBarrage10DamageDescription ; description
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
	tx RockName ; category
	db DEX_GEODUDE ; Pokedex number
	db FALSE ; is Dark
	db 16 ; level
	length 0.4 ; length
	weight 20.0 ; weight
	tx GeodudeLv16Description ; description
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
	tx BoulderSmashName ; name
	tx BoulderSmashDescription ; description
	dw NONE ; description (cont)
	db 30 ; damage
	db DAMAGE_NORMAL ; category
	dw EffectCommands_5902d ; effect commands
	db DAMAGE_TO_OPPONENT_BENCH  ; flags 1
	db NONE ; flags 2
	db FLAG_3_BIT_2  ; flags 3
	db 0 ; ?
	db ATK_ANIM_BOULDER_SMASH ; animation

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
	tx RockName ; category
	db DEX_GRAVELER ; Pokedex number
	db FALSE ; is Dark
	db 27 ; level
	length 1.0 ; length
	weight 105.0 ; weight
	tx GravelerLv27Description ; description
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
	tx StoneBarrageAltName ; name
	tx StoneBarrage20DamageDescription ; description
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
	tx EarthquakeName ; name
	tx EarthquakeAltDescription ; description
	dw NONE ; description (cont)
	db 50 ; damage
	db DAMAGE_NORMAL ; category
	dw EffectCommands_58e38 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db SPECIAL_AI_HANDLING  ; flags 3
	db 0 ; ?
	db ATK_ANIM_EARTHQUAKE ; animation

	db 2 ; retreat cost
	db WR_GRASS ; weakness
	db NONE ; resistance
	tx RockName ; category
	db DEX_GRAVELER ; Pokedex number
	db FALSE ; is Dark
	db 28 ; level
	length 1.0 ; length
	weight 105.0 ; weight
	tx GravelerLv28Description ; description
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
	tx HardenName ; name
	tx Harden30DamageDescription ; description
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
	tx RockThrowName ; name
	dw NONE ; description
	dw NONE ; description (cont)
	db 40 ; damage
	db DAMAGE_NORMAL ; category
	dw NONE ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_ROCK_THROW ; animation

	db 2 ; retreat cost
	db WR_GRASS ; weakness
	db NONE ; resistance
	tx RockName ; category
	db DEX_GRAVELER ; Pokedex number
	db FALSE ; is Dark
	db 29 ; level
	length 1.0 ; length
	weight 105.0 ; weight
	tx GravelerLv29Description ; description
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
	tx AvalancheName ; name
	dw NONE ; description
	dw NONE ; description (cont)
	db 60 ; damage
	db DAMAGE_NORMAL ; category
	dw NONE ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_AVALANCHE ; animation

	; attack 2
	energy FIGHTING, 4 ; energies
	tx SelfdestructName ; name
	tx Selfdestruct100DamageDescription ; description
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
	tx MegatonName ; category
	db DEX_GOLEM ; Pokedex number
	db FALSE ; is Dark
	db 36 ; level
	length 1.4 ; length
	weight 300.0 ; weight
	tx GolemLv36Description ; description
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
	tx RolloutName ; name
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
	tx RockBlastName ; name
	tx RockBlastDescription ; description
	tx RockBlastDescriptionCont ; description (cont)
	db 0 ; damage
	db RESIDUAL ; category
	dw EffectCommands_5903b ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db SPECIAL_AI_HANDLING | FLAG_3_BIT_2  ; flags 3
	db 0 ; ?
	db ATK_ANIM_BOULDER_SMASH ; animation

	db 3 ; retreat cost
	db WR_GRASS ; weakness
	db NONE ; resistance
	tx MegatonName ; category
	db DEX_GOLEM ; Pokedex number
	db FALSE ; is Dark
	db 37 ; level
	length 1.4 ; length
	weight 300.0 ; weight
	tx GolemLv37Description ; description
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
	tx RockThrowName ; name
	dw NONE ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_NORMAL ; category
	dw NONE ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_ROCK_THROW ; animation

	; attack 2
	energy FIGHTING, 2 ; energies
	tx HardenName ; name
	tx Harden30DamageAltDescription ; description
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
	tx RockSnakeName ; category
	db DEX_ONIX ; Pokedex number
	db FALSE ; is Dark
	db 12 ; level
	length 8.8 ; length
	weight 210.0 ; weight
	tx OnixLv12Description ; description
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
	tx BindName ; name
	tx MayInflictParalysisAltDescription ; description
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
	tx RockSealName ; name
	tx RockSealDescription ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_NORMAL ; category
	dw EffectCommands_58e94 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_ROCK_THROW ; animation

	db 2 ; retreat cost
	db WR_GRASS ; weakness
	db NONE ; resistance
	tx RockSnakeName ; category
	db DEX_ONIX ; Pokedex number
	db FALSE ; is Dark
	db 25 ; level
	length 8.8 ; length
	weight 210.0 ; weight
	tx OnixLv25Description ; description
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
	tx SnivelName ; name
	tx SnivelDescription ; description
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
	tx RageName ; name
	tx RageDescription ; description
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
	tx LonelyName ; category
	db DEX_CUBONE ; Pokedex number
	db FALSE ; is Dark
	db 13 ; level
	length 0.4 ; length
	weight 6.5 ; weight
	tx CuboneLv13Description ; description
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
	tx BoneTossName ; name
	tx BoneTossDescription ; description
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
	tx LonelyName ; category
	db DEX_CUBONE ; Pokedex number
	db FALSE ; is Dark
	db 14 ; level
	length 0.4 ; length
	weight 6.5 ; weight
	tx CuboneLv14Description ; description
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
	tx BonemerangName ; name
	tx Do30DamageNumberOfHeadsDescription ; description
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
	tx CallForFriendName ; name
	tx CallForFriendDescription ; description
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
	tx BoneKeeperName ; category
	db DEX_MAROWAK ; Pokedex number
	db FALSE ; is Dark
	db 26 ; level
	length 1.0 ; length
	weight 45.0 ; weight
	tx MarowakLv26Description ; description
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
	tx BoneAttackName ; name
	tx BoneAttackDescription ; description
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
	tx WailName ; name
	tx WailDescription ; description
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
	tx BoneKeeperName ; category
	db DEX_MAROWAK ; Pokedex number
	db FALSE ; is Dark
	db 32 ; level
	length 1.0 ; length
	weight 45.0 ; weight
	tx MarowakLv32Description ; description
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
	tx BoneHeadbuttName ; name
	tx BoneHeadbuttDescription ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_NORMAL ; category
	dw EffectCommands_59327 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db FLAG_3_BIT_2  ; flags 3
	db 0 ; ?
	db ATK_ANIM_BONE_HEADBUTT ; animation

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
	tx BoneKeeperName ; category
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
	tx DoubleKickName ; name
	tx Do30DamageNumberOfHeadsDescription ; description
	dw NONE ; description (cont)
	db 30 ; damage
	db DAMAGE_X ; category
	dw EffectCommands_58eab ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_LEG_SWEEP ; animation

	; attack 2
	energy FIGHTING, 2, COLORLESS, 1 ; energies
	tx RollingKickName ; name
	tx MayInflictParalysisAltDescription ; description
	dw NONE ; description (cont)
	db 30 ; damage
	db DAMAGE_NORMAL ; category
	dw EffectCommands_58eb3 ; effect commands
	db INFLICT_PARALYSIS  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_LEG_SWEEP ; animation

	db 1 ; retreat cost
	db WR_PSYCHIC ; weakness
	db NONE ; resistance
	tx KickName ; category
	db DEX_HITMONLEE ; Pokedex number
	db FALSE ; is Dark
	db 23 ; level
	length 1.5 ; length
	weight 49.8 ; weight
	tx HitmonleeLv23Description ; description
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
	tx StretchKickName ; name
	tx StretchKickDescription ; description
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
	tx HighJumpKick ; name
	dw NONE ; description
	dw NONE ; description (cont)
	db 50 ; damage
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
	tx KickName ; category
	db DEX_HITMONLEE ; Pokedex number
	db FALSE ; is Dark
	db 30 ; level
	length 1.5 ; length
	weight 49.8 ; weight
	tx HitmonleeLv30Description ; description
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
	tx MatchPunchName ; name
	tx MatchPunchDescription ; description
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
	tx PunchName ; category
	db DEX_HITMONCHAN ; Pokedex number
	db FALSE ; is Dark
	db 23 ; level
	length 1.4 ; length
	weight 50.2 ; weight
	tx HitmonchanLv23Description ; description
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
	tx JabName ; name
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
	tx SpecialPunchName ; name
	dw NONE ; description
	dw NONE ; description (cont)
	db 40 ; damage
	db DAMAGE_NORMAL ; category
	dw NONE ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_MEGA_PUNCH ; animation

	db 2 ; retreat cost
	db WR_PSYCHIC ; weakness
	db NONE ; resistance
	tx PunchName ; category
	db DEX_HITMONCHAN ; Pokedex number
	db FALSE ; is Dark
	db 33 ; level
	length 1.4 ; length
	weight 50.2 ; weight
	tx HitmonchanLv33Description ; description
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
	tx LeerName ; name
	tx LeerDescription ; description
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
	tx HornAttackName ; name
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
	tx SpikesName ; category
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
	tx MountainBreakName ; name
	tx MountainBreakDescription ; description
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
	tx OneTwoStrikeName ; name
	tx QuickAttackAltDescription1 ; description
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
	tx DrillName ; category
	db DEX_RHYDON ; Pokedex number
	db FALSE ; is Dark
	db 37 ; level
	length 1.9 ; length
	weight 120.0 ; weight
	tx RhydonLv37Description ; description
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
	tx HornAttackName ; name
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
	tx RamAltName ; name
	tx RamDescription ; description
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
	tx DrillName ; category
	db DEX_RHYDON ; Pokedex number
	db FALSE ; is Dark
	db 48 ; level
	length 1.9 ; length
	weight 120.0 ; weight
	tx RhydonLv48Description ; description
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
	tx KabutoArmorName ; name
	tx KabutoArmorDescription ; description
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

	db 1 ; retreat cost
	db WR_GRASS ; weakness
	db NONE ; resistance
	tx ShellfishName ; category
	db DEX_KABUTO ; Pokedex number
	db FALSE ; is Dark
	db 9 ; level
	length 0.5 ; length
	weight 11.5 ; weight
	tx KabutoLv9Description ; description
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
	tx FossilizeName ; name
	tx FossilizeDescription ; description
	tx PowerCantBeUsedIfStatusDescription ; description (cont)
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
	tx SharpClawsName ; name
	tx SharpClawsDescription ; description
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
	tx ShellfishName ; category
	db DEX_KABUTO ; Pokedex number
	db FALSE ; is Dark
	db 22 ; level
	length 0.5 ; length
	weight 11.5 ; weight
	tx KabutoLv22Description ; description
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
	tx SharpSickleName ; name
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
	tx AbsorbName ; name
	tx MegaDrainDescription ; description
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
	tx ShellfishName ; category
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
	tx PrehistoricPowerName ; name
	tx PrehistoricPowerDescription ; description
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

	db 2 ; retreat cost
	db WR_GRASS ; weakness
	db WR_FIGHTING ; resistance
	tx FossilName ; category
	db DEX_AERODACTYL ; Pokedex number
	db FALSE ; is Dark
	db 28 ; level
	length 1.8 ; length
	weight 59.0 ; weight
	tx AerodactylLv28Description ; description
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
	tx SupersonicName ; name
	tx MayInflictConfusionDescription ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db DAMAGE_NORMAL ; category
	dw EffectCommands_58ef0 ; effect commands
	db INFLICT_CONFUSION  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_SUPERSONIC_COPY ; animation

	; attack 2
	energy COLORLESS, 3 ; energies
	tx TailspinAttackName ; name
	tx TailspinAttackDescription ; description
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
	tx FossilName ; category
	db DEX_AERODACTYL ; Pokedex number
	db FALSE ; is Dark
	db 30 ; level
	length 1.8 ; length
	weight 59.0 ; weight
	tx AerodactylLv30Description ; description
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
	tx PsychicBeamName ; name
	tx PsychicBeamDescription ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db RESIDUAL ; category
	dw EffectCommands_58cda ; effect commands
	db DAMAGE_TO_OPPONENT_BENCH  ; flags 1
	db FLAG_2_BIT_6  ; flags 2
	db FLAG_3_BIT_2  ; flags 3
	db 0 ; ?
	db ATK_ANIM_PSYBEAM ; animation

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
	tx PsyshockName ; category
	db DEX_ABRA ; Pokedex number
	db FALSE ; is Dark
	db 8 ; level
	length 0.9 ; length
	weight 19.5 ; weight
	tx AbraLv8Description ; description
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
	tx PsyshockName ; name
	tx MayInflictParalysisDescription ; description
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
	tx PsyshockName ; category
	db DEX_ABRA ; Pokedex number
	db FALSE ; is Dark
	db 10 ; level
	length 0.9 ; length
	weight 19.5 ; weight
	tx AbraLv10Description ; description
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
	tx VanishName ; name
	tx VanishDescription ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db RESIDUAL ; category
	dw EffectCommands_58a34 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db SPECIAL_AI_HANDLING | FLAG_3_BIT_2  ; flags 3
	db 0 ; ?
	db ATK_ANIM_TELEPORT ; animation

	; attack 2
	energy PSYCHIC, 1 ; energies
	tx PsyshockName ; name
	tx MayInflictParalysisAltDescription ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_NORMAL ; category
	dw EffectCommands_58a3f ; effect commands
	db INFLICT_PARALYSIS  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_PSYSHOCK ; animation

	db 1 ; retreat cost
	db WR_PSYCHIC ; weakness
	db NONE ; resistance
	tx PsyshockName ; category
	db DEX_ABRA ; Pokedex number
	db FALSE ; is Dark
	db 14 ; level
	length 0.9 ; length
	weight 19.5 ; weight
	tx AbraLv14Description ; description
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
	tx RecoverName ; name
	tx RecoverPsychicDescription ; description
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

	db 3 ; retreat cost
	db WR_PSYCHIC ; weakness
	db NONE ; resistance
	tx PsyshockName ; category
	db DEX_KADABRA ; Pokedex number
	db FALSE ; is Dark
	db 38 ; level
	length 1.3 ; length
	weight 56.5 ; weight
	tx KadabraLv38Description ; description
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
	tx PsychoPanicName ; name
	tx PsychoPanicDescription ; description
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
	tx BlinkName ; name
	tx BlinkDescription ; description
	dw NONE ; description (cont)
	db 30 ; damage
	db DAMAGE_NORMAL ; category
	dw EffectCommands_58fc6 ; effect commands
	db NONE ; flags 1
	db NULLIFY_OR_WEAKEN_ATTACK  ; flags 2
	db FLAG_3_BIT_2  ; flags 3
	db 0 ; ?
	db ATK_ANIM_BLINK ; animation

	db 3 ; retreat cost
	db WR_PSYCHIC ; weakness
	db NONE ; resistance
	tx PsyshockName ; category
	db DEX_KADABRA ; Pokedex number
	db FALSE ; is Dark
	db 39 ; level
	length 1.3 ; length
	weight 56.5 ; weight
	tx KadabraLv39Description ; description
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
	tx MatterExchangeName ; name
	tx MatterExchangeDescription ; description
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
	tx MindShockName ; name
	tx MindShockDescription ; description
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
	tx PsyshockName ; category
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
	tx DamageSwapName ; name
	tx DamageSwapDescription ; description
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
	tx ConfuseRayName ; name
	tx MayInflictConfusionAltDescription ; description
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
	tx PsyshockName ; category
	db DEX_ALAKAZAM ; Pokedex number
	db FALSE ; is Dark
	db 42 ; level
	length 1.5 ; length
	weight 48.0 ; weight
	tx AlakazamLv42Description ; description
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
	tx PsychoPanicName ; name
	tx PsychoPanicDescription ; description
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
	tx TransDamageName ; name
	tx TransDamageDescription ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db DAMAGE_NORMAL ; category
	dw EffectCommands_58fd3 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db SPECIAL_AI_HANDLING  ; flags 3
	db 0 ; ?
	db ATK_ANIM_TRANS_DAMAGE ; animation

	db 3 ; retreat cost
	db WR_PSYCHIC ; weakness
	db NONE ; resistance
	tx PsyshockName ; category
	db DEX_ALAKAZAM ; Pokedex number
	db FALSE ; is Dark
	db 45 ; level
	length 1.5 ; length
	weight 48.0 ; weight
	tx AlakazamLv45Description ; description
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
	tx TeleportBlastName ; name
	tx TeleportBlastDescription ; description
	dw NONE ; description (cont)
	db 30 ; damage
	db DAMAGE_NORMAL ; category
	dw EffectCommands_58a57 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db SPECIAL_AI_HANDLING  ; flags 3
	db 0 ; ?
	db ATK_ANIM_TELEPORT_BLAST ; animation

	; attack 2
	energy PSYCHIC, 3 ; energies
	tx MindShockName ; name
	tx SonicboomAltDescription ; description
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
	tx PsyshockName ; category
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
	energy PSYCHIC, 2 ; energies
	tx AmnesiaName ; name
	tx AmnesiaDescription ; description
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
	tx DopeyName ; category
	db DEX_SLOWPOKE ; Pokedex number
	db FALSE ; is Dark
	db 9 ; level
	length 1.2 ; length
	weight 36.0 ; weight
	tx SlowpokeLv9Description ; description
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
	tx AfternoonNapName ; name
	tx AfternoonNapDescription ; description
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

	db 1 ; retreat cost
	db WR_PSYCHIC ; weakness
	db NONE ; resistance
	tx DopeyName ; category
	db DEX_SLOWPOKE ; Pokedex number
	db FALSE ; is Dark
	db 16 ; level
	length 1.2 ; length
	weight 36.0 ; weight
	tx SlowpokeLv16Description ; description
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
	tx SpacingOutName ; name
	tx SpacingOutDescription ; description
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
	tx ScavengeName ; name
	tx ScavengeDescription ; description
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
	tx DopeyName ; category
	db DEX_SLOWPOKE ; Pokedex number
	db FALSE ; is Dark
	db 18 ; level
	length 1.2 ; length
	weight 36.0 ; weight
	tx SlowpokeLv18Description ; description
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
	tx StrangeBehaviorName ; name
	tx StrangeBehaviorDescription ; description
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
	tx PsyshockName ; name
	tx MayInflictParalysisDescription ; description
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
	tx HermitcrabName ; category
	db DEX_SLOWBRO ; Pokedex number
	db FALSE ; is Dark
	db 26 ; level
	length 1.6 ; length
	weight 78.5 ; weight
	tx SlowbroLv26Description ; description
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
	tx BigYawnName ; name
	tx BigYawnDescription ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db DAMAGE_NORMAL ; category
	dw EffectCommands_59060 ; effect commands
	db INFLICT_SLEEP  ; flags 1
	db NONE ; flags 2
	db SPECIAL_AI_HANDLING | FLAG_3_BIT_2  ; flags 3
	db 0 ; ?
	db ATK_ANIM_BIG_YAWN ; animation

	; attack 2
	energy PSYCHIC, 2 ; energies
	tx BigSnoreName ; name
	tx BigSnoreDescription ; description
	dw NONE ; description (cont)
	db 30 ; damage
	db DAMAGE_NORMAL ; category
	dw EffectCommands_59068 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_BIG_SNORE ; animation

	db 3 ; retreat cost
	db WR_PSYCHIC ; weakness
	db NONE ; resistance
	tx HermitcrabName ; category
	db DEX_SLOWBRO ; Pokedex number
	db FALSE ; is Dark
	db 35 ; level
	length 1.6 ; length
	weight 78.5 ; weight
	tx SlowbroLv35Description ; description
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
	tx ReelInName ; name
	tx ReelInDescription ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db POKEMON_POWER ; category
	dw EffectCommands_58a7b ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_POISON_GAS_COPY ; animation

	; attack 2
	energy PSYCHIC, 2 ; energies
	tx FickleAttackName ; name
	tx IfTailsDoNothingAltDescription ; description
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
	tx HermitcrabName ; category
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
	tx SleepingGasName ; name
	tx MayInflictSleepAltDescription ; description
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
	tx DestinyBondName ; name
	tx DestinyBondDescription ; description
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
	tx GasName ; category
	db DEX_GASTLY ; Pokedex number
	db FALSE ; is Dark
	db 8 ; level
	length 1.3 ; length
	weight 0.1 ; weight
	tx GastlyLv8Description ; description
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
	tx SpookifyName ; name
	tx SpookifyDescription ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db RESIDUAL ; category
	dw EffectCommands_5906d ; effect commands
	db NONE ; flags 1
	db FLAG_2_BIT_6  ; flags 2
	db FLAG_3_BIT_2  ; flags 3
	db 1 ; ?
	db ATK_ANIM_SPOOKIFY ; animation

	; attack 2
	energy PSYCHIC, 1, COLORLESS, 1 ; energies
	tx FadeToBlackName ; name
	tx MayInflictConfusionDescription ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_NORMAL ; category
	dw EffectCommands_59072 ; effect commands
	db INFLICT_CONFUSION  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_FADE_TO_BLACK ; animation

	db 0 ; retreat cost
	db NONE ; weakness
	db WR_FIGHTING ; resistance
	tx GasName ; category
	db DEX_GASTLY ; Pokedex number
	db FALSE ; is Dark
	db 13 ; level
	length 1.3 ; length
	weight 0.1 ; weight
	tx GastlyLv13Description ; description
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
	tx LickName ; name
	tx MayInflictParalysisDescription ; description
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
	tx EnergyConversionName ; name
	tx EnergyConversionDescription ; description
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
	tx GasName ; category
	db DEX_GASTLY ; Pokedex number
	db FALSE ; is Dark
	db 17 ; level
	length 1.3 ; length
	weight 0.1 ; weight
	tx GastlyLv17Description ; description
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
	tx TransparencyName ; name
	tx TransparencyDescription ; description
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
	tx NightmareName ; name
	tx InflictSleepDescription ; description
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
	tx GasName ; category
	db DEX_HAUNTER ; Pokedex number
	db FALSE ; is Dark
	db 17 ; level
	length 1.6 ; length
	weight 0.1 ; weight
	tx HaunterSharedDescription1 ; description
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
	tx HypnosisMoveName ; name
	tx InflictSleepDescription ; description
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
	tx DreamEaterName ; name
	tx DreamEaterDescription ; description
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
	tx GasName ; category
	db DEX_HAUNTER ; Pokedex number
	db FALSE ; is Dark
	db 22 ; level
	length 1.6 ; length
	weight 0.1 ; weight
	tx HaunterSharedDescription1 ; description
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
	tx EerieLightName ; name
	tx MayInflictConfusionDescription ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db DAMAGE_NORMAL ; category
	dw EffectCommands_59084 ; effect commands
	db INFLICT_CONFUSION  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_EERIE_LIGHT ; animation

	; attack 2
	energy PSYCHIC, 2 ; energies
	tx GrudgeName ; name
	tx GrudgeDescription ; description
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
	tx GasName ; category
	db DEX_HAUNTER ; Pokedex number
	db FALSE ; is Dark
	db 25 ; level
	length 1.6 ; length
	weight 0.1 ; weight
	tx HaunterSharedDescription2 ; description
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
	tx PoltergeistName ; name
	tx PoltergeistDescription ; description
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
	tx BadDreamsName ; name
	tx BadDreamsDescription ; description
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
	tx GasName ; category
	db DEX_HAUNTER ; Pokedex number
	db FALSE ; is Dark
	db 26 ; level
	length 1.6 ; length
	weight 0.1 ; weight
	tx HaunterSharedDescription2 ; description
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
	tx BotherName ; name
	tx BotherDescription ; description
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
	tx GasName ; category
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
	tx CurseName ; name
	tx CurseDescription ; description
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
	tx DarkMindName ; name
	tx Do10DamageToABenchedMonDescription ; description
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
	tx ShadowName ; category
	db DEX_GENGAR ; Pokedex number
	db FALSE ; is Dark
	db 38 ; level
	length 1.5 ; length
	weight 40.5 ; weight
	tx GengarLv38Description ; description
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
	tx PowerOfDarknessName ; name
	tx PowerOfDarknessDescription ; description
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
	tx PsyHorrorName ; name
	tx BadDreamsDescription ; description
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
	tx ShadowName ; category
	db DEX_GENGAR ; Pokedex number
	db FALSE ; is Dark
	db 40 ; level
	length 1.5 ; length
	weight 40.5 ; weight
	tx GengarLv40Description ; description
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
	tx PlayTricksName ; name
	tx PlayTricksDescription ; description
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
	tx PushAsideName ; name
	tx PushAsideDescription ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db RESIDUAL ; category
	dw EffectCommands_592f0 ; effect commands
	db NONE ; flags 1
	db FLAG_2_BIT_6  ; flags 2
	db FLAG_3_BIT_2  ; flags 3
	db 1 ; ?
	db ATK_ANIM_PUSH_ASIDE ; animation

	db 2 ; retreat cost
	db NONE ; weakness
	db WR_FIGHTING ; resistance
	tx ShadowName ; category
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
	tx LongDistanceHypnosisName ; name
	tx LongDistanceHypnosisDescription ; description
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
	tx NightmareName ; name
	tx InflictSleepDescription ; description
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
	tx HypnosisCategoryName ; category
	db DEX_DROWZEE ; Pokedex number
	db FALSE ; is Dark
	db 10 ; level
	length 1.0 ; length
	weight 32.4 ; weight
	tx DrowzeeLv10Description ; description
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

	; attack 2
	energy PSYCHIC, 2 ; energies
	tx ConfuseRayName ; name
	tx MayInflictConfusionAltDescription ; description
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
	tx HypnosisCategoryName ; category
	db DEX_DROWZEE ; Pokedex number
	db FALSE ; is Dark
	db 12 ; level
	length 1.0 ; length
	weight 32.4 ; weight
	tx DrowzeeLv12Description ; description
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
	tx PuppetMasterName ; name
	tx PuppetMasterDescription ; description
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
	tx MindShockName ; name
	tx SonicboomAltDescription ; description
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
	tx HypnosisCategoryName ; category
	db DEX_HYPNO ; Pokedex number
	db FALSE ; is Dark
	db 30 ; level
	length 1.6 ; length
	weight 75.6 ; weight
	tx HypnoLv30Description ; description
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
	tx ProphecyName ; name
	tx ProphecyDescription ; description
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
	tx DarkMindName ; name
	tx Do10DamageToABenchedMonDescription ; description
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
	tx HypnosisCategoryName ; category
	db DEX_HYPNO ; Pokedex number
	db FALSE ; is Dark
	db 36 ; level
	length 1.6 ; length
	weight 75.6 ; weight
	tx HypnoLv36Description ; description
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
	tx PsypunchName ; name
	dw NONE ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_NORMAL ; category
	dw NONE ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_PSYPUNCH ; animation

	; attack 2
	energy PSYCHIC, 2, COLORLESS, 1 ; energies
	tx BenchManipulationName ; name
	tx BenchManipulationDescription ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_X ; category
	dw EffectCommands_58a9b ; effect commands
	db NONE ; flags 1
	db FLAG_2_BIT_6  ; flags 2
	db NONE ; flags 3
	db 1 ; ?
	db ATK_ANIM_BENCH_MANIPULATION ; animation

	db 2 ; retreat cost
	db WR_PSYCHIC ; weakness
	db NONE ; resistance
	tx HypnosisCategoryName ; category
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
	tx DampeningShieldName ; name
	tx DampeningShieldDescription ; description
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
	tx JugglingName ; name
	tx JugglingDescription ; description
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
	tx BarrierName ; category
	db DEX_MR_MIME ; Pokedex number
	db FALSE ; is Dark
	db 20 ; level
	length 1.3 ; length
	weight 54.5 ; weight
	tx MrMimeLv20Description ; description
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
	tx InvisibleWallName ; name
	tx InvisibleWallDescription ; description
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
	tx MeditateName ; name
	tx MeditateDescription ; description
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
	tx BarrierName ; category
	db DEX_MR_MIME ; Pokedex number
	db FALSE ; is Dark
	db 28 ; level
	length 1.3 ; length
	weight 54.5 ; weight
	tx MrMimeLv28Description ; description
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
	tx IcePunchName ; name
	tx MayInflictParalysisAltDescription ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_NORMAL ; category
	dw EffectCommands_58ec6 ; effect commands
	db INFLICT_PARALYSIS  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_ICE_PUNCH ; animation

	; attack 2
	energy WATER, 2 ; energies
	tx ColdBreathName ; name
	tx MayInflictSleepDescription ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_NORMAL ; category
	dw EffectCommands_58ecb ; effect commands
	db INFLICT_SLEEP  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_COLD_BREATH ; animation

	db 1 ; retreat cost
	db WR_PSYCHIC ; weakness
	db NONE ; resistance
	tx HumanShapeName ; category
	db DEX_JYNX ; Pokedex number
	db FALSE ; is Dark
	db 18 ; level
	length 1.4 ; length
	weight 40.6 ; weight
	tx JynxLv18Description ; description
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
	tx DoubleSlapName ; name
	tx Plus10DamagePerHeadsDescription ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_X ; category
	dw EffectCommands_58589 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_SLAP ; animation

	; attack 2
	energy PSYCHIC, 2, COLORLESS, 1 ; energies
	tx MeditateName ; name
	tx MeditateDescription ; description
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
	tx HumanShapeName ; category
	db DEX_JYNX ; Pokedex number
	db FALSE ; is Dark
	db 23 ; level
	length 1.4 ; length
	weight 40.6 ; weight
	tx JynxLv23Description ; description
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

	; attack 2
	energy PSYCHIC, 1, COLORLESS, 1 ; energies
	tx DoubleSlapName ; name
	tx Do20DamageNumberOfHeadsDescription ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_X ; category
	dw EffectCommands_5928b ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_SLAP ; animation

	db 2 ; retreat cost
	db WR_PSYCHIC ; weakness
	db NONE ; resistance
	tx HumanShapeName ; category
	db DEX_JYNX ; Pokedex number
	db FALSE ; is Dark
	db 27 ; level
	length 1.4 ; length
	weight 40.6 ; weight
	tx JynxLv27Description ; description
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
	tx EnergySpikeName ; name
	tx EnergyControlDescription ; description
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
	tx TelekinesisName ; name
	tx TelekinesisDescription ; description
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
	tx GeneticName ; category
	db DEX_MEWTWO ; Pokedex number
	db FALSE ; is Dark
	db 30 ; level
	length 2.0 ; length
	weight 122.0 ; weight
	tx MewtwoLv30Description ; description
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
	tx PsychicName ; name
	tx PsychicDescription ; description
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
	tx BarrierName ; name
	tx BarrierDescription ; description
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
	tx GeneticName ; category
	db DEX_MEWTWO ; Pokedex number
	db FALSE ; is Dark
	db 53 ; level
	length 2.0 ; length
	weight 122.0 ; weight
	tx MewtwoLv53Description ; description
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
	tx PsycrushName ; name
	tx PsycrushDescription ; description
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
	db WR_PSYCHIC ; weakness
	db NONE ; resistance
	tx GeneticName ; category
	db DEX_MEWTWO ; Pokedex number
	db FALSE ; is Dark
	db 54 ; level
	length 2.0 ; length
	weight 122.0 ; weight
	tx MewtwoLv54Description ; description
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
	tx EnergyAbsorptionName ; name
	tx EnergyAbsorptionDescription ; description
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
	tx PsyburnName ; name
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
	tx GeneticName ; category
	db DEX_MEWTWO ; Pokedex number
	db FALSE ; is Dark
	db 60 ; level
	length 2.0 ; length
	weight 122.0 ; weight
	tx MewtwoLv60Description ; description
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
	tx EnergyAbsorptionName ; name
	tx EnergyAbsorptionDescription ; description
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
	tx PsyburnName ; name
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
	tx GeneticName ; category
	db DEX_MEWTWO ; Pokedex number
	db FALSE ; is Dark
	db 60 ; level
	length 2.0 ; length
	weight 122.0 ; weight
	tx MewtwoLv60Description ; description
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
	tx CompleteRecoveryName ; name
	tx CompleteRecoveryDescription ; description
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
	tx PsychoBlastName ; name
	tx PsychoBlastDescription ; description
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
	tx GeneticName ; category
	db DEX_MEWTWO ; Pokedex number
	db FALSE ; is Dark
	db 67 ; level
	length 2.0 ; length
	weight 122.0 ; weight
	tx MewtwoLv67Description ; description
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
	tx DarkWaveName ; name
	tx DarkWaveDescription ; description
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
	tx DarkAmplificationName ; name
	tx DarkAmplificationDescription ; description
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
	tx GeneticName ; category
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
	tx NeutralShieldName ; name
	tx NeutralShieldDescription ; description
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
	tx PsyshockName ; name
	tx MayInflictParalysisAltDescription ; description
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
	tx NewSpeciesName ; category
	db DEX_MEW ; Pokedex number
	db FALSE ; is Dark
	db 8 ; level
	length 0.4 ; length
	weight 4.0 ; weight
	tx MewLv8Description ; description
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
	tx MysteryAttackName ; name
	tx MysteryAttackDescription ; description
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
	tx NewSpeciesName ; category
	db DEX_MEW ; Pokedex number
	db FALSE ; is Dark
	db 15 ; level
	length 0.4 ; length
	weight 4.0 ; weight
	tx MewLv15Description ; description
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
	tx PsywaveName ; name
	tx PsywaveDescription ; description
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
	tx DevolutionBeamName ; name
	tx DevolutionBeamDescription ; description
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
	tx NewSpeciesName ; category
	db DEX_MEW ; Pokedex number
	db FALSE ; is Dark
	db 23 ; level
	length 0.4 ; length
	weight 4.0 ; weight
	tx MewLv23Description ; description
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
	tx WhirlwindName ; name
	tx WhirlwindDescription ; description
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
	tx TinyBirdName ; category
	db DEX_PIDGEY ; Pokedex number
	db FALSE ; is Dark
	db 8 ; level
	length 0.3 ; length
	weight 1.8 ; weight
	tx PidgeyLv8Description ; description
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
	tx GustName ; name
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
	tx QuickAttackName ; name
	tx QuickAttackAltDescription1 ; description
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
	tx TinyBirdName ; category
	db DEX_PIDGEY ; Pokedex number
	db FALSE ; is Dark
	db 10 ; level
	length 0.3 ; length
	weight 1.8 ; weight
	tx PidgeyLv10Description ; description
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
	tx WhirlwindName ; name
	tx WhirlwindDescription ; description
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
	tx MirrorMoveName ; name
	tx MirrorMoveDescription ; description
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
	tx BirdName ; category
	db DEX_PIDGEOTTO ; Pokedex number
	db FALSE ; is Dark
	db 36 ; level
	length 1.1 ; length
	weight 30.0 ; weight
	tx PidgeottoLv36Description ; description
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
	tx TwisterName ; name
	tx TwisterDescription ; description
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
	tx FlyName ; name
	tx FlyAltDescription ; description
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
	tx BirdName ; category
	db DEX_PIDGEOTTO ; Pokedex number
	db FALSE ; is Dark
	db 38 ; level
	length 1.1 ; length
	weight 30.0 ; weight
	tx PidgeottoLv38Description ; description
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
	tx SlicingWingName ; name
	tx SlicingWingDescription ; description
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
	tx GaleName ; name
	tx GaleDescription ; description
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
	tx BirdName ; category
	db DEX_PIDGEOT ; Pokedex number
	db FALSE ; is Dark
	db 38 ; level
	length 1.5 ; length
	weight 39.5 ; weight
	tx PidgeotLv38Description ; description
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
	tx WingAttackName ; name
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
	tx HurricaneName ; name
	tx HurricaneDescription ; description
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
	tx BirdName ; category
	db DEX_PIDGEOT ; Pokedex number
	db FALSE ; is Dark
	db 40 ; level
	length 1.5 ; length
	weight 39.5 ; weight
	tx PidgeotLv40Description ; description
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
	tx MouseName ; category
	db DEX_RATTATA ; Pokedex number
	db FALSE ; is Dark
	db 9 ; level
	length 0.3 ; length
	weight 3.5 ; weight
	tx RattataLv9Description ; description
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
	tx TrickeryName ; name
	tx TrickeryDescription ; description
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
	tx QuickAttackName ; name
	tx IfHeadsDo10DamageDescription ; description
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
	tx MouseName ; category
	db DEX_RATTATA ; Pokedex number
	db FALSE ; is Dark
	db 12 ; level
	length 0.3 ; length
	weight 3.5 ; weight
	tx RattataLv12Description ; description
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
	db ATK_ANIM_HIT ; animation

	; attack 2
	energy COLORLESS, 1 ; energies
	tx TailWhipName ; name
	tx TailWhipDescription ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db DAMAGE_NORMAL ; category
	dw EffectCommands_58c4a ; effect commands
	db NONE ; flags 1
	db NULLIFY_OR_WEAKEN_ATTACK  ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_TAIL_WHIP ; animation

	db 1 ; retreat cost
	db WR_FIGHTING ; weakness
	db WR_PSYCHIC ; resistance
	tx MouseName ; category
	db DEX_RATTATA ; Pokedex number
	db FALSE ; is Dark
	db 15 ; level
	length 0.3 ; length
	weight 3.5 ; weight
	tx RattataLv15Description ; description
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

	; attack 2
	energy COLORLESS, 3 ; energies
	tx SuperFangName ; name
	tx SuperFangDescription ; description
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
	tx MouseName ; category
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
	tx GnawName ; name
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
	tx HyperFangName ; name
	tx IfTailsDoNothingAltDescription ; description
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
	tx MouseName ; category
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
	energy COLORLESS, 2 ; energies
	tx WingAttackName ; name
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
	tx TinyBirdName ; category
	db DEX_SPEAROW ; Pokedex number
	db FALSE ; is Dark
	db 9 ; level
	length 0.3 ; length
	weight 2.0 ; weight
	tx SpearowLv9Description ; description
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
	tx FuryAttackName ; name
	tx Plus10DamagePerHeadsDescription ; description
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
	tx GustName ; name
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
	tx TinyBirdName ; category
	db DEX_SPEAROW ; Pokedex number
	db FALSE ; is Dark
	db 12 ; level
	length 0.3 ; length
	weight 2.0 ; weight
	tx SpearowLv12Description ; description
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
	energy COLORLESS, 3 ; energies
	tx MirrorMoveName ; name
	tx MirrorMoveDescription ; description
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
	tx TinyBirdName ; category
	db DEX_SPEAROW ; Pokedex number
	db FALSE ; is Dark
	db 13 ; level
	length 0.3 ; length
	weight 2.0 ; weight
	tx SpearowLv13Description ; description
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
	tx QuickAttackName ; name
	tx QuickAttackAltDescription1 ; description
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
	tx DrillDescentName ; name
	tx IfTailsDoNothingAltDescription ; description
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
	tx BeakName ; category
	db DEX_FEAROW ; Pokedex number
	db FALSE ; is Dark
	db 24 ; level
	length 1.2 ; length
	weight 38.0 ; weight
	tx FearowLv24Description ; description
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
	tx AgilityName ; name
	tx AgilityDescription ; description
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
	tx DrillPeckName ; name
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
	tx BeakName ; category
	db DEX_FEAROW ; Pokedex number
	db FALSE ; is Dark
	db 27 ; level
	length 1.2 ; length
	weight 38.0 ; weight
	tx FearowLv27Description ; description
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
	tx FlyHighName ; name
	tx FlyHighDescription ; description
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
	tx DrillDiveName ; name
	tx DrillDiveDescription ; description
	dw NONE ; description (cont)
	db 40 ; damage
	db DAMAGE_NORMAL ; category
	dw EffectCommands_5930d ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_DRILL_DIVE ; animation

	db 0 ; retreat cost
	db WR_LIGHTNING ; weakness
	db WR_FIGHTING ; resistance
	tx BeakName ; category
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
	tx SingName ; name
	tx MayInflictSleepAltDescription ; description
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
	tx MetronomeName ; name
	tx MetronomeDescription ; description
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
	tx FairyName ; category
	db DEX_CLEFAIRY ; Pokedex number
	db FALSE ; is Dark
	db 14 ; level
	length 0.6 ; length
	weight 7.5 ; weight
	tx ClefairyLv14Description ; description
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
	tx FollowMeName ; name
	tx LureDescription ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db RESIDUAL ; category
	dw EffectCommands_58c73 ; effect commands
	db NONE ; flags 1
	db SWITCH_OPPONENT_POKEMON  ; flags 2
	db FLAG_3_BIT_2  ; flags 3
	db 0 ; ?
	db ATK_ANIM_FOLLOW_ME ; animation

	; attack 2
	energy COLORLESS, 2 ; energies
	tx ShiningFingersName ; name
	tx InflictSleepDescription ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_NORMAL ; category
	dw EffectCommands_58c81 ; effect commands
	db INFLICT_SLEEP  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_SHINING_FINGER ; animation

	db 1 ; retreat cost
	db WR_FIGHTING ; weakness
	db WR_PSYCHIC ; resistance
	tx FairyName ; category
	db DEX_CLEFAIRY ; Pokedex number
	db FALSE ; is Dark
	db 15 ; level
	length 0.6 ; length
	weight 7.5 ; weight
	tx ClefairyLv15Description ; description
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
	tx MetronomeName ; name
	tx MetronomeDescription ; description
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
	tx MinimizeName ; name
	tx MinimizeAltDescription ; description
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
	tx FairyName ; category
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
	tx DarknessVeilName ; name
	tx DarknessVeiDescription ; description
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
	tx DarkSongName ; name
	tx DarkSongDescription ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_NORMAL ; category
	dw EffectCommands_592d8 ; effect commands
	db INFLICT_SLEEP  ; flags 1
	db NONE ; flags 2
	db FLAG_3_BIT_2  ; flags 3
	db 0 ; ?
	db ATK_ANIM_DARK_SONG ; animation

	db 2 ; retreat cost
	db WR_FIGHTING ; weakness
	db WR_PSYCHIC ; resistance
	tx FairyName ; category
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
	tx FirstAidName ; name
	tx FirstAidDescription ; description
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
	tx DoubleEdgeName ; name
	tx Do20DamageToSelfDescription ; description
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
	tx BalloonName ; category
	db DEX_JIGGLYPUFF ; Pokedex number
	db FALSE ; is Dark
	db 12 ; level
	length 0.5 ; length
	weight 5.5 ; weight
	tx JigglypuffLv12Description ; description
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
	tx FriendshipSongName ; name
	tx FriendshipSongDescription ; description
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
	tx ExpandName ; name
	tx ExpandDescription ; description
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
	tx BalloonName ; category
	db DEX_JIGGLYPUFF ; Pokedex number
	db FALSE ; is Dark
	db 13 ; level
	length 0.5 ; length
	weight 5.5 ; weight
	tx JigglypuffLv13Description ; description
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
	tx LullabyName ; name
	tx InflictSleepDescription ; description
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
	tx PoundName ; name
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
	tx BalloonName ; category
	db DEX_JIGGLYPUFF ; Pokedex number
	db FALSE ; is Dark
	db 14 ; level
	length 0.5 ; length
	weight 5.5 ; weight
	tx JigglypuffLv14Description ; description
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
	tx LullabyName ; name
	tx InflictSleepDescription ; description
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
	tx DoTheWaveName ; name
	tx DoTheWaveDescription ; description
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
	tx BalloonName ; category
	db DEX_WIGGLYTUFF ; Pokedex number
	db FALSE ; is Dark
	db 36 ; level
	length 1.0 ; length
	weight 12.0 ; weight
	tx WigglytuffLv36Description ; description
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
	tx HelpingHandName ; name
	tx HelpingHandDescription ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db POKEMON_POWER ; category
	dw EffectCommands_58c86 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_HELPING_HAND ; animation

	; attack 2
	energy COLORLESS, 4 ; energies
	tx ExpandName ; name
	tx ExpandAltDescription ; description
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
	tx BalloonName ; category
	db DEX_WIGGLYTUFF ; Pokedex number
	db FALSE ; is Dark
	db 40 ; level
	length 1.0 ; length
	weight 12.0 ; weight
	tx WigglytuffLv40Description ; description
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
	tx CoinHurlName ; name
	tx CoinHurlDescription ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db RESIDUAL ; category
	dw EffectCommands_58b1a ; effect commands
	db DAMAGE_TO_OPPONENT_BENCH  ; flags 1
	db FLAG_2_BIT_6  ; flags 2
	db FLAG_3_BIT_2  ; flags 3
	db 2 ; ?
	db ATK_ANIM_COIN_HURL ; animation

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
	tx ScratchCatName ; category
	db DEX_MEOWTH ; Pokedex number
	db FALSE ; is Dark
	db 10 ; level
	length 0.4 ; length
	weight 4.2 ; weight
	tx MeowthLv10Description ; description
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
	tx CatPunchName ; name
	tx CatPunchDescription ; description
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
	tx ScratchCatName ; category
	db DEX_MEOWTH ; Pokedex number
	db FALSE ; is Dark
	db 13 ; level
	length 0.4 ; length
	weight 4.2 ; weight
	tx MeowthLv13Description ; description
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
	energy COLORLESS, 1 ; energies
	tx ClearProfitName ; name
	tx ClearProfitDescription ; description
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
	tx ScratchCatName ; category
	db DEX_MEOWTH ; Pokedex number
	db FALSE ; is Dark
	db 14 ; level
	length 0.4 ; length
	weight 4.2 ; weight
	tx MeowthLv14Description ; description
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
	tx PayDayName ; name
	tx PayDayDescription ; description
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
	tx ScratchCatName ; category
	db DEX_MEOWTH ; Pokedex number
	db FALSE ; is Dark
	db 15 ; level
	length 0.4 ; length
	weight 4.2 ; weight
	tx MeowthLv15Description ; description
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
	energy COLORLESS, 2 ; energies
	tx FurySwipesName ; name
	tx FurySwipes10DamageDescription ; description
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
	tx ScratchCatName ; category
	db DEX_MEOWTH ; Pokedex number
	db FALSE ; is Dark
	db 17 ; level
	length 0.4 ; length
	weight 4.2 ; weight
	tx MeowthLv17Description ; description
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
	energy COLORLESS, 3 ; energies
	tx PounceName ; name
	tx PounceDescription ; description
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
	tx ClassyCatName ; category
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
	tx FascinateName ; name
	tx FascinateDescription ; description
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
	tx PoisonClawsName ; name
	tx MayInflictPoisonAltDescription ; description
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
	tx ClassyCatName ; category
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
	tx FascinateName ; name
	tx FascinateDescription ; description
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
	tx PoisonClawsName ; name
	tx MayInflictPoisonAltDescription ; description
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
	tx ClassyCatName ; category
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
	tx LeekSlapName ; name
	tx LeekSlapDescription ; description
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
	tx PotSmashName ; name
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
	tx WildDuckName ; category
	db DEX_FARFETCHD ; Pokedex number
	db FALSE ; is Dark
	db 20 ; level
	length 0.8 ; length
	weight 15.0 ; weight
	tx FarfetchdLv20Description ; description
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
	tx LeekSlapName ; name
	tx LeekSlapAltDescription ; description
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
	tx PotSmashName ; name
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
	tx WildDuckName ; category
	db DEX_FARFETCHD ; Pokedex number
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
	tx GrowlName ; name
	tx GrowlAltDescription2 ; description
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
	tx PeckName ; name
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
	tx TwinBirdName ; category
	db DEX_DODUO ; Pokedex number
	db FALSE ; is Dark
	db 8 ; level
	length 1.4 ; length
	weight 39.2 ; weight
	tx DoduoLv8Description ; description
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
	tx FuryAttackName ; name
	tx Plus10DamagePerHeadsDescription ; description
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
	tx TwinBirdName ; category
	db DEX_DODUO ; Pokedex number
	db FALSE ; is Dark
	db 10 ; level
	length 1.4 ; length
	weight 39.2 ; weight
	tx DoduoLv10Description ; description
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
	db ATK_ANIM_HIT ; animation

	; attack 2
	energy COLORLESS, 3 ; energies
	tx TriAttackName ; name
	tx FurySwipes20DamageDescription ; description
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
	tx TripleBirdName ; category
	db DEX_DODRIO ; Pokedex number
	db FALSE ; is Dark
	db 25 ; level
	length 1.8 ; length
	weight 85.2 ; weight
	tx DodrioLv25Description ; description
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
	tx RetreatAidName ; name
	tx RetreatAidDescription ; description
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
	tx RageName ; name
	tx RageDescription ; description
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
	tx TripleBirdName ; category
	db DEX_DODRIO ; Pokedex number
	db FALSE ; is Dark
	db 28 ; level
	length 1.8 ; length
	weight 85.2 ; weight
	tx DodrioLv28Description ; description
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
	tx LickAltName ; name
	tx MayInflictParalysisAltDescription ; description
	dw NONE ; description (cont)
	db 0 ; damage
	db DAMAGE_NORMAL ; category
	dw EffectCommands_58d16 ; effect commands
	db INFLICT_PARALYSIS  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_LICK ; animation

	; attack 2
	energy COLORLESS, 2 ; energies
	tx StompName ; name
	tx IfHeadsDo10DamageDescription ; description
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
	tx LickingName ; category
	db DEX_LICKITUNG ; Pokedex number
	db FALSE ; is Dark
	db 20 ; level
	length 1.2 ; length
	weight 65.5 ; weight
	tx LickitungLv20Description ; description
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
	tx TongueWrapName ; name
	tx MayInflictParalysisDescription ; description
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
	tx SupersonicName ; name
	tx MayInflictConfusionAltDescription ; description
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
	tx LickingName ; category
	db DEX_LICKITUNG ; Pokedex number
	db FALSE ; is Dark
	db 26 ; level
	length 1.2 ; length
	weight 65.5 ; weight
	tx LickitungLv26Description ; description
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
	tx SingName ; name
	tx MayInflictSleepDescription ; description
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
	tx DoubleSlapAltName ; name
	tx Do20DamageNumberOfHeadsDescription ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_X ; category
	dw EffectCommands_58d28 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_SLAP ; animation

	db 1 ; retreat cost
	db WR_FIGHTING ; weakness
	db WR_PSYCHIC ; resistance
	tx EggName ; category
	db DEX_CHANSEY ; Pokedex number
	db FALSE ; is Dark
	db 40 ; level
	length 1.1 ; length
	weight 34.6 ; weight
	tx ChanseyLv40Description ; description
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
	tx ScrunchName ; name
	tx PreventDamageCardEffectDescription ; description
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
	tx DoubleEdgeName ; name
	tx Do80DamageToSelfDescription ; description
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
	tx EggName ; category
	db DEX_CHANSEY ; Pokedex number
	db FALSE ; is Dark
	db 55 ; level
	length 1.1 ; length
	weight 34.6 ; weight
	tx ChanseyLv55Description ; description
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

	; attack 2
	energy COLORLESS, 3 ; energies
	tx TailDropName ; name
	tx IfEitherTailsDoNothingDescription ; description
	dw NONE ; description (cont)
	db 80 ; damage
	db DAMAGE_NORMAL ; category
	dw EffectCommands_590f7 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_TAIL_SLAP ; animation

	db 3 ; retreat cost
	db WR_FIGHTING ; weakness
	db WR_PSYCHIC ; resistance
	tx ParentName ; category
	db DEX_KANGASKHAN ; Pokedex number
	db FALSE ; is Dark
	db 36 ; level
	length 2.2 ; length
	weight 80.0 ; weight
	tx KangaskhanLv36Description ; description
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
	tx DizzyPunchName ; name
	tx Plus10DamagePerHeadsDescription ; description
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

	db 3 ; retreat cost
	db WR_FIGHTING ; weakness
	db WR_PSYCHIC ; resistance
	tx ParentName ; category
	db DEX_KANGASKHAN ; Pokedex number
	db FALSE ; is Dark
	db 38 ; level
	length 2.2 ; length
	weight 80.0 ; weight
	tx KangaskhanLv38Description ; description
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
	tx FetchName ; name
	tx FetchDescription ; description
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
	tx CometPunchName ; name
	tx PinMissileDescription ; description
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
	tx ParentName ; category
	db DEX_KANGASKHAN ; Pokedex number
	db FALSE ; is Dark
	db 40 ; level
	length 2.2 ; length
	weight 80.0 ; weight
	tx KangaskhanLv40Description ; description
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
	tx StompName ; name
	tx StompDescription ; description
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
	tx RampageName ; name
	tx RampageDescription ; description
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
	tx WildBullName ; category
	db DEX_TAUROS ; Pokedex number
	db FALSE ; is Dark
	db 32 ; level
	length 1.4 ; length
	weight 88.4 ; weight
	tx TaurosLv32Description ; description
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
	tx KickingAndStampingName ; name
	tx KickingAndStampingDescription ; description
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
	tx WildBullName ; category
	db DEX_TAUROS ; Pokedex number
	db FALSE ; is Dark
	db 35 ; level
	length 1.4 ; length
	weight 88.4 ; weight
	tx TaurosLv35Description ; description
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

	; attack 2
	energy COLORLESS, 3 ; energies
	tx MorphName ; name
	tx MorphDescription ; description
	tx MorphDescriptionCont ; description (cont)
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
	tx TransformName ; category
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
	energy COLORLESS, 1 ; energies
	tx LungeName ; name
	tx IfTailsDoNothingAltDescription ; description
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
	tx EvolutionName ; category
	db DEX_EEVEE ; Pokedex number
	db FALSE ; is Dark
	db 5 ; level
	length 0.3 ; length
	weight 6.5 ; weight
	tx EeveeLv5Description ; description
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
	energy COLORLESS, 2 ; energies
	tx SandAttackName ; name
	tx SandAttackDescription ; description
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
	tx EvolutionName ; category
	db DEX_EEVEE ; Pokedex number
	db FALSE ; is Dark
	db 9 ; level
	length 0.3 ; length
	weight 6.5 ; weight
	tx EeveeLv9Description ; description
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
	tx TailWhipName ; name
	tx LeerDescription ; description
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
	tx QuickAttackName ; name
	tx QuickAttackDescription ; description
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
	tx EvolutionName ; category
	db DEX_EEVEE ; Pokedex number
	db FALSE ; is Dark
	db 12 ; level
	length 0.3 ; length
	weight 6.5 ; weight
	tx EeveeLv12Description ; description
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
	tx Conversion1Name ; name
	tx Conversion1Description ; description
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
	tx Conversion2Name ; name
	tx Conversion2Description ; description
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
	tx VirtualName ; category
	db DEX_PORYGON ; Pokedex number
	db FALSE ; is Dark
	db 12 ; level
	length 0.8 ; length
	weight 36.5 ; weight
	tx PorygonLv12Description ; description
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
	tx Porygon3DAttackName ; name
	tx Porygon3DAttack10DamageDescription ; description
	dw NONE ; description (cont)
	db 10 ; damage
	db DAMAGE_X ; category
	dw EffectCommands_58d4d ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_3D_ATTACK ; animation

	; attack 2
	energy COLORLESS, 2 ; energies
	tx Conversion2Name ; name
	tx Conversion2Description ; description
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
	tx VirtualName ; category
	db DEX_PORYGON ; Pokedex number
	db FALSE ; is Dark
	db 18 ; level
	length 0.8 ; length
	weight 36.5 ; weight
	tx PorygonSharedDescription ; description
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
	tx Conversion1Name ; name
	tx Conversion1AltDescription ; description
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
	tx PsybeamName ; name
	tx MayInflictConfusionDescription ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_NORMAL ; category
	dw EffectCommands_58b5a ; effect commands
	db INFLICT_CONFUSION  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_PSYBEAM ; animation

	db 0 ; retreat cost
	db WR_FIGHTING ; weakness
	db WR_PSYCHIC ; resistance
	tx VirtualName ; category
	db DEX_PORYGON ; Pokedex number
	db FALSE ; is Dark
	db 20 ; level
	length 0.8 ; length
	weight 36.5 ; weight
	tx PorygonLv20Description ; description
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
	tx TextureMagicName ; name
	tx TextureMagicDescription ; description
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
	tx Porygon3DAttackName ; name
	tx Porygon3DAttack20DamageDescription ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_X ; category
	dw EffectCommands_591a9 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_3D_ATTACK ; animation

	db 1 ; retreat cost
	db WR_FIGHTING ; weakness
	db WR_PSYCHIC ; resistance
	tx VirtualName ; category
	db DEX_PORYGON ; Pokedex number
	db FALSE ; is Dark
	db 15 ; level
	length 0.8 ; length
	weight 36.5 ; weight
	tx PorygonSharedDescription ; description
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
	tx ThickSkinnedName ; name
	tx ThickSkinnedDescription ; description
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
	tx BodySlamName ; name
	tx MayInflictParalysisDescription ; description
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
	tx SleepingName ; category
	db DEX_SNORLAX ; Pokedex number
	db FALSE ; is Dark
	db 20 ; level
	length 2.1 ; length
	weight 460.0 ; weight
	tx SnorlaxLv20Description ; description
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
	tx GuardName ; name
	tx GuardDescription ; description
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
	tx RollOverName ; name
	tx RollOverDescription ; description
	dw NONE ; description (cont)
	db 30 ; damage
	db DAMAGE_NORMAL ; category
	dw EffectCommands_58d68 ; effect commands
	db INFLICT_SLEEP  ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_ROLL_OVER ; animation

	db 4 ; retreat cost
	db WR_FIGHTING ; weakness
	db WR_PSYCHIC ; resistance
	tx SleepingName ; category
	db DEX_SNORLAX ; Pokedex number
	db FALSE ; is Dark
	db 35 ; level
	length 2.1 ; length
	weight 460.0 ; weight
	tx SnorlaxLv35Description ; description
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
	tx EatName ; name
	tx EatDescription ; description
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
	tx RolloutName ; name
	tx RolloutDescription ; description
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
	tx SleepingName ; category
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
	tx DragonName ; category
	db DEX_DRATINI ; Pokedex number
	db FALSE ; is Dark
	db 10 ; level
	length 1.8 ; length
	weight 3.3 ; weight
	tx DratiniLv10Description ; description
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
	tx WrapName ; name
	tx MayInflictParalysisAltDescription ; description
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
	tx DragonName ; category
	db DEX_DRATINI ; Pokedex number
	db FALSE ; is Dark
	db 12 ; level
	length 1.8 ; length
	weight 3.3 ; weight
	tx DratiniLv12Description ; description
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
	tx SlamName ; name
	tx Do30DamageNumberOfHeadsDescription ; description
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
	tx HyperBeamName ; name
	tx HyperBeamDescription ; description
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
	tx DragonName ; category
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
	tx EvolutionaryLightName ; name
	tx EvolutionaryLightDescription ; description
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
	tx TailStrikeName ; name
	tx QuickAttackAltDescription1 ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_PLUS ; category
	dw EffectCommands_58b6f ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_TAIL_SLAP ; animation

	db 2 ; retreat cost
	db NONE ; weakness
	db WR_PSYCHIC ; resistance
	tx DragonName ; category
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
	tx HealingWindName ; name
	tx HealingWindDescription ; description
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
	tx SlamName ; name
	tx Do30DamageNumberOfHeadsDescription ; description
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
	tx DragonName ; category
	db DEX_DRAGONITE ; Pokedex number
	db FALSE ; is Dark
	db 41 ; level
	length 2.2 ; length
	weight 210.0 ; weight
	tx DragoniteLv41Description ; description
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
	tx SpecialDeliveryName ; name
	tx SpecialDeliveryDescription ; description
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
	tx SupersonicFlightName ; name
	tx IfTailsDoNothingAltDescription ; description
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
	tx DragonName ; category
	db DEX_DRAGONITE ; Pokedex number
	db FALSE ; is Dark
	db 43 ; level
	length 2.2 ; length
	weight 210.0 ; weight
	tx DragoniteSharedDescription ; description
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
	tx StepInName ; name
	tx StepInDescription ; description
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
	tx SlamName ; name
	tx SlamDescription ; description
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
	tx DragonName ; category
	db DEX_DRAGONITE ; Pokedex number
	db FALSE ; is Dark
	db 45 ; level
	length 2.2 ; length
	weight 210.0 ; weight
	tx DragoniteSharedDescription ; description
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
	tx SummonMinionsName ; name
	tx SummonMinionsDescription ; description
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
	tx GiantTailName ; name
	tx IfTailsDoNothingAltDescription ; description
	dw NONE ; description (cont)
	db 70 ; damage
	db DAMAGE_NORMAL ; category
	dw EffectCommands_58b82 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_TAIL_SLAP ; animation

	db 2 ; retreat cost
	db NONE ; weakness
	db WR_FIGHTING ; resistance
	tx DragonName ; category
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
	tx SnivelName ; name
	tx SnivelAltDescription ; description
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
	tx MetronomeName ; name
	tx MetronomeCoinTossDescription ; description
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
	tx SpikeBallName ; category
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
	tx AeroblastName ; name
	tx AeroblastDescription ; description
	dw NONE ; description (cont)
	db 20 ; damage
	db DAMAGE_PLUS ; category
	dw EffectCommands_59348 ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_AEROBLAST ; animation

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
	tx DivingName ; category
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

MaintenanceCard:
	db TYPE_TRAINER ; type
	dw $b4d2 ; gfx
	tx MaintenanceName ; name
	db DIAMOND ; rarity
	db BASE_SET ; real set
	db SKY_FLYING_POKEMON ; in-game set
	dw MAINTENANCE
	dw EffectCommands_59451 ; effect commands
	tx MaintenanceDescription ; description
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
	db WHITESTAR ; rarity
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
