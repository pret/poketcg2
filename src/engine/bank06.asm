SECTION "Bank 6@58f8", ROMX[$58f8], BANK[$6]

; clears saved data (card Collection/saved decks/Card Pop! data/etc)
; then adds the old starter decks as saved decks
; marks all cards in Collection as not owned
InitSaveData:
; clear card and deck save data
	call EnableSRAM
	ld a, PLAYER_TURN
	ldh [hWhoseTurn], a
	ld hl, sCardAndDeckSaveData
	ld bc, sCardAndDeckSaveDataEnd - sCardAndDeckSaveData
.loop_clear
	xor a
	ld [hli], a
	dec bc
	ld a, c
	or b
	jr nz, .loop_clear

	; these have been kept from Pokémon TCG 1
	; and correspond to the old starter decks
	; they will be erased from SRAM afterwards
	ld a, SWEAT_ANTI_GR1_DECK ; old CHARMANDER_AND_FRIENDS_DECK
	ld hl, sSavedDeck1
	call .SaveDeck
	ld a, VENGEFUL_ANTI_GR3_DECK ; old SQUIRTLE_AND_FRIENDS_DECK
	ld hl, sSavedDeck2
	call .SaveDeck
	ld a, SAMS_PRACTICE_DECK ; old BULBASAUR_AND_FRIENDS_DECK
	ld hl, sSavedDeck3
	call .SaveDeck

; marks all cards in Collection to not owned
	call EnableSRAM
	ld hl, sCardCollection
	ld bc, CARD_COLLECTION_SIZE
.loop_collection
	ld [hl], CARD_NOT_OWNED
	inc hl
	dec bc
	ld a, c
	or b
	jr nz, .loop_collection

	ld hl, sSavedDuel
	xor a
	ld [hli], a
	ld [hli], a ; sSavedDuelChecksum
	ld [hl], a

	; clears Card Pop! names
	ld a, BANK(sCardPopNameList)
	call BankswitchSRAM
	ld hl, sCardPopNameList
	ld c, CARDPOP_NAME_LIST_MAX_ELEMS
.loop_card_pop_names
	ld [hl], $0
	ld de, NAME_BUFFER_LENGTH
	add hl, de
	dec c
	jr nz, .loop_card_pop_names
	ld hl, s1a100
	ld [hl], $00
	xor a
	call BankswitchSRAM

; saved configuration options
	ld a, 2
	ld [sPrinterContrastLevel], a
	ld a, $2
	ld [sTextSpeed], a
	ld [wTextSpeed], a

; miscellaneous data
	xor a
	ld [s0a007], a
	ld [s0a009], a
	ld [s0a004], a
	ld [sTotalCardPopsDone], a
	ld [s0a00a], a
	ld hl, s0a020
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld [hli], a

	farcall Func_8f10
	call DisableSRAM
	ret

; saves deck in a to SRAM address in hl
.SaveDeck:
	push de
	push bc
	push hl
	ld [wcc16], a
	call LoadDeck
	jr c, .done
	call .LoadDeckName
	pop hl
	call EnableSRAM
	push hl
	ld de, wDefaultText
.loop_copy_name
	ld a, [de]
	inc de
	ld [hli], a
	or a
	jr nz, .loop_copy_name
	pop hl
	push hl
	ld de, DECK_NAME_SIZE
	add hl, de
	ld de, wPlayerDeck
	bank1call SaveDeckCards
	call DisableSRAM
	or a
.done
	pop hl
	pop bc
	pop de
	ret

.LoadDeckName:
	ld a, [wcc16]
	sub 3
	farcall LoadDeckIDData
	ld hl, wOpponentDeckName
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld de, wDuelTempList
	call CopyText
	ld c, $0f
	ld hl, wDuelTempList
	ld de, wDefaultText
.loop_chars
	ld a, [hl]
	or a
	jr z, .terminating_byte
	cp $0f
	jr nz, .asm_199dc
	ld c, a
	jr .next_char
.asm_199dc
	cp $0e
	jr nz, .asm_199e3
	ld c, a
	jr .next_char
.asm_199e3
	cp $06
	jr c, .copy_2_bytes
	ld a, c
	ld [de], a
	inc de
	ld a, [hl]
	ld [de], a
	inc de
.next_char
	inc hl
	jr .loop_chars
.copy_2_bytes
	ld a, [hli]
	ld [de], a
	inc de
	ld a, [hli]
	ld [de], a
	inc de
	jr .loop_chars

.terminating_byte
	ld [de], a
	ret
; 0x199fa

SECTION "Bank 6@601a", ROMX[$601a], BANK[$6]

ClearCardPopNameList:
	call EnableSRAM
	ld a, BANK(sCardPopNameList)
	call BankswitchSRAM
	ld hl, sCardPopNameList
	ld de, NAME_BUFFER_LENGTH
	ld c, CARDPOP_NAME_LIST_MAX_ELEMS
.loop_clear
	ld [hl], $0
	add hl, de
	dec c
	jr nz, .loop_clear
	; the intention was to clear sTotalCardPopsDone,
	; but since we are in SRAM1, it clears a byte
	; in sCardPopNameList instead
	xor a
	ld [sCardPopNameList + $5], a
	call BankswitchSRAM ; SRAM0
	call DisableSRAM
	ret
