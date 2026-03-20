; accessed from select btn (DuelMenuShortcut_BothActivePokemon)
; or from check menu (DuelCheckMenu_InPlayArea)
OpenInPlayAreaScreen::
	ld a, INPLAYAREA_PLAYER_ACTIVE
	ld [wMultiDirectionalMenuCursorPosition], a
.start
	xor a
	ld [wScrollMenuCursorBlinkCounter], a
	farcall DrawInPlayAreaScreen
	call EnableLCD
	bank1call IsClairvoyanceActive
	jr c, .clairvoyance_on
	ld a, [wPrizeCardsFaceUp]
	or a
	jr z, .default
; here comes team rocket on
	ld de, OpenInPlayAreaScreen_TransitionTable_WithPrizes
	jr .got_transition_table
.default
	ld de, OpenInPlayAreaScreen_TransitionTable
	jr .got_transition_table
.clairvoyance_on
	ld de, OpenInPlayAreaScreen_TransitionTable_WithHand

.got_transition_table
	ld hl, wTransitionTablePtr
	ld [hl], e
	inc hl
	ld [hl], d
	ld a, [wMultiDirectionalMenuCursorPosition]
	call .PrintAssociatedText

.on_frame
	ld a, TRUE
	ld [wVBlankOAMCopyToggle], a
	call DoFrame

	ldh a, [hDPadHeld]
	and PAD_START
	jr nz, .selection

; handle input if called from check menu
; skip input if called from select btn
	ld a, [wInPlayAreaFromSelectButton]
	or a
	jr z, .handle_input
	ldh a, [hDPadHeld]
	and PAD_SELECT
	jr nz, .skip_input

.handle_input
	ld a, [wMultiDirectionalMenuCursorPosition]
	ld [wTempInPlayAreaCursorPosition], a
	call OpenInPlayAreaScreen_HandleInput
	jr c, .pressed

	ld a, [wMultiDirectionalMenuCursorPosition]
	cp INPLAYAREA_PLAYER_PLAY_AREA
	jp z, .show_turn_holder_play_area
	cp INPLAYAREA_OPP_PLAY_AREA
	jp z, .show_non_turn_holder_play_area
	ld hl, wTempInPlayAreaCursorPosition
	cp [hl]
	call nz, .PrintAssociatedText
	jr .on_frame

.pressed
	cp MENU_CANCEL
	jr nz, .selection
; cancelled
	call ZeroObjectPositionsAndToggleOAMCopy_Bank06
	lb de, $38, $9f
	call SetupText
	scf
	ret

.skip_input
	call ZeroObjectPositionsAndToggleOAMCopy_Bank06
	lb de, $38, $9f
	call SetupText
	or a
	ret

.selection
	call ZeroObjectPositionsAndToggleOAMCopy_Bank06
	xor a
	ld [wd0d2], a
	ld a, [wMultiDirectionalMenuCursorPosition]
	ld [wPreservedInPlayAreaCursorPosition], a
	ld hl, .PositionsJumpTable
	call JumpToFunctionInTable
	ld a, [wd0d2]
	or a
	jr nz, .on_frame
	ld a, [wPreservedInPlayAreaCursorPosition]
	ld [wMultiDirectionalMenuCursorPosition], a
	jp .start

.PrintAssociatedText:
	push af
	lb de, 1, 17
	call InitTextPrinting
	ldtx hl, EmptyLineText
	call ProcessTextFromID

	ld hl, hffbb
	ld [hl], $01
	ldtx hl, HandText_2
	call ProcessTextFromID

	ld hl, hffbb
	ld [hl], $00
	lb de, 1, 17
	call InitTextPrinting
	pop af
	ld hl, OpenInPlayAreaScreen_TextTable
	ld b, 0
	sla a
	ld c, a
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, h
	or a
	jr nz, .hand_or_discard_pile
	ld a, l
	cp MAX_PLAY_AREA_POKEMON + MAX_PRIZE_CARDS
	jr nc, .hand_or_discard_pile
	cp MAX_PLAY_AREA_POKEMON
	jr nc, .prize_cards
	ld a, [wMultiDirectionalMenuCursorPosition]
	cp INPLAYAREA_PLAYER_HAND
	jr nc, .opponent_side

	ld a, l
	add DUELVARS_ARENA_CARD
	get_turn_duelist_var
	cp -1
	ret z

	call GetCardIDFromDeckIndex
	call LoadCardDataToBuffer1_FromCardID
	jr .display_card_name

.opponent_side
	ld a, l
	add DUELVARS_ARENA_CARD
	call GetNonTurnDuelistVariable
	cp -1
	ret z

	call SwapTurn
	call GetCardIDFromDeckIndex
	call LoadCardDataToBuffer1_FromCardID
	call SwapTurn

.display_card_name
	ld a, 18
	call CopyCardNameAndLevel
	ld hl, wDefaultText
	call ProcessText
	ret

.prize_cards
	sub INPLAYAREA_PRIZE_1
	ld b, a
	ld a, [wMultiDirectionalMenuCursorPosition]
	cp INPLAYAREA_OPP_PRIZE_1
	jr nc, .opp_side_prize_cards
	push bc
	ld a, b
	call IsCurPrizeCardRemaining
	pop bc
	ret z

	ld a, b
	add DUELVARS_PRIZE_CARDS
	get_turn_duelist_var
	call GetCardIDFromDeckIndex
	call LoadCardDataToBuffer1_FromCardID
	jr .display_card_name

