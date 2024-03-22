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

hff96:: ; ff98
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

; a PLAY_AREA_* constant (0: arena card, 1-5: bench card)
hTempPlayAreaLocation_ffa1:: ; ffa3
	ds $1

; $ff-terminated list of cards to be discarded upon retreat
hTempRetreatCostCards:: ; ffa4
	ds $6

	ds $9

; hffa8 through hffbb belong to the text engine
hffa8:: ; ffb3
	ds $1

hffa9:: ; ffb4
	ds $1

; Address within v*BGMap0 where text is currently being written to
hTextBGMap0Address:: ; ffb5
	ds $2

; position within a line of text where text is currently being placed at
; ranges between 0 and [hTextLineLength]
hTextLineCurPos:: ; ffb7
	ds $1

; used as an x coordinate offset when printing text, in order to align
; the text's starting position and/or adjust for the BG scroll registers
hTextHorizontalAlign:: ; ffb8
	ds $1

; how many tiles can be fit per line in the current text area
; for example, 11 for a narrow text box and 19 for a wide text box
hTextLineLength:: ; ffb9
	ds $1

; when printing text and no leading control character is specified, whether characters
; $10 to $60 map to the katakana.1bpp font graphics as characters $0 to $50
; (TX_KATAKANA mode), or map to the hiragana.1bpp font graphics (TX_HIRAGANA mode).
; the TX_HIRAGANA and TX_KATAKANA control characters are used to set this address to said
; value. only these two values are admitted, as any other is interpreted as TX_HIRAGANA.
hJapaneseSyllabary:: ; ffba
	ds $1

hffbb:: ; ffbb
	ds $1

; unlike wCurMenuItem, this accounts for the scroll offset (wListScrollOffset)
hCurScrollMenuItem:: ; ffbc
	ds $1

hCurMenuItem:: ; ffbd
	ds $1

hffbe:: ; ffbe
	ds $1

hffbf:: ; ffbf
	ds $1

hffc0:: ; ffc0
	ds $1
