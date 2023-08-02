SECTION "Bank 4B@4000", ROMX[$4000], BANK[$4b]

; input:
; bc = PALETTE_* constant
; outputs pointer as b:hl
GetPaletteGfxPointer::
	push af
	sla c
	rl b
	sla c
	rl b
	ld hl, Palettes
	add hl, bc
	ld a, [hli]
	add BANK(Palettes)
	ld b, a
	ld a, [hli]
	ld h, [hl]
	ld l, a
	pop af
	ret

; bc = TILESET_* constant
; outputs pointer as b:hl
GetTilesetGfxPointer::
	push af
	sla c
	rl b
	sla c
	rl b
	ld hl, Tilesets
	add hl, bc
	ld a, [hli]
	add BANK(Tilesets)
	ld b, a
	ld a, [hli]
	ld h, [hl]
	ld l, a
	pop af
	ret

; bc = TILEMAP_* constant
; outputs pointer as b:hl
GetTilemapGfxPointer:
	push af
	sla c
	rl b
	sla c
	rl b
	ld hl, Tilemaps
	add hl, bc
	ld a, [hli]
	add BANK(Tilemaps)
	ld b, a
	ld a, [hli]
	ld h, [hl]
	ld l, a
	pop af
	ret

; bc = SPRITE_ANIM_* constant
; outputs pointer as b:hl
GetSpriteAnimationGfxPointer:
	push af
	sla c
	rl b
	sla c
	rl b
	ld hl, SpriteAnimations
	add hl, bc
	ld a, [hli]
	add BANK(SpriteAnimations)
	ld b, a
	ld a, [hli]
	ld h, [hl]
	ld l, a
	pop af
	ret

; bc = OW_ANIM_* constant
; outputs pointer as b:hl
GetOWAnimationGfxPointer:
	push af
	sla c
	rl b
	sla c
	rl b
	ld hl, OWAnimations
	add hl, bc
	ld a, [hli]
	add BANK(OWAnimations)
	ld b, a
	ld a, [hli]
	ld h, [hl]
	ld l, a
	pop af
	ret

Func_12c06e::
	push af
	sla c
	rl b
	sla c
	rl b
	ld hl, GfxUnknown2
	add hl, bc
	ld a, [hli]
	add $4b
	ld b, a
	ld a, [hli]
	ld h, [hl]
	ld l, a
	pop af
	ret

; bc = FRAMESET_* constant
GetFramesetPointer:
	push af
	sla c
	rl b
	sla c
	rl b
	ld hl, Framesets
	add hl, bc
	ld a, [hli]
	add $4b
	ld b, a
	ld a, [hli]
	ld h, [hl]
	ld l, a
	pop af
	ret

; bc = OWFRAMEGROUP_*
; a = direction
GetOWObjectFrameset:
	push af
	push hl
	sla c
	rl b
	sla c
	rl b
	sla c
	rl b ; *8
	ld hl, OWObjectFramesets
	add hl, bc
	add a ; *2
	ld c, a
	ld b, $00
	add hl, bc
	ld a, [hli]
	ld b, [hl]
	ld c, a
	pop hl
	pop af
	ret

; b:hl = tilemap pointer
Func_12c0b7:
	push af
	push bc
	push de
	push hl
	xor a
	ld c, $00 ; Tiles0
	call LoadTilemap
	ld a, b
	ld [wd7dc], a ; width
	ld a, c
	ld [wd7dd], a ; height
	pop hl
	pop de
	pop bc
	pop af
	ret

; bc = TILEMAP_* constant
; de = OW coordinates
Func_12c0ce:
	push af
	push bc
	push de
	push hl
	push bc
	push de
	call GetTilemapGfxPointer
	sla d ; *2
	sla e ; *2
	call Func_12c0fc
	ld hl, wd852
	ld a, [hl]
	inc [hl]
	ld c, a
	sla c
	sla c ; *4
	ld b, $00
	ld hl, wd853
	add hl, bc
	pop de
	pop bc
	ld [hl], c ; tilemap
	inc hl     ;
	ld [hl], b ;
	inc hl
	ld [hl], d ; coordinates
	inc hl     ;
	ld [hl], e ;
	pop hl
	pop de
	pop bc
	pop af
	ret

; b:hl = tilemap pointer
Func_12c0fc:
	push af
	push bc
	push de
	push hl
	xor a
	ld c, $00 ; Tiles0
	call LoadTilemap
	pop hl
	pop de
	pop bc
	pop af
	ret

; input:
;  a = attribute to apply to tiles
;  c = $00 to select from Tiles0
;      $80 to select from Tiles1
;  b:hl = tilemap pointer
;  de = coordinates
; output:
;  b = tilemap width
;  c = tilemap height
LoadTilemap:
	push af
	push de
	push hl
	ld [wBGMapAttribute], a
	ld a, c
	ld [wBGMapTileOffset], a
	push de
	push bc
	push hl
	call Func_365b
	ld a, b
	ld [wBGMapWidth], a
	ld a, c
	ld [wBGMapHeight], a
	ld a, l
	ld [wd7d8], a
	ld a, h
	ld [wd7d9], a
	pop hl
	inc hl
	inc hl
	inc hl
	inc hl
	inc hl
	pop bc

	call InitDataDecompressionFromBank
	push bc
	ld b, d
	ld c, e
	call BCCoordToBGMap0Address
	pop bc
	ld a, [wBGMapHeight]
	ld c, a
