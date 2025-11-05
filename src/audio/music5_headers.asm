NumberOfSongs5:
	db 60

SongBanks5:
	db BANK(Music_Stop)
	db BANK(Music_TitleScreen)
	db BANK(Music_DuelThemeClubMember)
	db BANK(Music_DuelThemeClubMaster)
	db BANK(Music_DuelThemeGrandMaster)
	db BANK(Music_PauseMenu)
	db BANK(Music_PCMainMenu)
	db BANK(Music_DeckMachine)
	db BANK(Music_CardPop)
	db BANK(Music_Overworld)
	db BANK(Music_PokemonDome)
	db BANK(Music_ChallengeHall)
	db BANK(Music_Club1)
	db BANK(Music_Club2)
	db BANK(Music_Club3)
	db BANK(Music_Ronald)
	db BANK(Music_Imakuni)
	db BANK(Music_HallOfHonor)
	db BANK(Music_Song12)
	db BANK(Music_Song13)
	db BANK(Music_HereComesGR)
	db BANK(Music_GROverworld)
	db BANK(Music_Fort1)
	db BANK(Music_Fort2)
	db BANK(Music_Fort3)
	db BANK(Music_Fort4)
	db BANK(Music_GRCastle)
	db BANK(Music_Song1B)
	db BANK(Music_GRChallengeCup)
	db BANK(Music_GameCenter)
	db BANK(Music_GRBlimp)
	db BANK(Music_DuelThemeGRMember)
	db BANK(Music_DuelThemeGRLeader)
	db BANK(Music_DuelThemeGRKing)
	db BANK(Music_Song22)
	db BANK(Music_Ishihara)
	db BANK(Music_ImakuniRed)
	db BANK(Music_Credits)
	db BANK(Music_Song26)
	db BANK(Music_Song27)
	db BANK(Music_MatchStartMember)
	db BANK(Music_MatchStartClubMaster)
	db BANK(Music_MatchStartGrandMaster)
	db BANK(Music_MatchVictory)
	db BANK(Music_MatchLoss)
	db BANK(Music_MatchDraw)
	db BANK(Music_Unused2E)
	db BANK(Music_BoosterPack)
	db BANK(Music_Medal)
	db BANK(Music_Unused31)
	db BANK(Music_MatchStartGRLeader)
	db BANK(Music_MatchStartGRExecs)
	db BANK(Music_GameCenterPowerOn)
	db BANK(Music_Fanfare1)
	db BANK(Music_Fanfare2)
	db BANK(Music_Sting37)
	db BANK(Music_Sting38)
	db BANK(Music_Sting39)
	db BANK(Music_GrandMasterCupChampion)
	db BANK(Music_Sting3B)

SongHeaderPointers5:
	dw Music_Stop
	dw Music_TitleScreen
	dw Music_DuelThemeClubMember
	dw Music_DuelThemeClubMaster
	dw Music_DuelThemeGrandMaster
	dw Music_PauseMenu
	dw Music_PCMainMenu
	dw Music_DeckMachine
	dw Music_CardPop
	dw Music_Overworld
	dw Music_PokemonDome
	dw Music_ChallengeHall
	dw Music_Club1
	dw Music_Club2
	dw Music_Club3
	dw Music_Ronald
	dw Music_Imakuni
	dw Music_HallOfHonor
	dw Music_Song12
	dw Music_Song13
	dw Music_HereComesGR
	dw Music_GROverworld
	dw Music_Fort1
	dw Music_Fort2
	dw Music_Fort3
	dw Music_Fort4
	dw Music_GRCastle
	dw Music_Song1B
	dw Music_GRChallengeCup
	dw Music_GameCenter
	dw Music_GRBlimp
	dw Music_DuelThemeGRMember
	dw Music_DuelThemeGRLeader
	dw Music_DuelThemeGRKing
	dw Music_Song22
	dw Music_Ishihara
	dw Music_ImakuniRed
	dw Music_Credits
	dw Music_Song26
	dw Music_Song27
	dw Music_MatchStartMember
	dw Music_MatchStartClubMaster
	dw Music_MatchStartGrandMaster
	dw Music_MatchVictory
	dw Music_MatchLoss
	dw Music_MatchDraw
	dw Music_Unused2E
	dw Music_BoosterPack
	dw Music_Medal
	dw Music_Unused31
	dw Music_MatchStartGRLeader
	dw Music_MatchStartGRExecs
	dw Music_GameCenterPowerOn
	dw Music_Fanfare1
	dw Music_Fanfare2
	dw Music_Sting37
	dw Music_Sting38
	dw Music_Sting39
	dw Music_GrandMasterCupChampion
	dw Music_Sting3B

