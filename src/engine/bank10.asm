SECTION "Bank 10@4462", ROMX[$4462], BANK[$10]

Data_40462:
	db OVERWORLD_MAP_TCG
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
	ld a, MUSIC_GRBLIMP
	ld [wNextMusic], a
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

	ld a, OW_VOLCANO_SMOKE_TCG
	lb de, $78, $00
	ld b, NORTH
	farcall LoadOWObject

	ld a, [wCurOWLocation]
	call PrintTCGIslandLocationName

	ld a, [wd584]
	cp $1f
	jr z, .gr_ship_cutscene
	cp $26
	jr z, .gr_ship_cutscene

	; this is the case where player is
	; on OW map and navigating
	ld a, [wPlayerOWObject]
	lb de, 0, 0
	ld b, SOUTH
	farcall LoadOWObject
	ld a, [wCurOWLocation]
	call PlacePlayerInTCGIslandLocation

	ld a, OW_CURSOR_TCG
	lb de, 0, 0
	ld b, NORTH
	farcall LoadOWObject
	ld a, [wCurOWLocation]
	call UpdateTCGIslandCursorPosition

	ld a, $0a
	ld [wd582], a
	ld a, BANK(HandleTCGIslandInput)
	ld [wd592], a
	ld hl, HandleTCGIslandInput
	ld a, l
	ld [wd593 + 0], a
	ld a, h
	ld [wd593 + 1], a
	scf
	ret

.gr_ship_cutscene
	ld bc, TILEMAP_001
	lb de, 0, 0
	farcall Func_12c0ce

	ld a, $0a
	ld [wd582], a
	ld a, BANK(DoGRShipMovement)
	ld [wd592], a
	ld hl, DoGRShipMovement
	ld a, l
	ld [wd593 + 0], a
	ld a, h
	ld [wd593 + 1], a

	ld a, [wd584]
	cp $26
	jr z, .asm_40528
	ld a, OW_GR_BLIMP
	lb de, $50, $78
	ld b, EAST
	farcall LoadOWObject
	scf
	ret
.asm_40528
	ld a, OW_GR_BLIMP
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

HandleTCGIslandInput:
	farcall Func_d683
	farcall Func_1f293
	call WaitPalFading
.loop_input
	call DoFrame
	call UpdateRNGSources
	call HandleTCGIslandDirectionalInput
	ldh a, [hKeysPressed]
	bit A_BUTTON_F, a
	jr z, .loop_input
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

UpdateTCGIslandCursorPosition:
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
	ld a, OW_CURSOR_TCG
	farcall SetOWObjectPosition
	ret

HandleTCGIslandDirectionalInput:
	lb bc, 4, 0
	ldh a, [hKeysPressed]
.loop_shift
	sla a
	jr c, .got_key
	inc c
	dec b
	jr nz, .loop_shift
	ret

.got_key
	ld a, SFX_01
	call PlaySFX
	ld a, [wCurOWLocation]
	ld b, a
	sla a
	sla a ; *4
	ld hl, .LocationConnections
	add l
	ld l, a
	jr nc, .no_overflow_1
	inc h
.no_overflow_1
	ld a, c
	add l
	ld l, a
	jr nc, .no_overflow_2
	inc h
.no_overflow_2
	ld a, [hl]
	cp b
	jr z, .done
	ld [wCurOWLocation], a
	call UpdateTCGIslandCursorPosition
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
	ldtx hl, EmptyLocationNameText
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
	textitem 1, 3, MapMasonLabText         ; OWMAP_MASON_LABORATORY
	textitem 1, 2, MapIshiharasHouseText   ; OWMAP_ISHIHARAS_HOUSE
	textitem 1, 3, MapLightningClubText    ; OWMAP_LIGHTNING_CLUB
	textitem 1, 3, MapPsychicClubText      ; OWMAP_PSYCHIC_CLUB
	textitem 1, 3, MapRockClubText         ; OWMAP_ROCK_CLUB
	textitem 1, 3, MapFightingClubText     ; OWMAP_FIGHTING_CLUB
	textitem 1, 3, MapGrassClubText        ; OWMAP_GRASS_CLUB
	textitem 1, 2, MapScienceClubText      ; OWMAP_SCIENCE_CLUB
	textitem 1, 3, MapWaterClubText        ; OWMAP_WATER_CLUB
	textitem 1, 3, MapFireClubText         ; OWMAP_FIRE_CLUB
	textitem 1, 4, MapTCGAirportText       ; OWMAP_TCG_AIRPORT
	textitem 1, 2, MapTCGChallengeHallText ; OWMAP_TCG_CHALLENGE_HALL
	textitem 1, 3, MapPokemonDomeText      ; OWMAP_POKEMON_DOME

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
	ld hl, TCGIslandPlayerPaths
	add l
	ld l, a
	jr nc, .no_overflow_1
	inc h
