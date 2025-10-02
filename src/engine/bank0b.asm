SECTION "Bank b@4000", ROMX[$4000], BANK[$b]

Data_2c000:
	db MAP_ISHIHARAS_HOUSE
	dba Data_2c09b
	db MUSIC_ISHIHARA

Data_2c005:
	db $04, $0c, $00, $00, $02, $02, $03, $C4, $53
	db $05, $0c, $00, $00, $02, $02, $03, $C4, $53
	db $ff

Data_2c018:
	db $04, $04, $04, $02, $B8, $41
	db $11, $05, $04, $02, $6A, $44
	db $ff

Data_2c025:
	db $04, $0b, $72, $41
	db $11, $0b, $cb, $43
	db $ff

Data_2c02e:
	db $03, $02, $00, $00, $00, $00, $10, $00, $40
	db $04, $02, $00, $00, $00, $00, $10, $16, $40
	db $05, $02, $00, $00, $00, $00, $10, $2c, $40
	db $06, $02, $00, $00, $00, $00, $10, $42, $40
	db $07, $02, $00, $00, $00, $00, $10, $58, $40
	db $08, $02, $00, $00, $00, $00, $10, $6e, $40
	db $01, $09, $00, $00, $00, $00, $10, $84, $40
	db $02, $09, $00, $00, $00, $00, $10, $9a, $40
	db $03, $09, $00, $00, $00, $00, $10, $b0, $40
	db $06, $09, $00, $00, $00, $00, $10, $c6, $40
	db $07, $09, $00, $00, $00, $00, $10, $dc, $40
	db $08, $09, $00, $00, $00, $00, $10, $f2, $40
	db $ff

Data_2c09b:
	dbw $06, Func_2c0c1
	dbw $08, Func_2c0f1
	dbw $07, Func_2c0c8
	dbw $02, Func_2c0d1
	dbw $0c, Func_2c101
	dbw $0d, Func_2c12f
	dbw $0b, Func_2c13e
	dbw $01, Func_2c0b4
	db $ff

Func_2c0b4:
	call Func_2c1b8
	jr nc, .asm_2c0be
	ld a, MUSIC_OVERWORLD
	ld [wNextMusic], a
.asm_2c0be
	scf
	ccf
	ret

Func_2c0c1:
	ld hl, Data_2c005
	call Func_324d
	ret

Func_2c0c8:
	ld hl, Data_2c018
	call Func_3205
	scf
	ccf
	ret

Func_2c0d1:
	xor a
	call Func_33f2
	; Event Script @ 0x2c0d5
	db $64, $11, $00
	ld a, EVENT_F5
	farcall GetEventValue
	jr z, .asm_2c0ef
	ld a, OW_ISHIHARA
	lb de, 1, 2
	farcall Func_10db8
	ld b, NORTH
	farcall SetOWObjectDirection
.asm_2c0ef
	scf
	ret

Func_2c0f1:
	ld hl, Data_2c025
	call Func_328c
	jr nc, .asm_2c0ff
	ld hl, Data_2c02e
	call Func_32bf
.asm_2c0ff
	scf
	ret

Func_2c101:
	xor a
	push af
	ld a, EVENT_F5
	farcall GetEventValue
	jr z, .asm_2c10f
	pop af
	or $01
	push af
.asm_2c10f
	ld a, EVENT_ISHIHARA_CARD_TRADE_STATE
	farcall GetEventValue
	jr z, .asm_2c11b
	pop af
	or $02
	push af
.asm_2c11b
	pop af
	or a
	jr z, .asm_2c12c
	ld c, a
	ld a, VAR_00
	farcall SetVarValue
	ld a, EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE_DUMMY
	farcall MaxOutEventValue
.asm_2c12c
	scf
	ccf
	ret

Func_2c12f:
	ld a, EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE_DUMMY
	farcall ZeroOutEventValue
	ld a, VAR_00
	farcall ZeroOutVarValue
	scf
	ccf
	ret

Func_2c13e:
	ld a, EVENT_F5
	farcall ZeroOutEventValue
	ld a, VAR_00
	farcall GetVarValue
	bit 0, a
	push af
	call nz, Func_2c164
	pop af
	bit 1, a
	call nz, Func_2c16b
	ld a, EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE_DUMMY
	farcall ZeroOutEventValue
	ld a, VAR_00
	farcall ZeroOutVarValue
	scf
	ret

Func_2c164:
	ld a, EVENT_F5
	farcall MaxOutEventValue
	ret

Func_2c16b:
	ld a, EVENT_ISHIHARA_CARD_TRADE_STATE
	farcall MaxOutEventValue
	ret
; 0x2c172

SECTION "Bank b@41b8", ROMX[$41b8], BANK[$b]

Func_2c1b8:
	ld a, VAR_02
	farcall GetVarValue
	cp 5
	jr c, .asm_2c1d8
	jr nz, .asm_2c1ce
	ld a, EVENT_ISHIHARA_CARD_TRADE_STATE
	farcall GetEventValue
	jr nz, .asm_2c1d8
	jr .asm_2c1d6
.asm_2c1ce
	ld a, EVENT_F5
	farcall GetEventValue
	jr nz, .asm_2c1d8
.asm_2c1d6
	scf
	ret
.asm_2c1d8
	scf
	ccf
	ret
; 0x2c1db

SECTION "Bank b@4479", ROMX[$4479], BANK[$b]

Data_2c479:
	db MAP_LIGHTNING_CLUB_1
	dba Data_2c4c5
	db MUSIC_CLUB_1

Data_2c47e:
	db $06, $0f, $06, $04, $01, $02, $03, $c4, $53
	db $07, $0f, $06, $05, $01, $02, $03, $c4, $53
	db $ff

Data_2c491:
	db $22, $06, $02, $02, $00, $00
	db $23, $07, $09, $02, $f9, $48
	db $24, $03, $05, $02, $00, $00
	db $25, $0b, $06, $02, $f9, $48
	db $31, $07, $04, $02, $29, $49
	db $ff

Data_2c4b0:
	db $22, $0b, $45, $46
	db $23, $0b, $3b, $47
	db $24, $0b, $9d, $47
	db $25, $0b, $97, $48
	db $31, $0b, $0e, $49
	db $ff

Data_2c4c5:
	dbw $06, Func_2c4fa
	dbw $08, Func_2c560
	dbw $09, Func_2c568
	dbw $07, Func_2c501
	dbw $01, Func_2c4db
	dbw $02, Func_2c50a
	dbw $01, Func_2c4db
	db $ff

Func_2c4db:
	ld a, EVENT_GOT_PIKACHU_COIN
	farcall GetEventValue
	jr nz, .asm_2c4ea
	ld a, MUSIC_HERECOMESGR
	ld [wNextMusic], a
	jr .asm_2c4f7
.asm_2c4ea
	ld a, EVENT_SET_UNTIL_MAP_RELOAD_1
	farcall GetEventValue
	jr nz, .asm_2c4f7
	ld a, MAP_LIGHTNING_CLUB_2
	ld [wCurMap], a
.asm_2c4f7
	scf
	ccf
	ret

Func_2c4fa:
	ld hl, Data_2c47e
	call Func_324d
	ret

Func_2c501:
	ld hl, Data_2c491
	call Func_3205
	scf
	ccf
	ret

Func_2c50a:
	ld a, EVENT_MET_GR4_LIGHTNING_CLUB
	farcall GetEventValue
	jr z, .asm_2c524
	ld a, EVENT_SET_UNTIL_MAP_RELOAD_1
	farcall GetEventValue
	jr nz, .asm_2c54f
	ld a, EVENT_GOT_PIKACHU_COIN
	farcall GetEventValue
	jr z, .asm_2c54f
	jr .asm_2c55e
.asm_2c524
	ld a, $0a
	ld [wd582], a
	ld a, $0b
	ld [wd592], a
	ld hl, $4584
	ld a, l
	ld [wd593], a
	ld a, h
	ld [$d594], a
	xor a
	call Func_33f2
	; Event Script @ 0x2c53d
	db $22, $22, $05, $09, $02, $22, $24, $08, $09, $02
	db $22, $31, $07, $09, $02, $00
	jr .asm_2c55e
.asm_2c54f
	xor a
	call Func_33f2
	; Event Script @ 0x2c553
	db $22, $22, $05, $06, $02, $22, $24, $08, $08, $02
	db $00
.asm_2c55e
	scf
	ret

Func_2c560:
	ld hl, Data_2c4b0
	call Func_328c
	scf
	ret

Func_2c568:
	ld hl, Data_2c573
	ld a, [$d60e]
	call Func_344c
	scf
	ret

Data_2c573:
	db $22, $0b, $ec, $46
	db $23, $0b, $81, $47
	db $24, $0b, $47, $48
	db $25, $0b, $dd, $48
	db $ff
; 0x2c584

SECTION "Bank b@4936", ROMX[$4936], BANK[$b]

Data_2c936:
	db MAP_PSYCHIC_CLUB_ENTRANCE
	dba Data_2c990
	db MUSIC_OVERWORLD

Data_2c93b:
	db $04, $08, $00, $06, $03, $02, $03, $c4, $53
	db $05, $08, $00, $06, $03, $02, $03, $c4, $53
	db $00, $03, $0a, $0e, $06, $03, $03, $c4, $53
	db $00, $04, $0a, $0e, $07, $03, $03, $c4, $53
	db $04, $00, $0b, $06, $0c, $00, $03, $c4, $53
	db $05, $00, $0b, $07, $0c, $00, $03, $c4, $53
	db $04, $02, $00, $00, $00, $00, $0b, $3e, $4a
	db $05, $02, $00, $00, $00, $00, $0b, $3e, $4a
	db $ff

Data_2c984:
	db $29, $05, $01, $02, $bb, $4a,
	db $ff

Data_2c98b:
	db $29, $0b, $a0, $4a
	db $ff

Data_2c990:
	dbw $00, Func_2c9ac
	dbw $06, Func_2c9d8
	dbw $08, Func_2ca14
	dbw $09, Func_2ca1c
	dbw $07, Func_2c9df
	dbw $02, Func_2c9e8
	dbw $0b, Func_2ca22
	dbw $01, Func_2c9b8
	dbw $10, Func_2c9c8
	db $ff

Func_2c9ac:
	call Func_3332
	call Func_2ca46
	call Func_32d8
	scf
	ccf
	ret

