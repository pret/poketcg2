; CARD_RECEIVE_STRUCT_*
; $0, $1: card ID
; $2, $3: dialog-box card name (long)
; $4, $5: dialog-box card name (short, but mostly the same as long)
; $6, $7: received text
; $8    : alt flag (for Legendaries)
; $9, $a: alt received text
ReceiveCardTextPointers:

	dw GRS_MEWTWO
	tx PromotionalGRMewtwoLv35Text
	tx PromotionalGRMewtwoText
	tx ReceivedPromotionalGRMewtwoText
	db FALSE
	tx NONE

	dw ARCANINE_LV34
	tx PromotionalArcanineLv34Text
	tx PromotionalArcanineLv34Text
	tx ReceivedPromotionalCardText_2
	db FALSE
	tx NONE

	dw ELECTABUZZ_LV20
	tx PromotionalElectabuzzLv20Text
	tx PromotionalElectabuzzLv20Text
	tx ReceivedPromotionalCardText_2
	db FALSE
	tx NONE

	dw DRAGONITE_LV41
	tx PromotionalDragoniteLv41Text
	tx PromotionalDragoniteLv41Text
	tx ReceivedLegendaryCardText_2
	db TRUE
	tx ReceivedPromotionalCardText_2

	dw DRAGONITE_LV43
	tx PromotionalDragoniteLv43Text
	tx PromotionalDragoniteLv43Text
	tx ReceivedPromotionalCardText_2
	db FALSE
	tx NONE

	dw COOL_PORYGON
	tx PromotionalCoolPorygonLv15Text
	tx PromotionalCoolPorygonText
	tx ReceivedPromotionalCoolPorygonText
	db FALSE
	tx NONE

	dw BLASTOISE_ALT_LV52
	tx PromotionalBlastoiseLv52Text
	tx PromotionalBlastoiseLv52Text
	tx ReceivedPromotionalCardText_2
	db FALSE
	tx NONE

	dw FARFETCHD_ALT_LV20
	tx PromotionalFarfetchdLv20Text
	tx PromotionalFarfetchdLv20Text
	tx ReceivedPromotionalCardText_2
	db FALSE
	tx NONE

	dw KANGASKHAN_LV38
	tx PromotionalKangaskhanLv38Text
	tx PromotionalKangaskhanLv38Text
	tx ReceivedPromotionalCardText_2
	db FALSE
	tx NONE

	dw POTION_ENERGY
	tx NONE
	tx NotPromotionalPotionEnergyText
	tx ReceivedNotPromotionalPotionEnergyText
	db FALSE
	tx NONE

	dw HUNGRY_SNORLAX
	tx PromotionalHungrySnorlaxLv50Text
	tx PromotionalHungrySnorlaxText
	tx ReceivedPromotionalHungrySnorlaxText
	db FALSE
	tx NONE

	dw MAGIKARP_LV10
	tx PromotionalMagikarpLv10Text
	tx PromotionalMagikarpLv10Text
	tx ReceivedPromotionalCardText_2
	db FALSE
	tx NONE

	dw ZAPDOS_LV68
	tx PromotionalZapdosLv68Text
	tx PromotionalZapdosLv68Text
	tx ReceivedLegendaryCardText_2
	db TRUE
	tx ReceivedPromotionalCardText_2

	dw FLYING_PIKACHU_LV12
	tx PromotionalFlyingPikachuLv12Text
	tx PromotionalFlyingPikachuText
	tx ReceivedPromotionalFlyingPikachuText_2
	db FALSE
	tx NONE

	dw FLYING_PIKACHU_ALT_LV12
	tx PromotionalFlyingPikachuLv12Text
	tx PromotionalFlyingPikachuText
	tx ReceivedPromotionalFlyingPikachuText_2
	db FALSE
	tx NONE

	dw DUGTRIO_LV40
	tx PromotionalDugtrioLv40Text
	tx PromotionalDugtrioLv40Text
	tx ReceivedPromotionalCardText_2
	db FALSE
	tx NONE

	dw SUPER_ENERGY_RETRIEVAL
	tx PromotionalSuperEnergyRetrievalText
	tx PromotionalSuperEnergyRetrievalText
	tx ReceivedPromotionalCardText_2
	db FALSE
	tx NONE

	dw DIGLETT_LV16
	tx PromotionalDiglettLv16Text
	tx PromotionalDiglettLv16Text
	tx ReceivedPromotionalCardText_2
	db FALSE
	tx NONE

	dw TOGEPI
	tx PromotionalTogepiLv8Text
	tx PromotionalTogepiLv8Text
	tx ReceivedPromotionalCardText_2
	db FALSE
	tx NONE

	dw SURFING_PIKACHU_LV13
	tx PromotionalSurfingPikachuLv13Text
	tx PromotionalSurfingPikachuText
	tx ReceivedPromotionalSurfingPikachuText_2
	db FALSE
	tx NONE

	dw SURFING_PIKACHU_ALT_LV13
	tx PromotionalSurfingPikachuLv13Text
	tx PromotionalSurfingPikachuText
	tx ReceivedPromotionalSurfingPikachuText_2
	db FALSE
	tx NONE

	dw MEOWTH_LV14
	tx PromotionalMeowthLv14Text
	tx PromotionalMeowthLv14Text
	tx ReceivedPromotionalCardText_2
	db FALSE
	tx NONE

	dw COMPUTER_ERROR
	tx PromotionalComputerErrorText
	tx PromotionalComputerErrorText
	tx ReceivedPromotionalCardText_2
	db FALSE
	tx NONE

	dw PIKACHU_LV13
	tx PromotionalPikachuLv13Text
	tx PromotionalPikachuLv13Text
	tx ReceivedPromotionalCardText_2
	db FALSE
	tx NONE

	dw PIKACHU_LV16
	tx PromotionalPikachuLv16Text
	tx PromotionalPikachuLv16Text
	tx ReceivedPromotionalCardText_2
	db FALSE
	tx NONE

	dw PIKACHU_ALT_LV16
	tx PromotionalPikachuLv16Text
	tx PromotionalPikachuLv16Text
	tx ReceivedPromotionalCardText_2
	db FALSE
	tx NONE

	dw MOLTRES_LV40
	tx PromotionalMoltresLv40Text
	tx PromotionalMoltresLv40Text
	tx ReceivedLegendaryCardText_2
	db TRUE
	tx ReceivedPromotionalCardText_2

	dw VENUSAUR_ALT_LV67
	tx PromotionalVenusaurLv67Text
	tx PromotionalVenusaurLv67Text
	tx ReceivedPromotionalCardText_2
	db FALSE
	tx NONE

	dw ARTICUNO_LV37
	tx PromotionalArticunoLv37Text
	tx PromotionalArticunoLv37Text
	tx ReceivedLegendaryCardText_2
	db TRUE
	tx ReceivedPromotionalCardText_2

	dw JIGGLYPUFF_LV12
	tx PromotionalJigglypuffLv12Text
	tx PromotionalJigglypuffLv12Text
	tx ReceivedPromotionalCardText_2
	db FALSE
	tx NONE

	dw GOOP_GAS_ATTACK
	tx NONE
	tx NONE
	tx ReceivedCardText_4
	db FALSE
	tx NONE

	dw BILLS_COMPUTER
	tx PromotionalBillsComputerText
	tx PromotionalBillsComputerText
	tx ReceivedPromotionalCardText_2
	db FALSE
	tx NONE

	dw MARILL
	tx PromotionalMarillLv17Text
	tx PromotionalMarillLv17Text
	tx ReceivedPromotionalCardText_2
	db FALSE
	tx NONE

	dw MANKEY_ALT_LV7
	tx PromotionalMankeyLv7Text
	tx PromotionalMankeyLv7Text
	tx ReceivedPromotionalCardText_2
	db FALSE
	tx NONE

	dw MEW_LV8
	tx PromotionalMewLv8Text
	tx PromotionalMewLv8Text
	tx ReceivedPromotionalCardText_2
	db FALSE
	tx NONE

	dw MEWTWO_LV30
	tx PromotionalMewtwoLv30Text
	tx PromotionalMewtwoLv30Text
	tx ReceivedPromotionalCardText_2
	db FALSE
	tx NONE

	dw MEWTWO_ALT_LV60
	tx PromotionalMewtwoLv60Text
	tx PromotionalMewtwoLv60Text
	tx ReceivedPromotionalCardText_2
	db FALSE
	tx NONE

	dw MEWTWO_LV60
	tx PromotionalMewtwoLv60Text
	tx PromotionalMewtwoLv60Text
	tx ReceivedPromotionalCardText_2
	db FALSE
	tx NONE

	dw SLOWPOKE_LV9
	tx PromotionalSlowpokeLv9Text
	tx PromotionalSlowpokeLv9Text
	tx ReceivedPromotionalCardText_2
	db FALSE
	tx NONE

	dw CHARIZARD_ALT_LV76
	tx PromotionalCharizardLv76Text
	tx PromotionalCharizardLv76Text
	tx ReceivedPromotionalCardText_2
	db FALSE
	tx NONE

	dw ROCKETS_SNEAK_ATTACK
	tx NONE
	tx NONE
	tx ReceivedCardText_3
	db FALSE
	tx NONE

	dw DARK_ARBOK
	tx NONE
	tx NONE
	tx ReceivedCardText_3
	db FALSE
	tx NONE

	dw DARK_PRIMEAPE
	tx NONE
	tx NONE
	tx ReceivedCardText_3
	db FALSE
	tx NONE

	dw DARK_FEAROW
	tx NONE
	tx NONE
	tx ReceivedCardText_3
	db FALSE
	tx NONE

	dw DARK_MACHAMP
	tx NONE
	tx NONE
	tx ReceivedCardText_3
	db FALSE
	tx NONE

	dw DARK_DRAGONITE
	tx NONE
	tx NONE
	tx ReceivedCardText_3
	db FALSE
	tx NONE

	dw DARK_BLASTOISE
	tx NONE
	tx NONE
	tx ReceivedCardText_3
	db FALSE
	tx NONE

	dw DARK_NINETALES
	tx NONE
	tx NONE
	tx ReceivedCardText_3
	db FALSE
	tx NONE

	dw DARK_GYARADOS
	tx NONE
	tx NONE
	tx ReceivedCardText_3
	db FALSE
	tx NONE

	dw DARK_RAPIDASH
	tx NONE
	tx NONE
	tx ReceivedCardText_3
	db FALSE
	tx NONE

	dw DARK_GLOOM
	tx NONE
	tx NONE
	tx ReceivedCardText_3
	db FALSE
	tx NONE

	dw DARK_MACHOKE
	tx NONE
	tx NONE
	tx ReceivedCardText_3
	db FALSE
	tx NONE

	dw DARK_GOLDUCK
	tx NONE
	tx NONE
	tx ReceivedCardText_3
	db FALSE
	tx NONE

	dw DARK_GOLBAT
	tx NONE
	tx NONE
	tx ReceivedCardText_3
	db FALSE
	tx NONE

	dw DARK_JOLTEON
	tx NONE
	tx NONE
	tx ReceivedCardText_3
	db FALSE
	tx NONE

	dw DARK_VAPOREON
	tx NONE
	tx NONE
	tx ReceivedCardText_3
	db FALSE
	tx NONE

	dw DARK_STARMIE
	tx NONE
	tx NONE
	tx ReceivedCardText_3
	db FALSE
	tx NONE

	dw DARK_HYPNO
	tx NONE
	tx NONE
	tx ReceivedCardText_3
	db FALSE
	tx NONE

	dw DARK_DUGTRIO
	tx NONE
	tx NONE
	tx ReceivedCardText_3
	db FALSE
	tx NONE

	dw DARK_DRAGONAIR
	tx NONE
	tx NONE
	tx ReceivedCardText_3
	db FALSE
	tx NONE

	dw DARK_FLAREON
	tx NONE
	tx NONE
	tx ReceivedCardText_3
	db FALSE
	tx NONE

	dw DARK_ALAKAZAM
	tx NONE
	tx NONE
	tx ReceivedCardText_3
	db FALSE
	tx NONE

	dw DARK_IVYSAUR
	tx NONE
	tx NONE
	tx ReceivedCardText_3
	db FALSE
	tx NONE

	dw DARK_VENUSAUR
	tx NONE
	tx NONE
	tx ReceivedCardText_3
	db FALSE
	tx NONE

	dw DARK_MUK
	tx NONE
	tx NONE
	tx ReceivedCardText_3
	db FALSE
	tx NONE

	dw DARK_PERSIAN_LV28
	tx NONE
	tx NONE
	tx ReceivedCardText_3
	db FALSE
	tx NONE

	dw DARK_PERSIAN_ALT_LV28
	tx PromotionalDarkPersianLv28Text
	tx PromotionalDarkPersianLv28Text
	tx ReceivedPromotionalCardText_3
	db FALSE
	tx NONE

	dw DARK_WEEZING
	tx NONE
	tx NONE
	tx ReceivedCardText_3
	db FALSE
	tx NONE

	dw DARK_ELECTRODE
	tx NONE
	tx NONE
	tx ReceivedCardText_3
	db FALSE
	tx NONE

	dw DARK_KADABRA
	tx NONE
	tx NONE
	tx ReceivedCardText_3
	db FALSE
	tx NONE

	dw DARK_RAICHU
	tx NONE
	tx NONE
	tx ReceivedCardText_3
	db FALSE
	tx NONE

	dw DARK_VILEPLUME
	tx NONE
	tx NONE
	tx ReceivedCardText_3
	db FALSE
	tx NONE

	dw DARK_CHARIZARD
	tx NONE
	tx NONE
	tx ReceivedCardText_3
	db FALSE
	tx NONE

	dw DARK_MAGNETON
	tx NONE
	tx NONE
	tx ReceivedCardText_3
	db FALSE
	tx NONE

	dw $ffff ; end of list
