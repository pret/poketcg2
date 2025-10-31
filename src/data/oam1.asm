OAMData00::
	dw .frame_0
	dw .frame_1
	dw .frame_2

.frame_0
	db 8 ; size
	dbsprite   0,   0, $07, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite   0,  -8, $07, 0 | OAM_YFLIP
	dbsprite  -8,   0, $07, 0 | OAM_XFLIP
	dbsprite  -8,  -8, $07, 0
	dbsprite  -7, -16, $08, 0
	dbsprite -16,  -1, $08, 0 | OAM_XFLIP
	dbsprite   8,  -7, $08, 0 | OAM_YFLIP
	dbsprite  -1,   8, $08, 0 | OAM_XFLIP | OAM_YFLIP

.frame_1
	db 8 ; size
	dbsprite -12, -12, $04, 0
	dbsprite -13,  -4, $05, 0
	dbsprite  -4, -13, $06, 0
	dbsprite -12,   4, $04, 0 | OAM_XFLIP
	dbsprite  -4,   5, $06, 0 | OAM_XFLIP
	dbsprite   4, -12, $04, 0 | OAM_YFLIP
	dbsprite   5,  -4, $05, 0 | OAM_YFLIP
	dbsprite   4,   4, $04, 0 | OAM_XFLIP | OAM_YFLIP

.frame_2
	db 16 ; size
	dbsprite -16, -16, $00, 0
	dbsprite -16,  -8, $01, 0
	dbsprite  -8, -16, $02, 0
	dbsprite  -8,  -8, $03, 0
	dbsprite -16,   8, $00, 0 | OAM_XFLIP
	dbsprite -16,   0, $01, 0 | OAM_XFLIP
	dbsprite  -8,   8, $02, 0 | OAM_XFLIP
	dbsprite  -8,   0, $03, 0 | OAM_XFLIP
	dbsprite   8,   8, $00, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite   8,   0, $01, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite   0,   8, $02, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite   0,   0, $03, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite   8, -16, $00, 0 | OAM_YFLIP
	dbsprite   8,  -8, $01, 0 | OAM_YFLIP
	dbsprite   0, -16, $02, 0 | OAM_YFLIP
	dbsprite   0,  -8, $03, 0 | OAM_YFLIP

OAMData01::
	dw .frame_0
	dw .frame_1

.frame_0
	db 24 ; size
	dbsprite -24, -32, $00, 0
	dbsprite -24, -24, $01, 0
	dbsprite -24, -16, $02, 0
	dbsprite -24,  24, $03, 0
	dbsprite -16,  24, $04, 0
	dbsprite  -8,  24, $05, 0
	dbsprite -24,  -8, $01, 0
	dbsprite -24,   0, $02, 0
	dbsprite -24,   8, $01, 0
	dbsprite -24,  16, $02, 0
	dbsprite   0,  24, $04, 0
	dbsprite   8,  24, $05, 0
	dbsprite  16,  24, $00, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite  16,  16, $01, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite  16,   8, $02, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite  16, -32, $03, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite  16,   0, $01, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite  16,  -8, $02, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite  16, -16, $01, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite  16, -24, $02, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite   8, -32, $04, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite   0, -32, $05, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite  -8, -32, $04, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite -16, -32, $05, 0 | OAM_XFLIP | OAM_YFLIP

.frame_1
	db 24 ; size
	dbsprite -24,  24, $00, 0 | OAM_XFLIP
	dbsprite -24,  16, $01, 0 | OAM_XFLIP
	dbsprite -24,   8, $02, 0 | OAM_XFLIP
	dbsprite -24, -32, $03, 0 | OAM_XFLIP
	dbsprite -16, -32, $04, 0 | OAM_XFLIP
	dbsprite  -8, -32, $05, 0 | OAM_XFLIP
	dbsprite -24,   0, $01, 0 | OAM_XFLIP
	dbsprite -24,  -8, $02, 0 | OAM_XFLIP
	dbsprite -24, -16, $01, 0 | OAM_XFLIP
	dbsprite -24, -24, $02, 0 | OAM_XFLIP
	dbsprite   0, -32, $04, 0 | OAM_XFLIP
	dbsprite   8, -32, $05, 0 | OAM_XFLIP
	dbsprite  16, -32, $00, 0 | OAM_YFLIP
	dbsprite  16, -24, $01, 0 | OAM_YFLIP
	dbsprite  16, -16, $02, 0 | OAM_YFLIP
	dbsprite  16,  24, $03, 0 | OAM_YFLIP
	dbsprite  16,  -8, $01, 0 | OAM_YFLIP
	dbsprite  16,   0, $02, 0 | OAM_YFLIP
	dbsprite  16,   8, $01, 0 | OAM_YFLIP
	dbsprite  16,  16, $02, 0 | OAM_YFLIP
	dbsprite   8,  24, $04, 0 | OAM_YFLIP
	dbsprite   0,  24, $05, 0 | OAM_YFLIP
	dbsprite  -8,  24, $04, 0 | OAM_YFLIP
	dbsprite -16,  24, $05, 0 | OAM_YFLIP

OAMData02::
	dw .frame_0
	dw .frame_1
	dw .frame_2
	dw .frame_3
	dw .frame_4

.frame_0
	db 8 ; size
	dbsprite   0,   8, $02, 0 | OAM_XFLIP
	dbsprite   0,   0, $02, 0
	dbsprite  -8,   0, $02, 0 | OAM_YFLIP
	dbsprite  -8,   8, $02, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite   0, -16, $02, 0
	dbsprite   0,  -8, $02, 0 | OAM_XFLIP
	dbsprite  -8,  -8, $02, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite  -8, -16, $02, 0 | OAM_YFLIP

.frame_1
	db 8 ; size
	dbsprite  -7,  -8, $00, 1 | OAM_XFLIP
	dbsprite  -7, -16, $01, 1 | OAM_XFLIP
	dbsprite   1,  -8, $02, 0 | OAM_XFLIP
	dbsprite   1, -16, $03, 0 | OAM_XFLIP
	dbsprite  -7,   0, $00, 1
	dbsprite  -7,   8, $01, 1
	dbsprite   1,   0, $02, 0
	dbsprite   1,   8, $03, 0

.frame_2
	db 8 ; size
	dbsprite  -6, -16, $01, 1 | OAM_XFLIP
	dbsprite  -6,  -8, $01, 1
	dbsprite   2, -16, $05, 0 | OAM_XFLIP
	dbsprite   2,  -8, $04, 0 | OAM_XFLIP
	dbsprite  -6,   8, $01, 1
	dbsprite  -6,   0, $01, 1 | OAM_XFLIP
	dbsprite   2,   8, $05, 0
	dbsprite   2,   0, $04, 0

.frame_3
	db 9 ; size
	dbsprite  -5, -16, $01, 1 | OAM_XFLIP
	dbsprite   3, -16, $05, 0 | OAM_XFLIP
	dbsprite  -5,  -8, $01, 1
	dbsprite   3,  -8, $05, 0
	dbsprite  -5,   8, $01, 1
	dbsprite   3,   8, $05, 0
	dbsprite  -5,   0, $01, 1 | OAM_XFLIP
	dbsprite   3,   0, $05, 0 | OAM_XFLIP
	dbsprite -14,  11, $06, 2

.frame_4
	db 10 ; size
	dbsprite -14,  15, $07, 2 | OAM_XFLIP | OAM_YFLIP
	dbsprite  -5, -16, $01, 1 | OAM_XFLIP
	dbsprite   3, -16, $05, 0 | OAM_XFLIP
	dbsprite  -5,  -8, $01, 1
	dbsprite   3,  -8, $05, 0
	dbsprite  -5,   8, $01, 1
	dbsprite   3,   8, $05, 0
	dbsprite  -5,   0, $01, 1 | OAM_XFLIP
	dbsprite   3,   0, $05, 0 | OAM_XFLIP
	dbsprite -22,  15, $07, 2

OAMData03::
	dw .frame_0
	dw .frame_1
	dw .frame_2
	dw .frame_3
	dw .frame_4
	dw .frame_5
	dw .frame_6
	dw .frame_7

.frame_0
	db 8 ; size
	dbsprite  -8,  -8, $00, 1
	dbsprite  -8,   0, $00, 1 | OAM_XFLIP
	dbsprite -24,  -8, $00, 0
	dbsprite -24,   0, $00, 0 | OAM_XFLIP
	dbsprite -16,  -8, $01, 0
	dbsprite   0,  -8, $01, 1
	dbsprite -16,   0, $01, 0 | OAM_XFLIP
	dbsprite   0,   0, $01, 1 | OAM_XFLIP

.frame_1
	db 8 ; size
	dbsprite -16, -24, $00, 1
	dbsprite -16, -16, $00, 1 | OAM_XFLIP
	dbsprite -16,   8, $00, 0
	dbsprite -16,  16, $00, 0 | OAM_XFLIP
	dbsprite  -8, -24, $01, 1
	dbsprite  -8, -16, $01, 1 | OAM_XFLIP
	dbsprite  -8,   8, $01, 0
	dbsprite  -8,  16, $01, 0 | OAM_XFLIP

.frame_2
	db 8 ; size
	dbsprite -24, -32, $00, 1
	dbsprite -24, -24, $00, 1 | OAM_XFLIP
	dbsprite  -8,  16, $00, 0
	dbsprite  -8,  24, $00, 0 | OAM_XFLIP
	dbsprite -16, -32, $01, 1
	dbsprite -16, -24, $01, 1 | OAM_XFLIP
	dbsprite   0,  16, $01, 0
	dbsprite   0,  24, $01, 0 | OAM_XFLIP

.frame_3
	db 8 ; size
	dbsprite -32, -24, $00, 1
	dbsprite -32, -16, $00, 1 | OAM_XFLIP
	dbsprite   0,   8, $00, 0
	dbsprite   0,  16, $00, 0 | OAM_XFLIP
	dbsprite -24, -24, $01, 1
	dbsprite   8,   8, $01, 0
	dbsprite -24, -16, $01, 1 | OAM_XFLIP
	dbsprite   8,  16, $01, 0 | OAM_XFLIP

.frame_4
	db 8 ; size
	dbsprite -24,  -8, $00, 1
	dbsprite -24,   0, $00, 1 | OAM_XFLIP
	dbsprite  -8,  -8, $00, 0
	dbsprite  -8,   0, $00, 0 | OAM_XFLIP
	dbsprite -16,  -8, $01, 1
	dbsprite   0,  -8, $01, 0
	dbsprite -16,   0, $01, 1 | OAM_XFLIP
	dbsprite   0,   0, $01, 0 | OAM_XFLIP

.frame_5
	db 8 ; size
	dbsprite -16,   8, $00, 1
	dbsprite -16,  16, $00, 1 | OAM_XFLIP
	dbsprite -16, -24, $00, 0
	dbsprite -16, -16, $00, 0 | OAM_XFLIP
	dbsprite  -8, -24, $01, 0
	dbsprite  -8, -16, $01, 0 | OAM_XFLIP
	dbsprite  -8,   8, $01, 1
	dbsprite  -8,  16, $01, 1 | OAM_XFLIP

.frame_6
	db 8 ; size
	dbsprite  -8,  16, $00, 1
	dbsprite  -8,  24, $00, 1 | OAM_XFLIP
	dbsprite -24, -32, $00, 0
	dbsprite -24, -24, $00, 0 | OAM_XFLIP
	dbsprite -16, -32, $01, 0
	dbsprite -16, -24, $01, 0 | OAM_XFLIP
	dbsprite   0,  16, $01, 1
	dbsprite   0,  24, $01, 1 | OAM_XFLIP

.frame_7
	db 8 ; size
	dbsprite   0,   8, $00, 1
	dbsprite   0,  16, $00, 1 | OAM_XFLIP
	dbsprite -32, -24, $00, 0
	dbsprite -32, -16, $00, 0 | OAM_XFLIP
	dbsprite -24, -24, $01, 0
	dbsprite -24, -16, $01, 0 | OAM_XFLIP
	dbsprite   8,   8, $01, 1
	dbsprite   8,  16, $01, 1 | OAM_XFLIP

OAMData04::
	dw .frame_0
	dw .frame_1
	dw .frame_2
	dw .frame_3

.frame_0
	db 4 ; size
	dbsprite -24,  -8, $03, 0
	dbsprite -24,  24, $03, 0
	dbsprite -24, -32, $01, 0
	dbsprite -24,   8, $01, 0

.frame_1
	db 10 ; size
	dbsprite -16,  -8, $03, 0
	dbsprite -24,  -8, $02, 1
	dbsprite -24,   8, $00, 1
	dbsprite -16,  24, $03, 0
	dbsprite -24,  24, $02, 1
	dbsprite -16, -32, $01, 0
	dbsprite -24, -32, $00, 1
	dbsprite -24, -16, $01, 0 | OAM_XFLIP
	dbsprite -16,   8, $01, 0
	dbsprite -24,   0, $03, 0

.frame_2
	db 16 ; size
	dbsprite  -8,  -8, $03, 0
	dbsprite -16,   8, $00, 1
	dbsprite -16,  -8, $02, 1
	dbsprite -24,   8, $00, 2
	dbsprite -24,  -8, $02, 2
	dbsprite  -8,  24, $03, 0
	dbsprite -16,  24, $02, 1
	dbsprite -24,  24, $02, 2
	dbsprite -24,   0, $02, 1
	dbsprite -24, -16, $00, 1 | OAM_XFLIP
	dbsprite  -8, -32, $01, 0
	dbsprite -16, -32, $00, 1
	dbsprite -24, -32, $00, 2
	dbsprite -16, -16, $01, 0 | OAM_XFLIP
	dbsprite  -8,   8, $01, 0
	dbsprite -16,   0, $03, 0

.frame_3
	db 22 ; size
	dbsprite   0,  -8, $03, 0
	dbsprite  -8,   8, $00, 1
	dbsprite  -8,  -8, $02, 1
	dbsprite -16,   8, $00, 2
	dbsprite -16,  -8, $02, 2
	dbsprite   0,  24, $03, 0
	dbsprite  -8,  24, $02, 1
	dbsprite -16,  24, $02, 2
	dbsprite -24,   8, $00, 2
	dbsprite -24,  -8, $02, 2
	dbsprite -24,  24, $02, 2
	dbsprite -16,   0, $02, 1
	dbsprite -24,   0, $02, 2
	dbsprite -24, -16, $00, 2 | OAM_XFLIP
	dbsprite -16, -16, $00, 1 | OAM_XFLIP
	dbsprite   0, -32, $01, 0
	dbsprite  -8, -32, $00, 1
	dbsprite -16, -32, $00, 2
	dbsprite -24, -32, $00, 2
	dbsprite  -8, -16, $01, 0 | OAM_XFLIP
	dbsprite   0,   8, $01, 0
	dbsprite  -8,   0, $03, 0

OAMData05::
	dw .frame_0
	dw .frame_1
	dw .frame_2
	dw .frame_3
	dw .frame_4
	dw .frame_5
	dw .frame_6

.frame_0
	db 4 ; size
	dbsprite  -8,  -8, $00, 0
	dbsprite  -8,   0, $01, 0
	dbsprite   0,  -8, $02, 0
	dbsprite   0,   0, $03, 0

.frame_1
	db 9 ; size
	dbsprite -12, -12, $04, 0
	dbsprite -12,  -4, $05, 0
	dbsprite  -4, -12, $06, 0
	dbsprite  -4,  -4, $07, 1
	dbsprite -12,   4, $04, 0 | OAM_XFLIP
	dbsprite  -4,   4, $06, 0 | OAM_XFLIP
	dbsprite   4, -12, $04, 0 | OAM_YFLIP
	dbsprite   4,  -4, $05, 0 | OAM_YFLIP
	dbsprite   4,   4, $04, 0 | OAM_XFLIP | OAM_YFLIP

.frame_2
	db 13 ; size
	dbsprite  -8,   8, $00, 0
	dbsprite  -8,  16, $01, 0
	dbsprite   0,   8, $02, 0
	dbsprite   0,  16, $03, 0
	dbsprite -20, -28, $04, 0
	dbsprite -20, -20, $05, 0
	dbsprite -12, -28, $06, 0
	dbsprite -12, -20, $07, 1
	dbsprite -20, -12, $04, 0 | OAM_XFLIP
	dbsprite -12, -12, $06, 0 | OAM_XFLIP
	dbsprite  -4, -28, $04, 0 | OAM_YFLIP
	dbsprite  -4, -20, $05, 0 | OAM_YFLIP
	dbsprite  -4, -12, $04, 0 | OAM_XFLIP | OAM_YFLIP

.frame_3
	db 13 ; size
	dbsprite   0, -12, $00, 0
	dbsprite   0,  -4, $01, 0
	dbsprite   8, -12, $02, 0
	dbsprite   8,  -4, $03, 0
	dbsprite -12,   4, $04, 0
	dbsprite -12,  12, $05, 0
	dbsprite  -4,   4, $06, 0
	dbsprite  -4,  12, $07, 1
	dbsprite -12,  20, $04, 0 | OAM_XFLIP
	dbsprite  -4,  20, $06, 0 | OAM_XFLIP
	dbsprite   4,   4, $04, 0 | OAM_YFLIP
	dbsprite   4,  12, $05, 0 | OAM_YFLIP
	dbsprite   4,  20, $04, 0 | OAM_XFLIP | OAM_YFLIP

.frame_4
	db 17 ; size
	dbsprite   4,   8, $00, 0
	dbsprite   4,  16, $01, 0
	dbsprite  12,   8, $02, 0
	dbsprite  12,  16, $03, 0
	dbsprite -24, -32, $04, 0
	dbsprite -24, -24, $05, 0
	dbsprite -16, -32, $06, 0
	dbsprite -16, -24, $07, 1
	dbsprite -24, -16, $04, 0 | OAM_XFLIP
	dbsprite -16, -16, $06, 0 | OAM_XFLIP
	dbsprite  -8, -32, $04, 0 | OAM_YFLIP
	dbsprite  -8, -24, $05, 0 | OAM_YFLIP
	dbsprite  -8, -16, $04, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite -29, -11, $08, 0
	dbsprite -29, -37, $08, 0 | OAM_XFLIP
	dbsprite  -3, -11, $08, 0 | OAM_YFLIP
	dbsprite  -3, -37, $08, 0 | OAM_XFLIP | OAM_YFLIP

