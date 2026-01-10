; returns carry if no save data
Func_e883:
	ldh a, [hBankSRAM]
	push af
	ld a, BANK("SRAM2")
	call BankswitchSRAM
	call EnableSRAM
	ld a, [sBackup_baa3]
	ld b, a
	pop af
	call BankswitchSRAM
	call DisableSRAM
	ld a, b
	bit 0, a
	jr z, .set_carry
; no carry
	scf
	ccf
	ret
.set_carry
	scf
	ret

Func_e8a3:
	call EnableSRAM
	ld a, [s0baa3]
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
	ld a, BANK("SRAM2")
	ld [wSaveDataSRAMBank], a
	ldh a, [hBankSRAM]
	push af
	ld a, BANK("SRAM2")
	call BankswitchSRAM
	ld a, [sBackupGeneralSaveDataHeader]
	ld b, a
	pop af
	call BankswitchSRAM
	call DisableSRAM
	ld a, b
	cp $16
	jr nz, .asm_e918
	ld a, LOW(WRAMToSRAMMapper_GeneralSave)
	ld [wWRAMToSRAMMapperPointer], a
	ld a, HIGH(WRAMToSRAMMapper_GeneralSave)
	ld [wWRAMToSRAMMapperPointer + 1], a
	ld a, LOW(sBackupGeneralSaveDataMain)
	ld [wSaveDataSRAMOffset], a
	ld a, HIGH(sBackupGeneralSaveDataMain)
	ld [wSaveDataSRAMOffset + 1], a
	call Func_ea19
	call Func_ed7c
	ld a, [wSaveDataChecksum1]
	ld d, a
	ld a, [wSaveDataChecksum0]
	ld e, a
	ldh a, [hBankSRAM]
	push af
	ld a, BANK("SRAM2")
	call BankswitchSRAM
	ld a, [sBackup_baa0]
	ld b, a
	ld a, [sBackup_baa1]
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
	xor a ; BANK("SRAM0")
	ld [wSaveDataSRAMBank], a
	ldh a, [hBankSRAM]
	push af
	xor a ; BANK("SRAM0")
	call BankswitchSRAM
	ld a, [sGeneralSaveDataHeader]
	ld b, a
	pop af
	call BankswitchSRAM
	call DisableSRAM
	ld a, b
	cp $16
	jr nz, .asm_e978
	ld a, LOW(WRAMToSRAMMapper_GeneralSave)
	ld [wWRAMToSRAMMapperPointer], a
	ld a, HIGH(WRAMToSRAMMapper_GeneralSave)
	ld [wWRAMToSRAMMapperPointer + 1], a
	ld a, LOW(sGeneralSaveDataMain)
	ld [wSaveDataSRAMOffset], a
	ld a, HIGH(sGeneralSaveDataMain)
	ld [wSaveDataSRAMOffset + 1], a
	call Func_ea19
	call Func_ed7c
	ld a, [wSaveDataChecksum1]
	ld d, a
	ld a, [wSaveDataChecksum0]
	ld e, a
	ldh a, [hBankSRAM]
	push af
	xor a
	call BankswitchSRAM
	ld a, [s0baa0]
	ld b, a
	ld a, [s0baa1]
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
	ld hl, sBackup_baa3
	xor a
	ld [hl], a
	ld [sBackupGeneralSaveDataHeader], a
	pop af
	call BankswitchSRAM
	call DisableSRAM
	call EnableSRAM
	ld hl, s0baa3
	xor a
	ld [hl], a
	ld [sGeneralSaveDataHeader], a
	call DisableSRAM
	farcall ClearSavedDuel
	call DisableSRAM
	ret

Func_e9a7:
	call EnableSRAM
	ld hl, s0baa3
	xor a
	ld [hl], a
	call DisableSRAM
	farcall ClearSavedDuel
	ret

