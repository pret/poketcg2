MACRO lb ; r, hi, lo
	ld \1, (\2) << 8 + ((\3) & $ff)
ENDM

MACRO ldtx
	IF _NARG == 2
		ld \1, \2_
	ELSE
		ld \1, \2_ \3
	ENDC
ENDM

MACRO bank1call
	rst $18
	dw \1
ENDM

MACRO farcall
	rst $28
	IF _NARG == 1
		db BANK(\1)
		dw \1
	ELSE
		db \1
		dw \2
	ENDC
ENDM

; calls GetTurnDuelistVariable
DEF get_turn_duelist_var EQUS "rst $30"

; the rst $38 handler is a single ret instruction
; probably used for testing purposes during development
DEF debug_nop EQUS "rst $38"

; Returns to the pointer in bc instead of where the stack was.
MACRO retbc
	push bc
	ret
ENDM

MACRO cp16
	ld a, d
	cp HIGH(\1)
	jr nz, :+
	ld a, e
	cp LOW(\1)
:
ENDM
