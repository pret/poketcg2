SECTION "Bank c@4080", ROMX[$4080], BANK[$c]

OverworldGr_MapHeader:
	db OVERWORLD_MAP_GFX_GR
	dba OverworldGr_MapScripts
	db MUSIC_GROVERWORLD

OverworldGr_MapScripts:
	dbw $01, Func_30092
	dbw $02, Func_300a8
	dbw $04, Func_3018b
	dbw $0f, Func_30192
	db $ff ; end

Func_30092:
	ld a, [wd584]
	cp $26
	jr z, .asm_300a0
	cp $28
	jr z, .asm_300a0
	scf
	ccf
	ret
.asm_300a0
	ld a, MUSIC_GRBLIMP
	ld [wNextMusic], a
	scf
	ccf
	ret

Func_300a8:
	xor a
	farcall InitOWObjects
	ld a, $02
	farcall SetOWScrollState
	farcall ShowOWMapLocationBox
	call Func_30343
	ld a, [wCurOWLocation]
	ld [wPlayerOWLocation], a

	ld a, NPC_VOLCANO_SMOKE_GR
	lb de, $3c, $20
	ld b, NORTH
	farcall LoadOWObject

	ld a, NPC_GR_CASTLE_FLAG
	lb de, $b0, $00
	ld b, NORTH
	farcall LoadOWObject

	ld a, [wCurOWLocation]
	call PrintGRIslandLocationName

	ld a, [wd584]
	cp $26
	jr z, .asm_3012c
	cp $28
	jr z, .asm_3012c

	ld a, [wPlayerOWObject]
	lb de, 0, 0
	ld b, SOUTH
	farcall LoadOWObject

	ld a, NPC_CURSOR_GR
	lb de, 0, 0
	ld b, NORTH
	farcall LoadOWObject

	ld a, NPC_GR_CROSS
	lb de, 0, 0
	ld b, NORTH
	farcall LoadOWObject

	ld a, [wCurOWLocation]
	call PlacePlayerInGRIslandLocation
	ld a, [wCurOWLocation]
	call Func_30202
	ld a, $0a
	ld [wd582], a
	ld a, BANK(Func_301c0)
	ld [wd592], a
	ld hl, Func_301c0
	ld a, l
	ld [wd593 + 0], a
	ld a, h
	ld [wd593 + 1], a
	scf
	ret

.asm_3012c
	farcall Func_1d51e
	ld a, $0a
	ld [wd582], a
	ld a, $0c
	ld [wd592], a
	ld hl, $50a8
	ld a, l
	ld [wd593 + 0], a
	ld a, h
	ld [wd593 + 1], a
	ld a, [wd584]
	cp $26
	jr z, .asm_30159
	ld a, NPC_GR_BLIMP
	lb de, $18, $b0
	ld b, EAST
	farcall LoadOWObject
	scf
	ret

.asm_30159
	ld a, NPC_GR_BLIMP
	lb de, $30, $f0
	ld b, EAST
	farcall LoadOWObject
	ld a, EVENT_SHORT_GR_ISLAND_FLYOVER_SEQUENCE
	farcall GetEventValue
	call z, .Func_30175
	ld a, 0
	call Func_338f
	scf
	ccf
	ret

.Func_30175:
	ld a, NPC_GR_BLIMP
	farcall SetOWObjectAsScrollTarget
	ld a, $01
	farcall SetOWScrollState
	ld a, NPC_GR_BLIMP
	lb de, $40, $f0
	farcall SetOWObjectPosition
	ret

Func_3018b:
	farcall Func_1d51e
	scf
	ccf
	ret

Func_30192:
	ld a, [wd585]
	cp $28
	jr z, .asm_3019f
	cp $26
	jr z, .asm_301bd
	scf
	ret

.asm_3019f
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
.asm_301bd
	scf
	ccf
	ret

Func_301c0:
	farcall Func_d683
	farcall Func_1f293
	call WaitPalFading
.loop
	call DoFrame
	call UpdateRNGSources
	call Func_30242
	ldh a, [hKeysPressed]
	bit B_PAD_A, a
	jr z, .loop
	ld a, [wCurOWLocation]
	call Func_3030a
	jr c, .loop
	call Func_30452
	xor a
	call PlaySFX
	call Func_303c7
	ret

PlacePlayerInGRIslandLocation:
	sla a ; *2
	ld hl, GRIslandLocationPositions
	add l
	ld l, a
	jr nc, .got_pointer
	inc h
.got_pointer
	ld a, [hli]
	ld e, [hl]
	ld d, a
	ld a, [wPlayerOWObject]
	farcall SetOWObjectPosition
	ret

Func_30202:
	push af
	sla a ; *2
	ld hl, GRIslandLocationPositions
	add l
	ld l, a
	jr nc, .got_pointer
	inc h
.got_pointer
	ld a, [hli]
	ld d, a
	ld a, [hl]
	sub 12
	ld e, a
	ld a, NPC_CURSOR_GR
	farcall SetOWObjectPosition
	ld a, NPC_GR_CROSS
	farcall SetOWObjectPosition
	pop af

	call Func_3030a
	jr c, .asm_30233

	ld a, NPC_CURSOR_GR
	farcall _SetOWObjectSpriteAnimFlag6
	ld a, NPC_GR_CROSS
	farcall _ResetOWObjectSpriteAnimFlag6
	jr .done

.asm_30233
	ld a, NPC_CURSOR_GR
	farcall _ResetOWObjectSpriteAnimFlag6
	ld a, NPC_GR_CROSS
	farcall _SetOWObjectSpriteAnimFlag6
	jr .done ; unnecessary jump

.done
	ret

Func_30242:
	lb bc, 4, 0
	ldh a, [hKeysPressed]
.loop_shift
	sla a
	jr c, .asm_30250
	inc c
	dec b
	jr nz, .loop_shift
	ret
.asm_30250
	ld a, SFX_01
	call PlaySFX
	ld a, [wCurOWLocation]
	ld b, a
	sla a
	sla a ; *4
	ld hl, .LocationConnections
	add l
	ld l, a
	jr nc, .got_pointer1
	inc h
.got_pointer1
	ld a, c
	add l
	ld l, a
	jr nc, .got_pointer2
	inc h
.got_pointer2
	ld a, [hl]
	cp b
	jr z, .done
	ld [wCurOWLocation], a
	call Func_30202
	ld a, [wCurOWLocation]
	call PrintGRIslandLocationName
	call Func_30398
.done
	ret

.LocationConnections:
	; OWMAP_GR_AIRPORT
	db OWMAP_GAME_CENTER ; down
	db OWMAP_SEALED_FORT ; up
	db OWMAP_GR_AIRPORT ; left
	db OWMAP_GR_GRASS_FORT ; right

	; OWMAP_ISHIHARAS_VILLA
	db OWMAP_GR_PSYCHIC_STRONGHOLD ; down
	db OWMAP_ISHIHARAS_VILLA ; up
	db OWMAP_ISHIHARAS_VILLA ; left
	db OWMAP_GR_PSYCHIC_STRONGHOLD ; right

	; OWMAP_GAME_CENTER
	db OWMAP_GAME_CENTER ; down
	db OWMAP_GR_GRASS_FORT ; up
	db OWMAP_GR_AIRPORT ; left
	db OWMAP_GAME_CENTER ; right

	; OWMAP_SEALED_FORT
	db OWMAP_GR_AIRPORT ; down
	db OWMAP_SEALED_FORT ; up
	db OWMAP_SEALED_FORT ; left
	db OWMAP_GR_GRASS_FORT ; right

	; OWMAP_GR_CHALLENGE_HALL
	db OWMAP_GR_WATER_FORT ; down
	db OWMAP_GR_FIRE_FORT ; up
	db OWMAP_GR_LIGHTNING_FORT ; left
	db OWMAP_GR_FIGHTING_FORT ; right

	; OWMAP_GR_GRASS_FORT
	db OWMAP_GAME_CENTER ; down
	db OWMAP_SEALED_FORT ; up
	db OWMAP_GR_AIRPORT ; left
	db OWMAP_GR_LIGHTNING_FORT ; right

	; OWMAP_GR_LIGHTNING_FORT
	db OWMAP_GR_GRASS_FORT ; down
	db OWMAP_GR_CHALLENGE_HALL ; up
	db OWMAP_GR_GRASS_FORT ; left
	db OWMAP_GR_CHALLENGE_HALL ; right

	; OWMAP_GR_FIRE_FORT
	db OWMAP_GR_CHALLENGE_HALL ; down
	db OWMAP_GR_FIRE_FORT ; up
	db OWMAP_GR_FIRE_FORT ; left
	db OWMAP_GR_CHALLENGE_HALL ; right

	; OWMAP_GR_WATER_FORT
	db OWMAP_GR_WATER_FORT ; down
	db OWMAP_GR_CHALLENGE_HALL ; up
	db OWMAP_GR_CHALLENGE_HALL ; left
	db OWMAP_GR_WATER_FORT ; right

	; OWMAP_GR_FIGHTING_FORT
	db OWMAP_GR_CHALLENGE_HALL ; down
	db OWMAP_GR_PSYCHIC_STRONGHOLD ; up
	db OWMAP_GR_CHALLENGE_HALL ; left
	db OWMAP_GR_PSYCHIC_STRONGHOLD ; right

	; OWMAP_GR_PSYCHIC_STRONGHOLD
	db OWMAP_COLORLESS_ALTAR ; down
	db OWMAP_ISHIHARAS_VILLA ; up
	db OWMAP_GR_FIGHTING_FORT ; left
	db OWMAP_GR_CASTLE ; right

	; OWMAP_COLORLESS_ALTAR
	db OWMAP_COLORLESS_ALTAR ; down
	db OWMAP_GR_PSYCHIC_STRONGHOLD ; up
	db OWMAP_GR_PSYCHIC_STRONGHOLD ; left
	db OWMAP_COLORLESS_ALTAR ; right

	; OWMAP_GR_CASTLE
	db OWMAP_GR_PSYCHIC_STRONGHOLD ; down
	db OWMAP_GR_CASTLE ; up
	db OWMAP_GR_PSYCHIC_STRONGHOLD ; left
	db OWMAP_GR_CASTLE ; right

PrintGRIslandLocationName:
	lb de, 1, 33
	ldtx hl, EmptyLocationNameText
	call Func_35df
	ld a, [wCurOWLocation]
	sla a
	sla a ; *4
	ld hl, .data
	add l
	ld l, a
	jr nc, .got_pointer
	inc h
.got_pointer
	ld a, [hli]
	ld e, a
	ld a, [hli]
	ld d, a
	ld a, [hli]
	ld h, [hl]
	ld l, a
	call Func_35df
	ret

.data
	textitem 33, 4, MapGRAirportText           ; OWMAP_GR_AIRPORT
	textitem 33, 2, MapIshiharasVillaText      ; OWMAP_ISHIHARAS_VILLA
	textitem 33, 3, MapGameCenterText          ; OWMAP_GAME_CENTER
	textitem 33, 2, MapSealedFortText          ; OWMAP_SEALED_FORT
	textitem 33, 2, MapGRChallengeHallText     ; OWMAP_GR_CHALLENGE_HALL
	textitem 33, 2, MapGRGrassFortText         ; OWMAP_GR_GRASS_FORT
	textitem 33, 2, MapGRLightningFortText     ; OWMAP_GR_LIGHTNING_FORT
	textitem 33, 2, MapGRFireFortText          ; OWMAP_GR_FIRE_FORT
	textitem 33, 2, MapGRWaterFortText         ; OWMAP_GR_WATER_FORT
	textitem 33, 2, MapGRFightingFortText      ; OWMAP_GR_FIGHTING_FORT
	textitem 33, 1, MapGRPsychicStrongholdText ; OWMAP_GR_PSYCHIC_STRONGHOLD
	textitem 33, 3, MapGRColorlessAltarText    ; OWMAP_COLORLESS_ALTAR
	textitem 33, 2, MapGRCastleText            ; OWMAP_GR_CASTLE