.opp_side_prize_cards
	push bc
	ld a, b
	call SwapTurn
	call IsCurPrizeCardRemaining
	call SwapTurn
	pop bc
	ret z

	ld a, b
	add DUELVARS_PRIZE_CARDS
	call GetNonTurnDuelistVariable
	call SwapTurn
	call GetCardIDFromDeckIndex
	call LoadCardDataToBuffer1_FromCardID
	call SwapTurn
	jr .display_card_name

.hand_or_discard_pile
	ld a, [wMultiDirectionalMenuCursorPosition]
	cp INPLAYAREA_OPP_ACTIVE
	jr nc, .opp_side_print_hand_or_discard_pile
	call PrintTextNoDelay
	ret

.opp_side_print_hand_or_discard_pile
	call SwapTurn
	call PrintTextNoDelay
	call SwapTurn
	ret

.show_turn_holder_play_area:
	lb de, $38, $9f
	call SetupText
	ldh a, [hWhoseTurn]
	push af
	bank1call OpenTurnHolderPlayAreaScreen
	pop af
	ldh [hWhoseTurn], a
	ld a, [wPreservedInPlayAreaCursorPosition]
	ld [wMultiDirectionalMenuCursorPosition], a
	jp .start

.show_non_turn_holder_play_area:
	lb de, $38, $9f
	call SetupText
	ldh a, [hWhoseTurn]
	push af
	bank1call OpenNonTurnHolderPlayAreaScreen
	pop af
	ldh [hWhoseTurn], a
	ld a, [wPreservedInPlayAreaCursorPosition]
	ld [wMultiDirectionalMenuCursorPosition], a
	jp .start

.PositionsJumpTable:
	dw OpenInPlayAreaScreen_TurnHolderPlayArea       ; INPLAYAREA_PLAYER_BENCH_1
	dw OpenInPlayAreaScreen_TurnHolderPlayArea       ; INPLAYAREA_PLAYER_BENCH_2
	dw OpenInPlayAreaScreen_TurnHolderPlayArea       ; INPLAYAREA_PLAYER_BENCH_3
	dw OpenInPlayAreaScreen_TurnHolderPlayArea       ; INPLAYAREA_PLAYER_BENCH_4
	dw OpenInPlayAreaScreen_TurnHolderPlayArea       ; INPLAYAREA_PLAYER_BENCH_5
	dw OpenInPlayAreaScreen_TurnHolderPlayArea       ; INPLAYAREA_PLAYER_ACTIVE
	dw OpenInPlayAreaScreen_TurnHolderHand           ; INPLAYAREA_PLAYER_HAND
	dw OpenInPlayAreaScreen_TurnHolderDiscardPile    ; INPLAYAREA_PLAYER_DISCARD_PILE
	dw OpenInPlayAreaScreen_NonTurnHolderPlayArea    ; INPLAYAREA_OPP_ACTIVE
	dw OpenInPlayAreaScreen_NonTurnHolderHand        ; INPLAYAREA_OPP_HAND
	dw OpenInPlayAreaScreen_NonTurnHolderDiscardPile ; INPLAYAREA_OPP_DISCARD_PILE
	dw OpenInPlayAreaScreen_NonTurnHolderPlayArea    ; INPLAYAREA_OPP_BENCH_1
	dw OpenInPlayAreaScreen_NonTurnHolderPlayArea    ; INPLAYAREA_OPP_BENCH_2
	dw OpenInPlayAreaScreen_NonTurnHolderPlayArea    ; INPLAYAREA_OPP_BENCH_3
	dw OpenInPlayAreaScreen_NonTurnHolderPlayArea    ; INPLAYAREA_OPP_BENCH_4
	dw OpenInPlayAreaScreen_NonTurnHolderPlayArea    ; INPLAYAREA_OPP_BENCH_5
	dw OpenInPlayAreaScreen_TurnHolderPrizeCards     ; INPLAYAREA_PLAYER_PRIZE_1
	dw OpenInPlayAreaScreen_TurnHolderPrizeCards     ; INPLAYAREA_PLAYER_PRIZE_2
	dw OpenInPlayAreaScreen_TurnHolderPrizeCards     ; INPLAYAREA_PLAYER_PRIZE_3
	dw OpenInPlayAreaScreen_TurnHolderPrizeCards     ; INPLAYAREA_PLAYER_PRIZE_4
	dw OpenInPlayAreaScreen_TurnHolderPrizeCards     ; INPLAYAREA_PLAYER_PRIZE_5
	dw OpenInPlayAreaScreen_TurnHolderPrizeCards     ; INPLAYAREA_PLAYER_PRIZE_6
	dw OpenInPlayAreaScreen_NonTurnHolderPrizeCards  ; INPLAYAREA_OPP_PRIZE_1
	dw OpenInPlayAreaScreen_NonTurnHolderPrizeCards  ; INPLAYAREA_OPP_PRIZE_2
	dw OpenInPlayAreaScreen_NonTurnHolderPrizeCards  ; INPLAYAREA_OPP_PRIZE_3
	dw OpenInPlayAreaScreen_NonTurnHolderPrizeCards  ; INPLAYAREA_OPP_PRIZE_4
	dw OpenInPlayAreaScreen_NonTurnHolderPrizeCards  ; INPLAYAREA_OPP_PRIZE_5
	dw OpenInPlayAreaScreen_NonTurnHolderPrizeCards  ; INPLAYAREA_OPP_PRIZE_6

