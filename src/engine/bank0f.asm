SECTION "Bank f@4000", ROMX[$4000], BANK[$f]

Prologue::
	xor a ; MUSIC_STOP
	ld [wCurMusic], a
	ld a, MUSIC_OVERWORLD
	farcall PlayAfterCurrentSong

	xor a
	farcall ShowProloguePortraitAndText

	farcall Func_102ef
	xor a
	farcall InitOWObjects

	; load map and fade in
	ld a, MUSIC_HERECOMESGR
	farcall PlayAfterCurrentSong
	ld bc, OVERWORLD_MAP_GFX_TCG
	farcall LoadOWMap
	ld bc, TILEMAP_001
	lb de, 0, 0
	farcall Func_12c0ce
	ld a, $00
	call Func_338f
	call WaitPalFading
	call EnableLCD

	; do GR Ship movement
	ld a, OW_GR_BLIMP
	lb de, $a0, $30
	ld b, WEST
	farcall LoadOWObject
	lb de, $78, $30
	ld b, WEST
	call .MoveGRShip
	call .DoGRShipBeamAnimation
	lb de, $78, $10
	ld b, WEST
	call .MoveGRShip
	call .DoGRShipBeamAnimation
	lb de, $58, $18
	ld b, WEST
	call .MoveGRShip
	call .DoGRShipBeamAnimation

	ld a, $01
	farcall ShowProloguePortraitAndText_WithFade

	; load player object in map
	ld a, [wPlayerOWObject]
	lb de, $44, $44
	ld b, SOUTH
	farcall LoadOWObject
	lb de, $40, $30
	ld b, WEST
	call .MoveGRShip

	; show beam animation on player
	ld a, EVENT_PLAYER_GENDER
	farcall GetEventValue
	jr nz, .asm_3c08d
	ld bc, FRAMESET_0AE
	jr .asm_3c090
.asm_3c08d
	ld bc, FRAMESET_0B4
.asm_3c090
	ld a, [wPlayerOWObject]
	farcall SetOWObjectFrameset
	call .DoGRShipBeamAnimation

	; more GR Ship movement
	lb de, $20, $40
	ld b, WEST
	call .MoveGRShip
	call .DoGRShipBeamAnimation
	lb de, $30, $58
	ld b, EAST
	call .MoveGRShip
	call .DoGRShipBeamAnimation
	lb de, $68, $50
	ld b, EAST
	call .MoveGRShip
	call .DoGRShipBeamAnimation
	lb de, $50, $5c
	ld b, WEST
	call .MoveGRShip
	lb de, $50, $78
	ld b, EAST
	call .MoveGRShip

	ld a, $02
	farcall ShowProloguePortraitAndText_WithFade

	ld a, EVENT_PLAYER_GENDER
	farcall GetEventValue
	jr nz, .asm_3c0de
	ld bc, FRAMESET_0AF
	jr .asm_3c0e1
.asm_3c0de
	ld bc, FRAMESET_0B5
.asm_3c0e1
	ld a, [wPlayerOWObject]
	farcall SetOWObjectFrameset

	ld a, OW_GR_BLIMP
	farcall _ClearOWObject

	ld bc, TILEMAP_002
	lb de, 0, 0
	farcall Func_12c0ce

	lb de,  1, 1
	lb bc, 11, 1
	farcall FillBoxInBGMapWithZero

	ld a, OWMAP_POKEMON_DOME
	ld [wCurOWLocation], a
	farcall PrintTCGIslandLocationName

	ld a, [wPlayerOWObject]
	call WaitForOWObjectAnimation
	ld a, [wPlayerOWObject]
	farcall _ClearOWObject
	lb de, $44, $44
	ld b, SOUTH
	farcall LoadOWObject
	ld a, 30
	call WaitAFrames
	ld a, SFX_57
	call PlaySFX
	call .MovePlayer

	ld a, OWMAP_MASON_LABORATORY
	ld [wCurOWLocation], a
	farcall PrintTCGIslandLocationName

	ld a, 60
	call WaitAFrames
	xor a
	call PlaySFX
	ld a, $01
	call Func_33a3
	ld a, SFX_0C
	call PlaySFX
	ret

; b = direction
; de = target position
.MoveGRShip:
	push bc
	ld a, OW_GR_BLIMP
	farcall SetOWObjectTargetPosition
	pop bc
.loop
	push bc
	ld a, 3
	call WaitAFrames
	farcall MoveOWObjectToTargetPosition
	pop bc
	; override direction
	ld a, OW_GR_BLIMP
	farcall _SetOWObjectDirection
	jr c, .loop
	ret

.DoGRShipBeamAnimation:
	ld a, SFX_8B
	call PlaySFX
	ld a, OW_GR_BLIMP
	farcall GetOWObjectPosition
	ld a, e
	add $10
	ld e, a
	ld a, d
	sub $04
	ld d, a
	ld a, OW_GR_BLIMP_BEAM
	ld b, SOUTH
	farcall LoadOWObject
	call WaitForOWObjectAnimation
	ld a, OW_GR_BLIMP_BEAM
	farcall _ClearOWObject
	ret

.MovePlayer:
	ld a, [wPlayerOWObject]
	ld b, $01
	farcall Func_11471
	lb de, $24, $68
	farcall SetOWObjectTargetPosition
.loop_wait_1
	call DoFrame
	farcall MoveOWObjectToTargetPosition
	jr c, .loop_wait_1
	ld a, [wPlayerOWObject]
	lb de, $c, $68
	farcall SetOWObjectTargetPosition
.loop_wait_2
	call DoFrame
	farcall MoveOWObjectToTargetPosition
	jr c, .loop_wait_2
	ret
; 0x3c1b9

SECTION "Bank f@43ca", ROMX[$43ca], BANK[$f]

Func_3c3ca:
	xor a
	call Func_33f2
	; Event Script @ 0x3c3ce
	db $01, $11, $25, $0f, $10, $f1, $09, $1b, $44, $13
	db $22, $12, $22, $0d, $0a, $0b, $e3, $43, $11, $22
	db $0a, $0d, $03, $0b, $f8, $43, $09, $ff, $43, $0d
	db $06, $09, $06, $44, $0d, $09, $09, $0d, $44, $08
	db $14, $44, $50, $41, $44, $00, $08, $1e, $44, $50
	db $48, $44, $00, $08, $1e, $44, $50, $52, $44, $00
	db $08, $1e, $44, $50, $5c, $44, $00, $08, $1e, $44
	db $50, $74, $44, $00, $08, $1e, $44, $05, $cc, $12
	db $05, $cd, $12, $02, $36, $0d, $02, $0a, $2d, $44
	db $17, $03, $28, $81, $02, $2d, $92, $44, $2f, $16
	db $05, $00
	ld a, $00
	ld [wd582], a
	ld a, [wNextMusic]
	farcall PlayAfterCurrentSong
	ret
; 0x3c441