Func_3030a:
	sla a ; *2
	ld hl, .PointerTable
	add l
	ld l, a
	jr nc, .got_pointer
	inc h
.got_pointer
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp hl

.PointerTable:
	dw .NotPastFightingFort ; OWMAP_GR_AIRPORT
	dw .PastFightingFort    ; OWMAP_ISHIHARAS_VILLA
	dw .NotPastFightingFort ; OWMAP_GAME_CENTER
	dw .NotPastFightingFort ; OWMAP_SEALED_FORT
	dw .NotPastFightingFort ; OWMAP_GR_CHALLENGE_HALL
	dw .NotPastFightingFort ; OWMAP_GR_GRASS_FORT
	dw .NotPastFightingFort ; OWMAP_GR_LIGHTNING_FORT
	dw .NotPastFightingFort ; OWMAP_GR_FIRE_FORT
	dw .NotPastFightingFort ; OWMAP_GR_WATER_FORT
	dw .NotPastFightingFort ; OWMAP_GR_FIGHTING_FORT
	dw .PastFightingFort    ; OWMAP_GR_PSYCHIC_STRONGHOLD
	dw .PastFightingFort    ; OWMAP_COLORLESS_ALTAR
	dw .PastFightingFort    ; OWMAP_GR_CASTLE

.NotPastFightingFort:
	jr .no_carry

.PastFightingFort:
	ld a, EVENT_CAN_TRAVEL_PAST_FIGHTING_FORT
	farcall GetEventValue
	jr nz, .no_carry
	jr .set_carry
.no_carry
	scf
	ccf
	ret
.set_carry
	scf
	ret

Func_30343:
	ld a, [wCurOWLocation]
	sla a
	sla a ; *4
	ld hl, Data_3056a
	add l
	ld l, a
	jr nc, .got_pointer
	inc h
.got_pointer
	ld a, [hli]
	ld [wd680], a
	ld a, [hli]
	ld [wOWScrollX], a
	ld a, [hl]
	ld [wOWScrollY], a
	ret

Func_3035f:
	sla a
	sla a ; *4
	ld hl, Data_3056a
	add l
	ld l, a
	jr nc, .got_pointer
	inc h
.got_pointer
	ld a, c
	ld [wOWScrollSpeed], a
	ld a, [hli]
	ld [wd680], a
	ld a, [hli]
	ld d, a
	ld a, [hl]
	ld e, a
	farcall Func_d56b

.loop_frame
	call DoFrame
	ld a, [wOWScrollSpeed]
	cp 2
	jr z, .speed_2
	cp 1
	jr z, .speed_1
; speed 3
	farcall Func_d62a
.speed_2
	farcall Func_d62a
.speed_1
	farcall Func_d62a
	jr c, .loop_frame
	ret

Func_30398:
	ld a, [wd680]
	cp 2
	jr z, .scroll_if_challenge_hall
	or a
	jr nz, .scroll_if_grass_or_fighting_fort
	ld a, [wCurOWLocation]
	cp OWMAP_GR_LIGHTNING_FORT
	jr nz, .done
	jr .scroll
.scroll_if_grass_or_fighting_fort
	ld a, [wCurOWLocation]
	cp OWMAP_GR_GRASS_FORT
	jr nz, .scroll_if_fighting_fort
	jr .scroll
.scroll_if_fighting_fort
	cp OWMAP_GR_FIGHTING_FORT
	jr nz, .done
	jr .scroll
.scroll_if_challenge_hall
	ld a, [wCurOWLocation]
	cp OWMAP_GR_CHALLENGE_HALL
	jr nz, .done
.scroll
	ld c, 2 ; speed
	call Func_3035f
.done
	ret

Func_303c7:
	ld a, [wCurOWLocation]
	cp OWMAP_GR_FIGHTING_FORT
	jr z, .fighting_fort
	sla a
	sla a ; *4
	ld hl, .data
	add l
	ld l, a
	jr nc, .got_pointer
	inc h
.got_pointer
	ld a, [hl] ; map
	inc hl
	ld d, [hl] ; x
	inc hl
	ld e, [hl] ; y
	inc hl
	ld b, [hl] ; direction
	farcall Func_d3c4
.done
	ret

; arrive at entrance if coming from south, at Kamiya's room if from north
.fighting_fort
	ld a, [wPlayerOWLocation]
	cp OWMAP_ISHIHARAS_VILLA
	jr z, .from_north
	cp OWMAP_GR_PSYCHIC_STRONGHOLD
	jr z, .from_north
	cp OWMAP_COLORLESS_ALTAR
	jr z, .from_north
	cp OWMAP_GR_CASTLE
	jr z, .from_north
	cp OWMAP_GR_FIGHTING_FORT
	jr nz, .from_south
	ld a, [wd584]
	cp MAP_FIGHTING_FORT
	jr z, .from_north
.from_south
	ld a, MAP_FIGHTING_FORT_ENTRANCE
	lb de, 4, 11
	ld b, NORTH
	farcall Func_d3c4
	jr .done
.from_north
	ld a, MAP_FIGHTING_FORT
	lb de, 7, 1
	ld b, SOUTH
	farcall Func_d3c4
	jr .done

.data
	db MAP_GR_AIRPORT_ENTRANCE,         5, 11, NORTH ; OWMAP_GR_AIRPORT
	db MAP_ISHIHARAS_VILLA_MAIN,        4,  9, NORTH ; OWMAP_ISHIHARAS_VILLA
	db MAP_GAME_CENTER_ENTRANCE,        5, 14, NORTH ; OWMAP_GAME_CENTER
	db MAP_SEALED_FORT_ENTRANCE,        5,  7, NORTH ; OWMAP_SEALED_FORT
	db MAP_GR_CHALLENGE_HALL_ENTRANCE,  4,  7, NORTH ; OWMAP_GR_CHALLENGE_HALL
	db MAP_GRASS_FORT_ENTRANCE,         4,  7, NORTH ; OWMAP_GR_GRASS_FORT
	db MAP_LIGHTNING_FORT_ENTRANCE,     4, 11, NORTH ; OWMAP_GR_LIGHTNING_FORT
	db MAP_FIRE_FORT_ENTRANCE,          4, 11, NORTH ; OWMAP_GR_FIRE_FORT
	db MAP_WATER_FORT_ENTRANCE,         4, 11, NORTH ; OWMAP_GR_WATER_FORT
	db MAP_FIGHTING_FORT_ENTRANCE,      4, 11, NORTH ; OWMAP_GR_FIGHTING_FORT
	db MAP_PSYCHIC_STRONGHOLD_ENTRANCE, 4,  7, NORTH ; OWMAP_GR_PSYCHIC_STRONGHOLD
	db MAP_COLORLESS_ALTAR_ENTRANCE,    4, 11, NORTH ; OWMAP_COLORLESS_ALTAR
	db MAP_GR_CASTLE_ENTRANCE,          5,  7, NORTH ; OWMAP_GR_CASTLE

Func_30452:
	ld a, [wPlayerOWObject]
	ld b, $01
	farcall _SetOWObjectAnimStruct1Flag2
	ld a, [wPlayerOWLocation]
	ld c, 3 ; speed
	call Func_3035f

	ld a, [wPlayerOWLocation]
	sla a ; *2
	ld hl, GRIslandMovementCommands
	add l
	ld l, a
	jr nc, .got_pointer1
	inc h
.got_pointer1
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, [wCurOWLocation]
	sla a ; *2
	add l
	ld l, a
	jr nc, .got_pointer2
	inc h
.got_pointer2
	ld a, [hli]
	ld h, [hl]
	ld l, a
	or h
	jp z, .finish_movement ; is null
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
	jr nz, .set_target_position
	ld a, e
	cp $ff
	jp z, .finish_movement
	jr .asm_304c0

.set_target_position
	push hl
	ld a, [wPlayerOWObject]
	farcall SetOWObjectTargetPosition
	jr .loop_wait_movement

.straight_line
	push hl
	ld a, [wCurOWLocation]
	sla a ; *2
	ld hl, GRIslandLocationPositions
	add l
	ld l, a
	jr nc, .got_pointer3
	inc h
.got_pointer3
	ld a, [hli]
	ld e, [hl]
	ld d, a
	ld a, [wPlayerOWObject]
	farcall SetOWObjectTargetPosition
	jr .loop_wait_movement

.asm_304c0
	push hl
	ld a, e
	sla a ; *2
	ld hl, .data
	add l
	ld l, a
	jr nc, .got_pointer4
	inc h
.got_pointer4
	ld a, [hli]
	ld e, [hl]
	ld d, a
	farcall Func_d56b
.loop_wait_camera
	call DoFrame
	ld hl, wd583
	bit 2, [hl]
	jr nz, .asm_304ed
	ldh a, [hKeysPressed]
	bit B_PAD_B, a
	jr z, .asm_304ed
	set 2, [hl]
	ld a, $01
	ld b, $00
	farcall StartPalFadeToBlackOrWhite
.asm_304ed
	farcall Func_d62a
	jr c, .asm_304f6
	pop hl
	jr .loop_commands
.asm_304f6
	ld a, [wd583]
	bit 2, a
	jr z, .loop_wait_camera
	farcall CheckPalFading
	jr nz, .loop_wait_camera
	pop hl
	jr .wait_fade

.loop_wait_movement
	call DoFrame
	ld hl, wd583
	bit 2, [hl]
	jr nz, .move_to_target_position
	ldh a, [hKeysPressed]
	bit B_PAD_B, a
	jr z, .move_to_target_position
	set 2, [hl]
	ld a, $01
	ld b, $00
	farcall StartPalFadeToBlackOrWhite
.move_to_target_position
	farcall MoveOWObjectToTargetPosition
	jr c, .asm_3052a
	pop hl
	jp .loop_commands
.asm_3052a
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

.data
	; x, y
	db $00, $60
	db $20, $30
	db $30, $00

GRIslandLocationPositions:
	; x, y
	db $18, $b0 ; OWMAP_GR_AIRPORT
	db $88, $08 ; OWMAP_ISHIHARAS_VILLA
	db $38, $c0 ; OWMAP_GAME_CENTER
	db $10, $80 ; OWMAP_SEALED_FORT
	db $68, $60 ; OWMAP_GR_CHALLENGE_HALL
	db $3c, $88 ; OWMAP_GR_GRASS_FORT
	db $56, $78 ; OWMAP_GR_LIGHTNING_FORT
	db $46, $40 ; OWMAP_GR_FIRE_FORT
	db $88, $88 ; OWMAP_GR_WATER_FORT
	db $80, $48 ; OWMAP_GR_FIGHTING_FORT
	db $98, $28 ; OWMAP_GR_PSYCHIC_STRONGHOLD
	db $b8, $40 ; OWMAP_COLORLESS_ALTAR
	db $aa, $10 ; OWMAP_GR_CASTLE

Data_3056a:
	db 0, $00, $60, $00 ; OWMAP_GR_AIRPORT
	db 2, $30, $00, $00 ; OWMAP_ISHIHARAS_VILLA
	db 0, $00, $60, $00 ; OWMAP_GAME_CENTER
	db 0, $00, $60, $00 ; OWMAP_SEALED_FORT
	db 1, $20, $30, $00 ; OWMAP_GR_CHALLENGE_HALL
	db 0, $00, $60, $00 ; OWMAP_GR_GRASS_FORT
	db 1, $20, $30, $00 ; OWMAP_GR_LIGHTNING_FORT
	db 1, $20, $30, $00 ; OWMAP_GR_FIRE_FORT
	db 1, $20, $30, $00 ; OWMAP_GR_WATER_FORT
	db 2, $30, $00, $00 ; OWMAP_GR_FIGHTING_FORT
	db 2, $30, $00, $00 ; OWMAP_GR_PSYCHIC_STRONGHOLD
	db 2, $30, $00, $00 ; OWMAP_COLORLESS_ALTAR
	db 2, $30, $00, $00 ; OWMAP_GR_CASTLE

