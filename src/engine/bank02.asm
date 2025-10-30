SECTION "Bank 2@43b3", ROMX[$43b3], BANK[$2]

Func_82b6:
	ld a, [wCheckMenuPlayAreaWhichDuelist]
	ld b, a
	ld a, [wCheckMenuPlayAreaWhichLayout]
	cp b
	jr nz, .not_equal

	ld hl, PrizeCardsCoordinateData_YourOrOppPlayArea.player
	call DrawPlayArea_PrizeCards
	ret

.not_equal
	ld hl, PrizeCardsCoordinateData_YourOrOppPlayArea.opponent
	call DrawPlayArea_PrizeCards
	ret
; 0x83cb

SECTION "Bank 2@4587", ROMX[$4587], BANK[$2]

; draws prize cards depending on the turn
; loaded in wCheckMenuPlayAreaWhichDuelist
; input:
; hl = pointer to coordinates
DrawPlayArea_PrizeCards:
	push hl
	call GetDuelInitialPrizesUpperBitsSet
	ld a, [wCheckMenuPlayAreaWhichDuelist]
	ld h, a
	ld l, DUELVARS_PRIZES
	ld a, [hl]

	pop hl
	ld b, 0
	push af
; loop each prize card
.loop
	inc b
	ld a, [wDuelInitialPrizes]
	inc a
	cp b
	jr z, .done

	pop af
	srl a ; right shift prize cards left
	push af
	jr c, .not_taken
	ld a, $e0 ; tile byte for empty slot
	jr .draw
.not_taken
	ld a, [wcc07]
	or a
	jr z, .asm_85b2
	ld a, $f9
	jr .draw
.asm_85b2
	ld a, $dc ; tile byte for card
.draw
	ld e, [hl]
	inc hl
	ld d, [hl]
	inc hl

	push hl
	push bc
	lb hl, $01, $02 ; card tile gfx
	lb bc, 2, 2 ; rectangle size
	call FillRectangle

	ld a, [wConsole]
	cp CONSOLE_CGB
	jr nz, .not_cgb
	ld a, $03 ; blue colour
	lb bc, 2, 2
	lb hl, 0, 0
	call BankswitchVRAM1
	call FillRectangle
	call BankswitchVRAM0
.not_cgb
	pop bc
	pop hl
	jr .loop
.done
	pop af
	ret

PrizeCardsCoordinateData_YourOrOppPlayArea:
; x and y coordinates for player prize cards
.player
	db 2, 1
	db 2, 3
	db 4, 1
	db 4, 3
	db 6, 1
	db 6, 3
; x and y coordinates for opponent prize cards
.opponent
	db 9, 17
	db 9, 15
	db 7, 17
	db 7, 15
	db 5, 17
	db 5, 15

SECTION "Bank 2@4629", ROMX[$4629], BANK[$2]

; calculates bits set up to the number of initial prizes, with upper 2 bits set, i.e:
; 6 prizes: a = %11111111
; 4 prizes: a = %11001111
; 3 prizes: a = %11000111
; 2 prizes: a = %11000011
GetDuelInitialPrizesUpperBitsSet:
	ld a, [wDuelInitialPrizes]
	ld b, $01
.loop
	or a
	jr z, .done
	sla b
	dec a
	jr .loop
.done
	dec b
	ld a, b
	or %11000000
	ld [wDuelInitialPrizesUpperBitsSet], a
	ret
; 0x863e

SECTION "Bank 2@4acb", ROMX[$4acb], BANK[$2]

LoadMenuCursorTile:
	call Set_OBJ_8x8
	ld de, v0Tiles0
	ld hl, MenuCursorGfx
	ld b, 1 tiles
	call SafeCopyDataHLtoDE
	ret

MenuCursorGfx:
	INCBIN "gfx/menu_cursor.2bpp"

; handles menus which support cursor moving in
; all 4 directions using a transition table,
; instead of a simple up/down menu list
HandleMultiDirectionalMenu:
	xor a
	ld [wMenuInputSFX], a

	; get the transition data
	ld hl, wTransitionTablePtr
	ld e, [hl]
	inc hl
	ld d, [hl]
	ld a, [wd0c1]
	ld [wd0d0], a
	ld l, a
	ld h, 7 ; length of each transition table item
	call HtimesL
	add hl, de

; get the transition index related to the directional input
	ldh a, [hDPadHeld]
	or a
	jp z, .check_button
	inc hl
	inc hl
	inc hl

	bit B_PAD_UP, a
	jr z, .else_if_down
	; up
	ld a, [hl]
	jr .process_dpad

.else_if_down
	inc hl
	bit B_PAD_DOWN, a
	jr z, .else_if_right
	; down
	ld a, [hl]
	jr .process_dpad

.else_if_right
	inc hl
	bit B_PAD_RIGHT, a
	jr z, .else_if_left
	; right
	ld a, [hl]
	jr .process_dpad

.else_if_left
	inc hl
	bit B_PAD_LEFT, a
	jr z, .check_button
	; left
	ld a, [hl]

.process_dpad
	ld [wd0c1], a
	cp $8 ; if a >= 0x8
	jr nc, .sfx
	ld b, $1

; this loop equals to
; b = (1 << a)
.make_bitmask_loop
	or a
	jr z, .make_bitmask_done
	sla b
	dec a
	jr .make_bitmask_loop

.make_bitmask_done
; check if the moved cursor refers to an existing item.
	ld a, [wDuelInitialPrizesUpperBitsSet]
	and b
	jr nz, .sfx
	ld a, [wd0d0]
	cp $06
	jr nz, HandleMultiDirectionalMenu

; check if one of the dpad, left or right, is pressed.
; if not, just go back to the start.
	ldh a, [hDPadHeld]
	bit B_PAD_RIGHT, a
	jr nz, .left_or_right
	bit B_PAD_LEFT, a
	jr z, HandleMultiDirectionalMenu

.left_or_right
	; if started with 5 or 6 prize cards
	; can switch sides normally,
	ld a, [wDuelInitialPrizes]
	cp PRIZES_5
	jr nc, .sfx
	; else if it's last card,
	ld a, [wd0c1]
	cp 5
	jr nz, .not_last_card
	; place it at pos 3
	ld a, 3
	ld [wd0c1], a
	jr .ok
.not_last_card
	; otherwise place at pos 2
	ld a, 2
	ld [wd0c1], a

.ok
	ld a, [wDuelInitialPrizes]
	cp PRIZES_3
	jr nc, .handled_cursor_pos
	; in this case can just sub 2 from pos
	ld a, [wd0c1]
	sub 2
	ld [wd0c1], a

.handled_cursor_pos
	ld a, [wd0c1]
	ld [wd0d0], a
	ld b, $1
	jr .make_bitmask_loop

.sfx
	ld a, SFX_01
	ld [wMenuInputSFX], a

	; reset cursor blink
	xor a
	ld [wScrollMenuCursorBlinkCounter], a
.check_button
	ldh a, [hKeysPressed]
	and PAD_A | PAD_B
	jr z, .no_btns
	and PAD_A
	jr nz, .a_btn
; b btn
	ld a, $ff ; cancel
	call PlayAcceptOrDeclineSFX
	scf
	ret
.a_btn
	call .DrawCursor
	ld a, $01
	call PlayAcceptOrDeclineSFX
	ld a, [wd0c1]
	scf
	ret

.no_btns
	ld a, [wMenuInputSFX]
	or a
	jr z, .skip_sfx
	call PlaySFX
.skip_sfx
	ld hl, wScrollMenuCursorBlinkCounter
	ld a, [hl]
	inc [hl]
	and $0f
	ret nz
	bit 4, [hl]
	jr nz, ZeroObjectPositionsWithCopyToggleOn

.DrawCursor:
	call ZeroObjectPositions
	ld hl, wTransitionTablePtr
	ld e, [hl]
	inc hl
	ld d, [hl]
	ld a, [wd0c1]
	ld l, a
	ld h, 7
	call HtimesL
	add hl, de
; hl = [wTransitionTablePtr] + 7 * wd0c1

	ld d, [hl]
	inc hl
	ld e, [hl]
	inc hl
	ld b, [hl]
	ld c, $00 ; cursor tile
	call SetOneObjectAttributes
	or a
	ret

ZeroObjectPositionsWithCopyToggleOn:
	call ZeroObjectPositions
	ld a, $01
	ld [wVBlankOAMCopyToggle], a
	ret
; 0x8be6

SECTION "Bank 2@4e6b", ROMX[$4e6b], BANK[$2]

GlossaryTransitionTable_10Topics:
	cursor_transition $08, $28, $00, 4, 1, 5, 5 ; 0
	cursor_transition $08, $38, $00, 0, 2, 6, 6 ; 1
	cursor_transition $08, $48, $00, 1, 3, 7, 7 ; 2
	cursor_transition $08, $58, $00, 2, 4, 8, 8 ; 3
	cursor_transition $08, $68, $00, 3, 0, 9, 9 ; 4
	cursor_transition $58, $28, $00, 9, 6, 0, 0 ; 5
	cursor_transition $58, $38, $00, 5, 7, 1, 1 ; 6
	cursor_transition $58, $48, $00, 6, 8, 2, 2 ; 7
	cursor_transition $58, $58, $00, 7, 9, 3, 3 ; 8
	cursor_transition $58, $68, $00, 8, 5, 4, 4 ; 9

GlossaryTransitionTable_8Topics:
	cursor_transition $08, $28, $00, 3, 1, 4, 4 ; 0
	cursor_transition $08, $38, $00, 0, 2, 5, 5 ; 1
	cursor_transition $08, $48, $00, 1, 3, 6, 6 ; 2
	cursor_transition $08, $58, $00, 2, 0, 7, 7 ; 3
	cursor_transition $58, $28, $00, 7, 5, 0, 0 ; 4
	cursor_transition $58, $38, $00, 4, 6, 1, 1 ; 5
	cursor_transition $58, $48, $00, 5, 7, 2, 2 ; 6
	cursor_transition $58, $58, $00, 6, 4, 3, 3 ; 7

; copies DECK_SIZE number of cards from de to hl in SRAM
CopyDeckFromSRAM:
	push hl
	call EnableSRAM
	bank1call DecompressSRAMDeck
	call DisableSRAM
	pop hl
	push bc
	ld bc, DECK_SIZE_BYTES
	add hl, bc
	pop bc
	xor a ; terminating byte
	ld [hli], a
	ld [hl], a
	ret

; clears some WRAM addresses to act as
; terminator bytes to wTempCardList and wCurDeckCards
WriteCardListsTerminatorBytes:
	xor a
	ld hl, wTempCardList
	ld bc, $80
	add hl, bc
	ld [hl], a ; terminator byte
	ld hl, wCurDeckCards
	ld bc, $80
	add hl, bc
	ld [hl], a ; terminator byte
	ret

Func_8f10:
	call EnableSRAM
	xor a
	ld hl, sBoosterPacksObtained
	ld [hli], a
	inc a
	ld [hli], a
	ld [hli], a
	ld [hl], a
	ld [s0b7a1], a
	call DisableSRAM
;	fallthrough

EmptyScreenAndLoadFontDuelAndHandCardsIcons:
	xor a
	ld [wTileMapFill], a
	call EmptyScreen
	call ZeroObjectPositions
	ld a, $01
	ld [wVBlankOAMCopyToggle], a
	call LoadSymbolsFont
	call LoadDuelCardSymbolTiles
	farcall LoadHandCardsIcon
	bank1call SetDefaultPalettes
	lb de, $3c, $bf
	call SetupText
	ret

; empties screen, zeroes object positions,
; loads cursor tile, symbol fonts, duel card symbols
; hand card icon and sets default palettes
PrepareMenuGraphics:
	xor a
	ld [wTileMapFill], a
	call EmptyScreen
	call ZeroObjectPositions
	ld a, $1
	ld [wVBlankOAMCopyToggle], a
	call LoadMenuCursorTile
	call LoadSymbolsFont
	call LoadDuelCardSymbolTiles
	farcall LoadHandCardsIcon
	bank1call SetDefaultPalettes
	lb de, $3c, $bf
	call SetupText
	ret
; 0x8f6b

SECTION "Bank 2@4fb9", ROMX[$4fb9], BANK[$2]

Func_8fb9:
	ldh a, [hDPadHeld]
	and PAD_START
	ret z
	ld a, [wCurMenuItem]
	ld [wCurDeck], a
	call CheckIfCurDeckIsEmpty
	jp nc, .valid_deck ; can be jr
	ld a, $ff
	call PlayAcceptOrDeclineSFX
	call Func_9215
	scf
	ret

.valid_deck
	ld a, SFX_01
	call PlayAcceptOrDeclineSFX
	call GetSRAMPointerToCurDeckCards
	push hl
	call GetSRAMPointerToCurDeck
	pop de
	call OpenDeckConfirmationMenu
	ld a, $ff ; all decks
	call DrawDeckSelectionMenu
	ld a, [wCurDeck]
	scf
	ret

OpenDeckConfirmationMenu:
; copy deck name
	push de
	ld de, wCurDeckName
	call CopyListFromHLToDEInSRAM
	pop de

; copy deck cards
	ld hl, wCurDeckCards
	call CopyDeckFromSRAM

	ld a, NUM_FILTERS
	ld hl, wCardFilterCounts
	call ClearNBytesFromHL
	ld a, DECK_SIZE
	ld [wTotalCardCount], a
	ld [wd381], a
	ld hl, wCardFilterCounts
	ld [hl], a
	call HandleDeckConfirmationMenu
	ret
; 0x9014

SECTION "Bank 2@5215", ROMX[$5215], BANK[$2]

Func_9215:
	ldtx hl, ThereIsNoDeckHereText
	call DrawWideTextBox_WaitForInput
	ld a, [wCurDeck]
	ret

; returns carry if deck in wCurDeck is empty
CheckIfCurDeckIsEmpty:
	ld a, [wCurDeck]
	ld hl, wDecksValid
	ld b, $00
	ld c, a
	add hl, bc
	ld a, [hl]
	or a
	ret nz
	scf
	ret
; 0x922e

SECTION "Bank 2@5265", ROMX[$5265], BANK[$2]

GetSRAMPointerToCurDeck:
	ld a, [wCurDeck]
	ld h, a
	ld l, DECK_COMPRESSED_STRUCT_SIZE
	call HtimesL
	push de
	ld de, sDeck1
	add hl, de
	pop de
	ret

GetSRAMPointerToCurDeckCards:
	push af
	ld a, [wCurDeck]
	ld h, a
	ld l, DECK_COMPRESSED_STRUCT_SIZE
	call HtimesL
	push de
	ld de, sDeck1Cards
	add hl, de
	pop de
	pop af
	ret
; 0x9287

SECTION "Bank 2@5328", ROMX[$5328], BANK[$2]

; play different sfx by a.
; if a is 0xff play SFX_03 (usually following a B press),
; else play SFX_02 (usually following an A press).
PlayAcceptOrDeclineSFX:
	push af
	inc a
	jr z, .cancel
	ld a, SFX_02
	jr .play_sfx
.cancel
	ld a, SFX_03
.play_sfx
	call PlaySFX
	pop af
	ret
; 0x9337

SECTION "Bank 2@53bd", ROMX[$53bd], BANK[$2]

DrawDeckSelectionMenu:
	ld [hffbf], a

	call EmptyScreenAndLoadFontDuelAndHandCardsIcons

	; draw deck boxes
	lb de,  0, 0
	lb bc, 20, 4
	call DrawRegularTextBox
	lb de,  0, 3
	lb bc, 20, 4
	call DrawRegularTextBox
	lb de,  0, 6
	lb bc, 20, 4
	call DrawRegularTextBox
	lb de,  0, 9
	lb bc, 20, 4
	call DrawRegularTextBox

	; draw numbering text
	ld hl, .text_items
	call PlaceTextItems

	ld a, NUM_DECKS + 1
	ld hl, wDecksValid
	call ClearNBytesFromHL

; for each deck, check if it has cards and if so
; mark is as valid in wDecksValid

	ld a, [hffbf]
	bit DECK_1_F, a
	jr z, .skip_name_1
	ld hl, sDeck1
	lb de, 6, 2
	call PrintDeckName
.skip_name_1
	ld hl, sDeck1
	call CheckIfDeckHasCards
	jr c, .check_deck_2
	ld a, TRUE
	ld [wDeck1Valid], a

