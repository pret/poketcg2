OAMData33::
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
	db 16 ; size
	dbsprite -23, -16, $00, 0
	dbsprite -23,  -8, $01, 0
	dbsprite -23,   0, $01, 0 | OAM_XFLIP
	dbsprite -23,   8, $00, 0 | OAM_XFLIP
	dbsprite -15, -16, $02, 0
	dbsprite -15,  -8, $03, 0
	dbsprite -15,   0, $03, 0 | OAM_XFLIP
	dbsprite -15,   8, $02, 0 | OAM_XFLIP
	dbsprite  -7, -16, $02, 0 | OAM_YFLIP
	dbsprite  -7,  -8, $03, 0 | OAM_YFLIP
	dbsprite  -7,   0, $03, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite  -7,   8, $02, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite   1, -16, $00, 0 | OAM_YFLIP
	dbsprite   1,  -8, $01, 0 | OAM_YFLIP
	dbsprite   1,   0, $01, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite   1,   8, $00, 0 | OAM_XFLIP | OAM_YFLIP

.frame_1
	db 16 ; size
	dbsprite -23, -16, $00, 0
	dbsprite -23,  -8, $01, 0
	dbsprite -23,   0, $01, 0 | OAM_XFLIP
	dbsprite -23,   8, $00, 0 | OAM_XFLIP
	dbsprite -15, -16, $02, 0
	dbsprite -15,  -8, $03, 0
	dbsprite -15,   0, $03, 0 | OAM_XFLIP
	dbsprite -15,   8, $02, 0 | OAM_XFLIP
	dbsprite  -7,  -8, $03, 0 | OAM_YFLIP
	dbsprite  -7,   0, $03, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite  -7,   8, $02, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite   1, -16, $00, 0 | OAM_YFLIP
	dbsprite   1,  -8, $01, 0 | OAM_YFLIP
	dbsprite   1,   0, $01, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite   1,   8, $00, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite  -7, -16, $04, 0

.frame_2
	db 15 ; size
	dbsprite -23, -16, $00, 0
	dbsprite -23,  -8, $01, 0
	dbsprite -23,   0, $01, 0 | OAM_XFLIP
	dbsprite -23,   8, $00, 0 | OAM_XFLIP
	dbsprite -15, -16, $02, 0
	dbsprite -15,  -8, $03, 0
	dbsprite -15,   0, $03, 0 | OAM_XFLIP
	dbsprite -15,   8, $02, 0 | OAM_XFLIP
	dbsprite  -7,   0, $03, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite  -7,   8, $02, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite   1,   0, $01, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite   1,   8, $00, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite  -7, -16, $05, 0
	dbsprite  -4, -13, $06, 0
	dbsprite   1,  -8, $07, 0

.frame_3
	db 15 ; size
	dbsprite -23, -16, $00, 0
	dbsprite -23,  -8, $01, 0
	dbsprite -23,   0, $01, 0 | OAM_XFLIP
	dbsprite -23,   8, $00, 0 | OAM_XFLIP
	dbsprite -15, -16, $02, 0
	dbsprite -15,  -8, $03, 0
	dbsprite -15,   0, $03, 0 | OAM_XFLIP
	dbsprite -15,   8, $02, 0 | OAM_XFLIP
	dbsprite  -7,   0, $03, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite  -7,   8, $02, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite   1,   0, $01, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite   1,   8, $00, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite  -7, -16, $05, 0
	dbsprite  -1, -14, $06, 0
	dbsprite   1,  -8, $07, 0

.frame_4
	db 15 ; size
	dbsprite -23, -16, $00, 0
	dbsprite -23,  -8, $01, 0
	dbsprite -23,   0, $01, 0 | OAM_XFLIP
	dbsprite -23,   8, $00, 0 | OAM_XFLIP
	dbsprite -15, -16, $02, 0
	dbsprite -15,  -8, $03, 0
	dbsprite -15,   0, $03, 0 | OAM_XFLIP
	dbsprite -15,   8, $02, 0 | OAM_XFLIP
	dbsprite  -7,   0, $03, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite  -7,   8, $02, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite   1,   0, $01, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite   1,   8, $00, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite  -7, -16, $05, 0
	dbsprite   6, -13, $06, 0
	dbsprite   1,  -8, $07, 0

.frame_5
	db 16 ; size
	dbsprite -23, -16, $00, 0
	dbsprite -23,  -8, $01, 0
	dbsprite -23,   0, $01, 0 | OAM_XFLIP
	dbsprite -23,   8, $00, 0 | OAM_XFLIP
	dbsprite -15, -16, $02, 0
	dbsprite -15,  -8, $03, 0
	dbsprite -15,   0, $03, 0 | OAM_XFLIP
	dbsprite -15,   8, $02, 0 | OAM_XFLIP
	dbsprite  -7,   0, $03, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite  -7,   8, $02, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite   1,   8, $00, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite  -7, -16, $05, 0
	dbsprite  12,  -4, $06, 0
	dbsprite   1,  -8, $08, 0
	dbsprite   1,   0, $09, 0
	dbsprite   9,  -5, $05, 0

.frame_6
	db 16 ; size
	dbsprite -23, -16, $00, 0
	dbsprite -23,  -8, $01, 0
	dbsprite -23,   0, $01, 0 | OAM_XFLIP
	dbsprite -23,   8, $00, 0 | OAM_XFLIP
	dbsprite -15, -16, $02, 0
	dbsprite -15,  -8, $03, 0
	dbsprite -15,   0, $03, 0 | OAM_XFLIP
	dbsprite -15,   8, $02, 0 | OAM_XFLIP
	dbsprite  -7,   0, $03, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite  -7,   8, $02, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite   1,   8, $00, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite  -7, -16, $05, 0
	dbsprite  17,  -4, $06, 0
	dbsprite   1,  -8, $08, 0
	dbsprite   1,   0, $09, 0
	dbsprite   9,  -5, $05, 0

.frame_7
	db 16 ; size
	dbsprite -23, -16, $00, 0
	dbsprite -23,  -8, $01, 0
	dbsprite -23,   0, $01, 0 | OAM_XFLIP
	dbsprite -23,   8, $00, 0 | OAM_XFLIP
	dbsprite -15, -16, $02, 0
	dbsprite -15,  -8, $03, 0
	dbsprite -15,   0, $03, 0 | OAM_XFLIP
	dbsprite -15,   8, $02, 0 | OAM_XFLIP
	dbsprite  -7,   0, $03, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite  -7,   8, $02, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite   1,   8, $00, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite  -7, -16, $05, 0
	dbsprite  14,  -4, $06, 0
	dbsprite   1,  -8, $08, 0
	dbsprite   1,   0, $09, 0
	dbsprite   9,  -5, $05, 0

.frame_8
	db 16 ; size
	dbsprite -23, -16, $00, 1
	dbsprite -23,  -8, $01, 1
	dbsprite -23,   0, $01, 1 | OAM_XFLIP
	dbsprite -23,   8, $00, 1 | OAM_XFLIP
	dbsprite -15, -16, $02, 1
	dbsprite -15,  -8, $03, 1
	dbsprite -15,   0, $03, 1 | OAM_XFLIP
	dbsprite -15,   8, $02, 1 | OAM_XFLIP
	dbsprite  -7,   0, $03, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite  -7,   8, $02, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite   1,   8, $00, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite  -7, -16, $05, 1
	dbsprite  14,  -4, $06, 1
	dbsprite   1,  -8, $08, 1
	dbsprite   1,   0, $09, 1
	dbsprite   9,  -5, $05, 1

.frame_9
	db 16 ; size
	dbsprite -23, -16, $00, 2
	dbsprite -23,  -8, $01, 2
	dbsprite -23,   0, $01, 2 | OAM_XFLIP
	dbsprite -23,   8, $00, 2 | OAM_XFLIP
	dbsprite -15, -16, $02, 2
	dbsprite -15,  -8, $03, 2
	dbsprite -15,   0, $03, 2 | OAM_XFLIP
	dbsprite -15,   8, $02, 2 | OAM_XFLIP
	dbsprite  -7,   0, $03, 2 | OAM_XFLIP | OAM_YFLIP
	dbsprite  -7,   8, $02, 2 | OAM_XFLIP | OAM_YFLIP
	dbsprite   1,   8, $00, 2 | OAM_XFLIP | OAM_YFLIP
	dbsprite  -7, -16, $05, 2
	dbsprite  14,  -4, $06, 2
	dbsprite   1,  -8, $08, 2
	dbsprite   1,   0, $09, 2
	dbsprite   9,  -5, $05, 2

OAMData35::
	dw .frame_0
	dw .frame_1
	dw .frame_2
	dw .frame_3
	dw .frame_4
	dw .frame_5
	dw .frame_6
	dw .frame_7
	dw .frame_8

.frame_0
	db 5 ; size
	dbsprite  20, -32, $01, 0
	dbsprite  20, -16, $01, 0
	dbsprite  20,  -8, $01, 0
	dbsprite  20,   8, $01, 0
	dbsprite  20,  24, $01, 0

.frame_1
	db 8 ; size
	dbsprite  20, -24, $01, 0
	dbsprite  20,   0, $01, 0
	dbsprite  20,  16, $01, 0
	dbsprite  20, -32, $00, 1
	dbsprite  20, -16, $00, 1
	dbsprite  20,  -8, $00, 1
	dbsprite  20,   8, $00, 1
	dbsprite  20,  24, $00, 1

.frame_2
	db 8 ; size
	dbsprite  20, -32, $01, 1
	dbsprite  20, -16, $01, 1
	dbsprite  20,  -8, $01, 1
	dbsprite  20,   8, $01, 1
	dbsprite  20,  24, $01, 1
	dbsprite  20, -24, $00, 0
	dbsprite  20,   0, $00, 0
	dbsprite  20,  16, $00, 0

.frame_3
	db 8 ; size
	dbsprite  20, -24, $01, 1
	dbsprite  20,   0, $01, 1
	dbsprite  20,  16, $01, 1
	dbsprite  20, -32, $00, 0
	dbsprite  20, -16, $00, 0
	dbsprite  20,  -8, $00, 0
	dbsprite  20,   8, $00, 0
	dbsprite  20,  24, $00, 0

.frame_4
	db 8 ; size
	dbsprite  20, -32, $01, 0
	dbsprite  20, -16, $01, 0
	dbsprite  20,  -8, $01, 0
	dbsprite  20,   8, $01, 0
	dbsprite  20,  24, $01, 0
	dbsprite  20, -24, $00, 1
	dbsprite  20,   0, $00, 1
	dbsprite  20,  16, $00, 1

.frame_5
	db 13 ; size
	dbsprite -64,  -8, $01, 0
	dbsprite   8,   8, $01, 0
	dbsprite -48,   0, $01, 0
	dbsprite -24,  -8, $01, 0
	dbsprite -16,   0, $01, 0
	dbsprite   0,   0, $01, 0
	dbsprite -56, -16, $00, 1
	dbsprite -32,  -8, $00, 1
	dbsprite   0,   0, $00, 1
	dbsprite -12,  -4, $00, 1
	dbsprite -44,  -8, $00, 1
	dbsprite -32, -32, $00, 1
	dbsprite   8, -24, $00, 1

.frame_6
	db 13 ; size
	dbsprite -64, -16, $00, 0
	dbsprite -48,  -8, $00, 0
	dbsprite -24, -16, $00, 0
	dbsprite -16,  -8, $00, 0
	dbsprite   0,  -8, $00, 0
	dbsprite   8,   0, $00, 0
	dbsprite -56,  -8, $01, 1
	dbsprite -44,   0, $01, 1
	dbsprite -32,   0, $01, 1
	dbsprite -12,   4, $01, 1
	dbsprite   0,   8, $01, 1
	dbsprite -36, -32, $00, 0
	dbsprite   4, -24, $00, 0

.frame_7
	db 13 ; size
	dbsprite -64,  -8, $01, 1
	dbsprite   8,   8, $01, 1
	dbsprite -48,   0, $01, 1
	dbsprite -24,  -8, $01, 1
	dbsprite -16,   0, $01, 1
	dbsprite   0,   0, $01, 1
	dbsprite -56, -16, $00, 0
	dbsprite -32,  -8, $00, 0
	dbsprite   0,   0, $00, 0
	dbsprite -12,  -4, $00, 0
	dbsprite -44,  -8, $00, 0
	dbsprite -32, -32, $00, 0
	dbsprite   8, -24, $00, 0

.frame_8
	db 13 ; size
	dbsprite -64, -16, $00, 1
	dbsprite -48,  -8, $00, 1
	dbsprite -24, -16, $00, 1
	dbsprite -16,  -8, $00, 1
	dbsprite   0,  -8, $00, 1
	dbsprite   8,   0, $00, 1
	dbsprite -56,  -8, $01, 0
	dbsprite -44,   0, $01, 0
	dbsprite -32,   0, $01, 0
	dbsprite -12,   4, $01, 0
	dbsprite   0,   8, $01, 0
	dbsprite -36, -32, $00, 1
	dbsprite   4, -24, $00, 1

OAMData36::
	dw .frame_0
	dw .frame_1
	dw .frame_2
	dw .frame_3
	dw .frame_4

.frame_0
	db 5 ; size
	dbsprite -28,  24, $01, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite -28,   8, $01, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite -28,   0, $01, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite -28, -16, $01, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite -28, -32, $01, 0 | OAM_XFLIP | OAM_YFLIP

.frame_1
	db 8 ; size
	dbsprite -28,  16, $01, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite -28,  -8, $01, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite -28, -24, $01, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite -28,  24, $00, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite -28,   8, $00, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite -28,   0, $00, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite -28, -16, $00, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite -28, -32, $00, 1 | OAM_XFLIP | OAM_YFLIP

.frame_2
	db 8 ; size
	dbsprite -28,  24, $01, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite -28,   8, $01, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite -28,   0, $01, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite -28, -16, $01, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite -28, -32, $01, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite -28,  16, $00, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite -28,  -8, $00, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite -28, -24, $00, 0 | OAM_XFLIP | OAM_YFLIP

.frame_3
	db 8 ; size
	dbsprite -28,  16, $01, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite -28,  -8, $01, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite -28, -24, $01, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite -28,  24, $00, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite -28,   8, $00, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite -28,   0, $00, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite -28, -16, $00, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite -28, -32, $00, 0 | OAM_XFLIP | OAM_YFLIP

.frame_4
	db 8 ; size
	dbsprite -28,  24, $01, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite -28,   8, $01, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite -28,   0, $01, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite -28, -16, $01, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite -28, -32, $01, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite -28,  16, $00, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite -28,  -8, $00, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite -28, -24, $00, 1 | OAM_XFLIP | OAM_YFLIP

OAMData38::
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
	dbsprite   8,   8, $06, 0 | OAM_YFLIP
	dbsprite   0,  16, $00, 0 | OAM_XFLIP
	dbsprite   8,  16, $00, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite   8, -16, $06, 0 | OAM_YFLIP
	dbsprite   8,  -8, $06, 0 | OAM_YFLIP
	dbsprite   8,   0, $06, 0 | OAM_YFLIP
	dbsprite   0,   8, $06, 0
	dbsprite   0, -16, $06, 0
	dbsprite   0,  -8, $06, 0
	dbsprite   0,   0, $06, 0
	dbsprite   8, -24, $00, 0 | OAM_YFLIP
	dbsprite   0, -24, $00, 0

.frame_1
	db 12 ; size
	dbsprite   8,   0, $01, 0 | OAM_YFLIP
	dbsprite   8,   8, $02, 0 | OAM_YFLIP
	dbsprite   0,   0, $03, 0 | OAM_YFLIP
	dbsprite   0,   8, $04, 0 | OAM_YFLIP
	dbsprite  -8,   0, $00, 0
	dbsprite  -8,   8, $00, 0 | OAM_XFLIP
	dbsprite   0, -24, $00, 0
	dbsprite   8, -24, $00, 0 | OAM_YFLIP
	dbsprite   8, -16, $06, 0 | OAM_YFLIP
	dbsprite   8,  -8, $06, 0 | OAM_YFLIP
	dbsprite   0, -16, $06, 0
	dbsprite   0,  -8, $06, 0

.frame_2
	db 14 ; size
	dbsprite   8,   0, $01, 0 | OAM_YFLIP
	dbsprite   8,   8, $02, 0 | OAM_YFLIP
	dbsprite   0,   0, $03, 0 | OAM_YFLIP
	dbsprite   0,   8, $04, 0 | OAM_YFLIP
	dbsprite -16,   0, $01, 0
	dbsprite -16,   8, $02, 0
	dbsprite  -8,   0, $03, 0
	dbsprite  -8,   8, $04, 0
	dbsprite -16,  -8, $00, 0
	dbsprite  -8,  -8, $00, 0 | OAM_YFLIP
	dbsprite   0, -16, $00, 0
	dbsprite   8, -16, $00, 0 | OAM_YFLIP
	dbsprite   8,  -8, $06, 0 | OAM_YFLIP
	dbsprite   0,  -8, $06, 0

.frame_3
	db 15 ; size
	dbsprite   8,  -8, $00, 0 | OAM_YFLIP
	dbsprite -16,   0, $01, 0
	dbsprite -16,   8, $02, 0
	dbsprite  -8,   8, $04, 0
	dbsprite -16,  -8, $01, 0 | OAM_XFLIP
	dbsprite -16, -16, $02, 0 | OAM_XFLIP
	dbsprite  -8, -16, $04, 0 | OAM_XFLIP
	dbsprite   0, -16, $00, 0 | OAM_YFLIP
	dbsprite   8,   0, $01, 0 | OAM_YFLIP
	dbsprite   8,   8, $02, 0 | OAM_YFLIP
	dbsprite   0,   8, $04, 0 | OAM_YFLIP
	dbsprite   0,   0, $05, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite  -8,   0, $05, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite  -8,  -8, $05, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite   0,  -8, $07, 0 | OAM_XFLIP | OAM_YFLIP

.frame_4
	db 15 ; size
	dbsprite   8,   0, $00, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite -16,  -8, $01, 0 | OAM_XFLIP
	dbsprite -16, -16, $02, 0 | OAM_XFLIP
	dbsprite  -8, -16, $04, 0 | OAM_XFLIP
	dbsprite -16,   0, $01, 0
	dbsprite -16,   8, $02, 0
	dbsprite  -8,   8, $04, 0
	dbsprite   0,   8, $00, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite   8,  -8, $01, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite   8, -16, $02, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite   0, -16, $04, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite   0,  -8, $05, 0 | OAM_YFLIP
	dbsprite  -8,  -8, $05, 0 | OAM_YFLIP
	dbsprite  -8,   0, $05, 0 | OAM_YFLIP
	dbsprite   0,   0, $07, 0 | OAM_YFLIP

.frame_5
	db 16 ; size
	dbsprite   7,  -8, $01, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite   7, -16, $02, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite  -1, -16, $04, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite   7,   0, $01, 0 | OAM_YFLIP
	dbsprite   7,   8, $02, 0 | OAM_YFLIP
	dbsprite  -1,   8, $04, 0 | OAM_YFLIP
	dbsprite -15,  -8, $01, 0 | OAM_XFLIP
	dbsprite -15, -16, $02, 0 | OAM_XFLIP
	dbsprite  -7, -16, $04, 0 | OAM_XFLIP
	dbsprite  -7,  -8, $05, 0
	dbsprite  -1,  -8, $05, 0
	dbsprite  -1,   0, $05, 0
	dbsprite -15,   0, $01, 0
	dbsprite -15,   8, $02, 0
	dbsprite  -7,   8, $04, 0
	dbsprite  -7,   0, $05, 0 | OAM_XFLIP

.frame_6
	db 16 ; size
	dbsprite -16,  -7, $01, 1 | OAM_XFLIP
	dbsprite -16, -15, $02, 1 | OAM_XFLIP
	dbsprite  -8, -15, $04, 1 | OAM_XFLIP
	dbsprite   8,  -7, $01, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite   8, -15, $02, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite   0, -15, $04, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite   0,  -7, $05, 1 | OAM_YFLIP
	dbsprite  -8,  -7, $05, 1 | OAM_YFLIP
	dbsprite -16,  -1, $01, 1
	dbsprite -16,   7, $02, 1
	dbsprite  -8,   7, $04, 1
	dbsprite   8,  -1, $01, 1 | OAM_YFLIP
	dbsprite   8,   7, $02, 1 | OAM_YFLIP
	dbsprite   0,   7, $04, 1 | OAM_YFLIP
	dbsprite   0,  -1, $05, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite  -8,  -1, $05, 1 | OAM_XFLIP | OAM_YFLIP

.frame_7
	db 16 ; size
	dbsprite   7,  -8, $01, 2 | OAM_XFLIP | OAM_YFLIP
	dbsprite   7, -16, $02, 2 | OAM_XFLIP | OAM_YFLIP
	dbsprite  -1, -16, $04, 2 | OAM_XFLIP | OAM_YFLIP
	dbsprite   7,   0, $01, 2 | OAM_YFLIP
	dbsprite   7,   8, $02, 2 | OAM_YFLIP
	dbsprite  -1,   8, $04, 2 | OAM_YFLIP
	dbsprite -15,  -8, $01, 2 | OAM_XFLIP
	dbsprite -15, -16, $02, 2 | OAM_XFLIP
	dbsprite  -7, -16, $04, 2 | OAM_XFLIP
	dbsprite  -7,  -8, $05, 2
	dbsprite  -1,  -8, $05, 2
	dbsprite  -1,   0, $05, 2
	dbsprite -15,   0, $01, 2
	dbsprite -15,   8, $02, 2
	dbsprite  -7,   8, $04, 2
	dbsprite  -7,   0, $05, 2 | OAM_XFLIP

.frame_8
	db 16 ; size
	dbsprite -16,  -7, $01, 0 | OAM_XFLIP
	dbsprite -16, -15, $02, 0 | OAM_XFLIP
	dbsprite  -8, -15, $04, 0 | OAM_XFLIP
	dbsprite   8,  -7, $01, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite   8, -15, $02, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite   0, -15, $04, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite   0,  -7, $05, 0 | OAM_YFLIP
	dbsprite  -8,  -7, $05, 0 | OAM_YFLIP
	dbsprite -16,  -1, $01, 0
	dbsprite -16,   7, $02, 0
	dbsprite  -8,   7, $04, 0
	dbsprite   8,  -1, $01, 0 | OAM_YFLIP
	dbsprite   8,   7, $02, 0 | OAM_YFLIP
	dbsprite   0,   7, $04, 0 | OAM_YFLIP
	dbsprite   0,  -1, $05, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite  -8,  -1, $05, 0 | OAM_XFLIP | OAM_YFLIP

.frame_9
	db 16 ; size
	dbsprite   7,  -8, $01, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite   7, -16, $02, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite  -1, -16, $04, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite   7,   0, $01, 1 | OAM_YFLIP
	dbsprite   7,   8, $02, 1 | OAM_YFLIP
	dbsprite  -1,   8, $04, 1 | OAM_YFLIP
	dbsprite -15,  -8, $01, 1 | OAM_XFLIP
	dbsprite -15, -16, $02, 1 | OAM_XFLIP
	dbsprite  -7, -16, $04, 1 | OAM_XFLIP
	dbsprite  -7,  -8, $05, 1
	dbsprite  -1,  -8, $05, 1
	dbsprite  -1,   0, $05, 1
	dbsprite -15,   0, $01, 1
	dbsprite -15,   8, $02, 1
	dbsprite  -7,   8, $04, 1
	dbsprite  -7,   0, $05, 1 | OAM_XFLIP

.frame_10
	db 16 ; size
	dbsprite -16,  -7, $01, 2 | OAM_XFLIP
	dbsprite -16, -15, $02, 2 | OAM_XFLIP
	dbsprite  -8, -15, $04, 2 | OAM_XFLIP
	dbsprite   8,  -7, $01, 2 | OAM_XFLIP | OAM_YFLIP
	dbsprite   8, -15, $02, 2 | OAM_XFLIP | OAM_YFLIP
	dbsprite   0, -15, $04, 2 | OAM_XFLIP | OAM_YFLIP
	dbsprite   0,  -7, $05, 2 | OAM_YFLIP
	dbsprite  -8,  -7, $05, 2 | OAM_YFLIP
	dbsprite -16,  -1, $01, 2
	dbsprite -16,   7, $02, 2
	dbsprite  -8,   7, $04, 2
	dbsprite   8,  -1, $01, 2 | OAM_YFLIP
	dbsprite   8,   7, $02, 2 | OAM_YFLIP
	dbsprite   0,   7, $04, 2 | OAM_YFLIP
	dbsprite   0,  -1, $05, 2 | OAM_XFLIP | OAM_YFLIP
	dbsprite  -8,  -1, $05, 2 | OAM_XFLIP | OAM_YFLIP

OAMData39::
	dw .frame_0
	dw .frame_1
	dw .frame_2
	dw .frame_3
	dw .frame_4
	dw .frame_5

.frame_0
	db 1 ; size
	dbsprite  -3,  -4, $04, 0

.frame_1
	db 4 ; size
	dbsprite  -8,  -8, $02, 0
	dbsprite  -8,   0, $02, 0 | OAM_XFLIP
	dbsprite   0,  -8, $03, 0
	dbsprite   0,   0, $03, 0 | OAM_XFLIP

.frame_2
	db 10 ; size
	dbsprite -11, -12, $06, 0
	dbsprite -11,  -4, $07, 0
	dbsprite -11,   4, $08, 0
	dbsprite  -3, -12, $09, 0
	dbsprite  -3,  -4, $0a, 0
	dbsprite  -3,   4, $0b, 0
	dbsprite   5, -12, $0c, 0
	dbsprite   5,  -4, $0d, 0
	dbsprite   5,   4, $0e, 0
	dbsprite -14,  12, $05, 0 | OAM_XFLIP

.frame_3
	db 6 ; size
	dbsprite  -7,  -8, $00, 0
	dbsprite  -7,   0, $00, 0 | OAM_XFLIP
	dbsprite   1,  -8, $01, 0
	dbsprite   1,   0, $01, 0 | OAM_XFLIP
	dbsprite  -7, -16, $05, 0
	dbsprite  -7,   8, $05, 0 | OAM_XFLIP

.frame_4
	db 4 ; size
	dbsprite   0,   0, $10, 0 | OAM_XFLIP
	dbsprite  -8,   0, $0f, 0 | OAM_XFLIP
	dbsprite   0,  -8, $10, 0
	dbsprite  -8,  -8, $0f, 0

