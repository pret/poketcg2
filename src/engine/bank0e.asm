SECTION "Bank e@6b82", ROMX[$6b82], BANK[$e]

HandleScrollMenu:
	xor a
	ld [wMenuInputSFX], a
	ldh a, [hDPadHeld]
	or a
	jp z, .call_update_func ; no keys
	ld b, a
	ld a, [wNumMenuItems]
	ld c, a
	ld a, [wCurScrollMenuItem]
	bit D_UP_F, b
	jr z, .check_d_down
; d-up
	push af
	ld a, SFX_01
	ld [wMenuInputSFX], a
	pop af
	dec a
	bit 7, a
	jr z, .scroll_done
; wrap around
	ld a, [wScrollMenuScrollOffset]
	or a
	jr z, .no_scroll_up
	dec a
	ld [wScrollMenuScrollOffset], a
	ld hl, wScrollMenuScrollFunc
	call CallIndirect
	xor a
	jr .scroll_done
.no_scroll_up
	xor a
	ld [wMenuInputSFX], a
	jr .scroll_done

.check_d_down
	bit D_DOWN_F, b
	jr z, .call_update_func
; d-down
	push af
	ld a, SFX_01
	ld [wMenuInputSFX], a
	pop af
	inc a
	cp c
	jr c, .scroll_done
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
	jr .scroll_done
.already_at_bottom
	pop af
	dec a
	push af
	xor a
	ld [wMenuInputSFX], a
	pop af

.scroll_done
	push af
	call .draw_invisible_cursor
	pop af
	ld [wCurScrollMenuItem], a
	xor a
	ld [wScrollMenuCursorBlinkCounter], a
	jr .call_update_func ; unnecessary jump

.call_update_func
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

.asm_3ac12
	call .draw_visible_cursor
	ld a, $01
	farcall PlayAcceptOrDeclineSFX
	ld a, [wCurScrollMenuItem]
	ld e, a
	ld a, [hCurMenuItem]
	scf
	ret

.null
	ldh a, [hKeysPressed]
	and A_BUTTON | B_BUTTON
	jr z, .play_menu_input_sfx
	and A_BUTTON
	jr nz, .asm_3ac12
; b button
	ld a, $ff
	ld [hCurMenuItem], a
	farcall PlayAcceptOrDeclineSFX
	scf
	ret

.play_menu_input_sfx
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
	jr z, .draw_cursor
.draw_invisible_cursor
	ld a, [wMenuInvisibleCursorTile]
.draw_cursor
	ld e, a
	ld a, [wMenuXSeparation]
	ld l, a
	ld a, [wCurScrollMenuItem]
	ld h, a
	call HtimesL
	ld a, l
	ld hl, wMenuCursorXOffset
	add [hl]
	ld b, a
	ld a, [wMenuYSeparation]
	ld l, a
	ld a, [wCurScrollMenuItem]
	ld h, a
	call HtimesL
	ld a, l
	ld hl, wMenuCursorYOffset
	add [hl]
	ld c, a
	ld a, e
	call WriteByteToBGMap0
	or a
	ret

.draw_visible_cursor:
	ld a, [wMenuVisibleCursorTile]
	jr .draw_cursor
; 0x3ac82

SECTION "Bank e@6d06", ROMX[$6d06], BANK[$e]

FillBoosterPackMenuItems:
	call UpdateBoosterPackMenuArrows
	ld a, [wScrollMenuScrollOffset]
	lb de, 5, 2
	ld b, $05
.loop
	push af
	push bc
	push de
	call .PrintBoosterPackName
	pop de
	pop bc
	pop af
	ret c
	dec b
	ret z
	inc a
	inc e
	inc e
	jr .loop

; prints Booster Pack name in case
; player has obtained that booster pack
.PrintBoosterPackName:
	push af
	call InitTextPrinting
	pop af
	ld b, $00
	ld c, %1
.loop_find
	cp b
	jr z, .found
	sla c
	inc b
	jr .loop_find
