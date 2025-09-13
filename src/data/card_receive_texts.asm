; bytes 1, 2: card ID
; bytes 3, 4: card name (long)
; bytes 5, 6: card name (short, but mostly the same as long)
; bytes 7, 8: receiving text
; byte 9: alt flag (for Legendaries)
; bytes 10, 11: alt receiving text
ReceiveCardTextPointers:
.grs_mewtwo_header
	dw GRS_MEWTWO
	tx PromotionalGRMewtwoLv35Text
	tx PromotionalGRMewtwoText
	tx ReceivedPromotionalGRMewtwoText
	db FALSE
	tx 0
.arcanine_lv34_header
	dw ARCANINE_LV34
	tx PromotionalArcanineLv34Text
	tx PromotionalArcanineLv34Text
	tx ReceivedPromotionalCardText_2
	db FALSE
	tx 0
.electabuzz_lv20_header
	dw ELECTABUZZ_LV20
	tx PromotionalElectabuzzLv20Text
	tx PromotionalElectabuzzLv20Text
	tx ReceivedPromotionalCardText_2
	db FALSE
	tx 0
.dragonite_lv41_header
	dw DRAGONITE_LV41
	tx PromotionalDragoniteLv41Text
	tx PromotionalDragoniteLv41Text
	tx ReceivedLegendaryCardText_2
	db TRUE
	tx ReceivedPromotionalCardText_2
.dragonite_lv43_header
	dw DRAGONITE_LV43
	tx PromotionalDragoniteLv43Text
	tx PromotionalDragoniteLv43Text
	tx ReceivedPromotionalCardText_2
	db FALSE
	tx 0
.cool_porygon_header
	dw COOL_PORYGON
	tx PromotionalCoolPorygonLv15Text
	tx PromotionalCoolPorygonText
	tx ReceivedPromotionalCoolPorygonText
	db FALSE
	tx 0
.blastoise_alt_lv52_header
	dw BLASTOISE_ALT_LV52
	tx PromotionalBlastoiseLv52Text
	tx PromotionalBlastoiseLv52Text
	tx ReceivedPromotionalCardText_2
	db FALSE
	tx 0
.farfetchd_alt_lv20_header
	dw FARFETCHD_ALT_LV20
	tx PromotionalFarfetchdLv20Text
	tx PromotionalFarfetchdLv20Text
	tx ReceivedPromotionalCardText_2
	db FALSE
	tx 0
.kangaskhan_lv38_header
	dw KANGASKHAN_LV38
	tx PromotionalKangaskhanLv38Text
	tx PromotionalKangaskhanLv38Text
	tx ReceivedPromotionalCardText_2
	db FALSE
	tx 0
.potion_energy_header
	dw POTION_ENERGY
	tx 0
	tx NotPromotionalPotionEnergyText
	tx ReceivedNotPromotionalPotionEnergyText
	db FALSE
	tx 0
.hungry_snorlax_header
	dw HUNGRY_SNORLAX
	tx PromotionalHungrySnorlaxLv50Text
	tx PromotionalHungrySnorlaxText
	tx ReceivedPromotionalHungrySnorlaxText
	db FALSE
	tx 0
.magikarp_lv10_header
	dw MAGIKARP_LV10
	tx PromotionalMagikarpLv10Text
	tx PromotionalMagikarpLv10Text
	tx ReceivedPromotionalCardText_2
	db FALSE
	tx 0
.zapdos_lv68_header
	dw ZAPDOS_LV68
	tx PromotionalZapdosLv68Text
	tx PromotionalZapdosLv68Text
	tx ReceivedLegendaryCardText_2
	db TRUE
	tx ReceivedPromotionalCardText_2
.flying_pikachu_lv12_header
	dw FLYING_PIKACHU_LV12
	tx PromotionalFlyingPikachuLv12Text
	tx PromotionalFlyingPikachuText
	tx ReceivedPromotionalFlyingPikachuText_2
	db FALSE
	tx 0
