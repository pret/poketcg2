INCLUDE "engine/save_duel.asm"

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
	ld a, SFX_CURSOR
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

; outputs in hl the next position
; in hTempList to place a new card,
; and increments hCurSelectionItem.
GetNextPositionInTempList:
	push de
	ld hl, hCurSelectionItem
	ld a, [hl]
	inc [hl]
	ld e, a
	ld d, $00
	ld hl, hTempList
	add hl, de
	pop de
	ret

; returns carry if Deck is empty
CheckIfDeckIsEmpty:
	ld a, DUELVARS_NUMBER_OF_CARDS_NOT_IN_DECK
	get_turn_duelist_var
	ldtx hl, NoCardsLeftInTheDeckText
	cp DECK_SIZE
	ccf
	ret

; returns carry if Play Area is full
CheckIfHasSpaceInBench:
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	ld hl, wMaxNumPlayAreaPokemon
	cp [hl]
	ldtx hl, NoSpaceOnTheBenchText
	ccf
	ret

; draw duel main scene, then print "<Pokemon Lv.XX>の\n<attack>!" text
; ("<arena pokemon>'s <attack>!")
DrawDuelMainScene_PrintPokemonsAttackText::
	bank1call DrawDuelMainScene
; fallthrough

; print "<Pokemon Lv.XX>の\n<attack>!" text
; ("<arena pokemon>'s <attack>!")
PrintPokemonsAttackText:
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call LoadCardDataToBuffer1_FromDeckIndex
	ld a, 18
	call CopyCardNameAndLevel
	ld [hl], TX_END
	ld hl, wTxRam2
	xor a
	ld [hli], a ; NULL
	ld [hli], a ;
	ld a, [wLoadedAttackName + 0]
	ld [hli], a
	ld a, [wLoadedAttackName + 1]
	ld [hli], a
	ldtx hl, PokemonsAttackText
	call DrawWideTextBox_PrintText
	ret

; display attack detail when the opponent's Pokemon uses an attack
DisplayOpponentUsedAttackScreen:
	bank1call ZeroObjectPositionsAndToggleOAMCopy
	call EmptyScreen
	call LoadDuelCardSymbolTiles
	call LoadDuelFaceDownCardTiles
	ldh a, [hTempCardIndex_ff9f]
	call LoadCardDataToBuffer1_FromDeckIndex
	ld a, CARDPAGE_POKEMON_OVERVIEW
	ld [wCardPageNumber], a
	ld hl, wLoadedCard1Atk1Name
	ld de, wLoadedCard1Atk1Description
	ld a, [wSelectedAttack]
	or a ; cp FIRST_ATTACK_OR_PKMN_POWER
	jr z, .got_atk
	ld hl, wLoadedCard1Atk2Name
	ld de, wLoadedCard1Atk2Description
.got_atk
	push hl
	push de
	ld e, 1
	bank1call PrintAttackOrPkmnPowerInformation
	lb de, 1, 4
	pop hl
	push hl
	bank1call PrintAttackOrCardDescription
	pop de
	pop hl
	inc de
	inc de
	ld a, [de]
	ld c, a
	inc de
	ld a, [de]
	dec de
	or c
	ret z ; no second page
; print second page info
	push de
	push hl
	call DrawWideTextBox
	call WaitForWideTextBoxInput
	pop hl
	ld e, 1
	bank1call PrintAttackOrPkmnPowerInformation
	lb de, 1, 4
	pop hl
; fallthrough

; hl = description ptr (WRAM)
; de = coordinates
PrintDescriptionFromHL:
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
	call PrintTextToDescriptionScreenTextBox
	bank1call PrintPlayAreaCardInformationAndLocation
	lb de, 1, 4
	call InitTextPrinting
	ld hl, wLoadedCard1Atk1Name
	call InitTextPrinting_ProcessTextFromPointerToID
	lb de, 1, 6
	ld hl, wLoadedCard1Atk1Description
	bank1call PrintAttackOrCardDescription
	ld hl, wLoadedCard1Atk1Description + 2
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
	ld hl, wLoadedCard1Atk1Description + 2
	lb de, 1, 6
	call PrintDescriptionFromHL
	ret

PrintUsedTrainerCardDescription:
	call EmptyScreen
	lb de, 1, 1
	ld hl, wLoadedCard1Name
	call InitTextPrinting_ProcessTextFromPointerToID
	ldtx hl, UsedText
	call PrintTextToDescriptionScreenTextBox
	lb de, 1, 4
	ld hl, wLoadedCard1NonPokemonDescription
	bank1call PrintAttackOrCardDescription
	ld hl, wLoadedCard1NonPokemonDescription + 2
	ld a, [hli]
	or [hl]
	jr z, .done ; no second page
; print second page info
	call WaitForWideTextBoxInput
	lb de, 1, 1
	ld hl, wLoadedCard1Name
	call InitTextPrinting_ProcessTextFromPointerToID
	ld hl, wLoadedCard1NonPokemonDescription + 2
	lb de, 1, 4
	call PrintDescriptionFromHL
.done
	call WaitForWideTextBoxInput
	ret