; 0x1a03b

SECTION "Bank 6@6e14", ROMX[$6e14], BANK[$6]

LoadHandCardsIcon:
	ld hl, HandCardsGfx
	ld de, v0Tiles2 + $38 tiles
	ld b, 4 tiles
	call Func_1b8f1
	ret

HandCardsGfx:
	INCBIN "gfx/hand_cards.2bpp"

WhatIsYourNameData:
	textitem 1, 1, Text0287
	db $ff ; end
; 0x1ae65

SECTION "Bank 6@6e92", ROMX[$6e92], BANK[$6]

; play different sfx by a.
; if a is 0xff play SFX_03 (usually following a B press),
; else play SFX_02 (usually following an A press).
PlayAcceptOrDeclineSFX:
	push af
	inc a
	jr z, .asm_1ae9a
	ld a, SFX_02
	jr .asm_1ae9c
.asm_1ae9a
	ld a, SFX_03
.asm_1ae9c
	call PlaySFX
	pop af
	ret

; get player name from the user into hl
InputPlayerName:
	ld e, l
	ld d, h
	ld a, MAX_PLAYER_NAME_LENGTH
	ld hl, WhatIsYourNameData
	lb bc, 12, 1
	call InitializeInputName
	call Set_OBJ_8x8

	xor a
	ld [wd3ef], a
	ld [wTileMapFill], a
	call EmptyScreen
	call ZeroObjectPositions
	ld a, $01
	ld [wVBlankOAMCopyToggle], a
	call LoadSymbolsFont
	lb de, $38, $bf
	call SetupText
	call LoadFullWidthTextCursorTile
	xor a ; NAME_MODE_HIRAGANA
	ld [wNamingScreenMode], a

	call UpdateNamingScreenUI

	xor a
	ld [wNamingScreenCursorX], a
	ld [wNamingScreenCursorY], a

	ld a, 9
	ld [wNamingScreenNumColumns], a
	ld a, 7
	ld [wNamingScreenNumRows], a
	ld a, SYM_CURSOR_R
	ld [wVisibleCursorTile], a
	ld a, SYM_SPACE
	ld [wInvisibleCursorTile], a
.loop
	ld a, $01
	ld [wVBlankOAMCopyToggle], a
	call DoFrame

	call UpdateRNGSources

	ldh a, [hDPadHeld]
	and START
	jr z, .check_select
	ld a, $01
	call PlayAcceptOrDeclineSFX
	call HideCursorAtCharPosition
	ld a, 6
	ld [wNamingScreenCursorY], a
	inc a ; 7
	ld [wNamingScreenCursorX], a
	call ShowCursorAtCharPosition
	jr .loop

.check_select
	ldh a, [hDPadHeld]
	and SELECT
	jr z, .asm_1af3b
	ld a, $01
	call PlayAcceptOrDeclineSFX
	ld a, [wNamingScreenMode]
	inc a
	cp NUM_NAME_MODES
	jr c, .got_mode
	xor a ; NAME_MODE_HIRAGANA
.got_mode
	ld [wNamingScreenMode], a
	xor a
	ld [wNamingScreenCursorX], a
	ld [wNamingScreenCursorY], a
	call UpdateNamingScreenUI
	jr .loop

.asm_1af3b
	call HandleNamingScreenInput
	jr nc, .loop
	cp $ff
	jr z, .remove_last_char
	call SelectKeyboardItem
	jr nc, .loop
	call FinalizeInputName
	ret

.remove_last_char
	ld a, [wNamingScreenBufferLength]
	or a
	jr z, .loop
	ld e, a
	ld d, $00
	ld hl, wNamingScreenBuffer
	add hl, de
	dec hl
	dec hl
	ld [hl], TX_END
	ld hl, wNamingScreenBufferLength
	dec [hl]
	dec [hl]
	call ProcessTextWithUnderbar
	jr .loop

; called when naming (either player's or deck's) starts.
; a = maximum length of name (depending on whether player's or deck's).
; bc = position of name.
; de = dest. pointer.
; hl = pointer to text item of the question.
InitializeInputName:
	ld [wNamingScreenBufferMaxLength], a

	; wNamingScreenNamePosition = bc
	push hl
	ld hl, wNamingScreenNamePosition
	ld [hl], b
	inc hl
	ld [hl], c
	pop hl

	; wNamingScreenQuestionPointer = hl
	ld b, h
	ld c, l
	ld hl, wNamingScreenQuestionPointer
	ld [hl], c
	inc hl
	ld [hl], b

	; wNamingScreenDestPointer = de
	ld hl, wNamingScreenDestPointer
	ld [hl], e
	inc hl
	ld [hl], d

	; clear the name buffer
	ld a, NAMING_SCREEN_BUFFER_LENGTH
	ld hl, wNamingScreenBuffer
	farcall ClearBytesInHL

	ld a, [de]
	cp $06
	jr z, .get_length
	ld hl, wNamingScreenBuffer
	ld a, [wNamingScreenBufferMaxLength]
	ld b, a
	inc b
.loop
	ld a, [de]
	inc de
	ld [hli], a
	dec b
	jr nz, .loop