.frame_5
	db 17 ; size
	dbsprite   0, -24, $00, 0
	dbsprite   0, -16, $01, 0
	dbsprite   8, -24, $02, 0
	dbsprite   8, -16, $03, 0
	dbsprite   0,   4, $04, 0
	dbsprite   0,  12, $05, 0
	dbsprite   8,   4, $06, 0
	dbsprite   8,  12, $07, 1
	dbsprite   0,  20, $04, 0 | OAM_XFLIP
	dbsprite   8,  20, $06, 0 | OAM_XFLIP
	dbsprite  16,   4, $04, 0 | OAM_YFLIP
	dbsprite  16,  12, $05, 0 | OAM_YFLIP
	dbsprite  16,  20, $04, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite  -5,  25, $08, 0
	dbsprite  -5,  -1, $08, 0 | OAM_XFLIP
	dbsprite  21,  25, $08, 0 | OAM_YFLIP
	dbsprite  21,  -1, $08, 0 | OAM_XFLIP | OAM_YFLIP

.frame_6
	db 13 ; size
	dbsprite  -4, -28, $04, 0
	dbsprite  -4, -20, $05, 0
	dbsprite   4, -28, $06, 0
	dbsprite   4, -20, $07, 1
	dbsprite  -4, -12, $04, 0 | OAM_XFLIP
	dbsprite   4, -12, $06, 0 | OAM_XFLIP
	dbsprite  12, -28, $04, 0 | OAM_YFLIP
	dbsprite  12, -20, $05, 0 | OAM_YFLIP
	dbsprite  12, -12, $04, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite  -9,  -7, $08, 0
	dbsprite  -9, -33, $08, 0 | OAM_XFLIP
	dbsprite  17,  -7, $08, 0 | OAM_YFLIP
	dbsprite  17, -33, $08, 0 | OAM_XFLIP | OAM_YFLIP

OAMData06::
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

.frame_0
	db 1 ; size
	dbsprite   0,   0, $00, 0

.frame_1
	db 1 ; size
	dbsprite   0,   0, $01, 0

.frame_2
	db 1 ; size
	dbsprite   0,   0, $02, 0

.frame_3
	db 1 ; size
	dbsprite   0,   0, $03, 0

.frame_4
	db 1 ; size
	dbsprite   0,   0, $04, 0

.frame_5
	db 1 ; size
	dbsprite   0,   0, $05, 0

.frame_6
	db 1 ; size
	dbsprite   0,   0, $06, 0

.frame_7
	db 1 ; size
	dbsprite   0,   0, $07, 0

.frame_8
	db 1 ; size
	dbsprite   0,   0, $08, 0

.frame_9
	db 1 ; size
	dbsprite   0,   0, $09, 0

.frame_10
	db 8 ; size
	dbsprite   0,   0, $11, 0
	dbsprite   0,   8, $12, 0
	dbsprite   0,  16, $13, 0
	dbsprite   0,  24, $14, 0
	dbsprite   8,   0, $15, 0
	dbsprite   8,   8, $16, 0
	dbsprite   8,  16, $17, 0
	dbsprite   8,  24, $18, 0

.frame_11
	db 6 ; size
	dbsprite   0,   0, $0b, 0
	dbsprite   0,   8, $0c, 0
	dbsprite   0,  16, $0d, 0
	dbsprite   8,   0, $0e, 0
	dbsprite   8,   8, $0f, 0
	dbsprite   8,  16, $10, 0

.frame_12
	db 1 ; size
	dbsprite   0,   0, $0a, 0

OAMData07::
	dw .frame_0
	dw .frame_1
	dw .frame_2
	dw .frame_3
	dw .frame_4
	dw .frame_5
	dw .frame_6

.frame_0
	db 2 ; size
	dbsprite -32,  -5, $00, 0
	dbsprite -24,  -4, $01, 0 | OAM_XFLIP

.frame_1
	db 8 ; size
	dbsprite  -8,  -4, $09, 0 | OAM_XFLIP
	dbsprite -32,  -3, $00, 0 | OAM_XFLIP
	dbsprite -24,  -4, $01, 0 | OAM_XFLIP
	dbsprite -16,  -2, $02, 0 | OAM_XFLIP
	dbsprite  -8,   0, $03, 1 | OAM_XFLIP
	dbsprite  -8,  -8, $04, 1 | OAM_XFLIP
	dbsprite   0,   0, $05, 1 | OAM_XFLIP
	dbsprite   0,  -8, $06, 1 | OAM_XFLIP

.frame_2
	db 8 ; size
	dbsprite  -8,  -4, $09, 0
	dbsprite -32,  -5, $00, 0
	dbsprite -24,  -4, $01, 0
	dbsprite -16,  -6, $02, 0
	dbsprite  -8,  -8, $03, 1
	dbsprite  -8,   0, $04, 1
	dbsprite   0,  -8, $05, 1
	dbsprite   0,   0, $06, 1

.frame_3
	db 9 ; size
	dbsprite  -8,  -5, $09, 0
	dbsprite  -8,   0, $03, 1 | OAM_XFLIP
	dbsprite  -8,  -8, $04, 1 | OAM_XFLIP
	dbsprite   0,   0, $05, 1 | OAM_XFLIP
	dbsprite   0,  -8, $06, 1 | OAM_XFLIP
	dbsprite -12, -14, $08, 1
	dbsprite   4,   6, $08, 1
	dbsprite   4, -14, $07, 1
	dbsprite -12,   6, $07, 1

.frame_4
	db 4 ; size
	dbsprite -16,  10, $08, 1 | OAM_XFLIP
	dbsprite   8, -18, $08, 1 | OAM_XFLIP
	dbsprite   8,  10, $07, 1 | OAM_XFLIP
	dbsprite -16, -18, $07, 1 | OAM_XFLIP

.frame_5
	db 4 ; size
	dbsprite -18, -22, $08, 2
	dbsprite  10,  14, $08, 2
	dbsprite  10, -22, $07, 2
	dbsprite -18,  14, $07, 2

.frame_6
	db 4 ; size
	dbsprite -22,  18, $08, 2 | OAM_XFLIP
	dbsprite  14, -26, $08, 2 | OAM_XFLIP
	dbsprite  14,  18, $07, 2 | OAM_XFLIP
	dbsprite -22, -26, $07, 2 | OAM_XFLIP

OAMData08::
	dw .frame_0
	dw .frame_1
	dw .frame_2
	dw .frame_3
	dw .frame_4
	dw .frame_5

.frame_0
	db 9 ; size
	dbsprite -40,  -5, $00, 0
	dbsprite -32, -12, $02, 0
	dbsprite -32,  -4, $03, 0
	dbsprite -24, -20, $04, 0
	dbsprite -24, -12, $05, 0
	dbsprite -24,  -4, $06, 0
	dbsprite -16,  -4, $09, 0
	dbsprite -16,   4, $0a, 0
	dbsprite  -8,   6, $0e, 0

.frame_1
	db 19 ; size
	dbsprite   0,   9, $0d, 0
	dbsprite -16, -17, $01, 0
	dbsprite -40,  -5, $00, 0
	dbsprite -32, -12, $02, 0
	dbsprite -32,  -4, $03, 0
	dbsprite -24, -20, $04, 0
	dbsprite -24, -12, $05, 0
	dbsprite -24,  -4, $06, 0
	dbsprite -16,  -4, $09, 0
	dbsprite -16,   4, $0a, 0
	dbsprite  -8,   6, $0e, 0
	dbsprite -16, -24, $07, 1
	dbsprite -16, -16, $08, 1
	dbsprite  -8, -24, $0b, 1
	dbsprite  -8, -16, $0c, 1
	dbsprite   0,   8, $0f, 1
	dbsprite   0,  16, $10, 1
	dbsprite   8,  16, $0b, 1 | OAM_XFLIP
	dbsprite   8,   8, $0c, 1 | OAM_XFLIP

.frame_2
	db 9 ; size
	dbsprite -40,  -3, $00, 0 | OAM_XFLIP
	dbsprite -32,   4, $02, 0 | OAM_XFLIP
	dbsprite -32,  -4, $03, 0 | OAM_XFLIP
	dbsprite -24,  12, $04, 0 | OAM_XFLIP
	dbsprite -24,   4, $05, 0 | OAM_XFLIP
	dbsprite -24,  -4, $06, 0 | OAM_XFLIP
	dbsprite -16,  -4, $09, 0 | OAM_XFLIP
	dbsprite -16, -12, $0a, 0 | OAM_XFLIP
	dbsprite  -8, -14, $0e, 0 | OAM_XFLIP

.frame_3
	db 19 ; size
	dbsprite   0, -17, $0d, 0 | OAM_XFLIP
	dbsprite -16,   9, $01, 0 | OAM_XFLIP
	dbsprite -40,  -3, $00, 0 | OAM_XFLIP
	dbsprite -32,   4, $02, 0 | OAM_XFLIP
	dbsprite -32,  -4, $03, 0 | OAM_XFLIP
	dbsprite -24,  12, $04, 0 | OAM_XFLIP
	dbsprite -24,   4, $05, 0 | OAM_XFLIP
	dbsprite -24,  -4, $06, 0 | OAM_XFLIP
	dbsprite -16,  -4, $09, 0 | OAM_XFLIP
	dbsprite -16, -12, $0a, 0 | OAM_XFLIP
	dbsprite  -8, -14, $0e, 0 | OAM_XFLIP
	dbsprite -16,  16, $07, 1 | OAM_XFLIP
	dbsprite -16,   8, $08, 1 | OAM_XFLIP
	dbsprite  -8,  16, $0b, 1 | OAM_XFLIP
	dbsprite  -8,   8, $0c, 1 | OAM_XFLIP
	dbsprite   0, -16, $0f, 1 | OAM_XFLIP
	dbsprite   0, -24, $10, 1 | OAM_XFLIP
	dbsprite   8, -24, $0b, 1
	dbsprite   8, -16, $0c, 1

.frame_4
	db 9 ; size
	dbsprite -40,  -5, $00, 0
	dbsprite -32, -12, $02, 0
	dbsprite -32,  -4, $03, 0
	dbsprite -24,  -4, $04, 0 | OAM_XFLIP
	dbsprite -24, -12, $05, 0 | OAM_XFLIP
	dbsprite -24, -20, $06, 0 | OAM_XFLIP
	dbsprite -16, -20, $09, 0 | OAM_XFLIP
	dbsprite -16, -28, $0a, 0 | OAM_XFLIP
	dbsprite  -8, -26, $0e, 0

.frame_5
	db 19 ; size
	dbsprite   0, -23, $0d, 0
	dbsprite -16,  -7, $01, 0 | OAM_XFLIP
	dbsprite -40,  -5, $00, 0
	dbsprite -32, -12, $02, 0
	dbsprite -32,  -4, $03, 0
	dbsprite -24,  -4, $04, 0 | OAM_XFLIP
	dbsprite -24, -12, $05, 0 | OAM_XFLIP
	dbsprite -24, -20, $06, 0 | OAM_XFLIP
	dbsprite -16, -20, $09, 0 | OAM_XFLIP
	dbsprite -16, -28, $0a, 0 | OAM_XFLIP
	dbsprite  -8, -26, $0e, 0
	dbsprite   0, -24, $0f, 1
	dbsprite   0, -16, $10, 1
	dbsprite   8, -16, $0b, 1 | OAM_XFLIP
	dbsprite   8, -24, $0c, 1 | OAM_XFLIP
	dbsprite -16,   0, $07, 1 | OAM_XFLIP
	dbsprite -16,  -8, $08, 1 | OAM_XFLIP
	dbsprite  -8,   0, $0b, 1 | OAM_XFLIP
	dbsprite  -8,  -8, $0c, 1 | OAM_XFLIP

OAMData09::
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
	db 2 ; size
	dbsprite -27, -35, $00, 0
	dbsprite  20,  28, $00, 0

.frame_1
	db 6 ; size
	dbsprite -27, -27, $01, 0
	dbsprite  20,  20, $01, 0
	dbsprite -19, -35, $00, 0
	dbsprite  12,  28, $00, 0
	dbsprite -27, -35, $00, 0
	dbsprite  20,  28, $00, 0

.frame_2
	db 8 ; size
	dbsprite -27, -20, $00, 0 | OAM_XFLIP
	dbsprite  20,  11, $00, 0 | OAM_XFLIP
	dbsprite -15, -35, $02, 0
	dbsprite   8,  28, $02, 0
	dbsprite -27, -27, $01, 0
	dbsprite  20,  20, $01, 0
	dbsprite -19, -35, $00, 0
	dbsprite  12,  28, $00, 0

.frame_3
	db 8 ; size
	dbsprite -27, -11, $02, 0
	dbsprite  20,   4, $02, 0
	dbsprite -12, -35, $00, 0 | OAM_YFLIP
	dbsprite   3,  28, $00, 0 | OAM_YFLIP
	dbsprite -27, -20, $00, 0 | OAM_XFLIP
	dbsprite  20,  11, $00, 0 | OAM_XFLIP
	dbsprite -15, -35, $02, 0
	dbsprite   8,  28, $02, 0

.frame_4
	db 8 ; size
	dbsprite  19,  -4, $00, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite -28,  -5, $00, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite  -7, -35, $01, 0
	dbsprite   0,  29, $01, 0
	dbsprite -27, -11, $02, 0
	dbsprite  20,   4, $02, 0
	dbsprite -12, -35, $00, 0 | OAM_YFLIP
	dbsprite   3,  28, $00, 0 | OAM_YFLIP

.frame_5
	db 8 ; size
	dbsprite -27,   3, $01, 0 | OAM_XFLIP
	dbsprite  20, -12, $01, 0 | OAM_XFLIP
	dbsprite  -4, -36, $00, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite  -5,  27, $00, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite  19,  -4, $00, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite -28,  -5, $00, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite  -7, -35, $01, 0
	dbsprite   0,  29, $01, 0

.frame_6
	db 8 ; size
	dbsprite  19, -19, $00, 0 | OAM_YFLIP
	dbsprite -28,  12, $00, 0 | OAM_YFLIP
	dbsprite   1, -35, $02, 0
	dbsprite  -8,  28, $02, 0
	dbsprite -27,   3, $01, 0 | OAM_XFLIP
	dbsprite  20, -12, $01, 0 | OAM_XFLIP
	dbsprite  -4, -36, $00, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite  -5,  27, $00, 0 | OAM_XFLIP | OAM_YFLIP

.frame_7
	db 8 ; size
	dbsprite -27,  19, $02, 0 | OAM_XFLIP
	dbsprite  20, -28, $02, 0 | OAM_XFLIP
	dbsprite   5, -36, $00, 0 | OAM_XFLIP
	dbsprite -12,  27, $00, 0 | OAM_XFLIP
	dbsprite  19, -19, $00, 0 | OAM_YFLIP
	dbsprite -28,  12, $00, 0 | OAM_YFLIP
	dbsprite   1, -35, $02, 0
	dbsprite  -8,  28, $02, 0

.frame_8
	db 8 ; size
	dbsprite  20, -35, $00, 0
	dbsprite -27,  28, $00, 0
	dbsprite   8, -35, $01, 0
	dbsprite -16,  28, $01, 0
	dbsprite -27,  19, $02, 0 | OAM_XFLIP
	dbsprite  20, -28, $02, 0 | OAM_XFLIP
	dbsprite   5, -36, $00, 0 | OAM_XFLIP
	dbsprite -12,  27, $00, 0 | OAM_XFLIP

OAMData0A::
	dw .frame_0
	dw .frame_1
	dw .frame_2
	dw .frame_3
	dw .frame_4
	dw .frame_5

.frame_0
	db 27 ; size
	dbsprite -16,   0, $2d, 0
	dbsprite -72,  -8, $00, 0
	dbsprite -72,   0, $01, 0
	dbsprite -64,   1, $02, 0 | OAM_XFLIP
	dbsprite -64,  -7, $03, 0 | OAM_XFLIP
	dbsprite -56,  -9, $04, 0
	dbsprite -56,  -1, $05, 0
	dbsprite -48,  -9, $0f, 0
	dbsprite -48,  -1, $10, 0
	dbsprite -48,   7, $11, 0
	dbsprite -48,  15, $12, 0
	dbsprite -40, -14, $13, 0
	dbsprite -40,  -6, $14, 0
	dbsprite -40,   1, $15, 0
	dbsprite -40,   9, $16, 0
	dbsprite -40,  17, $17, 0
	dbsprite -32,  -8, $19, 0
	dbsprite -32,   0, $1a, 0
	dbsprite -24,  -8, $1b, 0
	dbsprite -24,   0, $1c, 0
	dbsprite -16,  -8, $1d, 1
	dbsprite -16,   0, $1e, 1
	dbsprite -16,   8, $1f, 1
	dbsprite  -8,  -8, $20, 1
	dbsprite  -8,   0, $21, 1
	dbsprite  -8,   8, $22, 1
	dbsprite -32,   8, $18, 0

.frame_1
	db 21 ; size
	dbsprite -16,   0, $2d, 0 | OAM_XFLIP
	dbsprite -72,   0, $00, 0 | OAM_XFLIP
	dbsprite -72,  -8, $01, 0 | OAM_XFLIP
	dbsprite -64,   8, $02, 0 | OAM_XFLIP
	dbsprite -64,   0, $03, 0 | OAM_XFLIP
	dbsprite -56,   9, $04, 0 | OAM_XFLIP
	dbsprite -56,   1, $05, 0 | OAM_XFLIP
	dbsprite -48,   9, $0f, 0 | OAM_XFLIP
	dbsprite -40,  14, $13, 0 | OAM_XFLIP
	dbsprite -40,   6, $14, 0 | OAM_XFLIP
	dbsprite -32,   8, $19, 0 | OAM_XFLIP
	dbsprite -32,   0, $1a, 0 | OAM_XFLIP
	dbsprite -24,   8, $1b, 0 | OAM_XFLIP
	dbsprite -24,   0, $1c, 0 | OAM_XFLIP
	dbsprite -48,   1, $23, 0 | OAM_XFLIP
	dbsprite -16,  -8, $24, 1
	dbsprite -16,   0, $25, 1
	dbsprite -16,   8, $26, 1
	dbsprite  -8,  -8, $27, 1
	dbsprite  -8,   0, $28, 1
	dbsprite  -8,   8, $29, 1

.frame_2
	db 32 ; size
	dbsprite   8, -41, $2d, 0 | OAM_XFLIP
	dbsprite -72,  -8, $00, 0
	dbsprite -72,   0, $01, 0
	dbsprite -64, -16, $02, 0
	dbsprite -64,  -8, $03, 0
	dbsprite -56, -16, $04, 0
	dbsprite -56,  -8, $05, 0
	dbsprite -48,  -2, $06, 0 | OAM_XFLIP
	dbsprite -48, -10, $07, 0 | OAM_XFLIP
	dbsprite -48, -18, $08, 0 | OAM_XFLIP
	dbsprite -40,   3, $09, 0 | OAM_XFLIP
	dbsprite -40,  -5, $0a, 0 | OAM_XFLIP
	dbsprite -40, -13, $0b, 0 | OAM_XFLIP
	dbsprite -40, -21, $0c, 0 | OAM_XFLIP
	dbsprite -32,  -8, $0d, 0
	dbsprite -32,   1, $0e, 0
	dbsprite -32, -24, $0f, 0
	dbsprite -32, -16, $23, 0
	dbsprite -24, -19, $13, 0 | OAM_XFLIP
	dbsprite -24, -27, $14, 0 | OAM_XFLIP
	dbsprite -16, -30, $19, 0
	dbsprite -16, -22, $1a, 0
	dbsprite  -8, -33, $19, 0
	dbsprite  -8, -25, $1a, 0
	dbsprite   0, -33, $1b, 0 | OAM_XFLIP
	dbsprite   0, -41, $1c, 0 | OAM_XFLIP
	dbsprite   8, -49, $24, 1
	dbsprite   8, -41, $25, 1
	dbsprite   8, -33, $26, 1
	dbsprite  16, -49, $27, 1
	dbsprite  16, -41, $28, 1
	dbsprite  16, -33, $29, 1

