Func_305c::
	farcall $77, $4000
	ret

Func_3061::
	xor a
Func_3062::
	farcall $77, $4006
	ret

Func_3067::
	farcall $77, $400f
	ret

Func_306c::
	farcall $77, $4012
	ret

Func_3071::
	ld a, $04
Func_3073::
	farcall $77, $4009
	ret

Func_3078::
	farcall $77, $401b
	ret

Func_307d::
	farcall $77, $401e
	ret

Func_3082::
	farcall $77, $4018
	ret

Func_3087::
	ldh a, [hBankROM]
	push af
.asm_308a
	ld a, [wd54c]
	or a
	jr z, .asm_30a5
	cp $06
	jr c, .asm_3096
	ld a, $01
.asm_3096
	ld l, a
	ld a, $01
	ld [wd54c], a
	ld a, l
	ld hl, PointerTable_30aa
	call JumpToFunctionInTable
	jr .asm_308a
.asm_30a5
	pop af
	call BankswitchROM
	ret

PointerTable_30aa::
	dw Func_30b6
	dw Func_30b6
	dw Func_30b7
	dw Func_30d6
	dw Func_30ef
	dw Func_314a

Func_30b6::
	ret

Func_30b7::
	ld hl, wd583
	bit 6, [hl]
	jr nz, .asm_30ca
	bit 7, [hl]
	jr nz, .asm_30d1
	ld a, $02
	farcall Func_d698
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
	farcall $7, $65a2
	jr c, .asm_30e8
	ld a, $f1
	farcall Func_d6d3
	ret
.asm_30e8
	ld a, $f1
	farcall Func_d6e3
	ret

Func_30ef::
	ld a, [wd54d]
	or a
	jr nz, .asm_312e
	farcall $7, $78bd
	ld a, $00
	farcall Func_d698
	jr nz, .asm_3108
	ld a, $00
	ld [wd550], a
	jr .asm_310d
.asm_3108
	ld a, $01
	ld [wd550], a
.asm_310d
	ld a, $04
	ld [wd54c], a
	ld a, $01
	ld [wd54d], a
	ld a, $00
	ld [wd589], a
	ld a, $0e
	ld [wd587], a
	farcall Func_ea30
	ld a, $56
	call Func_3073
	farcall $11, $499e
.asm_312e
	farcall $f, $4000
	ld a, $00
	ld [wd589], a
	ld a, $00
	ld [wd587], a
	ld a, $02
	ld [wd54c], a
	ld a, $02
	ld [wd54d], a
	call Func_3087
	ret

Func_314a::
	farcall $4, $7890
	ld a, $00
	ld [wd54c], a
	ret

Func_3154::
	ld c, a
	ldh a, [hBankROM]
	push af
	ld a, [$d551]
	call BankswitchROM
	ld hl, $d552
	ld a, [hli]
	ld h, [hl]
	ld l, a
	or h
	jr z, .asm_318b
.asm_3167
	ld a, [hli]
	cp $ff
	jr z, .asm_3186
	cp c
	jr z, .asm_3173
	inc hl
	inc hl
	jr .asm_3167
.asm_3173
	push bc
	call Func_3191
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
.asm_3186
	ld a, c
	farcall Func_c12e
.asm_318b
	pop af
	call BankswitchROM
	scf
	ret

Func_3191::
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp hl

Func_3195::
	ld a, [wd550]
	farcall $4, $4dcb
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
	ld a, [wd550]
	farcall $4, $4d58
	bit 5, a
	jr z, .asm_31f8
	ldh a, [hKeysHeld]
	bit 1, a
	jr nz, .asm_31d8
	ld a, [wd550]
	farcall $4, $4deb
	ld a, $01
	cp c
	jr z, .asm_3204
	ld a, [wd550]
	farcall $4, $4de3
	sla e
	dec c
	farcall $4, $4de7
	jr .asm_3204
.asm_31d8
	ld a, [wd550]
	farcall $4, $4deb
	ld a, $02
	cp c
	jr z, .asm_3204
	bit 0, e
	jr nz, .asm_3204
	ld a, [wd550]
	farcall $4, $4de3
	srl e
	inc c
	farcall $4, $4de7
	jr .asm_3204
.asm_31f8
	ld a, $06
	ld [$d582], a
	ld a, [wd550]
	farcall $4, $4dd7
