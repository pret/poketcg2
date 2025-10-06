Func_3639f:
	ld a, [wd584]
	cp $6b
	jr nz, .asm_363aa
	farcall Func_1f293
.asm_363aa
	xor a
	call StartScript
Script_363ae:
	check_event EVENT_MET_PSYCHIC_STRONGHOLD_MEMBERS
	script_jump_if_b0z .ows_363be
	unload_npc NPC_MIWA
	unload_npc NPC_KEVIN
	unload_npc NPC_YOSUKE
	unload_npc NPC_RYOKO
	script_jump .ows_363da
; 0x363be
.ows_363be
	script_call .ows_36ba6
	check_event EVENT_BEAT_MIWA
	script_call b0z, .ows_36408
	check_event EVENT_BEAT_KEVIN
	script_call b0z, .ows_36412
	check_event EVENT_BEAT_YOSUKE
	script_call b0z, .ows_3641c
	check_event EVENT_BEAT_RYOKO
	script_call b0z, .ows_36426
.ows_363da
	end_script
; 0x363db
; gap from 0x363db to 0x36408
	ld a, [wd584]
	cp $6e
	jr z, .asm_363e4
	scf
	ret
.asm_363e4
	ld a, [wPlayerOWObject]
	farcall ResetOWObjectSpriteAnimFlag6
	ld a, $e8
	farcall ResetOWObjectSpriteAnimFlag6
	ld a, $0a
	ld [wd582], a
	ld a, $0d
	ld [wd592], a
	ld hl, $6c36
	ld a, l
	ld [wd593], a
	ld a, h
	ld [$d594], a
	scf
	ret
.ows_36408
	set_npc_position NPC_MIWA, 5, 6
	load_tilemap TILEMAP_0A8, $04, $07
	script_ret
; 0x36412
.ows_36412
	set_npc_position NPC_KEVIN, 3, 4
	load_tilemap TILEMAP_0A7, $02, $05
	script_ret
; 0x3641c
.ows_3641c
	set_npc_position NPC_YOSUKE, 10, 6
	load_tilemap TILEMAP_0A9, $09, $07
	script_ret
; 0x36426
.ows_36426
	set_npc_position NPC_RYOKO, 12, 4
	load_tilemap TILEMAP_0AA, $0b, $05
	script_call .ows_36b76
	script_ret
; 0x36434
; gap from 0x36434 to 0x36b76
; 0x36434