.loop_rows
	push bc
	push de
	ld de, wDecompressedBGMap
	ld a, [wBGMapWidth]
	add a ; *2
	ld c, a
	call DecompressDataFromBank
	pop de

	; copy tile map
	push hl
	ld hl, wDecompressedBGMap
	ld a, [wBGMapWidth]
	ld c, a
	ld a, [wBGMapTileOffset]
	ld b, a
.loop_apply_offset
	ld a, [hl]
	add b
	ld [hli], a
	dec c
	jr nz, .loop_apply_offset
	pop hl
	xor a ; BANK("VRAM0")
	call BankswitchVRAM
	push de
	ld hl, wDecompressedBGMap
	ld a, [wBGMapWidth]
	ld b, a
	call SafeCopyDataHLtoDE
	pop de

	; copy attribute map
	ld a, [wConsole]
	cp CONSOLE_CGB
	jr nz, .next_row
	push hl
	ld a, [wBGMapWidth]
	ld c, a
	ld a, [wBGMapAttribute]
	ld b, a
.loop_apply_attribute
	ld a, [hl]
	add b
	ld [hli], a
	dec c
	jr nz, .loop_apply_attribute
	pop hl
	ld a, BANK("VRAM1")
	call BankswitchVRAM
	push de
	ld a, [wBGMapWidth]
	ld b, a
	call SafeCopyDataHLtoDE
	pop de

.next_row
	ld h, d
	ld l, e
	ld bc, BG_MAP_WIDTH
	add hl, bc
	ld d, h
	ld e, l
	pop bc
	dec c
	jr nz, .loop_rows
	pop de

	ld a, [wd7d8]
	ld l, a
	ld a, [wd7d9]
	ld h, a
	or l
	jr z, .null
	call Func_12c1c1
.null
	ld a, [wBGMapWidth]
	ld b, a
	ld a, [wBGMapHeight]
	ld c, a
	xor a ; BANK("VRAM0")
	call BankswitchVRAM
	pop hl
	pop de
	pop af
	ret

; decompress permission data?
Func_12c1c1:
	call InitDataDecompressionFromBank
	srl d
	srl e
	sla e
	sla e
	sla e
	sla e
	; d /= 2
	; e *= 8
	ld a, d
	ld d, $00
	ld hl, wd6d4
	add hl, de
	ld e, a
	add hl, de
	ld a, [wBGMapHeight]
	srl a
	ld c, a
.loop_rows
	push bc
	push hl
	ld de, wDecompressedBGMap
	ld a, [wBGMapWidth]
	srl a
	ld c, a
	call DecompressDataFromBank
	ld de, wDecompressedBGMap
	ld a, [wBGMapWidth]
	srl a
	ld b, a
.loop_cols
	ld a, [de]
	inc de
	ld [hli], a
	dec b
	jr nz, .loop_cols
	pop hl
	ld bc, BG_MAP_WIDTH / 2
	add hl, bc
	pop bc
	dec c
	jr nz, .loop_rows
	ret

; bc = map ID
LoadOWMap:
	ld a, c
	ld [wOWMap + 0], a
	ld a, b
	ld [wOWMap + 1], a
	ld l, c
	ld h, b
	sla c
	rl b
	sla c
	rl b
	sla c
	rl b
	add hl, bc ; *9
	ld c, l
	ld b, h
	ld hl, MapGfx
	add hl, bc

	ld c, [hl] ; tilemap
	inc hl     ;
	ld b, [hl] ;
	inc hl
	push hl
	call GetTilemapGfxPointer
	lb de, 0, 0
	call Func_12c0b7
	pop hl

	ld c, [hl] ; tileset
	inc hl     ;
	ld b, [hl] ;
	inc hl
	push hl
	call GetTilesetGfxPointer
	ld a, b
	ld [wd7de], a
	ld a, l
	ld [wd7df + 0], a
	ld a, h
	ld [wd7df + 1], a
	call Func_3792
	pop hl

	ld c, [hl] ; palette
	inc hl     ;
	ld b, [hl] ;
	inc hl
	push hl
	call GetPaletteGfxPointer
	call Func_378c
	pop hl

	xor a
	ld [wOWAnimBank], a
	ld [wOWAnimPtr + 0], a
	ld [wOWAnimPtr + 1], a
	ld a, [hli]
	cp OW_ANIM_NONE
	jr z, .no_ow_anim
	dec hl
	ld a, [hli] ; unnecessary
	push hl
	ld b, $00
	ld c, a
	call GetOWAnimationGfxPointer
	ld a, b
	ld [wOWAnimBank], a
	ld a, l
	ld [wOWAnimPtr + 0], a
	ld a, h
	ld [wOWAnimPtr + 1], a
	call LoadOWAnimatedTiles
	pop hl

.no_ow_anim
	ld c, [hl] ; palette 
	inc hl     ;
	ld b, [hl] ;
	call GetPaletteGfxPointer
	ld c, $00
	call LoadGfxPalettes

	farcall SetFontAndTextBoxFrameColor_PreserveRegisters

	; very inefficient...
	ld a, [wd693]
	set 0, a
	ld [wd693], a
	ld a, [wd693]
	res 2, a
	ld [wd693], a
	ld a, [wd693]
	res 1, a
	ld [wd693], a
	ret

; bc = TILESET_* constant
LoadSpriteAnimGfx::
	push bc
	push de
	push hl
	ld hl, wSpriteTilesets
	ld a, [wNumSpriteTilesets]
	and a
	jr z, .load_tiles
	ld e, a
