Func_40000:
	ld hl, $ac5
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	print_npc_text CombosBookText
	script_command_02
	end_script
	ret

Func_40016:
	ld hl, $ac6
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	print_npc_text EnergyTransBookText
	script_command_02
	end_script
	ret

Func_4002c:
	ld hl, $ac7
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	print_npc_text ToxicGasBookText
	script_command_02
	end_script
	ret

Func_40042:
	ld hl, $ac8
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	print_npc_text RainDanceBookText
	script_command_02
	end_script
	ret

Func_40058:
	ld hl, $ac9
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	print_npc_text SelfdestructBookText
	script_command_02
	end_script
	ret

Func_4006e:
	ld hl, $aca
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	print_npc_text DamageSwapBookText
	script_command_02
	end_script
	ret

Func_40084:
	ld hl, $acb
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	print_npc_text RemoveEnergiesBookText
	script_command_02
	end_script
	ret

Func_4009a:
	ld hl, $acc
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	print_npc_text PrehistoricPowerBookText
	script_command_02
	end_script
	ret

Func_400b0:
	ld hl, $acd
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	print_npc_text WeaknessResistanceBookText
	script_command_02
	end_script
	ret

Func_400c6:
	ld hl, $ace
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	print_npc_text TeamGRBookText
	script_command_02
	end_script
	ret

Func_400dc:
	ld hl, $acf
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	print_npc_text GameCenterBookText
	script_command_02
	end_script
	ret

Func_400f2:
	ld hl, $ad0
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	print_npc_text SamePokemonBookText
	script_command_02
	end_script
	ret

Func_40108:
	ld hl, $ad7
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	print_npc_text RockGroundPokemonBookText
	script_command_02
	end_script
	ret

Func_4011e:
	ld hl, $ad8
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	print_npc_text FightingPokemonSurefireMethodBookText
	script_command_02
	end_script
	ret

Func_40134:
	ld hl, $ad9
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	print_npc_text FightingPokemonFormidableOpponentsBookText
	script_command_02
	end_script
	ret

Func_4014a:
	ld hl, $ada
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	print_npc_text FightingPokemonBookText
	script_command_02
	end_script
	ret

Func_40160:
	ld hl, $adb
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	print_npc_text FightingPokemonCombosBookText
	script_command_02
	end_script
	ret

Func_40176:
	ld hl, $adc
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	print_npc_text FightingPokemonDeckBuildingBookText
	script_command_02
	end_script
	ret

Func_4018c:
	ld hl, $add
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	print_npc_text PlantlikePokemonBookText
	script_command_02
	end_script
	ret

Func_401a2:
	ld hl, $ade
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	print_npc_text GrassPokemonBreederBookText
	script_command_02
	end_script
	ret

Func_401b8:
	ld hl, $adf
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	print_npc_text GrassPokemonDeckBuildingBookText
	script_command_02
	end_script
	ret

Func_401ce:
	ld hl, $ae0
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	print_npc_text SciencePokemonBookText
	script_command_02
	end_script
	ret

Func_401e4:
	ld hl, $ae1
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	print_npc_text SciencePokemonSurefireMethodBookText
	script_command_02
	end_script
	ret

Func_401fa:
	ld hl, $ae2
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	print_npc_text SciencePokemonDeckBuildingBookText
	script_command_02
	end_script
	ret

Func_40210:
	ld hl, $ae3
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	print_npc_text WaterPokemonBookText
	script_command_02
	end_script
	ret

Func_40226:
	ld hl, $ae4
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	print_npc_text WaterPokemonAttacksBookText
	script_command_02
	end_script
	ret

Func_4023c:
	ld hl, $ae5
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	print_npc_text PsyduckGolduckBookText
	script_command_02
	end_script
	ret

Func_40252:
	ld hl, $ae6
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	print_npc_text FirePokemonBookText
	script_command_02
	end_script
	ret

Func_40268:
	ld hl, $ae7
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	print_npc_text FirePokemonAttacksBookText
	script_command_02
	end_script
	ret

Func_4027e:
	ld hl, $ae8
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	print_npc_text FirePokemonDeckBuildingBookText
	script_command_02
	end_script
	ret

Func_40294:
	ld hl, $ae9
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	print_npc_text LightningPokemonBookText
	script_command_02
	end_script
	ret

Func_402aa:
	ld hl, $aea
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	print_npc_text LightningPokemonDeckBuildingBookText
	script_command_02
	end_script
	ret

Func_402c0:
	ld hl, $aeb
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	print_npc_text BirdPokemonBookText
	script_command_02
	end_script
	ret

Func_402d6:
	ld hl, $aec
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	print_npc_text PsychicPokemonBookText
	script_command_02
	end_script
	ret

Func_402ec:
	ld hl, $aed
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	print_npc_text PsychicPokemonPokemonPowerBookText
	script_command_02
	end_script
	ret

Func_40302:
	ld hl, $aee
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	print_npc_text UsefulButtonsBookText
	script_command_02
	end_script
	ret

Func_40318:
	ld hl, $aef
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	print_npc_text ColorlessPokemonBookText
	script_command_02
	end_script
	ret

Func_4032e:
	ld hl, $af0
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	print_npc_text CardPopBookText
	script_command_02
	end_script
	ret

Func_40344:
	ld hl, $af1
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	print_npc_text EnergyCardColorsBookText
	script_command_02
	end_script
	ret

Func_4035a:
	ld hl, $af2
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	print_npc_text LegendaryPokemonCardsVol1BookText
	script_command_02
	end_script
	ret

Func_40370:
	ld hl, $af3
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	print_npc_text LegendaryPokemonCardsVol2BookText
	script_command_02
	end_script
	ret

Func_40386:
	ld hl, $af4
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	print_npc_text LegendaryPokemonCardsVol3BookText
	script_command_02
	end_script
	ret

Func_4039c:
	ld hl, $af5
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	print_npc_text LegendaryPokemonCardsVol4BookText
	script_command_02
	end_script
	ret

Func_403b2:
	ld hl, $af6
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	print_npc_text GrandMastersBookText
	script_command_02
	end_script
	ret

Func_403c8:
	ld hl, $af7
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	print_npc_text CoinsBookText
	script_command_02
	end_script
	ret

Func_403de:
	ld hl, $ad1
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	print_npc_text PhantomCardsBookText
	script_command_02
	end_script
	ret

Func_403f4:
	ld hl, $ad2
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	print_npc_text DarkPokemonBookText
	script_command_02
	end_script
	ret

Func_4040a:
	ld hl, $ad3
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	print_npc_text AugmentBasicPokemonBookText
	script_command_02
	end_script
	ret

Func_40420:
	ld hl, $ad4
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	print_npc_text GRKingCardsBookText
	script_command_02
	end_script
	ret

Func_40436:
	ld hl, $ad5
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	print_npc_text SpecialEnergyBookText
	script_command_02
	end_script
	ret

Func_4044c:
	ld hl, $ad6
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	print_npc_text GetCoinsBookText
	script_command_02
	end_script
	ret

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

MasonLaboratoryMain_MapHeader:
	db MAP_GFX_MASON_LABORATORY_MAIN
	dba MasonLaboratoryMain_MapScripts
	db MUSIC_OVERWORLD

MasonLaboratoryMain_StepEvents:
	_ow_coordinate_function 6, 14, 0, 1, 7, 2, Func_40fff
	_ow_coordinate_function 7, 14, 0, 1, 7, 2, Func_40fff
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
	npc NPC_RONALD, 3, 6, SOUTH, Func_4121d
	db $ff

MasonLaboratoryMain_NPCInteractions:
	npc_script NPC_DR_MASON, Func_41188
	npc_script NPC_SAM, Func_41233
	npc_script NPC_LAB_TECH_PC_GUIDE, Func_41370
	npc_script NPC_LAB_TECH_CLUB_GUIDE, Func_41396
	npc_script NPC_LAB_TECH_BOOSTER_GUIDE, Func_413bc
	npc_script NPC_LAB_TECH_ROOM_GUIDE, Func_413e2
	npc_script NPC_RONALD, Func_411f2
	db $ff

MasonLaboratoryMain_OWInteractions:
	ow_script 1, 2, PCMenu
	ow_script 2, 2, PCMenu
	ow_script 6, 3, Func_4101d
	ow_script 7, 3, Func_4101d
	db $ff

MasonLaboratoryMain_MapScripts:
	dbw $06, Func_40e83
	dbw $08, Func_40f04
	dbw $09, Func_40f21
	dbw $11, Func_40f14
	dbw $07, Func_40e8a
	dbw $02, Func_40e91
	dbw $01, Func_40e72
	db $ff

Func_40e72:
	ld a, VAR_TIMES_MET_RONALD
	farcall GetVarValue
	or a
	jr nz, .asm_40e80
	ld a, MUSIC_RONALD
	ld [wNextMusic], a
.asm_40e80
	scf
	ccf
	ret

Func_40e83:
	ld hl, MasonLaboratoryMain_StepEvents
	call Func_324d
	ret

Func_40e8a:
	ld hl, MasonLaboratoryMain_NPCs
	call Func_3205
	ret

Func_40e91:
	ld a, VAR_TIMES_MET_RONALD
	farcall GetVarValue
	or a
	jr z, .asm_40ead
	ld a, EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE_DUMMY
	farcall GetEventValue
	jr nz, .asm_40ee8
	ld a, EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE
	farcall GetEventValue
	call nz, Func_40ef9
	scf
	ret
.asm_40ead
	ld a, $03
	ld de, $605
	ld b, $01
	farcall Func_10f0f
	ld a, [wPlayerOWObject]
	ld de, $60f
	farcall SetOWObjectTilePosition
	ld a, $02
	ld b, $03
	farcall SetOWObjectDirection
	ld de, $408
	farcall CalcOWScroll
	ld a, $0a
	ld [wd582], a
	ld a, $10
	ld [wd592], a
	ld hl, $4f46
	ld a, l
	ld [wd593], a
	ld a, h
	ld [$d594], a
	scf
	ret
.asm_40ee8
	ld a, EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE_DUMMY
	farcall ZeroOutEventValue
	call Func_40ef9
	ld a, $00
	call Func_338f
	scf
	ccf
	ret

Func_40ef9:
	ld bc, $6
	ld de, $500
	farcall Func_12c0ce
	ret

Func_40f04:
	ld hl, MasonLaboratoryMain_NPCInteractions
	call Func_328c
	jr nc, .asm_40f12
	ld hl, MasonLaboratoryMain_OWInteractions
	call Func_32bf
.asm_40f12
	scf
	ret

Func_40f14:
	ld a, EVENT_EB
	farcall GetEventValue
	jr nz, .asm_40f1e
	scf
	ret
.asm_40f1e
	scf
	ccf
	ret

Func_40f21:
	ld a, EVENT_EB
	farcall GetEventValue
	jr nz, .asm_40f34
	ld hl, MasonLaboratoryMain_AfterDuelScripts
	ld a, [wScriptNPC]
	call Func_344c
	scf
	ret
.asm_40f34
	farcall Func_ec6c
	call Func_41074
	scf
	ret

MasonLaboratoryMain_AfterDuelScripts:
	npc_script NPC_DR_MASON, Func_4133e
	npc_script NPC_SAM, Func_412c0
	db $ff

Func_40f46:
	xor a
	start_script
	script_callfar Script_34000
	move_player .NPCMovement_40f80, TRUE
	wait_for_player_animation
	set_active_npc NPC_DR_MASON, DialogDrMasonText
	script_command_01
	script_command_64 $03
	script_command_64 $04
	script_command_64 $08
	set_event EVENT_GOT_CHANSEY_COIN
	script_call .ows_40f83
	script_call .ows_40fac
	script_call .ows_40f9b
	quit_script
	farcall Func_ea30
	ld a, $01
	start_script
	play_sfx SFX_56
	script_command_02
	end_script
	ld a, $00
	ld [wd582], a
	ret
.NPCMovement_40f80:
	db NORTH, MOVE_2
	db $ff
.ows_40f83
	set_event EVENT_SET_UNTIL_MAP_RELOAD_1
	set_active_npc_direction SOUTH
	print_npc_text Text0efb
.ows_40f8a
	ask_question Text0efc, TRUE
	script_jump_if_b0nz .ows_40f97
	print_npc_text Text0efd
	script_jump .ows_40f8a
.ows_40f97
	print_npc_text Text0efe
	script_ret
.ows_40f9b
	print_npc_text Text0eff
	play_song MUSIC_BOOSTER_PACK
	print_text_wide_textbox Text0f00
	wait_song
	do_frames 60
	wait_input
	resume_song
	print_npc_text Text0f01
	script_ret
.ows_40fac
	print_npc_text Text0f02
	play_song MUSIC_BOOSTER_PACK
	print_text_wide_textbox Text0f03
	wait_song
	do_frames 60
	wait_input
	resume_song
	give_deck STARTER_DECK_ID
	script_ret

Func_40fbc:
	ld a, NPC_DR_MASON
	ld [wScriptNPC], a
	ld hl, $9d0
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	set_active_npc_direction SOUTH
	print_npc_text Text0f04
	script_command_02
	get_player_x_position
	compare_loaded_var $07
	script_jump_if_b0nz .ows_40fe4
	move_player NPCMovement_40ff5, TRUE
	script_jump .ows_40fe8
.ows_40fe4
	move_player NPCMovement_40ffc, TRUE
.ows_40fe8
	wait_for_player_animation
	script_command_01
	print_npc_text Text0f05
	script_command_02
	end_script
	ld a, $00
	ld [wd582], a
	ret
NPCMovement_40ff5:
	db NORTH, MOVE_4
	db EAST, MOVE_1
	db NORTH, MOVE_4
	db $ff
NPCMovement_40ffc:
	db NORTH, MOVE_8
	db $ff

Func_40fff:
	ld a, EVENT_SET_UNTIL_MAP_RELOAD_1
	farcall GetEventValue
	jr nz, .asm_41013
	ld a, $00
	ld de, $107
	ld b, $02
	farcall Func_d3c4
	ret
.asm_41013
	ld a, EVENT_SET_UNTIL_MAP_RELOAD_1
	farcall ZeroOutEventValue
	call Func_40fbc
	ret

Func_4101d:
	ld a, EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE
	farcall GetEventValue
	ret z
	farcall Func_ebc6
	jr nc, .asm_41038
	farcall Func_eb39
	xor a
	start_script
	script_command_01
	print_text Text0f06
	script_command_02
	end_script
.asm_41038
	farcall Func_ec6c
	xor a
	farcall Func_ef40
	farcall Func_efd0
	xor a
	ld bc, $0
	farcall Func_135ec
	jr c, .asm_41061
	xor a
	start_script
	set_event EVENT_EB
	set_var VAR_34, $01
	script_command_64 $0d
	end_script
	farcall Func_eff7
	jr .asm_41073
.asm_41061
	or a
	jr z, .asm_41073
	ld bc, $0
	ld a, c
	ld [wde11], a
	ld a, b
	ld [$de12], a
	farcall Func_ec38
.asm_41073
	ret

Func_41074:
	ld a, EVENT_SET_UNTIL_MAP_RELOAD_2
	farcall GetEventValue
	jp z, .asm_410ee
	ld a, [wde11]
	ld c, a
	ld a, [$de12]
	ld b, a
	inc bc
	ld a, b
	cp $03
	jr c, .asm_41090
	jr nz, .asm_41090
	ld a, c
	cp $e8
.asm_41090
	jr nc, .asm_4109a
	ld a, c
	ld [wde11], a
	ld a, b
	ld [$de12], a
.asm_4109a
	ld a, VAR_34
	farcall GetVarValue
	cp $05
	jr z, .asm_410c4
	ld b, a
	xor a
	ld c, $01
	farcall Func_135ec
	jp c, .asm_410fc
	ld a, $34
	ld d, a
	farcall GetVarValue
	inc a
	ld c, a
	ld a, d
	farcall SetVarValue
	farcall Func_eff7
	jp .asm_41114
.asm_410c4
	ld a, [wde0d]
	ld c, a
	ld a, [$de0e]
	ld b, a
	inc bc
	ld a, b
	cp $03
	jr c, .asm_410d7
	jr nz, .asm_410d7
	ld a, c
	cp $e8
.asm_410d7
	jr nc, .asm_410e1
	ld a, c
	ld [wde0d], a
	ld a, b
	ld [$de0e], a
.asm_410e1
	call Func_4112e
	xor a
	ld bc, $501
	farcall Func_135ec
	jr .asm_41115
