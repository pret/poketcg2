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

MACRO gfx_ptr1
	db \1 ; BANK(\1)
	dw \2 ; \1
	db $0 ; padding
ENDM

MACRO gfx_ptr
	db BANK(\1) - BANK(@)
	dw \1
	db $0
ENDM