; hl = text ID
PrintTextToDescriptionScreenTextBox:
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
	ld a, SFX_POKEMON_EVOLUTION
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
	dw DuelTransmissionError                         ; OPPACTION_ERROR
	dw OppAction_PlayBasicPokemonCard                ; OPPACTION_PLAY_BASIC_PKMN
	dw OppAction_EvolvePokemonCard                   ; OPPACTION_EVOLVE_PKMN
	dw OppAction_PlayEnergyCard                      ; OPPACTION_PLAY_ENERGY
	dw OppAction_AttemptRetreat                      ; OPPACTION_ATTEMPT_RETREAT
	dw OppAction_FinishTurnWithoutAttacking          ; OPPACTION_FINISH_NO_ATTACK
	dw OppAction_PlayTrainerCard                     ; OPPACTION_PLAY_TRAINER
	dw OppAction_ExecuteTrainerCardEffectCommands    ; OPPACTION_EXECUTE_TRAINER_EFFECTS
	dw OppAction_BeginUseAttack                      ; OPPACTION_BEGIN_ATTACK
	dw OppAction_UseAttack                           ; OPPACTION_USE_ATTACK
	dw OppAction_PlayAttackAnimationDealAttackDamage ; OPPACTION_ATTACK_ANIM_AND_DAMAGE
	dw OppAction_DrawCard                            ; OPPACTION_DRAW_CARD
	dw OppAction_UsePokemonPower_NoEffect2           ; OPPACTION_USE_PKMN_POWER_NO_EFF2
	dw OppAction_UsePokemonPower                     ; OPPACTION_USE_PKMN_POWER
	dw OppAction_ExecutePokemonPowerEffect           ; OPPACTION_EXECUTE_PKMN_POWER_EFFECT
	dw OppAction_ForceSwitchActive                   ; OPPACTION_FORCE_SWITCH_ACTIVE
	dw OppAction_NoAction                            ; OPPACTION_NO_ACTION_0F
	dw OppAction_NoAction                            ; OPPACTION_NO_ACTION_10
	dw OppAction_TossCoinATimes                      ; OPPACTION_TOSS_COIN_A_TIMES
	dw OppAction_6b30                                ; OPPACTION_6B30
	dw OppAction_NoAction                            ; OPPACTION_NO_ACTION_13
	dw OppAction_UseMetronomeAttack                  ; OPPACTION_USE_METRONOME_ATTACK
	dw OppAction_6b15                                ; OPPACTION_6B15
	dw OppAction_DrawDuelMainScene                   ; OPPACTION_DUEL_MAIN_SCENE
	dw OppAction_ProcessPlayedPokemonCard            ; OPPACTION_PROCESS_PLAYED_PKMN
	dw OppAction_ProcessTriggeredPokemonPower        ; OPPACTION_PROCESS_TRIGGERED_PKMN_POWER
	dw OppAction_ComputerErrorPrompt                 ; OPPACTION_REACT_TO_COMPUTER_ERROR
	dw OppAction_ChallengePrompt                     ; OPPACTION_REACT_TO_CHALLENGE
	dw OppAction_ChallengeAccepted                   ; OPPACTION_ACCEPT_CHALLENGE_PUT_BASIC_PKMN

OppAction_DrawCard:
	call DrawCardFromDeck
	call nc, AddCardToHand
	ret

OppAction_FinishTurnWithoutAttacking:
	bank1call DrawDuelMainScene
	bank1call ClearNonTurnTemporaryDuelvars
	ld a, TRUE
	ld [wOpponentTurnEnded], a
	ld a, [wTurnEndedDueToComputerError]
	or a
	ret nz
	ldtx hl, FinishedTurnWithoutAttackingText
	call DrawWideTextBox_WaitForInput
	ret

OppAction_PlayEnergyCard:
	ldh a, [hTempPlayAreaLocation_ffa1]
	ldh [hTempPlayAreaLocation_ff9d], a
	ld e, a
	ldh a, [hTemp_ffa0]
	ldh [hTempCardIndex_ff98], a
	call PutHandCardInPlayArea
	ldh a, [hTemp_ffa0]
	call LoadCardDataToBuffer1_FromDeckIndex
	call DrawLargePictureOfCard
	call PrintAttachedEnergyToPokemon
	ld a, TRUE
	ld [wAlreadyPlayedEnergy], a
	bank1call DrawDuelMainScene
	bank1call Func_6986
	ret

OppAction_EvolvePokemonCard:
	ldh a, [hTempPlayAreaLocation_ffa1]
	ldh [hTempPlayAreaLocation_ff9d], a
	ldh a, [hTemp_ffa0]
	ldh [hTempCardIndex_ff98], a
	call LoadCardDataToBuffer1_FromDeckIndex
	call DrawLargePictureOfCard
	call EvolvePokemonCardIfPossible
	call PrintPokemonEvolvedIntoPokemon
	ld a, TRUE
	ld [wSkipDuelistIsThinkingDelay], a
	ret

OppAction_PlayBasicPokemonCard:
	ldh a, [hTemp_ffa0]
	ldh [hTempCardIndex_ff98], a
	call PutHandPokemonCardInPlayArea
	ldh [hTempPlayAreaLocation_ff9d], a
	add DUELVARS_ARENA_CARD_STAGE
	get_turn_duelist_var
	ld [hl], BASIC
	ldh a, [hTemp_ffa0]
	ldtx hl, PlacedOnBenchText
	bank1call DisplayCardDetailScreen
	ld a, TRUE
	ld [wSkipDuelistIsThinkingDelay], a
	ret

; now handle KOs by Pokemon Power effects
OppAction_AttemptRetreat:
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	push af
	bank1call AttemptRetreat
	ldtx hl, RetreatWasUnsuccessfulText
	jr c, .failed
	or a
	jr z, .knocked_out
	xor a
	ld [wDuelDisplayedScreen], a
	ldtx hl, RetreatedToTheBenchText
.failed
	push hl
	bank1call DrawDuelMainScene
	pop hl
	pop af
	push hl
	call LoadCardNameToTxRam2
	pop hl
	call DrawWideTextBox_WaitForInput
	ret
.knocked_out
	pop af
	bank1call DrawDuelMainScene
	ret

OppAction_PlayTrainerCard:
	bank1call LoadNonPokemonCardEffectCommands
	call DisplayUsedTrainerCardDetailScreen
	call PrintUsedTrainerCardDescription
	call ExchangeRNG
	ld a, TRUE
	ld [wSkipDuelistIsThinkingDelay], a
	ret

OppAction_ExecuteTrainerCardEffectCommands:
	ld a, EFFECTCMDTYPE_DISCARD_ENERGY
	call TryExecuteEffectCommandFunction
	ld a, EFFECTCMDTYPE_BEFORE_DAMAGE
	call TryExecuteEffectCommandFunction
	bank1call DrawDuelMainScene
	ldh a, [hTempCardIndex_ff9f]
	call MoveHandCardToDiscardPile
	call ExchangeRNG
	bank1call DrawDuelMainScene
	ret

OppAction_BeginUseAttack:
	ldh a, [hTempCardIndex_ff9f]
	ld d, a
	ldh a, [hTemp_ffa0]
	ld e, a
	call CopyAttackDataAndDamage_FromDeckIndex
	call UpdateTempDuelistCardIDsAndClearTwoTurnDuelVars
	call DisplayOpponentUsedAttackScreen
	call PrintPokemonsAttackText
	call WaitForWideTextBoxInput
	call ExchangeRNG
	ld a, TRUE
	ld [wSkipDuelistIsThinkingDelay], a
	bank1call HandleSandAttackSmokescreenOrLightningFlashSubstatus
	ret nc
	bank1call ClearNonTurnTemporaryDuelvars
	ld a, TRUE
	ld [wOpponentTurnEnded], a
	ret