.no_overflow_1
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, [wCurOWLocation]
	sla a ; *2
	add l
	ld l, a
	jr nc, .no_overflow_2
	inc h
.no_overflow_2
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
	jr nc, .no_overflow_3
	inc h
.no_overflow_3
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

INCLUDE "data/tcg_island_paths.asm"

DoGRShipMovement:
	ld a, [wd584]
	cp $1f
	jr z, .asm_40cfa

	ld a, $1f
	lb de, 0, 0
	ld b, NORTH
	farcall Func_d3c4
	ld hl, .movement_3
	jr .start_movement
.asm_40cfa
	ld a, $26
	lb de, 0, 0
	ld b, NORTH
	farcall Func_d3c4
	ld hl, .movement_2
	ld a, EVENT_SHORT_GR_ISLAND_FLYOVER_SEQUENCE
	farcall GetEventValue
	jr nz, .start_movement
	ld hl, wd583
	set 3, [hl]
	ld hl, .movement_1

.start_movement
	ld a, [hli] ; coordinates
	ld e, [hl]  ;
	inc hl
	ld d, a
	cp $ff
	jr z, .done_movement
	ld a, [hli] ; direction
	ld b, a
	push hl
	push bc
	ld a, OW_GR_BLIMP
	farcall SetOWObjectTargetPosition
	ld a, OW_GR_BLIMP
	pop bc
	farcall SetOWObjectDirection

; does movement every 4 frames
; can be skipped with B button
.loop_movement
	ld c, 4
.loop_wait
	push bc
	call DoFrame
	ld hl, wd583
	bit 3, [hl]
	jr nz, .skip_fade_out
	bit 2, [hl]
	jr nz, .skip_fade_out
	ldh a, [hKeysPressed]
	bit B_BUTTON_F, a
	jr z, .skip_fade_out
	set 2, [hl]
	call .FadeOut
.skip_fade_out
	pop bc
	dec c
	jr nz, .loop_wait
	farcall MoveOWObjectToTargetPosition
	jr c, .still_moving
	pop hl
	jr .start_movement
.still_moving
	ld a, [wd583]
	bit 2, a
	jr z, .loop_movement
	farcall CheckPalFading
	jr nz, .loop_movement
	pop hl
	jr .finish

.done_movement
	ld a, [wd585]
	cp $26
	jr z, .asm_40d71 ; unnecessary cp
.asm_40d71
	call .FadeOut
.finish
	call WaitPalFading
	farcall Func_110a8
	ret

; fades out to white or black
; dependent on wd585
.FadeOut:
	ld a, [wd585]
	cp $26
	jr nz, .to_black
; to white
	ld a, $0
	ld b, $00
	farcall StartPalFadeToBlackOrWhite
	ret
.to_black
	ld a, $1
	ld b, $00
	farcall StartPalFadeToBlackOrWhite
	ret

.movement_1
	; goes up and east (high)
	db $50, $58, EAST
	db $90, $40, EAST
	db $a0, $40, EAST
	db $ff, $ff ; end

.movement_2
	; goes up and east (low)
	db $50, $58, EAST
	db $90, $60, EAST
	db $a0, $60, EAST
	db $ff, $ff ; end

.movement_3
	; goes down
	db $50, $58, WEST
	db $50, $78, EAST
	db $ff, $ff ; end
; 0x40db3
