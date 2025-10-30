OAMData4B::
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
	dw .frame_39
	dw .frame_40

.frame_0
	db 8 ; size
	dbsprite -24,  24, $02, 0
	dbsprite -24,  16, $00, 0
	dbsprite -24,   8, $02, 0
	dbsprite -24,   0, $00, 0
	dbsprite -24,  -8, $02, 0
	dbsprite -24, -16, $00, 0
	dbsprite -24, -24, $02, 0
	dbsprite -24, -32, $00, 0

.frame_1
	db 8 ; size
	dbsprite -24, -32, $02, 0 | OAM_XFLIP
	dbsprite -24, -24, $00, 0 | OAM_XFLIP
	dbsprite -24, -16, $02, 0 | OAM_XFLIP
	dbsprite -24,  -8, $00, 0 | OAM_XFLIP
	dbsprite -24,   0, $02, 0 | OAM_XFLIP
	dbsprite -24,   8, $00, 0 | OAM_XFLIP
	dbsprite -24,  16, $02, 0 | OAM_XFLIP
	dbsprite -24,  24, $00, 0 | OAM_XFLIP

.frame_2
	db 8 ; size
	dbsprite -24,  24, $06, 0
	dbsprite -24,  16, $04, 0
	dbsprite -24,   8, $06, 0
	dbsprite -24,   0, $04, 0
	dbsprite -24,  -8, $06, 0
	dbsprite -24, -16, $04, 0
	dbsprite -24, -24, $06, 0
	dbsprite -24, -32, $04, 0

.frame_3
	db 8 ; size
	dbsprite -24, -32, $06, 0 | OAM_XFLIP
	dbsprite -24, -24, $04, 0 | OAM_XFLIP
	dbsprite -24, -16, $06, 0 | OAM_XFLIP
	dbsprite -24,  -8, $04, 0 | OAM_XFLIP
	dbsprite -24,   0, $06, 0 | OAM_XFLIP
	dbsprite -24,   8, $04, 0 | OAM_XFLIP
	dbsprite -24,  16, $06, 0 | OAM_XFLIP
	dbsprite -24,  24, $04, 0 | OAM_XFLIP

.frame_4
	db 8 ; size
	dbsprite -24,  24, $0a, 0
	dbsprite -24,  16, $08, 0
	dbsprite -24,   8, $0a, 0
	dbsprite -24,   0, $08, 0
	dbsprite -24,  -8, $0a, 0
	dbsprite -24, -16, $08, 0
	dbsprite -24, -24, $0a, 0
	dbsprite -24, -32, $08, 0

.frame_5
	db 8 ; size
	dbsprite -24, -32, $0a, 0 | OAM_XFLIP
	dbsprite -24, -24, $08, 0 | OAM_XFLIP
	dbsprite -24, -16, $0a, 0 | OAM_XFLIP
	dbsprite -24,  -8, $08, 0 | OAM_XFLIP
	dbsprite -24,   0, $0a, 0 | OAM_XFLIP
	dbsprite -24,   8, $08, 0 | OAM_XFLIP
	dbsprite -24,  16, $0a, 0 | OAM_XFLIP
	dbsprite -24,  24, $08, 0 | OAM_XFLIP

.frame_6
	db 8 ; size
	dbsprite -24,  24, $0e, 0
	dbsprite -24,  16, $0c, 0
	dbsprite -24,   8, $0e, 0
	dbsprite -24,   0, $0c, 0
	dbsprite -24,  -8, $0e, 0
	dbsprite -24, -16, $0c, 0
	dbsprite -24, -24, $0e, 0
	dbsprite -24, -32, $0c, 0

.frame_7
	db 8 ; size
	dbsprite -24, -32, $0e, 0 | OAM_XFLIP
	dbsprite -24, -24, $0c, 0 | OAM_XFLIP
	dbsprite -24, -16, $0e, 0 | OAM_XFLIP
	dbsprite -24,  -8, $0c, 0 | OAM_XFLIP
	dbsprite -24,   0, $0e, 0 | OAM_XFLIP
	dbsprite -24,   8, $0c, 0 | OAM_XFLIP
	dbsprite -24,  16, $0e, 0 | OAM_XFLIP
	dbsprite -24,  24, $0c, 0 | OAM_XFLIP

.frame_8
	db 16 ; size
	dbsprite  -8,  24, $02, 0
	dbsprite  -8,  16, $00, 0
	dbsprite  -8,   8, $02, 0
	dbsprite  -8,   0, $00, 0
	dbsprite  -8,  -8, $02, 0
	dbsprite  -8, -16, $00, 0
	dbsprite  -8, -24, $02, 0
	dbsprite  -8, -32, $00, 0
	dbsprite -24,  24, $12, 0
	dbsprite -24,  16, $10, 0
	dbsprite -24,   8, $12, 0
	dbsprite -24,   0, $10, 0
	dbsprite -24,  -8, $12, 0
	dbsprite -24, -16, $10, 0
	dbsprite -24, -24, $12, 0
	dbsprite -24, -32, $10, 0

.frame_9
	db 16 ; size
	dbsprite  -8, -32, $02, 0 | OAM_XFLIP
	dbsprite  -8, -24, $00, 0 | OAM_XFLIP
	dbsprite  -8, -16, $02, 0 | OAM_XFLIP
	dbsprite  -8,  -8, $00, 0 | OAM_XFLIP
	dbsprite  -8,   0, $02, 0 | OAM_XFLIP
	dbsprite  -8,   8, $00, 0 | OAM_XFLIP
	dbsprite  -8,  16, $02, 0 | OAM_XFLIP
	dbsprite  -8,  24, $00, 0 | OAM_XFLIP
	dbsprite -24, -32, $12, 0 | OAM_XFLIP
	dbsprite -24, -24, $10, 0 | OAM_XFLIP
	dbsprite -24, -16, $12, 0 | OAM_XFLIP
	dbsprite -24,  -8, $10, 0 | OAM_XFLIP
	dbsprite -24,   0, $12, 0 | OAM_XFLIP
	dbsprite -24,   8, $10, 0 | OAM_XFLIP
	dbsprite -24,  16, $12, 0 | OAM_XFLIP
	dbsprite -24,  24, $10, 0 | OAM_XFLIP

.frame_10
	db 16 ; size
	dbsprite  -8,  24, $06, 0
	dbsprite  -8,  16, $04, 0
	dbsprite  -8,   8, $06, 0
	dbsprite  -8,   0, $04, 0
	dbsprite  -8,  -8, $06, 0
	dbsprite  -8, -16, $04, 0
	dbsprite  -8, -24, $06, 0
	dbsprite  -8, -32, $04, 0
	dbsprite -24,  24, $16, 0
	dbsprite -24,  16, $14, 0
	dbsprite -24,   8, $16, 0
	dbsprite -24,   0, $14, 0
	dbsprite -24,  -8, $16, 0
	dbsprite -24, -16, $14, 0
	dbsprite -24, -24, $16, 0
	dbsprite -24, -32, $14, 0

.frame_11
	db 16 ; size
	dbsprite  -8, -32, $06, 0 | OAM_XFLIP
	dbsprite  -8, -24, $04, 0 | OAM_XFLIP
	dbsprite  -8, -16, $06, 0 | OAM_XFLIP
	dbsprite  -8,  -8, $04, 0 | OAM_XFLIP
	dbsprite  -8,   0, $06, 0 | OAM_XFLIP
	dbsprite  -8,   8, $04, 0 | OAM_XFLIP
	dbsprite  -8,  16, $06, 0 | OAM_XFLIP
	dbsprite  -8,  24, $04, 0 | OAM_XFLIP
	dbsprite -24, -32, $16, 0 | OAM_XFLIP
	dbsprite -24, -24, $14, 0 | OAM_XFLIP
	dbsprite -24, -16, $16, 0 | OAM_XFLIP
	dbsprite -24,  -8, $14, 0 | OAM_XFLIP
	dbsprite -24,   0, $16, 0 | OAM_XFLIP
	dbsprite -24,   8, $14, 0 | OAM_XFLIP
	dbsprite -24,  16, $16, 0 | OAM_XFLIP
	dbsprite -24,  24, $14, 0 | OAM_XFLIP

.frame_12
	db 16 ; size
	dbsprite  -8,  24, $0a, 0
	dbsprite  -8,  16, $08, 0
	dbsprite  -8,   8, $0a, 0
	dbsprite  -8,   0, $08, 0
	dbsprite  -8,  -8, $0a, 0
	dbsprite  -8, -16, $08, 0
	dbsprite  -8, -24, $0a, 0
	dbsprite  -8, -32, $08, 0
	dbsprite -24,  24, $1a, 0
	dbsprite -24,  16, $18, 0
	dbsprite -24,   8, $1a, 0
	dbsprite -24,   0, $18, 0
	dbsprite -24,  -8, $1a, 0
	dbsprite -24, -16, $18, 0
	dbsprite -24, -24, $1a, 0
	dbsprite -24, -32, $18, 0

.frame_13
	db 16 ; size
	dbsprite  -8, -32, $0a, 0 | OAM_XFLIP
	dbsprite  -8, -24, $08, 0 | OAM_XFLIP
	dbsprite  -8, -16, $0a, 0 | OAM_XFLIP
	dbsprite  -8,  -8, $08, 0 | OAM_XFLIP
	dbsprite  -8,   0, $0a, 0 | OAM_XFLIP
	dbsprite  -8,   8, $08, 0 | OAM_XFLIP
	dbsprite  -8,  16, $0a, 0 | OAM_XFLIP
	dbsprite  -8,  24, $08, 0 | OAM_XFLIP
	dbsprite -24, -32, $1a, 0 | OAM_XFLIP
	dbsprite -24, -24, $18, 0 | OAM_XFLIP
	dbsprite -24, -16, $1a, 0 | OAM_XFLIP
	dbsprite -24,  -8, $18, 0 | OAM_XFLIP
	dbsprite -24,   0, $1a, 0 | OAM_XFLIP
	dbsprite -24,   8, $18, 0 | OAM_XFLIP
	dbsprite -24,  16, $1a, 0 | OAM_XFLIP
	dbsprite -24,  24, $18, 0 | OAM_XFLIP

.frame_14
	db 16 ; size
	dbsprite  -8,  24, $0e, 0
	dbsprite  -8,  16, $0c, 0
	dbsprite  -8,   8, $0e, 0
	dbsprite  -8,   0, $0c, 0
	dbsprite  -8,  -8, $0e, 0
	dbsprite  -8, -16, $0c, 0
	dbsprite  -8, -24, $0e, 0
	dbsprite  -8, -32, $0c, 0
	dbsprite -24,  24, $1e, 0
	dbsprite -24,  16, $1c, 0
	dbsprite -24,   8, $1e, 0
	dbsprite -24,   0, $1c, 0
	dbsprite -24,  -8, $1e, 0
	dbsprite -24, -16, $1c, 0
	dbsprite -24, -24, $1e, 0
	dbsprite -24, -32, $1c, 0

.frame_15
	db 16 ; size
	dbsprite  -8, -32, $0e, 0 | OAM_XFLIP
	dbsprite  -8, -24, $0c, 0 | OAM_XFLIP
	dbsprite  -8, -16, $0e, 0 | OAM_XFLIP
	dbsprite  -8,  -8, $0c, 0 | OAM_XFLIP
	dbsprite  -8,   0, $0e, 0 | OAM_XFLIP
	dbsprite  -8,   8, $0c, 0 | OAM_XFLIP
	dbsprite  -8,  16, $0e, 0 | OAM_XFLIP
	dbsprite  -8,  24, $0c, 0 | OAM_XFLIP
	dbsprite -24, -32, $1e, 0 | OAM_XFLIP
	dbsprite -24, -24, $1c, 0 | OAM_XFLIP
	dbsprite -24, -16, $1e, 0 | OAM_XFLIP
	dbsprite -24,  -8, $1c, 0 | OAM_XFLIP
	dbsprite -24,   0, $1e, 0 | OAM_XFLIP
	dbsprite -24,   8, $1c, 0 | OAM_XFLIP
	dbsprite -24,  16, $1e, 0 | OAM_XFLIP
	dbsprite -24,  24, $1c, 0 | OAM_XFLIP

.frame_16
	db 24 ; size
	dbsprite   8,  24, $02, 0
	dbsprite   8,  16, $00, 0
	dbsprite   8,   8, $02, 0
	dbsprite   8,   0, $00, 0
	dbsprite   8,  -8, $02, 0
	dbsprite   8, -16, $00, 0
	dbsprite   8, -24, $02, 0
	dbsprite   8, -32, $00, 0
	dbsprite  -8,  24, $12, 0
	dbsprite  -8,  16, $10, 0
	dbsprite  -8,   8, $12, 0
	dbsprite  -8,   0, $10, 0
	dbsprite  -8,  -8, $12, 0
	dbsprite  -8, -16, $10, 0
	dbsprite  -8, -24, $12, 0
	dbsprite  -8, -32, $10, 0
	dbsprite -24,  24, $22, 0
	dbsprite -24,  16, $20, 0
	dbsprite -24,   8, $22, 0
	dbsprite -24,   0, $20, 0
	dbsprite -24,  -8, $22, 0
	dbsprite -24, -16, $20, 0
	dbsprite -24, -24, $22, 0
	dbsprite -24, -32, $20, 0

.frame_17
	db 24 ; size
	dbsprite   8, -32, $02, 0 | OAM_XFLIP
	dbsprite   8, -24, $00, 0 | OAM_XFLIP
	dbsprite   8, -16, $02, 0 | OAM_XFLIP
	dbsprite   8,  -8, $00, 0 | OAM_XFLIP
	dbsprite   8,   0, $02, 0 | OAM_XFLIP
	dbsprite   8,   8, $00, 0 | OAM_XFLIP
	dbsprite   8,  16, $02, 0 | OAM_XFLIP
	dbsprite   8,  24, $00, 0 | OAM_XFLIP
	dbsprite  -8, -32, $12, 0 | OAM_XFLIP
	dbsprite  -8, -24, $10, 0 | OAM_XFLIP
	dbsprite  -8, -16, $12, 0 | OAM_XFLIP
	dbsprite  -8,  -8, $10, 0 | OAM_XFLIP
	dbsprite  -8,   0, $12, 0 | OAM_XFLIP
	dbsprite  -8,   8, $10, 0 | OAM_XFLIP
	dbsprite  -8,  16, $12, 0 | OAM_XFLIP
	dbsprite  -8,  24, $10, 0 | OAM_XFLIP
	dbsprite -24, -32, $22, 0 | OAM_XFLIP
	dbsprite -24, -24, $20, 0 | OAM_XFLIP
	dbsprite -24, -16, $22, 0 | OAM_XFLIP
	dbsprite -24,  -8, $20, 0 | OAM_XFLIP
	dbsprite -24,   0, $22, 0 | OAM_XFLIP
	dbsprite -24,   8, $20, 0 | OAM_XFLIP
	dbsprite -24,  16, $22, 0 | OAM_XFLIP
	dbsprite -24,  24, $20, 0 | OAM_XFLIP

.frame_18
	db 24 ; size
	dbsprite   8,  24, $06, 0
	dbsprite   8,  16, $04, 0
	dbsprite   8,   8, $06, 0
	dbsprite   8,   0, $04, 0
	dbsprite   8,  -8, $06, 0
	dbsprite   8, -16, $04, 0
	dbsprite   8, -24, $06, 0
	dbsprite   8, -32, $04, 0
	dbsprite  -8,  24, $16, 0
	dbsprite  -8,  16, $14, 0
	dbsprite  -8,   8, $16, 0
	dbsprite  -8,   0, $14, 0
	dbsprite  -8,  -8, $16, 0
	dbsprite  -8, -16, $14, 0
	dbsprite  -8, -24, $16, 0
	dbsprite  -8, -32, $14, 0
	dbsprite -24,  24, $26, 0
	dbsprite -24,  16, $24, 0
	dbsprite -24,   8, $26, 0
	dbsprite -24,   0, $24, 0
	dbsprite -24,  -8, $26, 0
	dbsprite -24, -16, $24, 0
	dbsprite -24, -24, $26, 0
	dbsprite -24, -32, $24, 0

.frame_19
	db 24 ; size
	dbsprite   8, -32, $06, 0 | OAM_XFLIP
	dbsprite   8, -24, $04, 0 | OAM_XFLIP
	dbsprite   8, -16, $06, 0 | OAM_XFLIP
	dbsprite   8,  -8, $04, 0 | OAM_XFLIP
	dbsprite   8,   0, $06, 0 | OAM_XFLIP
	dbsprite   8,   8, $04, 0 | OAM_XFLIP
	dbsprite   8,  16, $06, 0 | OAM_XFLIP
	dbsprite   8,  24, $04, 0 | OAM_XFLIP
	dbsprite  -8, -32, $16, 0 | OAM_XFLIP
	dbsprite  -8, -24, $14, 0 | OAM_XFLIP
	dbsprite  -8, -16, $16, 0 | OAM_XFLIP
	dbsprite  -8,  -8, $14, 0 | OAM_XFLIP
	dbsprite  -8,   0, $16, 0 | OAM_XFLIP
	dbsprite  -8,   8, $14, 0 | OAM_XFLIP
	dbsprite  -8,  16, $16, 0 | OAM_XFLIP
	dbsprite  -8,  24, $14, 0 | OAM_XFLIP
	dbsprite -24, -32, $26, 0 | OAM_XFLIP
	dbsprite -24, -24, $24, 0 | OAM_XFLIP
	dbsprite -24, -16, $26, 0 | OAM_XFLIP
	dbsprite -24,  -8, $24, 0 | OAM_XFLIP
	dbsprite -24,   0, $26, 0 | OAM_XFLIP
	dbsprite -24,   8, $24, 0 | OAM_XFLIP
	dbsprite -24,  16, $26, 0 | OAM_XFLIP
	dbsprite -24,  24, $24, 0 | OAM_XFLIP

.frame_20
	db 24 ; size
	dbsprite   8,  24, $0a, 0
	dbsprite   8,  16, $08, 0
	dbsprite   8,   8, $0a, 0
	dbsprite   8,   0, $08, 0
	dbsprite   8,  -8, $0a, 0
	dbsprite   8, -16, $08, 0
	dbsprite   8, -24, $0a, 0
	dbsprite   8, -32, $08, 0
	dbsprite  -8,  24, $1a, 0
	dbsprite  -8,  16, $18, 0
	dbsprite  -8,   8, $1a, 0
	dbsprite  -8,   0, $18, 0
	dbsprite  -8,  -8, $1a, 0
	dbsprite  -8, -16, $18, 0
	dbsprite  -8, -24, $1a, 0
	dbsprite  -8, -32, $18, 0
	dbsprite -24,  24, $2a, 0
	dbsprite -24,  16, $28, 0
	dbsprite -24,   8, $2a, 0
	dbsprite -24,   0, $28, 0
	dbsprite -24,  -8, $2a, 0
	dbsprite -24, -16, $28, 0
	dbsprite -24, -24, $2a, 0
	dbsprite -24, -32, $28, 0

.frame_21
	db 24 ; size
	dbsprite   8, -32, $0a, 0 | OAM_XFLIP
	dbsprite   8, -24, $08, 0 | OAM_XFLIP
	dbsprite   8, -16, $0a, 0 | OAM_XFLIP
	dbsprite   8,  -8, $08, 0 | OAM_XFLIP
	dbsprite   8,   0, $0a, 0 | OAM_XFLIP
	dbsprite   8,   8, $08, 0 | OAM_XFLIP
	dbsprite   8,  16, $0a, 0 | OAM_XFLIP
	dbsprite   8,  24, $08, 0 | OAM_XFLIP
	dbsprite  -8, -32, $1a, 0 | OAM_XFLIP
	dbsprite  -8, -24, $18, 0 | OAM_XFLIP
	dbsprite  -8, -16, $1a, 0 | OAM_XFLIP
	dbsprite  -8,  -8, $18, 0 | OAM_XFLIP
	dbsprite  -8,   0, $1a, 0 | OAM_XFLIP
	dbsprite  -8,   8, $18, 0 | OAM_XFLIP
	dbsprite  -8,  16, $1a, 0 | OAM_XFLIP
	dbsprite  -8,  24, $18, 0 | OAM_XFLIP
	dbsprite -24, -32, $2a, 0 | OAM_XFLIP
	dbsprite -24, -24, $28, 0 | OAM_XFLIP
	dbsprite -24, -16, $2a, 0 | OAM_XFLIP
	dbsprite -24,  -8, $28, 0 | OAM_XFLIP
	dbsprite -24,   0, $2a, 0 | OAM_XFLIP
	dbsprite -24,   8, $28, 0 | OAM_XFLIP
	dbsprite -24,  16, $2a, 0 | OAM_XFLIP
	dbsprite -24,  24, $28, 0 | OAM_XFLIP

.frame_22
	db 24 ; size
	dbsprite   8,  24, $0e, 0
	dbsprite   8,  16, $0c, 0
	dbsprite   8,   8, $0e, 0
	dbsprite   8,   0, $0c, 0
	dbsprite   8,  -8, $0e, 0
	dbsprite   8, -16, $0c, 0
	dbsprite   8, -24, $0e, 0
	dbsprite   8, -32, $0c, 0
	dbsprite  -8,  24, $1e, 0
	dbsprite  -8,  16, $1c, 0
	dbsprite  -8,   8, $1e, 0
	dbsprite  -8,   0, $1c, 0
	dbsprite  -8,  -8, $1e, 0
	dbsprite  -8, -16, $1c, 0
	dbsprite  -8, -24, $1e, 0
	dbsprite  -8, -32, $1c, 0
	dbsprite -24,  24, $2e, 0
	dbsprite -24,  16, $2c, 0
	dbsprite -24,   8, $2e, 0
	dbsprite -24,   0, $2c, 0
	dbsprite -24,  -8, $2e, 0
	dbsprite -24, -16, $2c, 0
	dbsprite -24, -24, $2e, 0
	dbsprite -24, -32, $2c, 0

.frame_23
	db 24 ; size
	dbsprite   8, -32, $0e, 0 | OAM_XFLIP
	dbsprite   8, -24, $0c, 0 | OAM_XFLIP
	dbsprite   8, -16, $0e, 0 | OAM_XFLIP
	dbsprite   8,  -8, $0c, 0 | OAM_XFLIP
	dbsprite   8,   0, $0e, 0 | OAM_XFLIP
	dbsprite   8,   8, $0c, 0 | OAM_XFLIP
	dbsprite   8,  16, $0e, 0 | OAM_XFLIP
	dbsprite   8,  24, $0c, 0 | OAM_XFLIP
	dbsprite  -8, -32, $1e, 0 | OAM_XFLIP
	dbsprite  -8, -24, $1c, 0 | OAM_XFLIP
	dbsprite  -8, -16, $1e, 0 | OAM_XFLIP
	dbsprite  -8,  -8, $1c, 0 | OAM_XFLIP
	dbsprite  -8,   0, $1e, 0 | OAM_XFLIP
	dbsprite  -8,   8, $1c, 0 | OAM_XFLIP
	dbsprite  -8,  16, $1e, 0 | OAM_XFLIP
	dbsprite  -8,  24, $1c, 0 | OAM_XFLIP
	dbsprite -24, -32, $2e, 0 | OAM_XFLIP
	dbsprite -24, -24, $2c, 0 | OAM_XFLIP
	dbsprite -24, -16, $2e, 0 | OAM_XFLIP
	dbsprite -24,  -8, $2c, 0 | OAM_XFLIP
	dbsprite -24,   0, $2e, 0 | OAM_XFLIP
	dbsprite -24,   8, $2c, 0 | OAM_XFLIP
	dbsprite -24,  16, $2e, 0 | OAM_XFLIP
	dbsprite -24,  24, $2c, 0 | OAM_XFLIP

.frame_24
	db 24 ; size
	dbsprite   8,  24, $12, 0
	dbsprite   8,  16, $10, 0
	dbsprite   8,   8, $12, 0
	dbsprite   8,   0, $10, 0
	dbsprite   8,  -8, $12, 0
	dbsprite   8, -16, $10, 0
	dbsprite   8, -24, $12, 0
	dbsprite   8, -32, $10, 0
	dbsprite  -8,  24, $22, 0
	dbsprite  -8,  16, $20, 0
	dbsprite  -8,   8, $22, 0
	dbsprite  -8,   0, $20, 0
	dbsprite  -8,  -8, $22, 0
	dbsprite  -8, -16, $20, 0
	dbsprite  -8, -24, $22, 0
	dbsprite  -8, -32, $20, 0
	dbsprite -24,  24, $30, 0
	dbsprite -24,  16, $30, 0
	dbsprite -24,   8, $30, 0
	dbsprite -24,   0, $30, 0
	dbsprite -24,  -8, $30, 0
	dbsprite -24, -16, $30, 0
	dbsprite -24, -24, $30, 0
	dbsprite -24, -32, $30, 0