.loop_loaded_tiles
	ld a, [hl]
	cp c
	jr nz, .next_loaded_tile
	inc hl
	ld a, [hld]
	cp b
	jr z, .got_tiles
.next_loaded_tile
	inc hl
	inc hl
	inc hl
	inc hl
	dec e
	jr nz, .loop_loaded_tiles

.load_tiles
	push bc
	push hl
	ld hl, wNumSpriteTilesets
	inc [hl]
	call GetTilesetGfxPointer
	call LoadGfxFromTileset
	pop hl
	pop bc
	ld [hl], c ; tileset ID
	inc hl     ;
	ld [hl], b ;
	inc hl
	ld [hl], a ; tile offset
	jr .done

.got_tiles
	inc hl
	inc hl
	ld a, [hl] ; tile offset
.done
	pop hl
	pop de
	pop bc
	ret

UpdateSpriteAnim:
	push af
	push bc
	push de
	push hl
	ld a, [hl] ; SPRITEANIMSTRUCT_FLAGS
	and SPRITEANIMSTRUCT_ANIMATING | SPRITEANIMSTRUCT_FLAG6 | SPRITEANIMSTRUCT_ACTIVE
	jr z, .done
	push hl
	call LoadSpriteAnim
	call DecrementSpriteAnimStartDelay
	jr nz, .apply_changes ; still delaying
	call Func_12c35c
	ld hl, wCurSpriteAnim
	bit SPRITEANIMSTRUCT_ANIMATING_F, [hl] ; SPRITEANIMSTRUCT_FLAGS
	jr z, .asm_12c2fe
	call DecrementSpriteAnimFrameDuration
.asm_12c2fe
	ld a, [wCurSpriteAnimFramesetID + 0]
	ld c, a
	ld a, [wCurSpriteAnimFramesetID + 1]
	ld b, a
	call GetFramesetPointer
	ld a, [wCurSpriteAnimFrameIndex]
	ld c, a
	call GetFramesetData
	ld a, c
	ld [wd975], a
	ld hl, wCurSpriteAnim
	bit SPRITEANIMSTRUCT_FLAG6_F, [hl] ; SPRITEANIMSTRUCT_FLAGS
	jr z, .apply_changes
	ld a, [wCurSpriteAnimAnimID + 0]
	ld c, a
	ld a, [wCurSpriteAnimAnimID + 1]
	ld b, a
	call GetSpriteAnimationGfxPointer
	ld a, [wd975]
	ld c, a
	cp $ff
	jr z, .apply_changes
	ld a, [wCurSpriteAnimXPos]
	ld d, a
	ld a, [wCurSpriteAnimYPos]
	ld e, a
	ld a, [wCurSpriteAnimTileOffset]
	call Func_3924
.apply_changes
	pop hl
	call WriteCurSpriteAnim
.done
	pop hl
	pop de
	pop bc
	pop af
	ret

DecrementSpriteAnimStartDelay:
	ld a, [wCurSpriteAnimStartDelay]
	and a
	ret z
	dec a
	ld [wCurSpriteAnimStartDelay], a
	ret

DecrementSpriteAnimFrameDuration:
	ld a, [wCurSpriteAnimFrameDuration]
	dec a
	ld [wCurSpriteAnimFrameDuration], a
	and a
	ret nz
	call Func_12c36a
	ret

Func_12c35c:
	ld a, [wCurSpriteAnimFrameIndex]
	ld b, a
	ld a, [wCurSpriteAnimFrameDuration]
	or b
	ret nz
	ld a, -1
	ld [wCurSpriteAnimFrameIndex], a
Func_12c36a:
	ld a, [wCurSpriteAnimFrameIndex]
	inc a
	ld [wCurSpriteAnimFrameIndex], a
.reset
	ld a, [wCurSpriteAnimFramesetID + 0]
	ld c, a
	ld a, [wCurSpriteAnimFramesetID + 1]
	ld b, a
	call GetFramesetPointer
	ld a, [wCurSpriteAnimFrameIndex]
	ld c, a
	call GetFramesetData
	ld a, b
	and a
	jr nz, .non_zero_duration
	xor a
	ld [wCurSpriteAnimFrameIndex], a
	jr .reset
.non_zero_duration
	cp $ff
	jr nz, .continue
	; end of animation
	ld hl, wCurSpriteAnim
	res SPRITEANIMSTRUCT_ANIMATING_F, [hl] ; SPRITEANIMSTRUCT_FLAGS
.continue
	ld a, [wCurSpriteAnimUnk1]
	bit 2, a
	jr z, .apply_position_offset
	srl b
.apply_position_offset
	ld a, b
	ld [wCurSpriteAnimFrameDuration], a
	ld a, c
	ld [wd975], a
	ld a, d
	ld [wd971], a
	ld a, e
	ld [wd972], a

	ld a, [wd971]
	ld b, a
	ld a, [wCurSpriteAnimXPos]
	add b
	ld [wCurSpriteAnimXPos], a
	ld a, [wd972]
	ld b, a
	ld a, [wCurSpriteAnimYPos]
	add b
	ld [wCurSpriteAnimYPos], a
	ret

; load sprite anim in hl to wCurSpriteAnim
LoadSpriteAnim:
	ld de, wCurSpriteAnim
	ld bc, (SPRITEANIMSTRUCT_START_DELAY - SPRITEANIMSTRUCT_FLAGS) + 1
	call CopyDataHLtoDE_SaveRegisters
	ret

