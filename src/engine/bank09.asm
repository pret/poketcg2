; save data of the current duel to sCurrentDuel
; byte 0 is $01, bytes 1 and 2 are the checksum, byte 3 is [wDuelType]
; next $33a bytes come from DuelDataToSave
SaveDuelData::
	ld de, sCurrentDuel
;	fallthrough

; save data of the current duel to de (in SRAM)
; byte 0 is $01, bytes 1 and 2 are the checksum, byte 3 is [wDuelType]
; next $33a bytes come from DuelDataToSave
SaveDuelDataToDE::
	call EnableSRAM
	push de
	inc de
	inc de
	inc de
	inc de
	ld hl, DuelDataToSave
	push de
.save_duel_data_loop
	; start copying data to de = sCurrentDuelData + $1
	ld c, [hl]
	inc hl
	ld b, [hl]
	inc hl
	ld a, c
	or b
	jr z, .data_done
	push hl
	push bc
	ld c, [hl]
	inc hl
	ld b, [hl]
	inc hl
	pop hl
	call CopyDataHLtoDE
	pop hl
	inc hl
	inc hl
	jr .save_duel_data_loop
.data_done
	pop hl
	; save a checksum to hl = sCurrentDuelData + $1
	lb de, $23, $45
	ld bc, $352
.checksum_loop
	ld a, e
	sub [hl]
	ld e, a
	ld a, [hli]
	xor d
	ld d, a
	dec bc
	ld a, c
	or b
	jr nz, .checksum_loop
	pop hl
	ld a, $01
	ld [hli], a ; sCurrentDuel
	ld [hl], e ; sCurrentDuelChecksum
	inc hl
	ld [hl], d ; sCurrentDuelChecksum
	inc hl
	ld a, [wDuelType]
	ld [hl], a ; sCurrentDuelData
	call DisableSRAM
	ret

Func_24048:
	ld hl, sCurrentDuel
	call CheckSavedDuelChecksum_FromHL
	ret c
	ld de, sCurrentDuel
	call LoadSavedDuelData
	or a
	ret

; load the data saved in sCurrentDuelData to WRAM according to the distribution
; of DuelDataToSave. assumes saved data exists and that the checksum is valid.
LoadSavedDuelData:
	call EnableSRAM
	inc de
	inc de
	inc de
	inc de
	ld hl, DuelDataToSave
.loop
	ld c, [hl]
	inc hl
	ld b, [hl]
	inc hl
	ld a, c
	or b
	jr z, .done
	push hl
	push bc
	ld c, [hl]
	inc hl
	ld b, [hl]
	inc hl
	pop hl
.loop_copy
	ld a, [de]
	inc de
	ld [hli], a
	dec bc
	ld a, c
	or b
	jr nz, .loop_copy
	pop hl
	inc hl
	inc hl
	jr .loop
.done
	call DisableSRAM
	bank1call Func_6838
	ret

DuelDataToSave:
;	dw address, number of bytes to copy
	dw STARTOF("WRAM0 Duels 1"), wNameBuffer + NAME_BUFFER_LENGTH - STARTOF("WRAM0 Duels 1")
	dw wWhoseTurn, $24
	dw hWhoseTurn, $1
	dw wRNG1, $3
	dw $d023, $20
	dw NULL

; return carry if saved duel checksum
; in SRAM is not valid
CheckSavedDuelChecksum:
	call EnableSRAM
	ld hl, sCurrentDuel
	ld a, [sCurrentDuelChecksum + $2]
	call DisableSRAM
	cp $01
	jr nz, CheckSavedDuelChecksum_FromHL
	scf
	ret

CheckSavedDuelChecksum_FromHL:
	call EnableSRAM
	push de
	ld a, [hli] ; sCurrentDuel
	or a
	jr z, .set_carry
	lb de, $23, $45
	ld bc, $352
	ld a, [hl] ; sCurrentDuelChecksum
	sub e
	ld e, a
	inc hl
	ld a, [hl]
	xor d
	ld d, a
	inc hl
	inc hl
	; hl = sCurrentDuelData
.loop_data
	ld a, [hl]
	add e
	ld e, a
	ld a, [hli]
	xor d
	ld d, a
	dec bc
	ld a, c
	or b
	jr nz, .loop_data
	ld a, e
	or d
	jr z, .no_carry
.set_carry
	scf
.no_carry
	call DisableSRAM
	pop de
	ret

ClearSavedDuel:
	call EnableSRAM
	ld hl, sCurrentDuel
	xor a
	ld [hli], a
	ld [hli], a
	ld [hl], a
	call DisableSRAM
	ret

; save duel state to SRAM
; called between each two-player turn, just after player draws card (ROM bank 1 loaded)
SaveDuelStateToSRAM:
	ld a, $2
	call BankswitchSRAM
	; save duel data to sCurrentDuel
	call SaveDuelData
	xor a
	call BankswitchSRAM
	call EnableSRAM
	ld hl, s0a008
	ld a, [hl]
	inc [hl]
	call DisableSRAM
	; select hl = SRAM3:(a000 + $400 * [s0a008] & $3)
	; save wDuelTurns, non-turn holder's arena card ID, turn holder's arena card ID
	and $3
	add HIGH($a000) / 4
	ld l, $0
	ld h, a
	add hl, hl
	add hl, hl
	ld a, $3
	call BankswitchSRAM
	push hl
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call GetCardIDFromDeckIndex
	ld hl, wTempTurnDuelistCardID
	ld [hl], e
	inc hl
	ld [hl], d
	call SwapTurn
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call GetCardIDFromDeckIndex
	ld hl, wTempNonTurnDuelistCardID
	ld [hl], e
	inc hl
	ld [hl], d
	call SwapTurn
	pop hl
	push hl
	call EnableSRAM
	ld a, [wDuelTurns]
	ld [hli], a
	ld a, [wTempNonTurnDuelistCardID]
	ld [hli], a
	ld a, [wTempNonTurnDuelistCardID + 1]
	ld [hli], a
	ld a, [wTempTurnDuelistCardID]
	ld [hli], a
	ld a, [wTempTurnDuelistCardID + 1]
	ld [hli], a
	; save duel data to SRAM3:(a000 + $400 * [s0a008] & $3) + $10
	pop hl
	ld de, $10
	add hl, de
	ld e, l
	ld d, h
	call DisableSRAM
	call SaveDuelDataToDE
	xor a
	call BankswitchSRAM
	call DisableSRAM
	ret

; display the card details of the card in wLoadedCard1
; print the text at hl
_DisplayCardDetailScreen:
	push hl
	call DrawLargePictureOfCard
	ld a, 18
	call CopyCardNameAndLevel
	ld [hl], TX_END
	ld hl, 0
	call LoadTxRam2
	pop hl
	call DrawWideTextBox_WaitForInput
	ret

; draw a large picture of the card loaded in wLoadedCard1, including its image
; and a header indicating the type of card (TRAINER, ENERGY, PoKéMoN)
DrawLargePictureOfCard:
	bank1call ZeroObjectPositionsAndToggleOAMCopy
	call EmptyScreen
	call LoadSymbolsFont
	bank1call SetDefaultPalettes
	ld a, LARGE_CARD_PICTURE
	ld [wDuelDisplayedScreen], a
	call LoadCardOrDuelMenuBorderTiles
	ld e, HEADER_TRAINER
	ld a, [wLoadedCard1Type]
	cp TYPE_TRAINER
	jr z, .draw
	ld e, HEADER_ENERGY
	and TYPE_ENERGY
	jr nz, .draw
	ld e, HEADER_POKEMON
.draw
	push de
	ld a, e
	call LoadCardTypeHeaderTiles
	pop de
	ld d, $00
	ld hl, .CardTypeTileAttributes
	add hl, de
	ld a, [hl]
	lb de, 6, 1
	lb bc, 8, 2
	lb hl, 0, 0
	call BankswitchVRAM1
	call FillRectangle
	call BankswitchVRAM0
	ld de, v0Tiles1 + $200
	bank1call LoadLoadedCard1Gfx
	lb de, 6, 3
	bank1call DrawCardGfxToDE_BGPalIndex5
	bank1call FlushAllPalettesIfNotDMG
	ld hl, .TileData
	call WriteDataBlocksToBGMap0
	ret

.CardTypeTileAttributes:
	db $04 ; Trainer
	db $03 ; Energy
	db $02 ; Pkmn

.TileData:
	db  5,  0, $d0, $d4, $d4, $d4, $d4, $d4, $d4, $d4, $d4, $d1, 0
	db  5,  1, $d6, $e0, $e1, $e2, $e3, $e4, $e5, $e6, $e7, $d7, 0
	db  5,  2, $d6, $e8, $e9, $ea, $eb, $ec, $ed, $ee, $ef, $d7, 0
	db  5,  3, $d6, $a0, $a6, $ac, $b2, $b8, $be, $c4, $ca, $d7, 0
	db  5,  4, $d6, $a1, $a7, $ad, $b3, $b9, $bf, $c5, $cb, $d7, 0
	db  5,  5, $d6, $a2, $a8, $ae, $b4, $ba, $c0, $c6, $cc, $d7, 0
	db  5,  6, $d6, $a3, $a9, $af, $b5, $bb, $c1, $c7, $cd, $d7, 0
	db  5,  7, $d6, $a4, $aa, $b0, $b6, $bc, $c2, $c8, $ce, $d7, 0
	db  5,  8, $d6, $a5, $ab, $b1, $b7, $bd, $c3, $c9, $cf, $d7, 0
	db  5,  9, $d6, 0
	db 14,  9, $d7, 0
	db  5, 10, $d6, 0
	db 14, 10, $d7, 0
	db  5, 11, $d2, $d5, $d5, $d5, $d5, $d5, $d5, $d5, $d5, $d3, 0
	db $ff ; end

DrawDuelHorizontalSeparator:
	ld hl, .LineSeparatorTileData
	call WriteDataBlocksToBGMap0
	ld a, [wConsole]
	cp CONSOLE_CGB
	ret nz
	call BankswitchVRAM1
	ld hl, .LineSeparatorAttributeData
	call WriteDataBlocksToBGMap0
	call BankswitchVRAM0
	ret

.LineSeparatorTileData:
	db 0, 4, $34, $34, $34, $34, $34, $34, $34, $34, $34, $31, $32, 0
	db 9, 5, $33, $33, 0
	db 9, 6, $33, $33, 0
	db 9, 7, $32, $31, $34, $34, $34, $34, $34, $34, $34, $34, $34, 0
	db $ff ; end

.LineSeparatorAttributeData:
	db 0, 4, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, 0
	db 9, 5, $01, $21, 0
	db 9, 6, $01, $21, 0
	db 9, 7, $61, $61, $01, $01, $01, $01, $01, $01, $01, $01, $01, 0
	db $ff ; end

; handles menu for when player is waiting for
; Link Opponent to make a decision, where it's
; possible to examine the hand or duel main scene
HandleWaitingLinkOpponentMenu:
	ld a, 10
.delay_loop
	call DoFrame
	dec a
	jr nz, .delay_loop
	ld [wCurrentDuelMenuItem], a ; 0
.loop_outer
	ld a, PLAYER_TURN
	ldh [hWhoseTurn], a
	ldtx hl, Text005a ; WaitingHandExamineText
	call DrawWideTextBox_PrintTextNoDelay
	call .InitTextBoxMenu
.loop_inner
	call DoFrame
	call .HandleInput
	call RefreshMenuCursor
	ldh a, [hKeysPressed]
	bit A_BUTTON_F, a
	jr nz, .a_pressed
	ld a, $01
	bank1call HandleSpecialDuelMainSceneHotkeys
	jr nc, .loop_inner
.duel_main_scene
	bank1call DrawDuelMainScene
	jr .loop_outer
.a_pressed
	ld a, [wCurrentDuelMenuItem]
	or a
	jr z, .open_hand
; duel check
	call OpenDuelCheckMenu
	jr .duel_main_scene
.open_hand
	bank1call OpenTurnHolderHandScreen_Simple
	jr .duel_main_scene

.HandleInput:
	ldh a, [hDPadHeld]
	bit B_BUTTON_F, a
	ret nz
	and D_LEFT | D_RIGHT
	ret z
	ld a, SFX_01
	call PlaySFX
	call EraseCursor
	ld hl, wCurrentDuelMenuItem
	ld a, [hl]
	xor $01
	ld [hl], a

.InitTextBoxMenu:
	ld d, 2
	ld a, [wCurrentDuelMenuItem]
	or a
	jr z, .set_cursor_params
	ld d, 8
.set_cursor_params
	ld e, 16
	lb bc, SYM_CURSOR_R, SYM_SPACE
	call SetCursorParametersForTextBox
	ret

SetLinkDuelTransmissionFrameFunction:
	call FinishQueuedAnimations
	ld hl, sp+$00
	ld a, l
	ld [wLinkOpponentTurnReturnAddress], a
	ld a, h
	ld [wLinkOpponentTurnReturnAddress + 1], a
	ld de, LinkOpponentTurnFrameFunction
	ld hl, wDoFrameFunction
	ld [hl], e
	inc hl
	ld [hl], d
	ret

ResetDoFrameFunction_Bank9:
	xor a
	ld hl, wDoFrameFunction
	ld [hli], a
	ld [hl], a
	ret
; 0x24350

SECTION "Bank 9@43ee", ROMX[$43ee], BANK[$9]

Func_243ee:
	push de
	push hl
	dec e
	lb bc, 18, 7
	lb hl,  0, 0
	ld a, $00
	call FillRectangle
	pop hl
	pop de
	bank1call PrintAttackOrCardDescription
	ret

; display the screen that prompts the player to use the selected card's
; Pokemon Power. Includes the card's information above, and the Pokemon Power's
; description below.
; input: hTempPlayAreaLocation_ff9d
DisplayUsePokemonPowerScreen:
	push hl
	ldh a, [hTempPlayAreaLocation_ff9d]
	ld [wCurPlayAreaSlot], a
	xor a
	ld [wCurPlayAreaY], a
	bank1call ZeroObjectPositionsAndToggleOAMCopy
	call EmptyScreen
	call LoadDuelCardSymbolTiles
	call LoadDuelCheckPokemonScreenTiles
	bank1call Func_6c12
	pop hl
	call Func_24494
	bank1call PrintPlayAreaCardInformationAndLocation
	lb de, 1, 4
	call InitTextPrinting
	ld hl, wLoadedCard1Atk1Name
	call InitTextPrinting_ProcessTextFromPointerToID
	lb de, 1, 6
	ld hl, wLoadedCard1Atk1Description
	bank1call PrintAttackOrCardDescription
	ld hl, wLoadedCard1Atk1Description + $2
	ld a, [hli]
	or [hl]
	ret z ; no second page
	; print second page info
	call WaitForWideTextBoxInput
	bank1call PrintPlayAreaCardInformationAndLocation
	lb de, 1, 4
	call InitTextPrinting
	ld hl, wLoadedCard1Atk1Name
	call InitTextPrinting_ProcessTextFromPointerToID
	ld hl, wLoadedCard1Atk1Description + $2
	lb de, 1, 6
	call Func_243ee
	ret
