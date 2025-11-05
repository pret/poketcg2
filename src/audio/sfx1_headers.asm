NumberOfSFX1:
	db NUM_SFX

SFXHeaderPointers1:
	dw SfxStop
	dw Sfx_Cursor
	dw Sfx_Confirm
	dw Sfx_Cancel
	dw Sfx_Denied
	dw Sfx_Jingle
	dw Sfx06
	dw Sfx_CardShuffle
	dw Sfx_PlacePrize
	dw Sfx09
	dw Sfx0a
	dw Sfx_CoinToss
	dw Sfx_Warp
	dw Sfx0d
	dw Sfx0e
	dw Sfx_Doors
	dw Sfx_Tcg1_LegendaryCards
	dw Sfx_Glow
	dw Sfx_Paralysis
	dw Sfx_Sleep
	dw Sfx_Confusion
	dw Sfx_Poison
	dw Sfx_SmallHit
	dw Sfx_Hit
	dw Sfx_ThunderShock
	dw Sfx_Lightning
	dw Sfx_BorderSpark
	dw Sfx_BigLightning
	dw Sfx_SmallFlame
	dw Sfx_BigFlame
	dw Sfx_FireSpin
	dw Sfx_DiveBomb
	dw Sfx_WaterJets
	dw Sfx_WaterGun
	dw Sfx_Whirlpool
	dw Sfx_HydroPump
	dw Sfx_Blizzard
	dw Sfx_Psychic
	dw Sfx_Leer
	dw Sfx_Beam
	dw Sfx_HyperBeam
	dw Sfx_Avalanche
	dw Sfx_StoneBarrage
	dw Sfx_Punch
	dw Sfx_StretchKick
	dw Sfx_Slash
	dw Sfx_SonicBoom
	dw Sfx_FurySwipes
	dw Sfx_Drill
	dw Sfx_PotSmash
	dw Sfx_Bonemerang
	dw Sfx_SeismicToss
	dw Sfx_Needles
	dw Sfx_WhiteGas
	dw Sfx_Powder
	dw Sfx_Goo
	dw Sfx_Bubbles
	dw Sfx_StringShot
	dw Sfx_Boyfriends
	dw Sfx_Lure
	dw Sfx_Toxic
	dw Sfx_ConfuseRay
	dw Sfx_Sing
	dw Sfx_Supersonic
	dw Sfx_PetalDance
	dw Sfx_Protect
	dw Sfx_Barrier
	dw Sfx_Speed
	dw Sfx_Whirlwind
	dw Sfx_Cry
	dw Sfx_QuestionMark
	dw Sfx_SelfDestruct
	dw Sfx_BigSelfDestruct
	dw Sfx_Heal
	dw Sfx_Drain
	dw Sfx_DarkGas
	dw Sfx_HealingWind
	dw Sfx_Whirlwind_Bench
	dw Sfx_Expand
	dw Sfx_CatPunch
	dw Sfx_ThunderWave
	dw Sfx_Firegiver
	dw Sfx_ThunderPunch
	dw Sfx_FirePunch
	dw Sfx_CoinTossPositive
	dw Sfx_CoinTossNegative
	dw Sfx_SaveGame
	dw Sfx_PlayerWalkMap
	dw Sfx_Tcg1_IntroOrb
	dw Sfx_Tcg1_IntroOrbSwoop
	dw Sfx_Tcg1_IntroOrbTitle
	dw Sfx_Tcg1_IntroOrbScatter
	dw Sfx_FiregiverStart
	dw Sfx_ReceiveCardPop
	dw Sfx_PokemonEvolution
	dw Sfx5f
	dw Sfx_Placeholder60
	dw Sfx_Placeholder61
	dw Sfx_Placeholder62
	dw Sfx_Placeholder63
	dw Sfx_Fireball
	dw Sfx_ContinuousFireball
	dw Sfx_BenchManipulation
	dw Sfx_PsychicBeam
	dw Sfx_PsychicBeam_Bench
	dw Sfx_BoulderSmash
	dw Sfx_MegaPunch
	dw Sfx_PsyPunch
	dw Sfx_SludgePunch
	dw Sfx_IcePunch
	dw Sfx_Kick
	dw Sfx_TailSlap
	dw Sfx_TailWhip
	dw Sfx_Slap
	dw Sfx_QuestionMark_Bench
	dw Sfx_SkullBash
	dw Sfx_CoinHurl
	dw Sfx_Teleport
	dw Sfx_FollowMe
	dw Sfx_Swift
	dw Sfx_3dAttack
	dw Sfx_DryUp
	dw Sfx_FocusBlast
	dw Sfx_FocusBlast_Bench
	dw Sfx_ChipsCounting
	dw Sfx_SlotStart
	dw Sfx_SlotReel
	dw Sfx_BlackBoxInsert
	dw Sfx_BlackBoxInserted
	dw Sfx_BlackBoxTransmitted
	dw Sfx_NewMail
	dw Sfx_PodDoors
	dw Sfx_Pitfall
	dw Sfx_OpenChest
	dw Sfx_NpcWarpTransform
	dw Sfx_StrongholdPlatformUp
	dw Sfx_StrongholdPlatformDown
	dw Sfx_GRBlimpHatchClose
	dw Sfx_GRBlimpHatchOpen
	dw Sfx_GRBlimpTractorBeam
	dw Sfx_BoneToss_Bench
	dw Sfx_CoinHurl_Bench
	dw Sfx_BigSnore
	dw Sfx_SlotBigHit
	dw Sfx_SlotBonusHit
	dw Sfx_SlotSmallHit
	dw Sfx_RazorLeaf
	dw Sfx_Guillotine
	dw Sfx_VinePull
	dw Sfx_Perplex
	dw Sfx_NineTails
	dw Sfx_BoneHeadbutt
	dw Sfx_DrillDive
	dw Sfx_DarkSong
	dw Sfx_Tcg2_IntroOrbs
	dw Sfx_Tcg2_IntroTitle
	dw Sfx_Tcg2_IntroSubtitle
	dw Sfx_ElectronicInput
	dw Sfx_ElectronicResponse
	dw Sfx_GhostMasterAppear
	dw Sfx_GhostMasterDisappear