OppAction_UseAttack:
	call CheckSelfConfusionDamage
	jr c, .confusion_damage
	call ExchangeRNG
	ld a, TRUE
	ld [wSkipDuelistIsThinkingDelay], a
	ret
.confusion_damage
	call HandleConfusionDamageToSelf
	ld a, TRUE
	ld [wOpponentTurnEnded], a
	ret

; now handle EFFECTCMDTYPE_DISCARD_ENERGY here
OppAction_PlayAttackAnimationDealAttackDamage:
	ldh a, [hTempCardIndex_ff9f]
	cp -1
	jr z, .metronome_unsuccessful
	ld a, EFFECTCMDTYPE_DISCARD_ENERGY
	call TryExecuteEffectCommandFunction
	call PlayAttackAnimation_DealAttackDamage
	ld a, TRUE
	ld [wOpponentTurnEnded], a
	ret
.metronome_unsuccessful
	call ShowMetronomeUnsuccessfulText
	ld a, TRUE
	ld [wOpponentTurnEnded], a
	ret

OppAction_ForceSwitchActive:
	ldtx hl, SelectBenchedPokemonToSwitchWithActiveText
	call DrawWideTextBox_WaitForInput
	call SwapTurn
	bank1call HasAlivePokemonInBench
.force_selection
	bank1call OpenPlayAreaScreenForSelection
	jr c, .force_selection
	call SwapTurn
	ldh a, [hTempPlayAreaLocation_ff9d]
	call SerialSendByte
	ret

OppAction_UsePokemonPower_NoEffect2:
	ldh a, [hTempCardIndex_ff9f]
	ld d, a
	ld e, FIRST_ATTACK_OR_PKMN_POWER
	call CopyAttackDataAndDamage_FromDeckIndex
	call ClearTwoTurnDuelVars
	ldh a, [hTemp_ffa0]
	ldh [hTempPlayAreaLocation_ff9d], a
	ldh a, [hTempCardIndex_ff9f]
	call LoadCardNameToTxRam2
	ld hl, wLoadedAttackName
	ld a, [hli]
	ld [wTxRam2_b], a
	ld a, [hl]
	ld [wTxRam2_b + 1], a
	ldtx hl, UsePokemonPowerText
	call DisplayUsePokemonPowerScreen
	call WaitForWideTextBoxInput
	ret

OppAction_UsePokemonPower:
	ldh a, [hTempCardIndex_ff9f]
	ld d, a
	ld e, FIRST_ATTACK_OR_PKMN_POWER
	call CopyAttackDataAndDamage_FromDeckIndex
	call ClearTwoTurnDuelVars
	ldh a, [hTemp_ffa0]
	ldh [hTempPlayAreaLocation_ff9d], a
	ld a, EFFECTCMDTYPE_INITIAL_EFFECT_2
	call TryExecuteEffectCommandFunction
	ld a, [wcd0d]
	or a
	jr nz, .exit
	ldh a, [hTempCardIndex_ff9f]
	call LoadCardNameToTxRam2
	ld hl, wLoadedAttackName
	ld a, [hli]
	ld [wTxRam2_b], a
	ld a, [hl]
	ld [wTxRam2_b + 1], a
	ldtx hl, UsePokemonPowerText
	call DisplayUsePokemonPowerScreen
	call WaitForWideTextBoxInput
.exit
	call ExchangeRNG
	ld a, TRUE
	ld [wSkipDuelistIsThinkingDelay], a
	ret

OppAction_ExecutePokemonPowerEffect:
	farcall ResetAttackAnimationIsPlaying
	ld a, EFFECTCMDTYPE_BEFORE_DAMAGE
	call TryExecuteEffectCommandFunction
	ld a, TRUE
	ld [wSkipDuelistIsThinkingDelay], a
	ret

; transfer-based Pokemon Power
; now EFFECTCMDTYPE_UNK_11 instead of EFFECTCMDTYPE_AFTER_DAMAGE
OppAction_6b15:
	ld a, EFFECTCMDTYPE_UNK_11
	call TryExecuteEffectCommandFunction
	ld a, TRUE
	ld [wSkipDuelistIsThinkingDelay], a
	ret

OppAction_DrawDuelMainScene:
	bank1call DrawDuelMainScene
	ret

OppAction_TossCoinATimes:
	call SerialRecv8Bytes
	push af
	call LoadTxRam3
	pop af
	call TossCoinATimes
	ld a, TRUE
	ld [wSkipDuelistIsThinkingDelay], a
	ret

OppAction_6b30:
	ldh a, [hWhoseTurn]
	push af
	ldh a, [hTemp_ffa0]
	ldh [hWhoseTurn], a
	call PlayDeckShuffleAnimation
	pop af
	ldh [hWhoseTurn], a
	ret

OppAction_UseMetronomeAttack:
	bank1call DrawDuelMainScene
	call SerialRecv8Bytes
	push bc
	ld [wMetronomeAttackCannotBeUsed], a
	call SwapTurn
	call CopyAttackDataAndDamage_FromDeckIndex
	call SwapTurn
	ldh a, [hTempCardIndex_ff9f]
	ld [wPlayerAttackingCardIndex], a
	ld a, [wSelectedAttack]
	ld [wPlayerAttackingAttackIndex], a
	ld a, [wTempCardID_ccc2]
	ld [wPlayerAttackingCardID], a
	ld a, [wTempCardID_ccc2 + 1]
	ld [wPlayerAttackingCardID + 1], a
	call UpdateTempDuelistCardIDsAndClearTwoTurnDuelVars
	pop bc
	ld a, c
	ld [wMetronomeEnergyCost], a
	call PrintPokemonsAttackText
	call WaitForWideTextBoxInput
	ret

OppAction_ProcessPlayedPokemonCard:
	ldh a, [hTemp_ffa0]
	ldh [hTempPlayAreaLocation_ff9d], a
	bank1call ProcessPlayedPokemonCard.Process
	ret nc
	bank1call DrawDuelMainScene
	ret

; EFFECTCMDTYPE_PKMN_POWER_TRIGGER
OppAction_ProcessTriggeredPokemonPower:
	bank1call ProcessPlayedPokemonCard.TriggerPkmnPower
	bank1call DrawDuelMainScene
	ret

