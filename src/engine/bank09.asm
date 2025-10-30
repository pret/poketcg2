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
	ldtx hl, OpponentsTurnWaitingMenuHandCheckText
	call DrawWideTextBox_PrintTextNoDelay
	call .InitTextBoxMenu
.loop_inner
	call DoFrame
	call .HandleInput
	call RefreshMenuCursor
	ldh a, [hKeysPressed]
	bit B_PAD_A, a
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
	bit B_PAD_B, a
	ret nz
	and PAD_LEFT | PAD_RIGHT
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
	ldtx hl, UsedText
	bank1call DisplayCardDetailScreen
	ret

; print the AttachedEnergyToPokemonText, given the energy card to attach in hTempCardIndex_ff98,
; and the PLAY_AREA_* of the turn holder's Pokemon to attach the energy to in hTempPlayAreaLocation_ff9d
PrintAttachedEnergyToPokemon:
	ldh a, [hTempPlayAreaLocation_ff9d]
	add DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call LoadCardNameToTxRam2_b
	ldh a, [hTempCardIndex_ff98]
	call LoadCardNameToTxRam2
	ldtx hl, AttachedEnergyToPokemonText
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
	ldtx hl, PokemonEvolvedIntoPokemonText
	call DrawWideTextBox_WaitForInput
	ret

DoAIOpponentTurn:
	xor a
	ld [wVBlankCounter], a
	ld [wSkipDuelistIsThinkingDelay], a
	ldtx hl, DuelistIsThinkingText
	call DrawWideTextBox_PrintTextNoDelay
	call AIDoAction_Turn
	ld a, $ff
	ld [wPlayerAttackingCardIndex], a
	ld [wPlayerAttackingAttackIndex], a
	ret

; related to AI taking their turn in a duel
; called multiple times during one AI turn
; each call results in the execution of an OppActionTable function
AIMakeDecision:
	ldh [hOppActionTableIndex], a
	ld hl, wSkipDuelistIsThinkingDelay
	ld a, [hl]
	ld [hl], $0
	or a
	jr nz, .skip_delay
.delay_loop
	call DoFrame
	ld a, [wVBlankCounter]
	cp 60
	jr c, .delay_loop

.skip_delay
	ldh a, [hOppActionTableIndex]
	ld hl, wOpponentTurnEnded
	ld [hl], 0
	ld hl, OppActionTable
	call JumpToFunctionInTable
	ld a, [wDuelFinished]
	ld hl, wOpponentTurnEnded
	or [hl]
	jr nz, .turn_ended
	ld a, [wSkipDuelistIsThinkingDelay]
	or a
	ret nz
	ld [wVBlankCounter], a
	ldtx hl, DuelistIsThinkingText
	call DrawWideTextBox_PrintTextNoDelay
	or a
	ret

.turn_ended
	scf
	ret

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
	ld hl, OppActionTable
	call JumpToFunctionInTable
	ld a, [wDuelFinished]
	ld hl, wOpponentTurnEnded
	or [hl]
	jr z, .link_opp_turn_loop
	ret

