SECTION "Bank 1@4074", ROMX[$4074], BANK[$1]

StartDuelFromSRAM:
	call SetupDuel
	farcall Func_24048
	ldtx hl, BackUpIsBrokenText
	jr c, .corrupted
.ok::
	ld hl, sp+$00
	ld a, l
	ld [wDuelReturnAddress + 0], a
	ld a, h
	ld [wDuelReturnAddress + 1], a
	call ClearJoypad
	ld a, [wDuelTheme]
	call PlaySong
	xor a
	ld [wDuelFinished], a
	call DuelMainInterface
	jp MainDuelLoop.between_turns
.corrupted
	call DrawWideTextBox_WaitForInput
	call ResetSerial
	scf
	ret

; this function begins the duel after the opponent's graphics, name and deck have been introduced
; loads both player's decks and sets up the variables and resources required to begin a duel.
StartDuel_VSAIOpp:
	ld a, PLAYER_TURN
	ldh [hWhoseTurn], a
	ld a, DUELIST_TYPE_PLAYER
	ld [wPlayerDuelistType], a
	ld a, [wNPCDuelDeckID]
	ld [wOpponentDeckID], a
	call LoadPlayerDeck
	call SwapTurn
	call LoadOpponentDeck
	call SwapTurn
	jr StartDuel

; .init is also used by link duels
StartDuel_VS:
	ld a, PLAYER_TURN
	ldh [hWhoseTurn], a
	ld a, DUELIST_TYPE_PLAYER
	ld [wPlayerDuelistType], a
	ld [wOpponentDuelistType], a
	ld a, COIN_LUGIA
	ld [wOppCoin], a
	ld a, PRIZES_6
	ld [wNPCDuelPrizes], a
	xor a ; COIN_CHANSEY
	ld [wPlayerCoin], a
	ld a, NUM_PICS
	call Random
	ld [wOpponentPicID], a
; fallthrough
.init
	ld hl, wOpponentName
	xor a
	ld [hli], a
	ld [hl], a ; wNPCDuelPrizes
	ld [wOpponentDeckID], a
	ld [wSpecialRule], a
	ld [wIsPracticeDuel], a
;	fallthrough

StartDuel:
	ld hl, sp+$00
	ld a, l
	ld [wDuelReturnAddress], a
	ld a, h
	ld [wDuelReturnAddress + 1], a
	xor a
	ld [wCurrentDuelMenuItem], a
	call SetupDuel
	ld a, [wNPCDuelPrizes]
	ld [wDuelInitialPrizes], a
	call InitVariablesToBeginDuel
	ld a, [wDuelTheme]
	call PlaySong
	call HandleDuelSetup
	ret c
;	fallthrough

; the loop returns here after every turn switch
MainDuelLoop:
	xor a
	ld [wCurrentDuelMenuItem], a
	call UpdateSubstatusConditions_StartOfTurn
	call DisplayDuelistTurnScreen
	call HandleTurn

.between_turns
	call ExchangeRNG
	ld a, [wDuelFinished]
	or a
	jr nz, .duel_finished
	call UpdateSubstatusConditions_EndOfTurn
	call HandleBetweenTurnsEvents
	call FinishQueuedAnimations
	call ExchangeRNG
	ld a, [wDuelFinished]
	or a
	jr nz, .duel_finished
	ld hl, wDuelTurns
	inc [hl]
	ld a, [wDuelType]
	cp DUELTYPE_PRACTICE
	jr z, .practice_duel

.next_turn
	call SwapTurn
	jr MainDuelLoop

.practice_duel
	ld a, [wIsPracticeDuel]
	or a
	jr z, .next_turn
	ld a, [hl]
	cp 15 ; the practice duel lasts 15 turns (8 player turns and 7 opponent turns)
	jr c, .next_turn
	xor a ; DUEL_WIN
	ld [wDuelResult], a
	ret

.duel_finished
	call ZeroObjectPositionsAndToggleOAMCopy
	call EmptyScreen
	ld a, BOXMSG_DECISION
	call DrawDuelBoxMessage
	ldtx hl, DecisionText
	call DrawWideTextBox_WaitForInput
	call EmptyScreen
	call ResetAnimationQueue

	ld a, [wDuelFinished]
	cp TURN_PLAYER_WON
	jr z, .turn_player_won
	cp TURN_PLAYER_LOST
	jr z, .asm_41b3
	ld b, DUEL_ANIM_DUEL_DRAW
	ld c, MUSIC_MATCHDRAW
	ldtx hl, DuelWasADrawText
	ld a, $2
	jr .set_duel_result
.turn_player_won
	ldh a, [hWhoseTurn]
	cp PLAYER_TURN
	jr nz, .asm_41b9
.asm_4192
	ld a, DUELVARS_DUELIST_TYPE
	call GetNonTurnDuelistVariable
	cp DUELIST_TYPE_LINK_OPP
	jr nz, .not_link_duel

	; is link duel, increment duel counter
	call EnableSRAM
	ld hl, sLinkDuelCounter
	inc [hl]
	jr nz, .done_increment_link_duel_count
	inc hl
	inc [hl]
.done_increment_link_duel_count
	call DisableSRAM

.not_link_duel
	ld b, DUEL_ANIM_DUEL_WIN
	ld c, MUSIC_MATCHVICTORY
	ldtx hl, WonDuelText
	xor a
	jr .set_duel_result
.asm_41b3
	ldh a, [hWhoseTurn]
	cp PLAYER_TURN
	jr nz, .asm_4192
.asm_41b9
	ld b, DUEL_ANIM_DUEL_LOSS
	ld c, MUSIC_MATCHLOSS
	ldtx hl, LostDuelText
	ld a, $1
.set_duel_result
	ld [wDuelResult], a

	push hl
	push bc
	ld a, PLAYER_TURN
	ldh [hWhoseTurn], a
	farcall DrawDuelistPortraitsAndNames
	call PrintDuelResultStats
	pop bc
	pop hl
	ld a, b
	call PlayDuelAnimation
	ld a, c
	call PlaySong

	ld a, OPPONENT_TURN
	ldh [hWhoseTurn], a
	call DrawWideTextBox_PrintText
	call EnableLCD

	ld a, [wDuelFinished]
	cp TURN_PLAYER_TIED
	jr z, .wait_song

	call EnableSRAM
	ld hl, sTotalDuelCounter
	inc [hl]
	jr nz, .done_increment_total_duel_count
	inc hl
	inc [hl]
.done_increment_total_duel_count
	call DisableSRAM

.wait_song
	call DoFrame
	call UpdateRNGSources
	call AssertSongFinished
	or a
	jr nz, .wait_song
	ld a, [wDuelFinished]
	cp TURN_PLAYER_TIED
	jr z, .tied_duel
	call StubbedPlayDefaultSong
	call WaitForWideTextBoxInput_AdvanceRNG
	call FinishQueuedAnimations
	call ResetSerial
	ld a, PLAYER_TURN
	ldh [hWhoseTurn], a
	ret

.tied_duel
	call WaitForWideTextBoxInput
	call FinishQueuedAnimations
	ld a, [wDuelTheme]
	call PlaySong
	ldtx hl, StartSuddenDeathMatchText
	call DrawWideTextBox_WaitForInput
	ld a, 1
	ld [wDuelInitialPrizes], a
	call InitVariablesToBeginDuel
	ld a, [wDuelType]
	cp DUELTYPE_LINK
	jr z, .link_duel

	; load player's and opponent's decks
	call LoadPlayerDeck
	ld a, [wOpponentDeckID]
	or a
	jr z, .skip_opp_deck
	ld a, OPPONENT_TURN
	ldh [hWhoseTurn], a
	ld a, [wOpponentDeckID]
	call LoadOpponentDeck

.skip_opp_deck
	ld a, PLAYER_TURN
	ldh [hWhoseTurn], a
	call HandleDuelSetup
	jp MainDuelLoop

.link_duel
	call LoadPlayerDeck
	call ExchangeRNG
	ld h, PLAYER_TURN
	ld a, [wSerialOp]
	cp $92
	jr z, .got_turn
	ld h, OPPONENT_TURN
.got_turn
	ld a, h
	ldh [hWhoseTurn], a
	call HandleDuelSetup
	jp nc, MainDuelLoop
	ret

; empty the screen, and setup text and graphics for a duel
SetupDuel:
	xor a
	ld [wTileMapFill], a
	call ZeroObjectPositionsAndToggleOAMCopy
	call EmptyScreen
	call LoadSymbolsFont
	call SetDefaultPalettes
	lb de, $38, $9f
	call SetupText
	call EnableLCD
	ret

; handle the turn of the duelist identified by hWhoseTurn.
; if player's turn, display the animation of the player drawing the card at
; hTempCardIndex_ff98, and save the duel state to SRAM.
HandleTurn:
	ld a, DUELVARS_DUELIST_TYPE
	get_turn_duelist_var
	ld [wDuelistType], a
	ld a, [wDuelTurns]
	cp 2
	jr c, .skip_let_evolve ; jump if it's the turn holder's first turn
	call SetAllPlayAreaPokemonCanEvolve
.skip_let_evolve
	call InitVariablesToBeginTurn
	call CheckIfCannotDrawDueToPerplex
	jr nc, .can_draw
	call DrawWideTextBox_WaitForInput
	xor a
	farcall DisplayDrawNCardsScreen
	jr .save_duel

.can_draw
	farcall DisplayDrawOneCardScreen
	call DrawCardFromDeck
	jr nc, .deck_not_empty
	ld a, TURN_PLAYER_LOST
	ld [wDuelFinished], a
	ret

.deck_not_empty
	ldh [hTempCardIndex_ff98], a
	call AddCardToHand
	ld a, [wDuelistType]
	cp DUELIST_TYPE_PLAYER
	jr z, .player_turn

; opponent's turn
	call SwapTurn
	call IsClairvoyanceActive
	call SwapTurn
	call c, DisplayPlayerDrawCardScreen
	jr DuelMainInterface

; player's turn
.player_turn
	call DisplayPlayerDrawCardScreen

.save_duel
	farcall SaveDuelStateToSRAM
;	fallthrough

; when a practice duel turn needs to be restarted because the player did not
; follow the instructions correctly, the game loops back here
RestartPracticeDuelTurn:
	ld a, PRACTICEDUEL_PRINT_TURN_INSTRUCTIONS
	call DoPracticeDuelAction
;	fallthrough

; print the main interface during a duel, including background, Pokemon, HUDs and a text box.
; the bottom text box changes depending on whether the turn belongs to the player (show the duel menu),
; an AI opponent (print "Waiting..." and a reduced menu) or a link opponent (print "<Duelist> is thinking").
DuelMainInterface:
	ld a, [wcd09]
	or a
	jp nz, DuelMenu_Done
	call DrawDuelMainScene
	ld a, [wDuelistType]
	cp DUELIST_TYPE_PLAYER
	jr z, PrintDuelMenuAndHandleInput
	cp DUELIST_TYPE_LINK_OPP
	jr nz, .ai_opp
	; DUELIST_TYPE_LINK_OPP
	farcall DoLinkOpponentTurn
	ret
.ai_opp
	; DUELIST_TYPE_AI_OPP
	farcall DoAIOpponentTurn
	ret

PrintDuelMenuAndHandleInput:
	call DrawWideTextBox
	ld hl, DuelMenuData
	call PlaceTextItems
.menu_items_printed
	farcall SaveDuelData
	ld a, [wDuelFinished]
	or a
	ret nz
	ld a, [wCurrentDuelMenuItem]
	call SetMenuItem

.handle_input
	call DoFrame
	ldh a, [hKeysHeld]
	and PAD_B
	jr z, .b_not_held
	ldh a, [hKeysPressed]
	bit B_PAD_UP, a
	jr nz, DuelMenuShortcut_OpponentPlayArea
	bit B_PAD_DOWN, a
	jr nz, DuelMenuShortcut_PlayerPlayArea
	bit B_PAD_LEFT, a
	jr nz, DuelMenuShortcut_PlayerDiscardPile
	bit B_PAD_RIGHT, a
	jr nz, DuelMenuShortcut_OpponentDiscardPile
	bit B_PAD_START, a
	jp nz, DuelMenuShortcut_OpponentActivePokemon

.b_not_held
	ldh a, [hKeysPressed]
	and PAD_START
	jp nz, DuelMenuShortcut_PlayerActivePokemon
	ldh a, [hKeysPressed]
	bit B_PAD_SELECT, a
	jp nz, DuelMenuShortcut_BothActivePokemon
	ld a, [wDebugSkipDuelMenuInput]
	or a
	jr nz, .handle_input
	call HandleDuelMenuInput
	ld a, e
	ld [wCurrentDuelMenuItem], a
	jr nc, .handle_input
	ldh a, [hCurScrollMenuItem]
	ld hl, DuelMenuFunctionTable
	jp JumpToFunctionInTable

DuelMenuFunctionTable:
	dw DuelMenu_Hand
	dw DuelMenu_Attack
	dw DuelMenu_Check
	dw DuelMenu_PkmnPower
	dw DuelMenu_Retreat
	dw DuelMenu_Done

; unreferenced
UnreferencedDrawCardFromDeckToHand:
	call DrawCardFromDeck
	call nc, AddCardToHand
	ld a, OPPACTION_DRAW_CARD
	call SetOppAction_SerialSendDuelData
	jp PrintDuelMenuAndHandleInput.menu_items_printed

; triggered by pressing B + UP in the duel menu
DuelMenuShortcut_OpponentPlayArea:
	call OpenNonTurnHolderPlayAreaScreen
	jp DuelMainInterface

; triggered by pressing B + DOWN in the duel menu
DuelMenuShortcut_PlayerPlayArea:
	call OpenTurnHolderPlayAreaScreen
	jp DuelMainInterface

; triggered by pressing B + RIGHT in the duel menu
DuelMenuShortcut_OpponentDiscardPile:
	call OpenNonTurnHolderDiscardPileScreen
	jp c, PrintDuelMenuAndHandleInput
	jp DuelMainInterface

; triggered by pressing B + LEFT in the duel menu
DuelMenuShortcut_PlayerDiscardPile:
	call OpenTurnHolderDiscardPileScreen
	jp c, PrintDuelMenuAndHandleInput
	jp DuelMainInterface
; 0x439d

SECTION "Bank 1@43be", ROMX[$43be], BANK[$1]

; draw the non-turn holder's play area screen
OpenNonTurnHolderPlayAreaScreen:
	call SwapTurn
	call OpenTurnHolderPlayAreaScreen
	jp SwapTurn

; draw the turn holder's play area screen
OpenTurnHolderPlayAreaScreen:
	call HasAlivePokemonInPlayArea
	jp OpenPlayAreaScreenForViewing

; draw the non-turn holder's discard pile screen
OpenNonTurnHolderDiscardPileScreen:
	call SwapTurn
	call OpenDiscardPileScreen
	jp SwapTurn

; draw the turn holder's discard pile screen
OpenTurnHolderDiscardPileScreen:
	jp OpenDiscardPileScreen
; 0x43d9

SECTION "Bank 1@43e2", ROMX[$43e2], BANK[$1]

; draw the turn holder's hand screen. simpler version of OpenPlayerHandScreen
; used only for checking the cards rather than for playing them.
; used for example in the "Your Play Area" screen of the Check menu
OpenTurnHolderHandScreen_Simple:
	call CreateHandCardList
	jr nc, .got_cards_in_hand
	ldtx hl, NoCardsInHandText
	jp DrawWideTextBox_WaitForInput
.got_cards_in_hand
	call InitAndDrawCardListScreenLayout
	ld a, PAD_START + PAD_A
	ld [wNoItemSelectionMenuKeys], a
	jp DisplayCardList

; triggered by pressing B + START in the duel menu
DuelMenuShortcut_OpponentActivePokemon:
	call SwapTurn
	call OpenActivePokemonScreen
	call SwapTurn
	jp DuelMainInterface

; triggered by pressing START in the duel menu
DuelMenuShortcut_PlayerActivePokemon:
	call OpenActivePokemonScreen
	jp DuelMainInterface

; draw the turn holder's active Pokemon screen if it exists
OpenActivePokemonScreen:
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	cp -1
	ret z
	call GetCardIDFromDeckIndex
	call LoadCardDataToBuffer1_FromCardID
	ld hl, wCurPlayAreaSlot
	xor a
	ld [hli], a
	ld [hl], a ; wCurPlayAreaY
	call OpenCardPage_FromCheckPlayArea
	ret

; triggered by selecting the "Pkmn Power" item in the duel menu
DuelMenu_PkmnPower:
	call DisplayPlayAreaScreenToUsePkmnPower
	jp c, DuelMainInterface
	call UseAttackOrPokemonPower
	jp DuelMainInterface

; triggered by selecting the "Done" item in the duel menu
DuelMenu_Done:
	ld a, PRACTICEDUEL_REPEAT_INSTRUCTIONS
	call DoPracticeDuelAction
	jp c, RestartPracticeDuelTurn
	ld a, OPPACTION_FINISH_NO_ATTACK
	call SetOppAction_SerialSendDuelData
	call ClearNonTurnTemporaryDuelvars
	ret

; triggered by selecting the "Retreat" item in the duel menu
DuelMenu_Retreat:
	ld a, DUELVARS_ARENA_CARD_STATUS
	get_turn_duelist_var
	and CNF_SLP_PRZ
	cp CONFUSED
	ldh [hTemp_ffa0], a
	jr nz, .not_confused
	ld a, [wGotHeadsFromConfusionCheckDuringRetreat]
	or a
	jr nz, .unable_due_to_confusion
	call CheckAbleToRetreat
	jr c, .unable_to_retreat
	call DisplayRetreatScreen
	jr c, .done
	ldtx hl, SelectBenchedPokemonToSwitchWithActiveText
	call DrawWideTextBox_WaitForInput
	call OpenPlayAreaScreenForSelection
	jr c, .done
	ld [wBenchSelectedPokemon], a
	ld a, [wBenchSelectedPokemon] ; unnecessary
	ldh [hTempPlayAreaLocation_ffa1], a
	ld a, OPPACTION_ATTEMPT_RETREAT
	call SetOppAction_SerialSendDuelData
	call AttemptRetreat
	jr nc, .done
	call DrawDuelMainScene

.unable_due_to_confusion
	ldtx hl, UnableToRetreatText
	call DrawWideTextBox_WaitForInput
	jp PrintDuelMenuAndHandleInput

.not_confused
	; note that the energy cards are discarded (DiscardRetreatCostCards), then returned
	; (ReturnRetreatCostCardsToArena), then discarded again for good (AttemptRetreat).
	; It's done this way so that the retreating Pokemon is listed with its energies updated
	; when the Play Area screen is shown to select the Pokemon to switch to. The reason why
	; AttemptRetreat is responsible for discarding the energy cards is because, if the
	; Pokemon is confused, it may not be able to retreat, so they cannot be discarded earlier.
	call CheckAbleToRetreat
	jr c, .unable_to_retreat
	call DisplayRetreatScreen
	jr c, .done
	call DiscardRetreatCostCards
	ldtx hl, SelectBenchedPokemonToSwitchWithActiveText
	call DrawWideTextBox_WaitForInput
	call OpenPlayAreaScreenForSelection
	ld [wBenchSelectedPokemon], a
	ldh [hTempPlayAreaLocation_ffa1], a
	push af
	call ReturnRetreatCostCardsToArena
	pop af
	jp c, DuelMainInterface
	ld a, OPPACTION_ATTEMPT_RETREAT
	call SetOppAction_SerialSendDuelData
	call AttemptRetreat

.done
	jp DuelMainInterface

.unable_to_retreat
	call DrawWideTextBox_WaitForInput
	jp PrintDuelMenuAndHandleInput

; triggered by selecting the "Hand" item in the duel menu
DuelMenu_Hand:
	ld a, DUELVARS_NUMBER_OF_CARDS_IN_HAND
	get_turn_duelist_var
	or a
	jr nz, OpenPlayerHandScreen
	ldtx hl, NoCardsInHandText
	call DrawWideTextBox_WaitForInput
	jp PrintDuelMenuAndHandleInput

; draw the screen for the player's hand and handle user input to for example check
; a card or attempt to use a card, playing the card if possible in that case.
OpenPlayerHandScreen:
	call CreateHandCardList
	call InitAndDrawCardListScreenLayout
	ldtx hl, PleaseSelectHandText
	call SetCardListInfoBoxText
	ld a, PLAY_CHECK
	ld [wCardListItemSelectionMenuType], a
.handle_input
	call DisplayCardList
	push af
	ld a, [wSortCardListByID]
	or a
	jr z, .skip_sort
	call SortHandCardsByID
.skip_sort
	pop af
	jp c, DuelMainInterface
	ldh a, [hTempCardIndex_ff98]
	call LoadCardDataToBuffer1_FromDeckIndex
	ld a, [wLoadedCard1Type]
	ld c, a
	bit TYPE_TRAINER_F, c
	jr nz, .trainer_card
	bit TYPE_ENERGY_F, c
	jr nz, PlayEnergyCard
	call PlayPokemonCard
	jr c, ReloadCardListScreen ; jump if card not played
	jp DuelMainInterface
.trainer_card
	call PlayTrainerCard
	jr c, ReloadCardListScreen ; jump if card not played
	jp DuelMainInterface

; play the energy card with deck index at hTempCardIndex_ff98
; c contains the type of energy card being played
PlayEnergyCard:
	ld a, c
	cp TYPE_ENERGY_WATER
	jr nz, .not_water_energy
	call IsRainDanceActive
	jr c, .rain_dance_active

.not_water_energy
	ld a, [wAlreadyPlayedEnergy]
	or a
	jr nz, .already_played_energy
	call HasAlivePokemonInPlayArea
	call OpenPlayAreaScreenForSelection ; choose card to play energy card on
	jp c, DuelMainInterface ; exit if no card was chosen
.play_energy_set_played
	ld a, TRUE
	ld [wAlreadyPlayedEnergy], a
.play_energy
	ldh a, [hTempPlayAreaLocation_ff9d]
	ldh [hTempPlayAreaLocation_ffa1], a
	ld e, a
	ldh a, [hTempCardIndex_ff98]
	ldh [hTemp_ffa0], a
	call PutHandCardInPlayArea
	call PrintPlayAreaCardList_EnableLCD
	ld a, OPPACTION_PLAY_ENERGY
	call SetOppAction_SerialSendDuelData
	farcall PrintAttachedEnergyToPokemon
	call Func_6986
	jp DuelMainInterface

.rain_dance_active
	call HasAlivePokemonInPlayArea
	call OpenPlayAreaScreenForSelection ; choose card to play energy card on
	jp c, DuelMainInterface ; exit if no card was chosen
	call CheckRainDanceScenario
	jr c, .play_energy
	ld a, [wAlreadyPlayedEnergy]
	or a
	jr z, .play_energy_set_played
	ldtx hl, Only1EnergyCardPerTurnText
	call DrawWideTextBox_WaitForInput
	jp OpenPlayerHandScreen

.already_played_energy
	ldtx hl, Only1EnergyCardPerTurnText
	call DrawWideTextBox_WaitForInput
;	fallthrough

; reload the card list screen after the card trying to play couldn't be played
ReloadCardListScreen:
	call CreateHandCardList
	; skip doing the things that have already been done when initially opened
	call DrawCardListScreenLayout
	jp OpenPlayerHandScreen.handle_input

; place a basic Pokemon card on the arena or bench, or place an stage 1 or 2
; Pokemon card over a Pokemon card already in play to evolve it.
; the card to use is loaded in wLoadedCard1 and its deck index is at hTempCardIndex_ff98.
; return nc if the card was played, carry if it wasn't.
PlayPokemonCard:
	ld a, [wLoadedCard1Stage]
	or a ; BASIC
	jr nz, .try_evolve ; jump if the card being played is a Stage 1 or 2 Pokemon
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	ld hl, wMaxNumPlayAreaPokemon
	cp [hl]
	jr nc, .no_space
	ldh a, [hTempCardIndex_ff98]
	ldh [hTemp_ffa0], a
	call PutHandPokemonCardInPlayArea
	ldh [hTempPlayAreaLocation_ff9d], a
	ldh [hTempPlayAreaLocation_ffa1], a
	add DUELVARS_ARENA_CARD_STAGE
	get_turn_duelist_var
	ld [hl], BASIC
	ld a, OPPACTION_PLAY_BASIC_PKMN
	call SetOppAction_SerialSendDuelData
	ldh a, [hTempCardIndex_ff98]
	call LoadCardDataToBuffer1_FromDeckIndex
	ld a, 20
	call CopyCardNameAndLevel
	ld [hl], $00
	ld hl, $0000
	call LoadTxRam2
	ldtx hl, PlacedOnBenchText
	call DrawWideTextBox_WaitForInput
	call ProcessPlayedPokemonCard
	or a
	ret

.no_space
	ldtx hl, NoSpaceOnTheBenchText
	call DrawWideTextBox_WaitForInput
	scf
	ret

.try_evolve
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	ld c, a
	ldh a, [hTempCardIndex_ff98]
	ld d, a
	ld e, PLAY_AREA_ARENA
	push de
	push bc
.next_play_area_pkmn
	push de
	call CheckIfCanEvolveInto
	pop de
	jr nc, .can_evolve
	inc e
	dec c
	jr nz, .next_play_area_pkmn
	pop bc
	pop de
.find_cant_evolve_reason_loop
	push de
	call CheckIfCanEvolveInto
	pop de
	ldtx hl, CantEvolvePokemonInSameTurnItsPlacedText
	jr nz, .cant_same_turn
	inc e
	dec c
	jr nz, .find_cant_evolve_reason_loop
	ldtx hl, NoPokemonCapableOfEvolvingText
.cant_same_turn
	; don't bother opening the selection screen if there are no pokemon capable of evolving
	call DrawWideTextBox_WaitForInput
	scf
	ret

.can_evolve
	pop bc
	pop de
	call IsPrehistoricPowerActive
	jr c, .prehistoric_power
	call HasAlivePokemonInPlayArea
.try_evolve_loop
	call OpenPlayAreaScreenForSelection
	jr c, .done
	ldh a, [hTempCardIndex_ff98]
	ldh [hTemp_ffa0], a
	ldh a, [hTempPlayAreaLocation_ff9d]
	ldh [hTempPlayAreaLocation_ffa1], a
	call EvolvePokemonCardIfPossible
	jr c, .try_evolve_loop ; jump if evolution wasn't successful somehow
	ld a, OPPACTION_EVOLVE_PKMN
	call SetOppAction_SerialSendDuelData
	call PrintPlayAreaCardList_EnableLCD
	farcall PrintPokemonEvolvedIntoPokemon
	call ProcessPlayedPokemonCard
.done
	or a
	ret

.prehistoric_power
	call DrawWideTextBox_WaitForInput
	scf
	ret

; triggered by selecting the "Check" item in the duel menu
DuelMenu_Check:
	call FinishQueuedAnimations
	call OpenDuelCheckMenu
	jp DuelMainInterface

; triggered by pressing SELECT in the duel menu
DuelMenuShortcut_BothActivePokemon:
	call FinishQueuedAnimations
	call OpenVariousPlayAreaScreens_FromSelectPresses
	jp DuelMainInterface

OpenVariousPlayAreaScreens_FromSelectPresses:
	call OpenInPlayAreaScreen_FromSelectButton
	ret c
	call .Func_45a9
	ret c
	call SwapTurn
	call .Func_45a9
	call SwapTurn
	ret

.Func_45a9
	call HasAlivePokemonInPlayArea
	ld a, $02
	ld [wPlayAreaSelectAction], a
	call OpenPlayAreaScreenForViewing
	ldh a, [hKeysPressed]
	and PAD_B
	ret z
	scf
	ret

; check if the turn holder's arena Pokemon is unable to retreat due to
; some status condition or due the bench containing no alive Pokemon.
; return carry if unable, nc if able.
CheckAbleToRetreat:
	call CheckUnableToRetreatDueToEffect
	ret c
	call HasAlivePokemonInBench
	jr c, .unable_to_retreat
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call GetCardIDFromDeckIndex
	call LoadCardDataToBuffer1_FromCardID
	ld a, [wLoadedCard1Type]
	cp TYPE_TRAINER
	jr z, .unable_to_retreat
	call CheckIfEnoughEnergiesToRetreat
	jr c, .not_enough_energies
	or a
	ret
.not_enough_energies
	ld a, [wEnergyCardsRequiredToRetreat]
	ld l, a
	ld h, $00
	call LoadTxRam3
	ldtx hl, EnergyRequiredToRetreatText
	jr .done
.unable_to_retreat
	ldtx hl, UnableToRetreatText
.done
	scf
	ret

; check if the turn holder's arena Pokemon has enough energies attached to it
; in order to retreat. Return carry if it doesn't.
; load amount of energies required to wEnergyCardsRequiredToRetreat.
CheckIfEnoughEnergiesToRetreat:
	ld e, PLAY_AREA_ARENA
	call GetPlayAreaCardAttachedEnergies
	xor a ; PLAY_AREA_ARENA
	ldh [hTempPlayAreaLocation_ff9d], a
	call GetPlayAreaCardRetreatCost
	ld [wEnergyCardsRequiredToRetreat], a
	ld c, a
	ld a, [wTotalAttachedEnergies]
	cp c
	ret c
	ld [wNumRetreatEnergiesSelected], a
	ld a, c
	ld [wEnergyCardsRequiredToRetreat], a
	or a
	ret

; display the screen that prompts the player to select energy cards to discard
; in order to retreat a Pokemon card. also handle input in order to display
; the amount of energy cards already selected, and return whenever enough
; energy cards have been selected or if the player declines to retreat.
DisplayRetreatScreen:
	ld a, $ff
	ldh [hTempRetreatCostCards], a
	ld a, [wEnergyCardsRequiredToRetreat]
	or a
	ret z ; return if no energy cards are required at all
	xor a
	ld [wNumRetreatEnergiesSelected], a
	call CreateArenaOrBenchEnergyCardList
	ld a, LOW(hTempRetreatCostCards)
	ld [wTempRetreatCostCardsPos], a
	xor a
	call DisplayEnergyDiscardMenu
	ld a, [wEnergyCardsRequiredToRetreat]
	ld [wAttachedEnergyMenuDenominator], a
.select_energies_loop
	ld a, [wNumRetreatEnergiesSelected]
	ld [wAttachedEnergyMenuNumerator], a
	call HandleAttachedEnergyMenuInput
	ret c
	ldh a, [hTempCardIndex_ff98]
	call LoadCardDataToBuffer2_FromDeckIndex
	; append selected energy card to hTempRetreatCostCards
	ld hl, wTempRetreatCostCardsPos
	ld c, [hl]
	inc [hl]
	ldh a, [hTempCardIndex_ff98]
	ld [$ff00+c], a
	; accumulate selected energy card
	ld c, 1
	ld a, [wLoadedCard2Type]
	cp TYPE_ENERGY_DOUBLE_COLORLESS
	jr nz, .not_double
	inc c
.not_double
	ld hl, wNumRetreatEnergiesSelected
	ld a, [hl]
	add c
	ld [hl], a
	ld hl, wEnergyCardsRequiredToRetreat
	cp [hl]
	jr nc, .enough
	; not enough energies selected yet
	ldh a, [hTempCardIndex_ff98]
	call RemoveCardFromDuelTempList
	call UpdateAttachedEnergyMenu
	jr .select_energies_loop
.enough
	; terminate hTempRetreatCostCards array with $ff
	ld a, [wTempRetreatCostCardsPos]
	ld c, a
	ld a, $ff
	ld [$ff00+c], a
	or a
	ret

DisplayEnergyDiscardMenu:
	ldtx de, ChooseEnergyCardToDiscardText
;	fallthrough

; display the screen that shows the player the energy attached
; to a Play Area Pokemon, this is used both for the discard
; effects of cards and retreat cost, and also just as an
; informative screen when viewing the Play Area
; input:
; - a  = PLAY_AREA_* of the Pokemon
; - de = text ID to show in the text box
DisplayAttachedEnergyMenu:
	ld hl, wAttachedEnergyMenuTextID
	ld [hl], e
	inc hl
	ld [hl], d
	ld [wAttachedEnergyMenuPlayAreaLocation], a
	call SortCardsInDuelTempListByID
	call EmptyScreen
	call LoadDuelCardSymbolTiles
	call LoadDuelFaceDownCardTiles
	call Func_6c12
	call FlushAllPalettesIfNotDMG
	ld a, [wAttachedEnergyMenuPlayAreaLocation]
	ld hl, wCurPlayAreaSlot
	ld [hli], a
	ld [hl], 0 ; wCurPlayAreaY
	call PrintPlayAreaCardInformation
	xor a
	ld [wAttachedEnergyMenuNumerator], a
	ld [wcbeb], a
	inc a
	ld [wAttachedEnergyMenuDenominator], a
;	fallthrough

UpdateAttachedEnergyMenu:
	lb de, 0, 3
	lb bc, 20, 10
	call DrawRegularTextBox
	ld hl, wAttachedEnergyMenuTextID
	ld a, [hli]
	ld h, [hl]
	ld l, a
	call DrawWideTextBox_PrintTextNoDelay
	call EnableLCD
	call CountCardsInDuelTempList
	ld hl, AttachedEnergyCardListParameters
	lb de, 0, 0 ; initial page scroll offset, initial item (in the visible page)
	call PrintCardListItems
	ld a, 4
	ld [wCardListIndicatorYPosition], a
	ret

; if [wAttachedEnergyMenuDenominator] non-0:
   ; prints "[wAttachedEnergyMenuNumerator]/[wAttachedEnergyMenuDenominator]" at 16,16
   ; where [wAttachedEnergyMenuNumerator] is the number of energy cards already selected to discard
   ; and [wAttachedEnergyMenuDenominator] is the total number of energies that are required to discard.
; if [wAttachedEnergyMenuDenominator] == 0:
	; prints only "[wAttachedEnergyMenuNumerator]"
HandleAttachedEnergyMenuInput:
	ld a, [wcbeb]
	or a
	jr nz, .wait_input

	lb bc, 16, 16
	ld a, [wAttachedEnergyMenuDenominator]
	or a
	jr z, .print_single_number
	ld a, [wAttachedEnergyMenuNumerator]
	add SYM_0
	call WriteByteToBGMap0
	inc b
	ld a, SYM_SLASH
	call WriteByteToBGMap0
	inc b
	ld a, [wAttachedEnergyMenuDenominator]
	add SYM_0
	call WriteByteToBGMap0
	jr .wait_input