.asm_410ee
	ld a, VAR_34
	farcall GetVarValue
	ld b, a
	xor a
	ld c, $02
	farcall Func_135ec
.asm_410fc
	call Func_4112e
	ld bc, $0
	ld a, c
	ld [wde11], a
	ld a, b
	ld [$de12], a
.asm_4110a
	ld a, EVENT_EB
	farcall ZeroOutEventValue
	farcall Func_ec38
.asm_41114
	ret
.asm_41115
	ld a, [wde11]
	ld e, a
	ld a, [$de12]
	ld d, a
	ld a, d
	cp $00
	jr c, .asm_41127
	jr nz, .asm_41127
	ld a, e
	cp $32
.asm_41127
	jr nz, .asm_4110a
	call Func_41167
	jr .asm_4110a

Func_4112e:
	ld a, [wde11]
	ld c, a
	ld a, [$de12]
	ld b, a
	ld a, [wde15]
	ld e, a
	ld a, [$de16]
	ld d, a
	ld a, b
	cp d
	jr c, .asm_41146
	jr nz, .asm_41146
	ld a, c
	cp e
.asm_41146
	jr nc, .asm_4114a
	scf
	ret
.asm_4114a
	ld a, c
	ld [wde15], a
	ld a, b
	ld [$de16], a
	call EnableSRAM
	ld hl, sPlayerName
	ld de, wde19
	ld bc, $10
	call CopyDataHLtoDE_SaveRegisters
	call DisableSRAM
	scf
	ccf
	ret

Func_41167:
	xor a
	start_script
	check_event EVENT_GOT_DUGTRIO_COIN
	script_jump_if_b0z .ows_41186
	set_event EVENT_GOT_DUGTRIO_COIN
	set_active_npc NPC_DR_MASON, DialogDrMasonText
	set_active_npc_direction NORTH
	set_player_direction SOUTH
	script_command_01
	print_npc_text Text0f07
	give_coin COIN_DUGTRIO
	print_npc_text Text0f08
	script_command_02
	set_active_npc_direction SOUTH
.ows_41186
	end_script
	ret

Func_41188:
	ld a, NPC_DR_MASON
	ld [wScriptNPC], a
	ld hl, $9d0
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	check_event EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE
	script_jump_if_b0z .ows_411df
	check_event EVENT_GOT_MACHAMP_COIN
	script_jump_if_b0z .ows_411d9
	check_event EVENT_GOT_MAGNEMITE_COIN
	script_jump_if_b0z .ows_411d3
	check_event EVENT_GOT_GR_COIN
	script_jump_if_b0z .ows_411cd
	get_var VAR_TIMES_MET_RONALD
	compare_loaded_var $02
	script_jump_if_b0nz .ows_411c1
	script_jump_if_b1z .ows_411c7
	print_npc_text Text0f09
	script_jump .ows_411ef
.ows_411c1
	print_npc_text Text0f0a
	script_jump .ows_411ef
.ows_411c7
	print_npc_text Text0f0b
	script_jump .ows_411ef
.ows_411cd
	print_npc_text Text0f0c
	script_jump .ows_411ef
.ows_411d3
	print_npc_text Text0f0d
	script_jump .ows_411ef
.ows_411d9
	print_npc_text Text0f0e
	script_jump .ows_411ef
.ows_411df
	check_event EVENT_92
	script_jump_if_b0z .ows_411ec
	set_event EVENT_92
	print_npc_text Text0f0f
	script_jump .ows_411ef
.ows_411ec
	print_npc_text Text0f10
.ows_411ef
	script_command_02
	end_script
	ret

Func_411f2:
	ld a, NPC_RONALD
	ld [wScriptNPC], a
	ld hl, $a2d
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	get_var VAR_TIMES_MET_RONALD
	compare_loaded_var $09
	script_jump_if_b1z .ows_41217
	set_var VAR_TIMES_MET_RONALD, $09
	print_npc_text Text0f11
	script_jump .ows_4121a
.ows_41217
	print_npc_text Text0f12
.ows_4121a
	script_command_02
	end_script
	ret

Func_4121d:
	ld a, EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE
	farcall GetEventValue
	jr nz, .asm_41230
	ld a, VAR_TIMES_MET_RONALD
	farcall GetVarValue
	or a
	jr z, .asm_41230
	scf
	ret
.asm_41230
	scf
	ccf
	ret

Func_41233:
	ld a, NPC_SAM
	ld [wScriptNPC], a
	ld hl, $9d1
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	check_event EVENT_TALKED_TO_SAM
	script_jump_if_b0nz Script_412f8
	print_npc_text Text0f13
	end_script
	ld a, $01
	ld b, $00
	farcall Func_121e1
	jr c, .asm_41264
	or a
	jr z, .asm_4126b
	dec a
	jr z, .asm_4128d
	dec a
	jr z, .asm_412b2
.asm_41264
	xor a
	start_script
	script_jump .ows_412bd
.asm_4126b
	xor a
	start_script
	print_npc_text Text0f14
	ask_question Text0f15, TRUE
	script_jump_if_b0z .ows_41287
	script_command_02
	set_active_npc_direction EAST
	script_call Script_41499
	set_event EVENT_EF
	start_duel SAMS_PRACTICE_DECK_ID, MUSIC_MATCHSTART_1
	end_script
	ret
.ows_41287
	print_npc_text Text0f16
	script_jump .ows_412bd
.asm_4128d
	xor a
	start_script
	print_npc_text Text0f17
	ask_question Text0f15, TRUE
	script_jump_if_b0z .ows_412ac
	script_command_02
	set_active_npc_direction EAST
	script_call Script_4151b
	script_command_01
	print_npc_text Text0f18
	script_command_02
	start_duel UNUSED_SAMS_PRACTICE_DECK_ID, MUSIC_MATCHSTART_1
	end_script
	ret
.ows_412ac
	print_npc_text Text0f19
	script_jump .ows_412bd
.asm_412b2
	xor a
	start_script
	script_call Script_41408
	print_npc_text Text0f16
.ows_412bd
	script_command_02
	end_script
	ret

Func_412c0:
	xor a
	start_script
	script_command_01
	check_event EVENT_EF
	script_jump_if_b0z .ows_412e4
	check_event EVENT_SET_UNTIL_MAP_RELOAD_2
	script_jump_if_b0nz .ows_412db
	print_npc_text Text0f1a
	give_booster_packs BoosterList_cc9b
	print_npc_text Text0f1b
	script_jump .ows_412e1
.ows_412db
	print_npc_text Text0f1c
	script_jump .ows_412e1
.ows_412e1
	script_command_02
	end_script
	ret
.ows_412e4
	reset_event EVENT_EF
	print_npc_text Text0f1d
	script_command_02
	move_npc NPC_DR_MASON, NPCMovement_412f1
	wait_for_player_animation
	end_script
	ret
NPCMovement_412f1:
	db NORTH, MOVE_1
	db EAST, MOVE_3
	db SOUTH, MOVE_0
	db $ff

Script_412f8:
	set_event EVENT_TALKED_TO_SAM
	print_npc_text Text0f1e
	ask_question Text0f1f, TRUE
	script_jump_if_b0nz .ows_4130a
	print_npc_text Text0f20
	script_jump .ows_4133b

.ows_4130a
	print_npc_text Text0f21
	script_command_02
	set_active_npc_direction EAST
	script_call Script_41499
	script_command_01
	set_active_npc NPC_DR_MASON, DialogDrMasonText
	print_npc_text Text0f22
	set_active_npc NPC_SAM, DialogSamText
	print_npc_text Text0f23
.ows_41323
	script_call Script_41408
	npc_ask_question Text0f24, TRUE
	script_jump_if_b0z .ows_41323
	set_active_npc NPC_DR_MASON, DialogDrMasonText
	print_npc_text Text0f25
	script_command_02
	start_duel SAMS_PRACTICE_DECK_ID, MUSIC_MATCHSTART_1
	end_script
	ret

.ows_4133b
	script_command_02
	end_script
	ret

Func_4133e:
	xor a
	start_script
	script_command_01
	print_npc_text Text0f26
	ask_question Text0f27, TRUE
	script_jump_if_b0z .ows_41356
	print_npc_text Text0f28
	script_command_02
	start_duel SAMS_PRACTICE_DECK_ID, MUSIC_MATCHSTART_1
	end_script
	ret
.ows_41356
	print_npc_text Text0f29
	script_command_02
	move_active_npc NPCMovement_41369
	wait_for_player_animation
	script_command_01
	set_active_npc NPC_SAM, DialogSamText
	print_npc_text Text0f2a
	script_command_02
	end_script
	ret
NPCMovement_41369:
	db NORTH, MOVE_1
	db EAST, MOVE_3
	db SOUTH, MOVE_0
	db $ff

Func_41370:
	ld a, NPC_LAB_TECH_PC_GUIDE
	ld [wScriptNPC], a
	ld hl, $a4a
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	check_event EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE
	script_jump_if_b0z .ows_41390
	print_npc_text Text0f2b
	script_jump .ows_41393
.ows_41390
	print_npc_text Text0f2c
.ows_41393
	script_command_02
	end_script
	ret

Func_41396:
	ld a, NPC_LAB_TECH_CLUB_GUIDE
	ld [wScriptNPC], a
	ld hl, $a4a
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	check_event EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE
	script_jump_if_b0z .ows_413b6
	print_npc_text Text0f2d
	script_jump .ows_413b9
.ows_413b6
	print_npc_text Text0f2e
.ows_413b9
	script_command_02
	end_script
	ret

Func_413bc:
	ld a, NPC_LAB_TECH_BOOSTER_GUIDE
	ld [wScriptNPC], a
	ld hl, $a4a
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	check_event EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE
	script_jump_if_b0z .ows_413dc
	print_npc_text Text0f2f
	script_jump .ows_413df
.ows_413dc
	print_npc_text Text0f30
.ows_413df
	script_command_02
	end_script
	ret

Func_413e2:
	ld a, NPC_LAB_TECH_ROOM_GUIDE
	ld [wScriptNPC], a
	ld hl, $a4a
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	check_event EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE
	script_jump_if_b0z .ows_41402
	print_npc_text Text0f31
	script_jump .ows_41405
.ows_41402
	print_npc_text Text0f32
.ows_41405
	script_command_02
	end_script
	ret
Script_41408:
	script_command_02
	quit_script

Func_4140a:
	ld b, $00
.asm_4140c
	xor a
	farcall Func_121e1
	jr c, .asm_41428
	or a
	jr z, .asm_4142f
	dec a
	jr z, .asm_4143e
	dec a
	jr z, .asm_4144d
	dec a
	jr z, .asm_4145c
	dec a
	jr z, .asm_4146b
	dec a
	jr z, .asm_4147a
	dec a
	jr z, .asm_41489
.asm_41428
	ld a, $01
	start_script
	script_command_01
	script_ret
.asm_4142f
	ld a, $01
	start_script
	script_command_01
	print_npc_text Text0f33
	script_command_02
	quit_script
	ld b, $00
	jr .asm_4140c
.asm_4143e
	ld a, $01
	start_script
	script_command_01
	print_npc_text Text0f34
	script_command_02
	quit_script
	ld b, $01
	jr .asm_4140c
.asm_4144d
	ld a, $01
	start_script
	script_command_01
	print_npc_text Text0f35
	script_command_02
	quit_script
	ld b, $02
	jr .asm_4140c
.asm_4145c
	ld a, $01
	start_script
	script_command_01
	print_npc_text Text0f36
	script_command_02
	quit_script
	ld b, $03
	jr .asm_4140c
.asm_4146b
	ld a, $01
	start_script
	script_command_01
	print_npc_text Text0f37
	script_command_02
	quit_script
	ld b, $04
	jr .asm_4140c
.asm_4147a
	ld a, $01
	start_script
	script_command_01
	print_npc_text Text0f38
	script_command_02
	quit_script
	ld b, $05
	jr .asm_4140c
.asm_41489
	ld a, $01
	start_script
	script_command_01
	print_npc_text Text0f39
	script_command_02
	quit_script
	ld b, $06
	jp .asm_4140c

Script_41499:
	get_player_direction
	compare_loaded_var $00
	script_jump_if_b0nz .ows_414b8
	compare_loaded_var $01
	script_jump_if_b0nz .ows_414ac
	check_event EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE
	script_jump_if_b0z .ows_414c4
	script_jump .ows_414d9

.ows_414ac
	check_event EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE
	script_jump_if_b0z .ows_414cb
	move_player NPCMovement_414f0, TRUE
	script_jump .ows_414d9

.ows_414b8
	check_event EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE
	script_jump_if_b0z .ows_414d2
	move_player NPCMovement_414f5, TRUE
	script_jump .ows_414de

.ows_414c4
	move_player NPCMovement_414fe, TRUE
	script_jump .ows_414de

.ows_414cb
	move_player NPCMovement_41509, TRUE
	script_jump .ows_414de

.ows_414d2
	move_player NPCMovement_41512, TRUE
	script_jump .ows_414de

.ows_414d9
	wait_for_player_animation
	move_player NPCMovement_414e9, TRUE
.ows_414de
	move_npc NPC_DR_MASON, NPCMovement_414e4
	wait_for_player_animation
	script_ret

NPCMovement_414e4:
	db WEST, MOVE_3
	db SOUTH, MOVE_1
	db $ff

NPCMovement_414e9:
	db EAST, MOVE_3
	db SOUTH, MOVE_1
	db WEST, MOVE_0
	db $ff

NPCMovement_414f0:
	db NORTH, MOVE_1
	db EAST, MOVE_1
	db $ff

NPCMovement_414f5:
	db SOUTH, MOVE_1
	db EAST, MOVE_3
	db NORTH, MOVE_2
	db WEST, MOVE_0
	db $ff

NPCMovement_414fe:
	db WEST, MOVE_1
	db SOUTH, MOVE_3
	db EAST, MOVE_4
	db NORTH, MOVE_2
	db WEST, MOVE_0
	db $ff

NPCMovement_41509:
	db SOUTH, MOVE_2
	db EAST, MOVE_4
	db NORTH, MOVE_2
	db WEST, MOVE_0
	db $ff

NPCMovement_41512:
	db SOUTH, MOVE_1
	db EAST, MOVE_3
	db NORTH, MOVE_2
	db WEST, MOVE_0
	db $ff

Script_4151b:
	get_player_direction
	compare_loaded_var $00
	script_jump_if_b0nz .ows_4153e
	compare_loaded_var $01
	script_jump_if_b0nz .ows_41532
	check_event EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE
	script_jump_if_b0z .ows_4154a
	move_player NPCMovement_4155e, TRUE
	script_jump .ows_4155c

.ows_41532
	check_event EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE
	script_jump_if_b0z .ows_41551
	move_player NPCMovement_41565, TRUE
	script_jump .ows_4155c

.ows_4153e
	check_event EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE
	script_jump_if_b0z .ows_41558
	move_player NPCMovement_4156e, TRUE
	script_jump .ows_4155c

.ows_4154a
	move_player NPCMovement_41577, TRUE
	script_jump .ows_4155c

.ows_41551
	move_player NPCMovement_41580, TRUE
	script_jump .ows_4155c

.ows_41558
	move_player NPCMovement_41589, TRUE
.ows_4155c
	wait_for_player_animation
	script_ret

NPCMovement_4155e:
	db EAST, MOVE_3
	db SOUTH, MOVE_1
	db WEST, MOVE_0
	db $ff

NPCMovement_41565:
	db NORTH, MOVE_1
	db EAST, MOVE_4
	db SOUTH, MOVE_1
	db WEST, MOVE_0
	db $ff

NPCMovement_4156e:
	db SOUTH, MOVE_1
	db EAST, MOVE_3
	db NORTH, MOVE_2
	db WEST, MOVE_0
	db $ff

NPCMovement_41577:
	db NORTH, MOVE_1
	db EAST, MOVE_3
	db SOUTH, MOVE_2
	db WEST, MOVE_0
	db $ff

NPCMovement_41580:
	db SOUTH, MOVE_2
	db EAST, MOVE_4
	db NORTH, MOVE_2
	db WEST, MOVE_0
	db $ff

NPCMovement_41589:
	db SOUTH, MOVE_1
	db EAST, MOVE_3
	db NORTH, MOVE_2
	db WEST, MOVE_0
	db $ff

TcgChallengeHall_MapHeader:
	db MAP_GFX_TCG_CHALLENGE_HALL
	dba TcgChallengeHall_MapScripts
	db MUSIC_OVERWORLD

