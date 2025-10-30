OAMData17::
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
	db 10 ; size
	dbsprite -24,  16, $02, 0
	dbsprite -24,  24, $03, 1
	dbsprite -32,  16, $00, 2
	dbsprite -32,  24, $01, 0
	dbsprite -16,  22, $15, 0
	dbsprite -28,  32, $16, 0
	dbsprite -25,   8, $14, 0
	dbsprite -33,   8, $14, 0 | OAM_YFLIP
	dbsprite -32,  32, $0e, 0
	dbsprite -24,  32, $0f, 0

.frame_1
	db 10 ; size
	dbsprite -24,   8, $04, 2
	dbsprite -24,  16, $05, 0
	dbsprite -16,   8, $06, 0
	dbsprite -16,  16, $07, 1
	dbsprite -21,  24, $16, 0
	dbsprite -24,  24, $0c, 0
	dbsprite -16,  24, $0d, 0
	dbsprite -15,   0, $14, 0
	dbsprite -32,  16, $17, 0
	dbsprite  -8,   8, $17, 0 | OAM_XFLIP | OAM_YFLIP

.frame_2
	db 10 ; size
	dbsprite  -8,   8, $00, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite  -8,   0, $01, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite -16,   8, $02, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite -16,   0, $03, 2 | OAM_XFLIP | OAM_YFLIP
	dbsprite -13,  -8, $16, 0 | OAM_XFLIP
	dbsprite -24,   5, $15, 0 | OAM_YFLIP
	dbsprite  -7,  16, $14, 0 | OAM_XFLIP
	dbsprite -15,  16, $14, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite -16,  16, $0e, 0
	dbsprite  -8,  16, $0f, 0

.frame_3
	db 15 ; size
	dbsprite -24, -16, $12, 0
	dbsprite -24,  -8, $13, 1
	dbsprite -24,   0, $0d, 0
	dbsprite  16, -16, $00, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite  16, -24, $01, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite   8, -16, $02, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite   8, -24, $03, 2 | OAM_XFLIP | OAM_YFLIP
	dbsprite  11, -32, $16, 0 | OAM_XFLIP
	dbsprite   0, -19, $15, 0 | OAM_YFLIP
	dbsprite  17,  -8, $14, 0 | OAM_XFLIP
	dbsprite   9,  -8, $14, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite   8,  -8, $0e, 0
	dbsprite  16,  -8, $0f, 0
	dbsprite -32, -16, $10, 2
	dbsprite -32,  -8, $11, 0

.frame_4
	db 26 ; size
	dbsprite -24, -11, $0e, 0
	dbsprite -16,  -8, $0f, 0
	dbsprite -24, -24, $08, 2
	dbsprite -24, -16, $09, 0
	dbsprite -16, -24, $0a, 0
	dbsprite -16, -16, $0b, 1
	dbsprite  24, -32, $02, 0
	dbsprite  24, -24, $03, 2
	dbsprite  16, -32, $00, 1
	dbsprite  16, -24, $01, 0
	dbsprite  32, -26, $15, 0
	dbsprite  20, -16, $16, 0
	dbsprite  23, -40, $14, 0
	dbsprite  15, -40, $14, 0 | OAM_YFLIP
	dbsprite  16, -16, $0e, 0
	dbsprite  24, -16, $0f, 0
	dbsprite  -8,  24, $02, 0
	dbsprite  -8,  32, $03, 1
	dbsprite -16,  24, $00, 2
	dbsprite -16,  32, $01, 0
	dbsprite   0,  30, $15, 0
	dbsprite -12,  40, $16, 0
	dbsprite  -9,  16, $14, 0
	dbsprite -17,  16, $14, 0 | OAM_YFLIP
	dbsprite -16,  40, $0e, 0
	dbsprite  -8,  40, $0f, 0

.frame_5
	db 16 ; size
	dbsprite -18, -18, $0c, 0
	dbsprite -10, -18, $0d, 0
	dbsprite  -8, -24, $10, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite  -8, -32, $11, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite -16, -24, $12, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite -16, -32, $13, 2 | OAM_XFLIP | OAM_YFLIP
	dbsprite  -8,  16, $04, 2
	dbsprite  -8,  24, $05, 0
	dbsprite   0,  16, $06, 0
	dbsprite   0,  24, $07, 1
	dbsprite  -5,  32, $16, 0
	dbsprite  -8,  32, $0c, 0
	dbsprite   0,  32, $0d, 0
	dbsprite   1,   8, $14, 0
	dbsprite -16,  24, $17, 0
	dbsprite   8,  16, $17, 0 | OAM_XFLIP | OAM_YFLIP

.frame_6
	db 21 ; size
	dbsprite -10, -28, $0e, 0
	dbsprite  -2, -26, $0f, 0
	dbsprite -24,   8, $12, 0
	dbsprite -24,  16, $13, 1
	dbsprite -24,  22, $0f, 0
	dbsprite   0, -32, $08, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite  -8, -32, $0a, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite   8,  16, $00, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite   8,   8, $01, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite   0,  16, $02, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite   0,   8, $03, 2 | OAM_XFLIP | OAM_YFLIP
	dbsprite   3,   0, $16, 0 | OAM_XFLIP
	dbsprite  -8,  13, $15, 0 | OAM_YFLIP
	dbsprite   9,  24, $14, 0 | OAM_XFLIP
	dbsprite   1,  24, $14, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite   0,  24, $0e, 0
	dbsprite   8,  24, $0f, 0
	dbsprite  -8, -40, $08, 2
	dbsprite   0, -40, $0a, 0
	dbsprite -32,   8, $10, 2
	dbsprite -32,  16, $11, 0

.frame_7
	db 16 ; size
	dbsprite -24,  14, $0e, 0
	dbsprite -16,  14, $0f, 0
	dbsprite -24,   0, $08, 2
	dbsprite -24,   8, $09, 0
	dbsprite -16,   0, $0a, 0
	dbsprite -16,   8, $0b, 1
	dbsprite  16,   0, $02, 0
	dbsprite  16,   8, $03, 1
	dbsprite   8,   0, $00, 2
	dbsprite   8,   8, $01, 0
	dbsprite  24,   6, $15, 0
	dbsprite  12,  16, $16, 0
	dbsprite  15,  -8, $14, 0
	dbsprite   7,  -8, $14, 0 | OAM_YFLIP
	dbsprite   8,  16, $0e, 0
	dbsprite  16,  16, $0f, 0

.frame_8
	db 16 ; size
	dbsprite -18,   4, $0c, 0
	dbsprite -10,   6, $0d, 0
	dbsprite  -8,   0, $10, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite  -8,  -8, $11, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite -16,   0, $12, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite -16,  -8, $13, 2 | OAM_XFLIP | OAM_YFLIP
	dbsprite  16,  -8, $04, 2
	dbsprite  16,   0, $05, 0
	dbsprite  24,  -8, $06, 0
	dbsprite  24,   0, $07, 1
	dbsprite  19,   8, $16, 0
	dbsprite  16,   8, $0c, 0
	dbsprite  24,   8, $0d, 0
	dbsprite  25, -16, $14, 0
	dbsprite   8,   0, $17, 0
	dbsprite  32,  -8, $17, 0 | OAM_XFLIP | OAM_YFLIP

.frame_9
	db 6 ; size
	dbsprite -10,  -4, $0e, 0
	dbsprite  -2,  -2, $0f, 0
	dbsprite   0,  -8, $08, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite   0, -16, $09, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite  -8,  -8, $0a, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite  -8, -16, $0b, 2 | OAM_XFLIP | OAM_YFLIP

.frame_10
	db 6 ; size
	dbsprite   0, -24, $10, 2
	dbsprite   0, -16, $11, 0
	dbsprite   8, -24, $12, 0
	dbsprite   8, -16, $13, 1
	dbsprite  -2, -12, $0c, 0
	dbsprite   7, -11, $0d, 0

.frame_11
	db 6 ; size
	dbsprite   7, -19, $0e, 0
	dbsprite  15, -17, $0f, 0
	dbsprite   8, -32, $08, 2
	dbsprite   8, -24, $09, 0
	dbsprite  16, -32, $0a, 0
	dbsprite  16, -24, $0b, 1

.frame_12
	db 5 ; size
	dbsprite  14, -28, $0e, 0
	dbsprite  16, -32, $12, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite  16, -40, $13, 2 | OAM_XFLIP | OAM_YFLIP
	dbsprite  24, -32, $10, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite  24, -40, $11, 0 | OAM_XFLIP | OAM_YFLIP

OAMData18::
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
	dbsprite -18,   0, $00, 0
	dbsprite -16,   8, $01, 0
	dbsprite -10,  -8, $02, 0
	dbsprite -10,   0, $03, 0
	dbsprite  -8,   8, $04, 0
	dbsprite   0, -16, $05, 0
	dbsprite  -2,  -8, $06, 0
	dbsprite  -2,   0, $07, 0
	dbsprite   8, -24, $08, 0
	dbsprite   8, -16, $09, 0
	dbsprite   8,  -8, $0a, 0
	dbsprite  16, -32, $0b, 0
	dbsprite  16, -24, $0c, 0
	dbsprite  16, -16, $0d, 0

.frame_1
	db 14 ; size
	dbsprite -18,  -8, $00, 0 | OAM_XFLIP
	dbsprite -16, -16, $01, 0 | OAM_XFLIP
	dbsprite -10,   0, $02, 0 | OAM_XFLIP
	dbsprite -10,  -8, $03, 0 | OAM_XFLIP
	dbsprite  -8, -16, $04, 0 | OAM_XFLIP
	dbsprite   0,   8, $05, 0 | OAM_XFLIP
	dbsprite  -2,   0, $06, 0 | OAM_XFLIP
	dbsprite  -2,  -8, $07, 0 | OAM_XFLIP
	dbsprite   8,  16, $08, 0 | OAM_XFLIP
	dbsprite   8,   8, $09, 0 | OAM_XFLIP
	dbsprite   8,   0, $0a, 0 | OAM_XFLIP
	dbsprite  16,  24, $0b, 0 | OAM_XFLIP
	dbsprite  16,  16, $0c, 0 | OAM_XFLIP
	dbsprite  16,   8, $0d, 0 | OAM_XFLIP

.frame_2
	db 16 ; size
	dbsprite -16, -16, $13, 1
	dbsprite -16,   8, $13, 1 | OAM_XFLIP
	dbsprite   8,   8, $13, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite   8, -16, $13, 1 | OAM_YFLIP
	dbsprite -16,  -8, $14, 1
	dbsprite -16,   0, $14, 1 | OAM_XFLIP
	dbsprite   8,   0, $14, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite   8,  -8, $14, 1 | OAM_YFLIP
	dbsprite  -8, -16, $15, 1
	dbsprite  -8,   8, $15, 1 | OAM_XFLIP
	dbsprite   0,   8, $15, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite   0, -16, $15, 1 | OAM_YFLIP
	dbsprite  -8,  -8, $16, 1
	dbsprite  -8,   0, $16, 1 | OAM_XFLIP
	dbsprite   0,   0, $16, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite   0,  -8, $16, 1 | OAM_YFLIP

.frame_3
	db 20 ; size
	dbsprite -26, -18, $0e, 1
	dbsprite -18, -20, $0f, 1
	dbsprite -18, -12, $10, 1
	dbsprite -10, -18, $11, 1
	dbsprite -10, -10, $12, 1
	dbsprite -26,  10, $0e, 1 | OAM_XFLIP
	dbsprite -18,  12, $0f, 1 | OAM_XFLIP
	dbsprite -18,   4, $10, 1 | OAM_XFLIP
	dbsprite -10,  10, $11, 1 | OAM_XFLIP
	dbsprite -10,   2, $12, 1 | OAM_XFLIP
	dbsprite  18, -18, $0e, 1 | OAM_YFLIP
	dbsprite  10, -20, $0f, 1 | OAM_YFLIP
	dbsprite  10, -12, $10, 1 | OAM_YFLIP
	dbsprite   2, -18, $11, 1 | OAM_YFLIP
	dbsprite   2, -10, $12, 1 | OAM_YFLIP
	dbsprite  18,  10, $0e, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite  10,  12, $0f, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite  10,   4, $10, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite   2,  10, $11, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite   2,   2, $12, 1 | OAM_XFLIP | OAM_YFLIP

.frame_4
	db 1 ; size
	dbsprite  -5,  -4, $17, 2

.frame_5
	db 8 ; size
	dbsprite -13,   4, $18, 2
	dbsprite  -1,   0, $18, 2
	dbsprite -17,  -8, $18, 2 | OAM_XFLIP
	dbsprite  -5, -12, $18, 2 | OAM_XFLIP
	dbsprite   3, -12, $1a, 2 | OAM_XFLIP
	dbsprite   7,   0, $1a, 2 | OAM_XFLIP
	dbsprite  -9,  -8, $1a, 2
	dbsprite  -5,   4, $1a, 2

.frame_6
	db 8 ; size
	dbsprite -20,  -9, $18, 2
	dbsprite   2,   1, $18, 2 | OAM_XFLIP
	dbsprite -14,   7, $19, 2
	dbsprite  -4, -14, $19, 2
	dbsprite   4, -15, $1a, 2
	dbsprite  10,   1, $1a, 2
	dbsprite -12,  -9, $1a, 2 | OAM_XFLIP
	dbsprite  -6,   7, $1a, 2 | OAM_XFLIP

.frame_7
	db 8 ; size
	dbsprite -16,  13, $18, 2
	dbsprite  -2, -21, $18, 2 | OAM_XFLIP
	dbsprite -26, -11, $19, 2 | OAM_XFLIP
	dbsprite   8,   3, $19, 2
	dbsprite -18, -10, $1a, 2
	dbsprite  -8,  13, $1a, 2
	dbsprite   6, -21, $1a, 2 | OAM_XFLIP
	dbsprite  16,   2, $1a, 2 | OAM_XFLIP

.frame_8
	db 8 ; size
	dbsprite  -2, -21, $18, 2
	dbsprite   8,   3, $18, 2
	dbsprite -26, -11, $18, 2 | OAM_XFLIP
	dbsprite -16,  13, $18, 2 | OAM_XFLIP
	dbsprite   6, -21, $1a, 2
	dbsprite  16,   3, $1a, 2
	dbsprite -18, -11, $1a, 2 | OAM_XFLIP
	dbsprite  -8,  13, $1a, 2 | OAM_XFLIP

OAMData19::
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
	db 2 ; size
	dbsprite  -8,  32, $03, 0
	dbsprite   0,  32, $06, 0

.frame_1
	db 4 ; size
	dbsprite  -8,  32, $02, 0
	dbsprite  -8,  40, $03, 0
	dbsprite   0,  32, $05, 0
	dbsprite   0,  40, $06, 0

.frame_2
	db 6 ; size
	dbsprite  -8,  32, $01, 0
	dbsprite  -8,  40, $02, 0
	dbsprite  -8,  48, $03, 0
	dbsprite   0,  32, $04, 0
	dbsprite   0,  40, $05, 0
	dbsprite   0,  48, $06, 0

.frame_3
	db 7 ; size
	dbsprite  -8,  40, $01, 0
	dbsprite  -8,  48, $02, 0
	dbsprite  -8,  56, $03, 0
	dbsprite   0,  40, $04, 0
	dbsprite   0,  48, $05, 0
	dbsprite   0,  56, $06, 0
	dbsprite  -4,  32, $00, 0

.frame_4
	db 9 ; size
	dbsprite  -8,  56, $01, 0
	dbsprite  -8,  64, $02, 0
	dbsprite  -8,  72, $03, 0
	dbsprite   0,  56, $04, 0
	dbsprite   0,  64, $05, 0
	dbsprite   0,  72, $06, 0
	dbsprite  -4,  48, $00, 0
	dbsprite  -4,  40, $00, 0
	dbsprite  -4,  32, $00, 0

.frame_5
	db 11 ; size
	dbsprite  -8,  72, $01, 0
	dbsprite  -8,  80, $02, 0
	dbsprite  -8,  88, $03, 0
	dbsprite   0,  72, $04, 0
	dbsprite   0,  80, $05, 0
	dbsprite   0,  88, $06, 0
	dbsprite  -4,  64, $00, 0
	dbsprite  -4,  56, $00, 0
	dbsprite  -4,  48, $00, 0
	dbsprite  -4,  40, $00, 0
	dbsprite  -4,  32, $00, 0

.frame_6
	db 13 ; size
	dbsprite  -8,  88, $01, 0
	dbsprite  -8,  96, $02, 0
	dbsprite  -8, 104, $03, 0
	dbsprite   0,  88, $04, 0
	dbsprite   0,  96, $05, 0
	dbsprite   0, 104, $06, 0
	dbsprite  -4,  80, $00, 0
	dbsprite  -4,  72, $00, 0
	dbsprite  -4,  64, $00, 0
	dbsprite  -4,  56, $00, 0
	dbsprite  -4,  48, $00, 0
	dbsprite  -4,  40, $00, 0
	dbsprite  -4,  32, $00, 0

.frame_7
	db 13 ; size
	dbsprite  -8, 102, $01, 0
	dbsprite  -8, 110, $02, 0
	dbsprite  -8, 118, $03, 0
	dbsprite   0, 102, $04, 0
	dbsprite   0, 110, $05, 0
	dbsprite   0, 118, $06, 0
	dbsprite  -4,  32, $00, 0
	dbsprite  -4,  42, $07, 0
	dbsprite  -4,  52, $07, 0
	dbsprite  -4,  62, $07, 0
	dbsprite  -4,  72, $07, 0
	dbsprite  -4,  82, $07, 0
	dbsprite  -4,  92, $07, 0

.frame_8
	db 9 ; size
	dbsprite  -8, 120, $01, 0
	dbsprite   0, 120, $04, 0
	dbsprite  -4,  32, $00, 0
	dbsprite  -4,  44, $07, 0
	dbsprite  -4,  56, $07, 0
	dbsprite  -4,  68, $07, 0
	dbsprite  -4,  80, $07, 0
	dbsprite  -4,  92, $07, 0
	dbsprite  -4, 104, $07, 0

.frame_9
	db 7 ; size
	dbsprite  -4,  32, $00, 0
	dbsprite  -4,  46, $07, 0
	dbsprite  -4,  60, $07, 0
	dbsprite  -4,  74, $07, 0
	dbsprite  -4,  88, $07, 0
	dbsprite  -4, 102, $07, 0
	dbsprite  -4, 116, $07, 0

.frame_10
	db 6 ; size
	dbsprite  -4,  32, $00, 0
	dbsprite  -4,  48, $07, 0
	dbsprite  -4,  64, $07, 0
	dbsprite  -4,  80, $07, 0
	dbsprite  -4,  96, $07, 0
	dbsprite  -4, 112, $07, 0

.frame_11
	db 5 ; size
	dbsprite  -4,  32, $00, 0
	dbsprite  -4,  52, $07, 0
	dbsprite  -4,  72, $07, 0
	dbsprite  -4,  92, $07, 0
	dbsprite  -4, 112, $07, 0

OAMData1A::
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
	db 5 ; size
	dbsprite   0,  -6, $00, 0
	dbsprite  -8,  -6, $01, 0
	dbsprite  -8,   2, $02, 0
	dbsprite -16,   2, $03, 0
	dbsprite -16,  10, $04, 1

.frame_1
	db 13 ; size
	dbsprite  16, -22, $00, 0
	dbsprite   8, -22, $01, 0
	dbsprite   8, -14, $02, 0
	dbsprite   0, -14, $03, 0
	dbsprite   0,  -6, $04, 1
	dbsprite  -3, -11, $05, 0
	dbsprite -11, -11, $06, 0
	dbsprite -11,  -3, $07, 0
	dbsprite -19,  -3, $08, 0
	dbsprite   3,  -5, $09, 0
	dbsprite   3,   3, $0a, 0
	dbsprite  -5,   3, $0b, 0
	dbsprite  -5,  11, $0c, 0

.frame_2
	db 11 ; size
	dbsprite  24, -30, $02, 1
	dbsprite  16, -30, $03, 1
	dbsprite  16, -22, $04, 2
	dbsprite  -2, -10, $05, 0
	dbsprite -10, -10, $06, 0
	dbsprite -10,  -2, $07, 0
	dbsprite -18,  -2, $08, 0
	dbsprite   2,  -6, $09, 0
	dbsprite   2,   2, $0a, 0
	dbsprite  -6,   2, $0b, 0
	dbsprite  -6,  10, $0c, 0

.frame_3
	db 8 ; size
	dbsprite  -3, -11, $05, 1
	dbsprite -11, -11, $06, 1
	dbsprite -11,  -3, $07, 1
	dbsprite -19,  -3, $08, 1
	dbsprite   3,  -5, $09, 1
	dbsprite   3,   3, $0a, 1
	dbsprite  -5,   3, $0b, 1
	dbsprite  -5,  11, $0c, 1

.frame_4
	db 8 ; size
	dbsprite  -2, -10, $05, 2
	dbsprite -10, -10, $06, 2
	dbsprite -10,  -2, $07, 2
	dbsprite -18,  -2, $08, 2
	dbsprite   2,  -6, $09, 2
	dbsprite   2,   2, $0a, 2
	dbsprite  -6,   2, $0b, 2
	dbsprite  -6,  10, $0c, 2

.frame_5
	db 10 ; size
	dbsprite  -2,  -2, $05, 1
	dbsprite -10,  -2, $06, 1
	dbsprite -10,   6, $07, 2
	dbsprite -18,   6, $08, 2
	dbsprite   2,   2, $09, 1
	dbsprite   2,  10, $0a, 1
	dbsprite  -6,  10, $0b, 2
	dbsprite  -6,  18, $0c, 2
	dbsprite -24, -34, $00, 0 | OAM_XFLIP
	dbsprite -32, -38, $00, 0 | OAM_YFLIP

.frame_6
	db 13 ; size
	dbsprite  -3,  -3, $05, 2
	dbsprite -11,  -3, $06, 2
	dbsprite -11,   5, $07, 2
	dbsprite -19,   5, $08, 2
	dbsprite   3,   3, $09, 2
	dbsprite   3,  11, $0a, 2
	dbsprite  -5,  11, $0b, 2
	dbsprite  -5,  19, $0c, 2
	dbsprite  -8, -18, $00, 0 | OAM_XFLIP
	dbsprite -16, -18, $01, 0 | OAM_XFLIP
	dbsprite -16, -26, $02, 0 | OAM_XFLIP
	dbsprite -24, -26, $03, 0 | OAM_XFLIP
	dbsprite -24, -34, $04, 1 | OAM_XFLIP

.frame_7
	db 9 ; size
	dbsprite   8,  -2, $00, 0 | OAM_XFLIP
	dbsprite   0,  -2, $01, 0 | OAM_XFLIP
	dbsprite   0, -10, $02, 0 | OAM_XFLIP
	dbsprite  -8, -10, $03, 0 | OAM_XFLIP
	dbsprite  -8, -18, $04, 1 | OAM_XFLIP
	dbsprite  -8, -10, $05, 0 | OAM_XFLIP
	dbsprite -16, -10, $06, 0 | OAM_XFLIP
	dbsprite  -2, -16, $09, 0 | OAM_XFLIP
	dbsprite  -2, -24, $0a, 0 | OAM_XFLIP

.frame_8
	db 13 ; size
	dbsprite  24,  14, $00, 0 | OAM_XFLIP
	dbsprite  16,  14, $01, 1 | OAM_XFLIP
	dbsprite  16,   6, $02, 1 | OAM_XFLIP
	dbsprite   8,   6, $03, 2 | OAM_XFLIP
	dbsprite   8,  -2, $04, 2 | OAM_XFLIP
	dbsprite  -4,  -4, $05, 0 | OAM_XFLIP
	dbsprite -12,  -4, $06, 0 | OAM_XFLIP
	dbsprite -12, -12, $07, 0 | OAM_XFLIP
	dbsprite -20, -12, $08, 0 | OAM_XFLIP
	dbsprite   4, -12, $09, 0 | OAM_XFLIP
	dbsprite   4, -20, $0a, 0 | OAM_XFLIP
	dbsprite  -4, -20, $0b, 0 | OAM_XFLIP
	dbsprite  -4, -28, $0c, 0 | OAM_XFLIP

.frame_9
	db 8 ; size
	dbsprite  -3,  -5, $05, 1 | OAM_XFLIP
	dbsprite -11,  -5, $06, 1 | OAM_XFLIP
	dbsprite -11, -13, $07, 1 | OAM_XFLIP
	dbsprite -19, -13, $08, 1 | OAM_XFLIP
	dbsprite   3, -11, $09, 1 | OAM_XFLIP
	dbsprite   3, -19, $0a, 1 | OAM_XFLIP
	dbsprite  -5, -19, $0b, 1 | OAM_XFLIP
	dbsprite  -5, -27, $0c, 1 | OAM_XFLIP

.frame_10
	db 13 ; size
	dbsprite  -4,  -4, $05, 2 | OAM_XFLIP
	dbsprite -12,  -4, $06, 2 | OAM_XFLIP
	dbsprite -12, -12, $07, 2 | OAM_XFLIP
	dbsprite -20, -12, $08, 2 | OAM_XFLIP
	dbsprite   4, -12, $09, 2 | OAM_XFLIP
	dbsprite   4, -20, $0a, 2 | OAM_XFLIP
	dbsprite  -4, -20, $0b, 2 | OAM_XFLIP
	dbsprite  -4, -28, $0c, 2 | OAM_XFLIP
	dbsprite   8,  18, $00, 0 | OAM_YFLIP
	dbsprite  16,  18, $01, 0 | OAM_YFLIP
	dbsprite  16,  26, $02, 0 | OAM_YFLIP
	dbsprite  24,  26, $03, 0 | OAM_YFLIP
	dbsprite  24,  34, $04, 0 | OAM_YFLIP

.frame_11
	db 5 ; size
	dbsprite  -8,   2, $00, 0 | OAM_YFLIP
	dbsprite   0,   2, $01, 0 | OAM_YFLIP
	dbsprite   0,  10, $02, 0 | OAM_YFLIP
	dbsprite   8,  10, $03, 0 | OAM_YFLIP
	dbsprite   8,  18, $04, 1 | OAM_YFLIP

.frame_12
	db 13 ; size
	dbsprite -24, -14, $00, 0 | OAM_YFLIP
	dbsprite -16, -14, $01, 0 | OAM_YFLIP
	dbsprite -16,  -6, $02, 0 | OAM_YFLIP
	dbsprite  -8,  -6, $03, 0 | OAM_YFLIP
	dbsprite  -8,   2, $04, 1 | OAM_YFLIP
	dbsprite  -5,  -3, $05, 0 | OAM_YFLIP
	dbsprite   3,  -3, $06, 0 | OAM_YFLIP
	dbsprite   3,   5, $07, 0 | OAM_YFLIP
	dbsprite  11,   5, $08, 0 | OAM_YFLIP
	dbsprite -11,   3, $09, 0 | OAM_YFLIP
	dbsprite -11,  11, $0a, 0 | OAM_YFLIP
	dbsprite  -3,  11, $0b, 0 | OAM_YFLIP
	dbsprite  -3,  19, $0c, 0 | OAM_YFLIP

.frame_13
	db 11 ; size
	dbsprite -32, -22, $02, 1 | OAM_YFLIP
	dbsprite -24, -22, $03, 1 | OAM_YFLIP
	dbsprite -24, -14, $04, 2 | OAM_YFLIP
	dbsprite  -6,  -2, $05, 0 | OAM_YFLIP
	dbsprite   2,  -2, $06, 0 | OAM_YFLIP
	dbsprite   2,   6, $07, 0 | OAM_YFLIP
	dbsprite  10,   6, $08, 0 | OAM_YFLIP
	dbsprite -10,   2, $09, 0 | OAM_YFLIP
	dbsprite -10,  10, $0a, 0 | OAM_YFLIP
	dbsprite  -2,  10, $0b, 0 | OAM_YFLIP
	dbsprite  -2,  18, $0c, 0 | OAM_YFLIP