.print_single_number
	ld a, [wAttachedEnergyMenuNumerator]
	inc b
	call WriteTwoDigitNumberInTxSymbolFormat
.wait_input
	call DoFrame
	call HandleCardListInput
	jr nc, .wait_input
	cp $ff ; B pressed?
	jr z, .return_carry
	ld a, [wcbeb]
	or a
	jr nz, .wait_input
	ldh a, [hCurScrollMenuItem]
	call GetCardInDuelTempList_OnlyDeckIndex
	or a
	ret
.return_carry
	scf
	ret

AttachedEnergyCardListParameters:
	db 1, 5 ; cursor x, cursor y
	db 4 ; item x
	db 14 ; maximum length, in tiles, occupied by the name and level string of each card in the list
	db 4 ; number of items selectable without scrolling
	db SYM_CURSOR_R ; cursor tile number
	db SYM_SPACE ; tile behind cursor
	dw NULL ; function pointer if non-0

; triggered by selecting the "Attack" item in the duel menu
DuelMenu_Attack:
	call CheckIfArenaCardIsUnableToAttack
	jr nc, .can_attack
	call DrawWideTextBox_WaitForInput
	jp PrintDuelMenuAndHandleInput

.can_attack
	xor a
	ld [wSelectedDuelSubMenuItem], a
.try_open_attack_menu
	call PrintAndLoadAttacksToDuelTempList
	or a
	jr nz, .init_menu
	ldtx hl, NoSelectableAttacksText
	call DrawWideTextBox_WaitForInput
	jp PrintDuelMenuAndHandleInput

.init_menu
	push af
	ld a, [wSelectedDuelSubMenuItem]
	ld hl, AttackMenuParameters
	call InitializeMenuParameters
	pop af

.open_attack_menu
	ld [wNumScrollMenuItems], a
	ldh a, [hWhoseTurn]
	ld h, a
	ld l, DUELVARS_ARENA_CARD
	ld a, [hl]
	call LoadCardDataToBuffer1_FromDeckIndex

.wait_for_input
	call DoFrame
	ldh a, [hKeysPressed]
	and PAD_START
	jr nz, .display_selected_attack_info
	call HandleMenuInput
	jr nc, .wait_for_input
	cp -1 ; was B pressed?
	jp z, PrintDuelMenuAndHandleInput
	ld [wSelectedDuelSubMenuItem], a
	call CheckIfEnoughEnergiesToAttack
	jr nc, .enough_energy
	ldtx hl, NotEnoughEnergyCardsText
	call DrawWideTextBox_WaitForInput
	jr .try_open_attack_menu

.enough_energy
	ldh a, [hCurScrollMenuItem]
	add a
	ld e, a
	ld d, $00
	ld hl, wDuelTempList
	add hl, de
	ld d, [hl] ; card's deck index (0 to 59)
	inc hl
	ld e, [hl] ; attack index (0 or 1)
	call CopyAttackDataAndDamage_FromDeckIndex
	call HandleAmnesiaSubstatus
	jr c, .cannot_use_due_to_amnesia
	ld a, PRACTICEDUEL_VERIFY_PLAYER_TURN_ACTIONS
	call DoPracticeDuelAction
	; if player did something wrong in the practice duel, jump in order to restart turn
	jp c, RestartPracticeDuelTurn
	call UseAttackOrPokemonPower
	jp c, DuelMainInterface
	ret

.cannot_use_due_to_amnesia
	call DrawWideTextBox_WaitForInput
	jr .try_open_attack_menu

.display_selected_attack_info
	call OpenAttackPage
	call DrawDuelMainScene
	jp .try_open_attack_menu

; draw the attack page of the card at wLoadedCard1 and of the attack selected in the Attack
; menu by hCurScrollMenuItem, and listen for input in order to switch the page or to exit.
OpenAttackPage:
	ld a, CARDPAGE_POKEMON_OVERVIEW
	ld [wCardPageNumber], a
	xor a
	ld [wCurPlayAreaSlot], a
	call EmptyScreen
	call FinishQueuedAnimations
	ld de, v0Tiles1 + $20 tiles
	call LoadLoadedCard1Gfx
	call DrawCardPageCardGfx
	call Func_6c12
	call FlushAllPalettesIfNotDMG
	ldh a, [hCurScrollMenuItem]
	ld [wSelectedDuelSubMenuItem], a
	add a
	ld e, a
	ld d, $00
	ld hl, wDuelTempList + 1
	add hl, de
	ld a, [hl]
	or a
	jr nz, .attack_2
	xor a ; ATTACKPAGE_ATTACK1_1
	jr .attack_1

.attack_2
	ld a, ATTACKPAGE_ATTACK2_1

.attack_1
	ld [wAttackPageNumber], a

.open_page
	call DisplayAttackPage
	call EnableLCD

.loop
	call DoFrame
	; switch page (see SwitchAttackPage) if Right or Left pressed
	ldh a, [hDPadHeld]
	and PAD_RIGHT | PAD_LEFT
	jr nz, .open_page
	; return to Attack menu if A or B pressed
	ldh a, [hKeysPressed]
	and PAD_A | PAD_B
	jr z, .loop
	ret

AttackMenuParameters:
	db 1, 13 ; cursor x, cursor y
	db 2 ; y displacement between items
	db 2 ; number of items
	db SYM_CURSOR_R ; cursor tile number
	db SYM_SPACE ; tile behind cursor
	dw NULL ; function pointer if non-0

; display the card page with id at wAttackPageNumber of wLoadedCard1
DisplayAttackPage:
	ld a, [wAttackPageNumber]
	ld hl, AttackPageDisplayPointerTable
	jp JumpToFunctionInTable

AttackPageDisplayPointerTable:
	dw DisplayAttackPage_Attack1Page1 ; ATTACKPAGE_ATTACK1_1
	dw DisplayAttackPage_Attack1Page2 ; ATTACKPAGE_ATTACK1_2
	dw DisplayAttackPage_Attack2Page1 ; ATTACKPAGE_ATTACK2_1
	dw DisplayAttackPage_Attack2Page2 ; ATTACKPAGE_ATTACK2_2

; display ATTACKPAGE_ATTACK1_1
DisplayAttackPage_Attack1Page1:
	call DisplayCardPage_PokemonAttack1Page1
	jr SwitchAttackPage

; display ATTACKPAGE_ATTACK1_2 if it exists. otherwise return in order
; to switch back to ATTACKPAGE_ATTACK1_1 and display it instead.
DisplayAttackPage_Attack1Page2:
	ld hl, wLoadedCard1Atk1Description + 2
	ld a, [hli]
	or [hl]
	ret z
	call DisplayCardPage_PokemonAttack1Page2
	jr SwitchAttackPage

; display ATTACKPAGE_ATTACK2_1
DisplayAttackPage_Attack2Page1:
	call DisplayCardPage_PokemonAttack2Page1
	jr SwitchAttackPage

; display ATTACKPAGE_ATTACK2_2 if it exists. otherwise return in order
; to switch back to ATTACKPAGE_ATTACK2_1 and display it instead.
DisplayAttackPage_Attack2Page2:
	ld hl, wLoadedCard1Atk2Description + 2
	ld a, [hli]
	or [hl]
	ret z
	call DisplayCardPage_PokemonAttack2Page2
;	fallthrough

; switch to ATTACKPAGE_ATTACK*_2 if in ATTACKPAGE_ATTACK*_1 and vice versa.
; sets the next attack page to switch to if Right or Left are pressed.
SwitchAttackPage:
	ld hl, wAttackPageNumber
	ld a, $01
	xor [hl]
	ld [hl], a
	ret

; given the card at hTempCardIndex_ff98, for each non-empty, non-Pokemon Power attack slot,
; prints its information at lines 13 (first attack, if any), and 15 (second attack, if any)
; also, copies zero, one, or both of the following to wDuelTempList, $ff terminated:
;   if pokemon's first attack slot isn't empty or a Pokemon Power: <card_index>, 0
;   if pokemon's second attack slot isn't empty or a Pokemon Power: <card_index>, 1
; return the amount of non-empty, non-Pokemon Power attacks in a.
PrintAndLoadAttacksToDuelTempList:
	call DrawWideTextBox
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	ldh [hTempCardIndex_ff98], a
	call LoadCardDataToBuffer1_FromDeckIndex
	ld c, 0
	ld b, 13
	ld hl, wDuelTempList
	ld a, [wMetronomeEnergyCost]
	push af
	xor a
	ld [wCardPageNumber], a
	ld [wMetronomeEnergyCost], a
	ld de, wLoadedCard1Atk1Name
	call .CheckAttackSlotEmptyOrPokemonPower
	jr c, .check_second_atk_slot
	ldh a, [hTempCardIndex_ff98]
	ld [hli], a
	xor a
	ld [hli], a
	inc c
	push hl
	push bc
	ld e, b
	ld hl, wLoadedCard1Atk1Name
	call PrintAttackOrPkmnPowerInformation
	pop bc
	pop hl
	inc b
	inc b ; 15

.check_second_atk_slot
	ld de, wLoadedCard1Atk2Name
	call .CheckAttackSlotEmptyOrPokemonPower
	jr c, .done
	ldh a, [hTempCardIndex_ff98]
	ld [hli], a
	ld a, $01
	ld [hli], a
	inc c
	push hl
	push bc
	ld e, b
	ld hl, wLoadedCard1Atk2Name
	call PrintAttackOrPkmnPowerInformation
	pop bc
	pop hl

.done
	pop af
	ld [wMetronomeEnergyCost], a
	ld a, c
	ret

; given de = wLoadedCard*Atk*Name, return carry if the attack is a
; Pkmn Power or if the attack slot is empty.
.CheckAttackSlotEmptyOrPokemonPower:
	push hl
	push de
	push bc
	ld a, [de]
	ld c, a
	inc de
	ld a, [de]
	or c
	jr z, .return_no_atk_found
	ld hl, CARD_DATA_ATTACK1_CATEGORY - (CARD_DATA_ATTACK1_NAME + 1)
	add hl, de
	ld a, [hl]
	and $ff ^ RESIDUAL
	cp POKEMON_POWER
	jr z, .return_no_atk_found
	or a
.return
	pop bc
	pop de
	pop hl
	ret
.return_no_atk_found
	scf
	jr .return

; check if the arena pokemon card has enough energy attached to it
; in order to use the selected attack.
; returns: carry if not enough energy, nc if enough energy.
CheckIfEnoughEnergiesToAttack:
	push hl
	push bc
	ld e, PLAY_AREA_ARENA
	call GetPlayAreaCardAttachedEnergies
	call HandleEnergyBurn
	ldh a, [hCurScrollMenuItem]
	add a
	ld e, a
	ld d, $0
	ld hl, wDuelTempList
	add hl, de
	ld d, [hl] ; card's deck index (0 to 59)
	inc hl
	ld e, [hl] ; attack index (0 or 1)
	call .CheckEnergy
	pop bc
	pop hl
	ret

; returns carry if no enough energy
.CheckEnergy:
	push hl
	push de
	push bc
	call GetLoadedAttackEnergyCost
	jr c, .done
	ld de, wAttachedEnergies
	ld hl, wAttackEnergyCost
	lb bc, NUM_COLORED_TYPES, 0
.loop
	ld a, [de]
	sub [hl]
	jr nc, .cost_fulfilled
	; not enough, check for Rainbow energy
	ld a, [wAttachedEnergies + RAINBOW]
	or a
	scf ; not enough energy, set carry
	jr z, .done
	; consume an attached rainbow energy,
	; then loop back to check if cost ir fulfilled
	dec a
	ld [wAttachedEnergies + RAINBOW], a
	dec [hl]
	jr .loop
.cost_fulfilled
	add c
	ld c, a
	inc hl
	inc de
	dec b
	jr nz, .loop
	; colorless energy check
	ld a, [de]
	add c
	ld c, a
	inc de
	ld a, [de]
	add c
	cp [hl]
.done
	pop bc
	pop de
	pop hl
	ret

; print the number of prizes left, of active Pokemon, and of cards left in the deck
; of both duelists. this is called when the duel ends.
PrintDuelResultStats:
	lb de, 8, 8
	call .PrintDuelistResultStats
	lb de, 2, 1
	call SwapTurn
	call .PrintDuelistResultStats
	call SwapTurn
	ret

; print, at d,e, the number of prizes left, of active Pokemon, and of cards left in
; the deck of the turn duelist. b,c are used throughout as input coords for
; WriteTwoDigitNumberInTxSymbolFormat, and d,e for InitTextPrinting_ProcessTextFromID.
.PrintDuelistResultStats:
	call SetNoLineSeparation
	ldtx hl, PrizesLeftActivePokemonCardsInDeckText
	call InitTextPrinting_ProcessTextFromID
	call SetOneLineSeparation
	ld c, e
	ld a, d
	add 7
	ld b, a
	inc a
	inc a
	ld d, a
	call CountPrizes
	call .print_x_cards
	inc e
	inc c
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	ldtx hl, YesText
	or a
	jr nz, .pkmn_in_play_area
	ldtx hl, NoneText
.pkmn_in_play_area
	dec d
	call InitTextPrinting_ProcessTextFromID
	inc e
	inc d
	inc c
	ld a, DUELVARS_NUMBER_OF_CARDS_NOT_IN_DECK
	get_turn_duelist_var
	ld a, DECK_SIZE
	sub [hl]
.print_x_cards
	call WriteTwoDigitNumberInTxSymbolFormat
	ldtx hl, CardsUnitText
	call InitTextPrinting_ProcessTextFromID
	ret

; display the animation of the player drawing the card at hTempCardIndex_ff98
DisplayPlayerDrawCardScreen:
	ldtx hl, YouDrewText
	ldh a, [hTempCardIndex_ff98]
;	fallthrough

; display card detail when a card is drawn or played
; hl is text to display
; a is the card's deck index
DisplayCardDetailScreen:
	call LoadCardDataToBuffer1_FromDeckIndex
	farcall _DisplayCardDetailScreen
	ret
; 0x49e8

SECTION "Bank 1@4a0d", ROMX[$4a0d], BANK[$1]

; handles the initial duel actions:
; - drawing starting hand and placing the Basic Pokemon cards
; - placing the appropriate number of prize cards
; - tossing coin to determine first player to go
HandleDuelSetup:
; init variables and shuffle cards
	call InitializeDuelVariables
	call SwapTurn
	call InitializeDuelVariables
	call SwapTurn
	farcall PlayShuffleAndDrawCardsAnimation_BothDuelists
	call ShuffleDeckAndDrawSevenCards
	ldh [hTemp_ffa0], a
	call SwapTurn
	call ShuffleDeckAndDrawSevenCards
	call SwapTurn
	ld c, a

; check if any Basic Pokémon cards were drawn
	ldh a, [hTemp_ffa0]
	ld b, a
	and c
	jr nz, .hand_cards_ok
	ld a, b
	or c
	jr z, .neither_drew_basic_pkmn
	ld a, b
	or a
	jr nz, .opp_drew_no_basic_pkmn

;.player_drew_no_basic_pkmn
.ensure_player_basic_pkmn_loop
	call DisplayNoBasicPokemonInHandScreenAndText
	call InitializeDuelVariables
	farcall PlayShuffleAndDrawCardsAnimation_TurnDuelist
	call ShuffleDeckAndDrawSevenCards
	jr c, .ensure_player_basic_pkmn_loop
	jr .hand_cards_ok

.opp_drew_no_basic_pkmn
	call SwapTurn
.ensure_opp_basic_pkmn_loop
	call DisplayNoBasicPokemonInHandScreenAndText
	call InitializeDuelVariables
	farcall PlayShuffleAndDrawCardsAnimation_TurnDuelist
	call ShuffleDeckAndDrawSevenCards
	jr c, .ensure_opp_basic_pkmn_loop
	call SwapTurn
	jr .hand_cards_ok

.neither_drew_basic_pkmn
	ldtx hl, NeitherPlayerHasBasicPokemonText
	call DrawWideTextBox_WaitForInput
	call DisplayNoBasicPokemonInHandScreen
	call InitializeDuelVariables
	call SwapTurn
	call DisplayNoBasicPokemonInHandScreen
	call InitializeDuelVariables
	call SwapTurn
	call PrintReturnCardsToDeckDrawAgain
	jp HandleDuelSetup

.hand_cards_ok
	ldh a, [hWhoseTurn]
	push af
	ld a, PLAYER_TURN
	ldh [hWhoseTurn], a
	call ChooseInitialArenaAndBenchPokemon
	call SwapTurn
	call ChooseInitialArenaAndBenchPokemon
	call SwapTurn
	jp c, .error
	call DrawPlayAreaToPlacePrizeCards
	ldtx hl, PlacingThePrizesText
	call DrawWideTextBox_WaitForInput
	call ExchangeRNG

	ld a, [wDuelInitialPrizes]
	ld l, a
	ld h, 0
	call LoadTxRam3
	ldtx hl, EachPlayerPlacePrizesText
	call DrawWideTextBox_PrintText
	call EnableLCD
	farcall PlacePrizes
	call WaitForWideTextBoxInput
	pop af

	ldh [hWhoseTurn], a
	call InitTurnDuelistPrizes
	call SwapTurn
	call InitTurnDuelistPrizes
	call SwapTurn
	call EmptyScreen
	ld a, BOXMSG_COIN_TOSS
	call DrawDuelBoxMessage
	ldtx hl, CoinTossToDecideWhoPlaysFirstText
	call DrawWideTextBox_WaitForInput
	ldh a, [hWhoseTurn]
	cp PLAYER_TURN
	jr nz, .opponent_turn

; player flips coin
	ld de, wDefaultText
	call CopyPlayerName
	ld hl, $0000
	call LoadTxRam2
	ldtx hl, YouPlayFirstText
	ldtx de, IfHeadsDuelistPlaysFirstText
	call TossCoin
	jr c, .play_first
	call SwapTurn
	ldtx hl, YouPlaySecondText
.play_first
	call DrawWideTextBox_WaitForInput
	call ExchangeRNG
	or a
	ret

.opponent_turn
; opp flips coin
	ld de, wDefaultText
	call CopyOpponentName
	ld hl, $0000
	call LoadTxRam2
	ldtx hl, YouPlaySecondText
	ldtx de, IfHeadsDuelistPlaysFirstText
	call TossCoin
	jr c, .play_second
	call SwapTurn
	ldtx hl, YouPlayFirstText
.play_second
	call DrawWideTextBox_WaitForInput
	call ExchangeRNG
	or a
	ret

.error
	pop af
	ldh [hWhoseTurn], a
	scf
	ret

; have the turn duelist place, at the beginning of the duel, the active Pokemon
; and 0 more bench Pokemon, all of which must be basic Pokemon cards.
; also transmits the turn holder's duelvars to the other duelist in a link duel.
; called twice, once for each duelist.
ChooseInitialArenaAndBenchPokemon:
	ld a, DUELVARS_DUELIST_TYPE
	get_turn_duelist_var
	cp DUELIST_TYPE_PLAYER
	jr z, .choose_arena
	cp DUELIST_TYPE_LINK_OPP
	jr z, .exchange_duelvars

; AI opponent's turn
	push af
	push hl
	call AIDoAction_StartDuel
	pop hl
	pop af
	ld [hl], a
	or a
	ret

; link opponent's turn
.exchange_duelvars
	ldtx hl, TransmittingDataText
	call DrawWideTextBox_PrintText
	call ExchangeRNG
	ld hl, wPlayerDuelVariables
	ld de, wOpponentDuelVariables
	ld c, (wOpponentDuelVariables - wPlayerDuelVariables) / 2
	call SerialExchangeBytes
	jr c, .error
	ld c, (wOpponentDuelVariables - wPlayerDuelVariables) / 2
	call SerialExchangeBytes
	jr c, .error
	ld a, DUELVARS_DUELIST_TYPE
	get_turn_duelist_var
	ld [hl], DUELIST_TYPE_LINK_OPP
	or a
	ret
.error
	jp DuelTransmissionError

; player's turn (either AI or link duel)
; prompt (force) the player to choose a basic Pokemon card to place in the arena
.choose_arena
	call EmptyScreen
	ld a, BOXMSG_ARENA_POKEMON
	call DrawDuelBoxMessage
	ldtx hl, ChooseBasicPokemonToPlaceInArenaText
	call DrawWideTextBox_WaitForInput
	ld a, PRACTICEDUEL_DRAW_SEVEN_CARDS
	call DoPracticeDuelAction
.choose_arena_loop
	xor a
	ldtx hl, ChooseActivePokemonText
	call DisplayPlaceInitialPokemonCardsScreen
	jr c, .choose_arena_loop
	ldh a, [hTempCardIndex_ff98]
	call LoadCardDataToBuffer1_FromDeckIndex
	ld a, PRACTICEDUEL_PLAY_DIGLETT
	call DoPracticeDuelAction
	jr c, .choose_arena_loop
	ldh a, [hTempCardIndex_ff98]
	call PutHandPokemonCardInPlayArea
	ldh a, [hTempCardIndex_ff98]
	ldtx hl, PlacedInArenaText
	call DisplayCardDetailScreen
	jr .choose_bench

; after choosing the active Pokemon, let the player place 0 or more basic Pokemon
; cards in the bench. loop until the player decides to stop placing Pokemon cards.
.choose_bench
	call EmptyScreen
	ld a, BOXMSG_BENCH_POKEMON
	call DrawDuelBoxMessage
	ld a, [wMaxNumPlayAreaPokemon]
	dec a
	ld l, a
	ld h, $00
	call LoadTxRam3
	ldtx hl, ChooseUpToXBasicPokemonToPlaceOnBenchText
	call PrintScrollableText_NoTextBoxLabel
	ld a, PRACTICEDUEL_PUT_NIDORANM_IN_BENCH
	call DoPracticeDuelAction
.bench_loop
	ld a, TRUE
	ldtx hl, ChooseBenchedPokemonText
	call DisplayPlaceInitialPokemonCardsScreen
	jr c, .bench_done
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	ld hl, wMaxNumPlayAreaPokemon
	cp [hl]
	jr nc, .no_space
	ldh a, [hTempCardIndex_ff98]
	call PutHandPokemonCardInPlayArea
	ldh a, [hTempCardIndex_ff98]
	ldtx hl, PlacedOnBenchText
	call DisplayCardDetailScreen
	ld a, PRACTICEDUEL_DONE_PUTTING_ON_BENCH
	call DoPracticeDuelAction
	jr .bench_loop

.no_space
	ldtx hl, NoSpaceOnTheBenchText
	call DrawWideTextBox_WaitForInput
	jr .bench_loop

.bench_done
	ld a, PRACTICEDUEL_VERIFY_INITIAL_PLAY
	call DoPracticeDuelAction
	jr c, .bench_loop
	or a
	ret

; the turn duelist shuffles the deck unless it's a practice duel, then draws 7 cards
; returns $00 in a and carry if no basic Pokemon cards are drawn, and $01 in a otherwise
ShuffleDeckAndDrawSevenCards:
	call InitializeDuelVariables
	ld a, [wcd17]
	or a
	jr nz, .deck_ready
	call ShuffleDeck
	call ShuffleDeck
.deck_ready
	ld b, 7
.draw_loop
	call DrawCardFromDeck
	call AddCardToHand
	dec b
	jr nz, .draw_loop
	ld a, DUELVARS_HAND
	get_turn_duelist_var
	ld b, $00
	ld c, 7
.cards_loop
	ld a, [hli]
	push hl
	push bc
	call LoadCardDataToBuffer1_FromDeckIndex
	call IsLoadedCard1BasicPokemon.skip_mysterious_fossil_clefairy_doll
	pop bc
	pop hl
	or b
	ld b, a
	dec c
	jr nz, .cards_loop
	ld a, b
	or a
	ret nz
	xor a
	scf
	ret

; return nc if the card at wLoadedCard1 is a basic Pokemon card
; MYSTERIOUS_FOSSIL and CLEFAIRY_DOLL do count as basic Pokemon cards
IsLoadedCard1BasicPokemon:
	ld hl, wLoadedCard1ID
	cphl MYSTERIOUS_FOSSIL
	jr z, .basic
	cphl CLEFAIRY_DOLL
	jr z, .basic
;	fallthrough

; return nc if the card at wLoadedCard1 is a basic Pokemon card
; MYSTERIOUS_FOSSIL and CLEFAIRY_DOLL do NOT count unless already checked
.skip_mysterious_fossil_clefairy_doll
	ld a, [wLoadedCard1Type]
	cp TYPE_ENERGY
	jr nc, .energy_trainer_nonbasic
	ld a, [wLoadedCard1Stage]
	or a
	jr nz, .energy_trainer_nonbasic

; basic
	ld a, $01
	ret ; z

.energy_trainer_nonbasic
	xor a
	scf
	ret

.basic ; MYSTERIOUS_FOSSIL or CLEFAIRY_DOLL
	ld a, $01
	or a
	ret ; nz

DisplayNoBasicPokemonInHandScreenAndText:
	ldtx hl, NoBasicPokemonInHandText
	call DrawWideTextBox_WaitForInput
	call DisplayNoBasicPokemonInHandScreen
;	fallthrough

; prints ReturnCardsToDeckAndDrawAgainText in a textbox and calls ExchangeRNG
PrintReturnCardsToDeckDrawAgain:
	ldtx hl, ReturnCardsToDeckAndDrawAgainText
	call DrawWideTextBox_WaitForInput
	call ExchangeRNG
	ret

; display a bare list of seven hand cards of the turn duelist, and the duelist's name above
; used to let the player know that there are no basic Pokemon in the hand and need to redraw
DisplayNoBasicPokemonInHandScreen:
	call EmptyScreen
	call Func_6c12
	call LoadDuelCardSymbolTiles
	lb de, 0, 0
	lb bc, 20, 18
	call DrawRegularTextBox
	call CreateHandCardList
	call CountCardsInDuelTempList
	ld hl, NoBasicPokemonCardListParameters
	lb de, 0, 0
	call PrintCardListItems
	ldtx hl, DuelistHandText
	lb de, 1, 1
	call PrintTextNoDelay_Init
	call EnableLCD
	call WaitForWideTextBoxInput
	ret

NoBasicPokemonCardListParameters:
	db 1, 3 ; cursor x, cursor y
	db 4 ; item x
	db 14 ; maximum length, in tiles, occupied by the name and level string of each card in the list
	db 7 ; number of items selectable without scrolling
	db SYM_CURSOR_R ; cursor tile number
	db SYM_SPACE ; tile behind cursor
	dw NULL ; function pointer if non-0

; used only during the practice duel with Sam.
; displays the list with the player's cards in hand, and the player's name above the list.
DisplayPracticeDuelPlayerHandScreen:
	call CreateHandCardList
	call EmptyScreen
	call LoadDuelCardSymbolTiles
	call Func_6c12
	lb de, 0, 0
	lb bc, 20, 13
	call DrawRegularTextBox
	call CountCardsInDuelTempList ; list length
	ld hl, CardListParameters ; other list params
	lb de, 0, 0 ; initial page scroll offset, initial item (in the visible page)
	call PrintCardListItems
	ldtx hl, DuelistHandText
	lb de, 1, 1
	call PrintTextNoDelay_Init
	call EnableLCD
	ret

DrawDuelMainScene::
	ld a, [wDuelType]
	cp $00
	jr nz, .asm_4ced
	ldh a, [hWhoseTurn]
	push af
	ld a, [wWhoseTurn]
	ldh [hWhoseTurn], a
	call .Draw
	pop af
	ldh [hWhoseTurn], a
	ret

.asm_4ced
	ldh a, [hWhoseTurn]
	push af
	ld a, PLAYER_TURN
	ldh [hWhoseTurn], a
	call .Draw
	pop af
	ldh [hWhoseTurn], a
	ret

.Draw:
	ld a, [wDuelDisplayedScreen]
	cp $01
	ret z
	call ZeroObjectPositionsAndToggleOAMCopy
	call EmptyScreen
	call LoadSymbolsFont
	ld a, $01
	ld [wDuelDisplayedScreen], a

	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	cp $ff
	jr z, .turn_duelist_no_arena
	ld de, v0Tiles1 + $50 tiles
	call LoadCardGfxFromDeckIndex
	lb de, 0, 5
	call DrawCardGfxToDE_BGPalIndex2
.turn_duelist_no_arena
	call SwapTurn
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	cp $ff
	jr z, .non_turn_duelist_no_arena
	ld de, v0Tiles1 + $20 tiles
	call LoadCardGfxFromDeckIndex
	lb de, 12, 1
	call DrawCardGfxToDE_BGPalIndex5
	call FlushAllPalettesIfNotDMG
.non_turn_duelist_no_arena
	call SwapTurn
; next, draw the Pokemon in the arena
;.place_player_arena_pkmn
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	cp $ff
	jr z, .place_opponent_arena_pkmn
	ld a, $d0 ; v0Tiles1 + $50 tiles
	lb hl, 6, 1
	lb de, 0, 5
	lb bc, 8, 6
	call FillRectangle
.place_opponent_arena_pkmn
	call SwapTurn
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	cp $ff
	jr z, .place_other_elements
	ld a, $a0 ; v0Tiles1 + $20 tiles
	lb hl, 6, 1
	lb de, 12, 1
	lb bc, 8, 6
	call FillRectangle
.place_other_elements
	call SwapTurn
	ld hl, DuelEAndHPTileData
	call WriteDataBlocksToBGMap0
	farcall DrawDuelHorizontalSeparator
	call DrawDuelHUDs
	call DrawWideTextBox
	call EnableLCD
	ret

DrawDuelHUDs::
	ld a, [wDuelDisplayedScreen]
	cp $01
	ret nz
	ld e, PLAYER_TURN
	ld a, [wDuelType]
	cp $00
	jr nz, .asm_4d95
	ld a, [wWhoseTurn]
	ld e, a
.asm_4d95
	ldh a, [hWhoseTurn]
	push af
	ld a, e
	ldh [hWhoseTurn], a
	lb de, 1, 11 ; coordinates for player's arena card name and info icons
	lb bc, 11, 8 ; coordinates for player's attached energies and HP bar
	call DrawDuelHUD
	lb bc, 8, 5
	ld a, DUELVARS_ARENA_CARD_STATUS
	get_turn_duelist_var
	call CheckPrintCnfSlpPrz
	inc c
	call CheckPrintPoisoned
	inc c
	call CheckPrintDoublePoisoned ; if double poisoned, print a second poison icon
	inc c
	ld a, 1
	call CheckPrintFoodCounters

	call SwapTurn
	lb de, 7, 0 ; coordinates for opponent's arena card name and info icons
	lb bc, 3, 1 ; coordinates for opponent's attached energies and HP bar
	call GetNonTurnDuelistVariable
	call DrawDuelHUD
	lb bc, 11, 6
	ld a, DUELVARS_ARENA_CARD_STATUS
	get_turn_duelist_var
	call CheckPrintCnfSlpPrz
	dec c
	call CheckPrintPoisoned
	dec c
	call CheckPrintDoublePoisoned ; if double poisoned, print a second poison icon
	dec c
	ld a, -1
	call CheckPrintFoodCounters
	pop af
	ldh [hWhoseTurn], a
	ret

DuelEAndHPTileData:
; x, y, tiles[], 0
	db 1, 1, SYM_E,  0
	db 1, 2, SYM_HP, 0
	db 9, 8, SYM_E,  0
	db 9, 9, SYM_HP, 0
	db $ff ; end

DrawDuelHUD:
	ld hl, wHUDEnergyAndHPBarsX
	ld [hl], b
	inc hl
	ld [hl], c ; wHUDEnergyAndHPBarsY
	push de
	ld d, 1 ; x
	ld a, e
	or a
	jr z, .asm_4e05
	ld d, 15 ; x
.asm_4e05
	push de
	pop bc

	; number of Bench Pokemon
	ld a, SYM_POKEMON
	call WriteByteToBGMap0
	inc b
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	add SYM_0 - 1
	call WriteByteToBGMap0
	inc b

	; number of prize cards
	ld a, SYM_PRIZE
	call WriteByteToBGMap0
	inc b
	call CountPrizes
	add SYM_0
	call WriteByteToBGMap0
	pop de

	; Arena card names
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	cp $ff
	ret z ; no arena card
	call LoadCardDataToBuffer1_FromDeckIndex
	push de
	ld a, 32
	call CopyCardNameAndLevel
	ld [hl], TX_END

	; print the arena Pokemon card color symbol just before the name
	pop de
	ld a, e
	or a
	jr nz, .print_color_icon
	ld hl, wDefaultText
	call GetTextLengthInTiles
	add SCREEN_WIDTH
	ld d, a
.print_color_icon
	call InitTextPrinting
	ld hl, wDefaultText
	call ProcessText
	push de
	pop bc
	call GetArenaCardColor
	inc a ; TX_SYMBOL color tiles start at 1
	dec b ; place the color symbol one tile to the left of the start of the card's name
	call JPWriteByteToBGMap0

	; print attached energies
	ld hl, wHUDEnergyAndHPBarsX
	ld b, [hl]
	inc hl
	ld c, [hl] ; wHUDEnergyAndHPBarsY
	lb de, 9, PLAY_AREA_ARENA
	call PrintPlayAreaCardAttachedEnergies

	; print HP bar
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call LoadCardDataToBuffer1_FromDeckIndex
	ld a, [wLoadedCard1HP]
	ld d, a ; max HP
	ld a, DUELVARS_ARENA_CARD_HP
	get_turn_duelist_var
	ld e, a ; cur HP
	call DrawHPBar
	ld hl, wHUDEnergyAndHPBarsX
	ld b, [hl]
	inc hl
	ld c, [hl] ; wHUDEnergyAndHPBarsY
	inc c ; [wHUDEnergyAndHPBarsY] + 1
	call BCCoordToBGMap0Address
	push de
	ld hl, wDefaultText
	ld b, HP_BAR_LENGTH / 2 ; first row of the HP bar
	call SafeCopyDataHLtoDE
	pop de
	ld hl, TILEMAP_WIDTH
	add hl, de
	ld e, l
	ld d, h
	ld hl, wDefaultText + HP_BAR_LENGTH / 2
	ld b, HP_BAR_LENGTH / 2 ; second row of the HP bar
	call SafeCopyDataHLtoDE

	; print number of attached Pluspower and Defender with respective icon, if any
	ld hl, wHUDEnergyAndHPBarsX
	ld a, [hli]
	add 6
	ld b, a
	ld c, [hl] ; wHUDEnergyAndHPBarsY
	inc c
	ld a, DUELVARS_ARENA_CARD_ATTACHED_PLUSPOWER
	get_turn_duelist_var
	or a
	jr z, .check_defender
	ld a, SYM_PLUSPOWER
	call WriteByteToBGMap0
	inc b
	ld a, [hl] ; number of attached Pluspower
	add SYM_0
	call WriteByteToBGMap0
	dec b