.frame_3
	db 13 ; size
	dbsprite -56,  33, $2d, 0
	dbsprite -72,   8, $00, 0 | OAM_XFLIP
	dbsprite -72,   0, $01, 0 | OAM_XFLIP
	dbsprite -64,   8, $2c, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite -64,  16, $2a, 0
	dbsprite -64,  24, $2b, 0
	dbsprite -64,  32, $2c, 0
	dbsprite -56,  25, $1d, 1
	dbsprite -56,  33, $1e, 1
	dbsprite -56,  41, $1f, 1
	dbsprite -48,  25, $20, 1
	dbsprite -48,  33, $21, 1
	dbsprite -48,  41, $22, 1

.frame_4
	db 19 ; size
	dbsprite -36, -49, $2d, 0 | OAM_XFLIP
	dbsprite -72,   8, $00, 0
	dbsprite -72,  16, $01, 0
	dbsprite -64,   8, $2c, 0 | OAM_YFLIP
	dbsprite -64,   0, $2a, 0 | OAM_XFLIP
	dbsprite -64,  -8, $2b, 0 | OAM_XFLIP
	dbsprite -64, -16, $2c, 0 | OAM_XFLIP
	dbsprite -56, -16, $1b, 0 | OAM_XFLIP
	dbsprite -56, -24, $1c, 0 | OAM_XFLIP
	dbsprite -48, -23, $2c, 0 | OAM_YFLIP
	dbsprite -46, -31, $2a, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite -45, -39, $2b, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite -44, -47, $2c, 0 | OAM_XFLIP
	dbsprite -36, -57, $24, 1
	dbsprite -36, -49, $25, 1
	dbsprite -36, -41, $26, 1
	dbsprite -28, -57, $27, 1
	dbsprite -28, -49, $28, 1
	dbsprite -28, -41, $29, 1

.frame_5
	db 30 ; size
	dbsprite  -8,  40, $2d, 0
	dbsprite -72,   0, $00, 0 | OAM_XFLIP
	dbsprite -72,  -8, $01, 0 | OAM_XFLIP
	dbsprite -16,  32, $1b, 0
	dbsprite -16,  40, $1c, 0
	dbsprite  -8,  32, $1d, 1
	dbsprite  -8,  40, $1e, 1
	dbsprite   0,  32, $20, 1
	dbsprite   0,  40, $21, 1
	dbsprite  -8,  48, $1f, 1
	dbsprite   0,  48, $22, 1
	dbsprite -24,  32, $19, 0 | OAM_XFLIP
	dbsprite -24,  24, $1a, 0 | OAM_XFLIP
	dbsprite -32,  21, $13, 0
	dbsprite -32,  29, $14, 0
	dbsprite -40,  26, $0f, 0 | OAM_XFLIP
	dbsprite -40,  18, $10, 0 | OAM_XFLIP
	dbsprite -40,  10, $11, 0 | OAM_XFLIP
	dbsprite -40,   2, $12, 0 | OAM_XFLIP
	dbsprite -32,  16, $15, 0 | OAM_XFLIP
	dbsprite -32,   8, $16, 0 | OAM_XFLIP
	dbsprite -32,   0, $17, 0 | OAM_XFLIP
	dbsprite -24,   8, $18, 0 | OAM_XFLIP
	dbsprite -48,  15, $0b, 0
	dbsprite -48,  23, $0c, 0
	dbsprite -64,   8, $02, 0 | OAM_XFLIP
	dbsprite -64,   0, $03, 0 | OAM_XFLIP
	dbsprite -56,  18, $2c, 0
	dbsprite -56,   2, $2c, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite -56,  10, $2a, 0

OAMData0B::
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

.frame_0
	db 4 ; size
	dbsprite  -8,  -8, $00, 0
	dbsprite   0,  -8, $01, 1
	dbsprite  -8,   0, $04, 0 | OAM_XFLIP
	dbsprite   0,   0, $05, 1 | OAM_XFLIP

.frame_1
	db 4 ; size
	dbsprite  -8,  -8, $02, 0
	dbsprite   0,  -8, $03, 1
	dbsprite  -8,   0, $06, 0 | OAM_XFLIP
	dbsprite   0,   0, $07, 1 | OAM_XFLIP

.frame_2
	db 4 ; size
	dbsprite  -8,  -8, $04, 0
	dbsprite   0,  -8, $05, 1
	dbsprite  -8,   0, $00, 0 | OAM_XFLIP
	dbsprite   0,   0, $01, 1 | OAM_XFLIP

.frame_3
	db 4 ; size
	dbsprite  -8,  -8, $06, 0
	dbsprite   0,  -8, $07, 1
	dbsprite  -8,   0, $02, 0 | OAM_XFLIP
	dbsprite   0,   0, $03, 1 | OAM_XFLIP

.frame_4
	db 12 ; size
	dbsprite  -8,  -8, $00, 0
	dbsprite   0,  -8, $01, 1
	dbsprite  -8,   0, $04, 0 | OAM_XFLIP
	dbsprite   0,   0, $05, 1 | OAM_XFLIP
	dbsprite -19,   2, $08, 0
	dbsprite   1, -10, $08, 0
	dbsprite -12,   2, $09, 1
	dbsprite   9, -10, $09, 1
	dbsprite -19, -10, $0a, 0
	dbsprite -11, -10, $0b, 1
	dbsprite   1,   2, $0a, 0
	dbsprite   9,   2, $0b, 1

.frame_5
	db 10 ; size
	dbsprite -24, -14, $08, 0
	dbsprite -16, -14, $09, 1
	dbsprite   4,   6, $09, 1
	dbsprite  -4,   6, $08, 0
	dbsprite -23,   6, $0a, 0
	dbsprite  -4, -14, $0a, 0
	dbsprite   4, -14, $0b, 1
	dbsprite -15,   6, $0b, 1
	dbsprite  -8,  -4, $08, 0
	dbsprite   0,  -4, $09, 1

.frame_6
	db 10 ; size
	dbsprite -28, -18, $0a, 0
	dbsprite -20, -18, $0b, 1
	dbsprite   6,  10, $0b, 1
	dbsprite  -2,  10, $0a, 0
	dbsprite -28,  10, $08, 0
	dbsprite  -2, -18, $08, 0
	dbsprite   6, -18, $09, 1
	dbsprite -20,  10, $09, 1
	dbsprite  -8,  -4, $0a, 0
	dbsprite   0,  -4, $0b, 1

.frame_7
	db 10 ; size
	dbsprite -24, -20, $0a, 0
	dbsprite -16, -20, $0b, 1
	dbsprite   8,  12, $0b, 1
	dbsprite   0,  12, $0a, 0
	dbsprite -24,  12, $08, 0
	dbsprite   0, -20, $08, 0
	dbsprite   8, -20, $09, 1
	dbsprite -16,  12, $09, 1
	dbsprite  -8,  -4, $0a, 0
	dbsprite   0,  -4, $0b, 1

.frame_8
	db 5 ; size
	dbsprite  -1,  -4, $0c, 0
	dbsprite -16, -20, $0c, 0
	dbsprite   8, -20, $0c, 0
	dbsprite -16,  12, $0c, 0
	dbsprite   8,  12, $0c, 0

.frame_9
	db 5 ; size
	dbsprite  -8,  10, $04, 0
	dbsprite   0,  10, $05, 1
	dbsprite  -8,  18, $00, 0 | OAM_XFLIP
	dbsprite   0,  18, $01, 1 | OAM_XFLIP
	dbsprite -16,  12, $0c, 0

.frame_10
	db 6 ; size
	dbsprite   2,   8, $06, 0
	dbsprite  10,   8, $07, 1
	dbsprite   2,  16, $02, 0 | OAM_XFLIP
	dbsprite  10,  16, $03, 1 | OAM_XFLIP
	dbsprite -19,  12, $0a, 0
	dbsprite -11,  12, $0b, 1

.frame_11
	db 9 ; size
	dbsprite   6,  -8, $00, 0
	dbsprite  14,  -8, $01, 1
	dbsprite   6,   0, $04, 0 | OAM_XFLIP
	dbsprite  14,   0, $05, 1 | OAM_XFLIP
	dbsprite   8,  12, $0c, 0
	dbsprite -21,   8, $00, 0
	dbsprite -13,   8, $01, 1
	dbsprite -21,  16, $04, 0 | OAM_XFLIP
	dbsprite -13,  16, $05, 1 | OAM_XFLIP

.frame_12
	db 10 ; size
	dbsprite   2, -22, $02, 0
	dbsprite  10, -22, $03, 1
	dbsprite   2, -14, $06, 0 | OAM_XFLIP
	dbsprite  10, -14, $07, 1 | OAM_XFLIP
	dbsprite   5,  12, $08, 0
	dbsprite  13,  12, $09, 1
	dbsprite -21,   9, $02, 0
	dbsprite -13,   9, $03, 1
	dbsprite -21,  17, $06, 0 | OAM_XFLIP
	dbsprite -13,  17, $07, 1 | OAM_XFLIP

.frame_13
	db 13 ; size
	dbsprite  -8, -26, $04, 0
	dbsprite   0, -26, $05, 1
	dbsprite  -8, -18, $00, 0 | OAM_XFLIP
	dbsprite   0, -18, $01, 1 | OAM_XFLIP
	dbsprite   8, -20, $0c, 0
	dbsprite -20,   8, $04, 0
	dbsprite -12,   8, $05, 1
	dbsprite -20,  16, $00, 0 | OAM_XFLIP
	dbsprite -12,  16, $01, 1 | OAM_XFLIP
	dbsprite   5,   8, $04, 0
	dbsprite  13,   8, $05, 1
	dbsprite   5,  16, $00, 0 | OAM_XFLIP
	dbsprite  13,  16, $01, 1 | OAM_XFLIP

.frame_14
	db 16 ; size
	dbsprite -20, -24, $06, 0
	dbsprite -12, -24, $07, 1
	dbsprite -20, -16, $02, 0 | OAM_XFLIP
	dbsprite -12, -16, $03, 1 | OAM_XFLIP
	dbsprite -20,   8, $06, 0
	dbsprite -12,   8, $07, 1
	dbsprite -20,  16, $02, 0 | OAM_XFLIP
	dbsprite -12,  16, $03, 1 | OAM_XFLIP
	dbsprite   5,   8, $06, 0
	dbsprite  13,   8, $07, 1
	dbsprite   5,  16, $02, 0 | OAM_XFLIP
	dbsprite  13,  16, $03, 1 | OAM_XFLIP
	dbsprite   5, -24, $06, 0
	dbsprite  13, -24, $07, 1
	dbsprite   5, -16, $02, 0 | OAM_XFLIP
	dbsprite  13, -16, $03, 1 | OAM_XFLIP

.frame_15
	db 16 ; size
	dbsprite -20, -24, $00, 0
	dbsprite -12, -24, $01, 1
	dbsprite -20, -16, $04, 0 | OAM_XFLIP
	dbsprite -12, -16, $05, 1 | OAM_XFLIP
	dbsprite -20,   8, $00, 0
	dbsprite -12,   8, $01, 1
	dbsprite -20,  16, $04, 0 | OAM_XFLIP
	dbsprite -12,  16, $05, 1 | OAM_XFLIP
	dbsprite   5, -25, $00, 0
	dbsprite  13, -25, $01, 1
	dbsprite   5, -17, $04, 0 | OAM_XFLIP
	dbsprite  13, -17, $05, 1 | OAM_XFLIP
	dbsprite   6,   6, $00, 0
	dbsprite  14,   6, $01, 1
	dbsprite   6,  14, $04, 0 | OAM_XFLIP
	dbsprite  14,  14, $05, 1 | OAM_XFLIP

.frame_16
	db 16 ; size
	dbsprite -20,  16, $06, 0 | OAM_XFLIP
	dbsprite -12,  16, $07, 1 | OAM_XFLIP
	dbsprite -20,   8, $02, 0
	dbsprite -12,   8, $03, 1
	dbsprite -20, -16, $06, 0 | OAM_XFLIP
	dbsprite -12, -16, $07, 1 | OAM_XFLIP
	dbsprite -20, -24, $02, 0
	dbsprite -12, -24, $03, 1
	dbsprite   5, -16, $06, 0 | OAM_XFLIP
	dbsprite  13, -16, $07, 1 | OAM_XFLIP
	dbsprite   5, -24, $02, 0
	dbsprite  13, -24, $03, 1
	dbsprite   5,  16, $06, 0 | OAM_XFLIP
	dbsprite  13,  16, $07, 1 | OAM_XFLIP
	dbsprite   5,   8, $02, 0
	dbsprite  13,   8, $03, 1

.frame_17
	db 16 ; size
	dbsprite -20, -24, $04, 0
	dbsprite -12, -24, $05, 1
	dbsprite -20, -16, $00, 0 | OAM_XFLIP
	dbsprite -12, -16, $01, 1 | OAM_XFLIP
	dbsprite -19,   8, $04, 0
	dbsprite -11,   8, $05, 1
	dbsprite -19,  16, $00, 0 | OAM_XFLIP
	dbsprite -11,  16, $01, 1 | OAM_XFLIP
	dbsprite   4,   8, $04, 0
	dbsprite  12,   8, $05, 1
	dbsprite   4,  16, $00, 0 | OAM_XFLIP
	dbsprite  12,  16, $01, 1 | OAM_XFLIP
	dbsprite   5, -24, $04, 0
	dbsprite  13, -24, $05, 1
	dbsprite   5, -16, $00, 0 | OAM_XFLIP
	dbsprite  13, -16, $01, 1 | OAM_XFLIP

.frame_18
	db 12 ; size
	dbsprite -20, -20, $08, 0
	dbsprite -12, -20, $18, 1
	dbsprite -20,  12, $08, 0
	dbsprite -12,  12, $18, 1
	dbsprite   4,  12, $08, 0
	dbsprite  12,  12, $18, 1
	dbsprite   4, -20, $08, 0
	dbsprite  12, -20, $18, 1
	dbsprite -12, -20, $09, 1
	dbsprite -12,  12, $09, 1
	dbsprite  12,  12, $09, 1
	dbsprite  12, -20, $09, 1

.frame_19
	db 4 ; size
	dbsprite -16, -20, $0c, 0
	dbsprite -16,  12, $0c, 0
	dbsprite   8,  12, $0c, 0
	dbsprite   8, -20, $0c, 0

OAMData0C::
	dw .frame_0
	dw .frame_1
	dw .frame_2
	dw .frame_3
	dw .frame_4
	dw .frame_5
	dw .frame_6
	dw .frame_7

.frame_0
	db 4 ; size
	dbsprite -42, -10, $18, 0 | OAM_XFLIP
	dbsprite -42, -18, $19, 0 | OAM_XFLIP
	dbsprite -34, -10, $1a, 0 | OAM_XFLIP
	dbsprite -34, -18, $1b, 0 | OAM_XFLIP

.frame_1
	db 4 ; size
	dbsprite -14, -10, $18, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite -14, -18, $19, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite -22, -10, $1a, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite -22, -18, $1b, 0 | OAM_XFLIP | OAM_YFLIP

.frame_2
	db 4 ; size
	dbsprite -14,   2, $18, 0 | OAM_YFLIP
	dbsprite -14,  10, $19, 0 | OAM_YFLIP
	dbsprite -22,   2, $1a, 0 | OAM_YFLIP
	dbsprite -22,  10, $1b, 0 | OAM_YFLIP

.frame_3
	db 4 ; size
	dbsprite -42,   2, $18, 0
	dbsprite -42,  10, $19, 0
	dbsprite -34,   2, $1a, 0
	dbsprite -34,  10, $1b, 0

.frame_4
	db 11 ; size
	dbsprite -32, -24, $0d, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite -32, -32, $0e, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite -40, -32, $11, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite -48, -32, $14, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite -56, -28, $16, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite -56, -20, $15, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite -48, -16, $12, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite -48, -24, $13, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite -40, -24, $10, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite -40, -16, $0f, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite -56,  -8, $17, 0 | OAM_XFLIP | OAM_YFLIP

.frame_5
	db 13 ; size
	dbsprite   1,  -8, $00, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite  -7,  -8, $05, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite   1, -16, $01, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite  -7, -16, $06, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite   0, -24, $02, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite  -8, -24, $07, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite -16, -24, $0a, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite  -1, -32, $03, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite  -1, -40, $04, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite  -9, -40, $09, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite -17, -40, $0c, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite -17, -32, $0b, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite  -9, -32, $08, 0 | OAM_XFLIP | OAM_YFLIP

.frame_6
	db 11 ; size
	dbsprite -24,  16, $0d, 0
	dbsprite -24,  24, $0e, 0
	dbsprite -16,  24, $11, 0
	dbsprite  -8,  24, $14, 0
	dbsprite   0,  20, $16, 0
	dbsprite   0,  12, $15, 0
	dbsprite  -8,   8, $12, 0
	dbsprite  -8,  16, $13, 0
	dbsprite -16,  16, $10, 0
	dbsprite -16,   8, $0f, 0
	dbsprite   0,   0, $17, 0

.frame_7
	db 13 ; size
	dbsprite -57,   0, $00, 0
	dbsprite -49,   0, $05, 0
	dbsprite -57,   8, $01, 0
	dbsprite -49,   8, $06, 0
	dbsprite -56,  16, $02, 0
	dbsprite -48,  16, $07, 0
	dbsprite -40,  16, $0a, 0
	dbsprite -55,  24, $03, 0
	dbsprite -55,  32, $04, 0
	dbsprite -47,  32, $09, 0
	dbsprite -39,  32, $0c, 0
	dbsprite -39,  24, $0b, 0
	dbsprite -47,  24, $08, 0

OAMData0D::
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
	db 8 ; size
	dbsprite -24,  -8, $14, 1
	dbsprite -24,   0, $15, 1
	dbsprite -24,   8, $16, 1
	dbsprite -16,   8, $18, 1
	dbsprite -16,   0, $17, 1
	dbsprite -16,  -8, $17, 1 | OAM_XFLIP
	dbsprite -24, -16, $16, 1 | OAM_XFLIP
	dbsprite -16, -16, $18, 1 | OAM_XFLIP