Func_2c9b8:
	ld a, EVENT_GOT_GR_COIN_PIECE_BOTTOM_RIGHT
	farcall GetEventValue
	jr nz, .asm_2c9c5
	ld a, MUSIC_HERECOMESGR
	ld [wNextMusic], a
.asm_2c9c5
	scf
	ccf
	ret

Func_2c9c8:
	call PsychicClubEntranceShouldRonaldAppear
	jr nc, .asm_2c9cf
	scf
	ret
.asm_2c9cf
	ld a, MUSIC_RONALD
	farcall PlayAfterCurrentSong
	scf
	ccf
	ret

Func_2c9d8:
	ld hl, Data_2c93b
	call Func_324d
	ret

Func_2c9df:
	ld hl, Data_2c984
	call Func_3205
	scf
	ccf
	ret

Func_2c9e8:
	call PsychicClubEntranceShouldRonaldAppear
	jr c, .asm_2ca12
	cp 1
	jr z, .asm_2c9f8
	jr nc, .asm_2c9fd
	ld hl, $4037
	jr .asm_2ca00
.asm_2c9f8
	ld hl, $417e
	jr .asm_2ca00
.asm_2c9fd
	ld hl, $41f7
.asm_2ca00
	ld a, $0a
	ld [wd582], a
	ld a, $0d
	ld [wd592], a
	ld a, l
	ld [wd593], a
	ld a, h
	ld [$d594], a
.asm_2ca12
	scf
	ret

Func_2ca14:
	ld hl, Data_2c98b
	call Func_328c
	scf
	ret

Func_2ca1c:
	farcall Func_341c4
	scf
	ret

Func_2ca22:
	ld a, EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE_DUMMY
	farcall GetEventValue
	jr z, .asm_2ca3c
	ld a, OW_RONALD
	farcall ClearOWObject
	ld a, EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE_DUMMY
	farcall ZeroOutEventValue
	ld a, [wNextMusic]
	ld [wCurMusic], a
.asm_2ca3c
	scf
	ret

Func_2ca3e:
	call Func_2ca46
	farcall Func_c199
	ret

Func_2ca46:
	ld a, EVENT_GOT_PIKACHU_COIN
	farcall GetEventValue
	jr nz, .asm_2ca9f
	ldh a, [hKeysHeld]
	bit 6, a
	jr z, .asm_2ca9f
	ld a, [wPlayerOWObject]
	ld b, NORTH
	farcall SetOWObjectDirection
	farcall Func_10da7
	ld a, $02
	cp e
	jr nz, .asm_2ca9f
	ld a, $04
	cp d
	jr z, .asm_2ca86
	ld a, $05
	cp d
	jr nz, .asm_2ca9f
	ld a, $29
	farcall Func_10da7
	ld a, $05
	cp d
	jr z, .asm_2ca9f
	ld a, $29
	ld bc, $8101
	farcall Func_10e3c
	jr .asm_2ca9a
.asm_2ca86
	ld a, $29
	farcall Func_10da7
	ld a, $04
	cp d
	jr z, .asm_2ca9f
	ld a, $29
	ld bc, $8301
	farcall Func_10e3c
.asm_2ca9a
	ld a, $29
	call Func_336d
.asm_2ca9f
	ret

Func_2caa0:
	ld a, $29
	ld [$d60e], a
	ld hl, $9f3
	ld a, l
	ld [$d60f], a
	ld a, h
	ld [$d610], a
	xor a
	call Func_33f2
	; Event Script @ 0x2cab4
	db $01, $05, $cb, $0b, $02, $00
	ret

Func_2cabb:
	ld a, EVENT_GOT_PIKACHU_COIN
	farcall GetEventValue
	jr z, .asm_2cac5
	scf
	ret
.asm_2cac5
	scf
	ccf
	ret

; sets and complements carry flag if Ronald should appear.
; return a = which meeting script to use
PsychicClubEntranceShouldRonaldAppear:
	ld a, VAR_TIMES_MET_RONALD
	farcall GetVarValue
	cp 2
	jr c, .second_meeting
	cp 3
	jr c, .third_meeting
	cp 4
	jr c, .fourth_meeting
.asm_2cada
	scf
	ret
.second_meeting ; second meeting - Ronald card pops with you
	xor a
	scf
	ccf
	ret
.third_meeting ; after 2 GC pieces. Ronald gives you Super Energy Retrieval card
	farcall CountGRCoinPiecesObtained
	cp 2
	jr nz, .asm_2cada
	ld a, 1
	scf
	ccf
	ret
.fourth_meeting ; after 4 GC pieces. Ronald tells you he got the stolen cards back
	farcall CountGRCoinPiecesObtained
	cp 4
	jr nz, .asm_2cada
	ld a, 2
	scf
	ccf
	ret

Data_2cafa:
	db MAP_PSYCHIC_CLUB_LOBBY
	dba Data_2cb92
	db MUSIC_OVERWORLD

Data_2caff:
	db $0f, $06, $09, $01, $03, $01, $03, $c4, $53
	db $0f, $07, $09, $01, $04, $01, $03, $c4, $53
	db $ff

Data_2cb12:
	db $83, $08, $08, $01, $00, $00
	db $84, $0a, $09, $03, $00, $00
	db $05, $01, $0a, $03, $a8, $4c
	db $85, $07, $06, $01, $00, $00
	db $86, $0e, $04, $02, $0e, $4d
	db $64, $02, $02, $02, $00, $00
	db $65, $04, $02, $02, $00, $00
	db $ff

Data_2cb3d:
	db $83, $0b, $11, $4c
	db $84, $0b, $7d, $4c
	db $05, $0f, $0c, $43
	db $85, $0b, $b7, $4c
	db $86, $0b, $e8, $4c
	db $ff

Data_2cb52:
	db $08, $02, $00, $00, $00, $00, $03, $11, $54
	db $09, $02, $00, $00, $00, $00, $03, $11, $54
	db $02, $04, $00, $00, $00, $00, $0f, $b9, $41
	db $04, $04, $00, $00, $00, $00, $0f, $d9, $42
	db $0c, $02, $00, $00, $00, $00, $10, $d6, $42
	db $0d, $02, $00, $00, $00, $00, $10, $ec, $42
	db $0e, $02, $00, $00, $00, $00, $10, $02, $43
	db $ff
Data_2cb92:
	dbw $06, Func_2cbcf
	dbw $08, Func_2cbdf
	dbw $07, Func_2cbd6
	dbw $09, Func_2cbef
	dbw $0b, Func_2cbf5
	dbw $01, Func_2cba8
	dbw $10, Func_2cbba
	db $ff

Func_2cba8:
	ld a, EVENT_GOT_GR_COIN_PIECE_BOTTOM_RIGHT
	farcall GetEventValue
	jr nz, .asm_2cbb7
	ld a, MUSIC_HERECOMESGR
	ld [wNextMusic], a
	jr .asm_2cbb7
.asm_2cbb7
	scf
	ccf
	ret

Func_2cbba:
	ld a, VAR_25
	farcall GetVarValue
	cp 3
	jr z, .asm_2cbc6
	scf
	ret
.asm_2cbc6
	ld a, MUSIC_IMAKUNI
	farcall PlayAfterCurrentSong
	scf
	ccf
	ret

Func_2cbcf:
	ld hl, Data_2caff
	call Func_324d
	ret

Func_2cbd6:
	ld hl, Data_2cb12
	call Func_3205
	scf
	ccf
	ret

Func_2cbdf:
	ld hl, Data_2cb3d
	call Func_328c
	jr nc, .asm_2cbed
	ld hl, Data_2cb52
	call Func_32bf
.asm_2cbed
	scf
	ret

Func_2cbef:
	farcall Func_3c3ca
	scf
	ret

Func_2cbf5:
	ld a, EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE_DUMMY
	farcall GetEventValue
	jr z, .asm_2cc0f
	ld a, OW_IMAKUNI_BLACK
	farcall ClearOWObject
	ld a, EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE_DUMMY
	farcall ZeroOutEventValue
	ld a, [wNextMusic]
	ld [wCurMusic], a
.asm_2cc0f
	scf
	ret

SECTION "Bank b@4d23", ROMX[$4d23], BANK[$b]

Data_2cd23:
	db MAP_PSYCHIC_CLUB
	dba Data_2cd6f
	db MUSIC_CLUB_2

Data_2cd28:
	db $06, $0d, $09, $04, $01, $02, $03, $c4, $53
	db $07, $0d, $09, $05, $01, $02, $03, $c4, $53
	db $ff

Data_2cd3b:
	db $26, $06, $03, $02, $00, $00
	db $27, $03, $0a, $03, $00, $00
	db $28, $04, $05, $00, $00, $00
	db $29, $0b, $06, $01, $00, $00
	db $31, $07, $03, $02, $3c, $52
	db $ff

Data_2cd5a:
	db $26, $0b, $88, $4e
	db $27, $0b, $cc, $4f
	db $28, $0b, $46, $50
	db $29, $0b, $b3, $50
	db $31, $0b, $90, $51
	db $ff

Data_2cd6f:
	dbw $06, Func_2cd92
	dbw $08, Func_2ce11
	dbw $09, Func_2ce19
	dbw $07, Func_2cd99
	dbw $02, Func_2cda2
	dbw $01, Func_2cd82
	db $ff

Func_2cd82:
	ld a, EVENT_GOT_GR_COIN_PIECE_BOTTOM_RIGHT
	farcall GetEventValue
	jr nz, .asm_2cd8f
	ld a, MUSIC_HERECOMESGR
	ld [wNextMusic], a
.asm_2cd8f
	scf
	ccf
	ret

Func_2cd92:
	ld hl, Data_2cd28
	call Func_324d
	ret

Func_2cd99:
	ld hl, Data_2cd3b
	call Func_3205
	scf
	ccf
	ret

Func_2cda2:
	ld a, EVENT_MET_GR4_PSYCHIC_CLUB
	farcall GetEventValue
	jr z, .asm_2cdc6
	ld a, EVENT_SET_UNTIL_MAP_RELOAD_1
	farcall GetEventValue
	jr nz, .asm_2cdf6
	ld a, EVENT_GOT_GR_COIN_PIECE_BOTTOM_RIGHT
	farcall GetEventValue
	jr z, .asm_2cdf6
	ld bc, TILEMAP_013
	lb de, 5, 6
	farcall Func_12c0ce
	jr .asm_2ce0f
