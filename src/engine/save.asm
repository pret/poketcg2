; return carry if no save data in SRAM2 (sBackupSaveDataState bit 0 = z)
CheckIfHasBackupSave:
	ldh a, [hBankSRAM]
	push af
	ld a, BANK(sBackupSaveDataState)
	call BankswitchSRAM
	call EnableSRAM
	ld a, [sBackupSaveDataState]
	ld b, a
	pop af
	call BankswitchSRAM
	call DisableSRAM
	ld a, b
	bit 0, a
	jr z, .no_save
	scf
	ccf
	ret
.no_save
	scf
	ret

; return carry if no save data in SRAM0 (sSaveDataState bit 1 = z)
CheckIfHasMainSave:
	call EnableSRAM
	ld a, [sSaveDataState]
	ld b, a
	call DisableSRAM
	ld a, b
	bit 1, a
	jr z, .no_save
	scf
	ccf
	ret
.no_save
	scf
	ret

; return carry if invalid (SRAM2)
; (reversing tcg1's logic)
ValidateBackupGeneralSaveData:
	ld a, BANK(sBackupGeneralSaveData)
	ld [wSaveDataCurBankSRAM], a
	ldh a, [hBankSRAM]
	push af
	ld a, BANK(sBackupGeneralSaveData)
	call BankswitchSRAM
	ld a, [sBackupGeneralSaveDataHeader]
	ld b, a
	pop af
	call BankswitchSRAM
	call DisableSRAM
	ld a, b
	cp $16
	jr nz, .invalid
	ld a, LOW(WRAMToSRAMMapper_GeneralSave)
	ld [wWRAMToSRAMMapperPointer], a
	ld a, HIGH(WRAMToSRAMMapper_GeneralSave)
	ld [wWRAMToSRAMMapperPointer + 1], a
	ld a, LOW(sBackupGeneralSaveDataMain)
	ld [wSaveDataSRAMOffset], a
	ld a, HIGH(sBackupGeneralSaveDataMain)
	ld [wSaveDataSRAMOffset + 1], a
	call LoadGeneralSaveDataChecksumSeed
	call LoadSaveDataChecksumsFromSRAM
	ld a, [wSaveDataChecksum1]
	ld d, a
	ld a, [wSaveDataChecksum0]
	ld e, a
	ldh a, [hBankSRAM]
	push af
	ld a, BANK(sBackupGeneralSaveData)
	call BankswitchSRAM
	ld a, [sBackupGeneralSaveDataChecksum1]
	ld b, a
	ld a, [sBackupGeneralSaveDataChecksum0]
	ld c, a
	pop af
	call BankswitchSRAM
	call DisableSRAM
	ld a, b
	cp d
	jr nz, .invalid
	ld a, c
	cp e
	jr nz, .invalid
	scf
	ccf
	ret
.invalid
	scf
	ret

; return carry if invalid (SRAM0)
; (reversing tcg1's logic)
ValidateGeneralSaveData:
	xor a ; BANK(sGeneralSaveData)
	ld [wSaveDataCurBankSRAM], a
	ldh a, [hBankSRAM]
	push af
	xor a ; BANK(sGeneralSaveData)
	call BankswitchSRAM
	ld a, [sGeneralSaveDataHeader]
	ld b, a
	pop af
	call BankswitchSRAM
	call DisableSRAM
	ld a, b
	cp $16
	jr nz, .invalid
	ld a, LOW(WRAMToSRAMMapper_GeneralSave)
	ld [wWRAMToSRAMMapperPointer], a
	ld a, HIGH(WRAMToSRAMMapper_GeneralSave)
	ld [wWRAMToSRAMMapperPointer + 1], a
	ld a, LOW(sGeneralSaveDataMain)
	ld [wSaveDataSRAMOffset], a
	ld a, HIGH(sGeneralSaveDataMain)
	ld [wSaveDataSRAMOffset + 1], a
	call LoadGeneralSaveDataChecksumSeed
	call LoadSaveDataChecksumsFromSRAM
	ld a, [wSaveDataChecksum1]
	ld d, a
	ld a, [wSaveDataChecksum0]
	ld e, a
	ldh a, [hBankSRAM]
	push af
	xor a ; BANK(sGeneralSaveData)
	call BankswitchSRAM
	ld a, [sGeneralSaveDataChecksum1]
	ld b, a
	ld a, [sGeneralSaveDataChecksum0]
	ld c, a
	pop af
	call BankswitchSRAM
	call DisableSRAM
	ld a, b
	cp d
	jr nz, .invalid
	ld a, c
	cp e
	jr nz, .invalid
	scf
	ccf
	ret
.invalid
	scf
	ret

ClearSaveData:
	ldh a, [hBankSRAM]
	push af
	ld a, BANK(sBackupGeneralSaveData)
	call BankswitchSRAM
	ld hl, sBackupSaveDataState
	xor a
	ld [hl], a
	ld [sBackupGeneralSaveDataHeader], a
	pop af
	call BankswitchSRAM
	call DisableSRAM
	call EnableSRAM
	ld hl, sSaveDataState
	xor a
	ld [hl], a
	ld [sGeneralSaveDataHeader], a
	call DisableSRAM
	farcall ClearSavedDuel
	call DisableSRAM
	ret

InitSaveDataState:
	call EnableSRAM
	ld hl, sSaveDataState
	xor a
	ld [hl], a
	call DisableSRAM
	farcall ClearSavedDuel
	ret

; copy all SRAM0 to SRAM2
; and set sBackupGeneralSaveDataHeader and sBackupSaveDataState
BackupMainSave:
	ld a, 2
	call BulkCopySRAM
	ldh a, [hBankSRAM]
	push af
	ld a, BANK(sBackupGeneralSaveData)
	call BankswitchSRAM
	ld a, $16
	ld [sBackupGeneralSaveDataHeader], a
	ld hl, sBackupSaveDataState
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

; from either SRAM0 or SRAM2 (wSaveDataCurBankSRAM)
; to wSaveDataChecksumSeed
LoadGeneralSaveDataChecksumSeed:
	ldh a, [hBankSRAM]
	push af
	ld a, [wSaveDataCurBankSRAM]
	call BankswitchSRAM
	ld a, [sGeneralSaveDataChecksumSeed]
	ld [wSaveDataChecksumSeed], a
	pop af
	call BankswitchSRAM
	call DisableSRAM
	ret

_SaveGame::
	ld a, OWMODE_SAVE_PRELOAD
	call ExecuteOWModeScript
	farcall Func_10f32
	xor a ; BANK(sGeneralSaveData)
	ld [wSaveDataCurBankSRAM], a
.save
	ld a, LOW(WRAMToSRAMMapper_GeneralSave)
	ld [wWRAMToSRAMMapperPointer], a
	ld a, HIGH(WRAMToSRAMMapper_GeneralSave)
	ld [wWRAMToSRAMMapperPointer + 1], a
	ld a, LOW(sGeneralSaveDataMain)
	ld [wSaveDataSRAMOffset], a
	ld a, HIGH(sGeneralSaveDataMain)
	ld [wSaveDataSRAMOffset + 1], a
	call WriteSaveDataToSRAM
	call EnableSRAM
	ld a, $16
	ld [sGeneralSaveDataHeader], a
	ld a, [wSaveDataChecksum1]
	ld [sGeneralSaveDataChecksum1], a
	ld a, [wSaveDataChecksum0]
	ld [sGeneralSaveDataChecksum0], a
	ld a, [wSaveDataChecksumSeed]
	ld [sGeneralSaveDataChecksumSeed], a
	ld hl, sSaveDataState
	set 0, [hl]
	call DisableSRAM
	call LoadGeneralSaveDataChecksumSeed
	call LoadSaveDataChecksumsFromSRAM
	ld a, [wSaveDataChecksum1]
	ld d, a
	ld a, [wSaveDataChecksum0]
	ld e, a
	call EnableSRAM
	ld a, [sGeneralSaveDataChecksum1]
	ld b, a
	ld a, [sGeneralSaveDataChecksum0]
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
	jr .save

SaveGame_NoBackup:
	farcall Func_10f32
	xor a ; BANK(sGeneralSaveData)
	ld [wSaveDataCurBankSRAM], a
	ld a, LOW(WRAMToSRAMMapper_GeneralSave)
	ld [wWRAMToSRAMMapperPointer], a
	ld a, HIGH(WRAMToSRAMMapper_GeneralSave)
	ld [wWRAMToSRAMMapperPointer + 1], a
	ld a, LOW(sGeneralSaveDataMain)
	ld [wSaveDataSRAMOffset], a
	ld a, HIGH(sGeneralSaveDataMain)
	ld [wSaveDataSRAMOffset + 1], a
	call WriteSaveDataToSRAM
	call EnableSRAM
	ld a, $16
	ld [sGeneralSaveDataHeader], a
	ld a, [wSaveDataChecksum1]
	ld [sGeneralSaveDataChecksum1], a
	ld a, [wSaveDataChecksum0]
	ld [sGeneralSaveDataChecksum0], a
	ld a, [wSaveDataChecksumSeed]
	ld [sGeneralSaveDataChecksumSeed], a
	ld hl, sSaveDataState
	set 1, [hl]
	call DisableSRAM
	ret

RestoreBackupSave:
	call LoadBackupSave
	xor a
	call BulkCopySRAM
	farcall Func_10f78
	ret

LoadBackupSave:
	ld a, BANK(sBackupGeneralSaveData)
	ld [wSaveDataCurBankSRAM], a
	ld a, LOW(WRAMToSRAMMapper_GeneralSave)
	ld [wWRAMToSRAMMapperPointer], a
	ld a, HIGH(WRAMToSRAMMapper_GeneralSave)
	ld [wWRAMToSRAMMapperPointer + 1], a
	ld a, LOW(sBackupGeneralSaveDataMain)
	ld [wSaveDataSRAMOffset], a
	ld a, HIGH(sBackupGeneralSaveDataMain)
	ld [wSaveDataSRAMOffset + 1], a
	call LoadGeneralSaveDataChecksumSeed
	call LoadSaveDataFromSRAM
	ret

LoadMainSave:
	xor a ; BANK(sGeneralSaveData)
	ld [wSaveDataCurBankSRAM], a
	ld a, LOW(WRAMToSRAMMapper_GeneralSave)
	ld [wWRAMToSRAMMapperPointer], a
	ld a, HIGH(WRAMToSRAMMapper_GeneralSave)
	ld [wWRAMToSRAMMapperPointer + 1], a
	ld a, LOW(sGeneralSaveDataMain)
	ld [wSaveDataSRAMOffset], a
	ld a, HIGH(sGeneralSaveDataMain)
	ld [wSaveDataSRAMOffset + 1], a
	call LoadGeneralSaveDataChecksumSeed
	call LoadSaveDataFromSRAM
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
	ld [sChallengeMachineSaveDataChecksum0], a
	ld a, $ff
	ld [sChallengeMachineSaveDataChecksum1], a
	call DisableSRAM
	ret

Func_ebc6:
	xor a ; BANK(sChallengeMachineSaveData)
	ld [wSaveDataCurBankSRAM], a
	ld a, LOW(WRAMToSRAMMapper_ChallengeMachineSave)
	ld [wWRAMToSRAMMapperPointer], a
	ld a, HIGH(WRAMToSRAMMapper_ChallengeMachineSave)
	ld [wWRAMToSRAMMapperPointer + 1], a
	ld a, LOW(sChallengeMachineSaveData)
	ld [wSaveDataSRAMOffset], a
	ld a, HIGH(sChallengeMachineSaveData)
	ld [wSaveDataSRAMOffset + 1], a
	call EnableSRAM
	ld a, [sChallengeMachineSaveDataChecksumSeed]
	ld [wSaveDataChecksumSeed], a
	call DisableSRAM
	call LoadSaveDataFromSRAM
	ld a, [wSaveDataChecksum1]
	ld d, a
	ld a, [wSaveDataChecksum0]
	ld e, a
	call EnableSRAM
	ld a, [sChallengeMachineSaveDataChecksum1]
	ld b, a
	ld a, [sChallengeMachineSaveDataChecksum0]
	ld c, a
	call DisableSRAM
	ld a, b
	cp d
	jr nz, .error
	ld a, c
	cp e
	jr nz, .error
	ld a, [wde15 + 0]
	ld e, a
	ld a, [wde15 + 1]
	ld d, a
	cp16_long 0
	jr z, .error
	ld a, [wde17 + 0]
	ld e, a
	ld a, [wde17 + 1]
	ld d, a
	cp16_long 0
	jr z, .error
	scf
	ccf
	ret
.error
	scf
	ret

Func_ec38:
	xor a ; BANK(sChallengeMachineSaveData)
	ld [wSaveDataCurBankSRAM], a
	ld a, LOW(WRAMToSRAMMapper_ChallengeMachineSave)
	ld [wWRAMToSRAMMapperPointer], a
	ld a, HIGH(WRAMToSRAMMapper_ChallengeMachineSave)
	ld [wWRAMToSRAMMapperPointer + 1], a
	ld a, LOW(sChallengeMachineSaveData)
	ld [wSaveDataSRAMOffset], a
	ld a, HIGH(sChallengeMachineSaveData)
	ld [wSaveDataSRAMOffset + 1], a
	call WriteSaveDataToSRAM
	call EnableSRAM
	ld a, [wSaveDataChecksum1]
	ld [sChallengeMachineSaveDataChecksum1], a
	ld a, [wSaveDataChecksum0]
	ld [sChallengeMachineSaveDataChecksum0], a
	ld a, [wSaveDataChecksumSeed]
	ld [sChallengeMachineSaveDataChecksumSeed], a
	call DisableSRAM
	ret

Func_ec6c:
	xor a ; BANK(sChallengeMachineSaveData)
	ld [wSaveDataCurBankSRAM], a
	ld a, LOW(WRAMToSRAMMapper_ChallengeMachineSave)
	ld [wWRAMToSRAMMapperPointer], a
	ld a, HIGH(WRAMToSRAMMapper_ChallengeMachineSave)
	ld [wWRAMToSRAMMapperPointer + 1], a
	ld a, LOW(sChallengeMachineSaveData)
	ld [wSaveDataSRAMOffset], a
	ld a, HIGH(sChallengeMachineSaveData)
	ld [wSaveDataSRAMOffset + 1], a
	call EnableSRAM
	ld a, [sChallengeMachineSaveDataChecksumSeed]
	ld [wSaveDataChecksumSeed], a
	call DisableSRAM
	call LoadSaveDataFromSRAM
	ret

WriteSaveDataToSRAM:
	ldh a, [hBankSRAM]
	push af
	ld a, [wSaveDataCurBankSRAM]
	call BankswitchSRAM
	xor a
	ld [wSaveDataChecksum0], a
	ld [wSaveDataChecksum1], a
	call UpdateRNGSources
	or $01
	ld [wSaveDataChecksumSeed], a
	ld [wSaveDataChecksum2], a
	ld a, [wWRAMToSRAMMapperPointer]
	ld l, a
	ld a, [wWRAMToSRAMMapperPointer + 1]
	ld h, a
	ld a, [wSaveDataSRAMOffset]
	ld e, a
	ld a, [wSaveDataSRAMOffset + 1]
	ld d, a
.loop_write
	ld a, [hli]
	ld c, a
	ld a, [hli]
	ld b, a
	or c
	jr z, .done
	push hl
	push bc
	ld a, [hli]
	ld c, a
	ld a, [hli]
	ld b, a
	ld a, [hli]
	ld [wSaveDataCurItemMinValidValue], a
	ld a, [hli]
	ld [wSaveDataCurItemMaxValidValue], a
	pop hl
.loop_checksum
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
	jr nz, .loop_checksum
	pop hl
REPT 4
	inc hl
ENDR
	jr .loop_write
.done
	pop af
	call BankswitchSRAM
	call DisableSRAM
	ret

LoadSaveDataFromSRAM:
	ldh a, [hBankSRAM]
	push af
	ld a, [wSaveDataCurBankSRAM]
	call BankswitchSRAM
	xor a
	ld [wSaveDataChecksum0], a
	ld [wSaveDataChecksum1], a
	ld a, [wSaveDataChecksumSeed]
	ld [wSaveDataChecksum2], a
	ld a, [wWRAMToSRAMMapperPointer]
	ld l, a
	ld a, [wWRAMToSRAMMapperPointer + 1]
	ld h, a
	ld a, [wSaveDataSRAMOffset]
	ld e, a
	ld a, [wSaveDataSRAMOffset + 1]
	ld d, a
.loop_load
	ld a, [hli]
	ld c, a
	ld a, [hli]
	ld b, a
	or c
	jr z, .done
	push hl
	push bc
	ld a, [hli]
	ld c, a
	ld a, [hli]
	ld b, a
	ld a, [hli]
	ld [wSaveDataCurItemMinValidValue], a
	ld a, [hli]
	ld [wSaveDataCurItemMaxValidValue], a
	pop hl
.loop_checksum
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
	jr nz, .loop_checksum
	pop hl
REPT 4
	inc hl
ENDR
	jr .loop_load
.done
	pop af
	call BankswitchSRAM
	call DisableSRAM
	ret

; dry-run version of LoadSaveDataFromSRAM
; that only updates checksums (and wSaveDataCurItem_*)
LoadSaveDataChecksumsFromSRAM:
	ldh a, [hBankSRAM]
	push af
	ld a, [wSaveDataCurBankSRAM]
	call BankswitchSRAM
	xor a
	ld [wSaveDataChecksum0], a
	ld [wSaveDataChecksum1], a
	ld a, [wSaveDataChecksumSeed]
	ld [wSaveDataChecksum2], a
	ld a, [wWRAMToSRAMMapperPointer]
	ld l, a
	ld a, [wWRAMToSRAMMapperPointer + 1]
	ld h, a
	ld a, [wSaveDataSRAMOffset]
	ld e, a
	ld a, [wSaveDataSRAMOffset + 1]
	ld d, a
.loop_load
	ld a, [hli]
	ld c, a
	ld a, [hli]
	ld b, a
	or c
	jr z, .done
	push hl
	push bc
	ld a, [hli]
	ld c, a
	ld a, [hli]
	ld b, a
	ld a, [hli]
	ld [wSaveDataCurItemMinValidValue], a
	ld a, [hli]
	ld [wSaveDataCurItemMaxValidValue], a
	pop hl
.loop_checksum
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
	jr nz, .loop_checksum
	pop hl
REPT 4
	inc hl
ENDR
	jr .loop_load
.done
	pop af
	call BankswitchSRAM
	call DisableSRAM
	ret
