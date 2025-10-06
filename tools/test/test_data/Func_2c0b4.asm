Func_2c0b4:
	call Func_2c1b8
	jr nc, .asm_2c0be
	ld a, $09
	ld [wNextMusic], a
.asm_2c0be
	scf
	ccf
	ret
; 0x2c0c1