OpenInPlayAreaScreen_TurnHolderPlayArea:
	lb de, $38, $9f
	call SetupText
; convert INPLAYAREA_PLAYER_* to PLAY_AREA_*
	ld a, [wMultiDirectionalMenuCursorPosition]
	inc a
	cp INPLAYAREA_PLAYER_ACTIVE + 1
	jr nz, .on_bench
	xor a ; PLAY_AREA_ARENA
.on_bench
	ld [wCurPlayAreaSlot], a
	add DUELVARS_ARENA_CARD
	get_turn_duelist_var
	cp -1
	ret z

	call GetCardIDFromDeckIndex
	call LoadCardDataToBuffer1_FromCardID
	xor a
	ld [wCurPlayAreaY], a
	bank1call OpenCardPage_FromCheckPlayArea
	ret

OpenInPlayAreaScreen_NonTurnHolderPlayArea:
	lb de, $38, $9f
	call SetupText
; convert INPLAYAREA_OPP_* to PLAY_AREA_*
	ld a, [wMultiDirectionalMenuCursorPosition]
	sub INPLAYAREA_OPP_ACTIVE
	or a
	jr z, .active
	sub INPLAYAREA_OPP_BENCH_1 - INPLAYAREA_OPP_ACTIVE - PLAY_AREA_BENCH_1
.active
	ld [wCurPlayAreaSlot], a
	add DUELVARS_ARENA_CARD
	call GetNonTurnDuelistVariable
	cp -1
	ret z

	call SwapTurn
	call GetCardIDFromDeckIndex
	call LoadCardDataToBuffer1_FromCardID
	xor a
	ld [wCurPlayAreaY], a
	bank1call OpenCardPage_FromCheckPlayArea
	call SwapTurn
	ret

OpenInPlayAreaScreen_TurnHolderPrizeCards:
	ld a, [wMultiDirectionalMenuCursorPosition]
	sub INPLAYAREA_PLAYER_PRIZE_1
	call IsCurPrizeCardRemaining
	jr nz, .found
	ld a, $01
	ld [wd0d2], a
	ret

.found
	lb de, $38, $9f
	call SetupText
	ld a, [wMultiDirectionalMenuCursorPosition]
	sub INPLAYAREA_PLAYER_PRIZE_1
	add DUELVARS_PRIZE_CARDS
	get_turn_duelist_var
	call GetCardIDFromDeckIndex
	call LoadCardDataToBuffer1_FromCardID
	bank1call OpenCardPage_FromHand
	ret

OpenInPlayAreaScreen_NonTurnHolderPrizeCards:
	ld a, [wMultiDirectionalMenuCursorPosition]
	sub INPLAYAREA_OPP_PRIZE_1
	call SwapTurn
	call IsCurPrizeCardRemaining
	call SwapTurn
	jr nz, .found
	ld a, $01
	ld [wd0d2], a
	ret

.found
	lb de, $38, $9f
	call SetupText
	ld a, [wMultiDirectionalMenuCursorPosition]
	sub INPLAYAREA_OPP_PRIZE_1
	add DUELVARS_PRIZE_CARDS
	call GetNonTurnDuelistVariable
	call SwapTurn
	call GetCardIDFromDeckIndex
	call LoadCardDataToBuffer1_FromCardID
	bank1call OpenCardPage_FromHand
	call SwapTurn
	ret

OpenInPlayAreaScreen_TurnHolderHand:
	lb de, $38, $9f
	call SetupText
	ldh a, [hWhoseTurn]
	push af
	bank1call OpenTurnHolderHandScreen_Simple
	pop af
	ldh [hWhoseTurn], a
	ret

OpenInPlayAreaScreen_NonTurnHolderHand:
	lb de, $38, $9f
	call SetupText
	ldh a, [hWhoseTurn]
	push af
	bank1call OpenNonTurnHolderHandScreen_Simple
	pop af
	ldh [hWhoseTurn], a
	ret

OpenInPlayAreaScreen_TurnHolderDiscardPile:
	lb de, $38, $9f
	call SetupText
	ldh a, [hWhoseTurn]
	push af
	bank1call OpenTurnHolderDiscardPileScreen
	pop af
	ldh [hWhoseTurn], a
	ret

OpenInPlayAreaScreen_NonTurnHolderDiscardPile:
	lb de, $38, $9f
	call SetupText
	ldh a, [hWhoseTurn]
	push af
	bank1call OpenNonTurnHolderDiscardPileScreen
	pop af
	ldh [hWhoseTurn], a
	ret