.found
	call EnableSRAM
	ld a, [sBoosterPacksObtained]
	call DisableSRAM
	and c
	ld hl, .ObtainedTextIDs
	jr nz, .has_booster
	ld hl, .NotObtainedTextIDs
.has_booster
	ld a, b
	add a ; *2
	ld c, a
	ld b, $00
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	call ProcessTextFromID
	ret

.ObtainedTextIDs:
	tx Text02c1
	tx Text02c2
	tx Text02c3
	tx Text02c5
	tx Text02c7
	tx Text02c9
	tx Text02cb
	tx Text02cd

.NotObtainedTextIDs:
	tx Text02c1
	tx Text02c2
	tx Text02c4
	tx Text02c6
	tx Text02c8
	tx Text02ca
	tx Text02cc
	tx Text02ce

UpdateBoosterPackMenuArrows:
	ld a, [wScrollMenuScrollOffset]
	or a
	jr z, .no_up_arrow
	ld a, SYM_CURSOR_U
	jr .draw_up_arrow
.no_up_arrow
	ld a, SYM_BOX_TOP
.draw_up_arrow
	lb bc, 18, 0
	call WriteByteToBGMap0
	ld a, [wScrollMenuScrollOffset]
	cp $03
	jr nc, .no_down_arrow
	xor a
	ld [wUnableToScrollDown], a
	ld a, SYM_CURSOR_D
	jr .draw_down_arrow
.no_down_arrow
	ld a, $01
	ld [wUnableToScrollDown], a
	ld a, SYM_BOX_TOP
.draw_down_arrow
	lb bc, 18, 12
	call WriteByteToBGMap0
	ret
; 0x3ada1

SECTION "Bank e@6e8c", ROMX[$6e8c], BANK[$e]

; sets the number of cursor positions for deck machine menu,
; sets the text ID to show given by de
; and sets DrawDeckMachineScreen as the update function
; de = text ID
InitDeckMachineDrawingParams:
	ld a, NUM_DECK_MACHINE_VISIBLE_DECKS
	ld [wNumMenuItems], a
	ld hl, wDeckMachineText
	ld [hl], e
	inc hl
	ld [hl], d
	ld hl, DrawDeckMachineScreen
	ld d, h
	ld a, l
	ld hl, wScrollMenuScrollFunc
	ld [hli], a
	ld [hl], d
	xor a
	ld [wd119], a
	ret

	; handles player input inside the Deck Machine screen
; the Start button opens up the deck confirmation menu
; and returns carry
; otherwise, returns no carry and selection made in a
HandleDeckMachineSelection:
.start
	call DoFrame
	call HandleScrollMenu
	jr c, .selection_made

	call .HandleListJumps
	jr c, .start
	ldh a, [hDPadHeld]
	and START
	jr z, .start

; start btn
	ld a, [wScrollMenuScrollOffset]
	ld [wTempScrollMenuScrollOffset], a
	ld b, a
	ld a, [wCurScrollMenuItem]
	ld [wTempScrollMenuItem], a
	add b
	ld c, a
	inc a
	or $80
	ld [wCurDeck], a

	; get pointer to selected deck cards
	; and if it's an empty deck, jump to start
	ld a, c
	call Func_3afb8
	push hl
	farcall CheckIfDeckHasCards
	pop hl
	jr c, .start

; show deck confirmation screen with deck cards
; and return carry set
	push hl
	ld bc, DECK_NAME_SIZE
	add hl, bc
	ld d, h
	ld e, l
	pop hl
	ld a, $01
	farcall PlayAcceptOrDeclineSFX
	farcall OpenDeckConfirmationMenu
	ld a, [wTempScrollMenuScrollOffset]
	ld [wScrollMenuScrollOffset], a
	call ClearScreenAndDrawDeckMachineScreen
	call DrawListScrollArrows
	call PrintNumSavedDecks
	ld a, [wTempScrollMenuItem]
	ld [wCurScrollMenuItem], a
	scf
	ret