OppAction_ComputerErrorPrompt:
	ldh a, [hTemp_ffa0]
	ld l, a
	ld h, 0
	call LoadTxRam3
	ldtx hl, DuelistDrawCardsText
	call DrawWideTextBox_WaitForInput
	call SwapTurn
	call HandleComputerErrorPlayerSelection
	call SwapTurn
	call SerialSendByte
	ret

OppAction_ChallengePrompt:
	call SwapTurn
	bank1call DrawDuelMainScene
	ldtx hl, ChallengePromptText
	call YesOrNoMenuWithText
	call SwapTurn
	call SerialSendByte
	ret

OppAction_ChallengeAccepted:
	call PrintHowManyCardsLinkOpponentChoseDueToChallenge
	call SwapTurn
	call HandleChallengeCardPlayerSelection
	call SetOppAction_SerialSendDuelData
	call SwapTurn
	ret

OppAction_NoAction:
	ret

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

PlayDeckShuffleAnimation:
	ld a, [wDuelDisplayedScreen]
	cp SHUFFLE_DECK
	jr z, .skip_draw_scene
	bank1call ZeroObjectPositionsAndToggleOAMCopy
	call EmptyScreen
	call DrawDuelistPortraitsAndNames
.skip_draw_scene
	ld a, SHUFFLE_DECK
	ld [wDuelDisplayedScreen], a

; if duelist has only one card in deck,
; skip shuffling animation
	ld a, DUELVARS_NUMBER_OF_CARDS_NOT_IN_DECK
	get_turn_duelist_var
	ld a, DECK_SIZE
	sub [hl]
	cp 2
	jr c, .one_card_in_deck

	ldtx hl, ShufflesTheDeckText
	call DrawWideTextBox_PrintText
	call EnableLCD
	call ResetAnimationQueue

; load correct animation depending on turn duelist
	ld e, DUEL_ANIM_PLAYER_SHUFFLE
	ldh a, [hWhoseTurn]
	cp PLAYER_TURN
	jr z, .load_anim
	ld e, DUEL_ANIM_OPP_SHUFFLE
.load_anim
; play animation 3 times
REPT 3
	ld a, e
	call PlayDuelAnimation
ENDR

.loop_anim
	call DoFrame
	bank1call CheckSkipDelayAllowed
	jr c, .done_anim
	call CheckAnyAnimationPlaying
	jr c, .loop_anim

.done_anim
	call FinishQueuedAnimations
	ld a, $01
	ret

.one_card_in_deck
; no animation, just print text and delay
	ld l, a
	ld h, $00
	call LoadTxRam3
	ldtx hl, DeckPileCardCountText
	call DrawWideTextBox_PrintText
	call EnableLCD
	ld a, 60
.loop_wait
	call DoFrame
	dec a
	jr nz, .loop_wait
	ld a, $01
	ret

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
	ld a, SFX_PLACE_PRIZE
	call PlaySFX
	; print new deck card number
	lb bc, 3, 5
	ld a, e
	bank1call WriteTwoDigitNumberInTxSymbol_PadSpace
	lb bc, 18, 7
	ld a, e
	bank1call WriteTwoDigitNumberInTxSymbol_PadSpace
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
	bank1call WriteTwoDigitNumberInTxSymbol_PadSpace
	ld a, e
	lb bc, 10, 10
	bank1call WriteTwoDigitNumberInTxSymbol_PadSpace
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
	bank1call WriteTwoDigitNumberInTxSymbol_PadSpace
	ld a, e
	lb bc, 11, 3
	bank1call WriteTwoDigitNumberInTxSymbol_PadSpace
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

; draws a menu on screen for selecting number of cards
; that player chooses to draw from the deck
; due to the effects of Computer Error
HandleComputerErrorPlayerSelection:
	call EmptyScreen
	lb de, 0, 0
	lb bc, 20, 13
	call DrawRegularTextBox
	ldtx hl, ComputerErrorPromptText
	call DrawWideTextBox_PrintText

	ld a, DUELVARS_NUMBER_OF_CARDS_NOT_IN_DECK
	get_turn_duelist_var
	ld a, DECK_SIZE
	sub [hl]
	; a = num cards in deck
	ld c, 5
	cp c
	jr nc, .got_num_cards
	ld c, a ; load num cards left
.got_num_cards
	inc c ; plus 1 due to 0
	ld a, c
	ld [wNumCardsBeingDrawn], a

	; draws 0 1 2 3 4 5
	lb de, 2, 2
	ld b, SYM_0
.loop_draw_numbers
	push bc
	ld a, b
	ld c, e
	ld b, d
	call WriteByteToBGMap0
	push de
	inc d ; y + 1
	ldtx hl, EffectTargetCardsUnitText
	call InitTextPrinting_ProcessTextFromID
	pop de
	pop bc
	inc e ; increment x
	inc b ; increment digit to draw
	dec c
	jr nz, .loop_draw_numbers

	call EnableLCD
	ld hl, .MenuParameters
	xor a
	call InitializeMenuParameters
	ld a, [wNumCardsBeingDrawn]
	ld [wNumScrollMenuItems], a
.loop_input
	call DoFrame
	call HandleMenuInput
	jr nc, .loop_input
	cp MENU_CANCEL
	jr z, .loop_input ; mandatory
	ldh a, [hCurScrollMenuItem]
	ret

.MenuParameters:
	menu_params 1, 2, 1, 6, SYM_CURSOR_R, SYM_SPACE, NULL

; handles player selection when opponent
; accepts challenge due to the effects of Challenge! card
HandleChallengeCardPlayerSelection:
	ldh a, [hTemp_ffa0]
	ldh [hCurSelectionItem], a
	call CreateDeckCardList
	jr nc, .has_deck_cards
	; no cards
	ldtx hl, NoCardsLeftInTheDeckText
	call DrawWideTextBox_WaitForInput
	jr .done_selection

.has_deck_cards
	call CheckIfHasSpaceInBench
	jr nc, .has_space_in_bench
	call DrawWideTextBox_WaitForInput
	ldtx hl, NoTargetsButCheckDeckPromptText
	call YesOrNoMenuWithText_SetCursorToYes
	jr c, .done_selection

	; no space in Bench, but player chose to look at deck anyway
	call CreateDeckCardList ; unnecessary, already done above
	bank1call InitAndDrawCardListScreenLayout
	ldtx hl, ChooseCardToCheckText
	ldtx de, DuelistDeckText
	bank1call SetCardListHeaderAndInfoText
	ld a, PAD_A | PAD_START
	ld [wNoItemSelectionMenuKeys], a
	bank1call DisplayCardList
	jr .done_selection

