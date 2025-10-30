OAMData73::
	dw .frame_0
	dw .frame_1
	dw .frame_2
	dw .frame_3
	dw .frame_4
	dw .frame_5
	dw .frame_6
	dw .frame_7
	dw .frame_8
	dw .frame_9

.frame_0
	db 4 ; size
	dbsprite   0,   0, $08, 0
	dbsprite   0,   8, $09, 0
	dbsprite   8,   0, $0a, 0
	dbsprite   8,   8, $0b, 0

.frame_1
	db 4 ; size
	dbsprite   0,   0, $06, 0
	dbsprite   8,   0, $07, 0
	dbsprite   8,   8, $07, 0 | OAM_XFLIP
	dbsprite   0,   8, $06, 0 | OAM_XFLIP

.frame_2
	db 4 ; size
	dbsprite   0,   0, $09, 0 | OAM_XFLIP
	dbsprite   8,   0, $0b, 0 | OAM_XFLIP
	dbsprite   0,   8, $08, 0 | OAM_XFLIP
	dbsprite   8,   8, $0a, 0 | OAM_XFLIP

.frame_3
	db 4 ; size
	dbsprite   0,   0, $0c, 0
	dbsprite   0,   8, $0d, 0
	dbsprite   8,   0, $0e, 0
	dbsprite   8,   8, $0f, 0

.frame_4
	db 4 ; size
	dbsprite   0,   0, $10, 0
	dbsprite   0,   8, $11, 0
	dbsprite   8,   0, $12, 0
	dbsprite   8,   8, $13, 0

.frame_5
	db 4 ; size
	dbsprite   0,   0, $02, 0
	dbsprite   0,   8, $03, 0
	dbsprite   8,   0, $04, 0
	dbsprite   8,   8, $05, 0

.frame_6
	db 4 ; size
	dbsprite   0,   8, $14, 0
	dbsprite   0,   0, $00, 0
	dbsprite   8,   0, $01, 0
	dbsprite   8,   8, $01, 0 | OAM_XFLIP

.frame_7
	db 4 ; size
	dbsprite   0,   8, $03, 0
	dbsprite   0,   0, $02, 0
	dbsprite   8,   0, $05, 0 | OAM_XFLIP
	dbsprite   8,   8, $04, 0 | OAM_XFLIP

.frame_8
	db 4 ; size
	dbsprite   0,   8, $16, 0
	dbsprite   0,   0, $15, 0
	dbsprite   8,   0, $0f, 0 | OAM_XFLIP
	dbsprite   8,   8, $0e, 0 | OAM_XFLIP

.frame_9
	db 4 ; size
	dbsprite   0,   8, $18, 0
	dbsprite   0,   0, $17, 0
	dbsprite   8,   0, $13, 0 | OAM_XFLIP
	dbsprite   8,   8, $12, 0 | OAM_XFLIP

OAMData74::
	dw .frame_0
	dw .frame_1
	dw .frame_2
	dw .frame_3
	dw .frame_4
	dw .frame_5
	dw .frame_6
	dw .frame_7
	dw .frame_8
	dw .frame_9

.frame_0
	db 4 ; size
	dbsprite   0,   0, $08, 0
	dbsprite   0,   8, $09, 0
	dbsprite   8,   0, $0a, 0
	dbsprite   8,   8, $0b, 0

.frame_1
	db 4 ; size
	dbsprite   0,   0, $06, 0
	dbsprite   8,   0, $07, 0
	dbsprite   8,   8, $07, 0 | OAM_XFLIP
	dbsprite   0,   8, $06, 0 | OAM_XFLIP

.frame_2
	db 4 ; size
	dbsprite   0,   0, $09, 0 | OAM_XFLIP
	dbsprite   8,   0, $0b, 0 | OAM_XFLIP
	dbsprite   0,   8, $08, 0 | OAM_XFLIP
	dbsprite   8,   8, $0a, 0 | OAM_XFLIP

.frame_3
	db 4 ; size
	dbsprite   0,   0, $0c, 0
	dbsprite   0,   8, $0d, 0
	dbsprite   8,   0, $0e, 0
	dbsprite   8,   8, $0f, 0

.frame_4
	db 4 ; size
	dbsprite   0,   0, $10, 0
	dbsprite   0,   8, $11, 0
	dbsprite   8,   0, $12, 0
	dbsprite   8,   8, $13, 0

.frame_5
	db 4 ; size
	dbsprite   0,   0, $02, 0
	dbsprite   0,   8, $03, 0
	dbsprite   8,   0, $04, 0
	dbsprite   8,   8, $05, 0

.frame_6
	db 4 ; size
	dbsprite   0,   8, $14, 0
	dbsprite   0,   0, $00, 0
	dbsprite   8,   0, $01, 0
	dbsprite   8,   8, $01, 0 | OAM_XFLIP

.frame_7
	db 4 ; size
	dbsprite   0,   8, $03, 0
	dbsprite   8,   0, $05, 0 | OAM_XFLIP
	dbsprite   0,   0, $02, 0
	dbsprite   8,   8, $04, 0 | OAM_XFLIP

.frame_8
	db 4 ; size
	dbsprite   0,   8, $16, 0
	dbsprite   0,   0, $15, 0
	dbsprite   8,   0, $0f, 0 | OAM_XFLIP
	dbsprite   8,   8, $0e, 0 | OAM_XFLIP

.frame_9
	db 4 ; size
	dbsprite   0,   8, $18, 0
	dbsprite   0,   0, $17, 0
	dbsprite   8,   0, $13, 0 | OAM_XFLIP
	dbsprite   8,   8, $12, 0 | OAM_XFLIP

OAMData75::
	dw .frame_0
	dw .frame_1
	dw .frame_2
	dw .frame_3
	dw .frame_4
	dw .frame_5
	dw .frame_6
	dw .frame_7
	dw .frame_8
	dw .frame_9

.frame_0
	db 4 ; size
	dbsprite   0,   0, $08, 0
	dbsprite   0,   8, $09, 0
	dbsprite   8,   0, $0a, 0
	dbsprite   8,   8, $0b, 0

.frame_1
	db 4 ; size
	dbsprite   0,   0, $06, 0
	dbsprite   8,   0, $07, 0
	dbsprite   8,   8, $07, 0 | OAM_XFLIP
	dbsprite   0,   8, $06, 0 | OAM_XFLIP

.frame_2
	db 4 ; size
	dbsprite   0,   0, $09, 0 | OAM_XFLIP
	dbsprite   8,   0, $0b, 0 | OAM_XFLIP
	dbsprite   0,   8, $08, 0 | OAM_XFLIP
	dbsprite   8,   8, $0a, 0 | OAM_XFLIP

.frame_3
	db 4 ; size
	dbsprite   0,   0, $0c, 0
	dbsprite   0,   8, $0d, 0
	dbsprite   8,   0, $0e, 0
	dbsprite   8,   8, $0f, 0

.frame_4
	db 4 ; size
	dbsprite   0,   0, $10, 0
	dbsprite   0,   8, $11, 0
	dbsprite   8,   0, $12, 0
	dbsprite   8,   8, $13, 0

.frame_5
	db 4 ; size
	dbsprite   0,   0, $02, 0
	dbsprite   0,   8, $03, 0
	dbsprite   8,   0, $04, 0
	dbsprite   8,   8, $05, 0

.frame_6
	db 4 ; size
	dbsprite   0,   8, $14, 0
	dbsprite   0,   0, $00, 0
	dbsprite   8,   0, $01, 0
	dbsprite   8,   8, $01, 0 | OAM_XFLIP

.frame_7
	db 4 ; size
	dbsprite   0,   8, $03, 0
	dbsprite   8,   0, $05, 0 | OAM_XFLIP
	dbsprite   0,   0, $02, 0
	dbsprite   8,   8, $04, 0 | OAM_XFLIP

.frame_8
	db 4 ; size
	dbsprite   0,   0, $0d, 0 | OAM_XFLIP
	dbsprite   8,   0, $0f, 0 | OAM_XFLIP
	dbsprite   0,   8, $0c, 0 | OAM_XFLIP
	dbsprite   8,   8, $0e, 0 | OAM_XFLIP

.frame_9
	db 4 ; size
	dbsprite   0,   0, $11, 0 | OAM_XFLIP
	dbsprite   8,   0, $13, 0 | OAM_XFLIP
	dbsprite   0,   8, $10, 0 | OAM_XFLIP
	dbsprite   8,   8, $12, 0 | OAM_XFLIP

OAMData76::
	dw .frame_0
	dw .frame_1
	dw .frame_2
	dw .frame_3
	dw .frame_4
	dw .frame_5
	dw .frame_6
	dw .frame_7
	dw .frame_8
	dw .frame_9

.frame_0
	db 4 ; size
	dbsprite   0,   0, $08, 0
	dbsprite   0,   8, $09, 0
	dbsprite   8,   0, $0a, 0
	dbsprite   8,   8, $0b, 0

.frame_1
	db 4 ; size
	dbsprite   0,   0, $06, 0
	dbsprite   8,   0, $07, 0
	dbsprite   8,   8, $07, 0 | OAM_XFLIP
	dbsprite   0,   8, $06, 0 | OAM_XFLIP

.frame_2
	db 4 ; size
	dbsprite   0,   0, $09, 0 | OAM_XFLIP
	dbsprite   8,   0, $0b, 0 | OAM_XFLIP
	dbsprite   0,   8, $08, 0 | OAM_XFLIP
	dbsprite   8,   8, $0a, 0 | OAM_XFLIP

.frame_3
	db 4 ; size
	dbsprite   0,   0, $0c, 0
	dbsprite   0,   8, $0d, 0
	dbsprite   8,   0, $0e, 0
	dbsprite   8,   8, $0f, 0

.frame_4
	db 4 ; size
	dbsprite   0,   0, $10, 0
	dbsprite   0,   8, $11, 0
	dbsprite   8,   0, $12, 0
	dbsprite   8,   8, $13, 0

.frame_5
	db 4 ; size
	dbsprite   0,   0, $02, 0
	dbsprite   0,   8, $03, 0
	dbsprite   8,   0, $04, 0
	dbsprite   8,   8, $05, 0

.frame_6
	db 4 ; size
	dbsprite   0,   8, $14, 0
	dbsprite   0,   0, $00, 0
	dbsprite   8,   0, $01, 0
	dbsprite   8,   8, $01, 0 | OAM_XFLIP

.frame_7
	db 4 ; size
	dbsprite   0,   8, $16, 0
	dbsprite   0,   0, $15, 0
	dbsprite   8,   0, $05, 0 | OAM_XFLIP
	dbsprite   8,   8, $04, 0 | OAM_XFLIP

.frame_8
	db 4 ; size
	dbsprite   0,   8, $18, 0
	dbsprite   0,   0, $17, 0
	dbsprite   8,   0, $0f, 0 | OAM_XFLIP
	dbsprite   8,   8, $0e, 0 | OAM_XFLIP

.frame_9
	db 4 ; size
	dbsprite   0,   8, $1a, 0
	dbsprite   0,   0, $19, 0
	dbsprite   8,   0, $13, 0 | OAM_XFLIP
	dbsprite   8,   8, $12, 0 | OAM_XFLIP

OAMData77::
	dw .frame_0
	dw .frame_1
	dw .frame_2
	dw .frame_3
	dw .frame_4
	dw .frame_5
	dw .frame_6
	dw .frame_7
	dw .frame_8
	dw .frame_9

.frame_0
	db 4 ; size
	dbsprite   0,   0, $08, 4
	dbsprite   0,   8, $09, 4
	dbsprite   8,   0, $0a, 4
	dbsprite   8,   8, $0b, 4

.frame_1
	db 4 ; size
	dbsprite   0,   0, $06, 4
	dbsprite   8,   0, $07, 4
	dbsprite   8,   8, $07, 4 | OAM_XFLIP
	dbsprite   0,   8, $06, 4 | OAM_XFLIP

.frame_2
	db 4 ; size
	dbsprite   0,   0, $09, 4 | OAM_XFLIP
	dbsprite   8,   0, $0b, 4 | OAM_XFLIP
	dbsprite   0,   8, $08, 4 | OAM_XFLIP
	dbsprite   8,   8, $0a, 4 | OAM_XFLIP

.frame_3
	db 4 ; size
	dbsprite   0,   0, $0c, 4
	dbsprite   0,   8, $0d, 4
	dbsprite   8,   0, $0e, 4
	dbsprite   8,   8, $0f, 4

.frame_4
	db 4 ; size
	dbsprite   0,   0, $10, 4
	dbsprite   0,   8, $11, 4
	dbsprite   8,   0, $12, 4
	dbsprite   8,   8, $13, 4

.frame_5
	db 4 ; size
	dbsprite   0,   0, $02, 4
	dbsprite   0,   8, $03, 4
	dbsprite   8,   0, $04, 4
	dbsprite   8,   8, $05, 4

.frame_6
	db 4 ; size
	dbsprite   0,   8, $14, 4
	dbsprite   0,   0, $00, 4
	dbsprite   8,   0, $01, 4
	dbsprite   8,   8, $01, 4 | OAM_XFLIP

.frame_7
	db 4 ; size
	dbsprite   0,   8, $03, 4
	dbsprite   8,   0, $05, 4 | OAM_XFLIP
	dbsprite   0,   0, $02, 4
	dbsprite   8,   8, $04, 4 | OAM_XFLIP

.frame_8
	db 4 ; size
	dbsprite   0,   0, $0d, 4 | OAM_XFLIP
	dbsprite   8,   0, $0f, 4 | OAM_XFLIP
	dbsprite   0,   8, $0c, 4 | OAM_XFLIP
	dbsprite   8,   8, $0e, 4 | OAM_XFLIP

.frame_9
	db 4 ; size
	dbsprite   0,   0, $11, 4 | OAM_XFLIP
	dbsprite   8,   0, $13, 4 | OAM_XFLIP
	dbsprite   0,   8, $10, 4 | OAM_XFLIP
	dbsprite   8,   8, $12, 4 | OAM_XFLIP

OAMData78::
	dw .frame_0
	dw .frame_1
	dw .frame_2
	dw .frame_3
	dw .frame_4
	dw .frame_5
	dw .frame_6
	dw .frame_7
	dw .frame_8
	dw .frame_9

.frame_0
	db 4 ; size
	dbsprite   0,   0, $08, 2
	dbsprite   0,   8, $09, 2
	dbsprite   8,   0, $0a, 2
	dbsprite   8,   8, $0b, 2

.frame_1
	db 4 ; size
	dbsprite   0,   0, $06, 2
	dbsprite   8,   0, $07, 2
	dbsprite   8,   8, $07, 2 | OAM_XFLIP
	dbsprite   0,   8, $06, 2 | OAM_XFLIP

.frame_2
	db 4 ; size
	dbsprite   0,   0, $09, 2 | OAM_XFLIP
	dbsprite   8,   0, $0b, 2 | OAM_XFLIP
	dbsprite   0,   8, $08, 2 | OAM_XFLIP
	dbsprite   8,   8, $0a, 2 | OAM_XFLIP

.frame_3
	db 4 ; size
	dbsprite   0,   0, $0c, 2
	dbsprite   0,   8, $0d, 2
	dbsprite   8,   0, $0e, 2
	dbsprite   8,   8, $0f, 2

.frame_4
	db 4 ; size
	dbsprite   0,   0, $10, 2
	dbsprite   0,   8, $11, 2
	dbsprite   8,   0, $12, 2
	dbsprite   8,   8, $13, 2

.frame_5
	db 4 ; size
	dbsprite   0,   0, $02, 2
	dbsprite   0,   8, $03, 2
	dbsprite   8,   0, $04, 2
	dbsprite   8,   8, $05, 2

.frame_6
	db 4 ; size
	dbsprite   0,   8, $14, 2
	dbsprite   0,   0, $00, 2
	dbsprite   8,   0, $01, 2
	dbsprite   8,   8, $01, 2 | OAM_XFLIP

.frame_7
	db 4 ; size
	dbsprite   0,   8, $03, 2
	dbsprite   8,   0, $05, 2 | OAM_XFLIP
	dbsprite   0,   0, $02, 2
	dbsprite   8,   8, $04, 2 | OAM_XFLIP

.frame_8
	db 4 ; size
	dbsprite   0,   0, $0d, 2 | OAM_XFLIP
	dbsprite   8,   0, $0f, 2 | OAM_XFLIP
	dbsprite   0,   8, $0c, 2 | OAM_XFLIP
	dbsprite   8,   8, $0e, 2 | OAM_XFLIP

.frame_9
	db 4 ; size
	dbsprite   0,   0, $11, 2 | OAM_XFLIP
	dbsprite   8,   0, $13, 2 | OAM_XFLIP
	dbsprite   0,   8, $10, 2 | OAM_XFLIP
	dbsprite   8,   8, $12, 2 | OAM_XFLIP

OAMData79::
	dw .frame_0
	dw .frame_1
	dw .frame_2
	dw .frame_3
	dw .frame_4
	dw .frame_5
	dw .frame_6
	dw .frame_7
	dw .frame_8
	dw .frame_9

