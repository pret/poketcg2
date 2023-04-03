; handles intro, title screen and start menu
; as well as the core gameplay loop
_CoreGameLoop::
	call Func_c240
.intro
	farcall IntroAndTitleScreen
	ld a, PLAYER_TURN
	ldh [hWhoseTurn], a
	call Func_c249
	xor a
	call PlaySong
	xor a
	call PlaySFX
.start_menu_loop
	call HandleStartMenu
	ld hl, .StartMenuFunctionTable
	call JumpToFunctionInTable
	jr c, .intro
	jr .start_menu_loop

.StartMenuFunctionTable
	dw StartMenu_CardPop           ; STARTMENU_CARD_POP
	dw StartMenu_ContinueFromDiary ; STARTMENU_CONTINUE_FROM_DIARY
	dw StartMenu_NewGame           ; STARTMENU_NEW_GAME
	dw StartMenu_ContinueDuel      ; STARTMENU_CONTINUE_DUEL

StartMenu_NewGame:
	ld hl, wd554
	bit 0, [hl]
	jr z, .no_save_data
	farcall AskToOverwriteSaveData
	ret c
.no_save_data
	farcall $6, $58f8
	call Func_e97a
	call Func_c24d
	call Func_eb97
	xor a
	farcall Func_1d475
	ld a, $04
	ld [wd54c], a
	xor a
	ld [wd54d], a
	call Func_3087
	scf
	ret

StartMenu_ContinueFromDiary:
	ld hl, wd554
	bit 2, [hl]
	jr z, .asm_c067
	bit 1, [hl]
	jr z, .asm_c067
	farcall AskToContinueFromDiaryInsteadOfDuel
	ret c
.asm_c067
	call Func_eaea
	xor a
	call PlaySong
	ld a, [wd54c]
	cp $04
	jr z, .asm_c0a0
	cp $03
	jr z, .asm_c0ab
	ld a, [wd550]
	ld b, $01
	farcall $4, $4f16
	call Func_33b7
	call Func_c29d
	call Func_e9a7
	ld a, $01
	farcall Func_1d475
	ld hl, wd583
	set 7, [hl]
	ld a, $02
	ld [wd54c], a
	call Func_3087
	scf
	ret

.asm_c0a0
	ld a, $01
	farcall Func_1d475
	call Func_3087
	scf
	ret

.asm_c0ab
	ld a, [wd550]
	ld b, $01
	farcall $4, $4f16
	call Func_33b7
	call Func_c29d
	call Func_e9a7
	ld a, $01
	farcall Func_1d475
	call DisableLCD
	farcall $4, $4b9c
	farcall $4, $455e
	farcall $4, $4417
	farcall SaveTargetFadePals
	farcall $4, $509f
	call DoFrame
	ld a, $0e
	call Func_3154
	ld a, $3c
	call Func_d6bb
	ld [wcc16], a
	ld a, $3d
	call Func_d6bb
	ld [wdd03], a
	call Func_3087
	scf
	ret

StartMenu_ContinueDuel:
	ld a, $01
	farcall Func_1d475
	xor a
	call PlaySong
	call Func_eb16
	ld a, [wd550]
	ld b, $01
	farcall $4, $4f16
	call Func_33b7
	call EnablePlayTimeCounter
	ld a, $f0
	call Func_d6d3
	ld a, $0e
	call Func_3154
	ld a, $03
	ld [wd54c], a
	call Func_3087
	scf
	ret

StartMenu_CardPop:
	farcall $7, $782b
	scf
	ccf
	ret

Func_c12e::
	sla a
	ld hl, .PointerTable
	add l
	ld l, a
	jr nc, .no_cap
	inc h
.no_cap
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp hl

.PointerTable
	dw $31a1
	dw Func_c162
	dw $417d
	dw $4169
	dw $4183
	dw $31a8
	dw $4199
	dw Func_c162
	dw $4163
	dw $4189
	dw $3234
	dw $418f
	dw Func_c162
	dw Func_c162
	dw Func_c162
	dw $416f
	dw $4175
	dw $41a2
	dw $41a6

Func_c162:
	ret

SECTION "Bank 3@41c9", ROMX

HandleStartMenu:
	xor a
	ld [wd554], a
	call Func_e883
	jr c, .asm_c21a
	call Func_e8b7
	jr c, .asm_c20f
.asm_c1d7
	ld hl, wd554
	set 0, [hl]
	call Func_eaf6
	farcall $9, $409a
	jr c, .asm_c204
	ld hl, wd554
	set 2, [hl]
	ld a, $04
	call Func_d6bb
	cp $02
	jr c, .asm_c238
	call Func_e8a3
	jr c, .asm_c22a
	call Func_e91a
	jr c, .asm_c22a
	ld hl, wd554
	set 1, [hl]
	jr .asm_c231
.asm_c204
	ld a, $04
	call Func_d6bb
	cp $02
	jr c, .asm_c222
	jr .asm_c22a

.asm_c20f
	debug_nop
	call Func_e91a
	jr c, .asm_c21a
	call Func_e9b7
	jr .asm_c1d7

.asm_c21a
	xor a
	farcall $7, $4d6f
	ld a, STARTMENU_NEW_GAME
	ret
.asm_c222
	ld a, $01
	farcall $7, $4d6f
	inc a
	ret
.asm_c22a
	ld a, $02
	farcall $7, $4d6f
	ret
.asm_c231
	ld a, $03
	farcall $7, $4d6f
	ret
.asm_c238
	ld a, $04
	farcall $7, $4d6f
	inc a
	ret

; called before intro starts
Func_c240:
	xor a
	ld [wd674], a
	farcall Func_13dfa
	ret

Func_c249:
	call Func_d671
	ret

Func_c24d:
	call Func_d671
	; reset play time
	xor a
	ld [wPlayTimeCounter + 0], a
	ld [wPlayTimeCounter + 1], a
	ld [wPlayTimeCounter + 2], a
	ld [wPlayTimeCounter + 3], a
	ld [wPlayTimeCounter + 4], a
	call Func_c2c2
	xor a
	ld [wd54c], a
	ld [wd54d], a
	ld [wd54e], a
	ld [wd54f], a
	ld [wd551], a
	ld [wd552], a
	ld [wd553], a
	ld [wd589], a
	ld [wd586], a
	ld [wd587], a
	ld [wd674], a
	ld [wd611], a
	ld [wd612], a
	ld [wd613], a
	ld [wd614], a
	call Func_ebc6
	jr nc, .asm_c299
	call Func_eb39
.asm_c299
	call Func_c2a7
	ret

Func_c29d:
	call Func_c2a7
	ret