.has_space_in_bench
	; get number of maximum cards that can select
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	ld a, [wMaxNumPlayAreaPokemon]
	sub [hl]
	ld [wNumberOfCardsToOrder], a
.start_selection
	bank1call InitAndDrawCardListScreenLayout_WithSelectCheckMenu
	ldtx hl, ChooseBasicPokemonText
	ldtx de, DuelistDeckText
	bank1call SetCardListHeaderAndInfoText
.loop_selection
	bank1call DisplayCardList
	ldh [hTempCardIndex_ff98], a
	cp MENU_CANCEL
	jr z, .try_cancel ; player cancelled operation
	call LoadCardDataToBuffer2_FromDeckIndex
	ld a, [wLoadedCard2Type]
	cp TYPE_ENERGY
	jr nc, .loop_selection ; not Pkmn
	ld a, [wLoadedCard2Stage]
	or a
	jr nz, .loop_selection ; not Basic
	; add this Basic Pokémon to hTempList
	call GetNextPositionInTempList
	ldh a, [hTempCardIndex_ff98]
	ld [hl], a
	call RemoveCardFromDuelTempList
	jr c, .done_selection
	; check if we are done selecting
	ld hl, wNumberOfCardsToOrder
	dec [hl]
	jr nz, .start_selection

.done_selection
	call GetNextPositionInTempList
	ld [hl], $ff ; terminating byte
	ldh a, [hCurSelectionItem]
	ldh [hTemp_ffa0], a
	ret

.try_cancel
	; prompt player if they still want to exit
	; since they can still select more cards
	ld a, [wNumberOfCardsToOrder]
	ld l, a
	ld h, $00
	call LoadTxRam3
	ldtx hl, MaySelectMoreCardsButQuitPromptText
	call YesOrNoMenuWithText
	jr c, .start_selection
	jr .done_selection

PrintHowManyCardsLinkOpponentChoseDueToChallenge:
	ldh a, [hTemp_ffa0]
	sub $02
	ld hl, wTxRam3
	ld [hli], a
	ld [hl], $00
	inc hl
	push hl
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	ld a, [wTxRam3]
	add [hl]
	pop hl
	ld [hli], a
	ld [hl], TX_END
	ldtx hl, DuelistSelectsPokemonTotalNumberText
	call DrawWideTextBox_WaitForInput
	ret

; input:
; - a = CARDSEARCH_* constant
; - de = parameter for card search function
; - hl = text to print while selecting target in deck
; - bc = target name to print in case target not found
; returns -1 in a if no valid target found in wDuelTempList
; and carry set if player agreed to check deck anyway
LookForCardsInDeck:
	push hl
	push bc
	call SetCardSearchFuncParams
	ld a, [wDuelTempList]
	cp $ff
	jr z, .none_in_deck

	ld hl, wDuelTempList
.loop_deck
	ld a, [hli]
	cp $ff
	jr z, .none_in_deck
	call ExecuteCardSearchFunc
	jr nc, .loop_deck
	pop bc
	pop hl
	call DrawWideTextBox_WaitForInput
	xor a
	ld [wCardSearchResult], a
	ret

.none_in_deck
	pop hl
	call LoadTxRam2
	pop hl
	ldtx hl, NoTargetsInDeckText
	call DrawWideTextBox_WaitForInput
	ldtx hl, NoTargetsButCheckDeckPromptText
	call YesOrNoMenuWithText_SetCursorToYes
	ld a, $ff
	ld [wCardSearchResult], a
	ret

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
	dw .SearchPkmn                   ; CARDSEARCH_POKEMON
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

; returns carry if input card is a Pokémon Card
.SearchPkmn:
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

; displays the deck card selection screen for a specific target
; the target is set by a previous call to SetCardSearchFuncParams
; expected to be called after LookForCardsInDeck, since
; we need to know whether there is a valid target or not in wCardSearchResult
; input:
; - hl = info text ID
; - de = header text ID
; returns carry if no selection made, else return selection in [hTempCardIndex_ff98]
SelectCardSearchTarget:
	push hl
	push de
	bank1call InitAndDrawCardListScreenLayout_WithSelectCheckMenu
	pop de
	pop hl
	bank1call SetCardListHeaderAndInfoText
.loop
	; player input for selection
	bank1call DisplayCardList
	jr c, .check_can_exit
	; is selected card valid selection?
	call ExecuteCardSearchFunc
	jr nc, .invalid_selection
	ld a, [wCardSearchResult]
	or a
	jr nz, .loop
	; valid selection
	ldh a, [hTempCardIndex_ff98]
	or a
	ret

.check_can_exit
	ld a, [wCardSearchResult]
	or a
	jr nz, .exit_without_selecting
.invalid_selection
	call PlaySFX_InvalidChoice
	jr .loop

.exit_without_selecting
	ld a, $ff
	scf
	ret

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
	dw $4896 ; TrainerCardAsPokemonEffectCommands ; CARD_DATA_ATTACK1_EFFECT_COMMANDS
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

; handles drawing and selection of screen for
; choosing a color (excluding colorless), for use
; of Shift Pkmn Power and Conversion attacks.
; outputs in a the color that was selected
; input:
;	a  = Play Area location (PLAY_AREA_*), with:
;	     bit 7 not set if it's applying to opponent's card
;	     bit 7 set if it's applying to player's card
;	hl = text to be printed in the bottom box
; output:
;	a = color that was selected
HandleColorChangeScreen:
	or a
	call z, SwapTurn
	push af
	call Func_24ef5
	pop af
	call z, SwapTurn

	ld hl, .menu_params
	xor a
	call InitializeMenuParameters
	call EnableLCD

.loop_input
	call DoFrame
	call HandleMenuInput
	jr nc, .loop_input
	cp MENU_CANCEL ; b pressed?
	jr z, .loop_input
	ld e, a
	ld d, $00
	ld hl, ShiftListItemToColor
	add hl, de
	ld a, [hl]
	or a
	ret

	scf
	ret