.frame_5
	db 10 ; size
	dbsprite -11, -12, $06, 1
	dbsprite -11,  -4, $07, 1
	dbsprite -11,   4, $08, 1
	dbsprite  -3, -12, $09, 1
	dbsprite  -3,  -4, $0a, 1
	dbsprite  -3,   4, $0b, 1
	dbsprite   5, -12, $0c, 1
	dbsprite   5,  -4, $0d, 1
	dbsprite   5,   4, $0e, 1
	dbsprite -14,  12, $05, 1 | OAM_XFLIP

OAMData3A::
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

.frame_0
	db 16 ; size
	dbsprite -24,  -1, $00, 0
	dbsprite -32,   0, $00, 1
	dbsprite -40,   1, $00, 0
	dbsprite -48,   2, $00, 1
	dbsprite  16,  -7, $00, 0 | OAM_YFLIP
	dbsprite  24,  -8, $00, 1 | OAM_YFLIP
	dbsprite  32,  -9, $00, 0 | OAM_YFLIP
	dbsprite  40, -10, $00, 1 | OAM_YFLIP
	dbsprite  -1,  16, $01, 0
	dbsprite   0,  24, $01, 1
	dbsprite   1,  32, $01, 0
	dbsprite   2,  40, $01, 1
	dbsprite  -7, -24, $01, 0 | OAM_XFLIP
	dbsprite  -8, -32, $01, 1 | OAM_XFLIP
	dbsprite  -9, -40, $01, 0 | OAM_XFLIP
	dbsprite -10, -48, $01, 1 | OAM_XFLIP

.frame_1
	db 16 ; size
	dbsprite -24,  -1, $00, 1 | OAM_XFLIP
	dbsprite -32,   0, $00, 0 | OAM_XFLIP
	dbsprite -40,   1, $00, 1 | OAM_XFLIP
	dbsprite -48,   2, $00, 0 | OAM_XFLIP
	dbsprite  16,  -7, $00, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite  24,  -8, $00, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite  32,  -9, $00, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite  40, -10, $00, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite  -1,  16, $01, 1 | OAM_YFLIP
	dbsprite   0,  24, $01, 0 | OAM_YFLIP
	dbsprite   1,  32, $01, 1 | OAM_YFLIP
	dbsprite   2,  40, $01, 0 | OAM_YFLIP
	dbsprite  -7, -24, $01, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite  -8, -32, $01, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite  -9, -40, $01, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite -10, -48, $01, 0 | OAM_XFLIP | OAM_YFLIP

.frame_2
	db 16 ; size
	dbsprite -22,   5, $00, 0
	dbsprite -30,   8, $00, 1
	dbsprite -38,  11, $00, 0
	dbsprite -46,  14, $00, 1
	dbsprite  14, -13, $00, 0 | OAM_YFLIP
	dbsprite  22, -16, $00, 1 | OAM_YFLIP
	dbsprite  30, -19, $00, 0 | OAM_YFLIP
	dbsprite  38, -22, $00, 1 | OAM_YFLIP
	dbsprite   5,  14, $01, 0
	dbsprite   8,  22, $01, 1
	dbsprite  11,  30, $01, 0
	dbsprite  14,  38, $01, 1
	dbsprite -13, -22, $01, 0 | OAM_XFLIP
	dbsprite -16, -30, $01, 1 | OAM_XFLIP
	dbsprite -19, -38, $01, 0 | OAM_XFLIP
	dbsprite -22, -46, $01, 1 | OAM_XFLIP

.frame_3
	db 16 ; size
	dbsprite -22,   5, $00, 1 | OAM_XFLIP
	dbsprite -30,   8, $00, 0 | OAM_XFLIP
	dbsprite -38,  11, $00, 1 | OAM_XFLIP
	dbsprite -46,  14, $00, 0 | OAM_XFLIP
	dbsprite  14, -13, $00, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite  22, -16, $00, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite  30, -19, $00, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite  38, -22, $00, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite   5,  14, $01, 1 | OAM_YFLIP
	dbsprite   8,  22, $01, 0 | OAM_YFLIP
	dbsprite  11,  30, $01, 1 | OAM_YFLIP
	dbsprite  14,  38, $01, 0 | OAM_YFLIP
	dbsprite -13, -22, $01, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite -16, -30, $01, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite -19, -38, $01, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite -22, -46, $01, 0 | OAM_XFLIP | OAM_YFLIP

.frame_4
	db 12 ; size
	dbsprite -42,  22, $02, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite -32,  16, $02, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite -22,  10, $02, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite  10,  14, $02, 0 | OAM_YFLIP
	dbsprite  16,  24, $02, 1 | OAM_YFLIP
	dbsprite  22,  34, $02, 0 | OAM_YFLIP
	dbsprite  34, -30, $02, 0
	dbsprite  24, -24, $02, 1
	dbsprite  14, -18, $02, 0
	dbsprite -18, -22, $02, 0 | OAM_XFLIP
	dbsprite -24, -32, $02, 1 | OAM_XFLIP
	dbsprite -30, -42, $02, 0 | OAM_XFLIP

.frame_5
	db 12 ; size
	dbsprite -22,  10, $02, 1
	dbsprite -32,  16, $02, 0
	dbsprite -42,  22, $02, 1
	dbsprite  22,  34, $02, 1 | OAM_XFLIP
	dbsprite  16,  24, $02, 0 | OAM_XFLIP
	dbsprite  10,  14, $02, 1 | OAM_XFLIP
	dbsprite  14, -18, $02, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite  24, -24, $02, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite  34, -30, $02, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite -30, -42, $02, 1 | OAM_YFLIP
	dbsprite -24, -32, $02, 0 | OAM_YFLIP
	dbsprite -18, -22, $02, 1 | OAM_YFLIP

.frame_6
	db 12 ; size
	dbsprite -36,  28, $02, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite -28,  20, $02, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite -20,  12, $02, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite  12,  12, $02, 0 | OAM_YFLIP
	dbsprite  20,  20, $02, 1 | OAM_YFLIP
	dbsprite  28,  28, $02, 0 | OAM_YFLIP
	dbsprite  28, -36, $02, 0
	dbsprite  20, -28, $02, 1
	dbsprite  12, -20, $02, 0
	dbsprite -20, -20, $02, 0 | OAM_XFLIP
	dbsprite -28, -28, $02, 1 | OAM_XFLIP
	dbsprite -36, -36, $02, 0 | OAM_XFLIP

.frame_7
	db 12 ; size
	dbsprite -20,  12, $02, 1
	dbsprite -28,  20, $02, 0
	dbsprite -36,  28, $02, 1
	dbsprite  28,  28, $02, 1 | OAM_XFLIP
	dbsprite  20,  20, $02, 0 | OAM_XFLIP
	dbsprite  12,  12, $02, 1 | OAM_XFLIP
	dbsprite  12, -20, $02, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite  20, -28, $02, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite  28, -36, $02, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite -36, -36, $02, 1 | OAM_YFLIP
	dbsprite -28, -28, $02, 0 | OAM_YFLIP
	dbsprite -20, -20, $02, 1 | OAM_YFLIP

.frame_8
	db 12 ; size
	dbsprite -22, -18, $02, 0 | OAM_XFLIP
	dbsprite -32, -24, $02, 1 | OAM_XFLIP
	dbsprite -42, -30, $02, 0 | OAM_XFLIP
	dbsprite  22, -42, $02, 0
	dbsprite  16, -32, $02, 1
	dbsprite  10, -22, $02, 0
	dbsprite  14,  10, $02, 0 | OAM_YFLIP
	dbsprite  24,  16, $02, 1 | OAM_YFLIP
	dbsprite  34,  22, $02, 0 | OAM_YFLIP
	dbsprite -30,  34, $02, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite -24,  24, $02, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite -18,  14, $02, 0 | OAM_XFLIP | OAM_YFLIP

.frame_9
	db 12 ; size
	dbsprite -42, -30, $02, 1 | OAM_YFLIP
	dbsprite -32, -24, $02, 0 | OAM_YFLIP
	dbsprite -22, -18, $02, 1 | OAM_YFLIP
	dbsprite  10, -22, $02, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite  16, -32, $02, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite  22, -42, $02, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite  34,  22, $02, 1 | OAM_XFLIP
	dbsprite  24,  16, $02, 0 | OAM_XFLIP
	dbsprite  14,  10, $02, 1 | OAM_XFLIP
	dbsprite -18,  14, $02, 1
	dbsprite -24,  24, $02, 0
	dbsprite -30,  34, $02, 1

.frame_10
	db 16 ; size
	dbsprite -22, -13, $00, 0
	dbsprite -30, -16, $00, 0
	dbsprite -38, -19, $00, 0
	dbsprite -46, -22, $00, 0
	dbsprite   5, -22, $01, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite   8, -30, $01, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite  11, -38, $01, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite  14, -46, $01, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite  14,   5, $00, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite  22,   8, $00, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite  30,  11, $00, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite  38,  14, $00, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite -13,  14, $01, 0
	dbsprite -16,  22, $01, 0
	dbsprite -19,  30, $01, 0
	dbsprite -22,  38, $01, 0

.frame_11
	db 16 ; size
	dbsprite -22, -13, $00, 1 | OAM_XFLIP
	dbsprite -30, -16, $00, 0 | OAM_XFLIP
	dbsprite -38, -19, $00, 1 | OAM_XFLIP
	dbsprite -46, -22, $00, 0 | OAM_XFLIP
	dbsprite   5, -22, $01, 1 | OAM_XFLIP
	dbsprite   8, -30, $01, 0 | OAM_XFLIP
	dbsprite  11, -38, $01, 1 | OAM_XFLIP
	dbsprite  14, -46, $01, 0 | OAM_XFLIP
	dbsprite  14,   5, $00, 1 | OAM_YFLIP
	dbsprite  22,   8, $00, 0 | OAM_YFLIP
	dbsprite  30,  11, $00, 1 | OAM_YFLIP
	dbsprite  38,  14, $00, 0 | OAM_YFLIP
	dbsprite -13,  14, $01, 1 | OAM_YFLIP
	dbsprite -16,  22, $01, 0 | OAM_YFLIP
	dbsprite -19,  30, $01, 1 | OAM_YFLIP
	dbsprite -22,  38, $01, 0 | OAM_YFLIP

.frame_12
	db 16 ; size
	dbsprite -24,  -7, $00, 0
	dbsprite -32,  -8, $00, 1
	dbsprite -40,  -9, $00, 0
	dbsprite -48, -10, $00, 1
	dbsprite  -7,  16, $01, 0
	dbsprite  -8,  24, $01, 1
	dbsprite  -9,  32, $01, 0
	dbsprite -10,  40, $01, 1
	dbsprite  -1, -24, $01, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite   0, -32, $01, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite   1, -40, $01, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite   2, -48, $01, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite  16,  -1, $00, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite  24,   0, $00, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite  32,   1, $00, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite  40,   2, $00, 1 | OAM_XFLIP | OAM_YFLIP

.frame_13
	db 16 ; size
	dbsprite -24,  -7, $00, 1 | OAM_XFLIP
	dbsprite -32,  -8, $00, 0 | OAM_XFLIP
	dbsprite -40,  -9, $00, 1 | OAM_XFLIP
	dbsprite -48, -10, $00, 0 | OAM_XFLIP
	dbsprite  16,  -1, $00, 1 | OAM_XFLIP
	dbsprite  24,   0, $00, 0 | OAM_XFLIP
	dbsprite  32,   1, $00, 1 | OAM_XFLIP
	dbsprite  40,   2, $00, 0 | OAM_XFLIP
	dbsprite  -7,  16, $01, 1 | OAM_YFLIP
	dbsprite  -8,  24, $01, 0 | OAM_YFLIP
	dbsprite  -9,  32, $01, 1 | OAM_YFLIP
	dbsprite -10,  40, $01, 0 | OAM_YFLIP
	dbsprite  -1, -24, $01, 1 | OAM_YFLIP
	dbsprite   0, -32, $01, 0 | OAM_YFLIP
	dbsprite   1, -40, $01, 1 | OAM_YFLIP
	dbsprite   2, -48, $01, 0 | OAM_YFLIP

OAMData3B::
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
	db 2 ; size
	dbsprite -32,  13, $06, 0
	dbsprite -32,   5, $05, 0

.frame_1
	db 4 ; size
	dbsprite -24,  10, $0d, 0
	dbsprite -24,   2, $0c, 0
	dbsprite -32,  10, $0b, 0
	dbsprite -32,   2, $0a, 0

.frame_2
	db 6 ; size
	dbsprite -16,   7, $14, 0
	dbsprite -16,  -1, $13, 0
	dbsprite -24,   7, $12, 0
	dbsprite -24,  -1, $11, 0
	dbsprite -32,   7, $10, 0
	dbsprite -32,  -1, $0f, 0

.frame_3
	db 7 ; size
	dbsprite  -8,   4, $06, 0
	dbsprite  -8,  -4, $05, 0
	dbsprite -16,   4, $04, 0
	dbsprite -16,  -4, $03, 0
	dbsprite -24,   4, $02, 0
	dbsprite -24,  -4, $01, 0
	dbsprite -32,   4, $00, 0

.frame_4
	db 7 ; size
	dbsprite  -8,   4, $0d, 0
	dbsprite  -8,  -4, $0c, 0
	dbsprite -16,   4, $0b, 0
	dbsprite -16,  -4, $0a, 0
	dbsprite -24,   4, $09, 0
	dbsprite -24,  -4, $08, 0
	dbsprite -32,   4, $07, 0

.frame_5
	db 7 ; size
	dbsprite  -8,   4, $14, 0
	dbsprite  -8,  -4, $13, 0
	dbsprite -16,   4, $12, 0
	dbsprite -16,  -4, $11, 0
	dbsprite -24,   4, $10, 0
	dbsprite -24,  -4, $0f, 0
	dbsprite -32,   4, $0e, 0

.frame_6
	db 13 ; size
	dbsprite   0,   8, $1c, 1
	dbsprite   0,   0, $1b, 1
	dbsprite   0,  -8, $1a, 1
	dbsprite   0, -16, $19, 1
	dbsprite  -8,   8, $18, 1
	dbsprite  -8,   0, $17, 1
	dbsprite  -8,  -8, $16, 1
	dbsprite  -8, -16, $15, 1
	dbsprite -10,   1, $12, 0
	dbsprite -10,  -7, $11, 0
	dbsprite -18,   1, $10, 0
	dbsprite -18,  -7, $0f, 0
	dbsprite -26,   1, $0e, 0

.frame_7
	db 15 ; size
	dbsprite   8,   8, $28, 1
	dbsprite   8,   0, $27, 1
	dbsprite   8,  -8, $26, 1
	dbsprite   8, -16, $25, 1
	dbsprite   0,   8, $24, 1
	dbsprite   0,   0, $23, 1
	dbsprite   0,  -8, $22, 1
	dbsprite   0, -16, $21, 1
	dbsprite  -8,   8, $20, 1
	dbsprite  -8,   0, $1f, 1
	dbsprite  -8,  -8, $1e, 1
	dbsprite  -8, -16, $1d, 1
	dbsprite  -8,  -2, $02, 0
	dbsprite  -8, -10, $01, 0
	dbsprite -16,  -2, $00, 0

.frame_8
	db 5 ; size
	dbsprite   5, -10, $2a, 1 | OAM_YFLIP
	dbsprite   4,   7, $2a, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite -12, -18, $2a, 1
	dbsprite  -8,   8, $29, 1 | OAM_XFLIP
	dbsprite  -2, -17, $29, 1 | OAM_YFLIP

.frame_9
	db 5 ; size
	dbsprite  12, -17, $2a, 0 | OAM_YFLIP
	dbsprite  10,  14, $2a, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite -17, -24, $2a, 0
	dbsprite -11,  15, $29, 0 | OAM_XFLIP
	dbsprite   0, -24, $29, 0 | OAM_YFLIP

.frame_10
	db 9 ; size
	dbsprite -64,  41, $06, 0
	dbsprite -64,  33, $05, 0
	dbsprite -40,  11, $06, 0
	dbsprite -40,   3, $05, 0
	dbsprite -48,  11, $04, 0
	dbsprite -48,   3, $03, 0
	dbsprite -56,  11, $02, 0
	dbsprite -56,   3, $01, 0
	dbsprite -64,  11, $00, 0

.frame_11
	db 11 ; size
	dbsprite -56,  38, $0d, 0
	dbsprite -56,  30, $0c, 0
	dbsprite -64,  38, $0b, 0
	dbsprite -64,  30, $0a, 0
	dbsprite -32,   8, $0d, 0
	dbsprite -32,   0, $0c, 0
	dbsprite -40,   8, $0b, 0
	dbsprite -40,   0, $0a, 0
	dbsprite -48,   8, $09, 0
	dbsprite -48,   0, $08, 0
	dbsprite -56,   8, $07, 0

.frame_12
	db 13 ; size
	dbsprite -48,  35, $14, 0
	dbsprite -48,  27, $13, 0
	dbsprite -56,  35, $12, 0
	dbsprite -56,  27, $11, 0
	dbsprite -64,  35, $10, 0
	dbsprite -64,  27, $0f, 0
	dbsprite -24,   5, $14, 0
	dbsprite -24,  -3, $13, 0
	dbsprite -32,   5, $12, 0
	dbsprite -32,  -3, $11, 0
	dbsprite -40,   5, $10, 0
	dbsprite -40,  -3, $0f, 0
	dbsprite -48,   5, $0e, 0

.frame_13
	db 16 ; size
	dbsprite -64,   6, $06, 0
	dbsprite -64,  -2, $05, 0
	dbsprite -40,  32, $06, 0
	dbsprite -40,  24, $05, 0
	dbsprite -48,  32, $04, 0
	dbsprite -48,  24, $03, 0
	dbsprite -56,  32, $02, 0
	dbsprite -56,  24, $01, 0
	dbsprite -64,  32, $00, 0
	dbsprite -16,   2, $06, 0
	dbsprite -16,  -6, $05, 0
	dbsprite -24,   2, $04, 0
	dbsprite -24,  -6, $03, 0
	dbsprite -32,   2, $02, 0
	dbsprite -32,  -6, $01, 0
	dbsprite -40,   2, $00, 0

.frame_14
	db 18 ; size
	dbsprite -56,   3, $0d, 0
	dbsprite -56,  -5, $0c, 0
	dbsprite -64,   3, $0b, 0
	dbsprite -64,  -5, $0a, 0
	dbsprite -32,  29, $0d, 0
	dbsprite -32,  21, $0c, 0
	dbsprite -40,  29, $0b, 0
	dbsprite -40,  21, $0a, 0
	dbsprite -48,  29, $09, 0
	dbsprite -48,  21, $08, 0
	dbsprite -56,  29, $07, 0
	dbsprite -32,  -1, $07, 0
	dbsprite  -8,  -1, $0d, 0
	dbsprite  -8,  -9, $0c, 0
	dbsprite -16,  -1, $0b, 0
	dbsprite -16,  -9, $0a, 0
	dbsprite -24,  -1, $09, 0
	dbsprite -24,  -9, $08, 0

.frame_15
	db 20 ; size
	dbsprite -48,   0, $14, 0
	dbsprite -48,  -8, $13, 0
	dbsprite -56,   0, $12, 0
	dbsprite -56,  -8, $11, 0
	dbsprite -64,   0, $10, 0
	dbsprite -64,  -8, $0f, 0
	dbsprite -24,  26, $14, 0
	dbsprite -24,  18, $13, 0
	dbsprite -32,  26, $12, 0
	dbsprite -32,  18, $11, 0
	dbsprite -40,  26, $10, 0
	dbsprite -40,  18, $0f, 0
	dbsprite -48,  26, $0e, 0
	dbsprite   0,  -4, $14, 0
	dbsprite   0, -12, $13, 0
	dbsprite  -8,  -4, $12, 0
	dbsprite  -8, -12, $11, 0
	dbsprite -16,  -4, $10, 0
	dbsprite -16, -12, $0f, 0
	dbsprite -24,  -4, $0e, 0

.frame_16
	db 29 ; size
	dbsprite -64,  27, $06, 0
	dbsprite -64,  19, $05, 0
	dbsprite -40,  -3, $06, 0
	dbsprite -40, -11, $05, 0
	dbsprite -48,  -3, $04, 0
	dbsprite -48, -11, $03, 0
	dbsprite -56,  -3, $02, 0
	dbsprite -56, -11, $01, 0
	dbsprite -64,  -3, $00, 0
	dbsprite -16,  23, $06, 0
	dbsprite -16,  15, $05, 0
	dbsprite -24,  23, $04, 0
	dbsprite -24,  15, $03, 0
	dbsprite -32,  23, $02, 0
	dbsprite -32,  15, $01, 0
	dbsprite -40,  23, $00, 0
	dbsprite -16,  -7, $00, 0
	dbsprite   8,   0, $1c, 1
	dbsprite   8,  -8, $1b, 1
	dbsprite   8, -16, $1a, 1
	dbsprite   8, -24, $19, 1
	dbsprite   0,   0, $18, 1
	dbsprite   0,  -8, $17, 1
	dbsprite   0, -16, $16, 1
	dbsprite   0, -24, $15, 1
	dbsprite   0,  -7, $04, 0
	dbsprite   0, -15, $03, 0
	dbsprite  -8,  -7, $02, 0
	dbsprite  -8, -15, $01, 0

.frame_17
	db 33 ; size
	dbsprite -56,  24, $0d, 0
	dbsprite -56,  16, $0c, 0
	dbsprite -64,  24, $0b, 0
	dbsprite -64,  16, $0a, 0
	dbsprite -32,  20, $07, 0
	dbsprite  -8,  20, $0d, 0
	dbsprite  -8,  12, $0c, 0
	dbsprite -16,  20, $0b, 0
	dbsprite -16,  12, $0a, 0
	dbsprite -24,  20, $09, 0
	dbsprite -24,  12, $08, 0
	dbsprite -56,  -6, $07, 0
	dbsprite -32,  -6, $0d, 0
	dbsprite -32, -14, $0c, 0
	dbsprite -40,  -6, $0b, 0
	dbsprite -40, -14, $0a, 0
	dbsprite -48,  -6, $09, 0
	dbsprite -48, -14, $08, 0
	dbsprite  16,   0, $28, 1
	dbsprite  16,  -8, $27, 1
	dbsprite  16, -16, $26, 1
	dbsprite  16, -24, $25, 1
	dbsprite   8,   0, $24, 1
	dbsprite   8,  -8, $23, 1
	dbsprite   8, -16, $22, 1
	dbsprite   8, -24, $21, 1
	dbsprite   0,   0, $20, 1
	dbsprite   0,  -8, $1f, 1
	dbsprite   0, -16, $1e, 1
	dbsprite   0, -24, $1d, 1
	dbsprite  -8, -10, $07, 0
	dbsprite   0, -10, $09, 0
	dbsprite   0, -18, $08, 0

.frame_18
	db 31 ; size
	dbsprite -48,  21, $14, 0
	dbsprite -48,  13, $13, 0
	dbsprite -56,  21, $12, 0
	dbsprite -56,  13, $11, 0
	dbsprite -64,  21, $10, 0
	dbsprite -64,  13, $0f, 0
	dbsprite -24,  -9, $14, 0
	dbsprite -24, -17, $13, 0
	dbsprite -32,  -9, $12, 0
	dbsprite -32, -17, $11, 0
	dbsprite -40,  -9, $10, 0
	dbsprite -40, -17, $0f, 0
	dbsprite -48,  -9, $0e, 0
	dbsprite   0,  24, $1c, 1
	dbsprite   0,  16, $1b, 1
	dbsprite   0,   8, $1a, 1
	dbsprite   0,   0, $19, 1
	dbsprite  -8,  24, $18, 1
	dbsprite  -8,  16, $17, 1
	dbsprite  -8,   8, $16, 1
	dbsprite  -8,   0, $15, 1
	dbsprite  -8,  17, $12, 0
	dbsprite  -8,   9, $11, 0
	dbsprite -16,  17, $10, 0
	dbsprite -16,   9, $0f, 0
	dbsprite -24,  17, $0e, 0
	dbsprite  13, -18, $2a, 1 | OAM_YFLIP
	dbsprite  12,  -1, $2a, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite  -4, -26, $2a, 1
	dbsprite   0,   0, $29, 1 | OAM_XFLIP
	dbsprite   6, -25, $29, 1 | OAM_YFLIP

.frame_19
	db 34 ; size
	dbsprite -40,  18, $06, 0
	dbsprite -40,  10, $05, 0
	dbsprite -48,  18, $04, 0
	dbsprite -48,  10, $03, 0
	dbsprite -56,  18, $02, 0
	dbsprite -56,  10, $01, 0
	dbsprite -64,  18, $00, 0
	dbsprite -16, -12, $06, 0
	dbsprite -16, -20, $05, 0
	dbsprite -24, -12, $04, 0
	dbsprite -24, -20, $03, 0
	dbsprite -32, -12, $02, 0
	dbsprite -32, -20, $01, 0
	dbsprite -40, -12, $00, 0
	dbsprite   8,  24, $28, 1
	dbsprite   8,  16, $27, 1
	dbsprite   8,   8, $26, 1
	dbsprite   8,   0, $25, 1
	dbsprite   0,  24, $24, 1
	dbsprite   0,  16, $23, 1
	dbsprite   0,   8, $22, 1
	dbsprite   0,   0, $21, 1
	dbsprite  -8,  24, $20, 1
	dbsprite  -8,  16, $1f, 1
	dbsprite  -8,   8, $1e, 1
	dbsprite  -8,   0, $1d, 1
	dbsprite  -8,  14, $02, 0
	dbsprite  -8,   6, $01, 0
	dbsprite -16,  14, $00, 0
	dbsprite  20, -25, $2a, 0 | OAM_YFLIP
	dbsprite  18,   6, $2a, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite  -9, -32, $2a, 0
	dbsprite  -3,   7, $29, 0 | OAM_XFLIP
	dbsprite   8, -32, $29, 0 | OAM_YFLIP

.frame_20
	db 25 ; size
	dbsprite -56,  15, $07, 0
	dbsprite -32,  15, $0d, 0
	dbsprite -32,   7, $0c, 0
	dbsprite -40,  15, $0b, 0
	dbsprite -40,   7, $0a, 0
	dbsprite -48,  15, $09, 0
	dbsprite -48,   7, $08, 0
	dbsprite  -8,  -8, $1c, 1
	dbsprite  -8, -16, $1b, 1
	dbsprite  -8, -24, $1a, 1
	dbsprite  -8, -32, $19, 1
	dbsprite -16,  -8, $18, 1
	dbsprite -16, -16, $17, 1
	dbsprite -16, -24, $16, 1
	dbsprite -16, -32, $15, 1
	dbsprite -32, -15, $07, 0
	dbsprite -16, -15, $0b, 0
	dbsprite -16, -23, $0a, 0
	dbsprite -24, -15, $09, 0
	dbsprite -24, -23, $08, 0
	dbsprite   5,   6, $2a, 1 | OAM_YFLIP
	dbsprite   4,  23, $2a, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite -12,  -2, $2a, 1
	dbsprite  -8,  24, $29, 1 | OAM_XFLIP
	dbsprite  -2,  -1, $29, 1 | OAM_YFLIP

