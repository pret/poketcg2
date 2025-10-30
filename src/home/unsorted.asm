SetupSound::
	farcall _SetupSound
	ret

StopMusic::
	xor a ; MUSIC_STOP
PlaySong::
	farcall _PlaySong
	ret

AssertSongFinished::
	farcall _AssertSongFinished
	ret

AssertSFXFinished::
	farcall _AssertSFXFinished
	ret

Func_3071::
	ld a, SFX_04
PlaySFX::
	farcall _PlaySFX
	ret

PauseSong::
	farcall _PauseSong
	ret

ResumeSong::
	farcall _ResumeSong
	ret

SetVolume::
	farcall _SetVolume
	ret

Func_3087::
	ldh a, [hBankROM]
	push af
.loop
	ld a, [wd54c]
	or a
	jr z, .done
	cp $06
	jr c, .ok
	ld a, $01
.ok
	ld l, a
	ld a, $01
	ld [wd54c], a
	ld a, l
	ld hl, PointerTable_30aa
	call JumpToFunctionInTable
	jr .loop
.done
	pop af
	call BankswitchROM
	ret

PointerTable_30aa::
	dw Func_30b6 ; $0
	dw Func_30b6 ; $1
	dw Func_30b7 ; $2
	dw Func_30d6 ; $3
	dw NewGameAndPrologue ; $4
	dw PlayCredits ; $5

Func_30b6::
	ret

Func_30b7::
	ld hl, wd583
	bit 6, [hl]
	jr nz, .asm_30ca
	bit 7, [hl]
	jr nz, .asm_30d1
	ld a, EVENT_02
	farcall GetEventValue
	jr nz, .asm_30d1
.asm_30ca
	ld a, [wd54d]
	farcall Func_d421
.asm_30d1
	farcall Func_d299
	ret

Func_30d6::
	ld a, $02
	ld [wd54c], a
	farcall Func_1e5a2
	jr c, .lost
; won
	ld a, EVENT_SET_UNTIL_MAP_RELOAD_2
	farcall MaxOutEventValue
	ret
.lost
	ld a, EVENT_SET_UNTIL_MAP_RELOAD_2
	farcall ZeroOutEventValue
	ret

NewGameAndPrologue::
	ld a, [wd54d]
	or a
	jr nz, .has_entered_info

	; get player's name and gender
	farcall PlayerGenderAndNameSelection
	ld a, EVENT_PLAYER_GENDER
	farcall GetEventValue
	jr nz, .female
; male
	ld a, NPC_MARK
	ld [wPlayerOWObject], a
	jr .got_info
.female
	ld a, NPC_MINT
	ld [wPlayerOWObject], a

.got_info
	ld a, $04
	ld [wd54c], a
	ld a, $01
	ld [wd54d], a
	ld a, TCG_ISLAND
	ld [wCurIsland], a
	ld a, $0e
	ld [wCurOWLocation], a
	farcall Func_ea30
	ld a, SFX_56
	call PlaySFX
	farcall WaitForSFXToFinish

.has_entered_info
	farcall Prologue
	ld a, TCG_ISLAND
	ld [wCurIsland], a
	ld a, OWMAP_MASON_LABORATORY
	ld [wCurOWLocation], a
	ld a, $02
	ld [wd54c], a
	ld a, $02
	ld [wd54d], a
	call Func_3087
	ret

PlayCredits::
	farcall _PlayCredits
	ld a, $00
	ld [wd54c], a
	ret

Func_3154::
	ld c, a
	ldh a, [hBankROM]
	push af
	ld a, [wd551]
	call BankswitchROM
	ld hl, wd552
	ld a, [hli]
	ld h, [hl]
	ld l, a
	or h
	jr z, .null
.loop
	ld a, [hli]
	cp $ff
	jr z, .not_found
	cp c
	jr z, .found
	inc hl
	inc hl
	jr .loop

.found
	push bc
	call .JumpToHL
	pop bc
	jr nc, .asm_317f
	ld a, c
	farcall Func_c12e
.asm_317f
	pop af
	call BankswitchROM
	scf
	ccf
	ret

.not_found
	ld a, c
	farcall Func_c12e
.null
	pop af
	call BankswitchROM
	scf
	ret

.JumpToHL:
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp hl

Func_3195::
	ld a, [wPlayerOWObject]
	farcall GetOWObjectAnimStruct1Flag0And1
	ld a, b
	xor $02
	ld b, a
	ret

Func_31a1::
	call Func_3332
	call Func_32d8
	ret

Func_31a8::
	call Func_3332
	ld a, [wPlayerOWObject]
	farcall GetOWObjectSpriteAnimFlags
	bit SPRITEANIMSTRUCT_MOVE_F, a
	jr z, .not_moving
	ldh a, [hKeysHeld]
	bit B_PAD_B, a
	jr nz, .b_btn_pressed
	ld a, [wPlayerOWObject]
	farcall GetOWObjectSpeedAndMoveDuration
	ld a, $1
	cp c
	jr z, .done
	ld a, [wPlayerOWObject]
	farcall StopAndGetOWObjectSpeedAndMoveDuration
	sla e
	dec c
	farcall MoveAndSetOWObjectSpeedAndMoveDuration
	jr .done
.b_btn_pressed
	ld a, [wPlayerOWObject]
	farcall GetOWObjectSpeedAndMoveDuration
	ld a, $2
	cp c
	jr z, .done
	bit 0, e
	jr nz, .done
	ld a, [wPlayerOWObject]
	farcall StopAndGetOWObjectSpeedAndMoveDuration
	srl e
	inc c
	farcall MoveAndSetOWObjectSpeedAndMoveDuration
	jr .done

.not_moving
	ld a, $06
	ld [wd582], a
	ld a, [wPlayerOWObject]
	farcall StopOWObjectAnimation
.done
	ret

Func_3205::
.asm_3205
	ld a, [hli]
	cp $ff
	ret z
	push af
	ld a, [hli]
	ld d, a
	ld a, [hli]
	ld e, a
	push de
	ld a, [hli]
	ld b, a
	push bc
	push hl
	ld a, [hli]
	ld h, [hl]
	ld l, a
	or h
	jr z, .asm_321e
	call Func_3233
	jr c, .asm_322c
.asm_321e
	pop hl
	pop bc
	pop de
	pop af
	push hl
	farcall LoadOWObjectInMap
	pop hl
	inc hl
	inc hl
	jr .asm_3205
.asm_322c
	pop hl
	add sp, $06
	inc hl
	inc hl
	jr .asm_3205

Func_3233::
	jp hl

Func_3234::
	ldh a, [hBankROM]
	push af
	call Func_323f
	pop af
	call BankswitchROM
	ret

Func_323f::
	ld hl, wd592
	ld a, [hl]
	call BankswitchROM
	ld hl, wd593
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp hl

Func_324d::
	ld a, [wPlayerOWObject]
	farcall GetOWObjectTilePosition
.asm_3254
	ld a, [hli]
	cp $ff
	jr nz, .asm_325b
	scf
	ret
.asm_325b
	cp d
	jr nz, .asm_3282
	ld a, [hli]
	cp e
	jr nz, .asm_3283
	ldh a, [hBankROM]
	push af
	call .asm_326f
	pop af
	call BankswitchROM
	scf
	ccf
	ret