Sfx_Placeholder60:
Sfx_Placeholder61:
Sfx_Placeholder62:
Sfx_Placeholder63:
	db BANK(Sfx_Placeholder60)
	db %0001
	dw Sfx_Placeholder60_Ch1

;SfxUnused
	db BANK(SfxUnused)
	db %0001
	dw SfxUnused_Ch1

SfxStop:
	db BANK(SfxStop)
	db %0000

Sfx_Cursor:
	db BANK(Sfx_Cursor)
	db %0001
	dw Sfx_Cursor_Ch1

Sfx_Confirm:
	db BANK(Sfx_Confirm)
	db %0001
	dw Sfx_Confirm_Ch1

Sfx_Cancel:
	db BANK(Sfx_Cancel)
	db %0001
	dw Sfx_Cancel_Ch1

Sfx_Denied:
	db BANK(Sfx_Denied)
	db %0001
	dw Sfx_Denied_Ch1

Sfx_Jingle:
	db BANK(Sfx_Jingle)
	db %0001
	dw Sfx_Jingle_Ch1

Sfx06:
	db BANK(Sfx06)
	db %0001
	dw Sfx06_Ch1

Sfx_CardShuffle:
	db BANK(Sfx_CardShuffle)
	db %1000
	dw Sfx_CardShuffle_Ch1

Sfx_PlacePrize:
	db BANK(Sfx_PlacePrize)
	db %1000
	dw Sfx_PlacePrize_Ch1

Sfx09:
	db BANK(Sfx09)
	db %1000
	dw Sfx09_Ch1

