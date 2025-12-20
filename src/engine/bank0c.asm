Func_30000:
	scf
	ccf
	push af
	jr Func_30005.asm_30007

Func_30005:
	scf
	push af
.asm_30007:
	ld a, MAP_FIGHTING_FORT_BASEMENT
	lb de, 10, 01
	ld b, SOUTH
	farcall Func_d3c4
	ld a, $1e
	call WaitAFrames
	ld a, EVENT_PLAYER_GENDER
	farcall GetEventValue
	jr nz, .asm_30024
	ld bc, $ae
	jr .asm_30027
.asm_30024
	ld bc, $b4
.asm_30027
	ld a, [wPlayerOWObject]
	farcall SetAndInitOWObjectFrameset
	farcall StartOWObjectAnimation
	ld b, $01
	farcall SetOWObjectAnimStruct1Flag2
	ld a, $0a
	call WaitAFrames
	pop af
	jr c, .asm_30050
	ld a, [wPlayerOWObject]
	ld b, SOUTH | MOVE_BACKWARDS
	ld c, MOVE_SPEED_RUN
	farcall Func_10e3c
	ld a, $05
	call WaitAFrames
.asm_30050
	ld a, SFX_PITFALL
	call PlaySFX
	ret

Func_30056:
	ld a, [wd584]
	cp OVERWORLD_MAP_GR
	ret nz
	ld a, VAR_3B
	ld c, $01
	farcall SetVarValue
	ret

Func_30065:
	ld c, a
	ld a, VAR_3B
	farcall GetVarValue
	cp c
	jr nz, .asm_30077
	inc c
	ld a, VAR_3B
	farcall SetVarValue
	ret
.asm_30077
	ld a, VAR_3B
	ld c, $00
	farcall SetVarValue
	ret

OverworldGr_MapHeader:
	db OVERWORLD_MAP_GFX_GR
	dba OverworldGr_MapScripts
	db MUSIC_GR_OVERWORLD

OverworldGr_MapScripts:
	dbw $01, Func_30092
	dbw $02, Func_300a8
	dbw $04, Func_3018b
	dbw $0f, Func_30192
	db $ff ; end

Func_30092:
	ld a, [wd584]
	cp MAP_OVERHEAD_ISLANDS
	jr z, .asm_300a0
	cp MAP_GR_AIRPORT
	jr z, .asm_300a0
	scf
	ccf
	ret
.asm_300a0
	ld a, MUSIC_GR_BLIMP
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
	cp MAP_OVERHEAD_ISLANDS
	jr z, .asm_3012c
	cp MAP_GR_AIRPORT
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
	ld a, BANK(DoGRBlimpMovement_GRIsland)
	ld [wd592], a
	ld hl, DoGRBlimpMovement_GRIsland
	ld a, l
	ld [wd593 + 0], a
	ld a, h
	ld [wd593 + 1], a
	ld a, [wd584]
	cp MAP_OVERHEAD_ISLANDS
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
	call z, .asm_30175
	ld a, 0
	call Func_338f
	scf
	ccf
	ret

.asm_30175:
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
	cp MAP_GR_AIRPORT
	jr z, .asm_3019f
	cp MAP_OVERHEAD_ISLANDS
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
	ld a, SFX_GR_BLIMP_HATCH_OPEN
	call PlaySFX
	farcall WaitForSFXToFinish
.asm_301bd
	scf
	ccf
	ret

Func_301c0:
	farcall Func_d683
	farcall DeliverMailFromQueue
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
	add_hl_a
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
	add_hl_a
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
	ld a, SFX_CURSOR
	call PlaySFX
	ld a, [wCurOWLocation]
	ld b, a
	sla a
	sla a ; *4
	ld hl, .LocationConnections
	add_hl_a
	ld a, c
	add_hl_a
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
	add_hl_a
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
	; no sentinels

Func_3030a:
	sla a ; *2
	ld hl, .PointerTable
	add_hl_a
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
	add_hl_a
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
	add_hl_a
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
	add_hl_a
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
	ld hl, GRIslandPlayerPaths
	add_hl_a
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, [wCurOWLocation]
	sla a ; *2
	add_hl_a
	ld a, [hli]
	ld h, [hl]
	ld l, a
	or h
	jp z, .finish_movement ; is null
	ld a, SFX_PLAYER_WALK_MAP
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
	add_hl_a
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
	add_hl_a
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

INCLUDE "data/gr_island_paths.asm"

DoGRBlimpMovement_GRIsland:
	ld a, [wd584]
	cp MAP_GR_AIRPORT
	jr z, .asm_310cf

	ld a, MAP_GR_AIRPORT
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
	jr .start_movement
.asm_310cf
	ld a, MAP_OVERHEAD_ISLANDS
	lb de, 0, 0
	ld b, NORTH
	farcall Func_d3c4
	ld hl, .movement_3

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
	ld a, NPC_GR_BLIMP
	farcall SetOWObjectTargetPosition
	ld a, NPC_GR_BLIMP
	pop bc
	farcall _SetOWObjectDirection

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
	bit B_PAD_B, a
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
	cp MAP_OVERHEAD_ISLANDS
	jr z, .asm_31136 ; unnecessary cp
.asm_31136
	call .FadeOut
.finish
	call WaitPalFading
	farcall Func_110a8
	ret

; fades out to white or black
; dependent on wd585
.FadeOut:
	ld a, [wd585]
	cp MAP_OVERHEAD_ISLANDS
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
	db $88, $88, EAST
	db $a8, $40, EAST
	db $60, $28, WEST
	db $28, $68, WEST
	db $18, $90, WEST
	db $18, $b0, EAST
	db $ff, $ff ; end

.movement_2
	db $50, $d8, EAST
	db $50, $d0, EAST
	db $18, $90, WEST
	db $18, $b0, EAST
	db $ff, $ff ; end

.movement_3
	db $18, $90, EAST
	db $50, $d0, EAST
	db $50, $d8, EAST
	db $30, $f0, WEST
	db $ff, $ff ; end

CardDungeonQueen_MapHeader:
	db MAP_GFX_CARD_DUNGEON_QUEEN
	dba CardDungeonQueen_MapScripts
	db MUSIC_FORT_3

CardDungeonQueen_NPCs:
	npc NPC_QUEEN, 3, 4, EAST, NULL
	db $ff

CardDungeonQueen_NPCInteractions:
	npc_script NPC_QUEEN, CardDungeonQueenScript
	db $ff

CardDungeonQueen_MapScripts:
	dbw $08, Func_311b1
	dbw $09, Func_311d0
	dbw $07, Func_311a8
	dbw $02, Func_311b9
	db $ff

Func_311a8:
	ld hl, CardDungeonQueen_NPCs
	call Func_3205
	scf
	ccf
	ret

Func_311b1:
	ld hl, CardDungeonQueen_NPCInteractions
	call Func_328c
	scf
	ret

Func_311b9:
	ld a, $0a
	ld [wd582], a
	ld a, BANK(Func_312d2)
	ld [wd592], a
	ld hl, Func_312d2
	ld a, l
	ld [wd593], a
	ld a, h
	ld [wd593 + 1], a
	scf
	ret

Func_311d0:
	call Func_31285
	scf
	ret

CardDungeonQueenScript:
	ld a, NPC_QUEEN
	ld [wScriptNPC], a
	ldtx hl, DialogQueenText
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [wScriptNPCName + 1], a
	xor a
	start_script
	script_command_01
	game_center
	check_event EVENT_TALKED_TO_QUEEN
	script_jump_if_b0z .duel_repeat
	set_event EVENT_TALKED_TO_QUEEN
	print_npc_text QueenWantsToDuelInitialText
	script_jump .duel_prompt
.duel_repeat
	print_npc_text QueenWantsToDuelRepeatText
.duel_prompt
	ask_question QueenDuelPromptText, TRUE
	script_jump_if_b0z .quit_prompt
.bet_start
	print_text GameCenterCardDungeonBetPromptText
	quit_script
	ld a, POPUPMENU_CARD_DUNGEON_QUEEN
	ld b, 0
	farcall HandlePopupMenu
	jr c, .cancel
	cp 1
	jr z, .bet_100
	jr nc, .cancel
; bet 50
	ld a, CHIPS_BET_DUNGEON_50
	jr .bet_check
.bet_100
	ld a, CHIPS_BET_DUNGEON_100
	jr .bet_check
.cancel
	ld a, $01
	start_script
	script_jump .quit_prompt
.bet_check
	ld h, 0
	ld l, a
	ld [wTempCardDungeonBet], a
	call LoadTxRam3
	farcall GetGameCenterChips
	cp16bc_long hl
	jr nc, .bet
	ld a, $01
	start_script
	print_npc_text QueenNotEnoughChipsText
	script_jump .bet_start
.bet
	ld c, l
	ld b, h
	farcall DecreaseChipsSmoothly
	ld a, $01
	start_script
	print_npc_text QueenDuelStart1Text
	script_command_71
	script_command_02
	set_active_npc_direction EAST
	script_call Script_312ea
	script_command_01
	print_npc_text QueenDuelStart2Text
	script_command_02
	start_duel POWERFUL_POKEMON_DECK_ID, MUSIC_MATCH_START_GR_LEADER
	end_script
	ret
.quit_prompt
	print_npc_text QueenDeclinedDuelText
	ask_question QueenQuitDuelPromptText, TRUE
	script_jump_if_b0nz .quit
	print_npc_text QueenResumeDuelText
	script_jump .duel_prompt
.quit
	set_var VAR_CARD_DUNGEON_PROGRESS, CARDDUNGEON_QUIT_OR_WITHDREW
	print_npc_text QueenPlayerQuitText
	script_command_71
	script_command_02
	end_script

Func_31281:
	jp Func_312c6
	ret

Func_31285:
	xor a
	start_script
	script_command_01
	check_event EVENT_SET_UNTIL_MAP_RELOAD_2
	script_jump_if_b0nz .player_lost
	set_var VAR_CARD_DUNGEON_PROGRESS, CARDDUNGEON_WON_QUEEN
	print_npc_text QueenPlayerWon1Text
	game_center
	quit_script
	ld a, [wTempCardDungeonBet]
	sla a
	ld h, 0
	ld l, a
	call LoadTxRam3
	ld c, l
	ld b, h
	ldtx hl, ReceivedXChipsText
	farcall PrintScrollableText_NoTextBoxLabelVRAM0
	farcall IncreaseChipsSmoothly
	ld a, $01
	start_script
	print_npc_text QueenPlayerWon2Text
	script_command_71
	script_jump .done
.player_lost
	set_var VAR_CARD_DUNGEON_PROGRESS, CARDDUNGEON_LOST
	print_npc_text QueenPlayerLostText
.done
	script_command_02
	end_script
	jp Func_312c6

Func_312c6:
	ld a, MAP_GAME_CENTER_2
	lb de, 6, 3
	ld b, SOUTH
	farcall Func_d3c4
	ret

Func_312d2:
	xor a
	start_script
	animate_player_movement $00, $01
	animate_player_movement $00, $01
	play_sfx SFX_DOORS
	load_tilemap TILEMAP_04F, $04, $09
	end_script
	ld a, $00
	ld [wd582], a
	ret

Script_312ea:
	get_player_direction
	compare_loaded_var NORTH
	script_jump_if_b0nz .ows_31303
	compare_loaded_var EAST
	script_jump_if_b0nz .ows_312fc
	move_player .NPCMovement_31309, TRUE
	script_jump .ows_31307
.ows_312fc
	move_player .NPCMovement_31312, TRUE
	script_jump .ows_31307
.ows_31303
	move_player .NPCMovement_3131b, TRUE
.ows_31307
	wait_for_player_animation
	script_ret
.NPCMovement_31309:
	db NORTH, MOVE_1
	db EAST, MOVE_3
	db SOUTH, MOVE_2
	db WEST, MOVE_0
	db $ff
.NPCMovement_31312:
	db SOUTH, MOVE_2
	db EAST, MOVE_4
	db NORTH, MOVE_2
	db WEST, MOVE_0
	db $ff
.NPCMovement_3131b:
	db SOUTH, MOVE_1
	db EAST, MOVE_3
	db NORTH, MOVE_2
	db WEST, MOVE_0
	db $ff

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
	ow_script 4, 1, Func_313bc
	ow_script 5, 1, Func_313bc
	ow_script 6, 1, Func_313bc
	db $ff

SealedFortEntrance_MapScripts:
	dbw $06, Func_31386
	dbw $08, Func_3138d
	dbw $02, Func_313a8
	db $ff

Func_31386:
	ld hl, SealedFortEntrance_StepEvents
	call Func_324d
	ret

Func_3138d:
	ld a, [wPlayerOWObject]
	farcall GetOWObjectAnimStruct1Flag0And1
	ld a, b
	cp $00
	ld a, [wPlayerOWObject]
	jr nz, .asm_313a6
	farcall GetOWObjectTilePosition
	ld hl, SealedFortEntrance_OWInteractions
	call Func_3254
.asm_313a6
	scf
	ret

Func_313a8:
	ld a, EVENT_SEALED_FORT_DOOR_STATE
	farcall GetEventValue
	jr nz, .asm_313ba
	ld bc, TILEMAP_051
	lb de, 4, 0
	farcall Func_12c0ce
.asm_313ba
	scf
	ret

Func_313bc:
	ld a, EVENT_SEALED_FORT_DOOR_STATE
	farcall GetEventValue
	ret nz
	xor a
	start_script
	script_command_01
	print_text Text1087
	script_command_02
	end_script
	ret

GrChallengeHallEntrance_MapHeader:
	db MAP_GFX_GR_CHALLENGE_HALL_ENTRANCE
	dba GrChallengeHallEntrance_MapScripts
	db MUSIC_GR_OVERWORLD

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
	npc_script NPC_GR_CLERK_CHALLENGE_HALL_ENTRANCE, Func_314a1
	db $ff

GrChallengeHallEntrance_MapScripts:
	dbw $06, Func_31426
	dbw $08, Func_31499
	dbw $07, Func_31490
	dbw $01, Func_3142d
	dbw $04, Func_31447
	db $ff

Func_31426:
	ld hl, GrChallengeHallEntrance_StepEvents
	call Func_324d
	ret

Func_3142d:
	ld a, VAR_30
	farcall GetVarValue
	cp $01
	jr z, .asm_3143f
	cp $03
	jr z, .asm_3143f
	cp $06
	jr nz, .asm_31444
.asm_3143f
	ld a, MUSIC_GR_CHALLENGE_CUP
	ld [wNextMusic], a
.asm_31444
	scf
	ccf
	ret

Func_31447:
	ld a, [wd585]
	cp OVERWORLD_MAP_GR
	jr nz, .asm_3148e
	ld a, VAR_30
	farcall GetVarValue
	cp $01
	jr z, .asm_31460
	cp $03
	jr z, .asm_31460
	cp $06
	jr nz, .asm_3148e
.asm_31460
	ld a, VAR_33
	farcall GetVarValue
	cp $01
	push af
	ld a, VAR_33
	farcall ZeroOutVarValue
	pop af
	jr nz, .asm_3148e
	ld a, VAR_30
	farcall GetVarValue
	cp $06
	jr z, .asm_31486
	inc a
	ld c, a
	ld a, VAR_30
	farcall SetVarValue
	jr .asm_3148e
.asm_31486
	ld a, VAR_30
	ld c, $05
	farcall SetVarValue
.asm_3148e
	scf
	ret

Func_31490:
	ld hl, GrChallengeHallEntrance_NPCs
	call Func_3205
	scf
	ccf
	ret

Func_31499:
	ld hl, GrChallengeHallEntrance_NPCInteractions
	call Func_328c
	scf
	ret

Func_314a1:
	ld a, NPC_GR_CLERK_CHALLENGE_HALL_ENTRANCE
	ld [wScriptNPC], a
	ldtx hl, DialogReceptionistText
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [wScriptNPCName + 1], a
	xor a
	start_script
	script_command_01
	get_var VAR_33
	compare_loaded_var $00
	script_jump_if_b0z .ows_314f8
	get_var VAR_30
	compare_loaded_var $05
	script_jump_if_b0nz .ows_314ec
	script_jump_if_b1z .ows_314f2
	compare_loaded_var $03
	script_jump_if_b0nz .ows_314e0
	script_jump_if_b1z .ows_314e6
	compare_loaded_var $01
	script_jump_if_b0nz .ows_314da
	print_npc_text Text0e2b
	script_jump .ows_314fb
.ows_314da
	print_npc_text Text0e2c
	script_jump .ows_314fb
.ows_314e0
	print_npc_text Text0e2d
	script_jump .ows_314fb
.ows_314e6
	print_npc_text Text0e2e
	script_jump .ows_314fb
.ows_314ec
	print_npc_text Text0e2f
	script_jump .ows_314fb
.ows_314f2
	print_npc_text Text0e30
	script_jump .ows_314fb
.ows_314f8
	print_npc_text Text0e31
.ows_314fb
	script_command_02
	end_script
	ret

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
	npc_script NPC_GR_CLERK_GRASS_FORT, Func_315ad
	db $ff

GrassFortEntrance_MapScripts:
	dbw $06, Func_3156e
	dbw $08, Func_3159f
	dbw $02, Func_3157e
	dbw $09, Func_315a7
	dbw $07, Func_31575
	dbw $10, Func_31559
	db $ff

Func_31559:
	ld a, VAR_TIMES_MET_RONALD
	farcall GetVarValue
	cp $05
	jr c, .asm_31565
	scf
	ret
.asm_31565
	ld a, MUSIC_RONALD
	farcall PlayAfterCurrentSong
	scf
	ccf
	ret

Func_3156e:
	ld hl, GrassFortEntrance_StepEvents
	call Func_324d
	ret

Func_31575:
	ld hl, GrassFortEntrance_NPCs
	call Func_3205
	scf
	ccf
	ret

Func_3157e:
	ld a, VAR_TIMES_MET_RONALD
	farcall GetVarValue
	cp $05
	jr nc, .asm_3159d
	ld a, $0a
	ld [wd582], a
	ld a, BANK(Func_342ef)
	ld [wd592], a
	ld hl, Func_342ef
	ld a, l
	ld [wd593], a
	ld a, h
	ld [wd593 + 1], a
