ScenarioDebugMenu:
	push af
	push bc
	push de
	push hl
	call DisableLCD
	farcall SetInitialGraphicsConfiguration
	farcall ZeroObjectPositionsAndEnableOBPFading
	call FlushAllPalettes
	ld a, SYM_SPACE
	ld [wTileMapFill], a
	call EmptyScreen
	call LoadSymbolsFont
	call PrintScenarioDebugMenu
	call EnableLCD
	xor a
	ld [wScenarioDebugMenuCursorPosition], a
	ld [wScenarioDebugMenu_d67a], a
	ld [wScenarioDebugMenuCurEventFlagItem], a
	ld [wScenarioDebugMenuCurEventVarItem], a
	ld [wScenarioDebugMenuCurEventItem], a
	ld [wScenarioDebugMenuCurCardItem + 1], a
	ld a, LOW(GRASS_ENERGY)
	ld [wScenarioDebugMenuCurCardItem], a
; fallthrough

HandleScenarioDebugMenu:
	call DoFrame
	call DrawScenarioDebugMenuCursor
	ldh a, [hKeysPressed]
	bit B_PAD_B, a
	jr nz, .exit
	bit B_PAD_UP, a
	jr nz, .up_pressed
	bit B_PAD_DOWN, a
	jr nz, .down_pressed
	bit B_PAD_A, a
	jr nz, .a_btn_pressed
	jr HandleScenarioDebugMenu

.exit
	pop hl
	pop de
	pop bc
	pop af
	ret

.up_pressed
	ld a, [wScenarioDebugMenuCursorPosition]
	or a
	jr nz, .handle_up
	ld a, NUM_SCENARIODEBUGMENU_ITEMS
.handle_up
	dec a
	call RefreshScenarioDebugMenuCursor
	jr HandleScenarioDebugMenu

.down_pressed
	ld a, [wScenarioDebugMenuCursorPosition]
	inc a
	cp NUM_SCENARIODEBUGMENU_ITEMS
	jr nz, .handle_down
	xor a
.handle_down
	call RefreshScenarioDebugMenuCursor
	jr HandleScenarioDebugMenu

.a_btn_pressed
	call ClearScenarioDebugMenuValueSelector
	ld a, [wScenarioDebugMenuCursorPosition]
	cp SCENARIODEBUGMENU_MODIFY_EXIT
	jr z, .exit
	push af
	ld hl, .ReinitMenu
	push hl
	or a
	jp z, DebugModifyEvents   ; SCENARIODEBUGMENU_MODIFY_EVENTS
	dec a
	jp z, DebugModifyFlags    ; SCENARIODEBUGMENU_MODIFY_FLAGS
	dec a
	jp z, DebugModifyCounters ; SCENARIODEBUGMENU_MODIFY_COUNTERS
	jp DebugModifyCardCount   ; SCENARIODEBUGMENU_MODIFY_CARD_COUNT

.ReinitMenu:
	pop af
	call RefreshScenarioDebugMenuCursor
	call PrintScenarioDebugMenu
	jr HandleScenarioDebugMenu

DebugModifyFlags:
	lb de, 0, 15
	ldtx hl, DebugBlankValueSelectorText
	call PrintTextNoDelay_Init
	lb de, 4, 15
	ldtx hl, DebugModifyFlagsNumberLabelText
	call PrintTextNoDelay_Init
	ld a, SCENARIODEBUGMENU_VALUE_SELECTOR
	call RefreshScenarioDebugMenuCursor
	call .PrintFlagMenu

.wait_input
	call DoFrame
	call DrawScenarioDebugMenuCursor
	ldh a, [hKeysHeld]
	bit B_PAD_UP, a
	jr nz, .check_input
	bit B_PAD_DOWN, a
	jr nz, .check_input
	ldh a, [hDPadHeld]
.check_input
	bit B_PAD_B, a
	jr nz, .exit
	bit B_PAD_UP, a
	jr nz, .handle_forward
	bit B_PAD_RIGHT, a
	jr nz, .handle_forward
	bit B_PAD_DOWN, a
	jr nz, .handle_backward
	bit B_PAD_LEFT, a
	jr nz, .handle_backward
	bit B_PAD_A, a
	jr nz, .modify
	jr .wait_input

.exit
	ret

.handle_forward
	ld a, [wScenarioDebugMenuCurEventFlagItem]
	inc a
	cp NUM_EVENT_FLAGS
	jr c, .scroll_forward
	xor a
.scroll_forward
	ld [wScenarioDebugMenuCurEventFlagItem], a
	call .PrintFlagMenu
	jr .wait_input

.handle_backward
	ld a, [wScenarioDebugMenuCurEventFlagItem]
	or a
	jr nz, .scroll_backward
	ld a, NUM_EVENT_FLAGS
.scroll_backward
	dec a
	ld [wScenarioDebugMenuCurEventFlagItem], a
	call .PrintFlagMenu
	jr .wait_input

.modify
	ld a, [wScenarioDebugMenuCurEventFlagItem]
	push af
	farcall GetEventValue
	jr z, .set_flag