Sfx0a:
	db BANK(Sfx0a)
	db %0001
	dw Sfx0a_Ch1

Sfx_CoinToss:
	db BANK(Sfx_CoinToss)
	db %0001
	dw Sfx_CoinToss_Ch1

Sfx_Warp:
	db BANK(Sfx_Warp)
	db %1000
	dw Sfx_Warp_Ch1

Sfx0d:
	db BANK(Sfx0d)
	db %0001
	dw Sfx0d_Ch1

Sfx0e:
	db BANK(Sfx0e)
	db %0001
	dw Sfx0e_Ch1

Sfx_Doors:
	db BANK(Sfx_Doors)
	db %1000
	dw Sfx_Doors_Ch1

Sfx_Tcg1_LegendaryCards:
	db BANK(Sfx_Tcg1_LegendaryCards)
	db %0001
	dw Sfx_Tcg1_LegendaryCards_Ch1

Sfx_Glow:
	db BANK(Sfx_Glow)
	db %0001
	dw Sfx_Glow_Ch1

Sfx_Paralysis:
	db BANK(Sfx_Paralysis)
	db %0001
	dw Sfx_Paralysis_Ch1

Sfx_Sleep:
	db BANK(Sfx_Sleep)
	db %0001
	dw Sfx_Sleep_Ch1

Sfx_Confusion:
	db BANK(Sfx_Confusion)
	db %0001
	dw Sfx_Confusion_Ch1

Sfx_Poison:
	db BANK(Sfx_Poison)
	db %0001
	dw Sfx_Poison_Ch1

Sfx_SmallHit:
	db BANK(Sfx_SmallHit)
	db %1000
	dw Sfx_SmallHit_Ch1

Sfx_Hit:
	db BANK(Sfx_Hit)
	db %1000
	dw Sfx_Hit_Ch1

Sfx_ThunderShock:
	db BANK(Sfx_ThunderShock)
	db %1000
	dw Sfx_ThunderShock_Ch1

Sfx_Lightning:
	db BANK(Sfx_Lightning)
	db %1000
	dw Sfx_Lightning_Ch1

Sfx_BorderSpark:
	db BANK(Sfx_BorderSpark)
	db %1000
	dw Sfx_BorderSpark_Ch1

Sfx_BigLightning:
	db BANK(Sfx_BigLightning)
	db %1000
	dw Sfx_BigLightning_Ch1

Sfx_SmallFlame:
	db BANK(Sfx_SmallFlame)
	db %1000
	dw Sfx_SmallFlame_Ch1

Sfx_BigFlame:
	db BANK(Sfx_BigFlame)
	db %1000
	dw Sfx_BigFlame_Ch1

Sfx_FireSpin:
	db BANK(Sfx_FireSpin)
	db %1000
	dw Sfx_FireSpin_Ch1

Sfx_DiveBomb:
	db BANK(Sfx_DiveBomb)
	db %1000
	dw Sfx_DiveBomb_Ch1

Sfx_WaterJets:
	db BANK(Sfx_WaterJets)
	db %1000
	dw Sfx_WaterJets_Ch1

Sfx_WaterGun:
	db BANK(Sfx_WaterGun)
	db %1000
	dw Sfx_WaterGun_Ch1

Sfx_Whirlpool:
	db BANK(Sfx_Whirlpool)
	db %1000
	dw Sfx_Whirlpool_Ch1

Sfx_HydroPump:
	db BANK(Sfx_HydroPump)
	db %1000
	dw Sfx_HydroPump_Ch1

Sfx_Blizzard:
	db BANK(Sfx_Blizzard)
	db %1000
	dw Sfx_Blizzard_Ch1

Sfx_Psychic:
	db BANK(Sfx_Psychic)
	db %0001
	dw Sfx_Psychic_Ch1

Sfx_Leer:
	db BANK(Sfx_Leer)
	db %0001
	dw Sfx_Leer_Ch1