.frame_14
	db 8 ; size
	dbsprite  -5,  -3, $05, 1 | OAM_YFLIP
	dbsprite   3,  -3, $06, 1 | OAM_YFLIP
	dbsprite   3,   5, $07, 1 | OAM_YFLIP
	dbsprite  11,   5, $08, 1 | OAM_YFLIP
	dbsprite -11,   3, $09, 1 | OAM_YFLIP
	dbsprite -11,  11, $0a, 1 | OAM_YFLIP
	dbsprite  -3,  11, $0b, 1 | OAM_YFLIP
	dbsprite  -3,  19, $0c, 1 | OAM_YFLIP

.frame_15
	db 8 ; size
	dbsprite  -6,  -2, $05, 2 | OAM_YFLIP
	dbsprite   2,  -2, $06, 2 | OAM_YFLIP
	dbsprite   2,   6, $07, 2 | OAM_YFLIP
	dbsprite  10,   6, $08, 2 | OAM_YFLIP
	dbsprite -10,   2, $09, 2 | OAM_YFLIP
	dbsprite -10,  10, $0a, 2 | OAM_YFLIP
	dbsprite  -2,  10, $0b, 2 | OAM_YFLIP
	dbsprite  -2,  18, $0c, 2 | OAM_YFLIP

OAMData1B::
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
	db 6 ; size
	dbsprite  16, -14, $00, 0
	dbsprite  16,  -6, $01, 0
	dbsprite  16,   2, $02, 1
	dbsprite  24, -14, $03, 0
	dbsprite  24,  -6, $04, 0
	dbsprite  24,   2, $05, 0

.frame_1
	db 7 ; size
	dbsprite   8, -10, $00, 0
	dbsprite   8,  -2, $01, 1
	dbsprite   8,   6, $02, 2
	dbsprite  16, -10, $03, 0
	dbsprite  16,  -2, $04, 0
	dbsprite  16,   6, $05, 1
	dbsprite  24,  -2, $06, 1

.frame_2
	db 8 ; size
	dbsprite   0,  -4, $07, 1
	dbsprite   0,   4, $08, 0
	dbsprite   0,  12, $09, 0
	dbsprite   8,  -4, $0a, 2
	dbsprite   8,   4, $0b, 0
	dbsprite   8,  12, $0c, 0
	dbsprite  16,   0, $06, 1
	dbsprite  24,  -3, $0d, 2

.frame_3
	db 10 ; size
	dbsprite  -8,   1, $0e, 0
	dbsprite  -8,   9, $0f, 0
	dbsprite   0,  11, $10, 0
	dbsprite   8,   3, $0b, 0
	dbsprite   8,  11, $0c, 0
	dbsprite  16,  -1, $06, 1
	dbsprite  24,  -4, $11, 2
	dbsprite  -8,  -8, $14, 2
	dbsprite   0,  -8, $15, 2
	dbsprite   0,   0, $16, 2

.frame_4
	db 14 ; size
	dbsprite -24,  13, $12, 0
	dbsprite -16,  13, $13, 0
	dbsprite  -8,  11, $10, 0
	dbsprite   0,   7, $06, 0
	dbsprite   8,   3, $06, 0
	dbsprite  16,  -1, $06, 1
	dbsprite  24,  -4, $11, 2
	dbsprite   0,  -8, $17, 2
	dbsprite   0,   0, $18, 2
	dbsprite -16,  -2, $1d, 2
	dbsprite -16,   6, $1e, 2
	dbsprite  -8, -10, $1f, 2
	dbsprite  -8,  -2, $20, 2
	dbsprite  -8,   6, $21, 2

.frame_5
	db 12 ; size
	dbsprite   0,   7, $06, 0
	dbsprite   8,   3, $06, 0
	dbsprite  16,  -1, $06, 0
	dbsprite  24,  -4, $11, 1
	dbsprite  -8,  19, $0e, 0 | OAM_XFLIP
	dbsprite  -8,  11, $0f, 0 | OAM_XFLIP
	dbsprite   0,  -8, $15, 1
	dbsprite   0,   0, $16, 1
	dbsprite -16,  -4, $19, 2
	dbsprite -16,   4, $1a, 2
	dbsprite  -8,  -4, $1b, 1
	dbsprite  -8,   4, $1c, 2

.frame_6
	db 12 ; size
	dbsprite   8,   7, $06, 0
	dbsprite  16,   3, $06, 0
	dbsprite  24,  -1, $06, 0
	dbsprite   0,  19, $0e, 0 | OAM_XFLIP
	dbsprite   0,  11, $0f, 0 | OAM_XFLIP
	dbsprite   0,  -8, $17, 1
	dbsprite   0,   0, $18, 1
	dbsprite -16,  -2, $1d, 1
	dbsprite -16,   6, $1e, 1
	dbsprite  -8, -10, $1f, 1
	dbsprite  -8,  -2, $20, 1
	dbsprite  -8,   6, $21, 1

.frame_7
	db 9 ; size
	dbsprite  24,   1, $06, 0
	dbsprite  16,  13, $0e, 0 | OAM_XFLIP
	dbsprite  16,   5, $0f, 0 | OAM_XFLIP
	dbsprite   0,  -8, $15, 0
	dbsprite   0,   0, $16, 0
	dbsprite -16,  -4, $19, 1
	dbsprite -16,   4, $1a, 1
	dbsprite  -8,  -4, $1b, 0
	dbsprite  -8,   4, $1c, 1

.frame_8
	db 9 ; size
	dbsprite  24,  13, $0e, 0 | OAM_XFLIP
	dbsprite  24,   5, $0f, 0 | OAM_XFLIP
	dbsprite   0,  -8, $17, 0
	dbsprite   0,   0, $18, 0
	dbsprite -16,  -2, $1d, 0
	dbsprite -16,   6, $1e, 0
	dbsprite  -8, -10, $1f, 0
	dbsprite  -8,  -2, $20, 0
	dbsprite  -8,   6, $21, 0

OAMData1C::
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

.frame_0
	db 12 ; size
	dbsprite  -8, -32, $03, 0
	dbsprite  -8, -24, $04, 0
	dbsprite   0, -32, $03, 0 | OAM_YFLIP
	dbsprite   0, -24, $04, 0 | OAM_YFLIP
	dbsprite  -8, -40, $02, 1
	dbsprite  -8, -48, $01, 2
	dbsprite -16, -40, $00, 1
	dbsprite -20, -48, $00, 2
	dbsprite   0, -40, $02, 1 | OAM_YFLIP
	dbsprite   0, -48, $01, 2 | OAM_YFLIP
	dbsprite   8, -40, $00, 1 | OAM_YFLIP
	dbsprite  12, -48, $00, 2 | OAM_YFLIP

.frame_1
	db 16 ; size
	dbsprite  12, -32, $00, 2 | OAM_YFLIP
	dbsprite   8, -24, $00, 1 | OAM_YFLIP
	dbsprite   0, -32, $01, 2 | OAM_YFLIP
	dbsprite   0, -24, $02, 1 | OAM_YFLIP
	dbsprite   0, -16, $03, 0 | OAM_YFLIP
	dbsprite   0,  -8, $04, 0 | OAM_YFLIP
	dbsprite -10, -24, $05, 0
	dbsprite -11, -32, $06, 0
	dbsprite -20, -32, $00, 2
	dbsprite -16, -24, $00, 1
	dbsprite  -8, -32, $01, 2
	dbsprite  -8, -24, $02, 1
	dbsprite  -8, -16, $03, 0
	dbsprite  -8,  -8, $04, 0
	dbsprite   2, -24, $05, 0 | OAM_YFLIP
	dbsprite   3, -32, $06, 0 | OAM_YFLIP

.frame_2
	db 16 ; size
	dbsprite  12, -32, $00, 2 | OAM_YFLIP
	dbsprite   8, -24, $00, 1 | OAM_YFLIP
	dbsprite   0, -32, $01, 2 | OAM_YFLIP
	dbsprite   0, -24, $02, 1 | OAM_YFLIP
	dbsprite   0, -16, $03, 0 | OAM_YFLIP
	dbsprite   0,  -8, $04, 0 | OAM_YFLIP
	dbsprite  -9, -24, $05, 0
	dbsprite -10, -32, $06, 0
	dbsprite -20, -32, $00, 2
	dbsprite -16, -24, $00, 1
	dbsprite  -8, -32, $01, 2
	dbsprite  -8, -24, $02, 1
	dbsprite  -8, -16, $03, 0
	dbsprite  -8,  -8, $04, 0
	dbsprite   1, -24, $05, 0 | OAM_YFLIP
	dbsprite   2, -32, $06, 0 | OAM_YFLIP

.frame_3
	db 20 ; size
	dbsprite  12, -16, $00, 2 | OAM_YFLIP
	dbsprite   8,  -8, $00, 1 | OAM_YFLIP
	dbsprite   0, -16, $01, 2 | OAM_YFLIP
	dbsprite   0,  -8, $02, 1 | OAM_YFLIP
	dbsprite   0,   0, $03, 0 | OAM_YFLIP
	dbsprite   0,   8, $04, 0 | OAM_YFLIP
	dbsprite -10,  -8, $05, 0
	dbsprite -11, -16, $06, 0
	dbsprite -12, -24, $07, 0
	dbsprite -13, -32, $08, 0
	dbsprite -20, -16, $00, 2
	dbsprite -16,  -8, $00, 1
	dbsprite  -8, -16, $01, 2
	dbsprite  -8,  -8, $02, 1
	dbsprite  -8,   0, $03, 0
	dbsprite  -8,   8, $04, 0
	dbsprite   2,  -8, $05, 0 | OAM_YFLIP
	dbsprite   3, -16, $06, 0 | OAM_YFLIP
	dbsprite   4, -24, $07, 0 | OAM_YFLIP
	dbsprite   5, -32, $08, 0 | OAM_YFLIP

.frame_4
	db 20 ; size
	dbsprite  12, -16, $00, 2 | OAM_YFLIP
	dbsprite   8,  -8, $00, 1 | OAM_YFLIP
	dbsprite   0, -16, $01, 2 | OAM_YFLIP
	dbsprite   0,  -8, $02, 1 | OAM_YFLIP
	dbsprite   0,   0, $03, 0 | OAM_YFLIP
	dbsprite   0,   8, $04, 0 | OAM_YFLIP
	dbsprite  -9,  -8, $05, 0
	dbsprite -10, -16, $06, 0
	dbsprite -11, -24, $07, 0
	dbsprite -12, -32, $08, 0
	dbsprite -20, -16, $00, 2
	dbsprite -16,  -8, $00, 1
	dbsprite  -8, -16, $01, 2
	dbsprite  -8,  -8, $02, 1
	dbsprite  -8,   0, $03, 0
	dbsprite  -8,   8, $04, 0
	dbsprite   1,  -8, $05, 0 | OAM_YFLIP
	dbsprite   2, -16, $06, 0 | OAM_YFLIP
	dbsprite   3, -24, $07, 0 | OAM_YFLIP
	dbsprite   4, -32, $08, 0 | OAM_YFLIP

.frame_5
	db 24 ; size
	dbsprite  12,   0, $00, 2 | OAM_YFLIP
	dbsprite   8,   8, $00, 1 | OAM_YFLIP
	dbsprite   0,   0, $01, 2 | OAM_YFLIP
	dbsprite   0,   8, $02, 1 | OAM_YFLIP
	dbsprite   0,  16, $03, 0 | OAM_YFLIP
	dbsprite   0,  24, $04, 0 | OAM_YFLIP
	dbsprite -10,   8, $05, 0
	dbsprite -11,   0, $06, 0
	dbsprite -12,  -8, $07, 0
	dbsprite -13, -16, $08, 0
	dbsprite -14, -24, $08, 0
	dbsprite -15, -32, $08, 0
	dbsprite -20,   0, $00, 2
	dbsprite -16,   8, $00, 1
	dbsprite  -8,   0, $01, 2
	dbsprite  -8,   8, $02, 1
	dbsprite  -8,  16, $03, 0
	dbsprite  -8,  24, $04, 0
	dbsprite   2,   8, $05, 0 | OAM_YFLIP
	dbsprite   3,   0, $06, 0 | OAM_YFLIP
	dbsprite   4,  -8, $07, 0 | OAM_YFLIP
	dbsprite   5, -16, $08, 0 | OAM_YFLIP
	dbsprite   6, -24, $08, 0 | OAM_YFLIP
	dbsprite   7, -32, $08, 0 | OAM_YFLIP

.frame_6
	db 24 ; size
	dbsprite  12,   0, $00, 2 | OAM_YFLIP
	dbsprite   8,   8, $00, 1 | OAM_YFLIP
	dbsprite   0,   0, $01, 2 | OAM_YFLIP
	dbsprite   0,   8, $02, 1 | OAM_YFLIP
	dbsprite   0,  16, $03, 0 | OAM_YFLIP
	dbsprite   0,  24, $04, 0 | OAM_YFLIP
	dbsprite  -9,   8, $05, 0
	dbsprite -10,   0, $06, 0
	dbsprite -11,  -8, $07, 0
	dbsprite -12, -16, $08, 0
	dbsprite -13, -24, $08, 0
	dbsprite -14, -32, $08, 0
	dbsprite -20,   0, $00, 2
	dbsprite -16,   8, $00, 1
	dbsprite  -8,   0, $01, 2
	dbsprite  -8,   8, $02, 1
	dbsprite  -8,  16, $03, 0
	dbsprite  -8,  24, $04, 0
	dbsprite   1,   8, $05, 0 | OAM_YFLIP
	dbsprite   2,   0, $06, 0 | OAM_YFLIP
	dbsprite   3,  -8, $07, 0 | OAM_YFLIP
	dbsprite   4, -16, $08, 0 | OAM_YFLIP
	dbsprite   5, -24, $08, 0 | OAM_YFLIP
	dbsprite   6, -32, $08, 0 | OAM_YFLIP

.frame_7
	db 28 ; size
	dbsprite  12,  16, $00, 2 | OAM_YFLIP
	dbsprite   8,  24, $00, 1 | OAM_YFLIP
	dbsprite   0,  16, $01, 2 | OAM_YFLIP
	dbsprite   0,  24, $02, 1 | OAM_YFLIP
	dbsprite -10,  24, $05, 0
	dbsprite -11,  16, $06, 0
	dbsprite -12,   8, $07, 0
	dbsprite -13,   0, $08, 0
	dbsprite -14,  -8, $08, 0
	dbsprite -15, -16, $08, 0
	dbsprite -16, -24, $08, 0
	dbsprite -17, -32, $08, 0
	dbsprite -20,  16, $00, 2
	dbsprite -16,  24, $00, 1
	dbsprite  -8,  16, $01, 2
	dbsprite  -8,  24, $02, 1
	dbsprite   2,  24, $05, 0 | OAM_YFLIP
	dbsprite   3,  16, $06, 0 | OAM_YFLIP
	dbsprite   4,   8, $07, 0 | OAM_YFLIP
	dbsprite   5,   0, $08, 0 | OAM_YFLIP
	dbsprite   6,  -8, $08, 0 | OAM_YFLIP
	dbsprite   7, -16, $08, 0 | OAM_YFLIP
	dbsprite   8, -24, $08, 0 | OAM_YFLIP
	dbsprite   9, -32, $08, 0 | OAM_YFLIP
	dbsprite   0,  32, $03, 0 | OAM_YFLIP
	dbsprite   0,  40, $04, 0 | OAM_YFLIP
	dbsprite  -8,  32, $03, 0
	dbsprite  -8,  40, $04, 0

.frame_8
	db 28 ; size
	dbsprite  12,  16, $00, 2 | OAM_YFLIP
	dbsprite   8,  24, $00, 1 | OAM_YFLIP
	dbsprite   0,  16, $01, 2 | OAM_YFLIP
	dbsprite   0,  24, $02, 1 | OAM_YFLIP
	dbsprite  -9,  24, $05, 0
	dbsprite -10,  16, $06, 0
	dbsprite -11,   8, $07, 0
	dbsprite -12,   0, $08, 0
	dbsprite -13,  -8, $08, 0
	dbsprite -14, -16, $08, 0
	dbsprite -15, -24, $08, 0
	dbsprite -16, -32, $08, 0
	dbsprite -20,  16, $00, 2
	dbsprite -16,  24, $00, 1
	dbsprite  -8,  16, $01, 2
	dbsprite  -8,  24, $02, 1
	dbsprite   1,  24, $05, 0 | OAM_YFLIP
	dbsprite   2,  16, $06, 0 | OAM_YFLIP
	dbsprite   3,   8, $07, 0 | OAM_YFLIP
	dbsprite   4,   0, $08, 0 | OAM_YFLIP
	dbsprite   5,  -8, $08, 0 | OAM_YFLIP
	dbsprite   6, -16, $08, 0 | OAM_YFLIP
	dbsprite   7, -24, $08, 0 | OAM_YFLIP
	dbsprite   8, -32, $08, 0 | OAM_YFLIP
	dbsprite   0,  32, $03, 0 | OAM_YFLIP
	dbsprite   0,  40, $04, 0 | OAM_YFLIP
	dbsprite  -8,  32, $03, 0
	dbsprite  -8,  40, $04, 0

.frame_9
	db 16 ; size
	dbsprite -12,  24, $07, 0
	dbsprite -13,  16, $08, 0
	dbsprite -14,   8, $08, 0
	dbsprite -15,   0, $08, 0
	dbsprite -16,  -8, $08, 0
	dbsprite -17, -16, $08, 0
	dbsprite -18, -24, $08, 0
	dbsprite -19, -32, $08, 0
	dbsprite   4,  24, $07, 0 | OAM_YFLIP
	dbsprite   5,  16, $08, 0 | OAM_YFLIP
	dbsprite   6,   8, $08, 0 | OAM_YFLIP
	dbsprite   7,   0, $08, 0 | OAM_YFLIP
	dbsprite   8,  -8, $08, 0 | OAM_YFLIP
	dbsprite   9, -16, $08, 0 | OAM_YFLIP
	dbsprite  10, -24, $08, 0 | OAM_YFLIP
	dbsprite  11, -32, $08, 0 | OAM_YFLIP

.frame_10
	db 16 ; size
	dbsprite -11,  24, $07, 0
	dbsprite -12,  16, $08, 0
	dbsprite -13,   8, $08, 0
	dbsprite -14,   0, $08, 0
	dbsprite -15,  -8, $08, 0
	dbsprite -16, -16, $08, 0
	dbsprite -17, -24, $08, 0
	dbsprite -18, -32, $08, 0
	dbsprite   3,  24, $07, 0 | OAM_YFLIP
	dbsprite   4,  16, $08, 0 | OAM_YFLIP
	dbsprite   5,   8, $08, 0 | OAM_YFLIP
	dbsprite   6,   0, $08, 0 | OAM_YFLIP
	dbsprite   7,  -8, $08, 0 | OAM_YFLIP
	dbsprite   8, -16, $08, 0 | OAM_YFLIP
	dbsprite   9, -24, $08, 0 | OAM_YFLIP
	dbsprite  10, -32, $08, 0 | OAM_YFLIP

.frame_11
	db 16 ; size
	dbsprite -14,  24, $08, 0
	dbsprite -15,  16, $08, 0
	dbsprite -16,   8, $08, 0
	dbsprite -17,   0, $08, 0
	dbsprite -18,  -8, $08, 0
	dbsprite -19, -16, $08, 0
	dbsprite -20, -24, $09, 0
	dbsprite -21, -32, $09, 0
	dbsprite   6,  24, $08, 0 | OAM_YFLIP
	dbsprite   7,  16, $08, 0 | OAM_YFLIP
	dbsprite   8,   8, $08, 0 | OAM_YFLIP
	dbsprite   9,   0, $08, 0 | OAM_YFLIP
	dbsprite  10,  -8, $08, 0 | OAM_YFLIP
	dbsprite  11, -16, $08, 0 | OAM_YFLIP
	dbsprite  12, -24, $09, 0 | OAM_YFLIP
	dbsprite  13, -32, $09, 0 | OAM_YFLIP

.frame_12
	db 16 ; size
	dbsprite -13,  24, $08, 0
	dbsprite -14,  16, $08, 0
	dbsprite -15,   8, $08, 0
	dbsprite -16,   0, $08, 0
	dbsprite -17,  -8, $08, 0
	dbsprite -18, -16, $08, 0
	dbsprite -19, -24, $09, 0
	dbsprite -20, -32, $09, 0
	dbsprite   5,  24, $08, 0 | OAM_YFLIP
	dbsprite   6,  16, $08, 0 | OAM_YFLIP
	dbsprite   7,   8, $08, 0 | OAM_YFLIP
	dbsprite   8,   0, $08, 0 | OAM_YFLIP
	dbsprite   9,  -8, $08, 0 | OAM_YFLIP
	dbsprite  10, -16, $08, 0 | OAM_YFLIP
	dbsprite  11, -24, $09, 0 | OAM_YFLIP
	dbsprite  12, -32, $09, 0 | OAM_YFLIP

.frame_13
	db 16 ; size
	dbsprite -16,  24, $08, 0
	dbsprite -17,  16, $08, 0
	dbsprite -18,   8, $08, 0
	dbsprite -19,   0, $08, 0
	dbsprite -20,  -8, $09, 0
	dbsprite -21, -16, $09, 0
	dbsprite -23, -32, $0a, 0
	dbsprite -22, -24, $0a, 0
	dbsprite   8,  24, $08, 0 | OAM_YFLIP
	dbsprite   9,  16, $08, 0 | OAM_YFLIP
	dbsprite  10,   8, $08, 0 | OAM_YFLIP
	dbsprite  11,   0, $08, 0 | OAM_YFLIP
	dbsprite  12,  -8, $09, 0 | OAM_YFLIP
	dbsprite  13, -16, $09, 0 | OAM_YFLIP
	dbsprite  15, -32, $0a, 0 | OAM_YFLIP
	dbsprite  14, -24, $0a, 0 | OAM_YFLIP

.frame_14
	db 16 ; size
	dbsprite -15,  24, $08, 0
	dbsprite -16,  16, $08, 0
	dbsprite -17,   8, $08, 0
	dbsprite -18,   0, $08, 0
	dbsprite -19,  -8, $09, 0
	dbsprite -20, -16, $09, 0
	dbsprite -22, -32, $0a, 1
	dbsprite -21, -24, $0a, 1
	dbsprite   7,  24, $08, 0 | OAM_YFLIP
	dbsprite   8,  16, $08, 0 | OAM_YFLIP
	dbsprite   9,   8, $08, 0 | OAM_YFLIP
	dbsprite  10,   0, $08, 0 | OAM_YFLIP
	dbsprite  11,  -8, $09, 0 | OAM_YFLIP
	dbsprite  12, -16, $09, 0 | OAM_YFLIP
	dbsprite  14, -32, $0a, 1 | OAM_YFLIP
	dbsprite  13, -24, $0a, 1 | OAM_YFLIP

.frame_15
	db 16 ; size
	dbsprite -18,  24, $08, 0
	dbsprite -19,  16, $08, 0
	dbsprite -20,   8, $09, 0
	dbsprite -21,   0, $09, 0
	dbsprite -23, -16, $0a, 0
	dbsprite -22,  -8, $0a, 0
	dbsprite -25, -32, $0b, 1
	dbsprite -24, -24, $0b, 1
	dbsprite  10,  24, $08, 0 | OAM_YFLIP
	dbsprite  11,  16, $08, 0 | OAM_YFLIP
	dbsprite  12,   8, $09, 0 | OAM_YFLIP
	dbsprite  13,   0, $09, 0 | OAM_YFLIP
	dbsprite  15, -16, $0a, 0 | OAM_YFLIP
	dbsprite  14,  -8, $0a, 0 | OAM_YFLIP
	dbsprite  17, -32, $0b, 1 | OAM_YFLIP
	dbsprite  16, -24, $0b, 1 | OAM_YFLIP

.frame_16
	db 16 ; size
	dbsprite -17,  24, $08, 0
	dbsprite -18,  16, $08, 0
	dbsprite -19,   8, $09, 0
	dbsprite -20,   0, $09, 0
	dbsprite -22, -16, $0a, 1
	dbsprite -21,  -8, $0a, 1
	dbsprite -24, -32, $0b, 2
	dbsprite -23, -24, $0b, 2
	dbsprite   9,  24, $08, 0 | OAM_YFLIP
	dbsprite  10,  16, $08, 0 | OAM_YFLIP
	dbsprite  11,   8, $09, 0 | OAM_YFLIP
	dbsprite  12,   0, $09, 0 | OAM_YFLIP
	dbsprite  14, -16, $0a, 1 | OAM_YFLIP
	dbsprite  13,  -8, $0a, 1 | OAM_YFLIP
	dbsprite  16, -32, $0b, 2 | OAM_YFLIP
	dbsprite  15, -24, $0b, 2 | OAM_YFLIP

.frame_17
	db 12 ; size
	dbsprite -20,  24, $09, 0
	dbsprite -21,  16, $09, 0
	dbsprite -23,   0, $0a, 0
	dbsprite -22,   8, $0a, 0
	dbsprite -25, -16, $0b, 1
	dbsprite -24,  -8, $0b, 1
	dbsprite  12,  24, $09, 0 | OAM_YFLIP
	dbsprite  13,  16, $09, 0 | OAM_YFLIP
	dbsprite  15,   0, $0a, 0 | OAM_YFLIP
	dbsprite  14,   8, $0a, 0 | OAM_YFLIP
	dbsprite  17, -16, $0b, 1 | OAM_YFLIP
	dbsprite  16,  -8, $0b, 1 | OAM_YFLIP

.frame_18
	db 12 ; size
	dbsprite -19,  24, $09, 0
	dbsprite -20,  16, $09, 0
	dbsprite -22,   0, $0a, 1
	dbsprite -21,   8, $0a, 1
	dbsprite -24, -16, $0b, 2
	dbsprite -23,  -8, $0b, 2
	dbsprite  11,  24, $09, 0 | OAM_YFLIP
	dbsprite  12,  16, $09, 0 | OAM_YFLIP
	dbsprite  14,   0, $0a, 1 | OAM_YFLIP
	dbsprite  13,   8, $0a, 1 | OAM_YFLIP
	dbsprite  16, -16, $0b, 2 | OAM_YFLIP
	dbsprite  15,  -8, $0b, 2 | OAM_YFLIP

.frame_19
	db 8 ; size
	dbsprite -23,  16, $0a, 0
	dbsprite -22,  24, $0a, 0
	dbsprite -25,   0, $0b, 1
	dbsprite -24,   8, $0b, 1
	dbsprite  15,  16, $0a, 0 | OAM_YFLIP
	dbsprite  14,  24, $0a, 0 | OAM_YFLIP
	dbsprite  17,   0, $0b, 1 | OAM_YFLIP
	dbsprite  16,   8, $0b, 1 | OAM_YFLIP

.frame_20
	db 8 ; size
	dbsprite -22,  16, $0a, 1
	dbsprite -21,  24, $0a, 1
	dbsprite -24,   0, $0b, 2
	dbsprite -23,   8, $0b, 2
	dbsprite  14,  16, $0a, 1 | OAM_YFLIP
	dbsprite  13,  24, $0a, 1 | OAM_YFLIP
	dbsprite  16,   0, $0b, 2 | OAM_YFLIP
	dbsprite  15,   8, $0b, 2 | OAM_YFLIP

.frame_21
	db 4 ; size
	dbsprite -25,  16, $0b, 1
	dbsprite -24,  24, $0b, 1
	dbsprite  17,  16, $0b, 1 | OAM_YFLIP
	dbsprite  16,  24, $0b, 1 | OAM_YFLIP

.frame_22
	db 4 ; size
	dbsprite -24,  16, $0b, 2
	dbsprite -23,  24, $0b, 2
	dbsprite  16,  16, $0b, 2 | OAM_YFLIP
	dbsprite  15,  24, $0b, 2 | OAM_YFLIP

OAMData1D::
	dw .frame_0
	dw .frame_1
	dw .frame_2
	dw .frame_3
	dw .frame_4
	dw .frame_5