.asm_3159d
	scf
	ret

Func_3159f:
	ld hl, GrassFortEntrance_NPCInteractions
	call Func_328c
	scf
	ret

Func_315a7:
	farcall Func_34323
	scf
	ret

Func_315ad:
	ld a, NPC_GR_CLERK_GRASS_FORT
	ld [wScriptNPC], a
	ldtx hl, DialogReceptionistText
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [wScriptNPCName + 1], a
	xor a
	start_script
	script_command_01
	check_event EVENT_GOT_GOLBAT_COIN
	script_jump_if_b0z .ows_315ce
	script_call .ows_315d4
	script_jump .ows_315d1
.ows_315ce
	print_npc_text Text0d8c
.ows_315d1
	script_command_02
	end_script
	ret
.ows_315d4
	print_npc_text Text0d8d
	script_ret

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
	npc NPC_IMAKUNI_RED, 12, 1, NORTH, Func_31776
	npc NPC_GR_CLERK_BATTLE_CENTER, 5, 2, SOUTH, NULL
	npc NPC_GR_CLERK_GIFT_CENTER, 8, 2, SOUTH, NULL
	db $ff

GrassFortLobby_NPCInteractions:
	npc_script NPC_GRASS_FORT_GR_GRUNT, Func_316b5
	npc_script NPC_GRASS_FORT_GR_PAPPY, Func_3171f
	npc_script NPC_GRASS_FORT_GR_LASS, Func_31745
	npc_script NPC_IMAKUNI_RED, Func_3c4e0
	db $ff

GrassFortLobby_OWInteractions:
	ow_script 1, 2, PCMenu
	ow_script 2, 2, PCMenu
	ow_script 5, 4, Func_3c1d0
	ow_script 8, 4, Func_3c2d9
	db $ff

GrassFortLobby_MapScripts:
	dbw $06, Func_31673
	dbw $08, Func_31683
	dbw $09, Func_31693
	dbw $0b, Func_31699
	dbw $07, Func_3167a
	dbw $10, Func_3165e
	db $ff

Func_3165e:
	ld a, VAR_26
	farcall GetVarValue
	cp $05
	jr z, .asm_3166a
	scf
	ret
.asm_3166a
	ld a, MUSIC_IMAKUNI_RED
	farcall PlayAfterCurrentSong
	scf
	ccf
	ret

Func_31673:
	ld hl, GrassFortLobby_StepEvents
	call Func_324d
	ret

Func_3167a:
	ld hl, GrassFortLobby_NPCs
	call Func_3205
	scf
	ccf
	ret

Func_31683:
	ld hl, GrassFortLobby_NPCInteractions
	call Func_328c
	jr nc, .asm_31691
	ld hl, GrassFortLobby_OWInteractions
	call Func_32bf
.asm_31691
	scf
	ret

Func_31693:
	farcall Func_3c52d
	scf
	ret

Func_31699:
	ld a, EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE_DUMMY
	farcall GetEventValue
	jr z, .asm_316b3
	ld a, NPC_IMAKUNI_RED
	farcall ClearOWObject
	ld a, EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE_DUMMY
	farcall ZeroOutEventValue
	ld a, [wNextMusic]
	ld [wCurMusic], a
.asm_316b3
	scf
	ret

Func_316b5:
	ld a, NPC_GRASS_FORT_GR_GRUNT
	ld [wScriptNPC], a
	ldtx hl, DialogGRGruntText
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [wScriptNPCName + 1], a
	xor a
	start_script
	script_command_01
	check_event EVENT_TRADED_CARDS_GRASS_FORT
	script_jump_if_b0z .ows_31715
	check_event EVENT_TALKED_TO_TRADE_NPC_GRASS_FORT
	script_jump_if_b0z .ows_316dc
	set_event EVENT_TALKED_TO_TRADE_NPC_GRASS_FORT
	print_npc_text Text0dc7
	script_jump .ows_316df
.ows_316dc
	print_npc_text Text0dc8
.ows_316df
	ask_question TradeCardsPromptText, TRUE
	script_jump_if_b0nz .ows_316ec
	print_npc_text Text0dc9
	script_jump .ows_3171c
.ows_316ec
	get_card_count_in_collection_and_decks DARK_VENUSAUR
	script_jump_if_b0z .ows_316f8
	print_npc_text Text0dca
	script_jump .ows_3171c
.ows_316f8
	get_card_count_in_collection DARK_VENUSAUR
	script_jump_if_b0z .ows_31704
	print_npc_text Text0dcb
	script_jump .ows_3171c
.ows_31704
	print_npc_text Text0dcc
	receive_card VENUSAUR_ALT_LV67
	take_card DARK_VENUSAUR
	set_event EVENT_TRADED_CARDS_GRASS_FORT
	print_npc_text Text0dcd
	script_jump .ows_3171c
.ows_31715
	check_event EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE
	print_variable_npc_text Text0dce, Text0dcf
.ows_3171c
	script_command_02
	end_script
	ret

Func_3171f:
	ld a, NPC_GRASS_FORT_GR_PAPPY
	ld [wScriptNPC], a
	ldtx hl, DialogPappy1Text
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [wScriptNPCName + 1], a
	xor a
	start_script
	script_command_01
	check_event EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE
	script_jump_if_b0z .ows_3173f
	print_npc_text Text0dd0
	script_jump .ows_31742
.ows_3173f
	print_npc_text Text0dd1
.ows_31742
	script_command_02
	end_script
	ret

Func_31745:
	ld a, NPC_GRASS_FORT_GR_LASS
	ld [wScriptNPC], a
	ldtx hl, DialogLassText
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [wScriptNPCName + 1], a
	xor a
	start_script
	script_command_01
	check_event EVENT_SEALED_FORT_DOOR_STATE
	script_jump_if_b0z .ows_31770
	check_event EVENT_FREED_RICK
	script_jump_if_b0z .ows_3176a
	print_npc_text Text0dd2
	script_jump .ows_31773
.ows_3176a
	print_npc_text Text0dd3
	script_jump .ows_31773
.ows_31770
	print_npc_text Text0dd4
.ows_31773
	script_command_02
	end_script
	ret

Func_31776:
	ld a, VAR_26
	farcall GetVarValue
	cp $05
	jr z, .asm_31782
	scf
	ret
.asm_31782
	scf
	ccf
	ret

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
	npc NPC_RICK, 6, 2, SOUTH, Func_31864
	db $ff

GrassFortMidori_NPCInteractions:
	npc_script NPC_MIDORI, Func_31871
	db $ff

GrassFortMidori_OWInteractions:
	ow_script 6, 4, Func_31835
	db $ff

GrassFortMidori_MapScripts:
	dbw $06, Func_317db
	dbw $08, Func_31815
	dbw $09, Func_31825
	dbw $02, Func_317eb
	dbw $07, Func_317e2
	db $ff

Func_317db:
	ld hl, GrassFortMidori_StepEvents
	call Func_324d
	ret

Func_317e2:
	ld hl, GrassFortMidori_NPCs
	call Func_3205
	scf
	ccf
	ret

Func_317eb:
	ld a, [wd584]
	cp MAP_GRASS_FORT_ENTRANCE
	jr nz, .asm_317f6
	farcall DeliverMailFromQueue
.asm_317f6
	ld bc, $3b
	ld a, $14
	farcall SetwD896
	ld a, EVENT_MIDORIS_ROOM_CAGE_STATE
	farcall GetEventValue
	jr z, .asm_31809
	scf
	ret
.asm_31809
	ld bc, TILEMAP_05B
	lb de, 5, 0
	farcall Func_12c0ce
	scf
	ret

Func_31815:
	ld hl, GrassFortMidori_NPCInteractions
	call Func_328c
	jr nc, .asm_31823
	ld hl, GrassFortMidori_OWInteractions
	call Func_32bf
.asm_31823
	scf
	ret

Func_31825:
	ld hl, GrassFortMidori_AfterDuelScripts
	ld a, [wScriptNPC]
	call Func_344c
	scf
	ret

GrassFortMidori_AfterDuelScripts:
	npc_script NPC_MIDORI, Func_318e2
	db $ff

Func_31835:
	ld a, EVENT_MIDORIS_ROOM_CAGE_STATE
	farcall GetEventValue
	ret nz
	ld a, NPC_RICK
	ld [wScriptNPC], a
	ldtx hl, DialogRickText
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [wScriptNPCName + 1], a
	xor a
	start_script
	script_command_01
	check_event EVENT_TALKED_TO_RICK
	script_jump_if_b0z .ows_3185e
	set_event EVENT_TALKED_TO_RICK
	print_npc_text Text0d8e
	script_jump .ows_31861
.ows_3185e
	print_npc_text Text0d8f
.ows_31861
	script_command_02
	end_script
	ret

Func_31864:
	ld a, EVENT_MIDORIS_ROOM_CAGE_STATE
	farcall GetEventValue
	jr z, .asm_3186e
	scf
	ret
.asm_3186e
	scf
	ccf
	ret

Func_31871:
	ld a, NPC_MIDORI
	ld [wScriptNPC], a
	ldtx hl, DialogMidoriText
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [wScriptNPCName + 1], a
	xor a
	start_script
	script_command_01
	check_event EVENT_FREED_RICK
	script_jump_if_b0z .ows_318c9
	check_event EVENT_TALKED_TO_MIDORI
	script_jump_if_b0z .ows_318ac
	set_event EVENT_TALKED_TO_MIDORI
	print_npc_text Text0d90
	script_command_02
	do_frames 30
	get_active_npc_direction
	set_active_npc_direction NORTH
	do_frames 30
	script_command_01
	print_npc_text Text0d91
	script_command_02
	do_frames 30
	restore_active_npc_direction
	script_command_01
	print_npc_text Text0d92
	script_jump .ows_318af
.ows_318ac
	print_npc_text Text0d93
.ows_318af
	ask_question Text0d94, TRUE
	script_jump_if_b0z .ows_318c1
	check_event EVENT_MIDORIS_ROOM_CAGE_STATE
	print_npc_text Text0d95
	script_command_02
	start_duel BUG_COLLECTING_DECK_ID, MUSIC_MATCH_START_MEMBER
	end_script
	ret
.ows_318c1
	check_event EVENT_MIDORIS_ROOM_CAGE_STATE
	print_npc_text Text0d96
	script_command_02
	end_script
	ret
.ows_318c9
	print_npc_text Text0d97
	ask_question Text0d94, TRUE
	script_jump_if_b0z .ows_318dc
	print_npc_text Text0d98
	script_command_02
	start_duel BUG_COLLECTING_DECK_ID, MUSIC_MATCH_START_MEMBER
	end_script
	ret
.ows_318dc
	print_npc_text Text0d99
	script_command_02
	end_script
	ret

Func_318e2:
	xor a
	start_script
	script_command_01
	check_event EVENT_FREED_RICK
	script_jump_if_b0z .ows_31905
	check_event EVENT_SET_UNTIL_MAP_RELOAD_2
	script_jump_if_b0nz .ows_318ff
	set_event EVENT_FREED_RICK
	print_npc_text Text0d9a
	give_booster_packs BoosterList_cd50
	print_npc_text Text0d9b
	script_jump .ows_3191c
.ows_318ff
	print_npc_text Text0d9c
	script_command_02
	end_script
	ret
.ows_31905
	check_event EVENT_SET_UNTIL_MAP_RELOAD_2
	script_jump_if_b0nz .ows_31916
	print_npc_text Text0d9d
	give_booster_packs BoosterList_cd50
	print_npc_text Text0d9e
	script_jump .ows_31919
.ows_31916
	print_npc_text Text0d9f
.ows_31919
	script_command_02
	end_script
	ret
.ows_3191c
	set_event EVENT_MIDORIS_ROOM_CAGE_STATE
	reset_event EVENT_TALKED_TO_RICK
	reset_event EVENT_TALKED_TO_JOSEPH
	print_npc_text Text0da0
	script_command_02
	do_frames 30
	set_active_npc_direction NORTH
	do_frames 30
	fade_out $00, TRUE
	wait_for_fade
	play_sfx SFX_DOORS
	load_tilemap TILEMAP_05C, $05, $00
	set_active_npc_direction SOUTH
	set_player_position_and_direction 5, 5, NORTH
	do_frames 28
	fade_in $00, TRUE
	wait_for_fade
	set_active_npc NPC_RICK, DialogRickText
	move_active_npc .NPCMovement_3196b
	wait_for_player_animation
	set_player_direction EAST
	script_command_01
	print_npc_text Text0da1
	receive_card HUNGRY_SNORLAX
	print_npc_text Text0da2
	script_command_02
	move_active_npc .NPCMovement_31970
	wait_for_player_animation
	unload_npc NPC_RICK
	set_player_direction NORTH
	set_active_npc NPC_MIDORI, DialogMidoriText
	script_command_01
	print_npc_text Text0da3
	script_command_02
	end_script
	ret
.NPCMovement_3196b:
	db SOUTH, MOVE_3
	db WEST, MOVE_0
	db $ff
.NPCMovement_31970:
	db SOUTH, MOVE_7
	db $ff

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
	npc_script NPC_YUTA, Func_31a12
	db $ff

GrassFortYuta_OWInteractions:
	ow_script 4, 1, Func_31ae1
	ow_script 5, 1, Func_31ae1
	db $ff

GrassFortYuta_MapScripts:
	dbw $06, Func_319cc
	dbw $08, Func_319f2
	dbw $09, Func_31a02
	dbw $02, Func_319dc
	dbw $07, Func_319d3
	db $ff

Func_319cc:
	ld hl, GrassFortYuta_StepEvents
	call Func_324d
	ret

Func_319d3:
	ld hl, GrassFortYuta_NPCs
	call Func_3205
	scf
	ccf
	ret

Func_319dc:
	ld a, EVENT_YUTAS_ROOM_DOOR_STATE
	farcall GetEventValue
	jr z, .asm_319e6
	scf
	ret
.asm_319e6
	ld bc, TILEMAP_05E
	lb de, 4, 0
	farcall Func_12c0ce
	scf
	ret

Func_319f2:
	ld hl, GrassFortYuta_NPCInteractions
	call Func_328c
	jr nc, .asm_31a00
	ld hl, GrassFortYuta_OWInteractions
	call Func_32bf
.asm_31a00
	scf
	ret

Func_31a02:
	ld hl, GrassFortYuta_AfterDuelScripts
	ld a, [wScriptNPC]
	call Func_344c
	scf
	ret

GrassFortYuta_AfterDuelScripts:
	npc_script NPC_YUTA, Func_31aa7
	db $ff

Func_31a12:
	ld a, NPC_YUTA
	ld [wScriptNPC], a
	ldtx hl, DialogYutaText
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [wScriptNPCName + 1], a
	xor a
	start_script
	script_command_01
	check_event EVENT_YUTAS_ROOM_DOOR_STATE
	script_jump_if_b0z .ows_31a8e
	check_event EVENT_TALKED_TO_YUTA
	script_jump_if_b0z .ows_31a75
	set_event EVENT_TALKED_TO_YUTA
	print_npc_text Text0dd5
	script_command_02
	get_active_npc_direction
	spin_active_npc 516
	play_sfx SFX_NPC_WARP_TRANSFORM
	load_npc NPC_WARP_SPARKLES, 4, 3, SOUTH
	reset_npc_flag6 NPC_YUTA
	wait_for_npc_animation NPC_WARP_SPARKLES
	load_npc NPC_GR_1, 4, 3, SOUTH
	restore_npc_direction NPC_GR_1
	unload_npc NPC_WARP_SPARKLES
	spin_npc NPC_GR_1, 772
	script_command_01
	print_npc_text Text0dd6
	script_command_02
	spin_npc_reverse NPC_GR_1, 516
	play_sfx SFX_NPC_WARP_TRANSFORM
	load_npc NPC_WARP_SPARKLES, 4, 3, SOUTH
	unload_npc NPC_GR_1
	wait_for_npc_animation NPC_WARP_SPARKLES
	set_npc_flag6 NPC_YUTA
	unload_npc NPC_WARP_SPARKLES
	spin_active_npc_reverse 772
	script_command_01
	print_npc_text Text0dd7
	script_jump .ows_31a78
.ows_31a75
	print_npc_text Text0dd8
.ows_31a78
	ask_question Text0dd9, TRUE
	script_jump_if_b0z .ows_31a88
	print_npc_text Text0dda
	script_command_02
	start_duel DEMONIC_FOREST_DECK_ID, MUSIC_MATCH_START_MEMBER
	end_script
	ret
.ows_31a88
	print_npc_text Text0ddb
	script_command_02
	end_script
	ret
.ows_31a8e
	print_npc_text Text0ddc
	ask_question Text0dd9, TRUE
	script_jump_if_b0z .ows_31aa1
	print_npc_text Text0ddd
	script_command_02
	start_duel DEMONIC_FOREST_DECK_ID, MUSIC_MATCH_START_MEMBER
	end_script
	ret
.ows_31aa1
	print_npc_text Text0dde
	script_command_02
	end_script
	ret

Func_31aa7:
	xor a
	start_script
	script_command_01
	check_event EVENT_YUTAS_ROOM_DOOR_STATE
	script_jump_if_b0z .ows_31aca
	check_event EVENT_SET_UNTIL_MAP_RELOAD_2
	script_jump_if_b0nz .ows_31ac4
	set_event EVENT_YUTAS_ROOM_DOOR_STATE
	print_npc_text Text0ddf
	give_booster_packs BoosterList_cd53
	print_npc_text Text0de0
	script_jump Script_31b0a
.ows_31ac4
	print_npc_text Text0de1
	script_command_02
	end_script
	ret
.ows_31aca
	check_event EVENT_SET_UNTIL_MAP_RELOAD_2
	script_jump_if_b0nz .ows_31adb
	print_npc_text Text0de2
	give_booster_packs BoosterList_cd53
	print_npc_text Text0de3
	script_jump .ows_31ade
.ows_31adb
	print_npc_text Text0de4
.ows_31ade
	script_command_02
	end_script
	ret

