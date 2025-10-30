SECTION "Bank 4@4221", ROMX[$4221], BANK[$4]

; waits until any of the keys
; in register c are pressed
Func_10221:
.loop
	call DoFrame
	ldh a, [hKeysPressed]
	and c
	jr z, .loop
	ret

Func_1022a:
	push af
	push bc
	push de
	push hl
	farcall SetAllBGPaletteFadeConfigsToEnabled
	farcall SetAllOBPaletteFadeConfigsToEnabled
	farcall StartFadeToWhite
	farcall WaitPalFading_Bank07
	call Func_110a8
	call Func_10ea7
	call Func_1059f
	call Func_10d40
	call Func_102ef
	pop hl
	pop de
	pop bc
	pop af
	ret

Func_10252:
	push af
	push bc
	push de
	push hl
	call Func_10d40
	call Func_102ef
	call Func_10ed3
	call Func_105de
	call DisableLCD
	call Func_10b9c
	call Func_1055e
	call UpdateOWScroll
	call EnableLCD
	call Func_1109f
	farcall SetAllBGPaletteFadeConfigsToEnabled
	farcall SetAllOBPaletteFadeConfigsToEnabled
	farcall StartFadeFromWhite
	pop hl
	pop de
	pop bc
	pop af
	ret

; use with FadeToWhiteAndUnsetFrameFunc
SetFrameFuncAndFadeFromWhite:
	call SetSpriteAnimationAndFadePalsFrameFunc
	farcall StartFadeFromWhite
	farcall WaitPalFading_Bank07
	ret

; use with SetFrameFuncAndFadeFromWhite
FadeToWhiteAndUnsetFrameFunc:
	farcall StartFadeToWhite
	farcall WaitPalFading_Bank07
	call UnsetSpriteAnimationAndFadePalsFrameFunc
	ret

ClearSpriteAnimsAndSetInitialGraphicsConfiguration::
	call ClearSpriteAnims
	call SetInitialGraphicsConfiguration
	ret

Func_102a4:
	push af
	push bc
	push de
	push hl
	farcall StartFadeToWhite
	farcall WaitPalFading_Bank07
	call Func_10ea7
	call Func_1059f
	call SetSpriteAnimationAndFadePalsFrameFunc
	call Func_10d40
	call Func_102ef
	pop hl
	pop de
	pop bc
	pop af
	ret

Func_102c4:
	push af
	push bc
	push de
	push hl
	call Func_10d40
	call Func_102ef
	call Func_10ed3
	call Func_105de
	call DisableLCD
	call Func_10b9c
	call Func_1055e
	call UpdateOWScroll
	call EnableLCD
	call UnsetSpriteAnimationAndFadePalsFrameFunc
	farcall StartFadeFromWhite
	pop hl
	pop de
	pop bc
	pop af
	ret

Func_102ef:
	push af
	push bc
	push de
	push hl
	call SetInitialGraphicsConfiguration

	xor a
	ld hl, wOWAnimatedTiles
	ld bc, NUM_OW_ANIMATED_TILES * $4
	call WriteBCBytesToHL

	ld a, $80
	ld hl, wd6d4
	ld bc, $101
	call WriteBCBytesToHL

	xor a
	ld [wd852], a
	ld hl, wd853
	ld bc, $40
	call WriteBCBytesToHL

	call .Func_10327

	xor a
	ld [wd896 + 0], a
	ld [wd896 + 1], a
	pop hl
	pop de
	pop bc
	pop af
	ret

.Func_10327:
	ld a, [wWRAMBank]
	push af
	ld a, BANK("WRAM3")
	call SwitchWRAMBank
	xor a
	ld [w3d400], a
	ld de, w3d000
	ld hl, w3d401
	ld [hl], e
	inc hl
	ld [hl], d
	pop af
	call SwitchWRAMBank
	ret

; de: x, y, bc: width, height
; store bg map data from VRAM0, 1 into WRAM3
CopyBGMapFromVRAMToWRAM:
	push af
	push bc
	push de
	push hl
	ld a, [wWRAMBank]
	push af
	ld a, BANK("WRAM3")
	call SwitchWRAMBank
	push bc
	ld a, [w3d400]
	ld c, a
	ld b, $00
	ld hl, w3d401
	add hl, bc
	add hl, bc
	pop bc
	push hl
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld [hl], d ; x
	inc hl
	ld [hl], e ; y
	inc hl
	ld [hl], b ; width
	inc hl
	ld [hl], c ; height
	inc hl
	push hl
	push bc
	ld b, d ; x
	ld c, e ; y
	call BCCoordToBGMap0Address
	pop bc
	pop de ; WRAM3
.loop
	xor a ; BANK("VRAM0")
	call BankswitchVRAM
	push bc
	push hl
.loop_copy_vram0
	di
	call WaitForLCDOff
	ld a, [hli]
	ld [de], a
	ei
	inc de
	dec b
	jr nz, .loop_copy_vram0
	pop hl
	pop bc
	ld a, BANK("VRAM1")
	call BankswitchVRAM
	push bc
	push hl
.loop_copy_vram1
	di
	call WaitForLCDOff
	ld a, [hli]
	ld [de], a
	ei
	inc de
	dec b
	jr nz, .loop_copy_vram1
	pop hl
	ld bc, TILEMAP_WIDTH
	add hl, bc
	pop bc
	dec c
	jr nz, .loop

	ld hl, w3d400
	inc [hl]
	pop hl
	inc hl
	inc hl
	ld [hl], e
	inc hl
	ld [hl], d
	xor a
	call BankswitchVRAM
	pop af
	call SwitchWRAMBank
	pop hl
	pop de
	pop bc
	pop af
	ret

; restore bg map data from WRAM3 into VRAM0, 1
CopyBGMapFromWRAMToVRAM:
	push af
	push hl
	ld a, [wWRAMBank]
	push af
	ld a, BANK("WRAM3")
	call SwitchWRAMBank
	ld hl, w3d400
	dec [hl]
	ld a, [hl]
	ld c, a
	ld b, $00
	ld hl, w3d401
	add hl, bc
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, [hli] ; x
	ld d, a
	ld a, [hli] ; y
	ld e, a
	ld a, [hli] ; width
	ld b, a
	ld a, [hli] ; height
	ld c, a
	push bc
	push de
	push hl
	push bc
	ld b, d ; x
	ld c, e ; y
	call BCCoordToBGMap0Address
	pop bc
	pop hl
.loop_rows
	push bc
	xor a ; BANK("VRAM0")
	call BankswitchVRAM
	push de
	call SafeCopyDataHLtoDE
	pop de
	ld a, BANK("VRAM1")
	call BankswitchVRAM
	push de
	call SafeCopyDataHLtoDE
	pop de
	push hl
	ld h, d
	ld l, e
	ld bc, TILEMAP_WIDTH
	add hl, bc
	ld d, h
	ld e, l
	pop hl
	pop bc
	dec c
	jr nz, .loop_rows
	xor a ; BANK("VRAM0")
	call BankswitchVRAM
	pop de
	pop bc
	pop af
	call SwitchWRAMBank
	pop hl
	pop af
	ret

SetOWScrollState:
	ld [wOWScrollState], a
	ret

; updates scrolling, depending on wOWScrollState:
; - if $0 then move to target position
;   with wd7e8 = x and wd7e9 = y
; - if $1 then move scroll so that
;   wScrollTargetObject is at the center
UpdateOWScroll::
	push af
	push bc
	push de
	push hl
	ld a, [wOWScrollState]
	inc a
	dec a
	jr nz, .no_target_position
	call .MoveToTargetPosition
	jr .apply_scroll
.no_target_position
	dec a
	jr nz, .apply_scroll
	call .FollowScrollTargetObject
.apply_scroll
	ld a, [wOWScrollX]
	ldh [hSCX], a
	ld a, [wOWScrollY]
	ldh [hSCY], a
	pop hl
	pop de
	pop bc
	pop af
	ret

.FollowScrollTargetObject:
	ld a, [wScrollTargetSpritePtr + 0]
	ld l, a
	ld a, [wScrollTargetSpritePtr + 1]
	ld h, a
	call GetSpriteAnimPosition
	ld a, d
	sub $08
	ld d, a ; x
	ld a, e
	sub $10
	ld e, a ; y

	ld a, d
	cp $40
	ld a, 0
	jr c, .got_x_scroll
	ld a, [wd7dc]
REPT 3
	sla a
ENDR
	sub $a0
	ld b, a
	ld a, d
	sub $40
	cp b
	jr c, .got_x_scroll
	ld a, b
.got_x_scroll
	ld [wOWScrollX], a

	ld a, e
	cp $40
	ld a, 0
	jr c, .got_y_scroll
	ld a, [wd7dd]
REPT 3
	sla a
ENDR
	sub $90
	ld b, a
	ld a, e
	sub $40
	cp b
	jr c, .got_y_scroll
	ld a, b
.got_y_scroll
	ld [wOWScrollY], a
	ret

.MoveToTargetPosition:
	ld a, [wd7e8]
	ld b, a
	ld hl, wOWScrollX
	ld a, [hl]
	cp b
	jr z, .no_x_scroll
	jr c, .incr_x_scroll
; decr x scroll
	dec [hl]
	jr .no_x_scroll
.incr_x_scroll
	inc [hl]
.no_x_scroll
	ld a, [wd7e9]
	ld b, a
	ld hl, wOWScrollY
	ld a, [hl]
	cp b
	jr z, .done
	jr c, .incr_y_scroll
; decr y scroll
	dec [hl]
	jr .done
.incr_y_scroll
	inc [hl]
.done
	ret

; input: d = x_1, e = y_1
; x_2 = [wOWScrollX] * 8 if x_1 bit 7 is set, x_1 otherwise
; y_2 = [wOWScrollY] * 8 if x_1 bit 7 is set, y_1 otherwise
; x_n = [wd7dc] * 8 - $a0, y_n = [wd7dd] * 8 - $90
; output:
; [wd7e8] = min(x_2 * 8, x_n),
; [wd7e9] = min(y_2 * 8, y_n),
; [wOWScrollState] = 0
Func_104ad:
	push af
	push bc
	push de
	ld a, d
	bit 7, a
	jr z, .got_x_base
	ld a, [wOWScrollX]
REPT 3
	srl a
ENDR
; fallthrough
.got_x_base
REPT 3
	add a
ENDR
	ld c, a
	ld a, [wd7dc]
REPT 3
	add a
ENDR
	sub $a0
	ld b, a
	ld a, c
	cp b
	jr c, .got_x
	ld a, b
; fallthrough
.got_x
	ld [wd7e8], a

	ld a, e
	bit 7, a
	jr z, .got_y_base
	ld a, [wOWScrollY]
REPT 3
	srl a
ENDR
; fallthrough
.got_y_base
REPT 3
	add a
ENDR
	ld c, a
	ld a, [wd7dd]
REPT 3
	add a
ENDR
	sub $90
	ld b, a
	ld a, c
	cp b
	jr c, .got_y
	ld a, b
; fallthrough
.got_y
	ld [wd7e9], a
	xor a
	call SetOWScrollState
	pop de
	pop bc
	pop af
	ret

StoreScrollTargetObjectPtr:
	push af
	ld a, l
	ld [wScrollTargetSpritePtr + 0], a
	ld a, h
	ld [wScrollTargetSpritePtr + 1], a
	pop af
	ret

; output:
; [wOWScrollState] = 2
; [wOWScrollX] = d * 8
; [wOWScrollY] = e * 8
CalcOWScroll:
	push af
	ld a, 2
	call SetOWScrollState
	ld a, d
REPT 3
	add a
ENDR
	ld [wOWScrollX], a
	ld a, e
REPT 3
	add a
ENDR
	ld [wOWScrollY], a
	pop af
	ret

; output:
; a = 0 if [wOWScrollState] = 0 AND [wOWScrollX] = [wd7e8] AND [wOWScrollY] = [wd7e9]
; a = 1 otherwise
CheckOWScroll:
	push bc
	ld c, 1
	ld a, [wOWScrollState]
	and a
	jr nz, .got_result
	ld a, [wOWScrollX]
	ld b, a
	ld a, [wd7e8]
	cp b
	jr nz, .got_result
	ld a, [wOWScrollY]
	ld b, a
	ld a, [wd7e9]
	cp b
	jr nz, .got_result
	ld c, 0
; fallthrough
.got_result
	ld a, c
	pop bc
	ret

; output:
; a = [wd6d4 + (e/2)*16 + d/2]
Func_10541:
	push bc
	push de
	push hl
	srl d
	srl e
	ld b, 0
	ld hl, wd6d4
REPT 4
	sla e
ENDR
	ld c, e
	add hl, bc
	ld c, d
	add hl, bc
	ld a, [hl]
	pop hl
	pop de
	pop bc
	ret

Func_1055e:
	push af
	push bc
	push de
	push hl
	ld a, [wOWMap + 0]
	ld c, a
	ld a, [wOWMap + 1]
	ld b, a
	farcall LoadOWMap
	ld a, $00
	ld hl, wOWAnimatedTiles
	ld bc, $64
	call WriteBCBytesToHL
	call LoadOWAnimatedTiles
	ld hl, wd852
	ld a, [hl]
	and a
	jr z, .asm_1059a
	ld c, a
	xor a
	ld [hl], a
	ld hl, wd853
.asm_10589
	push bc
	ld a, [hli]
	ld c, a
	ld a, [hli]
	ld b, a
	ld a, [hli]
	ld d, a
	ld a, [hli]
	ld e, a
	farcall Func_12c0ce
	pop bc
	dec c
	jr nz, .asm_10589
.asm_1059a
	pop hl
	pop de
	pop bc
	pop af
	ret

Func_1059f:
	push af
	push bc
	push de
	push hl
	ld de, w3d415
	ld hl, wOWMap
	ld c, $b1
.loop_copy
	ld b, [hl]
	ld a, [wWRAMBank]
	push af
	ld a, BANK("WRAM3")
	call SwitchWRAMBank
	ld a, b
	ld [de], a
	pop af
	call SwitchWRAMBank
	inc hl
	inc de
	dec c
	jr nz, .loop_copy
	ld a, [wWRAMBank]
	push af
	ld a, BANK("WRAM3")
	call SwitchWRAMBank
	ld bc, $415
	ld de, w3d4c6
	ld hl, w3d000
	call CopyBCBytesFromHLToDE
	pop af
	call SwitchWRAMBank
	pop hl
	pop de
	pop bc
	pop af
	ret

Func_105de:
	push af
	push bc
	push de
	push hl
	ld de, w3d415
	ld hl, wOWMap
	ld c, $b1
.loop_copy
	ld a, [wWRAMBank]
	push af
	ld a, BANK("WRAM3")
	call SwitchWRAMBank
	ld a, [de]
	ld b, a
	pop af
	call SwitchWRAMBank
	ld [hl], b
	inc hl
	inc de
	dec c
	jr nz, .loop_copy
	ld a, [wWRAMBank]
	push af
	ld a, BANK("WRAM3")
	call SwitchWRAMBank
	ld bc, $415
	ld de, w3d000
	ld hl, w3d4c6
	call CopyBCBytesFromHLToDE
	pop af
	call SwitchWRAMBank
	pop hl
	pop de
	pop bc
	pop af
	ret

; input: a, b, c
; output:
; [wd896] = c
; [wd896 + 1] = b
; [wd896 + 2] = [wd896 + 3] = a
; [wd896 + 4] = 0
SetwD896:
	ld [wd896 + 2], a
	ld [wd896 + 3], a
	ld a, c
	ld [wd896], a
	ld a, b
	ld [wd896 + 1], a
	xor a
	ld [wd896 + 4], a
	ret

CopyCGBBGPalsWithID_BeginWithPal2:
	push bc
	farcall GetPaletteGfxPointer
	call CopyCGBBGPalsFromSource_BeginWithPal2
	pop bc
	ret

SetInitialGraphicsConfiguration:
	push af
	push bc
	push de
	push hl
	xor a
	ld [wTileMapFill], a
	bank1call SetOneLineSeparation
	call LoadSymbolsFont
	call Func_35a0
	call SetZeroScroll
	call SafeClearBGMap
	ld a, $01
	ld [wTextBoxFrameType], a
	bank1call SetFontAndTextBoxFrameColor
	farcall EnableBGPFading
	xor a
	call BankswitchVRAM
	pop hl
	pop de
	pop bc
	pop af
	ret

SetFontAndTextBoxFrameColor_PreserveRegisters::
	push af
	push bc
	push de
	push hl
	bank1call SetFontAndTextBoxFrameColor
	pop hl
	pop de
	pop bc
	pop af
	ret

; 0x10672
	ret

; input: de = coord
; return d += [hSCX]/8, e += [hSCY]/8
AdjustDECoordByhSC::
	push af
	ldh a, [hSCX]
	srl a
	srl a
	srl a ; /8
	add d
	ld d, a
	ldh a, [hSCY]
	srl a
	srl a
	srl a ; /8
	add e
	ld e, a
	pop af
	ret

SetZeroScroll:
	push af
	xor a
	ldh [hSCX], a
	ldh [hSCY], a
	pop af
	ret