TcgChallengeHall_StepEvents:
	map_exit 7, 15, MAP_TCG_CHALLENGE_HALL_ENTRANCE, 4, 1, SOUTH
	map_exit 8, 15, MAP_TCG_CHALLENGE_HALL_ENTRANCE, 5, 1, SOUTH
	db $ff

TcgChallengeHall_NPCs:
	npc NPC_CUP_HOST, 7, 2, SOUTH, Func_41768
	npc NPC_TCG_CUP_CLERK_RIGHT, 10, 9, SOUTH, Func_41768
	npc NPC_TCG_CUP_CLERK_LEFT, 5, 9, SOUTH, Func_41768
	npc NPC_TCG_CHALLENGE_HALL_MAN, 7, 10, SOUTH, Func_41751
	db $ff

TcgChallengeHall_NPCInteractions:
	npc_script NPC_TCG_CUP_CLERK_LEFT, Func_41662
	npc_script NPC_TCG_CUP_CLERK_RIGHT, Func_41705
	npc_script NPC_TCG_CHALLENGE_HALL_MAN, Func_41720
	db $ff

TcgChallengeHall_MapScripts:
	dbw $06, Func_415f3
	dbw $08, Func_41622
	dbw $09, Func_4162a
	dbw $07, Func_415fa
	dbw $01, Func_415e6
	dbw $02, Func_41603
	dbw $0b, Func_4163b
	db $ff

Func_415e6:
	call Func_41bd2
	jr c, .asm_415f0
	ld a, MUSIC_CHALLENGEHALL
	ld [wNextMusic], a
.asm_415f0
	scf
	ccf
	ret

Func_415f3:
	ld hl, TcgChallengeHall_StepEvents
	call Func_324d
	ret

Func_415fa:
	ld hl, TcgChallengeHall_NPCs
	call Func_3205
	scf
	ccf
	ret

Func_41603:
	call Func_41bd2
	jr c, .asm_41620
	xor a
	farcall Func_45301
	ld a, VAR_2D
	farcall GetVarValue
	farcall Func_453c3
	ld de, $904
	ld b, $03
	farcall LoadOWObjectInMap
.asm_41620
	scf
	ret

Func_41622:
	ld hl, TcgChallengeHall_NPCInteractions
	call Func_328c
	scf
	ret

Func_4162a:
	ld a, VAR_2C
	farcall GetVarValue
	cp $02
	jp c, Func_417df
	jp z, Func_418ed
	jp Func_41a4d

Func_4163b:
	ld a, EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE_DUMMY
	farcall GetEventValue
	jr nz, .asm_41645
	scf
	ret
.asm_41645
	farcall Func_c18f
	call Func_4164f
	scf
	ccf
	ret
Func_4164f:
	xor a
	start_script
	reset_event EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE_DUMMY
	set_active_npc_position 9, 2
	get_var VAR_2C
	compare_loaded_var $02
	script_jump_if_b0nz Script_418a6
	script_jump Script_419ab

Func_41662:
	ld a, NPC_TCG_CUP_CLERK_LEFT
	ld [wScriptNPC], a
	ld hl, $a5a
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	get_var VAR_2B
	compare_loaded_var $01
	script_jump_if_b0nz .ows_416ac
	script_jump_if_b1z .ows_416b2
	get_var VAR_28
	compare_loaded_var $06
	script_jump_if_b0nz .ows_41699
	compare_loaded_var $03
	script_jump_if_b0nz .ows_41693
	print_npc_text Text094e
	script_jump .ows_416b8
.ows_41693
	print_npc_text Text094f
	script_jump .ows_416b8
.ows_41699
	quit_script
	farcall Func_f027
	call LoadTxRam2
	ld a, $01
	start_script
	print_npc_text Text0950
	script_jump .ows_416b8
.ows_416ac
	print_npc_text Text0951
	script_jump .ows_416da
.ows_416b2
	print_npc_text Text0952
	script_jump .ows_416da
.ows_416b8
	ask_question Text0953, TRUE
	script_jump_if_b0z .ows_416d7
	print_npc_text Text0954
	script_command_02
	get_player_direction
	compare_loaded_var $00
	script_jump_if_b0nz .ows_416d0
	move_player NPCMovement_416f8, TRUE
	script_jump .ows_416dd
.ows_416d0
	move_player NPCMovement_416fd, TRUE
	script_jump .ows_416dd
.ows_416d7
	print_npc_text Text0955
.ows_416da
	script_command_02
	end_script
	ret
.ows_416dd
	move_active_npc NPCMovement_416ec
	wait_for_player_animation
	move_player NPCMovement_41700, TRUE
	move_active_npc NPCMovement_416f3
	wait_for_player_animation
	script_jump Script_4177f
NPCMovement_416ec:
	db NORTH, MOVE_2
	db EAST, MOVE_1
	db WEST, MOVE_0
	db $ff
NPCMovement_416f3:
	db WEST, MOVE_1
	db SOUTH, MOVE_2
	db $ff
NPCMovement_416f8:
	db EAST, MOVE_1
	db NORTH, MOVE_3
	db $ff
NPCMovement_416fd:
	db NORTH, MOVE_4
	db $ff
NPCMovement_41700:
	db NORTH, MOVE_2
	db EAST, MOVE_1
	db $ff

Func_41705:
	ld a, NPC_TCG_CUP_CLERK_RIGHT
	ld [wScriptNPC], a
	ld hl, $a5a
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	print_npc_text Text0956
	script_command_02
	end_script
	ret

Func_41720:
	ld a, NPC_TCG_CHALLENGE_HALL_MAN
	ld [wScriptNPC], a
	ld hl, $a3a
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	check_event EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE
	script_jump_if_b0z .ows_4174b
	check_event EVENT_GOT_GR_COIN
	script_jump_if_b0z .ows_41745
	print_npc_text Text0957
	script_jump .ows_4174e
.ows_41745
	print_npc_text Text0958
	script_jump .ows_4174e
.ows_4174b
	print_npc_text Text0959
.ows_4174e
	script_command_02
	end_script
	ret

Func_41751:
	ld a, VAR_28
	farcall GetVarValue
	cp $01
	jr z, .asm_41766
	cp $03
	jr z, .asm_41766
	cp $06
	jr z, .asm_41766
	scf
	ccf
	ret
.asm_41766
	scf
	ret

Func_41768:
	ld a, VAR_28
	farcall GetVarValue
	cp $01
	jr z, .asm_4177c
	cp $03
	jr z, .asm_4177c
	cp $06
	jr z, .asm_4177c
	scf
	ret
.asm_4177c
	scf
	ccf
	ret

Script_4177f:
	set_var VAR_2C, $00
	script_jump .ows_41785
.ows_41785
	set_var VAR_2C, $01
	quit_script
	farcall Func_453ce
	ld a, $01
	start_script
	set_active_npc NPC_CUP_HOST, DialogCupHostText
	script_command_01
	get_var VAR_28
	compare_loaded_var $03
	script_jump_if_b0nz .ows_417b1
	script_jump_if_b1z .ows_417c1
	print_npc_text Text095a
	script_command_02
	animate_active_npc_movement $03, $01
	set_active_npc_direction SOUTH
	script_command_01
	print_npc_text Text095b
	script_jump .ows_417ce
.ows_417b1
	print_npc_text Text095c
	script_command_02
	animate_active_npc_movement $03, $01
	set_active_npc_direction SOUTH
	script_command_01
	print_npc_text Text095d
	script_jump .ows_417ce
.ows_417c1
	print_npc_text Text095e
	script_command_02
	animate_active_npc_movement $03, $01
	set_active_npc_direction SOUTH
	script_command_01
	print_npc_text Text095f
.ows_417ce
	script_command_02
	animate_active_npc_movement $01, $01
	set_active_npc_direction SOUTH
	script_command_01
	print_npc_text Text0960
	script_command_02
	end_script
	farcall Func_453f9
	ret

Func_417df:
	xor a
	start_script
	script_command_01
	quit_script
	farcall Func_453ce
	ld a, $01
	start_script
	check_event EVENT_SET_UNTIL_MAP_RELOAD_2
	script_jump_if_b0nz .ows_41824
	get_var VAR_28
	compare_loaded_var $03
	script_jump_if_b0nz .ows_4180a
	script_jump_if_b1z .ows_41817
	print_npc_text Text0961
	script_call .ows_4186a
	print_npc_text Text0962
	script_jump .ows_41840
.ows_4180a
	print_npc_text Text0961
	script_call .ows_4186a
	print_npc_text Text0963
	script_jump .ows_41840
.ows_41817
	print_npc_text Text0964
	script_call .ows_4186a
	print_npc_text Text0965
	script_jump .ows_41840
.ows_41824
	get_var VAR_28
	compare_loaded_var $03
	script_jump_if_b0nz .ows_41834
	script_jump_if_b1z .ows_4183a
	print_npc_text Text0966
	script_jump Script_41b98
.ows_41834
	print_npc_text Text0967
	script_jump Script_41b98
.ows_4183a
	print_npc_text Text0968
	script_jump Script_41b98
.ows_41840
	script_command_02
	quit_script
	ld a, VAR_2E
	farcall GetVarValue
	farcall Func_453c3
	ld b, $00
	ld de, $a09
	farcall LoadOWObjectInMap
	ld b, $10
	ld hl, NPCMovement_418a1
	farcall MoveNPC
	call Func_3340
	ld a, $01
	start_script
	script_command_01
	script_jump Script_418a6
.ows_4186a
	script_command_02
	animate_active_npc_movement $01, $01
	animate_active_npc_movement $01, $01
	set_active_npc_direction SOUTH
	script_command_01
	print_npc_text Text0969
	script_command_02
	quit_script
	ld a, VAR_2D
	farcall GetVarValue
	farcall Func_453c3
	push af
	ld b, $10
	ld hl, NPCMovement_4189c
	farcall MoveNPC
	call Func_3340
	pop af
	farcall ClearOWObject
	ld a, $01
	start_script
	script_command_01
	script_ret

NPCMovement_4189c:
	db EAST, MOVE_1
	db SOUTH, MOVE_5
	db $ff

NPCMovement_418a1:
	db NORTH, MOVE_5
	db WEST, MOVE_1
	db $ff

Script_418a6:
	set_var VAR_2C, $02
	quit_script
	farcall Func_453ce
	ld a, $01
	start_script
	script_command_01
	print_npc_text Text096a
	script_command_02
	move_active_npc NPCMovement_418e8
	wait_for_player_animation
	script_command_01
	get_var VAR_28
	compare_loaded_var $06
	script_jump_if_b0z .ows_418c7
	print_npc_text Text096b
.ows_418c7
	print_npc_text Text096c
	ask_question DuelPrepPromptText, FALSE
	script_jump_if_b0z .ows_418de
	print_npc_text Text096d
	script_command_02
	set_event EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE_DUMMY
	script_command_58
	reset_event EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE_DUMMY
	script_command_01
	script_jump .ows_418c7
.ows_418de
	print_npc_text Text096e
	script_command_02
	end_script
	farcall Func_453f9
	ret
NPCMovement_418e8:
	db WEST, MOVE_2
	db SOUTH, MOVE_0
	db $ff

Func_418ed:
	xor a
	start_script
	script_command_01
	quit_script
	farcall Func_453ce
	ld a, $01
	start_script
	check_event EVENT_SET_UNTIL_MAP_RELOAD_2
	script_jump_if_b0nz .ows_41932
	get_var VAR_28
	compare_loaded_var $03
	script_jump_if_b0nz .ows_41918
	script_jump_if_b1z .ows_41925
	print_npc_text Text096f
	script_call .ows_4196f
	print_npc_text Text0970
	script_jump .ows_41945
.ows_41918
	print_npc_text Text096f
	script_call .ows_4196f
	print_npc_text Text0971
	script_jump .ows_41945
.ows_41925
	print_npc_text Text096f
	script_call .ows_4196f
	print_npc_text Text0972
	script_jump .ows_41945
.ows_41932
	get_var VAR_28
	compare_loaded_var $06
	script_jump_if_b0nz .ows_4193f
	print_npc_text Text0973
	script_jump Script_41b98
.ows_4193f
	print_npc_text Text0974
	script_jump Script_41b98
.ows_41945
	script_command_02
	quit_script
	ld a, VAR_2F
	farcall GetVarValue
	farcall Func_453c3
	ld b, $00
	ld de, $a09
	farcall LoadOWObjectInMap
	ld b, $10
	ld hl, NPCMovement_419a6
	farcall MoveNPC
	call Func_3340
	ld a, $01
	start_script
	script_command_01
	script_jump Script_419ab
.ows_4196f
	script_command_02
	animate_active_npc_movement $01, $01
	animate_active_npc_movement $01, $01
	set_active_npc_direction SOUTH
	script_command_01
	print_npc_text Text0969
	script_command_02
	quit_script
	ld a, VAR_2E
	farcall GetVarValue
	farcall Func_453c3
	push af
	ld b, $10
	ld hl, NPCMovement_419a1
	farcall MoveNPC
	call Func_3340
	pop af
	farcall ClearOWObject
	ld a, $01
	start_script
	script_command_01
	script_ret

NPCMovement_419a1:
	db EAST, MOVE_1
	db SOUTH, MOVE_5
	db $ff

NPCMovement_419a6:
	db NORTH, MOVE_5
	db WEST, MOVE_1
	db $ff

Script_419ab:
	set_var VAR_2C, $03
	quit_script
	farcall Func_453ce
	ld a, $01
	start_script
	script_command_01
	get_var VAR_28
	compare_loaded_var $03
	script_jump_if_b0nz .ows_419c9
	script_jump_if_b1z .ows_419cf
	print_npc_text Text0975
	script_jump .ows_41a17
.ows_419c9
	print_npc_text Text0976
	script_jump .ows_41a17
.ows_419cf
	quit_script
	ld a, VAR_2F
	farcall GetVarValue
	farcall Func_453c3
	cp $03
	jr z, .asm_41a04
	cp $2e
	jr z, .asm_419f9
	cp $2f
	jr z, .asm_419f9
	cp $30
	jr z, .asm_419f9
	cp $31
	jr z, .asm_419f9
	ld a, $01
	start_script
	print_npc_text Text0977
	script_jump .ows_41a17
.asm_419f9
	ld a, $01
	start_script
	print_npc_text Text0978
	script_jump .ows_41a17
.asm_41a04
	ld a, $01
	start_script
	print_npc_text Text0979
	set_active_npc NPC_RONALD, DialogRonaldText
	print_npc_text Text097a
	set_active_npc NPC_CUP_HOST, DialogCupHostText
.ows_41a17
	script_command_02
	move_active_npc NPCMovement_41a48
	wait_for_player_animation
	script_command_01
	get_var VAR_28
	compare_loaded_var $03
	script_jump_if_b0z .ows_41a27
	print_npc_text Text097b
.ows_41a27
	print_npc_text Text096c
	ask_question DuelPrepPromptText, FALSE
	script_jump_if_b0z .ows_41a3e
	print_npc_text Text096d
	script_command_02
	set_event EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE_DUMMY
	script_command_58
	reset_event EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE_DUMMY
	script_command_01
	script_jump .ows_41a27
.ows_41a3e
	print_npc_text Text097c
	script_command_02
	end_script
	farcall Func_453f9
	ret
NPCMovement_41a48:
	db WEST, MOVE_2
	db SOUTH, MOVE_0
	db $ff

Func_41a4d:
	xor a
	start_script
	script_command_01
	quit_script
	farcall Func_453ce
	ld a, $01
	start_script
	check_event EVENT_SET_UNTIL_MAP_RELOAD_2
	script_jump_if_b0nz .ows_41a92
	get_var VAR_28
	compare_loaded_var $03
	script_jump_if_b0nz .ows_41a78
	script_jump_if_b1z .ows_41a85
	print_npc_text Text097d
	script_call .ows_41aae
	print_npc_text Text097e
	script_jump .ows_41aea
.ows_41a78
	print_npc_text Text097d
	script_call .ows_41aae
	print_npc_text Text097e
	script_jump .ows_41aea
.ows_41a85
	print_npc_text Text097d
	script_call .ows_41aae
	print_npc_text Text097f
	script_jump .ows_41aea
.ows_41a92
	get_var VAR_28
	compare_loaded_var $03
	script_jump_if_b0nz .ows_41aa2
	script_jump_if_b1z .ows_41aa8
	print_npc_text Text0980
	script_jump Script_41b98
.ows_41aa2
	print_npc_text Text0981
	script_jump Script_41b98
.ows_41aa8
	print_npc_text Text0982
	script_jump Script_41b98