.check_defender
	ld a, DUELVARS_ARENA_CARD_ATTACHED_DEFENDER
	get_turn_duelist_var
	or a
	jr z, .done
	inc c
	ld a, SYM_DEFENDER
	call WriteByteToBGMap0
	inc b
	ld a, [hl] ; number of attached Defender
	add SYM_0
	call WriteByteToBGMap0
.done
	ret

; if this is a practice duel, execute the practice duel action at wPracticeDuelAction
; if not a practice duel, always return nc
; the practice duel functions below return carry when something's wrong
DoPracticeDuelAction:
	ld [wPracticeDuelAction], a
	ld a, [wIsPracticeDuel]
	or a
	ret z
	ld a, [wPracticeDuelAction]
	ld hl, PracticeDuelActionTable
	jp JumpToFunctionInTable

PracticeDuelActionTable:
	dw NULL
	dw PracticeDuel_DrawSevenCards
	dw PracticeDuel_PlayDiglett
	dw PracticeDuel_PutPidgeyInBench
	dw PracticeDuel_VerifyInitialPlay
	dw PracticeDuel_DonePuttingOnBench
	dw PracticeDuel_PrintTurnInstructions
	dw PracticeDuel_VerifyPlayerTurnActions
	dw PracticeDuel_RepeatInstructions
	dw PracticeDuel_PlayNidoranMFromBench
	dw PracticeDuel_ReplaceKnockedOutPokemon

PracticeDuel_DrawSevenCards:
	call DisplayPracticeDuelPlayerHandScreen
	call EnableLCD
	ldtx hl, PracticeDuelMasonSetupsActivePokemonText
	jp PrintPracticeDuelDrMasonInstructions

PracticeDuel_PlayDiglett:
	ld hl, wLoadedCard1ID
	cphl DIGLETT_LV8
	ret z
	ldtx hl, PracticeDuelMasonSetupsActivePokemonIncorrectText
	scf
	jp PrintPracticeDuelDrMasonInstructions

PracticeDuel_PutPidgeyInBench:
	call DisplayPracticeDuelPlayerHandScreen
	call EnableLCD
	ldtx hl, PracticeDuelMasonSetupsBenchedPokemonText
	jp PrintPracticeDuelDrMasonInstructions

PracticeDuel_VerifyInitialPlay:
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	cp 2
	ret z
	ldtx hl, PracticeDuelMasonSetupsBenchedPokemonIncorrectText
	scf
	jp PrintPracticeDuelDrMasonInstructions

PracticeDuel_DonePuttingOnBench:
	call DisplayPracticeDuelPlayerHandScreen
	call EnableLCD
	ld a, $ff
	ld [wPracticeDuelTurn], a
	ldtx hl, PracticeDuelMasonSetupsFinishPressBText
	jp PrintPracticeDuelDrMasonInstructions

PracticeDuel_PrintTurnInstructions:
	call EmptyScreen
	ld a, [wDuelTurns]
	srl a
	inc a
	ld l, a
	ld h, $00
	call LoadTxRam3
	ld de, $0
	lb bc, 20, 12
	call DrawRegularTextBox
	lb de, 1, 0
	ldtx hl, PracticeDuelHeaderPlayersTurnNumberText
	call Func_2c4b
	call EnableLCD
	ld a, [wDuelTurns]
	ld hl, wPracticeDuelTurn
	cp [hl]
	ld [hl], a
	; calling PrintPracticeDuelInstructionsForCurrentTurn with a = 0 means that Dr. Mason's
	; instructions are also printed along with each of the point-by-point instructions
	ld a, 0
	jp nz, PrintPracticeDuelInstructionsForCurrentTurn
	; if we're here, the player followed the current turn actions wrong and has to
	; repeat them. ask the player whether to show detailed instructions again, in
	; order to call PrintPracticeDuelInstructionsForCurrentTurn with a = 0 or a = 1.
	ldtx de, DrMasonText
	ldtx hl, PracticeDuelMasonExplainAgainPromptText
	call PrintScrollableText_WithTextBoxLabel_NoWait
	call YesOrNoMenu
	jp PrintPracticeDuelInstructionsForCurrentTurn

PracticeDuel_VerifyPlayerTurnActions:
	ld a, [wDuelTurns]
	srl a
	ld hl, PracticeDuelTurnVerificationPointerTable
	call JumpToFunctionInTable
	; return nc if player followed instructions correctly
	ret nc
;	fallthrough

PracticeDuel_RepeatInstructions:
	ldtx hl, PracticeDuelMasonIncorrectRetryText
	call PrintPracticeDuelDrMasonInstructions
	; restart the turn from the saved data of the previous turn
	ld a, $02
	call BankswitchSRAM
	ld de, sCurrentDuel
	farcall LoadSavedDuelData
	xor a
	call BankswitchSRAM
	call DisableSRAM
	; return carry in order to repeat instructions
	scf
	ret

PracticeDuel_PlayNidoranMFromBench:
	ld a, [wDuelTurns]
	cp 7
	jr z, .its_sam_turn_4
.no_carry
	or a
	ret
.its_sam_turn_4
	call EmptyScreen
	lb de, 0, 0
	lb bc, 20, 12
	call DrawRegularTextBox
	lb de, 1, 0
	ldtx hl, PracticeDuelHeaderKnockedOutReplaceText
	call Func_2c4b
	call EnableLCD
	ld hl, PracticeDuelText_SamTurn4
	jp PrintPracticeDuelInstructions

PracticeDuel_ReplaceKnockedOutPokemon:
	ld a, [wDuelTurns]
	cp 7
	jr nz, PracticeDuel_PlayNidoranMFromBench.no_carry
	ldh a, [hTempPlayAreaLocation_ff9d]
	cp PLAY_AREA_BENCH_2
	ret z
	; if player selected other Pokemon instead
	call HasAlivePokemonInBench
	ldtx hl, PracticeDuelKnockedOutMasonIncorrectText
	scf
;	fallthrough

; print a text box with given the text id at hl, labeled as 'Dr. Mason'
PrintPracticeDuelDrMasonInstructions:
	push af
	ldtx de, DrMasonText
	call PrintScrollableText_WithTextBoxLabel
	pop af
	ret

INCLUDE "data/duel/practice_text.asm"

; print the instructions of the current practice duel turn, taken from
; one of the structs in PracticeDuelTextPointerTable.
; if a != 0, only the point-by-point instructions are printed, otherwise
; Dr. Mason instructions are also shown in a textbox at the bottom of the screen.
PrintPracticeDuelInstructionsForCurrentTurn:
	push af
	ld a, [wDuelTurns]
	and %11111110
	ld e, a
	ld d, $00
	ld hl, PracticeDuelTextPointerTable
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	pop af
	or a
	jr nz, PrintPracticeDuelInstructions_Fast
;	fallthrough

; print practice duel instructions given hl = PracticeDuelText_*
; each practicetext entry (see above) contains a Dr. Mason text along with
; a numbered instruction text, that is later printed without text delay.
PrintPracticeDuelInstructions:
	ld a, [hli]
	ld [wPracticeDuelTextY], a
	or a
	jr z, PrintPracticeDuelLetsPlayTheGame
	ld e, [hl]
	inc hl
	ld d, [hl]
	inc hl
	push hl
	ld l, e
	ld h, d
	call PrintPracticeDuelDrMasonInstructions
	pop hl
	ld e, [hl]
	inc hl
	ld d, [hl]
	inc hl
	push hl
	call SetNoLineSeparation
	ld l, e
	ld h, d
	ld a, [wPracticeDuelTextY]
	ld e, a
	ld d, 1
	call InitTextPrinting_ProcessTextFromID
	call SetOneLineSeparation
	pop hl
	jr PrintPracticeDuelInstructions

; print the generic Dr. Mason's text that completes all his practice duel instructions
PrintPracticeDuelLetsPlayTheGame:
	ldtx hl, PracticeDuelMasonProceedAsTaughtText
	call PrintPracticeDuelDrMasonInstructions
	ret

; simplified version of PrintPracticeDuelInstructions that skips Dr. Mason's text
; and instead places the point-by-point instructions all at once.
PrintPracticeDuelInstructions_Fast:
	ld a, [hli]
	or a
	jr z, PrintPracticeDuelLetsPlayTheGame
	ld e, a ; y
	ld d, 1 ; x
	inc hl
	inc hl
	ld c, [hl]
	inc hl
	ld b, [hl]
	inc hl
	push hl
	ld l, c
	ld h, b
	call SetNoLineSeparation
	call InitTextPrinting_ProcessTextFromID
	call SetOneLineSeparation
	pop hl
	jr PrintPracticeDuelInstructions_Fast

PracticeDuelTurnVerificationPointerTable:
	dw PracticeDuelVerify_Turn1
	dw PracticeDuelVerify_Turn2
	dw PracticeDuelVerify_Turn3
	dw PracticeDuelVerify_Turn4
	dw PracticeDuelVerify_Turn5
	dw PracticeDuelVerify_Turn6

PracticeDuelVerify_Turn1:
	ld hl, wTempCardID_ccc2
	cphl DIGLETT_LV8
	jp nz, ReturnWrongAction
	ret

PracticeDuelVerify_Turn2:
	ld hl, wTempCardID_ccc2
	cphl DIGLETT_LV8
	jp nz, ReturnWrongAction
	ld a, [wSelectedAttack]
	cp SECOND_ATTACK
	jp nz, ReturnWrongAction
	ret

PracticeDuelVerify_Turn3:
	ld hl, wTempCardID_ccc2
	cphl DUGTRIO_LV36
	jp nz, ReturnWrongAction
	ld e, PLAY_AREA_ARENA
	call GetPlayAreaCardAttachedEnergies
	ld a, [wAttachedEnergies + FIGHTING]
	cp 3
	jr nz, ReturnWrongAction
	or a
	ret

PracticeDuelVerify_Turn4:
	ld a, [wPlayerNumberOfPokemonInPlayArea]
	cp 3
	jr nz, ReturnWrongAction
	ld e, PLAY_AREA_BENCH_2
	call GetPlayAreaCardAttachedEnergies
	ld a, [wAttachedEnergies + GRASS]
	or a
	jr z, ReturnWrongAction
	ld hl, wTempCardID_ccc2
	cphl DUGTRIO_LV36
	jp nz, ReturnWrongAction
	or a
	ret

PracticeDuelVerify_Turn5:
	ld a, [wPlayerNumberOfPokemonInPlayArea]
	cp 3
	jr nz, ReturnWrongAction
	ld e, PLAY_AREA_ARENA
	call GetPlayAreaCardAttachedEnergies
	ld a, [wAttachedEnergies + GRASS]
	cp 2
	jr nz, ReturnWrongAction
	ld hl, wTempCardID_ccc2
	cphl NIDORANM_LV20
	jr nz, ReturnWrongAction
	ret

PracticeDuelVerify_Turn6:
	ld hl, wTempCardID_ccc2
	cphl NIDORINO_LV25
	jr nz, ReturnWrongAction
	or a
	ret

ReturnWrongAction:
	scf
	ret

; display BOXMSG_PLAYERS_TURN or BOXMSG_OPPONENTS_TURN and print
; DuelistsTurnText in a textbox. also call ExchangeRNG.
DisplayDuelistTurnScreen:
	call EmptyScreen
	ld c, BOXMSG_PLAYERS_TURN
	ldh a, [hWhoseTurn]
	cp PLAYER_TURN
	jr z, .got_turn
	inc c ; BOXMSG_OPPONENTS_TURN
.got_turn
	ld a, c
	call DrawDuelBoxMessage
	ldtx hl, DuelistsTurnText
	call DrawWideTextBox_WaitForInput
	call ExchangeRNG
	ret
; 0x5177

SECTION "Bank 1@517e", ROMX[$517e], BANK[$1]

DuelMenuData:
	; x, y, text id
	textitem  3, 14, HandText
	textitem  9, 14, CheckText
	textitem 15, 14, RetreatText
	textitem  3, 16, AttackText
	textitem  9, 16, PokemonPowerHiraganaText
	textitem 15, 16, DoneText
	db $ff

; display the screen that prompts the player to choose a Pokemon card to
; place in the arena or in the bench at the beginning of the duel.
; input:
   ; a = 0 -> prompted to place Pokemon card in arena
   ; a = 1 -> prompted to place Pokemon card in bench
; return carry if no card was placed (only allowed for bench)
DisplayPlaceInitialPokemonCardsScreen:
	ld [wPlacingInitialBenchPokemon], a
	push hl
	call CreateHandCardList
	call InitAndDrawCardListScreenLayout
	pop hl
	call SetCardListInfoBoxText
	ld a, PLAY_CHECK
	ld [wCardListItemSelectionMenuType], a
.display_card_list
	call DisplayCardList
	jr nc, .card_selected
	; attempted to exit screen
	ld a, [wPlacingInitialBenchPokemon]
	or a
	; player is forced to place a Pokemon card in the arena
	jr z, .display_card_list
	; in the bench, however, we can get away without placing anything
	; alternatively, the player doesn't want or can't place more bench Pokemon
	scf
	jr .done
.card_selected
	ldh a, [hTempCardIndex_ff98]
	call LoadCardDataToBuffer1_FromDeckIndex
	call IsLoadedCard1BasicPokemon
	jr nc, .done
	; invalid card selected, tell the player and go back
	ldtx hl, YouCannotSelectThisCardText
	call DrawWideTextBox_WaitForInput
	call DrawCardListScreenLayout
	jr .display_card_list
.done
	; valid basic Pokemon card selected, or no card selected (bench only)
	push af
	ld a, [wSortCardListByID]
	or a
	jr z, .skip_sorting
	call SortHandCardsByID
.skip_sorting
	pop af
	ret
; 0x51d9

SECTION "Bank 1@51ed", ROMX[$51ed], BANK[$1]

; draw the turn holder's discard pile screen
OpenDiscardPileScreen:
	call CreateDiscardPileCardList
	jr c, .discard_pile_empty
	call InitAndDrawCardListScreenLayout
	ldtx hl, ChooseCardToCheckText
	ldtx de, DuelistDiscardPileText
	call SetCardListHeaderAndInfoText
	ld a, PAD_START + PAD_A
	ld [wNoItemSelectionMenuKeys], a
	call DisplayCardList
	or a
	ret
.discard_pile_empty
	; this might be either because there are no cards
	; in the Discard Pile, or that Black Hole is active
	; in which case the "No cards in Discard Pile" text
	; will always show here regardless
	ldtx hl, TheDiscardPileHasNoCardsText
	call DrawWideTextBox_WaitForInput
	scf
	ret

; hl = info text ID
; de = header text ID
SetCardListHeaderAndInfoText:
	ld a, e
	ld [wCardListHeaderText], a
	ld a, d
	ld [wCardListHeaderText + 1], a
;	fallthrough

SetCardListInfoBoxText:
	ld a, l
	ld [wCardListInfoBoxText + 0], a
	ld a, h
	ld [wCardListInfoBoxText + 1], a
	ret
; 0x5221

SECTION "Bank 1@522a", ROMX[$522a], BANK[$1]

; draw the layout of the screen that displays the player's Hand card list or a
; Discard Pile card list, including a bottom-right image of the current card.
; since this loads the text for the Hand card list screen, SetDiscardPileScreenTexts
; is called after this if the screen corresponds to a Discard Pile list.
; the dimensions of text box where the card list is printed are 20x13, in order to accommodate
; another text box below it (wCardListInfoBoxText) as well as the image of the selected card.
InitAndDrawCardListScreenLayout:
	xor a
	ld hl, wSelectedDuelSubMenuItem
	ld [hli], a
	ld [hl], a
	ld [wSortCardListByID], a
	ld hl, wPrintSortNumberInCardListPtr
	ld [hli], a
	ld [hl], a
	ld [wCardListItemSelectionMenuType], a
	ld a, PAD_START
	ld [wNoItemSelectionMenuKeys], a
	ld hl, wCardListInfoBoxText
	ldtx [hl], PleaseSelectHandText, & $ff
	inc hl
	ldtx [hl], PleaseSelectHandText, >> 8
	inc hl ; wCardListHeaderText
	ldtx [hl], DuelistHandText, & $ff
	inc hl
	ldtx [hl], DuelistHandText, >> 8
; fallthrough

; same as InitAndDrawCardListScreenLayout, except that variables like wSelectedDuelSubMenuItem,
; wNoItemSelectionMenuKeys, wCardListInfoBoxText, wCardListHeaderText, etc already set by caller.
DrawCardListScreenLayout:
	call ZeroObjectPositionsAndToggleOAMCopy
	call EmptyScreen
	call LoadSymbolsFont
	call LoadDuelCardSymbolTiles
	call Func_6c12
	; draw the surrounding box
	lb de, 0, 0
	lb bc, 20, 13
	call DrawRegularTextBox
	; draw the image of the selected card
	ld a, $a0
	lb hl, 6, 1
	lb de, 12, 12
	lb bc, 8, 6
	call FillRectangle
	call Func_53cb
	ld a, [wDuelTempList]
	cp $ff
	scf
	ret z
	or a
	ret

; displays a list of cards and handles input in order to navigate through the list,
; select a card, open a card page, etc.
; input:
   ; - text IDs at wCardListInfoBoxText and wCardListHeaderText
   ; - $ff-terminated list of cards to display at wDuelTempList
   ; - wSelectedDuelSubMenuItem (initial item) and wSelectedDuelSubMenuScrollOffset
   ;   (initial page scroll offset). Usually both 0 to begin with the first card.
; returns carry if B is pressed to exit the card list screen.
; otherwise returns the selected card at hTempCardIndex_ff98 and at a.
DisplayCardList:
	call DrawNarrowTextBox
	call PrintCardListHeaderAndInfoBoxTexts
.reload_list
	; get the list length
	call CountCardsInDuelTempList
	; get the position and scroll within the list
	ld hl, wSelectedDuelSubMenuItem
	ld e, [hl] ; initial item (in the visible page)
	inc hl
	ld d, [hl] ; initial page scroll offset
	ld hl, CardListParameters ; other list params
	call PrintCardListItems
	call LoadSelectedCardGfx
	call EnableLCD
.wait_button
	call DoFrame
	call .UpdateListOnDPadInput
	call HandleCardListInput
	jr nc, .wait_button
	; refresh the position of the last checked card of the list, so that
	; the cursor points to said card when the list is reloaded
	ld hl, wSelectedDuelSubMenuItem
	ld [hl], e
	inc hl
	ld [hl], d
	ldh a, [hKeysPressed]
	ld b, a
	bit B_PAD_SELECT, b
	jr nz, .select_pressed
	bit B_PAD_B, b
	jr nz, .b_pressed
	ld a, [wNoItemSelectionMenuKeys]
	and b
	jr nz, .open_card_page
	; display the item selection menu (PLAY|CHECK or SELECT|CHECK) for the selected card
	; open the card page if CHECK is selected
	ldh a, [hCurScrollMenuItem]
	call GetCardInDuelTempList_OnlyDeckIndex
	call CardListItemSelectionMenu
	; jump back if B pressed to exit the item selection menu
	jr c, DisplayCardList
	ldh a, [hTempCardIndex_ff98]
	or a
	ret
.select_pressed
	; sort cards by ID if SELECT is pressed and return to the first item
	ld a, [wSortCardListByID]
	or a
	jr nz, .wait_button
	call SortCardsInDuelTempListByID
	xor a
	ld hl, wSelectedDuelSubMenuItem
	ld [hli], a
	ld [hl], a
	ld a, 1
	ld [wSortCardListByID], a
	call EraseCursor
	jr .reload_list
.open_card_page
	; open the card page directly, without an item selection menu
	; in this mode, D_UP and D_DOWN can be used to open the card page
	; of the card above and below the current card
	ldh a, [hCurScrollMenuItem]
	call GetCardInDuelTempList
	call LoadCardDataToBuffer1_FromDeckIndex
	call OpenCardPage_FromCheckHandOrDiscardPile
	ldh a, [hDPadHeld]
	bit B_PAD_UP, a
	jr nz, .up_pressed
	bit B_PAD_DOWN, a
	jr nz, .down_pressed
	; if B pressed, exit card page and reload the card list
	call DrawCardListScreenLayout
	jp DisplayCardList
.up_pressed
	ldh a, [hCurScrollMenuItem]
	or a
	jr z, .open_card_page ; if can't go up, reload card page of current card
	dec a
	jr .move_to_another_card
.down_pressed
	call CountCardsInDuelTempList
	ld b, a
	ldh a, [hCurScrollMenuItem]
	inc a
	cp b
	jr nc, .open_card_page ; if can't go down, reload card page of current card
.move_to_another_card
	; update hCurScrollMenuItem, and wSelectedDuelSubMenuScrollOffset.
	; this means that when navigating up/down through card pages, the page is
	; scrolled to reflect the movement, rather than the cursor going up/down.
	ldh [hCurScrollMenuItem], a
	ld hl, wSelectedDuelSubMenuItem
	ld [hl], $00
	inc hl
	ld [hl], a
	jr .open_card_page
.b_pressed
	ldh a, [hCurScrollMenuItem]
	scf
	ret

.UpdateListOnDPadInput:
	ldh a, [hDPadHeld]
	and PAD_CTRL_PAD
	ret z
	ld a, $01
	ldh [hffbb], a
	call PrintCardListHeaderAndInfoBoxTexts
	xor a
	ldh [hffbb], a
	ret

; prints the text ID at wCardListHeaderText at 1,1
; and the text ID at wCardListInfoBoxText at 1,14
PrintCardListHeaderAndInfoBoxTexts:
	ld hl, wCardListInfoBoxText
	ld a, [hli]
	ld h, [hl]
	ld l, a
	lb de, 1, 14
	call PrintTextNoDelay_Init
	ld hl, wCardListHeaderText
	ld a, [hli]
	ld h, [hl]
	ld l, a
	lb de, 1, 1
	call PrintTextNoDelay_Init
	ret

; display the SELECT|CHECK or PLAY|CHECK menu when a card of a list is selected
; and handle input. return carry if b is pressed.
; input: wCardListItemSelectionMenuType
CardListItemSelectionMenu:
	ld a, [wCardListItemSelectionMenuType]
	or a
	ret z
	ldtx hl, MenuSelectCheckText
	ld a, [wCardListItemSelectionMenuType]
	cp PLAY_CHECK
	jr nz, .got_text
	ldh a, [hTempCardIndex_ff98]
	call LoadCardDataToBuffer1_FromDeckIndex
; handle verbs
; redundant in English, where both are just "PLAY"
	ldtx hl, MenuPutOutCheckText
	ld a, [wLoadedCard1Type]
	cp TYPE_TRAINER
	jr nz, .got_text
	ldtx hl, MenuUseCheckText
.got_text
	call DrawNarrowTextBox_PrintTextNoDelay
	ld hl, ItemSelectionMenuParameters
	xor a
	call InitializeMenuParameters
.wait_a_or_b
	call DoFrame
	call HandleMenuInput
	jr nc, .wait_a_or_b
	cp -1
	jr z, .b_pressed
	; A pressed
	or a
	ret z
	; CHECK option selected: open the card page
	ldh a, [hTempCardIndex_ff98]
	call LoadCardDataToBuffer1_FromDeckIndex
	call OpenCardPage_FromHand
	call DrawCardListScreenLayout
.b_pressed
	scf
	ret

ItemSelectionMenuParameters:
	db 1, 14 ; cursor x, cursor y
	db 2 ; y displacement between items
	db 2 ; number of items
	db SYM_CURSOR_R ; cursor tile number
	db SYM_SPACE ; tile behind cursor
	dw NULL ; function pointer if non-0

CardListParameters:
	db 1, 3 ; cursor x, cursor y
	db 4 ; item x
	db 14 ; maximum length, in tiles, occupied by the name and level string of each card in the list
	db 5 ; number of items selectable without scrolling
	db SYM_CURSOR_R ; cursor tile number
	db SYM_SPACE ; tile behind cursor
	dw CardListFunction ; function pointer if non-0

; return carry if any of the buttons is pressed, and load the graphics
; of the card pointed to by the cursor whenever a d-pad key is released.
; also return $ff unto hCurScrollMenuItem if B is pressed.
CardListFunction:
	ldh a, [hKeysPressed]
	bit B_PAD_B, a
	jr nz, .exit
	and PAD_A | PAD_SELECT | PAD_START
	jr nz, .action_button
	ldh a, [hKeysReleased]
	and PAD_CTRL_PAD
	jr nz, .reload_card_image ; jump if the PAD_CTRL_PAD key was released this frame
	ret
.exit
	ld a, $ff
	ldh [hCurScrollMenuItem], a
.action_button
	scf
	ret
.reload_card_image
	call LoadSelectedCardGfx
	or a
	ret
; 0x53bc

SECTION "Bank 1@53cb", ROMX[$53cb], BANK[$1]

Func_53cb:
	ld hl, wPrintSortNumberInCardListPtr
	jp CallIndirect
; 0x53d1

SECTION "Bank 1@53e9", ROMX[$53e9], BANK[$1]

; draw the card page of the card at wLoadedCard1 and listen for input
; in order to switch the page or to exit.
; triggered by checking a hand card or a discard pile card in the Check menu.
; D_UP and D_DOWN exit the card page allowing the caller to load the card page
; of the card above or below in the list.
OpenCardPage_FromCheckHandOrDiscardPile:
	ld a, PAD_B | PAD_UP | PAD_DOWN
	ld [wCardPageExitKeys], a
	xor a ; CARDPAGETYPE_NOT_PLAY_AREA
	jr OpenCardPage

; draw the card page of the card at wLoadedCard1 and listen for input
; in order to switch the page or to exit.
; triggered by checking an arena card or a bench card in the Check menu.
OpenCardPage_FromCheckPlayArea:
	ld a, PAD_B
	ld [wCardPageExitKeys], a
	ld a, CARDPAGETYPE_PLAY_AREA
	jr OpenCardPage

; draw the card page of the card at wLoadedCard1 and listen for input
; in order to switch the page or to exit.
; triggered by checking a card in the Hand menu.
OpenCardPage_FromHand:
	ld a, PAD_B
	ld [wCardPageExitKeys], a
	xor a ; CARDPAGETYPE_NOT_PLAY_AREA
;	fallthrough

; draw the card page of the card at wLoadedCard1 and listen for input
; in order to switch the page or to exit.
OpenCardPage:
	ld [wCardPageType], a
	call ZeroObjectPositionsAndToggleOAMCopy
	call EmptyScreen
	call FinishQueuedAnimations
	; load the graphics and display the card image of wLoadedCard1
	call LoadDuelCardSymbolTiles
	ld de, v0Tiles1 + $200
	call LoadLoadedCard1Gfx
	lb de, 6, 4
	call DrawCardGfxToDE_BGPalIndex5
	call Func_6c12
	call FlushAllPalettesIfNotDMG
	; display the initial card page for the card at wLoadedCard1
	xor a
	ld [wCardPageNumber], a

.load_next
	call DisplayFirstOrNextCardPage
	jr c, .done ; done if trying to advance past the last page with START or A

.loop_input
	call DoFrame
	ldh a, [hDPadHeld]
	ld b, a
	ld a, [wCardPageExitKeys]
	and b
	jr nz, .done
	; START and A advance to the next valid card page, but close it
	; after trying to advance from the last page
	ldh a, [hKeysPressed]
	and PAD_A | PAD_START
	jr nz, .load_next
	; D_RIGHT and D_LEFT advance to the next and previous valid card page respectively.
	; however, unlike START and A, D_RIGHT past the last page goes back to the start.
	ldh a, [hKeysPressed]
	and PAD_RIGHT | PAD_LEFT
	jr z, .loop_input
	call .LeftOrRightPressed
	jr .loop_input
.done
	ret

.LeftOrRightPressed:
	bit B_PAD_LEFT, a
	jr nz, .d_left
; d_right
	call DisplayFirstOrNextCardPage
	call c, DisplayCardPage
	ret
.d_left
	call DisplayPreviousCardPage
	call c, DisplayCardPage
	ret

DrawCardPageCardGfx:
	ld de, v0Tiles1 + $20 tiles
	call LoadLoadedCard1Gfx
	ld a, $a0
	lb hl, 6, 1
	lb de, 6, 4
	lb bc, 8, 6
	call FillRectangle
	lb de, 6, 4
	call DrawCardGfxToDE_BGPalIndex5
	ret
; 0x5475

SECTION "Bank 1@549b", ROMX[$549b], BANK[$1]

; has turn duelist take amount of prizes that are in wNumberPrizeCardsToTake
; returns carry if all prize cards were taken
TurnDuelistTakePrizes:
	call FinishQueuedAnimations
	ld a, [wNumberPrizeCardsToTake]
	ld l, a
	ld h, $00
	call LoadTxRam3
	ld a, DUELVARS_DUELIST_TYPE
	get_turn_duelist_var
	cp DUELIST_TYPE_PLAYER
	jr nz, .opponent

; player
	ldtx hl, WillDrawXPrizesText
	call DrawWideTextBox_WaitForInput
	ld a, [wNumberPrizeCardsToTake]
	call SelectPrizeCards
	ld hl, hTemp_ffa0
	ld d, [hl]
	inc hl
	ld e, [hl]
	call SerialSend8Bytes

.return_has_prizes
	call ExchangeRNG
	ld a, DUELVARS_PRIZES
	get_turn_duelist_var
	or a
	ret nz
	scf
	ret

.opponent
	call .Func_588a
	ldtx hl, WillDrawXPrizesText
	call DrawWideTextBox_PrintText
	call CountPrizes
	ld [wTempNumRemainingPrizeCards], a
	ld a, DUELVARS_DUELIST_TYPE
	get_turn_duelist_var
	cp DUELIST_TYPE_LINK_OPP
	jr z, .link_opponent
	ld c, 60
.delay_loop
	call DoFrame
	dec c
	jr nz, .delay_loop
	call AIDoAction_TakePrize
	jr .asm_586f

.link_opponent
	call SerialRecv8Bytes
	ld a, DUELVARS_PRIZES
	get_turn_duelist_var
	ld [hl], d
	ld a, e
	cp $ff
	jr z, .asm_586f
	call AddCardToHand
	call .Func_551d

.asm_586f
	ld a, [wTempNumRemainingPrizeCards]
	ld hl, wNumberPrizeCardsToTake
	cp [hl]
	jr nc, .asm_587e
	ld l, a
	ld h, $00
	call LoadTxRam3
.asm_587e
	farcall Func_82b6
	ldtx hl, DrewXPrizesText
	call DrawWideTextBox_WaitForInput
	jr .return_has_prizes

.Func_551d:
	ld e, a
	ld a, [wcc07]
	or a
	ret z
	ld a, e
	call LoadCardDataToBuffer1_FromDeckIndex
	ldtx hl, DrewFromPrizesText
	farcall _DisplayCardDetailScreen
	call OpenCardPage_FromHand
	call .Func_588a ; can be fallthrough
	ret

.Func_588a:
	ld l, PLAYER_TURN
	ldh a, [hWhoseTurn]
	ld h, a
	jp DrawYourOrOppPlayAreaScreen_Bank0

; display the previous valid card page
DisplayPreviousCardPage:
	call GoToPreviousCardPage
	jr nc, DisplayCardPage
	ret

; display the next valid card page or load the first valid card page if [wCardPageNumber] == 0
DisplayFirstOrNextCardPage:
	call GoToFirstOrNextCardPage
	ret c
;	fallthrough

; display the card page with id at wCardPageNumber of wLoadedCard1
DisplayCardPage:
	ld a, [wCardPageNumber]
	ld hl, CardPageDisplayPointerTable
	call JumpToFunctionInTable
	call EnableLCD
	or a
	ret

; load the tiles and palette of the card selected in card list screen
LoadSelectedCardGfx:
	ldh a, [hCurScrollMenuItem]
	call GetCardInDuelTempList
	call LoadCardDataToBuffer1_FromCardID
	ld de, v0Tiles1 + $20 tiles
	call LoadLoadedCard1Gfx
	lb de, 12, 12
	call DrawCardGfxToDE_BGPalIndex5
	call Func_6c12
	call FlushAllPalettesIfNotDMG
	ret

CardPageDisplayPointerTable:
	dw DrawDuelMainScene ; $0
	dw DisplayCardPage_PokemonOverview ; CARDPAGE_POKEMON_OVERVIEW
	dw DisplayCardPage_PokemonAttack1Page1 ; CARDPAGE_POKEMON_ATTACK1_1
	dw DisplayCardPage_PokemonAttack1Page2 ; CARDPAGE_POKEMON_ATTACK1_2
	dw DisplayCardPage_PokemonAttack2Page1 ; CARDPAGE_POKEMON_ATTACK2_1
	dw DisplayCardPage_PokemonAttack2Page2 ; CARDPAGE_POKEMON_ATTACK2_2
	dw DisplayCardPage_PokemonDescription ; CARDPAGE_POKEMON_DESCRIPTION
	dw DrawDuelMainScene ; $7
	dw DrawDuelMainScene ; $8
	dw DisplayCardPage_Energy1 ; CARDPAGE_ENERGY_1
	dw DisplayCardPage_Energy2 ; CARDPAGE_ENERGY_2
	dw DrawDuelMainScene ; $b
	dw DrawDuelMainScene ; $c
	dw DisplayCardPage_TrainerPage1 ; CARDPAGE_TRAINER_1
	dw DisplayCardPage_TrainerPage2 ; CARDPAGE_TRAINER_2
	dw DrawDuelMainScene ; $f

; given the current card page at [wCardPageNumber], go to the next valid card page or load
; the first valid card page of the current card at wLoadedCard1 if [wCardPageNumber] == 0
GoToFirstOrNextCardPage:
	ld a, [wCardPageNumber]
	or a
	jr nz, .advance_page
	; load the first page for this type of card
	ld a, [wLoadedCard1Type]
	ld b, a
	ld a, CARDPAGE_ENERGY_1
	bit TYPE_ENERGY_F, b
	jr nz, .set_initial_page
	ld a, CARDPAGE_TRAINER_1
	bit TYPE_TRAINER_F, b
	jr nz, .set_initial_page
	ld a, CARDPAGE_POKEMON_OVERVIEW
