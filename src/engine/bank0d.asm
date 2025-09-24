SECTION "Bank d@41c4", ROMX[$41c4], BANK[$d]

Func_341c4:
	xor a
	call Func_33f2
	; Event Script @ 0x341c8
	db $01
	db $10
	db $f1
	db $09
	db $dd
	db $41
	db $05
	db $6e
	db $12
	db $33
	db $98
	db $01
	db $1b
	db $98
	db $01
	db $05
	db $6f
	db $12
	db $08
	db $e0
	db $41
	db $05
	db $70
	db $12
	db $02
	db $2d
	db $f0
	db $41
	db $2f
	db $16
	db $03
	db $00
	ld a, [wNextMusic]
	farcall PlayAfterCurrentSong
	ret