.asm_326f
	ld a, [hli]
	push af
	ld d, [hl]
	inc hl
	ld e, [hl]
	inc hl
	ld b, [hl]
	inc hl
	ld c, [hl]
	inc hl
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, c
	call BankswitchROM
	pop af
	jp hl
.asm_3282
	inc hl
.asm_3283
	ld a, $07
	add l
	ld l, a
	jr nc, .asm_328a
	inc h
.asm_328a
	jr .asm_3254

Func_328c::
	push hl
	farcall Func_d3e9
	farcall Func_10dfb
	cp $ff
	jr z, .set_carry
	push af
	call Func_3195
	pop af
	farcall SetOWObjectDirection
	pop hl
	call Func_344c
	ret
.set_carry
	pop hl
	scf
	ret

Func_32aa::
	push hl
	farcall Func_d3e9
	farcall Func_10dfb
	cp $ff
	jr z, .set_carry
	pop hl
	call Func_344c
	ret
.set_carry
	pop hl
	scf
	ret

Func_32bf::
	ld a, [wPlayerOWObject]
	farcall GetOWObjectAnimStruct1Flag0And1
	ld a, $00
	cp b
	jr nz, .asm_32d6
	ld a, [wPlayerOWObject]
	farcall GetOWObjectTilePosition
	call Func_324d.asm_3254
	ret
.asm_32d6
	scf
	ret

Func_32d8::
	call Func_32f6
	jr nc, .done
	ldh a, [hKeysPressed]
	bit B_PAD_A, a
	jr nz, .asm_32e9
	bit B_PAD_START, a
	jr nz, .asm_32f0
	jr .done
.asm_32e9
	ld a, $08
	ld [wd582], a
	jr .done
.asm_32f0
	ld a, $12
	ld [wd582], a
.done
	ret

Func_32f6::
	ldh a, [hKeysHeld]
	and PAD_CTRL_PAD
	jr z, .set_carry
	ld b, NORTH
	bit B_PAD_UP, a
	jr nz, .got_direction
	inc b ; EAST
	bit B_PAD_RIGHT, a
	jr nz, .got_direction
	inc b ; SOUTH
	bit B_PAD_DOWN, a
	jr nz, .got_direction
	; B_PAD_LEFT set
	inc b ; WEST
.got_direction
	ld c, 1
	ldh a, [hKeysHeld]
	bit B_PAD_B, a
	jr z, .got_speed
	inc c
.got_speed
	ld a, [wPlayerOWObject]
	farcall Func_10e3c
	or a
	jr z, .set_carry
	ld a, $05
	ld [wd582], a
	ld a, [wPlayerOWObject]
	farcall StartOWObjectAnimation
	scf
	ccf
	jr .exit
.set_carry
	scf
.exit
	ret

Func_3332::
	call DoFrame
	ret

WaitPalFading::
.loop
	call DoFrame
	farcall CheckPalFading
	jr nz, .loop
	ret

Func_3340::
.asm_3340
	call DoFrame
	farcall Func_10df3
	jr z, .asm_3361
	ld a, [wPlayerOWObject]
	farcall GetOWObjectSpriteAnimFlags
	bit 2, a
	jr nz, .asm_3340
	bit SPRITEANIMSTRUCT_ANIMATING_F, a
	jr z, .asm_3340
	ld a, [wPlayerOWObject]
	farcall StopOWObjectAnimation
	jr .asm_3340
.asm_3361
	ld a, [wPlayerOWObject]
	farcall StopOWObjectAnimation
	farcall SetOWObjectFlag5_WithID
	ret

; a = NPC_* ID
Func_336d::
	push af
.loop_wait
	call DoFrame
	farcall GetOWObjectSpriteAnimFlags
	bit SPRITEANIMSTRUCT_MOVE_F, a
	jr z, .done
	pop af
	push af
	jr .loop_wait
.done
	pop af
	ret

; a = NPC_* ID
WaitForOWObjectAnimation::
	push af
.loop
	call DoFrame
	pop af
	push af
	farcall GetOWObjectSpriteAnimFlags
	bit SPRITEANIMSTRUCT_ANIMATING_F, a
	jr nz, .loop
	pop af
	ret

Func_338f::
	push af
	farcall SaveTargetFadePals
	farcall Func_1109f
	call DoFrame
	pop af
	ld b, $00
	farcall StartPalFadeFromBlackOrWhite
	ret

Func_33a3::
	ld b, $00
	farcall StartPalFadeToBlackOrWhite
	call WaitPalFading
	farcall Func_110a8
	ld a, EVENT_EF
	farcall ZeroOutEventValue
	ret

Func_33b7::
	ld a, [wd586]
	ld c, a
	ld b, $00
	sla c
	add c ; *3
	ld c, a
	rl b
	ld hl, MapHeaderPtrs
	add hl, bc
	ld a, [hli]
	ld c, a
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, c
	ld de, wd561
	ld bc, $5
	call CopyFarHLToDE
	ld a, [wd562]
	ld [wd551], a
	ld [wd58b], a
	ld a, [wd563 + 0]
	ld [wd552 + 0], a
	ld [wd58c + 0], a
	ld a, [wd563 + 1]
	ld [wd552 + 1], a
	ld [wd58c + 1], a
	ret

StartScript::
	ld hl, wScriptFlags
	or a
	jr nz, .skip_reset
; reset script vars and stack
	xor a
	ld [wScriptLoadedVar], a
	ld [wScriptLoadedVar + 1], a
	ld [hl], a
	ld a, SCRIPT_STACK_SIZE
	ld [wScriptStackOffset], a
.skip_reset
	res 6, [hl]
	ldh a, [hBankROM]
	ld [wScriptBank], a
	; pop return address from stack
	pop hl
	ld a, l
	ld [wScriptPointer + 0], a
	ld a, h
	ld [wScriptPointer + 1], a
	farcall ReloadScriptBuffer
.script_loop
	farcall RunOverworldScript
	ld a, [wScriptFlags]
	bit 7, a
	jr nz, .script_ended
	bit 6, a
	jr nz, .script_ended
	jr .script_loop
.script_ended
	ld a, [wScriptBank]
	call BankswitchROM
	ld hl, wScriptPointer
	ld a, [hli]
	ld c, a
	ld b, [hl]
	push bc
	ret

; copies b bytes from a:hl to de
CopyFarHLToDE::
	ld [wd678], a
	ldh a, [hBankROM]
	push af
	ld a, [wd678]
	call BankswitchROM
	call CopyDataHLtoDE_SaveRegisters
	pop af
	call BankswitchROM
	ret

; a = NPC_* ID
Func_344c::
	ld c, a
.asm_344d
	ld a, [hli]
	cp $ff
	jr z, .asm_3471
	cp c
	jr nz, .asm_346c
	ldh a, [hBankROM]
	push af
	call .asm_3462
	pop af
	call BankswitchROM
	scf
	ccf
	ret

.asm_3462
	ld a, [hli]
	push af
	ld a, [hli]
	ld h, [hl]
	ld l, a
	pop af
	call BankswitchROM
	jp hl