Func_e9b7:
	ld a, 2
	call BulkCopySRAM
	ldh a, [hBankSRAM]
	push af
	ld a, BANK("SRAM2")
	call BankswitchSRAM
	ld a, $16
	ld [sBackupGeneralSaveDataHeader], a
	ld hl, sBackup_baa3
	set 0, [hl]
	pop af
	call BankswitchSRAM
	call DisableSRAM
	ret

; sram copy
; a = 0: sCardAndDeckSaveData onwards, from SRAM2 to SRAM0
; a = 1: sCardAndDeckSaveData onwards, from SRAM0 to SRAM2
; a = 2: all, from SRAM0 to SRAM2
BulkCopySRAM:
	cp 1
	jr z, .from_sram0_to_sram2
	jr nc, .all_from_sram0_to_sram2
; from sram2 to sram0
	ld e, BANK("SRAM2")
	ld d, BANK("SRAM0")
	jr .card_deck_onwards
.from_sram0_to_sram2
	ld e, BANK("SRAM0")
	ld d, BANK("SRAM2")
	jr .card_deck_onwards
.all_from_sram0_to_sram2
	ld e, BANK("SRAM0")
	ld d, BANK("SRAM2")
	ldh a, [hBankSRAM]
	push af
	ld bc, SIZEOF(SRAM)
	ld hl, STARTOF(SRAM)
	jr .loop_copy
.card_deck_onwards
	ldh a, [hBankSRAM]
	push af
	ld bc, SIZEOF(SRAM) - (sCardAndDeckSaveData - STARTOF(SRAM))
	ld hl, sCardAndDeckSaveData
.loop_copy
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
	jr nz, .loop_copy
	pop af
	call BankswitchSRAM
	call DisableSRAM
	ret

Func_ea19:
	ldh a, [hBankSRAM]
	push af
	ld a, [wSaveDataSRAMBank]
	call BankswitchSRAM
	ld a, [s0baa2]
	ld [wd673], a
	pop af
	call BankswitchSRAM
	call DisableSRAM
	ret

Func_ea30::
	ld a, OWMODE_SAVE_PRELOAD
	call ExecuteOWModeScript
	farcall Func_10f32
	xor a ; BANK("SRAM0")
	ld [wSaveDataSRAMBank], a
.asm_ea3d
	ld a, LOW(WRAMToSRAMMapper_GeneralSave)
	ld [wWRAMToSRAMMapperPointer], a
	ld a, HIGH(WRAMToSRAMMapper_GeneralSave)
	ld [wWRAMToSRAMMapperPointer + 1], a
	ld a, LOW(sGeneralSaveDataMain)
	ld [wSaveDataSRAMOffset], a
	ld a, HIGH(sGeneralSaveDataMain)
	ld [wSaveDataSRAMOffset + 1], a
	call Func_ec94
	call EnableSRAM
	ld a, $16
	ld [sGeneralSaveDataHeader], a
	ld a, [wSaveDataChecksum1]
	ld [s0baa0], a
	ld a, [wSaveDataChecksum0]
	ld [s0baa1], a
	ld a, [wd673]
	ld [s0baa2], a
	ld hl, s0baa3
	set 0, [hl]
	call DisableSRAM
	call Func_ea19
	call Func_ed7c
	ld a, [wSaveDataChecksum1]
	ld d, a
	ld a, [wSaveDataChecksum0]
	ld e, a
	call EnableSRAM
	ld a, [s0baa0]
	ld b, a
	ld a, [s0baa1]
	ld c, a
	call DisableSRAM
	ld a, b
	cp d
	jr nz, .error
	ld a, c
	cp e
	jr nz, .error
	ld a, 1
	call BulkCopySRAM
	ld a, OWMODE_SAVE_POSTLOAD
	call ExecuteOWModeScript
	ret

.error
	debug_nop
	jr .asm_ea3d