EnablePlayTimeCounter:
	ld a, TRUE
	ld [wPlayTimeCounterEnable], a
	ret

Func_c2a7:
	ld a, TRUE
	ld [wPlayTimeCounterEnable], a
	call Func_c2d6
	call Func_c366
	call Func_c3d4
	call Func_c2ff
	call Func_c319
	call Func_c439
	call Func_c477
	ret

; clears s0a4e0
Func_c2c2:
	ld hl, s0a4e0
	ld bc, $12c0
	call EnableSRAM
.loop_clear
	xor a
	ld [hli], a
	dec bc
	ld a, c
	or b
	jr nz, .loop_clear
	call DisableSRAM
	ret

Func_c2d6:
	ld a, $0d
	call Func_d698
	jr nz, .asm_c2fe
	ld a, [wd587]
	cp $06
	jr z, .asm_c2fe
	cp $07
	jr z, .asm_c2fe
	call UpdateRNGSources
	rrca
	jr c, .asm_c2f7
	ld a, $0f
	ld c, $06
	call Func_d6fe
	jr .asm_c2fe
.asm_c2f7
	ld a, $0f
	ld c, $07
	call Func_d6fe
.asm_c2fe
	ret

Func_c2ff:
	ld a, $02
	call Func_d6bb
	cp $06
	jr c, .asm_c318
	ld a, $f5
	call Func_d6e3
	call UpdateRNGSources
	rra
	jr nc, .asm_c318
	ld a, $f5
	call Func_d6d3
.asm_c318
	ret

Func_c319:
	ld a, $0d
	call Func_d6bb
	cp $04
	jr c, .asm_c32d
	jr z, .asm_c357
	ld a, $0d
	ld c, $01
	call Func_d6fe
	jr .asm_c357
.asm_c32d
	ld a, [wd586]
	cp $23
	jr z, .asm_c357
	cp $24
	jr z, .asm_c357
	cp $25
	jr z, .asm_c357
	ld a, $0d
	call Func_d6bb
	cp $02
	jr z, .asm_c357
	jr nc, .asm_c358
	ld a, $20
	call Func_d6bb
	cp $0a
	jr c, .asm_c357
	ld a, $0d
	ld c, $02
	call Func_d6fe
.asm_c357
	ret
.asm_c358
	ld a, $0d
	ld c, $01
	call Func_d6fe
	ld a, $20
	call Func_d6f3
	jr .asm_c357

Func_c366:
	ld a, $21
	call Func_d6bb
	cp $02
	jr c, .asm_c3d3
	ld a, [wd589]
	cp $00
	jr nz, .asm_c382
	ld a, $25
	call Func_d6bb
	ld c, a
	ld a, [wd587]
	cp c
	jr z, .asm_c3d3
.asm_c382
	ld a, $05
	call Random
	or a
	jr z, .asm_c395
	dec a
	jr z, .asm_c39e
	dec a
	jr z, .asm_c3a7
	dec a
	jr z, .asm_c3b0
	jr .asm_c3b9
.asm_c395
	ld a, $25
	ld c, $04
	call Func_d6fe
	jr .asm_c3c0
.asm_c39e
	ld a, $25
	ld c, $03
	call Func_d6fe
	jr .asm_c3c0
.asm_c3a7
	ld a, $25
	ld c, $07
	call Func_d6fe
	jr .asm_c3c0
.asm_c3b0
	ld a, $25
	ld c, $09
	call Func_d6fe
	jr .asm_c3c0
.asm_c3b9
	ld a, $25
	ld c, $08
	call Func_d6fe
.asm_c3c0
	ld a, [wd589]
	cp $00
	jr nz, .asm_c3d3
	ld a, $25
	call Func_d6bb
	ld c, a
	ld a, [wd587]
	cp c
	jr z, .asm_c382
.asm_c3d3
	ret

Func_c3d4:
	ld a, [wd589]
	cp $01
	jr nz, .asm_c3e7
	ld a, $26
	call Func_d6bb
	ld c, a
	ld a, [wd587]
	cp c
	jr z, .asm_c438
.asm_c3e7
	ld a, $05
	call Random
	or a
	jr z, .asm_c3fa
	dec a
	jr z, .asm_c403
	dec a
	jr z, .asm_c40c
	dec a
	jr z, .asm_c415
	jr .asm_c41e
.asm_c3fa
	ld a, $26
	ld c, $05
	call Func_d6fe
	jr .asm_c425
.asm_c403
	ld a, $26
	ld c, $07
	call Func_d6fe
	jr .asm_c425
.asm_c40c
	ld a, $26
	ld c, $08
	call Func_d6fe
	jr .asm_c425
.asm_c415
	ld a, $26
	ld c, $0a
	call Func_d6fe
	jr .asm_c425
.asm_c41e
	ld a, $26
	ld c, $02
	call Func_d6fe
.asm_c425
	ld a, [wd589]
	cp $01
	jr nz, .asm_c438
	ld a, $26
	call Func_d6bb
	ld c, a
	ld a, [wd587]
	cp c
	jr z, .asm_c3e7
.asm_c438
	ret

Func_c439:
	ld a, $28
	call Func_d6bb
	cp $05
	jr c, .asm_c476
	ld a, [wd589]
	cp $00
	jr nz, .asm_c450
	ld a, [wd587]
	cp $0b
	jr z, .asm_c476
.asm_c450
	ld a, $28
	ld c, $05
	call Func_d6fe
	ld a, $04
	call Random
	or a
	jr nz, .asm_c476
	ld a, $28
	ld c, $06
	call Func_d6fe
	ld a, $2b
	call Func_d6f3
	ld a, $11
	call Random
	ld c, a
	ld a, $29
	call Func_d6fe
.asm_c476
	ret

Func_c477:
	ld a, $30
	call Func_d6bb
	cp $05
	jr c, .asm_c4b4
	ld a, [wd589]
	cp $01
	jr nz, .asm_c48e
	ld a, [wd587]
	cp $04
	jr z, .asm_c4b4
.asm_c48e
	ld a, $30
	ld c, $05
	call Func_d6fe
	ld a, $05
	call Random
	or a
	jr nz, .asm_c4b4
	ld a, $30
	ld c, $06
	call Func_d6fe
	ld a, $33
	call Func_d6f3
	ld a, $11
	call Random
	ld c, a
	ld a, $31
	call Func_d6fe
.asm_c4b4
	ret

SECTION "Bank 3@4651", ROMX