GRIslandMovementCommands:
	dw .GRAirport           ; OWMAP_GR_AIRPORT
	dw .IshiharasVilla      ; OWMAP_ISHIHARAS_VILLA
	dw .GameCenter          ; OWMAP_GAME_CENTER
	dw .SealedFort          ; OWMAP_SEALED_FORT
	dw .GRChallengeHall     ; OWMAP_GR_CHALLENGE_HALL
	dw .GRGrassFort         ; OWMAP_GR_GRASS_FORT
	dw .GRLightningFort     ; OWMAP_GR_LIGHTNING_FORT
	dw .GRFireFort          ; OWMAP_GR_FIRE_FORT
	dw .GRWaterFort         ; OWMAP_GR_WATER_FORT
	dw .GRFightingFort      ; OWMAP_GR_FIGHTING_FORT
	dw .GRPsychicStronghold ; OWMAP_GR_PSYCHIC_STRONGHOLD
	dw .ColorlessAltar      ; OWMAP_COLORLESS_ALTAR
	dw .GRCastle            ; OWMAP_GR_CASTLE

.GRAirport:
	dw NULL ; OWMAP_GR_AIRPORT
	dw $470a ; OWMAP_ISHIHARAS_VILLA
	dw $4724 ; OWMAP_GAME_CENTER
	dw $472a ; OWMAP_SEALED_FORT
	dw $4732 ; OWMAP_GR_CHALLENGE_HALL
	dw $4740 ; OWMAP_GR_GRASS_FORT
	dw $4748 ; OWMAP_GR_LIGHTNING_FORT
	dw $4756 ; OWMAP_GR_FIRE_FORT
	dw $4768 ; OWMAP_GR_WATER_FORT
	dw $4778 ; OWMAP_GR_FIGHTING_FORT
	dw $478a ; OWMAP_GR_PSYCHIC_STRONGHOLD
	dw $47a0 ; OWMAP_COLORLESS_ALTAR
	dw $47bc ; OWMAP_GR_CASTLE

.IshiharasVilla:
	dw $47d4 ; OWMAP_GR_AIRPORT
	dw NULL ; OWMAP_ISHIHARAS_VILLA
	dw $47ee ; OWMAP_GAME_CENTER
	dw $480c ; OWMAP_SEALED_FORT
	dw $482a ; OWMAP_GR_CHALLENGE_HALL
	dw $4836 ; OWMAP_GR_GRASS_FORT
	dw $484a ; OWMAP_GR_LIGHTNING_FORT
	dw $4858 ; OWMAP_GR_FIRE_FORT
	dw $4868 ; OWMAP_GR_WATER_FORT
	dw $487a ; OWMAP_GR_FIGHTING_FORT
	dw $4884 ; OWMAP_GR_PSYCHIC_STRONGHOLD
	dw $488c ; OWMAP_COLORLESS_ALTAR
	dw $4896 ; OWMAP_GR_CASTLE

.GameCenter:
	dw $489e ; OWMAP_GR_AIRPORT
	dw $48a4 ; OWMAP_ISHIHARAS_VILLA
	dw NULL ; OWMAP_GAME_CENTER
	dw $48c0 ; OWMAP_SEALED_FORT
	dw $48cc ; OWMAP_GR_CHALLENGE_HALL
	dw $48de ; OWMAP_GR_GRASS_FORT
	dw $48ea ; OWMAP_GR_LIGHTNING_FORT
	dw $48fc ; OWMAP_GR_FIRE_FORT
	dw $4912 ; OWMAP_GR_WATER_FORT
	dw $4926 ; OWMAP_GR_FIGHTING_FORT
	dw $493c ; OWMAP_GR_PSYCHIC_STRONGHOLD
	dw $4956 ; OWMAP_COLORLESS_ALTAR
	dw $4976 ; OWMAP_GR_CASTLE

.SealedFort:
	dw $4992 ; OWMAP_GR_AIRPORT
	dw $499a ; OWMAP_ISHIHARAS_VILLA
	dw $49b6 ; OWMAP_GAME_CENTER
	dw NULL ; OWMAP_SEALED_FORT
	dw $49c2 ; OWMAP_GR_CHALLENGE_HALL
	dw $49d4 ; OWMAP_GR_GRASS_FORT
	dw $49e0 ; OWMAP_GR_LIGHTNING_FORT
	dw $49f2 ; OWMAP_GR_FIRE_FORT
	dw $4a08 ; OWMAP_GR_WATER_FORT
	dw $4a1c ; OWMAP_GR_FIGHTING_FORT
	dw $4a32 ; OWMAP_GR_PSYCHIC_STRONGHOLD
	dw $4a4c ; OWMAP_COLORLESS_ALTAR
	dw $4a6c ; OWMAP_GR_CASTLE

.GRChallengeHall:
	dw $4a88 ; OWMAP_GR_AIRPORT
	dw $4a98 ; OWMAP_ISHIHARAS_VILLA
	dw $4aa4 ; OWMAP_GAME_CENTER
	dw $4ab8 ; OWMAP_SEALED_FORT
	dw NULL ; OWMAP_GR_CHALLENGE_HALL
	dw $4acc ; OWMAP_GR_GRASS_FORT
	dw $50a4 ; OWMAP_GR_LIGHTNING_FORT
	dw $4ad6 ; OWMAP_GR_FIRE_FORT
	dw $4ade ; OWMAP_GR_WATER_FORT
	dw $4ae6 ; OWMAP_GR_FIGHTING_FORT
	dw $4aec ; OWMAP_GR_PSYCHIC_STRONGHOLD
	dw $4af6 ; OWMAP_COLORLESS_ALTAR
	dw $4b06 ; OWMAP_GR_CASTLE

.GRGrassFort:
	dw $4b12 ; OWMAP_GR_AIRPORT
	dw $4b1a ; OWMAP_ISHIHARAS_VILLA
	dw $4b2e ; OWMAP_GAME_CENTER
	dw $4b3a ; OWMAP_SEALED_FORT
	dw $4b46 ; OWMAP_GR_CHALLENGE_HALL
	dw NULL ; OWMAP_GR_GRASS_FORT
	dw $4b50 ; OWMAP_GR_LIGHTNING_FORT
	dw $4b5a ; OWMAP_GR_FIRE_FORT
	dw $4b68 ; OWMAP_GR_WATER_FORT
	dw $4b74 ; OWMAP_GR_FIGHTING_FORT
	dw $4b82 ; OWMAP_GR_PSYCHIC_STRONGHOLD
	dw $4b94 ; OWMAP_COLORLESS_ALTAR
	dw $4bac ; OWMAP_GR_CASTLE

.GRLightningFort:
	dw $4bc0 ; OWMAP_GR_AIRPORT
	dw $4bd0 ; OWMAP_ISHIHARAS_VILLA
	dw $4bdc ; OWMAP_GAME_CENTER
	dw $4bf0 ; OWMAP_SEALED_FORT
	dw $50a4 ; OWMAP_GR_CHALLENGE_HALL
	dw $4c04 ; OWMAP_GR_GRASS_FORT
	dw NULL ; OWMAP_GR_LIGHTNING_FORT
	dw $4c0e ; OWMAP_GR_FIRE_FORT
	dw $4c16 ; OWMAP_GR_WATER_FORT
	dw $4c1c ; OWMAP_GR_FIGHTING_FORT
	dw $4c24 ; OWMAP_GR_PSYCHIC_STRONGHOLD
	dw $4c30 ; OWMAP_COLORLESS_ALTAR
	dw $4c42 ; OWMAP_GR_CASTLE

.GRFireFort:
	dw $4c50 ; OWMAP_GR_AIRPORT
	dw $4c64 ; OWMAP_ISHIHARAS_VILLA
	dw $4c74 ; OWMAP_GAME_CENTER
	dw $4c8c ; OWMAP_SEALED_FORT
	dw $4ca4 ; OWMAP_GR_CHALLENGE_HALL
	dw $4cac ; OWMAP_GR_GRASS_FORT
	dw $4cba ; OWMAP_GR_LIGHTNING_FORT
	dw NULL ; OWMAP_GR_FIRE_FORT
	dw $4cc2 ; OWMAP_GR_WATER_FORT
	dw $4cd0 ; OWMAP_GR_FIGHTING_FORT
	dw $4cda ; OWMAP_GR_PSYCHIC_STRONGHOLD
	dw $4ce8 ; OWMAP_COLORLESS_ALTAR
	dw $4cfc ; OWMAP_GR_CASTLE

.GRWaterFort:
	dw $4d0c ; OWMAP_GR_AIRPORT
	dw $4d1e ; OWMAP_ISHIHARAS_VILLA
	dw $4d2e ; OWMAP_GAME_CENTER
	dw $4d44 ; OWMAP_SEALED_FORT
	dw $4d5a ; OWMAP_GR_CHALLENGE_HALL
	dw $4d62 ; OWMAP_GR_GRASS_FORT
	dw $4d6e ; OWMAP_GR_LIGHTNING_FORT
	dw $4d76 ; OWMAP_GR_FIRE_FORT
	dw NULL ; OWMAP_GR_WATER_FORT
	dw $4d84 ; OWMAP_GR_FIGHTING_FORT
	dw $4d8e ; OWMAP_GR_PSYCHIC_STRONGHOLD
	dw $4d9c ; OWMAP_COLORLESS_ALTAR
	dw $4db0 ; OWMAP_GR_CASTLE

.GRFightingFort:
	dw $4dc0 ; OWMAP_GR_AIRPORT
	dw $4dd4 ; OWMAP_ISHIHARAS_VILLA
	dw $4dde ; OWMAP_GAME_CENTER
	dw $4df6 ; OWMAP_SEALED_FORT
	dw $4e0e ; OWMAP_GR_CHALLENGE_HALL
	dw $4e14 ; OWMAP_GR_GRASS_FORT
	dw $4e22 ; OWMAP_GR_LIGHTNING_FORT
	dw $4e2a ; OWMAP_GR_FIRE_FORT
	dw $4e34 ; OWMAP_GR_WATER_FORT
	dw NULL ; OWMAP_GR_FIGHTING_FORT
	dw $4e40 ; OWMAP_GR_PSYCHIC_STRONGHOLD
	dw $4e48 ; OWMAP_COLORLESS_ALTAR
	dw $4e56 ; OWMAP_GR_CASTLE

.GRPsychicStronghold:
	dw $4e60 ; OWMAP_GR_AIRPORT
	dw $4e78 ; OWMAP_ISHIHARAS_VILLA
	dw $4e80 ; OWMAP_GAME_CENTER
	dw $4e9c ; OWMAP_SEALED_FORT
	dw $4eb8 ; OWMAP_GR_CHALLENGE_HALL
	dw $4ec2 ; OWMAP_GR_GRASS_FORT
	dw $4ed4 ; OWMAP_GR_LIGHTNING_FORT
	dw $4ee0 ; OWMAP_GR_FIRE_FORT
	dw $4eee ; OWMAP_GR_WATER_FORT
	dw $4efe ; OWMAP_GR_FIGHTING_FORT
	dw NULL ; OWMAP_GR_PSYCHIC_STRONGHOLD
	dw $4f06 ; OWMAP_COLORLESS_ALTAR
	dw $50a4 ; OWMAP_GR_CASTLE

.ColorlessAltar:
	dw $4f0e ; OWMAP_GR_AIRPORT
	dw $4f2c ; OWMAP_ISHIHARAS_VILLA
	dw $4f38 ; OWMAP_GAME_CENTER
	dw $4f5a ; OWMAP_SEALED_FORT
	dw $4f7c ; OWMAP_GR_CHALLENGE_HALL
	dw $4f8c ; OWMAP_GR_GRASS_FORT
	dw $4fa4 ; OWMAP_GR_LIGHTNING_FORT
	dw $4fb6 ; OWMAP_GR_FIRE_FORT
	dw $4fca ; OWMAP_GR_WATER_FORT
	dw $4fe0 ; OWMAP_GR_FIGHTING_FORT
	dw $4fee ; OWMAP_GR_PSYCHIC_STRONGHOLD
	dw NULL ; OWMAP_COLORLESS_ALTAR
	dw $4fee ; OWMAP_GR_CASTLE