.frame_1
	db 20 ; size
	dbsprite -32, -20, $34, 1
	dbsprite -33, -12, $35, 1
	dbsprite -32,  -4, $36, 1
	dbsprite -33,   4, $37, 1
	dbsprite -32,  12, $38, 1
	dbsprite -24, -20, $39, 1
	dbsprite -25, -12, $3a, 1
	dbsprite -24,  -4, $3b, 1
	dbsprite -25,   4, $3c, 1
	dbsprite -24,  12, $3d, 1
	dbsprite -16, -20, $3e, 1
	dbsprite -17, -12, $3f, 1
	dbsprite -16,  -4, $40, 1
	dbsprite -17,   4, $41, 1
	dbsprite -16,  12, $42, 1
	dbsprite  -9, -12, $43, 1
	dbsprite  -8,  -4, $44, 1
	dbsprite  -9,   4, $43, 1 | OAM_XFLIP
	dbsprite  -1, -12, $45, 1
	dbsprite  -1,   4, $45, 1 | OAM_XFLIP

.frame_2
	db 20 ; size
	dbsprite -32,  12, $34, 1 | OAM_XFLIP
	dbsprite -33,   4, $35, 1 | OAM_XFLIP
	dbsprite -32,  -4, $46, 1
	dbsprite -33, -12, $37, 1 | OAM_XFLIP
	dbsprite -32, -20, $38, 1 | OAM_XFLIP
	dbsprite -24,  12, $39, 1 | OAM_XFLIP
	dbsprite -25,   4, $48, 1
	dbsprite -24,  -4, $3b, 1
	dbsprite -25, -12, $47, 1
	dbsprite -24, -20, $3d, 1 | OAM_XFLIP
	dbsprite -16,  12, $3e, 1 | OAM_XFLIP
	dbsprite -17,   4, $3f, 1 | OAM_XFLIP
	dbsprite -16,  -4, $40, 1
	dbsprite -17, -12, $41, 1 | OAM_XFLIP
	dbsprite -16, -20, $42, 1 | OAM_XFLIP
	dbsprite  -9,   4, $43, 1 | OAM_XFLIP
	dbsprite  -8,  -4, $44, 1
	dbsprite  -9, -12, $43, 1
	dbsprite  -1,   4, $45, 0 | OAM_XFLIP
	dbsprite  -1, -12, $45, 0

.frame_3
	db 23 ; size
	dbsprite -38, -10, $49, 2
	dbsprite -38,  -2, $4a, 2
	dbsprite -30,  -2, $4b, 2
	dbsprite -32, -20, $34, 1
	dbsprite -33, -12, $35, 1
	dbsprite -32,  -4, $36, 1
	dbsprite -33,   4, $37, 1
	dbsprite -32,  12, $38, 1
	dbsprite -24, -20, $39, 1
	dbsprite -25, -12, $3a, 1
	dbsprite -24,  -4, $3b, 1
	dbsprite -25,   4, $3c, 1
	dbsprite -24,  12, $3d, 1
	dbsprite -16, -20, $3e, 1
	dbsprite -17, -12, $3f, 1
	dbsprite -16,  -4, $40, 1
	dbsprite -17,   4, $41, 1
	dbsprite -16,  12, $42, 1
	dbsprite  -9, -12, $43, 1
	dbsprite  -8,  -4, $44, 1
	dbsprite  -9,   4, $43, 1 | OAM_XFLIP
	dbsprite  -1, -12, $45, 1
	dbsprite  -1,   4, $45, 1 | OAM_XFLIP

.frame_4
	db 23 ; size
	dbsprite -38, -10, $49, 2
	dbsprite -38,  -2, $4a, 2
	dbsprite -30,  -2, $4b, 2
	dbsprite -32,  12, $34, 1 | OAM_XFLIP
	dbsprite -33,   4, $35, 1 | OAM_XFLIP
	dbsprite -32,  -4, $46, 1
	dbsprite -33, -12, $37, 1 | OAM_XFLIP
	dbsprite -32, -20, $38, 1 | OAM_XFLIP
	dbsprite -24,  12, $39, 1 | OAM_XFLIP
	dbsprite -25,   4, $48, 1
	dbsprite -24,  -4, $3b, 1
	dbsprite -25, -12, $47, 1
	dbsprite -24, -20, $3d, 1 | OAM_XFLIP
	dbsprite -16,  12, $3e, 1 | OAM_XFLIP
	dbsprite -17,   4, $3f, 1 | OAM_XFLIP
	dbsprite -16,  -4, $40, 1
	dbsprite -17, -12, $41, 1 | OAM_XFLIP
	dbsprite -16, -20, $42, 1 | OAM_XFLIP
	dbsprite  -9,   4, $43, 1 | OAM_XFLIP
	dbsprite  -8,  -4, $44, 1
	dbsprite  -9, -12, $43, 1
	dbsprite  -1,   4, $45, 0 | OAM_XFLIP
	dbsprite  -1, -12, $45, 0

.frame_5
	db 23 ; size
	dbsprite -46, -10, $49, 2
	dbsprite -46,  -2, $4a, 2
	dbsprite -38,  -2, $4b, 2
	dbsprite -32, -20, $34, 1
	dbsprite -33, -12, $35, 1
	dbsprite -32,  -4, $36, 1
	dbsprite -33,   4, $37, 1
	dbsprite -32,  12, $38, 1
	dbsprite -24, -20, $39, 1
	dbsprite -25, -12, $3a, 1
	dbsprite -24,  -4, $3b, 1
	dbsprite -25,   4, $3c, 1
	dbsprite -24,  12, $3d, 1
	dbsprite -16, -20, $3e, 1
	dbsprite -17, -12, $3f, 1
	dbsprite -16,  -4, $40, 1
	dbsprite -17,   4, $41, 1
	dbsprite -16,  12, $42, 1
	dbsprite  -9, -12, $43, 1
	dbsprite  -8,  -4, $44, 1
	dbsprite  -9,   4, $43, 1 | OAM_XFLIP
	dbsprite  -1, -12, $45, 0
	dbsprite  -1,   4, $45, 0 | OAM_XFLIP

.frame_6
	db 23 ; size
	dbsprite -46,  -2, $49, 2
	dbsprite -46,   6, $4a, 2
	dbsprite -38,   6, $4b, 2
	dbsprite -32,  12, $34, 1 | OAM_XFLIP
	dbsprite -33,   4, $35, 1 | OAM_XFLIP
	dbsprite -32,  -4, $46, 1
	dbsprite -33, -12, $37, 1 | OAM_XFLIP
	dbsprite -32, -20, $38, 1 | OAM_XFLIP
	dbsprite -24,  12, $39, 1 | OAM_XFLIP
	dbsprite -25,   4, $48, 1
	dbsprite -24,  -4, $3b, 1
	dbsprite -25, -12, $47, 1
	dbsprite -24, -20, $3d, 1 | OAM_XFLIP
	dbsprite -16,  12, $3e, 1 | OAM_XFLIP
	dbsprite -17,   4, $3f, 1 | OAM_XFLIP
	dbsprite -16,  -4, $40, 1
	dbsprite -17, -12, $41, 1 | OAM_XFLIP
	dbsprite -16, -20, $42, 1 | OAM_XFLIP
	dbsprite  -9,   4, $43, 1 | OAM_XFLIP
	dbsprite  -8,  -4, $44, 1
	dbsprite  -9, -12, $43, 1
	dbsprite  -1,   4, $45, 1 | OAM_XFLIP
	dbsprite  -1, -12, $45, 1

.frame_7
	db 23 ; size
	dbsprite -46,  14, $49, 2
	dbsprite -46,  22, $4a, 2
	dbsprite -38,  22, $4b, 2
	dbsprite -32, -20, $34, 1
	dbsprite -33, -12, $35, 1
	dbsprite -32,  -4, $36, 1
	dbsprite -33,   4, $37, 1
	dbsprite -32,  12, $38, 1
	dbsprite -24, -20, $39, 1
	dbsprite -25, -12, $3a, 1
	dbsprite -24,  -4, $3b, 1
	dbsprite -25,   4, $3c, 1
	dbsprite -24,  12, $3d, 1
	dbsprite -16, -20, $3e, 1
	dbsprite -17, -12, $3f, 1
	dbsprite -16,  -4, $40, 1
	dbsprite -17,   4, $41, 1
	dbsprite -16,  12, $42, 1
	dbsprite  -9, -12, $43, 1
	dbsprite  -8,  -4, $44, 1
	dbsprite  -9,   4, $43, 1 | OAM_XFLIP
	dbsprite  -1, -12, $45, 1
	dbsprite  -1,   4, $45, 1 | OAM_XFLIP

.frame_8
	db 23 ; size
	dbsprite -38,  30, $49, 2
	dbsprite -38,  38, $4a, 2
	dbsprite -30,  38, $4b, 2
	dbsprite -32,  12, $34, 1 | OAM_XFLIP
	dbsprite -33,   4, $35, 1 | OAM_XFLIP
	dbsprite -32,  -4, $46, 1
	dbsprite -33, -12, $37, 1 | OAM_XFLIP
	dbsprite -32, -20, $38, 1 | OAM_XFLIP
	dbsprite -24,  12, $39, 1 | OAM_XFLIP
	dbsprite -25,   4, $48, 1
	dbsprite -24,  -4, $3b, 1
	dbsprite -25, -12, $47, 1
	dbsprite -24, -20, $3d, 1 | OAM_XFLIP
	dbsprite -16,  12, $3e, 1 | OAM_XFLIP
	dbsprite -17,   4, $3f, 1 | OAM_XFLIP
	dbsprite -16,  -4, $40, 1
	dbsprite -17, -12, $41, 1 | OAM_XFLIP
	dbsprite -16, -20, $42, 1 | OAM_XFLIP
	dbsprite  -9,   4, $43, 1 | OAM_XFLIP
	dbsprite  -8,  -4, $44, 1
	dbsprite  -9, -12, $43, 1
	dbsprite  -1,   4, $45, 1 | OAM_XFLIP
	dbsprite  -1, -12, $45, 1

.frame_9
	db 23 ; size
	dbsprite -22,  38, $49, 2
	dbsprite -22,  46, $4a, 2
	dbsprite -14,  46, $4b, 2
	dbsprite -32, -20, $34, 1
	dbsprite -33, -12, $35, 1
	dbsprite -32,  -4, $36, 1
	dbsprite -33,   4, $37, 1
	dbsprite -32,  12, $38, 1
	dbsprite -24, -20, $39, 1
	dbsprite -25, -12, $3a, 1
	dbsprite -24,  -4, $3b, 1
	dbsprite -25,   4, $3c, 1
	dbsprite -24,  12, $3d, 1
	dbsprite -16, -20, $3e, 1
	dbsprite -17, -12, $3f, 1
	dbsprite -16,  -4, $40, 1
	dbsprite -17,   4, $41, 1
	dbsprite -16,  12, $42, 1
	dbsprite  -9, -12, $43, 1
	dbsprite  -8,  -4, $44, 1
	dbsprite  -9,   4, $43, 1 | OAM_XFLIP
	dbsprite  -1, -12, $45, 1
	dbsprite  -1,   4, $45, 1 | OAM_XFLIP

.frame_10
	db 23 ; size
	dbsprite -54, -18, $49, 2
	dbsprite -54, -10, $4a, 2
	dbsprite -46, -10, $4b, 2
	dbsprite -32,  12, $34, 1 | OAM_XFLIP
	dbsprite -33,   4, $35, 1 | OAM_XFLIP
	dbsprite -32,  -4, $46, 1
	dbsprite -33, -12, $37, 1 | OAM_XFLIP
	dbsprite -32, -20, $38, 1 | OAM_XFLIP
	dbsprite -24,  12, $39, 1 | OAM_XFLIP
	dbsprite -25,   4, $48, 1
	dbsprite -24,  -4, $3b, 1
	dbsprite -25, -12, $47, 1
	dbsprite -24, -20, $3d, 1 | OAM_XFLIP
	dbsprite -16,  12, $3e, 1 | OAM_XFLIP
	dbsprite -17,   4, $3f, 1 | OAM_XFLIP
	dbsprite -16,  -4, $40, 1
	dbsprite -17, -12, $41, 1 | OAM_XFLIP
	dbsprite -16, -20, $42, 1 | OAM_XFLIP
	dbsprite  -9,   4, $43, 1 | OAM_XFLIP
	dbsprite  -8,  -4, $44, 1
	dbsprite  -9, -12, $43, 1
	dbsprite  -1,   4, $45, 1 | OAM_XFLIP
	dbsprite  -1, -12, $45, 1

.frame_11
	db 23 ; size
	dbsprite -54, -34, $49, 2
	dbsprite -54, -26, $4a, 2
	dbsprite -46, -26, $4b, 2
	dbsprite -32, -20, $34, 1
	dbsprite -33, -12, $35, 1
	dbsprite -32,  -4, $36, 1
	dbsprite -33,   4, $37, 1
	dbsprite -32,  12, $38, 1
	dbsprite -24, -20, $39, 1
	dbsprite -25, -12, $3a, 1
	dbsprite -24,  -4, $3b, 1
	dbsprite -25,   4, $3c, 1
	dbsprite -24,  12, $3d, 1
	dbsprite -16, -20, $3e, 1
	dbsprite -17, -12, $3f, 1
	dbsprite -16,  -4, $40, 1
	dbsprite -17,   4, $41, 1
	dbsprite -16,  12, $42, 1
	dbsprite  -9, -12, $43, 1
	dbsprite  -8,  -4, $44, 1
	dbsprite  -9,   4, $43, 1 | OAM_XFLIP
	dbsprite  -1, -12, $45, 1
	dbsprite  -1,   4, $45, 1 | OAM_XFLIP

.frame_12
	db 23 ; size
	dbsprite -54, -50, $49, 2
	dbsprite -54, -42, $4a, 2
	dbsprite -46, -42, $4b, 2
	dbsprite -32,  12, $34, 1 | OAM_XFLIP
	dbsprite -33,   4, $35, 1 | OAM_XFLIP
	dbsprite -32,  -4, $46, 1
	dbsprite -33, -12, $37, 1 | OAM_XFLIP
	dbsprite -32, -20, $38, 1 | OAM_XFLIP
	dbsprite -24,  12, $39, 1 | OAM_XFLIP
	dbsprite -25,   4, $48, 1
	dbsprite -24,  -4, $3b, 1
	dbsprite -25, -12, $47, 1
	dbsprite -24, -20, $3d, 1 | OAM_XFLIP
	dbsprite -16,  12, $3e, 1 | OAM_XFLIP
	dbsprite -17,   4, $3f, 1 | OAM_XFLIP
	dbsprite -16,  -4, $40, 1
	dbsprite -17, -12, $41, 1 | OAM_XFLIP
	dbsprite -16, -20, $42, 1 | OAM_XFLIP
	dbsprite  -9,   4, $43, 1 | OAM_XFLIP
	dbsprite  -8,  -4, $44, 1
	dbsprite  -9, -12, $43, 1
	dbsprite  -1,   4, $45, 1 | OAM_XFLIP
	dbsprite  -1, -12, $45, 1

.frame_13
	db 23 ; size
	dbsprite -46, -66, $49, 2
	dbsprite -46, -58, $4a, 2
	dbsprite -38, -58, $4b, 2
	dbsprite -32, -20, $34, 1
	dbsprite -33, -12, $35, 1
	dbsprite -32,  -4, $36, 1
	dbsprite -33,   4, $37, 1
	dbsprite -32,  12, $38, 1
	dbsprite -24, -20, $39, 1
	dbsprite -25, -12, $3a, 1
	dbsprite -24,  -4, $3b, 1
	dbsprite -25,   4, $3c, 1
	dbsprite -24,  12, $3d, 1
	dbsprite -16, -20, $3e, 1
	dbsprite -17, -12, $3f, 1
	dbsprite -16,  -4, $40, 1
	dbsprite -17,   4, $41, 1
	dbsprite -16,  12, $42, 1
	dbsprite  -9, -12, $43, 1
	dbsprite  -8,  -4, $44, 1
	dbsprite  -9,   4, $43, 1 | OAM_XFLIP
	dbsprite  -1, -12, $45, 0
	dbsprite  -1,   4, $45, 0 | OAM_XFLIP

.frame_14
	db 23 ; size
	dbsprite -38, -74, $49, 2
	dbsprite -38, -66, $4a, 2
	dbsprite -30, -66, $4b, 2
	dbsprite -32,  12, $34, 1 | OAM_XFLIP
	dbsprite -33,   4, $35, 1 | OAM_XFLIP
	dbsprite -32,  -4, $46, 1
	dbsprite -33, -12, $37, 1 | OAM_XFLIP
	dbsprite -32, -20, $38, 1 | OAM_XFLIP
	dbsprite -24,  12, $39, 1 | OAM_XFLIP
	dbsprite -25,   4, $48, 1
	dbsprite -24,  -4, $3b, 1
	dbsprite -25, -12, $47, 1
	dbsprite -24, -20, $3d, 1 | OAM_XFLIP
	dbsprite -16,  12, $3e, 1 | OAM_XFLIP
	dbsprite -17,   4, $3f, 1 | OAM_XFLIP
	dbsprite -16,  -4, $40, 1
	dbsprite -17, -12, $41, 1 | OAM_XFLIP
	dbsprite -16, -20, $42, 1 | OAM_XFLIP
	dbsprite  -9,   4, $43, 1 | OAM_XFLIP
	dbsprite  -8,  -4, $44, 1
	dbsprite  -9, -12, $43, 1
	dbsprite  -1,   4, $45, 0 | OAM_XFLIP
	dbsprite  -1, -12, $45, 0

.frame_15
	db 23 ; size
	dbsprite -38, -74, $49, 2
	dbsprite -38, -66, $4a, 2
	dbsprite -30, -66, $4b, 2
	dbsprite -32, -20, $34, 1
	dbsprite -33, -12, $35, 1
	dbsprite -32,  -4, $36, 1
	dbsprite -33,   4, $37, 1
	dbsprite -32,  12, $38, 1
	dbsprite -24, -20, $39, 1
	dbsprite -25, -12, $3a, 1
	dbsprite -24,  -4, $3b, 1
	dbsprite -25,   4, $3c, 1
	dbsprite -24,  12, $3d, 1
	dbsprite -16, -20, $3e, 1
	dbsprite -17, -12, $3f, 1
	dbsprite -16,  -4, $40, 1
	dbsprite -17,   4, $41, 1
	dbsprite -16,  12, $42, 1
	dbsprite  -9, -12, $43, 1
	dbsprite  -8,  -4, $44, 1
	dbsprite  -9,   4, $43, 1 | OAM_XFLIP
	dbsprite  -1, -12, $45, 1
	dbsprite  -1,   4, $45, 1 | OAM_XFLIP

