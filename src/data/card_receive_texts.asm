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
	tx 0

	dw ARCANINE_LV34
	tx PromotionalArcanineLv34Text
	tx PromotionalArcanineLv34Text
	tx ReceivedPromotionalCardText_2
	db FALSE
	tx 0

	dw ELECTABUZZ_LV20
	tx PromotionalElectabuzzLv20Text
	tx PromotionalElectabuzzLv20Text
	tx ReceivedPromotionalCardText_2
	db FALSE
	tx 0

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
	tx 0

	dw COOL_PORYGON
	tx PromotionalCoolPorygonLv15Text
	tx PromotionalCoolPorygonText
	tx ReceivedPromotionalCoolPorygonText
	db FALSE
	tx 0

	dw BLASTOISE_ALT_LV52
	tx PromotionalBlastoiseLv52Text
	tx PromotionalBlastoiseLv52Text
	tx ReceivedPromotionalCardText_2
	db FALSE
	tx 0

	dw FARFETCHD_ALT_LV20
	tx PromotionalFarfetchdLv20Text
	tx PromotionalFarfetchdLv20Text
	tx ReceivedPromotionalCardText_2
	db FALSE
	tx 0

	dw KANGASKHAN_LV38
	tx PromotionalKangaskhanLv38Text
	tx PromotionalKangaskhanLv38Text
	tx ReceivedPromotionalCardText_2
	db FALSE
	tx 0

	dw POTION_ENERGY
	tx 0
	tx NotPromotionalPotionEnergyText
	tx ReceivedNotPromotionalPotionEnergyText
	db FALSE
	tx 0

	dw HUNGRY_SNORLAX
	tx PromotionalHungrySnorlaxLv50Text
	tx PromotionalHungrySnorlaxText
	tx ReceivedPromotionalHungrySnorlaxText
	db FALSE
	tx 0

	dw MAGIKARP_LV10
	tx PromotionalMagikarpLv10Text
	tx PromotionalMagikarpLv10Text
	tx ReceivedPromotionalCardText_2
	db FALSE
	tx 0

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
	tx 0

	dw FLYING_PIKACHU_ALT_LV12
	tx PromotionalFlyingPikachuLv12Text
	tx PromotionalFlyingPikachuText
	tx ReceivedPromotionalFlyingPikachuText_2
	db FALSE
	tx 0

	dw DUGTRIO_LV40
	tx PromotionalDugtrioLv40Text
	tx PromotionalDugtrioLv40Text
	tx ReceivedPromotionalCardText_2
	db FALSE
	tx 0

	dw SUPER_ENERGY_RETRIEVAL
	tx PromotionalSuperEnergyRetrievalText
	tx PromotionalSuperEnergyRetrievalText
	tx ReceivedPromotionalCardText_2
	db FALSE
	tx 0

	dw DIGLETT_LV16
	tx PromotionalDiglettLv16Text
	tx PromotionalDiglettLv16Text
	tx ReceivedPromotionalCardText_2
	db FALSE
	tx 0

	dw TOGEPI
	tx PromotionalTogepiLv8Text
	tx PromotionalTogepiLv8Text
	tx ReceivedPromotionalCardText_2
	db FALSE
	tx 0

	dw SURFING_PIKACHU_LV13
	tx PromotionalSurfingPikachuLv13Text
	tx PromotionalSurfingPikachuText
	tx ReceivedPromotionalSurfingPikachuText_2
	db FALSE
	tx 0

	dw SURFING_PIKACHU_ALT_LV13
	tx PromotionalSurfingPikachuLv13Text
	tx PromotionalSurfingPikachuText
	tx ReceivedPromotionalSurfingPikachuText_2
	db FALSE
	tx 0

	dw MEOWTH_LV14
	tx PromotionalMeowthLv14Text
	tx PromotionalMeowthLv14Text
	tx ReceivedPromotionalCardText_2
	db FALSE
	tx 0

	dw COMPUTER_ERROR
	tx PromotionalComputerErrorText
	tx PromotionalComputerErrorText
	tx ReceivedPromotionalCardText_2
	db FALSE
	tx 0

	dw PIKACHU_LV13
	tx PromotionalPikachuLv13Text
	tx PromotionalPikachuLv13Text
	tx ReceivedPromotionalCardText_2
	db FALSE
	tx 0

	dw PIKACHU_LV16
	tx PromotionalPikachuLv16Text
	tx PromotionalPikachuLv16Text
	tx ReceivedPromotionalCardText_2
	db FALSE
	tx 0

	dw PIKACHU_ALT_LV16
	tx PromotionalPikachuLv16Text
	tx PromotionalPikachuLv16Text
	tx ReceivedPromotionalCardText_2
	db FALSE
	tx 0

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
	tx 0

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
	tx 0

	dw GOOP_GAS_ATTACK
	tx 0
	tx 0
	tx ReceivedCardText_4
	db FALSE
	tx 0

	dw BILLS_COMPUTER
	tx PromotionalBillsComputerText
	tx PromotionalBillsComputerText
	tx ReceivedPromotionalCardText_2
	db FALSE
	tx 0

	dw MARILL
	tx PromotionalMarillLv17Text
	tx PromotionalMarillLv17Text
	tx ReceivedPromotionalCardText_2
	db FALSE
	tx 0

	dw MANKEY_ALT_LV7
	tx PromotionalMankeyLv7Text
	tx PromotionalMankeyLv7Text
	tx ReceivedPromotionalCardText_2
	db FALSE
	tx 0

	dw MEW_LV8
	tx PromotionalMewLv8Text
	tx PromotionalMewLv8Text
	tx ReceivedPromotionalCardText_2
	db FALSE
	tx 0

	dw MEWTWO_LV30
	tx PromotionalMewtwoLv30Text
	tx PromotionalMewtwoLv30Text
	tx ReceivedPromotionalCardText_2
	db FALSE
	tx 0

	dw MEWTWO_ALT_LV60
	tx PromotionalMewtwoLv60Text
	tx PromotionalMewtwoLv60Text
	tx ReceivedPromotionalCardText_2
	db FALSE
	tx 0

	dw MEWTWO_LV60
	tx PromotionalMewtwoLv60Text
	tx PromotionalMewtwoLv60Text
	tx ReceivedPromotionalCardText_2
	db FALSE
	tx 0

	dw SLOWPOKE_LV9
	tx PromotionalSlowpokeLv9Text
	tx PromotionalSlowpokeLv9Text
	tx ReceivedPromotionalCardText_2
	db FALSE
	tx 0

	dw CHARIZARD_ALT_LV76
	tx PromotionalCharizardLv76Text
	tx PromotionalCharizardLv76Text
	tx ReceivedPromotionalCardText_2
	db FALSE
	tx 0

	dw ROCKETS_SNEAK_ATTACK
	tx 0
	tx 0
	tx ReceivedCardText_3
	db FALSE
	tx 0

	dw DARK_ARBOK
	tx 0
	tx 0
	tx ReceivedCardText_3
	db FALSE
	tx 0

	dw DARK_PRIMEAPE
	tx 0
	tx 0
	tx ReceivedCardText_3
	db FALSE
	tx 0

	dw DARK_FEAROW
	tx 0
	tx 0
	tx ReceivedCardText_3
	db FALSE
	tx 0

	dw DARK_MACHAMP
	tx 0
	tx 0
	tx ReceivedCardText_3
	db FALSE
	tx 0

	dw DARK_DRAGONITE
	tx 0
	tx 0
	tx ReceivedCardText_3
	db FALSE
	tx 0

	dw DARK_BLASTOISE
	tx 0
	tx 0
	tx ReceivedCardText_3
	db FALSE
	tx 0

	dw DARK_NINETALES
	tx 0
	tx 0
	tx ReceivedCardText_3
	db FALSE
	tx 0

	dw DARK_GYARADOS
	tx 0
	tx 0
	tx ReceivedCardText_3
	db FALSE
	tx 0

	dw DARK_RAPIDASH
	tx 0
	tx 0
	tx ReceivedCardText_3
	db FALSE
	tx 0

	dw DARK_GLOOM
	tx 0
	tx 0
	tx ReceivedCardText_3
	db FALSE
	tx 0

	dw DARK_MACHOKE
	tx 0
	tx 0
	tx ReceivedCardText_3
	db FALSE
	tx 0

	dw DARK_GOLDUCK
	tx 0
	tx 0
	tx ReceivedCardText_3
	db FALSE
	tx 0

	dw DARK_GOLBAT
	tx 0
	tx 0
	tx ReceivedCardText_3
	db FALSE
	tx 0

	dw DARK_JOLTEON
	tx 0
	tx 0
	tx ReceivedCardText_3
	db FALSE
	tx 0

	dw DARK_VAPOREON
	tx 0
	tx 0
	tx ReceivedCardText_3
	db FALSE
	tx 0

	dw DARK_STARMIE
	tx 0
	tx 0
	tx ReceivedCardText_3
	db FALSE
	tx 0

	dw DARK_HYPNO
	tx 0
	tx 0
	tx ReceivedCardText_3
	db FALSE
	tx 0

	dw DARK_DUGTRIO
	tx 0
	tx 0
	tx ReceivedCardText_3
	db FALSE
	tx 0

	dw DARK_DRAGONAIR
	tx 0
	tx 0
	tx ReceivedCardText_3
	db FALSE
	tx 0

	dw DARK_FLAREON
	tx 0
	tx 0
	tx ReceivedCardText_3
	db FALSE
	tx 0

	dw DARK_ALAKAZAM
	tx 0
	tx 0
	tx ReceivedCardText_3
	db FALSE
	tx 0

	dw DARK_IVYSAUR
	tx 0
	tx 0
	tx ReceivedCardText_3
	db FALSE
	tx 0

	dw DARK_VENUSAUR
	tx 0
	tx 0
	tx ReceivedCardText_3
	db FALSE
	tx 0

	dw DARK_MUK
	tx 0
	tx 0
	tx ReceivedCardText_3
	db FALSE
	tx 0

	dw DARK_PERSIAN_LV28
	tx 0
	tx 0
	tx ReceivedCardText_3
	db FALSE
	tx 0

	dw DARK_PERSIAN_ALT_LV28
	tx PromotionalDarkPersianLv28Text
	tx PromotionalDarkPersianLv28Text
	tx ReceivedPromotionalCardText_3
	db FALSE
	tx 0

	dw DARK_WEEZING
	tx 0
	tx 0
	tx ReceivedCardText_3
	db FALSE
	tx 0

	dw DARK_ELECTRODE
	tx 0
	tx 0
	tx ReceivedCardText_3
	db FALSE
	tx 0

	dw DARK_KADABRA
	tx 0
	tx 0
	tx ReceivedCardText_3
	db FALSE
	tx 0

	dw DARK_RAICHU
	tx 0
	tx 0
	tx ReceivedCardText_3
	db FALSE
	tx 0

	dw DARK_VILEPLUME
	tx 0
	tx 0
	tx ReceivedCardText_3
	db FALSE
	tx 0

	dw DARK_CHARIZARD
	tx 0
	tx 0
	tx ReceivedCardText_3
	db FALSE
	tx 0

	dw DARK_MAGNETON
	tx 0
	tx 0
	tx ReceivedCardText_3
	db FALSE
	tx 0

	dw $ffff ; end of list
