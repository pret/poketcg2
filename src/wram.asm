INCLUDE "macros.asm"
INCLUDE "constants.asm"

INCLUDE "vram.asm"

SECTION "WRAM0", WRAM0

; aside from wDecompressionBuffer, which stores the
; de facto final decompressed data after decompression,
; this buffer stores a secondary buffer that is used
; for "lookbacks" when repeating byte sequences.
; actually starts in the middle of the buffer,
; at wDecompressionSecondaryBufferStart, then wraps back up
; to wDecompressionSecondaryBuffer.
; this is used so that $00 can be "looked back", since anything
; before $ef is initialized to 0 when starting decompression.
wDecompressionSecondaryBuffer:: ; c000
	ds $ef
wDecompressionSecondaryBufferStart:: ; c0ef
	ds $11

SECTION "WRAM0 1", WRAM0

wOAM:: ; ca00
	ds $a0

; 16-byte buffer to store text, usually a name or a number
; used by TX_RAM1 but not exclusively
wStringBuffer:: ; caa0
	ds $10

wcab0:: ; cab0
	ds $1

wcab1:: ; cab1
	ds $1

wcab2:: ; cab2
	ds $1

; initial value of the A register. used to tell the console when reset
wInitialA:: ; cab3
	ds $1

; what console we are playing on, either 0 (DMG), 1 (SGB) or 2 (CGB)
; use constants CONSOLE_DMG, CONSOLE_SGB and CONSOLE_CGB for checks
wConsole:: ; cab4
	ds $1

; used to select a sprite or a starting sprite from wOAM
wOAMOffset:: ; cab5
	ds $1

; FillTileMap fills VRAM0 BG Maps with the tile stored here
wTileMapFill:: ; cab6
	ds $1

wIE:: ; cab7
	ds $1

; incremented whenever the vblank handler ends. used to wait for it to end,
; or to delay a specific amount of frames
wVBlankCounter:: ; cab8
	ds $1

	ds $1

; bit0: is in vblank interrupt?
; bit1: is in timer interrupt?
wReentrancyFlag:: ; caba
	ds $1

wBGP:: ; cabb
	ds $1

wOBP0:: ; cabc
	ds $1

wOBP1:: ; cabd
	ds $1

; set to non-0 to request OAM copy during vblank
wVBlankOAMCopyToggle:: ; cabe
	ds $1

; used by HblankWriteByteToBGMap0
wTempByte:: ; cabf
	ds $1

; which screen or interface is currently displayed in the screen during a duel
; used to prevent loading graphics or drawing stuff more times than necessary
wDuelDisplayedScreen:: ; cac0
	ds $1

; used to increase the play time counter every four timer interrupts (60.24 Hz)
wTimerCounter:: ; cac1
	ds $1

wPlayTimeCounterEnable:: ; cac2
	ds $1

; byte0: 1/60ths of a second
; byte1: seconds
; byte2: minutes
; byte3: hours (lower byte)
; byte4: hours (upper byte)
wPlayTimeCounter:: ; cac3
	ds $5

wRNG1:: ; cac8
	ds $1

wRNG2:: ; cac9
	ds $1

wRNGCounter:: ; caca
	ds $1

; the LCDC status interrupt is always disabled and this always reads as jp $0000
wLCDCFunctionTrampoline:: ; cacb
	ds $3

wVBlankFunctionTrampoline:: ; cace
	ds $3

; pointer to a function to be called by DoFrame
wDoFrameFunction:: ; cad1
	ds $2

; if non-zero, the game screen can be paused at any time with the select button
wDebugPauseAllowed:: ; cad3
	ds $1

; pointer to keep track of where
; in the source data we are while
; running the decompression algorithm
wDecompSourcePosPtr:: ; cad4
	ds $2

; number of bits that are still left
; to read from the current command byte
wDecompNumCommandBitsLeft:: ; cad6
	ds $1

; command byte from which to read the bits
; to decompress source data
wDecompCommandByte:: ; cad7
	ds $1

; if bit 7 is changed from off to on, then
; decompression routine will read next two bytes
; for repeating previous sequence (length, offset)
; if it changes from on to off, then the routine
; will only read one byte, and reuse previous length byte
wDecompRepeatModeToggle:: ; cad8
	ds $1

; stores in both nybbles the length of the
; sequences to copy in decompression
; the high nybble is used first, then the low nybble
; for a subsequent sequence repetition
wDecompRepeatLengths:: ; cad9
	ds $1

wDecompNumBytesToRepeat:: ; cada
	ds $1

wDecompSecondaryBufferPtrHigh:: ; cadb
	ds $1

; offset to repeat byte from decompressed data
wDecompRepeatSeqOffset:: ; cadc
	ds $1

wDecompSecondaryBufferPtrLow:: ; cadd
	ds $1

	ds $10

; temporary CGB palette data buffer to eventually save into BGPD registers.
wBackgroundPalettesCGB:: ; caee
	ds NUM_BACKGROUND_PALETTES palettes

SECTION "WRAM0 Serial Transfer", WRAM0

wSerialOp:: ; cb6e
	ds $1

wSerialFlags:: ; cb6f
	ds $1

wSerialCounter:: ; cb70
	ds $1

wSerialCounter2:: ; cb71
	ds $1

wSerialTimeoutCounter:: ; cb72
	ds $1

wcb79:: ; cb73
	ds $2

wcb7b:: ; cb75
	ds $2

wSerialSendSave:: ; cb77
	ds $1

wSerialSendBufToggle:: ; cb78
	ds $1

wSerialSendBufIndex:: ; cb79
	ds $1

wcb80:: ; cb7a
	ds $1

wSerialSendBuf:: ; cb7b
	ds $20

wSerialLastReadCA:: ; cb9b
	ds $1

wSerialRecvCounter:: ; cb9c
	ds $1

wcba3:: ; cb9d
	ds $1

wSerialRecvIndex:: ; cb9e
	ds $1

wSerialRecvBuf:: ; cb9f
	ds $20

wSerialEnd:: ; cbbf

SECTION "WRAM0 Duels 2", WRAM0

wOppRNG1:: ; cbda
	ds $1

	ds $2

; sp is saved here when starting a duel, in order to save the return address
; however, it only seems to be read after a transmission error in a link duel
wDuelReturnAddress:: ; cbdd
	ds $2

	ds $3

; temporarily stores 8 bytes for serial send/recv.
; used by SerialSend8Bytes and SerialRecv8Bytes
wTempSerialBuf:: ; cbe2
	ds $8

SECTION "WRAM0 Duels 2@cc02", WRAM0

; a DUELTYPE_* constant. note that for a practice duel, wIsPracticeDuel must also be set to $1
wDuelType:: ; cc02
	ds $1

SECTION "WRAM0 2", WRAM0

wce63:: ; cde9
	ds $1

SECTION "WRAM1", WRAMX

; stores a pointer to a temporary list of elements (e.g. pointer to wDuelTempList)
; to be read or written sequentially
wListPointer:: ; d000
	ds $2

wListPointer2:: ; d002
	ds $2

SECTION "WRAM1@dd02", WRAMX

; stores the player's result in a duel (0: win, 1: loss, 2: ???, -1: transmission error?)
; to be read by the overworld caller
wDuelResult:: ; dd02
	ds $1

INCLUDE "sram.asm"