Sfx_Beam:
	db BANK(Sfx_Beam)
	db %0001
	dw Sfx_Beam_Ch1

Sfx_HyperBeam:
	db BANK(Sfx_HyperBeam)
	db %1001
	dw Sfx_HyperBeam_Ch1
	dw Sfx_HyperBeam_Ch2

Sfx_Avalanche:
	db BANK(Sfx_Avalanche)
	db %1000
	dw Sfx_Avalanche_Ch1

Sfx_StoneBarrage:
	db BANK(Sfx_StoneBarrage)
	db %1000
	dw Sfx_StoneBarrage_Ch1

Sfx_Punch:
	db BANK(Sfx_Punch)
	db %0001
	dw Sfx_Punch_Ch1

Sfx_StretchKick:
	db BANK(Sfx_StretchKick)
	db %0001
	dw Sfx_StretchKick_Ch1

Sfx_Slash:
	db BANK(Sfx_Slash)
	db %1000
	dw Sfx_Slash_Ch1

Sfx_SonicBoom:
	db BANK(Sfx_SonicBoom)
	db %1000
	dw Sfx_SonicBoom_Ch1

Sfx_FurySwipes:
	db BANK(Sfx_FurySwipes)
	db %1000
	dw Sfx_FurySwipes_Ch1

Sfx_Drill:
	db BANK(Sfx_Drill)
	db %1000
	dw Sfx_Drill_Ch1

Sfx_PotSmash:
	db BANK(Sfx_PotSmash)
	db %0001
	dw Sfx_PotSmash_Ch1

Sfx_Bonemerang:
	db BANK(Sfx_Bonemerang)
	db %1001
	dw Sfx_Bonemerang_Ch1
	dw Sfx_Bonemerang_Ch2

Sfx_SeismicToss:
	db BANK(Sfx_SeismicToss)
	db %1001
	dw Sfx_SeismicToss_Ch1
	dw Sfx_SeismicToss_Ch2

Sfx_Needles:
	db BANK(Sfx_Needles)
	db %0001
	dw Sfx_Needles_Ch1

Sfx_WhiteGas:
	db BANK(Sfx_WhiteGas)
	db %1000
	dw Sfx_WhiteGas_Ch1

Sfx_Powder:
	db BANK(Sfx_Powder)
	db %0001
	dw Sfx_Powder_Ch1

Sfx_Goo:
	db BANK(Sfx_Goo)
	db %1001
	dw Sfx_Goo_Ch1
	dw Sfx_Goo_Ch2

Sfx_Bubbles:
	db BANK(Sfx_Bubbles)
	db %0001
	dw Sfx_Bubbles_Ch1

Sfx_StringShot:
	db BANK(Sfx_StringShot)
	db %1001
	dw Sfx_StringShot_Ch1
	dw Sfx_StringShot_Ch2

Sfx_Boyfriends:
	db BANK(Sfx_Boyfriends)
	db %0001
	dw Sfx_Boyfriends_Ch1

Sfx_Lure:
	db BANK(Sfx_Lure)
	db %0001
	dw Sfx_Lure_Ch1

Sfx_Toxic:
	db BANK(Sfx_Toxic)
	db %0001
	dw Sfx_Toxic_Ch1

Sfx_ConfuseRay:
	db BANK(Sfx_ConfuseRay)
	db %0001
	dw Sfx_ConfuseRay_Ch1

Sfx_Sing:
	db BANK(Sfx_Sing)
	db %0001
	dw Sfx_Sing_Ch1

Sfx_Supersonic:
	db BANK(Sfx_Supersonic)
	db %1000
	dw Sfx_Supersonic_Ch1

Sfx_PetalDance:
	db BANK(Sfx_PetalDance)
	db %0001
	dw Sfx_PetalDance_Ch1

Sfx_Protect:
	db BANK(Sfx_Protect)
	db %0001
	dw Sfx_Protect_Ch1

