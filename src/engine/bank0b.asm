SECTION "Bank b@4000", ROMX[$4000], BANK[$b]

Data_2c000:
	db MAP_ISHIHARAS_HOUSE
	dba Data_2c09b
	db MUSIC_ISHIHARA

SECTION "Bank b@409b", ROMX[$409b], BANK[$b]

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
	ld hl, $4005
	call Func_324d
	ret

Func_2c0c8:
	ld hl, $4018
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
	ld hl, $4025
	call Func_328c
	jr nc, .asm_2c0ff
	ld hl, $402e
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
	cp $05
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


SECTION "Bank b@44c5", ROMX[$44c5], BANK[$b]

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
	ld hl, $447e
	call Func_324d
	ret

Func_2c501:
	ld hl, $4491
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
	ld hl, $44b0
	call Func_328c
	scf
	ret

Func_2c568:
	ld hl, $4573
	ld a, [$d60e]
	call Func_344c
	scf
	ret
; 0x2c573

SECTION "Bank b@4936", ROMX[$4936], BANK[$b]

Data_2c936:
	db MAP_PSYCHIC_CLUB_ENTRANCE
	dba Data_2c990
	db MUSIC_OVERWORLD


SECTION "Bank b@4990", ROMX[$4990], BANK[$b]

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
	ld hl, $493b
	call Func_324d
	ret

Func_2c9df:
	ld hl, $4984
	call Func_3205
	scf
	ccf
	ret

Func_2c9e8:
	call PsychicClubEntranceShouldRonaldAppear
	jr c, .asm_2ca12
	cp $01
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
	ld hl, $498b
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
	farcall _ClearOWObject
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
	ld a, VAR_TIMES_RONALD_MET
	farcall GetVarValue
	cp $02
	jr c, .second_meeting
	cp $03
	jr c, .third_meeting
	cp $04
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
	cp $02
	jr nz, .asm_2cada
	ld a, $01
	scf
	ccf
	ret
.fourth_meeting ; after 4 GR pieces. Ronald tells you he got the stolen cards back
	farcall CountGRCoinPiecesObtained
	cp $04
	jr nz, .asm_2cada
	ld a, $02
	scf
	ccf
	ret

Data_2cafa:
	db MAP_PSYCHIC_CLUB_LOBBY
	dba Data_2cb92
	db MUSIC_OVERWORLD

SECTION "Bank b@4b92", ROMX[$4b92], BANK[$b]

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
	cp $03
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
	ld hl, $4aff
	call Func_324d
	ret

Func_2cbd6:
	ld hl, $4b12
	call Func_3205
	scf
	ccf
	ret

Func_2cbdf:
	ld hl, $4b3d
	call Func_328c
	jr nc, .asm_2cbed
	ld hl, $4b52
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
	farcall _ClearOWObject
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

SECTION "Bank b@4d6f", ROMX[$4d6f], BANK[$b]

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
	ld hl, $4d28
	call Func_324d
	ret

Func_2cd99:
	ld hl, $4d3b
	call Func_3205
	scf
	ccf
	ret
; 0x2cda2

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
	ld hl, $4d5a
	call Func_328c
	scf
	ret

Func_2ce19:
	ld hl, $4e24
	ld a, [$d60e]
	call Func_344c
	scf
	ret

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

SECTION "Bank b@5346", ROMX[$5346], BANK[$b]

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
	call Func_2d3b5
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
	ld hl, $530f
	call Func_324d
	ret

Func_2d37d:
	call Func_2d3b5
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
	farcall _ClearOWObject
	ld a, EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE_DUMMY
	farcall ZeroOutEventValue
	ld a, [wNextMusic]
	ld [wCurMusic], a
.asm_2d3b3
	scf
	ret

Func_2d3b5:
	ld a, VAR_TIMES_RONALD_MET
	farcall GetVarValue
	cp $02
	jr c, .asm_2d3c1
	scf
	ret
.asm_2d3c1
	scf
	ccf
	ret

Data_2d3c4:
	db MAP_ROCK_CLUB_LOBBY
	dba Data_2d45c
	db MUSIC_OVERWORLD

SECTION "Bank b@545c", ROMX[$545c], BANK[$b]

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
	cp $04
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
	ld hl, $53c9
	call Func_324d
	ret

Func_2d4a5:
	ld hl, $53dc
	call Func_3205
	scf
	ccf
	ret

Func_2d4ae:
	ld hl, $5407
	call Func_328c
	jr nc, .asm_2d4bc
	ld hl, $541c
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
	farcall _ClearOWObject
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

SECTION "Bank b@5640", ROMX[$5640], BANK[$b]

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
	ld hl, $55fd
	call Func_324d
	ret

Func_2d66a:
	ld hl, $5610
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
	ld hl, $562f
	call Func_328c
	scf
	ret