; bank and offset table of data for Func_d421
Data_c651:
	dbw $10, $4462
	dbw $0c, $4080
	dbw $10, $4db3
	dbw $0f, $4603
	dbw $0f, $47dc
	dbw $0b, $4000
	dbw $0f, $4b88
	dbw $0f, $4c62
	dbw $0b, $4479
	dbw $0b, $4936
	dbw $0b, $4afa
	dbw $0b, $4d23
	dbw $0b, $530a
	dbw $0b, $53c4
	dbw $0b, $55f8
	dbw $0b, $5930
	dbw $0b, $5a26
	dbw $0b, $5c9f
	dbw $0b, $606d
	dbw $0f, $4ee6
	dbw $0b, $6163
	dbw $0b, $64b7
	dbw $0b, $663f
	dbw $0b, $68e6
	dbw $0b, $6cc8
	dbw $0b, $6dc5
	dbw $0b, $7012
	dbw $0b, $74ff
	dbw $0b, $75fc
	dbw $0b, $77ca
	dbw $0d, $4575
	dbw $0d, $4773
	dbw $0f, $519e
	dbw $0f, $52d7
	dbw $10, $5592
	dbw $0b, $7cd5
	dbw $0f, $55d1
	dbw $0f, $5d58
	dbw $0b, $7e45
	dbw $0d, $4aaf
	dbw $10, $5be9
	dbw $0f, $6698
	dbw $0f, $68e0
	dbw $0f, $6cea
	dbw $0f, $6efa
	dbw $0d, $4ba8
	dbw $0d, $4e4d
	dbw $0f, $704c
	dbw $0f, $71f2
	dbw $0d, $509f
	dbw $0f, $73c2
	dbw $0c, $518a
	dbw $0c, $5324
	dbw $10, $5e8e
	dbw $0c, $53ce
	dbw $0d, $5288
	dbw $10, $65cf
	dbw $0c, $54fe
	dbw $0c, $55d8
	dbw $0c, $5785
	dbw $0c, $5973
	dbw $0c, $5b29
	dbw $0d, $54a2
	dbw $0c, $5cbf
	dbw $0c, $5dd2
	dbw $0c, $5fad
	dbw $0c, $6148
	dbw $0c, $641e
	dbw $0c, $6531
	dbw $0c, $6696
	dbw $0c, $6804
	dbw $0c, $696d
	dbw $0c, $6beb
	dbw $0c, $6e20
	dbw $0c, $6f5b
	dbw $0f, $75ab
	dbw $0c, $70c0
	dbw $0d, $55de
	dbw $0d, $580f
	dbw $0c, $724d
	dbw $0c, $7357
	dbw $0d, $5989
	dbw $10, $6e2b
	dbw $0c, $7506
	dbw $0c, $75da
	dbw $0c, $762f
	dbw $0c, $7723
	dbw $0c, $7766
	dbw $0c, $77bb
	dbw $0c, $7822
	dbw $0c, $7928
	dbw $0c, $797d
	dbw $0c, $79b2
	dbw $0c, $7a19
	dbw $0c, $7ab4
	dbw $0c, $7b1b
	dbw $0c, $7ba4
	dbw $0d, $5c10
	dbw $0c, $7bf9
	dbw $0d, $5c9a
	dbw $0f, $77b5
	dbw $0c, $7d2e
	dbw $10, $6e80
	dbw $0c, $7d63
	dbw $0f, $7884
	dbw $0d, $5d36
	dbw $0d, $5f14
	dbw $0d, $6097
	dbw $0d, $6173
	dbw $0d, $631f
	dbw $0d, $6c9b
	dbw $0c, $7d98
	dbw $0d, $6f9a
	dbw $0d, $7365
	dbw $0d, $75df
	dbw $10, $6ed5

SECTION "Bank 3@5299", ROMX

Func_d299::
	push af
	ldh a, [hKeysHeld]
	bit A_BUTTON_F, a
	jr z, .skip_nop
	bit B_BUTTON_F, a
	jr z, .skip_nop
	nop
	nop
	nop
	nop
.skip_nop
	pop af
	ld hl, wd583
	bit 6, [hl]
	jr nz, .asm_d2c1
	bit 7, [hl]
	jp nz, Func_d398
	ld a, $02
	call Func_d698
	jp nz, Func_d377
	ld a, PLAYER_TURN
	ldh [hWhoseTurn], a
.asm_d2c1
	ld hl, wd58b
	ld a, [hl]
	ld [wd551], a
	ld hl, wd58c
	ld a, [hli]
	ld [wd552], a
	ld a, [hl]
	ld [wd553], a
	ld a, $01
	call Func_3154
	farcall $4, $42ef
	xor a
	farcall $4, $4d40
	ld a, $01
	farcall $4, $4413
	ld b, $00
	ld a, [wd58a]
	ld c, a
	farcall $4b, $4206
	ld a, [wd58f]
	ld d, a
	ld a, [wd590]
	ld e, a
	ld a, [wd591]
	ld b, a
	ld a, [wd550]
	farcall $4, $4d77
	farcall $4, $4dd7
	farcall $4, $5450
	farcall $4, $4eff
	ld b, $01
	farcall $4, $4f16
	ld a, $00
	ld [wd582], a
	xor a
	ld [wd583], a
	ld a, $07
	call Func_3154
	ld a, $10
	call Func_3154
	ld a, $02
	call Func_3154
	ld a, $03
	call Func_3154
;	fallthrough

Func_d333:
	ld a, [wVBlankCounter]
	and $3f
	call z, UpdateRNGSources
	ld a, [wd582]
	call Func_3154
	ld a, [wd583]
	bit 1, a
	jr nz, .asm_d357
	bit 0, a
	jr z, Func_d333
	ld a, $04
	call Func_3154
	ld a, $0f
	call Func_3154
	ret
.asm_d357
	ld a, [wcc16]
	ld c, a
	ld a, $3c
	call Func_d6fe
	ld a, [wdd03]
	ld c, a
	ld a, $3d
	call Func_d6fe
	ld a, $02
	call Func_d6d3
	ld a, $03
	ld [wd54c], a
	call Func_eaa8
	ret

Func_d377:
	ld a, $11
	call Func_3154
	ld a, $02
	call Func_d6e3
	call Func_e9a7
	ld a, $f0
	call Func_d6e3
	farcall $11, $4943
	ld a, $09
	ld [wd582], a
	xor a
	ld [wd583], a
	jr Func_d333

Func_d398:
	farcall $4, $4b9c
	farcall $4, $455e
	farcall $4, $4417
	farcall SaveTargetFadePals
	farcall $4, $509f
	call DoFrame
	ld a, $00
	ld b, $00
	farcall StartPalFadeFromBlackOrWhite
	ld a, $0b
	ld [wd582], a
	ld hl, wd583
	res 7, [hl]
	jp Func_d333

SECTION "Bank 3@53e9", ROMX

