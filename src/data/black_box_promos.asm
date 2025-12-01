MACRO blackbox_promo
	dw \1 ; recipe pointer
	db \2 ; whether locked to post-game (EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE)
	dw \3 ; output promo card id
ENDM

MACRO blackbox_promo_recipe
	REPT _NARG
		dw \1 ; input card id
		SHIFT
	ENDR
	dw 0 ; end of list
ENDM

BlackboxPromoCards:
	blackbox_promo .dugtrio_lv40, FALSE, DUGTRIO_LV40
	blackbox_promo .mankey_alt_lv7, TRUE, MANKEY_ALT_LV7
	blackbox_promo .diglett_lv16, TRUE, DIGLETT_LV16
	blackbox_promo .moltres_lv40, FALSE, MOLTRES_LV40
	blackbox_promo .arcanine_lv34, TRUE, ARCANINE_LV34
; bug, CHARIZARD_LV76 should be CHARIZARD_ALT_LV76
	blackbox_promo .nonpromo_charizard_lv76, FALSE, CHARIZARD_LV76
	blackbox_promo .pikachu_lv13, TRUE, PIKACHU_LV13
	blackbox_promo .pikachu_lv16, FALSE, PIKACHU_LV16
	blackbox_promo .zapdos_lv68, FALSE, ZAPDOS_LV68
	blackbox_promo .pikachu_alt_lv16, FALSE, PIKACHU_ALT_LV16
	blackbox_promo .electabuzz_lv20, TRUE, ELECTABUZZ_LV20
	blackbox_promo .articuno_lv37, FALSE, ARTICUNO_LV37
	blackbox_promo .magikarp_lv10, TRUE, MAGIKARP_LV10
	blackbox_promo .blastoise_alt_lv52, FALSE, BLASTOISE_ALT_LV52
	blackbox_promo .venusaur_alt_lv67, FALSE, VENUSAUR_ALT_LV67
	blackbox_promo .grs_mewtwo, TRUE, GRS_MEWTWO
	blackbox_promo .mewtwo_alt_lv60, FALSE, MEWTWO_ALT_LV60
	blackbox_promo .mewtwo_lv60, FALSE, MEWTWO_LV60
	blackbox_promo .mewtwo_lv30, TRUE, MEWTWO_LV30
	blackbox_promo .slowpoke_lv9, TRUE, SLOWPOKE_LV9
	blackbox_promo .super_energy_retrieval, TRUE, SUPER_ENERGY_RETRIEVAL
	blackbox_promo .dark_persian_alt_lv28, TRUE, DARK_PERSIAN_ALT_LV28
	blackbox_promo .jigglypuff_lv12, FALSE, JIGGLYPUFF_LV12
	blackbox_promo .kangaskhan_lv38, FALSE, KANGASKHAN_LV38
	blackbox_promo .farfetchd_alt_lv20, TRUE, FARFETCHD_ALT_LV20
	blackbox_promo .dragonite_lv41, FALSE, DRAGONITE_LV41
; bug, DRAGONITE_LV45 should be DRAGONITE_LV43
	blackbox_promo .nonpromo_dragonite_lv45, TRUE, DRAGONITE_LV45
	blackbox_promo .meowth_lv14, FALSE, MEOWTH_LV14
	blackbox_promo .hungry_snorlax, TRUE, HUNGRY_SNORLAX
	blackbox_promo .cool_porygon, TRUE, COOL_PORYGON
	dw 0 ; end

.dugtrio_lv40
	blackbox_promo_recipe DUGTRIO_LV36, HITMONLEE_LV30, HITMONCHAN_LV23
.mankey_alt_lv7
	blackbox_promo_recipe HITMONLEE_LV30, HITMONCHAN_LV23
.diglett_lv16
	blackbox_promo_recipe DUGTRIO_LV36, DARK_DUGTRIO
.moltres_lv40
	blackbox_promo_recipe NINETALES_LV32, DARK_NINETALES, MOLTRES_LV35
.arcanine_lv34
	blackbox_promo_recipe NINETALES_LV32, ARCANINE_LV45
.nonpromo_charizard_lv76
	blackbox_promo_recipe DARK_CHARIZARD, DARK_NINETALES
