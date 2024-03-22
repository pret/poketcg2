MACRO credits_reset_unused
	db CREDITSCMD_RESET
ENDM

; \1 = number of frames to wait
MACRO credits_wait
	db CREDITSCMD_WAIT
	db \1
	db $00, $00, $00, $00
ENDM

; \1 = x
; \2 = y
; \3 = width
; \4 = height
MACRO credits_draw_box
	db CREDITSCMD_DRAW_BOX
	db $00
	db \1
	db \2
	db \3
	db \4
ENDM

; \1 = pal fade config
; \2 = pal fade mask
MACRO credits_fade_out
	db CREDITSCMD_FADE_OUT
	db \1
	db \2
	db $00, $00, $00
ENDM

; \1 = pal fade config
; \2 = pal fade mask
MACRO credits_fade_in
	db CREDITSCMD_FADE_IN
	db \1
	db \2
	db $00, $00, $00
ENDM

; \1 = music ID
MACRO credits_set_music
	db CREDITSCMD_SET_MUSIC
	db \1
	db $00, $00, $00, $00
ENDM

MACRO credits_stop_music
	db CREDITSCMD_STOP_MUSIC
	db $00, $00, $00, $00, $00
ENDM

MACRO credits_show_companies
	db CREDITSCMD_SHOW_COMPANIES
	db $00, $00, $00, $00, $00
ENDM

MACRO credits_show_title
	db CREDITSCMD_SHOW_TITLE
	db $00, $00, $00, $00, $00
ENDM

; \1 = x
; \2 = y
; \3 = card ID
MACRO credits_show_card
	db CREDITSCMD_SHOW_CARD
	db $00
	db \1
	db \2
	dw \3
ENDM

; \1 = set
; \2 = x
; \3 = y
MACRO credits_show_set
	db CREDITSCMD_SHOW_SET
	db \1
	db \2
	db \3
	db $00, $00
ENDM

; \1 = NPC_* constant
; \2 = x
; \3 = y
; \4 = portrait variant
MACRO credits_show_portrait
	db CREDITSCMD_SHOW_PORTRAIT
	db \1
	db \2
	db \3
	db $00
	db \4
ENDM

; \1 = length
; \2 = x
; \3 = y
; \4 = text ID
MACRO credits_print_header
	db CREDITSCMD_PRINT_HEADER
	db \1
	db \2
	db \3
	tx \4
ENDM

; \1 = x
; \2 = y
; \3 = text ID
MACRO credits_print_text
	db CREDITSCMD_PRINT_TEXT
	db $0
	db \1
	db \2
	tx \3
ENDM

; \1 = speed
; \2 = initial x
; \3 = x direction
; \4 = initial y
; \5 = y direction
MACRO credits_scroll_unused
	db CREDITSCMD_SCROLL
	db \1
	db \2
	db \3
	db \4
	db \5
ENDM

; \1 = keys for input
MACRO credits_wait_input
	db CREDITSCMD_WAIT_INPUT
	db \1
	db $00, $00, $00, $00
ENDM

MACRO credits_music_fade_out
	db CREDITSCMD_MUSIC_FADE_OUT
	db $00, $00, $00, $00, $00
ENDM

; \1 = volume
MACRO credits_set_volume
	db CREDITSCMD_SET_VOLUME
	db \1
	db $00, $00, $00, $00
ENDM

; \1 = map ID
MACRO credits_load_map
	db CREDITSCMD_LOAD_MAP
	db $00
	db HIGH(\1) ; for some reason this is
	db LOW(\1)  ; read in small endian
	db $00, $00
ENDM

MACRO credits_init_ow
	db CREDITSCMD_INIT_OW
	db $00, $00, $00, $00, $00
ENDM

MACRO credits_deinit_ow
	db CREDITSCMD_DEINIT_OW
	db $00, $00, $00, $00, $00
ENDM

; \1 = tilemap ID
; \2 = x
; \3 = y
MACRO credits_load_tilemap
	db CREDITSCMD_LOAD_TILEMAP
	db $00
	dw \1
	db \2
	db \3
ENDM

; \1 = OW obj ID
; \2 = direction
; \3 = x
; \4 = y
MACRO credits_load_ow_obj
	db CREDITSCMD_LOAD_OW_OBJ
	db \1
	db \2
	db $00
	db \3
	db \4
ENDM

; \1 = OW obj ID
; \2 = direction
; \3 = x
; \4 = y
MACRO credits_load_ow_obj_unused
	db CREDITSCMD_LOAD_OW_OBJ_IN_MAP
	db \1
	db \2
	db $00
	db \3
	db \4
ENDM

; \1 = x
; \2 = y
; \3 = tile index
; \4 = attributes
MACRO credits_show_tile
	db CREDITSCMD_SHOW_TILE
	db $00
	db \1
	db \2
	db \3
	db \4
ENDM

MACRO credits_end
	db CREDITS_END
ENDM