.frame_0
	db 13 ; size
	dbsprite -32, -16, $00, 0 | OAM_XFLIP
	dbsprite -32, -24, $01, 0 | OAM_XFLIP
	dbsprite -24,  -8, $02, 0 | OAM_XFLIP
	dbsprite -24, -16, $03, 0 | OAM_XFLIP
	dbsprite -24, -24, $04, 0 | OAM_XFLIP
	dbsprite -24, -32, $05, 0 | OAM_XFLIP
	dbsprite -16,  -8, $06, 0 | OAM_XFLIP
	dbsprite -16, -16, $07, 0 | OAM_XFLIP
	dbsprite -16, -24, $08, 0 | OAM_XFLIP
	dbsprite -16, -32, $09, 0 | OAM_XFLIP
	dbsprite  -8,  -8, $0a, 0 | OAM_XFLIP
	dbsprite  -8, -16, $09, 0 | OAM_XFLIP
	dbsprite  -8, -24, $02, 0 | OAM_YFLIP

.frame_1
	db 13 ; size
	dbsprite -32, -16, $00, 0 | OAM_XFLIP
	dbsprite -24,  -8, $02, 0 | OAM_XFLIP
	dbsprite -24, -32, $05, 0 | OAM_XFLIP
	dbsprite -16, -24, $08, 0 | OAM_XFLIP
	dbsprite -16, -32, $09, 0 | OAM_XFLIP
	dbsprite  -8, -16, $09, 0 | OAM_XFLIP
	dbsprite  -8, -24, $02, 0 | OAM_YFLIP
	dbsprite -32, -24, $0b, 0 | OAM_XFLIP
	dbsprite -24, -16, $0c, 0 | OAM_XFLIP
	dbsprite -24, -24, $0d, 0 | OAM_XFLIP
	dbsprite -16,  -8, $0e, 0 | OAM_XFLIP
	dbsprite -16, -16, $0f, 0 | OAM_XFLIP
	dbsprite  -8,  -8, $10, 0 | OAM_XFLIP

.frame_2
	db 13 ; size
	dbsprite -24,  -8, $02, 0 | OAM_XFLIP
	dbsprite -24, -32, $05, 0 | OAM_XFLIP
	dbsprite -16, -24, $08, 0 | OAM_XFLIP
	dbsprite -16, -32, $09, 0 | OAM_XFLIP
	dbsprite  -8, -16, $09, 0 | OAM_XFLIP
	dbsprite  -8, -24, $02, 0 | OAM_YFLIP
	dbsprite -32, -16, $11, 0 | OAM_XFLIP
	dbsprite -32, -24, $12, 0 | OAM_XFLIP
	dbsprite -24, -16, $13, 0 | OAM_XFLIP
	dbsprite -24, -24, $14, 0 | OAM_XFLIP
	dbsprite -16,  -8, $15, 0 | OAM_XFLIP
	dbsprite -16, -16, $16, 0 | OAM_XFLIP
	dbsprite  -8,  -8, $17, 0 | OAM_XFLIP

.frame_3
	db 18 ; size
	dbsprite -32, -16, $00, 0 | OAM_XFLIP
	dbsprite -32, -24, $01, 0 | OAM_XFLIP
	dbsprite -24,  -8, $02, 0 | OAM_XFLIP
	dbsprite -24, -16, $03, 0 | OAM_XFLIP
	dbsprite -24, -24, $04, 0 | OAM_XFLIP
	dbsprite -24, -32, $05, 0 | OAM_XFLIP
	dbsprite -16,  -8, $06, 0 | OAM_XFLIP
	dbsprite -16, -16, $07, 0 | OAM_XFLIP
	dbsprite -16, -24, $08, 0 | OAM_XFLIP
	dbsprite -16, -32, $09, 0 | OAM_XFLIP
	dbsprite  -8, -16, $09, 0 | OAM_XFLIP
	dbsprite  -8, -24, $02, 0 | OAM_YFLIP
	dbsprite  -8,   0, $18, 1 | OAM_XFLIP
	dbsprite  -8,  -8, $19, 0 | OAM_XFLIP
	dbsprite   0,   0, $1a, 1 | OAM_XFLIP
	dbsprite   0,  -8, $1b, 1 | OAM_XFLIP
	dbsprite   4,   4, $24, 2
	dbsprite   2, -20, $24, 2

.frame_4
	db 18 ; size
	dbsprite -31, -16, $00, 0 | OAM_XFLIP
	dbsprite -23,  -8, $02, 0 | OAM_XFLIP
	dbsprite -23, -32, $05, 0 | OAM_XFLIP
	dbsprite -15, -24, $08, 0 | OAM_XFLIP
	dbsprite -15, -32, $09, 0 | OAM_XFLIP
	dbsprite  -7, -16, $09, 0 | OAM_XFLIP
	dbsprite  -7, -24, $02, 0 | OAM_YFLIP
	dbsprite -31, -24, $0b, 0 | OAM_XFLIP
	dbsprite -23, -16, $0c, 0 | OAM_XFLIP
	dbsprite -23, -24, $0d, 0 | OAM_XFLIP
	dbsprite -15,  -8, $0e, 0 | OAM_XFLIP
	dbsprite -15, -16, $0f, 0 | OAM_XFLIP
	dbsprite  -7,   0, $1c, 1 | OAM_XFLIP
	dbsprite  -7,  -8, $1d, 0 | OAM_XFLIP
	dbsprite   1,   0, $1e, 1 | OAM_XFLIP
	dbsprite   1,  -8, $1f, 1 | OAM_XFLIP
	dbsprite -16,   1, $24, 2
	dbsprite  10,  10, $24, 2

.frame_5
	db 18 ; size
	dbsprite -24,  -8, $02, 0 | OAM_XFLIP
	dbsprite -24, -32, $05, 0 | OAM_XFLIP
	dbsprite -16, -24, $08, 0 | OAM_XFLIP
	dbsprite -16, -32, $09, 0 | OAM_XFLIP
	dbsprite  -8, -16, $09, 0 | OAM_XFLIP
	dbsprite  -8, -24, $02, 0 | OAM_YFLIP
	dbsprite -32, -16, $11, 0 | OAM_XFLIP
	dbsprite -32, -24, $12, 0 | OAM_XFLIP
	dbsprite -24, -16, $13, 0 | OAM_XFLIP
	dbsprite -24, -24, $14, 0 | OAM_XFLIP
	dbsprite -16,  -8, $15, 0 | OAM_XFLIP
	dbsprite -16, -16, $16, 0 | OAM_XFLIP
	dbsprite  -8,   0, $20, 1 | OAM_XFLIP
	dbsprite  -8,  -8, $21, 0 | OAM_XFLIP
	dbsprite   0,   0, $22, 1 | OAM_XFLIP
	dbsprite   0,  -8, $23, 1 | OAM_XFLIP
	dbsprite  -1, -13, $24, 2
	dbsprite -24,   4, $24, 2

OAMData1F::
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
	db 3 ; size
	dbsprite -52, -52, $06, 0
	dbsprite -52, -44, $07, 0
	dbsprite -52, -36, $06, 0 | OAM_XFLIP

.frame_1
	db 4 ; size
	dbsprite -55, -52, $03, 0
	dbsprite -55, -44, $04, 0
	dbsprite -47, -44, $04, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite -47, -36, $05, 0

.frame_2
	db 3 ; size
	dbsprite -59, -44, $00, 0
	dbsprite -51, -44, $01, 0
	dbsprite -43, -44, $02, 0

.frame_3
	db 4 ; size
	dbsprite -55, -36, $03, 0 | OAM_XFLIP
	dbsprite -55, -44, $04, 0 | OAM_XFLIP
	dbsprite -47, -44, $04, 0 | OAM_YFLIP
	dbsprite -47, -52, $05, 0 | OAM_XFLIP

.frame_4
	db 7 ; size
	dbsprite -52, -52, $06, 0
	dbsprite -52, -44, $07, 0
	dbsprite -52, -36, $06, 0 | OAM_XFLIP
	dbsprite -66, -58, $08, 0
	dbsprite -66, -50, $09, 0
	dbsprite -58, -58, $0a, 0
	dbsprite -58, -50, $0b, 0

.frame_5
	db 8 ; size
	dbsprite -55, -52, $03, 0
	dbsprite -55, -44, $04, 0
	dbsprite -47, -44, $04, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite -47, -36, $05, 0
	dbsprite -61, -61, $08, 1 | OAM_YFLIP
	dbsprite -61, -53, $09, 1 | OAM_YFLIP
	dbsprite -69, -61, $0a, 1 | OAM_YFLIP
	dbsprite -69, -53, $0b, 1 | OAM_YFLIP

.frame_6
	db 7 ; size
	dbsprite -59, -44, $00, 0
	dbsprite -51, -44, $01, 0
	dbsprite -43, -44, $02, 0
	dbsprite -72, -64, $08, 1
	dbsprite -72, -56, $09, 1
	dbsprite -64, -64, $0a, 1
	dbsprite -64, -56, $0b, 1

.frame_7
	db 8 ; size
	dbsprite -66, -67, $08, 2 | OAM_YFLIP
	dbsprite -66, -59, $09, 2 | OAM_YFLIP
	dbsprite -74, -67, $0a, 2 | OAM_YFLIP
	dbsprite -74, -59, $0b, 2 | OAM_YFLIP
	dbsprite -55, -36, $03, 0 | OAM_XFLIP
	dbsprite -55, -44, $04, 0 | OAM_XFLIP
	dbsprite -47, -44, $04, 0 | OAM_YFLIP
	dbsprite -47, -52, $05, 0 | OAM_XFLIP

.frame_8
	db 7 ; size
	dbsprite -59, -44, $00, 0
	dbsprite -51, -44, $01, 0
	dbsprite -43, -44, $02, 0
	dbsprite -46, -38, $08, 0
	dbsprite -46, -30, $09, 0
	dbsprite -38, -38, $0a, 0
	dbsprite -38, -30, $0b, 0

.frame_9
	db 8 ; size
	dbsprite -55, -36, $03, 0 | OAM_XFLIP
	dbsprite -55, -44, $04, 0 | OAM_XFLIP
	dbsprite -47, -44, $04, 0 | OAM_YFLIP
	dbsprite -47, -52, $05, 0 | OAM_XFLIP
	dbsprite -35, -35, $08, 1 | OAM_YFLIP
	dbsprite -35, -27, $09, 1 | OAM_YFLIP
	dbsprite -43, -35, $0a, 1 | OAM_YFLIP
	dbsprite -43, -27, $0b, 1 | OAM_YFLIP

.frame_10
	db 7 ; size
	dbsprite -52, -52, $06, 0
	dbsprite -52, -44, $07, 0
	dbsprite -52, -36, $06, 0 | OAM_XFLIP
	dbsprite -40, -32, $08, 1
	dbsprite -40, -24, $09, 1
	dbsprite -32, -32, $0a, 1
	dbsprite -32, -24, $0b, 1

.frame_11
	db 8 ; size
	dbsprite -29, -28, $08, 2 | OAM_YFLIP
	dbsprite -29, -20, $09, 2 | OAM_YFLIP
	dbsprite -37, -28, $0a, 2 | OAM_YFLIP
	dbsprite -37, -20, $0b, 2 | OAM_YFLIP
	dbsprite -55, -52, $03, 0
	dbsprite -55, -44, $04, 0
	dbsprite -47, -44, $04, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite -47, -36, $05, 0

OAMData20::
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
	db 36 ; size
	dbsprite -40, -24, $00, 0
	dbsprite -40, -16, $01, 0
	dbsprite -40,  -8, $02, 0
	dbsprite -40,   0, $03, 0
	dbsprite -40,   8, $04, 0
	dbsprite -40,  16, $00, 0 | OAM_XFLIP
	dbsprite -32, -24, $05, 0
	dbsprite -32, -16, $06, 0
	dbsprite -32,  -8, $07, 0
	dbsprite -32,   0, $08, 0
	dbsprite -32,   8, $08, 0
	dbsprite -32,  16, $09, 0
	dbsprite -24, -24, $0a, 0
	dbsprite -24, -16, $0b, 0
	dbsprite -24,  -8, $0c, 0
	dbsprite -24,   0, $08, 0
	dbsprite -24,   8, $08, 0
	dbsprite -24,  16, $0d, 0
	dbsprite -16, -24, $0e, 0
	dbsprite -16, -16, $0f, 0
	dbsprite -16,  -8, $10, 0
	dbsprite -16,   0, $11, 0
	dbsprite -16,   8, $12, 0
	dbsprite -16,  16, $0d, 0 | OAM_YFLIP
	dbsprite  -8, -24, $09, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite  -8, -16, $13, 0
	dbsprite  -8,  -8, $14, 0
	dbsprite  -8,   0, $15, 0
	dbsprite  -8,   8, $0c, 0 | OAM_YFLIP
	dbsprite  -8,  16, $09, 0 | OAM_YFLIP
	dbsprite   0, -24, $00, 0 | OAM_YFLIP
	dbsprite   0, -16, $04, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite   0,  -8, $16, 0
	dbsprite   0,   0, $16, 0 | OAM_XFLIP
	dbsprite   0,   8, $04, 0 | OAM_YFLIP
	dbsprite   0,  16, $00, 0 | OAM_XFLIP | OAM_YFLIP

.frame_1
	db 38 ; size
	dbsprite -40, -24, $00, 1
	dbsprite -40, -16, $01, 1
	dbsprite -40,  -8, $02, 1
	dbsprite -40,   0, $03, 1
	dbsprite -40,   8, $04, 1
	dbsprite -40,  16, $00, 1 | OAM_XFLIP
	dbsprite -32, -24, $05, 1
	dbsprite -32, -16, $06, 1
	dbsprite -32,  -8, $07, 1
	dbsprite -32,   0, $08, 1
	dbsprite -32,   8, $08, 1
	dbsprite -32,  16, $09, 1
	dbsprite -24, -24, $0a, 1
	dbsprite -24, -16, $0b, 1
	dbsprite -24,  -8, $0c, 1
	dbsprite -24,   0, $08, 1
	dbsprite -24,   8, $08, 1
	dbsprite -24,  16, $0d, 1
	dbsprite -16, -24, $0e, 1
	dbsprite -16, -16, $0f, 1
	dbsprite -16,  -8, $10, 1
	dbsprite -16,   0, $11, 1
	dbsprite -16,   8, $12, 1
	dbsprite -16,  16, $0d, 1 | OAM_YFLIP
	dbsprite  -8, -24, $09, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite  -8, -16, $13, 1
	dbsprite  -8,  -8, $14, 1
	dbsprite  -8,   0, $15, 1
	dbsprite  -8,   8, $0c, 1 | OAM_YFLIP
	dbsprite  -8,  16, $09, 1 | OAM_YFLIP
	dbsprite   0,  -8, $16, 1
	dbsprite   0,   8, $18, 1
	dbsprite   0,  16, $19, 1
	dbsprite   0,  21, $1a, 2
	dbsprite   0, -29, $1a, 2 | OAM_XFLIP
	dbsprite   0, -16, $18, 1 | OAM_XFLIP
	dbsprite   0, -24, $19, 1 | OAM_XFLIP
	dbsprite   0,   0, $17, 1

.frame_2
	db 38 ; size
	dbsprite -44, -24, $00, 0
	dbsprite -44, -16, $01, 0
	dbsprite -44,  -8, $02, 0
	dbsprite -44,   0, $03, 0
	dbsprite -44,   8, $04, 0
	dbsprite -44,  16, $00, 0 | OAM_XFLIP
	dbsprite -36, -24, $05, 0
	dbsprite -36, -16, $06, 0
	dbsprite -36,  -8, $07, 0
	dbsprite -36,   0, $08, 0
	dbsprite -36,   8, $08, 0
	dbsprite -36,  16, $09, 0
	dbsprite -28, -24, $0a, 0
	dbsprite -28, -16, $0b, 0
	dbsprite -28,  -8, $0c, 0
	dbsprite -28,   0, $08, 0
	dbsprite -28,   8, $08, 0
	dbsprite -28,  16, $0d, 0
	dbsprite -20, -24, $0e, 0
	dbsprite -20, -16, $0f, 0
	dbsprite -20,  -8, $10, 0
	dbsprite -20,   0, $11, 0
	dbsprite -20,   8, $12, 0
	dbsprite -20,  16, $0d, 0 | OAM_YFLIP
	dbsprite -12, -24, $09, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite -12, -16, $13, 0
	dbsprite -12,  -8, $14, 0
	dbsprite -12,   0, $15, 0
	dbsprite -12,   8, $0c, 0 | OAM_YFLIP
	dbsprite -12,  16, $09, 0 | OAM_YFLIP
	dbsprite  -4, -24, $00, 0 | OAM_YFLIP
	dbsprite  -4, -16, $04, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite  -4,   8, $04, 0 | OAM_YFLIP
	dbsprite  -4,  16, $00, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite  -2, -36, $1a, 2 | OAM_XFLIP
	dbsprite  -2,  28, $1a, 2
	dbsprite  -4,   0, $17, 0
	dbsprite  -4,  -8, $17, 0 | OAM_XFLIP

.frame_3
	db 36 ; size
	dbsprite -40, -24, $00, 0
	dbsprite -40, -16, $01, 0
	dbsprite -40,  -8, $02, 0
	dbsprite -40,   0, $03, 0
	dbsprite -40,   8, $04, 0
	dbsprite -40,  16, $00, 0 | OAM_XFLIP
	dbsprite -32, -24, $05, 0
	dbsprite -32, -16, $06, 0
	dbsprite -32,  -8, $07, 0
	dbsprite -32,   0, $08, 0
	dbsprite -32,   8, $08, 0
	dbsprite -32,  16, $09, 0
	dbsprite -24, -24, $0a, 0
	dbsprite -24, -16, $0b, 0
	dbsprite -24,  -8, $0c, 0
	dbsprite -24,   0, $08, 0
	dbsprite -24,   8, $08, 0
	dbsprite -24,  16, $0d, 0
	dbsprite -16, -24, $0e, 0
	dbsprite -16, -16, $0f, 0
	dbsprite -16,  -8, $10, 0
	dbsprite -16,   0, $11, 0
	dbsprite -16,   8, $12, 0
	dbsprite -16,  16, $0d, 0 | OAM_YFLIP
	dbsprite  -8, -24, $09, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite  -8, -16, $13, 0
	dbsprite  -8,  16, $09, 0 | OAM_YFLIP
	dbsprite   0, -24, $00, 0 | OAM_YFLIP
	dbsprite   0, -16, $04, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite   0,   8, $04, 0 | OAM_YFLIP
	dbsprite   0,  16, $00, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite  -8,  -8, $1b, 0
	dbsprite  -8,   0, $1c, 0
	dbsprite  -8,   8, $1d, 0
	dbsprite   0,  -8, $1e, 0
	dbsprite   0,   0, $1f, 0

.frame_4
	db 36 ; size
	dbsprite -40, -24, $00, 0
	dbsprite -40, -16, $01, 0
	dbsprite -40,   8, $04, 0
	dbsprite -40,  16, $00, 0 | OAM_XFLIP
	dbsprite -32, -24, $05, 0
	dbsprite -32,   8, $08, 0
	dbsprite -32,  16, $09, 0
	dbsprite -24, -24, $0a, 0
	dbsprite -24,   0, $08, 0
	dbsprite -24,   8, $08, 0
	dbsprite -24,  16, $0d, 0
	dbsprite -16, -24, $0e, 0
	dbsprite -16,  16, $0d, 0 | OAM_YFLIP
	dbsprite  -8, -24, $09, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite  -8,  16, $09, 0 | OAM_YFLIP
	dbsprite   0, -24, $00, 0 | OAM_YFLIP
	dbsprite   0, -16, $04, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite   0,   8, $04, 0 | OAM_YFLIP
	dbsprite   0,  16, $00, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite -40,  -8, $20, 0
	dbsprite -40,   0, $21, 0
	dbsprite -32, -16, $22, 0
	dbsprite -32,  -8, $23, 0
	dbsprite -32,   0, $24, 0
	dbsprite -24, -16, $25, 0
	dbsprite -24,  -8, $08, 0
	dbsprite -16, -16, $26, 0
	dbsprite -16,  -8, $27, 0
	dbsprite -16,   0, $28, 0
	dbsprite -16,   8, $29, 0
	dbsprite  -8, -16, $2a, 0
	dbsprite  -8,  -8, $2b, 0
	dbsprite  -8,   0, $2c, 0
	dbsprite  -8,   8, $2d, 0
	dbsprite   0,  -8, $2e, 0
	dbsprite   0,   0, $2f, 0

.frame_5
	db 36 ; size
	dbsprite -40, -24, $00, 0
	dbsprite -40, -16, $01, 0
	dbsprite -40,   8, $04, 0
	dbsprite -40,  16, $00, 0 | OAM_XFLIP
	dbsprite -32, -24, $05, 0
	dbsprite -32,   8, $08, 0
	dbsprite -32,  16, $09, 0
	dbsprite -24, -24, $0a, 0
	dbsprite -24,   0, $08, 0
	dbsprite -24,   8, $08, 0
	dbsprite -24,  16, $0d, 0
	dbsprite -16, -24, $0e, 0
	dbsprite -16,  16, $0d, 0 | OAM_YFLIP
	dbsprite  -8, -24, $09, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite  -8,  16, $09, 0 | OAM_YFLIP
	dbsprite   0, -24, $00, 0 | OAM_YFLIP
	dbsprite   0,   8, $04, 0 | OAM_YFLIP
	dbsprite   0,  16, $00, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite -40,   0, $21, 0
	dbsprite -40,  -8, $30, 0
	dbsprite -32, -16, $31, 0
	dbsprite -32,  -8, $32, 0
	dbsprite -32,   0, $33, 0
	dbsprite -24, -16, $34, 0
	dbsprite -24,  -8, $35, 0
	dbsprite -16, -16, $36, 0
	dbsprite -16,  -8, $37, 0
	dbsprite -16,   0, $38, 0
	dbsprite -16,   8, $08, 0
	dbsprite  -8, -16, $39, 0
	dbsprite  -8,  -8, $3a, 0
	dbsprite  -8,   0, $3b, 0
	dbsprite  -8,   8, $3c, 0
	dbsprite   0,  -8, $3e, 0
	dbsprite   0,   0, $3f, 0
	dbsprite   0, -16, $3d, 0

.frame_6
	db 36 ; size
	dbsprite -40, -24, $00, 0
	dbsprite -40, -16, $01, 0
	dbsprite -40,   8, $04, 0
	dbsprite -40,  16, $00, 0 | OAM_XFLIP
	dbsprite -32, -24, $05, 0
	dbsprite -32,   8, $08, 0
	dbsprite -32,  16, $09, 0
	dbsprite -24, -24, $0a, 0
	dbsprite -24,   0, $08, 0
	dbsprite -24,   8, $08, 0
	dbsprite -24,  16, $0d, 0
	dbsprite -16, -24, $0e, 0
	dbsprite -16,  16, $0d, 0 | OAM_YFLIP
	dbsprite  -8, -24, $09, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite  -8,  16, $09, 0 | OAM_YFLIP
	dbsprite   0, -24, $00, 0 | OAM_YFLIP
	dbsprite   0,  16, $00, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite -40,   0, $21, 0
	dbsprite -40,  -8, $30, 0
	dbsprite -32, -16, $31, 0
	dbsprite -16,   8, $08, 0
	dbsprite   0,  -8, $3e, 0
	dbsprite   0,   0, $3f, 0
	dbsprite   0, -16, $3d, 0
	dbsprite -32,  -8, $0c, 0 | OAM_YFLIP
	dbsprite -32,   0, $08, 0
	dbsprite -24, -16, $08, 0
	dbsprite -24,  -8, $08, 0
	dbsprite -16, -16, $40, 0
	dbsprite -16,  -8, $41, 0
	dbsprite -16,   0, $08, 0
	dbsprite  -8, -16, $42, 0
	dbsprite  -8,  -8, $43, 0
	dbsprite  -8,   0, $44, 0
	dbsprite  -8,   8, $45, 0
	dbsprite   0,   8, $46, 0

.frame_7
	db 36 ; size
	dbsprite -40, -24, $00, 0
	dbsprite -40, -16, $01, 0
	dbsprite -40,   8, $04, 0
	dbsprite -40,  16, $00, 0 | OAM_XFLIP
	dbsprite -32, -24, $05, 0
	dbsprite -32,   8, $08, 0
	dbsprite -32,  16, $09, 0
	dbsprite -24, -24, $0a, 0
	dbsprite -24,   0, $08, 0
	dbsprite -24,   8, $08, 0
	dbsprite -24,  16, $0d, 0
	dbsprite -16, -24, $0e, 0
	dbsprite -16,  16, $0d, 0 | OAM_YFLIP
	dbsprite  -8, -24, $09, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite  -8,  16, $09, 0 | OAM_YFLIP
	dbsprite   0, -24, $00, 0 | OAM_YFLIP
	dbsprite   0,  16, $00, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite -40,   0, $21, 0
	dbsprite -40,  -8, $30, 0
	dbsprite -32, -16, $31, 0
	dbsprite -16,   8, $08, 0
	dbsprite   0,  -8, $3e, 0
	dbsprite   0,   0, $3f, 0
	dbsprite   0, -16, $3d, 0
	dbsprite -32,  -8, $0c, 0 | OAM_YFLIP
	dbsprite -32,   0, $08, 0
	dbsprite -24, -16, $08, 0
	dbsprite -24,  -8, $08, 0
	dbsprite -16,   0, $08, 0
	dbsprite  -8,   8, $45, 0
	dbsprite   0,   8, $46, 0
	dbsprite -16, -16, $47, 0
	dbsprite -16,  -8, $48, 0
	dbsprite  -8, -16, $49, 0
	dbsprite  -8,  -8, $4a, 0
	dbsprite  -8,   0, $4b, 0

.frame_8
	db 36 ; size
	dbsprite -40, -24, $00, 1
	dbsprite -40, -16, $01, 1
	dbsprite -40,   8, $04, 1
	dbsprite -40,  16, $00, 1 | OAM_XFLIP
	dbsprite -32, -24, $05, 1
	dbsprite -32,   8, $08, 1
	dbsprite -32,  16, $09, 1
	dbsprite -24, -24, $0a, 1
	dbsprite -24,   0, $08, 1
	dbsprite -24,   8, $08, 1
	dbsprite -24,  16, $0d, 1
	dbsprite -16, -24, $0e, 1
	dbsprite -16,  16, $0d, 1 | OAM_YFLIP
	dbsprite  -8, -24, $09, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite  -8,  16, $09, 1 | OAM_YFLIP
	dbsprite   0, -24, $00, 1 | OAM_YFLIP
	dbsprite   0,  16, $00, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite -40,   0, $21, 1
	dbsprite -40,  -8, $30, 1
	dbsprite -32, -16, $31, 1
	dbsprite -16,   8, $08, 1
	dbsprite   0,  -8, $3e, 1
	dbsprite   0,   0, $3f, 1
	dbsprite   0, -16, $3d, 1
	dbsprite -32,  -8, $0c, 1 | OAM_YFLIP
	dbsprite -32,   0, $08, 1
	dbsprite -24, -16, $08, 1
	dbsprite -24,  -8, $08, 1
	dbsprite -16,   0, $08, 1
	dbsprite  -8,   8, $45, 1
	dbsprite   0,   8, $46, 1
	dbsprite -16, -16, $47, 1
	dbsprite -16,  -8, $48, 1
	dbsprite  -8, -16, $49, 1
	dbsprite  -8,  -8, $4a, 1
	dbsprite  -8,   0, $4b, 1

OAMData21::
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
	dbsprite  -9, -24, $03, 0 | OAM_YFLIP
	dbsprite  -9, -16, $04, 0 | OAM_YFLIP
	dbsprite -17, -16, $06, 0 | OAM_YFLIP
	dbsprite -25, -24, $07, 0 | OAM_YFLIP
	dbsprite -17, -24, $05, 0 | OAM_YFLIP

.frame_1
	db 8 ; size
	dbsprite  -9, -24, $03, 0 | OAM_YFLIP
	dbsprite  -9, -16, $04, 0 | OAM_YFLIP
	dbsprite -17, -16, $06, 0 | OAM_YFLIP
	dbsprite -25, -24, $07, 0 | OAM_YFLIP
	dbsprite -17, -24, $05, 0 | OAM_YFLIP
	dbsprite -13, -23, $00, 0 | OAM_YFLIP
	dbsprite -21, -23, $02, 0 | OAM_YFLIP
	dbsprite -21, -31, $01, 0 | OAM_YFLIP