.check_deck_2
	ld a, [hffbf]
	bit DECK_2_F, a
	jr z, .skip_name_2
	ld hl, sDeck2
	lb de, 6, 5
	call PrintDeckName
.skip_name_2
	ld hl, sDeck2
	call CheckIfDeckHasCards
	jr c, .check_deck_3
	ld a, TRUE
	ld [wDeck2Valid], a

.check_deck_3
	ld a, [hffbf]
	bit DECK_3_F, a
	jr z, .skip_name_3
	ld hl, sDeck3
	lb de, 6, 8
	call PrintDeckName
.skip_name_3
	ld hl, sDeck3
	call CheckIfDeckHasCards
	jr c, .check_deck_4
	ld a, TRUE
	ld [wDeck3Valid], a

.check_deck_4
	ld a, [hffbf]
	bit DECK_4_F, a
	jr z, .skip_name_4
	ld hl, sDeck4
	lb de, 6, 11
	call PrintDeckName
.skip_name_4
	ld hl, sDeck4
	call CheckIfDeckHasCards
	jr c, .place_cursor
	ld a, TRUE
	ld [wDeck4Valid], a

.place_cursor
; places cursor on sCurrentlySelectedDeck
; if it's an empty deck, then advance the cursor
; until it's selecting a valid deck
	call EnableSRAM
	ld a, [sCurrentlySelectedDeck]
	ld c, a
	ld b, 0
	ld d, 2
.loop_decks
	ld hl, wDecksValid
	add hl, bc
	ld a, [hl]
	or a
	jr nz, .valid_deck
	; invalid deck
	inc c
	ld a, NUM_DECKS
	cp c
	jr nz, .loop_decks
	ld c, 0 ; wrap back to deck 1
	dec d
	jr z, .valid_deck
	jr .loop_decks

.valid_deck
	ld a, c
	ld [sCurrentlySelectedDeck], a

	call DisableSRAM
	call DrawHandCardsTileOnCurDeck
	call EnableLCD
	ret

.text_items
	textitem 4,  2, Deck1Text ; "1・"
	textitem 4,  5, Deck2Text ; "2・"
	textitem 4,  8, Deck3Text ; "3・"
	textitem 4, 11, Deck4Text ; "4・"
	db $ff

CopyDeckName:
	ld de, wDefaultText
	call CopyListFromHLToDE
	ld hl, wDefaultText
	call GetTextLengthInTiles
	ld b, $00
	ld hl, wDefaultText
	add hl, bc
	ld d, h
	ld e, l
	ld hl, DeckNameSuffix
	call CopyListFromHLToDE
	ret

; prints deck name given in hl in position de
; if it's an empty deck, print "NEW DECK" instead
; returns carry if it's an empty deck
; hl = deck name (sDeck1Name ~ sDeck4Name)
; de = coordinates to print text
PrintDeckName:
	push hl
	call CheckIfDeckHasCards
	pop hl
	jr c, .empty_deck

	; valid deck, get its name
	push de
	ld de, wDefaultText
	call CopyListFromHLToDEInSRAM
	ld hl, wDefaultText
	call GetTextLengthInTiles
	ld b, $00
	ld hl, wDefaultText
	add hl, bc
	ld d, h
	ld e, l
	ld hl, DeckNameSuffix
	call CopyListFromHLToDE
	pop de
	ld hl, wDefaultText
	call InitTextPrinting
	call ProcessText
	or a
	ret

.empty_deck
	call InitTextPrinting
	ldtx hl, NewDeckText
	call ProcessTextFromID
	scf
	ret

DeckNameSuffix:
	katakana "デ"
	katakana "ッ"
	katakana "キ"
	done

SECTION "Bank 2@5503", ROMX[$5503], BANK[$2]

CopyListFromHLToDE:
.loop
	ld a, [hli]
	ld [de], a
	or a
	ret z ; TX_END
	inc de
	jr .loop

; same as CopyListFromHLToDE, but for SRAM copying
CopyListFromHLToDEInSRAM:
	call EnableSRAM
	call CopyListFromHLToDE
	call DisableSRAM
	ret

; appends text in hl to wDefaultText
; then adds "deck" to the end
; returns carry if deck has no cards
; hl = text to append
; de = input to InitTextPrinting
AppendDeckName:
	push hl
	call CheckIfDeckHasCards
	pop hl
	ret c ; no cards

	push de
	; append the text from hl
	ld de, wDefaultText
	call CopyListFromHLToDEInSRAM

	; get string length (up to DECK_NAME_SIZE_WO_SUFFIX)
	ld hl, wDefaultText
	ld a, [hl]
	cp TX_HALFWIDTH
	jr z, .halfwidth
	call GetTextLengthInTiles
	ld a, c
	cp DECK_NAME_SIZE_WO_SUFFIX
	jr c, .got_len
	ld c, DECK_NAME_SIZE_WO_SUFFIX
.got_len
	ld b, $0
	ld hl, wDefaultText
	add hl, bc
	ld d, h
	ld e, l
	; append "deck" starting from the given length
	ld hl, .text_start
	ld b, .text_end - .text_start
	call CopyBBytesFromHLToDE_Bank02
	xor a ; TX_END
	ld [wDefaultText + DECK_NAME_SIZE + 2], a
	pop de
	ld hl, wDefaultText
	call InitTextPrinting
	call ProcessText
	or a
	ret

.halfwidth
	call GetTextLengthInTiles
	ld a, c
	cp DECK_NAME_SIZE_WO_SUFFIX + 1
	jr c, .asm_955d
	ld c, DECK_NAME_SIZE_WO_SUFFIX + 1
.asm_955d
	ld b, $00
	ld hl, wDefaultText
	add hl, bc
	ld d, h
	ld e, l
	ld hl, .text_start
	ld b, .text_end - .text_start + 1
	call CopyBBytesFromHLToDE_Bank02
	ld hl, wDefaultText + (.text_end - .text_start + 1)
	ld a, [hl]
	or a
	jr nz, .asm_9575
	dec hl
.asm_9575
	xor a
	ld [hl], a
	pop de
	ld hl, wDefaultText
	call InitTextPrinting
	call ProcessText
	or a
	ret

.text_start
	katakana "デ"
	katakana "ッ"
	katakana "キ"
	db "<SPACE><SPACE><SPACE><SPACE><SPACE><SPACE><SPACE><SPACE><SPACE><SPACE>"
.text_end

; returns carry if the deck in hl
; is not valid, that is, has no cards
; alternatively, the direct address of the cards
; can be used, since DECK_SIZE > DECK_NAME_SIZE
; hl = deck name (sDeck1Name ~ sDeck4Name)
;   or deck cards (sDeck1Cards ~ sDeck4Cards)
CheckIfDeckHasCards:
	ld bc, DECK_NAME_SIZE
	add hl, bc
	push de
	ld d, h
	ld e, l
	ld hl, wTempSavedDeckCards
	call CopyDeckFromSRAM
	; first card being invalid means empty deck
	ld hl, wTempSavedDeckCards
	ld e, [hl]
	inc hl
	ld d, [hl]
	call CheckIfCardIDIsZero
	pop de
	ret c
	or a
	ret

; calculates the y coordinate of the currently selected deck
; and draws the hands card tile at that position
DrawHandCardsTileOnCurDeck:
	call EnableSRAM
	ld a, [sCurrentlySelectedDeck]
	call DisableSRAM
	ld h, 3
	ld l, a
	call HtimesL
	ld e, l
	inc e ; (sCurrentlySelectedDeck * 3) + 1
	ld d, 2
;	fallthrough

; de = coordinates to draw rectangle
DrawHandCardsTileAtDE:
	ld a, $38 ; hand cards tile
	lb hl, 1, 2
	lb bc, 2, 2
	call FillRectangle
	ret
; 0x95d6

SECTION "Bank 2@5a31", ROMX[$5a31], BANK[$2]

FiltersCardSelectionParams:
	db 1 ; x pos
	db 1 ; y pos
	db 0 ; y spacing
	db 2 ; x spacing
	db NUM_FILTERS ; num entries
	db SYM_CURSOR_D ; visible cursor tile
	db SYM_SPACE ; invisible cursor tile
	dw NULL ; wCardListHandlerFunction

SECTION "Bank 2@5a8e", ROMX[$5a8e], BANK[$2]

; fills one line at coordinate bc in BG Map
; with the byte in register a
; fills the same line with $01 in VRAM1 if in CGB
; bc = coordinates
FillBGMapLineWithA:
	call BCCoordToBGMap0Address
	ld b, SCREEN_WIDTH
	call WriteBBytesToDE
	ld a, [wConsole]
	cp CONSOLE_CGB
	ret nz ; not cgb
	ld a, $01 ; attributes
	ld b, SCREEN_WIDTH
	call BankswitchVRAM1
	call WriteBBytesToDE
	call BankswitchVRAM0
	ret
; 0x9aaa

SECTION "Bank 2@5abb", ROMX[$5abb], BANK[$2]

; a = byte to write
; b = number of bytes
; de = target address
WriteBBytesToDE:
	push hl
	ld l, e
	ld h, d
.loop
	ld [hli], a
	dec b
	jr nz, .loop
	pop hl
	ret

; draws all the card type icons
; in a line specified by .CardTypeIcons
DrawCardTypeIcons:
	ld hl, .CardTypeIcons
.loop
	ld a, [hli]
	or a
	ret z ; done
	ld d, [hl] ; x coord
	inc hl
	ld e, [hl] ; y coord
	inc hl
	call .DrawIcon
	jr .loop

; input:
; de = coordinates
.DrawIcon:
	push hl
	push af
	lb hl, 1, 2
	lb bc, 2, 2
	call FillRectangle
	pop af
	call GetCardTypeIconPalette
	ld b, a
	ld a, [wConsole]
	cp CONSOLE_CGB
	jr nz, .not_cgb
	ld a, b
	lb bc, 2, 2
	lb hl, 0, 0
	call BankswitchVRAM1
	call FillRectangle
	call BankswitchVRAM0
.not_cgb
	pop hl
	ret

.CardTypeIcons:
; icon tile, x coord, y coord
	db ICON_TILE_GRASS,      1, 2
	db ICON_TILE_FIRE,       3, 2
	db ICON_TILE_WATER,      5, 2
	db ICON_TILE_LIGHTNING,  7, 2
	db ICON_TILE_FIGHTING,   9, 2
	db ICON_TILE_PSYCHIC,   11, 2
	db ICON_TILE_COLORLESS, 13, 2
	db ICON_TILE_TRAINER,   15, 2
	db ICON_TILE_ENERGY,    17, 2
	db $00
; 0x9b18

SECTION "Bank 2@5b31", ROMX[$5b31], BANK[$2]

; prints "/60" to the coordinates given in de
PrintSlashSixty:
	ld hl, wDefaultText
	ld a, TX_SYMBOL
	ld [hli], a
	ld a, SYM_SLASH
	ld [hli], a
	ld a, [wd381]
	call ConvertToNumericalDigits
	ld [hl], TX_END
	call InitTextPrinting
	ld hl, wDefaultText
	call ProcessText
	ret

; creates two separate lists given the card type in register a
; if a card matches the card type given, then it's added to wTempCardList
; if a card has been owned by the player, and its card count is at least 1,
; (or in case it's 0 if it's in any deck configurations saved)
; then its collection count is also added to wTempCardList
; if input a is $ff, then all card types are included
CreateFilteredCardList:
	push af
	push bc
	push de
	push hl

; clear wOwnedCardsCountList and wTempCardList
	push af
	ld a, $51
	ld hl, wOwnedCardsCountList
	call ClearNBytesFromHL
	ld a, $a0
	ld hl, wTempCardList
	call ClearNBytesFromHL
	pop af

; loops all cards in collection
	ld hl, $0
	ld de, 0
	ld b, a ; input card type
.loop_card_ids
	inc de
	call GetCardType
	jr c, .store_count
	ld c, a
	ld a, b
	cp $ff
	jr z, .add_card
	and FILTER_ENERGY
	cp FILTER_ENERGY
	jr z, .check_energy
	ld a, c
	cp b
	jr nz, .loop_card_ids
	jr .add_card
.check_energy
	ld a, c
	and TYPE_ENERGY
	cp TYPE_ENERGY
	jr nz, .loop_card_ids

.add_card
	push bc
	push hl
	add hl, hl
	ld bc, wTempCardList
	add hl, bc
	ld [hl], e
	inc hl
	ld [hl], d
	ld hl, wTempCardCollection
	add hl, de
	ld a, [hl]
	pop hl
	cp CARD_NOT_OWNED
	jr z, .next_card ; jump if never seen card
	or a
	jr nz, .ok ; has at least 1
	call .IsCardInAnyDeck
	jr c, .next_card ; jump if not in any deck
.ok
	push af
	cp16 BILLS_COMPUTER
	jr nz, .asm_9bb8
	ld a, [wd121]
	or a
	jr nz, .asm_9bb8
	pop af
	jr .next_card
.asm_9bb8
	pop af

	push hl
	ld bc, wOwnedCardsCountList
	add hl, bc
	ld [hl], a
	pop hl
	inc l
.next_card
	pop bc
	jr .loop_card_ids

.store_count
	ld a, l
	ld [wNumEntriesInCurFilter], a
; add terminator bytes in both lists
	ld c, l
	ld b, h
	ld a, $ff
	ld hl, wOwnedCardsCountList
	add hl, bc
	ld [hl], a ; $ff
	ld hl, wTempCardList
	add hl, bc
	add hl, bc
	xor a
	ld [hli], a ; $00
	ld [hl], a
	pop hl
	pop de
	pop bc
	pop af
	ret

; returns carry if card ID in register e is not
; found in any of the decks saved in SRAM
.IsCardInAnyDeck:
	push af
	push hl
	ld hl, sDeck1Cards
	call .FindCardInDeck
	jr nc, .found_card
	ld hl, sDeck2Cards
	call .FindCardInDeck
	jr nc, .found_card
	ld hl, sDeck3Cards
	call .FindCardInDeck
	jr nc, .found_card
	ld hl, sDeck4Cards
	call .FindCardInDeck
	jr nc, .found_card
	pop hl
	pop af
	scf
	ret
.found_card
	pop hl
	pop af
	or a
	ret

; returns carry if input card ID in de
; is not found in deck given by hl
.FindCardInDeck:
	push de
	ld d, h
	ld e, l
	ld hl, wTempSavedDeckCards
	call CopyDeckFromSRAM

	ld hl, wTempSavedDeckCards
	pop de
	ld b, DECK_SIZE
.loop
	ld a, [hli]
	cp e
	ld a, [hli]
	jr nz, .not_equal
	cp d
	jr z, .not_found_in_deck
.not_equal
	dec b
	jr nz, .loop
	scf
	ret
.not_found_in_deck
	or a
	ret

; preserves all registers
; hl = start of bytes to set to $0
; a = number of bytes to set to $0
ClearNBytesFromHL:
	push af
	push bc
	push hl
	ld b, a
	xor a
.loop
	ld [hli], a
	dec b
	jr nz, .loop
	pop hl
	pop bc
	pop af
	ret

; returns the number of times that card de
; appears in wCurDeckCards
GetCountOfCardInCurDeck:
	push hl
	push bc
	ld hl, wCurDeckCards
	ld b, 0
.loop
	push de
	ld e, [hl]
	inc hl
	ld d, [hl]
	inc hl
	call CheckIfCardIDIsZero
	ld c, e
	ld a, d
	pop de
	jr c, .zero ; not found
	; is valid ID, compare card ID
	cp d
	jr nz, .loop
	ld a, c
	cp e
	jr nz, .loop
	inc b
	jr .loop

.zero
	ld a, b
	pop bc
	pop hl
	ret

Func_9c55:
	push hl
	push bc
	ld hl, wBoosterPackCardList
	ld b, -1
.loop
	inc b
	push de
	ld e, [hl]
	inc hl
	ld d, [hl]
	inc hl
	call CheckIfCardIDIsZero
	ld c, e
	ld a, d
	pop de
	jr c, .zero ; not found
	; is valid ID, compare card ID
	cp d
	jr nz, .loop
	ld a, c
	cp e
	jr nz, .loop
	; has same card ID, get its count
	ld hl, wBoosterPackCardCounts
	ld c, b
	ld b, $00
	add hl, bc
	ld a, [hl]
	pop bc
	pop hl
	ret