.asm_3204
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
	farcall $4, $4d77
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
	ld hl, $d592
	ld a, [hl]
	call BankswitchROM
	ld hl, $d593
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp hl

Func_324d::
	ld a, [wd550]
	farcall $4, $4da7
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
	farcall $4, $4dfb
	cp $ff
	jr z, .asm_32a7
	push af
	call Func_3195
	pop af
	farcall $4, $4dcf
	pop hl
	call Func_344c
	ret
.asm_32a7
	pop hl
	scf
	ret

Func_32aa::
	push hl
	farcall Func_d3e9
	farcall $4, $4dfb
	cp $ff
	jr z, .asm_32bc
	pop hl
	call Func_344c
	ret
.asm_32bc
	pop hl
	scf
	ret

Func_32bf::
	ld a, [wd550]
	farcall $4, $4dcb
	ld a, $00
	cp b
	jr nz, .asm_32d6
	ld a, [wd550]
	farcall $4, $4da7
	call Func_324d.asm_3254
	ret
.asm_32d6
	scf
	ret

Func_32d8::
	call Func_32f6
	jr nc, .asm_32f5
	ldh a, [hKeysPressed]
	bit 0, a
	jr nz, .asm_32e9
	bit 3, a
	jr nz, .asm_32f0
	jr .asm_32f5
.asm_32e9
	ld a, $08
	ld [$d582], a
	jr .asm_32f5
.asm_32f0
	ld a, $12
	ld [$d582], a
.asm_32f5
	ret

Func_32f6::
	ldh a, [hKeysHeld]
	and $f0
	jr z, .asm_3330
	ld b, $00
	bit 6, a
	jr nz, .asm_330d
	inc b
	bit 4, a
	jr nz, .asm_330d
	inc b
	bit 7, a
	jr nz, .asm_330d
	inc b
.asm_330d
	ld c, $01
	ldh a, [hKeysHeld]
	bit 1, a
	jr z, .asm_3316
	inc c
.asm_3316
	ld a, [wd550]
	farcall $4, $4e3c
	or a
	jr z, .asm_3330
	ld a, $05
	ld [$d582], a
	ld a, [wd550]
	farcall $4, $4dd3
	scf
	ccf
	jr .asm_3331
.asm_3330
	scf
.asm_3331
	ret

Func_3332::
	call DoFrame
	ret

Func_3336::
.asm_3336
	call DoFrame
	farcall $7, $493c
	jr nz, .asm_3336
	ret

Func_3340::
.asm_3340
	call DoFrame
	farcall $4, $4df3
	jr z, .asm_3361
	ld a, [wd550]
	farcall $4, $4d58
	bit 2, a
	jr nz, .asm_3340
	bit 4, a
	jr z, .asm_3340
	ld a, [wd550]
	farcall $4, $4dd7
	jr .asm_3340
.asm_3361
	ld a, [wd550]
	farcall $4, $4dd7
	farcall $4, $4eff
	ret

Func_336d::
	push af
.asm_336e
	call DoFrame
	farcall $4, $4d58
	bit 5, a
	jr z, .asm_337d
	pop af
	push af
	jr .asm_336e
.asm_337d
	pop af
	ret

Func_337f::
	push af
.asm_3380
	call DoFrame
	pop af
	push af
	farcall $4, $4d58
	bit 4, a
	jr nz, .asm_3380
	pop af
	ret

Func_338f::
	push af
	farcall $7, $4990
	farcall $4, $509f
	call DoFrame
	pop af
	ld b, $00
	farcall $7, $4909
	ret

Func_33a3::
	ld b, $00
	farcall $7, $4927
	call Func_3336
	farcall $4, $50a8
	ld a, $ef
	farcall Func_d6e3
	ret

Func_33b7::
	ld a, [$d586]
	ld c, a
	ld b, $00
	sla c
	add c
	ld c, a
	rl b
	ld hl, $4651
	add hl, bc
	ld a, [hli]
	ld c, a
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, c
	ld de, $d561
	ld bc, $5
	call CopyFarHLToDE
	ld a, [$d562]
	ld [$d551], a
	ld [$d58b], a
	ld a, [$d563]
	ld [$d552], a
	ld [$d58c], a
	ld a, [$d564]
	ld [$d553], a
	ld [$d58d], a
	ret