.frame_21
	db 27 ; size
	dbsprite -24,  12, $14, 0
	dbsprite -24,   4, $13, 0
	dbsprite -32,  12, $12, 0
	dbsprite -32,   4, $11, 0
	dbsprite -40,  12, $10, 0
	dbsprite -40,   4, $0f, 0
	dbsprite -48,  12, $0e, 0
	dbsprite   0,  -8, $28, 1
	dbsprite   0, -16, $27, 1
	dbsprite   0, -24, $26, 1
	dbsprite   0, -32, $25, 1
	dbsprite  -8,  -8, $24, 1
	dbsprite  -8, -16, $23, 1
	dbsprite  -8, -24, $22, 1
	dbsprite  -8, -32, $21, 1
	dbsprite -16,  -8, $20, 1
	dbsprite -16, -16, $1f, 1
	dbsprite -16, -24, $1e, 1
	dbsprite -16, -32, $1d, 1
	dbsprite -16, -18, $10, 0
	dbsprite -16, -26, $0f, 0
	dbsprite -24, -18, $0e, 0
	dbsprite  12,  -1, $2a, 0 | OAM_YFLIP
	dbsprite  10,  30, $2a, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite -17,  -8, $2a, 0
	dbsprite -11,  31, $29, 0 | OAM_XFLIP
	dbsprite   0,  -8, $29, 0 | OAM_YFLIP

.frame_22
	db 18 ; size
	dbsprite -16,  16, $1c, 1
	dbsprite -16,   8, $1b, 1
	dbsprite -16,   0, $1a, 1
	dbsprite -16,  -8, $19, 1
	dbsprite -24,  16, $18, 1
	dbsprite -24,   8, $17, 1
	dbsprite -24,   0, $16, 1
	dbsprite -24,  -8, $15, 1
	dbsprite -24,   9, $04, 0
	dbsprite -24,   1, $03, 0
	dbsprite -32,   9, $02, 0
	dbsprite -32,   1, $01, 0
	dbsprite -40,   9, $00, 0
	dbsprite  -3, -26, $2a, 1 | OAM_YFLIP
	dbsprite  -4,  -9, $2a, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite -20, -34, $2a, 1
	dbsprite -16,  -8, $29, 1 | OAM_XFLIP
	dbsprite -10, -33, $29, 1 | OAM_YFLIP

.frame_23
	db 20 ; size
	dbsprite  -8,  16, $28, 1
	dbsprite  -8,   8, $27, 1
	dbsprite  -8,   0, $26, 1
	dbsprite  -8,  -8, $25, 1
	dbsprite -16,  16, $24, 1
	dbsprite -16,   8, $23, 1
	dbsprite -16,   0, $22, 1
	dbsprite -16,  -8, $21, 1
	dbsprite -24,  16, $20, 1
	dbsprite -24,   8, $1f, 1
	dbsprite -24,   0, $1e, 1
	dbsprite -24,  -8, $1d, 1
	dbsprite -32,   6, $07, 0
	dbsprite -24,   6, $09, 0
	dbsprite -24,  -2, $08, 0
	dbsprite   4, -33, $2a, 0 | OAM_YFLIP
	dbsprite   2,  -2, $2a, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite -25, -40, $2a, 0
	dbsprite -19,  -1, $29, 0 | OAM_XFLIP
	dbsprite  -8, -40, $29, 0 | OAM_YFLIP

OAMData3C::
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
	dbsprite   9,  -1, $05, 0 | OAM_XFLIP
	dbsprite   9,  -7, $05, 0

.frame_1
	db 6 ; size
	dbsprite   1,  -3, $04, 1 | OAM_XFLIP
	dbsprite   1,   5, $03, 1 | OAM_XFLIP
	dbsprite   9,  -1, $05, 0 | OAM_XFLIP
	dbsprite   1,  -5, $04, 1
	dbsprite   1, -13, $03, 1
	dbsprite   9,  -7, $05, 0

.frame_2
	db 12 ; size
	dbsprite  -8,   1, $02, 2
	dbsprite  -8,  -7, $01, 2
	dbsprite  -8, -15, $00, 2
	dbsprite  -8,  -9, $02, 2 | OAM_XFLIP
	dbsprite  -8,  -1, $01, 2 | OAM_XFLIP
	dbsprite  -8,   7, $00, 2 | OAM_XFLIP
	dbsprite   1,  -3, $04, 1 | OAM_XFLIP
	dbsprite   1,   5, $03, 1 | OAM_XFLIP
	dbsprite   9,  -1, $05, 0 | OAM_XFLIP
	dbsprite   1,  -5, $04, 1
	dbsprite   1, -13, $03, 1
	dbsprite   9,  -7, $05, 0

.frame_3
	db 14 ; size
	dbsprite  11,   1, $0b, 0 | OAM_XFLIP
	dbsprite -18,  -7, $02, 0 | OAM_XFLIP
	dbsprite -18,   1, $01, 0 | OAM_XFLIP
	dbsprite -18,   9, $00, 0 | OAM_XFLIP
	dbsprite  -9,  -1, $04, 2 | OAM_XFLIP
	dbsprite  -9,   7, $03, 2 | OAM_XFLIP
	dbsprite  -1,   1, $05, 1 | OAM_XFLIP
	dbsprite  11,  -9, $0b, 0
	dbsprite -18,  -1, $02, 0
	dbsprite -18,  -9, $01, 0
	dbsprite -18, -17, $00, 0
	dbsprite  -9,  -7, $04, 2
	dbsprite  -9, -15, $03, 2
	dbsprite  -1,  -9, $05, 1

.frame_4
	db 18 ; size
	dbsprite   4,   0, $0a, 1 | OAM_XFLIP
	dbsprite   4,   8, $09, 1 | OAM_XFLIP
	dbsprite -28,  -5, $02, 1 | OAM_XFLIP
	dbsprite -28,   3, $01, 1 | OAM_XFLIP
	dbsprite -28,  11, $00, 1 | OAM_XFLIP
	dbsprite -19,   1, $04, 0 | OAM_XFLIP
	dbsprite -19,   9, $03, 0 | OAM_XFLIP
	dbsprite -11,   3, $05, 2 | OAM_XFLIP
	dbsprite  11,   1, $0b, 0 | OAM_XFLIP
	dbsprite   4,  -8, $0a, 1
	dbsprite   4, -16, $09, 1
	dbsprite -28,  -3, $02, 1
	dbsprite -28, -11, $01, 1
	dbsprite -28, -19, $00, 1
	dbsprite -19,  -9, $04, 0
	dbsprite -19, -17, $03, 0
	dbsprite -11, -11, $05, 2
	dbsprite  11,  -9, $0b, 0

.frame_5
	db 24 ; size
	dbsprite   0,  16, $08, 2 | OAM_XFLIP
	dbsprite  -8,   8, $07, 2 | OAM_XFLIP
	dbsprite  -8,  16, $06, 2 | OAM_XFLIP
	dbsprite -38,  -3, $02, 2 | OAM_XFLIP
	dbsprite -38,   5, $01, 2 | OAM_XFLIP
	dbsprite -38,  13, $00, 2 | OAM_XFLIP
	dbsprite -29,   3, $04, 1 | OAM_XFLIP
	dbsprite -29,  11, $03, 1 | OAM_XFLIP
	dbsprite -21,   5, $05, 0 | OAM_XFLIP
	dbsprite   4,   0, $0a, 1 | OAM_XFLIP
	dbsprite   4,   8, $09, 1 | OAM_XFLIP
	dbsprite  11,   1, $0b, 0 | OAM_XFLIP
	dbsprite   0, -24, $08, 2
	dbsprite  -8, -16, $07, 2
	dbsprite  -8, -24, $06, 2
	dbsprite -38,  -5, $02, 2
	dbsprite -38, -13, $01, 2
	dbsprite -38, -21, $00, 2
	dbsprite -29, -11, $04, 1
	dbsprite -29, -19, $03, 1
	dbsprite -21, -13, $05, 0
	dbsprite   4,  -8, $0a, 1
	dbsprite   4, -16, $09, 1
	dbsprite  11,  -9, $0b, 0

.frame_6
	db 24 ; size
	dbsprite  -8,  22, $08, 0 | OAM_XFLIP
	dbsprite -16,  14, $07, 0 | OAM_XFLIP
	dbsprite -16,  22, $06, 0 | OAM_XFLIP
	dbsprite  -4,   6, $0a, 2 | OAM_XFLIP
	dbsprite  -4,  14, $09, 2 | OAM_XFLIP
	dbsprite   3,   7, $0b, 1 | OAM_XFLIP
	dbsprite -48,  -1, $02, 0 | OAM_XFLIP
	dbsprite -48,   7, $01, 0 | OAM_XFLIP
	dbsprite -48,  15, $00, 0 | OAM_XFLIP
	dbsprite -39,   5, $04, 2 | OAM_XFLIP
	dbsprite -39,  13, $03, 2 | OAM_XFLIP
	dbsprite -31,   7, $05, 1 | OAM_XFLIP
	dbsprite  -8, -30, $08, 0
	dbsprite -16, -22, $07, 0
	dbsprite -16, -30, $06, 0
	dbsprite  -4, -14, $0a, 2
	dbsprite  -4, -22, $09, 2
	dbsprite   3, -15, $0b, 1
	dbsprite -48,  -7, $02, 0
	dbsprite -48, -15, $01, 0
	dbsprite -48, -23, $00, 0
	dbsprite -39, -13, $04, 2
	dbsprite -39, -21, $03, 2
	dbsprite -31, -15, $05, 1

.frame_7
	db 24 ; size
	dbsprite -16,  28, $08, 1 | OAM_XFLIP
	dbsprite -24,  20, $07, 1 | OAM_XFLIP
	dbsprite -24,  28, $06, 1 | OAM_XFLIP
	dbsprite -12,  12, $0a, 0 | OAM_XFLIP
	dbsprite -12,  20, $09, 0 | OAM_XFLIP
	dbsprite  -5,  13, $0b, 2 | OAM_XFLIP
	dbsprite -58,   1, $02, 1 | OAM_XFLIP
	dbsprite -58,   9, $01, 1 | OAM_XFLIP
	dbsprite -58,  17, $00, 1 | OAM_XFLIP
	dbsprite -49,   7, $04, 0 | OAM_XFLIP
	dbsprite -49,  15, $03, 0 | OAM_XFLIP
	dbsprite -41,   9, $05, 2 | OAM_XFLIP
	dbsprite -16, -36, $08, 1
	dbsprite -24, -28, $07, 1
	dbsprite -24, -36, $06, 1
	dbsprite -12, -20, $0a, 0
	dbsprite -12, -28, $09, 0
	dbsprite  -5, -21, $0b, 2
	dbsprite -58,  -9, $02, 1
	dbsprite -58, -17, $01, 1
	dbsprite -58, -25, $00, 1
	dbsprite -49, -15, $04, 0
	dbsprite -49, -23, $03, 0
	dbsprite -41, -17, $05, 2

.frame_8
	db 24 ; size
	dbsprite -24,  34, $08, 2 | OAM_XFLIP
	dbsprite -32,  26, $07, 2 | OAM_XFLIP
	dbsprite -32,  34, $06, 2 | OAM_XFLIP
	dbsprite -20,  18, $0a, 1 | OAM_XFLIP
	dbsprite -20,  26, $09, 1 | OAM_XFLIP
	dbsprite -13,  19, $0b, 0 | OAM_XFLIP
	dbsprite -68,   3, $02, 2 | OAM_XFLIP
	dbsprite -68,  11, $01, 2 | OAM_XFLIP
	dbsprite -68,  19, $00, 2 | OAM_XFLIP
	dbsprite -59,   9, $04, 1 | OAM_XFLIP
	dbsprite -59,  17, $03, 1 | OAM_XFLIP
	dbsprite -51,  11, $05, 0 | OAM_XFLIP
	dbsprite -24, -42, $08, 2
	dbsprite -32, -34, $07, 2
	dbsprite -32, -42, $06, 2
	dbsprite -20, -26, $0a, 1
	dbsprite -20, -34, $09, 1
	dbsprite -13, -27, $0b, 0
	dbsprite -68, -11, $02, 2
	dbsprite -68, -19, $01, 2
	dbsprite -68, -27, $00, 2
	dbsprite -59, -17, $04, 1
	dbsprite -59, -25, $03, 1
	dbsprite -51, -19, $05, 0

.frame_9
	db 18 ; size
	dbsprite -32,  40, $08, 0 | OAM_XFLIP
	dbsprite -40,  32, $07, 0 | OAM_XFLIP
	dbsprite -40,  40, $06, 0 | OAM_XFLIP
	dbsprite -28,  24, $0a, 2 | OAM_XFLIP
	dbsprite -28,  32, $09, 2 | OAM_XFLIP
	dbsprite -21,  25, $0b, 1 | OAM_XFLIP
	dbsprite -69,  11, $04, 2 | OAM_XFLIP
	dbsprite -69,  19, $03, 2 | OAM_XFLIP
	dbsprite -61,  13, $05, 1 | OAM_XFLIP
	dbsprite -32, -48, $08, 0
	dbsprite -40, -40, $07, 0
	dbsprite -40, -48, $06, 0
	dbsprite -28, -32, $0a, 2
	dbsprite -28, -40, $09, 2
	dbsprite -21, -33, $0b, 1
	dbsprite -69, -19, $04, 2
	dbsprite -69, -27, $03, 2
	dbsprite -61, -21, $05, 1

.frame_10
	db 14 ; size
	dbsprite -40,  46, $08, 1 | OAM_XFLIP
	dbsprite -48,  38, $07, 1 | OAM_XFLIP
	dbsprite -48,  46, $06, 1 | OAM_XFLIP
	dbsprite -36,  30, $0a, 0 | OAM_XFLIP
	dbsprite -36,  38, $09, 0 | OAM_XFLIP
	dbsprite -29,  31, $0b, 2 | OAM_XFLIP
	dbsprite -71,  15, $05, 2 | OAM_XFLIP
	dbsprite -40, -54, $08, 1
	dbsprite -48, -46, $07, 1
	dbsprite -48, -54, $06, 1
	dbsprite -36, -38, $0a, 0
	dbsprite -36, -46, $09, 0
	dbsprite -29, -39, $0b, 2
	dbsprite -71, -23, $05, 2

.frame_11
	db 12 ; size
	dbsprite -48,  52, $08, 2 | OAM_XFLIP
	dbsprite -56,  44, $07, 2 | OAM_XFLIP
	dbsprite -56,  52, $06, 2 | OAM_XFLIP
	dbsprite -44,  36, $0a, 1 | OAM_XFLIP
	dbsprite -44,  44, $09, 1 | OAM_XFLIP
	dbsprite -37,  37, $0b, 0 | OAM_XFLIP
	dbsprite -48, -60, $08, 2
	dbsprite -56, -52, $07, 2
	dbsprite -56, -60, $06, 2
	dbsprite -44, -44, $0a, 1
	dbsprite -44, -52, $09, 1
	dbsprite -37, -45, $0b, 0

.frame_12
	db 12 ; size
	dbsprite -56,  58, $08, 0 | OAM_XFLIP
	dbsprite -64,  50, $07, 0 | OAM_XFLIP
	dbsprite -64,  58, $06, 0 | OAM_XFLIP
	dbsprite -52,  42, $0a, 2 | OAM_XFLIP
	dbsprite -52,  50, $09, 2 | OAM_XFLIP
	dbsprite -45,  43, $0b, 1 | OAM_XFLIP
	dbsprite -56, -66, $08, 0
	dbsprite -64, -58, $07, 0
	dbsprite -64, -66, $06, 0
	dbsprite -52, -50, $0a, 2
	dbsprite -52, -58, $09, 2
	dbsprite -45, -51, $0b, 1

.frame_13
	db 12 ; size
	dbsprite -64,  64, $08, 1 | OAM_XFLIP
	dbsprite -72,  56, $07, 1 | OAM_XFLIP
	dbsprite -72,  64, $06, 1 | OAM_XFLIP
	dbsprite -60,  48, $0a, 0 | OAM_XFLIP
	dbsprite -60,  56, $09, 0 | OAM_XFLIP
	dbsprite -53,  49, $0b, 2 | OAM_XFLIP
	dbsprite -64, -72, $08, 1
	dbsprite -72, -64, $07, 1
	dbsprite -72, -72, $06, 1
	dbsprite -60, -56, $0a, 0
	dbsprite -60, -64, $09, 0
	dbsprite -53, -57, $0b, 2

.frame_14
	db 8 ; size
	dbsprite -72,  70, $08, 2 | OAM_XFLIP
	dbsprite -68,  54, $0a, 1 | OAM_XFLIP
	dbsprite -68,  62, $09, 1 | OAM_XFLIP
	dbsprite -61,  55, $0b, 0 | OAM_XFLIP
	dbsprite -72, -78, $08, 2
	dbsprite -68, -62, $0a, 1
	dbsprite -68, -70, $09, 1
	dbsprite -61, -63, $0b, 0

.frame_15
	db 2 ; size
	dbsprite -69,  61, $0b, 1 | OAM_XFLIP
	dbsprite -69, -69, $0b, 1

OAMData3D::
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
	db 4 ; size
	dbsprite -64,   3, $03, 1
	dbsprite -64,  -4, $02, 0
	dbsprite -64, -11, $01, 1
	dbsprite -56,  -4, $00, 0

.frame_1
	db 13 ; size
	dbsprite -40,   3, $03, 1 | OAM_YFLIP
	dbsprite -40,  -4, $02, 0 | OAM_YFLIP
	dbsprite -40, -11, $01, 1 | OAM_YFLIP
	dbsprite -48,   3, $03, 1 | OAM_YFLIP
	dbsprite -48,  -4, $02, 0 | OAM_YFLIP
	dbsprite -48, -11, $01, 1 | OAM_YFLIP
	dbsprite -56,   3, $03, 1 | OAM_YFLIP
	dbsprite -56,  -4, $02, 0 | OAM_YFLIP
	dbsprite -56, -11, $01, 1 | OAM_YFLIP
	dbsprite -64,   3, $03, 1 | OAM_YFLIP
	dbsprite -64,  -4, $02, 0 | OAM_YFLIP
	dbsprite -64, -11, $01, 1 | OAM_YFLIP
	dbsprite -32,  -4, $00, 0

.frame_2
	db 22 ; size
	dbsprite -64,   3, $03, 1
	dbsprite -64,  -4, $02, 0
	dbsprite -64, -11, $01, 1
	dbsprite -56,   3, $03, 1
	dbsprite -56,  -4, $02, 0
	dbsprite -56, -11, $01, 1
	dbsprite -48,   3, $03, 1
	dbsprite -48,  -4, $02, 0
	dbsprite -48, -11, $01, 1
	dbsprite -40,   3, $03, 1
	dbsprite -40,  -4, $02, 0
	dbsprite -40, -11, $01, 1
	dbsprite -32,   3, $03, 1
	dbsprite -32,  -4, $02, 0
	dbsprite -32, -11, $01, 1
	dbsprite -24,   3, $03, 1
	dbsprite -24,  -4, $02, 0
	dbsprite -24, -11, $01, 1
	dbsprite -16,   3, $03, 1
	dbsprite -16,  -4, $02, 0
	dbsprite -16, -11, $01, 1
	dbsprite  -8,  -4, $00, 0

.frame_3
	db 27 ; size
	dbsprite -64,   3, $03, 1 | OAM_YFLIP
	dbsprite -64,  -4, $02, 0 | OAM_YFLIP
	dbsprite -64, -11, $01, 1 | OAM_YFLIP
	dbsprite   0,   4, $08, 2
	dbsprite   0,  -4, $07, 2
	dbsprite   0, -12, $06, 2
	dbsprite  -8,   4, $05, 2
	dbsprite  -8, -12, $04, 2
	dbsprite  -8,  -4, $02, 0 | OAM_YFLIP
	dbsprite -56,   3, $03, 1 | OAM_YFLIP
	dbsprite -56,  -4, $02, 0 | OAM_YFLIP
	dbsprite -56, -11, $01, 1 | OAM_YFLIP
	dbsprite -16,   3, $03, 1 | OAM_YFLIP
	dbsprite -16,  -4, $02, 0 | OAM_YFLIP
	dbsprite -16, -11, $01, 1 | OAM_YFLIP
	dbsprite -24,   3, $03, 1 | OAM_YFLIP
	dbsprite -24,  -4, $02, 0 | OAM_YFLIP
	dbsprite -24, -11, $01, 1 | OAM_YFLIP
	dbsprite -32,   3, $03, 1 | OAM_YFLIP
	dbsprite -32,  -4, $02, 0 | OAM_YFLIP
	dbsprite -32, -11, $01, 1 | OAM_YFLIP
	dbsprite -40,   3, $03, 1 | OAM_YFLIP
	dbsprite -40,  -4, $02, 0 | OAM_YFLIP
	dbsprite -40, -11, $01, 1 | OAM_YFLIP
	dbsprite -48,   3, $03, 1 | OAM_YFLIP
	dbsprite -48,  -4, $02, 0 | OAM_YFLIP
	dbsprite -48, -11, $01, 1 | OAM_YFLIP

.frame_4
	db 27 ; size
	dbsprite -56,   3, $03, 1
	dbsprite -56,  -4, $02, 0
	dbsprite -56, -11, $01, 1
	dbsprite -64,  -4, $19, 0
	dbsprite   0, -12, $08, 2 | OAM_XFLIP
	dbsprite   0,  -4, $07, 2 | OAM_XFLIP
	dbsprite   0,   4, $06, 2 | OAM_XFLIP
	dbsprite  -8, -12, $05, 2 | OAM_XFLIP
	dbsprite  -8,   4, $04, 2 | OAM_XFLIP
	dbsprite  -8,  -4, $02, 0
	dbsprite -16,   3, $03, 1
	dbsprite -16,  -4, $02, 0
	dbsprite -16, -11, $01, 1
	dbsprite -64,   3, $03, 1
	dbsprite -64, -11, $01, 1
	dbsprite -48,   3, $03, 1
	dbsprite -48,  -4, $02, 0
	dbsprite -48, -11, $01, 1
	dbsprite -40,   3, $03, 1
	dbsprite -40,  -4, $02, 0
	dbsprite -40, -11, $01, 1
	dbsprite -32,   3, $03, 1
	dbsprite -32,  -4, $02, 0
	dbsprite -32, -11, $01, 1
	dbsprite -24,   3, $03, 1
	dbsprite -24,  -4, $02, 0
	dbsprite -24, -11, $01, 1

.frame_5
	db 38 ; size
	dbsprite -32,   3, $03, 1 | OAM_YFLIP
	dbsprite -32,  -4, $02, 0 | OAM_YFLIP
	dbsprite -32, -11, $01, 1 | OAM_YFLIP
	dbsprite -40,   3, $03, 1 | OAM_YFLIP
	dbsprite -40,  -4, $02, 0 | OAM_YFLIP
	dbsprite -40, -11, $01, 1 | OAM_YFLIP
	dbsprite -56,  -4, $1a, 1 | OAM_YFLIP
	dbsprite -64,  -4, $1a, 1 | OAM_YFLIP
	dbsprite -48,  -4, $19, 0 | OAM_YFLIP
	dbsprite   8,   4, $18, 2
	dbsprite   8,  -4, $17, 2
	dbsprite   8, -12, $16, 2
	dbsprite   0,  12, $15, 2
	dbsprite   0,   4, $14, 2
	dbsprite   0,  -4, $13, 2
	dbsprite   0, -12, $12, 2
	dbsprite   0, -20, $11, 2
	dbsprite  -8,  12, $10, 2
	dbsprite  -8,   4, $0f, 2
	dbsprite  -8, -12, $0e, 2
	dbsprite  -8, -20, $0d, 2
	dbsprite -16,  12, $0c, 2
	dbsprite -16,   4, $0b, 2
	dbsprite -16, -12, $0a, 2
	dbsprite -16, -20, $09, 2
	dbsprite  -8,  -4, $02, 0 | OAM_YFLIP
	dbsprite -16,   3, $03, 1 | OAM_YFLIP
	dbsprite -16,  -4, $02, 0 | OAM_YFLIP
	dbsprite -16, -11, $01, 1 | OAM_YFLIP
	dbsprite -24,   3, $03, 1 | OAM_YFLIP
	dbsprite -24,  -4, $02, 0 | OAM_YFLIP
	dbsprite -24, -11, $01, 1 | OAM_YFLIP
	dbsprite -48,   3, $03, 1 | OAM_YFLIP
	dbsprite -48, -11, $01, 1 | OAM_YFLIP
	dbsprite -56,   3, $03, 1 | OAM_YFLIP
	dbsprite -56, -11, $01, 1 | OAM_YFLIP
	dbsprite -64,   4, $03, 1 | OAM_YFLIP
	dbsprite -64, -11, $01, 1 | OAM_YFLIP

.frame_6
	db 37 ; size
	dbsprite -16,   3, $03, 1
	dbsprite -16,  -4, $02, 0
	dbsprite -16, -11, $01, 1
	dbsprite -40,  -4, $1a, 1
	dbsprite -48,  -4, $1a, 1
	dbsprite -56,  -4, $1a, 1
	dbsprite -32,  -4, $19, 0
	dbsprite   8, -12, $18, 2 | OAM_XFLIP
	dbsprite   8,  -4, $17, 2 | OAM_XFLIP
	dbsprite   8,   4, $16, 2 | OAM_XFLIP
	dbsprite   0, -20, $15, 2 | OAM_XFLIP
	dbsprite   0, -12, $14, 2 | OAM_XFLIP
	dbsprite   0,  -4, $13, 2 | OAM_XFLIP
	dbsprite   0,   4, $12, 2 | OAM_XFLIP
	dbsprite   0,  12, $11, 2 | OAM_XFLIP
	dbsprite  -8, -20, $10, 2 | OAM_XFLIP
	dbsprite  -8, -12, $0f, 2 | OAM_XFLIP
	dbsprite  -8,   4, $0e, 2 | OAM_XFLIP
	dbsprite  -8,  12, $0d, 2 | OAM_XFLIP
	dbsprite -16, -20, $0c, 2 | OAM_XFLIP
	dbsprite -16, -12, $0b, 2 | OAM_XFLIP
	dbsprite -16,   4, $0a, 2 | OAM_XFLIP
	dbsprite -16,  12, $09, 2 | OAM_XFLIP
	dbsprite -64,   6, $03, 1
	dbsprite -56, -12, $01, 1
	dbsprite -56,   4, $03, 1
	dbsprite -64, -13, $01, 1
	dbsprite  -8,  -4, $02, 0
	dbsprite -24,   3, $03, 1
	dbsprite -24,  -4, $02, 0
	dbsprite -24, -11, $01, 1
	dbsprite -32,   3, $03, 1
	dbsprite -32, -11, $01, 1
	dbsprite -40,   3, $03, 1
	dbsprite -40, -11, $01, 1
	dbsprite -48,   4, $03, 1
	dbsprite -48, -11, $01, 1