.get_length
	ld hl, wNamingScreenBuffer
	call GetTextLengthInTiles
	ld a, c
	ld [wNamingScreenBufferLength], a
	ret

FinalizeInputName:
	ld hl, wNamingScreenDestPointer
	ld e, [hl]
	inc hl
	ld d, [hl]
	ld l, e
	ld h, d
	ld de, wNamingScreenBuffer
	ld a, [wNamingScreenBufferMaxLength]
	ld b, a
	inc b
	jr InitializeInputName.loop

; draws textbox around keyboard,
; the naming question and the actual
; items in the keyboard
UpdateNamingScreenUI:
	call DrawTextboxForKeyboard
	call ProcessTextWithUnderbar
	ld hl, wNamingScreenQuestionPointer
	ld c, [hl]
	inc hl
	ld a, [hl]
	ld h, a
	or c
	jr z, .print
	; print the question string.
	ld l, c
	call PlaceTextItems
.print
	ld hl, .text_items1
	call PlaceTextItems

	ld a, [wNamingScreenMode]
	or a
	jr nz, .asm_1afe5
; NAME_MODE_HIRAGANA
	ld hl, .text_items2
	call PlaceTextItems
	ldtx hl, Text0288
	jr .asm_1b00a
.asm_1afe5
	dec a
	jr nz, .asm_1aff3
; NAME_MODE_KATAKANA
	ld hl, .text_items3
	call PlaceTextItems
	ldtx hl, Text0289
	jr .asm_1b00a
.asm_1aff3
	dec a
	jr nz, .asm_1b001
; NAME_MODE_UPPER_ABC
	ld hl, .text_items4
	call PlaceTextItems
	ldtx hl, Text028a
	jr .asm_1b00a
.asm_1b001
; NAME_MODE_LOWER_ABC
	ld hl, .text_items5
	call PlaceTextItems
	ldtx hl, Text028b
.asm_1b00a
	lb de, 2, 4
	call InitTextPrinting
	call ProcessTextFromID
	call EnableLCD
	ret

.text_items1:
	textitem 16, 16, Text0286
	db $ff ; end

.text_items2:
	textitem  2, 16, Text0283
	textitem  7, 16, Text0284
	textitem 12, 16, Text0285
	db $ff ; end

.text_items3:
	textitem  2, 16, Text0282
	textitem  7, 16, Text0284
	textitem 12, 16, Text0285
	db $ff ; end

.text_items4:
	textitem  2, 16, Text0282
	textitem  7, 16, Text0283
	textitem 12, 16, Text0285
	db $ff ; end

.text_items5:
	textitem  2, 16, Text0282
	textitem  7, 16, Text0283
	textitem 12, 16, Text0284
	db $ff ; end

DrawTextboxForKeyboard:
	lb de, 0, 3
	lb bc, 20, 15
	call DrawRegularTextBox
	ret

ProcessTextWithUnderbar:
	ld hl, wNamingScreenNamePosition
	ld d, [hl]
	inc hl
	ld e, [hl]
	push de
	call InitTextPrinting
	ld a, [wNamingScreenBufferMaxLength]
	ld e, a
	ld a, $14
	sub e
	inc a
	ld e, a ; = $14 - wNamingScreenBufferMaxLength + 1
	ld d, $00
	ld hl, .underbar_chars
	add hl, de
	call ProcessText
	pop de
	call InitTextPrinting
	ld hl, wNamingScreenBuffer
	call ProcessText
	ret

.underbar_chars
	db "W" ; stray byte
REPT $a
	textfw4 "_"
ENDR
	done

HandleNamingScreenInput:
.start
	xor a
	ld [wNamingScreenInputSFX], a
	ldh a, [hDPadHeld]
	or a
	jp z, .check_btns
	ld b, a
	ld a, [wNamingScreenNumRows]
	ld c, a
	ld a, [wNamingScreenCursorX]
	ld h, a
	ld a, [wNamingScreenCursorY]
	ld l, a
	bit D_UP_F, b
	jr z, .check_d_down
	; move cursor down
	dec a
	bit 7, a
	jr z, .apply_y_value
	; wrap around
	ld a, c
	dec a
	jr .apply_y_value
.check_d_down
	bit D_DOWN_F, b
	jr z, .horizontal_directions
	; move cursor up
	inc a
	cp c
	jr c, .apply_y_value
	; wrap around
	xor a
	jr .apply_y_value

.horizontal_directions
	ld a, [wNamingScreenNumColumns]
	ld c, a
	ld a, h
	bit D_LEFT_F, b
	jr z, .check_d_right
	ld d, a
	ld a, 6 ; is last row?
	cp l
	ld a, d
	jr nz, .move_left
	; handle last row movement
	push hl
	push bc
	push af
	call GetCharInfoFromPos
	inc hl
	inc hl
	inc hl
	inc hl
	inc hl
	ld a, [hl]
	dec a
	ld d, a
	pop af
	pop bc
	pop hl
	sub d ; cursor_x - d
	cp -1
	jr nz, .asm_1b0f1
	; wrap around
	ld a, c
	sub 2
	jr .apply_x_value
.asm_1b0f1
	cp -2
	jr nz, .move_left
	; wrap around
	ld a, c
	sub 3
	jr .apply_x_value

