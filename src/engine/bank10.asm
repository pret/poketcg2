SECTION "Bank 10@4462", ROMX[$4462], BANK[$10]

OverworldTcg_MapHeader:
	db OVERWORLD_MAP_GFX_TCG
	dba OverworldTcg_MapScripts
	db MUSIC_OVERWORLD

OverworldTcg_MapScripts:
	dbw $01, Func_40474
	dbw $02, Func_4048a
	dbw $04, Func_4053b
	dbw $0f, Func_4053e
	db $ff ; end

Func_40474:
	ld a, [wd584]
	cp MAP_OVERHEAD_ISLANDS
	jr z, .asm_40482
	cp MAP_TCG_AIRPORT
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

	ld a, NPC_VOLCANO_SMOKE_TCG
	lb de, $78, $00
	ld b, NORTH
	farcall LoadOWObject

	ld a, [wCurOWLocation]
	call PrintTCGIslandLocationName

	ld a, [wd584]
	cp MAP_TCG_AIRPORT
	jr z, .gr_ship_cutscene
	cp MAP_OVERHEAD_ISLANDS
	jr z, .gr_ship_cutscene

	; this is the case where player is
	; on OW map and navigating
	ld a, [wPlayerOWObject]
	lb de, 0, 0
	ld b, SOUTH
	farcall LoadOWObject
	ld a, [wCurOWLocation]
	call PlacePlayerInTCGIslandLocation

	ld a, NPC_CURSOR_TCG
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
	cp MAP_OVERHEAD_ISLANDS
	jr z, .asm_40528
	ld a, NPC_GR_BLIMP
	lb de, $50, $78
	ld b, EAST
	farcall LoadOWObject
	scf
	ret
.asm_40528
	ld a, NPC_GR_BLIMP
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
	bit B_PAD_A, a
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
	jr nc, .got_pointer
	inc h
.got_pointer
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
	jr nc, .got_pointer
	inc h
.got_pointer
	ld a, [hli]
	ld d, a
	ld a, [hl]
	sub 12
	ld e, a
	ld a, NPC_CURSOR_TCG
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
	jr nc, .got_pointer_1
	inc h
.got_pointer_1
	ld a, c
	add l
	ld l, a
	jr nc, .got_pointer_2
	inc h
.got_pointer_2
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
	ret

.data
	db MAP_MASON_LABORATORY_MAIN,       6, 13, NORTH ; OWMAP_MASON_LABORATORY
	db MAP_ISHIHARAS_HOUSE,             4, 11, NORTH ; OWMAP_ISHIHARAS_HOUSE
	db MAP_LIGHTNING_CLUB_ENTRANCE,     4,  7, NORTH ; OWMAP_LIGHTNING_CLUB
	db MAP_PSYCHIC_CLUB_ENTRANCE,       4,  7, NORTH ; OWMAP_PSYCHIC_CLUB
	db MAP_ROCK_CLUB_ENTRANCE,          4,  7, NORTH ; OWMAP_ROCK_CLUB
	db MAP_FIGHTING_CLUB_ENTRANCE,      4,  7, NORTH ; OWMAP_FIGHTING_CLUB
	db MAP_GRASS_CLUB_ENTRANCE,         4,  7, NORTH ; OWMAP_GRASS_CLUB
	db MAP_SCIENCE_CLUB_ENTRANCE,       4,  7, NORTH ; OWMAP_SCIENCE_CLUB
	db MAP_WATER_CLUB_ENTRANCE,         4,  7, NORTH ; OWMAP_WATER_CLUB
	db MAP_FIRE_CLUB_ENTRANCE,          4,  7, NORTH ; OWMAP_FIRE_CLUB
	db MAP_TCG_AIRPORT_ENTRANCE,        5, 11, NORTH ; OWMAP_TCG_AIRPORT
	db MAP_TCG_CHALLENGE_HALL_ENTRANCE, 4,  7, NORTH ; OWMAP_TCG_CHALLENGE_HALL
	db MAP_POKEMON_DOME_ENTRANCE,       7,  7, NORTH ; OWMAP_POKEMON_DOME

Func_406d1:
	ld a, [wPlayerOWObject]
	ld b, $01
	farcall _SetOWObjectAnimStruct1Flag2

	ld a, [wPlayerOWLocation]
	sla a ; *2
	ld hl, TCGIslandPlayerPaths
	add l
	ld l, a
	jr nc, .got_pointer_1
	inc h
.got_pointer_1
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, [wCurOWLocation]
	sla a ; *2
	add l
	ld l, a
	jr nc, .got_pointer_2
	inc h
.got_pointer_2
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
	jr nc, .got_pointer_3
	inc h