.asm_2cdc6
	ld a, $0a
	ld [wd582], a
	ld a, $0b
	ld [wd592], a
	ld hl, $4e39
	ld a, l
	ld [wd593], a
	ld a, h
	ld [$d594], a
	xor a
	call Func_33f2
	; Event Script @ 0x2cddf
	db $22, $26, $07, $06, $02, $22, $27, $05, $06, $02
	db $22, $28, $06, $06, $02, $22, $29, $08, $0a, $02
	db $00
	jr .asm_2ce0f
.asm_2cdf6
	xor a
	call Func_33f2
	; Event Script @ 0x2cdfa
	db $22, $26, $06, $03, $02, $22, $27, $05, $06, $02
	db $22, $28, $06, $0a, $02, $22, $29, $08, $0a, $02
	db $00
.asm_2ce0f
	scf
	ret

Func_2ce11:
	ld hl, Data_2cd5a
	call Func_328c
	scf
	ret

Func_2ce19:
	ld hl, Data_2ce24
	ld a, [$d60e]
	call Func_344c
	scf
	ret

Data_2ce24:
	db $26, $0b, $73, $4f
	db $27, $0b, $2a, $50
	db $28, $0b, $97, $50
	db $29, $0b, $42, $51
	db $31, $0b, $0e, $52
	db $ff
; 0x2ce39

SECTION "Bank b@523c", ROMX[$523c], BANK[$b]

Func_2d23c:
	ld a, EVENT_GOT_GR_COIN_PIECE_BOTTOM_RIGHT
	farcall GetEventValue
	jr z, .asm_2d246
	scf
	ret
.asm_2d246
	scf
	ccf
	ret
; 0x2d249

SECTION "Bank b@530a", ROMX[$530a], BANK[$b]

Data_2d30a:
	db MAP_ROCK_CLUB_ENTRANCE
	dba Data_2d346
	db MUSIC_OVERWORLD

Data_2d30f:
	db $04, $08, $00, $01, $04, $02, $03, $c4, $53
	db $05, $08, $00, $01, $04, $02, $03, $c4, $53
	db $00, $03, $0d, $0e, $06, $03, $03, $c4, $53
	db $00, $04, $0d, $0e, $07, $03, $03, $c4, $53
	db $04, $00, $0e, $06, $0d, $00, $03, $c4, $53
	db $05, $00, $0e, $07, $0d, $00, $03, $c4, $53
	db $ff

Data_2d346:
	dbw $06, Func_2d376
	dbw $02, Func_2d37d
	dbw $0b, Func_2d399
	dbw $01, Func_2d356
	dbw $10, Func_2d366
	db $ff

Func_2d356:
	ld a, EVENT_MET_GR1_ROCK_CLUB
	farcall GetEventValue
	jr nz, .asm_2d363
	ld a, MUSIC_HERECOMESGR
	ld [wNextMusic], a
.asm_2d363
	scf
	ccf
	ret

Func_2d366:
	call RockClubEntranceShouldRonaldAppear
	jr nc, .asm_2d36d
	scf
	ret
.asm_2d36d
	ld a, MUSIC_RONALD
	farcall PlayAfterCurrentSong
	scf
	ccf
	ret

Func_2d376:
	ld hl, Data_2d30f
	call Func_324d
	ret

Func_2d37d:
	call RockClubEntranceShouldRonaldAppear
	jr c, .asm_2d397
	ld a, $0a
	ld [wd582], a
	ld a, $0d
	ld [wd592], a
	ld hl, $4111
	ld a, l
	ld [wd593], a
	ld a, h
	ld [$d594], a
.asm_2d397
	scf
	ret

Func_2d399:
	ld a, EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE_DUMMY
	farcall GetEventValue
	jr z, .asm_2d3b3
	ld a, OW_RONALD
	farcall ClearOWObject
	ld a, EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE_DUMMY
	farcall ZeroOutEventValue
	ld a, [wNextMusic]
	ld [wCurMusic], a
.asm_2d3b3
	scf
	ret

; sets and complements carry flag if Ronald should appear.
; return a = which meeting script to use
RockClubEntranceShouldRonaldAppear:
	ld a, VAR_TIMES_MET_RONALD
	farcall GetVarValue
	cp 2
	jr c, .second_meeting
	scf
	ret
.second_meeting ; second meeting - Ronald card pops with you
	scf
	ccf
	ret

Data_2d3c4:
	db MAP_ROCK_CLUB_LOBBY
	dba Data_2d45c
	db MUSIC_OVERWORLD

Data_2d3c9:
	db $0f, $06, $0c, $01, $03, $01, $03, $c4, $53
	db $0f, $07, $0c, $01, $04, $01, $03, $c4, $53
	db $ff

Data_2d3dc:
	db $6a, $05, $06, $01, $00, $00
	db $6b, $0c, $0a, $00, $00, $00
	db $05, $01, $0a, $03, $7c, $55
	db $6c, $08, $09, $03, $00, $00
	db $6d, $0a, $03, $02, $00, $00
	db $64, $02, $02, $02, $00, $00
	db $65, $04, $02, $02, $00, $00
	db $ff

Data_2d407:
	db $6a, $0b, $e0, $54
	db $6b, $0b, $46, $55
	db $05, $0f, $0c, $43
	db $6c, $0b, $8b, $55
	db $6d, $0b, $c7, $55
	db $ff

Data_2d41c:
	db $08, $02, $00, $00, $00, $00, $03, $11, $54
	db $09, $02, $00, $00, $00, $00, $03, $11, $54
	db $02, $04, $00, $00, $00, $00, $0f, $b9, $41
	db $04, $04, $00, $00, $00, $00, $0f, $d9, $42
	db $0c, $02, $00, $00, $00, $00, $10, $08, $41
	db $0d, $02, $00, $00, $00, $00, $10, $1e, $41
	db $0e, $02, $00, $00, $00, $00, $10, $34, $41
	db $ff

Data_2d45c:
	dbw $06, Func_2d49e
	dbw $08, Func_2d4ae
	dbw $07, Func_2d4a5
	dbw $09, Func_2d4be
	dbw $0b, Func_2d4c4
	dbw $01, Func_2d472
	dbw $10, Func_2d489
	db $ff

Func_2d472:
	ld a, EVENT_MET_GR1_ROCK_CLUB
	farcall GetEventValue
	jr nz, .asm_2d486
	ld a, MUSIC_HERECOMESGR
	ld [wNextMusic], a
	jr .asm_2d486
	ld a, MUSIC_IMAKUNI
	ld [wNextMusic], a
.asm_2d486
	scf
	ccf
	ret

Func_2d489:
	ld a, VAR_25
	farcall GetVarValue
	cp 4
	jr z, .asm_2d495
	scf
	ret
.asm_2d495
	ld a, MUSIC_IMAKUNI
	farcall PlayAfterCurrentSong
	scf
	ccf
	ret

Func_2d49e:
	ld hl,Data_2d3c9
	call Func_324d
	ret

Func_2d4a5:
	ld hl, Data_2d3dc
	call Func_3205
	scf
	ccf
	ret

Func_2d4ae:
	ld hl, Data_2d407
	call Func_328c
	jr nc, .asm_2d4bc
	ld hl, Data_2d41c
	call Func_32bf
.asm_2d4bc
	scf
	ret

Func_2d4be:
	farcall Func_3c3ca
	scf
	ret

Func_2d4c4:
	ld a, EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE_DUMMY
	farcall GetEventValue
	jr z, .asm_2d4de
	ld a, OW_IMAKUNI_BLACK
	farcall ClearOWObject
	ld a, EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE_DUMMY
	farcall ZeroOutEventValue
	ld a, [wNextMusic]
	ld [wCurMusic], a
.asm_2d4de
	scf
	ret
; 0x2d4e0

SECTION "Bank b@55f8", ROMX[$55f8], BANK[$b]

Data_2d5f8:
	db MAP_ROCK_CLUB
	dba Data_2d640
	db MUSIC_CLUB_2

Data_2d5fd:
	db $06, $0e, $0c, $04, $01, $02, $03, $c4, $53
	db $07, $0e, $0c, $05, $01, $02, $03, $c4, $53
	db $ff

Data_2d610:
	db $09, $07, $02, $02, $00, $00
	db $0a, $02, $03, $02, $00, $00
	db $0b, $09, $07, $01, $00, $00
	db $0c, $03, $08, $01, $00, $00
	db $2e, $07, $03, $00, $f3, $58
	db $ff

Data_2d62f:
	db $09, $0b, $54, $57
	db $0a, $0b, $ea, $57
	db $0b, $0b, $41, $58
	db $0c, $0b, $9c, $58
	db $ff

Data_2d640:
	dbw $06, Func_2d663
	dbw $08, Func_2d6a6
	dbw $07, Func_2d66a
	dbw $02, Func_2d673
	dbw $09, Func_2d6ae
	dbw $01, Func_2d653
	db $ff

Func_2d653:
	ld a, EVENT_MET_GR1_ROCK_CLUB
	farcall GetEventValue
	jr nz, .asm_2d660
	ld a, MUSIC_HERECOMESGR
	ld [wNextMusic], a
.asm_2d660
	scf
	ccf
	ret

Func_2d663:
	ld hl, Data_2d5fd
	call Func_324d
	ret

Func_2d66a:
	ld hl, Data_2d610
	call Func_3205
	scf
	ccf
	ret

Func_2d673:
	ld a, EVENT_MET_GR1_ROCK_CLUB
	farcall GetEventValue
	jr nz, .asm_2d6a4
	ld a, $0a
	ld [wd582], a
	ld a, $0b
	ld [wd592], a
	ld hl, $56ca
	ld a, l
	ld [wd593], a
	ld a, h
	ld [$d594], a
	xor a
	call Func_33f2
	; Event Script @ 0x2d694
	db $22, $0a, $05, $01, $02, $22, $0b, $08, $01, $02
	db $22, $0c, $06, $01, $02, $00
.asm_2d6a4
	scf
	ret

Func_2d6a6:
	ld hl, Data_2d62f
	call Func_328c
	scf
	ret

Func_2d6ae:
	ld hl, Data_2d6b9
	ld a, [$d60e]
	call Func_344c
	scf
	ret

Data_2d6b9:
	db $09, $0b, $c3, $57
	db $0a, $0b, $25, $58
	db $0b, $0b, $7e, $58
	db $0c, $0b, $d7, $58
	db $ff
; 0x2d6ca

SECTION "Bank b@5930", ROMX[$5930], BANK[$b]

