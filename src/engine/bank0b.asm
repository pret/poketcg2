SECTION "Bank b@4000", ROMX[$4000], BANK[$b]

IshiharasHouse_MapHeader:
	db MAP_ISHIHARAS_HOUSE
	dba IshiharasHouse_MapScripts
	db MUSIC_ISHIHARA

IshiharasHouse_StepEvents:
	db 4, 12, $00, 0, 2, SOUTH, $03, $C4, $53
	db 5, 12, $00, 0, 2, SOUTH, $03, $C4, $53
	db $ff

IshiharasHouse_NPCs:
	db OW_ISHIHARA, 4, 4, SOUTH, $B8, $41
	db OW_NIKKI, 5, 4, SOUTH, $6A, $44
	db $ff

IshiharasHouse_NPCInteractions:
	db OW_ISHIHARA, $0b, $72, $41
	db OW_NIKKI, $0b, $cb, $43
	db $ff

IshiharasHouse_OWInteractions:
	db 3, 2, $00, $00, $00, $00, $10, $00, $40
	db 4, 2, $00, $00, $00, $00, $10, $16, $40
	db 5, 2, $00, $00, $00, $00, $10, $2c, $40
	db 6, 2, $00, $00, $00, $00, $10, $42, $40
	db 7, 2, $00, $00, $00, $00, $10, $58, $40
	db 8, 2, $00, $00, $00, $00, $10, $6e, $40
	db 1, 9, $00, $00, $00, $00, $10, $84, $40
	db 2, 9, $00, $00, $00, $00, $10, $9a, $40
	db 3, 9, $00, $00, $00, $00, $10, $b0, $40
	db 6, 9, $00, $00, $00, $00, $10, $c6, $40
	db 7, 9, $00, $00, $00, $00, $10, $dc, $40
	db 8, 9, $00, $00, $00, $00, $10, $f2, $40
	db $ff

IshiharasHouse_MapScripts:
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
	ld hl, IshiharasHouse_StepEvents
	call Func_324d
	ret

Func_2c0c8:
	ld hl, IshiharasHouse_NPCs
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
	ld hl, IshiharasHouse_NPCInteractions
	call Func_328c
	jr nc, .asm_2c0ff
	ld hl, IshiharasHouse_OWInteractions
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

LightningClub_MapHeader:
	db MAP_LIGHTNING_CLUB_1
	dba LightningClub_MapScripts
	db MUSIC_CLUB_1

LightningClub_StepEvents:
	db 6, 15, $06, 4, 1, SOUTH, $03, $c4, $53
	db 7, 15, $06, 5, 1, SOUTH, $03, $c4, $53
	db $ff

LightningClub_NPCs:
	db OW_ISAAC, 6, 2, SOUTH, $00, $00
	db OW_JENNIFER, 7, 9, SOUTH, $f9, $48
	db OW_NICHOLAS, 3, 5, SOUTH, $00, $00
	db OW_BRANDON, 11, 6, SOUTH, $f9, $48
	db OW_GR_4, 7, 4, SOUTH, $29, $49
	db $ff

LightningClub_NPCInteractions:
	db OW_ISAAC, $0b, $45, $46
	db OW_JENNIFER, $0b, $3b, $47
	db OW_NICHOLAS, $0b, $9d, $47
	db OW_BRANDON, $0b, $97, $48
	db OW_GR_4, $0b, $0e, $49
	db $ff

LightningClub_MapScripts:
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
	ld hl, LightningClub_StepEvents
	call Func_324d
	ret

Func_2c501:
	ld hl, LightningClub_NPCs
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
	ld hl, LightningClub_NPCInteractions
	call Func_328c
	scf
	ret

Func_2c568:
	ld hl, LightningClub_AfterDuelScripts
	ld a, [$d60e]
	call Func_344c
	scf
	ret

LightningClub_AfterDuelScripts:
	db OW_ISAAC, $0b, $ec, $46
	db OW_JENNIFER, $0b, $81, $47
	db OW_NICHOLAS, $0b, $47, $48
	db OW_BRANDON, $0b, $dd, $48
	db $ff
; 0x2c584

SECTION "Bank b@4936", ROMX[$4936], BANK[$b]

PsychicClubEntrance_MapHeader:
	db MAP_PSYCHIC_CLUB_ENTRANCE
	dba PsychicClubEntrance_MapScripts
	db MUSIC_OVERWORLD

PsychicClubEntrance_StepEvents:
	db 4, 8, $00, 6, 3, SOUTH, $03, $c4, $53
	db 5, 8, $00, 6, 3, SOUTH, $03, $c4, $53
	db 0, 3, $0a, 14, 6, WEST, $03, $c4, $53
	db 0, 4, $0a, 14, 7, WEST, $03, $c4, $53
	db 4, 0, $0b, 6, 12, NORTH, $03, $c4, $53
	db 5, 0, $0b, 7, 12, NORTH, $03, $c4, $53
	db 4, 2, $00, $00, $00, $00, $0b, $3e, $4a
	db 5, 2, $00, $00, $00, $00, $0b, $3e, $4a
	db $ff

PsychicClubEntrance_NPCs:
	db OW_STEPHANIE, 5, 1, SOUTH, $bb, $4a
	db $ff

PsychicClubEntrance_NPCInteractions:
	db OW_STEPHANIE, $0b, $a0, $4a
	db $ff

PsychicClubEntrance_MapScripts:
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
	call PsychicClubEntrance_ShouldRonaldAppear
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
	ld hl, PsychicClubEntrance_StepEvents
	call Func_324d
	ret

Func_2c9df:
	ld hl, PsychicClubEntrance_NPCs
	call Func_3205
	scf
	ccf
	ret

