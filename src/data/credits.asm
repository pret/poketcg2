INCLUDE "macros/credits_commands.asm"

Credits:
	credits_music_fade_out
	credits_stop_music
	credits_wait 120
	credits_set_volume 7
	credits_set_music MUSIC_CREDITS
	credits_fade_out CREDITS_FADE_ALL, $05
	credits_wait 60

	credits_draw_box  0,  0, 20, 18
	credits_show_title
	credits_fade_in CREDITS_FADE_ALL, $0f
	credits_wait 120
	credits_wait 150
	credits_fade_out CREDITS_FADE_ALL, $0f
	credits_wait 120
	credits_wait 20

	credits_draw_box  0,  0, 20, 18
	credits_show_portrait ISHIHARA_PIC, 2, 6, EMOTION_NORMAL
	credits_fade_in CREDITS_FADE_BACKGROUND, $0a
	credits_wait 60
	credits_show_portrait ISHIHARA_PIC, 2, 6, EMOTION_HAPPY
	credits_print_header  7, 2, 2, CreditsProducersText
	credits_print_text 10,  6, CreditsProducersListText
	credits_fade_in CREDITS_FADE_HEADER_TEXT, $05
	credits_wait 30
	credits_wait 150
	credits_fade_out CREDITS_FADE_ALL, $05
	credits_wait 30
	credits_wait 20

	credits_draw_box  0,  0, 20, 18
	credits_show_portrait AARON_PIC, 2, 6, EMOTION_NORMAL
	credits_fade_in CREDITS_FADE_BACKGROUND, $0a
	credits_wait 60
	credits_show_portrait AARON_PIC, 2, 6, EMOTION_HAPPY
	credits_print_header  7, 2, 2, CreditsDirectorText
	credits_print_text 10,  8, CreditsDirectorListText
	credits_fade_in CREDITS_FADE_HEADER_TEXT, $05
	credits_wait 30
	credits_wait 150
	credits_fade_out CREDITS_FADE_ALL, $05
	credits_wait 30
	credits_wait 20

	credits_draw_box  0,  0, 20, 18
	credits_show_portrait KAMIYA_PIC, 2, 6, EMOTION_NORMAL
	credits_fade_in CREDITS_FADE_BACKGROUND, $0a
	credits_wait 60
	credits_show_portrait KAMIYA_PIC, 2, 6, EMOTION_HAPPY
	credits_print_header  4, 2, 2, CreditsStoryText
	credits_print_text 10,  8, CreditsStoryListText
	credits_fade_in CREDITS_FADE_HEADER_TEXT, $05
	credits_wait 30
	credits_wait 150
	credits_fade_out CREDITS_FADE_ALL, $05
	credits_wait 30
	credits_wait 20

	credits_draw_box  0,  0, 20, 18
	credits_show_portrait TAP_PIC, 2, 6, EMOTION_HAPPY
	credits_fade_in CREDITS_FADE_BACKGROUND, $0a
	credits_wait 60
	credits_show_portrait TAP_PIC, 2, 6, EMOTION_HAPPY
	credits_print_header  5, 2, 2, CreditsPlannerText
	credits_print_text 10,  8, CreditsPlannerListText
	credits_fade_in CREDITS_FADE_HEADER_TEXT, $05
	credits_wait 30
	credits_wait 150
	credits_fade_out CREDITS_FADE_ALL, $05
	credits_wait 30
	credits_wait 20

	credits_draw_box  0,  0, 20, 18
	credits_show_portrait TOBICHAN_PIC, 2, 6, EMOTION_NORMAL
	credits_fade_in CREDITS_FADE_BACKGROUND, $0a
	credits_wait 60
	credits_print_header  5, 2, 2, CreditsProgrammersText
	credits_print_text 10,  8, CreditsProgrammersList1Text
	credits_fade_in CREDITS_FADE_HEADER_TEXT, $05
	credits_wait 30
	credits_wait 150
	credits_fade_out CREDITS_FADE_BACKGROUND_TEXT, $05
	credits_wait 30
	credits_wait 20

	credits_draw_box  2,  6, 18,  6
	credits_show_card 1, 6, PIKACHU_LV13
	credits_fade_in CREDITS_FADE_BACKGROUND, $0a
	credits_wait 60
	credits_print_text 11,  6, CreditsProgrammersList2Text
	credits_fade_in CREDITS_FADE_TEXT, $05
	credits_wait 30
	credits_wait 150
	credits_fade_out CREDITS_FADE_TEXT, $05
	credits_wait 30
	credits_wait 20
	credits_draw_box 10,  6, 10,  6
	credits_print_text 11,  8, CreditsProgrammersList3Text
	credits_fade_in CREDITS_FADE_TEXT, $05
	credits_wait 30
	credits_wait 150
	credits_fade_out CREDITS_FADE_ALL, $05
	credits_wait 30
	credits_wait 20

	credits_draw_box  0,  0, 20, 18
	credits_show_card 1, 6, TOGEPI
	credits_fade_in CREDITS_FADE_BACKGROUND, $0a
	credits_wait 60
	credits_print_header 12, 2, 2, CreditsGBGraphicDesignersText
	credits_print_text 10,  8, CreditsGBGraphicDesignersList1Text
	credits_fade_in CREDITS_FADE_HEADER_TEXT, $05
	credits_wait 30
	credits_wait 150
	credits_fade_out CREDITS_FADE_TEXT, $05
	credits_wait 30
	credits_wait 20
	credits_draw_box 10,  6, 10,  6
	credits_print_text 10,  7, CreditsGBGraphicDesignersList2Text
	credits_fade_in CREDITS_FADE_TEXT, $05
	credits_wait 30
	credits_wait 150
	credits_fade_out CREDITS_FADE_BACKGROUND_TEXT, $05
	credits_wait 30
	credits_wait 20

	credits_draw_box  1,  6,  8,  6
	credits_draw_box 10,  6, 10,  6
	credits_show_card 1, 6, MARILL
	credits_fade_in CREDITS_FADE_BACKGROUND, $0a
	credits_wait 60
	credits_print_text 10,  6, CreditsGBGraphicDesignersList3Text
	credits_fade_in CREDITS_FADE_TEXT, $05
	credits_wait 30
	credits_wait 150
	credits_fade_out CREDITS_FADE_TEXT, $05
	credits_wait 30
	credits_wait 20
	credits_draw_box 10,  6, 10,  8
	credits_print_text 11,  8, CreditsGBGraphicDesignersList4Text
	credits_fade_in CREDITS_FADE_TEXT, $05
	credits_wait 30
	credits_wait 150
	credits_fade_out CREDITS_FADE_ALL, $05
	credits_wait 30
	credits_wait 20

	credits_draw_box  0,  0, 20, 18
	credits_show_card 1, 6, JIGGLYPUFF_LV13
	credits_fade_in CREDITS_FADE_BACKGROUND, $0a
	credits_wait 60
	credits_print_header 11, 2, 2, CreditsSoundDirectorText
	credits_print_text 10,  8, CreditsSoundDirectorListText
	credits_fade_in CREDITS_FADE_HEADER_TEXT, $05
	credits_wait 30
	credits_wait 150
	credits_fade_out CREDITS_FADE_ALL, $05
	credits_wait 30
	credits_wait 20

	credits_draw_box  0,  0, 20, 18
	credits_show_card 1, 6, WIGGLYTUFF_LV40
	credits_fade_in CREDITS_FADE_BACKGROUND, $0a
	credits_wait 60
	credits_print_header  6, 2, 2, CreditsMusicText
	credits_print_text 10,  8, CreditsMusicListText
	credits_fade_in CREDITS_FADE_HEADER_TEXT, $05
	credits_wait 30
	credits_wait 150
	credits_fade_out CREDITS_FADE_ALL, $05
	credits_wait 30
	credits_wait 20

	credits_draw_box  0,  0, 20, 18
	credits_show_card 1, 6, LAPRAS_LV24
	credits_fade_in CREDITS_FADE_BACKGROUND, $0a
	credits_wait 60
	credits_print_header 11, 2, 2, CreditsMusicProgrammerText
	credits_print_text 12,  8, CreditsMusicProgrammerListText
	credits_fade_in CREDITS_FADE_HEADER_TEXT, $05
	credits_wait 30
	credits_wait 150
	credits_fade_out CREDITS_FADE_ALL, $05
	credits_wait 30
	credits_wait 20

	credits_draw_box  0,  0, 20, 18
	credits_show_card 1, 6, DARK_MAROWAK
	credits_fade_in CREDITS_FADE_BACKGROUND, $0a
	credits_wait 60
	credits_print_header  9, 2, 2, CreditsSoundEffectsText
	credits_print_text 10,  7, CreditsSoundEffectsListText
	credits_fade_in CREDITS_FADE_HEADER_TEXT, $05
	credits_wait 30
	credits_wait 150
	credits_fade_out CREDITS_FADE_ALL, $05
	credits_wait 30
	credits_wait 20

	credits_draw_box  0,  0, 20, 18
	credits_show_card 1, 6, ZUBAT_LV10
	credits_fade_in CREDITS_FADE_BACKGROUND, $0a
	credits_wait 60
	credits_print_header  8, 2, 2, CreditsSoundSupportText
	credits_print_text 10,  7, CreditsSoundSupportListText
	credits_fade_in CREDITS_FADE_HEADER_TEXT, $05
	credits_wait 30
	credits_wait 150
	credits_fade_out CREDITS_FADE_ALL, $05
	credits_wait 30
	credits_wait 20

	credits_draw_box  0,  0, 20, 18
	credits_show_portrait KEN_PIC, 2, 6, EMOTION_NORMAL
	credits_fade_in CREDITS_FADE_BACKGROUND, $0a
	credits_wait 60
	credits_print_header 10, 2, 2, CreditsCardGameProductionText
	credits_print_text 10,  8, CreditsCardGameProductionList1Text
	credits_fade_in CREDITS_FADE_HEADER_TEXT, $05
	credits_wait 30
	credits_wait 150
	credits_fade_out CREDITS_FADE_BACKGROUND_TEXT, $05
	credits_wait 30
	credits_wait 20

	credits_draw_box  2,  6,  6,  6
	credits_draw_box 10,  6, 10,  6
	credits_show_portrait DR_MASON_PIC, 2, 6, EMOTION_HAPPY
	credits_fade_in CREDITS_FADE_BACKGROUND, $0a
	credits_wait 60
	credits_print_text 10,  8, CreditsCardGameProductionList2Text
	credits_fade_in CREDITS_FADE_TEXT, $05
	credits_wait 30
	credits_wait 150
	credits_fade_out CREDITS_FADE_BACKGROUND_TEXT, $05
	credits_wait 30
	credits_wait 20

	credits_draw_box  2,  6,  6,  6
	credits_draw_box 10,  6, 10,  6
	credits_show_portrait MURRAY_PIC, 2, 6, EMOTION_NORMAL
	credits_fade_in CREDITS_FADE_BACKGROUND, $0a
	credits_wait 60
	credits_print_text 10,  8, CreditsCardGameProductionList3Text
	credits_fade_in CREDITS_FADE_TEXT, $05
	credits_wait 30
	credits_wait 150
	credits_fade_out CREDITS_FADE_ALL, $05
	credits_wait 30
	credits_wait 20

	credits_draw_box  0,  0, 20, 18
	credits_show_card 1, 6, EEVEE_LV9
	credits_fade_in CREDITS_FADE_BACKGROUND, $0a
	credits_wait 60
	credits_print_header 12, 2, 2, CreditsCardIllustratorsText
	credits_print_text 10,  6, CreditsCardIllustratorsList1Text
	credits_fade_in CREDITS_FADE_HEADER_TEXT, $05
	credits_wait 30
	credits_wait 150
	credits_fade_out CREDITS_FADE_BACKGROUND_TEXT, $05
	credits_wait 30
	credits_wait 20

	credits_draw_box  2,  6,  8,  6
	credits_draw_box 10,  6, 10,  6
	credits_show_card 1, 6, MEOWTH_LV17
	credits_fade_in CREDITS_FADE_BACKGROUND, $0a
	credits_wait 60
	credits_print_text 10,  6, CreditsCardIllustratorsList2Text
	credits_fade_in CREDITS_FADE_TEXT, $05
	credits_wait 30
	credits_wait 150
	credits_fade_out CREDITS_FADE_BACKGROUND_TEXT, $05
	credits_wait 30
	credits_wait 20

	credits_draw_box  2,  6,  8,  6
	credits_draw_box 10,  6, 10,  6
	credits_show_card 1, 6, DARK_PERSIAN_LV28
	credits_fade_in CREDITS_FADE_BACKGROUND, $0a
	credits_wait 60
	credits_print_text 10,  6, CreditsCardIllustratorsList3Text
	credits_fade_in CREDITS_FADE_TEXT, $05
	credits_wait 30
	credits_wait 150
	credits_fade_out CREDITS_FADE_BACKGROUND_TEXT, $05
	credits_wait 30
	credits_wait 20

	credits_draw_box  2,  6,  8,  6
	credits_draw_box 10,  6, 10,  6
	credits_show_card 1, 6, OMASTAR_LV36
	credits_fade_in CREDITS_FADE_BACKGROUND, $0a
	credits_wait 60
	credits_print_text 10,  6, CreditsCardIllustratorsList4Text
	credits_fade_in CREDITS_FADE_TEXT, $05
	credits_wait 30
	credits_wait 150
	credits_fade_out CREDITS_FADE_BACKGROUND_TEXT, $05
	credits_wait 30
	credits_wait 20

	credits_draw_box  2,  6,  8,  6
	credits_draw_box 10,  6, 10,  6
	credits_show_card 1, 6, DARK_GENGAR
	credits_fade_in CREDITS_FADE_BACKGROUND, $0a
	credits_wait 60
	credits_print_text 10,  6, CreditsCardIllustratorsList5Text
	credits_fade_in CREDITS_FADE_TEXT, $05
	credits_wait 30
	credits_wait 150
	credits_fade_out CREDITS_FADE_BACKGROUND_TEXT, $05
	credits_wait 30
	credits_wait 20

	credits_draw_box  2,  6,  8,  6
	credits_draw_box 10,  6, 10,  6
	credits_show_card 1, 6, DRAGONITE_LV43
	credits_fade_in CREDITS_FADE_BACKGROUND, $0a
	credits_wait 60
	credits_print_text 10,  6, CreditsCardIllustratorsList6Text
	credits_fade_in CREDITS_FADE_TEXT, $05
	credits_wait 30
	credits_wait 150
	credits_fade_out CREDITS_FADE_ALL, $05
	credits_wait 30
	credits_wait 20

	credits_draw_box  0,  0, 20, 18
	credits_show_portrait IMAKUNI_RED_PIC, 2, 6, EMOTION_SAD
	credits_fade_in CREDITS_FADE_BACKGROUND, $0a
	credits_wait 60
	credits_print_header 12, 2, 2, CreditsGuestAppearancesText
	credits_print_text  9,  6, CreditsGuestAppearancesListText
	credits_fade_in CREDITS_FADE_HEADER_TEXT, $05
	credits_wait 30
	credits_wait 140
	credits_fade_out CREDITS_FADE_ALL, $05
	credits_wait 30
	credits_wait 20

	credits_draw_box  0,  0, 20, 18
	credits_show_card 1, 6, DARK_RAICHU
	credits_fade_in CREDITS_FADE_BACKGROUND, $0a
	credits_wait 60
	credits_print_header  6, 2, 2, CreditsMasteringText
	credits_print_text 11,  8, CreditsMasteringListText
	credits_fade_in CREDITS_FADE_HEADER_TEXT, $05
	credits_wait 30
	credits_wait 140
	credits_fade_out CREDITS_FADE_ALL, $05
	credits_wait 30
	credits_wait 20

	credits_draw_box  0,  0, 20, 18
	credits_show_card 1, 6, HERE_COMES_TEAM_ROCKET
	credits_fade_in CREDITS_FADE_BACKGROUND, $0a
	credits_wait 60
	credits_print_header  9, 2, 2, CreditsManualProductionText
	credits_print_text 10,  7, CreditsManualProductionListText
	credits_fade_in CREDITS_FADE_HEADER_TEXT, $05
	credits_wait 30
	credits_wait 140
	credits_fade_out CREDITS_FADE_ALL, $05
	credits_wait 30
	credits_wait 20

	credits_draw_box  0,  0, 20, 18
	credits_show_set CREDITS_BASE_SET, 1, 4
	credits_fade_in CREDITS_FADE_BACKGROUND, $0a
	credits_wait 60
	credits_print_header  9, 2, 2, CreditsManualIllustrationsText
	credits_print_text 10,  9, CreditsManualIllustrationsListText
	credits_fade_in CREDITS_FADE_HEADER_TEXT, $05
	credits_wait 30
	credits_wait 140
	credits_fade_out CREDITS_FADE_ALL, $05
	credits_wait 30
	credits_wait 20

	credits_draw_box  0,  0, 20, 18
	credits_show_set CREDITS_JUNGLE, 1, 4
	credits_fade_in CREDITS_FADE_BACKGROUND, $0a
	credits_wait 60
	credits_print_header 11, 2, 2, CreditsPackageArtworkText
	credits_print_text 10,  9, CreditsPackageArtworkListText
	credits_fade_in CREDITS_FADE_HEADER_TEXT, $05
	credits_wait 30
	credits_wait 140
	credits_fade_out CREDITS_FADE_ALL, $05
	credits_wait 30
	credits_wait 20

	credits_draw_box  0,  0, 20, 18
	credits_show_set CREDITS_FOSSIL, 1, 4
	credits_fade_in CREDITS_FADE_BACKGROUND, $0a
	credits_wait 60
	credits_print_header 13, 2, 2, CreditsOriginalPokemonCreatorText
	credits_print_text 11,  9, CreditsOriginalPokemonCreatorListText
	credits_fade_in CREDITS_FADE_HEADER_TEXT, $05
	credits_wait 30
	credits_wait 140
	credits_fade_out CREDITS_FADE_ALL, $05
	credits_wait 30
	credits_wait 20

	credits_draw_box  0,  0, 20, 18
	credits_show_set CREDITS_TEAM_ROCKET, 1, 4
	credits_fade_in CREDITS_FADE_BACKGROUND, $0a
	credits_wait 60
	credits_print_header 10, 2, 2, CreditsProductionAssistanceText
	credits_print_text 11,  7, CreditsProductionAssistanceListText
	credits_fade_in CREDITS_FADE_HEADER_TEXT, $05
	credits_wait 30
	credits_wait 140
	credits_fade_out CREDITS_FADE_ALL, $05
	credits_wait 30
	credits_wait 20

	credits_draw_box  0,  0, 20, 18
	credits_show_card 1, 6, DARK_MAGNETON
	credits_fade_in CREDITS_FADE_BACKGROUND, $0a
	credits_wait 60
	credits_print_header  6, 2, 2, CreditsAssistanceText
	credits_print_text 10,  6, CreditsAssistanceList1Text
	credits_fade_in CREDITS_FADE_HEADER_TEXT, $05
	credits_wait 30
	credits_wait 140
	credits_fade_out CREDITS_FADE_BACKGROUND_TEXT, $05
	credits_wait 30
	credits_wait 20

	credits_draw_box  2,  6,  8,  6
	credits_draw_box 10,  6, 10,  6
	credits_show_card 1, 6, DODRIO_LV25
	credits_fade_in CREDITS_FADE_BACKGROUND, $0a
	credits_wait 60
	credits_print_text 11,  7, CreditsAssistanceList2Text
	credits_fade_in CREDITS_FADE_TEXT, $05
	credits_wait 30
	credits_wait 140
	credits_fade_out CREDITS_FADE_BACKGROUND_TEXT, $05
	credits_wait 30
	credits_wait 20

	credits_draw_box  2,  6,  8,  6
	credits_draw_box 10,  6, 10,  6
	credits_show_card 1, 6, DARK_WEEZING
	credits_fade_in CREDITS_FADE_BACKGROUND, $0a
	credits_wait 60
	credits_print_text 10,  7, CreditsAssistanceList3Text
	credits_fade_in CREDITS_FADE_TEXT, $05
	credits_wait 30
	credits_wait 140
	credits_fade_out CREDITS_FADE_BACKGROUND_TEXT, $05
	credits_wait 30
	credits_wait 20

	credits_draw_box  2,  6,  8,  6
	credits_draw_box 10,  6, 10,  6
	credits_show_card 1, 6, DUGTRIO_LV40
	credits_fade_in CREDITS_FADE_BACKGROUND, $0a
	credits_wait 60
	credits_print_text 10,  7, CreditsAssistanceList4Text
	credits_fade_in CREDITS_FADE_TEXT, $05
	credits_wait 30
	credits_wait 140
	credits_fade_out CREDITS_FADE_BACKGROUND_TEXT, $05
	credits_wait 30
	credits_wait 20

	credits_draw_box  2,  6,  8,  6
	credits_draw_box 10,  6, 10,  6
	credits_show_card 1, 6, KANGASKHAN_LV38
	credits_fade_in CREDITS_FADE_BACKGROUND, $0a
	credits_wait 60
	credits_print_text 10,  7, CreditsAssistanceList5Text
	credits_print_text 10, 10, CreditsAssistanceList5ContText
	credits_fade_in CREDITS_FADE_TEXT, $05
	credits_wait 30
	credits_wait 140
	credits_fade_out CREDITS_FADE_BACKGROUND_TEXT, $05
	credits_wait 30
	credits_wait 20

	credits_draw_box  2,  6,  8,  6
	credits_draw_box 10,  6, 10,  6
	credits_show_card 1, 6, THE_ROCKETS_TRAP
	credits_fade_in CREDITS_FADE_BACKGROUND, $0a
	credits_wait 60
	credits_print_text 10,  7, CreditsAssistanceList6Text
	credits_print_text 10,  8, CreditsAssistanceList7Text
	credits_print_text 10,  9, CreditsAssistanceList7ContText
	credits_print_text 10, 10, CreditsAssistanceList8Text
	credits_fade_in CREDITS_FADE_TEXT, $05
	credits_wait 30
	credits_wait 140
	credits_fade_out CREDITS_FADE_ALL, $05
	credits_wait 30
	credits_wait 20

	credits_draw_box  0,  0, 20, 18
	credits_show_card 1, 6, DARK_CLEFABLE
	credits_fade_in CREDITS_FADE_BACKGROUND, $0a
	credits_wait 60
	credits_print_header 12, 2, 2, CreditsProjectManagerText
	credits_print_text 10,  8, CreditsProjectManagerListText
	credits_fade_in CREDITS_FADE_HEADER_TEXT, $05
	credits_wait 30
	credits_wait 140
	credits_fade_out CREDITS_FADE_ALL, $05
	credits_wait 30
	credits_wait 20

	credits_draw_box  0,  0, 20, 18
	credits_show_card 1, 6, VENUSAUR_LV64
	credits_fade_in CREDITS_FADE_BACKGROUND, $0a
	credits_wait 60
	credits_print_header  8, 2, 2, CreditsSupervisorText
	credits_print_text 11,  8, CreditsSupervisorListText
	credits_fade_in CREDITS_FADE_HEADER_TEXT, $05
	credits_wait 30
	credits_wait 140
	credits_fade_out CREDITS_FADE_ALL, $05
	credits_wait 30
	credits_wait 20

	credits_draw_box  0,  0, 20, 18
	credits_show_card 1, 6, LUGIA
	credits_fade_in CREDITS_FADE_BACKGROUND, $0a
	credits_wait 60
	credits_print_header 14, 2, 2, CreditsExecutiveProducerText
	credits_print_text 10,  8, CreditsExecutiveProducerListText
	credits_fade_in CREDITS_FADE_HEADER_TEXT, $05
	credits_wait 30
	credits_wait 140
	credits_fade_out CREDITS_FADE_ALL, $05
	credits_wait 30
	credits_wait 20

	credits_draw_box  0,  0, 20, 18
	credits_show_card 1, 6, MEW_LV15
	credits_fade_in CREDITS_FADE_BACKGROUND, $0a
	credits_wait 60
	credits_print_header  7, 2, 2, CreditsGameProductionText
	credits_print_text 11,  8, CreditsGameProductionListText
	credits_fade_in CREDITS_FADE_HEADER_TEXT, $05
	credits_wait 30
	credits_wait 140
	credits_fade_out CREDITS_FADE_ALL, $05
	credits_wait 30
	credits_wait 20

	credits_draw_box  0,  0, 20, 18
	credits_show_companies
	credits_fade_in CREDITS_FADE_ALL, $0a
	credits_wait 60
	credits_wait 140
	credits_fade_out CREDITS_FADE_ALL, $05
	credits_wait 30
	credits_wait 20

	credits_draw_box  0,  0, 20, 18
	credits_init_ow
	credits_load_map OVERWORLD_MAP_GFX_TCG
	credits_load_tilemap TILEMAP_100, 0, 0
	credits_load_npc NPC_MARK, SOUTH, $34, $30
	credits_fade_in CREDITS_FADE_ALL, $0a
	credits_wait 60
	credits_draw_box 19,  0,  1, 18
	credits_draw_box  0, 17, 20,  1
	credits_wait 8
	credits_draw_box 18,  0,  1, 17
	credits_draw_box  0, 16, 19,  1
	credits_wait 8
	credits_draw_box 17,  0,  1, 16
	credits_draw_box  0, 15, 18,  1
	credits_wait 4
	credits_draw_box 16,  0,  1, 15
	credits_draw_box  0, 14, 17,  1
	credits_wait 4
	credits_draw_box  0,  0,  1, 14
	credits_draw_box  0,  0, 16,  1
	credits_draw_box 15,  0,  1, 14
	credits_draw_box  0, 13, 16,  1
	credits_wait 2
	credits_draw_box 14,  0,  1, 14
	credits_draw_box  0, 12, 16,  1
	credits_wait 4
	credits_wait 30
	credits_show_tile $03, $10, $0f, $00
	credits_print_text  4, 16, CreditsToBeContinuedText
	credits_wait 120
	credits_wait_input PAD_A | PAD_START
	credits_stop_music
	credits_fade_out CREDITS_FADE_ALL, $0f
	credits_wait 120
	credits_deinit_ow
	credits_end
