SECTION "Bank c@4080", ROMX[$4080], BANK[$c]

Data_30080:
	db OVERWORLD_MAP_GFX_GR
	dba Data_30085
	db MUSIC_GROVERWORLD

Data_30085:
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
	farcall Func_10413
	farcall ShowOWMapLocationBox
	call Func_30343
	ld a, [wCurOWLocation]
	ld [wPlayerOWLocation], a

	ld a, OW_VOLCANO_SMOKE_GR
	lb de, $3c, $20
	ld b, NORTH
	farcall LoadOWObject

	ld a, OW_GR_CASTLE_FLAG
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

	ld a, OW_CURSOR_GR
	lb de, 0, 0
	ld b, NORTH
	farcall LoadOWObject

	ld a, OW_GR_CROSS
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
	ld a, OW_GR_BLIMP
	lb de, $18, $b0
	ld b, EAST
	farcall LoadOWObject
	scf
	ret

.asm_30159
	ld a, OW_GR_BLIMP
	lb de, $30, $f0
	ld b, EAST
	farcall LoadOWObject
	ld a, EVENT_SHORT_GR_ISLAND_FLYOVER_SEQUENCE
	farcall GetEventValue
	call z, .Func_30175
	ld a, $00
	call Func_338f
	scf
	ccf
	ret

.Func_30175:
	ld a, OW_GR_BLIMP
	farcall SetOWObjectAsScrollTarget
	ld a, $01
	farcall Func_10413
	ld a, OW_GR_BLIMP
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
	bit A_BUTTON_F, a
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
	jr nc, .no_overflow
	inc h
.no_overflow
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
	jr nc, .no_overflow
	inc h
.no_overflow
	ld a, [hli]
	ld d, a
	ld a, [hl]
	sub 12
	ld e, a
	ld a, OW_CURSOR_GR
	farcall SetOWObjectPosition
	ld a, OW_GR_CROSS
	farcall SetOWObjectPosition
	pop af

	call Func_3030a
	jr c, .asm_30233

	ld a, OW_CURSOR_GR
	farcall Func_112e8
	ld a, OW_GR_CROSS
	farcall Func_112f4
	jr .done

.asm_30233
	ld a, OW_CURSOR_GR
	farcall Func_112f4
	ld a, OW_GR_CROSS
	farcall Func_112e8
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
	jr nc, .no_overflow1
	inc h
.no_overflow1
	ld a, c
	add l
	ld l, a
	jr nc, .no_overflow2
	inc h
.no_overflow2
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
	jr nc, .no_overflow
	inc h
.no_overflow
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
	jr nc, .no_overflow
	inc h
.no_overflow
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
	jr nc, .no_overflow
	inc h
.no_overflow
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
	jr nc, .no_overflow
	inc h
.no_overflow
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
.done
	ret

.fighting_fort
	ld a, [wPlayerOWLocation]
	cp OWMAP_ISHIHARAS_VILLA
	jr z, .asm_30411
	cp OWMAP_GR_PSYCHIC_STRONGHOLD
	jr z, .asm_30411
	cp OWMAP_COLORLESS_ALTAR
	jr z, .asm_30411
	cp OWMAP_GR_CASTLE
	jr z, .asm_30411
	cp OWMAP_GR_FIGHTING_FORT
	jr nz, .asm_30404
	ld a, [wd584]
	cp $51
	jr z, .asm_30411
.asm_30404
	ld a, $50 ; ?
	lb de, 4, 11
	ld b, NORTH
	farcall Func_d3c4
	jr .done
.asm_30411
	ld a, $51 ; ?
	lb de, 7, 1
	ld b, SOUTH
	farcall Func_d3c4
	jr .done

.data
	db $27, 5, 11, NORTH ; OWMAP_GR_AIRPORT
	db $29, 4,  9, NORTH ; OWMAP_ISHIHARAS_VILLA
	db $2b, 5, 14, NORTH ; OWMAP_GAME_CENTER
	db $34, 5,  7, NORTH ; OWMAP_SEALED_FORT
	db $36, 4,  7, NORTH ; OWMAP_GR_CHALLENGE_HALL
	db $39, 4,  7, NORTH ; OWMAP_GR_GRASS_FORT
	db $3f, 4, 11, NORTH ; OWMAP_GR_LIGHTNING_FORT
	db $44, 4, 11, NORTH ; OWMAP_GR_FIRE_FORT
	db $4a, 4, 11, NORTH ; OWMAP_GR_WATER_FORT
	db $50, 4, 11, NORTH ; OWMAP_GR_FIGHTING_FORT
	db $6b, 4,  7, NORTH ; OWMAP_GR_PSYCHIC_STRONGHOLD
	db $6f, 4, 11, NORTH ; OWMAP_COLORLESS_ALTAR
	db $71, 5,  7, NORTH ; OWMAP_GR_CASTLE

Func_30452:
	ld a, [wPlayerOWObject]
	ld b, $01
	farcall Func_11471
	ld a, [wPlayerOWLocation]
	ld c, 3 ; speed
	call Func_3035f

	ld a, [wPlayerOWLocation]
	sla a ; *2
	ld hl, GRIslandMovementCommands
	add l
	ld l, a
	jr nc, .no_overflow1
	inc h
.no_overflow1
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, [wCurOWLocation]
	sla a ; *2
	add l
	ld l, a
	jr nc, .no_overflow2
	inc h
.no_overflow2
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
	jr nc, .no_overflow3
	inc h
.no_overflow3
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
	jr nc, .no_overflow4
	inc h
.no_overflow4
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
	bit B_BUTTON_F, a
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
	bit B_BUTTON_F, a
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