.move_left
	dec a
	bit 7, a
	jr z, .apply_x_value
	ld a, c
	dec a
	jr .apply_x_value

.check_d_right
	bit D_RIGHT_F, b
	jr z, .check_btns
	ld d, a
	ld a, 6 ; is last row?
	cp l
	ld a, d
	jr nz, .move_right
	push hl
	push bc
	push af
	call GetCharInfoFromPos
	inc hl
	inc hl
	inc hl
	inc hl
	ld a, [hl]
	dec a
	ld d, a
	pop af
	pop bc
	pop hl
	add d ; cursor_x + d
.move_right
	inc a
	cp c
	jr c, .apply_x_value
	inc c
	cp c
	jr c, .warp_around_right
	inc c
	cp c
	jr c, .warp_round_last_row
	ld a, 2
	jr .apply_x_value
.warp_round_last_row
	ld a, 1
	jr .apply_x_value
.warp_around_right
	xor a
	jr .apply_x_value

.apply_y_value
	ld l, a
	jr .got_new_cursor_position

.apply_x_value
	ld h, a

.got_new_cursor_position
	push hl
	call GetCharInfoFromPos
	inc hl
	inc hl
	inc hl
	ld a, [wNamingScreenMode]
	cp NAME_MODE_LOWER_ABC
	jr nz, .asm_1b14a
	inc hl
	inc hl
.asm_1b14a
	ld d, [hl]
	push de
	call HideCursorAtCharPosition
	pop de
	pop hl
	ld a, l
	ld [wNamingScreenCursorY], a
	ld a, h
	ld [wNamingScreenCursorX], a
	xor a
	ld [wNamingScreenCursorBlinkCounter], a
	ld a, KEYBOARD_UNKNOWN
	cp d
	jp z, .start
	ld a, SFX_01
	ld [wNamingScreenInputSFX], a

.check_btns
	ldh a, [hKeysPressed]
	and A_BUTTON | B_BUTTON
	jr z, .no_pressed_btns
	and A_BUTTON
	jr nz, .asm_1b174
	ld a, $ff
.asm_1b174
	call PlayAcceptOrDeclineSFX
	push af
	call ShowCursorAtCharPosition
	pop af
	scf
	ret

.no_pressed_btns
	ld a, [wNamingScreenInputSFX]
	or a
	jr z, .skip_sfx
	call PlaySFX
.skip_sfx
	ld hl, wNamingScreenCursorBlinkCounter
	ld a, [hl]
	inc [hl]
	and $0f
	ret nz
	ld a, [wVisibleCursorTile]
	bit 4, [hl]
	jr z, DrawSymbolAtCharPosition
; fallthrough

HideCursorAtCharPosition:
	ld a, [wInvisibleCursorTile]
; fallthrough

DrawSymbolAtCharPosition:
	ld e, a
	ld a, [wNamingScreenCursorX]
	ld h, a
	ld a, [wNamingScreenCursorY]
	ld l, a
	call GetCharInfoFromPos
	ld a, [hli] ; y
	ld c, a
	ld a, [wd3ef]
	or a
	jr z, .asm_1b1ae
	inc c
.asm_1b1ae
	ld b, [hl] ; x
	dec b
	ld a, e ; tile
	call UpdateNameTextCursor
	call WriteByteToBGMap0
	or a
	ret

ShowCursorAtCharPosition:
	ld a, [wVisibleCursorTile]
	jr DrawSymbolAtCharPosition

; a = tile of cursor
UpdateNameTextCursor:
	push af
	push bc
	push de
	push hl
	push af
	call ZeroObjectPositions
	pop af
	ld b, a
	ld a, [wInvisibleCursorTile]
	cp b
	jr z, .done ; cursor is invisible, done
	ld a, [wd3ef]
	or a
	jr nz, .asm_1b201

; place text cursor on the next name character position
	ld a, [wNamingScreenBufferLength]
	srl a ; /2
	ld d, a
	ld a, [wNamingScreenBufferMaxLength]
	srl a ; /2
	ld e, a
	ld a, d
	cp e
	jr nz, .name_not_full
	dec a
.name_not_full
	ld hl, wNamingScreenNamePosition
	add [hl] ; add name x position
	ld d, a
	ld h, 8
	ld l, d
	call HtimesL
	ld a, l
	add 8
	ld d, a ; x
	ld e, 24 ; y
	lb bc, $0, $0 ; attributes, tile number
	call SetOneObjectAttributes
.done
	pop hl
	pop de
	pop bc
	pop af
	ret

.asm_1b201
	ld a, [wNamingScreenBufferLength]
	sub $24
	jr c, .asm_1b212
	cp $24
	jr nz, .asm_1b20e
	dec a
	dec a
.asm_1b20e
	ld e, 32 ; y
	jr .asm_1b217
.asm_1b212
	ld a, [wNamingScreenBufferLength]
	ld e, 24 ; y
.asm_1b217
	sra a
	ld l, a
	ld h, 8
	call HtimesL
	ld a, l
	add 16
	ld d, a ; x
	lb bc, $0, $0
	call SetOneObjectAttributes
	jr .done

; load, to the first tile of v0Tiles0, the graphics for the
; blinking black square used in name input screens
LoadFullWidthTextCursorTile:
	ld hl, v0Tiles0
	ld de, .black_tile
	ld b, $00
