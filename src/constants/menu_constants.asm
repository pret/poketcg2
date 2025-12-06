; start menu configurations
	const_def

	; New Game
	const STARTMENU_CONFIG_0 ; 0

	; Continue From Diary
	; New Game
	const STARTMENU_CONFIG_1 ; 1

	; Card Pop!
	; Continue From Diary
	; New Game
	const STARTMENU_CONFIG_2 ; 2

	; Card Pop!
	; Continue From Diary
	; New Game
	; Continue Duel
	const STARTMENU_CONFIG_3 ; 3

	; Continue From Diary
	; New Game
	; Continue Duel
	const STARTMENU_CONFIG_4 ; 4

; start menu options
	const_def
	const STARTMENU_CARD_POP            ; 0
	const STARTMENU_CONTINUE_FROM_DIARY ; 1
	const STARTMENU_NEW_GAME            ; 2
	const STARTMENU_CONTINUE_DUEL       ; 3

; constants for wGlossaryMenu
	const_def
	const GLOSSARY_GAME_BASICS            ; $0
	const GLOSSARY_CARD_TYPE_EXPLANATIONS ; $1
	const GLOSSARY_STATUS_WINNING_LOSING  ; $2
	const GLOSSARY_SPECIAL_DUEL_RULES     ; $3
	const GLOSSARY_EXIT                   ; $4

; filter types for CardTypeFilters
; used to categorise the different cards
; i.e. in the deck building screen
DEF FILTER_FIRE      EQUS "TYPE_PKMN_FIRE"
DEF FILTER_GRASS     EQUS "TYPE_PKMN_GRASS"
DEF FILTER_LIGHTNING EQUS "TYPE_PKMN_LIGHTNING"
DEF FILTER_WATER     EQUS "TYPE_PKMN_WATER"
DEF FILTER_FIGHTING  EQUS "TYPE_PKMN_FIGHTING"
DEF FILTER_PSYCHIC   EQUS "TYPE_PKMN_PSYCHIC"
DEF FILTER_COLORLESS EQUS "TYPE_PKMN_COLORLESS"
DEF FILTER_TRAINER   EQUS "TYPE_TRAINER"
DEF FILTER_ENERGY    EQU $20

DEF NUM_FILTERS EQU 9

DEF NUM_DECK_CONFIRMATION_VISIBLE_CARDS EQU 7
DEF NUM_FILTERED_LIST_VISIBLE_CARDS     EQU 6

DEF NUM_DECK_SAVE_MACHINE_SLOTS EQU 50
DEF NUM_DECK_MACHINE_VISIBLE_DECKS EQU 5

; deck flags
	const_def
	const DECK_1_F ; $0
	const DECK_2_F ; $1
	const DECK_3_F ; $2
	const DECK_4_F ; $3

DEF DECK_1 EQU 1 << DECK_1_F ; $1
DEF DECK_2 EQU 1 << DECK_2_F ; $2
DEF DECK_3 EQU 1 << DECK_3_F ; $4
DEF DECK_4 EQU 1 << DECK_4_F ; $8

DEF ALL_DECKS EQU $ff

; flags in wOwnedPhantomCards
	const_def
	const PROMO_VENUSAUR_LV64_F          ; $0
	const PROMO_MEW_LV15_F               ; $1
	const PROMO_LUGIA_F                  ; $2
	const PROMO_HERE_COMES_TEAM_ROCKET_F ; $3

DEF PROMO_VENUSAUR_LV64          EQU (1 << PROMO_VENUSAUR_LV64_F)
DEF PROMO_MEW_LV15               EQU (1 << PROMO_MEW_LV15_F)
DEF PROMO_LUGIA                  EQU (1 << PROMO_LUGIA_F)
DEF PROMO_HERE_COMES_TEAM_ROCKET EQU (1 << PROMO_HERE_COMES_TEAM_ROCKET_F)

; TODO find a way to not have these hardcoded?
DEF NUM_CARDS_BEGINNING_POKEMON     EQU 66
DEF NUM_CARDS_LEGENDARY_POWER       EQU 61
DEF NUM_CARDS_ISLAND_OF_FOSSIL      EQU 59
DEF NUM_CARDS_PSYCHIC_BATTLE        EQU 54
DEF NUM_CARDS_SKY_FLYING_POKEMON    EQU 56
DEF NUM_CARDS_WE_ARE_TEAM_ROCKET    EQU 50
DEF NUM_CARDS_TEAM_ROCKETS_AMBITION EQU 50
DEF NUM_CARDS_PROMOTIONAL           EQU 45 ; doesn't include Phantom cards
