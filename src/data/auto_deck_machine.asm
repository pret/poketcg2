; each Auto Deck Machine category has 4 deck entries
; each entry consists of
; its card list (see data/auto_deck_card_lists.asm) and
; two text IDs for its name and description (flavor) text

MACRO auto_deck
	dw \1 ; deck list
	tx \2 ; deck name text ID
	tx \3 ; deck description text ID
ENDM

AutoDeckMachine1Entries:
; basic
	auto_deck MachineStarterDeckList, \
		MachineStarterDeckName, \
		MachineStarterDeckDescriptionText
	auto_deck MachineElectricFireDeckList, \
		MachineElectricFireDeckName, \
		MachineElectricFireDeckDescriptionText
	auto_deck MachineBattleWaterDeckList, \
		MachineBattleWaterDeckName, \
		MachineBattleWaterDeckDescriptionText
	auto_deck MachineEsperGreenDeckList, \
		MachineEsperGreenDeckName, \
		MachineEsperGreenDeckDescriptionText
; gifts
	auto_deck MachineSweatAntiGR1DeckList, \
		MachineSweatAntiGR1DeckName, \
		MachineSweatAntiGR1DeckDescriptionText
	auto_deck MachineGiveInAntiGR2DeckList, \
		MachineGiveInAntiGR2DeckName, \
		MachineGiveInAntiGR2DeckDescriptionText
	auto_deck MachineVengefulAntiGR3DeckList, \
		MachineVengefulAntiGR3DeckName, \
		MachineVengefulAntiGR3DeckDescriptionText
	auto_deck MachineUnforgivingAntiGR4DeckList, \
		MachineUnforgivingAntiGR4DeckName, \
		MachineUnforgivingAntiGR4DeckDescriptionText
; fighting
	auto_deck MachineAwesomeFossilsDeckList, \
		MachineAwesomeFossilsDeckName, \
		MachineAwesomeFossilsDeckDescriptionText
	auto_deck MachineNewMachokeDeckList, \
		MachineNewMachokeDeckName, \
		MachineNewMachokeDeckDescriptionText
	auto_deck MachineRockFestivalDeckList, \
		MachineRockFestivalDeckName, \
		MachineRockFestivalDeckDescriptionText
	auto_deck MachineJabHookDeckList, \
		MachineJabHookDeckName, \
		MachineJabHookDeckDescriptionText
; grass
	auto_deck MachineSteadyIncreaseDeckList, \
		MachineSteadyIncreaseDeckName, \
		MachineSteadyIncreaseDeckDescriptionText
	auto_deck MachineGatheringNidoranDeckList, \
		MachineGatheringNidoranDeckName, \
		MachineGatheringNidoranDeckDescriptionText
	auto_deck MachineNationalParkDeckList, \
		MachineNationalParkDeckName, \
		MachineNationalParkDeckDescriptionText
	auto_deck MachineSelectiveBreedingDeckList, \
		MachineSelectiveBreedingDeckName, \
		MachineSelectiveBreedingDeckDescriptionText
; water
	auto_deck MachineSplashingAboutDeckList, \
		MachineSplashingAboutDeckName, \
		MachineSplashingAboutDeckDescriptionText
	auto_deck MachineBeachDeckList, \
		MachineBeachDeckName, \
		MachineBeachDeckDescriptionText
	auto_deck MachineInsulationDeckList, \
		MachineInsulationDeckName, \
		MachineInsulationDeckDescriptionText
	auto_deck MachineAntarcticDeckList, \
		MachineAntarcticDeckName, \
		MachineAntarcticDeckDescriptionText
; fire
	auto_deck MachineFlameFestivalDeckList, \
		MachineFlameFestivalDeckName, \
		MachineFlameFestivalDeckDescriptionText
	auto_deck MachineElectricCurrentShockDeckList, \
		MachineElectricCurrentShockDeckName, \
		MachineElectricCurrentShockDeckDescriptionText
	auto_deck MachineRiskyBlazeDeckList, \
		MachineRiskyBlazeDeckName, \
		MachineRiskyBlazeDeckDescriptionText
	auto_deck MachineRagingCharizardDeckList, \
		MachineRagingCharizardDeckName, \
		MachineRagingCharizardDeckDescriptionText
