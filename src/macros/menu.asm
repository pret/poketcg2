/*
	\1 ; cursor x coordinate            - int
	\2 ; cursor y coordinate            - int
	\3 ; y displacement between items   - int
	\4 ; number of items                - int
	\5 ; cursor tile number             - SYM_*, usually SYM_CURSOR_R
	\6 ; tile behind cursor             - SYM_*, usually SYM_SPACE
	\7 ; function pointer if non-0      - function ptr or NULL

8 bytes. Used by InitializeMenuParameters.
*/
MACRO? menu_parameters
	db \1, \2, \3, \4, \5, \6
	dw \7
ENDM

; common patterns

MACRO? menuparams_x_y_dy_num_fn
	menu_parameters \1, \2, \3, \4, SYM_CURSOR_R, SYM_SPACE, \5
ENDM

MACRO? menuparams_x_y_dy_num
	menu_parameters \1, \2, \3, \4, SYM_CURSOR_R, SYM_SPACE, NULL
ENDM

MACRO? menuparams_textbox_x_y
	menu_parameters \1, \2, 1, 1, SYM_CURSOR_D, SYM_BOX_BOTTOM, NULL
ENDM

/*
	\1 ; cursor x coordinate            - int
	\2 ; cursor y coordinate            - int
	\3 ; y displacement between items   - int
	\4 ; x displacement between items   - int
	\5 ; number of items                - int
	\6 ; cursor tile number             - SYM_*, usually SYM_CURSOR_R
	\7 ; tile behind cursor             - SYM_*, usually SYM_SPACE
	\8 ; function pointer if non-0      - function ptr or NULL

9 bytes. Used by InitializeScrollMenuParameters.
*/
MACRO? scroll_menu_parameters
	db \1, \2, \3, \4, \5, \6, \7
	dw \8
ENDM

; common patterns

MACRO? scrollmenuparams_x_y_dy_dx_num
	scroll_menu_parameters \1, \2, \3, \4, \5, SYM_CURSOR_R, SYM_SPACE, NULL
ENDM

MACRO? scrollmenuparamsdown_x_y_dy_dx_num
	scroll_menu_parameters \1, \2, \3, \4, \5, SYM_CURSOR_D, SYM_SPACE, NULL
ENDM

/*
	\1  ; skip clear                - TRUE or FALSE
	\2  ; width                     - int
	\3  ; height                    - int
	\4  ; blink cursor symbol       - SYM_*, usually SYM_CURSOR_R
	\5  ; space symbol              - SYM_*, usually SYM_SPACE
	\6  ; default cursor symbol     - SYM_*, usually SYM_CURSOR_R
	\7  ; selection cursor symbol   - SYM_*, usually SYM_CURSOR_R
	\8  ; press keys                - PAD_*, usually PAD_A
	\9  ; held keys                 - PAD_*, usually PAD_B
	\10 ; has horizontal scroll     - TRUE or FALSE
	\11 ; vertical step             - int
	\12 ; update function           - function ptr or NULL
	\13 ; label text ID             - text ptr or NULL

15 bytes. Used by LoadMenuBoxParams.
Usually followed by menuboxtexts_begin, menuboxtext, menuboxtexts_end
*/
MACRO? menu_box_parameters
	db \1, \2, \3, \4, \5, \6, \7, \8, \9, \<10>, \<11>
	dw \<12>
	tx \<13>
ENDM

; common patterns

MACRO? menuboxparams_w_h_vstep
	menu_box_parameters TRUE, \1, \2, \
	SYM_CURSOR_R, SYM_SPACE, SYM_CURSOR_R, SYM_CURSOR_R, \
	PAD_A, PAD_B, TRUE, \3, NULL, NULL
ENDM

MACRO? menuboxparams_nohscroll_w_h_vstep
	menu_box_parameters TRUE, \1, \2, \
	SYM_CURSOR_R, SYM_SPACE, SYM_CURSOR_R, SYM_CURSOR_R, \
	PAD_A, PAD_B, FALSE, \3, NULL, NULL