.set_initial_page
	ld [wCardPageNumber], a
	or a
	ret

.advance_page
	ld hl, wCardPageNumber
	inc [hl]
	ld a, [hl]
	call SwitchCardPage
	jr c, .set_card_page
	; stay in this page if it exists, or skip to previous page if it doesn't
	or a
	ret nz
	; non-existent page: skip to next
	jr .advance_page
.set_card_page
	ld [wCardPageNumber], a
	ret

; given the current card page at [wCardPageNumber], go to the previous
; valid card page for the current card at wLoadedCard1
GoToPreviousCardPage:
	ld hl, wCardPageNumber
	dec [hl]
	ld a, [hl]
	call SwitchCardPage
	jr c, .set_card_page
	; stay in this page if it exists, or skip to previous page if it doesn't
	or a
	ret nz
	; non-existent page: skip to previous
	jr GoToPreviousCardPage
.set_card_page
	ld [wCardPageNumber], a
.previous_page_loop
	call SwitchCardPage
	or a
	jr nz, .stay
	ld hl, wCardPageNumber
	dec [hl]
	jr .previous_page_loop
.stay
	scf
	ret

; check if the card page trying to switch to is valid for the card at wLoadedCard1
; return with the equivalent to one of these three actions:
   ; stay in card page trying to switch to (nc, nz)
   ; change to card page returned in a if D_LEFT/D_RIGHT pressed, or exit if A/START pressed (c)
   ; non-existent page, so skip to next/previous (nc, z)
SwitchCardPage:
	ld hl, .CardPageSwitchPointerTable
	jp JumpToFunctionInTable

.CardPageSwitchPointerTable:
	dw CardPageSwitch_00
	dw CardPageSwitch_PokemonOverviewOrDescription ; CARDPAGE_POKEMON_OVERVIEW
	dw CardPageSwitch_PokemonAttack1Page1 ; CARDPAGE_POKEMON_ATTACK1_1
	dw CardPageSwitch_PokemonAttack1Page2 ; CARDPAGE_POKEMON_ATTACK1_2
	dw CardPageSwitch_PokemonAttack2Page1 ; CARDPAGE_POKEMON_ATTACK2_1
	dw CardPageSwitch_PokemonAttack2Page2 ; CARDPAGE_POKEMON_ATTACK2_2
	dw CardPageSwitch_PokemonOverviewOrDescription ; CARDPAGE_POKEMON_DESCRIPTION
	dw CardPageSwitch_PokemonEnd
	dw CardPageSwitch_08
	dw CardPageSwitch_EnergyOrTrainerPage1 ; CARDPAGE_ENERGY_1
	dw CardPageSwitch_TrainerPage2 ; CARDPAGE_ENERGY_1 + 1
	dw CardPageSwitch_EnergyEnd
	dw CardPageSwitch_0c
	dw CardPageSwitch_EnergyOrTrainerPage1 ; CARDPAGE_TRAINER_1
	dw CardPageSwitch_TrainerPage2 ; CARDPAGE_TRAINER_2
	dw CardPageSwitch_TrainerEnd

; return with CARDPAGE_POKEMON_DESCRIPTION
CardPageSwitch_00:
	ld a, CARDPAGE_POKEMON_DESCRIPTION
	scf
	ret

; return with current page
CardPageSwitch_PokemonOverviewOrDescription:
	ld a, $1
	or a
	ret ; nz

; return with current page if [wLoadedCard1Atk1Name] non-0
; (if card has at least one attack)
CardPageSwitch_PokemonAttack1Page1:
	ld hl, wLoadedCard1Atk1Name
	jr CheckCardPageExists