Func_eaa8:
	farcall Func_10f32
	xor a ; BANK("SRAM0")
	ld [wSaveDataSRAMBank], a
	ld a, LOW(WRAMToSRAMMapper_GeneralSave)
	ld [wWRAMToSRAMMapperPointer], a
	ld a, HIGH(WRAMToSRAMMapper_GeneralSave)
	ld [wWRAMToSRAMMapperPointer + 1], a
	ld a, LOW(sGeneralSaveDataMain)
	ld [wSaveDataSRAMOffset], a
	ld a, HIGH(sGeneralSaveDataMain)
	ld [wSaveDataSRAMOffset + 1], a
	call Func_ec94
	call EnableSRAM
	ld a, $16
	ld [sGeneralSaveDataHeader], a
	ld a, [wSaveDataChecksum1]
	ld [s0baa0], a
	ld a, [wSaveDataChecksum0]
	ld [s0baa1], a
	ld a, [wd673]
	ld [s0baa2], a
	ld hl, s0baa3
	set 1, [hl]
	call DisableSRAM
	ret

Func_eaea:
	call Func_eaf6
	xor a
	call BulkCopySRAM
	farcall Func_10f78
	ret

Func_eaf6:
	ld a, BANK("SRAM2")
	ld [wSaveDataSRAMBank], a
	ld a, LOW(WRAMToSRAMMapper_GeneralSave)
	ld [wWRAMToSRAMMapperPointer], a
	ld a, HIGH(WRAMToSRAMMapper_GeneralSave)
	ld [wWRAMToSRAMMapperPointer + 1], a
	ld a, LOW(sBackupGeneralSaveDataMain)
	ld [wSaveDataSRAMOffset], a
	ld a, HIGH(sBackupGeneralSaveDataMain)
	ld [wSaveDataSRAMOffset + 1], a
	call Func_ea19
	call Func_ed0b
	ret

Func_eb16:
	xor a ; BANK("SRAM0")
	ld [wSaveDataSRAMBank], a
	ld a, LOW(WRAMToSRAMMapper_GeneralSave)
	ld [wWRAMToSRAMMapperPointer], a
	ld a, HIGH(WRAMToSRAMMapper_GeneralSave)
	ld [wWRAMToSRAMMapperPointer + 1], a
	ld a, LOW(sGeneralSaveDataMain)
	ld [wSaveDataSRAMOffset], a
	ld a, HIGH(sGeneralSaveDataMain)
	ld [wSaveDataSRAMOffset + 1], a
	call Func_ea19
	call Func_ed0b
	farcall Func_10f78
	ret

Func_eb39:
	ld hl, wddf9
	xor a
	ld c, $14
.loop_init
	ld [hli], a
	dec c
	jr nz, .loop_init

; init verbosely from wde0d to wde17
	ld hl, wde0d
	xor a
REPT 4
	ld [hli], a
ENDR
	ld hl, wde11
	xor a
REPT 4
	ld [hli], a
ENDR
	ld hl, wde15
	xor a
REPT 4
	ld [hli], a
ENDR

	ld a, $01
	ld [wde15], a
	ld a, $05
	ld [wde17], a
	ld hl, .data
	ld de, wde19
	ld c, $20
.loop_copy
	ld a, [hli]
	ld [de], a
	inc de
	dec c
	jr nz, .loop_copy
	call Func_ec38
	ret

.data
	db $04, $13, $79, $15, $0f, $6b, $0f, $34, $0f, $2f, $0f, $00, $00, $00, $00, $00, $4e, $0f, $39, $0f, $38, $0f, $5f, $0f, $21, $0f, $00, $00, $00, $00, $00, $00

Func_eb97:
	call Func_ebc6
	jr nc, .asm_eb9f
	call Func_eb39
.asm_eb9f
	call Func_ec6c
; init verbosely from wde0d to wde13
	ld hl, wde0d
	xor a
REPT 4
	ld [hli], a
ENDR
	ld hl, wde11
	xor a
REPT 4
	ld [hli], a