Func_2c9e8:
	call PsychicClubEntrance_ShouldRonaldAppear
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
	ld hl, PsychicClubEntrance_NPCInteractions
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
PsychicClubEntrance_ShouldRonaldAppear:
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

PsychicClubLobby_MapHeader:
	db MAP_PSYCHIC_CLUB_LOBBY
	dba PsychicClubLobby_MapScripts
	db MUSIC_OVERWORLD

PsychicClubLobby_StepEvents:
	db 15, 6, $09, 1, 3, EAST, $03, $c4, $53
	db 15, 7, $09, 1, 4, EAST, $03, $c4, $53
	db $ff

PsychicClubLobby_NPCs:
	db OW_SPECS_5, $08, $08, $01, $00, $00
	db OW_LASS1_4, $0a, $09, $03, $00, $00
	db OW_IMAKUNI_BLACK, $01, $0a, $03, $a8, $4c
	db OW_LAD_6, $07, $06, $01, $00, $00
	db OW_GR_LASS_2, $0e, $04, $02, $0e, $4d
	db OW_CLERK_1, $02, $02, $02, $00, $00
	db OW_CLERK_2, $04, $02, $02, $00, $00
	db $ff

PsychicClubLobby_NPCInteractions:
	db OW_SPECS_5, $0b, $11, $4c
	db OW_LASS1_4, $0b, $7d, $4c
	db OW_IMAKUNI_BLACK, $0f, $0c, $43
	db OW_LAD_6, $0b, $b7, $4c
	db OW_GR_LASS_2, $0b, $e8, $4c
	db $ff

PsychicClubLobby_OWInteractions:
	db 8, 2, $00, $00, $00, $00, $03, $11, $54
	db 9, 2, $00, $00, $00, $00, $03, $11, $54
	db 2, 4, $00, $00, $00, $00, $0f, $b9, $41
	db 4, 4, $00, $00, $00, $00, $0f, $d9, $42
	db 12, 2, $00, $00, $00, $00, $10, $d6, $42
	db 13, 2, $00, $00, $00, $00, $10, $ec, $42
	db 14, 2, $00, $00, $00, $00, $10, $02, $43
	db $ff

PsychicClubLobby_MapScripts:
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
	ld hl, PsychicClubLobby_StepEvents
	call Func_324d
	ret

Func_2cbd6:
	ld hl, PsychicClubLobby_NPCs
	call Func_3205
	scf
	ccf
	ret

Func_2cbdf:
	ld hl, PsychicClubLobby_NPCInteractions
	call Func_328c
	jr nc, .asm_2cbed
	ld hl, PsychicClubLobby_OWInteractions
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

PsychicClub_MapHeader:
	db MAP_PSYCHIC_CLUB
	dba PsychicClub_MapScripts
	db MUSIC_CLUB_2

PsychicClub_StepEvents:
	db 6, 13, $09, 4, 1, SOUTH, $03, $c4, $53
	db 7, 13, $09, 5, 1, SOUTH, $03, $c4, $53
	db $ff

PsychicClub_NPCs:
	db OW_MURRAY, 6, 3, SOUTH, $00, $00
	db OW_ROBERT, 3, 10, WEST, $00, $00
	db OW_DANIEL, 4, 5, NORTH, $00, $00
	db OW_STEPHANIE, 11, 6, EAST, $00, $00
	db OW_GR_4, 7, 3, SOUTH, $3c, $52
	db $ff

PsychicClub_NPCInteractions:
	db OW_MURRAY, $0b, $88, $4e
	db OW_ROBERT, $0b, $cc, $4f
	db OW_DANIEL, $0b, $46, $50
	db OW_STEPHANIE, $0b, $b3, $50
	db OW_GR_4, $0b, $90, $51
	db $ff

PsychicClub_MapScripts:
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
	ld hl, PsychicClub_StepEvents
	call Func_324d
	ret

Func_2cd99:
	ld hl, PsychicClub_NPCs
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
	ld hl, PsychicClub_NPCInteractions
	call Func_328c
	scf
	ret

Func_2ce19:
	ld hl, PsychicClub_AfterDuelScripts
	ld a, [$d60e]
	call Func_344c
	scf
	ret

PsychicClub_AfterDuelScripts:
	db OW_MURRAY, $0b, $73, $4f
	db OW_ROBERT, $0b, $2a, $50
	db OW_DANIEL, $0b, $97, $50
	db OW_STEPHANIE, $0b, $42, $51
	db OW_GR_4, $0b, $0e, $52
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

RockClubEntrance_MapHeader:
	db MAP_ROCK_CLUB_ENTRANCE
	dba RockClubEntrance_MapScripts
	db MUSIC_OVERWORLD

RockClubEntrance_StepEvents:
	db 4, 8, $00, 1, 4, SOUTH, $03, $c4, $53
	db 5, 8, $00, 1, 4, SOUTH, $03, $c4, $53
	db 0, 3, $0d, 14, 6, WEST, $03, $c4, $53
	db 0, 4, $0d, 14, 7, WEST, $03, $c4, $53
	db 4, 0, $0e, 6, 13, NORTH, $03, $c4, $53
	db 5, 0, $0e, 7, 13, NORTH, $03, $c4, $53
	db $ff

RockClubEntrance_MapScripts:
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
	call RockClubEntrance_ShouldRonaldAppear
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
	ld hl, RockClubEntrance_StepEvents
	call Func_324d
	ret

Func_2d37d:
	call RockClubEntrance_ShouldRonaldAppear
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
RockClubEntrance_ShouldRonaldAppear:
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

RockClubLobby_MapHeader:
	db MAP_ROCK_CLUB_LOBBY
	dba RockClubLobby_MapScripts
	db MUSIC_OVERWORLD