.got_pointer_3
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
	bit B_PAD_B, a
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
	cp MAP_TCG_AIRPORT
	jr z, .asm_40cfa

	ld a, MAP_TCG_AIRPORT
	lb de, 0, 0
	ld b, NORTH
	farcall Func_d3c4
	ld hl, .movement_3
	jr .start_movement
.asm_40cfa
	ld a, MAP_OVERHEAD_ISLANDS
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

SECTION "Bank 10@4db3", ROMX[$4db3], BANK[$10]

MasonLaboratoryMain_MapHeader:
	db MAP_GFX_MASON_LABORATORY_MAIN
	dba MasonLaboratoryMain_MapScripts
	db MUSIC_OVERWORLD

MasonLaboratoryMain_StepEvents:
	_ow_coordinate_function 6, 14, 0, 1, 7, 2, $10, $4fff
	_ow_coordinate_function 7, 14, 0, 1, 7, 2, $10, $4fff
	map_exit 0, 5, MAP_MASON_LABORATORY_TRAINING_ROOM, 12, 11, WEST
	map_exit 0, 6, MAP_MASON_LABORATORY_TRAINING_ROOM, 12, 12, WEST
	map_exit 13, 5, MAP_MASON_LABORATORY_COMPUTER_ROOM, 1, 5, EAST
	map_exit 13, 6, MAP_MASON_LABORATORY_COMPUTER_ROOM, 1, 6, EAST
	db $ff

MasonLaboratoryMain_NPCs:
	npc NPC_DR_MASON, 7, 5, SOUTH, $0
	npc NPC_SAM, 2, 7, EAST, $0
	npc NPC_LAB_TECH_PC_GUIDE, 3, 2, SOUTH, $0
	npc NPC_LAB_TECH_CLUB_GUIDE, 11, 8, SOUTH, $0
	npc NPC_LAB_TECH_BOOSTER_GUIDE, 9, 10, WEST, $0
	npc NPC_LAB_TECH_ROOM_GUIDE, 10, 4, WEST, $0
	npc NPC_RONALD, 3, 6, SOUTH, $521d
	db $ff

MasonLaboratoryMain_NPCInteractions:
	npc_script NPC_DR_MASON, $10, $5188
	npc_script NPC_SAM, $10, $5233
	npc_script NPC_LAB_TECH_PC_GUIDE, $10, $5370
	npc_script NPC_LAB_TECH_CLUB_GUIDE, $10, $5396
	npc_script NPC_LAB_TECH_BOOSTER_GUIDE, $10, $53bc
	npc_script NPC_LAB_TECH_ROOM_GUIDE, $10, $53e2
	npc_script NPC_RONALD, $10, $51f2
	db $ff

MasonLaboratoryMain_OWInteractions:
	ow_script 1, 2, PCMenu
	ow_script 2, 2, PCMenu
	ow_script 6, 3, $10, $501d
	ow_script 7, 3, $10, $501d
	db $ff

MasonLaboratoryMain_MapScripts:
	dbw $06, $4e83
	dbw $08, $4f04
	dbw $09, $4f21
	dbw $11, $4f14
	dbw $07, $4e8a
	dbw $02, $4e91
	dbw $01, $4e72
	db $ff
; gap from 0x40e72 to 0x40f3d

SECTION "Bank 10@4f3d", ROMX[$4f3d], BANK[$10]

MasonLaboratoryMain_AfterDuelScripts:
	npc_script NPC_DR_MASON, $10, $533e
	npc_script NPC_SAM, $10, $52c0
	db $ff
; gap from 0x40f46 to 0x41592

SECTION "Bank 10@5592", ROMX[$5592], BANK[$10]

TcgChallengeHall_MapHeader:
	db MAP_GFX_TCG_CHALLENGE_HALL
	dba TcgChallengeHall_MapScripts
	db MUSIC_OVERWORLD

TcgChallengeHall_StepEvents:
	map_exit 7, 15, MAP_TCG_CHALLENGE_HALL_ENTRANCE, 4, 1, SOUTH
	map_exit 8, 15, MAP_TCG_CHALLENGE_HALL_ENTRANCE, 5, 1, SOUTH
	db $ff

TcgChallengeHall_NPCs:
	npc NPC_CUP_HOST, 7, 2, SOUTH, $5768
	npc NPC_TCG_CUP_CLERK_RIGHT, 10, 9, SOUTH, $5768
	npc NPC_TCG_CUP_CLERK_LEFT, 5, 9, SOUTH, $5768
	npc NPC_TCG_CHALLENGE_HALL_MAN, 7, 10, SOUTH, $5751
	db $ff

TcgChallengeHall_NPCInteractions:
	npc_script NPC_TCG_CUP_CLERK_LEFT, $10, $5662
	npc_script NPC_TCG_CUP_CLERK_RIGHT, $10, $5705
	npc_script NPC_TCG_CHALLENGE_HALL_MAN, $10, $5720
	db $ff