.menu_params
	menu_params 1, 1, 2, MAX_PLAY_AREA_POKEMON, SYM_CURSOR_R, SYM_SPACE, NULL

Func_24ef5:
	push hl
	push af
	call EmptyScreen
	call ZeroObjectPositions
	call LoadDuelCardSymbolTiles
	bank1call Func_6c12

; load card data
	pop af
	and $7f
	ld [wTempPlayAreaLocation_cceb], a
	add DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call LoadCardDataToBuffer1_FromDeckIndex

; draw card gfx
	ld de, v0Tiles1 + $20 tiles ; destination offset of loaded gfx
	ld hl, wLoadedCard1Gfx
	ld a, [hli]
	ld h, [hl]
	ld l, a
	lb bc, $30, TILE_SIZE
	call LoadCardGfx
	lb de, 9, 2
	bank1call DrawCardGfxToDE_BGPalIndex5
	bank1call FlushAllPalettesIfNotDMG
	ld a, $a0
	lb hl, 6, 1
	lb de, 9, 2
	lb bc, 8, 6
	call FillRectangle
	bank1call StubbedApplyBGP6OrSGB3ToCardImage

; print card name and level at the top
	ld a, 16
	call CopyCardNameAndLevel
	ld [hl], TX_END
	lb de, 7, 0
	call InitTextPrinting
	ld hl, wDefaultText
	call ProcessText

	ld hl, ShiftMenuData
	call PlaceTextItems

; print card's color, resistance and weakness
	ld a, [wTempPlayAreaLocation_cceb]
	bank1call GetPlayAreaCardColor
	inc a
	lb bc, 14, 9
	call WriteByteToBGMap0
	ld a, [wTempPlayAreaLocation_cceb]
	bank1call GetPlayAreaCardWeakness
	lb bc, 14, 10
	bank1call PrintCardPageWeaknessesOrResistances
	ld a, [wTempPlayAreaLocation_cceb]
	bank1call GetPlayAreaCardResistance
	lb bc, 14, 11
	bank1call PrintCardPageWeaknessesOrResistances

	call DrawWideTextBox

; print list of color names on all list items
	lb de, 5, 1
	ldtx hl, ColorListText
	call InitTextPrinting_ProcessTextFromID

; print input hl to text box
	lb de, 1, 14
	pop hl
	call InitTextPrinting_ProcessTextFromID

; draw and apply palette to color icons
	ld hl, ColorTileAndBGP
	lb de, 2, 0
	ld c, NUM_COLORED_TYPES
.loop_colors
	ld a, [hli]
	push de
	push bc
	push hl
	lb hl, 1, 2
	lb bc, 2, 2
	call FillRectangle

	; this is a remnant from TCG1
	; console is always CGB
	ld a, [wConsole]
	cp CONSOLE_CGB
	jr nz, .skip_vram1
	pop hl
	push hl
	call BankswitchVRAM1
	ld a, [hl]
	lb hl, 0, 0
	lb bc, 2, 2
	call FillRectangle
	call BankswitchVRAM0

.skip_vram1
	pop hl
	pop bc
	pop de
	inc hl
	inc e
	inc e
	dec c
	jr nz, .loop_colors
	ret

ShiftMenuData:
	textitem 10,  9, TypeText
	textitem 10, 10, WeaknessText
	textitem 10, 11, ResistanceText
	textitems_end

ColorTileAndBGP:
	; tile, BG
	db $e4, $03
	db $e0, $02
	db $ec, $03
	db $e8, $02
	db $f0, $04
	db $f4, $04

ShiftListItemToColor:
	db GRASS
	db FIRE
	db WATER
	db LIGHTNING
	db FIGHTING
	db PSYCHIC

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
	cp MENU_CANCEL
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
	cp MENU_CANCEL
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
; returns MENU_CANCEL instead
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
	ld a, MENU_CANCEL
	ret

.MenuParameters:
	menu_params 11, 2, 2, 5, SYM_CURSOR_R, SYM_SPACE, .UpdateFunc

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
	ld a, MENU_CANCEL
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
	bank1call WriteOneByteNumberInTxSymbol_PadSpace
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
.GetDeckCardCounts
	ld e, l
	ld d, h
	ld hl, wPlayerDeck
	push hl
	call EnableSRAM
	bank1call DecompressSRAMDeck
	call DisableSRAM
	pop hl

.asm_25461
	push hl
	ld hl, wDeckCheckCardCounts
	ld c, DECKCHECKSTRUCT_LENGTH
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
	ld e, DECKCHECKSTRUCT_TRAINER
	cp TYPE_TRAINER
	jr z, .got_type
	ld e, DECKCHECKSTRUCT_ENERGY
	cp TYPE_ENERGY
	jr nc, .got_type
	ld e, DECKCHECKSTRUCT_BASIC_PKMN
	ld a, [wLoadedCard1Stage]
	or a
	jr z, .got_type
	ld e, DECKCHECKSTRUCT_STAGE1_PKMN
	cp STAGE1
	jr z, .got_type
	ld e, DECKCHECKSTRUCT_STAGE2_PKMN
.got_type
	ld d, 0
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
	db BEGINNING_POKEMON,     PROMOTIONAL,          10, 0, 0,  0 ; BOOSTER_DEBUG_10_STAR
	db BEGINNING_POKEMON,     BEGINNING_POKEMON,     0, 0, 0, 10 ; BOOSTER_PRESENT_10_ENERGY
	db BEGINNING_POKEMON,     TEAM_ROCKETS_AMBITION, 1, 3, 6,  0 ; BOOSTER_PRESENT_FROM_ALL_SETS
	db BEGINNING_POKEMON,     SKY_FLYING_POKEMON,    1, 3, 6,  0 ; BOOSTER_PRESENT_FROM_NON_ROCKET_SETS
	db PSYCHIC_BATTLE,        TEAM_ROCKETS_AMBITION, 1, 3, 6,  0 ; BOOSTER_PRESENT_FROM_LATTER_4_SETS
	db WE_ARE_TEAM_ROCKET,    TEAM_ROCKETS_AMBITION, 1, 3, 6,  0 ; BOOSTER_PRESENT_FROM_ROCKET_SETS
	db BEGINNING_POKEMON,     TEAM_ROCKETS_AMBITION, 2, 3, 5,  0 ; BOOSTER_DEBUG_2_STAR

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
	ld [wDeckRequirement], a
	ld a, [hli]
	ld [wDuelTheme], a
	ld a, [hli]
	ld [wDuelistIntroText], a
	ld a, [hli]
	ld [wOppCoin], a
	or a
	ret