; only hand and discard pile slots have text id
OpenInPlayAreaScreen_TextTable:
	dw PLAY_AREA_BENCH_1        ; INPLAYAREA_PLAYER_BENCH_1
	dw PLAY_AREA_BENCH_2        ; INPLAYAREA_PLAYER_BENCH_2
	dw PLAY_AREA_BENCH_3        ; INPLAYAREA_PLAYER_BENCH_3
	dw PLAY_AREA_BENCH_4        ; INPLAYAREA_PLAYER_BENCH_4
	dw PLAY_AREA_BENCH_5        ; INPLAYAREA_PLAYER_BENCH_5
	dw PLAY_AREA_ARENA          ; INPLAYAREA_PLAYER_ACTIVE
	tx DuelistHandText_2        ; INPLAYAREA_PLAYER_HAND
	tx DuelistDiscardPileText_2 ; INPLAYAREA_PLAYER_DISCARD_PILE
	dw PLAY_AREA_ARENA          ; INPLAYAREA_OPP_ACTIVE
	tx DuelistHandText_2        ; INPLAYAREA_OPP_HAND
	tx DuelistDiscardPileText_2 ; INPLAYAREA_OPP_DISCARD_PILE
	dw PLAY_AREA_BENCH_1        ; INPLAYAREA_OPP_BENCH_1
	dw PLAY_AREA_BENCH_2        ; INPLAYAREA_OPP_BENCH_2
	dw PLAY_AREA_BENCH_3        ; INPLAYAREA_OPP_BENCH_3
	dw PLAY_AREA_BENCH_4        ; INPLAYAREA_OPP_BENCH_4
	dw PLAY_AREA_BENCH_5        ; INPLAYAREA_OPP_BENCH_5
	dw INPLAYAREA_PRIZE_1       ; INPLAYAREA_PLAYER_PRIZE_1
	dw INPLAYAREA_PRIZE_2       ; INPLAYAREA_PLAYER_PRIZE_2
	dw INPLAYAREA_PRIZE_3       ; INPLAYAREA_PLAYER_PRIZE_3
	dw INPLAYAREA_PRIZE_4       ; INPLAYAREA_PLAYER_PRIZE_4
	dw INPLAYAREA_PRIZE_5       ; INPLAYAREA_PLAYER_PRIZE_5
	dw INPLAYAREA_PRIZE_6       ; INPLAYAREA_PLAYER_PRIZE_6
	dw INPLAYAREA_PRIZE_1       ; INPLAYAREA_OPP_PRIZE_1
	dw INPLAYAREA_PRIZE_2       ; INPLAYAREA_OPP_PRIZE_2
	dw INPLAYAREA_PRIZE_3       ; INPLAYAREA_OPP_PRIZE_3
	dw INPLAYAREA_PRIZE_4       ; INPLAYAREA_OPP_PRIZE_4
	dw INPLAYAREA_PRIZE_5       ; INPLAYAREA_OPP_PRIZE_5
	dw INPLAYAREA_PRIZE_6       ; INPLAYAREA_OPP_PRIZE_6

MACRO in_play_area_cursor_transition
	cursor_transition \1, \2, \3, INPLAYAREA_\4, INPLAYAREA_\5, INPLAYAREA_\6, INPLAYAREA_\7
ENDM

OpenInPlayAreaScreen_TransitionTable:
	in_play_area_cursor_transition  $18, $8c, $00,       PLAYER_ACTIVE,       PLAYER_PLAY_AREA, PLAYER_BENCH_2,      PLAYER_BENCH_5
	in_play_area_cursor_transition  $30, $8c, $00,       PLAYER_ACTIVE,       PLAYER_PLAY_AREA, PLAYER_BENCH_3,      PLAYER_BENCH_1
	in_play_area_cursor_transition  $48, $8c, $00,       PLAYER_ACTIVE,       PLAYER_PLAY_AREA, PLAYER_BENCH_4,      PLAYER_BENCH_2
	in_play_area_cursor_transition  $60, $8c, $00,       PLAYER_ACTIVE,       PLAYER_PLAY_AREA, PLAYER_BENCH_5,      PLAYER_BENCH_3
	in_play_area_cursor_transition  $78, $8c, $00,       PLAYER_ACTIVE,       PLAYER_PLAY_AREA, PLAYER_BENCH_1,      PLAYER_BENCH_4
	in_play_area_cursor_transition  $30, $6c, $00,       OPP_ACTIVE,          PLAYER_BENCH_1,   PLAYER_DISCARD_PILE, PLAYER_DISCARD_PILE
	in_play_area_cursor_transition  $78, $80, $00,       PLAYER_DISCARD_PILE, PLAYER_BENCH_1,   PLAYER_ACTIVE,       PLAYER_ACTIVE
	in_play_area_cursor_transition  $78, $70, $00,       OPP_ACTIVE,          PLAYER_HAND,      PLAYER_ACTIVE,       PLAYER_ACTIVE
	in_play_area_cursor_transition  $78, $34, OAM_XFLIP, OPP_BENCH_1,         PLAYER_ACTIVE,    OPP_DISCARD_PILE,    OPP_DISCARD_PILE
	in_play_area_cursor_transition  $30, $20, OAM_XFLIP, OPP_BENCH_1,         OPP_DISCARD_PILE, OPP_ACTIVE,          OPP_ACTIVE
	in_play_area_cursor_transition  $30, $38, OAM_XFLIP, OPP_BENCH_1,         PLAYER_ACTIVE,    OPP_ACTIVE,          OPP_ACTIVE
	in_play_area_cursor_transition  $90, $14, OAM_XFLIP, OPP_PLAY_AREA,       OPP_ACTIVE,       OPP_BENCH_5,         OPP_BENCH_2
	in_play_area_cursor_transition  $78, $14, OAM_XFLIP, OPP_PLAY_AREA,       OPP_ACTIVE,       OPP_BENCH_1,         OPP_BENCH_3
	in_play_area_cursor_transition  $60, $14, OAM_XFLIP, OPP_PLAY_AREA,       OPP_ACTIVE,       OPP_BENCH_2,         OPP_BENCH_4
	in_play_area_cursor_transition  $48, $14, OAM_XFLIP, OPP_PLAY_AREA,       OPP_ACTIVE,       OPP_BENCH_3,         OPP_BENCH_5
	in_play_area_cursor_transition  $30, $14, OAM_XFLIP, OPP_PLAY_AREA,       OPP_ACTIVE,       OPP_BENCH_4,         OPP_BENCH_1