.selection_made
	call HandleScrollMenu.draw_visible_cursor
	ld a, [wScrollMenuScrollOffset]
	ld [wTempScrollMenuScrollOffset], a
	ld a, [wCurScrollMenuItem]
	ld [wTempScrollMenuItem], a
	ld a, [hCurMenuItem]
	or a
	ret

; handles right and left input for jumping several entries at once
; returns carry if jump was made
.HandleListJumps
	ld a, [wScrollMenuScrollOffset]
	ld c, a
	ldh a, [hDPadHeld]
	cp D_RIGHT
	jr z, .d_right
	cp D_LEFT
	jr z, .d_left
	or a
	ret

.d_right
	ld a, [wScrollMenuScrollOffset]
	add NUM_DECK_MACHINE_VISIBLE_DECKS
	ld b, a
	add NUM_DECK_MACHINE_VISIBLE_DECKS
	ld hl, wNumDeckMachineEntries
	cp [hl]
	jr c, .got_new_pos
	ld a, [wNumDeckMachineEntries]
	sub NUM_DECK_MACHINE_VISIBLE_DECKS
	ld b, a
	jr .got_new_pos

.d_left
	ld a, [wScrollMenuScrollOffset]
	sub NUM_DECK_MACHINE_VISIBLE_DECKS
	ld b, a
	jr nc, .got_new_pos
	ld b, 0 ; first entry

.got_new_pos
	ld a, b
	ld [wScrollMenuScrollOffset], a
	cp c
	jr z, .set_carry
	; play SFX if jump was made
	; and update UI
	ld a, SFX_01
	call PlaySFX
	call DrawDeckMachineScreen
	call PrintNumSavedDecks
.set_carry
	scf
	ret

; returns carry if deck corresponding to the
; entry selected in the Deck Machine menu is empty
CheckIfSelectedDeckMachineEntryIsEmpty:
	ld a, [wSelectedDeckMachineEntry]
	call Func_3afb8
	farcall CheckIfDeckHasCards
	ret
; 0x3af66

SECTION "Bank e@6f66", ROMX[$6f66], BANK[$e]

ClearScreenAndDrawDeckMachineScreen:
	xor a
	ld [wTileMapFill], a
	call ZeroObjectPositions
	call EmptyScreen
	ld a, $01
	ld [wVBlankOAMCopyToggle], a
	call LoadSymbolsFont
	call LoadDuelCardSymbolTiles
	bank1call SetDefaultPalettes
	lb de, $3c, $ff
	call SetupText
	lb de, 0, 0
	lb bc, 20, 13
	call DrawRegularTextBox
	call SetDeckMachineTitleText
	call GetSavedDeckPointers
	call PrintVisibleDeckMachineEntries
	call GetSavedDeckCount
	call EnableLCD
	ret

; prints wDeckMachineTitleText as title text
SetDeckMachineTitleText:
	ld hl, wDeckMachineTitleText
	ld a, [hli]
	ld h, [hl]
	ld l, a
	lb de, 1, 0
	call Func_2c4b
	ret

CopyBBytesFromHLToDE_Bank0e:
.loop
	ld a, [hli]
	ld [de], a
	inc de
	dec b
	jr nz, .loop
	ret
; 0x3afb1

SECTION "Bank e@6fb8", ROMX[$6fb8], BANK[$e]

; a = deck index in wMachineDeckPtrs
Func_3afb8:
	push bc
	push de
	add a ; *2
	ld c, a
	ld b, $00
	ld hl, wMachineDeckPtrs
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, h
	cp HIGH(STARTOF(WRAM0))
	jr c, .done ; done if not from WRAM

	call SwitchToWRAM2
	push hl
	ld hl, wc000
	ld de, w2d58e
	ld b, $80
	call CopyBBytesFromHLToDE_Bank0e
	pop hl
	ld de, wc000
	ld b, $80
	call CopyBBytesFromHLToDE_Bank0e

	call SwitchToWRAM1
	ld hl, wc000
	ld de, wd4c8
	ld b, $80
	call CopyBBytesFromHLToDE_Bank0e
	call SwitchToWRAM2
	ld hl, w2d58e
	ld de, wc000
	ld b, $80
	call CopyBBytesFromHLToDE_Bank0e
	call SwitchToWRAM1
	ld hl, wd4c8