Func_33f2::
	ld hl, wd618
	or a
	jr nz, .asm_3405
	xor a
	ld [wd616], a
	ld [wd617], a
	ld [hl], a
	ld a, $10
	ld [wd61d], a
.asm_3405
	res 6, [hl]
	ldh a, [hBankROM]
	ld [wd619], a
	; pop return address from stack
	pop hl
	ld a, l
	ld [wd61b + 0], a
	ld a, h
	ld [wd61b + 1], a
	farcall Func_dbdb
.asm_3419
	farcall Func_dbf2
	ld a, [wd618]
	bit 7, a
	jr nz, .asm_342a
	bit 6, a
	jr nz, .asm_342a
	jr .asm_3419
.asm_342a
	ld a, [wd619]
	call BankswitchROM
	ld hl, wd61b
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

Func_3485::
	ld hl, $0
	rl e
	rl d
	ld a, $10
.asm_348e
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
	jr nc, .asm_34a4
	ld h, a
	add sp, $02
	scf
	jr .asm_34a5
.asm_34a4
	pop hl
.asm_34a5
	rl e
	rl d
	ld a, [wd678]
	dec a
	jr nz, .asm_348e
	ld a, h
	or l
	ret

Func_34b2::
.asm_34b2
	call DoFrame
	dec a
	jr nz, .asm_34b2
	ret

CoreGameLoop::
	farcall _CoreGameLoop
	ret

Func_34be::
	farcall $4, $4000
	ret

Func_34c3::
.asm_34c3
	ldh a, [rSTAT]
	and $03
	jr nz, .asm_34c3
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

Func_34d4::
	push af
	push bc
	push de
	call Func_34e5
	pop de
	pop bc
	pop af
	ret

Func_34de::
	ld a, b
	cp d
	ret c
	ret nz
	ld a, c
	cp e
	ret

Func_34e5::
	call Func_34de
	jr c, .asm_34ee
	push bc
	push de
	pop bc
	pop de
.asm_34ee
	ld hl, $0
	ld a, $10
.asm_34f3
	rr d
	rr e
	jr nc, .asm_34fa
	add hl, bc
.asm_34fa
	sla c
	rl b
	dec a
	jr nz, .asm_34f3
	ret

Func_3502::
	push af
	ld a, c
	or b
	jr nz, .asm_3509
	pop af
	ret
.asm_3509
	pop af
	inc b
.asm_350b
	ld [hli], a
	dec c
	jr nz, .asm_350b
	dec b
	jr nz, .asm_350b
	ret

Func_3513::
	ld a, c
	or b
	jr nz, .asm_3518
	ret
.asm_3518
	inc b
.asm_3519
	ld a, [hli]
	ld [de], a
	inc de
	dec c
	jr nz, .asm_3519
	dec b
	jr nz, .asm_3519
	ret

Func_3523::
	ld [$ce4d], a
	ldh [rSVBK], a
	ret

Func_3529::
	push af
	and a
	jr z, .asm_3533
.asm_352d
	call DoFrame
	dec a
	jr nz, .asm_352d
.asm_3533
	pop af
	ret

Func_3535::
	ld c, a
.asm_3536
	ld a, [hli]
	cp $ff
	jr z, .asm_355a
	cp c
	jr nz, .asm_3555
	ldh a, [hBankROM]
	push af
	call .asm_354b
	pop af
	call BankswitchROM
	scf
	ccf
	ret

.asm_354b
	ld a, [hli]
	push af
	ld a, [hli]
	ld h, [hl]
	ld l, a
	pop af
	call BankswitchROM
	jp hl
.asm_3555
	inc hl
	inc hl
	inc hl
	jr .asm_3536
.asm_355a
	scf
	ret

Func_355c::
	jp hl

Func_355d::
	push bc
	ret

Func_355f::
	ld hl, $0
	rl c
	rl b
	ld a, $10
.asm_3568
	ldh [$ffc0], a
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
	add sp, $02
	scf
	jr .asm_357e
.asm_357d
	pop hl
.asm_357e
	rl c
	rl b
	ldh a, [$ffc0]
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
	ld de, $407f
	call SetupText
	pop hl
	pop de
	pop bc
	pop af
	ret

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