.frame_0
	db 4 ; size
	dbsprite   0,   0, $08, 5
	dbsprite   0,   8, $09, 5
	dbsprite   8,   0, $0a, 5
	dbsprite   8,   8, $0b, 5

.frame_1
	db 4 ; size
	dbsprite   8,   8, $17, 5
	dbsprite   0,   8, $16, 5
	dbsprite   0,   0, $06, 5
	dbsprite   8,   0, $07, 5

.frame_2
	db 4 ; size
	dbsprite   8,   8, $1b, 5
	dbsprite   8,   0, $1a, 5
	dbsprite   0,   8, $09, 5
	dbsprite   0,   0, $08, 5

.frame_3
	db 4 ; size
	dbsprite   0,   0, $0c, 5
	dbsprite   0,   8, $0d, 5
	dbsprite   8,   0, $0e, 5
	dbsprite   8,   8, $0f, 5

.frame_4
	db 4 ; size
	dbsprite   0,   0, $10, 5
	dbsprite   0,   8, $11, 5
	dbsprite   8,   0, $12, 5
	dbsprite   8,   8, $13, 5

.frame_5
	db 4 ; size
	dbsprite   0,   0, $02, 5
	dbsprite   0,   8, $03, 5
	dbsprite   8,   0, $04, 5
	dbsprite   8,   8, $05, 5

.frame_6
	db 4 ; size
	dbsprite   8,   8, $15, 5
	dbsprite   0,   8, $14, 5
	dbsprite   0,   0, $00, 5
	dbsprite   8,   0, $01, 5

.frame_7
	db 4 ; size
	dbsprite   8,   8, $19, 5
	dbsprite   8,   0, $18, 5
	dbsprite   0,   8, $03, 5
	dbsprite   0,   0, $02, 5

.frame_8
	db 4 ; size
	dbsprite   8,   8, $0e, 5 | OAM_XFLIP
	dbsprite   8,   0, $1e, 5
	dbsprite   0,   8, $1d, 5
	dbsprite   0,   0, $1c, 5

.frame_9
	db 4 ; size
	dbsprite   8,   0, $1f, 5
	dbsprite   8,   8, $12, 5 | OAM_XFLIP
	dbsprite   0,   8, $21, 5
	dbsprite   0,   0, $20, 5

OAMData7A::
	dw .frame_0
	dw .frame_1
	dw .frame_2
	dw .frame_3
	dw .frame_4
	dw .frame_5
	dw .frame_6
	dw .frame_7
	dw .frame_8
	dw .frame_9

.frame_0
	db 4 ; size
	dbsprite   0,   0, $08, 0
	dbsprite   0,   8, $09, 0
	dbsprite   8,   0, $0a, 0
	dbsprite   8,   8, $0b, 0

.frame_1
	db 4 ; size
	dbsprite   8,   8, $1b, 0
	dbsprite   0,   8, $1a, 0
	dbsprite   0,   0, $06, 0
	dbsprite   8,   0, $07, 0

.frame_2
	db 4 ; size
	dbsprite   8,   8, $1f, 0
	dbsprite   8,   0, $1e, 0
	dbsprite   0,   8, $1d, 0
	dbsprite   0,   0, $1c, 0

.frame_3
	db 4 ; size
	dbsprite   0,   0, $0c, 0
	dbsprite   0,   8, $0d, 0
	dbsprite   8,   0, $0e, 0
	dbsprite   8,   8, $0f, 0

.frame_4
	db 4 ; size
	dbsprite   0,   0, $10, 0
	dbsprite   0,   8, $11, 0
	dbsprite   8,   0, $12, 0
	dbsprite   8,   8, $13, 0

.frame_5
	db 4 ; size
	dbsprite   0,   0, $02, 0
	dbsprite   0,   8, $03, 0
	dbsprite   8,   0, $04, 0
	dbsprite   8,   8, $05, 0

.frame_6
	db 4 ; size
	dbsprite   8,   8, $15, 0
	dbsprite   0,   8, $14, 0
	dbsprite   0,   0, $00, 0
	dbsprite   8,   0, $01, 0

.frame_7
	db 4 ; size
	dbsprite   8,   8, $19, 0
	dbsprite   8,   0, $18, 0
	dbsprite   0,   8, $17, 0
	dbsprite   0,   0, $16, 0

.frame_8
	db 4 ; size
	dbsprite   8,   8, $23, 0
	dbsprite   8,   0, $22, 0
	dbsprite   0,   8, $21, 0
	dbsprite   0,   0, $20, 0

.frame_9
	db 4 ; size
	dbsprite   0,   8, $25, 0
	dbsprite   0,   0, $24, 0
	dbsprite   8,   0, $13, 0 | OAM_XFLIP
	dbsprite   8,   8, $12, 0 | OAM_XFLIP

OAMData7B::
	dw .frame_0
	dw .frame_1
	dw .frame_2
	dw .frame_3
	dw .frame_4
	dw .frame_5
	dw .frame_6
	dw .frame_7
	dw .frame_8
	dw .frame_9

.frame_0
	db 4 ; size
	dbsprite   0,   0, $08, 5
	dbsprite   0,   8, $09, 5
	dbsprite   8,   0, $0a, 5
	dbsprite   8,   8, $0b, 5

.frame_1
	db 4 ; size
	dbsprite   0,   0, $06, 5
	dbsprite   8,   0, $07, 5
	dbsprite   8,   8, $07, 5 | OAM_XFLIP
	dbsprite   0,   8, $06, 5 | OAM_XFLIP

.frame_2
	db 4 ; size
	dbsprite   0,   0, $09, 5 | OAM_XFLIP
	dbsprite   8,   0, $0b, 5 | OAM_XFLIP
	dbsprite   0,   8, $08, 5 | OAM_XFLIP
	dbsprite   8,   8, $0a, 5 | OAM_XFLIP

.frame_3
	db 4 ; size
	dbsprite   0,   0, $0c, 5
	dbsprite   0,   8, $0d, 5
	dbsprite   8,   0, $0e, 5
	dbsprite   8,   8, $0f, 5

.frame_4
	db 4 ; size
	dbsprite   0,   0, $10, 5
	dbsprite   0,   8, $11, 5
	dbsprite   8,   0, $12, 5
	dbsprite   8,   8, $13, 5

.frame_5
	db 4 ; size
	dbsprite   0,   0, $02, 5
	dbsprite   0,   8, $03, 5
	dbsprite   8,   0, $04, 5
	dbsprite   8,   8, $05, 5

.frame_6
	db 4 ; size
	dbsprite   0,   8, $14, 5
	dbsprite   0,   0, $00, 5
	dbsprite   8,   0, $01, 5
	dbsprite   8,   8, $01, 5 | OAM_XFLIP

.frame_7
	db 4 ; size
	dbsprite   0,   8, $03, 5
	dbsprite   8,   0, $05, 5 | OAM_XFLIP
	dbsprite   0,   0, $02, 5
	dbsprite   8,   8, $04, 5 | OAM_XFLIP

.frame_8
	db 4 ; size
	dbsprite   0,   0, $15, 5
	dbsprite   8,   0, $0f, 5 | OAM_XFLIP
	dbsprite   0,   8, $0c, 5 | OAM_XFLIP
	dbsprite   8,   8, $0e, 5 | OAM_XFLIP

.frame_9
	db 4 ; size
	dbsprite   0,   0, $16, 5
	dbsprite   8,   0, $13, 5 | OAM_XFLIP
	dbsprite   0,   8, $10, 5 | OAM_XFLIP
	dbsprite   8,   8, $12, 5 | OAM_XFLIP

OAMData7C::
	dw .frame_0
	dw .frame_1
	dw .frame_2
	dw .frame_3
	dw .frame_4
	dw .frame_5
	dw .frame_6
	dw .frame_7
	dw .frame_8
	dw .frame_9

.frame_0
	db 4 ; size
	dbsprite   0,   0, $08, 2
	dbsprite   0,   8, $09, 2
	dbsprite   8,   0, $0a, 2
	dbsprite   8,   8, $0b, 2

.frame_1
	db 4 ; size
	dbsprite   0,   0, $06, 2
	dbsprite   8,   0, $07, 2
	dbsprite   8,   8, $07, 2 | OAM_XFLIP
	dbsprite   0,   8, $06, 2 | OAM_XFLIP

.frame_2
	db 4 ; size
	dbsprite   0,   0, $09, 2 | OAM_XFLIP
	dbsprite   8,   0, $0b, 2 | OAM_XFLIP
	dbsprite   0,   8, $08, 2 | OAM_XFLIP
	dbsprite   8,   8, $0a, 2 | OAM_XFLIP

.frame_3
	db 4 ; size
	dbsprite   0,   0, $0c, 2
	dbsprite   0,   8, $0d, 2
	dbsprite   8,   0, $0e, 2
	dbsprite   8,   8, $0f, 2

.frame_4
	db 4 ; size
	dbsprite   0,   0, $10, 2
	dbsprite   0,   8, $11, 2
	dbsprite   8,   0, $12, 2
	dbsprite   8,   8, $13, 2

.frame_5
	db 4 ; size
	dbsprite   0,   0, $02, 2
	dbsprite   0,   8, $03, 2
	dbsprite   8,   0, $04, 2
	dbsprite   8,   8, $05, 2

.frame_6
	db 4 ; size
	dbsprite   8,   8, $15, 2
	dbsprite   0,   8, $14, 2
	dbsprite   0,   0, $00, 2
	dbsprite   8,   0, $01, 2

.frame_7
	db 4 ; size
	dbsprite   8,   8, $19, 2
	dbsprite   8,   0, $18, 2
	dbsprite   0,   8, $17, 2
	dbsprite   0,   0, $16, 2

.frame_8
	db 4 ; size
	dbsprite   8,   0, $1b, 2
	dbsprite   0,   8, $0c, 2 | OAM_XFLIP
	dbsprite   0,   0, $1a, 2
	dbsprite   8,   8, $0e, 2 | OAM_XFLIP

.frame_9
	db 4 ; size
	dbsprite   8,   0, $1d, 2
	dbsprite   0,   0, $1c, 2
	dbsprite   8,   8, $12, 2 | OAM_XFLIP
	dbsprite   0,   8, $10, 2 | OAM_XFLIP

OAMData7D::
	dw .frame_0
	dw .frame_1
	dw .frame_2
	dw .frame_3

.frame_0
	db 4 ; size
	dbsprite   0,   0, $06, 3
	dbsprite   8,   0, $07, 3
	dbsprite   0,   8, $06, 3 | OAM_XFLIP
	dbsprite   8,   8, $07, 3 | OAM_XFLIP

.frame_1
	db 4 ; size
	dbsprite   0,   0, $02, 3
	dbsprite   0,   8, $03, 3
	dbsprite   8,   0, $04, 3
	dbsprite   8,   8, $05, 3

.frame_2
	db 4 ; size
	dbsprite   0,   0, $00, 3
	dbsprite   8,   0, $01, 3
	dbsprite   0,   8, $00, 3 | OAM_XFLIP
	dbsprite   8,   8, $01, 3 | OAM_XFLIP

.frame_3
	db 4 ; size
	dbsprite   0,   0, $03, 3 | OAM_XFLIP
	dbsprite   8,   0, $05, 3 | OAM_XFLIP
	dbsprite   0,   8, $02, 3 | OAM_XFLIP
	dbsprite   8,   8, $04, 3 | OAM_XFLIP

OAMData7E::
	dw .frame_0
	dw .frame_1
	dw .frame_2
	dw .frame_3

.frame_0
	db 4 ; size
	dbsprite   0,   0, $06, 0
	dbsprite   8,   0, $07, 0
	dbsprite   0,   8, $06, 0 | OAM_XFLIP
	dbsprite   8,   8, $07, 0 | OAM_XFLIP

.frame_1
	db 4 ; size
	dbsprite   0,   0, $02, 0
	dbsprite   0,   8, $03, 0
	dbsprite   8,   0, $04, 0
	dbsprite   8,   8, $05, 0

.frame_2
	db 4 ; size
	dbsprite   0,   0, $00, 0
	dbsprite   8,   0, $01, 0
	dbsprite   0,   8, $00, 0 | OAM_XFLIP
	dbsprite   8,   8, $01, 0 | OAM_XFLIP

.frame_3
	db 4 ; size
	dbsprite   0,   0, $03, 0 | OAM_XFLIP
	dbsprite   8,   0, $05, 0 | OAM_XFLIP
	dbsprite   0,   8, $02, 0 | OAM_XFLIP
	dbsprite   8,   8, $04, 0 | OAM_XFLIP

OAMData82::
	dw .frame_0
	dw .frame_1
	dw .frame_2
	dw .frame_3
	dw .frame_4
	dw .frame_5

.frame_0
	db 4 ; size
	dbsprite   8,   0, $01, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite   8,   8, $00, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite   0,   8, $01, 1
	dbsprite   0,   0, $00, 1

.frame_1
	db 4 ; size
	dbsprite   8,   0, $03, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite   8,   8, $02, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite   0,   8, $03, 1
	dbsprite   0,   0, $02, 1

.frame_2
	db 4 ; size
	dbsprite   8,   0, $05, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite   8,   8, $04, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite   0,   8, $05, 1
	dbsprite   0,   0, $04, 1

.frame_3
	db 4 ; size
	dbsprite   8,   0, $07, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite   8,   8, $06, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite   0,   8, $07, 1
	dbsprite   0,   0, $06, 1

.frame_4
	db 4 ; size
	dbsprite   8,   0, $09, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite   8,   8, $08, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite   0,   8, $09, 1
	dbsprite   0,   0, $08, 1

.frame_5
	db 4 ; size
	dbsprite   8,   0, $0b, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite   8,   8, $0a, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite   0,   8, $0b, 1
	dbsprite   0,   0, $0a, 1

OAMData83::
	dw .frame_0
	dw .frame_1

.frame_0
	db 6 ; size
	dbsprite   8,  16, $05, 7
	dbsprite   8,   8, $04, 7
	dbsprite   8,   0, $03, 7
	dbsprite   0,  16, $02, 7
	dbsprite   0,   8, $01, 7
	dbsprite   0,   0, $00, 7

.frame_1
	db 6 ; size
	dbsprite   8,  16, $0b, 7
	dbsprite   8,   8, $0a, 7
	dbsprite   8,   0, $09, 7
	dbsprite   0,  16, $08, 7
	dbsprite   0,   8, $07, 7
	dbsprite   0,   0, $06, 7

OAMData84::
	dw .frame_0
	dw .frame_1
	dw .frame_2
	dw .frame_3
	dw .frame_4
	dw .frame_5
	dw .frame_6
	dw .frame_7
	dw .frame_8
	dw .frame_9
	dw .frame_10
	dw .frame_11
	dw .frame_12
	dw .frame_13
	dw .frame_14
	dw .frame_15

.frame_0
	db 2 ; size
	dbsprite   0,  12, $00, 1 | OAM_XFLIP
	dbsprite   0,   4, $00, 1

.frame_1
	db 4 ; size
	dbsprite   8,  12, $11, 1 | OAM_XFLIP
	dbsprite   0,  12, $01, 1 | OAM_XFLIP
	dbsprite   8,   4, $11, 1
	dbsprite   0,   4, $01, 1

.frame_2
	db 4 ; size
	dbsprite   8,  12, $12, 1 | OAM_XFLIP
	dbsprite   0,  12, $02, 1 | OAM_XFLIP
	dbsprite   8,   4, $12, 1
	dbsprite   0,   4, $02, 1

.frame_3
	db 4 ; size
	dbsprite   8,  12, $13, 1 | OAM_XFLIP
	dbsprite   0,  12, $03, 1 | OAM_XFLIP
	dbsprite   8,   4, $13, 1
	dbsprite   0,   4, $03, 1

.frame_4
	db 4 ; size
	dbsprite   8,  12, $14, 1 | OAM_XFLIP
	dbsprite   0,  12, $04, 1 | OAM_XFLIP
	dbsprite   8,   4, $14, 1
	dbsprite   0,   4, $04, 1

.frame_5
	db 4 ; size
	dbsprite   8,  12, $15, 1 | OAM_XFLIP
	dbsprite   0,  12, $05, 1 | OAM_XFLIP
	dbsprite   8,   4, $15, 1
	dbsprite   0,   4, $05, 1

.frame_6
	db 4 ; size
	dbsprite   8,  12, $07, 1
	dbsprite   8,   4, $06, 1
	dbsprite   0,  12, $05, 1 | OAM_XFLIP
	dbsprite   0,   4, $05, 1

.frame_7
	db 4 ; size
	dbsprite   8,  12, $17, 1
	dbsprite   8,   4, $16, 1
	dbsprite   0,  12, $05, 1 | OAM_XFLIP
	dbsprite   0,   4, $05, 1

.frame_8
	db 4 ; size
	dbsprite   0,  12, $05, 1 | OAM_XFLIP
	dbsprite   0,   4, $05, 1
	dbsprite   8,  12, $09, 1
	dbsprite   8,   4, $08, 1