.done
	pop de
	pop bc
	ret

; save all sSavedDecks pointers in wMachineDeckPtrs
GetSavedDeckPointers:
	ld a, NUM_DECK_SAVE_MACHINE_SLOTS
	add NUM_DECK_SAVE_MACHINE_SLOTS ; add a is better
	ld hl, wMachineDeckPtrs
	farcall ClearNBytesFromHL
	ld de, wMachineDeckPtrs
	ld hl, sSavedDecks
	ld bc, DECK_COMPRESSED_STRUCT_SIZE
	ld a, NUM_DECK_SAVE_MACHINE_SLOTS
.loop_saved_decks
	push af
	ld a, l
	ld [de], a
	inc de
	ld a, h
	ld [de], a
	inc de
	add hl, bc
	pop af
	dec a
	jr nz, .loop_saved_decks
	ret

; given the cursor position in the deck machine menu
; prints the deck names of all entries that are visible
PrintVisibleDeckMachineEntries:
	ld a, [wScrollMenuScrollOffset]
	lb de, 2, 2
	ld b, NUM_DECK_MACHINE_VISIBLE_DECKS
.loop
	push af
	push bc
	push de
	call PrintDeckMachineEntry
	pop de
	pop bc
	pop af
	ret c ; jump never made?
	dec b
	ret z ; no more entries
	inc a
	inc e
	inc e
	jr .loop
; 0x3b043

SECTION "Bank e@7048", ROMX[$7048], BANK[$e]

DrawDeckMachineScreen:
	call DrawListScrollArrows
	ld hl, hffbb
	ld [hl], $01
	call SetDeckMachineTitleText
	lb de, 1, 14
	call InitTextPrinting
	ld hl, wDeckMachineText
	ld a, [hli]
	ld h, [hl]
	ld l, a
	call ProcessTextFromID
	ld hl, hffbb
	ld [hl], $00
	jr PrintVisibleDeckMachineEntries
; 0x3b069

SECTION "Bank e@7096", ROMX[$7096], BANK[$e]

; prints the deck name of the deck corresponding
; to index in register a, from wMachineDeckPtrs
; also checks whether the deck can be built
; either by dismantling other decks or not,
; and places the corresponding symbol next to the name
PrintDeckMachineEntry:
	ld b, a
	push bc
	ld hl, wDefaultText
	inc a
	farcall ConvertToNumericalDigits
	ld [hl], "FW0_・"
	inc hl
	ld [hl], TX_END
	call InitTextPrinting
	ld hl, wDefaultText
	call ProcessText
	pop af

; get the deck corresponding to input index
; and append its name to wDefaultText
	push af
	call Func_3afb8
	inc d
	inc d
	inc d
	push de
	farcall AppendDeckName
	pop de
	pop bc
	jr nc, .valid_deck

; invalid deck, give it the default
; empty deck name ("--------------")
	call InitTextPrinting
	ldtx hl, Text02d2 ; EmptyDeckNameText
	call ProcessTextFromID
	ld d, 12
	inc e
	call InitTextPrinting
	ld hl, .text
	call ProcessText
	scf
	ret

.valid_deck
	push de
	push bc

	ld a, $0 ; no decks dismantled
	call CheckIfCanBuildSavedDeck
	pop bc
	ld hl, wDefaultText
	jr c, .cannot_build

	; deck can be built
	xor a
	ld [wd49b], a
	ld hl, wd49f
	ld d, $00
	ld e, b
	sla e ; *2
	add hl, de
	ld [hl], a
	ld [wd49e], a
	ld hl, wd49f
	ld d, $00
	ld e, b
	sla e
	inc e ; *2 + 1
	add hl, de
	ld [hl], a
	lb de, TX_FULLWIDTH4, "FW4_○" ; can build
	jp .asm_3b18e