Func_d3e9::
	ld a, [wd550]
	push af
	farcall $4, $4da7
	pop af
	push de
	farcall $4, $4dcb
	pop de
	ld a, b
	rlca
	ld hl, .data
	add l
	ld l, a
	jr nc, .no_cap
	inc h
.no_cap
	ld a, [hli]
	add d
	ld d, a
	ld a, [hl]
	add e
	ld e, a
	ret

.data
	db  0, -1
	db  1,  0
	db  0,  1
	db -1,  0

Func_d411:
	call PauseSong
	ld a, MUSIC_PCMAINMENU
	call PlaySong
	farcall $4, $50c6
	call ResumeSong
	ret

Func_d421::
	push af
	ld c, a
	ld b, $00
	sla c
	add c ; *3
	ld c, a
	rl b
	ld hl, Data_c651
	add hl, bc
	ld a, [hli]
	ld c, a     ; bank
	ld a, [hli] ; offset
	ld h, [hl]  ;
	ld l, a
	ld a, c
	ld de, wd58a
	ld bc, $5
	call CopyFarHLToDE
	ld a, [wd586]
	ld [wd584], a
	pop af
	ld [wd586], a
	ld a, $ff
	ld [wd585], a
	ret

SECTION "Bank 3@5671", ROMX

; reset data at wd59e
Func_d671:
	push bc
	push hl
	ld hl, wd59e
	ld bc, $68
.loop
	xor a
	ld [hli], a
	dec bc
	ld a, b
	or c
	jr nz, .loop
	pop hl
	pop bc
	ret

Func_d683:
	ld a, $ed
	call Func_d6e3
	ld a, $ee
	call Func_d6e3
	ld a, $3b
	ld c, $00
	call Func_d6fe
	ret

Func_d695:
	call Func_d74b
Func_d698::
	push bc
	push hl
	call Func_d71d
	ld c, [hl]
.asm_d69e
	bit 0, a
	jr nz, .asm_d6a8
	srl a
	srl c
	jr .asm_d69e
.asm_d6a8
	ld b, a
	ld a, c
	and b
	jr z, .asm_d6b4
	cp b
	jr nz, .asm_d6b4
	pop hl
	pop bc
	or a
	ret
.asm_d6b4
	pop hl
	pop bc
	xor a
	ret

Func_d6b8:
	call Func_d74b
Func_d6bb:
	push bc
	push hl
	call Func_d734
	ld c, [hl]
.asm_d6c1
	bit 0, a
	jr nz, .asm_d6cb
	srl a
	srl c
	jr .asm_d6c1
.asm_d6cb
	and c
	pop hl
	pop bc
	or a
	ret

Func_d6d0:
	call Func_d74b
Func_d6d3::
	push bc
	push hl
	call Func_d71d
	ld c, $ff
	call Func_d709
	pop hl
	pop bc
	ret

Func_d6e0:
	call Func_d74b
Func_d6e3::
	push bc
	push hl
	call Func_d71d
	ld c, $00
	call Func_d709
	pop hl
	pop bc
	ret

Func_d6f0:
	call Func_d74b
Func_d6f3:
	push bc
	ld c, $00
	call Func_d6fe
	pop bc
	ret

Func_d6fb:
	call Func_d74b
Func_d6fe:
	push bc
	push hl
	call Func_d734
	call Func_d709
	pop hl
	pop bc
	ret

Func_d709:
	ld b, a
.asm_d70a
	bit 0, a
	jr nz, .asm_d714
	srl a
	sla c
	jr .asm_d70a
.asm_d714
	ld a, b
	and c
	ld c, a
	ld a, b
	cpl
	and [hl]
	or c
	ld [hl], a
	ret

Func_d71d:
	push bc
	ld c, a
	xor a
	ld b, a
	sla c
	rl b
	ld hl, Data_d75a
	add hl, bc
	ld a, [hli]
	ld c, a
	xor a
	ld b, a
	ld a, [hl]
	ld hl, wd59e
	add hl, bc
	pop bc
	ret

Func_d734:
	push bc
	ld c, a
	xor a
	ld b, a
	sla c
	rl b
	ld hl, Data_d946
	add hl, bc
	ld a, [hli]
	ld c, a
	xor a
	ld b, a
	ld a, [hl]
	ld hl, wd5d2
	add hl, bc
	pop bc
	ret

Func_d74b:
	push hl
	ld hl, sp+$04
	push bc
	ld c, [hl]
	inc hl
	ld b, [hl]
	ld a, [bc]
	inc bc
	ld [hl], b
	dec hl
	ld [hl], c
	pop bc
	pop hl
	ret