.frame_9
	db 4 ; size
	dbsprite   0,  12, $05, 1 | OAM_XFLIP
	dbsprite   0,   4, $05, 1
	dbsprite   8,  12, $19, 1
	dbsprite   8,   4, $18, 1

.frame_10
	db 4 ; size
	dbsprite   0,  12, $05, 1 | OAM_XFLIP
	dbsprite   0,   4, $05, 1
	dbsprite   8,  12, $0b, 1
	dbsprite   8,   4, $0a, 1

.frame_11
	db 4 ; size
	dbsprite   0,  12, $05, 1 | OAM_XFLIP
	dbsprite   0,   4, $05, 1
	dbsprite   8,  12, $1b, 1
	dbsprite   8,   4, $1a, 1

.frame_12
	db 4 ; size
	dbsprite   8,  12, $1d, 1
	dbsprite   8,   4, $1c, 1
	dbsprite   0,  12, $0d, 1
	dbsprite   0,   4, $0c, 1

.frame_13
	db 4 ; size
	dbsprite   8,  12, $1f, 1
	dbsprite   8,   4, $1e, 1
	dbsprite   0,  12, $0f, 1
	dbsprite   0,   4, $0e, 1

.frame_14
	db 4 ; size
	dbsprite   8,  12, $23, 1
	dbsprite   8,   4, $22, 1
	dbsprite   0,  12, $21, 1
	dbsprite   0,   4, $20, 1

.frame_15
	db 4 ; size
	dbsprite   8,  12, $15, 1 | OAM_XFLIP
	dbsprite   8,   4, $15, 1
	dbsprite   0,  12, $10, 1
	dbsprite   0,   4, $24, 1

OAMData85::
	dw .frame_0
	dw .frame_1
	dw .frame_2
	dw .frame_3
	dw .frame_4
	dw .frame_5
	dw .frame_6

.frame_0
	db 16 ; size
	dbsprite   8,   8, $0f, 2
	dbsprite   8,   0, $0e, 2
	dbsprite   8,  -8, $0d, 2
	dbsprite   8, -16, $0c, 2
	dbsprite   0,   8, $0b, 2
	dbsprite   0,   0, $0a, 2
	dbsprite   0,  -8, $09, 2
	dbsprite   0, -16, $08, 2
	dbsprite  -8,   8, $07, 2
	dbsprite  -8,   0, $06, 2
	dbsprite  -8,  -8, $05, 2
	dbsprite  -8, -16, $04, 2
	dbsprite -16,   8, $03, 2
	dbsprite -16,   0, $02, 2
	dbsprite -16,  -8, $01, 2
	dbsprite -16, -16, $00, 2

.frame_1
	db 12 ; size
	dbsprite   4,  -1, $25, 2 | OAM_XFLIP
	dbsprite   4,   7, $24, 2 | OAM_XFLIP
	dbsprite   4,  -8, $25, 2
	dbsprite   4, -16, $24, 2
	dbsprite  -4,  -1, $21, 2 | OAM_XFLIP
	dbsprite  -4,   7, $20, 2 | OAM_XFLIP
	dbsprite  -4,  -8, $21, 2
	dbsprite  -4, -16, $20, 2
	dbsprite -12,  -1, $1d, 2 | OAM_XFLIP
	dbsprite -12,   7, $1c, 2 | OAM_XFLIP
	dbsprite -12,  -8, $1d, 2
	dbsprite -12, -16, $1c, 2

.frame_2
	db 4 ; size
	dbsprite  -4,  -1, $1f, 2 | OAM_XFLIP | OAM_YFLIP
	dbsprite  -4,   7, $1e, 2 | OAM_XFLIP | OAM_YFLIP
	dbsprite  -4,  -8, $1f, 2 | OAM_YFLIP
	dbsprite  -4, -16, $1e, 2 | OAM_YFLIP

.frame_3
	db 12 ; size
	dbsprite   4,  -1, $1b, 2 | OAM_XFLIP
	dbsprite   4,   7, $1a, 2 | OAM_XFLIP
	dbsprite   4,  -8, $1b, 2
	dbsprite   4, -16, $1a, 2
	dbsprite  -4, -16, $16, 2
	dbsprite  -4,   7, $16, 2 | OAM_XFLIP
	dbsprite  -4,  -1, $15, 2 | OAM_XFLIP
	dbsprite  -4,  -8, $15, 2
	dbsprite -12,  -1, $13, 2 | OAM_XFLIP
	dbsprite -12,   7, $12, 2 | OAM_XFLIP
	dbsprite -12,  -8, $13, 2
	dbsprite -12, -16, $12, 2

.frame_4
	db 16 ; size
	dbsprite  -1,  -8, $15, 2 | OAM_YFLIP
	dbsprite  -1,  -1, $15, 2 | OAM_XFLIP | OAM_YFLIP
	dbsprite  -8,  -1, $15, 2 | OAM_XFLIP
	dbsprite  -8,  -8, $15, 2
	dbsprite  -1, -16, $17, 2 | OAM_YFLIP
	dbsprite  -1,   7, $17, 2 | OAM_XFLIP | OAM_YFLIP
	dbsprite  -8,   7, $17, 2 | OAM_XFLIP
	dbsprite  -8, -16, $17, 2
	dbsprite   7,  -1, $23, 2 | OAM_XFLIP | OAM_YFLIP
	dbsprite   7,   7, $22, 2 | OAM_XFLIP | OAM_YFLIP
	dbsprite   7,  -8, $23, 2 | OAM_YFLIP
	dbsprite   7, -16, $22, 2 | OAM_YFLIP
	dbsprite -16,  -1, $23, 2 | OAM_XFLIP
	dbsprite -16,   7, $22, 2 | OAM_XFLIP
	dbsprite -16,  -8, $23, 2
	dbsprite -16, -16, $22, 2

.frame_5
	db 12 ; size
	dbsprite -13,  -1, $1b, 2 | OAM_XFLIP | OAM_YFLIP
	dbsprite -13,   7, $1a, 2 | OAM_XFLIP | OAM_YFLIP
	dbsprite -13,  -8, $1b, 2 | OAM_YFLIP
	dbsprite -13, -16, $1a, 2 | OAM_YFLIP
	dbsprite  -5, -16, $16, 2 | OAM_YFLIP
	dbsprite  -5,   7, $16, 2 | OAM_XFLIP | OAM_YFLIP
	dbsprite  -5,  -1, $15, 2 | OAM_XFLIP | OAM_YFLIP
	dbsprite  -5,  -8, $15, 2 | OAM_YFLIP
	dbsprite   3,  -1, $13, 2 | OAM_XFLIP | OAM_YFLIP
	dbsprite   3,   7, $12, 2 | OAM_XFLIP | OAM_YFLIP
	dbsprite   3,  -8, $13, 2 | OAM_YFLIP
	dbsprite   3, -16, $12, 2 | OAM_YFLIP

.frame_6
	db 12 ; size
	dbsprite  -4,  -1, $26, 2
	dbsprite  -4,  -8, $26, 2
	dbsprite   4,  -1, $19, 2 | OAM_XFLIP
	dbsprite   4,   7, $18, 2 | OAM_XFLIP
	dbsprite   4,  -8, $19, 2
	dbsprite   4, -16, $18, 2
	dbsprite  -4,   7, $14, 2 | OAM_XFLIP
	dbsprite  -4, -16, $14, 2
	dbsprite -12,  -1, $11, 2 | OAM_XFLIP
	dbsprite -12,   7, $10, 2 | OAM_XFLIP
	dbsprite -12,  -8, $11, 2
	dbsprite -12, -16, $10, 2

OAMData86::
	dw .frame_0
	dw .frame_1
	dw .frame_2
	dw .frame_3
	dw .frame_4

.frame_0
	db 2 ; size
	dbsprite   0,   0, $00, 0
	dbsprite   0,   8, $00, 0 | OAM_XFLIP

.frame_1
	db 4 ; size
	dbsprite   0,   0, $01, 0
	dbsprite   8,   0, $02, 0
	dbsprite   0,   8, $01, 0 | OAM_XFLIP
	dbsprite   8,   8, $02, 0 | OAM_XFLIP

.frame_2
	db 4 ; size
	dbsprite   0,   0, $03, 0
	dbsprite   8,   0, $04, 0
	dbsprite   0,   8, $03, 0 | OAM_XFLIP
	dbsprite   8,   8, $04, 0 | OAM_XFLIP

.frame_3
	db 1 ; size
	dbsprite   4,   4, $05, 0

.frame_4
	db 4 ; size
	dbsprite   0,   0, $06, 0
	dbsprite   8,   0, $07, 0
	dbsprite   0,   8, $06, 0 | OAM_XFLIP
	dbsprite   8,   8, $07, 0 | OAM_XFLIP

OAMData87::
	dw .frame_0
	dw .frame_1
	dw .frame_2

.frame_0
	db 4 ; size
	dbsprite   0,   8, $03, 0
	dbsprite   0,   0, $02, 0
	dbsprite   8,   8, $01, 0
	dbsprite   8,   0, $00, 0

.frame_1
	db 4 ; size
	dbsprite   0,   8, $07, 0
	dbsprite   0,   0, $06, 0
	dbsprite   8,   8, $05, 0
	dbsprite   8,   0, $04, 0

.frame_2
	db 4 ; size
	dbsprite   0,   8, $0b, 0
	dbsprite   0,   0, $0a, 0
	dbsprite   8,   8, $09, 0
	dbsprite   8,   0, $08, 0

OAMData89::
	dw .frame_0
	dw .frame_1

.frame_0
	db 1 ; size
	dbsprite   5,   4, $12, 0

.frame_1
	db 4 ; size
	dbsprite   8,   8, $14, 0 | OAM_XFLIP
	dbsprite   8,   0, $14, 0
	dbsprite   0,   8, $13, 0 | OAM_XFLIP
	dbsprite   0,   0, $13, 0

OAMData8A::
	dw .frame_0
	dw .frame_1
	dw .frame_2

.frame_0
	db 1 ; size
	dbsprite   2,   2, $15, 0

.frame_1
	db 1 ; size
	dbsprite   3,   3, $16, 0

.frame_2
	db 4 ; size
	dbsprite   8,   8, $1a, 0
	dbsprite   8,   0, $19, 0
	dbsprite   0,   8, $18, 0
	dbsprite   0,   0, $17, 0

OAMData8B::
	dw .frame_0
	dw .frame_1

.frame_0
	db 3 ; size
	dbsprite  19,   3, $02, 7
	dbsprite  11,  11, $01, 7
	dbsprite  11,   3, $00, 7

.frame_1
	db 3 ; size
	dbsprite  11,  11, $01, 7
	dbsprite  19,   3, $02, 7
	dbsprite  11,   3, $03, 7

OAMData8D::
	dw .frame_0
	dw .frame_1

.frame_0
	db 6 ; size
	dbsprite  16,   8, $05, 7
	dbsprite  16,   0, $04, 7
	dbsprite   8,   8, $03, 7
	dbsprite   8,   0, $02, 7
	dbsprite   0,   8, $01, 7
	dbsprite   0,   0, $00, 7

.frame_1
	db 6 ; size
	dbsprite  16,   8, $0b, 7
	dbsprite  16,   0, $0a, 7
	dbsprite   8,   8, $09, 7
	dbsprite   8,   0, $08, 7
	dbsprite   0,   8, $07, 7
	dbsprite   0,   0, $06, 7

OAMData8E::
	dw .frame_0
	dw .frame_1
	dw .frame_2

.frame_0
	db 6 ; size
	dbsprite  24,   8, $05, 7
	dbsprite  24,   0, $04, 7
	dbsprite  16,   8, $03, 7
	dbsprite  16,   0, $02, 7
	dbsprite   8,   8, $01, 7
	dbsprite   8,   0, $00, 7

.frame_1
	db 6 ; size
	dbsprite  24,   8, $0b, 7
	dbsprite  24,   0, $0a, 7
	dbsprite  16,   8, $09, 7
	dbsprite  16,   0, $08, 7
	dbsprite   8,   8, $07, 7
	dbsprite   8,   0, $06, 7

.frame_2
	db 4 ; size
	dbsprite  24,   8, $0f, 7
	dbsprite  24,   0, $0e, 7
	dbsprite   8,   8, $0d, 7
	dbsprite   8,   0, $0c, 7

OAMData8F::
	dw .frame_0
	dw .frame_1
	dw .frame_2

.frame_0
	db 4 ; size
	dbsprite   8,   8, $04, 7
	dbsprite   8,   0, $03, 7
	dbsprite   0,   8, $02, 7
	dbsprite   0,   0, $01, 7

.frame_1
	db 4 ; size
	dbsprite   8,   8, $08, 7
	dbsprite   8,   0, $07, 7
	dbsprite   0,   8, $06, 7
	dbsprite   0,   0, $05, 7

.frame_2
	db 4 ; size
	dbsprite   8,   8, $0c, 7
	dbsprite   8,   0, $0b, 7
	dbsprite   0,   8, $0a, 7
	dbsprite   0,   0, $09, 7

OAMData90::
	dw .frame_0
	dw .frame_1

.frame_0
	db 8 ; size
	dbsprite   8,  40, $07, 0
	dbsprite   8,  32, $06, 0
	dbsprite   8,  24, $05, 0
	dbsprite   8,  16, $04, 0
	dbsprite   0,  40, $03, 0
	dbsprite   0,  32, $02, 0
	dbsprite   0,  24, $01, 0
	dbsprite   0,  16, $00, 0

.frame_1
	db 4 ; size
	dbsprite   8,  24, $05, 0
	dbsprite   8,  16, $04, 0
	dbsprite   0,  24, $01, 0
	dbsprite   0,  16, $00, 0

OAMData91::
	dw .frame_0

.frame_0
	db 23 ; size
	dbsprite   0,   0, $00, 0
	dbsprite   8,   0, $08, 0
	dbsprite  16,   0, $10, 0
	dbsprite   0,   8, $01, 0
	dbsprite   8,   8, $09, 0
	dbsprite  16,   8, $11, 0
	dbsprite   0,  16, $02, 0
	dbsprite   8,  16, $0a, 0
	dbsprite  16,  16, $12, 0
	dbsprite   0,  24, $03, 0
	dbsprite   0,  32, $04, 0
	dbsprite   0,  40, $05, 0
	dbsprite   0,  56, $07, 0
	dbsprite   8,  24, $0b, 0
	dbsprite  16,  24, $13, 0
	dbsprite   8,  32, $0c, 0
	dbsprite  16,  32, $14, 0
	dbsprite   8,  40, $0d, 0
	dbsprite  16,  40, $15, 0
	dbsprite   8,  48, $0e, 0
	dbsprite  16,  48, $16, 0
	dbsprite   8,  56, $0f, 0
	dbsprite   0,  48, $06, 0

OAMData92::
	dw .frame_0

.frame_0
	db 4 ; size
	dbsprite   8,   8, $17, 0
	dbsprite   8,   0, $16, 0
	dbsprite   0,   8, $15, 0
	dbsprite   0,   0, $14, 0

OAMData93::
	dw .frame_0

.frame_0
	db 4 ; size
	dbsprite   8,   8, $1b, 1
	dbsprite   8,   0, $1a, 1
	dbsprite   0,   8, $19, 1
	dbsprite   0,   0, $18, 1

OAMData94::
	dw .frame_0

.frame_0
	db 4 ; size
	dbsprite   8,   8, $1f, 2
	dbsprite   8,   0, $1e, 2
	dbsprite   0,   8, $1d, 2
	dbsprite   0,   0, $1c, 2

OAMData95::
	dw .frame_0

.frame_0
	db 4 ; size
	dbsprite   8,   8, $23, 3
	dbsprite   8,   0, $22, 3
	dbsprite   0,   8, $21, 3
	dbsprite   0,   0, $20, 3

OAMData96::
	dw .frame_0

.frame_0
	db 4 ; size
	dbsprite   8,   8, $27, 4
	dbsprite   8,   0, $26, 4
	dbsprite   0,   8, $25, 4
	dbsprite   0,   0, $24, 4

OAMData97::
	dw .frame_0

.frame_0
	db 4 ; size
	dbsprite   8,   8, $2b, 5
	dbsprite   8,   0, $2a, 5
	dbsprite   0,   8, $29, 5
	dbsprite   0,   0, $28, 5

OAMData98::
	dw .frame_0

.frame_0
	db 4 ; size
	dbsprite   8,   8, $2f, 6
	dbsprite   8,   0, $2e, 6
	dbsprite   0,   8, $2d, 6
	dbsprite   0,   0, $2c, 6

OAMData99::
	dw .frame_0

.frame_0
	db 4 ; size
	dbsprite   8,   8, $33, 1
	dbsprite   8,   0, $32, 5
	dbsprite   0,   8, $31, 5
	dbsprite   0,   0, $30, 2

OAMData9A::
	dw .frame_0