; return with current page if [wLoadedCard1Atk1Description + 2] non-0
; (if card's first attack has a two-page description)
CardPageSwitch_PokemonAttack1Page2:
	ld hl, wLoadedCard1Atk1Description + 2
	jr CheckCardPageExists

; return with current page if [wLoadedCard1Atk2Name] non-0
; (if card has two attacks)
CardPageSwitch_PokemonAttack2Page1:
	ld hl, wLoadedCard1Atk2Name
	jr CheckCardPageExists

; return with current page if [wLoadedCard1Atk1Description + 2] non-0
; (if card's second attack has a two-page description)
CardPageSwitch_PokemonAttack2Page2:
	ld hl, wLoadedCard1Atk2Description + 2
;	fallthrough

CheckCardPageExists:
	ld a, [hli]
	or [hl]
	ret

; return with CARDPAGE_POKEMON_OVERVIEW
CardPageSwitch_PokemonEnd:
	ld a, CARDPAGE_POKEMON_OVERVIEW
	scf
	ret

; return with CARDPAGE_ENERGY_1 + 1
CardPageSwitch_08:
	ld a, CARDPAGE_ENERGY_1 + 1
	scf
	ret

; return with current page
CardPageSwitch_EnergyOrTrainerPage1:
	ld a, $1
	or a
	ret ; nz

; return with current page if [wLoadedCard1NonPokemonDescription + 2] non-0
; (if this trainer card has a two-page description)
CardPageSwitch_TrainerPage2:
	ld hl, wLoadedCard1NonPokemonDescription + 2
	jr CheckCardPageExists

; return with CARDPAGE_ENERGY_1
CardPageSwitch_EnergyEnd:
	ld a, CARDPAGE_ENERGY_1
	scf
	ret

; return with CARDPAGE_TRAINER_2
CardPageSwitch_0c:
	ld a, CARDPAGE_TRAINER_2
	scf
	ret

; return with CARDPAGE_TRAINER_1
CardPageSwitch_TrainerEnd:
	ld a, CARDPAGE_TRAINER_1
	scf
	ret

ZeroObjectPositionsAndToggleOAMCopy:
	call ZeroObjectPositions
	ld a, $01
	ld [wVBlankOAMCopyToggle], a
	ret
; 0x5647

SECTION "Bank 1@5670", ROMX[$5670], BANK[$1]

LoadCardGfxFromDeckIndex:
	push de
	call LoadCardDataToBuffer1_FromDeckIndex
	pop de
;	fallthrough

LoadLoadedCard1Gfx:
	ld hl, wLoadedCard1Gfx
	ld a, [hli]
	ld h, [hl]
	ld l, a
	lb bc, $30, TILE_SIZE
	call LoadCardGfx
	ret

; applies the tilemap of the loaded card gfx
; to coordinates in de, and loads its palette
; starting from BG pal 2
DrawCardGfxToDE_BGPalIndex2:
	ld a, [wConsole]
	or a
	ret z
	ld a, $02
	call LoadCardPalettesAndAttributes
	ret

; applies the tilemap of the loaded card gfx
; to coordinates in de, and loads its palette
; starting from BG pal 5
DrawCardGfxToDE_BGPalIndex5:
	ld a, [wConsole]
	or a
	ret z
	ld a, $5
	call LoadCardPalettesAndAttributes
	ret
; 0x5698

SECTION "Bank 1@56a6", ROMX[$56a6], BANK[$1]

; de = coordinates
LoadCardPalettesAndAttributes:
	push de
	call .CopyCardPals
	pop bc

	; copy attributes
	push hl
	call BCCoordToBGMap0Address
	pop hl
	call BankswitchVRAM1
	ld c, $06
.loop_copy_attr
	ld b, $08
	push de
	call SafeCopyDataHLtoDE
	pop de
	ld a, e
	add TILEMAP_WIDTH
	ld e, a
	ld a, $00
	adc d
	ld d, a
	dec c
	jr nz, .loop_copy_attr
	call BankswitchVRAM0
	ret

; a = starting BG palette index to copy to
.CopyCardPals:
	ld c, a
	add a
	add a
	add a ; *8
	ld e, a
	ld d, $00
	ld hl, wBackgroundPalettesCGB
	add hl, de
	ld de, wCardPalettes
	ld b, 3 palettes
.loop_copy_pal
	ld a, [de]
	inc de
	ld [hli], a
	dec b
	jr nz, .loop_copy_pal

	; de = wCardAttrMap
	push de
	ld b, $30
.asm_56e4
	ld a, [de]
	rlca
	rlca
	and $03
	add c
	ld [de], a
	inc de
	dec b
	jr nz, .asm_56e4
	pop hl
	ret

FlushAllPalettesIfNotDMG:
	ld a, [wConsole]
	or a
	ret z
	call FlushAllPalettes
	ret
; 0x56fa

	ret ; stray ret

JPWriteByteToBGMap0:
	jp WriteByteToBGMap0

DisplayCardPage_PokemonOverview:
	ld a, [wCardPageType]
	or a
	jr nz, .play_area_card_page

	; print surrounding box, card name at 5,1, type, set 2, and rarity
	call PrintPokemonCardPageGenericInformation
	; print fixed text and draw the card symbol associated to its TYPE_*
	ld hl, CardPageRetreatWRTextData
	call PlaceTextItems
	ld hl, CardPageLvHPNoTextTileData
	call WriteDataBlocksToBGMap0
	lb de, 3, 2
	call DrawCardSymbol
	; print pre-evolution's name (if any)
	ld a, [wLoadedCard1Stage]
	or a
	jr z, .basic
	ld hl, wLoadedCard1NonPokemonDescription
	lb de, 1, 3
	call InitTextPrinting_ProcessTextFromPointerToID
.basic
	; print card level and maximum HP
	lb bc, 12, 2
	ld a, [wLoadedCard1Level]
	call WriteTwoDigitNumberInTxSymbolFormat
	lb bc, 16, 2
	ld a, [wLoadedCard1HP]
	call WriteTwoByteNumberInTxSymbolFormat
	jr .print_numbers_and_energies

.play_area_card_page
	; draw the surrounding box, and print fixed text
	call DrawCardPageBoxAndCardGfx
	call LoadDuelCheckPokemonScreenTiles
	ld hl, CardPageRetreatWRTextData
	call PlaceTextItems
	ld hl, CardPageNoTextTileData
	call WriteDataBlocksToBGMap0
	ld a, 1
	ld [wCurPlayAreaY], a
	; print set 2 icon and rarity symbol at fixed positions
	call DrawCardPageSet2AndRarityIcons
	; print (Y coord at [wCurPlayAreaY]) card name, level, type, energies, HP, location...
	call PrintPlayAreaCardInformationAndLocation

; common for both card page types
.print_numbers_and_energies
	; print Pokedex number in the bottom right corner (16,16)
	lb bc, 16, 16
	ld a, [wLoadedCard1PokedexNumber]
	call WriteTwoByteNumberInTxSymbolFormat
	; print the name, damage, and energy cost of each attack and/or Pokemon power that exists
	; first attack at 5,10 and second at 5,12
	lb bc, 5, 10

.attacks
	ld e, c
	ld hl, wLoadedCard1Atk1Name
	call PrintAttackOrPkmnPowerInformation
	inc c
	inc c ; 12
	ld e, c
	ld hl, wLoadedCard1Atk2Name
	call PrintAttackOrPkmnPowerInformation
	; print the retreat cost (some amount of colorless energies) at 8,14
	inc c
	inc c ; 14
	ld b, 5
	ld a, [wLoadedCard1RetreatCost]
	ld e, a
	inc e
.retreat_cost_loop
	dec e
	jr z, .retreat_cost_done
	ld a, SYM_COLORLESS
	call JPWriteByteToBGMap0
	inc b
	jr .retreat_cost_loop
.retreat_cost_done
	; print the colors (energies) of the weakness(es) and resistance(s)
	inc c ; 15
	ld a, [wCardPageType]
	or a
	jr z, .wr_from_loaded_card
	ld a, [wCurPlayAreaSlot]
	or a
	jr nz, .wr_from_loaded_card
	call GetArenaCardWeakness
	ld d, a
	call GetArenaCardResistance
	ld e, a
	jr .got_wr
.wr_from_loaded_card
	ld a, [wLoadedCard1Weakness]
	ld d, a
	ld a, [wLoadedCard1Resistance]
	ld e, a
.got_wr
	ld a, d
	ld b, 5
	call PrintCardPageWeaknessesOrResistances
	inc c
	ld a, e
	call PrintCardPageWeaknessesOrResistances
	ret

; displays the name, damage, and energy cost of an attack or Pokemon power.
; used in the Attack menu and in the card page of a Pokemon.
; input:
   ; hl: pointer to attack 1 name in a atk_data_struct (which can be inside at card_data_struct)
   ; e: Y coordinate to start printing the data at
PrintAttackOrPkmnPowerInformation:
	ld a, [hli]
	or [hl]
	ret z
	push bc
	push hl
	dec hl
	; print text ID pointed to by hl at 7,e
	ld d, 7
	call InitTextPrinting_ProcessTextFromPointerToID
	pop hl
	inc hl
	inc hl
	ld a, [wCardPageNumber]
	or a
	jr nz, .print_damage
	dec hl
	ld a, [hli]
	or [hl]
	jr z, .print_damage
	; if in Attack menu and attack 1 description exists, print at 7,e:
	ld b, 7
	ld c, e
	inc c
	ld a, SYM_ATK_DESCR
	call WriteByteToBGMap0
.print_damage
	inc hl
	inc hl
	inc hl
	push hl
	ld a, [hl]
	or a
	jr z, .print_category
	; print attack damage at 15,(e+1) if non-0
	ld b, 15 ; unless damage has three digits, this is effectively 16
	ld c, e
	inc c
	call WriteTwoByteNumberInTxSymbolFormat
.print_category
	pop hl
	inc hl
	ld a, [hl]
	and $ff ^ RESIDUAL
	jr z, .print_energy_cost
	cp POKEMON_POWER
	jr z, .print_pokemon_power
	; register a is DAMAGE_PLUS, DAMAGE_MINUS, or DAMAGE_X
	; print the damage modifier (+, -, x) at 18,(e+1) (after the damage value)
	add SYM_PLUS - DAMAGE_PLUS
	ld b, 18
	ld c, e
	inc c
	call WriteByteToBGMap0
	jr .print_energy_cost
.print_energy_cost
	ld bc, CARD_DATA_ATTACK1_ENERGY_COST - CARD_DATA_ATTACK1_CATEGORY
	add hl, bc
	ld c, e
	ld b, 2 ; bc = 2, e
	lb de, NUM_TYPES / 2, 0
.energy_loop
	ld a, [hl]
	swap a
	call .PrintEnergiesOfColor
	ld a, [hli]
	call .PrintEnergiesOfColor
	dec d
	jr nz, .energy_loop
	pop bc
	ret
.print_pokemon_power
	; print "PKMN PWR" at 2,e
	ld d, 2
	ldtx hl, PokemonPowerKanjiText
	call InitTextPrinting_ProcessTextFromID
	pop bc
	ret

; print the number of energies required of color (type) e, and return e ++ (next color).
; the requirement of the current color is provided as input in the lower nybble of a.
.PrintEnergiesOfColor:
	inc e
	and $0f
	ret z
	push de
	ld d, a
.print_energies_loop
	ld a, e
	call JPWriteByteToBGMap0
	inc b
	dec d
	jr nz, .print_energies_loop
	pop de
	ret

; print the weaknesses or resistances of a Pokemon card, given in a, at b,c
PrintCardPageWeaknessesOrResistances:
	push bc
	push de
	ld d, a
	xor a ; FIRE
.loop
	; each WR_* constant is a different bit. rotate the value to find out
	; which bits are set and therefore which WR_* values are active.
	; a is kept updated with the equivalent TYPE_* constant.
	inc a
	cp 8
	jr nc, .done
	rl d
	jr nc, .loop
	push af
	call JPWriteByteToBGMap0
	inc b
	pop af
	jr .loop
.done
	pop de
	pop bc
	ret

; prints surrounding box, card name at 5,1, type, set 2, and rarity.
; used in all CARDPAGE_POKEMON_* and ATTACKPAGE_*, except in
; CARDPAGE_POKEMON_OVERVIEW when wCardPageType is CARDPAGETYPE_PLAY_AREA.
PrintPokemonCardPageGenericInformation:
	call DrawCardPageBoxAndCardGfx
	lb de, 5, 1
	ld hl, wLoadedCard1Name
	call InitTextPrinting_ProcessTextFromPointerToID
	ld a, [wCardPageType]
	or a
	jr z, .from_loaded_card
	ld a, [wCurPlayAreaSlot]
	call GetPlayAreaCardColor
	jr .got_color
.from_loaded_card
	ld a, [wLoadedCard1Type]
.got_color
	lb bc, 18, 1
	inc a
	call JPWriteByteToBGMap0
	call DrawCardPageSet2AndRarityIcons
	ret

DrawCardPageBoxAndCardGfx:
	lb de, 0, 0
	lb bc, 20, 18
	call DrawRegularTextBox
	call DrawCardPageCardGfx
	ret

CardPageRetreatWRTextData:
	textitem 1, 14, RetreatText
	textitem 1, 15, WeaknessText
	textitem 1, 16, ResistanceText
	db $ff

CardPageLvHPNoTextTileData:
	db 11,  2, SYM_Lv, 0
	db 15,  2, SYM_HP, 0
;	continues to CardPageNoTextTileData

CardPageNoTextTileData:
	db 15, 16, SYM_No, 0
	db $ff

DisplayCardPage_PokemonAttack1Page1:
	ld hl, wLoadedCard1Atk1Name
	ld de, wLoadedCard1Atk1Description
	jr DisplayPokemonAttackCardPage

DisplayCardPage_PokemonAttack1Page2:
	ld hl, wLoadedCard1Atk1Name
	ld de, wLoadedCard1Atk1Description + 2
	jr DisplayPokemonAttackCardPage

DisplayCardPage_PokemonAttack2Page1:
	ld hl, wLoadedCard1Atk2Name
	ld de, wLoadedCard1Atk2Description
	jr DisplayPokemonAttackCardPage

DisplayCardPage_PokemonAttack2Page2:
	ld hl, wLoadedCard1Atk2Name
	ld de, wLoadedCard1Atk2Description + 2
;	fallthrough

; input:
   ; hl = address of the attack's name (text id)
   ; de = address of the attack's description (either first or second text id)
DisplayPokemonAttackCardPage:
	push de
	push hl
	; print surrounding box, card name at 5,1, type, set 2, and rarity
	call PrintPokemonCardPageGenericInformation
	; print name, damage, and energy cost of attack or Pokemon power starting at line 2
	ld e, 2
	pop hl
	call PrintAttackOrPkmnPowerInformation
	pop hl
;	fallthrough

; print, if non-null, the description of the trainer card, energy card, attack,
; or Pokemon power, given as a pointer to text id in hl, starting from 1,11
PrintAttackOrNonPokemonCardDescription:
	ld a, [hli]
	or [hl]
	ret z
	dec hl
	lb de, 1, 11
	call PrintAttackOrCardDescription
	ret

DisplayCardPage_PokemonDescription:
	; print surrounding box, card name at 5,1, type, set 2, and rarity
	call PrintPokemonCardPageGenericInformation
	call LoadDuelCardSymbolTiles2
	; print "LENGTH", "WEIGHT", "Lv", and "HP" where it corresponds in the page
	ld hl, CardPageLengthWeightTextData
	call PlaceTextItems
	ld hl, CardPageLvHPTextTileData
	call WriteDataBlocksToBGMap0
	; draw the card symbol associated to its TYPE_* at 3,2
	lb de, 3, 2
	call DrawCardSymbol
	; print the Level and HP numbers at 12,2 and 16,2 respectively
	lb bc, 12, 2
	ld a, [wLoadedCard1Level]
	call WriteTwoDigitNumberInTxSymbolFormat
	lb bc, 16, 2
	ld a, [wLoadedCard1HP]
	call WriteTwoByteNumberInTxSymbolFormat
	; print the Pokemon's category at 1,10 (just above the length and weight texts)
	lb de, 1, 10
	ld hl, wLoadedCard1Category
	call InitTextPrinting_ProcessTextFromPointerToID
	ld a, TX_KATAKANA
	call ProcessSpecialTextCharacter
	ldtx hl, PokemonText
	call ProcessTextFromID
	; print the length at 3, 11
	lb bc, 3, 11
	ld a, [wLoadedCard1Length]
	ld l, a
	ld h, $00
	call PrintNumberAsMeasurement
	call InitTextPrinting
	ldtx hl, LengthUnitMetresText
	call ProcessTextFromID
	; print the weight at 3, 12
	lb bc, 3, 12
	ld hl, wLoadedCard1Weight
	ld a, [hli]
	ld h, [hl]
	ld l, a
	call PrintNumberAsMeasurement
	ldtx hl, WeightUnitKilogramsText
	call InitTextPrinting_ProcessTextFromID
	call SetNoLineSeparation
	ld a, 19
	lb de, 1, 14
	call InitTextPrintingInTextbox
	ld hl, wLoadedCard1Description
	call ProcessTextFromPointerToID
	call SetOneLineSeparation
	ret

; given a card rarity constant in a, and CardRarityTextIDs in hl,
; print the text character associated to it at d,e
PrintCardPageRarityIcon:
	inc a
	add a
	ld c, a
	ld b, $00
	add hl, bc
	call InitTextPrinting_ProcessTextFromPointerToID
	ret

; prints the card's set 2 icon and the full width text character of the card's rarity
DrawCardPageSet2AndRarityIcons:
	ld a, [wLoadedCard1RealSet]
	call LoadCardSet2Tiles
	jr c, .icon_done
	; draw the 2x2 set 2 icon of this card
	ld a, $fc
	lb hl, 1, 2
	lb bc, 2, 2
	lb de, 15, 8
	call FillRectangle
.icon_done
	lb de, 18, 9
	ld hl, CardRarityTextIDs
	ld a, [wLoadedCard1Rarity]
	cp PROMOSTAR
	call nz, PrintCardPageRarityIcon
	ret

CardPageLengthWeightTextData:
	textitem 1, 11, LengthText
	textitem 1, 12, WeightText
	db $ff

CardPageLvHPTextTileData:
	db 11, 2, SYM_Lv, 0
	db 15, 2, SYM_HP, 0
	db $ff

CardRarityTextIDs:
	tx PromostarRarityText ; PROMOSTAR (unused)
	tx CircleRarityText    ; CIRCLE
	tx DiamondRarityText   ; DIAMOND
	tx StarRarityText      ; STAR
	tx WhitestarRarityText ; WHITESTAR

DisplayCardPage_TrainerPage1:
	xor a ; HEADER_TRAINER
	ld hl, wLoadedCard1NonPokemonDescription
	jr DisplayEnergyOrTrainerCardPage

DisplayCardPage_TrainerPage2:
	xor a ; HEADER_TRAINER
	ld hl, wLoadedCard1NonPokemonDescription + 2
	jr DisplayEnergyOrTrainerCardPage

DisplayCardPage_Energy2:
	ld a, HEADER_ENERGY
	ld hl, wLoadedCard1NonPokemonDescription + 2
	jr DisplayEnergyOrTrainerCardPage

DisplayCardPage_Energy1:
	ld a, HEADER_ENERGY
	ld hl, wLoadedCard1NonPokemonDescription
;	fallthrough

; input:
   ; a = HEADER_ENERGY or HEADER_TRAINER
   ; hl = address of the card's description (text id)
DisplayEnergyOrTrainerCardPage:
	push hl
	push af
	call LoadCardTypeHeaderTiles
	; draw surrounding box
	lb de, 0, 0
	lb bc, 20, 18
	call DrawRegularTextBox
	pop af
	ld e, a
	ld d, $00
	ld hl, .HeaderPaletteIndices
	add hl, de
	ld a, [hl]
	lb hl, 0, 0
	call BankswitchVRAM1
	call .FillHeaderRectangle
	call BankswitchVRAM0
	call DrawCardPageCardGfx
	; print the card's name at 4,3
	lb de, 4, 3
	ld hl, wLoadedCard1Name
	call InitTextPrinting_ProcessTextFromPointerToID
	ld a, $e0
	lb hl, 1, 8
	call .FillHeaderRectangle
	call DrawCardPageSet2AndRarityIcons
	pop hl
	call PrintAttackOrNonPokemonCardDescription
	ret

.FillHeaderRectangle:
	lb de, 6, 1
	lb bc, 8, 2
	jp FillRectangle

.HeaderPaletteIndices:
	db $4 ; HEADER_TRAINER
	db $3 ; HEADER_ENERGY
	db $2 ; HEADER_POKEMON (unused)

; print lines of text with no separation between them
SetNoLineSeparation:
	ld a, SINGLE_SPACED
;	fallthrough

SetLineSeparation:
	ld [wLineSeparation], a
	ret

; separate lines of text by an empty line
SetOneLineSeparation:
	xor a
	jr SetLineSeparation

; prints number in register hl, first
; by dividing by 10, then by adding ".0"
; to the end if result has less than
; 4 digits (ie xxxx.0)
PrintNumberAsMeasurement:
	push bc
	ld de, -1
	ld bc, -10
.loop_subtract
	inc de
	add hl, bc
	jr c, .loop_subtract
	ld bc, 10
	add hl, bc
	pop bc
	push hl
	push bc
	ld l, e
	ld h, d
	call TwoByteNumberToTxSymbol_TrimLeadingZeros_Bank1
	pop bc
	pop hl
	ld a, l
	ld hl, wStringBuffer + $5
	or a
	jr z, .skip_decimal
	; appends ".0" to string
	ld [hl], SYM_DOT
	inc hl
	add SYM_0
	ld [hli], a
.skip_decimal
	ld [hl], TX_END
	push bc
	call BCCoordToBGMap0Address

	; loop through the string to find the first
	; non-0 byte (first number character)
	ld hl, wStringBuffer
.loop_find_first_number
	ld a, [hli]
	or a
	jr z, .loop_find_first_number
	dec hl

	; now loop string until end of text is found
	; and output size in b for SafeCopyDataHLtoDE
	push hl
	ld b, -1
.loop_get_size
	inc b
	ld a, [hli]
	or a
	jr nz, .loop_get_size
	pop hl
	push bc
	call SafeCopyDataHLtoDE
	pop bc
	pop de
	ld a, b
	add d
	ld d, a
	ret

; return carry if the turn holder has any Pokemon with non-zero HP on the bench.
; return how many Pokemon with non-zero HP in b.
; does this by calculating how many Pokemon in play area minus one
HasAlivePokemonInBench:
	ld a, $01
	jr _HasAlivePokemonInPlayArea

; return carry if the turn holder has any Pokemon with non-zero HP in the play area.
; return how many Pokemon with non-zero HP in b.
HasAlivePokemonInPlayArea:
	xor a
;	fallthrough

_HasAlivePokemonInPlayArea:
	ld [wExcludeArenaPokemon], a
	ld b, a
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	sub b
	ld c, a
	ld a, DUELVARS_ARENA_CARD_HP
	add b
	get_turn_duelist_var
	ld b, 0
	inc c
	xor a
	ld [wPlayAreaScreenLoaded], a
	ld [wPlayAreaSelectAction], a
	jr .next_pkmn
.loop
	ld a, [hli]
	or a
	jr z, .next_pkmn ; jump if this play area Pokemon has 0 HP
	inc b
.next_pkmn
	dec c
	jr nz, .loop
	ld a, b
	or a
	ret nz
	scf
	ret

OpenPlayAreaScreenForViewing:
	ld a, PAD_START + PAD_A
	jr DisplayPlayAreaScreen

OpenPlayAreaScreenForSelection:
	ld a, PAD_START
;	fallthrough

DisplayPlayAreaScreen:
	ld [wNoItemSelectionMenuKeys], a
	ldh a, [hTempCardIndex_ff98]
	push af
	ld a, [wPlayAreaScreenLoaded]
	or a
	jr nz, .skip_ahead
	xor a
	ld [wSelectedDuelSubMenuItem], a
	ld a, $01
	ld [wPlayAreaScreenLoaded], a
.asm_6022
	call ZeroObjectPositionsAndToggleOAMCopy
	call EmptyScreen
	call LoadSymbolsFont
	call LoadDuelCardSymbolTiles
	call LoadDuelCheckPokemonScreenTiles
	call PrintPlayAreaCardList
	call FlushAllPalettesIfNotDMG
	call EnableLCD
.skip_ahead
	ld hl, PlayAreaScreenMenuParameters_ActivePokemonIncluded
	ld a, [wExcludeArenaPokemon]
	or a
	jr z, .init_menu_params
	ld hl, PlayAreaScreenMenuParameters_ActivePokemonExcluded
.init_menu_params
	ld a, [wSelectedDuelSubMenuItem]
	call InitializeMenuParameters
	ld a, [wNumPlayAreaItems]
	ld [wNumScrollMenuItems], a
.asm_604c
	call DoFrame
	call SelectingBenchPokemonMenu
	jr nc, .asm_6061
	cp $02
	jp z, .asm_60ac
	cp $03
	jr z, .asm_6022
	pop af
	ldh [hTempCardIndex_ff98], a
	jr OpenPlayAreaScreenForSelection
.asm_6061
	call HandleMenuInput
	jr nc, .asm_604c
	ld a, e
	ld [wSelectedDuelSubMenuItem], a
	ld a, [wExcludeArenaPokemon]
	add e
	ld [wCurPlayAreaSlot], a
	ld a, [wNoItemSelectionMenuKeys]
	ld b, a
	ldh a, [hKeysPressed]
	and b
	jr z, .asm_6091
	ld a, [wCurPlayAreaSlot]
	add DUELVARS_ARENA_CARD
	get_turn_duelist_var
	cp -1
	jr z, .asm_6022
	call GetCardIDFromDeckIndex
	call LoadCardDataToBuffer1_FromCardID
	call OpenCardPage_FromCheckPlayArea
	jr .asm_6022
.asm_6091
	ld a, [wExcludeArenaPokemon]
	ld c, a
	ldh a, [hCurScrollMenuItem]
	add c
	ldh [hTempPlayAreaLocation_ff9d], a
	ldh a, [hCurScrollMenuItem]
	cp $ff
	jr z, .asm_60b5
	ldh a, [hTempPlayAreaLocation_ff9d]
	add DUELVARS_ARENA_CARD_HP
	get_turn_duelist_var
	or a
	jr nz, .asm_60ac
	jr .skip_ahead
.asm_60ac
	pop af
	ldh [hTempCardIndex_ff98], a
	ldh a, [hTempPlayAreaLocation_ff9d]
	ldh [hCurScrollMenuItem], a
	or a
	ret
.asm_60b5
	pop af
	ldh [hTempCardIndex_ff98], a
	ldh a, [hTempPlayAreaLocation_ff9d]
	ldh [hCurScrollMenuItem], a
	scf
	ret

PlayAreaScreenMenuParameters_ActivePokemonIncluded:
	db 0, 0 ; cursor x, cursor y
	db 3 ; y displacement between items
	db 6 ; number of items
	db SYM_CURSOR_R ; cursor tile number
	db SYM_SPACE ; tile behind cursor
	dw PlayAreaScreenMenuFunction ; function pointer if non-0

PlayAreaScreenMenuParameters_ActivePokemonExcluded:
	db 0, 3 ; cursor x, cursor y
	db 3 ; y displacement between items
	db 6 ; number of items
	db SYM_CURSOR_R ; cursor tile number
	db SYM_SPACE ; tile behind cursor
	dw PlayAreaScreenMenuFunction ; function pointer if non-0

PlayAreaScreenMenuFunction:
	ldh a, [hKeysPressed]
	and PAD_A | PAD_B | PAD_START
	ret z
	bit B_PAD_B, a
	jr z, .start_or_a
	ld a, $ff
	ldh [hCurScrollMenuItem], a
.start_or_a
	scf
	ret

SelectingBenchPokemonMenu:
	ldh a, [hKeysPressed]
	and PAD_SELECT
	ret z ; Select not pressed
	ld a, [wPlayAreaSelectAction]
	or a
	jr nz, .asm_5b76

	; get the energy cards attached to
	; selected Play Area Pokémon
	ldh a, [hCurScrollMenuItem]
	ld [wSelectedDuelSubMenuItem], a
	ld e, a
	ld a, [wExcludeArenaPokemon]
	add e
	ldh [hTempPlayAreaLocation_ff9d], a
	call CreateArenaOrBenchEnergyCardList
	jr c, .no_energy_cards
	ldh a, [hTempPlayAreaLocation_ff9d]
	ldtx de, EnergyCardsAttachedToPokemonText
	call DisplayAttachedEnergyMenu
	ld a, $01
	ld [wcbeb], a
	call HandleAttachedEnergyMenuInput
.no_energy_cards
	ld a, $03
	scf
	ret

.asm_5b76
	ld a, [wPlayAreaSelectAction]
	cp $02
	jr z, .return_carry
	xor a
	ld [wCurrentDuelMenuItem], a
.duel_main_scene
	call DrawDuelMainScene
	ldtx hl, SelectingBenchPokemonSubmenuHandCheckBackText
	call DrawWideTextBox_PrintTextNoDelay
	call .InitMenu
.loop_input
	call DoFrame
	ldh a, [hKeysPressed]
	and PAD_A
	jr nz, .a_pressed
	call .HandleInput
	call RefreshMenuCursor
	xor a
	call HandleSpecialDuelMainSceneHotkeys
	jr nc, .loop_input
	ldh a, [hKeysPressed]
	and PAD_SELECT
	jr z, .duel_main_scene
.back
	call HasAlivePokemonInBench
	ld a, $01
	ld [wPlayAreaSelectAction], a
.return_carry
	scf
	ret

.a_pressed
	ld a, [wCurrentDuelMenuItem]
	cp 2
	jr z, .back
	or a
	jr z, .check_hand
; examine
	call OpenDuelCheckMenu
	jr .duel_main_scene
.check_hand
	call OpenTurnHolderHandScreen_Simple
	jr .duel_main_scene

.HandleInput:
	ldh a, [hDPadHeld]
	bit B_PAD_B, a
	ret nz
	and PAD_RIGHT | PAD_LEFT
	ret z

	; right or left pressed
	ld b, a
	ld a, [wCurrentDuelMenuItem]
	bit B_PAD_LEFT, b
	jr z, .right_pressed
	dec a
	bit 7, a
	jr z, .got_menu_item
	ld a, 2
	jr .got_menu_item
.right_pressed
	inc a
	cp 3
	jr c, .got_menu_item
	xor a
.got_menu_item
	ld [wCurrentDuelMenuItem], a
	call EraseCursor
;	fallthrough

.InitMenu:
	ld a, [wCurrentDuelMenuItem]
	ld d, a
	add a
	add d
	add a
	add 2
	ld d, a
	ld e, 16
	lb bc, SYM_CURSOR_R, SYM_SPACE
	jp SetCursorParametersForTextBox
; 0x5bfd

SECTION "Bank 1@5c30", ROMX[$5c30], BANK[$1]

Func_5c30:
	xor a
	ld [wExcludeArenaPokemon], a
	ld a, [wDuelDisplayedScreen]
	cp PLAY_AREA_CARD_LIST
	ret z
	call ZeroObjectPositionsAndToggleOAMCopy
	call EmptyScreen
	call LoadDuelCardSymbolTiles
	call LoadDuelCheckPokemonScreenTiles
	ret

; for each turn holder's play area Pokemon card, print the name, level,
; face down stage card, color symbol, status symbol (if any), pluspower/defender
; symbols (if any), attached energies (if any), and HP bar.
; also print the play area locations (ACT/BPx indicators) for each of the six slots.
; return the value of wNumPlayAreaItems (as returned from PrintPlayAreaCardList) in a.
PrintPlayAreaCardList_EnableLCD:
	ld a, PLAY_AREA_CARD_LIST
	ld [wDuelDisplayedScreen], a
	call PrintPlayAreaCardList
	call EnableLCD
	ld a, [wNumPlayAreaItems]
	ret

; for each turn holder's play area Pokemon card, print the name, level,
; face down stage card, color symbol, status symbol (if any), pluspower/defender
; symbols (if any), attached energies (if any), and HP bar.
; also print the play area locations (ACT/BPx indicators) for each of the six slots.
PrintPlayAreaCardList:
	ld a, PLAY_AREA_CARD_LIST
	ld [wDuelDisplayedScreen], a
	ld de, wcbf5
	call SetListPointer2
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	ld c, a
	ld b, $00
.print_cards_info_loop
	; for each Pokemon card in play area, print its information (and location)
	push hl
	push bc
	ld a, b
	ld [wCurPlayAreaSlot], a
	ld a, b
	add a
	add b
	ld [wCurPlayAreaY], a
	ld a, b
	add DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call SetNextElementOfList2
	call PrintPlayAreaCardInformationAndLocation
	pop bc
	pop hl
	inc b
	dec c
	jr nz, .print_cards_info_loop
	push bc
.print_locations_loop
	; print all play area location indicators (even if there's no Pokemon card on it)
	ld a, b
	ld hl, wMaxNumPlayAreaPokemon
	cp [hl]
	jr nc, .locations_printed
	ld [wCurPlayAreaSlot], a
	add a
	add b
	ld [wCurPlayAreaY], a
	push bc
	call PrintPlayAreaCardLocation
	pop bc
	inc b
	jr .print_locations_loop
.locations_printed
	pop bc
	ld a, b
	ld [wNumPlayAreaItems], a
	ld a, [wExcludeArenaPokemon]
	or a
	ret z
	; if wExcludeArenaPokemon is set, decrement [wNumPlayAreaItems] and shift back wcbf5
	dec b
	ld a, b
	ld [wNumPlayAreaItems], a
	ld hl, wcbf5 + 1
	ld de, wcbf5
.shift_back_loop
	ld a, [hli]
	ld [de], a
	inc de
	dec b
	jr nz, .shift_back_loop
	ret

; print a turn holder's play area Pokemon card's name, level, face down stage card,
; color symbol, status symbol (if any), pluspower/defender symbols (if any),
; attached energies (if any), HP bar, and the play area location (ACT/BPx indicator)
; input:
   ; wCurPlayAreaSlot: PLAY_AREA_* of the card to display the information of
   ; wCurPlayAreaY: Y coordinate of where to print the card's information
; total space occupied is a rectangle of 20x3 tiles
PrintPlayAreaCardInformationAndLocation:
	ld a, [wCurPlayAreaSlot]
	add DUELVARS_ARENA_CARD
	get_turn_duelist_var
	cp -1
	ret z
	call PrintPlayAreaCardInformation
;	fallthrough

;  print a turn holder's play area Pokemon card's location (ACT/BPx indicator)
PrintPlayAreaCardLocation:
	ld de, PlayerPlayAreaLocationTileNumbers
	ldh a, [hWhoseTurn]
	cp PLAYER_TURN
	jr z, .opps_turn
	ld de, OpponentPlayAreaLocationTileNumbers
.opps_turn
	ld a, [wCurPlayAreaSlot]
	add a
	add a
	ld l, a
	ld h, $00
	add hl, de
	ld a, [wCurPlayAreaY]
	ld c, a
	ld b, 1
	ld a, [hli]
	ld e, a
	; call .WritePalAndTile 3 times
	; because each position is 3 tiles high
	call .WritePalAndTile
	call .WritePalAndTile
;	fallthrough

.WritePalAndTile:
	call BankswitchVRAM1
	ld a, e ; pal index
	call WriteByteToBGMap0
	call BankswitchVRAM0
	ld a, [hli] ; vtile
	call WriteByteToBGMap0
	inc c
	ret

PlayerPlayAreaLocationTileNumbers:
	db $2, $e0, $e1, $e2 ; ACT
	db $2, $e3, $e4, $e5 ; BP1
	db $2, $e3, $e4, $e6 ; BP2
	db $2, $e3, $e4, $e7 ; BP3
	db $2, $e3, $e4, $e8 ; BP4
	db $2, $e3, $e4, $e9 ; BP5

OpponentPlayAreaLocationTileNumbers:
	db $4, $ea, $eb, $ec ; ACT
	db $3, $ed, $ee, $ef ; BP1
	db $3, $ed, $ee, $f0 ; BP2
	db $3, $ed, $ee, $f1 ; BP3
	db $3, $ed, $ee, $f2 ; BP4
	db $3, $ed, $ee, $f3 ; BP5

; print a turn holder's play area Pokemon card's name, level, face down stage card,
; color symbol, status symbol (if any), pluspower/defender symbols (if any),
; attached energies (if any), and HP bar.
; input:
   ; wCurPlayAreaSlot: PLAY_AREA_* of the card to display the information of
   ; wCurPlayAreaY: Y coordinate of where to print the card's information
; total space occupied is a rectangle of 20x3 tiles
PrintPlayAreaCardInformation:
	; print name, level, color, stage, status, pluspower/defender
	call PrintPlayAreaCardHeader
	; print the symbols of the attached energies
	ld a, [wCurPlayAreaSlot]
	ld e, a
	ld a, [wCurPlayAreaY]
	inc a
	ld c, a
	ld b, 7
	call PrintPlayAreaCardAttachedEnergies
	ld a, [wCurPlayAreaY]
	inc a
	ld c, a
	ld b, 5
	ld a, SYM_E
	call WriteByteToBGMap0
	; print the HP bar
	inc c
	ld a, SYM_HP
	call WriteByteToBGMap0
	ld a, [wCurPlayAreaSlot]
	add DUELVARS_ARENA_CARD_HP
	get_turn_duelist_var
	or a
	jr z, .zero_hp
	ld e, a
	ld a, [wLoadedCard1HP]
	ld d, a
	call DrawHPBar
	ld a, [wCurPlayAreaY]
	inc a
	inc a
	ld c, a
	ld b, 7
	call BCCoordToBGMap0Address
	ld hl, wDefaultText
	ld b, 12
	call SafeCopyDataHLtoDE
	ret
.zero_hp
	; if fainted, print "Knock Out" in place of the HP bar
	ld a, [wCurPlayAreaY]
	inc a
	inc a
	ld e, a
	ld d, 7
	ldtx hl, KnockOutText
	call InitTextPrinting_ProcessTextFromID
	ret

; print a turn holder's play area Pokemon card's name, level, face down stage card,
; color symbol, status symbol (if any), and pluspower/defender symbols (if any).
; input:
   ; wCurPlayAreaSlot: PLAY_AREA_* of the card to display the information of
   ; wCurPlayAreaY: Y coordinate of where to print the card's information
PrintPlayAreaCardHeader:
	ld a, [wCurPlayAreaSlot]
	add DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call LoadCardDataToBuffer1_FromDeckIndex
	ld a, [wCurPlayAreaY]
	ld e, a
	ld d, 4
	call InitTextPrinting
	; copy the name to wDefaultText (max. 10 characters)
	; then call ProcessText with hl = wDefaultText
	ld hl, wLoadedCard1Name
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld de, wDefaultText
	push de
	ld a, 10 ; card name maximum length
	call CopyTextData_FromTextID
	pop hl
	call ProcessText

	; print the Pokemon's color and the level
	ld a, [wCurPlayAreaY]
	ld c, a
	ld b, 18
	ld a, [wCurPlayAreaSlot]
	call GetPlayAreaCardColor
	inc a
	call JPWriteByteToBGMap0
	ld b, 14
	ld a, SYM_Lv
	call WriteByteToBGMap0
	ld a, [wCurPlayAreaY]
	ld c, a
	ld b, 15
	ld a, [wLoadedCard1Level]
	call WriteTwoDigitNumberInTxSymbolFormat

	; print the 2x2 face down card image depending on the Pokemon's evolution stage
	ld a, [wCurPlayAreaSlot]
	add DUELVARS_ARENA_CARD_STAGE
	get_turn_duelist_var
	add a
	ld e, a
	ld d, $00
	ld hl, FaceDownCardTileNumbers
	add hl, de
	ld a, [hli] ; starting tile to fill the 2x2 rectangle with
	push hl
	push af
	lb hl, 1, 2
	lb bc, 2, 2
	ld a, [wCurPlayAreaY]
	ld e, a
	ld d, 2
	pop af
	call FillRectangle
	pop hl
	ld a, [wConsole]
	cp CONSOLE_CGB
	jr nz, .not_cgb
	; in cgb, we have to take care of coloring it too
	ld a, [hl]
	lb hl, 0, 0
	lb bc, 2, 2
	call BankswitchVRAM1
	call FillRectangle
	call BankswitchVRAM0

.not_cgb
	; print the status condition symbol if any (only for the arena Pokemon card)
	ld hl, wCurPlayAreaSlot
	ld a, [hli]
	or a
	jr nz, .skip_status
	ld c, [hl]
	inc c
	inc c
	ld b, 2
	ld a, DUELVARS_ARENA_CARD_STATUS
	get_turn_duelist_var
	call CheckPrintCnfSlpPrz
	inc b
	call CheckPrintPoisoned
	inc b
	call CheckPrintDoublePoisoned

.skip_status
	; finally check whether to print the Pluspower and/or Defender symbols
	ld a, [wCurPlayAreaSlot]
	add DUELVARS_ARENA_CARD_ATTACHED_PLUSPOWER
	get_turn_duelist_var
	or a
	jr z, .not_pluspower
	ld a, [wCurPlayAreaY]
	inc a
	ld c, a
	ld b, 15
	ld a, SYM_PLUSPOWER
	call WriteByteToBGMap0
	inc b
	ld a, [hl]
	add SYM_0
	call WriteByteToBGMap0
.not_pluspower
	ld a, [wCurPlayAreaSlot]
	add DUELVARS_ARENA_CARD_ATTACHED_DEFENDER
	get_turn_duelist_var
	or a
	jr z, .not_defender
	ld a, [wCurPlayAreaY]
	inc a
	ld c, a
	ld b, 17
	ld a, SYM_DEFENDER
	call WriteByteToBGMap0
	inc b
	ld a, [hl]
	add SYM_0
	call WriteByteToBGMap0

.not_defender
	ld a, [wCurPlayAreaSlot]
	add DUELVARS_ARENA_CARD_FOOD_COUNTERS
	get_turn_duelist_var
	or a
	jr z, .no_food_counters
	ld e, a
	ld a, [wCurPlayAreaY]
	inc a
	ld c, a
	ld b, 6
.loop_food_counters
	ld a, SYM_CHERRY
	call WriteByteToBGMap0
	inc c
	dec e
	jr nz, .loop_food_counters
.no_food_counters
	ret

FaceDownCardTileNumbers:
; starting tile number, cgb palette (grey, yellow/red, green/blue, pink/orange)
	db $d0, $03 ; basic
	db $d4, $03 ; stage 1
	db $d8, $02 ; stage 2
	db $dc, $02 ; stage 2 special

CheckPrintPoisoned:
	push af
	and POISONED
	jr z, .print
.poison
	ld a, SYM_POISONED
.print
	call WriteByteToBGMap0
	pop af
	ret

CheckPrintDoublePoisoned:
	push af
	and DOUBLE_POISONED & (POISONED ^ $ff)
	jr nz, CheckPrintPoisoned.poison ; double poisoned (print SYM_POISONED)
	jr CheckPrintPoisoned.print ; not double poisoned (print SYM_SPACE)

; given a card's status in a, print the Confusion, Sleep, or Paralysis symbol at bc
; for each of those status that is active
CheckPrintCnfSlpPrz:
	push af
	push hl
	push de
	and CNF_SLP_PRZ
	ld e, a
	ld d, $00
	ld hl, .status_symbols
	add hl, de
	ld a, [hl]
	call WriteByteToBGMap0
	pop de
	pop hl
	pop af
	ret

.status_symbols
	;  NO_STATUS, CONFUSED,     ASLEEP,     PARALYZED
	db SYM_SPACE, SYM_CONFUSED, SYM_ASLEEP, SYM_PARALYZED

; prints cherry symbols on the arena card
; if it has any Food Counters
; if a = 1, prints them left to right
; if a = -1, print them right to left
CheckPrintFoodCounters:
	push af
	ld a, DUELVARS_ARENA_CARD_FOOD_COUNTERS
	get_turn_duelist_var
	or a
	jr z, .done
	ld e, a
.loop_counters
	ld a, SYM_CHERRY
	call WriteByteToBGMap0
	pop af
	push af
	add c
	ld c, a
	dec e
	jr nz, .loop_counters
.done
	pop af
	ret

; print the symbols of the attached energies of a turn holder's play area card
; input:
; - e: PLAY_AREA_*
; - b, c: where to print (x, y)
; - wAttachedEnergies and wTotalAttachedEnergies
PrintPlayAreaCardAttachedEnergies:
	push bc
	call GetPlayAreaCardAttachedEnergies
	ld hl, wDefaultText
	push hl
	ld c, 8
	xor a
.empty_loop
	ld [hli], a
	dec c
	jr nz, .empty_loop
	pop hl
	ld a, [wAttachedEnergies + RAINBOW]
	inc a
	ld c, a
	jr .next_rainbow_energy
.loop_rainbow_energies
	ld [hl], SYM_RAINBOW
	inc hl
.next_rainbow_energy
	dec c
	jr nz, .loop_rainbow_energies

	ld de, wAttachedEnergies
	lb bc, SYM_FIRE, NUM_TYPES - 1
.next_color
	ld a, [de] ; energy count of current color
	inc de
	inc a
	jr .check_amount
.has_energy
	ld [hl], b
	inc hl
.check_amount
	dec a
	jr nz, .has_energy
	inc b
	dec c
	jr nz, .next_color
	ld a, [wTotalAttachedEnergies]
	cp 9
	jr c, .place_tiles
	ld a, SYM_PLUS
	ld [wDefaultText + 7], a
.place_tiles
	pop bc
	call BCCoordToBGMap0Address
	ld hl, wDefaultText
	ld b, NUM_TYPES
	call SafeCopyDataHLtoDE
	ret
; 0x5efe

SECTION "Bank 1@5f0c", ROMX[$5f0c], BANK[$1]

DisplayPlayAreaScreenToUsePkmnPower:
	xor a
	ld [wSelectedDuelSubMenuItem], a

.asm_6435
	call .DrawScreen
	ld hl, PlayAreaScreenMenuParameters_ActivePokemonIncluded
	ld a, [wSelectedDuelSubMenuItem]
	call InitializeMenuParameters
	ld a, [wNumPlayAreaItems]
	ld [wNumScrollMenuItems], a
.asm_6447
	call DoFrame
	call HandleMenuInput
	ldh [hTempPlayAreaLocation_ff9d], a
	ld [wHUDEnergyAndHPBarsX], a
	jr nc, .asm_6447
	cp $ff
	jr z, .asm_649b
	ld [wSelectedDuelSubMenuItem], a
	ldh a, [hKeysPressed]
	and PAD_START
	jr nz, .asm_649d
	ldh a, [hCurScrollMenuItem]
	add a
	ld e, a
	ld d, $00
	ld hl, wDuelTempList + 1
	add hl, de
	ld a, [hld]
	cp $04
	jr nz, .asm_6447
	ld a, [hl]
	ldh [hTempCardIndex_ff98], a
	ld d, a
	ld e, FIRST_ATTACK_OR_PKMN_POWER
	call CopyAttackDataAndDamage_FromDeckIndex
	ld a, EFFECTCMDTYPE_INITIAL_EFFECT_1
	call TryExecuteEffectCommandFunction
	jr nc, .asm_648c
	ldtx hl, PokemonPowerSelectNotRequiredText
	farcall DisplayUsePokemonPowerScreen
	call WaitForWideTextBoxInput
	jp .asm_6435
.asm_648c
	ldtx hl, UseThisPokemonPowerPromptText
	farcall DisplayUsePokemonPowerScreen
	call YesOrNoMenu
	jp c, .asm_6435
	ldh a, [hTempCardIndex_ff98]
	ldh [hTemp_ffa0], a
	or a
	ret
.asm_649b
	scf
	ret
.asm_649d
	ldh a, [hCurScrollMenuItem]
	add DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call GetCardIDFromDeckIndex
	call LoadCardDataToBuffer1_FromCardID
	call OpenCardPage_FromCheckPlayArea
	jp .asm_6435

.DrawScreen:
	call ZeroObjectPositionsAndToggleOAMCopy
	call EmptyScreen
	call LoadDuelCardSymbolTiles
	call LoadDuelCheckPokemonScreenTiles
	ld de, wDuelTempList
	call SetListPointer2
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	ld c, a
	ld b, $00
.asm_64ca
	push hl
	push bc
	ld a, b
	ld [wHUDEnergyAndHPBarsX], a
	ld a, b
	add a
	add b
	ld [wCurPlayAreaY], a
	ld a, b
	add DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call SetNextElementOfList2
	call PrintPlayAreaCardHeader
	call PrintPlayAreaCardLocation
	call .PrintCardNameIfHasPkmnPower
	ld a, [wLoadedCard1Atk1Category]
	call SetNextElementOfList2
	pop bc
	pop hl
	inc b
	dec c
	jr nz, .asm_64ca
	ld a, b
	ld [wNumPlayAreaItems], a
	call EnableLCD
	ret

.PrintCardNameIfHasPkmnPower:
	ld a, [wLoadedCard1Atk1Category]
	cp POKEMON_POWER
	ret nz
	ld a, [wCurPlayAreaY]
	inc a
	ld e, a
	ld d, 4
	ld hl, wLoadedCard1Atk1Name
	call InitTextPrinting_ProcessTextFromPointerToID
	ret

; print the description of an attack, a Pokemon power, or a trainer or energy card
; x,y coordinates of where to start printing the text are given at de
; don't separate lines of text
PrintAttackOrCardDescription:
	call SetNoLineSeparation
	ld a, [hli]
	ld h, [hl]
	ld l, a
	call CountLinesOfTextFromID
	cp 7
	jr c, .print
	dec e ; move one line up to fit (assumes it will be enough)
.print
	ld a, 19
	call InitTextPrintingInTextbox
	call ProcessTextFromID
	call SetOneLineSeparation
	ret

; moves the cards loaded by deck index at hTempRetreatCostCards to the discard pile
DiscardRetreatCostCards:
	ld hl, hTempRetreatCostCards
.discard_loop
	ld a, [hli]
	cp $ff
	ret z
	call PutCardInDiscardPile
	jr .discard_loop

; moves the discard pile cards that were loaded to hTempRetreatCostCards back to the active Pokemon.
; this exists because they will be discarded again during the call to AttemptRetreat, so
; it prevents the energy cards from being discarded twice.
ReturnRetreatCostCardsToArena:
	ld hl, hTempRetreatCostCards
.loop
	ld a, [hli]
	cp $ff
	ret z
	push hl
	call MoveDiscardPileCardToHand
	call AddCardToHand
	ld e, PLAY_AREA_ARENA
	call PutHandCardInPlayArea
	pop hl
	jr .loop

; discard retreat cost energy cards and attempt retreat of the arena card.
; return carry if unable to retreat this turn due to unsuccessful confusion check
; if successful, the retreated card is replaced with a bench Pokemon card
AttemptRetreat:
	ld hl, hTempRetreatCostCards
.discard_loop
	ld a, [hli]
	cp $ff
	jr z, .asm_6033
	call Func_0ffa
	jr .discard_loop

.asm_6033
	ldh a, [hTemp_ffa0]
	and CNF_SLP_PRZ
	cp CONFUSED
	jr nz, .success
	ldtx de, ConfusionCheckRetreatText
	call TossCoin
	jr c, .success
	ld a, 1
	ld [wGotHeadsFromConfusionCheckDuringRetreat], a
	scf
	ret
.success
	xor a
	ld [wGotHeadsFromConfusionCheckDuringRetreat], a

	call HandleRetreatPkmnPowers
	ld a, DUELVARS_ARENA_CARD_HP
	get_turn_duelist_var

	push af
	ldh a, [hTempPlayAreaLocation_ffa1]
	ld e, a
	call SwapArenaWithBenchPokemon
	call Func_6518
	pop af
	or a
	ret

WriteTwoByteNumberInTxSymbolFormat:
	push de
	push bc
	ld l, a
	ld h, $00
	call TwoByteNumberToTxSymbol_TrimLeadingZeros_Bank1
	pop bc
	push bc
	call BCCoordToBGMap0Address
	ld hl, wStringBuffer + 2
	ld b, 3
	call SafeCopyDataHLtoDE
	pop bc
	pop de
	ret

Func_6079:
	push de
	push bc
	call TwoByteNumberToTxSymbol_TrimLeadingZeros_Bank1
	pop bc
	push bc
	call BCCoordToBGMap0Address
	ld hl, wStringBuffer
	ld b, 5
	call SafeCopyDataHLtoDE
	pop bc
	pop de
	ret

; given a number between 0-99 in a, converts it to TX_SYMBOL format,
; and writes it to wStringBuffer + 3 and to the BGMap0 address at bc.
; if the number is between 0-9, the first digit is replaced with SYM_SPACE.
WriteTwoDigitNumberInTxSymbolFormat:
	push hl
	push de
	push bc
	ld l, a
	ld h, $00
	call TwoByteNumberToTxSymbol_TrimLeadingZeros_Bank1
	pop bc
	push bc
	call BCCoordToBGMap0Address
	ld hl, wStringBuffer + 3
	ld b, 2
	call SafeCopyDataHLtoDE
	pop bc
	pop de
	pop hl
	ret

; convert the number at hl to TX_SYMBOL text format and write it to wStringBuffer
; replace leading zeros with SYM_SPACE
TwoByteNumberToTxSymbol_TrimLeadingZeros_Bank1:
	ld de, wStringBuffer
	ld bc, -10000
	call .get_digit
	ld bc, -1000
	call .get_digit
	ld bc, -100
	call .get_digit
	ld bc, -10
	call .get_digit
	ld bc, -1
	call .get_digit
	xor a
	ld [de], a
	ld hl, wStringBuffer
	ld b, 4
.digit_loop
	ld a, [hl]
	cp SYM_0
	jr nz, .done ; jump if not zero
	ld [hl], SYM_SPACE ; trim leading zero
	inc hl
	dec b
	jr nz, .digit_loop
.done
	ret

.get_digit
	ld a, SYM_0 - 1
.subtract_loop
	inc a
	add hl, bc
	jr c, .subtract_loop
	ld [de], a
	inc de
	ld a, l
	sub c
	ld l, a
	ld a, h
	sbc b
	ld h, a
	ret

; input d, e: max. HP, current HP
DrawHPBar:
	ld a, MAX_HP
	ld c, SYM_SPACE
	call .fill_hp_bar ; empty bar
	ld a, d
	ld c, SYM_HP_OK
	call .fill_hp_bar ; fill (max. HP) with HP counters
	ld a, d
	sub e
	ld c, SYM_HP_NOK
; fill (max. HP - current HP) with damaged HP counters
.fill_hp_bar
	or a
	ret z
	ld hl, wDefaultText
	ld b, HP_BAR_LENGTH
.tile_loop
	ld [hl], c
	inc hl
	dec b
	ret z
	sub MAX_HP / HP_BAR_LENGTH
	jr nz, .tile_loop
	ret

; loads a player deck (sDeck*Cards) from SRAM to wPlayerDeck
; sCurrentlySelectedDeck determines which sDeck*Cards source (0-3)
LoadPlayerDeck:
	call EnableSRAM
	ld a, [sCurrentlySelectedDeck]
	ld l, a
	ld h, DECK_COMPRESSED_STRUCT_SIZE
	call HtimesL
	ld de, sDeck1Cards
	add hl, de
	ld e, l
	ld d, h
	ld hl, wPlayerDeck
	call DecompressSRAMDeck
	call DisableSRAM
	ret

; returns carry if wSkipDelayAllowed is non-0 and B is being held in order to branch
; out of the caller's wait frames loop. probably only used for debugging.
CheckSkipDelayAllowed:
	ld a, [wSkipDelayAllowed]
	or a
	ret z
	ldh a, [hKeysHeld]
	and PAD_B
	ret z
	scf
	ret

; handles the key shortcuts to access some duel functions
; while inside the Duel Main scene in some situations
; (while waiting for Link Opponent's turn & when
; selecting a bench Pokémon, and choosing 'Examine')
; hotkeys:
; - Start     = Arena's card page
; - Select    = if a == 0: In Play Area
;               otherwise: In Play Area then both Play Areas
; - B + down  = player's Play Area
; - B + left  = player's Discard Pile
; - B + up    = opponent's Play Area
; - B + right = opponent's Discard Pile
HandleSpecialDuelMainSceneHotkeys:
	ld [wDuelMainSceneSelectHotkeyAction], a
	ldh a, [hKeysPressed]
	bit B_PAD_START, a
	jr nz, .start_pressed
	bit B_PAD_SELECT, a
	jr nz, .select_pressed
	ldh a, [hKeysHeld]
	and PAD_B
	ret z ; exit if no B btn
	ldh a, [hKeysPressed]
	bit B_PAD_DOWN, a
	jr nz, .down_pressed
	bit B_PAD_LEFT, a
	jr nz, .left_pressed
	bit B_PAD_UP, a
	jr nz, .up_pressed
	bit B_PAD_RIGHT, a
	jr nz, .right_pressed
	or a
	ret
.start_pressed
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	cp -1
	jr z, .return_carry
	call GetCardIDFromDeckIndex
	call LoadCardDataToBuffer1_FromCardID
	ld hl, wCurPlayAreaSlot
	xor a
	ld [hli], a
	ld [hl], a ; wCurPlayAreaY
	call OpenCardPage_FromCheckPlayArea
.return_carry
	scf
	ret
.select_pressed
	ld a, [wDuelMainSceneSelectHotkeyAction]
	or a
	jr nz, .both_duelist_play_areas
	call OpenInPlayAreaScreen_FromSelectButton
	jr .return_carry
.both_duelist_play_areas
	call OpenVariousPlayAreaScreens_FromSelectPresses
	jr .return_carry
.down_pressed
	call OpenTurnHolderPlayAreaScreen
	jr .return_carry
.left_pressed
	call OpenTurnHolderDiscardPileScreen
	jr .return_carry
.up_pressed
	call OpenNonTurnHolderPlayAreaScreen
	jr .return_carry
.right_pressed
	call OpenNonTurnHolderDiscardPileScreen
	jr .return_carry

; a = PLAY_AREA_* constant
LoadPlayAreaCardID_ToTempTurnDuelistCardID::
	ld hl, wTempTurnDuelistCardID
	ld [wccd8], a
	jr LoadPlayAreaCardID

; a = PLAY_AREA_* constant
LoadPlayAreaCardID_ToTempNonTurnDuelistCardID::
	ld hl, wTempNonTurnDuelistCardID
	ld [wccd9], a
;	fallthrough

LoadPlayAreaCardID:
	push de
	push hl
	add DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call GetCardIDFromDeckIndex
	pop hl
	ld [hl], e
	inc hl
	ld [hl], d
	pop de
	ret

; when playing a Pokemon card, initializes some variables according to the
; card played, and checks if the played card has Pokemon Power to show it to
; the player, and possibly to use it if it triggers when the card is played.
ProcessPlayedPokemonCard:
	ldh a, [hTempCardIndex_ff98]
	ldh [hTempCardIndex_ff9f], a
	ldh a, [hTempPlayAreaLocation_ff9d]
	ldh [hTemp_ffa0], a
	ld a, OPPACTION_UNK_18
	call SetOppAction_SerialSendDuelData
	call .Process
	ret c
	ld a, EFFECTCMDTYPE_REQUIRE_SELECTION
	call TryExecuteEffectCommandFunction
	ld a, OPPACTION_UNK_19
	call SetOppAction_SerialSendDuelData
	call .TriggerPkmnPower
	ret

.Process:
	ldh a, [hTempCardIndex_ff9f]
	ldh [hTempCardIndex_ff98], a
	call ClearChangedTypesIfMuk
	ldh a, [hTempCardIndex_ff9f]
	ld d, a
	ld e, FIRST_ATTACK_OR_PKMN_POWER
	call CopyAttackDataAndDamage_FromDeckIndex
	call ClearTwoTurnDuelVars
	ldh a, [hTempCardIndex_ff9f]
	call GetCardIDFromDeckIndex
	ld hl, wTempTurnDuelistCardID
	ld [hl], e
	inc hl
	ld [hl], d
	ld a, [wLoadedAttackCategory]
	cp POKEMON_POWER
	jr nz, .not_using_pkmn_power

	; has Pkmn Power
	ldh a, [hTempCardIndex_ff98]
	call LoadCardDataToBuffer1_FromDeckIndex
	ld hl, wLoadedCard1Name
	ld a, [hli]
	ld h, [hl]
	ld l, a
	call LoadTxRam2
	ldtx hl, HavePokemonPowerText
	farcall DisplayUsePokemonPowerScreen
	call WaitForWideTextBoxInput
	ld hl, wLoadedCard1ID
	cphl MUK
	jr z, .use_pokemon_power
	ldh a, [hTempPlayAreaLocation_ff9d]
	call CheckIsIncapableOfUsingPkmnPower
	jr nc, .use_pokemon_power
	ldtx hl, HavePokemonPowerButUnableDueToToxicGasText
	dec a
	jr nz, .asm_622b
	ldtx hl, HavePokemonPowerButUnableDueToGoopGasAttackText
.asm_622b
	call DrawWideTextBox_WaitForInput

.not_using_pkmn_power
	xor a
	ld [wcd18], a
	scf
	ret

.use_pokemon_power
	ld hl, wLoadedAttackEffectCommands
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, EFFECTCMDTYPE_PKMN_POWER_TRIGGER
	call CheckMatchingCommand
	jr c, .not_using_pkmn_power
	call DrawDuelMainScene
	ldh a, [hTempCardIndex_ff9f]
	call LoadCardDataToBuffer1_FromDeckIndex
	ld de, wLoadedCard1Name
	ld hl, wTxRam2
	ld a, [de]
	inc de
	ld [hli], a
	ld a, [de]
	ld [hli], a
	ld de, wLoadedAttackName
	ld a, [de]
	inc de
	ld [hli], a
	ld a, [de]
	ld [hl], a
	ldtx hl, UsePokemonPowerText
	call DrawWideTextBox_WaitForInput
	ld a, $01
	ld [wcd18], a
	or a
	ret

.TriggerPkmnPower:
	farcall ResetAttackAnimationIsPlaying
	ld a, EFFECTCMDTYPE_PKMN_POWER_TRIGGER
	call TryExecuteEffectCommandFunction
	ret

; apply and/or refresh status conditions and other events that trigger between turns
HandleBetweenTurnsEvents:
	call IsArenaPokemonAsleepOrPoisoned
	jr c, .something_to_handle
	cp PARALYZED
	jr z, .something_to_handle
	call SwapTurn
	call IsArenaPokemonAsleepOrPoisoned
	call SwapTurn
	jr c, .something_to_handle
	call DiscardAttachedPluspowers
	call SwapTurn
	call DiscardAttachedDefenders
	call SwapTurn
	ret

.something_to_handle
	; either:
	; 1. turn holder's arena Pokemon is paralyzed, asleep, poisoned or double poisoned
	; 2. non-turn holder's arena Pokemon is asleep, poisoned or double poisoned
	call ResetAnimationQueue
	call ZeroObjectPositionsAndToggleOAMCopy
	call EmptyScreen
	ld a, BOXMSG_BETWEEN_TURNS
	call DrawDuelBoxMessage
	ldtx hl, BetweenTurnsText
	call DrawWideTextBox_WaitForInput

	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call GetCardIDFromDeckIndex
	ld a, e
	ld [wTempNonTurnDuelistCardID + 0], a
	ld a, d
	ld [wTempNonTurnDuelistCardID + 1], a
	ld l, DUELVARS_ARENA_CARD_STATUS
	ld a, [hl]
	or a
	jr z, .discard_pluspower
	; has status condition
	call HandlePoisonDamage
	jr c, .discard_pluspower
	call HandleSleepCheck
	ld a, [hl]
	and CNF_SLP_PRZ
	cp PARALYZED
	jr nz, .discard_pluspower
	; heal paralysis
	ld a, DOUBLE_POISONED
	and [hl]
	ld [hl], a
	call RedrawTurnDuelistsMainSceneOrDuelHUD
	ldtx hl, IsCuredOfParalysisText
	call PrintCardNameFromCardIDInTextBox
	ld a, DUEL_ANIM_HEAL
	call PlayBetweenTurnsAnimation
	call WaitForWideTextBoxInput

.discard_pluspower
	call DiscardAttachedPluspowers
	call SwapTurn
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call GetCardIDFromDeckIndex
	ld a, e
	ld [wTempNonTurnDuelistCardID + 0], a
	ld a, d
	ld [wTempNonTurnDuelistCardID + 1], a
	ld l, DUELVARS_ARENA_CARD_STATUS
	ld a, [hl]
	or a
	jr z, .asm_6c3a
	call HandlePoisonDamage
	jr c, .asm_6c3a
	call HandleSleepCheck
.asm_6c3a
	call DiscardAttachedDefenders
	call SwapTurn
	call HandleBetweenTurnKnockOuts
	ret

; discard any PLUSPOWER attached to the turn holder's arena and/or bench Pokemon
DiscardAttachedPluspowers:
	ld a, DUELVARS_ARENA_CARD_ATTACHED_PLUSPOWER
	get_turn_duelist_var
	ld e, MAX_PLAY_AREA_POKEMON
	xor a
.unattach_pluspower_loop
	ld [hli], a
	dec e
	jr nz, .unattach_pluspower_loop
	ld de, PLUSPOWER
	jp MoveCardToDiscardPileIfInArena

; discard any DEFENDER attached to the turn holder's arena and/or bench Pokemon
DiscardAttachedDefenders:
	ld a, DUELVARS_ARENA_CARD_ATTACHED_DEFENDER
	get_turn_duelist_var
	ld e, MAX_PLAY_AREA_POKEMON
	xor a
.unattach_defender_loop
	ld [hli], a
	dec e
	jr nz, .unattach_defender_loop
	ld de, DEFENDER
	jp MoveCardToDiscardPileIfInArena

; return carry if the turn holder's arena Pokemon card is asleep, poisoned, or double poisoned.
; also, if confused, paralyzed, or asleep, return the status condition in a.
IsArenaPokemonAsleepOrPoisoned:
	ld a, DUELVARS_ARENA_CARD_STATUS
	get_turn_duelist_var
	or a
	ret z
	; note that POISONED | DOUBLE_POISONED is the same as just DOUBLE_POISONED ($c0)
	; poison status masking is normally done with PSN_DBLPSN ($f0)
	and POISONED | DOUBLE_POISONED
	jr nz, .set_carry
	ld a, [hl]
	and CNF_SLP_PRZ
	cp ASLEEP
	jr z, .set_carry
	or a
	ret
.set_carry
	scf
	ret

RedrawTurnDuelistsMainSceneOrDuelHUD:
	ld a, [wDuelDisplayedScreen]
	cp DUEL_MAIN_SCENE
	jr z, RedrawTurnDuelistsDuelHUD
	ld hl, wWhoseTurn
	ldh a, [hWhoseTurn]
	cp [hl]
	jp z, DrawDuelMainScene
	call SwapTurn
	call DrawDuelMainScene
	call SwapTurn
	ret

RedrawTurnDuelistsDuelHUD:
	ld hl, wWhoseTurn
	ldh a, [hWhoseTurn]
	cp [hl]
	jp z, DrawDuelHUDs
	call SwapTurn
	call DrawDuelHUDs
	call SwapTurn
	ret

; input:
;	a = animation ID
PlayBetweenTurnsAnimation:
	push af
	ld a, [wDuelType]
	or a
	jr nz, .store_duelist_turn
	ld a, [wWhoseTurn]
	cp PLAYER_TURN
	jr z, .store_duelist_turn
	call SwapTurn
	ldh a, [hWhoseTurn]
	ld [wDuelAnimDuelistSide], a
	call SwapTurn
	jr .asm_6ccb

.store_duelist_turn
	ldh a, [hWhoseTurn]
	ld [wDuelAnimDuelistSide], a

.asm_6ccb
	xor a
	ld [wDuelAnimLocationParam], a
	ld a, DUEL_ANIM_SCREEN_MAIN_SCENE
	ld [wDuelAnimationScreen], a
	pop af

; play animation
	call PlayDuelAnimation
.loop_anim
	call DoFrame
	call CheckAnyAnimationPlaying
	jr c, .loop_anim
	call RedrawTurnDuelistsDuelHUD
	ret

; prints the name of the card at wTempNonTurnDuelistCardID in a text box
PrintCardNameFromCardIDInTextBox:
	push hl
	ld hl, wTempNonTurnDuelistCardID
	ld e, [hl]
	inc hl
	ld d, [hl]
	call LoadCardDataToBuffer1_FromCardID
	ld hl, wLoadedCard1Name
	ld a, [hli]
	ld h, [hl]
	ld l, a
	call LoadTxRam2
	pop hl
	call DrawWideTextBox_PrintText
	ret

; handles the sleep check for the NonTurn Duelist
; heals sleep status if coin is heads, else
; it plays sleeping animation
HandleSleepCheck:
	ld a, [hl]
	and CNF_SLP_PRZ
	cp ASLEEP
	ret nz ; quit if not asleep

	push hl
	ld hl, wTempNonTurnDuelistCardID
	ld e, [hl]
	inc hl
	ld d, [hl]
	call LoadCardDataToBuffer1_FromCardID
	ld a, 18
	call CopyCardNameAndLevel
	ld [hl], TX_END
	ld hl, wTxRam2
	xor a
	ld [hli], a
	ld [hl], a
	ldtx de, PokemonsSleepCheckText
	call TossCoin
	ld a, DUEL_ANIM_SLEEP
	ldtx hl, IsStillAsleepText
	jr nc, .tails

; coin toss was heads, cure sleep status
	pop hl
	push hl
	ld a, DOUBLE_POISONED
	and [hl]
	ld [hl], a
	ld a, DUEL_ANIM_HEAL
	ldtx hl, IsCuredOfSleepText

.tails
	push af
	push hl
	call RedrawTurnDuelistsMainSceneOrDuelHUD
	pop hl
	call PrintCardNameFromCardIDInTextBox
	pop af
	call PlayBetweenTurnsAnimation
	pop hl
	call WaitForWideTextBoxInput
	ret

HandlePoisonDamage:
	or a
	bit POISONED_F , [hl]
	ret z ; quit if not poisoned

; load damage and text according to normal/double poison
	push hl
	bit DOUBLE_POISONED_F, [hl]
	ld a, DBLPSN_DAMAGE
	ldtx hl, ReceivedXDamageDueToToxicText
	jr nz, .got_damage
	call GetPoisonDamage
	ldtx hl, ReceivedXDamageDueToPoisonText

.got_damage
	push af
	push hl
	ld l, a
	ld [wDuelAnimDamage + 0], a
	xor a
	ld h, a
	ld [wDuelAnimDamage + 1], a
	call LoadTxRam3
	call RedrawTurnDuelistsMainSceneOrDuelHUD
	pop hl
	call PrintCardNameFromCardIDInTextBox

; play animation
	ld a, DUEL_ANIM_POISON
	call PlayBetweenTurnsAnimation
	pop af

; deal poison damage
	ld e, a
	ld d, $00
	ld a, DUELVARS_ARENA_CARD_HP
	get_turn_duelist_var
	call SubtractHP
	push hl
	ld a, $8d
	call PlayBetweenTurnsAnimation
	pop hl

	call PrintKnockedOutIfHLZero
	push af
	call WaitForWideTextBoxInput
	pop af
	pop hl
	ret

; move the turn holder's card with ID at de to the discard pile
; if it's currently in the arena.
MoveCardToDiscardPileIfInArena:
	ld c, e
	ld b, d
	ld l, DUELVARS_CARD_LOCATIONS
.next_card
	ld a, [hl]
	and CARD_LOCATION_ARENA
	jr z, .skip ; jump if card not in arena
	ld a, l
	call GetCardIDFromDeckIndex
	ld a, c
	cp e
	jr nz, .skip
	ld a, b
	cp d
	jr nz, .skip ; jump if not the card id provided in de
	ld a, l
	push bc
	call Func_0ffa
	pop bc
.skip
	inc l
	ld a, l
	cp DECK_SIZE
	jr c, .next_card
	ret
; 0x6470

SECTION "Bank 1@6518", ROMX[$6518], BANK[$1]

Func_6518::
	call Func_7234
;	fallthrough

HandleBetweenTurnKnockOuts:
	call .ClearDamageReductionSubstatus2OfKnockedOutPokemon
	xor a
	ld [wDuelFinishParam], a
	call SwapTurn
	call .Func_6ef6
	call SwapTurn
	ld a, [wDuelFinishParam]
	or a
	jr z, .asm_6e86
	call CheckIfTurnDuelistPlayAreaPokemonAreAllKnockedOut
	jr c, .asm_6e86
	call CountKnockedOutPokemon
	ld c, a
	call SwapTurn
	call CountPrizes
	call SwapTurn
	dec a
	cp c
	jr c, .asm_6e86
	ld a, c
	call SwapTurn
	call TakeAPrizes
	call SwapTurn
	ld a, TURN_PLAYER_WON
	jr .set_duel_finished
.asm_6e86
	call .Func_6ef6
	ld a, [wDuelFinishParam]
	cp TRUE
	jr nz, .asm_6e9f
	call SwapTurn
	call CheckIfTurnDuelistPlayAreaPokemonAreAllKnockedOut
	call SwapTurn
	jr c, .asm_6e9f
	ld a, TURN_PLAYER_LOST
	jr .set_duel_finished
.asm_6e9f
	call SwapTurn
	call .Func_6eff
	call SwapTurn
	call .Func_6eff
	ld a, [wDuelFinishParam]
	or a
	jr nz, .asm_6ec4
	xor a
.asm_6eb2
	push af
	call MoveAllTurnHolderKnockedOutPokemonToDiscardPile
	call SwapTurn
	call MoveAllTurnHolderKnockedOutPokemonToDiscardPile
	call SwapTurn
	call ShiftAllPokemonToFirstPlayAreaSlots
	call Func_7943
	pop af
	ret

.asm_6ec4
	ld e, a
	ld d, $00
	ld hl, .Data_6ed2
	add hl, de
	ld a, [hl]
.set_duel_finished
	ld [wDuelFinished], a
	scf
	jr .asm_6eb2

.Data_6ed2:
	db DUEL_NOT_FINISHED, TURN_PLAYER_LOST, TURN_PLAYER_WON,  TURN_PLAYER_TIED
	db TURN_PLAYER_LOST,  TURN_PLAYER_LOST, TURN_PLAYER_TIED, TURN_PLAYER_LOST
	db TURN_PLAYER_WON,   TURN_PLAYER_TIED, TURN_PLAYER_WON,  TURN_PLAYER_WON
	db TURN_PLAYER_TIED,  TURN_PLAYER_LOST, TURN_PLAYER_WON,  TURN_PLAYER_TIED

; clears SUBSTATUS2_REDUCE_BY_20, SUBSTATUS2_POUNCE, SUBSTATUS2_GROWL,
; SUBSTATUS2_TAIL_WAG, and SUBSTATUS2_LEER for each arena Pokemon with 0 HP
.ClearDamageReductionSubstatus2OfKnockedOutPokemon:
	call SwapTurn
	call .clear
	call SwapTurn
.clear
	ld a, DUELVARS_ARENA_CARD_HP
	call GetNonTurnDuelistVariable
	or a
	ret nz
	call ClearDamageReductionSubstatus2
	ret

.Func_6ef6:
	call Func_6fa5
	ld hl, wDuelFinishParam
	rl [hl]
	ret

.Func_6eff:
	call ReplaceKnockedOutPokemon
	ld hl, wDuelFinishParam
	rl [hl]
	ret

; for each Pokemon in the turn holder's play area (arena and bench),
; move that card to the discard pile if its HP is 0
MoveAllTurnHolderKnockedOutPokemonToDiscardPile:
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	ld d, a
	ld l, DUELVARS_ARENA_CARD_HP
	ld e, PLAY_AREA_ARENA
.loop
	ld a, [hl]
	or a
	jr nz, .next
	push hl
	push de
	call Func_12fc
	pop de
	pop hl
.next
	inc hl
	inc e
	dec d
	jr nz, .loop
	ret

; have the turn holder replace the arena Pokemon card when it's been knocked out.
; if there are no Pokemon cards in the turn holder's bench, return carry.
ReplaceKnockedOutPokemon:
	ld a, DUELVARS_ARENA_CARD_HP
	get_turn_duelist_var
	or a
	ret nz
	call FinishQueuedAnimations
	call ClearAllStatusConditions
	call HasAlivePokemonInBench
	jr nc, .can_replace_pokemon

; if we made it here, the duelist can't replace the knocked out Pokemon
	call DrawDuelMainScene
	ldtx hl, NoPokemonInPlayAreaText
	call DrawWideTextBox_WaitForInput
	call ExchangeRNG
	scf
	ret

.can_replace_pokemon
	ld a, DUELVARS_DUELIST_TYPE
	get_turn_duelist_var
	cp DUELIST_TYPE_PLAYER
	jr nz, .opponent

; prompt the player to replace the knocked out Pokemon with one from bench
	call DrawDuelMainScene
	ldtx hl, SelectPokemonToPlaceInTheArenaText
	call DrawWideTextBox_WaitForInput
	ld a, $01
	ld [wPlayAreaSelectAction], a
	ld a, PRACTICEDUEL_PLAY_STARYU_FROM_BENCH
	call DoPracticeDuelAction
.select_pokemon
	call OpenPlayAreaScreenForSelection
	jr c, .select_pokemon
	ldh a, [hTempPlayAreaLocation_ff9d]
	call SerialSend8Bytes

; replace the arena Pokemon with the one at location [hTempPlayAreaLocation_ff9d]
.replace_pokemon
	ld a, PRACTICEDUEL_REPLACE_KNOCKED_OUT_POKEMON
	call DoPracticeDuelAction
	jr c, .select_pokemon
	ldh a, [hTempPlayAreaLocation_ff9d]
	ld d, a
	ld e, PLAY_AREA_ARENA
	call SwapPlayAreaPokemon
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	ldtx hl, DuelistPlacedACardInArenaText
	call DisplayCardDetailScreen
	call ExchangeRNG
	or a
	ret

; the AI opponent replaces the knocked out Pokemon with one from bench
.opponent
	cp DUELIST_TYPE_LINK_OPP
	jr z, .link_opponent
	call AIDoAction_KOSwitch
	ldh a, [hTemp_ffa0]
	ldh [hTempPlayAreaLocation_ff9d], a
	jr .replace_pokemon

; wait for link opponent to replace the knocked out Pokemon with one from bench
.link_opponent
	call DrawDuelMainScene
	ldtx hl, DuelistIsSelectingPokemonToPlaceInArenaText
	call DrawWideTextBox_PrintText
	call SerialRecv8Bytes
	ldh [hTempPlayAreaLocation_ff9d], a
	jr .replace_pokemon

Func_6fa5:
	call CountKnockedOutPokemon
	ret nc
	; at least one Pokemon knocked out
	call SwapTurn
	call TurnDuelistTakePrizes
	call SwapTurn
	ret nc
	call SwapTurn
	call DrawDuelMainScene
	ldtx hl, TookAllThePrizesText
	call DrawWideTextBox_WaitForInput
	call ExchangeRNG
	call SwapTurn
	scf
	ret

; return in wNumberPrizeCardsToTake the amount of Pokemon in the turn holder's
; play area that are still there despite having 0 HP.
; that is, the number of Pokemon that have just been knocked out.
; Clefairy Doll and Mysterious Fossil don't count.
CountKnockedOutPokemon:
	ld a, DUELVARS_ARENA_CARD_HP
	get_turn_duelist_var
	ld d, h
	ld e, DUELVARS_ARENA_CARD
	ld b, PLAY_AREA_ARENA
	ld c, MAX_PLAY_AREA_POKEMON
.loop
	ld a, [de]
	cp -1
	jr z, .next ; jump if no Pokemon in this location
	ld a, [hl]
	or a
	jr nz, .next ; jump if this Pokemon's HP isn't 0
	; this Pokemon's HP has just become 0
	ld a, [de]
	push de
	call GetCardIDFromDeckIndex
	call GetCardType
	pop de
	cp TYPE_TRAINER
	jr z, .next ; jump if this is a trainer card (Clefairy Doll or Mysterious Fossil)
	inc b
.next
	inc hl
	inc de
	dec c
	jr nz, .loop
	ld a, b
	ld [wNumberPrizeCardsToTake], a
	or a
	ret z
	scf
	ret

; returns carry if turn duelist has no Play Area Pokémon
; with non-zero HP, that is, all Pokémon are knocked out
CheckIfTurnDuelistPlayAreaPokemonAreAllKnockedOut:
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	ld c, a
	ld l, DUELVARS_ARENA_CARD_HP
.loop
	ld a, [hli]
	or a
	jr nz, .non_zero_hp
	dec c
	jr nz, .loop
	scf
	ret
.non_zero_hp
	or a
	ret
; 0x66d0

SECTION "Bank 1@6717", ROMX[$6717], BANK[$1]

; returns carry if card at hTempPlayAreaLocation_ff9d
; is a basic card.
; otherwise, lists the card indices of all stages in
; that card location, and returns the card one
; stage below.
; input:
;	hTempPlayAreaLocation_ff9d = play area location to check;
; output:
;	a = card index in hTempPlayAreaLocation_ff9d;
;	d = card index of card one stage below;
;	carry set if card is a basic card.
GetCardOneStageBelow:
	ldh a, [hTempPlayAreaLocation_ff9d]
	add DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call LoadCardDataToBuffer2_FromDeckIndex
	ld a, [wLoadedCard2Stage]
	or a
	jr nz, .not_basic
	scf
	ret

.not_basic
	ld hl, wAllStagesIndices
	ld a, $ff
	ld [hli], a
	ld [hli], a
	ld [hl], a

; loads deck indices of the stages present in hTempPlayAreaLocation_ff9d.
; the three stages are loaded consecutively in wAllStagesIndices.
	ldh a, [hTempPlayAreaLocation_ff9d]
	or CARD_LOCATION_ARENA
	ld c, a
	ld a, DUELVARS_CARD_LOCATIONS
	get_turn_duelist_var
.loop
	ld a, [hl]
	cp c
	jr nz, .next
	ld a, l
	call LoadCardDataToBuffer2_FromDeckIndex
	ld a, [wLoadedCard2Type]
	cp TYPE_ENERGY
	jr nc, .next
	ld b, l
	push hl
	ld a, [wLoadedCard2Stage]
	ld e, a
	ld d, $00
	ld hl, wAllStagesIndices
	add hl, de
	ld [hl], b
	pop hl
.next
	inc l
	ld a, l
	cp DECK_SIZE
	jr c, .loop

; if card at hTempPlayAreaLocation_ff9d is a stage 1, load d with basic card.
; otherwise if stage 2, load d with the stage 1 card.
	ldh a, [hTempPlayAreaLocation_ff9d]
	add DUELVARS_ARENA_CARD_STAGE
	get_turn_duelist_var
	ld hl, wAllStagesIndices ; pointing to basic
	cp STAGE1
	jr z, .done
	; if stage1 was skipped, hl should point to Basic stage card
	cp STAGE2_WITHOUT_STAGE1
	jr z, .done
	inc hl ; pointing to stage 1
.done
	ld d, [hl]
	ldh a, [hTempPlayAreaLocation_ff9d]
	add DUELVARS_ARENA_CARD
	get_turn_duelist_var
	ld e, a
	or a
	ret

; initializes variables when a duel begins, such as zeroing wDuelFinished or wDuelTurns,
; and setting wDuelType based on wPlayerDuelistType and wOpponentDuelistType
InitVariablesToBeginDuel:
	xor a
	ld [wDuelFinished], a
	ld [wDuelTurns], a
	ld [wccfc], a
	ld [wGoopGasAttackActive], a
	ld [wcc07], a

	ld a, $ff
	ld [wcc0f], a
	ld [wPlayerAttackingCardIndex], a
	ld [wPlayerAttackingAttackIndex], a

	ld a, [wSelectedCoin]
	ld [wPlayerCoin], a
	call Func_6838

	ld b, MAX_PLAY_AREA_POKEMON
	ld a, [wSpecialRule]
	cp SMALL_BENCH
	jr nz, .got_bench_size
	ld b, MAX_SMALL_BENCH_PLAY_AREA_POKEMON
.got_bench_size
	ld a, b
	ld [wMaxNumPlayAreaPokemon], a

	call GetDuelInitialPrizesBits
	ld [wPlayerPrizes], a
	ld [wOpponentPrizes], a

	ld a, [wPlayerDuelistType]
	cp DUELIST_TYPE_LINK_OPP
	jr z, .set_duel_type
	bit 7, a ; DUELIST_TYPE_AI_OPP
	jr nz, .set_duel_type
	ld a, [wOpponentDuelistType]
	cp DUELIST_TYPE_LINK_OPP
	jr z, .set_duel_type
	bit 7, a ; DUELIST_TYPE_AI_OPP
	jr nz, .set_duel_type
	xor a
.set_duel_type
	ld [wDuelType], a
	ret

; init variables that last a single player's turn
InitVariablesToBeginTurn:
	xor a
	ld [wAlreadyPlayedEnergy], a
	ld [wGotHeadsFromConfusionCheckDuringRetreat], a
	ld [wcc03], a
	ld [wcd09], a
	ld [wEffectFailed], a
	ld [wMetronomeEnergyCost], a
	ld a, $ff
	ld [wcc1b], a
	ldh a, [hWhoseTurn]
	ld [wWhoseTurn], a
	farcall ResetAttackAnimationIsPlaying
	ret

; make all Pokemon in the turn holder's play area able to evolve. called from the
; player's second turn on, in order to allow evolution of all Pokemon already played.
SetAllPlayAreaPokemonCanEvolve:
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	ld c, a
	ld l, DUELVARS_ARENA_CARD_FLAGS
.loop_turn_holder_play_area
	res PLAY_AREA_FLAG_UNK_2_F, [hl]
	res USED_PKMN_POWER_THIS_TURN_F, [hl]
	set CAN_EVOLVE_THIS_TURN_F, [hl]
	inc l
	dec c
	jr nz, .loop_turn_holder_play_area

	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	call GetNonTurnDuelistVariable
	ld c, a
	ld l, DUELVARS_ARENA_CARD_FLAGS
.loop_non_turn_holder_play_area
	res PLAY_AREA_FLAG_UNK_2_F, [hl]
	inc l
	dec c
	jr nz, .loop_non_turn_holder_play_area
	ret

; initializes duel variables such as cards in deck and in hand, or Pokemon in play area
; player turn: [c200, c2ff]
; opponent turn: [c300, c3ff]
InitializeDuelVariables:
	ldh a, [hWhoseTurn]
	ld h, a
	ld l, DUELVARS_DUELIST_TYPE
	ld a, [hl]
	push hl
	push af
	xor a
	ld l, a
.zero_duel_variables_loop
	ld [hl], a
	inc l
	jr nz, .zero_duel_variables_loop
	pop af
	pop hl
	ld [hl], a
	lb bc, DUELVARS_CARD_LOCATIONS, DECK_SIZE
	ld l, DUELVARS_DECK_CARDS
.init_duel_variables_loop
; zero card locations and cards in hand, and init order of cards in deck
	push hl
	ld [hl], b
	ld l, b
	ld [hl], $0
	pop hl
	inc l
	inc b
	dec c
	jr nz, .init_duel_variables_loop
	ld l, DUELVARS_ARENA_CARD
	ld c, MAX_PLAY_AREA_POKEMON + 1
.init_play_area
; initialize to $ff card in arena as well as cards in bench (plus a terminator)
	ld [hl], -1
	inc l
	dec c
	jr nz, .init_play_area
	ret

Func_6838:
	call EnableSRAM
	ld a, [sSkipDelayAllowed]
	ld [wSkipDelayAllowed], a
	ld a, [s0a00b]
	ld [wcd14], a
	call DisableSRAM
	ret

; draw [wDuelInitialPrizes] cards from the turn holder's deck and place them as prizes:
; write their deck indexes to DUELVARS_PRIZE_CARDS, set their location to
; CARD_LOCATION_PRIZE, and set [wDuelInitialPrizes] bits of DUELVARS_PRIZES.
InitTurnDuelistPrizes:
	ldh a, [hWhoseTurn]
	ld d, a
	ld e, DUELVARS_PRIZE_CARDS
	ld a, [wDuelInitialPrizes]
	ld c, a
	ld b, 0
.draw_prizes_loop
	call DrawCardFromDeck
	ld [de], a
	inc de
	ld h, d
	ld l, a
	ld [hl], CARD_LOCATION_PRIZE
	inc b
	ld a, b
	cp c
	jr nz, .draw_prizes_loop
	call GetDuelInitialPrizesBits
	ld l, DUELVARS_PRIZES
	ld [hl], a
	ret

; calculates bits set up to the number of initial prizes:
GetDuelInitialPrizesBits:
	push hl
	ld a, [wDuelInitialPrizes]
	ld e, a
	ld d, $00
	ld hl, PrizeBitmasks
	add hl, de
	ld a, [hl]
	pop hl
	ret

PrizeBitmasks:
	db %000000 ; 0
	db %000001 ; PRIZES_1
	db %000011 ; PRIZES_2
	db %000111 ; PRIZES_3
	db %001111 ; PRIZES_4
	db %011111 ; PRIZES_5
	db %111111 ; PRIZES_6

; update the turn holder's DUELVARS_PRIZES following that duelist
; drawing a number of prizes equal to register a
TakeAPrizes:
	or a
	ret z
	ld c, a
	call CountPrizes
	sub c
	jr nc, .no_underflow
	xor a
.no_underflow
	ld c, a
	ld b, $00
	ld hl, PrizeBitmasks
	add hl, bc
	ld b, [hl]
	ld a, DUELVARS_PRIZES
	get_turn_duelist_var
	ld [hl], b
	ret

; writes the cards in de to hl
; in a compressed format
SaveDeckCards:
	push hl
	push de
	push bc
	ld a, 8
.loop
	push af
	inc hl
	ld c, 8
.loop_bits
	ld a, [de]
	inc de
	ld [hli], a
	ld a, [de]
	inc de
	rra
	rl b
	dec c
	jr nz, .loop_bits
	push hl
	push de
	ld de, -9
	add hl, de
	ld [hl], b
	pop de
	pop hl
	pop af
	dec a
	jr nz, .loop
	pop bc
	pop de
	pop hl
	ret

; loads deck saved in SRAM to hl
DecompressSRAMDeck::
	push hl
	push de
	push bc
	ld a, $08
.loop_outer
	push af
	ld a, [de]
	inc de
	ld b, a
	ld c, 8 ; number of bits
.loop_inner
	ld a, [de]
	inc de
	ld [hli], a
	xor a
	rl b
	rla
	ld [hli], a
	dec c
	jr nz, .loop_inner
	pop af
	dec a
	jr nz, .loop_outer
	pop bc
	pop de
	pop hl
	ret

; outputs in wAttackEnergyCost the energy cost of one of wLoadedCard1's attacks
; input:
;   d = deck index of card (0 to 59)
;   e = attack index (0 or 1)
; returns: carry if not a valid attack
GetLoadedAttackEnergyCost:
	ld c, e
	ld a, d
	call LoadCardDataToBuffer1_FromDeckIndex
	ld de, wLoadedCard1Atk1EnergyCost
	dec c
	jr nz, .got_atk
	ld de, wLoadedCard1Atk2EnergyCost

.got_atk
	ld hl, CARD_DATA_ATTACK1_NAME - CARD_DATA_ATTACK1_ENERGY_COST
	add hl, de
	ld a, [hli]
	or [hl]
	jr z, .set_carry
	ld hl, CARD_DATA_ATTACK1_CATEGORY - CARD_DATA_ATTACK1_ENERGY_COST
	add hl, de
	ld a, [hl]
	cp POKEMON_POWER
	jr z, .set_carry
	ld c, (NUM_TYPES) / 2
	ld hl, wAttackEnergyCost

.next_energy_type_pair
	ld a, [de]
	swap a
	and $0f
	ld [hli], a
	ld a, [de]
	and $0f
	ld [hli], a
	inc de
	dec c
	jr nz, .next_energy_type_pair
	or a
	ret
.set_carry
	scf
	ret

; play the trainer card with deck index at hTempCardIndex_ff98.
; a trainer card is like an attack effect, with its own effect commands.
; return nc if the card was played, carry if it wasn't.
PlayTrainerCard:
	call CheckCantUseTrainerDueToEffect
	jr c, .cant_use
	ldh a, [hWhoseTurn]
	ld h, a
	ldh a, [hTempCardIndex_ff98]
	ldh [hTempCardIndex_ff9f], a
	call LoadNonPokemonCardEffectCommands
	ld a, EFFECTCMDTYPE_INITIAL_EFFECT_1
	call TryExecuteEffectCommandFunction
	jr nc, .can_use
.cant_use
	call DrawWideTextBox_WaitForInput
	scf
	ret
.can_use
	ld a, EFFECTCMDTYPE_INITIAL_EFFECT_2
	call TryExecuteEffectCommandFunction
	jr c, .done
	ld a, OPPACTION_PLAY_TRAINER
	call SetOppAction_SerialSendDuelData
	farcall DisplayUsedTrainerCardDetailScreen
	call ExchangeRNG
	ld a, EFFECTCMDTYPE_DISCARD_ENERGY
	call TryExecuteEffectCommandFunction
	ld a, EFFECTCMDTYPE_REQUIRE_SELECTION
	call TryExecuteEffectCommandFunction
	ld a, OPPACTION_EXECUTE_TRAINER_EFFECTS
	call SetOppAction_SerialSendDuelData
	ld a, EFFECTCMDTYPE_BEFORE_DAMAGE
	call TryExecuteEffectCommandFunction
	ldh a, [hTempCardIndex_ff9f]
	call MoveHandCardToDiscardPile
	call ExchangeRNG
	ld a, [wcd15]
	cp $ff
	jr z, .done
	ldh [hTempCardIndex_ff98], a
	call ProcessPlayedPokemonCard
.done
	or a
	ret

; loads the effect commands of a (trainer or energy) card with deck index (0-59) at hTempCardIndex_ff9f
; into wLoadedAttackEffectCommands. in practice, only used for trainer cards
LoadNonPokemonCardEffectCommands:
	ldh a, [hTempCardIndex_ff9f]
	call LoadCardDataToBuffer1_FromDeckIndex
	ld hl, wLoadedCard1EffectCommands
	ld de, wLoadedAttackEffectCommands
	ld a, [hli]
	ld [de], a
	inc de
	ld a, [hl]
	ld [de], a
	ld a, DUELVARS_ARENA_CARD_SUBSTATUS1
	call GetNonTurnDuelistVariable
	ld [wcd0b], a
	ld a, $ff
	ld [wcd15], a
	ret

Func_6986:
	ldh a, [hTempCardIndex_ff98]
	ldh [hTempCardIndex_ff9f], a
	call LoadNonPokemonCardEffectCommands
	ld hl, wLoadedAttackEffectCommands
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, EFFECTCMDTYPE_PKMN_POWER_TRIGGER
	call CheckMatchingCommand
	ret c
	farcall ResetAttackAnimationIsPlaying
	ld a, EFFECTCMDTYPE_PKMN_POWER_TRIGGER
	call TryExecuteEffectCommandFunction
	ret

; returns carry if Black Hole rule is active
; when attempting to open the Discard Pile
IsBlackHoleRuleActive:
	ld a, [wSpecialRule]
	cp BLACK_HOLE
	jr z, .black_hole_rule
	or a
	ret
.black_hole_rule
	ld a, $ff
	ld [wDuelTempList], a
	ldtx hl, NoCardsInDiscardPileText ; this text ID is always discarded
	xor a
	scf
	ret

; fill wDuelTempList with the turn holder's discard pile cards (their 0-59 deck indexes)
; return carry if the turn holder has no cards in the discard pile
CreateDiscardPileCardList:
	call IsBlackHoleRuleActive
	ret c ; no Discard Pile
	ldh a, [hWhoseTurn]
	ld h, a
	ld l, DUELVARS_NUMBER_OF_CARDS_IN_DISCARD_PILE
	ld b, [hl]
	ld a, DUELVARS_DECK_CARDS - 1
	add [hl] ; point to last card in discard pile
	ld l, a
	ld de, wDuelTempList
	inc b
	jr .begin_loop
.next_card_loop
	ld a, [hld]
	ld [de], a
	inc de
.begin_loop
	dec b
	jr nz, .next_card_loop
	ld a, $ff ; $ff-terminated
	ld [de], a
	ld l, DUELVARS_NUMBER_OF_CARDS_IN_DISCARD_PILE
	ld a, [hl]
	or a
	ret nz
	scf
	ret

; loads all the energy cards
; in hand in wDuelTempList
; output in a the number of cards found
; return carry if no energy cards found
CreateEnergyCardListFromHand:
	push hl
	push de
	push bc
	ld de, wDuelTempList
	ld a, DUELVARS_NUMBER_OF_CARDS_IN_HAND
	get_turn_duelist_var
	ld c, a
	inc c
	ld b, 0
	ld l, DUELVARS_HAND
	jr .decrease

.loop
	ld a, [hli]
	push de
	call GetCardIDFromDeckIndex
	call GetCardType
	pop de
	and TYPE_ENERGY
	jr z, .decrease
	dec hl
	ld a, [hli]
	ld [de], a
	inc de
	inc b
.decrease
	dec c
	jr nz, .loop

	ld a, $ff
	ld [de], a
	ld a, b
	pop bc
	pop de
	pop hl
	or a
	ret nz
	scf
	ret

; creates a list at wTempCardCollection of every card the player owns and how many
CreateTempCardCollection::
	call EnableSRAM
	ld hl, sCardCollection
	ld de, wTempCardCollection
	ld bc, CARD_COLLECTION_SIZE
	call CopyDataHLtoDE
	ld de, sDeck1Cards
	call .AddCards
	call .AddCards
	call .AddCards
	call .AddCards
	call DisableSRAM
	ret

.AddCards:
	push de
	ld hl, wDuelTempList
	push hl
	call DecompressSRAMDeck
	pop hl
.loop_cards
	ld e, [hl]
	inc hl
	ld d, [hl]
	inc hl
	ld a, e
	or d
	jr z, .next_deck
	push hl
	ld hl, wTempCardCollection
	add hl, de
	inc [hl]
	pop hl
	jr .loop_cards
.next_deck
	pop de
	ld hl, DECK_COMPRESSED_STRUCT_SIZE
	add hl, de
	ld e, l
	ld d, h
	ret

; sort the turn holder's hand cards by ID (highest to lowest ID)
; makes use of wDuelTempList
SortHandCardsByID:
	call FindLastCardInHand
.loop
	ld a, [hld]
	ld [de], a
	inc de
	dec b
	jr nz, .loop
	ld a, $ff
	ld [de], a
	call SortCardsInDuelTempListByID
	call FindLastCardInHand
.loop2
	ld a, [de]
	inc de
	ld [hld], a
	dec b
	jr nz, .loop2
	ret

; shuffles the turn holder's deck
; if less than 60 cards remain in the deck, it makes sure that the rest are ignored
ShuffleDeck:
	ldh a, [hWhoseTurn]
	ld h, a
	ld d, a
	ld a, DECK_SIZE
	ld l, DUELVARS_NUMBER_OF_CARDS_NOT_IN_DECK
	sub [hl]
	ld b, a
	ld a, DUELVARS_DECK_CARDS
	add [hl]
	ld l, a ; hl = DUELVARS_DECK_CARDS + [DUELVARS_NUMBER_OF_CARDS_NOT_IN_DECK]
	ld a, b ; a = number of cards in the deck
	call ShuffleCards
	ret
; 0x6a7c

SECTION "Bank 1@6a96", ROMX[$6a96], BANK[$1]

SortCardsInDuelTempListByID:
	ld hl, hTempListPtr_ff99
	ld [hl], LOW(wDuelTempList)
	inc hl
	ld [hl], HIGH(wDuelTempList)
	jr .asm_6ae2

.asm_6aa0
	ld hl, hTempListPtr_ff99
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld e, l
	ld d, h
	ld a, [de]
	call .GetCardID
	ld a, c
	ldh [hTempCardID_ff9b + 0], a
	ld a, b
	ldh [hTempCardID_ff9b + 1], a
	inc hl
	jr .asm_6acc

.compare_card_ids
	ld a, [hl]
	call .GetCardID
	ldh a, [hTempCardID_ff9b + 1]
	cp b
	jr nz, .swap_card_ids
	ldh a, [hTempCardID_ff9b + 0]
	cp c
.swap_card_ids
	jr c, .sorted
	ld e, l
	ld d, h
	ld a, c
	ldh [hTempCardID_ff9b + 0], a
	ld a, b
	ldh [hTempCardID_ff9b + 1], a
.sorted
	inc hl
.asm_6acc
	bit 7, [hl]
	jr z, .compare_card_ids
	ld hl, hTempListPtr_ff99
	push hl
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld c, [hl]
	ld a, [de]
	ld [hl], a
	ld a, c
	ld [de], a
	pop hl
	inc [hl]
	jr nz, .asm_6ae2
	inc hl
	inc [hl]
.asm_6ae2
	ld hl, hTempListPtr_ff99
	ld a, [hli]
	ld h, [hl]
	ld l, a
	bit 7, [hl]
	jr z, .asm_6aa0
	ret

.GetCardID:
	push hl
	call _GetCardIDFromDeckIndex
	ld c, [hl]
	inc hl
	ld b, [hl]
	pop hl
	ret

; return [wDuelTempList + a] in a and in hTempCardIndex_ff98
GetCardInDuelTempList_OnlyDeckIndex:
	push hl
	push de
	ld e, a
	ld d, $0
	ld hl, wDuelTempList
	add hl, de
	ld a, [hl]
	ldh [hTempCardIndex_ff98], a
	pop de
	pop hl
	ret

; clear the non-turn holder's duelvars starting at DUELVARS_ARENA_CARD_DISABLED_ATTACK_INDEX
; these duelvars only last a two-player turn at most.
ClearNonTurnTemporaryDuelvars::
	ld a, DUELVARS_ARENA_CARD_DISABLED_ATTACK_INDEX
	call GetNonTurnDuelistVariable
	xor a
	ld [hli], a ; DUELVARS_ARENA_CARD_DISABLED_ATTACK_INDEX
	ld [hli], a ; DUELVARS_ARENA_CARD_LAST_TURN_DAMAGE
	ld [hli], a ; DUELVARS_ARENA_CARD_LAST_TURN_STATUS
	ld [hli], a ; DUELVARS_ARENA_CARD_LAST_TURN_SUBSTATUS2
	ld [hli], a ; DUELVARS_ARENA_CARD_LAST_TURN_CHANGE_WEAK
	ld [hli], a ; DUELVARS_ARENA_CARD_LAST_TURN_EFFECT
	ld [hl], a  ; DUELVARS_UNK_FE
	ret

; same as ClearNonTurnTemporaryDuelvars, except the non-turn holder's arena
; Pokemon status condition is copied to wccc5
ClearNonTurnTemporaryDuelvars_CopyStatus::
	ld a, DUELVARS_ARENA_CARD_STATUS
	call GetNonTurnDuelistVariable
	ld [wccc5], a
	call ClearNonTurnTemporaryDuelvars
	ret
; 0x6b1f

SECTION "Bank 1@6b37", ROMX[$6b37], BANK[$1]

; given the deck index (0-59) of a card in [wDuelTempList + a], return:
;  - the id of the card with that deck index in register de
;  - [wDuelTempList + a] in hTempCardIndex_ff98 and in register a
GetCardInDuelTempList:
	push hl
	ld e, a
	ld d, $0
	ld hl, wDuelTempList
	add hl, de
	ld a, [hl]
	ldh [hTempCardIndex_ff98], a
	call GetCardIDFromDeckIndex
	pop hl
	ldh a, [hTempCardIndex_ff98]
	ret

; b = attacking card Play Area location
; c = defending card Play Area location
; de = base damage
DamageCalculation:
	push bc
	ld a, c
	ld [wTempPlayAreaLocation_cceb], a
	xor a
	ld [wDamageEffectiveness], a
	ld a, b
	or a
	jr nz, .skip_damage_modifiers
	call HandleDamageModifiersEffects
.skip_damage_modifiers
	pop bc
	ld a, e
	or d
	ret z ; no damage
	ld a, b
	call GetPlayAreaCardColor
	call TranslateColorToWR
	ld b, a
	call CheckWhetherToApplyWeakness
	jr c, .check_resistance
	ld a, [wIsDamageToSelf]
	or a
	jr z, .not_self_damage_1
	ld a, [wTempPlayAreaLocation_cceb]
	call GetArenaOrBenchCardWeakness
	jr .got_weakness
.not_self_damage_1
	call SwapTurn
	ld a, [wTempPlayAreaLocation_cceb]
	call GetArenaOrBenchCardWeakness
	call SwapTurn
.got_weakness
	and b
	jr z, .check_resistance
	; double the damage
	sla e
	rl d
	ld hl, wDamageEffectiveness
	set WEAKNESS, [hl]

.check_resistance
	call CheckWhetherToApplyResistance
	jr c, .no_resistance
	ld a, [wIsDamageToSelf]
	or a
	jr z, .not_self_damage_2
	ld a, [wTempPlayAreaLocation_cceb]
	call GetArenaOrBenchCardResistance
	jr .got_resistance
.not_self_damage_2
	call SwapTurn
	ld a, [wTempPlayAreaLocation_cceb]
	call GetArenaOrBenchCardResistance
	call SwapTurn
.got_resistance
	and b
	jr z, .no_resistance
	ld hl, -30
	ld a, [wSpecialRule]
	cp LOW_RESISTANCE
	jr nz, .got_resistance_modifier
	ld hl, -10
.got_resistance_modifier
	add hl, de
	ld e, l
	ld d, h
	ld hl, wDamageEffectiveness
	set RESISTANCE, [hl]
.no_resistance
	ret

SetDefaultPalettes:
	call SetFontAndTextBoxFrameColor
	ld a, %11100100
	ld [wOBP0], a
	ld [wBGP], a
	ld a, $01 ; equivalent to FLUSH_ONE_PAL
	ldh [hFlushPaletteFlags], a
	ld hl, Pals_6f0b0 - $4000
	ld de, wObjectPalettesCGB
	ld c, PAL_SIZE
	call CopyFontsOrDuelGraphicsBytes
	call FlushAllPalettes
	ret

SetFontAndTextBoxFrameColor:
	ld a, $01
	ld [wTextBoxFrameType], a
	ld hl, Pals_6f0b0 - $4000
	ld de, wBackgroundPalettesCGB
	ld c, PAL_SIZE
	call CopyFontsOrDuelGraphicsBytes
	push de
	call EnableSRAM
	ld a, [sTextBoxFrameColor]
	call DisableSRAM
	inc a
	add a
	add a
	add a ; *PAL_SIZE
	ld e, a
	ld d, $00
	ld hl, Pals_6f0b0 - $4000
	add hl, de
	pop de
	ld c, PAL_SIZE
	call CopyFontsOrDuelGraphicsBytes
	ret

Func_6c12::
	ld hl, Pals_6f0d8 - $4000
	ld de, wBackgroundPalettesCGB + 2 * PAL_SIZE
	ld c, 3 palettes
	jp CopyFontsOrDuelGraphicsBytes
; 0x6c1d

SECTION "Bank 1@6c22", ROMX[$6c22], BANK[$1]

HandleDamageModifiersEffects::
	call HandlePrehistoricDreamDamageBoost
	call HandleThunderChargeDamageBoost
	call Func_6f25

	ld a, DUELVARS_ARENA_CARD_SUBSTATUS1
	get_turn_duelist_var
	or a
	call nz, .HandleSubstatus1DamageModifiers
	ld a, DUELVARS_ARENA_CARD_SUBSTATUS2
	get_turn_duelist_var
	or a
	call nz, .HandleSubstatus2DamageModifiers
	ret

.HandleSubstatus1DamageModifiers:
	cp SUBSTATUS1_NEXT_TURN_DOUBLE_DAMAGE
	jr z, .double_damage
	cp SUBSTATUS1_UNK_0D
	jr z, .triple_damage
	ret
.double_damage
	call .Func_6c5a
	ret nz
	ld a, e
	or d
	ret z
	sla e
	rl d
	ret
.triple_damage
	call .Func_6c5a
	ret nz
	ld l, e
	ld h, d
	add hl, hl
	add hl, de
	ld e, l
	ld d, h
	ret

; compares loaded attack name with
; turn holder's DUELVARS_UNK_FE
; if it's the same, then return z
.Func_6c5a:
	push hl
	push de
	ld l, DUELVARS_UNK_FE
	ld e, [hl]
	inc hl
	ld d, [hl]
	ld hl, wLoadedAttackName
	ld a, [hli]
	cp e
	jr nz, .not_same
	ld a, [hl]
	cp d
.not_same
	pop de
	pop hl
	ret

.HandleSubstatus2DamageModifiers:
	ret

; check if the attacking card (non-turn holder's arena card) has any substatus that
; reduces the damage dealt this turn (SUBSTATUS2).
; check if the defending card (turn holder's arena card) has any substatus that
; reduces the damage dealt to it this turn (SUBSTATUS1 or Pkmn Powers).
; damage is given in de as input and the possibly updated damage is also returned in de.
HandleDamageReduction::
	call HandleDamageReductionExceptSubstatus2

	ld a, [wLoadedAttackCategory]
	cp POKEMON_POWER
	ret z

	ld a, DUELVARS_ARENA_CARD_SUBSTATUS2
	call GetNonTurnDuelistVariable
	or a
	ret z
	cp SUBSTATUS2_REDUCE_BY_20
	jr z, .reduce_damage_by_20
	cp SUBSTATUS2_POUNCE
	jr z, .reduce_damage_by_10
	cp SUBSTATUS2_GROWL
	jr z, .reduce_damage_by_10
	ret
.reduce_damage_by_20
	ld hl, -20
	add hl, de
	ld e, l
	ld d, h
	ret
.reduce_damage_by_10
	ld hl, -10
	add hl, de
	ld e, l
	ld d, h
	ret
; 0x6c99

SECTION "Bank 1@6cbf", ROMX[$6cbf], BANK[$1]

; check if the defending card (turn holder's arena card) has any substatus that
; reduces the damage dealt to it this turn. (SUBSTATUS1 or Pkmn Powers)
; damage is given in de as input and the possibly updated damage is also returned in de.
HandleDamageReductionExceptSubstatus2:
	ld a, [wNoDamageOrEffect]
	or a
	jr nz, .no_damage
	ld a, DUELVARS_ARENA_CARD_SUBSTATUS1
	get_turn_duelist_var
	or a
	jr z, .not_affected_by_substatus1

	cp SUBSTATUS1_DOUBLE_DAMAGE
	jp z, .double_damage
	cp SUBSTATUS1_UNK_28
	jr z, .no_damage
	cp SUBSTATUS1_UNK_27
	jr z, .no_damage
	cp SUBSTATUS1_NO_DAMAGE_STIFFEN
	jr z, .no_damage
	cp SUBSTATUS1_NO_DAMAGE_10
	jr z, .no_damage
	cp SUBSTATUS1_NO_DAMAGE_11
	jr z, .no_damage
	cp SUBSTATUS1_NO_DAMAGE_17
	jr z, .no_damage
	cp SUBSTATUS1_REDUCE_BY_10
	jr z, .reduce_damage_by_10
	cp SUBSTATUS1_REDUCE_BY_20
	jr z, .reduce_damage_by_20
	cp SUBSTATUS1_HARDEN
	jr z, .prevent_less_than_40_damage
	cp SUBSTATUS1_UNK_26
	jr z, .prevent_less_than_30_damage
	cp SUBSTATUS1_HALVE_DAMAGE
	jr z, .halve_damage
	cp SUBSTATUS1_UNK_25
	jr z, .no_damage

.not_affected_by_substatus1
	call ApplyDarknessVeilDamageReduction
	call CheckIsIncapableOfUsingPkmnPower_ArenaCard
	ret c
.pkmn_power
	ld a, [wLoadedAttackCategory]
	cp POKEMON_POWER
	ret z
	ld hl, wTempNonTurnDuelistCardID
	cphl MR_MIME_LV28
	jr z, .invisible_wall
	cphl KABUTO_LV9
	jr z, .kabuto_armor
	ret

.no_damage
	ld de, 0
	ret

.reduce_damage_by_10
	ld hl, -10
	add hl, de
	ld e, l
	ld d, h
	ret

.reduce_damage_by_20
	ld a, [wLoadedAttackCategory]
	cp POKEMON_POWER
	ret z
	ld hl, -20
	add hl, de
	ld e, l
	ld d, h
	ret

.prevent_less_than_40_damage
	ld bc, 40
	call CompareDEtoBC
	ret nc
	ld de, 0
	ret

.prevent_less_than_30_damage
	ld bc, 30
	call CompareDEtoBC
	ret nc
	ld de, 0
	ret

.halve_damage
	sla d ; bug, should be sra d
	rr e
	bit 0, e
	ret z
	ld hl, -5
	add hl, de
	ld e, l
	ld d, h
	ret

.invisible_wall
	ld a, [wLoadedAttackCategory]
	cp POKEMON_POWER
	ret z
	ld bc, 30
	call CompareDEtoBC
	ret c
	ld de, 0
	ret

.kabuto_armor
	sla d ; bug, should be sra d
	rr e
	bit 0, e
	ret z
	ld hl, -5
	add hl, de
	ld e, l
	ld d, h
	ret

.double_damage
	sla e
	rl d
	ret
; 0x6d87

SECTION "Bank 1@6e57", ROMX[$6e57], BANK[$1]

ApplyDarknessVeilDamageReduction:
	ldh a, [hWhoseTurn]
	ld hl, wWhoseTurn
	cp [hl]
	ret z
	ld hl, wDarknessVeilDamageModifier
	ld a, [hli]
	add e
	ld e, a
	ld a, [hl]
	adc d
	ld d, a
	ret

; determines what values to use if Dark Wave
; or Darkness Veil are activated this turn
; for each, randomly select between 0, 10 and 20
SetDarkWaveAndDarknessVeilDamageModifiers::
	xor a
	ld hl, wDarkWaveAndDarknessVeilDamageModifiers
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld [hl], a
	call .DarkWave
	call SwapTurn
	call .DarknessVeil
	call SwapTurn
	ret

.DarkWave:
	xor a
	ld hl, wDarkWaveDamageModifier
	ld [hli], a
	ld [hl], a

	call CheckGoopGasAttackAndToxicGasActive
	ret c ; no Pkmn Powers

	; loop Play Area and search for GR's Mewtwo
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	ld c, a
	ld b, PLAY_AREA_ARENA
	ld de, 0 ; unused
.loop_play_area_1
	ld a, b
	add DUELVARS_ARENA_CARD
	get_turn_duelist_var
	cp $ff
	jr z, .next_card_1

	; check if it's GR's Mewtwo
	push de
	call GetCardIDFromDeckIndex
	cp16 GRS_MEWTWO
	pop de
	jr nz, .next_card_1

	; check if it is affected by Stare
	ld a, b
	add DUELVARS_ARENA_CARD_FLAGS
	get_turn_duelist_var
	and AFFECTED_BY_STARE
	jr nz, .next_card_1

	; store a random number: 0, 10 or 20
	ld a, 3
	call Random
	call ATimes10
	ld hl, wDarkWaveDamageModifier
	ld [hli], a
	ld [hl], 0
.next_card_1
	inc b
	dec c
	jr nz, .loop_play_area_1
	ret

.DarknessVeil:
	push de
	ld hl, wTempNonTurnDuelistCardID
	ld e, [hl]
	inc hl
	ld d, [hl]
	call CheckIfCardIDIsDarkPokemon
	pop de
	or a
	ret z

	call CheckGoopGasAttackAndToxicGasActive
	ret c ; no Pkmn Powers

	ld a, [wLoadedAttackCategory]
	cp POKEMON_POWER
	ret z ; not an attack

	; loop Play Area and search for Dark Clefable
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	ld c, a
	ld b, PLAY_AREA_ARENA
	ld de, 0
.loop_play_area_2

	; check if it's Dark Clefable
	push de
	ld a, b
	add DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call GetCardIDFromDeckIndex
	cp16 DARK_CLEFABLE
	pop de
	jr nz, .next_card_2

	; is it Arena Card?
	ld a, b
	or a
	jr nz, .skip_status_check
	; check if it is statused
	ld a, DUELVARS_ARENA_CARD_STATUS
	get_turn_duelist_var
	and CNF_SLP_PRZ
	jr nz, .next_card_2

.skip_status_check
	; check if it is affected by Stare
	ld a, b
	add DUELVARS_ARENA_CARD_FLAGS
	get_turn_duelist_var
	and AFFECTED_BY_STARE
	jr nz, .next_card_2

	; store a random number: 0, 10 or 20
	ld a, 3
	call Random
	call ATimes10
	; de -= a
	ld l, a
	ld a, e
	sub l
	ld e, a
	ld a, d
	sbc 0
	ld d, a
	jr .break
.next_card_2
	inc b
	dec c
	jr nz, .loop_play_area_2

.break
	ld hl, wDarknessVeilDamageModifier
	ld [hl], e
	inc hl
	ld [hl], d
	ret

; de = damage
Func_6f25:
	push de
	ld hl, wTempTurnDuelistCardID
	ld e, [hl]
	inc hl
	ld d, [hl]
	call CheckIfCardIDIsDarkPokemon
	pop de
	or a
	jr nz, .asm_6f37
	ret

	ld a, b
	or a
	ret z

.asm_6f37
	ld a, e
	or d
	ret z ; no damage
	ld a, [wMetronomeEnergyCost]
	or a
	ret nz
	ld hl, wDarkWaveDamageModifier
	ld a, [hli]
	add e
	ld e, a
	ld a, [hl]
	adc d
	ld d, a
	ret

; e = PLAY_AREA_* location
Func_6f49:
	ld a, e
	ld [wTempPlayAreaLocation_cceb], a
	or a
	jr nz, .bench

; arena card
	push de
	ld hl, wTempNonTurnDuelistCardID
	ld e, [hl]
	inc hl
	ld d, [hl]
	push hl
	push de
	ld a, [wTempPlayAreaLocation_cceb]
	call GetCardIDFromDeckIndex
	ld [hl], d
	dec hl
	ld [hl], e
	call HandleNoDamageOrEffectSubstatus
	jr nc, .asm_6f76
	push af
	call DrawWideTextBox_PrintText
	ld a, [wDuelDisplayedScreen]
	cp DUEL_MAIN_SCENE
	jr z, .skip_wait_for_input
	call WaitForWideTextBoxInput
.skip_wait_for_input
	pop af
.asm_6f76
	pop de
	pop hl
	ld [hl], d
	dec hl
	ld [hl], e
	pop de
	ret c ; exit if no damage

.bench
	push de
	ld a, [wTempPlayAreaLocation_cceb]
	call CheckIsIncapableOfUsingPkmnPower
	jr c, .no_carry
	call CheckArticunoAuroraVeil
	jr c, .asm_6fbb
	ld a, [wTempPlayAreaLocation_cceb]
	add DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call GetCardIDFromDeckIndex
	cp16 MEW_LV8
	jr z, .mew_lv8
	cp16 HAUNTER_LV17
	jr z, .haunter_lv17
.no_carry
	pop de
	or a
	ret

.mew_lv8
	ld a, DUELVARS_ARENA_CARD_STAGE
	call GetNonTurnDuelistVariable
	or a
	jr z, .no_carry
	ld a, $05
	ld [wNoDamageOrEffect], a
	ldtx hl, NoDamageOrEffectDueToNShieldText
.asm_6fbb
	call DrawWideTextBox_WaitForInput
	pop de
	scf
	ret

.haunter_lv17
	call CheckHaunterTransparency
	jr nc, .no_carry
	call DrawWideTextBox_WaitForInput
	pop de
	scf
	ret

; return carry if the defending card (turn holder's arena card) is under a substatus
; that prevents any damage or effect dealt to it for a turn.
; also return the cause of the substatus in wNoDamageOrEffect
HandleNoDamageOrEffectSubstatus::
	xor a
	ld [wNoDamageOrEffect], a
	ld a, [wLoadedAttackCategory]
	cp POKEMON_POWER
	ret z ; return if Pkmn Power

	ld a, DUELVARS_ARENA_CARD_SUBSTATUS1
	ld e, NO_DAMAGE_OR_EFFECT_HIDE
	ldtx hl, NoDamageOrEffectDueToHideText
	get_turn_duelist_var
	cp SUBSTATUS1_HIDE
	jr z, .no_damage_or_effect
	ld e, NO_DAMAGE_OR_EFFECT_FLY
	ldtx hl, NoDamageOrEffectDueToFlyText
	cp SUBSTATUS1_FLY
	jr z, .no_damage_or_effect
	ld e, NO_DAMAGE_OR_EFFECT_BARRIER
	ldtx hl, NoDamageOrEffectDueToBarrierText
	cp SUBSTATUS1_BARRIER
	jr z, .no_damage_or_effect
	ld e, NO_DAMAGE_OR_EFFECT_AGILITY
	ldtx hl, NoDamageOrEffectDueToAgilityText
	cp SUBSTATUS1_AGILITY
	jr z, .no_damage_or_effect

	; check Mew lv8
	call CheckIsIncapableOfUsingPkmnPower_ArenaCard
	ccf
	ret nc
	ld hl, wTempNonTurnDuelistCardID
	cphl MEW_LV8
	jr z, .neutralizing_shield
	or a
	ret

.no_damage_or_effect
	ld a, e
	ld [wNoDamageOrEffect], a
	scf
	ret

.neutralizing_shield
	ld a, [wIsDamageToSelf]
	or a
	ret nz
	; prevent damage if attacked by a non-basic Pokemon
	ld hl, wTempTurnDuelistCardID
	ld e, [hl]
	inc hl
	ld d, [hl]
	call LoadCardDataToBuffer2_FromCardID
	ld a, [wLoadedCard2Type]
	cp TYPE_ENERGY
	ret nc ; not Pkmn card
	ld a, [wLoadedCard2Stage]
	or a
	ret z ; is basic card
	ld e, NO_DAMAGE_OR_EFFECT_NSHIELD
	ldtx hl, NoDamageOrEffectDueToNShieldText
	jr .no_damage_or_effect
; 0x7038

SECTION "Bank 1@7057", ROMX[$7057], BANK[$1]

CheckHaunterTransparency:
	xor a
	ld [wDuelDisplayedScreen], a
	ld a, [wTempPlayAreaLocation_cceb]
	add DUELVARS_ARENA_CARD_FLAGS
	get_turn_duelist_var
	bit PLAY_AREA_FLAG_UNK_2_F, [hl]
	jr nz, .asm_707e
	set PLAY_AREA_FLAG_UNK_2_F, [hl]
	res PLAY_AREA_FLAG_UNK_1_F, [hl]
	push hl
	ldtx de, TransparencyCheckText
	call TossCoin
	pop hl
	ret nc
	set PLAY_AREA_FLAG_UNK_1_F, [hl]
.asm_7074
	ld a, $04
	ld [wNoDamageOrEffect], a
	ldtx hl, NoDamageOrEffectDueToTransparencyText
	scf
	ret
.asm_707e
	bit PLAY_AREA_FLAG_UNK_1_F, [hl]
	jr nz, .asm_7074
	or a
	ret

; return carry and return the appropriate text id in hl if the target has an
; special status or power that prevents any damage or effect done to it this turn
; input: a = NO_DAMAGE_OR_EFFECT_*
CheckNoDamageOrEffect::
	ld a, [wNoDamageOrEffect]
	or a
	ret z
	bit 7, a
	jr nz, .dont_print_text ; already been here so don't repeat the text
	ld hl, wNoDamageOrEffect
	set 7, [hl]
	dec a
	add a
	ld e, a
	ld d, $0
	ld hl, NoDamageOrEffectTextIDTable
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	scf
	ret

.dont_print_text
	ld hl, NULL
	scf
	ret

NoDamageOrEffectTextIDTable::
	tx NoDamageOrEffectDueToAgilityText ; NO_DAMAGE_OR_EFFECT_AGILITY
	tx NoDamageOrEffectDueToBarrierText ; NO_DAMAGE_OR_EFFECT_BARRIER
	tx NoDamageOrEffectDueToFlyText ; NO_DAMAGE_OR_EFFECT_FLY
	tx NoDamageOrEffectDueToTransparencyText ; NO_DAMAGE_OR_EFFECT_TRANSPARENCY
	tx NoDamageOrEffectDueToNShieldText ; NO_DAMAGE_OR_EFFECT_NSHIELD
	tx NoDamageOrEffectDueToHideText ; NO_DAMAGE_OR_EFFECT_HIDE
	tx NoDamageOrEffectDueToAuroraVeilText ; NO_DAMAGE_OR_EFFECT_AURORA_VEIL

CheckIsIncapableOfUsingPkmnPower_ArenaCard:
	xor a ; PLAY_AREA_ARENA
;	fallthrough

; returns carry if Pokemon in turn holder's Play Area location in register a
; cannot use its Pkmn Power, and if so outputs in a the reason:
; - $0 = Muk's Toxic Gas
; - $1 = Goop Gas Attack
; - $2 = Dark Arbok's Stare
CheckIsIncapableOfUsingPkmnPower:
	ld [wce0c], a
	or a
	jr nz, .skip_arena_card_condition
	ld a, DUELVARS_ARENA_CARD_STATUS
	get_turn_duelist_var
	and CNF_SLP_PRZ
	ldtx hl, CannotUseDueToStatusText
	scf
	ret nz
.skip_arena_card_condition
	call CheckGoopGasAttackAndToxicGasActive
	ret c
	ld a, [wce0c]
	add DUELVARS_ARENA_CARD_FLAGS
	get_turn_duelist_var
	and AFFECTED_BY_STARE
	jr z, .can_use
	; can't use due to Dark Arbok's Stare attack
	ldtx hl, UnableDueToStareText
	ld a, $2
	scf
	ret
.can_use
	or a
	ret

; return in a the amount of cards that correspond to the
; card ID in input register de, which have their Pkmn Power active
; also return carry if at least 1 is found
; de = card ID
CountPokemonWithActivePkmnPowerInBothPlayAreas:
	push bc
	push de
	call CountTurnDuelistPokemonWithActivePkmnPower
	ld c, a
	call SwapTurn
	pop de
	call CountTurnDuelistPokemonWithActivePkmnPower
	call SwapTurn
	add c
	jr z, .none_found
	scf
.none_found
	pop bc
	ret

; same as CountTurnDuelistPokemonWithActivePkmnPower
; but does not account Arena Card
; de = card ID
CountTurnDuelistBenchWithActivePkmnPower:
	push hl
	push de
	push bc
	ld c, $00
	ld hl, wTempCardID_ce08
	ld [hl], e
	inc hl
	ld [hl], d
	ld a, DUELVARS_ARENA_CARD
	jr CountTurnDuelistPokemonWithActivePkmnPower.bench

; counts how many Pokemon with card ID in de
; is in Turn Duelist's Play Area with its Pkmn Power active
; de = card ID
CountTurnDuelistPokemonWithActivePkmnPower:
	push hl
	push de
	push bc
	ld c, 0
	call CheckArenaCardIDAndHasActivePkmnPower
	jr nc, .bench
	inc c

; if a Bench card is the same as wTempCardID_ce08,
; and its flag 4 is not set, then add to count
.bench
	ld b, PLAY_AREA_BENCH_1
	ldh a, [hWhoseTurn]
	ld h, a
.loop_bench
	ld a, b
	add DUELVARS_ARENA_CARD
	ld l, a
	ld a, [hl]
	cp $ff
	jr z, .tally
	call GetCardIDFromDeckIndex
	ld a, [wTempCardID_ce08 + 0]
	cp e
	jr nz, .next_bench_card
	ld a, [wTempCardID_ce08 + 1]
	cp d
	jr nz, .next_bench_card
	; is input card ID
	ld a, b
	add DUELVARS_ARENA_CARD_FLAGS
	ld l, a
	bit 4, [hl]
	jr nz, .next_bench_card
	inc c
.next_bench_card
	inc b
	jr .loop_bench

.tally
	ld a, c
	or a
	scf
	jr nz, .at_least_1
	or a
.at_least_1
	pop bc
	pop de
	pop hl
	ret

; returns carry if turn duelist's Arena card
; is the card in input registers de,
; is not affected either by a status condition or by Stare
CheckArenaCardIDAndHasActivePkmnPower:
	ld hl, wTempCardID_ce08
	ld [hl], e
	inc hl
	ld [hl], d
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	cp $ff
	jr z, .false
	call GetCardIDFromDeckIndex
	ld hl, wTempCardID_ce08
	ld a, [hli]
	cp e
	jr nz, .false
	ld a, [hl]
	cp d
	jr nz, .false
	ld a, DUELVARS_ARENA_CARD_STATUS
	get_turn_duelist_var
	and CNF_SLP_PRZ
	jr nz, .false
	ld l, DUELVARS_ARENA_CARD_FLAGS
	bit AFFECTED_BY_STARE_F, [hl]
	jr nz, .false
; true
	scf
	ret
.false
	or a
	ret

; clears some SUBSTATUS2 conditions from the turn holder's active Pokemon.
; more specifically, those conditions that reduce the damage from an attack
; or prevent the opposing Pokemon from attacking the substatus condition inducer.
ClearDamageReductionSubstatus2:
	ld a, DUELVARS_ARENA_CARD_SUBSTATUS2
	get_turn_duelist_var
	or a
	ret z
	cp SUBSTATUS2_REDUCE_BY_20
	jr z, .zero
	cp SUBSTATUS2_POUNCE
	jr z, .zero
	cp SUBSTATUS2_GROWL
	jr z, .zero
	cp SUBSTATUS2_TAIL_WAG
	jr z, .zero
	cp SUBSTATUS2_LEER
	jr z, .zero
	ret
.zero
	ld [hl], 0
	ret

; clears the SUBSTATUS1 and updates the double damage condition of the player about to start his turn
UpdateSubstatusConditions_StartOfTurn:
	xor a
	ld [wcc1a], a
	ld [wcd0c], a

	; reset bit flag 3 in all Play Area Pokémon
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	ld c, a
	ld l, DUELVARS_ARENA_CARD_FLAGS
.loop_play_area
	res PLAY_AREA_FLAG_UNK_3_F, [hl]
	inc hl
	dec c
	jr nz, .loop_play_area

	ld a, DUELVARS_ARENA_CARD_SUBSTATUS3
	get_turn_duelist_var
	res SUBSTATUS3_UNK_6_F, [hl]

	ld a, DUELVARS_ARENA_CARD_SUBSTATUS3
	get_turn_duelist_var
	bit SUBSTATUS3_UNK_5_F, [hl]
	ret nz
	ld l, DUELVARS_ARENA_CARD_SUBSTATUS1
	ld [hl], $00
	ret

; clears the SUBSTATUS2, Headache, and updates the double damage condition of the player ending his turn
UpdateSubstatusConditions_EndOfTurn:
	ld a, DUELVARS_ARENA_CARD_FLAGS
	get_turn_duelist_var
	ld c, MAX_PLAY_AREA_POKEMON
.loop_play_area
	res AFFECTED_BY_STARE_F, [hl]
	inc l
	dec c
	jr nz, .loop_play_area

	; reset Goop Gas attack flag
	ld hl, wGoopGasAttackActive
	ld a, [hl]
	or a
	jr z, .goop_gas_attack_not_active
	dec [hl]
.goop_gas_attack_not_active

	ld a, DUELVARS_ARENA_CARD_SUBSTATUS3
	get_turn_duelist_var
	res SUBSTATUS3_HEADACHE_F, [hl]
	res SUBSTATUS3_SPOOKIFY_F, [hl]
	res SUBSTATUS3_PERPLEX_F, [hl]

	bit SUBSTATUS3_UNK_5_F, [hl]
	jr z, .asm_71d0
	res SUBSTATUS3_UNK_4_F, [hl]
	res SUBSTATUS3_UNK_5_F, [hl]
	jr .reset_substatus2
.asm_71d0
	bit SUBSTATUS3_UNK_4_F, [hl]
	jr z, .reset_substatus2
	set SUBSTATUS3_UNK_5_F, [hl]

.reset_substatus2
	ld a, DUELVARS_ARENA_CARD_SUBSTATUS2
	get_turn_duelist_var
	ld [hl], $00
	ret

; return carry if turn player cannot draw due to Perplex
CheckIfCannotDrawDueToPerplex:
	ld a, DUELVARS_ARENA_CARD_SUBSTATUS3
	get_turn_duelist_var
	bit SUBSTATUS3_PERPLEX_F, [hl]
	jr nz, .perplex_active
	or a
	ret
.perplex_active
	ldtx hl, UnableToDrawCardDueToPerplexText
	scf
	ret

; checks if Goop Gas Attack is active and if so,
; returns carry and a = $1
; otherwise, checks for Muk in Play Area with Pkmn Power active
; and if there is at least 1, return carry and a = $0
CheckGoopGasAttackAndToxicGasActive:
	ld a, [wGoopGasAttackActive]
	or a
	jr nz, .goop_gas_attack_active
	push de
	ld de, MUK
	call CountPokemonWithActivePkmnPowerInBothPlayAreas
	pop de
	ld a, $00
	ldtx hl, UnableDueToToxicGasText
	ret
.goop_gas_attack_active
	ld a, $01
	ldtx hl, UnableDueToGoopGasAttackText
	scf
	ret

; return carry if turn holder has Blastoise and its Rain Dance Pkmn Power is active
IsRainDanceActive:
	ld de, BLASTOISE_LV52
	call CountTurnDuelistPokemonWithActivePkmnPower
	jr c, .has_rain_dance
	ld de, BLASTOISE_ALT_LV52
	call CountTurnDuelistPokemonWithActivePkmnPower
	jr c, .has_rain_dance
	ret
.has_rain_dance
	call CheckGoopGasAttackAndToxicGasActive
	ccf
	ret

; return carry if card at [hTempCardIndex_ff98] is a water energy card AND
; if card at [hTempPlayAreaLocation_ff9d] is a water Pokemon card.
CheckRainDanceScenario:
	ldh a, [hTempCardIndex_ff98]
	call GetCardIDFromDeckIndex
	call GetCardType
	cp TYPE_ENERGY_WATER
	jr nz, .no_carry
	ldh a, [hTempPlayAreaLocation_ff9d]
	call GetPlayAreaCardColor
	cp TYPE_PKMN_WATER
	jr nz, .no_carry
	scf
	ret
.no_carry
	or a
	ret

Func_7234:
	call HandleDestinyBondSubstatus
	call HandleFinalBeam
	ret

; if the defending (non-turn) card's HP is 0 and the attacking (turn) card's HP
;  is not, the attacking card faints if it was affected by destiny bond
HandleDestinyBondSubstatus:
	ld a, [wcd0b]
	cp SUBSTATUS1_DESTINY_BOND
	ret nz

	ld a, DUELVARS_ARENA_CARD
	call GetNonTurnDuelistVariable
	cp -1
	ret z
	ld a, [wccef]
	add DUELVARS_ARENA_CARD_HP
	call GetNonTurnDuelistVariable
	or a
	ret nz

	; don't apply Destiny Bond if target is in Bench
	; and Articuno's Aurora Veil is active
	ld a, [wcd0a]
	ld [wTempPlayAreaLocation_cceb], a
	call CheckArticunoAuroraVeil
	jr c, .draw_text_box_and_exit

	ld a, [wcd0a]
	add DUELVARS_ARENA_CARD_HP
	get_turn_duelist_var
	or a
	ret z
	ld [hl], 0
	call DrawDuelMainScene
	call DrawDuelHUDs
	ld a, [wcd0a]
	add DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call LoadCardDataToBuffer2_FromDeckIndex
	ld hl, wLoadedCard2Name
	ld a, [hli]
	ld h, [hl]
	ld l, a
	call LoadTxRam2
	ldtx hl, KnockedOutDueToDestinyBondText
.draw_text_box_and_exit
	call DrawWideTextBox_WaitForInput
	ret

HandleFinalBeam:
	; exit if turn holder's Arena cards has no HP
	ld a, [wcd0a]
	add DUELVARS_ARENA_CARD_HP
	get_turn_duelist_var
	or a
	ret z

	; exit if the knock out was due to Pkmn Power
	ld a, [wLoadedAttackCategory]
	cp POKEMON_POWER
	ret z

	; look for Dark Gyarados in Bench with 0 HP
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	call GetNonTurnDuelistVariable
	ld c, a
	ld b, PLAY_AREA_ARENA
.loop_play_area
	push bc
	ld a, [wcd0a]
	add DUELVARS_ARENA_CARD_HP
	get_turn_duelist_var
	or a
	jr z, .next_card
	ld a, b
	add DUELVARS_ARENA_CARD_HP
	call GetNonTurnDuelistVariable
	or a
	jr nz, .next_card ; has HP, skip

	; check if this card in Dark Gyarados
	call SwapTurn
	ld a, b
	add DUELVARS_ARENA_CARD
	get_turn_duelist_var
	ld de, $0
	cp $ff
	call nz, GetCardIDFromDeckIndex
	call SwapTurn
	cp16 DARK_GYARADOS
	jr nz, .next_card

	; check if it can use its Pkmn Power
	ld a, b
	call SwapTurn
	call CheckIsIncapableOfUsingPkmnPower
	call SwapTurn
	jr c, .next_card
	pop bc
	push bc
	call .ProcessFinalBeam
.next_card
	pop bc
	inc b
	dec c
	jr nz, .loop_play_area
	ret

.ProcessFinalBeam:
	; count all Water and Rainbow energy cards attached
	call SwapTurn
	ld a, b
	ld [wTempPlayAreaLocation_cceb], a
	ld e, b
	call GetPlayAreaCardAttachedEnergies
	ld a, [wAttachedEnergies + RAINBOW]
	ld hl, wAttachedEnergies + WATER
	add [hl]
	ld [wTotalAttachedEnergies], a
	call SwapTurn
	or a
	ret z ; no attached Water energy cards

	; wTotalAttachedEnergies = (Water + Rainbow energy cards)
	call SwapTurn
	ld a, b
	add DUELVARS_ARENA_CARD_FLAGS
	get_turn_duelist_var
	set AFFECTED_BY_STARE_F, [hl]
	xor a
	ld [wDuelDisplayedScreen], a

	; flip a coin to determine if successful
	ldtx de, FinalBeamSuccessCheckText
	call TossCoin
	call SwapTurn
	ret nc ; not successful

	ld a, [wTotalAttachedEnergies]
	ld l, a
	ld h, 20
	call HtimesL ; does (20 * wTotalAttachedEnergies) damage
	push hl
	call DrawDuelMainScene
	pop de
	ld a, [wcd0a]
	call LoadPlayAreaCardID_ToTempNonTurnDuelistCardID
	call SwapTurn
	ld a, [wTempPlayAreaLocation_cceb]
	call LoadPlayAreaCardID_ToTempTurnDuelistCardID
	ld a, [wcd0a]
	ld c, a
	ld a, [wTempPlayAreaLocation_cceb]
	ld b, a
	call DamageCalculation
	call SwapTurn
	ld l, e
	ld h, d
	bit 7, h
	jr z, .non_negative
	ld hl, 0 ; at least 0 damage
.non_negative
	ldtx de, ReceivedDamageDueToFinalBeamText
	call Func_7518
	call nc, WaitForWideTextBoxInput
	ret
; 0x7352

SECTION "Bank 1@7518", ROMX[$7518], BANK[$1]

; hl = damage
; de = text ID
Func_7518:
	push hl
	call LoadTxRam3
	ld a, e
	ld [wce0a + 0], a
	ld a, d
	ld [wce0a + 1], a
	ld hl, wTempTurnDuelistCardID
	ld e, [hl]
	inc hl
	ld d, [hl]
	call LoadCardDataToBuffer2_FromCardID
	ld hl, wLoadedCard2Name
	ld a, [hli]
	ld h, [hl]
	ld l, a
	call LoadTxRam2

	ld a, [wcd0a]
	add DUELVARS_ARENA_CARD_HP
	get_turn_duelist_var
	pop de
	push af
	push hl
	call SubtractHP
	ld hl, wce0a
	ld a, [hli]
	ld h, [hl]
	ld l, a
	call DrawWideTextBox_PrintText
	pop hl
	pop af
	or a
	ret z
	call WaitForWideTextBoxInput
	ld a, [wcd0a]
	call PrintPlayAreaCardKnockedOutIfNoHP
	call DrawDuelHUDs
	scf
	ret

; return the turn holder's arena card's color in a, accounting for Venomoth's Shift Pokemon Power if active
GetArenaCardColor::
	xor a

; input: a = play area location offset (PLAY_AREA_*) of the desired card
; return the turn holder's card's color in a, accounting for Venomoth's Shift Pokemon Power if active
GetPlayAreaCardColor::
	push hl
	push de
	ld e, a
	add DUELVARS_ARENA_CARD_CHANGED_TYPE
	get_turn_duelist_var
	bit HAS_CHANGED_COLOR_F, a
	jr nz, .has_changed_color
.regular_color
	ld a, e
	add DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call GetCardIDFromDeckIndex
	call GetCardType
	cp TYPE_TRAINER
	jr nz, .got_type
	ld a, COLORLESS
.got_type
	pop de
	pop hl
	ret
.has_changed_color
	ld a, e
	call CheckIsIncapableOfUsingPkmnPower
	jr c, .regular_color ; jump if can't use Shift
	ld a, e
	add DUELVARS_ARENA_CARD_CHANGED_TYPE
	get_turn_duelist_var
	pop de
	pop hl
	and $f
	ret

; return in a the weakness of the turn holder's Play Area Pokemon
; if [DUELVARS_ARENA_CARD_CHANGED_WEAKNESS] != 0, return it instead
; input:
; - a = PLAY_AREA_* constant
GetArenaOrBenchCardWeakness:
	or a
	jr z, GetArenaCardWeakness
	add DUELVARS_ARENA_CARD
	jr GetPlayAreaCardWeakness

GetArenaCardWeakness::
	ld a, DUELVARS_ARENA_CARD_CHANGED_WEAKNESS
	get_turn_duelist_var
	or a
	ret nz
	ld a, DUELVARS_ARENA_CARD
;	fallthrough

GetPlayAreaCardWeakness:
	get_turn_duelist_var
	call LoadCardDataToBuffer2_FromDeckIndex
	ld a, [wLoadedCard2Weakness]
	ret

; return in a the resistance of the turn holder's Play Area Pokemon
; if [DUELVARS_ARENA_CARD_CHANGED_RESISTANCE] != 0, return it instead
; input:
; - a = PLAY_AREA_* constant
GetArenaOrBenchCardResistance:
	or a
	jr z, GetArenaCardResistance
	add DUELVARS_ARENA_CARD
	jr GetPlayAreaCardResistance

GetArenaCardResistance::
	ld a, DUELVARS_ARENA_CARD_CHANGED_RESISTANCE
	get_turn_duelist_var
	or a
	ret nz
	ld a, DUELVARS_ARENA_CARD
	;	fallthrough

GetPlayAreaCardResistance:
	get_turn_duelist_var
	call LoadCardDataToBuffer2_FromDeckIndex
	ld a, [wLoadedCard2Resistance]
	ret

; this function checks if turn holder's CHARIZARD energy burn is active, and if so, turns
; all energies at wAttachedEnergies except double colorless energies into fire energies
HandleEnergyBurn:
	ld a, e
	ld c, a
	add DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call GetCardIDFromDeckIndex
	cp16 CHARIZARD_LV76
	jr z, .has_energy_burn
	cp16 CHARIZARD_ALT_LV76
	ret nz
.has_energy_burn
	ld a, c
	call CheckIsIncapableOfUsingPkmnPower
	ret c
	ld hl, wAttachedEnergies
	ld c, NUM_COLORED_TYPES
	xor a
.zero_next_energy
	ld [hli], a
	dec c
	jr nz, .zero_next_energy
	ld a, [wTotalAttachedEnergies]
	ld [wAttachedEnergies], a
	ret
; 0x75e7

SECTION "Bank 1@7650", ROMX[$7650], BANK[$1]

; returns carry if unable to retreat
CheckUnableToRetreatDueToEffect:
	; can't retreat if affected by sleep or paralysis
	call CheckIfArenaCardIsParalyzedOrAsleep
	ret c

	; can't retreat if opponent has Snorlax lv35
	; and its Pkmn Power is active
	call CheckGoopGasAttackAndToxicGasActive
	jr c, .no_pkmn_powers
	call SwapTurn
	ld de, SNORLAX_LV35
	call CheckArenaCardIDAndHasActivePkmnPower
	call SwapTurn
	ldtx hl, UnableToRetreatDueToGuardText
	jr c, .set_carry ; can just be ret c

.no_pkmn_powers
	; can't retreat if used Drill Dive last turn
	call CheckIfArenaCardUsedDrillDiveLastTurn
	ldtx hl, UnableToRetreatDueToDrillDiveText
	ret c

	; can't retreat if affected by Acid or Rock Seal
	ld a, DUELVARS_ARENA_CARD_SUBSTATUS2
	get_turn_duelist_var
	or a
	jr z, .can_retreat
	ldtx hl, UnableToRetreatDueToAcidText
	cp SUBSTATUS2_ACID
	jr z, .set_carry
	ldtx hl, UnableToRetreatDueToRockSealText
	cp SUBSTATUS2_ROCK_SEAL
	jr z, .set_carry
.can_retreat
	or a
	ret

.set_carry
	scf
	ret

; returns carry if Arena Card's substatus1 is SUBSTATUS1_USED_DRILL_DIVE
CheckIfArenaCardUsedDrillDiveLastTurn:
	ld a, DUELVARS_ARENA_CARD_SUBSTATUS1
	get_turn_duelist_var
	cp SUBSTATUS1_USED_DRILL_DIVE
	jr nz, .no_carry
	scf
	ret
.no_carry
	or a
	ret

; handles Pkmn Powers that trigger when
; an Arena Card retreats to the bench
HandleRetreatPkmnPowers:
	call CheckGoopGasAttackAndToxicGasActive
	ret c
	call .HandleVinePull
	call .HandleSinkhole
	ret

.HandleVinePull:
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call GetCardIDFromDeckIndex
	cp16 DARK_IVYSAUR
	ret nz ; not Dark Ivysaur

	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	call GetNonTurnDuelistVariable
	cp 2
	ret c ; no Bench Pokémon

	ld a, DUELVARS_ARENA_CARD_FLAGS
	get_turn_duelist_var
	and AFFECTED_BY_STARE | USED_PKMN_POWER_THIS_TURN
	ret nz ; Dark Ivysaur cannot use Vine Pull
	set USED_PKMN_POWER_THIS_TURN_F, [hl]

	xor a ; PLAY_AREA_ARENA
	ldh [hTempPlayAreaLocation_ff9d], a
	ld a, $f4
	farcall $6, $4a87
	; select random Bench Pokémon to switch
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	call GetNonTurnDuelistVariable
	dec a
	call Random
	inc a
	call SwapTurn
	ld e, a
	call SwapArenaWithBenchPokemon
	call SwapTurn
	ldtx hl, SwitchedOutDueToVinePullText
	call DrawWideTextBox_WaitForInput
	xor a
	ld [wDuelDisplayedScreen], a
	ret

.HandleSinkhole:
	call SwapTurn
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	ld c, a
	ld b, PLAY_AREA_ARENA
	ld l, DUELVARS_ARENA_CARD
.loop_play_area
	push hl
	push bc
	ld a, [hl]
	call GetCardIDFromDeckIndex
	cp16 DARK_DUGTRIO
	jr nz, .next_card
	ld a, b
	call CheckIsIncapableOfUsingPkmnPower
	jr c, .next_card
	call SwapTurn
	call .DealSinkholeDamage
	call SwapTurn
.next_card
	pop bc
	pop hl
	inc hl
	inc b
	dec c
	jr nz, .loop_play_area
	call SwapTurn
	ret

.DealSinkholeDamage:
	ldtx de, SinkholeCheckText
	call TossCoin
	ret c ; exit if heads
	xor a
	ld [wNoDamageOrEffect], a
	ld a, POKEMON_POWER
	ld [wLoadedAttackCategory], a
	ld a, TRUE
	ld [wIsDamageToSelf], a
	ld a, ATK_ANIM_RECOIL_HIT
	ld [wLoadedAttackAnimation], a
	ld b, PLAY_AREA_ARENA
	ld de, 20
	call DealDamageToPlayAreaPokemon
	xor a
	ld [wDuelDisplayedScreen], a
	ret
; 0x7742

SECTION "Bank 1@7765", ROMX[$7765], BANK[$1]

; return carry if the turn holder is affected by an effect
; that doesn't allow trainer cards to be used
CheckCantUseTrainerDueToEffect:
	ld a, DUELVARS_ARENA_CARD_SUBSTATUS3
	get_turn_duelist_var
	ldtx de, UnableToUseTrainerDueToHeadacheText
	bit SUBSTATUS3_HEADACHE_F, [hl]
	jr nz, .cannot_use
	ldtx de, UnableToUseTrainerDueToSpookifyText
	bit SUBSTATUS3_SPOOKIFY_F, [hl]
	jr nz, .cannot_use
	call CheckGoopGasAttackAndToxicGasActive
	jr c, .skip_hay_fever_check
	; check Dark Vileplume's Hay Fever
	ld de, DARK_VILEPLUME
	call CountPokemonWithActivePkmnPowerInBothPlayAreas
	ldtx hl, UnableToUseTrainerDueToHayFeverText
	ret c
.skip_hay_fever_check
	or a
	ret
.cannot_use
	ld l, e
	ld h, d
	scf
	ret

; return carry if the turn holder's arena Pokemon cannot use
; selected attack at wSelectedAttack due to amnesia
HandleAmnesiaSubstatus:
	ld a, DUELVARS_ARENA_CARD_SUBSTATUS2
	get_turn_duelist_var
	or a
	jr nz, .check_disable
	ret
.check_disable
	ldtx de, UnableToUseAttackDueToDisableText
	cp SUBSTATUS2_DISABLE
	jr z, .affected_by_disable_or_amnesia
	ldtx de, UnableToUseAttackDueToAmnesiaText
	cp SUBSTATUS2_AMNESIA
	jr z, .affected_by_disable_or_amnesia
.not_the_disabled_atk
	or a
	ret
.affected_by_disable_or_amnesia
	ld a, DUELVARS_ARENA_CARD_DISABLED_ATTACK_INDEX
	get_turn_duelist_var
	ld a, [wSelectedAttack]
	cp [hl]
	jr nz, .not_the_disabled_atk
	ld l, e
	ld h, d
	scf
	ret

; return carry if any duelist has Aerodactyl and its Prehistoric Power Pkmn Power is active
IsPrehistoricPowerActive:
	ld de, AERODACTYL_LV28
	call CountPokemonWithActivePkmnPowerInBothPlayAreas
	ret nc
	call CheckGoopGasAttackAndToxicGasActive
	ldtx hl, UnableToEvolveDueToPrehistoricPowerText
	ccf
	ret

; if the id of the card provided in register a as a deck index is MUK,
; clear the changed type of all arena and bench Pokemon
ClearChangedTypesIfMuk:
	call GetCardIDFromDeckIndex
	cp16 MUK
	ret nz
	call .ResetChangedTypes
	ret

.ResetChangedTypes:
	call SwapTurn
	call .zero_changed_types
	call SwapTurn
.zero_changed_types
	ld a, DUELVARS_ARENA_CARD_CHANGED_TYPE
	get_turn_duelist_var
	ld c, MAX_PLAY_AREA_POKEMON
.zero_changed_types_loop
	xor a
	ld [hli], a
	dec c
	jr nz, .zero_changed_types_loop
	ret

; return carry if turn holder has Omanyte and its Clairvoyance Pkmn Power is active
IsClairvoyanceActive:
	call CheckGoopGasAttackAndToxicGasActive
	ccf
	ret nc
	ld de, OMANYTE_LV19
	call CountTurnDuelistPokemonWithActivePkmnPower
	ret

CheckIfArenaCardIsUnableToAttack:
	ld a, DUELVARS_ARENA_CARD_SUBSTATUS2
	get_turn_duelist_var
	or a
	jr z, .skip_check_substatus2

	ldtx hl, UnableToAttackDueToTailWagText
	cp SUBSTATUS2_TAIL_WAG
	jr z, .set_carry
	ldtx hl, UnableToAttackDueToLeerText
	cp SUBSTATUS2_LEER
	jr z, .set_carry
	ldtx hl, UnableToAttackDueToBoneAttackText
	cp SUBSTATUS2_BONE_ATTACK
	jr z, .set_carry

.skip_check_substatus2
	call CheckIfArenaCardUsedDrillDiveLastTurn
	ldtx hl, UnableToAttackDueToDrillDiveText
	ret c ; cannot attack due to Drill Dive

	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call GetCardIDFromDeckIndex
	cp16 SLOWBRO_LV35
	jr z, .slowbro_lv35
	call CheckIfArenaCardIsParalyzedOrAsleep
	ret

.slowbro_lv35
	; Slowbro lv35 can potentially select an attack
	; while asleep, so only return carry if it's paralyzed
	ld a, DUELVARS_ARENA_CARD_STATUS
	get_turn_duelist_var
	and CNF_SLP_PRZ
	cp PARALYZED
	jr z, .set_carry
	or a
	ret
.set_carry
	; bug, missing load text ID into hl
	; ldtx hl, UnableDueToParalysisText
	scf
	ret

; returns carry if turn holder's Arena Card is paralyzed or asleep
; and outputs in hl text to display accordingly
CheckIfArenaCardIsParalyzedOrAsleep:
	ld a, DUELVARS_ARENA_CARD_STATUS
	get_turn_duelist_var
	and CNF_SLP_PRZ
	cp PARALYZED
	jr z, .paralyzed
	cp ASLEEP
	jr z, .asleep
	or a
	ret
.paralyzed
	ldtx hl, UnableDueToParalysisText
	jr .has_status_condition
.asleep
	ldtx hl, UnableDueToSleepText
.has_status_condition
	scf
	ret
; 0x784a

SECTION "Bank 1@7881", ROMX[$7881], BANK[$1]

; return carry if turn duelist's Arena Card
; is protected from Status Conditions
CheckIfArenaCardIsProtectedFromStatusCondition:
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call GetCardIDFromDeckIndex

	; Clefairy Doll and Mysterious Fossil cannot be statused
	cp16 CLEFAIRY_DOLL
	jr z, .return_carry
	cp16 MYSTERIOUS_FOSSIL
	jr z, .return_carry

	; Snorlax lv20 cannot be statused if its Pkmn Power is active
	cp16 SNORLAX_LV20
	jr nz, .check_chlorophyll
	push de
	xor a
	call CheckIsIncapableOfUsingPkmnPower
	pop de
	jr c, .check_chlorophyll
.return_carry
	scf
	ret

.check_chlorophyll
	; Grass Pokémon cannot be statused if Chlorophyll is active
	ld a, [wSpecialRule]
	cp CHLOROPHYLL
	jr z, .chlorophyll_active
	or a
	ret
.chlorophyll_active
	call GetArenaCardColor
	cp GRASS
	jr z, .return_carry
	or a
	ret

; returns carry if weakness should not be applied
; in the current damage calculation
CheckWhetherToApplyWeakness::
	call HandleFlameArmorWaterWeakness
	ret c ; don't apply Water weakness on Fire types
	call CheckGoopGasAttackAndToxicGasActive
	jr c, .no_pkmn_powers
	call CheckIfDampeningShieldIsActive
	ret c ; Dampening Shield active, no Weakness/Resistance
	call .SwapTurnIfNotDamageToSelf
	call GetDefendingCardType
	call .SwapTurnIfNotDamageToSelf
	cp TYPE_PKMN_GRASS
	jr nz, .no_pkmn_powers
	call .CheckGreenShield
	ret c ; no Weakness/Resistance to Grass Pokémon
.no_pkmn_powers
	call .SwapTurnIfNotDamageToSelf
	ld a, DUELVARS_ARENA_CARD_SUBSTATUS3
	get_turn_duelist_var
	call .SwapTurnIfNotDamageToSelf
	bit SUBSTATUS3_UNK_6_F, a
	jr z, .no_carry
	call .Func_78f2
	ret c
.no_carry
	or a
	ret

.Func_78f2:
	call .SwapTurnIfNotDamageToSelf
	call GetDefendingCardType
	call .SwapTurnIfNotDamageToSelf
	cp TYPE_PKMN_WATER
	jr nz, .no_carry
	scf
	ret

.CheckGreenShield:
	call .SwapTurnIfNotDamageToSelf
	push de
	ld de, METAPOD_LV20
	call CountTurnDuelistPokemonWithActivePkmnPower
	pop de
	call .SwapTurnIfNotDamageToSelf
	ret

.SwapTurnIfNotDamageToSelf:
	push af
	ld a, [wIsDamageToSelf]
	or a
	call z, SwapTurn
	pop af
	ret

; returns carry if resistance should not be applied
; in the current damage calculation
CheckWhetherToApplyResistance::
	call HandleEarthPowerRockResistance
	ret c ; don't apply Fighting resistance
	call CheckGoopGasAttackAndToxicGasActive
	ccf
	ret nc
	call CheckIfDampeningShieldIsActive
	ret

; checks in both duelists' Bench whether Mr. Mime lv20
; exists and has its Pkmn Power active
; if there is at least one, return carry
CheckIfDampeningShieldIsActive:
	push de
	push bc
	ld de, MR_MIME_LV20
	call CountTurnDuelistBenchWithActivePkmnPower
	ld c, a
	call SwapTurn
	ld de, MR_MIME_LV20
	call CountTurnDuelistBenchWithActivePkmnPower
	call SwapTurn
	add c
	jr z, .no_carry
	scf
.no_carry
	pop bc
	pop de
	ret

Func_7943:
	ld a, [wcd0c]
	or a
	ret z
	ld a, DUELVARS_ARENA_CARD_HP
	call GetNonTurnDuelistVariable
	or a
	ret z ; hp == 0
	call SwapTurn
	call CheckIfArenaCardIsProtectedFromStatusCondition
	jr c, .no_poison
	ld e, $00
	call Func_6f49
	jr c, .no_poison
	ld a, DUELVARS_ARENA_CARD_STATUS
	get_turn_duelist_var
	ld [hl], POISONED
	xor a
	ld [wcd0c], a
.no_poison
	call SwapTurn
	ret

Func_796b:
	call CheckGoopGasAttackAndToxicGasActive
	ccf
	ret nc
	call .Func_797f
	jr c, .done
	call SwapTurn
	call .Func_797f
	call SwapTurn
.done
	ret

.Func_797f:
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	ld c, a
	ld b, PLAY_AREA_ARENA
	ld l, DUELVARS_ARENA_CARD_FLAGS
.loop_play_area_pkmn
	bit PLAY_AREA_FLAG_UNK_3_F, [hl]
	jr z, .next_pkmn
	push hl
	push bc
	ld a, b
	call CheckIsIncapableOfUsingPkmnPower
	pop bc
	pop hl
	ccf
	ret c
.next_pkmn
	inc l
	inc b
	dec c
	jr nz, .loop_play_area_pkmn
	or a
	ret

; de = damage
HandlePrehistoricDreamDamageBoost:
	ld a, [wcc1a]
	or a
	ret z ; no boost
	ld a, [wIsDamageToSelf]
	or a
	ret nz
	call CheckGoopGasAttackAndToxicGasActive
	ret c ; can't use Pkmn Power

	; check if the attacking Pokémon
	; is a fossil card, by checking its Pokédex number
	ld hl, wTempTurnDuelistCardID
	push de
	ld e, [hl]
	inc hl
	ld d, [hl]
	call LoadCardDataToBuffer2_FromCardID
	pop de
	ld a, [wLoadedCard2PokedexNumber]
	cp DEX_OMANYTE
	jr c, .not_fossil_card
	cp DEX_AERODACTYL + 1
	jr nc, .not_fossil_card
	ld a, [wcc1a]
	call ATimes10
	add e
	ld e, a
	ld a, 0
	adc d
	ld d, a
.not_fossil_card
	ret

; returns carry if Articuno lv34 is Arena Card and its Pkmn Power is active,
; and if the attack target is a card in the Bench
CheckArticunoAuroraVeil:
	ld a, [wLoadedAttackCategory]
	cp POKEMON_POWER
	jr z, .no_carry
	ld a, [wTempPlayAreaLocation_cceb]
	or a
	jr z, .no_carry
	push de
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call GetCardIDFromDeckIndex
	cp16 ARTICUNO_LV34
	pop de
	jr nz, .no_carry
	call CheckIsIncapableOfUsingPkmnPower_ArenaCard
	jr c, .no_carry
	ld a, $07
	ld [wNoDamageOrEffect], a
	ldtx hl, NoDamageOrEffectDueToAuroraVeilText
	scf
	ret
.no_carry
	or a
	ret
; 0x79fd

SECTION "Bank 1@7a2d", ROMX[$7a2d], BANK[$1]

; returns carry if:
; - turn duelist has a Hypno lv30 in the Play Area;
; - Hypno is able to use its Pkmn Power;
; - Hypno has enough energy to pay for its Mind Shock attack
CheckHypnoPuppetMaster:
	push hl
	ldh a, [hWhoseTurn]
	ld hl, wWhoseTurn
	cp [hl]
	jr nz, .no_carry
	ld b, PLAY_AREA_ARENA - 1
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
.loop_play_area
	inc b
	ld a, [hli]
	cp $ff
	jr z, .no_carry
	call GetCardIDFromDeckIndex
	cp16 HYPNO_LV30
	jr nz, .loop_play_area
	; is Hypno lv30, check if it can use its Pkmn Power
	push hl
	push bc
	ld a, b
	call CheckIsIncapableOfUsingPkmnPower
	pop bc
	pop hl
	jr c, .loop_play_area ; not able to use, skip

	; Hypno lv30 is in Play Area, check if it
	; has enough energy to pay for its Mind Shock attack
	; loop through all card locations and count
	; how many Rainbow or Psychic energy cards
	; are attached to the found Play Area location
	push hl
	push de
	ld a, b
	or CARD_LOCATION_ARENA
	ld e, a
	ld c, 0 ; tracks the energy count
	ld a, DUELVARS_CARD_LOCATIONS
	get_turn_duelist_var
.loop_card_locations
	ld a, [hl]
	cp e
	jr nz, .next_card_location
	push de
	ld a, l
	call GetCardIDFromDeckIndex
	cp16 RAINBOW_ENERGY
	jr z, .check_energy
	cp16 PSYCHIC_ENERGY
.check_energy
	pop de
	jr nz, .next_card_location
	inc c
.next_card_location
	inc l
	ld a, l
	cp DECK_SIZE
	jr c, .loop_card_locations
	; no more cards to check, tally energy count
	pop de
	pop hl
	ld a, c ; number of energy cards
	cp 2
	jr c, .loop_play_area
	; enough energy
	pop hl
	scf
	ret
.no_carry
	pop hl
	or a
	ret

; de = damage
HandleThunderChargeDamageBoost:
	ld a, [wSpecialRule]
	cp THUNDER_CHARGE
	ret nz ; Thunder Charge not active
	call GetAttackingCardType
	cp TYPE_PKMN_LIGHTNING
	ret nz ; not a lightning card
	ld a, [wIsDamageToSelf]
	or a
	ret nz
	ld a, [wLoadedAttackCategory]
	cp POKEMON_POWER
	ret z
	; add boost
	ld hl, 10
	add hl, de
	ld e, l
	ld d, h
	ret

; returns carry if Flame Armor rule is active
; and if the attacking Pokémon is Water type
; and the defending Pokémon is Fire Type
HandleFlameArmorWaterWeakness:
	ld a, [wSpecialRule]
	cp FLAME_ARMOR
	jr z, .is_active
.no_carry
	or a
	ret

.is_active
	; no carry if attacking Pokémon is Water
	call GetAttackingCardType
	cp TYPE_PKMN_WATER
	jr nz, .no_carry
	; no carry if defending Pokémon is Fire
	call SwapTurn
	call GetDefendingCardType
	call SwapTurn
	cp TYPE_PKMN_FIRE
	jr nz, .no_carry
	scf
	ret

; returns carry if Earth Power rule is active
; and if the attacking Pokémon is Fighting type
HandleEarthPowerRockResistance:
	ld a, [wSpecialRule]
	cp EARTH_POWER
	jr z, .is_active
.no_carry
	or a
	ret

.is_active
	push de
	call GetAttackingCardType
	pop de
	cp TYPE_PKMN_FIGHTING
	jr nz, .no_carry
	scf
	ret
; 0x7ae6

SECTION "Bank 1@7b00", ROMX[$7b00], BANK[$1]

GetDefendingCardType:
	ld hl, wTempNonTurnDuelistCardID
	call GetPlayAreaPokemonType
	ret nc
	ld a, [wccd9]
;	fallthrough
Func_7b0a:
	call GetPlayAreaCardColor
	ret

GetAttackingCardType:
	ld hl, wTempTurnDuelistCardID
	call GetPlayAreaPokemonType
	ret nc
	; is Venomoth, get its color
	ld a, [wccd8]
	jr Func_7b0a

; gets type of Pokémon with ID given in [hl]
; if it's Venomoth lv28, then get its color
; taking into account Color Change
GetPlayAreaPokemonType:
	push de
	ld e, [hl]
	inc hl
	ld d, [hl]
	cp16 VENOMOTH_LV28
	jr z, .is_venomoth
	call GetCardType
	cp TYPE_TRAINER
	jr nz, .not_trainer
	ld a, TYPE_PKMN_COLORLESS
.not_trainer
	pop de
	or a
	ret
.is_venomoth
	pop de
	scf
	ret

; outputs -30 in hl if it's a normal duel,
; outputs -10 in hl if using Low Resistance rule
GetResistanceModifier::
	ld hl, -30
	ld a, [wSpecialRule]
	cp LOW_RESISTANCE
	ret nz
	ld hl, -10
	ret

GetPoisonDamage:
	ld a, DUELVARS_ARENA_CARD_STATUS
	get_turn_duelist_var
	and DOUBLE_POISONED
	ret z
	cp DOUBLE_POISONED
	ld a, DBLPSN_DAMAGE
	ret z
	push de
	call Func_796b
	pop de
	ld a, PSN_DAMAGE
	ret nc
	ld a, DBLPSN_DAMAGE
	ret

; seems to communicate with other device
; for starting a duel
; outputs in hl either wPlayerDuelVariables
; or wOpponentDuelVariables depending on wSerialOp
DecideLinkDuelVariables:
	call SerialDeclarePeerMaster
	ldtx hl, PressStartWhenReadyText
	call DrawWideTextBox_PrintText
	call EnableLCD
.input_loop
	call DoFrame
	ldh a, [hKeysPressed]
	bit B_PAD_B, a
	jr nz, .link_cancel
	and PAD_START
	call Serial_Func_0be6
	jr nc, .input_loop
	ld hl, wPlayerDuelVariables
	ld a, [wSerialOp]
	cp SERIAL_OP_MASTER_TCG2
	jr z, .link_continue
	ld hl, wOpponentDuelVariables
	cp SERIAL_PEER_MASTER_TCG2
	jr z, .link_continue
.link_cancel
	call ResetSerial
	scf
	ret
.link_continue
	or a
	ret

; stray ret
	ret
; 0x7b8f