.loop
	ld a, TILE_SIZE
	cp b
	ret z
	inc b
	ld a, [de]
	inc de
	ld [hli], a
	jr .loop

.black_tile
REPT TILE_SIZE
	db $ff
ENDR

; return carry if player selected "Done"
SelectKeyboardItem:
	ld a, [wNamingScreenCursorX]
	ld h, a
	ld a, [wNamingScreenCursorY]
	ld l, a
	call GetCharInfoFromPos
	inc hl
	inc hl
	ld e, [hl]
	inc hl
	ld a, [hli]
	ld d, a
	cp KEYBOARD_DONE
	jp z, .set_carry
	cp KEYBOARD_TOGGLE_KATAKANA
	jr nz, .asm_1b276
	ld a, [wNamingScreenMode]
	or a
	jr nz, .hiragana_mode
	ld a, NAME_MODE_KATAKANA
	jp .set_mode
.hiragana_mode
	xor a ; NAME_MODE_HIRAGANA
	jp .set_mode
.asm_1b276
	cp KEYBOARD_TOGGLE_UPPER_ABC
	jr nz, .asm_1b289
	ld a, [wNamingScreenMode]
	cp NAME_MODE_UPPER_ABC
	jr c, .not_upper_abc_mode
	ld a, NAME_MODE_KATAKANA
	jr .set_mode
.not_upper_abc_mode
	ld a, NAME_MODE_UPPER_ABC
	jr .set_mode
.asm_1b289
	cp KEYBOARD_TOGGLE_LOWER_ABC
	jr nz, .character_item
	ld a, [wNamingScreenMode]
	cp NAME_MODE_LOWER_ABC
	jr nz, .not_lower_abc_mode
	ld a, NAME_MODE_UPPER_ABC
	jr .set_mode
.not_lower_abc_mode
	ld a, NAME_MODE_LOWER_ABC
.set_mode
	ld [wNamingScreenMode], a
	call UpdateNamingScreenUI
	or a
	ret

.character_item
	ld a, [wNamingScreenMode]
	cp NAME_MODE_UPPER_ABC
	jr z, .upper_abc
	cp NAME_MODE_LOWER_ABC
	jr z, .lower_abc

	; handle diacritics
	lb bc, TX_FULLWIDTH4, "FW4_゛"
	ld a, d
	cp b
	jr nz, .check_handakuten
	ld a, e
	cp c
	jr nz, .check_handakuten
	push hl
	ld hl, DakutenTable
	call GetDiacriticCharacter
	pop hl
	jr c, .no_carry
	jr .apply_diacritic
.check_handakuten
	lb bc, TX_FULLWIDTH4, "FW4_゜"
	ld a, d
	cp b
	jr nz, .not_diacritic
	ld a, e
	cp c
	jr nz, .not_diacritic
	push hl
	ld hl, HandakutenTable
	call GetDiacriticCharacter
	pop hl
	jr c, .no_carry
.apply_diacritic
	; decrease length by 2
	ld a, [wNamingScreenBufferLength]
	dec a
	dec a
	ld [wNamingScreenBufferLength], a

	; get pointer to last character in buffer
	ld hl, wNamingScreenBuffer
	push de
	ld d, $00
	ld e, a
	add hl, de
	pop de
	ld a, [hl]
	jr .add_character

.not_diacritic
	ld a, d
	or a
	jr nz, .add_character
	ld a, [wNamingScreenMode]
	or a
	jr nz, .asm_1b2fb
	; NAME_MODE_HIRAGANA
	ld a, TX_HIRAGANA
	jr .add_character
.asm_1b2fb
	; NAME_MODE_KATAKANA
	ld a, TX_KATAKANA
	jr .add_character
.lower_abc
	inc hl
	inc hl
.upper_abc
	ld e, [hl]
	inc hl
	ld a, [hl]
	or a
	jr nz, .add_character
	ld a, TX_HIRAGANA

; a = TX_* constant
; e = character byte
.add_character
	ld d, a
	ld hl, wNamingScreenBufferLength
	ld a, [hl]
	ld c, a
	push hl
	ld hl, wNamingScreenBufferMaxLength
	cp [hl]
	pop hl
	jr nz, .not_last_character
	; overwrite last character
	ld hl, wNamingScreenBuffer
	dec hl
	dec hl
	; hl = wNamingScreenBuffer - 2
	jr .got_char_position
.not_last_character
	inc [hl]
	inc [hl]
	ld hl, wNamingScreenBuffer
.got_char_position
	ld b, $00
	add hl, bc
	ld [hl], d
	inc hl
	ld [hl], e
	inc hl
	ld [hl], TX_END
	call ProcessTextWithUnderbar
.no_carry
	or a
	ret

.set_carry:
	scf
	ret

; input:
;  hl = pointer to either DakutenTable or HandakutenTable
; output:
;  d = $00
;  e = new character byte
GetDiacriticCharacter:
	ld a, [wNamingScreenBufferLength]
	or a
	jr z, .set_carry
	dec a
	dec a
	push hl
	ld hl, wNamingScreenBuffer
	ld d, $00
	ld e, a
	add hl, de
	ld e, [hl] ; TX_*
	inc hl
	ld d, [hl] ; character
	ld a, TX_KATAKANA
	cp e
	jr nz, .not_katakana
	dec e ; change to hiragana