.zero
	xor a
	pop bc
	pop hl
	ret
; 0x9c80

SECTION "Bank 2@5ca6", ROMX[$5ca6], BANK[$2]

; determines the ones and tens digits in a for printing
; the ones place is added $20 (SYM_0) so that it maps to a numerical character
; if the tens is 0, it maps to an empty character
; a = value to calculate digits
CalculateOnesAndTensDigits:
	push af
	push bc
	push de
	push hl
	ld c, -1
.loop_sub
	inc c
	sub 10
	jr nc, .loop_sub
	jr z, .got_result
	add 10
.got_result
	add SYM_0
	ld hl, wDecimalDigitsSymbols
	ld [hli], a ; ones place
	ld a, c
	or a
	jr z, .below_10
	add SYM_0
.below_10
	ld [hl], a ; tens place
	pop hl
	pop de
	pop bc
	pop af
	ret

; converts value in register a to
; numerical symbols for ProcessText
; places the symbols in hl
ConvertToNumericalDigits:
	call CalculateOnesAndTensDigits
	push hl
	ld hl, wDecimalDigitsSymbols
	ld a, [hli]
	ld b, a
	ld a, [hl]
	pop hl
	ld [hl], TX_SYMBOL
	inc hl
	ld [hli], a
	ld [hl], TX_SYMBOL
	inc hl
	ld a, b
	ld [hli], a
	ret
; 0x9cdc

SECTION "Bank 2@5d1a", ROMX[$5d1a], BANK[$2]

; prints the card count of each individual card type
; assumes CountNumberOfCardsForEachCardType was already called
; this is done by processing text in a single line
; and concatenating all digits
PrintCardTypeCounts:
	ld bc, $0
	ld hl, wDefaultText
.loop
	push hl
	ld hl, wCardFilterCounts
	add hl, bc
	ld a, [hl]
	pop hl
	push bc
	call ConvertToNumericalDigits
	pop bc
	inc c
	ld a, NUM_FILTERS
	cp c
	jr nz, .loop
	ld [hl], TX_END
	lb de, 1, 4
	call InitTextPrinting
	ld hl, wDefaultText
	call ProcessText
	ret
; 0x9d41

SECTION "Bank 2@5d8c", ROMX[$5d8c], BANK[$2]

; used to filter the cards in the deck building/card selection screen
CardTypeFilters:
	db FILTER_GRASS
	db FILTER_FIRE
	db FILTER_WATER
	db FILTER_LIGHTNING
	db FILTER_FIGHTING
	db FILTER_PSYCHIC
	db FILTER_COLORLESS
	db FILTER_TRAINER
	db FILTER_ENERGY
	db -1 ; end of list

; counts all the cards from each card type
; (stored in wCardFilterCounts) and store it in wTotalCardCount
; also prints it in coordinates de
PrintTotalCardCount:
	push de
	ld bc, $0
	ld hl, wCardFilterCounts
.loop
	ld a, [hli]
	add b
	ld b, a
	inc c
	ld a, NUM_FILTERS
	cp c
	jr nz, .loop
	ld hl, wDefaultText
	ld a, b
	ld [wTotalCardCount], a
	push bc
	call ConvertToNumericalDigits
	pop bc
	ld [hl], TX_END
	pop de
	call InitTextPrinting
	ld hl, wDefaultText
	call ProcessText
	ret
; 0x9dbf

SECTION "Bank 2@5e48", ROMX[$5e48], BANK[$2]

Text_9e48:
	db "<SPACE>"
	db "<SPACE>"
	db "<SPACE>"
	db "<SPACE>"
	db "<SPACE>"
	db "<SPACE>"
	db "<SPACE>"
	db "<SPACE>"
	db "<SPACE>"
	db "<SPACE>"
	db "<SPACE>"
	db "<SPACE>"
	db "<SPACE>"
	db "<SPACE>"
	db "<SPACE>"
	db "<SPACE>"
	db "<SPACE>"
	db "<SPACE>"
	db "<SPACE>"
	db "<SPACE>"
	done

; returns carry if card ID in de is $0000
; de = card ID
CheckIfCardIDIsZero:
	push af
	xor a
	cp d
	jr nz, .false
	cp e
	jr nz, .false
	pop af
	scf
	ret
.false
	pop af
	or a
	ret

; writes the card ID in register de to wVisibleListCardIDs
; given its position in the list in register b
; input:
; b = list position (starts from bottom)
; de = card ID
AddCardIDToVisibleList:
	push af
	push bc
	push hl
	ld hl, wVisibleListCardIDs
	ld c, b
	ld a, [wNumVisibleCardListEntries]
	sub c
	; a = wNumVisibleCardListEntries - b
	add a ; *2
	ld c, a
	ld b, $00
	add hl, bc
	ld [hl], e
	inc hl
	ld [hl], d
	pop hl
	pop bc
	pop af
	ret

; initializes parameters for a menu, given the 8 bytes starting at hl,
; which are loaded to the following addresses:
;	wMenuCursorXOffset, wMenuCursorYOffset, wMenuYSeparation, wNumMenuItems,
;	wMenuVisibleCursorTile, wMenuInvisibleCursorTile, wMenuUpdateFunc.
; also sets the current menu item (wCurScrollMenuItem) to the one specified in register a.
InitializeScrollMenuParameters:
	ld [wCurScrollMenuItem], a
	ld [hCurMenuItem], a
	ld de, wMenuParams
	ld b, wMenuParamsEnd - wMenuParams
.loop
	ld a, [hli]
	ld [de], a
	inc de
	dec b
	jr nz, .loop
	xor a
	ld [wScrollMenuCursorBlinkCounter], a
	ret

DeckMachineSelectionParams:
	db 1 ; x pos
	db 2 ; y pos
	db 2 ; y spacing
	db 0 ; x spacing
	db 5 ; num entries
	db SYM_CURSOR_R ; visible cursor tile
	db SYM_SPACE ; invisible cursor tile
	dw NULL ; wCardListHandlerFunction
; 0x9eb5

SECTION "Bank 2@5ebe", ROMX[$5ebe], BANK[$2]

HandleCardSelectionInput:
	xor a ; FALSE
	ld [wMenuInputSFX], a
	ldh a, [hDPadHeld]
	or a
	jr z, .handle_ab_btns

; handle d-pad
	ld b, a
	ld a, [wNumMenuItems]
	ld c, a
	ld a, [wCurScrollMenuItem]
	bit B_PAD_LEFT, b
	jr z, .check_d_right
	dec a
	bit 7, a
	jr z, .got_cursor_pos
	; if underflow, set to max cursor pos
	ld a, [wNumMenuItems]
	dec a
	jr .got_cursor_pos
.check_d_right
	bit B_PAD_RIGHT, b
	jr z, .handle_ab_btns
	inc a
	cp c
	jr c, .got_cursor_pos
	; if over max pos, set to pos 0
	xor a
.got_cursor_pos
	push af
	ld a, TRUE
	ld [wMenuInputSFX], a
	call DrawHorizontalListCursor_Invisible
	pop af
	ld [wCurScrollMenuItem], a
	xor a
	ld [wScrollMenuCursorBlinkCounter], a

.handle_ab_btns
	ld a, [wCurScrollMenuItem]
	ld [hCurMenuItem], a
	ldh a, [hKeysPressed]
	and PAD_A | PAD_B
	jr z, HandleCardSelectionCursorBlink
	and PAD_A
	jr nz, ConfirmSelectionAndReturnCarry
	; b button
	ld a, $ff
	ld [hCurMenuItem], a
	call PlayAcceptOrDeclineSFX
	scf
	ret

; outputs cursor position in e and selection in a
ConfirmSelectionAndReturnCarry:
	call DrawHorizontalListCursor_Visible
	ld a, $01
	call PlayAcceptOrDeclineSFX
	ld a, [wCurScrollMenuItem]
	ld e, a
	ld a, [hCurMenuItem]
	scf
	ret

HandleCardSelectionCursorBlink:
	ld a, [wMenuInputSFX]
	or a
	jr z, .skip_sfx
	call PlaySFX
.skip_sfx
	ld hl, wScrollMenuCursorBlinkCounter
	ld a, [hl]
	inc [hl]
	and $0f
	ret nz
	ld a, [wMenuVisibleCursorTile]
	bit 4, [hl]
	jr z, DrawHorizontalListCursor

DrawHorizontalListCursor_Invisible:
	ld a, [wMenuInvisibleCursorTile]
;	fallthrough

; like DrawListCursor but only
; for lists with one line, and each entry
; being laid horizontally
; a = tile to write
DrawHorizontalListCursor:
	ld e, a
	ld a, [wMenuXSeparation]
	ld l, a
	ld a, [wCurScrollMenuItem]
	ld h, a
	call HtimesL
	ld a, l
	ld hl, wMenuCursorXOffset
	add [hl]
	ld b, a ; x coord
	ld hl, wMenuCursorYOffset
	ld a, [hl]
	ld c, a ; y coord
	ld a, e
	call WriteByteToBGMap0
	or a
	ret

DrawHorizontalListCursor_Visible:
	ld a, [wMenuVisibleCursorTile]
	jr DrawHorizontalListCursor

; handles user input when selecting cards to add
; to deck configuration
; returns carry if a selection was made
; (either selected card or cancelled)
; outputs in a the list index if selection was made
; or $ff if operation was cancelled
HandleScrollListInput:
	xor a ; FALSE
	ld [wMenuInputSFX], a
	ldh a, [hDPadHeld]
	or a
	jp z, .asm_9ff4
	ld b, a
	ld a, [wNumMenuItems]
	ld c, a
	ld a, [wCurScrollMenuItem]
	bit B_PAD_UP, b
	jr z, .check_d_down
; d_up
	push af
	ld a, SFX_01
	ld [wMenuInputSFX], a
	pop af
	dec a
	bit 7, a
	jr z, .done_scroll
	ld a, [wScrollMenuScrollOffset]
	or a
	jr z, .already_at_top
	dec a
	ld [wScrollMenuScrollOffset], a
	ld hl, wScrollMenuScrollFunc
	call CallIndirect
	xor a
	jr .done_scroll
.already_at_top
	xor a
	ld [wMenuInputSFX], a
	jr .done_scroll

.check_d_down
	bit B_PAD_DOWN, b
	jr z, .asm_9fd8
; d_down
	push af
	ld a, SFX_01
	ld [wMenuInputSFX], a
	pop af
	inc a
	cp c
	jr c, .done_scroll
	push af
	ld a, [wUnableToScrollDown]
	or a
	jr nz, .already_at_bottom
	ld a, [wScrollMenuScrollOffset]
	inc a
	ld [wScrollMenuScrollOffset], a
	ld hl, wScrollMenuScrollFunc
	call CallIndirect
	pop af
	dec a
	jr .done_scroll
.already_at_bottom
	pop af
	dec a
	push af
	xor a
	ld [wMenuInputSFX], a
	pop af

.done_scroll
	push af
	call DrawListCursor_Invisible
	pop af
	ld [wCurScrollMenuItem], a
	xor a
	ld [wScrollMenuCursorBlinkCounter], a
	jr .asm_9ff4

.asm_9fd8
	ld a, [wd119]
	or a
	jr z, .asm_9ff4
	bit B_PAD_LEFT, b
	jr z, .asm_9fea
	call GetSelectedVisibleCardID
	call RemoveCardFromDeckAndUpdateCount
	jr .asm_9ff4
.asm_9fea
	bit B_PAD_RIGHT, b
	jr z, .asm_9ff4
	call GetSelectedVisibleCardID
	call AddCardToDeckAndUpdateCount

.asm_9ff4
	ld a, [wCurScrollMenuItem]
	ld [hCurMenuItem], a
	ld hl, wMenuUpdateFunc
	ld a, [hli]
	or [hl]
	jr z, .null
	ld a, [hld]
	ld l, [hl]
	ld h, a
	ld a, [hCurMenuItem]
	call CallHL
	jr nc, .blink_cursor
.selected
	call DrawListCursor_Visible
	ld a, $01
	call PlayAcceptOrDeclineSFX
	ld a, [wCurScrollMenuItem]
	ld e, a
	ld a, [hCurMenuItem]
	scf
	ret

.null
	ldh a, [hKeysPressed]
	and PAD_A | PAD_B
	jr z, .check_sfx
	and PAD_A
	jr nz, .selected
	ld a, $ff
	ld [hCurMenuItem], a
	call PlayAcceptOrDeclineSFX
	scf
	ret

.check_sfx
	ld a, [wMenuInputSFX]
	or a
	jr z, .blink_cursor
	call PlaySFX

.blink_cursor
	ld hl, wScrollMenuCursorBlinkCounter
	ld a, [hl]
	inc [hl]
	and %1111
	ret nz
	ld a, [wMenuVisibleCursorTile]
	bit 4, [hl]
	jr z, DrawListCursor

DrawListCursor_Invisible:
	ld a, [wMenuInvisibleCursorTile]
;	fallthrough

; draws cursor considering wCurScrollMenuItem
; spaces each entry horizontally by wCardListXSpacing
; and vertically by wCardListYSpacing
; a = tile to write
DrawListCursor:
	ld e, a
	ld a, [wMenuXSeparation]
	ld l, a
	ld a, [wCurScrollMenuItem]
	ld h, a
	call HtimesL
	ld a, l
	ld hl, wMenuCursorXOffset
	add [hl]
	ld b, a ; x coord
	ld a, [wMenuYSeparation]
	ld l, a
	ld a, [wCurScrollMenuItem]
	ld h, a
	call HtimesL
	ld a, l
	ld hl, wMenuCursorYOffset
	add [hl]
	ld c, a ; y coord
	ld a, e
	call WriteByteToBGMap0
	or a
	ret

DrawListCursor_Visible:
	ld a, [wMenuVisibleCursorTile]
	jr DrawListCursor

OpenCardPageFromCardList:
; get the card index that is selected
; and open its card page
	ld hl, wCurCardListPtr
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, [wCurScrollMenuItem]
	add a ; *2
	ld c, a
	ld b, $0
	add hl, bc
	ld a, [wScrollMenuScrollOffset]
	add a ; *2
	ld c, a
	ld b, $0
	add hl, bc
	ld e, [hl]
	inc hl
	ld d, [hl]
	push de
	call LoadCardDataToBuffer1_FromCardID
	lb de, $38, $9f
	call SetupText
	bank1call OpenCardPage_FromCheckHandOrDiscardPile
	pop de

.handle_input
	ldh a, [hDPadHeld]
	ld b, a
	and PAD_A | PAD_B | PAD_SELECT | PAD_START
	jp nz, .exit

; check d-pad
; if UP or DOWN is pressed, change the
; card that is being shown, given the
; order in the current card list
	xor a ; FALSE
	ld [wMenuInputSFX], a
	ld a, [wNumMenuItems]
	ld c, a
	ld a, [wCurScrollMenuItem]
	bit B_PAD_UP, b
	jr z, .check_d_down
	push af
	ld a, TRUE
	ld [wMenuInputSFX], a
	pop af
	dec a
	bit 7, a
	jr z, .reopen_card_page
	ld a, [wScrollMenuScrollOffset]
	or a
	jr z, .handle_regular_card_page_input
	dec a
	ld [wScrollMenuScrollOffset], a
	xor a
	jr .reopen_card_page

.check_d_down
	bit B_PAD_DOWN, b
	jr z, .handle_regular_card_page_input
	push af
	ld a, TRUE
	ld [wMenuInputSFX], a
	pop af
	inc a
	cp c
	jr c, .reopen_card_page
	push af
	ld hl, wCurCardListPtr
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, [wCurScrollMenuItem]
	add a ; *2
	ld c, a
	ld b, $0
	add hl, bc
	ld a, [wScrollMenuScrollOffset]
	inc a
	add a ; *2
	ld c, a
	ld b, $0
	add hl, bc
	push de
	ld e, [hl]
	inc hl
	ld d, [hl]
	call CheckIfCardIDIsZero
	pop de
	jr c, .skip_change_card
	ld a, [wScrollMenuScrollOffset]
	inc a
	ld [wScrollMenuScrollOffset], a
	pop af
	dec a
.reopen_card_page
	ld [wCurScrollMenuItem], a
	ld a, [wMenuInputSFX]
	or a
	jp z, OpenCardPageFromCardList
	call PlaySFX
	jp OpenCardPageFromCardList