Func_35df::
	call Func_35af
	push bc
	push de
	ld bc, $c00
	ld de, $40
	farcall $7, $408b
	pop de
	pop bc
	ret

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
	ld b, [hl]
	inc hl
	ld c, [hl]
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
	ld a, [$d7e1]
	call BankswitchROM
	ld a, [$d7e2]
	ld l, a
	ld a, [$d7e3]
	ld h, a
	or l
	jr z, Func_36b8.asm_3724
	ld a, [hli]
	ld c, a
	ld b, $00
	add hl, bc
	ld de, $d7ee
;	fallthrough

Func_36b8::
	push bc
	push hl
	ld a, [de]
	and a
	jr nz, .asm_3713
	ld a, [hli]
	ld c, a
	ld a, [hli]
	ld b, a
	push bc
	ld c, [hl]
	inc hl
	ld b, [hl]
	farcall Func_12c06e
	ld a, b
	ld [$d7e7], a
	pop bc
	ld a, l
	ld [$d7e5], a
	ld a, h
	ld [$d7e6], a
	ldh a, [hBankROM]
	push af
	ld a, [$d7e7]
	call BankswitchROM
	push bc
	inc de
	ld a, [de]
	add a
	add a
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
	ld a, [$d7e5]
	ld l, a
	ld a, [$d7e6]
	ld h, a
	ld a, $00
	ld [de], a
	jr .asm_36eb
.asm_36fe
	ld a, [hli]
	ld e, a
	ld a, [hli]
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
	jr z, .asm_3724
	jp Func_36b8
.asm_3724
	pop af
	call BankswitchROM
	pop hl
	pop de
	pop bc
	pop af
	ret

Func_372d::
	ldh a, [hBankROM]
	push af
	ld a, [$d7de]
	call BankswitchROM
	ld a, [$d7df]
	ld l, a
	ld a, [$d7e0]
	ld h, a
	inc hl
	inc hl
	sla e
	rl d
	sla e
	rl d
	sla e
	rl d
	sla e
	rl d
	add hl, de
	ld a, b
	xor $01
	ld b, c
	ld c, 1
	call CopyTilesToTiles1
	pop af
	call BankswitchROM
	ret

Func_375f::
	push af
	push bc
	push de
	push hl
	ldh a, [hBankROM]
	push af
	ld a, [$d7e1]
	call BankswitchROM
	ld a, [$d7e2]
	ld l, a
	ld a, [$d7e3]
	ld h, a
	or l
	jr z, .asm_3783
	ld de, $d7ee
	ld a, [hli]
	ld c, a
.asm_377c
	ld a, [hli]
	ld [de], a
	inc de
	inc de
	dec c
	jr nz, .asm_377c
.asm_3783
	pop af
	call BankswitchROM
	pop hl
	pop de
	pop bc
	pop af
	ret

Func_378c::
	ld c, $02
	call Func_3861
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
	jr z, .asm_37be
	ld a, [wConsole]
	cp CONSOLE_CGB
	jr nz, .asm_37be
	push hl
	push bc
	ld bc, $1000
	add hl, bc
	pop bc
	ld a, c
	or a
	jr z, .asm_37bb
	xor a ; BANK("VRAM0")
	ld b, $00
	call CopyTilesToTiles1
.asm_37bb
	pop hl
	ld c, $00
.asm_37be
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
	ld a, [$d896]
	ld c, a
	ld a, [$d897]
	ld b, a
	or c
	jr z, .asm_3823
	farcall $7, $493c
	jr nz, .asm_3823
	farcall $7, $4941
	cp $02
	jr z, .asm_3823
	ld a, [$d899]
	dec a
	ld [$d899], a
	jr nz, .asm_3823
	ld a, [$d898]
	ld [$d899], a
	farcall GetPaletteGfxPointer
	ldh a, [hBankROM]
	push af
	ld a, b
	call BankswitchROM
	ld a, [hli]
	ld b, a
	ld a, [$d89a]
	ld c, a
	inc a
	cp b
	jr nz, .asm_3810
	xor a
.asm_3810
	ld [$d89a], a
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
	farcall $4, $4673
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
; c = starting CGB BG pal number
Func_3861::
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
	sla c ; *CGB_PAL_SIZE
	ld hl, wBackgroundPalettesCGB
	add hl, bc
	ld d, h
	ld e, l
	pop hl
	ld a, [hli]
	ld c, a
