; Animation duel screen constants (see wDuelAnimationScreen)
	const_def
	const DUEL_ANIM_SCREEN_MAIN_SCENE       ; 0
	const DUEL_ANIM_SCREEN_PLAYER_PLAY_AREA ; 1
	const DUEL_ANIM_SCREEN_OPP_PLAY_AREA    ; 2

	const_def
	; Normal animations
	const DUEL_ANIM_NONE                  ; $00
	const DUEL_ANIM_GLOW                  ; $01
	const DUEL_ANIM_PARALYSIS             ; $02
	const DUEL_ANIM_SLEEP                 ; $03
	const DUEL_ANIM_CONFUSION             ; $04
	const DUEL_ANIM_POISON                ; $05
	const DUEL_ANIM_SINGLE_HIT            ; $06
	const DUEL_ANIM_HIT                   ; $07
	const DUEL_ANIM_BIG_HIT               ; $08
	const DUEL_ANIM_SHOW_DAMAGE           ; $09
	const DUEL_ANIM_THUNDER_SHOCK         ; $0a
	const DUEL_ANIM_LIGHTNING             ; $0b
	const DUEL_ANIM_BORDER_SPARK          ; $0c
	const DUEL_ANIM_BIG_LIGHTNING         ; $0d
	const DUEL_ANIM_SMALL_FLAME           ; $0e
	const DUEL_ANIM_BIG_FLAME             ; $0f
	const DUEL_ANIM_FIRE_SPIN             ; $10
	const DUEL_ANIM_DIVE_BOMB             ; $11
	const DUEL_ANIM_WATER_JETS            ; $12
	const DUEL_ANIM_WATER_GUN             ; $13
	const DUEL_ANIM_WHIRLPOOL             ; $14
	const DUEL_ANIM_HYDRO_PUMP            ; $15
	const DUEL_ANIM_BLIZZARD              ; $16
	const DUEL_ANIM_PSYCHIC               ; $17
	const DUEL_ANIM_LEER                  ; $18
	const DUEL_ANIM_BEAM                  ; $19
	const DUEL_ANIM_HYPER_BEAM            ; $1a
	const DUEL_ANIM_AVALANCHE             ; $1b
	const DUEL_ANIM_STONE_BARRAGE         ; $1c
	const DUEL_ANIM_PUNCH                 ; $1d
	const DUEL_ANIM_THUNDER_PUNCH         ; $1e
	const DUEL_ANIM_FIRE_PUNCH            ; $1f
	const DUEL_ANIM_STRETCH_KICK          ; $20
	const DUEL_ANIM_SLASH                 ; $21
	const DUEL_ANIM_WHIP                  ; $22
	const DUEL_ANIM_SONIC_BOOM            ; $23
	const DUEL_ANIM_FURY_SWIPES           ; $24
	const DUEL_ANIM_DRILL                 ; $25
	const DUEL_ANIM_POT_SMASH             ; $26
	const DUEL_ANIM_BONEMERANG            ; $27
	const DUEL_ANIM_SEISMIC_TOSS          ; $28
	const DUEL_ANIM_NEEDLES               ; $29
	const DUEL_ANIM_WHITE_GAS             ; $2a
	const DUEL_ANIM_POWDER                ; $2b
	const DUEL_ANIM_GOO                   ; $2c
	const DUEL_ANIM_BUBBLES               ; $2d
	const DUEL_ANIM_STRING_SHOT           ; $2e
	const DUEL_ANIM_BOYFRIENDS            ; $2f
	const DUEL_ANIM_LURE                  ; $30
	const DUEL_ANIM_TOXIC                 ; $31
	const DUEL_ANIM_CONFUSE_RAY           ; $32
	const DUEL_ANIM_SING                  ; $33
	const DUEL_ANIM_SUPERSONIC            ; $34
	const DUEL_ANIM_PETAL_DANCE           ; $35
	const DUEL_ANIM_PROTECT               ; $36
	const DUEL_ANIM_BARRIER               ; $37
	const DUEL_ANIM_SPEED                 ; $38
	const DUEL_ANIM_WHIRLWIND             ; $39
	const DUEL_ANIM_CRY                   ; $3a
	const DUEL_ANIM_QUESTION_MARK         ; $3b
	const DUEL_ANIM_SELFDESTRUCT          ; $3c
	const DUEL_ANIM_BIG_SELFDESTRUCT_1    ; $3d
	const DUEL_ANIM_HEAL                  ; $3e
	const DUEL_ANIM_DRAIN                 ; $3f
	const DUEL_ANIM_DARK_GAS              ; $40
	const DUEL_ANIM_BIG_SELFDESTRUCT_2    ; $41
	const DUEL_ANIM_UNUSED_HIT            ; $42
	const DUEL_ANIM_UNUSED_BIG_HIT        ; $43
	const DUEL_ANIM_THUNDER_BENCH         ; $44
	const DUEL_ANIM_QUICKFREEZE           ; $45
	const DUEL_ANIM_GLOW_BENCH            ; $46
	const DUEL_ANIM_FIREGIVER_START       ; $47
	const DUEL_ANIM_UNUSED_FIREGIVER_INIT ; $48
	const DUEL_ANIM_HEALING_WIND          ; $49
	const DUEL_ANIM_WHIRLWIND_BENCH       ; $4a
	const DUEL_ANIM_EXPAND                ; $4b
	const DUEL_ANIM_CAT_PUNCH             ; $4c
	const DUEL_ANIM_THUNDER_WAVE          ; $4d
	const DUEL_ANIM_FIREGIVER_PLAYER      ; $4e
	const DUEL_ANIM_FIREGIVER_OPP         ; $4f
	const DUEL_ANIM_UNUSED_DECK_SWAP      ; $50
	const DUEL_ANIM_PLAYER_SHUFFLE        ; $51
	const DUEL_ANIM_OPP_SHUFFLE           ; $52
	const DUEL_ANIM_BOTH_SHUFFLE          ; $53
	const DUEL_ANIM_UNUSED_DECK_SHIFT     ; $54
	const DUEL_ANIM_BOTH_DRAW             ; $55
	const DUEL_ANIM_PLAYER_DRAW           ; $56
	const DUEL_ANIM_OPP_DRAW              ; $57
	const DUEL_ANIM_COIN_SPIN             ; $58
	const DUEL_ANIM_COIN_TOSS_GOING_HEADS ; $59
	const DUEL_ANIM_COIN_TOSS_GOING_TAILS ; $5a
	const DUEL_ANIM_COIN_HEADS            ; $5b
	const DUEL_ANIM_COIN_TAILS            ; $5c
	const DUEL_ANIM_DUEL_WIN              ; $5d
	const DUEL_ANIM_DUEL_LOSS             ; $5e
	const DUEL_ANIM_DUEL_DRAW             ; $5f
	const DUEL_ANIM_UNUSED_DECK_PAUSE     ; $60
	const DUEL_ANIM_UNUSED_61             ; $61
	const DUEL_ANIM_UNUSED_62             ; $62
	const DUEL_ANIM_UNUSED_63             ; $63
	const DUEL_ANIM_FIREBALL              ; $64
	const DUEL_ANIM_CONTINUOUS_FIREBALL   ; $65
	const DUEL_ANIM_BENCH_MANIPULATION    ; $66
	const DUEL_ANIM_PSYCHIC_BEAM          ; $67
	const DUEL_ANIM_PSYCHIC_BEAM_BENCH    ; $68
	const DUEL_ANIM_BOULDER_SMASH         ; $69
	const DUEL_ANIM_MEGA_PUNCH            ; $6a
	const DUEL_ANIM_PSYPUNCH              ; $6b
	const DUEL_ANIM_SLUDGE_PUNCH          ; $6c
	const DUEL_ANIM_ICE_PUNCH             ; $6d
	const DUEL_ANIM_KICK                  ; $6e
	const DUEL_ANIM_TAIL_SLAP             ; $6f
	const DUEL_ANIM_TAIL_WHIP             ; $70
	const DUEL_ANIM_SLAP                  ; $71
	const DUEL_ANIM_QUESTION_MARK_BENCH   ; $72
	const DUEL_ANIM_SKULL_BASH            ; $73
	const DUEL_ANIM_COIN_HURL             ; $74
	const DUEL_ANIM_TELEPORT              ; $75
	const DUEL_ANIM_FOLLOW_ME             ; $76
	const DUEL_ANIM_SWIFT                 ; $77
	const DUEL_ANIM_3D_ATTACK             ; $78
	const DUEL_ANIM_DRY_UP                ; $79
	const DUEL_ANIM_FOCUS_BLAST           ; $7a
	const DUEL_ANIM_FOCUS_BLAST_BENCH     ; $7b
	const DUEL_ANIM_BONE_TOSS_BENCH       ; $7c
	const DUEL_ANIM_COIN_HURL_BENCH       ; $7d
	const DUEL_ANIM_BIG_SNORE             ; $7e
	const DUEL_ANIM_RAZOR_LEAF            ; $7f
	const DUEL_ANIM_GUILLOTINE            ; $80
	const DUEL_ANIM_VINE_PULL             ; $81
	const DUEL_ANIM_PERPLEX               ; $82
	const DUEL_ANIM_NINE_TAILS            ; $83
	const DUEL_ANIM_BONE_HEADBUTT         ; $84
	const DUEL_ANIM_DRILL_DIVE            ; $85
	const DUEL_ANIM_DARK_SONG             ; $86

	; screen animations