.ows_41aae
	script_command_02
	animate_active_npc_movement $01, $01
	animate_active_npc_movement $01, $01
	set_active_npc_direction SOUTH
	script_command_01
	print_npc_text Text0969
	script_command_02
	quit_script
	ld a, VAR_2F
	farcall GetVarValue
	farcall Func_453c3
	push af
	ld b, $10
	ld hl, .NPCMovement_41ae0
	farcall MoveNPC
	call Func_3340
	pop af
	farcall ClearOWObject
	ld a, $01
	start_script
	script_command_01
	script_ret

.NPCMovement_41ae0:
	db EAST, MOVE_1
	db SOUTH, MOVE_5
	db $ff

.NPCMovement_41ae5:
	db NORTH, MOVE_5
	db WEST, MOVE_1
	db $ff

.ows_41aea
	set_var VAR_2B, $01
	get_var VAR_2A
	compare_loaded_var $0b
	script_jump_if_b1z .ows_41af6
	inc_var VAR_2A
.ows_41af6
	script_command_02
	move_active_npc .NPCMovement_41b86
	wait_for_player_animation
	set_player_direction NORTH
	script_command_01
	get_var VAR_28
	compare_loaded_var $03
	script_jump_if_b0nz .ows_41b14
	script_jump_if_b1z .ows_41b20
	print_npc_text Text0983
	give_card MEWTWO_LV30
	show_card_received_screen MEWTWO_LV30
	script_jump .ows_41b57
.ows_41b14
	print_npc_text Text0984
	give_card PIKACHU_LV13
	show_card_received_screen PIKACHU_LV13
	script_jump .ows_41b57
.ows_41b20
	quit_script
	ld a, VAR_29
	farcall GetVarValue
	farcall Func_f027
	call LoadTxRam2
	ld a, $01
	start_script
	print_npc_text Text0985
	quit_script
	ld a, VAR_29
	farcall GetVarValue
	farcall Func_f010
	ld e, c
	ld d, b
	farcall Func_1022a
	farcall Func_c646
	farcall Func_10252
	call WaitPalFading
	ld a, $01
	start_script
.ows_41b57
	get_var VAR_2A
	compare_loaded_var $0a
	script_jump_if_b0z .ows_41b6b
	print_npc_text Text0986
	set_event EVENT_GOT_PONYTA_COIN
	give_coin COIN_PONYTA
	print_npc_text Text0987
	script_jump .ows_41b6e
.ows_41b6b
	print_npc_text Text0988
.ows_41b6e
	script_command_02
	move_player .NPCMovement_41b8b, TRUE
	wait_for_player_animation
	move_player .NPCMovement_41b90, TRUE
	move_npc NPC_TCG_CUP_CLERK_LEFT, .NPCMovement_41b93
	wait_for_player_animation
	animate_npc_movement NPC_TCG_CUP_CLERK_LEFT, $01, $01
	set_npc_direction NPC_TCG_CUP_CLERK_LEFT, SOUTH
	end_script
	ret
.NPCMovement_41b86:
	db WEST, MOVE_3
	db SOUTH, MOVE_1
	db $ff
.NPCMovement_41b8b:
	db WEST, MOVE_1
	db SOUTH, MOVE_3
	db $ff
.NPCMovement_41b90:
	db SOUTH, MOVE_3
	db $ff
.NPCMovement_41b93:
	db WEST, MOVE_1
	db EAST, MOVE_0
	db $ff
Script_41b98:
	set_var VAR_2B, $02
	script_command_02
	animate_active_npc_movement $03, $01
	set_active_npc_direction SOUTH
	script_command_01
	print_npc_text Text0989
	script_command_02
	move_active_npc NPCMovement_41bc0
	move_player NPCMovement_41bc5, TRUE
	wait_for_player_animation
	move_player NPCMovement_41bca, TRUE
	move_npc NPC_TCG_CUP_CLERK_LEFT, NPCMovement_41bcd
	wait_for_player_animation
	animate_npc_movement NPC_TCG_CUP_CLERK_LEFT, $01, $01
	set_npc_direction NPC_TCG_CUP_CLERK_LEFT, SOUTH
	end_script
	ret
NPCMovement_41bc0:
	db EAST, MOVE_1
	db SOUTH, MOVE_0
	db $ff
NPCMovement_41bc5:
	db WEST, MOVE_1
	db SOUTH, MOVE_3
	db $ff
NPCMovement_41bca:
	db SOUTH, MOVE_3
	db $ff
NPCMovement_41bcd:
	db WEST, MOVE_1
	db EAST, MOVE_0
	db $ff

Func_41bd2:
	ld a, VAR_28
	farcall GetVarValue
	cp $01
	jr z, .asm_41be6
	cp $03
	jr z, .asm_41be6
	cp $06
	jr z, .asm_41be6
	scf
	ret
.asm_41be6
	scf
	ccf
	ret

GrAirport_MapHeader:
	db MAP_GFX_GR_AIRPORT
	dba GrAirport_MapScripts
	db MUSIC_GROVERWORLD

GrAirport_StepEvents:
	map_exit 13, 9, MAP_GR_AIRPORT_ENTRANCE, 1, 6, EAST
	map_exit 13, 10, MAP_GR_AIRPORT_ENTRANCE, 1, 7, EAST
	_ow_coordinate_function 5, 8, 0, 0, 0, 3, Func_41dac
	ow_script 4, 9, Func_41dac
	ow_script 3, 9, Func_41dac
	_ow_coordinate_function 2, 8, 0, 0, 0, 1, Func_41dac
	db $ff

GrAirport_NPCs:
	npc NPC_GR_5, 4, 8, SOUTH, $0
	db $ff

GrAirport_NPCInteractions:
	npc_script NPC_GR_5, Func_41cd3
	db $ff

GrAirport_MapScripts:
	dbw $00, Func_41c44
	dbw $06, Func_41c50
	dbw $08, Func_41ccb
	dbw $07, Func_41c57
	dbw $02, Func_41c60
	dbw $0f, Func_41ca1
	db $ff

Func_41c44:
	call DoFrame
	call Func_41db4
	call Func_32d8
	scf
	ccf
	ret

Func_41c50:
	ld hl, GrAirport_StepEvents
	call Func_324d
	ret

Func_41c57:
	ld hl, GrAirport_NPCs
	call Func_3205
	scf
	ccf
	ret

Func_41c60:
	farcall ClearwD986
	ld a, [wd584]
	cp $01
	jr nz, .asm_41c9f
	ld a, $0a
	ld [wd582], a
	ld a, $10
	ld [wd592], a
	ld hl, $5d64
	ld a, l
	ld [wd593], a
	ld a, h
	ld [$d594], a
	ld a, $32
	ld de, $505
	farcall SetOWObjectTilePosition
	ld b, $03
	farcall SetOWObjectDirection
	ld a, [wPlayerOWObject]
	ld de, $505
	farcall SetOWObjectTilePosition
	ld b, $03
	farcall SetOWObjectDirection
.asm_41c9f
	scf
	ret

Func_41ca1:
	ld a, [wd585]
	cp $01
	jr z, .asm_41caa
	scf
	ret
.asm_41caa
	ld a, $0a
	ld c, $07
	farcall InitMusicFadeOut
	farcall MusicFadeOut.loop
	xor a
	call PlaySong
	ld a, $07
	call SetVolume
	ld a, SFX_89
	call PlaySFX
	farcall WaitForSFXToFinish.loop_wait
	scf
	ccf
	ret

Func_41ccb:
	ld hl, GrAirport_NPCInteractions
	call Func_328c
	scf
	ret

Func_41cd3:
	ld a, NPC_GR_5
	ld [wScriptNPC], a
	ld hl, $a2c
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	npc_ask_question Text0829, TRUE
	script_jump_if_b0nz .ows_41cf5
	print_npc_text Text082a
	script_command_02
	end_script
	ret
.ows_41cf5
	print_npc_text Text082b
	script_command_02
	get_player_direction
	compare_loaded_var $03
	script_jump_if_b0nz .ows_41d0d
	compare_loaded_var $01
	script_jump_if_b0nz .ows_41d2b
	get_player_x_position
	compare_loaded_var $04
	script_jump_if_b0nz .ows_41d17
	script_jump .ows_41d21
.ows_41d0d
	move_active_npc NPCMovement_41d42
	move_player NPCMovement_41d4c, TRUE
	script_jump .ows_41d32
.ows_41d17
	move_active_npc NPCMovement_41d42
	move_player NPCMovement_41d53, TRUE
	script_jump .ows_41d32
.ows_41d21
	move_active_npc NPCMovement_41d47
	move_player NPCMovement_41d58, TRUE
	script_jump .ows_41d32
.ows_41d2b
	move_active_npc NPCMovement_41d47
	move_player NPCMovement_41d5d, TRUE
.ows_41d32
	wait_for_player_animation
	do_frames 60
	end_script
	ld a, $01
	ld de, $0
	ld b, $00
	farcall Func_d3c4
	ret

NPCMovement_41d42:
	db NORTH, MOVE_3
	db EAST, MOVE_2
	db $ff

NPCMovement_41d47:
	db NORTH, MOVE_3
	db EAST, MOVE_3
	db $ff

NPCMovement_41d4c:
	db WEST, MOVE_1
	db NORTH, MOVE_3
	db EAST, MOVE_1
	db $ff

NPCMovement_41d53:
	db NORTH, MOVE_4
	db EAST, MOVE_1
	db $ff

NPCMovement_41d58:
	db NORTH, MOVE_4
	db EAST, MOVE_2
	db $ff

NPCMovement_41d5d:
	db EAST, MOVE_1
	db NORTH, MOVE_3
	db EAST, MOVE_2
	db $ff

Func_41d64:
	xor a
	start_script
	do_frames 60
	move_player NPCMovement_41da5, TRUE
	wait_for_player_animation
	move_npc NPC_GR_5, NPCMovement_41da0
	wait_for_player_animation
	check_event EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE
	script_jump_if_b0z .ows_41d94
	check_event EVENT_SHORT_GR_ISLAND_FLYOVER_SEQUENCE
	script_jump_if_b0z .ows_41d88
	set_event EVENT_SHORT_GR_ISLAND_FLYOVER_SEQUENCE
	script_command_01
	print_npc_text Text082c
	script_command_02
	script_jump .ows_41d99
.ows_41d88
	set_active_npc NPC_GR_5, DialogGR5Text
	script_command_01
	print_npc_text Text082d
	script_command_02
	script_jump .ows_41d99
.ows_41d94
	script_command_64 $0e
	script_jump .ows_41d88
.ows_41d99
	end_script
	ld a, $00
	ld [wd582], a
	ret
NPCMovement_41da0:
	db WEST, MOVE_1
	db SOUTH, MOVE_3
	db $ff
NPCMovement_41da5:
	db WEST, MOVE_1
	db SOUTH, MOVE_4
	db NORTH, MOVE_0
	db $ff

Func_41dac:
	call Func_41db4
	farcall Func_c199
	ret

Func_41db4:
	ld a, [wPlayerOWObject]
	farcall GetOWObjectTilePosition
	ld a, d
	cp $05
	jr c, .asm_41dc5
	jr nz, .asm_41dc5
	ld a, e
	cp $08
.asm_41dc5
	jr z, .asm_41ded
	ld a, d
	cp $04
	jr c, .asm_41dd1
	jr nz, .asm_41dd1
	ld a, e
	cp $09
.asm_41dd1
	jr z, .asm_41e09
	ld a, d
	cp $03
	jr c, .asm_41ddd
	jr nz, .asm_41ddd
	ld a, e
	cp $09
.asm_41ddd
	jr z, .asm_41e25
	ld a, d
	cp $02
	jr c, .asm_41de9
	jr nz, .asm_41de9
	ld a, e
	cp $08
.asm_41de9
	jr z, .asm_41e41
	jr .asm_41e5b
.asm_41ded
	ldh a, [hKeysHeld]
	bit 5, a
	jr z, .asm_41e5b
	ld a, [wPlayerOWObject]
	ld b, $03
	farcall SetOWObjectDirection
	ld a, $32
	ld b, $01
	farcall SetOWObjectDirection
	call Func_41e75
	jr .asm_41e5b
.asm_41e09
	ldh a, [hKeysHeld]
	bit 6, a
	jr z, .asm_41e5b
	ld a, [wPlayerOWObject]
	ld b, $00
	farcall SetOWObjectDirection
	ld a, $32
	ld b, $02
	farcall SetOWObjectDirection
	call Func_41e75
	jr .asm_41e5b
.asm_41e25
	ldh a, [hKeysHeld]
	bit 6, a
	jr z, .asm_41e5b
	ld a, [wPlayerOWObject]
	ld b, $00
	farcall SetOWObjectDirection
	ld a, $32
	ld b, $02
	farcall SetOWObjectDirection
	call Func_41e5c
	jr .asm_41e5b
.asm_41e41
	ldh a, [hKeysHeld]
	bit 4, a
	jr z, .asm_41e5b
	ld a, [wPlayerOWObject]
	ld b, $01
	farcall SetOWObjectDirection
	ld a, $32
	ld b, $03
	farcall SetOWObjectDirection
	call Func_41e5c
.asm_41e5b
	ret

Func_41e5c:
	ld a, $32
	farcall GetOWObjectTilePosition
	ld a, $03
	cp d
	ret z
	ld a, $32
	ld bc, $8301
	farcall Func_10e3c
	ld a, $32
	call Func_336d
	ret

Func_41e75:
	ld a, $32
	farcall GetOWObjectTilePosition
	ld a, $04
	cp d
	ret z
	ld a, $32
	ld bc, $8101
	farcall Func_10e3c
	ld a, $32
	call Func_336d
	ret

SealedFort_MapHeader:
	db MAP_GFX_SEALED_FORT
	dba SealedFort_MapScripts
	db MUSIC_FORT_4

SealedFort_StepEvents:
	map_exit 5, 12, MAP_SEALED_FORT_ENTRANCE, 4, 1, SOUTH
	map_exit 6, 12, MAP_SEALED_FORT_ENTRANCE, 5, 1, SOUTH
	map_exit 7, 12, MAP_SEALED_FORT_ENTRANCE, 6, 1, SOUTH
	ow_script 6, 6, Func_41f66
	db $ff

SealedFort_OWInteractions:
	ow_script 6, 2, Func_41fe1
	ow_script 2, 2, Func_4207e
	ow_script 3, 2, Func_42119
	ow_script 4, 2, Func_421b4
	ow_script 5, 2, Func_4224f
	ow_script 9, 2, Func_422ec
	ow_script 7, 2, Func_42387
	ow_script 8, 2, Func_42424
	ow_script 10, 2, Func_424bf
	db $ff

SealedFort_MapScripts:
	dbw $06, Func_41f14
	dbw $08, Func_41f1b
	dbw $09, Func_41f36
	db $ff

Func_41f14:
	ld hl, SealedFort_StepEvents
	call Func_324d
	ret

Func_41f1b:
	ld a, [wPlayerOWObject]
	farcall GetOWObjectAnimStruct1Flag0And1
	ld a, b
	cp $00
	ld a, [wPlayerOWObject]
	jr nz, .asm_41f34
	farcall GetOWObjectTilePosition
	ld hl, SealedFort_OWInteractions
	call Func_324d.asm_3254
.asm_41f34
	scf
	ret

Func_41f36:
	ld hl, SealedFort_AfterDuelScripts
	ld a, [wScriptNPC]
	call Func_344c
	scf
	ret

SealedFort_AfterDuelScripts:
	npc_script NPC_TOBICHAN, Func_42050
	npc_script NPC_EIJI, Func_420eb
	npc_script NPC_MAGICIAN, Func_42186
	npc_script NPC_TOSHIRON, Func_42221
	npc_script NPC_PIERROT, Func_422be
	npc_script NPC_ANNA, Func_42359
	npc_script NPC_DEE, Func_423f6
	npc_script NPC_MASQUERADE, Func_42491
	npc_script NPC_YUI, Func_4252c
	db $ff

Func_41f66:
	ld a, NPC_TOBICHAN
	ld [wScriptNPC], a
	ld hl, $a01
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	ld a, EVENT_SET_UNTIL_MAP_RELOAD_1
	farcall GetEventValue
	jr nz, .asm_41fd9
	xor a
	start_script
	set_player_direction NORTH
	check_event EVENT_GHOST_MASTER_STATUES_STATE
	script_jump_if_b0z .ows_41f8e
	script_command_01
	print_npc_text Text1088
	script_command_02
