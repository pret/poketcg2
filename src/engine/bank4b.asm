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

Func_12c058:
	push af
	sla c
	rl b
	sla c
	rl b
	ld hl, GfxUnknown1
	add hl, bc
	ld a, [hli]
	add $4b
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

Func_12c09a:
	push af
	push hl
	sla c
	rl b
	sla c
	rl b
	sla c
	rl b ; *8
	ld hl, Data_12f355
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

SECTION "Bank 4B@410b", ROMX[$410b], BANK[$4b]

; input:
; a = attribute to apply to tiles
; c = $00 to select from Tiles0
;     $80 to select from Tiles1
; b:hl = tilemap pointer
; de = coordinates
Func_12c10b:
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
	jr z, .asm_12c1b1
	call Func_12c1c1
.asm_12c1b1
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
.asm_12c1f6
	ld a, [de]
	inc de
	ld [hli], a
	dec b
	jr nz, .asm_12c1f6
	pop hl
	ld bc, BG_MAP_WIDTH / 2
	add hl, bc
	pop bc
	dec c
	jr nz, .loop_rows
	ret

SECTION "Bank 4B@42a6", ROMX[$42a6], BANK[$4b]

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

SECTION "Bank 4B@7355", ROMX[$7355], BANK[$4b]

Data_12f355:
	dw FRAMESET_147, FRAMESET_147, FRAMESET_147, FRAMESET_147 ; $00
	dw FRAMESET_148, FRAMESET_148, FRAMESET_148, FRAMESET_148 ; $01
	dw FRAMESET_149, FRAMESET_149, FRAMESET_149, FRAMESET_149 ; $02
	dw FRAMESET_14A, FRAMESET_14A, FRAMESET_14A, FRAMESET_14A ; $03
	dw FRAMESET_14B, FRAMESET_14B, FRAMESET_14B, FRAMESET_14B ; $04
	dw FRAMESET_14C, FRAMESET_14C, FRAMESET_14C, FRAMESET_14C ; $05
	dw FRAMESET_14D, FRAMESET_14D, FRAMESET_14D, FRAMESET_14D ; $06
	dw FRAMESET_14E, FRAMESET_14E, FRAMESET_14E, FRAMESET_14E ; $07
	dw FRAMESET_14F, FRAMESET_14F, FRAMESET_14F, FRAMESET_14F ; $08
	dw FRAMESET_150, FRAMESET_150, FRAMESET_150, FRAMESET_150 ; $09
	dw FRAMESET_151, FRAMESET_151, FRAMESET_151, FRAMESET_151 ; $0a
	dw FRAMESET_152, FRAMESET_152, FRAMESET_152, FRAMESET_152 ; $0b
	dw FRAMESET_153, FRAMESET_153, FRAMESET_153, FRAMESET_153 ; $0c
	dw FRAMESET_155, FRAMESET_155, FRAMESET_155, FRAMESET_155 ; $0d
	dw FRAMESET_0AA, FRAMESET_0AB, FRAMESET_0AC, FRAMESET_0AD ; $0e
	dw FRAMESET_0B0, FRAMESET_0B1, FRAMESET_0B2, FRAMESET_0B3 ; $0f
	dw FRAMESET_0B6, FRAMESET_0B7, FRAMESET_0B8, FRAMESET_0B9 ; $10
	dw FRAMESET_0BA, FRAMESET_0BB, FRAMESET_0BC, FRAMESET_0BD ; $11
	dw FRAMESET_0BE, FRAMESET_0BE, FRAMESET_0BE, FRAMESET_0BE ; $12
	dw FRAMESET_0BF, FRAMESET_0C0, FRAMESET_0C1, FRAMESET_0C2 ; $13
	dw FRAMESET_0C3, FRAMESET_0C4, FRAMESET_0C5, FRAMESET_0C6 ; $14
	dw FRAMESET_0C7, FRAMESET_0C8, FRAMESET_0C9, FRAMESET_0CA ; $15
	dw FRAMESET_0CB, FRAMESET_0CC, FRAMESET_0CD, FRAMESET_0CE ; $16
	dw FRAMESET_0CF, FRAMESET_0D0, FRAMESET_0D1, FRAMESET_0D2 ; $17
	dw FRAMESET_0D3, FRAMESET_0D4, FRAMESET_0D5, FRAMESET_0D6 ; $18
	dw FRAMESET_0D7, FRAMESET_0D8, FRAMESET_0D9, FRAMESET_0DA ; $19
	dw FRAMESET_0DB, FRAMESET_0DC, FRAMESET_0DD, FRAMESET_0DE ; $1a
	dw FRAMESET_0DF, FRAMESET_0E0, FRAMESET_0E1, FRAMESET_0E2 ; $1b
	dw FRAMESET_0E3, FRAMESET_0E4, FRAMESET_0E5, FRAMESET_0E6 ; $1c
	dw FRAMESET_0E7, FRAMESET_0E8, FRAMESET_0E9, FRAMESET_0EA ; $1d
	dw FRAMESET_0EB, FRAMESET_0EC, FRAMESET_0ED, FRAMESET_0EE ; $1e
	dw FRAMESET_0EF, FRAMESET_0F0, FRAMESET_0F1, FRAMESET_0F2 ; $1f
	dw FRAMESET_0F3, FRAMESET_0F4, FRAMESET_0F5, FRAMESET_0F6 ; $20
	dw FRAMESET_0F7, FRAMESET_0F8, FRAMESET_0F9, FRAMESET_0FA ; $21
	dw FRAMESET_0FB, FRAMESET_0FC, FRAMESET_0FD, FRAMESET_0FE ; $22
	dw FRAMESET_0FF, FRAMESET_100, FRAMESET_101, FRAMESET_102 ; $23
	dw FRAMESET_103, FRAMESET_104, FRAMESET_105, FRAMESET_106 ; $24
	dw FRAMESET_107, FRAMESET_108, FRAMESET_109, FRAMESET_10A ; $25
	dw FRAMESET_10B, FRAMESET_10B, FRAMESET_10B, FRAMESET_10B ; $26
	dw FRAMESET_10C, FRAMESET_10C, FRAMESET_10C, FRAMESET_10C ; $27
	dw FRAMESET_10D, FRAMESET_10D, FRAMESET_10D, FRAMESET_10D ; $28
	dw FRAMESET_10E, FRAMESET_10E, FRAMESET_10E, FRAMESET_10E ; $29
	dw FRAMESET_10F, FRAMESET_110, FRAMESET_110, FRAMESET_10F ; $2a
	dw FRAMESET_111, FRAMESET_111, FRAMESET_111, FRAMESET_111 ; $2b
	dw FRAMESET_08A, FRAMESET_08B, FRAMESET_08C, FRAMESET_08D ; $2c
	dw FRAMESET_08E, FRAMESET_08F, FRAMESET_090, FRAMESET_091 ; $2d
	dw FRAMESET_092, FRAMESET_093, FRAMESET_094, FRAMESET_095 ; $2e
	dw FRAMESET_096, FRAMESET_097, FRAMESET_098, FRAMESET_099 ; $2f
	dw FRAMESET_09A, FRAMESET_09B, FRAMESET_09C, FRAMESET_09D ; $30
	dw FRAMESET_09E, FRAMESET_09F, FRAMESET_0A0, FRAMESET_0A1 ; $31
	dw FRAMESET_0A2, FRAMESET_0A3, FRAMESET_0A4, FRAMESET_0A5 ; $32
	dw FRAMESET_0A6, FRAMESET_0A7, FRAMESET_0A8, FRAMESET_0A9 ; $33
