SECTION "Bank 10@4462", ROMX[$4462], BANK[$10]

Data_40462:
	db OVERWORLD_MAP
	dba Data_40467
	db $09

Data_40467:
	dbw $01, Func_40474
	dbw $02, Func_4048a
	dbw $04, Func_4053b
	dbw $0f, Func_4053e
	db $ff ; end

Func_40474:
	ld a, [wd584]
	cp $26
	jr z, .asm_40482
	cp $1f
	jr z, .asm_40482
	scf
	ccf
	ret

.asm_40482
	ld a, $1e
	ld [wd58e], a
	scf
	ccf
	ret

Func_4048a:
	xor a
	farcall InitOWObjects
	lb de,  1, 1
	lb bc, 11, 1
	farcall FillBoxInBGMapWithZero
	ld a, [wCurOWLocation]
	ld [wPlayerOWLocation], a

	ld a, OW_UNK_C8
	lb de, $78, $00
	ld b, NORTH
	farcall LoadOWObject

	ld a, [wCurOWLocation]
	call PrintTCGIslandLocationName

	ld a, [wd584]
	cp $1f
	jr z, .asm_404f5
	cp $26
	jr z, .asm_404f5

	ld a, [wPlayerOWObject]
	lb de, 0, 0
	ld b, SOUTH
	farcall LoadOWObject

	ld a, [wCurOWLocation]
	call PlacePlayerInTCGIslandLocation

	ld a, OW_UNK_CA
	lb de, 0, 0
	ld b, NORTH
	farcall LoadOWObject

	ld a, [wCurOWLocation]
	call Func_405a6

	ld a, $0a
	ld [wd582], a
	ld a, BANK(Func_4056c)
	ld [wd592], a
	ld hl, Func_4056c
	ld a, l
	ld [wd593 + 0], a
	ld a, h
	ld [wd593 + 1], a
	scf
	ret

.asm_404f5
	ld bc, TILEMAP_001
	lb de, 0, 0
	farcall Func_12c0ce

	ld a, $0a
	ld [wd582], a
	ld a, $10
	ld [wd592], a
	ld hl, $4ce3
	ld a, l
	ld [wd593 + 0], a
	ld a, h
	ld [wd593 + 1], a

	ld a, [wd584]
	cp $26
	jr z, .asm_40528
	ld a, OW_GRSHIP
	lb de, $50, $78
	ld b, EAST
	farcall LoadOWObject
	scf
	ret
.asm_40528
	ld a, OW_GRSHIP
	lb de, $90, $60
	ld b, WEST
	farcall LoadOWObject
	ld a, $00
	call Func_338f
	scf
	ccf
	ret

Func_4053b:
	scf
	ccf
	ret

Func_4053e:
	ld a, [wd585]
	cp $1f
	jr z, .asm_4054b
	cp $26
	jr z, .asm_40569
	scf
	ret

.asm_4054b
	ld a, 10
	ld c, 7
	farcall InitMusicFadeOut
	farcall MusicFadeOut
	xor a
	call PlaySong
	ld a, 7
	call SetVolume
	ld a, SFX_8A
	call PlaySFX
	farcall WaitForSFXToFinish
.asm_40569
	scf
	ccf
	ret

Func_4056c:
	farcall Func_d683
	farcall Func_1f293
	call WaitPalFading
.asm_40577
	call DoFrame
	call UpdateRNGSources
	call Func_405bd
	ldh a, [hKeysPressed]
	bit A_BUTTON_F, a
	jr z, .asm_40577
	call Func_406d1
	xor a
	call PlaySFX
	call Func_40682
	ret

PlacePlayerInTCGIslandLocation:
	sla a ; *2
	ld hl, TCGIslandLocationPositions
	add l
	ld l, a
	jr nc, .no_overflow
	inc h
.no_overflow
	ld a, [hli]
	ld e, [hl]
	ld d, a
	ld a, [wPlayerOWObject]
	farcall SetOWObjectPosition
	ret

Func_405a6:
	sla a ; *2
	ld hl, TCGIslandLocationPositions
	add l
	ld l, a
	jr nc, .no_overflow
	inc h
.no_overflow
	ld a, [hli]
	ld d, a
	ld a, [hl]
	sub 12
	ld e, a
	ld a, OW_UNK_CA
	farcall SetOWObjectPosition
	ret

Func_405bd:
	lb bc, 4, 0
	ldh a, [hKeysPressed]
.loop_shift
	sla a
	jr c, .asm_405cb
	inc c
	dec b
	jr nz, .loop_shift
	ret
.asm_405cb
	ld a, SFX_01
	call PlaySFX
	ld a, [wCurOWLocation]
	ld b, a
	sla a
	sla a ; *4
	ld hl, .LocationConnections
	add l
	ld l, a
	jr nc, .no_overflow
	inc h
.no_overflow
	ld a, c
	add l
	ld l, a
	jr nc, .asm_405e6
	inc h
.asm_405e6
	ld a, [hl]
	cp b
	jr z, .done
	ld [wCurOWLocation], a
	call Func_405a6
	ld a, [wCurOWLocation]
	call PrintTCGIslandLocationName