.GRCastle:
	dw $4ff6 ; OWMAP_GR_AIRPORT
	dw $500e ; OWMAP_ISHIHARAS_VILLA
	dw $5016 ; OWMAP_GAME_CENTER
	dw $5032 ; OWMAP_SEALED_FORT
	dw $504e ; OWMAP_GR_CHALLENGE_HALL
	dw $5058 ; OWMAP_GR_GRASS_FORT
	dw $506a ; OWMAP_GR_LIGHTNING_FORT
	dw $5076 ; OWMAP_GR_FIRE_FORT
	dw $5084 ; OWMAP_GR_WATER_FORT
	dw $5094 ; OWMAP_GR_FIGHTING_FORT
	dw $50a4 ; OWMAP_GR_PSYCHIC_STRONGHOLD
	dw $509c ; OWMAP_COLORLESS_ALTAR
	dw NULL ; OWMAP_GR_CASTLE
; 0x3070a

SECTION "Bank c@518a", ROMX[$518a], BANK[$c]

CardDungeonQueen_MapHeader:
	db MAP_GFX_CARD_DUNGEON_QUEEN
	dba CardDungeonQueen_MapScripts
	db MUSIC_FORT_3

CardDungeonQueen_NPCs:
	npc NPC_QUEEN, 3, 4, EAST, NULL
	db $ff

CardDungeonQueen_NPCInteractions:
	npc_script NPC_QUEEN, $0c, $51d5
	db $ff

CardDungeonQueen_MapScripts:
	dbw $08, $51b1
	dbw $09, $51d0
	dbw $07, $51a8
	dbw $02, $51b9
	db $ff
; gap from 0x311a8 to 0x31324

SECTION "Bank c@5324", ROMX[$5324], BANK[$c]

SealedFortEntrance_MapHeader:
	db MAP_GFX_SEALED_FORT_ENTRANCE
	dba SealedFortEntrance_MapScripts
	db MUSIC_FORT_4

SealedFortEntrance_StepEvents:
	map_exit 4, 8, OVERWORLD_MAP_GR, 4, 4, SOUTH
	map_exit 5, 8, OVERWORLD_MAP_GR, 4, 4, SOUTH
	map_exit 6, 8, OVERWORLD_MAP_GR, 4, 4, SOUTH
	map_exit 4, 0, MAP_SEALED_FORT, 5, 11, NORTH
	map_exit 5, 0, MAP_SEALED_FORT, 6, 11, NORTH
	map_exit 6, 0, MAP_SEALED_FORT, 7, 11, NORTH
	db $ff

SealedFortEntrance_OWInteractions:
	ow_script 4, 1, $0c, $53bc
	ow_script 5, 1, $0c, $53bc
	ow_script 6, 1, $0c, $53bc
	db $ff

SealedFortEntrance_MapScripts:
	dbw $06, $5386
	dbw $08, $538d
	dbw $02, $53a8
	db $ff
; gap from 0x31386 to 0x313ce

SECTION "Bank c@53ce", ROMX[$53ce], BANK[$c]

GrChallengeHallEntrance_MapHeader:
	db MAP_GFX_GR_CHALLENGE_HALL_ENTRANCE
	dba GrChallengeHallEntrance_MapScripts
	db MUSIC_GROVERWORLD

GrChallengeHallEntrance_StepEvents:
	map_exit 4, 8, OVERWORLD_MAP_GR, 4, 4, SOUTH
	map_exit 5, 8, OVERWORLD_MAP_GR, 4, 4, SOUTH
	map_exit 0, 3, MAP_GR_CHALLENGE_HALL_LOBBY, 12, 6, WEST
	map_exit 0, 4, MAP_GR_CHALLENGE_HALL_LOBBY, 12, 7, WEST
	map_exit 4, 0, MAP_GR_CHALLENGE_HALL, 7, 14, NORTH
	map_exit 5, 0, MAP_GR_CHALLENGE_HALL, 8, 14, NORTH
	db $ff

GrChallengeHallEntrance_NPCs:
	npc NPC_GR_CLERK_CHALLENGE_HALL_ENTRANCE, 3, 1, SOUTH, NULL
	db $ff

GrChallengeHallEntrance_NPCInteractions:
	npc_script NPC_GR_CLERK_CHALLENGE_HALL_ENTRANCE, $0c, $54a1
	db $ff

GrChallengeHallEntrance_MapScripts:
	dbw $06, $5426
	dbw $08, $5499
	dbw $07, $5490
	dbw $01, $542d
	dbw $04, $5447
	db $ff
; gap from 0x31426 to 0x314fe

SECTION "Bank c@54fe", ROMX[$54fe], BANK[$c]

GrassFortEntrance_MapHeader:
	db MAP_GFX_GRASS_FORT_ENTRANCE
	dba GrassFortEntrance_MapScripts
	db MUSIC_FORT_1

GrassFortEntrance_StepEvents:
	map_exit 4, 8, OVERWORLD_MAP_GR, 4, 4, SOUTH
	map_exit 5, 8, OVERWORLD_MAP_GR, 4, 4, SOUTH
	map_exit 0, 3, MAP_GRASS_FORT_LOBBY, 12, 6, WEST
	map_exit 0, 4, MAP_GRASS_FORT_LOBBY, 12, 7, WEST
	map_exit 4, 0, MAP_GRASS_FORT_MIDORI, 5, 10, NORTH
	map_exit 5, 0, MAP_GRASS_FORT_MIDORI, 6, 10, NORTH
	db $ff

GrassFortEntrance_NPCs:
	npc NPC_GR_CLERK_GRASS_FORT, 3, 1, SOUTH, NULL
	db $ff

GrassFortEntrance_NPCInteractions:
	npc_script NPC_GR_CLERK_GRASS_FORT, $0c, $55ad
	db $ff

GrassFortEntrance_MapScripts:
	dbw $06, $556e
	dbw $08, $559f
	dbw $02, $557e
	dbw $09, $55a7
	dbw $07, $5575
	dbw $10, $5559
	db $ff
; gap from 0x31559 to 0x315d8

SECTION "Bank c@55d8", ROMX[$55d8], BANK[$c]

GrassFortLobby_MapHeader:
	db MAP_GFX_GRASS_FORT_LOBBY
	dba GrassFortLobby_MapScripts
	db MUSIC_FORT_1

GrassFortLobby_StepEvents:
	map_exit 13, 6, MAP_GRASS_FORT_ENTRANCE, 1, 3, EAST
	map_exit 13, 7, MAP_GRASS_FORT_ENTRANCE, 1, 4, EAST
	db $ff

GrassFortLobby_NPCs:
	npc NPC_GRASS_FORT_GR_GRUNT, 3, 4, SOUTH, NULL
	npc NPC_GRASS_FORT_GR_PAPPY, 3, 9, WEST, NULL
	npc NPC_GRASS_FORT_GR_LASS, 7, 7, NORTH, NULL
	npc NPC_IMAKUNI_RED, 12, 1, NORTH, $5776
	npc NPC_GR_CLERK_BATTLE_CENTER, 5, 2, SOUTH, NULL
	npc NPC_GR_CLERK_GIFT_CENTER, 8, 2, SOUTH, NULL
	db $ff

GrassFortLobby_NPCInteractions:
	npc_script NPC_GRASS_FORT_GR_GRUNT, $0c, $56b5
	npc_script NPC_GRASS_FORT_GR_PAPPY, $0c, $571f
	npc_script NPC_GRASS_FORT_GR_LASS, $0c, $5745
	npc_script NPC_IMAKUNI_RED, $0f, $44e0
	db $ff

GrassFortLobby_OWInteractions:
	ow_script 1, 2, PCMenu
	ow_script 2, 2, PCMenu
	ow_script 5, 4, $0f, $41d0
	ow_script 8, 4, $0f, $42d9
	db $ff

GrassFortLobby_MapScripts:
	dbw $06, $5673
	dbw $08, $5683
	dbw $09, $5693
	dbw $0b, $5699
	dbw $07, $567a
	dbw $10, $565e
	db $ff
; gap from 0x3165e to 0x31785

SECTION "Bank c@5785", ROMX[$5785], BANK[$c]

GrassFortMidori_MapHeader:
	db MAP_GFX_GRASS_FORT_MIDORI
	dba GrassFortMidori_MapScripts
	db MUSIC_FORT_1

GrassFortMidori_StepEvents:
	map_exit 5, 11, MAP_GRASS_FORT_ENTRANCE, 4, 1, SOUTH
	map_exit 6, 11, MAP_GRASS_FORT_ENTRANCE, 5, 1, SOUTH
	map_exit 5, 0, MAP_GRASS_FORT_YUTA, 4, 7, NORTH
	map_exit 6, 0, MAP_GRASS_FORT_YUTA, 5, 7, NORTH
	db $ff

GrassFortMidori_NPCs:
	npc NPC_MIDORI, 5, 4, SOUTH, NULL
	npc NPC_RICK, 6, 2, SOUTH, $5864
	db $ff

GrassFortMidori_NPCInteractions:
	npc_script NPC_MIDORI, $0c, $5871
	db $ff

GrassFortMidori_OWInteractions:
	ow_script 6, 4, $0c, $5835
	db $ff

GrassFortMidori_MapScripts:
	dbw $06, $57db
	dbw $08, $5815
	dbw $09, $5825
	dbw $02, $57eb
	dbw $07, $57e2
	db $ff
; gap from 0x317db to 0x31830

SECTION "Bank c@5830", ROMX[$5830], BANK[$c]

GrassFortMidori_AfterDuelScripts:
	npc_script NPC_MIDORI, $0c, $58e2
	db $ff
; gap from 0x31835 to 0x31973

SECTION "Bank c@5973", ROMX[$5973], BANK[$c]

GrassFortYuta_MapHeader:
	db MAP_GFX_GRASS_FORT_YUTA
	dba GrassFortYuta_MapScripts
	db MUSIC_FORT_1

GrassFortYuta_StepEvents:
	map_exit 4, 8, MAP_GRASS_FORT_MIDORI, 5, 1, SOUTH
	map_exit 5, 8, MAP_GRASS_FORT_MIDORI, 6, 1, SOUTH
	map_exit 4, 0, MAP_GRASS_FORT_MIYUKI, 5, 7, NORTH
	map_exit 5, 0, MAP_GRASS_FORT_MIYUKI, 6, 7, NORTH
	db $ff

GrassFortYuta_NPCs:
	npc NPC_YUTA, 4, 3, SOUTH, NULL
	db $ff

GrassFortYuta_NPCInteractions:
	npc_script NPC_YUTA, $0c, $5a12
	db $ff

GrassFortYuta_OWInteractions:
	ow_script 4, 1, $0c, $5ae1
	ow_script 5, 1, $0c, $5ae1
	db $ff

GrassFortYuta_MapScripts:
	dbw $06, $59cc
	dbw $08, $59f2
	dbw $09, $5a02
	dbw $02, $59dc
	dbw $07, $59d3
	db $ff
; gap from 0x319cc to 0x31a0d

SECTION "Bank c@5a0d", ROMX[$5a0d], BANK[$c]

GrassFortYuta_AfterDuelScripts:
	npc_script NPC_YUTA, $0c, $5aa7
	db $ff
; gap from 0x31a12 to 0x31b29

SECTION "Bank c@5b29", ROMX[$5b29], BANK[$c]

GrassFortMiyuki_MapHeader:
	db MAP_GFX_GRASS_FORT_MIYUKI
	dba GrassFortMiyuki_MapScripts
	db MUSIC_FORT_1

GrassFortMiyuki_StepEvents:
	map_exit 5, 8, MAP_GRASS_FORT_YUTA, 4, 1, SOUTH
	map_exit 6, 8, MAP_GRASS_FORT_YUTA, 5, 1, SOUTH
	map_exit 5, 0, MAP_GRASS_FORT_MORINO, 6, 14, NORTH
	map_exit 6, 0, MAP_GRASS_FORT_MORINO, 7, 14, NORTH
	db $ff