.ows_41f8e
	set_event EVENT_SET_UNTIL_MAP_RELOAD_1
	scroll_to_position $02, $00
	load_npc NPC_TOBICHAN, 6, 2, SOUTH
	play_sfx SFX_9F
	quit_script
	ld a, $56
	ld hl, Data_4257f
	call Func_4255a
	farcall SetOWObjectSpriteAnimFlag6
	ld a, $01
	start_script
	move_active_npc NPCMovement_41fde
	scroll_to_position $02, $02
	wait_for_player_animation
	scroll_to_player
	script_command_01
	check_event EVENT_GHOST_MASTER_STATUES_STATE
	script_jump_if_b0z .ows_41fc2
	set_event EVENT_GHOST_MASTER_STATUES_STATE
	print_npc_text Text1089
	script_jump .ows_41fc5
.ows_41fc2
	print_npc_text Text108a
.ows_41fc5
	script_command_02
	play_sfx SFX_A0
	quit_script
	ld a, $56
	ld hl, Data_425ae
	call Func_4255a
	ld a, $01
	start_script
	unload_npc NPC_TOBICHAN
	end_script
.asm_41fd9
	farcall Func_c199
	ret
NPCMovement_41fde:
	db SOUTH, MOVE_1
	db $ff

Func_41fe1:
	ld a, NPC_TOBICHAN
	ld [wScriptNPC], a
	ld hl, $a01
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	set_text_ram2 DialogTobichanText
	set_text_ram2b Text108b
	print_text Text108c
	check_event EVENT_GHOST_MASTER_STATUES_STATE
	script_jump_if_b0nz .ows_42044
	ask_question Text108d, TRUE
	script_jump_if_b0z .ows_42044
	print_npc_text Text108e
	script_command_02
	move_player NPCMovement_42047, TRUE
	wait_for_player_animation
	load_npc NPC_TOBICHAN, 6, 3, SOUTH
	play_sfx SFX_9F
	quit_script
	ld a, $56
	ld hl, Data_4257f
	call Func_4255a
	farcall SetOWObjectSpriteAnimFlag6
	ld a, $01
	start_script
	script_command_01
	check_event EVENT_BATTLED_TOBICHAN
	script_jump_if_b0z .ows_4203b
	set_event EVENT_BATTLED_TOBICHAN
	print_npc_text Text108f
	script_jump .ows_4203e
.ows_4203b
	print_npc_text Text1090
.ows_4203e
	script_command_02
	start_duel POISON_STORM_DECK_ID, MUSIC_DITTY_2
	end_script
	ret
.ows_42044
	script_command_02
	end_script
	ret
NPCMovement_42047:
	db WEST, MOVE_2
	db SOUTH, MOVE_4
	db EAST, MOVE_2
	db NORTH, MOVE_0
	db $ff

Func_42050:
	xor a
	start_script
	script_command_01
	check_event EVENT_SET_UNTIL_MAP_RELOAD_2
	script_jump_if_b0nz .ows_42066
	print_npc_text Text1091
	give_booster_packs BoosterList_cdbe
	print_npc_text Text1092
	script_jump .ows_42069
.ows_42066
	print_npc_text Text1093
.ows_42069
	script_command_02
	play_sfx SFX_A0
	quit_script
	ld a, $56
	ld hl, Data_425ae
	call Func_4255a
	ld a, $01
	start_script
	unload_npc NPC_TOBICHAN
	end_script
	ret

Func_4207e:
	ld a, NPC_EIJI
	ld [wScriptNPC], a
	ld hl, $a02
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	set_text_ram2 DialogEijiText
	set_text_ram2b Text1094
	print_text Text108c
	check_event EVENT_GHOST_MASTER_STATUES_STATE
	script_jump_if_b0nz .ows_420e1
	ask_question Text108d, TRUE
	script_jump_if_b0z .ows_420e1
	print_npc_text Text1095
	script_command_02
	move_player NPCMovement_420e4, TRUE
	wait_for_player_animation
	load_npc NPC_EIJI, 6, 3, SOUTH
	play_sfx SFX_9F
	quit_script
	ld a, $57
	ld hl, Data_4257f
	call Func_4255a
	farcall SetOWObjectSpriteAnimFlag6
	ld a, $01
	start_script
	script_command_01
	check_event EVENT_BATTLED_EIJI
	script_jump_if_b0z .ows_420d8
	set_event EVENT_BATTLED_EIJI
	print_npc_text Text1096
	script_jump .ows_420db
.ows_420d8
	print_npc_text Text1097
.ows_420db
	script_command_02
	start_duel EVERYBODYS_FRIEND_DECK_ID, MUSIC_DITTY_2
	end_script
	ret
.ows_420e1
	script_command_02
	end_script
	ret
NPCMovement_420e4:
	db SOUTH, MOVE_4
	db EAST, MOVE_4
	db NORTH, MOVE_0
	db $ff

Func_420eb:
	xor a
	start_script
	script_command_01
	check_event EVENT_SET_UNTIL_MAP_RELOAD_2
	script_jump_if_b0nz .ows_42101
	print_npc_text Text1098
	give_booster_packs BoosterList_cdbe
	print_npc_text Text1099
	script_jump .ows_42104
.ows_42101
	print_npc_text Text109a
.ows_42104
	script_command_02
	play_sfx SFX_A0
	quit_script
	ld a, $57
	ld hl, Data_425ae
	call Func_4255a
	ld a, $01
	start_script
	unload_npc NPC_EIJI
	end_script
	ret

Func_42119:
	ld a, NPC_MAGICIAN
	ld [wScriptNPC], a
	ld hl, $a03
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	set_text_ram2 DialogMagicianText
	set_text_ram2b Text109b
	print_text Text108c
	check_event EVENT_GHOST_MASTER_STATUES_STATE
	script_jump_if_b0nz .ows_4217c
	ask_question Text108d, TRUE
	script_jump_if_b0z .ows_4217c
	print_npc_text Text109c
	script_command_02
	move_player NPCMovement_4217f, TRUE
	wait_for_player_animation
	load_npc NPC_MAGICIAN, 6, 3, SOUTH
	play_sfx SFX_9F
	quit_script
	ld a, $58
	ld hl, Data_4257f
	call Func_4255a
	farcall SetOWObjectSpriteAnimFlag6
	ld a, $01
	start_script
	script_command_01
	check_event EVENT_BATTLED_MAGICIAN
	script_jump_if_b0z .ows_42173
	set_event EVENT_BATTLED_MAGICIAN
	print_npc_text Text109d
	script_jump .ows_42176
.ows_42173
	print_npc_text Text109e
.ows_42176
	script_command_02
	start_duel IMMORTAL_POKEMON_DECK_ID, MUSIC_DITTY_2
	end_script
	ret
.ows_4217c
	script_command_02
	end_script
	ret
NPCMovement_4217f:
	db SOUTH, MOVE_4
	db EAST, MOVE_3
	db NORTH, MOVE_0
	db $ff

Func_42186:
	xor a
	start_script
	script_command_01
	check_event EVENT_SET_UNTIL_MAP_RELOAD_2
	script_jump_if_b0nz .ows_4219c
	print_npc_text Text109f
	give_booster_packs BoosterList_cdbe
	print_npc_text Text10a0
	script_jump .ows_4219f
.ows_4219c
	print_npc_text Text10a1
.ows_4219f
	script_command_02
	play_sfx SFX_A0
	quit_script
	ld a, $58
	ld hl, Data_425ae
	call Func_4255a
	ld a, $01
	start_script
	unload_npc NPC_MAGICIAN
	end_script
	ret

Func_421b4:
	ld a, NPC_TOSHIRON
	ld [wScriptNPC], a
	ld hl, $a04
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	set_text_ram2 DialogToshironText
	set_text_ram2b Text10a2
	print_text Text108c
	check_event EVENT_GHOST_MASTER_STATUES_STATE
	script_jump_if_b0nz .ows_42217
	ask_question Text108d, TRUE
	script_jump_if_b0z .ows_42217
	print_npc_text Text10a3
	script_command_02
	move_player NPCMovement_4221a, TRUE
	wait_for_player_animation
	load_npc NPC_TOSHIRON, 6, 3, SOUTH
	play_sfx SFX_9F
	quit_script
	ld a, $59
	ld hl, Data_4257f
	call Func_4255a
	farcall SetOWObjectSpriteAnimFlag6
	ld a, $01
	start_script
	script_command_01
	check_event EVENT_BATTLED_TOSHIRON
	script_jump_if_b0z .ows_4220e
	set_event EVENT_BATTLED_TOSHIRON
	print_npc_text Text10a4
	script_jump .ows_42211
.ows_4220e
	print_npc_text Text10a5
.ows_42211
	script_command_02
	start_duel TRAINER_IMPRISON_DECK_ID, MUSIC_DITTY_2
	end_script
	ret
.ows_42217
	script_command_02
	end_script
	ret
NPCMovement_4221a:
	db SOUTH, MOVE_4
	db EAST, MOVE_2
	db NORTH, MOVE_0
	db $ff

Func_42221:
	xor a
	start_script
	script_command_01
	check_event EVENT_SET_UNTIL_MAP_RELOAD_2
	script_jump_if_b0nz .ows_42237
	print_npc_text Text10a6
	give_booster_packs BoosterList_cdbe
	print_npc_text Text10a7
	script_jump .ows_4223a
.ows_42237
	print_npc_text Text10a8
.ows_4223a
	script_command_02
	play_sfx SFX_A0
	quit_script
	ld a, $59
	ld hl, Data_425ae
	call Func_4255a
	ld a, $01
	start_script
	unload_npc NPC_TOSHIRON
	end_script
	ret

Func_4224f:
	ld a, NPC_PIERROT
	ld [wScriptNPC], a
	ld hl, $a05
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	set_text_ram2 DialogPierrotText
	set_text_ram2b Text10a9
	print_text Text108c
	check_event EVENT_GHOST_MASTER_STATUES_STATE
	script_jump_if_b0nz .ows_422b2
	ask_question Text108d, TRUE
	script_jump_if_b0z .ows_422b2
	print_npc_text Text10aa
	script_command_02
	move_player NPCMovement_422b5, TRUE
	wait_for_player_animation
	load_npc NPC_PIERROT, 6, 3, SOUTH
	play_sfx SFX_9F
	quit_script
	ld a, $5a
	ld hl, Data_4257f
	call Func_4255a
	farcall SetOWObjectSpriteAnimFlag6
	ld a, $01
	start_script
	script_command_01
	check_event EVENT_BATTLED_PIERROT
	script_jump_if_b0z .ows_422a9
	set_event EVENT_BATTLED_PIERROT
	print_npc_text Text10ab
	script_jump .ows_422ac
.ows_422a9
	print_npc_text Text10ac
.ows_422ac
	script_command_02
	start_duel BLAZING_FLAME_DECK_ID, MUSIC_DITTY_2
	end_script
	ret
.ows_422b2
	script_command_02
	end_script
	ret
NPCMovement_422b5:
	db WEST, MOVE_1
	db SOUTH, MOVE_4
	db EAST, MOVE_2
	db NORTH, MOVE_0
	db $ff

Func_422be:
	xor a
	start_script
	script_command_01
	check_event EVENT_SET_UNTIL_MAP_RELOAD_2
	script_jump_if_b0nz .ows_422d4
	print_npc_text Text10ad
	give_booster_packs BoosterList_cdbe
	print_npc_text Text10ae
	script_jump .ows_422d7
.ows_422d4
	print_npc_text Text10af
.ows_422d7
	script_command_02
	play_sfx SFX_A0
	quit_script
	ld a, $5a
	ld hl, Data_425ae
	call Func_4255a
	ld a, $01
	start_script
	unload_npc NPC_PIERROT
	end_script
	ret

Func_422ec:
	ld a, NPC_ANNA
	ld [wScriptNPC], a
	ld hl, $a07
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	set_text_ram2 DialogAnnaText
	set_text_ram2b Text10b0
	print_text Text108c
	check_event EVENT_GHOST_MASTER_STATUES_STATE
	script_jump_if_b0nz .ows_4234f
	ask_question Text108d, TRUE
	script_jump_if_b0z .ows_4234f
	print_npc_text Text10b1
	script_command_02
	move_player NPCMovement_42352, TRUE
	wait_for_player_animation
	load_npc NPC_ANNA, 6, 3, SOUTH
	play_sfx SFX_9F
	quit_script
	ld a, $5b
	ld hl, Data_4257f
	call Func_4255a
	farcall SetOWObjectSpriteAnimFlag6
	ld a, $01
	start_script
	script_command_01
	check_event EVENT_BATTLED_ANNA
	script_jump_if_b0z .ows_42346
	set_event EVENT_BATTLED_ANNA
	print_npc_text Text10b2
	script_jump .ows_42349
.ows_42346
	print_npc_text Text10b3
.ows_42349
	script_command_02
	start_duel DAMAGE_CHAOS_DECK_ID, MUSIC_DITTY_2
	end_script
	ret
.ows_4234f
	script_command_02
	end_script
	ret
NPCMovement_42352:
	db SOUTH, MOVE_4
	db WEST, MOVE_3
	db NORTH, MOVE_0
	db $ff

Func_42359:
	xor a
	start_script
	script_command_01
	check_event EVENT_SET_UNTIL_MAP_RELOAD_2
	script_jump_if_b0nz .ows_4236f
	print_npc_text Text10b4
	give_booster_packs BoosterList_cdbe
	print_npc_text Text10b5
	script_jump .ows_42372
.ows_4236f
	print_npc_text Text10b6
.ows_42372
	script_command_02
	play_sfx SFX_A0
	quit_script
	ld a, $5b
	ld hl, Data_425ae
	call Func_4255a
	ld a, $01
	start_script
	unload_npc NPC_ANNA
	end_script
	ret

Func_42387:
	ld a, NPC_DEE
	ld [wScriptNPC], a
	ld hl, $a06
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	set_text_ram2 DialogDeeText
	set_text_ram2b Text10b7
	print_text Text108c
	check_event EVENT_GHOST_MASTER_STATUES_STATE
	script_jump_if_b0nz .ows_423ea
	ask_question Text108d, TRUE
	script_jump_if_b0z .ows_423ea
	print_npc_text Text10b8
	script_command_02
	move_player NPCMovement_423ed, TRUE
	wait_for_player_animation
	load_npc NPC_DEE, 6, 3, SOUTH
	play_sfx SFX_9F
	quit_script
	ld a, $5c
	ld hl, Data_4257f
	call Func_4255a
	farcall SetOWObjectSpriteAnimFlag6
	ld a, $01
	start_script
	script_command_01
	check_event EVENT_BATTLED_DEE
	script_jump_if_b0z .ows_423e1
	set_event EVENT_BATTLED_DEE
	print_npc_text Text10b9
	script_jump .ows_423e4
.ows_423e1
	print_npc_text Text10ba
.ows_423e4
	script_command_02
	start_duel BIG_THUNDER_DECK_ID, MUSIC_DITTY_2
	end_script
	ret
.ows_423ea
	script_command_02
	end_script
	ret
NPCMovement_423ed:
	db EAST, MOVE_1
	db SOUTH, MOVE_4
	db WEST, MOVE_2
	db NORTH, MOVE_0
	db $ff

Func_423f6:
	xor a
	start_script
	script_command_01
	check_event EVENT_SET_UNTIL_MAP_RELOAD_2
	script_jump_if_b0nz .ows_4240c
	print_npc_text Text10bb
	give_booster_packs BoosterList_cdbe
	print_npc_text Text10bc
	script_jump .ows_4240f
.ows_4240c
	print_npc_text Text10bd
.ows_4240f
	script_command_02
	play_sfx SFX_A0
	quit_script
	ld a, $5c
	ld hl, Data_425ae
	call Func_4255a
	ld a, $01
	start_script
	unload_npc NPC_DEE
	end_script
	ret

Func_42424:
	ld a, NPC_MASQUERADE
	ld [wScriptNPC], a
	ld hl, $a08
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	set_text_ram2 DialogMasqueradeText
	set_text_ram2b Text10be
	print_text Text108c
	check_event EVENT_GHOST_MASTER_STATUES_STATE
	script_jump_if_b0nz .ows_42487
	ask_question Text108d, TRUE
	script_jump_if_b0z .ows_42487
	print_npc_text Text10bf
	script_command_02
	move_player NPCMovement_4248a, TRUE
	wait_for_player_animation
	load_npc NPC_MASQUERADE, 6, 3, SOUTH
	play_sfx SFX_9F
	quit_script
	ld a, $5d
	ld hl, Data_4257f
	call Func_4255a
	farcall SetOWObjectSpriteAnimFlag6
	ld a, $01
	start_script
	script_command_01
	check_event EVENT_BATTLED_MASQUERADE
	script_jump_if_b0z .ows_4247e
	set_event EVENT_BATTLED_MASQUERADE
	print_npc_text Text10c0
	script_jump .ows_42481