.flying_pikachu_alt_lv12_header
	dw FLYING_PIKACHU_ALT_LV12
	tx PromotionalFlyingPikachuLv12Text
	tx PromotionalFlyingPikachuText
	tx ReceivedPromotionalFlyingPikachuText_2
	db FALSE
	tx 0
.dugtrio_lv40_header
	dw DUGTRIO_LV40
	tx PromotionalDugtrioLv40Text
	tx PromotionalDugtrioLv40Text
	tx ReceivedPromotionalCardText_2
	db FALSE
	tx 0
.super_energy_retrieval_header
	dw SUPER_ENERGY_RETRIEVAL
	tx PromotionalSuperEnergyRetrievalText
	tx PromotionalSuperEnergyRetrievalText
	tx ReceivedPromotionalCardText_2
	db FALSE
	tx 0
.diglett_lv16_header
	dw DIGLETT_LV16
	tx PromotionalDiglettLv16Text
	tx PromotionalDiglettLv16Text
	tx ReceivedPromotionalCardText_2
	db FALSE
	tx 0
.togepi_header
	dw TOGEPI
	tx PromotionalTogepiLv8Text
	tx PromotionalTogepiLv8Text
	tx ReceivedPromotionalCardText_2
	db FALSE
	tx 0
.surfing_pikachu_lv13_header
	dw SURFING_PIKACHU_LV13
	tx PromotionalSurfingPikachuLv13Text
	tx PromotionalSurfingPikachuText
	tx ReceivedPromotionalSurfingPikachuText_2
	db FALSE
	tx 0
.surfing_pikachu_alt_lv13_header
	dw SURFING_PIKACHU_ALT_LV13
	tx PromotionalSurfingPikachuLv13Text
	tx PromotionalSurfingPikachuText
	tx ReceivedPromotionalSurfingPikachuText_2
	db FALSE
	tx 0
.meowth_lv14_header
	dw MEOWTH_LV14
	tx PromotionalMeowthLv14Text
	tx PromotionalMeowthLv14Text
	tx ReceivedPromotionalCardText_2
	db FALSE
	tx 0
.computer_error_header
	dw COMPUTER_ERROR
	tx PromotionalComputerErrorText
	tx PromotionalComputerErrorText
	tx ReceivedPromotionalCardText_2
	db FALSE
	tx 0
.pikachu_lv13_header
	dw PIKACHU_LV13
	tx PromotionalPikachuLv13Text
	tx PromotionalPikachuLv13Text
	tx ReceivedPromotionalCardText_2
	db FALSE
	tx 0
.pikachu_lv16_header
	dw PIKACHU_LV16
	tx PromotionalPikachuLv16Text
	tx PromotionalPikachuLv16Text
	tx ReceivedPromotionalCardText_2
	db FALSE
	tx 0
.pikachu_alt_lv16_header
	dw PIKACHU_ALT_LV16
	tx PromotionalPikachuLv16Text
	tx PromotionalPikachuLv16Text
	tx ReceivedPromotionalCardText_2
	db FALSE
	tx 0
.moltres_lv40_header
	dw MOLTRES_LV40
	tx PromotionalMoltresLv40Text
	tx PromotionalMoltresLv40Text
	tx ReceivedLegendaryCardText_2
	db TRUE
	tx ReceivedPromotionalCardText_2
.venusaur_alt_lv67_header
	dw VENUSAUR_ALT_LV67
	tx PromotionalVenusaurLv67Text
	tx PromotionalVenusaurLv67Text
	tx ReceivedPromotionalCardText_2
	db FALSE
	tx 0
.articuno_lv37_header
	dw ARTICUNO_LV37
	tx PromotionalArticunoLv37Text
	tx PromotionalArticunoLv37Text
	tx ReceivedLegendaryCardText_2
	db TRUE
	tx ReceivedPromotionalCardText_2
.jigglypuff_lv12_header
	dw JIGGLYPUFF_LV12
	tx PromotionalJigglypuffLv12Text
	tx PromotionalJigglypuffLv12Text
	tx ReceivedPromotionalCardText_2
	db FALSE
	tx 0
