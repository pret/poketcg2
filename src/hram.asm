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

; deck index of a card (0-59)
hTempCardIndex_ff98:: ; ff9a
	ds $1

; used in SortCardsInListByID
hTempListPtr_ff99:: ; ff9b
	ds $2

; used in SortCardsInListByID
; this function supports 16-bit card IDs
hTempCardID_ff9b:: ; ff9d
	ds $2

; a PLAY_AREA_* constant (0: arena card, 1-5: bench card)
hTempPlayAreaLocation_ff9d:: ; ff9f
	ds $1

; index for AIActionTable
hOppActionTableIndex:: ; ffa0
	ds $1

; deck index of a card (0-59)
hTempCardIndex_ff9f:: ; ffa1
	ds $1

; multipurpose temp storage (card's deck index, selected attack index, status condition...)
hTemp_ffa0:: ; ffa2
	ds $1