.asm_346c
	inc hl
	inc hl
	inc hl
	jr .asm_344d
.asm_3471
	scf
	ret

Func_3473::
	push bc
	ld b, a
	ldh a, [hBankROM]
	push af
	ld a, b
	call BankswitchROM
	ld a, [hl]
	ld b, a
	pop af
	call BankswitchROM
	ld a, b
	pop bc
	ret

DivideDEByBC::
	ld hl, 0
	rl e
	rl d
	ld a, 16 ; number of bits
.loop
	ld [wd678], a
	rl l
	rl h
	push hl
	ld a, l
	sub c
	ld l, a
	ld a, h
	sbc b
	ccf
	; carry set if bc < hl
	jr nc, .pop_hl
	ld h, a
	add sp, $2
	scf
	jr .skip_pop_hl
.pop_hl
	pop hl
.skip_pop_hl
	rl e
	rl d
	ld a, [wd678]
	dec a
	jr nz, .loop
	ld a, h
	or l
	ret

WaitAFrames::
.loop
	call DoFrame
	dec a
	jr nz, .loop
	ret

CoreGameLoop::
	farcall _CoreGameLoop
	ret

Func_34be::
	farcall $4, $4000
	ret

WaitForLCDOff::
.loop_wait
	ldh a, [rSTAT]
	and STAT_MODE
	jr nz, .loop_wait
	ret

Func_34ca::
	ld b, $00
.asm_34cc
	sbc c
	jr c, .asm_34d2
	inc b
	jr .asm_34cc
.asm_34d2
	add c
	ret

; outputs result in hl
MultiplyBCByDE::
	push af
	push bc
	push de
	call .Multiply
	pop de
	pop bc
	pop af
	ret

; compares bc and de
; output:
;  carry if bc < de
;  z if bc == de
.CompareBCAndDE:
	ld a, b
	cp d
	ret c
	ret nz
	ld a, c
	cp e
	ret

.Multiply:
	call .CompareBCAndDE
	jr c, .ok
	; bc > de
	; swap bc and de
	push bc
	push de
	pop bc
	pop de
.ok
	; de is larger than bc
	ld hl, 0
	ld a, 16 ; number of bits
.loop
	rr d
	rr e
	jr nc, .asm_34fa
	add hl, bc
.asm_34fa
	sla c
	rl b
	dec a
	jr nz, .loop
	ret

WriteBCBytesToHL::
	push af
	ld a, c
	or b
	jr nz, .write
	pop af
	ret
.write
	pop af
	inc b
.loop
	ld [hli], a
	dec c
	jr nz, .loop
	dec b
	jr nz, .loop
	ret

CopyBCBytesFromHLToDE::
	ld a, c
	or b
	jr nz, .copy
	ret
.copy
	inc b
.loop
	ld a, [hli]
	ld [de], a
	inc de
	dec c
	jr nz, .loop
	dec b
	jr nz, .loop
	ret

SwitchWRAMBank::
	ld [wWRAMBank], a
	ldh [rWBK], a
	ret

DoAFrames_WithPreCheck::
	push af
	and a
	jr z, .done
.loop
	call DoFrame
	dec a
	jr nz, .loop
.done
	pop af
	ret

CallMappedFunction::
	ld c, a
.loop_entries
	ld a, [hli]
	cp $ff
	jr z, .not_found
	cp c
	jr nz, .next
	ldh a, [hBankROM]
	push af
	call .CallFunc
	pop af
	call BankswitchROM
	scf
	ccf
	ret

.CallFunc
	ld a, [hli]
	push af
	ld a, [hli]
	ld h, [hl]
	ld l, a
	pop af
	call BankswitchROM
	jp hl

.next
	inc hl
	inc hl
	inc hl
	jr .loop_entries

.not_found
	scf
	ret

CallHL2::
	jp hl

CallBC::
	push bc
	ret

; divides BC by DE. Stores result in BC and stores remainder in HL
DivideBCbyDE::
	ld hl, $0000
	rl c
	rl b
	ld a, $10
.asm_3568
	ldh [hffc0], a
	rl l
	rl h
	push hl
	ld a, l
	sub e
	ld l, a
	ld a, h
	sbc d
	ccf
	jr nc, .asm_357d
	ld h, a
	add sp, $2
	scf
	jr .asm_357e
.asm_357d
	pop hl
.asm_357e
	rl c
	rl b
	ldh a, [hffc0]
	dec a
	jr nz, .asm_3568
	ret

Func_3588::
	push af
	push bc
	push de
	push hl
	call WriteDataBlockToBGMap0
	pop hl
	pop de
	pop bc
	pop af
	ret

Func_3594::
	push af
	push bc
	push de
	push hl
	call WriteDataBlocksToBGMap0
	pop hl
	pop de
	pop bc
	pop af
	ret

Func_35a0::
	push af
	push bc
	push de
	push hl
	lb de, $40, $7f
	call SetupText
	pop hl
	pop de
	pop bc
	pop af
	ret

; hl = text ID
; de = coordinates
Func_35af::
	push af
	push bc
	push de
	push hl
	xor a
	call BankswitchVRAM
	call InitTextPrinting_ProcessTextFromID
	pop hl
	pop de
	pop bc
	pop af
	ret

Func_35bf::
	push af
	push bc
	push de
	push hl
	xor a
	call BankswitchVRAM
	call PrintTextNoDelay_Init
	pop hl
	pop de
	pop bc
	pop af
	ret

Func_35cf::
	push af
	push bc
	push de
	push hl
	xor a
	call BankswitchVRAM
	call PlaceTextItems
	pop hl
	pop de
	pop bc
	pop af
	ret

; hl = text ID
; de = coordinates
Func_35df::
	call Func_35af
	push bc
	push de
	ld bc, $c0 tiles
	ld de, $40 ; number of tiles
	farcall Func_1c08b
	pop de
	pop bc
	ret

; hl = source
; de = destination
; a = VRAM bank
; c = number of tiles
; if c is $00, copy $100 tiles
CopyTiles::
	push af
	push bc
	push de
	call BankswitchVRAM
	ld a, c
	or a
	jr nz, .not_zero
	ld c, $80
	ld b, TILE_SIZE
	call CopyGfxData
	ld c, $80
.not_zero
	ld b, TILE_SIZE
	call CopyGfxData
	xor a
	call BankswitchVRAM
	pop de
	pop bc
	pop af
	ret

; hl = source
; a = VRAM bank
; b = tile number in Tiles1
; c = number of tiles
CopyTilesToTiles1::
	push af
	push de
	push bc
	push hl
	ld c, b
	ld b, $00
	sla c
	rl b
	sla c
	rl b
	sla c
	rl b
	sla c
	rl b ; *TILE_SIZE
	ld hl, v0Tiles1
	add hl, bc
	ld d, h
	ld e, l
	pop hl
	pop bc
	call CopyTiles
	pop de
	pop af
	ret