.loop_pals
	ld b, CGB_PAL_SIZE
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

Func_389d::
	push af
	push bc
	push de
	push hl
	xor a
	call BankswitchVRAM
	call DrawRegularTextBox
	pop hl
	pop de
	pop bc
	pop af
	ret

Func_38ad::
	push af
	push bc
	push de
	push hl
	xor a
	call BankswitchVRAM
	call DrawLabeledTextBox
	pop hl
	pop de
	pop bc
	pop af
	ret

Func_38bd::
	ldh a, [hBankROM]
	push af
	ld a, b
	call BankswitchROM
	push hl
	ld b, $00
	sla c
	sla c
	sla c
	ld hl, wcb2e
	add hl, bc
	ld d, h
	ld e, l
	pop hl
	ld a, [hli]
	ld c, a
	push bc
.loop_pals
	ld b, CGB_PAL_SIZE
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

Func_38e8::
	push bc
	push de
	push hl
	ld a, [wd942]
	push af
	ldh a, [hBankROM]
	push af
	ld a, b
	call BankswitchROM
	ld a, [hli]
	ld c, a
	ld a, [hli]
	ld a, [wd942]
	ld e, a
.asm_38fd
	push bc
	ld a, e
	and $7f
	ld b, a
	ld c, $01
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
	jr nz, .asm_38fd
	ld a, e
	ld [wd942], a
	pop af
	call BankswitchROM
	pop af
	pop hl
	pop de
	pop bc
	ret

; input:
; a = ?
; b:hl = sprite animation pointer
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
	bit 6, a
	jr z, .asm_3953
	ld a, e
	xor $ff
	inc a
	ld e, a
.asm_3953
	ldh a, [hSCY]
	ld c, a
	ld a, e
	sub c
	ld e, a
	ld a, [hli] ; x
	add d
	ld d, a
	ld a, [wd96f]
	bit 5, a
	jr z, .asm_3968
	ld a, d
	xor $ff
	inc a
	ld d, a
.asm_3968
	ldh a, [hSCX]
	ld c, a
	ld a, d
	sub c
	ld d, a
	ld a, [hli]
	add b
	ld c, a
	ld a, [wd96f]
	ld b, a
	ld a, [hli] ; attributes
	xor b
	ld b, a
	ld a, c
	bit 7, a
	jr z, .asm_3981
	set OAM_TILE_BANK, b
	res 7, c
.asm_3981
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

Func_3992::
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
	rl b
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
	ld d, a
.asm_39ba
	ld a, [wd970]
	bit 6, a
	jr z, .asm_39c6
	ld a, e
	xor $ff
	inc a
	ld e, a
.asm_39c6
	pop af
	call BankswitchROM
	pop hl
	ret

Func_39cc::
	push af
	push hl
.asm_39ce
	ld a, [hl]
	cp $ff
	jr z, .asm_39e0
	push hl
	ld a, [hli]
	ld h, [hl]
	ld l, a
	farcall $4, $502c
	pop hl
	inc hl
	inc hl
	jr .asm_39ce
.asm_39e0
	pop hl
	pop af
	ret

Func_39e3::
	xor a
	ld [$d9bd], a
	ret

Func_39e8::
	push af
	push bc
	push hl
	ld hl, $d9bd
	ld a, [hl]
	inc [hl]
	add a
	ld c, a
	ld b, $00
	ld hl, $d9be
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

Func_3a0e::
	push af
	push bc
	push hl
	ld hl, $d9bd
	dec [hl]
	ld a, [hl]
	add a
	ld c, a
	ld b, $00
	ld hl, $d9be
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

Func_3a2c::
	push af
	push bc
	push de
	push hl
	farcall $7, $46c2
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
	farcall $4, $4417
	farcall $4, $48cd
	and a
	jr nz, .asm_3a50
	ld e, $01
	farcall $4, $5384
	jr .asm_3a56
.asm_3a50
	ld e, $10
	farcall $4, $4ea3
.asm_3a56
	farcall $7, $757b
	farcall Func_109fa
	call Func_3698
	call Func_37ce
	farcall $7, $46c2
	pop hl
	pop de
	pop bc
	pop af
	ret

Func_3a6d::
	push af
	push bc
	push de
	push hl
	call Func_3f78
	farcall Func_109fa
	farcall $7, $46c2
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
	farcall $7, $6088
	ld a, [$dcea]
	cp $ff
	jr nz, .asm_3a94
	farcall Func_109fa