; safely clears BGMap0 and BGMap1
; of both VRAM0 and VRAM1
SafeClearBGMap:
	push af
	push bc
	push de
	push hl
	ld hl, v0BGMap0
	ld bc, $800
.loop_clear
	xor a
	call BankswitchVRAM
	ei
.wait_lcd_1
	di
	ldh a, [rSTAT]
	and STAT_MODE
	jr nz, .wait_lcd_1
	xor a
	ld [hl], a
	ei
	ld a, BANK("VRAM1")
	call BankswitchVRAM
	ei
.wait_lcd_2
	di
	ldh a, [rSTAT]
	and STAT_MODE
	jr nz, .wait_lcd_2
	xor a
	ld [hli], a
	ei
	dec c
	jr nz, .loop_clear
	dec b
	jr nz, .loop_clear
	xor a
	call BankswitchVRAM
	pop hl
	pop de
	pop bc
	pop af
	ret

; copy 64 bytes from hl to wBackgroundPalettesCGB, then run FlushAllPalettes with a = 7
UpdateBackgroundPalettesCGB_Flush:
	push af
	push bc
	push de
	push hl
	xor a
	ld de, wBackgroundPalettesCGB
	ld bc, NUM_BACKGROUND_PALETTES palettes
	call CopyDataHLtoDE_SaveRegisters
	ld a, 7
	call FlushAllPalettes
	pop hl
	pop de
	pop bc
	pop af
	ret

; copy 64 bytes from hl to wBackgroundPalettesCGB
UpdateBackgroundPalettesCGB:
	push af
	push bc
	push de
	push hl
	ld hl, wBackgroundPalettesCGB
	ld bc, NUM_BACKGROUND_PALETTES palettes
	call CopyDataHLtoDE_SaveRegisters
	pop hl
	pop de
	pop bc
	pop af
	ret

; h = tile index
; l = attributes
; de = coordinates
; b = width
; c = height
FillBoxInBGMap:
	push af
	push bc
	push de
	push hl
	ld a, h
	ld [wd89d], a
	ld a, l
	ld [wd89e], a
	push bc
	ld b, d
	ld c, e
	call BCCoordToBGMap0Address
	pop bc
.loop_rows
	push bc
	push hl
.loop_columns
	xor a
	call BankswitchVRAM
	di
	call WaitForLCDOff
	ld a, [wd89d]
	ld [hl], a
	ei
	ld a, BANK("VRAM1")
	call BankswitchVRAM
	di
	call WaitForLCDOff
	ld a, [wd89e]
	ld [hli], a
	ei
	dec b
	jr nz, .loop_columns
	pop hl
	ld de, TILEMAP_WIDTH
	add hl, de
	pop bc
	dec c
	jr nz, .loop_rows
	xor a
	call BankswitchVRAM
	pop hl
	pop de
	pop bc
	pop af
	ret

; same as ClearBoxInBGMap
; de = coordinates
; b = width
; c = height
FillBoxInBGMapWithZero:
	push hl
	lb hl, $0, $0
	call FillBoxInBGMap
	pop hl
	ret

; sets priority flag in all tiles
; inside a box in BGMap
; d = x
; e = y
; b = width
; c = height
Func_10742:
	push af
	push bc
	push de
	push hl
	push bc
	ld b, d
	ld c, e
	call BCCoordToBGMap0Address
	pop bc
	ld a, BANK("VRAM1")
	call BankswitchVRAM
.loop
	push bc
	push hl
.loop_tiles
	di
	call WaitForLCDOff
	ld a, [hl]
	set 7, a ; priority
	ld [hli], a
	ei
	dec b
	jr nz, .loop_tiles
	pop hl
	ld de, TILEMAP_WIDTH
	add hl, de
	pop bc
	dec c
	jr nz, .loop
	xor a
	call BankswitchVRAM
	pop hl
	pop de
	pop bc
	pop af
	ret
; 0x10772

SECTION "Bank 4@488a", ROMX[$488a], BANK[$4]

ZeroObjectPositionsAndEnableOBPFading:
	push af
	push bc
	push de
	push hl
	call Set_OBJ_8x8
	call ZeroObjectPositions
	ld a, $01
	ld [wVBlankOAMCopyToggle], a
	farcall EnableOBPFading
	pop hl
	pop de
	pop bc
	pop af
	ret
; 0x108a2

SECTION "Bank 4@48c9", ROMX[$48c9], BANK[$4]

SetwD8A1:
	ld [wd8a1], a
	ret

GetwD8A1::
	ld a, [wd8a1]
	ret
; 0x108d1

SECTION "Bank 4@48e6", ROMX[$48e6], BANK[$4]

ClearSpriteAnims:
	push af
	push bc
	push de
	push hl
	xor a
	ld [wCurVRAMTile], a
	ld [wNumSpriteTilesets], a
	ld [wd96f], a
	ld [wd970], a
	ld bc, NUM_SPRITE_ANIM_STRUCTS * SPRITEANIMSTRUCT_LENGTH
	ld hl, wSpriteAnimationStructs
	call WriteBCBytesToHL
	call ZeroObjectPositionsAndEnableOBPFading
	pop hl
	pop de
	pop bc
	pop af
	ret

LoadGfxPalettesFrom0:
	ld c, 0
	call LoadGfxPalettes
	ret

GetNextInactiveSpriteAnim::
	push af
	push bc
	push de
	ld hl, wSpriteAnimationStructs
	ld c, NUM_SPRITE_ANIM_STRUCTS
	ld b, $00 ; unused
	ld de, SPRITEANIMSTRUCT_LENGTH
.loop
	ld a, [hl] ; SPRITEANIMSTRUCT_FLAGS
	bit SPRITEANIMSTRUCT_ACTIVE_F, a
	jr z, .inactive
	add hl, de
	dec c
	jr nz, .loop
	ld hl, NULL
.inactive
	pop de
	pop bc
	pop af
	ret
; 0x1092b

SECTION "Bank 4@4948", ROMX[$4948], BANK[$4]

GetCthSpriteAnim::
	push bc
	sla c
	sla c
	sla c
	sla c ; *16 aka SPRITEANIMSTRUCT_LENGTH
	ld b, $00
	ld hl, wSpriteAnimationStructs
	add hl, bc
	pop bc
	ret

SetNewSpriteAnimValues::
	push af
	push bc
	push de
	push hl
	ld a, SPRITEANIMSTRUCT_ANIMATING | SPRITEANIMSTRUCT_FLAG6 | SPRITEANIMSTRUCT_ACTIVE
	call SetSpriteAnimFlags
	xor a
	lb bc, $0, $0
	lb de, $0, $0
	call StubSetSpriteAnimValue
	call SetSpriteAnimPosition
	call SetSpriteAnimFrameIndex
	call SetSpriteAnimOWFrameGroup
	call SetSpriteAnimFrameDuration
	call SetSpriteAnimTileOffset
	call SetSpriteAnimAnimation
	call SetSpriteAnimMoveDuration
	call SetSpriteAnimStartDelay
	pop hl
	pop de
	pop bc
	pop af
	ret

Func_10989:
	ld [wd96f], a
	ret

Func_1098d:
	ld [wd970], a
	ret

MoveSpriteAnim:
	push af
	push bc
	push de
	push hl
	bit SPRITEANIMSTRUCT_MOVE_F, [hl] ; SPRITEANIMSTRUCT_FLAGS
	jr z, .done
	push hl
	ld a, [hl] ; SPRITEANIMSTRUCT_FLAGS
	and SPRITEANIMSTRUCT_DIR_MASK
	ld b, a
	srl b
	ld a, [hl] ; SPRITEANIMSTRUCT_FLAGS
	and SPRITEANIMSTRUCT_SPEED
	inc a
	ld c, a
	inc hl
	inc hl
	inc hl
	ld d, [hl] ; SPRITEANIMSTRUCT_X_POS
	inc hl
	ld e, [hl] ; SPRITEANIMSTRUCT_Y_POS
	inc b
	dec b
	jr nz, .right

; up
; b == 0
	; y -= c
	ld a, e
	sub c
	ld e, a

.right
	dec b
	jr nz, .down
; b == 1
	; x += c
	ld a, d
	add c
	ld d, a

.down
	dec b
	jr nz, .left
; b == 2
	; y += c
	ld a, e
	add c
	ld e, a

.left
	dec b
	jr nz, .up_right
; b == 3
	; x -= c
	ld a, d
	sub c
	ld d, a

.up_right
	dec b
	jr nz, .down_right
; b == 4
	; x += c
	; y -= c
	ld a, d
	add c
	ld d, a
	ld a, e
	sub c
	ld e, a

.down_right
	dec b
	jr nz, .down_left
; b == 5
	; x += c
	; y += c
	ld a, d
	add c
	ld d, a
	ld a, e
	add c
	ld e, a

.down_left
	dec b
	jr nz, .up_left
; b == 6
	; x -= c
	; y += c
	ld a, d
	sub c
	ld d, a
	ld a, e
	add c
	ld e, a

.up_left
	dec b
	jr nz, .apply_offset
; b == 7
	; x -= c
	; y -= c
	ld a, d
	sub c
	ld d, a
	ld a, e
	sub c
	ld e, a

.apply_offset
	ld [hl], e ; SPRITEANIMSTRUCT_Y_POS
	dec hl
	ld [hl], d ; SPRITEANIMSTRUCT_X_POS
	ld bc, SPRITEANIMSTRUCT_MOVE_DURATION - SPRITEANIMSTRUCT_X_POS
	add hl, bc
	dec [hl] ; SPRITEANIMSTRUCT_MOVE_DURATION
	pop hl
	jr nz, .done
	res SPRITEANIMSTRUCT_MOVE_F, [hl] ; SPRITEANIMSTRUCT_FLAGS
.done
	pop hl
	pop de
	pop bc
	pop af
	ret

UpdateSpriteAnims::
	push af
	push bc
	push de
	push hl
	call ZeroObjectPositions
	ld hl, wSpriteAnimationStructs
	ld c, NUM_SPRITE_ANIM_STRUCTS
.loop_objs
	call MoveSpriteAnim
	farcall UpdateSpriteAnim
	ld de, SPRITEANIMSTRUCT_LENGTH
	add hl, de
	dec c
	jr nz, .loop_objs
	ld a, $01
	ld [wVBlankOAMCopyToggle], a
	pop hl
	pop de
	pop bc
	pop af
	ret

; d = x coordinate
; e = y coordinate
SetSpriteAnimPosition::
	push hl
REPT SPRITEANIMSTRUCT_X_POS
	inc hl
ENDR
	ld [hl], d ; SPRITEANIMSTRUCT_X_POS
	inc hl
	ld [hl], e ; SPRITEANIMSTRUCT_Y_POS
	pop hl
	ret

; get x coordinate in d, y in e
GetSpriteAnimPosition:
	push hl
REPT SPRITEANIMSTRUCT_X_POS
	inc hl
ENDR
	ld d, [hl] ; SPRITEANIMSTRUCT_X_POS
	inc hl
	ld e, [hl] ; SPRITEANIMSTRUCT_Y_POS
	pop hl
	ret

; b = direction
SetSpriteAnimDirection::
	push af
	push bc
	push de
	push hl
	inc hl
	ld a, [hl] ; SPRITEANIMSTRUCT_1
	and SPRITE_ANIM_STRUCT1_FLAG0 | SPRITE_ANIM_STRUCT1_FLAG1
	cp b
	jr z, .exit
	ld a, [hl] ; SPRITEANIMSTRUCT_1
	and ~(SPRITE_ANIM_STRUCT1_FLAG0 | SPRITE_ANIM_STRUCT1_FLAG1)
	or b
	ld [hl], a
	ld de, SPRITEANIMSTRUCT_FRAME_INDEX - SPRITEANIMSTRUCT_1
	add hl, de
	xor a
	ld [hli], a ; SPRITEANIMSTRUCT_FRAME_INDEX
	push hl
	ld de, SPRITEANIMSTRUCT_OW_FRAMEGROUP - SPRITEANIMSTRUCT_FRAMESET_ID
	add hl, de
	ld a, b
	ld c, [hl] ; SPRITEANIMSTRUCT_OW_FRAMEGROUP
	inc hl
	ld b, [hl]
	farcall GetOWObjectFrameset
	pop hl
	ld [hl], c ; SPRITEANIMSTRUCT_FRAMESET_ID
	inc hl
	ld [hl], b
.exit
	pop hl
	pop de
	pop bc
	pop af
	ret

GetSpriteAnimStruct1Flag0And1:
	push af
	push hl
	inc hl
	ld a, [hl] ; SPRITEANIMSTRUCT_1
	and SPRITE_ANIM_STRUCT1_FLAG0 | SPRITE_ANIM_STRUCT1_FLAG1
	ld b, a
	pop hl
	pop af
	ret

; b = direction
; c = speed
; e = move duration
SetSpriteAnimMotion:
	push af
	push bc
	push de
	push hl
	bit SPRITEANIMSTRUCT_MOVE_F, [hl]
	jr nz, .done
	dec c
	ld a, [hl]
	and SPRITEANIMSTRUCT_ANIMATING | SPRITEANIMSTRUCT_FLAG6 | SPRITEANIMSTRUCT_ACTIVE
	or SPRITEANIMSTRUCT_MOVE
	sla b
	or b
	or c
	ld [hl], a
	ld bc, SPRITEANIMSTRUCT_MOVE_DURATION - SPRITEANIMSTRUCT_FLAGS
	add hl, bc
	ld [hl], e
.done
	pop hl
	pop de
	pop bc
	pop af
	ret

; clear the move flag of sprite anim at hl
; return c = 2 if the speed flag is set, 1 if not
; also e = move duration
StopAndGetSpriteAnimSpeedAndMoveDuration:
	push af
	push hl
	res SPRITEANIMSTRUCT_MOVE_F, [hl]
	ld a, [hl] ; SPRITEANIMSTRUCT_FLAGS
	and SPRITEANIMSTRUCT_SPEED
	inc a
	ld c, a
	ld de, SPRITEANIMSTRUCT_MOVE_DURATION - SPRITEANIMSTRUCT_FLAGS
	add hl, de
	ld e, [hl]
	pop hl
	pop af
	ret

; set the move flag of sprite anim at hl
; set the speed flag if c = 2, unset if c = 1
; set move duration from e
MoveAndSetSpriteAnimSpeedAndMoveDuration:
	push af
	push bc
	push hl
	dec c
	set SPRITEANIMSTRUCT_MOVE_F, [hl]
	ld a, [hl] ; SPRITEANIMSTRUCT_FLAGS
	and ~SPRITEANIMSTRUCT_SPEED
	or c
	ld [hl], a
	ld bc, SPRITEANIMSTRUCT_MOVE_DURATION - SPRITEANIMSTRUCT_FLAGS
	add hl, bc
	ld [hl], e
	pop hl
	pop bc
	pop af
	ret

GetSpriteAnimSpeedAndMoveDuration:
	push af
	push hl
	ld a, [hl]
	and SPRITEANIMSTRUCT_SPEED
	ld c, a
	inc c
	ld de, SPRITEANIMSTRUCT_MOVE_DURATION - SPRITEANIMSTRUCT_FLAGS
	add hl, de
	ld e, [hl]
	pop hl
	pop af
	ret

Func_10ab7:
	ld a, [hl]
	ret

ResetSpriteAnimFlag6:
	res SPRITEANIMSTRUCT_FLAG6_F, [hl]
	ret

SetSpriteAnimFlag6:
	set SPRITEANIMSTRUCT_FLAG6_F, [hl]
	ret

; de: x_0, y_0
; bc: x_1, y_1
; reset flag 6 for each active sprite anim if its x, y satisfy
; x_0 + 1 <= x/8 < x_0 + x_1 + 1 and y_0 + 2 <= y/8 < y_0 + y_1 + 2
ResetActiveSpriteAnimFlag6WithinArea:
	push af
	push bc
	push de
	push hl
	inc d
	inc e
	inc e
	ld a, d
	add b
	ld b, a ; (d + 1 + b)
	ld a, e
	add c
	ld c, a ; (e + 2 + c)

	ld hl, wSpriteAnimationStructs
	ld a, NUM_SPRITE_ANIM_STRUCTS
.loop_sprite_anims
	push af
	push hl
	ld a, [hl] ; SPRITEANIMSTRUCT_FLAGS
	and SPRITEANIMSTRUCT_ACTIVE
	jr z, .next_sprite_anim
	inc hl
	inc hl
	inc hl
	ld a, [hli] ; SPRITEANIMSTRUCT_X_POS
	srl a
	srl a
	srl a ; /8
	cp d
	jr c, .next_sprite_anim
	ld a, [hld] ; SPRITEANIMSTRUCT_Y_POS
	srl a
	srl a
	srl a ; /8
	cp e
	jr c, .next_sprite_anim
	ld a, [hli] ; SPRITEANIMSTRUCT_X_POS
	srl a
	srl a
	srl a ; /8
	cp b
	jr nc, .next_sprite_anim
	ld a, [hld] ; SPRITEANIMSTRUCT_Y_POS
	srl a
	srl a
	srl a ; /8
	cp c
	jr nc, .next_sprite_anim
	dec hl
	dec hl
	dec hl
	res SPRITEANIMSTRUCT_FLAG6_F, [hl] ; SPRITEANIMSTRUCT_FLAGS