.frame_2
	db 3 ; size
	dbsprite -13, -23, $00, 0 | OAM_YFLIP
	dbsprite -21, -23, $02, 0 | OAM_YFLIP
	dbsprite -21, -31, $01, 0 | OAM_YFLIP

.frame_3
	db 8 ; size
	dbsprite   8,  16, $03, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite   8,   8, $04, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite   0,   8, $06, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite  -8,  16, $07, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite   0,  16, $05, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite -13, -23, $00, 0 | OAM_YFLIP
	dbsprite -21, -23, $02, 0 | OAM_YFLIP
	dbsprite -21, -31, $01, 0 | OAM_YFLIP

.frame_4
	db 11 ; size
	dbsprite   8,  16, $03, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite   8,   8, $04, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite   0,   8, $06, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite  -8,  16, $07, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite   0,  16, $05, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite -13, -23, $00, 0 | OAM_YFLIP
	dbsprite -21, -23, $02, 0 | OAM_YFLIP
	dbsprite -21, -31, $01, 0 | OAM_YFLIP
	dbsprite   8,  24, $01, 0 | OAM_XFLIP
	dbsprite   0,  16, $00, 0 | OAM_XFLIP
	dbsprite   8,  16, $02, 0 | OAM_XFLIP

.frame_5
	db 6 ; size
	dbsprite   8,  24, $01, 0 | OAM_XFLIP
	dbsprite   0,  16, $00, 0 | OAM_XFLIP
	dbsprite   8,  16, $02, 0 | OAM_XFLIP
	dbsprite -13, -23, $00, 0 | OAM_YFLIP
	dbsprite -21, -23, $02, 0 | OAM_YFLIP
	dbsprite -21, -31, $01, 0 | OAM_YFLIP

.frame_6
	db 11 ; size
	dbsprite   2, -17, $03, 0
	dbsprite   2,  -9, $04, 0
	dbsprite  10,  -9, $06, 0
	dbsprite  10, -17, $05, 0
	dbsprite  18, -17, $07, 0
	dbsprite   8,  24, $01, 0 | OAM_XFLIP
	dbsprite   0,  16, $00, 0 | OAM_XFLIP
	dbsprite   8,  16, $02, 0 | OAM_XFLIP
	dbsprite -13, -23, $00, 0 | OAM_YFLIP
	dbsprite -21, -23, $02, 0 | OAM_YFLIP
	dbsprite -21, -31, $01, 0 | OAM_YFLIP

.frame_7
	db 14 ; size
	dbsprite   2, -17, $03, 0
	dbsprite   2,  -9, $04, 0
	dbsprite  10,  -9, $06, 0
	dbsprite  10, -17, $05, 0
	dbsprite   8,  24, $01, 0 | OAM_XFLIP
	dbsprite   0,  16, $00, 0 | OAM_XFLIP
	dbsprite   8,  16, $02, 0 | OAM_XFLIP
	dbsprite  18, -17, $07, 0
	dbsprite   5, -16, $00, 0
	dbsprite  13, -16, $02, 0
	dbsprite  13, -24, $01, 0
	dbsprite -13, -23, $00, 0 | OAM_YFLIP
	dbsprite -21, -23, $02, 0 | OAM_YFLIP
	dbsprite -21, -31, $01, 0 | OAM_YFLIP

.frame_8
	db 9 ; size
	dbsprite   8,  24, $01, 0 | OAM_XFLIP
	dbsprite   0,  16, $00, 0 | OAM_XFLIP
	dbsprite   8,  16, $02, 0 | OAM_XFLIP
	dbsprite   5, -16, $00, 0
	dbsprite  13, -16, $02, 0
	dbsprite  13, -24, $01, 0
	dbsprite -13, -23, $00, 0 | OAM_YFLIP
	dbsprite -21, -23, $02, 0 | OAM_YFLIP
	dbsprite -21, -31, $01, 0 | OAM_YFLIP

OAMData22::
	dw .frame_0
	dw .frame_1
	dw .frame_2
	dw .frame_3
	dw .frame_4
	dw .frame_5
	dw .frame_6
	dw .frame_7

.frame_0
	db 16 ; size
	dbsprite -10, -32, $00, 0
	dbsprite -10, -24, $00, 0 | OAM_XFLIP
	dbsprite  -6, -16, $00, 0 | OAM_XFLIP
	dbsprite  -6,  -8, $00, 0
	dbsprite -10,   8, $00, 0 | OAM_XFLIP
	dbsprite -10,   0, $00, 0
	dbsprite  -6,  16, $00, 0 | OAM_XFLIP
	dbsprite  -6,  24, $00, 0
	dbsprite  -2, -32, $06, 0 | OAM_XFLIP
	dbsprite  -2, -24, $06, 0
	dbsprite   2, -16, $06, 0
	dbsprite   2,  -8, $06, 0 | OAM_XFLIP
	dbsprite  -2,   0, $06, 0 | OAM_XFLIP
	dbsprite  -2,   8, $06, 0
	dbsprite   1,  16, $06, 0
	dbsprite   1,  24, $06, 0 | OAM_XFLIP

.frame_1
	db 32 ; size
	dbsprite -14, -32, $00, 0
	dbsprite  -6, -32, $01, 0
	dbsprite   2, -32, $05, 0 | OAM_XFLIP
	dbsprite  10, -32, $06, 1 | OAM_XFLIP
	dbsprite -18, -24, $00, 0
	dbsprite -10, -24, $01, 0
	dbsprite  -2, -24, $05, 0 | OAM_XFLIP
	dbsprite   6, -24, $06, 1 | OAM_XFLIP
	dbsprite -18, -16, $00, 0 | OAM_XFLIP
	dbsprite -10, -16, $01, 0 | OAM_XFLIP
	dbsprite  -2, -16, $05, 0
	dbsprite   6, -16, $06, 1
	dbsprite -14,  -8, $00, 0 | OAM_XFLIP
	dbsprite  -6,  -8, $01, 0 | OAM_XFLIP
	dbsprite   2,  -8, $05, 0
	dbsprite  10,  -8, $06, 1
	dbsprite -14,   0, $00, 0
	dbsprite  -6,   0, $01, 0
	dbsprite   2,   0, $05, 0 | OAM_XFLIP
	dbsprite  10,   0, $06, 1 | OAM_XFLIP
	dbsprite -18,   8, $00, 0
	dbsprite -10,   8, $01, 0
	dbsprite  -2,   8, $05, 0 | OAM_XFLIP
	dbsprite   6,   8, $06, 1 | OAM_XFLIP
	dbsprite -18,  16, $00, 0 | OAM_XFLIP
	dbsprite -10,  16, $01, 0 | OAM_XFLIP
	dbsprite  -2,  16, $05, 0
	dbsprite   6,  16, $06, 1
	dbsprite -14,  24, $00, 0 | OAM_XFLIP
	dbsprite  -6,  24, $01, 0 | OAM_XFLIP
	dbsprite   2,  24, $05, 0
	dbsprite  10,  24, $06, 1

.frame_2
	db 40 ; size
	dbsprite  -6,  24, $02, 1 | OAM_XFLIP
	dbsprite  -6,  16, $02, 1
	dbsprite  -2,   8, $02, 1 | OAM_XFLIP
	dbsprite  -2,   0, $02, 1
	dbsprite  -6,  -8, $02, 1 | OAM_XFLIP
	dbsprite  -6, -16, $02, 1
	dbsprite  -2, -24, $02, 1 | OAM_XFLIP
	dbsprite  -2, -32, $02, 1
	dbsprite -18, -32, $00, 0 | OAM_XFLIP
	dbsprite -10, -32, $01, 0 | OAM_XFLIP
	dbsprite   6, -32, $05, 1 | OAM_XFLIP
	dbsprite  14, -32, $06, 1 | OAM_XFLIP
	dbsprite -18, -24, $00, 0
	dbsprite -10, -24, $01, 0
	dbsprite   6, -24, $05, 1
	dbsprite  14, -24, $06, 1
	dbsprite -22, -16, $00, 0
	dbsprite -14, -16, $01, 0
	dbsprite   2, -16, $05, 1
	dbsprite  10, -16, $06, 1
	dbsprite -22,  -8, $00, 0 | OAM_XFLIP
	dbsprite -14,  -8, $01, 0 | OAM_XFLIP
	dbsprite   2,  -8, $05, 1 | OAM_XFLIP
	dbsprite  10,  -8, $06, 1 | OAM_XFLIP
	dbsprite -18,   0, $00, 0 | OAM_XFLIP
	dbsprite -10,   0, $01, 0 | OAM_XFLIP
	dbsprite   6,   0, $05, 1 | OAM_XFLIP
	dbsprite  14,   0, $06, 1 | OAM_XFLIP
	dbsprite -18,   8, $00, 0
	dbsprite -10,   8, $01, 0
	dbsprite   6,   8, $05, 1
	dbsprite  14,   8, $06, 1
	dbsprite -22,  16, $00, 0
	dbsprite -14,  16, $01, 0
	dbsprite   2,  16, $05, 1
	dbsprite  10,  16, $06, 1
	dbsprite -22,  24, $00, 0 | OAM_XFLIP
	dbsprite -14,  24, $01, 0 | OAM_XFLIP
	dbsprite   2,  24, $05, 1 | OAM_XFLIP
	dbsprite  10,  24, $06, 1 | OAM_XFLIP

.frame_3
	db 40 ; size
	dbsprite  -6,  24, $01, 1
	dbsprite  -2,  16, $01, 1 | OAM_XFLIP
	dbsprite  -2,   8, $01, 1
	dbsprite  -6,   0, $01, 1 | OAM_XFLIP
	dbsprite  -6,  -8, $01, 1
	dbsprite  -2, -16, $01, 1 | OAM_XFLIP
	dbsprite  -2, -24, $01, 1
	dbsprite  -6, -32, $01, 1 | OAM_XFLIP
	dbsprite -14, -32, $02, 0 | OAM_XFLIP
	dbsprite -22, -32, $00, 0 | OAM_XFLIP
	dbsprite   2, -32, $04, 1
	dbsprite  10, -32, $06, 1
	dbsprite -10, -24, $02, 0 | OAM_XFLIP
	dbsprite -18, -24, $00, 0 | OAM_XFLIP
	dbsprite   6, -24, $04, 1
	dbsprite  14, -24, $06, 1
	dbsprite -10, -16, $02, 0
	dbsprite -18, -16, $00, 0
	dbsprite   6, -16, $04, 1 | OAM_XFLIP
	dbsprite  14, -16, $06, 1 | OAM_XFLIP
	dbsprite -14,  -8, $02, 0
	dbsprite -22,  -8, $00, 0
	dbsprite   2,  -8, $04, 1 | OAM_XFLIP
	dbsprite  10,  -8, $06, 1 | OAM_XFLIP
	dbsprite -14,   0, $02, 0 | OAM_XFLIP
	dbsprite -22,   0, $00, 0 | OAM_XFLIP
	dbsprite   2,   0, $04, 1
	dbsprite  10,   0, $06, 1
	dbsprite -10,   8, $02, 0 | OAM_XFLIP
	dbsprite -18,   8, $00, 0 | OAM_XFLIP
	dbsprite   6,   8, $04, 1
	dbsprite  14,   8, $06, 1
	dbsprite -10,  16, $02, 0
	dbsprite -18,  16, $00, 0
	dbsprite   6,  16, $04, 1 | OAM_XFLIP
	dbsprite  14,  16, $06, 1 | OAM_XFLIP
	dbsprite -14,  24, $02, 0
	dbsprite -22,  24, $00, 0
	dbsprite   2,  24, $04, 1 | OAM_XFLIP
	dbsprite  10,  24, $06, 1 | OAM_XFLIP

.frame_4
	db 40 ; size
	dbsprite  -2,  24, $02, 1 | OAM_XFLIP
	dbsprite  -2,  16, $02, 1
	dbsprite  -6,   8, $02, 1 | OAM_XFLIP
	dbsprite  -6,   0, $02, 1
	dbsprite  -2,  -8, $02, 1 | OAM_XFLIP
	dbsprite  -2, -16, $02, 1
	dbsprite  -6, -24, $02, 1 | OAM_XFLIP
	dbsprite  -6, -32, $02, 1
	dbsprite -22, -32, $01, 0
	dbsprite -14, -32, $02, 0
	dbsprite   2, -32, $04, 1
	dbsprite  10, -32, $05, 1
	dbsprite -18, -16, $01, 0 | OAM_XFLIP
	dbsprite -10, -16, $02, 0 | OAM_XFLIP
	dbsprite   2, -24, $04, 1 | OAM_XFLIP
	dbsprite  10, -24, $05, 1 | OAM_XFLIP
	dbsprite -22, -24, $01, 0 | OAM_XFLIP
	dbsprite -14, -24, $02, 0 | OAM_XFLIP
	dbsprite   6, -16, $04, 1 | OAM_XFLIP
	dbsprite  14, -16, $05, 1 | OAM_XFLIP
	dbsprite -18,  -8, $01, 0
	dbsprite -10,  -8, $02, 0
	dbsprite   6,  -8, $04, 1
	dbsprite  14,  -8, $05, 1
	dbsprite -22,   0, $01, 0
	dbsprite -14,   0, $02, 0
	dbsprite   2,   0, $04, 1
	dbsprite  10,   0, $05, 1
	dbsprite -18,  16, $01, 0 | OAM_XFLIP
	dbsprite -10,  16, $02, 0 | OAM_XFLIP
	dbsprite   2,   8, $04, 1 | OAM_XFLIP
	dbsprite  10,   8, $05, 1 | OAM_XFLIP
	dbsprite -22,   8, $01, 0 | OAM_XFLIP
	dbsprite -14,   8, $02, 0 | OAM_XFLIP
	dbsprite   6,  16, $04, 1 | OAM_XFLIP
	dbsprite  14,  16, $05, 1 | OAM_XFLIP
	dbsprite -18,  24, $01, 0
	dbsprite -10,  24, $02, 0
	dbsprite   6,  24, $04, 1
	dbsprite  14,  24, $05, 1

.frame_5
	db 40 ; size
	dbsprite  -2,  24, $02, 1
	dbsprite  -6,  16, $02, 1 | OAM_XFLIP
	dbsprite  -6,   8, $02, 1
	dbsprite  -2,   0, $02, 1 | OAM_XFLIP
	dbsprite  -2,  -8, $02, 1
	dbsprite  -6, -16, $02, 1 | OAM_XFLIP
	dbsprite  -6, -24, $02, 1
	dbsprite  -2, -32, $02, 1 | OAM_XFLIP
	dbsprite -22, -24, $01, 0
	dbsprite -14, -24, $02, 0
	dbsprite   2, -24, $04, 1
	dbsprite  10, -24, $05, 1
	dbsprite -18,  -8, $01, 0 | OAM_XFLIP
	dbsprite -10,  -8, $02, 0 | OAM_XFLIP
	dbsprite   2, -16, $04, 1 | OAM_XFLIP
	dbsprite  10, -16, $05, 1 | OAM_XFLIP
	dbsprite -22, -16, $01, 0 | OAM_XFLIP
	dbsprite -14, -16, $02, 0 | OAM_XFLIP
	dbsprite   6,  -8, $04, 1 | OAM_XFLIP
	dbsprite  14,  -8, $05, 1 | OAM_XFLIP
	dbsprite -18,   0, $01, 0
	dbsprite -10,   0, $02, 0
	dbsprite   6,   0, $04, 1
	dbsprite  14,   0, $05, 1
	dbsprite -22,   8, $01, 0
	dbsprite -14,   8, $02, 0
	dbsprite   2,   8, $04, 1
	dbsprite  10,   8, $05, 1
	dbsprite -18,  24, $01, 0 | OAM_XFLIP
	dbsprite -10,  24, $02, 0 | OAM_XFLIP
	dbsprite   2,  16, $04, 1 | OAM_XFLIP
	dbsprite  10,  16, $05, 1 | OAM_XFLIP
	dbsprite -22,  16, $01, 0 | OAM_XFLIP
	dbsprite -14,  16, $02, 0 | OAM_XFLIP
	dbsprite   6,  24, $04, 1 | OAM_XFLIP
	dbsprite  14,  24, $05, 1 | OAM_XFLIP
	dbsprite -18, -32, $01, 0
	dbsprite -10, -32, $02, 0
	dbsprite   6, -32, $04, 1
	dbsprite  14, -32, $05, 1

.frame_6
	db 40 ; size
	dbsprite  -6,  24, $02, 1 | OAM_XFLIP
	dbsprite  -6,  16, $02, 1
	dbsprite  -2,   8, $02, 1 | OAM_XFLIP
	dbsprite  -2,   0, $02, 1
	dbsprite  -6,  -8, $02, 1 | OAM_XFLIP
	dbsprite  -6, -16, $02, 1
	dbsprite  -2, -24, $02, 1 | OAM_XFLIP
	dbsprite  -2, -32, $02, 1
	dbsprite -22, -16, $01, 0
	dbsprite -14, -16, $02, 0
	dbsprite   2, -16, $04, 1
	dbsprite  10, -16, $05, 1
	dbsprite -18,   0, $01, 0 | OAM_XFLIP
	dbsprite -10,   0, $02, 0 | OAM_XFLIP
	dbsprite   2,  -8, $04, 1 | OAM_XFLIP
	dbsprite  10,  -8, $05, 1 | OAM_XFLIP
	dbsprite -22,  -8, $01, 0 | OAM_XFLIP
	dbsprite -14,  -8, $02, 0 | OAM_XFLIP
	dbsprite   6,   0, $04, 1 | OAM_XFLIP
	dbsprite  14,   0, $05, 1 | OAM_XFLIP
	dbsprite -18,   8, $01, 0
	dbsprite -10,   8, $02, 0
	dbsprite   6,   8, $04, 1
	dbsprite  14,   8, $05, 1
	dbsprite -22,  16, $01, 0
	dbsprite -14,  16, $02, 0
	dbsprite   2,  16, $04, 1
	dbsprite  10,  16, $05, 1
	dbsprite   2,  24, $04, 1 | OAM_XFLIP
	dbsprite  10,  24, $05, 1 | OAM_XFLIP
	dbsprite -22,  24, $01, 0 | OAM_XFLIP
	dbsprite -14,  24, $02, 0 | OAM_XFLIP
	dbsprite -18, -24, $01, 0
	dbsprite -10, -24, $02, 0
	dbsprite   6, -24, $04, 1
	dbsprite  14, -24, $05, 1
	dbsprite -18, -32, $01, 0 | OAM_XFLIP
	dbsprite -10, -32, $02, 0 | OAM_XFLIP
	dbsprite   6, -32, $04, 1 | OAM_XFLIP
	dbsprite  14, -32, $05, 1 | OAM_XFLIP

.frame_7
	db 40 ; size
	dbsprite  -6,  24, $02, 1
	dbsprite  -2,  16, $02, 1 | OAM_XFLIP
	dbsprite  -2,   8, $02, 1
	dbsprite  -6,   0, $02, 1 | OAM_XFLIP
	dbsprite  -6,  -8, $02, 1
	dbsprite  -2, -16, $02, 1 | OAM_XFLIP
	dbsprite  -2, -24, $02, 1
	dbsprite  -6, -32, $02, 1 | OAM_XFLIP
	dbsprite -22,  -8, $01, 0
	dbsprite -14,  -8, $02, 0
	dbsprite   2,  -8, $04, 1
	dbsprite  10,  -8, $05, 1
	dbsprite -18,   8, $01, 0 | OAM_XFLIP
	dbsprite -10,   8, $02, 0 | OAM_XFLIP
	dbsprite   2,   0, $04, 1 | OAM_XFLIP
	dbsprite  10,   0, $05, 1 | OAM_XFLIP
	dbsprite -22,   0, $01, 0 | OAM_XFLIP
	dbsprite -14,   0, $02, 0 | OAM_XFLIP
	dbsprite   6,   8, $04, 1 | OAM_XFLIP
	dbsprite  14,   8, $05, 1 | OAM_XFLIP
	dbsprite -18,  16, $01, 0
	dbsprite -10,  16, $02, 0
	dbsprite   6,  16, $04, 1
	dbsprite  14,  16, $05, 1
	dbsprite -22,  24, $01, 0
	dbsprite -14,  24, $02, 0
	dbsprite   2,  24, $04, 1
	dbsprite  10,  24, $05, 1
	dbsprite -18, -16, $01, 0
	dbsprite -10, -16, $02, 0
	dbsprite   6, -16, $04, 1
	dbsprite  14, -16, $05, 1
	dbsprite -18, -24, $01, 0 | OAM_XFLIP
	dbsprite -10, -24, $02, 0 | OAM_XFLIP
	dbsprite   6, -24, $04, 1 | OAM_XFLIP
	dbsprite  14, -24, $05, 1 | OAM_XFLIP
	dbsprite   2, -32, $04, 1 | OAM_XFLIP
	dbsprite  10, -32, $05, 1 | OAM_XFLIP
	dbsprite -22, -32, $01, 0 | OAM_XFLIP
	dbsprite -14, -32, $02, 0 | OAM_XFLIP

OAMData23::
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
	dbsprite -24,  -8, $00, 0
	dbsprite -24,  24, $00, 0
	dbsprite -16,   8, $00, 0
	dbsprite -16, -30, $00, 0

.frame_1
	db 6 ; size
	dbsprite -16,   0, $00, 0
	dbsprite -21, -16, $00, 0
	dbsprite -26,  16, $00, 0
	dbsprite -16,  28, $00, 0
	dbsprite  -8,   8, $00, 1
	dbsprite  -8, -32, $00, 1

.frame_2
	db 8 ; size
	dbsprite  -8,   4, $00, 1
	dbsprite -13, -22, $00, 0
	dbsprite -20,  20, $00, 0
	dbsprite  -8,  24, $00, 1
	dbsprite -24,  -8, $00, 0
	dbsprite   0,   0, $00, 1
	dbsprite  -3, -26, $00, 1
	dbsprite -24, -24, $00, 0

.frame_3
	db 9 ; size
	dbsprite   5,   2, $00, 2
	dbsprite  -5, -24, $00, 1
	dbsprite -13,  23, $00, 0
	dbsprite   0,  20, $00, 1
	dbsprite -16,  -4, $00, 0
	dbsprite   8,  -8, $00, 2
	dbsprite   0, -24, $00, 1
	dbsprite -18, -16, $00, 0
	dbsprite -24,   8, $00, 0

.frame_4
	db 8 ; size
	dbsprite  16,  -2, $00, 2
	dbsprite  10, -22, $00, 2
	dbsprite  -1,  18, $00, 1
	dbsprite   8,  20, $00, 2 | OAM_YFLIP
	dbsprite  -8,  -8, $00, 1
	dbsprite   4, -28, $00, 1
	dbsprite -12, -20, $00, 0
	dbsprite -16,  11, $00, 0

.frame_5
	db 7 ; size
	dbsprite   9,  13, $00, 2
	dbsprite  16,  18, $00, 2
	dbsprite   0,  -8, $00, 1
	dbsprite  16, -16, $00, 2
	dbsprite  -4, -22, $00, 1
	dbsprite  -8,   8, $00, 1
	dbsprite   8, -32, $00, 2

.frame_6
	db 5 ; size
	dbsprite   8,  -4, $00, 2
	dbsprite  19,  16, $00, 2
	dbsprite   0, -24, $00, 1
	dbsprite   0,   4, $00, 1
	dbsprite  12, -32, $00, 2

.frame_7
	db 4 ; size
	dbsprite  16,   0, $00, 2
	dbsprite   8, -20, $00, 2
	dbsprite   8,   8, $00, 2
	dbsprite  16, -32, $00, 2

OAMData24::
	dw .frame_0
	dw .frame_1
	dw .frame_2
	dw .frame_3
	dw .frame_4
	dw .frame_5
	dw .frame_6

.frame_0
	db 9 ; size
	dbsprite -12, -13, $00, 1
	dbsprite -12,  -5, $01, 1
	dbsprite -12,   3, $02, 0
	dbsprite  -4, -13, $03, 1
	dbsprite  -4,  -5, $04, 1
	dbsprite  -4,   3, $05, 0
	dbsprite   4, -13, $06, 0
	dbsprite   4,  -5, $07, 0
	dbsprite   4,   3, $08, 0

.frame_1
	db 9 ; size
	dbsprite   4,   4, $00, 2 | OAM_XFLIP | OAM_YFLIP
	dbsprite   4,  -4, $01, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite   4, -12, $02, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite  -4,   4, $03, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite  -4,  -4, $04, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite  -4, -12, $05, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite -12,   4, $06, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite -12,  -4, $07, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite -12, -12, $08, 1 | OAM_XFLIP | OAM_YFLIP

.frame_2
	db 16 ; size
	dbsprite -20,   4, $09, 0
	dbsprite -12,  -4, $0a, 1
	dbsprite -12,   4, $0b, 0
	dbsprite -12,  12, $0c, 0
	dbsprite  -4,   4, $0d, 0
	dbsprite  12, -12, $09, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite   4, -12, $0b, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite   4, -20, $0c, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite  -4, -12, $0d, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite -20, -12, $09, 1 | OAM_XFLIP
	dbsprite -12, -12, $0b, 1 | OAM_XFLIP
	dbsprite -12, -20, $0c, 1 | OAM_XFLIP
	dbsprite  12,   4, $09, 2 | OAM_YFLIP
	dbsprite   4,  -4, $0a, 0 | OAM_YFLIP
	dbsprite   4,   4, $0b, 2 | OAM_YFLIP
	dbsprite   4,  12, $0c, 2 | OAM_YFLIP

.frame_3
	db 20 ; size
	dbsprite  12, -12, $0e, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite  12, -20, $0f, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite   4,  -4, $10, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite   4, -12, $11, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite   4, -20, $12, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite  -4, -12, $13, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite -20,   4, $0e, 0
	dbsprite -20,  12, $0f, 0
	dbsprite -12,  -4, $10, 1
	dbsprite -12,   4, $11, 0
	dbsprite -12,  12, $12, 0
	dbsprite  -4,   4, $13, 0
	dbsprite -20, -12, $0e, 1 | OAM_XFLIP
	dbsprite -20, -20, $0f, 1 | OAM_XFLIP
	dbsprite -12, -12, $11, 1 | OAM_XFLIP
	dbsprite -12, -20, $12, 1 | OAM_XFLIP
	dbsprite  12,   4, $0e, 2 | OAM_YFLIP
	dbsprite  12,  12, $0f, 2 | OAM_YFLIP
	dbsprite   4,   4, $11, 2 | OAM_YFLIP
	dbsprite   4,  12, $12, 2 | OAM_YFLIP

.frame_4
	db 20 ; size
	dbsprite  16, -16, $14, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite  16, -24, $15, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite   8,  -8, $16, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite   8, -16, $17, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite   8, -24, $18, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite   0, -16, $19, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite -16,   0, $14, 0
	dbsprite -16,   8, $15, 0
	dbsprite  -8,  -8, $16, 1
	dbsprite  -8,   0, $17, 0
	dbsprite  -8,   8, $18, 0
	dbsprite   0,   0, $19, 0
	dbsprite -16, -16, $14, 1 | OAM_XFLIP
	dbsprite -16, -24, $15, 1 | OAM_XFLIP
	dbsprite  -8, -16, $17, 1 | OAM_XFLIP
	dbsprite  -8, -24, $18, 1 | OAM_XFLIP
	dbsprite  16,   0, $14, 2 | OAM_YFLIP
	dbsprite  16,   8, $15, 2 | OAM_YFLIP
	dbsprite   8,   0, $17, 2 | OAM_YFLIP
	dbsprite   8,   8, $18, 2 | OAM_YFLIP

.frame_5
	db 4 ; size
	dbsprite   0,   0, $00, 2 | OAM_XFLIP | OAM_YFLIP
	dbsprite   0,  -8, $02, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite  -8,   1, $06, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite  -8,  -7, $08, 1 | OAM_XFLIP | OAM_YFLIP

.frame_6
	db 4 ; size
	dbsprite  -8,  -8, $00, 1
	dbsprite  -8,   0, $02, 0
	dbsprite   0,  -9, $06, 0
	dbsprite   0,  -1, $08, 0