.frame_16
	db 12 ; size
	dbsprite   0, -32, $00, 0
	dbsprite   0, -24, $01, 0
	dbsprite   8, -32, $03, 0
	dbsprite   8, -24, $04, 0
	dbsprite  16, -32, $06, 0
	dbsprite  16, -24, $07, 0
	dbsprite   0,  16, $0b, 0 | OAM_XFLIP
	dbsprite   0,  24, $0a, 0 | OAM_XFLIP
	dbsprite   8,  24, $0d, 0 | OAM_XFLIP
	dbsprite   8,  16, $0e, 0 | OAM_XFLIP
	dbsprite  16,  16, $11, 0 | OAM_XFLIP
	dbsprite  16,  24, $10, 0 | OAM_XFLIP

.frame_17
	db 12 ; size
	dbsprite   0,  24, $00, 0 | OAM_XFLIP
	dbsprite   0,  16, $01, 0 | OAM_XFLIP
	dbsprite   8,  24, $03, 0 | OAM_XFLIP
	dbsprite   8,  16, $04, 0 | OAM_XFLIP
	dbsprite  16,  24, $06, 0 | OAM_XFLIP
	dbsprite  16,  16, $07, 0 | OAM_XFLIP
	dbsprite   0, -24, $0b, 0
	dbsprite   0, -32, $0a, 0
	dbsprite   8, -32, $0d, 0
	dbsprite   8, -24, $0e, 0
	dbsprite  16, -24, $11, 0
	dbsprite  16, -32, $10, 0

.frame_18
	db 19 ; size
	dbsprite  -8, -24, $00, 0
	dbsprite  -8, -16, $01, 0
	dbsprite   0, -32, $02, 0
	dbsprite   0, -24, $03, 0
	dbsprite   0, -16, $04, 0
	dbsprite   8, -32, $05, 0
	dbsprite   8, -24, $06, 0
	dbsprite   8, -16, $07, 0
	dbsprite  16, -32, $08, 0
	dbsprite  16, -24, $09, 0
	dbsprite  -8,   8, $0b, 0 | OAM_XFLIP
	dbsprite  -8,  16, $0a, 0 | OAM_XFLIP
	dbsprite   0,  24, $0a, 0 | OAM_XFLIP
	dbsprite   0,  16, $0d, 0 | OAM_XFLIP
	dbsprite   0,   8, $0e, 0 | OAM_XFLIP
	dbsprite   8,   8, $11, 0 | OAM_XFLIP
	dbsprite   8,  16, $10, 0 | OAM_XFLIP
	dbsprite   8,  24, $0f, 0 | OAM_XFLIP
	dbsprite  16,  24, $12, 0 | OAM_XFLIP

.frame_19
	db 19 ; size
	dbsprite  -8,  16, $00, 0 | OAM_XFLIP
	dbsprite  -8,   8, $01, 0 | OAM_XFLIP
	dbsprite   0,  24, $02, 0 | OAM_XFLIP
	dbsprite   0,  16, $03, 0 | OAM_XFLIP
	dbsprite   0,   8, $04, 0 | OAM_XFLIP
	dbsprite   8,  24, $05, 0 | OAM_XFLIP
	dbsprite   8,  16, $06, 0 | OAM_XFLIP
	dbsprite   8,   8, $07, 0 | OAM_XFLIP
	dbsprite  16,  24, $08, 0 | OAM_XFLIP
	dbsprite  16,  16, $09, 0 | OAM_XFLIP
	dbsprite  -8, -16, $0b, 0
	dbsprite  -8, -24, $0a, 0
	dbsprite   0, -32, $0a, 0
	dbsprite   0, -24, $0d, 0
	dbsprite   0, -16, $0e, 0
	dbsprite   8, -16, $11, 0
	dbsprite   8, -24, $10, 0
	dbsprite   8, -32, $0f, 0
	dbsprite  16, -32, $12, 0

.frame_20
	db 29 ; size
	dbsprite  -8, -24, $00, 0
	dbsprite  -8, -16, $01, 0
	dbsprite   0, -32, $02, 0
	dbsprite   0, -24, $03, 0
	dbsprite   0, -16, $04, 0
	dbsprite   8, -32, $05, 0
	dbsprite   8, -24, $06, 0
	dbsprite   8, -16, $07, 0
	dbsprite  16, -32, $08, 0
	dbsprite  16, -24, $09, 0
	dbsprite  -8,   8, $0b, 0 | OAM_XFLIP
	dbsprite  -8,  16, $0a, 0 | OAM_XFLIP
	dbsprite   0,  24, $0a, 0 | OAM_XFLIP
	dbsprite   0,  16, $0d, 0 | OAM_XFLIP
	dbsprite   0,   8, $0e, 0 | OAM_XFLIP
	dbsprite   8,   8, $11, 0 | OAM_XFLIP
	dbsprite   8,  16, $10, 0 | OAM_XFLIP
	dbsprite   8,  24, $0f, 0 | OAM_XFLIP
	dbsprite  16,  24, $12, 0 | OAM_XFLIP
	dbsprite  -8,  -8, $19, 0
	dbsprite  -8,   0, $1a, 0
	dbsprite  -8,   8, $1b, 0
	dbsprite   0,   8, $1e, 0
	dbsprite   8,   8, $21, 0
	dbsprite   8,   0, $20, 0
	dbsprite   8,  -8, $1f, 0
	dbsprite   0,  -8, $1c, 0
	dbsprite   0,   0, $1d, 0
	dbsprite  16,  16, $13, 0 | OAM_XFLIP

.frame_21
	db 9 ; size
	dbsprite -16, -16, $22, 0
	dbsprite -16,  -8, $23, 0
	dbsprite -16,   0, $24, 0
	dbsprite  -8,   0, $27, 0
	dbsprite  -8,  -8, $26, 0
	dbsprite  -8, -16, $25, 0
	dbsprite   0, -16, $28, 0
	dbsprite   0,  -8, $29, 0
	dbsprite   0,   0, $2a, 0

.frame_22
	db 9 ; size
	dbsprite  -8,   0, $2d, 0
	dbsprite  -8,  -8, $2c, 0
	dbsprite  -8, -16, $2b, 0
	dbsprite   0, -16, $2e, 0
	dbsprite   0,  -8, $2f, 0
	dbsprite   0,   0, $30, 0
	dbsprite   8,   0, $33, 0
	dbsprite   8,  -8, $32, 0
	dbsprite   8, -16, $31, 0

.frame_23
	db 9 ; size
	dbsprite  -8,  -8, $19, 0
	dbsprite  -8,   0, $1a, 0
	dbsprite  -8,   8, $1b, 0
	dbsprite   0,   8, $1e, 0
	dbsprite   8,   8, $21, 0
	dbsprite   8,   0, $20, 0
	dbsprite   8,  -8, $1f, 0
	dbsprite   0,  -8, $1c, 0
	dbsprite   0,   0, $1d, 0

OAMData0E::
	dw .frame_0
	dw .frame_1
	dw .frame_2
	dw .frame_3
	dw .frame_4
	dw .frame_5
	dw .frame_6
	dw .frame_7

.frame_0
	db 3 ; size
	dbsprite  17, -24, $01, 0
	dbsprite  17,   0, $01, 0
	dbsprite  17,  24, $01, 0

.frame_1
	db 6 ; size
	dbsprite  13, -24, $01, 0
	dbsprite  18,  16, $01, 0
	dbsprite  10,   0, $02, 0
	dbsprite  11,  24, $02, 0
	dbsprite  16, -56, $01, 0
	dbsprite  16,  56, $01, 0

.frame_2
	db 10 ; size
	dbsprite -10,   0, $00, 1
	dbsprite  -7,  24, $00, 1
	dbsprite   8, -24, $02, 0
	dbsprite  12,  16, $02, 0
	dbsprite  16,  -8, $01, 0
	dbsprite  12, -56, $02, 0
	dbsprite  16,  40, $01, 0
	dbsprite  12,  56, $02, 0
	dbsprite  -2,   0, $00, 0 | OAM_YFLIP
	dbsprite   1,  24, $00, 0 | OAM_YFLIP

.frame_3
	db 16 ; size
	dbsprite  -7,  16, $00, 1
	dbsprite -17, -24, $00, 1
	dbsprite  16, -32, $01, 0
	dbsprite  16,   8, $01, 0
	dbsprite   8,  -8, $02, 0
	dbsprite -26,   0, $00, 1
	dbsprite -24,  24, $00, 1
	dbsprite   0, -56, $00, 1
	dbsprite   8,  40, $02, 0
	dbsprite   0,  56, $00, 1
	dbsprite   8, -56, $00, 0 | OAM_YFLIP
	dbsprite  -9, -24, $00, 0 | OAM_YFLIP
	dbsprite -18,   0, $00, 0 | OAM_YFLIP
	dbsprite -16,  24, $00, 0 | OAM_YFLIP
	dbsprite   1,  16, $00, 0 | OAM_YFLIP
	dbsprite   8,  56, $00, 0 | OAM_YFLIP

.frame_4
	db 18 ; size
	dbsprite   8, -32, $02, 0
	dbsprite   5,   8, $02, 0
	dbsprite -12,  -8, $00, 1
	dbsprite -27, -24, $00, 1
	dbsprite -21,  16, $00, 1
	dbsprite -50,   0, $00, 1
	dbsprite -34,  24, $00, 1
	dbsprite  -8,  40, $00, 1
	dbsprite -16, -56, $00, 1
	dbsprite  -8,  56, $00, 1
	dbsprite  -8, -56, $00, 0 | OAM_YFLIP
	dbsprite -19, -24, $00, 0 | OAM_YFLIP
	dbsprite  -4,  -8, $00, 0 | OAM_YFLIP
	dbsprite -42,   0, $00, 0 | OAM_YFLIP
	dbsprite -13,  16, $00, 0 | OAM_YFLIP
	dbsprite -26,  24, $00, 0 | OAM_YFLIP
	dbsprite   0,  40, $00, 0 | OAM_YFLIP
	dbsprite   0,  56, $00, 0 | OAM_YFLIP

.frame_5
	db 16 ; size
	dbsprite -19, -32, $00, 1
	dbsprite  -9,   8, $00, 1
	dbsprite -51, -24, $00, 1
	dbsprite -32,  -8, $00, 1
	dbsprite -29,  40, $00, 1
	dbsprite -40, -56, $00, 1
	dbsprite -40,  56, $00, 1
	dbsprite -64,  16, $00, 1
	dbsprite -32, -56, $00, 0 | OAM_YFLIP
	dbsprite -11, -32, $00, 0 | OAM_YFLIP
	dbsprite -43, -24, $00, 0 | OAM_YFLIP
	dbsprite -24,  -8, $00, 0 | OAM_YFLIP
	dbsprite  -1,   8, $00, 0 | OAM_YFLIP
	dbsprite -56,  16, $00, 0 | OAM_YFLIP
	dbsprite -21,  40, $00, 0 | OAM_YFLIP
	dbsprite -32,  56, $00, 0 | OAM_YFLIP

.frame_6
	db 12 ; size
	dbsprite -32,   8, $00, 1
	dbsprite -48, -32, $00, 1
	dbsprite -64,  -8, $00, 1
	dbsprite -61,  40, $00, 1
	dbsprite -40, -32, $00, 0 | OAM_YFLIP
	dbsprite -56,  -8, $00, 0 | OAM_YFLIP
	dbsprite -24,   8, $00, 0 | OAM_YFLIP
	dbsprite -53,  40, $00, 0 | OAM_YFLIP
	dbsprite -80, -56, $00, 1
	dbsprite -72, -56, $00, 0 | OAM_YFLIP
	dbsprite -80,  56, $00, 1
	dbsprite -72,  56, $00, 0 | OAM_YFLIP

.frame_7
	db 4 ; size
	dbsprite -64,   0, $00, 1
	dbsprite -56,   0, $00, 0 | OAM_YFLIP
	dbsprite -80, -32, $00, 1
	dbsprite -72, -32, $00, 0 | OAM_YFLIP

OAMData0F::
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
	db 4 ; size
	dbsprite -11,  -8, $00, 0
	dbsprite  -3,  -8, $01, 0
	dbsprite -11,   0, $00, 0 | OAM_XFLIP
	dbsprite  -3,   0, $01, 0 | OAM_XFLIP

.frame_1
	db 4 ; size
	dbsprite -11,  -8, $02, 0
	dbsprite  -3,  -8, $03, 0
	dbsprite -11,   0, $02, 0 | OAM_XFLIP
	dbsprite  -3,   0, $03, 0 | OAM_XFLIP

.frame_2
	db 4 ; size
	dbsprite -11,  -8, $04, 0
	dbsprite  -3,  -8, $05, 0
	dbsprite -11,   0, $04, 0 | OAM_XFLIP
	dbsprite  -3,   0, $05, 0 | OAM_XFLIP

.frame_3
	db 6 ; size
	dbsprite -19,  -8, $06, 0
	dbsprite -11,  -8, $07, 0
	dbsprite  -3,  -8, $08, 0
	dbsprite -19,   0, $06, 0 | OAM_XFLIP
	dbsprite -11,   0, $07, 0 | OAM_XFLIP
	dbsprite  -3,   0, $08, 0 | OAM_XFLIP

.frame_4
	db 6 ; size
	dbsprite -20,  -8, $09, 0
	dbsprite -12,  -8, $0a, 0
	dbsprite  -4,  -8, $0b, 0
	dbsprite -20,   0, $09, 0 | OAM_XFLIP
	dbsprite -12,   0, $0a, 0 | OAM_XFLIP
	dbsprite  -4,   0, $0b, 0 | OAM_XFLIP

.frame_5
	db 6 ; size
	dbsprite -19,  -8, $0c, 0
	dbsprite -11,  -8, $0d, 0
	dbsprite  -3,  -8, $0e, 0
	dbsprite -19,   0, $0c, 0 | OAM_XFLIP
	dbsprite -11,   0, $0d, 0 | OAM_XFLIP
	dbsprite  -3,   0, $0e, 0 | OAM_XFLIP

.frame_6
	db 8 ; size
	dbsprite -27,  -8, $0f, 0
	dbsprite -19,  -8, $10, 0
	dbsprite -11,  -8, $11, 0
	dbsprite  -3,  -8, $12, 0
	dbsprite -27,   0, $0f, 0 | OAM_XFLIP
	dbsprite -19,   0, $10, 0 | OAM_XFLIP
	dbsprite -11,   0, $11, 0 | OAM_XFLIP
	dbsprite  -3,   0, $12, 0 | OAM_XFLIP

.frame_7
	db 8 ; size
	dbsprite -27,  -8, $13, 0
	dbsprite -19,  -8, $14, 0
	dbsprite -11,  -8, $15, 0
	dbsprite  -3,  -8, $16, 0
	dbsprite -19,   0, $14, 0 | OAM_XFLIP
	dbsprite -11,   0, $15, 0 | OAM_XFLIP
	dbsprite  -3,   0, $16, 0 | OAM_XFLIP
	dbsprite -29,   0, $13, 0 | OAM_XFLIP

.frame_8
	db 8 ; size
	dbsprite -27,  -8, $17, 0
	dbsprite -19,  -8, $18, 0
	dbsprite -11,  -8, $19, 0
	dbsprite  -3,  -8, $1a, 0
	dbsprite -27,   0, $17, 0 | OAM_XFLIP
	dbsprite -19,   0, $18, 0 | OAM_XFLIP
	dbsprite -11,   0, $19, 0 | OAM_XFLIP
	dbsprite  -3,   0, $1a, 0 | OAM_XFLIP

OAMData10::
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
	dbsprite -16,  16, $05, 0
	dbsprite  -8,   8, $06, 0
	dbsprite  -8,  16, $04, 0
	dbsprite -16,   8, $04, 0
	dbsprite -24,   8, $06, 0
	dbsprite -24,  -8, $00, 1
	dbsprite -24,   0, $01, 0
	dbsprite -16,  -8, $02, 0
	dbsprite -16,   0, $03, 0

.frame_1
	db 10 ; size
	dbsprite -24,   0, $04, 0
	dbsprite -16,   8, $05, 0
	dbsprite -24,   8, $06, 0
	dbsprite  -8, -24, $00, 1 | OAM_YFLIP
	dbsprite  -8, -16, $01, 0 | OAM_YFLIP
	dbsprite -16, -24, $02, 0 | OAM_YFLIP
	dbsprite -16, -16, $00, 0 | OAM_YFLIP
	dbsprite -16,  -8, $01, 0 | OAM_YFLIP
	dbsprite -24, -16, $02, 0 | OAM_YFLIP
	dbsprite -24,  -8, $03, 0 | OAM_YFLIP

.frame_2
	db 11 ; size
	dbsprite -24, -16, $04, 0
	dbsprite -24, -32, $05, 0
	dbsprite -32, -24, $06, 0
	dbsprite  -8, -16, $00, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite  -8, -24, $01, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite -16, -16, $02, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite -16, -24, $03, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite   8, -16, $00, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite   8, -24, $01, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite   0, -16, $02, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite   0, -24, $03, 0 | OAM_XFLIP | OAM_YFLIP

.frame_3
	db 10 ; size
	dbsprite   0, -24, $06, 0
	dbsprite   0, -16, $05, 0
	dbsprite   8, -24, $04, 0
	dbsprite  -8, -24, $04, 0
	dbsprite  -8, -32, $06, 0
	dbsprite -24, -24, $06, 0
	dbsprite  16,  -8, $00, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite  16, -16, $01, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite   8,  -8, $02, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite   8, -16, $03, 0 | OAM_XFLIP | OAM_YFLIP

.frame_4
	db 9 ; size
	dbsprite   8, -24, $05, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite   0, -16, $06, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite   0, -24, $04, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite   8, -16, $04, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite  16, -16, $06, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite  16,   0, $00, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite  16,  -8, $01, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite   8,   0, $02, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite   8,  -8, $03, 0 | OAM_XFLIP | OAM_YFLIP

.frame_5
	db 10 ; size
	dbsprite  16,  -8, $04, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite   8, -16, $05, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite  16, -16, $06, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite   0,  16, $00, 1 | OAM_XFLIP
	dbsprite   0,   8, $01, 0 | OAM_XFLIP
	dbsprite   8,  16, $02, 0 | OAM_XFLIP
	dbsprite   8,   8, $00, 0 | OAM_XFLIP
	dbsprite   8,   0, $01, 0 | OAM_XFLIP
	dbsprite  16,   8, $02, 0 | OAM_XFLIP
	dbsprite  16,   0, $03, 0 | OAM_XFLIP

