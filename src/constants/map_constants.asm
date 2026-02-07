; island constants
; for wCurIsland, challenge cups/machines, etc.
DEF TCG_ISLAND EQU $0
DEF GR_ISLAND  EQU $1

	; MAP_*
	; used in map scripts, and other places.
	; see also: bank03.asm:MapHeaderPtrs
	const_def
	const OVERWORLD_MAP_TCG                  ; $00
	const OVERWORLD_MAP_GR                   ; $01
	const MAP_MASON_LABORATORY_MAIN          ; $02
	const MAP_MASON_LABORATORY_COMPUTER_ROOM ; $03
	const MAP_MASON_LABORATORY_TRAINING_ROOM ; $04
	const MAP_ISHIHARAS_HOUSE                ; $05
	const MAP_LIGHTNING_CLUB_ENTRANCE        ; $06
	const MAP_LIGHTNING_CLUB_LOBBY           ; $07
	const MAP_LIGHTNING_CLUB                 ; $08
	const MAP_PSYCHIC_CLUB_ENTRANCE          ; $09
	const MAP_PSYCHIC_CLUB_LOBBY             ; $0a
	const MAP_PSYCHIC_CLUB                   ; $0b
	const MAP_ROCK_CLUB_ENTRANCE             ; $0c
	const MAP_ROCK_CLUB_LOBBY                ; $0d
	const MAP_ROCK_CLUB                      ; $0e
	const MAP_FIGHTING_CLUB_ENTRANCE         ; $0f
	const MAP_FIGHTING_CLUB_LOBBY            ; $10
	const MAP_FIGHTING_CLUB                  ; $11
	const MAP_GRASS_CLUB_ENTRANCE            ; $12
	const MAP_GRASS_CLUB_LOBBY               ; $13
	const MAP_GRASS_CLUB                     ; $14
	const MAP_SCIENCE_CLUB_ENTRANCE          ; $15
	const MAP_SCIENCE_CLUB_LOBBY             ; $16
	const MAP_SCIENCE_CLUB                   ; $17
	const MAP_WATER_CLUB_ENTRANCE            ; $18
	const MAP_WATER_CLUB_LOBBY               ; $19
	const MAP_WATER_CLUB                     ; $1a
	const MAP_FIRE_CLUB_ENTRANCE             ; $1b
	const MAP_FIRE_CLUB_LOBBY                ; $1c
	const MAP_FIRE_CLUB                      ; $1d
	const MAP_TCG_AIRPORT_ENTRANCE           ; $1e
	const MAP_TCG_AIRPORT                    ; $1f
	const MAP_TCG_CHALLENGE_HALL_ENTRANCE    ; $20
	const MAP_TCG_CHALLENGE_HALL_LOBBY       ; $21
	const MAP_TCG_CHALLENGE_HALL             ; $22
	const MAP_POKEMON_DOME_ENTRANCE          ; $23
	const MAP_POKEMON_DOME                   ; $24
	const MAP_POKEMON_DOME_BACK              ; $25
	const MAP_OVERHEAD_ISLANDS               ; $26
	const MAP_GR_AIRPORT_ENTRANCE            ; $27
	const MAP_GR_AIRPORT                     ; $28
	const MAP_ISHIHARAS_VILLA_MAIN           ; $29
	const MAP_ISHIHARAS_VILLA_LIBRARY        ; $2a
	const MAP_GAME_CENTER_ENTRANCE           ; $2b
	const MAP_GAME_CENTER_LOBBY              ; $2c
	const MAP_GAME_CENTER_1                  ; $2d
	const MAP_GAME_CENTER_2                  ; $2e
	const MAP_CARD_DUNGEON_PAWN              ; $2f
	const MAP_CARD_DUNGEON_KNIGHT            ; $30
	const MAP_CARD_DUNGEON_BISHOP            ; $31
	const MAP_CARD_DUNGEON_ROOK              ; $32
	const MAP_CARD_DUNGEON_QUEEN             ; $33
	const MAP_SEALED_FORT_ENTRANCE           ; $34
	const MAP_SEALED_FORT                    ; $35
	const MAP_GR_CHALLENGE_HALL_ENTRANCE     ; $36
	const MAP_GR_CHALLENGE_HALL_LOBBY        ; $37
	const MAP_GR_CHALLENGE_HALL              ; $38
	const MAP_GRASS_FORT_ENTRANCE            ; $39
	const MAP_GRASS_FORT_LOBBY               ; $3a
	const MAP_GRASS_FORT_MIDORI              ; $3b
	const MAP_GRASS_FORT_YUTA                ; $3c
	const MAP_GRASS_FORT_MIYUKI              ; $3d
	const MAP_GRASS_FORT_MORINO              ; $3e
	const MAP_LIGHTNING_FORT_ENTRANCE        ; $3f
	const MAP_LIGHTNING_FORT_LOBBY           ; $40
	const MAP_LIGHTNING_FORT_RENNA           ; $41
	const MAP_LIGHTNING_FORT_ICHIKAWA        ; $42
	const MAP_LIGHTNING_FORT_CATHERINE       ; $43
	const MAP_FIRE_FORT_ENTRANCE             ; $44
	const MAP_FIRE_FORT_LOBBY                ; $45
	const MAP_FIRE_FORT_JES                  ; $46
	const MAP_FIRE_FORT_YUKI                 ; $47
	const MAP_FIRE_FORT_SHOKO                ; $48
	const MAP_FIRE_FORT_HIDERO               ; $49
	const MAP_WATER_FORT_ENTRANCE            ; $4a
	const MAP_WATER_FORT_LOBBY               ; $4b
	const MAP_WATER_FORT_MIYAJIMA            ; $4c
	const MAP_WATER_FORT_SENTA               ; $4d
	const MAP_WATER_FORT_AIRA                ; $4e
	const MAP_WATER_FORT_KANOKO              ; $4f
	const MAP_FIGHTING_FORT_ENTRANCE         ; $50
	const MAP_FIGHTING_FORT                  ; $51
	const MAP_FIGHTING_FORT_MAZE_1           ; $52
	const MAP_FIGHTING_FORT_MAZE_2           ; $53
	const MAP_FIGHTING_FORT_MAZE_3           ; $54
	const MAP_FIGHTING_FORT_MAZE_4           ; $55
	const MAP_FIGHTING_FORT_MAZE_5           ; $56
	const MAP_FIGHTING_FORT_MAZE_6           ; $57
	const MAP_FIGHTING_FORT_MAZE_7           ; $58
	const MAP_FIGHTING_FORT_MAZE_8           ; $59
	const MAP_FIGHTING_FORT_MAZE_9           ; $5a
	const MAP_FIGHTING_FORT_MAZE_10          ; $5b
	const MAP_FIGHTING_FORT_MAZE_11          ; $5c
	const MAP_FIGHTING_FORT_MAZE_12          ; $5d
	const MAP_FIGHTING_FORT_MAZE_13          ; $5e
	const MAP_FIGHTING_FORT_MAZE_14          ; $5f
	const MAP_FIGHTING_FORT_MAZE_15          ; $60
	const MAP_FIGHTING_FORT_MAZE_16          ; $61
	const MAP_FIGHTING_FORT_MAZE_17          ; $62
	const MAP_FIGHTING_FORT_MAZE_18          ; $63
	const MAP_FIGHTING_FORT_MAZE_19          ; $64
	const MAP_FIGHTING_FORT_MAZE_20          ; $65
	const MAP_FIGHTING_FORT_MAZE_21          ; $66
	const MAP_FIGHTING_FORT_MAZE_22          ; $67
	const MAP_FIGHTING_FORT_BASEMENT         ; $68
	const MAP_FIGHTING_FORT_GODA             ; $69
	const MAP_FIGHTING_FORT_GRACE            ; $6a
	const MAP_PSYCHIC_STRONGHOLD_ENTRANCE    ; $6b
	const MAP_PSYCHIC_STRONGHOLD_LOBBY       ; $6c
	const MAP_PSYCHIC_STRONGHOLD             ; $6d
	const MAP_PSYCHIC_STRONGHOLD_MAMI        ; $6e
	const MAP_COLORLESS_ALTAR_ENTRANCE       ; $6f
	const MAP_COLORLESS_ALTAR                ; $70
	const MAP_GR_CASTLE_ENTRANCE             ; $71
	const MAP_GR_CASTLE                      ; $72
	const MAP_GR_CASTLE_BIRURITCHI           ; $73
	const_def -1
	const MAP_NONE                           ; $ff

	; MAP_GFX_*
	; referenced in MapHeaders, and others. see also: data/map_gfx.asm
	; only 2 maps have alternate graphics: MAP_LIGHTNING_CLUB, MAP_GFX_GR_CHALLENGE_HALL
	; note that the constant values are largely different from the corresponding MAP_*
	const_def
	const OVERWORLD_MAP_GFX_TCG                  ; $00
	const OVERWORLD_MAP_GFX_GR                   ; $01
	const MAP_GFX_MASON_LABORATORY_MAIN          ; $02
	const MAP_GFX_MASON_LABORATORY_COMPUTER_ROOM ; $03
	const MAP_GFX_MASON_LABORATORY_TRAINING_ROOM ; $04
	const MAP_GFX_ISHIHARAS_HOUSE                ; $05
	const MAP_GFX_LIGHTNING_CLUB_ENTRANCE        ; $06
	const MAP_GFX_LIGHTNING_CLUB_LOBBY           ; $07
	const MAP_GFX_LIGHTNING_CLUB_1               ; $08
	const MAP_GFX_LIGHTNING_CLUB_2               ; $09 - main club room after defeating GR
	const MAP_GFX_PSYCHIC_CLUB_ENTRANCE          ; $0a
	const MAP_GFX_PSYCHIC_CLUB_LOBBY             ; $0b
	const MAP_GFX_PSYCHIC_CLUB                   ; $0c
	const MAP_GFX_ROCK_CLUB_ENTRANCE             ; $0d
	const MAP_GFX_ROCK_CLUB_LOBBY                ; $0e
	const MAP_GFX_ROCK_CLUB                      ; $0f
	const MAP_GFX_FIGHTING_CLUB_ENTRANCE         ; $10
	const MAP_GFX_FIGHTING_CLUB_LOBBY            ; $11
	const MAP_GFX_FIGHTING_CLUB                  ; $12
	const MAP_GFX_GRASS_CLUB_ENTRANCE            ; $13
	const MAP_GFX_GRASS_CLUB_LOBBY               ; $14
	const MAP_GFX_GRASS_CLUB                     ; $15
	const MAP_GFX_SCIENCE_CLUB_ENTRANCE          ; $16
	const MAP_GFX_SCIENCE_CLUB_LOBBY             ; $17
	const MAP_GFX_SCIENCE_CLUB                   ; $18
	const MAP_GFX_WATER_CLUB_ENTRANCE            ; $19
	const MAP_GFX_WATER_CLUB_LOBBY               ; $1a
	const MAP_GFX_WATER_CLUB                     ; $1b
	const MAP_GFX_FIRE_CLUB_ENTRANCE             ; $1c
	const MAP_GFX_FIRE_CLUB_LOBBY                ; $1d
	const MAP_GFX_FIRE_CLUB                      ; $1e
	const MAP_GFX_TCG_AIRPORT_ENTRANCE           ; $1f
	const MAP_GFX_TCG_AIRPORT                    ; $20
	const MAP_GFX_TCG_CHALLENGE_HALL_ENTRANCE    ; $21
	const MAP_GFX_TCG_CHALLENGE_HALL_LOBBY       ; $22
	const MAP_GFX_TCG_CHALLENGE_HALL             ; $23
	const MAP_GFX_POKEMON_DOME_ENTRANCE          ; $24
	const MAP_GFX_POKEMON_DOME                   ; $25
	const MAP_GFX_OVERHEAD_ISLANDS               ; $26
	const MAP_GFX_GR_AIRPORT_ENTRANCE            ; $27
	const MAP_GFX_GR_AIRPORT                     ; $28
	const MAP_GFX_ISHIHARAS_VILLA_MAIN           ; $29
	const MAP_GFX_ISHIHARAS_VILLA_LIBRARY        ; $2a
	const MAP_GFX_GAME_CENTER_ENTRANCE           ; $2b
	const MAP_GFX_GAME_CENTER_LOBBY              ; $2c
	const MAP_GFX_GAME_CENTER_1                  ; $2d
	const MAP_GFX_GAME_CENTER_2                  ; $2e
	const MAP_GFX_CARD_DUNGEON_PAWN              ; $2f
	const MAP_GFX_CARD_DUNGEON_KNIGHT            ; $30
	const MAP_GFX_CARD_DUNGEON_BISHOP            ; $31
	const MAP_GFX_CARD_DUNGEON_ROOK              ; $32
	const MAP_GFX_CARD_DUNGEON_QUEEN             ; $33
	const MAP_GFX_SEALED_FORT_ENTRANCE           ; $34
	const MAP_GFX_SEALED_FORT                    ; $35
	const MAP_GFX_GR_CHALLENGE_HALL_ENTRANCE     ; $36
	const MAP_GFX_GR_CHALLENGE_HALL_LOBBY        ; $37
	const MAP_GFX_GR_CHALLENGE_HALL              ; $38
	const MAP_GFX_GRASS_FORT_ENTRANCE            ; $39
	const MAP_GFX_GRASS_FORT_LOBBY               ; $3a
	const MAP_GFX_GRASS_FORT_MIDORI              ; $3b
	const MAP_GFX_GRASS_FORT_YUTA                ; $3c
	const MAP_GFX_GRASS_FORT_MIYUKI              ; $3d
	const MAP_GFX_GRASS_FORT_MORINO              ; $3e
	const MAP_GFX_LIGHTNING_FORT_ENTRANCE        ; $3f
	const MAP_GFX_LIGHTNING_FORT_LOBBY           ; $40
	const MAP_GFX_LIGHTNING_FORT_RENNA           ; $41
	const MAP_GFX_LIGHTNING_FORT_ICHIKAWA        ; $42
	const MAP_GFX_LIGHTNING_FORT_CATHERINE       ; $43
	const MAP_GFX_FIRE_FORT_ENTRANCE             ; $44
	const MAP_GFX_FIRE_FORT_LOBBY                ; $45
	const MAP_GFX_FIRE_FORT_JES                  ; $46
	const MAP_GFX_FIRE_FORT_YUKI                 ; $47
	const MAP_GFX_FIRE_FORT_SHOKO                ; $48
	const MAP_GFX_FIRE_FORT_HIDERO               ; $49
	const MAP_GFX_WATER_FORT_ENTRANCE            ; $4a
	const MAP_GFX_WATER_FORT_LOBBY               ; $4b
	const MAP_GFX_WATER_FORT_MIYAJIMA            ; $4c
	const MAP_GFX_WATER_FORT_SENTA               ; $4d
	const MAP_GFX_WATER_FORT_AIRA                ; $4e
	const MAP_GFX_WATER_FORT_KANOKO              ; $4f
	const MAP_GFX_FIGHTING_FORT_ENTRANCE         ; $50
	const MAP_GFX_FIGHTING_FORT                  ; $51
	const MAP_GFX_FIGHTING_FORT_MAZE_1           ; $52
	const MAP_GFX_FIGHTING_FORT_MAZE_2           ; $53
	const MAP_GFX_FIGHTING_FORT_MAZE_3           ; $54
	const MAP_GFX_FIGHTING_FORT_MAZE_4           ; $55
	const MAP_GFX_FIGHTING_FORT_MAZE_5           ; $56
	const MAP_GFX_FIGHTING_FORT_MAZE_6           ; $57
	const MAP_GFX_FIGHTING_FORT_GODA             ; $58
	const MAP_GFX_FIGHTING_FORT_GRACE            ; $59
	const MAP_GFX_PSYCHIC_STRONGHOLD_ENTRANCE    ; $5a
	const MAP_GFX_PSYCHIC_STRONGHOLD_LOBBY       ; $5b
	const MAP_GFX_PSYCHIC_STRONGHOLD             ; $5c
	const MAP_GFX_PSYCHIC_STRONGHOLD_MAMI        ; $5d
	const MAP_GFX_COLORLESS_ALTAR_ENTRANCE       ; $5e
	const MAP_GFX_COLORLESS_ALTAR                ; $5f
	const MAP_GFX_GR_CASTLE_ENTRANCE             ; $60
	const MAP_GFX_GR_CASTLE                      ; $61
	const MAP_GFX_GR_CASTLE_BIRURITCHI           ; $62
	const MAP_GFX_POKEMON_DOME_BACK              ; $63
	const MAP_GFX_FIGHTING_FORT_MAZE_7           ; $64
	const MAP_GFX_FIGHTING_FORT_MAZE_8           ; $65
	const MAP_GFX_FIGHTING_FORT_MAZE_9           ; $66
	const MAP_GFX_FIGHTING_FORT_MAZE_10          ; $67
	const MAP_GFX_FIGHTING_FORT_MAZE_11          ; $68
	const MAP_GFX_FIGHTING_FORT_MAZE_12          ; $69
	const MAP_GFX_FIGHTING_FORT_MAZE_13          ; $6a
	const MAP_GFX_FIGHTING_FORT_MAZE_14          ; $6b
	const MAP_GFX_FIGHTING_FORT_MAZE_15          ; $6c
	const MAP_GFX_FIGHTING_FORT_MAZE_16          ; $6d
	const MAP_GFX_FIGHTING_FORT_MAZE_17          ; $6e
	const MAP_GFX_FIGHTING_FORT_MAZE_18          ; $6f
	const MAP_GFX_FIGHTING_FORT_MAZE_19          ; $70
	const MAP_GFX_FIGHTING_FORT_MAZE_20          ; $71
	const MAP_GFX_FIGHTING_FORT_MAZE_21          ; $72
	const MAP_GFX_FIGHTING_FORT_MAZE_22          ; $73
	const MAP_GFX_FIGHTING_FORT_BASEMENT         ; $74
	const MAP_GFX_GR_CHALLENGE_HALL_2            ; $75 - after clearing the game. has challenge machine