Data_2d930:
	db MAP_FIGHTING_CLUB_ENTRANCE
	dba Data_2d96c
	db MUSIC_OVERWORLD

Data_2d935:
	db $04, $08, $00, $03, $07, $02, $03, $c4, $53
	db $05, $08, $00, $03, $07, $02, $03, $c4, $53
	db $00, $03, $10, $0e, $06, $03, $03, $c4, $53
	db $00, $04, $10, $0e, $07, $03, $03, $c4, $53
	db $04, $00, $11, $05, $0a, $00, $03, $c4, $53
	db $05, $00, $11, $06, $0a, $00, $03, $c4, $53
	db $ff

Data_2d96c:
	dbw $06, Func_2d99f
	dbw $09, Func_2d9d2
	dbw $02, Func_2d9a6
	dbw $0b, Func_2d9d8
	dbw $01, Func_2d97f
	dbw $10, Func_2d98f
	db $ff

Func_2d97f:
	ld a, EVENT_GOT_GR_COIN_PIECE_TOP_LEFT
	farcall GetEventValue
	jr nz, .asm_2d98c
	ld a, MUSIC_HERECOMESGR
	ld [wNextMusic], a
.asm_2d98c
	scf
	ccf
	ret

Func_2d98f:
	call FightingClubEntranceShouldRonaldAppear
	jr nc, .asm_2d996
	scf
	ret
.asm_2d996
	ld a, MUSIC_RONALD
	farcall PlayAfterCurrentSong
	scf
	ccf
	ret

Func_2d99f:
	ld hl, Data_2d935
	call Func_324d
	ret

Func_2d9a6:
	call FightingClubEntranceShouldRonaldAppear
	jr c, .asm_2d9d0
	cp 1
	jr z, .asm_2d9b6
	jr nc, .asm_2d9bb
	ld hl, $4037
	jr .asm_2d9be
.asm_2d9b6
	ld hl, $417e
	jr .asm_2d9be
.asm_2d9bb
	ld hl, $41f7
.asm_2d9be
	ld a, $0a
	ld [wd582], a
	ld a, $0d
	ld [wd592], a
	ld a, l
	ld [wd593], a
	ld a, h
	ld [$d594], a
.asm_2d9d0
	scf
	ret

Func_2d9d2:
	farcall Func_341c4
	scf
	ret

SECTION "Bank b@59d8", ROMX[$59d8], BANK[$b]

Func_2d9d8:
	ld a, EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE_DUMMY
	farcall GetEventValue
	jr z, .asm_2d9f2
	ld a, OW_RONALD
	farcall ClearOWObject
	ld a, EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE_DUMMY
	farcall ZeroOutEventValue
	ld a, [wNextMusic]
	ld [wCurMusic], a
.asm_2d9f2
	scf
	ret

; sets and complements carry flag if Ronald should appear.
; return a = which meeting script to use
FightingClubEntranceShouldRonaldAppear:
	ld a, VAR_TIMES_MET_RONALD
	farcall GetVarValue
	cp 2
	jr c, .second_meeting
	cp 3
	jr c, .third_meeting
	cp 4
	jr c, .fourth_meeting
.asm_2da06
	scf
	ret
.second_meeting ; second meeting - Ronald card pops with you
	xor a
	scf
	ccf
	ret
.third_meeting ; after 2 GC pieces. Ronald gives you Super Energy Retrieval card
	farcall CountGRCoinPiecesObtained
	cp 2
	jr nz, .asm_2da06
	ld a, 1
	scf
	ccf
	ret
.fourth_meeting ; after 4 GC pieces. Ronald tells you he got the stolen cards back
	farcall CountGRCoinPiecesObtained
	cp 4
	jr nz, .asm_2da06
	ld a, 2
	scf
	ccf
	ret

Data_2da26:
	db MAP_FIGHTING_CLUB_LOBBY
	dba Data_d2abe
	db MUSIC_OVERWORLD

Data_2da2b:
	db $0F, $06, $0F, $01, $03, $01, $03, $C4, $53
	db $0F, $07, $0F, $01, $04, $01, $03, $C4, $53
	db $ff

Data_2da3e:
	db $6e, $01, $05, $02, $00, $00
	db $6f, $04, $09, $01, $00, $00
	db $70, $07, $09, $03, $00, $00
	db $71, $06, $08, $02, $00, $00
	db $64, $02, $02, $02, $00, $00
	db $65, $04, $02, $02, $00, $00
	db $0e, $0b, $06, $01, $97, $5b
	db $ff

Data_2da69:
	db $6e, $0b, $ac, $5b
	db $6f, $0b, $17, $5c
	db $70, $0b, $48, $5c
	db $71, $0b, $79, $5c
	db $0e, $0b, $0e, $5b
	db $ff

Data_2da7e:
	db $08, $02, $00, $00, $00, $00, $03, $11, $54
	db $09, $02, $00, $00, $00, $00, $03, $11, $54
	db $02, $04, $00, $00, $00, $00, $0F, $B9, $41
	db $04, $04, $00, $00, $00, $00, $0F, $D9, $42
	db $0C, $02, $00, $00, $00, $00, $10, $4A, $41
	db $0D, $02, $00, $00, $00, $00, $10, $60, $41
	db $0E, $02, $00, $00, $00, $00, $10, $76, $41
	db $ff

Data_d2abe:
	dbw $06, Func_2dade
	dbw $08, Func_2daee
	dbw $07, Func_2dae5
	dbw $09, Func_2dafe
	dbw $01, Func_2dace
	db $ff

Func_2dace:
	ld a, EVENT_GOT_GR_COIN_PIECE_TOP_LEFT
	farcall GetEventValue
	jr nz, .asm_2dadb
	ld a, MUSIC_HERECOMESGR
	ld [wNextMusic], a
.asm_2dadb
	scf
	ccf
	ret

Func_2dade:
	ld hl, Data_2da2b
	call Func_324d
	ret

Func_2dae5:
	ld hl, Data_2da3e
	call Func_3205
	scf
	ccf
	ret

Func_2daee:
	ld hl, Data_2da69
	call Func_328c
	jr nc, .asm_2dafc
	ld hl, Data_2da7e
	call Func_32bf
.asm_2dafc
	scf
	ret

Func_2dafe:
	ld hl, Data_2db09
	ld a, [$d60e]
	call Func_344c
	scf
	ret

Data_2db09:
	db $0e, $0B, $7B, $5B
	db $ff
; 0x2db5b

SECTION "Bank b@5c9f", ROMX[$5c9f], BANK[$b]

Data_2dc9f:
	db MAP_FIGHTING_CLUB
	dba Data_2dceb
	db MUSIC_CLUB_3

Data_2dca4:
	db $05, $0b, $0f, $04, $01, $02, $03, $c4, $53
	db $06, $0b, $0f, $05, $01, $02, $03, $c4, $53
	db $ff

Data_2dcb7:
	db $0d, $05, $02, $02, $e4, $5d
	db $0e, $07, $07, $02, $9c, $5f
	db $0f, $02, $05, $02, $9c, $5f
	db $10, $09, $04, $02, $9c, $5f
	db $2e, $06, $02, $02, $23, $60
	db $ff

Data_2dcd6:
	db $0d, $0b, $62, $5d
	db $0e, $0b, $f1, $5d
	db $0f, $0b, $ad, $5e
	db $10, $0b, $3a, $5f
	db $2e, $0b, $b1, $5f
	db $ff

Data_2dceb:
	dbw $06, Func_2dd0e
	dbw $08, Func_2dd3a
	dbw $07, Func_2dd31
	dbw $09, Func_2dd42
	dbw $02, Func_2dd15
	dbw $01, Func_2dcfe
	db $ff

Func_2dcfe:
	ld a, EVENT_GOT_GR_COIN_PIECE_TOP_LEFT
	farcall GetEventValue
	jr nz, .asm_2dd0b
	ld a, MUSIC_HERECOMESGR
	ld [wNextMusic], a
.asm_2dd0b
	scf
	ccf
	ret

Func_2dd0e:
	ld hl, Data_2dca4
	call Func_324d
	ret

Func_2dd15:
	ld a, EVENT_SET_UNTIL_MAP_RELOAD_1
	farcall GetEventValue
	jr nz, .asm_2dd2f
	ld a, EVENT_GOT_GR_COIN_PIECE_TOP_LEFT
	farcall GetEventValue
	jr z, .asm_2dd2f
	ld bc, TILEMAP_01A
	lb de, 5, 0
	farcall Func_12c0ce
.asm_2dd2f
	scf
	ret

Func_2dd31:
	ld hl, Data_2dcb7
	call Func_3205
	scf
	ccf
	ret

Func_2dd3a:
	ld hl, Data_2dcd6
	call Func_328c
	scf
	ret

Func_2dd42:
	ld hl, Data_2dd4d
	ld a, [$d60e]
	call Func_344c
	scf
	ret

Data_2dd4d:
	db $0d, $0b, $c8, $5d
	db $0e, $0b, $75, $5e
	db $0f, $0b, $1e, $5f
	db $10, $0b, $80, $5f
	db $2e, $0b, $08, $60
	db $ff
; 0x2dd62

SECTION "Bank b@606d", ROMX[$606d], BANK[$b]

Data_2e06d:
	db MAP_GRASS_CLUB_ENTRANCE
	dba Data_2e0a9
	db MUSIC_OVERWORLD

Data_2e072:
	db $04, $08, $00, $08, $04, $02, $03, $c4, $53
	db $05, $08, $00, $08, $04, $02, $03, $c4, $53
	db $00, $03, $13, $0e, $06, $03, $03, $c4, $53
	db $00, $04, $13, $0e, $07, $03, $03, $c4, $53
	db $04, $00, $14, $06, $0d, $00, $03, $c4, $53
	db $05, $00, $14, $07, $0d, $00, $03, $c4, $53
	db $ff

Data_2e0a9:
	dbw $06, Func_2e0dc
	dbw $09, Func_2e10f
	dbw $02, Func_2e0e3
	dbw $0b, Func_2e115
	dbw $01, Func_2e0bc
	dbw $10, Func_2e0cc
	db $ff

Func_2e0bc:
	ld a, EVENT_GOT_GR_COIN_PIECE_TOP_RIGHT
	farcall GetEventValue
	jr nz, .asm_2e0c9
	ld a, MUSIC_HERECOMESGR
	ld [wNextMusic], a
.asm_2e0c9
	scf
	ccf
	ret