OpenInPlayAreaScreen_TransitionTable_WithHand:
	in_play_area_cursor_transition  $18, $8c, $00,       PLAYER_ACTIVE,       PLAYER_PLAY_AREA, PLAYER_BENCH_2,      PLAYER_BENCH_5
	in_play_area_cursor_transition  $30, $8c, $00,       PLAYER_ACTIVE,       PLAYER_PLAY_AREA, PLAYER_BENCH_3,      PLAYER_BENCH_1
	in_play_area_cursor_transition  $48, $8c, $00,       PLAYER_ACTIVE,       PLAYER_PLAY_AREA, PLAYER_BENCH_4,      PLAYER_BENCH_2
	in_play_area_cursor_transition  $60, $8c, $00,       PLAYER_ACTIVE,       PLAYER_PLAY_AREA, PLAYER_BENCH_5,      PLAYER_BENCH_3
	in_play_area_cursor_transition  $78, $8c, $00,       PLAYER_ACTIVE,       PLAYER_PLAY_AREA, PLAYER_BENCH_1,      PLAYER_BENCH_4
	in_play_area_cursor_transition  $30, $6c, $00,       OPP_ACTIVE,          PLAYER_BENCH_1,   PLAYER_DISCARD_PILE, PLAYER_DISCARD_PILE
	in_play_area_cursor_transition  $78, $80, $00,       PLAYER_DISCARD_PILE, PLAYER_BENCH_1,   PLAYER_ACTIVE,       PLAYER_ACTIVE
	in_play_area_cursor_transition  $78, $70, $00,       OPP_ACTIVE,          PLAYER_HAND,      PLAYER_ACTIVE,       PLAYER_ACTIVE
	in_play_area_cursor_transition  $78, $34, OAM_XFLIP, OPP_BENCH_1,         PLAYER_ACTIVE,    OPP_DISCARD_PILE,    OPP_DISCARD_PILE
	in_play_area_cursor_transition  $30, $20, OAM_XFLIP, OPP_BENCH_1,         OPP_DISCARD_PILE, OPP_ACTIVE,          OPP_ACTIVE
	in_play_area_cursor_transition  $30, $38, OAM_XFLIP, OPP_HAND,            PLAYER_ACTIVE,    OPP_ACTIVE,          OPP_ACTIVE
	in_play_area_cursor_transition  $90, $14, OAM_XFLIP, OPP_PLAY_AREA,       OPP_ACTIVE,       OPP_BENCH_5,         OPP_BENCH_2
	in_play_area_cursor_transition  $78, $14, OAM_XFLIP, OPP_PLAY_AREA,       OPP_ACTIVE,       OPP_BENCH_1,         OPP_BENCH_3
	in_play_area_cursor_transition  $60, $14, OAM_XFLIP, OPP_PLAY_AREA,       OPP_ACTIVE,       OPP_BENCH_2,         OPP_BENCH_4
	in_play_area_cursor_transition  $48, $14, OAM_XFLIP, OPP_PLAY_AREA,       OPP_ACTIVE,       OPP_BENCH_3,         OPP_BENCH_5
	in_play_area_cursor_transition  $30, $14, OAM_XFLIP, OPP_PLAY_AREA,       OPP_ACTIVE,       OPP_BENCH_4,         OPP_BENCH_1