; lightning
	auto_deck MachineZapdosPowerPlantDeckList, \
		MachineZapdosPowerPlantDeckName, \
		MachineZapdosPowerPlantDeckDescriptionText
	auto_deck MachineElectricShockDeckList, \
		MachineElectricShockDeckName, \
		MachineElectricShockDeckDescriptionText
	auto_deck MachineOverflowDeckList, \
		MachineOverflowDeckName, \
		MachineOverflowDeckDescriptionText
	auto_deck MachineTripleZapdosDeckList, \
		MachineTripleZapdosDeckName, \
		MachineTripleZapdosDeckDescriptionText
; psychic
	auto_deck MachineSpecialBarrierDeckList, \
		MachineSpecialBarrierDeckName, \
		MachineSpecialBarrierDeckDescriptionText
	auto_deck MachineEvolutionProhibitedDeckList, \
		MachineEvolutionProhibitedDeckName, \
		MachineEvolutionProhibitedDeckDescriptionText
	auto_deck MachineGhostDeckList, \
		MachineGhostDeckName, \
		MachineGhostDeckDescriptionText
	auto_deck MachinePuppetMasterDeckList, \
		MachinePuppetMasterDeckName, \
		MachinePuppetMasterDeckDescriptionText
; special
	auto_deck MachineMewLv15DeckList, \
		MachineMewLv15DeckName, \
		MachineMewLv15DeckDescriptionText
	auto_deck MachineVenusaurLv64DeckList, \
		MachineVenusaurLv64DeckName, \
		MachineVenusaurLv64DeckDescriptionText
	auto_deck MachineMutualDestructionDeckList, \
		MachineMutualDestructionDeckName, \
		MachineMutualDestructionDeckDescriptionText
	auto_deck MachineEverybodySurfDeckList, \
		MachineEverybodySurfDeckName, \
		MachineEverybodySurfDeckDescriptionText
; legendary
	auto_deck MachineGrandFireDeckList, \
		MachineGrandFireDeckName, \
		MachineGrandFireDeckDescriptionText
	auto_deck MachineLegendaryFossilDeckList, \
		MachineLegendaryFossilDeckName, \
		MachineLegendaryFossilDeckDescriptionText
	auto_deck MachineWaterLegendDeckList, \
		MachineWaterLegendDeckName, \
		MachineWaterLegendDeckDescriptionText
	auto_deck MachineGreatDragonDeckList, \
		MachineGreatDragonDeckName, \
		MachineGreatDragonDeckDescriptionText

AutoDeckMachine2Entries:
; dark grass
	auto_deck MachineInsectCollectionDeckList, \
		MachineInsectCollectionDeckName, \
		MachineInsectCollectionDeckDescriptionText
	auto_deck MachineCaveExplorationDeckList, \
		MachineCaveExplorationDeckName, \
		MachineCaveExplorationDeckDescriptionText
	auto_deck MachineOminousMeadowDeckList, \
		MachineOminousMeadowDeckName, \
		MachineOminousMeadowDeckDescriptionText
	auto_deck MachineAtrociousWeezingDeckList, \
		MachineAtrociousWeezingDeckName, \
		MachineAtrociousWeezingDeckDescriptionText
; dark lightning
	auto_deck MachineTheBenchIsAlsoASurpriseDeckList, \
		MachineTheBenchIsAlsoASurpriseDeckName, \
		MachineTheBenchIsAlsoASurpriseDeckDescriptionText
	auto_deck MachineEnergyConservationDeckList, \
		MachineEnergyConservationDeckName, \
		MachineEnergyConservationDeckDescriptionText
	auto_deck MachineSonicboomDeckList, \
		MachineSonicboomDeckName, \
		MachineSonicboomDeckDescriptionText
	auto_deck MachineRageOfTheHeavensDeckList, \
		MachineRageOfTheHeavensDeckName, \
		MachineRageOfTheHeavensDeckDescriptionText
; dark water
	auto_deck MachineDarkWaterDeckList, \
		MachineDarkWaterDeckName, \
		MachineDarkWaterDeckDescriptionText
	auto_deck MachineQuickFreezeDeckList, \
		MachineQuickFreezeDeckName, \
		MachineQuickFreezeDeckDescriptionText
	auto_deck MachineWhirlpoolShowerDeckList, \
		MachineWhirlpoolShowerDeckName, \
		MachineWhirlpoolShowerDeckDescriptionText
	auto_deck MachineWaterGangDeckList, \
		MachineWaterGangDeckName, \
		MachineWaterGangDeckDescriptionText
