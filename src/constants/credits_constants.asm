	const_def
	const CREDITSCMD_RESET               ; $00
	const CREDITSCMD_WAIT                ; $01
	const CREDITSCMD_DRAW_BOX            ; $02
	const CREDITSCMD_FADE_OUT            ; $03
	const CREDITSCMD_FADE_IN             ; $04
	const CREDITSCMD_SET_MUSIC           ; $05
	const CREDITSCMD_STOP_MUSIC          ; $06
	const CREDITSCMD_SHOW_COMPANIES      ; $07
	const CREDITSCMD_SHOW_TITLE          ; $08
	const CREDITSCMD_SHOW_CARD           ; $09
	const CREDITSCMD_SHOW_SET            ; $0a
	const CREDITSCMD_SHOW_PORTRAIT       ; $0b
	const CREDITSCMD_PRINT_HEADER        ; $0c
	const CREDITSCMD_PRINT_TEXT          ; $0d
	const CREDITSCMD_SCROLL              ; $0e
	const CREDITSCMD_WAIT_INPUT          ; $0f
	const CREDITSCMD_MUSIC_FADE_OUT      ; $10
	const CREDITSCMD_SET_VOLUME          ; $11
	const CREDITSCMD_LOAD_MAP            ; $12
	const CREDITSCMD_INIT_OW             ; $13
	const CREDITSCMD_DEINIT_OW           ; $14
	const CREDITSCMD_LOAD_TILEMAP        ; $15
	const CREDITSCMD_LOAD_OW_OBJ         ; $16
	const CREDITSCMD_LOAD_OW_OBJ_IN_MAP  ; $17
	const CREDITSCMD_SHOW_TILE           ; $18

	const_def $ff
	const CREDITS_END                    ; $ff

; constants for Func_138c6
; used to select what is affected by
; fade in/out credits commands
	const_def
	const CREDITS_FADE_ALL             ; $0
	const CREDITS_FADE_BACKGROUND      ; $1
	const CREDITS_FADE_HEADER          ; $2 (unused)
	const CREDITS_FADE_TEXT            ; $3
	const CREDITS_FADE_HEADER_TEXT     ; $4
	const CREDITS_FADE_BACKGROUND_TEXT ; $5

; constants to use with credits_show_set
	const_def
	const CREDITS_BASE_SET    ; $0
	const CREDITS_JUNGLE      ; $1
	const CREDITS_FOSSIL      ; $2
	const CREDITS_TEAM_ROCKET ; $3