; hl = source
; a = VRAM bank
; b = tile number in Tiles0
; c = number of tiles
CopyTilesToTiles0::
	push af
	push de
	push bc
	push hl
	ld c, b
	ld b, $00
	sla c
	rl b
	sla c
	rl b
	sla c
	rl b
	sla c
	rl b
	ld hl, v0Tiles0
	add hl, bc
	ld d, h
	ld e, l
	pop hl
	pop bc
	call CopyTiles
	pop de
	pop af
	ret

; input:
; b:hl = tilemap pointer
Func_365b::
	ldh a, [hBankROM]
	push af
	ld a, b
	call BankswitchROM
	ld b, [hl] ; width
	inc hl
	ld c, [hl] ; height
	inc hl
	ld a, [hli]
	ld h, [hl]
	ld l, a
	pop af
	call BankswitchROM
	ret

; input:
; b:hl = compressed data source
InitDataDecompressionFromBank::
	push bc
	push de
	ldh a, [hBankROM]
	push af
	ld a, b
	call BankswitchROM
	ld d, h
	ld e, l
	ld b, HIGH(wDecompressionSecondaryBuffer)
	call InitDataDecompression
	pop af
	call BankswitchROM
	pop de
	pop bc
	ret

; decompresses data from a given bank
; uses values initialized by InitDataDecompressionFromBank
; input:
; b = source bank
; c = data length
; de = decompressed data address
DecompressDataFromBank::
	push bc
	ldh a, [hBankROM]
	push af
	ld a, b
	call BankswitchROM
	ld b, $00
	call DecompressData
	pop af
	call BankswitchROM
	pop bc
	ret

Func_3698::
	push af
	push bc
	push de
	push hl
	ldh a, [hBankROM]
	push af
	ld a, [wOWAnimBank]
	call BankswitchROM
	ld a, [wOWAnimPtr + 0]
	ld l, a
	ld a, [wOWAnimPtr + 1]
	ld h, a
	or l
	jr z, .done
	ld a, [hli]
	ld c, a
	ld b, $00
	add hl, bc
	ld de, wOWAnimatedTiles
.asm_36b8
	push bc
	push hl
	ld a, [de]
	and a
	jr nz, .asm_3713
	ld a, [hli] ; tile number
	ld c, a
	ld a, [hli] ; VRAM
	ld b, a
	push bc
	ld c, [hl]
	inc hl
	ld b, [hl]
	farcall Func_12c06e
	ld a, b
	ld [wd7e7], a
	pop bc
	ld a, l
	ld [wd7e5 + 0], a
	ld a, h
	ld [wd7e5 + 1], a

	ldh a, [hBankROM]
	push af
	ld a, [wd7e7]
	call BankswitchROM
	push bc
	inc de
	ld a, [de]
	add a
	add a ; *4
	ld c, a
	ld b, $00
	add hl, bc
	pop bc
	push de
.asm_36eb
	inc hl
	ld a, [hld]
	bit 7, a
	jr z, .asm_36fe
	ld a, [wd7e5 + 0]
	ld l, a
	ld a, [wd7e5 + 1]
	ld h, a
	ld a, $00
	ld [de], a
	jr .asm_36eb
.asm_36fe
	ld a, [hli] ; tile index
	ld e, a     ;
	ld a, [hli] ;
	ld d, a
	push hl
	call Func_372d
	pop hl
	pop de
	ld a, [de]
	inc a
	ld [de], a
	dec de
	ld a, [hli]
	inc hl
	ld [de], a
	pop af
	call BankswitchROM
.asm_3713
	ld a, [de]
	dec a
	ld [de], a
	inc de
	inc de
	pop hl
	inc hl
	inc hl
	inc hl
	inc hl
	pop bc
	dec c
	jr z, .done
	jp .asm_36b8
.done
	pop af
	call BankswitchROM
	pop hl
	pop de
	pop bc
	pop af
	ret

; de = tile index
; b = $0 if VRAM1, $1 if VRAM0
; c = destination tile number in VRAM
Func_372d::
	ldh a, [hBankROM]
	push af
	ld a, [wd7de]
	call BankswitchROM
	ld a, [wd7df + 0]
	ld l, a
	ld a, [wd7df + 1]
	ld h, a
	inc hl ; skip length
	inc hl ;
	sla e
	rl d
	sla e
	rl d
	sla e
	rl d
	sla e
	rl d ; *16 (TILE_SIZE)
	add hl, de
	ld a, b
	xor $1
	ld b, c
	ld c, 1
	call CopyTilesToTiles1
	pop af
	call BankswitchROM
	ret

LoadOWAnimatedTiles::
	push af
	push bc
	push de
	push hl
	ldh a, [hBankROM]
	push af
	ld a, [wOWAnimBank]
	call BankswitchROM
	ld a, [wOWAnimPtr + 0]
	ld l, a
	ld a, [wOWAnimPtr + 1]
	ld h, a
	or l
	jr z, .null
	ld de, wOWAnimatedTiles
	ld a, [hli]
	ld c, a
.loop
	ld a, [hli]
	ld [de], a
	inc de
	inc de
	dec c
	jr nz, .loop
.null
	pop af
	call BankswitchROM
	pop hl
	pop de
	pop bc
	pop af
	ret

CopyCGBBGPalsFromSource_BeginWithPal2::
	ld c, 2
	call CopyCGBBGPalsFromSource_WithPalOffset
	ret

Func_3792::
	push af
	push bc
	push de
	push hl
	ldh a, [hBankROM]
	push af
	ld a, b
	call BankswitchROM
	ld a, [hli]
	ld c, a
	ld a, [hli]
	or a
	jr z, .copy
	ld a, [wConsole]
	cp CONSOLE_CGB
	jr nz, .copy
	push hl
	push bc
	ld bc, $1000
	add hl, bc
	pop bc
	ld a, c
	or a
	jr z, .no_copy
	xor a ; BANK("VRAM0")
	ld b, $00
	call CopyTilesToTiles1
.no_copy
	pop hl
	ld c, 0
.copy
	ld a, BANK("VRAM1")
	ld b, $00
	call CopyTilesToTiles1
	pop af
	call BankswitchROM
	pop hl
	pop de
	pop bc
	pop af
	ret

Func_37ce::
	push af
	push bc
	push de
	push hl
	ld a, [wd896]
	ld c, a
	ld a, [wd896 + 1]
	ld b, a
	or c
	jr z, .asm_3823
	farcall CheckPalFading
	jr nz, .asm_3823
	farcall $7, $4941
	cp $02
	jr z, .asm_3823
	ld a, [wd899]
	dec a
	ld [wd899], a
	jr nz, .asm_3823
	ld a, [wd898]
	ld [wd899], a
	farcall GetPaletteGfxPointer
	ldh a, [hBankROM]
	push af
	ld a, b
	call BankswitchROM
	ld a, [hli]
	ld b, a
	ld a, [wd89a]
	ld c, a
	inc a
	cp b
	jr nz, .asm_3810
	xor a
.asm_3810
	ld [wd89a], a
	sla c
	sla c
	sla c
	ld b, $00
	add hl, bc
	call Func_3828
	pop af
	call BankswitchROM
.asm_3823
	pop hl
	pop de
	pop bc
	pop af
	ret

Func_3828::
	ld de, $cb26
	ld b, $08
.asm_382d
	ld a, [hli]
	ld [de], a
	inc de
	dec b
	jr nz, .asm_382d
	call FlushAllPalettes
	ret