DEF NUM_OW_ANIMATED_TILES EQU 25

; TCG Island OW map location constants
	const_def
	const OWMAP_MASON_LABORATORY   ; $0
	const OWMAP_ISHIHARAS_HOUSE    ; $1
	const OWMAP_LIGHTNING_CLUB     ; $2
	const OWMAP_PSYCHIC_CLUB       ; $3
	const OWMAP_ROCK_CLUB          ; $4
	const OWMAP_FIGHTING_CLUB      ; $5
	const OWMAP_GRASS_CLUB         ; $6
	const OWMAP_SCIENCE_CLUB       ; $7
	const OWMAP_WATER_CLUB         ; $8
	const OWMAP_FIRE_CLUB          ; $9
	const OWMAP_TCG_AIRPORT        ; $a
	const OWMAP_TCG_CHALLENGE_HALL ; $b
	const OWMAP_POKEMON_DOME       ; $c

; GR Island OW map location constants
	const_def
	const OWMAP_GR_AIRPORT            ; $0
	const OWMAP_ISHIHARAS_VILLA       ; $1
	const OWMAP_GAME_CENTER           ; $2
	const OWMAP_SEALED_FORT           ; $3
	const OWMAP_GR_CHALLENGE_HALL     ; $4
	const OWMAP_GR_GRASS_FORT         ; $5
	const OWMAP_GR_LIGHTNING_FORT     ; $6
	const OWMAP_GR_FIRE_FORT          ; $7
	const OWMAP_GR_WATER_FORT         ; $8
	const OWMAP_GR_FIGHTING_FORT      ; $9
	const OWMAP_GR_PSYCHIC_STRONGHOLD ; $a
	const OWMAP_COLORLESS_ALTAR       ; $b
	const OWMAP_GR_CASTLE             ; $c