.skip_change_card
	pop af
	jr .handle_regular_card_page_input ; unnecessary jr
.handle_regular_card_page_input
	push de
	bank1call OpenCardPage.loop_input
	pop de
	jp .handle_input

.exit
	ld a, $1
	ld [wVBlankOAMCopyToggle], a
	ld a, [wCurScrollMenuItem]
	ld [wTempCurMenuItem], a
	ret
; 0xa132

SECTION "Bank 2@6152", ROMX[$6152], BANK[$2]

; adds card in register de to deck configuration
; and updates the values shown for its count
; in the card selection list
; input:
; de = card ID
AddCardToDeckAndUpdateCount:
	call .TryAddCardToDeck
	ret c ; failed to add card
	push de
	call PrintCardTypeCounts
	lb de, 15, 0
	call PrintTotalCardCount
	pop de
	call GetCountOfCardInCurDeck
	call PrintNumberValueInCursorYPos
	ret

; tries to add card ID in register e to wCurDeckCards
; fails to add card if one of the following conditions are met:
; - total cards are equal to wMaxNumCardsAllowed
; - cards with the same name as it reached the allowed limit
; - player doesn't own more copies in the collection
; returns carry if fails
; otherwise, writes card ID to first empty slot in wCurDeckCards
; input:
; de = card ID
.TryAddCardToDeck:
	push de
	ld a, [wMaxNumCardsAllowed]
	ld d, a
	ld a, [wTotalCardCount]
	cp d
	pop de
	jr nz, .not_equal
	; wMaxNumCardsAllowed == wTotalCardCount
	scf
	ret

.not_equal
	push de
	call .CheckIfCanAddCardWithSameName
	pop de
	ret c ; cannot add more cards with this name

	push de
	call GetCountOfCardInCurDeck
	ld b, a
	ld hl, wBoosterPackCardCounts
	ld d, $00
	ld a, [wScrollMenuScrollOffset]
	ld e, a
	add hl, de
	ld a, [wCurScrollMenuItem]
	ld e, a
	add hl, de
	ld d, [hl]
	ld a, b
	cp d
	pop de
	scf
	ret z ; cannot add because player doesn't own more copies

	ld a, SFX_01
	call PlaySFX
	push de
	call .AddCardToCurDeck
	ld a, [wCurCardTypeFilter]
	ld c, a
	ld b, $00
	ld hl, wCardFilterCounts
	add hl, bc
	inc [hl]
	pop de
	or a
	ret

; finds first empty slot in wCurDeckCards
; then writes the card ID in de to it
.AddCardToCurDeck:
	ld hl, wCurDeckCards
.loop_find_empty
	ld a, [hli]
	or a
	jr z, .empty
	inc hl
	jr .loop_find_empty
.empty
	ld a, [hli]
	or a
	jr nz, .loop_find_empty
	xor a
	ld [hli], a
	ld [hl], a
	dec hl
	dec hl
	ld [hl], d
	dec hl
	ld [hl], e
	ret

; returns carry if card ID in de cannot be
; added to the current deck configuration
; due to having reached the maximum number
; of cards allowed with that same name
; de = card id
.CheckIfCanAddCardWithSameName:
	call LoadCardDataToBuffer1_FromCardID
	ld a, [wLoadedCard1Type]
	cp TYPE_ENERGY_DOUBLE_COLORLESS
	jr nc, .has_limit
	; basic energy cards have no limit
	and TYPE_ENERGY
	cp TYPE_ENERGY
	jr z, .no_carry

.has_limit
; compare this card's name to
; the names of cards in list wCurDeckCards
	ld a, [wLoadedCard1Name + 0]
	ld c, a
	ld a, [wLoadedCard1Name + 1]
	ld b, a
	ld hl, wCurDeckCards
	ld d, 0
	push de
.loop_cards
	ld e, [hl]
	inc hl
	ld d, [hl]
	inc hl
	call CheckIfCardIDIsZero
	jr c, .no_carry_pop_de
	call GetCardName
	ld a, e
	cp c
	jr nz, .loop_cards
	ld a, d
	cp b
	jr nz, .loop_cards
	; has same name
	pop de
	inc d ; increment counter of cards with this name
	ld a, [wSameNameCardsLimit]
	cp d
	push de
	jr nz, .loop_cards
	; reached the maximum number
	; of cards with same name allowed
	pop de
	scf
	ret

.no_carry_pop_de
	pop de
.no_carry
	or a
	ret

; gets the element in wVisibleListCardIDs
; corresponding to index wCurScrollMenuItem
GetSelectedVisibleCardID:
	ld hl, wVisibleListCardIDs
	ld a, [wCurScrollMenuItem]
	add a ; *2
	ld e, a
	ld d, $00
	add hl, de
	ld e, [hl]
	inc hl
	ld d, [hl]
	ret

; appends the digits of value in register a to wDefaultText
; then prints it in cursor Y position
; a = value to convert to numerical digits
PrintNumberValueInCursorYPos:
	ld hl, wDefaultText
	call ConvertToNumericalDigits
	ld [hl], TX_END
	ld a, [wMenuYSeparation]
	ld l, a
	ld a, [wCurScrollMenuItem]
	ld h, a
	call HtimesL
	ld a, l
	ld hl, wMenuCursorYOffset
	add [hl]
	ld e, a
	ld d, 14
	call InitTextPrinting
	ld hl, wDefaultText
	call ProcessText
	ret

; removes card in register de from deck configuration
; and updates the values shown for its count
; in the card selection list
; input:
; de = card ID
RemoveCardFromDeckAndUpdateCount:
	call RemoveCardFromDeck
	ret nc
	push de
	call PrintCardTypeCounts
	ld de, $f00
	call PrintTotalCardCount
	pop de
	call GetCountOfCardInCurDeck
	call PrintNumberValueInCursorYPos
	ret

; removes card ID in de from wCurDeckCards
RemoveCardFromDeck:
	push de
	call GetCountOfCardInCurDeck
	pop de
	or a
	ret z ; card is not in deck
	ld a, SFX_01
	call PlaySFX
	push de
	call .RemoveCard
	ld a, [wCurCardTypeFilter]
	ld c, a
	ld b, $00
	ld hl, wCardFilterCounts
	add hl, bc
	dec [hl]
	pop de
	scf
	ret

; remove first card instance of card ID in de
; and shift all elements up by one
.RemoveCard:
	ld hl, wCurDeckCards
.loop_find
	ld a, [hli]
	cp e
	jr z, .compare_high_byte
	inc hl
	jr .loop_find
.compare_high_byte
	ld a, [hli]
	cp d
	jr nz, .loop_find
	ld c, l
	ld b, h
	dec bc
	dec bc
.loop_overwrite
	ld e, [hl]
	inc hl
	ld d, [hl]
	inc hl
	call CheckIfCardIDIsZero
	jr c, .done
	ld a, e
	ld [bc], a
	inc bc
	ld a, d
	ld [bc], a
	inc bc
	jr .loop_overwrite

.done
	xor a
	ld [bc], a
	inc bc
	ld [bc], a
	ret

UpdateConfirmationCardScreen:
	ld hl, hffbb
	ld [hl], $01
	call PrintCurDeckNumberAndName
	ld hl, hffbb
	ld [hl], $00
	jp PrintConfirmationCardList

HandleDeckConfirmationMenu:
; if deck is empty, just show deck info header with empty card list
	ld a, [wTotalCardCount]
	or a
	jp z, ShowDeckInfoHeaderAndWaitForBButton

; create list of all unique cards
	call SortCurDeckCardsByID
	call CreateCurDeckUniqueCardList

	xor a
	ld [wScrollMenuScrollOffset], a
.init_params
	ld hl, .CardSelectionParams
	call InitializeScrollMenuParameters
	ld a, [wNumUniqueCards]
	ld [wNumCardListEntries], a
	cp NUM_DECK_CONFIRMATION_VISIBLE_CARDS
	jr c, .no_cap
	ld a, NUM_DECK_CONFIRMATION_VISIBLE_CARDS
.no_cap
	ld [wNumMenuItems], a
	ld [wNumVisibleCardListEntries], a
	call ShowConfirmationCardScreen

	ld hl, UpdateConfirmationCardScreen
	ld d, h
	ld a, l
	ld hl, wScrollMenuScrollFunc
	ld [hli], a
	ld [hl], d

	xor a
	ld [wd119], a
.loop_input
	call DoFrame
	call HandleScrollListInput
	jr c, .selection_made
	call HandleJumpListInput
	jr c, .loop_input
	ldh a, [hDPadHeld]
	and PAD_START
	jr z, .loop_input

.selected_card
	ld a, $01
	call PlayAcceptOrDeclineSFX
	ld a, [wCurScrollMenuItem]
	ld [wced7], a

	; set wOwnedCardsCountList as current card list
	; and show card page screen
	ld de, wOwnedCardsCountList
	ld hl, wCurCardListPtr
	ld [hl], e
	inc hl
	ld [hl], d
	call OpenCardPageFromCardList
	jr .init_params

.selection_made
	ld a, [hCurMenuItem]
	cp $ff
	ret z ; operation cancelled
	jr .selected_card

.CardSelectionParams
	db 0 ; x pos
	db 5 ; y pos
	db 2 ; y spacing
	db 0 ; x spacing
	db 7 ; num entries
	db SYM_CURSOR_R ; visible cursor tile
	db SYM_SPACE ; invisible cursor tile
	dw NULL ; wCardListHandlerFunction

; handles the cases where player presses
; left or right to jump in a scrolling list
HandleJumpListInput:
	ld a, [wNumMenuItems]
	ld d, a
	ld a, [wScrollMenuScrollOffset]
	ld c, a
	ldh a, [hDPadHeld]
	cp PAD_RIGHT
	jr z, .d_right
	cp PAD_LEFT
	jr z, .d_left
	or a
	ret

.d_right
	ld a, [wScrollMenuScrollOffset]
	add d
	ld b, a
	add d
	ld hl, wNumCardListEntries
	cp [hl]
	jr c, .got_new_index
	ld a, [wNumCardListEntries]
	sub d
	ld b, a
	jr .got_new_index

.d_left
	ld a, [wScrollMenuScrollOffset]
	sub d
	ld b, a
	jr nc, .got_new_index
	ld b, $00
.got_new_index
	ld a, b
	ld [wScrollMenuScrollOffset], a
	cp c
	jr z, .no_scroll
	ld a, SFX_01
	call PlaySFX
	ld hl, wScrollMenuScrollFunc
	call CallIndirect
.no_scroll
	scf
	ret

; handles scrolling up and down with Select button
; in this case, the cursor position goes up/down
; by wNumMenuItems entries respectively
; return carry if scrolling happened, otherwise no carry
HandleSelectUpAndDownInList:
	ld a, [wNumMenuItems]
	ld d, a
	ld a, [wScrollMenuScrollOffset]
	ld c, a
	ldh a, [hDPadHeld]
	cp PAD_SELECT | PAD_DOWN
	jr z, .sel_down
	cp PAD_SELECT | PAD_UP
	jr z, .sel_up
	or a
	ret

.sel_down
	ld a, [wScrollMenuScrollOffset]
	add d
	ld b, a ; wScrollMenuScrollOffset + wNumMenuItems
	add d
	ld hl, wNumCardListEntries
	cp [hl]
	jr c, .got_new_pos
	ld a, [wNumCardListEntries]
	sub d
	ld b, a ; wNumCardListEntries - wNumMenuItems
	jr .got_new_pos
.sel_up
	ld a, [wScrollMenuScrollOffset]
	sub d
	ld b, a ; wScrollMenuScrollOffset - wNumMenuItems
	jr nc, .got_new_pos
	ld b, 0 ; go to first position

.got_new_pos
	ld a, b
	ld [wScrollMenuScrollOffset], a
	cp c
	jr z, .set_carry
	ld a, SFX_01
	call PlaySFX
	ld hl, wScrollMenuScrollFunc
	call CallIndirect
.set_carry
	scf
	ret

; simply draws the deck info header
; then awaits a b button press to exit
ShowDeckInfoHeaderAndWaitForBButton:
	call ShowDeckInfoHeader
.wait_input
	call DoFrame
	ldh a, [hKeysPressed]
	and PAD_B
	jr z, .wait_input
	ld a, $ff
	call PlayAcceptOrDeclineSFX
	ret

ShowConfirmationCardScreen:
	call ShowDeckInfoHeader
	lb de, 3, 5
	ld hl, wCardListCoords
	ld [hl], e
	inc hl
	ld [hl], d
	call PrintConfirmationCardList
	ret

; draws a box on the top of the screen
; with wCurDeck's number, name and card count
; and draws the Hand Cards icon if it's
; the current dueling deck
ShowDeckInfoHeader:
	call EmptyScreenAndLoadFontDuelAndHandCardsIcons
	lb de, 0, 0
	lb bc, 20, 4
	call DrawRegularTextBox
	ld a, [wCurDeckName]
	or a
	jp z, .print_card_count ; can be jr

; draw hand cards icon if it's the current dueling deck
	call PrintCurDeckNumberAndName
	ld a, [wCurDeck]
	ld b, a
	call EnableSRAM
	ld a, [sCurrentlySelectedDeck]
	call DisableSRAM
	cp b
	jr nz, .print_card_count
	lb de, 2, 1
	call DrawHandCardsTileAtDE

.print_card_count
	lb de, 14, 1
	call PrintTotalCardCount
	lb de, 16, 1
	call PrintSlashSixty
	call EnableLCD
	ret

; prints the name of wCurDeck in the form
; "X・ <deck name> deck", where X is the number
; of the deck in the given menu
; if no current deck, print blank line
PrintCurDeckNumberAndName:
	ld a, [wCurDeck]
	cp $ff
	jr z, .skip_deck_numeral

; print the deck number in the menu
; in the form "X・"
	lb de, 3, 2
	call InitTextPrinting
	ld a, [wCurDeck]
	bit 7, a
	jr z, .incr_by_one
	and $7f
	jr .got_deck_numeral
.incr_by_one
	inc a
.got_deck_numeral
	ld hl, wDefaultText
	call ConvertToNumericalDigits
	ldfw [hl], "・"
	inc hl
	ld [hl], TX_END
	ld hl, wDefaultText
	call ProcessText

.skip_deck_numeral
	ld hl, wCurDeckName
	ld de, wDefaultText
	call CopyListFromHLToDE
	ld a, [wCurDeck]
	cp $ff
	jr z, .blank_deck_name

; print "<deck name> deck"
	ld hl, wDefaultText
	call GetTextLengthInTiles
	ld b, $0
	ld hl, wDefaultText
	add hl, bc
	ld d, h
	ld e, l
	ld hl, DeckNameSuffix
	call CopyListFromHLToDE
	lb de, 6, 2
	ld hl, wDefaultText
	call InitTextPrinting
	call ProcessText
	ret

.blank_deck_name
	lb de, 2, 2
	ld hl, wDefaultText
	call InitTextPrinting
	call ProcessText
	ret

; sorts wCurDeckCards by ID in place
SortCurDeckCardsByID:
	ld hl, wCurDeckCards
.loop
	ld b, h
	ld c, l
	inc bc
	inc bc
	call .CheckEndOfDeck
	ret z ; done
.compare
	call .CompareCardIDs
	jr nc, .ordered
	call .SwapCardIDs
.ordered
	call .CheckEndOfDeck
	jr nz, .compare
	inc hl
	inc hl
	jr .loop

; returns c if card ID in [bc] < card ID in [hl]
.CompareCardIDs:
	ld e, [hl]
	inc hl
	ld d, [hl]
	dec hl
	inc bc
	ld a, [bc]
	cp d
	jr nz, .different_high
	; high byte matches, check low byte
	dec bc
	ld a, [bc]
	cp e
	inc bc
.different_high
	inc bc
	ret

; swap card ID in [bc - $2] with [hl]
.SwapCardIDs:
	dec bc
	dec bc
	ld a, [bc]
	ld d, [hl]
	ld [hli], a
	ld a, d
	ld [bc], a
	inc bc
	ld a, [bc]
	ld d, [hl]
	ld [hl], a
	dec hl
	ld a, d
	ld [bc], a
	inc bc
	ret