.frame_0
	db 20 ; size
	dbsprite  -2,  -7, $00, 0
	dbsprite  -2,   1, $01, 0
	dbsprite  -2,  17, $03, 0
	dbsprite  -2,  25, $04, 0
	dbsprite  -2,   9, $02, 0
	dbsprite   6,  -7, $05, 0
	dbsprite   6,   1, $06, 0
	dbsprite   6,   9, $07, 0
	dbsprite   6,  17, $08, 0
	dbsprite   6,  25, $09, 0
	dbsprite  -2,  38, $0a, 0
	dbsprite  -2,  46, $0b, 0
	dbsprite  -2,  54, $0c, 0
	dbsprite  -2,  62, $0d, 0
	dbsprite  -2,  70, $0e, 0
	dbsprite   6,  38, $0f, 0
	dbsprite   6,  46, $10, 0
	dbsprite   6,  70, $13, 0
	dbsprite   6,  62, $12, 0
	dbsprite   6,  54, $11, 0

OAMData9B::
	dw .frame_0
	dw .frame_1
	dw .frame_2
	dw .frame_3
	dw .frame_4

.frame_0
	db 6 ; size
	dbsprite  16,   0, $05, 0
	dbsprite  16,  -8, $04, 0
	dbsprite   8,   0, $03, 0
	dbsprite   8,  -8, $02, 0
	dbsprite   0,   0, $01, 0
	dbsprite   0,  -8, $00, 0

.frame_1
	db 6 ; size
	dbsprite   8,   0, $05, 0
	dbsprite   8,  -8, $04, 0
	dbsprite   0,   0, $03, 0
	dbsprite   0,  -8, $02, 0
	dbsprite  -8,   0, $01, 0
	dbsprite  -8,  -8, $00, 0

.frame_2
	db 4 ; size
	dbsprite   0,   0, $05, 0
	dbsprite   0,  -8, $04, 0
	dbsprite  -8,   0, $03, 0
	dbsprite  -8,  -8, $02, 0

.frame_3
	db 2 ; size
	dbsprite  -8,   0, $05, 0
	dbsprite  -8,  -8, $04, 0

.frame_4
	db 6 ; size
	dbsprite  16,   8, $05, 0
	dbsprite  16,   0, $04, 0
	dbsprite   8,   8, $03, 0
	dbsprite   8,   0, $02, 0
	dbsprite   0,   8, $01, 0
	dbsprite   0,   0, $00, 0

OAMData9C::
	dw .frame_0
	dw .frame_1
	dw .frame_2
	dw .frame_3
	dw .frame_4
	dw .frame_5
	dw .frame_6
	dw .frame_7
	dw .frame_8
	dw .frame_9

.frame_0
	db 8 ; size
	dbsprite -48,  -8, $04, 0 | OAM_XFLIP
	dbsprite -56,  -8, $01, 0 | OAM_XFLIP
	dbsprite -56, -16, $00, 0
	dbsprite -48, -16, $03, 0
	dbsprite -48,   8, $05, 0
	dbsprite -48,   0, $04, 0
	dbsprite -56,   8, $02, 0
	dbsprite -56,   0, $01, 0

.frame_1
	db 8 ; size
	dbsprite -48, -16, $04, 0 | OAM_XFLIP
	dbsprite -56, -16, $01, 0 | OAM_XFLIP
	dbsprite -56, -24, $00, 0
	dbsprite -48, -24, $03, 0
	dbsprite -48,   0, $05, 0
	dbsprite -48,  -8, $04, 0
	dbsprite -56,   0, $02, 0
	dbsprite -56,  -8, $01, 0

.frame_2
	db 8 ; size
	dbsprite -48, -24, $04, 0 | OAM_XFLIP
	dbsprite -56, -24, $01, 0 | OAM_XFLIP
	dbsprite -56, -32, $00, 0
	dbsprite -48, -32, $03, 0
	dbsprite -48,  -8, $05, 0
	dbsprite -48, -16, $04, 0
	dbsprite -56,  -8, $02, 0
	dbsprite -56, -16, $01, 0

.frame_3
	db 8 ; size
	dbsprite -48, -32, $04, 0 | OAM_XFLIP
	dbsprite -56, -32, $01, 0 | OAM_XFLIP
	dbsprite -56, -40, $00, 0
	dbsprite -48, -40, $03, 0
	dbsprite -48, -16, $05, 0
	dbsprite -48, -24, $04, 0
	dbsprite -56, -16, $02, 0
	dbsprite -56, -24, $01, 0

.frame_4
	db 8 ; size
	dbsprite -48, -40, $04, 0 | OAM_XFLIP
	dbsprite -56, -40, $01, 0 | OAM_XFLIP
	dbsprite -56, -48, $00, 0
	dbsprite -48, -48, $03, 0
	dbsprite -48, -24, $05, 0
	dbsprite -48, -32, $04, 0
	dbsprite -56, -24, $02, 0
	dbsprite -56, -32, $01, 0

.frame_5
	db 8 ; size
	dbsprite -48, -48, $04, 0 | OAM_XFLIP
	dbsprite -56, -48, $01, 0 | OAM_XFLIP
	dbsprite -56, -56, $00, 0
	dbsprite -48, -56, $03, 0
	dbsprite -48, -32, $05, 0
	dbsprite -48, -40, $04, 0
	dbsprite -56, -32, $02, 0
	dbsprite -56, -40, $01, 0

.frame_6
	db 8 ; size
	dbsprite -48, -56, $04, 0 | OAM_XFLIP
	dbsprite -56, -56, $01, 0 | OAM_XFLIP
	dbsprite -56, -64, $00, 0
	dbsprite -48, -64, $03, 0
	dbsprite -48, -40, $05, 0
	dbsprite -48, -48, $04, 0
	dbsprite -56, -40, $02, 0
	dbsprite -56, -48, $01, 0

.frame_7
	db 7 ; size
	dbsprite -56, -64, $01, 0 | OAM_XFLIP
	dbsprite -48, -48, $05, 0
	dbsprite -48, -56, $04, 0
	dbsprite -48, -56, $05, 0
	dbsprite -48, -64, $04, 0 | OAM_XFLIP
	dbsprite -56, -48, $02, 0
	dbsprite -56, -56, $01, 0

.frame_8
	db 4 ; size
	dbsprite -48, -56, $05, 0
	dbsprite -48, -64, $04, 0
	dbsprite -56, -56, $02, 0
	dbsprite -56, -64, $01, 0

.frame_9
	db 2 ; size
	dbsprite -48, -64, $05, 0
	dbsprite -56, -64, $02, 0

OAMData9D::
	dw .frame_0

.frame_0
	db 16 ; size
	dbsprite  32,   0, $07, 0
	dbsprite   0,  32, $06, 0
	dbsprite   0,  24, $05, 0
	dbsprite   0,  16, $05, 0
	dbsprite   0,   8, $05, 0
	dbsprite   0,   0, $04, 0
	dbsprite  32,  16, $01, 0 | OAM_YFLIP
	dbsprite  32,  32, $02, 0 | OAM_YFLIP
	dbsprite  32,  24, $01, 0 | OAM_YFLIP
	dbsprite  32,   8, $01, 0 | OAM_YFLIP
	dbsprite  24,  32, $03, 0 | OAM_XFLIP
	dbsprite  16,  32, $03, 0 | OAM_XFLIP
	dbsprite   8,  32, $03, 0 | OAM_XFLIP
	dbsprite  24,  -1, $03, 0
	dbsprite  16,  -1, $03, 0
	dbsprite   8,  -1, $03, 0

OAMData9E::
	dw .frame_0
	dw .frame_1

.frame_0
	db 2 ; size
	dbsprite  -8,  72, $6a, 0
	dbsprite  -8, -80, $6a, 0

.frame_1
	db 2 ; size
	dbsprite  -8,  72, $6b, 0
	dbsprite  -8, -80, $6b, 0

OAMData9F::
	dw .frame_0

.frame_0
	db 30 ; size
	dbsprite -56,  32, $29, 2
	dbsprite -56,  24, $28, 2
	dbsprite -56,  16, $27, 2
	dbsprite -56,   8, $26, 2
	dbsprite -56,   0, $25, 2
	dbsprite -56,  -8, $24, 2
	dbsprite -56, -16, $23, 2
	dbsprite -56, -24, $22, 2
	dbsprite -56, -32, $21, 2
	dbsprite -56, -40, $20, 2
	dbsprite -64,  32, $19, 2
	dbsprite -64,  24, $18, 2
	dbsprite -64,  16, $17, 2
	dbsprite -64,   8, $16, 2
	dbsprite -64,   0, $15, 2
	dbsprite -64,  -8, $14, 2
	dbsprite -64, -16, $13, 2
	dbsprite -64, -24, $12, 2
	dbsprite -64, -32, $11, 2
	dbsprite -64, -40, $10, 2
	dbsprite -72,  32, $09, 2
	dbsprite -72,  24, $08, 2
	dbsprite -72,  16, $07, 2
	dbsprite -72,   8, $06, 2
	dbsprite -72,   0, $05, 2
	dbsprite -72,  -8, $04, 2
	dbsprite -72, -16, $03, 2
	dbsprite -72, -24, $02, 2
	dbsprite -72, -32, $01, 2
	dbsprite -72, -40, $00, 2

OAMDataA0::
	dw .frame_0

.frame_0
	db 40 ; size
	dbsprite  56,  32, $69, 4
	dbsprite  56,  24, $68, 4
	dbsprite  56,  16, $67, 4
	dbsprite  56,   8, $66, 4
	dbsprite  56,   0, $65, 4
	dbsprite  56,  -8, $64, 4
	dbsprite  56, -16, $63, 4
	dbsprite  56, -24, $62, 4
	dbsprite  56, -32, $61, 4
	dbsprite  56, -40, $60, 4
	dbsprite  48,  32, $59, 4
	dbsprite  48,  24, $58, 4
	dbsprite  48,  16, $57, 4
	dbsprite  48,   8, $56, 4
	dbsprite  48,   0, $55, 4
	dbsprite  48,  -8, $54, 4
	dbsprite  48, -16, $53, 4
	dbsprite  48, -24, $52, 4
	dbsprite  48, -32, $51, 4
	dbsprite  48, -40, $50, 4
	dbsprite  40,  32, $49, 4
	dbsprite  40,  24, $48, 4
	dbsprite  40,  16, $47, 4
	dbsprite  40,   8, $46, 4
	dbsprite  40,   0, $45, 4
	dbsprite  40,  -8, $44, 4
	dbsprite  40, -16, $43, 4
	dbsprite  40, -24, $42, 4
	dbsprite  40, -32, $41, 4
	dbsprite  40, -40, $40, 4
	dbsprite  32,  32, $39, 4
	dbsprite  32,  24, $38, 4
	dbsprite  32,  16, $37, 4
	dbsprite  32,   8, $36, 4
	dbsprite  32,   0, $35, 4
	dbsprite  32,  -8, $34, 4
	dbsprite  32, -16, $33, 4
	dbsprite  32, -24, $32, 4
	dbsprite  32, -32, $31, 4
	dbsprite  32, -40, $30, 4

OAMDataA1::
	dw .frame_0

.frame_0
	db 36 ; size
	dbsprite  56,  28, $5f, 1
	dbsprite  56,  20, $5e, 1
	dbsprite  56,  12, $5d, 1
	dbsprite  48,  28, $4f, 1
	dbsprite  48,  20, $4e, 1
	dbsprite  48,  12, $4d, 1
	dbsprite  40,  28, $5c, 1
	dbsprite  40,  20, $5b, 1
	dbsprite  40,  12, $5a, 1
	dbsprite  32,  28, $4c, 1
	dbsprite  32,  20, $4b, 1
	dbsprite  32,  12, $4a, 1
	dbsprite  56,   4, $3f, 1
	dbsprite  56,  -4, $3e, 1
	dbsprite  56, -12, $3d, 1
	dbsprite  56, -20, $3c, 1
	dbsprite  56, -28, $3b, 1
	dbsprite  56, -36, $3a, 1
	dbsprite  48,   4, $2f, 1
	dbsprite  48,  -4, $2e, 1
	dbsprite  48, -12, $2d, 1
	dbsprite  48, -20, $2c, 1
	dbsprite  48, -28, $2b, 1
	dbsprite  48, -36, $2a, 1
	dbsprite  40,   4, $1f, 1
	dbsprite  40,  -4, $1e, 1
	dbsprite  40, -12, $1d, 1
	dbsprite  40, -20, $1c, 1
	dbsprite  40, -28, $1b, 1
	dbsprite  40, -36, $1a, 1
	dbsprite  32,   4, $0f, 1
	dbsprite  32,  -4, $0e, 1
	dbsprite  32, -12, $0d, 1
	dbsprite  32, -20, $0c, 1
	dbsprite  32, -28, $0b, 1
	dbsprite  32, -36, $0a, 1

OAMDataA2::
	dw .frame_0
	dw .frame_1
	dw .frame_2
	dw .frame_3

.frame_0
	db 12 ; size
	dbsprite -40, -40, $7f, 3
	dbsprite -40, -48, $7e, 3
	dbsprite -40, -56, $7d, 3
	dbsprite -40, -64, $7c, 3
	dbsprite -48, -40, $83, 3
	dbsprite -48, -48, $82, 3
	dbsprite -48, -56, $81, 3
	dbsprite -48, -64, $80, 3
	dbsprite -56, -40, $73, 3
	dbsprite -56, -48, $72, 3
	dbsprite -56, -56, $71, 3
	dbsprite -56, -64, $70, 3

.frame_1
	db 24 ; size
	dbsprite -40, -40, $7f, 3
	dbsprite -40, -48, $7e, 3
	dbsprite -40, -56, $7d, 3
	dbsprite -40, -64, $7c, 3
	dbsprite -40,   8, $6f, 2
	dbsprite -40,   0, $6e, 2
	dbsprite -40,  -8, $6d, 2
	dbsprite -40, -16, $6c, 2
	dbsprite -48,   8, $87, 2
	dbsprite -48,   0, $86, 2
	dbsprite -48,  -8, $85, 2
	dbsprite -48, -16, $84, 2
	dbsprite -56,   8, $77, 2
	dbsprite -56,   0, $76, 2
	dbsprite -56,  -8, $75, 2
	dbsprite -56, -16, $74, 2
	dbsprite -48, -40, $83, 3
	dbsprite -48, -48, $82, 3
	dbsprite -48, -56, $81, 3
	dbsprite -48, -64, $80, 3
	dbsprite -56, -40, $73, 3
	dbsprite -56, -48, $72, 3
	dbsprite -56, -56, $71, 3
	dbsprite -56, -64, $70, 3

.frame_2
	db 24 ; size
	dbsprite -40,   8, $6f, 2
	dbsprite -40,   0, $6e, 2
	dbsprite -40,  -8, $6d, 2
	dbsprite -40, -16, $6c, 2
	dbsprite -40,  56, $8f, 3
	dbsprite -40,  48, $8e, 3
	dbsprite -40,  40, $8d, 3
	dbsprite -40,  32, $8c, 3
	dbsprite -48,  56, $8b, 3
	dbsprite -48,  48, $8a, 3
	dbsprite -48,  40, $89, 3
	dbsprite -48,  32, $88, 3
	dbsprite -56,  56, $7b, 3
	dbsprite -56,  48, $7a, 3
	dbsprite -56,  40, $79, 3
	dbsprite -56,  32, $78, 3
	dbsprite -48,   8, $87, 2
	dbsprite -48,   0, $86, 2
	dbsprite -48,  -8, $85, 2
	dbsprite -48, -16, $84, 2
	dbsprite -56,   8, $77, 2
	dbsprite -56,   0, $76, 2
	dbsprite -56,  -8, $75, 2
	dbsprite -56, -16, $74, 2

.frame_3
	db 12 ; size
	dbsprite -40,  56, $8f, 3
	dbsprite -40,  48, $8e, 3
	dbsprite -40,  40, $8d, 3
	dbsprite -40,  32, $8c, 3
	dbsprite -48,  56, $8b, 3
	dbsprite -48,  48, $8a, 3
	dbsprite -48,  40, $89, 3
	dbsprite -48,  32, $88, 3
	dbsprite -56,  56, $7b, 3
	dbsprite -56,  48, $7a, 3
	dbsprite -56,  40, $79, 3
	dbsprite -56,  32, $78, 3

OAMDataA3::
	dw .frame_0
	dw .frame_1
	dw .frame_2
	dw .frame_3
	dw .frame_4

.frame_0
	db 3 ; size
	dbsprite  16,  24, $01, 0 | OAM_XFLIP
	dbsprite  16,  16, $02, 0
	dbsprite  16,   8, $01, 0

.frame_1
	db 10 ; size
	dbsprite   8,   0, $00, 0 | OAM_XFLIP
	dbsprite   8,  32, $00, 0
	dbsprite   8,  24, $06, 0 | OAM_XFLIP
	dbsprite  16,  24, $05, 0 | OAM_XFLIP
	dbsprite  16,  32, $04, 0 | OAM_XFLIP
	dbsprite  16,  16, $02, 0
	dbsprite   8,  16, $07, 0
	dbsprite   8,   8, $06, 0
	dbsprite  16,   8, $05, 0
	dbsprite  16,   0, $04, 0