;Music_Stop
	db %0000

;Music_TitleScreen
	db %1111
	dw Music_TitleScreen_Ch1
	dw Music_TitleScreen_Ch2
	dw Music_TitleScreen_Ch3
	dw Music_TitleScreen_Ch4

;Music_DuelThemeClubMember
	db %1111
	dw Music_DuelThemeClubMember_Ch1
	dw Music_DuelThemeClubMember_Ch2
	dw Music_DuelThemeClubMember_Ch3
	dw Music_DuelThemeClubMember_Ch4

;Music_DuelThemeClubMaster
	db %1111
	dw Music_DuelThemeClubMaster_Ch1
	dw Music_DuelThemeClubMaster_Ch2
	dw Music_DuelThemeClubMaster_Ch3
	dw Music_DuelThemeClubMaster_Ch4

;Music_DuelThemeGrandMaster
	db %1111
	dw Music_DuelThemeGrandMaster_Ch1
	dw Music_DuelThemeGrandMaster_Ch2
	dw Music_DuelThemeGrandMaster_Ch3
	dw Music_DuelThemeGrandMaster_Ch4

;Music_PauseMenu
	db %1111
	dw Music_PauseMenu_Ch1
	dw Music_PauseMenu_Ch2
	dw Music_PauseMenu_Ch3
	dw Music_PauseMenu_Ch4

;Music_PCMainMenu
	db %1111
	dw Music_PCMainMenu_Ch1
	dw Music_PCMainMenu_Ch2
	dw Music_PCMainMenu_Ch3
	dw Music_PCMainMenu_Ch4

;Music_DeckMachine
	db %1111
	dw Music_DeckMachine_Ch1
	dw Music_DeckMachine_Ch2
	dw Music_DeckMachine_Ch3
	dw Music_DeckMachine_Ch4

;Music_CardPop
	db %1111
	dw Music_CardPop_Ch1
	dw Music_CardPop_Ch2
	dw Music_CardPop_Ch3
	dw Music_CardPop_Ch4

;Music_Overworld
	db %1111
	dw Music_Overworld_Ch1
	dw Music_Overworld_Ch2
	dw Music_Overworld_Ch3
	dw Music_Overworld_Ch4

;Music_PokemonDome
	db %1111
	dw Music_PokemonDome_Ch1
	dw Music_PokemonDome_Ch2
	dw Music_PokemonDome_Ch3
	dw Music_PokemonDome_Ch4

;Music_ChallengeHall
	db %1111
	dw Music_ChallengeHall_Ch1
	dw Music_ChallengeHall_Ch2
	dw Music_ChallengeHall_Ch3
	dw Music_ChallengeHall_Ch4

;Music_Club1
	db %1111
	dw Music_Club1_Ch1
	dw Music_Club1_Ch2
	dw Music_Club1_Ch3
	dw Music_Club1_Ch4

;Music_Club2
	db %0111
	dw Music_Club2_Ch1
	dw Music_Club2_Ch2
	dw Music_Club2_Ch3
	dw $0000

;Music_Club3
	db %1111
	dw Music_Club3_Ch1
	dw Music_Club3_Ch2
	dw Music_Club3_Ch3
	dw Music_Club3_Ch4