; 0x24459

SECTION "Bank 9@4494", ROMX[$4494], BANK[$9]

Func_24494:
	push hl
	call DrawWideTextBox
	ld a, 19
	lb de, 1, 14
	call AdjustCoordinatesForBGScroll
	call InitTextPrintingInTextbox
	pop hl
	jp PrintTextNoDelay

; display card detail when a trainer card is used, and print "Used xxx"
; hTempCardIndex_ff9f contains the card's deck index
DisplayUsedTrainerCardDetailScreen:
	ldh a, [hTempCardIndex_ff9f]
	ldtx hl, Text0034 ; UsedText
	bank1call DisplayCardDetailScreen
	ret

SECTION "Bank 9@44b0", ROMX[$44b0], BANK[$9]

; print the AttachedEnergyToPokemonText, given the energy card to attach in hTempCardIndex_ff98,
; and the PLAY_AREA_* of the turn holder's Pokemon to attach the energy to in hTempPlayAreaLocation_ff9d
PrintAttachedEnergyToPokemon:
	ldh a, [hTempPlayAreaLocation_ff9d]
	add DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call LoadCardNameToTxRam2_b
	ldh a, [hTempCardIndex_ff98]
	call LoadCardNameToTxRam2
	ldtx hl, Text0061 ; AttachedEnergyToPokemonText
	call DrawWideTextBox_WaitForInput
	ret

; print the PokemonEvolvedIntoPokemonText, given the Pokemon card to evolve in wPreEvolutionPokemonCard,
; and the evolved Pokemon card in hTempCardIndex_ff98. also play a sound effect.
PrintPokemonEvolvedIntoPokemon:
	ld a, SFX_5E
	call PlaySFX
	ld a, [wPreEvolutionPokemonCard]
	call LoadCardNameToTxRam2
	ldh a, [hTempCardIndex_ff98]
	call LoadCardNameToTxRam2_b
	ldtx hl, Text0062 ; AttachedEnergyToPokemonText
	call DrawWideTextBox_WaitForInput
	ret

DoAIOpponentTurn:
	xor a
	ld [wVBlankCounter], a
	ld [wSkipDuelistIsThinkingDelay], a
	ldtx hl, Text008d ; DuelistIsThinkingText
	call DrawWideTextBox_PrintTextNoDelay
	call AIDoAction_Turn
	ld a, $ff
	ld [wPlayerAttackingCardIndex], a
	ld [wPlayerAttackingAttackIndex], a
	ret
; 0x244f4

SECTION "Bank 9@4531", ROMX[$4531], BANK[$9]

; handle the opponent's turn in a link duel
; loop until either [wOpponentTurnEnded] or [wDuelFinished] is non-0
DoLinkOpponentTurn:
	xor a
	ld [wOpponentTurnEnded], a
	xor a
	ld [wSkipDuelistIsThinkingDelay], a
.link_opp_turn_loop
	ld a, [wSkipDuelistIsThinkingDelay]
	or a
	jr nz, .asm_6932
	call SetLinkDuelTransmissionFrameFunction
	call HandleWaitingLinkOpponentMenu
	ld a, [wDuelDisplayedScreen]
	cp CHECK_PLAY_AREA
	jr nz, .asm_6932
	lb de, $38, $9f
	call SetupText
.asm_6932
	call ResetDoFrameFunction_Bank9
	call SerialRecvDuelData
	ld a, OPPONENT_TURN
	ldh [hWhoseTurn], a
	ld a, [wSerialFlags]
	or a
	jp nz, DuelTransmissionError
	xor a
	ld [wSkipDuelistIsThinkingDelay], a
	ldh a, [hOppActionTableIndex]
	cp NUM_OPP_ACTIONS
	jp nc, DuelTransmissionError
	ld hl, $457e ; OppActionTable
	call JumpToFunctionInTable
	ld a, [wDuelFinished]
	ld hl, wOpponentTurnEnded
	or [hl]
	jr z, .link_opp_turn_loop
	ret

SECTION "Bank 9@4829", ROMX[$4829], BANK[$9]

; load the text ID of the card name with deck index given in a to TxRam2
; also loads the card to wLoadedCard1
LoadCardNameToTxRam2:
	call LoadCardDataToBuffer1_FromDeckIndex
	ld a, [wLoadedCard1Name]
	ld [wTxRam2], a
	ld a, [wLoadedCard1Name + 1]
	ld [wTxRam2 + 1], a
	ret

; load the text ID of the card name with deck index given in a to TxRam2_b
; also loads the card to wLoadedCard1
LoadCardNameToTxRam2_b:
	call LoadCardDataToBuffer1_FromDeckIndex
	ld a, [wLoadedCard1Name]
	ld [wTxRam2_b], a
	ld a, [wLoadedCard1Name + 1]
	ld [wTxRam2_b + 1], a
	ret

; draw the portraits of the two duelists and print their names.
; also draw an horizontal line separating the two sides.
DrawDuelistPortraitsAndNames:
	ld a, $00
	ld [wcd77], a
	call AIDoAction_06

	call LoadSymbolsFont

	; player's name
	ld de, wDefaultText
	push de
	call CopyPlayerName
	lb de, 0, 11
	call InitTextPrinting
	pop hl
	call ProcessText
	; player's portrait
	lb bc, 0, 5
	call DrawPlayerPortrait

	; opponent's name (aligned to the right)
	ld de, wDefaultText
	push de
	call CopyOpponentName
	pop hl
	call GetTextLengthInTiles
	push hl
	add SCREEN_WIDTH
	ld d, a
	ld e, 0
	call InitTextPrinting
	pop hl
	call ProcessText
	; opponent's portrait
	call DrawOpponentPortrait
	; middle line
	call DrawDuelHorizontalSeparator
	call FlushAllPalettes
	ret

DrawOpponentPortrait:
	ld a, [wcd78]
	ld e, a
	ld a, [wOpponentNPCID]
	lb bc, 13, 1
	call DrawNPCPortrait
	ret

PlayShuffleAndDrawCardsAnimation_TurnDuelist:
	ld b, DUEL_ANIM_PLAYER_SHUFFLE
	ld c, DUEL_ANIM_PLAYER_DRAW
	ldh a, [hWhoseTurn]
	cp PLAYER_TURN
	jr z, .play_anim
	ld b, DUEL_ANIM_OPP_SHUFFLE
	ld c, DUEL_ANIM_OPP_DRAW
.play_anim
	ldtx hl, Text0065 ; ShufflesTheDeckText
	ldtx de, Text0069 ; Drew7CardsText
	jr PlayShuffleAndDrawCardsAnimation

PlayShuffleAndDrawCardsAnimation_BothDuelists:
	ld b, DUEL_ANIM_BOTH_SHUFFLE
	ld c, DUEL_ANIM_BOTH_DRAW
	ldtx hl, Text0067 ; EachPlayerShuffleOpponentsDeckText
	ldtx de, Text0068 ; EachPlayerDraw7CardsText
	ld a, [wcd17]
	or a
	jr z, PlayShuffleAndDrawCardsAnimation
	ldtx hl, Text0066 ; ThisIsJustPracticeDoNotShuffleText
;	fallthrough

; animate the shuffle and drawing screen
; input:
;	b = shuffling animation index
;	c = drawing animation index
;	hl = text to print while shuffling
;	de = text to print while drawing
PlayShuffleAndDrawCardsAnimation:
	push bc
	push de
	push hl
	bank1call ZeroObjectPositionsAndToggleOAMCopy
	call EmptyScreen
	call DrawDuelistPortraitsAndNames
	call LoadDuelDrawCardsScreenTiles
	ld a, SHUFFLE_DECK
	ld [wDuelDisplayedScreen], a
	pop hl
	call DrawWideTextBox_PrintText
	call EnableLCD
	ld a, [wcd17]
	or a
	jr z, .not_practice
	call WaitForWideTextBoxInput
	jr .print_deck_info

.not_practice
; get the shuffling animation from input value of b
	call ResetAnimationQueue
	ld hl, sp+$03
	; play animation 3 times
	ld a, [hl]
	call PlayDuelAnimation
	ld a, [hl]
	call PlayDuelAnimation
	ld a, [hl]
	call PlayDuelAnimation

.loop_shuffle_anim
	call DoFrame
	bank1call CheckSkipDelayAllowed
	jr c, .done_shuffle
	call CheckAnyAnimationPlaying
	jr c, .loop_shuffle_anim
.done_shuffle
	call FinishQueuedAnimations

.print_deck_info
	xor a
	ld [wNumCardsBeingDrawn], a
	call PrintDeckAndHandIconsAndNumberOfCards
	call ResetAnimationQueue
	pop hl
	call DrawWideTextBox_PrintText
.draw_card
; get the draw animation from input value of c
	ld hl, sp+$00
	ld a, [hl]
	call PlayDuelAnimation

.loop_drawing_anim
	call DoFrame
	bank1call CheckSkipDelayAllowed
	jr c, .done_draw
	call CheckAnyAnimationPlaying
	jr c, .loop_drawing_anim

.done_draw
	ld hl, wNumCardsBeingDrawn
	inc [hl]
	ld hl, sp+$00
	ld a, [hl]
	cp DUEL_ANIM_BOTH_DRAW
	jr nz, .one_duelist_shuffled
	; if both duelists shuffled
	call PrintDeckAndHandIconsAndNumberOfCards.not_cgb
	jr .check_num_cards
.one_duelist_shuffled
	call PrintNumberOfHandAndDeckCards

.check_num_cards
	ld a, [wNumCardsBeingDrawn]
	cp 7
	jr c, .draw_card

	ld c, 30
.wait_loop
	call DoFrame
	bank1call CheckSkipDelayAllowed
	jr c, .done
	dec c
	jr nz, .wait_loop

.done
	call FinishQueuedAnimations
	pop bc
	ret

SECTION "Bank 9@49c6", ROMX[$49c6], BANK[$9]

; places the prize cards on both sides
; of the Play Area (player & opp)
PlacePrizes:
	ld hl, .PrizeCardCoordinates
	ld e, DECK_SIZE - 7 - 1 ; deck size - cards drawn - 1
	ld a, [wDuelInitialPrizes]
	ld d, a

.place_prize
	push de
	ld b, 20 ; frames to delay
.loop_delay
	call DoFrame
	bank1call CheckSkipDelayAllowed
	jr c, .skip_delay
	dec b
	jr nz, .loop_delay
.skip_delay
	call .DrawPrizeTile
	call .DrawPrizeTile

	push hl
	ld a, SFX_08
	call PlaySFX
	; print new deck card number
	lb bc, 3, 5
	ld a, e
	bank1call WriteTwoDigitNumberInTxSymbolFormat
	lb bc, 18, 7
	ld a, e
	bank1call WriteTwoDigitNumberInTxSymbolFormat
	pop hl
	pop de
	dec e ; decrease number of cards in deck
	dec d ; decrease number of prize cards left
	jr nz, .place_prize
	ret

.DrawPrizeTile:
	ld b, [hl]
	inc hl
	ld c, [hl]
	inc hl
	ld a, $ac ; prize card tile
	jp WriteByteToBGMap0

.PrizeCardCoordinates:
; player x, player y, opp x, opp y
	db 5, 6, 14, 5 ; Prize 1
	db 6, 6, 13, 5 ; Prize 2
	db 5, 7, 14, 4 ; Prize 3
	db 6, 7, 13, 4 ; Prize 4
	db 5, 8, 14, 3 ; Prize 5
	db 6, 8, 13, 3 ; Prize 6

SECTION "Bank 9@4a1f", ROMX[$4a1f], BANK[$9]

; display the animation of the turn duelist drawing one card at the beginning of the turn
; if there isn't any card left in the deck, let the player know with a text message
DisplayDrawOneCardScreen:
	ld a, 1
;	fallthrough

; display the animation of the turn duelist drawing number of cards that is in a.
; if there isn't any card left in the deck, let the player know with a text message.
; input:
;	- a = number of cards to draw
DisplayDrawNCardsScreen:
	push hl
	push de
	push bc
	ld [wNumCardsTryingToDraw], a
	xor a
	ld [wNumCardsBeingDrawn], a
	ld a, DUELVARS_NUMBER_OF_CARDS_NOT_IN_DECK
	get_turn_duelist_var
	ld a, DECK_SIZE
	sub [hl]
	ld hl, wNumCardsTryingToDraw
	cp [hl]
	jr nc, .has_cards_left
	; trying to draw more cards than there are left in the deck
	ld [hl], a ; 0
.has_cards_left
	ld a, [wDuelDisplayedScreen]
	cp DRAW_CARDS
	jr z, .portraits_drawn
	cp SHUFFLE_DECK
	jr z, .portraits_drawn
	call EmptyScreen
	call DrawDuelistPortraitsAndNames
.portraits_drawn
	ld a, DRAW_CARDS
	ld [wDuelDisplayedScreen], a
	call PrintDeckAndHandIconsAndNumberOfCards
	ld a, [wNumCardsTryingToDraw]
	or a
	jr nz, .can_draw
	; if wNumCardsTryingToDraw set to 0 before, it's because not enough cards in deck
	ldtx hl, Text016f ; CannotDrawCardBecauseNoCardsInDeckText
	call DrawWideTextBox_WaitForInput
	jr .done
.can_draw
	ld l, a
	ld h, 0
	call LoadTxRam3
	ldtx hl, Text016e ; DrawCardsFromTheDeckText
	call DrawWideTextBox_PrintText
	call EnableLCD
.anim_drawing_cards_loop
	call PlayTurnDuelistDrawAnimation
	ld hl, wNumCardsBeingDrawn
	inc [hl]
	call PrintNumberOfHandAndDeckCards
	ld a, [wNumCardsBeingDrawn]
	ld hl, wNumCardsTryingToDraw
	cp [hl]
	jr c, .anim_drawing_cards_loop

	ld a, [wNumCardsTryingToDraw]
	ld [wcd77], a
	call AIDoAction_06
	call DrawOpponentPortrait

	ld c, 30
.wait_loop
	call DoFrame
	bank1call CheckSkipDelayAllowed
	jr c, .done
	dec c
	jr nz, .wait_loop
.done
	pop bc
	pop de
	pop hl
	ret

; animates the screen for Turn Duelist drawing a card
PlayTurnDuelistDrawAnimation:
	call ResetAnimationQueue
	ld e, DUEL_ANIM_PLAYER_DRAW
	ldh a, [hWhoseTurn]
	cp PLAYER_TURN
	jr z, .got_duelist
	ld e, DUEL_ANIM_OPP_DRAW
