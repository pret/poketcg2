SECTION "Bank d@41c4", ROMX[$41c4], BANK[$d]

Func_341c4:
	xor a
	call Func_33f2
	; Event Script @ 0x341c8
	db $01, $10, $f1, $09, $dd, $41, $05, $6e, $12, $33
	db $98, $01, $1b, $98, $01, $05, $6f, $12, $08, $e0
	db $41, $05, $70, $12, $02, $2d, $f0, $41, $2f, $16
	db $03, $00
	ld a, [wNextMusic]
	farcall PlayAfterCurrentSong
	ret
