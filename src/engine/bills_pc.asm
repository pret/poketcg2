; return de = evo card id to receive
_BillsPC:
	bank1call SetupDuel
	call DisableLCD
	lb de, 0, 0
	lb bc, 20, 13
	call DrawRegularTextBox
	lb de, 1, 0
	ldtx hl, GameCenterBillsPCTitleText
	call Func_2c4b
	lb de, 13, 0
	ldtx hl, GameCenterBillsPC20ChipsPerPlayText
	call Func_2c4b
	lb de, 2, 2
	ldtx hl, GameCenterBillsPCDescriptionText
	call InitTextPrinting_ProcessTextFromID
	ldtx hl, GameCenterBillsPCDescriptionDialogText
	call DrawWideTextBox_WaitForInput
	ldtx hl, GameCenterBillsPCStartPromptText
	call YesOrNoMenuWithText
	ret c
	farcall CheckForBillsPCCardInMail
	ldtx hl, GameCenterBillsPCUnableLastOutputRemainingText
	jr c, .exit
	farcall GetGameCenterChips
	ldtx hl, GameCenterBillsPCUnableNotEnoughChipsText
	ld a, b
	or a
	jr nz, .count_bills_computer
	ld a, c
	cp CHIPS_BET_BILLS_PC
	jr c, .exit
.count_bills_computer
	ld de, BILLS_COMPUTER
	call GetCardCountInCollectionAndDecks
	ldtx hl, GameCenterBillsPCUnableNoBillsComputerText
	jr c, .exit

	xor a
	ld [wBillsPCCurMenuItem], a
	ld [wBillsPCMenuScrollOffset], a
	call DrawBillsPCTextBox
	call ListBillsPCCompatibleCardsInCollection
	ld [wNumBillsPCCompatibleCardItems], a
	ldtx hl, GameCenterBillsPCUnableNoCompatibleCardsText
	jr nc, .card_selection

.exit
	call PrintScrollableText_NoTextBoxLabel
	scf
	ret

.card_selection
	call HandleBillsPCMenu
	ret c ; cancelled
; confirm prompt
	call LoadCardDataToBuffer1_FromCardID
	call DrawLargePictureOfCard
	ldtx hl, GameCenterBillsPCConfirmPromptText
	call YesOrNoMenuWithText
	jr nc, .confirmed
; restart card selection
	call DrawBillsPCTextBox
	jr .card_selection

.confirmed
	call EmptyScreen
	farcall Func_10327
	farcall TurnOnCurChipsHUD
	ldtx hl, GameCenterBillsPCChipsPaidText
	call DrawWideTextBox_WaitForInput
	ld bc, CHIPS_BET_BILLS_PC
	farcall DecreaseChipsSmoothly
	farcall TurnOffCurChipsHUD
	lb de, $38, $7f
	call SetupText

	call EmptyScreen
	ld hl, $4930 ; DuelOtherGraphics + $30 tiles
	ld de, v0Tiles2 + $30 tiles
	ld b, 8
	call CopyFontsOrDuelGraphicsTiles
	call LoadCardOrDuelMenuBorderTiles
	ld hl, .tile_data
	call WriteDataBlocksToBGMap0

	ld de, BILLS_COMPUTER
	call LoadCardDataToBuffer2_FromCardID
	ld hl, wLoadedCard2Gfx
	ld a, [hli]
	ld h, [hl]
	ld l, a
	lb bc, $30, TILE_SIZE
	ld de, v0Tiles1 + $20 tiles
	call LoadCardGfx
	ld a, $a0 ; v0Tiles1 + $20 tiles
	lb hl, 6, 1
	lb de, 1, 3
	lb bc, 8, 6
	call FillRectangle
	bank1call DrawCardGfxToDE_BGPalIndex5
	ld de, v0Tiles1
	ld hl, $34d0 ; DuelCardHeaderGraphics - $4000
	ld b, $10
	call CopyFontsOrDuelGraphicsTiles
	ld a, $80 ; v0Tiles1
	lb de, 1, 1
	lb bc, 8, 2
	lb hl, 1, 8
	call FillRectangle
	ld hl, wLoadedCard1Gfx
	ld a, [hli]
	ld h, [hl]
	ld l, a
	lb bc, $30, TILE_SIZE
	ld de, v0Tiles1 + $50 tiles
	call LoadCardGfx
	ld a, $d0 ; v0Tiles1 + $50 tiles
	lb hl,  6, 1
	lb de, 11, 3
	lb bc,  8, 6
	call FillRectangle
	bank1call DrawCardGfxToDE_BGPalIndex2
	ld de, v0Tiles1 + $10 tiles
	ld hl, $36d0
	ld b, $10
	call CopyFontsOrDuelGraphicsTiles
	ld a, $90 ; v0Tiles1 + $10 tiles
	lb de, 11 ,1
	lb bc, 8, 2
	lb hl, 1, 8
	call FillRectangle