; actions for the opponent's turn
; on a link duel, this is referenced by DoLinkOpponentTurn in a loop (on each opponent's HandleTurn)
; on a non-link duel (vs AI opponent), this is referenced by AIMakeDecision
OppActionTable:
	dw DuelTransmissionError
	dw $4613
	dw $45f9
	dw $45d6
	dw $462f
	dw $45bf
	dw $4659
	dw $466b
	dw $4684
	dw $46ae
	dw $46c5
	dw $45b8
	dw $46fc
	dw $4725
	dw $4761
	dw $46e2
	dw $4828
	dw $4828
	dw $477f
	dw $4790
	dw $4828
	dw $479e
	dw $4770
	dw $477b
	dw $47d7
	dw $47e3
	dw $47ea
	dw $4805
	dw $4818
; 0x245b8

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
	call AIDoAction_UpdatePortrait

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
	ld a, [wOpponentPicID]
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
	ldtx hl, ShufflesTheDeckText
	ldtx de, Drew7CardsText
	jr PlayShuffleAndDrawCardsAnimation

PlayShuffleAndDrawCardsAnimation_BothDuelists:
	ld b, DUEL_ANIM_BOTH_SHUFFLE
	ld c, DUEL_ANIM_BOTH_DRAW
	ldtx hl, EachPlayerShuffleOpponentsDeckText
	ldtx de, EachPlayerDraw7CardsText
	ld a, [wcd17]
	or a
	jr z, PlayShuffleAndDrawCardsAnimation
	ldtx hl, PracticeDuelNoShufflesText
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
; 0x24958

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
	ldtx hl, DrawNoCardsFromTheDeckText
	call DrawWideTextBox_WaitForInput
	jr .done
.can_draw
	ld l, a
	ld h, 0
	call LoadTxRam3
	ldtx hl, DrawCardsFromTheDeckText
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
	call AIDoAction_UpdatePortrait
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

SECTION "Bank 9@4cd7", ROMX[$4cd7], BANK[$9]

; saves a to wCardSearchFunc and de to wCardSearchFuncParam
; input:
; - a = CARDSEARCH_* constant
; - de = parameter for card search function
SetCardSearchFuncParams:
	push hl
	ld [wCardSearchFunc], a
	ld hl, wCardSearchFuncParam
	ld [hl], e
	inc hl
	ld [hl], d
	pop hl
	ret

; runs the card search function loaded in wCardSearchFunc
; if the input card passes the predicate, then carry set is returned
; input:
; - a = card index
; - [wCardSearchFunc] = CARDSEARCH_* constant
; - wCardSearchFuncParam = parameter for func
; output:
; - carry set if input card passes all checks of the function
ExecuteCardSearchFunc:
	push hl
	push de
	push bc
	ld e, a
	ld a, [wCardSearchFunc]
	ld hl, .FuncTable
	call JumpToFunctionInTable
	pop bc
	pop de
	pop hl
	ret

.FuncTable:
	dw .SearchCardID                 ; CARDSEARCH_CARD_ID
	dw .SearchNidoran                ; CARDSEARCH_NIDORAN
	dw .SearchBasicFightingPkmn      ; CARDSEARCH_BASIC_FIGHTING_POKEMON
	dw .SearchBasicEnergy            ; CARDSEARCH_BASIC_ENERGY
	dw .SearchAnyEnergy              ; CARDSEARCH_ANY_ENERGY
	dw .SearchPokedexNumber          ; CARDSEARCH_POKEDEX_NUMBER
	dw .SearchDarkPkmn               ; CARDSEARCH_DARK_POKEMON
	dw .SearchPsychicEnergy          ; CARDSEARCH_PSYCHIC_ENERGY
	dw .SearchEvolutionPkmn          ; CARDSEARCH_EVOLUTION_POKEMON
	dw .Func_24df6                   ; CARDSEARCH_UNK_9
	dw .SearchTrainer                ; CARDSEARCH_TRAINER
	dw .SearchEvolutionColorlessPkmn ; CARDSEARCH_EVOLUTION_COLORLESS_POKEMON
	dw .SearchLightningEnergy        ; CARDSEARCH_LIGHTNING_ENERGY
	dw .Func_24df6                   ; CARDSEARCH_UNK_D
	dw .SearchBasicPkmn              ; CARDSEARCH_BASIC_POKEMON

.no_carry
	or a
	ret

; returns carry if input card has same card ID
; as wCardSearchFuncParam
.SearchCardID:
	ld a, e
	call GetCardIDFromDeckIndex
	ld hl, wCardSearchFuncParam + 1
	ld a, d
	cp [hl]
	jr nz, .no_carry
	dec hl
	ld a, e
	cp [hl]
	jr nz, .no_carry
	scf
	ret

; returns carry if input card is a NidoranF or NidoranM
.SearchNidoran:
	ld a, e
	call LoadCardDataToBuffer2_FromDeckIndex
	ld a, [wLoadedCard2PokedexNumber]
	cp DEX_NIDORAN_F
	jr z, .is_nidoran
	cp DEX_NIDORAN_M
	jr nz, .no_carry
.is_nidoran
	scf
	ret

; returns carry if input card is a Basic Fighting Pokémon
.SearchBasicFightingPkmn:
	ld a, e
	call LoadCardDataToBuffer2_FromDeckIndex
	ld a, [wLoadedCard2Type]
	cp TYPE_PKMN_FIGHTING
	jr nz, .no_carry
	ld a, [wLoadedCard2Stage]
	or a
	jr nz, .no_carry
	scf
	ret

; returns carry if input card is a Basic energy
.SearchBasicEnergy:
	ld a, e
	call GetCardIDFromDeckIndex
	call GetCardType
	cp TYPE_ENERGY_DOUBLE_COLORLESS
	jr nc, .no_carry
	and TYPE_ENERGY
	jr z, .no_carry
	scf
	ret

; returns carry if input card is an energy card
.SearchAnyEnergy:
	ld a, e
	call GetCardIDFromDeckIndex
	call GetCardType
	cp TYPE_ENERGY
	jr nc, .no_carry
	scf
	ret

; returns carry if input card has same Pokédex number
; as wCardSearchFuncParam
.SearchPokedexNumber:
	ld a, e
	call LoadCardDataToBuffer2_FromDeckIndex
	ld a, [wLoadedCard2PokedexNumber]
	ld hl, wCardSearchFuncParam
	cp [hl]
	jr nz, .no_carry
	scf
	ret

; returns carry if input card is a Dark Pokémon
.SearchDarkPkmn:
	ld a, e
	call LoadCardDataToBuffer2_FromDeckIndex
	ld a, [wLoadedCard2Type]
	cp TYPE_ENERGY
	jr nc, .no_carry
	ld a, [wLoadedCard2Dark]
	or a
	jr z, .no_carry ; not Dark
	scf
	ret

; returns carry if input card is a Psychic energy
.SearchPsychicEnergy:
	ld a, e
	call GetCardIDFromDeckIndex
	call GetCardType
	cp TYPE_ENERGY_PSYCHIC
	jp nz, .no_carry
	scf
	ret

; returns carry if input card is an Evolution Pokémon
.SearchEvolutionPkmn:
	ld a, e
	call LoadCardDataToBuffer2_FromDeckIndex
	ld a, [wLoadedCard2Type]
	cp TYPE_ENERGY
	jp nc, .no_carry
	ld a, [wLoadedCard2Stage]
	or a
	jp z, .no_carry
	scf
	ret

; returns carry if input card is a Trainer card
.SearchTrainer:
	ld a, e
	call LoadCardDataToBuffer2_FromDeckIndex
	ld a, [wLoadedCard2Type]
	cp TYPE_TRAINER
	jp nz, .no_carry
	scf
	ret

; returns carry if input card is an Evolution Colorless Pokémon
.SearchEvolutionColorlessPkmn:
	ld a, e
	call LoadCardDataToBuffer2_FromDeckIndex
	ld a, [wLoadedCard2Type]
	cp TYPE_PKMN_COLORLESS
	jp nz, .no_carry
	ld a, [wLoadedCard2Stage]
	or a
	jp z, .no_carry
	scf
	ret

; returns carry if input card is a Lightning energy
.SearchLightningEnergy:
	ld a, e
	call GetCardIDFromDeckIndex
	call GetCardType
	cp TYPE_ENERGY_LIGHTNING
	jp nz, .no_carry
	scf
	ret

; returns carry if input card is a Basic Pokémon
.SearchBasicPkmn:
	ld a, e
	call GetCardIDFromDeckIndex
	call LoadCardDataToBuffer2_FromDeckIndex
	ld a, [wLoadedCard2Type]
	cp TYPE_ENERGY
	jp nc, .no_carry
	ld a, [wLoadedCard2Stage]
	or a
	jp nz, .no_carry
	scf
	ret

.Func_24df6:
	scf
	ret
; 0x24df8

SECTION "Bank 9@4e25", ROMX[$4e25], BANK[$9]

; given the deck index of a turn holder's card in register a,
; and a pointer in hl to the wLoadedCard* buffer where the card data is loaded,
; check if the card is Clefairy Doll or Mysterious Fossil, and, if so, convert it
; to a Pokemon card in the wLoadedCard* buffer, using .trainer_to_pkmn_data.
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

	; in the case of Clefairy Doll, also overwrite
	; the second attack with Mind Shock attack data
	; in case Hypno's Puppet Master is in effect
	bank1call CheckHypnoPuppetMaster
	jr nc, .OverwriteCardData ; no Puppet Master
	call .OverwriteCardData
	ld bc, CARD_DATA_ATTACK2
	add hl, bc
	ld c, CARD_DATA_ATTACK2_ANIMATION - CARD_DATA_ATTACK2 + 1
	ld de, .mind_shock_attack_data
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
	ld bc, CARD_DATA_HP
	add hl, bc
	ld de, .trainer_to_pkmn_data
	ld c, CARD_DATA_UNKNOWN2 - CARD_DATA_HP + 1
.loop_copy_2
	ld a, [de]
	inc de
	ld [hli], a
	dec c
	jr nz, .loop_copy_2
	pop de
	pop hl
	ret

.trainer_to_pkmn_data
	db CARD_DATA_HP
	ds CARD_DATA_ATTACK1_NAME - (CARD_DATA_HP + 1)
	tx DiscardActionName ; CARD_DATA_ATTACK1_NAME
	tx DiscardActionDescription ; CARD_DATA_ATTACK1_DESCRIPTION
	ds CARD_DATA_ATTACK1_CATEGORY - (CARD_DATA_ATTACK1_DESCRIPTION + 2)
	db POKEMON_POWER      ; CARD_DATA_ATTACK1_CATEGORY
	dw $4896; TrainerCardAsPokemonEffectCommands ; CARD_DATA_ATTACK1_EFFECT_COMMANDS
	ds CARD_DATA_RETREAT_COST - (CARD_DATA_ATTACK1_EFFECT_COMMANDS + 2)
	db UNABLE_RETREAT     ; CARD_DATA_RETREAT_COST
	ds PKMN_CARD_DATA_LENGTH - (CARD_DATA_RETREAT_COST + 1)

.mind_shock_attack_data
	energy 0 ; energies
	tx ClefairyDollsMindShockName ; name
	tx ClefairyDollsMindShockDescription ; description
	dw NONE ; description (cont)
	db 30 ; damage
	db DAMAGE_NORMAL ; category
	dw $50ab ; effect commands
	db NONE ; flags 1
	db NONE ; flags 2
	db NONE ; flags 3
	db 0 ; ?
	db ATK_ANIM_NONE ; animation
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
	ldtx hl, DeckDiagnosisDialogInitialText
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
	tx DeckDiagnosisDialogStep1Text

	tx DeckDiagnosisDialogStep2Text
	tx DeckDiagnosisDialogStep3Text
	tx DeckDiagnosisDialogStep4Text
	tx DeckDiagnosisDialogExitText

.step_1
	db 5 ; number of items
	tx DeckDiagnosisStep1MenuText ; text ID with all items

	; menu items
	tx DeckDiagnosisDialogCheckDeckText
	tx DeckDiagnosisDialogStep1Advice1Text
	tx DeckDiagnosisDialogStep1Advice2Text
	tx DeckDiagnosisDialogStep1Advice3Text
	tx DeckDiagnosisDialogBackText

.step_2
	db 4 ; number of items
	tx DeckDiagnosisStep2MenuText ; text ID with all items

	; menu items
	tx DeckDiagnosisDialogStep2Advice1Text
	tx DeckDiagnosisDialogStep2Advice2Text
	tx DeckDiagnosisDialogStep2Advice3Text
	tx DeckDiagnosisDialogBackText

.step_3
	db 4 ; number of items
	tx DeckDiagnosisStep3MenuText ; text ID with all items

	; menu items
	tx DeckDiagnosisDialogStep3Advice1Text
	tx DeckDiagnosisDialogStep3Advice2Text
	tx DeckDiagnosisDialogStep3Advice3Text
	tx DeckDiagnosisDialogBackText

.step_4
	db 5 ; number of items
	tx DeckDiagnosisStep4MenuText ; text ID with all items

	; menu items
	tx DeckDiagnosisDialogStep4Advice1Text
	tx DeckDiagnosisDialogStep4Advice2Text
	tx DeckDiagnosisDialogStep4Advice3Text
	tx DeckDiagnosisDialogStep4Advice4Text
	tx DeckDiagnosisDialogBackText

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
	and PAD_UP | PAD_DOWN
	jr z, .check_a_btn
	call .PrintCursorMenuItemText
.check_a_btn
	ldh a, [hKeysPressed]
	bit B_PAD_A, a
	jr nz, .a_btn_pressed
	and PAD_B
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
	ldtx hl, DeckDiagnosisDialogExitText
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
	ldtx hl, DrMasonText
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

	ldtx hl, DeckDiagnosisExitText
	call InitTextPrinting_ProcessTextFromID
	ld a, [wNumDeckDiagnosisSteps]
	add 2
	ret

.text_ids
	tx DeckDiagnosisStep1Text
	tx DeckDiagnosisStep2Text
	tx DeckDiagnosisStep3Text
	tx DeckDiagnosisStep4Text

; loads Deck Diagnosis scene together
; with Dr. Mason's portrait
LoadDeckDiagnosisScene:
	lb bc, 1, 1
	ld a, SCENE_DECK_DIAGNOSIS
	call LoadScene
	lb bc, 2, 6
;	fallthrough
DrawDrMasonsPortrait:
	ld a, DR_MASON_PIC
	ld e, EMOTION_NORMAL
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
	tx DeckDiagnosisStep1Text
	tx DeckDiagnosisStep2Text
	tx DeckDiagnosisStep3Text
	tx DeckDiagnosisStep4Text

MACRO advice
	dw \1
	tx \2
ENDM

.AdviceTexts:
	; Step 1
	dw NULL, NULL                   ; Check Deck
	advice .step1_advice1, DeckDiagnosisAdvice1Text
	advice .step1_advice2, DeckDiagnosisAdvice2Text
	advice .step1_advice3, DeckDiagnosisAdvice3Text

	; Step 2
	advice .step2_advice1, DeckDiagnosisAdvice1Text
	advice .step2_advice2, DeckDiagnosisAdvice2Text
	advice .step2_advice3, DeckDiagnosisAdvice3Text
	dw NULL, NULL

	; Step 3
	advice .step3_advice1, DeckDiagnosisAdvice1Text
	advice .step3_advice2, DeckDiagnosisAdvice2Text
	advice .step3_advice3, DeckDiagnosisAdvice3Text
	dw NULL, NULL

	; Step 4
	advice .step4_advice1, DeckDiagnosisAdvice1Text
	advice .step4_advice2, DeckDiagnosisAdvice2Text
	advice .step4_advice3, DeckDiagnosisAdvice3Text
	advice .step4_advice4, DeckDiagnosisAdvice4Text

.step1_advice1
	tx DeckDiagnosisStep1Advice1Description1Text
	tx DeckDiagnosisStep1Advice1Description2Text
	dw NULL

.step1_advice2
	tx DeckDiagnosisStep1Advice2Description1Text
	tx DeckDiagnosisStep1Advice2Description2Text
	dw NULL

.step1_advice3
	tx DeckDiagnosisStep1Advice3Description1Text
	tx DeckDiagnosisStep1Advice3Description2Text
	dw NULL

.step2_advice1
	tx DeckDiagnosisStep2Advice1DescriptionText
	dw NULL

.step2_advice2
	tx DeckDiagnosisStep2Advice2DescriptionText
	dw NULL

.step2_advice3
	tx DeckDiagnosisStep2Advice3DescriptionText
	dw NULL

.step3_advice1
	tx DeckDiagnosisStep3Advice1Description1Text
	tx DeckDiagnosisStep3Advice1Description2Text
	tx DeckDiagnosisStep3Advice1Description3Text
	tx DeckDiagnosisStep3Advice1Description4Text
	dw NULL

.step3_advice2
	tx DeckDiagnosisStep3Advice2Description1Text
	tx DeckDiagnosisStep3Advice2Description2Text
	dw NULL

.step3_advice3
	tx DeckDiagnosisStep3Advice3Description1Text
	tx DeckDiagnosisStep3Advice3Description2Text
	dw NULL

.step4_advice1
	tx DeckDiagnosisStep4Advice1Description1Text
	tx DeckDiagnosisStep4Advice1Description2Text
	tx DeckDiagnosisStep4Advice1Description3Text
	tx DeckDiagnosisStep4Advice1Description4Text
	tx DeckDiagnosisStep4Advice1Description5Text
	tx DeckDiagnosisStep4Advice1Description6Text
	dw NULL

.step4_advice2
	tx DeckDiagnosisStep4Advice2Description1Text
	tx DeckDiagnosisStep4Advice2Description2Text
	tx DeckDiagnosisStep4Advice2Description3Text
	dw NULL

.step4_advice3
	tx DeckDiagnosisStep4Advice3Description1Text
	tx DeckDiagnosisStep4Advice3Description2Text
	dw NULL

.step4_advice4
	tx DeckDiagnosisStep4Advice4Description1Text
	tx DeckDiagnosisStep4Advice4Description2Text
	dw NULL

CheckDeck:
.start
	ldtx de, DeckDiagnosisChooseDeckToCheckText
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

	ldtx de, DrMasonText
	ldtx hl, DeckDiagnosisCheckAnotherDeckPromptText
	call PrintScrollableText_WithTextBoxLabel_NoWait
	call YesOrNoMenu
	jr nc, .start
	ret

.DoChecks:
	; check has enough Basic cards
	ldtx hl, DeckDiagnosisTooFewBasicPokemonText
	ld a, [wDeckCheckBasicCount]
	cp 12
	jp c, .PrintDrMasonText ; < 12 Basic cards

	; check color diversity
	call .CountTypesOfPkmnCards
	ldtx hl, DeckDiagnosisTooManyColorsText
	cp 4
	jp nc, .PrintDrMasonText ; >= 4 different types

	call .DiagnoseNumberOfPkmnAndEnergyCards
	ret c ; already printed a diagnosis

	call .CheckIfEvolutionCardsHaveTheirPreEvos
	jr nc, .check_mismatched_evos
	ldtx hl, DeckDiagnosisEvolutionMismatchedText
	ldtx de, DeckDiagnosisEvolutionMismatchedListText
	jp .asm_25352

.check_mismatched_evos
	call .LookForBasicCardsWithMismatchedEvolutionCounts
	jr nc, .check_mismatched_energy
	ldtx hl, DeckDiagnosisEvolutionUnbalancedText
	ldtx de, DeckDiagnosisEvolutionUnbalancedListText
	jp .asm_25352

.check_mismatched_energy
	call .CheckIfAllEnergyCardsMatchPkmnColors
	jr c, .check_amount_energy_cards
	ldtx hl, DeckDiagnosisPokemonEnergyMismatchedText
	ldtx de, DeckDiagnosisPokemonEnergyMismatchedListText
	jp .asm_25352

.check_amount_energy_cards
	call .CheckEnergyAmountVsPkmnCards
	ret c
	ldtx hl, DeckDiagnosisOKText
	ld a, [wDeckCheckTrainerCount]
	or a
	jr nz, .asm_2534d
	ldtx hl, DeckDiagnosisOKButNoTrainerText
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
	ldtx de, DrMasonText
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
	ldtx hl, DeckDiagnosisTooManyPokemonText
	cp 31
	jr nc, .asm_25390
	ldtx hl, DeckDiagnosisTooFewPokemonText
	cp 18
	jr nc, .asm_25393
.asm_25390
	call .PrintDrMasonText

.asm_25393
	ld a, [wDeckCheckEnergyCount]
	ldtx hl, DeckDiagnosisNoEnergyText
	or a
	jr z, .asm_253aa
	ldtx hl, DeckDiagnosisTooFewEnergyText
	cp 20
	jr c, .asm_253aa
	ldtx hl, DeckDiagnosisTooManyEnergyText
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
	ldtx hl, DeckDiagnosisTargetNameText
	call PrintTextNoDelay_Init
	call EnableLCD
	ldtx de, DrMasonText
	ldtx hl, DeckDiagnosisCheckingDeckText
	call PrintScrollableText_WithTextBoxLabel_NoWait

	; delays for $80 frames,
	; every $10 frames cycle Dr. Mason's portrait
	; between normal and sad variants
	ld d, $80
	ld e, EMOTION_NORMAL
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
	ld a, DR_MASON_PIC
	lb bc, 7, 4
	call DrawNPCPortrait
	call FlushAllPalettes
	pop de
	dec d
	jr nz, .check_delay

	; show happy portrait
	ld a, DR_MASON_PIC
	ld e, EMOTION_HAPPY
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
	ldtx hl, DeckDiagnosisTargetNameText
	call Func_2c4b
	lb de, 2, 2
	ldtx hl, DeckDiagnosisBreakdownText
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
	ldtx de, DrMasonText
	ldtx hl, DeckDiagnosisCheckedDeckText
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
	ldtx hl, DeckDiagnosisPokemonEnergyUnbalancedText
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
	ldtx hl, DeckDiagnosisTooManyEnergyThisColorText
	jr .get_energy_name
.negative
	; not enough energy cards
	ldtx hl, DeckDiagnosisTooFewEnergyThisColorText

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
	ldtx hl, DeckDiagnosisEnergyUnbalancedText
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
	tx DeckDiagnosisFireText
	tx DeckDiagnosisGrassText
	tx DeckDiagnosisLightningText
	tx DeckDiagnosisWaterText
	tx DeckDiagnosisFightingText
	tx DeckDiagnosisPsychicText

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

; a = BOOSTER_* constant
; generate the content, according to .ContentTable[a]
; using CreateCardPopCandidateList
; and set wDuelTempList to 0--9
GenerateBoosterContent:
	ld e, a
	add a
	add e
	add a ; a *= 6
	ld e, a
	ld d, 0
	ld hl, .ContentTable
	add hl, de
	ld b, [hl]
	inc hl
	ld c, [hl]
	inc hl
	ld de, wPlayerDeck

	ld a, CARDPOP_STAR
	call .GenerateCard

	ld a, CARDPOP_DIAMOND
	call .GenerateCard

	ld a, CARDPOP_CIRCLE
	call .GenerateCard

	ld a, CARDPOP_ENERGY
	call .GenerateCard

	xor a
	ld [de], a
	inc de
	ld [de], a
	ld hl, wDuelTempList
	ld c, NUM_CARDS_IN_BOOSTER
	xor a
.loop_set_temp_list
	ld [hli], a
	inc a
	dec c
	jr nz, .loop_set_temp_list
	ld [hl], $ff
	ret

.GenerateCard:
	ldh [hff96], a
	ld a, [hli]
	or a
	ret z

	dec hl
	push bc
	push de
	push hl
	ldh a, [hff96]
	call CreateCardPopCandidateList
	pop hl
	pop de
	pop bc
	ld a, [hli]
	push hl
	push bc
	ld c, a
.loop_generate
	push bc
	ld hl, wDuelTempList
.loop_random_get
	ld a, [wcd54]
	call Random
	ld l, a
	ld h, 0
	add hl, hl
	ld bc, wCardPopCandidateList
	add hl, bc
	ld a, [hli]
	or [hl]
	dec hl
	jr z, .loop_random_get
	ld a, [hli]
	ld [de], a
	inc de
	ld a, [hl]
	ld [de], a
	inc de
	xor a
	ld [hld], a
	ld [hl], a
	pop bc
	dec c
	jr nz, .loop_generate
	pop bc
	pop hl
	ret

; arg0 <= set range <= arg1
; arg2--5: number of star, diamond, circle, energy
.ContentTable:
	db BEGINNING_POKEMON,     BEGINNING_POKEMON,     1, 3, 5,  1 ; BOOSTER_BEGINNING_POKEMON
	db LEGENDARY_POWER,       LEGENDARY_POWER,       1, 3, 5,  1 ; BOOSTER_LEGENDARY_POWER
	db ISLAND_OF_FOSSIL,      ISLAND_OF_FOSSIL,      1, 3, 5,  1 ; BOOSTER_ISLAND_OF_FOSSIL
	db PSYCHIC_BATTLE,        PSYCHIC_BATTLE,        1, 3, 6,  0 ; BOOSTER_PSYCHIC_BATTLE
	db SKY_FLYING_POKEMON,    SKY_FLYING_POKEMON,    1, 3, 6,  0 ; BOOSTER_SKY_FLYING_POKEMON
	db WE_ARE_TEAM_ROCKET,    WE_ARE_TEAM_ROCKET,    1, 3, 6,  0 ; BOOSTER_WE_ARE_TEAM_ROCKET
	db TEAM_ROCKETS_AMBITION, TEAM_ROCKETS_AMBITION, 1, 3, 6,  0 ; BOOSTER_TEAM_ROCKETS_AMBITION
	db BEGINNING_POKEMON,     PROMOTIONAL,          10, 0, 0,  0 ; BOOSTER_DEBUG_1
	db BEGINNING_POKEMON,     BEGINNING_POKEMON,     0, 0, 0, 10 ; BOOSTER_PRESENT_PACK_1
	db BEGINNING_POKEMON,     TEAM_ROCKETS_AMBITION, 1, 3, 6,  0 ; BOOSTER_PRESENT_PACK_2
	db BEGINNING_POKEMON,     SKY_FLYING_POKEMON,    1, 3, 6,  0 ; BOOSTER_PRESENT_PACK_3
	db PSYCHIC_BATTLE,        TEAM_ROCKETS_AMBITION, 1, 3, 6,  0 ; BOOSTER_PRESENT_PACK_4
	db WE_ARE_TEAM_ROCKET,    TEAM_ROCKETS_AMBITION, 1, 3, 6,  0 ; BOOSTER_PRESENT_PACK_5
	db BEGINNING_POKEMON,     TEAM_ROCKETS_AMBITION, 2, 3, 5,  0 ; BOOSTER_DEBUG_2

; fills wCardPopCandidateList with cards that satisfy
; certain criteria:
; if a == $ff, then only output energy cards
; if a == $fe, then only output Phantom cards
; otherwise, output cards with:
; - rarity == a
; - b <= set <= c
; outputs in a the number of cards in the list
CreateCardPopCandidateList:
	cp CARDPOP_ENERGY
	jr z, .energy_cards
	cp CARDPOP_PHANTOM
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
	ld [wOpponentPicID], a
	ld a, [hli]
	ld [wNPCDuelPrizes], a
	ld a, [hli]
	ld [wSpecialRule], a
	ld a, [hli]
	ld [wcd0e], a
	ld a, [hli]
	ld [wDuelTheme], a
	ld a, [hli]
	ld [wcd0f], a
	ld a, [hli]
	ld [wOppCoin], a
	or a
	ret

DeckIDData:
	db SAMS_PRACTICE_DECK_ID
	tx SamsPracticeDeckName ; deck name
	tx DuelistSamName ; opponent name
	db SAM_PIC ; Pic ID
	db PRIZES_2 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $00 ; ?
	db MUSIC_DUELTHEME_1 ; duel theme
	db $12 ; ?
	db COIN_CHANSEY ; coin

	db STARTER_DECK_ID - 1
	tx StarterDeckName ; deck name
	tx DuelistMainCharacterName ; opponent name
	db MARK_PIC ; Pic ID
	db 0 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $00 ; ?
	db MUSIC_STOP ; duel theme
	db $00 ; ?
	db COIN_CHANSEY ; coin

	db SWEAT_ANTI_GR1_DECK_ID - 1
	tx SweatAntiGR1DeckName ; deck name
	tx DuelistMainCharacterName ; opponent name
	db MARK_PIC ; Pic ID
	db 0 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $00 ; ?
	db MUSIC_STOP ; duel theme
	db $00 ; ?
	db COIN_CHANSEY ; coin

	db GIVE_IN_ANTI_GR2_DECK_ID - 1
	tx GiveInAntiGR2DeckName ; deck name
	tx DuelistMainCharacterName ; opponent name
	db MARK_PIC ; Pic ID
	db 0 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $00 ; ?
	db MUSIC_STOP ; duel theme
	db $00 ; ?
	db COIN_CHANSEY ; coin

	db VENGEFUL_ANTI_GR3_DECK_ID - 1
	tx VengefulAntiGR3DeckName ; deck name
	tx DuelistMainCharacterName ; opponent name
	db MARK_PIC ; Pic ID
	db 0 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $00 ; ?
	db MUSIC_STOP ; duel theme
	db $00 ; ?
	db COIN_CHANSEY ; coin

	db UNFORGIVING_ANTI_GR4_DECK_ID - 1
	tx UnforgivingAntiGR4DeckName ; deck name
	tx DuelistMainCharacterName ; opponent name
	db MARK_PIC ; Pic ID
	db 0 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $00 ; ?
	db MUSIC_STOP ; duel theme
	db $00 ; ?
	db COIN_CHANSEY ; coin

	db UNUSED_SAMS_PRACTICE_DECK_ID - 1
	tx PracticeDeckName ; deck name
	tx DuelistMainCharacterName ; opponent name
	db MARK_PIC ; Pic ID
	db 0 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $00 ; ?
	db MUSIC_STOP ; duel theme
	db $00 ; ?
	db COIN_CHANSEY ; coin

	db UNUSED_SAMS_PRACTICE_DECK_ID
	tx SamsPracticeDeckName ; deck name
	tx DuelistSamName ; opponent name
	db SAM_PIC ; Pic ID
	db PRIZES_2 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $00 ; ?
	db MUSIC_DUELTHEME_1 ; duel theme
	db $12 ; ?
	db COIN_CHANSEY ; coin

	db AARON_PRACTICE_DECK1_ID
	tx YourPracticeDeck1Name ; deck name
	tx DuelistMainCharacterName ; opponent name
	db MARK_PIC ; Pic ID
	db 0 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $00 ; ?
	db MUSIC_STOP ; duel theme
	db $00 ; ?
	db COIN_CHANSEY ; coin

	db AARONS_STEP1_DECK_ID
	tx AaronsStep1DeckName ; deck name
	tx DuelistAaronName ; opponent name
	db AARON_PIC ; Pic ID
	db PRIZES_4 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $00 ; ?
	db MUSIC_DUELTHEME_1 ; duel theme
	db $12 ; ?
	db COIN_CHANSEY ; coin

	db AARON_PRACTICE_DECK2_ID
	tx YourPracticeDeck2Name ; deck name
	tx DuelistMainCharacterName ; opponent name
	db MARK_PIC ; Pic ID
	db 0 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $00 ; ?
	db MUSIC_STOP ; duel theme
	db $00 ; ?
	db COIN_CHANSEY ; coin

	db AARONS_STEP2_DECK_ID
	tx AaronsStep2DeckName ; deck name
	tx DuelistAaronName ; opponent name
	db AARON_PIC ; Pic ID
	db PRIZES_4 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $00 ; ?
	db MUSIC_DUELTHEME_1 ; duel theme
	db $12 ; ?
	db COIN_CHANSEY ; coin

	db AARON_PRACTICE_DECK3_ID
	tx YourPracticeDeck3Name ; deck name
	tx DuelistMainCharacterName ; opponent name
	db MARK_PIC ; Pic ID
	db 0 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $00 ; ?
	db MUSIC_STOP ; duel theme
	db $00 ; ?
	db COIN_CHANSEY ; coin

	db AARONS_STEP3_DECK_ID
	tx AaronsStep3DeckName ; deck name
	tx DuelistAaronName ; opponent name
	db AARON_PIC ; Pic ID
	db PRIZES_4 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $00 ; ?
	db MUSIC_DUELTHEME_1 ; duel theme
	db $12 ; ?
	db COIN_CHANSEY ; coin

	db BRICK_WALK_DECK_ID
	tx RiversideWalkDeckName ; deck name
	tx DuelistAaronName ; opponent name
	db AARON_PIC ; Pic ID
	db PRIZES_4 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $00 ; ?
	db MUSIC_DUELTHEME_1 ; duel theme
	db $12 ; ?
	db COIN_CHANSEY ; coin

	db BENCH_TRAP_DECK_ID
	tx BenchTrapDeckName ; deck name
	tx DuelistAaronName ; opponent name
	db AARON_PIC ; Pic ID
	db PRIZES_4 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $00 ; ?
	db MUSIC_DUELTHEME_1 ; duel theme
	db $12 ; ?
	db COIN_CHANSEY ; coin

	db SKY_SPARK_DECK_ID
	tx SkySparkDeckName ; deck name
	tx DuelistIsaacName ; opponent name
	db ISAAC_PIC ; Pic ID
	db PRIZES_6 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $00 ; ?
	db MUSIC_DUELTHEME_2 ; duel theme
	db $09 ; ?
	db COIN_PIKACHU ; coin

	db ELECTRIC_SELFDESTRUCT_DECK_ID
	tx ElectricSelfDestructDeckName ; deck name
	tx DuelistIsaacName ; opponent name
	db ISAAC_PIC ; Pic ID
	db PRIZES_6 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $00 ; ?
	db MUSIC_DUELTHEME_2 ; duel theme
	db $09 ; ?
	db COIN_PIKACHU ; coin

	db OVERFLOW_DECK_ID
	tx OverflowDeckName ; deck name
	tx DuelistNicholasName ; opponent name
	db NICHOLAS_PIC ; Pic ID
	db PRIZES_4 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $00 ; ?
	db MUSIC_DUELTHEME_1 ; duel theme
	db $01 ; ?
	db COIN_CHANSEY ; coin

	db TRIPLE_ZAPDOS_DECK_ID
	tx TripleZapdosDeckName ; deck name
	tx DuelistNicholasName ; opponent name
	db NICHOLAS_PIC ; Pic ID
	db PRIZES_4 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $00 ; ?
	db MUSIC_DUELTHEME_1 ; duel theme
	db $01 ; ?
	db COIN_PIKACHU ; coin

	db I_LOVE_PIKACHU_DECK_ID
	tx ILovePikachuDeckName ; deck name
	tx DuelistJenniferName ; opponent name
	db JENNIFER_PIC ; Pic ID
	db PRIZES_4 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $00 ; ?
	db MUSIC_DUELTHEME_1 ; duel theme
	db $01 ; ?
	db COIN_CHANSEY ; coin

	db TEN_THOUSAND_VOLTS_DECK_ID
	tx ThunderboltDeckName ; deck name
	tx DuelistBrandonName ; opponent name
	db BRANDON_PIC ; Pic ID
	db PRIZES_4 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $00 ; ?
	db MUSIC_DUELTHEME_1 ; duel theme
	db $01 ; ?
	db COIN_CHANSEY ; coin

	db HAND_OVER_GR_DECK_ID
	tx HandedOverGRDeckName ; deck name
	tx DuelistMurrayName ; opponent name
	db MURRAY_PIC ; Pic ID
	db PRIZES_6 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $00 ; ?
	db MUSIC_DUELTHEME_2 ; duel theme
	db $0a ; ?
	db COIN_ALAKAZAM ; coin

	db PSYCHIC_ELITE_DECK_ID
	tx PsychicEliteDeckName ; deck name
	tx DuelistMurrayName ; opponent name
	db MURRAY_PIC ; Pic ID
	db PRIZES_6 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $00 ; ?
	db MUSIC_DUELTHEME_2 ; duel theme
	db $0a ; ?
	db COIN_ALAKAZAM ; coin

	db PSYCHOKINESIS_DECK_ID
	tx PsychicDeckName ; deck name
	tx DuelistStephanieName ; opponent name
	db STEPHANIE_PIC ; Pic ID
	db PRIZES_4 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $00 ; ?
	db MUSIC_DUELTHEME_1 ; duel theme
	db $02 ; ?
	db COIN_CHANSEY ; coin

	db PHANTOM_DECK_ID
	tx GhostDeckName ; deck name
	tx DuelistRobertName ; opponent name
	db ROBERT_PIC ; Pic ID
	db PRIZES_4 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $00 ; ?
	db MUSIC_DUELTHEME_1 ; duel theme
	db $02 ; ?
	db COIN_CHANSEY ; coin

	db PUPPET_MASTER_DECK_ID
	tx PuppetMasterDeckName ; deck name
	tx DuelistDanielName ; opponent name
	db DANIEL_PIC ; Pic ID
	db PRIZES_4 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $00 ; ?
	db MUSIC_DUELTHEME_1 ; duel theme
	db $02 ; ?
	db COIN_CHANSEY ; coin

	db EVEN3_YEARS_ON_A_ROCK_DECK_ID
	tx ThreeYearsOnRockDeckName ; deck name
	tx DuelistGeneName ; opponent name
	db GENE_PIC ; Pic ID
	db PRIZES_6 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $00 ; ?
	db MUSIC_DUELTHEME_2 ; duel theme
	db $0b ; ?
	db COIN_KABUTO ; coin

	db ROLLING_STONE_DECK_ID
	tx RollingStoneDeckName ; deck name
	tx DuelistMatthewName ; opponent name
	db MATTHEW_PIC ; Pic ID
	db PRIZES_4 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $00 ; ?
	db MUSIC_DUELTHEME_1 ; duel theme
	db $03 ; ?
	db COIN_CHANSEY ; coin

	db GREAT_EARTHQUAKE_DECK_ID
	tx GreatEarthquakeDeckName ; deck name
	tx DuelistRyanName ; opponent name
	db RYAN_PIC ; Pic ID
	db PRIZES_4 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $00 ; ?
	db MUSIC_DUELTHEME_1 ; duel theme
	db $03 ; ?
	db COIN_CHANSEY ; coin

	db AWESOME_FOSSIL_DECK_ID
	tx AwesomeFossilDeckName ; deck name
	tx DuelistAndrewName ; opponent name
	db ANDREW_PIC ; Pic ID
	db PRIZES_4 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $00 ; ?
	db MUSIC_DUELTHEME_1 ; duel theme
	db $03 ; ?
	db COIN_CHANSEY ; coin

	db RAGING_BILLOW_OF_FISTS_DECK_ID
	tx RagingBillowOfFistsDeckName ; deck name
	tx DuelistMitchName ; opponent name
	db MITCH_PIC ; Pic ID
	db PRIZES_6 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $00 ; ?
	db MUSIC_DUELTHEME_2 ; duel theme
	db $0c ; ?
	db COIN_MACHAMP ; coin

	db YOU_CAN_DO_IT_MACHOP_DECK_ID
	tx YouCanDoItMachopDeckName ; deck name
	tx DuelistMichaelName ; opponent name
	db MICHAEL_PIC ; Pic ID
	db PRIZES_4 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $00 ; ?
	db MUSIC_DUELTHEME_1 ; duel theme
	db $04 ; ?
	db COIN_CHANSEY ; coin

	db NEW_MACHOKE_DECK_ID
	tx NewMachokeDeckName ; deck name
	tx DuelistMichaelName ; opponent name
	db MICHAEL_PIC ; Pic ID
	db PRIZES_4 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $00 ; ?
	db MUSIC_DUELTHEME_1 ; duel theme
	db $04 ; ?
	db COIN_CHANSEY ; coin

	db SKILLED_WARRIOR_DECK_ID
	tx SkilledWarriorDeckName ; deck name
	tx DuelistChrisName ; opponent name
	db CHRIS_PIC ; Pic ID
	db PRIZES_4 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $00 ; ?
	db MUSIC_DUELTHEME_1 ; duel theme
	db $04 ; ?
	db COIN_CHANSEY ; coin

	db I_LOVE_TO_FIGHT_DECK_ID
	tx LoveToBattleDeckName ; deck name
	tx DuelistJessicaName ; opponent name
	db JESSICA_PIC ; Pic ID
	db PRIZES_4 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $00 ; ?
	db MUSIC_DUELTHEME_1 ; duel theme
	db $04 ; ?
	db COIN_CHANSEY ; coin

	db MAX_ENERGY_DECK_ID
	tx MaxEnergyDeckName ; deck name
	tx DuelistNikkiName ; opponent name
	db NIKKI_PIC ; Pic ID
	db PRIZES_6 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $00 ; ?
	db MUSIC_DUELTHEME_2 ; duel theme
	db $0d ; ?
	db COIN_ODDISH ; coin

	db REMAINING_GREEN_DECK_ID
	tx SurvivingGreenDeckName ; deck name
	tx DuelistBrittanyName ; opponent name
	db BRITTANY_PIC ; Pic ID
	db PRIZES_4 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $00 ; ?
	db MUSIC_DUELTHEME_1 ; duel theme
	db $05 ; ?
	db COIN_CHANSEY ; coin

	db POISON_CURSE_DECK_ID
	tx PoisonVespidsDeckName ; deck name
	tx DuelistBrittanyName ; opponent name
	db BRITTANY_PIC ; Pic ID
	db PRIZES_4 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $00 ; ?
	db MUSIC_DUELTHEME_1 ; duel theme
	db $05 ; ?
	db COIN_ODDISH ; coin

	db GLITTERING_SCALES_DECK_ID
	tx GlitteringScalesDeckName ; deck name
	tx DuelistKristinName ; opponent name
	db KRISTIN_PIC ; Pic ID
	db PRIZES_4 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $00 ; ?
	db MUSIC_DUELTHEME_1 ; duel theme
	db $05 ; ?
	db COIN_CHANSEY ; coin

	db STEADY_INCREASE_DECK_ID
	tx SteadyIncreaseDeckName ; deck name
	tx DuelistHeatherName ; opponent name
	db HEATHER_PIC ; Pic ID
	db PRIZES_4 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $00 ; ?
	db MUSIC_DUELTHEME_1 ; duel theme
	db $05 ; ?
	db COIN_CHANSEY ; coin

	db DARK_SCIENCE_DECK_ID
	tx DarkScienceDeckName ; deck name
	tx DuelistRickName ; opponent name
	db RICK_PIC ; Pic ID
	db PRIZES_6 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $00 ; ?
	db MUSIC_DUELTHEME_2 ; duel theme
	db $0e ; ?
	db COIN_GOLBAT ; coin

	db NATURAL_SCIENCE_DECK_ID
	tx NaturalScienceDeckName ; deck name
	tx DuelistDavidName ; opponent name
	db DAVID_PIC ; Pic ID
	db PRIZES_4 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $00 ; ?
	db MUSIC_DUELTHEME_1 ; duel theme
	db $06 ; ?
	db COIN_CHANSEY ; coin

	db POISONOUS_SWAMP_DECK_ID
	tx PoisonousSwampDeckName ; deck name
	tx DuelistJosephName ; opponent name
	db JOSEPH_PIC ; Pic ID
	db PRIZES_4 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $00 ; ?
	db MUSIC_DUELTHEME_1 ; duel theme
	db $06 ; ?
	db COIN_CHANSEY ; coin

	db GATHERING_NIDORAN_DECK_ID
	tx GatheringNidoranDeckName ; deck name
	tx DuelistErikName ; opponent name
	db ERIK_PIC ; Pic ID
	db PRIZES_4 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $00 ; ?
	db MUSIC_DUELTHEME_1 ; duel theme
	db $06 ; ?
	db COIN_CHANSEY ; coin

	db RAIN_DANCE_CONFUSION_DECK_ID
	tx RainDanceConfusionDeckName ; deck name
	tx DuelistAmyName ; opponent name
	db AMY_PIC ; Pic ID
	db PRIZES_6 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $00 ; ?
	db MUSIC_DUELTHEME_2 ; duel theme
	db $0f ; ?
	db COIN_STARMIE ; coin

	db CONSERVING_WATER_DECK_ID
	tx SurvivingWaterDeckName ; deck name
	tx DuelistJoshuaName ; opponent name
	db JOSHUA_PIC ; Pic ID
	db PRIZES_4 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $00 ; ?
	db MUSIC_DUELTHEME_1 ; duel theme
	db $07 ; ?
	db COIN_CHANSEY ; coin

	db ENERGY_REMOVAL_DECK_ID
	tx EnergyRemovalDeckName ; deck name
	tx DuelistJoshuaName ; opponent name
	db JOSHUA_PIC ; Pic ID
	db PRIZES_4 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $00 ; ?
	db MUSIC_DUELTHEME_1 ; duel theme
	db $07 ; ?
	db COIN_STARMIE ; coin

	db SPLASHING_ABOUT_DECK_ID
	tx SplashingAboutDeckName ; deck name
	tx DuelistSaraName ; opponent name
	db SARA_PIC ; Pic ID
	db PRIZES_4 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $00 ; ?
	db MUSIC_DUELTHEME_1 ; duel theme
	db $07 ; ?
	db COIN_CHANSEY ; coin

	db BEACH_DECK_ID
	tx BeachDeckName ; deck name
	tx DuelistAmandaName ; opponent name
	db AMANDA_PIC ; Pic ID
	db PRIZES_4 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $00 ; ?
	db MUSIC_DUELTHEME_1 ; duel theme
	db $07 ; ?
	db COIN_CHANSEY ; coin

	db GO_ARCANINE_DECK_ID
	tx GoArcanineDeckName ; deck name
	tx DuelistKenName ; opponent name
	db KEN_PIC ; Pic ID
	db PRIZES_6 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $00 ; ?
	db MUSIC_DUELTHEME_2 ; duel theme
	db $10 ; ?
	db COIN_CHARMANDER ; coin

	db FLAME_FESTIVAL_DECK_ID
	tx FlameFestivalDeckName ; deck name
	tx DuelistJohnName ; opponent name
	db JOHN_PIC ; Pic ID
	db PRIZES_4 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $00 ; ?
	db MUSIC_DUELTHEME_1 ; duel theme
	db $08 ; ?
	db COIN_CHANSEY ; coin

	db IMMORTAL_FLAME_DECK_ID
	tx ImmortalFlameDeckName ; deck name
	tx DuelistJonathanName ; opponent name
	db JONATHAN_PIC ; Pic ID
	db PRIZES_4 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $00 ; ?
	db MUSIC_DUELTHEME_1 ; duel theme
	db $08 ; ?
	db COIN_CHANSEY ; coin

	db ELECTRIC_CURRENT_SHOCK_DECK_ID
	tx ElectricCurrentShockDeckName ; deck name
	tx DuelistAdamName ; opponent name
	db ADAM_PIC ; Pic ID
	db PRIZES_4 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $00 ; ?
	db MUSIC_DUELTHEME_1 ; duel theme
	db $08 ; ?
	db COIN_CHANSEY ; coin

	db GREAT_ROCKET4_DECK_ID
	tx GreatRocket4DeckName ; deck name
	tx DuelistGR4Name ; opponent name
	db GR_4_PIC ; Pic ID
	db PRIZES_6 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $00 ; ?
	db MUSIC_GRDUELTHEME_1 ; duel theme
	db $16 ; ?
	db COIN_GR ; coin

	db GREAT_ROCKET1_DECK_ID
	tx GreatRocket1DeckName ; deck name
	tx DuelistGR1Name ; opponent name
	db GR_1_PIC ; Pic ID
	db PRIZES_6 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $00 ; ?
	db MUSIC_GRDUELTHEME_1 ; duel theme
	db $16 ; ?
	db COIN_GR ; coin

	db GREAT_ROCKET2_DECK_ID
	tx GreatRocket2DeckName ; deck name
	tx DuelistGR2Name ; opponent name
	db GR_2_PIC ; Pic ID
	db PRIZES_6 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $00 ; ?
	db MUSIC_GRDUELTHEME_1 ; duel theme
	db $16 ; ?
	db COIN_GR ; coin

	db GREAT_ROCKET3_DECK_ID
	tx GreatRocket3DeckName ; deck name
	tx DuelistGR3Name ; opponent name
	db GR_3_PIC ; Pic ID
	db PRIZES_6 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $00 ; ?
	db MUSIC_GRDUELTHEME_1 ; duel theme
	db $16 ; ?
	db COIN_GR ; coin

	db GRAND_FIRE_DECK_ID
	tx GrandFireDeckName ; deck name
	tx DuelistCourtneyName ; opponent name
	db COURTNEY_PIC ; Pic ID
	db PRIZES_6 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $00 ; ?
	db MUSIC_DUELTHEME_3 ; duel theme
	db $11 ; ?
	db COIN_CHARMANDER ; coin

	db LEGENDARY_FOSSIL_DECK_ID
	tx LegendaryFossilDeckName ; deck name
	tx DuelistSteveName ; opponent name
	db STEVE_PIC ; Pic ID
	db PRIZES_6 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $00 ; ?
	db MUSIC_DUELTHEME_3 ; duel theme
	db $11 ; ?
	db COIN_PIKACHU ; coin

	db WATER_LEGEND_DECK_ID
	tx WaterLegendDeckName ; deck name
	tx DuelistJackName ; opponent name
	db JACK_PIC ; Pic ID
	db PRIZES_6 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $00 ; ?
	db MUSIC_DUELTHEME_3 ; duel theme
	db $11 ; ?
	db COIN_STARMIE ; coin

	db GREAT_DRAGON_DECK_ID
	tx GreatDragonDeckName ; deck name
	tx DuelistRodName ; opponent name
	db ROD_PIC ; Pic ID
	db PRIZES_6 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $00 ; ?
	db MUSIC_DUELTHEME_3 ; duel theme
	db $11 ; ?
	db COIN_CHANSEY ; coin

	db BUG_COLLECTING_DECK_ID
	tx InsectCollectionDeckName ; deck name
	tx DuelistMidoriName ; opponent name
	db MIDORI_PIC ; Pic ID
	db PRIZES_4 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $00 ; ?
	db MUSIC_GRDUELTHEME_1 ; duel theme
	db $17 ; ?
	db COIN_GR ; coin

	db DEMONIC_FOREST_DECK_ID
	tx DemonicForestDeckName ; deck name
	tx DuelistYutaName ; opponent name
	db YUTA_PIC ; Pic ID
	db PRIZES_4 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $00 ; ?
	db MUSIC_GRDUELTHEME_1 ; duel theme
	db $17 ; ?
	db COIN_GR ; coin

	db STICKY_POISON_GAS_DECK_ID
	tx PoisonGoopGasDeckName ; deck name
	tx DuelistMiyukiName ; opponent name
	db MIYUKI_PIC ; Pic ID
	db PRIZES_4 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $01 ; ?
	db MUSIC_GRDUELTHEME_1 ; duel theme
	db $17 ; ?
	db COIN_GR ; coin

	db MAD_PETALS_DECK_ID
	tx MadPetalsDeckName ; deck name
	tx DuelistMorinoName ; opponent name
	db MORINO_PIC ; Pic ID
	db PRIZES_6 ; number of prize cards
	db $01 ; special duel rules
	db $00 ; ?
	db MUSIC_GRDUELTHEME_2 ; duel theme
	db $1d ; ?
	db COIN_GOLBAT ; coin

	db DANGEROUS_BENCH_DECK_ID
	tx DangerousBenchDeckName ; deck name
	tx DuelistTapName ; opponent name
	db TAP_PIC ; Pic ID
	db PRIZES_4 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $00 ; ?
	db MUSIC_DUELTHEME_1 ; duel theme
	db $26 ; ?
	db COIN_CHANSEY ; coin

	db CHAIN_LIGHTNING_BY_PIKACHU_DECK_ID
	tx ChainLightningByPikachuDeckName ; deck name
	tx DuelistRennaName ; opponent name
	db RENNA_PIC ; Pic ID
	db PRIZES_4 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $07 ; ?
	db MUSIC_GRDUELTHEME_1 ; duel theme
	db $18 ; ?
	db COIN_GR ; coin

	db THIS_IS_THE_POWER_OF_ELECTRICITY_DECK_ID
	tx ThisIsThePowerOfElectricityDeckName ; deck name
	tx DuelistIchikawaName ; opponent name
	db ICHIKAWA_PIC ; Pic ID
	db PRIZES_4 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $02 ; ?
	db MUSIC_GRDUELTHEME_1 ; duel theme
	db $18 ; ?
	db COIN_GR ; coin

	db QUICK_ATTACK_DECK_ID
	tx QuickAttackDeckName ; deck name
	tx DuelistCatherineName ; opponent name
	db CATHERINE_PIC ; Pic ID
	db PRIZES_6 ; number of prize cards
	db $02 ; special duel rules
	db $00 ; ?
	db MUSIC_GRDUELTHEME_2 ; duel theme
	db $1e ; ?
	db COIN_MAGNEMITE ; coin

	db COMPLETE_COMBUSTION_DECK_ID
	tx CompleteCombustionDeckName ; deck name
	tx DuelistJesName ; opponent name
	db JES_PIC ; Pic ID
	db PRIZES_4 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $00 ; ?
	db MUSIC_GRDUELTHEME_1 ; duel theme
	db $19 ; ?
	db COIN_GR ; coin

	db FIREBALL_DECK_ID
	tx FireballDeckName ; deck name
	tx DuelistYukiName ; opponent name
	db YUKI_PIC ; Pic ID
	db PRIZES_4 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $03 ; ?
	db MUSIC_GRDUELTHEME_1 ; duel theme
	db $19 ; ?
	db COIN_GR ; coin

	db EEVEE_SHOWDOWN_DECK_ID
	tx EeveeShowdownDeckName ; deck name
	tx DuelistShokoName ; opponent name
	db SHOKO_PIC ; Pic ID
	db PRIZES_4 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $08 ; ?
	db MUSIC_GRDUELTHEME_1 ; duel theme
	db $19 ; ?
	db COIN_GR ; coin

	db GAZE_UPON_THE_POWER_OF_FIRE_DECK_ID
	tx GazeUponThePowerOfFireDeckName ; deck name
	tx DuelistHideroName ; opponent name
	db HIDERO_PIC ; Pic ID
	db PRIZES_6 ; number of prize cards
	db $03 ; special duel rules
	db $00 ; ?
	db MUSIC_GRDUELTHEME_2 ; duel theme
	db $1f ; ?
	db COIN_MAGMAR ; coin

	db WHIRLPOOL_SHOWER_DECK_ID
	tx WhirlpoolShowerDeckName ; deck name
	tx DuelistMiyajimaName ; opponent name
	db MIYAJIMA_PIC ; Pic ID
	db PRIZES_4 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $04 ; ?
	db MUSIC_GRDUELTHEME_1 ; duel theme
	db $1a ; ?
	db COIN_GR ; coin

	db PARALYZED_PARALYZED_DECK_ID
	tx ParalyzedParalyzedDeckName ; deck name
	tx DuelistSentaName ; opponent name
	db SENTA_PIC ; Pic ID
	db PRIZES_4 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $09 ; ?
	db MUSIC_GRDUELTHEME_1 ; duel theme
	db $1a ; ?
	db COIN_GR ; coin

	db BENCH_CALL_DECK_ID
	tx BenchCallDeckName ; deck name
	tx DuelistAiraName ; opponent name
	db AIRA_PIC ; Pic ID
	db PRIZES_4 ; number of prize cards
	db $04 ; special duel rules
	db $00 ; ?
	db MUSIC_GRDUELTHEME_1 ; duel theme
	db $1a ; ?
	db COIN_GR ; coin

	db WATER_STREAM_DECK_ID
	tx WaterStreamDeckName ; deck name
	tx DuelistKanokoName ; opponent name
	db KANOKO_PIC ; Pic ID
	db PRIZES_6 ; number of prize cards
	db $05 ; special duel rules
	db $00 ; ?
	db MUSIC_GRDUELTHEME_2 ; duel theme
	db $20 ; ?
	db COIN_PSYDUCK ; coin

	db ROCK_BLAST_DECK_ID
	tx RockBlastDeckName ; deck name
	tx DuelistGodaName ; opponent name
	db GODA_PIC ; Pic ID
	db PRIZES_4 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $0c ; ?
	db MUSIC_GRDUELTHEME_1 ; duel theme
	db $1b ; ?
	db COIN_GR ; coin

	db FULL_STRENGTH_DECK_ID
	tx FullStrengthDeckName ; deck name
	tx DuelistGraceName ; opponent name
	db GRACE_PIC ; Pic ID
	db PRIZES_4 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $05 ; ?
	db MUSIC_GRDUELTHEME_1 ; duel theme
	db $1b ; ?
	db COIN_GR ; coin

	db RUNNING_WILD_DECK_ID
	tx RunningWildDeckName ; deck name
	tx DuelistKamiyaName ; opponent name
	db KAMIYA_PIC ; Pic ID
	db PRIZES_6 ; number of prize cards
	db $06 ; special duel rules
	db $00 ; ?
	db MUSIC_GRDUELTHEME_2 ; duel theme
	db $21 ; ?
	db COIN_MACHAMP ; coin

	db DIRECT_HIT_DECK_ID
	tx DirectHitDeckName ; deck name
	tx DuelistMiwaName ; opponent name
	db MIWA_PIC ; Pic ID
	db PRIZES_4 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $06 ; ?
	db MUSIC_GRDUELTHEME_1 ; duel theme
	db $1c ; ?
	db COIN_GR ; coin

	db SUPERDESTRUCTIVE_POWER_DECK_ID
	tx SuperDestructivePowerDeckName ; deck name
	tx DuelistKevinName ; opponent name
	db KEVIN_PIC ; Pic ID
	db PRIZES_4 ; number of prize cards
	db $07 ; special duel rules
	db $00 ; ?
	db MUSIC_GRDUELTHEME_1 ; duel theme
	db $1c ; ?
	db COIN_GR ; coin

	db BAD_DREAM_DECK_ID
	tx BadDreamDeckName ; deck name
	tx DuelistYosukeName ; opponent name
	db YOSUKE_PIC ; Pic ID
	db PRIZES_4 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $0a ; ?
	db MUSIC_GRDUELTHEME_1 ; duel theme
	db $1c ; ?
	db COIN_GR ; coin

	db POKEMON_POWER_DECK_ID
	tx PokemonsPowerDeckName ; deck name
	tx DuelistRyokoName ; opponent name
	db RYOKO_PIC ; Pic ID
	db PRIZES_4 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $0d ; ?
	db MUSIC_GRDUELTHEME_1 ; duel theme
	db $1c ; ?
	db COIN_GR ; coin

	db SPIRITED_AWAY_DECK_ID
	tx SpiritedAwayDeckName ; deck name
	tx DuelistMamiName ; opponent name
	db MAMI_PIC ; Pic ID
	db PRIZES_6 ; number of prize cards
	db $08 ; special duel rules
	db $00 ; ?
	db MUSIC_GRDUELTHEME_2 ; duel theme
	db $22 ; ?
	db COIN_MEW ; coin

	db SNORLAX_GUARD_DECK_ID
	tx SnorlaxGuardDeckName ; deck name
	tx DuelistNishijimaName ; opponent name
	db NISHIJIMA_PIC ; Pic ID
	db PRIZES_6 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $0e ; ?
	db MUSIC_GRDUELTHEME_2 ; duel theme
	db $23 ; ?
	db COIN_SNORLAX ; coin

	db EYE_OF_THE_STORM_DECK_ID
	tx EyeOfTheStormDeckName ; deck name
	tx DuelistIshiiName ; opponent name
	db ISHII_PIC ; Pic ID
	db PRIZES_6 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $0f ; ?
	db MUSIC_GRDUELTHEME_2 ; duel theme
	db $23 ; ?
	db COIN_SNORLAX ; coin

	db SUDDEN_GROWTH_DECK_ID
	tx SuddenGrowthDeckName ; deck name
	tx DuelistSamejimaName ; opponent name
	db SAMEJIMA_PIC ; Pic ID
	db PRIZES_6 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $10 ; ?
	db MUSIC_GRDUELTHEME_2 ; duel theme
	db $23 ; ?
	db COIN_SNORLAX ; coin

	db VERY_RARE_CARD_DECK_ID
	tx VeryRareCardDeckName ; deck name
	tx DuelistMrIshiharaName ; opponent name
	db ISHIHARA_PIC ; Pic ID
	db PRIZES_6 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $00 ; ?
	db MUSIC_ISHIHARA ; duel theme
	db $14 ; ?
	db COIN_JIGGLYPUFF ; coin

	db BAD_GUYS_DECK_ID
	tx BadGuysDeckName ; deck name
	tx DuelistKanzakiName ; opponent name
	db KANZAKI_PIC ; Pic ID
	db PRIZES_6 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $0b ; ?
	db MUSIC_GRDUELTHEME_2 ; duel theme
	db $24 ; ?
	db COIN_HORSEA ; coin

	db POISON_MIST_DECK_ID
	tx PoisonMistDeckName ; deck name
	tx DuelistRuiName ; opponent name
	db RUI_PIC ; Pic ID
	db PRIZES_6 ; number of prize cards
	db $09 ; special duel rules
	db $00 ; ?
	db MUSIC_GRDUELTHEME_2 ; duel theme
	db $24 ; ?
	db COIN_ARBOK ; coin

	db ULTRA_REMOVAL_DECK_ID
	tx UltraRemovalDeckName ; deck name
	tx DuelistRuiName ; opponent name
	db RUI_PIC ; Pic ID
	db PRIZES_6 ; number of prize cards
	db $0a ; special duel rules
	db $00 ; ?
	db MUSIC_GRDUELTHEME_2 ; duel theme
	db $24 ; ?
	db COIN_JIGGLYPUFF ; coin

	db PSYCHIC_BATTLE_DECK_ID
	tx PsychicBattleDeckName ; deck name
	tx DuelistRuiName ; opponent name
	db RUI_PIC ; Pic ID
	db PRIZES_6 ; number of prize cards
	db $07 ; special duel rules
	db $00 ; ?
	db MUSIC_GRDUELTHEME_2 ; duel theme
	db $24 ; ?
	db COIN_GENGAR ; coin

	db STOP_LIFE_DECK_ID
	tx ChokeDeckName ; deck name
	tx DuelistBiruritchiName ; opponent name
	db BIRURITCHI_PIC ; Pic ID
	db PRIZES_6 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $00 ; ?
	db MUSIC_GRDUELTHEME_3 ; duel theme
	db $25 ; ?
	db COIN_TOGEPI ; coin

	db SCORCHER_DECK_ID
	tx IncinerateDeckName ; deck name
	tx DuelistBiruritchiName ; opponent name
	db BIRURITCHI_PIC ; Pic ID
	db PRIZES_6 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $00 ; ?
	db MUSIC_GRDUELTHEME_3 ; duel theme
	db $25 ; ?
	db COIN_TOGEPI ; coin

	db TSUNAMI_STARTER_DECK_ID
	tx SmashDeckName ; deck name
	tx DuelistBiruritchiName ; opponent name
	db BIRURITCHI_PIC ; Pic ID
	db PRIZES_6 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $00 ; ?
	db MUSIC_GRDUELTHEME_3 ; duel theme
	db $25 ; ?
	db COIN_TOGEPI ; coin

	db SMASH_TO_MINCEMEAT_DECK_ID
	tx ThrowOutDeckName ; deck name
	tx DuelistBiruritchiName ; opponent name
	db BIRURITCHI_PIC ; Pic ID
	db PRIZES_6 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $00 ; ?
	db MUSIC_GRDUELTHEME_3 ; duel theme
	db $25 ; ?
	db COIN_TOGEPI ; coin

	db TEST_YOUR_LUCK_DECK_ID
	tx TestYourLuckDeckName ; deck name
	tx DuelistPawnName ; opponent name
	db PAWN_PIC ; Pic ID
	db PRIZES_4 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $00 ; ?
	db MUSIC_DUELTHEME_1 ; duel theme
	db $27 ; ?
	db COIN_JIGGLYPUFF ; coin

	db PROTOHISTORIC_DECK_ID
	tx ProtohistoricDeckName ; deck name
	tx DuelistKnightName ; opponent name
	db KNIGHT_PIC ; Pic ID
	db PRIZES_4 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $00 ; ?
	db MUSIC_DUELTHEME_2 ; duel theme
	db $27 ; ?
	db COIN_JIGGLYPUFF ; coin

	db TEXTURE_TUNER7_DECK_ID
	tx TextureTuner7DeckName ; deck name
	tx DuelistBishopName ; opponent name
	db BISHOP_PIC ; Pic ID
	db PRIZES_4 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $00 ; ?
	db MUSIC_GRDUELTHEME_1 ; duel theme
	db $27 ; ?
	db COIN_JIGGLYPUFF ; coin

	db COLORLESS_ENERGY_DECK_ID
	tx ColorlessEnergyDeckName ; deck name
	tx DuelistRookName ; opponent name
	db ROOK_PIC ; Pic ID
	db PRIZES_5 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $00 ; ?
	db MUSIC_GRDUELTHEME_1 ; duel theme
	db $27 ; ?
	db COIN_JIGGLYPUFF ; coin

	db POWERFUL_POKEMON_DECK_ID
	tx PowerfulPokemonDeckName ; deck name
	tx DuelistQueenName ; opponent name
	db QUEEN_PIC ; Pic ID
	db PRIZES_6 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $00 ; ?
	db MUSIC_GRDUELTHEME_2 ; duel theme
	db $27 ; ?
	db COIN_JIGGLYPUFF ; coin

	db WEIRD_DECK_ID
	tx WeirdDeckName ; deck name
	tx DuelistImakuniName ; opponent name
	db IMAKUNI_BLACK_PIC ; Pic ID
	db PRIZES_6 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $00 ; ?
	db MUSIC_IMAKUNI ; duel theme
	db $13 ; ?
	db COIN_PSYDUCK ; coin

	db STRANGE_DECK_ID
	tx StrangeDeckName ; deck name
	tx DuelistImakuniName ; opponent name
	db IMAKUNI_RED_PIC ; Pic ID
	db PRIZES_6 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $00 ; ?
	db MUSIC_IMAKUNI2 ; duel theme
	db $13 ; ?
	db COIN_JIGGLYPUFF ; coin

	db RONALDS_UNCOOL_DECK_ID
	tx RonaldsUncoolDeckName ; deck name
	tx DuelistRonaldName ; opponent name
	db RONALD_PIC ; Pic ID
	db PRIZES_6 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $00 ; ?
	db MUSIC_RONALD ; duel theme
	db $15 ; ?
	db COIN_RAICHU ; coin

	db RONALDS_GRX_DECK_ID
	tx RonaldsGRXDeckName ; deck name
	tx DuelistGRXName ; opponent name
	db GR_X_PIC ; Pic ID
	db PRIZES_6 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $00 ; ?
	db MUSIC_RONALD ; duel theme
	db $16 ; ?
	db COIN_RAICHU ; coin

	db RONALDS_POWER_DECK_ID
	tx RonaldsPowerDeckName ; deck name
	tx DuelistRonaldName ; opponent name
	db RONALD_PIC ; Pic ID
	db PRIZES_6 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $00 ; ?
	db MUSIC_RONALD ; duel theme
	db $15 ; ?
	db COIN_RAICHU ; coin

	db RONALDS_PSYCHIC_DECK_ID
	tx RonaldsSuperDeckName ; deck name
	tx DuelistRonaldName ; opponent name
	db RONALD_PIC ; Pic ID
	db PRIZES_6 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $00 ; ?
	db MUSIC_RONALD ; duel theme
	db $15 ; ?
	db COIN_RAICHU ; coin

	db RONALDS_ULTRA_DECK_ID
	tx RonaldsUltraDeckName ; deck name
	tx DuelistRonaldName ; opponent name
	db RONALD_PIC ; Pic ID
	db PRIZES_6 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $00 ; ?
	db MUSIC_RONALD ; duel theme
	db $15 ; ?
	db COIN_RAICHU ; coin

	db EVERYBODYS_FRIEND_DECK_ID
	tx EverybodysFriendDeckName ; deck name
	tx DuelistEijiName ; opponent name
	db EIJI_PIC ; Pic ID
	db PRIZES_6 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $00 ; ?
	db MUSIC_GRDUELTHEME_2 ; duel theme
	db $28 ; ?
	db COIN_LUGIA ; coin

	db IMMORTAL_POKEMON_DECK_ID
	tx ImmortalPokemonDeckName ; deck name
	tx DuelistMagicianName ; opponent name
	db MAGICIAN_PIC ; Pic ID
	db PRIZES_6 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $00 ; ?
	db MUSIC_GRDUELTHEME_2 ; duel theme
	db $28 ; ?
	db COIN_LUGIA ; coin

	db TORRENTIAL_FLOOD_DECK_ID
	tx TorrentialFloodDeckName ; deck name
	tx DuelistYuiName ; opponent name
	db YUI_PIC ; Pic ID
	db PRIZES_6 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $00 ; ?
	db MUSIC_GRDUELTHEME_2 ; duel theme
	db $28 ; ?
	db COIN_LUGIA ; coin

	db TRAINER_IMPRISON_DECK_ID
	tx TrainerImprisonDeckName ; deck name
	tx DuelistToshironName ; opponent name
	db TOSHIRON_PIC ; Pic ID
	db PRIZES_6 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $00 ; ?
	db MUSIC_GRDUELTHEME_2 ; duel theme
	db $28 ; ?
	db COIN_LUGIA ; coin

	db BLAZING_FLAME_DECK_ID
	tx BlazingFlameDeckName ; deck name
	tx DuelistPierrotName ; opponent name
	db PIERROT_PIC ; Pic ID
	db PRIZES_6 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $00 ; ?
	db MUSIC_GRDUELTHEME_2 ; duel theme
	db $28 ; ?
	db COIN_LUGIA ; coin

	db DAMAGE_CHAOS_DECK_ID
	tx DamageChaosDeckName ; deck name
	tx DuelistAnnaName ; opponent name
	db ANNA_PIC ; Pic ID
	db PRIZES_6 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $00 ; ?
	db MUSIC_GRDUELTHEME_2 ; duel theme
	db $28 ; ?
	db COIN_LUGIA ; coin

	db BIG_THUNDER_DECK_ID
	tx BigThunderDeckName ; deck name
	tx DuelistDeeName ; opponent name
	db DEE_PIC ; Pic ID
	db PRIZES_6 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $00 ; ?
	db MUSIC_GRDUELTHEME_2 ; duel theme
	db $28 ; ?
	db COIN_LUGIA ; coin

	db POWER_OF_DARKNESS_DECK_ID
	tx PowerOfDarknessDeckName ; deck name
	tx DuelistMasqueradeName ; opponent name
	db MASQUERADE_PIC ; Pic ID
	db PRIZES_6 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $00 ; ?
	db MUSIC_GRDUELTHEME_2 ; duel theme
	db $28 ; ?
	db COIN_LUGIA ; coin

	db POISON_STORM_DECK_ID
	tx PoisonStormDeckName ; deck name
	tx DuelistTobichanName ; opponent name
	db TOBICHAN_PIC ; Pic ID
	db PRIZES_6 ; number of prize cards
	db NO_SPECIAL_RULE ; special duel rules
	db $00 ; ?
	db MUSIC_GRDUELTHEME_2 ; duel theme
	db $28 ; ?
	db COIN_LUGIA ; coin

	db $ff ; end

; set [wcd55] = e
; then check deck requirement using the opponent offset in [wcd0e]
CheckDuelDeckRequirement::
	ld a, e
	ld [wcd55], a
	bank1call LoadPlayerDeck
	ld a, [wcd0e]
	ld hl, .DuelDeckRequirementPointers
	jp JumpToFunctionInTable

.DuelDeckRequirementPointers:
	dw NULL                      ; $00
	dw CheckMiyukiRequirement    ; $01
	dw CheckIchikawaRequirement  ; $02
	dw CheckYukiRequirement      ; $03
	dw CheckMiyajimaRequirement  ; $04
	dw CheckGraceRequirement     ; $05
	dw CheckMiwaRequirement      ; $06
	dw CheckRennaRequirement     ; $07
	dw CheckShokoRequirement     ; $08
	dw CheckSentaRequirement     ; $09
	dw CheckYosukeRequirement    ; $0a
	dw CheckKanzakiRequirement   ; $0b
	dw CheckGodaRequirement      ; $0c
	dw CheckRyokoRequirement     ; $0d
	dw CheckNishijimaRequirement ; $0e
	dw CheckIshiiRequirement     ; $0f
	dw CheckSamejimaRequirement  ; $10

CheckMiyukiRequirement:
	ld b, TYPE_ENERGY_GRASS
	jr CheckSoloEnergyRequirement

CheckIchikawaRequirement:
	ld b, TYPE_ENERGY_LIGHTNING
	jr CheckSoloEnergyRequirement

CheckYukiRequirement:
	ld b, TYPE_ENERGY_FIRE
	jr CheckSoloEnergyRequirement

CheckMiyajimaRequirement:
	ld b, TYPE_ENERGY_WATER
	jr CheckSoloEnergyRequirement

CheckGraceRequirement:
	ld b, TYPE_ENERGY_FIGHTING
	jr CheckSoloEnergyRequirement

CheckMiwaRequirement:
	ld b, TYPE_ENERGY_PSYCHIC
; fallthrough

; check if the deck has energy cards of different types than b
; return carry if so
CheckSoloEnergyRequirement:
	ld c, DECK_SIZE
	ld hl, wPlayerDeck
.scan_deck_loop
	ld e, [hl]
	inc hl
	ld d, [hl]
	inc hl
	call GetCardType
	bit 3, a
	jr z, .non_energy
	cp b
	jr nz, .found_different_energy
.non_energy
	dec c
	jr nz, .scan_deck_loop
	or a
	ret
.found_different_energy
	scf
	ret

CheckRennaRequirement:
	ld hl, Whitelist_Pikachu
	call CountListedCardsInDeck
	cp 4 ; amount
	ret

CheckShokoRequirement:
	ld hl, Whitelist_Eevee
	call CountListedCardsInDeck
	cp 4 ; amount
	ret

CheckSentaRequirement:
	ld hl, Whitelist_Magikarp
	call CountListedCardsInDeck
	cp 4 ; amount
	ret

CheckYosukeRequirement:
	ld hl, Whitelist_GastlyAndHaunter
	call CountListedCardsInDeck
	cp 6 ; amount
	ret

CheckKanzakiRequirement:
	ld de, MOLTRES_LV40
	call CountIfListedCardsInDeck
	ret c
	ld de, ARTICUNO_LV37
	call CountIfListedCardsInDeck
	ret c
	ld de, ZAPDOS_LV68
	call CountIfListedCardsInDeck
	ret c
	ld de, DRAGONITE_LV41
	call CountIfListedCardsInDeck
	ret

CheckGodaRequirement:
	ld hl, Blacklist_Removal
	call CountListedCardsInDeck
	ret

CheckRyokoRequirement:
	ld c, DECK_SIZE
	ld hl, wPlayerDeck
.scan_deck_loop
	ld e, [hl]
	inc hl
	ld d, [hl]
	inc hl
	call GetCardType
	cp TYPE_TRAINER
	jr z, .found_trainer
	dec c
	jr nz, .scan_deck_loop
	or a
	ret
.found_trainer
	scf
	ret

CheckNishijimaRequirement:
	ld e, 0 ; table offset
	jr CheckColorlessAltarRequirement

CheckIshiiRequirement:
	ld e, 3 ; table offset
	ld a, [wcd55]
	or a
	jr z, CheckDarkPokemonRequirement
	jr CheckColorlessAltarRequirement

CheckSamejimaRequirement:
	ld e, 6 ; table offset
	; fallthrough
CheckColorlessAltarRequirement:
	ld a, [wcd55]
	add e
	add a
	ld e, a
	ld d, 0
	ld hl, ColorlessAltarRequirementTable
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	push hl
	call CountListedCardsInDeck
	pop hl
	push af
	ld e, [hl]
	inc hl
	ld d, [hl]
	call LoadCardDataToBuffer1_FromCardID
	ld hl, wLoadedCard1Name
	ld a, [hli]
	ld h, [hl]
	ld l, a
	pop af
	cp 4 ; amount
	ret

CheckDarkPokemonRequirement:
	ld hl, wPlayerDeck
	ld c, 0
.scan_deck_loop
	ld e, [hl]
	inc hl
	ld d, [hl]
	inc hl
	ld a, e
	or d
	jr z, .scanned
	call LoadCardDataToBuffer1_FromCardID
	ld a, [wLoadedCard1Type]
	cp TYPE_ENERGY ; non-pokemon
	jr nc, .scan_deck_loop
	ld a, [wLoadedCard1Dark]
	or a
	jr z, .scan_deck_loop
	inc c
	jr .scan_deck_loop
.scanned
	ldtx hl, EffectTargetDarkPokemonText
	ld a, c
	cp 4 ; amount
	ret

Whitelist_Pikachu:
	dw PIKACHU_LV5
	dw PIKACHU_LV12
	dw PIKACHU_LV13
	dw PIKACHU_LV14
	dw PIKACHU_LV16
	dw PIKACHU_ALT_LV16
	dw NULL
Whitelist_Eevee:
	dw EEVEE_LV5
	dw EEVEE_LV9
	dw EEVEE_LV12
	dw NULL
Whitelist_Magikarp:
	dw MAGIKARP_LV6
	dw MAGIKARP_LV8
	dw MAGIKARP_LV10
	dw NULL
Whitelist_GastlyAndHaunter:
	dw GASTLY_LV8
	dw GASTLY_LV13
	dw GASTLY_LV17
	dw HAUNTER_LV17
	dw HAUNTER_LV22
	dw HAUNTER_LV25
	dw HAUNTER_LV26
	dw NULL
Blacklist_Removal:
	dw ENERGY_REMOVAL
	dw SUPER_ENERGY_REMOVAL
	dw NULL

ColorlessAltarRequirementTable:
	; Nishijima
	dw Whitelist_DCE
	dw Whitelist_Pidgey
	dw Whitelist_Spearow
	; Ishii
	dw NULL ; Dark Pokémon
	dw Whitelist_Rattata
	dw Whitelist_Meowth
	; Samejima
	dw Whitelist_MysteriousFossil
	dw Whitelist_Jigglypuff
	dw Whitelist_Dratini
Whitelist_DCE:
	dw DOUBLE_COLORLESS_ENERGY
	dw NULL
Whitelist_Pidgey:
	dw PIDGEY_LV8
	dw PIDGEY_LV10
	dw NULL
Whitelist_Spearow:
	dw SPEAROW_LV9
	dw SPEAROW_LV12
	dw SPEAROW_LV13
	dw NULL
Whitelist_Rattata:
	dw RATTATA_LV9
	dw RATTATA_LV12
	dw RATTATA_LV15
	dw NULL
Whitelist_Meowth:
	dw MEOWTH_LV10
	dw MEOWTH_LV13
	dw MEOWTH_LV14
	dw MEOWTH_LV15
	dw MEOWTH_LV17
	dw NULL
Whitelist_MysteriousFossil:
	dw MYSTERIOUS_FOSSIL
	dw NULL
Whitelist_Jigglypuff:
	dw JIGGLYPUFF_LV12
	dw JIGGLYPUFF_LV13
	dw JIGGLYPUFF_LV14
	dw NULL
Whitelist_Dratini:
	dw DRATINI_LV10
	dw DRATINI_LV12
	dw NULL

; output: a = b = total number of the target card(s)
CountListedCardsInDeck:
	ld b, 0
.target_card_loop
	ld e, [hl]
	inc hl
	ld d, [hl]
	inc hl
	ld a, d
	or e
	jr z, .no_more_targets
	push hl
	ld hl, wPlayerDeck
	ld c, DECK_SIZE
.scan_deck_loop
	ld a, [hl]
	cp e
	jr nz, .next_deck_card
	inc hl
	ld a, [hld]
	cp d
	jr nz, .next_deck_card
	inc b
.next_deck_card
	inc hl
	inc hl
	dec c
	jr nz, .scan_deck_loop
	pop hl
	jr .target_card_loop
.no_more_targets
	ld a, b
	or a
	ret z
	scf
	ret

CountIfListedCardsInDeck:
	ld hl, wPlayerDeck
	ld c, DECK_SIZE
.scan_deck_loop
	ld a, [hl]
	cp e
	jr nz, .next_deck_card
	inc hl
	ld a, [hld]
	cp d
	jr z, .found
.next_deck_card
	inc hl
	inc hl
	dec c
	jr nz, .scan_deck_loop
	scf
	ret
.found
	or a
	ret
; 0x260e7

SECTION "GBC Only Disclaimer", ROMX[$64fd], BANK[$9]
INCLUDE "engine/gbc_only_disclaimer.asm"