; returns z if bc points to end of deck
.CheckEndOfDeck:
	ld a, [bc]
	or a
	ret nz
	inc bc
	ld a, [bc]
	or a
	dec bc
	ret

; goes through list in wCurDeckCards, and for each card in it
; creates list in wUniqueDeckCardList of all unique cards
; it finds (assuming wCurDeckCards is sorted by ID)
; also counts the total number of the different cards
CreateCurDeckUniqueCardList:
	xor a
	ld [wNumUniqueCards], a
	ld b, a
	ld c, a
	ld hl, wCurDeckCards
	ld de, wUniqueDeckCardList
.loop
	ld a, [hli]
	cp c
	jr nz, .different_card_1
	ld a, [hl]
	cp b
	jr nz, .different_card_2
	inc hl
	jr .loop
.different_card_2
	dec hl
	ld a, [hli]
.different_card_1
	ld c, a
	ld [de], a
	inc de
	push af
	ld a, [hl]
	ld b, a
	ld [de], a
	inc de
	pop af
	or [hl]
	ret z
	inc hl
	ld a, [wNumUniqueCards]
	inc a
	ld [wNumUniqueCards], a
	jr .loop

; prints the list of cards visible in the window
; of the confirmation screen
; card info is presented with name, level and
; its count preceded by "x"
PrintConfirmationCardList:
	push bc
	ld hl, wCardListCoords
	ld e, [hl]
	inc hl
	ld d, [hl]
	ld b, 19 ; x coord
	ld c, e
	dec c
	ld a, [wScrollMenuScrollOffset]
	or a
	jr z, .no_cursor
	ld a, SYM_CURSOR_U
	jr .got_cursor_tile_1
.no_cursor
	ld a, SYM_SPACE
.got_cursor_tile_1
	call WriteByteToBGMap0

; iterates by decreasing value in wNumVisibleCardListEntries
; by 1 until it reaches 0
	ld a, [wScrollMenuScrollOffset]
	add a
	ld c, a
	ld b, $0
	ld hl, wOwnedCardsCountList
	add hl, bc
	ld a, [wNumVisibleCardListEntries]
.loop_cards
	push de
	or a
	jr z, .exit_loop
	ld b, a
	ld e, [hl]
	inc hl
	ld d, [hl]
	inc hl
	call CheckIfCardIDIsZero
	jr c, .no_more_cards
	call AddCardIDToVisibleList
	call LoadCardDataToBuffer1_FromCardID
	; places in wDefaultText the card's name and level
	; then appends at the end "x" with the count of that card
	; draws the card's type icon as well
	ld a, 13
	push bc
	push hl
	push de
	call CopyCardNameAndLevel
	pop de
	call .PrintCardCount
	pop hl
	pop bc
	pop de
	call .DrawCardTypeIcon
	push hl
	call InitTextPrinting
	ld hl, wDefaultText
	call ProcessText
	pop hl
	ld a, b
	dec a
	inc e
	inc e
	jr .loop_cards

.exit_loop
	ld e, [hl]
	inc hl
	ld d, [hl]
	call CheckIfCardIDIsZero
	jr c, .no_more_cards
	pop de
	xor a ; FALSE
	ld [wUnableToScrollDown], a
	ld a, SYM_CURSOR_D
	jr .got_cursor_tile_2

.no_more_cards
	pop de
	ld a, TRUE
	ld [wUnableToScrollDown], a
	ld a, SYM_SPACE
.got_cursor_tile_2
	ld b, 19 ; x coord
	ld c, e
	dec c
	dec c
	call WriteByteToBGMap0
	pop bc
	ret

; prints the card count preceded by a cross
; for example "x42"
.PrintCardCount:
	push af
	push bc
	push de
	push hl
.loop_search
	ld a, [hl]
	or a
	jr z, .found_card_id
	inc hl
	jr .loop_search
.found_card_id
	call GetCountOfCardInCurDeck
	ld [hl], TX_SYMBOL
	inc hl
	ld [hl], SYM_CROSS
	inc hl
	call ConvertToNumericalDigits
	ld [hl], TX_END
	pop hl
	pop de
	pop bc
	pop af
	ret

; draws the icon corresponding to the loaded card's type
; can be any of Pokemon stages (basic, 1st and 2nd stage)
; Energy or Trainer
; draws it 2 tiles to the left and 1 up to
; the current coordinate in de
.DrawCardTypeIcon
	push hl
	push de
	push bc
	ld a, [wLoadedCard1Type]
	cp TYPE_ENERGY
	jr nc, .not_pkmn_card

; pokemon card
	ld a, [wLoadedCard1Stage]
	ld b, a
	add b
	add b
	add b ; *4
	add ICON_TILE_BASIC_POKEMON
	jr .got_tile

.not_pkmn_card
	cp TYPE_TRAINER
	jr nc, .trainer_card

; energy card
	sub TYPE_ENERGY
	ld b, a
	add b
	add b
	add b ; *4
	add ICON_TILE_FIRE
	jr .got_tile

.trainer_card
	ld a, ICON_TILE_TRAINER
.got_tile
	dec d
	dec d
	dec e
	push af
	lb hl, 1, 2
	lb bc, 2, 2
	call FillRectangle
	pop af

	call GetCardTypeIconPalette
	ld b, a
	ld a, [wConsole]
	cp CONSOLE_CGB
	jr nz, .skip_pal
	ld a, b
	lb bc, 2, 2
	lb hl, 0, 0
	call BankswitchVRAM1
	call FillRectangle
	call BankswitchVRAM0
.skip_pal
	pop bc
	pop de
	pop hl
	ret

; returns in a the BG Pal corresponding to the
; card type icon in input register a
; if not found, returns $00
GetCardTypeIconPalette:
	push bc
	push hl
	push de
	push af
	bank1call Func_6c12
	pop af
	pop de
	ld b, a
	ld hl, .CardTypeIconPalettes
.loop
	ld a, [hli]
	or a
	jr z, .done
	cp b
	jr z, .done
	inc hl
	jp .loop ; can be jr
.done
	ld a, [hl]
	pop hl
	pop bc
	ret

.CardTypeIconPalettes:
; icon tile, BG pal
	db ICON_TILE_FIRE,            2
	db ICON_TILE_GRASS,           3
	db ICON_TILE_LIGHTNING,       2
	db ICON_TILE_WATER,           3
	db ICON_TILE_FIGHTING,        4
	db ICON_TILE_PSYCHIC,         4
	db ICON_TILE_COLORLESS,       0
	db ICON_TILE_ENERGY,          3
	db ICON_TILE_BASIC_POKEMON,   3
	db ICON_TILE_STAGE_1_POKEMON, 3
	db ICON_TILE_STAGE_2_POKEMON, 2
	db ICON_TILE_TRAINER,         3
	db $00, $ff
; 0xa603

SECTION "Bank 2@677f", ROMX[$677f], BANK[$2]

CopyBBytesFromHLToDE_Bank02:
.loop
	ld a, [hli]
	ld [de], a
	inc de
	dec b
	jr nz, .loop
	ret
; 0xa786

SECTION "Bank 2@689d", ROMX[$689d], BANK[$2]

GeneralCardListMenuParams:
	db 1 ; x pos
	db 5 ; y pos
	db 2 ; y spacing
	db 0 ; x spacing
	db 7 ; num entries
	db SYM_CURSOR_R ; visible cursor tile
	db SYM_SPACE ; invisible cursor tile
	dw NULL ; wCardListHandlerFunction

GeneralCardListUpdateFunc:
	ld a, $01
	ldh [hffbb], a
	call PrintPlayersCardsText
	xor a
	ldh [hffbb], a
	call PrintCardSelectionList
	ret

; a = which card type filter
PrintFilteredCardSelectionList:
	push af
	ld hl, CardTypeFilters
	ld b, $00
	ld c, a
	add hl, bc
	ld a, [hl]
	push af
	ld a, ALL_DECKS
	call CreateCardCollectionListWithDeckCards
	ld a, TRUE
	ld [wd121], a
	pop af
	call CreateFilteredCardList

	ld a, NUM_DECK_CONFIRMATION_VISIBLE_CARDS
	ld [wNumVisibleCardListEntries], a
	lb de, 2, 5
	ld hl, wCardListCoords
	ld [hl], e
	inc hl
	ld [hl], d
	ld a, SYM_SPACE
	ld [wCursorAlternateTile], a
	call PrintCardSelectionList
	pop af
	ret

; creates a card collection list in wTempCardCollection
; if a is $80, only include cards that are in the
; built decks, otherwise include all owned cards
CreateCardCollectionListWithDeckCards:
	cp $80
	jr nz, .copy_card_collection
	ld hl, wTempCardCollection
	xor a
	call ClearNBytesFromHL
	ld hl, wTempCardCollection + $100
	xor a
	call ClearNBytesFromHL
	ld a, ALL_DECKS
	ld [hffbf], a
	jr .deck_1

.copy_card_collection
	ld [hffbf], a

; copies sCardCollection to wTempCardCollection
	call EnableSRAM
	ld hl, sCardCollection
	ld de, wTempCardCollection
	ld b, $00 ; aka $100 bytes
	call CopyBBytesFromHLToDE_Bank02
	ld hl, sCardCollection + $100
	ld de, wTempCardCollection + $100
	ld b, $00 ; aka $100 bytes
	call CopyBBytesFromHLToDE_Bank02
	call DisableSRAM
.deck_1
	ld a, [hffbf]
	bit DECK_1_F, a
	jr z, .deck_2
	ld de, sDeck1Cards
	call IncrementDeckCardsInTempCollection
.deck_2
	ld a, [hffbf]
	bit DECK_2_F, a
	jr z, .deck_3
	ld de, sDeck2Cards
	call IncrementDeckCardsInTempCollection
.deck_3
	ld a, [hffbf]
	bit DECK_3_F, a
	jr z, .deck_4
	ld de, sDeck3Cards
	call IncrementDeckCardsInTempCollection
.deck_4
	ld a, [hffbf]
	bit DECK_4_F, a
	ret z
	ld de, sDeck4Cards
	call IncrementDeckCardsInTempCollection
	ret

; goes through cards in deck in de
; and for each card ID, increments its corresponding
; entry in wTempCardCollection
IncrementDeckCardsInTempCollection:
	call EnableSRAM
	ld a, 8
.loop_outer
	push af
	ld a, [de]
	inc de
	ld b, a
	ld c, 8
.loop_inner
	ld a, [de]
	inc de
	push de
	ld e, a
	xor a
	rl b
	rla
	ld d, a
	ld hl, wTempCardCollection
	add hl, de
	inc [hl]
	pop de
	dec c
	jr nz, .loop_inner
	pop af
	dec a
	jr nz, .loop_outer
	call DisableSRAM
	ret

; prints the name, level and storage count of the cards
; that are visible in the list window
; in the form:
; CARD NAME/LEVEL X
; where X is the current count of that card
PrintCardSelectionList:
	push bc
	ld hl, wCardListCoords
	ld e, [hl]
	inc hl
	ld d, [hl]
	ld b, 19 ; x coord
	ld c, e
	ld a, [wScrollMenuScrollOffset]
	or a
	jr z, .alternate_cursor_tile
	ld a, SYM_CURSOR_U
	jr .got_cursor_tile_1
.alternate_cursor_tile
	ld a, [wCursorAlternateTile]
.got_cursor_tile_1
	call WriteByteToBGMap0

; iterates by decreasing value in wNumVisibleCardListEntries
; by 1 until it reaches 0
	ld a, [wScrollMenuScrollOffset]
	add a
	ld c, a
	ld b, $0
	ld hl, wTempCardList
	add hl, bc
	ld a, [wNumVisibleCardListEntries]
.loop_filtered_cards
	push de
	or a
	jr z, .exit_loop
	ld b, a
	ld e, [hl]
	inc hl
	ld d, [hl]
	inc hl
	call CheckIfCardIDIsZero
	jr c, .invalid_card
	call AddCardIDToVisibleList
	call LoadCardDataToBuffer1_FromCardID
	; places in wDefaultText the card's name and level
	; then appends at the end the count of that card
	; in the card storage
	ld a, 14
	push bc
	push hl
	push de
	call CopyCardNameAndLevel
	pop de
	call AppendOwnedCardCountNumber
	pop hl
	pop bc
	pop de
	push hl
	call InitTextPrinting
	ld hl, wDefaultText
	jr .process_text
.invalid_card
	pop de
	push hl
	call InitTextPrinting
	ld hl, Text_9e48 + $6
.process_text
	call ProcessText
	pop hl

	ld a, b
	dec a
	inc e
	inc e
	jr .loop_filtered_cards

.exit_loop
	ld a, [hli]
	or a
	jr nz, .asm_a9e3
	ld a, [hli]
	or a
	jr z, .cannot_scroll
.asm_a9e3
	pop de
; draw down cursor because
; there are still more cards
; to be scrolled down
	xor a ; FALSE
	ld [wUnableToScrollDown], a
	ld a, SYM_CURSOR_D
	jr .got_cursor_tile_2
.cannot_scroll
	pop de
	ld a, TRUE
	ld [wUnableToScrollDown], a
	ld a, [wCursorAlternateTile]
.got_cursor_tile_2
	ld b, 19 ; x coord
	ld c, e
	dec c
	dec c
	call WriteByteToBGMap0
	pop bc
	ret

; appends the card count given in register e
; to the list in hl, in numerical form
; (i.e. its numeric symbol representation)
AppendOwnedCardCountNumber:
	push af
	push bc
	push de
	push hl
; increment hl until end is reached ($00 byte)
.loop
	ld a, [hl]
	or a
	jr z, .end
	inc hl
	jr .loop
.end
	call Func_9c55
	call ConvertToNumericalDigits
	ld bc, $84
	ld [hl], c
	inc hl
	ld [hl], b
	inc hl
	ld [hl], $00 ; insert byte terminator
	pop hl
	pop de
	pop bc
	pop af
	ret

; print header info (card count and player name)
PrintPlayersCardsHeaderInfo:
	call PrepareMenuGraphics
;	fallthrough
PrintPlayersCardsHeaderInfo_SkipEmptyScreen:
	lb bc, 0, 4
	ld a, SYM_BOX_TOP
	call FillBGMapLineWithA
	call PrintTotalNumberOfCardsInCollection
	call PrintPlayersCardsText
	call DrawCardTypeIcons
	ret

; prints "<PLAYER>'s cards"
PrintPlayersCardsText:
	lb de, 1, 0
	call InitTextPrinting
	ld de, wDefaultText
	call CopyPlayerName
	ld hl, wDefaultText
	call ProcessText
	ld hl, wDefaultText
	call GetTextLengthInTiles
	inc b
	ld d, b
	ld e, 0
	call InitTextPrinting
	ldtx hl, OnesCardsText ; "'s Cards"
	call ProcessTextFromID
	ret

PrintTotalNumberOfCardsInCollection:
	ld a, ALL_DECKS
	call CreateCardCollectionListWithDeckCards

; count all the cards in collection
	ld bc, wTempCardCollection + 1
	ld de, 0
	ld hl, 0
.loop_all_cards
	ld a, [bc]
	inc bc
	and $7f
	push de
	ld d, $00
	ld e, a
	add hl, de
	pop de
	cp16 NUM_CARDS
	inc de
	jr nz, .loop_all_cards

; hl = total number of cards in collection
	call .GetTotalCountDigits
	ld hl, wTempCardCollection
	ld de, wDecimalDigitsSymbols
	ld b, $00
	call .PlaceNumericalChar
	call .PlaceNumericalChar
	call .PlaceNumericalChar
	call .PlaceNumericalChar
	call .PlaceNumericalChar
	ldfw bc, "枚"
	ld [hl], c ; 枚
	inc hl
	ld [hl], b
	inc hl
	ld [hl], TX_END
	lb de, 13, 0
	call InitTextPrinting
	ld hl, wTempCardCollection
	call ProcessText
	ret

; places a numerical character in hl from de
; doesn't place a 0 if no non-0
; numerical character has been placed before
; this makes it so that there are no
; 0s in more significant digits
.PlaceNumericalChar:
	ld [hl], TX_SYMBOL
	inc hl
	ld a, b
	or a
	jr z, .leading_num
	ld a, [de]
	inc de
	ld [hli], a
	ret
.leading_num
; don't place a 0 as a leading number
	ld a, [de]
	inc de
	cp SYM_0
	jr z, .space_char
	ld [hli], a
	ld b, $01 ; at least one non-0 char was placed
	ret