RockClubLobby_StepEvents:
	db 15, 6, $0c, 1, 3, EAST, $03, $c4, $53
	db 15, 7, $0c, 1, 4, EAST, $03, $c4, $53
	db $ff

RockClubLobby_NPCs:
	db OW_LASS2_2, 5, 6, EAST, $00, $00
	db OW_WOMAN, 12, 10, NORTH, $00, $00
	db OW_IMAKUNI_BLACK, 1, 10, WEST, $7c, $55
	db OW_CHAP_1, 8, 9, WEST, $00, $00
	db OW_LAD_3, 10, 3, SOUTH, $00, $00
	db OW_CLERK_1, 2, 2, SOUTH, $00, $00
	db OW_CLERK_2, 4, 2, SOUTH, $00, $00
	db $ff

RockClubLobby_NPCInteractions:
	db OW_LASS2_2, $0b, $e0, $54
	db OW_WOMAN, $0b, $46, $55
	db OW_IMAKUNI_BLACK, $0f, $0c, $43
	db OW_CHAP_1, $0b, $8b, $55
	db OW_LAD_3, $0b, $c7, $55
	db $ff

RockClubLobby_OWInteractions:
	db 8, 2, $00, $00, $00, $00, $03, $11, $54
	db 9, 2, $00, $00, $00, $00, $03, $11, $54
	db 2, 4, $00, $00, $00, $00, $0f, $b9, $41
	db 4, 4, $00, $00, $00, $00, $0f, $d9, $42
	db 12, 2, $00, $00, $00, $00, $10, $08, $41
	db 13, 2, $00, $00, $00, $00, $10, $1e, $41
	db 14, 2, $00, $00, $00, $00, $10, $34, $41
	db $ff

RockClubLobby_MapScripts:
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
	ld hl,RockClubLobby_StepEvents
	call Func_324d
	ret

Func_2d4a5:
	ld hl, RockClubLobby_NPCs
	call Func_3205
	scf
	ccf
	ret

Func_2d4ae:
	ld hl, RockClubLobby_NPCInteractions
	call Func_328c
	jr nc, .asm_2d4bc
	ld hl, RockClubLobby_OWInteractions
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

RockClub_MapHeader:
	db MAP_ROCK_CLUB
	dba RockClub_MapScripts
	db MUSIC_CLUB_2

RockClub_StepEvents:
	db 6, 14, $0c, 4, 1, SOUTH, $03, $c4, $53
	db 7, 14, $0c, 5, 1, SOUTH, $03, $c4, $53
	db $ff

RockClub_NPCs:
	db OW_GENE, 7, 2, $02, $00, $00
	db OW_MATTHEW, 2, 3, $02, $00, $00
	db OW_RYAN, 9, 7, $01, $00, $00
	db OW_ANDREW, 3, 8, $01, $00, $00
	db OW_GR_1, 7, 3, $00, $f3, $58
	db $ff

RockClub_NPCInteractions:
	db OW_GENE, $0b, $54, $57
	db OW_MATTHEW, $0b, $ea, $57
	db OW_RYAN, $0b, $41, $58
	db OW_ANDREW, $0b, $9c, $58
	db $ff

RockClub_MapScripts:
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
	ld hl, RockClub_StepEvents
	call Func_324d
	ret

Func_2d66a:
	ld hl, RockClub_NPCs
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
	ld hl, RockClub_NPCInteractions
	call Func_328c
	scf
	ret

Func_2d6ae:
	ld hl, RockClub_AfterDuelScripts
	ld a, [$d60e]
	call Func_344c
	scf
	ret

RockClub_AfterDuelScripts:
	db OW_GENE, $0b, $c3, $57
	db OW_MATTHEW, $0b, $25, $58
	db OW_RYAN, $0b, $7e, $58
	db OW_ANDREW, $0b, $d7, $58
	db $ff
; 0x2d6ca

SECTION "Bank b@5930", ROMX[$5930], BANK[$b]

FightningClubEntrance_MapHeader:
	db MAP_FIGHTING_CLUB_ENTRANCE
	dba FightningClubEntrance_MapScripts
	db MUSIC_OVERWORLD

FightningClubEntrance_StepEvents:
	db 4, 8, $00, 3, 7, SOUTH, $03, $c4, $53
	db 5, 8, $00, 3, 7, SOUTH, $03, $c4, $53
	db 0, 3, $10, 14, 6, WEST, $03, $c4, $53
	db 0, 4, $10, 14, 7, WEST, $03, $c4, $53
	db 4, 0, $11, 5, 10, NORTH, $03, $c4, $53
	db 5, 0, $11, 6, 10, NORTH, $03, $c4, $53
	db $ff

FightningClubEntrance_MapScripts:
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
	call FightingClubEntrance_ShouldRonaldAppear
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
	ld hl, FightningClubEntrance_StepEvents
	call Func_324d
	ret

Func_2d9a6:
	call FightingClubEntrance_ShouldRonaldAppear
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
FightingClubEntrance_ShouldRonaldAppear:
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

FightningClubLobby_MapHeader:
	db MAP_FIGHTING_CLUB_LOBBY
	dba FightningClubLobby_MapScripts
	db MUSIC_OVERWORLD

FightningClubLobby_StepEvents:
	db 15, 6, $0F, 1, 3, EAST, $03, $C4, $53
	db 15, 7, $0F, 1, 4, EAST, $03, $C4, $53
	db $ff

