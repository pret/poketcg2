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
MACRO menu_parameters
	db \1, \2, \3, \4, \5, \6
	dw \7
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
Usually followed by a list of textitem macros, then $ff
*/
MACRO menu_box_params
	db \1, \2, \3, \4, \5, \6, \7, \8, \9, \<10>, \<11>
	dw \<12>
	tx \<13>
ENDM