.next_sprite_anim
	pop hl
	push bc
	ld bc, SPRITEANIMSTRUCT_LENGTH
	add hl, bc
	pop bc
	pop af
	dec a
	jr nz, .loop_sprite_anims
	pop hl
	pop de
	pop bc
	pop af
	ret

; de: x_0, y_0
; bc: x_1, y_1
; set flag 6 for each active sprite anim if its x, y satisfy
; x_0 + 1 <= x/8 < x_0 + x_1 + 1 and y_0 + 2 <= y/8 < y_0 + y_1 + 2
SetActiveSpriteAnimFlag6WithinArea:
	push af
	push bc
	push de
	push hl
	inc d
	inc e
	inc e
	ld a, d
	add b
	ld b, a ; (d + 1 + b)
	ld a, e
	add c
	ld c, a ; (e + 2 + c)

	ld hl, wSpriteAnimationStructs
	ld a, NUM_SPRITE_ANIM_STRUCTS
.loop_sprite_anims
	push af
	push hl
	ld a, [hl] ; SPRITEANIMSTRUCT_FLAGS
	and SPRITEANIMSTRUCT_ACTIVE
	jr z, .next_sprite_anim
	inc hl
	inc hl
	inc hl
	ld a, [hli] ; SPRITEANIMSTRUCT_X_POS
	srl a
	srl a
	srl a ; /8
	cp d
	jr c, .next_sprite_anim
	ld a, [hld] ; SPRITEANIMSTRUCT_Y_POS
	srl a
	srl a
	srl a ; /8
	cp e
	jr c, .next_sprite_anim
	ld a, [hli] ; SPRITEANIMSTRUCT_X_POS
	srl a
	srl a
	srl a ; /8
	cp b
	jr nc, .next_sprite_anim
	ld a, [hld] ; SPRITEANIMSTRUCT_Y_POS
	srl a
	srl a
	srl a ; /8
	cp c
	jr nc, .next_sprite_anim
	dec hl
	dec hl
	dec hl
	set SPRITEANIMSTRUCT_FLAG6_F, [hl] ; SPRITEANIMSTRUCT_FLAGS
.next_sprite_anim
	pop hl
	push bc
	ld bc, SPRITEANIMSTRUCT_LENGTH
	add hl, bc
	pop bc
	pop af
	dec a
	jr nz, .loop_sprite_anims
	pop hl
	pop de
	pop bc
	pop af
	ret

; just clear the current [hl]
_ClearSpriteAnimFlags:
	push af
	xor a
	ld [hl], a ; SPRITEANIMSTRUCT_FLAGS
	pop af
	ret

; input: sprite anim x_pos in d, y_pos in e
; output: d -= 8, e -= 16
ConvertToOWObjectPosition:
	push af
	ld a, d
	sub $08
	ld d, a
	ld a, e
	sub $10
	ld e, a
	pop af
	ret

; input: sprite anim x_pos in d, y_pos in e
; output: d = (d - 8) >> 4, e = (e - 16) >> 4
ConvertToOWObjectTilePosition:
	push af
	ld a, d
	sub $08
	ld d, a
REPT 4
	srl d
ENDR
	ld a, e
	sub $10
	ld e, a
REPT 4
	srl e
ENDR
	pop af
	ret

; load all sprite tilesets and their sprite anim gfx
; also clear wNumSpriteTilesets and wCurVRAMTile
Func_10b9c:
	push af
	push bc
	push de
	push hl
	ld a, [wNumSpriteTilesets]
	ld c, a
	xor a
	ld [wNumSpriteTilesets], a
	ld [wCurVRAMTile], a
	ld hl, wSpriteTilesets
.loop
	push bc
	ld a, [hli] ;  LOW(OBJTILESTRUCT_ID)
	ld c, a
	ld a, [hld] ; HIGH(OBJTILESTRUCT_ID)
	ld b, a
	farcall LoadSpriteAnimGfx
REPT OBJTILESTRUCT_LENGTH
	inc hl
ENDR
	pop bc
	dec c
	jr nz, .loop
	pop hl
	pop de
	pop bc
	pop af
	ret

GetSpriteAnimBuffer:
	ld hl, wSpriteAnimationStructs
	ret

SetSpriteAnimAnimating:
	set SPRITEANIMSTRUCT_ANIMATING_F, [hl]
	ret

ResetSpriteAnimAnimating:
	res SPRITEANIMSTRUCT_ANIMATING_F, [hl]
	ret
; 0x10bce

SECTION "Bank 4@4be7", ROMX[$4be7], BANK[$4]

; push to w3d8db
; wSpriteAnimationStructs, wCurVRAMTile, wNumSpriteTilesets, wSpriteTilesets
PushSpriteAnimTileToBank3:
	ei
	di
	push af
	push bc
	push de
	push hl
	ld de, w3d8db
	ld hl, wSpriteAnimationStructs
	ld c, SPRITE_ANIM_TILE_BUFFER_SIZE
.copy_loop
	ld b, [hl]
	ld a, [wWRAMBank]
	push af
	ld a, BANK("WRAM3")
	call SwitchWRAMBank
	ld a, b
	ld [de], a
	pop af
	call SwitchWRAMBank
	inc hl
	inc de
	dec c
	jr nz, .copy_loop
	pop hl
	pop de
	pop bc
	pop af
	ei
	ret

; pull from w3d8db
; wSpriteAnimationStructs, wCurVRAMTile, wNumSpriteTilesets, wSpriteTilesets
PullSpriteAnimTileFromBank3:
	ei
	di
	push af
	push bc
	push de
	push hl
	ld de, w3d8db
	ld hl, wSpriteAnimationStructs
	ld c, SPRITE_ANIM_TILE_BUFFER_SIZE
.copy_loop
	ld a, [wWRAMBank]
	push af
	ld a, BANK("WRAM3")
	call SwitchWRAMBank
	ld a, [de]
	ld b, a
	pop af
	call SwitchWRAMBank
	ld [hl], b
	inc hl
	inc de
	dec c
	jr nz, .copy_loop
	pop hl
	pop de
	pop bc
	pop af
	ei
	ret

; returns nz if sprite anim in hl is animating
CheckIsSpriteAnimAnimating:
	bit SPRITEANIMSTRUCT_ANIMATING_F, [hl]
	ret
; 0x10c3c

SECTION "Bank 4@4c5a", ROMX[$4c5a], BANK[$4]

; bc = FRAMESET_* constant
SetAndInitSpriteAnimFrameset::
	push af
	push de
	push hl
	ld de, SPRITEANIMSTRUCT_FRAME_INDEX
	add hl, de
	xor a
	ld [hli], a ; SPRITEANIMSTRUCT_FRAME_INDEX
	ld [hl], c ; SPRITEANIMSTRUCT_FRAMESET_ID
	inc hl
	ld [hl], b
	inc hl
	ld [hl], a ; SPRITEANIMSTRUCT_FRAME_DURATION
	pop hl
	pop de
	pop af
	ret

SetSpriteAnimFrameset:
	push af
	push de
	push hl
	ld de, SPRITEANIMSTRUCT_FRAMESET_ID
	add hl, de
	ld [hl], c ; SPRITEANIMSTRUCT_FRAMESET_ID
	inc hl
	ld [hl], b
	pop hl
	pop de
	pop af
	ret

; bc = OWFRAMEGROUP_*
SetSpriteAnimOWFrameGroup::
	push af
	push bc
	push de
	push hl
	inc hl
	ld a, [hl] ; SPRITEANIMSTRUCT_1
	and $fc
	ld [hl], a
	ld de, SPRITEANIMSTRUCT_OW_FRAMEGROUP - SPRITEANIMSTRUCT_1
	add hl, de
	ld [hl], c ; SPRITEANIMSTRUCT_OW_FRAMEGROUP
	inc hl
	ld [hl], b
	farcall GetOWObjectFrameset
	pop hl
	call SetAndInitSpriteAnimFrameset
	pop de
	pop bc
	pop af
	ret

SetSpriteAnimStartDelay:
	push bc
	push hl
	ld bc, SPRITEANIMSTRUCT_START_DELAY
	add hl, bc
	ld [hl], a ; SPRITEANIMSTRUCT_START_DELAY
	pop hl
	pop bc
	ret

SetSpriteAnimFlags:
	ld [hl], a ; SPRITEANIMSTRUCT_FLAGS
	ret

StubSetSpriteAnimValue:
	ret

SetSpriteAnimFrameDuration:
	push bc
	push hl
	ld bc, SPRITEANIMSTRUCT_FRAME_DURATION
	add hl, bc
	ld [hl], a ; SPRITEANIMSTRUCT_FRAME_DURATION
	pop hl
	pop bc
	ret

SetSpriteAnimTileOffset::
	push bc
	push hl
	ld bc, SPRITEANIMSTRUCT_TILE_OFFSET
	add hl, bc
	ld [hl], a ; SPRITEANIMSTRUCT_TILE_OFFSET
	pop hl
	pop bc
	ret

SetSpriteAnimFrameIndex:
	push bc
	push hl
	ld bc, SPRITEANIMSTRUCT_FRAME_INDEX
	add hl, bc
	ld [hl], a ; SPRITEANIMSTRUCT_FRAME_INDEX
	pop hl
	pop bc
	ret

SetSpriteAnimMoveDuration:
	push bc
	push hl
	ld bc, SPRITEANIMSTRUCT_MOVE_DURATION
	add hl, bc
	ld [hl], a ; SPRITEANIMSTRUCT_MOVE_DURATION
	pop hl
	pop bc
	ret

; bc = SPRITE_ANIM_* constant
SetSpriteAnimAnimation::
	push bc
	push hl
	push bc
	ld bc, SPRITEANIMSTRUCT_ANIM_ID
	add hl, bc
	pop bc
	ld [hl], c ; SPRITEANIMSTRUCT_ANIM_ID
	inc hl
	ld [hl], b
	pop hl
	pop bc
	ret
; 0x10cd9

SECTION "Bank 4@4cfe", ROMX[$4cfe], BANK[$4]

Stub_10cfe:
	ret
; 0x10cff

SECTION "Bank 4@4d17", ROMX[$4d17], BANK[$4]

; input:
; - b: ? (would make sense if $0/$1)
; - hl: OW obj anim pointer
; update its SPRITEANIMSTRUCT_1 by clearing bit 2 and then OR (b*4)
_SetSpriteAnimStruct1Flag2:
	push af
	push bc
	push hl
	sla b
	sla b ; *4
	inc hl
	ld a, [hl] ; SPRITEANIMSTRUCT_1
	and ~SPRITE_ANIM_STRUCT1_FLAG2
	or b
	ld [hl], a
	pop hl
	pop bc
	pop af
	ret

; return, in bit 0 of b, bit 2 of SPRITEANIMSTRUCT_1 of anim pointer at hl
_GetSpriteAnimStruct1Flag2:
	push af
	push hl
	inc hl
	ld a, [hl] ; SPRITEANIMSTRUCT_1
	and SPRITE_ANIM_STRUCT1_FLAG2
	ld b, a
	srl b
	srl b ; /4
	pop hl
	pop af
	ret

GetPalettesWithID:
	push bc
	farcall GetPaletteGfxPointer
	call LoadGfxPalettesFrom0
	pop bc
	ret

Func_10d40::
	call InitOWObjects
	ld a, 1
	call SetwD8A1
	call FillwD986
	ret

GetNextInactiveOWObject:
	call _GetNextInactiveOWObject
	ret

GetOWObjectWithID:
	call _GetOWObjectWithID
	ret

GetOWObjectSpriteAnim:
	call _GetOWObjectSpriteAnim
	ret

GetOWObjectSpriteAnimFlags::
	call _GetOWObjectSpriteAnimFlags
	ret

; input: x in d, y in e
; output: d = (d << 4) + 8, e = (e << 4) + 16
ConvertFromTileToSpriteAnimPosition:
	push af
	ld a, d
REPT 4
	sla a
ENDR
	add $08
	ld d, a
	ld a, e
REPT 4
	sla a
ENDR
	add $10
	ld e, a
	pop af
	ret

; a = NPC_* constant
LoadOWObjectInMap::
	push af
	push bc
	push de
	push hl
REPT 4 ; *16
	sla d
ENDR
REPT 4 ; *16
	sla e
ENDR
	call LoadOWObject
	call IsStillOWObject
	jr c, .still_object

; apply a random animation duration
; to the object so that NPCs in a map
; appear out of phase
	push af
	call UpdateRNGSources
	and $f
	ld c, a
	pop af
	call SetOWObjectFrameDuration

.still_object
	pop hl
	pop de
	pop bc
	pop af
	ret

ClearOWObject:
	call _ClearOWObject
	ret

GetOWObjectTilePosition::
	push af
	push hl
	call _GetOWObjectWithID
	call GetOWObjectSpriteAnim
	call GetSpriteAnimPosition
	call ConvertToOWObjectTilePosition
	pop hl
	pop af
	ret

SetOWObjectTilePosition:
	push af
	push de
	push hl
	call _GetOWObjectWithID
	call GetOWObjectSpriteAnim
	call ConvertFromTileToSpriteAnimPosition
	call SetSpriteAnimPosition
	pop hl
	pop de
	pop af
	ret

GetOWObjectAnimStruct1Flag0And1::
	call _GetOWObjectAnimStruct1Flag0And1
	ret

; a = NPC_* constant (ow_object)
; b = direction
SetOWObjectDirection::
	call _SetOWObjectDirection
	ret

StartOWObjectAnimation::
	call SetOWObjectSpriteAnimating
	ret

StopOWObjectAnimation::
	call ResetOWObjectSpriteAnimating
	ret

SetOWObjectSpriteAnimFlag6:
	call _SetOWObjectSpriteAnimFlag6
	ret

ResetOWObjectSpriteAnimFlag6:
	call _ResetOWObjectSpriteAnimFlag6
	ret

StopAndGetOWObjectSpeedAndMoveDuration::
	call _StopAndGetOWObjectSpeedAndMoveDuration
	ret

MoveAndSetOWObjectSpeedAndMoveDuration::
	call _MoveAndSetOWObjectSpeedAndMoveDuration
	ret

GetOWObjectSpeedAndMoveDuration::
	call _GetOWObjectSpeedAndMoveDuration
	ret

; a = NPC_* ID
Func_10def:
	call Func_11367
	ret

Func_10df3::
	call Func_113d2
	ret

CheckOWObjectPointerWithID:
	call _CheckOWObjectPointerWithID
	ret

; outputs NPC ID of OW object that is
; in the grid position de
; if no object, then output $ff
Func_10dfb::
	push bc
	push de
	push hl
	ld a, $ff
	ld [wd987], a

	call GetOWObjectsPointer
	ld c, MAX_NUM_OW_OBJECTS
.loop
	push bc
	push de
	push hl
	bit ACTIVE_OBJ_F, [hl]
	jr z, .next
	inc hl
	ld a, [hli] ; OWOBJSTRUCT_ID
	ld b, a
	push bc
	ld b, d
	ld c, e
	ld a, [hli] ; OWOBJSTRUCT_ANIM_PTR
	ld h, [hl]  ;
	ld l, a
	call GetSpriteAnimPosition
	pop hl
	call ConvertToOWObjectTilePosition
	ld a, d
	cp b
	jr nz, .next
	ld a, e
	cp c
	jr nz, .next
	ld a, h
	ld [wd987], a
.next
	pop hl
	pop de
	ld bc, OWOBJSTRUCT_LENGTH
	add hl, bc
	pop bc
	dec c
	jr nz, .loop

	ld a, [wd987]
	pop hl
	pop de
	pop bc
	ret

; a = NPC_* ID
; b = direction
; c = speed
Func_10e3c::
	push bc
	push de
	push hl
	push bc
	ld [wd989], a
	xor a
	ld [wd98a], a
	ld a, [wd989]
	call GetOWObjectWithID
	bit 5, [hl] ; OWOBJSTRUCT_FLAGS
	jr z, .asm_10e8f
	call GetOWObjectTilePosition
	ld a, b
	and $03
	inc a
	dec a
	jr nz, .check_east
	; NORTH
	dec e
	jr nz, .got_direction
.check_east
	dec a
	jr nz, .check_south
	; EAST
	inc d
	jr nz, .got_direction
.check_south
	dec a
	jr nz, .check_west
	; SOUTH
	inc e
	jr nz, .got_direction
.check_west
	dec a
	jr nz, .got_direction
	; WEST
	dec d

.got_direction
	ld a, [wd986]
	cp $ff
	jr z, .asm_10e7f
	ld a, d
	cp $10
	jr nc, .blocked
	ld a, e
	cp $10
	jr nc, .blocked
.asm_10e7f
	call Func_10dfb
	inc a
	jr nz, .blocked
	sla d
	sla e
	call Func_10541
	and a
	jr nz, .blocked
.asm_10e8f
	ld a, $10
	ld [wd98a], a