; write wCurSpriteAnim to sprite anim in hl
WriteCurSpriteAnim:
	ld d, h
	ld e, l
	ld hl, wCurSpriteAnim
	ld bc, (SPRITEANIMSTRUCT_START_DELAY - SPRITEANIMSTRUCT_FLAGS) + 1
	call CopyDataHLtoDE_SaveRegisters
	ret
; 0x12c3dc

SECTION "Bank 4B@43e0", ROMX[$43e0], BANK[$4b]

; input:
;  b:hl = tilemap pointer
;  de = coordinates
LoadPortraitAttributeMap:
	push af
	push bc
	push de
	push hl
	push af
	ld a, c
	inc a
	dec a
	ld c, $a0
	jr z, .asm_12c3f3
	dec a
	ld c, $7c
	jr z, .asm_12c3f3
	ld c, $58
.asm_12c3f3
	pop af
	and a
	ld a, 2 | (1 << OAM_TILE_BANK)
	jr z, .got_pal_and_tiles
	ld a, c
	add $30
	ld c, a
	ld a, 5 | (1 << OAM_TILE_BANK)
.got_pal_and_tiles
	call LoadTilemap
	pop hl
	pop de
	pop bc
	pop af
	ret

; a = ?
; b = direction
; de = coordinates
_LoadOWObject:
	push af
	push bc
	push de
	push hl
	ld [wda8c], a
	ld a, b
	ld [wda8d], a
	ld a, d
	ld [wda94 + 0], a
	ld a, e
	ld [wda94 + 1], a
	farcall GetNextInactiveOWObject
	ld a, ACTIVE_OBJ
	ld [hli], a ; OWOBJSTRUCT_FLAGS
	ld a, [wda8c]
	ld [hli], a ; OWOBJSTRUCT_ID
	push hl
	farcall GetNextInactiveSpriteAnim
	farcall SetNewSpriteAnimValues
	ld a, [wda94 + 0]
	ld d, a
	ld a, [wda94 + 1]
	ld e, a
	farcall ConvertToSpriteAnimPosition
	farcall SetSpriteAnimPosition
	ld a, [wda8d]
	farcall SetSpriteAnimDirection
	ld a, [wda8c]
	call Func_3bc1
	push hl
	ld h, b
	ld l, c
	add hl, hl
	sla c
	rl b
	sla c
	rl b
	add hl, bc ; *6
	ld b, h
	ld c, l
	ld hl, Data_12f07f
	add hl, bc
	ld d, h
	ld e, l
	pop hl

	ld a, [de]
	inc de
	ld c, a
	ld a, [de]
	inc de
	ld b, a
	call LoadSpriteAnimGfx
	farcall SetSpriteAnimTileOffset

	ld a, [de]
	inc de
	ld c, a
	ld a, [de]
	inc de
	ld b, a
	farcall SetSpriteAnimAnimation

	ld a, [de]
	inc de
	ld c, a
	ld a, [de]
	inc de
	ld b, a
	farcall SetSpriteAnimOWFrameGroup

	ld a, [wda8d]
	ld b, a
	farcall SetSpriteAnimDirection

	ld d, h
	ld e, l
	pop hl
	ld [hl], e ; OWOBJSTRUCT_ANIM_PTR
	inc hl     ;
	ld [hl], d ;
	inc hl
	xor a
	ld [hli], a ; OWOBJSTRUCT_4
	ld [hli], a ; OWOBJSTRUCT_5
	ld [hli], a ; OWOBJSTRUCT_6
	ld [hl], a  ; OWOBJSTRUCT_7
	pop hl
	pop de
	pop bc
	pop af
	ret
; 0x12c49b

SECTION "Bank 4B@707f", ROMX[$707f], BANK[$4b]

