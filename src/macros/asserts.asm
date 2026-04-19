; Macros to verify assumptions about the data or code

; MACRO? _redef_current_label
; 	IF DEF(\1)
; 		PURGE \1
; 	ENDC
; 	IF _NARG > 2
; 		DEF \1 EQUS "\3"
; 	ELIF STRLEN(#__SCOPE__)
; 		IF {{__SCOPE__}} - @ == 0
; 			DEF \1 EQUS #{__SCOPE__}
; 		ENDC
; 	ENDC
; 	IF !DEF(\1)
; 		DEF \1 EQUS \2
; 		{\1}:
; 	ENDC
; ENDM

; MACRO? table_width
; 	DEF CURRENT_TABLE_WIDTH = \1
; 	SHIFT
; 	_redef_current_label CURRENT_TABLE_START, "._table_width\@", \#
; ENDM

; MACRO? assert_table_length
; 	DEF w = \1
; 	DEF x = w * CURRENT_TABLE_WIDTH
; 	DEF y = @ - {CURRENT_TABLE_START}
; 	ASSERT x == y, \
; 		"{CURRENT_TABLE_START}: expected {d:w} entries, each {d:CURRENT_TABLE_WIDTH} " ++ \
; 		"bytes, for {d:x} total; but got {d:y} bytes"
; ENDM

MACRO? deck_list_start
	DEF x = 0
ENDM

; \1 = card ID
; \2 = quantity
MACRO? card_item
	DEF x += \2
	db \2
	dw \1
ENDM

MACRO? deck_list_end
	db 0 ; end of list
	ASSERT DECK_SIZE == x, \
		"deck list: expected {d:DECK_SIZE} cards, got {d:x}"
ENDM