.ows_4247e
	print_npc_text Text10c1
.ows_42481
	script_command_02
	start_duel POWER_OF_DARKNESS_DECK_ID, MUSIC_DITTY_2
	end_script
	ret
.ows_42487
	script_command_02
	end_script
	ret
NPCMovement_4248a:
	db SOUTH, MOVE_4
	db WEST, MOVE_2
	db NORTH, MOVE_0
	db $ff

Func_42491:
	xor a
	start_script
	script_command_01
	check_event EVENT_SET_UNTIL_MAP_RELOAD_2
	script_jump_if_b0nz .ows_424a7
	print_npc_text Text10c2
	give_booster_packs BoosterList_cdbe
	print_npc_text Text10c3
	script_jump .ows_424aa
.ows_424a7
	print_npc_text Text10c4
.ows_424aa
	script_command_02
	play_sfx SFX_A0
	quit_script
	ld a, $5d
	ld hl, Data_425ae
	call Func_4255a
	ld a, $01
	start_script
	unload_npc NPC_MASQUERADE
	end_script
	ret

Func_424bf:
	ld a, NPC_YUI
	ld [wScriptNPC], a
	ld hl, $a09
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	set_text_ram2 DialogYuiText
	set_text_ram2b Text10c5
	print_text Text108c
	check_event EVENT_GHOST_MASTER_STATUES_STATE
	script_jump_if_b0nz .ows_42522
	ask_question Text108d, TRUE
	script_jump_if_b0z .ows_42522
	print_npc_text Text10c6
	script_command_02
	move_player NPCMovement_42525, TRUE
	wait_for_player_animation
	load_npc NPC_YUI, 6, 3, SOUTH
	play_sfx SFX_9F
	quit_script
	ld a, $b0
	ld hl, Data_4257f
	call Func_4255a
	farcall SetOWObjectSpriteAnimFlag6
	ld a, $01
	start_script
	script_command_01
	check_event EVENT_BATTLED_YUI
	script_jump_if_b0z .ows_42519
	set_event EVENT_BATTLED_YUI
	print_npc_text Text10c7
	script_jump .ows_4251c
.ows_42519
	print_npc_text Text10c8
.ows_4251c
	script_command_02
	start_duel TORRENTIAL_FLOOD_DECK_ID, MUSIC_DITTY_2
	end_script
	ret
.ows_42522
	script_command_02
	end_script
	ret
NPCMovement_42525:
	db SOUTH, MOVE_4
	db WEST, MOVE_4
	db NORTH, MOVE_0
	db $ff

Func_4252c:
	xor a
	start_script
	script_command_01
	check_event EVENT_SET_UNTIL_MAP_RELOAD_2
	script_jump_if_b0nz .ows_42542
	print_npc_text Text10c9
	give_booster_packs BoosterList_cdbe
	print_npc_text Text10ca
	script_jump .ows_42545
.ows_42542
	print_npc_text Text10cb
.ows_42545
	script_command_02
	play_sfx SFX_A0
	quit_script
	ld a, $b0
	ld hl, Data_425ae
	call Func_4255a
	ld a, $01
	start_script
	unload_npc NPC_YUI
	end_script
	ret

Func_4255a:
	push af
	push bc
	push hl
	ld c, a
.asm_4255e
	ld a, [hl]
	cp $ff
	jr z, .asm_4257b
	bit 7, a
	jr z, .asm_4256e
	ld a, c
	farcall SetOWObjectSpriteAnimFlag6
	jr .asm_42573
.asm_4256e
	ld a, c
	farcall ResetOWObjectSpriteAnimFlag6
.asm_42573
	ld a, [hli]
	res 7, a
	call WaitAFrames
	jr .asm_4255e
.asm_4257b
	pop hl
	pop bc
	pop af
	ret

Data_4257f:
	db $8a, $0a, $89, $09, $88, $08, $87, $07, $86, $06
	db $85, $05, $84, $04, $83, $02, $82, $02, $82, $02
	db $82, $02, $82, $02, $81, $01, $81, $01, $81, $01
	db $81, $01, $81, $01, $81, $01, $81, $01, $81, $01
	db $81, $01, $81, $01, $81, $01, $ff

Data_425ae:
	db $88, $08, $87, $07, $86, $06, $85, $05, $84, $04
	db $83, $02, $82, $02, $82, $02, $81, $01, $81, $01
	db $81, $01, $81, $01, $81, $01, $81, $01, $81, $01
	db $81, $01, $ff

GrChallengeHall_MapHeader:
	db MAP_GFX_GR_CHALLENGE_HALL
	dba GrChallengeHall_MapScripts
	db MUSIC_GROVERWORLD

GrChallengeHall_StepEvents:
	map_exit 7, 15, MAP_GR_CHALLENGE_HALL_ENTRANCE, 4, 1, SOUTH
	map_exit 8, 15, MAP_GR_CHALLENGE_HALL_ENTRANCE, 5, 1, SOUTH
	db $ff

GrChallengeHall_NPCs:
	npc NPC_CUP_HOST, 7, 2, SOUTH, Func_4294a
	npc NPC_GR_CUP_CLERK_LEFT, 4, 8, SOUTH, Func_4294a
	npc NPC_GR_CUP_CLERK_RIGHT, 11, 8, SOUTH, Func_4294a
	npc NPC_GR_STAFF, 8, 6, NORTH, Func_4299f
	db $ff

GrChallengeHall_NPCInteractions:
	npc_script NPC_GR_CUP_CLERK_LEFT, Func_4288d
	npc_script NPC_GR_CUP_CLERK_RIGHT, Func_4292f
	npc_script NPC_GR_STAFF, Func_42961
	db $ff

GrChallengeHall_OWInteractions:
	ow_script 7, 3, Func_4271f
	ow_script 8, 3, Func_4271f
	db $ff

GrChallengeHall_MapScripts:
	dbw $06, Func_42639
	dbw $08, Func_426b9
	dbw $09, Func_426d6
	dbw $11, Func_426c9
	dbw $07, Func_42640
	dbw $02, Func_4266e
	dbw $01, Func_42649
	dbw $0b, Func_426f8
	db $ff

Func_42639:
	ld hl, GrChallengeHall_StepEvents
	call Func_324d
	ret

Func_42640:
	ld hl, GrChallengeHall_NPCs
	call Func_3205
	scf
	ccf
	ret

Func_42649:
	ld a, VAR_30
	farcall GetVarValue
	cp $01
	jr z, .asm_4265f
	cp $03
	jr z, .asm_4265f
	cp $05
	jr z, .asm_42666
	jr nc, .asm_4265f
	scf
	ret
.asm_4265f
	ld a, MUSIC_GRCHALLENGECUP
	ld [wNextMusic], a
	jr .asm_4266b
.asm_42666
	ld a, $75
	ld [wCurMapGfx], a
.asm_4266b
	scf
	ccf
	ret

Func_4266e:
	call Func_42e14
	jr nc, .asm_4268a
	ld a, VAR_30
	farcall GetVarValue
	cp $05
	jr nz, .asm_426b7
	ld a, $e1
	ld de, $903
	ld b, $02
	farcall Func_10f0f
	jr .asm_426b7
.asm_4268a
	ld a, VAR_30
	farcall GetVarValue
	cp $06
	jr nz, .asm_4269e
	ld bc, $57
	ld de, $500
	farcall Func_12c0ce
.asm_4269e
	ld a, $01
	farcall Func_45301
	ld a, VAR_2D
	farcall GetVarValue
	farcall Func_453c3
	ld de, $904
	ld b, $03
	farcall LoadOWObjectInMap
.asm_426b7
	scf
	ret

Func_426b9:
	ld hl, GrChallengeHall_NPCInteractions
	call Func_328c
	jr nc, .asm_426c7
	ld hl, GrChallengeHall_OWInteractions
	call Func_32bf
.asm_426c7
	scf
	ret

Func_426c9:
	ld a, EVENT_EB
	farcall GetEventValue
	jr nz, .asm_426d3
	scf
	ret
.asm_426d3
	scf
	ccf
	ret

Func_426d6:
	ld a, EVENT_EB
	farcall GetEventValue
	jr nz, .asm_426ef
	ld a, VAR_2C
	farcall GetVarValue
	cp $02
	jp c, Func_42a1b
	jp z, Func_42aee
	jp Func_42bb7
.asm_426ef
	farcall Func_ec6c
	call Func_42776
	scf
	ret

Func_426f8:
	ld a, EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE_DUMMY
	farcall GetEventValue
	jr nz, .asm_42702
	scf
	ret
.asm_42702
	farcall Func_c18f
	call Func_4270c
	scf
	ccf
	ret

Func_4270c:
	xor a
	start_script
	reset_event EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE_DUMMY
	set_active_npc_position 9, 2
	get_var VAR_2C
	compare_loaded_var $02
	script_jump_if_b0nz Script_42aae
	script_jump Script_42b81

Func_4271f:
	ld a, EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE
	farcall GetEventValue
	ret z
	farcall Func_ebc6
	jr nc, .asm_4273a
	farcall Func_eb39
	xor a
	start_script
	script_command_01
	print_text Text0f06
	script_command_02
	end_script
.asm_4273a
	farcall Func_ec6c
	ld a, $01
	farcall Func_ef40
	farcall Func_efd0
	ld a, $01
	ld bc, $0
	farcall Func_135ec
	jr c, .asm_42763
	xor a
	start_script
	set_event EVENT_EB
	set_var VAR_34, $01
	end_script
	farcall Func_eff7
	jr .asm_42775
.asm_42763
	or a
	jr z, .asm_42775
	ld bc, $0
	ld a, c
	ld [$de13], a
	ld a, b
	ld [$de14], a
	farcall Func_ec38
.asm_42775
	ret

Func_42776:
	ld a, EVENT_SET_UNTIL_MAP_RELOAD_2
	farcall GetEventValue
	jp z, .asm_427f2
	ld a, [$de13]
	ld c, a
	ld a, [$de14]
	ld b, a
	inc bc
	ld a, b
	cp $03
	jr c, .asm_42792
	jr nz, .asm_42792
	ld a, c
	cp $e8
.asm_42792
	jr nc, .asm_4279c
	ld a, c
	ld [$de13], a
	ld a, b
	ld [$de14], a
.asm_4279c
	ld a, VAR_34
	farcall GetVarValue
	cp $05
	jr z, .asm_427c7
	ld b, a
	ld a, $01
	ld c, $01
	farcall Func_135ec
	jp c, .asm_42801
	ld a, $34
	ld d, a
	farcall GetVarValue
	inc a
	ld c, a
	ld a, d
	farcall SetVarValue
	farcall Func_eff7
	jp .asm_42819
.asm_427c7
	ld a, [$de0f]
	ld c, a
	ld a, [$de10]
	ld b, a
	inc bc
	ld a, b
	cp $03
	jr c, .asm_427da
	jr nz, .asm_427da
	ld a, c
	cp $e8
.asm_427da
	jr nc, .asm_427e4
	ld a, c
	ld [$de0f], a
	ld a, b
	ld [$de10], a
.asm_427e4
	call Func_42833
	ld a, $01
	ld bc, $501
	farcall Func_135ec
	jr .asm_4281a
.asm_427f2
	ld a, VAR_34
	farcall GetVarValue
	ld b, a
	ld a, $01
	ld c, $02
	farcall Func_135ec
.asm_42801
	call Func_42833
	ld bc, $0
	ld a, c
	ld [$de13], a
	ld a, b
	ld [$de14], a
.asm_4280f
	ld a, EVENT_EB
	farcall ZeroOutEventValue
	farcall Func_ec38
.asm_42819
	ret
.asm_4281a
	ld a, [$de13]
	ld e, a
	ld a, [$de14]
	ld d, a
	ld a, d
	cp $00
	jr c, .asm_4282c
	jr nz, .asm_4282c
	ld a, e
	cp $32
.asm_4282c
	jr nz, .asm_4280f
	call Func_4286c
	jr .asm_4280f

Func_42833:
	ld a, [$de13]
	ld c, a
	ld a, [$de14]
	ld b, a
	ld a, [$de17]
	ld e, a
	ld a, [$de18]
	ld d, a
	ld a, b
	cp d
	jr c, .asm_4284b
	jr nz, .asm_4284b
	ld a, c
	cp e
.asm_4284b
	jr nc, .asm_4284f
	scf
	ret
.asm_4284f
	ld a, c
	ld [$de17], a
	ld a, b
	ld [$de18], a
	call EnableSRAM
	ld hl, sPlayerName
	ld de, $de29
	ld bc, $10
	call CopyDataHLtoDE_SaveRegisters
	call DisableSRAM
	scf
	ccf
	ret

Func_4286c:
	xor a
	start_script
	check_event EVENT_GOT_GENGAR_COIN
	script_jump_if_b0z .ows_4288b
	set_event EVENT_GOT_GENGAR_COIN
	set_active_npc NPC_GR_STAFF, DialogStaffText
	set_active_npc_direction WEST
	set_player_direction EAST
	script_command_01
	print_npc_text Text0de9
	give_coin COIN_GENGAR
	print_npc_text Text0dea
	script_command_02
	set_active_npc_direction SOUTH
.ows_4288b
	end_script
	ret

Func_4288d:
	ld a, NPC_GR_CUP_CLERK_LEFT
	ld [wScriptNPC], a
	ld hl, $a5a
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	get_var VAR_33
	compare_loaded_var $01
	script_jump_if_b0nz .ows_428d7
	script_jump_if_b1z .ows_428f3
	get_var VAR_30
	compare_loaded_var $06
	script_jump_if_b0nz .ows_428c4
	compare_loaded_var $03
	script_jump_if_b0nz .ows_428be
	print_npc_text Text0deb
	script_jump .ows_428f9
.ows_428be
	print_npc_text Text0dec
	script_jump .ows_428f9
.ows_428c4
	quit_script
	farcall Func_f04d
	call LoadTxRam2
	ld a, $01
	start_script
	print_npc_text Text0ded
	script_jump .ows_428f9
.ows_428d7
	get_var VAR_30
	compare_loaded_var $03
	script_jump_if_b1z .ows_428ed
	script_jump_if_b0nz .ows_428e7
	print_npc_text Text0dee
	script_jump .ows_4291a
.ows_428e7
	print_npc_text Text0def
	script_jump .ows_4291a
.ows_428ed
	print_npc_text Text0df0
	script_jump .ows_4291a
.ows_428f3
	print_npc_text Text0df1
	script_jump .ows_4291a
.ows_428f9
	ask_question Text0df2, TRUE
	script_jump_if_b0z .ows_42917
	print_npc_text Text0df3
	script_command_02
	move_active_npc NPCMovement_4291d
	move_player NPCMovement_42927, TRUE
	wait_for_player_animation
	move_active_npc NPCMovement_42922
	move_player NPCMovement_4292a, TRUE
	wait_for_player_animation
	script_jump Script_429b6
.ows_42917
	print_npc_text Text0df4
.ows_4291a
	script_command_02
	end_script
	ret
NPCMovement_4291d:
	db EAST, MOVE_1
	db WEST, MOVE_0
	db $ff
NPCMovement_42922:
	db WEST, MOVE_1
	db SOUTH, MOVE_0
	db $ff
NPCMovement_42927:
	db NORTH, MOVE_2
	db $ff
NPCMovement_4292a:
	db NORTH, MOVE_3
	db EAST, MOVE_2
	db $ff

Func_4292f:
	ld a, NPC_GR_CUP_CLERK_RIGHT
	ld [wScriptNPC], a
	ld hl, $a5a
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	print_npc_text Text0df5
	script_command_02
	end_script
	ret

Func_4294a:
	ld a, VAR_30
	farcall GetVarValue
	cp $01
	jr z, .asm_4295e
	cp $03
	jr z, .asm_4295e
	cp $06
	jr z, .asm_4295e
	scf
	ret
.asm_4295e
	scf
	ccf
	ret

Func_42961:
	ld a, NPC_GR_STAFF
	ld [wScriptNPC], a
	ld hl, $a59
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	check_event EVENT_GOT_GENGAR_COIN
	script_jump_if_b0z .ows_42999
	check_event EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE
	script_jump_if_b0z .ows_42993
	check_event EVENT_C5
	script_jump_if_b0z .ows_4298d
	set_event EVENT_C5
	print_npc_text Text0df6
	script_jump .ows_4299c