OAMData25::
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
	db 6 ; size
	dbsprite -20, -28, $02, 0
	dbsprite -12,  12, $00, 0
	dbsprite   0, -16, $03, 0
	dbsprite   0,  -8, $03, 0 | OAM_XFLIP
	dbsprite   8, -16, $03, 0 | OAM_YFLIP
	dbsprite   8,  -8, $03, 0 | OAM_XFLIP | OAM_YFLIP

.frame_1
	db 9 ; size
	dbsprite -12,  12, $02, 0
	dbsprite   0, -16, $05, 0
	dbsprite   0,  -8, $05, 0 | OAM_XFLIP
	dbsprite   8, -16, $05, 0 | OAM_YFLIP
	dbsprite   8,  -8, $05, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite -24, -32, $04, 0
	dbsprite -24, -24, $04, 0 | OAM_XFLIP
	dbsprite -16, -24, $04, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite -16, -32, $04, 0 | OAM_YFLIP

.frame_2
	db 12 ; size
	dbsprite -16,   8, $04, 0
	dbsprite -16,  16, $04, 0 | OAM_XFLIP
	dbsprite  -8,  16, $04, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite  -8,   8, $04, 0 | OAM_YFLIP
	dbsprite   0, -16, $06, 0
	dbsprite   0,  -8, $06, 0 | OAM_XFLIP
	dbsprite   8, -16, $06, 0 | OAM_YFLIP
	dbsprite   8,  -8, $06, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite -24, -32, $07, 0
	dbsprite -24, -24, $07, 0 | OAM_XFLIP
	dbsprite -16, -24, $07, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite -16, -32, $07, 0 | OAM_YFLIP

.frame_3
	db 12 ; size
	dbsprite -24, -32, $06, 0
	dbsprite -24, -24, $06, 0 | OAM_XFLIP
	dbsprite -16, -32, $06, 0 | OAM_YFLIP
	dbsprite -16, -24, $06, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite   0, -16, $07, 0
	dbsprite   0,  -8, $07, 0 | OAM_XFLIP
	dbsprite   8,  -8, $07, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite   8, -16, $07, 0 | OAM_YFLIP
	dbsprite -16,   8, $06, 0
	dbsprite -16,  16, $06, 0 | OAM_XFLIP
	dbsprite  -8,   8, $06, 0 | OAM_YFLIP
	dbsprite  -8,  16, $06, 0 | OAM_XFLIP | OAM_YFLIP

.frame_4
	db 12 ; size
	dbsprite   0, -16, $06, 0
	dbsprite   0,  -8, $06, 0 | OAM_XFLIP
	dbsprite   8, -16, $06, 0 | OAM_YFLIP
	dbsprite   8,  -8, $06, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite -24, -32, $07, 0
	dbsprite -24, -24, $07, 0 | OAM_XFLIP
	dbsprite -16, -24, $07, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite -16, -32, $07, 0 | OAM_YFLIP
	dbsprite -16,   8, $07, 0
	dbsprite -16,  16, $07, 0 | OAM_XFLIP
	dbsprite  -8,  16, $07, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite  -8,   8, $07, 0 | OAM_YFLIP

.frame_5
	db 15 ; size
	dbsprite -24, -32, $06, 0
	dbsprite -24, -24, $06, 0 | OAM_XFLIP
	dbsprite -16, -32, $06, 0 | OAM_YFLIP
	dbsprite -16, -24, $06, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite   0, -16, $07, 0
	dbsprite   0,  -8, $07, 0 | OAM_XFLIP
	dbsprite   8,  -8, $07, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite   8, -16, $07, 0 | OAM_YFLIP
	dbsprite -16,   8, $06, 0
	dbsprite -16,  16, $06, 0 | OAM_XFLIP
	dbsprite  -8,   8, $06, 0 | OAM_YFLIP
	dbsprite  -8,  16, $06, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite -24,   0, $00, 0
	dbsprite  -8, -16, $00, 0
	dbsprite   8,  24, $00, 0

.frame_6
	db 16 ; size
	dbsprite   0, -16, $06, 0
	dbsprite   0,  -8, $06, 0 | OAM_XFLIP
	dbsprite   8, -16, $06, 0 | OAM_YFLIP
	dbsprite   8,  -8, $06, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite -24, -32, $07, 0
	dbsprite -24, -24, $07, 0 | OAM_XFLIP
	dbsprite -16, -24, $07, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite -16, -32, $07, 0 | OAM_YFLIP
	dbsprite -16,   8, $07, 0
	dbsprite -16,  16, $07, 0 | OAM_XFLIP
	dbsprite  -8,  16, $07, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite  -8,   8, $07, 0 | OAM_YFLIP
	dbsprite  -8, -16, $01, 0
	dbsprite -24,   0, $01, 0
	dbsprite   8,  24, $01, 0
	dbsprite  16, -32, $00, 0

.frame_7
	db 16 ; size
	dbsprite -24, -32, $06, 0
	dbsprite -24, -24, $06, 0 | OAM_XFLIP
	dbsprite -16, -32, $06, 0 | OAM_YFLIP
	dbsprite -16, -24, $06, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite -16,   8, $06, 0
	dbsprite -16,  16, $06, 0 | OAM_XFLIP
	dbsprite  -8,   8, $06, 0 | OAM_YFLIP
	dbsprite  -8,  16, $06, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite  16, -32, $01, 0
	dbsprite  -8, -16, $02, 0
	dbsprite -24,   0, $02, 0
	dbsprite   8,  24, $02, 0
	dbsprite   0, -16, $08, 0
	dbsprite   0,  -8, $08, 0 | OAM_XFLIP
	dbsprite   8, -16, $08, 0 | OAM_YFLIP
	dbsprite   8,  -8, $08, 0 | OAM_XFLIP | OAM_YFLIP

.frame_8
	db 25 ; size
	dbsprite -16,   8, $07, 0
	dbsprite -16,  16, $07, 0 | OAM_XFLIP
	dbsprite  -8,  16, $07, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite  -8,   8, $07, 0 | OAM_YFLIP
	dbsprite  16, -32, $02, 0
	dbsprite  -2, -18, $09, 0
	dbsprite  -2,  -6, $09, 0 | OAM_XFLIP
	dbsprite  10, -18, $09, 0 | OAM_YFLIP
	dbsprite  10,  -6, $09, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite -12, -20, $03, 0
	dbsprite -12, -12, $03, 0 | OAM_XFLIP
	dbsprite  -4, -20, $03, 0 | OAM_YFLIP
	dbsprite  -4, -12, $03, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite   4,  20, $03, 0
	dbsprite   4,  28, $03, 0 | OAM_XFLIP
	dbsprite  12,  20, $03, 0 | OAM_YFLIP
	dbsprite  12,  28, $03, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite -28,  -4, $03, 0
	dbsprite -28,   4, $03, 0 | OAM_XFLIP
	dbsprite -20,  -4, $03, 0 | OAM_YFLIP
	dbsprite -20,   4, $03, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite -24, -32, $08, 0
	dbsprite -24, -24, $08, 0 | OAM_XFLIP
	dbsprite -16, -32, $08, 0 | OAM_YFLIP
	dbsprite -16, -24, $08, 0 | OAM_XFLIP | OAM_YFLIP

.frame_9
	db 24 ; size
	dbsprite -26, -34, $09, 0
	dbsprite -26, -22, $09, 0 | OAM_XFLIP
	dbsprite -14, -34, $09, 0 | OAM_YFLIP
	dbsprite -14, -22, $09, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite -16,   8, $08, 0
	dbsprite -16,  16, $08, 0 | OAM_XFLIP
	dbsprite  -8,   8, $08, 0 | OAM_YFLIP
	dbsprite  -8,  16, $08, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite  12, -36, $03, 0
	dbsprite  12, -28, $03, 0 | OAM_XFLIP
	dbsprite  20, -36, $03, 0 | OAM_YFLIP
	dbsprite  20, -28, $03, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite -12, -20, $04, 0
	dbsprite -12, -12, $04, 0 | OAM_XFLIP
	dbsprite  -4, -20, $04, 0 | OAM_YFLIP
	dbsprite  -4, -12, $04, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite -28,  -4, $04, 0
	dbsprite -28,   4, $04, 0 | OAM_XFLIP
	dbsprite -20,  -4, $04, 0 | OAM_YFLIP
	dbsprite -20,   4, $04, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite   4,  20, $04, 0
	dbsprite   4,  28, $04, 0 | OAM_XFLIP
	dbsprite  12,  20, $04, 0 | OAM_YFLIP
	dbsprite  12,  28, $04, 0 | OAM_XFLIP | OAM_YFLIP

.frame_10
	db 20 ; size
	dbsprite  12, -36, $04, 0
	dbsprite  12, -28, $04, 0 | OAM_XFLIP
	dbsprite  20, -36, $04, 0 | OAM_YFLIP
	dbsprite  20, -28, $04, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite -18,   6, $09, 0
	dbsprite -18,  18, $09, 0 | OAM_XFLIP
	dbsprite  -6,   6, $09, 0 | OAM_YFLIP
	dbsprite  -6,  18, $09, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite -28,  -4, $05, 0
	dbsprite -28,   4, $05, 0 | OAM_XFLIP
	dbsprite -20,  -4, $05, 0 | OAM_YFLIP
	dbsprite -20,   4, $05, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite -12, -20, $08, 0
	dbsprite -12, -12, $08, 0 | OAM_XFLIP
	dbsprite  -4, -20, $08, 0 | OAM_YFLIP
	dbsprite  -4, -12, $08, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite   4,  20, $05, 0
	dbsprite   4,  28, $05, 0 | OAM_XFLIP
	dbsprite  12,  20, $05, 0 | OAM_YFLIP
	dbsprite  12,  28, $05, 0 | OAM_XFLIP | OAM_YFLIP

.frame_11
	db 16 ; size
	dbsprite -14, -22, $09, 0
	dbsprite -14, -10, $09, 0 | OAM_XFLIP
	dbsprite  -2, -22, $09, 0 | OAM_YFLIP
	dbsprite  -2, -10, $09, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite   4,  20, $08, 0
	dbsprite   4,  28, $08, 0 | OAM_XFLIP
	dbsprite  12,  20, $08, 0 | OAM_YFLIP
	dbsprite  12,  28, $08, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite  12, -36, $05, 0
	dbsprite  12, -28, $05, 0 | OAM_XFLIP
	dbsprite  20, -36, $05, 0 | OAM_YFLIP
	dbsprite  20, -28, $05, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite -28,  -4, $06, 0
	dbsprite -28,   4, $06, 0 | OAM_XFLIP
	dbsprite -20,  -4, $06, 0 | OAM_YFLIP
	dbsprite -20,   4, $06, 0 | OAM_XFLIP | OAM_YFLIP

.frame_12
	db 12 ; size
	dbsprite   2,  18, $09, 0
	dbsprite   2,  30, $09, 0 | OAM_XFLIP
	dbsprite  14,  18, $09, 0 | OAM_YFLIP
	dbsprite  14,  30, $09, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite  12, -36, $06, 0
	dbsprite  12, -28, $06, 0 | OAM_XFLIP
	dbsprite  20, -36, $06, 0 | OAM_YFLIP
	dbsprite  20, -28, $06, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite -28,  -4, $07, 0
	dbsprite -28,   4, $07, 0 | OAM_XFLIP
	dbsprite -20,   4, $07, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite -20,  -4, $07, 0 | OAM_YFLIP

.frame_13
	db 8 ; size
	dbsprite  12, -36, $08, 0
	dbsprite  12, -28, $08, 0 | OAM_XFLIP
	dbsprite  20, -36, $08, 0 | OAM_YFLIP
	dbsprite  20, -28, $08, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite -28,  -4, $06, 0
	dbsprite -28,   4, $06, 0 | OAM_XFLIP
	dbsprite -20,  -4, $06, 0 | OAM_YFLIP
	dbsprite -20,   4, $06, 0 | OAM_XFLIP | OAM_YFLIP

.frame_14
	db 8 ; size
	dbsprite -28,  -4, $07, 0
	dbsprite -28,   4, $07, 0 | OAM_XFLIP
	dbsprite -20,   4, $07, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite -20,  -4, $07, 0 | OAM_YFLIP
	dbsprite  10, -38, $09, 0
	dbsprite  10, -26, $09, 0 | OAM_XFLIP
	dbsprite  22, -38, $09, 0 | OAM_YFLIP
	dbsprite  22, -26, $09, 0 | OAM_XFLIP | OAM_YFLIP

.frame_15
	db 4 ; size
	dbsprite -28,  -4, $08, 0
	dbsprite -28,   4, $08, 0 | OAM_XFLIP
	dbsprite -20,  -4, $08, 0 | OAM_YFLIP
	dbsprite -20,   4, $08, 0 | OAM_XFLIP | OAM_YFLIP

.frame_16
	db 4 ; size
	dbsprite -30,  -6, $09, 0
	dbsprite -30,   6, $09, 0 | OAM_XFLIP
	dbsprite -18,  -6, $09, 0 | OAM_YFLIP
	dbsprite -18,   6, $09, 0 | OAM_XFLIP | OAM_YFLIP

OAMData26::
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
	dbsprite -29, -16, $00, 0
	dbsprite -29,  -8, $01, 0
	dbsprite -29,   0, $02, 0
	dbsprite -29,   8, $03, 0
	dbsprite -21,  -7, $0d, 0
	dbsprite -21,   3, $0d, 0

.frame_1
	db 8 ; size
	dbsprite -27, -16, $04, 0
	dbsprite -27,  -8, $05, 0
	dbsprite -27,   0, $06, 0
	dbsprite -27,   8, $07, 0
	dbsprite -19, -23, $08, 0
	dbsprite -19,  -9, $09, 0
	dbsprite -19,   1, $0a, 0
	dbsprite -23, -20, $04, 0

.frame_2
	db 12 ; size
	dbsprite -27, -16, $04, 0
	dbsprite -27,  -8, $05, 0
	dbsprite -27,   0, $06, 0
	dbsprite -27,   8, $07, 0
	dbsprite -19,  -8, $0c, 0
	dbsprite -19, -23, $0b, 0
	dbsprite -11, -24, $0e, 0
	dbsprite -11, -11, $0f, 0
	dbsprite -11,   0, $10, 0
	dbsprite  -3,   0, $11, 0
	dbsprite -19,   6, $23, 0
	dbsprite -23, -20, $04, 0

.frame_3
	db 16 ; size
	dbsprite -25,   8, $12, 0
	dbsprite -25, -16, $04, 0
	dbsprite -25,  -8, $05, 0
	dbsprite -25,   0, $1a, 0
	dbsprite -17, -23, $13, 0
	dbsprite -17,  -8, $14, 0
	dbsprite -17,   2, $15, 0
	dbsprite  -9,  -8, $16, 0
	dbsprite  -9,   1, $15, 0
	dbsprite  -1,   1, $15, 0
	dbsprite  -1, -24, $17, 0
	dbsprite   7, -12, $18, 0
	dbsprite   7,   0, $19, 0
	dbsprite  -1, -12, $10, 0
	dbsprite  -9, -20, $23, 0
	dbsprite -21, -20, $04, 0

.frame_4
	db 18 ; size
	dbsprite -24,   8, $1d, 0
	dbsprite -24,   0, $1c, 0
	dbsprite -24,  -8, $1b, 0
	dbsprite -16, -13, $1e, 0
	dbsprite -16,  -4, $1f, 0
	dbsprite -16,   3, $20, 0
	dbsprite  -8, -20, $21, 0
	dbsprite  -8,  -8, $22, 0
	dbsprite  -8,   1, $15, 0
	dbsprite   0,  -8, $23, 0
	dbsprite   8, -25, $24, 0
	dbsprite   8,  -9, $25, 0
	dbsprite  16, -31, $26, 0
	dbsprite   0,   0, $15, 0
	dbsprite   8,   0, $15, 0
	dbsprite  16,   0, $15, 0
	dbsprite  16, -16, $15, 0
	dbsprite   0, -22, $2a, 0

.frame_5
	db 15 ; size
	dbsprite -24,   9, $27, 0
	dbsprite -16,   0, $28, 0
	dbsprite -16,   8, $29, 0
	dbsprite  -8,   6, $26, 0
	dbsprite   0,  -1, $2a, 0
	dbsprite   0,   8, $2b, 0
	dbsprite   8, -19, $2c, 0
	dbsprite  16, -26, $2c, 0
	dbsprite   8,  -8, $2d, 0
	dbsprite  16, -12, $2d, 0
	dbsprite   8,   8, $25, 0
	dbsprite  16,   5, $2b, 0
	dbsprite   0, -12, $2c, 0
	dbsprite  -8,   3, $2a, 0
	dbsprite  -8,  -5, $2c, 0

.frame_6
	db 21 ; size
	dbsprite -24,   9, $27, 0
	dbsprite -16,   0, $28, 0
	dbsprite -16,   8, $29, 0
	dbsprite  -8,   6, $26, 0
	dbsprite   0,  -1, $2a, 0
	dbsprite   0,   8, $2b, 0
	dbsprite   8, -19, $2c, 0
	dbsprite  16, -26, $2c, 0
	dbsprite   8,  -8, $2d, 0
	dbsprite  16, -12, $2d, 0
	dbsprite   8,   8, $25, 0
	dbsprite  16,   5, $2b, 0
	dbsprite   0, -12, $2c, 0
	dbsprite  -8,   3, $2a, 0
	dbsprite  -8,  -5, $2c, 0
	dbsprite -29,   8, $00, 1 | OAM_XFLIP
	dbsprite -29,   0, $01, 1 | OAM_XFLIP
	dbsprite -29,  -8, $02, 1 | OAM_XFLIP
	dbsprite -29, -16, $03, 1 | OAM_XFLIP
	dbsprite -21,  -7, $0d, 1
	dbsprite -21,   3, $0d, 1

.frame_7
	db 23 ; size
	dbsprite -24,   9, $27, 0
	dbsprite -16,   0, $28, 0
	dbsprite -16,   8, $29, 0
	dbsprite  -8,   6, $26, 0
	dbsprite   0,  -1, $2a, 0
	dbsprite   0,   8, $2b, 0
	dbsprite   8, -19, $2c, 0
	dbsprite  16, -26, $2c, 0
	dbsprite   8,  -8, $2d, 0
	dbsprite  16, -12, $2d, 0
	dbsprite   8,   8, $25, 0
	dbsprite  16,   5, $2b, 0
	dbsprite   0, -12, $2c, 0
	dbsprite  -8,   3, $2a, 0
	dbsprite  -8,  -5, $2c, 0
	dbsprite -27,   8, $04, 1 | OAM_XFLIP
	dbsprite -27,   0, $05, 1 | OAM_XFLIP
	dbsprite -27,  -8, $06, 1 | OAM_XFLIP
	dbsprite -27, -16, $07, 1 | OAM_XFLIP
	dbsprite -19,  15, $08, 1 | OAM_XFLIP
	dbsprite -23,  12, $04, 1 | OAM_XFLIP
	dbsprite -19,   1, $09, 1 | OAM_XFLIP
	dbsprite -19,  -9, $0a, 1 | OAM_XFLIP

.frame_8
	db 27 ; size
	dbsprite -24,   9, $27, 0
	dbsprite -16,   0, $28, 0
	dbsprite -16,   8, $29, 0
	dbsprite  -8,   6, $26, 0
	dbsprite   0,  -1, $2a, 0
	dbsprite   0,   8, $2b, 0
	dbsprite   8, -19, $2c, 0
	dbsprite  16, -26, $2c, 0
	dbsprite   8,  -8, $2d, 0
	dbsprite  16, -12, $2d, 0
	dbsprite   8,   8, $25, 0
	dbsprite  16,   5, $2b, 0
	dbsprite   0, -12, $2c, 0
	dbsprite  -8,   3, $2a, 0
	dbsprite  -8,  -5, $2c, 0
	dbsprite -27,   8, $04, 1 | OAM_XFLIP
	dbsprite -27,   0, $05, 1 | OAM_XFLIP
	dbsprite -27,  -8, $06, 1 | OAM_XFLIP
	dbsprite -27, -16, $07, 1 | OAM_XFLIP
	dbsprite -23,  11, $04, 1 | OAM_XFLIP
	dbsprite -19,   0, $0c, 1 | OAM_XFLIP
	dbsprite -11,  16, $0e, 1 | OAM_XFLIP
	dbsprite -11,   3, $0f, 1 | OAM_XFLIP
	dbsprite -11,  -8, $10, 1 | OAM_XFLIP
	dbsprite  -3,  -8, $11, 1 | OAM_XFLIP
	dbsprite -19, -14, $23, 1 | OAM_XFLIP
	dbsprite -19,  14, $0b, 1 | OAM_XFLIP

.frame_9
	db 31 ; size
	dbsprite -24,   9, $27, 0
	dbsprite -16,   0, $28, 0
	dbsprite -16,   8, $29, 0
	dbsprite  -8,   6, $26, 0
	dbsprite   0,  -1, $2a, 0
	dbsprite   0,   8, $2b, 0
	dbsprite   8, -19, $2c, 0
	dbsprite  16, -26, $2c, 0
	dbsprite   8,  -8, $2d, 0
	dbsprite  16, -12, $2d, 0
	dbsprite   8,   8, $25, 0
	dbsprite  16,   5, $2b, 0
	dbsprite   0, -12, $2c, 0
	dbsprite  -8,   3, $2a, 0
	dbsprite  -8,  -5, $2c, 0
	dbsprite -25, -16, $12, 1 | OAM_XFLIP
	dbsprite -25,   8, $04, 1 | OAM_XFLIP
	dbsprite -25,   0, $05, 1 | OAM_XFLIP
	dbsprite -25,  -8, $1a, 1 | OAM_XFLIP
	dbsprite -17,   8, $04, 1 | OAM_YFLIP
	dbsprite -17,  15, $13, 1 | OAM_XFLIP
	dbsprite -17,   0, $14, 1 | OAM_XFLIP
	dbsprite -17, -10, $15, 1 | OAM_XFLIP
	dbsprite  -9,   0, $16, 1 | OAM_XFLIP
	dbsprite  -9,  -9, $15, 1 | OAM_XFLIP
	dbsprite  -1,  -9, $15, 1 | OAM_XFLIP
	dbsprite  -1,  16, $17, 1 | OAM_XFLIP
	dbsprite   7,   4, $18, 1 | OAM_XFLIP
	dbsprite   7,  -8, $19, 1 | OAM_XFLIP
	dbsprite  -1,   4, $10, 1 | OAM_XFLIP
	dbsprite  -9,  12, $23, 1 | OAM_XFLIP

.frame_10
	db 33 ; size
	dbsprite -24,   9, $27, 0
	dbsprite -16,   0, $28, 0
	dbsprite -16,   8, $29, 0
	dbsprite  -8,   6, $26, 0
	dbsprite   0,  -1, $2a, 0
	dbsprite   0,   8, $2b, 0
	dbsprite   8, -19, $2c, 0
	dbsprite  16, -26, $2c, 0
	dbsprite   8,  -8, $2d, 0
	dbsprite  16, -12, $2d, 0
	dbsprite   8,   8, $25, 0
	dbsprite  16,   5, $2b, 0
	dbsprite   0, -12, $2c, 0
	dbsprite  -8,   3, $2a, 0
	dbsprite  -8,  -5, $2c, 0
	dbsprite -24, -16, $1d, 1 | OAM_XFLIP
	dbsprite -24,  -8, $1c, 1 | OAM_XFLIP
	dbsprite -24,   0, $1b, 1 | OAM_XFLIP
	dbsprite -16,   5, $1e, 1 | OAM_XFLIP
	dbsprite -16,  -4, $1f, 1 | OAM_XFLIP
	dbsprite -16, -11, $20, 1 | OAM_XFLIP
	dbsprite  -8,  12, $21, 1 | OAM_XFLIP
	dbsprite  -8,   0, $22, 1 | OAM_XFLIP
	dbsprite  -8,  -9, $15, 1 | OAM_XFLIP
	dbsprite   0,   0, $23, 1 | OAM_XFLIP
	dbsprite   8,  17, $24, 1 | OAM_XFLIP
	dbsprite   8,   1, $25, 1 | OAM_XFLIP
	dbsprite  16,  23, $26, 1 | OAM_XFLIP
	dbsprite   0,  -8, $15, 1 | OAM_XFLIP
	dbsprite   8,  -8, $15, 1 | OAM_XFLIP
	dbsprite  16,  -8, $15, 1 | OAM_XFLIP
	dbsprite  16,   8, $15, 1 | OAM_XFLIP
	dbsprite   0,  14, $2a, 1 | OAM_XFLIP

.frame_11
	db 30 ; size
	dbsprite -24,   9, $27, 0
	dbsprite -16,   0, $28, 0
	dbsprite -16,   8, $29, 0
	dbsprite  -8,   6, $26, 0
	dbsprite   0,  -1, $2a, 0
	dbsprite   0,   8, $2b, 0
	dbsprite   8, -19, $2c, 0
	dbsprite  16, -26, $2c, 0
	dbsprite   8,  -8, $2d, 0
	dbsprite  16, -12, $2d, 0
	dbsprite   8,   8, $25, 0
	dbsprite  16,   5, $2b, 0
	dbsprite   0, -12, $2c, 0
	dbsprite  -8,   3, $2a, 0
	dbsprite  -8,  -5, $2c, 0
	dbsprite -24, -17, $27, 1 | OAM_XFLIP
	dbsprite -16,  -8, $28, 1 | OAM_XFLIP
	dbsprite -16, -16, $29, 1 | OAM_XFLIP
	dbsprite  -8, -14, $26, 1 | OAM_XFLIP
	dbsprite   0,  -7, $2a, 1 | OAM_XFLIP
	dbsprite   0, -16, $2b, 1 | OAM_XFLIP
	dbsprite   8,  11, $2c, 1 | OAM_XFLIP
	dbsprite  16,  18, $2c, 1 | OAM_XFLIP
	dbsprite   8,   0, $2d, 1 | OAM_XFLIP
	dbsprite  16,   4, $2d, 1 | OAM_XFLIP
	dbsprite   8, -16, $25, 1 | OAM_XFLIP
	dbsprite  16, -13, $2b, 1 | OAM_XFLIP
	dbsprite   0,   4, $2c, 1 | OAM_XFLIP
	dbsprite  -8, -11, $2a, 1 | OAM_XFLIP
	dbsprite  -8,  -3, $2c, 1 | OAM_XFLIP

OAMData27::
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
	dbsprite -32, -40, $02, 0
	dbsprite -24, -40, $03, 0
	dbsprite -32, -32, $02, 0 | OAM_XFLIP
	dbsprite -24, -32, $03, 0 | OAM_XFLIP
	dbsprite -32,  24, $02, 0
	dbsprite -24,  24, $03, 0
	dbsprite -32,  32, $02, 0 | OAM_XFLIP
	dbsprite -24,  32, $03, 0 | OAM_XFLIP

.frame_1
	db 14 ; size
	dbsprite -32, -40, $02, 0
	dbsprite -24, -40, $03, 0
	dbsprite -32, -32, $02, 0 | OAM_XFLIP
	dbsprite -24, -32, $03, 0 | OAM_XFLIP
	dbsprite -32,  24, $02, 0
	dbsprite -24,  24, $03, 0
	dbsprite -32,  32, $02, 0 | OAM_XFLIP
	dbsprite -24,  32, $03, 0 | OAM_XFLIP
	dbsprite -24,  16, $00, 0
	dbsprite -24, -24, $00, 0 | OAM_XFLIP
	dbsprite -16, -32, $01, 0
	dbsprite -16,  16, $01, 0
	dbsprite -16, -24, $01, 0 | OAM_XFLIP
	dbsprite -16,  24, $01, 0 | OAM_XFLIP

