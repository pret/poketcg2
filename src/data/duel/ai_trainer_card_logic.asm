MACRO? ai_trainer_card_logic
	db \1 ; AI_TRAINER_CARD_PHASE_* constant
	dw \2 ; ID of trainer card
	dw \3 ; function for AI decision to play card
	dw \4 ; function for AI playing the card
ENDM

AITrainerCardLogic:
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_07, POTION,                 AIDecide_Potion_Phase07,                 AIPlay_Potion
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_10, POTION,                 AIDecide_Potion_Phase10,                 AIPlay_Potion
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_11, POTION,                 AIDecide_Potion_Phase11,                 AIPlay_Potion
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_08, SUPER_POTION,           AIDecide_SuperPotion_Phase08,            AIPlay_SuperPotion
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_11, SUPER_POTION,           AIDecide_SuperPotion_Phase11,            AIPlay_SuperPotion
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_13, SUPER_POTION,           AIDecide_SuperPotion_Phase13,            AIPlay_SuperPotion
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_13, DEFENDER,               AIDecide_Defender_Phase13,               AIPlay_Defender
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_14, DEFENDER,               AIDecide_Defender_Phase14,               AIPlay_Defender
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_13, PLUSPOWER,              AIDecide_PlusPower_Phase13,              AIPlay_PlusPower
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_14, PLUSPOWER,              AIDecide_PlusPower_Phase14,              AIPlay_PlusPower
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_09, SWITCH,                 AIDecide_Switch_Phase09,                 AIPlay_Switch
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_16, SWITCH,                 AIDecide_Switch_Phase16,                 AIPlay_Switch
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_07, GUST_OF_WIND,           AIDecide_GustOfWind,                     AIPlay_GustOfWind
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_10, GUST_OF_WIND,           AIDecide_GustOfWind,                     AIPlay_GustOfWind
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_04, BILL,                   AIDecide_Bill,                           AIPlay_Bill
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_05, ENERGY_REMOVAL,         AIDecide_EnergyRemoval,                  AIPlay_EnergyRemoval
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_05, SUPER_ENERGY_REMOVAL,   AIDecide_SuperEnergyRemoval,             AIPlay_SuperEnergyRemoval
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_07, POKEMON_BREEDER,        AIDecide_PokemonBreeder,                 AIPlay_PokemonBreeder
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_15, PROFESSOR_OAK,          AIDecide_ProfessorOak,                   AIPlay_ProfessorOak
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_10, ENERGY_RETRIEVAL,       AIDecide_EnergyRetrieval,                AIPlay_EnergyRetrieval
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_11, SUPER_ENERGY_RETRIEVAL, AIDecide_SuperEnergyRetrieval,           AIPlay_SuperEnergyRetrieval
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_06, POKEMON_CENTER,         AIDecide_PokemonCenter,                  AIPlay_PokemonCenter
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_07, IMPOSTER_PROFESSOR_OAK, AIDecide_ImposterProfessorOak,           AIPlay_ImposterProfessorOak
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_12, ENERGY_SEARCH,          AIDecide_EnergySearch,                   AIPlay_EnergySearch
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_03, POKEDEX,                AIDecide_Pokedex,                        AIPlay_Pokedex
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_07, FULL_HEAL,              AIDecide_FullHeal,                       AIPlay_FullHeal
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_10, MR_FUJI,                AIDecide_MrFuji,                         AIPlay_MrFuji
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_10, SCOOP_UP,               AIDecide_ScoopUp,                        AIPlay_ScoopUp
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_02, MAINTENANCE,            AIDecide_Maintenance,                    AIPlay_Maintenance
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_03, RECYCLE,                AIDecide_Recycle,                        AIPlay_Recycle
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_13, LASS,                   AIDecide_Lass,                           AIPlay_Lass
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_04, ITEMFINDER,             AIDecide_ItemFinder,                     AIPlay_ItemFinder
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_01, IMAKUNI_CARD,           AIDecide_Imakuni,                        AIPlay_Imakuni
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_01, GAMBLER,                AIDecide_Gambler,                        AIPlay_Gambler
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_05, REVIVE,                 AIDecide_Revive,                         AIPlay_Revive
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_06, POKEMON_FLUTE,          AIDecide_PokemonFlute,                   AIPlay_PokemonFlute
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_05, CLEFAIRY_DOLL,          AIDecide_ClefairyDollOrMysteriousFossil, AIPlay_ClefairyDollOrMysteriousFossil
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_05, MYSTERIOUS_FOSSIL,      AIDecide_ClefairyDollOrMysteriousFossil, AIPlay_ClefairyDollOrMysteriousFossil
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_02, POKEBALL,               AIDecide_Pokeball,                       AIPlay_Pokeball
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_02, COMPUTER_SEARCH,        AIDecide_ComputerSearch,                 AIPlay_ComputerSearch
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_02, POKEMON_TRADER,         AIDecide_PokemonTrader,                  AIPlay_PokemonTrader
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_02, THE_BOSSS_WAY,          AIDecide_TheBosssWay,                    AIPlay_TheBosssWay
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_04, NIGHTLY_GARBAGE_RUN,    AIDecide_NightlyGarbageRun,              AIPlay_NightlyGarbageRun
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_04, FOSSIL_EXCAVATION,      AIDecide_FossilExcavation,               AIPlay_FossilExcavation
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_12, SLEEP,                  AIDecide_Sleep,                          AIPlay_Sleep
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_02, POKEMON_RECALL,         AIDecide_PokemonRecall,                  AIPlay_PokemonRecall
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_02, MASTER_BALL,            AIDecide_MasterBall,                     AIPlay_MasterBall
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_04, BILLS_TELEPORTER,       AIDecide_BillsTeleporter,                AIPlay_BillsTeleporter
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_02, MOON_STONE,             AIDecide_MoonStone,                      AIPlay_MoonStone
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_08, THE_ROCKETS_TRAP,       AIDecide_TheRocketsTrap,                 AIPlay_TheRocketsTrap
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_17, GOOP_GAS_ATTACK,        AIDecide_GoopGasAttack,                  AIPlay_GoopGasAttack
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_07, IMPOSTER_OAKS_REVENGE,  AIDecide_ImposterOaksRevenge,            AIPlay_ImposterOaksRevenge
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_01, DIGGER,                 AIDecide_Digger,                         AIPlay_Digger
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_17, COMPUTER_ERROR,         AIDecide_ComputerError,                  AIPlay_ComputerError
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_10, SUPER_SCOOP_UP,         AIDecide_SuperScoopUp,                   AIPlay_SuperScoopUp
	db $ff
