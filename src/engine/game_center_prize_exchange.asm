GameCenterPrizeExchange:
	farcall HideNPCAnimsUnderDialogBox
	call .PrintWelcome
	call .PrintExchangePrompt
	jr c, .exit
	farcall ShowNPCAnimsUnderDialogBox
	farcall Func_1022a
	call .ShowMenu
	farcall Func_10252
	farcall HideNPCAnimsUnderDialogBox
.exit
	call .PrintComeAgain
	farcall ShowNPCAnimsUnderDialogBox
	ret

.ShowMenu:
	push af
	push bc
	push de
	push hl
	xor a
	ld [wGameCenterPrizeExchangeMenuCursorPosition], a
	call DrawAndHandleGameCenterPrizeExchangeMenu
	pop hl
	pop de
	pop bc
	pop af
	ret

.PrintWelcome:
	ldtx de, ReceptionistText
	ldtx hl, GameCenterPrizeExchangeWelcomeText
	farcall PrintScrollableText_WithTextBoxLabelVRAM0
	ret

.PrintComeAgain:
	ldtx de, ReceptionistText
	ldtx hl, GameCenterPrizeExchangeComeAgainText
	farcall PrintScrollableText_WithTextBoxLabelVRAM0
	ret

.PrintExchangePrompt:
	ldtx hl, GameCenterPrizeExchangePromptText
	ld a, $01
	farcall PrintScrollableText_WithTextBoxLabelWithYesOrNoMenu
	ret

DrawAndHandleGameCenterPrizeExchangeMenu:
	farcall ClearSpriteAnimsAndSetInitialGraphicsConfiguration
	call DrawGameCenterPrizeExchangeMenu
	farcall SetFrameFuncAndFadeFromWhite
	call HandleGameCenterPrizeExchangeMenu
	farcall FadeToWhiteAndUnsetFrameFunc
	ret

DrawGameCenterPrizeExchangeMenu:
	call LoadGameCenterPrizeExchangeItems
	lb de, 0, 0
	ld b, BANK(.menu_params)
	ld hl, .menu_params
	call LoadMenuBoxParams
	ld a, [wGameCenterPrizeExchangeMenuCursorPosition]
	call DrawMenuBox
; draw chip HUD
	ldtx hl, PlayersChipsText
	lb de, 1, 0
	call Func_2c4b
	lb de, 14, 0
	lb bc, 5, 1
	farcall FillBoxInBGMapWithZero
	ldtx hl, CardsAndChipsUnitText
	lb de, 18, 0
	call InitTextPrinting_ProcessTextFromIDVRAM0
	farcall GetGameCenterChips
	lb de, 14, 0
	ld h, b
	ld l, c
	ld a, 4
	ld b, TRUE
	call PrintNumber
; print available prizes
	ld hl, wIndicesGameCenterPrizeExchangeItems
	ld e, 2 ; y
	ld c, NUM_GAME_CENTER_PRIZE_LIST_ITEMS
.loop_print_prizes
	ld a, [hli]
	call .PrintPrizeAndPrice
	inc e
	inc e
	dec c
	jr nz, .loop_print_prizes
	ret

; print GameCenterPrizeExchangeItems[a]
.PrintPrizeAndPrice:
	push af
	push bc
	push de
	push hl
	ld hl, GameCenterPrizeExchangeItems
	add a
	add a ; *4
	ld c, a
	ld b, $00
	add hl, bc
; prize name
	push hl
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld d, 2 ; x
	call InitTextPrinting_ProcessTextFromIDVRAM0
	pop hl
; prize price (+unit)
	inc hl
	inc hl
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, 4
	ld b, TRUE
	ld d, 14 ; x
	call PrintNumber
	ld d, 18 ; x
	ldtx hl, CardsAndChipsUnitText
	call InitTextPrinting_ProcessTextFromIDVRAM0
	pop hl
	pop de
	pop bc
	pop af
	ret

.menu_params
	menubox_params TRUE, 20, 18, \
		SYM_CURSOR_R, SYM_SPACE, SYM_CURSOR_R, SYM_CURSOR_R, \
		PAD_A, PAD_B, FALSE, 1, NULL, NULL
		textitem 2,  2, SingleSpaceText
		textitem 2,  4, SingleSpaceText
		textitem 2,  6, SingleSpaceText
		textitem 2,  8, SingleSpaceText
		textitem 2, 10, SingleSpaceText
		textitems_end

HandleGameCenterPrizeExchangeMenu:
	lb de, 1, 14
	ldtx hl, GameCenterPrizeExchangeChoosePrizeText
	farcall PrintTextInWideTextBox
	ld a, [wGameCenterPrizeExchangeMenuCursorPosition]
	call HandleMenuBox
	ld [wGameCenterPrizeExchangeMenuCursorPosition], a
	jr c, .exit
	push af
	ld a, SFX_CONFIRM
	call CallPlaySFX
	pop af
	jr .selected
.exit
	push af
	ld a, SFX_CANCEL
	call CallPlaySFX
	pop af
	jr .quit_prompt