.blocked
	pop bc
	ld a, [wd98a]
	ld e, a
	ld a, [wd989]
	call Func_1132e
	pop hl
	pop de
	pop bc
	ret

Func_10ea3::
	call Func_11384
	ret

Func_10ea7:
	ei
	di
	push af
	push bc
	push de
	push hl
	ld de, $7563 ; w3d563?
	ld hl, wOWObjects
	ld c, 1
.copy_loop
	ld b, [hl]
	ld a, [wWRAMBank]
	push af
	ld a, BANK("WRAM3")
	call SwitchWRAMBank
	ld a, b
	ld [de], a
	pop af
	call SwitchWRAMBank
	inc hl
	inc de
	dec c
	jr nz, .copy_loop
	ei
	pop hl
	pop de
	pop bc
	pop af
	call PushOWObjectsAndAnimTileToBank3
	ret

Func_10ed3:
	ei
	di
	push af
	push bc
	push de
	push hl
	ld de, $7563 ; w3d563?
	ld hl, wOWObjects
	ld c, 1
.copy_loop
	ld a, [wWRAMBank]
	push af
	ld a, BANK("WRAM3")
	call SwitchWRAMBank
	ld a, [de]
	ld b, a
	pop af
	call SwitchWRAMBank
	ld [hl], b
	inc hl
	inc de
	dec c
	jr nz, .copy_loop
	ei
	pop hl
	pop de
	pop bc
	pop af
	call PullSpriteAnimTileObjFromBank3
	ret

SetOWObjectFlag5_WithID::
	push hl
	call GetOWObjectWithID
	set OBJ_FLAG5_F, [hl]
	pop hl
	ret

ResetOWObjectFlag5_WithID:
	push hl
	call GetOWObjectWithID
	res OBJ_FLAG5_F, [hl]
	pop hl
	ret

Func_10f0f:
	call SetOWObjectTilePosition
	call SetOWObjectDirection
	ret

SetOWObjectAnimStruct1Flag2:
	call _SetOWObjectAnimStruct1Flag2
	ret

GetOWObjectAnimStruct1Flag2:
	call _GetOWObjectAnimStruct1Flag2
	ret

SetAndInitOWObjectFrameset:
	call _SetAndInitOWObjectFrameset
	ret

SetOWObjectFrameset:
	call _SetOWObjectFrameset
	ret

FillwD986:
	ld a, $ff
	ld [wd986], a
	ret

ClearwD986:
	ld a, 0
	ld [wd986], a
	ret

Func_10f32:
	push af
	push bc
	push de
	push hl
	ld de, wd98b
	ld hl, wOWObjects
	ld c, MAX_NUM_OW_OBJECTS
.loop
	bit ACTIVE_OBJ_F, [hl]
	jr z, .next
	call .Func_10f53
.next
	push bc
	ld bc, OWOBJSTRUCT_LENGTH
	add hl, bc
	pop bc
	dec c
	jr nz, .loop
	pop hl
	pop de
	pop bc
	pop af
	ret

.Func_10f53:
	push bc
	push hl
	inc hl
	ld a, [hl] ; OWOBJSTRUCT_ID
	ld c, a
	ld h, d
	ld l, e
	ld [hl], a
	inc hl
	ld a, c
	call GetOWObjectSpriteAnimFlags
	ld [hl], a
	inc hl
	ld a, c
	call GetOWObjectAnimStruct1Flag0And1
	ld [hl], b
	inc hl
	ld a, c
	call GetOWObjectTilePosition
	ld [hl], d
	inc hl
	ld [hl], e
	inc hl
	ld a, $ff
	ld [hl], a
	ld d, h
	ld e, l
	pop hl
	pop bc
	ret

Func_10f78:
	push af
	push bc
	push de
	push hl
	call Func_10d40
	ld hl, wd98b
	ld c, MAX_NUM_OW_OBJECTS
.loop
	ld a, [hl]
	cp $ff
	jr z, .done
	call .LoadObject
	dec c
	jr nz, .loop
.done
	ld a, [wScrollTargetObject]
	call SetOWObjectAsScrollTarget
	pop hl
	pop de
	pop bc
	pop af
	ret

.LoadObject:
	push bc
	ld a, [hl] ; NPC ID
	inc hl
	ld c, [hl] ; anim flags
	inc hl
	ld b, [hl] ; direction
	inc hl
	ld d, [hl] ; x
	inc hl
	ld e, [hl] ; y
	inc hl
	call LoadOWObjectInMap
	bit SPRITEANIMSTRUCT_ANIMATING_F, c
	jr nz, .done_anim
	call StopOWObjectAnimation
.done_anim
	bit SPRITEANIMSTRUCT_FLAG1_F, c
	jr z, .done_flags
	call SetOWObjectFlag5_WithID
.done_flags
	pop bc
	ret

SetOWObjectFrameDuration:
	call _SetOWObjectFrameDuration
	ret

; check if NPC_* ID in register a
; is a still object, which means it
; will not animate its walking animation in place
IsStillOWObject:
	push bc
	push hl
	ld b, a
	ld hl, .OWObjectList
.loop
	ld a, [hli]
	cp $ff
	jr z, .not_found
	cp b
	jr nz, .loop
	scf
	jr .exit
.not_found
	scf
	ccf
.exit
	ld a, b
	pop hl
	pop bc
	ret

.OWObjectList
	db NPC_MARK
	db NPC_MINT
	db NPC_AMY_LOUNGE
	db NPC_CLERK_BATTLE_CENTER
	db NPC_CLERK_GIFT_CENTER
	db NPC_GR_CLERK_TCG_AIRPORT
	db NPC_GR_CLERK_GR_AIRPORT
	db NPC_GR_CLERK_BATTLE_CENTER
	db NPC_GR_CLERK_GIFT_CENTER
	db NPC_GR_CLERK_5
	db NPC_CLERK_TCG_CHALLENGE_HALL_ENTRANCE
	db NPC_GR_CLERK_6
	db NPC_GR_CLERK_GRASS_FORT
	db NPC_GR_CLERK_LIGHTNING_FORT
	db NPC_GR_CLERK_FIRE_FORT
	db NPC_GR_CLERK_WATER_FORT
	db NPC_GR_CLERK_FIGHTING_FORT
	db NPC_GR_CLERK_PSYCHIC_STRONGHOLD
	db NPC_GR_CLERK_13
	db NPC_CAPTURED_AMY
	db NPC_CAPTURED_SARA
	db NPC_CAPTURED_AMANDA
	db NPC_WARP_SPARKLES
	db NPC_GR_CLERK_CASTLE_RIGHT
	db NPC_GR_CLERK_CASTLE_LEFT
	db NPC_GR_CLERK_GAME_CENTER_PRIZE_DESK
	db NPC_GR_CLERK_GAME_CENTER_CHIP_DESK
	db NPC_VOLCANO_SMOKE_TCG
	db NPC_VOLCANO_SMOKE_GR
	db NPC_CURSOR_TCG
	db NPC_CURSOR_GR
	db NPC_GR_CROSS
	db NPC_GR_CASTLE_FLAG
	db NPC_CHEST_CLOSED
	db NPC_CHEST_OPENED
	db NPC_GR_BLIMP_BEAM
	db NPC_GR_BLIMP
	db NPC_POD_DOORS
	db NPC_GR_CLERK_CHALLENGE_HALL_ENTRANCE
	db NPC_GR_CUP_CLERK_LEFT
	db NPC_GR_CUP_CLERK_RIGHT
	db NPC_RED_FORT_COIN
	db NPC_BLUE_FORT_COIN
	db NPC_WHITE_CASTLE_COIN
	db NPC_PURPLE_CASTLE_COIN
	db NPC_STRONGHOLD_PLATFORM
	db $ff ; end

Func_11002:
	push af
	push bc
	push de
	push hl
	lb de,  0, 12
	lb bc, 20,  6
	call AdjustDECoordByhSC
	call ResetActiveSpriteAnimFlag6WithinArea
	call DoFrame
	call CopyBGMapFromVRAMToWRAM
	pop hl
	pop de
	pop bc
	pop af
	ret

Func_1101d:
	push af
	push bc
	push de
	push hl
	call CopyBGMapFromWRAMToVRAM
	call SetActiveSpriteAnimFlag6WithinArea
	pop hl
	pop de
	pop bc
	pop af
	ret

PrintScrollableText_NoTextBoxLabelVRAM0::
	push af
	push bc
	push de
	push hl
	xor a
	call BankswitchVRAM
	call PrintScrollableText_NoTextBoxLabel
	pop hl
	pop de
	pop bc
	pop af
	ret

PrintScrollableText_WithTextBoxLabelVRAM0::
	push af
	push bc
	push de
	push hl
	xor a
	call BankswitchVRAM
	call PrintScrollableText_WithTextBoxLabel
	pop hl
	pop de
	pop bc
	pop af
	ret

; input:
;  a = $0 for "yes" default option
;  a = $1 for "no" default option
;  hl = text ID
; output:
;  a = $0 if "yes" selected
;  a = $1 if "no" selected
;  carry set if "no" selected
DrawWideTextBox_PrintTextWithYesOrNoMenu:
	push bc
	push de
	push hl
	xor 1
	ld [wDefaultYesOrNo], a
	call DrawWideTextBox_PrintText
	call YesOrNoMenu
	ld a, 0
	jr nc, .exit
	ld a, 1
; fallthrough
.exit
	pop hl
	pop de
	pop bc
	ret

PrintScrollableText_WithTextBoxLabelWithYesOrNoMenu:
	push bc
	push de
	push hl
	xor 1
	ld [wDefaultYesOrNo], a
	call PrintScrollableText_WithTextBoxLabel_NoWait
	call YesOrNoMenu
	ld a, 0
	jr nc, .exit
	ld a, 1
; fallthrough
.exit
	pop hl
	pop de
	pop bc
	ret

; hl = text ID
PrintTextInWideTextBox:
	push af
	push bc
	push de
	push hl
	call DrawWideTextBox_PrintText
	pop hl
	pop de
	pop bc
	pop af
	ret

PrintTextInLabelledScrollableTextBox:
	push bc
	push de
	push hl
	call PrintScrollableText_WithTextBoxLabel_NoWait
	pop hl
	pop de
	pop bc
	ret

SetFadePalsFrameFunc:
	push hl
	ld hl, FrameFunc_FadePals
	call PushFrameFunction
	pop hl
	ret

UnsetFadePalsFrameFunc:
	call PopFrameFunction
	ret

Func_1109f::
	push hl
	ld hl, Func_3a39
	call PushFrameFunction
	pop hl
	ret

Func_110a8::
	call PopFrameFunction
	ret

SetSpriteAnimationAndFadePalsFrameFunc::
	push hl
	ld hl, FrameFunc_SpriteAnimationAndFadePals
	call PushFrameFunction
	pop hl
	ret

UnsetSpriteAnimationAndFadePalsFrameFunc::
	call PopFrameFunction
	ret

Func_110b9::
	push hl
	ld hl, Func_3a81
	call PushFrameFunction
	pop hl
	ret

Func_110c2::
	call PopFrameFunction
	ret

_PCMenu:
	push af
	push bc
	push de
	push hl
	call Func_11002
	ldtx hl, TurnedOnPCText
	call PrintScrollableText_NoTextBoxLabelVRAM0
	ld e, $01
.asm_110d5
	call .ShowMenu
	call .HandleInput
	jr c, .asm_110f2
	push de
	call .ExecuteSelectedOption
	pop de
	jr c, .asm_110f2
	call .Func_11181
	ld a, e
	and a
	jr z, .asm_110f0
	call Func_1101d
	ld e, $00
.asm_110f0
	jr .asm_110d5
.asm_110f2
	call .Func_11181
	ld a, e
	and a
	jr nz, .asm_110fc
	call Func_11002
.asm_110fc
	ldtx hl, TurnedOffPCText
	call PrintScrollableText_NoTextBoxLabelVRAM0
	call Func_1101d
	pop hl
	pop de
	pop bc
	pop af
	ret

.ShowMenu:
	push af
	push bc
	push de
	push hl
	lb de, 10, 0
	ld b, BANK(.menu_params)
	ld hl, .menu_params
	call LoadMenuBoxParams
	farcall Func_1cacf
	ld a, [wPCMenuCursorPosition]
	farcall DrawMenuBox
	pop hl
	pop de
	pop bc
	pop af
	ret

.menu_params
	db TRUE ; skip clear
	db 10, 12 ; width, height
	db SYM_CURSOR_R ; blink cursor symbol
	db SYM_SPACE ; space symbol
	db SYM_CURSOR_R ; default cursor symbol
	db SYM_CURSOR_R ; selection cursor symbol
	db PAD_A ; press keys
	db PAD_B ; held keys
	db FALSE ; has horizontal scroll
	db 1 ; vertical step
	dw NULL ; update function
	dw NULL ; label text ID

	textitem 2,  2, PCMenuCardAlbumText
	textitem 2,  4, PCMenuDeckDiagnosisText
	textitem 2,  6, PCMenuGlossaryText
	textitem 2,  8, PCMenuPrintText
	textitem 2, 10, PCMenuShutdownText
	db $ff

.HandleInput:
	ld a, [wPCMenuCursorPosition]
	farcall HandleMenuBox
	ld [wPCMenuCursorPosition], a
	jr c, .asm_11161
	push af
	ld a, SFX_02
	call CallPlaySFX
	pop af
	ret
.asm_11161
	push af
	ld a, SFX_03
	call CallPlaySFX
	pop af
	ret

; a = option that was selected
.ExecuteSelectedOption:
	ld hl, .function_map
	call CallMappedFunction
	ret

.function_map
	key_func $0, .CardAlbum
	key_func $1, .DeckDiagnosis
	key_func $2, .Glossary
	key_func $3, .Printer
	db $ff ; end

.Func_11181:
	farcall Func_1caf1
	ret

.CardAlbum:
	call Func_1022a
	call SetFadePalsFrameFunc
	farcall CardAlbum
	farcall StartFadeToWhite
	farcall WaitPalFading_Bank07
	call UnsetFadePalsFrameFunc
	call Func_10252
	ret

.Glossary:
	call Func_1022a
	call SetFadePalsFrameFunc
	call ClearSpriteAnimsAndSetInitialGraphicsConfiguration
	call FlushAllPalettes
	farcall Glossary
	farcall StartFadeToWhite
	farcall WaitPalFading_Bank07
	call UnsetFadePalsFrameFunc
	call Func_10252
	ret

.Printer:
	call Func_1022a
	call SetFadePalsFrameFunc
	farcall PrinterMenu
	farcall StartFadeToWhite
	farcall WaitPalFading_Bank07
	call UnsetFadePalsFrameFunc
	call Func_10252
	ret

.DeckDiagnosis:
	call Func_1022a
	call SetFadePalsFrameFunc
	farcall DeckDiagnosis
	farcall StartFadeToWhite
	farcall WaitPalFading_Bank07
	call UnsetFadePalsFrameFunc
	call Func_10252
	ret

Func_111f0:
	ld a, $04
	ld [wPCMenuCursorPosition], a
	ret

; clears animations and all OW objects
InitOWObjects:
	push af
	push bc
	push de
	push hl
	xor a
	call ClearSpriteAnims
	xor a
	call SetwD8A1
	xor a
	ld bc, OWOBJSTRUCT_LENGTH * MAX_NUM_OW_OBJECTS
	ld hl, wOWObjects
	call WriteBCBytesToHL
	pop hl
	pop de
	pop bc
	pop af
	ret

_GetNextInactiveOWObject::
	push af
	push bc
	push de
	ld hl, wOWObjects
	ld de, OWOBJSTRUCT_LENGTH
	ld c, MAX_NUM_OW_OBJECTS
.loop
	bit ACTIVE_OBJ_F, [hl]
	jr z, .inactive
	add hl, de
	dec c
	jr nz, .loop
	ld hl, NULL
.inactive
	pop de
	pop bc
	pop af
	ret

; returns in hl the pointer to the OW object
; with the given NPC ID in register a
; returns NULL if not found
_GetOWObjectWithID:
	push af
	push bc
	push de
	ld hl, wOWObjects
	ld de, OWOBJSTRUCT_LENGTH
	ld c, MAX_NUM_OW_OBJECTS
	ld b, a
.loop
	bit ACTIVE_OBJ_F, [hl]
	jr z, .next ; skip objects that are inactive
	inc hl
	ld a, [hld] ; OWOBJSTRUCT_ID
	cp b
	jr z, .found
.next
	add hl, de
	dec c
	jr nz, .loop
	ld hl, NULL
.found
	pop de
	pop bc
	pop af
	ret

_GetOWObjectSpriteAnim:
	push af
REPT OWOBJSTRUCT_ANIM_PTR
	inc hl
ENDR
	ld a, [hli]
	ld h, [hl]
	ld l, a
	pop af
	ret

_GetOWObjectSpriteAnimFlags:
	push bc
	push hl
	call _GetOWObjectWithID
	ld b, [hl]
REPT 4
	srl b
ENDR
	call _GetOWObjectSpriteAnim
	ld a, [hl]
	and $f0
	or b
	pop hl
	pop bc
	ret

