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
	credits_show_portrait $07, 2, 6, PORTRAITVARIANT_NORMAL
	credits_fade_in CREDITS_FADE_BACKGROUND, $0a
	credits_wait 60
	credits_show_portrait $07, 2, 6, PORTRAITVARIANT_HAPPY
	credits_print_header  7, 2, 2, Text07aa
	credits_print_text 10,  6, Text07ab
	credits_fade_in CREDITS_FADE_HEADER_TEXT, $05
	credits_wait 30
	credits_wait 150
	credits_fade_out CREDITS_FADE_ALL, $05
	credits_wait 30
	credits_wait 20

	credits_draw_box  0,  0, 20, 18
	credits_show_portrait $06, 2, 6, PORTRAITVARIANT_NORMAL
	credits_fade_in CREDITS_FADE_BACKGROUND, $0a
	credits_wait 60
	credits_show_portrait $06, 2, 6, PORTRAITVARIANT_HAPPY
	credits_print_header  7, 2, 2, Text07ac
	credits_print_text 10,  8, Text07ad
	credits_fade_in CREDITS_FADE_HEADER_TEXT, $05
	credits_wait 30
	credits_wait 150
	credits_fade_out CREDITS_FADE_ALL, $05
	credits_wait 30
	credits_wait 20

	credits_draw_box  0,  0, 20, 18
	credits_show_portrait $51, 2, 6, PORTRAITVARIANT_NORMAL
	credits_fade_in CREDITS_FADE_BACKGROUND, $0a
	credits_wait 60
	credits_show_portrait $51, 2, 6, PORTRAITVARIANT_HAPPY
	credits_print_header  4, 2, 2, Text07ae
	credits_print_text 10,  8, Text07af
	credits_fade_in CREDITS_FADE_HEADER_TEXT, $05
	credits_wait 30
	credits_wait 150
	credits_fade_out CREDITS_FADE_ALL, $05
	credits_wait 30
	credits_wait 20

	credits_draw_box  0,  0, 20, 18
	credits_show_portrait $46, 2, 6, PORTRAITVARIANT_HAPPY
	credits_fade_in CREDITS_FADE_BACKGROUND, $0a
	credits_wait 60
	credits_show_portrait $46, 2, 6, PORTRAITVARIANT_HAPPY
	credits_print_header  5, 2, 2, Text07b0
	credits_print_text 10,  8, Text07b1
	credits_fade_in CREDITS_FADE_HEADER_TEXT, $05
	credits_wait 30
	credits_wait 150
	credits_fade_out CREDITS_FADE_ALL, $05
	credits_wait 30
	credits_wait 20

	credits_draw_box  0,  0, 20, 18
	credits_show_portrait $5e, 2, 6, PORTRAITVARIANT_NORMAL
	credits_fade_in CREDITS_FADE_BACKGROUND, $0a
	credits_wait 60
	credits_print_header  5, 2, 2, Text07b2
	credits_print_text 10,  8, Text07b3
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
	credits_print_text 11,  6, Text07b4
	credits_fade_in CREDITS_FADE_TEXT, $05
	credits_wait 30
	credits_wait 150
	credits_fade_out CREDITS_FADE_TEXT, $05
	credits_wait 30
	credits_wait 20
	credits_draw_box 10,  6, 10,  6
	credits_print_text 11,  8, Text07b5
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
	credits_print_header 12, 2, 2, Text07b6
	credits_print_text 10,  8, Text07b7
	credits_fade_in CREDITS_FADE_HEADER_TEXT, $05
	credits_wait 30
	credits_wait 150
	credits_fade_out CREDITS_FADE_TEXT, $05
	credits_wait 30
	credits_wait 20
	credits_draw_box 10,  6, 10,  6
	credits_print_text 10,  7, Text07b8
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
	credits_print_text 10,  6, Text07b9
	credits_fade_in CREDITS_FADE_TEXT, $05
	credits_wait 30
	credits_wait 150
	credits_fade_out CREDITS_FADE_TEXT, $05
	credits_wait 30
	credits_wait 20
	credits_draw_box 10,  6, 10,  8
	credits_print_text 11,  8, Text07ba
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
	credits_print_header 11, 2, 2, Text07bb
	credits_print_text 10,  8, Text07bc
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
	credits_print_header  6, 2, 2, Text07bd
	credits_print_text 10,  8, Text07be
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
	credits_print_header 11, 2, 2, Text07bf
	credits_print_text 12,  8, Text07c0
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
	credits_print_header  9, 2, 2, Text07c1
	credits_print_text 10,  7, Text07c2
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
	credits_print_header  8, 2, 2, Text07c3
	credits_print_text 10,  7, Text07c4
	credits_fade_in CREDITS_FADE_HEADER_TEXT, $05
	credits_wait 30
	credits_wait 150
	credits_fade_out CREDITS_FADE_ALL, $05
	credits_wait 30
	credits_wait 20

	credits_draw_box  0,  0, 20, 18
	credits_show_portrait $26, 2, 6, PORTRAITVARIANT_NORMAL
	credits_fade_in CREDITS_FADE_BACKGROUND, $0a
	credits_wait 60
	credits_print_header 10, 2, 2, Text07c5
	credits_print_text 10,  8, Text07c6
	credits_fade_in CREDITS_FADE_HEADER_TEXT, $05
	credits_wait 30
	credits_wait 150
	credits_fade_out CREDITS_FADE_BACKGROUND_TEXT, $05
	credits_wait 30
	credits_wait 20

	credits_draw_box  2,  6,  6,  6
	credits_draw_box 10,  6, 10,  6
	credits_show_portrait $5f, 2, 6, PORTRAITVARIANT_HAPPY
	credits_fade_in CREDITS_FADE_BACKGROUND, $0a
	credits_wait 60
	credits_print_text 10,  8, Text07c7
	credits_fade_in CREDITS_FADE_TEXT, $05
	credits_wait 30
	credits_wait 150
	credits_fade_out CREDITS_FADE_BACKGROUND_TEXT, $05
	credits_wait 30
	credits_wait 20

	credits_draw_box  2,  6,  6,  6
	credits_draw_box 10,  6, 10,  6
	credits_show_portrait $0e, 2, 6, PORTRAITVARIANT_NORMAL
	credits_fade_in CREDITS_FADE_BACKGROUND, $0a
	credits_wait 60
	credits_print_text 10,  8, Text07c8
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
	credits_print_header 12, 2, 2, Text07c9
	credits_print_text 10,  6, Text07ca
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
	credits_print_text 10,  6, Text07cb
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
	credits_print_text 10,  6, Text07cc
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
	credits_print_text 10,  6, Text07cd
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
	credits_print_text 10,  6, Text07ce
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
	credits_print_text 10,  6, Text07cf
	credits_fade_in CREDITS_FADE_TEXT, $05
	credits_wait 30
	credits_wait 150
	credits_fade_out CREDITS_FADE_ALL, $05
	credits_wait 30
	credits_wait 20

	credits_draw_box  0,  0, 20, 18
	credits_show_portrait $09, 2, 6, PORTRAITVARIANT_SAD
	credits_fade_in CREDITS_FADE_BACKGROUND, $0a
	credits_wait 60
	credits_print_header 12, 2, 2, Text07d0
	credits_print_text  9,  6, Text07d1
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
	credits_print_header  6, 2, 2, Text07d2
	credits_print_text 11,  8, Text07d3
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
	credits_print_header  9, 2, 2, Text07d4
	credits_print_text 10,  7, Text07d5
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
	credits_print_header  9, 2, 2, Text07d6
	credits_print_text 10,  9, Text07d7
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
	credits_print_header 11, 2, 2, Text07d8
	credits_print_text 10,  9, Text07d9
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
	credits_print_header 13, 2, 2, Text07da
	credits_print_text 11,  9, Text07db
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
	credits_print_header 10, 2, 2, Text07dc
	credits_print_text 11,  7, Text07dd
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
	credits_print_header  6, 2, 2, Text07de
	credits_print_text 10,  6, Text07df
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
	credits_print_text 11,  7, Text07e0
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
	credits_print_text 10,  7, Text07e1
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
	credits_print_text 10,  7, Text07e2
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
	credits_print_text 10,  7, Text07e3
	credits_print_text 10, 10, Text07e4
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
	credits_print_text 10,  7, Text07e5
	credits_print_text 10,  8, Text07e6
	credits_print_text 10,  9, Text07e7
	credits_print_text 10, 10, Text07e8
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
	credits_print_header 12, 2, 2, Text07e9
	credits_print_text 10,  8, Text07ea
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
	credits_print_header  8, 2, 2, Text07eb
	credits_print_text 11,  8, Text07ec
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
	credits_print_header 14, 2, 2, Text07ed
	credits_print_text 10,  8, Text07ee
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
	credits_print_header  7, 2, 2, Text07ef
	credits_print_text 11,  8, Text07f0
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
	credits_load_map OVERWORLD_MAP
	credits_load_tilemap TILEMAP_100, 0, 0
	credits_load_ow_obj OW_MARK, SOUTH, $34, $30
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
	credits_print_text  4, 16, Text07f1
	credits_wait 120
	credits_wait_input A_BUTTON | START
	credits_stop_music
	credits_fade_out CREDITS_FADE_ALL, $0f
	credits_wait 120
	credits_deinit_ow
	credits_end