.frame_7
	db 32 ; size
	dbsprite -59, -15, $01, 1 | OAM_YFLIP
	dbsprite -40,  -4, $1a, 1 | OAM_YFLIP
	dbsprite -48,   6, $03, 1 | OAM_YFLIP
	dbsprite -40, -12, $01, 1 | OAM_YFLIP
	dbsprite -40,   4, $03, 1 | OAM_YFLIP
	dbsprite -48, -13, $01, 1 | OAM_YFLIP
	dbsprite -24,  -4, $1a, 1 | OAM_YFLIP
	dbsprite -32,  -4, $1a, 1 | OAM_YFLIP
	dbsprite -16,  -4, $19, 0 | OAM_YFLIP
	dbsprite   8,   4, $18, 2
	dbsprite   8,  -4, $17, 2
	dbsprite   8, -12, $16, 2
	dbsprite   0,  12, $15, 2
	dbsprite   0,   4, $14, 2
	dbsprite   0,  -4, $13, 2
	dbsprite   0, -12, $12, 2
	dbsprite   0, -20, $11, 2
	dbsprite  -8,  12, $10, 2
	dbsprite  -8,   4, $0f, 2
	dbsprite  -8, -12, $0e, 2
	dbsprite  -8, -20, $0d, 2
	dbsprite -16,  12, $0c, 2
	dbsprite -16,   4, $0b, 2
	dbsprite -16, -12, $0a, 2
	dbsprite -16, -20, $09, 2
	dbsprite  -8,  -4, $02, 0 | OAM_YFLIP
	dbsprite -16,   3, $03, 1 | OAM_YFLIP
	dbsprite -16, -11, $01, 1 | OAM_YFLIP
	dbsprite -24,   3, $03, 1 | OAM_YFLIP
	dbsprite -24, -11, $01, 1 | OAM_YFLIP
	dbsprite -32,   4, $03, 1 | OAM_YFLIP
	dbsprite -32, -11, $01, 1 | OAM_YFLIP

.frame_8
	db 23 ; size
	dbsprite   4,   8, $26, 2
	dbsprite   4,   0, $25, 2
	dbsprite   4,  -8, $24, 2
	dbsprite   4, -16, $23, 2
	dbsprite  -4,   8, $22, 2
	dbsprite  -4,   0, $21, 1
	dbsprite  -4,  -8, $20, 1
	dbsprite  -4, -16, $1f, 2
	dbsprite -12,   8, $1e, 2
	dbsprite -12,   0, $1d, 2
	dbsprite -12,  -8, $1c, 2
	dbsprite -12, -16, $1b, 2
	dbsprite  -8,  -4, $1a, 1
	dbsprite -16,  -4, $1a, 1
	dbsprite -24,  -4, $1a, 1
	dbsprite -16, -11, $01, 1
	dbsprite -16,   3, $03, 1
	dbsprite  -8, -11, $01, 1
	dbsprite -42,   5, $03, 1
	dbsprite -32,   4, $03, 1
	dbsprite -33, -13, $01, 1
	dbsprite -24,   4, $03, 1
	dbsprite -24, -12, $01, 1

.frame_9
	db 16 ; size
	dbsprite  -8,  -4, $1a, 1
	dbsprite -26,   6, $03, 1
	dbsprite -27, -15, $01, 1
	dbsprite -16,   4, $03, 1
	dbsprite -17, -13, $01, 1
	dbsprite  -8, -12, $01, 1
	dbsprite   4,   4, $30, 1
	dbsprite   4,  -4, $2f, 1
	dbsprite   4, -12, $2e, 1
	dbsprite  -4,   4, $2d, 1
	dbsprite  -4,  -4, $2c, 1
	dbsprite  -4, -12, $2b, 1
	dbsprite  -4, -20, $2a, 1
	dbsprite -12,   4, $29, 1
	dbsprite -12,  -4, $28, 1
	dbsprite -12, -12, $27, 1

.frame_10
	db 9 ; size
	dbsprite   6,   5, $30, 1
	dbsprite   6,  -4, $2f, 1
	dbsprite   7, -12, $2e, 1
	dbsprite  -4,   8, $2d, 1
	dbsprite  -4, -15, $2b, 1
	dbsprite  -4, -23, $2a, 1
	dbsprite -14,   5, $29, 1
	dbsprite -14,  -6, $28, 1
	dbsprite -14, -14, $27, 1

OAMData3E::
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
	db 7 ; size
	dbsprite -64,   2, $01, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite -72,  -4, $02, 0
	dbsprite -72,  -9, $01, 1
	dbsprite -72,   2, $01, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite -64,  -4, $02, 0
	dbsprite -64,  -9, $01, 1
	dbsprite -56,  -4, $00, 0

.frame_1
	db 13 ; size
	dbsprite -48,  -4, $02, 0 | OAM_YFLIP
	dbsprite -48,  -9, $01, 1 | OAM_YFLIP
	dbsprite -48,   2, $01, 1 | OAM_XFLIP
	dbsprite -56,  -4, $02, 0 | OAM_YFLIP
	dbsprite -56,  -9, $01, 1 | OAM_YFLIP
	dbsprite -56,   2, $01, 1 | OAM_XFLIP
	dbsprite -72,   2, $01, 1 | OAM_XFLIP
	dbsprite -64,  -4, $02, 0 | OAM_YFLIP
	dbsprite -64,  -9, $01, 1 | OAM_YFLIP
	dbsprite -64,   2, $01, 1 | OAM_XFLIP
	dbsprite -72,  -4, $02, 0 | OAM_YFLIP
	dbsprite -72,  -9, $01, 1 | OAM_YFLIP
	dbsprite -40,  -4, $00, 0

.frame_2
	db 19 ; size
	dbsprite -72,   2, $01, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite -72,  -4, $02, 0
	dbsprite -72,  -9, $01, 1
	dbsprite -64,   2, $01, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite -64,  -4, $02, 0
	dbsprite -64,  -9, $01, 1
	dbsprite -56,   2, $01, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite -56,  -4, $02, 0
	dbsprite -56,  -9, $01, 1
	dbsprite -48,   2, $01, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite -48,  -4, $02, 0
	dbsprite -48,  -9, $01, 1
	dbsprite -40,   2, $01, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite -40,  -4, $02, 0
	dbsprite -40,  -9, $01, 1
	dbsprite -32,   2, $01, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite -32,  -4, $02, 0
	dbsprite -32,  -9, $01, 1
	dbsprite -24,  -4, $00, 0

.frame_3
	db 25 ; size
	dbsprite -64,   2, $01, 1 | OAM_XFLIP
	dbsprite -64,  -4, $02, 0 | OAM_YFLIP
	dbsprite -64,  -9, $01, 1 | OAM_YFLIP
	dbsprite -72,   2, $01, 1 | OAM_XFLIP
	dbsprite -72,  -4, $02, 0 | OAM_YFLIP
	dbsprite -72,  -9, $01, 1 | OAM_YFLIP
	dbsprite -16,   2, $01, 1 | OAM_XFLIP
	dbsprite -16,  -4, $02, 0 | OAM_YFLIP
	dbsprite -16,  -9, $01, 1 | OAM_YFLIP
	dbsprite -24,   2, $01, 1 | OAM_XFLIP
	dbsprite -24,  -4, $02, 0 | OAM_YFLIP
	dbsprite -24,  -9, $01, 1 | OAM_YFLIP
	dbsprite -32,   2, $01, 1 | OAM_XFLIP
	dbsprite -32,  -4, $02, 0 | OAM_YFLIP
	dbsprite -32,  -9, $01, 1 | OAM_YFLIP
	dbsprite -40,   2, $01, 1 | OAM_XFLIP
	dbsprite -40,  -4, $02, 0 | OAM_YFLIP
	dbsprite -40,  -9, $01, 1 | OAM_YFLIP
	dbsprite -48,   2, $01, 1 | OAM_XFLIP
	dbsprite -48,  -4, $02, 0 | OAM_YFLIP
	dbsprite -48,  -9, $01, 1 | OAM_YFLIP
	dbsprite -56,   2, $01, 1 | OAM_XFLIP
	dbsprite -56,  -4, $02, 0 | OAM_YFLIP
	dbsprite -56,  -9, $01, 1 | OAM_YFLIP
	dbsprite  -8,  -4, $00, 0

.frame_4
	db 29 ; size
	dbsprite -48,   2, $01, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite -48,  -4, $02, 0
	dbsprite -48,  -9, $01, 1
	dbsprite   0,   0, $06, 2
	dbsprite   0,  -8, $05, 2
	dbsprite  -8,   0, $04, 2
	dbsprite  -8,  -8, $03, 2
	dbsprite -72,   3, $01, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite -72,  -4, $08, 1
	dbsprite -72, -10, $01, 1
	dbsprite -64,   2, $01, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite -64,  -4, $07, 0
	dbsprite -64,  -9, $01, 1
	dbsprite -56,   2, $01, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite -56,  -4, $02, 0
	dbsprite -56,  -9, $01, 1
	dbsprite -40,   2, $01, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite -40,  -4, $02, 0
	dbsprite -40,  -9, $01, 1
	dbsprite -32,   2, $01, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite -32,  -4, $02, 0
	dbsprite -32,  -9, $01, 1
	dbsprite -24,   2, $01, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite -24,  -4, $02, 0
	dbsprite -24,  -9, $01, 1
	dbsprite -16,   2, $01, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite -16,  -4, $02, 0
	dbsprite -16,  -9, $01, 1
	dbsprite  -8,  -4, $02, 0

.frame_5
	db 25 ; size
	dbsprite   0,  -7, $06, 2 | OAM_XFLIP
	dbsprite   0,   1, $05, 2 | OAM_XFLIP
	dbsprite  -8,  -7, $04, 2 | OAM_XFLIP
	dbsprite  -8,   1, $03, 2 | OAM_XFLIP
	dbsprite -64,   4, $01, 1 | OAM_XFLIP
	dbsprite -64, -11, $01, 1 | OAM_YFLIP
	dbsprite -56,   3, $01, 1 | OAM_XFLIP
	dbsprite -56,  -4, $08, 1 | OAM_YFLIP
	dbsprite -56, -10, $01, 1 | OAM_YFLIP
	dbsprite -48,   2, $01, 1 | OAM_XFLIP
	dbsprite -48,  -4, $07, 0 | OAM_YFLIP
	dbsprite -48,  -9, $01, 1 | OAM_YFLIP
	dbsprite -16,   2, $01, 1 | OAM_XFLIP
	dbsprite -16,  -4, $02, 0 | OAM_YFLIP
	dbsprite -16,  -9, $01, 1 | OAM_YFLIP
	dbsprite -24,   2, $01, 1 | OAM_XFLIP
	dbsprite -24,  -4, $02, 0 | OAM_YFLIP
	dbsprite -24,  -9, $01, 1 | OAM_YFLIP
	dbsprite -32,   2, $01, 1 | OAM_XFLIP
	dbsprite -32,  -4, $02, 0 | OAM_YFLIP
	dbsprite -32,  -9, $01, 1 | OAM_YFLIP
	dbsprite -40,   2, $01, 1 | OAM_XFLIP
	dbsprite -40,  -4, $02, 0 | OAM_YFLIP
	dbsprite -40,  -9, $01, 1 | OAM_YFLIP
	dbsprite  -8,  -4, $02, 0 | OAM_YFLIP

.frame_6
	db 23 ; size
	dbsprite   3, -11, $11, 2 | OAM_XFLIP
	dbsprite   3,  -3, $10, 2 | OAM_XFLIP
	dbsprite   3,   5, $0f, 2 | OAM_XFLIP
	dbsprite  -5, -11, $0e, 2 | OAM_XFLIP
	dbsprite  -5,  -3, $0d, 2 | OAM_XFLIP
	dbsprite  -5,   5, $0c, 2 | OAM_XFLIP
	dbsprite -13, -11, $0b, 2 | OAM_XFLIP
	dbsprite -13,   5, $09, 2 | OAM_XFLIP
	dbsprite -49,   4, $01, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite -49, -11, $01, 1
	dbsprite -40,   3, $01, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite -40,  -4, $08, 1
	dbsprite -40, -10, $01, 1
	dbsprite -32,   2, $01, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite -32,  -4, $07, 0
	dbsprite -32,  -9, $01, 1
	dbsprite -16,   2, $01, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite -16,  -4, $02, 0
	dbsprite -16,  -9, $01, 1
	dbsprite -24,   2, $01, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite -24,  -4, $02, 0
	dbsprite -24,  -9, $01, 1
	dbsprite  -8,  -4, $02, 0

.frame_7
	db 18 ; size
	dbsprite   3,   4, $11, 2
	dbsprite   3,  -4, $10, 2
	dbsprite   3, -12, $0f, 2
	dbsprite  -5,   4, $0e, 2
	dbsprite  -5,  -4, $0d, 2
	dbsprite  -5, -12, $0c, 2
	dbsprite -13,   4, $0b, 2
	dbsprite -13,  -4, $0a, 2
	dbsprite -13, -12, $09, 2
	dbsprite -33,   4, $01, 1 | OAM_XFLIP
	dbsprite -33, -11, $01, 1 | OAM_YFLIP
	dbsprite -24,   3, $01, 1 | OAM_XFLIP
	dbsprite -24,  -4, $08, 1 | OAM_YFLIP
	dbsprite -24, -10, $01, 1 | OAM_YFLIP
	dbsprite -16,   2, $01, 1 | OAM_XFLIP
	dbsprite -16,  -4, $07, 0 | OAM_YFLIP
	dbsprite -16,  -9, $01, 1 | OAM_YFLIP
	dbsprite  -8,  -4, $02, 0 | OAM_YFLIP

.frame_8
	db 14 ; size
	dbsprite  -8,   3, $01, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite  -8,  -4, $08, 1
	dbsprite  -8, -10, $01, 1
	dbsprite -25,   5, $01, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite -25, -12, $01, 1
	dbsprite -16,   4, $01, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite -16, -11, $01, 1
	dbsprite   0,   4, $18, 2
	dbsprite   4,  -4, $17, 2
	dbsprite   0, -12, $16, 2
	dbsprite  -8,   4, $15, 2
	dbsprite  -4,  -4, $14, 1
	dbsprite  -8, -12, $13, 2
	dbsprite -12,  -4, $12, 2

.frame_9
	db 14 ; size
	dbsprite  -8,   3, $01, 1 | OAM_XFLIP
	dbsprite -17,   4, $01, 1 | OAM_XFLIP
	dbsprite  -8, -11, $01, 1
	dbsprite -17, -12, $01, 1
	dbsprite  -8,  -4, $08, 1 | OAM_YFLIP
	dbsprite   5,   4, $21, 1
	dbsprite   5,  -4, $20, 1
	dbsprite   5, -12, $1f, 1
	dbsprite  -3,   4, $1e, 1
	dbsprite  -3,  -4, $1d, 1
	dbsprite  -3, -12, $1c, 1
	dbsprite -11,   4, $1b, 1
	dbsprite -11,  -4, $1a, 1
	dbsprite -11, -12, $19, 1

.frame_10
	db 8 ; size
	dbsprite   7,   5, $21, 1
	dbsprite   7,  -6, $20, 1
	dbsprite   7, -14, $1f, 1
	dbsprite  -3,   8, $1e, 1
	dbsprite  -3, -15, $1c, 1
	dbsprite -13,   5, $1b, 1
	dbsprite -13,  -5, $1a, 1
	dbsprite -13, -13, $19, 1

OAMData3F::
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

.frame_0
	db 24 ; size
	dbsprite   8,  16, $17, 0
	dbsprite   8,   8, $16, 0
	dbsprite   8,   0, $15, 0
	dbsprite   8,  -8, $14, 0
	dbsprite   8, -16, $13, 0
	dbsprite   8, -24, $12, 0
	dbsprite   0,  16, $11, 0
	dbsprite   0,   8, $10, 0
	dbsprite   0,   0, $0f, 0
	dbsprite   0,  -8, $0e, 0
	dbsprite   0, -16, $0d, 0
	dbsprite   0, -24, $0c, 0
	dbsprite  -8,  16, $0b, 0
	dbsprite  -8,   8, $0a, 0
	dbsprite  -8,   0, $09, 0
	dbsprite  -8,  -8, $08, 0
	dbsprite  -8, -16, $07, 0
	dbsprite  -8, -24, $06, 0
	dbsprite -16,  16, $05, 0
	dbsprite -16,   8, $04, 0
	dbsprite -16,   0, $03, 0
	dbsprite -16,  -8, $02, 0
	dbsprite -16, -16, $01, 0
	dbsprite -16, -24, $00, 0

.frame_1
	db 32 ; size
	dbsprite   9,  16, $17, 0
	dbsprite   9,   8, $16, 0
	dbsprite   9,   0, $15, 0
	dbsprite   9,  -8, $14, 0
	dbsprite   9, -16, $13, 0
	dbsprite   9, -24, $12, 0
	dbsprite   1,  16, $11, 0
	dbsprite   1,   8, $10, 0
	dbsprite   1,   0, $0f, 0
	dbsprite   1,  -8, $0e, 0
	dbsprite   1, -16, $0d, 0
	dbsprite   1, -24, $0c, 0
	dbsprite  -7,  16, $0b, 0
	dbsprite  -7,   8, $0a, 0
	dbsprite  -7,   0, $09, 0
	dbsprite  -7,  -8, $08, 0
	dbsprite  -7, -16, $07, 0
	dbsprite  -7, -24, $06, 0
	dbsprite -15,  16, $05, 0
	dbsprite -15,   8, $04, 0
	dbsprite -15,   0, $03, 0
	dbsprite -15,  -8, $02, 0
	dbsprite -15, -16, $01, 0
	dbsprite -15, -24, $00, 0
	dbsprite   1,  24, $40, 1 | OAM_XFLIP
	dbsprite   9,  24, $41, 1 | OAM_XFLIP
	dbsprite   1,  16, $3e, 1
	dbsprite   9,  16, $3f, 1
	dbsprite   1, -32, $40, 1
	dbsprite   9, -32, $41, 1
	dbsprite   1, -24, $3c, 1
	dbsprite   9, -24, $3d, 1

.frame_2
	db 32 ; size
	dbsprite   8,  16, $17, 0
	dbsprite   8,   8, $16, 0
	dbsprite   8,   0, $15, 0
	dbsprite   8,  -8, $14, 0
	dbsprite   8, -16, $13, 0
	dbsprite   8, -24, $12, 0
	dbsprite   0,  16, $11, 0
	dbsprite   0,   8, $10, 0
	dbsprite   0,   0, $0f, 0
	dbsprite   0,  -8, $0e, 0
	dbsprite   0, -16, $0d, 0
	dbsprite   0, -24, $0c, 0
	dbsprite  -8,  16, $0b, 0
	dbsprite  -8,   8, $0a, 0
	dbsprite  -8,   0, $09, 0
	dbsprite  -8,  -8, $08, 0
	dbsprite  -8, -16, $07, 0
	dbsprite  -8, -24, $06, 0
	dbsprite -16,  16, $05, 0
	dbsprite -16,   8, $04, 0
	dbsprite -16,   0, $03, 0
	dbsprite -16,  -8, $02, 0
	dbsprite -16, -16, $01, 0
	dbsprite -16, -24, $00, 0
	dbsprite   0,  24, $40, 0 | OAM_XFLIP
	dbsprite   8,  24, $41, 0 | OAM_XFLIP
	dbsprite   0,  16, $3e, 0
	dbsprite   8,  16, $3f, 0
	dbsprite   0, -32, $40, 0
	dbsprite   8, -32, $41, 0
	dbsprite   0, -24, $3c, 0
	dbsprite   8, -24, $3d, 0

.frame_3
	db 30 ; size
	dbsprite   0,  26, $42, 2
	dbsprite   8,  32, $42, 2
	dbsprite   0, -35, $42, 2 | OAM_YFLIP
	dbsprite   8, -40, $42, 2 | OAM_YFLIP
	dbsprite   8,  20, $42, 0 | OAM_YFLIP
	dbsprite   8, -28, $42, 0
	dbsprite   8,  16, $17, 0
	dbsprite   8,   8, $16, 0
	dbsprite   8,   0, $15, 0
	dbsprite   8,  -8, $14, 0
	dbsprite   8, -16, $13, 0
	dbsprite   8, -24, $12, 0
	dbsprite   0,  16, $11, 0
	dbsprite   0,   8, $10, 0
	dbsprite   0,   0, $0f, 0
	dbsprite   0,  -8, $0e, 0
	dbsprite   0, -16, $0d, 0
	dbsprite   0, -24, $0c, 0
	dbsprite  -8,  16, $0b, 0
	dbsprite  -8,   8, $0a, 0
	dbsprite  -8,   0, $09, 0
	dbsprite  -8,  -8, $08, 0
	dbsprite  -8, -16, $07, 0
	dbsprite  -8, -24, $06, 0
	dbsprite -16,  16, $05, 0
	dbsprite -16,   8, $04, 0
	dbsprite -16,   0, $03, 0
	dbsprite -16,  -8, $02, 0
	dbsprite -16, -16, $01, 0
	dbsprite -16, -24, $00, 0

.frame_4
	db 26 ; size
	dbsprite   8,  36, $42, 2 | OAM_YFLIP
	dbsprite   8, -44, $42, 2
	dbsprite   8,  16, $17, 0
	dbsprite   8,   8, $16, 0
	dbsprite   8,   0, $15, 0
	dbsprite   8,  -8, $14, 0
	dbsprite   8, -16, $13, 0
	dbsprite   8, -24, $12, 0
	dbsprite   0,  16, $11, 0
	dbsprite   0,   8, $10, 0
	dbsprite   0,   0, $0f, 0
	dbsprite   0,  -8, $0e, 0
	dbsprite   0, -16, $0d, 0
	dbsprite   0, -24, $0c, 0
	dbsprite  -8,  16, $0b, 0
	dbsprite  -8,   8, $0a, 0
	dbsprite  -8,   0, $09, 0
	dbsprite  -8,  -8, $08, 0
	dbsprite  -8, -16, $07, 0
	dbsprite  -8, -24, $06, 0
	dbsprite -16,  16, $05, 0
	dbsprite -16,   8, $04, 0
	dbsprite -16,   0, $03, 0
	dbsprite -16,  -8, $02, 0
	dbsprite -16, -16, $01, 0
	dbsprite -16, -24, $00, 0

.frame_5
	db 24 ; size
	dbsprite   8,   0, $18, 0
	dbsprite   8,  16, $17, 0
	dbsprite   8,   8, $16, 0
	dbsprite   8,  -8, $14, 0
	dbsprite   8, -16, $13, 0
	dbsprite   8, -24, $12, 0
	dbsprite   0,  16, $11, 0
	dbsprite   0,   8, $10, 0
	dbsprite   0,   0, $0f, 0
	dbsprite   0,  -8, $0e, 0
	dbsprite   0, -16, $0d, 0
	dbsprite   0, -24, $0c, 0
	dbsprite  -8,  16, $0b, 0
	dbsprite  -8,   8, $0a, 0
	dbsprite  -8,   0, $09, 0
	dbsprite  -8,  -8, $08, 0
	dbsprite  -8, -16, $07, 0
	dbsprite  -8, -24, $06, 0
	dbsprite -16,  16, $05, 0
	dbsprite -16,   8, $04, 0
	dbsprite -16,   0, $03, 0
	dbsprite -16,  -8, $02, 0
	dbsprite -16, -16, $01, 0
	dbsprite -16, -24, $00, 0

.frame_6
	db 24 ; size
	dbsprite   8,  -8, $19, 0
	dbsprite   8,   0, $18, 0
	dbsprite   8,  16, $17, 0
	dbsprite   8,   8, $16, 0
	dbsprite   8, -16, $13, 0
	dbsprite   8, -24, $12, 0
	dbsprite   0,  16, $11, 0
	dbsprite   0,   8, $10, 0
	dbsprite   0,   0, $0f, 0
	dbsprite   0,  -8, $0e, 0
	dbsprite   0, -16, $0d, 0
	dbsprite   0, -24, $0c, 0
	dbsprite  -8,  16, $0b, 0
	dbsprite  -8,   8, $0a, 0
	dbsprite  -8,   0, $09, 0
	dbsprite  -8,  -8, $08, 0
	dbsprite  -8, -16, $07, 0
	dbsprite  -8, -24, $06, 0
	dbsprite -16,  16, $05, 0
	dbsprite -16,   8, $04, 0
	dbsprite -16,   0, $03, 0
	dbsprite -16,  -8, $02, 0
	dbsprite -16, -16, $01, 0
	dbsprite -16, -24, $00, 0

.frame_7
	db 24 ; size
	dbsprite   0,   0, $1a, 0
	dbsprite   8,  -8, $19, 0
	dbsprite   8,   0, $18, 0
	dbsprite   8,  16, $17, 0
	dbsprite   8,   8, $16, 0
	dbsprite   8, -16, $13, 0
	dbsprite   8, -24, $12, 0
	dbsprite   0,  16, $11, 0
	dbsprite   0,   8, $10, 0
	dbsprite   0,  -8, $0e, 0
	dbsprite   0, -16, $0d, 0
	dbsprite   0, -24, $0c, 0
	dbsprite  -8,  16, $0b, 0
	dbsprite  -8,   8, $0a, 0
	dbsprite  -8,   0, $09, 0
	dbsprite  -8,  -8, $08, 0
	dbsprite  -8, -16, $07, 0
	dbsprite  -8, -24, $06, 0
	dbsprite -16,  16, $05, 0
	dbsprite -16,   8, $04, 0
	dbsprite -16,   0, $03, 0
	dbsprite -16,  -8, $02, 0
	dbsprite -16, -16, $01, 0
	dbsprite -16, -24, $00, 0

.frame_8
	db 24 ; size
	dbsprite   0,  -8, $1b, 0
	dbsprite   0,   0, $1a, 0
	dbsprite   8,  -8, $19, 0
	dbsprite   8,   0, $18, 0
	dbsprite   8,  16, $17, 0
	dbsprite   8,   8, $16, 0
	dbsprite   8, -16, $13, 0
	dbsprite   8, -24, $12, 0
	dbsprite   0,  16, $11, 0
	dbsprite   0,   8, $10, 0
	dbsprite   0, -16, $0d, 0
	dbsprite   0, -24, $0c, 0
	dbsprite  -8,  16, $0b, 0
	dbsprite  -8,   8, $0a, 0
	dbsprite  -8,   0, $09, 0
	dbsprite  -8,  -8, $08, 0
	dbsprite  -8, -16, $07, 0
	dbsprite  -8, -24, $06, 0
	dbsprite -16,  16, $05, 0
	dbsprite -16,   8, $04, 0
	dbsprite -16,   0, $03, 0
	dbsprite -16,  -8, $02, 0
	dbsprite -16, -16, $01, 0
	dbsprite -16, -24, $00, 0