OpenInPlayAreaScreen_TransitionTable_WithPrizes:
	in_play_area_cursor_transition  $18, $8c, $00,       PLAYER_ACTIVE,       PLAYER_PLAY_AREA, PLAYER_BENCH_2,      PLAYER_BENCH_5
	in_play_area_cursor_transition  $30, $8c, $00,       PLAYER_ACTIVE,       PLAYER_PLAY_AREA, PLAYER_BENCH_3,      PLAYER_BENCH_1
	in_play_area_cursor_transition  $48, $8c, $00,       PLAYER_ACTIVE,       PLAYER_PLAY_AREA, PLAYER_BENCH_4,      PLAYER_BENCH_2
	in_play_area_cursor_transition  $60, $8c, $00,       PLAYER_ACTIVE,       PLAYER_PLAY_AREA, PLAYER_BENCH_5,      PLAYER_BENCH_3
	in_play_area_cursor_transition  $78, $8c, $00,       PLAYER_ACTIVE,       PLAYER_PLAY_AREA, PLAYER_BENCH_1,      PLAYER_BENCH_4
	in_play_area_cursor_transition  $30, $6c, $00,       OPP_ACTIVE,          PLAYER_BENCH_1,   PLAYER_DISCARD_PILE, PLAYER_PRIZE_1
	in_play_area_cursor_transition  $78, $80, $00,       PLAYER_DISCARD_PILE, PLAYER_BENCH_1,   PLAYER_ACTIVE,       PLAYER_ACTIVE
	in_play_area_cursor_transition  $78, $70, $00,       OPP_ACTIVE,          PLAYER_HAND,      PLAYER_ACTIVE,       PLAYER_ACTIVE
	in_play_area_cursor_transition  $78, $34, OAM_XFLIP, OPP_BENCH_1,         PLAYER_ACTIVE,    OPP_PRIZE_1,         OPP_DISCARD_PILE
	in_play_area_cursor_transition  $30, $20, OAM_XFLIP, OPP_BENCH_1,         OPP_DISCARD_PILE, OPP_ACTIVE,          OPP_ACTIVE
	in_play_area_cursor_transition  $30, $38, OAM_XFLIP, OPP_BENCH_1,         PLAYER_ACTIVE,    OPP_ACTIVE,          OPP_ACTIVE
	in_play_area_cursor_transition  $90, $14, OAM_XFLIP, OPP_PLAY_AREA,       OPP_ACTIVE,       OPP_BENCH_5,         OPP_BENCH_2
	in_play_area_cursor_transition  $78, $14, OAM_XFLIP, OPP_PLAY_AREA,       OPP_ACTIVE,       OPP_BENCH_1,         OPP_BENCH_3
	in_play_area_cursor_transition  $60, $14, OAM_XFLIP, OPP_PLAY_AREA,       OPP_ACTIVE,       OPP_BENCH_2,         OPP_BENCH_4
	in_play_area_cursor_transition  $48, $14, OAM_XFLIP, OPP_PLAY_AREA,       OPP_ACTIVE,       OPP_BENCH_3,         OPP_BENCH_5
	in_play_area_cursor_transition  $30, $14, OAM_XFLIP, OPP_PLAY_AREA,       OPP_ACTIVE,       OPP_BENCH_4,         OPP_BENCH_1
	in_play_area_cursor_transition  $08, $5c, $00,       OPP_ACTIVE,          PLAYER_PRIZE_3,   PLAYER_PRIZE_2,      PLAYER_PRIZE_1
	in_play_area_cursor_transition  $30, $5c, OAM_XFLIP, OPP_ACTIVE,          PLAYER_PRIZE_4,   PLAYER_ACTIVE,       PLAYER_PRIZE_1
	in_play_area_cursor_transition  $08, $6c, $00,       PLAYER_PRIZE_1,      PLAYER_PRIZE_5,   PLAYER_PRIZE_4,      PLAYER_PRIZE_3
	in_play_area_cursor_transition  $30, $6c, OAM_XFLIP, PLAYER_PRIZE_2,      PLAYER_PRIZE_6,   PLAYER_ACTIVE,       PLAYER_PRIZE_3
	in_play_area_cursor_transition  $08, $7c, $00,       PLAYER_PRIZE_3,      PLAYER_BENCH_1,   PLAYER_PRIZE_6,      PLAYER_PRIZE_5
	in_play_area_cursor_transition  $30, $7c, OAM_XFLIP, PLAYER_PRIZE_4,      PLAYER_BENCH_1,   PLAYER_ACTIVE,       PLAYER_PRIZE_5
	in_play_area_cursor_transition  $a0, $44, OAM_XFLIP, OPP_PRIZE_3,         PLAYER_ACTIVE,    OPP_PRIZE_1,         OPP_PRIZE_2
	in_play_area_cursor_transition  $78, $44, $00,       OPP_PRIZE_4,         PLAYER_ACTIVE,    OPP_PRIZE_1,         OPP_ACTIVE
	in_play_area_cursor_transition  $a0, $34, OAM_XFLIP, OPP_PRIZE_5,         OPP_PRIZE_1,      OPP_PRIZE_3,         OPP_PRIZE_4
	in_play_area_cursor_transition  $78, $34, $00,       OPP_PRIZE_6,         OPP_PRIZE_2,      OPP_PRIZE_3,         OPP_ACTIVE
	in_play_area_cursor_transition  $a0, $24, OAM_XFLIP, OPP_BENCH_1,         OPP_PRIZE_3,      OPP_PRIZE_5,         OPP_PRIZE_6
	in_play_area_cursor_transition  $78, $24, $00,       OPP_BENCH_1,         OPP_PRIZE_4,      OPP_PRIZE_5,         OPP_ACTIVE