.space_char
	xor a ; SYM_SPACE
	ld [hli], a
	ret

.GetTotalCountDigits:
	ld de, wDecimalDigitsSymbols
	ld bc, -10000
	call .GetDigit
	ld bc, -1000
	call .GetDigit
	ld bc, -100
	call .GetDigit
	ld bc, -10
	call .GetDigit
	ld bc, -1
	call .GetDigit
	ret

.GetDigit
	ld a, SYM_0 - 1
.loop
	inc a
	add hl, bc
	jr c, .loop
	ld [de], a
	inc de
	ld a, l
	sub c
	ld l, a
	ld a, h
	sbc b
	ld h, a
	ret

; a = Booster Pack
CreateBoosterPackCardList:
	push af
	ld a, 2 * 80
	ld hl, wBoosterPackCardList
	call ClearNBytesFromHL
	ld a, 80 + 1
	ld hl, wBoosterPackCardCounts
	call ClearNBytesFromHL
	xor a
	ld [wOwnedPhantomCards], a
	pop af

	ld hl, 0
	ld de, 0
	ld b, a
.loop_create_booster_pack_list
	inc de
	call LoadCardDataToBuffer1_FromCardID
	jp c, .handle_energy_cards
	ld a, [wLoadedCard1Set]
	cp b
	jr nz, .loop_create_booster_pack_list

	; handle promo cards differently
	cp16 VENUSAUR_LV64
	jp z, .venusaur_lv64
	cp16 MEW_LV15
	jp z, .mew_lv15
	cp16 LUGIA
	jp z, .lugia
	cp16 HERE_COMES_TEAM_ROCKET
	jp z, .here_comes_team_rocket

	; ignore special energy cards
	cp16 DOUBLE_COLORLESS_ENERGY
	jp z, .loop_create_booster_pack_list
	cp16 POTION_ENERGY
	jp z, .loop_create_booster_pack_list
	cp16 FULLHEAL_ENERGY
	jp z, .loop_create_booster_pack_list
	cp16 RAINBOW_ENERGY
	jp z, .loop_create_booster_pack_list
	cp16 RECYCLE_ENERGY
	jp z, .loop_create_booster_pack_list

	push bc
	push hl
	ld bc, wBoosterPackCardList
	add hl, hl
	add hl, bc
	ld [hl], e
	inc hl
	ld [hl], d

	ld hl, wTempCardCollection
	add hl, de
	ld a, [hl]
	pop hl
	push hl
	ld bc, wBoosterPackCardCounts
	add hl, bc
	ld [hl], a
	pop hl
	inc l
	pop bc
	jp .loop_create_booster_pack_list

.handle_energy_cards
	ld a, b
	cp LEGENDARY_POWER
	jr z, .legendary_power
	cp WE_ARE_TEAM_ROCKET
	jr z, .we_are_team_rocket
	cp TEAM_ROCKETS_AMBITION
	jp z, .team_rockets_ambition
	or a
	jp nz, .handle_phantom_cards

; beginning pokemon
	ld de, 0
.loop_add_basic_energy_cards
	inc de
	cp16 DOUBLE_COLORLESS_ENERGY
	jp z, .handle_phantom_cards
	push bc
	push hl
	ld bc, wBoosterPackCardList
	add hl, hl
	add hl, bc
	ld [hl], e
	inc hl
	ld [hl], d
	ld hl, wTempCardCollection
	add hl, de
	ld a, [hl]
	pop hl
	push hl
	ld bc, wBoosterPackCardCounts
	add hl, bc
	ld [hl], a
	pop hl
	inc l
	pop bc
	jr .loop_add_basic_energy_cards

.legendary_power
	ld de, 0
.loop_add_double_colorless_energy
	inc de
	cp16 BULBASAUR_LV12
	jp z, .handle_phantom_cards
	cp16 DOUBLE_COLORLESS_ENERGY
	jr nz, .loop_add_double_colorless_energy
	push bc
	push hl
	ld bc, wBoosterPackCardList
	add hl, hl
	add hl, bc
	ld [hl], e
	inc hl
	ld [hl], d
	ld hl, wTempCardCollection
	add hl, de
	ld a, [hl]
	pop hl
	push hl
	ld bc, wBoosterPackCardCounts
	add hl, bc
	ld [hl], a
	pop hl
	inc l
	pop bc
	jr .loop_add_double_colorless_energy

.we_are_team_rocket
	ld de, 0
.loop_add_potion_and_fullheal_energy
	inc de
	cp16 BULBASAUR_LV12
	jr z, .handle_phantom_cards
	cp16 POTION_ENERGY
	jr z, .potion_or_fullheal_energy
	cp16 FULLHEAL_ENERGY
	jr z, .potion_or_fullheal_energy
	cp16 RAINBOW_ENERGY
	jr nz, .loop_add_potion_and_fullheal_energy
.potion_or_fullheal_energy
	push bc
	push hl
	ld bc, wBoosterPackCardList
	add hl, hl
	add hl, bc
	ld [hl], e
	inc hl
	ld [hl], d
	ld hl, wTempCardCollection
	add hl, de
	ld a, [hl]
	pop hl
	push hl
	ld bc, wBoosterPackCardCounts
	add hl, bc
	ld [hl], a
	pop hl
	inc l
	pop bc
	jr .loop_add_potion_and_fullheal_energy

.team_rockets_ambition
	ld de, 0
.loop_add_recycle_energy
	inc de
	cp16 BULBASAUR_LV12
	jr z, .handle_phantom_cards
	cp16 RECYCLE_ENERGY
	jr nz, .loop_add_recycle_energy
	push bc
	push hl
	ld bc, wBoosterPackCardList
	add hl, hl
	add hl, bc
	ld [hl], e
	inc hl
	ld [hl], d
	ld hl, wTempCardCollection
	add hl, de
	ld a, [hl]
	pop hl
	push hl
	ld bc, wBoosterPackCardCounts
	add hl, bc
	ld [hl], a
	pop hl
	inc l
	pop bc
	jr .loop_add_recycle_energy

.handle_phantom_cards
	ld a, [wOwnedPhantomCards]
	bit PROMO_VENUSAUR_LV64_F, a
	jr z, .asm_ac92
	call .AddVenusaurLv64
.asm_ac92
	bit PROMO_MEW_LV15_F, a
	jr z, .asm_ac99
	call .AddMewLv15
.asm_ac99
	bit PROMO_LUGIA_F, a
	jr z, .asm_aca0
	call .AddLugia
.asm_aca0
	bit PROMO_HERE_COMES_TEAM_ROCKET_F, a
	jr z, .find_last_owned_card
	call .AddHereComesTeamRocket

.find_last_owned_card
	dec l
	ld c, l
	ld b, h
.loop_find_last_owned_card
	ld hl, wBoosterPackCardCounts
	add hl, bc
	ld a, [hl]
	cp CARD_NOT_OWNED
	jr nz, .owns_card
	dec c
	jr .loop_find_last_owned_card
.owns_card
	inc c
	ld a, c
	ld [wBoosterPackCardListSize], a

	; terminate lists
	xor a
	ld hl, wBoosterPackCardList
	add hl, bc
	add hl, bc
	ld [hli], a
	ld [hl], a
	ld a, $ff
	ld hl, wBoosterPackCardCounts
	add hl, bc
	ld [hl], a
	ret

.mew_lv15
	ld a, PROMO_MEW_LV15

.store_owned_phantom_card
	push hl
	push bc
	ld b, a
	ld hl, wTempCardCollection
	add hl, de
	ld a, [hl]
	cp CARD_NOT_OWNED
	jr z, .promo_card_not_owned
	ld a, [wOwnedPhantomCards]
	or b
	ld [wOwnedPhantomCards], a
.promo_card_not_owned
	pop bc
	pop hl
	jp .loop_create_booster_pack_list

.venusaur_lv64
	ld a, PROMO_VENUSAUR_LV64
	jr .store_owned_phantom_card

.lugia
	ld a, PROMO_LUGIA
	jr .store_owned_phantom_card

.here_comes_team_rocket
	ld a, PROMO_HERE_COMES_TEAM_ROCKET
	jr .store_owned_phantom_card

.AddVenusaurLv64:
	push af
	push hl
	ld de, VENUSAUR_LV64
.asm_acf6
	ld bc, wBoosterPackCardList
	add hl, hl
	add hl, bc
	ld [hl], e
	inc hl
	ld [hl], d
	pop hl
	push hl
	ld bc, wBoosterPackCardCounts
	add hl, bc
	ld [hl], $01
	pop hl
	inc l
	pop af
	ret

.AddMewLv15:
	push af
	push hl
	ld de, MEW_LV15
	jr .asm_acf6

.AddLugia:
	push af
	push hl
	ld de, LUGIA
	jr .asm_acf6

.AddHereComesTeamRocket:
	push af
	push hl
	ld de, HERE_COMES_TEAM_ROCKET
	jr .asm_acf6

; a = Booster Pack
PrepareBoosterPackCardList:
	push af
	call EnableSRAM
	ld hl, sCardCollection
	ld de, wTempCardCollection
	ld b, 0 ; aka $100 bytes
	call CopyBBytesFromHLToDE_Bank02
	ld hl, sCardCollection + $100
	ld de, wTempCardCollection + $100
	ld b, 0 ; aka $100 bytes
	call CopyBBytesFromHLToDE_Bank02
	call DisableSRAM
	pop af

	push af
	call .GetEntryPrefix
	call CreateBoosterPackCardList
	ld a, 7
	ld [wNumVisibleCardListEntries], a
	lb de, 2, 4
	ld hl, wCardListCoords
	ld [hl], e
	inc hl
	ld [hl], d
	pop af
	ret

; places in entry name the prefix associated with the selected Card Set
; a = CARD_SET_* constant
.GetEntryPrefix:
	push af
	cp PROMOTIONAL
	jr nz, .check_team_rockets_ambition
	ldfw de, "P"
	jr .got_letter
.check_team_rockets_ambition
	cp TEAM_ROCKETS_AMBITION
	jr nz, .check_we_are_team_rocket
	ldfw de, "H"
	jr .got_letter
.check_we_are_team_rocket
	cp WE_ARE_TEAM_ROCKET
	jr nz, .check_sky_flying_pokemon
	ldfw de, "G"
	jr .got_letter
.check_sky_flying_pokemon
	cp SKY_FLYING_POKEMON
	jr nz, .check_psychic_battle
	ldfw de, "F"
	jr .got_letter
.check_psychic_battle
	cp PSYCHIC_BATTLE
	jr nz, .check_island_of_fossil
	ldfw de, "D"
	jr .got_letter
.check_island_of_fossil
	cp ISLAND_OF_FOSSIL
	jr nz, .check_legendary_power
	ldfw de, "C"
	jr .got_letter
.check_legendary_power
	cp LEGENDARY_POWER
	jr nz, .beginning_pokemon
	ldfw de, "B"
	jr .got_letter
.beginning_pokemon
	ldfw de, "A"
.got_letter
	ld hl, wBoosterPackCardListPrefixBuffer
	ld [hl], d
	inc hl
	ld [hl], e
	pop af
	ret

; prints the cards being shown in the Card Album screen
; for the corresponding Card Set
FillBoosterPackCardList:
	push bc
	ld hl, wCardListCoords
	ld e, [hl]
	inc hl
	ld d, [hl]
	ld b, 19 ; x
	ld c, e
	dec c
	dec c

; draw up cursor on top right
	ld a, [wScrollMenuScrollOffset]
	or a
	jr z, .box_top_tile
	ld a, SYM_CURSOR_U
	jr .write_byte
.box_top_tile
	ld a, SYM_BOX_TOP_R
.write_byte
	call WriteByteToBGMap0

	; iterate through the visible cards
	; in reverse order to fill their names
	ld a, [wScrollMenuScrollOffset]
	ld l, a
	ld h, $00
	ld a, [wNumVisibleCardListEntries]
.loop_visible_cards
	push de
	or a
	jr z, .done_card_names
	ld b, a
	ld de, wBoosterPackCardList
	push hl
	add hl, hl
	add hl, de
	ld e, [hl]
	inc hl
	ld d, [hl]
	pop hl
	inc l
	call CheckIfCardIDIsZero
	jr c, .at_the_bottom
	call AddCardIDToVisibleList
	call LoadCardDataToBuffer1_FromCardID
	push bc
	push hl
	ld de, wBoosterPackCardCounts
	add hl, de
	dec hl
	ld a, [hl]
	cp CARD_NOT_OWNED
	jr nz, .copy_card_name
	ld hl, .empty_slot_text
	ld de, wDefaultText
	call CopyListFromHLToDE
	jr .got_card_text
.copy_card_name
	ld a, 13
	call CopyCardNameAndLevel
.got_card_text
	pop hl
	pop bc
	pop de
	push hl
	call InitTextPrinting
	pop hl
	push hl
	call .AppendCardListIndex
	call ProcessText
	ld hl, wDefaultText
	jr .process_text
	; unreachable
	pop de
	push hl
	call InitTextPrinting
	ld hl, Text_9e48 + $6
.process_text
	call ProcessText
	pop hl
	ld a, b
	dec a
	inc e
	inc e
	jr .loop_visible_cards

.done_card_names
	ld de, wBoosterPackCardList
	add hl, hl
	add hl, de
	ld e, [hl]
	inc hl
	ld d, [hl]
	call CheckIfCardIDIsZero
	jr c, .at_the_bottom
	pop de
	xor a ; FALSE
	ld [wUnableToScrollDown], a
	ld a, SYM_CURSOR_D
	jr .draw_down_arrow
.at_the_bottom
	pop de
	ld a, TRUE
	ld [wUnableToScrollDown], a
	ld a, SYM_BOX_BTM_R
.draw_down_arrow
	ld b, 19
	ld c, 17
	call WriteByteToBGMap0
	pop bc
	ret

.empty_slot_text
	textfw "-------------"
	done

.AppendCardListIndex:
	push bc
	push de
	ld de, wBoosterPackCardList
	add hl, hl
	add hl, de
	dec hl
	ld d, [hl]
	dec hl
	ld e, [hl]
	cp16 BULBASAUR_LV12
	jr c, .energy

	cp16 VENUSAUR_LV64
	jr z, .promo_card
	cp16 MEW_LV15
	jr z, .promo_card
	cp16 LUGIA
	jr z, .promo_card
	cp16 HERE_COMES_TEAM_ROCKET
	jr z, .promo_card

	ld a, [wNumVisibleCardListEntries]
	sub b
	ld hl, wScrollMenuScrollOffset
	add [hl]
	inc a
	call CalculateOnesAndTensDigits
	ld hl, wDecimalDigitsSymbols
	ld a, [hli]
	ld b, a
	ld a, [hl]
	or a
	jr nz, .over_10
	ld a, SYM_0
.over_10
	ld hl, wBoosterPackCardListPrefixBuffer + $2
	ld [hl], TX_SYMBOL
	inc hl
	ld [hli], a
	ld [hl], TX_SYMBOL
	inc hl
	ld a, b
	ld [hli], a
	ld [hl], TX_SYMBOL
	inc hl
	xor a
	ld [hli], a ; SYM_SPACE
	ld [hl], a  ; TX_END
	ld hl, wBoosterPackCardListPrefixBuffer
	pop de
	pop bc
	ret

.energy
	ld a, e
	call CalculateOnesAndTensDigits
	ld hl, wDecimalDigitsSymbols
	ld a, [hli]
	ld b, a
	ld a, [hl]
	ld hl, wBoosterPackCardListPrefixBuffer + $2
	ldfw de, "E"
	ld [hl], d
	inc hl
	ld [hl], e
	inc hl
	ld [hl], TX_SYMBOL
	inc hl
	or a
	jr nz, .over_10_energy
	ld a, SYM_0
.over_10_energy
	ld [hli], a
	ld [hl], TX_SYMBOL
	inc hl
	ld a, b
	ld [hli], a
	ld [hl], TX_SYMBOL
	inc hl
	xor a
	ld [hli], a ; SYM_SPACE
	ld [hl], a  ; TX_END
	ld hl, wBoosterPackCardListPrefixBuffer + $2
	pop de
	pop bc
	ret