.frame_9
	db 24 ; size
	dbsprite  -8,   0, $1c, 0
	dbsprite   0,  -8, $1b, 0
	dbsprite   0,   0, $1a, 0
	dbsprite   8,  -8, $19, 0
	dbsprite   8,   0, $18, 0
	dbsprite   8,  16, $17, 0
	dbsprite   8,   8, $16, 0
	dbsprite   8, -16, $13, 0
	dbsprite   8, -24, $12, 0
	dbsprite   0,  16, $11, 0
	dbsprite   0,   8, $10, 0
	dbsprite   0, -16, $0d, 0
	dbsprite   0, -24, $0c, 0
	dbsprite  -8,  16, $0b, 0
	dbsprite  -8,   8, $0a, 0
	dbsprite  -8,  -8, $08, 0
	dbsprite  -8, -16, $07, 0
	dbsprite  -8, -24, $06, 0
	dbsprite -16,  16, $05, 0
	dbsprite -16,   8, $04, 0
	dbsprite -16,   0, $03, 0
	dbsprite -16,  -8, $02, 0
	dbsprite -16, -16, $01, 0
	dbsprite -16, -24, $00, 0

.frame_10
	db 24 ; size
	dbsprite  -8,  -8, $1d, 0
	dbsprite  -8,   0, $1c, 0
	dbsprite   0,  -8, $1b, 0
	dbsprite   0,   0, $1a, 0
	dbsprite   8,  -8, $19, 0
	dbsprite   8,   0, $18, 0
	dbsprite   8,  16, $17, 0
	dbsprite   8,   8, $16, 0
	dbsprite   8, -16, $13, 0
	dbsprite   8, -24, $12, 0
	dbsprite   0,  16, $11, 0
	dbsprite   0,   8, $10, 0
	dbsprite   0, -16, $0d, 0
	dbsprite   0, -24, $0c, 0
	dbsprite  -8,  16, $0b, 0
	dbsprite  -8,   8, $0a, 0
	dbsprite  -8, -16, $07, 0
	dbsprite  -8, -24, $06, 0
	dbsprite -16,  16, $05, 0
	dbsprite -16,   8, $04, 0
	dbsprite -16,   0, $03, 0
	dbsprite -16,  -8, $02, 0
	dbsprite -16, -16, $01, 0
	dbsprite -16, -24, $00, 0

.frame_11
	db 24 ; size
	dbsprite -16,   0, $1e, 0
	dbsprite  -8,  -8, $1d, 0
	dbsprite  -8,   0, $1c, 0
	dbsprite   0,  -8, $1b, 0
	dbsprite   0,   0, $1a, 0
	dbsprite   8,  -8, $19, 0
	dbsprite   8,   0, $18, 0
	dbsprite   8,  16, $17, 0
	dbsprite   8,   8, $16, 0
	dbsprite   8, -16, $13, 0
	dbsprite   8, -24, $12, 0
	dbsprite   0,  16, $11, 0
	dbsprite   0,   8, $10, 0
	dbsprite   0, -16, $0d, 0
	dbsprite   0, -24, $0c, 0
	dbsprite  -8,  16, $0b, 0
	dbsprite  -8,   8, $0a, 0
	dbsprite  -8, -16, $07, 0
	dbsprite  -8, -24, $06, 0
	dbsprite -16,  16, $05, 0
	dbsprite -16,   8, $04, 0
	dbsprite -16,  -8, $02, 0
	dbsprite -16, -16, $01, 0
	dbsprite -16, -24, $00, 0

.frame_12
	db 24 ; size
	dbsprite -16,  -8, $1f, 0
	dbsprite -16,   0, $1e, 0
	dbsprite  -8,  -8, $1d, 0
	dbsprite  -8,   0, $1c, 0
	dbsprite   0,  -8, $1b, 0
	dbsprite   0,   0, $1a, 0
	dbsprite   8,  -8, $19, 0
	dbsprite   8,   0, $18, 0
	dbsprite   8,  16, $17, 0
	dbsprite   8,   8, $16, 0
	dbsprite   8, -16, $13, 0
	dbsprite   8, -24, $12, 0
	dbsprite   0,  16, $11, 0
	dbsprite   0,   8, $10, 0
	dbsprite   0, -16, $0d, 0
	dbsprite   0, -24, $0c, 0
	dbsprite  -8,  16, $0b, 0
	dbsprite  -8,   8, $0a, 0
	dbsprite  -8, -16, $07, 0
	dbsprite  -8, -24, $06, 0
	dbsprite -16,  16, $05, 0
	dbsprite -16,   8, $04, 0
	dbsprite -16, -16, $01, 0
	dbsprite -16, -24, $00, 0

.frame_13
	db 28 ; size
	dbsprite -16,   1, $1e, 0
	dbsprite  -8,   1, $1c, 0
	dbsprite   0,   1, $1a, 0
	dbsprite   8,   1, $18, 0
	dbsprite   8,  17, $17, 0
	dbsprite   8,   9, $16, 0
	dbsprite   0,  17, $11, 0
	dbsprite   0,   9, $10, 0
	dbsprite  -8,  17, $0b, 0
	dbsprite  -8,   9, $0a, 0
	dbsprite -16,  17, $05, 0
	dbsprite -16,   9, $04, 0
	dbsprite -16,  -9, $1f, 0
	dbsprite  -8,  -9, $1d, 0
	dbsprite   0,  -9, $1b, 0
	dbsprite   8,  -9, $19, 0
	dbsprite   8, -17, $13, 0
	dbsprite   8, -25, $12, 0
	dbsprite   0, -17, $0d, 0
	dbsprite   0, -25, $0c, 0
	dbsprite  -8, -17, $07, 0
	dbsprite  -8, -25, $06, 0
	dbsprite -16, -17, $01, 0
	dbsprite -16, -25, $00, 0
	dbsprite   8,  -1, $23, 0
	dbsprite   0,  -1, $22, 0
	dbsprite  -8,  -1, $21, 0
	dbsprite -16,  -1, $20, 0

.frame_14
	db 24 ; size
	dbsprite   8,  16, $3b, 0
	dbsprite   8,   8, $3a, 0
	dbsprite   8,   0, $39, 0
	dbsprite   8,  -8, $38, 0
	dbsprite   8, -16, $37, 0
	dbsprite   8, -24, $36, 0
	dbsprite   0,  16, $35, 0
	dbsprite   0,   8, $34, 0
	dbsprite   0,   0, $33, 0
	dbsprite   0,  -8, $32, 0
	dbsprite   0, -16, $31, 0
	dbsprite   0, -24, $30, 0
	dbsprite  -8,  16, $2f, 0
	dbsprite  -8,   8, $2e, 0
	dbsprite  -8,   0, $2d, 0
	dbsprite  -8,  -8, $2c, 0
	dbsprite  -8, -16, $2b, 0
	dbsprite  -8, -24, $2a, 0
	dbsprite -16,  16, $29, 0
	dbsprite -16,   8, $28, 0
	dbsprite -16,   0, $27, 0
	dbsprite -16,  -8, $26, 0
	dbsprite -16, -16, $25, 0
	dbsprite -16, -24, $24, 0

OAMData40::
	dw .frame_0
	dw .frame_1
	dw .frame_2
	dw .frame_3
	dw .frame_4
	dw .frame_5
	dw .frame_6

.frame_0
	db 27 ; size
	dbsprite  11,  12, $2c, 0
	dbsprite  11,   4, $03, 0
	dbsprite  11,  -4, $02, 0
	dbsprite  11, -12, $01, 0
	dbsprite  11, -20, $00, 0
	dbsprite   3,  12, $08, 0
	dbsprite   3,   4, $07, 0
	dbsprite   3,  -4, $06, 0
	dbsprite   3, -12, $05, 0
	dbsprite   3, -20, $04, 0
	dbsprite  -5,  12, $0d, 0
	dbsprite  -5,   4, $0c, 0
	dbsprite  -5,  -4, $0b, 0
	dbsprite  -5, -12, $0a, 0
	dbsprite  -5, -20, $09, 0
	dbsprite -13,  -9, $0f, 0
	dbsprite -13, -17, $0e, 0
	dbsprite -13,   7, $11, 0
	dbsprite -13,  -1, $10, 0
	dbsprite -21,  12, $15, 0
	dbsprite -21,   4, $14, 0
	dbsprite -21,  -4, $13, 0
	dbsprite -21, -12, $12, 0
	dbsprite -29,  12, $19, 0
	dbsprite -29,   4, $18, 0
	dbsprite -29,  -4, $17, 0
	dbsprite -29, -12, $16, 0

.frame_1
	db 36 ; size
	dbsprite  12,  12, $2c, 0
	dbsprite  12,   4, $03, 0
	dbsprite  12,  -4, $02, 0
	dbsprite  12, -12, $01, 0
	dbsprite  12, -20, $00, 0
	dbsprite   4,  12, $08, 0
	dbsprite   4,   4, $07, 0
	dbsprite   4,  -4, $06, 0
	dbsprite   4, -12, $05, 0
	dbsprite   4, -20, $04, 0
	dbsprite  -4,  12, $0d, 0
	dbsprite  -4,   4, $0c, 0
	dbsprite  -4,  -4, $0b, 0
	dbsprite  -4, -12, $0a, 0
	dbsprite  -4, -20, $09, 0
	dbsprite -12,  -9, $0f, 0
	dbsprite -12, -17, $0e, 0
	dbsprite -12,   7, $11, 0
	dbsprite -12,  -1, $10, 0
	dbsprite -20,  12, $15, 0
	dbsprite -20,   4, $14, 0
	dbsprite -20,  -4, $13, 0
	dbsprite -20, -12, $12, 0
	dbsprite -28,  12, $19, 0
	dbsprite -28,   4, $18, 0
	dbsprite -28,  -4, $17, 0
	dbsprite -28, -12, $16, 0
	dbsprite   8,  20, $21, 1
	dbsprite   8, -28, $21, 1
	dbsprite  17,  12, $20, 1
	dbsprite   9,  12, $1b, 1
	dbsprite  17,   4, $1f, 1
	dbsprite  17,  -4, $1e, 1
	dbsprite  17, -12, $1d, 1
	dbsprite  17, -20, $1c, 1
	dbsprite   9, -20, $1a, 1

.frame_2
	db 36 ; size
	dbsprite  11,  12, $2c, 0
	dbsprite  11,   4, $03, 0
	dbsprite  11,  -4, $02, 0
	dbsprite  11, -12, $01, 0
	dbsprite  11, -20, $00, 0
	dbsprite   3,  12, $08, 0
	dbsprite   3,   4, $07, 0
	dbsprite   3,  -4, $06, 0
	dbsprite   3, -12, $05, 0
	dbsprite   3, -20, $04, 0
	dbsprite  -5,  12, $0d, 0
	dbsprite  -5,   4, $0c, 0
	dbsprite  -5,  -4, $0b, 0
	dbsprite  -5, -12, $0a, 0
	dbsprite  -5, -20, $09, 0
	dbsprite -13,  -9, $0f, 0
	dbsprite -13, -17, $0e, 0
	dbsprite -13,   7, $11, 0
	dbsprite -13,  -1, $10, 0
	dbsprite -21,  12, $15, 0
	dbsprite -21,   4, $14, 0
	dbsprite -21,  -4, $13, 0
	dbsprite -21, -12, $12, 0
	dbsprite -29,  12, $19, 0
	dbsprite -29,   4, $18, 0
	dbsprite -29,  -4, $17, 0
	dbsprite -29, -12, $16, 0
	dbsprite   3,  28, $21, 2
	dbsprite   4, -36, $21, 2
	dbsprite  16,  12, $20, 2
	dbsprite   8,  12, $1b, 2
	dbsprite  16,   4, $1f, 2
	dbsprite  16,  -4, $1e, 2
	dbsprite  16, -12, $1d, 2
	dbsprite  16, -20, $1c, 2
	dbsprite   8, -20, $1a, 2

.frame_3
	db 31 ; size
	dbsprite  11,  12, $2c, 0
	dbsprite  11,   4, $03, 0
	dbsprite  11,  -4, $02, 0
	dbsprite  11, -12, $01, 0
	dbsprite  11, -20, $00, 0
	dbsprite   3,  12, $08, 0
	dbsprite   3,   4, $07, 0
	dbsprite   3,  -4, $06, 0
	dbsprite   3, -12, $05, 0
	dbsprite   3, -20, $04, 0
	dbsprite  -5,  12, $0d, 0
	dbsprite  -5,   4, $0c, 0
	dbsprite  -5,  -4, $0b, 0
	dbsprite  -5, -12, $0a, 0
	dbsprite  -5, -20, $09, 0
	dbsprite -13,  -9, $0f, 0
	dbsprite -13, -17, $0e, 0
	dbsprite -13,   7, $11, 0
	dbsprite -13,  -1, $10, 0
	dbsprite -21,  12, $15, 0
	dbsprite -21,   4, $14, 0
	dbsprite -21,  -4, $13, 0
	dbsprite -21, -12, $12, 0
	dbsprite -29,  12, $19, 0
	dbsprite -29,   4, $18, 0
	dbsprite -29,  -4, $17, 0
	dbsprite -29, -12, $16, 0
	dbsprite   0,  28, $29, 2 | OAM_XFLIP
	dbsprite   8,  28, $2a, 2 | OAM_XFLIP
	dbsprite   0, -36, $29, 2
	dbsprite   8, -36, $2a, 2

.frame_4
	db 31 ; size
	dbsprite  11,  12, $2c, 0
	dbsprite  11,   4, $03, 0
	dbsprite  11,  -4, $02, 0
	dbsprite  11, -12, $01, 0
	dbsprite  11, -20, $00, 0
	dbsprite   3,  12, $08, 0
	dbsprite   3,   4, $07, 0
	dbsprite   3,  -4, $06, 0
	dbsprite   3, -12, $05, 0
	dbsprite   3, -20, $04, 0
	dbsprite  -5,  12, $0d, 0
	dbsprite  -5,   4, $0c, 0
	dbsprite  -5,  -4, $0b, 0
	dbsprite  -5, -12, $0a, 0
	dbsprite  -5, -20, $09, 0
	dbsprite -13,  -9, $0f, 0
	dbsprite -13, -17, $0e, 0
	dbsprite -13,   7, $11, 0
	dbsprite -13,  -1, $10, 0
	dbsprite -21,  12, $15, 0
	dbsprite -21,   4, $14, 0
	dbsprite -21,  -4, $13, 0
	dbsprite -21, -12, $12, 0
	dbsprite -29,  12, $19, 0
	dbsprite -29,   4, $18, 0
	dbsprite -29,  -4, $17, 0
	dbsprite -29, -12, $16, 0
	dbsprite   8,  12, $25, 1
	dbsprite   0,  12, $24, 1
	dbsprite   8, -20, $23, 1
	dbsprite   0, -20, $22, 1

.frame_5
	db 35 ; size
	dbsprite  11,  12, $2c, 0
	dbsprite  11,   4, $03, 0
	dbsprite  11,  -4, $02, 0
	dbsprite  11, -12, $01, 0
	dbsprite  11, -20, $00, 0
	dbsprite   3,  12, $08, 0
	dbsprite   3,   4, $07, 0
	dbsprite   3,  -4, $06, 0
	dbsprite   3, -12, $05, 0
	dbsprite   3, -20, $04, 0
	dbsprite  -5,  12, $0d, 0
	dbsprite  -5,   4, $0c, 0
	dbsprite  -5,  -4, $0b, 0
	dbsprite  -5, -12, $0a, 0
	dbsprite  -5, -20, $09, 0
	dbsprite -13,  -9, $0f, 0
	dbsprite -13, -17, $0e, 0
	dbsprite -13,   7, $11, 0
	dbsprite -13,  -1, $10, 0
	dbsprite -21,  12, $15, 0
	dbsprite -21,   4, $14, 0
	dbsprite -21,  -4, $13, 0
	dbsprite -21, -12, $12, 0
	dbsprite -29,  12, $19, 0
	dbsprite -29,   4, $18, 0
	dbsprite -29,  -4, $17, 0
	dbsprite -29, -12, $16, 0
	dbsprite   8,  20, $28, 1 | OAM_XFLIP
	dbsprite   0,  20, $27, 1 | OAM_XFLIP
	dbsprite  -8,  20, $2b, 1 | OAM_XFLIP
	dbsprite  -8, -28, $2b, 1
	dbsprite   8, -28, $28, 1
	dbsprite   0, -28, $27, 1
	dbsprite   8,  12, $25, 2
	dbsprite   0,  12, $24, 2

.frame_6
	db 37 ; size
	dbsprite  11,  12, $2c, 0
	dbsprite  11,   4, $03, 0
	dbsprite  11,  -4, $02, 0
	dbsprite  11, -12, $01, 0
	dbsprite  11, -20, $00, 0
	dbsprite   3,  12, $08, 0
	dbsprite   3,   4, $07, 0
	dbsprite   3,  -4, $06, 0
	dbsprite   3, -12, $05, 0
	dbsprite   3, -20, $04, 0
	dbsprite  -5,  12, $0d, 0
	dbsprite  -5,   4, $0c, 0
	dbsprite  -5,  -4, $0b, 0
	dbsprite  -5, -12, $0a, 0
	dbsprite  -5, -20, $09, 0
	dbsprite -13,  -9, $0f, 0
	dbsprite -13, -17, $0e, 0
	dbsprite -13,   7, $11, 0
	dbsprite -13,  -1, $10, 0
	dbsprite -21,  12, $15, 0
	dbsprite -21,   4, $14, 0
	dbsprite -21,  -4, $13, 0
	dbsprite -21, -12, $12, 0
	dbsprite -29,  12, $19, 0
	dbsprite -29,   4, $18, 0
	dbsprite -29,  -4, $17, 0
	dbsprite -29, -12, $16, 0
	dbsprite   0,  28, $29, 1 | OAM_XFLIP
	dbsprite   8,  28, $2a, 1 | OAM_XFLIP
	dbsprite   0, -36, $29, 1
	dbsprite   8, -36, $2a, 1
	dbsprite   8,  20, $28, 2 | OAM_XFLIP
	dbsprite   0,  20, $27, 2 | OAM_XFLIP
	dbsprite  -8,  20, $2b, 2 | OAM_XFLIP
	dbsprite  -8, -28, $2b, 2
	dbsprite   8, -28, $28, 2
	dbsprite   0, -28, $27, 2

OAMData41::
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
	dbsprite  14, -30, $0f, 1
	dbsprite  15, -31, $0e, 1

.frame_1
	db 2 ; size
	dbsprite  13, -29, $11, 1
	dbsprite  20, -36, $10, 1

.frame_2
	db 4 ; size
	dbsprite  19, -27, $15, 1
	dbsprite  19, -35, $14, 1
	dbsprite  11, -27, $13, 1
	dbsprite  11, -35, $12, 1

.frame_3
	db 4 ; size
	dbsprite  17, -25, $19, 1
	dbsprite  17, -33, $18, 1
	dbsprite   9, -25, $17, 1
	dbsprite   9, -33, $16, 1

.frame_4
	db 5 ; size
	dbsprite  23, -31, $1e, 1
	dbsprite  15, -17, $1d, 1
	dbsprite  15, -25, $1c, 1
	dbsprite  15, -33, $1b, 1
	dbsprite   7, -31, $1a, 1

.frame_5
	db 7 ; size
	dbsprite  20, -22, $25, 1
	dbsprite  20, -30, $24, 1
	dbsprite  20, -38, $23, 1
	dbsprite  12, -22, $22, 1
	dbsprite  12, -30, $21, 1
	dbsprite  12, -38, $20, 1
	dbsprite   4, -30, $1f, 1

.frame_6
	db 8 ; size
	dbsprite  22, -27, $2d, 1
	dbsprite  22, -35, $2c, 1
	dbsprite  14, -20, $2b, 1
	dbsprite  14, -28, $2a, 1
	dbsprite  14, -36, $29, 1
	dbsprite   6, -28, $28, 1
	dbsprite   6, -36, $27, 1
	dbsprite  -2, -33, $26, 1

.frame_7
	db 2 ; size
	dbsprite  14,  22, $0f, 1 | OAM_XFLIP
	dbsprite  15,  23, $0e, 1 | OAM_XFLIP

.frame_8
	db 2 ; size
	dbsprite  13,  21, $11, 1 | OAM_XFLIP
	dbsprite  20,  28, $10, 1 | OAM_XFLIP

.frame_9
	db 4 ; size
	dbsprite  19,  19, $15, 1 | OAM_XFLIP
	dbsprite  19,  27, $14, 1 | OAM_XFLIP
	dbsprite  11,  19, $13, 1 | OAM_XFLIP
	dbsprite  11,  27, $12, 1 | OAM_XFLIP

.frame_10
	db 4 ; size
	dbsprite  17,  17, $19, 1 | OAM_XFLIP
	dbsprite  17,  25, $18, 1 | OAM_XFLIP
	dbsprite   9,  17, $17, 1 | OAM_XFLIP
	dbsprite   9,  25, $16, 1 | OAM_XFLIP

.frame_11
	db 5 ; size
	dbsprite  23,  23, $1e, 1 | OAM_XFLIP
	dbsprite  15,   9, $1d, 1 | OAM_XFLIP
	dbsprite  15,  17, $1c, 1 | OAM_XFLIP
	dbsprite  15,  25, $1b, 1 | OAM_XFLIP
	dbsprite   7,  23, $1a, 1 | OAM_XFLIP

.frame_12
	db 7 ; size
	dbsprite  20,  14, $25, 1 | OAM_XFLIP
	dbsprite  20,  22, $24, 1 | OAM_XFLIP
	dbsprite  20,  30, $23, 1 | OAM_XFLIP
	dbsprite  12,  14, $22, 1 | OAM_XFLIP
	dbsprite  12,  22, $21, 1 | OAM_XFLIP
	dbsprite  12,  30, $20, 1 | OAM_XFLIP
	dbsprite   4,  22, $1f, 1 | OAM_XFLIP

.frame_13
	db 8 ; size
	dbsprite  22,  19, $2d, 1 | OAM_XFLIP
	dbsprite  22,  27, $2c, 1 | OAM_XFLIP
	dbsprite  14,  12, $2b, 1 | OAM_XFLIP
	dbsprite  14,  20, $2a, 1 | OAM_XFLIP
	dbsprite  14,  28, $29, 1 | OAM_XFLIP
	dbsprite   6,  20, $28, 1 | OAM_XFLIP
	dbsprite   6,  28, $27, 1 | OAM_XFLIP
	dbsprite  -2,  25, $26, 1 | OAM_XFLIP

.frame_14
	db 14 ; size
	dbsprite  16, -24, $0d, 0
	dbsprite  16, -32, $0c, 0
	dbsprite  16, -40, $0b, 0
	dbsprite   8, -16, $0a, 0
	dbsprite   8, -24, $09, 0
	dbsprite   8, -32, $08, 0
	dbsprite   0, -24, $05, 0
	dbsprite  -2,  -8, $07, 0
	dbsprite  -2, -16, $06, 0
	dbsprite  -8,   0, $04, 0
	dbsprite -10,  -8, $03, 0
	dbsprite -10, -16, $02, 0
	dbsprite -16,   0, $01, 0
	dbsprite -18,  -8, $00, 0

.frame_15
	db 14 ; size
	dbsprite  16,  16, $0d, 0 | OAM_XFLIP
	dbsprite  16,  24, $0c, 0 | OAM_XFLIP
	dbsprite  16,  32, $0b, 0 | OAM_XFLIP
	dbsprite   8,   8, $0a, 0 | OAM_XFLIP
	dbsprite   8,  16, $09, 0 | OAM_XFLIP
	dbsprite   8,  24, $08, 0 | OAM_XFLIP
	dbsprite   0,  16, $05, 0 | OAM_XFLIP
	dbsprite  -2,   0, $07, 0 | OAM_XFLIP
	dbsprite  -2,   8, $06, 0 | OAM_XFLIP
	dbsprite  -8,  -8, $04, 0 | OAM_XFLIP
	dbsprite -10,   0, $03, 0 | OAM_XFLIP
	dbsprite -10,   8, $02, 0 | OAM_XFLIP
	dbsprite -16,  -8, $01, 0 | OAM_XFLIP
	dbsprite -18,   0, $00, 0 | OAM_XFLIP

OAMData42::
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

.frame_0
	db 16 ; size
	dbsprite   8, -24, $0e, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite  16, -16, $0e, 0
	dbsprite  16, -24, $0d, 0
	dbsprite  16, -32, $0c, 0
	dbsprite   8,   0, $0b, 0
	dbsprite   8,  -8, $0a, 0
	dbsprite   8, -16, $09, 0
	dbsprite   0,   8, $08, 0
	dbsprite   0,   0, $07, 0
	dbsprite   0,  -8, $06, 0
	dbsprite   0, -16, $05, 0
	dbsprite  -8,   8, $04, 0
	dbsprite  -8,   0, $03, 0
	dbsprite  -8,  -8, $02, 0
	dbsprite -16,   8, $01, 0
	dbsprite -16,   0, $00, 0

.frame_1
	db 16 ; size
	dbsprite   8,  16, $0e, 0 | OAM_YFLIP
	dbsprite  16,   8, $0e, 0 | OAM_XFLIP
	dbsprite  16,  16, $0d, 0 | OAM_XFLIP
	dbsprite  16,  24, $0c, 0 | OAM_XFLIP
	dbsprite   8,  -8, $0b, 0 | OAM_XFLIP
	dbsprite   8,   0, $0a, 0 | OAM_XFLIP
	dbsprite   8,   8, $09, 0 | OAM_XFLIP
	dbsprite   0, -16, $08, 0 | OAM_XFLIP
	dbsprite   0,  -8, $07, 0 | OAM_XFLIP
	dbsprite   0,   0, $06, 0 | OAM_XFLIP
	dbsprite   0,   8, $05, 0 | OAM_XFLIP
	dbsprite  -8, -16, $04, 0 | OAM_XFLIP
	dbsprite  -8,  -8, $03, 0 | OAM_XFLIP
	dbsprite  -8,   0, $02, 0 | OAM_XFLIP
	dbsprite -16, -16, $01, 0 | OAM_XFLIP
	dbsprite -16,  -8, $00, 0 | OAM_XFLIP