; reset
	pop af
	farcall ZeroOutEventValue
	call .PrintFlagMenu
	jr .wait_input
.set_flag
	pop af
	farcall MaxOutEventValue
	call .PrintFlagMenu
	jr .wait_input

.PrintFlagMenu:
	lb bc, 11, 15
	ld a, [wScenarioDebugMenuCurEventFlagItem]
	push af
	bank1call WriteTwoByteNumberInTxSymbolFormat
	pop af
	farcall GetEventValue
	ldtx hl, DebugModifyFlagsOnText
	jr nz, .print_state
	ldtx hl, DebugModifyFlagsOffText
.print_state
	lb de, 15, 15
	call PrintTextNoDelay_Init
	ret

; event vars are internally called "counters"
DebugModifyCounters:
	lb de, 0, 15
	ldtx hl, DebugBlankValueSelectorText
	call PrintTextNoDelay_Init
	lb de, 4, 15
	ldtx hl, DebugModifyCountersNumberLabelText
	call PrintTextNoDelay_Init
	ld a, SCENARIODEBUGMENU_VALUE_SELECTOR
	call RefreshScenarioDebugMenuCursor
	call .PrintCounterMenu

.wait_input
	call DoFrame
	call DrawScenarioDebugMenuCursor
	ldh a, [hKeysHeld]
	bit B_PAD_UP, a
	jr nz, .check_input
	bit B_PAD_DOWN, a
	jr nz, .check_input
	ldh a, [hDPadHeld]
.check_input
	bit B_PAD_B, a
	jr nz, .exit
	bit B_PAD_UP, a
	jr nz, .handle_forward
	bit B_PAD_RIGHT, a
	jr nz, .handle_forward
	bit B_PAD_DOWN, a
	jr nz, .handle_backward
	bit B_PAD_LEFT, a
	jr nz, .handle_backward
	ldh a, [hKeysPressed]
	bit B_PAD_A, a
	jr z, .wait_input

	call DebugModifyCounterValue
	ld a, SCENARIODEBUGMENU_VALUE_SELECTOR
	call RefreshScenarioDebugMenuCursor
	jr .wait_input

.exit
	ret

.handle_forward
	ld a, [wScenarioDebugMenuCurEventVarItem]
	inc a
	cp NUM_EVENT_VARS
	jr c, .scroll_forward
	xor a
.scroll_forward
	ld [wScenarioDebugMenuCurEventVarItem], a
	call .PrintCounterMenu
	jr .wait_input

.handle_backward
	ld a, [wScenarioDebugMenuCurEventVarItem]
	or a
	jr nz, .scroll_backward
	ld a, NUM_EVENT_VARS
.scroll_backward
	dec a
	ld [wScenarioDebugMenuCurEventVarItem], a
	call .PrintCounterMenu
	jr .wait_input

.PrintCounterMenu:
	lb bc, 12, 15
	ld a, [wScenarioDebugMenuCurEventVarItem]
	push af
	bank1call WriteTwoByteNumberInTxSymbolFormat
	pop af
	farcall GetVarValue
	lb bc, 17, 15
	bank1call WriteTwoByteNumberInTxSymbolFormat
	ret

DebugModifyCounterValue:
	ld a, SCENARIODEBUGMENU_VALUE_SELECTOR_COUNTER
	call RefreshScenarioDebugMenuCursor
	call .PrintCounterValue

.wait_input
	call DoFrame
	call DrawScenarioDebugMenuCursor
	ldh a, [hKeysHeld]
	bit B_PAD_UP, a
	jr nz, .check_input
	bit B_PAD_DOWN, a
	jr nz, .check_input
	ldh a, [hDPadHeld]
.check_input
	bit B_PAD_B, a
	jr nz, .exit
	bit B_PAD_UP, a
	jr nz, .handle_forward
	bit B_PAD_RIGHT, a
	jr nz, .handle_forward
	bit B_PAD_DOWN, a
	jr nz, .handle_backward
	bit B_PAD_LEFT, a
	jr nz, .handle_backward
	jr .wait_input

.exit
	ret

.handle_forward
	ld a, [wScenarioDebugMenuCurEventVarItem]
	push af
	farcall GetVarValue
	inc a
	ld c, a
	pop af
	farcall SetVarValue
	call .PrintCounterValue
	jr .wait_input

.handle_backward
	ld a, [wScenarioDebugMenuCurEventVarItem]
	push af
	farcall GetVarValue
	dec a
	ld c, a
	pop af
	farcall SetVarValue
	call .PrintCounterValue
	jr .wait_input

.PrintCounterValue:
	ld a, [wScenarioDebugMenuCurEventVarItem]
	farcall GetVarValue
	lb bc, 17, 15
	bank1call WriteTwoByteNumberInTxSymbolFormat
	ret

