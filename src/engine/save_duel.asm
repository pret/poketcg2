; save data of the current duel to sCurrentDuel
; header (4 bytes): valid flag (TRUE), 2-byte checksum, [wDuelType]
; main (856 bytes): defined in DuelDataToSave
SaveDuelData::
	ld de, sCurrentDuel
;	fallthrough

; save data of the current duel to de (in SRAM)
; header (4 bytes): valid flag (TRUE), 2-byte checksum, [wDuelType]
; main (856 bytes): defined in DuelDataToSave
SaveDuelDataToDE::
	call EnableSRAM
	push de
REPT SAVE_DUEL_HEADER_SIZE
	inc de
ENDR
	ld hl, DuelDataToSave
	push de
; start copying data to de = sCurrentDuelData
.loop_duel_data
	ld c, [hl] ; LOW(ptr)
	inc hl
	ld b, [hl] ; HIGH(ptr)
	inc hl
	ld a, c
	or b
	jr z, .data_done
	push hl
	push bc
	ld c, [hl] ; LOW(size)
	inc hl
	ld b, [hl] ; HIGH(size)
	inc hl ; redundant
	pop hl ; ptr
	call CopyDataHLtoDE
; next
	pop hl
	inc hl
	inc hl
	jr .loop_duel_data

.data_done
	pop hl
; calculate checksum with hl = sCurrentDuelData (omitting last 6 bytes)
; and set header bytes
	ld de, SAVE_DUEL_CHECKSUM_SEED
	ld bc, SAVE_DUEL_DATA_SIZE - 6
.loop_checksum
	ld a, e
	sub [hl]
	ld e, a
	ld a, [hli]
	xor d
	ld d, a
	dec bc
	ld a, c
	or b
	jr nz, .loop_checksum
	pop hl
	ld a, TRUE
	ld [hli], a ; sCurrentDuelValid
	ld [hl], e ; sCurrentDuelChecksum
	inc hl
	ld [hl], d ; sCurrentDuelChecksum
	inc hl
	ld a, [wDuelType]
	ld [hl], a ; sCurrentDuelType
	call DisableSRAM
	ret

; exit early with carry if invalid
; now skipping general save data unlike tcg1
LoadAndValidateDuelSaveData:
	ld hl, sCurrentDuel
	call ValidateSavedDuelDataInHL
	ret c
	ld de, sCurrentDuel
	call LoadSavedDuelDataFromDE
	or a
	ret

; load data saved at de (in SRAM) to WRAM, using DuelDataToSave table
; assumes saved data exists with valid checksum
LoadSavedDuelDataFromDE:
	call EnableSRAM
REPT SAVE_DUEL_HEADER_SIZE
	inc de
ENDR
	ld hl, DuelDataToSave
.loop_duel_data
	ld c, [hl] ; LOW(ptr)
	inc hl
	ld b, [hl] ; HIGH(ptr)
	inc hl
	ld a, c
	or b
	jr z, .done
	push hl
	push bc
	ld c, [hl] ; LOW(size)
	inc hl
	ld b, [hl] ; HIGH(size)
	inc hl ; redundant
	pop hl ; ptr
.loop_copy
	ld a, [de]
	inc de
	ld [hli], a
	dec bc
	ld a, c
	or b
	jr nz, .loop_copy
; next
	pop hl
	inc hl
	inc hl
	jr .loop_duel_data
.done
	call DisableSRAM
	bank1call LoadSkipAllowed
	ret

; 856 bytes
DuelDataToSave:
;	dw address, number of bytes to copy
	dw STARTOF("WRAM0 Duels 1"), wNameBuffer + NAME_BUFFER_LENGTH - STARTOF("WRAM0 Duels 1")
	dw wDuelStates,              wDuelStatesEnd - wDuelStates
	dw hWhoseTurn,               $1
	dw wRNGVars,                 RNGVARS_SIZE
	dw wAIDuelVars,              wAIDuelVarsEnd - wAIDuelVars
	dw NULL