BankswitchVRAM::
	call _BankswitchVRAM
	ret

Func_383b::
	push af
	push de
	ld d, b
	ld e, c
	farcall AdjustDECoordByhSC
	ld b, d
	ld c, e
	pop de
	xor a
	call BankswitchVRAM
	push bc
	push de
	ld a, d
	call WriteByteToBGMap0
	ld a, $01
	call BankswitchVRAM
	pop de
	pop bc
	ld a, e
	call WriteByteToBGMap0
	xor a
	call BankswitchVRAM
	pop af
	ret

; b = source bank
; hl = pointer to palette
; c = starting CGB BG pal number
CopyCGBBGPalsFromSource_WithPalOffset::
	ldh a, [hBankROM]
	push af
	ld a, b
	call BankswitchROM
	ld a, [wConsole]
	cp CONSOLE_CGB
	push af
	call z, .CopyCGBBGPals
	pop af
	call nz, .SetGBBGP
	pop af
	call BankswitchROM
	ret

.CopyCGBBGPals::
	push hl
	ld b, $00
	sla c
	sla c
	sla c ; *PAL_SIZE
	ld hl, wBackgroundPalettesCGB
	add hl, bc
	ld d, h
	ld e, l
	pop hl
	ld a, [hli]
	ld c, a
.loop_pals
	ld b, PAL_SIZE
.loop_copy
	ld a, [hli]
	ld [de], a
	inc de
	dec b
	jr nz, .loop_copy
	dec c
	jr nz, .loop_pals
	ret

.SetGBBGP::
	ld a, $e4
	ldh [rBGP], a
	ret

DrawRegularTextBoxVRAM0::
	push af
	push bc
	push de
	push hl
	xor a ; BANK("VRAM0")
	call BankswitchVRAM
	call DrawRegularTextBox
	pop hl
	pop de
	pop bc
	pop af
	ret

DrawLabeledTextBoxVRAM0::
	push af
	push bc
	push de
	push hl
	xor a ; BANK("VRAM0")
	call BankswitchVRAM
	call DrawLabeledTextBox
	pop hl
	pop de
	pop bc
	pop af
	ret

LoadGfxPalettes::
	ldh a, [hBankROM]
	push af
	ld a, b
	call BankswitchROM
	push hl
	ld b, $00
	sla c
	sla c
	sla c ; *PAL_SIZE
	ld hl, wObjectPalettesCGB
	add hl, bc
	ld d, h
	ld e, l
	pop hl
	ld a, [hli]
	ld c, a
	push bc
.loop_pals
	ld b, PAL_SIZE
.loop_copy
	ld a, [hli]
	ld [de], a
	inc de
	dec b
	jr nz, .loop_copy
	dec c
	jr nz, .loop_pals
	pop bc
	pop af
	call BankswitchROM
	ret

LoadGfxFromTileset::
	push bc
	push de
	push hl
	ld a, [wCurVRAMTile]
	push af
	ldh a, [hBankROM]
	push af
	ld a, b
	call BankswitchROM
	ld a, [hli]
	ld c, a
	ld a, [hli] ; unused
	ld a, [wCurVRAMTile]
	ld e, a
.loop_tiles
	push bc
	ld a, e
	and $7f
	ld b, a
	ld c, 1 ; number of tiles
	ld a, e
	and $80
	swap a
	srl a
	srl a
	srl a
	call CopyTilesToTiles0
	pop bc
	inc e
	dec c
	jr nz, .loop_tiles
	ld a, e
	ld [wCurVRAMTile], a
	pop af
	call BankswitchROM
	pop af
	pop hl
	pop de
	pop bc
	ret

; input:
; b:hl = sprite animation pointer
; a = tile offset in VRAM
; c = frame number
; d = x position
; e = y position
Func_3924::
	push af
	push bc
	push de
	push hl
	ld [wd68c], a
	ldh a, [hBankROM]
	push af
	ld a, b
	call BankswitchROM
	ld b, $00
	sla c
	rl b
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, [wd68c]
	ld b, a
	ld a, [hli]
	ld c, a
.loop_oam
	push bc
	push de
	ld a, [hli] ; y
	add e
	ld e, a
	ld a, [wd96f]
	bit SPRITE_ANIM_FLAG_Y_FLIP_F, a
	jr z, .got_y
	ld a, e
	xor $ff
	inc a
	ld e, a
.got_y
	ldh a, [hSCY]
	ld c, a
	ld a, e
	sub c
	ld e, a

	ld a, [hli] ; x
	add d
	ld d, a
	ld a, [wd96f]
	bit SPRITE_ANIM_FLAG_X_FLIP_F, a
	jr z, .got_x
	ld a, d
	xor $ff
	inc a
	ld d, a
.got_x
	ldh a, [hSCX]
	ld c, a
	ld a, d
	sub c
	ld d, a

	ld a, [hli] ; tile index
	add b
	ld c, a

	ld a, [wd96f]
	ld b, a
	ld a, [hli] ; attributes
	xor b
	ld b, a
	ld a, c
	bit 7, a
	jr z, .set_attr
	set B_OAM_BANK1, b
	res 7, c
.set_attr
	call SetOneObjectAttributes
	pop de
	pop bc
	dec c
	jr nz, .loop_oam
	pop af
	call BankswitchROM
	pop hl
	pop de
	pop bc
	pop af
	ret

GetFramesetData::
	push hl
	ldh a, [hBankROM]
	push af
	ld a, b
	call BankswitchROM
	push bc
	ld b, $00
	sla c
	rl b
	sla c
	rl b ; *4
	add hl, bc
	pop bc
	ld c, [hl]
	inc hl
	ld b, [hl]
	inc hl
	ld d, [hl]
	inc hl
	ld e, [hl]
	ld a, [wd970]
	bit 5, a
	jr z, .asm_39ba
	ld a, d
	xor $ff
	inc a
	ld d, a ; d = -d
.asm_39ba
	ld a, [wd970]
	bit 6, a
	jr z, .asm_39c6
	ld a, e
	xor $ff
	inc a
	ld e, a ; e = -e
.asm_39c6
	pop af
	call BankswitchROM
	pop hl
	ret

; hl = list of text IDs
PrintScrollableTextFromList::
	push af
	push hl
.loop_text_ids
	ld a, [hl]
	cp $ff
	jr z, .done
	push hl
	ld a, [hli]
	ld h, [hl]
	ld l, a
	farcall PrintScrollableText_NoTextBoxLabelVRAM0
	pop hl
	inc hl
	inc hl
	jr .loop_text_ids
.done
	pop hl
	pop af
	ret

ResetFrameFunctionStack::
	xor a
	ld [wFrameFunctionStackSize], a
	ret

; hl = new frame function
PushFrameFunction::
	push af
	push bc
	push hl
	ld hl, wFrameFunctionStackSize
	ld a, [hl]
	inc [hl]
	add a
	ld c, a
	ld b, $00
	ld hl, wFrameFunctionStack
	add hl, bc
	ld a, [wDoFrameFunction + 0]
	ld [hli], a
	ld a, [wDoFrameFunction + 1]
	ld [hl], a
	pop hl
	di
	ld a, l
	ld [wDoFrameFunction + 0], a
	ld a, h
	ld [wDoFrameFunction + 1], a
	ei
	pop bc
	pop af
	ret