PrintScenarioDebugMenu:
	lb de, $40, $ff
	call SetupText
	lb de, 1, 1
	ldtx hl, DebugScenarioDebugMenuText
	call PrintTextNoDelay_Init
	lb de, 4, 4
	ldtx hl, DebugModifyEventsText
	call PrintTextNoDelay_Init
	lb de, 4, 6
	ldtx hl, DebugModifyFlagsText
	call PrintTextNoDelay_Init
	lb de, 4, 8
	ldtx hl, DebugModifyCountersText
	call PrintTextNoDelay_Init
	lb de, 4, 10
	ldtx hl, DebugModifyCardCountText
	call PrintTextNoDelay_Init
	lb de, 4, 12
	ldtx hl, DebugReturnToGameText
	call PrintTextNoDelay_Init
	ret

DebugModifyEvents:
	ld a, SCENARIODEBUGMENU_VALUE_SELECTOR
	call RefreshScenarioDebugMenuCursor
	call .PrintEventMenu

.wait_input
	call DoFrame
	call DrawScenarioDebugMenuCursor
	ldh a, [hKeysHeld]
	bit B_PAD_UP, a
	jr nz, .check_input
	bit B_PAD_DOWN, a
	jr nz, .check_input
	ldh a, [hDPadHeld]
.check_input
	bit B_PAD_B, a
	jr nz, .exit
	bit B_PAD_UP, a
	jr nz, .handle_forward
	bit B_PAD_RIGHT, a
	jr nz, .handle_forward
	bit B_PAD_DOWN, a
	jr nz, .handle_backward
	bit B_PAD_LEFT, a
	jr nz, .handle_backward
	ldh a, [hKeysPressed]
	bit B_PAD_A, a
	jr nz, .modify
	jr .wait_input

.exit
	ret

.handle_forward
	ld a, [wScenarioDebugMenuCurEventItem]
	inc a
	cp NUM_DEBUGEVENTMENU_ITEMS
	jr c, .scroll_forward
	xor a
.scroll_forward
	ld [wScenarioDebugMenuCurEventItem], a
	call .PrintEventMenu
	jr .wait_input

.handle_backward
	ld a, [wScenarioDebugMenuCurEventItem]
	or a
	jr nz, .scroll_backward
	ld a, NUM_DEBUGEVENTMENU_ITEMS
.scroll_backward
	dec a
	ld [wScenarioDebugMenuCurEventItem], a
	call .PrintEventMenu
	jr .wait_input

.PrintEventMenu:
	lb de, 0, 15
	ldtx hl, DebugBlankValueSelectorText
	call PrintTextNoDelay_Init
	ld a, [wScenarioDebugMenuCurEventItem]
	sla a
	sla a
	ld hl, DebugModifyEventsMenuItems
	add_hl_a
	ld a, [hli]
	ld h, [hl]
	ld l, a
	lb de, 4, 15
	call PrintTextNoDelay_Init
	ret

.modify
	ld hl, .exit
	push hl
	ld a, [wScenarioDebugMenuCurEventItem]
	sla a
	sla a
	ld hl, DebugModifyEventsMenuItems
	add_hl_a
	inc hl
	inc hl
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp hl

DebugModifyCardCount:
	lb de, 0, 15
	ldtx hl, DebugBlankValueSelectorText
	call PrintTextNoDelay_Init
	ld a, SCENARIODEBUGMENU_VALUE_SELECTOR
	call RefreshScenarioDebugMenuCursor
	call .PrintCardCountMenu

.wait_input
	call DoFrame
	call DrawScenarioDebugMenuCursor
	ldh a, [hKeysHeld]
	bit B_PAD_UP, a
	jr nz, .check_input
	bit B_PAD_DOWN, a
	jr nz, .check_input
	ldh a, [hDPadHeld]
.check_input
	bit B_PAD_B, a
	jr nz, .exit
	bit B_PAD_UP, a
	jr nz, .handle_forward
	bit B_PAD_RIGHT, a
	jr nz, .handle_forward
	bit B_PAD_DOWN, a
	jr nz, .handle_backward
	bit B_PAD_LEFT, a
	jr nz, .handle_backward
	bit B_PAD_START, a
	jp nz, .PreviewReceivedCardScreen
	ldh a, [hKeysPressed]
	bit B_PAD_A, a
	jr z, .wait_input
	call DebugModifyCardCountValue
	ld a, SCENARIODEBUGMENU_VALUE_SELECTOR
	call RefreshScenarioDebugMenuCursor
	jr .wait_input

.exit
	ret

.handle_forward
	ld a, [wScenarioDebugMenuCurCardItem]
	ld c, a
	ld a, [wScenarioDebugMenuCurCardItem + 1]
	ld b, a
	inc bc
	cp16bc_long NUM_CARDS + 1
	jr c, .scroll_forward
	ld bc, GRASS_ENERGY
.scroll_forward
	ld a, c
	ld [wScenarioDebugMenuCurCardItem], a
	ld a, b
	ld [wScenarioDebugMenuCurCardItem + 1], a
	call .PrintCardCountMenu
	jr .wait_input