; just set [hl] to a
Func_1126b:
	ld [hl], a
	ret

ConvertToSpriteAnimPosition::
	push af
	ld a, d
	add $08
	ld d, a
	ld a, e
	add $10
	ld e, a
	pop af
	ret

; a = NPC_* ID
; b = direction
; de = coordinates
LoadOWObject:
	farcall _LoadOWObject
	ret

_ClearOWObject:
	push af
	push hl
	call _GetOWObjectWithID
	xor a
	ld [hli], a ; OWOBJSTRUCT_FLAGS
	ld [hld], a ; OWOBJSTRUCT_ID
	call _GetOWObjectSpriteAnim
	call _ClearSpriteAnimFlags
	pop hl
	pop af
	ret

GetOWObjectPosition:
	push af
	push hl
	call _GetOWObjectWithID
	call _GetOWObjectSpriteAnim
	call GetSpriteAnimPosition
	call ConvertToOWObjectPosition
	pop hl
	pop af
	ret

; de = position
SetOWObjectPosition:
	push af
	push de
	push hl
	call _GetOWObjectWithID
	call _GetOWObjectSpriteAnim
	call ConvertToSpriteAnimPosition
	call SetSpriteAnimPosition
	pop hl
	pop de
	pop af
	ret

_GetOWObjectAnimStruct1Flag0And1:
	push af
	push hl
	call _GetOWObjectWithID
	call _GetOWObjectSpriteAnim
	call GetSpriteAnimStruct1Flag0And1
	pop hl
	pop af
	ret

; a = NPC_* constant (ow_object)
; b = direction
_SetOWObjectDirection:
	push af
	push bc
	push hl
	call _GetOWObjectWithID
	call _GetOWObjectSpriteAnim
	call SetSpriteAnimDirection
	pop hl
	pop bc
	pop af
	ret

SetOWObjectSpriteAnimating:
	push hl
	call _GetOWObjectWithID
	call _GetOWObjectSpriteAnim
	call SetSpriteAnimAnimating
	pop hl
	ret

ResetOWObjectSpriteAnimating:
	push hl
	call _GetOWObjectWithID
	call _GetOWObjectSpriteAnim
	call ResetSpriteAnimAnimating
	pop hl
	ret

_SetOWObjectSpriteAnimFlag6:
	push hl
	call _GetOWObjectWithID
	call _GetOWObjectSpriteAnim
	call SetSpriteAnimFlag6
	pop hl
	ret

_ResetOWObjectSpriteAnimFlag6:
	push hl
	call _GetOWObjectWithID
	call _GetOWObjectSpriteAnim
	call ResetSpriteAnimFlag6
	pop hl
	ret

_StopAndGetOWObjectSpeedAndMoveDuration:
	push af
	push hl
	call _GetOWObjectWithID
	call _GetOWObjectSpriteAnim
	call StopAndGetSpriteAnimSpeedAndMoveDuration
	pop hl
	pop af
	ret

_MoveAndSetOWObjectSpeedAndMoveDuration:
	push af
	push bc
	push de
	push hl
	call _GetOWObjectWithID
	call _GetOWObjectSpriteAnim
	call MoveAndSetSpriteAnimSpeedAndMoveDuration
	pop hl
	pop de
	pop bc
	pop af
	ret

_GetOWObjectSpeedAndMoveDuration:
	push af
	push hl
	call _GetOWObjectWithID
	call _GetOWObjectSpriteAnim
	call GetSpriteAnimSpeedAndMoveDuration
	pop hl
	pop af
	ret

; a = NPC_* ID
; b = direction
; c = speed
Func_1132e:
	push bc
	push de
	push hl
	call _GetOWObjectWithID
	call _GetOWObjectSpriteAnim
	bit SPRITEANIMSTRUCT_MOVE_F, [hl]
	jr nz, .done
	bit 7, b
	jr nz, .skip_set_direction
	call SetSpriteAnimDirection
.skip_set_direction
	ld a, b
	and $07
	ld b, a
	xor a
	ld [wda8b], a
	ld a, c
	and a
	jr z, .done
	dec c
	jr c, .done
	jr z, .asm_11355
	srl e ; /2
.asm_11355
	ld a, e
	and a
	jr z, .done
	ld [wda8b], a
	inc c
	call SetSpriteAnimMotion
.done
	pop hl
	pop de
	pop bc
	ld a, [wda8b]
	ret

; a = NPC_* ID
Func_11367:
	push af
	push bc
	push de
	push hl
	ld d, h
	ld e, l
	call _GetOWObjectWithID
	set OBJ_FLAG6_F, [hl]
	push bc
	ld bc, OWOBJSTRUCT_4
	add hl, bc
	pop bc
	xor a
	ld [hli], a ; OWOBJSTRUCT_4
	ld [hl], b  ; OWOBJSTRUCT_5
	inc hl
	ld [hl], e  ;  LOW(OWOBJSTRUCT_6)
	inc hl
	ld [hl], d  ; HIGH(OWOBJSTRUCT_6)
	pop hl
	pop de
	pop bc
	pop af
	ret

; e = ?
Func_11384::
	push af
	push bc
	push de
	push hl
	ld c, MAX_NUM_OW_OBJECTS
	ld hl, wOWObjects
.loop
	push bc
	push hl
	bit OBJ_FLAG6_F, [hl]
	jr z, .next
	push hl
	call _GetOWObjectSpriteAnim
	bit SPRITEANIMSTRUCT_MOVE_F, [hl]
	pop hl
	jr nz, .next ; is moving
	push de
	call .Func_113af
	pop de
.next
	pop hl
	ld bc, OWOBJSTRUCT_LENGTH
	add hl, bc
	pop bc
	dec c
	jr nz, .loop
	pop hl
	pop de
	pop bc
	pop af
	ret

.Func_113af:
	inc hl
	ld d, [hl] ; OWOBJSTRUCT_ID
REPT OWOBJSTRUCT_4 - OWOBJSTRUCT_ID
	inc hl
ENDR
	push hl
	ld a, [hli] ; OWOBJSTRUCT_4
	ld c, a
	ld a, [hli] ; OWOBJSTRUCT_5
	ld b, a
	ld a, [hli] ;  LOW(OWOBJSTRUCT_6)
	ld h, [hl]  ; HIGH(OWOBJSTRUCT_6)
	ld l, a
	call Func_3be0
	pop hl
	inc [hl] ; OWOBJSTRUCT_4
	ld a, b
	cp $ff
	jr z, .asm_113cb
	ld a, d
	call Func_1132e
	ret

.asm_113cb
	ld bc, OWOBJSTRUCT_FLAGS - OWOBJSTRUCT_4
	add hl, bc
	res OBJ_FLAG6_F, [hl]
	ret

; counts number of OW objects
; that have flag 6 set
Func_113d2:
	push bc
	push de
	push hl
	ld c, MAX_NUM_OW_OBJECTS
	ld hl, wOWObjects
	xor a
.loop
	bit OBJ_FLAG6_F, [hl] ; OWOBJSTRUCT_FLAGS
	jr z, .next
	inc a
.next
	ld de, OWOBJSTRUCT_LENGTH
	add hl, de
	dec c
	jr nz, .loop
	and a
	pop hl
	pop de
	pop bc
	ret

; input: a = NPC ID
; output: a = HIGH(pointer) | LOW(pointer)
_CheckOWObjectPointerWithID:
	push hl
	call _GetOWObjectWithID
	ld a, h
	or l
	pop hl
	ret

GetOWObjectsPointer:
	ld hl, wOWObjects
	ret

; push all wOWObjects to w3d9a5, then PushSpriteAnimTileToBank3
PushOWObjectsAndAnimTileToBank3:
	ei
	di
	push af
	push bc
	push de
	push hl
	ld de, w3d9a5
	ld hl, wOWObjects
	ld c, OW_OBJECTS_BUFFER_SIZE
.copy_loop
	ld b, [hl]
	ld a, [wWRAMBank]
	push af
	ld a, BANK("WRAM3")
	call SwitchWRAMBank
	ld a, b
	ld [de], a
	pop af
	call SwitchWRAMBank
	inc hl
	inc de
	dec c
	jr nz, .copy_loop
	ei
	call PushSpriteAnimTileToBank3
	pop hl
	pop de
	pop bc
	pop af
	ret

; pull all wOWObjects from w3d9a5, then PullSpriteAnimTileFromBank3
PullSpriteAnimTileObjFromBank3:
	ei
	di
	push af
	push bc
	push de
	push hl
	ld de, w3d9a5
	ld hl, wOWObjects
	ld c, OW_OBJECTS_BUFFER_SIZE
.copy_loop
	ld a, [wWRAMBank]
	push af
	ld a, BANK("WRAM3")
	call SwitchWRAMBank
	ld a, [de]
	ld b, a
	pop af
	call SwitchWRAMBank
	ld [hl], b
	inc hl
	inc de
	dec c
	jr nz, .copy_loop
	ei
	call PullSpriteAnimTileFromBank3
	pop hl
	pop de
	pop bc
	pop af
	ret

SetOWObjectAsScrollTarget:
	ld [wScrollTargetObject], a
	call _GetOWObjectWithID
	call _GetOWObjectSpriteAnim
	call StoreScrollTargetObjectPtr
	ret

CheckIsOWObjectAnimating:
	call _GetOWObjectWithID
	call _GetOWObjectSpriteAnim
	call CheckIsSpriteAnimAnimating
	ret

SetOWObjectPositionAndDirection:
	call _GetOWObjectWithID
	call SetOWObjectPosition
	call _SetOWObjectDirection
	ret

_SetOWObjectAnimStruct1Flag2:
	call _GetOWObjectWithID
	call _GetOWObjectSpriteAnim
	call _SetSpriteAnimStruct1Flag2
	ret

_GetOWObjectAnimStruct1Flag2:
	call _GetOWObjectWithID
	call _GetOWObjectSpriteAnim
	call _GetSpriteAnimStruct1Flag2
	ret

_SetAndInitOWObjectFrameset:
	call _GetOWObjectWithID
	call _GetOWObjectSpriteAnim
	call SetAndInitSpriteAnimFrameset
	ret

_SetOWObjectFrameset:
	call _GetOWObjectWithID
	call _GetOWObjectSpriteAnim
	call SetSpriteAnimFrameset
	ret

_SetOWObjectFrameDuration:
	call _GetOWObjectWithID
	call _GetOWObjectSpriteAnim
	ld a, c
	call SetSpriteAnimFrameDuration
	ret

_SetOWObjectFrameIndex:
	call _GetOWObjectWithID
	call _GetOWObjectSpriteAnim
	ld a, b
	call SetSpriteAnimFrameIndex
	ret

Func_114af:
	push af
	push bc
	push de
	push hl
	ld a, [wda98]
	and a
	jr nz, .fill

	lb de, 0, 0
	lb bc, 8, 4
	call AdjustDECoordByhSC
	call CopyBGMapFromVRAMToWRAM
	call ResetActiveSpriteAnimFlag6WithinArea
	lb de, 0, 0
	lb bc, 8, 4
	call AdjustDECoordByhSC
	call DrawRegularTextBoxVRAM0
	lb de, 1, 1
	call AdjustDECoordByhSC
	ldtx hl, ChipsText
	call Func_35af
	lb de, 6, 2
	call AdjustDECoordByhSC
	ldtx hl, PlayerDiaryCardsUnitText
	call Func_35af
	call PrintNumberOfChips

.fill
	ld a, $ff
	ld [wda98], a
	pop hl
	pop de
	pop bc
	pop af
	ret

Func_114f9:
	push af
	push bc
	push de
	push hl
	ld a, [wda98]
	and a
	jr z, .clear

	call CopyBGMapFromWRAMToVRAM
	call SetActiveSpriteAnimFlag6WithinArea

.clear
	xor a
	ld [wda98], a
	pop hl
	pop de
	pop bc
	pop af
	ret

; bc = number of chips
AddChips:
	push af
	push bc
	push hl
	ld a, [wGameCenterChips]
	ld l, a
	ld a, [wGameCenterChips + 1]
	ld h, a
	add hl, bc
	ld a, h
	cp HIGH(MAX_CHIPS)
	jr c, .got_value
	ld a, l
	cp LOW(MAX_CHIPS)
	jr c, .got_value
	ld hl, MAX_CHIPS
.got_value
	ld a, l
	ld [wGameCenterChips], a
	ld a, h
	ld [wGameCenterChips + 1], a
	ld a, [wda98]
	and a
	jr z, .done
	call PrintNumberOfChips
.done
	pop hl
	pop bc
	pop af
	ret

; bc = number of chips
SubtractChips:
	push af
	push bc
	push hl
	ld a, c
	xor $ff
	ld l, a
	ld a, b
	xor $ff
	ld h, a
	ld bc, 1
	add hl, bc
	ld c, l
	ld b, h
	ld a, [wGameCenterChips]
	ld l, a
	ld a, [wGameCenterChips + 1]
	ld h, a
	add hl, bc
	ld a, h
	cp HIGH(MAX_CHIPS)
	jr c, .got_value
	ld a, l
	cp LOW(MAX_CHIPS)
	jr c, .got_value
	ld hl, 0
.got_value
	ld a, l
	ld [wGameCenterChips], a
	ld a, h
	ld [wGameCenterChips + 1], a
	ld a, [wda98]
	and a
	jr z, .done
	call PrintNumberOfChips
.done
	pop hl
	pop bc
	pop af
	ret

; clear wda98 to wda9c
Func_1157c:
	push af
	xor a
	ld [wGameCenterChips], a
	ld [wGameCenterChips + 1], a
	ld [wGameCenterBankedChips], a
	ld [wGameCenterBankedChips + 1], a
	ld [wda98], a
	pop af
	ret

; load [wGameCenterChips] to bc
GetGameCenterChips:
	push af
	ld a, [wGameCenterChips]
	ld c, a
	ld a, [wGameCenterChips + 1]
	ld b, a
	pop af
	ret

; increases player's chip count and ticks up the display on screen
; while playing sfx. first ticks up slowly, then quickly if bc is large enough.
; bc = number of chips
IncreaseChipsSmoothly:
	push af
	push bc
	push de
	push hl
	ld a, b
	or c
	jr z, .done
	ld d, b
	ld e, c
	ld bc, 20
	call DivideDEByBC
	ld a, h
	or l
	jr z, .next
	ld bc, 1
	inc h
.display_loop_1
	call AddChipsAndPlaySFX
	dec l
	jr nz, .display_loop_1
	dec h
	jr nz, .display_loop_1
; fallthrough
.next
	ld a, d
	or e
	jr z, .done
	ld b, d
	ld c, e
	ld e, 20
.display_loop_2
	call AddChipsAndPlaySFX
	dec e
	jr nz, .display_loop_2
.done
	pop hl
	pop de
	pop bc
	pop af
	ret

; bc = number of chips
AddChipsAndPlaySFX:
	push af
	ld a, SFX_CHIPS_COUNTING
	call CallPlaySFX
	pop af
	call AddChips
	ld a, 3
	call DoAFrames_WithPreCheck
	ret

; decreases player's chip count and ticks down the display on screen
; while playing sfx. first ticks down slowly, then quickly if bc is large enough.
; bc = number of chips
DecreaseChipsSmoothly:
	push af
	push bc
	push de
	push hl
	ld a, b
	or c
	jr z, .done
	ld d, b
	ld e, c
	ld bc, 20
	call DivideDEByBC
	ld a, h
	or l
	jr z, .next
	ld bc, 1
	inc h
.display_loop_1
	call SubtractChipsAndPlaySFX
	dec l
	jr nz, .display_loop_1
	dec h
	jr nz, .display_loop_1
; fallthrough
.next
	ld a, d
	or e
	jr z, .done
	ld b, d
	ld c, e
	ld e, 20
.display_loop_2
	call SubtractChipsAndPlaySFX
	dec e
	jr nz, .display_loop_2
.done
	pop hl
	pop de
	pop bc
	pop af
	ret

; bc = number of chips
SubtractChipsAndPlaySFX:
	push af
	ld a, SFX_CHIPS_COUNTING
	call CallPlaySFX
	pop af
	call SubtractChips
	ld a, 3
	call DoAFrames_WithPreCheck
	ret

; prints value from RAM
PrintNumberOfChips:
	push af
	push bc
	push de
	push hl
	ld a, [wGameCenterChips]
	ld l, a
	ld a, [wGameCenterChips + 1]
	ld h, a
	lb de, 2, 2
	call AdjustDECoordByhSC
	ld a, 4
	ld b, TRUE
	farcall PrintNumber
	pop hl
	pop de
	pop bc
	pop af
	ret

IntroAndTitleScreen:
	push af
	push bc
	push de
	push hl
	call SetNoMusic

.start
	call ChooseTitleScreenCards
	call ClearSpriteAnimsAndSetInitialGraphicsConfiguration
	call EnableLCD
	call DoFrame
	call DoIntro
	jr c, .FadeInScreen
	call AnimateTitle
	jr c, .FadeInScreen
	call AnimateSubtitleEnter
	jr c, .FadeInScreen
	call AnimateTrademark
	jr nc, .title_screen_idle