Data_12f07f:
	dw TILESET_0DD, SPRITE_ANIM_67, OWFRAMEGROUP_0E ; OWSPRITE_PLAYERM
	dw TILESET_0DE, SPRITE_ANIM_68, OWFRAMEGROUP_0F ; OWSPRITE_PLAYERF
	dw TILESET_0DF, SPRITE_ANIM_62, OWFRAMEGROUP_2F ; OWSPRITE_DRMASON
	dw TILESET_0E0, SPRITE_ANIM_62, OWFRAMEGROUP_2F ; OWSPRITE_RONALD
	dw TILESET_0E1, SPRITE_ANIM_63, OWFRAMEGROUP_30 ; OWSPRITE_ISHIHARA
	dw TILESET_0E2, SPRITE_ANIM_62, OWFRAMEGROUP_2F ; OWSPRITE_IMAKUNI1
	dw TILESET_0E3, SPRITE_ANIM_5F, OWFRAMEGROUP_2C ; OWSPRITE_IMAKUNI2
	dw TILESET_0E4, SPRITE_ANIM_65, OWFRAMEGROUP_32 ; OWSPRITE_ISAAC
	dw TILESET_0E5, SPRITE_ANIM_63, OWFRAMEGROUP_30 ; OWSPRITE_MURRAY
	dw TILESET_0E6, SPRITE_ANIM_61, OWFRAMEGROUP_2E ; OWSPRITE_GENE
	dw TILESET_0E7, SPRITE_ANIM_61, OWFRAMEGROUP_2E ; OWSPRITE_MITCH
	dw TILESET_0E8, SPRITE_ANIM_69, OWFRAMEGROUP_10 ; OWSPRITE_NIKKI
	dw TILESET_0E9, SPRITE_ANIM_61, OWFRAMEGROUP_2E ; OWSPRITE_RICK
	dw TILESET_0EA, SPRITE_ANIM_6A, OWFRAMEGROUP_11 ; OWSPRITE_AMY1
	dw TILESET_0EB, SPRITE_ANIM_6B, OWFRAMEGROUP_12 ; OWSPRITE_AMY2
	dw TILESET_0EC, SPRITE_ANIM_62, OWFRAMEGROUP_2F ; OWSPRITE_SARA
	dw TILESET_0ED, SPRITE_ANIM_60, OWFRAMEGROUP_2D ; OWSPRITE_AMANDA
	dw TILESET_0EE, SPRITE_ANIM_5F, OWFRAMEGROUP_2C ; OWSPRITE_KEN
	dw TILESET_0EF, SPRITE_ANIM_66, OWFRAMEGROUP_33 ; OWSPRITE_COURTNEY
	dw TILESET_0F0, SPRITE_ANIM_5F, OWFRAMEGROUP_2C ; OWSPRITE_STEVE1
	dw TILESET_0F1, SPRITE_ANIM_61, OWFRAMEGROUP_2E ; OWSPRITE_JACK
	dw TILESET_0F2, SPRITE_ANIM_6C, OWFRAMEGROUP_13 ; OWSPRITE_ROD
	dw TILESET_0F3, SPRITE_ANIM_60, OWFRAMEGROUP_2D ; OWSPRITE_STEVE2
	dw TILESET_0F4, SPRITE_ANIM_6D, OWFRAMEGROUP_14 ; OWSPRITE_17
	dw TILESET_0F5, SPRITE_ANIM_64, OWFRAMEGROUP_31 ; OWSPRITE_STEVE3
	dw TILESET_0F6, SPRITE_ANIM_6E, OWFRAMEGROUP_15 ; OWSPRITE_19
	dw TILESET_0F7, SPRITE_ANIM_6F, OWFRAMEGROUP_16 ; OWSPRITE_1A
	dw TILESET_0F8, SPRITE_ANIM_62, OWFRAMEGROUP_2F ; OWSPRITE_STEVE4
	dw TILESET_0F9, SPRITE_ANIM_63, OWFRAMEGROUP_30 ; OWSPRITE_1C
	dw TILESET_0FA, SPRITE_ANIM_63, OWFRAMEGROUP_30 ; OWSPRITE_1D
	dw TILESET_0FB, SPRITE_ANIM_60, OWFRAMEGROUP_2D ; OWSPRITE_1E
	dw TILESET_0FC, SPRITE_ANIM_60, OWFRAMEGROUP_2D ; OWSPRITE_1F
	dw TILESET_0FD, SPRITE_ANIM_60, OWFRAMEGROUP_2D ; OWSPRITE_20
	dw TILESET_0FE, SPRITE_ANIM_60, OWFRAMEGROUP_2D ; OWSPRITE_21
	dw TILESET_0FF, SPRITE_ANIM_65, OWFRAMEGROUP_32 ; OWSPRITE_22
	dw TILESET_100, SPRITE_ANIM_61, OWFRAMEGROUP_2E ; OWSPRITE_23
	dw TILESET_101, SPRITE_ANIM_60, OWFRAMEGROUP_2D ; OWSPRITE_24
	dw TILESET_102, SPRITE_ANIM_63, OWFRAMEGROUP_30 ; OWSPRITE_25
	dw TILESET_103, SPRITE_ANIM_64, OWFRAMEGROUP_31 ; OWSPRITE_26
	dw TILESET_104, SPRITE_ANIM_5F, OWFRAMEGROUP_2C ; OWSPRITE_27
	dw TILESET_105, SPRITE_ANIM_5F, OWFRAMEGROUP_2C ; OWSPRITE_28
	dw TILESET_106, SPRITE_ANIM_5F, OWFRAMEGROUP_2C ; OWSPRITE_29
	dw TILESET_107, SPRITE_ANIM_60, OWFRAMEGROUP_2D ; OWSPRITE_2A
	dw TILESET_108, SPRITE_ANIM_60, OWFRAMEGROUP_2D ; OWSPRITE_2B
	dw TILESET_109, SPRITE_ANIM_61, OWFRAMEGROUP_2E ; OWSPRITE_2C
	dw TILESET_10A, SPRITE_ANIM_62, OWFRAMEGROUP_2F ; OWSPRITE_2D
	dw TILESET_10B, SPRITE_ANIM_70, OWFRAMEGROUP_17 ; OWSPRITE_2E
	dw TILESET_10C, SPRITE_ANIM_5F, OWFRAMEGROUP_2C ; OWSPRITE_2F
	dw TILESET_10D, SPRITE_ANIM_71, OWFRAMEGROUP_18 ; OWSPRITE_30
	dw TILESET_10E, SPRITE_ANIM_66, OWFRAMEGROUP_33 ; OWSPRITE_31
	dw TILESET_10F, SPRITE_ANIM_5F, OWFRAMEGROUP_2C ; OWSPRITE_32
	dw TILESET_110, SPRITE_ANIM_60, OWFRAMEGROUP_2D ; OWSPRITE_33
	dw TILESET_111, SPRITE_ANIM_72, OWFRAMEGROUP_19 ; OWSPRITE_34
	dw TILESET_112, SPRITE_ANIM_73, OWFRAMEGROUP_1A ; OWSPRITE_35
	dw TILESET_113, SPRITE_ANIM_74, OWFRAMEGROUP_1B ; OWSPRITE_36
	dw TILESET_114, SPRITE_ANIM_75, OWFRAMEGROUP_1C ; OWSPRITE_37
	dw TILESET_115, SPRITE_ANIM_76, OWFRAMEGROUP_1D ; OWSPRITE_38
	dw TILESET_116, SPRITE_ANIM_77, OWFRAMEGROUP_1E ; OWSPRITE_39
	dw TILESET_117, SPRITE_ANIM_61, OWFRAMEGROUP_2E ; OWSPRITE_3A
	dw TILESET_118, SPRITE_ANIM_61, OWFRAMEGROUP_2E ; OWSPRITE_3B
	dw TILESET_119, SPRITE_ANIM_78, OWFRAMEGROUP_1F ; OWSPRITE_3C
	dw TILESET_11A, SPRITE_ANIM_79, OWFRAMEGROUP_20 ; OWSPRITE_3D
	dw TILESET_11B, SPRITE_ANIM_7A, OWFRAMEGROUP_21 ; OWSPRITE_3E
	dw TILESET_11C, SPRITE_ANIM_63, OWFRAMEGROUP_30 ; OWSPRITE_3F
	dw TILESET_11D, SPRITE_ANIM_64, OWFRAMEGROUP_31 ; OWSPRITE_40
	dw TILESET_11E, SPRITE_ANIM_7B, OWFRAMEGROUP_22 ; OWSPRITE_41
	dw TILESET_11F, SPRITE_ANIM_60, OWFRAMEGROUP_2D ; OWSPRITE_YOUNGSTER
	dw TILESET_120, SPRITE_ANIM_65, OWFRAMEGROUP_32 ; OWSPRITE_LAD
	dw TILESET_121, SPRITE_ANIM_63, OWFRAMEGROUP_30 ; OWSPRITE_SPECS
	dw TILESET_122, SPRITE_ANIM_60, OWFRAMEGROUP_2D ; OWSPRITE_BUTCH
	dw TILESET_123, SPRITE_ANIM_61, OWFRAMEGROUP_2E ; OWSPRITE_MANIA
	dw TILESET_124, SPRITE_ANIM_61, OWFRAMEGROUP_2E ; OWSPRITE_JOSHUA
	dw TILESET_125, SPRITE_ANIM_5F, OWFRAMEGROUP_2C ; OWSPRITE_HOOD
	dw TILESET_126, SPRITE_ANIM_62, OWFRAMEGROUP_2F ; OWSPRITE_TECH
	dw TILESET_127, SPRITE_ANIM_65, OWFRAMEGROUP_32 ; OWSPRITE_CHAP
	dw TILESET_128, SPRITE_ANIM_60, OWFRAMEGROUP_2D ; OWSPRITE_MAN
	dw TILESET_129, SPRITE_ANIM_63, OWFRAMEGROUP_30 ; OWSPRITE_PAPPY
	dw TILESET_12A, SPRITE_ANIM_62, OWFRAMEGROUP_2F ; OWSPRITE_4D
	dw TILESET_12B, SPRITE_ANIM_5F, OWFRAMEGROUP_2C ; OWSPRITE_GRYOUNGSTER
	dw TILESET_12C, SPRITE_ANIM_5F, OWFRAMEGROUP_2C ; OWSPRITE_4F
	dw TILESET_12D, SPRITE_ANIM_5F, OWFRAMEGROUP_2C ; OWSPRITE_50
	dw TILESET_12E, SPRITE_ANIM_5F, OWFRAMEGROUP_2C ; OWSPRITE_51
	dw TILESET_12F, SPRITE_ANIM_60, OWFRAMEGROUP_2D ; OWSPRITE_52
	dw TILESET_130, SPRITE_ANIM_7C, OWFRAMEGROUP_23 ; OWSPRITE_53
	dw TILESET_131, SPRITE_ANIM_62, OWFRAMEGROUP_2F ; OWSPRITE_GIRL
	dw TILESET_132, SPRITE_ANIM_63, OWFRAMEGROUP_30 ; OWSPRITE_LASS1
	dw TILESET_133, SPRITE_ANIM_5F, OWFRAMEGROUP_2C ; OWSPRITE_LASS2
	dw TILESET_134, SPRITE_ANIM_65, OWFRAMEGROUP_32 ; OWSPRITE_LASS3
	dw TILESET_135, SPRITE_ANIM_60, OWFRAMEGROUP_2D ; OWSPRITE_SWIMMER
	dw TILESET_136, SPRITE_ANIM_60, OWFRAMEGROUP_2D ; OWSPRITE_GAL
	dw TILESET_137, SPRITE_ANIM_5F, OWFRAMEGROUP_2C ; OWSPRITE_WOMAN
	dw TILESET_138, SPRITE_ANIM_60, OWFRAMEGROUP_2D ; OWSPRITE_GRANNY
	dw TILESET_139, SPRITE_ANIM_62, OWFRAMEGROUP_2F ; OWSPRITE_5C
	dw TILESET_13A, SPRITE_ANIM_5F, OWFRAMEGROUP_2C ; OWSPRITE_GRLASS1
	dw TILESET_13B, SPRITE_ANIM_5F, OWFRAMEGROUP_2C ; OWSPRITE_GRGAL
	dw TILESET_13C, SPRITE_ANIM_5F, OWFRAMEGROUP_2C ; OWSPRITE_GRWOMAN
	dw TILESET_13D, SPRITE_ANIM_5F, OWFRAMEGROUP_2C ; OWSPRITE_GRGRANNY
	dw TILESET_13E, SPRITE_ANIM_5F, OWFRAMEGROUP_2C ; OWSPRITE_61
	dw TILESET_13F, SPRITE_ANIM_63, OWFRAMEGROUP_30 ; OWSPRITE_62
	dw TILESET_140, SPRITE_ANIM_7D, OWFRAMEGROUP_24 ; OWSPRITE_CLERK
	dw TILESET_141, SPRITE_ANIM_7E, OWFRAMEGROUP_25 ; OWSPRITE_GRCLERK
	dw TILESET_142, SPRITE_ANIM_7F, OWFRAMEGROUP_26 ; OWSPRITE_65
	dw TILESET_143, SPRITE_ANIM_80, OWFRAMEGROUP_27 ; OWSPRITE_66
	dw TILESET_144, SPRITE_ANIM_81, OWFRAMEGROUP_28 ; OWSPRITE_67
	dw TILESET_145, SPRITE_ANIM_82, OWFRAMEGROUP_29 ; OWSPRITE_68
	dw TILESET_146, SPRITE_ANIM_83, OWFRAMEGROUP_2A ; OWSPRITE_GRSHIP
	dw TILESET_147, SPRITE_ANIM_84, OWFRAMEGROUP_2B ; OWSPRITE_GRSHIPBEAM
	dw TILESET_001, SPRITE_ANIM_86, OWFRAMEGROUP_00 ; OWSPRITE_VULCANO_SMOKE_TCG
	dw TILESET_001, SPRITE_ANIM_86, OWFRAMEGROUP_01 ; OWSPRITE_CURSOR_TCG
	dw TILESET_003, SPRITE_ANIM_87, OWFRAMEGROUP_02 ; OWSPRITE_6D
	dw TILESET_003, SPRITE_ANIM_88, OWFRAMEGROUP_03 ; OWSPRITE_6E
	dw TILESET_003, SPRITE_ANIM_89, OWFRAMEGROUP_04 ; OWSPRITE_6F
	dw TILESET_003, SPRITE_ANIM_8A, OWFRAMEGROUP_05 ; OWSPRITE_70
	dw TILESET_077, SPRITE_ANIM_8D, OWFRAMEGROUP_0A ; OWSPRITE_71
	dw TILESET_077, SPRITE_ANIM_8D, OWFRAMEGROUP_0B ; OWSPRITE_72
	dw TILESET_078, SPRITE_ANIM_8E, OWFRAMEGROUP_0C ; OWSPRITE_73
	dw TILESET_07A, SPRITE_ANIM_90, OWFRAMEGROUP_0D ; OWSPRITE_74
	dw TILESET_07B, SPRITE_ANIM_8B, OWFRAMEGROUP_06 ; OWSPRITE_75
	dw TILESET_07B, SPRITE_ANIM_8B, OWFRAMEGROUP_07 ; OWSPRITE_76
	dw TILESET_07C, SPRITE_ANIM_8C, OWFRAMEGROUP_08 ; OWSPRITE_77
	dw TILESET_07C, SPRITE_ANIM_8C, OWFRAMEGROUP_09 ; OWSPRITE_78