Func_31ae1:
	ld a, EVENT_YUTAS_ROOM_DOOR_STATE
	farcall GetEventValue
	jr nz, .asm_31b05
	ld a, NPC_YUTA
	ld [wScriptNPC], a
	ldtx hl, DialogYutaText
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [wScriptNPCName + 1], a
	xor a
	start_script
	script_command_01
	set_active_npc_direction NORTH
	print_npc_text Text0de5
	script_command_02
	end_script
.asm_31b05
	farcall Func_c199
	ret

Script_31b0a:
	print_npc_text Text0de6
	script_command_02
	get_active_npc_direction
	set_active_npc_direction NORTH
	do_frames 30
	script_command_01
	print_npc_text Text0de7
	script_command_02
	play_sfx SFX_DOORS
	load_tilemap TILEMAP_05F, $04, $00
	do_frames 30
	restore_active_npc_direction
	script_command_01
	print_npc_text Text0de8
	script_command_02
	end_script
	ret

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
	npc_script NPC_MIYUKI, Func_31bc8
	db $ff

GrassFortMiyuki_OWInteractions:
	ow_script 5, 1, Func_31ca8
	ow_script 6, 1, Func_31ca8
	db $ff

GrassFortMiyuki_MapScripts:
	dbw $06, Func_31b82
	dbw $08, Func_31ba8
	dbw $09, Func_31bb8
	dbw $07, Func_31b89
	dbw $02, Func_31b92
	db $ff

Func_31b82:
	ld hl, GrassFortMiyuki_StepEvents
	call Func_324d
	ret

Func_31b89:
	ld hl, GrassFortMiyuki_NPCs
	call Func_3205
	scf
	ccf
	ret

Func_31b92:
	ld a, EVENT_MIYUKIS_ROOM_DOOR_STATE
	farcall GetEventValue
	jr z, .asm_31b9c
	scf
	ret
.asm_31b9c
	ld bc, TILEMAP_061
	lb de, 5, 0
	farcall Func_12c0ce
	scf
	ret

Func_31ba8:
	ld hl, GrassFortMiyuki_NPCInteractions
	call Func_328c
	jr nc, .asm_31bb6
	ld hl, GrassFortMiyuki_OWInteractions
	call Func_32bf
.asm_31bb6
	scf
	ret

Func_31bb8:
	ld hl, GrassFortMiyuki_AfterDuelScripts
	ld a, [wScriptNPC]
	call Func_344c
	scf
	ret

GrassFortMiyuki_AfterDuelScripts:
	npc_script NPC_MIYUKI, Func_31c37
	db $ff

Func_31bc8:
	ld a, NPC_MIYUKI
	ld [wScriptNPC], a
	ldtx hl, DialogMiyukiText
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [wScriptNPCName + 1], a
	xor a
	start_script
	script_command_01
	check_event EVENT_MIYUKIS_ROOM_DOOR_STATE
	script_jump_if_b0z .ows_31c13
	check_event EVENT_TALKED_TO_MIYUKI
	script_jump_if_b0z .ows_31bef
	set_event EVENT_TALKED_TO_MIYUKI
	print_npc_text Text0da4
	script_jump .ows_31bf2
.ows_31bef
	print_npc_text Text0da5
.ows_31bf2
	ask_question Text0da6, TRUE
	script_jump_if_b0z .ows_31c0d
	duel_requirement_check DUEL_REQUIREMENT_MIYUKI
	script_jump_if_b1z .ows_31c04
	print_npc_text Text0da7
	script_jump .ows_31c10
.ows_31c04
	print_npc_text Text0da8
	script_command_02
	start_duel STICKY_POISON_GAS_DECK_ID, MUSIC_MATCH_START_MEMBER
	end_script
	ret
.ows_31c0d
	print_npc_text Text0da9
.ows_31c10
	script_command_02
	end_script
	ret
.ows_31c13
	print_npc_text Text0daa
	ask_question Text0da6, TRUE
	script_jump_if_b0z .ows_31c31
	duel_requirement_check DUEL_REQUIREMENT_MIYUKI
	script_jump_if_b1z .ows_31c28
	print_npc_text Text0dab
	script_jump .ows_31c34
.ows_31c28
	print_npc_text Text0dac
	script_command_02
	start_duel STICKY_POISON_GAS_DECK_ID, MUSIC_MATCH_START_MEMBER
	end_script
	ret
.ows_31c31
	print_npc_text Text0dad
.ows_31c34
	script_command_02
	end_script
	ret

Func_31c37:
	xor a
	start_script
	script_command_01
	check_event EVENT_MIYUKIS_ROOM_DOOR_STATE
	script_jump_if_b0z .ows_31c5a
	check_event EVENT_SET_UNTIL_MAP_RELOAD_2
	script_jump_if_b0nz .ows_31c54
	set_event EVENT_MIYUKIS_ROOM_DOOR_STATE
	print_npc_text Text0dae
	give_booster_packs BoosterList_cd56
	print_npc_text Text0daf
	script_jump .ows_31c71
.ows_31c54
	print_npc_text Text0db0
	script_command_02
	end_script
	ret
.ows_31c5a
	check_event EVENT_SET_UNTIL_MAP_RELOAD_2
	script_jump_if_b0nz .ows_31c6b
	print_npc_text Text0db1
	give_booster_packs BoosterList_cd56
	print_npc_text Text0db2
	script_jump .ows_31c6e
.ows_31c6b
	print_npc_text Text0db3
.ows_31c6e
	script_command_02
	end_script
	ret
.ows_31c71
	print_npc_text Text0db4
	script_command_02
	get_player_direction
	compare_loaded_var SOUTH
	script_jump_if_b0z .ows_31c80
	set_player_direction WEST
	animate_player_movement $81, $02
.ows_31c80
	move_active_npc .NPCMovement_31c9a
	wait_for_player_animation
	do_frames 30
	play_sfx SFX_DOORS
	load_tilemap TILEMAP_062, $05, $00
	do_frames 30
	move_active_npc .NPCMovement_31ca1
	wait_for_player_animation
	script_command_01
	print_npc_text Text0db5
	script_command_02
	end_script
	ret
.NPCMovement_31c9a:
	db NORTH, MOVE_3
	db WEST, MOVE_3
	db NORTH, MOVE_1
	db $ff
.NPCMovement_31ca1:
	db SOUTH, MOVE_1
	db EAST, MOVE_3
	db SOUTH, MOVE_3
	db $ff

Func_31ca8:
	ld a, EVENT_MIYUKIS_ROOM_DOOR_STATE
	farcall GetEventValue
	jr nz, .asm_31cba
	xor a
	start_script
	script_command_01
	print_text DoorsAreShutText
	script_command_02
	end_script
.asm_31cba
	farcall Func_c199
	ret

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
	npc_script NPC_GR_CLERK_LIGHTNING_FORT, Func_31d6e
	db $ff

LightningFortEntrance_OWInteractions:
	ow_script 4, 8, Func_31da0
	ow_script 5, 8, Func_31da0
	db $ff

LightningFortEntrance_MapScripts:
	dbw $06, Func_31d27
	dbw $08, Func_31d5e
	dbw $07, Func_31d2e
	dbw $02, Func_31d37
	db $ff

Func_31d27:
	ld hl, LightningFortEntrance_StepEvents
	call Func_324d
	ret

Func_31d2e:
	ld hl, LightningFortEntrance_NPCs
	call Func_3205
	scf
	ccf
	ret

Func_31d37:
	ld a, EVENT_LIGHTNING_FORT_ENTRANCE_DOOR_STATE
	farcall GetEventValue
	jr z, .asm_31d41
	jr .asm_31d5c
.asm_31d41
	ld bc, TILEMAP_065
	lb de, 4, 7
	farcall Func_12c0ce
	ld a, EVENT_GOT_GOLBAT_COIN
	farcall GetEventValue
	jr nz, .asm_31d5c
	ld a, NPC_GR_CLERK_LIGHTNING_FORT
	lb de, 4, 8
	farcall SetOWObjectTilePosition
.asm_31d5c
	scf
	ret

Func_31d5e:
	ld hl, LightningFortEntrance_NPCInteractions
	call Func_328c
	jr nc, .asm_31d6c
	ld hl, LightningFortEntrance_OWInteractions
	call Func_32bf
.asm_31d6c
	scf
	ret

Func_31d6e:
	ld a, NPC_GR_CLERK_LIGHTNING_FORT
	ld [wScriptNPC], a
	ldtx hl, DialogReceptionistText
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [wScriptNPCName + 1], a
	xor a
	start_script
	script_command_01
	check_event EVENT_GOT_MAGNEMITE_COIN
	script_jump_if_b0z .ows_31d9a
	check_event EVENT_GOT_GOLBAT_COIN
	script_jump_if_b0z .ows_31d93
	print_npc_text Text11ab
	script_jump .ows_31d9d
.ows_31d93
	script_call Script_31dce
	script_jump .ows_31d9d
.ows_31d9a
	print_npc_text Text11ac
.ows_31d9d
	script_command_02
	end_script
	ret

Func_31da0:
	ld a, EVENT_LIGHTNING_FORT_ENTRANCE_DOOR_STATE
	farcall GetEventValue
	jr nz, .asm_31dcd
	xor a
	start_script
	script_command_01
	print_text Text11ad
	check_event EVENT_GOT_GOLBAT_COIN
	script_jump_if_b0nz .ows_31dcb
	ask_question Text11ae, TRUE
	script_jump_if_b0z .ows_31dcb
	send_mail $15
	set_event EVENT_LIGHTNING_FORT_ENTRANCE_DOOR_STATE
	script_command_02
	play_sfx SFX_DOORS
	load_tilemap TILEMAP_066, $04, $07
	end_script
	jr .asm_31dcd
.ows_31dcb
	script_command_02
	end_script
.asm_31dcd
	ret

Script_31dce:
	print_npc_text Text11af
	script_ret

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
	npc_script NPC_LIGHTNING_FORT_GR_LASS, Func_31e82
	npc_script NPC_LIGHTNING_FORT_GR_WOMAN, Func_31ee8
	npc_script NPC_LIGHTNING_FORT_CHUBBY_KID, Func_31f2c
	npc_script NPC_TAP, Func_31f52
	db $ff

LightningFortLobby_OWInteractions:
	ow_script 1, 2, PCMenu
	ow_script 2, 2, PCMenu
	ow_script 5, 4, Func_3c1d0
	ow_script 8, 4, Func_3c2d9
	db $ff

LightningFortLobby_MapScripts:
	dbw $06, Func_31e52
	dbw $08, Func_31e62
	dbw $09, Func_31e72
	dbw $07, Func_31e59
	db $ff

Func_31e52:
	ld hl, LightningFortLobby_StepEvents
	call Func_324d
	ret

Func_31e59:
	ld hl, LightningFortLobby_NPCs
	call Func_3205
	scf
	ccf
	ret

Func_31e62:
	ld hl, LightningFortLobby_NPCInteractions
	call Func_328c
	jr nc, .asm_31e70
	ld hl, LightningFortLobby_OWInteractions
	call Func_32bf
.asm_31e70
	scf
	ret

Func_31e72:
	ld hl, LightningFortLobby_AfterDuelScripts
	ld a, [wScriptNPC]
	call Func_344c
	scf
	ret

LightningFortLobby_AfterDuelScripts:
	npc_script NPC_TAP, Func_31f8f
	db $ff

Func_31e82:
	ld a, NPC_LIGHTNING_FORT_GR_LASS
	ld [wScriptNPC], a
	ldtx hl, DialogGRKidText
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [wScriptNPCName + 1], a
	xor a
	start_script
	script_command_01
	check_event EVENT_TRADED_CARDS_LIGHTNING_FORT
	script_jump_if_b0z .ows_31ee2
	check_event EVENT_TALKED_TO_TRADE_NPC_LIGHTNING_FORT
	script_jump_if_b0z .ows_31ea9
	set_event EVENT_TALKED_TO_TRADE_NPC_LIGHTNING_FORT
	print_npc_text Text11ec
	script_jump .ows_31eac
.ows_31ea9
	print_npc_text Text11ed
.ows_31eac
	ask_question TradeCardsPromptText, TRUE
	script_jump_if_b0nz .ows_31eb9
	print_npc_text Text11ee
	script_jump .ows_31ee5
.ows_31eb9
	get_card_count_in_collection_and_decks DARK_RAICHU
	script_jump_if_b0z .ows_31ec5
	print_npc_text Text11ef
	script_jump .ows_31ee5
.ows_31ec5
	get_card_count_in_collection DARK_RAICHU
	script_jump_if_b0z .ows_31ed1
	print_npc_text Text11f0
	script_jump .ows_31ee5
.ows_31ed1
	print_npc_text Text11f1
	receive_card PIKACHU_LV16
	take_card DARK_RAICHU
	set_event EVENT_TRADED_CARDS_LIGHTNING_FORT
	print_npc_text Text11f2
	script_jump .ows_31ee5
.ows_31ee2
	print_npc_text Text11f3
.ows_31ee5
	script_command_02
	end_script
	ret

Func_31ee8:
	ld a, NPC_LIGHTNING_FORT_GR_WOMAN
	ld [wScriptNPC], a
	ldtx hl, DialogGRLightningWomanText
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [wScriptNPCName + 1], a
	xor a
	start_script
	script_command_01
	check_event EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE
	script_jump_if_b0z .ows_31f26
	check_event EVENT_FREED_ROD
	script_jump_if_b0z .ows_31f20
	check_event EVENT_GOT_MAGMAR_COIN
	script_jump_if_b0nz .ows_31f14
	check_event EVENT_GOT_PSYDUCK_COIN
	script_jump_if_b0nz .ows_31f14
	script_jump .ows_31f1a
.ows_31f14
	print_npc_text Text11f4
	script_jump .ows_31f29
.ows_31f1a
	print_npc_text Text11f5
	script_jump .ows_31f29
.ows_31f20
	print_npc_text Text11f6
	script_jump .ows_31f29
.ows_31f26
	print_npc_text Text11f7
.ows_31f29
	script_command_02
	end_script
	ret

Func_31f2c:
	ld a, NPC_LIGHTNING_FORT_CHUBBY_KID
	ld [wScriptNPC], a
	ldtx hl, DialogChubbyKidText
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [wScriptNPCName + 1], a
	xor a
	start_script
	script_command_01
	check_event EVENT_TRADED_CARDS_LIGHTNING_FORT
	script_jump_if_b0z .ows_31f4c
	print_npc_text Text11f8
	script_jump .ows_31f4f
.ows_31f4c
	print_npc_text Text11f9
.ows_31f4f
	script_command_02
	end_script
	ret

Func_31f52:
	ld a, NPC_TAP
	ld [wScriptNPC], a
	ldtx hl, DialogTapText
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [wScriptNPCName + 1], a
	xor a
	start_script
	script_command_01
	check_event EVENT_TALKED_TO_TAP
	script_jump_if_b0z .ows_31f74
	set_event EVENT_TALKED_TO_TAP
	print_npc_text Text11fa
	script_jump .ows_31f77
.ows_31f74
	print_npc_text Text11fb
.ows_31f77
	ask_question Text11fc, TRUE
	script_jump_if_b0z .ows_31f87
	print_npc_text Text11fd
	script_command_02
	start_duel DANGEROUS_BENCH_DECK_ID, MUSIC_MATCH_START_MEMBER
	end_script
	ret
.ows_31f87
	print_npc_text Text11fe
	script_command_02
	set_active_npc_direction WEST
	end_script
	ret

Func_31f8f:
	xor a
	start_script
	script_command_01
	check_event EVENT_SET_UNTIL_MAP_RELOAD_2
	script_jump_if_b0nz .ows_31fa5
	print_npc_text Text11ff
	give_booster_packs BoosterList_cd67
	print_npc_text Text1200
	script_jump .ows_31fa8
.ows_31fa5
	print_npc_text Text1201
.ows_31fa8
	set_active_npc_direction WEST
	script_command_02
	end_script
	ret

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
	npc_script NPC_RENNA, Func_32057
	db $ff

LightningFortRenna_OWInteractions:
	ow_script 4, 1, Func_320f5
	ow_script 5, 1, Func_320f5
	db $ff

LightningFortRenna_MapScripts:
	dbw $06, Func_32006
	dbw $08, Func_32037
	dbw $09, Func_32047
	dbw $07, Func_3200d
	dbw $02, Func_32016
	db $ff

Func_32006:
	ld hl, LightningFortRenna_StepEvents
	call Func_324d
	ret

Func_3200d:
	ld hl, LightningFortRenna_NPCs
	call Func_3205
	scf
	ccf
	ret

Func_32016:
	ld a, [wd584]
	cp MAP_LIGHTNING_FORT_ENTRANCE
	jr nz, .asm_32021
	farcall DeliverMailFromQueue
.asm_32021
	ld a, EVENT_RENNAS_ROOM_DOOR_STATE
	farcall GetEventValue
	jr z, .asm_3202b
	scf
	ret
.asm_3202b
	ld bc, TILEMAP_069
	lb de, 4, 0
	farcall Func_12c0ce
	scf
	ret

Func_32037:
	ld hl, LightningFortRenna_NPCInteractions
	call Func_328c
	jr nc, .asm_32045
	ld hl, LightningFortRenna_OWInteractions
	call Func_32bf
.asm_32045
	scf
	ret

Func_32047:
	ld hl, LightningFortRenna_AfterDuelScripts
	ld a, [wScriptNPC]
	call Func_344c
	scf
	ret

LightningFortRenna_AfterDuelScripts:
	npc_script NPC_RENNA, Func_320bb
	db $ff

Func_32057:
	ld a, NPC_RENNA
	ld [wScriptNPC], a
	ldtx hl, DialogRennaText
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [wScriptNPCName + 1], a
	xor a
	start_script
	script_command_01
	check_event EVENT_RENNAS_ROOM_DOOR_STATE
	script_jump_if_b0z .ows_32097
	set_event EVENT_TALKED_TO_RENNA
	print_npc_text Text11db
	ask_question Text11dc, TRUE
	script_jump_if_b0z .ows_32091
	duel_requirement_check DUEL_REQUIREMENT_RENNA
	script_jump_if_b1z .ows_32088
	print_npc_text Text11dd
	script_jump .ows_32094