INCLUDE "data/deck_id_data.asm"

; set [wcd55] = e
; then check deck requirement using the opponent offset in [wDeckRequirement]
CheckDuelDeckRequirement::
	ld a, e
	ld [wcd55], a
	bank1call LoadPlayerDeck
	ld a, [wDeckRequirement]
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

; for a card in de,
; create in wDuelTempList a list of its unique evo cards
; also set carry if at least 1
_ListUniqueEvoCardsFromDE:
	call LoadCardDataToBuffer1_FromCardID
	ld hl, wLoadedCard1Name
	ld c, [hl]
	inc hl
	ld b, [hl]
	ld hl, wDuelTempList
	ld de, GRASS_ENERGY - 1 ; 0
.loop_cards
	inc de
	push hl
	push de
	call LoadCardDataToBuffer1_FromCardID
	jr c, .exit
	ld a, [wLoadedCard1Type]
	cp TYPE_ENERGY
	jr nc, .next_card
	ld hl, wLoadedCard1PreEvoName
	ld a, c
	cp [hl]
	jr nz, .next_card
	inc hl
	ld a, b
	cp [hl]
	jr nz, .next_card
; found evo
	pop de
	pop hl
	ld [hl], e
	inc hl
	ld [hl], d
	inc hl
	jr .loop_cards
.next_card
	pop de
	pop hl
	jr .loop_cards

.exit
	pop de
	pop hl
; append $0000 terminator
	xor a
	ld [hli], a
	ld [hl], a
	ld hl, wDuelTempList
	ld a, [hli]
	or [hl]
	ret z ; empty
; not empty
	scf
	ret

INCLUDE "engine/bills_pc.asm"

INCLUDE "engine/gbc_only_disclaimer.asm"

_TossCoin::
	ld [wCoinTossTotalNum], a
	ld a, [wDuelDisplayedScreen]
	cp COIN_TOSS
	jr z, .print_text

	xor a
	ld [wCoinTossNumTossed], a
	call EmptyScreen
	call LoadDuelCoinTossResultTiles

.print_text
; no need to print text if this is not the first coin toss
	ld a, [wCoinTossNumTossed]
	or a
	jr nz, .clear_text_pointer
	ld a, COIN_TOSS
	ld [wDuelDisplayedScreen], a
	lb de, 0, 12
	lb bc, 20, 6
	ld hl, NULL
	call DrawLabeledTextBox
	call EnableLCD
	lb de, 1, 14
	ld a, 19
	call InitTextPrintingInTextbox
	ld hl, wCoinTossScreenTextID
	ld a, [hli]
	ld h, [hl]
	ld l, a
	call PrintText

.clear_text_pointer
	ld hl, wCoinTossScreenTextID
	xor a
	ld [hli], a
	ld [hl], a

; store duelist type and reset number of heads
	call EnableLCD
	ld a, DUELVARS_DUELIST_TYPE
	get_turn_duelist_var
	ld [wCoinTossDuelistType], a
	call ExchangeRNG
	xor a
	ld [wCoinTossNumHeads], a

.toss_next_coin
; skip printing text if it's only one coin toss
	ld a, [wCoinTossTotalNum]
	cp 2
	jr c, .skip_print_coin_tally

; write "#coin/#total coins"
	lb bc, 15, 11
	ld a, [wCoinTossNumTossed]
	inc a ; current coin number is wCoinTossNumTossed + 1
	bank1call WriteTwoDigitNumberInTxSymbol_PadSpace
	ld b, 17
	ld a, SYM_SLASH
	call WriteByteToBGMap0
	inc b
	ld a, [wCoinTossTotalNum]
	bank1call WriteTwoDigitNumberInTxSymbol_PadSpace

.skip_print_coin_tally
	call ResetAnimationQueue
	ld a, DUEL_ANIM_COIN_SPIN
	call .LoadCoinAnimation

	ld a, [wCoinTossDuelistType]
	or a
	jr z, .player_tossing ; DUELIST_TYPE_PLAYER
; opponent tossing
	call .WaitForOpponent
	jr .generate_coin_result
.player_tossing
	; wait for input, and send byte when player is ready to toss
	call WaitForWideTextBoxInput
	call .SendSerialByte

.generate_coin_result
	call ResetAnimationQueue
	ld d, DUEL_ANIM_COIN_TOSS_GOING_TAILS
	ld e, TAILS
	call UpdateRNGSources
	rla
	jr c, .got_result
	ld d, DUEL_ANIM_COIN_TOSS_GOING_HEADS
	ld e, HEADS

.got_result
; already decided on coin toss result,
; check if we should show animation or not
	ld a, [wSkipCoinTossAnimationAllowed]
	or a
	jr z, .dont_skip_animation
	ldh a, [hKeysHeld]
	and PAD_B | PAD_UP | PAD_DOWN
	jr nz, .skip_animation
.dont_skip_animation
; load the correct tossing animation
	ld a, d
	call .LoadCoinAnimation

.skip_animation
	ld a, [wCoinTossDuelistType]
	or a
	jr z, .wait_anim ; player tossing
; opponent tossing
	ld a, e
	call .GetOpponentCoinResult
	ld e, a ; coin result from opponent
	jr .done_toss_anim

.wait_anim
	push de
	call DoFrame
	call CheckAnyAnimationPlaying
	pop de
	jr c, .wait_anim
	ld a, e
	call .SendSerialByte

.done_toss_anim
	ld b, DUEL_ANIM_COIN_HEADS
	ld c, $34 ; tile for cross
	ld a, e
	or a
	jr z, .show_result
	ld b, DUEL_ANIM_COIN_TAILS
	ld c, $30 ; tile for circle
	ld hl, wCoinTossNumHeads
	inc [hl]

.show_result
	ld a, b
	call .LoadCoinAnimation

; load correct sound effect
; the sound of the coin toss result
; is dependant on whether it was the Player
; or the Opponent to get heads/tails
	ld a, [wCoinTossDuelistType]
	or a
	jr z, .check_sfx
	ld a, $1
	xor e ; invert result in case it's not Player
	ld e, a