GrassFortMiyuki_NPCs:
	npc NPC_MIYUKI, 9, 5, EAST, NULL
	db $ff

GrassFortMiyuki_NPCInteractions:
	npc_script NPC_MIYUKI, $0c, $5bc8
	db $ff

GrassFortMiyuki_OWInteractions:
	ow_script 5, 1, $0c, $5ca8
	ow_script 6, 1, $0c, $5ca8
	db $ff

GrassFortMiyuki_MapScripts:
	dbw $06, $5b82
	dbw $08, $5ba8
	dbw $09, $5bb8
	dbw $07, $5b89
	dbw $02, $5b92
	db $ff
; gap from 0x31b82 to 0x31bc3

SECTION "Bank c@5bc3", ROMX[$5bc3], BANK[$c]

GrassFortMiyuki_AfterDuelScripts:
	npc_script NPC_MIYUKI, $0c, $5c37
	db $ff
; gap from 0x31bc8 to 0x31cbf

SECTION "Bank c@5cbf", ROMX[$5cbf], BANK[$c]

LightningFortEntrance_MapHeader:
	db MAP_GFX_LIGHTNING_FORT_ENTRANCE
	dba LightningFortEntrance_MapScripts
	db MUSIC_FORT_2

LightningFortEntrance_StepEvents:
	map_exit 4, 12, OVERWORLD_MAP_GR, 4, 4, SOUTH
	map_exit 5, 12, OVERWORLD_MAP_GR, 4, 4, SOUTH
	map_exit 0, 3, MAP_LIGHTNING_FORT_LOBBY, 12, 6, WEST
	map_exit 0, 4, MAP_LIGHTNING_FORT_LOBBY, 12, 7, WEST
	map_exit 4, 0, MAP_LIGHTNING_FORT_RENNA, 4, 7, NORTH
	map_exit 5, 0, MAP_LIGHTNING_FORT_RENNA, 5, 7, NORTH
	db $ff

LightningFortEntrance_NPCs:
	npc NPC_GR_CLERK_LIGHTNING_FORT, 3, 2, SOUTH, NULL
	db $ff

LightningFortEntrance_NPCInteractions:
	npc_script NPC_GR_CLERK_LIGHTNING_FORT, $0c, $5d6e
	db $ff

LightningFortEntrance_OWInteractions:
	ow_script 4, 8, $0c, $5da0
	ow_script 5, 8, $0c, $5da0
	db $ff

LightningFortEntrance_MapScripts:
	dbw $06, $5d27
	dbw $08, $5d5e
	dbw $07, $5d2e
	dbw $02, $5d37
	db $ff
; gap from 0x31d27 to 0x31dd2

SECTION "Bank c@5dd2", ROMX[$5dd2], BANK[$c]

LightningFortLobby_MapHeader:
	db MAP_GFX_LIGHTNING_FORT_LOBBY
	dba LightningFortLobby_MapScripts
	db MUSIC_FORT_2

LightningFortLobby_StepEvents:
	map_exit 13, 6, MAP_LIGHTNING_FORT_ENTRANCE, 1, 3, EAST
	map_exit 13, 7, MAP_LIGHTNING_FORT_ENTRANCE, 1, 4, EAST
	db $ff

LightningFortLobby_NPCs:
	npc NPC_LIGHTNING_FORT_GR_LASS, 5, 10, NORTH, NULL
	npc NPC_LIGHTNING_FORT_GR_WOMAN, 3, 4, WEST, NULL
	npc NPC_LIGHTNING_FORT_CHUBBY_KID, 10, 8, SOUTH, NULL
	npc NPC_TAP, 8, 9, WEST, NULL
	npc NPC_GR_CLERK_BATTLE_CENTER, 5, 2, SOUTH, NULL
	npc NPC_GR_CLERK_GIFT_CENTER, 8, 2, SOUTH, NULL
	db $ff

LightningFortLobby_NPCInteractions:
	npc_script NPC_LIGHTNING_FORT_GR_LASS, $0c, $5e82
	npc_script NPC_LIGHTNING_FORT_GR_WOMAN, $0c, $5ee8
	npc_script NPC_LIGHTNING_FORT_CHUBBY_KID, $0c, $5f2c
	npc_script NPC_TAP, $0c, $5f52
	db $ff

LightningFortLobby_OWInteractions:
	ow_script 1, 2, PCMenu
	ow_script 2, 2, PCMenu
	ow_script 5, 4, $0f, $41d0
	ow_script 8, 4, $0f, $42d9
	db $ff

LightningFortLobby_MapScripts:
	dbw $06, $5e52
	dbw $08, $5e62
	dbw $09, $5e72
	dbw $07, $5e59
	db $ff
; gap from 0x31e52 to 0x31e7d

SECTION "Bank c@5e7d", ROMX[$5e7d], BANK[$c]

LightningFortLobby_AfterDuelScripts:
	npc_script NPC_TAP, $0c, $5f8f
	db $ff
; gap from 0x31e82 to 0x31fad

SECTION "Bank c@5fad", ROMX[$5fad], BANK[$c]

LightningFortRenna_MapHeader:
	db MAP_GFX_LIGHTNING_FORT_RENNA
	dba LightningFortRenna_MapScripts
	db MUSIC_FORT_2

LightningFortRenna_StepEvents:
	map_exit 4, 8, MAP_LIGHTNING_FORT_ENTRANCE, 4, 1, SOUTH
	map_exit 5, 8, MAP_LIGHTNING_FORT_ENTRANCE, 5, 1, SOUTH
	map_exit 4, 0, MAP_LIGHTNING_FORT_ICHIKAWA, 4, 10, NORTH
	map_exit 5, 0, MAP_LIGHTNING_FORT_ICHIKAWA, 5, 10, NORTH
	db $ff

LightningFortRenna_NPCs:
	npc NPC_RENNA, 1, 2, NORTH, NULL
	db $ff

LightningFortRenna_NPCInteractions:
	npc_script NPC_RENNA, $0c, $6057
	db $ff

LightningFortRenna_OWInteractions:
	ow_script 4, 1, $0c, $60f5
	ow_script 5, 1, $0c, $60f5
	db $ff

LightningFortRenna_MapScripts:
	dbw $06, $6006
	dbw $08, $6037
	dbw $09, $6047
	dbw $07, $600d
	dbw $02, $6016
	db $ff
; gap from 0x32006 to 0x32052

SECTION "Bank c@6052", ROMX[$6052], BANK[$c]

LightningFortRenna_AfterDuelScripts:
	npc_script NPC_RENNA, $0c, $60bb
	db $ff
; gap from 0x32057 to 0x32148

SECTION "Bank c@6148", ROMX[$6148], BANK[$c]

LightningFortIchikawa_MapHeader:
	db MAP_GFX_LIGHTNING_FORT_ICHIKAWA
	dba LightningFortIchikawa_MapScripts
	db MUSIC_FORT_2

LightningFortIchikawa_StepEvents:
	map_exit 4, 11, MAP_LIGHTNING_FORT_RENNA, 4, 1, SOUTH
	map_exit 5, 11, MAP_LIGHTNING_FORT_RENNA, 5, 1, SOUTH
	map_exit 4, 0, MAP_LIGHTNING_FORT_CATHERINE, 7, 10, NORTH
	map_exit 5, 0, MAP_LIGHTNING_FORT_CATHERINE, 8, 10, NORTH
	db $ff

LightningFortIchikawa_NPCs:
	npc NPC_ICHIKAWA, 5, 5, EAST, NULL
	db $ff

LightningFortIchikawa_NPCInteractions:
	npc_script NPC_ICHIKAWA, $0c, $6204
	db $ff

LightningFortIchikawa_OWInteractions:
	ow_script 4, 1, $0c, $63f0
	ow_script 5, 1, $0c, $63f0
	ow_script 3, 3, $0c, $6407
	db $ff

LightningFortIchikawa_MapScripts:
	dbw $06, $61aa
	dbw $08, $61e4
	dbw $09, $61f4
	dbw $07, $61b1
	dbw $02, $61ba
	db $ff
; gap from 0x321aa to 0x321ff

SECTION "Bank c@61ff", ROMX[$61ff], BANK[$c]

LightningFortIchikawa_AfterDuelScripts:
	npc_script NPC_ICHIKAWA, $0c, $62a1
	db $ff
; gap from 0x32204 to 0x3241e

SECTION "Bank c@641e", ROMX[$641e], BANK[$c]

LightningFortCatherine_MapHeader:
	db MAP_GFX_LIGHTNING_FORT_CATHERINE
	dba LightningFortCatherine_MapScripts
	db MUSIC_FORT_2

LightningFortCatherine_StepEvents:
	map_exit 7, 11, MAP_LIGHTNING_FORT_ICHIKAWA, 4, 1, SOUTH
	map_exit 8, 11, MAP_LIGHTNING_FORT_ICHIKAWA, 5, 1, SOUTH
	db $ff

LightningFortCatherine_NPCs:
	npc NPC_CATHERINE, 7, 4, NORTH, NULL
	db $ff

LightningFortCatherine_NPCInteractions:
	npc_script NPC_CATHERINE, $0c, $6477
	db $ff

LightningFortCatherine_MapScripts:
	dbw $06, $644f
	dbw $08, $645f
	dbw $09, $6467
	dbw $07, $6456
	db $ff
; gap from 0x3244f to 0x32472

SECTION "Bank c@6472", ROMX[$6472], BANK[$c]

LightningFortCatherine_AfterDuelScripts:
	npc_script NPC_CATHERINE, $0c, $64e1
	db $ff
; gap from 0x32477 to 0x32531

SECTION "Bank c@6531", ROMX[$6531], BANK[$c]

FireFortEntrance_MapHeader:
	db MAP_GFX_FIRE_FORT_ENTRANCE
	dba FireFortEntrance_MapScripts
	db MUSIC_FORT_3

FireFortEntrance_StepEvents:
	map_exit 4, 12, OVERWORLD_MAP_GR, 4, 4, SOUTH
	map_exit 5, 12, OVERWORLD_MAP_GR, 4, 4, SOUTH
	map_exit 0, 3, MAP_FIRE_FORT_LOBBY, 12, 6, WEST
	map_exit 0, 4, MAP_FIRE_FORT_LOBBY, 12, 7, WEST
	map_exit 4, 0, MAP_FIRE_FORT_JES, 4, 8, NORTH
	map_exit 5, 0, MAP_FIRE_FORT_JES, 5, 8, NORTH
	db $ff

FireFortEntrance_NPCs:
	npc NPC_GR_CLERK_FIRE_FORT, 3, 1, SOUTH, NULL
	db $ff

FireFortEntrance_NPCInteractions:
	npc_script NPC_GR_CLERK_FIRE_FORT, $0c, $6632
	db $ff

FireFortEntrance_OWInteractions:
	ow_script 4, 8, $0c, $6664
	ow_script 5, 8, $0c, $6664
	db $ff

FireFortEntrance_MapScripts:
	dbw $06, $65bc
	dbw $08, $661c
	dbw $07, $65c3
	dbw $02, $65cc
	dbw $09, $662c
	dbw $10, $659f
	db $ff
; gap from 0x3259f to 0x32696

SECTION "Bank c@6696", ROMX[$6696], BANK[$c]

FireFortLobby_MapHeader:
	db MAP_GFX_FIRE_FORT_LOBBY
	dba FireFortLobby_MapScripts
	db MUSIC_FORT_3

FireFortLobby_StepEvents:
	map_exit 13, 6, MAP_FIRE_FORT_ENTRANCE, 1, 3, EAST
	map_exit 13, 7, MAP_FIRE_FORT_ENTRANCE, 1, 4, EAST
	db $ff

FireFortLobby_NPCs:
	npc NPC_FIRE_FORT_GRAMPY, 2, 10, SOUTH, NULL
	npc NPC_FIRE_FORT_YOUNGSTER, 7, 6, WEST, NULL
	npc NPC_IMAKUNI_RED, 12, 1, NORTH, $67f5
	npc NPC_GR_CLERK_BATTLE_CENTER, 5, 2, SOUTH, NULL
	npc NPC_GR_CLERK_GIFT_CENTER, 8, 2, SOUTH, NULL
	db $ff