.ows_32088
	print_npc_text Text11de
	script_command_02
	start_duel CHAIN_LIGHTNING_BY_PIKACHU_DECK_ID, MUSIC_MATCH_START_MEMBER
	end_script
	ret
.ows_32091
	print_npc_text Text11df
.ows_32094
	script_command_02
	end_script
	ret
.ows_32097
	print_npc_text Text11e0
	ask_question Text11dc, TRUE
	script_jump_if_b0z .ows_320b5
	duel_requirement_check DUEL_REQUIREMENT_RENNA
	script_jump_if_b1z .ows_320ac
	print_npc_text Text11e1
	script_jump .ows_320b8
.ows_320ac
	print_npc_text Text11e2
	script_command_02
	start_duel CHAIN_LIGHTNING_BY_PIKACHU_DECK_ID, MUSIC_MATCH_START_MEMBER
	end_script
	ret
.ows_320b5
	print_npc_text Text11e3
.ows_320b8
	script_command_02
	end_script
	ret

Func_320bb:
	xor a
	start_script
	script_command_01
	check_event EVENT_RENNAS_ROOM_DOOR_STATE
	script_jump_if_b0z .ows_320de
	check_event EVENT_SET_UNTIL_MAP_RELOAD_2
	script_jump_if_b0nz .ows_320d8
	set_event EVENT_RENNAS_ROOM_DOOR_STATE
	print_npc_text Text11e4
	give_booster_packs BoosterList_cd5d
	print_npc_text Text11e5
	script_jump Script_3211e
.ows_320d8
	print_npc_text Text11e6
	script_command_02
	end_script
	ret
.ows_320de
	check_event EVENT_SET_UNTIL_MAP_RELOAD_2
	script_jump_if_b0nz .ows_320ef
	print_npc_text Text11e7
	give_booster_packs BoosterList_cd5d
	print_npc_text Text11e8
	script_jump .ows_320f2
.ows_320ef
	print_npc_text Text11e6
.ows_320f2
	script_command_02
	end_script
	ret

Func_320f5:
	ld a, EVENT_RENNAS_ROOM_DOOR_STATE
	farcall GetEventValue
	jr nz, .asm_32119
	ld a, NPC_RENNA
	ld [wScriptNPC], a
	ldtx hl, DialogRennaText
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [wScriptNPCName + 1], a
	xor a
	start_script
	script_command_01
	set_active_npc_direction EAST
	print_npc_text Text11e9
	script_command_02
	end_script
.asm_32119
	farcall Func_c199
	ret

Script_3211e:
	set_active_npc_direction NORTH
	print_npc_text Text11ea
	script_command_02
	do_frames 60
	play_sfx_and_wait SFX_ELECTRONIC_INPUT
	do_frames 30
	play_sfx_and_wait SFX_ELECTRONIC_INPUT
	do_frames 30
	play_sfx_and_wait SFX_ELECTRONIC_INPUT
	do_frames 30
	play_sfx_and_wait SFX_ELECTRONIC_RESPONSE
	do_frames 60
	play_sfx SFX_DOORS
	load_tilemap TILEMAP_06A, $04, $00
	do_frames 60
	set_active_npc_direction EAST
	script_command_01
	print_npc_text Text11eb
	script_command_02
	end_script
	ret

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
	npc_script NPC_ICHIKAWA, Func_32204
	db $ff

LightningFortIchikawa_OWInteractions:
	ow_script 4, 1, Func_323f0
	ow_script 5, 1, Func_323f0
	ow_script 3, 3, Func_32407
	db $ff

LightningFortIchikawa_MapScripts:
	dbw $06, Func_321aa
	dbw $08, Func_321e4
	dbw $09, Func_321f4
	dbw $07, Func_321b1
	dbw $02, Func_321ba
	db $ff

Func_321aa:
	ld hl, LightningFortIchikawa_StepEvents
	call Func_324d
	ret

Func_321b1:
	ld hl, LightningFortIchikawa_NPCs
	call Func_3205
	scf
	ccf
	ret

Func_321ba:
	ld bc, TILEMAP_06C
	lb de, 3, 0
	farcall Func_12c0ce
	ld a, EVENT_ICHIKAWAS_ROOM_DOOR_STATE
	farcall GetEventValue
	jr z, .asm_321d8
	ld bc, TILEMAP_06D
	lb de, 1, 2
	farcall Func_12c0ce
	jr .asm_321e2
.asm_321d8
	ld bc, TILEMAP_06E
	lb de, 4, 0
	farcall Func_12c0ce
.asm_321e2
	scf
	ret

Func_321e4:
	ld hl, LightningFortIchikawa_NPCInteractions
	call Func_328c
	jr nc, .asm_321f2
	ld hl, LightningFortIchikawa_OWInteractions
	call Func_32bf
.asm_321f2
	scf
	ret

Func_321f4:
	ld hl, LightningFortIchikawa_AfterDuelScripts
	ld a, [wScriptNPC]
	call Func_344c
	scf
	ret

LightningFortIchikawa_AfterDuelScripts:
	npc_script NPC_ICHIKAWA, Func_322a1
	db $ff

Func_32204:
	ld a, NPC_ICHIKAWA
	ld [wScriptNPC], a
	ldtx hl, DialogIchikawaText
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [wScriptNPCName + 1], a
	xor a
	start_script
	script_command_01
	check_event EVENT_ICHIKAWAS_ROOM_DOOR_STATE
	script_jump_if_b0z .ows_3227d
	check_event EVENT_TALKED_TO_ICHIKAWA
	script_jump_if_b0z .ows_32259
	set_event EVENT_TALKED_TO_ICHIKAWA
	print_npc_text Text11b0
	script_command_02
	get_active_npc_direction
	play_sfx SFX_NPC_WARP_TRANSFORM
	load_npc NPC_WARP_SPARKLES, 5, 5, SOUTH
	reset_npc_flag6 NPC_ICHIKAWA
	wait_for_npc_animation NPC_WARP_SPARKLES
	load_npc NPC_GR_3, 5, 5, EAST
	restore_npc_direction NPC_GR_3
	unload_npc NPC_WARP_SPARKLES
	script_command_01
	print_npc_text Text11b1
	script_command_02
	play_sfx SFX_NPC_WARP_TRANSFORM
	load_npc NPC_WARP_SPARKLES, 5, 5, SOUTH
	unload_npc NPC_GR_3
	wait_for_npc_animation NPC_WARP_SPARKLES
	set_npc_flag6 NPC_ICHIKAWA
	unload_npc NPC_WARP_SPARKLES
	script_command_01
	print_npc_text Text11b2
	script_jump .ows_3225c
.ows_32259
	print_npc_text Text11b3
.ows_3225c
	ask_question Text11b4, TRUE
	script_jump_if_b0z .ows_32277
	duel_requirement_check DUEL_REQUIREMENT_ICHIKAWA
	script_jump_if_b1z .ows_3226e
	print_npc_text Text11b5
	script_jump .ows_3227a
.ows_3226e
	print_npc_text Text11b6
	script_command_02
	start_duel THIS_IS_THE_POWER_OF_ELECTRICITY_DECK_ID, MUSIC_MATCH_START_MEMBER
	end_script
	ret
.ows_32277
	print_npc_text Text11b7
.ows_3227a
	script_command_02
	end_script
	ret
.ows_3227d
	print_npc_text Text11b8
	ask_question Text11b4, TRUE
	script_jump_if_b0z .ows_3229b
	duel_requirement_check DUEL_REQUIREMENT_ICHIKAWA
	script_jump_if_b1z .ows_32292
	print_npc_text Text11b9
	script_jump .ows_3229e
.ows_32292
	print_npc_text Text11ba
	script_command_02
	start_duel THIS_IS_THE_POWER_OF_ELECTRICITY_DECK_ID, MUSIC_MATCH_START_MEMBER
	end_script
	ret
.ows_3229b
	print_npc_text Text11bb
.ows_3229e
	script_command_02
	end_script
	ret

Func_322a1:
	xor a
	start_script
	script_command_01
	check_event EVENT_ICHIKAWAS_ROOM_DOOR_STATE
	script_jump_if_b0z .ows_322c4
	check_event EVENT_SET_UNTIL_MAP_RELOAD_2
	script_jump_if_b0nz .ows_322be
	set_event EVENT_ICHIKAWAS_ROOM_DOOR_STATE
	print_npc_text Text11bc
	give_booster_packs BoosterList_cd60
	print_npc_text Text11bd
	script_jump .ows_322db
.ows_322be
	print_npc_text Text11be
	script_command_02
	end_script
	ret
.ows_322c4
	check_event EVENT_SET_UNTIL_MAP_RELOAD_2
	script_jump_if_b0nz .ows_322d5
	print_npc_text Text11bf
	give_booster_packs BoosterList_cd60
	print_npc_text Text11c0
	script_jump .ows_322d8
.ows_322d5
	print_npc_text Text11c1
.ows_322d8
	script_command_02
	end_script
	ret
.ows_322db
	set_event EVENT_FREED_STEVE
	reset_event EVENT_TALKED_TO_BRITTANY
	reset_event EVENT_TALKED_TO_HEATHER
	reset_event EVENT_TALKED_TO_AMY
	reset_event EVENT_TALKED_TO_AMANDA
	reset_event EVENT_TALKED_TO_ISAAC
	reset_event EVENT_TALKED_TO_KEN
	reset_event EVENT_TALKED_TO_ADAM
	reset_event EVENT_TALKED_TO_ROBERT
	set_var VAR_28, $02
	print_npc_text Text11c2
	script_command_02
	get_player_direction
	compare_loaded_var SOUTH
	script_jump_if_b0nz .ows_3230d
	compare_loaded_var EAST
	script_jump_if_b0nz .ows_32306
	move_player .NPCMovement_32367, TRUE
	script_jump .ows_32311
.ows_32306
	move_player .NPCMovement_3236c, TRUE
	script_jump .ows_32311
.ows_3230d
	move_player .NPCMovement_32371, TRUE
.ows_32311
	move_active_npc .NPCMovement_32362
	wait_for_player_animation
	do_frames 30
	script_command_01
	play_sfx SFX_AVALANCHE
	print_npc_text_instant Text11c3
	script_command_67 $06, $1e
	do_frames 60
	script_command_68
	script_command_02
	do_frames 28
	do_frames 30
	play_sfx SFX_POD_DOORS
	load_npc NPC_POD_DOORS, 3, 1, SOUTH
	load_tilemap TILEMAP_070, $03, $00
	wait_for_npc_animation NPC_POD_DOORS
	unload_npc NPC_POD_DOORS
	do_frames 30
	load_tilemap TILEMAP_06D, $01, $02
	load_tilemap TILEMAP_06C, $03, $00
	load_npc NPC_STEVE, 3, 3, SOUTH
	set_active_npc_direction SOUTH
	do_frames 30
	set_active_npc NPC_STEVE, DialogSteveText
	script_command_01
	print_npc_text Text11c4
	receive_card ELECTABUZZ_LV20
	print_npc_text Text11c5
	script_command_02
	animate_active_npc_movement $01, $01
	script_jump Script_32376
.NPCMovement_32362:
	db NORTH, MOVE_3
	db WEST, MOVE_0
	db $ff
.NPCMovement_32367:
	db WEST, MOVE_2
	db NORTH, MOVE_2
	db $ff
.NPCMovement_3236c:
	db WEST, MOVE_1
	db NORTH, MOVE_1
	db $ff
.NPCMovement_32371:
	db WEST, MOVE_2
	db NORTH, MOVE_0
	db $ff

Script_32376:
	set_active_npc NPC_ICHIKAWA, DialogIchikawaText
	script_command_01
	print_npc_text Text11c6
	set_active_npc NPC_STEVE, DialogSteveText
	print_npc_text Text11c7
	script_command_02
	set_active_npc_direction NORTH
	set_active_npc NPC_ICHIKAWA, DialogIchikawaText
	animate_active_npc_movement $03, $01
	set_active_npc_direction SOUTH
	script_command_01
	print_npc_text Text11c8
	set_active_npc NPC_STEVE, DialogSteveText
	print_npc_text Text11c9
	script_command_02
	animate_active_npc_movement $02, $01
	set_active_npc_direction WEST
	set_player_direction EAST
	script_command_01
	print_npc_text Text11ca
	script_command_02
	move_active_npc .NPCMovement_323b2
	wait_for_player_animation
	unload_npc NPC_STEVE
	script_jump Script_323b5
.NPCMovement_323b2:
	db SOUTH, MOVE_8
	db $ff

Script_323b5:
	set_active_npc NPC_ICHIKAWA, DialogIchikawaText
	script_command_01
	set_player_direction NORTH
	print_npc_text Text11cb
	script_command_02
	do_frames 30
	set_active_npc_direction NORTH
	do_frames 30
	script_command_01
	play_sfx SFX_AVALANCHE
	print_npc_text_instant Text11cc
	script_command_67 $04, $1e
	script_command_68
	script_command_02
	do_frames 30
	play_sfx SFX_DOORS
	load_tilemap TILEMAP_06F, $04, $00
	do_frames 60
	set_active_npc_direction SOUTH
	script_command_01
	print_npc_text Text11cd
	script_command_02
	move_active_npc .NPCMovement_323e9
	wait_for_player_animation
	end_script
	ret
.NPCMovement_323e9:
	db EAST, MOVE_1
	db SOUTH, MOVE_3
	db EAST, MOVE_0
	db $ff

Func_323f0:
	ld a, EVENT_ICHIKAWAS_ROOM_DOOR_STATE
	farcall GetEventValue
	jr nz, .asm_32402
	xor a
	start_script
	script_command_01
	print_text DoorsAreShutText
	script_command_02
	end_script
.asm_32402
	farcall Func_c199
	ret

Func_32407:
	ld a, EVENT_FREED_STEVE
	farcall GetEventValue
	jr nz, .asm_32419
	xor a
	start_script
	script_command_01
	print_text Text11ce
	script_command_02
	end_script
.asm_32419
	farcall Func_c199
	ret

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
	npc_script NPC_CATHERINE, Func_32477
	db $ff

LightningFortCatherine_MapScripts:
	dbw $06, Func_3244f
	dbw $08, Func_3245f
	dbw $09, Func_32467
	dbw $07, Func_32456
	db $ff

Func_3244f:
	ld hl, LightningFortCatherine_StepEvents
	call Func_324d
	ret

Func_32456:
	ld hl, LightningFortCatherine_NPCs
	call Func_3205
	scf
	ccf
	ret

Func_3245f:
	ld hl, LightningFortCatherine_NPCInteractions
	call Func_32aa
	scf
	ret

Func_32467:
	ld hl, LightningFortCatherine_AfterDuelScripts
	ld a, [wScriptNPC]
	call Func_344c
	scf
	ret

LightningFortCatherine_AfterDuelScripts:
	npc_script NPC_CATHERINE, Func_324e1
	db $ff

Func_32477:
	ld a, NPC_CATHERINE
	ld [wScriptNPC], a
	ldtx hl, DialogCatherineText
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [wScriptNPCName + 1], a
	xor a
	start_script
	script_command_01
	check_event EVENT_BEAT_CATHERINE
	script_jump_if_b0z .ows_324c4
	check_event EVENT_TALKED_TO_CATHERINE
	script_jump_if_b0z .ows_324a7
	set_event EVENT_TALKED_TO_CATHERINE
	print_npc_text Text11cf
	script_command_02
	get_player_opposite_direction
	restore_active_npc_direction
	do_frames 30
	script_command_01
	print_npc_text Text11d0
	script_jump .ows_324ac
.ows_324a7
	get_player_opposite_direction
	restore_active_npc_direction
	print_npc_text Text11d1
.ows_324ac
	ask_question Text11d2, TRUE
	script_jump_if_b0z .ows_324bc
	print_npc_text Text11d3
	script_command_02
	start_duel QUICK_ATTACK_DECK_ID, MUSIC_MATCH_START_GR_LEADER
	end_script
	ret
.ows_324bc
	print_npc_text Text11d4
	script_command_02
	set_active_npc_direction NORTH
	end_script
	ret
.ows_324c4
	get_player_opposite_direction
	restore_active_npc_direction
	print_npc_text Text11d5
	ask_question Text11d2, TRUE
	script_jump_if_b0z .ows_324d9
	print_npc_text Text11d3
	script_command_02
	start_duel QUICK_ATTACK_DECK_ID, MUSIC_MATCH_START_GR_LEADER
	end_script
	ret
.ows_324d9
	print_npc_text Text11d4
	script_command_02
	set_active_npc_direction NORTH
	end_script
	ret

Func_324e1:
	xor a
	start_script
	script_command_01
	check_event EVENT_BEAT_CATHERINE
	script_jump_if_b0z .ows_3250b
	check_event EVENT_SET_UNTIL_MAP_RELOAD_2
	script_jump_if_b0nz .ows_32503
	set_event EVENT_BEAT_CATHERINE
	set_var VAR_30, $01
	set_var VAR_33, $00
	send_mail $07
	print_npc_text Text11d6
	give_booster_packs BoosterList_cd63
	script_jump .ows_32524
.ows_32503
	print_npc_text Text11d7
	script_command_02
	set_active_npc_direction NORTH
	end_script
	ret
.ows_3250b
	check_event EVENT_SET_UNTIL_MAP_RELOAD_2
	script_jump_if_b0nz .ows_3251c
	print_npc_text Text11d6
	give_booster_packs BoosterList_cd63
	print_npc_text Text11d8
	script_jump .ows_3251f
.ows_3251c
	print_npc_text Text11d7
.ows_3251f
	script_command_02
	set_active_npc_direction NORTH
	end_script
	ret
.ows_32524
	set_event EVENT_GOT_MAGNEMITE_COIN
	print_npc_text Text11d9
	give_coin COIN_MAGNEMITE
	print_npc_text Text11da
	script_command_02
	end_script
	ret

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
	npc_script NPC_GR_CLERK_FIRE_FORT, Func_32632
	db $ff

FireFortEntrance_OWInteractions:
	ow_script 4, 8, Func_32664
	ow_script 5, 8, Func_32664
	db $ff

FireFortEntrance_MapScripts:
	dbw $06, Func_325bc
	dbw $08, Func_3261c
	dbw $07, Func_325c3
	dbw $02, Func_325cc
	dbw $09, Func_3262c
	dbw $10, Func_3259f
	db $ff