.handle_backward
	ld a, [wScenarioDebugMenuCurCardItem]
	ld c, a
	ld a, [wScenarioDebugMenuCurCardItem + 1]
	ld b, a
	dec bc
	ld a, c
	or b
	jr nz, .scroll_backward
	ld bc, NUM_CARDS
.scroll_backward
	ld a, c
	ld [wScenarioDebugMenuCurCardItem], a
	ld a, b
	ld [wScenarioDebugMenuCurCardItem + 1], a
	call .PrintCardCountMenu
	jr .wait_input

; index, name,
; F/D/T: file (collection), deck, total
.PrintCardCountMenu:
	call ClearScenarioDebugMenuValueSelector
	ld a, [wScenarioDebugMenuCurCardItem]
	ld l, a
	ld a, [wScenarioDebugMenuCurCardItem + 1]
	ld h, a
	push hl
	call LoadTxRam3
	lb de, 4, 15
	ldtx hl, DebugModifyCardCountNumberLabelText
	call PrintTextNoDelay_Init
	pop de
	push de
	farcall GetReceivingCardLongName
	call LoadTxRam2
	lb de, 5, 16
	ldtx hl, DebugModifyCardCountCardNameText
	call PrintTextNoDelay_Init
	lb de, 5, 17
	ldtx hl, DebugModifyCardCountValuesText
	call PrintTextNoDelay_Init
	pop de
	call GetCardCountInCollection
	ld b, a
	call GetCardCountInCollectionAndDecks
	ld c, a
	push bc
	ld a, b
	lb bc, 6, 17
	bank1call WriteTwoByteNumberInTxSymbolFormat
	pop bc
	push bc
	ld a, c
	lb bc, 16, 17
	bank1call WriteTwoByteNumberInTxSymbolFormat
	pop bc
	ld a, c
	sub b
	lb bc, 11, 17
	bank1call WriteTwoByteNumberInTxSymbolFormat
	ret

.PreviewReceivedCardScreen:
	ld a, [wScenarioDebugMenuCurCardItem]
	ld e, a
	ld a, [wScenarioDebugMenuCurCardItem + 1]
	ld d, a
	farcall GetReceivedCardText
	farcall _ShowReceivedCardScreen
	call DisableLCD
	call FlushAllPalettes
	call EmptyScreen
	call PrintScenarioDebugMenu
	call .PrintCardCountMenu
	call EnableLCD
	jp .wait_input

DebugModifyCardCountValue:
	ld a, SCENARIODEBUGMENU_VALUE_SELECTOR_CARD_COUNT
	call RefreshScenarioDebugMenuCursor
	call .PrintCardCountValue

.wait_input
	call DoFrame
	call DrawScenarioDebugMenuCursor
	ldh a, [hKeysHeld]
	bit B_PAD_UP, a
	jr nz, .check_input
	bit B_PAD_DOWN, a
	jr nz, .check_input
	ldh a, [hDPadHeld]
.check_input
	bit B_PAD_B, a
	jr nz, .exit
	bit B_PAD_UP, a
	jr nz, .handle_forward
	bit B_PAD_RIGHT, a
	jr nz, .handle_forward
	bit B_PAD_DOWN, a
	jr nz, .handle_backward
	bit B_PAD_LEFT, a
	jr nz, .handle_backward
	jr .wait_input

.exit
	ret

.handle_forward
	ld a, [wScenarioDebugMenuCurCardItem]
	ld e, a
	ld a, [wScenarioDebugMenuCurCardItem + 1]
	ld d, a
	call AddCardToCollection
	call .PrintCardCountValue
	jr .wait_input

.handle_backward
	ld a, [wScenarioDebugMenuCurCardItem]
	ld e, a
	ld a, [wScenarioDebugMenuCurCardItem + 1]
	ld d, a
	call RemoveCardFromCollection
	call .PrintCardCountValue
	jr .wait_input

.PrintCardCountValue:
	call GetCardCountInCollection
	ld b, a
	call GetCardCountInCollectionAndDecks
	ld c, a
	push bc
	ld a, b
	lb bc, 6, 17
	bank1call WriteTwoByteNumberInTxSymbolFormat
	pop bc
	push bc
	ld a, c
	lb bc, 16, 17
	bank1call WriteTwoByteNumberInTxSymbolFormat
	pop bc
	ld a, c
	sub b
	lb bc, 11, 17
	bank1call WriteTwoByteNumberInTxSymbolFormat
	ret

; unreferenced
ClearScenarioDebugMenuValueSelector_SingleRow:
	lb de, 0, 15
	ldtx hl, DebugBlankValueSelectorText
	call PrintTextNoDelay_Init
	ret

; fill three rows with spaces
ClearScenarioDebugMenuValueSelector:
FOR y, 15, 18
	lb de, 0, y
	ldtx hl, DebugBlankValueSelectorText
	call PrintTextNoDelay_Init
ENDR
	ret

DrawScenarioDebugMenuCursor:
	ld a, [wScenarioDebugMenuCursorPosition]
	ld hl, ScenarioDebugMenuCursorCoordinates
	sla a
	add_hl_a
	ld a, [hli]
	ld b, a
	ld c, [hl]
	ld a, [wScenarioDebugMenu_d67a]
	inc a
	cp $20
	jr nz, .ok
	xor a