Func_2e0cc:
	call GrassClubEntranceShouldRonaldAppear
	jr nc, .asm_2e0d3
	scf
	ret
.asm_2e0d3
	ld a, MUSIC_RONALD
	farcall PlayAfterCurrentSong
	scf
	ccf
	ret

Func_2e0dc:
	ld hl, Data_2e072
	call Func_324d
	ret

Func_2e0e3:
	call GrassClubEntranceShouldRonaldAppear
	jr c, .asm_2e10d
	cp 1
	jr z, .asm_2e0f3
	jr nc, .asm_2e0f8
	ld hl, $4037
	jr .asm_2e0fb
.asm_2e0f3
	ld hl, $417e
	jr .asm_2e0fb
.asm_2e0f8
	ld hl, $41f7
.asm_2e0fb
	ld a, $0a
	ld [wd582], a
	ld a, $0d
	ld [wd592], a
	ld a, l
	ld [wd593], a
	ld a, h
	ld [$d594], a
.asm_2e10d
	scf
	ret

Func_2e10f:
	farcall Func_341c4
	scf
	ret
; 0x2e115

SECTION "Bank b@6115", ROMX[$6115], BANK[$b]

Func_2e115:
	ld a, EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE_DUMMY
	farcall GetEventValue
	jr z, .asm_2e12f
	ld a, OW_RONALD
	farcall ClearOWObject
	ld a, EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE_DUMMY
	farcall ZeroOutEventValue
	ld a, [wNextMusic]
	ld [wCurMusic], a
.asm_2e12f
	scf
	ret

; sets and complements carry flag if Ronald should appear.
; return a = which meeting script to use
GrassClubEntranceShouldRonaldAppear:
	ld a, VAR_TIMES_MET_RONALD
	farcall GetVarValue
	cp 2
	jr c, .second_meeting
	cp 3
	jr c, .third_meeting
	cp 4
	jr c, .fourth_meeting
.asm_2e143
	scf
	ret
.second_meeting ; second meeting - Ronald card pops with you
	xor a
	scf
	ccf
	ret
.third_meeting ; after 2 GC pieces. Ronald gives you Super Energy Retrieval card
	farcall CountGRCoinPiecesObtained
	cp 2
	jr nz, .asm_2e143
	ld a, 1
	scf
	ccf
	ret
.fourth_meeting ; after 4 GC pieces. Ronald tells you he got the stolen cards back
	farcall CountGRCoinPiecesObtained
	cp 4
	jr nz, .asm_2e143
	ld a, 2
	scf
	ccf
	ret

Data_2e163:
	db MAP_GRASS_CLUB
	dba Data_2e1af
	db MUSIC_CLUB_1

Data_2e168:
	db $06, $0e, $12, $04, $01, $02, $03, $c4, $53
	db $07, $0e, $12, $05, $01, $02, $03, $c4, $53
	db $ff

Data_2e17b:
	db $11, $06, $02, $02, $f6, $63
	db $12, $0a, $04, $00, $f6, $63
	db $13, $02, $07, $01, $f6, $63
	db $14, $07, $09, $02, $f6, $63
	db $2f, $07, $08, $02, $98, $64
	db $ff

Data_2e19a:
	db $11, $0b, $26, $62
	db $12, $0b, $8c, $62
	db $13, $0b, $32, $63
	db $14, $0b, $94, $63
	db $2f, $0b, $0b, $64
	db $ff

Data_2e1af:
	dbw $06, Func_2e1d2
	dbw $08, Func_2e1fe
	dbw $09, Func_2e206
	dbw $02, Func_2e1d9
	dbw $07, Func_2e1f5
	dbw $01, Func_2e1c2
	db $ff

Func_2e1c2:
	ld a, EVENT_GOT_GR_COIN_PIECE_TOP_RIGHT
	farcall GetEventValue
	jr nz, .asm_2e1cf
	ld a, MUSIC_HERECOMESGR
	ld [wNextMusic], a
.asm_2e1cf
	scf
	ccf
	ret

Func_2e1d2:
	ld hl, Data_2e168
	call Func_324d
	ret

Func_2e1d9:
	ld a, EVENT_SET_UNTIL_MAP_RELOAD_1
	farcall GetEventValue
	jr nz, .asm_2e1f3
	ld a, EVENT_GOT_GR_COIN_PIECE_TOP_RIGHT
	farcall GetEventValue
	jr z, .asm_2e1f3
	ld bc, TILEMAP_01E
	lb de, 5, 11
	farcall Func_12c0ce
.asm_2e1f3
	scf
	ret

Func_2e1f5:
	ld hl, Data_2e17b
	call Func_3205
	scf
	ccf
	ret

Func_2e1fe:
	ld hl, Data_2e19a
	call Func_328c
	scf
	ret

Func_2e206:
	ld hl, Data_2e211
	ld a, [$d60e]
	call Func_344c
	scf
	ret

Data_2e211:
	db $11, $0b, $6e, $62
	db $12, $0b, $f6, $62
	db $13, $0b, $78, $63
	db $14, $0b, $da, $63
	db $2f, $0b, $49, $64
	db $ff
; 0x2e226

SECTION "Bank b@64b7", ROMX[$64b7], BANK[$b]

Data_2e4b7:
	db MAP_SCIENCE_CLUB_ENTRANCE
	dba Data_2e4ff
	db MUSIC_OVERWORLD

Data_2e4bc:
	db $04, $08, $00, $08, $02, $02, $03, $c4, $53
	db $05, $08, $00, $08, $02, $02, $03, $c4, $53
	db $00, $03, $16, $0e, $06, $03, $03, $c4, $53
	db $00, $04, $16, $0e, $07, $03, $03, $c4, $53
	db $04, $00, $17, $06, $0e, $00, $03, $c4, $53
	db $05, $00, $17, $07, $0e, $00, $03, $c4, $53
	db $ff

Data_2e4f3:
	db $17, $06, $01, $02, $2a, $66
	db $ff

Data_2e4fa:
	db $17, $0b, $d0, $65
	db $ff

Data_2e4ff:
	dbw $06, Func_2e538
	dbw $08, Func_2e574
	dbw $09, Func_2e57c
	dbw $07, Func_2e53f
	dbw $02, Func_2e548
	dbw $0b, Func_2e582
	dbw $01, Func_2e518
	dbw $10, Func_2e528
	db $ff

Func_2e518:
	ld a, EVENT_GOT_GR_COIN_PIECE_TOP_RIGHT
	farcall GetEventValue
	jr nz, .asm_2e525
	ld a, MUSIC_HERECOMESGR
	ld [wNextMusic], a
.asm_2e525
	scf
	ccf
	ret

Func_2e528:
	call ScienceClubEntranceShouldRonaldAppear
	jr nc, .asm_2e52f
	scf
	ret
.asm_2e52f
	ld a, MUSIC_RONALD
	farcall PlayAfterCurrentSong
	scf
	ccf
	ret

Func_2e538:
	ld hl, Data_2e4bc
	call Func_324d
	ret

Func_2e53f:
	ld hl, Data_2e4f3
	call Func_3205
	scf
	ccf
	ret

Func_2e548:
	call ScienceClubEntranceShouldRonaldAppear
	jr c, .asm_2e572
	cp 1
	jr z, .asm_2e558
	jr nc, .asm_2e55d
	ld hl, $4037
	jr .asm_2e560
.asm_2e558
	ld hl, $417e
	jr .asm_2e560
.asm_2e55d
	ld hl, $41f7
.asm_2e560
	ld a, $0a
	ld [wd582], a
	ld a, $0d
	ld [wd592], a
	ld a, l
	ld [wd593], a
	ld a, h
	ld [$d594], a
.asm_2e572
	scf
	ret

Func_2e574:
	ld hl, Data_2e4fa
	call Func_328c
	scf
	ret

Func_2e57c:
	farcall Func_341c4
	scf
	ret

Func_2e582:
	ld a, EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE_DUMMY
	farcall GetEventValue
	jr z, .asm_2e59c
	ld a, OW_RONALD
	farcall ClearOWObject
	ld a, EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE_DUMMY
	farcall ZeroOutEventValue
	ld a, [wNextMusic]
	ld [wCurMusic], a
.asm_2e59c
	scf
	ret

; sets and complements carry flag if Ronald should appear.
; return a = which meeting script to use
ScienceClubEntranceShouldRonaldAppear:
	ld a, VAR_TIMES_MET_RONALD
	farcall GetVarValue
	cp 2
	jr c, .second_meeting
	cp 3
	jr c, .third_meeting
	cp 4
	jr c, .fourth_meeting
.asm_2e5b0
	scf
	ret
.second_meeting ; second meeting - Ronald card pops with you
	xor a
	scf
	ccf
	ret
.third_meeting ; after 2 GC pieces. Ronald gives you Super Energy Retrieval card
	farcall CountGRCoinPiecesObtained
	cp 2
	jr nz, .asm_2e5b0
	ld a, 1
	scf
	ccf
	ret
.fourth_meeting ; after 4 GC pieces. Ronald tells you he got the stolen cards back
	farcall CountGRCoinPiecesObtained
	cp 4
	jr nz, .asm_2e5b0
	ld a, 2
	scf
	ccf
	ret
; 0x2e5d0

SECTION "Bank b@662a", ROMX[$662a], BANK[$b]

Func_2e62a:
	ld a, EVENT_GOT_GR_COIN_PIECE_TOP_RIGHT
	farcall GetEventValue
	jr z, .asm_2e63c
	ld a, EVENT_SET_UNTIL_MAP_RELOAD_1
	farcall GetEventValue
	jr nz, .asm_2e63c
	scf
	ret
.asm_2e63c
	scf
	ccf
	ret

Data_2e63f:
	db MAP_SCIENCE_CLUB_LOBBY
	dba Data_2e6e1
	db MUSIC_OVERWORLD

Data_2e644:
	db $0f, $06, $15, $01, $03, $01, $03, $c4, $53
	db $0f, $07, $15, $01, $04, $01, $03, $c4, $53
	db $ff

Data_2e657:
	db $16, $09, $06, $01, $0d, $68
	db $18, $04, $09, $01, $0d, $68
	db $05, $01, $0a, $03, $22, $68
	db $75, $03, $09, $03, $d1, $68
	db $77, $0d, $04, $02, $d1, $68
	db $78, $07, $09, $03, $d1, $68
	db $64, $02, $02, $02, $00, $00
	db $65, $04, $02, $02, $00, $00
	db $ff