Func_2d6ae:
	ld hl, $56b9
	ld a, [$d60e]
	call Func_344c
	scf
	ret
; 0x2d6b9

SECTION "Bank b@5930", ROMX[$5930], BANK[$b]

Data_2d930:
	db MAP_FIGHTING_CLUB_ENTRANCE
	dba Data_2d96c
	db MUSIC_OVERWORLD

SECTION "Bank b@596c", ROMX[$596c], BANK[$b]

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
	call Func_2d9f4
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
	ld hl, $5935
	call Func_324d
	ret

Func_2d9a6:
	call Func_2d9f4
	jr c, .asm_2d9d0
	cp $01
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
	farcall _ClearOWObject
	ld a, EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE_DUMMY
	farcall ZeroOutEventValue
	ld a, [wNextMusic]
	ld [wCurMusic], a
.asm_2d9f2
	scf
	ret

Func_2d9f4:
	ld a, VAR_TIMES_RONALD_MET
	farcall GetVarValue
	cp $02
	jr c, .asm_2da08
	cp $03
	jr c, .asm_2da0c
	cp $04
	jr c, .asm_2da19
.asm_2da06
	scf
	ret
.asm_2da08
	xor a
	scf
	ccf
	ret
.asm_2da0c
	farcall CountGRCoinPiecesObtained
	cp $02
	jr nz, .asm_2da06
	ld a, $01
	scf
	ccf
	ret
.asm_2da19
	farcall CountGRCoinPiecesObtained
	cp $04
	jr nz, .asm_2da06
	ld a, $02
	scf
	ccf
	ret

Data_2da26:
	db MAP_FIGHTING_CLUB_LOBBY
	dba Data_d2abe
	db MUSIC_OVERWORLD

SECTION "Bank b@5abe", ROMX[$5abe], BANK[$b]

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
	ld hl, $5a2b
	call Func_324d
	ret

Func_2dae5:
	ld hl, $5a3e
	call Func_3205
	scf
	ccf
	ret

Func_2daee:
	ld hl, $5a69
	call Func_328c
	jr nc, .asm_2dafc
	ld hl, $5a7e
	call Func_32bf
.asm_2dafc
	scf
	ret

Func_2dafe:
	ld hl, $5b09
	ld a, [$d60e]
	call Func_344c
	scf
	ret
; 0x2db09

SECTION "Bank b@5c9f", ROMX[$5c9f], BANK[$b]

Data_2dc9f:
	db MAP_FIGHTING_CLUB
	dba Data_2dceb
	db MUSIC_CLUB_3

SECTION "Bank b@5ceb", ROMX[$5ceb], BANK[$b]

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
	ld hl, $5ca4
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
	ld hl, $5cb7
	call Func_3205
	scf
	ccf
	ret

Func_2dd3a:
	ld hl, $5cd6
	call Func_328c
	scf
	ret

Func_2dd42:
	ld hl, $5d4d
	ld a, [$d60e]
	call Func_344c
	scf
	ret
; 0x2dd4d

SECTION "Bank b@5d9c", ROMX[$5d9c], BANK[$b]

Func_2dd9c:
	dec b
	sub b
	ld [$2], sp
	ret
; 0x2dda2

SECTION "Bank b@5ef2", ROMX[$5ef2], BANK[$b]

Func_2def2:
	dec b
	xor c
	ld [$2], sp
	ret
; 0x2def8

SECTION "Bank b@606d", ROMX[$606d], BANK[$b]

Data_2e06d:
	db MAP_GRASS_CLUB_ENTRANCE
	dba Data_2e0a9
	db MUSIC_OVERWORLD

SECTION "Bank b@60a9", ROMX[$60a9], BANK[$b]

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
	call Func_2e131
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
	ld hl, $6072
	call Func_324d
	ret

Func_2e0e3:
	call Func_2e131
	jr c, .asm_2e10d
	cp $01
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
	farcall _ClearOWObject
	ld a, EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE_DUMMY
	farcall ZeroOutEventValue
	ld a, [wNextMusic]
	ld [wCurMusic], a
.asm_2e12f
	scf
	ret

Func_2e131:
	ld a, VAR_TIMES_RONALD_MET
	farcall GetVarValue
	cp $02
	jr c, .asm_2e145
	cp $03
	jr c, .asm_2e149
	cp $04
	jr c, .asm_2e156
.asm_2e143
	scf
	ret
.asm_2e145
	xor a
	scf
	ccf
	ret
.asm_2e149
	farcall CountGRCoinPiecesObtained
	cp $02
	jr nz, .asm_2e143
	ld a, $01
	scf
	ccf
	ret
.asm_2e156
	farcall CountGRCoinPiecesObtained
	cp $04
	jr nz, .asm_2e143
	ld a, $02
	scf
	ccf
	ret