.got_duelist
	ld a, e
	call PlayDuelAnimation

.loop_anim
	call DoFrame
	bank1call CheckSkipDelayAllowed
	jr c, .done_anim
	call CheckAnyAnimationPlaying
	jr c, .loop_anim

.done_anim
	call FinishQueuedAnimations
	ret

; prints, for each duelist, the number of cards in the hand along with the
; hand icon, and the number of cards in the deck, along with the deck icon,
; according to each element's placement in the draw card(s) screen.
PrintDeckAndHandIconsAndNumberOfCards:
	call LoadDuelDrawCardsScreenTiles
	ld hl, DeckAndHandIconsTileData
	call WriteDataBlocksToBGMap0
	ld a, [wConsole]
	cp CONSOLE_CGB ; useless cp
	jr nz, .not_cgb
.not_cgb
	call PrintPlayerNumberOfHandAndDeckCards
	call PrintOpponentNumberOfHandAndDeckCards
	ret

; prints, for each duelist, the number of cards in the hand, and the number
; of cards in the deck, according to their placement in the draw card(s) screen.
; input: wNumCardsBeingDrawn = number of cards being drawn (in order to add
; them to the hand cards and subtract them from the deck cards).
PrintNumberOfHandAndDeckCards:
	ldh a, [hWhoseTurn]
	cp PLAYER_TURN
	jr nz, PrintOpponentNumberOfHandAndDeckCards
;	fallthrough

PrintPlayerNumberOfHandAndDeckCards:
	ld a, [wPlayerNumberOfCardsInHand]
	ld hl, wNumCardsBeingDrawn
	add [hl]
	ld d, a
	ld a, DECK_SIZE
	ld hl, wPlayerNumberOfCardsNotInDeck
	sub [hl]
	ld hl, wNumCardsBeingDrawn
	sub [hl]
	ld e, a
	ld a, d
	lb bc, 16, 10
	bank1call WriteTwoDigitNumberInTxSymbolFormat
	ld a, e
	lb bc, 10, 10
	bank1call WriteTwoDigitNumberInTxSymbolFormat
	ret

PrintOpponentNumberOfHandAndDeckCards:
	ld a, [wOpponentNumberOfCardsInHand]
	ld hl, wNumCardsBeingDrawn
	add [hl]
	ld d, a
	ld a, DECK_SIZE
	ld hl, wOpponentNumberOfCardsNotInDeck
	sub [hl]
	ld hl, wNumCardsBeingDrawn
	sub [hl]
	ld e, a
	ld a, d
	lb bc, 5, 3
	bank1call WriteTwoDigitNumberInTxSymbolFormat
	ld a, e
	lb bc, 11, 3
	bank1call WriteTwoDigitNumberInTxSymbolFormat
	ret

DeckAndHandIconsTileData:
; x, y, tiles[], 0
	db  4,  3, SYM_CROSS, 0 ; x for opponent's hand
	db 10,  3, SYM_CROSS, 0 ; x for opponent's deck
	db  8,  2, $f4, $f5,  0 ; opponent's deck icon
	db  8,  3, $f6, $f7,  0 ; opponent's deck icon
	db  2,  2, $f8, $f9,  0 ; opponent's hand icon
	db  2,  3, $fa, $fb,  0 ; opponent's hand icon
	db  9, 10, SYM_CROSS, 0 ; x for player's deck
	db 15, 10, SYM_CROSS, 0 ; x for player's hand
	db  7,  9, $f4, $f5,  0 ; player's deck icon
	db  7, 10, $f6, $f7,  0 ; player's deck icon
	db 13,  9, $f8, $f9,  0 ; player's hand icon
	db 13, 10, $fa, $fb,  0 ; player's hand icon
	db $ff

; unreferenced, copied over from TCG1
DeckAndHandIconsCGBPalData:
; x, y, pals[], 0
	db  8,  2, $03, $03, 0
	db  8,  3, $03, $03, 0
	db  2,  2, $03, $03, 0
	db  2,  3, $03, $03, 0
	db  7,  9, $03, $03, 0
	db  7, 10, $03, $03, 0
	db 13,  9, $03, $03, 0
	db 13, 10, $03, $03, 0
	db $ff
; 0x24b83

SECTION "Bank 9@4e25", ROMX[$4e25], BANK[$9]

; given the deck index of a turn holder's card in register a,
; and a pointer in hl to the wLoadedCard* buffer where the card data is loaded,
; check if the card is Clefairy Doll or Mysterious Fossil, and, if so, convert it
; to a Pokemon card in the wLoadedCard* buffer, using .trainer_to_pkmn_data_1.
ConvertSpecialTrainerCardToPokemon::
	ld c, a
	ld a, [hl]
	cp TYPE_TRAINER
	ret nz ; return if the card is not TRAINER type
	push hl
	ldh a, [hWhoseTurn]
	ld h, a
	ld l, c
	ld a, [hl]
	and CARD_LOCATION_PLAY_AREA
	pop hl
	ret z ; return if the card is not in the arena or bench
	ld a, e
	cp LOW(MYSTERIOUS_FOSSIL)
	jr nz, .check_for_clefairy_doll
	ld a, d
	cp HIGH(MYSTERIOUS_FOSSIL)
	jr z, .OverwriteCardData
	ret
.check_for_clefairy_doll
	cp LOW(CLEFAIRY_DOLL)
	ret nz
	ld a, d
	cp HIGH(CLEFAIRY_DOLL)
	ret nz
	bank1call CheckHypnoPuppetMaster
	jr nc, .OverwriteCardData
	call .OverwriteCardData
	ld bc, $21
	add hl, bc
	ld c, $13
	ld de, .trainer_to_pkmn_data_2
.loop_copy_1
	ld a, [de]
	inc de
	ld [hli], a
	dec c
	jr nz, .loop_copy_1
	ret

.OverwriteCardData
	push hl
	push de
	ld [hl], TYPE_PKMN_COLORLESS
	ld bc, $a ; CARD_DATA_HP
	add hl, bc
	ld de, .trainer_to_pkmn_data_1
	ld c, $38 ; CARD_DATA_UNKNOWN2 - CARD_DATA_HP
.loop_copy_2
	ld a, [de]
	inc de
	ld [hli], a
	dec c
	jr nz, .loop_copy_2
	pop de
	pop hl
	ret

.trainer_to_pkmn_data_1
	db 10                 ; CARD_DATA_HP
	ds $07                ; CARD_DATA_ATTACK1_NAME - (CARD_DATA_HP + 1)
	tx Text0031 ; DiscardName ; CARD_DATA_ATTACK1_NAME
	tx Text0042 ; DiscardDescription ; CARD_DATA_ATTACK1_DESCRIPTION
	ds $03                ; CARD_DATA_ATTACK1_CATEGORY - (CARD_DATA_ATTACK1_DESCRIPTION + 2)
	db POKEMON_POWER      ; CARD_DATA_ATTACK1_CATEGORY
	dw $4896; TrainerCardAsPokemonEffectCommands ; CARD_DATA_ATTACK1_EFFECT_COMMANDS
	ds $18                ; CARD_DATA_RETREAT_COST - (CARD_DATA_ATTACK1_EFFECT_COMMANDS + 2)
	db UNABLE_RETREAT     ; CARD_DATA_RETREAT_COST
	ds $0d                ; PKMN_CARD_DATA_LENGTH - (CARD_DATA_RETREAT_COST + 1)

.trainer_to_pkmn_data_2
	db $00
	db $00
	db $00
	db $00
	tx Text01ce
	tx Text01cf
	db $00
	db $00
	db $1e
	db $00
	db $ab
	db $50
	db $00
	db $00
	db $00
	db $00
	db $00
; 0x24ebf

SECTION "Bank 9@4fe0", ROMX[$4fe0], BANK[$9]

DeckDiagnosis:
	farcall GetNumberOfDeckDiagnosisStepsUnlocked
	ld [wNumDeckDiagnosisSteps], a

	bank1call SetupDuel

	call DisableLCD
	call LoadDeckDiagnosisScene
	call PrintDeckDiagnosisSteps
	call EnableLCD

	; initial text
	ldtx hl, Text053e
	call CheckDeck.PrintDrMasonText

	xor a
	ld [wDeckDiagnosisStep], a
.loop_menu
	ld a, [wDeckDiagnosisStep]
	ldh [hCurScrollMenuItem], a
	xor a ; menu to select the step
	ld [wDeckDiagnosisMenuStepSelected], a
	call HandleDeckDiagnosisMenu
	ld [wDeckDiagnosisStep], a
	cp $ff
	ret z ; exit Deck Diagnosis screen
	inc a
	ld [wDeckDiagnosisMenuStepSelected], a
	xor a
	ld [wcd29], a
.selected_step_menu
	ld a, [wcd29]
	ldh [hCurScrollMenuItem], a
	ld a, [wDeckDiagnosisMenuStepSelected]
	call HandleDeckDiagnosisMenu
	cp $ff
	jr z, .loop_menu
	ld [wcd29], a
	call Func_2517f
	call EmptyScreen
	call LoadDeckDiagnosisScene
	jr .selected_step_menu

DeckDiagnosisTextTables:
	dw .steps_menu
	dw .step_1
	dw .step_2
	dw .step_3
	dw .step_4

.steps_menu
	db $00
	dw NULL
	tx Text053f

	tx Text0540 ; Step 1
	tx Text0541 ; Step 2
	tx Text0542 ; Step 3
	tx Text0543 ; Step 4

.step_1
	db 5 ; number of items
	tx Text0532 ; text ID with all items

	; menu items
	tx Text0544 ; Check Deck
	tx Text0545 ; Advice 1
	tx Text0546 ; Advice 2
	tx Text0547 ; Advice 3
	tx Text0548 ; Back

.step_2
	db 4 ; number of items
	tx Text0533 ; text ID with all items

	; menu items
	tx Text0549 ; Advice 1
	tx Text054a ; Advice 2
	tx Text054b ; Advice 3
	tx Text0548 ; Back

.step_3
	db 4 ; number of items
	tx Text0534 ; text ID with all items

	; menu items
	tx Text054c ; Advice 1
	tx Text054d ; Advice 2
	tx Text054e ; Advice 3
	tx Text0548 ; Back

.step_4
	db 5 ; number of items
	tx Text0535 ; text ID with all items

	; menu items
	tx Text054f ; Advice 1
	tx Text0550 ; Advice 2
	tx Text0551 ; Advice 3
	tx Text0552 ; Advice 4
	tx Text0548 ; Back

; prints menu for the current Deck Diagnosis step
; depending on a:
; - 0 = menu to select which step to view
; - 1 = Step 1 menu
; - 2 = Step 2 menu
; - 3 = Step 3 menu
; - 4 = Step 4 menu
; returns item that player selected in a
; if player selected cancel (last item),
; returns $ff instead
HandleDeckDiagnosisMenu:
	add a ; *2
	ld e, a
	ld d, $00
	ld hl, DeckDiagnosisTextTables
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, [hli]
	ld e, [hl]
	inc hl
	ld d, [hl]
	inc hl
	push af
	push de
	ld a, l
	ld [wDeckDiagnosisTextIDsPtr + 0], a
	ld a, h
	ld [wDeckDiagnosisTextIDsPtr + 1], a
	lb de, 10, 0
	lb bc, 10, 12
	call DrawRegularTextBox
	pop hl

	; print the menu items
	lb de, 12, 0
	ld a, $06
	call ZeroAttributesAtDE
	call InitTextPrinting_ProcessTextFromID

	; initialize the menu
	ld hl, .MenuParameters
	ldh a, [hCurScrollMenuItem]
	call InitializeMenuParameters

	call .PrintCursorMenuItemText
	pop af
	or a
	call z, PrintDeckDiagnosisSteps
	ld [wNumScrollMenuItems], a
	call EnableLCD
.loop_input
	call DoFrame
	call HandleMenuInput
	jr nc, .loop_input
	ld hl, wNumScrollMenuItems
	ld c, [hl]
	dec c
	cp c
	ret c
	ld a, $ff
	ret

.MenuParameters:
	db 11, 2 ; cursor x, cursor y
	db 2 ; y displacement between items
	db 5 ; number of items
	db SYM_CURSOR_R ; cursor tile number
	db SYM_SPACE ; tile behind cursor
	dw .UpdateFunc ; function pointer if non-0

.UpdateFunc:
	ldh a, [hDPadHeld]
	and D_UP | D_DOWN
	jr z, .check_a_btn
	call .PrintCursorMenuItemText
.check_a_btn
	ldh a, [hKeysPressed]
	bit A_BUTTON_F, a
	jr nz, .a_btn_pressed
	and B_BUTTON
	ret z
	; b btn pressed
	ld a, $ff
	ldh [hCurScrollMenuItem], a
.a_btn_pressed
	scf
	ret

.PrintCursorMenuItemText:
	ld a, [wDeckDiagnosisMenuStepSelected]
	or a
	jr nz, .load_text_id
	; is inside menu to select which step
	ld a, [wNumDeckDiagnosisSteps]
	ld hl, hCurScrollMenuItem
	cp [hl]
	jr nc, .load_text_id
	; cursor is on cancel (last item)
	ldtx hl, Text0543
	jr .print_text
.load_text_id
	; loads text ID from wDeckDiagnosisTextIDsPtr
	; depending on which menu item the cursor is on
	ldh a, [hCurScrollMenuItem]
	add a ; *2
	ld e, a
	ld d, $00
	ld hl, wDeckDiagnosisTextIDsPtr
	ld a, [hli]
	ld h, [hl]
	ld l, a
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
.print_text
	push hl
	lb de, 0, 12
	lb bc, 20, 6
	ldtx hl, Text04f7
	call DrawLabeledTextBox
	pop hl
	lb de, 1, 14
	call InitTextPrinting_ProcessTextFromID
	ret

PrintDeckDiagnosisSteps:
	lb de, 10,  0
	lb bc, 10, 12
	call DrawRegularTextBox

	ld a, [wNumDeckDiagnosisSteps]
	inc a
	ld c, a
	lb de, 12, 2
	ld hl, .text_ids
.loop
	push hl
	push de
	push bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	call InitTextPrinting_ProcessTextFromID
	pop bc
	pop de
	pop hl
	inc hl
	inc hl
	inc e
	inc e
	dec c
	jr nz, .loop

	ldtx hl, Text0531
	call InitTextPrinting_ProcessTextFromID
	ld a, [wNumDeckDiagnosisSteps]
	add 2
	ret

.text_ids
	tx Text0529 ; Step 1
	tx Text052a ; Step 2
	tx Text052b ; Step 3
	tx Text052c ; Step 4