.promo_card
	; promo cards are numbered as xx
	ld hl, wBoosterPackCardListPrefixBuffer + $2
	ldfw [hl], "×"
	inc hl
	ldfw [hl], "×"
	inc hl
	ld [hl], TX_SYMBOL
	inc hl
	xor a
	ld [hli], a ; SYM_SPACE
	ld [hl], a  ; TX_END
	ld hl, wBoosterPackCardListPrefixBuffer
	pop de
	pop bc
	ret

; handles opening card page, and inputs when inside Card Album
HandleCardAlbumCardPage:
	ld a, [wCurScrollMenuItem]
	ld b, a
	ld a, [wScrollMenuScrollOffset]
	add b
	ld c, a
	ld b, $00
	ld hl, wBoosterPackCardCounts
	add hl, bc
	ld a, [hl]
	cp CARD_NOT_OWNED
	jr z, .handle_input

	ld hl, wCurCardListPtr
	ld a, [hli]
	ld h, [hl]
	ld l, a
	add hl, bc
	add hl, bc
	ld e, [hl]
	inc hl
	ld d, [hl]
	push de
	call LoadCardDataToBuffer1_FromCardID
	lb de, $38, $9f
	call SetupText
	bank1call OpenCardPage_FromCheckHandOrDiscardPile
	pop de

.handle_input
	ldh a, [hDPadHeld]
	ld b, a
	and PAD_BUTTONS
	jp nz, .exit
	xor a ; FALSE
	ld [wMenuInputSFX], a
	ld a, [wNumMenuItems]
	ld c, a
	ld a, [wCurScrollMenuItem]
	bit B_PAD_UP, b
	jr z, .check_d_down

	push af
	ld a, SFX_01
	ld [wMenuInputSFX], a
	ld a, [wCurScrollMenuItem]
	ld hl, wScrollMenuScrollOffset
	add [hl]
	ld hl, wFirstOwnedCardIndex
	cp [hl]
	jr z, .open_card_page_pop_af_2
	pop af

	dec a
	bit 7, a
	jr z, .got_new_pos
	ld a, [wScrollMenuScrollOffset]
	or a
	jr z, .open_card_page
	dec a
	ld [wScrollMenuScrollOffset], a
	xor a
	jr .got_new_pos

.check_d_down
	bit B_PAD_DOWN, b
	jr z, .open_card_page
	push af
	ld a, SFX_01
	ld [wMenuInputSFX], a
	pop af
	inc a
	cp c
	jr c, .got_new_pos
	push af
	ld hl, wCurCardListPtr
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, [wCurScrollMenuItem]
	ld b, a
	ld a, [wScrollMenuScrollOffset]
	inc a
	add b
	ld c, a
	ld b, $00
	add hl, bc
	add hl, bc
	ld e, [hl]
	inc hl
	ld d, [hl]
	call CheckIfCardIDIsZero
	jr c, .open_card_page_pop_af_1
	ld a, [wScrollMenuScrollOffset]
	inc a
	ld [wScrollMenuScrollOffset], a
	pop af
	dec a
.got_new_pos
	ld [wCurScrollMenuItem], a
	ld a, [wMenuInputSFX]
	or a
	jp z, HandleCardAlbumCardPage
	call PlaySFX
	jp HandleCardAlbumCardPage
.open_card_page_pop_af_1
	pop af
	jr .open_card_page
.open_card_page_pop_af_2
	pop af

.open_card_page
	push de
	bank1call OpenCardPage.loop_input
	pop de
	jp .handle_input

.exit
	ld a, $01
	ld [wVBlankOAMCopyToggle], a
	ld a, [wCurScrollMenuItem]
	ld [wTempCurMenuItem], a
	ret

GetFirstOwnedCardIndex:
	ld hl, wBoosterPackCardCounts
	ld b, 0
.loop
	ld a, [hli]
	cp CARD_NOT_OWNED
	jr nz, .owned
	inc b
	jr .loop
.owned
	ld a, b
	ld [wFirstOwnedCardIndex], a
	ret

CardAlbum:
	ld a, $01
	ld [hffbe], a ; should be ldh

	xor a
	ld [wScrollMenuScrollOffset], a
.booster_pack_menu
	ld hl, .BoosterPackMenuParams
	call InitializeScrollMenuParameters
	call .ShowBoosterPackMenu
	ld a, 5
	ld [wNumMenuItems], a
	ld hl, FillBoosterPackMenuItems
	ld d, h
	ld a, l
	ld hl, wScrollMenuScrollFunc
	ld [hli], a
	ld [hl], d
	xor a
	ld [wd119], a
.loop_input
	call DoFrame
	farcall HandleScrollMenu
	jp nc, .loop_input ; can be jr
	ld a, [hCurMenuItem]
	cp $ff
	ret z ; exit

	; selected a Booster Pack
	ld a, [wScrollMenuScrollOffset]
	ld [wTempScrollMenuScrollOffset], a
	ld b, a
	ld a, [wCurScrollMenuItem]
	ld [wTempScrollMenuItem], a
	add b
	ld c, a
	ld b, $00
	ld hl, wBoosterPackItems
	add hl, bc
	ld a, [hl]
	or a
	jr nz, .loop_input ; haven't obtained

	ld a, c
	ld [wCardAlbumBoosterPack], a
	call PrepareBoosterPackCardList
	call .InitList
	xor a
	ld [wScrollMenuScrollOffset], a
	call FillBoosterPackCardList
	call EnableLCD
	ld a, [wBoosterPackCardListSize]
	or a
	jr nz, .card_list
	; is empty list
.loop_input_empty_list
	call DoFrame
	ldh a, [hKeysPressed]
	and PAD_B
	jr z, .loop_input_empty_list
	ld a, $ff
	call PlayAcceptOrDeclineSFX
	ld a, [wTempScrollMenuScrollOffset]
	ld [wScrollMenuScrollOffset], a
	ld a, [wTempScrollMenuItem]
	ld [wCurScrollMenuItem], a
	jp .booster_pack_menu

.card_list
	call .CountCardIDs
	xor a
	ld hl, .BoosterPackCardsMenuParams
	call InitializeScrollMenuParameters
	ld a, [wBoosterPackCardListSize]
	ld hl, wNumVisibleCardListEntries
	cp [hl]
	jr nc, .got_num_visible_cards
	ld [wNumMenuItems], a
.got_num_visible_cards
	ld hl, FillBoosterPackCardList
	ld d, h
	ld a, l
	ld hl, wScrollMenuScrollFunc
	ld [hli], a
	ld [hl], d
	xor a
	ld [wd119], a
.loop
	call DoFrame
	call HandleScrollListInput
	jr c, .card_selection_made
	call HandleJumpListInput
	jr c, .loop
	ldh a, [hDPadHeld]
	and PAD_START
	jr z, .loop
.open_card_page
	ld a, $01
	call PlayAcceptOrDeclineSFX
	ld a, [wNumMenuItems]
	ld [wTempScrollMenuNumVisibleItems], a
	ld a, [wCurScrollMenuItem]
	ld [wTempCurMenuItem], a
	ld c, a
	ld a, [wScrollMenuScrollOffset]
	add c
	ld hl, wBoosterPackCardCounts
	ld c, a
	ld b, $00
	add hl, bc
	ld a, [hl]
	cp CARD_NOT_OWNED
	jr z, .loop

	ld de, wBoosterPackCardList
	ld hl, wCurCardListPtr
	ld [hl], e
	inc hl
	ld [hl], d
	call GetFirstOwnedCardIndex
	call HandleCardAlbumCardPage

	call .InitList
	call FillBoosterPackCardList
	call EnableLCD
	ld hl, .BoosterPackCardsMenuParams
	call InitializeScrollMenuParameters
	ld a, [wTempScrollMenuNumVisibleItems]
	ld [wNumMenuItems], a
	ld a, [wTempCurMenuItem]
	ld [wCurScrollMenuItem], a
	jr .loop

.card_selection_made
	call DrawListCursor_Invisible
	ld a, [wCurScrollMenuItem]
	ld [wTempCurMenuItem], a
	ld a, [hCurMenuItem]
	cp $ff
	jr nz, .open_card_page
	ld a, [wTempScrollMenuScrollOffset]
	ld [wScrollMenuScrollOffset], a
	ld a, [wTempScrollMenuItem]
	ld [wCurScrollMenuItem], a
	jp .booster_pack_menu

.BoosterPackMenuParams:
	db 3, 2 ; x,y offset
	db 2 ; y separation
	db 0 ; x separation
	db 5 ; number of items
	db SYM_CURSOR_R ; visible cursor
	db SYM_SPACE ; invisible cursor
	dw NULL ; update func

.BoosterPackCardsMenuParams
	db 1, 4 ; x,y offset
	db 2 ; y separation
	db 0 ; x separation
	db 7 ; number of items
	db SYM_CURSOR_R ; visible cursor
	db SYM_SPACE ; invisible cursor
	dw NULL ; update func

.CountCardIDs:
	ld hl, wBoosterPackCardList
	ld b, $00
.loop_count_card_ids
	ld e, [hl]
	inc hl
	ld d, [hl]
	inc hl
	call CheckIfCardIDIsZero
	jr c, .zero
	inc b
	jr .loop_count_card_ids
.zero
	ld a, b
	ld [wNumCardListEntries], a
	ret

.InitList:
	xor a
	ld [wTileMapFill], a
	call ZeroObjectPositions
	call EmptyScreen
	ld a, $01
	ld [wVBlankOAMCopyToggle], a
	call LoadMenuCursorTile
	call LoadSymbolsFont
	call LoadDuelCardSymbolTiles
	bank1call SetDefaultPalettes
	lb de, $3c, $ff
	call SetupText
	lb de, 1, 1
	call InitTextPrinting

	ld a, [wCardAlbumBoosterPack]
	cp PROMOTIONAL
	jr nz, .check_team_rockets_ambition
	ldtx hl, Item8PromotionalCardText
	ld e, NUM_CARDS_PROMOTIONAL

	; check which Phantom cards were obtained
	; and adjust card count in e
	ld a, [wOwnedPhantomCards]
	bit PROMO_VENUSAUR_LV64_F, a
	jr z, .check_mew
	inc e
.check_mew
	bit PROMO_MEW_LV15_F, a
	jr z, .check_lugia
	inc e
.check_lugia
	bit PROMO_LUGIA_F, a
	jr z, .check_here_comes_team_rocket
	inc e
.check_here_comes_team_rocket
	bit PROMO_HERE_COMES_TEAM_ROCKET_F, a
	jr z, .got_booster_pack
	inc e
	jr .got_booster_pack

.check_team_rockets_ambition
	cp TEAM_ROCKETS_AMBITION
	jr nz, .check_we_are_team_rocket
	ldtx hl, Item7TeamRocketsAmbitionText
	ld e, NUM_CARDS_TEAM_ROCKETS_AMBITION
	jr .got_booster_pack

.check_we_are_team_rocket
	cp WE_ARE_TEAM_ROCKET
	jr nz, .check_sky_flying_pokemon
	ld hl, SetWindowOn
	ld e, NUM_CARDS_WE_ARE_TEAM_ROCKET
	jr .got_booster_pack

.check_sky_flying_pokemon
	cp SKY_FLYING_POKEMON
	jr nz, .check_psychic_battle
	ldtx hl, Item5SkyFlyingPokemonText
	ld e, NUM_CARDS_SKY_FLYING_POKEMON
	jr .got_booster_pack

.check_psychic_battle
	cp PSYCHIC_BATTLE
	jr nz, .check_island_of_fossil
	ldtx hl, Item4PsychicBattleText
	ld e, NUM_CARDS_PSYCHIC_BATTLE
	jr .got_booster_pack

.check_island_of_fossil
	cp ISLAND_OF_FOSSIL
	jr nz, .check_legendary_power
	ldtx hl, Item3IslandOfFossilText
	ld e, NUM_CARDS_ISLAND_OF_FOSSIL
	jr .got_booster_pack

.check_legendary_power
	cp LEGENDARY_POWER
	jr nz, .beginning_pokemon
	ld hl, Set_OBJ_8x16
	ld e, NUM_CARDS_LEGENDARY_POWER
	jr .got_booster_pack

.beginning_pokemon
	ldtx hl, Item1BeginningPokemonText
	ld e, NUM_CARDS_BEGINNING_POKEMON
.got_booster_pack
	; prints "X/Y" where X is number of cards owned in the set
	; and Y is the total card count of the Card Set
	push de
	call ProcessTextFromID
	call .GetNumberOfOwnedCards
	lb de, 14, 1
	call InitTextPrinting
	ld a, [wBoosterPackCardListNumItems]
	ld hl, wDefaultText
	call ConvertToNumericalDigits
	ld [hl], TX_SYMBOL
	inc hl
	ld [hl], SYM_SLASH
	inc hl
	pop de
	ld a, e ; number of cards
	call ConvertToNumericalDigits
	ld [hl], TX_END
	ld hl, wDefaultText
	call ProcessText
	lb de,  0,  2
	lb bc, 20, 16
	call DrawRegularTextBox
	call EnableLCD
	ret

.GetNumberOfOwnedCards:
	ld hl, wBoosterPackCardCounts
	ld b, 0
.loop_counts
	ld a, [hli]
	cp $ff
	jr z, .got_num_items
	cp CARD_NOT_OWNED
	jr z, .loop_counts
	inc b
	jr .loop_counts
.got_num_items
	ld a, b
	ld [wBoosterPackCardListNumItems], a
	ret

.ShowBoosterPackMenu:
	xor a
	ld [wTileMapFill], a
	call EmptyScreen
	ld a, [hffbe]
	dec a
	jp nz, .draw_box
	ld [hffbe], a
	call ZeroObjectPositions
	ld a, $01
	ld [wVBlankOAMCopyToggle], a

	call LoadMenuCursorTile
	call LoadSymbolsFont
	call LoadDuelCardSymbolTiles
	bank1call SetDefaultPalettes
	lb de, $3c, $ff
	call SetupText

	; set all Card Sets as available
	ld a, NUM_CARD_SETS
	ld hl, wBoosterPackItems
	call ClearNBytesFromHL

	; check whether player has had promotional cards
	call EnableSRAM
	ld a, [sBoosterPacksObtained]
	call DisableSRAM
	cp $ff
	jr z, .draw_box ; has all sets

	; copies whole card collection from SRAM to WRAM,
	; in two batches of $100 cards each
	call EnableSRAM
	ld hl, sCardCollection
	ld de, wTempCardCollection
	ld b, $00
	call CopyBBytesFromHLToDE_Bank02
	ld hl, sCardCollection + $100
	ld de, wTempCardCollection + $100
	ld b, $00
	call CopyBBytesFromHLToDE_Bank02
	call DisableSRAM

	ld b, %1
	ld c, CIRCLE
.loop_sets
	call EnableSRAM
	ld a, [sBoosterPacksObtained]
	call DisableSRAM
	and b
	jr nz, .next_set
	push bc
	ld a, c
	call .CheckHasCardFromSet
	pop bc
	jr c, .has_set_card
	ld hl, wBoosterPackItems
	ld e, c
	ld d, $00
	add hl, de
	ld [hl], TRUE
	jr .next_set
.has_set_card
	call EnableSRAM
	ld a, [sBoosterPacksObtained]
	or b
	ld [sBoosterPacksObtained], a
	call DisableSRAM
.next_set
	sla b
	inc c
	ld a, NUM_CARD_SETS
	cp c
	jr nz, .loop_sets

.draw_box
	lb de,  0,  0
	lb bc, 20, 13
	call DrawRegularTextBox
	lb de, 1, 0
	ldtx hl, BoosterPackTitleText ; title
	call Func_2c4b
	farcall FillBoosterPackMenuItems
	ldtx hl, ViewWhichCardFileText
	call DrawWideTextBox_PrintText
	farcall UpdateBoosterPackMenuArrows
	ret

; returns carry if any card
; with given set is owned
; b = set
.CheckHasCardFromSet:
	ld de, 0
	ld hl, wTempCardCollection + $1
	ld b, a
.loop_card_ids
	inc de
	ld a, [hli]
	cp CARD_NOT_OWNED
	jr c, .owns
; not owned
	cp16 NUM_CARDS
	ret nc
	jr .loop_card_ids
.owns
	push bc
	call GetCardTypeRarityAndSet
	ld a, c ; set
	pop bc
	ccf
	ret nc
	cp NUM_CARD_SETS
	jr nz, .ok
	xor a ; BEGINNING_POKEMON