.ows_4298d
	print_npc_text Text0df7
	script_jump .ows_4299c
.ows_42993
	print_npc_text Text0df8
	script_jump .ows_4299c
.ows_42999
	print_npc_text Text0df9
.ows_4299c
	script_command_02
	end_script
	ret

Func_4299f:
	ld a, VAR_30
	farcall GetVarValue
	cp $01
	jr z, .asm_429b4
	cp $03
	jr z, .asm_429b4
	cp $06
	jr z, .asm_429b4
	scf
	ccf
	ret
.asm_429b4
	scf
	ret

Script_429b6:
	set_var VAR_2C, $00
	script_jump .ows_429bc
.ows_429bc
	set_var VAR_2C, $01
	quit_script
	farcall Func_453ce
	ld a, $01
	start_script
	set_active_npc NPC_CUP_HOST, DialogCupHostText
	script_command_01
	get_var VAR_30
	compare_loaded_var $03
	script_jump_if_b0nz .ows_429ec
	script_jump_if_b1z .ows_42a00
	print_npc_text Text0dfa
	script_call Script_42d1a
	print_npc_text Text0dfb
	script_call Script_42d2d
	print_npc_text Text0dfc
	script_jump .ows_42a14
.ows_429ec
	print_npc_text Text0dfd
	script_call Script_42d1a
	print_npc_text Text0dfe
	script_call Script_42d2d
	print_npc_text Text0dfc
	script_jump .ows_42a14
.ows_42a00
	print_npc_text Text0dff
	script_call Script_42d1a
	print_npc_text Text0e00
	script_call Script_42d2d
	print_npc_text Text0e01
	script_jump .ows_42a14
.ows_42a14
	script_command_02
	end_script
	farcall Func_453f9
	ret

Func_42a1b:
	xor a
	start_script
	script_command_01
	quit_script
	farcall Func_453ce
	ld a, $01
	start_script
	check_event EVENT_SET_UNTIL_MAP_RELOAD_2
	script_jump_if_b0nz .ows_42a75
	get_var VAR_30
	compare_loaded_var $03
	script_jump_if_b0nz .ows_42a4d
	script_jump_if_b1z .ows_42a61
	print_npc_text Text0e02
	script_call Script_42d22
	print_npc_text Text0e03
	script_call Script_42d40
	print_npc_text Text0e04
	script_jump .ows_42aa6
.ows_42a4d
	print_npc_text Text0e02
	script_call Script_42d22
	print_npc_text Text0e03
	script_call Script_42d40
	print_npc_text Text0e04
	script_jump .ows_42aa6
.ows_42a61
	print_npc_text Text0e05
	script_call Script_42d22
	print_npc_text Text0e06
	script_call Script_42d40
	print_npc_text Text0e07
	script_jump .ows_42aa6
.ows_42a75
	get_var VAR_30
	compare_loaded_var $03
	script_jump_if_b0nz .ows_42a8c
	script_jump_if_b1z .ows_42a99
	print_npc_text Text0e08
	script_call Script_42d1a
	print_npc_text Text0e09
	script_jump Script_42cea
.ows_42a8c
	print_npc_text Text0e08
	script_call Script_42d1a
	print_npc_text Text0e09
	script_jump Script_42cea
.ows_42a99
	print_npc_text Text0e0a
	script_call Script_42d1a
	print_npc_text Text0e0b
	script_jump Script_42cea
.ows_42aa6
	script_call Script_42dad
	script_command_02
	script_jump Script_42aae
Script_42aae:
	set_var VAR_2C, $02
	quit_script
	farcall Func_453ce
	ld a, $01
	start_script
	script_command_01
	print_npc_text Text0e0c
	script_call Script_42d35
	get_var VAR_30
	compare_loaded_var $06
	script_jump_if_b0z .ows_42acd
	print_npc_text Text0e0d
.ows_42acd
	print_npc_text Text0e0e
	ask_question DuelPrepPromptText, FALSE
	script_jump_if_b0z .ows_42ae4
	print_npc_text Text0e0f
	script_command_02
	set_event EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE_DUMMY
	script_command_58
	reset_event EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE_DUMMY
	script_command_01
	script_jump .ows_42acd
.ows_42ae4
	print_npc_text Text0e10
	script_command_02
	end_script
	farcall Func_453f9
	ret
Func_42aee:
	xor a
	start_script
	script_command_01
	quit_script
	farcall Func_453ce
	ld a, $01
	start_script
	check_event EVENT_SET_UNTIL_MAP_RELOAD_2
	script_jump_if_b0nz .ows_42b48
	get_var VAR_30
	compare_loaded_var $03
	script_jump_if_b0nz .ows_42b20
	script_jump_if_b1z .ows_42b34
	print_npc_text Text0e11
	script_call Script_42d22
	print_npc_text Text0e12
	script_call Script_42d40
	print_npc_text Text0e13
	script_jump .ows_42b79
.ows_42b20
	print_npc_text Text0e14
	script_call Script_42d22
	print_npc_text Text0e12
	script_call Script_42d40
	print_npc_text Text0e13
	script_jump .ows_42b79
.ows_42b34
	print_npc_text Text0e15
	script_call Script_42d22
	print_npc_text Text0e12
	script_call Script_42d40
	print_npc_text Text0e16
	script_jump .ows_42b79
.ows_42b48
	get_var VAR_30
	compare_loaded_var $03
	script_jump_if_b0nz .ows_42b5f
	script_jump_if_b1z .ows_42b6c
	print_npc_text Text0e17
	script_call Script_42d1a
	print_npc_text Text0e18
	script_jump Script_42cea
.ows_42b5f
	print_npc_text Text0e17
	script_call Script_42d1a
	print_npc_text Text0e18
	script_jump Script_42cea
.ows_42b6c
	print_npc_text Text0e19
	script_call Script_42d1a
	print_npc_text Text0e1a
	script_jump Script_42cea
.ows_42b79
	script_call Script_42dad
	script_command_02
	script_jump Script_42b81
Script_42b81:
	set_var VAR_2C, $03
	quit_script
	farcall Func_453ce
	ld a, $01
	start_script
	script_command_01
	print_npc_text Text0e1b
	script_call Script_42d35
.ows_42b96
	print_npc_text Text0e0e
	ask_question DuelPrepPromptText, FALSE
	script_jump_if_b0z .ows_42bad
	print_npc_text Text0e0f
	script_command_02
	set_event EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE_DUMMY
	script_command_58
	reset_event EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE_DUMMY
	script_command_01
	script_jump .ows_42b96
.ows_42bad
	print_npc_text Text0e1c
	script_command_02
	end_script
	farcall Func_453f9
	ret

Func_42bb7:
	xor a
	start_script
	script_command_01
	quit_script
	farcall Func_453ce
	ld a, $01
	start_script
	check_event EVENT_SET_UNTIL_MAP_RELOAD_2
	script_jump_if_b0nz .ows_42c11
	get_var VAR_30
	compare_loaded_var $03
	script_jump_if_b0nz .ows_42be9
	script_jump_if_b1z .ows_42bfd
	print_npc_text Text0e1d
	script_call Script_42d22
	print_npc_text Text0e12
	script_call Script_42d40
	print_npc_text Text0e1e
	script_jump .ows_42c42
.ows_42be9
	print_npc_text Text0e1d
	script_call Script_42d22
	print_npc_text Text0e12
	script_call Script_42d40
	print_npc_text Text0e1e
	script_jump .ows_42c42
.ows_42bfd
	print_npc_text Text0e1f
	script_call Script_42d22
	print_npc_text Text0e12
	script_call Script_42d40
	print_npc_text Text0e20
	script_jump .ows_42c42
.ows_42c11
	get_var VAR_30
	compare_loaded_var $03
	script_jump_if_b0nz .ows_42c28
	script_jump_if_b1z .ows_42c35
	print_npc_text Text0e21
	script_call Script_42d1a
	print_npc_text Text0e22
	script_jump Script_42cea
.ows_42c28
	print_npc_text Text0e21
	script_call Script_42d1a
	print_npc_text Text0e22
	script_jump Script_42cea
.ows_42c35
	print_npc_text Text0e23
	script_call Script_42d1a
	print_npc_text Text0e24
	script_jump Script_42cea
.ows_42c42
	set_var VAR_33, $01
	script_command_02
	move_active_npc .NPCMovement_42cd8
	wait_for_player_animation
	set_player_direction NORTH
	script_command_01
	get_var VAR_30
	compare_loaded_var $03
	script_jump_if_b0nz .ows_42c60
	script_jump_if_b1z .ows_42c69
	print_npc_text Text0e25
	receive_card DARK_PERSIAN_ALT_LV28
	script_jump .ows_42cbd
.ows_42c60
	print_npc_text Text0e26
	receive_card BILLS_COMPUTER
	script_jump .ows_42ca9
.ows_42c69
	get_var VAR_32
	compare_loaded_var $0b
	script_jump_if_b1z .ows_42c72
	inc_var VAR_32
.ows_42c72
	quit_script
	ld a, VAR_31
	farcall GetVarValue
	farcall Func_f04d
	call LoadTxRam2
	ld a, $01
	start_script
	print_npc_text Text0e27
	quit_script
	ld a, VAR_31
	farcall GetVarValue
	farcall Func_f036
	ld e, c
	ld d, b
	farcall Func_1022a
	farcall Func_c646
	farcall Func_10252
	call WaitPalFading
	ld a, $01
	start_script
.ows_42ca9
	get_var VAR_32
	compare_loaded_var $0a
	script_jump_if_b0z .ows_42cbd
	print_npc_text Text0e28
	set_event EVENT_GOT_HORSEA_COIN
	give_coin COIN_HORSEA
	print_npc_text Text0e29
	script_jump .ows_42cc0
.ows_42cbd
	print_npc_text Text0e2a
.ows_42cc0
	script_command_02
	move_player .NPCMovement_42cdd, TRUE
	wait_for_player_animation
	move_player .NPCMovement_42ce2, TRUE
	move_npc NPC_GR_CUP_CLERK_LEFT, .NPCMovement_42ce5
	wait_for_player_animation
	animate_npc_movement NPC_GR_CUP_CLERK_LEFT, $03, $01
	set_npc_direction NPC_GR_CUP_CLERK_LEFT, SOUTH
	end_script
	ret
.NPCMovement_42cd8:
	db WEST, MOVE_3
	db SOUTH, MOVE_1
	db $ff
.NPCMovement_42cdd:
	db WEST, MOVE_2
	db SOUTH, MOVE_2
	db $ff
.NPCMovement_42ce2:
	db SOUTH, MOVE_5
	db $ff
.NPCMovement_42ce5:
	db EAST, MOVE_1
	db WEST, MOVE_0
	db $ff
Script_42cea:
	set_var VAR_33, $02
	script_command_02
	move_active_npc .NPCMovement_42d08
	move_player .NPCMovement_42d0d, TRUE
	wait_for_player_animation
	move_player .NPCMovement_42d12, TRUE
	move_npc NPC_GR_CUP_CLERK_LEFT, .NPCMovement_42d15
	wait_for_player_animation
	animate_npc_movement NPC_GR_CUP_CLERK_LEFT, $03, $01
	set_npc_direction NPC_GR_CUP_CLERK_LEFT, SOUTH
	end_script
	ret
.NPCMovement_42d08:
	db EAST, MOVE_1
	db SOUTH, MOVE_0
	db $ff
.NPCMovement_42d0d:
	db WEST, MOVE_2
	db SOUTH, MOVE_2
	db $ff
.NPCMovement_42d12:
	db SOUTH, MOVE_5
	db $ff
.NPCMovement_42d15:
	db EAST, MOVE_1
	db WEST, MOVE_0
	db $ff

Script_42d1a:
	script_command_02
	animate_active_npc_movement $03, $01
	set_active_npc_direction SOUTH
	script_command_01
	script_ret

Script_42d22:
	script_command_02
	animate_active_npc_movement $01, $01
	animate_active_npc_movement $01, $01
	set_active_npc_direction SOUTH
	script_command_01
	script_ret
Script_42d2d:
	script_command_02
	animate_active_npc_movement $01, $01
	set_active_npc_direction SOUTH
	script_command_01
	script_ret
Script_42d35:
	script_command_02
	animate_active_npc_movement $03, $01
	animate_active_npc_movement $03, $01
	set_active_npc_direction SOUTH
	script_command_01
	script_ret

Script_42d40:
	script_command_02
	quit_script
	ld a, VAR_2C
	farcall GetVarValue
	ld c, $2d
	cp $02
	jr c, .asm_42d54
	ld c, $2e
	jr z, .asm_42d54
	ld c, $2f
.asm_42d54
	ld a, c
	farcall GetVarValue
	farcall Func_453c3
	push af
	ld b, $10
	ld hl, NPCMovement_42d9b
	farcall MoveNPC
	call Func_3340
	pop af
	push af
	ld b, $10
	ld hl, NPCMovement_42da0
	farcall MoveNPC
	ld a, NPC_GR_CUP_CLERK_RIGHT
	ld hl, NPCMovement_42da3
	farcall MoveNPC
	call Func_3340
	pop af
	farcall ClearOWObject
	ld a, NPC_GR_CUP_CLERK_RIGHT
	ld b, $10
	ld hl, NPCMovement_42da8
	farcall MoveNPC
	call Func_3340
	ld a, $01
	start_script
	script_command_01
	script_ret

NPCMovement_42d9b:
	db EAST, MOVE_2
	db SOUTH, MOVE_2
	db $ff

NPCMovement_42da0:
	db SOUTH, MOVE_5
	db $ff

NPCMovement_42da3:
	db WEST, MOVE_1
	db EAST, MOVE_0
	db $ff

NPCMovement_42da8:
	db EAST, MOVE_1
	db SOUTH, MOVE_0
	db $ff

Script_42dad:
	script_command_02
	quit_script
	ld a, VAR_2C
	farcall GetVarValue
	ld c, $2e
	cp $02
	jr c, .asm_42dbd
	ld c, $2f
.asm_42dbd
	ld a, c
	farcall GetVarValue
	farcall Func_453c3
	push af
	ld b, $00
	ld de, $b0a
	farcall LoadOWObjectInMap
	ld b, $10
	ld hl, Data_42e02
	farcall MoveNPC
	ld a, NPC_GR_CUP_CLERK_RIGHT
	ld hl, Data_42e0a
	farcall MoveNPC
	call Func_3340
	pop af
	ld b, $10
	ld hl, Data_42e05
	farcall MoveNPC
	ld a, NPC_GR_CUP_CLERK_RIGHT
	ld hl, Data_42e0f
	farcall MoveNPC
	call Func_3340
	ld a, $01
	start_script
	script_command_01
	script_ret

Data_42e02:
	db NORTH, MOVE_3
	db $ff

Data_42e05:
	db NORTH, MOVE_3
	db WEST, MOVE_2
	db $ff

Data_42e0a:
	db WEST, MOVE_1
	db SOUTH, MOVE_0
	db $ff

Data_42e0f:
	db EAST, MOVE_1
	db SOUTH, MOVE_0
	db $ff

Func_42e14:
	ld a, VAR_30
	farcall GetVarValue
	cp $01
	jr z, .asm_42e28
	cp $03
	jr z, .asm_42e28
	cp $06
	jr z, .asm_42e28
	scf
	ret
.asm_42e28
	scf
	ccf
	ret

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
	dbw $06, Func_42e6e
	dbw $02, Func_42e75
	db $ff

Func_42e6e:
	ld hl, FightingFortMaze1_StepEvents
	call Func_324d
	ret

Func_42e75:
	ld bc, $53
	ld a, $05
	farcall SetwD896
	scf
	ret

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
	dbw $06, Func_42ec3
	dbw $02, Func_42eca
	db $ff

Func_42ec3:
	ld hl, FightingFortMaze21_StepEvents
	call Func_324d
	ret

Func_42eca:
	ld bc, $53
	ld a, $05
	farcall SetwD896
	scf
	ret

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
	npc_script NPC_BIRURITCHI, Func_43136
	db $ff

GrCastleBiruritchi_OWInteractions:
	ow_script 4, 12, Func_431bf
	ow_script 10, 12, Func_431bf
	db $ff

