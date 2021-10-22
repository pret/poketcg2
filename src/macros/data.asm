dn: MACRO
	db \1 << 4 | \2
ENDM

dbw: MACRO
	db \1
	dw \2
ENDM

dwb: MACRO
	dw \1
	db \2
ENDM

dx: MACRO
x = 8 * ((\1) - 1)
	rept \1
	db ((\2) >> x) & $ff
x = x - 8
	endr
	ENDM

dt: MACRO ; three-byte (big-endian)
	dx 3, \1
	ENDM

dd: MACRO ; four-byte (big-endian)
	dx 4, \1
	ENDM

bigdw: MACRO ; big-endian word
	dx 2, \1
	ENDM

sgb: MACRO
	db \1 << 3 + \2 ; sgb_command * 8 + length
ENDM

rgb: MACRO
	dw (\3 << 10 | \2 << 5 | \1)
ENDM