FireFortLobby_NPCInteractions:
	npc_script NPC_FIRE_FORT_GRAMPY, $0c, $6769
	npc_script NPC_FIRE_FORT_YOUNGSTER, $0c, $67cf
	npc_script NPC_IMAKUNI_RED, $0f, $44e0
	db $ff

FireFortLobby_OWInteractions:
	ow_script 1, 2, PCMenu
	ow_script 2, 2, PCMenu
	ow_script 5, 4, $0f, $41d0
	ow_script 8, 4, $0f, $42d9
	db $ff

FireFortLobby_MapScripts:
	dbw $06, $6727
	dbw $08, $6737
	dbw $09, $6747
	dbw $0b, $674d
	dbw $07, $672e
	dbw $10, $6712
	db $ff
; gap from 0x32712 to 0x32804

SECTION "Bank c@6804", ROMX[$6804], BANK[$c]

FireFortJes_MapHeader:
	db MAP_GFX_FIRE_FORT_JES
	dba FireFortJes_MapScripts
	db MUSIC_FORT_3

FireFortJes_StepEvents:
	map_exit 4, 9, MAP_FIRE_FORT_ENTRANCE, 4, 1, SOUTH
	map_exit 5, 9, MAP_FIRE_FORT_ENTRANCE, 5, 1, SOUTH
	map_exit 4, 0, MAP_FIRE_FORT_YUKI, 5, 12, NORTH
	map_exit 5, 0, MAP_FIRE_FORT_YUKI, 6, 12, NORTH
	db $ff

FireFortJes_NPCs:
	npc NPC_JES, 6, 2, NORTH, NULL
	db $ff

FireFortJes_NPCInteractions:
	npc_script NPC_JES, $0c, $68ae
	db $ff

FireFortJes_OWInteractions:
	ow_script 4, 1, $0c, $6956
	ow_script 5, 1, $0c, $6956
	db $ff

FireFortJes_MapScripts:
	dbw $06, $685d
	dbw $08, $688e
	dbw $09, $689e
	dbw $07, $6864
	dbw $02, $686d
	db $ff
; gap from 0x3285d to 0x328a9

SECTION "Bank c@68a9", ROMX[$68a9], BANK[$c]

FireFortJes_AfterDuelScripts:
	npc_script NPC_JES, $0c, $6907
	db $ff
; gap from 0x328ae to 0x3296d

SECTION "Bank c@696d", ROMX[$696d], BANK[$c]

FireFortYuki_MapHeader:
	db MAP_GFX_FIRE_FORT_YUKI
	dba FireFortYuki_MapScripts
	db MUSIC_FORT_3

FireFortYuki_StepEvents:
	map_exit 5, 13, MAP_FIRE_FORT_JES, 4, 1, SOUTH
	map_exit 6, 13, MAP_FIRE_FORT_JES, 5, 1, SOUTH
	map_exit 5, 0, MAP_FIRE_FORT_SHOKO, 4, 14, NORTH
	map_exit 6, 0, MAP_FIRE_FORT_SHOKO, 5, 14, NORTH
	db $ff

FireFortYuki_NPCs:
	npc NPC_YUKI, 5, 3, SOUTH, NULL
	db $ff

FireFortYuki_NPCInteractions:
	npc_script NPC_YUKI, $0c, $6a76
	db $ff

FireFortYuki_OWInteractions:
	ow_script 5, 1, $0c, $6bd4
	ow_script 6, 1, $0c, $6bd4
	db $ff

FireFortYuki_MapScripts:
	dbw $06, $69c6
	dbw $08, $6a18
	dbw $09, $6a28
	dbw $07, $69cd
	dbw $02, $69d6
	db $ff
; gap from 0x329c6 to 0x32a33

SECTION "Bank c@6a33", ROMX[$6a33], BANK[$c]

FireFortYuki_AfterDuelScripts:
	npc_script NPC_YUKI, $0c, $6b43
	db $ff
; gap from 0x32a38 to 0x32beb

SECTION "Bank c@6beb", ROMX[$6beb], BANK[$c]

FireFortShoko_MapHeader:
	db MAP_GFX_FIRE_FORT_SHOKO
	dba FireFortShoko_MapScripts
	db MUSIC_FORT_3

FireFortShoko_StepEvents:
	map_exit 4, 15, MAP_FIRE_FORT_YUKI, 5, 1, SOUTH
	map_exit 5, 15, MAP_FIRE_FORT_YUKI, 6, 1, SOUTH
	map_exit 4, 0, MAP_FIRE_FORT_HIDERO, 5, 14, NORTH
	map_exit 5, 0, MAP_FIRE_FORT_HIDERO, 6, 14, NORTH
	db $ff

FireFortShoko_NPCs:
	npc NPC_SHOKO, 3, 4, EAST, NULL
	npc NPC_COURTNEY, 3, 7, SOUTH, $6d82
	db $ff

FireFortShoko_NPCInteractions:
	npc_script NPC_SHOKO, $0c, $6c9a
	db $ff

FireFortShoko_OWInteractions:
	ow_script 4, 1, $0c, $6d59
	ow_script 5, 1, $0c, $6d59
	db $ff

FireFortShoko_MapScripts:
	dbw $06, $6c4a
	dbw $08, $6c7a
	dbw $09, $6c8a
	dbw $07, $6c51
	dbw $02, $6c5a
	db $ff
; gap from 0x32c4a to 0x32c95

SECTION "Bank c@6c95", ROMX[$6c95], BANK[$c]

FireFortShoko_AfterDuelScripts:
	npc_script NPC_SHOKO, $0c, $6d1f
	db $ff
; gap from 0x32c9a to 0x32e20

SECTION "Bank c@6e20", ROMX[$6e20], BANK[$c]

FireFortHidero_MapHeader:
	db MAP_GFX_FIRE_FORT_HIDERO
	dba FireFortHidero_MapScripts
	db MUSIC_FORT_3

FireFortHidero_StepEvents:
	map_exit 5, 15, MAP_FIRE_FORT_SHOKO, 4, 1, SOUTH
	map_exit 6, 15, MAP_FIRE_FORT_SHOKO, 5, 1, SOUTH
	db $ff

FireFortHidero_NPCs:
	npc NPC_HIDERO, 6, 5, SOUTH, NULL
	db $ff

FireFortHidero_NPCInteractions:
	npc_script NPC_HIDERO, $0c, $6e79
	db $ff

FireFortHidero_MapScripts:
	dbw $06, $6e51
	dbw $08, $6e61
	dbw $09, $6e69
	dbw $07, $6e58
	db $ff
; gap from 0x32e51 to 0x32e74

SECTION "Bank c@6e74", ROMX[$6e74], BANK[$c]

FireFortHidero_AfterDuelScripts:
	npc_script NPC_HIDERO, $0c, $6efd
	db $ff
; gap from 0x32e79 to 0x32f5b

SECTION "Bank c@6f5b", ROMX[$6f5b], BANK[$c]

WaterFortEntrance_MapHeader:
	db MAP_GFX_WATER_FORT_ENTRANCE
	dba WaterFortEntrance_MapScripts
	db MUSIC_FORT_1

WaterFortEntrance_StepEvents:
	map_exit 4, 12, OVERWORLD_MAP_GR, 4, 4, SOUTH
	map_exit 5, 12, OVERWORLD_MAP_GR, 4, 4, SOUTH
	map_exit 0, 3, MAP_WATER_FORT_LOBBY, 12, 6, WEST
	map_exit 0, 4, MAP_WATER_FORT_LOBBY, 12, 7, WEST
	map_exit 4, 0, MAP_WATER_FORT_MIYAJIMA, 4, 9, NORTH
	map_exit 5, 0, MAP_WATER_FORT_MIYAJIMA, 5, 9, NORTH
	db $ff

WaterFortEntrance_NPCs:
	npc NPC_GR_CLERK_WATER_FORT, 3, 1, SOUTH, NULL
	db $ff

WaterFortEntrance_NPCInteractions:
	npc_script NPC_GR_CLERK_WATER_FORT, $0c, $705c
	db $ff

WaterFortEntrance_OWInteractions:
	ow_script 4, 8, $0c, $708e
	ow_script 5, 8, $0c, $708e
	db $ff

WaterFortEntrance_MapScripts:
	dbw $06, $6fe6
	dbw $08, $7046
	dbw $07, $6fed
	dbw $02, $6ff6
	dbw $09, $7056
	dbw $10, $6fc9
	db $ff
; gap from 0x32fc9 to 0x330c0

SECTION "Bank c@70c0", ROMX[$70c0], BANK[$c]

WaterFortMiyajima_MapHeader:
	db MAP_GFX_WATER_FORT_MIYAJIMA
	dba WaterFortMiyajima_MapScripts
	db MUSIC_FORT_1

WaterFortMiyajima_StepEvents:
	map_exit 4, 10, MAP_WATER_FORT_ENTRANCE, 4, 1, SOUTH
	map_exit 5, 10, MAP_WATER_FORT_ENTRANCE, 5, 1, SOUTH
	map_exit 4, 0, MAP_WATER_FORT_SENTA, 6, 10, NORTH
	map_exit 5, 0, MAP_WATER_FORT_SENTA, 7, 10, NORTH
	db $ff

WaterFortMiyajima_NPCs:
	npc NPC_MIYAJIMA, 4, 4, SOUTH, NULL
	db $ff

WaterFortMiyajima_NPCInteractions:
	npc_script NPC_MIYAJIMA, $0c, $716a
	db $ff

WaterFortMiyajima_OWInteractions:
	ow_script 4, 1, $0c, $7236
	ow_script 5, 1, $0c, $7236
	db $ff

WaterFortMiyajima_MapScripts:
	dbw $06, $7119
	dbw $08, $714a
	dbw $09, $715a
	dbw $07, $7120
	dbw $02, $7129
	db $ff
; gap from 0x33119 to 0x33165

SECTION "Bank c@7165", ROMX[$7165], BANK[$c]

WaterFortMiyajima_AfterDuelScripts:
	npc_script NPC_MIYAJIMA, $0c, $71d9
	db $ff
; gap from 0x3316a to 0x3324d

SECTION "Bank c@724d", ROMX[$724d], BANK[$c]

WaterFortKanoko_MapHeader:
	db MAP_GFX_WATER_FORT_KANOKO
	dba WaterFortKanoko_MapScripts
	db MUSIC_FORT_1

WaterFortKanoko_StepEvents:
	map_exit 6, 13, MAP_WATER_FORT_AIRA, 4, 1, SOUTH
	map_exit 7, 13, MAP_WATER_FORT_AIRA, 5, 1, SOUTH
	db $ff

WaterFortKanoko_NPCs:
	npc NPC_KANOKO, 6, 4, SOUTH, NULL
	db $ff

WaterFortKanoko_NPCInteractions:
	npc_script NPC_KANOKO, $0c, $72a6
	db $ff

WaterFortKanoko_MapScripts:
	dbw $06, $727e
	dbw $08, $728e
	dbw $09, $7296
	dbw $07, $7285
	db $ff
; gap from 0x3327e to 0x332a1

SECTION "Bank c@72a1", ROMX[$72a1], BANK[$c]

WaterFortKanoko_AfterDuelScripts:
	npc_script NPC_KANOKO, $0c, $72ff
	db $ff
; gap from 0x332a6 to 0x33357

SECTION "Bank c@7357", ROMX[$7357], BANK[$c]

FightingFortEntrance_MapHeader:
	db MAP_GFX_FIGHTING_FORT_ENTRANCE
	dba FightingFortEntrance_MapScripts
	db MUSIC_FORT_3

FightingFortEntrance_StepEvents:
	map_exit 4, 12, OVERWORLD_MAP_GR, 4, 4, SOUTH
	map_exit 5, 12, OVERWORLD_MAP_GR, 4, 4, SOUTH
	map_exit 4, 0, MAP_FIGHTING_FORT, 7, 7, NORTH
	map_exit 5, 0, MAP_FIGHTING_FORT, 8, 7, NORTH
	db $ff