.cannot_build
	; deck cannot be built
	lb de, TX_FULLWIDTH0, "FW0_ "
	call Func_22ca

	; figure out how many cards are being
	; used on the other decks
	push bc
	call .CountCardsNeededToBuildInBuiltDecks
	ld [wd49b], a
	pop bc
	ld hl, wd49f
	ld d, $00
	ld e, b
	sla e ; *2
	add hl, de
	ld [hl], a

	push bc
	ld a, $ff ; all decks
	call .CountCardsNeededToBuildInCardCollection
	ld [wd49e], a
	pop bc
	ld hl, wd49f
	ld d, $00
	ld e, b
	sla e
	inc e ; *2 + 1
	add hl, de
	ld [hl], a
	pop de

	push af
	push de
	ld d, 12
	inc e
	call InitTextPrinting
	ld hl, .text
	call ProcessText
	pop de
	pop af
	push de
	or a
	jr z, .need_dismantle

	; players doesn't own all necessary cards
	pop de
	push de
	inc e
	ld d, $10
	call InitTextPrinting
	lb de, TX_FULLWIDTH0, "FW0_×"
	call Func_22ca
	ld a, [wd49e]
	ld hl, wDefaultText
	farcall ConvertToNumericalDigits
	ld [hl], TX_END
	ld hl, wDefaultText
	call ProcessText

.need_dismantle
	pop de
	ld a, [wd49b]
	or a
	jr z, .asm_3b18c
	inc e
	ld d, 12
	call InitTextPrinting
	lb de, TX_FULLWIDTH4, "FW4_※"
	call Func_22ca
	ld a, [wd49b]
	ld hl, wDefaultText
	farcall ConvertToNumericalDigits
	ld [hl], TX_END
	ld hl, wDefaultText
	call ProcessText
.asm_3b18c
	or a
	ret

.asm_3b18e
	call Func_22ca
	pop de
	ld d, 12
	inc e
	call InitTextPrinting
	ld hl, .text
	call ProcessText
	or a
	ret

.text
	db "<SPACE><SPACE><SPACE><SPACE><SPACE><SPACE><SPACE>"
	done

; de = card ID
.GetCardCountInScratchCardCollection:
	call SwitchToWRAM2
	push hl
	ld hl, wScratchCardCollection
	add hl, de
	ld a, [hl]
	pop hl
	call SwitchToWRAM1
	ret

; de = card ID
.DecrementCardCountInScratchCardCollection:
	call SwitchToWRAM2
	push hl
	ld hl, wScratchCardCollection
	add hl, de
	dec [hl]
	pop hl
	call SwitchToWRAM1
	ret

; b = saved deck index
.CountCardsNeededToBuildInBuiltDecks:
	push bc
	ld a, $80 ; only cards that are in built decks
	farcall CreateCardCollectionListWithDeckCards

	; copy to wScratchCardCollection
	call SwitchToWRAM2
	ld hl, wTempCardCollection
	ld de, wScratchCardCollection
	ld b, 0 ; $100 bytes
	call CopyBBytesFromHLToDE_Bank0e
	ld hl, wTempCardCollection + $100
	ld de, wScratchCardCollection + $100
	ld b, 0 ; $100 bytes
	call CopyBBytesFromHLToDE_Bank0e
	call SwitchToWRAM1

	xor a ; all owned cards
	farcall CreateCardCollectionListWithDeckCards
	pop bc

	; here, wTempCardCollection holds all cards that
	; the player owns, including in and out of decks
	; wScratchCardCollection holds all cards that
	; are in built decks only

	ld a, b
	call Func_3afb8
	ld bc, DECK_NAME_SIZE
	add hl, bc
	ld d, h
	ld e, l
	ld hl, wTempSavedDeckCards
	farcall CopyDeckFromSRAM

	ld hl, wTempSavedDeckCards
	lb bc, DECK_SIZE + 1, 0