; loads Deck Diagnosis scene together
; with Dr. Mason's portrait
LoadDeckDiagnosisScene:
	lb bc, 1, 1
	ld a, SCENE_DECK_DIAGNOSIS
	call LoadScene
	lb bc, 2, 6
;	fallthrough
DrawDrMasonsPortrait:
	ld a, NPC_DR_MASON
	ld e, PORTRAITVARIANT_NORMAL
	call DrawNPCPortrait
	call FlushAllPalettes
	ret

Func_2517f:
	call EmptyScreen
	ldh a, [hCurScrollMenuItem]
	ld [wDeckDiagnosisAdvice], a
	call .GetTextIDsForAdvice
	jp c, CheckDeck
	call .Func_251c2
	bank1call SetNoLineSeparation
.loop
	push hl
	lb de, 0, 8
	lb bc, 20, 10
	call DrawRegularTextBox
	pop hl

	push hl
	ld a, [hli]
	ld h, [hl]
	ld l, a
	lb de, 1, 9
	call InitTextPrinting_ProcessTextFromID
	call WaitForWideTextBoxInput
	pop hl
	inc hl
	inc hl
	ld a, [hli]
	or [hl]
	dec hl
	jr z, .done
	push hl
	call .GetTextIDsForAdvice
	call .Func_251c2
	pop hl
	jr .loop
.done
	bank1call SetOneLineSeparation
	or a
	ret

.Func_251c2:
	push de
	push hl
	ld a, [wDeckDiagnosisStep]
	add a ; *2
	ld e, a
	ld d, $00
	ld hl, .StepTextIDs
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	lb de, 10, 2
	call InitTextPrinting_ProcessTextFromID
	pop hl
	lb de, 10, 5
	call InitTextPrinting_ProcessTextFromID
	lb bc, 2, 1
	call DrawDrMasonsPortrait
	call EnableLCD
	pop hl
	ret

; output:
; hl = textID of advice (Advice1, Advice2, etc)
; de = pointer to text IDs of that advice's explanation
; if hl is NULL, then return carry set, this is
; done in the Check Deck option, or an invalid entry
.GetTextIDsForAdvice:
	ld a, [wDeckDiagnosisAdvice]
	ld c, a
	ld a, [wDeckDiagnosisStep]
	add a
	add a
	add c
	add a
	add a
	; a = (wDeckDiagnosisStep * 4 + wDeckDiagnosisAdvice) * 4
	ld e, a
	ld d, $00
	ld hl, .AdviceTexts
	add hl, de
	ld e, [hl]
	inc hl
	ld d, [hl]
	inc hl
	ld a, [hli]
	ld h, [hl]
	ld l, a
	or h
	ret nz
	scf
	ret

.StepTextIDs:
	tx Text0529 ; Step 1
	tx Text052a ; Step 2
	tx Text052b ; Step 3
	tx Text052c ; Step 4

MACRO advice
	dw \1
	tx \2
ENDM

.AdviceTexts:
	; Step 1
	dw NULL, NULL                   ; Check Deck
	advice .step1_advice1, Text052d ; Advice 1
	advice .step1_advice2, Text052e ; Advice 2
	advice .step1_advice3, Text052f ; Advice 3

	; Step 2
	advice .step2_advice1, Text052d ; Advice 1
	advice .step2_advice2, Text052e ; Advice 2
	advice .step2_advice3, Text052f ; Advice 3
	dw NULL, NULL

	; Step 3
	advice .step3_advice1, Text052d ; Advice 1
	advice .step3_advice2, Text052e ; Advice 2
	advice .step3_advice3, Text052f ; Advice 3
	dw NULL, NULL

	; Step 4
	advice .step4_advice1, Text052d ; Advice 1
	advice .step4_advice2, Text052e ; Advice 2
	advice .step4_advice3, Text052f ; Advice 3
	advice .step4_advice4, Text0530 ; Advice 4

.step1_advice1
	tx Text055b
	tx Text055c
	dw NULL

.step1_advice2
	tx Text055d
	tx Text055e
	dw NULL

.step1_advice3
	tx Text055f
	tx Text0560
	dw NULL

.step2_advice1
	tx Text0561
	dw NULL

.step2_advice2
	tx Text0562
	dw NULL

.step2_advice3
	tx Text0563
	dw NULL

.step3_advice1
	tx Text0564
	tx Text0565
	tx Text0566
	tx Text0567
	dw NULL

.step3_advice2
	tx Text0568
	tx Text0569
	dw NULL

.step3_advice3
	tx Text056a
	tx Text056b
	dw NULL

.step4_advice1
	tx Text056c
	tx Text056d
	tx Text056e
	tx Text056f
	tx Text0570
	tx Text0571
	dw NULL

.step4_advice2
	tx Text0572
	tx Text0573
	tx Text0574
	dw NULL

.step4_advice3
	tx Text0575
	tx Text0576
	dw NULL

.step4_advice4
	tx Text0577
	tx Text0578
	dw NULL

CheckDeck:
.start
	ldtx de, Text0553
	farcall Func_2bc4f
	ret c
	ld l, a
	ld h, DECK_COMPRESSED_STRUCT_SIZE
	call HtimesL
	ld de, sDeck1
	add hl, de
	ld a, l
	ld [wcd2b + 0], a
	ld a, h
	ld [wcd2b + 1], a

	call EnableSRAM
	ld de, wDefaultText
	ld c, DECK_NAME_SIZE
.loop_copy_name
	ld a, [hli]
	ld [de], a
	inc de
	dec c
	jr nz, .loop_copy_name
	xor a ; TX_END
	ld [de], a
	call DisableSRAM
	ld hl, $0
	call LoadTxRam2

	call .CheckDeckDelay
	call .GetDeckCardCountsAndPrintCounts

	xor a
	ld [wcd4e], a
	ld a, PLAYER_TURN
	ldh [hWhoseTurn], a
	call .DoChecks

	ldtx de, Text04f7
	ldtx hl, Text055a
	call PrintScrollableText_WithTextBoxLabel_NoWait
	call YesOrNoMenu
	jr nc, .start
	ret

.DoChecks:
	; check has enough Basic cards
	ldtx hl, Text0579
	ld a, [wDeckCheckBasicCount]
	cp 12
	jp c, .PrintDrMasonText ; < 12 Basic cards

	; check color diversity
	call .CountTypesOfPkmnCards
	ldtx hl, Text057a
	cp 4
	jp nc, .PrintDrMasonText ; >= 4 different types

	call .DiagnoseNumberOfPkmnAndEnergyCards
	ret c ; already printed a diagnosis

	call .CheckIfEvolutionCardsHaveTheirPreEvos
	jr nc, .check_mismatched_evos
	ldtx hl, Text0580
	ldtx de, Text0581
	jp .asm_25352

.check_mismatched_evos
	call .LookForBasicCardsWithMismatchedEvolutionCounts
	jr nc, .check_mismatched_energy
	ldtx hl, Text0582
	ldtx de, Text0583
	jp .asm_25352

.check_mismatched_energy
	call .CheckIfAllEnergyCardsMatchPkmnColors
	jr c, .check_amount_energy_cards
	ldtx hl, Text0584
	ldtx de, Text0585
	jp .asm_25352

.check_amount_energy_cards
	call .CheckEnergyAmountVsPkmnCards
	ret c
	ldtx hl, Text058a
	ld a, [wDeckCheckTrainerCount]
	or a
	jr nz, .asm_2534d
	ldtx hl, Text058b
.asm_2534d
	call .PrintDrMasonText
	or a
	ret

.asm_25352
	push de
	call .PrintDrMasonText
	pop hl
	farcall DeckDiagnosisResult
	ret

; print a given text in the text box
; with Dr. Mason as the box header
; hl = text ID
.PrintDrMasonText:
	ldtx de, Text04f7 ; "Dr. Mason"
	call PrintScrollableText_WithTextBoxLabel
	ld hl, wcd4e
	inc [hl]
	ret

; outputs in a number of different colored types
; that are found in wDeckCheckPkmnCounts
.CountTypesOfPkmnCards:
	lb bc, 0, NUM_COLORED_TYPES
	ld hl, wDeckCheckPkmnCounts
.loop_pkmn_colored_types
	ld a, [hli]
	or a
	jr z, .none
	inc b
.none
	dec c
	jr nz, .loop_pkmn_colored_types
	ld a, b
	or a
	ret nz
	; output at least 1
	ld a, 1
	ret

.DiagnoseNumberOfPkmnAndEnergyCards:
	ld hl, wDeckCheckBasicCount
	ld a, [hli]
	add [hl]
	inc hl
	add [hl]
	ldtx hl, Text057c
	cp 31
	jr nc, .asm_25390
	ldtx hl, Text057b
	cp 18
	jr nc, .asm_25393
.asm_25390
	call .PrintDrMasonText

.asm_25393
	ld a, [wDeckCheckEnergyCount]
	ldtx hl, Text057f
	or a
	jr z, .asm_253aa
	ldtx hl, Text057d
	cp 20
	jr c, .asm_253aa
	ldtx hl, Text057e
	cp 31
	jr c, .asm_253ad
.asm_253aa
	call .PrintDrMasonText

.asm_253ad
	ld a, [wcd4e]
	or a
	ret z
	scf
	ret

.CheckDeckDelay:
	call EmptyScreen

	lb de,  0, 0
	lb bc, 20, 3
	call DrawRegularTextBox
	lb de, 3, 1
	ldtx hl, Text0536
	call PrintTextNoDelay_Init
	call EnableLCD
	ldtx de, Text04f7
	ldtx hl, Text0554
	call PrintScrollableText_WithTextBoxLabel_NoWait

	; delays for $80 frames,
	; every $10 frames cycle Dr. Mason's portrait
	; between normal and sad variants
	ld d, $80
	ld e, PORTRAITVARIANT_NORMAL
.check_delay
	ld a, d
	and %1111
	jr nz, .skip_portrait_switch
	; swap between normal and sad portrait
	ld a, e
	xor $2
	ld e, a
.skip_portrait_switch
	push de
	call DoFrame
	ld a, NPC_DR_MASON
	lb bc, 7, 4
	call DrawNPCPortrait
	call FlushAllPalettes
	pop de
	dec d
	jr nz, .check_delay

	; show happy portrait
	ld a, NPC_DR_MASON
	ld e, PORTRAITVARIANT_HAPPY
	lb bc, 7, 4
	call DrawNPCPortrait
	call FlushAllPalettes

	call WaitForWideTextBoxInput
	ret

.GetDeckCardCountsAndPrintCounts:
	call EmptyScreen

	lb de,  0,  0
	lb bc, 20, 12
	call DrawRegularTextBox
	lb de, 2, 0
	ldtx hl, Text0536
	call Func_2c4b
	lb de, 2, 2
	ldtx hl, Text0537
	call PrintTextNoDelay_Init

	ld hl, wcd2b
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld de, DECK_NAME_SIZE
	add hl, de
	call .GetDeckCardCounts

	; prints counts for Energy, Basic,
	; Stage1, Stage2 and Trainer cards
	lb bc, 14, 2
	ld hl, wDeckCheckCardCounts
	ld e, (wDeckCheckTrainerCount - wDeckCheckEnergyCount) + 1
.loop_counts
	ld a, [hli]
	push hl
	bank1call WriteTwoByteNumberInTxSymbolFormat
	pop hl
	inc c
	inc c ; two tiles spacing
	dec e
	jr nz, .loop_counts
	call EnableLCD
	ldtx de, Text04f7
	ldtx hl, Text0555
	call PrintScrollableText_WithTextBoxLabel
	ret

; given deck in hl, count how many cards
; of each type there are (Basic, Stage1, Stage2, Energy, Trainer)
; and within Energy cards, count each color as well
; outputs all results in wDeckCheckCardCounts
.GetDeckCardCounts:
	ld e, l
	ld d, h
	ld hl, wPlayerDeck
	push hl
	call EnableSRAM
	bank1call DecompressSRAMDeck
	call DisableSRAM
	pop hl

	push hl
	ld hl, wDeckCheckCardCounts
	ld c, wDeckCheckCardCountsEnd - wDeckCheckCardCounts
	xor a
.loop_clear
	ld [hli], a
	dec c
	jr nz, .loop_clear
	pop hl

.loop_deck
	ld e, [hl]
	inc hl
	ld d, [hl]
	inc hl
	call LoadCardDataToBuffer1_FromCardID
	ret c ; done
	push hl
	cp16 RAINBOW_ENERGY
	jr nz, .not_rainbow
	; rainbow energy has its own count
	ld hl, wDeckCheckRainbowEnergyCount
	inc [hl]
.not_rainbow
	ld a, [wLoadedCard1Type]
	ld e, $4
	cp TYPE_TRAINER
	jr z, .got_type
	ld e, $0
	cp TYPE_ENERGY
	jr nc, .got_type
	ld e, $1
	ld a, [wLoadedCard1Stage]
	or a
	jr z, .got_type
	ld e, $2
	cp STAGE1
	jr z, .got_type
	ld e, $3
.got_type
	ld d, $00
	ld hl, wDeckCheckCardCounts
	add hl, de
	inc [hl]
	ld a, [wLoadedCard1Type]
	bit TYPE_ENERGY_F, a
	jr z, .not_energy
	; is an energy card
	and TYPE_PKMN
	ld e, a
	ld hl, wDeckCheckEnergyCounts
	add hl, de
	inc [hl]
.not_energy
	ld a, [wLoadedCard1Type]
	cp TYPE_ENERGY
	jr nc, .not_pkmn
	; is a pkmn card
	and TYPE_PKMN
	ld e, a
	ld hl, wDeckCheckPkmnCounts
	add hl, de
	inc [hl]
.not_pkmn
	pop hl
	jr .loop_deck

.CheckIfEvolutionCardsHaveTheirPreEvos:
	ld de, wCurDeckCards
	call SetListPointer2
	ld hl, wPlayerDeck
	ld a, DECK_SIZE ; unused
.loop_evo_cards
	ld e, [hl]
	inc hl
	ld d, [hl]
	inc hl
	call LoadCardDataToBuffer1_FromCardID
	jr c, .done_evo_cards
	ld a, [wLoadedCard1Type]
	cp TYPE_ENERGY
	jr nc, .check_next_evo_card
	ld a, [wLoadedCard1Stage]
	or a
	jr z, .check_next_evo_card
	call .CheckIfHasPreEvo
	jr nc, .check_next_evo_card
	call Func_0b99
.check_next_evo_card
	jr .loop_evo_cards
.done_evo_cards
	ld de, $0
	call Func_0b99
	ld hl, wCurDeckCards
	ld a, [hli]
	or [hl]
	ret z
	scf
	ret