FightningClubLobby_NPCs:
	db OW_PAPPY_2, 1, 5, $02, $00, $00
	db OW_SPECS_3, 4, 9, $01, $00, $00
	db OW_LAD4, 7, 9, $03, $00, $00
	db OW_GIRL_4, 6, 8, $02, $00, $00
	db OW_CLERK_1, 2, 2, $02, $00, $00
	db OW_CLERK_2, 4, 2, $02, $00, $00
	db OW_MICHAEL, 11, 6, $01, $97, $5b
	db $ff

FightningClubLobby_NPCInteractions:
	db OW_PAPPY_2, $0b, $ac, $5b
	db OW_SPECS_3, $0b, $17, $5c
	db OW_LAD4, $0b, $48, $5c
	db OW_GIRL_4, $0b, $79, $5c
	db OW_MICHAEL, $0b, $0e, $5b
	db $ff

FightningClubLobby_OWInteractions:
	db 8, 2, $00, $00, $00, $00, $03, $11, $54
	db 9, 2, $00, $00, $00, $00, $03, $11, $54
	db 2, 4, $00, $00, $00, $00, $0F, $B9, $41
	db 4, 4, $00, $00, $00, $00, $0F, $D9, $42
	db 12, 2, $00, $00, $00, $00, $10, $4A, $41
	db 13, 2, $00, $00, $00, $00, $10, $60, $41
	db 14, 2, $00, $00, $00, $00, $10, $76, $41
	db $ff

FightningClubLobby_MapScripts:
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
	ld hl, FightningClubLobby_StepEvents
	call Func_324d
	ret

Func_2dae5:
	ld hl, FightningClubLobby_NPCs
	call Func_3205
	scf
	ccf
	ret

Func_2daee:
	ld hl, FightningClubLobby_NPCInteractions
	call Func_328c
	jr nc, .asm_2dafc
	ld hl, FightningClubLobby_OWInteractions
	call Func_32bf
.asm_2dafc
	scf
	ret

Func_2dafe:
	ld hl, FightningClubLobby_AfterDuelScripts
	ld a, [$d60e]
	call Func_344c
	scf
	ret

FightningClubLobby_AfterDuelScripts:
	db OW_MICHAEL, $0B, $7B, $5B
	db $ff
; 0x2db5b

SECTION "Bank b@5c9f", ROMX[$5c9f], BANK[$b]

FightingClub_MapHeader:
	db MAP_FIGHTING_CLUB
	dba FightingClub_MapScripts
	db MUSIC_CLUB_3

FightingClub_StepEvents:
	db 5, 11, $0f, 4, 1, SOUTH, $03, $c4, $53
	db 6, 11, $0f, 5, 1, SOUTH, $03, $c4, $53
	db $ff

FightingClub_NPCs:
	db OW_MITCH, 5, 2, SOUTH, $e4, $5d
	db OW_MICHAEL, 7, 7, SOUTH, $9c, $5f
	db OW_CHRIS, 2, 5, SOUTH, $9c, $5f
	db OW_JESSICA, 9, 4, SOUTH, $9c, $5f
	db OW_GR_1, 6, 2, SOUTH, $23, $60
	db $ff

FightingClub_NPCInteractions:
	db OW_MITCH, $0b, $62, $5d
	db OW_MICHAEL, $0b, $f1, $5d
	db OW_CHRIS, $0b, $ad, $5e
	db OW_JESSICA, $0b, $3a, $5f
	db OW_GR_1, $0b, $b1, $5f
	db $ff

FightingClub_MapScripts:
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
	ld hl, FightingClub_StepEvents
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
	ld hl, FightingClub_NPCs
	call Func_3205
	scf
	ccf
	ret

Func_2dd3a:
	ld hl, FightingClub_NPCInteractions
	call Func_328c
	scf
	ret

Func_2dd42:
	ld hl, FightingClub_AfterDuelScripts
	ld a, [$d60e]
	call Func_344c
	scf
	ret

FightingClub_AfterDuelScripts:
	db OW_MITCH, $0b, $c8, $5d
	db OW_MICHAEL, $0b, $75, $5e
	db OW_CHRIS, $0b, $1e, $5f
	db OW_JESSICA, $0b, $80, $5f
	db OW_GR_1, $0b, $08, $60
	db $ff
; 0x2dd62

SECTION "Bank b@606d", ROMX[$606d], BANK[$b]

GrassClubEntrance_MapHeader:
	db MAP_GRASS_CLUB_ENTRANCE
	dba GrassClubEntrance_MapScripts
	db MUSIC_OVERWORLD

GrassClubEntrance_StepEvents:
	db 4, 8, $00, 8, 4, SOUTH, $03, $c4, $53
	db 5, 8, $00, 8, 4, SOUTH, $03, $c4, $53
	db 0, 3, $13, 14, 6, WEST, $03, $c4, $53
	db 0, 4, $13, 14, 7, WEST, $03, $c4, $53
	db 4, 0, $14, 6, 13, NORTH, $03, $c4, $53
	db 5, 0, $14, 7, 13, NORTH, $03, $c4, $53
	db $ff

GrassClubEntrance_MapScripts:
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
	call GrassClubEntrance_ShouldRonaldAppear
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
	ld hl, GrassClubEntrance_StepEvents
	call Func_324d
	ret

Func_2e0e3:
	call GrassClubEntrance_ShouldRonaldAppear
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
GrassClubEntrance_ShouldRonaldAppear:
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

GrassClub_MapHeader:
	db MAP_GRASS_CLUB
	dba GrassClub_MapScripts
	db MUSIC_CLUB_1

GrassClub_StepEvents:
	db 6, 14, $12, 4, 1, SOUTH, $03, $c4, $53
	db 7, 14, $12, 5, 1, SOUTH, $03, $c4, $53
	db $ff