.frame_25
	db 24 ; size
	dbsprite   8, -32, $12, 0 | OAM_XFLIP
	dbsprite   8, -24, $10, 0 | OAM_XFLIP
	dbsprite   8, -16, $12, 0 | OAM_XFLIP
	dbsprite   8,  -8, $10, 0 | OAM_XFLIP
	dbsprite   8,   0, $12, 0 | OAM_XFLIP
	dbsprite   8,   8, $10, 0 | OAM_XFLIP
	dbsprite   8,  16, $12, 0 | OAM_XFLIP
	dbsprite   8,  24, $10, 0 | OAM_XFLIP
	dbsprite  -8, -32, $22, 0 | OAM_XFLIP
	dbsprite  -8, -24, $20, 0 | OAM_XFLIP
	dbsprite  -8, -16, $22, 0 | OAM_XFLIP
	dbsprite  -8,  -8, $20, 0 | OAM_XFLIP
	dbsprite  -8,   0, $22, 0 | OAM_XFLIP
	dbsprite  -8,   8, $20, 0 | OAM_XFLIP
	dbsprite  -8,  16, $22, 0 | OAM_XFLIP
	dbsprite  -8,  24, $20, 0 | OAM_XFLIP
	dbsprite -24, -32, $30, 0 | OAM_XFLIP
	dbsprite -24, -24, $30, 0 | OAM_XFLIP
	dbsprite -24, -16, $30, 0 | OAM_XFLIP
	dbsprite -24,  -8, $30, 0 | OAM_XFLIP
	dbsprite -24,   0, $30, 0 | OAM_XFLIP
	dbsprite -24,   8, $30, 0 | OAM_XFLIP
	dbsprite -24,  16, $30, 0 | OAM_XFLIP
	dbsprite -24,  24, $30, 0 | OAM_XFLIP

.frame_26
	db 24 ; size
	dbsprite   8,  24, $16, 0
	dbsprite   8,  16, $14, 0
	dbsprite   8,   8, $16, 0
	dbsprite   8,   0, $14, 0
	dbsprite   8,  -8, $16, 0
	dbsprite   8, -16, $14, 0
	dbsprite   8, -24, $16, 0
	dbsprite   8, -32, $14, 0
	dbsprite  -8,  24, $26, 0
	dbsprite  -8,  16, $24, 0
	dbsprite  -8,   8, $26, 0
	dbsprite  -8,   0, $24, 0
	dbsprite  -8,  -8, $26, 0
	dbsprite  -8, -16, $24, 0
	dbsprite  -8, -24, $26, 0
	dbsprite  -8, -32, $24, 0
	dbsprite -24,  24, $30, 0
	dbsprite -24,  16, $30, 0
	dbsprite -24,   8, $30, 0
	dbsprite -24,   0, $30, 0
	dbsprite -24,  -8, $30, 0
	dbsprite -24, -16, $30, 0
	dbsprite -24, -24, $30, 0
	dbsprite -24, -32, $30, 0

.frame_27
	db 24 ; size
	dbsprite   8, -32, $16, 0 | OAM_XFLIP
	dbsprite   8, -24, $14, 0 | OAM_XFLIP
	dbsprite   8, -16, $16, 0 | OAM_XFLIP
	dbsprite   8,  -8, $14, 0 | OAM_XFLIP
	dbsprite   8,   0, $16, 0 | OAM_XFLIP
	dbsprite   8,   8, $14, 0 | OAM_XFLIP
	dbsprite   8,  16, $16, 0 | OAM_XFLIP
	dbsprite   8,  24, $14, 0 | OAM_XFLIP
	dbsprite  -8, -32, $26, 0 | OAM_XFLIP
	dbsprite  -8, -24, $24, 0 | OAM_XFLIP
	dbsprite  -8, -16, $26, 0 | OAM_XFLIP
	dbsprite  -8,  -8, $24, 0 | OAM_XFLIP
	dbsprite  -8,   0, $26, 0 | OAM_XFLIP
	dbsprite  -8,   8, $24, 0 | OAM_XFLIP
	dbsprite  -8,  16, $26, 0 | OAM_XFLIP
	dbsprite  -8,  24, $24, 0 | OAM_XFLIP
	dbsprite -24, -32, $30, 0 | OAM_XFLIP
	dbsprite -24, -24, $30, 0 | OAM_XFLIP
	dbsprite -24, -16, $30, 0 | OAM_XFLIP
	dbsprite -24,  -8, $30, 0 | OAM_XFLIP
	dbsprite -24,   0, $30, 0 | OAM_XFLIP
	dbsprite -24,   8, $30, 0 | OAM_XFLIP
	dbsprite -24,  16, $30, 0 | OAM_XFLIP
	dbsprite -24,  24, $30, 0 | OAM_XFLIP

.frame_28
	db 24 ; size
	dbsprite   8,  24, $1a, 0
	dbsprite   8,  16, $18, 0
	dbsprite   8,   8, $1a, 0
	dbsprite   8,   0, $18, 0
	dbsprite   8,  -8, $1a, 0
	dbsprite   8, -16, $18, 0
	dbsprite   8, -24, $1a, 0
	dbsprite   8, -32, $18, 0
	dbsprite  -8,  24, $2a, 0
	dbsprite  -8,  16, $28, 0
	dbsprite  -8,   8, $2a, 0
	dbsprite  -8,   0, $28, 0
	dbsprite  -8,  -8, $2a, 0
	dbsprite  -8, -16, $28, 0
	dbsprite  -8, -24, $2a, 0
	dbsprite  -8, -32, $28, 0
	dbsprite -24,  24, $30, 0
	dbsprite -24,  16, $30, 0
	dbsprite -24,   8, $30, 0
	dbsprite -24,   0, $30, 0
	dbsprite -24,  -8, $30, 0
	dbsprite -24, -16, $30, 0
	dbsprite -24, -24, $30, 0
	dbsprite -24, -32, $30, 0

.frame_29
	db 24 ; size
	dbsprite   8, -32, $1a, 0 | OAM_XFLIP
	dbsprite   8, -24, $18, 0 | OAM_XFLIP
	dbsprite   8, -16, $1a, 0 | OAM_XFLIP
	dbsprite   8,  -8, $18, 0 | OAM_XFLIP
	dbsprite   8,   0, $1a, 0 | OAM_XFLIP
	dbsprite   8,   8, $18, 0 | OAM_XFLIP
	dbsprite   8,  16, $1a, 0 | OAM_XFLIP
	dbsprite   8,  24, $18, 0 | OAM_XFLIP
	dbsprite  -8, -32, $2a, 0 | OAM_XFLIP
	dbsprite  -8, -24, $28, 0 | OAM_XFLIP
	dbsprite  -8, -16, $2a, 0 | OAM_XFLIP
	dbsprite  -8,  -8, $28, 0 | OAM_XFLIP
	dbsprite  -8,   0, $2a, 0 | OAM_XFLIP
	dbsprite  -8,   8, $28, 0 | OAM_XFLIP
	dbsprite  -8,  16, $2a, 0 | OAM_XFLIP
	dbsprite  -8,  24, $28, 0 | OAM_XFLIP
	dbsprite -24, -32, $30, 0 | OAM_XFLIP
	dbsprite -24, -24, $30, 0 | OAM_XFLIP
	dbsprite -24, -16, $30, 0 | OAM_XFLIP
	dbsprite -24,  -8, $30, 0 | OAM_XFLIP
	dbsprite -24,   0, $30, 0 | OAM_XFLIP
	dbsprite -24,   8, $30, 0 | OAM_XFLIP
	dbsprite -24,  16, $30, 0 | OAM_XFLIP
	dbsprite -24,  24, $30, 0 | OAM_XFLIP

.frame_30
	db 24 ; size
	dbsprite   8,  24, $1e, 0
	dbsprite   8,  16, $1c, 0
	dbsprite   8,   8, $1e, 0
	dbsprite   8,   0, $1c, 0
	dbsprite   8,  -8, $1e, 0
	dbsprite   8, -16, $1c, 0
	dbsprite   8, -24, $1e, 0
	dbsprite   8, -32, $1c, 0
	dbsprite  -8,  24, $2e, 0
	dbsprite  -8,  16, $2c, 0
	dbsprite  -8,   8, $2e, 0
	dbsprite  -8,   0, $2c, 0
	dbsprite  -8,  -8, $2e, 0
	dbsprite  -8, -16, $2c, 0
	dbsprite  -8, -24, $2e, 0
	dbsprite  -8, -32, $2c, 0
	dbsprite -24,  24, $30, 0
	dbsprite -24,  16, $30, 0
	dbsprite -24,   8, $30, 0
	dbsprite -24,   0, $30, 0
	dbsprite -24,  -8, $30, 0
	dbsprite -24, -16, $30, 0
	dbsprite -24, -24, $30, 0
	dbsprite -24, -32, $30, 0

.frame_31
	db 24 ; size
	dbsprite   8, -32, $1e, 0 | OAM_XFLIP
	dbsprite   8, -24, $1c, 0 | OAM_XFLIP
	dbsprite   8, -16, $1e, 0 | OAM_XFLIP
	dbsprite   8,  -8, $1c, 0 | OAM_XFLIP
	dbsprite   8,   0, $1e, 0 | OAM_XFLIP
	dbsprite   8,   8, $1c, 0 | OAM_XFLIP
	dbsprite   8,  16, $1e, 0 | OAM_XFLIP
	dbsprite   8,  24, $1c, 0 | OAM_XFLIP
	dbsprite  -8, -32, $2e, 0 | OAM_XFLIP
	dbsprite  -8, -24, $2c, 0 | OAM_XFLIP
	dbsprite  -8, -16, $2e, 0 | OAM_XFLIP
	dbsprite  -8,  -8, $2c, 0 | OAM_XFLIP
	dbsprite  -8,   0, $2e, 0 | OAM_XFLIP
	dbsprite  -8,   8, $2c, 0 | OAM_XFLIP
	dbsprite  -8,  16, $2e, 0 | OAM_XFLIP
	dbsprite  -8,  24, $2c, 0 | OAM_XFLIP
	dbsprite -24, -32, $30, 0 | OAM_XFLIP
	dbsprite -24, -24, $30, 0 | OAM_XFLIP
	dbsprite -24, -16, $30, 0 | OAM_XFLIP
	dbsprite -24,  -8, $30, 0 | OAM_XFLIP
	dbsprite -24,   0, $30, 0 | OAM_XFLIP
	dbsprite -24,   8, $30, 0 | OAM_XFLIP
	dbsprite -24,  16, $30, 0 | OAM_XFLIP
	dbsprite -24,  24, $30, 0 | OAM_XFLIP

.frame_32
	db 24 ; size
	dbsprite   8,  24, $22, 0
	dbsprite   8,  16, $20, 0
	dbsprite   8,   8, $22, 0
	dbsprite   8,   0, $20, 0
	dbsprite   8,  -8, $22, 0
	dbsprite   8, -16, $20, 0
	dbsprite   8, -24, $22, 0
	dbsprite   8, -32, $20, 0
	dbsprite  -8,  24, $30, 0
	dbsprite  -8,  16, $30, 0
	dbsprite  -8,   8, $30, 0
	dbsprite  -8,   0, $30, 0
	dbsprite  -8,  -8, $30, 0
	dbsprite  -8, -16, $30, 0
	dbsprite  -8, -24, $30, 0
	dbsprite  -8, -32, $30, 0
	dbsprite -24,  24, $30, 0
	dbsprite -24,  16, $30, 0
	dbsprite -24,   8, $30, 0
	dbsprite -24,   0, $30, 0
	dbsprite -24,  -8, $30, 0
	dbsprite -24, -16, $30, 0
	dbsprite -24, -24, $30, 0
	dbsprite -24, -32, $30, 0

.frame_33
	db 24 ; size
	dbsprite   8, -32, $22, 0 | OAM_XFLIP
	dbsprite   8, -24, $20, 0 | OAM_XFLIP
	dbsprite   8, -16, $22, 0 | OAM_XFLIP
	dbsprite   8,  -8, $20, 0 | OAM_XFLIP
	dbsprite   8,   0, $22, 0 | OAM_XFLIP
	dbsprite   8,   8, $20, 0 | OAM_XFLIP
	dbsprite   8,  16, $22, 0 | OAM_XFLIP
	dbsprite   8,  24, $20, 0 | OAM_XFLIP
	dbsprite  -8, -32, $30, 0 | OAM_XFLIP
	dbsprite  -8, -24, $30, 0 | OAM_XFLIP
	dbsprite  -8, -16, $30, 0 | OAM_XFLIP
	dbsprite  -8,  -8, $30, 0 | OAM_XFLIP
	dbsprite  -8,   0, $30, 0 | OAM_XFLIP
	dbsprite  -8,   8, $30, 0 | OAM_XFLIP
	dbsprite  -8,  16, $30, 0 | OAM_XFLIP
	dbsprite  -8,  24, $30, 0 | OAM_XFLIP
	dbsprite -24, -32, $30, 0 | OAM_XFLIP
	dbsprite -24, -24, $30, 0 | OAM_XFLIP
	dbsprite -24, -16, $30, 0 | OAM_XFLIP
	dbsprite -24,  -8, $30, 0 | OAM_XFLIP
	dbsprite -24,   0, $30, 0 | OAM_XFLIP
	dbsprite -24,   8, $30, 0 | OAM_XFLIP
	dbsprite -24,  16, $30, 0 | OAM_XFLIP
	dbsprite -24,  24, $30, 0 | OAM_XFLIP

.frame_34
	db 24 ; size
	dbsprite   8,  24, $26, 0
	dbsprite   8,  16, $24, 0
	dbsprite   8,   8, $26, 0
	dbsprite   8,   0, $24, 0
	dbsprite   8,  -8, $26, 0
	dbsprite   8, -16, $24, 0
	dbsprite   8, -24, $26, 0
	dbsprite   8, -32, $24, 0
	dbsprite  -8,  24, $30, 0
	dbsprite  -8,  16, $30, 0
	dbsprite  -8,   8, $30, 0
	dbsprite  -8,   0, $30, 0
	dbsprite  -8,  -8, $30, 0
	dbsprite  -8, -16, $30, 0
	dbsprite  -8, -24, $30, 0
	dbsprite  -8, -32, $30, 0
	dbsprite -24,  24, $30, 0
	dbsprite -24,  16, $30, 0
	dbsprite -24,   8, $30, 0
	dbsprite -24,   0, $30, 0
	dbsprite -24,  -8, $30, 0
	dbsprite -24, -16, $30, 0
	dbsprite -24, -24, $30, 0
	dbsprite -24, -32, $30, 0

.frame_35
	db 24 ; size
	dbsprite   8, -32, $26, 0 | OAM_XFLIP
	dbsprite   8, -24, $24, 0 | OAM_XFLIP
	dbsprite   8, -16, $26, 0 | OAM_XFLIP
	dbsprite   8,  -8, $24, 0 | OAM_XFLIP
	dbsprite   8,   0, $26, 0 | OAM_XFLIP
	dbsprite   8,   8, $24, 0 | OAM_XFLIP
	dbsprite   8,  16, $26, 0 | OAM_XFLIP
	dbsprite   8,  24, $24, 0 | OAM_XFLIP
	dbsprite  -8, -32, $30, 0 | OAM_XFLIP
	dbsprite  -8, -24, $30, 0 | OAM_XFLIP
	dbsprite  -8, -16, $30, 0 | OAM_XFLIP
	dbsprite  -8,  -8, $30, 0 | OAM_XFLIP
	dbsprite  -8,   0, $30, 0 | OAM_XFLIP
	dbsprite  -8,   8, $30, 0 | OAM_XFLIP
	dbsprite  -8,  16, $30, 0 | OAM_XFLIP
	dbsprite  -8,  24, $30, 0 | OAM_XFLIP
	dbsprite -24, -32, $30, 0 | OAM_XFLIP
	dbsprite -24, -24, $30, 0 | OAM_XFLIP
	dbsprite -24, -16, $30, 0 | OAM_XFLIP
	dbsprite -24,  -8, $30, 0 | OAM_XFLIP
	dbsprite -24,   0, $30, 0 | OAM_XFLIP
	dbsprite -24,   8, $30, 0 | OAM_XFLIP
	dbsprite -24,  16, $30, 0 | OAM_XFLIP
	dbsprite -24,  24, $30, 0 | OAM_XFLIP

.frame_36
	db 24 ; size
	dbsprite   8,  24, $2a, 0
	dbsprite   8,  16, $28, 0
	dbsprite   8,   8, $2a, 0
	dbsprite   8,   0, $28, 0
	dbsprite   8,  -8, $2a, 0
	dbsprite   8, -16, $28, 0
	dbsprite   8, -24, $2a, 0
	dbsprite   8, -32, $28, 0
	dbsprite  -8,  24, $30, 0
	dbsprite  -8,  16, $30, 0
	dbsprite  -8,   8, $30, 0
	dbsprite  -8,   0, $30, 0
	dbsprite  -8,  -8, $30, 0
	dbsprite  -8, -16, $30, 0
	dbsprite  -8, -24, $30, 0
	dbsprite  -8, -32, $30, 0
	dbsprite -24,  24, $30, 0
	dbsprite -24,  16, $30, 0
	dbsprite -24,   8, $30, 0
	dbsprite -24,   0, $30, 0
	dbsprite -24,  -8, $30, 0
	dbsprite -24, -16, $30, 0
	dbsprite -24, -24, $30, 0
	dbsprite -24, -32, $30, 0

.frame_37
	db 24 ; size
	dbsprite   8, -32, $2a, 0 | OAM_XFLIP
	dbsprite   8, -24, $28, 0 | OAM_XFLIP
	dbsprite   8, -16, $2a, 0 | OAM_XFLIP
	dbsprite   8,  -8, $28, 0 | OAM_XFLIP
	dbsprite   8,   0, $2a, 0 | OAM_XFLIP
	dbsprite   8,   8, $28, 0 | OAM_XFLIP
	dbsprite   8,  16, $2a, 0 | OAM_XFLIP
	dbsprite   8,  24, $28, 0 | OAM_XFLIP
	dbsprite  -8, -32, $30, 0 | OAM_XFLIP
	dbsprite  -8, -24, $30, 0 | OAM_XFLIP
	dbsprite  -8, -16, $30, 0 | OAM_XFLIP
	dbsprite  -8,  -8, $30, 0 | OAM_XFLIP
	dbsprite  -8,   0, $30, 0 | OAM_XFLIP
	dbsprite  -8,   8, $30, 0 | OAM_XFLIP
	dbsprite  -8,  16, $30, 0 | OAM_XFLIP
	dbsprite  -8,  24, $30, 0 | OAM_XFLIP
	dbsprite -24, -32, $30, 0 | OAM_XFLIP
	dbsprite -24, -24, $30, 0 | OAM_XFLIP
	dbsprite -24, -16, $30, 0 | OAM_XFLIP
	dbsprite -24,  -8, $30, 0 | OAM_XFLIP
	dbsprite -24,   0, $30, 0 | OAM_XFLIP
	dbsprite -24,   8, $30, 0 | OAM_XFLIP
	dbsprite -24,  16, $30, 0 | OAM_XFLIP
	dbsprite -24,  24, $30, 0 | OAM_XFLIP

.frame_38
	db 24 ; size
	dbsprite   8,  24, $2e, 0
	dbsprite   8,  16, $2c, 0
	dbsprite   8,   8, $2e, 0
	dbsprite   8,   0, $2c, 0
	dbsprite   8,  -8, $2e, 0
	dbsprite   8, -16, $2c, 0
	dbsprite   8, -24, $2e, 0
	dbsprite   8, -32, $2c, 0
	dbsprite  -8, -32, $30, 0 | OAM_XFLIP
	dbsprite  -8, -24, $30, 0 | OAM_XFLIP
	dbsprite  -8, -16, $30, 0 | OAM_XFLIP
	dbsprite  -8,  -8, $30, 0 | OAM_XFLIP
	dbsprite  -8,   0, $30, 0 | OAM_XFLIP
	dbsprite  -8,   8, $30, 0 | OAM_XFLIP
	dbsprite  -8,  16, $30, 0 | OAM_XFLIP
	dbsprite  -8,  24, $30, 0 | OAM_XFLIP
	dbsprite -24, -32, $30, 0 | OAM_XFLIP
	dbsprite -24, -24, $30, 0 | OAM_XFLIP
	dbsprite -24, -16, $30, 0 | OAM_XFLIP
	dbsprite -24,  -8, $30, 0 | OAM_XFLIP
	dbsprite -24,   0, $30, 0 | OAM_XFLIP
	dbsprite -24,   8, $30, 0 | OAM_XFLIP
	dbsprite -24,  16, $30, 0 | OAM_XFLIP
	dbsprite -24,  24, $30, 0 | OAM_XFLIP

.frame_39
	db 24 ; size
	dbsprite   8,  24, $2e, 0
	dbsprite   8,  16, $2c, 0
	dbsprite   8,   8, $2e, 0
	dbsprite   8,   0, $2c, 0
	dbsprite   8,  -8, $2e, 0
	dbsprite   8, -16, $2c, 0
	dbsprite   8, -24, $2e, 0
	dbsprite   8, -32, $2c, 0
	dbsprite  -8, -32, $30, 0 | OAM_XFLIP
	dbsprite  -8, -24, $30, 0 | OAM_XFLIP
	dbsprite  -8, -16, $30, 0 | OAM_XFLIP
	dbsprite  -8,  -8, $30, 0 | OAM_XFLIP
	dbsprite  -8,   0, $30, 0 | OAM_XFLIP
	dbsprite  -8,   8, $30, 0 | OAM_XFLIP
	dbsprite  -8,  16, $30, 0 | OAM_XFLIP
	dbsprite  -8,  24, $30, 0 | OAM_XFLIP
	dbsprite -24, -32, $30, 0 | OAM_XFLIP
	dbsprite -24, -24, $30, 0 | OAM_XFLIP
	dbsprite -24, -16, $30, 0 | OAM_XFLIP
	dbsprite -24,  -8, $30, 0 | OAM_XFLIP
	dbsprite -24,   0, $30, 0 | OAM_XFLIP
	dbsprite -24,   8, $30, 0 | OAM_XFLIP
	dbsprite -24,  16, $30, 0 | OAM_XFLIP
	dbsprite -24,  24, $30, 0 | OAM_XFLIP

.frame_40
	db 24 ; size
	dbsprite   8, -32, $30, 0 | OAM_XFLIP
	dbsprite   8, -24, $30, 0 | OAM_XFLIP
	dbsprite   8, -16, $30, 0 | OAM_XFLIP
	dbsprite   8,  -8, $30, 0 | OAM_XFLIP
	dbsprite   8,   0, $30, 0 | OAM_XFLIP
	dbsprite   8,   8, $30, 0 | OAM_XFLIP
	dbsprite   8,  16, $30, 0 | OAM_XFLIP
	dbsprite   8,  24, $30, 0 | OAM_XFLIP
	dbsprite  -8, -32, $30, 0 | OAM_XFLIP
	dbsprite  -8, -24, $30, 0 | OAM_XFLIP
	dbsprite  -8, -16, $30, 0 | OAM_XFLIP
	dbsprite  -8,  -8, $30, 0 | OAM_XFLIP
	dbsprite  -8,   0, $30, 0 | OAM_XFLIP
	dbsprite  -8,   8, $30, 0 | OAM_XFLIP
	dbsprite  -8,  16, $30, 0 | OAM_XFLIP
	dbsprite  -8,  24, $30, 0 | OAM_XFLIP
	dbsprite -24, -32, $30, 0 | OAM_XFLIP
	dbsprite -24, -24, $30, 0 | OAM_XFLIP
	dbsprite -24, -16, $30, 0 | OAM_XFLIP
	dbsprite -24,  -8, $30, 0 | OAM_XFLIP
	dbsprite -24,   0, $30, 0 | OAM_XFLIP
	dbsprite -24,   8, $30, 0 | OAM_XFLIP
	dbsprite -24,  16, $30, 0 | OAM_XFLIP
	dbsprite -24,  24, $30, 0 | OAM_XFLIP

OAMData4D::
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
	db 12 ; size
	dbsprite   0,  16, $01, 0 | OAM_XFLIP
	dbsprite   0,   8, $01, 0
	dbsprite   8, -16, $01, 0 | OAM_XFLIP
	dbsprite   8, -24, $01, 0
	dbsprite  -8,  -8, $01, 0 | OAM_XFLIP
	dbsprite  -8, -16, $01, 0
	dbsprite  -8,  16, $00, 0 | OAM_XFLIP
	dbsprite   0, -16, $00, 0 | OAM_XFLIP
	dbsprite -16,  -8, $00, 0 | OAM_XFLIP
	dbsprite  -8,   8, $00, 0
	dbsprite   0, -24, $00, 0
	dbsprite -16, -16, $00, 0

.frame_1
	db 12 ; size
	dbsprite   0,  16, $03, 0 | OAM_XFLIP
	dbsprite   8, -16, $03, 0 | OAM_XFLIP
	dbsprite  -8,  -8, $03, 0 | OAM_XFLIP
	dbsprite   0,   8, $03, 0
	dbsprite   8, -24, $03, 0
	dbsprite  -8, -16, $03, 0
	dbsprite  -8,  16, $02, 0 | OAM_XFLIP
	dbsprite   0, -16, $02, 0 | OAM_XFLIP
	dbsprite -16,  -8, $02, 0 | OAM_XFLIP
	dbsprite  -8,   8, $02, 0
	dbsprite   0, -24, $02, 0
	dbsprite -16, -16, $02, 0