.frame_2
	db 14 ; size
	dbsprite -24, -32, $02, 0
	dbsprite -16, -32, $03, 0
	dbsprite -24, -24, $02, 0 | OAM_XFLIP
	dbsprite -16, -24, $03, 0 | OAM_XFLIP
	dbsprite -24,  16, $02, 0
	dbsprite -16,  16, $03, 0
	dbsprite -24,  24, $02, 0 | OAM_XFLIP
	dbsprite -16,  24, $03, 0 | OAM_XFLIP
	dbsprite -32, -40, $00, 0
	dbsprite -32,  24, $00, 0
	dbsprite -24, -40, $01, 0
	dbsprite -32, -32, $00, 0 | OAM_XFLIP
	dbsprite -32,  32, $00, 0 | OAM_XFLIP
	dbsprite -24,  32, $01, 0 | OAM_XFLIP

.frame_3
	db 8 ; size
	dbsprite -24, -32, $02, 0
	dbsprite -16, -32, $03, 0
	dbsprite -24, -24, $02, 0 | OAM_XFLIP
	dbsprite -16, -24, $03, 0 | OAM_XFLIP
	dbsprite -24,  16, $02, 0
	dbsprite -16,  16, $03, 0
	dbsprite -24,  24, $02, 0 | OAM_XFLIP
	dbsprite -16,  24, $03, 0 | OAM_XFLIP

.frame_4
	db 14 ; size
	dbsprite -24, -32, $02, 0
	dbsprite -16, -32, $03, 0
	dbsprite -24, -24, $02, 0 | OAM_XFLIP
	dbsprite -16, -24, $03, 0 | OAM_XFLIP
	dbsprite -24,  16, $02, 0
	dbsprite -16,  16, $03, 0
	dbsprite -24,  24, $02, 0 | OAM_XFLIP
	dbsprite -16,  24, $03, 0 | OAM_XFLIP
	dbsprite -16,   8, $00, 0
	dbsprite  -8, -24, $01, 0
	dbsprite  -8,   8, $01, 0
	dbsprite -16, -16, $00, 0 | OAM_XFLIP
	dbsprite  -8, -16, $01, 0 | OAM_XFLIP
	dbsprite  -8,  16, $01, 0 | OAM_XFLIP

.frame_5
	db 14 ; size
	dbsprite -16, -24, $02, 0
	dbsprite  -8, -24, $03, 0
	dbsprite -16, -16, $02, 0 | OAM_XFLIP
	dbsprite  -8, -16, $03, 0 | OAM_XFLIP
	dbsprite -16,   8, $02, 0
	dbsprite  -8,   8, $03, 0
	dbsprite -16,  16, $02, 0 | OAM_XFLIP
	dbsprite  -8,  16, $03, 0 | OAM_XFLIP
	dbsprite -24, -32, $00, 0
	dbsprite -24,  16, $00, 0
	dbsprite -16, -32, $01, 0
	dbsprite -24, -24, $00, 0 | OAM_XFLIP
	dbsprite -24,  24, $00, 0 | OAM_XFLIP
	dbsprite -16,  24, $01, 0 | OAM_XFLIP

.frame_6
	db 8 ; size
	dbsprite -16, -24, $02, 0
	dbsprite  -8, -24, $03, 0
	dbsprite -16, -16, $02, 0 | OAM_XFLIP
	dbsprite  -8, -16, $03, 0 | OAM_XFLIP
	dbsprite -16,   8, $02, 0
	dbsprite  -8,   8, $03, 0
	dbsprite -16,  16, $02, 0 | OAM_XFLIP
	dbsprite  -8,  16, $03, 0 | OAM_XFLIP

.frame_7
	db 14 ; size
	dbsprite -16, -24, $02, 0
	dbsprite  -8, -24, $03, 0
	dbsprite -16, -16, $02, 0 | OAM_XFLIP
	dbsprite  -8, -16, $03, 0 | OAM_XFLIP
	dbsprite -16,   8, $02, 0
	dbsprite  -8,   8, $03, 0
	dbsprite -16,  16, $02, 0 | OAM_XFLIP
	dbsprite  -8,  16, $03, 0 | OAM_XFLIP
	dbsprite  -8,   0, $00, 0
	dbsprite   0,   0, $01, 0
	dbsprite   0, -16, $01, 0
	dbsprite  -8,  -8, $00, 0 | OAM_XFLIP
	dbsprite   0,  -8, $01, 0 | OAM_XFLIP
	dbsprite   0,   8, $01, 0 | OAM_XFLIP

.frame_8
	db 14 ; size
	dbsprite  -8, -16, $02, 0
	dbsprite   0, -16, $03, 0
	dbsprite  -8,  -8, $02, 0 | OAM_XFLIP
	dbsprite   0,  -8, $03, 0 | OAM_XFLIP
	dbsprite  -8,   0, $02, 0
	dbsprite   0,   0, $03, 0
	dbsprite  -8,   8, $02, 0 | OAM_XFLIP
	dbsprite   0,   8, $03, 0 | OAM_XFLIP
	dbsprite -16, -24, $00, 0
	dbsprite  -8, -24, $01, 0
	dbsprite -16, -16, $00, 0 | OAM_XFLIP
	dbsprite -16,  16, $00, 0 | OAM_XFLIP
	dbsprite -16,   8, $00, 0
	dbsprite  -8,  16, $01, 0 | OAM_XFLIP

.frame_9
	db 8 ; size
	dbsprite  -8, -16, $02, 0
	dbsprite   0, -16, $03, 0
	dbsprite  -8,  -8, $02, 0 | OAM_XFLIP
	dbsprite   0,  -8, $03, 0 | OAM_XFLIP
	dbsprite  -8,   0, $02, 0
	dbsprite   0,   0, $03, 0
	dbsprite  -8,   8, $02, 0 | OAM_XFLIP
	dbsprite   0,   8, $03, 0 | OAM_XFLIP

.frame_10
	db 10 ; size
	dbsprite   0,  -8, $04, 1
	dbsprite   0,   0, $05, 1
	dbsprite   8,  -8, $06, 1
	dbsprite   8,   0, $07, 1
	dbsprite  -8, -16, $00, 0
	dbsprite  -8,   0, $00, 0
	dbsprite  -8,  -8, $00, 0 | OAM_XFLIP
	dbsprite  -8,   8, $00, 0 | OAM_XFLIP
	dbsprite   0, -16, $01, 0
	dbsprite   0,   8, $01, 0 | OAM_XFLIP

.frame_11
	db 8 ; size
	dbsprite -22, -37, $02, 0
	dbsprite -14, -37, $03, 0
	dbsprite -22, -29, $02, 0 | OAM_XFLIP
	dbsprite -14, -29, $03, 0 | OAM_XFLIP
	dbsprite -22,  21, $02, 0
	dbsprite -14,  21, $03, 0
	dbsprite -22,  29, $02, 0 | OAM_XFLIP
	dbsprite -14,  29, $03, 0 | OAM_XFLIP

.frame_12
	db 8 ; size
	dbsprite -16, -40, $02, 0
	dbsprite  -8, -40, $03, 0
	dbsprite -16, -32, $02, 0 | OAM_XFLIP
	dbsprite  -8, -32, $03, 0 | OAM_XFLIP
	dbsprite -16,  24, $02, 0
	dbsprite  -8,  24, $03, 0
	dbsprite -16,  32, $02, 0 | OAM_XFLIP
	dbsprite  -8,  32, $03, 0 | OAM_XFLIP

OAMData28::
	dw .frame_0
	dw .frame_1
	dw .frame_2
	dw .frame_3
	dw .frame_4
	dw .frame_5
	dw .frame_6
	dw .frame_7

.frame_0
	db 6 ; size
	dbsprite  -4, -18, $00, 1
	dbsprite  -4, -10, $01, 1
	dbsprite  -4,   2, $00, 1
	dbsprite  -4,  10, $01, 1
	dbsprite   4, -14, $04, 1
	dbsprite   4,   6, $04, 1

.frame_1
	db 6 ; size
	dbsprite  -4, -18, $00, 1
	dbsprite  -4, -10, $01, 1
	dbsprite  -4,   3, $02, 2
	dbsprite  -4,  11, $03, 2
	dbsprite   4, -14, $04, 1
	dbsprite   4,   6, $04, 2

.frame_2
	db 9 ; size
	dbsprite  -4, -18, $00, 1
	dbsprite  -4, -10, $01, 1
	dbsprite  -4,   3, $02, 2
	dbsprite  -4,  11, $03, 2
	dbsprite   4, -14, $04, 1
	dbsprite   4,   6, $04, 2
	dbsprite  -5,  23, $05, 0
	dbsprite   3,  19, $06, 0
	dbsprite  -5,  15, $05, 0 | OAM_XFLIP

.frame_3
	db 9 ; size
	dbsprite  -4, -18, $00, 1
	dbsprite  -4, -10, $01, 1
	dbsprite  -4,   3, $02, 2
	dbsprite  -4,  11, $03, 2
	dbsprite   4, -14, $04, 1
	dbsprite   4,   6, $04, 2
	dbsprite -13,  26, $05, 0
	dbsprite  -5,  22, $06, 0
	dbsprite -13,  18, $05, 0 | OAM_XFLIP

.frame_4
	db 9 ; size
	dbsprite  -4, -18, $00, 1
	dbsprite  -4, -10, $01, 1
	dbsprite  -4,   3, $02, 2
	dbsprite  -4,  11, $03, 2
	dbsprite   4, -14, $04, 1
	dbsprite   4,   6, $04, 2
	dbsprite -21,  24, $05, 0
	dbsprite -13,  20, $06, 0
	dbsprite -21,  16, $05, 0 | OAM_XFLIP

.frame_5
	db 9 ; size
	dbsprite  -4, -18, $00, 1
	dbsprite  -4, -10, $01, 1
	dbsprite  -4,   3, $02, 2
	dbsprite  -4,  11, $03, 2
	dbsprite   4, -14, $04, 1
	dbsprite   4,   6, $04, 2
	dbsprite -29,  24, $05, 0
	dbsprite -21,  20, $06, 0
	dbsprite -29,  16, $05, 0 | OAM_XFLIP

.frame_6
	db 9 ; size
	dbsprite  -4, -18, $00, 1
	dbsprite  -4, -10, $01, 1
	dbsprite  -4,   3, $02, 2
	dbsprite  -4,  11, $03, 2
	dbsprite   4, -14, $04, 1
	dbsprite   4,   6, $04, 2
	dbsprite -32,  32, $05, 0
	dbsprite -24,  28, $06, 0
	dbsprite -32,  24, $05, 0 | OAM_XFLIP

.frame_7
	db 9 ; size
	dbsprite  -4, -18, $00, 1
	dbsprite  -4, -10, $01, 1
	dbsprite  -4,   3, $02, 2
	dbsprite  -4,  11, $03, 2
	dbsprite   4, -14, $04, 1
	dbsprite   4,   6, $04, 2
	dbsprite -32,  40, $05, 0
	dbsprite -24,  36, $06, 0
	dbsprite -32,  32, $05, 0 | OAM_XFLIP

OAMData29::
	dw .frame_0
	dw .frame_1
	dw .frame_2
	dw .frame_3
	dw .frame_4
	dw .frame_5

.frame_0
	db 14 ; size
	dbsprite -16, -16, $00, 0
	dbsprite -16,  -8, $01, 0
	dbsprite -16,   0, $02, 0
	dbsprite -16,   8, $03, 0
	dbsprite  -8, -16, $04, 0
	dbsprite  -8,  -8, $05, 0
	dbsprite  -8,   0, $06, 0
	dbsprite  -8,   8, $07, 0
	dbsprite   0, -16, $08, 0
	dbsprite   0,  -8, $09, 0
	dbsprite   0,   0, $0a, 0
	dbsprite   0,   8, $0b, 0
	dbsprite   8,  -8, $0c, 0
	dbsprite   8,   0, $0d, 0

.frame_1
	db 14 ; size
	dbsprite -16,   8, $00, 0 | OAM_XFLIP
	dbsprite -16,   0, $01, 0 | OAM_XFLIP
	dbsprite -16,  -8, $02, 0 | OAM_XFLIP
	dbsprite -16, -16, $03, 0 | OAM_XFLIP
	dbsprite  -8,   8, $04, 0 | OAM_XFLIP
	dbsprite  -8,   0, $05, 0 | OAM_XFLIP
	dbsprite  -8,  -8, $06, 0 | OAM_XFLIP
	dbsprite  -8, -16, $07, 0 | OAM_XFLIP
	dbsprite   0,   8, $08, 0 | OAM_XFLIP
	dbsprite   0,   0, $09, 0 | OAM_XFLIP
	dbsprite   0,  -8, $0a, 0 | OAM_XFLIP
	dbsprite   0, -16, $0b, 0 | OAM_XFLIP
	dbsprite   8,   0, $0c, 0 | OAM_XFLIP
	dbsprite   8,  -8, $0d, 0 | OAM_XFLIP

.frame_2
	db 14 ; size
	dbsprite -16, -16, $0e, 0
	dbsprite -16,  -8, $0f, 0
	dbsprite -16,   0, $10, 0
	dbsprite -16,   8, $11, 0
	dbsprite  -8, -16, $12, 0
	dbsprite  -8,  -8, $13, 0
	dbsprite  -8,   0, $14, 0
	dbsprite  -8,   8, $15, 0
	dbsprite   0, -16, $16, 0
	dbsprite   0,  -8, $17, 0
	dbsprite   0,   0, $18, 0
	dbsprite   0,   8, $19, 0
	dbsprite   8,  -8, $1a, 0
	dbsprite   8,   0, $1b, 0

.frame_3
	db 14 ; size
	dbsprite -16,   8, $0e, 0 | OAM_XFLIP
	dbsprite -16,   0, $0f, 0 | OAM_XFLIP
	dbsprite -16,  -8, $10, 0 | OAM_XFLIP
	dbsprite -16, -16, $11, 0 | OAM_XFLIP
	dbsprite  -8,   8, $12, 0 | OAM_XFLIP
	dbsprite  -8,   0, $13, 0 | OAM_XFLIP
	dbsprite  -8,  -8, $14, 0 | OAM_XFLIP
	dbsprite  -8, -16, $15, 0 | OAM_XFLIP
	dbsprite   0,   8, $16, 0 | OAM_XFLIP
	dbsprite   0,   0, $17, 0 | OAM_XFLIP
	dbsprite   0,  -8, $18, 0 | OAM_XFLIP
	dbsprite   0, -16, $19, 0 | OAM_XFLIP
	dbsprite   8,   0, $1a, 0 | OAM_XFLIP
	dbsprite   8,  -8, $1b, 0 | OAM_XFLIP

.frame_4
	db 14 ; size
	dbsprite -16, -16, $0e, 1
	dbsprite -16,  -8, $0f, 1
	dbsprite -16,   0, $10, 1
	dbsprite -16,   8, $11, 1
	dbsprite  -8, -16, $12, 1
	dbsprite  -8,  -8, $13, 1
	dbsprite  -8,   0, $14, 1
	dbsprite  -8,   8, $15, 1
	dbsprite   0, -16, $16, 1
	dbsprite   0,  -8, $17, 1
	dbsprite   0,   0, $18, 1
	dbsprite   0,   8, $19, 1
	dbsprite   8,  -8, $1a, 1
	dbsprite   8,   0, $1b, 1

.frame_5
	db 14 ; size
	dbsprite -16,   8, $0e, 1 | OAM_XFLIP
	dbsprite -16,   0, $0f, 1 | OAM_XFLIP
	dbsprite -16,  -8, $10, 1 | OAM_XFLIP
	dbsprite -16, -16, $11, 1 | OAM_XFLIP
	dbsprite  -8,   8, $12, 1 | OAM_XFLIP
	dbsprite  -8,   0, $13, 1 | OAM_XFLIP
	dbsprite  -8,  -8, $14, 1 | OAM_XFLIP
	dbsprite  -8, -16, $15, 1 | OAM_XFLIP
	dbsprite   0,   8, $16, 1 | OAM_XFLIP
	dbsprite   0,   0, $17, 1 | OAM_XFLIP
	dbsprite   0,  -8, $18, 1 | OAM_XFLIP
	dbsprite   0, -16, $19, 1 | OAM_XFLIP
	dbsprite   8,   0, $1a, 1 | OAM_XFLIP
	dbsprite   8,  -8, $1b, 1 | OAM_XFLIP

OAMData2A::
	dw .frame_0
	dw .frame_1
	dw .frame_2
	dw .frame_3
	dw .frame_4
	dw .frame_5
	dw .frame_6
	dw .frame_7

.frame_0
	db 1 ; size
	dbsprite -16,   8, $00, 0

.frame_1
	db 2 ; size
	dbsprite -16,   8, $01, 0
	dbsprite   8, -16, $00, 0

.frame_2
	db 6 ; size
	dbsprite -20,   4, $02, 0
	dbsprite -20,  12, $02, 0 | OAM_XFLIP
	dbsprite -12,  12, $02, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite -12,   4, $02, 0 | OAM_YFLIP
	dbsprite   8, -16, $01, 0
	dbsprite   8,  16, $00, 0

.frame_3
	db 9 ; size
	dbsprite -20,   4, $03, 0
	dbsprite -20,  12, $03, 0 | OAM_XFLIP
	dbsprite -12,   4, $03, 0 | OAM_YFLIP
	dbsprite -12,  12, $03, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite   4, -20, $02, 0
	dbsprite   4, -12, $02, 0 | OAM_XFLIP
	dbsprite  12, -12, $02, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite  12, -20, $02, 0 | OAM_YFLIP
	dbsprite   8,  16, $01, 0

.frame_4
	db 12 ; size
	dbsprite   4, -20, $03, 0
	dbsprite   4, -12, $03, 0 | OAM_XFLIP
	dbsprite  12, -20, $03, 0 | OAM_YFLIP
	dbsprite  12, -12, $03, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite   4,  12, $02, 0
	dbsprite   4,  20, $02, 0 | OAM_XFLIP
	dbsprite  12,  20, $02, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite  12,  12, $02, 0 | OAM_YFLIP
	dbsprite -20,   4, $02, 1
	dbsprite -20,  12, $02, 1 | OAM_XFLIP
	dbsprite -12,  12, $02, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite -12,   4, $02, 1 | OAM_YFLIP

.frame_5
	db 12 ; size
	dbsprite   4,  12, $03, 0
	dbsprite   4,  20, $03, 0 | OAM_XFLIP
	dbsprite  12,  12, $03, 0 | OAM_YFLIP
	dbsprite  12,  20, $03, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite -20,   4, $03, 0
	dbsprite -20,  12, $03, 0 | OAM_XFLIP
	dbsprite -12,   4, $03, 0 | OAM_YFLIP
	dbsprite -12,  12, $03, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite   4, -20, $02, 1
	dbsprite   4, -12, $02, 1 | OAM_XFLIP
	dbsprite  12, -12, $02, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite  12, -20, $02, 1 | OAM_YFLIP

.frame_6
	db 12 ; size
	dbsprite   4, -20, $03, 0
	dbsprite   4, -12, $03, 0 | OAM_XFLIP
	dbsprite  12, -20, $03, 0 | OAM_YFLIP
	dbsprite  12, -12, $03, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite   4,  12, $02, 1
	dbsprite   4,  20, $02, 1 | OAM_XFLIP
	dbsprite  12,  20, $02, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite  12,  12, $02, 1 | OAM_YFLIP
	dbsprite -20,   4, $02, 0
	dbsprite -20,  12, $02, 0 | OAM_XFLIP
	dbsprite -12,  12, $02, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite -12,   4, $02, 0 | OAM_YFLIP

.frame_7
	db 12 ; size
	dbsprite   4,  12, $03, 0
	dbsprite   4,  20, $03, 0 | OAM_XFLIP
	dbsprite  12,  12, $03, 0 | OAM_YFLIP
	dbsprite  12,  20, $03, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite -20,   4, $03, 2
	dbsprite -20,  12, $03, 2 | OAM_XFLIP
	dbsprite -12,   4, $03, 2 | OAM_YFLIP
	dbsprite -12,  12, $03, 2 | OAM_XFLIP | OAM_YFLIP
	dbsprite   4, -20, $02, 0
	dbsprite   4, -12, $02, 0 | OAM_XFLIP
	dbsprite  12, -12, $02, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite  12, -20, $02, 0 | OAM_YFLIP

OAMData2B::
	dw .frame_0
	dw .frame_1
	dw .frame_2
	dw .frame_3
	dw .frame_4
	dw .frame_5
	dw .frame_6
	dw .frame_7

.frame_0
	db 2 ; size
	dbsprite -24,  -8, $02, 0 | OAM_YFLIP
	dbsprite -16,  -8, $00, 0

.frame_1
	db 8 ; size
	dbsprite -16,   0, $02, 0 | OAM_YFLIP
	dbsprite -21, -16, $01, 0
	dbsprite -25,  17, $03, 0 | OAM_XFLIP
	dbsprite  -8,   0, $00, 0
	dbsprite -16, -16, $02, 0
	dbsprite -26,  25, $03, 0
	dbsprite -17,  15, $00, 0
	dbsprite -18,  24, $00, 0

.frame_2
	db 8 ; size
	dbsprite  -8,   4, $02, 0 | OAM_YFLIP
	dbsprite -13, -22, $01, 0
	dbsprite -19,  21, $03, 0 | OAM_XFLIP
	dbsprite   0,   4, $00, 0
	dbsprite  -8, -22, $02, 0
	dbsprite -11,  19, $00, 0
	dbsprite -12,  28, $00, 0
	dbsprite -20,  29, $03, 0

.frame_3
	db 12 ; size
	dbsprite   5,   2, $02, 0 | OAM_YFLIP
	dbsprite  -5, -24, $01, 0
	dbsprite -12,  24, $03, 0 | OAM_XFLIP
	dbsprite  13,   2, $00, 0
	dbsprite   0, -24, $02, 0
	dbsprite  -4,  22, $00, 0
	dbsprite  -5,  31, $00, 0
	dbsprite -13,  32, $03, 0
	dbsprite -20, -10, $07, 0
	dbsprite -28, -16, $05, 0
	dbsprite -28,  -8, $06, 0
	dbsprite -36,  -8, $04, 0

.frame_4
	db 12 ; size
	dbsprite  16,  -2, $02, 0 | OAM_YFLIP
	dbsprite  10, -22, $01, 0
	dbsprite   0,  19, $03, 0 | OAM_XFLIP
	dbsprite  24,  -2, $00, 0
	dbsprite  15, -22, $02, 0
	dbsprite  -1,  27, $03, 0
	dbsprite   7,  26, $00, 0
	dbsprite   8,  17, $00, 0
	dbsprite  -8,  -5, $07, 0
	dbsprite -16, -11, $05, 0
	dbsprite -16,  -3, $06, 0
	dbsprite -24,  -3, $04, 0

.frame_5
	db 10 ; size
	dbsprite  21, -16, $01, 0
	dbsprite  10,  14, $03, 0 | OAM_XFLIP
	dbsprite  26, -16, $02, 0
	dbsprite   9,  22, $03, 0
	dbsprite  18,  12, $00, 0
	dbsprite  17,  21, $00, 0
	dbsprite   0,  -9, $07, 0
	dbsprite  -8, -15, $05, 0
	dbsprite  -8,  -7, $06, 0
	dbsprite -16,  -7, $04, 0

.frame_6
	db 8 ; size
	dbsprite  18,  10, $03, 0 | OAM_XFLIP
	dbsprite  17,  18, $03, 0
	dbsprite  26,   8, $00, 0
	dbsprite  25,  17, $00, 0
	dbsprite  12, -13, $07, 0
	dbsprite   4, -19, $05, 0
	dbsprite   4, -11, $06, 0
	dbsprite  -4, -11, $04, 0

.frame_7
	db 4 ; size
	dbsprite  24, -17, $07, 0
	dbsprite  16, -23, $05, 0
	dbsprite  16, -15, $06, 0
	dbsprite   8, -15, $04, 0

OAMData2C::
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
	db 8 ; size
	dbsprite  -7, -32, $00, 0
	dbsprite  -7, -24, $00, 0
	dbsprite  -7, -16, $00, 0
	dbsprite  -7,  -8, $00, 0
	dbsprite  -7,   0, $00, 0
	dbsprite  -7,   8, $00, 0
	dbsprite  -7,  16, $00, 0
	dbsprite  -7,  24, $00, 0

.frame_1
	db 9 ; size
	dbsprite  -7, -24, $00, 1
	dbsprite  -7, -16, $00, 1
	dbsprite  -7,  -8, $00, 1
	dbsprite  -7,   0, $00, 1
	dbsprite  -7,   8, $00, 1
	dbsprite  -7,  16, $00, 1
	dbsprite  -7,  24, $00, 1
	dbsprite  -8, -32, $01, 1
	dbsprite   0, -32, $01, 1 | OAM_YFLIP

.frame_2
	db 9 ; size
	dbsprite  -7, -32, $00, 2
	dbsprite  -7, -16, $00, 2
	dbsprite  -7,  -8, $00, 2
	dbsprite  -7,   0, $00, 2
	dbsprite  -7,   8, $00, 2
	dbsprite  -7,  16, $00, 2
	dbsprite  -7,  24, $00, 2
	dbsprite  -8, -24, $01, 2
	dbsprite   0, -24, $01, 2 | OAM_YFLIP

.frame_3
	db 9 ; size
	dbsprite  -7, -32, $00, 0
	dbsprite  -7, -24, $00, 0
	dbsprite  -7,  -8, $00, 0
	dbsprite  -7,   0, $00, 0
	dbsprite  -7,   8, $00, 0
	dbsprite  -7,  16, $00, 0
	dbsprite  -7,  24, $00, 0
	dbsprite  -8, -16, $01, 0
	dbsprite   0, -16, $01, 0 | OAM_YFLIP

.frame_4
	db 9 ; size
	dbsprite  -7, -24, $00, 1
	dbsprite  -7, -16, $00, 1
	dbsprite  -7,   0, $00, 1
	dbsprite  -7,   8, $00, 1
	dbsprite  -7,  16, $00, 1
	dbsprite  -7,  24, $00, 1
	dbsprite  -8,  -8, $01, 1
	dbsprite  -7, -32, $00, 1
	dbsprite   0,  -8, $01, 1 | OAM_YFLIP

.frame_5
	db 9 ; size
	dbsprite  -7, -16, $00, 2
	dbsprite  -7,  -8, $00, 2
	dbsprite  -7,   8, $00, 2
	dbsprite  -7,  16, $00, 2
	dbsprite  -7,  24, $00, 2
	dbsprite  -8,   0, $01, 2
	dbsprite  -7, -24, $00, 2
	dbsprite  -7, -32, $00, 2
	dbsprite   0,   0, $01, 2 | OAM_YFLIP

.frame_6
	db 9 ; size
	dbsprite  -7, -16, $00, 0
	dbsprite  -7,  -8, $00, 0
	dbsprite  -7,  16, $00, 0
	dbsprite  -7,  24, $00, 0
	dbsprite  -7, -24, $00, 0
	dbsprite  -7,   0, $00, 0
	dbsprite  -8,   8, $01, 0
	dbsprite  -7, -32, $00, 0
	dbsprite   0,   8, $01, 0 | OAM_YFLIP

.frame_7
	db 9 ; size
	dbsprite  -7,  -8, $00, 1
	dbsprite  -7,   0, $00, 1
	dbsprite  -7,  24, $00, 1
	dbsprite  -7, -16, $00, 1
	dbsprite  -7,   8, $00, 1
	dbsprite  -8,  16, $01, 1
	dbsprite  -7, -24, $00, 1
	dbsprite  -7, -32, $00, 1
	dbsprite   0,  16, $01, 1 | OAM_YFLIP

.frame_8
	db 9 ; size
	dbsprite  -7,   0, $00, 2
	dbsprite  -7,   8, $00, 2
	dbsprite  -7,  -8, $00, 2
	dbsprite  -7,  16, $00, 2
	dbsprite  -8,  24, $01, 2
	dbsprite  -7, -16, $00, 2
	dbsprite  -7, -24, $00, 2
	dbsprite  -7, -32, $00, 2
	dbsprite   0,  24, $01, 2 | OAM_YFLIP

.frame_9
	db 9 ; size
	dbsprite  -7,  24, $00, 0
	dbsprite  -8, -24, $05, 0
	dbsprite  -7, -32, $00, 0
	dbsprite  -7, -16, $00, 0
	dbsprite  -7,  -8, $00, 0
	dbsprite  -7,   0, $00, 0
	dbsprite  -7,   8, $00, 0
	dbsprite  -7,  16, $00, 0
	dbsprite   0, -24, $05, 0 | OAM_YFLIP