; fade in whole title screen
; for when there is player input
.FadeInScreen
	call SetNoMusic
	call DoFrame
	call FadeInTitleScreen

.title_screen_idle
	call Func_3d02
	push af
	ld a, MUSIC_TITLESCREEN
	call SetMusic
	pop af
	call TitleScreenPushStart
	jr c, .restart_intro
	call DoFrame
	call AnimateSubtitleExit
	jr c, .FadeInScreen
	call DoFrame
	call AnimateIntroCards
	jr c, .FadeInScreen
	call FadeInTitleScreenAfterIntroCards
	jr c, .FadeInScreen

.restart_intro
	call SetNoMusic
	call SetFadePalsFrameFunc
	farcall StartFadeToWhite
	farcall WaitPalFading_Bank07
	call UnsetFadePalsFrameFunc
	jr nc, .start

	pop hl
	pop de
	pop bc
	pop af
	ret

CreateIntroOrbs:
	ld hl, .SpriteAnimGfxParams
	ld b, BANK(.SpriteAnimGfxParams)
	lb de, 0, 0
	ld c, NUM_INTRO_ORBS
.loop_create
	push bc
	ld a, $ff
	ld c, 0
	call CreateSpriteAnim
	pop bc
	dec c
	jr nz, .loop_create
	ret

.SpriteAnimGfxParams
	dw TILESET_START_ENERGIES
	dw SPRITE_ANIM_92
	dw FRAMESET_159
	dw PALETTE_168
; 0x116cc

SECTION "Bank 4@5704", ROMX[$5704], BANK[$4]

SetAthSpriteAnimPosition:
	push bc
	ld c, a
	call SetCthSpriteAnimPosition
	pop bc
	ret

; also return nz if already animating before setting the flag
SetAthSpriteAnimAnimating:
	push bc
	ld c, a
	call SetCthSpriteAnimAnimating
	pop bc
	ret

; c = which group this orb belongs to
;     group 1 will move from the right
;     group 2 will move from the left
SetIntroOrbFrameset:
	push af
	push bc
	push de
	push hl
	sla c
	ld b, $00
	ld hl, .FramesetIDs
	add hl, bc
	ld e, [hl]
	inc hl
	ld d, [hl]
	ld c, a
	call SetCthSpriteAnimFrameset
	pop hl
	pop de
	pop bc
	pop af
	ret

.FramesetIDs
	dw FRAMESET_159
	dw FRAMESET_176
	dw FRAMESET_177

; c = start delay
SetAthSpriteAnimStartDelay:
	push af
	push bc
	ld b, a
	ld a, c
	ld c, b
	call SetCthSpriteAnimStartDelay
	pop bc
	pop af
	ret

; loads title screen in parts, depending
; on value in register a:
; 0 = title
; 1 = subtitle top
; 2 = subtitle bottom
; 3 = trademark
LoadTitleScreenGraphics:
	ld c, a
	ld b, $00
	sla c
	rl b
	sla c
	rl b
	sla c
	rl b ; *8
	ld hl, .data
	add hl, bc
	ld b, $04
	ld c, $00
	call LoadBGGraphics
	ld a, [wd693]
	set 3, a
	ld [wd693], a
	ret

.data
	dw TILESET_TITLE_SCREEN, PALETTE_167, TILEMAP_21E, $0000
	dw TILESET_TITLE_SCREEN, PALETTE_167, TILEMAP_21F, $0000
	dw TILESET_TITLE_SCREEN, PALETTE_167, TILEMAP_220, $0000
	dw TILESET_TITLE_SCREEN, PALETTE_167, TILEMAP_221, $0000
	dw TILESET_TITLE_SCREEN, PALETTE_167, TILEMAP_222, $0000

CreatePushStartAnimation:
	ld b, BANK(.SpriteAnimGfxParams)
	ld hl, .SpriteAnimGfxParams
	lb de, 48, 119
	ld a, $00
	ld c, 0
	call CreateSpriteAnim
	ret

.SpriteAnimGfxParams
	dw TILESET_START_ENERGIES
	dw SPRITE_ANIM_9A
	dw FRAMESET_161
	dw PALETTE_168

IntroCheckInput:
	scf
	ccf
	call DoFrame
	ldh a, [hKeysPressed]
	and PAD_A | PAD_START
	jr z, .no_carry
	scf
.no_carry
	ret

; waits a number of frames given in a
; for the player input
WaitAFramesForInput:
	push bc
	ld c, a
.loop_wait
	call DoFrame
	ldh a, [hKeysPressed]
	and PAD_A | PAD_START
	jr nz, .set_carry
	dec c
	jr nz, .loop_wait
	scf
	ccf
	jr .no_carry
.set_carry
	scf
.no_carry
	pop bc
	ret

; waits a number of frames given in bc
; for the player input
WaitBCFramesForInput:
	push bc
	ld a, b
	or c
	jr z, .no_carry
	inc c
.loop_wait
	call DoFrame
	ldh a, [hKeysPressed]
	and PAD_A | PAD_START
	jr nz, .set_carry
	dec c
	jr nz, .loop_wait
	dec b
	jr nz, .loop_wait
	scf
	ccf
	jr .no_carry
.set_carry
	scf
.no_carry
	pop bc
	ret

TitleScreenPushStart:
	call ClearSpriteAnims
	call SetSpriteAnimationAndFadePalsFrameFunc
	call CreatePushStartAnimation
	call FlushAllPalettes
	ld bc, 1080
	call WaitBCFramesForInput
	call UnsetSpriteAnimationAndFadePalsFrameFunc
	call ClearSpriteAnims
	ret

; returns carry set if there was user input
DoIntro:
	call ClearSpriteAnims
	call CreateIntroOrbs
	call SetFrameFuncAndFadeFromWhite
	farcall DisableOBPFading

	xor a
	ld [wIntroSceneCounter], a
.loop_intro_scenes
	call ResetIntroState
	call ResetIntroOrbStates
	push af
	ld a, SFX_9A
	call CallPlaySFX
	pop af

.loop_intro_update
	call IntroCheckInput
	jr c, .end_intro
	call HandleIntroScenes
	call UpdateIntroOrbs
	call .CheckLastOrbFinished
	jr nz, .loop_intro_update
	ld a, 20
	call WaitAFramesForInput
	jr c, .end_intro
	ld a, [wIntroSceneCounter]
	inc a
	ld [wIntroSceneCounter], a
	cp NUM_INTRO_SCENES
	jr nz, .loop_intro_scenes

.end_intro
	farcall EnableOBPFading
	call FadeToWhiteAndUnsetFrameFunc
	call ClearSpriteAnims
	ret

; returns z if last orb is in end state
.CheckLastOrbFinished:
	ld a, [wIntroOrbsStates + (NUM_INTRO_ORBS - 1)]
	cp INTRO_ORB_STATE_FINISH
	ret

ResetIntroOrbStates:
	ld hl, wIntroOrbsStates
	ld bc, NUM_INTRO_ORBS
	ld a, INTRO_ORB_STATE_START
	call WriteBCBytesToHL
	xor a
	ld c, $00
.loop_orbs
	call SetIntroOrbFrameset
	inc a
	cp NUM_INTRO_ORBS
	jr nz, .loop_orbs
	ret

UpdateIntroOrbs:
	ld hl, wIntroOrbsStates
	ld b, NUM_INTRO_ORBS
	ld c, 0
.loop_orbs
	push af
	push bc
	push de
	push hl
	ld a, c
	call SetAthSpriteAnimAnimating
	jr nz, .skip
	call .UpdateState
.skip
	pop hl
	pop de
	pop bc
	pop af
	inc hl
	inc c
	dec b
	jr nz, .loop_orbs
	ret

.UpdateState:
	ld a, [hl]
	inc a
	dec a
	call z, .Start
	dec a
	call z, .Stop
	ret

; INTRO_ORB_STATE_START
.Start:
	push af
	push hl
	ld a, c
	lb de, 88, 88
	call SetAthSpriteAnimPosition
	ld b, $00
	sla c
	ld hl, .OrbParams
	add hl, bc
	ld c, [hl]
	call SetIntroOrbFrameset
	inc hl
	ld c, [hl]
	call SetAthSpriteAnimStartDelay
	pop hl
	ld a, INTRO_ORB_STATE_STOP
	ld [hl], a
	pop af
	ret

; INTRO_ORB_STATE_STOP
.Stop:
	push af
	ld a, c
	ld c, $00
	call SetIntroOrbFrameset
	ld a, INTRO_ORB_STATE_FINISH
	ld [hl], a
	pop af
	ret

.OrbParams
	; group, delay
	db 1,  0
	db 1, 24
	db 1, 48
	db 1, 72
	db 2,  3
	db 2, 27
	db 2, 51
	db 2, 75

ResetIntroState:
	ld a, $01
	ld [wIntroStateCounter], a
	ld a, $00
	ld [wIntroStateMode], a
	ret

HandleIntroScenes:
	ld hl, wIntroStateCounter
	dec [hl]
	ret nz
	ld a, [wIntroStateMode]
	inc a
	dec a
	call z, .LoadSceneAndInitPals
	dec a
	call z, .FadeIn
	dec a
	call z, .FadeOut
	ret

; wIntroStateMode == 0
.LoadSceneAndInitPals:
	push af
	ld a, $ff ; white
	farcall InitFadePalettes
	call FlushAllPalettes
	; cycle through
	; SCENE_INTRO_BASE_SET,
	; SCENE_INTRO_JUNGLE,
	; SCENE_INTRO_FOSSIL,
	; SCENE_INTRO_TEAM_ROCKET
	ld a, [wIntroSceneCounter]
	and $3
	add SCENE_INTRO_BASE_SET
	lb bc, 6, 3
	call LoadScene
	ld a, 72
	ld [wIntroStateCounter], a
	ld a, 1
	ld [wIntroStateMode], a
	pop af
	ret

; wIntroStateMode == 1
.FadeIn:
	push af
	farcall SaveTargetFadePals
	xor a
	ld b, $06
	farcall StartPalFadeFromBlackOrWhite
	ld a, 216
	ld [wIntroStateCounter], a
	ld a, 2
	ld [wIntroStateMode], a
	pop af
	ret

; wIntroStateMode == 2
.FadeOut:
	push af
	xor a
	ld b, $06
	farcall StartPalFadeToBlackOrWhite
	ld a, 240
	ld [wIntroStateCounter], a
	ld a, 0
	ld [wIntroStateMode], a
	pop af
	ret

AnimateTitle:
	call SafeClearBGMap
	call DoFrame
	farcall SetAllBGPaletteFadeConfigsToDisabled
	ld a, $04
	farcall SetPaletteFadeConfigToEnabled
	ld a, $ff ; white
	farcall InitFadePalettes
	call FlushAllPalettes
	lb de, 0, 1
	xor a
	call LoadTitleScreenGraphics
	ld a, 2
	call WaitAFramesForInput
	jr c, .finish
	push af
	ld a, SFX_9B
	call CallPlaySFX
	pop af
	call .Expand
	jr c, .finish
	ld a, 18
	call WaitAFramesForInput
.finish
	farcall SetAllBGPaletteFadeConfigsToEnabled
	ret

.Expand:
	xor a
	ld [wIntroStateCounter], a
	ld hl, Data_11e52
.asm_11976
	call DoFrame
	ldh a, [hKeysPressed]
	and PAD_A | PAD_START
	scf
	ret nz
	ld a, [wIntroStateCounter]
	ld b, a
	ld a, $30
	sub b
	ld b, a ; $30 - wIntroStateCounter
.asm_11987
	ldh a, [rLY]
	cp $91
	jr nc, .asm_11987
.asm_1198d
	ldh a, [rLY]
	cp $04
	jr c, .asm_1198d
	; $04 <= rLY < $91
	di
	call WaitForLCDOff
	ld a, $50
	ldh [rSCY], a
.asm_1199b
	ldh a, [rLY]
	cp b
	jr c, .asm_1199b
	; rLY >= b
	ld b, a
.asm_119a1
	ldh a, [rLY]
	cp $30
	jr nc, .asm_119bb
	cp b
	jr z, .asm_119a1
	ld b, a
	call WaitForLCDOff
	ldh a, [rLY]
	ld c, [hl]
	inc hl
	sub c
	sub 8
	xor $ff
	ldh [rSCY], a
	jr .asm_119a1

.asm_119bb
	call WaitForLCDOff
	xor a
	ldh [rSCY], a
	ei
	ld a, [wIntroStateCounter]
	cp 1
	call z, .LoadTitlePals
	ld a, [wIntroStateCounter]
	inc a
	ld [wIntroStateCounter], a
	cp 40
	jr c, .asm_11976
	scf
	ccf
	ret

.LoadTitlePals:
	push bc
	push de
	push hl
	ld hl, rBGPI
	ld a, $a0
	ld [hl], a
	ld de, rBGPD
	ld hl, wBackgroundPalettesCGB + $20
	ld c, PAL_SIZE
.loop_load_pal
	ldh a, [rSTAT]
	and STAT_OAM
	jr nz, .loop_load_pal
	ld a, [hli]
	ld [de], a
	dec c
	jr nz, .loop_load_pal
	pop hl
	pop de
	pop bc
	ret

AnimateSubtitleEnter:
	farcall SetAllBGPaletteFadeConfigsToDisabled
	ld a, $05
	farcall SetPaletteFadeConfigToEnabled
	ld a, $06
	farcall SetPaletteFadeConfigToEnabled
	ld a, $ff ; white
	farcall InitFadePalettes
	call FlushAllPalettes
	lb de, 1, 6
	ld a, $01
	call LoadTitleScreenGraphics
	lb de, 1, 9
	ld a, $02
	call LoadTitleScreenGraphics
	push af
	ld a, SFX_9C
	call CallPlaySFX
	pop af
	call .Distort
	farcall SetAllBGPaletteFadeConfigsToEnabled
	ret

.Distort:
	ld a, $0f
	ld [wdafd], a
	xor a
	ld [wIntroStateCounter], a
	call .Func_11a98
.asm_11a3c
	call DoFrame
	ldh a, [hKeysPressed]
	and PAD_A | PAD_START
	scf
	ret nz
	ld a, [wIntroStateCounter]
	ld c, a
.asm_11a49
	ldh a, [rLY]
	cp $91
	jr nc, .asm_11a49
.asm_11a4f
	ldh a, [rLY]
	cp $30
	jr c, .asm_11a4f
	; $30 <= rLY < $91
	di
	ld a, [wIntroStateCounter]
	ld e, a
.asm_11a5a
	ldh a, [rLY]
	cp $68
	jr nc, .asm_11a7c
	ld d, a
	and $01
	swap a
	ld l, a
	ld a, d
	sub $30
	add e
	xor l
	and $1f
	; a = (rLY - $30 + wIntroStateCounter) ^ ((rLY & %1) << 4) & %11111
	ld b, $00
	ld c, a
	ld hl, wdac1
	add hl, bc
	call WaitForLCDOff
	ld a, [hl]
	ldh [rSCX], a
	jr .asm_11a5a
.asm_11a7c
	ei
	ld a, [wIntroStateCounter]
	cp 1
	call z, .LoadSubtitlePals
	ld a, [wIntroStateCounter]
	inc a
	ld [wIntroStateCounter], a
	call .Func_11a98
	ld a, [wdafd]
	and a
	jr nz, .asm_11a3c
	scf
	ccf
	ret

.Func_11a98:
	push de
	ld hl, Data_11dd2
	ld de, wdac1
	ld a, [wIntroStateCounter]
	ld c, a ; unused
	ld a, $20
.asm_11aa5
	push af
	ld a, [hl]
	push hl
	ld c, $00
	ld b, a
	sra b
	rr c
	sra b
	rr c
	sra b
	rr c
	sra b
	rr c
	sra b
	rr c ; /32

	ld hl, $0
	ld a, [wdafd]
.loop_multiply
	add hl, bc
	dec a
	jr nz, .loop_multiply
	; hl = bc * wdafd

	ld a, h
	ld [de], a
	inc de
	pop hl
	ld bc, $4
	add hl, bc
	pop af
	dec a
	jr nz, .asm_11aa5
	pop de
	ld a, [wIntroStateCounter]
	and $03
	ret nz
	ld hl, wdafd
	dec [hl]
	ret

.LoadSubtitlePals:
	push bc
	push de
	push hl
	ld hl, rBGPI
	ld a, $a8
	ld [hl], a
	ld de, rBGPD
	ld hl, wBackgroundPalettesCGB + $28
	ld c, 2 palettes
.asm_11af2
	ldh a, [rSTAT]
	and STAT_OAM
	jr nz, .asm_11af2
	ld a, [hli]
	ld [de], a
	dec c
	jr nz, .asm_11af2
	pop hl
	pop de
	pop bc
	ret

AnimateTrademark:
	call SetFadePalsFrameFunc
	farcall SetAllBGPaletteFadeConfigsToDisabled
	ld a, $07
	farcall SetPaletteFadeConfigToEnabled
	ld a, $ff ; white
	farcall InitFadePalettes
	call FlushAllPalettes
	lb de, 0, 14
	ld a, $03
	call LoadTitleScreenGraphics
	farcall SaveTargetFadePals
	xor a
	ld b, $02
	farcall StartPalFadeFromBlackOrWhite
	ld a, 60
	call WaitAFramesForInput
	jr c, .asm_11b31 ; unnecessary jump