.goop_gas_attack_header
	dw GOOP_GAS_ATTACK
	tx 0
	tx 0
	tx ReceivedCardText_4
	db FALSE
	tx 0
.bills_computer_header
	dw BILLS_COMPUTER
	tx PromotionalBillsComputerText
	tx PromotionalBillsComputerText
	tx ReceivedPromotionalCardText_2
	db FALSE
	tx 0
.marill_header
	dw MARILL
	tx PromotionalMarillLv17Text
	tx PromotionalMarillLv17Text
	tx ReceivedPromotionalCardText_2
	db FALSE
	tx 0
.mankey_alt_lv7_header
	dw MANKEY_ALT_LV7
	tx PromotionalMankeyLv7Text
	tx PromotionalMankeyLv7Text
	tx ReceivedPromotionalCardText_2
	db FALSE
	tx 0
.mew_lv8_header
	dw MEW_LV8
	tx PromotionalMewLv8Text
	tx PromotionalMewLv8Text
	tx ReceivedPromotionalCardText_2
	db FALSE
	tx 0
.mewtwo_lv30_header
	dw MEWTWO_LV30
	tx PromotionalMewtwoLv30Text
	tx PromotionalMewtwoLv30Text
	tx ReceivedPromotionalCardText_2
	db FALSE
	tx 0
.mewtwo_alt_lv60_header
	dw MEWTWO_ALT_LV60
	tx PromotionalMewtwoLv60Text
	tx PromotionalMewtwoLv60Text
	tx ReceivedPromotionalCardText_2
	db FALSE
	tx 0
.mewtwo_lv60_header
	dw MEWTWO_LV60
	tx PromotionalMewtwoLv60Text
	tx PromotionalMewtwoLv60Text
	tx ReceivedPromotionalCardText_2
	db FALSE
	tx 0
.slowpoke_lv9_header
	dw SLOWPOKE_LV9
	tx PromotionalSlowpokeLv9Text
	tx PromotionalSlowpokeLv9Text
	tx ReceivedPromotionalCardText_2
	db FALSE
	tx 0
.charizard_alt_lv76_header
	dw CHARIZARD_ALT_LV76
	tx PromotionalCharizardLv76Text
	tx PromotionalCharizardLv76Text
	tx ReceivedPromotionalCardText_2
	db FALSE
	tx 0
.rockets_sneak_attack_header
	dw ROCKETS_SNEAK_ATTACK
	tx 0
	tx 0
	tx ReceivedCardText_3
	db FALSE
	tx 0
.dark_arbok_header
	dw DARK_ARBOK
	tx 0
	tx 0
	tx ReceivedCardText_3
	db FALSE
	tx 0
.dark_primeape_header
	dw DARK_PRIMEAPE
	tx 0
	tx 0
	tx ReceivedCardText_3
	db FALSE
	tx 0
.dark_fearow_header
	dw DARK_FEAROW
	tx 0
	tx 0
	tx ReceivedCardText_3
	db FALSE
	tx 0
.dark_machamp_header
	dw DARK_MACHAMP
	tx 0
	tx 0
	tx ReceivedCardText_3
	db FALSE
	tx 0
.dark_dragonite_header
	dw DARK_DRAGONITE
	tx 0
	tx 0
	tx ReceivedCardText_3
	db FALSE
	tx 0
.dark_blastoise_header
	dw DARK_BLASTOISE
	tx 0
	tx 0
	tx ReceivedCardText_3
	db FALSE
	tx 0
.dark_ninetales_header
	dw DARK_NINETALES
	tx 0
	tx 0
	tx ReceivedCardText_3
	db FALSE
	tx 0
.dark_gyarados_header
	dw DARK_GYARADOS
	tx 0
	tx 0
	tx ReceivedCardText_3
	db FALSE
	tx 0
.dark_rapidash_header
	dw DARK_RAPIDASH
	tx 0
	tx 0
	tx ReceivedCardText_3
	db FALSE
	tx 0