Sfx_Barrier:
	db BANK(Sfx_Barrier)
	db %0001
	dw Sfx_Barrier_Ch1

Sfx_Speed:
	db BANK(Sfx_Speed)
	db %1000
	dw Sfx_Speed_Ch1

Sfx_Whirlwind:
	db BANK(Sfx_Whirlwind)
	db %1000
	dw Sfx_Whirlwind_Ch1

Sfx_Cry:
	db BANK(Sfx_Cry)
	db %0001
	dw Sfx_Cry_Ch1

Sfx_QuestionMark:
	db BANK(Sfx_QuestionMark)
	db %0001
	dw Sfx_QuestionMark_Ch1

Sfx_SelfDestruct:
	db BANK(Sfx_SelfDestruct)
	db %1000
	dw Sfx_SelfDestruct_Ch1

Sfx_BigSelfDestruct:
	db BANK(Sfx_BigSelfDestruct)
	db %1000
	dw Sfx_BigSelfDestruct_Ch1

Sfx_Heal:
	db BANK(Sfx_Heal)
	db %0001
	dw Sfx_Heal_Ch1

Sfx_Drain:
	db BANK(Sfx_Drain)
	db %0001
	dw Sfx_Drain_Ch1

Sfx_DarkGas:
	db BANK(Sfx_DarkGas)
	db %1000
	dw Sfx_DarkGas_Ch1

Sfx_HealingWind:
	db BANK(Sfx_HealingWind)
	db %0001
	dw Sfx_HealingWind_Ch1

Sfx_Whirlwind_Bench:
	db BANK(Sfx_Whirlwind_Bench)
	db %0001
	dw Sfx_Whirlwind_Bench_Ch1

Sfx_Expand:
	db BANK(Sfx_Expand)
	db %0001
	dw Sfx_Expand_Ch1

Sfx_CatPunch:
	db BANK(Sfx_CatPunch)
	db %0001
	dw Sfx_CatPunch_Ch1

Sfx_ThunderWave:
	db BANK(Sfx_ThunderWave)
	db %1001
	dw Sfx_ThunderWave_Ch1
	dw Sfx_ThunderWave_Ch2

Sfx_Firegiver:
	db BANK(Sfx_Firegiver)
	db %1001
	dw Sfx_Firegiver_Ch1
	dw Sfx_Firegiver_Ch2

Sfx_ThunderPunch:
	db BANK(Sfx_ThunderPunch)
	db %1001
	dw Sfx_ThunderPunch_Ch1
	dw Sfx_ThunderPunch_Ch2

Sfx_FirePunch:
	db BANK(Sfx_FirePunch)
	db %1001
	dw Sfx_FirePunch_Ch1
	dw Sfx_FirePunch_Ch2

Sfx_CoinTossPositive:
	db BANK(Sfx_CoinTossPositive)
	db %0001
	dw Sfx_CoinTossPositive_Ch1

Sfx_CoinTossNegative:
	db BANK(Sfx_CoinTossNegative)
	db %0001
	dw Sfx_CoinTossNegative_Ch1

Sfx_SaveGame:
	db BANK(Sfx_SaveGame)
	db %0001
	dw Sfx_SaveGame_Ch1

Sfx_PlayerWalkMap:
	db BANK(Sfx_PlayerWalkMap)
	db %0001
	dw Sfx_PlayerWalkMap_Ch1

Sfx_Tcg1_IntroOrb:
	db BANK(Sfx_Tcg1_IntroOrb)
	db %0001
	dw Sfx_Tcg1_IntroOrb_Ch1

Sfx_Tcg1_IntroOrbSwoop:
	db BANK(Sfx_Tcg1_IntroOrbSwoop)
	db %0001
	dw Sfx_Tcg1_IntroOrbSwoop_Ch1

Sfx_Tcg1_IntroOrbTitle:
	db BANK(Sfx_Tcg1_IntroOrbTitle)
	db %0001
	dw Sfx_Tcg1_IntroOrbTitle_Ch1