Data_d75a:
	db $00, $1 << 0
	db $00, $1 << 1
	db $00, $1 << 2
	db $00, $1 << 3
	db $01, $1 << 0
	db $01, $1 << 1
	db $01, $1 << 2
	db $01, $1 << 3
	db $01, $1 << 4
	db $01, $1 << 5
	db $01, $1 << 6
	db $02, ($1 << 0) | ($1 << 1) | ($1 << 2) | ($1 << 3)
	db $02, $1 << 0
	db $02, $1 << 1
	db $02, $1 << 2
	db $02, $1 << 3
	db $02, $1 << 4
	db $02, $1 << 5
	db $02, $1 << 6
	db $02, $1 << 7
	db $03, $1 << 0
	db $03, $1 << 1
	db $03, $1 << 2
	db $03, $1 << 3
	db $03, $1 << 4
	db $03, $1 << 5
	db $03, $1 << 6
	db $03, $1 << 7
	db $04, $1 << 0
	db $04, $1 << 1
	db $04, $1 << 2
	db $04, $1 << 3
	db $05, $1 << 0
	db $05, $1 << 1
	db $05, $1 << 2
	db $05, $1 << 3
	db $06, $1 << 0
	db $06, $1 << 1
	db $06, $1 << 2
	db $06, $1 << 3
	db $07, $1 << 0
	db $07, $1 << 1
	db $07, $1 << 2
	db $07, $1 << 3
	db $07, $1 << 4
	db $08, $1 << 0
	db $08, $1 << 1
	db $08, $1 << 2
	db $08, $1 << 3
	db $09, $1 << 0
	db $09, $1 << 1
	db $09, $1 << 2
	db $09, $1 << 3
	db $09, $1 << 4
	db $09, $1 << 5
	db $0a, $1 << 0
	db $0a, $1 << 1
	db $0a, $1 << 2
	db $0a, $1 << 3
	db $0a, $1 << 4
	db $0b, $1 << 0
	db $0b, $1 << 1
	db $0b, $1 << 2
	db $0b, $1 << 3
	db $0c, $1 << 0
	db $0c, $1 << 1
	db $0c, $1 << 2
	db $0c, $1 << 3
	db $0c, $1 << 5
	db $0c, $1 << 6
	db $0d, $1 << 0
	db $0d, $1 << 1
	db $0d, $1 << 2
	db $0d, $1 << 3
	db $0d, $1 << 4
	db $0d, $1 << 5
	db $0d, $1 << 6
	db $0d, $1 << 7
	db $0e, $1 << 0
	db $0e, $1 << 1
	db $0e, $1 << 2
	db $0e, $1 << 3
	db $0e, $1 << 4
	db $0e, $1 << 5
	db $0e, $1 << 6
	db $0f, $1 << 0
	db $0f, $1 << 1
	db $0f, $1 << 2
	db $0f, $1 << 3
	db $0f, $1 << 4
	db $0f, $1 << 5
	db $0f, $1 << 6
	db $0f, $1 << 7
	db $10, $1 << 0
	db $10, $1 << 1
	db $10, $1 << 2
	db $10, $1 << 3
	db $10, $1 << 4
	db $10, $1 << 5
	db $10, $1 << 6
	db $10, $1 << 7
	db $11, $1 << 0
	db $11, $1 << 1
	db $11, $1 << 2
	db $11, $1 << 3
	db $11, $1 << 4
	db $11, $1 << 5
	db $12, $1 << 0
	db $12, $1 << 1
	db $12, $1 << 2
	db $12, $1 << 3
	db $12, $1 << 4
	db $12, $1 << 5
	db $12, $1 << 6
	db $12, $1 << 7
	db $13, $1 << 0
	db $13, $1 << 1
	db $14, $1 << 0
	db $14, $1 << 1
	db $14, $1 << 2
	db $14, $1 << 3
	db $14, $1 << 4
	db $14, $1 << 5
	db $14, ($1 << 3) | ($1 << 4) | ($1 << 5)
	db $14, $1 << 6
	db $14, $1 << 7
	db $15, $1 << 0
	db $16, $1 << 0
	db $16, $1 << 1
	db $16, $1 << 2
	db $16, $1 << 3
	db $16, $1 << 4
	db $17, $1 << 0
	db $18, $1 << 0
	db $18, $1 << 1
	db $18, $1 << 2
	db $18, $1 << 3
	db $18, $1 << 4
	db $18, $1 << 5
	db $18, $1 << 6
	db $18, $1 << 7
	db $19, $1 << 0
	db $19, $1 << 1
	db $19, $1 << 2
	db $19, $1 << 3
	db $19, $1 << 4
	db $19, $1 << 5
	db $19, $1 << 6
	db $19, $1 << 7
	db $1a, $1 << 0
	db $1a, $1 << 1
	db $1a, $1 << 2
	db $1b, $1 << 0
	db $1b, $1 << 1
	db $1b, $1 << 2
	db $1b, $1 << 3
	db $1b, $1 << 4
	db $1b, $1 << 5
	db $1b, $1 << 6
	db $1b, $1 << 7
	db $1c, $1 << 0
	db $1c, $1 << 1
	db $1c, $1 << 2
	db $1d, $1 << 0
	db $1d, $1 << 1
	db $1d, $1 << 2
	db $1d, $1 << 3
	db $1d, $1 << 4
	db $1d, $1 << 5
	db $1d, $1 << 6
	db $1d, $1 << 7
	db $1e, $1 << 0
	db $1e, $1 << 1
	db $1e, $1 << 2
	db $1e, $1 << 3
	db $1e, $1 << 4
	db $1e, $1 << 5
	db $1e, $1 << 6
	db $1e, $1 << 7
	db $1f, $1 << 0
	db $1f, $1 << 1
	db $1f, $1 << 2
	db $1f, $1 << 3
	db $1f, $1 << 4
	db $1f, $1 << 5
	db $20, $1 << 0
	db $20, $1 << 1
	db $21, $1 << 0
	db $21, $1 << 1
	db $21, $1 << 2
	db $21, $1 << 3
	db $21, $1 << 4
	db $21, $1 << 5
	db $21, $1 << 6
	db $21, $1 << 7
	db $22, $1 << 0
	db $22, $1 << 1
	db $22, $1 << 2
	db $22, $1 << 3
	db $23, $1 << 0
	db $23, $1 << 1
	db $23, $1 << 2
	db $23, ($1 << 3) | ($1 << 4)
	db $23, $1 << 3
	db $23, $1 << 4
	db $23, $1 << 5
	db $24, ($1 << 0) | ($1 << 1)
	db $24, $1 << 0
	db $24, $1 << 1
	db $24, $1 << 2
	db $25, $1 << 0
	db $25, $1 << 1
	db $25, $1 << 2
	db $25, $1 << 3
	db $25, $1 << 4
	db $25, $1 << 5
	db $25, $1 << 6
	db $26, $1 << 0
	db $26, $1 << 1
	db $26, $1 << 2
	db $27, $1 << 0
	db $27, $1 << 1
	db $28, $1 << 0
	db $28, $1 << 1
	db $28, $1 << 2
	db $28, $1 << 3
	db $28, $1 << 4
	db $28, $1 << 5
	db $28, $1 << 6
	db $28, $1 << 7
	db $29, $1 << 0
	db $29, $1 << 1
	db $29, $1 << 2
	db $29, $1 << 3
	db $29, $1 << 4
	db $2a, $1 << 0
	db $2a, $1 << 1
	db $2b, $1 << 0
	db $2b, $1 << 1
	db $2b, $1 << 2
	db $33, $1 << 0
	db $33, $1 << 1
	db $33, $1 << 2
	db $33, $1 << 3
	db $33, $1 << 4
	db $33, $1 << 5

Data_d946:
	db $00, $ff
	db $01, $03
	db $01, $3c
	db $01, $c0
	db $02, $0f
	db $03, $03
	db $03, $0c
	db $03, $30
	db $04, $0f
	db $04, $30
	db $04, $c0
	db $05, $03
	db $06, $03
	db $06, $1c
	db $06, $e0
	db $07, $0f
	db $08, $ff
	db $09, $ff
	db $0a, $ff
	db $0b, $ff
	db $0c, $ff
	db $0d, $ff
	db $0e, $ff
	db $0f, $ff
	db $10, $ff
	db $11, $ff
	db $12, $ff
	db $13, $ff
	db $14, $ff
	db $15, $ff
	db $16, $ff
	db $17, $03
	db $17, $3c
	db $18, $07
	db $18, $f0
	db $19, $01
	db $19, $f0
	db $1a, $0f
	db $1a, $f0
	db $1b, $0f
	db $1b, $70
	db $1c, $1f
	db $1d, $0f
	db $1d, $30
	db $1d, $c0
	db $1e, $ff
	db $1f, $ff
	db $20, $ff
	db $21, $07
	db $21, $f8
	db $22, $0f
	db $22, $30
	db $23, $07
	db $24, $ff
	db $25, $ff
	db $26, $ff
	db $27, $ff
	db $28, $ff
	db $29, $07
	db $2a, $ff
	db $2b, $ff
	db $2c, $ff
	db $33, $ff