.not_katakana
	pop hl
.loop
	ld a, [hli]
	or a
	jr z, .set_carry ; not in table
	cp d
	jr nz, .next
	ld a, [hl]
	cp e
	jr nz, .next
	inc hl
	ld e, [hl] ; new character byte
	inc hl
	ld d, [hl] ; unused byte
	or a
	ret
.next
	inc hl
	inc hl
	inc hl
	jr .loop

.set_carry
	scf
	ret

; given the position of the current cursor,
; it returns the pointer to the proper information.
; h: position x.
; l: position y.
GetCharInfoFromPos:
	push de
	; (information index) = (x) * (height) + (y)
	ld e, l
	ld d, h
	ld a, [wNamingScreenNumRows]
	ld l, a
	call HtimesL
	ld a, l
	add e
	ld hl, KeyboardData
	pop de
	or a
	ret z
.loop
REPT 8
	inc hl
ENDR
	dec a
	jr nz, .loop
	ret

; a set of keyboard datum
; \1 = absolute y coordinate
; \2 = absolute x coordinate
; \3 = TX_* constant (hiragana/katakana)
; \4 = hiragana character (must coincide with the
;      katakana character with the same byte value)
; \5 = TX_* constant (uppercase ABC)
; \6 = uppercase alphabet character
; \7 = TX_* constant (lowercase ABC)
; \8 = lowercase alphabet character
MACRO kbchar
	db \1, \2

REPT 3
IF \3 == TX_FULLWIDTH0 || \3 == TX_KATAKANA
	db STRCAT("FW0_", \4)
ELIF \3 == TX_FULLWIDTH4
	db STRCAT("FW4_", \4)
ELIF \3 == TX_SYMBOL
	db SYM_\4
ENDC
	db \3
SHIFT 2
ENDR
ENDM

; \1 = absolute y coordinate
; \2 = absolute x coordinate
; \3 = keyboard function (KEYBOARD_* constant)
; \4 = cursor x offset to right
; \5 = cursor x offset to left
MACRO kbitem
	db \1, \2
	db $01 ; unused
	db \3
	db \4, \5
	db \4, \5 ; unused
ENDM