DEF DUEL_SCREEN_ANIMS EQU const_value
	const DUEL_ANIM_SMALL_SHAKE_X         ; $87
	const DUEL_ANIM_BIG_SHAKE_X           ; $88
	const DUEL_ANIM_SMALL_SHAKE_Y         ; $89
	const DUEL_ANIM_BIG_SHAKE_Y           ; $8a
	const DUEL_ANIM_FLASH                 ; $8b
	const DUEL_ANIM_DISTORT               ; $8c

	; this animation is only played within DUEL_ANIM_SHOW_DAMAGE
	const DUEL_ANIM_DAMAGE_HUD            ; $8d

	const_def $96
	; animations passed this point are treated differently
DEF DUEL_SPECIAL_ANIMS EQU const_value
	const DUEL_ANIM_SET_SCREEN            ; $96
	const DUEL_PRINT_DAMAGE               ; $97
	const DUEL_ANIM_UPDATE_HUD            ; $98
	const DUEL_ANIM_153_UNUSED            ; $99
	const DUEL_ANIM_154_UNUSED            ; $9a
	const DUEL_ANIM_155_UNUSED            ; $9b
	const DUEL_ANIM_156_UNUSED            ; $9c
	const DUEL_ANIM_157_UNUSED            ; $9d
	const DUEL_ANIM_158_UNUSED            ; $9e

	; Duel Anim Struct constants