.ok
	ld [wScenarioDebugMenu_d67a], a
	cp $10
	jr nc, .erase_cursor
	ld a, SYM_CURSOR_R
	jr .draw
.erase_cursor
	ld a, SYM_SPACE
.draw
	call WriteByteToBGMap0
	ret

; a = new cursor pos
RefreshScenarioDebugMenuCursor:
	push af
	ld a, [wScenarioDebugMenuCursorPosition]
	ld hl, ScenarioDebugMenuCursorCoordinates
	push hl
	sla a
	add_hl_a
	ld a, [hli]
	ld b, a
	ld c, [hl]
	ld a, SYM_SPACE
	call WriteByteToBGMap0
	pop hl
	pop af
	ld [wScenarioDebugMenuCursorPosition], a
	sla a
	add_hl_a
	ld a, [hli]
	ld b, a
	ld c, [hl]
	ld a, SYM_CURSOR_R
	call WriteByteToBGMap0
	ret

ScenarioDebugMenuCursorCoordinates:
	; x, y
	db  2,  4 ; SCENARIODEBUGMENU_MODIFY_EVENTS
	db  2,  6 ; SCENARIODEBUGMENU_MODIFY_FLAGS
	db  2,  8 ; SCENARIODEBUGMENU_MODIFY_COUNTERS
	db  2, 10 ; SCENARIODEBUGMENU_MODIFY_CARD_COUNT
	db  2, 12 ; SCENARIODEBUGMENU_MODIFY_EXIT
	db  2, 15 ; SCENARIODEBUGMENU_VALUE_SELECTOR
	db 16, 15 ; SCENARIODEBUGMENU_VALUE_SELECTOR_COUNTER
	db  3, 17 ; SCENARIODEBUGMENU_VALUE_SELECTOR_CARD_COUNT

; unreferenced
Data_44eb6:
	db $44, $42, $47, $44, $45, $55, $41, $44, $a8, $49

MACRO debug_event
	tx \1 ; text
	dw \2 ; func
ENDM

DebugModifyEventsMenuItems:
	debug_event DebugBeatTheGameText,               .BeatGame
	debug_event DebugSwapPlayerGenderText,          .SwapPlayerGender
	debug_event DebugGoToTCGIslandText,             .GoToTCGIsland
	debug_event DebugGoToGRIslandText,              .GoToGRIsland
	debug_event DebugGetAllCoinsText,               .GetAllCoins
	debug_event DebugDeliverAllMailText,            .DeliverAllMail
	debug_event DebugResetChallengeMachineDataText, .ResetChallengeMachine
	debug_event DebugUnlockSealedFortText,          .UnlockSealedFort
	debug_event DebugHoldGrandMasterCupText,        .HoldGrandMasterCup
	debug_event DebugGet10CardsEachText,            .Get10CardsEach
	debug_event DebugGet10EnergyCardsEachText,      .Get10EnergyCardsEach