.frame_2
	db 6 ; size
	dbsprite   0,  12, $05, 0
	dbsprite   8, -20, $05, 0
	dbsprite  -8, -12, $05, 0
	dbsprite  -8,  12, $04, 0
	dbsprite   0, -20, $04, 0
	dbsprite -16, -12, $04, 0

.frame_3
	db 12 ; size
	dbsprite   0,  16, $03, 1 | OAM_XFLIP
	dbsprite   8, -16, $03, 1 | OAM_XFLIP
	dbsprite  -8,  -8, $03, 1 | OAM_XFLIP
	dbsprite   0,   8, $03, 1
	dbsprite   8, -24, $03, 1
	dbsprite  -8, -16, $03, 1
	dbsprite  -8,  16, $02, 1 | OAM_XFLIP
	dbsprite   0, -16, $02, 1 | OAM_XFLIP
	dbsprite -16,  -8, $02, 1 | OAM_XFLIP
	dbsprite  -8,   8, $02, 1
	dbsprite   0, -24, $02, 1
	dbsprite -16, -16, $02, 1

.frame_4
	db 6 ; size
	dbsprite   0,  12, $05, 1
	dbsprite   8, -20, $05, 1
	dbsprite  -8, -12, $05, 1
	dbsprite  -8,  12, $04, 1
	dbsprite   0, -20, $04, 1
	dbsprite -16, -12, $04, 1

.frame_5
	db 12 ; size
	dbsprite   4,  20, $01, 0 | OAM_XFLIP
	dbsprite   4,   4, $01, 0
	dbsprite  12, -12, $01, 0 | OAM_XFLIP
	dbsprite  12, -28, $01, 0
	dbsprite  -4,  -4, $01, 0 | OAM_XFLIP
	dbsprite  -4, -20, $01, 0
	dbsprite -12,  20, $00, 0 | OAM_XFLIP
	dbsprite  -4, -12, $00, 0 | OAM_XFLIP
	dbsprite -20,  -4, $00, 0 | OAM_XFLIP
	dbsprite -12,   4, $00, 0
	dbsprite  -4, -28, $00, 0
	dbsprite -20, -20, $00, 0

.frame_6
	db 12 ; size
	dbsprite   8,  24, $01, 1 | OAM_XFLIP
	dbsprite   8,   0, $01, 1
	dbsprite  16,  -8, $01, 1 | OAM_XFLIP
	dbsprite  16, -32, $01, 1
	dbsprite   0,   0, $01, 1 | OAM_XFLIP
	dbsprite   0, -24, $01, 1
	dbsprite -16,  24, $00, 1 | OAM_XFLIP
	dbsprite  -8,  -8, $00, 1 | OAM_XFLIP
	dbsprite -24,   0, $00, 1 | OAM_XFLIP
	dbsprite -16,   0, $00, 1
	dbsprite  -8, -32, $00, 1
	dbsprite -24, -24, $00, 1

.frame_7
	db 12 ; size
	dbsprite  12,  28, $01, 2 | OAM_XFLIP
	dbsprite  12,  -4, $01, 2
	dbsprite  20,  -4, $01, 2 | OAM_XFLIP
	dbsprite  20, -36, $01, 2
	dbsprite   4,   4, $01, 2 | OAM_XFLIP
	dbsprite   4, -28, $01, 2
	dbsprite -20,  28, $00, 2 | OAM_XFLIP
	dbsprite -12,  -4, $00, 2 | OAM_XFLIP
	dbsprite -28,   4, $00, 2 | OAM_XFLIP
	dbsprite -20,  -4, $00, 2
	dbsprite -12, -36, $00, 2
	dbsprite -28, -28, $00, 2

.frame_8
	db 30 ; size
	dbsprite -12,  44, $0a, 0
	dbsprite  -4,  12, $0a, 0
	dbsprite  -4,  44, $0b, 0
	dbsprite   4,  12, $0b, 0
	dbsprite -12,  20, $0b, 0
	dbsprite -20,  20, $0a, 0
	dbsprite  -4,  36, $09, 0
	dbsprite -12,  36, $08, 0
	dbsprite  -4,  28, $07, 0
	dbsprite  -4,  20, $06, 0
	dbsprite   4,   4, $09, 0
	dbsprite  -4,   4, $08, 0
	dbsprite   4,  -4, $07, 0
	dbsprite   4, -12, $06, 0
	dbsprite -12,  12, $09, 0
	dbsprite -20,  12, $08, 0
	dbsprite -12,   4, $07, 0
	dbsprite -12,  -4, $06, 0
	dbsprite   0,  16, $01, 0 | OAM_XFLIP
	dbsprite   0,   8, $01, 0
	dbsprite   8, -16, $01, 0 | OAM_XFLIP
	dbsprite   8, -24, $01, 0
	dbsprite  -8,  -8, $01, 0 | OAM_XFLIP
	dbsprite  -8, -16, $01, 0
	dbsprite  -8,  16, $00, 0 | OAM_XFLIP
	dbsprite   0, -16, $00, 0 | OAM_XFLIP
	dbsprite -16,  -8, $00, 0 | OAM_XFLIP
	dbsprite  -8,   8, $00, 0
	dbsprite   0, -24, $00, 0
	dbsprite -16, -16, $00, 0

.frame_9
	db 24 ; size
	dbsprite  -4,  36, $09, 0
	dbsprite -12,  36, $08, 0
	dbsprite  -4,  28, $07, 0
	dbsprite  -4,  20, $06, 0
	dbsprite   4,   4, $09, 0
	dbsprite  -4,   4, $08, 0
	dbsprite   4,  -4, $07, 0
	dbsprite   4, -12, $06, 0
	dbsprite -12,  12, $09, 0
	dbsprite -20,  12, $08, 0
	dbsprite -12,   4, $07, 0
	dbsprite -12,  -4, $06, 0
	dbsprite   0,  16, $01, 0 | OAM_XFLIP
	dbsprite   0,   8, $01, 0
	dbsprite   8, -16, $01, 0 | OAM_XFLIP
	dbsprite   8, -24, $01, 0
	dbsprite  -8,  -8, $01, 0 | OAM_XFLIP
	dbsprite  -8, -16, $01, 0
	dbsprite  -8,  16, $00, 0 | OAM_XFLIP
	dbsprite   0, -16, $00, 0 | OAM_XFLIP
	dbsprite -16,  -8, $00, 0 | OAM_XFLIP
	dbsprite  -8,   8, $00, 0
	dbsprite   0, -24, $00, 0
	dbsprite -16, -16, $00, 0

.frame_10
	db 18 ; size
	dbsprite  -4,  28, $07, 0
	dbsprite  -4,  20, $06, 0
	dbsprite   4,  -4, $07, 0
	dbsprite   4, -12, $06, 0
	dbsprite -12,   4, $07, 0
	dbsprite -12,  -4, $06, 0
	dbsprite   0,  16, $01, 0 | OAM_XFLIP
	dbsprite   0,   8, $01, 0
	dbsprite   8, -16, $01, 0 | OAM_XFLIP
	dbsprite   8, -24, $01, 0
	dbsprite  -8,  -8, $01, 0 | OAM_XFLIP
	dbsprite  -8, -16, $01, 0
	dbsprite  -8,  16, $00, 0 | OAM_XFLIP
	dbsprite   0, -16, $00, 0 | OAM_XFLIP
	dbsprite -16,  -8, $00, 0 | OAM_XFLIP
	dbsprite  -8,   8, $00, 0
	dbsprite   0, -24, $00, 0
	dbsprite -16, -16, $00, 0

.frame_11
	db 15 ; size
	dbsprite  -4,  20, $06, 0
	dbsprite   4, -12, $06, 0
	dbsprite -12,  -4, $06, 0
	dbsprite   0,  16, $01, 0 | OAM_XFLIP
	dbsprite   0,   8, $01, 0
	dbsprite   8, -16, $01, 0 | OAM_XFLIP
	dbsprite   8, -24, $01, 0
	dbsprite  -8,  -8, $01, 0 | OAM_XFLIP
	dbsprite  -8, -16, $01, 0
	dbsprite  -8,  16, $00, 0 | OAM_XFLIP
	dbsprite   0, -16, $00, 0 | OAM_XFLIP
	dbsprite -16,  -8, $00, 0 | OAM_XFLIP
	dbsprite  -8,   8, $00, 0
	dbsprite   0, -24, $00, 0
	dbsprite -16, -16, $00, 0

OAMData4F::
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

OAMData50::
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
	dbsprite  -4,   6, $07, 1
	dbsprite  -4,  -2, $06, 1
	dbsprite -12,   6, $05, 1
	dbsprite  -4, -14, $07, 1 | OAM_XFLIP
	dbsprite  -4,  -6, $06, 1 | OAM_XFLIP
	dbsprite -12, -14, $05, 1 | OAM_XFLIP
	dbsprite  -8,  -8, $02, 0
	dbsprite  -8,   0, $02, 0 | OAM_XFLIP

.frame_1
	db 12 ; size
	dbsprite  -4,   6, $07, 1
	dbsprite  -4,  -2, $06, 1
	dbsprite -12,   6, $05, 1
	dbsprite -20,   6, $04, 1
	dbsprite  -4, -14, $07, 1 | OAM_XFLIP
	dbsprite  -4,  -6, $06, 1 | OAM_XFLIP
	dbsprite -12, -14, $05, 1 | OAM_XFLIP
	dbsprite -20, -14, $04, 1 | OAM_XFLIP
	dbsprite  -8,  -8, $02, 0
	dbsprite -16,  -8, $01, 0
	dbsprite  -8,   0, $02, 0 | OAM_XFLIP
	dbsprite -16,   0, $01, 0 | OAM_XFLIP

.frame_2
	db 16 ; size
	dbsprite  -4,   6, $07, 1
	dbsprite  -4,  -2, $06, 1
	dbsprite -12,   6, $05, 1
	dbsprite -20,   6, $04, 1
	dbsprite -28,   6, $03, 1
	dbsprite  -4, -14, $07, 1 | OAM_XFLIP
	dbsprite  -4,  -6, $06, 1 | OAM_XFLIP
	dbsprite -12, -14, $05, 1 | OAM_XFLIP
	dbsprite -20, -14, $04, 1 | OAM_XFLIP
	dbsprite -28, -14, $03, 1 | OAM_XFLIP
	dbsprite  -8,  -8, $02, 0
	dbsprite -16,  -8, $01, 0
	dbsprite -24,  -8, $00, 0
	dbsprite  -8,   0, $02, 0 | OAM_XFLIP
	dbsprite -16,   0, $01, 0 | OAM_XFLIP
	dbsprite -24,   0, $00, 0 | OAM_XFLIP

.frame_3
	db 17 ; size
	dbsprite -12,   6, $05, 1
	dbsprite -20,   6, $04, 1
	dbsprite -28,   6, $03, 1
	dbsprite -12, -14, $05, 1 | OAM_XFLIP
	dbsprite -20, -14, $04, 1 | OAM_XFLIP
	dbsprite -28, -14, $03, 1 | OAM_XFLIP
	dbsprite  -8,  -8, $02, 0
	dbsprite -16,  -8, $01, 0
	dbsprite -24,  -8, $00, 0
	dbsprite  -8,   0, $02, 0 | OAM_XFLIP
	dbsprite -16,   0, $01, 0 | OAM_XFLIP
	dbsprite -24,   0, $00, 0 | OAM_XFLIP
	dbsprite   0,   4, $08, 1 | OAM_XFLIP
	dbsprite   0,  -4, $09, 1
	dbsprite   0, -12, $08, 1
	dbsprite  -8,   4, $08, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite  -8, -12, $08, 1 | OAM_YFLIP

.frame_4
	db 16 ; size
	dbsprite -12,   6, $04, 1
	dbsprite -20,   6, $03, 1
	dbsprite -12, -14, $04, 1 | OAM_XFLIP
	dbsprite -20, -14, $03, 1 | OAM_XFLIP
	dbsprite  -8,  -8, $01, 0
	dbsprite -16,  -8, $00, 0
	dbsprite  -8,   0, $01, 0 | OAM_XFLIP
	dbsprite -16,   0, $00, 0 | OAM_XFLIP
	dbsprite -12,   8, $0b, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite -12, -16, $0b, 1 | OAM_YFLIP
	dbsprite   4,   0, $0c, 1 | OAM_XFLIP
	dbsprite   4,   8, $0b, 1 | OAM_XFLIP
	dbsprite   4,  -8, $0c, 1
	dbsprite   4, -16, $0b, 1
	dbsprite  -4,   8, $0a, 1 | OAM_XFLIP
	dbsprite  -4, -16, $0a, 1

.frame_5
	db 20 ; size
	dbsprite -12,   6, $03, 1
	dbsprite -12, -14, $03, 1 | OAM_XFLIP
	dbsprite  -8,  -8, $00, 0
	dbsprite  -8,   0, $00, 0 | OAM_XFLIP
	dbsprite   0,  16, $10, 1 | OAM_XFLIP
	dbsprite  -8,  16, $10, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite  -8, -24, $10, 1 | OAM_YFLIP
	dbsprite   0, -24, $10, 1
	dbsprite   8,   0, $0f, 1 | OAM_XFLIP
	dbsprite   8,   8, $0e, 1 | OAM_XFLIP
	dbsprite   8,  16, $0d, 1 | OAM_XFLIP
	dbsprite -16,   0, $0f, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite -16,   8, $0e, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite -16,  16, $0d, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite -16,  -8, $0f, 1 | OAM_YFLIP
	dbsprite -16, -16, $0e, 1 | OAM_YFLIP
	dbsprite -16, -24, $0d, 1 | OAM_YFLIP
	dbsprite   8,  -8, $0f, 1
	dbsprite   8, -16, $0e, 1
	dbsprite   8, -24, $0d, 1

.frame_6
	db 26 ; size
	dbsprite   0,   4, $08, 2 | OAM_XFLIP
	dbsprite  -8,   4, $08, 2 | OAM_XFLIP | OAM_YFLIP
	dbsprite   0,  -4, $09, 2
	dbsprite   0, -12, $08, 2
	dbsprite  -8,  -4, $09, 2 | OAM_YFLIP
	dbsprite  -8, -12, $08, 2 | OAM_YFLIP
	dbsprite -20,   4, $15, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite -20,  12, $14, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite -20,  -4, $16, 1 | OAM_YFLIP
	dbsprite -20, -12, $15, 1 | OAM_YFLIP
	dbsprite -20, -20, $14, 1 | OAM_YFLIP
	dbsprite -12,  12, $13, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite -12,  20, $12, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite -12, -20, $13, 1 | OAM_YFLIP
	dbsprite -12, -28, $12, 1 | OAM_YFLIP
	dbsprite  12,   4, $15, 1 | OAM_XFLIP
	dbsprite  12,  12, $14, 1 | OAM_XFLIP
	dbsprite  12,  -4, $16, 1
	dbsprite  12, -12, $15, 1
	dbsprite  12, -20, $14, 1
	dbsprite   4,  12, $13, 1 | OAM_XFLIP
	dbsprite   4,  20, $12, 1 | OAM_XFLIP
	dbsprite   4, -20, $13, 1
	dbsprite   4, -28, $12, 1
	dbsprite  -4,  20, $11, 1 | OAM_XFLIP
	dbsprite  -4, -28, $11, 1

.frame_7
	db 10 ; size
	dbsprite   4,   0, $0c, 2 | OAM_XFLIP
	dbsprite   4,  -8, $0c, 2
	dbsprite -12,   8, $0b, 2 | OAM_XFLIP | OAM_YFLIP
	dbsprite -12, -16, $0b, 2 | OAM_YFLIP
	dbsprite -12,   0, $0c, 2 | OAM_XFLIP | OAM_YFLIP
	dbsprite   4,   8, $0b, 2 | OAM_XFLIP
	dbsprite -12,  -8, $0c, 2 | OAM_YFLIP
	dbsprite   4, -16, $0b, 2
	dbsprite  -4,   8, $0a, 2 | OAM_XFLIP
	dbsprite  -4, -16, $0a, 2

.frame_8
	db 16 ; size
	dbsprite   0,  16, $10, 2 | OAM_XFLIP
	dbsprite  -8,  16, $10, 2 | OAM_XFLIP | OAM_YFLIP
	dbsprite  -8, -24, $10, 2 | OAM_YFLIP
	dbsprite   0, -24, $10, 2
	dbsprite   8,   0, $0f, 2 | OAM_XFLIP
	dbsprite   8,   8, $0e, 2 | OAM_XFLIP
	dbsprite   8,  16, $0d, 2 | OAM_XFLIP
	dbsprite -16,   0, $0f, 2 | OAM_XFLIP | OAM_YFLIP
	dbsprite -16,   8, $0e, 2 | OAM_XFLIP | OAM_YFLIP
	dbsprite -16,  16, $0d, 2 | OAM_XFLIP | OAM_YFLIP
	dbsprite -16,  -8, $0f, 2 | OAM_YFLIP
	dbsprite -16, -16, $0e, 2 | OAM_YFLIP
	dbsprite -16, -24, $0d, 2 | OAM_YFLIP
	dbsprite   8,  -8, $0f, 2
	dbsprite   8, -16, $0e, 2
	dbsprite   8, -24, $0d, 2

.frame_9
	db 20 ; size
	dbsprite -20,   4, $15, 2 | OAM_XFLIP | OAM_YFLIP
	dbsprite -20,  12, $14, 2 | OAM_XFLIP | OAM_YFLIP
	dbsprite -20,  -4, $16, 2 | OAM_YFLIP
	dbsprite -20, -12, $15, 2 | OAM_YFLIP
	dbsprite -20, -20, $14, 2 | OAM_YFLIP
	dbsprite -12,  12, $13, 2 | OAM_XFLIP | OAM_YFLIP
	dbsprite -12,  20, $12, 2 | OAM_XFLIP | OAM_YFLIP
	dbsprite -12, -20, $13, 2 | OAM_YFLIP
	dbsprite -12, -28, $12, 2 | OAM_YFLIP
	dbsprite  12,   4, $15, 2 | OAM_XFLIP
	dbsprite  12,  12, $14, 2 | OAM_XFLIP
	dbsprite  12,  -4, $16, 2
	dbsprite  12, -12, $15, 2
	dbsprite  12, -20, $14, 2
	dbsprite   4,  12, $13, 2 | OAM_XFLIP
	dbsprite   4,  20, $12, 2 | OAM_XFLIP
	dbsprite   4, -20, $13, 2
	dbsprite   4, -28, $12, 2
	dbsprite  -4,  20, $11, 2 | OAM_XFLIP
	dbsprite  -4, -28, $11, 2

OAMData51::
	dw .frame_0
	dw .frame_1
	dw .frame_2
	dw .frame_3
	dw .frame_4
	dw .frame_5
	dw .frame_6

.frame_0
	db 5 ; size
	dbsprite   0,   0, $04, 1
	dbsprite  -8,   1, $03, 1
	dbsprite   0,  -8, $04, 1 | OAM_XFLIP
	dbsprite  -8,  -9, $03, 1 | OAM_XFLIP
	dbsprite  -8,  -4, $01, 0

.frame_1
	db 8 ; size
	dbsprite   0,   0, $04, 1
	dbsprite  -8,   1, $03, 1
	dbsprite -16,   1, $02, 1
	dbsprite   0,  -8, $04, 1 | OAM_XFLIP
	dbsprite  -8,  -9, $03, 1 | OAM_XFLIP
	dbsprite -16,  -9, $02, 1 | OAM_XFLIP
	dbsprite  -8,  -4, $01, 0
	dbsprite -16,  -4, $00, 0

.frame_2
	db 9 ; size
	dbsprite  -8,   1, $03, 1
	dbsprite -16,   1, $02, 1
	dbsprite  -8,  -9, $03, 1 | OAM_XFLIP
	dbsprite -16,  -9, $02, 1 | OAM_XFLIP
	dbsprite  -8,  -4, $01, 0
	dbsprite -16,  -4, $00, 0
	dbsprite  -4,   4, $05, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite  -4,  -4, $06, 1
	dbsprite  -4, -12, $05, 1

.frame_3
	db 7 ; size
	dbsprite  -8,   1, $02, 1
	dbsprite  -8,  -9, $02, 1 | OAM_XFLIP
	dbsprite  -8,  -4, $00, 0
	dbsprite   0,   0, $07, 1 | OAM_XFLIP
	dbsprite   0,  -8, $07, 1
	dbsprite  -8,   0, $07, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite  -8,  -8, $07, 1 | OAM_YFLIP

.frame_4
	db 10 ; size
	dbsprite  -4,  -4, $06, 2 | OAM_XFLIP | OAM_YFLIP
	dbsprite  -4,   4, $05, 2 | OAM_XFLIP | OAM_YFLIP
	dbsprite  -4,  -4, $06, 2
	dbsprite  -4, -12, $05, 2
	dbsprite   0, -12, $0a, 1
	dbsprite  -8, -12, $08, 1
	dbsprite   1,  -4, $0b, 1
	dbsprite   0,   4, $0a, 1 | OAM_XFLIP
	dbsprite  -8,  -4, $09, 1
	dbsprite  -8,   4, $08, 1 | OAM_XFLIP

.frame_5
	db 4 ; size
	dbsprite   0,   0, $07, 2 | OAM_XFLIP
	dbsprite   0,  -8, $07, 2
	dbsprite  -8,   0, $07, 2 | OAM_XFLIP | OAM_YFLIP
	dbsprite  -8,  -8, $07, 2 | OAM_YFLIP

.frame_6
	db 6 ; size
	dbsprite   0, -12, $0a, 2
	dbsprite  -8, -12, $08, 2
	dbsprite   1,  -4, $0b, 2
	dbsprite   0,   4, $0a, 2 | OAM_XFLIP
	dbsprite  -8,  -4, $09, 2
	dbsprite  -8,   4, $08, 2 | OAM_XFLIP

OAMData52::
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
	db 3 ; size
	dbsprite  13, -35, $06, 0
	dbsprite  13, -27, $07, 0
	dbsprite  13, -19, $06, 0 | OAM_XFLIP

.frame_1
	db 4 ; size
	dbsprite   9, -35, $03, 0
	dbsprite   9, -27, $04, 0
	dbsprite  17, -27, $04, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite  17, -19, $05, 0

.frame_2
	db 3 ; size
	dbsprite   5, -27, $00, 0
	dbsprite  13, -27, $01, 0
	dbsprite  21, -27, $02, 0

.frame_3
	db 4 ; size
	dbsprite   9, -19, $03, 0 | OAM_XFLIP
	dbsprite   9, -27, $04, 0 | OAM_XFLIP
	dbsprite  17, -27, $04, 0 | OAM_YFLIP
	dbsprite  17, -35, $05, 0 | OAM_XFLIP

.frame_4
	db 7 ; size
	dbsprite   5, -27, $00, 0
	dbsprite  13, -27, $01, 0
	dbsprite  21, -27, $02, 0
	dbsprite  16, -23, $08, 0 | OAM_YFLIP
	dbsprite  16, -15, $09, 0 | OAM_YFLIP
	dbsprite   8, -23, $0a, 0 | OAM_YFLIP
	dbsprite   8, -15, $0b, 0 | OAM_YFLIP

.frame_5
	db 8 ; size
	dbsprite   9, -19, $03, 0 | OAM_XFLIP
	dbsprite   9, -27, $04, 0 | OAM_XFLIP
	dbsprite  17, -27, $04, 0 | OAM_YFLIP
	dbsprite  17, -35, $05, 0 | OAM_XFLIP
	dbsprite   6, -20, $08, 1
	dbsprite   6, -12, $09, 1
	dbsprite  14, -20, $0a, 1
	dbsprite  14, -12, $0b, 1

.frame_6
	db 7 ; size
	dbsprite  13, -35, $06, 0
	dbsprite  13, -27, $07, 0
	dbsprite  13, -19, $06, 0 | OAM_XFLIP
	dbsprite  12, -17, $08, 2 | OAM_YFLIP
	dbsprite  12,  -9, $09, 2 | OAM_YFLIP
	dbsprite   4, -17, $0a, 2 | OAM_YFLIP
	dbsprite   4,  -9, $0b, 2 | OAM_YFLIP

.frame_7
	db 7 ; size
	dbsprite -59, -44, $00, 0
	dbsprite -51, -44, $01, 0
	dbsprite -43, -44, $02, 0
	dbsprite -46, -38, $08, 0
	dbsprite -46, -30, $09, 0
	dbsprite -38, -38, $0a, 0
	dbsprite -38, -30, $0b, 0

.frame_8
	db 8 ; size
	dbsprite -55, -36, $03, 0 | OAM_XFLIP
	dbsprite -55, -44, $04, 0 | OAM_XFLIP
	dbsprite -47, -44, $04, 0 | OAM_YFLIP
	dbsprite -47, -52, $05, 0 | OAM_XFLIP
	dbsprite -35, -35, $08, 1 | OAM_YFLIP
	dbsprite -35, -27, $09, 1 | OAM_YFLIP
	dbsprite -43, -35, $0a, 1 | OAM_YFLIP
	dbsprite -43, -27, $0b, 1 | OAM_YFLIP

