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

Func_12c084:
	push af
	sla c
	rl b
	sla c
	rl b
	ld hl, GfxUnknown3
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
Func_12c2a6::
	push bc
	push de
	push hl
	ld hl, wd944
	ld a, [wd943]
	and a
	jr z, .asm_12c2c3
	ld e, a
.asm_12c2b3
	ld a, [hl]
	cp c
	jr nz, .asm_12c2bc
	inc hl
	ld a, [hld]
	cp b
	jr z, .asm_12c2d8
.asm_12c2bc
	inc hl
	inc hl
	inc hl
	inc hl
	dec e
	jr nz, .asm_12c2b3
.asm_12c2c3
	push bc
	push hl
	ld hl, wd943
	inc [hl]
	call GetTilesetGfxPointer
	call Func_38e8
	pop hl
	pop bc
	ld [hl], c
	inc hl
	ld [hl], b
	inc hl
	ld [hl], a
	jr .done
.asm_12c2d8
	inc hl
	inc hl
	ld a, [hl]
.done
	pop hl
	pop de
	pop bc
	ret

Func_12c2df:
	push af
	push bc
	push de
	push hl
	ld a, [hl]
	and $d0
	jr z, .done
	push hl
	call Func_12c3c6
	call Func_12c345
	jr nz, .asm_12c33c
	call Func_12c35c
	ld hl, wd976
	bit 4, [hl]
	jr z, .asm_12c2fe
	call Func_12c34f
.asm_12c2fe
	ld a, [wd97c]
	ld c, a
	ld a, [wd97d]
	ld b, a
	call Func_12c084
	ld a, [wd97b]
	ld c, a
	call Func_3992
	ld a, c
	ld [wd975], a
	ld hl, wd976
	bit 6, [hl]
	jr z, .asm_12c33c
	ld a, [wd980 + 0]
	ld c, a
	ld a, [wd980 + 1]
	ld b, a
	call GetSpriteAnimationGfxPointer
	ld a, [wd975]
	ld c, a
	cp $ff
	jr z, .asm_12c33c
	ld a, [wd979]
	ld d, a
	ld a, [wd97a]
	ld e, a
	ld a, [wd97f]
	call Func_3924
.asm_12c33c
	pop hl
	call Func_12c3d0
.done
	pop hl
	pop de
	pop bc
	pop af
	ret

Func_12c345:
	ld a, [wd983]
	and a
	ret z
	dec a
	ld [wd983], a
	ret

Func_12c34f:
	ld a, [wd97e]
	dec a
	ld [wd97e], a
	and a
	ret nz
	call Func_12c36a
	ret

Func_12c35c:
	ld a, [wd97b]
	ld b, a
	ld a, [wd97e]
	or b
	ret nz
	ld a, $ff
	ld [wd97b], a
Func_12c36a:
	ld a, [wd97b]
	inc a
	ld [wd97b], a
.asm_12c371
	ld a, [wd97c]
	ld c, a
	ld a, [wd97d]
	ld b, a
	call Func_12c084
	ld a, [wd97b]
	ld c, a
	call Func_3992
	ld a, b
	and a
	jr nz, .asm_12c38d
	xor a
	ld [wd97b], a
	jr .asm_12c371
.asm_12c38d
	cp $ff
	jr nz, .asm_12c396
	ld hl, wd976
	res 4, [hl]
.asm_12c396
	ld a, [wd977]
	bit 2, a
	jr z, .asm_12c39f
	srl b
.asm_12c39f
	ld a, b
	ld [wd97e], a
	ld a, c
	ld [wd975], a
	ld a, d
	ld [wd971], a
	ld a, e
	ld [wd972], a
	ld a, [wd971]
	ld b, a
	ld a, [wd979]
	add b
	ld [wd979], a
	ld a, [wd972]
	ld b, a
	ld a, [wd97a]
	add b
	ld [wd97a], a
	ret

Func_12c3c6:
	ld de, wd976
	ld bc, $e
	call CopyDataHLtoDE_SaveRegisters
	ret

Func_12c3d0:
	ld d, h
	ld e, l
	ld hl, wd976
	ld bc, $e
	call CopyDataHLtoDE_SaveRegisters
	ret

SECTION "Bank 4B@7355", ROMX[$7355], BANK[$4b]

Data_12f355:
	dw $147, $147, $147, $147 ; $00
	dw $148, $148, $148, $148 ; $01
	dw $149, $149, $149, $149 ; $02
	dw $14a, $14a, $14a, $14a ; $03
	dw $14b, $14b, $14b, $14b ; $04
	dw $14c, $14c, $14c, $14c ; $05
	dw $14d, $14d, $14d, $14d ; $06
	dw $14e, $14e, $14e, $14e ; $07
	dw $14f, $14f, $14f, $14f ; $08
	dw $150, $150, $150, $150 ; $09
	dw $151, $151, $151, $151 ; $0a
	dw $152, $152, $152, $152 ; $0b
	dw $153, $153, $153, $153 ; $0c
	dw $155, $155, $155, $155 ; $0d
	dw $0aa, $0ab, $0ac, $0ad ; $0e
	dw $0b0, $0b1, $0b2, $0b3 ; $0f
	dw $0b6, $0b7, $0b8, $0b9 ; $10
	dw $0ba, $0bb, $0bc, $0bd ; $11
	dw $0be, $0be, $0be, $0be ; $12
	dw $0bf, $0c0, $0c1, $0c2 ; $13
	dw $0c3, $0c4, $0c5, $0c6 ; $14
	dw $0c7, $0c8, $0c9, $0ca ; $15
	dw $0cb, $0cc, $0cd, $0ce ; $16
	dw $0cf, $0d0, $0d1, $0d2 ; $17
	dw $0d3, $0d4, $0d5, $0d6 ; $18
	dw $0d7, $0d8, $0d9, $0da ; $19
	dw $0db, $0dc, $0dd, $0de ; $1a
	dw $0df, $0e0, $0e1, $0e2 ; $1b
	dw $0e3, $0e4, $0e5, $0e6 ; $1c
	dw $0e7, $0e8, $0e9, $0ea ; $1d
	dw $0eb, $0ec, $0ed, $0ee ; $1e
	dw $0ef, $0f0, $0f1, $0f2 ; $1f
	dw $0f3, $0f4, $0f5, $0f6 ; $20
	dw $0f7, $0f8, $0f9, $0fa ; $21
	dw $0fb, $0fc, $0fd, $0fe ; $22
	dw $0ff, $100, $101, $102 ; $23
	dw $103, $104, $105, $106 ; $24
	dw $107, $108, $109, $10a ; $25
	dw $10b, $10b, $10b, $10b ; $26
	dw $10c, $10c, $10c, $10c ; $27
	dw $10d, $10d, $10d, $10d ; $28
	dw $10e, $10e, $10e, $10e ; $29
	dw $10f, $110, $110, $10f ; $2a
	dw $111, $111, $111, $111 ; $2b
	dw $08a, $08b, $08c, $08d ; $2c
	dw $08e, $08f, $090, $091 ; $2d
	dw $092, $093, $094, $095 ; $2e
	dw $096, $097, $098, $099 ; $2f
	dw $09a, $09b, $09c, $09d ; $30
	dw $09e, $09f, $0a0, $0a1 ; $31
	dw $0a2, $0a3, $0a4, $0a5 ; $32
	dw $0a6, $0a7, $0a8, $0a9 ; $33