; finish sending
	call FlushAllPalettes
	ldtx hl, GameCenterBillsPCCardsInsertedText
	call DrawWideTextBox_WaitForInput
	ld de, BILLS_COMPUTER
	call RemoveCardFromCollection
	ld hl, wLoadedCard1ID
	ld e, [hl]
	inc hl
	ld d, [hl]
	call RemoveCardFromCollection

; set output card
	ld a, [wLoadedCard1PokedexNumber]
	ld de, OMASTAR_LV36
	cp DEX_OMANYTE
	ret z
	ld de, MACHAMP_LV54
	cp DEX_MACHOKE
	ret z
	ld de, GOLEM_LV37
	cp DEX_GRAVELER
	ret z
	ld de, ALAKAZAM_LV45
	cp DEX_KADABRA
	ret z
	ld de, GENGAR_LV40
	cp DEX_HAUNTER
	ret z
; fallback: invalid input
	scf
	ret

.tile_data
; x, y, tiles[], 0

; y = 0 (top)
	db 0, 0
REPT 2
	db $30, $34, $34, $34, $34, $34, $34, $34, $34, $31
ENDR
	db 0

; y = [1, 10]
FOR y, 1, 11
	db  0, y, $36, 0
	db  9, y, $37, $36, 0
	db 19, y, $37, 0
ENDR

; y = 11 (bottom)
	db 0, 11
REPT 2
	db $32, $35, $35, $35, $35, $35, $35, $35, $35, $33
ENDR
	db 0
	db $ff ; end

HandleBillsPCMenu:
	ld hl, BillsPCMenuParams
	ld a, [wBillsPCCurMenuItem]
	call InitializeMenuParameters
	ld a, [wNumBillsPCCompatibleCardItems]
	cp NUM_BILLS_PC_LIST_VISIBLE_CARDS
	jr nc, .num_items_ok
	ld [wNumScrollMenuItems], a
.num_items_ok
	call DrawBillsPCMenu
	call EnableLCD
.wait_input
	call DoFrame
	call HandleMenuInput
	ld a, [wCurMenuItem]
	ld [wBillsPCCurMenuItem], a
	jr nc, .wait_input
	ldh a, [hCurScrollMenuItem]
	cp MENU_CANCEL
	jr z, .cancel_prompt
	add a
	ld e, a
	ld d, $00
	ld hl, wPlayerDeck
	add hl, de
	ld e, [hl]
	inc hl
	ld d, [hl]
; start btn to preview
	ldh a, [hKeysPressed]
	and PAD_START
	ret z
	call LoadCardDataToBuffer1_FromCardID
	bank1call OpenCardPage_FromHand
.back_to_start
	call DrawBillsPCTextBox
	jr HandleBillsPCMenu

.cancel_prompt
	ldtx hl, GameCenterBillsPCCancelPromptText
	call YesOrNoMenuWithText
	jr c, .back_to_start
	scf
	ret

DrawBillsPCTextBox:
	call EmptyScreen
	lb de, 0, 0
	lb bc, 20, 3
	call DrawRegularTextBox

PrintBillsPCCompatibleCardListTitle:
	lb de, 1, 1
	ldtx hl, GameCenterBillsPCYourCompatibleCardsText
	call InitTextPrinting_ProcessTextFromID
	ret

BillsPCMenuParams:
	menu_params 1, 4, 2, NUM_BILLS_PC_LIST_VISIBLE_CARDS, \
		SYM_CURSOR_R, 0, HandleBillsPCMenuScroll

HandleBillsPCMenuScroll:
	ldh a, [hDPadHeld]
	ld b, a
	and PAD_UP | PAD_DOWN
	jr z, .check_action_btns
	bit B_PAD_DOWN, b
	jr nz, .down_pressed

; up pressed
	ld hl, wCurMenuItem
	ld a, [wNumScrollMenuItems]
	dec a
	cp [hl]
	jr nz, .check_action_btns
	xor a
	ld [wCurMenuItem], a
	ld hl, wBillsPCMenuScrollOffset
	ld a, [hl]
	or a
	jr z, .check_action_btns
	dec [hl]
	jr .draw_menu

