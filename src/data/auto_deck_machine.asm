; each Auto Deck Machine section has 4 deck entries
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
		MachineStarterDeckText, \
		MachineStarterDeckDescriptionText
	auto_deck MachineElectricFireDeckList, \
		MachineElectricFireDeckText, \
		MachineElectricFireDeckDescriptionText
	auto_deck MachineBattleWaterDeckList, \
		MachineBattleWaterDeckText, \
		MachineBattleWaterDeckDescriptionText
	auto_deck MachineEsperGreenDeckList, \
		MachineEsperGreenDeckText, \
		MachineEsperGreenDeckDescriptionText
; gifts
	auto_deck MachineSweatAntiGR1DeckList, \
		MachineSweatAntiGR1DeckText, \
		MachineSweatAntiGR1DeckDescriptionText
	auto_deck MachineGiveInAntiGR2DeckList, \
		MachineGiveInAntiGR2DeckText, \
		MachineGiveInAntiGR2DeckDescriptionText
	auto_deck MachineVengefulAntiGR3DeckList, \
		MachineVengefulAntiGR3DeckText, \
		MachineVengefulAntiGR3DeckDescriptionText
	auto_deck MachineUnforgivingAntiGR4DeckList, \
		MachineUnforgivingAntiGR4DeckText, \
		MachineUnforgivingAntiGR4DeckDescriptionText
; fighting
	auto_deck MachineAwesomeFossilsDeckList, \
		MachineAwesomeFossilsDeckText, \
		MachineAwesomeFossilsDeckDescriptionText
	auto_deck MachineNewMachokeDeckList, \
		MachineNewMachokeDeckText, \
		MachineNewMachokeDeckDescriptionText
	auto_deck MachineRockFestivalDeckList, \
		MachineRockFestivalDeckText, \
		MachineRockFestivalDeckDescriptionText
	auto_deck MachineJabHookDeckList, \
		MachineJabHookDeckText, \
		MachineJabHookDeckDescriptionText
; grass
	auto_deck MachineSteadyIncreaseDeckList, \
		MachineSteadyIncreaseDeckText, \
		MachineSteadyIncreaseDeckDescriptionText
	auto_deck MachineGatheringNidoranDeckList, \
		MachineGatheringNidoranDeckText, \
		MachineGatheringNidoranDeckDescriptionText
	auto_deck MachineNationalParkDeckList, \
		MachineNationalParkDeckText, \
		MachineNationalParkDeckDescriptionText
	auto_deck MachineSelectiveBreedingDeckList, \
		MachineSelectiveBreedingDeckText, \
		MachineSelectiveBreedingDeckDescriptionText
; water
	auto_deck MachineSplashingAboutDeckList, \
		MachineSplashingAboutDeckText, \
		MachineSplashingAboutDeckDescriptionText
	auto_deck MachineBeachDeckList, \
		MachineBeachDeckText, \
		MachineBeachDeckDescriptionText
	auto_deck MachineInsulationDeckList, \
		MachineInsulationDeckText, \
		MachineInsulationDeckDescriptionText
	auto_deck MachineAntarcticDeckList, \
		MachineAntarcticDeckText, \
		MachineAntarcticDeckDescriptionText
; fire
	auto_deck MachineFlameFestivalDeckList, \
		MachineFlameFestivalDeckText, \
		MachineFlameFestivalDeckDescriptionText
	auto_deck MachineElectricCurrentShockDeckList, \
		MachineElectricCurrentShockDeckText, \
		MachineElectricCurrentShockDeckDescriptionText
	auto_deck MachineRiskyBlazeDeckList, \
		MachineRiskyBlazeDeckText, \
		MachineRiskyBlazeDeckDescriptionText
	auto_deck MachineRagingCharizardDeckList, \
		MachineRagingCharizardDeckText, \
		MachineRagingCharizardDeckDescriptionText
; lightning
	auto_deck MachineZapdosPowerPlantDeckList, \
		MachineZapdosPowerPlantDeckText, \
		MachineZapdosPowerPlantDeckDescriptionText
	auto_deck MachineElectricShockDeckList, \
		MachineElectricShockDeckText, \
		MachineElectricShockDeckDescriptionText
	auto_deck MachineOverflowDeckList, \
		MachineOverflowDeckText, \
		MachineOverflowDeckDescriptionText
	auto_deck MachineTripleZapdosDeckList, \
		MachineTripleZapdosDeckText, \
		MachineTripleZapdosDeckDescriptionText