Data_2e163:
	db MAP_GRASS_CLUB
	dba Data_2e1af
	db MUSIC_CLUB_1

SECTION "Bank b@61af", ROMX[$61af], BANK[$b]

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
	ld hl, $6168
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
	ld hl, $617b
	call Func_3205
	scf
	ccf
	ret

Func_2e1fe:
	ld hl, $619a
	call Func_328c
	scf
	ret

Func_2e206:
	ld hl, $6211
	ld a, [$d60e]
	call Func_344c
	scf
	ret
; 0x2e211

SECTION "Bank b@64b7", ROMX[$64b7], BANK[$b]

Data_2e4b7:
	db MAP_SCIENCE_CLUB_ENTRANCE
	dba Data_2e4ff
	db MUSIC_OVERWORLD

SECTION "Bank b@64ff", ROMX[$64ff], BANK[$b]

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
	call Func_2e59e
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
	ld hl, $64bc
	call Func_324d
	ret

Func_2e53f:
	ld hl, $64f3
	call Func_3205
	scf
	ccf
	ret

Func_2e548:
	call Func_2e59e
	jr c, .asm_2e572
	cp $01
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
	ld hl, $64fa
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
	farcall _ClearOWObject
	ld a, EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE_DUMMY
	farcall ZeroOutEventValue
	ld a, [wNextMusic]
	ld [wCurMusic], a
.asm_2e59c
	scf
	ret

Func_2e59e:
	ld a, VAR_TIMES_RONALD_MET
	farcall GetVarValue
	cp $02
	jr c, .asm_2e5b2
	cp $03
	jr c, .asm_2e5b6
	cp $04
	jr c, .asm_2e5c3
.asm_2e5b0
	scf
	ret
.asm_2e5b2
	xor a
	scf
	ccf
	ret
.asm_2e5b6
	farcall CountGRCoinPiecesObtained
	cp $02
	jr nz, .asm_2e5b0
	ld a, $01
	scf
	ccf
	ret
.asm_2e5c3
	farcall CountGRCoinPiecesObtained
	cp $04
	jr nz, .asm_2e5b0
	ld a, $02
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

SECTION "Bank b@66e1", ROMX[$66e1], BANK[$b]

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
	cp $07
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
	ld hl, $6644
	call Func_324d
	ret

Func_2e725:
	ld hl, $6657
	call Func_3205
	scf
	ccf
	ret

Func_2e72e:
	ld hl, $6688
	call Func_328c
	jr nc, .asm_2e73c
	ld hl, $66a1
	call Func_32bf
.asm_2e73c
	scf
	ret

Func_2e73e:
	ld hl, $6749
	ld a, [$d60e]
	call Func_344c
	scf
	ret
; 0x2e749

SECTION "Bank b@6752", ROMX[$6752], BANK[$b]

Func_2e752:
	ld a, EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE_DUMMY
	farcall GetEventValue
	jr z, .asm_2e76c
	ld a, OW_IMAKUNI_BLACK
	farcall _ClearOWObject
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

SECTION "Bank b@6932", ROMX[$6932], BANK[$b]

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
	ld hl, $68eb
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
	ld hl, $68fe
	call Func_3205
	scf
	ccf
	ret

Func_2e99f:
	ld hl, $691d
	call Func_328c
	scf
	ret

Func_2e9a7:
	ld hl, $69b2
	ld a, [$d60e]
	call Func_344c
	scf
	ret
; 0x2e9b2

SECTION "Bank b@6cc8", ROMX[$6cc8], BANK[$b]

Data_2ecc8:
	db MAP_WATER_CLUB_ENTRANCE
	dba Data_2ed04
	db MUSIC_OVERWORLD

SECTION "Bank b@6d04", ROMX[$6d04], BANK[$b]

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
	call Func_2eda8
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
	ld hl, $6ccd
	call Func_324d
	ret

Func_2ed3e:
	xor a
	call Func_33f2
	; Event Script @ 0x2ed42
	db $64, $12, $00
	call Func_2eda8
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
	cp $00
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
	farcall _ClearOWObject
	ld a, EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE_DUMMY
	farcall ZeroOutEventValue
	ld a, [wNextMusic]
	ld [wCurMusic], a
.asm_2eda6
	scf
	ret

Func_2eda8:
	ld a, VAR_TIMES_RONALD_MET
	farcall GetVarValue
	cp $02
	jr c, .asm_2edbc
	ld a, EVENT_EE
	farcall GetEventValue
	jr nz, .asm_2edc0
	scf
	ret
.asm_2edbc
	xor a
	scf
	ccf
	ret
.asm_2edc0
	ld a, $01
	scf
	ccf
	ret

Data_2edc5:
	db MAP_WATER_CLUB_LOBBY
	dba Data_2ee5d
	db MUSIC_OVERWORLD