Func_3259f:
	ld a, EVENT_GOT_MAGMAR_COIN
	farcall GetEventValue
	jr z, .asm_325b1
	ld a, VAR_TIMES_MET_RONALD
	farcall GetVarValue
	cp $06
	jr c, .asm_325b3
.asm_325b1
	scf
	ret
.asm_325b3
	ld a, MUSIC_RONALD
	farcall PlayAfterCurrentSong
	scf
	ccf
	ret

Func_325bc:
	ld hl, FireFortEntrance_StepEvents
	call Func_324d
	ret

Func_325c3:
	ld hl, FireFortEntrance_NPCs
	call Func_3205
	scf
	ccf
	ret

Func_325cc:
	ld a, EVENT_FIRE_FORT_ENTRANCE_DOOR_STATE
	farcall GetEventValue
	jr z, .asm_325e0
	ld a, VAR_TIMES_MET_RONALD
	farcall GetVarValue
	cp $06
	jr c, .asm_325fd
	jr .asm_3261a
.asm_325e0
	ld bc, TILEMAP_073
	lb de, 4, 7
	farcall Func_12c0ce
	ld a, EVENT_GOT_MAGNEMITE_COIN
	farcall GetEventValue
	jr nz, .asm_3261a
	ld a, NPC_GR_CLERK_FIRE_FORT
	lb de, 4, 8
	farcall SetOWObjectTilePosition
	jr .asm_3261a
.asm_325fd
	ld a, EVENT_GOT_MAGMAR_COIN
	farcall GetEventValue
	jr z, .asm_3261a
	ld a, $0a
	ld [wd582], a
	ld a, BANK(Func_34391)
	ld [wd592], a
	ld hl, Func_34391
	ld a, l
	ld [wd593], a
	ld a, h
	ld [wd593 + 1], a
.asm_3261a
	scf
	ret

Func_3261c:
	ld hl, FireFortEntrance_NPCInteractions
	call Func_328c
	jr nc, .asm_3262a
	ld hl, FireFortEntrance_OWInteractions
	call Func_32bf
.asm_3262a
	scf
	ret

Func_3262c:
	farcall Func_343ef
	scf
	ret

Func_32632:
	ld a, NPC_GR_CLERK_FIRE_FORT
	ld [wScriptNPC], a
	ldtx hl, DialogReceptionistText
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [wScriptNPCName + 1], a
	xor a
	start_script
	script_command_01
	check_event EVENT_GOT_MAGMAR_COIN
	script_jump_if_b0z .ows_3265e
	check_event EVENT_GOT_MAGNEMITE_COIN
	script_jump_if_b0z .ows_32657
	print_npc_text Text0c80
	script_jump .ows_32661
.ows_32657
	script_call Script_32692
	script_jump .ows_32661
.ows_3265e
	print_npc_text Text0c81
.ows_32661
	script_command_02
	end_script
	ret

Func_32664:
	ld a, EVENT_FIRE_FORT_ENTRANCE_DOOR_STATE
	farcall GetEventValue
	jr nz, .asm_32691
	xor a
	start_script
	script_command_01
	print_text Text0c82
	check_event EVENT_GOT_MAGNEMITE_COIN
	script_jump_if_b0nz .ows_3268f
	ask_question Text0c83, TRUE
	script_jump_if_b0z .ows_3268f
	send_mail $16
	set_event EVENT_FIRE_FORT_ENTRANCE_DOOR_STATE
	script_command_02
	play_sfx SFX_DOORS
	load_tilemap TILEMAP_074, $04, $07
	end_script
	jr .asm_32691
.ows_3268f
	script_command_02
	end_script
.asm_32691
	ret

Script_32692:
	print_npc_text Text0c84
	script_ret

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
	npc NPC_IMAKUNI_RED, 12, 1, NORTH, Func_327f5
	npc NPC_GR_CLERK_BATTLE_CENTER, 5, 2, SOUTH, NULL
	npc NPC_GR_CLERK_GIFT_CENTER, 8, 2, SOUTH, NULL
	db $ff

FireFortLobby_NPCInteractions:
	npc_script NPC_FIRE_FORT_GRAMPY, Func_32769
	npc_script NPC_FIRE_FORT_YOUNGSTER, Func_327cf
	npc_script NPC_IMAKUNI_RED, Func_3c4e0
	db $ff

FireFortLobby_OWInteractions:
	ow_script 1, 2, PCMenu
	ow_script 2, 2, PCMenu
	ow_script 5, 4, Func_3c1d0
	ow_script 8, 4, Func_3c2d9
	db $ff

FireFortLobby_MapScripts:
	dbw $06, Func_32727
	dbw $08, Func_32737
	dbw $09, Func_32747
	dbw $0b, Func_3274d
	dbw $07, Func_3272e
	dbw $10, Func_32712
	db $ff

Func_32712:
	ld a, VAR_26
	farcall GetVarValue
	cp $07
	jr z, .asm_3271e
	scf
	ret
.asm_3271e
	ld a, MUSIC_IMAKUNI_RED
	farcall PlayAfterCurrentSong
	scf
	ccf
	ret

Func_32727:
	ld hl, FireFortLobby_StepEvents
	call Func_324d
	ret

Func_3272e:
	ld hl, FireFortLobby_NPCs
	call Func_3205
	scf
	ccf
	ret

Func_32737:
	ld hl, FireFortLobby_NPCInteractions
	call Func_328c
	jr nc, .asm_32745
	ld hl, FireFortLobby_OWInteractions
	call Func_32bf
.asm_32745
	scf
	ret

Func_32747:
	farcall Func_3c52d
	scf
	ret

Func_3274d:
	ld a, EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE_DUMMY
	farcall GetEventValue
	jr z, .asm_32767
	ld a, NPC_IMAKUNI_RED
	farcall ClearOWObject
	ld a, EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE_DUMMY
	farcall ZeroOutEventValue
	ld a, [wNextMusic]
	ld [wCurMusic], a
.asm_32767
	scf
	ret

Func_32769:
	ld a, NPC_FIRE_FORT_GRAMPY
	ld [wScriptNPC], a
	ldtx hl, DialogGRampyText
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [wScriptNPCName + 1], a
	xor a
	start_script
	script_command_01
	check_event EVENT_TRADED_CARDS_FIRE_FORT
	script_jump_if_b0z .ows_327c9
	check_event EVENT_TALKED_TO_TRADE_NPC_FIRE_FORT
	script_jump_if_b0z .ows_32790
	set_event EVENT_TALKED_TO_TRADE_NPC_FIRE_FORT
	print_npc_text Text0cba
	script_jump .ows_32793
.ows_32790
	print_npc_text Text0cbb
.ows_32793
	ask_question TradeCardsPromptText, TRUE
	script_jump_if_b0nz .ows_327a0
	print_npc_text Text0cbc
	script_jump .ows_327cc
.ows_327a0
	get_card_count_in_collection_and_decks DARK_CHARIZARD
	script_jump_if_b0z .ows_327ac
	print_npc_text Text0cbd
	script_jump .ows_327cc
.ows_327ac
	get_card_count_in_collection DARK_CHARIZARD
	script_jump_if_b0z .ows_327b8
	print_npc_text Text0cbe
	script_jump .ows_327cc
.ows_327b8
	print_npc_text Text0cbf
	receive_card CHARIZARD_ALT_LV76
	take_card DARK_CHARIZARD
	set_event EVENT_TRADED_CARDS_FIRE_FORT
	print_npc_text Text0cc0
	script_jump .ows_327cc
.ows_327c9
	print_npc_text Text0cc1
.ows_327cc
	script_command_02
	end_script
	ret

Func_327cf:
	ld a, NPC_FIRE_FORT_YOUNGSTER
	ld [wScriptNPC], a
	ldtx hl, DialogYoungsterText
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [wScriptNPCName + 1], a
	xor a
	start_script
	script_command_01
	check_event EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE
	script_jump_if_b0z .ows_327ef
	print_npc_text Text0cc2
	script_jump .ows_327f2
.ows_327ef
	print_npc_text Text0cc3
.ows_327f2
	script_command_02
	end_script
	ret

Func_327f5:
	ld a, VAR_26
	farcall GetVarValue
	cp $07
	jr z, .asm_32801
	scf
	ret
.asm_32801
	scf
	ccf
	ret

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
	npc_script NPC_JES, Func_328ae
	db $ff

FireFortJes_OWInteractions:
	ow_script 4, 1, Func_32956
	ow_script 5, 1, Func_32956
	db $ff

FireFortJes_MapScripts:
	dbw $06, Func_3285d
	dbw $08, Func_3288e
	dbw $09, Func_3289e
	dbw $07, Func_32864
	dbw $02, Func_3286d
	db $ff

Func_3285d:
	ld hl, FireFortJes_StepEvents
	call Func_324d
	ret

Func_32864:
	ld hl, FireFortJes_NPCs
	call Func_3205
	scf
	ccf
	ret

Func_3286d:
	ld a, [wd584]
	cp MAP_FIRE_FORT_ENTRANCE
	jr nz, .asm_32878
	farcall DeliverMailFromQueue
.asm_32878
	ld a, EVENT_JES_ROOM_DOOR_STATE
	farcall GetEventValue
	jr z, .asm_32882
	scf
	ret
.asm_32882
	ld bc, TILEMAP_077
	lb de, 4, 0
	farcall Func_12c0ce
	scf
	ret

Func_3288e:
	ld hl, FireFortJes_NPCInteractions
	call Func_328c
	jr nc, .asm_3289c
	ld hl, FireFortJes_OWInteractions
	call Func_32bf
.asm_3289c
	scf
	ret

Func_3289e:
	ld hl, FireFortJes_AfterDuelScripts
	ld a, [wScriptNPC]
	call Func_344c
	scf
	ret

FireFortJes_AfterDuelScripts:
	npc_script NPC_JES, Func_32907
	db $ff

Func_328ae:
	ld a, NPC_JES
	ld [wScriptNPC], a
	ldtx hl, DialogJesText
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [wScriptNPCName + 1], a
	xor a
	start_script
	script_command_01
	check_event EVENT_JES_ROOM_DOOR_STATE
	script_jump_if_b0z .ows_328ee
	check_event EVENT_TALKED_TO_JES
	script_jump_if_b0z .ows_328d5
	set_event EVENT_TALKED_TO_JES
	print_npc_text Text0c97
	script_jump .ows_328d8
.ows_328d5
	print_npc_text Text0c98
.ows_328d8
	ask_question Text0c99, TRUE
	script_jump_if_b0z .ows_328e8
	print_npc_text Text0c9a
	script_command_02
	start_duel COMPLETE_COMBUSTION_DECK_ID, MUSIC_MATCH_START_MEMBER
	end_script
	ret
.ows_328e8
	print_npc_text Text0c9b
	script_command_02
	end_script
	ret
.ows_328ee
	print_npc_text Text0c9c
	ask_question Text0c99, TRUE
	script_jump_if_b0z .ows_32901
	print_npc_text Text0c9d
	script_command_02
	start_duel COMPLETE_COMBUSTION_DECK_ID, MUSIC_MATCH_START_MEMBER
	end_script
	ret
.ows_32901
	print_npc_text Text0c9e
	script_command_02
	end_script
	ret

Func_32907:
	xor a
	start_script
	script_command_01
	check_event EVENT_JES_ROOM_DOOR_STATE
	script_jump_if_b0z .ows_32927
	check_event EVENT_SET_UNTIL_MAP_RELOAD_2
	script_jump_if_b0nz .ows_32921
	set_event EVENT_JES_ROOM_DOOR_STATE
	print_npc_text Text0c9f
	give_booster_packs BoosterList_cd6b
	script_jump .ows_3293e
.ows_32921
	print_npc_text Text0ca0
	script_command_02
	end_script
	ret
.ows_32927
	check_event EVENT_SET_UNTIL_MAP_RELOAD_2
	script_jump_if_b0nz .ows_32938
	print_npc_text Text0ca1
	give_booster_packs BoosterList_cd6b
	print_npc_text Text0ca2
	script_jump .ows_3293b
.ows_32938
	print_npc_text Text0ca3
.ows_3293b
	script_command_02
	end_script
	ret
.ows_3293e
	print_npc_text Text0ca4
	script_command_02
	get_active_npc_direction
	set_active_npc_direction NORTH
	do_frames 60
	play_sfx SFX_DOORS
	load_tilemap TILEMAP_078, $04, $00
	restore_active_npc_direction
	script_command_01
	print_npc_text Text0ca5
	script_command_02
	end_script
	ret

Func_32956:
	ld a, EVENT_JES_ROOM_DOOR_STATE
	farcall GetEventValue
	jr nz, .asm_32968
	xor a
	start_script
	script_command_01
	print_text DoorsAreShutText
	script_command_02
	end_script
.asm_32968
	farcall Func_c199
	ret

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
	npc_script NPC_YUKI, Func_32a76
	db $ff

FireFortYuki_OWInteractions:
	ow_script 5, 1, Func_32bd4
	ow_script 6, 1, Func_32bd4
	db $ff

FireFortYuki_MapScripts:
	dbw $06, Func_329c6
	dbw $08, Func_32a18
	dbw $09, Func_32a28
	dbw $07, Func_329cd
	dbw $02, Func_329d6
	db $ff

Func_329c6:
	ld hl, FireFortYuki_StepEvents
	call Func_324d
	ret

Func_329cd:
	ld hl, FireFortYuki_NPCs
	call Func_3205
	scf
	ccf
	ret

Func_329d6:
	ld a, EVENT_YUKIS_ROOM_DOOR_STATE
	farcall GetEventValue
	jr z, .asm_329e0
	scf
	ret
.asm_329e0
	ld bc, TILEMAP_07A
	lb de, 5, 0
	farcall Func_12c0ce
	ld a, EVENT_MET_YUKI_FIRE_FORT
	farcall GetEventValue
	jr nz, .asm_32a16
	ld a, EVENT_MET_YUKI_FIRE_FORT
	farcall MaxOutEventValue
	ld a, $0a
	ld [wd582], a
	ld a, BANK(Func_32a38)
	ld [wd592], a
	ld hl, Func_32a38
	ld a, l
	ld [wd593], a
	ld a, h
	ld [wd593 + 1], a
	ld a, NPC_YUKI
	lb de, 5, 9
	farcall SetOWObjectTilePosition
.asm_32a16
	scf
	ret

Func_32a18:
	ld hl, FireFortYuki_NPCInteractions
	call Func_328c
	jr nc, .asm_32a26
	ld hl, FireFortYuki_OWInteractions
	call Func_32bf
.asm_32a26
	scf
	ret

Func_32a28:
	ld hl, FireFortYuki_AfterDuelScripts
	ld a, [wScriptNPC]
	call Func_344c
	scf
	ret

FireFortYuki_AfterDuelScripts:
	npc_script NPC_YUKI, Func_32b43
	db $ff

Func_32a38:
	ld a, NPC_YUKI
	ld [wScriptNPC], a
	ldtx hl, DialogYukiText
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [wScriptNPCName + 1], a
	xor a
	start_script
	wait_for_fade
	script_command_01
	print_npc_text Text0cc4
	script_command_02
	do_frames 60
	set_active_npc_direction NORTH
	do_frames 30
	script_command_01
	print_npc_text Text0cc5
	script_command_02
	do_frames 30
	set_active_npc_direction SOUTH
	script_command_01
	print_npc_text Text0cc6
	script_command_02
	move_active_npc .NPCMovement_32a71
	wait_for_player_animation
	end_script
	ld a, $00
	ld [wd582], a
	ret
.NPCMovement_32a71:
	db NORTH, RUN_6
	db SOUTH, MOVE_0
	db $ff

Func_32a76:
	ld a, NPC_YUKI
	ld [wScriptNPC], a
	ldtx hl, DialogYukiText
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [wScriptNPCName + 1], a
	xor a
	start_script
	script_command_01
	check_event EVENT_YUKIS_ROOM_DOOR_STATE
	script_jump_if_b0z .ows_32b0d
	check_event EVENT_TALKED_TO_YUKI
	script_jump_if_b0z .ows_32ab1
	set_event EVENT_TALKED_TO_YUKI
	print_npc_text Text0cc7
	script_command_02
	get_active_npc_direction
	do_frames 30
	set_active_npc_direction WEST
	do_frames 90
	script_command_01
	print_npc_text Text0cc8
	script_command_02
	do_frames 30
	restore_active_npc_direction
	script_command_01
	print_npc_text Text0cc9
	script_jump .ows_32ac6
.ows_32ab1
	print_npc_text Text0cca
	script_command_02
	get_active_npc_direction
	set_active_npc_direction WEST
	do_frames 30
	script_command_01
	print_npc_text Text0ccb
	script_command_02
	restore_active_npc_direction
	do_frames 15
	script_command_01
	print_npc_text Text0ccc
.ows_32ac6
	ask_question Text0ccd, TRUE
	script_jump_if_b0z .ows_32af3
	duel_requirement_check DUEL_REQUIREMENT_YUKI
	script_jump_if_b1z .ows_32aea
	print_npc_text Text0cce
	script_command_02
	get_active_npc_direction
	set_active_npc_direction WEST
	do_frames 60
	script_command_01
	print_npc_text Text0ccf
	script_command_02
	do_frames 30
	restore_active_npc_direction
	script_command_01
	print_npc_text Text0cd0
	script_jump .ows_32b0a
.ows_32aea
	print_npc_text Text0cd1
	script_command_02
	start_duel FIREBALL_DECK_ID, MUSIC_MATCH_START_MEMBER
	end_script
	ret
.ows_32af3
	print_npc_text Text0cd2
	script_command_02
	do_frames 30
	get_player_direction
	restore_active_npc_direction
	do_frames 60
	script_command_01
	print_npc_text Text0cd3
	script_command_02
	do_frames 30
	get_player_opposite_direction
	restore_active_npc_direction
	script_command_01
	print_npc_text Text0cd4
.ows_32b0a
	script_command_02
	end_script
	ret