.BeatGame:
	call EnableSRAM
	ld a, TRUE
	ld [sClearedGame], a
	call DisableSRAM
	ld a, EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE
	farcall MaxOutEventValue
	ld a, EVENT_GOT_CHANSEY_COIN
	farcall MaxOutEventValue
	ld a, EVENT_GOT_ODDISH_COIN
	farcall MaxOutEventValue
	ld a, EVENT_GOT_CHARMANDER_COIN
	farcall MaxOutEventValue
	ld a, EVENT_GOT_STARMIE_COIN
	farcall MaxOutEventValue
	ld a, EVENT_GOT_PIKACHU_COIN
	farcall MaxOutEventValue
	ld a, EVENT_GOT_ALAKAZAM_COIN
	farcall MaxOutEventValue
	ld a, EVENT_GOT_KABUTO_COIN
	farcall MaxOutEventValue
	ld a, EVENT_GOT_GR_COIN
	farcall MaxOutEventValue
	ld a, EVENT_GOT_GOLBAT_COIN
	farcall MaxOutEventValue
	ld a, EVENT_GOT_MAGNEMITE_COIN
	farcall MaxOutEventValue
	ld a, EVENT_GOT_MAGMAR_COIN
	farcall MaxOutEventValue
	ld a, EVENT_GOT_PSYDUCK_COIN
	farcall MaxOutEventValue
	ld a, EVENT_GOT_MACHAMP_COIN
	farcall MaxOutEventValue
	ld a, EVENT_GOT_MEW_COIN
	farcall MaxOutEventValue
	ld a, EVENT_GOT_SNORLAX_COIN
	farcall MaxOutEventValue
	ld a, EVENT_GOT_TOGEPI_COIN
	farcall MaxOutEventValue
	ld a, EVENT_TALKED_TO_MITCH
	farcall ZeroOutEventValue
	ld a, EVENT_TALKED_TO_AMY
	farcall ZeroOutEventValue
	ld a, EVENT_TALKED_TO_KEN
	farcall ZeroOutEventValue
	ld a, EVENT_TALKED_TO_MURRAY
	farcall ZeroOutEventValue
	ld a, EVENT_TALKED_TO_MORINO
	farcall ZeroOutEventValue
	ld a, EVENT_TALKED_TO_HIDERO
	farcall ZeroOutEventValue
	ld a, EVENT_TALKED_TO_KANZAKI
	farcall ZeroOutEventValue
	ld a, EVENT_TALKED_TO_ISHIHARA
	farcall ZeroOutEventValue
	ld a, EVENT_TALKED_TO_COURTNEY_POKEMON_DOME
	farcall ZeroOutEventValue
	ld a, EVENT_TALKED_TO_STEVE_POKEMON_DOME
	farcall ZeroOutEventValue
	ld a, EVENT_TALKED_TO_JACK_POKEMON_DOME
	farcall ZeroOutEventValue
	ld a, EVENT_ENTERED_GRAND_MASTER_CUP
	farcall ZeroOutEventValue
	ld a, VAR_0B
	ld c, $01
	farcall SetVarValue
	ld a, VAR_27
	ld c, $09
	farcall SetVarValue
	ld a, VAR_ISHIHARA_STATE
	ld c, ISHIHARA_HELPED_NIKKI
	farcall SetVarValue
	ld a, VAR_03
	ld c, $03
	farcall SetVarValue
	ld a, VAR_TIMES_MET_RONALD
	ld c, 9
	farcall SetVarValue
	ld a, VAR_TCG_CHALLENGE_CUP_STATE
	ld c, CHALLENGE_CUP_3_UNLOCKED
	farcall SetVarValue
	ld a, VAR_GR_CHALLENGE_CUP_STATE
	ld c, CHALLENGE_CUP_3_UNLOCKED
	farcall SetVarValue
	ld a, EVENT_YUTAS_ROOM_DOOR_STATE
	farcall MaxOutEventValue
	ld a, EVENT_MIYUKIS_ROOM_DOOR_STATE
	farcall MaxOutEventValue
	ld a, EVENT_BEAT_MORINO
	farcall MaxOutEventValue
	ld a, EVENT_RENNAS_ROOM_DOOR_STATE
	farcall MaxOutEventValue
	ld a, EVENT_ICHIKAWAS_ROOM_DOOR_STATE
	farcall MaxOutEventValue
	ld a, EVENT_BEAT_CATHERINE
	farcall MaxOutEventValue
	ld a, EVENT_JES_ROOM_DOOR_STATE
	farcall MaxOutEventValue
	ld a, EVENT_YUKIS_ROOM_DOOR_STATE
	farcall MaxOutEventValue
	ld a, EVENT_SHOKOS_ROOM_DOOR_STATE
	farcall MaxOutEventValue
	ld a, EVENT_BEAT_HIDERO
	farcall MaxOutEventValue
	ld a, EVENT_MIYAJIMAS_ROOM_DOOR_STATE
	farcall MaxOutEventValue
	ld a, EVENT_SENTAS_ROOM_BRIDGE_STATE
	farcall MaxOutEventValue
	ld a, EVENT_AIRAS_ROOM_BRIDGE_STATE
	farcall MaxOutEventValue
	ld a, EVENT_BEAT_KANOKO
	farcall MaxOutEventValue
	ld a, EVENT_BEAT_KAMIYA
	farcall MaxOutEventValue
	ld a, EVENT_FREED_MITCH
	farcall MaxOutEventValue
	ld a, EVENT_GRACES_ROOM_CHEST_STATE
	farcall MaxOutEventValue
	ld a, EVENT_BEAT_MIWA
	farcall MaxOutEventValue
	ld a, EVENT_BEAT_KEVIN
	farcall MaxOutEventValue
	ld a, EVENT_BEAT_YOSUKE
	farcall MaxOutEventValue
	ld a, EVENT_BEAT_RYOKO
	farcall MaxOutEventValue
	ld a, EVENT_BEAT_MAMI
	farcall MaxOutEventValue
	ld a, EVENT_BEAT_NISHIJIMA
	farcall MaxOutEventValue
	ld a, EVENT_BEAT_ISHII
	farcall MaxOutEventValue
	ld a, EVENT_BEAT_SAMEJIMA
	farcall MaxOutEventValue
	ld a, EVENT_BEAT_KANZAKI
	farcall MaxOutEventValue
	ld a, EVENT_BEAT_RUI
	farcall MaxOutEventValue
	ld a, EVENT_MET_GR1_ROCK_CLUB
	farcall MaxOutEventValue
	ld a, EVENT_MET_GR4_LIGHTNING_CLUB
	farcall MaxOutEventValue
	ld a, EVENT_MET_GR4_PSYCHIC_CLUB
	farcall MaxOutEventValue
	ld a, EVENT_MET_YUKI_FIRE_FORT
	farcall MaxOutEventValue
	ld a, EVENT_MET_FIGHTING_FORT_MEMBERS
	farcall MaxOutEventValue
	ld a, EVENT_MET_PSYCHIC_STRONGHOLD_MEMBERS
	farcall MaxOutEventValue
	ld a, EVENT_MET_MAMI_AND_ROD
	farcall MaxOutEventValue
	ld a, EVENT_MET_COLORLESS_ALTAR_MEMBERS
	farcall MaxOutEventValue
	ld a, EVENT_MET_BIRURITCHI_AND_ADMINS
	farcall MaxOutEventValue
	ld a, EVENT_GR_CASTLE_STAIRS_RUI_ROADBLOCK
	farcall MaxOutEventValue
	ld a, EVENT_MET_RONALD_GAME_CENTER
	farcall MaxOutEventValue
	ld a, EVENT_GODAS_ROOM_CAGE_STATE
	farcall MaxOutEventValue
	ld a, EVENT_MIDORIS_ROOM_CAGE_STATE
	farcall MaxOutEventValue
	ld a, EVENT_FREED_STEVE
	farcall MaxOutEventValue
	ld a, EVENT_FREED_COURTNEY
	farcall MaxOutEventValue
	ld a, EVENT_FREED_JACK
	farcall MaxOutEventValue
	ld a, EVENT_FREED_ROD
	farcall MaxOutEventValue
	ld a, EVENT_LIGHTNING_FORT_ENTRANCE_DOOR_STATE
	farcall MaxOutEventValue
	ld a, EVENT_FIRE_FORT_ENTRANCE_DOOR_STATE
	farcall MaxOutEventValue
	ld a, EVENT_WATER_FORT_ENTRANCE_DOOR_STATE
	farcall MaxOutEventValue
	ld a, EVENT_FIGHTING_FORT_ENTRANCE_DOOR_STATE
	farcall MaxOutEventValue
	ld a, EVENT_CAN_TRAVEL_PAST_FIGHTING_FORT
	farcall MaxOutEventValue
	ld a, EVENT_GR_CASTLE_ENTRANCE_DOOR_STATE
	farcall MaxOutEventValue
	ld a, EVENT_SHORT_GR_ISLAND_FLYOVER_SEQUENCE
	farcall MaxOutEventValue
	ret