.frame_10
	db 9 ; size
	dbsprite  -7,  24, $00, 1
	dbsprite  -8, -16, $06, 1
	dbsprite  -7, -32, $00, 1
	dbsprite  -7, -24, $00, 1
	dbsprite  -7,  -8, $00, 1
	dbsprite  -7,   0, $00, 1
	dbsprite  -7,   8, $00, 1
	dbsprite  -7,  16, $00, 1
	dbsprite   0, -16, $06, 1 | OAM_YFLIP

.frame_11
	db 13 ; size
	dbsprite  -7,  24, $00, 2
	dbsprite  -8,  -8, $07, 2
	dbsprite  -7, -32, $00, 2
	dbsprite  -7, -24, $00, 2
	dbsprite  -7, -16, $00, 2
	dbsprite  -7,   0, $00, 2
	dbsprite  -7,   8, $00, 2
	dbsprite  -7,  16, $00, 2
	dbsprite   0,  -8, $07, 2 | OAM_YFLIP
	dbsprite -16,  -8, $04, 2
	dbsprite   8,  -8, $04, 2 | OAM_YFLIP
	dbsprite -24,  -8, $02, 2
	dbsprite  16,  -8, $02, 2 | OAM_YFLIP

.frame_12
	db 9 ; size
	dbsprite  -7,  24, $00, 0
	dbsprite  -8,   0, $08, 0
	dbsprite  -7, -32, $00, 0
	dbsprite  -7, -24, $00, 0
	dbsprite  -7, -16, $00, 0
	dbsprite  -7,  -8, $00, 0
	dbsprite  -7,   8, $00, 0
	dbsprite  -7,  16, $00, 0
	dbsprite   0,   0, $08, 0 | OAM_YFLIP

.frame_13
	db 11 ; size
	dbsprite  -7,  24, $00, 1
	dbsprite -16,   8, $03, 1
	dbsprite  -8,   8, $09, 1
	dbsprite  -7, -32, $00, 1
	dbsprite  -7,  16, $00, 1
	dbsprite  -7,   0, $00, 1
	dbsprite  -7,  -8, $00, 1
	dbsprite  -7, -16, $00, 1
	dbsprite  -7, -24, $00, 1
	dbsprite   8,   8, $03, 1 | OAM_YFLIP
	dbsprite   0,   8, $09, 1 | OAM_YFLIP

.frame_14
	db 13 ; size
	dbsprite  -7,  24, $00, 2
	dbsprite -24,  16, $02, 2
	dbsprite -16,  16, $04, 2
	dbsprite  -8,  16, $0a, 2
	dbsprite  -7, -32, $00, 2
	dbsprite  -7,   8, $00, 2
	dbsprite  -7,   0, $00, 2
	dbsprite  -7,  -8, $00, 2
	dbsprite  -7, -16, $00, 2
	dbsprite  -7, -24, $00, 2
	dbsprite  16,  16, $02, 2 | OAM_YFLIP
	dbsprite   8,  16, $04, 2 | OAM_YFLIP
	dbsprite   0,  16, $0a, 2 | OAM_YFLIP

OAMData2D::
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
	db 4 ; size
	dbsprite -72,   0, $00, 1
	dbsprite -72, -64, $00, 0 | OAM_XFLIP
	dbsprite -64,  40, $00, 1
	dbsprite -72,  24, $00, 0 | OAM_XFLIP

.frame_1
	db 6 ; size
	dbsprite -66, -22, $00, 0
	dbsprite -66, -42, $00, 1 | OAM_XFLIP
	dbsprite -50,  18, $00, 0
	dbsprite -72,  -8, $00, 1 | OAM_XFLIP
	dbsprite -72,  40, $00, 1
	dbsprite -66,  54, $00, 0 | OAM_XFLIP

.frame_2
	db 5 ; size
	dbsprite -64, -32, $00, 0 | OAM_XFLIP
	dbsprite -48,   8, $00, 0
	dbsprite -66,  22, $00, 1 | OAM_XFLIP
	dbsprite -58,   2, $00, 1
	dbsprite -64,  56, $00, 0 | OAM_XFLIP

.frame_3
	db 7 ; size
	dbsprite -56, -24, $00, 1 | OAM_XFLIP
	dbsprite -56, -40, $00, 0
	dbsprite -40,  16, $00, 1 | OAM_XFLIP
	dbsprite -64,  32, $00, 0 | OAM_XFLIP
	dbsprite -56,  -8, $00, 0
	dbsprite -56,  48, $00, 1
	dbsprite -66, -62, $00, 1

.frame_4
	db 8 ; size
	dbsprite -50,   6, $00, 0 | OAM_XFLIP
	dbsprite -50, -62, $00, 1
	dbsprite -26,  46, $00, 1 | OAM_XFLIP
	dbsprite -56,  24, $00, 0
	dbsprite -48,   0, $00, 1 | OAM_XFLIP
	dbsprite -42,  18, $00, 1
	dbsprite -64, -72, $00, 0
	dbsprite -64, -24, $00, 0

.frame_5
	db 10 ; size
	dbsprite -48,  16, $00, 1 | OAM_XFLIP
	dbsprite -48, -72, $00, 1
	dbsprite -24,  56, $00, 0 | OAM_XFLIP
	dbsprite -50,  -6, $00, 0
	dbsprite -34,  38, $00, 0 | OAM_XFLIP
	dbsprite -40,   0, $00, 0
	dbsprite -56, -64, $00, 0 | OAM_XFLIP
	dbsprite -64, -32, $00, 1
	dbsprite -72,  48, $00, 1
	dbsprite -72,   0, $00, 1

.frame_6
	db 11 ; size
	dbsprite -40,   8, $00, 0
	dbsprite -40, -64, $00, 1 | OAM_XFLIP
	dbsprite -16,  48, $00, 1
	dbsprite -48, -16, $00, 1
	dbsprite -32,  56, $00, 0 | OAM_XFLIP
	dbsprite -32,   8, $00, 1 | OAM_XFLIP
	dbsprite -42, -34, $00, 0 | OAM_XFLIP
	dbsprite -56, -24, $00, 0 | OAM_XFLIP
	dbsprite -64,  24, $00, 1
	dbsprite -72, -48, $00, 1 | OAM_XFLIP
	dbsprite -64, -32, $00, 0

.frame_7
	db 12 ; size
	dbsprite -34, -18, $00, 1
	dbsprite -26, -30, $00, 0 | OAM_XFLIP
	dbsprite  -2,  14, $00, 1
	dbsprite -40,  -8, $00, 0 | OAM_XFLIP
	dbsprite -24,  48, $00, 1
	dbsprite -18,  50, $00, 0 | OAM_XFLIP
	dbsprite -40, -24, $00, 1 | OAM_XFLIP
	dbsprite -48,   8, $00, 0 | OAM_XFLIP
	dbsprite -64,  16, $00, 1
	dbsprite -72, -72, $00, 0 | OAM_XFLIP
	dbsprite -64,  -8, $00, 0 | OAM_XFLIP
	dbsprite -64, -40, $00, 1

.frame_8
	db 12 ; size
	dbsprite -32, -40, $00, 0
	dbsprite -24, -16, $00, 0 | OAM_XFLIP
	dbsprite   0,   0, $00, 0
	dbsprite -26,  18, $00, 1 | OAM_XFLIP
	dbsprite -10,  14, $00, 1
	dbsprite -16,  64, $00, 0 | OAM_XFLIP
	dbsprite -32, -32, $00, 1
	dbsprite -48,  16, $00, 1 | OAM_XFLIP
	dbsprite -56,  24, $00, 0 | OAM_XFLIP
	dbsprite -64, -40, $00, 1 | OAM_XFLIP
	dbsprite -64,   0, $00, 0 | OAM_XFLIP
	dbsprite -56, -32, $00, 1 | OAM_XFLIP

.frame_9
	db 14 ; size
	dbsprite -24, -24, $00, 1 | OAM_XFLIP
	dbsprite -16, -24, $00, 1
	dbsprite   8,   8, $00, 1 | OAM_XFLIP
	dbsprite -24,  32, $00, 0 | OAM_XFLIP
	dbsprite  -8,   0, $00, 1
	dbsprite  -8,  56, $00, 0
	dbsprite -10, -58, $00, 0
	dbsprite -40,   8, $00, 0
	dbsprite -48,  64, $00, 1 | OAM_XFLIP
	dbsprite -72, -16, $00, 0
	dbsprite -64, -32, $00, 0 | OAM_XFLIP
	dbsprite -56,  -8, $00, 1
	dbsprite -48,  24, $00, 0 | OAM_XFLIP
	dbsprite -72,  48, $00, 1

.frame_10
	db 15 ; size
	dbsprite -18,  14, $00, 1 | OAM_XFLIP
	dbsprite  -2, -58, $00, 0
	dbsprite  14,  46, $00, 1 | OAM_XFLIP
	dbsprite -16,  24, $00, 0
	dbsprite   0,   8, $00, 1 | OAM_XFLIP
	dbsprite   6,  30, $00, 0
	dbsprite  -8, -72, $00, 1
	dbsprite -32, -24, $00, 0
	dbsprite -48,  72, $00, 1 | OAM_XFLIP
	dbsprite -64, -56, $00, 0
	dbsprite -56, -40, $00, 0
	dbsprite -48, -56, $00, 1
	dbsprite -48,  32, $00, 0 | OAM_XFLIP
	dbsprite -72,  16, $00, 1
	dbsprite -64,   8, $00, 1

.frame_11
	db 15 ; size
	dbsprite -16,  24, $00, 1 | OAM_XFLIP
	dbsprite   0, -72, $00, 1
	dbsprite  16,  56, $00, 1 | OAM_XFLIP
	dbsprite  -2, -10, $00, 0
	dbsprite  14,  54, $00, 0 | OAM_XFLIP
	dbsprite   8,  16, $00, 1
	dbsprite   0, -64, $00, 0 | OAM_XFLIP
	dbsprite -32, -32, $00, 0
	dbsprite -40,  64, $00, 0
	dbsprite -64, -64, $00, 0
	dbsprite -48, -80, $00, 1
	dbsprite -48, -64, $00, 0
	dbsprite -40,  24, $00, 1
	dbsprite -64, -24, $00, 1
	dbsprite -64,   0, $00, 0

.frame_12
	db 13 ; size
	dbsprite  -8,  16, $00, 0
	dbsprite   8, -64, $00, 0 | OAM_XFLIP
	dbsprite   0, -24, $00, 1
	dbsprite  16,  72, $00, 1 | OAM_XFLIP
	dbsprite  16,  24, $00, 0 | OAM_XFLIP
	dbsprite  14, -18, $00, 1 | OAM_XFLIP
	dbsprite -24, -24, $00, 0 | OAM_XFLIP
	dbsprite -24,  32, $00, 1
	dbsprite -56, -56, $00, 0 | OAM_XFLIP
	dbsprite -40, -56, $00, 0 | OAM_XFLIP
	dbsprite -32, -16, $00, 1
	dbsprite -64, -32, $00, 1
	dbsprite -56,   8, $00, 1 | OAM_XFLIP

.frame_13
	db 12 ; size
	dbsprite   6, -26, $00, 0
	dbsprite  22, -22, $00, 1 | OAM_XFLIP
	dbsprite   8, -16, $00, 1 | OAM_XFLIP
	dbsprite  16,   0, $00, 0 | OAM_XFLIP
	dbsprite -16,  16, $00, 1 | OAM_XFLIP
	dbsprite -32,  24, $00, 1
	dbsprite -48, -24, $00, 1 | OAM_XFLIP
	dbsprite -40, -80, $00, 1 | OAM_XFLIP
	dbsprite -24, -16, $00, 0 | OAM_XFLIP
	dbsprite -32, -24, $00, 0
	dbsprite -56, -24, $00, 0 | OAM_XFLIP
	dbsprite -48,  48, $00, 0 | OAM_XFLIP

.frame_14
	db 11 ; size
	dbsprite  16, -48, $00, 1
	dbsprite  22,  26, $00, 0 | OAM_XFLIP
	dbsprite  24,  -8, $00, 1
	dbsprite -16,  24, $00, 0 | OAM_XFLIP
	dbsprite -24,  32, $00, 1 | OAM_XFLIP
	dbsprite -40, -32, $00, 1
	dbsprite -24, -40, $00, 0 | OAM_XFLIP
	dbsprite -24,  -8, $00, 0 | OAM_XFLIP
	dbsprite -24, -16, $00, 1 | OAM_XFLIP
	dbsprite -48,  24, $00, 1 | OAM_XFLIP
	dbsprite -48,  64, $00, 0 | OAM_XFLIP

OAMData2E::
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
	db 12 ; size
	dbsprite -24, -32, $00, 2
	dbsprite -24, -24, $01, 2
	dbsprite -16, -32, $02, 2
	dbsprite -24,  24, $00, 2 | OAM_XFLIP
	dbsprite -24,  16, $01, 2 | OAM_XFLIP
	dbsprite -16,  24, $02, 2 | OAM_XFLIP
	dbsprite  16, -32, $00, 2 | OAM_YFLIP
	dbsprite  16, -24, $01, 2 | OAM_YFLIP
	dbsprite   8, -32, $02, 2 | OAM_YFLIP
	dbsprite  16,  24, $00, 2 | OAM_XFLIP | OAM_YFLIP
	dbsprite  16,  16, $01, 2 | OAM_XFLIP | OAM_YFLIP
	dbsprite   8,  24, $02, 2 | OAM_XFLIP | OAM_YFLIP

.frame_1
	db 12 ; size
	dbsprite -24, -32, $03, 0
	dbsprite -24, -24, $04, 0
	dbsprite -16, -32, $05, 0
	dbsprite -24,  24, $03, 0 | OAM_XFLIP
	dbsprite -24,  16, $04, 0 | OAM_XFLIP
	dbsprite -16,  24, $05, 0 | OAM_XFLIP
	dbsprite  16, -32, $03, 0 | OAM_YFLIP
	dbsprite  16, -24, $04, 0 | OAM_YFLIP
	dbsprite   8, -32, $05, 0 | OAM_YFLIP
	dbsprite  16,  24, $03, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite  16,  16, $04, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite   8,  24, $05, 0 | OAM_XFLIP | OAM_YFLIP

.frame_2
	db 12 ; size
	dbsprite -24, -32, $06, 1
	dbsprite -24, -24, $07, 1
	dbsprite -16, -32, $08, 1
	dbsprite -24,  24, $06, 1 | OAM_XFLIP
	dbsprite -24,  16, $07, 1 | OAM_XFLIP
	dbsprite -16,  24, $08, 1 | OAM_XFLIP
	dbsprite  16, -32, $06, 1 | OAM_YFLIP
	dbsprite  16, -24, $07, 1 | OAM_YFLIP
	dbsprite   8, -32, $08, 1 | OAM_YFLIP
	dbsprite  16,  24, $06, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite  16,  16, $07, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite   8,  24, $08, 1 | OAM_XFLIP | OAM_YFLIP

.frame_3
	db 12 ; size
	dbsprite -24, -32, $09, 2
	dbsprite -24, -24, $0a, 2
	dbsprite -16, -32, $0b, 2
	dbsprite -24,  24, $09, 2 | OAM_XFLIP
	dbsprite -24,  16, $0a, 2 | OAM_XFLIP
	dbsprite -16,  24, $0b, 2 | OAM_XFLIP
	dbsprite  16, -32, $09, 2 | OAM_YFLIP
	dbsprite  16, -24, $0a, 2 | OAM_YFLIP
	dbsprite   8, -32, $0b, 2 | OAM_YFLIP
	dbsprite  16,  24, $09, 2 | OAM_XFLIP | OAM_YFLIP
	dbsprite  16,  16, $0a, 2 | OAM_XFLIP | OAM_YFLIP
	dbsprite   8,  24, $0b, 2 | OAM_XFLIP | OAM_YFLIP

.frame_4
	db 12 ; size
	dbsprite -21, -28, $09, 0
	dbsprite -21, -20, $0a, 0
	dbsprite -13, -28, $0b, 0
	dbsprite -21,  20, $09, 0 | OAM_XFLIP
	dbsprite -21,  12, $0a, 0 | OAM_XFLIP
	dbsprite -13,  20, $0b, 0 | OAM_XFLIP
	dbsprite  13, -28, $09, 0 | OAM_YFLIP
	dbsprite  13, -20, $0a, 0 | OAM_YFLIP
	dbsprite   5, -28, $0b, 0 | OAM_YFLIP
	dbsprite  13,  20, $09, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite  13,  12, $0a, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite   5,  20, $0b, 0 | OAM_XFLIP | OAM_YFLIP

.frame_5
	db 12 ; size
	dbsprite -18, -24, $09, 1
	dbsprite -18, -16, $0a, 1
	dbsprite -10, -24, $0b, 1
	dbsprite -18,  16, $09, 1 | OAM_XFLIP
	dbsprite -18,   8, $0a, 1 | OAM_XFLIP
	dbsprite -10,  16, $0b, 1 | OAM_XFLIP
	dbsprite  10, -24, $09, 1 | OAM_YFLIP
	dbsprite  10, -16, $0a, 1 | OAM_YFLIP
	dbsprite   2, -24, $0b, 1 | OAM_YFLIP
	dbsprite  10,  16, $09, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite  10,   8, $0a, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite   2,  16, $0b, 1 | OAM_XFLIP | OAM_YFLIP

.frame_6
	db 12 ; size
	dbsprite -15, -20, $09, 2
	dbsprite -15, -12, $0a, 2
	dbsprite  -7, -20, $0b, 2
	dbsprite -15,  12, $09, 2 | OAM_XFLIP
	dbsprite -15,   4, $0a, 2 | OAM_XFLIP
	dbsprite  -7,  12, $0b, 2 | OAM_XFLIP
	dbsprite   7, -20, $09, 2 | OAM_YFLIP
	dbsprite   7, -12, $0a, 2 | OAM_YFLIP
	dbsprite  -1, -20, $0b, 2 | OAM_YFLIP
	dbsprite   7,  12, $09, 2 | OAM_XFLIP | OAM_YFLIP
	dbsprite   7,   4, $0a, 2 | OAM_XFLIP | OAM_YFLIP
	dbsprite  -1,  12, $0b, 2 | OAM_XFLIP | OAM_YFLIP

.frame_7
	db 12 ; size
	dbsprite   4, -16, $09, 0 | OAM_YFLIP
	dbsprite   4,  -8, $0a, 0 | OAM_YFLIP
	dbsprite  -4, -16, $0b, 0 | OAM_YFLIP
	dbsprite   4,   8, $09, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite   4,   0, $0a, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite  -4,   8, $0b, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite -12, -16, $09, 0
	dbsprite -12,  -8, $0a, 0
	dbsprite  -4, -16, $0b, 0
	dbsprite -12,   8, $09, 0 | OAM_XFLIP
	dbsprite -12,   0, $0a, 0 | OAM_XFLIP
	dbsprite  -4,   8, $0b, 0 | OAM_XFLIP

.frame_8
	db 28 ; size
	dbsprite -20, -16, $0c, 1
	dbsprite -20,  -8, $0d, 1
	dbsprite -20,   8, $0c, 1 | OAM_XFLIP
	dbsprite -20,   0, $0d, 1 | OAM_XFLIP
	dbsprite  12, -16, $0c, 1 | OAM_YFLIP
	dbsprite  12,  -8, $0d, 1 | OAM_YFLIP
	dbsprite  12,   8, $0c, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite  12,   0, $0d, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite -16,  16, $14, 1
	dbsprite  -8,  16, $15, 1
	dbsprite   0,  16, $15, 1
	dbsprite   8,  16, $14, 1 | OAM_YFLIP
	dbsprite -16, -24, $14, 1 | OAM_XFLIP
	dbsprite  -8, -24, $15, 1 | OAM_XFLIP
	dbsprite   0, -24, $15, 1 | OAM_XFLIP
	dbsprite   8, -24, $14, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite   4, -16, $09, 1 | OAM_YFLIP
	dbsprite   4,  -8, $0a, 1 | OAM_YFLIP
	dbsprite  -4, -16, $0b, 1 | OAM_YFLIP
	dbsprite   4,   8, $09, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite   4,   0, $0a, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite  -4,   8, $0b, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite -12, -16, $09, 1
	dbsprite -12,  -8, $0a, 1
	dbsprite  -4, -16, $0b, 1
	dbsprite -12,   8, $09, 1 | OAM_XFLIP
	dbsprite -12,   0, $0a, 1 | OAM_XFLIP
	dbsprite  -4,   8, $0b, 1 | OAM_XFLIP

.frame_9
	db 28 ; size
	dbsprite  12,   8, $0e, 2 | OAM_XFLIP | OAM_YFLIP
	dbsprite  12,   0, $0f, 2 | OAM_XFLIP | OAM_YFLIP
	dbsprite   8,  16, $16, 2 | OAM_YFLIP
	dbsprite   0,  16, $17, 2 | OAM_YFLIP
	dbsprite  12, -16, $0e, 2 | OAM_YFLIP
	dbsprite  12,  -8, $0f, 2 | OAM_YFLIP
	dbsprite   8, -24, $16, 2 | OAM_XFLIP | OAM_YFLIP
	dbsprite   0, -24, $17, 2 | OAM_XFLIP | OAM_YFLIP
	dbsprite -20,   8, $0e, 2 | OAM_XFLIP
	dbsprite -20,   0, $0f, 2 | OAM_XFLIP
	dbsprite -16,  16, $16, 2
	dbsprite  -8,  16, $17, 2
	dbsprite -20, -16, $0e, 2
	dbsprite -20,  -8, $0f, 2
	dbsprite -16, -24, $16, 2 | OAM_XFLIP
	dbsprite  -8, -24, $17, 2 | OAM_XFLIP
	dbsprite   4, -16, $09, 2 | OAM_YFLIP
	dbsprite   4,  -8, $0a, 2 | OAM_YFLIP
	dbsprite  -4, -16, $0b, 2 | OAM_YFLIP
	dbsprite   4,   8, $09, 2 | OAM_XFLIP | OAM_YFLIP
	dbsprite   4,   0, $0a, 2 | OAM_XFLIP | OAM_YFLIP
	dbsprite  -4,   8, $0b, 2 | OAM_XFLIP | OAM_YFLIP
	dbsprite -12, -16, $09, 2
	dbsprite -12,  -8, $0a, 2
	dbsprite  -4, -16, $0b, 2
	dbsprite -12,   8, $09, 2 | OAM_XFLIP
	dbsprite -12,   0, $0a, 2 | OAM_XFLIP
	dbsprite  -4,   8, $0b, 2 | OAM_XFLIP

.frame_10
	db 28 ; size
	dbsprite  12,   8, $10, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite  12,   0, $11, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite   8,  16, $18, 0 | OAM_YFLIP
	dbsprite   0,  16, $19, 0 | OAM_YFLIP
	dbsprite  12, -16, $10, 0 | OAM_YFLIP
	dbsprite  12,  -8, $11, 0 | OAM_YFLIP
	dbsprite   8, -24, $18, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite   0, -24, $19, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite -20,   8, $10, 0 | OAM_XFLIP
	dbsprite -20,   0, $11, 0 | OAM_XFLIP
	dbsprite -16,  16, $18, 0
	dbsprite  -8,  16, $19, 0
	dbsprite -20, -16, $10, 0
	dbsprite -20,  -8, $11, 0
	dbsprite -16, -24, $18, 0 | OAM_XFLIP
	dbsprite  -8, -24, $19, 0 | OAM_XFLIP
	dbsprite   4, -16, $09, 0 | OAM_YFLIP
	dbsprite   4,  -8, $0a, 0 | OAM_YFLIP
	dbsprite  -4, -16, $0b, 0 | OAM_YFLIP
	dbsprite   4,   8, $09, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite   4,   0, $0a, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite  -4,   8, $0b, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite -12, -16, $09, 0
	dbsprite -12,  -8, $0a, 0
	dbsprite  -4, -16, $0b, 0
	dbsprite -12,   8, $09, 0 | OAM_XFLIP
	dbsprite -12,   0, $0a, 0 | OAM_XFLIP
	dbsprite  -4,   8, $0b, 0 | OAM_XFLIP

.frame_11
	db 28 ; size
	dbsprite  12,   8, $12, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite  12,   0, $13, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite   8,  16, $1a, 1 | OAM_YFLIP
	dbsprite   0,  16, $1b, 1 | OAM_YFLIP
	dbsprite  12, -16, $12, 1 | OAM_YFLIP
	dbsprite  12,  -8, $13, 1 | OAM_YFLIP
	dbsprite   8, -24, $1a, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite   0, -24, $1b, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite -20,   8, $12, 1 | OAM_XFLIP
	dbsprite -20,   0, $13, 1 | OAM_XFLIP
	dbsprite -16,  16, $1a, 1
	dbsprite  -8,  16, $1b, 1
	dbsprite -20, -16, $12, 1
	dbsprite -20,  -8, $13, 1
	dbsprite -16, -24, $1a, 1 | OAM_XFLIP
	dbsprite  -8, -24, $1b, 1 | OAM_XFLIP
	dbsprite   4, -16, $09, 1 | OAM_YFLIP
	dbsprite   4,  -8, $0a, 1 | OAM_YFLIP
	dbsprite  -4, -16, $0b, 1 | OAM_YFLIP
	dbsprite   4,   8, $09, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite   4,   0, $0a, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite  -4,   8, $0b, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite -12, -16, $09, 1
	dbsprite -12,  -8, $0a, 1
	dbsprite  -4, -16, $0b, 1
	dbsprite -12,   8, $09, 1 | OAM_XFLIP
	dbsprite -12,   0, $0a, 1 | OAM_XFLIP
	dbsprite  -4,   8, $0b, 1 | OAM_XFLIP

.frame_12
	db 28 ; size
	dbsprite  12,   8, $12, 2 | OAM_XFLIP | OAM_YFLIP
	dbsprite  12,   0, $13, 2 | OAM_XFLIP | OAM_YFLIP
	dbsprite   8,  16, $1a, 2 | OAM_YFLIP
	dbsprite   0,  16, $1b, 2 | OAM_YFLIP
	dbsprite  12, -16, $12, 2 | OAM_YFLIP
	dbsprite  12,  -8, $13, 2 | OAM_YFLIP
	dbsprite   8, -24, $1a, 2 | OAM_XFLIP | OAM_YFLIP
	dbsprite   0, -24, $1b, 2 | OAM_XFLIP | OAM_YFLIP
	dbsprite -20,   8, $12, 2 | OAM_XFLIP
	dbsprite -20,   0, $13, 2 | OAM_XFLIP
	dbsprite -16,  16, $1a, 2
	dbsprite  -8,  16, $1b, 2
	dbsprite -20, -16, $12, 2
	dbsprite -20,  -8, $13, 2
	dbsprite -16, -24, $1a, 2 | OAM_XFLIP
	dbsprite  -8, -24, $1b, 2 | OAM_XFLIP
	dbsprite   4, -16, $09, 2 | OAM_YFLIP
	dbsprite   4,  -8, $0a, 2 | OAM_YFLIP
	dbsprite  -4, -16, $0b, 2 | OAM_YFLIP
	dbsprite   4,   8, $09, 2 | OAM_XFLIP | OAM_YFLIP
	dbsprite   4,   0, $0a, 2 | OAM_XFLIP | OAM_YFLIP
	dbsprite  -4,   8, $0b, 2 | OAM_XFLIP | OAM_YFLIP
	dbsprite -12, -16, $09, 2
	dbsprite -12,  -8, $0a, 2
	dbsprite  -4, -16, $0b, 2
	dbsprite -12,   8, $09, 2 | OAM_XFLIP
	dbsprite -12,   0, $0a, 2 | OAM_XFLIP
	dbsprite  -4,   8, $0b, 2 | OAM_XFLIP

