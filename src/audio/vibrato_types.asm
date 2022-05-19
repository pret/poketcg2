	dw .vibrato_type_0
	dw .vibrato_type_1
	dw .vibrato_type_2
	dw .vibrato_type_3
	dw .vibrato_type_4
	dw .vibrato_type_5
	dw .vibrato_type_6
	dw .vibrato_type_7
	dw .vibrato_type_8
	dw .vibrato_type_9
	dw .vibrato_type_A
	dw .vibrato_type_B
	dw .vibrato_type_C
	dw .vibrato_type_D
	dw .vibrato_type_E
	dw .vibrato_type_F
	dw .vibrato_type_10
	dw .vibrato_type_11
	dw .vibrato_type_12

.vibrato_type_0
	db $00,$80,$80

.vibrato_type_1
	db $01,$02,$01,$00,$ff,$fe,$ff,$00,$80,$80

.vibrato_type_2
	db $03,$fd,$03,$00,$00,$00,$00,$00,$00,$00,$00,$00,$80,$01

.vibrato_type_3
	db $01,$01,$00,$00,$ff,$ff,$00,$00,$80,$80

.vibrato_type_4
	db $01,$01,$01,$00,$00,$00,$ff,$ff,$ff,$00,$00,$00,$80,$80

.vibrato_type_5
	db $02,$04,$06,$04,$02,$00,$fe,$fc,$fa,$fc,$fe,$00,$80,$80

.vibrato_type_6
	db $04,$04,$08,$08,$04,$04,$00,$00,$fc,$fc,$f8,$f8,$fc,$fc,$00,$00,$80,$80

.vibrato_type_7
	db $f8,$f8,$f9,$f9,$fa,$fa,$fb,$fb,$fc,$fc,$fd,$fd,$fe,$fe,$ff,$ff,$00,$00,$80,$05

.vibrato_type_8
	db $02,$04,$02,$00,$fe,$fc,$fe,$00,$80,$80

.vibrato_type_9
	db $01,$02,$04,$02,$01,$00,$ff,$fe,$fc,$fe,$ff,$00,$80,$08

.vibrato_type_A
	db $01,$01,$01,$01,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$80,$80

.vibrato_type_B
	db $01,$02,$08,$04,$02,$01,$00,$fe,$fc,$f8,$fc,$fe,$ff,$fe,$80,$80

.vibrato_type_C
	db $7f,$40,$00,$7f,$c0,$80,$00

.vibrato_type_D
	db $7f,$40,$d8,$7f,$80,$c4,$ba,$b0,$a6,$9c,$92,$80,$00

.vibrato_type_E
	db $7f,$40,$0c,$7f,$80,$06,$7f,$00,$00,$80,$00

.vibrato_type_F
	db $7f,$00,$00,$7f,$80,$80,$00

.vibrato_type_10
	db $03,$05,$07,$05,$03,$00,$fd,$fb,$f9,$fb,$fd,$00,$80,$80

.vibrato_type_11
	db $7f,$00,$00,$7f,$40,$80,$05

.vibrato_type_12
	db $7f,$c0,$00,$7f,$80,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$80,$08