.SwapPlayerGender:
	ld a, EVENT_PLAYER_GENDER
	farcall GetEventValue
	jr z, .to_female
	ld a, EVENT_PLAYER_GENDER
	farcall ZeroOutEventValue
	ld a, NPC_MARK
	ld [wPlayerOWObject], a
	call EnableSRAM
	ld a, PLAYER_MALE
	ld [sPlayerName + $d], a
	call DisableSRAM
	ret
.to_female
	ld a, EVENT_PLAYER_GENDER
	farcall MaxOutEventValue
	ld a, NPC_MINT
	ld [wPlayerOWObject], a
	call EnableSRAM
	ld a, PLAYER_FEMALE
	ld [sPlayerName + $d], a
	call DisableSRAM
	ret

.GoToTCGIsland:
	ld a, TCG_ISLAND
	ld [wCurIsland], a
	ld a, OWMAP_TCG_AIRPORT
	ld [wCurOWLocation], a
	ld a, MAP_TCG_AIRPORT_ENTRANCE
	ld [wCurMap], a
	ld a, 5
	ld [wNextWarpPlayerXCoord], a
	ld a, 7
	ld [wNextWarpPlayerYCoord], a
	ld a, SOUTH
	ld [wNextWarpPlayerDirection], a
	ld a, OVERWORLD_MAP_TCG
	farcall LoadMapHeader
	ret

.GoToGRIsland:
	ld a, GR_ISLAND
	ld [wCurIsland], a
	ld a, OWMAP_GR_AIRPORT
	ld [wCurOWLocation], a
	ld a, MAP_GR_AIRPORT_ENTRANCE
	ld [wCurMap], a
	ld a, 4
	ld [wNextWarpPlayerXCoord], a
	ld a, 4
	ld [wNextWarpPlayerYCoord], a
	ld a, SOUTH
	ld [wNextWarpPlayerDirection], a
	ld a, OVERWORLD_MAP_GR
	farcall LoadMapHeader
	ret