SECTION "Bank 3@5bdb", ROMX

Func_dbdb::
	xor a
	ld [wd61a], a
	ld hl, wd61b
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld de, wd61e
	ld bc, $20
	ld a, [wd619]
	call CopyFarHLToDE
	ret

Func_dbf2::
	ld hl, wd61a
	ld a, [hl]
	ld hl, wd61e
	add l
	ld l, a
	jr nc, .asm_dbfe
	inc h
.asm_dbfe
	ld a, [hl]
	ld d, a
	ld hl, .PointerTable
	add l
	ld l, a
	jr nc, .asm_dc08
	inc h
.asm_dc08
	ld a, d
	add l
	ld l, a
	jr nc, .asm_dc0e
	inc h
.asm_dc0e
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp hl

.PointerTable
	dw $5d91
	dw $5d9c
	dw $5da6
	dw $5dad
	dw $5db9
	dw $5dd1
	dw $5de3
	dw $5e01
	dw $5e1f
	dw $5e30
	dw $5e3b
	dw $5e46
	dw $5e51
	dw $5e5c
	dw $5e76
	dw $5e7f
	dw $5e88
	dw $5e9d
	dw $5ea8
	dw $5eb4
	dw $5ec4
	dw $5ed4
	dw $5eeb
	dw $5ef5
	dw $5f03
	dw $5f11
	dw $5f1e
	dw $5f2f
	dw $5f45
	dw $5f54
	dw $5f63
	dw $5f6d
	dw $5f87
	dw $5f9b
	dw $5fb5
	dw $5fd0
	dw $5fdc
	dw $5fe8
	dw $5ff3
	dw $6004
	dw $601e
	dw $604f
	dw $6070
	dw $608e
	dw $60b2
	dw $60c7
	dw $60da
	dw $60ed
	dw $60f3
	dw $60f9
	dw $6115
	dw $6131
	dw $613c
	dw $6147
	dw $616d
	dw $617b
	dw $61a0
	dw $61ae
	dw $61be
	dw $61ce
	dw $61de
	dw $6209
	dw $6217
	dw $6242
	dw $624c
	dw $6256
	dw $636b
	dw $637b
	dw $638b
	dw $6394
	dw $63a1
	dw $63ac
	dw $63c3
	dw $63cc
	dw $63da
	dw $63e8
	dw $63f8
	dw $6424
	dw $6450
	dw $6466
	dw $647e
	dw $64dd
	dw $64fc
	dw $6509
	dw $6512
	dw $6527
	dw $6531
	dw $65d7
	dw $65e3
	dw $65eb
	dw $65f6
	dw $6601
	dw $660d
	dw $6613
	dw $664e
	dw $6672
	dw $667f
	dw $6689
	dw $6697
	dw $66b1
	dw $66ce
	dw $670e
	dw $6724
	dw $673a
	dw $6746
	dw $6752
	dw $6764
	dw $6775
	dw $6786
	dw $679c
	dw $67ab
	dw $67d0
	dw $67df
	dw $67e6
	dw $67ed
	dw $67f7
	dw $6801
	dw $680f
	dw $6816
	dw $681d
	dw $6847
	dw $684e
	dw $685b
	dw $686a
	dw $6871
	dw $687d

SECTION "Bank 3@6883", ROMX

Func_e883:
	ldh a, [hBankSRAM]
	push af
	ld a, BANK("SRAM2")
	call BankswitchSRAM
	call EnableSRAM
	ld a, [$baa3]
	ld b, a
	pop af
	call BankswitchSRAM
	call DisableSRAM
	ld a, b
	bit 0, a
	jr z, .asm_e8a1
	scf
	ccf
	ret
.asm_e8a1
	scf
	ret

Func_e8a3:
	call EnableSRAM
	ld a, [$baa3]
	ld b, a
	call DisableSRAM
	ld a, b
	bit 1, a
	jr z, .asm_e8b5
	scf
	ccf
	ret
.asm_e8b5
	scf
	ret

Func_e8b7:
	ld a, $02
	ld [wd668], a
	ldh a, [hBankSRAM]
	push af
	ld a, BANK("SRAM2")
	call BankswitchSRAM
	ld a, [$b800]
	ld b, a
	pop af
	call BankswitchSRAM
	call DisableSRAM
	ld a, b
	cp $16
	jr nz, .asm_e918
	ld a, $ec
	ld [wd66f], a
	ld a, $6d
	ld [wd670], a
	ld a, $01
	ld [wd671], a
	ld a, $b8
	ld [wd672], a
	call Func_ea19
	call Func_ed7c
	ld a, [wd66d]
	ld d, a
	ld a, [wd66c]
	ld e, a
	ldh a, [hBankSRAM]
	push af
	ld a, BANK("SRAM2")
	call BankswitchSRAM
	ld a, [$baa0]
	ld b, a
	ld a, [$baa1]
	ld c, a
	pop af
	call BankswitchSRAM
	call DisableSRAM
	ld a, b
	cp d
	jr nz, .asm_e918
	ld a, c
	cp e
	jr nz, .asm_e918
	scf
	ccf
	ret
.asm_e918
	scf
	ret

Func_e91a:
	xor a
	ld [wd668], a
	ldh a, [hBankSRAM]
	push af
	xor a
	call BankswitchSRAM
	ld a, [$b800]
	ld b, a
	pop af
	call BankswitchSRAM
	call DisableSRAM
	ld a, b
	cp $16
	jr nz, .asm_e978
	ld a, $ec
	ld [wd66f], a
	ld a, $6d
	ld [wd670], a
	ld a, $01
	ld [wd671], a
	ld a, $b8
	ld [wd672], a
	call Func_ea19
	call Func_ed7c
	ld a, [wd66d]
	ld d, a
	ld a, [wd66c]
	ld e, a
	ldh a, [hBankSRAM]
	push af
	xor a
	call BankswitchSRAM
	ld a, [$baa0]
	ld b, a
	ld a, [$baa1]
	ld c, a
	pop af
	call BankswitchSRAM
	call DisableSRAM
	ld a, b
	cp d
	jr nz, .asm_e978
	ld a, c
	cp e
	jr nz, .asm_e978
	scf
	ccf
	ret
