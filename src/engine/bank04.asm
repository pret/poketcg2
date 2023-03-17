SECTION "Bank 4@490e", ROMX[$490e], BANK[$4]

Func_1090e::
	push af
	push bc
	push de
	ld hl, wd8a2
	ld c, $0a
	ld b, $00 ; unused
	ld de, SCENE_UNK_STRUCT_LENGTH
.asm_1091b
	ld a, [hl]
	bit 7, a
	jr z, .asm_10927
	add hl, de
	dec c
	jr nz, .asm_1091b
	ld hl, $0
.asm_10927
	pop de
	pop bc
	pop af
	ret

SECTION "Bank 4@4948", ROMX[$4948], BANK[$4]

Func_10948::
	push bc
	sla c
	sla c
	sla c
	sla c ; *16 aka SCENE_UNK_STRUCT_LENGTH
	ld b, $00
	ld hl, wd8a2
	add hl, bc
	pop bc
	ret

Func_10959::
	push af
	push bc
	push de
	push hl
	ld a, $d0
	call Func_10ca0
	xor a
	ld bc, $0
	ld de, $0
	call Func_10ca2
	call Func_10a1e
	call Func_10cb7
	call Func_10c7a
	call Func_10ca3
	call Func_10cad
	call Func_10ccb
	call Func_10cc1
	call Func_10c96
	pop hl
	pop de
	pop bc
	pop af
	ret

SECTION "Bank 4@4991", ROMX[$4991], BANK[$4]

Func_10991:
	push af
	push bc
	push de
	push hl
	bit 5, [hl]
	jr z, .done
	push hl
	ld a, [hl]
	and $0e
	ld b, a
	srl b
	ld a, [hl]
	and $01
	inc a
	ld c, a
	inc hl
	inc hl
	inc hl
	ld d, [hl]
	inc hl
	ld e, [hl]
	inc b
	dec b
	jr nz, .asm_109b2
	ld a, e
	sub c
	ld e, a
.asm_109b2
	dec b
	jr nz, .asm_109b8
	ld a, d
	add c
	ld d, a
.asm_109b8
	dec b
	jr nz, .asm_109be
	ld a, e
	add c
	ld e, a
.asm_109be
	dec b
	jr nz, .asm_109c4
	ld a, d
	sub c
	ld d, a
.asm_109c4
	dec b
	jr nz, .asm_109cd
	ld a, d
	add c
	ld d, a
	ld a, e
	sub c
	ld e, a
.asm_109cd
	dec b
	jr nz, .asm_109d6
	ld a, d
	add c
	ld d, a
	ld a, e
	add c
	ld e, a
.asm_109d6
	dec b
	jr nz, .asm_109df
	ld a, d
	sub c
	ld d, a
	ld a, e
	add c
	ld e, a
.asm_109df
	dec b
	jr nz, .asm_109e8
	ld a, d
	sub c
	ld d, a
	ld a, e
	sub c
	ld e, a
.asm_109e8
	ld [hl], e
	dec hl
	ld [hl], d
	ld bc, $9
	add hl, bc
	dec [hl]
	pop hl
	jr nz, .done
	res 5, [hl]
.done
	pop hl
	pop de
	pop bc
	pop af
	ret

Func_109fa::
	push af
	push bc
	push de
	push hl
	call ZeroObjectPositions
	ld hl, wd8a2
	ld c, $0a
.loop
	call Func_10991
	farcall Func_12c2df
	ld de, $10
	add hl, de
	dec c
	jr nz, .loop
	ld a, $01
	ld [wVBlankOAMCopyToggle], a
	pop hl
	pop de
	pop bc
	pop af
	ret

SECTION "Bank 4@4a1e", ROMX[$4a1e], BANK[$4]

Func_10a1e::
	push hl
	inc hl
	inc hl
	inc hl
	ld [hl], d ; SCENE_UNK_STRUCT_3
	inc hl
	ld [hl], e
	pop hl
	ret


SECTION "Bank 4@4c5a", ROMX[$4c5a], BANK[$4]

Func_10c5a::
	push af
	push de
	push hl
	ld de, SCENE_UNK_STRUCT_5
	add hl, de
	xor a
	ld [hli], a ; SCENE_UNK_STRUCT_5
	ld [hl], c ; SCENE_UNK_STRUCT_6
	inc hl
	ld [hl], b
	inc hl
	ld [hl], a ; SCENE_UNK_STRUCT_8
	pop hl
	pop de
	pop af
	ret

Func_10c6c:
	push af
	push de
	push hl
	ld de, SCENE_UNK_STRUCT_6
	add hl, de
	ld [hl], c ; SCENE_UNK_STRUCT_6
	inc hl
	ld [hl], b
	pop hl
	pop de
	pop af
	ret

Func_10c7a:
	push af
	push bc
	push de
	push hl
	inc hl
	ld a, [hl] ; SCENE_UNK_STRUCT_1
	and $fc
	ld [hl], a
	ld de, SCENE_UNK_STRUCT_E - SCENE_UNK_STRUCT_1
	add hl, de
	ld [hl], c ; SCENE_UNK_STRUCT_E
	inc hl
	ld [hl], b
	farcall Func_12c09a
	pop hl
	call Func_10c5a
	pop de
	pop bc
	pop af
	ret

Func_10c96:
	push bc
	push hl
	ld bc, SCENE_UNK_STRUCT_D
	add hl, bc
	ld [hl], a ; SCENE_UNK_STRUCT_D
	pop hl
	pop bc
	ret

Func_10ca0:
	ld [hl], a ; SCENE_UNK_STRUCT_0
	ret

Func_10ca2:
	ret

Func_10ca3:
	push bc
	push hl
	ld bc, SCENE_UNK_STRUCT_8
	add hl, bc
	ld [hl], a ; SCENE_UNK_STRUCT_8
	pop hl
	pop bc
	ret

Func_10cad::
	push bc
	push hl
	ld bc, SCENE_UNK_STRUCT_9
	add hl, bc
	ld [hl], a ; SCENE_UNK_STRUCT_9
	pop hl
	pop bc
	ret

Func_10cb7:
	push bc
	push hl
	ld bc, SCENE_UNK_STRUCT_5
	add hl, bc
	ld [hl], a ; SCENE_UNK_STRUCT_5
	pop hl
	pop bc
	ret

Func_10cc1:
	push bc
	push hl
	ld bc, SCENE_UNK_STRUCT_C
	add hl, bc
	ld [hl], a ; SCENE_UNK_STRUCT_C
	pop hl
	pop bc
	ret

Func_10ccb::
	push bc
	push hl
	push bc
	ld bc, SCENE_UNK_STRUCT_A
	add hl, bc
	pop bc
	ld [hl], c ; SCENE_UNK_STRUCT_A
	inc hl
	ld [hl], b
	pop hl
	pop bc
	ret


SECTION "Bank 4@6e68", ROMX[$6e68], BANK[$4]

; bc = TILEMAP_* constant
Func_12e68::
	push af
	push bc
	push de
	push hl
	farcall GetTilemapGfxPointer
	xor a
	ld c, $80
	farcall Func_12c10b
	pop hl
	pop de
	pop bc
	pop af
	ret