.check_sfx
	ld d, SFX_COIN_TOSS_POSITIVE
	ld a, e
	or a
	jr nz, .got_sfx
	ld d, SFX_COIN_TOSS_NEGATIVE
.got_sfx
	ld a, d
	call PlaySFX

; in case it's a multiple coin toss scenario,
; then the result needs to be registered on screen
; with a circle (o) or a cross (x)
	ld a, [wCoinTossTotalNum]
	dec a
	jr z, .incr_num_coin_tossed ; skip if not more than 1 coin toss
	ld a, c
	push af
	ld e, 0
	ld a, [wCoinTossNumTossed]
; calculate the offset to draw the circle/cross
.loop_get_offset
	; if < 10, then the offset is simply calculated
	; from wCoinTossNumTossed * 2...
	cp 10
	jr c, .got_offset
	; ...else the y-offset is added for each multiple of 10
	inc e
	inc e
	sub 10
	jr .loop_get_offset

.got_offset
	add a
	ld d, a
	lb bc, 2, 2
	pop af

	push af
	push bc
	push de
	ld l, $1 ; red
	cp $30 ; circle tile?
	jr z, .got_color
	inc l ; $2 blue
.got_color
	ld a, l
	lb hl, 0, 0
	call BankswitchVRAM1
	call FillRectangle
	call BankswitchVRAM0
	pop de
	pop bc
	pop af
	lb hl, 1, 2
	call FillRectangle

.incr_num_coin_tossed
	ld hl, wCoinTossNumTossed
	inc [hl]

	ld a, [wCoinTossDuelistType]
	or a
	jr z, .player_tossing_next_coin
	; wait for input if we are finished, that is
	; if wCoinTossNumTossed == wCoinTossTotalNum
	ld a, [hl]
	ld hl, wCoinTossTotalNum
	cp [hl]
	call z, WaitForWideTextBoxInput

	; delay/wait for link opp input
	call .WaitForOpponent

	; if we are "tossing until tails",
	; (i.e. wCoinTossTotalNum == 0)
	; and we got no heads, wait for input
	ld a, [wCoinTossTotalNum]
	ld hl, wCoinTossNumHeads
	or [hl]
	jr nz, .check_if_finished
	call z, WaitForWideTextBoxInput
	jr .check_if_finished

.player_tossing_next_coin
	call WaitForWideTextBoxInput
	call .SendSerialByte

.check_if_finished
	call FinishQueuedAnimations
	ld a, [wCoinTossNumTossed]
	ld hl, wCoinTossTotalNum
	cp [hl]
	jp c, .toss_next_coin
	call ExchangeRNG
	call FinishQueuedAnimations
	call ResetAnimationQueue

; return carry if at least 1 heads
	ld a, [wCoinTossNumHeads]
	or a
	ret z
	scf
	ret

.LoadCoinAnimation:
	ld [wCurAnimation], a
	ldh a, [hWhoseTurn]
	ld [wDuelAnimDuelistSide], a
	ld a, [wOppCoin]
	ld [wdce1], a
	ld a, [wPlayerCoin]
	ld [wdce0], a
	call LoadDuelAnimationToBuffer
	ret

; input:
; - a = byte to send through serial
.SendSerialByte:
	ldh [hff96], a
	ld a, [wDuelType]
	cp DUELTYPE_LINK
	ret nz ; not link duel
	ldh a, [hff96]
	call SerialSendByte
	call .CheckTransmissionError
	ret

; if opponent is AI, then wait for animation and
; use the result generated beforehand (input register a)
; if link opponent, then wait for serial byte which
; gives the coin result
; input:
; - a = coin result to use for AI (HEADS or TAILS)
; output:
; - a = coin result (HEADS or TAILS)
.GetOpponentCoinResult:
	ldh [hff96], a
	ld a, [wDuelType]
	cp DUELTYPE_LINK
	jr z, .wait_serial_byte_recv
.wait_anim_ai
	call DoFrame
	call CheckAnyAnimationPlaying
	jr c, .wait_anim_ai
	ldh a, [hff96]
	ret

; waits for opponent
; AI delays for 30 frames
; link opponent sends byte through serial when ready
.WaitForOpponent:
	ldh [hff96], a
	ld a, [wDuelType]
	cp DUELTYPE_LINK
	jr z, .wait_serial_byte_recv

; delay coin flip for AI opponent
	ld a, 30
.ai_coin_toss_delay
	call DoFrame
	dec a
	jr nz, .ai_coin_toss_delay
	ldh a, [hff96]
	ret

.wait_serial_byte_recv
	call DoFrame
	call SerialRecvByte
	jr c, .wait_serial_byte_recv
	call .CheckTransmissionError
	ret

.CheckTransmissionError:
	push af
	ld a, [wSerialFlags]
	or a
	jr nz, .transmission_error
	pop af
	ret
.transmission_error
	call FinishQueuedAnimations
	call DuelTransmissionError
	ret

; debug? unreferenced
RequestToPrintCards_SelectStartCard:
	call EmptyScreen
	call EnableLCD
	ld hl, wPrinterStartCardID
	ld [hl], LOW(GRASS_ENERGY)
	inc hl
	ld [hl], HIGH(GRASS_ENERGY)
.wait_input
	call DoFrame
	ld hl, wPrinterStartCardID
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ldh a, [hDPadHeld]
	ld b, a
; left
	bit B_PAD_LEFT, b
	jr z, .right
	dec hl ; previous card
.right
	bit B_PAD_RIGHT, b
	jr z, .up
	inc hl ; next card
.up
	bit B_PAD_UP, b
	jr z, .down
	ld de, 10
	add hl, de
.down
	bit B_PAD_DOWN, b
	jr z, .got_card_id
	ld de, -10
	add hl, de

.got_card_id
	ld a, l
	ld [wPrinterStartCardID], a
	ld a, h
	ld [wPrinterStartCardID + 1], a
	lb bc, 5, 5
	bank1call WriteTwoByteNumberInTxSymbol_PadSpace
	ldh a, [hKeysPressed]
	and PAD_START
	jr z, .wait_input

; request to print until end of card index
	ld hl, wPrinterStartCardID
	ld e, [hl]
	inc hl
	ld d, [hl]
.loop_cards
	call LoadCardDataToBuffer1_FromCardID
	ret c ; reached out of bounds
	push de
	farcall RequestToPrintCard
	pop de
	inc de
	jr .loop_cards