SECTION "Bank b@6e5d", ROMX[$6e5d], BANK[$b]

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
	cp $08
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
	ld hl, $6dca
	call Func_324d
	ret

Func_2eea1:
	ld hl, $6ddd
	call Func_3205
	scf
	ccf
	ret

Func_2eeaa:
	ld hl, $6e08
	call Func_328c
	jr nc, .asm_2eeb8
	ld hl, $6e1d
	call Func_32bf
.asm_2eeb8
	scf
	ret

Func_2eeba:
	ld hl, $6ec5
	ld a, [$d60e]
	call Func_344c
	scf
	ret
; 0x2eec5

SECTION "Bank b@6ece", ROMX[$6ece], BANK[$b]

Func_2eece:
	ld a, EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE_DUMMY
	farcall GetEventValue
	jr z, .asm_2eee8
	ld a, OW_IMAKUNI_BLACK
	farcall _ClearOWObject
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

SECTION "Bank b@7072", ROMX[$7072], BANK[$b]

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
	ld hl, $7017
	call Func_324d
	ret

Func_2f09c:
	ld hl, $702a
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
	ld hl, $704f
	call Func_328c
	jr nc, .asm_2f105
	ld hl, $7068
	call Func_32bf
.asm_2f105
	scf
	ret

Func_2f107:
	ld hl, $7112
	ld a, [$d60e]
	call Func_344c
	scf
	ret
; 0x2f112

SECTION "Bank b@74ff", ROMX[$74ff], BANK[$b]

Data_2f4ff:
	db MAP_FIRE_CLUB_ENTRANCE
	dba Data_2f53b
	db MUSIC_OVERWORLD

SECTION "Bank b@753b", ROMX[$753b], BANK[$b]

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
	call Func_2f5ca
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
	ld hl, $7504
	call Func_324d
	ret

Func_2f575:
	xor a
	call Func_33f2
	; Event Script @ 0x2f579
	db $64, $12, $00
	call Func_2f5ca
	jr c, .asm_2f5a6
	cp $01
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
	farcall _ClearOWObject
	ld a, EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE_DUMMY
	farcall ZeroOutEventValue
	ld a, [wNextMusic]
	ld [wCurMusic], a
.asm_2f5c8
	scf
	ret

Func_2f5ca:
	ld a, VAR_TIMES_RONALD_MET
	farcall GetVarValue
	cp $02
	jr c, .asm_2f5de
	cp $03
	jr c, .asm_2f5e2
	cp $04
	jr c, .asm_2f5ef
.asm_2f5dc
	scf
	ret
.asm_2f5de
	xor a
	scf
	ccf
	ret
.asm_2f5e2
	farcall CountGRCoinPiecesObtained
	cp $02
	jr nz, .asm_2f5dc
	ld a, $01
	scf
	ccf
	ret
.asm_2f5ef
	farcall CountGRCoinPiecesObtained
	cp $04
	jr nz, .asm_2f5dc
	ld a, $02
	scf
	ccf
	ret

Data_2f5fc:
	db MAP_FIRE_CLUB_LOBBY
	dba Data_2f68a
	db MUSIC_OVERWORLD

SECTION "Bank b@768a", ROMX[$768a], BANK[$b]

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
	cp $09
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
	ld hl, $7601
	call Func_324d
	ret

Func_2f6ce:
	ld hl, $7614
	call Func_3205
	scf
	ccf
	ret

Func_2f6d7:
	ld hl, $7639
	call Func_328c
	jr nc, .asm_2f6e5
	ld hl, $764a
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
	farcall _ClearOWObject
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

SECTION "Bank b@783b", ROMX[$783b], BANK[$b]

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
	ld hl, $77cf
	call Func_324d
	ret

Func_2f865:
	ld hl, $77e2
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
	ld hl, $7801
	call Func_328c
	jr nc, .asm_2f8d6
	ld hl, $7816
	call Func_32bf
.asm_2f8d6
	scf
	ret

Func_2f8d8:
	ld hl, $78e3
	ld a, [$d60e]
	call Func_344c
	scf
	ret
; 0x2f8e3


SECTION "Bank b@7cd5", ROMX[$7cd5], BANK[$b]

Data_2fcd5:
	db MAP_POKEMON_DOME_ENTRANCE
	dba Data_2fd66
	db MUSIC_OVERWORLD

SECTION "Bank b@7d66", ROMX[$7d66], BANK[$b]

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
	ld hl, $7cda
	call Func_324d
	ret

Func_2fd8a:
	ld hl, $7cff
	call Func_3205
	scf
	ccf
	ret

Func_2fd93:
	ld hl, $7d06
	call Func_328c
	jr nc, .asm_2fda1
	ld hl, $7d0b
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
	cp $00
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
