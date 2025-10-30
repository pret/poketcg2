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
GetTilemapGfxPointer::
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
GetOWObjectFrameset::
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
Func_12c0ce::
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
LoadTilemap::
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
	ld bc, TILEMAP_WIDTH
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
	ld bc, TILEMAP_WIDTH / 2
	add hl, bc
	pop bc
	dec c
	jr nz, .loop_rows
	ret

; bc = MAP_GFX_* ID
LoadOWMap::
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
	call CopyCGBBGPalsFromSource_BeginWithPal2
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

UpdateSpriteAnim::
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

Func_12c3dc:
	call Func_3bc1
	ret

; input:
;  b:hl = tilemap pointer
;  de = coordinates
LoadPortraitAttributeMap::
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
	ld a, 2 | OAM_BANK1
	jr z, .got_pal_and_tiles
	ld a, c
	add $30
	ld c, a
	ld a, 5 | OAM_BANK1
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
_LoadOWObject::
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
	farcall _GetNextInactiveOWObject
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
	ld [hl], a  ;
	pop hl
	pop de
	pop bc
	pop af
	ret

Func_12c49b::
	push af
	push bc
	push de
	push hl
	push af
	push de
	ld a, [wd693]
	bit 2, a
	jr nz, .checked_flag

	ld bc, TILESET_SMALL_COINS
	call GetTilesetGfxPointer
	call Func_3c10
	ld bc, PALETTE_13B
	call GetPaletteGfxPointer
	call Func_3c2e
	ld a, [wd693]
	set 2, a
	ld [wd693], a
	ld a, [wd693]
	res 0, a
	ld [wd693], a

.checked_flag
	pop de
	pop af
	ld c, a
	ld b, 0
	sla c
	rl b
	ld hl, .TilemapPointers
	add hl, bc
	ld c, [hl]
	inc hl
	ld b, [hl]
	call GetTilemapGfxPointer
	call Func_12c535
	pop hl
	pop de
	pop bc
	pop af
	ret

.TilemapPointers:
	dw TILEMAP_1EB
	dw TILEMAP_201
	dw TILEMAP_1EC
	dw TILEMAP_1ED
	dw TILEMAP_1EE
	dw TILEMAP_1EF
	dw TILEMAP_1F0
	dw TILEMAP_1F1
	dw TILEMAP_202
	dw TILEMAP_203
	dw TILEMAP_204
	dw TILEMAP_205
	dw TILEMAP_206
	dw TILEMAP_207
	dw TILEMAP_208
	dw TILEMAP_209
	dw TILEMAP_20A
	dw TILEMAP_20B
	dw TILEMAP_20C
	dw TILEMAP_20D
	dw TILEMAP_20E
	dw TILEMAP_20F
	dw TILEMAP_210
	dw TILEMAP_211
	dw TILEMAP_1F2
	dw TILEMAP_1F3
	dw TILEMAP_1F4
	dw TILEMAP_1F5
	dw TILEMAP_1F6
	dw TILEMAP_1F7
	dw TILEMAP_1F8
	dw TILEMAP_1F9
	dw TILEMAP_1FA
	dw TILEMAP_1FB
	dw TILEMAP_1FC
	dw TILEMAP_1FD
	dw TILEMAP_1FE
	dw TILEMAP_1FF
	dw TILEMAP_200
	dw TILEMAP_201

Func_12c535:
	push af
	push bc
	push de
	push hl
	ld a, 0
	ld c, $80 ; Tiles1
	call LoadTilemap
	pop hl
	pop de
	pop bc
	pop af
	ret

INCLUDE "data/gfx_pointers/tilemaps.asm"
INCLUDE "data/gfx_pointers/tilesets.asm"
INCLUDE "data/gfx_pointers/palettes.asm"
INCLUDE "data/gfx_pointers/sprite_animations.asm"
INCLUDE "data/gfx_pointers/framesets.asm"
INCLUDE "data/gfx_pointers/ow_tile_frames.asm"
INCLUDE "data/gfx_pointers/ow_animations.asm"

INCLUDE "data/map_gfx.asm"

