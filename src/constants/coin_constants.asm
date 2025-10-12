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
	const COIN_SENTINEL   ; $18
; checking GR Coin pieces may temporarily result in $18 + [0, 7]
; the values for GR_PIECEs are used in calls to give_coin event script
	const COIN_GR_PIECE1  ; $19
	const COIN_GR_PIECE2  ; $1a
	const COIN_GR_DUMMY2  ; $1b
	const COIN_GR_PIECE3  ; $1c
	const COIN_GR_DUMMY3  ; $1d
	const COIN_GR_DUMMY4  ; $1e
	const COIN_GR_DUMMY5  ; $1f
	const COIN_GR_PIECE4  ; $20

; coin types, also used for pagination
	const_def
	const COIN_TYPE_TCG_ISLAND ; $0
	const COIN_TYPE_GR_ISLAND  ; $1
	const COIN_TYPE_SPECIAL    ; $2

DEF NUM_COIN_TYPES EQU const_value

; gfx/text order, slightly different
	const_def
	const GFX_COIN_CHANSEY    ; $00
	const GFX_COIN_GR         ; $01
	const GFX_COIN_ODDISH     ; $02
	const GFX_COIN_CHARMANDER ; $03
	const GFX_COIN_STARMIE    ; $04
	const GFX_COIN_PIKACHU    ; $05
	const GFX_COIN_ALAKAZAM   ; $06
	const GFX_COIN_KABUTO     ; $07
	const GFX_COIN_GOLBAT     ; $08
	const GFX_COIN_MAGNEMITE  ; $09
	const GFX_COIN_MAGMAR     ; $0a
	const GFX_COIN_PSYDUCK    ; $0b
	const GFX_COIN_MACHAMP    ; $0c
	const GFX_COIN_MEW        ; $0d
	const GFX_COIN_SNORLAX    ; $0e
	const GFX_COIN_TOGEPI     ; $0f
	const GFX_COIN_PONYTA     ; $10
	const GFX_COIN_HORSEA     ; $11
	const GFX_COIN_ARBOK      ; $12
	const GFX_COIN_JIGGLYPUFF ; $13
	const GFX_COIN_DUGTRIO    ; $14
	const GFX_COIN_GENGAR     ; $15
	const GFX_COIN_RAICHU     ; $16
	const GFX_COIN_LUGIA      ; $17
	const GFX_COIN_GR_DUMMY1  ; $18
	const GFX_COIN_GR_PIECE1  ; $19
	const GFX_COIN_GR_PIECE2  ; $1a
	const GFX_COIN_GR_DUMMY2  ; $1b
	const GFX_COIN_GR_PIECE3  ; $1c
	const GFX_COIN_GR_DUMMY3  ; $1d
	const GFX_COIN_GR_DUMMY4  ; $1e
	const GFX_COIN_GR_DUMMY5  ; $1f
	const GFX_COIN_GR_PIECE4  ; $20
	const GFX_COIN_GR_DUMMY6  ; $21
	const GFX_COIN_GR_DUMMY7  ; $22
	const GFX_COIN_GR_DUMMY8  ; $23
	const GFX_COIN_GR_DUMMY9  ; $24
	const GFX_COIN_GR_DUMMY10 ; $25
	const GFX_COIN_GR_DUMMY11 ; $26
	const GFX_COIN_GR_DUMMY12 ; $27

DEF NUM_GFX_MAIN_COINS EQU const_value ; $28
