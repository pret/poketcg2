; wNextGameEvent constants, used as ExecuteGameEvent index
; somewhat different from tcg1
	const_def
	const GAME_EVENT_NONE             ; 0
	const GAME_EVENT_IDLE             ; 1
	const GAME_EVENT_OVERWORLD_UPDATE ; 2
	const GAME_EVENT_DUEL             ; 3
	const GAME_EVENT_NEWGAME_PROLOGUE ; 4
	const GAME_EVENT_CREDITS          ; 5

DEF NUM_GAME_EVENTS EQU const_value ; 6

	const_def
	const OWMODE_00             ; $00
	const OWMODE_MUSIC_PRELOAD  ; $01
	const OWMODE_02             ; $02
	const OWMODE_03             ; $03
	const OWMODE_04             ; $04
	const OWMODE_05             ; $05
	const OWMODE_06             ; $06
	const OWMODE_07             ; $07
	const OWMODE_INTERACT       ; $08
	const OWMODE_AFTER_DUEL     ; $09
	const OWMODE_0A             ; $0a
	const OWMODE_0B             ; $0b
	const OWMODE_0C             ; $0c
	const OWMODE_0D             ; $0d
	const OWMODE_0E             ; $0e
	const OWMODE_0F             ; $0f
	const OWMODE_MUSIC_POSTLOAD ; $10
	const OWMODE_11             ; $11
	const OWMODE_PAUSE_MENU     ; $12

; DEF NUM_OWMODES EQU const_value ; $13