FightingFortEntrance_NPCs:
	npc NPC_GR_CLERK_FIGHTING_FORT, 3, 2, SOUTH, NULL
	db $ff

FightingFortEntrance_NPCInteractions:
	npc_script NPC_GR_CLERK_FIGHTING_FORT, $0c, $7434
	db $ff

FightingFortEntrance_OWInteractions:
	ow_script 4, 8, $0c, $7470
	ow_script 5, 8, $0c, $74b3
	db $ff

FightingFortEntrance_MapScripts:
	dbw $06, $73ad
	dbw $08, $7424
	dbw $07, $73b4
	dbw $02, $73bd
	db $ff
; gap from 0x333ad to 0x33506

SECTION "Bank c@7506", ROMX[$7506], BANK[$c]

FightingFortMaze2_MapHeader:
	db MAP_GFX_FIGHTING_FORT_MAZE_2
	dba FightingFortMaze2_MapScripts
	db MUSIC_FORT_3

FightingFortMaze2_StepEvents:
	map_exit 4, 0, MAP_FIGHTING_FORT_MAZE_7, 4, 7, NORTH
	map_exit 5, 0, MAP_FIGHTING_FORT_MAZE_7, 5, 7, NORTH
	map_exit 0, 3, MAP_FIGHTING_FORT_MAZE_1, 8, 3, WEST
	map_exit 0, 4, MAP_FIGHTING_FORT_MAZE_1, 8, 4, WEST
	_ow_coordinate_function 3, 3, 104, 10, 1, 2, $0c, $75c7
	_ow_coordinate_function 3, 4, 104, 10, 1, 2, $0c, $75c7
	db $ff

FightingFortMaze2_NPCs:
	npc NPC_CHEST_CLOSED, 5, 2, SOUTH, $75a2
	npc NPC_CHEST_OPENED, 5, 2, SOUTH, $75ba
	db $ff

FightingFortMaze2_NPCInteractions:
	npc_script NPC_CHEST_CLOSED, $0c, $7589
	npc_script NPC_CHEST_OPENED, $0c, $75af
	db $ff

FightingFortMaze2_MapScripts:
	dbw $06, $7565
	dbw $08, $7581
	dbw $07, $7578
	dbw $0f, $756c
	db $ff
; gap from 0x33565 to 0x335da

SECTION "Bank c@75da", ROMX[$75da], BANK[$c]

FightingFortMaze3_MapHeader:
	db MAP_GFX_FIGHTING_FORT_MAZE_3
	dba FightingFortMaze3_MapScripts
	db MUSIC_FORT_3

FightingFortMaze3_StepEvents:
	map_exit 4, 8, MAP_FIGHTING_FORT, 12, 2, SOUTH
	map_exit 5, 8, MAP_FIGHTING_FORT, 12, 2, SOUTH
	map_exit 4, 0, MAP_FIGHTING_FORT_MAZE_8, 4, 7, NORTH
	map_exit 5, 0, MAP_FIGHTING_FORT_MAZE_8, 5, 7, NORTH
	map_exit 9, 3, MAP_FIGHTING_FORT_MAZE_4, 1, 3, EAST
	map_exit 9, 4, MAP_FIGHTING_FORT_MAZE_4, 1, 4, EAST
	db $ff

FightingFortMaze3_MapScripts:
	dbw $06, $761d
	dbw $02, $7624
	db $ff
; gap from 0x3361d to 0x3362f

SECTION "Bank c@762f", ROMX[$762f], BANK[$c]

FightingFortMaze4_MapHeader:
	db MAP_GFX_FIGHTING_FORT_MAZE_4
	dba FightingFortMaze4_MapScripts
	db MUSIC_FORT_3

FightingFortMaze4_StepEvents:
	map_exit 0, 3, MAP_FIGHTING_FORT_MAZE_3, 8, 3, WEST
	map_exit 0, 4, MAP_FIGHTING_FORT_MAZE_3, 8, 4, WEST
	map_exit 4, 0, MAP_FIGHTING_FORT_MAZE_9, 4, 7, NORTH
	map_exit 5, 0, MAP_FIGHTING_FORT_MAZE_9, 5, 7, NORTH
	map_exit 9, 3, MAP_FIGHTING_FORT_MAZE_5, 1, 3, EAST
	map_exit 9, 4, MAP_FIGHTING_FORT_MAZE_5, 1, 4, EAST
	_ow_coordinate_function 2, 3, 104, 10, 1, 2, $0c, $7710
	_ow_coordinate_function 2, 4, 104, 10, 1, 2, $0c, $7710
	db $ff

FightingFortMaze4_NPCs:
	npc NPC_CHEST_CLOSED, 3, 3, SOUTH, $76eb
	npc NPC_CHEST_OPENED, 3, 3, SOUTH, $7703
	db $ff

FightingFortMaze4_NPCInteractions:
	npc_script NPC_CHEST_CLOSED, $0c, $76d2
	npc_script NPC_CHEST_OPENED, $0c, $76f8
	db $ff

FightingFortMaze4_MapScripts:
	dbw $06, $76a3
	dbw $08, $76ca
	dbw $07, $76c1
	dbw $0f, $76aa
	dbw $02, $76b6
	db $ff
; gap from 0x336a3 to 0x33723

SECTION "Bank c@7723", ROMX[$7723], BANK[$c]

FightingFortMaze5_MapHeader:
	db MAP_GFX_FIGHTING_FORT_MAZE_5
	dba FightingFortMaze5_MapScripts
	db MUSIC_FORT_3

FightingFortMaze5_StepEvents:
	map_exit 0, 3, MAP_FIGHTING_FORT_MAZE_4, 8, 3, WEST
	map_exit 0, 4, MAP_FIGHTING_FORT_MAZE_4, 8, 4, WEST
	map_exit 4, 0, MAP_FIGHTING_FORT_GRACE, 4, 9, NORTH
	map_exit 5, 0, MAP_FIGHTING_FORT_GRACE, 5, 9, NORTH
	db $ff

FightingFortMaze5_MapScripts:
	dbw $06, $7754
	dbw $02, $775b
	db $ff
; gap from 0x33754 to 0x33766

SECTION "Bank c@7766", ROMX[$7766], BANK[$c]

FightingFortMaze6_MapHeader:
	db MAP_GFX_FIGHTING_FORT_MAZE_6
	dba FightingFortMaze6_MapScripts
	db MUSIC_FORT_3

FightingFortMaze6_StepEvents:
	map_exit 4, 8, MAP_FIGHTING_FORT_MAZE_1, 4, 1, SOUTH
	map_exit 5, 8, MAP_FIGHTING_FORT_MAZE_1, 5, 1, SOUTH
	map_exit 4, 0, MAP_FIGHTING_FORT_MAZE_11, 4, 7, NORTH
	map_exit 5, 0, MAP_FIGHTING_FORT_MAZE_11, 5, 7, NORTH
	map_exit 9, 3, MAP_FIGHTING_FORT_MAZE_7, 1, 3, EAST
	map_exit 9, 4, MAP_FIGHTING_FORT_MAZE_7, 1, 4, EAST
	db $ff

FightingFortMaze6_MapScripts:
	dbw $06, $77a9
	dbw $02, $77b0
	db $ff
; gap from 0x337a9 to 0x337bb

SECTION "Bank c@77bb", ROMX[$77bb], BANK[$c]

FightingFortMaze7_MapHeader:
	db MAP_GFX_FIGHTING_FORT_MAZE_7
	dba FightingFortMaze7_MapScripts
	db MUSIC_FORT_3

FightingFortMaze7_StepEvents:
	map_exit 4, 8, MAP_FIGHTING_FORT_MAZE_2, 4, 1, SOUTH
	map_exit 5, 8, MAP_FIGHTING_FORT_MAZE_2, 5, 1, SOUTH
	map_exit 4, 0, MAP_FIGHTING_FORT_MAZE_12, 4, 7, NORTH
	map_exit 5, 0, MAP_FIGHTING_FORT_MAZE_12, 5, 7, NORTH
	map_exit 0, 3, MAP_FIGHTING_FORT_MAZE_6, 8, 3, WEST
	map_exit 0, 4, MAP_FIGHTING_FORT_MAZE_6, 8, 4, WEST
	map_exit 9, 3, MAP_FIGHTING_FORT_MAZE_8, 1, 3, EAST
	map_exit 9, 4, MAP_FIGHTING_FORT_MAZE_8, 1, 4, EAST
	db $ff

FightingFortMaze7_MapScripts:
	dbw $06, $7810
	dbw $02, $7817
	db $ff
; gap from 0x33810 to 0x33822

SECTION "Bank c@7822", ROMX[$7822], BANK[$c]

FightingFortMaze8_MapHeader:
	db MAP_GFX_FIGHTING_FORT_MAZE_8
	dba FightingFortMaze8_MapScripts
	db MUSIC_FORT_3

FightingFortMaze8_StepEvents:
	map_exit 4, 8, MAP_FIGHTING_FORT_MAZE_3, 4, 1, SOUTH
	map_exit 5, 8, MAP_FIGHTING_FORT_MAZE_3, 5, 1, SOUTH
	map_exit 4, 0, MAP_FIGHTING_FORT_MAZE_13, 4, 7, NORTH
	map_exit 5, 0, MAP_FIGHTING_FORT_MAZE_13, 5, 7, NORTH
	map_exit 0, 3, MAP_FIGHTING_FORT_MAZE_7, 8, 3, WEST
	map_exit 0, 4, MAP_FIGHTING_FORT_MAZE_7, 8, 4, WEST
	map_exit 9, 3, MAP_FIGHTING_FORT_MAZE_9, 1, 3, EAST
	map_exit 9, 4, MAP_FIGHTING_FORT_MAZE_9, 1, 4, EAST
	_ow_coordinate_function 3, 3, 104, 10, 1, 2, $0c, $7915
	_ow_coordinate_function 3, 4, 104, 10, 1, 2, $0c, $7915
	db $ff

FightingFortMaze8_NPCs:
	npc NPC_CHEST_CLOSED, 2, 3, SOUTH, $78f0
	npc NPC_CHEST_OPENED, 2, 3, SOUTH, $7908
	db $ff

FightingFortMaze8_NPCInteractions:
	npc_script NPC_CHEST_CLOSED, $0c, $78d7
	npc_script NPC_CHEST_OPENED, $0c, $78fd
	db $ff

FightingFortMaze8_MapScripts:
	dbw $06, $78a8
	dbw $08, $78cf
	dbw $07, $78c6
	dbw $0f, $78af
	dbw $02, $78bb
	db $ff
; gap from 0x338a8 to 0x33928

SECTION "Bank c@7928", ROMX[$7928], BANK[$c]

FightingFortMaze9_MapHeader:
	db MAP_GFX_FIGHTING_FORT_MAZE_9
	dba FightingFortMaze9_MapScripts
	db MUSIC_FORT_3

FightingFortMaze9_StepEvents:
	map_exit 4, 8, MAP_FIGHTING_FORT_MAZE_4, 4, 1, SOUTH
	map_exit 5, 8, MAP_FIGHTING_FORT_MAZE_4, 5, 1, SOUTH
	map_exit 4, 0, MAP_FIGHTING_FORT_MAZE_14, 4, 7, NORTH
	map_exit 5, 0, MAP_FIGHTING_FORT_MAZE_14, 5, 7, NORTH
	map_exit 0, 3, MAP_FIGHTING_FORT_MAZE_8, 8, 3, WEST
	map_exit 0, 4, MAP_FIGHTING_FORT_MAZE_8, 8, 4, WEST
	db $ff

FightingFortMaze9_MapScripts:
	dbw $06, $796b
	dbw $02, $7972
	db $ff
; gap from 0x3396b to 0x3397d

SECTION "Bank c@797d", ROMX[$797d], BANK[$c]

FightingFortMaze10_MapHeader:
	db MAP_GFX_FIGHTING_FORT_MAZE_10
	dba FightingFortMaze10_MapScripts
	db MUSIC_FORT_3