.frame_9
	db 7 ; size
	dbsprite -52, -52, $06, 0
	dbsprite -52, -44, $07, 0
	dbsprite -52, -36, $06, 0 | OAM_XFLIP
	dbsprite -40, -32, $08, 1
	dbsprite -40, -24, $09, 1
	dbsprite -32, -32, $0a, 1
	dbsprite -32, -24, $0b, 1

.frame_10
	db 8 ; size
	dbsprite -29, -28, $08, 2 | OAM_YFLIP
	dbsprite -29, -20, $09, 2 | OAM_YFLIP
	dbsprite -37, -28, $0a, 2 | OAM_YFLIP
	dbsprite -37, -20, $0b, 2 | OAM_YFLIP
	dbsprite -55, -52, $03, 0
	dbsprite -55, -44, $04, 0
	dbsprite -47, -44, $04, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite -47, -36, $05, 0

OAMData53::
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
	db 19 ; size
	dbsprite   8,  -8, $12, 0
	dbsprite   8, -16, $11, 0
	dbsprite   8, -24, $10, 0
	dbsprite   0,   0, $0f, 0
	dbsprite   0,  -8, $0e, 0
	dbsprite   0, -16, $0d, 0
	dbsprite   0, -24, $0c, 0
	dbsprite  -8,   0, $0b, 0
	dbsprite  -8,  -8, $0a, 0
	dbsprite  -8, -16, $09, 0
	dbsprite  -8, -24, $08, 0
	dbsprite  -8, -32, $07, 0
	dbsprite -16,  -8, $06, 0
	dbsprite -16, -16, $05, 0
	dbsprite -16, -24, $04, 0
	dbsprite -16, -32, $03, 0
	dbsprite -24,  -8, $02, 0
	dbsprite -24, -16, $01, 0
	dbsprite -24, -24, $00, 0

.frame_1
	db 21 ; size
	dbsprite   9,  -7, $13, 1 | OAM_XFLIP
	dbsprite   8, -24, $13, 1
	dbsprite   8,  -8, $12, 0
	dbsprite   8, -16, $11, 0
	dbsprite   8, -24, $10, 0
	dbsprite   0,   0, $0f, 0
	dbsprite   0,  -8, $0e, 0
	dbsprite   0, -16, $0d, 0
	dbsprite   0, -24, $0c, 0
	dbsprite  -8,   0, $0b, 0
	dbsprite  -8,  -8, $0a, 0
	dbsprite  -8, -16, $09, 0
	dbsprite  -8, -24, $08, 0
	dbsprite  -8, -32, $07, 0
	dbsprite -16,  -8, $06, 0
	dbsprite -16, -16, $05, 0
	dbsprite -16, -24, $04, 0
	dbsprite -16, -32, $03, 0
	dbsprite -24,  -8, $02, 0
	dbsprite -24, -16, $01, 0
	dbsprite -24, -24, $00, 0

.frame_2
	db 21 ; size
	dbsprite   5,   5, $13, 1 | OAM_XFLIP
	dbsprite   6, -34, $13, 1
	dbsprite   8,  -8, $12, 0
	dbsprite   8, -16, $11, 0
	dbsprite   8, -24, $10, 0
	dbsprite   0,   0, $0f, 0
	dbsprite   0,  -8, $0e, 0
	dbsprite   0, -16, $0d, 0
	dbsprite   0, -24, $0c, 0
	dbsprite  -8,   0, $0b, 0
	dbsprite  -8,  -8, $0a, 0
	dbsprite  -8, -16, $09, 0
	dbsprite  -8, -24, $08, 0
	dbsprite  -8, -32, $07, 0
	dbsprite -16,  -8, $06, 0
	dbsprite -16, -16, $05, 0
	dbsprite -16, -24, $04, 0
	dbsprite -16, -32, $03, 0
	dbsprite -24,  -8, $02, 0
	dbsprite -24, -16, $01, 0
	dbsprite -24, -24, $00, 0

.frame_3
	db 16 ; size
	dbsprite -16,   8, $14, 0 | OAM_XFLIP
	dbsprite -16,   0, $15, 0 | OAM_XFLIP
	dbsprite   8,   8, $23, 0
	dbsprite   8,   0, $22, 0
	dbsprite   8,  -8, $21, 0
	dbsprite   8, -16, $20, 0
	dbsprite   0,   8, $1f, 0
	dbsprite   0,   0, $1e, 0
	dbsprite   0,  -8, $1d, 0
	dbsprite   0, -16, $1c, 0
	dbsprite  -8,   8, $1b, 0
	dbsprite  -8,   0, $1a, 0
	dbsprite  -8,  -8, $19, 0
	dbsprite  -8, -16, $18, 0
	dbsprite -16,  -8, $15, 0
	dbsprite -16, -16, $14, 0

.frame_4
	db 16 ; size
	dbsprite -16,   8, $14, 1 | OAM_XFLIP
	dbsprite -16,  -8, $15, 1
	dbsprite   8,   8, $23, 1
	dbsprite   8,   0, $22, 1
	dbsprite   8,  -8, $21, 1
	dbsprite   8, -16, $20, 1
	dbsprite   0,   8, $1f, 1
	dbsprite   0,   0, $1e, 1
	dbsprite   0,  -8, $1d, 1
	dbsprite   0, -16, $1c, 1
	dbsprite  -8,   8, $1b, 1
	dbsprite  -8,   0, $1a, 1
	dbsprite  -8,  -8, $19, 1
	dbsprite  -8, -16, $18, 1
	dbsprite -16,   0, $15, 1 | OAM_XFLIP
	dbsprite -16, -16, $14, 1

.frame_5
	db 16 ; size
	dbsprite -16,   8, $14, 1 | OAM_XFLIP
	dbsprite   8,  -8, $27, 1
	dbsprite -16,   0, $24, 1
	dbsprite   8,   8, $23, 1
	dbsprite   8,   0, $22, 1
	dbsprite   8, -16, $20, 1
	dbsprite   0,   8, $1f, 1
	dbsprite   0,   0, $1e, 1
	dbsprite   0,  -8, $1d, 1
	dbsprite   0, -16, $1c, 1
	dbsprite  -8,   8, $1b, 1
	dbsprite  -8,   0, $1a, 1
	dbsprite  -8,  -8, $19, 1
	dbsprite  -8, -16, $18, 1
	dbsprite -16,  -8, $15, 1
	dbsprite -16, -16, $14, 1

.frame_6
	db 16 ; size
	dbsprite -16,   8, $14, 1 | OAM_XFLIP
	dbsprite   0,  -8, $26, 1
	dbsprite  -8,   0, $25, 1
	dbsprite   8,  -8, $27, 1
	dbsprite -16,   0, $24, 1
	dbsprite   8,   8, $23, 1
	dbsprite   8,   0, $22, 1
	dbsprite   8, -16, $20, 1
	dbsprite   0,   8, $1f, 1
	dbsprite   0,   0, $1e, 1
	dbsprite   0, -16, $1c, 1
	dbsprite  -8,   8, $1b, 1
	dbsprite  -8,  -8, $19, 1
	dbsprite  -8, -16, $18, 1
	dbsprite -16,  -8, $15, 1
	dbsprite -16, -16, $14, 1

.frame_7
	db 17 ; size
	dbsprite -15,   8, $14, 1 | OAM_XFLIP
	dbsprite   8,   8, $23, 1
	dbsprite   8,   0, $22, 1
	dbsprite   8,  -8, $32, 1
	dbsprite   8, -16, $31, 1
	dbsprite   0,   8, $1f, 1
	dbsprite   0,   0, $30, 1
	dbsprite   0,  -8, $2f, 1
	dbsprite   0, -16, $2e, 1
	dbsprite  -7,   8, $1b, 1
	dbsprite  -8,   0, $2d, 1
	dbsprite  -8,  -8, $2c, 1
	dbsprite  -8, -16, $2b, 1
	dbsprite -15,   8, $17, 1
	dbsprite -16,   0, $2a, 1
	dbsprite -16,  -8, $29, 1
	dbsprite -16, -16, $28, 1

.frame_8
	db 17 ; size
	dbsprite   8,   8, $23, 1
	dbsprite   8,   0, $22, 1
	dbsprite   8,  -8, $32, 1
	dbsprite   8, -16, $31, 1
	dbsprite   0,  16, $3f, 1
	dbsprite   0,   8, $3e, 1
	dbsprite   0,   0, $3d, 1
	dbsprite   0,  -8, $3c, 1
	dbsprite   0, -16, $3b, 1
	dbsprite  -8,  16, $3a, 1
	dbsprite  -8,   8, $39, 1
	dbsprite  -8,   0, $38, 1
	dbsprite  -8,  -8, $37, 1
	dbsprite  -8, -16, $36, 1
	dbsprite -16,   7, $35, 1
	dbsprite -16,  -7, $34, 1
	dbsprite -16, -15, $33, 1

.frame_9
	db 10 ; size
	dbsprite   8, -16, $17, 1
	dbsprite   8,   8, $16, 1
	dbsprite   8,   0, $22, 1
	dbsprite   8,  -8, $32, 1
	dbsprite   3,  16, $45, 1
	dbsprite   0,   8, $44, 1
	dbsprite   0,   0, $43, 1
	dbsprite   0,  -8, $42, 1
	dbsprite   0, -16, $41, 1
	dbsprite   4, -24, $40, 1

OAMData54::
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
	db 8 ; size
	dbsprite -32,  32, $0b, 0 | OAM_XFLIP
	dbsprite -32,  40, $0a, 0 | OAM_XFLIP
	dbsprite -40,  32, $05, 0 | OAM_XFLIP
	dbsprite -40,  40, $04, 0 | OAM_XFLIP
	dbsprite -16, -48, $07, 1 | OAM_XFLIP
	dbsprite -16, -40, $06, 1 | OAM_XFLIP
	dbsprite -24, -48, $01, 1 | OAM_XFLIP
	dbsprite -24, -40, $00, 1 | OAM_XFLIP

.frame_1
	db 8 ; size
	dbsprite -24,  32, $09, 0
	dbsprite -24,  24, $08, 0
	dbsprite -32,  32, $03, 0
	dbsprite -32,  24, $02, 0
	dbsprite -10, -40, $09, 1 | OAM_XFLIP
	dbsprite -10, -32, $08, 1 | OAM_XFLIP
	dbsprite -18, -40, $03, 1 | OAM_XFLIP
	dbsprite -18, -32, $02, 1 | OAM_XFLIP

.frame_2
	db 8 ; size
	dbsprite -16,  24, $07, 0
	dbsprite -16,  16, $06, 0
	dbsprite -24,  24, $01, 0
	dbsprite -24,  16, $00, 0
	dbsprite  -6, -34, $0b, 1 | OAM_XFLIP
	dbsprite  -6, -26, $0a, 1 | OAM_XFLIP
	dbsprite -14, -34, $05, 1 | OAM_XFLIP
	dbsprite -14, -26, $04, 1 | OAM_XFLIP

.frame_3
	db 8 ; size
	dbsprite -16,  16, $0b, 0 | OAM_YFLIP
	dbsprite -16,   8, $0a, 0 | OAM_YFLIP
	dbsprite  -8,  16, $05, 0 | OAM_YFLIP
	dbsprite  -8,   8, $04, 0 | OAM_YFLIP
	dbsprite   0, -18, $09, 1
	dbsprite   0, -26, $08, 1
	dbsprite  -8, -18, $03, 1
	dbsprite  -8, -26, $02, 1

.frame_4
	db 8 ; size
	dbsprite   0,   0, $07, 0 | OAM_XFLIP
	dbsprite   0,   8, $06, 0 | OAM_XFLIP
	dbsprite  -8,   0, $01, 0 | OAM_XFLIP
	dbsprite  -8,   8, $00, 0 | OAM_XFLIP
	dbsprite   4, -12, $07, 1
	dbsprite   4, -20, $06, 1
	dbsprite  -4, -12, $01, 1
	dbsprite  -4, -20, $00, 1

.frame_5
	db 8 ; size
	dbsprite   6,  -8, $09, 0 | OAM_XFLIP
	dbsprite   6,   0, $08, 0 | OAM_XFLIP
	dbsprite  -2,  -8, $03, 0 | OAM_XFLIP
	dbsprite  -2,   0, $02, 0 | OAM_XFLIP
	dbsprite   0,  -4, $0b, 1 | OAM_YFLIP
	dbsprite   0, -12, $0a, 1 | OAM_YFLIP
	dbsprite   8,  -4, $05, 1 | OAM_YFLIP
	dbsprite   8, -12, $04, 1 | OAM_YFLIP

.frame_6
	db 8 ; size
	dbsprite  12, -16, $0b, 0 | OAM_XFLIP
	dbsprite  12,  -8, $0a, 0 | OAM_XFLIP
	dbsprite   4, -16, $05, 0 | OAM_XFLIP
	dbsprite   4,  -8, $04, 0 | OAM_XFLIP
	dbsprite  12,  -4, $07, 1 | OAM_XFLIP
	dbsprite  12,   4, $06, 1 | OAM_XFLIP
	dbsprite   4,  -4, $01, 1 | OAM_XFLIP
	dbsprite   4,   4, $00, 1 | OAM_XFLIP

.frame_7
	db 8 ; size
	dbsprite  15, -14, $09, 0
	dbsprite  15, -22, $08, 0
	dbsprite   7, -14, $03, 0
	dbsprite   7, -22, $02, 0
	dbsprite  14,   4, $09, 1 | OAM_XFLIP
	dbsprite  14,  12, $08, 1 | OAM_XFLIP
	dbsprite   6,   4, $03, 1 | OAM_XFLIP
	dbsprite   6,  12, $02, 1 | OAM_XFLIP

.frame_8
	db 8 ; size
	dbsprite  16, -18, $07, 0
	dbsprite  16, -26, $06, 0
	dbsprite   8, -18, $01, 0
	dbsprite   8, -26, $00, 0
	dbsprite  16,   8, $0b, 1 | OAM_XFLIP
	dbsprite  16,  16, $0a, 1 | OAM_XFLIP
	dbsprite   8,   8, $05, 1 | OAM_XFLIP
	dbsprite   8,  16, $04, 1 | OAM_XFLIP

.frame_9
	db 8 ; size
	dbsprite   8, -20, $0b, 0 | OAM_YFLIP
	dbsprite   8, -28, $0a, 0 | OAM_YFLIP
	dbsprite  16, -20, $05, 0 | OAM_YFLIP
	dbsprite  16, -28, $04, 0 | OAM_YFLIP
	dbsprite  14,  20, $09, 1
	dbsprite  14,  12, $08, 1
	dbsprite   6,  20, $03, 1
	dbsprite   6,  12, $02, 1

.frame_10
	db 8 ; size
	dbsprite  14, -30, $07, 0 | OAM_XFLIP
	dbsprite  14, -22, $06, 0 | OAM_XFLIP
	dbsprite  10,  20, $07, 1
	dbsprite  10,  12, $06, 1
	dbsprite   6, -30, $01, 0 | OAM_XFLIP
	dbsprite   6, -22, $00, 0 | OAM_XFLIP
	dbsprite   2,  20, $01, 1
	dbsprite   2,  12, $00, 1

.frame_11
	db 8 ; size
	dbsprite  12, -32, $09, 0 | OAM_XFLIP
	dbsprite  12, -24, $08, 0 | OAM_XFLIP
	dbsprite   4, -32, $03, 0 | OAM_XFLIP
	dbsprite   4, -24, $02, 0 | OAM_XFLIP
	dbsprite  -2,  19, $0b, 1 | OAM_YFLIP
	dbsprite  -2,  11, $0a, 1 | OAM_YFLIP
	dbsprite   6,  19, $05, 1 | OAM_YFLIP
	dbsprite   6,  11, $04, 1 | OAM_YFLIP

.frame_12
	db 8 ; size
	dbsprite  10, -31, $0b, 0 | OAM_XFLIP
	dbsprite  10, -23, $0a, 0 | OAM_XFLIP
	dbsprite   2, -31, $05, 0 | OAM_XFLIP
	dbsprite   2, -23, $04, 0 | OAM_XFLIP
	dbsprite   4,   8, $07, 1 | OAM_XFLIP
	dbsprite   4,  16, $06, 1 | OAM_XFLIP
	dbsprite  -4,   8, $01, 1 | OAM_XFLIP
	dbsprite  -4,  16, $00, 1 | OAM_XFLIP

.frame_13
	db 8 ; size
	dbsprite   8, -22, $09, 0
	dbsprite   8, -30, $08, 0
	dbsprite   0, -22, $03, 0
	dbsprite   0, -30, $02, 0
	dbsprite   0,   0, $09, 1 | OAM_XFLIP
	dbsprite   0,   8, $08, 1 | OAM_XFLIP
	dbsprite  -8,   0, $03, 1 | OAM_XFLIP
	dbsprite  -8,   8, $02, 1 | OAM_XFLIP

.frame_14
	db 8 ; size
	dbsprite   5, -20, $07, 0
	dbsprite   5, -28, $06, 0
	dbsprite  -3, -20, $01, 0
	dbsprite  -3, -28, $00, 0
	dbsprite  -6,  -6, $0b, 1 | OAM_XFLIP
	dbsprite  -6,   2, $0a, 1 | OAM_XFLIP
	dbsprite -14,  -6, $05, 1 | OAM_XFLIP
	dbsprite -14,   2, $04, 1 | OAM_XFLIP

.frame_15
	db 8 ; size
	dbsprite  -8, -16, $0b, 0 | OAM_YFLIP
	dbsprite  -8, -24, $0a, 0 | OAM_YFLIP
	dbsprite   0, -16, $05, 0 | OAM_YFLIP
	dbsprite   0, -24, $04, 0 | OAM_YFLIP
	dbsprite  -8,  -6, $09, 1
	dbsprite  -8, -14, $08, 1
	dbsprite -16,  -6, $03, 1
	dbsprite -16, -14, $02, 1

.frame_16
	db 8 ; size
	dbsprite -11, -20, $07, 0 | OAM_XFLIP
	dbsprite -11, -12, $06, 0 | OAM_XFLIP
	dbsprite -19, -20, $01, 0 | OAM_XFLIP
	dbsprite -19, -12, $00, 0 | OAM_XFLIP
	dbsprite -16, -15, $07, 1
	dbsprite -16, -23, $06, 1
	dbsprite -24, -15, $01, 1
	dbsprite -24, -23, $00, 1

.frame_17
	db 8 ; size
	dbsprite -16, -14, $09, 0 | OAM_XFLIP
	dbsprite -16,  -6, $08, 0 | OAM_XFLIP
	dbsprite -24, -14, $03, 0 | OAM_XFLIP
	dbsprite -24,  -6, $02, 0 | OAM_XFLIP
	dbsprite -24, -24, $0b, 1 | OAM_YFLIP
	dbsprite -24, -32, $0a, 1 | OAM_YFLIP
	dbsprite -16, -24, $05, 1 | OAM_YFLIP
	dbsprite -16, -32, $04, 1 | OAM_YFLIP

.frame_18
	db 8 ; size
	dbsprite -24,  -8, $0b, 0 | OAM_XFLIP
	dbsprite -24,   0, $0a, 0 | OAM_XFLIP
	dbsprite -32,  -8, $05, 0 | OAM_XFLIP
	dbsprite -32,   0, $04, 0 | OAM_XFLIP
	dbsprite -20, -40, $07, 1 | OAM_XFLIP
	dbsprite -20, -32, $06, 1 | OAM_XFLIP
	dbsprite -28, -40, $01, 1 | OAM_XFLIP
	dbsprite -28, -32, $00, 1 | OAM_XFLIP

.frame_19
	db 8 ; size
	dbsprite -32,   8, $09, 0
	dbsprite -32,   0, $08, 0
	dbsprite -40,   8, $03, 0
	dbsprite -40,   0, $02, 0
	dbsprite -24, -48, $09, 1 | OAM_XFLIP
	dbsprite -24, -40, $08, 1 | OAM_XFLIP
	dbsprite -32, -48, $03, 1 | OAM_XFLIP
	dbsprite -32, -40, $02, 1 | OAM_XFLIP

OAMData55::
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
	db 2 ; size
	dbsprite  16,  24, $10, 0
	dbsprite   8,  24, $00, 1

.frame_1
	db 6 ; size
	dbsprite  16,   9, $09, 0
	dbsprite  16,  24, $21, 0
	dbsprite   8,  24, $11, 0
	dbsprite   8,  16, $10, 0
	dbsprite   0,  24, $01, 1
	dbsprite   0,  16, $00, 1

.frame_2
	db 12 ; size
	dbsprite  16,  24, $05, 0
	dbsprite   8,  24, $22, 0
	dbsprite   0,  24, $12, 1
	dbsprite  -8,  24, $02, 1
	dbsprite  16,   8, $0b, 0
	dbsprite  16,   0, $0a, 0
	dbsprite   8,   1, $09, 0
	dbsprite   8,  16, $21, 0
	dbsprite   0,  16, $11, 0
	dbsprite   0,   8, $10, 0
	dbsprite  -8,  16, $01, 1
	dbsprite  -8,   8, $00, 1

.frame_3
	db 21 ; size
	dbsprite  16,  16, $1b, 0
	dbsprite  16,   8, $1a, 0
	dbsprite  16,   0, $19, 0
	dbsprite  16,  -8, $18, 0
	dbsprite  16,  24, $16, 0
	dbsprite   8,  24, $06, 0
	dbsprite   0,  24, $23, 1
	dbsprite  -8,  24, $13, 1
	dbsprite -16,  24, $03, 1
	dbsprite   8,  16, $05, 0
	dbsprite   0,  16, $22, 0
	dbsprite  -8,  16, $12, 1
	dbsprite -16,  16, $02, 1
	dbsprite   8,   0, $0b, 0
	dbsprite   8,  -8, $0a, 0
	dbsprite   0,  -7, $09, 0
	dbsprite   0,   8, $21, 0
	dbsprite  -8,   8, $11, 0
	dbsprite  -8,   0, $10, 0
	dbsprite -16,   8, $01, 1
	dbsprite -16,   0, $00, 1

.frame_4
	db 27 ; size
	dbsprite  16,   8, $0f, 0
	dbsprite  16,   0, $1e, 0
	dbsprite  16,  -8, $1d, 0
	dbsprite   8,   0, $0e, 0
	dbsprite   8,  -8, $0d, 0
	dbsprite  15, -16, $1c, 0
	dbsprite   7, -16, $0c, 0
	dbsprite  16,  16, $26, 0
	dbsprite  16,  24, $27, 0
	dbsprite   8,  24, $17, 0
	dbsprite   0,  24, $07, 0
	dbsprite  -8,  24, $24, 1
	dbsprite -16,  24, $14, 1
	dbsprite   8,  16, $16, 0
	dbsprite   0,  16, $06, 0
	dbsprite  -8,  16, $23, 1
	dbsprite -16,  16, $13, 1
	dbsprite -24,  16, $03, 1
	dbsprite   0,   8, $05, 0
	dbsprite  -8,   8, $22, 0
	dbsprite -16,   8, $12, 1
	dbsprite -24,   8, $02, 1
	dbsprite  -8,   0, $21, 0
	dbsprite -16,   0, $11, 0
	dbsprite -16,  -8, $10, 0
	dbsprite -24,   0, $01, 1
	dbsprite -24,  -8, $00, 1

.frame_5
	db 33 ; size
	dbsprite  16,  24, $1f, 0
	dbsprite   8,  24, $28, 0
	dbsprite   0,  24, $23, 1
	dbsprite  -8,  24, $08, 1
	dbsprite -16,  24, $25, 1
	dbsprite -24,  24, $15, 1
	dbsprite  16,  16, $07, 0
	dbsprite  16,   8, $07, 0
	dbsprite  16,   0, $07, 0
	dbsprite  16,  -8, $07, 0
	dbsprite  16, -16, $32, 0
	dbsprite  16, -24, $31, 0
	dbsprite   8,   8, $34, 0
	dbsprite   8,   0, $34, 0
	dbsprite   8,  -8, $33, 0
	dbsprite   8, -16, $0f, 0
	dbsprite   8, -24, $30, 0
	dbsprite   0, -24, $20, 0
	dbsprite   8,  16, $27, 0
	dbsprite   0,  16, $17, 0
	dbsprite  -8,  16, $07, 0
	dbsprite -16,  16, $24, 1
	dbsprite -24,  16, $14, 1
	dbsprite   0,   8, $16, 0
	dbsprite  -8,   8, $06, 0
	dbsprite -16,   8, $23, 1
	dbsprite -24,   8, $13, 1
	dbsprite  -8,   0, $05, 0
	dbsprite -16,   0, $22, 0
	dbsprite -24,   0, $12, 1
	dbsprite -16,  -8, $21, 0
	dbsprite -24,  -8, $11, 0
	dbsprite -24, -16, $10, 0