.ok
	cp b
	jr nz, .loop_card_ids
	; found
	scf
	ret

PrinterMenu_PokemonCards:
	call WriteCardListsTerminatorBytes
	call PrintPlayersCardsHeaderInfo
	xor a
	ld [wScrollMenuScrollOffset], a
	ld [wCurCardTypeFilter], a
	call PrintFilteredCardSelectionList
	call EnableLCD
	xor a
	ld hl, FiltersCardSelectionParams
	call InitializeScrollMenuParameters

.loop_frame_1
	call DoFrame
	ld a, [wCurCardTypeFilter]
	ld b, a
	ld a, [wTempCardTypeFilter]
	cp b
	jr z, .handle_input
	ld [wCurCardTypeFilter], a
	ld hl, wScrollMenuScrollOffset
	ld [hl], $00
	call PrintFilteredCardSelectionList
	ld hl, hffbb
	ld [hl], $01
	call PrintPlayersCardsText
	ld hl, hffbb
	ld [hl], $00
	ld a, NUM_FILTERS
	ld [wNumMenuItems], a
.handle_input
	ldh a, [hDPadHeld]
	and PAD_DOWN
	jr z, .asm_b33b
; d_down
	call ConfirmSelectionAndReturnCarry
	jr .asm_b348
.asm_b33b
	call HandleCardSelectionInput
	jr nc, .loop_frame_1
	ld a, [hCurMenuItem]
	cp $ff
	jr nz, .asm_b348
	ret

.asm_b348
	ld a, [wBoosterPackCardListSize]
	or a
	jr z, .loop_frame_1

	xor a
	ld hl, GeneralCardListMenuParams
	call InitializeScrollMenuParameters
	ld a, [wBoosterPackCardListSize]
	ld [wNumCardListEntries], a
	ld hl, wNumVisibleCardListEntries
	cp [hl]
	jr nc, .asm_b367
	ld [wNumMenuItems], a
	ld [wTempScrollMenuNumVisibleItems], a
.asm_b367
	ld hl, GeneralCardListUpdateFunc
	ld d, h
	ld a, l
	ld hl, wScrollMenuScrollFunc
	ld [hli], a
	ld [hl], d
	xor a
	ld [wd119], a

.loop_frame_2
	call DoFrame
	ldh a, [hDPadHeld]
	and PAD_UP
	jr z, .asm_b38e
	ld a, [wTempCardTypeFilter]
	ld hl, wScrollMenuScrollOffset
	add [hl]
	jr nz, .asm_b38e
	ld a, $ff
	ld [hCurMenuItem], a
	jr .asm_b3e7
.asm_b38e
	call HandleSelectUpAndDownInList
	jr c, .loop_frame_2
	call HandleScrollListInput
	jr c, .asm_b3e7
	ldh a, [hDPadHeld]
	and PAD_START
	jr z, .loop_frame_2
; start btn
	ld a, $01
	call PlayAcceptOrDeclineSFX
	ld a, [wNumMenuItems]
	ld [wTempScrollMenuNumVisibleItems], a
	ld a, [wTempCardTypeFilter]
	ld [wTempCurMenuItem], a

	; set wTempCardList as current card list
	; and show card page screen
	ld de, wTempCardList
	ld hl, wCurCardListPtr
	ld [hl], e
	inc hl
	ld [hl], d
	call OpenCardPageFromCardList
	call PrintPlayersCardsHeaderInfo

.asm_b3be
	ld hl, FiltersCardSelectionParams
	call InitializeScrollMenuParameters
	ld a, [wCurCardTypeFilter]
	ld [wTempCardTypeFilter], a
	call DrawHorizontalListCursor_Visible
	call PrintCardSelectionList
	call EnableLCD
	ld hl, GeneralCardListMenuParams
	call InitializeScrollMenuParameters
	ld a, [wTempScrollMenuNumVisibleItems]
	ld [wNumMenuItems], a
	ld a, [wTempCurMenuItem]
	ld [wTempCardTypeFilter], a
	jr .loop_frame_2

.asm_b3e7
	call DrawListCursor_Invisible
	ld a, [wNumMenuItems]
	ld [wTempScrollMenuNumVisibleItems], a
	ld a, [wTempCardTypeFilter]
	ld [wTempCurMenuItem], a
	ld a, [hCurMenuItem]
	cp $ff
	jr nz, .asm_b40c

	ld hl, FiltersCardSelectionParams
	call InitializeScrollMenuParameters
	ld a, [wCurCardTypeFilter]
	ld [wTempCardTypeFilter], a
	jp .loop_frame_1

.asm_b40c
	call DrawListCursor_Visible
	call .Func_b45d
	lb de, 1, 1
	call InitTextPrinting
	ld hl, $2f6
	call ProcessTextFromID
	ld a, $01
	ld hl, Data_ad05
	call InitializeScrollMenuParameters
.loop_frame_3
	call DoFrame
	call HandleCardSelectionInput
	jr nc, .loop_frame_3
	ld a, [hCurMenuItem]
	or a
	jr nz, .asm_b454
	ld hl, wTempCardList
	ld a, [wTempCurMenuItem]
	add a
	ld c, a
	ld b, $00
	add hl, bc
	ld a, [wScrollMenuScrollOffset]
	add a
	ld c, a
	ld b, $00
	add hl, bc
	ld e, [hl]
	inc hl
	ld d, [hl]
	farcall RequestToPrintCard
	call PrintPlayersCardsHeaderInfo
	jp .asm_b3be

.asm_b454
	call .Func_b45d
	call PrintPlayersCardsHeaderInfo_SkipEmptyScreen
	jp .asm_b3be

.Func_b45d:
	xor a
	lb hl, 0, 0
	lb de, 0, 0
	lb bc, 20, 4
	call FillRectangle
	ld a, [wConsole]
	cp CONSOLE_CGB
	ret nz ; exit if not CGB

	xor a
	lb hl, 0, 0
	lb de, 0, 0
	lb bc, 20, 4
	call BankswitchVRAM1
	call FillRectangle
	call BankswitchVRAM0
	ret

Data_ad05:
	db 3 ; x pos
	db 3 ; y pos
	db 0 ; y spacing
	db 4 ; x spacing
	db 2 ; num entries
	db SYM_CURSOR_R ; visible cursor tile
	db SYM_SPACE ; invisible cursor tile
	dw NULL ; wCardListHandlerFunction

PrinterMenu_CardList:
	call WriteCardListsTerminatorBytes
	call PrepareMenuGraphics
	lb bc, 0, 4
	ld a, SYM_BOX_TOP
	call FillBGMapLineWithA

	xor a
	ld [wScrollMenuScrollOffset], a
	ld [wCurCardTypeFilter], a
	call PrintFilteredCardSelectionList
	call EnableLCD
	lb de, 1, 1
	call InitTextPrinting
	ldtx hl, PrintCardListPromptText
	call ProcessTextFromID
	ld a, $01
	ld hl, Data_ad05
	call InitializeScrollMenuParameters
.loop_frame
	call DoFrame
	call HandleCardSelectionInput
	jr nc, .loop_frame
	ld a, [hCurMenuItem]
	or a
	ret nz
	farcall PrintCardList
	ret

PrinterMenu:
	farcall ConnectPrinter
	ret c ; error occurred
	xor a
.loop
	ld hl, .MenuParameters
	call InitializeMenuParameters
	call EmptyScreenAndLoadFontDuelAndHandCardsIcons
	lb de, 4, 0
	lb bc, 12, 12
	call DrawRegularTextBox
	lb de, 6, 2
	call InitTextPrinting
	ldtx hl, PrintMenuItemsText
	call ProcessTextFromID
	ldtx hl, WhatToPrintPromptText
	call DrawWideTextBox_PrintText
	call EnableLCD
.loop_input
	call DoFrame
	call HandleMenuInput
	jr nc, .loop_input
	ldh a, [hCurScrollMenuItem]
	cp $ff
	call z, .QuitPrint
	ld [wSelectedPrinterMenuItem], a
	ld hl, .MenuFunctionTable
	call JumpToFunctionInTable
	ld a, [wSelectedPrinterMenuItem]
	jr .loop

.QuitPrint:
	add sp, $2 ; exit menu
	ldtx hl, PrinterTurningOffReminderText
	call DrawWideTextBox_WaitForInput
	ret

.MenuFunctionTable:
	dw PrinterMenu_PokemonCards
	dw PrinterMenu_DeckConfiguration
	dw PrinterMenu_CardList
	dw .PrintQuality
	dw .QuitPrint

.MenuParameters:
	db 5, 2 ; cursor x, cursor y
	db 2 ; y displacement between items
	db 5 ; number of items
	db SYM_CURSOR_R ; cursor tile number
	db SYM_SPACE ; tile behind cursor
	dw NULL ; function pointer if non-0

.PrintQuality:
	ldtx hl, PrinterContrastSettingsPromptText
	call DrawWideTextBox_PrintText
	call EnableSRAM
	ld a, [sPrinterContrastLevel]
	call DisableSRAM
	ld hl, .PrinterQualityMenuParams
	call InitializeScrollMenuParameters
.loop_input_quality
	call DoFrame
	call HandleCardSelectionInput
	jr nc, .loop_input_quality
	ld a, [hCurMenuItem]
	cp $ff ; cancel
	jr z, .re_draw_menu
	call EnableSRAM
	ld [sPrinterContrastLevel], a
	call DisableSRAM
.re_draw_menu
	add sp, $2 ; exit menu
	ld a, [wSelectedPrinterMenuItem]
	ld hl, .MenuParameters
	call InitializeMenuParameters
	ldtx hl, WhatToPrintPromptText
	call DrawWideTextBox_PrintText
	jr .loop_input

.PrinterQualityMenuParams
	db 5, 16 ; x,y offset
	db 0 ; y separation
	db 2 ; x separation
	db 5 ; number of items
	db SYM_CURSOR_R ; visible cursor
	db SYM_SPACE ; invisible cursor
	dw NULL ; update func
; 0xb57c

SECTION "Bank 2@7947", ROMX[$7947], BANK[$2]

; hl = text ID for text box
DeckDiagnosisResult:
	ld a, l
	ld [wd394 + 0], a
	ld a, h
	ld [wd394 + 1], a

	call GetSRAMPointerToCurDeck
	call EnableSRAM
	call CopyDeckName
	call DisableSRAM
	ld hl, wDefaultText
	ld de, wCurDeckName
	call CopyListFromHLToDE

	call WriteCardListsTerminatorBytes
	call .InitMenu
	xor a
	ld [wScrollMenuScrollOffset], a
	call .SortAndPrintCardList

	xor a
	ld hl, GeneralCardListMenuParams
	call InitializeScrollMenuParameters
	ld a, [wNumUniqueCards]
	ld [wNumCardListEntries], a
	ld hl, wNumVisibleCardListEntries
	cp [hl]
	jr nc, .set_update_func
	ld [wNumMenuItems], a
.set_update_func
	ld hl, .UpdateFunc
	ld d, h
	ld a, l
	ld hl, wScrollMenuScrollFunc
	ld [hli], a
	ld [hl], d
	xor a
	ld [wd119], a

.loop_input
	call DoFrame
	call HandleSelectUpAndDownInList
	jr c, .loop_input
	call HandleScrollListInput
	jr c, .selection_made
	ldh a, [hDPadHeld]
	and PAD_START
	jr z, .loop_input
.open_card_page
	ld a, SFX_01
	call PlayAcceptOrDeclineSFX
	ld a, [wNumMenuItems]
	ld [wTempScrollMenuNumVisibleItems], a
	ld a, [wCurScrollMenuItem]
	ld [wTempCurMenuItem], a
	ld de, wUniqueDeckCardList
	ld hl, wCurCardListPtr
	ld [hl], e
	inc hl
	ld [hl], d
	call OpenCardPageFromCardList
	call .InitMenu
	call .PrintCardList
	call EnableLCD
	ld hl, GeneralCardListMenuParams
	call InitializeScrollMenuParameters
	ld a, [wTempScrollMenuNumVisibleItems]
	ld [wNumMenuItems], a
	ld a, [wTempCurMenuItem]
	ld [wCurScrollMenuItem], a
	jr .loop_input

.selection_made
	call DrawListCursor_Invisible
	ld a, [wCurScrollMenuItem]
	ld [wTempCurMenuItem], a
	ld a, [hCurMenuItem]
	cp $ff
	jr nz, .open_card_page
	ret ; exit menu

.UpdateFunc:
	ld a, $01
	ldh [hffbb], a
	call .PrintText
	xor a
	ldh [hffbb], a
	call .PrintCardList
	ret

.InitMenu:
	call PrepareMenuGraphics
	lb bc, 0, 4
	ld a, SYM_BOX_TOP
	call FillBGMapLineWithA
	call .PrintText
	call EnableLCD
	ret

.PrintText:
	ld hl, wCurDeckName
	ld de, wDefaultText
	call CopyListFromHLToDE
	xor a
	ld [wTxRam2 + 0], a
	ld [wTxRam2 + 1], a
	ld a, [wd394 + 0]
	ld l, a
	ld a, [wd394 + 1]
	ld h, a
	lb de, 1, 1
	call PrintTextNoDelay_Init
	ret

.SortAndPrintCardList:
	call SortCurDeckCardsByID
	call CreateCurDeckUniqueCardList
	ld a, 7
	ld [wNumVisibleCardListEntries], a
	lb de, 2, 5
	ld hl, wCardListCoords
	ld [hl], e
	inc hl
	ld [hl], d
	ld a, SYM_SPACE
	ld [wCursorAlternateTile], a
	call .PrintCardList ; can be fallthrough
	ret

.PrintCardList:
	push bc
	ld hl, wCardListCoords
	ld e, [hl]
	inc hl
	ld d, [hl]
	ld b, 19
	ld c, e

	ld a, [wScrollMenuScrollOffset]
	or a
	jr z, .asm_ba63
	ld a, SYM_CURSOR_U
	jr .asm_ba65
.asm_ba63
	ld a, SYM_SPACE
.asm_ba65
	call WriteByteToBGMap0

	ld a, [wScrollMenuScrollOffset]
	add a
	ld c, a
	ld b, $00
	ld hl, wUniqueDeckCardList
	add hl, bc
	ld a, [wNumVisibleCardListEntries]
.loop_list_entries
	push de
	or a
	jr z, .done_print_card_list
	ld b, a
	ld e, [hl]
	inc hl
	ld d, [hl]
	inc hl
	call CheckIfCardIDIsZero
	jr c, .at_last_entry
	call AddCardIDToVisibleList
	call LoadCardDataToBuffer1_FromCardID
	ld a, 14
	push bc
	push hl
	push de
	call CopyCardNameAndLevel
	pop de
	call .PrintCardCount
	pop hl
	pop bc
	pop de
	push hl
	call InitTextPrinting
	ld hl, wDefaultText
	call ProcessText
	pop hl
	ld a, b
	dec a
	inc e
	inc e
	jr .loop_list_entries

.done_print_card_list
	ld e, [hl]
	inc hl
	ld d, [hl]
	call CheckIfCardIDIsZero
	jr c, .at_last_entry
	pop de
	xor a
	ld [wUnableToScrollDown], a
	ld a, SYM_CURSOR_D
	jr .asm_bac3
.at_last_entry
	pop de
	ld a, TRUE
	ld [wUnableToScrollDown], a
	ld a, SYM_SPACE
.asm_bac3
	ld b, 19
	ld c, e
	dec c
	dec c
	call WriteByteToBGMap0
	pop bc
	ret

.PrintCardCount:
	push af
	push bc
	push de
	push hl
.asm_bad1
	ld a, [hl]
	or a
	jr z, .asm_bad8
	inc hl
	jr .asm_bad1
.asm_bad8
	call GetCountOfCardInCurDeck
	call ConvertToNumericalDigits
	ldfw bc, "枚"
	ld [hl], c
	inc hl
	ld [hl], b
	inc hl
	ld [hl], TX_END
	pop hl
	pop de
	pop bc
	pop af
	ret
; 0xbaec

SECTION "Bank 2@7af6", ROMX[$7af6], BANK[$2]

PrinterMenu_DeckConfiguration:
	farcall _PrinterMenu_DeckConfiguration
	ret
; 0xbafb