.asm_3a94
	pop hl
	pop de
	pop bc
	pop af
	ret

Func_3a99::
	push af
	push bc
	push de
	push hl
	farcall $7, $40ec
	add $00
	ld d, b
	ld e, c
	ld c, $00
	ld b, $00
	farcall $4c, $4000
	pop hl
	pop de
	pop bc
	pop af
	ret

Func_3ab2::
	push af
	push bc
	push de
	push hl
	cp $04
	jr nc, .asm_3abc
	ld e, $00
.asm_3abc
	farcall $7, $4101
	ld h, e
	ld d, b
	ld e, c
	ld c, h
	ld b, $01
	farcall $4c, $4000
	pop hl
	pop de
	pop bc
	pop af
	ret

Func_3acf::
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
	ld de, $240
	call Func_34d4
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

Func_3b02::
	push af
	push bc
	push de
	ld a, $02
	dec e
	jr nz, .asm_3b0c
	add $03
.asm_3b0c
	ld c, a
	call Func_3861
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

Func_3b2b::
	push af
	push bc
	push de
	push hl
	ldh a, [hBankROM]
	push af
	ld a, b
	call BankswitchROM
	farcall $4, $4673
	ld a, d
	ld [$d9e3], a
	ld a, e
	ld [$d9e4], a
	ld a, [hli]
	ld [$d9e7], a
	ld a, [hli]
	ld [$d9e5], a
	ld a, [hli]
	ld [$d9e6], a
	ld a, [hli]
	ld [$d9ec], a
	ld a, [hli]
	ld [$d9ed], a
	ld a, [hli]
	ld [$d9ee], a
	ld a, [hli]
	ld [$d9ef], a
	ld a, [hli]
	ld [$d9f0], a
	ld a, [hli]
	ld [$d9f1], a
	ld a, [hli]
	ld [$d9ea], a
	ld a, [hli]
	ld [$d9eb], a
	ld a, [hli]
	ld [$da34], a
	ld a, [hli]
	ld [$da35], a
	ld a, [hli]
	ld [$d9e8], a
	ld a, [hli]
	ld [$d9e9], a
	ld bc, $0
.asm_3b81
	ld a, [hl]
	cp $ff
	jr z, .asm_3bb0
	push bc
	push de
	ld a, [hli]
	add d
	push hl
	ld hl, $d9f3
	add hl, bc
	ld [hl], a
	pop hl
	ld a, [hli]
	add e
	push hl
	ld hl, $da03
	add hl, bc
	ld [hl], a
	pop hl
	ld a, [hli]
	ld e, a
	ld a, [hli]
	ld d, a
	push hl
	ld hl, $da13
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
	jr .asm_3b81
.asm_3bb0
	ld a, c
	ld [$d9f2], a
	xor a
	ld [$da38], a
	pop af
	call BankswitchROM
	pop hl
	pop de
	pop bc
	pop af
	ret

Func_3bc1::
	push af
	push hl
	ld c, a
	ldh a, [hBankROM]
	push af
	ld a, $4c
	call BankswitchROM
	ld b, $00
	sla c
	rl b
	ld hl, $405b
	add hl, bc
	ld c, [hl]
	inc hl
	ld b, [hl]
	pop af
	call BankswitchROM
	pop hl
	pop af
	ret

Func_3be0::
	push af
	push hl
	ldh a, [hBankROM]
	push af
	ld a, b
	call BankswitchROM
	ld b, $00
	sla c
	add hl, bc
	ld b, [hl]
	inc hl
	ld c, [hl]
	ld a, e
	ld e, c
	srl e
	srl e
.asm_3bf7
	srl a
	and a
	jr z, .asm_3c00
	sla e
	jr .asm_3bf7
.asm_3c00
	ld a, c
	and $03
	ld c, a
	pop af
	call BankswitchROM
	pop hl
	pop af
	ret

Func_3c0b::
	farcall $7, $4e92
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
	ld c, $02
	call Func_3861
	pop hl
	pop de
	pop bc
	pop af
	ret

Func_3c3c::
	ret

Func_3c3d::
	farcall $7, $5ef1
	ret

