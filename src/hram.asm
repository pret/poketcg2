SECTION "HRAM", HRAM[$ff80]

hBankROM:: ; ff80
	ds $1

hBankSRAM:: ; ff81
	ds $1

hBankVRAM:: ; ff82
	ds $1

hDMAFunction:: ; ff83
	ds $a

; D-pad repeat counter. see HandleDPadRepeat
hDPadRepeat:: ; ff8d
	ds $1

; keys pressed in last frame but not in current frame
hKeysReleased:: ; ff8e
	ds $1

; used to quickly scroll through menus when a relevant D-pad key is held
; see HandleDPadRepeat
hDPadHeld:: ; ff8f
	ds $1

; keys pressed in last frame and in current frame
hKeysHeld:: ; ff90
	ds $1

; keys pressed in current frame but not in last frame
hKeysPressed:: ; ff91
	ds $1

hSCX:: ; ff92
	ds $1

hSCY:: ; ff93
	ds $1

hWX:: ; ff94
	ds $1

hWY:: ; ff95
	ds $1

hLCDC:: ; ff96
	ds $1

hFlushPaletteFlags:: ; ff97
	ds $1

	ds $1

hWhoseTurn:: ; ff99
	ds $1