; returns carry if wPlayerDeck does not
; contain the pre-evolution of wLoadedCard1
.CheckIfHasPreEvo:
	push hl
	push de
	push bc
	ld hl, wLoadedCard1PreEvoName
	ld c, [hl]
	inc hl
	ld b, [hl]
	ld hl, wPlayerDeck
.loop_search_pre_evo
	ld e, [hl]
	inc hl
	ld d, [hl]
	inc hl
	call GetCardName
	jr c, .pre_evo_not_found
	ld a, c
	cp e
	jr nz, .loop_search_pre_evo
	ld a, b
	cp d
	jr nz, .loop_search_pre_evo
	or a
.pre_evo_not_found
	pop bc
	pop de
	pop hl
	ret

; creates a list in wCurDeckCards of Basic cards
; that have mismatched Stage 1 and Stage 2 card counts
; if this list is not empty, return carry set
.LookForBasicCardsWithMismatchedEvolutionCounts:
	ld de, wCurDeckCards
	call SetListPointer2

	; fills wDuelTempList with sequence
	; 0, 1, 2, 3, 4, ... to serve as deck indices
	ld hl, wDuelTempList
	xor a
.loop_fill_list_sequence
	ld [hli], a
	inc a
	cp DECK_SIZE
	jr c, .loop_fill_list_sequence
	ld [hl], $ff

	bank1call SortCardsInDuelTempListByID

	ld hl, wDuelTempList
.loop_filter_only_pkmn
	ld a, [hli]
	ldh [hTempCardIndex_ff98], a
	cp $ff
	jp z, .got_basic_card_list
	; keeps only PKMN cards or Mysterious Fossil
	; and removes all other cards
	call GetCardIDFromDeckIndex
	call LoadCardDataToBuffer1_FromCardID
	cp16 MYSTERIOUS_FOSSIL
	jr z, .basic_stage
	ld a, [wLoadedCard1Type]
	cp TYPE_ENERGY
	jr c, .check_stage
	; is not PKMN card or Mysterious Fossil
	ldh a, [hTempCardIndex_ff98]
	call RemoveCardFromDuelTempList
	jr .loop_filter_only_pkmn
.check_stage
	ld a, [wLoadedCard1Stage]
	or a
	jr nz, .loop_filter_only_pkmn

.basic_stage
	ld a, [wListPointer2 + 0]
	ld [wListPointer + 0], a
	ld a, [wListPointer2 + 1]
	ld [wListPointer + 1], a

	xor a
	ld hl, wDeckCheckCurBasicCount
	ld [hli], a ; wDeckCheckCurBasicCount
	ld [hli], a ; wDeckCheckCurStage1Count
	ld [hl], a  ; wDeckCheckCurStage2Count

	ld hl, wLoadedCard1Name
	ld e, [hl]
	inc hl
	ld d, [hl]
	call .CountAndRemoveCardsWithSameName
	ld [wDeckCheckCurBasicCount], a

; goes through 1st and 2nd stage cards
; that evolve from current basic card
; counts how many cards of each stage there are
.loop_search_stage1_and_stage2_cards
	call .CountAndRemoveCardsWithPreEvolution
	or a
	jr z, .no_more_evolutions
	push de
	ld hl, wDeckCheckCurStage1Count
	add [hl]
	ld [hl], a
	ld hl, wLoadedCard2Name
	ld e, [hl]
	inc hl
	ld d, [hl]
	call .CountAndRemoveCardsWithPreEvolution
	ld hl, wDeckCheckCurStage2Count
	add [hl]
	ld [hl], a
	pop de
	jr .loop_search_stage1_and_stage2_cards

.no_more_evolutions
	ld hl, wDeckCheckCurBasicCount
	ld a, [hli]
	cp [hl] ; wDeckCheckCurStage1Count
	jr c, .mismatched_evo_cards
	ld a, [hli] ; wDeckCheckCurStage1Count
	cp [hl] ; wDeckCheckCurStage2Count
	jr c, .mismatched_evo_cards
	ld a, [wListPointer + 0]
	ld [wListPointer2 + 0], a
	ld a, [wListPointer + 1]
	ld [wListPointer2 + 1], a
.mismatched_evo_cards
	ld hl, wDuelTempList
	jp .loop_filter_only_pkmn

.got_basic_card_list
	ld de, $0
	call Func_0b99
	ld hl, wCurDeckCards
	ld a, [hli]
	or a
	ret z
	; at least 1 entry
	scf
	ret

; outputs in a the number of cards that
; have card name in de as its pre-evolution
; if it finds any, also removes them from wDuelTempList
; only does this to first card ID it finds, so
; if a card has different evolution cards, this needs
; to be called again until there are not cards left
; de = card name
.CountAndRemoveCardsWithPreEvolution:
	push hl
	push de
	push bc
	ld hl, wDeckCheckCardName
	ld [hl], e
	inc hl
	ld [hl], d

	ld c, 0
	ld hl, wDuelTempList
.loop_search_card_evos
	ld a, [hli]
	cp $ff
	jr z, .got_card_evo_count
	call GetCardIDFromDeckIndex
	call LoadCardDataToBuffer2_FromCardID
	ld a, [wLoadedCard2Type]
	cp TYPE_ENERGY
	jr nc, .loop_search_card_evos

	; check if it evolves from card currently looked at
	; if so, add to count and remove it from wDuelTempList
	push hl
	ld hl, wDeckCheckCardName
	ld a, [wLoadedCard2PreEvoName + 0]
	cp [hl]
	jr nz, .not_cards_evo
	ld a, [wLoadedCard2PreEvoName + 1]
	inc hl
	cp [hl]
.not_cards_evo
	pop hl
	jr nz, .loop_search_card_evos

	ld a, [wLoadedCard2Name + 0]
	ld e, a
	ld a, [wLoadedCard2Name + 1]
	ld d, a
	call .CountAndRemoveCardsWithSameName
	ld c, a
.got_card_evo_count
	ld a, c
	pop bc
	pop de
	pop hl
	ret

; outputs in a the number of cards with the name in de
; if it finds any, also removes them from wDuelTempList
; de = card name
.CountAndRemoveCardsWithSameName:
	push hl
	push de
	push bc
	ld hl, wDeckCheckCardName
	ld [hl], e
	inc hl
	ld [hl], d

	ld c, 0
	ld hl, wDuelTempList
.loop_search_cards_with_same_name
	ld a, [hli]
	ldh [hTempCardIndex_ff98], a
	cp $ff
	jr z, .got_card_with_same_name_count
	call GetCardIDFromDeckIndex
	call GetCardName
	jr c, .got_card_with_same_name_count
	push hl
	ld hl, wDeckCheckCardName
	ld a, e
	cp [hl]
	jr nz, .not_same_name
	inc hl
	ld a, d
	cp [hl]
.not_same_name
	pop hl
	jr nz, .loop_search_cards_with_same_name

	; has same name, remove it from wDuelTempList
	; and add this card to list in wListPointer2
	ldh a, [hTempCardIndex_ff98]
	call GetCardIDFromDeckIndex
	call Func_0b99
	ldh a, [hTempCardIndex_ff98]
	call RemoveCardFromDuelTempList
	dec hl
	inc c
	jr .loop_search_cards_with_same_name

.got_card_with_same_name_count
	ld a, c
	pop bc
	pop de
	pop hl
	ret

; returns carry if for all energy cards there is at least
; one Pokémon card in the deck that matches its color
.CheckIfAllEnergyCardsMatchPkmnColors:
	ld hl, wPlayerDeck
	ld bc, wCurDeckCards
.loop_basic_energy
	ld e, [hl]
	inc hl
	ld d, [hl]
	inc hl
	call GetCardType
	jr c, .check_nonmatching_energy
	cp TYPE_ENERGY
	jr c, .matching_pkmn_found
	cp TYPE_ENERGY_DOUBLE_COLORLESS
	jr nc, .matching_pkmn_found

	; is basic energy card
	; check if there is at least a Pokémon
	; that has the same color as it
	push hl
	push de
	push bc
	and TYPE_PKMN
	ld c, a
	ld hl, wPlayerDeck
.loop_pkmn_cards
	ld e, [hl]
	inc hl
	ld d, [hl]
	inc hl
	call GetCardType
	jr c, .break_pkmn_loop
	cp TYPE_ENERGY
	jr nc, .next_pkmn_card ; not Pkmn
	cp c
	jr nz, .next_pkmn_card ; not same type as energy
	or a ; unset carry
	jr .break_pkmn_loop
.next_pkmn_card
	jr .loop_pkmn_cards
.break_pkmn_loop
	pop bc
	pop de
	pop hl
	jr nc, .matching_pkmn_found
	; reaching here means that no
	; Pokémon with matching color was found
	; so add the energy card ID to wCurDeckCards
	ld a, e
	ld [bc], a
	inc bc
	ld a, d
	ld [bc], a
	inc bc
.matching_pkmn_found
	jr .loop_basic_energy

.check_nonmatching_energy
	xor a
	ld [bc], a
	inc bc
	ld [bc], a
	ld hl, wCurDeckCards
	ld a, [hli]
	or [hl]
	jr z, .return_carry
	; first check if all Pokémon are colorless
	; in that case, return carry
	call .CountTypesOfPkmnCards
	cp 2
	jr nc, .at_least_2_types
	ld a, [wDeckCheckPkmnCounts + COLORLESS]
	or a
	jr nz, .return_carry
.at_least_2_types
	or a
	ret
.return_carry
	scf
	ret

; checks if each every type has right amount
; of energy, dependent on number of Pokémon cards
; for that type
.CheckEnergyAmountVsPkmnCards:
	call .CountTypesOfPkmnCards
	ld [wcd4b], a

	; counts total amount of energy that the deck provides
	; Double Colorless counts as 2 energies
	ld c, 0
	ld hl, wPlayerDeck
.loop_count_amount_energy
	ld e, [hl]
	inc hl
	ld d, [hl]
	inc hl
	call GetCardType
	jr c, .done_counting_energy
	cp TYPE_ENERGY
	jr c, .next_card
	cp TYPE_TRAINER
	jr nc, .next_card
	inc c
	cp16 DOUBLE_COLORLESS_ENERGY
	jr nz, .next_card
	inc c
.next_card
	jr .loop_count_amount_energy

.done_counting_energy
	ld hl, wDeckCheckBasicCount
	ld a, [hli] ; wDeckCheckBasicCount
	add [hl] ; wDeckCheckStage1Count
	inc hl
	add [hl] ; wDeckCheckStage2Count
	ld b, a ; total count of all Pkmn cards
	ld hl, wcd4b
	sub [hl]
	sub c
	jr z, .asm_256f4
	jr c, .asm_256f4
	; total Pkmn cards > wcd4b + total energy
	ldtx hl, Text0586
	call .PrintDrMasonText

.asm_256f4
	call .CalculateEnergySurplus
	ld hl, wDeckCheckEnergySurplus
	ld c, FIRE
	ld b, NUM_COLORED_TYPES
.loop_colored_types_1
	ld a, [hli]
	push hl
	push bc
	or a
	jr z, .asm_25737
	bit 7, a
	jr nz, .negative
	; surplus of energy cards
	ldtx hl, Text0587
	jr .get_energy_name
.negative
	; not enough energy cards
	ldtx hl, Text0588

.get_energy_name
	push hl
	ld a, c
	add a ; *2
	ld c, a
	ld b, $00
	ld hl, .TypeTextIDs
	add hl, bc
	ld e, [hl]
	inc hl
	ld d, [hl]
	ld hl, wTxRam2
	ld [hl], e
	inc hl
	ld [hl], d
	inc hl
	ld [hl], e
	inc hl
	ld [hl], d
	ld a, [wcd4e]
	or a
	jr nz, .asm_25733
	ldtx hl, Text058c
	call .PrintDrMasonText
.asm_25733
	pop hl
	call .PrintDrMasonText
.asm_25737
	pop bc
	pop hl
	inc c
	dec b
	jr nz, .loop_colored_types_1
	ld a, [wcd4e]
	or a
	ret z
	scf
	ret

.TypeTextIDs:
	tx Text053b ; FIRE
	tx Text0538 ; GRASS
	tx Text053a ; LIGHTNING
	tx Text0539 ; WATER
	tx Text053c ; FIGHTING
	tx Text053d ; PSYCHIC

.CalculateEnergySurplus:
	; divide colorless card counts
	; between the different types found
	ld a, [wDeckCheckPkmnCounts + COLORLESS]
	ld b, a
	ld c, 0
	ld a, [wcd4b]
	ld d, 0
	ld e, a
	; bc = colorless counts * 16
	; de = number different Pkmn types in deck
	call DivideBCbyDE
	; round up
	ld hl, $80
	add hl, bc
	ld a, h
	ld [wDeckCheckColorlessCardsPerType], a

	xor a
	ld [wDeckCheckTotalEnergySurplus], a
	ld hl, wDeckCheckPkmnCounts
	ld de, .TypeEnergyWeights
	ld b, NUM_COLORED_TYPES
	ld c, FIRE
.loop_colored_types_2
	push bc
	ld a, [de] ; weight
	ld b, a
	ld a, [hl] ; pkmn counts
	push de
	push hl
	ld l, a
	ld h, b
	or a
	jr z, .got_surplus_energy
	cp 2
	jr nc, .at_least_2_pkmn
	; count = 1
	dec a
.at_least_2_pkmn
	ld [wcd4c], a

	; multiply Pkmn count with type weight
	call HtimesL
	add hl, hl
	add hl, hl
	add hl, hl
	add hl, hl ; *16
	; round up
	ld de, $80
	add hl, de
	ld a, [wDeckCheckColorlessCardsPerType]
	add h
	ld [wDeckCheckTotalEnergyRequirement], a

	; sum this type's energy count
	; with rainbow energy count
	ld b, $00
	ld hl, wDeckCheckEnergyCounts
	add hl, bc
	ld a, [wDeckCheckRainbowEnergyCount]
	add [hl]
	ld e, a

	ld hl, wcd4c
	sub [hl]
	jr c, .got_surplus_energy ; jump if (total energy) < Pkmn count
	ld a, e
	ld hl, wDeckCheckTotalEnergyRequirement
	sub [hl]
	jr nc, .got_surplus_energy ; jump if (total energy) >= (energy requirement)
	xor a
.got_surplus_energy
	; a = 0, if (total energy) < (energy requirement)
	; a = (energy requirement) - (total energy), otherwise
	ld hl, wDeckCheckEnergySurplus
	add hl, bc
	ld [hl], a
	ld hl, wDeckCheckTotalEnergySurplus
	add [hl]
	ld [hl], a
	pop hl
	pop de
	pop bc
	inc de
	inc hl
	inc c
	dec b
	jr nz, .loop_colored_types_2

	ld a, [wDeckCheckEnergyCount]
	ld hl, wDeckCheckTotalEnergySurplus
	add [hl]
	cp 31
	jr nc, .asm_257d2
	; less than 31, set to 0
	xor a