.frame_2
	db 15 ; size
	dbsprite   8,  24, $06, 0 | OAM_XFLIP
	dbsprite  16,  24, $05, 0 | OAM_XFLIP
	dbsprite  16,  32, $04, 0 | OAM_XFLIP
	dbsprite   8,  32, $0a, 0 | OAM_XFLIP
	dbsprite   8,   0, $0a, 0
	dbsprite   0,  32, $03, 0 | OAM_XFLIP
	dbsprite   0,  24, $08, 0 | OAM_XFLIP
	dbsprite   0,  16, $09, 0
	dbsprite   0,   8, $08, 0
	dbsprite   0,   0, $03, 0
	dbsprite  16,  16, $02, 0
	dbsprite   8,  16, $07, 0
	dbsprite   8,   8, $06, 0
	dbsprite  16,   8, $05, 0
	dbsprite  16,   0, $04, 0

.frame_3
	db 14 ; size
	dbsprite   0,  24, $08, 0 | OAM_XFLIP
	dbsprite   0,  32, $03, 0 | OAM_XFLIP
	dbsprite   0,   0, $03, 0
	dbsprite   0,  16, $09, 0
	dbsprite   0,   8, $08, 0
	dbsprite  16,  24, $0b, 0 | OAM_XFLIP
	dbsprite  16,   8, $0b, 0
	dbsprite  16,  32, $04, 0 | OAM_XFLIP
	dbsprite   8,  24, $06, 0 | OAM_XFLIP
	dbsprite   8,  32, $0a, 0 | OAM_XFLIP
	dbsprite   8,   0, $0a, 0
	dbsprite  16,   0, $04, 0
	dbsprite   8,  16, $07, 0
	dbsprite   8,   8, $06, 0

.frame_4
	db 7 ; size
	dbsprite   8,  32, $0c, 0 | OAM_XFLIP
	dbsprite   8,   0, $0c, 0
	dbsprite   0,  32, $03, 0 | OAM_XFLIP
	dbsprite   0,  24, $08, 0 | OAM_XFLIP
	dbsprite   0,  16, $09, 0
	dbsprite   0,   8, $08, 0
	dbsprite   0,   0, $03, 0

OAMDataA4::
	dw .frame_0

.frame_0
	db 16 ; size
	dbsprite  16,  16, $05, 0 | OAM_YFLIP
	dbsprite  16,   8, $04, 0 | OAM_YFLIP
	dbsprite   8,  16, $05, 0
	dbsprite   8,   8, $04, 0
	dbsprite  16,   0, $02, 0
	dbsprite   8,   0, $02, 0 | OAM_YFLIP
	dbsprite   8,  24, $01, 0 | OAM_YFLIP
	dbsprite  16,  24, $01, 0
	dbsprite  24,  24, $03, 0 | OAM_YFLIP
	dbsprite  24,  16, $02, 0 | OAM_YFLIP
	dbsprite  24,   8, $01, 0 | OAM_YFLIP
	dbsprite  24,   0, $00, 0 | OAM_YFLIP
	dbsprite   0,  24, $03, 0
	dbsprite   0,  16, $02, 0
	dbsprite   0,   8, $01, 0
	dbsprite   0,   0, $00, 0

OAMDataA5::
	dw .frame_0
	dw .frame_1
	dw .frame_2
	dw .frame_3
	dw .frame_4
	dw .frame_5
	dw .frame_6
	dw .frame_7
	dw .frame_8
	dw .frame_9
	dw .frame_10

.frame_0
	db 12 ; size
	dbsprite -32, -40, $22, 1 | OAM_YFLIP
	dbsprite -24, -32, $14, 1
	dbsprite -16,  16, $21, 1
	dbsprite -24,  24, $13, 1
	dbsprite -24,  16, $12, 1
	dbsprite -32,  24, $03, 1
	dbsprite -32,  16, $02, 1
	dbsprite -24, -40, $20, 1
	dbsprite -32, -24, $11, 1
	dbsprite -32, -32, $10, 1
	dbsprite -40, -24, $01, 1
	dbsprite -40, -32, $00, 1

.frame_1
	db 18 ; size
	dbsprite  -8,   8, $22, 1 | OAM_XFLIP
	dbsprite -40, -32, $22, 1 | OAM_YFLIP
	dbsprite -32, -40, $22, 1 | OAM_YFLIP
	dbsprite -32, -32, $26, 1
	dbsprite -16,   8, $18, 1
	dbsprite -16,   0, $17, 1
	dbsprite -24,   8, $08, 1
	dbsprite -24,   0, $07, 1
	dbsprite -16,  16, $24, 1
	dbsprite -24,  16, $25, 1
	dbsprite  -8,   0, $22, 1
	dbsprite -24, -24, $22, 1
	dbsprite -32, -16, $16, 1
	dbsprite -32, -24, $15, 1
	dbsprite -40, -16, $06, 1
	dbsprite -40, -24, $05, 1
	dbsprite -24, -32, $14, 1
	dbsprite -24, -40, $20, 1

.frame_2
	db 23 ; size
	dbsprite -48, -16, $14, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite -24,   0, $22, 1 | OAM_YFLIP
	dbsprite  -8,   8, $22, 1 | OAM_XFLIP
	dbsprite -32, -40, $22, 1 | OAM_YFLIP
	dbsprite -40, -32, $22, 1 | OAM_YFLIP
	dbsprite -16,   8, $2a, 1
	dbsprite -16,   0, $29, 1
	dbsprite -32,  16, $0c, 1
	dbsprite -24,   8, $1b, 1
	dbsprite -32,   8, $0b, 1
	dbsprite -40, -24, $28, 1
	dbsprite -40, -16, $19, 1
	dbsprite -48,  -8, $0a, 1
	dbsprite -40,  -8, $1a, 1
	dbsprite -32, -16, $27, 1
	dbsprite -32, -32, $26, 1
	dbsprite -16,  16, $24, 1
	dbsprite -24,  16, $25, 1
	dbsprite  -8,   0, $22, 1
	dbsprite -24, -24, $22, 1
	dbsprite -32, -24, $15, 1
	dbsprite -24, -40, $20, 1
	dbsprite -24, -32, $14, 1

.frame_3
	db 28 ; size
	dbsprite  -8,   8, $22, 1 | OAM_XFLIP
	dbsprite -32, -40, $22, 1 | OAM_YFLIP
	dbsprite -40, -32, $22, 1 | OAM_YFLIP
	dbsprite -48, -16, $14, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite -16,   0, $40, 1
	dbsprite -24,   0, $30, 1
	dbsprite -16,  -8, $1d, 1
	dbsprite -24,  -8, $2f, 1
	dbsprite -24, -16, $2e, 1
	dbsprite -32,  -8, $0d, 1
	dbsprite -32,   0, $1e, 1
	dbsprite -40,   0, $0e, 1
	dbsprite -40,  -8, $2c, 1
	dbsprite -40, -16, $1c, 1
	dbsprite -48,  -8, $2b, 1
	dbsprite -24,   8, $1b, 1
	dbsprite -16,   8, $2a, 1
	dbsprite -40, -24, $28, 1
	dbsprite -32, -16, $27, 1
	dbsprite -32, -32, $26, 1
	dbsprite -16,  16, $24, 1
	dbsprite -24,  16, $25, 1
	dbsprite -24, -24, $22, 1
	dbsprite  -8,   0, $22, 1
	dbsprite -32, -24, $15, 1
	dbsprite -24, -40, $20, 1
	dbsprite -24, -32, $14, 1
	dbsprite -32,   8, $2d, 1

.frame_4
	db 28 ; size
	dbsprite -48, -16, $14, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite  -8,   8, $22, 1 | OAM_XFLIP
	dbsprite -16,  16, $22, 1 | OAM_XFLIP
	dbsprite -40, -32, $22, 1 | OAM_YFLIP
	dbsprite -24,  16, $3a, 1
	dbsprite -24,   8, $32, 1
	dbsprite -16,   0, $49, 1
	dbsprite -16,  -8, $48, 1
	dbsprite -16, -16, $47, 1
	dbsprite -24,   0, $39, 1
	dbsprite -24,  -8, $38, 1
	dbsprite -24, -16, $37, 1
	dbsprite -24, -24, $22, 1
	dbsprite -32,   8, $46, 1
	dbsprite -32,   0, $45, 1
	dbsprite -32,  -8, $44, 1
	dbsprite -32, -16, $43, 1
	dbsprite -40,   8, $36, 1
	dbsprite -40,   0, $35, 1
	dbsprite -40,  -8, $34, 1
	dbsprite -40, -16, $33, 1
	dbsprite -48,   0, $42, 1
	dbsprite -48,  -8, $41, 1
	dbsprite -32, -32, $31, 1
	dbsprite -32, -24, $15, 1
	dbsprite -16,   8, $2a, 1
	dbsprite -40, -24, $28, 1
	dbsprite  -8,   0, $22, 1

.frame_5
	db 23 ; size
	dbsprite -24,   8, $5b, 1
	dbsprite -24,   0, $5a, 1
	dbsprite -24,  -8, $59, 1
	dbsprite -24, -16, $58, 1
	dbsprite -16,   8, $57, 1
	dbsprite -16,   0, $56, 1
	dbsprite -16,  -8, $55, 1
	dbsprite -16, -16, $54, 1
	dbsprite -32,   8, $53, 1
	dbsprite -32,   0, $52, 1
	dbsprite -32,  -8, $51, 1
	dbsprite -32, -16, $50, 1
	dbsprite  -8,   0, $4b, 1
	dbsprite  -8,  -8, $4a, 1
	dbsprite -24, -24, $3b, 1
	dbsprite -40,   8, $4f, 1
	dbsprite -40,   0, $4e, 1
	dbsprite -40,  -8, $4d, 1
	dbsprite -40, -16, $4c, 1
	dbsprite -48,   8, $3f, 1
	dbsprite -48,   0, $3e, 1
	dbsprite -48,  -8, $3d, 1
	dbsprite -48, -16, $3c, 1

.frame_6
	db 9 ; size
	dbsprite   8,  16, $09, 0
	dbsprite  -8,   0, $09, 0
	dbsprite -24, -16, $09, 0
	dbsprite -16, -56, $09, 0
	dbsprite   8, -40, $04, 1
	dbsprite -48,  32, $04, 1
	dbsprite -32,  16, $04, 1
	dbsprite -40,   0, $04, 1
	dbsprite -48, -32, $04, 1

.frame_7
	db 9 ; size
	dbsprite  16, -40, $09, 1
	dbsprite -40,  32, $09, 1
	dbsprite -24,  16, $09, 1
	dbsprite -32,   0, $09, 1
	dbsprite -40, -32, $09, 1
	dbsprite  16,  16, $04, 0
	dbsprite   0,   0, $04, 0
	dbsprite -16, -16, $04, 0
	dbsprite  -8, -56, $04, 0

.frame_8
	db 7 ; size
	dbsprite   8,   0, $5c, 0
	dbsprite  -8, -16, $5c, 0
	dbsprite   0, -56, $5c, 0
	dbsprite -32,  32, $0f, 1
	dbsprite -16,  16, $0f, 1
	dbsprite -24,   0, $0f, 1
	dbsprite -32, -32, $0f, 1

.frame_9
	db 7 ; size
	dbsprite  16,   0, $5d, 0
	dbsprite   0, -16, $5d, 0
	dbsprite   8, -56, $5d, 0
	dbsprite -24,  32, $1f, 1
	dbsprite  -8,  16, $1f, 1
	dbsprite -16,   0, $1f, 1
	dbsprite -24, -32, $1f, 1

.frame_10
	db 6 ; size
	dbsprite  16, -56, $5e, 0
	dbsprite   8, -16, $5e, 0
	dbsprite -16,  32, $23, 1
	dbsprite   0,  16, $23, 1
	dbsprite  -8,   0, $23, 1
	dbsprite -16, -32, $23, 1

OAMDataA6::
	dw .frame_0
	dw .frame_1
	dw .frame_2
	dw .frame_3
	dw .frame_4
	dw .frame_5
	dw .frame_6
	dw .frame_7
	dw .frame_8
	dw .frame_9
	dw .frame_10

.frame_0
	db 5 ; size
	dbsprite   6,  14, $0e, 0
	dbsprite -16, -20, $08, 0
	dbsprite -16, -28, $07, 0
	dbsprite  -8, -24, $18, 0
	dbsprite  -8, -32, $17, 0

.frame_1
	db 8 ; size
	dbsprite   0,   4, $19, 0
	dbsprite   8,  14, $0c, 0
	dbsprite   0,  12, $1c, 0
	dbsprite  -8,   4, $0b, 0
	dbsprite  -7,  -9, $1a, 0
	dbsprite  -7, -17, $19, 0
	dbsprite -15, -17, $0a, 0
	dbsprite -15, -25, $09, 0

.frame_2
	db 7 ; size
	dbsprite   0,   8, $1f, 0
	dbsprite  -8,   2, $0f, 0
	dbsprite   0,   0, $2e, 0
	dbsprite   0,  -8, $2d, 0
	dbsprite  -8,  -8, $1e, 0
	dbsprite  -8, -16, $1d, 0
	dbsprite -16, -16, $0d, 0

.frame_3
	db 4 ; size
	dbsprite  -8,  -1, $0d, 0 | OAM_XFLIP
	dbsprite  -8,  -8, $0d, 0
	dbsprite   0,   0, $27, 0
	dbsprite   0,  -8, $26, 0

.frame_4
	db 2 ; size
	dbsprite   0,   0, $03, 1
	dbsprite   8,  -8, $2c, 1

.frame_5
	db 5 ; size
	dbsprite  -8,   0, $03, 1
	dbsprite   0, -16, $03, 1
	dbsprite   0,   8, $2c, 1
	dbsprite  -8, -24, $2c, 1
	dbsprite -16, -16, $2b, 1

.frame_6
	db 8 ; size
	dbsprite -16,  16, $03, 1
	dbsprite   8,   0, $03, 1
	dbsprite   8, -24, $03, 1
	dbsprite   8,  24, $2c, 1
	dbsprite -16, -32, $2c, 1
	dbsprite -24, -24, $2b, 1
	dbsprite  -8,   0, $2b, 1
	dbsprite   0,  -8, $1b, 1

.frame_7
	db 9 ; size
	dbsprite -24,  32, $03, 1
	dbsprite  16,   8, $03, 1
	dbsprite   8, -32, $03, 1
	dbsprite   8,  32, $2c, 1
	dbsprite -16, -40, $2c, 1
	dbsprite  -8,  16, $2b, 1
	dbsprite  -8, -16, $2b, 1
	dbsprite -32, -32, $1b, 1
	dbsprite   8,  -8, $1b, 1

.frame_8
	db 9 ; size
	dbsprite  -8,  40, $03, 1
	dbsprite  40,   8, $03, 1
	dbsprite  24, -40, $03, 1
	dbsprite  32,  40, $2c, 1
	dbsprite  -8, -48, $2c, 1
	dbsprite   8,  24, $2b, 1
	dbsprite   8, -24, $2b, 1
	dbsprite -24, -40, $1b, 1
	dbsprite  24,  -8, $1b, 1

.frame_9
	db 36 ; size
	dbsprite  24,  44, $32, 0
	dbsprite  24,  36, $31, 0
	dbsprite  24,  28, $30, 0
	dbsprite  24, -36, $32, 0
	dbsprite  24, -44, $31, 0
	dbsprite  24, -52, $30, 0
	dbsprite  16,  24, $23, 0
	dbsprite  16,  16, $22, 0
	dbsprite  16, -56, $23, 0
	dbsprite  16, -64, $22, 0
	dbsprite  16,  40, $25, 0
	dbsprite  16,  32, $25, 0
	dbsprite  16, -40, $25, 0
	dbsprite  16, -48, $25, 0
	dbsprite  16,  48, $2f, 0
	dbsprite  16, -32, $2f, 0
	dbsprite   8,  48, $21, 0
	dbsprite   8, -32, $21, 0
	dbsprite   8,  20, $20, 0
	dbsprite   8, -60, $20, 0
	dbsprite  -8,  44, $02, 0
	dbsprite  -8,  36, $01, 0
	dbsprite  -8,  28, $00, 0
	dbsprite  -8, -36, $02, 0
	dbsprite  -8, -44, $01, 0
	dbsprite  -8, -52, $00, 0
	dbsprite   0,  56, $14, 0
	dbsprite   0,  48, $13, 0
	dbsprite   0,  40, $12, 0
	dbsprite   0,  32, $11, 0
	dbsprite   0,  24, $10, 0
	dbsprite   0, -24, $14, 0
	dbsprite   0, -32, $13, 0
	dbsprite   0, -40, $12, 0
	dbsprite   0, -48, $11, 0
	dbsprite   0, -56, $10, 0