Data_2e688:
	db $16, $0b, $6e, $67
	db $18, $0b, $e3, $67
	db $05, $0f, $0c, $43
	db $75, $0b, $31, $68
	db $77, $0b, $62, $68
	db $78, $0b, $a0, $68
	db $ff

Data_2e6a1:
	db $08, $02, $00, $00, $00, $00, $03, $11, $54
	db $09, $02, $00, $00, $00, $00, $03, $11, $54
	db $02, $04, $00, $00, $00, $00, $0f, $b9, $41
	db $04, $04, $00, $00, $00, $00, $0f, $d9, $42
	db $0c, $02, $00, $00, $00, $00, $10, $ce, $41
	db $0d, $02, $00, $00, $00, $00, $10, $e4, $41
	db $0e, $02, $00, $00, $00, $00, $10, $fa, $41
	db $ff

Data_2e6e1:
	dbw $06, Func_2e71e
	dbw $08, Func_2e72e
	dbw $09, Func_2e73e
	dbw $07, Func_2e725
	dbw $0b, Func_2e752
	dbw $01, Func_2e6f7
	dbw $10, Func_2e709
	db $ff

Func_2e6f7:
	ld a, EVENT_GOT_GR_COIN_PIECE_TOP_RIGHT
	farcall GetEventValue
	jr nz, .asm_2e706
	ld a, MUSIC_HERECOMESGR
	ld [wNextMusic], a
	jr .asm_2e706
.asm_2e706
	scf
	ccf
	ret

Func_2e709:
	ld a, VAR_25
	farcall GetVarValue
	cp 7
	jr z, .asm_2e715
	scf
	ret
.asm_2e715
	ld a, MUSIC_IMAKUNI
	farcall PlayAfterCurrentSong
	scf
	ccf
	ret

Func_2e71e:
	ld hl, Data_2e644
	call Func_324d
	ret

Func_2e725:
	ld hl, Data_2e657
	call Func_3205
	scf
	ccf
	ret

Func_2e72e:
	ld hl, Data_2e688
	call Func_328c
	jr nc, .asm_2e73c
	ld hl, Data_2e6a1
	call Func_32bf
.asm_2e73c
	scf
	ret

Func_2e73e:
	ld hl, Data_2e749
	ld a, [$d60e]
	call Func_344c
	scf
	ret

Data_2e749:
	db $16, $0b, $c7, $67
	db $05, $0f, $ca, $43
	db $ff

Func_2e752:
	ld a, EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE_DUMMY
	farcall GetEventValue
	jr z, .asm_2e76c
	ld a, OW_IMAKUNI_BLACK
	farcall ClearOWObject
	ld a, EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE_DUMMY
	farcall ZeroOutEventValue
	ld a, [wNextMusic]
	ld [wCurMusic], a
.asm_2e76c
	scf
	ret
; 0x2e76e

SECTION "Bank b@68e6", ROMX[$68e6], BANK[$b]

Data_2e8e6:
	db MAP_SCIENCE_CLUB
	dba Data_2e932
	db MUSIC_CLUB_3

Data_2e8eb:
	db $06, $0f, $15, $04, $01, $02, $03, $c4, $53
	db $07, $0f, $15, $05, $01, $02, $03, $c4, $53
	db $ff

Data_2e8fe:
	db $15, $02, $02, $00, $87, $6a
	db $16, $0a, $02, $00, $07, $6c
	db $17, $06, $05, $03, $07, $6c
	db $18, $03, $08, $01, $07, $6c
	db $2f, $06, $08, $02, $a9, $6c
	db $ff

Data_2e91d:
	db $15, $0b, $c7, $69
	db $16, $0b, $94, $6a
	db $17, $0b, $ef, $6a
	db $18, $0b, $a5, $6b
	db $2f, $0b, $1c, $6c
	db $ff

Data_2e932:
	dbw $06, Func_2e955
	dbw $08, Func_2e99f
	dbw $09, Func_2e9a7
	dbw $02, Func_2e95c
	dbw $07, Func_2e996
	dbw $01, Func_2e945
	db $ff

Func_2e945:
	ld a, EVENT_GOT_GR_COIN_PIECE_TOP_RIGHT
	farcall GetEventValue
	jr nz, .asm_2e952
	ld a, MUSIC_HERECOMESGR
	ld [wNextMusic], a
.asm_2e952
	scf
	ccf
	ret

Func_2e955:
	ld hl, Data_2e8eb
	call Func_324d
	ret

Func_2e95c:
	ld a, EVENT_SET_UNTIL_MAP_RELOAD_1
	farcall GetEventValue
	jr nz, .asm_2e994
	ld a, EVENT_GOT_GR_COIN_PIECE_TOP_RIGHT
	farcall GetEventValue
	jr z, .asm_2e994
	ld bc, TILEMAP_022
	lb de, 4, 1
	farcall Func_12c0ce
	ld bc, TILEMAP_023
	lb de, 9, 1
	farcall Func_12c0ce
	ld bc, TILEMAP_024
	lb de, 4, 6
	farcall Func_12c0ce
	ld bc, TILEMAP_025
	lb de, 5, 12
	farcall Func_12c0ce
.asm_2e994
	scf
	ret

Func_2e996:
	ld hl, Data_2e8fe
	call Func_3205
	scf
	ccf
	ret

Func_2e99f:
	ld hl, Data_2e91d
	call Func_328c
	scf
	ret

Func_2e9a7:
	ld hl, Data_2e9b2
	ld a, [$d60e]
	call Func_344c
	scf
	ret

Data_2e9b2:
	db $15, $0b, $4b, $6a
	db $16, $0b, $d1, $6a
	db $17, $0b, $6d, $6b
	db $18, $0b, $eb, $6b
	db $2f, $0b, $5a, $6c
	db $ff
; 0x2e9c7

SECTION "Bank b@6cc8", ROMX[$6cc8], BANK[$b]

Data_2ecc8:
	db MAP_WATER_CLUB_ENTRANCE
	dba Data_2ed04
	db MUSIC_OVERWORLD

Data_2eccd:
	db $04, $08, $00, $07, $06, $02, $03, $c4, $53
	db $05, $08, $00, $07, $06, $02, $03, $c4, $53
	db $00, $03, $19, $0e, $06, $03, $03, $c4, $53
	db $00, $04, $19, $0e, $07, $03, $03, $c4, $53
	db $04, $00, $1a, $06, $0e, $00, $03, $c4, $53
	db $05, $00, $1a, $07, $0e, $00, $03, $c4, $53
	db $ff

Data_2ed04:
	dbw $06, Func_2ed37
	dbw $02, Func_2ed3e
	dbw $04, Func_2ed75
	dbw $0b, Func_2ed8c
	dbw $01, Func_2ed17
	dbw $10, Func_2ed27
	db $ff

Func_2ed17:
	ld a, EVENT_GOT_STARMIE_COIN
	farcall GetEventValue
	jr nz, .asm_2ed24
	ld a, MUSIC_HERECOMESGR
	ld [wNextMusic], a
.asm_2ed24
	scf
	ccf
	ret

Func_2ed27:
	call WaterClubEntranceShouldRonaldAppear
	jr nc, .asm_2ed2e
	scf
	ret
.asm_2ed2e
	ld a, MUSIC_RONALD
	farcall PlayAfterCurrentSong
	scf
	ccf
	ret

Func_2ed37:
	ld hl, Data_2eccd
	call Func_324d
	ret

Func_2ed3e:
	xor a
	call Func_33f2
	; Event Script @ 0x2ed42
	db $64, $12, $00
	call WaterClubEntranceShouldRonaldAppear
	jr c, .asm_2ed73
	or a
	jr nz, .asm_2ed58
	ld hl, $a2a
	call LoadTxRam2
	ld hl, $40a4
	jr .asm_2ed61
.asm_2ed58
	ld a, EVENT_EE
	farcall ZeroOutEventValue
	ld hl, $451d
.asm_2ed61
	ld a, $0a
	ld [wd582], a
	ld a, $0d
	ld [wd592], a
	ld a, l
	ld [wd593], a
	ld a, h
	ld [$d594], a
.asm_2ed73
	scf
	ret

Func_2ed75:
	ld a, EVENT_SET_UNTIL_MAP_RELOAD_1
	farcall GetEventValue
	jr z, .asm_2ed8a
	ld a, [wd585]
	cp 0
	jr nz, .asm_2ed8a
	ld a, EVENT_TALKED_TO_SARA
	farcall ZeroOutEventValue
.asm_2ed8a
	scf
	ret

Func_2ed8c:
	ld a, EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE_DUMMY
	farcall GetEventValue
	jr z, .asm_2eda6
	ld a, OW_RONALD
	farcall ClearOWObject
	ld a, EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE_DUMMY
	farcall ZeroOutEventValue
	ld a, [wNextMusic]
	ld [wCurMusic], a
.asm_2eda6
	scf
	ret

; sets and complements carry flag if Ronald should appear.
; return a = which meeting script to use
;
; This club is an anomaly. For other clubs, return "1" triggers the 3rd meeting,
; but only if you have 2 GC pieces. Here it checks EVENT_EE instead of GC pieces
WaterClubEntranceShouldRonaldAppear:
	ld a, VAR_TIMES_MET_RONALD
	farcall GetVarValue
	cp 2
	jr c, .second_meeting
	ld a, EVENT_EE
	farcall GetEventValue
	jr nz, .asm_2edc0
	scf
	ret
.second_meeting ; second meeting - Ronald card pops with you
	xor a
	scf
	ccf
	ret
.asm_2edc0
	ld a, 1
	scf
	ccf
	ret

Data_2edc5:
	db MAP_WATER_CLUB_LOBBY
	dba Data_2ee5d
	db MUSIC_OVERWORLD

Data_2edca:
	db $0f, $06, $18, $01, $03, $01, $03, $c4, $53
	db $0f, $07, $18, $01, $04, $01, $03, $c4, $53
	db $ff

Data_2eddd:
	db $1b, $08, $06, $03, $5f, $6f
	db $7b, $0b, $01, $03, $00, $00
	db $05, $01, $0a, $03, $9f, $6f
	db $79, $0c, $0b, $01, $00, $00
	db $7a, $04, $09, $02, $00, $00
	db $64, $02, $02, $02, $00, $00
	db $65, $04, $02, $02, $00, $00
	db $ff