GrassClub_NPCs:
	db OW_NIKKI, 6, 2, SOUTH, $f6, $63
	db OW_BRITTANY, 10, 4, NORTH, $f6, $63
	db OW_KRISTIN, 2, 7, EAST, $f6, $63
	db OW_HEATHER, 7, 9, SOUTH, $f6, $63
	db OW_GR_2, 7, 8, SOUTH, $98, $64
	db $ff

GrassClub_NPCInteractions:
	db OW_NIKKI, $0b, $26, $62
	db OW_BRITTANY, $0b, $8c, $62
	db OW_KRISTIN, $0b, $32, $63
	db OW_HEATHER, $0b, $94, $63
	db OW_GR_2, $0b, $0b, $64
	db $ff

GrassClub_MapScripts:
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
	ld hl, GrassClub_StepEvents
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
	ld hl, GrassClub_NPCs
	call Func_3205
	scf
	ccf
	ret

Func_2e1fe:
	ld hl, GrassClub_NPCInteractions
	call Func_328c
	scf
	ret

Func_2e206:
	ld hl, GrassClub_AfterDuelScripts
	ld a, [$d60e]
	call Func_344c
	scf
	ret

GrassClub_AfterDuelScripts:
	db OW_NIKKI, $0b, $6e, $62
	db OW_BRITTANY, $0b, $f6, $62
	db OW_KRISTIN, $0b, $78, $63
	db OW_HEATHER, $0b, $da, $63
	db OW_GR_2, $0b, $49, $64
	db $ff
; 0x2e226

SECTION "Bank b@64b7", ROMX[$64b7], BANK[$b]

ScienceClubEntrance_MapHeader:
	db MAP_SCIENCE_CLUB_ENTRANCE
	dba ScienceClubEntrance_MapScripts
	db MUSIC_OVERWORLD

ScienceClubEntrance_StepEvents:
	db 4, 8, $00, 8, 2, SOUTH, $03, $c4, $53
	db 5, 8, $00, 8, 2, SOUTH, $03, $c4, $53
	db 0, 3, $16, 14, 6, WEST, $03, $c4, $53
	db 0, 4, $16, 14, 7, WEST, $03, $c4, $53
	db 4, 0, $17, 6, 14, NORTH, $03, $c4, $53
	db 5, 0, $17, 7, 14, NORTH, $03, $c4, $53
	db $ff

ScienceClubEntrance_NPCs:
	db OW_JOSEPH, 6, 1, SOUTH, $2a, $66
	db $ff

ScienceClubEntrance_NPCInteractions:
	db OW_JOSEPH, $0b, $d0, $65
	db $ff

ScienceClubEntrance_MapScripts:
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
	call ScienceClubEntrance_ShouldRonaldAppear
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
	ld hl, ScienceClubEntrance_StepEvents
	call Func_324d
	ret

Func_2e53f:
	ld hl, ScienceClubEntrance_NPCs
	call Func_3205
	scf
	ccf
	ret

Func_2e548:
	call ScienceClubEntrance_ShouldRonaldAppear
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
	ld hl, ScienceClubEntrance_NPCInteractions
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
ScienceClubEntrance_ShouldRonaldAppear:
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

ScienceClubLobby_MapHeader:
	db MAP_SCIENCE_CLUB_LOBBY
	dba ScienceClubLobby_MapScripts
	db MUSIC_OVERWORLD

ScienceClubLobby_StepEvents:
	db 15, 6, $15, 1, 3, EAST, $03, $c4, $53
	db 15, 7, $15, 1, 4, EAST, $03, $c4, $53
	db $ff

ScienceClubLobby_NPCs:
	db OW_DAVID, 9, 6, EAST, $0d, $68
	db OW_ERIK, 4, 9, EAST, $0d, $68
	db OW_IMAKUNI_BLACK, 1, 10, WEST, $22, $68
	db OW_MAN_2, 3, 9, WEST, $d1, $68
	db OW_SPECS_4, 13, 4, SOUTH, $d1, $68
	db OW_TECH_6, 7, 9, WEST, $d1, $68
	db OW_CLERK_1, 2, 2, SOUTH, $00, $00
	db OW_CLERK_2, 4, 2, SOUTH, $00, $00
	db $ff

ScienceClubLobby_NPCInteractions:
	db OW_DAVID, $0b, $6e, $67
	db OW_ERIK, $0b, $e3, $67
	db OW_IMAKUNI_BLACK, $0f, $0c, $43
	db OW_MAN_2, $0b, $31, $68
	db OW_SPECS_4, $0b, $62, $68
	db OW_TECH_6, $0b, $a0, $68
	db $ff

ScienceClubLobby_OWInteractions:
	db 8, 2, $00, $00, $00, $00, $03, $11, $54
	db 9, 2, $00, $00, $00, $00, $03, $11, $54
	db 2, 4, $00, $00, $00, $00, $0f, $b9, $41
	db 4, 4, $00, $00, $00, $00, $0f, $d9, $42
	db 12, 2, $00, $00, $00, $00, $10, $ce, $41
	db 13, 2, $00, $00, $00, $00, $10, $e4, $41
	db 14, 2, $00, $00, $00, $00, $10, $fa, $41
	db $ff

ScienceClubLobby_MapScripts:
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
	ld hl, ScienceClubLobby_StepEvents
	call Func_324d
	ret

Func_2e725:
	ld hl, ScienceClubLobby_NPCs
	call Func_3205
	scf
	ccf
	ret

Func_2e72e:
	ld hl, ScienceClubLobby_NPCInteractions
	call Func_328c
	jr nc, .asm_2e73c
	ld hl, ScienceClubLobby_OWInteractions
	call Func_32bf
.asm_2e73c
	scf
	ret