.frame_6
	db 10 ; size
	dbsprite   8,  16, $04, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite   0,  24, $05, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite   8,  24, $06, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite -16,   0, $00, 1
	dbsprite -16,   8, $01, 0
	dbsprite  -8,   0, $02, 0
	dbsprite  -8,   8, $00, 0
	dbsprite  -8,  16, $01, 0
	dbsprite   0,   8, $02, 0
	dbsprite   0,  16, $03, 0

.frame_7
	db 10 ; size
	dbsprite  -8,  16, $06, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite  -8,   8, $05, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite -16,  16, $04, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite   0,  16, $04, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite   0,  24, $06, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite  16,  16, $06, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite -24,   0, $00, 1
	dbsprite -24,   8, $01, 0
	dbsprite -16,   0, $02, 0
	dbsprite -16,   8, $03, 0

.frame_8
	db 12 ; size
	dbsprite  16,  -8, $06, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite  -8, -24, $06, 0
	dbsprite   8,  -8, $06, 0
	dbsprite   0, -24, $05, 0
	dbsprite   0,  16, $00, 1 | OAM_XFLIP
	dbsprite   0,   8, $01, 0 | OAM_XFLIP
	dbsprite   8,  16, $02, 0 | OAM_XFLIP
	dbsprite   8,   8, $00, 0 | OAM_XFLIP
	dbsprite   8,   0, $01, 0 | OAM_XFLIP
	dbsprite  16,   8, $02, 0 | OAM_XFLIP
	dbsprite  16,   0, $03, 0 | OAM_XFLIP
	dbsprite   8, -16, $04, 0

.frame_9
	db 5 ; size
	dbsprite  -8,   8, $06, 0
	dbsprite   8,   0, $05, 0
	dbsprite -16, -16, $04, 0
	dbsprite   0,  -8, $06, 0
	dbsprite   0, -24, $04, 0

.frame_10
	db 5 ; size
	dbsprite  -8,   0, $06, 0
	dbsprite -16, -16, $05, 0
	dbsprite   8,   8, $06, 0
	dbsprite   0, -16, $06, 0
	dbsprite -16,   0, $06, 0

.frame_11
	db 2 ; size
	dbsprite  -8,  16, $06, 0
	dbsprite   0,  -8, $06, 0

OAMData11::
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
	db 1 ; size
	dbsprite  -8, -16, $09, 0

.frame_1
	db 9 ; size
	dbsprite -16, -24, $00, 1
	dbsprite -16, -16, $01, 1
	dbsprite -16,  -8, $02, 1
	dbsprite  -8, -24, $03, 1
	dbsprite  -8, -16, $04, 1
	dbsprite  -8,  -8, $05, 1
	dbsprite   0, -24, $06, 1
	dbsprite   0, -16, $07, 1
	dbsprite   0,  -8, $08, 1

.frame_2
	db 6 ; size
	dbsprite -24, -16, $09, 0
	dbsprite   0,  -8, $09, 0
	dbsprite -16, -24, $09, 0
	dbsprite -16,  -8, $0a, 0
	dbsprite  -8, -32, $0a, 0
	dbsprite   8, -16, $0a, 0

.frame_3
	db 6 ; size
	dbsprite -16,   0, $0b, 0
	dbsprite  16, -16, $0b, 0
	dbsprite -16, -32, $0a, 0
	dbsprite -24, -16, $0a, 0
	dbsprite   0,   0, $0a, 0
	dbsprite   0, -32, $0b, 0

.frame_4
	db 7 ; size
	dbsprite   8, -36, $0b, 0
	dbsprite -16, -12, $0b, 0
	dbsprite  -8, -36, $0b, 0
	dbsprite   8,   4, $0b, 0
	dbsprite   0, -20, $0b, 0
	dbsprite   0,  -4, $0b, 0
	dbsprite  -8,   8, $09, 0

.frame_5
	db 11 ; size
	dbsprite  -8, -24, $0b, 0
	dbsprite   8,   0, $0b, 0
	dbsprite -16,   0, $00, 1
	dbsprite -16,   8, $01, 1
	dbsprite -16,  16, $02, 1
	dbsprite  -8,   0, $03, 1
	dbsprite  -8,   8, $04, 1
	dbsprite  -8,  16, $05, 1
	dbsprite   0,   0, $06, 1
	dbsprite   0,   8, $07, 1
	dbsprite   0,  16, $08, 1

.frame_6
	db 6 ; size
	dbsprite -24,   8, $09, 0
	dbsprite   0,  16, $09, 0
	dbsprite -16,   0, $09, 0
	dbsprite -16,  16, $0a, 0
	dbsprite  -8,  -8, $0a, 0
	dbsprite   8,   8, $0a, 0

.frame_7
	db 7 ; size
	dbsprite   0, -16, $0b, 0
	dbsprite -16,  24, $0b, 0
	dbsprite  16,   8, $0b, 0
	dbsprite -16,  -8, $0a, 0
	dbsprite -24,   8, $0a, 0
	dbsprite   0,  24, $0a, 0
	dbsprite  -8,  16, $09, 0

.frame_8
	db 6 ; size
	dbsprite   8,  28, $0b, 0 | OAM_XFLIP
	dbsprite -16,   4, $0b, 0 | OAM_XFLIP
	dbsprite  -8,  28, $0b, 0 | OAM_XFLIP
	dbsprite   8, -12, $0b, 0 | OAM_XFLIP
	dbsprite   0,  12, $0b, 0 | OAM_XFLIP
	dbsprite   0,  -4, $0b, 0 | OAM_XFLIP

OAMData12::
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
	db 20 ; size
	dbsprite -72, -128, $00, 0
	dbsprite -72, -88, $00, 0
	dbsprite -62, -104, $00, 0
	dbsprite -62, -64, $00, 0
	dbsprite -52, -120, $00, 0
	dbsprite -52, -80, $00, 0
	dbsprite -42, -96, $00, 0
	dbsprite -32, -112, $00, 0
	dbsprite -32, -72, $00, 0
	dbsprite -42, -56, $00, 0
	dbsprite -22, -128, $00, 0
	dbsprite -22, -88, $00, 0
	dbsprite -12, -104, $00, 0
	dbsprite -12, -64, $00, 0
	dbsprite  -2, -120, $00, 0
	dbsprite  -2, -80, $00, 0
	dbsprite   8, -96, $00, 0
	dbsprite  18, -112, $00, 0
	dbsprite  18, -72, $00, 0
	dbsprite   8, -56, $00, 0

.frame_1
	db 36 ; size
	dbsprite -72, -104, $00, 0
	dbsprite -72, -64, $00, 0
	dbsprite -72, -24, $00, 0
	dbsprite -62, -120, $00, 0
	dbsprite -62, -80, $00, 0
	dbsprite -62, -40, $00, 0
	dbsprite -62,   0, $00, 0
	dbsprite -52, -96, $00, 0
	dbsprite -52, -56, $00, 0
	dbsprite -52, -16, $00, 0
	dbsprite -42, -112, $00, 0
	dbsprite -42, -72, $00, 0
	dbsprite -42, -32, $00, 0
	dbsprite -32, -128, $00, 0
	dbsprite -32, -88, $00, 0
	dbsprite -32, -48, $00, 0
	dbsprite -32,  -8, $00, 0
	dbsprite -42,   8, $00, 0
	dbsprite -22, -104, $00, 0
	dbsprite -22, -64, $00, 0
	dbsprite -22, -24, $00, 0
	dbsprite -12, -120, $00, 0
	dbsprite -12, -80, $00, 0
	dbsprite -12, -40, $00, 0
	dbsprite -12,   0, $00, 0
	dbsprite  -2, -96, $00, 0
	dbsprite  -2, -56, $00, 0
	dbsprite  -2, -16, $00, 0
	dbsprite   8, -112, $00, 0
	dbsprite   8, -72, $00, 0
	dbsprite   8, -32, $00, 0
	dbsprite  18, -128, $00, 0
	dbsprite  18, -88, $00, 0
	dbsprite  18, -48, $00, 0
	dbsprite  18,  -8, $00, 0
	dbsprite   8,   8, $00, 0

.frame_2
	db 40 ; size
	dbsprite -72, -80, $00, 0
	dbsprite -72, -40, $00, 0
	dbsprite -72,   0, $00, 0
	dbsprite -72,  40, $00, 0
	dbsprite -62, -56, $00, 0
	dbsprite -62, -16, $00, 0
	dbsprite -62,  24, $00, 0
	dbsprite -62,  64, $00, 0
	dbsprite -52, -72, $00, 0
	dbsprite -52, -32, $00, 0
	dbsprite -52,   8, $00, 0
	dbsprite -52,  48, $00, 0
	dbsprite -42, -48, $00, 0
	dbsprite -42,  -8, $00, 0
	dbsprite -42,  32, $00, 0
	dbsprite -32, -64, $00, 0
	dbsprite -32, -24, $00, 0
	dbsprite -32,  16, $00, 0
	dbsprite -32,  56, $00, 0
	dbsprite -42,  72, $00, 0
	dbsprite -22, -80, $00, 0
	dbsprite -22, -40, $00, 0
	dbsprite -22,   0, $00, 0
	dbsprite -22,  40, $00, 0
	dbsprite -12, -56, $00, 0
	dbsprite -12, -16, $00, 0
	dbsprite -12,  24, $00, 0
	dbsprite -12,  64, $00, 0
	dbsprite  -2, -72, $00, 0
	dbsprite  -2, -32, $00, 0
	dbsprite  -2,   8, $00, 0
	dbsprite  -2,  48, $00, 0
	dbsprite   8, -48, $00, 0
	dbsprite   8,  -8, $00, 0
	dbsprite   8,  32, $00, 0
	dbsprite  18, -64, $00, 0
	dbsprite  18, -24, $00, 0
	dbsprite  18,  16, $00, 0
	dbsprite  18,  56, $00, 0
	dbsprite   8,  72, $00, 0

.frame_3
	db 40 ; size
	dbsprite -72, -64, $00, 0
	dbsprite -72, -24, $00, 0
	dbsprite -72,  16, $00, 0
	dbsprite -72,  56, $00, 0
	dbsprite -62, -40, $00, 0
	dbsprite -62,   0, $00, 0
	dbsprite -62,  40, $00, 0
	dbsprite -52, -56, $00, 0
	dbsprite -52, -16, $00, 0
	dbsprite -52,  24, $00, 0
	dbsprite -52,  64, $00, 0
	dbsprite -42, -32, $00, 0
	dbsprite -42,   8, $00, 0
	dbsprite -42,  48, $00, 0
	dbsprite -32, -48, $00, 0
	dbsprite -32,  -8, $00, 0
	dbsprite -32,  32, $00, 0
	dbsprite -32,  72, $00, 0
	dbsprite -22, -64, $00, 0
	dbsprite -22, -24, $00, 0
	dbsprite -22,  16, $00, 0
	dbsprite -22,  56, $00, 0
	dbsprite -12, -40, $00, 0
	dbsprite -12,   0, $00, 0
	dbsprite -12,  40, $00, 0
	dbsprite  -2, -56, $00, 0
	dbsprite  -2, -16, $00, 0
	dbsprite  -2,  24, $00, 0
	dbsprite  -2,  64, $00, 0
	dbsprite   8, -32, $00, 0
	dbsprite   8,   8, $00, 0
	dbsprite   8,  48, $00, 0
	dbsprite  18, -48, $00, 0
	dbsprite  18,  -8, $00, 0
	dbsprite  18,  32, $00, 0
	dbsprite  18,  72, $00, 0
	dbsprite -62, -80, $00, 0
	dbsprite -42, -72, $00, 0
	dbsprite -12, -80, $00, 0
	dbsprite   8, -72, $00, 0

.frame_4
	db 40 ; size
	dbsprite -72, -48, $00, 0
	dbsprite -72,  -8, $00, 0
	dbsprite -72,  32, $00, 0
	dbsprite -72,  72, $00, 0
	dbsprite -62, -24, $00, 0
	dbsprite -62,  16, $00, 0
	dbsprite -62,  56, $00, 0
	dbsprite -52, -40, $00, 0
	dbsprite -52,   0, $00, 0
	dbsprite -52,  40, $00, 0
	dbsprite -42, -16, $00, 0
	dbsprite -42,  24, $00, 0
	dbsprite -42,  64, $00, 0
	dbsprite -32, -32, $00, 0
	dbsprite -32,   8, $00, 0
	dbsprite -32,  48, $00, 0
	dbsprite -22, -48, $00, 0
	dbsprite -22,  -8, $00, 0
	dbsprite -22,  32, $00, 0
	dbsprite -22,  72, $00, 0
	dbsprite -12, -24, $00, 0
	dbsprite -12,  16, $00, 0
	dbsprite -12,  56, $00, 0
	dbsprite  -2, -40, $00, 0
	dbsprite  -2,   0, $00, 0
	dbsprite  -2,  40, $00, 0
	dbsprite   8, -16, $00, 0
	dbsprite   8,  24, $00, 0
	dbsprite   8,  64, $00, 0
	dbsprite  18, -32, $00, 0
	dbsprite  18,   8, $00, 0
	dbsprite  18,  48, $00, 0
	dbsprite -62, -64, $00, 0
	dbsprite -42, -56, $00, 0
	dbsprite -12, -64, $00, 0
	dbsprite   8, -56, $00, 0
	dbsprite -52, -80, $00, 0
	dbsprite -32, -72, $00, 0
	dbsprite  -2, -80, $00, 0
	dbsprite  18, -72, $00, 0

.frame_5
	db 40 ; size
	dbsprite -72, -32, $00, 0
	dbsprite -72,   8, $00, 0
	dbsprite -72,  48, $00, 0
	dbsprite -62,  -8, $00, 0
	dbsprite -62,  32, $00, 0
	dbsprite -62,  72, $00, 0
	dbsprite -52, -24, $00, 0
	dbsprite -52,  16, $00, 0
	dbsprite -52,  56, $00, 0
	dbsprite -42,   0, $00, 0
	dbsprite -42,  40, $00, 0
	dbsprite -32, -16, $00, 0
	dbsprite -32,  24, $00, 0
	dbsprite -32,  64, $00, 0
	dbsprite -22, -32, $00, 0
	dbsprite -22,   8, $00, 0
	dbsprite -22,  48, $00, 0
	dbsprite -12,  -8, $00, 0
	dbsprite -12,  32, $00, 0
	dbsprite -12,  72, $00, 0
	dbsprite  -2, -24, $00, 0
	dbsprite  -2,  16, $00, 0
	dbsprite  -2,  56, $00, 0
	dbsprite   8,   0, $00, 0
	dbsprite   8,  40, $00, 0
	dbsprite  18, -16, $00, 0
	dbsprite  18,  24, $00, 0
	dbsprite  18,  64, $00, 0
	dbsprite -62, -48, $00, 0
	dbsprite -42, -40, $00, 0
	dbsprite -12, -48, $00, 0
	dbsprite   8, -40, $00, 0
	dbsprite -52, -64, $00, 0
	dbsprite -32, -56, $00, 0
	dbsprite  -2, -64, $00, 0
	dbsprite  18, -56, $00, 0
	dbsprite -72, -72, $00, 0
	dbsprite -42, -80, $00, 0
	dbsprite -22, -72, $00, 0
	dbsprite   8, -80, $00, 0

.frame_6
	db 40 ; size
	dbsprite -72, -16, $00, 0
	dbsprite -72,  24, $00, 0
	dbsprite -72,  64, $00, 0
	dbsprite -62,   8, $00, 0
	dbsprite -62,  48, $00, 0
	dbsprite -52,  -8, $00, 0
	dbsprite -52,  32, $00, 0
	dbsprite -52,  72, $00, 0
	dbsprite -42,  16, $00, 0
	dbsprite -42,  56, $00, 0
	dbsprite -32,   0, $00, 0
	dbsprite -32,  40, $00, 0
	dbsprite -22, -16, $00, 0
	dbsprite -22,  24, $00, 0
	dbsprite -22,  64, $00, 0
	dbsprite -12,   8, $00, 0
	dbsprite -12,  48, $00, 0
	dbsprite  -2,  -8, $00, 0
	dbsprite  -2,  32, $00, 0
	dbsprite  -2,  72, $00, 0
	dbsprite   8,  16, $00, 0
	dbsprite   8,  56, $00, 0
	dbsprite  18,   0, $00, 0
	dbsprite  18,  40, $00, 0
	dbsprite -62, -32, $00, 0
	dbsprite -42, -24, $00, 0
	dbsprite -12, -32, $00, 0
	dbsprite   8, -24, $00, 0
	dbsprite -52, -48, $00, 0
	dbsprite -32, -40, $00, 0
	dbsprite  -2, -48, $00, 0
	dbsprite  18, -40, $00, 0
	dbsprite -72, -56, $00, 0
	dbsprite -42, -64, $00, 0
	dbsprite -22, -56, $00, 0
	dbsprite   8, -64, $00, 0
	dbsprite -62, -72, $00, 0
	dbsprite -32, -80, $00, 0
	dbsprite -12, -72, $00, 0
	dbsprite  18, -80, $00, 0

.frame_7
	db 34 ; size
	dbsprite -72, -48, $00, 0
	dbsprite -72,  -8, $00, 0
	dbsprite -62, -24, $00, 0
	dbsprite -62,  16, $00, 0
	dbsprite -52, -40, $00, 0
	dbsprite -52,   0, $00, 0
	dbsprite -42, -16, $00, 0
	dbsprite -42,  24, $00, 0
	dbsprite -32, -32, $00, 0
	dbsprite -32,   8, $00, 0
	dbsprite -22, -48, $00, 0
	dbsprite -22,  -8, $00, 0
	dbsprite -12, -24, $00, 0
	dbsprite -12,  16, $00, 0
	dbsprite  -2, -40, $00, 0
	dbsprite  -2,   0, $00, 0
	dbsprite   8, -16, $00, 0
	dbsprite   8,  24, $00, 0
	dbsprite  18, -32, $00, 0
	dbsprite  18,   8, $00, 0
	dbsprite  -8, -72, $00, 0
	dbsprite -48, -96, $00, 0
	dbsprite -72,  32, $00, 0
	dbsprite -72,  72, $00, 0
	dbsprite -62,  56, $00, 0
	dbsprite -52,  40, $00, 0
	dbsprite -42,  64, $00, 0
	dbsprite -32,  48, $00, 0
	dbsprite -22,  32, $00, 0
	dbsprite -22,  72, $00, 0
	dbsprite -12,  56, $00, 0
	dbsprite  -2,  40, $00, 0
	dbsprite   8,  64, $00, 0
	dbsprite  18,  48, $00, 0