FightingFortMaze10_StepEvents:
	map_exit 4, 0, MAP_FIGHTING_FORT_MAZE_15, 4, 7, NORTH
	map_exit 5, 0, MAP_FIGHTING_FORT_MAZE_15, 5, 7, NORTH
	map_exit 9, 3, MAP_FIGHTING_FORT_MAZE_11, 1, 3, EAST
	map_exit 9, 4, MAP_FIGHTING_FORT_MAZE_11, 1, 4, EAST
	db $ff

FightingFortMaze10_MapScripts:
	dbw $06, $79ab
	db $ff
; gap from 0x339ab to 0x339b2

SECTION "Bank c@79b2", ROMX[$79b2], BANK[$c]

FightingFortMaze11_MapHeader:
	db MAP_GFX_FIGHTING_FORT_MAZE_11
	dba FightingFortMaze11_MapScripts
	db MUSIC_FORT_3

FightingFortMaze11_StepEvents:
	map_exit 4, 8, MAP_FIGHTING_FORT_MAZE_6, 4, 1, SOUTH
	map_exit 5, 8, MAP_FIGHTING_FORT_MAZE_6, 5, 1, SOUTH
	map_exit 4, 0, MAP_FIGHTING_FORT_MAZE_16, 4, 7, NORTH
	map_exit 5, 0, MAP_FIGHTING_FORT_MAZE_16, 5, 7, NORTH
	map_exit 0, 3, MAP_FIGHTING_FORT_MAZE_10, 8, 3, WEST
	map_exit 0, 4, MAP_FIGHTING_FORT_MAZE_10, 8, 4, WEST
	map_exit 9, 3, MAP_FIGHTING_FORT_MAZE_12, 1, 3, EAST
	map_exit 9, 4, MAP_FIGHTING_FORT_MAZE_12, 1, 4, EAST
	db $ff

FightingFortMaze11_MapScripts:
	dbw $06, $7a07
	dbw $02, $7a0e
	db $ff
; gap from 0x33a07 to 0x33a19

SECTION "Bank c@7a19", ROMX[$7a19], BANK[$c]

FightingFortMaze12_MapHeader:
	db MAP_GFX_FIGHTING_FORT_MAZE_12
	dba FightingFortMaze12_MapScripts
	db MUSIC_FORT_3

FightingFortMaze12_StepEvents:
	map_exit 4, 8, MAP_FIGHTING_FORT_MAZE_7, 4, 1, SOUTH
	map_exit 5, 8, MAP_FIGHTING_FORT_MAZE_7, 5, 1, SOUTH
	map_exit 4, 0, MAP_FIGHTING_FORT_MAZE_17, 4, 7, NORTH
	map_exit 5, 0, MAP_FIGHTING_FORT_MAZE_17, 5, 7, NORTH
	map_exit 0, 3, MAP_FIGHTING_FORT_MAZE_11, 8, 3, WEST
	map_exit 0, 4, MAP_FIGHTING_FORT_MAZE_11, 8, 4, WEST
	map_exit 9, 3, MAP_FIGHTING_FORT_MAZE_13, 1, 3, EAST
	map_exit 9, 4, MAP_FIGHTING_FORT_MAZE_13, 1, 4, EAST
	_ow_coordinate_function 4, 6, 104, 10, 1, 2, $0c, $7aa1
	_ow_coordinate_function 5, 6, 104, 10, 1, 2, $0c, $7aa1
	db $ff

FightingFortMaze12_MapScripts:
	dbw $06, $7a83
	dbw $0f, $7a8a
	dbw $02, $7a96
	db $ff
; gap from 0x33a83 to 0x33ab4

SECTION "Bank c@7ab4", ROMX[$7ab4], BANK[$c]

FightingFortMaze13_MapHeader:
	db MAP_GFX_FIGHTING_FORT_MAZE_13
	dba FightingFortMaze13_MapScripts
	db MUSIC_FORT_3

FightingFortMaze13_StepEvents:
	map_exit 4, 8, MAP_FIGHTING_FORT_MAZE_8, 4, 1, SOUTH
	map_exit 5, 8, MAP_FIGHTING_FORT_MAZE_8, 5, 1, SOUTH
	map_exit 4, 0, MAP_FIGHTING_FORT_MAZE_18, 4, 7, NORTH
	map_exit 5, 0, MAP_FIGHTING_FORT_MAZE_18, 5, 7, NORTH
	map_exit 0, 3, MAP_FIGHTING_FORT_MAZE_12, 8, 3, WEST
	map_exit 0, 4, MAP_FIGHTING_FORT_MAZE_12, 8, 4, WEST
	map_exit 9, 3, MAP_FIGHTING_FORT_MAZE_14, 1, 3, EAST
	map_exit 9, 4, MAP_FIGHTING_FORT_MAZE_14, 1, 4, EAST
	db $ff

FightingFortMaze13_MapScripts:
	dbw $06, $7b09
	dbw $02, $7b10
	db $ff
; gap from 0x33b09 to 0x33b1b

SECTION "Bank c@7b1b", ROMX[$7b1b], BANK[$c]

FightingFortMaze14_MapHeader:
	db MAP_GFX_FIGHTING_FORT_MAZE_14
	dba FightingFortMaze14_MapScripts
	db MUSIC_FORT_3

FightingFortMaze14_StepEvents:
	map_exit 4, 8, MAP_FIGHTING_FORT_MAZE_9, 4, 1, SOUTH
	map_exit 5, 8, MAP_FIGHTING_FORT_MAZE_9, 5, 1, SOUTH
	map_exit 4, 0, MAP_FIGHTING_FORT_MAZE_19, 4, 7, NORTH
	map_exit 5, 0, MAP_FIGHTING_FORT_MAZE_19, 5, 7, NORTH
	map_exit 0, 3, MAP_FIGHTING_FORT_MAZE_13, 8, 3, WEST
	map_exit 0, 4, MAP_FIGHTING_FORT_MAZE_13, 8, 4, WEST
	_ow_coordinate_function 2, 3, 104, 10, 1, 2, $0c, $7b91
	_ow_coordinate_function 2, 4, 104, 10, 1, 2, $0c, $7b91
	db $ff

FightingFortMaze14_MapScripts:
	dbw $06, $7b73
	dbw $0f, $7b7a
	dbw $02, $7b86
	db $ff
; gap from 0x33b73 to 0x33ba4

SECTION "Bank c@7ba4", ROMX[$7ba4], BANK[$c]

FightingFortMaze15_MapHeader:
	db MAP_GFX_FIGHTING_FORT_MAZE_15
	dba FightingFortMaze15_MapScripts
	db MUSIC_FORT_3

FightingFortMaze15_StepEvents:
	map_exit 4, 8, MAP_FIGHTING_FORT_MAZE_10, 4, 1, SOUTH
	map_exit 5, 8, MAP_FIGHTING_FORT_MAZE_10, 5, 1, SOUTH
	map_exit 4, 0, MAP_FIGHTING_FORT_GODA, 5, 9, NORTH
	map_exit 5, 0, MAP_FIGHTING_FORT_GODA, 6, 9, NORTH
	map_exit 9, 3, MAP_FIGHTING_FORT_MAZE_16, 1, 3, EAST
	map_exit 9, 4, MAP_FIGHTING_FORT_MAZE_16, 1, 4, EAST
	db $ff

FightingFortMaze15_MapScripts:
	dbw $06, $7be7
	dbw $02, $7bee
	db $ff
; gap from 0x33be7 to 0x33bf9

SECTION "Bank c@7bf9", ROMX[$7bf9], BANK[$c]

FightingFortMaze17_MapHeader:
	db MAP_GFX_FIGHTING_FORT_MAZE_17
	dba FightingFortMaze17_MapScripts
	db MUSIC_FORT_3

FightingFortMaze17_StepEvents:
	map_exit 4, 8, MAP_FIGHTING_FORT_MAZE_12, 4, 1, SOUTH
	map_exit 5, 8, MAP_FIGHTING_FORT_MAZE_12, 5, 1, SOUTH
	map_exit 4, 0, MAP_FIGHTING_FORT_MAZE_21, 4, 7, NORTH
	map_exit 5, 0, MAP_FIGHTING_FORT_MAZE_21, 5, 7, NORTH
	_ow_coordinate_function 4, 6, 104, 10, 1, 2, $0c, $7d1b
	_ow_coordinate_function 5, 6, 104, 10, 1, 2, $0c, $7d1b
	_ow_coordinate_function 8, 3, 104, 10, 1, 2, $0c, $7cf8
	_ow_coordinate_function 8, 4, 104, 10, 1, 2, $0c, $7cf8
	db $ff

FightingFortMaze17_NPCs:
	npc NPC_CHEST_CLOSED, 1, 1, SOUTH, $7cd3
	npc NPC_CHEST_OPENED, 1, 1, SOUTH, $7ceb
	db $ff

FightingFortMaze17_NPCInteractions:
	npc_script NPC_CHEST_CLOSED, $0c, $7cba
	npc_script NPC_CHEST_OPENED, $0c, $7ce0
	db $ff

FightingFortMaze17_MapScripts:
	dbw $06, $7c6d
	dbw $08, $7cb2
	dbw $07, $7ca9
	dbw $02, $7c74
	dbw $0f, $7c9d
	db $ff
; gap from 0x33c6d to 0x33d2e

SECTION "Bank c@7d2e", ROMX[$7d2e], BANK[$c]

FightingFortMaze20_MapHeader:
	db MAP_GFX_FIGHTING_FORT_MAZE_20
	dba FightingFortMaze20_MapScripts
	db MUSIC_FORT_3

FightingFortMaze20_StepEvents:
	map_exit 4, 8, MAP_FIGHTING_FORT_MAZE_16, 4, 1, SOUTH
	map_exit 5, 8, MAP_FIGHTING_FORT_MAZE_16, 5, 1, SOUTH
	map_exit 9, 3, MAP_FIGHTING_FORT_MAZE_21, 1, 3, EAST
	map_exit 9, 4, MAP_FIGHTING_FORT_MAZE_21, 1, 4, EAST
	db $ff

FightingFortMaze20_MapScripts:
	dbw $06, $7d5c
	db $ff
; gap from 0x33d5c to 0x33d63

SECTION "Bank c@7d63", ROMX[$7d63], BANK[$c]

FightingFortMaze22_MapHeader:
	db MAP_GFX_FIGHTING_FORT_MAZE_22
	dba FightingFortMaze22_MapScripts
	db MUSIC_FORT_3

FightingFortMaze22_StepEvents:
	map_exit 4, 8, MAP_FIGHTING_FORT_MAZE_18, 4, 1, SOUTH
	map_exit 5, 8, MAP_FIGHTING_FORT_MAZE_18, 5, 1, SOUTH
	map_exit 0, 3, MAP_FIGHTING_FORT_MAZE_21, 8, 3, WEST
	map_exit 0, 4, MAP_FIGHTING_FORT_MAZE_21, 8, 4, WEST
	db $ff

FightingFortMaze22_MapScripts:
	dbw $06, $7d91
	db $ff
; gap from 0x33d91 to 0x33d98

SECTION "Bank c@7d98", ROMX[$7d98], BANK[$c]

ColorlessAltarEntrance_MapHeader:
	db MAP_GFX_COLORLESS_ALTAR_ENTRANCE
	dba ColorlessAltarEntrance_MapScripts
	db MUSIC_FORT_4

ColorlessAltarEntrance_StepEvents:
	map_exit 4, 12, OVERWORLD_MAP_GR, 4, 4, SOUTH
	map_exit 5, 12, OVERWORLD_MAP_GR, 4, 4, SOUTH
	map_exit 4, 0, MAP_COLORLESS_ALTAR, 5, 10, NORTH
	map_exit 5, 0, MAP_COLORLESS_ALTAR, 6, 10, NORTH
	db $ff

ColorlessAltarEntrance_MapScripts:
	dbw $06, $7de1
	dbw $02, $7de8
	dbw $10, $7dcc
	db $ff
