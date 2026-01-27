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
	const OWMODE_IDLE                  ; $00
	const OWMODE_MUSIC_PRELOAD         ; $01
	const OWMODE_WARP_FADE_IN_PRELOAD  ; $02
	const OWMODE_WARP_INTERVAL         ; $03
	const OWMODE_WARP_FADE_OUT_PRELOAD ; $04
	const OWMODE_MOVE                  ; $05
	const OWMODE_STEP_EVENT            ; $06
	const OWMODE_NPC_POSITION          ; $07
	const OWMODE_INTERACT              ; $08
	const OWMODE_AFTER_DUEL            ; $09
	const OWMODE_SCRIPT                ; $0a
	const OWMODE_CONTINUE_OW           ; $0b
	const OWMODE_SAVE_PRELOAD          ; $0c
	const OWMODE_SAVE_POSTLOAD         ; $0d
	const OWMODE_CONTINUE_DUEL         ; $0e
	const OWMODE_WARP_END_SFX          ; $0f
	const OWMODE_MUSIC_POSTLOAD        ; $10
	const OWMODE_AFTER_DUEL_PRELOAD    ; $11
	const OWMODE_PAUSE_MENU            ; $12