.GetAllCoins:
	ld a, EVENT_GOT_CHANSEY_COIN
	farcall MaxOutEventValue
	ld a, EVENT_GOT_ODDISH_COIN
	farcall MaxOutEventValue
	ld a, EVENT_GOT_CHARMANDER_COIN
	farcall MaxOutEventValue
	ld a, EVENT_GOT_STARMIE_COIN
	farcall MaxOutEventValue
	ld a, EVENT_GOT_PIKACHU_COIN
	farcall MaxOutEventValue
	ld a, EVENT_GOT_ALAKAZAM_COIN
	farcall MaxOutEventValue
	ld a, EVENT_GOT_KABUTO_COIN
	farcall MaxOutEventValue
	ld a, EVENT_GOT_GR_COIN
	farcall MaxOutEventValue
	ld a, EVENT_GOT_GR_COIN_PIECE_TOP_LEFT
	farcall MaxOutEventValue
	ld a, EVENT_GOT_GR_COIN_PIECE_TOP_RIGHT
	farcall MaxOutEventValue
	ld a, EVENT_GOT_GR_COIN_PIECE_BOTTOM_LEFT
	farcall MaxOutEventValue
	ld a, EVENT_GOT_GR_COIN_PIECE_BOTTOM_RIGHT
	farcall MaxOutEventValue
	ld a, EVENT_GOT_GOLBAT_COIN
	farcall MaxOutEventValue
	ld a, EVENT_GOT_MAGNEMITE_COIN
	farcall MaxOutEventValue
	ld a, EVENT_GOT_MAGMAR_COIN
	farcall MaxOutEventValue
	ld a, EVENT_GOT_PSYDUCK_COIN
	farcall MaxOutEventValue
	ld a, EVENT_GOT_MACHAMP_COIN
	farcall MaxOutEventValue
	ld a, EVENT_GOT_MEW_COIN
	farcall MaxOutEventValue
	ld a, EVENT_GOT_SNORLAX_COIN
	farcall MaxOutEventValue
	ld a, EVENT_GOT_TOGEPI_COIN
	farcall MaxOutEventValue
	ld a, EVENT_GOT_PONYTA_COIN
	farcall MaxOutEventValue
	ld a, EVENT_GOT_HORSEA_COIN
	farcall MaxOutEventValue
	ld a, EVENT_GOT_ARBOK_COIN
	farcall MaxOutEventValue
	ld a, EVENT_GOT_JIGGLYPUFF_COIN
	farcall MaxOutEventValue
	ld a, EVENT_GOT_DUGTRIO_COIN
	farcall MaxOutEventValue
	ld a, EVENT_GOT_GENGAR_COIN
	farcall MaxOutEventValue
	ld a, EVENT_GOT_RAICHU_COIN
	farcall MaxOutEventValue
	ld a, EVENT_GOT_LUGIA_COIN
	farcall MaxOutEventValue
	ret

.DeliverAllMail:
	xor a
	start_script
	send_mail $03
	send_mail $04
	send_mail $05
	send_mail $06
	send_mail $07
	send_mail $08
	send_mail $09
	send_mail $0a
	send_mail $0b
	send_mail $0c
	send_mail $0d
	send_mail $0e
	send_mail $0f
	send_mail $10
	send_mail $11
	send_mail $12
	send_mail $13
	send_mail $14
	send_mail $15
	send_mail $16
	send_mail $17
	send_mail $18
	send_mail $19
	send_mail $1a
	send_mail $1b
	send_mail $1c
	end_script
	ret

.ResetChallengeMachine:
	farcall InitChallengeMachineChecksums
	ret

.UnlockSealedFort:
	ld a, EVENT_SEALED_FORT_DOOR_STATE
	farcall MaxOutEventValue
	ret

.HoldGrandMasterCup:
	ld a, EVENT_MASONS_LAB_CHALLENGE_MACHINE_STATE
	farcall GetEventValue
	ret z
	ld a, VAR_GRAND_MASTER_CUP_STATE
	ld c, GRAND_MASTER_CUP_ACTIVE
	farcall SetVarValue
	ld a, VAR_TIMES_WON_LINK_DUEL_FOR_GRAND_MASTER_CUP
	ld c, MAX_NUM_LINK_DUEL_WINS_FOR_GRAND_MASTER_CUP
	farcall SetVarValue
	ret

.Get10CardsEach:
	bank1call CreateTempCardCollection
	ld de, GRASS_ENERGY
	call EnableSRAM
.loop_cards
	ld c, 10
.loop_give_card
	ld hl, wTempCardCollection
	add hl, de
	ld a, [hl]
	and CARD_COUNT_MASK
	cp MAX_AMOUNT_OF_CARD
	jr nc, .next_card
	inc a
	ld [hl], a
	ld hl, sCardCollection
	add hl, de
	ld a, [hl]
	and CARD_COUNT_MASK
	inc a
	ld [hl], a
	dec c
	jr nz, .loop_give_card
.next_card
	cp16_long NUM_CARDS
	inc de
	jr nz, .loop_cards
	call DisableSRAM
	ret

.Get10EnergyCardsEach:
	bank1call CreateTempCardCollection
	ld de, GRASS_ENERGY
	call EnableSRAM
.loop_energy_cards
	ld c, 10
.loop_give_energy_card
	ld hl, wTempCardCollection
	add hl, de
	ld a, [hl]
	and CARD_COUNT_MASK
	cp MAX_AMOUNT_OF_CARD
	jr nc, .next_energy_card
	inc a
	ld [hl], a
	ld hl, sCardCollection
	add hl, de
	ld a, [hl]
	and CARD_COUNT_MASK
	inc a
	ld [hl], a
	dec c
	jr nz, .loop_give_energy_card
.next_energy_card
	cp16_long DOUBLE_COLORLESS_ENERGY
	inc de
	jr nz, .loop_energy_cards
	call DisableSRAM
	ret