PopFrameFunction::
	push af
	push bc
	push hl
	ld hl, wFrameFunctionStackSize
	dec [hl]
	ld a, [hl]
	add a
	ld c, a
	ld b, $00
	ld hl, wFrameFunctionStack
	add hl, bc
	di
	ld a, [hli]
	ld [wDoFrameFunction + 0], a
	ld a, [hl]
	ld [wDoFrameFunction + 1], a
	ei
	pop hl
	pop bc
	pop af
	ret

FrameFunc_FadePals::
	push af
	push bc
	push de
	push hl
	farcall FadePalettes
	pop hl
	pop de
	pop bc
	pop af
	ret

Func_3a39::
	push af
	push bc
	push de
	push hl
	farcall UpdateOWScroll
	farcall GetwD8A1
	and a
	jr nz, .asm_3a50
	ld e, $01
	farcall Func_11384
	jr .asm_3a56
.asm_3a50
	ld e, $10
	farcall Func_10ea3
.asm_3a56
	farcall Func_1f57b
	farcall UpdateSpriteAnims
	call Func_3698
	call Func_37ce
	farcall FadePalettes
	pop hl
	pop de
	pop bc
	pop af
	ret

FrameFunc_SpriteAnimationAndFadePals::
	push af
	push bc
	push de
	push hl
	call Func_3f78
	farcall UpdateSpriteAnims
	farcall FadePalettes
	pop hl
	pop de
	pop bc
	pop af
	ret

Func_3a81::
	push af
	push bc
	push de
	push hl
	farcall Func_1e088
	ld a, [wActiveScreenAnim]
	cp $ff
	jr nz, .done
	farcall UpdateSpriteAnims
.done
	pop hl
	pop de
	pop bc
	pop af
	ret

; draws player's portrait at bc
DrawPlayerPortrait::
	push af
	push bc
	push de
	push hl
	farcall GetPlayerPortrait
	add $00
	ld d, b
	ld e, c
	ld c, EMOTION_NORMAL
	ld b, 0
	farcall DrawPortrait
	pop hl
	pop de
	pop bc
	pop af
	ret

; a = *_PIC constant
; bc = coordinates
; e = EMOTION_* constant
DrawNPCPortrait::
	push af
	push bc
	push de
	push hl
	cp MINT_LINK_PIC + 1
	jr nc, .ok
	; Mark and Mint don't have portrait variants
	ld e, EMOTION_NORMAL
.ok
	farcall GetDuelistPortrait
	ld h, e
	ld d, b
	ld e, c
	ld c, h
	ld b, 1
	farcall DrawPortrait
	pop hl
	pop de
	pop bc
	pop af
	ret

; c = EMOTION_* constant
; e = portrait slot (0 or 1)
; b:hl = tileset pointer
LoadPortraitTiles::
	push af
	push bc
	push de
	push hl
	ldh a, [hBankROM]
	push af
	ld a, b
	call BankswitchROM
	inc hl
	inc hl
	push de
	push hl
	ld b, $00
	ld de, 36 tiles
	call MultiplyBCByDE
	ld b, h
	ld c, l
	pop hl
	pop de
	add hl, bc
	ld a, $20
	dec e
	jr nz, .asm_3af2
	add $30
.asm_3af2
	ld b, a
	ld c, 36
	xor a ; BANK("VRAM0")
	call CopyTilesToTiles1
	pop af
	call BankswitchROM
	pop hl
	pop de
	pop bc
	pop af
	ret

LoadPortraitPalettes::
	push af
	push bc
	push de
	ld a, $02
	dec e
	jr nz, .asm_3b0c
	add $03
.asm_3b0c
	ld c, a
	call CopyCGBBGPalsFromSource_WithPalOffset
	pop de
	pop bc
	pop af
	ret

Func_3b14::
	farcall $7, $4379
	ret

Func_3b19::
	farcall $7, $445a
	ret

Func_3b1e::
	push af
	push bc
	push de
	push hl
	farcall Func_ea30
	pop hl
	pop de
	pop bc
	pop af
	ret

; b = bank
; de = coordinates
LoadMenuBoxParams::
	push af
	push bc
	push de
	push hl
	ldh a, [hBankROM]
	push af
	ld a, b
	call BankswitchROM
	farcall AdjustDECoordByhSC
	ld a, d
	ld [wMenuBoxX], a
	ld a, e
	ld [wMenuBoxY], a
	ld a, [hli]
	ld [wMenuBoxSkipClear], a
	ld a, [hli]
	ld [wMenuBoxWidth], a
	ld a, [hli]
	ld [wMenuBoxHeight], a
	ld a, [hli]
	ld [wMenuBoxBlinkSymbol], a
	ld a, [hli]
	ld [wMenuBoxSpaceSymbol], a
	ld a, [hli]
	ld [wMenuBoxCursorSymbol], a
	ld a, [hli]
	ld [wMenuBoxSelectionSymbol], a
	ld a, [hli]
	ld [wMenuBoxPressKeys], a
	ld a, [hli]
	ld [wMenuBoxHeldKeys], a
	ld a, [hli]
	ld [wMenuBoxHasHorizontalScroll], a
	ld a, [hli]
	ld [wMenuBoxVerticalStep], a
	ld a, [hli]
	ld [wMenuBoxUpdateFunction + 0], a
	ld a, [hli]
	ld [wMenuBoxUpdateFunction + 1], a
	ld a, [hli]
	ld [wMenuBoxLabelTextID + 0], a
	ld a, [hli]
	ld [wMenuBoxLabelTextID + 1], a

	ld bc, 0
.loop
	ld a, [hl]
	cp $ff
	jr z, .asm_3bb0
	push bc
	push de
	ld a, [hli]
	add d ; x
	push hl
	ld hl, wMenuBoxItemsXPositions
	add hl, bc
	ld [hl], a
	pop hl
	ld a, [hli]
	add e ; y
	push hl
	ld hl, wMenuBoxItemsYPositions
	add hl, bc
	ld [hl], a
	pop hl
	ld a, [hli]
	ld e, a
	ld a, [hli]
	ld d, a
	push hl
	ld hl, wMenuBoxItemsTextIDs
	sla c
	rl b
	add hl, bc
	ld [hl], e
	inc hl
	ld [hl], d
	pop hl
	pop de
	pop bc
	inc c
	jr .loop

.asm_3bb0
	ld a, c
	ld [wMenuBoxNumItems], a
	xor a
	ld [wMenuBoxDelay], a
	pop af
	call BankswitchROM
	pop hl
	pop de
	pop bc
	pop af
	ret

; a = ?
Func_3bc1::
	push af
	push hl
	ld c, a
	ldh a, [hBankROM]
	push af
	ld a, BANK(Data_13005b)
	call BankswitchROM
	ld b, $00
	sla c
	rl b
	ld hl, Data_13005b
	add hl, bc
	ld c, [hl]
	inc hl
	ld b, [hl]
	pop af
	call BankswitchROM
	pop hl
	pop af
	ret