; return carry if sCurrentDuel is from link duel
; or invalid (no valid flag or checksum mismatch)
ValidateSavedNonLinkDuelData:
	call EnableSRAM
	ld hl, sCurrentDuel
	ld a, [sCurrentDuelType]
	call DisableSRAM
	cp DUELTYPE_LINK
	jr nz, ValidateSavedDuelDataInHL
; ignore any saved data of link duel
	scf
	ret

; return carry if duel save at hl (in SRAM) is invalid
; (no valid flag or checksum mismatch)
ValidateSavedDuelDataInHL:
	call EnableSRAM
	push de
	ld a, [hli] ; sCurrentDuelValid
	or a ; cp FALSE
	jr z, .set_carry
	ld de, SAVE_DUEL_CHECKSUM_SEED
	ld bc, SAVE_DUEL_DATA_SIZE - 6
	ld a, [hl] ; sCurrentDuelChecksum
	sub e
	ld e, a
	inc hl
	ld a, [hl] ; sCurrentDuelChecksum
	xor d
	ld d, a
	inc hl
	inc hl
; hl = sCurrentDuelData
.loop_checksum
	ld a, [hl]
	add e
	ld e, a
	ld a, [hli]
	xor d
	ld d, a
	dec bc
	ld a, c
	or b
	jr nz, .loop_checksum
	ld a, e
	or d
	jr z, .no_carry
.set_carry
	scf
.no_carry
	call DisableSRAM
	pop de
	ret

; reset sCurrentDuelValid and sCurrentDuelChecksum
ClearSavedDuel:
	call EnableSRAM
	ld hl, sCurrentDuel
	xor a
	ld [hli], a ; sCurrentDuelValid
	ld [hli], a ; sCurrentDuelChecksum
	ld [hl], a  ; sCurrentDuelChecksum
	call DisableSRAM
	ret

; save duel state to SRAM
; called between each two-player turn, just after player draws card (ROM bank 1 loaded)
; uses SRAM2 and SRAM3 as with tcg1
SaveDuelStateToSRAM:
; save duel data to sBackupCurrentDuel
	ld a, BANK(sBackupCurrentDuel)
	call BankswitchSRAM
	call SaveDuelData
	xor a ; BANK("SRAM0")
	call BankswitchSRAM
; get hl = sGfxBufferN for N = [s0a008] & $3
	call EnableSRAM
	ld hl, s0a008
	ld a, [hl]
	inc [hl]
	call DisableSRAM
	and $3
	add HIGH(sGfxBuffer0) / 4
	ld l, 0
	ld h, a
	add hl, hl
	add hl, hl
	ld a, BANK(sGfxBuffer0)
	call BankswitchSRAM
; save wDuelTurns, non-turn holder's arena card ID, turn holder's arena card ID
	push hl
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call GetCardIDFromDeckIndex
	ld hl, wTempTurnDuelistCardID
	ld [hl], e
	inc hl
	ld [hl], d
	call SwapTurn
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call GetCardIDFromDeckIndex
	ld hl, wTempNonTurnDuelistCardID
	ld [hl], e
	inc hl
	ld [hl], d
	call SwapTurn
	pop hl
	push hl
	call EnableSRAM
	ld a, [wDuelTurns]
	ld [hli], a
	ld a, [wTempNonTurnDuelistCardID]
	ld [hli], a
	ld a, [wTempNonTurnDuelistCardID + 1]
	ld [hli], a
	ld a, [wTempTurnDuelistCardID]
	ld [hli], a
	ld a, [wTempTurnDuelistCardID + 1]
	ld [hli], a
	pop hl
; save duel data to sGfxBufferN + $10
	ld de, $10
	add hl, de
	ld e, l
	ld d, h
	call DisableSRAM
	call SaveDuelDataToDE
	xor a ; BANK("SRAM0")
	call BankswitchSRAM
	call DisableSRAM
	ret