ENDR
	call Func_ec38
	ret

Func_ebb6:
	call EnableSRAM
	xor a
	ld [s0bae5], a
	ld a, $ff
	ld [s0bae4], a
	call DisableSRAM
	ret

Func_ebc6:
	xor a ; BANK("SRAM0")
	ld [wSaveDataSRAMBank], a
	ld a, LOW(WRAMToSRAMMapper_ChallengeMachineSave)
	ld [wWRAMToSRAMMapperPointer], a
	ld a, HIGH(WRAMToSRAMMapper_ChallengeMachineSave)
	ld [wWRAMToSRAMMapperPointer + 1], a
	ld a, LOW(sChallengeMachineSaveData)
	ld [wSaveDataSRAMOffset], a
	ld a, HIGH(sChallengeMachineSaveData)
	ld [wSaveDataSRAMOffset + 1], a
	call EnableSRAM
	ld a, [s0bae6]
	ld [wd673], a
	call DisableSRAM
	call Func_ed0b
	ld a, [wSaveDataChecksum1]
	ld d, a
	ld a, [wSaveDataChecksum0]
	ld e, a
	call EnableSRAM
	ld a, [s0bae4]
	ld b, a
	ld a, [s0bae5]
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
	cp16_long 0
	jr z, .asm_ec36
	ld a, [wde17 + 0]
	ld e, a
	ld a, [wde17 + 1]
	ld d, a
	cp16_long 0
	jr z, .asm_ec36
	scf
	ccf
	ret
.asm_ec36
	scf
	ret

Func_ec38:
	xor a ; BANK("SRAM0")
	ld [wSaveDataSRAMBank], a
	ld a, LOW(WRAMToSRAMMapper_ChallengeMachineSave)
	ld [wWRAMToSRAMMapperPointer], a
	ld a, HIGH(WRAMToSRAMMapper_ChallengeMachineSave)
	ld [wWRAMToSRAMMapperPointer + 1], a
	ld a, LOW(sChallengeMachineSaveData)
	ld [wSaveDataSRAMOffset], a
	ld a, HIGH(sChallengeMachineSaveData)
	ld [wSaveDataSRAMOffset + 1], a
	call Func_ec94
	call EnableSRAM
	ld a, [wSaveDataChecksum1]
	ld [s0bae4], a
	ld a, [wSaveDataChecksum0]
	ld [s0bae5], a
	ld a, [wd673]
	ld [s0bae6], a
	call DisableSRAM
	ret

Func_ec6c:
	xor a ; BANK("SRAM0")
	ld [wSaveDataSRAMBank], a
	ld a, LOW(WRAMToSRAMMapper_ChallengeMachineSave)
	ld [wWRAMToSRAMMapperPointer], a
	ld a, HIGH(WRAMToSRAMMapper_ChallengeMachineSave)
	ld [wWRAMToSRAMMapperPointer + 1], a
	ld a, LOW(sChallengeMachineSaveData)
	ld [wSaveDataSRAMOffset], a
	ld a, HIGH(sChallengeMachineSaveData)
	ld [wSaveDataSRAMOffset + 1], a
	call EnableSRAM
	ld a, [s0bae6]
	ld [wd673], a
	call DisableSRAM
	call Func_ed0b
	ret

Func_ec94:
	ldh a, [hBankSRAM]
	push af
	ld a, [wSaveDataSRAMBank]
	call BankswitchSRAM
	xor a
	ld [wSaveDataChecksum0], a
	ld [wSaveDataChecksum1], a
	call UpdateRNGSources
	or $01
	ld [wd673], a
	ld [wSaveDataChecksum2], a
	ld a, [wWRAMToSRAMMapperPointer]
	ld l, a
	ld a, [wWRAMToSRAMMapperPointer + 1]
	ld h, a
	ld a, [wSaveDataSRAMOffset]
	ld e, a
	ld a, [wSaveDataSRAMOffset + 1]
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
	ld [wSaveDataItemMinValidValue], a
	ld a, [hli]
	ld [wSaveDataItemMaxValidValue], a
	pop hl