KeyboardData:
	; col 0
	kbchar  4,  2, TX_FULLWIDTH0, "あ", TX_FULLWIDTH4, "A",  TX_FULLWIDTH4, "a"
	kbchar  6,  2, TX_FULLWIDTH0, "い", TX_FULLWIDTH4, "J",  TX_FULLWIDTH4, "j"
	kbchar  8,  2, TX_FULLWIDTH0, "う", TX_FULLWIDTH4, "S",  TX_FULLWIDTH4, "s"
	kbchar 10,  2, TX_FULLWIDTH0, "え", TX_FULLWIDTH0, "?",  TX_FULLWIDTH4, "@"
	kbchar 12,  2, TX_FULLWIDTH0, "お", TX_FULLWIDTH0, "4",  TX_FULLWIDTH4, ":"
	kbchar 14,  2, TX_FULLWIDTH0, "ゃ", TX_FULLWIDTH0, "ぃ", TX_SYMBOL,     LIGHTNING
	kbitem 16,  2, KEYBOARD_TOGGLE_KATAKANA, 3, 2

	; col 1
	kbchar  4,  4, TX_FULLWIDTH0, "か", TX_FULLWIDTH4, "B",  TX_FULLWIDTH4, "b"
	kbchar  6,  4, TX_FULLWIDTH0, "き", TX_FULLWIDTH4, "K",  TX_FULLWIDTH4, "k"
	kbchar  8,  4, TX_FULLWIDTH0, "く", TX_FULLWIDTH4, "T",  TX_FULLWIDTH4, "t"
	kbchar 10,  4, TX_FULLWIDTH0, "け", TX_FULLWIDTH4, "&",  TX_FULLWIDTH4, "&"
	kbchar 12,  4, TX_FULLWIDTH0, "こ", TX_FULLWIDTH0, "5",  TX_FULLWIDTH4, ";"
	kbchar 14,  4, TX_FULLWIDTH0, "ゅ", TX_FULLWIDTH0, "ぅ", TX_SYMBOL,     GRASS
	kbitem 16,  2, KEYBOARD_TOGGLE_KATAKANA, 2, 2

	; col 2
	kbchar  4,  6, TX_FULLWIDTH0, "さ", TX_FULLWIDTH4, "C",  TX_FULLWIDTH4, "c"
	kbchar  6,  6, TX_FULLWIDTH0, "し", TX_FULLWIDTH4, "L",  TX_FULLWIDTH4, "l"
	kbchar  8,  6, TX_FULLWIDTH0, "す", TX_FULLWIDTH4, "U",  TX_FULLWIDTH4, "u"
	kbchar 10,  6, TX_FULLWIDTH0, "せ", TX_FULLWIDTH0, "+",  TX_FULLWIDTH0, "/"
	kbchar 12,  6, TX_FULLWIDTH0, "そ", TX_FULLWIDTH0, "6",  TX_FULLWIDTH4, "_"
	kbchar 14,  6, TX_FULLWIDTH0, "ょ", TX_FULLWIDTH0, "ぇ", TX_SYMBOL,     FIRE
	kbitem 16,  2, KEYBOARD_TOGGLE_KATAKANA, 2, 3

	; col 3
	kbchar  4,  8, TX_FULLWIDTH0, "た", TX_FULLWIDTH4, "D",  TX_FULLWIDTH4, "d"
	kbchar  6,  8, TX_FULLWIDTH0, "ち", TX_FULLWIDTH4, "M",  TX_FULLWIDTH4, "m"
	kbchar  8,  8, TX_FULLWIDTH0, "つ", TX_FULLWIDTH4, "V",  TX_FULLWIDTH4, "v"
	kbchar 10,  8, TX_FULLWIDTH0, "て", TX_FULLWIDTH0, "-",  TX_FULLWIDTH4, "*"
	kbchar 12,  8, TX_FULLWIDTH0, "と", TX_FULLWIDTH0, "7",  TX_FULLWIDTH4, "<"
	kbchar 14,  8, TX_FULLWIDTH0, "っ", TX_FULLWIDTH0, "ぉ", TX_SYMBOL,     WATER
	kbitem 16,  7, KEYBOARD_TOGGLE_UPPER_ABC, 2, 3

	; col 4
	kbchar  4, 10, TX_FULLWIDTH0, "な", TX_FULLWIDTH4, "E",  TX_FULLWIDTH4, "e"
	kbchar  6, 10, TX_FULLWIDTH0, "に", TX_FULLWIDTH4, "N",  TX_FULLWIDTH4, "n"
	kbchar  8, 10, TX_FULLWIDTH0, "ぬ", TX_FULLWIDTH4, "W",  TX_FULLWIDTH4, "w"
	kbchar 10, 10, TX_FULLWIDTH0, "ね", TX_FULLWIDTH0, "・", TX_FULLWIDTH0, "+"
	kbchar 12, 10, TX_FULLWIDTH0, "の", TX_FULLWIDTH0, "8",  TX_FULLWIDTH4, ">"
	kbchar 14, 10, TX_FULLWIDTH0, "を", TX_KATAKANA,   "ァ", TX_SYMBOL,     PSYCHIC
	kbitem 16,  7, KEYBOARD_TOGGLE_UPPER_ABC, 2, 2

	; col 5
	kbchar  4, 12, TX_FULLWIDTH0, "は", TX_FULLWIDTH4, "F",  TX_FULLWIDTH4, "f"
	kbchar  6, 12, TX_FULLWIDTH0, "ひ", TX_FULLWIDTH4, "O",  TX_FULLWIDTH4, "о"
	kbchar  8, 12, TX_FULLWIDTH0, "ふ", TX_FULLWIDTH4, "X",  TX_FULLWIDTH4, "x"
	kbchar 10, 12, TX_FULLWIDTH0, "へ", TX_FULLWIDTH0, "0",  TX_FULLWIDTH0, "-"
	kbchar 12, 12, TX_FULLWIDTH0, "ほ", TX_FULLWIDTH0, "9",  TX_FULLWIDTH0, " "
	kbchar 14, 12, TX_FULLWIDTH4, "゛", TX_KATAKANA,   "ィ", TX_SYMBOL,     FIGHTING
	kbitem 16, 12, KEYBOARD_TOGGLE_LOWER_ABC, 2, 2

	; col 6
	kbchar  4, 14, TX_FULLWIDTH0, "ま", TX_FULLWIDTH4, "G",  TX_FULLWIDTH4, "g"
	kbchar  6, 14, TX_FULLWIDTH0, "み", TX_FULLWIDTH4, "P",  TX_FULLWIDTH4, "p"
	kbchar  8, 14, TX_FULLWIDTH0, "む", TX_FULLWIDTH4, "Y",  TX_FULLWIDTH4, "y"
	kbchar 10, 14, TX_FULLWIDTH0, "め", TX_FULLWIDTH0, "1",  TX_FULLWIDTH4, "="
	kbchar 12, 14, TX_FULLWIDTH0, "も", TX_SYMBOL,     No,   TX_FULLWIDTH0, " "
	kbchar 14, 14, TX_FULLWIDTH4, "゜", TX_KATAKANA,   "ゥ", TX_SYMBOL,     COLORLESS
	kbitem 16, 12, KEYBOARD_TOGGLE_LOWER_ABC, 2, 2

	; col 7
	kbchar  4, 16, TX_FULLWIDTH0, "や", TX_FULLWIDTH4, "H",  TX_FULLWIDTH4, "h"
	kbchar  6, 16, TX_FULLWIDTH0, "ゆ", TX_FULLWIDTH4, "Q",  TX_FULLWIDTH4, "q"
	kbchar  8, 16, TX_FULLWIDTH0, "よ", TX_FULLWIDTH4, "Z",  TX_FULLWIDTH4, "z"
	kbchar 10, 16, TX_FULLWIDTH0, "わ", TX_FULLWIDTH0, "2",  TX_FULLWIDTH0, "・"
	kbchar 12, 16, TX_FULLWIDTH0, "ん", TX_SYMBOL,     Lv,   TX_FULLWIDTH0, " "
	kbchar 14, 16, TX_FULLWIDTH0, "ー", TX_KATAKANA,   "ェ", TX_SYMBOL,    RAINBOW
	kbitem 16, 16, KEYBOARD_DONE, 2, 2

	; col 8
	kbchar  4, 18, TX_FULLWIDTH0, "ら", TX_FULLWIDTH4, "I",  TX_FULLWIDTH4, "i"
	kbchar  6, 18, TX_FULLWIDTH0, "り", TX_FULLWIDTH4, "R",  TX_FULLWIDTH4, "r"
	kbchar  8, 18, TX_FULLWIDTH0, "る", TX_FULLWIDTH0, "!",  TX_FULLWIDTH0, " "
	kbchar 10, 18, TX_FULLWIDTH0, "れ", TX_FULLWIDTH0, "3",  TX_FULLWIDTH4, "ˍ"
	kbchar 12, 18, TX_FULLWIDTH0, "ろ", TX_FULLWIDTH0, "ぁ", TX_FULLWIDTH0, " "
	kbchar 14, 18, TX_FULLWIDTH0, " ",  TX_KATAKANA,   "ォ", TX_FULLWIDTH0, " "
	kbitem 16, 16, KEYBOARD_DONE, 3, 3

	db  0,  0, $00, $00, $00, $00, $00, $00

