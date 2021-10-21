SECTION "WRAM0", WRAM0[$c000]
	ds $a00

wOAM:: ; ca00
	ds $1

	ds $b2

wInitialA:: ; cab3
	ds $1

wConsole:: ; cab4
	ds $1

wOAMOffset:: ; cab5
	ds $1

wTileMapFill:: ; cab6
	ds $1

wIE:: ; cab7
	ds $1

wVBlankCounter:: ; cab8
	ds $1

	ds $1

wReentrancyFlag:: ; caba
	ds $1

wBGP:: ; cabb
	ds $1

wOBP0:: ; cabc
	ds $1

wOBP1:: ; cabd
	ds $1

wVBlankOAMCopyToggle:: ; cabe
	ds $1

wTempByte:: ; cabf
	ds $1

wDuelDisplayedScreen:: ; cac0
	ds $1

wTimerCounter:: ; cac1
	ds $1

wPlayTimeCounterEnable:: ; cac2
	ds $1

wPlayTimeCounter:: ; cac3
	ds $1

	ds $4

wRNG1:: ; cac8
	ds $1

; cac9
	ds $1

; caca
	ds $1

wLCDCFunctionTrampoline:: ; cacb
	ds $1

; cacc
	ds $1

; cacd
	ds $1

wVBlankFunctionTrampoline:: ; cace
	ds $1