Func_3c42::
	push af
	call Func_3c55
	farcall $7, $5fb9
	farcall $4, $50b9
	ld a, $01
	ld [$dc57], a
	pop af
	ret

Func_3c55::
	push af
	ld a, [$dc57]
	and a
	jr z, .asm_3c60
	farcall $4, $50c2
.asm_3c60
	xor a
	ld [$dc57], a
	ld [$dc5e], a
	ld [$dc5f], a
	farcall $7, $5fb9
	pop af
	ret

Func_3c70::
	ld [$dce2], a
	call Func_3c77
	ret

Func_3c77::
	ldh a, [hBankROM]
	push af
	ld [$dce9], a
	farcall $7, $5ff5
	pop af
	call BankswitchROM
	ret

Func_3c86::
	farcall $7, $6420
	scf
	ret nz
	ccf
	ret

Func_3c8e::
	ld a, [$dce2]
	cp $9e
	jr z, .asm_3ca8
	ld a, [$dce2]
	sub $96
	add a
	ld c, a
	ld b, $00
	ld hl, Data_3cb3
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp Func_3cc3
.asm_3ca8
	ld a, [$dce6]
	ld l, a
	ld a, [$dce7]
	ld h, a
	jp Func_3cc3

Data_3cb3::
	dw $4C62, $4CA0, $4D07, $4D0B
	dw $4D0B, $4D0B, $4D0B, $4D0B

Func_3cc3::
	ld a, $ff
	ld [$dcf0], a
	ldh a, [hBankROM]
	push af
	ld a, [$dce9]
	call BankswitchROM
	call Func_355c
	pop af
	call BankswitchROM
	xor a
	ld [$dcf0], a
	ret

Func_3cdd::
	xor a
	ld [$dd04], a
	ld [$dd05], a
	ret

Func_3ce5::
	push bc
	push hl
	ld hl, $dd04
	ld b, [hl]
	cp b
	jr z, .asm_3cf4
	ld [$dd04], a
	call Func_3062
.asm_3cf4
	pop hl
	pop bc
	ret

Func_3cf7::
	push af
	xor a
	call Func_3ce5
	pop af
	ret

Func_3cfe::
	call Func_3073
	ret

Func_3d02::
	push af
	xor a
	call Func_3cfe
	pop af
	ret

Func_3d09::
	call Func_3062
	ret

Func_3d0d::
	push af
	call Func_3d1f
	call Func_3078
	pop af
	ret

Func_3d16::
	push af
	call Func_3d32
	call Func_307d
	pop af
	ret

Func_3d1f::
	push bc
	ld a, [$dd05]
	ld b, a
	ld a, [$dd06]
	or b
	ld [$dd06], a
	ld a, $ff
	ld [$dd05], a
	pop bc
	ret

Func_3d32::
	xor a
	ld [$dd05], a
	ld [$dd04], a
	ret

Func_3d3a::
	call Func_3082
	ret

Func_3d3e::
	push af
.asm_3d3f
	call DoFrame
	call Func_3067
	or a
	jr nz, .asm_3d3f
	pop af
	ret

Func_3d4a::
	ld a, [$dd06]
	and a
	ret

Func_3d4f::
	xor a
	ld [$dd06], a
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
Func_3d61::
	push af
	push bc
	push de
	ld a, c
	ld [$dd2f], a
	ldh a, [hBankROM]
	push af
	ld a, b
	call BankswitchROM
	ld a, [hli]
	ld c, a
	ld a, [hli]
	ld b, a
	call Func_3d90
	ld a, [hli]
	ld c, a
	ld a, [hli]
	ld b, a
	ld a, [$dd2f]
	call Func_3db2
	ld a, [hli]
	ld c, a
	ld a, [hli]
	ld b, a
	farcall Func_12e68
	pop af
	call BankswitchROM
	pop de
	pop bc
	pop af
	ret

; bc = TILESET_* constant
Func_3d90::
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
Func_3db2::
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
	call Func_3861
	pop af
	call BankswitchROM
	pop hl
	pop de
	pop bc
	pop af
	ret

; input:
; a = ?
; b = bank
; c = pal index
Func_3dcf::
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
	jr z, .asm_3dfb
	farcall Func_10948
	jr .asm_3dff
.asm_3dfb
	farcall Func_1090e