.frame_6
	db 30 ; size
	dbsprite  16,  16, $3e, 2
	dbsprite  16,   8, $3d, 2
	dbsprite  16,   0, $3c, 2
	dbsprite  16,  -8, $3b, 2
	dbsprite   8,  16, $46, 2
	dbsprite   8,   8, $45, 2
	dbsprite   8,   0, $44, 2
	dbsprite   8,  -8, $43, 2
	dbsprite   0,   8, $3a, 2
	dbsprite   0,   0, $39, 2
	dbsprite   0,  -8, $38, 2
	dbsprite  -8,   8, $2b, 1 | OAM_XFLIP
	dbsprite  -8,  16, $2a, 1 | OAM_XFLIP
	dbsprite  -8,  24, $29, 1 | OAM_XFLIP
	dbsprite  -8,   0, $2b, 1
	dbsprite  -8,  -8, $2a, 1
	dbsprite  -8, -16, $29, 1
	dbsprite  -8, -24, $15, 1 | OAM_XFLIP
	dbsprite   0,  16, $07, 0
	dbsprite   0,  24, $37, 1 | OAM_XFLIP
	dbsprite   0, -16, $37, 1
	dbsprite   0, -24, $36, 1
	dbsprite   0, -32, $35, 0
	dbsprite   8,  24, $47, 0
	dbsprite  16,  24, $3f, 0
	dbsprite   8, -16, $42, 2
	dbsprite   8, -24, $41, 0
	dbsprite   8, -32, $40, 0
	dbsprite  16, -16, $32, 0
	dbsprite  16, -24, $31, 0

.frame_7
	db 30 ; size
	dbsprite  -8,   8, $2b, 1 | OAM_XFLIP
	dbsprite  -8,  16, $2a, 1 | OAM_XFLIP
	dbsprite  -8,  24, $29, 1 | OAM_XFLIP
	dbsprite  -8,   0, $2b, 1
	dbsprite  -8,  -8, $2a, 1
	dbsprite  -8, -16, $29, 1
	dbsprite  -8, -24, $15, 1 | OAM_XFLIP
	dbsprite   0,  16, $07, 0
	dbsprite   0,   8, $07, 0
	dbsprite   0,   0, $07, 0
	dbsprite   0,  -8, $07, 0
	dbsprite   0,  24, $37, 1 | OAM_XFLIP
	dbsprite   0, -16, $37, 1
	dbsprite   0, -24, $36, 1
	dbsprite   0, -32, $35, 0
	dbsprite   8,  24, $47, 0
	dbsprite  16,  24, $3f, 0
	dbsprite   8,  16, $2f, 0
	dbsprite   8,   8, $2e, 0
	dbsprite   8,   0, $2d, 0
	dbsprite   8,  -8, $2c, 0
	dbsprite   8, -16, $42, 0
	dbsprite   8, -24, $41, 0
	dbsprite   8, -32, $40, 0
	dbsprite  16,  16, $07, 0
	dbsprite  16,   8, $07, 0
	dbsprite  16,   0, $07, 0
	dbsprite  16,  -8, $07, 0
	dbsprite  16, -16, $32, 0
	dbsprite  16, -24, $31, 0

.frame_8
	db 24 ; size
	dbsprite  16,  24, $07, 0
	dbsprite   8,  24, $36, 1 | OAM_XFLIP
	dbsprite   0,  24, $15, 1
	dbsprite   0,   0, $2b, 1 | OAM_XFLIP
	dbsprite   0,   8, $2a, 1 | OAM_XFLIP
	dbsprite   0,  16, $29, 1 | OAM_XFLIP
	dbsprite   0,  -8, $2b, 1
	dbsprite   0, -16, $2a, 1
	dbsprite   0, -24, $29, 1
	dbsprite   0, -32, $15, 1 | OAM_XFLIP
	dbsprite   8,   8, $07, 0
	dbsprite   8,   0, $07, 0
	dbsprite   8,  -8, $07, 0
	dbsprite   8, -16, $07, 0
	dbsprite   8,  16, $37, 1 | OAM_XFLIP
	dbsprite   8, -24, $37, 1
	dbsprite   8, -32, $36, 1
	dbsprite  16,  16, $47, 0
	dbsprite  16,   8, $2f, 0
	dbsprite  16,   0, $2e, 0
	dbsprite  16,  -8, $2d, 0
	dbsprite  16, -16, $2c, 0
	dbsprite  16, -24, $42, 0
	dbsprite  16, -32, $41, 0

.frame_9
	db 15 ; size
	dbsprite  16,  24, $35, 0 | OAM_XFLIP
	dbsprite  16,  16, $36, 1 | OAM_XFLIP
	dbsprite   8,  16, $15, 1
	dbsprite   8,  -8, $2b, 1 | OAM_XFLIP
	dbsprite   8,   0, $2a, 1 | OAM_XFLIP
	dbsprite   8,   8, $29, 1 | OAM_XFLIP
	dbsprite   8, -16, $2b, 1
	dbsprite   8, -24, $2a, 1
	dbsprite   8, -32, $29, 1
	dbsprite  16,   0, $07, 0
	dbsprite  16,  -8, $07, 0
	dbsprite  16, -16, $07, 0
	dbsprite  16, -24, $07, 0
	dbsprite  16,   8, $37, 1 | OAM_XFLIP
	dbsprite  16, -32, $37, 1

.frame_10
	db 6 ; size
	dbsprite  16,   8, $15, 1
	dbsprite  16, -16, $2b, 1 | OAM_XFLIP
	dbsprite  16,  -8, $2a, 1 | OAM_XFLIP
	dbsprite  16,   0, $29, 1 | OAM_XFLIP
	dbsprite  16, -24, $2b, 1
	dbsprite  16, -32, $2a, 1

OAMData56::
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
	dbsprite -64, -24, $00, 0
	dbsprite -64, -16, $03, 0
	dbsprite -64,   0, $02, 0 | OAM_XFLIP
	dbsprite -64,   8, $01, 0 | OAM_XFLIP
	dbsprite -56, -16, $02, 0
	dbsprite -56, -24, $01, 0

.frame_1
	db 11 ; size
	dbsprite -56,   8, $00, 0 | OAM_XFLIP
	dbsprite -48, -24, $00, 0
	dbsprite -56, -24, $00, 0
	dbsprite -64,   8, $00, 0 | OAM_XFLIP
	dbsprite -64, -25, $00, 0
	dbsprite -56,   0, $03, 0 | OAM_XFLIP
	dbsprite -48, -16, $03, 0
	dbsprite -48,   8, $02, 0
	dbsprite -48,   0, $01, 0
	dbsprite -40, -16, $02, 0
	dbsprite -40, -24, $01, 0

.frame_2
	db 15 ; size
	dbsprite -40,  10, $00, 0 | OAM_XFLIP
	dbsprite -32, -23, $00, 0
	dbsprite -40, -24, $00, 0
	dbsprite -64,   9, $00, 0 | OAM_XFLIP
	dbsprite -64, -23, $00, 0
	dbsprite -56,   9, $00, 0 | OAM_XFLIP
	dbsprite -56, -23, $00, 0
	dbsprite -48,  10, $00, 0 | OAM_XFLIP
	dbsprite -48, -24, $00, 0
	dbsprite -40,   2, $03, 0 | OAM_XFLIP
	dbsprite -31, -15, $03, 0
	dbsprite -32,  10, $02, 0
	dbsprite -32,   2, $01, 0
	dbsprite -24, -15, $02, 0
	dbsprite -24, -23, $01, 0

.frame_3
	db 20 ; size
	dbsprite -28,  11, $00, 0 | OAM_XFLIP
	dbsprite -20,  10, $00, 0 | OAM_XFLIP
	dbsprite -16, -23, $00, 0
	dbsprite -24, -24, $00, 0
	dbsprite -18,   2, $03, 0 | OAM_XFLIP
	dbsprite -13, -15, $03, 0
	dbsprite -12,  10, $02, 0
	dbsprite -12,   2, $01, 0
	dbsprite  -8, -15, $02, 0
	dbsprite  -8, -23, $01, 0
	dbsprite -64,  12, $00, 0 | OAM_XFLIP
	dbsprite -64, -24, $00, 0
	dbsprite -56,  11, $00, 0 | OAM_XFLIP
	dbsprite -56, -23, $00, 0
	dbsprite -48,  10, $00, 0 | OAM_XFLIP
	dbsprite -48, -22, $00, 0
	dbsprite -40,  10, $00, 0 | OAM_XFLIP
	dbsprite -40, -22, $00, 0
	dbsprite -32,  11, $00, 0 | OAM_XFLIP
	dbsprite -32, -23, $00, 0

.frame_4
	db 22 ; size
	dbsprite   6,   7, $04, 0 | OAM_XFLIP
	dbsprite  14,   7, $05, 0 | OAM_XFLIP
	dbsprite  16, -20, $05, 0
	dbsprite   8, -20, $04, 0
	dbsprite -10,  11, $00, 0 | OAM_XFLIP
	dbsprite  -2,  10, $00, 0 | OAM_XFLIP
	dbsprite   0, -23, $00, 0
	dbsprite  -8, -24, $00, 0
	dbsprite -48,  12, $00, 0 | OAM_XFLIP
	dbsprite -48, -24, $00, 0
	dbsprite -40,  11, $00, 0 | OAM_XFLIP
	dbsprite -40, -23, $00, 0
	dbsprite -32,  10, $00, 0 | OAM_XFLIP
	dbsprite -32, -22, $00, 0
	dbsprite -24,  10, $00, 0 | OAM_XFLIP
	dbsprite -24, -22, $00, 0
	dbsprite -16,  11, $00, 0 | OAM_XFLIP
	dbsprite -16, -23, $00, 0
	dbsprite -64,  13, $00, 0 | OAM_XFLIP
	dbsprite -64, -22, $00, 0
	dbsprite -56,  13, $00, 0 | OAM_XFLIP
	dbsprite -56, -23, $00, 0

.frame_5
	db 24 ; size
	dbsprite  24,   7, $04, 0 | OAM_XFLIP
	dbsprite  24, -20, $04, 0
	dbsprite   8,  11, $00, 0 | OAM_XFLIP
	dbsprite  16,  10, $00, 0 | OAM_XFLIP
	dbsprite  16, -23, $00, 0
	dbsprite   8, -24, $00, 0
	dbsprite -32,  12, $00, 0 | OAM_XFLIP
	dbsprite -32, -24, $00, 0
	dbsprite -24,  11, $00, 0 | OAM_XFLIP
	dbsprite -24, -23, $00, 0
	dbsprite -16,  10, $00, 0 | OAM_XFLIP
	dbsprite -16, -22, $00, 0
	dbsprite  -8,  10, $00, 0 | OAM_XFLIP
	dbsprite  -8, -22, $00, 0
	dbsprite   0,  11, $00, 0 | OAM_XFLIP
	dbsprite   0, -23, $00, 0
	dbsprite -48,  13, $00, 0 | OAM_XFLIP
	dbsprite -48, -22, $00, 0
	dbsprite -40,  13, $00, 0 | OAM_XFLIP
	dbsprite -40, -23, $00, 0
	dbsprite -64,  12, $00, 0 | OAM_XFLIP
	dbsprite -64, -20, $00, 0
	dbsprite -56,  12, $00, 0 | OAM_XFLIP
	dbsprite -56, -21, $00, 0

.frame_6
	db 24 ; size
	dbsprite  24,  11, $00, 0 | OAM_XFLIP
	dbsprite  24, -24, $00, 0
	dbsprite  16,  11, $00, 0 | OAM_XFLIP
	dbsprite  16, -23, $00, 0
	dbsprite -64,  12, $00, 0
	dbsprite -64, -21, $00, 0
	dbsprite -56,  11, $00, 0
	dbsprite -56, -21, $00, 0
	dbsprite -48,  12, $00, 0
	dbsprite -48, -20, $00, 0
	dbsprite -40,  12, $00, 0
	dbsprite -40, -21, $00, 0
	dbsprite -32,  13, $00, 0
	dbsprite -32, -22, $00, 0
	dbsprite -24,  13, $00, 0
	dbsprite -24, -23, $00, 0
	dbsprite -16,  12, $00, 0
	dbsprite -16, -24, $00, 0
	dbsprite  -8,  11, $00, 0
	dbsprite  -8, -23, $00, 0
	dbsprite   0,  10, $00, 0
	dbsprite   0, -22, $00, 0
	dbsprite   8,  10, $00, 0
	dbsprite   8, -22, $00, 0

.frame_7
	db 34 ; size
	dbsprite  -8,   5, $07, 0 | OAM_XFLIP
	dbsprite -16,   5, $07, 0 | OAM_XFLIP
	dbsprite -24,   5, $07, 0 | OAM_XFLIP
	dbsprite -32,   5, $07, 0 | OAM_XFLIP
	dbsprite -40,   5, $07, 0 | OAM_XFLIP
	dbsprite  -8, -13, $07, 0
	dbsprite -16, -13, $07, 0
	dbsprite -24, -13, $07, 0
	dbsprite -32, -13, $07, 0
	dbsprite -40, -13, $07, 0
	dbsprite  24,  12, $06, 0
	dbsprite  16,  12, $06, 0
	dbsprite   8,  12, $06, 0
	dbsprite   0,  12, $06, 0
	dbsprite  -8,  12, $06, 0
	dbsprite -16,  12, $06, 0
	dbsprite -24,  12, $06, 0
	dbsprite -32,  12, $06, 0
	dbsprite -40,  12, $06, 0
	dbsprite -48,  12, $06, 0
	dbsprite -56,  12, $06, 0
	dbsprite -64,  12, $06, 0
	dbsprite  24, -20, $06, 0
	dbsprite  16, -20, $06, 0
	dbsprite   8, -20, $06, 0
	dbsprite   0, -20, $06, 0
	dbsprite  -8, -20, $06, 0
	dbsprite -16, -20, $06, 0
	dbsprite -24, -20, $06, 0
	dbsprite -32, -20, $06, 0
	dbsprite -40, -20, $06, 0
	dbsprite -48, -20, $06, 0
	dbsprite -56, -20, $06, 0
	dbsprite -64, -20, $06, 0

.frame_8
	db 34 ; size
	dbsprite  -8,  19, $07, 0
	dbsprite -16,  19, $07, 0
	dbsprite -24,  19, $07, 0
	dbsprite -32,  19, $07, 0
	dbsprite -40,  19, $07, 0
	dbsprite  -8, -27, $07, 0 | OAM_XFLIP
	dbsprite -16, -27, $07, 0 | OAM_XFLIP
	dbsprite -24, -27, $07, 0 | OAM_XFLIP
	dbsprite -32, -27, $07, 0 | OAM_XFLIP
	dbsprite -40, -27, $07, 0 | OAM_XFLIP
	dbsprite  24,  12, $06, 0
	dbsprite  16,  12, $06, 0
	dbsprite   8,  12, $06, 0
	dbsprite   0,  12, $06, 0
	dbsprite  -8,  12, $06, 0
	dbsprite -16,  12, $06, 0
	dbsprite -24,  12, $06, 0
	dbsprite -32,  12, $06, 0
	dbsprite -40,  12, $06, 0
	dbsprite -48,  12, $06, 0
	dbsprite -56,  12, $06, 0
	dbsprite -64,  12, $06, 0
	dbsprite  24, -20, $06, 0
	dbsprite  16, -20, $06, 0
	dbsprite   8, -20, $06, 0
	dbsprite   0, -20, $06, 0
	dbsprite  -8, -20, $06, 0
	dbsprite -16, -20, $06, 0
	dbsprite -24, -20, $06, 0
	dbsprite -32, -20, $06, 0
	dbsprite -40, -20, $06, 0
	dbsprite -48, -20, $06, 0
	dbsprite -56, -20, $06, 0
	dbsprite -64, -20, $06, 0

OAMData57::
	dw .frame_0
	dw .frame_1
	dw .frame_2
	dw .frame_3
	dw .frame_4
	dw .frame_5
	dw .frame_6

.frame_0
	db 9 ; size
	dbsprite -24,  24, $10, 0
	dbsprite   8,   0, $0f, 2
	dbsprite   8,  -8, $0e, 2
	dbsprite   8, -16, $0d, 2
	dbsprite   8, -24, $0c, 2
	dbsprite   0,   0, $07, 2
	dbsprite   0,  -8, $06, 1
	dbsprite   0, -16, $05, 2
	dbsprite   0, -24, $04, 2

.frame_1
	db 12 ; size
	dbsprite -16,  24, $11, 0
	dbsprite -16,  16, $10, 0
	dbsprite -24,  24, $09, 0
	dbsprite -24,  16, $08, 0
	dbsprite   8,   0, $0f, 2
	dbsprite   8,  -8, $0e, 2
	dbsprite   8, -16, $0d, 2
	dbsprite   8, -24, $0c, 2
	dbsprite   0,   0, $07, 2
	dbsprite   0,  -8, $06, 1
	dbsprite   0, -16, $05, 2
	dbsprite   0, -24, $04, 2

.frame_2
	db 14 ; size
	dbsprite -16,  24, $12, 0
	dbsprite -16,  16, $11, 0
	dbsprite -16,   8, $10, 0
	dbsprite -24,  24, $0a, 0
	dbsprite -24,  16, $09, 0
	dbsprite -24,   8, $08, 0
	dbsprite   8,   0, $0f, 2
	dbsprite   8,  -8, $0e, 2
	dbsprite   8, -16, $0d, 2
	dbsprite   8, -24, $0c, 2
	dbsprite   0,   0, $07, 2
	dbsprite   0,  -8, $06, 1
	dbsprite   0, -16, $05, 2
	dbsprite   0, -24, $04, 2

.frame_3
	db 16 ; size
	dbsprite -16,  24, $13, 0
	dbsprite -16,  16, $12, 0
	dbsprite -16,   8, $11, 0
	dbsprite -16,   0, $10, 0
	dbsprite -24,  24, $0b, 0
	dbsprite -24,  16, $0a, 0
	dbsprite -24,   8, $09, 0
	dbsprite -24,   0, $08, 0
	dbsprite   8,   0, $0f, 2
	dbsprite   8,  -8, $0e, 2
	dbsprite   8, -16, $0d, 2
	dbsprite   8, -24, $0c, 2
	dbsprite   0,   0, $07, 2
	dbsprite   0,  -8, $06, 1
	dbsprite   0, -16, $05, 2
	dbsprite   0, -24, $04, 2

.frame_4
	db 21 ; size
	dbsprite -24,  24, $14, 0
	dbsprite  -8,  16, $13, 0
	dbsprite  -8,   8, $12, 0
	dbsprite  -8,   0, $11, 0
	dbsprite  -8,  -8, $10, 0
	dbsprite -16,  16, $0b, 0
	dbsprite -16,   8, $0a, 0
	dbsprite -16,   0, $09, 0
	dbsprite -16,  -8, $08, 0
	dbsprite -24,  16, $03, 0
	dbsprite -24,   8, $02, 0
	dbsprite -24,   0, $01, 0
	dbsprite -24,  -8, $00, 0
	dbsprite   8,   0, $0f, 2
	dbsprite   8,  -8, $0e, 2
	dbsprite   8, -16, $0d, 2
	dbsprite   8, -24, $0c, 2
	dbsprite   0,   0, $07, 2
	dbsprite   0,  -8, $06, 1
	dbsprite   0, -16, $05, 2
	dbsprite   0, -24, $04, 2

.frame_5
	db 37 ; size
	dbsprite   0,  -8, $16, 1 | OAM_YFLIP
	dbsprite   0,   0, $16, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite  -8,   0, $16, 1 | OAM_XFLIP
	dbsprite -16,   0, $15, 1 | OAM_YFLIP
	dbsprite -16,   8, $15, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite  -8,   8, $15, 1 | OAM_XFLIP
	dbsprite   8,   8, $15, 1 | OAM_XFLIP
	dbsprite   8,  -8, $15, 1 | OAM_XFLIP
	dbsprite   8, -16, $15, 1
	dbsprite   0, -16, $15, 1 | OAM_YFLIP
	dbsprite   0,   8, $15, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite   8,   0, $15, 1
	dbsprite -16,  -8, $15, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite -16, -16, $15, 1 | OAM_YFLIP
	dbsprite  -8,  -8, $16, 1
	dbsprite  -8, -16, $15, 1
	dbsprite -24,  24, $14, 0
	dbsprite  -8,  16, $13, 0
	dbsprite  -8,   8, $12, 0
	dbsprite  -8,   0, $11, 0
	dbsprite  -8,  -8, $10, 0
	dbsprite -16,  16, $0b, 0
	dbsprite -16,   8, $0a, 0
	dbsprite -16,   0, $09, 0
	dbsprite -16,  -8, $08, 0
	dbsprite -24,  16, $03, 0
	dbsprite -24,   8, $02, 0
	dbsprite -24,   0, $01, 0
	dbsprite -24,  -8, $00, 0
	dbsprite   8,   0, $0f, 2
	dbsprite   8,  -8, $0e, 2
	dbsprite   8, -16, $0d, 2
	dbsprite   8, -24, $0c, 2
	dbsprite   0,   0, $07, 2
	dbsprite   0,  -8, $06, 1
	dbsprite   0, -16, $05, 2
	dbsprite   0, -24, $04, 2

.frame_6
	db 16 ; size
	dbsprite   0,  -8, $16, 1 | OAM_YFLIP
	dbsprite   0,   0, $16, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite  -8,   0, $16, 1 | OAM_XFLIP
	dbsprite -16,   0, $15, 1 | OAM_YFLIP
	dbsprite -16,   8, $15, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite  -8,   8, $15, 1 | OAM_XFLIP
	dbsprite   8,   8, $15, 1 | OAM_XFLIP
	dbsprite   8,  -8, $15, 1 | OAM_XFLIP
	dbsprite   8, -16, $15, 1
	dbsprite   0, -16, $15, 1 | OAM_YFLIP
	dbsprite   0,   8, $15, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite   8,   0, $15, 1
	dbsprite -16,  -8, $15, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite -16, -16, $15, 1 | OAM_YFLIP
	dbsprite  -8,  -8, $16, 1
	dbsprite  -8, -16, $15, 1

OAMData58::
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
	dbsprite  16,   0, $01, 0
	dbsprite  16,  -8, $00, 0

.frame_1
	db 4 ; size
	dbsprite  16,   0, $03, 0
	dbsprite  16,  -8, $02, 0
	dbsprite   8,   0, $01, 0
	dbsprite   8,  -8, $00, 0

.frame_2
	db 6 ; size
	dbsprite  16,   0, $05, 0
	dbsprite  16,  -8, $04, 0
	dbsprite   8,   0, $03, 0
	dbsprite   8,  -8, $02, 0
	dbsprite   0,   0, $01, 0
	dbsprite   0,  -8, $00, 0

.frame_3
	db 7 ; size
	dbsprite  16,  -2, $06, 0
	dbsprite   8,   0, $05, 0
	dbsprite   8,  -8, $04, 0
	dbsprite   0,   0, $03, 0
	dbsprite   0,  -8, $02, 0
	dbsprite  -8,   0, $01, 0
	dbsprite  -8,  -8, $00, 0

.frame_4
	db 8 ; size
	dbsprite  16,  -2, $0e, 0 | OAM_XFLIP
	dbsprite   8,  -8, $0d, 0 | OAM_XFLIP
	dbsprite   8,   0, $0c, 0 | OAM_XFLIP
	dbsprite   0,  -8, $0b, 0 | OAM_XFLIP
	dbsprite   0,   0, $0a, 0 | OAM_XFLIP
	dbsprite  -8,  -8, $09, 0 | OAM_XFLIP
	dbsprite  -8,   0, $08, 0 | OAM_XFLIP
	dbsprite -16,  -4, $07, 0 | OAM_XFLIP

.frame_5
	db 8 ; size
	dbsprite  16,  -6, $0e, 0
	dbsprite   8,   0, $0d, 0
	dbsprite   8,  -8, $0c, 0
	dbsprite   0,   0, $0b, 0
	dbsprite   0,  -8, $0a, 0
	dbsprite  -8,   0, $09, 0
	dbsprite  -8,  -8, $08, 0
	dbsprite -16,  -4, $07, 0

.frame_6
	db 18 ; size
	dbsprite  16,  -8, $0f, 0
	dbsprite   8,  -8, $17, 0
	dbsprite  10, -16, $16, 0
	dbsprite   0,  -8, $15, 0
	dbsprite   2, -16, $14, 0
	dbsprite  -8,  -8, $13, 0
	dbsprite  -6, -16, $12, 0
	dbsprite -16,  -8, $11, 0
	dbsprite -14, -16, $10, 0
	dbsprite  16,   0, $0f, 0 | OAM_XFLIP
	dbsprite   8,   0, $17, 0 | OAM_XFLIP
	dbsprite  10,   8, $16, 0 | OAM_XFLIP
	dbsprite   0,   0, $15, 0 | OAM_XFLIP
	dbsprite   2,   8, $14, 0 | OAM_XFLIP
	dbsprite  -8,   0, $13, 0 | OAM_XFLIP
	dbsprite  -6,   8, $12, 0 | OAM_XFLIP
	dbsprite -16,   0, $11, 0 | OAM_XFLIP
	dbsprite -14,   8, $10, 0 | OAM_XFLIP

