MACRO dn
	db ((\1) << 4) | (\2)
ENDM

MACRO dbw
	db \1
	dw \2
ENDM

MACRO dwb
	dw \1
	db \2
ENDM

MACRO dba
	dbw BANK(\1), \1
ENDM

MACRO dx
	DEF x = 8 * ((\1) - 1)
	REPT \1
		db ((\2) >> x) & $ff
		DEF x = x - 8
	ENDR
ENDM

MACRO dt ; three-byte (big-endian)
	dx 3, \1
ENDM

MACRO dd ; four-byte (big-endian)
	dx 4, \1
ENDM

MACRO bigdw ; big-endian word
	dx 2, \1
ENDM

MACRO sgb
	db \1 << 3 + \2 ; sgb_command * 8 + length
ENDM

MACRO rgb
	dw (\3 << 10 | \2 << 5 | \1)
ENDM

; poketcg specific macros below

MACRO textpointer
	dw ((\1 + ($4000 * (BANK(\1) - 1))) - (TextOffsets + ($4000 * (BANK(TextOffsets) - 1)))) & $ffff
	dw ((\1 + ($4000 * (BANK(\1) - 1))) - (TextOffsets + ($4000 * (BANK(TextOffsets) - 1)))) >> 16
	const \1_
	EXPORT \1_
ENDM

MACRO tx
	dw \1_
ENDM

MACRO gfx_ptr
	db BANK(\1) - BANK(@)
	dw \1
	db $0 ; padding
ENDM

; \1 = y offset
; \2 = x offset
; \3 = vtile
; \4 = attributes
MACRO dbsprite
	db \1, \2, \3, \4
ENDM

; \1 = frame
; \2 = duration
; \3 = x offset
; \4 = y offset
MACRO oamframe
	db \1, \2, \3, \4
ENDM

MACRO oamreset
	oamframe 0, 0, 0, 0
ENDM

; \1 = duration
MACRO oamwait
	oamframe $ff, \1, 0, 0
ENDM

; \1 = frame
MACRO oamend
	oamframe \1, -1, 0, 0
ENDM

; \1 = vtile
; \2 = VRAM
; \3 = OW_FRAMES_* constant
MACRO ow_anim
	db \1, (\2 ^ $1)
	dw \3
ENDM

; \1 = tile index in tileset
; \2 = frame duration
MACRO ow_frame
	dw \1
	db \2
	db $00 ; padding
ENDM

MACRO ow_frame_end
	dw $ffff
ENDM

MACRO textitem
	db \1, \2 ; x, y
	tx \3     ; text ID
ENDM

; cursor x / cursor y / attribute / idx-up / idx-down / idx-right / idx-left
; idx-[direction] means the index to get when the input is in the direction.
; its attribute is used for drawing a flipped cursor.
MACRO cursor_transition
	db \1, \2, \3
	REPT 4
		db \4
		SHIFT
	ENDR
ENDM

; key-value pairs
; for function maps
MACRO key_func
	db \1  ; key
	dba \2 ; text ID
ENDM