.asm_11b31
	farcall SetAllBGPaletteFadeConfigsToEnabled
	call UnsetFadePalsFrameFunc
	ret

AnimateSubtitleExit:
	call .Animate
	jr c, .asm_11b46
	ld a, 80
	call WaitAFramesForInput
	jr c, .asm_11b46
	ret
.asm_11b46
	call SetFadePalsFrameFunc
	farcall StartFadeToWhite
	farcall WaitPalFading_Bank07
	call UnsetFadePalsFrameFunc
	ret

.Animate:
	xor a
	ld [wdabd], a
	ld [wdabf], a
	call .ApplyEffect
	ret c
	ld hl, .ClearBoxParams
	ld c, 7
.asm_11b65
	push bc
	ld d, [hl]
	inc hl
	ld e, [hl]
	inc hl
	ld b, [hl]
	inc hl
	ld c, [hl]
	inc hl
	push hl
	call ClearBoxInBGMap
	pop hl
	ld d, [hl]
	inc hl
	ld e, [hl]
	inc hl
	ld b, [hl]
	inc hl
	ld c, [hl]
	inc hl
	push hl
	call ClearBoxInBGMap
	pop hl
	push hl
	call .ApplyEffect
	pop hl
	pop bc
	jr c, .clear_subtitle
	dec c
	jr nz, .asm_11b65
	ret
.clear_subtitle
	push af
	lb de, 0, 6
	lb bc, 20, 7
	call ClearBoxInBGMap
	pop af
	ret

.ClearBoxParams:
	; top
	db  0,  6 ; coordinates
	db  3,  3 ; box dimensions
	; bottom
	db 18,  9 ; coordinates
	db  3,  4 ; box dimensions

	; top
	db  3,  6 ; coordinates
	db  3,  3 ; box dimensions
	; bottom
	db 15,  9 ; coordinates
	db  3,  4 ; box dimensions

	; top
	db  6,  6 ; coordinates
	db  3,  3 ; box dimensions
	; bottom
	db 12,  9 ; coordinates
	db  3,  4 ; box dimensions

	; top
	db  9,  6 ; coordinates
	db  3,  3 ; box dimensions
	; bottom
	db  9,  9 ; coordinates
	db  3,  4 ; box dimensions

	; top
	db 12,  6 ; coordinates
	db  3,  3 ; box dimensions
	; bottom
	db  6,  9 ; coordinates
	db  3,  4 ; box dimensions

	; top
	db 15,  6 ; coordinates
	db  3,  3 ; box dimensions
	; bottom
	db  3,  9 ; coordinates
	db  3,  4 ; box dimensions

	; top
	db 18,  6 ; coordinates
	db  3,  3 ; box dimensions
	; bottom
	db  0,  9 ; coordinates
	db  3,  4 ; box dimensions

.ApplyEffect:
	ld c, 10
.asm_11bd2
	call DoFrame
	ldh a, [hKeysPressed]
	and PAD_A | PAD_START
	scf
	ret nz
.asm_11bdb
	ldh a, [rLY]
	cp $91
	jr nc, .asm_11bdb
.asm_11be1
	ldh a, [rLY]
	cp $20
	jr c, .asm_11be1
	; $20 <= rLY < $91
	di
.asm_11be8
	ldh a, [rLY]
	cp $2f
	jr c, .asm_11be8
	call WaitForLCDOff
	ld a, [wdabd]
	ldh [rSCX], a
	ei
.asm_11bf7
	ldh a, [rLY]
	cp $3c
	jr c, .asm_11bf7
	di
.asm_11bfe
	ldh a, [rLY]
	cp $48
	jr c, .asm_11bfe
	call WaitForLCDOff
	ld a, [wdabf]
	ldh [rSCX], a
	ei
.asm_11c0d
	ldh a, [rLY]
	cp $58
	jr c, .asm_11c0d
	di
.asm_11c14
	ldh a, [rLY]
	cp $68
	jr c, .asm_11c14
	call WaitForLCDOff
	xor a
	ldh [rSCX], a
	ei
	ld a, [wdabd]
	add 3
	ld [wdabd], a
	ld a, [wdabf]
	add -3
	ld [wdabf], a
	dec c
	jr nz, .asm_11bd2
	scf
	ccf
	ret

AnimateIntroCards:
	xor a
	ld [wIntroCardIndex], a
.loop_cards
	call .DrawCurrentIntroCard
	call .AnimateEntrance
	jr c, .FadeOutAndExit
	call .WaitInput
	jr c, .FadeOutAndExit
	call .AnimateExit
	jr c, .FadeOutAndExit
	ld a, [wIntroCardIndex]
	inc a
	ld [wIntroCardIndex], a
	cp NUM_TITLE_SCREEN_CARDS
	jr nz, .loop_cards
	ld a, 30
	call WaitAFramesForInput
	ret

.FadeOutAndExit
	call SetFadePalsFrameFunc
	farcall StartFadeToWhite
	farcall WaitPalFading_Bank07
	call UnsetFadePalsFrameFunc
	ret

.DrawCurrentIntroCard:
	ld a, [wIntroCardIndex]
	add a ; *2
	ld c, a
	ld b, $00
	ld hl, wTitleScreenCards
	add hl, bc
	ld e, [hl]
	inc hl
	ld d, [hl]
	lb bc, 20, 7
	call DrawIntroCardGfx
	call FlushAllPalettes
	ret

.AnimateEntrance:
	call ScrollIntroCard
	jr c, .asm_11c90
	lb bc, 6, 7
	call Func_1340c
.asm_11c90
	ret

.AnimateExit:
	lb de, 20, 7
	lb bc, 8, 6
	call FillBoxInBGMapWithZero
	call ScrollIntroCard
	lb de, 6, 7
	lb bc, 8, 6
	call FillBoxInBGMapWithZero
	ret

.WaitInput:
	ld a, 240
	call WaitAFramesForInput
	ret

ChooseTitleScreenCards:
	ld hl, wTitleScreenCards
	farcall _ChooseTitleScreenCards
	ret

ScrollIntroCard:
	ldh a, [rSCX]
	ld [wdabd], a
	ld c, 28
.asm_11cbc
	call DoFrame
	ldh a, [hKeysPressed]
	and PAD_A | PAD_START
	scf
	jr nz, .done
.asm_11cc6
	ldh a, [rLY]
	cp $91
	jr nc, .asm_11cc6
.asm_11ccc
	ldh a, [rLY]
	cp $20
	jr c, .asm_11ccc
	; $20 <= rLY < $91
	di
.asm_11cd3
	ldh a, [rLY]
	cp $36
	jr c, .asm_11cd3
	call WaitForLCDOff
	ld a, [wdabd]
	ldh [rSCX], a
	ei
.asm_11ce2
	ldh a, [rLY]
	cp $50
	jr c, .asm_11ce2
	di
.asm_11ce9
	ldh a, [rLY]
	cp $68
	jr c, .asm_11ce9
	call WaitForLCDOff
	xor a
	ldh [rSCX], a
	ei
	ld a, [wdabd]
	add 4
	ld [wdabd], a
	dec c
	jr nz, .asm_11cbc
	scf
	ccf
.done
	ret

FadeInTitleScreenAfterIntroCards:
	call SetFadePalsFrameFunc
	farcall SetAllBGPaletteFadeConfigsToDisabled
	ld a, $05
	farcall SetPaletteFadeConfigToEnabled
	ld a, $06
	farcall SetPaletteFadeConfigToEnabled
	ld a, $ff ; white
	farcall InitFadePalettes
	call FlushAllPalettes

	ld a, $01
	lb de, 1, 6
	call LoadTitleScreenGraphics

	ld a, $02
	lb de, 1, 9
	call LoadTitleScreenGraphics

	farcall SaveTargetFadePals
	xor a
	ld b, $0f
	farcall StartPalFadeFromBlackOrWhite
	ld bc, 600
	call WaitBCFramesForInput
	farcall SetAllBGPaletteFadeConfigsToEnabled
	call UnsetFadePalsFrameFunc
	ret

FadeInTitleScreen:
	call DisableLCD
	call ClearSpriteAnimsAndSetInitialGraphicsConfiguration
	lb de, 0, 1
	xor a
	call LoadTitleScreenGraphics
	lb de, 1, 6
	ld a, $01
	call LoadTitleScreenGraphics
	lb de, 1, 9
	ld a, $02
	call LoadTitleScreenGraphics
	lb de, 0, 14
	ld a, $03
	call LoadTitleScreenGraphics
	bank1call SetFontAndTextBoxFrameColor
	call EnableLCD
	call SetFadePalsFrameFunc
	farcall StartFadeFromWhite
	farcall WaitPalFading_Bank07
	call UnsetFadePalsFrameFunc
	ret

; clears a bxc box at coordinates de
ClearBoxInBGMap:
	di
	push bc
	ld b, d
	ld c, e
	call BCCoordToBGMap0Address
	pop bc
.loop_rows
	push bc
	push hl
.loop_columns
	xor a
	call BankswitchVRAM
	call WaitForLCDOff
	xor a
	ld [hl], a
	ld a, BANK("VRAM1")
	call BankswitchVRAM
	call WaitForLCDOff
	xor a
	ld [hli], a
	dec b
	jr nz, .loop_columns
	pop hl
	ld de, TILEMAP_WIDTH
	add hl, de
	pop bc
	dec c
	jr nz, .loop_rows
	xor a
	call BankswitchVRAM
	ei
	ret
; 0x11db2

SECTION "Bank 4@5dd2", ROMX[$5dd2], BANK[$4]

; used for Title Screen subtitle distortion BG effect
Data_11dd2:
	db $00, $03, $06, $09
	db $0c, $0f, $12, $15
	db $18, $1b, $1e, $20
	db $23, $26, $28, $2a
	db $2d, $2f, $31, $33
	db $35, $36, $38, $39
	db $3b, $3c, $3d, $3e
	db $3e, $3f, $3f, $3f
	db $40, $3f, $3f, $3f
	db $3e, $3e, $3d, $3c
	db $3b, $39, $38, $36
	db $35, $33, $31, $2f
	db $2d, $2a, $28, $26
	db $23, $20, $1e, $1b
	db $18, $15, $12, $0f
	db $0c, $09, $06, $03
	db $00, $fd, $fa, $f7
	db $f4, $f1, $ee, $eb
	db $e8, $e5, $e2, $e0
	db $dd, $da, $d8, $d6
	db $d3, $d1, $cf, $cd
	db $cb, $ca, $c8, $c7
	db $c5, $c4, $c3, $c2
	db $c2, $c1, $c1, $c1
	db $c0, $c1, $c1, $c1
	db $c2, $c2, $c3, $c4
	db $c5, $c7, $c8, $ca
	db $cb, $cd, $cf, $d1
	db $d3, $d6, $d8, $da
	db $dd, $e0, $e2, $e5
	db $e8, $eb, $ee, $f1
	db $f4, $f7, $fa, $fd

; used for Title Screen title expansion BG effect
Data_11e52:
	db $28, $14, $28, $0d, $1a, $28, $0a, $14, $1e, $28, $08, $10, $18, $20, $28, $06, $0d, $14, $1a, $21
	db $28, $05, $0b, $11, $16, $1c, $22, $28, $05, $0a, $0f, $14, $19, $1e, $23, $28, $04, $08, $0d, $11
	db $16, $1a, $1f, $23, $27, $04, $08, $0c, $10, $14, $18, $1c, $20, $24, $28, $03, $07, $0a, $0e, $12
	db $15, $19, $1d, $20, $24, $28, $03, $06, $0a, $0d, $10, $14, $17, $1a, $1d, $21, $24, $28, $03, $06
	db $09, $0c, $0f, $12, $15, $18, $1b, $1e, $21, $24, $28, $02, $05, $08, $0b, $0e, $11, $14, $16, $19
	db $1c, $1f, $22, $25, $28, $02, $05, $08, $0a, $0d, $0f, $12, $15, $18, $1a, $1d, $20, $22, $25, $28
	db $02, $05, $07, $0a, $0c, $0f, $11, $14, $16, $19, $1b, $1e, $20, $23, $25, $28, $02, $04, $07, $09
	db $0b, $0e, $10, $12, $15, $17, $19, $1c, $1e, $20, $23, $25, $28, $02, $04, $06, $08, $0b, $0d, $0f
	db $11, $13, $16, $18, $1a, $1c, $1f, $21, $23, $25, $28, $02, $04, $06, $08, $0a, $0c, $0e, $10, $12
	db $15, $17, $19, $1b, $1d, $1f, $21, $23, $25, $28, $02, $04, $06, $08, $0a, $0c, $0e, $10, $12, $14
	db $16, $18, $1a, $1c, $1e, $20, $22, $24, $26, $28, $01, $03, $05, $07, $09, $0b, $0d, $0f, $11, $13
	db $14, $16, $18, $1a, $1c, $1e, $20, $22, $24, $26, $28, $01, $03, $05, $07, $09, $0a, $0c, $0e, $10
	db $12, $13, $15, $17, $19, $1b, $1d, $1e, $20, $22, $24, $26, $28, $01, $03, $05, $06, $08, $0a, $0c
	db $0d, $0f, $11, $13, $14, $16, $18, $1a, $1b, $1d, $1f, $21, $22, $24, $26, $28, $01, $03, $05, $06
	db $08, $0a, $0b, $0d, $0e, $10, $12, $14, $15, $17, $19, $1a, $1c, $1e, $1f, $21, $23, $24, $26, $28
	db $01, $03, $04, $06, $08, $09, $0b, $0c, $0e, $0f, $11, $13, $14, $16, $18, $19, $1b, $1c, $1e, $20
	db $21, $23, $24, $26, $28, $01, $03, $04, $06, $07, $09, $0a, $0c, $0d, $0f, $10, $12, $14, $15, $17
	db $18, $1a, $1b, $1d, $1e, $20, $21, $23, $24, $26, $28, $01, $02, $04, $05, $07, $08, $0a, $0b, $0d
	db $0e, $10, $11, $13, $14, $16, $17, $19, $1a, $1c, $1d, $1f, $20, $22, $23, $25, $26, $28, $01, $02
	db $04, $05, $07, $08, $0a, $0b, $0c, $0e, $0f, $11, $12, $13, $15, $16, $18, $19, $1b, $1c, $1d, $1f
	db $20, $22, $23, $25, $26, $28, $01, $02, $04, $05, $06, $08, $09, $0b, $0c, $0d, $0f, $10, $11, $13
	db $14, $16, $17, $18, $1a, $1b, $1c, $1e, $1f, $21, $22, $23, $25, $26, $28, $01, $02, $04, $05, $06
	db $07, $09, $0a, $0c, $0d, $0e, $10, $11, $12, $13, $15, $16, $17, $19, $1a, $1b, $1d, $1e, $1f, $21
	db $22, $23, $25, $26, $28, $01, $02, $03, $05, $06, $07, $09, $0a, $0b, $0c, $0e, $0f, $10, $12, $13
	db $14, $15, $17, $18, $19, $1b, $1c, $1d, $1e, $20, $21, $22, $24, $25, $26, $28, $01, $02, $03, $05
	db $06, $07, $08, $0a, $0b, $0c, $0d, $0f, $10, $11, $12, $14, $15, $16, $17, $19, $1a, $1b, $1c, $1e
	db $1f, $20, $21, $23, $24, $25, $26, $28, $01, $02, $03, $04, $06, $07, $08, $09, $0a, $0c, $0d, $0e
	db $0f, $10, $12, $13, $14, $15, $17, $18, $19, $1a, $1b, $1d, $1e, $1f, $20, $21, $23, $24, $25, $26
	db $28, $01, $02, $03, $04, $05, $07, $08, $09, $0a, $0b, $0c, $0e, $0f, $10, $11, $12, $13, $15, $16
	db $17, $18, $19, $1b, $1c, $1d, $1e, $1f, $20, $22, $23, $24, $25, $26, $28, $01, $02, $03, $04, $05
	db $06, $07, $09, $0a, $0b, $0c, $0d, $0e, $0f, $11, $12, $13, $14, $15, $16, $17, $19, $1a, $1b, $1c
	db $1d, $1e, $1f, $21, $22, $23, $24, $25, $26, $28, $01, $02, $03, $04, $05, $06, $07, $08, $09, $0b
	db $0c, $0d, $0e, $0f, $10, $11, $12, $13, $15, $16, $17, $18, $19, $1a, $1b, $1c, $1d, $1f, $20, $21
	db $22, $23, $24, $25, $26, $28, $01, $02, $03, $04, $05, $06, $07, $08, $09, $0a, $0b, $0c, $0e, $0f
	db $10, $11, $12, $13, $14, $15, $16, $17, $18, $19, $1b, $1c, $1d, $1e, $1f, $20, $21, $22, $23, $24
	db $25, $26, $28, $01, $02, $03, $04, $05, $06, $07, $08, $09, $0a, $0b, $0c, $0d, $0e, $0f, $10, $11
	db $12, $14, $15, $16, $17, $18, $19, $1a, $1b, $1c, $1d, $1e, $1f, $20, $21, $22, $23, $24, $25, $26
	db $28, $01, $02, $03, $04, $05, $06, $07, $08, $09, $0a, $0b, $0c, $0d, $0e, $0f, $10, $11, $12, $13
	db $14, $15, $16, $17, $18, $19, $1a, $1b, $1c, $1d, $1e, $1f, $20, $21, $22, $23, $24, $25, $26, $28