;Music_Ronald
	db %1111
	dw Music_Ronald_Ch1
	dw Music_Ronald_Ch2
	dw Music_Ronald_Ch3
	dw Music_Ronald_Ch4

;Music_Imakuni
	db %1111
	dw Music_Imakuni_Ch1
	dw Music_Imakuni_Ch2
	dw Music_Imakuni_Ch3
	dw Music_Imakuni_Ch4

;Music_HallOfHonor
	db %0111
	dw Music_HallOfHonor_Ch1
	dw Music_HallOfHonor_Ch2
	dw Music_HallOfHonor_Ch3
	dw $0000

;Music_Song12
	db %1111
	dw Music_Song12_Ch1
	dw Music_Song12_Ch2
	dw Music_Song12_Ch3
	dw Music_Song12_Ch4

;Music_HereComesGR
	db %1111
	dw Music_HereComesGR_Ch1
	dw Music_HereComesGR_Ch2
	dw Music_HereComesGR_Ch3
	dw Music_HereComesGR_Ch4

;Music_GROverworld
	db %1111
	dw Music_GROverworld_Ch1
	dw Music_GROverworld_Ch2
	dw Music_GROverworld_Ch3
	dw Music_GROverworld_Ch4

Music_Fort1:
	db %1111
	dw Music_Fort1_Ch1
	dw Music_Fort1_Ch2
	dw Music_Fort1_Ch3
	dw Music_Fort1_Ch4

Music_Fort2:
	db %1111
	dw Music_Fort2_Ch1
	dw Music_Fort2_Ch2
	dw Music_Fort2_Ch3
	dw Music_Fort2_Ch4

Music_Fort3:
	db %1111
	dw Music_Fort3_Ch1
	dw Music_Fort3_Ch2
	dw Music_Fort3_Ch3
	dw Music_Fort3_Ch4

;Music_Fort4
	db %1111
	dw Music_Fort4_Ch1
	dw Music_Fort4_Ch2
	dw Music_Fort4_Ch3
	dw Music_Fort4_Ch4

;Music_GRCastle
	db %1111
	dw Music_GRCastle_Ch1
	dw Music_GRCastle_Ch2
	dw Music_GRCastle_Ch3
	dw Music_GRCastle_Ch4

;Music_GRChallengeCup
	db %1111
	dw Music_GRChallengeCup_Ch1
	dw Music_GRChallengeCup_Ch2
	dw Music_GRChallengeCup_Ch3
	dw Music_GRChallengeCup_Ch4

;Music_GameCenter
	db %1111
	dw Music_GameCenter_Ch1
	dw Music_GameCenter_Ch2
	dw Music_GameCenter_Ch3
	dw Music_GameCenter_Ch4

;Music_GRBlimp
	db %1111
	dw Music_GRBlimp_Ch1
	dw Music_GRBlimp_Ch2
	dw Music_GRBlimp_Ch3
	dw Music_GRBlimp_Ch4

;Music_DuelThemeGRMember
	db %1111
	dw Music_DuelThemeGRMember_Ch1
	dw Music_DuelThemeGRMember_Ch2
	dw Music_DuelThemeGRMember_Ch3
	dw Music_DuelThemeGRMember_Ch4

Music_DuelThemeGRLeader:
	db %1111
	dw Music_DuelThemeGRLeader_Ch1
	dw Music_DuelThemeGRLeader_Ch2
	dw Music_DuelThemeGRLeader_Ch3
	dw Music_DuelThemeGRLeader_Ch4

;Music_DuelThemeGRKing
	db %1111
	dw Music_DuelThemeGRKing_Ch1
	dw Music_DuelThemeGRKing_Ch2
	dw Music_DuelThemeGRKing_Ch3
	dw Music_DuelThemeGRKing_Ch4

;Music_Ishihara
	db %1111
	dw Music_Ishihara_Ch1
	dw Music_Ishihara_Ch2
	dw Music_Ishihara_Ch3
	dw Music_Ishihara_Ch4