OpenInPlayAreaScreen_TransitionTable_WithHandAndPrizes:
	in_play_area_cursor_transition  $18, $8c, $00,       PLAYER_ACTIVE,       PLAYER_PLAY_AREA, PLAYER_BENCH_2,      PLAYER_BENCH_5
	in_play_area_cursor_transition  $30, $8c, $00,       PLAYER_ACTIVE,       PLAYER_PLAY_AREA, PLAYER_BENCH_3,      PLAYER_BENCH_1
	in_play_area_cursor_transition  $48, $8c, $00,       PLAYER_ACTIVE,       PLAYER_PLAY_AREA, PLAYER_BENCH_4,      PLAYER_BENCH_2
	in_play_area_cursor_transition  $60, $8c, $00,       PLAYER_ACTIVE,       PLAYER_PLAY_AREA, PLAYER_BENCH_5,      PLAYER_BENCH_3
	in_play_area_cursor_transition  $78, $8c, $00,       PLAYER_ACTIVE,       PLAYER_PLAY_AREA, PLAYER_BENCH_1,      PLAYER_BENCH_4
	in_play_area_cursor_transition  $30, $6c, $00,       OPP_ACTIVE,          PLAYER_BENCH_1,   PLAYER_DISCARD_PILE, PLAYER_PRIZE_1
	in_play_area_cursor_transition  $78, $80, $00,       PLAYER_DISCARD_PILE, PLAYER_BENCH_1,   PLAYER_ACTIVE,       PLAYER_ACTIVE
	in_play_area_cursor_transition  $78, $70, $00,       OPP_ACTIVE,          PLAYER_HAND,      PLAYER_ACTIVE,       PLAYER_ACTIVE
	in_play_area_cursor_transition  $78, $34, OAM_XFLIP, OPP_BENCH_1,         PLAYER_ACTIVE,    OPP_PRIZE_1,         OPP_DISCARD_PILE
	in_play_area_cursor_transition  $30, $20, OAM_XFLIP, OPP_BENCH_1,         OPP_DISCARD_PILE, OPP_ACTIVE,          OPP_ACTIVE
	in_play_area_cursor_transition  $30, $38, OAM_XFLIP, OPP_HAND,            PLAYER_ACTIVE,    OPP_ACTIVE,          OPP_ACTIVE
	in_play_area_cursor_transition  $90, $14, OAM_XFLIP, OPP_PLAY_AREA,       OPP_ACTIVE,       OPP_BENCH_5,         OPP_BENCH_2
	in_play_area_cursor_transition  $78, $14, OAM_XFLIP, OPP_PLAY_AREA,       OPP_ACTIVE,       OPP_BENCH_1,         OPP_BENCH_3
	in_play_area_cursor_transition  $60, $14, OAM_XFLIP, OPP_PLAY_AREA,       OPP_ACTIVE,       OPP_BENCH_2,         OPP_BENCH_4
	in_play_area_cursor_transition  $48, $14, OAM_XFLIP, OPP_PLAY_AREA,       OPP_ACTIVE,       OPP_BENCH_3,         OPP_BENCH_5
	in_play_area_cursor_transition  $30, $14, OAM_XFLIP, OPP_PLAY_AREA,       OPP_ACTIVE,       OPP_BENCH_4,         OPP_BENCH_1
	in_play_area_cursor_transition  $08, $5c, $00,       OPP_ACTIVE,          PLAYER_PRIZE_3,   PLAYER_PRIZE_2,      PLAYER_PRIZE_1
	in_play_area_cursor_transition  $30, $5c, OAM_XFLIP, OPP_ACTIVE,          PLAYER_PRIZE_4,   PLAYER_ACTIVE,       PLAYER_PRIZE_1
	in_play_area_cursor_transition  $08, $6c, $00,       PLAYER_PRIZE_1,      PLAYER_PRIZE_5,   PLAYER_PRIZE_4,      PLAYER_PRIZE_3
	in_play_area_cursor_transition  $30, $6c, OAM_XFLIP, PLAYER_PRIZE_2,      PLAYER_PRIZE_6,   PLAYER_ACTIVE,       PLAYER_PRIZE_3
	in_play_area_cursor_transition  $08, $7c, $00,       PLAYER_PRIZE_3,      PLAYER_BENCH_1,   PLAYER_PRIZE_6,      PLAYER_PRIZE_5
	in_play_area_cursor_transition  $30, $7c, OAM_XFLIP, PLAYER_PRIZE_4,      PLAYER_BENCH_1,   PLAYER_ACTIVE,       PLAYER_PRIZE_5
	in_play_area_cursor_transition  $a0, $44, OAM_XFLIP, OPP_PRIZE_3,         PLAYER_ACTIVE,    OPP_PRIZE_1,         OPP_PRIZE_2
	in_play_area_cursor_transition  $78, $44, $00,       OPP_PRIZE_4,         PLAYER_ACTIVE,    OPP_PRIZE_1,         OPP_ACTIVE
	in_play_area_cursor_transition  $a0, $34, OAM_XFLIP, OPP_PRIZE_5,         OPP_PRIZE_1,      OPP_PRIZE_3,         OPP_PRIZE_4
	in_play_area_cursor_transition  $78, $34, $00,       OPP_PRIZE_6,         OPP_PRIZE_2,      OPP_PRIZE_3,         OPP_ACTIVE
	in_play_area_cursor_transition  $a0, $24, OAM_XFLIP, OPP_BENCH_1,         OPP_PRIZE_3,      OPP_PRIZE_5,         OPP_PRIZE_6
	in_play_area_cursor_transition  $78, $24, $00,       OPP_BENCH_1,         OPP_PRIZE_4,      OPP_PRIZE_5,         OPP_ACTIVE

; variant of HandleMultiDirectionalMenu
OpenInPlayAreaScreen_HandleInput:
	xor a
	ld [wMenuInputSFX], a
	ld hl, wTransitionTablePtr
	ld e, [hl]
	inc hl
	ld d, [hl]
	ld a, [wMultiDirectionalMenuCursorPosition]
	ld l, a
	ld h, CURSOR_TRANSITION_STRUCT_LENGTH
	call HtimesL
	add hl, de

	ldh a, [hDPadHeld]
	or a
	jp z, .check_button
; check d-pad
REPT CURSOR_TRANSITION_STRUCT_DIR_INDICES
	inc hl