OWObjectFramesets:
	; north, east, south, west
	dw FRAMESET_147, FRAMESET_147, FRAMESET_147, FRAMESET_147 ; OWFRAMEGROUP_00
	dw FRAMESET_148, FRAMESET_148, FRAMESET_148, FRAMESET_148 ; OWFRAMEGROUP_01
	dw FRAMESET_149, FRAMESET_149, FRAMESET_149, FRAMESET_149 ; OWFRAMEGROUP_02
	dw FRAMESET_14A, FRAMESET_14A, FRAMESET_14A, FRAMESET_14A ; OWFRAMEGROUP_03
	dw FRAMESET_14B, FRAMESET_14B, FRAMESET_14B, FRAMESET_14B ; OWFRAMEGROUP_04
	dw FRAMESET_14C, FRAMESET_14C, FRAMESET_14C, FRAMESET_14C ; OWFRAMEGROUP_05
	dw FRAMESET_14D, FRAMESET_14D, FRAMESET_14D, FRAMESET_14D ; OWFRAMEGROUP_06
	dw FRAMESET_14E, FRAMESET_14E, FRAMESET_14E, FRAMESET_14E ; OWFRAMEGROUP_07
	dw FRAMESET_14F, FRAMESET_14F, FRAMESET_14F, FRAMESET_14F ; OWFRAMEGROUP_08
	dw FRAMESET_150, FRAMESET_150, FRAMESET_150, FRAMESET_150 ; OWFRAMEGROUP_09
	dw FRAMESET_151, FRAMESET_151, FRAMESET_151, FRAMESET_151 ; OWFRAMEGROUP_0A
	dw FRAMESET_152, FRAMESET_152, FRAMESET_152, FRAMESET_152 ; OWFRAMEGROUP_0B
	dw FRAMESET_153, FRAMESET_153, FRAMESET_153, FRAMESET_153 ; OWFRAMEGROUP_0C
	dw FRAMESET_155, FRAMESET_155, FRAMESET_155, FRAMESET_155 ; OWFRAMEGROUP_0D
	dw FRAMESET_0AA, FRAMESET_0AB, FRAMESET_0AC, FRAMESET_0AD ; OWFRAMEGROUP_0E
	dw FRAMESET_0B0, FRAMESET_0B1, FRAMESET_0B2, FRAMESET_0B3 ; OWFRAMEGROUP_0F
	dw FRAMESET_0B6, FRAMESET_0B7, FRAMESET_0B8, FRAMESET_0B9 ; OWFRAMEGROUP_10
	dw FRAMESET_0BA, FRAMESET_0BB, FRAMESET_0BC, FRAMESET_0BD ; OWFRAMEGROUP_11
	dw FRAMESET_0BE, FRAMESET_0BE, FRAMESET_0BE, FRAMESET_0BE ; OWFRAMEGROUP_12
	dw FRAMESET_0BF, FRAMESET_0C0, FRAMESET_0C1, FRAMESET_0C2 ; OWFRAMEGROUP_13
	dw FRAMESET_0C3, FRAMESET_0C4, FRAMESET_0C5, FRAMESET_0C6 ; OWFRAMEGROUP_14
	dw FRAMESET_0C7, FRAMESET_0C8, FRAMESET_0C9, FRAMESET_0CA ; OWFRAMEGROUP_15
	dw FRAMESET_0CB, FRAMESET_0CC, FRAMESET_0CD, FRAMESET_0CE ; OWFRAMEGROUP_16
	dw FRAMESET_0CF, FRAMESET_0D0, FRAMESET_0D1, FRAMESET_0D2 ; OWFRAMEGROUP_17
	dw FRAMESET_0D3, FRAMESET_0D4, FRAMESET_0D5, FRAMESET_0D6 ; OWFRAMEGROUP_18
	dw FRAMESET_0D7, FRAMESET_0D8, FRAMESET_0D9, FRAMESET_0DA ; OWFRAMEGROUP_19
	dw FRAMESET_0DB, FRAMESET_0DC, FRAMESET_0DD, FRAMESET_0DE ; OWFRAMEGROUP_1A
	dw FRAMESET_0DF, FRAMESET_0E0, FRAMESET_0E1, FRAMESET_0E2 ; OWFRAMEGROUP_1B
	dw FRAMESET_0E3, FRAMESET_0E4, FRAMESET_0E5, FRAMESET_0E6 ; OWFRAMEGROUP_1C
	dw FRAMESET_0E7, FRAMESET_0E8, FRAMESET_0E9, FRAMESET_0EA ; OWFRAMEGROUP_1D
	dw FRAMESET_0EB, FRAMESET_0EC, FRAMESET_0ED, FRAMESET_0EE ; OWFRAMEGROUP_1E
	dw FRAMESET_0EF, FRAMESET_0F0, FRAMESET_0F1, FRAMESET_0F2 ; OWFRAMEGROUP_1F
	dw FRAMESET_0F3, FRAMESET_0F4, FRAMESET_0F5, FRAMESET_0F6 ; OWFRAMEGROUP_20
	dw FRAMESET_0F7, FRAMESET_0F8, FRAMESET_0F9, FRAMESET_0FA ; OWFRAMEGROUP_21
	dw FRAMESET_0FB, FRAMESET_0FC, FRAMESET_0FD, FRAMESET_0FE ; OWFRAMEGROUP_22
	dw FRAMESET_0FF, FRAMESET_100, FRAMESET_101, FRAMESET_102 ; OWFRAMEGROUP_23
	dw FRAMESET_103, FRAMESET_104, FRAMESET_105, FRAMESET_106 ; OWFRAMEGROUP_24
	dw FRAMESET_107, FRAMESET_108, FRAMESET_109, FRAMESET_10A ; OWFRAMEGROUP_25
	dw FRAMESET_10B, FRAMESET_10B, FRAMESET_10B, FRAMESET_10B ; OWFRAMEGROUP_26
	dw FRAMESET_10C, FRAMESET_10C, FRAMESET_10C, FRAMESET_10C ; OWFRAMEGROUP_27
	dw FRAMESET_10D, FRAMESET_10D, FRAMESET_10D, FRAMESET_10D ; OWFRAMEGROUP_28
	dw FRAMESET_10E, FRAMESET_10E, FRAMESET_10E, FRAMESET_10E ; OWFRAMEGROUP_29
	dw FRAMESET_10F, FRAMESET_110, FRAMESET_110, FRAMESET_10F ; OWFRAMEGROUP_2A
	dw FRAMESET_111, FRAMESET_111, FRAMESET_111, FRAMESET_111 ; OWFRAMEGROUP_2B
	dw FRAMESET_08A, FRAMESET_08B, FRAMESET_08C, FRAMESET_08D ; OWFRAMEGROUP_2C
	dw FRAMESET_08E, FRAMESET_08F, FRAMESET_090, FRAMESET_091 ; OWFRAMEGROUP_2D
	dw FRAMESET_092, FRAMESET_093, FRAMESET_094, FRAMESET_095 ; OWFRAMEGROUP_2E
	dw FRAMESET_096, FRAMESET_097, FRAMESET_098, FRAMESET_099 ; OWFRAMEGROUP_2F
	dw FRAMESET_09A, FRAMESET_09B, FRAMESET_09C, FRAMESET_09D ; OWFRAMEGROUP_30
	dw FRAMESET_09E, FRAMESET_09F, FRAMESET_0A0, FRAMESET_0A1 ; OWFRAMEGROUP_31
	dw FRAMESET_0A2, FRAMESET_0A3, FRAMESET_0A4, FRAMESET_0A5 ; OWFRAMEGROUP_32
	dw FRAMESET_0A6, FRAMESET_0A7, FRAMESET_0A8, FRAMESET_0A9 ; OWFRAMEGROUP_33