.dark_gloom_header
	dw DARK_GLOOM
	tx 0
	tx 0
	tx ReceivedCardText_3
	db FALSE
	tx 0
.dark_machoke_header
	dw DARK_MACHOKE
	tx 0
	tx 0
	tx ReceivedCardText_3
	db FALSE
	tx 0
.dark_golduck_header
	dw DARK_GOLDUCK
	tx 0
	tx 0
	tx ReceivedCardText_3
	db FALSE
	tx 0
.dark_golbat_header
	dw DARK_GOLBAT
	tx 0
	tx 0
	tx ReceivedCardText_3
	db FALSE
	tx 0
.dark_jolteon_header
	dw DARK_JOLTEON
	tx 0
	tx 0
	tx ReceivedCardText_3
	db FALSE
	tx 0
.dark_vaporeon_header
	dw DARK_VAPOREON
	tx 0
	tx 0
	tx ReceivedCardText_3
	db FALSE
	tx 0
.dark_starmie_header
	dw DARK_STARMIE
	tx 0
	tx 0
	tx ReceivedCardText_3
	db FALSE
	tx 0
.dark_hypno_header
	dw DARK_HYPNO
	tx 0
	tx 0
	tx ReceivedCardText_3
	db FALSE
	tx 0
.dark_dugtrio_header
	dw DARK_DUGTRIO
	tx 0
	tx 0
	tx ReceivedCardText_3
	db FALSE
	tx 0
.dark_dragonair_header
	dw DARK_DRAGONAIR
	tx 0
	tx 0
	tx ReceivedCardText_3
	db FALSE
	tx 0
.dark_flareon_header
	dw DARK_FLAREON
	tx 0
	tx 0
	tx ReceivedCardText_3
	db FALSE
	tx 0
.dark_alakazam_header
	dw DARK_ALAKAZAM
	tx 0
	tx 0
	tx ReceivedCardText_3
	db FALSE
	tx 0
.dark_ivysaur_header
	dw DARK_IVYSAUR
	tx 0
	tx 0
	tx ReceivedCardText_3
	db FALSE
	tx 0
.dark_venusaur_header
	dw DARK_VENUSAUR
	tx 0
	tx 0
	tx ReceivedCardText_3
	db FALSE
	tx 0
.dark_muk_header
	dw DARK_MUK
	tx 0
	tx 0
	tx ReceivedCardText_3
	db FALSE
	tx 0
.dark_persian_lv28_header
	dw DARK_PERSIAN_LV28
	tx 0
	tx 0
	tx ReceivedCardText_3
	db FALSE
	tx 0
.dark_persian_alt_lv28_header
	dw DARK_PERSIAN_ALT_LV28
	tx PromotionalDarkPersianLv28Text
	tx PromotionalDarkPersianLv28Text
	tx ReceivedPromotionalCardText_3
	db FALSE
	tx 0
.dark_weezing_header
	dw DARK_WEEZING
	tx 0
	tx 0
	tx ReceivedCardText_3
	db FALSE
	tx 0
.dark_electrode_header
	dw DARK_ELECTRODE
	tx 0
	tx 0
	tx ReceivedCardText_3
	db FALSE
	tx 0
.dark_kadabra_header
	dw DARK_KADABRA
	tx 0
	tx 0
	tx ReceivedCardText_3
	db FALSE
	tx 0
.dark_raichu_header
	dw DARK_RAICHU
	tx 0
	tx 0
	tx ReceivedCardText_3
	db FALSE
	tx 0
.dark_vileplume_header
	dw DARK_VILEPLUME
	tx 0
	tx 0
	tx ReceivedCardText_3
	db FALSE
	tx 0
.dark_charizard_header
	dw DARK_CHARIZARD
	tx 0
	tx 0
	tx ReceivedCardText_3
	db FALSE
	tx 0
.dark_magneton_header
	dw DARK_MAGNETON
	tx 0
	tx 0
	tx ReceivedCardText_3
	db FALSE
	tx 0
.terminator
	dw $ffff