.frame_7
	db 29 ; size
	dbsprite -16,  -4, $07, 0 | OAM_XFLIP
	dbsprite  16,  -8, $25, 0
	dbsprite  16, -16, $24, 0
	dbsprite  15, -24, $23, 0
	dbsprite   8,  -8, $22, 0
	dbsprite   8, -16, $21, 0
	dbsprite   7, -24, $20, 0
	dbsprite   0,  -8, $1f, 0
	dbsprite   0, -16, $1e, 0
	dbsprite  -1, -24, $1d, 0
	dbsprite  -8,  -8, $1c, 0
	dbsprite  -8, -16, $1b, 0
	dbsprite  -9, -24, $1a, 0
	dbsprite -16,  -8, $19, 0
	dbsprite -16, -16, $18, 0
	dbsprite  16,   0, $25, 0 | OAM_XFLIP
	dbsprite  16,   8, $24, 0 | OAM_XFLIP
	dbsprite  15,  16, $23, 0 | OAM_XFLIP
	dbsprite   8,   0, $22, 0 | OAM_XFLIP
	dbsprite   8,   8, $21, 0 | OAM_XFLIP
	dbsprite   7,  16, $20, 0 | OAM_XFLIP
	dbsprite   0,   0, $1f, 0 | OAM_XFLIP
	dbsprite   0,   8, $1e, 0 | OAM_XFLIP
	dbsprite  -1,  16, $1d, 0 | OAM_XFLIP
	dbsprite  -8,   0, $1c, 0 | OAM_XFLIP
	dbsprite  -8,   8, $1b, 0 | OAM_XFLIP
	dbsprite  -9,  16, $1a, 0 | OAM_XFLIP
	dbsprite -16,   0, $19, 0 | OAM_XFLIP
	dbsprite -16,   8, $18, 0 | OAM_XFLIP

.frame_8
	db 33 ; size
	dbsprite  16,  24, $45, 0
	dbsprite  12,   8, $44, 0
	dbsprite  16,   0, $43, 0
	dbsprite  16,  -8, $42, 0
	dbsprite  16, -16, $41, 0
	dbsprite  16, -32, $40, 0
	dbsprite   8,  24, $3f, 0
	dbsprite   8,  16, $3e, 0
	dbsprite   4,   8, $3d, 0
	dbsprite   8,   0, $3c, 0
	dbsprite   8,  -8, $3b, 0
	dbsprite   8, -16, $3a, 0
	dbsprite   9, -24, $39, 0
	dbsprite   8, -32, $38, 0
	dbsprite   0,  24, $37, 0
	dbsprite   0,  16, $36, 0
	dbsprite  -4,   8, $35, 0
	dbsprite   0,   0, $34, 0
	dbsprite   0,  -8, $33, 0
	dbsprite   0, -16, $32, 0
	dbsprite   1, -24, $31, 0
	dbsprite   0, -32, $30, 0
	dbsprite  -8,  24, $2f, 0
	dbsprite  -8,  16, $2e, 0
	dbsprite -12,   8, $2d, 0
	dbsprite  -8,   0, $2c, 0
	dbsprite  -8,  -8, $2b, 0
	dbsprite  -8, -16, $2a, 0
	dbsprite  -7, -24, $29, 0
	dbsprite  -8, -32, $28, 0
	dbsprite -16, -16, $27, 0
	dbsprite -15, -24, $26, 0
	dbsprite -16,  -4, $07, 0

.frame_9
	db 37 ; size
	dbsprite -17,   2, $46, 1
	dbsprite -16, -21, $46, 1
	dbsprite -13,  24, $46, 1
	dbsprite   0, -34, $46, 1
	dbsprite  16, -32, $45, 0 | OAM_XFLIP
	dbsprite  12, -16, $44, 0 | OAM_XFLIP
	dbsprite  16,  -8, $43, 0 | OAM_XFLIP
	dbsprite  16,   0, $42, 0 | OAM_XFLIP
	dbsprite  16,   8, $41, 0 | OAM_XFLIP
	dbsprite  16,  24, $40, 0 | OAM_XFLIP
	dbsprite   8, -32, $3f, 0 | OAM_XFLIP
	dbsprite   8, -24, $3e, 0 | OAM_XFLIP
	dbsprite   4, -16, $3d, 0 | OAM_XFLIP
	dbsprite   8,  -8, $3c, 0 | OAM_XFLIP
	dbsprite   8,   0, $3b, 0 | OAM_XFLIP
	dbsprite   8,   8, $3a, 0 | OAM_XFLIP
	dbsprite   9,  16, $39, 0 | OAM_XFLIP
	dbsprite   8,  24, $38, 0 | OAM_XFLIP
	dbsprite   0, -32, $37, 0 | OAM_XFLIP
	dbsprite   0, -24, $36, 0 | OAM_XFLIP
	dbsprite  -4, -16, $35, 0 | OAM_XFLIP
	dbsprite   0,  -8, $34, 0 | OAM_XFLIP
	dbsprite   0,   0, $33, 0 | OAM_XFLIP
	dbsprite   0,   8, $32, 0 | OAM_XFLIP
	dbsprite   1,  16, $31, 0 | OAM_XFLIP
	dbsprite   0,  24, $30, 0 | OAM_XFLIP
	dbsprite  -8, -32, $2f, 0 | OAM_XFLIP
	dbsprite  -8, -24, $2e, 0 | OAM_XFLIP
	dbsprite -12, -16, $2d, 0 | OAM_XFLIP
	dbsprite  -8,  -8, $2c, 0 | OAM_XFLIP
	dbsprite  -8,   0, $2b, 0 | OAM_XFLIP
	dbsprite  -8,   8, $2a, 0 | OAM_XFLIP
	dbsprite  -7,  16, $29, 0 | OAM_XFLIP
	dbsprite  -8,  24, $28, 0 | OAM_XFLIP
	dbsprite -16,   8, $27, 0 | OAM_XFLIP
	dbsprite -15,  16, $26, 0 | OAM_XFLIP
	dbsprite -16,  -4, $07, 0 | OAM_XFLIP

.frame_10
	db 40 ; size
	dbsprite -16,  16, $46, 1
	dbsprite -17,  -8, $46, 1
	dbsprite -10, -28, $46, 1
	dbsprite -20, -20, $47, 1
	dbsprite -24,   2, $47, 1 | OAM_XFLIP
	dbsprite -16,  26, $47, 1 | OAM_XFLIP
	dbsprite  -1, -34, $47, 1
	dbsprite  16,  24, $45, 0
	dbsprite  12,   8, $44, 0
	dbsprite  16,   0, $43, 0
	dbsprite  16,  -8, $42, 0
	dbsprite  16, -16, $41, 0
	dbsprite  16, -32, $40, 0
	dbsprite   8,  24, $3f, 0
	dbsprite   8,  16, $3e, 0
	dbsprite   4,   8, $3d, 0
	dbsprite   8,   0, $3c, 0
	dbsprite   8,  -8, $3b, 0
	dbsprite   8, -16, $3a, 0
	dbsprite   9, -24, $39, 0
	dbsprite   8, -32, $38, 0
	dbsprite   0,  24, $37, 0
	dbsprite   0,  16, $36, 0
	dbsprite  -4,   8, $35, 0
	dbsprite   0,   0, $34, 0
	dbsprite   0,  -8, $33, 0
	dbsprite   0, -16, $32, 0
	dbsprite   1, -24, $31, 0
	dbsprite   0, -32, $30, 0
	dbsprite  -8,  24, $2f, 0
	dbsprite  -8,  16, $2e, 0
	dbsprite -12,   8, $2d, 0
	dbsprite  -8,   0, $2c, 0
	dbsprite  -8,  -8, $2b, 0
	dbsprite  -8, -16, $2a, 0
	dbsprite  -7, -24, $29, 0
	dbsprite  -8, -32, $28, 0
	dbsprite -16, -16, $27, 0
	dbsprite -15, -24, $26, 0
	dbsprite -16,  -4, $07, 0

.frame_11
	db 40 ; size
	dbsprite -22,  18, $47, 1 | OAM_XFLIP
	dbsprite -24, -11, $47, 1
	dbsprite -16, -32, $47, 1
	dbsprite -17,   2, $46, 1
	dbsprite -16, -21, $46, 1
	dbsprite -13,  24, $46, 1
	dbsprite   0, -34, $46, 1
	dbsprite  16, -32, $45, 0 | OAM_XFLIP
	dbsprite  12, -16, $44, 0 | OAM_XFLIP
	dbsprite  16,  -8, $43, 0 | OAM_XFLIP
	dbsprite  16,   0, $42, 0 | OAM_XFLIP
	dbsprite  16,   8, $41, 0 | OAM_XFLIP
	dbsprite  16,  24, $40, 0 | OAM_XFLIP
	dbsprite   8, -32, $3f, 0 | OAM_XFLIP
	dbsprite   8, -24, $3e, 0 | OAM_XFLIP
	dbsprite   4, -16, $3d, 0 | OAM_XFLIP
	dbsprite   8,  -8, $3c, 0 | OAM_XFLIP
	dbsprite   8,   0, $3b, 0 | OAM_XFLIP
	dbsprite   8,   8, $3a, 0 | OAM_XFLIP
	dbsprite   9,  16, $39, 0 | OAM_XFLIP
	dbsprite   8,  24, $38, 0 | OAM_XFLIP
	dbsprite   0, -32, $37, 0 | OAM_XFLIP
	dbsprite   0, -24, $36, 0 | OAM_XFLIP
	dbsprite  -4, -16, $35, 0 | OAM_XFLIP
	dbsprite   0,  -8, $34, 0 | OAM_XFLIP
	dbsprite   0,   0, $33, 0 | OAM_XFLIP
	dbsprite   0,   8, $32, 0 | OAM_XFLIP
	dbsprite   1,  16, $31, 0 | OAM_XFLIP
	dbsprite   0,  24, $30, 0 | OAM_XFLIP
	dbsprite  -8, -32, $2f, 0 | OAM_XFLIP
	dbsprite  -8, -24, $2e, 0 | OAM_XFLIP
	dbsprite -12, -16, $2d, 0 | OAM_XFLIP
	dbsprite  -8,  -8, $2c, 0 | OAM_XFLIP
	dbsprite  -8,   0, $2b, 0 | OAM_XFLIP
	dbsprite  -8,   8, $2a, 0 | OAM_XFLIP
	dbsprite  -7,  16, $29, 0 | OAM_XFLIP
	dbsprite  -8,  24, $28, 0 | OAM_XFLIP
	dbsprite -16,   8, $27, 0 | OAM_XFLIP
	dbsprite -15,  16, $26, 0 | OAM_XFLIP
	dbsprite -16,  -4, $07, 0 | OAM_XFLIP

OAMData5A::
	dw .frame_0
	dw .frame_1
	dw .frame_2
	dw .frame_3
	dw .frame_4
	dw .frame_5

.frame_0
	db 6 ; size
	dbsprite  -8,  24, $05, 0
	dbsprite  -8,  16, $04, 0
	dbsprite  -8,   8, $03, 0
	dbsprite  -7,   0, $02, 0
	dbsprite -16,  23, $01, 0
	dbsprite -16,  15, $00, 0

.frame_1
	db 6 ; size
	dbsprite  -8,  24, $0b, 0
	dbsprite  -8,  16, $0a, 0
	dbsprite  -8,   8, $09, 0
	dbsprite  -7,   0, $08, 0
	dbsprite -16,  23, $07, 0
	dbsprite -16,  15, $06, 0

.frame_2
	db 4 ; size
	dbsprite   0,   0, $0f, 1
	dbsprite   0,  -8, $0e, 1
	dbsprite  -8,   0, $0d, 1
	dbsprite  -8,  -8, $0c, 1

.frame_3
	db 4 ; size
	dbsprite  -8,  -8, $0f, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite  -8,   0, $0e, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite   0,  -8, $0d, 1 | OAM_XFLIP | OAM_YFLIP
	dbsprite   0,   0, $0c, 1 | OAM_XFLIP | OAM_YFLIP

.frame_4
	db 6 ; size
	dbsprite -11,   0, $05, 0 | OAM_YFLIP
	dbsprite -11,  -8, $04, 0 | OAM_YFLIP
	dbsprite -11, -16, $03, 0 | OAM_YFLIP
	dbsprite -12, -24, $02, 0 | OAM_YFLIP
	dbsprite  -3,  -1, $01, 0 | OAM_YFLIP
	dbsprite  -3,  -9, $00, 0 | OAM_YFLIP

.frame_5
	db 6 ; size
	dbsprite -11,   0, $0b, 0 | OAM_YFLIP
	dbsprite -11,  -8, $0a, 0 | OAM_YFLIP
	dbsprite -11, -16, $09, 0 | OAM_YFLIP
	dbsprite -12, -24, $08, 0 | OAM_YFLIP
	dbsprite  -3,  -1, $07, 0 | OAM_YFLIP
	dbsprite  -3,  -9, $06, 0 | OAM_YFLIP

OAMData5B::
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
	dbsprite -21, -16, $01, 1
	dbsprite -25,  17, $03, 2 | OAM_XFLIP
	dbsprite  -8,   0, $00, 0
	dbsprite -16, -16, $02, 1
	dbsprite -26,  25, $03, 2
	dbsprite -17,  15, $00, 2
	dbsprite -18,  24, $00, 2

.frame_2
	db 8 ; size
	dbsprite  -8,   4, $02, 0 | OAM_YFLIP
	dbsprite -13, -22, $01, 1
	dbsprite -19,  21, $03, 2 | OAM_XFLIP
	dbsprite   0,   4, $00, 0
	dbsprite  -8, -22, $02, 1
	dbsprite -11,  19, $00, 2
	dbsprite -12,  28, $00, 2
	dbsprite -20,  29, $03, 2

.frame_3
	db 12 ; size
	dbsprite   5,   2, $02, 2 | OAM_YFLIP
	dbsprite  -5, -24, $01, 0
	dbsprite -12,  24, $03, 1 | OAM_XFLIP
	dbsprite  13,   2, $00, 2
	dbsprite   0, -24, $02, 0
	dbsprite  -4,  22, $00, 1
	dbsprite  -5,  31, $00, 1
	dbsprite -13,  32, $03, 1
	dbsprite -20,  -8, $07, 2
	dbsprite -28, -16, $05, 2
	dbsprite -28,  -8, $06, 2
	dbsprite -36,  -8, $04, 2

.frame_4
	db 12 ; size
	dbsprite  16,  -2, $02, 2 | OAM_YFLIP
	dbsprite  10, -22, $01, 0
	dbsprite   0,  19, $03, 1 | OAM_XFLIP
	dbsprite  24,  -2, $00, 2
	dbsprite  15, -22, $02, 0
	dbsprite  -1,  27, $03, 1
	dbsprite   7,  26, $00, 1
	dbsprite   8,  17, $00, 1
	dbsprite  -8,  -2, $07, 2
	dbsprite -16, -11, $05, 2
	dbsprite -16,  -3, $06, 2
	dbsprite -24,  -4, $04, 2

.frame_5
	db 10 ; size
	dbsprite  21, -16, $01, 2
	dbsprite  10,  14, $03, 0 | OAM_XFLIP
	dbsprite  26, -16, $02, 2
	dbsprite   9,  22, $03, 0
	dbsprite  18,  12, $00, 0
	dbsprite  17,  21, $00, 0
	dbsprite   0,  -8, $07, 1
	dbsprite  -8, -15, $05, 1
	dbsprite  -8,  -7, $06, 1
	dbsprite -16,  -6, $04, 1

.frame_6
	db 8 ; size
	dbsprite  18,  10, $03, 0 | OAM_XFLIP
	dbsprite  17,  18, $03, 0
	dbsprite  26,   8, $00, 0
	dbsprite  25,  17, $00, 0
	dbsprite  12, -11, $07, 1
	dbsprite   4, -19, $05, 1
	dbsprite   4, -11, $06, 1
	dbsprite  -4, -11, $04, 1

.frame_7
	db 4 ; size
	dbsprite  24, -15, $07, 0
	dbsprite  16, -23, $05, 0
	dbsprite  16, -15, $06, 0
	dbsprite   8, -15, $04, 0

OAMData5C::
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
	dw .frame_39
	dw .frame_40
	dw .frame_41
	dw .frame_42

.frame_0
	db 8 ; size
	dbsprite -16, -24, $00, 0
	dbsprite -16, -16, $01, 0
	dbsprite  -8, -24, $02, 0
	dbsprite  -8, -16, $02, 0 | OAM_XFLIP
	dbsprite -48,   8, $00, 0
	dbsprite -48,  16, $01, 0
	dbsprite -40,   8, $02, 0
	dbsprite -40,  16, $02, 0 | OAM_XFLIP

.frame_1
	db 8 ; size
	dbsprite -14, -24, $00, 0
	dbsprite -14, -16, $01, 0
	dbsprite -46,   8, $00, 0
	dbsprite -46,  16, $01, 0
	dbsprite -38,   8, $03, 0
	dbsprite -38,  16, $03, 0 | OAM_XFLIP
	dbsprite  -6, -24, $03, 0
	dbsprite  -6, -16, $03, 0 | OAM_XFLIP

.frame_2
	db 8 ; size
	dbsprite -14,  -8, $00, 0
	dbsprite -14,   0, $01, 0
	dbsprite -46,  -8, $00, 0
	dbsprite -46,   0, $01, 0
	dbsprite -38,  -8, $03, 0
	dbsprite -38,   0, $03, 0 | OAM_XFLIP
	dbsprite  -6,  -8, $03, 0
	dbsprite  -6,   0, $03, 0 | OAM_XFLIP

.frame_3
	db 8 ; size
	dbsprite -22,   8, $00, 0
	dbsprite -22,  16, $01, 0
	dbsprite -38, -24, $00, 0
	dbsprite -38, -16, $01, 0
	dbsprite -30, -24, $03, 0
	dbsprite -30, -16, $03, 0 | OAM_XFLIP
	dbsprite -14,   8, $03, 0
	dbsprite -14,  16, $03, 0 | OAM_XFLIP

.frame_4
	db 8 ; size
	dbsprite -30,   8, $00, 0
	dbsprite -30,  16, $01, 0
	dbsprite -30, -24, $00, 0
	dbsprite -30, -16, $01, 0
	dbsprite -22, -24, $03, 0
	dbsprite -22, -16, $03, 0 | OAM_XFLIP
	dbsprite -22,   8, $03, 0
	dbsprite -22,  16, $03, 0 | OAM_XFLIP

.frame_5
	db 8 ; size
	dbsprite -38,   8, $00, 0
	dbsprite -38,  16, $01, 0
	dbsprite -22, -24, $00, 0
	dbsprite -22, -16, $01, 0
	dbsprite -14, -24, $03, 0
	dbsprite -14, -16, $03, 0 | OAM_XFLIP
	dbsprite -30,   8, $03, 0
	dbsprite -30,  16, $03, 0 | OAM_XFLIP

.frame_6
	db 8 ; size
	dbsprite -48,   8, $00, 0
	dbsprite -48,  16, $01, 0
	dbsprite -40,   8, $02, 0
	dbsprite -40,  16, $02, 0 | OAM_XFLIP
	dbsprite -14, -24, $00, 0
	dbsprite -14, -16, $01, 0
	dbsprite  -6, -24, $03, 0
	dbsprite  -6, -16, $03, 0 | OAM_XFLIP

.frame_7
	db 10 ; size
	dbsprite -48,   8, $00, 0
	dbsprite -48,  16, $01, 0
	dbsprite -40,   8, $02, 0
	dbsprite -40,  16, $02, 0 | OAM_XFLIP
	dbsprite -15, -24, $00, 0
	dbsprite -15, -16, $01, 0
	dbsprite  -7, -24, $03, 0
	dbsprite  -7, -16, $03, 0 | OAM_XFLIP
	dbsprite  -2, -24, $03, 0
	dbsprite  -2, -16, $03, 0 | OAM_XFLIP

.frame_8
	db 10 ; size
	dbsprite -48,   8, $00, 0
	dbsprite -48,  16, $01, 0
	dbsprite -40,   8, $02, 0
	dbsprite -40,  16, $02, 0 | OAM_XFLIP
	dbsprite -16, -24, $00, 0
	dbsprite -16, -16, $01, 0
	dbsprite  -8, -24, $03, 0
	dbsprite  -8, -16, $03, 0 | OAM_XFLIP
	dbsprite  -3, -24, $04, 0
	dbsprite  -3, -16, $01, 0 | OAM_YFLIP

.frame_9
	db 12 ; size
	dbsprite -48,   8, $00, 0
	dbsprite -48,  16, $01, 0
	dbsprite -40,   8, $02, 0
	dbsprite -40,  16, $02, 0 | OAM_XFLIP
	dbsprite -17, -24, $00, 0
	dbsprite -17, -16, $01, 0
	dbsprite  -9, -24, $03, 0
	dbsprite  -9, -16, $03, 0 | OAM_XFLIP
	dbsprite  -4, -24, $00, 0
	dbsprite  -4, -16, $01, 0
	dbsprite   4, -24, $03, 0
	dbsprite   4, -16, $03, 0 | OAM_XFLIP

.frame_10
	db 10 ; size
	dbsprite -48,   8, $00, 0
	dbsprite -48,  16, $01, 0
	dbsprite -40,   8, $02, 0
	dbsprite -40,  16, $02, 0 | OAM_XFLIP
	dbsprite -16, -24, $00, 0
	dbsprite -16, -16, $01, 0
	dbsprite  -7, -24, $00, 0
	dbsprite  -7, -16, $01, 0
	dbsprite   1, -24, $03, 0
	dbsprite   1, -16, $03, 0 | OAM_XFLIP

.frame_11
	db 10 ; size
	dbsprite -48,   8, $00, 0
	dbsprite -48,  16, $01, 0
	dbsprite -40,   8, $02, 0
	dbsprite -40,  16, $02, 0 | OAM_XFLIP
	dbsprite -10, -24, $00, 0
	dbsprite -10, -16, $01, 0
	dbsprite  -2, -24, $03, 0
	dbsprite  -2, -16, $03, 0 | OAM_XFLIP
	dbsprite -19, -24, $03, 0 | OAM_YFLIP
	dbsprite -19, -16, $03, 0 | OAM_XFLIP | OAM_YFLIP

.frame_12
	db 8 ; size
	dbsprite -16, -24, $00, 0
	dbsprite -16, -16, $01, 0
	dbsprite  -8, -24, $02, 0
	dbsprite  -8, -16, $02, 0 | OAM_XFLIP
	dbsprite -46,   8, $00, 0
	dbsprite -46,  16, $01, 0
	dbsprite -38,   8, $03, 0
	dbsprite -38,  16, $03, 0 | OAM_XFLIP

.frame_13
	db 10 ; size
	dbsprite -16, -24, $00, 0
	dbsprite -16, -16, $01, 0
	dbsprite  -8, -24, $02, 0
	dbsprite  -8, -16, $02, 0 | OAM_XFLIP
	dbsprite -45,   8, $00, 0
	dbsprite -45,  16, $01, 0
	dbsprite -37,   8, $03, 0
	dbsprite -37,  16, $03, 0 | OAM_XFLIP
	dbsprite -54,   8, $03, 0 | OAM_YFLIP
	dbsprite -54,  16, $03, 0 | OAM_XFLIP | OAM_YFLIP

.frame_14
	db 10 ; size
	dbsprite -16, -24, $00, 0
	dbsprite -16, -16, $01, 0
	dbsprite  -8, -24, $02, 0
	dbsprite  -8, -16, $02, 0 | OAM_XFLIP
	dbsprite -44,   8, $00, 0
	dbsprite -44,  16, $01, 0
	dbsprite -36,   8, $03, 0
	dbsprite -36,  16, $03, 0 | OAM_XFLIP
	dbsprite -53,   8, $00, 0
	dbsprite -53,  16, $01, 0

.frame_15
	db 12 ; size
	dbsprite -16, -24, $00, 0
	dbsprite -16, -16, $01, 0
	dbsprite  -8, -24, $02, 0
	dbsprite  -8, -16, $02, 0 | OAM_XFLIP
	dbsprite -43,   8, $00, 0
	dbsprite -43,  16, $01, 0
	dbsprite -35,   8, $03, 0
	dbsprite -35,  16, $03, 0 | OAM_XFLIP
	dbsprite -56,   8, $00, 0
	dbsprite -56,  16, $01, 0
	dbsprite -48,   8, $03, 0
	dbsprite -48,  16, $03, 0 | OAM_XFLIP

.frame_16
	db 10 ; size
	dbsprite -16, -24, $00, 0
	dbsprite -16, -16, $01, 0
	dbsprite  -8, -24, $02, 0
	dbsprite  -8, -16, $02, 0 | OAM_XFLIP
	dbsprite -40,  16, $01, 0 | OAM_YFLIP
	dbsprite -53,   8, $00, 0
	dbsprite -53,  16, $01, 0
	dbsprite -45,   8, $03, 0
	dbsprite -45,  16, $03, 0 | OAM_XFLIP
	dbsprite -40,   8, $04, 0

.frame_17
	db 10 ; size
	dbsprite -16, -24, $00, 0
	dbsprite -16, -16, $01, 0
	dbsprite  -8, -24, $02, 0
	dbsprite  -8, -16, $02, 0 | OAM_XFLIP
	dbsprite -50,   8, $00, 0
	dbsprite -50,  16, $01, 0
	dbsprite -42,   8, $03, 0
	dbsprite -42,  16, $03, 0 | OAM_XFLIP
	dbsprite -37,   8, $03, 0
	dbsprite -37,  16, $03, 0 | OAM_XFLIP