.ows_32b0d
	print_npc_text Text0cd5
	script_command_02
	get_active_npc_direction
	set_active_npc_direction WEST
	do_frames 30
	script_command_01
	print_npc_text Text0cd6
	script_command_02
	restore_active_npc_direction
	do_frames 15
	script_command_01
	print_npc_text Text0cd7
	ask_question Text0ccd, TRUE
	script_jump_if_b0z .ows_32b3d
	duel_requirement_check DUEL_REQUIREMENT_YUKI
	script_jump_if_b1z .ows_32b34
	print_npc_text Text0cd8
	script_jump .ows_32b40
.ows_32b34
	print_npc_text Text0cd1
	script_command_02
	start_duel FIREBALL_DECK_ID, MUSIC_MATCH_START_MEMBER
	end_script
	ret
.ows_32b3d
	print_npc_text Text0cd9
.ows_32b40
	script_command_02
	end_script
	ret

Func_32b43:
	xor a
	start_script
	script_command_01
	check_event EVENT_YUKIS_ROOM_DOOR_STATE
	script_jump_if_b0z .ows_32b77
	check_event EVENT_SET_UNTIL_MAP_RELOAD_2
	script_jump_if_b0nz .ows_32b5d
	set_event EVENT_YUKIS_ROOM_DOOR_STATE
	print_npc_text Text0cda
	give_booster_packs BoosterList_cd6e
	script_jump .ows_32b9f
.ows_32b5d
	print_npc_text Text0cdb
	script_command_02
	do_frames 30
	get_active_npc_direction
	set_active_npc_direction WEST
	do_frames 30
	script_command_01
	print_npc_text Text0cdc
	script_command_02
	do_frames 15
	restore_active_npc_direction
	script_command_01
	print_npc_text Text0cdd
	script_command_02
	end_script
	ret
.ows_32b77
	check_event EVENT_SET_UNTIL_MAP_RELOAD_2
	script_jump_if_b0nz .ows_32b99
	print_npc_text Text0cde
	give_booster_packs BoosterList_cd6e
	script_command_02
	do_frames 30
	get_player_direction
	restore_active_npc_direction
	do_frames 30
	script_command_01
	print_npc_text Text0cdf
	script_command_02
	get_player_opposite_direction
	restore_active_npc_direction
	do_frames 15
	script_command_01
	print_npc_text Text0ce0
	script_jump .ows_32b9c
.ows_32b99
	print_npc_text Text0ce1
.ows_32b9c
	script_command_02
	end_script
	ret
.ows_32b9f
	print_npc_text Text0ce2
	script_command_02
	do_frames 60
	get_player_direction
	restore_active_npc_direction
	do_frames 30
	script_command_01
	print_npc_text Text0ce3
	script_command_02
	do_frames 15
	get_player_opposite_direction
	restore_active_npc_direction
	do_frames 15
	script_command_01
	print_npc_text Text0ce4
	script_command_02
	do_frames 30
	set_active_npc_direction NORTH
	do_frames 60
	script_command_01
	print_npc_text Text0ce5
	script_command_02
	play_sfx SFX_DOORS
	load_tilemap TILEMAP_07B, $05, $00
	get_player_opposite_direction
	restore_active_npc_direction
	script_command_01
	print_npc_text Text0ce6
	script_command_02
	end_script
	ret

Func_32bd4:
	ld a, EVENT_YUKIS_ROOM_DOOR_STATE
	farcall GetEventValue
	jr nz, .asm_32be6
	xor a
	start_script
	script_command_01
	print_text DoorsAreShutText
	script_command_02
	end_script
.asm_32be6
	farcall Func_c199
	ret

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
	npc NPC_COURTNEY, 3, 7, SOUTH, Func_32d82
	db $ff

FireFortShoko_NPCInteractions:
	npc_script NPC_SHOKO, Func_32c9a
	db $ff

FireFortShoko_OWInteractions:
	ow_script 4, 1, Func_32d59
	ow_script 5, 1, Func_32d59
	db $ff

FireFortShoko_MapScripts:
	dbw $06, Func_32c4a
	dbw $08, Func_32c7a
	dbw $09, Func_32c8a
	dbw $07, Func_32c51
	dbw $02, Func_32c5a
	db $ff

Func_32c4a:
	ld hl, FireFortShoko_StepEvents
	call Func_324d
	ret

Func_32c51:
	ld hl, FireFortShoko_NPCs
	call Func_3205
	scf
	ccf
	ret

Func_32c5a:
	ld a, EVENT_SHOKOS_ROOM_DOOR_STATE
	farcall GetEventValue
	jr z, .asm_32c64
	scf
	ret
.asm_32c64
	ld bc, TILEMAP_07D
	lb de, 3, 7
	farcall Func_12c0ce
	ld bc, TILEMAP_07E
	lb de, 4, 0
	farcall Func_12c0ce
	scf
	ret

Func_32c7a:
	ld hl, FireFortShoko_NPCInteractions
	call Func_328c
	jr nc, .asm_32c88
	ld hl, FireFortShoko_OWInteractions
	call Func_32bf
.asm_32c88
	scf
	ret

Func_32c8a:
	ld hl, FireFortShoko_AfterDuelScripts
	ld a, [wScriptNPC]
	call Func_344c
	scf
	ret

FireFortShoko_AfterDuelScripts:
	npc_script NPC_SHOKO, Func_32d1f
	db $ff

Func_32c9a:
	ld a, NPC_SHOKO
	ld [wScriptNPC], a
	ldtx hl, DialogShokoText
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [wScriptNPCName + 1], a
	xor a
	start_script
	script_command_01
	check_event EVENT_SHOKOS_ROOM_DOOR_STATE
	script_jump_if_b0z .ows_32cfb
	check_event EVENT_TALKED_TO_SHOKO
	script_jump_if_b0z .ows_32cd7
	set_event EVENT_TALKED_TO_SHOKO
	print_npc_text Text0ca6
	script_command_02
	do_frames 30
	get_active_npc_direction
	set_active_npc_direction SOUTH
	do_frames 15
	script_command_01
	print_npc_text Text0ca7
	script_command_02
	do_frames 30
	restore_active_npc_direction
	do_frames 15
	script_command_01
	print_npc_text Text0ca8
	script_jump .ows_32cda
.ows_32cd7
	print_npc_text Text0ca9
.ows_32cda
	ask_question Text0caa, TRUE
	script_jump_if_b0z .ows_32cf5
	duel_requirement_check DUEL_REQUIREMENT_SHOKO
	script_jump_if_b1z .ows_32cec
	print_npc_text Text0cab
	script_jump .ows_32cf8
.ows_32cec
	print_npc_text Text0cac
	script_command_02
	start_duel EEVEE_SHOWDOWN_DECK_ID, MUSIC_MATCH_START_MEMBER
	end_script
	ret
.ows_32cf5
	print_npc_text Text0cad
.ows_32cf8
	script_command_02
	end_script
	ret
.ows_32cfb
	print_npc_text Text0cae
	ask_question Text0caa, TRUE
	script_jump_if_b0z .ows_32d19
	duel_requirement_check DUEL_REQUIREMENT_SHOKO
	script_jump_if_b1z .ows_32d10
	print_npc_text Text0cab
	script_jump .ows_32d1c
.ows_32d10
	print_npc_text Text0cac
	script_command_02
	start_duel EEVEE_SHOWDOWN_DECK_ID, MUSIC_MATCH_START_MEMBER
	end_script
	ret
.ows_32d19
	print_npc_text Text0cad
.ows_32d1c
	script_command_02
	end_script
	ret

Func_32d1f:
	xor a
	start_script
	script_command_01
	check_event EVENT_SHOKOS_ROOM_DOOR_STATE
	script_jump_if_b0z .ows_32d42
	check_event EVENT_SET_UNTIL_MAP_RELOAD_2
	script_jump_if_b0nz .ows_32d3c
	set_event EVENT_SHOKOS_ROOM_DOOR_STATE
	print_npc_text Text0caf
	give_booster_packs BoosterList_cd71
	print_npc_text Text0cb0
	script_jump Script_32d8f
.ows_32d3c
	print_npc_text Text0cb1
	script_command_02
	end_script
	ret
.ows_32d42
	check_event EVENT_SET_UNTIL_MAP_RELOAD_2
	script_jump_if_b0nz .ows_32d53
	print_npc_text Text0cb2
	give_booster_packs BoosterList_cd71
	print_npc_text Text0cb3
	script_jump .ows_32d56
.ows_32d53
	print_npc_text Text0cb1
.ows_32d56
	script_command_02
	end_script
	ret

Func_32d59:
	ld a, EVENT_SHOKOS_ROOM_DOOR_STATE
	farcall GetEventValue
	jr nz, .asm_32d7d
	ld a, NPC_SHOKO
	ld [wScriptNPC], a
	ldtx hl, DialogShokoText
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [wScriptNPCName + 1], a
	xor a
	start_script
	script_command_01
	set_active_npc_direction NORTH
	print_npc_text Text0cb4
	script_command_02
	end_script
.asm_32d7d
	farcall Func_c199
	ret

Func_32d82:
	ld a, EVENT_FREED_COURTNEY
	farcall GetEventValue
	jr z, .asm_32d8c
	scf
	ret
.asm_32d8c
	scf
	ccf
	ret

Script_32d8f:
	set_event EVENT_FREED_COURTNEY
	print_npc_text Text0cb5
	script_command_02
	do_frames 30
	set_active_npc_direction SOUTH
	do_frames 30
	play_sfx SFX_DOORS
	load_tilemap TILEMAP_080, $03, $07
	do_frames 30
	move_npc NPC_COURTNEY, .NPCMovement_32de0
	get_player_direction
	compare_loaded_var EAST
	script_jump_if_b0nz .ows_32dc1
	compare_loaded_var WEST
	script_jump_if_b0nz .ows_32dba
	move_player .NPCMovement_32dec, TRUE
	script_jump .ows_32dc5
.ows_32dba
	move_player .NPCMovement_32df3, TRUE
	script_jump .ows_32dc5
.ows_32dc1
	move_player .NPCMovement_32df6, TRUE
.ows_32dc5
	wait_for_player_animation
	set_active_npc NPC_COURTNEY, DialogCourtneyText
	script_command_01
	print_npc_text Text0cb6
	receive_card ARCANINE_LV34
	print_npc_text Text0cb7
	script_command_02
	move_active_npc .NPCMovement_32de9
	set_player_direction SOUTH
	wait_for_player_animation
	unload_npc NPC_COURTNEY
	script_jump Script_32dff
.NPCMovement_32de0:
	db SOUTH, MOVE_3
	db EAST, MOVE_3
	db NORTH, MOVE_6
	db WEST, MOVE_0
	db $ff
.NPCMovement_32de9:
	db SOUTH, MOVE_7
	db $ff
.NPCMovement_32dec:
	db EAST, MOVE_1
	db SOUTH, MOVE_1
	db EAST, MOVE_1
	db $ff
.NPCMovement_32df3:
	db EAST, MOVE_1
	db $ff
.NPCMovement_32df6:
	db NORTH, MOVE_1
	db EAST, MOVE_2
	db SOUTH, MOVE_1
	db EAST, MOVE_1
	db $ff

Script_32dff:
	set_active_npc NPC_SHOKO, DialogShokoText
	script_command_01
	print_npc_text Text0cb8
	script_command_02
	do_frames 30
	set_active_npc_direction NORTH
	set_player_direction NORTH
	do_frames 30
	play_sfx SFX_DOORS
	load_tilemap TILEMAP_07F, $04, $00
	script_command_01
	print_npc_text Text0cb9
	script_command_02
	set_active_npc_direction EAST
	end_script
	ret

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
	npc_script NPC_HIDERO, Func_32e79
	db $ff

FireFortHidero_MapScripts:
	dbw $06, Func_32e51
	dbw $08, Func_32e61
	dbw $09, Func_32e69
	dbw $07, Func_32e58
	db $ff

Func_32e51:
	ld hl, FireFortHidero_StepEvents
	call Func_324d
	ret

Func_32e58:
	ld hl, FireFortHidero_NPCs
	call Func_3205
	scf
	ccf
	ret

Func_32e61:
	ld hl, FireFortHidero_NPCInteractions
	call Func_328c
	scf
	ret

Func_32e69:
	ld hl, FireFortHidero_AfterDuelScripts
	ld a, [wScriptNPC]
	call Func_344c
	scf
	ret

FireFortHidero_AfterDuelScripts:
	npc_script NPC_HIDERO, Func_32efd
	db $ff

Func_32e79:
	ld a, NPC_HIDERO
	ld [wScriptNPC], a
	ldtx hl, DialogHideroText
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [wScriptNPCName + 1], a
	xor a
	start_script
	script_command_01
	check_event EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE
	script_jump_if_b0z .ows_32ed7
	check_event EVENT_BEAT_HIDERO
	script_jump_if_b0z .ows_32ebe
	check_event EVENT_TALKED_TO_HIDERO
	script_jump_if_b0z .ows_32ea5
	set_event EVENT_TALKED_TO_HIDERO
	print_npc_text Text0c85
	script_jump .ows_32ea8
.ows_32ea5
	print_npc_text Text0c86
.ows_32ea8
	ask_question Text0c87, TRUE
	script_jump_if_b0z .ows_32eb8
	print_npc_text Text0c88
	script_command_02
	start_duel GAZE_UPON_THE_POWER_OF_FIRE_DECK_ID, MUSIC_MATCH_START_GR_LEADER
	end_script
	ret
.ows_32eb8
	print_npc_text Text0c89
	script_command_02
	end_script
	ret
.ows_32ebe
	print_npc_text Text0c8a
	ask_question Text0c87, TRUE
	script_jump_if_b0z .ows_32ed1
	print_npc_text Text0c8b
	script_command_02
	start_duel GAZE_UPON_THE_POWER_OF_FIRE_DECK_ID, MUSIC_MATCH_START_GR_LEADER
	end_script
	ret
.ows_32ed1
	print_npc_text Text0c8c
	script_command_02
	end_script
	ret
.ows_32ed7
	check_event EVENT_TALKED_TO_HIDERO
	script_jump_if_b0z .ows_32ee4
	set_event EVENT_TALKED_TO_HIDERO
	print_npc_text Text0c8d
	script_jump .ows_32ee7
.ows_32ee4
	print_npc_text Text0c8a
.ows_32ee7
	ask_question Text0c87, TRUE
	script_jump_if_b0z .ows_32ef7
	print_npc_text Text0c8b
	script_command_02
	start_duel GAZE_UPON_THE_POWER_OF_FIRE_DECK_ID, MUSIC_MATCH_START_GR_LEADER
	end_script
	ret
.ows_32ef7
	print_npc_text Text0c8c
	script_command_02
	end_script
	ret

Func_32efd:
	xor a
	start_script
	script_command_01
	check_event EVENT_BEAT_HIDERO
	script_jump_if_b0z .ows_32f27
	check_event EVENT_SET_UNTIL_MAP_RELOAD_2
	script_jump_if_b0nz .ows_32f21
	set_event EVENT_BEAT_HIDERO
	set_var VAR_28, $03
	set_var VAR_2B, $00
	script_call .ows_32f52
	print_npc_text Text0c8e
	give_booster_packs BoosterList_cd75
	script_jump .ows_32f3e
.ows_32f21
	print_npc_text Text0c8f
	script_command_02
	end_script
	ret
.ows_32f27
	check_event EVENT_SET_UNTIL_MAP_RELOAD_2
	script_jump_if_b0nz .ows_32f38
	print_npc_text Text0c90
	give_booster_packs BoosterList_cd75
	print_npc_text Text0c91
	script_jump .ows_32f3b
.ows_32f38
	print_npc_text Text0c92
.ows_32f3b
	script_command_02
	end_script
	ret
.ows_32f3e
	set_event EVENT_GOT_MAGMAR_COIN
	print_npc_text Text0c93
	give_coin COIN_MAGMAR
	print_npc_text Text0c94
	check_event EVENT_GOT_PSYDUCK_COIN
	print_variable_npc_text Text0c95, Text0c96
	script_command_02
	end_script
	ret
.ows_32f52
	check_event EVENT_GOT_PSYDUCK_COIN
	script_jump_if_b0nz .ows_32f5a
	set_var VAR_30, $02
.ows_32f5a
	script_ret

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
	npc_script NPC_GR_CLERK_WATER_FORT, Func_3305c
	db $ff

WaterFortEntrance_OWInteractions:
	ow_script 4, 8, Func_3308e
	ow_script 5, 8, Func_3308e
	db $ff

WaterFortEntrance_MapScripts:
	dbw $06, Func_32fe6
	dbw $08, Func_33046
	dbw $07, Func_32fed
	dbw $02, Func_32ff6
	dbw $09, Func_33056
	dbw $10, Func_32fc9
	db $ff

Func_32fc9:
	ld a, EVENT_GOT_PSYDUCK_COIN
	farcall GetEventValue
	jr z, .asm_32fdb
	ld a, VAR_TIMES_MET_RONALD
	farcall GetVarValue
	cp $06
	jr c, .asm_32fdd
.asm_32fdb
	scf
	ret
.asm_32fdd
	ld a, MUSIC_RONALD
	farcall PlayAfterCurrentSong
	scf
	ccf
	ret

Func_32fe6:
	ld hl, WaterFortEntrance_StepEvents
	call Func_324d
	ret

Func_32fed:
	ld hl, WaterFortEntrance_NPCs
	call Func_3205
	scf
	ccf
	ret

Func_32ff6:
	ld a, EVENT_WATER_FORT_ENTRANCE_DOOR_STATE
	farcall GetEventValue
	jr z, .asm_3300a
	ld a, VAR_TIMES_MET_RONALD
	farcall GetVarValue
	cp $06
	jr c, .asm_33027
	jr .asm_33044
.asm_3300a
	ld bc, TILEMAP_083
	lb de, 4, 7
	farcall Func_12c0ce
	ld a, EVENT_GOT_MAGNEMITE_COIN
	farcall GetEventValue
	jr nz, .asm_33044
	ld a, NPC_GR_CLERK_WATER_FORT
	lb de, 4, 8
	farcall SetOWObjectTilePosition
	jr .asm_33044