.asm_e978
	scf
	ret

Func_e97a:
	ldh a, [hBankSRAM]
	push af
	ld a, BANK("SRAM2")
	call BankswitchSRAM
	ld hl, $baa3
	xor a
	ld [hl], a
	ld [$b800], a
	pop af
	call BankswitchSRAM
	call DisableSRAM
	call EnableSRAM
	ld hl, $baa3
	xor a
	ld [hl], a
	ld [$b800], a
	call DisableSRAM
	farcall $9, $40d8
	call DisableSRAM
	ret

Func_e9a7:
	call EnableSRAM
	ld hl, $baa3
	xor a
	ld [hl], a
	call DisableSRAM
	farcall $9, $40d8
	ret

Func_e9b7:
	ld a, $02
	call Func_e9d6
	ldh a, [hBankSRAM]
	push af
	ld a, BANK("SRAM2")
	call BankswitchSRAM
	ld a, $16
	ld [$b800], a
	ld hl, $baa3
	set 0, [hl]
	pop af
	call BankswitchSRAM
	call DisableSRAM
	ret

Func_e9d6:
	cp $01
	jr z, .asm_e9e2
	jr nc, .asm_e9e8
	ld e, $02
	ld d, $00
	jr .asm_e9f7
.asm_e9e2
	ld e, $00
	ld d, $02
	jr .asm_e9f7
.asm_e9e8
	ld e, $00
	ld d, $02
	ldh a, [hBankSRAM]
	push af
	ld bc, $2000
	ld hl, s0a000
	jr .asm_ea00
.asm_e9f7
	ldh a, [hBankSRAM]
	push af
	ld bc, $1f00
	ld hl, sCardAndDeckSaveData
.asm_ea00
	ld a, e
	call BankswitchSRAM
	ld a, [hl]
	push af
	ld a, d
	call BankswitchSRAM
	pop af
	ld [hli], a
	dec bc
	ld a, b
	or c
	jr nz, .asm_ea00
	pop af
	call BankswitchSRAM
	call DisableSRAM
	ret

Func_ea19:
	ldh a, [hBankSRAM]
	push af
	ld a, [wd668]
	call BankswitchSRAM
	ld a, [$baa2]
	ld [wd673], a
	pop af
	call BankswitchSRAM
	call DisableSRAM
	ret

Func_ea30::
	ld a, $0c
	call Func_3154
	farcall $4, $4f32
	xor a
	ld [wd668], a
.asm_ea3d
	ld a, $ec
	ld [wd66f], a
	ld a, $6d
	ld [wd670], a
	ld a, $01
	ld [wd671], a
	ld a, $b8
	ld [wd672], a
	call Func_ec94
	call EnableSRAM
	ld a, $16
	ld [$b800], a
	ld a, [wd66d]
	ld [$baa0], a
	ld a, [wd66c]
	ld [$baa1], a
	ld a, [wd673]
	ld [$baa2], a
	ld hl, $baa3
	set 0, [hl]
	call DisableSRAM
	call Func_ea19
	call Func_ed7c
	ld a, [wd66d]
	ld d, a
	ld a, [wd66c]
	ld e, a
	call EnableSRAM
	ld a, [$baa0]
	ld b, a
	ld a, [$baa1]
	ld c, a
	call DisableSRAM
	ld a, b
	cp d
	jr nz, .asm_eaa5
	ld a, c
	cp e
	jr nz, .asm_eaa5
	ld a, $01
	call Func_e9d6
	ld a, $0d
	call Func_3154
	ret
.asm_eaa5
	debug_nop
	jr .asm_ea3d

Func_eaa8:
	farcall $4, $4f32
	xor a
	ld [wd668], a
	ld a, $ec
	ld [wd66f], a
	ld a, $6d
	ld [wd670], a
	ld a, $01
	ld [wd671], a
	ld a, $b8
	ld [wd672], a
	call Func_ec94
	call EnableSRAM
	ld a, $16
	ld [$b800], a
	ld a, [wd66d]
	ld [$baa0], a
	ld a, [wd66c]
	ld [$baa1], a
	ld a, [wd673]
	ld [$baa2], a
	ld hl, $baa3
	set 1, [hl]
	call DisableSRAM
	ret

Func_eaea:
	call Func_eaf6
	xor a
	call Func_e9d6
	farcall $4, $4f78
	ret

Func_eaf6:
	ld a, $02
	ld [wd668], a
	ld a, $ec
	ld [wd66f], a
	ld a, $6d
	ld [wd670], a
	ld a, $01
	ld [wd671], a
	ld a, $b8
	ld [wd672], a
	call Func_ea19
	call Func_ed0b
	ret

Func_eb16:
	xor a
	ld [wd668], a
	ld a, $ec
	ld [wd66f], a
	ld a, $6d
	ld [wd670], a
	ld a, $01
	ld [wd671], a
	ld a, $b8
	ld [wd672], a
	call Func_ea19
	call Func_ed0b
	farcall $4, $4f78
	ret

Func_eb39:
	ld hl, wddf9
	xor a
	ld c, $14
.asm_eb3f
	ld [hli], a
	dec c
	jr nz, .asm_eb3f

	ld hl, wde0d
	xor a
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld hl, wde11
	xor a
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld hl, wde15
	xor a
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld [hli], a

	ld a, $01
	ld [wde15 + 0], a
	ld a, $05
	ld [wde15 + 2], a
	ld hl, .data
	ld de, wde19
	ld c, $20
.asm_eb6d
	ld a, [hli]
	ld [de], a
	inc de
	dec c
	jr nz, .asm_eb6d
	call Func_ec38
	ret

.data
	db $04, $13, $79, $15, $0f, $6b, $0f, $34, $0f, $2f, $0f, $00, $00, $00, $00, $00, $4e, $0f, $39, $0f, $38, $0f, $5f, $0f, $21, $0f, $00, $00, $00, $00, $00, $00

SECTION "Bank 3@6b97", ROMX

Func_eb97:
	call Func_ebc6
	jr nc, .asm_eb9f
	call Func_eb39
.asm_eb9f
	call Func_ec6c
	ld hl, wde0d
	xor a
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld hl, wde11
	xor a
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld [hli], a
	call Func_ec38
	ret

Func_ebb6:
	call EnableSRAM
	xor a
	ld [$bae5], a
	ld a, $ff
	ld [$bae4], a
	call DisableSRAM
	ret