.frame_18
	db 12 ; size
	dbsprite -15, -24, $00, 0
	dbsprite -15, -16, $01, 0
	dbsprite  -7, -24, $03, 0
	dbsprite  -7, -16, $03, 0 | OAM_XFLIP
	dbsprite  -2, -24, $03, 0
	dbsprite  -2, -16, $03, 0 | OAM_XFLIP
	dbsprite -45,   8, $00, 0
	dbsprite -45,  16, $01, 0
	dbsprite -37,   8, $03, 0
	dbsprite -37,  16, $03, 0 | OAM_XFLIP
	dbsprite -54,   8, $03, 0 | OAM_YFLIP
	dbsprite -54,  16, $03, 0 | OAM_XFLIP | OAM_YFLIP

.frame_19
	db 12 ; size
	dbsprite -16, -24, $00, 0
	dbsprite -16, -16, $01, 0
	dbsprite  -8, -24, $03, 0
	dbsprite  -8, -16, $03, 0 | OAM_XFLIP
	dbsprite  -3, -24, $04, 0
	dbsprite  -3, -16, $01, 0 | OAM_YFLIP
	dbsprite -44,   8, $00, 0
	dbsprite -44,  16, $01, 0
	dbsprite -36,   8, $03, 0
	dbsprite -36,  16, $03, 0 | OAM_XFLIP
	dbsprite -53,   8, $00, 0
	dbsprite -53,  16, $01, 0

.frame_20
	db 16 ; size
	dbsprite -17, -24, $00, 0
	dbsprite -17, -16, $01, 0
	dbsprite  -9, -24, $03, 0
	dbsprite  -9, -16, $03, 0 | OAM_XFLIP
	dbsprite  -4, -24, $00, 0
	dbsprite  -4, -16, $01, 0
	dbsprite   4, -24, $03, 0
	dbsprite   4, -16, $03, 0 | OAM_XFLIP
	dbsprite -43,   8, $00, 0
	dbsprite -43,  16, $01, 0
	dbsprite -35,   8, $03, 0
	dbsprite -35,  16, $03, 0 | OAM_XFLIP
	dbsprite -56,   8, $00, 0
	dbsprite -56,  16, $01, 0
	dbsprite -48,   8, $03, 0
	dbsprite -48,  16, $03, 0 | OAM_XFLIP

.frame_21
	db 12 ; size
	dbsprite -16, -24, $00, 0
	dbsprite -16, -16, $01, 0
	dbsprite  -7, -24, $00, 0
	dbsprite  -7, -16, $01, 0
	dbsprite   1, -24, $03, 0
	dbsprite   1, -16, $03, 0 | OAM_XFLIP
	dbsprite -40,  16, $01, 0 | OAM_YFLIP
	dbsprite -53,   8, $00, 0
	dbsprite -53,  16, $01, 0
	dbsprite -45,   8, $03, 0
	dbsprite -45,  16, $03, 0 | OAM_XFLIP
	dbsprite -40,   8, $04, 0

.frame_22
	db 12 ; size
	dbsprite -10, -24, $00, 0
	dbsprite -10, -16, $01, 0
	dbsprite  -2, -24, $03, 0
	dbsprite  -2, -16, $03, 0 | OAM_XFLIP
	dbsprite -19, -24, $03, 0 | OAM_YFLIP
	dbsprite -19, -16, $03, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite -50,   8, $00, 0
	dbsprite -50,  16, $01, 0
	dbsprite -42,   8, $03, 0
	dbsprite -42,  16, $03, 0 | OAM_XFLIP
	dbsprite -37,   8, $03, 0
	dbsprite -37,  16, $03, 0 | OAM_XFLIP

.frame_23
	db 8 ; size
	dbsprite  -8, -24, $00, 0
	dbsprite  -8, -16, $01, 0
	dbsprite   0, -24, $02, 0
	dbsprite   0, -16, $02, 0 | OAM_XFLIP
	dbsprite -56,  -4, $00, 0
	dbsprite -56,   4, $01, 0
	dbsprite -48,  -4, $02, 0
	dbsprite -48,   4, $02, 0 | OAM_XFLIP

.frame_24
	db 8 ; size
	dbsprite   0, -24, $00, 0
	dbsprite   0, -16, $01, 0
	dbsprite   8, -24, $02, 0
	dbsprite   8, -16, $02, 0 | OAM_XFLIP
	dbsprite -56, -16, $00, 0
	dbsprite -56,  -8, $01, 0
	dbsprite -48, -16, $02, 0
	dbsprite -48,  -8, $02, 0 | OAM_XFLIP

.frame_25
	db 8 ; size
	dbsprite  -1, -20, $00, 0
	dbsprite  -1, -12, $01, 0
	dbsprite -57, -20, $00, 0
	dbsprite -57, -12, $01, 0
	dbsprite -49, -20, $03, 0
	dbsprite -49, -12, $03, 0 | OAM_XFLIP
	dbsprite   7, -20, $03, 0
	dbsprite   7, -12, $03, 0 | OAM_XFLIP

.frame_26
	db 8 ; size
	dbsprite  -3, -12, $00, 0
	dbsprite  -3,  -4, $01, 0
	dbsprite -59, -28, $00, 0
	dbsprite -59, -20, $01, 0
	dbsprite -51, -28, $03, 0
	dbsprite -51, -20, $03, 0 | OAM_XFLIP
	dbsprite   5, -12, $03, 0
	dbsprite   5,  -4, $03, 0 | OAM_XFLIP

.frame_27
	db 8 ; size
	dbsprite  -4,  -4, $00, 0
	dbsprite  -4,   4, $01, 0
	dbsprite -60, -36, $00, 0
	dbsprite -60, -28, $01, 0
	dbsprite -52, -36, $03, 0
	dbsprite -52, -28, $03, 0 | OAM_XFLIP
	dbsprite   4,  -4, $03, 0
	dbsprite   4,   4, $03, 0 | OAM_XFLIP

.frame_28
	db 8 ; size
	dbsprite  -4,   4, $00, 0
	dbsprite  -4,  12, $01, 0
	dbsprite -60, -44, $00, 0
	dbsprite -60, -36, $01, 0
	dbsprite -52, -44, $03, 0
	dbsprite -52, -36, $03, 0 | OAM_XFLIP
	dbsprite   4,   4, $03, 0
	dbsprite   4,  12, $03, 0 | OAM_XFLIP

.frame_29
	db 8 ; size
	dbsprite  -3,  12, $00, 0
	dbsprite  -3,  20, $01, 0
	dbsprite -59, -52, $00, 0
	dbsprite -59, -44, $01, 0
	dbsprite -51, -52, $03, 0
	dbsprite -51, -44, $03, 0 | OAM_XFLIP
	dbsprite   5,  12, $03, 0
	dbsprite   5,  20, $03, 0 | OAM_XFLIP

.frame_30
	db 8 ; size
	dbsprite  -1,  20, $00, 0
	dbsprite  -1,  28, $01, 0
	dbsprite -57, -60, $00, 0
	dbsprite -57, -52, $01, 0
	dbsprite -49, -60, $03, 0
	dbsprite -49, -52, $03, 0 | OAM_XFLIP
	dbsprite   7,  20, $03, 0
	dbsprite   7,  28, $03, 0 | OAM_XFLIP

.frame_31
	db 4 ; size
	dbsprite  -1, -20, $00, 0
	dbsprite  -1, -12, $01, 0
	dbsprite   7, -20, $03, 0
	dbsprite   7, -12, $03, 0 | OAM_XFLIP

.frame_32
	db 4 ; size
	dbsprite  -3, -12, $00, 0
	dbsprite  -3,  -4, $01, 0
	dbsprite   5, -12, $03, 0
	dbsprite   5,  -4, $03, 0 | OAM_XFLIP

.frame_33
	db 4 ; size
	dbsprite  -4,  -4, $00, 0
	dbsprite  -4,   4, $01, 0
	dbsprite   4,  -4, $03, 0
	dbsprite   4,   4, $03, 0 | OAM_XFLIP

.frame_34
	db 4 ; size
	dbsprite  -4,   4, $00, 0
	dbsprite  -4,  12, $01, 0
	dbsprite   4,   4, $03, 0
	dbsprite   4,  12, $03, 0 | OAM_XFLIP

.frame_35
	db 4 ; size
	dbsprite  -3,  12, $00, 0
	dbsprite  -3,  20, $01, 0
	dbsprite   5,  12, $03, 0
	dbsprite   5,  20, $03, 0 | OAM_XFLIP

.frame_36
	db 4 ; size
	dbsprite  -1,  20, $00, 0
	dbsprite  -1,  28, $01, 0
	dbsprite   7,  20, $03, 0
	dbsprite   7,  28, $03, 0 | OAM_XFLIP

.frame_37
	db 4 ; size
	dbsprite -57, -20, $00, 0
	dbsprite -57, -12, $01, 0
	dbsprite -49, -20, $03, 0
	dbsprite -49, -12, $03, 0 | OAM_XFLIP

.frame_38
	db 4 ; size
	dbsprite -59, -28, $00, 0
	dbsprite -59, -20, $01, 0
	dbsprite -51, -28, $03, 0
	dbsprite -51, -20, $03, 0 | OAM_XFLIP

.frame_39
	db 4 ; size
	dbsprite -60, -36, $00, 0
	dbsprite -60, -28, $01, 0
	dbsprite -52, -36, $03, 0
	dbsprite -52, -28, $03, 0 | OAM_XFLIP

.frame_40
	db 4 ; size
	dbsprite -60, -44, $00, 0
	dbsprite -60, -36, $01, 0
	dbsprite -52, -44, $03, 0
	dbsprite -52, -36, $03, 0 | OAM_XFLIP

.frame_41
	db 4 ; size
	dbsprite -59, -52, $00, 0
	dbsprite -59, -44, $01, 0
	dbsprite -51, -52, $03, 0
	dbsprite -51, -44, $03, 0 | OAM_XFLIP

.frame_42
	db 4 ; size
	dbsprite -57, -60, $00, 0
	dbsprite -57, -52, $01, 0
	dbsprite -49, -60, $03, 0
	dbsprite -49, -52, $03, 0 | OAM_XFLIP

OAMData5D::
	dw .frame_0
	dw .frame_1
	dw .frame_2
	dw .frame_3
	dw .frame_4
	dw .frame_5
	dw .frame_6

.frame_0
	db 9 ; size
	dbsprite -12, -12, $00, 0
	dbsprite -12,  -4, $01, 0
	dbsprite -12,   4, $02, 0
	dbsprite  -4, -12, $03, 0
	dbsprite  -4,  -4, $04, 0
	dbsprite  -4,   4, $05, 0
	dbsprite   4, -12, $06, 0
	dbsprite   4,  -4, $07, 0
	dbsprite   4,   4, $08, 0

.frame_1
	db 6 ; size
	dbsprite  -8, -12, $11, 0
	dbsprite  -8,  -4, $12, 0
	dbsprite  -8,   4, $11, 0 | OAM_XFLIP
	dbsprite   0, -12, $13, 0
	dbsprite   0,  -4, $14, 0
	dbsprite   0,   4, $13, 0 | OAM_XFLIP

.frame_2
	db 3 ; size
	dbsprite  -4, -12, $15, 0
	dbsprite  -4,  -4, $16, 0
	dbsprite  -4,   4, $15, 0 | OAM_XFLIP

.frame_3
	db 6 ; size
	dbsprite  -8, -12, $0d, 0
	dbsprite  -8,  -4, $0e, 0
	dbsprite  -8,   4, $0d, 0 | OAM_XFLIP
	dbsprite   0, -12, $0f, 0
	dbsprite   0,  -4, $10, 0
	dbsprite   0,   4, $0f, 0 | OAM_XFLIP

.frame_4
	db 9 ; size
	dbsprite -12, -12, $09, 0
	dbsprite -12,  -4, $0a, 0
	dbsprite -12,   4, $09, 0 | OAM_XFLIP
	dbsprite  -4, -12, $0b, 0
	dbsprite  -4,  -4, $0c, 0
	dbsprite  -4,   4, $0b, 0 | OAM_XFLIP
	dbsprite   4, -12, $09, 0 | OAM_YFLIP
	dbsprite   4,  -4, $0a, 0 | OAM_YFLIP
	dbsprite   4,   4, $09, 0 | OAM_XFLIP | OAM_YFLIP

.frame_5
	db 6 ; size
	dbsprite   0, -12, $0d, 0 | OAM_YFLIP
	dbsprite   0,  -4, $0e, 0 | OAM_YFLIP
	dbsprite   0,   4, $0d, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite  -8, -12, $0f, 0 | OAM_YFLIP
	dbsprite  -8,  -4, $10, 0 | OAM_YFLIP
	dbsprite  -8,   4, $0f, 0 | OAM_XFLIP | OAM_YFLIP

.frame_6
	db 6 ; size
	dbsprite   0, -12, $11, 0 | OAM_YFLIP
	dbsprite   0,  -4, $12, 0 | OAM_YFLIP
	dbsprite   0,   4, $11, 0 | OAM_XFLIP | OAM_YFLIP
	dbsprite  -8, -12, $13, 0 | OAM_YFLIP
	dbsprite  -8,  -4, $14, 0 | OAM_YFLIP
	dbsprite  -8,   4, $13, 0 | OAM_XFLIP | OAM_YFLIP

OAMData5E::
	dw .frame_0
	dw .frame_1
	dw .frame_2

.frame_0
	db 40 ; size
	dbsprite -56,  32, $00, 0
	dbsprite -56,  40, $01, 0
	dbsprite -56,  48, $02, 0
	dbsprite -56,  56, $03, 0
	dbsprite -48,  64, $09, 0
	dbsprite -48,  56, $13, 0
	dbsprite -48,  48, $12, 0
	dbsprite -48,  40, $11, 0
	dbsprite -48,  32, $10, 0
	dbsprite -48,  24, $08, 0
	dbsprite -40,  24, $18, 0
	dbsprite -32,  32, $30, 0
	dbsprite -40,  32, $20, 0
	dbsprite -40,  40, $21, 0
	dbsprite -32,  40, $31, 0
	dbsprite -32,  48, $32, 0
	dbsprite -32,  56, $33, 0
	dbsprite -40,  64, $19, 0
	dbsprite -40,  48, $22, 0
	dbsprite -40,  56, $23, 0
	dbsprite -16, -40, $09, 0
	dbsprite -16, -80, $08, 0
	dbsprite  -8, -80, $18, 0
	dbsprite  -8, -40, $19, 0
	dbsprite -24, -72, $04, 0
	dbsprite -16, -72, $14, 0
	dbsprite  -8, -72, $24, 0
	dbsprite -24, -64, $05, 0
	dbsprite -16, -64, $15, 0
	dbsprite  -8, -64, $25, 0
	dbsprite   0, -64, $35, 0
	dbsprite   0, -72, $34, 0
	dbsprite   0, -56, $28, 0
	dbsprite  -8, -56, $26, 0
	dbsprite -16, -56, $16, 0
	dbsprite -24, -56, $06, 0
	dbsprite -24, -48, $07, 0
	dbsprite -16, -48, $17, 0
	dbsprite  -8, -48, $27, 0
	dbsprite   0, -48, $29, 0

.frame_1
	db 40 ; size
	dbsprite -48,  64, $09, 0
	dbsprite -48,  24, $08, 0
	dbsprite -40,  24, $18, 0
	dbsprite -40,  64, $19, 0
	dbsprite -56,  32, $04, 0
	dbsprite -48,  32, $14, 0
	dbsprite -40,  32, $24, 0
	dbsprite -56,  40, $05, 0
	dbsprite -48,  40, $15, 0
	dbsprite -40,  40, $25, 0
	dbsprite -32,  40, $35, 0
	dbsprite -32,  32, $34, 0
	dbsprite -32,  48, $28, 0
	dbsprite -40,  48, $26, 0
	dbsprite -48,  48, $16, 0
	dbsprite -56,  48, $06, 0
	dbsprite -56,  56, $07, 0
	dbsprite -48,  56, $17, 0
	dbsprite -40,  56, $27, 0
	dbsprite -32,  56, $29, 0
	dbsprite -24, -72, $00, 0
	dbsprite -24, -64, $01, 0
	dbsprite -24, -56, $02, 0
	dbsprite -24, -48, $03, 0
	dbsprite -16, -40, $09, 0
	dbsprite -16, -48, $13, 0
	dbsprite -16, -56, $12, 0
	dbsprite -16, -64, $11, 0
	dbsprite -16, -72, $10, 0
	dbsprite -16, -80, $08, 0
	dbsprite  -8, -80, $18, 0
	dbsprite   0, -72, $30, 0
	dbsprite  -8, -72, $20, 0
	dbsprite  -8, -64, $21, 0
	dbsprite   0, -64, $31, 0
	dbsprite   0, -56, $32, 0
	dbsprite   0, -48, $33, 0
	dbsprite  -8, -40, $19, 0
	dbsprite  -8, -56, $22, 0
	dbsprite  -8, -48, $23, 0

.frame_2
	db 36 ; size
	dbsprite -52,  24, $0a, 0
	dbsprite -44,  24, $1a, 0
	dbsprite -36,  24, $2a, 0
	dbsprite -52,  32, $0b, 0
	dbsprite -44,  32, $1b, 0
	dbsprite -36,  32, $2b, 0
	dbsprite -52,  40, $0c, 0
	dbsprite -44,  40, $1c, 0
	dbsprite -36,  40, $2c, 0
	dbsprite -52,  48, $0d, 0
	dbsprite -44,  56, $1e, 0
	dbsprite -44,  48, $1d, 0
	dbsprite -36,  48, $2d, 0
	dbsprite -36,  56, $2e, 0
	dbsprite -52,  56, $0e, 0
	dbsprite -52,  64, $0f, 0
	dbsprite -44,  64, $1f, 0
	dbsprite -36,  64, $2f, 0
	dbsprite -20, -80, $0a, 0
	dbsprite -12, -80, $1a, 0
	dbsprite  -4, -80, $2a, 0
	dbsprite -20, -72, $0b, 0
	dbsprite -12, -72, $1b, 0
	dbsprite  -4, -72, $2b, 0
	dbsprite -20, -64, $0c, 0
	dbsprite -12, -64, $1c, 0
	dbsprite  -4, -64, $2c, 0
	dbsprite -20, -56, $0d, 0
	dbsprite -12, -48, $1e, 0
	dbsprite -12, -56, $1d, 0
	dbsprite  -4, -56, $2d, 0
	dbsprite  -4, -48, $2e, 0
	dbsprite -20, -48, $0e, 0
	dbsprite -20, -40, $0f, 0
	dbsprite -12, -40, $1f, 0
	dbsprite  -4, -40, $2f, 0

OAMData5F::
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
	dbsprite   0,   0, $00, 0
	dbsprite   8,   0, $01, 0
	dbsprite   0,   8, $00, 0 | OAM_XFLIP
	dbsprite   8,   8, $01, 0 | OAM_XFLIP

.frame_7
	db 4 ; size
	dbsprite   0,   0, $03, 0 | OAM_XFLIP
	dbsprite   8,   0, $05, 0 | OAM_XFLIP
	dbsprite   0,   8, $02, 0 | OAM_XFLIP
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

OAMData60::
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
	dbsprite   0,   0, $08, 1
	dbsprite   0,   8, $09, 1
	dbsprite   8,   0, $0a, 1
	dbsprite   8,   8, $0b, 1

.frame_1
	db 4 ; size
	dbsprite   0,   0, $06, 1
	dbsprite   8,   0, $07, 1
	dbsprite   8,   8, $07, 1 | OAM_XFLIP
	dbsprite   0,   8, $06, 1 | OAM_XFLIP

.frame_2
	db 4 ; size
	dbsprite   0,   0, $09, 1 | OAM_XFLIP
	dbsprite   8,   0, $0b, 1 | OAM_XFLIP
	dbsprite   0,   8, $08, 1 | OAM_XFLIP
	dbsprite   8,   8, $0a, 1 | OAM_XFLIP

.frame_3
	db 4 ; size
	dbsprite   0,   0, $0c, 1
	dbsprite   0,   8, $0d, 1
	dbsprite   8,   0, $0e, 1
	dbsprite   8,   8, $0f, 1

.frame_4
	db 4 ; size
	dbsprite   0,   0, $10, 1
	dbsprite   0,   8, $11, 1
	dbsprite   8,   0, $12, 1
	dbsprite   8,   8, $13, 1

.frame_5
	db 4 ; size
	dbsprite   0,   0, $02, 1
	dbsprite   0,   8, $03, 1
	dbsprite   8,   0, $04, 1
	dbsprite   8,   8, $05, 1

.frame_6
	db 4 ; size
	dbsprite   0,   0, $00, 1
	dbsprite   8,   0, $01, 1
	dbsprite   0,   8, $00, 1 | OAM_XFLIP
	dbsprite   8,   8, $01, 1 | OAM_XFLIP

.frame_7
	db 4 ; size
	dbsprite   0,   0, $03, 1 | OAM_XFLIP
	dbsprite   8,   0, $05, 1 | OAM_XFLIP
	dbsprite   0,   8, $02, 1 | OAM_XFLIP
	dbsprite   8,   8, $04, 1 | OAM_XFLIP

.frame_8
	db 4 ; size
	dbsprite   0,   0, $0d, 1 | OAM_XFLIP
	dbsprite   8,   0, $0f, 1 | OAM_XFLIP
	dbsprite   0,   8, $0c, 1 | OAM_XFLIP
	dbsprite   8,   8, $0e, 1 | OAM_XFLIP

.frame_9
	db 4 ; size
	dbsprite   0,   0, $11, 1 | OAM_XFLIP
	dbsprite   8,   0, $13, 1 | OAM_XFLIP
	dbsprite   0,   8, $10, 1 | OAM_XFLIP
	dbsprite   8,   8, $12, 1 | OAM_XFLIP

OAMData61::
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
	dbsprite   0,   0, $00, 2
	dbsprite   8,   0, $01, 2
	dbsprite   0,   8, $00, 2 | OAM_XFLIP
	dbsprite   8,   8, $01, 2 | OAM_XFLIP

.frame_7
	db 4 ; size
	dbsprite   0,   0, $03, 2 | OAM_XFLIP
	dbsprite   8,   0, $05, 2 | OAM_XFLIP
	dbsprite   0,   8, $02, 2 | OAM_XFLIP
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

OAMData62::
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
	dbsprite   0,   0, $08, 3
	dbsprite   0,   8, $09, 3
	dbsprite   8,   0, $0a, 3
	dbsprite   8,   8, $0b, 3

.frame_1
	db 4 ; size
	dbsprite   0,   0, $06, 3
	dbsprite   8,   0, $07, 3
	dbsprite   8,   8, $07, 3 | OAM_XFLIP
	dbsprite   0,   8, $06, 3 | OAM_XFLIP

.frame_2
	db 4 ; size
	dbsprite   0,   0, $09, 3 | OAM_XFLIP
	dbsprite   8,   0, $0b, 3 | OAM_XFLIP
	dbsprite   0,   8, $08, 3 | OAM_XFLIP
	dbsprite   8,   8, $0a, 3 | OAM_XFLIP

.frame_3
	db 4 ; size
	dbsprite   0,   0, $0c, 3
	dbsprite   0,   8, $0d, 3
	dbsprite   8,   0, $0e, 3
	dbsprite   8,   8, $0f, 3

.frame_4
	db 4 ; size
	dbsprite   0,   0, $10, 3
	dbsprite   0,   8, $11, 3
	dbsprite   8,   0, $12, 3
	dbsprite   8,   8, $13, 3

.frame_5
	db 4 ; size
	dbsprite   0,   0, $02, 3
	dbsprite   0,   8, $03, 3
	dbsprite   8,   0, $04, 3
	dbsprite   8,   8, $05, 3

.frame_6
	db 4 ; size
	dbsprite   0,   0, $00, 3
	dbsprite   8,   0, $01, 3
	dbsprite   0,   8, $00, 3 | OAM_XFLIP
	dbsprite   8,   8, $01, 3 | OAM_XFLIP

.frame_7
	db 4 ; size
	dbsprite   0,   0, $03, 3 | OAM_XFLIP
	dbsprite   8,   0, $05, 3 | OAM_XFLIP
	dbsprite   0,   8, $02, 3 | OAM_XFLIP
	dbsprite   8,   8, $04, 3 | OAM_XFLIP

.frame_8
	db 4 ; size
	dbsprite   0,   0, $0d, 3 | OAM_XFLIP
	dbsprite   8,   0, $0f, 3 | OAM_XFLIP
	dbsprite   0,   8, $0c, 3 | OAM_XFLIP
	dbsprite   8,   8, $0e, 3 | OAM_XFLIP

.frame_9
	db 4 ; size
	dbsprite   0,   0, $11, 3 | OAM_XFLIP
	dbsprite   8,   0, $13, 3 | OAM_XFLIP
	dbsprite   0,   8, $10, 3 | OAM_XFLIP
	dbsprite   8,   8, $12, 3 | OAM_XFLIP

OAMData63::
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
	dbsprite   8,   8, $01, 4 | OAM_XFLIP
	dbsprite   8,   0, $01, 4
	dbsprite   0,   8, $00, 4 | OAM_XFLIP
	dbsprite   0,   0, $00, 4

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

OAMData64::
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
	dbsprite   8,   8, $07, 5 | OAM_XFLIP
	dbsprite   8,   0, $07, 5
	dbsprite   0,   8, $06, 5 | OAM_XFLIP
	dbsprite   0,   0, $06, 5