.frame_10
	db 36 ; size
	dbsprite   8, -28, $33, 0 | OAM_XFLIP
	dbsprite   8,  20, $33, 0
	dbsprite   8,  52, $33, 0 | OAM_XFLIP
	dbsprite   8, -60, $33, 0
	dbsprite  24, -32, $28, 0 | OAM_XFLIP
	dbsprite  24,  48, $28, 0 | OAM_XFLIP
	dbsprite  24,  40, $2a, 0
	dbsprite  24,  32, $29, 0
	dbsprite  24,  24, $28, 0
	dbsprite  24, -40, $2a, 0
	dbsprite  24, -48, $29, 0
	dbsprite  24, -56, $28, 0
	dbsprite  16, -40, $25, 0 | OAM_XFLIP
	dbsprite  16, -32, $24, 0 | OAM_XFLIP
	dbsprite  16,  40, $25, 0 | OAM_XFLIP
	dbsprite  16,  48, $24, 0 | OAM_XFLIP
	dbsprite  16,  32, $25, 0
	dbsprite  16,  24, $24, 0
	dbsprite  16, -48, $25, 0
	dbsprite  16, -56, $24, 0
	dbsprite   0,  48, $16, 0
	dbsprite   0,  40, $15, 0
	dbsprite   0,  24, $16, 0 | OAM_XFLIP
	dbsprite   0,  32, $15, 0 | OAM_XFLIP
	dbsprite   0, -56, $16, 0 | OAM_XFLIP
	dbsprite   0, -48, $15, 0 | OAM_XFLIP
	dbsprite   0, -32, $16, 0
	dbsprite   0, -40, $15, 0
	dbsprite  -8,  24, $06, 0 | OAM_XFLIP
	dbsprite  -8, -56, $06, 0 | OAM_XFLIP
	dbsprite  -8,  48, $06, 0
	dbsprite  -8,  40, $05, 0
	dbsprite  -8,  32, $04, 0
	dbsprite  -8, -32, $06, 0
	dbsprite  -8, -40, $05, 0
	dbsprite  -8, -48, $04, 0

OAMDataA7::
	dw .frame_0
	dw .frame_1
	dw .frame_2
	dw .frame_3
	dw .frame_4
	dw .frame_5
	dw .frame_6
	dw .frame_7
	dw .frame_8
	dw .frame_9
	dw .frame_10
	dw .frame_11
	dw .frame_12
	dw .frame_13
	dw .frame_14
	dw .frame_15
	dw .frame_16
	dw .frame_17
	dw .frame_18

.frame_0
	db 2 ; size
	dbsprite -36, -68, $01, 0 | OAM_XFLIP
	dbsprite -36, -76, $02, 0 | OAM_YFLIP

.frame_1
	db 4 ; size
	dbsprite -36, -68, $01, 0 | OAM_XFLIP
	dbsprite -44, -76, $02, 0 | OAM_YFLIP
	dbsprite -52, -76, $02, 0 | OAM_YFLIP
	dbsprite -36, -76, $02, 0 | OAM_YFLIP

.frame_2
	db 6 ; size
	dbsprite -36, -68, $01, 0 | OAM_XFLIP
	dbsprite -44, -76, $02, 0 | OAM_YFLIP
	dbsprite -52, -76, $02, 0 | OAM_YFLIP
	dbsprite -36, -76, $02, 0 | OAM_YFLIP
	dbsprite -60, -76, $01, 0
	dbsprite -60, -68, $01, 0

.frame_3
	db 8 ; size
	dbsprite -36, -68, $01, 0 | OAM_XFLIP
	dbsprite -44, -76, $02, 0 | OAM_YFLIP
	dbsprite -52, -76, $02, 0 | OAM_YFLIP
	dbsprite -36, -76, $02, 0 | OAM_YFLIP
	dbsprite -60, -76, $01, 0
	dbsprite -60, -68, $01, 0
	dbsprite -60, -60, $01, 0
	dbsprite -60, -52, $01, 0

.frame_4
	db 10 ; size
	dbsprite -36, -68, $01, 0 | OAM_XFLIP
	dbsprite -44, -76, $02, 0 | OAM_YFLIP
	dbsprite -52, -76, $02, 0 | OAM_YFLIP
	dbsprite -36, -76, $02, 0 | OAM_YFLIP
	dbsprite -60, -76, $01, 0
	dbsprite -60, -68, $01, 0
	dbsprite -60, -60, $01, 0
	dbsprite -60, -52, $01, 0
	dbsprite -60, -44, $01, 0
	dbsprite -60, -36, $01, 0

.frame_5
	db 12 ; size
	dbsprite -36, -68, $01, 0 | OAM_XFLIP
	dbsprite -44, -76, $02, 0 | OAM_YFLIP
	dbsprite -52, -76, $02, 0 | OAM_YFLIP
	dbsprite -36, -76, $02, 0 | OAM_YFLIP
	dbsprite -60, -76, $01, 0
	dbsprite -60, -68, $01, 0
	dbsprite -60, -60, $01, 0
	dbsprite -60, -52, $01, 0
	dbsprite -60, -44, $01, 0
	dbsprite -60, -36, $01, 0
	dbsprite -60, -28, $01, 0
	dbsprite -60, -20, $01, 0

.frame_6
	db 14 ; size
	dbsprite -36, -68, $01, 0 | OAM_XFLIP
	dbsprite -44, -76, $02, 0 | OAM_YFLIP
	dbsprite -52, -76, $02, 0 | OAM_YFLIP
	dbsprite -36, -76, $02, 0 | OAM_YFLIP
	dbsprite -60, -76, $01, 0
	dbsprite -60, -68, $01, 0
	dbsprite -60, -60, $01, 0
	dbsprite -60, -52, $01, 0
	dbsprite -60, -44, $01, 0
	dbsprite -60, -36, $01, 0
	dbsprite -60, -28, $01, 0
	dbsprite -60, -20, $01, 0
	dbsprite -60, -12, $01, 0
	dbsprite -60,  -4, $02, 0

.frame_7
	db 16 ; size
	dbsprite -36, -68, $01, 0 | OAM_XFLIP
	dbsprite -44, -76, $02, 0 | OAM_YFLIP
	dbsprite -52, -76, $02, 0 | OAM_YFLIP
	dbsprite -36, -76, $02, 0 | OAM_YFLIP
	dbsprite -60, -76, $01, 0
	dbsprite -60, -68, $01, 0
	dbsprite -60, -60, $01, 0
	dbsprite -60, -52, $01, 0
	dbsprite -60, -44, $01, 0
	dbsprite -60, -36, $01, 0
	dbsprite -60, -28, $01, 0
	dbsprite -60, -20, $01, 0
	dbsprite -60, -12, $01, 0
	dbsprite -60,  -4, $02, 0
	dbsprite -52,  -4, $02, 0
	dbsprite -44,  -4, $02, 0

.frame_8
	db 18 ; size
	dbsprite -36, -68, $01, 0 | OAM_XFLIP
	dbsprite -44, -76, $02, 0 | OAM_YFLIP
	dbsprite -52, -76, $02, 0 | OAM_YFLIP
	dbsprite -36, -76, $02, 0 | OAM_YFLIP
	dbsprite -60, -76, $01, 0
	dbsprite -60, -68, $01, 0
	dbsprite -60, -60, $01, 0
	dbsprite -60, -52, $01, 0
	dbsprite -60, -44, $01, 0
	dbsprite -60, -36, $01, 0
	dbsprite -60, -28, $01, 0
	dbsprite -60, -20, $01, 0
	dbsprite -60, -12, $01, 0
	dbsprite -60,  -4, $02, 0
	dbsprite -52,  -4, $02, 0
	dbsprite -44,  -4, $02, 0
	dbsprite -36,  -4, $02, 0
	dbsprite -28,  -4, $02, 0

.frame_9
	db 20 ; size
	dbsprite -36, -68, $01, 0 | OAM_XFLIP
	dbsprite -44, -76, $02, 0 | OAM_YFLIP
	dbsprite -52, -76, $02, 0 | OAM_YFLIP
	dbsprite -36, -76, $02, 0 | OAM_YFLIP
	dbsprite -60, -76, $01, 0
	dbsprite -60, -68, $01, 0
	dbsprite -60, -60, $01, 0
	dbsprite -60, -52, $01, 0
	dbsprite -60, -44, $01, 0
	dbsprite -60, -36, $01, 0
	dbsprite -60, -28, $01, 0
	dbsprite -60, -20, $01, 0
	dbsprite -60, -12, $01, 0
	dbsprite -60,  -4, $02, 0
	dbsprite -52,  -4, $02, 0
	dbsprite -44,  -4, $02, 0
	dbsprite -36,  -4, $02, 0
	dbsprite -28,  -4, $02, 0
	dbsprite -20,  -4, $02, 0
	dbsprite -12,  -4, $02, 0

.frame_10
	db 22 ; size
	dbsprite -36, -68, $01, 0 | OAM_XFLIP
	dbsprite -44, -76, $02, 0 | OAM_YFLIP
	dbsprite -52, -76, $02, 0 | OAM_YFLIP
	dbsprite -36, -76, $02, 0 | OAM_YFLIP
	dbsprite -60, -76, $01, 0
	dbsprite -60, -68, $01, 0
	dbsprite -60, -60, $01, 0
	dbsprite -60, -52, $01, 0
	dbsprite -60, -44, $01, 0
	dbsprite -60, -36, $01, 0
	dbsprite -60, -28, $01, 0
	dbsprite -60, -20, $01, 0
	dbsprite -60, -12, $01, 0
	dbsprite -60,  -4, $02, 0
	dbsprite -52,  -4, $02, 0
	dbsprite -44,  -4, $02, 0
	dbsprite -36,  -4, $02, 0
	dbsprite -28,  -4, $02, 0
	dbsprite -20,  -4, $02, 0
	dbsprite -12,  -4, $02, 0
	dbsprite  -4,  -4, $02, 0
	dbsprite   4,  -4, $02, 0

.frame_11
	db 24 ; size
	dbsprite -36, -68, $01, 0 | OAM_XFLIP
	dbsprite -44, -76, $02, 0 | OAM_YFLIP
	dbsprite -52, -76, $02, 0 | OAM_YFLIP
	dbsprite -36, -76, $02, 0 | OAM_YFLIP
	dbsprite -60, -76, $01, 0
	dbsprite -60, -68, $01, 0
	dbsprite -60, -60, $01, 0
	dbsprite -60, -52, $01, 0
	dbsprite -60, -44, $01, 0
	dbsprite -60, -36, $01, 0
	dbsprite -60, -28, $01, 0
	dbsprite -60, -20, $01, 0
	dbsprite -60, -12, $01, 0
	dbsprite -60,  -4, $02, 0
	dbsprite -52,  -4, $02, 0
	dbsprite -44,  -4, $02, 0
	dbsprite -36,  -4, $02, 0
	dbsprite -28,  -4, $02, 0
	dbsprite -20,  -4, $02, 0
	dbsprite -12,  -4, $02, 0
	dbsprite  -4,  -4, $02, 0
	dbsprite   4,  -4, $02, 0
	dbsprite  12,  -4, $01, 0
	dbsprite  12,   4, $01, 0

.frame_12
	db 26 ; size
	dbsprite -36, -68, $01, 0 | OAM_XFLIP
	dbsprite -44, -76, $02, 0 | OAM_YFLIP
	dbsprite -52, -76, $02, 0 | OAM_YFLIP
	dbsprite -36, -76, $02, 0 | OAM_YFLIP
	dbsprite -60, -76, $01, 0
	dbsprite -60, -68, $01, 0
	dbsprite -60, -60, $01, 0
	dbsprite -60, -52, $01, 0
	dbsprite -60, -44, $01, 0
	dbsprite -60, -36, $01, 0
	dbsprite -60, -28, $01, 0
	dbsprite -60, -20, $01, 0
	dbsprite -60, -12, $01, 0
	dbsprite -60,  -4, $02, 0
	dbsprite -52,  -4, $02, 0
	dbsprite -44,  -4, $02, 0
	dbsprite -36,  -4, $02, 0
	dbsprite -28,  -4, $02, 0
	dbsprite -20,  -4, $02, 0
	dbsprite -12,  -4, $02, 0
	dbsprite  -4,  -4, $02, 0
	dbsprite   4,  -4, $02, 0
	dbsprite  12,  -4, $01, 0
	dbsprite  12,   4, $01, 0
	dbsprite  12,  12, $01, 0
	dbsprite  12,  20, $01, 0

.frame_13
	db 28 ; size
	dbsprite -36, -68, $01, 0 | OAM_XFLIP
	dbsprite -44, -76, $02, 0 | OAM_YFLIP
	dbsprite -52, -76, $02, 0 | OAM_YFLIP
	dbsprite -36, -76, $02, 0 | OAM_YFLIP
	dbsprite -60, -76, $01, 0
	dbsprite -60, -68, $01, 0
	dbsprite -60, -60, $01, 0
	dbsprite -60, -52, $01, 0
	dbsprite -60, -44, $01, 0
	dbsprite -60, -36, $01, 0
	dbsprite -60, -28, $01, 0
	dbsprite -60, -20, $01, 0
	dbsprite -60, -12, $01, 0
	dbsprite -60,  -4, $02, 0
	dbsprite -52,  -4, $02, 0
	dbsprite -44,  -4, $02, 0
	dbsprite -36,  -4, $02, 0
	dbsprite -28,  -4, $02, 0
	dbsprite -20,  -4, $02, 0
	dbsprite -12,  -4, $02, 0
	dbsprite  -4,  -4, $02, 0
	dbsprite   4,  -4, $02, 0
	dbsprite  12,  -4, $01, 0
	dbsprite  12,   4, $01, 0
	dbsprite  12,  12, $01, 0
	dbsprite  12,  20, $01, 0
	dbsprite  12,  28, $01, 0
	dbsprite  12,  36, $01, 0

.frame_14
	db 30 ; size
	dbsprite -36, -68, $01, 0 | OAM_XFLIP
	dbsprite -44, -76, $02, 0 | OAM_YFLIP
	dbsprite -52, -76, $02, 0 | OAM_YFLIP
	dbsprite -36, -76, $02, 0 | OAM_YFLIP
	dbsprite -60, -76, $01, 0
	dbsprite -60, -68, $01, 0
	dbsprite -60, -60, $01, 0
	dbsprite -60, -52, $01, 0
	dbsprite -60, -44, $01, 0
	dbsprite -60, -36, $01, 0
	dbsprite -60, -28, $01, 0
	dbsprite -60, -20, $01, 0
	dbsprite -60, -12, $01, 0
	dbsprite -60,  -4, $02, 0
	dbsprite -52,  -4, $02, 0
	dbsprite -44,  -4, $02, 0
	dbsprite -36,  -4, $02, 0
	dbsprite -28,  -4, $02, 0
	dbsprite -20,  -4, $02, 0
	dbsprite -12,  -4, $02, 0
	dbsprite  -4,  -4, $02, 0
	dbsprite   4,  -4, $02, 0
	dbsprite  12,  -4, $01, 0
	dbsprite  12,   4, $01, 0
	dbsprite  12,  12, $01, 0
	dbsprite  12,  20, $01, 0
	dbsprite  12,  28, $01, 0
	dbsprite  12,  36, $01, 0
	dbsprite  12,  44, $01, 0
	dbsprite  12,  52, $01, 0

.frame_15
	db 32 ; size
	dbsprite -36, -68, $01, 0 | OAM_XFLIP
	dbsprite -44, -76, $02, 0 | OAM_YFLIP
	dbsprite -52, -76, $02, 0 | OAM_YFLIP
	dbsprite -36, -76, $02, 0 | OAM_YFLIP
	dbsprite -60, -76, $01, 0
	dbsprite -60, -68, $01, 0
	dbsprite -60, -60, $01, 0
	dbsprite -60, -52, $01, 0
	dbsprite -60, -44, $01, 0
	dbsprite -60, -36, $01, 0
	dbsprite -60, -28, $01, 0
	dbsprite -60, -20, $01, 0
	dbsprite -60, -12, $01, 0
	dbsprite -60,  -4, $02, 0
	dbsprite -52,  -4, $02, 0
	dbsprite -44,  -4, $02, 0
	dbsprite -36,  -4, $02, 0
	dbsprite -28,  -4, $02, 0
	dbsprite -20,  -4, $02, 0
	dbsprite -12,  -4, $02, 0
	dbsprite  -4,  -4, $02, 0
	dbsprite   4,  -4, $02, 0
	dbsprite  12,  -4, $01, 0
	dbsprite  12,   4, $01, 0
	dbsprite  12,  12, $01, 0
	dbsprite  12,  20, $01, 0
	dbsprite  12,  28, $01, 0
	dbsprite  12,  36, $01, 0
	dbsprite  12,  44, $01, 0
	dbsprite  12,  52, $01, 0
	dbsprite  12,  60, $01, 0
	dbsprite  12,  68, $02, 0 | OAM_YFLIP