ENDM

MACRO? menuboxparams_nohscroll_w_h_vstep_tx
	menu_box_parameters TRUE, \1, \2, \
	SYM_CURSOR_R, SYM_SPACE, SYM_CURSOR_R, SYM_CURSOR_R, \
	PAD_A, PAD_B, FALSE, \3, NULL, \4
ENDM

MACRO? menuboxparams_noskipclear_w_h_vstep_fn
	menu_box_parameters FALSE, \1, \2, \
	SYM_CURSOR_R, SYM_SPACE, SYM_CURSOR_R, SYM_CURSOR_R, \
	PAD_A, PAD_B, TRUE, \3, \4, NULL
ENDM

MACRO? menuboxparams_noskipclear_nohscroll_w_h_vstep_fn
	menu_box_parameters FALSE, \1, \2, \
	SYM_CURSOR_R, SYM_SPACE, SYM_CURSOR_R, SYM_CURSOR_R, \
	PAD_A, PAD_B, FALSE, \3, \4, NULL
ENDM

MACRO? menuboxparams_noskipclear_noheldkey_w_h_vstep
	menu_box_parameters FALSE, \1, \2, \
	SYM_CURSOR_R, SYM_SPACE, SYM_CURSOR_R, SYM_CURSOR_R, \
	PAD_A, 0, TRUE, \3, NULL, NULL
ENDM

MACRO? menuboxparams_config_w_h_vstep
	menu_box_parameters TRUE, \1, \2, \
	SYM_CURSOR_R, SYM_SPACE, SYM_CURSOR_R, SYM_CURSOR_R, \
	PAD_A, 0, FALSE, \3, StartMenuBoxUpdate, NULL
ENDM

; texts

MACRO? menuboxtexts_begin
ENDM

MACRO? menuboxtext
	textitem \1, \2, \3
ENDM

MACRO? menuboxtexts_end
	db $ff
ENDM

; loaders

MACRO? ldmenubox
	ld b, BANK(\1)
	ld hl, \1
	lb de, \2, \3
	call LoadMenuBoxParams
ENDM

MACRO? ldmenubox_reverse
	lb de, \2, \3
	ld b, BANK(\1)
	ld hl, \1
	call LoadMenuBoxParams
ENDM

; MACRO? setconfigmenubox
; 	ld b, BANK(\1)
; 	ld hl, \1
; 	lb de, \2, \3
; 	ld a, [\4]
; 	call LoadMenuBoxParams
; 	ld a, 8
; 	call SetMenuBoxDelay
; 	ld a, [\4]
; 	call HandleMenuBox
; 	ld [\4], a
; ENDM

/*
	\1 ; cursor x coordinate                               - int
	\2 ; cursor y coordinate                               - int
	\3 ; item x position                                   - int, usually 4
	\4 ; item name max length in tiles (name+level string) - int, usually 14
	\5 ; number of items (without scrolling)               - int
	\6 ; cursor tile number                                - SYM_*, usually SYM_CURSOR_R
	\7 ; tile behind cursor                                - SYM_*, usually SYM_SPACE
	\8 ; function pointer if non-0                         - function ptr or NULL

9 bytes. Used by InitializeCardListParameters
*/
MACRO? card_list_parameters
	db \1, \2, \3, \4, \5, \6, \7
	dw \8
ENDM

; common patterns
; TODO: constants for x pos = 4 and max length = 14 tiles
MACRO? cardlistparams_x_y_num_fn
	card_list_parameters \1, \2, 4, 14, \3, SYM_CURSOR_R, SYM_SPACE, \4
ENDM

; keyboard switching options for UpdateNamingScreenUI
MACRO? keyboardswitchers
	textitems_begin
		textitem  2, 16, \1
		textitem  7, 16, \2
		textitem 12, 16, \3
	textitems_end
ENDM