Func_2e73e:
	ld hl, ScienceClubLobby_AfterDuelScripts
	ld a, [$d60e]
	call Func_344c
	scf
	ret

ScienceClubLobby_AfterDuelScripts:
	db OW_DAVID, $0b, $c7, $67
	db OW_IMAKUNI_BLACK, $0f, $ca, $43
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

ScienceClub_MapHeader:
	db MAP_SCIENCE_CLUB
	dba ScienceClub_MapScripts
	db MUSIC_CLUB_3

ScienceClub_StepEvents:
	db 6, 15, $15, 4, 1, SOUTH, $03, $c4, $53
	db 7, 15, $15, 5, 1, SOUTH, $03, $c4, $53
	db $ff

ScienceClub_NPCs:
	db OW_RICK, 2, 2, NORTH, $87, $6a
	db OW_DAVID, 10, 2, NORTH, $07, $6c
	db OW_JOSEPH, 6, 5, WEST, $07, $6c
	db OW_ERIK, 3, 8, EAST, $07, $6c
	db OW_GR_2, 6, 8, SOUTH, $a9, $6c
	db $ff

ScienceClub_NPCInteractions:
	db OW_RICK, $0b, $c7, $69
	db OW_DAVID, $0b, $94, $6a
	db OW_JOSEPH, $0b, $ef, $6a
	db OW_ERIK, $0b, $a5, $6b
	db OW_GR_2, $0b, $1c, $6c
	db $ff

ScienceClub_MapScripts:
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
	ld hl, ScienceClub_StepEvents
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
	ld hl, ScienceClub_NPCs
	call Func_3205
	scf
	ccf
	ret

Func_2e99f:
	ld hl, ScienceClub_NPCInteractions
	call Func_328c
	scf
	ret

Func_2e9a7:
	ld hl, ScienceClub_AfterDuelScripts
	ld a, [$d60e]
	call Func_344c
	scf
	ret

ScienceClub_AfterDuelScripts:
	db OW_RICK, $0b, $4b, $6a
	db OW_DAVID, $0b, $d1, $6a
	db OW_JOSEPH, $0b, $6d, $6b
	db OW_ERIK, $0b, $eb, $6b
	db OW_GR_2, $0b, $5a, $6c
	db $ff
; 0x2e9c7

SECTION "Bank b@6cc8", ROMX[$6cc8], BANK[$b]

WaterClubEntrance_MapHeader:
	db MAP_WATER_CLUB_ENTRANCE
	dba WaterClubEntrance_MapScripts
	db MUSIC_OVERWORLD

WaterClubEntrance_StepEvents:
	db 4, 8, $00, 7, 6, SOUTH, $03, $c4, $53
	db 5, 8, $00, 7, 6, SOUTH, $03, $c4, $53
	db 0, 3, $19, 14, 6, WEST, $03, $c4, $53
	db 0, 4, $19, 14, 7, WEST, $03, $c4, $53
	db 4, 0, $1a, 6, 14, NORTH, $03, $c4, $53
	db 5, 0, $1a, 7, 14, NORTH, $03, $c4, $53
	db $ff

WaterClubEntrance_MapScripts:
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
	call WaterClubEntrance_ShouldRonaldAppear
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
	ld hl, WaterClubEntrance_StepEvents
	call Func_324d
	ret

Func_2ed3e:
	xor a
	call Func_33f2
	; Event Script @ 0x2ed42
	db $64, $12, $00
	call WaterClubEntrance_ShouldRonaldAppear
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
WaterClubEntrance_ShouldRonaldAppear:
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

WaterClubLobby_MapHeader:
	db MAP_WATER_CLUB_LOBBY
	dba WaterClubLobby_MapScripts
	db MUSIC_OVERWORLD

WaterClubLobby_StepEvents:
	db 15, 6, $18, 1, 3, EAST, $03, $c4, $53
	db 15, 7, $18, 1, 4, EAST, $03, $c4, $53
	db $ff

WaterClubLobby_NPCs:
	db OW_JOSHUA, 8, 6, WEST, $5f, $6f
	db OW_LASS2_4, 11, 1, WEST, $00, $00
	db OW_IMAKUNI_BLACK, 1, 10, WEST, $9f, $6f
	db OW_PAPPY_3, 12, 11, EAST, $00, $00
	db OW_LASS1_2, 4, 9, SOUTH, $00, $00
	db OW_CLERK_1, 2, 2, SOUTH, $00, $00
	db OW_CLERK_2, 4, 2, SOUTH, $00, $00
	db $ff

WaterClubLobby_NPCInteractions:
	db OW_JOSHUA, $0b, $ea, $6e
	db OW_LASS2_4, $0b, $74, $6f
	db OW_IMAKUNI_BLACK, $0f, $0c, $43
	db OW_PAPPY_3, $0b, $ae, $6f
	db OW_LASS1_2, $0b, $e1, $6f
	db $ff

WaterClubLobby_OWInteractions:
	db 8, 2, $00, $00, $00, $00, $03, $11, $54
	db 9, 2, $00, $00, $00, $00, $03, $11, $54
	db 2, 4, $00, $00, $00, $00, $0f, $b9, $41
	db 4, 4, $00, $00, $00, $00, $0f, $d9, $42
	db 12, 2, $00, $00, $00, $00, $10, $10, $42
	db 13, 2, $00, $00, $00, $00, $10, $26, $42
	db 14, 2, $00, $00, $00, $00, $10, $3c, $42
	db $ff

WaterClubLobby_MapScripts:
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
	ld hl, WaterClubLobby_StepEvents
	call Func_324d
	ret

Func_2eea1:
	ld hl, WaterClubLobby_NPCs
	call Func_3205
	scf
	ccf
	ret