.pikachu_lv13
	blackbox_promo_recipe RAICHU_LV40, RAICHU_LV45, RAICHU_LV32, DARK_RAICHU
.pikachu_lv16
	blackbox_promo_recipe RAICHU_LV40, RAICHU_LV45, RAICHU_LV32
.zapdos_lv68
	blackbox_promo_recipe RAICHU_LV40, DARK_RAICHU, ZAPDOS_LV64
.pikachu_alt_lv16
	blackbox_promo_recipe ELECTRODE_LV35, ELECTRODE_LV42, MAGNETON_LV28, MAGNETON_LV35
.electabuzz_lv20
	blackbox_promo_recipe ELECTABUZZ_LV35, MAGNETON_LV30, MAGNETON_LV28, MAGNETON_LV35
.articuno_lv37
	blackbox_promo_recipe POLIWRATH_LV40, KINGLER_LV33, ARTICUNO_LV35
.magikarp_lv10
	blackbox_promo_recipe GYARADOS, DARK_GYARADOS
.blastoise_alt_lv52
	blackbox_promo_recipe DARK_BLASTOISE, DARK_GYARADOS
.venusaur_alt_lv67
	blackbox_promo_recipe DARK_VILEPLUME, DARK_VENUSAUR
.grs_mewtwo
	blackbox_promo_recipe MEW_LV23, MEWTWO_LV53, MEWTWO_LV67
.mewtwo_alt_lv60
	blackbox_promo_recipe MEW_LV23, MEWTWO_LV67
.mewtwo_lv60
	blackbox_promo_recipe MEW_LV23, MEWTWO_LV53
.mewtwo_lv30
	blackbox_promo_recipe MEWTWO_LV53, MEWTWO_LV67
.slowpoke_lv9
	blackbox_promo_recipe ALAKAZAM_LV42, GENGAR_LV38, MR_MIME_LV28
.super_energy_retrieval
	blackbox_promo_recipe POLIWRATH_LV40, DRAGONAIR
.dark_persian_alt_lv28
	blackbox_promo_recipe CHANSEY_LV55, CLEFABLE, WIGGLYTUFF_LV36
.jigglypuff_lv12
	blackbox_promo_recipe CHANSEY_LV55, CLEFAIRY_LV14
.kangaskhan_lv38
	blackbox_promo_recipe KANGASKHAN_LV40, DRAGONAIR
.farfetchd_alt_lv20
	blackbox_promo_recipe PIDGEOT_LV38, CLEFAIRY_LV14, DITTO
.dragonite_lv41
	blackbox_promo_recipe DRAGONITE_LV45, DARK_DRAGONITE, DRAGONAIR
; impossible, recipes mustn't require promos
.nonpromo_dragonite_lv45
	blackbox_promo_recipe DRAGONITE_LV45, DARK_DRAGONITE, DRAGONITE_LV41
.meowth_lv14
	blackbox_promo_recipe DITTO, SNORLAX_LV20
.hungry_snorlax
	blackbox_promo_recipe SNORLAX_LV20, SNORLAX_LV35
.cool_porygon
	blackbox_promo_recipe DITTO, CLEFABLE

; phantoms, ishihara tradings, and game center prizes (but a few exceptions)
; used as special cases in black box, but actually redundant
; might be intended for non-recipe promos?
SpecialPromoCards:
	dw VENUSAUR_LV64
	dw MARILL
	dw OMASTAR_LV36
	dw GOLEM_LV37
	dw MACHAMP_LV54
	dw ALAKAZAM_LV45
	dw GENGAR_LV40
	dw MEWTWO_LV30 ; weird, out of the pattern
	dw MEW_LV15
	dw MEW_LV8
	dw SURFING_PIKACHU_LV13
	dw SURFING_PIKACHU_ALT_LV13
	dw FLYING_PIKACHU_LV12
	dw FLYING_PIKACHU_ALT_LV12
	dw DRAGONITE_LV43 ; weird, out of the pattern
	dw TOGEPI
	dw LUGIA
	dw HERE_COMES_TEAM_ROCKET
	dw IMAKUNI_CARD
	dw COMPUTER_ERROR
	dw 0