.done
	ret

.LocationConnections:
	; OWMAP_MASON_LABORATORY
	db OWMAP_MASON_LABORATORY ; down
	db OWMAP_LIGHTNING_CLUB ; up
	db OWMAP_MASON_LABORATORY ; left
	db OWMAP_FIGHTING_CLUB ; right

	; OWMAP_ISHIHARAS_HOUSE
	db OWMAP_ROCK_CLUB ; down
	db OWMAP_ISHIHARAS_HOUSE ; up
	db OWMAP_ISHIHARAS_HOUSE ; left
	db OWMAP_TCG_CHALLENGE_HALL ; right

	; OWMAP_LIGHTNING_CLUB
	db OWMAP_FIGHTING_CLUB ; down
	db OWMAP_ROCK_CLUB ; up
	db OWMAP_MASON_LABORATORY ; left
	db OWMAP_POKEMON_DOME ; right

	; OWMAP_PSYCHIC_CLUB
	db OWMAP_GRASS_CLUB ; down
	db OWMAP_FIRE_CLUB ; up
	db OWMAP_POKEMON_DOME ; left
	db OWMAP_SCIENCE_CLUB ; right

	; OWMAP_ROCK_CLUB
	db OWMAP_LIGHTNING_CLUB ; down
	db OWMAP_ISHIHARAS_HOUSE ; up
	db OWMAP_ROCK_CLUB ; left
	db OWMAP_POKEMON_DOME ; right

	; OWMAP_FIGHTING_CLUB
	db OWMAP_TCG_AIRPORT ; down
	db OWMAP_LIGHTNING_CLUB ; up
	db OWMAP_MASON_LABORATORY ; left
	db OWMAP_TCG_AIRPORT ; right

	; OWMAP_GRASS_CLUB
	db OWMAP_WATER_CLUB ; down
	db OWMAP_SCIENCE_CLUB ; up
	db OWMAP_PSYCHIC_CLUB ; left
	db OWMAP_GRASS_CLUB ; right

	; OWMAP_SCIENCE_CLUB
	db OWMAP_GRASS_CLUB ; down
	db OWMAP_FIRE_CLUB ; up
	db OWMAP_PSYCHIC_CLUB ; left
	db OWMAP_SCIENCE_CLUB ; right

	; OWMAP_WATER_CLUB
	db OWMAP_TCG_AIRPORT ; down
	db OWMAP_GRASS_CLUB ; up
	db OWMAP_TCG_AIRPORT ; left
	db OWMAP_WATER_CLUB ; right

	; OWMAP_FIRE_CLUB
	db OWMAP_SCIENCE_CLUB ; down
	db OWMAP_FIRE_CLUB ; up
	db OWMAP_PSYCHIC_CLUB ; left
	db OWMAP_SCIENCE_CLUB ; right

	; OWMAP_TCG_AIRPORT
	db OWMAP_TCG_AIRPORT ; down
	db OWMAP_POKEMON_DOME ; up
	db OWMAP_FIGHTING_CLUB ; left
	db OWMAP_WATER_CLUB ; right

	; OWMAP_TCG_CHALLENGE_HALL
	db OWMAP_POKEMON_DOME ; down
	db OWMAP_TCG_CHALLENGE_HALL ; up
	db OWMAP_ISHIHARAS_HOUSE ; left
	db OWMAP_PSYCHIC_CLUB ; right

	; OWMAP_POKEMON_DOME
	db OWMAP_FIGHTING_CLUB ; down
	db OWMAP_TCG_CHALLENGE_HALL ; up
	db OWMAP_ROCK_CLUB ; left
	db OWMAP_PSYCHIC_CLUB ; right

PrintTCGIslandLocationName:
	lb de, 1, 1
	ldtx hl, Text0af8
	call Func_35af

	ld a, [wCurOWLocation]
	sla a
	sla a ; *4
	ld hl, .LocationTitleTextItems
	add l
	ld l, a
	jr nc, .ok
	inc h
.ok
	ld a, [hli]
	ld e, a
	ld a, [hli]
	ld d, a
	ld a, [hli]
	ld h, [hl]
	ld l, a
	call Func_35af
	ret

.LocationTitleTextItems:
	textitem 1, 3, Text09b6 ; OWMAP_MASON_LABORATORY
	textitem 1, 2, Text09b7 ; OWMAP_ISHIHARAS_HOUSE
	textitem 1, 3, Text09b8 ; OWMAP_LIGHTNING_CLUB
	textitem 1, 3, Text09b9 ; OWMAP_PSYCHIC_CLUB
	textitem 1, 3, Text09ba ; OWMAP_ROCK_CLUB
	textitem 1, 3, Text09bb ; OWMAP_FIGHTING_CLUB
	textitem 1, 3, Text09bc ; OWMAP_GRASS_CLUB
	textitem 1, 2, Text09bd ; OWMAP_SCIENCE_CLUB
	textitem 1, 3, Text09be ; OWMAP_WATER_CLUB
	textitem 1, 3, Text09bf ; OWMAP_FIRE_CLUB
	textitem 1, 4, Text09c0 ; OWMAP_TCG_AIRPORT
	textitem 1, 2, Text09c1 ; OWMAP_TCG_CHALLENGE_HALL
	textitem 1, 3, Text09c2 ; OWMAP_POKEMON_DOME