; psychic
	auto_deck MachineSpecialBarrierDeckList, \
		MachineSpecialBarrierDeckText, \
		MachineSpecialBarrierDeckDescriptionText
	auto_deck MachineEvolutionProhibitedDeckList, \
		MachineEvolutionProhibitedDeckText, \
		MachineEvolutionProhibitedDeckDescriptionText
	auto_deck MachineGhostDeckList, \
		MachineGhostDeckText, \
		MachineGhostDeckDescriptionText
	auto_deck MachinePuppetMasterDeckList, \
		MachinePuppetMasterDeckText, \
		MachinePuppetMasterDeckDescriptionText
; special
	auto_deck MachineMewLv15DeckList, \
		MachineMewLv15DeckText, \
		MachineMewLv15DeckDescriptionText
	auto_deck MachineVenusaurLv64DeckList, \
		MachineVenusaurLv64DeckText, \
		MachineVenusaurLv64DeckDescriptionText
	auto_deck MachineMutualDestructionDeckList, \
		MachineMutualDestructionDeckText, \
		MachineMutualDestructionDeckDescriptionText
	auto_deck MachineEverybodySurfDeckList, \
		MachineEverybodySurfDeckText, \
		MachineEverybodySurfDeckDescriptionText
; legendary
	auto_deck MachineGrandFireDeckList, \
		MachineGrandFireDeckText, \
		MachineGrandFireDeckDescriptionText
	auto_deck MachineLegendaryFossilDeckList, \
		MachineLegendaryFossilDeckText, \
		MachineLegendaryFossilDeckDescriptionText
	auto_deck MachineWaterLegendDeckList, \
		MachineWaterLegendDeckText, \
		MachineWaterLegendDeckDescriptionText
	auto_deck MachineGreatDragonDeckList, \
		MachineGreatDragonDeckText, \
		MachineGreatDragonDeckDescriptionText

AutoDeckMachine2Entries:
; dark grass
	auto_deck MachineInsectCollectionDeckList, \
		MachineInsectCollectionDeckText, \
		MachineInsectCollectionDeckDescriptionText
	auto_deck MachineCaveExplorationDeckList, \
		MachineCaveExplorationDeckText, \
		MachineCaveExplorationDeckDescriptionText
	auto_deck MachineOminousMeadowDeckList, \
		MachineOminousMeadowDeckText, \
		MachineOminousMeadowDeckDescriptionText
	auto_deck MachineAtrociousWeezingDeckList, \
		MachineAtrociousWeezingDeckText, \
		MachineAtrociousWeezingDeckDescriptionText
; dark lightning
	auto_deck MachineTheBenchIsAlsoASurpriseDeckList, \
		MachineTheBenchIsAlsoASurpriseDeckText, MachineTheBenchIsAlsoASurpriseDeckDescriptionText
	auto_deck MachineEnergyConservationDeckList, \
		MachineEnergyConservationDeckText, \
		MachineEnergyConservationDeckDescriptionText
	auto_deck MachineSonicboomDeckList, \
		MachineSonicboomDeckText, \
		MachineSonicboomDeckDescriptionText
	auto_deck MachineRageOfTheHeavensDeckList, \
		MachineRageOfTheHeavensDeckText, \
		MachineRageOfTheHeavensDeckDescriptionText
; dark water
	auto_deck MachineDarkWaterDeckList, \
		MachineDarkWaterDeckText, \
		MachineDarkWaterDeckDescriptionText
	auto_deck MachineQuickFreezeDeckList, \
		MachineQuickFreezeDeckText, \
		MachineQuickFreezeDeckDescriptionText
	auto_deck MachineWhirlpoolShowerDeckList, \
		MachineWhirlpoolShowerDeckText, \
		MachineWhirlpoolShowerDeckDescriptionText
	auto_deck MachineWaterGangDeckList, \
		MachineWaterGangDeckText, \
		MachineWaterGangDeckDescriptionText