.loop_deck
	dec b
	jr z, .got_count_1
	ld e, [hl]
	inc hl
	ld d, [hl]
	inc hl
	push hl
	ld hl, wTempCardCollection
	add hl, de
	ld a, [hl]
	and CARD_COUNT_MASK
	or a
	jr z, .zero_count
	dec [hl]
	pop hl
	jr .loop_deck
.zero_count
	call .GetCardCountInScratchCardCollection
	or a
	jr z, .next_card
	call .DecrementCardCountInScratchCardCollection
	inc c
.next_card
	pop hl
	jr .loop_deck
.got_count_1
	ld a, c ; total number of cards found in built decks
	ret

; b = saved deck index
.CountCardsNeededToBuildInCardCollection:
	push bc
	farcall CreateCardCollectionListWithDeckCards
	pop bc

	ld a, b
	call Func_3afb8
	ld bc, DECK_NAME_SIZE
	add hl, bc
	ld d, h
	ld e, l
	ld hl, wTempSavedDeckCards
	farcall CopyDeckFromSRAM
	ld hl, wTempSavedDeckCards
	lb bc, DECK_SIZE + 1, 0
.loop_collection
	dec b
	jr z, .got_count_2
	ld e, [hl]
	inc hl
	ld d, [hl]
	inc hl
	push hl
	ld hl, wc000
	add hl, de
	ld a, [hl]
	and CARD_COUNT_MASK
	or a
	jr z, .next_card_in_collection
	dec a
	ld [hl], a
	pop hl
	jr .loop_collection
.next_card_in_collection
	inc c
	pop hl
	jr .loop_collection
.got_count_2
	ld a, c
	ret

; counts how many decks in sSavedDecks are not empty
; stores value in wNumSavedDecks
GetSavedDeckCount:
	call EnableSRAM
	ld hl, sSavedDecks
	ld bc, DECK_COMPRESSED_STRUCT_SIZE
	ld d, NUM_DECK_SAVE_MACHINE_SLOTS
	ld e, 0
.loop
	ld a, [hl]
	or a
	jr z, .empty_slot
	inc e
.empty_slot
	dec d
	jr z, .got_count
	add hl, bc
	jr .loop
.got_count
	ld a, e
	ld [wNumSavedDecks], a
	call DisableSRAM
	ret

; prints "[wNumSavedDecks]/50"
PrintNumSavedDecks:
	ld a, [wNumSavedDecks]
	ld hl, wDefaultText
	farcall ConvertToNumericalDigits
	ld a, TX_SYMBOL
	ld [hli], a
	ld a, SYM_SLASH
	ld [hli], a
	ld a, NUM_DECK_SAVE_MACHINE_SLOTS
	farcall ConvertToNumericalDigits
	ld [hl], TX_END
	lb de, 14, 1
	call InitTextPrinting
	ld hl, wDefaultText
	call ProcessText
	ret
; 0x3b2af

SECTION "Bank e@7366", ROMX[$7366], BANK[$e]

GetSelectedSavedDeckPtr:
	push af
	push de
	ld a, [wSelectedDeckMachineEntry]
	call Func_3afb8
	pop de
	pop af
	ret

; checks if it's possible to build saved deck with index b
; includes cards from already built decks from flags in a
; returns carry if cannot build the deck with the given criteria
; a = DECK_* flags for which decks to include in the collection
; b = saved deck index
CheckIfCanBuildSavedDeck:
	push bc
	farcall CreateCardCollectionListWithDeckCards
	pop bc
	ld a, b
	call Func_3afb8
	ld bc, DECK_NAME_SIZE
	add hl, bc
	call CheckIfHasEnoughCardsToBuildDeck
	ret

SwitchToWRAM1:
	push af
	ld a, [wce4c]
	cp $01
	jr z, .skip
	ld a, $01
	ld [wce4c], a
	ldh [rSVBK], a
.skip
	pop af
	ret

SwitchToWRAM2:
	push af
	ld a, [wce4c]
	cp $02
	jr z, .skip
	ld a, $02
	ld [wce4c], a
	ldh [rSVBK], a