Sfx_Tcg1_IntroOrbScatter:
	db BANK(Sfx_Tcg1_IntroOrbScatter)
	db %0001
	dw Sfx_Tcg1_IntroOrbScatter_Ch1

Sfx_FiregiverStart:
	db BANK(Sfx_FiregiverStart)
	db %1000
	dw Sfx_FiregiverStart_Ch1

Sfx_ReceiveCardPop:
	db BANK(Sfx_ReceiveCardPop)
	db %1011
	dw Sfx_ReceiveCardPop_Ch1
	dw Sfx_ReceiveCardPop_Ch2
	dw Sfx_ReceiveCardPop_Ch3

Sfx_PokemonEvolution:
	db BANK(Sfx_PokemonEvolution)
	db %0001
	dw Sfx_PokemonEvolution_Ch1

Sfx5f:
	db BANK(Sfx5f)
	db %1000
	dw Sfx5f_Ch1

;Sfx_Fireball
	db BANK(Sfx_Fireball)
	db %1001
	dw Sfx_Fireball_Ch1
	dw Sfx_Fireball_Ch2

;Sfx_ContinuousFireball
	db BANK(Sfx_ContinuousFireball)
	db %1001
	dw Sfx_ContinuousFireball_Ch1
	dw Sfx_ContinuousFireball_Ch2

;Sfx_BenchManipulation
	db BANK(Sfx_BenchManipulation)
	db %0001
	dw Sfx_BenchManipulation_Ch1

;Sfx_PsychicBeam
	db BANK(Sfx_PsychicBeam)
	db %1001
	dw Sfx_PsychicBeam_Ch1
	dw Sfx_PsychicBeam_Ch2

;Sfx_PsychicBeam_Bench
	db BANK(Sfx_PsychicBeam_Bench)
	db %1001
	dw Sfx_PsychicBeam_Bench_Ch1
	dw Sfx_PsychicBeam_Bench_Ch2

;Sfx_BoulderSmash
	db BANK(Sfx_BoulderSmash)
	db %1001
	dw Sfx_BoulderSmash_Ch1
	dw Sfx_BoulderSmash_Ch2

;Sfx_MegaPunch
	db BANK(Sfx_MegaPunch)
	db %1001
	dw Sfx_MegaPunch_Ch1
	dw Sfx_MegaPunch_Ch2

;Sfx_PsyPunch
	db BANK(Sfx_PsyPunch)
	db %0001
	dw Sfx_PsyPunch_Ch1

;Sfx_SludgePunch
	db BANK(Sfx_SludgePunch)
	db %1001
	dw Sfx_SludgePunch_Ch1
	dw Sfx_SludgePunch_Ch2

;Sfx_IcePunch
	db BANK(Sfx_IcePunch)
	db %0001
	dw Sfx_IcePunch_Ch1

;Sfx_Kick
	db BANK(Sfx_Kick)
	db %1001
	dw Sfx_Kick_Ch1
	dw Sfx_Kick_Ch2

;Sfx_TailSlap
	db BANK(Sfx_TailSlap)
	db %1001
	dw Sfx_TailSlap_Ch1
	dw Sfx_TailSlap_Ch2

;Sfx_TailWhip
	db BANK(Sfx_TailWhip)
	db %0001
	dw Sfx_TailWhip_Ch1

;Sfx_Slap
	db BANK(Sfx_Slap)
	db %1001
	dw Sfx_Slap_Ch1
	dw Sfx_Slap_Ch2

;Sfx_QuestionMark_Bench
	db BANK(Sfx_QuestionMark_Bench)
	db %0001
	dw Sfx_QuestionMark_Bench_Ch1

;Sfx_SkullBash
	db BANK(Sfx_SkullBash)
	db %1001
	dw Sfx_SkullBash_Ch1
	dw Sfx_SkullBash_Ch2

