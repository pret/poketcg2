MACRO? lb ; r, hi, lo
	ld \1, (\2) << 8 + ((\3) & $ff)
ENDM

MACRO? ldtx
	IF _NARG == 2
		ld \1, \2_
	ELSE
		ld \1, \2_ \3
	ENDC
ENDM

MACRO? bank1call
	rst $18
	dw \1
ENDM

MACRO? farcall
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
MACRO? get_turn_duelist_var
	rst $30
ENDM

; the rst $38 handler is a single ret instruction
; probably used for testing purposes during development
MACRO? debug_nop
	rst $38
ENDM

; Returns to the pointer in bc instead of where the stack was.
MACRO? retbc
	push bc
	ret
ENDM

MACRO? cp16
	ld a, d
	cp HIGH(\1)
	jr nz, :+
	ld a, e
	cp LOW(\1)
:
ENDM

MACRO? cp16_long
	ld a, d
	cp HIGH(\1)
	jr c, :+
	jr nz, :+
	ld a, e
	cp LOW(\1)
:
ENDM

MACRO? cp16bc_long
	ld a, b
	cp HIGH(\1)
	jr c, :+
	jr nz, :+
	ld a, c
	cp LOW(\1)
:
ENDM

MACRO? cp16_bytes
	ld a, d
	cp \1
	jr c, :+
	jr nz, :+
	ld a, e
	cp \2
:
ENDM

MACRO? cp16bc_bytes
	ld a, b
	cp \1
	jr c, :+
	jr nz, :+
	ld a, c
	cp \2
:
ENDM

MACRO? cpcoord
	cp16_bytes \1, \2
ENDM

MACRO? cphl
	inc hl
	ld a, [hld]
	cp HIGH(\1)
	jr nz, :+
	ld a, [hl]
	cp LOW(\1)
:
ENDM

MACRO? add_hl_a
	add l
	ld l, a
	jr nc, :+
	inc h
:
ENDM

MACRO? add_de_a
	add e
	ld e, a
	jr nc, :+
	inc d
:
ENDM

MACRO? add_at_hl_a
	add [hl]
	ld [hli], a
	jr nc, :+
	inc [hl]
:
ENDM