.asm_257d2
	ld [hl], a
	ret

; these will contribute as weights to the number
; of energy cards each Pkmn of that type requires
.TypeEnergyWeights:
	db $13 ; x1.2 FIRE
	db $13 ; x1.2 GRASS
	db $13 ; x1.2 LIGHTNING
	db $13 ; x1.2 WATER
	db $15 ; x1.3 FIGHTING
	db $15 ; x1.3 PSYCHIC
; 0x257da

SECTION "Bank 9@58a2", ROMX[$58a2], BANK[$9]

; fills wCardPopCandidateList with cards that satisfy
; certain criteria:
; if a == $ff, then only output energy cards
; if a == $fe, then only output Phantom cards
; otherwise, output cards with:
; - rarity == a
; - b <= set <= c
; outputs in a the number of cards in the list
CreateCardPopCandidateList:
	cp $ff
	jr z, .energy_cards
	cp $fe
	jr z, .phantom_cards

	ld hl, wcd51
	ld [hli], a
	ld [hl], b ; wcd52
	inc hl
	ld [hl], c ; wcd53
	xor a
	ld [wcd54], a

	ld de, 0
	ld hl, wCardPopCandidateList
	jr .start_loop

.loop_ids
	push hl
	ld hl, wcd51
	ld a, b ; rarity
	cp [hl]
	jr nz, .next_card
	inc hl

	; accept sets >= minimum set
	ld a, c ; set
	cp [hl] ; wcd52
	jr z, .add_card
	jr c, .next_card

	; accept sets <= maximum set
	inc hl
	cp [hl] ; wcd53
	jr z, .add_card
	jr nc, .next_card

.add_card
	ld hl, wcd54
	inc [hl]
	pop hl
	ld [hl], e
	inc hl
	ld [hl], d
	inc hl
.start_loop
	push hl
.next_card
	inc de
	call GetCardTypeRarityAndSet
	pop hl
	jr nc, .loop_ids
	; no more cards
	xor a
	ld [hli], a
	ld [hl], a
	ld a, [wcd54] ; number of cards
	ret

.phantom_cards
	ld hl, .phantom_card_list
	jr .got_card_list
.energy_cards
	ld hl, .energy_card_list
.got_card_list
	ld c, 0
	ld de, wCardPopCandidateList
.loop_list
	ld a, [hli]
	ld b, a
	ld [de], a
	inc de
	ld a, [hli]
	ld [de], a
	inc de
	inc c
	or b
	jr nz, .loop_list
	ld a, c
	dec a
	ld [wcd54], a
	ret

.energy_card_list
	dw GRASS_ENERGY
	dw FIRE_ENERGY
	dw WATER_ENERGY
	dw LIGHTNING_ENERGY
	dw FIGHTING_ENERGY
	dw PSYCHIC_ENERGY
	dw GRASS_ENERGY
	dw FIRE_ENERGY
	dw WATER_ENERGY
	dw LIGHTNING_ENERGY
	dw FIGHTING_ENERGY
	dw PSYCHIC_ENERGY
	dw NULL

.phantom_card_list
	dw VENUSAUR_LV64
	dw MEW_LV15
	dw HERE_COMES_TEAM_ROCKET
	dw LUGIA
	dw VENUSAUR_LV64
	dw MEW_LV15
	dw HERE_COMES_TEAM_ROCKET
	dw LUGIA
	dw NULL

; a = deck ID
LoadDeckIDData:
	ld [wNPCDuelDeckID], a
	ld c, a
	ld hl, DeckIDData
.loop_find
	ld a, [hl]
	cp $ff
	jr z, .not_found
	cp c
	jr z, .found
	ld de, 12
	add hl, de
	jr .loop_find
.not_found
	scf
	ret

.found
	inc hl
	ld a, [hli]
	ld [wOpponentDeckName + 0], a
	ld a, [hli]
	ld [wOpponentDeckName + 1], a
	ld a, [hli]
	ld [wOpponentName + 0], a
	ld a, [hli]
	ld [wOpponentName + 1], a
	ld a, [hli]
	ld [wOpponentNPCID], a
	ld a, [hli]
	ld [wcc15], a
	ld a, [hli]
	ld [wSpecialRule], a
	ld a, [hli]
	ld [wcd0e], a
	ld a, [hli]
	ld [wDuelTheme], a
	ld a, [hli]
	ld [wcd0f], a
	ld a, [hli]
	ld [wcc18], a
	or a
	ret