.frame_13
	db 28 ; size
	dbsprite  12,   8, $12, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite  12,   0, $13, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite   8,  16, $1a, 0 | OAM_YFLIP
	dbsprite   0,  16, $1b, 0 | OAM_YFLIP
	dbsprite  12, -16, $12, 0 | OAM_YFLIP
	dbsprite  12,  -8, $13, 0 | OAM_YFLIP
	dbsprite   8, -24, $1a, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite   0, -24, $1b, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite -20,   8, $12, 0 | OAM_XFLIP
	dbsprite -20,   0, $13, 0 | OAM_XFLIP
	dbsprite -16,  16, $1a, 0
	dbsprite  -8,  16, $1b, 0
	dbsprite -20, -16, $12, 0
	dbsprite -20,  -8, $13, 0
	dbsprite -16, -24, $1a, 0 | OAM_XFLIP
	dbsprite  -8, -24, $1b, 0 | OAM_XFLIP
	dbsprite   4, -16, $09, 0 | OAM_YFLIP
	dbsprite   4,  -8, $0a, 0 | OAM_YFLIP
	dbsprite  -4, -16, $0b, 0 | OAM_YFLIP
	dbsprite   4,   8, $09, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite   4,   0, $0a, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite  -4,   8, $0b, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite -12, -16, $09, 0
	dbsprite -12,  -8, $0a, 0
	dbsprite  -4, -16, $0b, 0
	dbsprite -12,   8, $09, 0 | OAM_XFLIP
	dbsprite -12,   0, $0a, 0 | OAM_XFLIP
	dbsprite  -4,   8, $0b, 0 | OAM_XFLIP

.frame_14
	db 12 ; size
	dbsprite   4, -16, $09, 1 | OAM_YFLIP
	dbsprite   4,  -8, $0a, 1 | OAM_YFLIP
	dbsprite  -4, -16, $0b, 1 | OAM_YFLIP
	dbsprite   4,   8, $09, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite   4,   0, $0a, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite  -4,   8, $0b, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite -12, -16, $09, 1
	dbsprite -12,  -8, $0a, 1
	dbsprite  -4, -16, $0b, 1
	dbsprite -12,   8, $09, 1 | OAM_XFLIP
	dbsprite -12,   0, $0a, 1 | OAM_XFLIP
	dbsprite  -4,   8, $0b, 1 | OAM_XFLIP

.frame_15
	db 12 ; size
	dbsprite   4, -16, $09, 2 | OAM_YFLIP
	dbsprite   4,  -8, $0a, 2 | OAM_YFLIP
	dbsprite  -4, -16, $0b, 2 | OAM_YFLIP
	dbsprite   4,   8, $09, 2 | OAM_XFLIP | OAM_YFLIP
	dbsprite   4,   0, $0a, 2 | OAM_XFLIP | OAM_YFLIP
	dbsprite  -4,   8, $0b, 2 | OAM_XFLIP | OAM_YFLIP
	dbsprite -12, -16, $09, 2
	dbsprite -12,  -8, $0a, 2
	dbsprite  -4, -16, $0b, 2
	dbsprite -12,   8, $09, 2 | OAM_XFLIP
	dbsprite -12,   0, $0a, 2 | OAM_XFLIP
	dbsprite  -4,   8, $0b, 2 | OAM_XFLIP

OAMData2F::
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
	db 6 ; size
	dbsprite -24,  -8, $15, 0
	dbsprite -24,   0, $15, 0
	dbsprite -24, -24, $14, 0
	dbsprite -24, -16, $15, 0
	dbsprite -24,   8, $15, 0
	dbsprite -24,  16, $14, 0 | OAM_XFLIP

.frame_1
	db 10 ; size
	dbsprite -24, -16, $00, 0
	dbsprite -24,  -8, $01, 0
	dbsprite -24,   0, $01, 0
	dbsprite -24,   8, $02, 0
	dbsprite -16,  -8, $15, 0
	dbsprite -16,   0, $15, 0
	dbsprite -16, -24, $14, 0
	dbsprite -16, -16, $15, 0
	dbsprite -16,   8, $15, 0
	dbsprite -16,  16, $14, 0 | OAM_XFLIP

.frame_2
	db 14 ; size
	dbsprite -24, -16, $00, 0
	dbsprite -24,  -8, $01, 0
	dbsprite -24,   0, $01, 0
	dbsprite -16, -16, $03, 0
	dbsprite -16,  -8, $04, 0
	dbsprite -16,   0, $05, 0
	dbsprite -24,   8, $02, 0
	dbsprite -16,   8, $06, 0
	dbsprite  -8,  -8, $15, 0
	dbsprite  -8,   0, $15, 0
	dbsprite  -8, -24, $14, 0
	dbsprite  -8, -16, $15, 0
	dbsprite  -8,   8, $15, 0
	dbsprite  -8,  16, $14, 0 | OAM_XFLIP

.frame_3
	db 18 ; size
	dbsprite -24, -16, $00, 0
	dbsprite -24,  -8, $01, 0
	dbsprite -24,   0, $01, 0
	dbsprite -16, -16, $03, 0
	dbsprite -16,  -8, $04, 0
	dbsprite -16,   0, $05, 0
	dbsprite  -8, -16, $07, 0
	dbsprite  -8,  -8, $05, 0
	dbsprite  -8,   0, $08, 0
	dbsprite -24,   8, $02, 0
	dbsprite -16,   8, $06, 0
	dbsprite  -8,   8, $09, 0
	dbsprite   0,  -8, $15, 0
	dbsprite   0,   0, $15, 0
	dbsprite   0, -24, $14, 0
	dbsprite   0, -16, $15, 0
	dbsprite   0,   8, $15, 0
	dbsprite   0,  16, $14, 0 | OAM_XFLIP

.frame_4
	db 22 ; size
	dbsprite -24, -16, $00, 0
	dbsprite -24,  -8, $01, 0
	dbsprite -24,   0, $01, 0
	dbsprite -16, -16, $03, 0
	dbsprite -16,  -8, $04, 0
	dbsprite -16,   0, $05, 0
	dbsprite  -8, -16, $07, 0
	dbsprite  -8,  -8, $05, 0
	dbsprite  -8,   0, $08, 0
	dbsprite   0, -16, $0a, 0
	dbsprite   0,  -8, $08, 0
	dbsprite   0,   0, $0b, 0
	dbsprite -24,   8, $02, 0
	dbsprite -16,   8, $06, 0
	dbsprite  -8,   8, $09, 0
	dbsprite   0,   8, $0c, 0
	dbsprite   8,  -8, $15, 0
	dbsprite   8,   0, $15, 0
	dbsprite   8, -24, $14, 0
	dbsprite   8, -16, $15, 0
	dbsprite   8,   8, $15, 0
	dbsprite   8,  16, $14, 0 | OAM_XFLIP

.frame_5
	db 26 ; size
	dbsprite -24, -16, $00, 0
	dbsprite -24,  -8, $01, 0
	dbsprite -24,   0, $01, 0
	dbsprite -16, -16, $03, 0
	dbsprite -16,  -8, $04, 0
	dbsprite -16,   0, $05, 0
	dbsprite  -8, -16, $07, 0
	dbsprite  -8,  -8, $05, 0
	dbsprite  -8,   0, $08, 0
	dbsprite   0, -16, $0a, 0
	dbsprite   0,  -8, $08, 0
	dbsprite   0,   0, $0b, 0
	dbsprite   8, -16, $0d, 0
	dbsprite   8,  -8, $0b, 0
	dbsprite   8,   0, $0e, 0
	dbsprite -24,   8, $02, 0
	dbsprite -16,   8, $06, 0
	dbsprite  -8,   8, $09, 0
	dbsprite   0,   8, $0c, 0
	dbsprite   8,   8, $0f, 0
	dbsprite  16,  -8, $15, 0
	dbsprite  16,   0, $15, 0
	dbsprite  16, -24, $14, 0
	dbsprite  16, -16, $15, 0
	dbsprite  16,   8, $15, 0
	dbsprite  16,  16, $14, 0 | OAM_XFLIP

.frame_6
	db 24 ; size
	dbsprite -24, -16, $00, 0
	dbsprite -24,  -8, $01, 0
	dbsprite -24,   0, $01, 0
	dbsprite -16, -16, $03, 0
	dbsprite -16,  -8, $04, 0
	dbsprite -16,   0, $05, 0
	dbsprite  -8, -16, $07, 0
	dbsprite  -8,  -8, $05, 0
	dbsprite  -8,   0, $08, 0
	dbsprite   0, -16, $0a, 0
	dbsprite   0,  -8, $08, 0
	dbsprite   0,   0, $0b, 0
	dbsprite   8, -16, $0d, 0
	dbsprite   8,  -8, $0b, 0
	dbsprite   8,   0, $0e, 0
	dbsprite -24,   8, $02, 0
	dbsprite -16,   8, $06, 0
	dbsprite  -8,   8, $09, 0
	dbsprite   0,   8, $0c, 0
	dbsprite   8,   8, $0f, 0
	dbsprite  16, -16, $10, 0
	dbsprite  16,  -8, $11, 0
	dbsprite  16,   0, $12, 0
	dbsprite  16,   8, $13, 0

.frame_7
	db 24 ; size
	dbsprite -24, -16, $00, 1
	dbsprite -24,  -8, $01, 1
	dbsprite -24,   0, $01, 1
	dbsprite -16, -16, $03, 1
	dbsprite -16,  -8, $04, 1
	dbsprite -16,   0, $05, 1
	dbsprite  -8, -16, $07, 1
	dbsprite  -8,  -8, $05, 1
	dbsprite  -8,   0, $08, 1
	dbsprite   0, -16, $0a, 1
	dbsprite   0,  -8, $08, 1
	dbsprite   0,   0, $0b, 1
	dbsprite   8, -16, $0d, 1
	dbsprite   8,  -8, $0b, 1
	dbsprite   8,   0, $0e, 1
	dbsprite -24,   8, $02, 1
	dbsprite -16,   8, $06, 1
	dbsprite  -8,   8, $09, 1
	dbsprite   0,   8, $0c, 1
	dbsprite   8,   8, $0f, 1
	dbsprite  16, -16, $10, 1
	dbsprite  16,  -8, $11, 1
	dbsprite  16,   0, $12, 1
	dbsprite  16,   8, $13, 1

.frame_8
	db 24 ; size
	dbsprite -24, -16, $00, 2
	dbsprite -24,  -8, $01, 2
	dbsprite -24,   0, $01, 2
	dbsprite -16, -16, $03, 2
	dbsprite -16,  -8, $04, 2
	dbsprite -16,   0, $05, 2
	dbsprite  -8, -16, $07, 2
	dbsprite  -8,  -8, $05, 2
	dbsprite  -8,   0, $08, 2
	dbsprite   0, -16, $0a, 2
	dbsprite   0,  -8, $08, 2
	dbsprite   0,   0, $0b, 2
	dbsprite   8, -16, $0d, 2
	dbsprite   8,  -8, $0b, 2
	dbsprite   8,   0, $0e, 2
	dbsprite -24,   8, $02, 2
	dbsprite -16,   8, $06, 2
	dbsprite  -8,   8, $09, 2
	dbsprite   0,   8, $0c, 2
	dbsprite   8,   8, $0f, 2
	dbsprite  16, -16, $10, 2
	dbsprite  16,  -8, $11, 2
	dbsprite  16,   0, $12, 2
	dbsprite  16,   8, $13, 2

OAMData30::
	dw .frame_0
	dw .frame_1

.frame_0
	db 19 ; size
	dbsprite -44, -104, $03, 2
	dbsprite -43, -96, $04, 2
	dbsprite -42, -88, $0e, 2
	dbsprite -41, -80, $0f, 2
	dbsprite -51, -96, $0a, 2
	dbsprite -50, -88, $0b, 2
	dbsprite -49, -80, $0c, 2
	dbsprite -48, -72, $0d, 1
	dbsprite -59, -96, $06, 2
	dbsprite -58, -88, $07, 2
	dbsprite -57, -80, $08, 1
	dbsprite -56, -72, $09, 0
	dbsprite -67, -96, $03, 2
	dbsprite -66, -88, $04, 2
	dbsprite -65, -80, $05, 2
	dbsprite -74, -88, $00, 2
	dbsprite -73, -80, $01, 1
	dbsprite -72, -72, $02, 0
	dbsprite -64, -72, $02, 1 | OAM_YFLIP

.frame_1
	db 19 ; size
	dbsprite -36, -64, $03, 2 | OAM_XFLIP
	dbsprite -37, -72, $04, 2 | OAM_XFLIP
	dbsprite -38, -80, $0e, 2 | OAM_XFLIP
	dbsprite -39, -88, $0f, 2 | OAM_XFLIP
	dbsprite -45, -72, $0a, 2 | OAM_XFLIP
	dbsprite -46, -80, $0b, 2 | OAM_XFLIP
	dbsprite -47, -88, $0c, 2 | OAM_XFLIP
	dbsprite -48, -96, $0d, 1 | OAM_XFLIP
	dbsprite -53, -72, $06, 2 | OAM_XFLIP
	dbsprite -54, -80, $07, 2 | OAM_XFLIP
	dbsprite -55, -88, $08, 1 | OAM_XFLIP
	dbsprite -56, -96, $09, 0 | OAM_XFLIP
	dbsprite -61, -72, $03, 2 | OAM_XFLIP
	dbsprite -62, -80, $04, 2 | OAM_XFLIP
	dbsprite -63, -88, $05, 2 | OAM_XFLIP
	dbsprite -70, -80, $00, 2 | OAM_XFLIP
	dbsprite -71, -88, $01, 1 | OAM_XFLIP
	dbsprite -72, -96, $02, 0 | OAM_XFLIP
	dbsprite -64, -96, $02, 1 | OAM_XFLIP | OAM_YFLIP

OAMData31::
	dw .frame_0
	dw .frame_1
	dw .frame_2

.frame_0
	db 4 ; size
	dbsprite  -7,  -7, $00, 0
	dbsprite  -7,   1, $01, 0
	dbsprite   1,  -7, $02, 0
	dbsprite   1,   1, $03, 2

.frame_1
	db 11 ; size
	dbsprite -23,  -8, $04, 0
	dbsprite -23,   0, $05, 0
	dbsprite -23,   8, $06, 1
	dbsprite -15,  -8, $07, 1
	dbsprite -15,   0, $08, 1
	dbsprite -15,   8, $09, 1
	dbsprite  -7,  -8, $0a, 0
	dbsprite  -7,   0, $0b, 0
	dbsprite  -7,   8, $0c, 2
	dbsprite   1,   0, $0d, 2
	dbsprite   1,   8, $0e, 2

.frame_2
	db 11 ; size
	dbsprite -23,  16, $04, 0 | OAM_XFLIP
	dbsprite -23,   8, $05, 0 | OAM_XFLIP
	dbsprite -23,   0, $06, 1 | OAM_XFLIP
	dbsprite -15,  16, $07, 1 | OAM_XFLIP
	dbsprite -15,   8, $08, 1 | OAM_XFLIP
	dbsprite -15,   0, $09, 1 | OAM_XFLIP
	dbsprite  -7,  16, $0a, 0 | OAM_XFLIP
	dbsprite  -7,   8, $0b, 0 | OAM_XFLIP
	dbsprite  -7,   0, $0c, 2 | OAM_XFLIP
	dbsprite   1,   8, $0d, 2 | OAM_XFLIP
	dbsprite   1,   0, $0e, 2 | OAM_XFLIP

OAMData32::
	dw .frame_0
	dw .frame_1
	dw .frame_2
	dw .frame_3
	dw .frame_4
	dw .frame_5
	dw .frame_6

.frame_0
	db 6 ; size
	dbsprite  -8, -16, $00, 0
	dbsprite  -8,   8, $02, 0
	dbsprite  -8,  16, $03, 0 | OAM_YFLIP
	dbsprite  -8,   0, $01, 0 | OAM_XFLIP
	dbsprite  -8, -24, $01, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite  -8,  -8, $03, 0

.frame_1
	db 6 ; size
	dbsprite  -8, -16, $02, 0
	dbsprite  -8,   8, $00, 0
	dbsprite  -8,  16, $01, 0 | OAM_YFLIP
	dbsprite  -8,   0, $03, 0 | OAM_XFLIP
	dbsprite  -8, -24, $03, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite  -8,  -8, $01, 0

.frame_2
	db 10 ; size
	dbsprite   0, -20, $05, 0
	dbsprite   8, -20, $06, 0
	dbsprite  -8, -16, $00, 0
	dbsprite  -8,   8, $02, 0
	dbsprite  -8,  16, $03, 0 | OAM_YFLIP
	dbsprite  -8,   0, $01, 0 | OAM_XFLIP
	dbsprite  -8, -24, $01, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite  -8,  -8, $03, 0
	dbsprite   0, -12, $05, 1 | OAM_XFLIP
	dbsprite   8, -12, $06, 0 | OAM_XFLIP

.frame_3
	db 11 ; size
	dbsprite   0, -16, $04, 0
	dbsprite   8, -20, $05, 0
	dbsprite  16, -20, $06, 1
	dbsprite  -8, -16, $02, 0
	dbsprite  -8,   8, $00, 0
	dbsprite  -8,  16, $01, 0 | OAM_YFLIP
	dbsprite  -8,   0, $03, 0 | OAM_XFLIP
	dbsprite  -8, -24, $03, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite  -8,  -8, $01, 0
	dbsprite   8, -12, $05, 1 | OAM_XFLIP
	dbsprite  16, -12, $06, 2 | OAM_XFLIP

.frame_4
	db 16 ; size
	dbsprite   0, -16, $04, 0
	dbsprite   8, -16, $04, 0
	dbsprite  16, -20, $05, 0
	dbsprite   0,   4, $05, 0
	dbsprite   8,   4, $06, 1
	dbsprite  24, -20, $06, 1
	dbsprite  -8, -16, $00, 0
	dbsprite  -8,   8, $02, 0
	dbsprite  -8,  16, $03, 0 | OAM_YFLIP
	dbsprite  -8,   0, $01, 0 | OAM_XFLIP
	dbsprite  -8, -24, $01, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite  -8,  -8, $03, 0
	dbsprite  16, -12, $05, 1 | OAM_XFLIP
	dbsprite  24, -12, $06, 2 | OAM_XFLIP
	dbsprite   0,  12, $05, 1 | OAM_XFLIP
	dbsprite   8,  12, $06, 2 | OAM_XFLIP

.frame_5
	db 16 ; size
	dbsprite   0, -16, $04, 0
	dbsprite   0,   8, $04, 0
	dbsprite   8,   4, $05, 0
	dbsprite  16,   4, $06, 1
	dbsprite   8, -20, $05, 0
	dbsprite  16, -20, $06, 1
	dbsprite  -8, -16, $02, 0
	dbsprite  -8,   8, $00, 0
	dbsprite  -8,  16, $01, 0 | OAM_YFLIP
	dbsprite  -8,   0, $03, 0 | OAM_XFLIP
	dbsprite  -8, -24, $03, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite  -8,  -8, $01, 0
	dbsprite   8, -12, $05, 1 | OAM_XFLIP
	dbsprite  16, -12, $06, 2 | OAM_XFLIP
	dbsprite   8,  12, $05, 1 | OAM_XFLIP
	dbsprite  16,  12, $06, 2 | OAM_XFLIP

.frame_6
	db 16 ; size
	dbsprite   0,   8, $04, 0
	dbsprite   8,   8, $04, 0
	dbsprite   0, -20, $05, 0
	dbsprite   8, -20, $06, 1
	dbsprite  16,   4, $05, 0
	dbsprite  24,   4, $06, 1
	dbsprite  -8, -16, $00, 0
	dbsprite  -8,   8, $02, 0
	dbsprite  -8,  16, $03, 0 | OAM_YFLIP
	dbsprite  -8,   0, $01, 0 | OAM_XFLIP
	dbsprite  -8, -24, $01, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite  -8,  -8, $03, 0
	dbsprite   0, -12, $05, 1 | OAM_XFLIP
	dbsprite   8, -12, $06, 2 | OAM_XFLIP
	dbsprite  16,  12, $05, 1 | OAM_XFLIP
	dbsprite  24,  12, $06, 2 | OAM_XFLIP

OAMData34::
	dw .frame_0
	dw .frame_1
	dw .frame_2
	dw .frame_3
	dw .frame_4
	dw .frame_5
	dw .frame_6
	dw .frame_7

.frame_0
	db 1 ; size
	dbsprite  -4,  -4, $05, 0

.frame_1
	db 12 ; size
	dbsprite  -8, -16, $06, 0
	dbsprite   0, -16, $06, 0 | OAM_YFLIP
	dbsprite  -8,  -8, $07, 0
	dbsprite   0,  -8, $07, 0 | OAM_YFLIP
	dbsprite -16,  -8, $08, 0
	dbsprite   8,  -8, $08, 0 | OAM_YFLIP
	dbsprite  -8,   8, $06, 0 | OAM_XFLIP
	dbsprite   0,   8, $06, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite  -8,   0, $07, 0 | OAM_XFLIP
	dbsprite   0,   0, $07, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite -16,   0, $08, 0 | OAM_XFLIP
	dbsprite   8,   0, $08, 0 | OAM_XFLIP | OAM_YFLIP

.frame_2
	db 4 ; size
	dbsprite  -8,  -8, $02, 0
	dbsprite  -8,   0, $03, 0
	dbsprite   0,  -8, $00, 0
	dbsprite   0,   0, $01, 0

.frame_3
	db 32 ; size
	dbsprite -40,  -8, $02, 0
	dbsprite -40,   0, $03, 0
	dbsprite -32,  -8, $00, 0
	dbsprite -32,   0, $01, 0
	dbsprite  -8, -32, $03, 0
	dbsprite   0, -32, $01, 0
	dbsprite  24,  -8, $02, 0
	dbsprite  24,   0, $03, 0
	dbsprite  32,  -8, $00, 0
	dbsprite  32,   0, $01, 0
	dbsprite  -8,  24, $02, 0
	dbsprite  -8,  32, $03, 0
	dbsprite   0,  24, $00, 0
	dbsprite   0,  32, $01, 0
	dbsprite -32, -32, $02, 0
	dbsprite -32, -24, $03, 0
	dbsprite -24, -32, $00, 0
	dbsprite -24, -24, $01, 0
	dbsprite -32,  16, $02, 0
	dbsprite -32,  24, $03, 0
	dbsprite -24,  16, $00, 0
	dbsprite -24,  24, $01, 0
	dbsprite  16, -32, $02, 0
	dbsprite  16, -24, $03, 0
	dbsprite  24, -32, $00, 0
	dbsprite  24, -24, $01, 0
	dbsprite  16,  16, $02, 0
	dbsprite  16,  24, $03, 0
	dbsprite  24,  16, $00, 0
	dbsprite  24,  24, $01, 0
	dbsprite  -8, -40, $02, 0
	dbsprite   0, -40, $00, 0

.frame_4
	db 32 ; size
	dbsprite -48,  -8, $02, 0
	dbsprite -48,   0, $03, 0
	dbsprite -40,  -8, $00, 0
	dbsprite -40,   0, $01, 0
	dbsprite  32,  -8, $02, 0
	dbsprite  32,   0, $03, 0
	dbsprite  40,  -8, $00, 0
	dbsprite  40,   0, $01, 0
	dbsprite  -8,  32, $02, 0
	dbsprite  -8,  40, $03, 0
	dbsprite   0,  32, $00, 0
	dbsprite   0,  40, $01, 0
	dbsprite -40, -32, $03, 0
	dbsprite -32, -32, $01, 0
	dbsprite -40,  24, $02, 0
	dbsprite -40,  32, $03, 0
	dbsprite -32,  24, $00, 0
	dbsprite -32,  32, $01, 0
	dbsprite  24, -32, $03, 0
	dbsprite  32, -32, $01, 0
	dbsprite  24,  24, $02, 0
	dbsprite  24,  32, $03, 0
	dbsprite  32,  24, $00, 0
	dbsprite  32,  32, $01, 0
	dbsprite  -8, -48, $02, 0
	dbsprite  -8, -40, $03, 0
	dbsprite   0, -48, $00, 0
	dbsprite   0, -40, $01, 0
	dbsprite -40, -40, $02, 0
	dbsprite -32, -40, $00, 0
	dbsprite  24, -40, $02, 0
	dbsprite  32, -40, $00, 0

.frame_5
	db 8 ; size
	dbsprite -56,  -4, $04, 0
	dbsprite  -4,  48, $04, 0
	dbsprite -44,  36, $04, 0
	dbsprite  28,  36, $04, 0
	dbsprite -44, -44, $04, 0
	dbsprite  28, -44, $04, 0
	dbsprite  -4, -56, $04, 0
	dbsprite  40,  -4, $04, 0

.frame_6
	db 16 ; size
	dbsprite -16,  -8, $02, 0
	dbsprite -16,   0, $03, 0
	dbsprite  -8,  -8, $00, 0
	dbsprite  -8,   0, $01, 0
	dbsprite   0,  -8, $02, 0
	dbsprite   0,   0, $03, 0
	dbsprite   8,  -8, $00, 0
	dbsprite   8,   0, $01, 0
	dbsprite  -8,   0, $02, 0
	dbsprite  -8,   8, $03, 0
	dbsprite   0,   0, $00, 0
	dbsprite   0,   8, $01, 0
	dbsprite  -8, -16, $02, 0
	dbsprite  -8,  -8, $03, 0
	dbsprite   0, -16, $00, 0
	dbsprite   0,  -8, $01, 0

.frame_7
	db 7 ; size
	dbsprite -40,  -4, $04, 0
	dbsprite  -4,  32, $04, 0
	dbsprite -32,  24, $04, 0
	dbsprite  24,  24, $04, 0
	dbsprite -32, -32, $04, 0
	dbsprite  24, -32, $04, 0
	dbsprite  -4, -40, $04, 0

OAMData37::
	dw .frame_0
	dw .frame_1
	dw .frame_2
	dw .frame_3
	dw .frame_4
	dw .frame_5

.frame_0
	db 4 ; size
	dbsprite  -8,  -8, $00, 0
	dbsprite   0,  -8, $00, 0 | OAM_YFLIP
	dbsprite  -8,   0, $00, 0 | OAM_XFLIP
	dbsprite   0,   0, $00, 0 | OAM_XFLIP | OAM_YFLIP

.frame_1
	db 4 ; size
	dbsprite  -8,  -8, $01, 0
	dbsprite   0,  -8, $01, 0 | OAM_YFLIP
	dbsprite  -8,   0, $01, 0 | OAM_XFLIP
	dbsprite   0,   0, $01, 0 | OAM_XFLIP | OAM_YFLIP

.frame_2
	db 4 ; size
	dbsprite  -8,  -8, $02, 0
	dbsprite  -8,   0, $02, 0 | OAM_XFLIP
	dbsprite   0,  -8, $02, 0 | OAM_YFLIP
	dbsprite   0,   0, $02, 0 | OAM_XFLIP | OAM_YFLIP

.frame_3
	db 4 ; size
	dbsprite  -8,  -8, $00, 1
	dbsprite   0,  -8, $00, 1 | OAM_YFLIP
	dbsprite  -8,   0, $00, 1 | OAM_XFLIP
	dbsprite   0,   0, $00, 1 | OAM_XFLIP | OAM_YFLIP

.frame_4
	db 4 ; size
	dbsprite  -8,  -8, $01, 1
	dbsprite   0,  -8, $01, 1 | OAM_YFLIP
	dbsprite  -8,   0, $01, 1 | OAM_XFLIP
	dbsprite   0,   0, $01, 1 | OAM_XFLIP | OAM_YFLIP

.frame_5
	db 4 ; size
	dbsprite  -8,  -8, $02, 1
	dbsprite  -8,   0, $02, 1 | OAM_XFLIP
	dbsprite   0,  -8, $02, 1 | OAM_YFLIP
	dbsprite   0,   0, $02, 1 | OAM_XFLIP | OAM_YFLIP

OAMData7F::
	dw .frame_0

.frame_0
	db 4 ; size
	dbsprite   8,   8, $02, 4
	dbsprite   8,   0, $01, 4
	dbsprite   0,   8, $00, 4 | OAM_XFLIP
	dbsprite   0,   0, $00, 4

OAMData8C::
	dw .frame_0
	dw .frame_1

.frame_0
	db 1 ; size
	dbsprite  10,   6, $01, 7

.frame_1
	db 1 ; size
	dbsprite  10,   3, $00, 7