.down_pressed
	ld hl, wCurMenuItem
	ld a, [hl]
	or a
	jr nz, .check_action_btns
	ld a, [wNumScrollMenuItems]
	dec a
	ld [hl], a
	ld hl, wBillsPCMenuScrollOffset
	add [hl]
	inc a
	ld hl, wNumBillsPCCompatibleCardItems
	cp [hl]
	jr nc, .check_action_btns
	ld hl, wBillsPCMenuScrollOffset
	inc [hl]

.draw_menu
	call DrawBillsPCMenu
.check_action_btns
	ld a, [wCurMenuItem]
	ld hl, wBillsPCMenuScrollOffset
	add [hl]
	ldh [hCurScrollMenuItem], a
	ldh a, [hKeysPressed]
	and PAD_A | PAD_START
	jr nz, .action_btns
	ldh a, [hKeysPressed]
	and PAD_B
	ret z
; b btn pressed
	ld a, MENU_CANCEL
	ldh [hCurScrollMenuItem], a
.action_btns
	scf
	ret

DrawBillsPCMenu:
	call PrintBillsPCCompatibleCardListTitle
	ld a, [wNumScrollMenuItems]
	ld b, a
	ld a, [wBillsPCMenuScrollOffset]
	ld c, a
	lb de, 2, 4
.loop_items
	push bc
	push de
	ld a, c
	call .PrintOwnedCard
	pop de
	pop bc
	inc e
	inc e
	inc c
	dec b
	jr nz, .loop_items

; handle indicators
	ld e, SYM_SPACE
	ld a, [wBillsPCMenuScrollOffset]
	or a
	jr z, .up_indicator
	ld e, SYM_CURSOR_U
.up_indicator
	ld a, e
	lb bc, 19, 3
	call WriteByteToBGMap0

	ld e, SYM_SPACE
	ld a, [wBillsPCMenuScrollOffset]
	ld hl, wNumScrollMenuItems
	add [hl]
	ld hl, wNumBillsPCCompatibleCardItems
	cp [hl]
	jr nc, .down_indicator
	ld e, SYM_CURSOR_D
.down_indicator
	ld a, e
	lb bc, 19, 17
	call WriteByteToBGMap0
	ret

.PrintOwnedCard:
	push de
	ld e, a
	ld d, $00
	ld hl, wOpponentDeck
	add hl, de
	ld a, [hl]
	ld [wBillsPCCurCompatibleCardOwnedCount], a
	sla e
	rl d
	ld hl, wPlayerDeck
	add hl, de
	ld e, [hl]
	inc hl
	ld d, [hl]
	call LoadCardDataToBuffer1_FromCardID
	ld a, 16
	call CopyCardNameAndLevel
	pop de
	push de
	call InitTextPrinting
	ld hl, wDefaultText
	call ProcessText
	pop bc
	push bc
	ld b, 16
	ld a, [wBillsPCCurCompatibleCardOwnedCount]
	bank1call WriteTwoDigitNumberInTxSymbolFormat
	pop de
	ld d, 18
	call InitTextPrinting
	ldfw de, "枚"
	call Func_22ca
	ret

; return a = list size
ListBillsPCCompatibleCardsInCollection:
	call EnableSRAM
	ld de, wOpponentDeck
	call SetListPointer
	ld de, wPlayerDeck
	call SetListPointer2

	ld hl, .compatible_cards
	ld c, 0
.loop_cards
	ld e, [hl]
	inc hl
	ld d, [hl]
	inc hl
	ld a, e
	or d
	jr z, .get_length
	push hl
	ld hl, sCardCollection
	add hl, de
	ld a, [hl]
	pop hl
	bit CARD_NOT_OWNED_F, a
	jr nz, .loop_cards
	call SetNextElementOfList
	call Func_0b99
	inc c
	jr .loop_cards

.get_length
	call DisableSRAM
	ld a, c
	or a
	ret nz

; not found
	scf
	ret

.compatible_cards
	dw OMANYTE_LV19
	dw OMANYTE_LV20
	dw OMANYTE_LV22
	dw MACHOKE_LV24
	dw MACHOKE_LV28
	dw MACHOKE_LV40
	dw GRAVELER_LV27
	dw GRAVELER_LV28
	dw GRAVELER_LV29
	dw KADABRA_LV38
	dw KADABRA_LV39
	dw HAUNTER_LV17
	dw HAUNTER_LV22
	dw HAUNTER_LV25
	dw HAUNTER_LV26
	dw 0