.selected
	ldtx hl, GameCenterPrizeExchangeConfirmText
	ld a, $01
	farcall DrawWideTextBox_PrintTextWithYesOrNoMenu
	jr c, .quit_prompt
	call .Exchange
	jr c, .quit_prompt
	farcall ClearSpriteAnimsAndSetInitialGraphicsConfiguration
	call DrawGameCenterPrizeExchangeMenu
	call StartFadeFromWhite
	call WaitPalFading_Bank07
.quit_prompt
	ldtx hl, GameCenterPrizeExchangeQuitConfirmText
	ld a, $01
	farcall DrawWideTextBox_PrintTextWithYesOrNoMenu
	jr c, HandleGameCenterPrizeExchangeMenu ; loop
	ret

.Exchange:
	ld a, [wGameCenterPrizeExchangeMenuCursorPosition]
	ld c, a
	ld b, $00
	ld hl, wIndicesGameCenterPrizeExchangeItems
	add hl, bc
	ld a, [hl]
	ld [wSelectedGameCenterPrizeExchangeItem], a
	add a
	add a ; *4
	ld c, a
	ld b, $00
	ld hl, GameCenterPrizeExchangeItems
	add hl, bc
	inc hl
	inc hl
	ld e, [hl]
	inc hl
	ld d, [hl]
	farcall GetGameCenterChips
	call CompareBCAndDE
	jr c, .not_enough_chips
	ld b, d
	ld c, e
	farcall SubtractChips
	call StartFadeToWhite
	call WaitPalFading_Bank07
	ld a, [wSelectedGameCenterPrizeExchangeItem]
	ld hl, .function_map
	call CallMappedFunction
	call WaitPalFading_Bank07
	ret

.not_enough_chips
	ldtx hl, GameCenterNotEnoughChipsText
	farcall PrintScrollableText_NoTextBoxLabelVRAM0
	ret

.function_map
	key_func GAMECENTERPRIZE_VENUSAUR,        .Venusaur
	key_func GAMECENTERPRIZE_MEW,             .Mew
	key_func GAMECENTERPRIZE_BILLS_COMPUTER,  .BillsComputer
	key_func GAMECENTERPRIZE_JIGGLYPUFF_COIN, .JigglypuffCoin
	key_func GAMECENTERPRIZE_1_PRESENT_PACK,  .PresentPack1
	key_func GAMECENTERPRIZE_3_PRESENT_PACKS, .PresentPacks3
	db $ff

.Venusaur:
	ld de, VENUSAUR_LV64
	farcall GetReceivedCardText
	call _ShowReceivedCard
	call AddCardToCollection
	ret

.Mew:
	ld de, MEW_LV15
	farcall GetReceivedCardText
	call _ShowReceivedCard
	call AddCardToCollection
	ret

.BillsComputer:
	ld de, BILLS_COMPUTER
	farcall GetReceivedCardText
	call _ShowReceivedCard
	call AddCardToCollection
	ret

.JigglypuffCoin:
	ld a, EVENT_GOT_JIGGLYPUFF_COIN
	farcall MaxOutEventValue
	ld a, COIN_JIGGLYPUFF
	call _GiveCoin
	ld a, TRUE
	ld [wClaimedJigglypuffCoin], a
	ret

; BOOSTER_PRESENT_FROM_* at random
.PresentPack1:
	ld a, NUM_BOOSTERS_PRESENT_REGULAR
	call Random
	add BOOSTERS_PRESENT_REGULAR_START
	ld b, FALSE
	call GiveBoosterPacks
	ret

; BOOSTER_PRESENT_FROM_* at random
.PresentPacks3:
	ld c, 3
	ld b, FALSE
.loop_present_packs
	ld a, NUM_BOOSTERS_PRESENT_REGULAR
	call Random
	add BOOSTERS_PRESENT_REGULAR_START
	call GiveBoosterPacks
	ld b, TRUE
	dec c
	jr nz, .loop_present_packs
	ret

; set up wIndicesGameCenterPrizeExchangeItems
LoadGameCenterPrizeExchangeItems:
	ld a, [wClaimedJigglypuffCoin]
	add a
	ld c, a
	ld b, $00
	ld hl, .lineup_table
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld de, wIndicesGameCenterPrizeExchangeItems
	ld c, NUM_GAME_CENTER_PRIZE_LIST_ITEMS
.loop_index
	ld a, [hli]
	ld [de], a
	inc de
	dec c
	jr nz, .loop_index
	ret

.lineup_table
	dw .WithJigglypuffCoin
	dw .WithoutJigglypuffCoin

.WithJigglypuffCoin:
	db GAMECENTERPRIZE_VENUSAUR
	db GAMECENTERPRIZE_MEW
	db GAMECENTERPRIZE_BILLS_COMPUTER
	db GAMECENTERPRIZE_JIGGLYPUFF_COIN
	db GAMECENTERPRIZE_1_PRESENT_PACK

.WithoutJigglypuffCoin:
	db GAMECENTERPRIZE_VENUSAUR
	db GAMECENTERPRIZE_MEW
	db GAMECENTERPRIZE_BILLS_COMPUTER
	db GAMECENTERPRIZE_3_PRESENT_PACKS
	db GAMECENTERPRIZE_1_PRESENT_PACK

InitGameCenterPrizeExchangeLineup:
	xor a
	ld [wClaimedJigglypuffCoin], a
	ret