.frame_8
	db 18 ; size
	dbsprite -72,  16, $00, 0
	dbsprite -72,  56, $00, 0
	dbsprite -62,  40, $00, 0
	dbsprite -52,  24, $00, 0
	dbsprite -52,  64, $00, 0
	dbsprite -42,  48, $00, 0
	dbsprite -32,  32, $00, 0
	dbsprite -32,  72, $00, 0
	dbsprite -22,  16, $00, 0
	dbsprite -22,  56, $00, 0
	dbsprite -12,  40, $00, 0
	dbsprite  -2,  24, $00, 0
	dbsprite  -2,  64, $00, 0
	dbsprite   8,  48, $00, 0
	dbsprite  18,  32, $00, 0
	dbsprite  18,  72, $00, 0
	dbsprite  -8,  -8, $00, 0
	dbsprite -48, -32, $00, 0

OAMData13::
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

.frame_0
	db 4 ; size
	dbsprite -26, -35, $00, 0
	dbsprite -26,  27, $00, 0 | OAM_XFLIP
	dbsprite  18,  27, $00, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite  18, -35, $00, 0 | OAM_YFLIP

.frame_1
	db 4 ; size
	dbsprite -25, -34, $00, 0
	dbsprite -25,  26, $00, 0 | OAM_XFLIP
	dbsprite  17,  26, $00, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite  17, -34, $00, 0 | OAM_YFLIP

.frame_2
	db 4 ; size
	dbsprite -24, -32, $01, 0
	dbsprite -24,  24, $01, 0 | OAM_XFLIP
	dbsprite  16,  24, $01, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite  16, -32, $01, 0 | OAM_YFLIP

.frame_3
	db 4 ; size
	dbsprite -23, -28, $02, 0
	dbsprite -23,  20, $02, 0 | OAM_XFLIP
	dbsprite  15,  20, $02, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite  15, -28, $02, 0 | OAM_YFLIP

.frame_4
	db 4 ; size
	dbsprite -20, -24, $03, 0
	dbsprite -20,  16, $03, 0 | OAM_XFLIP
	dbsprite  12,  16, $03, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite  12, -24, $03, 0 | OAM_YFLIP

.frame_5
	db 8 ; size
	dbsprite -17, -21, $04, 0
	dbsprite -17,  13, $04, 0 | OAM_XFLIP
	dbsprite   9,  13, $04, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite   9, -21, $04, 0 | OAM_YFLIP
	dbsprite -17, -13, $05, 0
	dbsprite -17,   5, $05, 0 | OAM_XFLIP
	dbsprite   9,   5, $05, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite   9, -13, $05, 0 | OAM_YFLIP

.frame_6
	db 12 ; size
	dbsprite -17, -24, $06, 0
	dbsprite -17,  16, $06, 0 | OAM_XFLIP
	dbsprite   9,  16, $06, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite   9, -24, $06, 0 | OAM_YFLIP
	dbsprite -17, -16, $07, 0
	dbsprite -17,   8, $07, 0 | OAM_XFLIP
	dbsprite   9,   8, $07, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite   9, -16, $07, 0 | OAM_YFLIP
	dbsprite  -9, -16, $08, 0
	dbsprite  -9,   8, $08, 0 | OAM_XFLIP
	dbsprite   1,   8, $08, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite   1, -16, $08, 0 | OAM_YFLIP

.frame_7
	db 12 ; size
	dbsprite -16, -16, $09, 0
	dbsprite -16,   8, $09, 0 | OAM_XFLIP
	dbsprite   8,   8, $09, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite   8, -16, $09, 0 | OAM_YFLIP
	dbsprite -16,  -8, $0a, 0
	dbsprite -16,   0, $0a, 0 | OAM_XFLIP
	dbsprite   8,   0, $0a, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite   8,  -8, $0a, 0 | OAM_YFLIP
	dbsprite  -8, -16, $0b, 0
	dbsprite  -8,   8, $0b, 0 | OAM_XFLIP
	dbsprite   0,   8, $0b, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite   0, -16, $0b, 0 | OAM_YFLIP

.frame_8
	db 12 ; size
	dbsprite -11, -12, $0c, 0
	dbsprite  -3, -10, $08, 0
	dbsprite -14,  -4, $0a, 0
	dbsprite -11,   4, $0c, 0 | OAM_XFLIP
	dbsprite   3,   4, $0c, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite   3, -12, $0c, 0 | OAM_YFLIP
	dbsprite -14,  -4, $0a, 0 | OAM_XFLIP
	dbsprite   6,  -4, $0a, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite   6,  -4, $0a, 0 | OAM_YFLIP
	dbsprite  -3,   2, $08, 0 | OAM_XFLIP
	dbsprite  -5,   2, $08, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite  -5, -10, $08, 0 | OAM_YFLIP

.frame_9
	db 8 ; size
	dbsprite -16,  -4, $0d, 0
	dbsprite   8,  -4, $0d, 0 | OAM_YFLIP
	dbsprite  -4, -16, $0e, 0
	dbsprite  -4,   8, $0e, 0 | OAM_XFLIP
	dbsprite  -8,  -8, $0f, 0
	dbsprite  -8,   0, $0f, 0 | OAM_XFLIP
	dbsprite   0,   0, $0f, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite   0,  -8, $0f, 0 | OAM_YFLIP

.frame_10
	db 4 ; size
	dbsprite  -8,  -8, $10, 0
	dbsprite  -8,   0, $10, 0 | OAM_XFLIP
	dbsprite   0,   0, $10, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite   0,  -8, $10, 0 | OAM_YFLIP

.frame_11
	db 6 ; size
	dbsprite  -8, -12, $11, 0
	dbsprite  -8,   4, $11, 0 | OAM_XFLIP
	dbsprite   0,   4, $11, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite   0, -12, $11, 0 | OAM_YFLIP
	dbsprite  -8,  -4, $12, 0
	dbsprite   0,  -4, $12, 0 | OAM_XFLIP | OAM_YFLIP

.frame_12
	db 9 ; size
	dbsprite  -4,  -4, $22, 1
	dbsprite -16,  -4, $13, 0
	dbsprite   8,  -4, $13, 0 | OAM_YFLIP
	dbsprite  -4, -16, $14, 0
	dbsprite  -4,   8, $14, 0 | OAM_XFLIP
	dbsprite  -8,  -8, $15, 0
	dbsprite  -8,   0, $15, 0 | OAM_XFLIP
	dbsprite   0,   0, $15, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite   0,  -8, $15, 0 | OAM_YFLIP

.frame_13
	db 9 ; size
	dbsprite  -4,  -4, $23, 1
	dbsprite -16,  -4, $16, 0
	dbsprite   8,  -4, $16, 0 | OAM_YFLIP
	dbsprite  -4, -16, $17, 0
	dbsprite  -4,   8, $17, 0 | OAM_XFLIP
	dbsprite  -8,  -8, $18, 0
	dbsprite  -8,   0, $18, 0 | OAM_XFLIP
	dbsprite   0,   0, $18, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite   0,  -8, $18, 0 | OAM_YFLIP

.frame_14
	db 8 ; size
	dbsprite -16,  -4, $19, 0
	dbsprite   8,  -4, $19, 0 | OAM_YFLIP
	dbsprite  -4, -16, $1a, 0
	dbsprite  -4,   8, $1a, 0 | OAM_XFLIP
	dbsprite  -8,  -8, $1b, 1
	dbsprite  -8,   0, $1b, 1 | OAM_XFLIP
	dbsprite   0,   0, $1b, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite   0,  -8, $1b, 1 | OAM_YFLIP

.frame_15
	db 8 ; size
	dbsprite -16,  -4, $1c, 1
	dbsprite   8,  -4, $1c, 1 | OAM_YFLIP
	dbsprite  -4, -16, $1d, 1
	dbsprite  -4,   8, $1d, 1 | OAM_XFLIP
	dbsprite  -8,  -8, $1e, 1
	dbsprite  -8,   0, $1e, 1 | OAM_XFLIP
	dbsprite   0,   0, $1e, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite   0,  -8, $1e, 1 | OAM_YFLIP

.frame_16
	db 8 ; size
	dbsprite -16,  -4, $1f, 1
	dbsprite   8,  -4, $1f, 1 | OAM_YFLIP
	dbsprite  -4, -16, $20, 1
	dbsprite  -4,   8, $20, 1 | OAM_XFLIP
	dbsprite  -8,  -8, $21, 1
	dbsprite  -8,   0, $21, 1 | OAM_XFLIP
	dbsprite   0,   0, $21, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite   0,  -8, $21, 1 | OAM_YFLIP

OAMData14::
	dw .frame_0
	dw .frame_1
	dw .frame_2
	dw .frame_3
	dw .frame_4
	dw .frame_5

.frame_0
	db 8 ; size
	dbsprite -11,  16, $00, 0
	dbsprite  -3,  13, $01, 0
	dbsprite   2,   9, $03, 0
	dbsprite   2,   1, $02, 0
	dbsprite -11, -24, $00, 0 | OAM_XFLIP
	dbsprite  -3, -21, $01, 0 | OAM_XFLIP
	dbsprite   2, -17, $03, 0 | OAM_XFLIP
	dbsprite   2,  -9, $02, 0 | OAM_XFLIP

.frame_1
	db 10 ; size
	dbsprite   2,  -9, $02, 0 | OAM_XFLIP
	dbsprite   2,   1, $02, 0
	dbsprite -11,  16, $00, 0
	dbsprite  -5,   8, $05, 0
	dbsprite  -5,  16, $06, 0
	dbsprite   3,   8, $07, 0
	dbsprite -11, -24, $00, 0 | OAM_XFLIP
	dbsprite  -5, -16, $05, 0 | OAM_XFLIP
	dbsprite  -5, -24, $06, 0 | OAM_XFLIP
	dbsprite   3, -16, $07, 0 | OAM_XFLIP

.frame_2
	db 10 ; size
	dbsprite -12,  16, $08, 0
	dbsprite  -4,   8, $09, 0
	dbsprite  -4,  16, $0a, 0
	dbsprite   4,   1, $0b, 0
	dbsprite   4,   9, $0c, 0
	dbsprite -12, -24, $08, 0 | OAM_XFLIP
	dbsprite  -4, -16, $09, 0 | OAM_XFLIP
	dbsprite  -4, -24, $0a, 0 | OAM_XFLIP
	dbsprite   4,  -9, $0b, 0 | OAM_XFLIP
	dbsprite   4, -17, $0c, 0 | OAM_XFLIP

.frame_3
	db 14 ; size
	dbsprite   0, -16, $04, 1 | OAM_XFLIP
	dbsprite   0,   8, $04, 1
	dbsprite -13,  16, $0d, 0
	dbsprite  -5,   8, $0e, 0
	dbsprite  -5,  16, $0f, 0
	dbsprite   3,   2, $10, 0
	dbsprite   3,  10, $11, 0
	dbsprite   3,  18, $12, 0
	dbsprite -13, -24, $0d, 0 | OAM_XFLIP
	dbsprite  -5, -16, $0e, 0 | OAM_XFLIP
	dbsprite  -5, -24, $0f, 0 | OAM_XFLIP
	dbsprite   3, -10, $10, 0 | OAM_XFLIP
	dbsprite   3, -18, $11, 0 | OAM_XFLIP
	dbsprite   3, -26, $12, 0 | OAM_XFLIP

.frame_4
	db 18 ; size
	dbsprite   0, -16, $16, 1 | OAM_XFLIP
	dbsprite   0,   8, $16, 1
	dbsprite   4,  -8, $1d, 0 | OAM_XFLIP
	dbsprite   4,   0, $1d, 0
	dbsprite -12,  16, $13, 0
	dbsprite  -4,   8, $14, 0
	dbsprite  -4,  16, $15, 0
	dbsprite   4,   8, $17, 0
	dbsprite   4,  16, $18, 0
	dbsprite  -4,   0, $12, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite -12,   8, $12, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite -12, -24, $13, 0 | OAM_XFLIP
	dbsprite  -4, -16, $14, 0 | OAM_XFLIP
	dbsprite  -4, -24, $15, 0 | OAM_XFLIP
	dbsprite   4, -16, $17, 0 | OAM_XFLIP
	dbsprite   4, -24, $18, 0 | OAM_XFLIP
	dbsprite  -4,  -8, $12, 0 | OAM_YFLIP
	dbsprite -12, -16, $12, 0 | OAM_YFLIP

.frame_5
	db 18 ; size
	dbsprite   0,   8, $1a, 1
	dbsprite   0, -16, $1a, 1 | OAM_XFLIP
	dbsprite  -4,  -8, $12, 0 | OAM_YFLIP
	dbsprite  -4,   0, $12, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite -12,  16, $19, 0
	dbsprite  -4,   8, $1b, 0
	dbsprite  -4,  16, $1c, 0
	dbsprite   4,   0, $1d, 0
	dbsprite   4,   8, $1e, 0
	dbsprite   4,  16, $1f, 0
	dbsprite -12,   8, $12, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite -12, -24, $19, 0 | OAM_XFLIP
	dbsprite  -4, -16, $1b, 0 | OAM_XFLIP
	dbsprite  -4, -24, $1c, 0 | OAM_XFLIP
	dbsprite   4,  -8, $1d, 0 | OAM_XFLIP
	dbsprite   4, -16, $1e, 0 | OAM_XFLIP
	dbsprite   4, -24, $1f, 0 | OAM_XFLIP
	dbsprite -12, -16, $12, 0 | OAM_YFLIP

OAMData15::
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
	db 8 ; size
	dbsprite -64,   0, $00, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite -56,   0, $00, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite -48,   0, $00, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite -40,   0, $00, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite -40,  -8, $00, 1
	dbsprite -48,  -8, $00, 1
	dbsprite -56,  -8, $00, 1
	dbsprite -64,  -8, $00, 1

.frame_1
	db 18 ; size
	dbsprite -64,   0, $00, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite -56,   0, $00, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite -48,   0, $00, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite -40,   0, $00, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite -32,   0, $00, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite -24,   0, $00, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite -16,   0, $00, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite  -8,   0, $00, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite  -8,  -8, $00, 1
	dbsprite -16,  -8, $00, 1
	dbsprite -24,  -8, $00, 1
	dbsprite -32,  -8, $00, 1
	dbsprite -40,  -8, $00, 1
	dbsprite -48,  -8, $00, 1
	dbsprite -56,  -8, $00, 1
	dbsprite -64,  -8, $00, 1
	dbsprite   0,  -8, $01, 1 | OAM_YFLIP
	dbsprite   0,   0, $01, 1 | OAM_XFLIP | OAM_YFLIP

.frame_2
	db 18 ; size
	dbsprite -64,  -8, $00, 1 | OAM_YFLIP
	dbsprite -56,  -8, $00, 1 | OAM_YFLIP
	dbsprite -48,  -8, $00, 1 | OAM_YFLIP
	dbsprite -40,  -8, $00, 1 | OAM_YFLIP
	dbsprite -32,  -8, $00, 1 | OAM_YFLIP
	dbsprite -24,  -8, $00, 1 | OAM_YFLIP
	dbsprite -16,  -8, $00, 1 | OAM_YFLIP
	dbsprite  -8,  -8, $00, 1 | OAM_YFLIP
	dbsprite  -8,   0, $00, 1 | OAM_XFLIP
	dbsprite -16,   0, $00, 1 | OAM_XFLIP
	dbsprite -24,   0, $00, 1 | OAM_XFLIP
	dbsprite -32,   0, $00, 1 | OAM_XFLIP
	dbsprite -40,   0, $00, 1 | OAM_XFLIP
	dbsprite -48,   0, $00, 1 | OAM_XFLIP
	dbsprite -56,   0, $00, 1 | OAM_XFLIP
	dbsprite -64,   0, $00, 1 | OAM_XFLIP
	dbsprite   0,   0, $01, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite   0,  -8, $01, 1 | OAM_YFLIP

.frame_3
	db 18 ; size
	dbsprite  -8,   0, $02, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite -16,   0, $02, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite -24,   0, $02, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite -32,   0, $02, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite -40,   0, $02, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite -48,   0, $02, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite -56,   0, $02, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite -64,   0, $02, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite   0,   0, $03, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite -64,  -8, $02, 0
	dbsprite -56,  -8, $02, 0
	dbsprite -48,  -8, $02, 0
	dbsprite -40,  -8, $02, 0
	dbsprite -32,  -8, $02, 0
	dbsprite -24,  -8, $02, 0
	dbsprite -16,  -8, $02, 0
	dbsprite  -8,  -8, $02, 0
	dbsprite   0,  -8, $03, 0 | OAM_YFLIP

.frame_4
	db 18 ; size
	dbsprite  -8,  -8, $02, 0 | OAM_YFLIP
	dbsprite -16,  -8, $02, 0 | OAM_YFLIP
	dbsprite -24,  -8, $02, 0 | OAM_YFLIP
	dbsprite -32,  -8, $02, 0 | OAM_YFLIP
	dbsprite -40,  -8, $02, 0 | OAM_YFLIP
	dbsprite -48,  -8, $02, 0 | OAM_YFLIP
	dbsprite -56,  -8, $02, 0 | OAM_YFLIP
	dbsprite -64,  -8, $02, 0 | OAM_YFLIP
	dbsprite   0,   0, $03, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite -64,   0, $02, 0 | OAM_XFLIP
	dbsprite -56,   0, $02, 0 | OAM_XFLIP
	dbsprite -48,   0, $02, 0 | OAM_XFLIP
	dbsprite -40,   0, $02, 0 | OAM_XFLIP
	dbsprite -32,   0, $02, 0 | OAM_XFLIP
	dbsprite -24,   0, $02, 0 | OAM_XFLIP
	dbsprite -16,   0, $02, 0 | OAM_XFLIP
	dbsprite  -8,   0, $02, 0 | OAM_XFLIP
	dbsprite   0,  -8, $03, 0 | OAM_YFLIP

.frame_5
	db 18 ; size
	dbsprite  -8,   0, $04, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite -16,   0, $04, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite -24,   0, $04, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite -32,   0, $04, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite -40,   0, $04, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite -48,   0, $04, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite -56,   0, $04, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite -64,   0, $04, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite   0,   0, $05, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite -64,  -8, $04, 0
	dbsprite -56,  -8, $04, 0
	dbsprite -48,  -8, $04, 0
	dbsprite -40,  -8, $04, 0
	dbsprite -32,  -8, $04, 0
	dbsprite -24,  -8, $04, 0
	dbsprite -16,  -8, $04, 0
	dbsprite  -8,  -8, $04, 0
	dbsprite   0,  -8, $05, 0 | OAM_YFLIP