GrCastleBiruritchi_MapScripts:
	dbw $06, Func_42f2e
	dbw $08, Func_42fad
	dbw $09, Func_42fbd
	dbw $07, Func_42f35
	dbw $02, Func_42f3e
	dbw $0b, Func_42fcd
	dbw $04, Func_42f86
	dbw $0f, Func_42fa1
	db $ff

Func_42f2e:
	ld hl, GrCastleBiruritchi_StepEvents
	call Func_324d
	ret

Func_42f35:
	ld hl, GrCastleBiruritchi_NPCs
	call Func_3205
	scf
	ccf
	ret

Func_42f3e:
	ld a, EVENT_GR_CASTLE_STAIRS_RUI_ROADBLOCK
	farcall GetEventValue
	jr nz, .asm_42f84
	ld a, $0a
	ld [wd582], a
	ld a, $10
	ld [wd592], a
	ld hl, $7050
	ld a, l
	ld [wd593], a
	ld a, h
	ld [$d594], a
	ld a, $55
	ld de, CopyDataHLtoDE_SaveRegisters
	farcall SetOWObjectTilePosition
	ld a, $53
	ld de, $80e
	ld b, $00
	farcall LoadOWObjectInMap
	ld a, $54
	ld de, $60e
	ld b, $00
	farcall LoadOWObjectInMap
	ld a, [wPlayerOWObject]
	ld de, $70f
	farcall SetOWObjectTilePosition
.asm_42f84
	scf
	ret

Func_42f86:
	ld a, [wd54c]
	cp $05
	jr z, .asm_42f8f
	scf
	ret
.asm_42f8f
	ld a, $00
	ld b, $04
	farcall StartPalFadeToBlackOrWhite
	call WaitPalFading
	farcall Func_110a8
	scf
	ccf
	ret

Func_42fa1:
	ld a, [wd54c]
	cp $05
	jr z, .asm_42faa
	scf
	ret
.asm_42faa
	scf
	ccf
	ret

Func_42fad:
	ld hl, GrCastleBiruritchi_NPCInteractions
	call Func_328c
	jr nc, .asm_42fbb
	ld hl, GrCastleBiruritchi_OWInteractions
	call Func_32bf
.asm_42fbb
	scf
	ret

Func_42fbd:
	ld hl, GrCastleBiruritchi_AfterDuelScripts
	ld a, [wScriptNPC]
	call Func_344c
	scf
	ret

GrCastleBiruritchi_AfterDuelScripts:
	npc_script NPC_BIRURITCHI, Func_431a6
	db $ff

Func_42fcd:
	ld a, EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE_DUMMY
	farcall GetEventValue
	jr nz, .asm_42fd7
	scf
	ret
.asm_42fd7
	farcall Func_c18f
	call Func_42fe1
	scf
	ccf
	ret

Func_42fe1:
	ld a, NPC_BIRURITCHI
	ld [wScriptNPC], a
	ld hl, $a27
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	reset_event EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE_DUMMY
	check_event EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE
	script_jump_if_b0nz Script_4324b
	script_jump Script_432a0

Script_43000:
	script_command_64 $0c
	play_song_next MUSIC_HALLOFHONOR
	script_command_02
	print_npc_text Text0927
	set_event EVENT_GOT_TOGEPI_COIN
	give_coin COIN_TOGEPI
	print_npc_text Text0928
	receive_card GRS_MEWTWO
	set_event EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE
	set_event EVENT_BEAT_GRAND_MASTER_CUP
	reset_event EVENT_TALKED_TO_MITCH
	reset_event EVENT_TALKED_TO_AMY
	reset_event EVENT_TALKED_TO_KEN
	reset_event EVENT_TALKED_TO_MURRAY
	reset_event EVENT_TALKED_TO_MORINO
	reset_event EVENT_TALKED_TO_HIDERO
	reset_event EVENT_TALKED_TO_KANZAKI
	reset_event EVENT_TALKED_TO_ISHIHARA
	reset_event EVENT_BB
	reset_event EVENT_BC
	reset_event EVENT_BD
	reset_event EVENT_ENTERED_GRAND_MASTER_CUP
	set_var VAR_0B, $01
	var_add VAR_27, $05
	set_var VAR_28, $05
	set_var VAR_30, $05
	script_call Script_43333
	print_npc_text Text0929
	script_jump Script_43044

Script_43044:
	end_script
	ld hl, wd583
	set 0, [hl]
	ld a, $05
	ld [wd54c], a
	ret

Data_43050:
	db $af, $cd, $f2, $33, $0e, $a1, $2c, $53, $ff

Script_43059:
	game_center
	move_npc NPC_RUI, NPCMovement_4310a
	move_player NPCMovement_430f4, TRUE
	wait_for_player_animation
	move_npc NPC_RUI, NPCMovement_43113
	wait_for_player_animation
	do_frames 30
	script_command_01
	set_active_npc NPC_KANZAKI, DialogKanzakiText
	print_npc_text Text092a
	script_command_02
	animate_active_npc_movement $82, $01
	script_command_01
	set_active_npc NPC_RUI, DialogRuiText
	print_npc_text Text092b
	script_command_02
	animate_active_npc_movement $82, $01
	script_command_01
	set_active_npc NPC_BIRURITCHI, DialogBiruritchiText
	print_npc_text Text092c
	script_command_02
	set_active_npc NPC_KANZAKI, DialogKanzakiText
	animate_active_npc_movement $00, $01
	set_active_npc_direction WEST
	script_command_01
	print_npc_text Text092d
	script_command_02
	move_active_npc NPCMovement_4311a
	wait_for_player_animation
	set_active_npc NPC_RUI, DialogRuiText
	animate_active_npc_movement $00, $01
	set_active_npc_direction EAST
	script_command_01
	print_npc_text Text092e
	script_command_02
	move_active_npc NPCMovement_4311f
	wait_for_player_animation
	unload_npc NPC_KANZAKI
	unload_npc NPC_RUI
	set_active_npc NPC_BIRURITCHI, DialogBiruritchiText
	animate_active_npc_movement $02, $01
	script_command_01
	print_npc_text Text092f
	script_command_02
	animate_active_npc_movement $01, $01
	script_command_01
	print_npc_text Text0930
	script_command_02
	animate_active_npc_movement $03, $01
	set_active_npc_direction SOUTH
	script_command_01
	print_npc_text Text0931
	script_command_02
	animate_active_npc_movement $03, $01
	script_command_01
	print_npc_text Text0932
	script_command_02
	animate_active_npc_movement $01, $01
	set_active_npc_direction SOUTH
	script_command_01
	print_npc_text Text0933
	script_command_02
	move_active_npc NPCMovement_4312d
	move_player NPCMovement_43124, TRUE
	wait_for_player_animation
	end_script
	ld a, $00
	ld [wd582], a
	jp Func_43136

NPCMovement_430f4:
	db NORTH, MOVE_6
	db WEST, MOVE_2
	db NORTH, MOVE_5
	db EAST, MOVE_2
	db NORTH, MOVE_0
	db $ff

NPCMovement_430ff:
	db NORTH, MOVE_5
	db EAST, MOVE_1
	db NORTH, MOVE_5
	db WEST, MOVE_1
	db NORTH, MOVE_0
	db $ff

NPCMovement_4310a:
	db NORTH, MOVE_5
	db WEST, MOVE_1
	db NORTH, MOVE_6
	db SOUTH, MOVE_0
	db $ff

NPCMovement_43113:
	db SOUTH, MOVE_1
	db EAST, MOVE_1
	db NORTH, MOVE_0
	db $ff

NPCMovement_4311a:
	db EAST, MOVE_1
	db SOUTH, MOVE_5
	db $ff

NPCMovement_4311f:
	db WEST, MOVE_1
	db SOUTH, MOVE_5
	db $ff

NPCMovement_43124:
	db EAST, MOVE_2
	db SOUTH, MOVE_4
	db WEST, MOVE_2
	db NORTH, MOVE_0
	db $ff

NPCMovement_4312d:
	db EAST, MOVE_1
	db SOUTH, MOVE_2
	db WEST, MOVE_1
	db SOUTH, MOVE_0
	db $ff

Func_43136:
	ld a, NPC_BIRURITCHI
	ld [wScriptNPC], a
	ld hl, $a27
	ld a, l
	ld [wScriptNPCName], a
	ld a, h
	ld [$d610], a
	xor a
	start_script
	script_command_01
	set_var VAR_08, $00
	set_var VAR_09, $00
	set_var VAR_0A, $00
	check_event EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE
	script_jump_if_b0z .ows_43181
	check_event EVENT_TALKED_TO_BIRURITCHI
	script_jump_if_b0z .ows_43166
	set_event EVENT_TALKED_TO_BIRURITCHI
	print_npc_text Text0934
	script_jump .ows_43169
.ows_43166
	print_npc_text Text0935
.ows_43169
	ask_question Text0936, TRUE
	script_jump_if_b0z .ows_4317b
	script_call Script_4336b
	print_npc_text Text0937
	script_command_02
	script_jump Script_431ca
.ows_4317b
	print_npc_text Text0938
	script_command_02
	end_script
	ret
.ows_43181
	print_npc_text Text0939
	ask_question Text0936, TRUE
	script_jump_if_b0z .ows_43196
	script_call Script_4336b
	print_npc_text Text093a
	script_command_02
	script_jump Script_431ca
.ows_43196
	print_npc_text Text093b
	get_var VAR_0B
	compare_loaded_var $01
	script_jump_if_b0z .ows_431a3
	print_npc_text Text093c
.ows_431a3
	script_command_02
	end_script
	ret

Func_431a6:
	xor a
	start_script
	script_command_01
	check_event EVENT_SET_UNTIL_MAP_RELOAD_2
	script_jump_if_b0nz .ows_431b5
	inc_var VAR_0A
	script_jump .ows_431b7
.ows_431b5
	get_var VAR_09
.ows_431b7
	check_event EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE
	script_jump_if_b0nz Script_4324b
	script_jump Script_432a0
Func_431bf:
	xor a
	start_script
	script_command_01
	print_text BiruritchiStatueCaptionText
	script_command_02
	end_script
	ret
Script_431ca:
	inc_var VAR_09
	end_script
.asm_431cd
	ld a, $04
	call Random
	dec a
	jr z, .asm_431f7
	dec a
	jr z, .asm_43213
	dec a
	jr z, .asm_4322f
	ld a, VAR_08
	farcall GetVarValue
	bit 0, a
	jr nz, .asm_431cd
	set 0, a
	ld c, a
	ld a, $08
	farcall SetVarValue
	xor a
	start_script
	start_duel STOP_LIFE_DECK_ID, MUSIC_DITTY_2
	end_script
	ret
.asm_431f7
	ld a, VAR_08
	farcall GetVarValue
	bit 1, a
	jr nz, .asm_431cd
	set 1, a
	ld c, a
	ld a, $08
	farcall SetVarValue
	xor a
	start_script
	start_duel SCORCHER_DECK_ID, MUSIC_DITTY_2
	end_script
	ret
.asm_43213
	ld a, VAR_08
	farcall GetVarValue
	bit 2, a
	jr nz, .asm_431cd
	set 2, a
	ld c, a
	ld a, $08
	farcall SetVarValue
	xor a
	start_script
	start_duel TSUNAMI_STARTER_DECK_ID, MUSIC_DITTY_2
	end_script
	ret
.asm_4322f
	ld a, VAR_08
	farcall GetVarValue
	bit 3, a
	jr nz, .asm_431cd
	set 3, a
	ld c, a
	ld a, $08
	farcall SetVarValue
	xor a
	start_script
	start_duel SMASH_TO_MINCEMEAT_DECK_ID, MUSIC_DITTY_2
	end_script
	ret

Script_4324b:
	get_var VAR_09
	compare_loaded_var $03
	script_jump_if_b0nz .ows_4327b
	compare_loaded_var $02
	script_jump_if_b0nz .ows_43266
	get_var VAR_0A
	compare_loaded_var $01
	print_variable_npc_text Text093d, Text093e
	set_text_ram3 $0002
	script_jump .ows_43285

.ows_43266
	get_var VAR_0A
	compare_loaded_var $02
	script_jump_if_b0nz Script_43000
	compare_loaded_var $00
	script_jump_if_b0nz Script_432f5
	print_npc_text Text093f
	set_text_ram3 $0003
	script_jump .ows_43285

.ows_4327b
	get_var VAR_0A
	compare_loaded_var $02
	script_jump_if_b0nz Script_43000
	script_jump Script_432f5

.ows_43285
	ask_question ChangeDeckPromptText, FALSE
	script_jump_if_b0z .ows_43299
	script_command_02
	set_event EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE_DUMMY
	script_command_58
	reset_event EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE_DUMMY
	script_command_01
	print_npc_text Text0941
	script_jump .ows_43285

.ows_43299
	print_npc_text Text0942
	script_command_02
	script_jump Script_431ca

Script_432a0:
	get_var VAR_09
	compare_loaded_var $03
	script_jump_if_b0nz .ows_432d0
	compare_loaded_var $02
	script_jump_if_b0nz .ows_432bb
	get_var VAR_0A
	compare_loaded_var $01
	print_variable_npc_text Text0943, Text0944
	set_text_ram3 $0002
	script_jump .ows_432da

.ows_432bb
	get_var VAR_0A
	compare_loaded_var $02
	script_jump_if_b0nz Script_432fb
	compare_loaded_var $00
	script_jump_if_b0nz Script_4332d
	print_npc_text Text0945
	set_text_ram3 $0003
	script_jump .ows_432da

.ows_432d0
	get_var VAR_0A
	compare_loaded_var $02
	script_jump_if_b0nz Script_432fb
	script_jump Script_4332d

.ows_432da
	ask_question ChangeDeckPromptText, FALSE
	script_jump_if_b0z .ows_432ee
	script_command_02
	set_event EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE_DUMMY
	script_command_58
	reset_event EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE_DUMMY
	script_command_01
	print_npc_text Text0946
	script_jump .ows_432da

.ows_432ee
	print_npc_text Text0947
	script_command_02
	script_jump Script_431ca




Script_432f5:
	print_npc_text Text0948
	script_command_02
	end_script
	ret

Script_432fb:
	play_song_next MUSIC_HALLOFHONOR
	script_command_02
	get_var VAR_0B
	compare_loaded_var $01
	script_jump_if_b0z .ows_4331a
	set_var VAR_0B, $02
	set_event EVENT_SEALED_FORT_DOOR_STATE
	print_npc_text Text0949
	receive_card GRS_MEWTWO
	script_call Script_43333
	print_npc_text Text094a
	script_jump Script_43044

.ows_4331a
	set_var VAR_0B, $03
	print_npc_text Text094b
	give_booster_packs BoosterList_cdba
	script_call Script_43333
	print_npc_text Text094c
	script_jump Script_43044

Script_4332d:
	print_npc_text Text094d
	script_command_02
	end_script
	ret

Script_43333:
	quit_script
	call EnableSRAM
	ld a, $01
	ld [sClearedGame], a
	call DisableSRAM
	ld hl, wd583
	set 6, [hl]
	ld a, $02
	ld de, $102
	ld b, $00
	farcall Func_d3c4
	ld a, $00
	ld [wCurOWLocation], a
	ld a, $00
	ld [wCurIsland], a
	ld a, EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE_DUMMY
	farcall MaxOutEventValue
	farcall Func_ea30
	ld a, $01
	start_script
	play_sfx SFX_56
	script_ret

Script_4336b:
	get_player_y_position
	compare_loaded_var $08
	script_jump_if_b0nz .ows_43393
	script_command_02
	set_active_npc_direction SOUTH
	get_player_direction
	compare_loaded_var $01
	script_jump_if_b0nz .ows_4338d
	compare_loaded_var $02
	script_jump_if_b0nz .ows_43386
	move_player NPCMovement_43394, TRUE
	script_jump .ows_43391

.ows_43386
	move_player NPCMovement_4339d, TRUE
	script_jump .ows_43391

.ows_4338d
	move_player NPCMovement_433a6, TRUE
.ows_43391
	wait_for_player_animation
	script_command_01
.ows_43393
	script_ret

NPCMovement_43394:
	db EAST, MOVE_1
	db SOUTH, MOVE_3
	db WEST, MOVE_2
	db NORTH, MOVE_0
	db $ff

NPCMovement_4339d:
	db EAST, MOVE_2
	db SOUTH, MOVE_4
	db WEST, MOVE_2
	db NORTH, MOVE_0
	db $ff

NPCMovement_433a6:
	db WEST, MOVE_1
	db SOUTH, MOVE_3
	db EAST, MOVE_2
	db NORTH, MOVE_0
	db $ff