Func_2eeaa:
	ld hl, WaterClubLobby_NPCInteractions
	call Func_328c
	jr nc, .asm_2eeb8
	ld hl, WaterClubLobby_OWInteractions
	call Func_32bf
.asm_2eeb8
	scf
	ret

Func_2eeba:
	ld hl, WaterClubLobby_AfterDuelScripts
	ld a, [$d60e]
	call Func_344c
	scf
	ret

WaterClubLobby_AfterDuelScripts:
	db OW_JOSHUA, $0b, $43, $6f
	db OW_IMAKUNI_BLACK, $0f, $ca, $43
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

WaterClub_MapHeader:
	db MAP_WATER_CLUB
	dba WaterClub_MapScripts
	db MUSIC_CLUB_1

WaterClub_StepEvents:
	db 6, 15, $18, 4, 1, SOUTH, $03, $c4, $53
	db 7, 15, $18, 5, 1, SOUTH, $03, $c4, $53
	db $ff

WaterClub_NPCs:
	db OW_AMY_LOUNGE, 11, 2, SOUTH, $6d, $73
	db OW_JOSHUA, 10, 4, SOUTH, $6d, $73
	db OW_SARA, 4, 9, EAST, $78, $74
	db OW_AMANDA, 11, 10, WEST, $78, $74
	db OW_AMY, 4, 6, SOUTH, $ed, $71
	db OW_GR_3, 8, 6, SOUTH, $f2, $74
	db $ff

WaterClub_NPCInteractions:
	db OW_AMY_LOUNGE, $0b, $fa, $71
	db OW_JOSHUA, $0b, $cf, $72
	db OW_SARA, $0b, $82, $73
	db OW_AMANDA, $0b, $f1, $73
	db OW_AMY, $0b, $d2, $71
	db OW_GR_3, $0b, $85, $74
	db $ff

WaterClub_OWInteractions:
	db 12, 3, $00, $00, $00, $00, $0b, $fa, $71
	db $ff

WaterClub_MapScripts:
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
	ld hl, WaterClub_StepEvents
	call Func_324d
	ret

Func_2f09c:
	ld hl, WaterClub_NPCs
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
	ld hl, WaterClub_NPCInteractions
	call Func_328c
	jr nc, .asm_2f105
	ld hl, WaterClub_OWInteractions
	call Func_32bf
.asm_2f105
	scf
	ret

Func_2f107:
	ld hl, WaterClub_AfterDuelScripts
	ld a, [$d60e]
	call Func_344c
	scf
	ret

WaterClub_AfterDuelScripts:
	db OW_AMY_LOUNGE, $0b, $8a, $72
	db OW_JOSHUA, $0b, $35, $73
	db OW_SARA, $0b, $d5, $73
	db OW_AMANDA, $0b, $4f, $74
	db OW_GR_3, $0b, $d9, $74
	db $ff
; 0x2f127

SECTION "Bank b@74ff", ROMX[$74ff], BANK[$b]

FireClubEntrance_MapHeader:
	db MAP_FIRE_CLUB_ENTRANCE
	dba FireClubEntrance_MapScripts
	db MUSIC_OVERWORLD

FireClubEntrance_StepEvents:
	db 4, 8, $00, 7, 1, SOUTH, $03, $c4, $53
	db 5, 8, $00, 7, 1, SOUTH, $03, $c4, $53
	db 0, 3, $1c, 14, 6, WEST, $03, $c4, $53
	db 0, 4, $1c, 14, 7, WEST, $03, $c4, $53
	db 4, 0, $1d, 6, 14, NORTH, $03, $c4, $53
	db 5, 0, $1d, 7, 14, NORTH, $03, $c4, $53
	db $ff

FireClubEntrance_MapScripts:
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
	call FireClubEntrance_ShouldRonaldAppear
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
	ld hl, FireClubEntrance_StepEvents
	call Func_324d
	ret

Func_2f575:
	xor a
	call Func_33f2
	; Event Script @ 0x2f579
	db $64, $12, $00
	call FireClubEntrance_ShouldRonaldAppear
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
FireClubEntrance_ShouldRonaldAppear:
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

FireClubLobby_MapHeader:
	db MAP_FIRE_CLUB_LOBBY
	dba FireClubLobby_MapScripts
	db MUSIC_OVERWORLD

FireClubLobby_StepEvents:
	db 15, 6, $1b, 1, 3, EAST, $03, $c4, $53
	db 15, 7, $1b, 1, 4, EAST, $03, $c4, $53
	db $ff

FireClubLobby_NPCs:
	db OW_HOOD_3, 8, 4, NORTH, $00, $00
	db OW_IMAKUNI_BLACK, 1, 10, WEST, $6f, $77
	db OW_MANIA_4, 10, 9, NORTH, $00, $00
	db OW_GAL_2, 5, 8, SOUTH, $00, $00
	db OW_CLERK_1, 2, 2, SOUTH, $00, $00
	db OW_CLERK_2, 4, 2, SOUTH, $00, $00
	db $ff

FireClubLobby_NPCInteractions:
	db OW_HOOD_3, $0b, $09, $77
	db OW_IMAKUNI_BLACK, $0f, $0c, $43
	db OW_MANIA_4, $0b, $7e, $77
	db OW_GAL_2, $0b, $a4, $77
	db $ff

FireClubLobby_OWInteractions:
	db 8, 2, $00, $00, $00, $00, $03, $11, $54
	db 9, 2, $00, $00, $00, $00, $03, $11, $54
	db 2, 4, $00, $00, $00, $00, $0f, $b9, $41
	db 4, 4, $00, $00, $00, $00, $0f, $d9, $42
	db 12, 2, $00, $00, $00, $00, $10, $52, $42
	db 13, 2, $00, $00, $00, $00, $10, $68, $42
	db 14, 2, $00, $00, $00, $00, $10, $7e, $42
	db $ff