DeckIDData:
	db UNKNOWN_SAMS_PRACTICE_DECK_ID
	tx Text04d6 ; deck name
	tx Text04d5 ; opponent name
	db NPC_SAM ; NPC ID
	db PRIZES_2 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $00 ; ?
	db MUSIC_DUELTHEME_1 ; duel theme
	db $12 ; ?
	db $00 ; ?

	db STARTER_DECK_ID - 1
	tx Text0448 ; deck name
	tx Text04f6 ; opponent name
	db NPC_MARK ; NPC ID
	db 0 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $00 ; ?
	db MUSIC_STOP ; duel theme
	db $00 ; ?
	db $00 ; ?

	db SWEAT_ANTI_GR1_DECK_ID - 1
	tx Text044d ; deck name
	tx Text04f6 ; opponent name
	db NPC_MARK ; NPC ID
	db 0 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $00 ; ?
	db MUSIC_STOP ; duel theme
	db $00 ; ?
	db $00 ; ?

	db GIVE_IN_ANTI_GR2_DECK_ID - 1
	tx Text0466 ; deck name
	tx Text04f6 ; opponent name
	db NPC_MARK ; NPC ID
	db 0 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $00 ; ?
	db MUSIC_STOP ; duel theme
	db $00 ; ?
	db $00 ; ?

	db VENGEFUL_ANTI_GR3_DECK_ID - 1
	tx Text0449 ; deck name
	tx Text04f6 ; opponent name
	db NPC_MARK ; NPC ID
	db 0 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $00 ; ?
	db MUSIC_STOP ; duel theme
	db $00 ; ?
	db $00 ; ?

	db UNFORGIVING_ANTI_GR4_DECK_ID - 1
	tx Text0470 ; deck name
	tx Text04f6 ; opponent name
	db NPC_MARK ; NPC ID
	db 0 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $00 ; ?
	db MUSIC_STOP ; duel theme
	db $00 ; ?
	db $00 ; ?

	db SAMS_PRACTICE_DECK_ID - 1
	tx Text04f1 ; deck name
	tx Text04f6 ; opponent name
	db NPC_MARK ; NPC ID
	db 0 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $00 ; ?
	db MUSIC_STOP ; duel theme
	db $00 ; ?
	db $00 ; ?

	db SAMS_PRACTICE_DECK_ID
	tx Text04d6 ; deck name
	tx Text04d5 ; opponent name
	db NPC_SAM ; NPC ID
	db PRIZES_2 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $00 ; ?
	db MUSIC_DUELTHEME_1 ; duel theme
	db $12 ; ?
	db $00 ; ?

	db AARON_PRACTICE_DECK1_ID
	tx Text04af ; deck name
	tx Text04f6 ; opponent name
	db NPC_MARK ; NPC ID
	db 0 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $00 ; ?
	db MUSIC_STOP ; duel theme
	db $00 ; ?
	db $00 ; ?

	db AARONS_STEP1_DECK_ID
	tx Text0433 ; deck name
	tx Text0432 ; opponent name
	db NPC_AARON ; NPC ID
	db PRIZES_4 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $00 ; ?
	db MUSIC_DUELTHEME_1 ; duel theme
	db $12 ; ?
	db $00 ; ?

	db AARON_PRACTICE_DECK2_ID
	tx Text04b0 ; deck name
	tx Text04f6 ; opponent name
	db NPC_MARK ; NPC ID
	db 0 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $00 ; ?
	db MUSIC_STOP ; duel theme
	db $00 ; ?
	db $00 ; ?

	db AARONS_STEP2_DECK_ID
	tx Text0434 ; deck name
	tx Text0432 ; opponent name
	db NPC_AARON ; NPC ID
	db PRIZES_4 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $00 ; ?
	db MUSIC_DUELTHEME_1 ; duel theme
	db $12 ; ?
	db $00 ; ?

	db AARON_PRACTICE_DECK3_ID
	tx Text04b1 ; deck name
	tx Text04f6 ; opponent name
	db NPC_MARK ; NPC ID
	db 0 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $00 ; ?
	db MUSIC_STOP ; duel theme
	db $00 ; ?
	db $00 ; ?

	db AARONS_STEP3_DECK_ID
	tx Text0435 ; deck name
	tx Text0432 ; opponent name
	db NPC_AARON ; NPC ID
	db PRIZES_4 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $00 ; ?
	db MUSIC_DUELTHEME_1 ; duel theme
	db $12 ; ?
	db $00 ; ?

	db BRICK_WALK_DECK_ID
	tx Text043e ; deck name
	tx Text0432 ; opponent name
	db NPC_AARON ; NPC ID
	db PRIZES_4 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $00 ; ?
	db MUSIC_DUELTHEME_1 ; duel theme
	db $12 ; ?
	db $00 ; ?

	db BENCH_TRAP_DECK_ID
	tx Text044b ; deck name
	tx Text0432 ; opponent name
	db NPC_AARON ; NPC ID
	db PRIZES_4 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $00 ; ?
	db MUSIC_DUELTHEME_1 ; duel theme
	db $12 ; ?
	db $00 ; ?

	db SKY_SPARK_DECK_ID
	tx Text049d ; deck name
	tx Text04a3 ; opponent name
	db NPC_ISAAC ; NPC ID
	db PRIZES_6 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $00 ; ?
	db MUSIC_DUELTHEME_2 ; duel theme
	db $09 ; ?
	db $05 ; ?

	db ELECTRIC_SELFDESTRUCT_DECK_ID
	tx Text04c1 ; deck name
	tx Text04a3 ; opponent name
	db NPC_ISAAC ; NPC ID
	db PRIZES_6 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $00 ; ?
	db MUSIC_DUELTHEME_2 ; duel theme
	db $09 ; ?
	db $05 ; ?

	db OVERFLOW_DECK_ID
	tx Text0481 ; deck name
	tx Text04a0 ; opponent name
	db NPC_NICHOLAS ; NPC ID
	db PRIZES_4 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $00 ; ?
	db MUSIC_DUELTHEME_1 ; duel theme
	db $01 ; ?
	db $00 ; ?

	db TRIPLE_ZAPDOS_DECK_ID
	tx Text04ad ; deck name
	tx Text04a0 ; opponent name
	db NPC_NICHOLAS ; NPC ID
	db PRIZES_4 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $00 ; ?
	db MUSIC_DUELTHEME_1 ; duel theme
	db $01 ; ?
	db $05 ; ?

	db I_LOVE_PIKACHU_DECK_ID
	tx Text04c4 ; deck name
	tx Text04e4 ; opponent name
	db NPC_JENNIFER ; NPC ID
	db PRIZES_4 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $00 ; ?
	db MUSIC_DUELTHEME_1 ; duel theme
	db $01 ; ?
	db $00 ; ?

	db TEN_THOUSAND_VOLTS_DECK_ID
	tx Text0426 ; deck name
	tx Text04aa ; opponent name
	db NPC_BRANDON ; NPC ID
	db PRIZES_4 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $00 ; ?
	db MUSIC_DUELTHEME_1 ; duel theme
	db $01 ; ?
	db $00 ; ?

	db HAND_OVER_GR_DECK_ID
	tx Text0471 ; deck name
	tx Text04d4 ; opponent name
	db NPC_MURRAY ; NPC ID
	db PRIZES_6 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $00 ; ?
	db MUSIC_DUELTHEME_2 ; duel theme
	db $0a ; ?
	db $06 ; ?

	db PSYCHIC_ELITE_DECK_ID
	tx Text0453 ; deck name
	tx Text04d4 ; opponent name
	db NPC_MURRAY ; NPC ID
	db PRIZES_6 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $00 ; ?
	db MUSIC_DUELTHEME_2 ; duel theme
	db $0a ; ?
	db $06 ; ?

	db PSYCHOKINESIS_DECK_ID
	tx Text0496 ; deck name
	tx Text04ec ; opponent name
	db NPC_STEPHANIE ; NPC ID
	db PRIZES_4 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $00 ; ?
	db MUSIC_DUELTHEME_1 ; duel theme
	db $02 ; ?
	db $00 ; ?

	db PHANTOM_DECK_ID
	tx Text046e ; deck name
	tx Text04bd ; opponent name
	db NPC_ROBERT ; NPC ID
	db PRIZES_4 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $00 ; ?
	db MUSIC_DUELTHEME_1 ; duel theme
	db $02 ; ?
	db $00 ; ?

	db PUPPET_MASTER_DECK_ID
	tx Text045f ; deck name
	tx Text0491 ; opponent name
	db NPC_DANIEL ; NPC ID
	db PRIZES_4 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $00 ; ?
	db MUSIC_DUELTHEME_1 ; duel theme
	db $02 ; ?
	db $00 ; ?

	db EVEN3_YEARS_ON_A_ROCK_DECK_ID
	tx Text0438 ; deck name
	tx Text0493 ; opponent name
	db NPC_GENE ; NPC ID
	db PRIZES_6 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $00 ; ?
	db MUSIC_DUELTHEME_2 ; duel theme
	db $0b ; ?
	db $07 ; ?

	db ROLLING_STONE_DECK_ID
	tx Text04f3 ; deck name
	tx Text04de ; opponent name
	db NPC_MATTHEW ; NPC ID
	db PRIZES_4 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $00 ; ?
	db MUSIC_DUELTHEME_1 ; duel theme
	db $03 ; ?
	db $00 ; ?

	db GREAT_EARTHQUAKE_DECK_ID
	tx Text044f ; deck name
	tx Text04b8 ; opponent name
	db NPC_RYAN ; NPC ID
	db PRIZES_4 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $00 ; ?
	db MUSIC_DUELTHEME_1 ; duel theme
	db $03 ; ?
	db $00 ; ?

	db AWESOME_FOSSIL_DECK_ID
	tx Text0498 ; deck name
	tx Text049c ; opponent name
	db NPC_ANDREW ; NPC ID
	db PRIZES_4 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $00 ; ?
	db MUSIC_DUELTHEME_1 ; duel theme
	db $03 ; ?
	db $00 ; ?

	db RAGING_BILLOW_OF_FISTS_DECK_ID
	tx Text04b2 ; deck name
	tx Text04e0 ; opponent name
	db NPC_MITCH ; NPC ID
	db PRIZES_6 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $00 ; ?
	db MUSIC_DUELTHEME_2 ; duel theme
	db $0c ; ?
	db $0c ; ?

	db YOU_CAN_DO_IT_MACHOP_DECK_ID
	tx Text0440 ; deck name
	tx Text04ce ; opponent name
	db NPC_MICHAEL ; NPC ID
	db PRIZES_4 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $00 ; ?
	db MUSIC_DUELTHEME_1 ; duel theme
	db $04 ; ?
	db $00 ; ?

	db NEW_MACHOKE_DECK_ID
	tx Text04b7 ; deck name
	tx Text04ce ; opponent name
	db NPC_MICHAEL ; NPC ID
	db PRIZES_4 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $00 ; ?
	db MUSIC_DUELTHEME_1 ; duel theme
	db $04 ; ?
	db $00 ; ?

	db SKILLED_WARRIOR_DECK_ID
	tx Text046a ; deck name
	tx Text04a5 ; opponent name
	db NPC_CHRIS ; NPC ID
	db PRIZES_4 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $00 ; ?
	db MUSIC_DUELTHEME_1 ; duel theme
	db $04 ; ?
	db $00 ; ?

	db I_LOVE_TO_FIGHT_DECK_ID
	tx Text04bb ; deck name
	tx Text04b5 ; opponent name
	db NPC_JESSICA ; NPC ID
	db PRIZES_4 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $00 ; ?
	db MUSIC_DUELTHEME_1 ; duel theme
	db $04 ; ?
	db $00 ; ?

	db MAX_ENERGY_DECK_ID
	tx Text042c ; deck name
	tx Text0489 ; opponent name
	db NPC_NIKKI ; NPC ID
	db PRIZES_6 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $00 ; ?
	db MUSIC_DUELTHEME_2 ; duel theme
	db $0d ; ?
	db $02 ; ?

	db REMAINING_GREEN_DECK_ID
	tx Text0461 ; deck name
	tx Text0475 ; opponent name
	db NPC_BRITTANY ; NPC ID
	db PRIZES_4 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $00 ; ?
	db MUSIC_DUELTHEME_1 ; duel theme
	db $05 ; ?
	db $00 ; ?

	db POISON_CURSE_DECK_ID
	tx Text045d ; deck name
	tx Text0475 ; opponent name
	db NPC_BRITTANY ; NPC ID
	db PRIZES_4 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $00 ; ?
	db MUSIC_DUELTHEME_1 ; duel theme
	db $05 ; ?
	db $02 ; ?

	db GLITTERING_SCALES_DECK_ID
	tx Text043c ; deck name
	tx Text04b9 ; opponent name
	db NPC_KRISTIN ; NPC ID
	db PRIZES_4 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $00 ; ?
	db MUSIC_DUELTHEME_1 ; duel theme
	db $05 ; ?
	db $00 ; ?

	db STEADY_INCREASE_DECK_ID
	tx Text04b3 ; deck name
	tx Text04d7 ; opponent name
	db NPC_HEATHER ; NPC ID
	db PRIZES_4 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $00 ; ?
	db MUSIC_DUELTHEME_1 ; duel theme
	db $05 ; ?
	db $00 ; ?

	db DARK_SCIENCE_DECK_ID
	tx Text04a6 ; deck name
	tx Text048a ; opponent name
	db NPC_RICK ; NPC ID
	db PRIZES_6 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $00 ; ?
	db MUSIC_DUELTHEME_2 ; duel theme
	db $0e ; ?
	db $08 ; ?

	db NATURAL_SCIENCE_DECK_ID
	tx Text044a ; deck name
	tx Text04df ; opponent name
	db NPC_DAVID ; NPC ID
	db PRIZES_4 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $00 ; ?
	db MUSIC_DUELTHEME_1 ; duel theme
	db $06 ; ?
	db $00 ; ?

	db POISONOUS_SWAMP_DECK_ID
	tx Text045b ; deck name
	tx Text04a1 ; opponent name
	db NPC_JOSEPH ; NPC ID
	db PRIZES_4 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $00 ; ?
	db MUSIC_DUELTHEME_1 ; duel theme
	db $06 ; ?
	db $00 ; ?

	db GATHERING_NIDORAN_DECK_ID
	tx Text042f ; deck name
	tx Text04cc ; opponent name
	db NPC_ERIK ; NPC ID
	db PRIZES_4 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $00 ; ?
	db MUSIC_DUELTHEME_1 ; duel theme
	db $06 ; ?
	db $00 ; ?

	db RAIN_DANCE_CONFUSION_DECK_ID
	tx Text0431 ; deck name
	tx Text047d ; opponent name
	db NPC_AMY ; NPC ID
	db PRIZES_6 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $00 ; ?
	db MUSIC_DUELTHEME_2 ; duel theme
	db $0f ; ?
	db $04 ; ?

	db CONSERVING_WATER_DECK_ID
	tx Text0460 ; deck name
	tx Text049a ; opponent name
	db NPC_JOSHUA ; NPC ID
	db PRIZES_4 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $00 ; ?
	db MUSIC_DUELTHEME_1 ; duel theme
	db $07 ; ?
	db $00 ; ?

	db ENERGY_REMOVAL_DECK_ID
	tx Text0480 ; deck name
	tx Text049a ; opponent name
	db NPC_JOSHUA ; NPC ID
	db PRIZES_4 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $00 ; ?
	db MUSIC_DUELTHEME_1 ; duel theme
	db $07 ; ?
	db $04 ; ?

	db SPLASHING_ABOUT_DECK_ID
	tx Text0467 ; deck name
	tx Text04d3 ; opponent name
	db NPC_SARA ; NPC ID
	db PRIZES_4 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $00 ; ?
	db MUSIC_DUELTHEME_1 ; duel theme
	db $07 ; ?
	db $00 ; ?

	db BEACH_DECK_ID
	tx Text045e ; deck name
	tx Text04dc ; opponent name
	db NPC_AMANDA ; NPC ID
	db PRIZES_4 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $00 ; ?
	db MUSIC_DUELTHEME_1 ; duel theme
	db $07 ; ?
	db $00 ; ?

	db GO_ARCANINE_DECK_ID
	tx Text046f ; deck name
	tx Text0474 ; opponent name
	db NPC_KEN ; NPC ID
	db PRIZES_6 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $00 ; ?
	db MUSIC_DUELTHEME_2 ; duel theme
	db $10 ; ?
	db $03 ; ?

	db FLAME_FESTIVAL_DECK_ID
	tx Text0465 ; deck name
	tx Text04a2 ; opponent name
	db NPC_JOHN ; NPC ID
	db PRIZES_4 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $00 ; ?
	db MUSIC_DUELTHEME_1 ; duel theme
	db $08 ; ?
	db $00 ; ?

	db IMMORTAL_FLAME_DECK_ID
	tx Text0463 ; deck name
	tx Text04cd ; opponent name
	db NPC_JONATHAN ; NPC ID
	db PRIZES_4 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $00 ; ?
	db MUSIC_DUELTHEME_1 ; duel theme
	db $08 ; ?
	db $00 ; ?

	db ELECTRIC_CURRENT_SHOCK_DECK_ID
	tx Text0459 ; deck name
	tx Text04f5 ; opponent name
	db NPC_ADAM ; NPC ID
	db PRIZES_4 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $00 ; ?
	db MUSIC_DUELTHEME_1 ; duel theme
	db $08 ; ?
	db $00 ; ?

	db GREAT_ROCKET4_DECK_ID
	tx Text0490 ; deck name
	tx Text042a ; opponent name
	db NPC_GR_4 ; NPC ID
	db PRIZES_6 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $00 ; ?
	db MUSIC_GRDUELTHEME_1 ; duel theme
	db $16 ; ?
	db $01 ; ?

	db GREAT_ROCKET1_DECK_ID
	tx Text048d ; deck name
	tx Text0427 ; opponent name
	db NPC_GR_1 ; NPC ID
	db PRIZES_6 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $00 ; ?
	db MUSIC_GRDUELTHEME_1 ; duel theme
	db $16 ; ?
	db $01 ; ?

	db GREAT_ROCKET2_DECK_ID
	tx Text048e ; deck name
	tx Text0428 ; opponent name
	db NPC_GR_2 ; NPC ID
	db PRIZES_6 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $00 ; ?
	db MUSIC_GRDUELTHEME_1 ; duel theme
	db $16 ; ?
	db $01 ; ?

	db GREAT_ROCKET3_DECK_ID
	tx Text048f ; deck name
	tx Text0429 ; opponent name
	db NPC_GR_3 ; NPC ID
	db PRIZES_6 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $00 ; ?
	db MUSIC_GRDUELTHEME_1 ; duel theme
	db $16 ; ?
	db $01 ; ?

	db GRAND_FIRE_DECK_ID
	tx Text048b ; deck name
	tx Text04be ; opponent name
	db NPC_COURTNEY ; NPC ID
	db PRIZES_6 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $00 ; ?
	db MUSIC_DUELTHEME_3 ; duel theme
	db $11 ; ?
	db $03 ; ?

	db LEGENDARY_FOSSIL_DECK_ID
	tx Text0458 ; deck name
	tx Text049e ; opponent name
	db NPC_STEVE ; NPC ID
	db PRIZES_6 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $00 ; ?
	db MUSIC_DUELTHEME_3 ; duel theme
	db $11 ; ?
	db $05 ; ?

	db WATER_LEGEND_DECK_ID
	tx Text047c ; deck name
	tx Text0482 ; opponent name
	db NPC_JACK ; NPC ID
	db PRIZES_6 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $00 ; ?
	db MUSIC_DUELTHEME_3 ; duel theme
	db $11 ; ?
	db $04 ; ?

	db GREAT_DRAGON_DECK_ID
	tx Text0450 ; deck name
	tx Text04ed ; opponent name
	db NPC_ROD ; NPC ID
	db PRIZES_6 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $00 ; ?
	db MUSIC_DUELTHEME_3 ; duel theme
	db $11 ; ?
	db $00 ; ?

	db BUG_COLLECTING_DECK_ID
	tx Text0447 ; deck name
	tx Text04d8 ; opponent name
	db NPC_MIDORI ; NPC ID
	db PRIZES_4 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $00 ; ?
	db MUSIC_GRDUELTHEME_1 ; duel theme
	db $17 ; ?
	db $01 ; ?

	db DEMONIC_FOREST_DECK_ID
	tx Text042e ; deck name
	tx Text04e3 ; opponent name
	db NPC_YUUTA ; NPC ID
	db PRIZES_4 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $00 ; ?
	db MUSIC_GRDUELTHEME_1 ; duel theme
	db $17 ; ?
	db $01 ; ?

	db STICKY_POISON_GAS_DECK_ID
	tx Text045c ; deck name
	tx Text04da ; opponent name
	db NPC_MIYUKI ; NPC ID
	db PRIZES_4 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $01 ; ?
	db MUSIC_GRDUELTHEME_1 ; duel theme
	db $17 ; ?
	db $01 ; ?

	db MAD_PETALS_DECK_ID
	tx Text0445 ; deck name
	tx Text04dd ; opponent name
	db NPC_MORINO ; NPC ID
	db PRIZES_6 ; number of prize cards
	db $01 ; special duel rules
	db $00 ; ?
	db MUSIC_GRDUELTHEME_2 ; duel theme
	db $1d ; ?
	db $08 ; ?

	db DANGEROUS_BENCH_DECK_ID
	tx Text0441 ; deck name
	tx Text04a4 ; opponent name
	db NPC_TAP ; NPC ID
	db PRIZES_4 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $00 ; ?
	db MUSIC_DUELTHEME_1 ; duel theme
	db $26 ; ?
	db $00 ; ?

	db CHAIN_LIGHTNING_BY_PIKACHU_DECK_ID
	tx Text04c5 ; deck name
	tx Text04f2 ; opponent name
	db NPC_RENNA ; NPC ID
	db PRIZES_4 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $07 ; ?
	db MUSIC_GRDUELTHEME_1 ; duel theme
	db $18 ; ?
	db $01 ; ?

	db THIS_IS_THE_POWER_OF_ELECTRICITY_DECK_ID
	tx Text0456 ; deck name
	tx Text0479 ; opponent name
	db NPC_ICHIKAWA ; NPC ID
	db PRIZES_4 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $02 ; ?
	db MUSIC_GRDUELTHEME_1 ; duel theme
	db $18 ; ?
	db $01 ; ?

	db QUICK_ATTACK_DECK_ID
	tx Text0457 ; deck name
	tx Text0487 ; opponent name
	db NPC_CATHERINE ; NPC ID
	db PRIZES_6 ; number of prize cards
	db $02 ; special duel rules
	db $00 ; ?
	db MUSIC_GRDUELTHEME_2 ; duel theme
	db $1e ; ?
	db $09 ; ?

	db COMPLETE_COMBUSTION_DECK_ID
	tx Text043f ; deck name
	tx Text049b ; opponent name
	db NPC_JES ; NPC ID
	db PRIZES_4 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $00 ; ?
	db MUSIC_GRDUELTHEME_1 ; duel theme
	db $19 ; ?
	db $01 ; ?

	db FIREBALL_DECK_ID
	tx Text04c6 ; deck name
	tx Text04e2 ; opponent name
	db NPC_YUKI ; NPC ID
	db PRIZES_4 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $03 ; ?
	db MUSIC_GRDUELTHEME_1 ; duel theme
	db $19 ; ?
	db $01 ; ?

	db EEVEE_SHOWDOWN_DECK_ID
	tx Text0477 ; deck name
	tx Text0499 ; opponent name
	db NPC_SHOKO ; NPC ID
	db PRIZES_4 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $08 ; ?
	db MUSIC_GRDUELTHEME_1 ; duel theme
	db $19 ; ?
	db $01 ; ?

	db GAZE_UPON_THE_POWER_OF_FIRE_DECK_ID
	tx Text0468 ; deck name
	tx Text04bc ; opponent name
	db NPC_HIDERO ; NPC ID
	db PRIZES_6 ; number of prize cards
	db $03 ; special duel rules
	db $00 ; ?
	db MUSIC_GRDUELTHEME_2 ; duel theme
	db $1f ; ?
	db $0a ; ?

	db WHIRLPOOL_SHOWER_DECK_ID
	tx Text0439 ; deck name
	tx Text04d9 ; opponent name
	db NPC_MIYAJIMA ; NPC ID
	db PRIZES_4 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $04 ; ?
	db MUSIC_GRDUELTHEME_1 ; duel theme
	db $1a ; ?
	db $01 ; ?

	db PARALYZED_PARALYZED_DECK_ID
	tx Text04d1 ; deck name
	tx Text049f ; opponent name
	db NPC_SENTA ; NPC ID
	db PRIZES_4 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $09 ; ?
	db MUSIC_GRDUELTHEME_1 ; duel theme
	db $1a ; ?
	db $01 ; ?

	db BENCH_CALL_DECK_ID
	tx Text04c7 ; deck name
	tx Text0473 ; opponent name
	db NPC_AIRA ; NPC ID
	db PRIZES_4 ; number of prize cards
	db $04 ; special duel rules
	db $00 ; ?
	db MUSIC_GRDUELTHEME_1 ; duel theme
	db $1a ; ?
	db $01 ; ?

	db WATER_STREAM_DECK_ID
	tx Text047b ; deck name
	tx Text0483 ; opponent name
	db NPC_KANOKO ; NPC ID
	db PRIZES_6 ; number of prize cards
	db $05 ; special duel rules
	db $00 ; ?
	db MUSIC_GRDUELTHEME_2 ; duel theme
	db $20 ; ?
	db $0b ; ?

	db ROCK_BLAST_DECK_ID
	tx Text04f4 ; deck name
	tx Text0494 ; opponent name
	db NPC_GODA ; NPC ID
	db PRIZES_4 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $0c ; ?
	db MUSIC_GRDUELTHEME_1 ; duel theme
	db $1b ; ?
	db $01 ; ?

	db FULL_STRENGTH_DECK_ID
	tx Text0451 ; deck name
	tx Text048c ; opponent name
	db NPC_GRACE ; NPC ID
	db PRIZES_4 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $05 ; ?
	db MUSIC_GRDUELTHEME_1 ; duel theme
	db $1b ; ?
	db $01 ; ?

	db RUNNING_WILD_DECK_ID
	tx Text0430 ; deck name
	tx Text0485 ; opponent name
	db NPC_KAMIYA ; NPC ID
	db PRIZES_6 ; number of prize cards
	db $06 ; special duel rules
	db $00 ; ?
	db MUSIC_GRDUELTHEME_2 ; duel theme
	db $21 ; ?
	db $0c ; ?

	db DIRECT_HIT_DECK_ID
	tx Text0454 ; deck name
	tx Text04db ; opponent name
	db NPC_MIWA ; NPC ID
	db PRIZES_4 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $06 ; ?
	db MUSIC_GRDUELTHEME_1 ; duel theme
	db $1c ; ?
	db $01 ; ?

	db SUPERDESTRUCTIVE_POWER_DECK_ID
	tx Text0452 ; deck name
	tx Text0492 ; opponent name
	db NPC_KEVIN ; NPC ID
	db PRIZES_4 ; number of prize cards
	db $07 ; special duel rules
	db $00 ; ?
	db MUSIC_GRDUELTHEME_1 ; duel theme
	db $1c ; ?
	db $01 ; ?

	db BAD_DREAM_DECK_ID
	tx Text04ba ; deck name
	tx Text04e5 ; opponent name
	db NPC_YOSUKE ; NPC ID
	db PRIZES_4 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $0a ; ?
	db MUSIC_GRDUELTHEME_1 ; duel theme
	db $1c ; ?
	db $01 ; ?

	db POKEMON_POWER_DECK_ID
	tx Text04cb ; deck name
	tx Text04ee ; opponent name
	db NPC_RYOKO ; NPC ID
	db PRIZES_4 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $0d ; ?
	db MUSIC_GRDUELTHEME_1 ; duel theme
	db $1c ; ?
	db $01 ; ?

	db SPIRITED_AWAY_DECK_ID
	tx Text043d ; deck name
	tx Text04d2 ; opponent name
	db NPC_MAMI ; NPC ID
	db PRIZES_6 ; number of prize cards
	db $08 ; special duel rules
	db $00 ; ?
	db MUSIC_GRDUELTHEME_2 ; duel theme
	db $22 ; ?
	db $0d ; ?

	db SNORLAX_GUARD_DECK_ID
	tx Text0484 ; deck name
	tx Text04b6 ; opponent name
	db NPC_NISHIJIMA ; NPC ID
	db PRIZES_6 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $0e ; ?
	db MUSIC_GRDUELTHEME_2 ; duel theme
	db $23 ; ?
	db $0e ; ?

	db EYE_OF_THE_STORM_DECK_ID
	tx Text044c ; deck name
	tx Text0478 ; opponent name
	db NPC_ISHII ; NPC ID
	db PRIZES_6 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $0f ; ?
	db MUSIC_GRDUELTHEME_2 ; duel theme
	db $23 ; ?
	db $0e ; ?

	db SUDDEN_GROWTH_DECK_ID
	tx Text0443 ; deck name
	tx Text0497 ; opponent name
	db NPC_SAMEJIMA ; NPC ID
	db PRIZES_6 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $10 ; ?
	db MUSIC_GRDUELTHEME_2 ; duel theme
	db $23 ; ?
	db $0e ; ?

	db VERY_RARE_CARD_DECK_ID
	tx Text045a ; deck name
	tx Text042d ; opponent name
	db NPC_ISHIHARA ; NPC ID
	db PRIZES_6 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $00 ; ?
	db MUSIC_ISHIHARA ; duel theme
	db $14 ; ?
	db $13 ; ?

	db BAD_GUYS_DECK_ID
	tx Text0472 ; deck name
	tx Text0486 ; opponent name
	db NPC_KANZAKI ; NPC ID
	db PRIZES_6 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $0b ; ?
	db MUSIC_GRDUELTHEME_2 ; duel theme
	db $24 ; ?
	db $11 ; ?

	db POISON_MIST_DECK_ID
	tx Text04ca ; deck name
	tx Text04f0 ; opponent name
	db NPC_RUI ; NPC ID
	db PRIZES_6 ; number of prize cards
	db $09 ; special duel rules
	db $00 ; ?
	db MUSIC_GRDUELTHEME_2 ; duel theme
	db $24 ; ?
	db $12 ; ?

	db ULTRA_REMOVAL_DECK_ID
	tx Text047e ; deck name
	tx Text04f0 ; opponent name
	db NPC_RUI ; NPC ID
	db PRIZES_6 ; number of prize cards
	db $0a ; special duel rules
	db $00 ; ?
	db MUSIC_GRDUELTHEME_2 ; duel theme
	db $24 ; ?
	db $13 ; ?

	db PSYCHIC_BATTLE_DECK_ID
	tx Text0495 ; deck name
	tx Text04f0 ; opponent name
	db NPC_RUI ; NPC ID
	db PRIZES_6 ; number of prize cards
	db $07 ; special duel rules
	db $00 ; ?
	db MUSIC_GRDUELTHEME_2 ; duel theme
	db $24 ; ?
	db $15 ; ?

	db STOP_LIFE_DECK_ID
	tx Text0437 ; deck name
	tx Text04c2 ; opponent name
	db NPC_BIRURITCHI ; NPC ID
	db PRIZES_6 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $00 ; ?
	db MUSIC_GRDUELTHEME_3 ; duel theme
	db $25 ; ?
	db $0f ; ?

	db SCORCHER_DECK_ID
	tx Text046d ; deck name
	tx Text04c2 ; opponent name
	db NPC_BIRURITCHI ; NPC ID
	db PRIZES_6 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $00 ; ?
	db MUSIC_GRDUELTHEME_3 ; duel theme
	db $25 ; ?
	db $0f ; ?

	db TSUNAMI_STARTER_DECK_ID
	tx Text044e ; deck name
	tx Text04c2 ; opponent name
	db NPC_BIRURITCHI ; NPC ID
	db PRIZES_6 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $00 ; ?
	db MUSIC_GRDUELTHEME_3 ; duel theme
	db $25 ; ?
	db $0f ; ?

	db SMASH_TO_MINCEMEAT_DECK_ID
	tx Text0455 ; deck name
	tx Text04c2 ; opponent name
	db NPC_BIRURITCHI ; NPC ID
	db PRIZES_6 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $00 ; ?
	db MUSIC_GRDUELTHEME_3 ; duel theme
	db $25 ; ?
	db $0f ; ?

	db TEST_YOUR_LUCK_DECK_ID
	tx Text043a ; deck name
	tx Text04c8 ; opponent name
	db NPC_PAWN ; NPC ID
	db PRIZES_4 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $00 ; ?
	db MUSIC_DUELTHEME_1 ; duel theme
	db $27 ; ?
	db $13 ; ?

	db PROTOHISTORIC_DECK_ID
	tx Text0446 ; deck name
	tx Text04b4 ; opponent name
	db NPC_KNIGHT ; NPC ID
	db PRIZES_4 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $00 ; ?
	db MUSIC_DUELTHEME_2 ; duel theme
	db $27 ; ?
	db $13 ; ?

	db TEXTURE_TUNER7_DECK_ID
	tx Text04a8 ; deck name
	tx Text04bf ; opponent name
	db NPC_BISHOP ; NPC ID
	db PRIZES_4 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $00 ; ?
	db MUSIC_GRDUELTHEME_1 ; duel theme
	db $27 ; ?
	db $13 ; ?

	db COLORLESS_ENERGY_DECK_ID
	tx Text046b ; deck name
	tx Text04ef ; opponent name
	db NPC_ROOK ; NPC ID
	db PRIZES_5 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $00 ; ?
	db MUSIC_GRDUELTHEME_1 ; duel theme
	db $27 ; ?
	db $13 ; ?

	db POWERFUL_POKEMON_DECK_ID
	tx Text0444 ; deck name
	tx Text0488 ; opponent name
	db NPC_QUEEN ; NPC ID
	db PRIZES_6 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $00 ; ?
	db MUSIC_GRDUELTHEME_2 ; duel theme
	db $27 ; ?
	db $13 ; ?

	db WEIRD_DECK_ID
	tx Text0464 ; deck name
	tx Text047a ; opponent name
	db NPC_IMAKUNI_BLACK ; NPC ID
	db PRIZES_6 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $00 ; ?
	db MUSIC_IMAKUNI ; duel theme
	db $13 ; ?
	db $0b ; ?

	db STRANGE_DECK_ID
	tx Text0442 ; deck name
	tx Text047a ; opponent name
	db NPC_IMAKUNI_RED ; NPC ID
	db PRIZES_6 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $00 ; ?
	db MUSIC_IMAKUNI2 ; duel theme
	db $13 ; ?
	db $13 ; ?

	db RONALDS_UNCOOL_DECK_ID
	tx Text04e8 ; deck name
	tx Text04e6 ; opponent name
	db NPC_RONALD ; NPC ID
	db PRIZES_6 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $00 ; ?
	db MUSIC_RONALD ; duel theme
	db $15 ; ?
	db $16 ; ?

	db RONALDS_GRX_DECK_ID
	tx Text04e7 ; deck name
	tx Text042b ; opponent name
	db NPC_GR_X ; NPC ID
	db PRIZES_6 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $00 ; ?
	db MUSIC_RONALD ; duel theme
	db $16 ; ?
	db $16 ; ?

	db RONALDS_POWER_DECK_ID
	tx Text04eb ; deck name
	tx Text04e6 ; opponent name
	db NPC_RONALD ; NPC ID
	db PRIZES_6 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $00 ; ?
	db MUSIC_RONALD ; duel theme
	db $15 ; ?
	db $16 ; ?

	db RONALDS_PSYCHIC_DECK_ID
	tx Text04ea ; deck name
	tx Text04e6 ; opponent name
	db NPC_RONALD ; NPC ID
	db PRIZES_6 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $00 ; ?
	db MUSIC_RONALD ; duel theme
	db $15 ; ?
	db $16 ; ?

	db RONALDS_ULTRA_DECK_ID
	tx Text04e9 ; deck name
	tx Text04e6 ; opponent name
	db NPC_RONALD ; NPC ID
	db PRIZES_6 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $00 ; ?
	db MUSIC_RONALD ; duel theme
	db $15 ; ?
	db $16 ; ?

	db EVERYBODYS_FRIEND_DECK_ID
	tx Text0469 ; deck name
	tx Text047f ; opponent name
	db NPC_EIJI ; NPC ID
	db PRIZES_6 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $00 ; ?
	db MUSIC_GRDUELTHEME_2 ; duel theme
	db $28 ; ?
	db $17 ; ?

	db IMMORTAL_POKEMON_DECK_ID
	tx Text0462 ; deck name
	tx Text04cf ; opponent name
	db NPC_MAGICIAN ; NPC ID
	db PRIZES_6 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $00 ; ?
	db MUSIC_GRDUELTHEME_2 ; duel theme
	db $28 ; ?
	db $17 ; ?

	db TORRENTIAL_FLOOD_DECK_ID
	tx Text043b ; deck name
	tx Text04e1 ; opponent name
	db NPC_YUI ; NPC ID
	db PRIZES_6 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $00 ; ?
	db MUSIC_GRDUELTHEME_2 ; duel theme
	db $28 ; ?
	db $17 ; ?

	db TRAINER_IMPRISON_DECK_ID
	tx Text04ae ; deck name
	tx Text04ab ; opponent name
	db NPC_TOSHIRON ; NPC ID
	db PRIZES_6 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $00 ; ?
	db MUSIC_GRDUELTHEME_2 ; duel theme
	db $28 ; ?
	db $17 ; ?

	db BLAZING_FLAME_DECK_ID
	tx Text046c ; deck name
	tx Text04c3 ; opponent name
	db NPC_PIERROT ; NPC ID
	db PRIZES_6 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $00 ; ?
	db MUSIC_GRDUELTHEME_2 ; duel theme
	db $28 ; ?
	db $17 ; ?

	db DAMAGE_CHAOS_DECK_ID
	tx Text04a7 ; deck name
	tx Text0476 ; opponent name
	db NPC_ANNA ; NPC ID
	db PRIZES_6 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $00 ; ?
	db MUSIC_GRDUELTHEME_2 ; duel theme
	db $28 ; ?
	db $17 ; ?

	db BIG_THUNDER_DECK_ID
	tx Text04c0 ; deck name
	tx Text04a9 ; opponent name
	db NPC_DEE ; NPC ID
	db PRIZES_6 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $00 ; ?
	db MUSIC_GRDUELTHEME_2 ; duel theme
	db $28 ; ?
	db $17 ; ?

	db POWER_OF_DARKNESS_DECK_ID
	tx Text0436 ; deck name
	tx Text04d0 ; opponent name
	db NPC_MASQUERADE ; NPC ID
	db PRIZES_6 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $00 ; ?
	db MUSIC_GRDUELTHEME_2 ; duel theme
	db $28 ; ?
	db $17 ; ?

	db POISON_STORM_DECK_ID
	tx Text04c9 ; deck name
	tx Text04ac ; opponent name
	db NPC_TOBI_CHAN ; NPC ID
	db PRIZES_6 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $00 ; ?
	db MUSIC_GRDUELTHEME_2 ; duel theme
	db $28 ; ?
	db $17 ; ?

	db $ff ; end