.frame_2
	db 4 ; size
	dbsprite   0,  -8, $12, 0 | OAM_XFLIP
	dbsprite   0,   0, $11, 0 | OAM_XFLIP
	dbsprite  -8,  -8, $10, 0 | OAM_XFLIP
	dbsprite  -8,   0, $0f, 0 | OAM_XFLIP

.frame_3
	db 6 ; size
	dbsprite   6, -11, $18, 0
	dbsprite  -2,  -3, $17, 0
	dbsprite  -2, -11, $16, 0
	dbsprite -10,   5, $15, 0
	dbsprite -10,  -3, $14, 0
	dbsprite -10, -11, $13, 0

.frame_4
	db 6 ; size
	dbsprite   6,   3, $18, 0 | OAM_XFLIP
	dbsprite  -2,  -5, $17, 0 | OAM_XFLIP
	dbsprite  -2,   3, $16, 0 | OAM_XFLIP
	dbsprite -10, -13, $15, 0 | OAM_XFLIP
	dbsprite -10,  -5, $14, 0 | OAM_XFLIP
	dbsprite -10,   3, $13, 0 | OAM_XFLIP

.frame_5
	db 8 ; size
	dbsprite   4,  -4, $20, 0
	dbsprite   4, -12, $1f, 0
	dbsprite  -4,   4, $1e, 0
	dbsprite  -4,  -4, $1d, 0
	dbsprite  -4, -12, $1c, 0
	dbsprite -12,   4, $1b, 0
	dbsprite -12,  -4, $1a, 0
	dbsprite -12, -12, $19, 0

.frame_6
	db 8 ; size
	dbsprite   4,  -4, $20, 0 | OAM_XFLIP
	dbsprite   4,   4, $1f, 0 | OAM_XFLIP
	dbsprite  -4, -12, $1e, 0 | OAM_XFLIP
	dbsprite  -4,  -4, $1d, 0 | OAM_XFLIP
	dbsprite  -4,   4, $1c, 0 | OAM_XFLIP
	dbsprite -12, -12, $1b, 0 | OAM_XFLIP
	dbsprite -12,  -4, $1a, 0 | OAM_XFLIP
	dbsprite -12,   4, $19, 0 | OAM_XFLIP

.frame_7
	db 7 ; size
	dbsprite   5,  -4, $27, 0
	dbsprite   5, -12, $26, 0
	dbsprite  -3,   4, $25, 0
	dbsprite  -3,  -4, $24, 0
	dbsprite  -3, -12, $23, 0
	dbsprite -11,   4, $22, 0
	dbsprite -11,  -4, $21, 0

.frame_8
	db 7 ; size
	dbsprite   5,  -4, $27, 0 | OAM_XFLIP
	dbsprite   5,   4, $26, 0 | OAM_XFLIP
	dbsprite  -3, -12, $25, 0 | OAM_XFLIP
	dbsprite  -3,  -4, $24, 0 | OAM_XFLIP
	dbsprite  -3,   4, $23, 0 | OAM_XFLIP
	dbsprite -11, -12, $22, 0 | OAM_XFLIP
	dbsprite -11,  -4, $21, 0 | OAM_XFLIP

.frame_9
	db 9 ; size
	dbsprite   6,   4, $30, 0
	dbsprite   6,  -4, $2f, 0
	dbsprite   6, -12, $2e, 0
	dbsprite  -2,   4, $2d, 0
	dbsprite  -2,  -4, $2c, 0
	dbsprite  -2, -12, $2b, 0
	dbsprite -10,   4, $2a, 0
	dbsprite -10,  -4, $29, 0
	dbsprite -10, -12, $28, 0

.frame_10
	db 9 ; size
	dbsprite   6, -12, $30, 0 | OAM_XFLIP
	dbsprite   6,  -4, $2f, 0 | OAM_XFLIP
	dbsprite   6,   4, $2e, 0 | OAM_XFLIP
	dbsprite  -2, -12, $2d, 0 | OAM_XFLIP
	dbsprite  -2,  -4, $2c, 0 | OAM_XFLIP
	dbsprite  -2,   4, $2b, 0 | OAM_XFLIP
	dbsprite -10, -12, $2a, 0 | OAM_XFLIP
	dbsprite -10,  -4, $29, 0 | OAM_XFLIP
	dbsprite -10,   4, $28, 0 | OAM_XFLIP

.frame_11
	db 4 ; size
	dbsprite   0,   0, $12, 0
	dbsprite   0,  -8, $11, 0
	dbsprite  -8,   0, $10, 0
	dbsprite  -8,  -8, $0f, 0

OAMData43::
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

.frame_0
	db 14 ; size
	dbsprite  16, -16, $0d, 0
	dbsprite  16, -24, $0c, 0
	dbsprite  16, -32, $0b, 0
	dbsprite   8,  -8, $0a, 0
	dbsprite   8, -16, $09, 0
	dbsprite   8, -24, $08, 0
	dbsprite   0, -16, $05, 0
	dbsprite  -2,   0, $07, 0
	dbsprite  -2,  -8, $06, 0
	dbsprite  -8,   8, $04, 0
	dbsprite -10,   0, $03, 0
	dbsprite -10,  -8, $02, 0
	dbsprite -16,   8, $01, 0
	dbsprite -18,   0, $00, 0

.frame_1
	db 14 ; size
	dbsprite  16,   8, $0d, 0 | OAM_XFLIP
	dbsprite  16,  16, $0c, 0 | OAM_XFLIP
	dbsprite  16,  24, $0b, 0 | OAM_XFLIP
	dbsprite   8,   0, $0a, 0 | OAM_XFLIP
	dbsprite   8,   8, $09, 0 | OAM_XFLIP
	dbsprite   8,  16, $08, 0 | OAM_XFLIP
	dbsprite   0,   8, $05, 0 | OAM_XFLIP
	dbsprite  -2,  -8, $07, 0 | OAM_XFLIP
	dbsprite  -2,   0, $06, 0 | OAM_XFLIP
	dbsprite  -8, -16, $04, 0 | OAM_XFLIP
	dbsprite -10,  -8, $03, 0 | OAM_XFLIP
	dbsprite -10,   0, $02, 0 | OAM_XFLIP
	dbsprite -16, -16, $01, 0 | OAM_XFLIP
	dbsprite -18,  -8, $00, 0 | OAM_XFLIP

.frame_2
	db 2 ; size
	dbsprite  16, -32, $0e, 1 | OAM_XFLIP
	dbsprite  16, -24, $0e, 1 | OAM_YFLIP

.frame_3
	db 5 ; size
	dbsprite  16, -32, $0e, 1
	dbsprite  16, -24, $0e, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite  16, -16, $0e, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite   8, -24, $0e, 1 | OAM_YFLIP
	dbsprite   8, -16, $0e, 1 | OAM_XFLIP

.frame_4
	db 11 ; size
	dbsprite  16, -32, $0e, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite   8, -32, $0e, 1 | OAM_YFLIP
	dbsprite  16, -24, $0e, 1 | OAM_XFLIP
	dbsprite  16,  -8, $0e, 1 | OAM_XFLIP
	dbsprite   0, -24, $0e, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite  16, -16, $0e, 1 | OAM_YFLIP
	dbsprite   8, -24, $0e, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite   8,  -8, $0e, 1 | OAM_YFLIP
	dbsprite   0, -16, $0e, 1 | OAM_YFLIP
	dbsprite   8, -16, $0e, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite   0,  -8, $0e, 1 | OAM_XFLIP

.frame_5
	db 16 ; size
	dbsprite  16, -32, $0e, 1 | OAM_XFLIP
	dbsprite   8, -32, $0e, 1 | OAM_XFLIP
	dbsprite   8,   0, $0e, 1 | OAM_YFLIP
	dbsprite  -8, -16, $0e, 1 | OAM_XFLIP
	dbsprite   0,   0, $0e, 1 | OAM_XFLIP
	dbsprite  -8,   0, $0e, 1
	dbsprite  -8,  -8, $0e, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite  16,  -8, $0e, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite  16, -16, $0e, 1 | OAM_XFLIP
	dbsprite  16, -24, $0e, 1
	dbsprite   8, -24, $0e, 1 | OAM_YFLIP
	dbsprite   8, -16, $0e, 1 | OAM_XFLIP
	dbsprite   8,  -8, $0e, 1
	dbsprite   0,  -8, $0e, 1 | OAM_YFLIP
	dbsprite   0, -16, $0e, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite   0, -24, $0e, 1 | OAM_XFLIP

.frame_6
	db 20 ; size
	dbsprite  16, -32, $0e, 1
	dbsprite  16,  -8, $0e, 1 | OAM_YFLIP
	dbsprite  16, -16, $0e, 1 | OAM_YFLIP
	dbsprite  16, -24, $0e, 1 | OAM_YFLIP
	dbsprite   8, -24, $0e, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite   0, -24, $0e, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite   8,   0, $0e, 1
	dbsprite   8,  -8, $0e, 1 | OAM_XFLIP
	dbsprite   8, -16, $0e, 1
	dbsprite   0, -16, $0e, 1
	dbsprite  -8, -16, $0e, 1 | OAM_YFLIP
	dbsprite   0,   0, $0e, 1 | OAM_YFLIP
	dbsprite   0,  -8, $0e, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite  -8,  -8, $0e, 1 | OAM_XFLIP
	dbsprite  -8,   0, $0e, 1 | OAM_XFLIP
	dbsprite   0,   8, $0e, 1 | OAM_XFLIP
	dbsprite  -8,   8, $0e, 1 | OAM_YFLIP
	dbsprite -16,  -8, $0e, 1 | OAM_YFLIP
	dbsprite -16,   0, $0e, 1
	dbsprite -16,   8, $0e, 1 | OAM_XFLIP

.frame_7
	db 22 ; size
	dbsprite  16, -24, $0e, 1 | OAM_XFLIP
	dbsprite  16, -16, $0e, 1
	dbsprite   8, -24, $0e, 1 | OAM_YFLIP
	dbsprite   8,   0, $0e, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite   8,  -8, $0e, 1
	dbsprite   8, -16, $0e, 1 | OAM_XFLIP
	dbsprite   0, -16, $0e, 1 | OAM_YFLIP
	dbsprite  -8, -16, $0e, 1 | OAM_XFLIP
	dbsprite   0,   8, $0e, 1
	dbsprite   0,   0, $0e, 1 | OAM_YFLIP
	dbsprite   0,  -8, $0e, 1 | OAM_XFLIP
	dbsprite  -8,  -8, $0e, 1 | OAM_YFLIP
	dbsprite -16,  -8, $0e, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite -16,  16, $0e, 1 | OAM_YFLIP
	dbsprite  -8,  16, $0e, 1
	dbsprite  -8,   8, $0e, 1 | OAM_XFLIP
	dbsprite -16,   8, $0e, 1
	dbsprite  -8,   0, $0e, 1
	dbsprite -16,   0, $0e, 1 | OAM_YFLIP
	dbsprite -24,   0, $0e, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite -24,   8, $0e, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite -24,  16, $0e, 1 | OAM_XFLIP

.frame_8
	db 20 ; size
	dbsprite  16, -24, $0e, 1 | OAM_YFLIP
	dbsprite   8,  -8, $0e, 1 | OAM_YFLIP
	dbsprite   8, -16, $0e, 1
	dbsprite   0, -16, $0e, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite   0,   8, $0e, 1 | OAM_YFLIP
	dbsprite   0,   0, $0e, 1 | OAM_XFLIP
	dbsprite   0,  -8, $0e, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite  -8,  -8, $0e, 1 | OAM_XFLIP
	dbsprite -16,  -8, $0e, 1 | OAM_YFLIP
	dbsprite  -8,  16, $0e, 1 | OAM_XFLIP
	dbsprite  -8,   8, $0e, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite -16,   0, $0e, 1 | OAM_XFLIP
	dbsprite  -8,   0, $0e, 1 | OAM_YFLIP
	dbsprite -24,   0, $0e, 1
	dbsprite -16,  24, $0e, 1 | OAM_YFLIP
	dbsprite -16,  16, $0e, 1 | OAM_YFLIP
	dbsprite -16,   8, $0e, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite -24,   8, $0e, 1 | OAM_XFLIP
	dbsprite -24,  16, $0e, 1 | OAM_YFLIP
	dbsprite -24,  24, $0e, 1 | OAM_XFLIP

.frame_9
	db 15 ; size
	dbsprite   8, -16, $0e, 1 | OAM_XFLIP
	dbsprite   0,   0, $0e, 1
	dbsprite   0,  -8, $0e, 1 | OAM_XFLIP
	dbsprite  -8,  -8, $0e, 1 | OAM_YFLIP
	dbsprite  -8,  16, $0e, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite  -8,   8, $0e, 1 | OAM_YFLIP
	dbsprite  -8,   0, $0e, 1 | OAM_XFLIP
	dbsprite -16,   0, $0e, 1 | OAM_YFLIP
	dbsprite -24,   0, $0e, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite -16,  24, $0e, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite -16,  16, $0e, 1
	dbsprite -24,   8, $0e, 1
	dbsprite -16,   8, $0e, 1 | OAM_XFLIP
	dbsprite -24,  24, $0e, 1
	dbsprite -24,  16, $0e, 1 | OAM_XFLIP

.frame_10
	db 10 ; size
	dbsprite   0,  -8, $0e, 1
	dbsprite  -8,   8, $0e, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite  -8,   0, $0e, 1 | OAM_YFLIP
	dbsprite -16,   0, $0e, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite -16,  24, $0e, 1
	dbsprite -16,  16, $0e, 1 | OAM_XFLIP
	dbsprite -16,   8, $0e, 1
	dbsprite -24,   8, $0e, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite -24,  24, $0e, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite -24,  16, $0e, 1

.frame_11
	db 6 ; size
	dbsprite  -8,   0, $0e, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite -16,  16, $0e, 1 | OAM_YFLIP
	dbsprite -16,   8, $0e, 1 | OAM_XFLIP
	dbsprite -24,   8, $0e, 1 | OAM_YFLIP
	dbsprite -24,  24, $0e, 1 | OAM_YFLIP
	dbsprite -24,  16, $0e, 1 | OAM_XFLIP

.frame_12
	db 3 ; size
	dbsprite -16,   8, $0e, 1 | OAM_YFLIP
	dbsprite -24,  24, $0e, 1 | OAM_XFLIP
	dbsprite -24,  16, $0e, 1 | OAM_YFLIP

.frame_13
	db 1 ; size
	dbsprite -24,  16, $0e, 1

.frame_14
	db 2 ; size
	dbsprite  16,  24, $0e, 1
	dbsprite  16,  16, $0e, 1 | OAM_XFLIP | OAM_YFLIP

.frame_15
	db 5 ; size
	dbsprite  16,  24, $0e, 1 | OAM_XFLIP
	dbsprite  16,  16, $0e, 1 | OAM_YFLIP
	dbsprite  16,   8, $0e, 1 | OAM_YFLIP
	dbsprite   8,  16, $0e, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite   8,   8, $0e, 1

.frame_16
	db 11 ; size
	dbsprite  16,  24, $0e, 1 | OAM_YFLIP
	dbsprite   8,  24, $0e, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite  16,  16, $0e, 1
	dbsprite  16,   0, $0e, 1
	dbsprite   0,  16, $0e, 1 | OAM_YFLIP
	dbsprite  16,   8, $0e, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite   8,  16, $0e, 1 | OAM_YFLIP
	dbsprite   8,   0, $0e, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite   0,   8, $0e, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite   8,   8, $0e, 1 | OAM_YFLIP
	dbsprite   0,   0, $0e, 1

.frame_17
	db 16 ; size
	dbsprite  16,  24, $0e, 1
	dbsprite   8,  24, $0e, 1
	dbsprite   8,  -8, $0e, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite  -8,   8, $0e, 1
	dbsprite   0,  -8, $0e, 1
	dbsprite  -8,  -8, $0e, 1 | OAM_XFLIP
	dbsprite  -8,   0, $0e, 1 | OAM_YFLIP
	dbsprite  16,   0, $0e, 1 | OAM_YFLIP
	dbsprite  16,   8, $0e, 1
	dbsprite  16,  16, $0e, 1 | OAM_XFLIP
	dbsprite   8,  16, $0e, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite   8,   8, $0e, 1
	dbsprite   8,   0, $0e, 1 | OAM_XFLIP
	dbsprite   0,   0, $0e, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite   0,   8, $0e, 1 | OAM_YFLIP
	dbsprite   0,  16, $0e, 1

.frame_18
	db 20 ; size
	dbsprite  16,  24, $0e, 1 | OAM_XFLIP
	dbsprite  16,   0, $0e, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite  16,   8, $0e, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite  16,  16, $0e, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite   8,  16, $0e, 1 | OAM_YFLIP
	dbsprite   0,  16, $0e, 1 | OAM_YFLIP
	dbsprite   8,  -8, $0e, 1 | OAM_XFLIP
	dbsprite   8,   0, $0e, 1
	dbsprite   8,   8, $0e, 1 | OAM_XFLIP
	dbsprite   0,   8, $0e, 1 | OAM_XFLIP
	dbsprite  -8,   8, $0e, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite   0,  -8, $0e, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite   0,   0, $0e, 1 | OAM_YFLIP
	dbsprite  -8,   0, $0e, 1
	dbsprite  -8,  -8, $0e, 1
	dbsprite   0, -16, $0e, 1
	dbsprite  -8, -16, $0e, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite -16,   0, $0e, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite -16,  -8, $0e, 1 | OAM_XFLIP
	dbsprite -16, -16, $0e, 1

.frame_19
	db 22 ; size
	dbsprite  16,  16, $0e, 1
	dbsprite  16,   8, $0e, 1 | OAM_XFLIP
	dbsprite   8,  16, $0e, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite   8,  -8, $0e, 1 | OAM_YFLIP
	dbsprite   8,   0, $0e, 1 | OAM_XFLIP
	dbsprite   8,   8, $0e, 1
	dbsprite   0,   8, $0e, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite  -8,   8, $0e, 1
	dbsprite   0, -16, $0e, 1 | OAM_XFLIP
	dbsprite   0,  -8, $0e, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite   0,   0, $0e, 1
	dbsprite  -8,   0, $0e, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite -16,   0, $0e, 1 | OAM_YFLIP
	dbsprite -16, -24, $0e, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite  -8, -24, $0e, 1 | OAM_XFLIP
	dbsprite  -8, -16, $0e, 1
	dbsprite -16, -16, $0e, 1 | OAM_XFLIP
	dbsprite  -8,  -8, $0e, 1 | OAM_XFLIP
	dbsprite -16,  -8, $0e, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite -24,  -8, $0e, 1 | OAM_YFLIP
	dbsprite -24, -16, $0e, 1 | OAM_YFLIP
	dbsprite -24, -24, $0e, 1

.frame_20
	db 20 ; size
	dbsprite  16,  16, $0e, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite   8,   0, $0e, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite   8,   8, $0e, 1 | OAM_XFLIP
	dbsprite   0,   8, $0e, 1 | OAM_YFLIP
	dbsprite   0, -16, $0e, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite   0,  -8, $0e, 1
	dbsprite   0,   0, $0e, 1 | OAM_YFLIP
	dbsprite  -8,   0, $0e, 1
	dbsprite -16,   0, $0e, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite  -8, -24, $0e, 1
	dbsprite  -8, -16, $0e, 1 | OAM_YFLIP
	dbsprite -16,  -8, $0e, 1
	dbsprite  -8,  -8, $0e, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite -24,  -8, $0e, 1 | OAM_XFLIP
	dbsprite -16, -32, $0e, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite -16, -24, $0e, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite -16, -16, $0e, 1 | OAM_YFLIP
	dbsprite -24, -16, $0e, 1
	dbsprite -24, -24, $0e, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite -24, -32, $0e, 1

.frame_21
	db 15 ; size
	dbsprite   8,   8, $0e, 1
	dbsprite   0,  -8, $0e, 1 | OAM_XFLIP
	dbsprite   0,   0, $0e, 1
	dbsprite  -8,   0, $0e, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite  -8, -24, $0e, 1 | OAM_YFLIP
	dbsprite  -8, -16, $0e, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite  -8,  -8, $0e, 1
	dbsprite -16,  -8, $0e, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite -24,  -8, $0e, 1 | OAM_YFLIP
	dbsprite -16, -32, $0e, 1 | OAM_YFLIP
	dbsprite -16, -24, $0e, 1 | OAM_XFLIP
	dbsprite -24, -16, $0e, 1 | OAM_XFLIP
	dbsprite -16, -16, $0e, 1
	dbsprite -24, -32, $0e, 1 | OAM_XFLIP
	dbsprite -24, -24, $0e, 1

.frame_22
	db 10 ; size
	dbsprite   0,   0, $0e, 1 | OAM_XFLIP
	dbsprite  -8, -16, $0e, 1 | OAM_YFLIP
	dbsprite  -8,  -8, $0e, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite -16,  -8, $0e, 1 | OAM_YFLIP
	dbsprite -16, -32, $0e, 1 | OAM_XFLIP
	dbsprite -16, -24, $0e, 1
	dbsprite -16, -16, $0e, 1 | OAM_XFLIP
	dbsprite -24, -16, $0e, 1 | OAM_YFLIP
	dbsprite -24, -32, $0e, 1 | OAM_YFLIP
	dbsprite -24, -24, $0e, 1 | OAM_XFLIP

.frame_23
	db 6 ; size
	dbsprite  -8,  -8, $0e, 1 | OAM_YFLIP
	dbsprite -16, -24, $0e, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite -16, -16, $0e, 1
	dbsprite -24, -16, $0e, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite -24, -32, $0e, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite -24, -24, $0e, 1

.frame_24
	db 3 ; size
	dbsprite -16, -16, $0e, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite -24, -32, $0e, 1
	dbsprite -24, -24, $0e, 1 | OAM_XFLIP | OAM_YFLIP

.frame_25
	db 1 ; size
	dbsprite -24, -24, $0e, 1 | OAM_XFLIP

OAMData44::
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
	db 9 ; size
	dbsprite  16,  24, $08, 0
	dbsprite  16,  16, $07, 0
	dbsprite  16,   8, $06, 0
	dbsprite  16,   0, $05, 0
	dbsprite  16,  -8, $04, 0
	dbsprite   8,  24, $03, 0
	dbsprite   8,  16, $02, 0
	dbsprite   8,   8, $01, 0
	dbsprite   8,   0, $00, 0

.frame_1
	db 11 ; size
	dbsprite  16,   8, $06, 0
	dbsprite  16,  24, $11, 0
	dbsprite  16,  16, $10, 0
	dbsprite  16,   0, $0f, 0
	dbsprite  16,  -8, $0e, 0
	dbsprite   8,  24, $0d, 0
	dbsprite   8,  16, $0c, 0
	dbsprite   8,   8, $06, 0
	dbsprite   8,   0, $0b, 0
	dbsprite   0,  13, $0a, 0
	dbsprite   0,   5, $09, 0

.frame_2
	db 15 ; size
	dbsprite  16,   0, $06, 0
	dbsprite  16,  24, $1e, 0
	dbsprite  16,  16, $1d, 0
	dbsprite  16,   8, $1c, 0
	dbsprite  16,  -8, $1b, 0
	dbsprite   8,  24, $1a, 0
	dbsprite   8,  16, $19, 0
	dbsprite   8,   8, $18, 0
	dbsprite   8,   0, $06, 0
	dbsprite   8,  -8, $17, 0
	dbsprite   0,  16, $16, 0
	dbsprite   0,   8, $15, 0
	dbsprite   0,   0, $14, 0
	dbsprite   0,  -8, $13, 0
	dbsprite  -8,   0, $12, 0

.frame_3
	db 16 ; size
	dbsprite  16,   8, $2c, 0
	dbsprite  16,   0, $2b, 0
	dbsprite  16,  -8, $2a, 0
	dbsprite   8,   7, $29, 0
	dbsprite   8,  -1, $06, 0
	dbsprite   8,  -9, $28, 0
	dbsprite   0,   0, $27, 0
	dbsprite   0,  -8, $06, 0
	dbsprite   0, -16, $26, 0
	dbsprite  -8,   7, $25, 0
	dbsprite  -8,  -1, $24, 0
	dbsprite  -8,  -9, $23, 0
	dbsprite -16,   8, $22, 0
	dbsprite -16,   0, $21, 0
	dbsprite -24,   8, $20, 0
	dbsprite -24,   0, $1f, 0

.frame_4
	db 18 ; size
	dbsprite  16,   8, $3e, 0
	dbsprite  16,   0, $3d, 0
	dbsprite  16,  -8, $3c, 0
	dbsprite  16, -16, $3b, 0
	dbsprite   8,   4, $3a, 0
	dbsprite   8,  -4, $39, 0
	dbsprite   8, -12, $38, 0
	dbsprite   0,   0, $37, 0
	dbsprite   0,  -8, $36, 0
	dbsprite   0, -16, $35, 0
	dbsprite  -8, -10, $34, 0
	dbsprite  -8, -18, $33, 0
	dbsprite -16,  -9, $32, 0
	dbsprite -16, -17, $31, 0
	dbsprite -16, -25, $30, 0
	dbsprite -24, -16, $2f, 0
	dbsprite -24, -24, $2e, 0
	dbsprite -24, -32, $2d, 0

.frame_5
	db 16 ; size
	dbsprite  16,   9, $4e, 0
	dbsprite  16,   1, $4d, 0
	dbsprite  16,  -7, $4c, 0
	dbsprite  16, -15, $4b, 0
	dbsprite   8,   2, $4a, 0
	dbsprite   8,  -6, $49, 0
	dbsprite   8, -14, $48, 0
	dbsprite   8, -22, $47, 0
	dbsprite   0,  -8, $46, 0
	dbsprite   0, -16, $45, 0
	dbsprite   0, -24, $44, 0
	dbsprite  -8, -16, $43, 0
	dbsprite  -8, -24, $42, 0
	dbsprite  -8, -32, $41, 0
	dbsprite -16, -24, $40, 0
	dbsprite -16, -32, $3f, 0

.frame_6
	db 15 ; size
	dbsprite  16,   9, $5d, 0
	dbsprite  16,   1, $5c, 0
	dbsprite  16,  -7, $5b, 0
	dbsprite  16, -15, $5a, 0
	dbsprite  16, -23, $59, 0
	dbsprite   8,   0, $58, 0
	dbsprite   8,  -8, $57, 0
	dbsprite   8, -16, $56, 0
	dbsprite   8, -24, $55, 0
	dbsprite   8, -32, $54, 0
	dbsprite   0, -16, $53, 0
	dbsprite   0, -24, $52, 0
	dbsprite   0, -32, $51, 0
	dbsprite  -8, -24, $50, 0
	dbsprite  -8, -32, $4f, 0

