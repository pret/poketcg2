; coins
	const_def
	const COIN_CHANSEY    ; $00
	const COIN_GR         ; $01
	const COIN_ODDISH     ; $02
	const COIN_CHARMANDER ; $03
	const COIN_STARMIE    ; $04
	const COIN_PIKACHU    ; $05
	const COIN_ALAKAZAM   ; $06
	const COIN_KABUTO     ; $07
	const COIN_GOLBAT     ; $08
	const COIN_MAGNEMITE  ; $09
	const COIN_MAGMAR     ; $0a
	const COIN_PSYDUCK    ; $0b
	const COIN_MACHAMP    ; $0c
	const COIN_MEW        ; $0d
	const COIN_SNORLAX    ; $0e
	const COIN_TOGEPI     ; $0f
	const COIN_PONYTA     ; $10
	const COIN_HORSEA     ; $11
	const COIN_ARBOK      ; $12
	const COIN_JIGGLYPUFF ; $13
	const COIN_DUGTRIO    ; $14
	const COIN_GENGAR     ; $15
	const COIN_RAICHU     ; $16
	const COIN_LUGIA      ; $17
DEF NUM_COINS EQU const_value
	const COIN_GR_START   ; $18

; handling GR Coin pieces uses COIN_GR_START + [0, 15]
	const_def
	const COIN_GR_PIECE1_F ; 0
	const COIN_GR_PIECE2_F ; 1
	const COIN_GR_PIECE3_F ; 2
	const COIN_GR_PIECE4_F ; 3

DEF COIN_GR_PIECE1 EQU 1 << COIN_GR_PIECE1_F ; 1
DEF COIN_GR_PIECE2 EQU 1 << COIN_GR_PIECE2_F ; 2
DEF COIN_GR_PIECE3 EQU 1 << COIN_GR_PIECE3_F ; 4
DEF COIN_GR_PIECE4 EQU 1 << COIN_GR_PIECE4_F ; 8

DEF NUM_COIN_GFX EQU COIN_GR_START + (COIN_GR_PIECE1 | COIN_GR_PIECE2 | COIN_GR_PIECE3 | COIN_GR_PIECE4) + 1 ; $28

; coin types, also used for pagination
	const_def
	const COIN_TYPE_TCG_ISLAND ; $0
	const COIN_TYPE_GR_ISLAND  ; $1
	const COIN_TYPE_SPECIAL    ; $2

DEF NUM_COIN_TYPES EQU const_value
