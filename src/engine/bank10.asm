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
	farcall Func_111f6
	lb de,  1, 1
	lb bc, 11, 1
	farcall FillBoxInBGMapWithZero
	ld a, [wd587]
	ld [wd588], a

	ld a, OW_UNK_C8
	lb de, $78, $00
	ld b, NORTH
	farcall LoadOWObject

	ld a, [wd587]
	call PrintLocationTitle

	ld a, [wd584]
	cp $1f
	jr z, .asm_404f5
	cp $26
	jr z, .asm_404f5

	ld a, [wPlayerOWObject]
	lb de, 0, 0
	ld b, SOUTH
	farcall LoadOWObject

	ld a, [wd587]
	call Func_40591

	ld a, OW_UNK_CA
	lb de, 0, 0
	ld b, NORTH
	farcall LoadOWObject

	ld a, [wd587]
	call Func_405a6

	ld a, $0a
	ld [wd582], a
	ld a, $10
	ld [wd592], a
	ld hl, $456c
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
; 0x4056c

SECTION "Bank 10@4591", ROMX[$4591], BANK[$10]

Func_40591:
	sla a ; *2
	ld hl, OWLocationPositions
	add l
	ld l, a
	jr nc, .no_cap
	inc h
.no_cap
	ld a, [hli]
	ld e, [hl]
	ld d, a
	ld a, [wPlayerOWObject]
	farcall SetOWObjectPosition
	ret

Func_405a6:
	sla a ; *2
	ld hl, OWLocationPositions
	add l
	ld l, a
	jr nc, .no_cap
	inc h
.no_cap
	ld a, [hli]
	ld d, a
	ld a, [hl]
	sub 12
	ld e, a
	ld a, OW_UNK_CA
	farcall SetOWObjectPosition
	ret
; 0x405bd

SECTION "Bank 10@462b", ROMX[$462b], BANK[$10]

PrintLocationTitle:
	lb de, 1, 1
	ldtx hl, Text0af8
	call Func_35af

	ld a, [wd587]
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
	textitem 1, 4, Text09c0 ; OWMAP_AIRPORT
	textitem 1, 2, Text09c1 ; OWMAP_CHALLENGE_HALL
	textitem 1, 3, Text09c2 ; OWMAP_POKEMON_DOME
; 0x40682

SECTION "Bank 10@476f", ROMX[$476f], BANK[$10]

OWLocationPositions:
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
	db $50, $78 ; OWMAP_AIRPORT
	db $3c, $20 ; OWMAP_CHALLENGE_HALL
	db $44, $44 ; OWMAP_POKEMON_DOME
; 0x40789