.frame_16
	db 34 ; size
	dbsprite -36, -68, $01, 0 | OAM_XFLIP
	dbsprite -44, -76, $02, 0 | OAM_YFLIP
	dbsprite -52, -76, $02, 0 | OAM_YFLIP
	dbsprite -36, -76, $02, 0 | OAM_YFLIP
	dbsprite -60, -76, $01, 0
	dbsprite -60, -68, $01, 0
	dbsprite -60, -60, $01, 0
	dbsprite -60, -52, $01, 0
	dbsprite -60, -44, $01, 0
	dbsprite -60, -36, $01, 0
	dbsprite -60, -28, $01, 0
	dbsprite -60, -20, $01, 0
	dbsprite -60, -12, $01, 0
	dbsprite -60,  -4, $02, 0
	dbsprite -52,  -4, $02, 0
	dbsprite -44,  -4, $02, 0
	dbsprite -36,  -4, $02, 0
	dbsprite -28,  -4, $02, 0
	dbsprite -20,  -4, $02, 0
	dbsprite -12,  -4, $02, 0
	dbsprite  -4,  -4, $02, 0
	dbsprite   4,  -4, $02, 0
	dbsprite  12,  -4, $01, 0
	dbsprite  12,   4, $01, 0
	dbsprite  12,  12, $01, 0
	dbsprite  12,  20, $01, 0
	dbsprite  12,  28, $01, 0
	dbsprite  12,  36, $01, 0
	dbsprite  12,  44, $01, 0
	dbsprite  12,  52, $01, 0
	dbsprite  12,  60, $01, 0
	dbsprite  -4,  68, $02, 0 | OAM_YFLIP
	dbsprite   4,  68, $02, 0 | OAM_YFLIP
	dbsprite  12,  68, $02, 0 | OAM_YFLIP

.frame_17
	db 36 ; size
	dbsprite -36, -68, $01, 0 | OAM_XFLIP
	dbsprite -44, -76, $02, 0 | OAM_YFLIP
	dbsprite -52, -76, $02, 0 | OAM_YFLIP
	dbsprite -36, -76, $02, 0 | OAM_YFLIP
	dbsprite -60, -76, $01, 0
	dbsprite -60, -68, $01, 0
	dbsprite -60, -60, $01, 0
	dbsprite -60, -52, $01, 0
	dbsprite -60, -44, $01, 0
	dbsprite -60, -36, $01, 0
	dbsprite -60, -28, $01, 0
	dbsprite -60, -20, $01, 0
	dbsprite -60, -12, $01, 0
	dbsprite -60,  -4, $02, 0
	dbsprite -52,  -4, $02, 0
	dbsprite -44,  -4, $02, 0
	dbsprite -36,  -4, $02, 0
	dbsprite -28,  -4, $02, 0
	dbsprite -20,  -4, $02, 0
	dbsprite -12,  -4, $02, 0
	dbsprite  -4,  -4, $02, 0
	dbsprite   4,  -4, $02, 0
	dbsprite  12,  -4, $01, 0
	dbsprite  12,   4, $01, 0
	dbsprite  12,  12, $01, 0
	dbsprite  12,  20, $01, 0
	dbsprite  12,  28, $01, 0
	dbsprite  12,  36, $01, 0
	dbsprite  12,  44, $01, 0
	dbsprite  12,  52, $01, 0
	dbsprite  12,  60, $01, 0
	dbsprite  -4,  68, $02, 0 | OAM_YFLIP
	dbsprite   4,  68, $02, 0 | OAM_YFLIP
	dbsprite  12,  68, $02, 0 | OAM_YFLIP
	dbsprite -12,  60, $01, 0 | OAM_XFLIP
	dbsprite -12,  68, $01, 0 | OAM_XFLIP

.frame_18
	db 12 ; size
	dbsprite -16, -14, $03, 1
	dbsprite -16,  -6, $04, 1
	dbsprite  -8, -14, $05, 1
	dbsprite -16,   6, $03, 1 | OAM_XFLIP
	dbsprite -16,  -2, $04, 1 | OAM_XFLIP
	dbsprite  -8,   6, $05, 1 | OAM_XFLIP
	dbsprite -24, -14, $03, 1 | OAM_YFLIP
	dbsprite -24,  -6, $04, 1 | OAM_YFLIP
	dbsprite -32, -14, $05, 1 | OAM_YFLIP
	dbsprite -24,   6, $03, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite -24,  -2, $04, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite -32,   6, $05, 1 | OAM_XFLIP | OAM_YFLIP

OAMDataA8::
	dw .frame_0

.frame_0
	db 9 ; size
	dbsprite  -8,  -8, $00, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite -16,  -8, $02, 0 | OAM_XFLIP
	dbsprite -24,  -8, $00, 0 | OAM_XFLIP
	dbsprite -16, -16, $03, 0
	dbsprite -16, -24, $02, 0
	dbsprite  -8, -16, $01, 0 | OAM_YFLIP
	dbsprite  -8, -24, $00, 0 | OAM_YFLIP
	dbsprite -24, -16, $01, 0
	dbsprite -24, -24, $00, 0

OAMDataA9::
	dw .frame_0
	dw .frame_1
	dw .frame_2
	dw .frame_3

.frame_0
	db 8 ; size
	dbsprite   0, -22, $07, 0
	dbsprite   0, -30, $06, 0
	dbsprite   0, -38, $05, 0
	dbsprite  -8, -14, $04, 0
	dbsprite  -8, -22, $03, 0
	dbsprite  -8, -30, $02, 0
	dbsprite  -8, -38, $01, 0
	dbsprite -16, -30, $00, 0

.frame_1
	db 8 ; size
	dbsprite -20, -25, $00, 0
	dbsprite  -4, -17, $07, 0
	dbsprite  -4, -25, $06, 0
	dbsprite  -4, -33, $05, 0
	dbsprite -12,  -9, $04, 0
	dbsprite -12, -17, $03, 0
	dbsprite -12, -25, $02, 0
	dbsprite -12, -33, $01, 0

.frame_2
	db 6 ; size
	dbsprite -17, -12, $0a, 0
	dbsprite -17, -20, $09, 0
	dbsprite -17, -28, $08, 0
	dbsprite  -9, -12, $0d, 0
	dbsprite  -9, -20, $0c, 0
	dbsprite  -9, -28, $0b, 0

.frame_3
	db 5 ; size
	dbsprite -14,  -7, $12, 0
	dbsprite -14, -15, $11, 0
	dbsprite -14, -23, $10, 0
	dbsprite -22, -15, $0f, 0
	dbsprite -22, -23, $0e, 0

OAMDataAA::
	dw .frame_0
	dw .frame_1

.frame_0
	db 2 ; size
	dbsprite   0,   7, $00, 0 | OAM_XFLIP
	dbsprite   0,  -1, $00, 0

.frame_1
	db 2 ; size
	dbsprite   0,   9, $00, 0 | OAM_XFLIP
	dbsprite   0,   1, $00, 0

OAMDataAB::
	dw .frame_0
	dw .frame_1
	dw .frame_2
	dw .frame_3
	dw .frame_4
	dw .frame_5
	dw .frame_6
	dw .frame_7
	dw .frame_8
	dw .frame_9
	dw .frame_10
	dw .frame_11
	dw .frame_12
	dw .frame_13
	dw .frame_14
	dw .frame_15
	dw .frame_16
	dw .frame_17
	dw .frame_18
	dw .frame_19
	dw .frame_20
	dw .frame_21
	dw .frame_22
	dw .frame_23

.frame_0
	db 1 ; size
	dbsprite -48, -28, $00, 1

.frame_1
	db 2 ; size
	dbsprite -48, -20, $00, 1
	dbsprite -48, -28, $00, 1

.frame_2
	db 3 ; size
	dbsprite -48, -12, $00, 1
	dbsprite -48, -20, $00, 1
	dbsprite -48, -28, $00, 1

.frame_3
	db 4 ; size
	dbsprite -48,  -4, $00, 1
	dbsprite -48, -12, $00, 1
	dbsprite -48, -20, $00, 1
	dbsprite -48, -28, $00, 1

.frame_4
	db 5 ; size
	dbsprite -40,  -4, $00, 1
	dbsprite -48,  -4, $00, 1
	dbsprite -48, -12, $00, 1
	dbsprite -48, -20, $00, 1
	dbsprite -48, -28, $00, 1

.frame_5
	db 6 ; size
	dbsprite -32,  -4, $00, 1
	dbsprite -40,  -4, $00, 1
	dbsprite -48,  -4, $00, 1
	dbsprite -48, -12, $00, 1
	dbsprite -48, -20, $00, 1
	dbsprite -48, -28, $00, 1

.frame_6
	db 7 ; size
	dbsprite -24,  -4, $00, 1
	dbsprite -32,  -4, $00, 1
	dbsprite -40,  -4, $00, 1
	dbsprite -48,  -4, $00, 1
	dbsprite -48, -12, $00, 1
	dbsprite -48, -20, $00, 1
	dbsprite -48, -28, $00, 1

.frame_7
	db 8 ; size
	dbsprite -16,  -4, $00, 1
	dbsprite -24,  -4, $00, 1
	dbsprite -32,  -4, $00, 1
	dbsprite -40,  -4, $00, 1
	dbsprite -48,  -4, $00, 1
	dbsprite -48, -12, $00, 1
	dbsprite -48, -20, $00, 1
	dbsprite -48, -28, $00, 1

.frame_8
	db 10 ; size
	dbsprite  -8,  -4, $00, 1
	dbsprite -16,  -4, $00, 1
	dbsprite -24,  -4, $00, 1
	dbsprite -32,  -4, $00, 1
	dbsprite -40,  -4, $00, 1
	dbsprite -48,  -4, $00, 1
	dbsprite -48, -12, $00, 1
	dbsprite -48, -12, $00, 1
	dbsprite -48, -20, $00, 1
	dbsprite -48, -28, $00, 1

.frame_9
	db 10 ; size
	dbsprite  -8,   4, $00, 1
	dbsprite  -8,  -4, $00, 1
	dbsprite -16,  -4, $00, 1
	dbsprite -24,  -4, $00, 1
	dbsprite -32,  -4, $00, 1
	dbsprite -40,  -4, $00, 1
	dbsprite -48,  -4, $00, 1
	dbsprite -48, -12, $00, 1
	dbsprite -48, -20, $00, 1
	dbsprite -48, -28, $00, 1

.frame_10
	db 11 ; size
	dbsprite  -8,  12, $00, 1
	dbsprite  -8,   4, $00, 1
	dbsprite  -8,  -4, $00, 1
	dbsprite -16,  -4, $00, 1
	dbsprite -24,  -4, $00, 1
	dbsprite -32,  -4, $00, 1
	dbsprite -40,  -4, $00, 1
	dbsprite -48,  -4, $00, 1
	dbsprite -48, -12, $00, 1
	dbsprite -48, -20, $00, 1
	dbsprite -48, -28, $00, 1

.frame_11
	db 12 ; size
	dbsprite  -8,  20, $00, 1
	dbsprite  -8,  12, $00, 1
	dbsprite  -8,   4, $00, 1
	dbsprite  -8,  -4, $00, 1
	dbsprite -16,  -4, $00, 1
	dbsprite -24,  -4, $00, 1
	dbsprite -32,  -4, $00, 1
	dbsprite -40,  -4, $00, 1
	dbsprite -48,  -4, $00, 1
	dbsprite -48, -12, $00, 1
	dbsprite -48, -20, $00, 1
	dbsprite -48, -28, $00, 1

.frame_12
	db 1 ; size
	dbsprite  -8,  20, $00, 1

.frame_13
	db 2 ; size
	dbsprite  -8,  20, $00, 1
	dbsprite  -8,  12, $00, 1

.frame_14
	db 3 ; size
	dbsprite  -8,  20, $00, 1
	dbsprite  -8,  12, $00, 1
	dbsprite  -8,   4, $00, 1

.frame_15
	db 4 ; size
	dbsprite  -8,  -4, $00, 1
	dbsprite  -8,   4, $00, 1
	dbsprite  -8,  12, $00, 1
	dbsprite  -8,  20, $00, 1

.frame_16
	db 5 ; size
	dbsprite  -8,  20, $00, 1
	dbsprite  -8,  12, $00, 1
	dbsprite  -8,   4, $00, 1
	dbsprite  -8,  -4, $00, 1
	dbsprite -16,  -4, $00, 1

.frame_17
	db 6 ; size
	dbsprite  -8,  20, $00, 1
	dbsprite  -8,  12, $00, 1
	dbsprite  -8,   4, $00, 1
	dbsprite  -8,  -4, $00, 1
	dbsprite -16,  -4, $00, 1
	dbsprite -24,  -4, $00, 1

.frame_18
	db 7 ; size
	dbsprite  -8,  20, $00, 1
	dbsprite  -8,  12, $00, 1
	dbsprite  -8,   4, $00, 1
	dbsprite  -8,  -4, $00, 1
	dbsprite -16,  -4, $00, 1
	dbsprite -24,  -4, $00, 1
	dbsprite -32,  -4, $00, 1

.frame_19
	db 8 ; size
	dbsprite  -8,  20, $00, 1
	dbsprite  -8,  12, $00, 1
	dbsprite  -8,   4, $00, 1
	dbsprite  -8,  -4, $00, 1
	dbsprite -16,  -4, $00, 1
	dbsprite -24,  -4, $00, 1
	dbsprite -32,  -4, $00, 1
	dbsprite -40,  -4, $00, 1

.frame_20
	db 9 ; size
	dbsprite  -8,  20, $00, 1
	dbsprite  -8,  12, $00, 1
	dbsprite  -8,   4, $00, 1
	dbsprite  -8,  -4, $00, 1
	dbsprite -16,  -4, $00, 1
	dbsprite -24,  -4, $00, 1
	dbsprite -32,  -4, $00, 1
	dbsprite -40,  -4, $00, 1
	dbsprite -48,  -4, $00, 1

.frame_21
	db 10 ; size
	dbsprite  -8,  20, $00, 1
	dbsprite  -8,  12, $00, 1
	dbsprite  -8,   4, $00, 1
	dbsprite  -8,  -4, $00, 1
	dbsprite -16,  -4, $00, 1
	dbsprite -24,  -4, $00, 1
	dbsprite -32,  -4, $00, 1
	dbsprite -40,  -4, $00, 1
	dbsprite -48,  -4, $00, 1
	dbsprite -48, -12, $00, 1

.frame_22
	db 11 ; size
	dbsprite  -8,  20, $00, 1
	dbsprite  -8,  12, $00, 1
	dbsprite  -8,   4, $00, 1
	dbsprite  -8,  -4, $00, 1
	dbsprite -16,  -4, $00, 1
	dbsprite -24,  -4, $00, 1
	dbsprite -32,  -4, $00, 1
	dbsprite -40,  -4, $00, 1
	dbsprite -48,  -4, $00, 1
	dbsprite -48, -12, $00, 1
	dbsprite -48, -20, $00, 1

.frame_23
	db 12 ; size
	dbsprite -32,  -2, $02, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite -32,   6, $01, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite -40,   6, $03, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite -16,   6, $03, 0 | OAM_XFLIP
	dbsprite -24,  -2, $02, 0 | OAM_XFLIP
	dbsprite -24,   6, $01, 0 | OAM_XFLIP
	dbsprite -32,  -6, $02, 0 | OAM_YFLIP
	dbsprite -32, -14, $01, 0 | OAM_YFLIP
	dbsprite -40, -14, $03, 0 | OAM_YFLIP
	dbsprite -16, -14, $03, 0
	dbsprite -24,  -6, $02, 0
	dbsprite -24, -14, $01, 0

OAMDataAC::
	dw .frame_0
	dw .frame_1
	dw .frame_2
	dw .frame_3

.frame_0
	db 8 ; size
	dbsprite  -5,  -5, $07, 2
	dbsprite  -5, -13, $06, 2
	dbsprite  -5, -21, $05, 2
	dbsprite -13,  -5, $04, 2
	dbsprite -13, -13, $03, 2
	dbsprite -13, -21, $02, 2
	dbsprite -21,  -5, $01, 2
	dbsprite -21, -13, $00, 2

.frame_1
	db 7 ; size
	dbsprite  -7,  13, $0d, 2
	dbsprite  -5,   5, $0c, 2
	dbsprite  -5,  -3, $0b, 2
	dbsprite -13,   5, $0a, 2
	dbsprite -13,  -3, $09, 2
	dbsprite -21,   4, $00, 2 | OAM_XFLIP
	dbsprite -21,  -4, $08, 2

.frame_2
	db 6 ; size
	dbsprite  14,  -6, $13, 2
	dbsprite   6,  -6, $12, 2
	dbsprite   6, -14, $11, 2
	dbsprite  -2,  -6, $10, 2
	dbsprite  -2, -14, $0f, 2
	dbsprite  -2, -22, $0e, 2

.frame_3
	db 5 ; size
	dbsprite  14,  -2, $17, 2
	dbsprite   6,   5, $11, 2 | OAM_XFLIP
	dbsprite   6,  -3, $16, 2
	dbsprite  -2,   7, $15, 2
	dbsprite  -2,  -1, $14, 2