.frame_7
	db 3 ; size
	dbsprite  16,  24, $02, 0
	dbsprite  16,  16, $01, 0
	dbsprite  16,   8, $00, 0

.frame_8
	db 7 ; size
	dbsprite   0, -32, $50, 0
	dbsprite   8, -24, $53, 0
	dbsprite   8, -32, $52, 0
	dbsprite  16,  -8, $58, 0
	dbsprite  16, -16, $57, 0
	dbsprite  16, -24, $56, 0
	dbsprite  16, -32, $55, 0

.frame_9
	db 1 ; size
	dbsprite  16, -32, $53, 0

OAMData45::
	dw .frame_0
	dw .frame_1
	dw .frame_2
	dw .frame_3
	dw .frame_4
	dw .frame_5

.frame_0
	db 9 ; size
	dbsprite   8, -32, $08, 0
	dbsprite   0, -24, $07, 0
	dbsprite   0, -32, $06, 0
	dbsprite  -8, -24, $05, 0
	dbsprite  -8, -32, $04, 0
	dbsprite -16, -24, $03, 0
	dbsprite -16, -32, $02, 0
	dbsprite -24, -24, $01, 0
	dbsprite -24, -32, $00, 0

.frame_1
	db 16 ; size
	dbsprite  16, -32, $18, 0
	dbsprite   8, -16, $17, 0
	dbsprite   8, -24, $16, 0
	dbsprite   8, -32, $15, 0
	dbsprite   0, -16, $14, 0
	dbsprite   0, -24, $13, 0
	dbsprite   0, -32, $12, 0
	dbsprite  -8,  -8, $11, 0
	dbsprite  -8, -16, $10, 0
	dbsprite  -8, -24, $0f, 0
	dbsprite  -8, -32, $0e, 0
	dbsprite -16,  -8, $0d, 0
	dbsprite -16, -16, $0c, 0
	dbsprite -16, -24, $0b, 0
	dbsprite -24,  -9, $0a, 0
	dbsprite -24, -17, $09, 0

.frame_2
	db 19 ; size
	dbsprite  15, -24, $2b, 0
	dbsprite  16, -32, $2a, 0
	dbsprite   7,  -8, $29, 0
	dbsprite  10, -16, $28, 0
	dbsprite   7, -24, $27, 0
	dbsprite   8, -32, $26, 0
	dbsprite   1,   0, $25, 0
	dbsprite  -1,  -8, $24, 0
	dbsprite   2, -16, $23, 0
	dbsprite  -1, -24, $22, 0
	dbsprite   0, -32, $21, 0
	dbsprite  -8,   8, $20, 0
	dbsprite  -7,   0, $1f, 0
	dbsprite  -9,  -8, $1e, 0
	dbsprite  -6, -16, $1d, 0
	dbsprite -16,  16, $1c, 0
	dbsprite -16,   8, $1b, 0
	dbsprite -15,   0, $1a, 0
	dbsprite -24,  12, $19, 0

.frame_3
	db 23 ; size
	dbsprite   8,   8, $57, 1
	dbsprite   8,   0, $56, 1
	dbsprite  16,   8, $59, 1
	dbsprite  16,   0, $58, 1
	dbsprite  16,  24, $3e, 0
	dbsprite  16,  16, $3d, 0
	dbsprite  16,   8, $3c, 0
	dbsprite  16,   0, $3b, 0
	dbsprite  16,  -8, $3a, 0
	dbsprite  16, -16, $39, 0
	dbsprite  16, -24, $38, 0
	dbsprite  16, -32, $37, 0
	dbsprite   8,  16, $36, 0
	dbsprite   8,   8, $35, 0
	dbsprite   8,   0, $34, 0
	dbsprite   8,  -8, $33, 0
	dbsprite   8, -16, $32, 0
	dbsprite   8, -24, $31, 0
	dbsprite   8, -32, $30, 0
	dbsprite   0,  -8, $2f, 0
	dbsprite   0, -16, $2e, 0
	dbsprite   0, -24, $2d, 0
	dbsprite   0, -32, $2c, 0

.frame_4
	db 23 ; size
	dbsprite   8,  12, $52, 1
	dbsprite   8,   4, $51, 1
	dbsprite   8,  -4, $50, 1
	dbsprite  16,  12, $55, 1
	dbsprite  16,   4, $54, 1
	dbsprite  16,  -4, $53, 1
	dbsprite  16,  16, $4f, 0
	dbsprite  16,   8, $4e, 0
	dbsprite  16,   0, $4d, 0
	dbsprite  16,  -8, $4c, 0
	dbsprite  16, -16, $4b, 0
	dbsprite  16, -24, $4a, 0
	dbsprite  16, -32, $49, 0
	dbsprite   8,   8, $48, 0
	dbsprite   8,   0, $47, 0
	dbsprite   8,  -8, $46, 0
	dbsprite   8, -16, $45, 0
	dbsprite   8, -24, $44, 0
	dbsprite   8, -32, $43, 0
	dbsprite   0,  -8, $42, 0
	dbsprite   0, -16, $41, 0
	dbsprite   0, -24, $40, 0
	dbsprite   0, -32, $3f, 0

.frame_5
	db 19 ; size
	dbsprite  16,  24, $3e, 0
	dbsprite  16,  16, $3d, 0
	dbsprite  16,   8, $3c, 0
	dbsprite  16,   0, $3b, 0
	dbsprite  16,  -8, $3a, 0
	dbsprite  16, -16, $39, 0
	dbsprite  16, -24, $38, 0
	dbsprite  16, -32, $37, 0
	dbsprite   8,  16, $36, 0
	dbsprite   8,   8, $35, 0
	dbsprite   8,   0, $34, 0
	dbsprite   8,  -8, $33, 0
	dbsprite   8, -16, $32, 0
	dbsprite   8, -24, $31, 0
	dbsprite   8, -32, $30, 0
	dbsprite   0,  -8, $2f, 0
	dbsprite   0, -16, $2e, 0
	dbsprite   0, -24, $2d, 0
	dbsprite   0, -32, $2c, 0

OAMData46::
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
	dbsprite -24,  -5, $00, 0
	dbsprite -16,  -5, $01, 0
	dbsprite  -8,   0, $03, 0
	dbsprite  -8,  -8, $02, 0
	dbsprite   0,   0, $05, 0
	dbsprite   0,  -8, $04, 0
	dbsprite   8,   1, $08, 0
	dbsprite   8,  -7, $07, 0
	dbsprite   8, -15, $06, 0
	dbsprite  16,   1, $0b, 0
	dbsprite  16,  -7, $0a, 0
	dbsprite  16, -15, $09, 0

.frame_1
	db 11 ; size
	dbsprite  16,   6, $16, 0
	dbsprite  16,  -2, $15, 0
	dbsprite  16, -10, $14, 0
	dbsprite   8,   8, $13, 0
	dbsprite   8,   0, $12, 0
	dbsprite   8,  -8, $11, 0
	dbsprite   0,   7, $10, 0
	dbsprite   0,  -1, $0f, 0
	dbsprite  -8,   8, $0e, 0
	dbsprite  -8,   0, $0d, 0
	dbsprite -16,   4, $0c, 0

.frame_2
	db 14 ; size
	dbsprite   3,  20, $3b, 1
	dbsprite  -5,  24, $3a, 1
	dbsprite  -5,  16, $39, 1
	dbsprite -16,  15, $17, 0
	dbsprite  -8,  13, $18, 0
	dbsprite   0,  14, $1a, 0
	dbsprite   0,   6, $19, 0
	dbsprite   8,  15, $1d, 0
	dbsprite   8,   7, $1c, 0
	dbsprite   8,  -1, $1b, 0
	dbsprite  16,  -2, $1f, 0
	dbsprite  16, -10, $1e, 0
	dbsprite  16,  14, $21, 0
	dbsprite  16,   6, $20, 0

.frame_3
	db 14 ; size
	dbsprite  -1,  21, $3b, 1
	dbsprite  -9,  25, $3a, 1
	dbsprite  -9,  17, $39, 1
	dbsprite  16,   6, $16, 0
	dbsprite  16,  -2, $15, 0
	dbsprite  16, -10, $14, 0
	dbsprite   8,   8, $13, 0
	dbsprite   8,   0, $12, 0
	dbsprite   8,  -8, $11, 0
	dbsprite   0,   7, $10, 0
	dbsprite   0,  -1, $0f, 0
	dbsprite  -8,   8, $0e, 0
	dbsprite  -8,   0, $0d, 0
	dbsprite -16,   4, $0c, 0

.frame_4
	db 15 ; size
	dbsprite  -5,  22, $3b, 1
	dbsprite -13,  26, $3a, 1
	dbsprite -13,  18, $39, 1
	dbsprite -24,  -5, $00, 0
	dbsprite -16,  -5, $01, 0
	dbsprite  -8,   0, $03, 0
	dbsprite  -8,  -8, $02, 0
	dbsprite   0,   0, $05, 0
	dbsprite   0,  -8, $04, 0
	dbsprite   8,   1, $08, 0
	dbsprite   8,  -7, $07, 0
	dbsprite   8, -15, $06, 0
	dbsprite  16,   1, $0b, 0
	dbsprite  16,  -7, $0a, 0
	dbsprite  16, -15, $09, 0

.frame_5
	db 15 ; size
	dbsprite  -9,  21, $3b, 1
	dbsprite -17,  25, $3a, 1
	dbsprite -17,  17, $39, 1
	dbsprite  16,   2, $2d, 0
	dbsprite  16,  -6, $2c, 0
	dbsprite  16, -14, $2b, 0
	dbsprite   8,   0, $2a, 0
	dbsprite   8,  -8, $29, 0
	dbsprite   8, -16, $28, 0
	dbsprite   0,   0, $27, 0
	dbsprite   0,  -8, $26, 0
	dbsprite   0, -16, $25, 0
	dbsprite  -8,  -8, $24, 0
	dbsprite  -8, -16, $23, 0
	dbsprite -16,  -9, $22, 0

.frame_6
	db 14 ; size
	dbsprite -13,  20, $3b, 1
	dbsprite -21,  24, $3a, 1
	dbsprite -21,  16, $39, 1
	dbsprite -16, -23, $2e, 0
	dbsprite  -8, -20, $2f, 0
	dbsprite   0, -14, $31, 0
	dbsprite   0, -22, $30, 0
	dbsprite   8,  -7, $34, 0
	dbsprite   8, -15, $33, 0
	dbsprite   8, -23, $32, 0
	dbsprite  16,   2, $38, 0
	dbsprite  16,  -6, $37, 0
	dbsprite  16, -14, $36, 0
	dbsprite  16, -22, $35, 0

.frame_7
	db 15 ; size
	dbsprite -19,  24, $3b, 1
	dbsprite -27,  28, $3a, 1
	dbsprite -27,  20, $39, 1
	dbsprite  16,   2, $2d, 0
	dbsprite  16,  -6, $2c, 0
	dbsprite  16, -14, $2b, 0
	dbsprite   8,   0, $2a, 0
	dbsprite   8,  -8, $29, 0
	dbsprite   8, -16, $28, 0
	dbsprite   0,   0, $27, 0
	dbsprite   0,  -8, $26, 0
	dbsprite   0, -16, $25, 0
	dbsprite  -8,  -8, $24, 0
	dbsprite  -8, -16, $23, 0
	dbsprite -16,  -9, $22, 0

.frame_8
	db 15 ; size
	dbsprite -26,  28, $3b, 1
	dbsprite -34,  32, $3a, 1
	dbsprite -34,  24, $39, 1
	dbsprite -24,  -5, $00, 0
	dbsprite -16,  -5, $01, 0
	dbsprite  -8,   0, $03, 0
	dbsprite  -8,  -8, $02, 0
	dbsprite   0,   0, $05, 0
	dbsprite   0,  -8, $04, 0
	dbsprite   8,   1, $08, 0
	dbsprite   8,  -7, $07, 0
	dbsprite   8, -15, $06, 0
	dbsprite  16,   1, $0b, 0
	dbsprite  16,  -7, $0a, 0
	dbsprite  16, -15, $09, 0

.frame_9
	db 14 ; size
	dbsprite -25,  32, $3b, 1
	dbsprite -33,  36, $3a, 1
	dbsprite -33,  28, $39, 1
	dbsprite  16,   6, $16, 0
	dbsprite  16,  -2, $15, 0
	dbsprite  16, -10, $14, 0
	dbsprite   8,   8, $13, 0
	dbsprite   8,   0, $12, 0
	dbsprite   8,  -8, $11, 0
	dbsprite   0,   7, $10, 0
	dbsprite   0,  -1, $0f, 0
	dbsprite  -8,   8, $0e, 0
	dbsprite  -8,   0, $0d, 0
	dbsprite -16,   4, $0c, 0

.frame_10
	db 14 ; size
	dbsprite -24,  36, $3b, 1
	dbsprite -32,  40, $3a, 1
	dbsprite -32,  32, $39, 1
	dbsprite -16,  15, $17, 0
	dbsprite  -8,  13, $18, 0
	dbsprite   0,  14, $1a, 0
	dbsprite   0,   6, $19, 0
	dbsprite   8,  15, $1d, 0
	dbsprite   8,   7, $1c, 0
	dbsprite   8,  -1, $1b, 0
	dbsprite  16,  -2, $1f, 0
	dbsprite  16, -10, $1e, 0
	dbsprite  16,  14, $21, 0
	dbsprite  16,   6, $20, 0

OAMData47::
	dw .frame_0
	dw .frame_1
	dw .frame_2
	dw .frame_3
	dw .frame_4
	dw .frame_5
	dw .frame_6
	dw .frame_7
	dw .frame_8

.frame_0
	db 14 ; size
	dbsprite   0,  32, $0d, 0
	dbsprite   0,  24, $0c, 0
	dbsprite   0,  16, $0b, 0
	dbsprite   8,  32, $0a, 0
	dbsprite   8,  24, $09, 0
	dbsprite   8,  16, $08, 0
	dbsprite   8,   8, $07, 0
	dbsprite  16,  24, $06, 0
	dbsprite  16,  16, $05, 0
	dbsprite  16,   8, $04, 2
	dbsprite  16,   0, $03, 2
	dbsprite  24,   8, $02, 2
	dbsprite  24,   0, $01, 2
	dbsprite  24,  -8, $00, 2

.frame_1
	db 14 ; size
	dbsprite   8,  -8, $33, 2 | OAM_XFLIP
	dbsprite   8,   0, $33, 2
	dbsprite  24,  -8, $16, 2 | OAM_XFLIP
	dbsprite  16,  -8, $15, 2 | OAM_XFLIP
	dbsprite   8,  -8, $14, 0 | OAM_XFLIP
	dbsprite  24,   0, $16, 2
	dbsprite  16,   0, $15, 2
	dbsprite   8,   0, $14, 0
	dbsprite   0,   0, $13, 0
	dbsprite   0,  -8, $12, 0
	dbsprite   0, -16, $11, 0
	dbsprite  -8,   0, $10, 0
	dbsprite  -8,  -8, $0f, 0
	dbsprite  -8, -16, $0e, 0

.frame_2
	db 15 ; size
	dbsprite  24,   0, $25, 2
	dbsprite  24,  -8, $24, 2
	dbsprite  24, -16, $23, 2
	dbsprite  16,  -8, $22, 2
	dbsprite  16, -16, $21, 2
	dbsprite  16, -24, $20, 0
	dbsprite  16, -32, $1f, 0
	dbsprite  16, -40, $1e, 0
	dbsprite   8, -16, $1d, 0
	dbsprite   8, -24, $1c, 0
	dbsprite   8, -32, $1b, 0
	dbsprite   8, -40, $1a, 0
	dbsprite   0, -24, $19, 0
	dbsprite   0, -32, $18, 0
	dbsprite   0, -40, $17, 0

.frame_3
	db 23 ; size
	dbsprite   8,  -8, $33, 2 | OAM_XFLIP
	dbsprite   8,   0, $33, 2
	dbsprite  24,  -8, $16, 2 | OAM_XFLIP
	dbsprite  16,  -8, $15, 2 | OAM_XFLIP
	dbsprite   8,  -8, $14, 0 | OAM_XFLIP
	dbsprite  24,   0, $16, 2
	dbsprite  16,   0, $15, 2
	dbsprite   8,   0, $14, 0
	dbsprite   0,   0, $13, 0
	dbsprite   0,  -8, $12, 0
	dbsprite   0, -16, $11, 0
	dbsprite  -8,   0, $10, 0
	dbsprite  -8,  -8, $0f, 0
	dbsprite  -8, -16, $0e, 0
	dbsprite  -4,   4, $32, 1
	dbsprite  -4,  -4, $31, 1
	dbsprite  -4, -12, $30, 1
	dbsprite -12,   4, $2f, 1
	dbsprite -12,  -4, $2e, 1
	dbsprite -12, -12, $2d, 1
	dbsprite -20,   4, $2c, 1
	dbsprite -20,  -4, $2b, 1
	dbsprite -20, -12, $2a, 1

.frame_4
	db 19 ; size
	dbsprite  24,   0, $25, 2
	dbsprite  24,  -8, $24, 2
	dbsprite  24, -16, $23, 2
	dbsprite  16,  -8, $22, 2
	dbsprite  16, -16, $21, 2
	dbsprite  16, -24, $20, 0
	dbsprite  16, -32, $1f, 0
	dbsprite  16, -40, $1e, 0
	dbsprite   8, -16, $1d, 0
	dbsprite   8, -24, $1c, 0
	dbsprite   8, -32, $1b, 0
	dbsprite   8, -40, $1a, 0
	dbsprite   0, -24, $19, 0
	dbsprite   0, -32, $18, 0
	dbsprite   0, -40, $17, 0
	dbsprite  -8,  -4, $29, 1
	dbsprite  -8, -12, $28, 1
	dbsprite -16,  -4, $27, 1
	dbsprite -16, -12, $26, 1

.frame_5
	db 18 ; size
	dbsprite   0,  32, $0d, 0
	dbsprite   0,  24, $0c, 0
	dbsprite   0,  16, $0b, 0
	dbsprite   8,  32, $0a, 0
	dbsprite   8,  24, $09, 0
	dbsprite   8,  16, $08, 0
	dbsprite   8,   8, $07, 0
	dbsprite  16,  24, $06, 0
	dbsprite  16,  16, $05, 0
	dbsprite  16,   8, $04, 2
	dbsprite  16,   0, $03, 2
	dbsprite  24,   8, $02, 2
	dbsprite  24,   0, $01, 2
	dbsprite  24,  -8, $00, 2
	dbsprite  -8,   4, $29, 1
	dbsprite  -8,  -4, $28, 1
	dbsprite -16,   4, $27, 1
	dbsprite -16,  -4, $26, 1

.frame_6
	db 11 ; size
	dbsprite   8,  36, $0d, 0
	dbsprite   8,  28, $0c, 0
	dbsprite   8,  20, $0b, 0
	dbsprite  16,  36, $0a, 0
	dbsprite  16,  28, $09, 0
	dbsprite  16,  20, $08, 0
	dbsprite  16,  12, $07, 0
	dbsprite  24,  28, $06, 0
	dbsprite  24,  20, $05, 0
	dbsprite  24,  12, $04, 2
	dbsprite  24,   4, $03, 2

.frame_7
	db 7 ; size
	dbsprite  16,  40, $0d, 0
	dbsprite  16,  32, $0c, 0
	dbsprite  16,  24, $0b, 0
	dbsprite  24,  40, $0a, 0
	dbsprite  24,  32, $09, 0
	dbsprite  24,  24, $08, 0
	dbsprite  24,  16, $07, 0

.frame_8
	db 3 ; size
	dbsprite  24,  44, $0d, 0
	dbsprite  24,  36, $0c, 0
	dbsprite  24,  28, $0b, 0

OAMData48::
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
	dbsprite   0,   0, $00, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite   0,  -8, $00, 0 | OAM_YFLIP
	dbsprite  -8,   0, $00, 0 | OAM_XFLIP
	dbsprite  -8,  -8, $00, 0

.frame_1
	db 4 ; size
	dbsprite   0,  -8, $01, 0
	dbsprite   0,   0, $00, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite  -8,   0, $00, 0 | OAM_XFLIP
	dbsprite  -8,  -8, $00, 0

.frame_2
	db 5 ; size
	dbsprite   1,  -9, $03, 0
	dbsprite   0,  -8, $02, 0
	dbsprite   0,   0, $00, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite  -8,   0, $00, 0 | OAM_XFLIP
	dbsprite  -8,  -8, $00, 0

.frame_3
	db 5 ; size
	dbsprite   2, -10, $03, 0
	dbsprite   0,  -8, $02, 0
	dbsprite   0,   0, $00, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite  -8,   0, $00, 0 | OAM_XFLIP
	dbsprite  -8,  -8, $00, 0

.frame_4
	db 5 ; size
	dbsprite   4,  -9, $03, 0
	dbsprite  -2,  -8, $02, 0
	dbsprite  -2,   0, $00, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite -10,   0, $00, 0 | OAM_XFLIP
	dbsprite -10,  -8, $00, 0

.frame_5
	db 6 ; size
	dbsprite   7,  -3, $03, 0
	dbsprite   5,  -3, $06, 0
	dbsprite  -3,   0, $05, 0
	dbsprite  -3,  -8, $04, 0
	dbsprite -11,   0, $00, 0 | OAM_XFLIP
	dbsprite -11,  -8, $00, 0

.frame_6
	db 6 ; size
	dbsprite   8,  -3, $03, 0 | OAM_YFLIP
	dbsprite   5,  -3, $06, 0
	dbsprite  -3,   0, $05, 0
	dbsprite  -3,  -8, $04, 0
	dbsprite -11,   0, $00, 0 | OAM_XFLIP
	dbsprite -11,  -8, $00, 0

.frame_7
	db 6 ; size
	dbsprite   8,  -3, $03, 0
	dbsprite   5,  -3, $06, 0
	dbsprite  -3,   0, $05, 0
	dbsprite  -3,  -8, $04, 0
	dbsprite -11,   0, $00, 0 | OAM_XFLIP
	dbsprite -11,  -8, $00, 0

.frame_8
	db 6 ; size
	dbsprite   8,  -3, $03, 1
	dbsprite   5,  -3, $06, 1
	dbsprite  -3,   0, $05, 1
	dbsprite  -3,  -8, $04, 1
	dbsprite -11,   0, $00, 1 | OAM_XFLIP
	dbsprite -11,  -8, $00, 1

.frame_9
	db 6 ; size
	dbsprite   8,  -3, $03, 2
	dbsprite   5,  -3, $06, 2
	dbsprite  -3,   0, $05, 2
	dbsprite  -3,  -8, $04, 2
	dbsprite -11,   0, $00, 2 | OAM_XFLIP
	dbsprite -11,  -8, $00, 2

OAMData49::
	dw .frame_0
	dw .frame_1
	dw .frame_2
	dw .frame_3
	dw .frame_4
	dw .frame_5
	dw .frame_6
	dw .frame_7

.frame_0
	db 15 ; size
	dbsprite   2,   4, $0e, 2 | OAM_XFLIP
	dbsprite   2,  12, $0d, 2 | OAM_XFLIP
	dbsprite   2,  20, $0c, 2 | OAM_XFLIP
	dbsprite   4, -16, $0b, 1 | OAM_XFLIP
	dbsprite   4,  -8, $0a, 1 | OAM_XFLIP
	dbsprite   4,   0, $09, 1 | OAM_XFLIP
	dbsprite   4,   8, $08, 1 | OAM_XFLIP
	dbsprite  -4, -16, $07, 0 | OAM_XFLIP
	dbsprite  -4,  -8, $06, 0 | OAM_XFLIP
	dbsprite  -4,   0, $05, 0 | OAM_XFLIP
	dbsprite  -4,   8, $04, 0 | OAM_XFLIP
	dbsprite -12, -16, $03, 0 | OAM_XFLIP
	dbsprite -12,  -8, $02, 0 | OAM_XFLIP
	dbsprite -12,   0, $01, 0 | OAM_XFLIP
	dbsprite -12,   8, $00, 0 | OAM_XFLIP

.frame_1
	db 15 ; size
	dbsprite   2,   4, $11, 2 | OAM_XFLIP
	dbsprite   2,  12, $10, 2 | OAM_XFLIP
	dbsprite   2,  20, $0f, 2 | OAM_XFLIP
	dbsprite   4, -16, $0b, 1 | OAM_XFLIP
	dbsprite   4,  -8, $0a, 1 | OAM_XFLIP
	dbsprite   4,   0, $09, 1 | OAM_XFLIP
	dbsprite   4,   8, $08, 1 | OAM_XFLIP
	dbsprite  -4, -16, $07, 0 | OAM_XFLIP
	dbsprite  -4,  -8, $06, 0 | OAM_XFLIP
	dbsprite  -4,   0, $05, 0 | OAM_XFLIP
	dbsprite  -4,   8, $04, 0 | OAM_XFLIP
	dbsprite -12, -16, $03, 0 | OAM_XFLIP
	dbsprite -12,  -8, $02, 0 | OAM_XFLIP
	dbsprite -12,   0, $01, 0 | OAM_XFLIP
	dbsprite -12,   8, $00, 0 | OAM_XFLIP

.frame_2
	db 16 ; size
	dbsprite   2,  28, $0c, 2 | OAM_XFLIP
	dbsprite   2,   4, $14, 2 | OAM_XFLIP
	dbsprite   2,  12, $13, 2 | OAM_XFLIP
	dbsprite   2,  20, $12, 2 | OAM_XFLIP
	dbsprite   4, -16, $0b, 1 | OAM_XFLIP
	dbsprite   4,  -8, $0a, 1 | OAM_XFLIP
	dbsprite   4,   0, $09, 1 | OAM_XFLIP
	dbsprite   4,   8, $08, 1 | OAM_XFLIP
	dbsprite  -4, -16, $07, 0 | OAM_XFLIP
	dbsprite  -4,  -8, $06, 0 | OAM_XFLIP
	dbsprite  -4,   0, $05, 0 | OAM_XFLIP
	dbsprite  -4,   8, $04, 0 | OAM_XFLIP
	dbsprite -12, -16, $03, 0 | OAM_XFLIP
	dbsprite -12,  -8, $02, 0 | OAM_XFLIP
	dbsprite -12,   0, $01, 0 | OAM_XFLIP
	dbsprite -12,   8, $00, 0 | OAM_XFLIP

