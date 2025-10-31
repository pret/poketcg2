GameLoop::
	di
	ld sp, $d000
	call ResetSerial
	call EnableInt_VBlank
	call EnableInt_Timer
	call EnableSRAM
	ld a, [sTextSpeed]
	ld [wTextSpeed], a
	ld a, [sSkipDelayAllowed]
	ld [wSkipDelayAllowed], a
	call DisableSRAM
	ld a, DECK_SIZE
	ld [wDeckSize], a
	ei

	ld a, [wConsole]
	cp CONSOLE_CGB
	jr nz, .not_cgb
	call ReadJoypad
	ldh a, [hKeysHeld]
	cp PAD_A | PAD_B
	jr z, .ask_erase_backup_ram
	farcall $4, CoreGameLoop ; unnecessary farcall?
	jr GameLoop

.not_cgb
	farcall GBCOnlyDisclaimer
	ret

.ask_erase_backup_ram
	call SetupResetBackUpRAMScreen
	call EmptyScreen
	ldtx hl, ResetBackUpRamPromptText
	call YesOrNoMenuWithText
	jr c, .reset_game
; erase sram
	call EnableSRAM
	xor a
	ld [s0a000], a
	call DisableSRAM
.reset_game
	jp Reset

_InitSaveData::
	farcall InitSaveData
	ret

SetupResetBackUpRAMScreen:
	xor a ; SYM_SPACE
	ld [wTileMapFill], a
	call DisableLCD
	call LoadSymbolsFont
	call SetDefaultPalettes
	lb de, $38, $7f
	call SetupText
	ret