OAMDataAD::
	dw .frame_0
	dw .frame_1
	dw .frame_2
	dw .frame_3
	dw .frame_4
	dw .frame_5
	dw .frame_6
	dw .frame_7
	dw .frame_8
	dw .frame_9
	dw .frame_10
	dw .frame_11
	dw .frame_12
	dw .frame_13
	dw .frame_14
	dw .frame_15
	dw .frame_16
	dw .frame_17
	dw .frame_18
	dw .frame_19
	dw .frame_20
	dw .frame_21
	dw .frame_22
	dw .frame_23
	dw .frame_24
	dw .frame_25
	dw .frame_26
	dw .frame_27
	dw .frame_28
	dw .frame_29
	dw .frame_30
	dw .frame_31
	dw .frame_32
	dw .frame_33
	dw .frame_34
	dw .frame_35
	dw .frame_36
	dw .frame_37
	dw .frame_38

.frame_0
	db 9 ; size
	dbsprite   4,   4, $28, 7
	dbsprite   4,  -4, $27, 7
	dbsprite   4, -12, $26, 7
	dbsprite  -4,   4, $18, 7
	dbsprite  -4,  -4, $17, 7
	dbsprite  -4, -12, $16, 7
	dbsprite -12,   4, $08, 7
	dbsprite -12,  -4, $07, 7
	dbsprite -12, -12, $06, 7

.frame_1
	db 9 ; size
	dbsprite   4,   4, $b2, 2
	dbsprite   4,  -4, $b1, 2
	dbsprite   4, -12, $b0, 2
	dbsprite  -4,   4, $a2, 2
	dbsprite  -4,  -4, $a1, 2
	dbsprite  -4, -12, $a0, 2
	dbsprite -12,   4, $92, 2
	dbsprite -12,  -4, $91, 2
	dbsprite -12, -12, $90, 2

.frame_2
	db 9 ; size
	dbsprite   4,   4, $55, 3
	dbsprite   4,  -4, $54, 3
	dbsprite   4, -12, $53, 3
	dbsprite  -4,   4, $45, 3
	dbsprite  -4,  -4, $44, 3
	dbsprite  -4, -12, $43, 3
	dbsprite -12,   4, $35, 3
	dbsprite -12,  -4, $34, 3
	dbsprite -12, -12, $33, 3

.frame_3
	db 9 ; size
	dbsprite   4,   4, $58, 4
	dbsprite   4,  -4, $57, 4
	dbsprite   4, -12, $56, 4
	dbsprite  -4,   4, $48, 4
	dbsprite  -4,  -4, $47, 4
	dbsprite  -4, -12, $46, 4
	dbsprite -12,   4, $38, 4
	dbsprite -12,  -4, $37, 4
	dbsprite -12, -12, $36, 4

.frame_4
	db 9 ; size
	dbsprite   4,   4, $8b, 5
	dbsprite   4,  -4, $8a, 5
	dbsprite   4, -12, $89, 5
	dbsprite  -4,   4, $7b, 5
	dbsprite  -4,  -4, $7a, 5
	dbsprite  -4, -12, $79, 5
	dbsprite -12,   4, $6b, 5
	dbsprite -12,  -4, $6a, 5
	dbsprite -12, -12, $69, 5

.frame_5
	db 9 ; size
	dbsprite   4,   4, $e5, 6
	dbsprite   4,  -4, $e4, 6
	dbsprite   4, -12, $e3, 6
	dbsprite  -4,   4, $d5, 6
	dbsprite  -4,  -4, $d4, 6
	dbsprite  -4, -12, $d3, 6
	dbsprite -12,   4, $c5, 6
	dbsprite -12,  -4, $c4, 6
	dbsprite -12, -12, $c3, 6

.frame_6
	db 9 ; size
	dbsprite   4,   4, $be, 3
	dbsprite   4,  -4, $bd, 3
	dbsprite   4, -12, $bc, 3
	dbsprite  -4,   4, $ae, 3
	dbsprite  -4,  -4, $ad, 3
	dbsprite  -4, -12, $ac, 3
	dbsprite -12,   4, $9e, 3
	dbsprite -12,  -4, $9d, 3
	dbsprite -12, -12, $9c, 3

.frame_7
	db 9 ; size
	dbsprite   4,   4, $00, 3
	dbsprite   4,  -4, $00, 3
	dbsprite   4, -12, $00, 3
	dbsprite  -4,   4, $00, 3
	dbsprite  -4,  -4, $00, 3
	dbsprite  -4, -12, $00, 3
	dbsprite -12,   4, $00, 3
	dbsprite -12,  -4, $00, 3
	dbsprite -12, -12, $00, 3

.frame_8
	db 9 ; size
	dbsprite   4,   4, $82, 2
	dbsprite   4,  -4, $81, 2
	dbsprite   4, -12, $80, 2
	dbsprite  -4,   4, $72, 2
	dbsprite  -4,  -4, $71, 2
	dbsprite  -4, -12, $70, 2
	dbsprite -12,   4, $62, 2
	dbsprite -12,  -4, $61, 2
	dbsprite -12, -12, $60, 2

.frame_9
	db 9 ; size
	dbsprite   4,   4, $bb, 5
	dbsprite   4,  -4, $ba, 5
	dbsprite   4, -12, $b9, 5
	dbsprite  -4,   4, $ab, 5
	dbsprite  -4,  -4, $aa, 5
	dbsprite  -4, -12, $a9, 5
	dbsprite -12,   4, $9b, 5
	dbsprite -12,  -4, $9a, 5
	dbsprite -12, -12, $99, 5

.frame_10
	db 9 ; size
	dbsprite   4,   4, $b5, 3
	dbsprite   4,  -4, $b4, 3
	dbsprite   4, -12, $b3, 3
	dbsprite  -4,   4, $a5, 3
	dbsprite  -4,  -4, $a4, 3
	dbsprite  -4, -12, $a3, 3
	dbsprite -12,   4, $95, 3
	dbsprite -12,  -4, $94, 3
	dbsprite -12, -12, $93, 3

.frame_11
	db 9 ; size
	dbsprite   4,   4, $88, 4
	dbsprite   4,  -4, $87, 4
	dbsprite   4, -12, $86, 4
	dbsprite  -4,   4, $78, 4
	dbsprite  -4,  -4, $77, 4
	dbsprite  -4, -12, $76, 4
	dbsprite -12,   4, $68, 4
	dbsprite -12,  -4, $67, 4
	dbsprite -12, -12, $66, 4

.frame_12
	db 9 ; size
	dbsprite   4,   4, $8e, 3
	dbsprite   4,  -4, $8d, 3
	dbsprite   4, -12, $8c, 3
	dbsprite  -4,   4, $7e, 3
	dbsprite  -4,  -4, $7d, 3
	dbsprite  -4, -12, $7c, 3
	dbsprite -12,   4, $6e, 3
	dbsprite -12,  -4, $6d, 3
	dbsprite -12, -12, $6c, 3

.frame_13
	db 9 ; size
	dbsprite   4,   4, $e8, 6
	dbsprite   4,  -4, $e7, 6
	dbsprite   4, -12, $e6, 6
	dbsprite  -4,   4, $d8, 6
	dbsprite  -4,  -4, $d7, 6
	dbsprite  -4, -12, $d6, 6
	dbsprite -12,   4, $c8, 6
	dbsprite -12,  -4, $c7, 6
	dbsprite -12, -12, $c6, 6

.frame_14
	db 9 ; size
	dbsprite   4,   4, $2b, 7
	dbsprite   4,  -4, $2a, 7
	dbsprite   4, -12, $29, 7
	dbsprite  -4,   4, $1b, 7
	dbsprite  -4,  -4, $1a, 7
	dbsprite  -4, -12, $19, 7
	dbsprite -12,   4, $0b, 7
	dbsprite -12,  -4, $0a, 7
	dbsprite -12, -12, $09, 7

.frame_15
	db 9 ; size
	dbsprite   4,   4, $eb, 7
	dbsprite   4,  -4, $ea, 7
	dbsprite   4, -12, $e9, 7
	dbsprite  -4,   4, $db, 7
	dbsprite  -4,  -4, $da, 7
	dbsprite  -4, -12, $d9, 7
	dbsprite -12,   4, $cb, 7
	dbsprite -12,  -4, $ca, 7
	dbsprite -12, -12, $c9, 7

.frame_16
	db 9 ; size
	dbsprite   4,   4, $85, 3
	dbsprite   4,  -4, $84, 3
	dbsprite   4, -12, $83, 3
	dbsprite  -4,   4, $75, 3
	dbsprite  -4,  -4, $74, 3
	dbsprite  -4, -12, $73, 3
	dbsprite -12,   4, $65, 3
	dbsprite -12,  -4, $64, 3
	dbsprite -12, -12, $63, 3

.frame_17
	db 9 ; size
	dbsprite   4,   4, $b8, 4
	dbsprite   4,  -4, $b7, 4
	dbsprite   4, -12, $b6, 4
	dbsprite  -4,   4, $a8, 4
	dbsprite  -4,  -4, $a7, 4
	dbsprite  -4, -12, $a6, 4
	dbsprite -12,   4, $98, 4
	dbsprite -12,  -4, $97, 4
	dbsprite -12, -12, $96, 4

.frame_18
	db 9 ; size
	dbsprite   4,   4, $52, 2
	dbsprite   4,  -4, $51, 2
	dbsprite   4, -12, $50, 2
	dbsprite  -4,   4, $42, 2
	dbsprite  -4,  -4, $41, 2
	dbsprite  -4, -12, $40, 2
	dbsprite -12,   4, $32, 2
	dbsprite -12,  -4, $31, 2
	dbsprite -12, -12, $30, 2

.frame_19
	db 9 ; size
	dbsprite   4,   4, $2e, 7
	dbsprite   4,  -4, $2d, 7
	dbsprite   4, -12, $2c, 7
	dbsprite  -4,   4, $1e, 7
	dbsprite  -4,  -4, $1d, 7
	dbsprite  -4, -12, $1c, 7
	dbsprite -12,   4, $0e, 7
	dbsprite -12,  -4, $0d, 7
	dbsprite -12, -12, $0c, 7

.frame_20
	db 9 ; size
	dbsprite   4,   4, $5e, 3
	dbsprite   4,  -4, $5d, 3
	dbsprite   4, -12, $5c, 3
	dbsprite  -4,   4, $4e, 3
	dbsprite  -4,  -4, $4d, 3
	dbsprite  -4, -12, $4c, 3
	dbsprite -12,   4, $3e, 3
	dbsprite -12,  -4, $3d, 3
	dbsprite -12, -12, $3c, 3

.frame_21
	db 9 ; size
	dbsprite   4,   4, $e2, 6
	dbsprite   4,  -4, $e1, 6
	dbsprite   4, -12, $e0, 6
	dbsprite  -4,   4, $d2, 6
	dbsprite  -4,  -4, $d1, 6
	dbsprite  -4, -12, $d0, 6
	dbsprite -12,   4, $c2, 6
	dbsprite -12,  -4, $c1, 6
	dbsprite -12, -12, $c0, 6

.frame_22
	db 9 ; size
	dbsprite   4,   4, $5b, 5
	dbsprite   4,  -4, $5a, 5
	dbsprite   4, -12, $59, 5
	dbsprite  -4,   4, $4b, 5
	dbsprite  -4,  -4, $4a, 5
	dbsprite  -4, -12, $49, 5
	dbsprite -12,   4, $3b, 5
	dbsprite -12,  -4, $3a, 5
	dbsprite -12, -12, $39, 5

.frame_23
	db 9 ; size
	dbsprite   4,   4, $ee, 5
	dbsprite   4,  -4, $ed, 5
	dbsprite   4, -12, $ec, 5
	dbsprite  -4,   4, $de, 5
	dbsprite  -4,  -4, $dd, 5
	dbsprite  -4, -12, $dc, 5
	dbsprite -12,   4, $ce, 5
	dbsprite -12,  -4, $cd, 5
	dbsprite -12, -12, $cc, 5

.frame_24
	db 4 ; size
	dbsprite -12, -12, $03, 3
	dbsprite  -4,  -4, $11, 3
	dbsprite  -4, -12, $10, 3
	dbsprite -12,  -4, $01, 3

.frame_25
	db 4 ; size
	dbsprite  -4,   4, $20, 3
	dbsprite  -4,  -4, $12, 3
	dbsprite -12,  -4, $02, 3
	dbsprite -12,   4, $05, 3

.frame_26
	db 6 ; size
	dbsprite  -4,  -4, $21, 3
	dbsprite  -4,   4, $20, 3
	dbsprite  -4, -12, $10, 3
	dbsprite -12,   4, $05, 3
	dbsprite -12,  -4, $04, 3
	dbsprite -12, -12, $03, 3

.frame_27
	db 4 ; size
	dbsprite   4,  -4, $1f, 3
	dbsprite  -4,  -4, $0f, 3
	dbsprite  -4, -12, $22, 3
	dbsprite   4, -12, $23, 3

.frame_28
	db 6 ; size
	dbsprite  -4,  -4, $2f, 3
	dbsprite   4,  -4, $1f, 3
	dbsprite -12,  -4, $01, 3
	dbsprite   4, -12, $23, 3
	dbsprite  -4, -12, $13, 3
	dbsprite -12, -12, $03, 3

.frame_29
	db 7 ; size
	dbsprite  -4,  -4, $3f, 3
	dbsprite  -4,   4, $20, 3
	dbsprite   4,  -4, $1f, 3
	dbsprite  -4, -12, $22, 3
	dbsprite -12,  -4, $02, 3
	dbsprite   4, -12, $23, 3
	dbsprite -12,   4, $05, 3

.frame_30
	db 8 ; size
	dbsprite  -4,  -4, $4f, 3
	dbsprite  -4,   4, $20, 3
	dbsprite   4,  -4, $1f, 3
	dbsprite   4, -12, $23, 3
	dbsprite  -4, -12, $13, 3
	dbsprite -12,   4, $05, 3
	dbsprite -12,  -4, $04, 3
	dbsprite -12, -12, $03, 3

.frame_31
	db 4 ; size
	dbsprite  -4,   4, $5f, 3
	dbsprite   4,  -4, $7f, 3
	dbsprite  -4,  -4, $6f, 3
	dbsprite   4,   4, $25, 3

.frame_32
	db 7 ; size
	dbsprite  -4,  -4, $8f, 3
	dbsprite   4,  -4, $7f, 3
	dbsprite  -4,   4, $5f, 3
	dbsprite  -4, -12, $10, 3
	dbsprite -12,  -4, $01, 3
	dbsprite   4,   4, $25, 3
	dbsprite -12, -12, $03, 3

.frame_33
	db 6 ; size
	dbsprite   4,  -4, $7f, 3
	dbsprite -12,  -4, $02, 3
	dbsprite  -4,  -4, $9f, 3
	dbsprite   4,   4, $25, 3
	dbsprite  -4,   4, $15, 3
	dbsprite -12,   4, $05, 3

.frame_34
	db 8 ; size
	dbsprite  -4,  -4, $af, 3
	dbsprite   4,  -4, $7f, 3
	dbsprite  -4, -12, $10, 3
	dbsprite   4,   4, $25, 3
	dbsprite  -4,   4, $15, 3
	dbsprite -12,   4, $05, 3
	dbsprite -12,  -4, $04, 3
	dbsprite -12, -12, $03, 3

.frame_35
	db 6 ; size
	dbsprite  -4,  -4, $bf, 3
	dbsprite  -4, -12, $22, 3
	dbsprite  -4,   4, $5f, 3
	dbsprite   4,   4, $25, 3
	dbsprite   4,  -4, $24, 3
	dbsprite   4, -12, $23, 3

.frame_36
	db 8 ; size
	dbsprite  -4,  -4, $cf, 3
	dbsprite  -4,   4, $5f, 3
	dbsprite -12,  -4, $01, 3
	dbsprite   4,   4, $25, 3
	dbsprite   4,  -4, $24, 3
	dbsprite   4, -12, $23, 3
	dbsprite  -4, -12, $13, 3
	dbsprite -12, -12, $03, 3

.frame_37
	db 8 ; size
	dbsprite  -4,  -4, $df, 3
	dbsprite  -4, -12, $22, 3
	dbsprite -12,  -4, $02, 3
	dbsprite   4,   4, $25, 3
	dbsprite   4,  -4, $24, 3
	dbsprite   4, -12, $23, 3
	dbsprite  -4,   4, $15, 3
	dbsprite -12,   4, $05, 3

.frame_38
	db 9 ; size
	dbsprite   4,   4, $25, 3
	dbsprite   4,  -4, $24, 3
	dbsprite   4, -12, $23, 3
	dbsprite  -4,   4, $15, 3
	dbsprite  -4,  -4, $14, 3
	dbsprite  -4, -12, $13, 3
	dbsprite -12,   4, $05, 3
	dbsprite -12,  -4, $04, 3
	dbsprite -12, -12, $03, 3