.asm_33027
	ld a, EVENT_GOT_PSYDUCK_COIN
	farcall GetEventValue
	jr z, .asm_33044
	ld a, $0a
	ld [wd582], a
	ld a, BANK(Func_34391)
	ld [wd592], a
	ld hl, Func_34391
	ld a, l
	ld [wd593], a
	ld a, h
	ld [wd593 + 1], a
.asm_33044
	scf
	ret

Func_33046:
	ld hl, WaterFortEntrance_NPCInteractions
	call Func_328c
	jr nc, .asm_33054
	ld hl, WaterFortEntrance_OWInteractions
	call Func_32bf
.asm_33054
	scf
	ret

Func_33056:
	farcall Func_343ef
	scf
	ret

Func_3305c:
	ld a, NPC_GR_CLERK_WATER_FORT
	ld [wScriptNPC], a
	ldtx hl, DialogReceptionistText
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [wScriptNPCName + 1], a
	xor a
	start_script
	script_command_01
	check_event EVENT_GOT_PSYDUCK_COIN
	script_jump_if_b0z .ows_33088
	check_event EVENT_GOT_MAGNEMITE_COIN
	script_jump_if_b0z .ows_33081
	print_npc_text Text1212
	script_jump .ows_3308b
.ows_33081
	script_call Script_330bc
	script_jump .ows_3308b
.ows_33088
	print_npc_text Text1213
.ows_3308b
	script_command_02
	end_script
	ret

Func_3308e:
	ld a, EVENT_WATER_FORT_ENTRANCE_DOOR_STATE
	farcall GetEventValue
	jr nz, .asm_330bb
	xor a
	start_script
	script_command_01
	print_text Text1214
	check_event EVENT_GOT_MAGNEMITE_COIN
	script_jump_if_b0nz .ows_330b9
	ask_question Text1215, TRUE
	script_jump_if_b0z .ows_330b9
	send_mail $17
	set_event EVENT_WATER_FORT_ENTRANCE_DOOR_STATE
	script_command_02
	play_sfx SFX_DOORS
	load_tilemap TILEMAP_084, $04, $07
	end_script
	jr .asm_330bb
.ows_330b9
	script_command_02
	end_script
.asm_330bb
	ret

Script_330bc:
	print_npc_text Text1216
	script_ret

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
	npc_script NPC_MIYAJIMA, Func_3316a
	db $ff

WaterFortMiyajima_OWInteractions:
	ow_script 4, 1, Func_33236
	ow_script 5, 1, Func_33236
	db $ff

WaterFortMiyajima_MapScripts:
	dbw $06, Func_33119
	dbw $08, Func_3314a
	dbw $09, Func_3315a
	dbw $07, Func_33120
	dbw $02, Func_33129
	db $ff

Func_33119:
	ld hl, WaterFortMiyajima_StepEvents
	call Func_324d
	ret

Func_33120:
	ld hl, WaterFortMiyajima_NPCs
	call Func_3205
	scf
	ccf
	ret

Func_33129:
	ld a, [wd584]
	cp MAP_WATER_FORT_ENTRANCE
	jr nz, .asm_33134
	farcall DeliverMailFromQueue
.asm_33134
	ld a, EVENT_MIYAJIMAS_ROOM_DOOR_STATE
	farcall GetEventValue
	jr z, .asm_3313e
	scf
	ret
.asm_3313e
	ld bc, TILEMAP_087
	lb de, 4, 0
	farcall Func_12c0ce
	scf
	ret

Func_3314a:
	ld hl, WaterFortMiyajima_NPCInteractions
	call Func_328c
	jr nc, .asm_33158
	ld hl, WaterFortMiyajima_OWInteractions
	call Func_32bf
.asm_33158
	scf
	ret

Func_3315a:
	ld hl, WaterFortMiyajima_AfterDuelScripts
	ld a, [wScriptNPC]
	call Func_344c
	scf
	ret

WaterFortMiyajima_AfterDuelScripts:
	npc_script NPC_MIYAJIMA, Func_331d9
	db $ff

Func_3316a:
	ld a, NPC_MIYAJIMA
	ld [wScriptNPC], a
	ldtx hl, DialogMiyajimaText
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [wScriptNPCName + 1], a
	xor a
	start_script
	script_command_01
	check_event EVENT_MIYAJIMAS_ROOM_DOOR_STATE
	script_jump_if_b0z .ows_331b5
	check_event EVENT_TALKED_TO_MIYAJIMA
	script_jump_if_b0z .ows_33191
	set_event EVENT_TALKED_TO_MIYAJIMA
	print_npc_text Text1228
	script_jump .ows_33194
.ows_33191
	print_npc_text Text1229
.ows_33194
	ask_question Text122a, TRUE
	script_jump_if_b0z .ows_331af
	duel_requirement_check DUEL_REQUIREMENT_MIYAJIMA
	script_jump_if_b1z .ows_331a6
	print_npc_text Text122b
	script_jump .ows_331b2
.ows_331a6
	print_npc_text Text122c
	script_command_02
	start_duel WHIRLPOOL_SHOWER_DECK_ID, MUSIC_MATCH_START_MEMBER
	end_script
	ret
.ows_331af
	print_npc_text Text122d
.ows_331b2
	script_command_02
	end_script
	ret
.ows_331b5
	print_npc_text Text122e
	ask_question Text122a, TRUE
	script_jump_if_b0z .ows_331d3
	duel_requirement_check DUEL_REQUIREMENT_MIYAJIMA
	script_jump_if_b1z .ows_331ca
	print_npc_text Text122f
	script_jump .ows_331d6
.ows_331ca
	print_npc_text Text1230
	script_command_02
	start_duel WHIRLPOOL_SHOWER_DECK_ID, MUSIC_MATCH_START_MEMBER
	end_script
	ret
.ows_331d3
	print_npc_text Text1231
.ows_331d6
	script_command_02
	end_script
	ret

Func_331d9:
	xor a
	start_script
	script_command_01
	check_event EVENT_MIYAJIMAS_ROOM_DOOR_STATE
	script_jump_if_b0z .ows_33203
	check_event EVENT_SET_UNTIL_MAP_RELOAD_2
	script_jump_if_b0nz .ows_331f6
	set_event EVENT_MIYAJIMAS_ROOM_DOOR_STATE
	print_npc_text Text1232
	give_booster_packs BoosterList_cd79
	print_npc_text Text1233
	script_jump .ows_3321a
.ows_331f6
	check_event EVENT_PLAYER_GENDER
	set_variable_text_ram2 Text1234, Text1235
	print_npc_text Text1236
	script_command_02
	end_script
	ret
.ows_33203
	check_event EVENT_SET_UNTIL_MAP_RELOAD_2
	script_jump_if_b0nz .ows_33214
	print_npc_text Text1237
	give_booster_packs BoosterList_cd79
	print_npc_text Text1238
	script_jump .ows_33217
.ows_33214
	print_npc_text Text1239
.ows_33217
	script_command_02
	end_script
	ret
.ows_3321a
	print_npc_text Text123a
	script_command_02
	do_frames 30
	get_active_npc_direction
	set_active_npc_direction NORTH
	do_frames 30
	play_sfx SFX_DOORS
	load_tilemap TILEMAP_088, $04, $00
	do_frames 30
	restore_active_npc_direction
	script_command_01
	print_npc_text Text123b
	script_command_02
	end_script
	ret

Func_33236:
	ld a, EVENT_MIYAJIMAS_ROOM_DOOR_STATE
	farcall GetEventValue
	jr nz, .asm_33248
	xor a
	start_script
	script_command_01
	print_text DoorsAreShutText
	script_command_02
	end_script
.asm_33248
	farcall Func_c199
	ret

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
	npc_script NPC_KANOKO, Func_332a6
	db $ff

WaterFortKanoko_MapScripts:
	dbw $06, Func_3327e
	dbw $08, Func_3328e
	dbw $09, Func_33296
	dbw $07, Func_33285
	db $ff

Func_3327e:
	ld hl, WaterFortKanoko_StepEvents
	call Func_324d
	ret

Func_33285:
	ld hl, WaterFortKanoko_NPCs
	call Func_3205
	scf
	ccf
	ret

Func_3328e:
	ld hl, WaterFortKanoko_NPCInteractions
	call Func_328c
	scf
	ret

Func_33296:
	ld hl, WaterFortKanoko_AfterDuelScripts
	ld a, [wScriptNPC]
	call Func_344c
	scf
	ret

WaterFortKanoko_AfterDuelScripts:
	npc_script NPC_KANOKO, Func_332ff
	db $ff

Func_332a6:
	ld a, NPC_KANOKO
	ld [wScriptNPC], a
	ldtx hl, DialogKanokoText
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [wScriptNPCName + 1], a
	xor a
	start_script
	script_command_01
	check_event EVENT_BEAT_KANOKO
	script_jump_if_b0z .ows_332e6
	check_event EVENT_TALKED_TO_KANOKO
	script_jump_if_b0z .ows_332cd
	set_event EVENT_TALKED_TO_KANOKO
	print_npc_text Text1217
	script_jump .ows_332d0
.ows_332cd
	print_npc_text Text1218
.ows_332d0
	ask_question Text1219, TRUE
	script_jump_if_b0z .ows_332e0
	print_npc_text Text121a
	script_command_02
	start_duel WATER_STREAM_DECK_ID, MUSIC_MATCH_START_GR_LEADER
	end_script
	ret
.ows_332e0
	print_npc_text Text121b
	script_command_02
	end_script
	ret
.ows_332e6
	print_npc_text Text121c
	ask_question Text1219, TRUE
	script_jump_if_b0z .ows_332f9
	print_npc_text Text121d
	script_command_02
	start_duel WATER_STREAM_DECK_ID, MUSIC_MATCH_START_GR_LEADER
	end_script
	ret
.ows_332f9
	print_npc_text Text121e
	script_command_02
	end_script
	ret

Func_332ff:
	xor a
	start_script
	script_command_01
	check_event EVENT_BEAT_KANOKO
	script_jump_if_b0z .ows_33326
	check_event EVENT_SET_UNTIL_MAP_RELOAD_2
	script_jump_if_b0nz .ows_33320
	set_event EVENT_BEAT_KANOKO
	script_call .ows_3334e
	print_npc_text Text121f
	give_booster_packs BoosterList_cd82
	print_npc_text Text1220
	script_jump .ows_3333d
.ows_33320
	print_npc_text Text1221
	script_command_02
	end_script
	ret
.ows_33326
	check_event EVENT_SET_UNTIL_MAP_RELOAD_2
	script_jump_if_b0nz .ows_33337
	print_npc_text Text1222
	give_booster_packs BoosterList_cd82
	print_npc_text Text1223
	script_jump .ows_3333a
.ows_33337
	print_npc_text Text1224
.ows_3333a
	script_command_02
	end_script
	ret
.ows_3333d
	set_event EVENT_GOT_PSYDUCK_COIN
	print_npc_text Text1225
	give_coin COIN_PSYDUCK
	check_event EVENT_GOT_MAGMAR_COIN
	print_variable_npc_text Text1226, Text1227
	script_command_02
	end_script
	ret
.ows_3334e
	check_event EVENT_GOT_MAGMAR_COIN
	script_jump_if_b0nz .ows_33356
	set_var VAR_30, $02
.ows_33356
	script_ret

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
	npc_script NPC_GR_CLERK_FIGHTING_FORT, Func_33434
	db $ff

FightingFortEntrance_OWInteractions:
	ow_script 4, 8, Func_33470
	ow_script 5, 8, Func_334b3
	db $ff

FightingFortEntrance_MapScripts:
	dbw $06, Func_333ad
	dbw $08, Func_33424
	dbw $07, Func_333b4
	dbw $02, Func_333bd
	db $ff

Func_333ad:
	ld hl, FightingFortEntrance_StepEvents
	call Func_324d
	ret

Func_333b4:
	ld hl, FightingFortEntrance_NPCs
	call Func_3205
	scf
	ccf
	ret

Func_333bd:
	ld a, EVENT_FIGHTING_FORT_ENTRANCE_DOOR_STATE
	farcall GetEventValue
	jr z, .asm_333c7
	jr .asm_33422
.asm_333c7
	ld bc, TILEMAP_093
	lb de, 4, 7
	farcall Func_12c0ce
	ld a, EVENT_INSERTED_LEFT_COIN_IN_FIGHTING_FORT_DOOR
	farcall GetEventValue
	jr z, .asm_333ed
	ld bc, PALETTE_187
	farcall GetPalettesWithID
	ld a, NPC_RED_FORT_COIN
	lb de, 4, 7
	ld b, SOUTH
	farcall LoadOWObjectInMap
	jr .asm_33422
.asm_333ed
	ld a, EVENT_INSERTED_RIGHT_COIN_IN_FIGHTING_FORT_DOOR
	farcall GetEventValue
	jr z, .asm_33409
	ld bc, PALETTE_186
	farcall GetPalettesWithID
	ld a, NPC_BLUE_FORT_COIN
	lb de, 5, 7
	ld b, SOUTH
	farcall LoadOWObjectInMap
	jr .asm_33422
.asm_33409
	ld a, EVENT_GOT_MAGMAR_COIN
	farcall GetEventValue
	jr nz, .asm_33422
	ld a, EVENT_GOT_PSYDUCK_COIN
	farcall GetEventValue
	jr nz, .asm_33422
	ld a, NPC_GR_CLERK_FIGHTING_FORT
	lb de, 4, 8
	farcall SetOWObjectTilePosition
.asm_33422
	scf
	ret

Func_33424:
	ld hl, FightingFortEntrance_NPCInteractions
	call Func_328c
	jr nc, .asm_33432
	ld hl, FightingFortEntrance_OWInteractions
	call Func_32bf
.asm_33432
	scf
	ret

Func_33434:
	ld a, NPC_GR_CLERK_FIGHTING_FORT
	ld [wScriptNPC], a
	ldtx hl, DialogReceptionistText
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [wScriptNPCName + 1], a
	xor a
	start_script
	script_command_01
	check_event EVENT_GOT_MACHAMP_COIN
	script_jump_if_b0z .ows_33465
	check_event EVENT_GOT_MAGMAR_COIN
	script_jump_if_b0nz .ows_3345f
	check_event EVENT_GOT_PSYDUCK_COIN
	script_jump_if_b0nz .ows_3345f
	script_call Script_33502
	script_jump .ows_33468
.ows_3345f
	print_npc_text Text0bdc
	script_jump .ows_33468
.ows_33465
	print_npc_text Text0bdd
.ows_33468
	script_command_02
	end_script
	ld a, $01
	call Func_30065
	ret

Func_33470:
	ld a, EVENT_FIGHTING_FORT_ENTRANCE_DOOR_STATE
	farcall GetEventValue
	jr nz, .asm_334b2
	xor a
	start_script
	script_command_01
	check_event EVENT_INSERTED_LEFT_COIN_IN_FIGHTING_FORT_DOOR
	script_jump_if_b0z .ows_334ad
	print_text Text0bde
	check_event EVENT_GOT_MAGMAR_COIN
	script_jump_if_b0nz .ows_334b0
	ask_question Text0bdf, TRUE
	script_jump_if_b0z .ows_334b0
	set_event EVENT_INSERTED_LEFT_COIN_IN_FIGHTING_FORT_DOOR
	check_event EVENT_FIGHTING_FORT_ENTRANCE_DOOR_STATE
	script_jump_if_b0nz .ows_3349d
	unload_npc NPC_BLUE_FORT_COIN
	script_jump Script_334f6
.ows_3349d
	print_text Text0be0
	load_palette PALETTE_187
	play_sfx SFX_CONFIRM
	load_npc NPC_RED_FORT_COIN, 4, 7, SOUTH
	script_jump .ows_334b0
.ows_334ad
	print_text Text0be1
.ows_334b0
	script_command_02
	end_script
.asm_334b2
	ret

Func_334b3:
	ld a, EVENT_FIGHTING_FORT_ENTRANCE_DOOR_STATE
	farcall GetEventValue
	jr nz, .asm_334f5
	xor a
	start_script
	script_command_01
	check_event EVENT_INSERTED_RIGHT_COIN_IN_FIGHTING_FORT_DOOR
	script_jump_if_b0z .ows_334f0
	print_text Text0be2
	check_event EVENT_GOT_PSYDUCK_COIN
	script_jump_if_b0nz .ows_334f3
	ask_question Text0be3, TRUE
	script_jump_if_b0z .ows_334f3
	set_event EVENT_INSERTED_RIGHT_COIN_IN_FIGHTING_FORT_DOOR
	check_event EVENT_FIGHTING_FORT_ENTRANCE_DOOR_STATE
	script_jump_if_b0nz .ows_334e0
	unload_npc NPC_RED_FORT_COIN
	script_jump Script_334f6
.ows_334e0
	print_text Text0be4
	load_palette PALETTE_186
	play_sfx SFX_CONFIRM
	load_npc NPC_BLUE_FORT_COIN, 5, 7, SOUTH
	script_jump .ows_334f3
.ows_334f0
	print_text Text0be5
.ows_334f3
	script_command_02
	end_script
.asm_334f5
	ret

Script_334f6:
	send_mail $18
	script_command_02
	play_sfx SFX_DOORS
	load_tilemap TILEMAP_094, $04, $07
	end_script
	ret

Script_33502:
	print_npc_text Text0be6
	script_ret

FightingFortMaze2_MapHeader:
	db MAP_GFX_FIGHTING_FORT_MAZE_2
	dba FightingFortMaze2_MapScripts
	db MUSIC_FORT_3

FightingFortMaze2_StepEvents:
	map_exit 4, 0, MAP_FIGHTING_FORT_MAZE_7, 4, 7, NORTH
	map_exit 5, 0, MAP_FIGHTING_FORT_MAZE_7, 5, 7, NORTH
	map_exit 0, 3, MAP_FIGHTING_FORT_MAZE_1, 8, 3, WEST
	map_exit 0, 4, MAP_FIGHTING_FORT_MAZE_1, 8, 4, WEST
	_ow_coordinate_function 3, 3, 104, 10, 1, 2, Func_335c7
	_ow_coordinate_function 3, 4, 104, 10, 1, 2, Func_335c7
	db $ff