RSRESET
DEF DUEL_ANIM_STRUCT_ID             RB ; $0
DEF DUEL_ANIM_STRUCT_SCREEN         RB ; $1
DEF DUEL_ANIM_STRUCT_DUELIST_SIDE   RB ; $2
DEF DUEL_ANIM_STRUCT_LOCATION_PARAM RB ; $3
DEF DUEL_ANIM_STRUCT_DAMAGE         RW ; $4
DEF DUEL_ANIM_STRUCT_UNKNOWN_2      RB ; $6
DEF DUEL_ANIM_STRUCT_BANK           RB ; $7
DEF DUEL_ANIM_STRUCT_SIZE EQU _RS

	; ow_frame struct constants
RSRESET
DEF OW_FRAME_STRUCT_DURATION         RB ; $0
DEF OW_FRAME_STRUCT_VRAM_TILE_OFFSET RB ; $1
DEF OW_FRAME_STRUCT_VRAM_BANK        RB ; $2
DEF OW_FRAME_STRUCT_TILESET_BANK     RB ; $3
DEF OW_FRAME_STRUCT_TILESET          RW ; $4
DEF OW_FRAME_STRUCT_TILESET_OFFSET   RW ; $6
DEF OW_FRAME_STRUCT_SIZE EQU _RS

DEF NUM_OW_FRAMESET_SUBGROUPS EQU 3

DEF SET_ANIM_SCREEN_MAIN      EQU $1
DEF SET_ANIM_SCREEN_PLAY_AREA EQU $4