.skip
	pop af
	ret

; returns carry if wTempCardCollection does not
; have enough cards to build deck pointed by hl
; hl = pointer to cards of deck to check
CheckIfHasEnoughCardsToBuildDeck:
	ld d, h
	ld e, l
	ld hl, wTempSavedDeckCards
	farcall CopyDeckFromSRAM
	ld hl, wTempSavedDeckCards
	ld b, DECK_SIZE + 1
.loop
	dec b
	jr z, .no_carry
	ld e, [hl]
	inc hl
	ld d, [hl]
	inc hl
	push hl
	ld hl, wTempCardCollection
	add hl, de
	ld a, [hl]
	or a
	jr z, .set_carry
	cp CARD_NOT_OWNED
	jr z, .set_carry
	dec a
	ld [hl], a
	pop hl
	jr .loop

.set_carry
	pop hl
	scf
	ret

.no_carry
	or a
	ret
; 0x3b3d1

SECTION "Bank e@742b", ROMX[$742b], BANK[$e]

DrawListScrollArrows:
	ld a, [wScrollMenuScrollOffset]
	or a
	jr z, .no_up_cursor
	ld a, SYM_CURSOR_U
	jr .got_tile_1
.no_up_cursor
	ld a, SYM_BOX_RIGHT
.got_tile_1
	lb bc, 19, 1
	call WriteByteToBGMap0

	ld a, [wScrollMenuScrollOffset]
	add NUM_DECK_MACHINE_VISIBLE_DECKS + 1
	ld b, a
	ld a, [wNumDeckMachineEntries]
	cp b
	jr c, .no_down_cursor
	xor a ; FALSE
	ld [wUnableToScrollDown], a
	ld a, SYM_CURSOR_D
	jr .got_tile_2
.no_down_cursor
	ld a, TRUE
	ld [wUnableToScrollDown], a
	ld a, SYM_BOX_RIGHT
.got_tile_2
	lb bc, 19, 11
	call WriteByteToBGMap0
	ret
; 0x3b45f

SECTION "Bank e@7a9c", ROMX[$7a9c], BANK[$e]

_PrinterMenu_DeckConfiguration:
	xor a
	ld [wScrollMenuScrollOffset], a
	call ClearScreenAndDrawDeckMachineScreen
	ld a, NUM_DECK_SAVE_MACHINE_SLOTS
	ld [wNumDeckMachineEntries], a

	xor a
.start_selection
	ld hl, DeckMachineSelectionParams
	farcall InitializeScrollMenuParameters
	call DrawListScrollArrows
	call PrintNumSavedDecks
	ldtx hl, Text02f7 ; PleaseChooseDeckConfigurationToPrintText
	call DrawWideTextBox_PrintText
	ldtx de, Text02f7 ; PleaseChooseDeckConfigurationToPrintText
	call InitDeckMachineDrawingParams
.loop_input
	call HandleDeckMachineSelection
	jr c, .start_selection
	cp $ff
	ret z

	ld b, a
	ld a, [wScrollMenuScrollOffset]
	add b
	ld [wSelectedDeckMachineEntry], a
	call CheckIfSelectedDeckMachineEntryIsEmpty
	jr c, .loop_input
	call DrawWideTextBox
	ldtx hl, Text02f8 ; PrintThisDeckText
	call YesOrNoMenuWithText
	jr c, .no
	call GetSelectedSavedDeckPtr
	ld de, DECK_NAME_SIZE
	add hl, de
	ld d, h
	ld e, l
	ld hl, wCurDeckCards
	farcall CopyDeckFromSRAM
	farcall SortCurDeckCardsByID
	ld a, [wSelectedDeckMachineEntry]
	farcall PrintDeckConfiguration
	call ClearScreenAndDrawDeckMachineScreen

.no
	ld a, [wTempScrollMenuItem]
	ld [wCurScrollMenuItem], a
	jp .start_selection
; 0x3bb09