; e = ?
Func_3be0::
	push af
	push hl
	ldh a, [hBankROM]
	push af
	ld a, b
	call BankswitchROM
	ld b, $00
	sla c ; *2
	add hl, bc
	ld b, [hl]
	inc hl
	ld c, [hl]
	ld a, e
	ld e, c
	srl e
	srl e
.loop
	srl a
	and a
	jr z, .asm_3c00
	sla e
	jr .loop
.asm_3c00
	ld a, c
	and $03
	ld c, a
	pop af
	call BankswitchROM
	pop hl
	pop af
	ret

StartMenuBoxUpdate::
	farcall _StartMenuBoxUpdate
	ret

Func_3c10::
	push af
	push bc
	push de
	push hl
	ldh a, [hBankROM]
	push af
	ld a, b
	call BankswitchROM
	ld c, [hl]
	inc hl
	inc hl
	ld a, BANK("VRAM1")
	ld b, $00
	call CopyTilesToTiles1
	pop af
	call BankswitchROM
	pop hl
	pop de
	pop bc
	pop af
	ret

Func_3c2e::
	push af
	push bc
	push de
	push hl
	ld c, 2
	call CopyCGBBGPalsFromSource_WithPalOffset
	pop hl
	pop de
	pop bc
	pop af
	ret

; PlayDefaultSong in TCG1
StubbedPlayDefaultSong::
	ret

Func_3c3d::
	farcall Func_1def1
	ret

ResetAnimationQueue::
	push af
	call FinishQueuedAnimations
	farcall Func_1dfb9
	farcall Func_110b9
	ld a, $01
	ld [wdc57], a
	pop af
	ret

FinishQueuedAnimations::
	push af
	ld a, [wdc57]
	and a
	jr z, .asm_3c60
	farcall Func_110c2
.asm_3c60
	xor a
	ld [wdc57], a
	ld [wDuelAnimBufferSize], a
	ld [wDuelAnimBufferCurPos], a
	farcall Func_1dfb9
	pop af
	ret

; plays duel animation
; the animations are loaded to a buffer
; and played in order, so they can be stacked
; input:
; - a = animation index
PlayDuelAnimation::
	ld [wCurAnimation], a ; hold an animation temporarily
	call .LoadDuelAnimationToBuffer
	ret

.LoadDuelAnimationToBuffer:
	ldh a, [hBankROM]
	push af
	ld [wDuelAnimReturnBank], a
	farcall _LoadDuelAnimationToBuffer
	pop af
	call BankswitchROM
	ret

; return c if an animation is still playing
CheckAnyAnimationPlaying::
	farcall _CheckAnyAnimationPlaying
	scf
	ret nz
	ccf
	ret

Func_3c8e::
	ld a, [wCurAnimation]
	cp DUEL_ANIM_158_UNUSED
	jr z, .asm_3ca8
	ld a, [wCurAnimation]
	sub $96
	add a
	ld c, a
	ld b, $00
	ld hl, .pointer_table
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp Func_3cc3

.asm_3ca8
	ld a, [wDuelAnimDamage]
	ld l, a
	ld a, [wDuelAnimDamage + 1]
	ld h, a
	jp Func_3cc3

.pointer_table
	dw SetScreenForDuelAnimation ; DUEL_ANIM_SET_SCREEN
	dw PrintDamageText    ; DUEL_ANIM_SHOW_DAMAGE
	dw UpdateMainSceneHUD ; DUEL_ANIM_UPDATE_HUD
	dw DuelAnim153        ; DUEL_ANIM_153_UNUSED
	dw DuelAnim154        ; DUEL_ANIM_154_UNUSED
	dw DuelAnim155        ; DUEL_ANIM_155_UNUSED
	dw DuelAnim156        ; DUEL_ANIM_156_UNUSED
	dw DuelAnim157        ; DUEL_ANIM_157_UNUSED

Func_3cc3::
	ld a, $ff
	ld [wdcf0], a
	ldh a, [hBankROM]
	push af
	ld a, [wDuelAnimReturnBank]
	call BankswitchROM
	call CallHL2
	pop af
	call BankswitchROM
	xor a
	ld [wdcf0], a
	ret

Func_3cdd::
	xor a
	ld [wdd04], a
	ld [wdd05], a
	ret

; a = MUSIC_* constant
SetMusic::
	push bc
	push hl
	ld hl, wdd04
	ld b, [hl]
	cp b
	jr z, .skip
	ld [wdd04], a
	call PlaySong
.skip
	pop hl
	pop bc
	ret

SetNoMusic::
	push af
	xor a
	call SetMusic
	pop af
	ret

CallPlaySFX::
	call PlaySFX
	ret

Func_3d02::
	push af
	xor a
	call CallPlaySFX
	pop af
	ret

Func_3d09::
	call PlaySong
	ret

Func_3d0d::
	push af
	call Func_3d1f
	call PauseSong
	pop af
	ret

Func_3d16::
	push af
	call Func_3d32
	call ResumeSong
	pop af
	ret

Func_3d1f::
	push bc
	ld a, [wdd05]
	ld b, a
	ld a, [wdd06]
	or b
	ld [wdd06], a
	ld a, $ff
	ld [wdd05], a
	pop bc
	ret

Func_3d32::
	xor a
	ld [wdd05], a
	ld [wdd04], a
	ret

Func_3d3a::
	call SetVolume
	ret

WaitForSongToFinish::
	push af
.wait
	call DoFrame
	call AssertSongFinished
	or a
	jr nz, .wait
	pop af
	ret

Func_3d4a::
	ld a, [wdd06]
	and a
	ret

Func_3d4f::
	xor a
	ld [wdd06], a
	ret

Func_3d54::
	push af
	push bc
	push de
	push hl
	farcall $7, $6c38
	pop hl
	pop de
	pop bc
	pop af
	ret

; c = starting CGB BG pal
LoadBGGraphics::
	push af
	push bc
	push de
	ld a, c
	ld [wdd2f], a
	ldh a, [hBankROM]
	push af
	ld a, b
	call BankswitchROM

	; tileset
	ld a, [hli]
	ld c, a
	ld a, [hli]
	ld b, a
	call LoadTileset

	; palette
	ld a, [hli]
	ld c, a
	ld a, [hli]
	ld b, a
	ld a, [wdd2f]
	call LoadBGPalette

	; tilemap
	ld a, [hli]
	ld c, a
	ld a, [hli]
	ld b, a
	farcall LoadAttrmap

	pop af
	call BankswitchROM
	pop de
	pop bc
	pop af
	ret

; bc = TILESET_* constant
LoadTileset::
	push af
	push bc
	push de
	push hl
	farcall GetTilesetGfxPointer
	ldh a, [hBankROM]
	push af
	ld a, b ; source bank
	call BankswitchROM
	ld c, [hl] ; number of tiles
	inc hl
	inc hl
	ld a, BANK("VRAM1")
	ld b, $00 ; starting tile number
	call CopyTilesToTiles1
	pop af
	call BankswitchROM
	pop hl
	pop de
	pop bc
	pop af
	ret

