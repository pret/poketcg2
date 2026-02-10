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

; debug menu options
	const_def
	const DEBUGMENU_POWER_ON      ; 0
	const DEBUGMENU_COIN          ; 1
	const DEBUGMENU_CONFIG        ; 2
	const DEBUGMENU_EFFECT_VIEWER ; 3
	const DEBUGMENU_CREDITS       ; 4
	const DEBUGMENU_DUEL          ; 5
	const DEBUGMENU_SLOT          ; 6

; pause menu options
	const_def
	const PAUSEMENU_STATUS  ; 0
	const PAUSEMENU_DIARY   ; 1
	const PAUSEMENU_DECK    ; 2
	const PAUSEMENU_MINICOM ; 3
	const PAUSEMENU_COIN    ; 4
	const PAUSEMENU_CONFIG  ; 5

; pc menu options
	const_def
	const PCMENU_CARD_ALBUM     ; 0
	const PCMENU_DECK_DIAGNOSIS ; 1
	const PCMENU_GLOSSARY       ; 2
	const PCMENU_PRINTER        ; 3
	const PCMENU_SHUTDOWN       ; 4

; minicom menu options
	const_def
	const MINICOMMENU_DECK_SAVE_MACHINE ; 0
	const MINICOMMENU_MAILBOX           ; 1
	const MINICOMMENU_CARD_ALBUM        ; 2

; deck save machine options
	const_def
	const DECKSAVEMACHINEMENU_SAVE   ; 0
	const DECKSAVEMACHINEMENU_DELETE ; 1
	const DECKSAVEMACHINEMENU_BUILD  ; 2
	const DECKSAVEMACHINEMENU_CANCEL ; 3

; auto deck machine options
	const_def
	const AUTODECKMACHINEMENU_BUILD  ; 0
	const AUTODECKMACHINEMENU_CANCEL ; 1
	const AUTODECKMACHINEMENU_READ   ; 2

; mailbox options
	const_def
	const MAILBOXMENU_READ   ; 0
	const MAILBOXMENU_DELETE ; 1

; gift center menu options
	const_def
	const GIFTCENTERMENU_SEND_CARDS                 ; 0
	const GIFTCENTERMENU_RECEIVE_CARDS              ; 1
	const GIFTCENTERMENU_SEND_DECK_CONFIGURATION    ; 2
	const GIFTCENTERMENU_RECEIVE_DECK_CONFIGURATION ; 3
	const GIFTCENTERMENU_QUIT                       ; 4

; constants for wGlossaryMenu
	const_def
	const GLOSSARY_GAME_BASICS            ; 0
	const GLOSSARY_CARD_TYPE_EXPLANATIONS ; 1
	const GLOSSARY_STATUS_WINNING_LOSING  ; 2
	const GLOSSARY_SPECIAL_DUEL_RULES     ; 3
	const GLOSSARY_EXIT                   ; 4

; pop-up menu index
	const_def
	const POPUPMENU_SAM_RULES           ; $0
	const POPUPMENU_SAM                 ; $1
	const POPUPMENU_AARON_1             ; $2
	const POPUPMENU_AARON_2             ; $3
	const POPUPMENU_AARON_3             ; $4
	const POPUPMENU_AARON_4             ; $5
	const POPUPMENU_CARD_DUNGEON_KNIGHT ; $6
	const POPUPMENU_CARD_DUNGEON_BISHOP ; $7
	const POPUPMENU_CARD_DUNGEON_ROOK   ; $8
	const POPUPMENU_CARD_DUNGEON_QUEEN  ; $9
	const POPUPMENU_CARD_DUNGEON_PAWN   ; $a

; for menu items, PlaySFXConfirmOrCancel, etc.
DEF MENU_CANCEL  EQU -1
DEF MENU_CONFIRM EQU  1 ; != -1, but uses 1 most of the time

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
DEF NO_FILTERS  EQU $ff

DEF FILTERED_CARD_LIST_SIZE EQU 80
DEF FILTERED_CARD_LIST_SIZE_BYTES EQU FILTERED_CARD_LIST_SIZE * 2

; for FilterCardListInHL
DEF FILTER_ONLY_PKMN    EQU 0
DEF FILTER_ONLY_TRAINER EQU FILTER_TRAINER >> 4 ; 1
DEF FILTER_ONLY_ENERGY  EQU FILTER_ENERGY  >> 4 ; 2, or any number > 1

DEF NUM_DECK_CONFIRMATION_VISIBLE_CARDS EQU 7
DEF NUM_FILTERED_LIST_VISIBLE_CARDS     EQU 6
DEF NUM_DECK_STATUS_LIST_VISIBLE_CARDS  EQU 5

DEF NUM_DECK_SAVE_MACHINE_SLOTS    EQU 50
DEF NUM_DECK_MACHINE_VISIBLE_SLOTS EQU 5  ; decks or categories
DEF NUM_AUTO_DECK_MACHINE_SLOTS    EQU 4

; auto deck machine 1
	const_def
	const AUTO_DECK_BASIC     ; 0
	const AUTO_DECK_GIVEN     ; 1
	const AUTO_DECK_FIGHTING  ; 2
	const AUTO_DECK_GRASS     ; 3
	const AUTO_DECK_WATER     ; 4
	const AUTO_DECK_FIRE      ; 5
	const AUTO_DECK_LIGHTNING ; 6
	const AUTO_DECK_PSYCHIC   ; 7
DEF NUM_AUTO_DECK_MACHINE_REGULAR_CATEGORIES EQU const_value ; shared with machine 2
	const AUTO_DECK_SPECIAL   ; 8
	const AUTO_DECK_LEGENDARY ; 9
DEF NUM_AUTO_DECK_MACHINE_CATEGORIES EQU const_value ; shared with machine 2

; auto deck machine 2
	const_def
	const AUTO_DECK_DARK_GRASS     ; 0
	const AUTO_DECK_DARK_LIGHTNING ; 1
	const AUTO_DECK_DARK_WATER     ; 2
	const AUTO_DECK_DARK_FIRE      ; 3
	const AUTO_DECK_DARK_FIGHTING  ; 4
	const AUTO_DECK_DARK_PSYCHIC   ; 5
	const AUTO_DECK_COLORLESS      ; 6
	const AUTO_DECK_DARK_SPECIAL   ; 7
	const AUTO_DECK_SUPER_RARE     ; 8
	const AUTO_DECK_MYSTERIOUS     ; 9

; auto_deck args
DEF AUTO_DECK_ENTRY_SIZE EQU 6

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