Data_2ee08:
	db $1b, $0b, $ea, $6e
	db $7b, $0b, $74, $6f
	db $05, $0f, $0c, $43
	db $79, $0b, $ae, $6f
	db $7a, $0b, $e1, $6f
	db $ff

Data_2ee1d:
	db $08, $02, $00, $00, $00, $00, $03, $11, $54
	db $09, $02, $00, $00, $00, $00, $03, $11, $54
	db $02, $04, $00, $00, $00, $00, $0f, $b9, $41
	db $04, $04, $00, $00, $00, $00, $0f, $d9, $42
	db $0c, $02, $00, $00, $00, $00, $10, $10, $42
	db $0d, $02, $00, $00, $00, $00, $10, $26, $42
	db $0e, $02, $00, $00, $00, $00, $10, $3c, $42
	db $ff

Data_2ee5d:
	dbw $06, Func_2ee9a
	dbw $08, Func_2eeaa
	dbw $09, Func_2eeba
	dbw $07, Func_2eea1
	dbw $0b, Func_2eece
	dbw $01, Func_2ee73
	dbw $10, Func_2ee85
	db $ff

Func_2ee73:
	ld a, EVENT_GOT_STARMIE_COIN
	farcall GetEventValue
	jr nz, .asm_2ee82
	ld a, MUSIC_HERECOMESGR
	ld [wNextMusic], a
	jr .asm_2ee82
.asm_2ee82
	scf
	ccf
	ret

Func_2ee85:
	ld a, VAR_25
	farcall GetVarValue
	cp 8
	jr z, .asm_2ee91
	scf
	ret
.asm_2ee91
	ld a, MUSIC_IMAKUNI
	farcall PlayAfterCurrentSong
	scf
	ccf
	ret

Func_2ee9a:
	ld hl, Data_2edca
	call Func_324d
	ret

Func_2eea1:
	ld hl, Data_2eddd
	call Func_3205
	scf
	ccf
	ret

Func_2eeaa:
	ld hl, Data_2ee08
	call Func_328c
	jr nc, .asm_2eeb8
	ld hl, Data_2ee1d
	call Func_32bf
.asm_2eeb8
	scf
	ret

Func_2eeba:
	ld hl, Data_2eec5
	ld a, [$d60e]
	call Func_344c
	scf
	ret

Data_2eec5:
	db $1b, $0b, $43, $6f
	db $05, $0f, $ca, $43
	db $ff

Func_2eece:
	ld a, EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE_DUMMY
	farcall GetEventValue
	jr z, .asm_2eee8
	ld a, OW_IMAKUNI_BLACK
	farcall ClearOWObject
	ld a, EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE_DUMMY
	farcall ZeroOutEventValue
	ld a, [wNextMusic]
	ld [wCurMusic], a
.asm_2eee8
	scf
	ret
; 0x2eeea

SECTION "Bank b@7012", ROMX[$7012], BANK[$b]

Data_2f012:
	db MAP_WATER_CLUB
	dba Data_2f072
	db MUSIC_CLUB_1

Data_2f017:
	db $06, $0f, $18, $04, $01, $02, $03, $c4, $53
	db $07, $0f, $18, $05, $01, $02, $03, $c4, $53
	db $ff

Data_2f02a:
	db $1a, $0b, $02, $02, $6d, $73
	db $1b, $0a, $04, $02, $6d, $73
	db $1c, $04, $09, $01, $78, $74
	db $1d, $0b, $0a, $03, $78, $74
	db $19, $04, $06, $02, $ed, $71
	db $30, $08, $06, $02, $f2, $74
	db $ff

Data_2f04f:
	db $1a, $0b, $fa, $71
	db $1b, $0b, $cf, $72
	db $1c, $0b, $82, $73
	db $1d, $0b, $f1, $73
	db $19, $0b, $d2, $71
	db $30, $0b, $85, $74
	db $ff

Data_2f068:
	db $0c, $03, $00, $00, $00, $00, $0b, $fa, $71
	db $ff

Data_2f072:
	dbw $06, Func_2f095
	dbw $08, Func_2f0f7
	dbw $02, Func_2f0a5
	dbw $09, Func_2f107
	dbw $07, Func_2f09c
	dbw $01, Func_2f085
	db $ff

Func_2f085:
	ld a, EVENT_GOT_STARMIE_COIN
	farcall GetEventValue
	jr nz, .asm_2f092
	ld a, MUSIC_HERECOMESGR
	ld [wNextMusic], a
.asm_2f092
	scf
	ccf
	ret

Func_2f095:
	ld hl, Data_2f017
	call Func_324d
	ret

Func_2f09c:
	ld hl, Data_2f02a
	call Func_3205
	scf
	ccf
	ret

Func_2f0a5:
	ld a, EVENT_GOT_STARMIE_COIN
	farcall GetEventValue
	jr nz, .asm_2f0c3
	xor a
	call Func_33f2
	; Event Script @ 0x2f0b1
	db $15, $ac, $04, $06, $02, $15, $ad, $03, $06, $01
	db $15, $ae, $05, $06, $03, $00
	jr .asm_2f0f5
.asm_2f0c3
	ld bc, TILEMAP_02A
	lb de, 2, 4
	farcall Func_12c0ce
	ld a, EVENT_SET_UNTIL_MAP_RELOAD_1
	farcall GetEventValue
	jr nz, .asm_2f0e1
	ld bc, TILEMAP_029
	lb de, 5, 12
	farcall Func_12c0ce
	jr .asm_2f0f5
.asm_2f0e1
	xor a
	call Func_33f2
	; Event Script @ 0x2f0e5
	db $22, $19, $09, $05, $02, $22, $1c, $08, $05, $02
	db $22, $1d, $0a, $05, $02, $00
.asm_2f0f5
	scf
	ret

Func_2f0f7:
	ld hl, Data_2f04f
	call Func_328c
	jr nc, .asm_2f105
	ld hl, Data_2f068
	call Func_32bf
.asm_2f105
	scf
	ret

Func_2f107:
	ld hl, Data_2f112
	ld a, [$d60e]
	call Func_344c
	scf
	ret

Data_2f112:
	db $1a, $0b, $8a, $72
	db $1b, $0b, $35, $73
	db $1c, $0b, $d5, $73
	db $1d, $0b, $4f, $74
	db $30, $0b, $d9, $74
	db $ff
; 0x2f127

SECTION "Bank b@74ff", ROMX[$74ff], BANK[$b]

Data_2f4ff:
	db MAP_FIRE_CLUB_ENTRANCE
	dba Data_2f53b
	db MUSIC_OVERWORLD

Data_2f504:
	db $04, $08, $00, $07, $01, $02, $03, $c4, $53
	db $05, $08, $00, $07, $01, $02, $03, $c4, $53
	db $00, $03, $1c, $0e, $06, $03, $03, $c4, $53
	db $00, $04, $1c, $0e, $07, $03, $03, $c4, $53
	db $04, $00, $1d, $06, $0e, $00, $03, $c4, $53
	db $05, $00, $1d, $07, $0e, $00, $03, $c4, $53
	db $ff

Data_2f53b:
	dbw $06, Func_2f56e
	dbw $09, Func_2f5a8
	dbw $02, Func_2f575
	dbw $0b, Func_2f5ae
	dbw $01, Func_2f54e
	dbw $10, Func_2f55e
	db $ff

Func_2f54e:
	ld a, EVENT_GOT_GR_COIN_PIECE_BOTTOM_LEFT
	farcall GetEventValue
	jr nz, .asm_2f55b
	ld a, MUSIC_HERECOMESGR
	ld [wNextMusic], a
.asm_2f55b
	scf
	ccf
	ret

Func_2f55e:
	call FireClubEntranceShouldRonaldAppear
	jr nc, .asm_2f565
	scf
	ret
.asm_2f565
	ld a, MUSIC_RONALD
	farcall PlayAfterCurrentSong
	scf
	ccf
	ret

Func_2f56e:
	ld hl, Data_2f504
	call Func_324d
	ret

Func_2f575:
	xor a
	call Func_33f2
	; Event Script @ 0x2f579
	db $64, $12, $00
	call FireClubEntranceShouldRonaldAppear
	jr c, .asm_2f5a6
	cp 1
	jr z, .asm_2f58c
	jr nc, .asm_2f591
	ld hl, $4037
	jr .asm_2f594
.asm_2f58c
	ld hl, $417e
	jr .asm_2f594
.asm_2f591
	ld hl, $41f7
.asm_2f594
	ld a, $0a
	ld [wd582], a
	ld a, $0d
	ld [wd592], a
	ld a, l
	ld [wd593], a
	ld a, h
	ld [$d594], a
.asm_2f5a6
	scf
	ret

Func_2f5a8:
	farcall Func_341c4
	scf
	ret

Func_2f5ae:
	ld a, EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE_DUMMY
	farcall GetEventValue
	jr z, .asm_2f5c8
	ld a, OW_RONALD
	farcall ClearOWObject
	ld a, EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE_DUMMY
	farcall ZeroOutEventValue
	ld a, [wNextMusic]
	ld [wCurMusic], a
.asm_2f5c8
	scf
	ret

; sets and complements carry flag if Ronald should appear.
; return a = which meeting script to use
FireClubEntranceShouldRonaldAppear:
	ld a, VAR_TIMES_MET_RONALD
	farcall GetVarValue
	cp 2
	jr c, .second_meeting
	cp 3
	jr c, .third_meeting
	cp 4
	jr c, .fourth_meeting
.asm_2f5dc
	scf
	ret
.second_meeting ; second meeting - Ronald card pops with you
	xor a
	scf
	ccf
	ret
.third_meeting ; after 2 GC pieces. Ronald gives you Super Energy Retrieval card
	farcall CountGRCoinPiecesObtained
	cp 2
	jr nz, .asm_2f5dc
	ld a, 1
	scf
	ccf
	ret
.fourth_meeting ; after 4 GC pieces. Ronald tells you he got the stolen cards back
	farcall CountGRCoinPiecesObtained
	cp 4
	jr nz, .asm_2f5dc
	ld a, 2
	scf
	ccf
	ret

Data_2f5fc:
	db MAP_FIRE_CLUB_LOBBY
	dba Data_2f68a
	db MUSIC_OVERWORLD

Data_2f601:
	db $0f, $06, $1b, $01, $03, $01, $03, $c4, $53
	db $0f, $07, $1b, $01, $04, $01, $03, $c4, $53
	db $ff