MACRO diacritic
	db STRCAT("FW0_", \1)
	db \2
	db STRCAT("FW0_", \3)
	db $00
ENDM

DakutenTable:
	diacritic "か", TX_HIRAGANA, "が" ; katakana カ, ガ
	diacritic "き", TX_HIRAGANA, "ぎ" ; katakana キ, ギ
	diacritic "く", TX_HIRAGANA, "ぐ" ; katakana ク, グ
	diacritic "け", TX_HIRAGANA, "げ" ; katakana ケ, ゲ
	diacritic "こ", TX_HIRAGANA, "ご" ; katakana コ, ゴ
	diacritic "さ", TX_HIRAGANA, "ざ" ; katakana サ, ザ
	diacritic "し", TX_HIRAGANA, "じ" ; katakana シ, ジ
	diacritic "す", TX_HIRAGANA, "ず" ; katakana ス, ズ
	diacritic "せ", TX_HIRAGANA, "ぜ" ; katakana セ, ゼ
	diacritic "そ", TX_HIRAGANA, "ぞ" ; katakana ソ, ゾ
	diacritic "た", TX_HIRAGANA, "だ" ; katakana タ, ダ
	diacritic "ち", TX_HIRAGANA, "ぢ" ; katakana チ, ヂ
	diacritic "つ", TX_HIRAGANA, "づ" ; katakana ツ, ヅ
	diacritic "て", TX_HIRAGANA, "で" ; katakana テ, デ
	diacritic "と", TX_HIRAGANA, "ど" ; katakana ト, ド
	diacritic "は", TX_HIRAGANA, "ば" ; katakana ハ, バ
	diacritic "ひ", TX_HIRAGANA, "び" ; katakana ヒ, ビ
	diacritic "ふ", TX_HIRAGANA, "ぶ" ; katakana フ, ブ
	diacritic "へ", TX_HIRAGANA, "べ" ; katakana ヘ, ベ
	diacritic "ほ", TX_HIRAGANA, "ぼ" ; katakana ホ, ボ
	diacritic "ぱ", TX_HIRAGANA, "ば" ; katakana パ, バ
	diacritic "ぴ", TX_HIRAGANA, "び" ; katakana ピ, ビ
	diacritic "ぷ", TX_HIRAGANA, "ぶ" ; katakana プ, ブ
	diacritic "ぺ", TX_HIRAGANA, "べ" ; katakana ペ, ベ
	diacritic "ぽ", TX_HIRAGANA, "ぼ" ; katakana ポ, ボ
	db $00, $00 ; end

HandakutenTable:
	diacritic "は", TX_HIRAGANA, "ぱ" ; katakana ハ, パ
	diacritic "ひ", TX_HIRAGANA, "ぴ" ; katakana ヒ, ピ
	diacritic "ふ", TX_HIRAGANA, "ぷ" ; katakana フ, プ
	diacritic "へ", TX_HIRAGANA, "ぺ" ; katakana ヘ, ペ
	diacritic "ほ", TX_HIRAGANA, "ぽ" ; katakana ホ, ポ
	diacritic "ば", TX_HIRAGANA, "ぱ" ; katakana バ, パ
	diacritic "び", TX_HIRAGANA, "ぴ" ; katakana ビ, ピ
	diacritic "ぶ", TX_HIRAGANA, "ぷ" ; katakana ブ, プ
	diacritic "べ", TX_HIRAGANA, "ぺ" ; katakana ベ, ペ
	diacritic "ぼ", TX_HIRAGANA, "ぽ" ; katakana ボ, ポ
	db $00, $00 ; end
; 0x1b613

SECTION "Bank 6@78f1", ROMX[$78f1], BANK[$6]

Func_1b8f1:
	ld a, b
	or a
	ret z
.asm_1b8f4
	ld a, [hli]
	ld [de], a
	inc de
	dec b
	jr nz, .asm_1b8f4
	ret
; 0x1b8fb