;Sfx_CoinHurl
	db BANK(Sfx_CoinHurl)
	db %1001
	dw Sfx_CoinHurl_Ch1
	dw Sfx_CoinHurl_Ch2

;Sfx_Teleport
	db BANK(Sfx_Teleport)
	db %1001
	dw Sfx_Teleport_Ch1
	dw Sfx_Teleport_Ch2

;Sfx_FollowMe
	db BANK(Sfx_FollowMe)
	db %0001
	dw Sfx_FollowMe_Ch1

;Sfx_Swift
	db BANK(Sfx_Swift)
	db %0001
	dw Sfx_Swift_Ch1

;Sfx_3dAttack
	db BANK(Sfx_3dAttack)
	db %0001
	dw Sfx_3dAttack_Ch1

;Sfx_DryUp
	db BANK(Sfx_DryUp)
	db %1000
	dw Sfx_DryUp_Ch1

;Sfx_FocusBlast
	db BANK(Sfx_FocusBlast)
	db %1001
	dw Sfx_FocusBlast_Ch1
	dw Sfx_FocusBlast_Ch2

;Sfx_FocusBlast_Bench
	db BANK(Sfx_FocusBlast_Bench)
	db %1001
	dw Sfx_FocusBlast_Bench_Ch1
	dw Sfx_FocusBlast_Bench_Ch2

;Sfx_ChipsCounting
	db BANK(Sfx_ChipsCounting)
	db %0001
	dw Sfx_ChipsCounting_Ch1

;Sfx_SlotStart
	db BANK(Sfx_SlotStart)
	db %0001
	dw Sfx_SlotStart_Ch1

;Sfx_SlotReel
	db BANK(Sfx_SlotReel)
	db %0001
	dw Sfx_SlotReel_Ch1

;Sfx_BlackBoxInsert
	db BANK(Sfx_BlackBoxInsert)
	db %1000
	dw Sfx_BlackBoxInsert_Ch1

;Sfx_BlackBoxInserted
	db BANK(Sfx_BlackBoxInserted)
	db %0001
	dw Sfx_BlackBoxInserted_Ch1

;Sfx_BlackBoxTransmitted
	db BANK(Sfx_BlackBoxTransmitted)
	db %0001
	dw Sfx_BlackBoxTransmitted_Ch1

;Sfx_NewMail
	db BANK(Sfx_NewMail)
	db %0001
	dw Sfx_NewMail_Ch1

;Sfx_PodDoors
	db BANK(Sfx_PodDoors)
	db %0001
	dw Sfx_PodDoors_Ch1

;Sfx_Pitfall
	db BANK(Sfx_Pitfall)
	db %0001
	dw Sfx_Pitfall_Ch1

;Sfx_OpenChest
	db BANK(Sfx_OpenChest)
	db %0001
	dw Sfx_OpenChest_Ch1

;Sfx_NpcWarpTransform
	db BANK(Sfx_NpcWarpTransform)
	db %0001
	dw Sfx_NpcWarpTransform_Ch1

;Sfx_StrongholdPlatformUp
	db BANK(Sfx_StrongholdPlatformUp)
	db %0001
	dw Sfx_StrongholdPlatformUp_Ch1

;Sfx_StrongholdPlatformDown
	db BANK(Sfx_StrongholdPlatformDown)
	db %0001
	dw Sfx_StrongholdPlatformDown_Ch1

;Sfx_GRBlimpHatchClose
	db BANK(Sfx_GRBlimpHatchClose)
	db %1001
	dw Sfx_GRBlimpHatchClose_Ch1
	dw Sfx_GRBlimpHatchClose_Ch2

;Sfx_GRBlimpHatchOpen
	db BANK(Sfx_GRBlimpHatchOpen)
	db %1001
	dw Sfx_GRBlimpHatchOpen_Ch1
	dw Sfx_GRBlimpHatchOpen_Ch2