Func_ebc6:
	xor a
	ld [wd668], a
	ld a, $20
	ld [wd66f], a
	ld a, $6f
	ld [wd670], a
	ld a, $a4
	ld [wd671], a
	ld a, $ba
	ld [wd672], a
	call EnableSRAM
	ld a, [$bae6]
	ld [wd673], a
	call DisableSRAM
	call Func_ed0b
	ld a, [wd66d]
	ld d, a
	ld a, [wd66c]
	ld e, a
	call EnableSRAM
	ld a, [$bae4]
	ld b, a
	ld a, [$bae5]
	ld c, a
	call DisableSRAM
	ld a, b
	cp d
	jr nz, .asm_ec36
	ld a, c
	cp e
	jr nz, .asm_ec36
	ld a, [wde15 + 0]
	ld e, a
	ld a, [wde15 + 1]
	ld d, a
	ld a, d
	cp $00
	jr c, .asm_ec1d
	jr nz, .asm_ec1d
	ld a, e
	cp $00
.asm_ec1d
	jr z, .asm_ec36
	ld a, [wde15 + 2]
	ld e, a
	ld a, [wde15 + 3]
	ld d, a
	ld a, d
	cp $00
	jr c, .asm_ec31
	jr nz, .asm_ec31
	ld a, e
	cp $00
.asm_ec31
	jr z, .asm_ec36
	scf
	ccf
	ret
.asm_ec36
	scf
	ret

Func_ec38:
	xor a
	ld [wd668], a
	ld a, $20
	ld [wd66f], a
	ld a, $6f
	ld [wd670], a
	ld a, $a4
	ld [wd671], a
	ld a, $ba
	ld [wd672], a
	call Func_ec94
	call EnableSRAM
	ld a, [wd66d]
	ld [$bae4], a
	ld a, [wd66c]
	ld [$bae5], a
	ld a, [wd673]
	ld [$bae6], a
	call DisableSRAM
	ret

Func_ec6c:
	xor a
	ld [wd668], a
	ld a, $20
	ld [wd66f], a
	ld a, $6f
	ld [wd670], a
	ld a, $a4
	ld [wd671], a
	ld a, $ba
	ld [wd672], a
	call EnableSRAM
	ld a, [$bae6]
	ld [wd673], a
	call DisableSRAM
	call Func_ed0b
	ret

Func_ec94:
	ldh a, [hBankSRAM]
	push af
	ld a, [wd668]
	call BankswitchSRAM
	xor a
	ld [wd66c], a
	ld [wd66d], a
	call UpdateRNGSources
	or $01
	ld [wd673], a
	ld [wd66e], a
	ld a, [wd66f]
	ld l, a
	ld a, [wd670]
	ld h, a
	ld a, [wd671]
	ld e, a
	ld a, [wd672]
	ld d, a
.asm_ecbf
	ld a, [hli]
	ld c, a
	ld a, [hli]
	ld b, a
	or c
	jr z, .asm_ed03
	push hl
	push bc
	ld a, [hli]
	ld c, a
	ld a, [hli]
	ld b, a
	ld a, [hli]
	ld [wd66a], a
	ld a, [hli]
	ld [wd66b], a
	pop hl
.asm_ecd5
	push bc
	ld a, [hli]
	ld c, a
	ld a, [wd66d]
	xor c
	ld [wd66d], a
	ld a, [wd66c]
	add c
	ld [wd66c], a
	ld a, [wd66e]
	ld b, a
	sla a
	add b
	ld b, a
	ld a, c
	add b
	ld [de], a
	inc de
	ld a, b
	ld [wd66e], a
	pop bc
	dec bc
	ld a, b
	or c
	jr nz, .asm_ecd5
	pop hl
	inc hl
	inc hl
	inc hl
	inc hl
	jr .asm_ecbf
.asm_ed03
	pop af
	call BankswitchSRAM
	call DisableSRAM
	ret

Func_ed0b:
	ldh a, [hBankSRAM]
	push af
	ld a, [wd668]
	call BankswitchSRAM
	xor a
	ld [wd66c], a
	ld [wd66d], a
	ld a, [wd673]
	ld [wd66e], a
	ld a, [wd66f]
	ld l, a
	ld a, [wd670]
	ld h, a
	ld a, [wd671]
	ld e, a
	ld a, [wd672]
	ld d, a
.asm_ed31
	ld a, [hli]
	ld c, a
	ld a, [hli]
	ld b, a
	or c
	jr z, .asm_ed74
	push hl
	push bc
	ld a, [hli]
	ld c, a
	ld a, [hli]
	ld b, a
	ld a, [hli]
	ld [wd66a], a
	ld a, [hli]
	ld [wd66b], a
	pop hl
.asm_ed47
	push bc
	ld a, [wd66e]
	ld b, a
	sla a
	add b
	ld b, a
	ld a, [de]
	sub b
	ld [hli], a
	inc de
	ld c, a
	ld a, b
	ld [wd66e], a
	ld a, [wd66d]
	xor c
	ld [wd66d], a
	ld a, [wd66c]
	add c
	ld [wd66c], a
	pop bc
	dec bc
	ld a, b
	or c
	jr nz, .asm_ed47
	pop hl
	inc hl
	inc hl
	inc hl
	inc hl
	jr .asm_ed31
.asm_ed74
	pop af
	call BankswitchSRAM
	call DisableSRAM
	ret

Func_ed7c:
	ldh a, [hBankSRAM]
	push af
	ld a, [wd668]
	call BankswitchSRAM
	xor a
	ld [wd66c], a
	ld [wd66d], a
	ld a, [wd673]
	ld [wd66e], a
	ld a, [wd66f]
	ld l, a
	ld a, [wd670]
	ld h, a
	ld a, [wd671]
	ld e, a
	ld a, [wd672]
	ld d, a
.asm_eda2
	ld a, [hli]
	ld c, a
	ld a, [hli]
	ld b, a
	or c
	jr z, .asm_ede4
	push hl
	push bc
	ld a, [hli]
	ld c, a
	ld a, [hli]
	ld b, a
	ld a, [hli]
	ld [wd66a], a
	ld a, [hli]
	ld [wd66b], a
	pop hl
.asm_edb8
	push bc
	ld a, [wd66e]
	ld b, a
	sla a
	add b
	ld b, a
	ld a, [de]
	sub b
	inc de
	ld c, a
	ld a, b
	ld [wd66e], a
	ld a, [wd66d]
	xor c
	ld [wd66d], a
	ld a, [wd66c]
	add c
	ld [wd66c], a
	pop bc
	dec bc
	ld a, b
	or c
	jr nz, .asm_edb8
	pop hl
	inc hl
	inc hl
	inc hl
	inc hl
	jr .asm_eda2
.asm_ede4
	pop af
	call BankswitchSRAM
	call DisableSRAM
	ret