.asm_ecd5
	push bc
	ld a, [hli]
	ld c, a
	ld a, [wSaveDataChecksum1]
	xor c
	ld [wSaveDataChecksum1], a
	ld a, [wSaveDataChecksum0]
	add c
	ld [wSaveDataChecksum0], a
	ld a, [wSaveDataChecksum2]
	ld b, a
	sla a
	add b
	ld b, a
	ld a, c
	add b
	ld [de], a
	inc de
	ld a, b
	ld [wSaveDataChecksum2], a
	pop bc
	dec bc
	ld a, b
	or c
	jr nz, .asm_ecd5
	pop hl
REPT 4
	inc hl
ENDR
	jr .asm_ecbf
.asm_ed03
	pop af
	call BankswitchSRAM
	call DisableSRAM
	ret

Func_ed0b:
	ldh a, [hBankSRAM]
	push af
	ld a, [wSaveDataSRAMBank]
	call BankswitchSRAM
	xor a
	ld [wSaveDataChecksum0], a
	ld [wSaveDataChecksum1], a
	ld a, [wd673]
	ld [wSaveDataChecksum2], a
	ld a, [wWRAMToSRAMMapperPointer]
	ld l, a
	ld a, [wWRAMToSRAMMapperPointer + 1]
	ld h, a
	ld a, [wSaveDataSRAMOffset]
	ld e, a
	ld a, [wSaveDataSRAMOffset + 1]
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
	ld [wSaveDataItemMinValidValue], a
	ld a, [hli]
	ld [wSaveDataItemMaxValidValue], a
	pop hl
.asm_ed47
	push bc
	ld a, [wSaveDataChecksum2]
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
	ld [wSaveDataChecksum2], a
	ld a, [wSaveDataChecksum1]
	xor c
	ld [wSaveDataChecksum1], a
	ld a, [wSaveDataChecksum0]
	add c
	ld [wSaveDataChecksum0], a
	pop bc
	dec bc
	ld a, b
	or c
	jr nz, .asm_ed47
	pop hl
REPT 4
	inc hl
ENDR
	jr .asm_ed31
.asm_ed74
	pop af
	call BankswitchSRAM
	call DisableSRAM
	ret

Func_ed7c:
	ldh a, [hBankSRAM]
	push af
	ld a, [wSaveDataSRAMBank]
	call BankswitchSRAM
	xor a
	ld [wSaveDataChecksum0], a
	ld [wSaveDataChecksum1], a
	ld a, [wd673]
	ld [wSaveDataChecksum2], a
	ld a, [wWRAMToSRAMMapperPointer]
	ld l, a
	ld a, [wWRAMToSRAMMapperPointer + 1]
	ld h, a
	ld a, [wSaveDataSRAMOffset]
	ld e, a
	ld a, [wSaveDataSRAMOffset + 1]
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
	ld [wSaveDataItemMinValidValue], a
	ld a, [hli]
	ld [wSaveDataItemMaxValidValue], a
	pop hl
.asm_edb8
	push bc
	ld a, [wSaveDataChecksum2]
	ld b, a
	sla a
	add b
	ld b, a
	ld a, [de]
	sub b
	inc de
	ld c, a
	ld a, b
	ld [wSaveDataChecksum2], a
	ld a, [wSaveDataChecksum1]
	xor c
	ld [wSaveDataChecksum1], a
	ld a, [wSaveDataChecksum0]
	add c
	ld [wSaveDataChecksum0], a
	pop bc
	dec bc
	ld a, b
	or c
	jr nz, .asm_edb8
	pop hl
REPT 4
	inc hl
ENDR
	jr .asm_eda2
.asm_ede4
	pop af
	call BankswitchSRAM
	call DisableSRAM
	ret