Data_12f07f:
	dw TILESET_MARK, SPRITE_ANIM_67, OWFRAMEGROUP_0E            ; OWSPRITE_MARK
	dw TILESET_MINT, SPRITE_ANIM_68, OWFRAMEGROUP_0F            ; OWSPRITE_MINT
	dw TILESET_DR_MASON, SPRITE_ANIM_62, OWFRAMEGROUP_2F        ; OWSPRITE_DR_MASON
	dw TILESET_RONALD, SPRITE_ANIM_62, OWFRAMEGROUP_2F          ; OWSPRITE_RONALD
	dw TILESET_ISHIHARA, SPRITE_ANIM_63, OWFRAMEGROUP_30        ; OWSPRITE_ISHIHARA
	dw TILESET_IMAKUNI_BLACK, SPRITE_ANIM_62, OWFRAMEGROUP_2F   ; OWSPRITE_IMAKUNI_BLACK
	dw TILESET_IMAKUNI_RED, SPRITE_ANIM_5F, OWFRAMEGROUP_2C     ; OWSPRITE_IMAKUNI_RED
	dw TILESET_ISAAC, SPRITE_ANIM_65, OWFRAMEGROUP_32           ; OWSPRITE_ISAAC
	dw TILESET_MURRAY, SPRITE_ANIM_63, OWFRAMEGROUP_30          ; OWSPRITE_MURRAY
	dw TILESET_GENE, SPRITE_ANIM_61, OWFRAMEGROUP_2E            ; OWSPRITE_GENE
	dw TILESET_MITCH, SPRITE_ANIM_61, OWFRAMEGROUP_2E           ; OWSPRITE_MITCH
	dw TILESET_NIKKI, SPRITE_ANIM_69, OWFRAMEGROUP_10           ; OWSPRITE_NIKKI
	dw TILESET_RICK, SPRITE_ANIM_61, OWFRAMEGROUP_2E            ; OWSPRITE_RICK
	dw TILESET_AMY, SPRITE_ANIM_6A, OWFRAMEGROUP_11             ; OWSPRITE_AMY
	dw TILESET_AMY_COPY, SPRITE_ANIM_6B, OWFRAMEGROUP_12        ; OWSPRITE_AMY_COPY
	dw TILESET_SARA, SPRITE_ANIM_62, OWFRAMEGROUP_2F            ; OWSPRITE_SARA
	dw TILESET_AMANDA, SPRITE_ANIM_60, OWFRAMEGROUP_2D          ; OWSPRITE_AMANDA
	dw TILESET_KEN, SPRITE_ANIM_5F, OWFRAMEGROUP_2C             ; OWSPRITE_KEN
	dw TILESET_COURTNEY, SPRITE_ANIM_66, OWFRAMEGROUP_33        ; OWSPRITE_COURTNEY
	dw TILESET_STEVE, SPRITE_ANIM_5F, OWFRAMEGROUP_2C           ; OWSPRITE_STEVE
	dw TILESET_JACK, SPRITE_ANIM_61, OWFRAMEGROUP_2E            ; OWSPRITE_JACK
	dw TILESET_ROD, SPRITE_ANIM_6C, OWFRAMEGROUP_13             ; OWSPRITE_ROD
	dw TILESET_EIJI, SPRITE_ANIM_60, OWFRAMEGROUP_2D            ; OWSPRITE_EIJI
	dw TILESET_MAGICIAN, SPRITE_ANIM_6D, OWFRAMEGROUP_14        ; OWSPRITE_MAGICIAN
	dw TILESET_TOSHIRON, SPRITE_ANIM_64, OWFRAMEGROUP_31        ; OWSPRITE_TOSHIRON
	dw TILESET_PIERROT, SPRITE_ANIM_6E, OWFRAMEGROUP_15         ; OWSPRITE_PIERROT
	dw TILESET_ANNA, SPRITE_ANIM_6F, OWFRAMEGROUP_16            ; OWSPRITE_ANNA
	dw TILESET_DEE, SPRITE_ANIM_62, OWFRAMEGROUP_2F             ; OWSPRITE_DEE
	dw TILESET_MASQUERADE, SPRITE_ANIM_63, OWFRAMEGROUP_30      ; OWSPRITE_MASQUERADE
	dw TILESET_PAWN, SPRITE_ANIM_63, OWFRAMEGROUP_30            ; OWSPRITE_PAWN
	dw TILESET_KNIGHT, SPRITE_ANIM_60, OWFRAMEGROUP_2D          ; OWSPRITE_KNIGHT
	dw TILESET_BISHOP, SPRITE_ANIM_60, OWFRAMEGROUP_2D          ; OWSPRITE_BISHOP
	dw TILESET_ROOK, SPRITE_ANIM_60, OWFRAMEGROUP_2D            ; OWSPRITE_ROOK
	dw TILESET_QUEEN, SPRITE_ANIM_60, OWFRAMEGROUP_2D           ; OWSPRITE_QUEEN
	dw TILESET_GR_1, SPRITE_ANIM_65, OWFRAMEGROUP_32            ; OWSPRITE_GR_1
	dw TILESET_GR_2, SPRITE_ANIM_61, OWFRAMEGROUP_2E            ; OWSPRITE_GR_2
	dw TILESET_GR_3, SPRITE_ANIM_60, OWFRAMEGROUP_2D            ; OWSPRITE_GR_3
	dw TILESET_GR_4, SPRITE_ANIM_63, OWFRAMEGROUP_30            ; OWSPRITE_GR_4
	dw TILESET_GR_5, SPRITE_ANIM_64, OWFRAMEGROUP_31            ; OWSPRITE_GR_5
	dw TILESET_MIDORI, SPRITE_ANIM_5F, OWFRAMEGROUP_2C          ; OWSPRITE_MIDORI
	dw TILESET_MORINO, SPRITE_ANIM_5F, OWFRAMEGROUP_2C          ; OWSPRITE_MORINO
	dw TILESET_RENNA, SPRITE_ANIM_5F, OWFRAMEGROUP_2C           ; OWSPRITE_RENNA
	dw TILESET_ICHIKAWA, SPRITE_ANIM_60, OWFRAMEGROUP_2D        ; OWSPRITE_ICHIKAWA
	dw TILESET_CATHERINE, SPRITE_ANIM_60, OWFRAMEGROUP_2D       ; OWSPRITE_CATHERINE
	dw TILESET_JES, SPRITE_ANIM_61, OWFRAMEGROUP_2E             ; OWSPRITE_JES
	dw TILESET_YUKI, SPRITE_ANIM_62, OWFRAMEGROUP_2F            ; OWSPRITE_YUKI
	dw TILESET_SHOKO, SPRITE_ANIM_70, OWFRAMEGROUP_17           ; OWSPRITE_SHOKO
	dw TILESET_HIDERO, SPRITE_ANIM_5F, OWFRAMEGROUP_2C          ; OWSPRITE_HIDERO
	dw TILESET_AIRA, SPRITE_ANIM_71, OWFRAMEGROUP_18            ; OWSPRITE_AIRA
	dw TILESET_KANOKO, SPRITE_ANIM_66, OWFRAMEGROUP_33          ; OWSPRITE_KANOKO
	dw TILESET_GODA, SPRITE_ANIM_5F, OWFRAMEGROUP_2C            ; OWSPRITE_GODA
	dw TILESET_GRACE, SPRITE_ANIM_60, OWFRAMEGROUP_2D           ; OWSPRITE_GRACE
	dw TILESET_KAMIYA, SPRITE_ANIM_72, OWFRAMEGROUP_19          ; OWSPRITE_KAMIYA
	dw TILESET_MIWA, SPRITE_ANIM_73, OWFRAMEGROUP_1A            ; OWSPRITE_MIWA
	dw TILESET_KEVIN, SPRITE_ANIM_74, OWFRAMEGROUP_1B           ; OWSPRITE_KEVIN
	dw TILESET_YOSUKE, SPRITE_ANIM_75, OWFRAMEGROUP_1C          ; OWSPRITE_YOSUKE
	dw TILESET_RYOKO, SPRITE_ANIM_76, OWFRAMEGROUP_1D           ; OWSPRITE_RYOKO
	dw TILESET_MAMI, SPRITE_ANIM_77, OWFRAMEGROUP_1E            ; OWSPRITE_MAMI
	dw TILESET_NISHIJIMA, SPRITE_ANIM_61, OWFRAMEGROUP_2E       ; OWSPRITE_NISHIJIMA
	dw TILESET_ISHII, SPRITE_ANIM_61, OWFRAMEGROUP_2E           ; OWSPRITE_ISHII
	dw TILESET_SAMEJIMA, SPRITE_ANIM_78, OWFRAMEGROUP_1F        ; OWSPRITE_SAMEJIMA
	dw TILESET_KANZAKI, SPRITE_ANIM_79, OWFRAMEGROUP_20         ; OWSPRITE_KANZAKI
	dw TILESET_RUI, SPRITE_ANIM_7A, OWFRAMEGROUP_21             ; OWSPRITE_RUI
	dw TILESET_BIRURITCHI, SPRITE_ANIM_63, OWFRAMEGROUP_30      ; OWSPRITE_BIRURITCHI
	dw TILESET_GR_X, SPRITE_ANIM_64, OWFRAMEGROUP_31            ; OWSPRITE_GR_X
	dw TILESET_TOBICHAN, SPRITE_ANIM_7B, OWFRAMEGROUP_22        ; OWSPRITE_TOBICHAN
	dw TILESET_YOUNGSTER, SPRITE_ANIM_60, OWFRAMEGROUP_2D       ; OWSPRITE_YOUNGSTER
	dw TILESET_LAD, SPRITE_ANIM_65, OWFRAMEGROUP_32             ; OWSPRITE_LAD
	dw TILESET_SPECS, SPRITE_ANIM_63, OWFRAMEGROUP_30           ; OWSPRITE_SPECS
	dw TILESET_BUTCH, SPRITE_ANIM_60, OWFRAMEGROUP_2D           ; OWSPRITE_BUTCH
	dw TILESET_MANIA, SPRITE_ANIM_61, OWFRAMEGROUP_2E           ; OWSPRITE_MANIA
	dw TILESET_JOSHUA, SPRITE_ANIM_61, OWFRAMEGROUP_2E          ; OWSPRITE_JOSHUA
	dw TILESET_HOOD, SPRITE_ANIM_5F, OWFRAMEGROUP_2C            ; OWSPRITE_HOOD
	dw TILESET_TECH, SPRITE_ANIM_62, OWFRAMEGROUP_2F            ; OWSPRITE_TECH
	dw TILESET_CHAP, SPRITE_ANIM_65, OWFRAMEGROUP_32            ; OWSPRITE_CHAP
	dw TILESET_MAN, SPRITE_ANIM_60, OWFRAMEGROUP_2D             ; OWSPRITE_MAN
	dw TILESET_PAPPY, SPRITE_ANIM_63, OWFRAMEGROUP_30           ; OWSPRITE_PAPPY
	dw TILESET_FIXER, SPRITE_ANIM_62, OWFRAMEGROUP_2F           ; OWSPRITE_FIXER
	dw TILESET_GR_LAD, SPRITE_ANIM_5F, OWFRAMEGROUP_2C          ; OWSPRITE_GR_LAD
	dw TILESET_GR_CHAP, SPRITE_ANIM_5F, OWFRAMEGROUP_2C         ; OWSPRITE_GR_CHAP
	dw TILESET_MIYAJIMA, SPRITE_ANIM_5F, OWFRAMEGROUP_2C        ; OWSPRITE_MIYAJIMA
	dw TILESET_GR_PAPPY, SPRITE_ANIM_5F, OWFRAMEGROUP_2C        ; OWSPRITE_GR_PAPPY
	dw TILESET_DEALER_BOY, SPRITE_ANIM_60, OWFRAMEGROUP_2D      ; OWSPRITE_DEALER_BOY
	dw TILESET_MONOCLE, SPRITE_ANIM_7C, OWFRAMEGROUP_23         ; OWSPRITE_MONOCLE
	dw TILESET_GIRL, SPRITE_ANIM_62, OWFRAMEGROUP_2F            ; OWSPRITE_GIRL
	dw TILESET_LASS1, SPRITE_ANIM_63, OWFRAMEGROUP_30           ; OWSPRITE_LASS1
	dw TILESET_LASS2, SPRITE_ANIM_5F, OWFRAMEGROUP_2C           ; OWSPRITE_LASS2
	dw TILESET_LASS3, SPRITE_ANIM_65, OWFRAMEGROUP_32           ; OWSPRITE_LASS3
	dw TILESET_SWIMMER, SPRITE_ANIM_60, OWFRAMEGROUP_2D         ; OWSPRITE_SWIMMER
	dw TILESET_GAL, SPRITE_ANIM_60, OWFRAMEGROUP_2D             ; OWSPRITE_GAL
	dw TILESET_WOMAN, SPRITE_ANIM_5F, OWFRAMEGROUP_2C           ; OWSPRITE_WOMAN
	dw TILESET_GRANNY, SPRITE_ANIM_60, OWFRAMEGROUP_2D          ; OWSPRITE_GRANNY
	dw TILESET_GR_STAFF, SPRITE_ANIM_62, OWFRAMEGROUP_2F        ; OWSPRITE_GR_STAFF
	dw TILESET_GR_LASS, SPRITE_ANIM_5F, OWFRAMEGROUP_2C         ; OWSPRITE_GR_LASS
	dw TILESET_GR_GAL, SPRITE_ANIM_5F, OWFRAMEGROUP_2C          ; OWSPRITE_GR_GAL
	dw TILESET_GR_WOMAN, SPRITE_ANIM_5F, OWFRAMEGROUP_2C        ; OWSPRITE_GR_WOMAN
	dw TILESET_GR_GRANNY, SPRITE_ANIM_5F, OWFRAMEGROUP_2C       ; OWSPRITE_GR_GRANNY
	dw TILESET_CHIP_GIRL, SPRITE_ANIM_5F, OWFRAMEGROUP_2C       ; OWSPRITE_CHIP_GIRL
	dw TILESET_DEALER_GIRL, SPRITE_ANIM_63, OWFRAMEGROUP_30     ; OWSPRITE_DEALER_GIRL
	dw TILESET_CLERK, SPRITE_ANIM_7D, OWFRAMEGROUP_24           ; OWSPRITE_CLERK
	dw TILESET_GR_CLERK, SPRITE_ANIM_7E, OWFRAMEGROUP_25        ; OWSPRITE_GR_GIRL
	dw TILESET_CAPTURED_AMY, SPRITE_ANIM_7F, OWFRAMEGROUP_26    ; OWSPRITE_CAPTURED_AMY
	dw TILESET_CAPTURED_SARA, SPRITE_ANIM_80, OWFRAMEGROUP_27   ; OWSPRITE_CAPTURED_SARA
	dw TILESET_CAPTURED_AMANDA, SPRITE_ANIM_81, OWFRAMEGROUP_28 ; OWSPRITE_CAPTURED_AMANDA
	dw TILESET_WARP_SPARKLES, SPRITE_ANIM_82, OWFRAMEGROUP_29   ; OWSPRITE_WARP_SPARKLES
	dw TILESET_GR_BLIMP, SPRITE_ANIM_83, OWFRAMEGROUP_2A        ; OWSPRITE_GR_BLIMP
	dw TILESET_TRACTOR_BEAM, SPRITE_ANIM_84, OWFRAMEGROUP_2B    ; OWSPRITE_TRACTOR_BEAM
	dw TILESET_TCG_OAM, SPRITE_ANIM_86, OWFRAMEGROUP_00         ; OWSPRITE_VOLCANO_SMOKE_TCG
	dw TILESET_TCG_OAM, SPRITE_ANIM_86, OWFRAMEGROUP_01         ; OWSPRITE_CURSOR_TCG
	dw TILESET_GR_OAM, SPRITE_ANIM_87, OWFRAMEGROUP_02          ; OWSPRITE_VOLCANO_SMOKE_GR
	dw TILESET_GR_OAM, SPRITE_ANIM_88, OWFRAMEGROUP_03          ; OWSPRITE_GR_CASTLE_FLAG
	dw TILESET_GR_OAM, SPRITE_ANIM_89, OWFRAMEGROUP_04          ; OWSPRITE_CURSOR_GR
	dw TILESET_GR_OAM, SPRITE_ANIM_8A, OWFRAMEGROUP_05          ; OWSPRITE_GR_CROSS
	dw TILESET_CHEST, SPRITE_ANIM_8D, OWFRAMEGROUP_0A           ; OWSPRITE_CHEST_CLOSED
	dw TILESET_CHEST, SPRITE_ANIM_8D, OWFRAMEGROUP_0B           ; OWSPRITE_CHEST_OPENED
	dw TILESET_POD_DOORS, SPRITE_ANIM_8E, OWFRAMEGROUP_0C       ; OWSPRITE_POD_DOORS
	dw TILESET_PLATFORM, SPRITE_ANIM_90, OWFRAMEGROUP_0D        ; OWSPRITE_STRONGHOLD_PLATFORM
	dw TILESET_COINS_FORT, SPRITE_ANIM_8B, OWFRAMEGROUP_06      ; OWSPRITE_RED_FORT_COIN
	dw TILESET_COINS_FORT, SPRITE_ANIM_8B, OWFRAMEGROUP_07      ; OWSPRITE_BLUE_FORT_COIN
	dw TILESET_COINS_CASTLE, SPRITE_ANIM_8C, OWFRAMEGROUP_08    ; OWSPRITE_WHITE_CASTLE_COIN
	dw TILESET_COINS_CASTLE, SPRITE_ANIM_8C, OWFRAMEGROUP_09    ; OWSPRITE_PURPLE_CASTLE_COIN

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