; a = starting CGB BG pal
; bc = PALETTE_* constant
LoadBGPalette::
	push af
	push bc
	push de
	push hl
	ld e, a
	farcall GetPaletteGfxPointer
	ldh a, [hBankROM]
	push af
	ld a, b ; source bank
	call BankswitchROM
	ld c, e
	call CopyCGBBGPalsFromSource_WithPalOffset
	pop af
	call BankswitchROM
	pop hl
	pop de
	pop bc
	pop af
	ret

; input:
; b:hl = object gfx params
; de = coordinates
; a = $00 to overwrite cth object slot
;     $ff to write on next empty object slot
; c = object index to overwrite
CreateSpriteAnim::
	push af
	push bc
	push de
	push hl
	ld [wdd2d], a
	ld a, c
	ld [wdd2e], a
	ldh a, [hBankROM]
	push af
	ld a, b
	call BankswitchROM
	push bc
	push de
	ld de, wdd25
	ld bc, $8
	call CopyDataHLtoDE_SaveRegisters
	pop de
	pop bc
	ld a, [wdd2d]
	cp $ff
	jr z, .get_inactive
	farcall GetCthSpriteAnim
	jr .got_obj
.get_inactive
	farcall GetNextInactiveSpriteAnim
.got_obj
	farcall SetNewSpriteAnimValues
	farcall SetSpriteAnimPosition

	ld a, [wdd25 + 0]
	ld c, a
	ld a, [wdd25 + 1]
	ld b, a
	farcall LoadSpriteAnimGfx
	farcall SetSpriteAnimTileOffset

	ld a, [wdd27 + 0]
	ld c, a
	ld a, [wdd27 + 1]
	ld b, a
	farcall SetSpriteAnimAnimation

	ld a, [wdd29 + 0]
	ld c, a
	ld a, [wdd29 + 1]
	ld b, a
	farcall SetAndInitSpriteAnimFrameset

	ld a, [wdd2b + 0]
	ld c, a
	ld a, [wdd2b + 1]
	ld b, a
	farcall GetPaletteGfxPointer
	ld a, [wdd2e]
	ld c, a
	call LoadGfxPalettes

	pop af
	call BankswitchROM
	pop hl
	ld bc, $8
	add hl, bc
	pop de
	pop bc
	pop af
	ret

Func_3e4f::
	farcall SetSpriteAnimationAndFadePalsFrameFunc
	ret

Func_3e54::
	farcall UnsetSpriteAnimationAndFadePalsFrameFunc
	farcall Func_10d40
	ret

; input
; a = scene ID (SCENE_* constant)
; b = base X position in tiles
; c = base Y position in tiles
EmptyScreenAndLoadScene::
	push af
	farcall ClearSpriteAnimsAndSetInitialGraphicsConfiguration
	call EmptyScreen
	pop af
	call LoadScene
	call FlushAllPalettes
	call EnableLCD
	ret

; input
; a = scene ID (SCENE_* constant)
; b = base X position in tiles
; c = base Y position in tiles
LoadScene::
	farcall _LoadScene
	ret

Func_3e75::
	farcall $7, $6f2a
	ret

Func_3e7a::
	push af
	push bc
	push de
	push hl
	farcall Func_13ac1
	pop hl
	pop de
	pop bc
	pop af
	ret

; apply background scroll for lines 0 to 96 using the values at BGScrollData
; skip if wApplyBGScroll is non-0
ApplyBackgroundScroll::
	push af
	push hl

	ldh a, [rWBK]
	push af
	ld a, BANK("WRAM1")
	ldh [rWBK], a

	call DisableInt_LYCoincidence
	ld hl, rSTAT
	res B_STAT_LYCF, [hl] ; reset coincidence flag
	ei
	ld hl, wApplyBGScroll
	ld a, [hl]
	or a
	jr nz, .done
	inc [hl]
	push bc
	push de
	xor a
	ld [wNextScrollLY], a
.ly_loop
	ld a, [wNextScrollLY]
	ld b, a
.wait_ly
	ldh a, [rLY]
	cp $60
	jr nc, .ly_over_0x60
	cp b ; already hit LY=b?
	jr c, .wait_ly
	call GetNextBackgroundScroll
	ld hl, rSTAT
.wait_hblank_or_vblank
	bit B_STAT_BUSY, [hl]
	jr nz, .wait_hblank_or_vblank
	ldh [rSCX], a
	ldh a, [rLY]
	inc a
	ld [wNextScrollLY], a
	jr .ly_loop
.ly_over_0x60
	xor a
	ldh [rSCX], a
	ld a, $00
	ldh [rLYC], a
	call GetNextBackgroundScroll
	ldh [hSCX], a
	pop de
	pop bc
	xor a
	ld [wApplyBGScroll], a
	call EnableInt_LYCoincidence
.done
	pop af
	ldh [rWBK], a
	pop hl
	pop af
	ret

BGScrollData::
	db  0,  0,  0,  1,  1,  1,  2,  2,  2,  3,  3,  3,  3,  3,  3,  3
	db  4,  3,  3,  3,  3,  3,  3,  3,  2,  2,  2,  1,  1,  1,  0,  0
	db  0, -1, -1, -1, -2, -2, -2, -3, -3, -3, -4, -4, -4, -4, -4, -4
	db -5, -4, -4, -4, -4, -4, -4, -3, -3, -3, -2, -2, -2, -1, -1, -1

; x = BGScrollData[(wVBlankCounter + a) & $3f]
; return, in register a, x rotated right [wBGScrollMod]-1 times (max 3 times)
GetNextBackgroundScroll::
	ld hl, wVBlankCounter
	add [hl]
	and $3f
	ld c, a
	ld b, $00
	ld hl, BGScrollData
	add hl, bc
	ld a, [wBGScrollMod]
	ld c, a
	ld a, [hl]
	dec c
	jr z, .done
	dec c
	jr z, .halve
	dec c
	jr z, .quarter
; effectively zero
	sra a
.quarter
	sra a
.halve
	sra a
.done
	ret

; enable lcdc interrupt on LYC=LC coincidence
EnableInt_LYCoincidence::
	push hl
	ld hl, rSTAT
	set B_STAT_LYC, [hl]
	xor a
	ld hl, rIE
	set B_IE_STAT, [hl]
	pop hl
	ret

; disable lcdc interrupt and the LYC=LC coincidence trigger
DisableInt_LYCoincidence::
	push hl
	ld hl, rSTAT
	res B_STAT_LYC, [hl]
	xor a
	ld hl, rIE
	res B_IE_STAT, [hl]
	pop hl
	ret

; clears wde69
Func_3f61::
	di
	xor a
	ld [wde69 + 0], a
	ld [wde69 + 1], a
	ei
	ret

; sets wde69 to function in hl
Func_3f6b::
	di
	push af
	ld a, l
	ld [wde69 + 0], a
	ld a, h
	ld [wde69 + 1], a
	pop af
	ei
	ret

; jumps to wde69 if not null
Func_3f78::
	push af
	ld hl, wde69
	ld a, [hli]
	or [hl]
	jr nz, .not_null
	pop af
	ret
.not_null
	ld a, [hld]
	ld l, [hl]
	ld h, a
	pop af
	jp hl

Func_3f87::
	ret