ENDR
	bit B_PAD_UP, a
	jr z, .elif_down
; up
	ld a, [hl]
	jr .process_dpad

.elif_down
	inc hl
	bit B_PAD_DOWN, a
	jr z, .elif_right
; down
	ld a, [hl]
	jr .process_dpad

.elif_right
	inc hl
	bit B_PAD_RIGHT, a
	jr z, .elif_left
; right
	ld a, [hl]
	jr .process_dpad

.elif_left
	inc hl
	bit B_PAD_LEFT, a
	jp z, .check_button
; left
	ld a, [hl]

.process_dpad
	push af
	ld a, [wMultiDirectionalMenuCursorPosition]
	ld [wPreservedInPlayAreaCursorPosition], a
	pop af
	ld [wMultiDirectionalMenuCursorPosition], a
	cp INPLAYAREA_PLAYER_ACTIVE
	jr c, .player_area
	cp INPLAYAREA_OPP_BENCH_1
	jr c, .next
	cp INPLAYAREA_PLAYER_PRIZE_1
	jr c, .opponent_area
	cp INPLAYAREA_OPP_PRIZE_1
	jr c, .player_prize_cards
	cp NUM_INPLAYAREA_POSITIONS
	jr c, .opponent_prize_cards
	jr .next

.player_area
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	dec a
	jr nz, .player_has_benched_pkmn
; no benched pkmn, so move to play area
	ld a, INPLAYAREA_PLAYER_PLAY_AREA
	ld [wMultiDirectionalMenuCursorPosition], a
	jr .next
.player_has_benched_pkmn
	ld b, a
	ld a, [wMultiDirectionalMenuCursorPosition]
	cp b
	jr c, .next
; check wrap
	ldh a, [hDPadHeld]
	bit B_PAD_RIGHT, a
	jr z, .on_left
	xor a
	ld [wMultiDirectionalMenuCursorPosition], a
	jr .next
.on_left
	ld a, b
	dec a
	ld [wMultiDirectionalMenuCursorPosition], a
	jr .next

.opponent_area
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	call GetNonTurnDuelistVariable
	dec a
	jr nz, .opponent_has_benched_pkmn
; no benched pkmn, so move to play area
	ld a, INPLAYAREA_OPP_PLAY_AREA
	ld [wMultiDirectionalMenuCursorPosition], a
	jr .next
.opponent_has_benched_pkmn
	ld b, a
	ld a, [wMultiDirectionalMenuCursorPosition]
	sub INPLAYAREA_OPP_BENCH_1
	cp b
	jr c, .next
; check wrap
	ldh a, [hDPadHeld]
	bit B_PAD_LEFT, a
	jr z, .on_right
	ld a, INPLAYAREA_OPP_BENCH_1
	ld [wMultiDirectionalMenuCursorPosition], a
	jr .next
.on_right
	ld a, b
	add INPLAYAREA_OPP_BENCH_1 - 1
	ld [wMultiDirectionalMenuCursorPosition], a
	jr .next

.player_prize_cards
	sub INPLAYAREA_PLAYER_PRIZE_1
	ld hl, wDuelInitialPrizes
	cp [hl]
	jp nc, OpenInPlayAreaScreen_HandleInput
	jr .next

.opponent_prize_cards
	sub INPLAYAREA_OPP_PRIZE_1
	ld hl, wDuelInitialPrizes
	cp [hl]
	jp nc, OpenInPlayAreaScreen_HandleInput

.next
	ld a, SFX_CURSOR
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
	ld a, MENU_CANCEL
	farcall PlaySFXConfirmOrCancel
	scf
	ret

.a_btn
	call .DrawCursor
	ld a, MENU_CONFIRM
	farcall PlaySFXConfirmOrCancel
	ld a, [wMultiDirectionalMenuCursorPosition]
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
	jr nz, ZeroObjectPositionsAndToggleOAMCopy_Bank06

.DrawCursor:
	call ZeroObjectPositions
	ld hl, wTransitionTablePtr
	ld e, [hl]
	inc hl
	ld d, [hl]
	ld a, [wMultiDirectionalMenuCursorPosition]
	ld l, a
	ld h, CURSOR_TRANSITION_STRUCT_LENGTH
	call HtimesL
	add hl, de
; for table = [wTransitionTablePtr] and i = wMultiDirectionalMenuCursorPosition,
; hl = table[i]

	ld d, [hl] ; CURSOR_TRANSITION_STRUCT_X
	inc hl
	ld e, [hl] ; CURSOR_TRANSITION_STRUCT_Y
	inc hl
	ld b, [hl] ; CURSOR_TRANSITION_STRUCT_ATTR
	ld c, $00 ; cursor tile
	call SetOneObjectAttributes
	or a
	ret

ZeroObjectPositionsAndToggleOAMCopy_Bank06:
	call ZeroObjectPositions
	ld a, TRUE
	ld [wVBlankOAMCopyToggle], a
	ret

; a = prize card index
; get bit a, DUELVARS_PRIZES
IsCurPrizeCardRemaining:
	ld b, 1
.loop_bitmask
	or a
	jr z, .get_bit
	sla b
	dec a
	jr .loop_bitmask
.get_bit
	ld a, DUELVARS_PRIZES
	get_turn_duelist_var
	and b
	ret