Func_40682:
	ld a, [wCurOWLocation]
	sla a
	sla a ; *4
	ld hl, .data
	add l
	ld l, a
	jr nc, .no_overflow
	inc h
.no_overflow
	ld a, [hl] ; ?
	inc hl
	ld d, [hl] ; x
	inc hl
	ld e, [hl] ; y
	inc hl
	ld b, [hl] ; direction
	farcall Func_d3c4
	ret

.data
	db $02, 6, 13, NORTH ; OWMAP_MASON_LABORATORY
	db $05, 4, 11, NORTH ; OWMAP_ISHIHARAS_HOUSE
	db $06, 4,  7, NORTH ; OWMAP_LIGHTNING_CLUB
	db $09, 4,  7, NORTH ; OWMAP_PSYCHIC_CLUB
	db $0c, 4,  7, NORTH ; OWMAP_ROCK_CLUB
	db $0f, 4,  7, NORTH ; OWMAP_FIGHTING_CLUB
	db $12, 4,  7, NORTH ; OWMAP_GRASS_CLUB
	db $15, 4,  7, NORTH ; OWMAP_SCIENCE_CLUB
	db $18, 4,  7, NORTH ; OWMAP_WATER_CLUB
	db $1b, 4,  7, NORTH ; OWMAP_FIRE_CLUB
	db $1e, 5, 11, NORTH ; OWMAP_TCG_AIRPORT
	db $20, 4,  7, NORTH ; OWMAP_TCG_CHALLENGE_HALL
	db $23, 7,  7, NORTH ; OWMAP_POKEMON_DOME

Func_406d1:
	ld a, [wPlayerOWObject]
	ld b, $01
	farcall Func_11471

	ld a, [wPlayerOWLocation]
	sla a ; *2
	ld hl, $4789
	add l
	ld l, a
	jr nc, .asm_406e7
	inc h
.asm_406e7
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, [wCurOWLocation]
	sla a ; *2
	add l
	ld l, a
	jr nc, .asm_406f4
	inc h
.asm_406f4
	ld a, [hli]
	ld h, [hl]
	ld l, a
	or h
	jr z, .finish_movement ; is null
	ld a, SFX_57
	call PlaySFX

.loop_commands
	ld a, [hli]
	ld e, [hl]
	inc hl
	ld d, a
	or e
	jr z, .straight_line
	cp $ff
	jr z, .finish_movement

; set target position
	push hl
	ld a, [wPlayerOWObject]
	farcall SetOWObjectTargetPosition
	jr .loop_wait_movement

.straight_line
	push hl
	ld a, [wCurOWLocation]
	sla a
	ld hl, TCGIslandLocationPositions
	add l ; *2
	ld l, a
	jr nc, .asm_40722
	inc h
.asm_40722
	ld a, [hli]
	ld e, [hl]
	ld d, a
	ld a, [wPlayerOWObject]
	farcall SetOWObjectTargetPosition

.loop_wait_movement
	call DoFrame
	ld hl, wd583
	bit 2, [hl]
	jr nz, .asm_40746
	ldh a, [hKeysPressed]
	bit B_BUTTON_F, a
	jr z, .asm_40746
	set 2, [hl]
	ld a, $01
	ld b, $00
	farcall StartPalFadeToBlackOrWhite
.asm_40746
	farcall MoveOWObjectToTargetPosition
	jr c, .asm_4074f
	pop hl
	jr .loop_commands
.asm_4074f
	ld a, [wd583]
	bit 2, a
	jr z, .loop_wait_movement
	farcall CheckPalFading
	jr nz, .loop_wait_movement
	pop hl
	jr .wait_fade

.finish_movement
	ld a, $01
	ld b, $00
	farcall StartPalFadeToBlackOrWhite
.wait_fade
	call WaitPalFading
	farcall Func_110a8
	ret

TCGIslandLocationPositions:
	; x, y
	db $0c, $68 ; OWMAP_MASON_LABORATORY
	db $04, $18 ; OWMAP_ISHIHARAS_HOUSE
	db $24, $50 ; OWMAP_LIGHTNING_CLUB
	db $5c, $2c ; OWMAP_PSYCHIC_CLUB
	db $14, $38 ; OWMAP_ROCK_CLUB
	db $34, $68 ; OWMAP_FIGHTING_CLUB
	db $7c, $40 ; OWMAP_GRASS_CLUB
	db $7c, $20 ; OWMAP_SCIENCE_CLUB
	db $6c, $64 ; OWMAP_WATER_CLUB
	db $6c, $10 ; OWMAP_FIRE_CLUB
	db $50, $78 ; OWMAP_TCG_AIRPORT
	db $3c, $20 ; OWMAP_TCG_CHALLENGE_HALL
	db $44, $44 ; OWMAP_POKEMON_DOME
; 0x40789