;Music_ImakuniRed
	db %1111
	dw Music_ImakuniRed_Ch1
	dw Music_ImakuniRed_Ch2
	dw Music_ImakuniRed_Ch3
	dw Music_ImakuniRed_Ch4

;Music_Credits
	db %1111
	dw Music_Credits_Ch1
	dw Music_Credits_Ch2
	dw Music_Credits_Ch3
	dw Music_Credits_Ch4

;Music_Song27
	db %0001
	dw Music_Song27_Ch1
	dw $0000
	dw $0000
	dw $0000

;Music_Sting3B
	db %1111
	dw Music_Sting_Ch1
	dw Music_Sting_Ch2
	dw Music_Sting_Ch3
	dw Music_Sting_Ch4

;Music_MatchStartMember
	db %0001
	dw Music_MatchStartMember_Ch1
	dw $0000
	dw $0000
	dw $0000

;Music_MatchStartClubMaster
	db %0011
	dw Music_MatchStartClubMaster_Ch1
	dw Music_MatchStartClubMaster_Ch2
	dw $0000
	dw $0000

;Music_MatchStartGrandMaster
	db %0011
	dw Music_MatchStartGrandMaster_Ch1
	dw Music_MatchStartGrandMaster_Ch2
	dw $0000
	dw $0000

;Music_MatchVictory
	db %0111
	dw Music_MatchVictory_Ch1
	dw Music_MatchVictory_Ch2
	dw Music_MatchVictory_Ch3
	dw $0000

;Music_MatchLoss
	db %0111
	dw Music_MatchLoss_Ch1
	dw Music_MatchLoss_Ch2
	dw Music_MatchLoss_Ch3
	dw $0000

;Music_MatchDraw
	db %0111
	dw Music_MatchDraw_Ch1
	dw Music_MatchDraw_Ch2
	dw Music_MatchDraw_Ch3
	dw $0000

;Music_Unused2E
	db %0000
	dw $0000
	dw $0000
	dw $0000
	dw $0000

;Music_BoosterPack
	db %0111
	dw Music_BoosterPack_Ch1
	dw Music_BoosterPack_Ch2
	dw Music_BoosterPack_Ch3
	dw $0000

;Music_Medal
	db %0111
	dw Music_Medal_Ch1
	dw Music_Medal_Ch2
	dw Music_Medal_Ch3
	dw $0000

;Music_Unused31
	db %0000
	dw $0000
	dw $0000
	dw $0000
	dw $0000

;Music_MatchStartGRLeader
	db %0111
	dw Music_MatchStartGRLeader_Ch1
	dw Music_MatchStartGRLeader_Ch2
	dw Music_MatchStartGRLeader_Ch3
	dw $0000

;Music_MatchStartGRExecs
	db %0111
	dw Music_MatchStartGRExecs_Ch1
	dw Music_MatchStartGRExecs_Ch2
	dw Music_MatchStartGRExecs_Ch3
	dw $0000

;Music_GameCenterPowerOn
	db %0111
	dw Music_GameCenterPowerOn_Ch1
	dw Music_GameCenterPowerOn_Ch2
	dw Music_GameCenterPowerOn_Ch3
	dw $0000

;Music_Fanfare1
	db %0111
	dw Music_Fanfare1_Ch1
	dw Music_Fanfare1_Ch2
	dw Music_Fanfare1_Ch3
	dw $0000

;Music_Fanfare2
	db %0011
	dw Music_Fanfare2_Ch1
	dw Music_Fanfare2_Ch2
	dw $0000
	dw $0000

;Music_GrandMasterCupChampion
	db %1111
	dw Music_GrandMasterCupChampion_Ch1
	dw Music_GrandMasterCupChampion_Ch2
	dw Music_GrandMasterCupChampion_Ch3
	dw Music_GrandMasterCupChampion_Ch4