;Sfx_GRBlimpTractorBeam
	db BANK(Sfx_GRBlimpTractorBeam)
	db %0001
	dw Sfx_GRBlimpTractorBeam_Ch1

;Sfx_BoneToss_Bench
	db BANK(Sfx_BoneToss_Bench)
	db %1001
	dw Sfx_BoneToss_Bench_Ch1
	dw Sfx_BoneToss_Bench_Ch2

;Sfx_CoinHurl_Bench
	db BANK(Sfx_CoinHurl_Bench)
	db %1001
	dw Sfx_CoinHurl_Bench_Ch1
	dw Sfx_CoinHurl_Bench_Ch2

;Sfx_BigSnore
	db BANK(Sfx_BigSnore)
	db %1001
	dw Sfx_BigSnore_Ch1
	dw Sfx_BigSnore_Ch2

;Sfx_SlotBigHit
	db BANK(Sfx_SlotBigHit)
	db %0001
	dw Sfx_SlotBigHit_Ch1

;Sfx_SlotBonusHit
	db BANK(Sfx_SlotBonusHit)
	db %0001
	dw Sfx_SlotBonusHit_Ch1

;Sfx_SlotSmallHit
	db BANK(Sfx_SlotSmallHit)
	db %0001
	dw Sfx_SlotSmallHit_Ch1

;Sfx_RazorLeaf
	db BANK(Sfx_RazorLeaf)
	db %1000
	dw Sfx_RazorLeaf_Ch1

;Sfx_Guillotine
	db BANK(Sfx_Guillotine)
	db %1001
	dw Sfx_Guillotine_Ch1
	dw Sfx_Guillotine_Ch2

;Sfx_VinePull
	db BANK(Sfx_VinePull)
	db %0001
	dw Sfx_VinePull_Ch1

;Sfx_Perplex
	db BANK(Sfx_Perplex)
	db %0001
	dw Sfx_Perplex_Ch1

;Sfx_NineTails
	db BANK(Sfx_NineTails)
	db %1001
	dw Sfx_NineTails_Ch1
	dw Sfx_NineTails_Ch2

;Sfx_BoneHeadbutt
	db BANK(Sfx_BoneHeadbutt)
	db %1001
	dw Sfx_BoneHeadbutt_Ch1
	dw Sfx_BoneHeadbutt_Ch2

;Sfx_DrillDive
	db BANK(Sfx_DrillDive)
	db %1001
	dw Sfx_DrillDive_Ch1
	dw Sfx_DrillDive_Ch2

;Sfx_DarkSong
	db BANK(Sfx_DarkSong)
	db %0001
	dw Sfx_DarkSong_Ch1

;Sfx_Tcg2_IntroOrbs
	db BANK(Sfx_Tcg2_IntroOrbs)
	db %0001
	dw Sfx_Tcg2_IntroOrbs_Ch1

;Sfx_Tcg2_IntroTitle
	db BANK(Sfx_Tcg2_IntroTitle)
	db %1001
	dw Sfx_Tcg2_IntroTitle_Ch1
	dw Sfx_Tcg2_IntroTitle_Ch2

;Sfx_Tcg2_IntroSubtitle
	db BANK(Sfx_Tcg2_IntroSubtitle)
	db %0001
	dw Sfx_Tcg2_IntroSubtitle_Ch1

;Sfx_ElectronicInput
	db BANK(Sfx_ElectronicInput)
	db %0001
	dw Sfx_ElectronicInput_Ch1

;Sfx_ElectronicResponse
	db BANK(Sfx_ElectronicResponse)
	db %0001
	dw Sfx_ElectronicResponse_Ch1

;Sfx_GhostMasterAppear
	db BANK(Sfx_GhostMasterAppear)
	db %0001
	dw Sfx_GhostMasterAppear_Ch1

;Sfx_GhostMasterDisappear
	db BANK(Sfx_GhostMasterDisappear)
	db %0001
	dw Sfx_GhostMasterDisappear_Ch1