FireClubLobby_MapScripts:
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
	ld hl, FireClubLobby_StepEvents
	call Func_324d
	ret

Func_2f6ce:
	ld hl, FireClubLobby_NPCs
	call Func_3205
	scf
	ccf
	ret

Func_2f6d7:
	ld hl, FireClubLobby_NPCInteractions
	call Func_328c
	jr nc, .asm_2f6e5
	ld hl, FireClubLobby_OWInteractions
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

FireClub_MapHeader:
	db MAP_FIRE_CLUB
	dba FireClub_MapScripts
	db MUSIC_CLUB_3

FireClub_StepEvents:
	db 6, 15, $1b, 4, 1, SOUTH, $03, $c4, $53
	db 7, 15, $1b, 5, 1, SOUTH, $03, $c4, $53
	db $ff

FireClub_NPCs:
	db OW_KEN, 7, 2, SOUTH, $00, $00
	db OW_JOHN, 6, 9, SOUTH, $00, $00
	db OW_ADAM, 5, 7, SOUTH, $00, $00
	db OW_JONATHAN, 10, 5, SOUTH, $00, $00
	db OW_GR_3, 7, 5, SOUTH, $29, $7c
	db $ff

FireClub_NPCInteractions:
	db OW_KEN, $0b, $26, $79
	db OW_JOHN, $0b, $25, $7a
	db OW_ADAM, $0b, $a1, $7a
	db OW_JONATHAN, $0b, $4e, $7b
	db OW_GR_3, $0b, $d3, $7b
	db $ff

FireClub_OWInteractions:
	db 7, 12, $00, $00, $00, $00, $0b, $ad, $7c
	db 6, 12, $00, $00, $00, $00, $0b, $b7, $7c
	db 5, 12, $00, $00, $00, $00, $0b, $c1, $7c
	db 8, 12, $00, $00, $00, $00, $0b, $cb, $7c
	db $ff

FireClub_MapScripts:
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
	ld hl, FireClub_StepEvents
	call Func_324d
	ret

Func_2f865:
	ld hl, FireClub_NPCs
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
	ld hl, FireClub_NPCInteractions
	call Func_328c
	jr nc, .asm_2f8d6
	ld hl, FireClub_OWInteractions
	call Func_32bf
.asm_2f8d6
	scf
	ret

Func_2f8d8:
	ld hl, FireClub_AfterDuelScripts
	ld a, [$d60e]
	call Func_344c
	scf
	ret

FireClub_AfterDuelScripts:
	db OW_KEN, $0b, $ed, $79
	db OW_JOHN, $0b, $85, $7a
	db OW_ADAM, $0b, $32, $7b
	db OW_JONATHAN, $0b, $b7, $7b
	db OW_GR_3, $0b, $0e, $7c
	db $ff
; 0x2f8f8

SECTION "Bank b@7cd5", ROMX[$7cd5], BANK[$b]

PokemonDomeEntrance_MapHeader:
	db MAP_POKEMON_DOME_ENTRANCE
	dba PokemonDomeEntrance_MapScripts
	db MUSIC_OVERWORLD

PokemonDomeEntrance_StepEvents:
	db 7, 8, $00, 4, 4, SOUTH, $03, $c4, $53
	db 8, 8, $00, 4, 4, SOUTH, $03, $c4, $53
	db 11, 0, $24, 7, 14, NORTH, $03, $c4, $53
	db 12, 0, $24, 8, 14, NORTH, $03, $c4, $53
	db $ff

PokemonDomeEntrance_NPCs:
	db OW_BUTCH_2, 8, 3, NORTH, $1d, $7e
	db $ff

PokemonDomeEntrance_NPCInteractions:
	db OW_BUTCH_2, $0b, $a3, $7d
	db $ff

PokemonDomeEntrance_OWInteractions:
	db 4, 2, $00, $00, $00, $00, $03, $11, $54
	db 5, 2, $00, $00, $00, $00, $03, $11, $54
	db 9, 1, $00, $00, $00, $00, $0b, $2a, $7e
	db 10, 1, $00, $00, $00, $00, $0b, $2a, $7e
	db 1, 2, $00, $00, $00, $00, $10, $5a, $43
	db 2, 2, $00, $00, $00, $00, $10, $70, $43
	db 3, 2, $00, $00, $00, $00, $10, $86, $43
	db 1, 5, $00, $00, $00, $00, $10, $9c, $43
	db 2, 5, $00, $00, $00, $00, $10, $b2, $43
	db 3, 5, $00, $00, $00, $00, $10, $c8, $43
	db $ff

PokemonDomeEntrance_MapScripts:
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
	ld hl, PokemonDomeEntrance_StepEvents
	call Func_324d
	ret

Func_2fd8a:
	ld hl, PokemonDomeEntrance_NPCs
	call Func_3205
	scf
	ccf
	ret

Func_2fd93:
	ld hl, PokemonDomeEntrance_NPCInteractions
	call Func_328c
	jr nc, .asm_2fda1
	ld hl, PokemonDomeEntrance_OWInteractions
	call Func_32bf
.asm_2fda1
	scf
	ret
; 0x2fda3

SECTION "Bank b@7e45", ROMX[$7e45], BANK[$b]

OverheadIslands_MapHeader:
	db MAP_OVERHEAD_ISLANDS
	dba OverheadIslands_MapScripts
	db MUSIC_GRBLIMP

OverheadIslands_MapScripts:
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