.asm_3dff
	farcall Func_10959
	farcall Func_10a1e
	ld a, [wdd25 + 0]
	ld c, a
	ld a, [wdd25 + 1]
	ld b, a
	farcall Func_12c2a6
	farcall Func_10cad
	ld a, [wdd27 + 0]
	ld c, a
	ld a, [wdd27 + 1]
	ld b, a
	farcall Func_10ccb
	ld a, [wdd29 + 0]
	ld c, a
	ld a, [wdd29 + 1]
	ld b, a
	farcall Func_10c5a
	ld a, [wdd2b + 0]
	ld c, a
	ld a, [wdd2b + 1]
	ld b, a
	farcall GetPaletteGfxPointer
	ld a, [wdd2e]
	ld c, a
	call Func_38bd
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
	farcall $4, $50ac
	ret

Func_3e54::
	farcall $4, $50b5
	farcall $4, $4d40
	ret

Func_3e5d::
	push af
	farcall $4, $429d
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
	farcall $4, $7ac1
	pop hl
	pop de
	pop bc
	pop af
	ret

Func_3e87::
	push af
	push hl
	ldh a, [rSVBK]
	push af
	ld a, $01
	ldh [rSVBK], a
	call Func_3f53
	ld hl, rSTAT
	res 2, [hl]
	ei
	ld hl, $de66
	ld a, [hl]
	or a
	jr nz, .asm_3edd
	inc [hl]
	push bc
	push de
	xor a
	ld [$de67], a
.asm_3ea7
	ld a, [$de67]
	ld b, a
.asm_3eab
	ldh a, [rLY]
	cp $60
	jr nc, .asm_3ec8
	cp b
	jr c, .asm_3eab
	call Func_3f23
	ld hl, rSTAT
.asm_3eba
	bit 1, [hl]
	jr nz, .asm_3eba
	ldh [rSCX], a
	ldh a, [rLY]
	inc a
	ld [$de67], a
	jr .asm_3ea7
.asm_3ec8
	xor a
	ldh [rSCX], a
	ld a, $00
	ldh [rLYC], a
	call Func_3f23
	ldh [hSCX], a
	pop de
	pop bc
	xor a
	ld [$de66], a
	call Func_3f45
.asm_3edd
	pop af
	ldh [rSVBK], a
	pop hl
	pop af
	ret

Data_3ee3::
	db $00, $00, $00, $01, $01, $01, $02, $02
	db $02, $03, $03, $03, $03, $03, $03, $03
	db $04, $03, $03, $03, $03, $03, $03, $03
	db $02, $02, $02, $01, $01, $01, $00, $00
	db $00, $FF, $FF, $FF, $FE, $FE, $FE, $FD
	db $FD, $FD, $FC, $FC, $FC, $FC, $FC, $FC
	db $FB, $FC, $FC, $FC, $FC, $FC, $FC, $FD
	db $FD, $FD, $FE, $FE, $FE, $FF, $FF, $FF

Func_3f23::
	ld hl, wVBlankCounter
	add [hl]
	and $3f
	ld c, a
	ld b, $00
	ld hl, Data_3ee3
	add hl, bc
	ld a, [$de65]
	ld c, a
	ld a, [hl]
	dec c
	jr z, .asm_3f44
	dec c
	jr z, .asm_3f42
	dec c
	jr z, .asm_3f40
	sra a
.asm_3f40
	sra a
.asm_3f42
	sra a
.asm_3f44
	ret

Func_3f45::
	push hl
	ld hl, rSTAT
	set 6, [hl]
	xor a
	ld hl, rIE
	set 1, [hl]
	pop hl
	ret

Func_3f53::
	push hl
	ld hl, rSTAT
	res 6, [hl]
	xor a
	ld hl, rIE
	res 1, [hl]
	pop hl
	ret

Func_3f61::
	di
	xor a
	ld [$de69], a
	ld [$de6a], a
	ei
	ret

Func_3f6b::
	di
	push af
	ld a, l
	ld [$de69], a
	ld a, h
	ld [$de6a], a
	pop af
	ei
	ret

Func_3f78::
	push af
	ld hl, $de69
	ld a, [hli]
	or [hl]
	jr nz, .asm_3f82
	pop af
	ret
.asm_3f82
	ld a, [hld]
	ld l, [hl]
	ld h, a
	pop af
	jp hl

Func_3f87::
	ret