; *_MapHeader struct constants
RSRESET
DEF MAPHEADERSTRUCT_GFX          RB ; 0
DEF MAPHEADERSTRUCT_SCRIPTS_BANK RB ; 1
DEF MAPHEADERSTRUCT_SCRIPTS_PTR  RW ; 2
DEF MAPHEADERSTRUCT_MUSIC        RB ; 4

DEF MAPHEADERSTRUCT_LENGTH EQU _RS ; 5

; _ow_coordinate_function struct constants
RSRESET
DEF OWCOORDFUNCSTRUCT_X0          RB ; 0
DEF OWCOORDFUNCSTRUCT_Y0          RB ; 1
DEF OWCOORDFUNCSTRUCT_ARGS        EQU _RS
DEF OWCOORDFUNCSTRUCT_ARG_A       RB ; 2
DEF OWCOORDFUNCSTRUCT_ARG_D       RB ; 3
DEF OWCOORDFUNCSTRUCT_ARG_E       RB ; 4
DEF OWCOORDFUNCSTRUCT_ARG_B       RB ; 5
DEF OWCOORDFUNCSTRUCT_SCRIPT_BANK RB ; 6
DEF OWCOORDFUNCSTRUCT_SCRIPT_PTR  RW ; 7

DEF OWCOORDFUNCSTRUCT_LENGTH EQU _RS ; 9