.frame_2
	db 4 ; size
	dbsprite   8,   8, $0a, 5 | OAM_XFLIP
	dbsprite   8,   0, $0b, 5 | OAM_XFLIP
	dbsprite   0,   8, $08, 5 | OAM_XFLIP
	dbsprite   0,   0, $09, 5 | OAM_XFLIP

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
	dbsprite   8,   8, $01, 5 | OAM_XFLIP
	dbsprite   8,   0, $01, 5
	dbsprite   0,   8, $00, 5 | OAM_XFLIP
	dbsprite   0,   0, $00, 5

.frame_7
	db 4 ; size
	dbsprite   8,   8, $04, 5 | OAM_XFLIP
	dbsprite   8,   0, $05, 5 | OAM_XFLIP
	dbsprite   0,   8, $02, 5 | OAM_XFLIP
	dbsprite   0,   0, $03, 5 | OAM_XFLIP

.frame_8
	db 4 ; size
	dbsprite   8,   8, $0e, 5 | OAM_XFLIP
	dbsprite   8,   0, $0f, 5 | OAM_XFLIP
	dbsprite   0,   8, $0c, 5 | OAM_XFLIP
	dbsprite   0,   0, $0d, 5 | OAM_XFLIP

.frame_9
	db 4 ; size
	dbsprite   8,   8, $12, 5 | OAM_XFLIP
	dbsprite   8,   0, $13, 5 | OAM_XFLIP
	dbsprite   0,   8, $10, 5 | OAM_XFLIP
	dbsprite   0,   0, $11, 5 | OAM_XFLIP

OAMData65::
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
	dbsprite   0,   0, $08, 6
	dbsprite   0,   8, $09, 6
	dbsprite   8,   0, $0a, 6
	dbsprite   8,   8, $0b, 6

.frame_1
	db 4 ; size
	dbsprite   0,   0, $06, 6
	dbsprite   8,   0, $07, 6
	dbsprite   8,   8, $07, 6 | OAM_XFLIP
	dbsprite   0,   8, $06, 6 | OAM_XFLIP

.frame_2
	db 4 ; size
	dbsprite   0,   0, $09, 6 | OAM_XFLIP
	dbsprite   8,   0, $0b, 6 | OAM_XFLIP
	dbsprite   0,   8, $08, 6 | OAM_XFLIP
	dbsprite   8,   8, $0a, 6 | OAM_XFLIP

.frame_3
	db 4 ; size
	dbsprite   0,   0, $0c, 6
	dbsprite   0,   8, $0d, 6
	dbsprite   8,   0, $0e, 6
	dbsprite   8,   8, $0f, 6

.frame_4
	db 4 ; size
	dbsprite   0,   0, $10, 6
	dbsprite   0,   8, $11, 6
	dbsprite   8,   0, $12, 6
	dbsprite   8,   8, $13, 6

.frame_5
	db 4 ; size
	dbsprite   0,   0, $02, 6
	dbsprite   0,   8, $03, 6
	dbsprite   8,   0, $04, 6
	dbsprite   8,   8, $05, 6

.frame_6
	db 4 ; size
	dbsprite   8,   8, $01, 6 | OAM_XFLIP
	dbsprite   8,   0, $01, 6
	dbsprite   0,   8, $00, 6 | OAM_XFLIP
	dbsprite   0,   0, $00, 6

.frame_7
	db 4 ; size
	dbsprite   0,   8, $03, 6
	dbsprite   8,   0, $05, 6 | OAM_XFLIP
	dbsprite   0,   0, $02, 6
	dbsprite   8,   8, $04, 6 | OAM_XFLIP

.frame_8
	db 4 ; size
	dbsprite   0,   0, $0d, 6 | OAM_XFLIP
	dbsprite   8,   0, $0f, 6 | OAM_XFLIP
	dbsprite   0,   8, $0c, 6 | OAM_XFLIP
	dbsprite   8,   8, $0e, 6 | OAM_XFLIP

.frame_9
	db 4 ; size
	dbsprite   0,   0, $11, 6 | OAM_XFLIP
	dbsprite   8,   0, $13, 6 | OAM_XFLIP
	dbsprite   0,   8, $10, 6 | OAM_XFLIP
	dbsprite   8,   8, $12, 6 | OAM_XFLIP

OAMData66::
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
	dbsprite   0,   0, $08, 7
	dbsprite   0,   8, $09, 7
	dbsprite   8,   0, $0a, 7
	dbsprite   8,   8, $0b, 7

.frame_1
	db 4 ; size
	dbsprite   0,   0, $06, 7
	dbsprite   8,   0, $07, 7
	dbsprite   8,   8, $07, 7 | OAM_XFLIP
	dbsprite   0,   8, $06, 7 | OAM_XFLIP

.frame_2
	db 4 ; size
	dbsprite   0,   0, $09, 7 | OAM_XFLIP
	dbsprite   8,   0, $0b, 7 | OAM_XFLIP
	dbsprite   0,   8, $08, 7 | OAM_XFLIP
	dbsprite   8,   8, $0a, 7 | OAM_XFLIP

.frame_3
	db 4 ; size
	dbsprite   0,   0, $0c, 7
	dbsprite   0,   8, $0d, 7
	dbsprite   8,   0, $0e, 7
	dbsprite   8,   8, $0f, 7

.frame_4
	db 4 ; size
	dbsprite   0,   0, $10, 7
	dbsprite   0,   8, $11, 7
	dbsprite   8,   0, $12, 7
	dbsprite   8,   8, $13, 7

.frame_5
	db 4 ; size
	dbsprite   0,   0, $02, 7
	dbsprite   0,   8, $03, 7
	dbsprite   8,   0, $04, 7
	dbsprite   8,   8, $05, 7

.frame_6
	db 4 ; size
	dbsprite   8,   8, $01, 7 | OAM_XFLIP
	dbsprite   8,   0, $01, 7
	dbsprite   0,   8, $00, 7 | OAM_XFLIP
	dbsprite   0,   0, $00, 7

.frame_7
	db 4 ; size
	dbsprite   0,   8, $03, 7
	dbsprite   8,   0, $05, 7 | OAM_XFLIP
	dbsprite   0,   0, $02, 7
	dbsprite   8,   8, $04, 7 | OAM_XFLIP

.frame_8
	db 4 ; size
	dbsprite   0,   0, $0d, 7 | OAM_XFLIP
	dbsprite   8,   0, $0f, 7 | OAM_XFLIP
	dbsprite   0,   8, $0c, 7 | OAM_XFLIP
	dbsprite   8,   8, $0e, 7 | OAM_XFLIP

.frame_9
	db 4 ; size
	dbsprite   0,   0, $11, 7 | OAM_XFLIP
	dbsprite   8,   0, $13, 7 | OAM_XFLIP
	dbsprite   0,   8, $10, 7 | OAM_XFLIP
	dbsprite   8,   8, $12, 7 | OAM_XFLIP

OAMData67::
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
	dbsprite   0,   0, $00, 0
	dbsprite   8,   0, $01, 0
	dbsprite   0,   8, $00, 0 | OAM_XFLIP
	dbsprite   8,   8, $01, 0 | OAM_XFLIP

.frame_7
	db 4 ; size
	dbsprite   0,   0, $03, 0 | OAM_XFLIP
	dbsprite   8,   0, $05, 0 | OAM_XFLIP
	dbsprite   0,   8, $02, 0 | OAM_XFLIP
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

OAMData68::
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
	dbsprite   0,   0, $08, 3
	dbsprite   0,   8, $09, 3
	dbsprite   8,   0, $0a, 3
	dbsprite   8,   8, $0b, 3

.frame_1
	db 4 ; size
	dbsprite   0,   0, $06, 3
	dbsprite   8,   0, $07, 3
	dbsprite   8,   8, $07, 3 | OAM_XFLIP
	dbsprite   0,   8, $06, 3 | OAM_XFLIP

.frame_2
	db 4 ; size
	dbsprite   0,   0, $09, 3 | OAM_XFLIP
	dbsprite   8,   0, $0b, 3 | OAM_XFLIP
	dbsprite   0,   8, $08, 3 | OAM_XFLIP
	dbsprite   8,   8, $0a, 3 | OAM_XFLIP

.frame_3
	db 4 ; size
	dbsprite   0,   0, $0c, 3
	dbsprite   0,   8, $0d, 3
	dbsprite   8,   0, $0e, 3
	dbsprite   8,   8, $0f, 3

.frame_4
	db 4 ; size
	dbsprite   0,   0, $10, 3
	dbsprite   0,   8, $11, 3
	dbsprite   8,   0, $12, 3
	dbsprite   8,   8, $13, 3

.frame_5
	db 4 ; size
	dbsprite   0,   0, $02, 3
	dbsprite   0,   8, $03, 3
	dbsprite   8,   0, $04, 3
	dbsprite   8,   8, $05, 3

.frame_6
	db 4 ; size
	dbsprite   8,   8, $01, 3 | OAM_XFLIP
	dbsprite   8,   0, $01, 3
	dbsprite   0,   8, $00, 3 | OAM_XFLIP
	dbsprite   0,   0, $00, 3

.frame_7
	db 4 ; size
	dbsprite   0,   0, $03, 3 | OAM_XFLIP
	dbsprite   8,   0, $05, 3 | OAM_XFLIP
	dbsprite   0,   8, $02, 3 | OAM_XFLIP
	dbsprite   8,   8, $04, 3 | OAM_XFLIP

.frame_8
	db 4 ; size
	dbsprite   0,   0, $0d, 3 | OAM_XFLIP
	dbsprite   8,   0, $0f, 3 | OAM_XFLIP
	dbsprite   0,   8, $0c, 3 | OAM_XFLIP
	dbsprite   8,   8, $0e, 3 | OAM_XFLIP

.frame_9
	db 4 ; size
	dbsprite   0,   0, $11, 3 | OAM_XFLIP
	dbsprite   8,   0, $13, 3 | OAM_XFLIP
	dbsprite   0,   8, $10, 3 | OAM_XFLIP
	dbsprite   8,   8, $12, 3 | OAM_XFLIP

OAMData69::
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
	dbsprite   0,   0, $08, 6
	dbsprite   0,   8, $09, 6
	dbsprite   8,   0, $0a, 6
	dbsprite   8,   8, $0b, 6

.frame_1
	db 4 ; size
	dbsprite   0,   0, $06, 6
	dbsprite   8,   0, $07, 6
	dbsprite   8,   8, $07, 6 | OAM_XFLIP
	dbsprite   0,   8, $06, 6 | OAM_XFLIP

.frame_2
	db 4 ; size
	dbsprite   0,   0, $09, 6 | OAM_XFLIP
	dbsprite   8,   0, $0b, 6 | OAM_XFLIP
	dbsprite   0,   8, $08, 6 | OAM_XFLIP
	dbsprite   8,   8, $0a, 6 | OAM_XFLIP

.frame_3
	db 4 ; size
	dbsprite   0,   0, $0c, 6
	dbsprite   0,   8, $0d, 6
	dbsprite   8,   0, $0e, 6
	dbsprite   8,   8, $0f, 6

.frame_4
	db 4 ; size
	dbsprite   0,   0, $10, 6
	dbsprite   0,   8, $11, 6
	dbsprite   8,   0, $12, 6
	dbsprite   8,   8, $13, 6

.frame_5
	db 4 ; size
	dbsprite   0,   0, $02, 6
	dbsprite   0,   8, $03, 6
	dbsprite   8,   0, $04, 6
	dbsprite   8,   8, $05, 6

.frame_6
	db 4 ; size
	dbsprite   0,   8, $14, 0
	dbsprite   0,   0, $00, 6
	dbsprite   8,   0, $01, 6
	dbsprite   8,   8, $01, 6 | OAM_XFLIP

.frame_7
	db 4 ; size
	dbsprite   0,   8, $03, 6
	dbsprite   8,   0, $05, 6 | OAM_XFLIP
	dbsprite   0,   0, $02, 6
	dbsprite   8,   8, $04, 6 | OAM_XFLIP

.frame_8
	db 4 ; size
	dbsprite   0,   0, $0d, 6 | OAM_XFLIP
	dbsprite   8,   0, $0f, 6 | OAM_XFLIP
	dbsprite   0,   8, $0c, 6 | OAM_XFLIP
	dbsprite   8,   8, $0e, 6 | OAM_XFLIP

.frame_9
	db 4 ; size
	dbsprite   0,   0, $11, 6 | OAM_XFLIP
	dbsprite   8,   0, $13, 6 | OAM_XFLIP
	dbsprite   0,   8, $10, 6 | OAM_XFLIP
	dbsprite   8,   8, $12, 6 | OAM_XFLIP

OAMData6A::
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
	dbsprite   0,   8, $08, 4 | OAM_XFLIP
	dbsprite   0,   0, $09, 4 | OAM_XFLIP
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
	dbsprite   0,   8, $09, 4
	dbsprite   8,   0, $0b, 4 | OAM_XFLIP
	dbsprite   0,   0, $08, 4
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
	dbsprite   0,   0, $00, 4
	dbsprite   8,   0, $01, 4
	dbsprite   0,   8, $00, 4 | OAM_XFLIP
	dbsprite   8,   8, $01, 4 | OAM_XFLIP

.frame_7
	db 4 ; size
	dbsprite   0,   0, $03, 4 | OAM_XFLIP
	dbsprite   8,   0, $05, 4 | OAM_XFLIP
	dbsprite   0,   8, $02, 4 | OAM_XFLIP
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

OAMData6C::
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
	dbsprite   0,   0, $08, 6
	dbsprite   0,   8, $09, 6
	dbsprite   8,   0, $0a, 6
	dbsprite   8,   8, $0b, 6

.frame_1
	db 4 ; size
	dbsprite   0,   0, $06, 6
	dbsprite   8,   0, $07, 6
	dbsprite   8,   8, $07, 6 | OAM_XFLIP
	dbsprite   0,   8, $06, 6 | OAM_XFLIP

.frame_2
	db 4 ; size
	dbsprite   0,   0, $09, 6 | OAM_XFLIP
	dbsprite   8,   0, $0b, 6 | OAM_XFLIP
	dbsprite   0,   8, $08, 6 | OAM_XFLIP
	dbsprite   8,   8, $0a, 6 | OAM_XFLIP

.frame_3
	db 4 ; size
	dbsprite   0,   0, $0c, 6
	dbsprite   0,   8, $0d, 6
	dbsprite   8,   0, $0e, 6
	dbsprite   8,   8, $0f, 6

.frame_4
	db 4 ; size
	dbsprite   0,   0, $10, 6
	dbsprite   0,   8, $11, 6
	dbsprite   8,   0, $12, 6
	dbsprite   8,   8, $13, 6

.frame_5
	db 4 ; size
	dbsprite   0,   0, $02, 6
	dbsprite   0,   8, $03, 6
	dbsprite   8,   0, $04, 6
	dbsprite   8,   8, $05, 6

.frame_6
	db 4 ; size
	dbsprite   8,   8, $01, 6 | OAM_XFLIP
	dbsprite   0,   8, $14, 6
	dbsprite   8,   0, $01, 6
	dbsprite   0,   0, $00, 6

.frame_7
	db 4 ; size
	dbsprite   8,   8, $16, 6
	dbsprite   8,   0, $15, 6
	dbsprite   0,   8, $03, 6
	dbsprite   0,   0, $02, 6

.frame_8
	db 4 ; size
	dbsprite   0,   0, $0d, 6 | OAM_XFLIP
	dbsprite   8,   0, $0f, 6 | OAM_XFLIP
	dbsprite   0,   8, $0c, 6 | OAM_XFLIP
	dbsprite   8,   8, $0e, 6 | OAM_XFLIP

.frame_9
	db 4 ; size
	dbsprite   0,   0, $11, 6 | OAM_XFLIP
	dbsprite   8,   0, $13, 6 | OAM_XFLIP
	dbsprite   0,   8, $10, 6 | OAM_XFLIP
	dbsprite   8,   8, $12, 6 | OAM_XFLIP

OAMData6D::
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
	dbsprite   8,   8, $15, 0
	dbsprite   0,   8, $14, 0
	dbsprite   0,   0, $00, 0
	dbsprite   8,   0, $01, 0

.frame_7
	db 4 ; size
	dbsprite   8,   8, $1b, 0
	dbsprite   8,   0, $1a, 0
	dbsprite   0,   0, $03, 0 | OAM_XFLIP
	dbsprite   0,   8, $02, 0 | OAM_XFLIP

.frame_8
	db 4 ; size
	dbsprite   8,   0, $17, 0
	dbsprite   0,   0, $16, 0
	dbsprite   0,   8, $0c, 0 | OAM_XFLIP
	dbsprite   8,   8, $0e, 0 | OAM_XFLIP

.frame_9
	db 4 ; size
	dbsprite   8,   0, $19, 0
	dbsprite   0,   0, $18, 0
	dbsprite   0,   8, $10, 0 | OAM_XFLIP
	dbsprite   8,   8, $12, 0 | OAM_XFLIP

OAMData6E::
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
	dbsprite   0,   8, $16, 0
	dbsprite   0,   0, $06, 0
	dbsprite   8,   0, $07, 0
	dbsprite   8,   8, $07, 0 | OAM_XFLIP

.frame_2
	db 4 ; size
	dbsprite   0,   8, $09, 0
	dbsprite   8,   0, $0b, 0 | OAM_XFLIP
	dbsprite   0,   0, $08, 0
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

OAMData6F::
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
	dbsprite   0,   0, $08, 7
	dbsprite   0,   8, $09, 7
	dbsprite   8,   0, $0a, 7
	dbsprite   8,   8, $0b, 7

.frame_1
	db 4 ; size
	dbsprite   0,   0, $06, 7
	dbsprite   8,   0, $07, 7
	dbsprite   8,   8, $07, 7 | OAM_XFLIP
	dbsprite   0,   8, $06, 7 | OAM_XFLIP

.frame_2
	db 4 ; size
	dbsprite   0,   0, $09, 7 | OAM_XFLIP
	dbsprite   8,   0, $0b, 7 | OAM_XFLIP
	dbsprite   0,   8, $08, 7 | OAM_XFLIP
	dbsprite   8,   8, $0a, 7 | OAM_XFLIP

.frame_3
	db 4 ; size
	dbsprite   0,   0, $0c, 7
	dbsprite   0,   8, $0d, 7
	dbsprite   8,   0, $0e, 7
	dbsprite   8,   8, $0f, 7

.frame_4
	db 4 ; size
	dbsprite   0,   0, $10, 7
	dbsprite   0,   8, $11, 7
	dbsprite   8,   0, $12, 7
	dbsprite   8,   8, $13, 7

.frame_5
	db 4 ; size
	dbsprite   0,   0, $02, 7
	dbsprite   0,   8, $03, 7
	dbsprite   8,   0, $04, 7
	dbsprite   8,   8, $05, 7

.frame_6
	db 4 ; size
	dbsprite   0,   8, $14, 7
	dbsprite   0,   0, $00, 7
	dbsprite   8,   0, $01, 7
	dbsprite   8,   8, $01, 7 | OAM_XFLIP

.frame_7
	db 4 ; size
	dbsprite   0,   8, $03, 7
	dbsprite   8,   0, $05, 7 | OAM_XFLIP
	dbsprite   0,   0, $02, 7
	dbsprite   8,   8, $04, 7 | OAM_XFLIP

.frame_8
	db 4 ; size
	dbsprite   0,   0, $0d, 7 | OAM_XFLIP
	dbsprite   8,   0, $0f, 7 | OAM_XFLIP
	dbsprite   0,   8, $0c, 7 | OAM_XFLIP
	dbsprite   8,   8, $0e, 7 | OAM_XFLIP

.frame_9
	db 4 ; size
	dbsprite   0,   0, $11, 7 | OAM_XFLIP
	dbsprite   8,   0, $13, 7 | OAM_XFLIP
	dbsprite   0,   8, $10, 7 | OAM_XFLIP
	dbsprite   8,   8, $12, 7 | OAM_XFLIP

OAMData70::
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
	dbsprite   8,   8, $17, 0
	dbsprite   0,   8, $16, 0
	dbsprite   0,   0, $06, 0
	dbsprite   8,   0, $07, 0

.frame_2
	db 4 ; size
	dbsprite   8,   8, $27, 0
	dbsprite   8,   0, $26, 0
	dbsprite   0,   8, $25, 0
	dbsprite   0,   0, $24, 0

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
	dbsprite   8,   8, $23, 0
	dbsprite   8,   0, $22, 0
	dbsprite   0,   8, $21, 0
	dbsprite   0,   0, $20, 0

.frame_8
	db 4 ; size
	dbsprite   8,   8, $1b, 0
	dbsprite   8,   0, $1a, 0
	dbsprite   0,   8, $19, 0
	dbsprite   0,   0, $18, 0

.frame_9
	db 4 ; size
	dbsprite   8,   8, $1f, 0
	dbsprite   8,   0, $1e, 0
	dbsprite   0,   8, $1d, 0
	dbsprite   0,   0, $1c, 0

OAMData71::
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
	dbsprite   0,   0, $08, 6
	dbsprite   0,   8, $09, 6
	dbsprite   8,   0, $0a, 6
	dbsprite   8,   8, $0b, 6

.frame_1
	db 4 ; size
	dbsprite   0,   0, $06, 6
	dbsprite   8,   0, $07, 6
	dbsprite   8,   8, $07, 6 | OAM_XFLIP
	dbsprite   0,   8, $06, 6 | OAM_XFLIP

.frame_2
	db 4 ; size
	dbsprite   0,   0, $09, 6 | OAM_XFLIP
	dbsprite   8,   0, $0b, 6 | OAM_XFLIP
	dbsprite   0,   8, $08, 6 | OAM_XFLIP
	dbsprite   8,   8, $0a, 6 | OAM_XFLIP

.frame_3
	db 4 ; size
	dbsprite   0,   0, $0c, 6
	dbsprite   0,   8, $0d, 6
	dbsprite   8,   0, $0e, 6
	dbsprite   8,   8, $0f, 6

.frame_4
	db 4 ; size
	dbsprite   0,   0, $10, 6
	dbsprite   0,   8, $11, 6
	dbsprite   8,   0, $12, 6
	dbsprite   8,   8, $13, 6

.frame_5
	db 4 ; size
	dbsprite   0,   0, $02, 6
	dbsprite   0,   8, $03, 6
	dbsprite   8,   0, $04, 6
	dbsprite   8,   8, $05, 6

.frame_6
	db 4 ; size
	dbsprite   0,   8, $14, 6
	dbsprite   0,   0, $00, 6
	dbsprite   8,   0, $01, 6
	dbsprite   8,   8, $01, 6 | OAM_XFLIP

.frame_7
	db 4 ; size
	dbsprite   0,   8, $03, 6
	dbsprite   8,   0, $05, 6 | OAM_XFLIP
	dbsprite   0,   0, $02, 6
	dbsprite   8,   8, $04, 6 | OAM_XFLIP

.frame_8
	db 4 ; size
	dbsprite   0,   0, $0d, 6 | OAM_XFLIP
	dbsprite   8,   0, $0f, 6 | OAM_XFLIP
	dbsprite   0,   8, $0c, 6 | OAM_XFLIP
	dbsprite   8,   8, $0e, 6 | OAM_XFLIP

.frame_9
	db 4 ; size
	dbsprite   0,   0, $11, 6 | OAM_XFLIP
	dbsprite   8,   0, $13, 6 | OAM_XFLIP
	dbsprite   0,   8, $10, 6 | OAM_XFLIP
	dbsprite   8,   8, $12, 6 | OAM_XFLIP

OAMData72::
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
	dbsprite   0,   8, $15, 2
	dbsprite   0,   0, $06, 2
	dbsprite   8,   0, $07, 2
	dbsprite   8,   8, $07, 2 | OAM_XFLIP

.frame_2
	db 4 ; size
	dbsprite   0,   8, $09, 2
	dbsprite   8,   0, $0b, 2 | OAM_XFLIP
	dbsprite   0,   0, $08, 2
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
	dbsprite   8,   8, $17, 2
	dbsprite   8,   0, $16, 2
	dbsprite   0,   8, $03, 2
	dbsprite   0,   0, $02, 2

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

OAMData80::
	dw .frame_0

.frame_0
	db 4 ; size
	dbsprite   8,   8, $03, 3
	dbsprite   8,   0, $02, 3
	dbsprite   0,   8, $01, 3
	dbsprite   0,   0, $00, 3

OAMData81::
	dw .frame_0

.frame_0
	db 4 ; size
	dbsprite   8,   8, $03, 1
	dbsprite   8,   0, $02, 1
	dbsprite   0,   8, $01, 1
	dbsprite   0,   0, $00, 1

OAMData88::
	dw .frame_0
	dw .frame_1
	dw .frame_2

.frame_0
	db 2 ; size
	dbsprite   0,   8, $0d, 0
	dbsprite   0,   0, $0c, 0

.frame_1
	db 2 ; size
	dbsprite   0,   8, $0f, 0
	dbsprite   0,   0, $0e, 0

.frame_2
	db 2 ; size
	dbsprite   0,   8, $11, 0
	dbsprite   0,   0, $10, 0