; dark fire
	auto_deck MachineFireballDeckList, \
		MachineFireballDeckText, \
		MachineFireballDeckDescriptionText
	auto_deck MachineCompleteCombustionDeckList, \
		MachineCompleteCombustionDeckText, \
		MachineCompleteCombustionDeckDescriptionText
	auto_deck MachineOminousSpiritFlamesDeckList, \
		MachineOminousSpiritFlamesDeckText, \
		MachineOminousSpiritFlamesDeckDescriptionText
	auto_deck MachineEternalFireDeckList, \
		MachineEternalFireDeckText, \
		MachineEternalFireDeckDescriptionText
; dark fighting
	auto_deck MachineBewareTheTrapDeckList, \
		MachineBewareTheTrapDeckText, \
		MachineBewareTheTrapDeckDescriptionText
	auto_deck MachineOgresKickDeckList, \
		MachineOgresKickDeckText, \
		MachineOgresKickDeckDescriptionText
	auto_deck MachineRockBlastDeckList, \
		MachineRockBlastDeckText, \
		MachineRockBlastDeckDescriptionText
	auto_deck MachineHeavyWorkDeckList, \
		MachineHeavyWorkDeckText, \
		MachineHeavyWorkDeckDescriptionText
; dark psychic
	auto_deck MachineSlowbrosFishingDeckList, \
		MachineSlowbrosFishingDeckText, \
		MachineSlowbrosFishingDeckDescriptionText
	auto_deck MachineDirectHitDeckList, \
		MachineDirectHitDeckText, \
		MachineDirectHitDeckDescriptionText
	auto_deck MachineBadDreamDeckList, \
		MachineBadDreamDeckText, \
		MachineBadDreamDeckDescriptionText
	auto_deck MachineBenchPanicDeckList, \
		MachineBenchPanicDeckText, \
		MachineBenchPanicDeckDescriptionText
; colorless
	auto_deck MachineSnorlaxGuardDeckList, \
		MachineSnorlaxGuardDeckText, \
		MachineSnorlaxGuardDeckDescriptionText
	auto_deck MachineEyeOfTheStormDeckList, \
		MachineEyeOfTheStormDeckText, \
		MachineEyeOfTheStormDeckDescriptionText
	auto_deck MachineSuddenGrowthDeckList, \
		MachineSuddenGrowthDeckText, \
		MachineSuddenGrowthDeckDescriptionText
	auto_deck MachineKingDragoniteDeckList, \
		MachineKingDragoniteDeckText, \
		MachineKingDragoniteDeckDescriptionText
; dark special
	auto_deck MachineDarkCharizardDeckList, \
		MachineDarkCharizardDeckText, \
		MachineDarkCharizardDeckDescriptionText
	auto_deck MachineDarkBlastoiseDeckList, \
		MachineDarkBlastoiseDeckText, \
		MachineDarkBlastoiseDeckDescriptionText
	auto_deck MachineDarkVenusaurDeckList, \
		MachineDarkVenusaurDeckText, \
		MachineDarkVenusaurDeckDescriptionText
	auto_deck MachineDarkDragoniteDeckList, \
		MachineDarkDragoniteDeckText, \
		MachineDarkDragoniteDeckDescriptionText
; rare
	auto_deck MachinePerfectHealthDeckList, \
		MachinePerfectHealthDeckText, \
		MachinePerfectHealthDeckDescriptionText
	auto_deck MachineSuperSoakerDeckList, \
		MachineSuperSoakerDeckText, \
		MachineSuperSoakerDeckDescriptionText
	auto_deck MachineHellsDemonDeckList, \
		MachineHellsDemonDeckText, \
		MachineHellsDemonDeckDescriptionText
	auto_deck MachinePremiumThunderDeckList, \
		MachinePremiumThunderDeckText, \
		MachinePremiumThunderDeckDescriptionText
; mysterious
	auto_deck MachineMysteriousMewtwoDeckList, \
		MachineMysteriousMewtwoDeckText, \
		MachineMysteriousMewtwoDeckDescriptionText
	auto_deck MachineHeavenlyLugiaDeckList, \
		MachineHeavenlyLugiaDeckText, \
		MachineHeavenlyLugiaDeckDescriptionText
	auto_deck MachineBrutalTrainersDeckList, \
		MachineBrutalTrainersDeckText, \
		MachineBrutalTrainersDeckDescriptionText
	auto_deck MachineDreadfulParalysisDeckList, \
		MachineDreadfulParalysisDeckText, \
		MachineDreadfulParalysisDeckDescriptionText