; de = coordinates
PrintPlayTime:
	push af
	push bc
	push de
	push hl
	ld a, [wPlayTimeCounter + 2] ; minutes
	ld [wDisplayMinutes], a
	ld a, [wPlayTimeCounter + 3] ; lo hours
	ld [wDisplayHours + 0], a
	ld a, [wPlayTimeCounter + 4] ; hi hours
	ld [wDisplayHours + 1], a
	ld a, [wDisplayHours + 0]
	ld l, a
	ld a, [wDisplayHours + 1]
	ld h, a
	ld b, TRUE
	ld a, 3
	farcall PrintNumber
	inc d
	inc d
	inc d
	ldtx hl, SingleColonText
	call Func_35af
	inc d
	ld a, [wDisplayMinutes]
	ld l, a
	ld h, $00
	ld b, FALSE
	ld a, 2
	farcall PrintNumber
	pop hl
	pop de
	pop bc
	pop af
	ret

; de = coordinates
PrintCardAlbumProgress:
	push af
	push bc
	push de
	push hl
	push de
	call GetCardAlbumProgress
	ld hl, wTotalNumCardsCollected
	ld [hl], e
	inc hl
	ld [hl], d
	ld hl, wTotalNumCardsToCollect
	ld [hl], c
	inc hl
	ld [hl], b
	pop de
	ld hl, wTotalNumCardsCollected
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, 3
	ld b, TRUE
	farcall PrintNumber
	inc d
	inc d
	inc d
	ldtx hl, CardCountSeparatorText
	call Func_35af
	inc d
	ld hl, wTotalNumCardsToCollect
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, 3
	ld b, TRUE
	farcall PrintNumber
	pop hl
	pop de
	pop bc
	pop af
	ret
; 0x121e1

SECTION "Bank 4@6e68", ROMX[$6e68], BANK[$4]

; bc = TILEMAP_* constant
LoadAttrmap::
	push af
	push bc
	push de
	push hl
	farcall GetTilemapGfxPointer
	xor a
	ld c, $80 ; Tiles1
	farcall LoadTilemap
	pop hl
	pop de
	pop bc
	pop af
	ret
; 0x12e7c

SECTION "Bank 4@6e87", ROMX[$6e87], BANK[$4]

SetCthSpriteAnimPosition:
	push bc
	push hl
	call GetCthSpriteAnim
	call SetSpriteAnimPosition
	pop hl
	pop bc
	ret

; de = FRAMESET_* constant
SetCthSpriteAnimFrameset:
	push bc
	push hl
	call GetCthSpriteAnim
	ld b, d
	ld c, e
	call SetAndInitSpriteAnimFrameset
	call SetSpriteAnimAnimating
	pop hl
	pop bc
	ret

SetCthSpriteAnimStartDelay:
	push bc
	push hl
	call GetCthSpriteAnim
	call SetSpriteAnimStartDelay
	pop hl
	pop bc
	ret

; also return nz if already animating before setting the flag
SetCthSpriteAnimAnimating:
	push hl
	call GetCthSpriteAnim
	call CheckIsSpriteAnimAnimating
	call SetSpriteAnimAnimating
	pop hl
	ret

INCLUDE "engine/scenes.asm"

SECTION "Bank 4@73f0", ROMX[$73f0], BANK[$4]

; de = card ID
DrawIntroCardGfx:
	push af
	push bc
	push de
	push hl
	push bc
	ld c, $80
	call LoadCardGfx_FromCardID
	pop de
	ld c, $01
	call CopyCardPalettesToBGPals
	ld b, $80
	ld c, $01
	call DrawLoadedCard
	pop hl
	pop de
	pop bc
	pop af
	ret

; bc = coordinates
Func_1340c:
	push af
	push bc
	push de
	push hl
	ld d, b
	ld e, c
	ld b, $80
	ld c, $01
	call DrawLoadedCard
	pop hl
	pop de
	pop bc
	pop af
	ret

; de = card ID
; c = address selector in VRAM
;     if $80, then v0Tiles1
;     if $00, then v0Tiles2
LoadCardGfx_FromCardID:
	push af
	push bc
	push de
	push hl
	push bc
	call LoadCardDataToBuffer1_FromCardID
	pop bc
	ld hl, wLoadedCard1Gfx
	ld a, [hli]
	ld h, [hl]
	ld l, a
	push hl
	ld a, $80
	add c
	ld c, a
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
	xor a
	call BankswitchVRAM
	lb bc, $30, TILE_SIZE
	call LoadCardGfx
	pop hl
	pop de
	pop bc
	pop af
	ret

; c = starting BG pal index
CopyCardPalettesToBGPals:
	push af
	push bc
	push de
	push hl
	ld b, $00
	sla c
	sla c
	sla c ; *PAL_SIZE
	ld hl, wBackgroundPalettesCGB
	add hl, bc
	ld d, h
	ld e, l
	ld hl, wCardPalettes
	ld bc, 3 palettes
	call CopyBCBytesFromHLToDE
	pop hl
	pop de
	pop bc
	pop af
	ret

; de = coordinates
DrawLoadedCard:
	push af
	push bc
	push de
	push hl
	ld a, b
	ld [wCardTilemapOffset], a
	ld a, c
	ld [wddf5], a
	ld b, d
	ld c, e
	call BCCoordToBGMap0Address
	xor a
	call BankswitchVRAM
	call .ApplyTilemap
	ld a, BANK("VRAM1")
	call BankswitchVRAM
	call .ApplyAttrmap
	pop hl
	pop de
	pop bc
	pop af
	ret

.ApplyTilemap:
	push de
	ld hl, .CardTilemap
	ld de, wCardTilemap
	ld a, [wCardTilemapOffset]
	ld c, a
	ld b, $30 ; card size in tiles
.loop_copy
	ld a, [hli]
	add c
	ld [de], a
	inc de
	dec b
	jr nz, .loop_copy
	pop de
	ld hl, wCardTilemap
	call .CopyCardDataToBGMap
	ret

.CardTilemap:
	db $00, $06, $0c, $12, $18, $1e, $24, $2a, $01, $07, $0d, $13, $19, $1f, $25, $2b
	db $02, $08, $0e, $14, $1a, $20, $26, $2c, $03, $09, $0f, $15, $1b, $21, $27, $2d
	db $04, $0a, $10, $16, $1c, $22, $28, $2e, $05, $0b, $11, $17, $1d, $23, $29, $2f

.ApplyAttrmap:
	push de
	ld hl, wCardAttrMap
	ld de, wddc4
	ld a, [wddf5]
	ld c, a
	ld b, $30 ; card size in tiles
.asm_134f8
	ld a, [hli]
	rlca
	rlca
	and $03 ; palette
	add c
	ld [de], a
	inc de
	dec b
	jr nz, .asm_134f8
	pop de
	ld hl, wddc4
	call .CopyCardDataToBGMap
	ret

.CopyCardDataToBGMap:
	push af
	push bc
	push de
	push hl
	ld b, $8 ; card width
	ld c, $6 ; card height
.loop_rows
	push bc
	call SafeCopyDataHLtoDE
	push hl
	ld h, d
	ld l, e
	ld bc, TILEMAP_WIDTH - 8 ; start of next line
	add hl, bc
	ld d, h
	ld e, l
	pop hl
	pop bc
	dec c
	jr nz, .loop_rows
	pop hl
	pop de
	pop bc
	pop af
	ret
; 0x1352a

SECTION "Bank 4@7890", ROMX[$7890], BANK[$4]

INCLUDE "engine/credits_commands.asm"

ShowProloguePortraitAndText_WithFade:
	call Func_1022a
	call ShowProloguePortraitAndText
	call Func_10252
	ret

ShowProloguePortraitAndText:
	push af
	push bc
	push de
	push hl
	ld [wProloguePortraitScene], a
	call .Show
	pop hl
	pop de
	pop bc
	pop af
	ret

.Show:
	call ClearSpriteAnimsAndSetInitialGraphicsConfiguration
	call .DrawPortraitAndTextBox
	call SetFrameFuncAndFadeFromWhite
	call .PrintText
	call FadeToWhiteAndUnsetFrameFunc
	ret

.DrawPortraitAndTextBox:
	ld a, [wProloguePortraitScene]
	ld hl, .FunctionMap
	call CallMappedFunction
	lb de, 0, 12
	lb bc, 20, 6
	call DrawRegularTextBoxVRAM0
	ret

.FunctionMap:
	key_func $00, .Func_13bd8
	key_func $01, .Func_13bdf
	key_func $02, .Func_13bd8
	db $ff ; end

.Func_13bd8:
	lb bc, 7, 3
	call DrawPlayerPortrait
	ret

.Func_13bdf:
	ld a, GR_1_PIC
	lb bc, 7, 3
	ld e, EMOTION_NORMAL
	call DrawNPCPortrait
	ret

.PrintText:
	ld hl, .TextListPointers
	ld a, [wProloguePortraitScene]
	add a
	ld c, a
	ld b, $00
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	call PrintScrollableTextFromList
	ret

.TextListPointers:
	dw .text_list1
	dw .text_list2
	dw .text_list3

.text_list1
	tx PrologueScene1Line1Text
	tx PrologueScene1Line2Text
	tx PrologueScene1Line3Text
	tx PrologueScene1Line4Text
	tx PrologueScene1Line5Text
	tx PrologueScene1Line6Text
	tx PrologueScene1Line7Text
	dw $ffff

.text_list2
	tx PrologueScene2Line1Text
	tx PrologueScene2Line2Text
	tx PrologueScene2Line3Text
	dw $ffff

.text_list3
	tx PrologueScene3Line1Text
	tx PrologueScene3Line2Text
	tx PrologueScene3Line3Text
	dw $ffff
; 0x13c22

SECTION "Bank 4@7c2c", ROMX[$7c2c], BANK[$4]

PlayerNameSelection:
	push af
	push bc
	push de
	push hl
	call .ShowScreenAndDoSelection
	pop hl
	pop de
	pop bc
	pop af
	ret

.ShowScreenAndDoSelection:
	call ClearSpriteAnimsAndSetInitialGraphicsConfiguration
	call SetFrameFuncAndFadeFromWhite
	call SetFadePalsFrameFunc
	call .InputName
	call UnsetFadePalsFrameFunc
	call FadeToWhiteAndUnsetFrameFunc
	ret

.InputName:
	call .ClearPlayerName
	bank1call SetDefaultPalettes
	ld hl, wPlayerName
	farcall InputPlayerName
	ld hl, wPlayerName
	ld a, [hl]
	or a
	jr nz, .got_name
	call .SetDefaultName
.got_name
	call .SetPlayerID
	call .SetGenderByte
	call .SaveName
	ret

.ClearPlayerName:
	xor a
	ld bc, NAME_BUFFER_LENGTH
	ld hl, wPlayerName
	call WriteBCBytesToHL
	ret

.SetPlayerID:
	ld hl, wPlayerName + $e
	call UpdateRNGSources
	ld [hli], a
	call UpdateRNGSources
	ld [hl], a
	ret

.SetGenderByte:
	ld hl, wPlayerName + $d
	call GetPlayerGender
	ld [hl], a
	ret

.SaveName:
	ld hl, wPlayerName
	call SavePlayerName
	ret

.SetDefaultName:
	call GetPlayerGender
	add a
	ld c, a
	ld b, $00
	ld hl, .DefaultNamePointers
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld de, wPlayerName
	ld bc, $c
	call CopyBCBytesFromHLToDE
	ret

.DefaultNamePointers:
	dw .default_male_name
	dw .default_female_name

.default_male_name
	katakana "パ"
	katakana "ー"
	katakana "ク"
	done
	done
	done
	done
	done
	done

.default_female_name
	katakana "ミ"
	katakana "ン"
	katakana "ト"
	done
	done
	done
	done
	done
	done

Func_13cc6:
	call EnableSRAM
	ld hl, $a01d
	ld [hl], a
	call DisableSRAM
	ret
; 0x13cd1

SECTION "Bank 4@7cdc", ROMX[$7cdc], BANK[$4]

; loads player's name from SRAM
; outputs in a the number of characters
LoadPlayerName:
	push bc
	push hl
	call EnableSRAM
	ld hl, sPlayerName
	ld de, wPlayerName
	ld bc, NAME_BUFFER_LENGTH
	call CopyBCBytesFromHLToDE
	call DisableSRAM
	ld hl, wPlayerName
	ld c, 0
.loop_chars
	ld a, [hli]
	ld b, a
	ld a, [hli]
	or b
	jr z, .got_length
	inc c
	ld a, c
	cp MAX_PLAYER_NAME_CHARS
	jr z, .got_length
	jr .loop_chars
.got_length
	ld a, c
	pop hl
	pop bc
	ret

SavePlayerName:
	push af
	push bc
	push de
	push hl
	call EnableSRAM
	ld de, sPlayerName
	ld bc, NAME_BUFFER_LENGTH
	call CopyBCBytesFromHLToDE
	call DisableSRAM
	pop hl
	pop de
	pop bc
	pop af
	ret
; 0x13d1f

SECTION "Bank 4@7d37", ROMX[$7d37], BANK[$4]

PlayerGenderSelection:
	push af
	push bc
	push de
	push hl
	xor a
	ld [wde64], a
	call .Show
	pop hl
	pop de
	pop bc
	pop af
	ret

.Show:
	call ClearSpriteAnimsAndSetInitialGraphicsConfiguration
	call .LoadPortraitsAndMenuParams
	call SetFrameFuncAndFadeFromWhite
	call .HandleSelection
	call FadeToWhiteAndUnsetFrameFunc
	ret

.LoadPortraitsAndMenuParams:
	; male portrait
	ld a, PORTRAIT_MARK
	ld b, 0
	ld c, EMOTION_NORMAL
	lb de, 2, 4
	farcall DrawPortrait

	; female portrait
	ld a, PORTRAIT_MINT
	ld b, 1
	ld c, EMOTION_NORMAL
	lb de, 12, 4
	farcall DrawPortrait

	ld b, BANK(.MenuParams)
	ld hl, .MenuParams
	lb de, 2, 2
	call LoadMenuBoxParams
	ld a, [wde64]
	farcall DrawMenuBox
	lb de, 0, 12
	lb bc, 20, 6
	call DrawRegularTextBoxVRAM0
	ret

.MenuParams
	db FALSE ; skip clear
	db 16, 1 ; width, height
	db SYM_CURSOR_R ; blink cursor symbol
	db SYM_SPACE ; space symbol
	db SYM_CURSOR_R ; default cursor symbol
	db SYM_CURSOR_R ; selection cursor symbol
	db PAD_A ; press keys
	db $00 ; held keys
	db TRUE ; has horizontal scroll
	db 0 ; vertical step
	dw NULL ; update function
	dw NULL ; label text ID

	textitem  1, 0, PlayerGenderMaleText
	textitem 11, 0, PlayerGenderFemaleText
	db $ff

.HandleSelection:
.loop
	ldtx hl, ChoosePlayerGenderText
	call PrintTextInWideTextBox
	ld a, [wde64]
	farcall HandleMenuBox
	ld [wde64], a
	inc a
	ldtx hl, ConfirmPlayerGenderMaleText
	dec a
	jr z, .got_selection
	ldtx hl, ConfirmPlayerGenderFemaleText
.got_selection
	ld a, $1
	call DrawWideTextBox_PrintTextWithYesOrNoMenu
	jr c, .loop
	ld a, [wde64]
	call SetPlayerGender
	ret

SetPlayerGender:
	push af
	push bc
	push de
	push hl
	and a
	ld a, EVENT_PLAYER_GENDER
	jr z, .set_male
; set female
	farcall MaxOutEventValue
	jr .get_value
.set_male
	farcall ZeroOutEventValue
.get_value
	call GetPlayerGender
	call Func_13cc6
	pop hl
	pop de
	pop bc
	pop af
	ret

GetPlayerGender:
	push hl
	ld a, EVENT_PLAYER_GENDER
	farcall GetEventValue
	ld a, PLAYER_MALE
	jr z, .got_gender
	ld a, PLAYER_FEMALE
.got_gender
	pop hl
	ret

Func_13dfa:
	call DisableLCD
	call Func_10d40
	call Func_102ef
	call EnableLCD
	ld a, $01
	ld [wWRAMBank], a
	call ResetFrameFunctionStack
	call Func_3cdd
	farcall SetAllPaletteFadeConfigsToEnabled
	ld a, $ff
	farcall InitFadePalettes
	call Func_3f61
	farcall Func_1dfb9
	farcall EnableAnimations
	ret
; 0x13e27