Data_2f614:
	db $7c, $08, $04, $00, $00, $00
	db $05, $01, $0a, $03, $6f, $77
	db $7d, $0a, $09, $00, $00, $00
	db $7e, $05, $08, $02, $00, $00
	db $64, $02, $02, $02, $00, $00
	db $65, $04, $02, $02, $00, $00
	db $ff

Data_2f639:
	db $7c, $0b, $09, $77
	db $05, $0f, $0c, $43
	db $7d, $0b, $7e, $77
	db $7e, $0b, $a4, $77
	db $ff

Data_2f64a:
	db $08, $02, $00, $00, $00, $00, $03, $11, $54
	db $09, $02, $00, $00, $00, $00, $03, $11, $54
	db $02, $04, $00, $00, $00, $00, $0f, $b9, $41
	db $04, $04, $00, $00, $00, $00, $0f, $d9, $42
	db $0c, $02, $00, $00, $00, $00, $10, $52, $42
	db $0d, $02, $00, $00, $00, $00, $10, $68, $42
	db $0e, $02, $00, $00, $00, $00, $10, $7e, $42
	db $ff

Data_2f68a:
	dbw $06, Func_2f6c7
	dbw $08, Func_2f6d7
	dbw $07, Func_2f6ce
	dbw $09, Func_2f6e7
	dbw $0b, Func_2f6ed
	dbw $01, Func_2f6a0
	dbw $10, Func_2f6b2
	db $ff

Func_2f6a0:
	ld a, EVENT_GOT_GR_COIN_PIECE_BOTTOM_LEFT
	farcall GetEventValue
	jr nz, .asm_2f6af
	ld a, MUSIC_HERECOMESGR
	ld [wNextMusic], a
	jr .asm_2f6af
.asm_2f6af
	scf
	ccf
	ret

Func_2f6b2:
	ld a, VAR_25
	farcall GetVarValue
	cp 9
	jr z, .asm_2f6be
	scf
	ret
.asm_2f6be
	ld a, MUSIC_IMAKUNI
	farcall PlayAfterCurrentSong
	scf
	ccf
	ret

Func_2f6c7:
	ld hl, Data_2f601
	call Func_324d
	ret

Func_2f6ce:
	ld hl, Data_2f614
	call Func_3205
	scf
	ccf
	ret

Func_2f6d7:
	ld hl, Data_2f639
	call Func_328c
	jr nc, .asm_2f6e5
	ld hl, Data_2f64a
	call Func_32bf
.asm_2f6e5
	scf
	ret

Func_2f6e7:
	farcall Func_3c3ca
	scf
	ret

Func_2f6ed:
	ld a, EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE_DUMMY
	farcall GetEventValue
	jr z, .asm_2f707
	ld a, OW_IMAKUNI_BLACK
	farcall ClearOWObject
	ld a, EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE_DUMMY
	farcall ZeroOutEventValue
	ld a, [wNextMusic]
	ld [wCurMusic], a
.asm_2f707
	scf
	ret

SECTION "Bank b@77ca", ROMX[$77ca], BANK[$b]

Data_2f7ca:
	db MAP_FIRE_CLUB
	dba Data_2f83b
	db MUSIC_CLUB_3

Data_2f7cf:
	db $06, $0f, $1b, $04, $01, $02, $03, $c4, $53
	db $07, $0f, $1b, $05, $01, $02, $03, $c4, $53
	db $ff

Data_2f7e2:
	db $1e, $07, $02, $02, $00, $00
	db $1f, $06, $09, $02, $00, $00
	db $20, $05, $07, $02, $00, $00
	db $21, $0a, $05, $02, $00, $00
	db $30, $07, $05, $02, $29, $7c
	db $ff

Data_2f801:
	db $1e, $0b, $26, $79
	db $1f, $0b, $25, $7a
	db $20, $0b, $a1, $7a
	db $21, $0b, $4e, $7b
	db $30, $0b, $d3, $7b
	db $ff

Data_2f816:
	db $07, $0c, $00, $00, $00, $00, $0b, $ad, $7c
	db $06, $0c, $00, $00, $00, $00, $0b, $b7, $7c
	db $05, $0c, $00, $00, $00, $00, $0b, $c1, $7c
	db $08, $0c, $00, $00, $00, $00, $0b, $cb, $7c
	db $ff

Data_2f83b:
	dbw $06, Func_2f85e
	dbw $08, Func_2f8c8
	dbw $09, Func_2f8d8
	dbw $02, Func_2f86e
	dbw $07, Func_2f865
	dbw $01, Func_2f84e
	db $ff

Func_2f84e:
	ld a, EVENT_GOT_GR_COIN_PIECE_BOTTOM_LEFT
	farcall GetEventValue
	jr nz, .asm_2f85b
	ld a, MUSIC_HERECOMESGR
	ld [wNextMusic], a
.asm_2f85b
	scf
	ccf
	ret

Func_2f85e:
	ld hl, Data_2f7cf
	call Func_324d
	ret

Func_2f865:
	ld hl, Data_2f7e2
	call Func_3205
	scf
	ccf
	ret

Func_2f86e:
	ld a, EVENT_GOT_CHARMANDER_COIN
	farcall GetEventValue
	jr nz, .asm_2f891
	xor a
	call Func_33f2
	; Event Script @ 0x2f87a
	db $22, $1e, $07, $0a, $02, $22, $1f, $06, $0a, $02
	db $22, $20, $05, $0a, $02, $22, $21, $08, $0a, $02
	db $00
	jr .asm_2f8c6
.asm_2f891
	ld bc, TILEMAP_02E
	lb de, 5, 11
	farcall Func_12c0ce
	ld bc, TILEMAP_02F
	lb de, 5, 7
	farcall Func_12c0ce
	ld a, EVENT_SET_UNTIL_MAP_RELOAD_1
	farcall GetEventValue
	jr z, .asm_2f8c6
	xor a
	call Func_33f2
	; Event Script @ 0x2f8b1
	db $22, $1e, $07, $0a, $02, $22, $1f, $06, $0a, $02
	db $22, $20, $05, $0a, $02, $22, $21, $08, $0a, $02
	db $00
.asm_2f8c6
	scf
	ret

Func_2f8c8:
	ld hl, Data_2f801
	call Func_328c
	jr nc, .asm_2f8d6
	ld hl, Data_2f816
	call Func_32bf
.asm_2f8d6
	scf
	ret

Func_2f8d8:
	ld hl, Data_2f8e3
	ld a, [$d60e]
	call Func_344c
	scf
	ret

Data_2f8e3:
	db $1e, $0b, $ed, $79
	db $1f, $0b, $85, $7a
	db $20, $0b, $32, $7b
	db $21, $0b, $b7, $7b
	db $30, $0b, $0e, $7c
	db $ff
; 0x2f8f8

SECTION "Bank b@7cd5", ROMX[$7cd5], BANK[$b]

Data_2fcd5:
	db MAP_POKEMON_DOME_ENTRANCE
	dba Data_2fd66
	db MUSIC_OVERWORLD

Data_2fcda:
	db $07, $08, $00, $04, $04, $02, $03, $c4, $53
	db $08, $08, $00, $04, $04, $02, $03, $c4, $53
	db $0b, $00, $24, $07, $0e, $00, $03, $c4, $53
	db $0c, $00, $24, $08, $0e, $00, $03, $c4, $53
	db $ff

Data_2fcff:
	db $b2, $08, $03, $00, $1d, $7e
	db $ff

Data_2fd06:
	db $b2, $0b, $a3, $7d
	db $ff

Data_2fd0b:
	db $04, $02, $00, $00, $00, $00, $03, $11, $54
	db $05, $02, $00, $00, $00, $00, $03, $11, $54
	db $09, $01, $00, $00, $00, $00, $0b, $2a, $7e
	db $0a, $01, $00, $00, $00, $00, $0b, $2a, $7e
	db $01, $02, $00, $00, $00, $00, $10, $5a, $43
	db $02, $02, $00, $00, $00, $00, $10, $70, $43
	db $03, $02, $00, $00, $00, $00, $10, $86, $43
	db $01, $05, $00, $00, $00, $00, $10, $9c, $43
	db $02, $05, $00, $00, $00, $00, $10, $b2, $43
	db $03, $05, $00, $00, $00, $00, $10, $c8, $43
	db $ff

Data_2fd66:
	dbw $06, Func_2fd83
	dbw $08, Func_2fd93
	dbw $07, Func_2fd8a
	dbw $01, Func_2fd73
	db $ff

Func_2fd73:
	ld a, EVENT_GOT_GR_COIN
	farcall GetEventValue
	jr nz, .asm_2fd80
	ld a, MUSIC_HERECOMESGR
	ld [wNextMusic], a
.asm_2fd80
	scf
	ccf
	ret

Func_2fd83:
	ld hl, Data_2fcda
	call Func_324d
	ret

Func_2fd8a:
	ld hl, Data_2fcff
	call Func_3205
	scf
	ccf
	ret

Func_2fd93:
	ld hl, Data_2fd06
	call Func_328c
	jr nc, .asm_2fda1
	ld hl,Data_2fd0b
	call Func_32bf
.asm_2fda1
	scf
	ret
; 0x2fda3

SECTION "Bank b@7e45", ROMX[$7e45], BANK[$b]

Data_2fe45:
	db MAP_OVERHEAD_ISLANDS
	dba Data_2fe4a
	db MUSIC_GRBLIMP

Data_2fe4a:
	dbw $02, Func_2fe54
	dbw $04, Func_2fe94
	dbw $0f, Func_2fe97
	db $ff

Func_2fe54:
	farcall InitOWObjects
	ld a, [wd584]
	cp 0
	jr nz, .asm_2fe6c
	ld a, OW_GR_BLIMP
	lb de, 16, 128
	ld b, EAST
	farcall LoadOWObject
	jr .asm_2fe77
.asm_2fe6c
	ld a, OW_GR_BLIMP
	lb de, 144, 16
	ld b, WEST
	farcall LoadOWObject
.asm_2fe77
	ld a, $0a
	ld [wd582], a
	ld a, $0b
	ld [wd592], a
	ld hl, $7e9a
	ld a, l
	ld [wd593], a
	ld a, h
	ld [$d594], a
	ld a, $00
	call Func_338f
	scf
	ccf
	ret

Func_2fe94:
	scf
	ccf
	ret

Func_2fe97:
	scf
	ccf
	ret
; 0x2fe9a