FightingFortMaze2_NPCs:
	npc NPC_CHEST_CLOSED, 5, 2, SOUTH, Func_335a2
	npc NPC_CHEST_OPENED, 5, 2, SOUTH, Func_335ba
	db $ff

FightingFortMaze2_NPCInteractions:
	npc_script NPC_CHEST_CLOSED, Func_33589
	npc_script NPC_CHEST_OPENED, Func_335af
	db $ff

FightingFortMaze2_MapScripts:
	dbw $06, Func_33565
	dbw $08, Func_33581
	dbw $07, Func_33578
	dbw $0f, Func_3356c
	db $ff

Func_33565:
	ld hl, FightingFortMaze2_StepEvents
	call Func_324d
	ret

Func_3356c:
	ld a, [wd585]
	cp MAP_FIGHTING_FORT_BASEMENT
	jr z, .asm_33575
	scf
	ret
.asm_33575
	scf
	ccf
	ret

Func_33578:
	ld hl, FightingFortMaze2_NPCs
	call Func_3205
	scf
	ccf
	ret

Func_33581:
	ld hl, FightingFortMaze2_NPCInteractions
	call Func_328c
	scf
	ret

Func_33589:
	xor a
	start_script
	script_command_01
	set_event EVENT_OPENED_CHEST_FIGHTING_FORT_1
	play_sfx SFX_OPEN_CHEST
	load_npc NPC_CHEST_OPENED, 5, 2, SOUTH
	unload_npc NPC_CHEST_CLOSED
	print_text OpenedTreasureBoxText
	give_booster_packs BoosterList_ce38
	script_command_02
	end_script
	ret

Func_335a2:
	ld a, EVENT_OPENED_CHEST_FIGHTING_FORT_1
	farcall GetEventValue
	jr nz, .asm_335ad
	scf
	ccf
	ret
.asm_335ad
	scf
	ret

Func_335af:
	xor a
	start_script
	script_command_01
	print_text TreasureBoxWasEmptyText
	script_command_02
	end_script
	ret

Func_335ba:
	ld a, EVENT_OPENED_CHEST_FIGHTING_FORT_1
	farcall GetEventValue
	jr z, .asm_335c5
	scf
	ccf
	ret
.asm_335c5
	scf
	ret

Func_335c7:
	ld a, SFX_DOORS
	call PlaySFX
	ld bc, TILEMAP_09A
	lb de, 3, 3
	farcall Func_12c0ce
	call Func_30000
	ret

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
	dbw $06, Func_3361d
	dbw $02, Func_33624
	db $ff

Func_3361d:
	ld hl, FightingFortMaze3_StepEvents
	call Func_324d
	ret

Func_33624:
	ld bc, $53
	ld a, $05
	farcall SetwD896
	scf
	ret

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
	_ow_coordinate_function 2, 3, 104, 10, 1, 2, Func_33710
	_ow_coordinate_function 2, 4, 104, 10, 1, 2, Func_33710
	db $ff

FightingFortMaze4_NPCs:
	npc NPC_CHEST_CLOSED, 3, 3, SOUTH, Func_336eb
	npc NPC_CHEST_OPENED, 3, 3, SOUTH, Func_33703
	db $ff

FightingFortMaze4_NPCInteractions:
	npc_script NPC_CHEST_CLOSED, Func_336d2
	npc_script NPC_CHEST_OPENED, Func_336f8
	db $ff

FightingFortMaze4_MapScripts:
	dbw $06, Func_336a3
	dbw $08, Func_336ca
	dbw $07, Func_336c1
	dbw $0f, Func_336aa
	dbw $02, Func_336b6
	db $ff

Func_336a3:
	ld hl, FightingFortMaze4_StepEvents
	call Func_324d
	ret

Func_336aa:
	ld a, [wd585]
	cp MAP_FIGHTING_FORT_BASEMENT
	jr z, .asm_336b3
	scf
	ret
.asm_336b3
	scf
	ccf
	ret

Func_336b6:
	ld bc, $53
	ld a, $05
	farcall SetwD896
	scf
	ret

Func_336c1:
	ld hl, FightingFortMaze4_NPCs
	call Func_3205
	scf
	ccf
	ret

Func_336ca:
	ld hl, FightingFortMaze4_NPCInteractions
	call Func_328c
	scf
	ret

Func_336d2:
	xor a
	start_script
	script_command_01
	set_event EVENT_OPENED_CHEST_FIGHTING_FORT_2
	play_sfx SFX_OPEN_CHEST
	load_npc NPC_CHEST_OPENED, 3, 3, SOUTH
	unload_npc NPC_CHEST_CLOSED
	print_text OpenedTreasureBoxText
	give_booster_packs BoosterList_ce3b
	script_command_02
	end_script
	ret

Func_336eb:
	ld a, EVENT_OPENED_CHEST_FIGHTING_FORT_2
	farcall GetEventValue
	jr nz, .asm_336f6
	scf
	ccf
	ret
.asm_336f6
	scf
	ret

Func_336f8:
	xor a
	start_script
	script_command_01
	print_text TreasureBoxWasEmptyText
	script_command_02
	end_script
	ret

Func_33703:
	ld a, EVENT_OPENED_CHEST_FIGHTING_FORT_2
	farcall GetEventValue
	jr z, .asm_3370e
	scf
	ccf
	ret
.asm_3370e
	scf
	ret

Func_33710:
	ld a, SFX_DOORS
	call PlaySFX
	ld bc, TILEMAP_09D
	lb de, 2, 3
	farcall Func_12c0ce
	call Func_30000
	ret

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
	dbw $06, Func_33754
	dbw $02, Func_3375b
	db $ff

Func_33754:
	ld hl, FightingFortMaze5_StepEvents
	call Func_324d
	ret

Func_3375b:
	ld bc, $53
	ld a, $05
	farcall SetwD896
	scf
	ret

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
	dbw $06, Func_337a9
	dbw $02, Func_337b0
	db $ff

Func_337a9:
	ld hl, FightingFortMaze6_StepEvents
	call Func_324d
	ret

Func_337b0:
	ld bc, $53
	ld a, $05
	farcall SetwD896
	scf
	ret

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
	dbw $06, Func_33810
	dbw $02, Func_33817
	db $ff

Func_33810:
	ld hl, FightingFortMaze7_StepEvents
	call Func_324d
	ret

Func_33817:
	ld bc, $53
	ld a, $05
	farcall SetwD896
	scf
	ret

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
	_ow_coordinate_function 3, 3, 104, 10, 1, 2, Func_33915
	_ow_coordinate_function 3, 4, 104, 10, 1, 2, Func_33915
	db $ff

FightingFortMaze8_NPCs:
	npc NPC_CHEST_CLOSED, 2, 3, SOUTH, Func_338f0
	npc NPC_CHEST_OPENED, 2, 3, SOUTH, Func_33908
	db $ff

FightingFortMaze8_NPCInteractions:
	npc_script NPC_CHEST_CLOSED, Func_338d7
	npc_script NPC_CHEST_OPENED, Func_338fd
	db $ff

FightingFortMaze8_MapScripts:
	dbw $06, Func_338a8
	dbw $08, Func_338cf
	dbw $07, Func_338c6
	dbw $0f, Func_338af
	dbw $02, Func_338bb
	db $ff

Func_338a8:
	ld hl, FightingFortMaze8_StepEvents
	call Func_324d
	ret

Func_338af:
	ld a, [wd585]
	cp MAP_FIGHTING_FORT_BASEMENT
	jr z, .asm_338b8
	scf
	ret
.asm_338b8
	scf
	ccf
	ret

Func_338bb:
	ld bc, $53
	ld a, $05
	farcall SetwD896
	scf
	ret

Func_338c6:
	ld hl, FightingFortMaze8_NPCs
	call Func_3205
	scf
	ccf
	ret

Func_338cf:
	ld hl, FightingFortMaze8_NPCInteractions
	call Func_328c
	scf
	ret

Func_338d7:
	xor a
	start_script
	script_command_01
	set_event EVENT_OPENED_CHEST_FIGHTING_FORT_3
	play_sfx SFX_OPEN_CHEST
	load_npc NPC_CHEST_OPENED, 2, 3, SOUTH
	unload_npc NPC_CHEST_CLOSED
	print_text OpenedTreasureBoxText
	give_booster_packs BoosterList_ce3e
	script_command_02
	end_script
	ret

Func_338f0:
	ld a, EVENT_OPENED_CHEST_FIGHTING_FORT_3
	farcall GetEventValue
	jr nz, .asm_338fb
	scf
	ccf
	ret
.asm_338fb
	scf
	ret

Func_338fd:
	xor a
	start_script
	script_command_01
	print_text TreasureBoxWasEmptyText
	script_command_02
	end_script
	ret

Func_33908:
	ld a, EVENT_OPENED_CHEST_FIGHTING_FORT_3
	farcall GetEventValue
	jr z, .asm_33913
	scf
	ccf
	ret
.asm_33913
	scf
	ret

Func_33915:
	ld a, SFX_DOORS
	call PlaySFX
	ld bc, TILEMAP_0BC
	lb de, 3, 3
	farcall Func_12c0ce
	call Func_30000
	ret

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
	dbw $06, Func_3396b
	dbw $02, Func_33972
	db $ff

Func_3396b:
	ld hl, FightingFortMaze9_StepEvents
	call Func_324d
	ret

Func_33972:
	ld bc, $53
	ld a, $05
	farcall SetwD896
	scf
	ret

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
	dbw $06, Func_339ab
	db $ff

Func_339ab:
	ld hl, FightingFortMaze10_StepEvents
	call Func_324d
	ret

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
	dbw $06, Func_33a07
	dbw $02, Func_33a0e
	db $ff

Func_33a07:
	ld hl, FightingFortMaze11_StepEvents
	call Func_324d
	ret

Func_33a0e:
	ld bc, $53
	ld a, $05
	farcall SetwD896
	scf
	ret

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
	_ow_coordinate_function 4, 6, 104, 10, 1, 2, Func_33aa1
	_ow_coordinate_function 5, 6, 104, 10, 1, 2, Func_33aa1
	db $ff

FightingFortMaze12_MapScripts:
	dbw $06, Func_33a83
	dbw $0f, Func_33a8a
	dbw $02, Func_33a96
	db $ff

Func_33a83:
	ld hl, FightingFortMaze12_StepEvents
	call Func_324d
	ret

Func_33a8a:
	ld a, [wd585]
	cp MAP_FIGHTING_FORT_BASEMENT
	jr z, .asm_33a93
	scf
	ret
.asm_33a93
	scf
	ccf
	ret

Func_33a96:
	ld bc, $53
	ld a, $05
	farcall SetwD896
	scf
	ret

Func_33aa1:
	ld a, SFX_DOORS
	call PlaySFX
	ld bc, TILEMAP_0C1
	lb de, 4, 6
	farcall Func_12c0ce
	call Func_30005
	ret

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
	dbw $06, Func_33b09
	dbw $02, Func_33b10
	db $ff

Func_33b09:
	ld hl, FightingFortMaze13_StepEvents
	call Func_324d
	ret

Func_33b10:
	ld bc, $53
	ld a, $05
	farcall SetwD896
	scf
	ret

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
	_ow_coordinate_function 2, 3, 104, 10, 1, 2, Func_33b91
	_ow_coordinate_function 2, 4, 104, 10, 1, 2, Func_33b91
	db $ff

FightingFortMaze14_MapScripts:
	dbw $06, Func_33b73
	dbw $0f, Func_33b7a
	dbw $02, Func_33b86
	db $ff

Func_33b73:
	ld hl, FightingFortMaze14_StepEvents
	call Func_324d
	ret

Func_33b7a:
	ld a, [wd585]
	cp MAP_FIGHTING_FORT_BASEMENT
	jr z, .asm_33b83
	scf
	ret
.asm_33b83
	scf
	ccf
	ret

Func_33b86:
	ld bc, $53
	ld a, $05
	farcall SetwD896
	scf
	ret

Func_33b91:
	ld a, SFX_DOORS
	call PlaySFX
	ld bc, TILEMAP_0C4
	lb de, 2, 3
	farcall Func_12c0ce
	call Func_30000
	ret

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
	dbw $06, Func_33be7
	dbw $02, Func_33bee
	db $ff

Func_33be7:
	ld hl, FightingFortMaze15_StepEvents
	call Func_324d
	ret

Func_33bee:
	ld bc, $53
	ld a, $05
	farcall SetwD896
	scf
	ret

FightingFortMaze17_MapHeader:
	db MAP_GFX_FIGHTING_FORT_MAZE_17
	dba FightingFortMaze17_MapScripts
	db MUSIC_FORT_3

FightingFortMaze17_StepEvents:
	map_exit 4, 8, MAP_FIGHTING_FORT_MAZE_12, 4, 1, SOUTH
	map_exit 5, 8, MAP_FIGHTING_FORT_MAZE_12, 5, 1, SOUTH
	map_exit 4, 0, MAP_FIGHTING_FORT_MAZE_21, 4, 7, NORTH
	map_exit 5, 0, MAP_FIGHTING_FORT_MAZE_21, 5, 7, NORTH
	_ow_coordinate_function 4, 6, 104, 10, 1, 2, Func_33d1b
	_ow_coordinate_function 5, 6, 104, 10, 1, 2, Func_33d1b
	_ow_coordinate_function 8, 3, 104, 10, 1, 2, Func_33cf8
	_ow_coordinate_function 8, 4, 104, 10, 1, 2, Func_33cf8
	db $ff

FightingFortMaze17_NPCs:
	npc NPC_CHEST_CLOSED, 1, 1, SOUTH, Func_33cd3
	npc NPC_CHEST_OPENED, 1, 1, SOUTH, Func_33ceb
	db $ff

FightingFortMaze17_NPCInteractions:
	npc_script NPC_CHEST_CLOSED, Func_33cba
	npc_script NPC_CHEST_OPENED, Func_33ce0
	db $ff

FightingFortMaze17_MapScripts:
	dbw $06, Func_33c6d
	dbw $08, Func_33cb2
	dbw $07, Func_33ca9
	dbw $02, Func_33c74
	dbw $0f, Func_33c9d
	db $ff

Func_33c6d:
	ld hl, FightingFortMaze17_StepEvents
	call Func_324d
	ret

Func_33c74:
	ld bc, $53
	ld a, $05
	farcall SetwD896
	ld a, [wd584]
	cp MAP_FIGHTING_FORT_MAZE_18
	jr z, .asm_33c86
	scf
	ret
.asm_33c86
	ld a, $0a
	ld [wd582], a
	ld a, BANK(Func_33cf8)
	ld [wd592], a
	ld hl, Func_33cf8
	ld a, l
	ld [wd593], a
	ld a, h
	ld [wd593 + 1], a
	scf
	ret

Func_33c9d:
	ld a, [wd585]
	cp MAP_FIGHTING_FORT_BASEMENT
	jr z, .asm_33ca6
	scf
	ret
.asm_33ca6
	scf
	ccf
	ret

Func_33ca9:
	ld hl, FightingFortMaze17_NPCs
	call Func_3205
	scf
	ccf
	ret

Func_33cb2:
	ld hl, FightingFortMaze17_NPCInteractions
	call Func_328c
	scf
	ret

Func_33cba:
	xor a
	start_script
	script_command_01
	set_event EVENT_OPENED_CHEST_FIGHTING_FORT_4
	play_sfx SFX_OPEN_CHEST
	load_npc NPC_CHEST_OPENED, 1, 1, SOUTH
	unload_npc NPC_CHEST_CLOSED
	print_text OpenedTreasureBoxText
	receive_card DIGLETT_LV16
	script_command_02
	end_script
	ret

Func_33cd3:
	ld a, EVENT_OPENED_CHEST_FIGHTING_FORT_4
	farcall GetEventValue
	jr nz, .asm_33cde
	scf
	ccf
	ret
.asm_33cde
	scf
	ret

Func_33ce0:
	xor a
	start_script
	script_command_01
	print_text TreasureBoxWasEmptyText
	script_command_02
	end_script
	ret

Func_33ceb:
	ld a, EVENT_OPENED_CHEST_FIGHTING_FORT_4
	farcall GetEventValue
	jr z, .asm_33cf6
	scf
	ccf
	ret
.asm_33cf6
	scf
	ret

Func_33cf8:
	ld a, SFX_DOORS
	call PlaySFX
	ld bc, TILEMAP_0C9
	lb de, 8, 3
	farcall Func_12c0ce
	ld a, [wPlayerOWObject]
	farcall GetOWObjectTilePosition
	ld a, $03
	cp e
	jr nz, .asm_33d17
	call Func_30000
	ret
.asm_33d17
	call Func_30005
	ret

Func_33d1b:
	ld a, SFX_DOORS
	call PlaySFX
	ld bc, TILEMAP_0CA
	lb de, 4, 6
	farcall Func_12c0ce
	call Func_30005
	ret

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
	dbw $06, Func_33d5c
	db $ff

Func_33d5c:
	ld hl, FightingFortMaze20_StepEvents
	call Func_324d
	ret

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
	dbw $06, Func_33d91
	db $ff

Func_33d91:
	ld hl, FightingFortMaze22_StepEvents
	call Func_324d
	ret

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
	dbw $06, Func_33de1
	dbw $02, Func_33de8
	dbw $10, Func_33dcc
	db $ff

Func_33dcc:
	ld a, VAR_TIMES_MET_RONALD
	farcall GetVarValue
	cp $07
	jr c, .asm_33dd8
	scf
	ret
.asm_33dd8
	ld a, MUSIC_RONALD
	farcall PlayAfterCurrentSong
	scf
	ccf
	ret

Func_33de1:
	ld hl, ColorlessAltarEntrance_StepEvents
	call Func_324d
	ret

Func_33de8:
	ld a, VAR_TIMES_MET_RONALD
	farcall GetVarValue
	cp $07
	jr nc, .asm_33e12
	ld a, NPC_GR_X
	lb de, 4, 7
	ld b, SOUTH
	farcall LoadOWObjectInMap
	ld a, $0a
	ld [wd582], a
	ld a, BANK(Func_3442d)
	ld [wd592], a
	ld hl, Func_3442d
	ld a, l
	ld [wd593], a
	ld a, h
	ld [wd593 + 1], a
.asm_33e12
	scf
	ret