TcgChallengeHall_MapScripts:
	dbw $06, $55f3
	dbw $08, $5622
	dbw $09, $562a
	dbw $07, $55fa
	dbw $01, $55e6
	dbw $02, $5603
	dbw $0b, $563b
	db $ff
; gap from 0x415e6 to 0x41be9

SECTION "Bank 10@5be9", ROMX[$5be9], BANK[$10]

GrAirport_MapHeader:
	db MAP_GFX_GR_AIRPORT
	dba GrAirport_MapScripts
	db MUSIC_GROVERWORLD

GrAirport_StepEvents:
	map_exit 13, 9, MAP_GR_AIRPORT_ENTRANCE, 1, 6, EAST
	map_exit 13, 10, MAP_GR_AIRPORT_ENTRANCE, 1, 7, EAST
	_ow_coordinate_function 5, 8, 0, 0, 0, 3, $10, $5dac
	ow_script 4, 9, $10, $5dac
	ow_script 3, 9, $10, $5dac
	_ow_coordinate_function 2, 8, 0, 0, 0, 1, $10, $5dac
	db $ff

GrAirport_NPCs:
	npc NPC_GR_5, 4, 8, SOUTH, $0
	db $ff

GrAirport_NPCInteractions:
	npc_script NPC_GR_5, $10, $5cd3
	db $ff

GrAirport_MapScripts:
	dbw $00, $5c44
	dbw $06, $5c50
	dbw $08, $5ccb
	dbw $07, $5c57
	dbw $02, $5c60
	dbw $0f, $5ca1
	db $ff
; gap from 0x41c44 to 0x41e8e

SECTION "Bank 10@5e8e", ROMX[$5e8e], BANK[$10]

SealedFort_MapHeader:
	db MAP_GFX_SEALED_FORT
	dba SealedFort_MapScripts
	db MUSIC_FORT_4

SealedFort_StepEvents:
	map_exit 5, 12, MAP_SEALED_FORT_ENTRANCE, 4, 1, SOUTH
	map_exit 6, 12, MAP_SEALED_FORT_ENTRANCE, 5, 1, SOUTH
	map_exit 7, 12, MAP_SEALED_FORT_ENTRANCE, 6, 1, SOUTH
	ow_script 6, 6, $10, $5f66
	db $ff

SealedFort_OWInteractions:
	ow_script 6, 2, $10, $5fe1
	ow_script 2, 2, $10, $607e
	ow_script 3, 2, $10, $6119
	ow_script 4, 2, $10, $61b4
	ow_script 5, 2, $10, $624f
	ow_script 9, 2, $10, $62ec
	ow_script 7, 2, $10, $6387
	ow_script 8, 2, $10, $6424
	ow_script 10, 2, $10, $64bf
	db $ff

SealedFort_MapScripts:
	dbw $06, $5f14
	dbw $08, $5f1b
	dbw $09, $5f36
	db $ff
; gap from 0x41f14 to 0x41f41

SECTION "Bank 10@5f41", ROMX[$5f41], BANK[$10]

SealedFort_AfterDuelScripts:
	npc_script NPC_TOBICHAN, $10, $6050
	npc_script NPC_EIJI, $10, $60eb
	npc_script NPC_MAGICIAN, $10, $6186
	npc_script NPC_TOSHIRON, $10, $6221
	npc_script NPC_PIERROT, $10, $62be
	npc_script NPC_ANNA, $10, $6359
	npc_script NPC_DEE, $10, $63f6
	npc_script NPC_MASQUERADE, $10, $6491
	npc_script NPC_YUI, $10, $652c
	db $ff
; gap from 0x41f66 to 0x425cf

SECTION "Bank 10@65cf", ROMX[$65cf], BANK[$10]

GrChallengeHall_MapHeader:
	db MAP_GFX_GR_CHALLENGE_HALL
	dba GrChallengeHall_MapScripts
	db MUSIC_GROVERWORLD

GrChallengeHall_StepEvents:
	map_exit 7, 15, MAP_GR_CHALLENGE_HALL_ENTRANCE, 4, 1, SOUTH
	map_exit 8, 15, MAP_GR_CHALLENGE_HALL_ENTRANCE, 5, 1, SOUTH
	db $ff

GrChallengeHall_NPCs:
	npc NPC_CUP_HOST, 7, 2, SOUTH, $694a
	npc NPC_GR_CUP_CLERK_LEFT, 4, 8, SOUTH, $694a
	npc NPC_GR_CUP_CLERK_RIGHT, 11, 8, SOUTH, $694a
	npc NPC_GR_STAFF, 8, 6, NORTH, $699f
	db $ff