.frame_3
	db 31 ; size
	dbsprite   2,   4, $0e, 2 | OAM_XFLIP
	dbsprite   2,  12, $0d, 2 | OAM_XFLIP
	dbsprite   2,  20, $0c, 2 | OAM_XFLIP
	dbsprite   4, -16, $0b, 1 | OAM_XFLIP
	dbsprite   4,  -8, $0a, 1 | OAM_XFLIP
	dbsprite   4,   0, $09, 1 | OAM_XFLIP
	dbsprite   4,   8, $08, 1 | OAM_XFLIP
	dbsprite  -4, -16, $07, 0 | OAM_XFLIP
	dbsprite  -4,  -8, $06, 0 | OAM_XFLIP
	dbsprite  -4,   0, $05, 0 | OAM_XFLIP
	dbsprite  -4,   8, $04, 0 | OAM_XFLIP
	dbsprite -12, -16, $03, 0 | OAM_XFLIP
	dbsprite -12,  -8, $02, 0 | OAM_XFLIP
	dbsprite -12,   0, $01, 0 | OAM_XFLIP
	dbsprite -12,   8, $00, 0 | OAM_XFLIP
	dbsprite   8,  -8, $3e, 1
	dbsprite   8, -16, $3d, 1
	dbsprite   8, -24, $3c, 1
	dbsprite   8, -32, $3b, 1
	dbsprite   0,  -8, $3a, 1
	dbsprite   0, -16, $39, 1
	dbsprite   0, -24, $38, 1
	dbsprite   0, -32, $37, 1
	dbsprite  -8,  -8, $36, 1
	dbsprite  -8, -16, $35, 1
	dbsprite  -8, -24, $34, 1
	dbsprite  -8, -32, $33, 1
	dbsprite -16,  -8, $32, 1
	dbsprite -16, -16, $31, 1
	dbsprite -16, -24, $30, 1
	dbsprite -16, -32, $2f, 1

.frame_4
	db 17 ; size
	dbsprite  14,  -1, $25, 2 | OAM_XFLIP
	dbsprite  14,   7, $24, 2 | OAM_XFLIP
	dbsprite   6,  -1, $23, 2 | OAM_XFLIP
	dbsprite   6,   7, $22, 2 | OAM_XFLIP
	dbsprite  10,  -5, $21, 1 | OAM_XFLIP
	dbsprite  10,   3, $20, 1 | OAM_XFLIP
	dbsprite   2, -13, $1f, 1 | OAM_XFLIP
	dbsprite   2,  -5, $1e, 1 | OAM_XFLIP
	dbsprite   2,   3, $1d, 0 | OAM_XFLIP
	dbsprite   2,  11, $1c, 0 | OAM_XFLIP
	dbsprite  -6, -13, $1b, 1 | OAM_XFLIP
	dbsprite  -6,  -5, $1a, 0 | OAM_XFLIP
	dbsprite  -6,   3, $19, 0 | OAM_XFLIP
	dbsprite  -6,  11, $18, 0 | OAM_XFLIP
	dbsprite -14, -13, $17, 0 | OAM_XFLIP
	dbsprite -14,  -5, $16, 0 | OAM_XFLIP
	dbsprite -14,   3, $15, 0 | OAM_XFLIP

.frame_5
	db 17 ; size
	dbsprite  14,  -1, $29, 2 | OAM_XFLIP
	dbsprite  14,   7, $28, 2 | OAM_XFLIP
	dbsprite   6,  -1, $27, 2 | OAM_XFLIP
	dbsprite   6,   7, $26, 2 | OAM_XFLIP
	dbsprite  10,  -5, $21, 1 | OAM_XFLIP
	dbsprite  10,   3, $20, 1 | OAM_XFLIP
	dbsprite   2, -13, $1f, 1 | OAM_XFLIP
	dbsprite   2,  -5, $1e, 1 | OAM_XFLIP
	dbsprite   2,   3, $1d, 0 | OAM_XFLIP
	dbsprite   2,  11, $1c, 0 | OAM_XFLIP
	dbsprite  -6, -13, $1b, 1 | OAM_XFLIP
	dbsprite  -6,  -5, $1a, 0 | OAM_XFLIP
	dbsprite  -6,   3, $19, 0 | OAM_XFLIP
	dbsprite  -6,  11, $18, 0 | OAM_XFLIP
	dbsprite -14, -13, $17, 0 | OAM_XFLIP
	dbsprite -14,  -5, $16, 0 | OAM_XFLIP
	dbsprite -14,   3, $15, 0 | OAM_XFLIP

.frame_6
	db 18 ; size
	dbsprite  22,  15, $2e, 2 | OAM_XFLIP
	dbsprite  14,  -1, $2d, 2 | OAM_XFLIP
	dbsprite  14,   7, $2c, 2 | OAM_XFLIP
	dbsprite   6,  -1, $2b, 2 | OAM_XFLIP
	dbsprite   6,   7, $2a, 2 | OAM_XFLIP
	dbsprite  10,  -5, $21, 1 | OAM_XFLIP
	dbsprite  10,   3, $20, 1 | OAM_XFLIP
	dbsprite   2, -13, $1f, 1 | OAM_XFLIP
	dbsprite   2,  -5, $1e, 1 | OAM_XFLIP
	dbsprite   2,   3, $1d, 0 | OAM_XFLIP
	dbsprite   2,  11, $1c, 0 | OAM_XFLIP
	dbsprite  -6, -13, $1b, 1 | OAM_XFLIP
	dbsprite  -6,  -5, $1a, 0 | OAM_XFLIP
	dbsprite  -6,   3, $19, 0 | OAM_XFLIP
	dbsprite  -6,  11, $18, 0 | OAM_XFLIP
	dbsprite -14, -13, $17, 0 | OAM_XFLIP
	dbsprite -14,  -5, $16, 0 | OAM_XFLIP
	dbsprite -14,   3, $15, 0 | OAM_XFLIP

.frame_7
	db 33 ; size
	dbsprite  14,  -1, $25, 2 | OAM_XFLIP
	dbsprite  14,   7, $24, 2 | OAM_XFLIP
	dbsprite   6,  -1, $23, 2 | OAM_XFLIP
	dbsprite   6,   7, $22, 2 | OAM_XFLIP
	dbsprite  10,  -5, $21, 1 | OAM_XFLIP
	dbsprite  10,   3, $20, 1 | OAM_XFLIP
	dbsprite   2, -13, $1f, 1 | OAM_XFLIP
	dbsprite   2,  -5, $1e, 1 | OAM_XFLIP
	dbsprite   2,   3, $1d, 0 | OAM_XFLIP
	dbsprite   2,  11, $1c, 0 | OAM_XFLIP
	dbsprite  -6, -13, $1b, 1 | OAM_XFLIP
	dbsprite  -6,  -5, $1a, 0 | OAM_XFLIP
	dbsprite  -6,   3, $19, 0 | OAM_XFLIP
	dbsprite  -6,  11, $18, 0 | OAM_XFLIP
	dbsprite -14, -13, $17, 0 | OAM_XFLIP
	dbsprite -14,  -5, $16, 0 | OAM_XFLIP
	dbsprite -14,   3, $15, 0 | OAM_XFLIP
	dbsprite   8, -32, $3e, 1 | OAM_XFLIP
	dbsprite   8, -24, $3d, 1 | OAM_XFLIP
	dbsprite   8, -16, $3c, 1 | OAM_XFLIP
	dbsprite   8,  -8, $3b, 1 | OAM_XFLIP
	dbsprite   0, -32, $3a, 1 | OAM_XFLIP
	dbsprite   0, -24, $39, 1 | OAM_XFLIP
	dbsprite   0, -16, $38, 1 | OAM_XFLIP
	dbsprite   0,  -8, $37, 1 | OAM_XFLIP
	dbsprite  -8, -32, $36, 1 | OAM_XFLIP
	dbsprite  -8, -24, $35, 1 | OAM_XFLIP
	dbsprite  -8, -16, $34, 1 | OAM_XFLIP
	dbsprite  -8,  -8, $33, 1 | OAM_XFLIP
	dbsprite -16, -32, $32, 1 | OAM_XFLIP
	dbsprite -16, -24, $31, 1 | OAM_XFLIP
	dbsprite -16, -16, $30, 1 | OAM_XFLIP
	dbsprite -16,  -8, $2f, 1 | OAM_XFLIP

OAMData4A::
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

.frame_0
	db 9 ; size
	dbsprite -18, -40, $11, 0
	dbsprite -18, -48, $10, 0
	dbsprite -18, -56, $0f, 0
	dbsprite -26, -40, $0e, 0
	dbsprite -26, -48, $0d, 0
	dbsprite -26, -56, $0c, 0
	dbsprite -34, -40, $0b, 0
	dbsprite -34, -48, $0a, 0
	dbsprite -34, -56, $09, 0

.frame_1
	db 5 ; size
	dbsprite  -9, -24, $03, 1 | OAM_YFLIP
	dbsprite  -9, -16, $04, 1 | OAM_YFLIP
	dbsprite -17, -16, $06, 1 | OAM_YFLIP
	dbsprite -25, -24, $07, 1 | OAM_YFLIP
	dbsprite -17, -24, $05, 1 | OAM_YFLIP

.frame_2
	db 9 ; size
	dbsprite -21, -31, $08, 0
	dbsprite  -9, -24, $03, 2 | OAM_YFLIP
	dbsprite  -9, -16, $04, 2 | OAM_YFLIP
	dbsprite -17, -16, $06, 2 | OAM_YFLIP
	dbsprite -25, -24, $07, 2 | OAM_YFLIP
	dbsprite -17, -24, $05, 2 | OAM_YFLIP
	dbsprite -21, -23, $00, 0
	dbsprite -13, -23, $02, 0
	dbsprite -13, -31, $01, 0

.frame_3
	db 13 ; size
	dbsprite   0,  32, $11, 0 | OAM_XFLIP
	dbsprite   0,  40, $10, 0 | OAM_XFLIP
	dbsprite   0,  48, $0f, 0 | OAM_XFLIP
	dbsprite  -8,  32, $0e, 0 | OAM_XFLIP
	dbsprite  -8,  40, $0d, 0 | OAM_XFLIP
	dbsprite  -8,  48, $0c, 0 | OAM_XFLIP
	dbsprite -16,  32, $0b, 0 | OAM_XFLIP
	dbsprite -16,  40, $0a, 0 | OAM_XFLIP
	dbsprite -16,  48, $09, 0 | OAM_XFLIP
	dbsprite -21, -31, $08, 0
	dbsprite -21, -23, $00, 0
	dbsprite -13, -23, $02, 0
	dbsprite -13, -31, $01, 0

.frame_4
	db 9 ; size
	dbsprite -21, -31, $08, 0
	dbsprite   8,  16, $03, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite   8,   8, $04, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite   0,   8, $06, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite  -8,  16, $07, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite   0,  16, $05, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite -21, -23, $00, 0
	dbsprite -13, -23, $02, 0
	dbsprite -13, -31, $01, 0

.frame_5
	db 13 ; size
	dbsprite -21, -31, $08, 0
	dbsprite   0,  24, $08, 0 | OAM_XFLIP
	dbsprite   8,  16, $03, 2 | OAM_XFLIP | OAM_YFLIP
	dbsprite   8,   8, $04, 2 | OAM_XFLIP | OAM_YFLIP
	dbsprite   0,   8, $06, 2 | OAM_XFLIP | OAM_YFLIP
	dbsprite  -8,  16, $07, 2 | OAM_XFLIP | OAM_YFLIP
	dbsprite   0,  16, $05, 2 | OAM_XFLIP | OAM_YFLIP
	dbsprite -21, -23, $00, 0
	dbsprite -13, -23, $02, 0
	dbsprite -13, -31, $01, 0
	dbsprite   8,  24, $01, 0 | OAM_XFLIP
	dbsprite   0,  16, $00, 0 | OAM_XFLIP
	dbsprite   8,  16, $02, 0 | OAM_XFLIP

.frame_6
	db 17 ; size
	dbsprite  10, -32, $11, 0 | OAM_YFLIP
	dbsprite  10, -40, $10, 0 | OAM_YFLIP
	dbsprite  10, -48, $0f, 0 | OAM_YFLIP
	dbsprite  18, -32, $0e, 0 | OAM_YFLIP
	dbsprite  18, -40, $0d, 0 | OAM_YFLIP
	dbsprite  18, -48, $0c, 0 | OAM_YFLIP
	dbsprite  26, -32, $0b, 0 | OAM_YFLIP
	dbsprite  26, -40, $0a, 0 | OAM_YFLIP
	dbsprite  26, -48, $09, 0 | OAM_YFLIP
	dbsprite   0,  24, $08, 0 | OAM_XFLIP
	dbsprite -21, -31, $08, 0
	dbsprite   8,  24, $01, 0 | OAM_XFLIP
	dbsprite   0,  16, $00, 0 | OAM_XFLIP
	dbsprite   8,  16, $02, 0 | OAM_XFLIP
	dbsprite -21, -23, $00, 0
	dbsprite -13, -23, $02, 0
	dbsprite -13, -31, $01, 0

.frame_7
	db 13 ; size
	dbsprite -21, -31, $08, 0
	dbsprite   0,  24, $08, 0 | OAM_XFLIP
	dbsprite   2, -17, $03, 1
	dbsprite   2,  -9, $04, 1
	dbsprite  10,  -9, $06, 1
	dbsprite  10, -17, $05, 1
	dbsprite  18, -17, $07, 1
	dbsprite   8,  24, $01, 0 | OAM_XFLIP
	dbsprite   0,  16, $00, 0 | OAM_XFLIP
	dbsprite   8,  16, $02, 0 | OAM_XFLIP
	dbsprite -21, -23, $00, 0
	dbsprite -13, -23, $02, 0
	dbsprite -13, -31, $01, 0

.frame_8
	db 17 ; size
	dbsprite  13, -24, $08, 0 | OAM_YFLIP
	dbsprite   0,  24, $08, 0 | OAM_XFLIP
	dbsprite -21, -31, $08, 0
	dbsprite   2, -17, $03, 2
	dbsprite   2,  -9, $04, 2
	dbsprite  10,  -9, $06, 2
	dbsprite  10, -17, $05, 2
	dbsprite   8,  24, $01, 0 | OAM_XFLIP
	dbsprite   0,  16, $00, 0 | OAM_XFLIP
	dbsprite   8,  16, $02, 0 | OAM_XFLIP
	dbsprite  18, -17, $07, 2
	dbsprite  13, -16, $00, 0 | OAM_YFLIP
	dbsprite   5, -16, $02, 0 | OAM_YFLIP
	dbsprite   5, -24, $01, 0 | OAM_YFLIP
	dbsprite -21, -23, $00, 0
	dbsprite -13, -23, $02, 0
	dbsprite -13, -31, $01, 0

.frame_9
	db 12 ; size
	dbsprite   0,  24, $08, 0 | OAM_XFLIP
	dbsprite  13, -24, $08, 0 | OAM_YFLIP
	dbsprite -21, -31, $08, 0
	dbsprite   8,  24, $01, 0 | OAM_XFLIP
	dbsprite   0,  16, $00, 0 | OAM_XFLIP
	dbsprite   8,  16, $02, 0 | OAM_XFLIP
	dbsprite  13, -16, $00, 0 | OAM_YFLIP
	dbsprite   5, -16, $02, 0 | OAM_YFLIP
	dbsprite   5, -24, $01, 0 | OAM_YFLIP
	dbsprite -21, -23, $00, 0
	dbsprite -13, -23, $02, 0
	dbsprite -13, -31, $01, 0

.frame_10
	db 4 ; size
	dbsprite -21, -31, $08, 0
	dbsprite -21, -23, $00, 0
	dbsprite -13, -23, $02, 0
	dbsprite -13, -31, $01, 0

.frame_11
	db 4 ; size
	dbsprite -20, -31, $08, 0
	dbsprite -20, -23, $00, 0
	dbsprite -15, -23, $02, 0
	dbsprite -15, -31, $01, 0

OAMData4C::
	dw .frame_0
	dw .frame_1
	dw .frame_2
	dw .frame_3
	dw .frame_4
	dw .frame_5
	dw .frame_6
	dw .frame_7

.frame_0
	db 12 ; size
	dbsprite -16,  -4, $0b, 0
	dbsprite  -8,  -1, $0a, 0
	dbsprite  -8,  -9, $09, 0
	dbsprite   0,   4, $08, 0
	dbsprite   0,  -4, $07, 0
	dbsprite   0, -12, $06, 0
	dbsprite   8,   4, $05, 0
	dbsprite   8,  -4, $04, 0
	dbsprite   8, -12, $03, 0
	dbsprite  16,   4, $02, 0
	dbsprite  16,  -4, $01, 0
	dbsprite  16, -12, $00, 0

.frame_1
	db 12 ; size
	dbsprite -16,  -4, $13, 0
	dbsprite  -8,  -1, $12, 0
	dbsprite  -8,  -9, $11, 0
	dbsprite   0,   4, $10, 0
	dbsprite   0,  -4, $07, 0
	dbsprite   0, -12, $0f, 0
	dbsprite   8,   4, $0e, 0
	dbsprite   8,  -4, $0d, 0
	dbsprite   8, -12, $0c, 0
	dbsprite  16,   4, $02, 0
	dbsprite  16,  -4, $01, 0
	dbsprite  16, -12, $00, 0

.frame_2
	db 12 ; size
	dbsprite -16, -11, $1b, 0
	dbsprite  -8,  -1, $1a, 0
	dbsprite  -8,  -9, $19, 0
	dbsprite   0,  -4, $07, 0
	dbsprite   0,   4, $18, 0
	dbsprite   0, -12, $17, 0
	dbsprite   8,   4, $16, 0
	dbsprite   8,  -4, $15, 0
	dbsprite   8, -12, $14, 0
	dbsprite  16,   4, $02, 0
	dbsprite  16,  -4, $01, 0
	dbsprite  16, -12, $00, 0

.frame_3
	db 13 ; size
	dbsprite -18,  -7, $1c, 1
	dbsprite -16,  -4, $0b, 0
	dbsprite  -8,  -1, $0a, 0
	dbsprite  -8,  -9, $09, 0
	dbsprite   0,   4, $08, 0
	dbsprite   0,  -4, $07, 0
	dbsprite   0, -12, $06, 0
	dbsprite   8,   4, $05, 0
	dbsprite   8,  -4, $04, 0
	dbsprite   8, -12, $03, 0
	dbsprite  16,   4, $02, 0
	dbsprite  16,  -4, $01, 0
	dbsprite  16, -12, $00, 0

.frame_4
	db 13 ; size
	dbsprite -18,  -7, $1d, 1
	dbsprite -16,  -4, $0b, 0
	dbsprite  -8,  -1, $0a, 0
	dbsprite  -8,  -9, $09, 0
	dbsprite   0,   4, $08, 0
	dbsprite   0,  -4, $07, 0
	dbsprite   0, -12, $06, 0
	dbsprite   8,   4, $05, 0
	dbsprite   8,  -4, $04, 0
	dbsprite   8, -12, $03, 0
	dbsprite  16,   4, $02, 0
	dbsprite  16,  -4, $01, 0
	dbsprite  16, -12, $00, 0

.frame_5
	db 16 ; size
	dbsprite -14,  -3, $1e, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite -14, -11, $1e, 1 | OAM_YFLIP
	dbsprite -22,  -3, $1e, 1 | OAM_XFLIP
	dbsprite -22, -11, $1e, 1
	dbsprite -16,  -4, $0b, 0
	dbsprite  -8,  -1, $0a, 0
	dbsprite  -8,  -9, $09, 0
	dbsprite   0,   4, $08, 0
	dbsprite   0,  -4, $07, 0
	dbsprite   0, -12, $06, 0
	dbsprite   8,   4, $05, 0
	dbsprite   8,  -4, $04, 0
	dbsprite   8, -12, $03, 0
	dbsprite  16,   4, $02, 0
	dbsprite  16,  -4, $01, 0
	dbsprite  16, -12, $00, 0

.frame_6
	db 21 ; size
	dbsprite -18,  -7, $22, 1
	dbsprite -10, -15, $1f, 1 | OAM_YFLIP
	dbsprite -10,   1, $1f, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite -26,   1, $1f, 1 | OAM_XFLIP
	dbsprite -18,   1, $21, 1 | OAM_XFLIP
	dbsprite -18, -15, $21, 1
	dbsprite -10,  -7, $20, 1 | OAM_YFLIP
	dbsprite -26,  -7, $20, 1
	dbsprite -26, -15, $1f, 1
	dbsprite -16,  -4, $0b, 0
	dbsprite  -8,  -1, $0a, 0
	dbsprite  -8,  -9, $09, 0
	dbsprite   0,   4, $08, 0
	dbsprite   0,  -4, $07, 0
	dbsprite   0, -12, $06, 0
	dbsprite   8,   4, $05, 0
	dbsprite   8,  -4, $04, 0
	dbsprite   8, -12, $03, 0
	dbsprite  16,   4, $02, 0
	dbsprite  16,  -4, $01, 0
	dbsprite  16, -12, $00, 0

.frame_7
	db 17 ; size
	dbsprite -10,  -7, $23, 1 | OAM_YFLIP
	dbsprite -26,  -7, $23, 1
	dbsprite -18,   1, $24, 1 | OAM_XFLIP
	dbsprite -18, -15, $24, 1
	dbsprite -18,  -7, $25, 1
	dbsprite -16,  -4, $0b, 0
	dbsprite  -8,  -1, $0a, 0
	dbsprite  -8,  -9, $09, 0
	dbsprite   0,   4, $08, 0
	dbsprite   0,  -4, $07, 0
	dbsprite   0, -12, $06, 0
	dbsprite   8,   4, $05, 0
	dbsprite   8,  -4, $04, 0
	dbsprite   8, -12, $03, 0
	dbsprite  16,   4, $02, 0
	dbsprite  16,  -4, $01, 0
	dbsprite  16, -12, $00, 0

OAMData4E::
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

.frame_0
	db 6 ; size
	dbsprite  16, -32, $05, 0
	dbsprite   8, -24, $04, 0
	dbsprite   8, -32, $03, 0
	dbsprite   0, -24, $02, 0
	dbsprite   0, -32, $01, 0
	dbsprite  -8, -32, $00, 0

.frame_1
	db 11 ; size
	dbsprite  16, -32, $05, 1
	dbsprite   8, -24, $04, 1
	dbsprite   8, -32, $03, 1
	dbsprite   0, -24, $02, 1
	dbsprite   0, -32, $01, 1
	dbsprite  -8, -32, $00, 1
	dbsprite  -8, -16, $0a, 0
	dbsprite  -8, -24, $09, 0
	dbsprite -16, -16, $08, 0
	dbsprite -16, -24, $07, 0
	dbsprite -24, -16, $06, 0

.frame_2
	db 15 ; size
	dbsprite -14,  -8, $0e, 0
	dbsprite -14, -16, $0d, 0
	dbsprite -22,  -8, $0c, 0
	dbsprite -22, -16, $0b, 0
	dbsprite  -8, -16, $0a, 1
	dbsprite  -8, -24, $09, 1
	dbsprite -16, -16, $08, 1
	dbsprite -16, -24, $07, 1
	dbsprite -24, -16, $06, 1
	dbsprite  16, -32, $05, 2
	dbsprite   8, -24, $04, 2
	dbsprite   8, -32, $03, 2
	dbsprite   0, -24, $02, 2
	dbsprite   0, -32, $01, 2
	dbsprite  -8, -32, $00, 2

.frame_3
	db 10 ; size
	dbsprite -15, -10, $10, 0
	dbsprite -23, -10, $0f, 0
	dbsprite -14,  -8, $0e, 1
	dbsprite -14, -16, $0d, 1
	dbsprite -22,  -8, $0c, 1
	dbsprite -22, -16, $0b, 1
	dbsprite  -8, -16, $0a, 2
	dbsprite  -8, -24, $09, 2
	dbsprite -16, -16, $08, 2
	dbsprite -16, -24, $07, 2

.frame_4
	db 8 ; size
	dbsprite -16,  -8, $12, 0
	dbsprite -24,  -8, $11, 0
	dbsprite -15, -10, $10, 1
	dbsprite -23, -10, $0f, 1
	dbsprite -14,  -8, $0e, 2
	dbsprite -14, -16, $0d, 2
	dbsprite -22,  -8, $0c, 2
	dbsprite -22, -16, $0b, 2

.frame_5
	db 5 ; size
	dbsprite -14,  -8, $13, 0
	dbsprite -16,  -8, $12, 1
	dbsprite -24,  -8, $11, 1
	dbsprite -15, -10, $10, 2
	dbsprite -23, -10, $0f, 2

.frame_6
	db 5 ; size
	dbsprite  -8,  -7, $15, 0
	dbsprite -16,  -7, $14, 0
	dbsprite -14,  -8, $13, 1
	dbsprite -16,  -8, $12, 2
	dbsprite -24,  -8, $11, 2

.frame_7
	db 4 ; size
	dbsprite  -9,  -5, $16, 0
	dbsprite  -8,  -7, $15, 1
	dbsprite -16,  -7, $14, 1
	dbsprite -14,  -8, $13, 2

.frame_8
	db 4 ; size
	dbsprite  -5,  -7, $17, 0
	dbsprite  -9,  -5, $16, 1
	dbsprite  -8,  -7, $15, 2
	dbsprite -16,  -7, $14, 2

.frame_9
	db 3 ; size
	dbsprite  -4,  -6, $18, 0
	dbsprite  -5,  -7, $17, 1
	dbsprite  -9,  -5, $16, 2

.frame_10
	db 2 ; size
	dbsprite  -4,  -6, $18, 1
	dbsprite  -5,  -7, $17, 2

.frame_11
	db 1 ; size
	dbsprite  -4,  -6, $18, 2

OAMData59::
	dw .frame_0
	dw .frame_1

.frame_0
	db 6 ; size
	dbsprite   8,  -2, $05, 0
	dbsprite   0,   7, $04, 0
	dbsprite   0,  -1, $03, 0
	dbsprite  -8,   8, $02, 0
	dbsprite  -8,   0, $01, 0
	dbsprite -16,   0, $00, 0

.frame_1
	db 22 ; size
	dbsprite   8,  -2, $05, 0
	dbsprite   0,   7, $04, 0
	dbsprite   0,  -1, $03, 0
	dbsprite  -8,   8, $02, 0
	dbsprite  -8,   0, $01, 0
	dbsprite -16,   0, $00, 0
	dbsprite   2,   8, $13, 1
	dbsprite   8, -10, $15, 1
	dbsprite   8, -18, $14, 1
	dbsprite   0,  -7, $12, 1
	dbsprite   0, -15, $11, 1
	dbsprite  -8,  -5, $10, 1
	dbsprite  -8, -13, $0f, 1
	dbsprite  -8, -21, $0e, 1
	dbsprite -16,  10, $0d, 1
	dbsprite -16,   2, $0c, 1
	dbsprite -16,  -6, $0b, 1
	dbsprite -16, -14, $0a, 1
	dbsprite -16, -22, $09, 1
	dbsprite -24,   3, $08, 1
	dbsprite -24,  -5, $07, 1
	dbsprite -24, -13, $06, 1