; dark fire
	auto_deck MachineFireballDeckList, \
		MachineFireballDeckName, \
		MachineFireballDeckDescriptionText
	auto_deck MachineCompleteCombustionDeckList, \
		MachineCompleteCombustionDeckName, \
		MachineCompleteCombustionDeckDescriptionText
	auto_deck MachineOminousSpiritFlamesDeckList, \
		MachineOminousSpiritFlamesDeckName, \
		MachineOminousSpiritFlamesDeckDescriptionText
	auto_deck MachineEternalFireDeckList, \
		MachineEternalFireDeckName, \
		MachineEternalFireDeckDescriptionText
; dark fighting
	auto_deck MachineBewareTheTrapDeckList, \
		MachineBewareTheTrapDeckName, \
		MachineBewareTheTrapDeckDescriptionText
	auto_deck MachineOgresKickDeckList, \
		MachineOgresKickDeckName, \
		MachineOgresKickDeckDescriptionText
	auto_deck MachineRockBlastDeckList, \
		MachineRockBlastDeckName, \
		MachineRockBlastDeckDescriptionText
	auto_deck MachineHeavyWorkDeckList, \
		MachineHeavyWorkDeckName, \
		MachineHeavyWorkDeckDescriptionText
; dark psychic
	auto_deck MachineSlowbrosFishingDeckList, \
		MachineSlowbrosFishingDeckName, \
		MachineSlowbrosFishingDeckDescriptionText
	auto_deck MachineDirectHitDeckList, \
		MachineDirectHitDeckName, \
		MachineDirectHitDeckDescriptionText
	auto_deck MachineBadDreamDeckList, \
		MachineBadDreamDeckName, \
		MachineBadDreamDeckDescriptionText
	auto_deck MachineBenchPanicDeckList, \
		MachineBenchPanicDeckName, \
		MachineBenchPanicDeckDescriptionText
; colorless
	auto_deck MachineSnorlaxGuardDeckList, \
		MachineSnorlaxGuardDeckName, \
		MachineSnorlaxGuardDeckDescriptionText
	auto_deck MachineEyeOfTheStormDeckList, \
		MachineEyeOfTheStormDeckName, \
		MachineEyeOfTheStormDeckDescriptionText
	auto_deck MachineSuddenGrowthDeckList, \
		MachineSuddenGrowthDeckName, \
		MachineSuddenGrowthDeckDescriptionText
	auto_deck MachineKingDragoniteDeckList, \
		MachineKingDragoniteDeckName, \
		MachineKingDragoniteDeckDescriptionText
; dark special
	auto_deck MachineDarkCharizardDeckList, \
		MachineDarkCharizardDeckName, \
		MachineDarkCharizardDeckDescriptionText
	auto_deck MachineDarkBlastoiseDeckList, \
		MachineDarkBlastoiseDeckName, \
		MachineDarkBlastoiseDeckDescriptionText
	auto_deck MachineDarkVenusaurDeckList, \
		MachineDarkVenusaurDeckName, \
		MachineDarkVenusaurDeckDescriptionText
	auto_deck MachineDarkDragoniteDeckList, \
		MachineDarkDragoniteDeckName, \
		MachineDarkDragoniteDeckDescriptionText
; rare
	auto_deck MachinePerfectHealthDeckList, \
		MachinePerfectHealthDeckName, \
		MachinePerfectHealthDeckDescriptionText
	auto_deck MachineSuperSoakerDeckList, \
		MachineSuperSoakerDeckName, \
		MachineSuperSoakerDeckDescriptionText
	auto_deck MachineHellsDemonDeckList, \
		MachineHellsDemonDeckName, \
		MachineHellsDemonDeckDescriptionText
	auto_deck MachinePremiumThunderDeckList, \
		MachinePremiumThunderDeckName, \
		MachinePremiumThunderDeckDescriptionText
; mysterious
	auto_deck MachineMysteriousMewtwoDeckList, \
		MachineMysteriousMewtwoDeckName, \
		MachineMysteriousMewtwoDeckDescriptionText
	auto_deck MachineHeavenlyLugiaDeckList, \
		MachineHeavenlyLugiaDeckName, \
		MachineHeavenlyLugiaDeckDescriptionText
	auto_deck MachineBrutalTrainersDeckList, \
		MachineBrutalTrainersDeckName, \
		MachineBrutalTrainersDeckDescriptionText
	auto_deck MachineDreadfulParalysisDeckList, \
		MachineDreadfulParalysisDeckName, \
		MachineDreadfulParalysisDeckDescriptionText