GrChallengeHall_NPCInteractions:
	npc_script NPC_GR_CUP_CLERK_LEFT, $10, $688d
	npc_script NPC_GR_CUP_CLERK_RIGHT, $10, $692f
	npc_script NPC_GR_STAFF, $10, $6961
	db $ff

GrChallengeHall_OWInteractions:
	ow_script 7, 3, $10, $671f
	ow_script 8, 3, $10, $671f
	db $ff

GrChallengeHall_MapScripts:
	dbw $06, $6639
	dbw $08, $66b9
	dbw $09, $66d6
	dbw $11, $66c9
	dbw $07, $6640
	dbw $02, $666e
	dbw $01, $6649
	dbw $0b, $66f8
	db $ff
; gap from 0x42639 to 0x42e2b

SECTION "Bank 10@6e2b", ROMX[$6e2b], BANK[$10]

FightingFortMaze1_MapHeader:
	db MAP_GFX_FIGHTING_FORT_MAZE_1
	dba FightingFortMaze1_MapScripts
	db MUSIC_FORT_3

FightingFortMaze1_StepEvents:
	map_exit 4, 8, MAP_FIGHTING_FORT, 3, 2, SOUTH
	map_exit 5, 8, MAP_FIGHTING_FORT, 3, 2, SOUTH
	map_exit 4, 0, MAP_FIGHTING_FORT_MAZE_6, 4, 7, NORTH
	map_exit 5, 0, MAP_FIGHTING_FORT_MAZE_6, 5, 7, NORTH
	map_exit 9, 3, MAP_FIGHTING_FORT_MAZE_2, 1, 3, EAST
	map_exit 9, 4, MAP_FIGHTING_FORT_MAZE_2, 1, 4, EAST
	db $ff

FightingFortMaze1_MapScripts:
	dbw $06, $6e6e
	dbw $02, $6e75
	db $ff
; gap from 0x42e6e to 0x42e80

SECTION "Bank 10@6e80", ROMX[$6e80], BANK[$10]

FightingFortMaze21_MapHeader:
	db MAP_GFX_FIGHTING_FORT_MAZE_21
	dba FightingFortMaze21_MapScripts
	db MUSIC_FORT_3

FightingFortMaze21_StepEvents:
	map_exit 4, 8, MAP_FIGHTING_FORT_MAZE_17, 4, 1, SOUTH
	map_exit 5, 8, MAP_FIGHTING_FORT_MAZE_17, 5, 1, SOUTH
	map_exit 0, 3, MAP_FIGHTING_FORT_MAZE_20, 8, 3, WEST
	map_exit 0, 4, MAP_FIGHTING_FORT_MAZE_20, 8, 4, WEST
	map_exit 9, 3, MAP_FIGHTING_FORT_MAZE_22, 1, 3, EAST
	map_exit 9, 4, MAP_FIGHTING_FORT_MAZE_22, 1, 4, EAST
	db $ff

FightingFortMaze21_MapScripts:
	dbw $06, $6ec3
	dbw $02, $6eca
	db $ff
; gap from 0x42ec3 to 0x42ed5

SECTION "Bank 10@6ed5", ROMX[$6ed5], BANK[$10]

GrCastleBiruritchi_MapHeader:
	db MAP_GFX_GR_CASTLE_BIRURITCHI
	dba GrCastleBiruritchi_MapScripts
	db MUSIC_GRCASTLE

GrCastleBiruritchi_StepEvents:
	map_exit 6, 15, MAP_GR_CASTLE, 6, 1, SOUTH
	map_exit 7, 15, MAP_GR_CASTLE, 7, 1, SOUTH
	map_exit 8, 15, MAP_GR_CASTLE, 8, 1, SOUTH
	db $ff

GrCastleBiruritchi_NPCs:
	npc NPC_BIRURITCHI, 7, 5, SOUTH, $0
	db $ff

GrCastleBiruritchi_NPCInteractions:
	npc_script NPC_BIRURITCHI, $10, $7136
	db $ff

GrCastleBiruritchi_OWInteractions:
	ow_script 4, 12, $10, $71bf
	ow_script 10, 12, $10, $71bf
	db $ff

GrCastleBiruritchi_MapScripts:
	dbw $06, $6f2e
	dbw $08, $6fad
	dbw $09, $6fbd
	dbw $07, $6f35
	dbw $02, $6f3e
	dbw $0b, $6fcd
	dbw $04, $6f86
	dbw $0f, $6fa1
	db $ff
; gap from 0x42f2e to 0x42fc8

SECTION "Bank 10@6fc8", ROMX[$6fc8], BANK[$10]

GrCastleBiruritchi_AfterDuelScripts:
	npc_script NPC_BIRURITCHI, $10, $71a6
	db $ff