.frame_6
	db 18 ; size
	dbsprite  -8,  -8, $04, 0 | OAM_YFLIP
	dbsprite -16,  -8, $04, 0 | OAM_YFLIP
	dbsprite -24,  -8, $04, 0 | OAM_YFLIP
	dbsprite -32,  -8, $04, 0 | OAM_YFLIP
	dbsprite -40,  -8, $04, 0 | OAM_YFLIP
	dbsprite -48,  -8, $04, 0 | OAM_YFLIP
	dbsprite -56,  -8, $04, 0 | OAM_YFLIP
	dbsprite -64,  -8, $04, 0 | OAM_YFLIP
	dbsprite   0,   0, $05, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite -64,   0, $04, 0 | OAM_XFLIP
	dbsprite -56,   0, $04, 0 | OAM_XFLIP
	dbsprite -48,   0, $04, 0 | OAM_XFLIP
	dbsprite -40,   0, $04, 0 | OAM_XFLIP
	dbsprite -32,   0, $04, 0 | OAM_XFLIP
	dbsprite -24,   0, $04, 0 | OAM_XFLIP
	dbsprite -16,   0, $04, 0 | OAM_XFLIP
	dbsprite  -8,   0, $04, 0 | OAM_XFLIP
	dbsprite   0,  -8, $05, 0 | OAM_YFLIP

.frame_7
	db 19 ; size
	dbsprite  -8,   4, $04, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite -16,   4, $04, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite -24,   4, $04, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite -32,   4, $04, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite -40,   4, $04, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite -48,   4, $04, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite -56,   4, $04, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite -64,   4, $04, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite   0,   4, $05, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite -64, -12, $04, 0
	dbsprite -56, -12, $04, 0
	dbsprite -48, -12, $04, 0
	dbsprite -40, -12, $04, 0
	dbsprite -32, -12, $04, 0
	dbsprite -24, -12, $04, 0
	dbsprite -16, -12, $04, 0
	dbsprite  -8, -12, $04, 0
	dbsprite   0, -12, $05, 0 | OAM_YFLIP
	dbsprite   0,  -4, $06, 0 | OAM_YFLIP

.frame_8
	db 19 ; size
	dbsprite  -8, -12, $04, 0 | OAM_YFLIP
	dbsprite -16, -12, $04, 0 | OAM_YFLIP
	dbsprite -24, -12, $04, 0 | OAM_YFLIP
	dbsprite -32, -12, $04, 0 | OAM_YFLIP
	dbsprite -40, -12, $04, 0 | OAM_YFLIP
	dbsprite -48, -12, $04, 0 | OAM_YFLIP
	dbsprite -56, -12, $04, 0 | OAM_YFLIP
	dbsprite -64, -12, $04, 0 | OAM_YFLIP
	dbsprite   0,   4, $05, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite -64,   4, $04, 0 | OAM_XFLIP
	dbsprite -56,   4, $04, 0 | OAM_XFLIP
	dbsprite -48,   4, $04, 0 | OAM_XFLIP
	dbsprite -40,   4, $04, 0 | OAM_XFLIP
	dbsprite -32,   4, $04, 0 | OAM_XFLIP
	dbsprite -24,   4, $04, 0 | OAM_XFLIP
	dbsprite -16,   4, $04, 0 | OAM_XFLIP
	dbsprite  -8,   4, $04, 0 | OAM_XFLIP
	dbsprite   0, -12, $05, 0 | OAM_YFLIP
	dbsprite   0,  -4, $06, 0 | OAM_YFLIP

.frame_9
	db 20 ; size
	dbsprite  -8,   8, $07, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite -16,   8, $07, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite -24,   8, $07, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite -32,   8, $07, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite -40,   8, $07, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite -48,   8, $07, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite -56,   8, $07, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite -64,   8, $07, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite   0,   8, $08, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite   0,   0, $09, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite -64, -16, $07, 0
	dbsprite -56, -16, $07, 0
	dbsprite -48, -16, $07, 0
	dbsprite -40, -16, $07, 0
	dbsprite -32, -16, $07, 0
	dbsprite -24, -16, $07, 0
	dbsprite -16, -16, $07, 0
	dbsprite  -8, -16, $07, 0
	dbsprite   0, -16, $08, 0 | OAM_YFLIP
	dbsprite   0,  -8, $09, 0 | OAM_YFLIP

.frame_10
	db 20 ; size
	dbsprite -64,   8, $07, 0 | OAM_XFLIP
	dbsprite -56,   8, $07, 0 | OAM_XFLIP
	dbsprite -48,   8, $07, 0 | OAM_XFLIP
	dbsprite -40,   8, $07, 0 | OAM_XFLIP
	dbsprite -32,   8, $07, 0 | OAM_XFLIP
	dbsprite -24,   8, $07, 0 | OAM_XFLIP
	dbsprite -16,   8, $07, 0 | OAM_XFLIP
	dbsprite  -8,   8, $07, 0 | OAM_XFLIP
	dbsprite   0,   8, $08, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite   0,   0, $09, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite  -8, -16, $07, 0 | OAM_YFLIP
	dbsprite -16, -16, $07, 0 | OAM_YFLIP
	dbsprite -24, -16, $07, 0 | OAM_YFLIP
	dbsprite -32, -16, $07, 0 | OAM_YFLIP
	dbsprite -40, -16, $07, 0 | OAM_YFLIP
	dbsprite -48, -16, $07, 0 | OAM_YFLIP
	dbsprite -56, -16, $07, 0 | OAM_YFLIP
	dbsprite -64, -16, $07, 0 | OAM_YFLIP
	dbsprite   0, -16, $08, 0 | OAM_YFLIP
	dbsprite   0,  -8, $09, 0 | OAM_YFLIP

OAMData16::
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

.frame_0
	db 8 ; size
	dbsprite -64, -12, $05, 0 | OAM_YFLIP
	dbsprite -64,  -4, $06, 0 | OAM_YFLIP
	dbsprite -64,   4, $07, 0 | OAM_YFLIP
	dbsprite -56, -12, $02, 0 | OAM_YFLIP
	dbsprite -56,  -4, $03, 0 | OAM_YFLIP
	dbsprite -56,   4, $04, 0 | OAM_YFLIP
	dbsprite -48,  -8, $00, 0 | OAM_YFLIP
	dbsprite -48,   0, $01, 0 | OAM_YFLIP

.frame_1
	db 11 ; size
	dbsprite -56,  -4, $08, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite -64,  -4, $08, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite -48,  -4, $08, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite -40,   4, $05, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite -40,  -4, $06, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite -40, -12, $07, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite -32,   4, $02, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite -32,  -4, $03, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite -32, -12, $04, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite -24,   0, $00, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite -24,  -8, $01, 0 | OAM_XFLIP | OAM_YFLIP

.frame_2
	db 14 ; size
	dbsprite -32,  -4, $08, 0 | OAM_YFLIP
	dbsprite -40,  -4, $08, 0 | OAM_YFLIP
	dbsprite -48,  -4, $08, 0 | OAM_YFLIP
	dbsprite -56,  -4, $08, 0 | OAM_YFLIP
	dbsprite -24,  -4, $08, 0 | OAM_YFLIP
	dbsprite -16, -12, $05, 0 | OAM_YFLIP
	dbsprite -16,  -4, $06, 0 | OAM_YFLIP
	dbsprite -16,   4, $07, 0 | OAM_YFLIP
	dbsprite  -8, -12, $02, 0 | OAM_YFLIP
	dbsprite  -8,  -4, $03, 0 | OAM_YFLIP
	dbsprite  -8,   4, $04, 0 | OAM_YFLIP
	dbsprite   0,  -8, $00, 0 | OAM_YFLIP
	dbsprite   0,   0, $01, 0 | OAM_YFLIP
	dbsprite -64,  -4, $09, 1 | OAM_XFLIP | OAM_YFLIP

.frame_3
	db 11 ; size
	dbsprite   0,  -8, $0a, 0 | OAM_YFLIP
	dbsprite   0,   0, $0b, 0 | OAM_YFLIP
	dbsprite  -8,  -8, $0c, 0 | OAM_YFLIP
	dbsprite  -8,   0, $0d, 0 | OAM_YFLIP
	dbsprite -16,  -4, $08, 0
	dbsprite -24,  -4, $08, 0
	dbsprite -32,  -4, $08, 0
	dbsprite -40,  -4, $08, 0
	dbsprite -48,  -4, $08, 0
	dbsprite -56,  -4, $09, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite -64,  -4, $09, 1

.frame_4
	db 11 ; size
	dbsprite   0,   0, $0a, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite   0,  -8, $0b, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite  -8,   0, $0c, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite  -8,  -8, $0d, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite -16,  -4, $08, 0
	dbsprite -24,  -4, $08, 0
	dbsprite -48,  -4, $09, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite -56,  -4, $09, 1
	dbsprite -32,  -4, $08, 0
	dbsprite -40,  -4, $08, 0
	dbsprite -64,  -4, $08, 0

.frame_5
	db 10 ; size
	dbsprite   0,  -8, $0a, 0 | OAM_YFLIP
	dbsprite   0,   0, $0b, 0 | OAM_YFLIP
	dbsprite  -8,  -8, $0c, 0 | OAM_YFLIP
	dbsprite  -8,   0, $0d, 0 | OAM_YFLIP
	dbsprite -40,  -4, $09, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite -48,  -4, $09, 1
	dbsprite -16,  -4, $08, 0
	dbsprite -24,  -4, $08, 0
	dbsprite -32,  -4, $08, 0
	dbsprite -56,  -4, $08, 0

.frame_6
	db 9 ; size
	dbsprite   0,   0, $0a, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite   0,  -8, $0b, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite  -8,   0, $0c, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite  -8,  -8, $0d, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite -16,  -4, $08, 0
	dbsprite -24,  -4, $08, 0
	dbsprite -32,  -4, $09, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite -40,  -4, $09, 1
	dbsprite -48,  -4, $08, 0

.frame_7
	db 13 ; size
	dbsprite -24,  -4, $09, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite -32,  -4, $09, 1
	dbsprite -16,  -4, $08, 0
	dbsprite -40,  -4, $08, 0
	dbsprite   8, -12, $0e, 0 | OAM_YFLIP
	dbsprite   8,  -4, $0f, 0 | OAM_YFLIP
	dbsprite   8,   4, $10, 0 | OAM_YFLIP
	dbsprite   0, -12, $11, 0 | OAM_YFLIP
	dbsprite   0,  -4, $12, 0 | OAM_YFLIP
	dbsprite   0,   4, $13, 0 | OAM_YFLIP
	dbsprite  -8, -12, $14, 0 | OAM_YFLIP
	dbsprite  -8,  -4, $15, 0 | OAM_YFLIP
	dbsprite  -8,   4, $16, 0 | OAM_YFLIP

.frame_8
	db 12 ; size
	dbsprite -32,  -4, $08, 0
	dbsprite -16,  -4, $09, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite -24,  -4, $09, 1
	dbsprite   8,   4, $0e, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite   8,  -4, $0f, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite   8, -12, $10, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite   0,   4, $11, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite   0,  -4, $12, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite   0, -12, $13, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite  -8,   4, $14, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite  -8,  -4, $15, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite  -8, -12, $16, 0 | OAM_XFLIP | OAM_YFLIP

.frame_9
	db 11 ; size
	dbsprite -24,  -4, $08, 0
	dbsprite -16,  -4, $09, 1
	dbsprite   8, -12, $0e, 0 | OAM_YFLIP
	dbsprite   8,  -4, $0f, 0 | OAM_YFLIP
	dbsprite   8,   4, $10, 0 | OAM_YFLIP
	dbsprite   0, -12, $11, 0 | OAM_YFLIP
	dbsprite   0,  -4, $12, 0 | OAM_YFLIP
	dbsprite   0,   4, $13, 0 | OAM_YFLIP
	dbsprite  -8, -12, $14, 0 | OAM_YFLIP
	dbsprite  -8,  -4, $15, 0 | OAM_YFLIP
	dbsprite  -8,   4, $16, 0 | OAM_YFLIP

.frame_10
	db 10 ; size
	dbsprite -16,  -4, $08, 0
	dbsprite   8,   4, $0e, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite   8,  -4, $0f, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite   8, -12, $10, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite   0,   4, $11, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite   0,  -4, $12, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite   0, -12, $13, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite  -8,   4, $14, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite  -8,  -4, $15, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite  -8, -12, $16, 0 | OAM_XFLIP | OAM_YFLIP

.frame_11
	db 14 ; size
	dbsprite -16,  -8, $23, 0 | OAM_YFLIP
	dbsprite -16,   0, $24, 0 | OAM_YFLIP
	dbsprite  -8, -16, $1f, 0 | OAM_YFLIP
	dbsprite  -8,  -8, $20, 0 | OAM_YFLIP
	dbsprite  -8,   0, $21, 0 | OAM_YFLIP
	dbsprite  -8,   8, $22, 0 | OAM_YFLIP
	dbsprite   0, -16, $1b, 0 | OAM_YFLIP
	dbsprite   0,  -8, $1c, 0 | OAM_YFLIP
	dbsprite   0,   0, $1d, 0 | OAM_YFLIP
	dbsprite   0,   8, $1e, 0 | OAM_YFLIP
	dbsprite   8, -16, $17, 0 | OAM_YFLIP
	dbsprite   8,  -8, $18, 0 | OAM_YFLIP
	dbsprite   8,   0, $19, 0 | OAM_YFLIP
	dbsprite   8,   8, $1a, 0 | OAM_YFLIP

.frame_12
	db 14 ; size
	dbsprite  12,   0, $23, 0 | OAM_XFLIP
	dbsprite  12,  -8, $24, 0 | OAM_XFLIP
	dbsprite   4,   8, $1f, 0 | OAM_XFLIP
	dbsprite   4,   0, $20, 0 | OAM_XFLIP
	dbsprite   4,  -8, $21, 0 | OAM_XFLIP
	dbsprite   4, -16, $22, 0 | OAM_XFLIP
	dbsprite  -4,   8, $1b, 0 | OAM_XFLIP
	dbsprite  -4,   0, $1c, 0 | OAM_XFLIP
	dbsprite  -4,  -8, $1d, 0 | OAM_XFLIP
	dbsprite  -4, -16, $1e, 0 | OAM_XFLIP
	dbsprite -12,   8, $17, 0 | OAM_XFLIP
	dbsprite -12,   0, $18, 0 | OAM_XFLIP
	dbsprite -12,  -8, $19, 0 | OAM_XFLIP
	dbsprite -12, -16, $1a, 0 | OAM_XFLIP

OAMData1E::
	dw .frame_0
	dw .frame_1
	dw .frame_2
	dw .frame_3

.frame_0
	db 12 ; size
	dbsprite -16,   8, $00, 0
	dbsprite  -8,  -8, $01, 0
	dbsprite  -8,   0, $02, 0
	dbsprite  -8,   8, $03, 0
	dbsprite   0, -16, $04, 0
	dbsprite   0,  -8, $05, 0
	dbsprite   0,   0, $06, 0
	dbsprite   0,   8, $07, 0
	dbsprite   8, -16, $08, 0
	dbsprite   8,  -8, $09, 0
	dbsprite   8,   0, $0a, 0
	dbsprite   8,   8, $0b, 0

.frame_1
	db 21 ; size
	dbsprite   8,   8, $0b, 0
	dbsprite   8,   0, $0a, 0
	dbsprite   8,  -8, $09, 0
	dbsprite   8, -16, $08, 0
	dbsprite   0, -16, $04, 0
	dbsprite  -8,  -8, $01, 0
	dbsprite -16,   8, $00, 0
	dbsprite  -8,   0, $02, 0
	dbsprite  -8,   8, $03, 0
	dbsprite   0,  -8, $05, 0
	dbsprite   0,   0, $06, 0
	dbsprite   0,   8, $07, 0
	dbsprite  -8,  -8, $0c, 1
	dbsprite   0, -16, $0d, 1
	dbsprite   8, -16, $0e, 1
	dbsprite   8,  -8, $0f, 1
	dbsprite   8,   0, $10, 1
	dbsprite   8,   8, $11, 1
	dbsprite  16, -14, $1f, 1
	dbsprite  16,  -6, $20, 1
	dbsprite  16,   2, $21, 1

.frame_2
	db 16 ; size
	dbsprite  -4, -24, $12, 0
	dbsprite  -8, -16, $13, 0
	dbsprite  -8,  -8, $14, 0
	dbsprite  -8,   0, $15, 0
	dbsprite  -8,   8, $16, 0
	dbsprite   0, -16, $17, 0
	dbsprite   0,  -8, $18, 0
	dbsprite   0,   0, $19, 0
	dbsprite   0,   8, $1a, 0
	dbsprite   8, -16, $1b, 0
	dbsprite   8,  -8, $1c, 0
	dbsprite   8,   0, $1d, 0
	dbsprite   8,   8, $1e, 0
	dbsprite  16, -16, $1f, 0
	dbsprite  16,  -8, $20, 0
	dbsprite  16,   0, $21, 0

.frame_3
	db 12 ; size
	dbsprite -16,  -8, $00, 0 | OAM_XFLIP
	dbsprite  -8,   8, $01, 0 | OAM_XFLIP
	dbsprite  -8,   0, $02, 0 | OAM_XFLIP
	dbsprite  -8,  -8, $03, 0 | OAM_XFLIP
	dbsprite   0,  16, $04, 0 | OAM_XFLIP
	dbsprite   0,   8, $05, 0 | OAM_XFLIP
	dbsprite   0,   0, $06, 0 | OAM_XFLIP
	dbsprite   0,  -8, $07, 0 | OAM_XFLIP
	dbsprite   8,  16, $08, 0 | OAM_XFLIP
	dbsprite   8,   8, $09, 0 | OAM_XFLIP
	dbsprite   8,   0, $0a, 0 | OAM_XFLIP
	dbsprite   8,  -8, $0b, 0 | OAM_XFLIP

OAMData6B::
	dw .frame_0
	dw .frame_1
	dw .frame_2
	dw .frame_3

.frame_0
	db 4 ; size
	dbsprite  -2,   7, $14, 4
	dbsprite  -2,  15, $15, 4
	dbsprite   6,   7, $16, 4
	dbsprite   6,  15, $17, 4

.frame_1
	db 4 ; size
	dbsprite   5,   4, $18, 4
	dbsprite   5,  12, $19, 4
	dbsprite  -3,   4, $0d, 4 | OAM_XFLIP
	dbsprite  -3,  12, $0c, 4 | OAM_XFLIP

.frame_2
	db 4 ; size
	dbsprite   5,   2, $19, 4
	dbsprite  -3,  -6, $0d, 4 | OAM_XFLIP
	dbsprite  -3,   2, $0c, 4 | OAM_XFLIP
	dbsprite   5,  -6, $1a, 4

.frame_3
	db 4 ; size
	dbsprite   0, -16, $00, 4
	dbsprite   8, -16, $01, 4
	dbsprite   0,  -8, $00, 4 | OAM_XFLIP
	dbsprite   8,  -8, $01, 4 | OAM_XFLIP
