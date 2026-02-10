INCLUDE "macros.asm"
INCLUDE "constants.asm"

INCLUDE "vram.asm"

SECTION "WRAM0", WRAM0

UNION

wTempCardCollection:: ; c000
	ds CARD_COLLECTION_SIZE

NEXTU

wc000:: ; c000
	ds $100

NEXTU

; aside from wDecompressionBuffer, which stores the
; de facto final decompressed data after decompression,
; this buffer stores a secondary buffer that is used
; for "lookbacks" when repeating byte sequences.
; actually starts in the middle of the buffer,
; at wDecompressionSecondaryBufferStart, then wraps back up
; to wDecompressionSecondaryBuffer.
; this is used so that $00 can be "looked back", since anything
; before $ef is initialized to 0 when starting decompression.
wDecompressionSecondaryBuffer:: ; c000
	ds $ef
wDecompressionSecondaryBufferStart:: ; c0ef
	ds $11

NEXTU

; names of the last players who have done
; Card Pop! with current save file
wCardPopNameList:: ; c000
	ds CARDPOP_NAME_LIST_SIZE

NEXTU

; candidate cards for Card Pop! to randomly choose
wCardPopCandidateList:: ; c000
	ds CARD_COLLECTION_SIZE

NEXTU

; buffer to store a target deck
wDeckToBuild:: ; c000
	ds DECK_BIG_TEMP_BUFFER_SIZE

ENDU

SECTION "WRAM0 Duels 1", WRAM0

UNION

wPlayerDuelVariables::   duel_vars wPlayer   ; c200
wOpponentDuelVariables:: duel_vars wOpponent ; c300

NEXTU

; buffer used to store the Card Pop! name list
; that is received from the other player
wOtherPlayerCardPopNameList:: ; c200
	ds CARDPOP_NAME_LIST_SIZE

ENDU

wPlayerDeck:: ; c400
	ds $80

wOpponentDeck:: ; c480
	ds $80

; this holds names like player's or opponent's.
wNameBuffer:: ; c500
	ds NAME_BUFFER_LENGTH

; this holds an $ff-terminated list of card deck indexes (e.g. cards in hand or in bench)
; or (less often) the attack list of a Pokemon card
wDuelTempList:: ; c510
	ds $80

; this is kept updated with some default text that is used
; when the text printing functions are called with text id $0000
wDefaultText:: ; c590
	ds $3c

	ds $1e

; signals what error, if any, occurred
; during IR communications
; 0 means there was no error
wIRCommunicationErrorCode:: ; c5ea
	ds $1

; parameters set for IR communications on own device
; and received from the other device respectively
; these must match for successful communication
wOwnIRCommunicationParams:: ; c5eb
wOwnIRCommunicationMode:: ; c5eb
	ds $1
wOwnIRCommunicationMagicString:: ; c5ec
	ds IR_MAGIC_STRING_SIZE

wOtherIRCommunicationParams:: ; c5ef
wOtherIRCommunicationMode:: ; c5ef
	ds $1
wOtherIRCommunicationMagicString:: ; c5f0
	ds IR_MAGIC_STRING_SIZE

; stores the result from LookUpNameInCardPopNameList
; is $ff if name was found in the Card Pop! list
; is $00 otherwise
wCardPopNameSearchResult:: ; c5f3
	ds $1

; information to send to other player in Card Pop!
; bytes 0-1: card ID obtained
; bytes 2-3: number of battles
; bytes 4-5: number of cards owned
; byte 7: number of event coins obtained
wCardPopSummary:: ; c5f4
	ds $7

SECTION "WRAM0 Text Engine", WRAM0

wc600:: ; c600
	ds $100

wc700:: ; c700
	ds $100

wc800:: ; c800
	ds $100

wc900:: ; c900
	ds $100

SECTION "WRAM0 1", WRAM0

wOAM:: ; ca00
	ds $a0

; 16-byte buffer to store text, usually a name or a number
; used by TX_RAM1 but not exclusively
wStringBuffer:: ; caa0
	ds $10

wcab0:: ; cab0
	ds $1

wcab1:: ; cab1
	ds $1

wcab2:: ; cab2
	ds $1

; initial value of the A register. used to tell the console when reset
wInitialA:: ; cab3
	ds $1

; what console we are playing on, either 0 (DMG), 1 (SGB) or 2 (CGB)
; use constants CONSOLE_DMG, CONSOLE_SGB and CONSOLE_CGB for checks
wConsole:: ; cab4
	ds $1

; used to select a sprite or a starting sprite from wOAM
wOAMOffset:: ; cab5
	ds $1

; FillTileMap fills VRAM0 BG Maps with the tile stored here
wTileMapFill:: ; cab6
	ds $1

wIE:: ; cab7
	ds $1

; incremented whenever the vblank handler ends. used to wait for it to end,
; or to delay a specific amount of frames
wVBlankCounter:: ; cab8
	ds $1

	ds $1

; bit0: is in vblank interrupt?
; bit1: is in timer interrupt?
wReentrancyFlag:: ; caba
	ds $1

wBGP:: ; cabb
	ds $1

wOBP0:: ; cabc
	ds $1

wOBP1:: ; cabd
	ds $1

; set to non-0 to request OAM copy during vblank
wVBlankOAMCopyToggle:: ; cabe
	ds $1

; used by HblankWriteByteToBGMap0
wTempByte:: ; cabf
	ds $1

; which screen or interface is currently displayed in the screen during a duel
; used to prevent loading graphics or drawing stuff more times than necessary
wDuelDisplayedScreen:: ; cac0
	ds $1

; used to increase the play time counter every four timer interrupts (60.24 Hz)
wTimerCounter:: ; cac1
	ds $1

wPlayTimeCounterEnable:: ; cac2
	ds $1

; byte0: 1/60ths of a second
; byte1: seconds
; byte2: minutes
; byte3: hours (lower byte)
; byte4: hours (upper byte)
wPlayTimeCounter:: ; cac3
	ds $5

wRNG1:: ; cac8
	ds $1

wRNG2:: ; cac9
	ds $1

wRNGCounter:: ; caca
	ds $1

; the LCDC status interrupt is always disabled and this always reads as jp $0000
wLCDCFunctionTrampoline:: ; cacb
	ds $3

wVBlankFunctionTrampoline:: ; cace
	ds $3

; pointer to a function to be called by DoFrame
wDoFrameFunction:: ; cad1
	ds $2

; if non-zero, the game screen can be paused at any time with the select button
wDebugPauseAllowed:: ; cad3
	ds $1

; pointer to keep track of where
; in the source data we are while
; running the decompression algorithm
wDecompSourcePosPtr:: ; cad4
	ds $2

; number of bits that are still left
; to read from the current command byte
wDecompNumCommandBitsLeft:: ; cad6
	ds $1

; command byte from which to read the bits
; to decompress source data
wDecompCommandByte:: ; cad7
	ds $1

; if bit 7 is changed from off to on, then
; decompression routine will read next two bytes
; for repeating previous sequence (length, offset)
; if it changes from on to off, then the routine
; will only read one byte, and reuse previous length byte
wDecompRepeatModeToggle:: ; cad8
	ds $1

; stores in both nybbles the length of the
; sequences to copy in decompression
; the high nybble is used first, then the low nybble
; for a subsequent sequence repetition
wDecompRepeatLengths:: ; cad9
	ds $1

wDecompNumBytesToRepeat:: ; cada
	ds $1

wDecompSecondaryBufferPtrHigh:: ; cadb
	ds $1

; offset to repeat byte from decompressed data
wDecompRepeatSeqOffset:: ; cadc
	ds $1

wDecompSecondaryBufferPtrLow:: ; cadd
	ds $1

	ds $10

; temporary CGB palette data buffer to eventually save into BGPD registers.
wBackgroundPalettesCGB:: ; caee
	ds NUM_BACKGROUND_PALETTES palettes

wObjectPalettesCGB:: ; cb2e
	ds NUM_OBJECT_PALETTES palettes

SECTION "WRAM0 Serial Transfer", WRAM0

wSerialOp:: ; cb6e
	ds $1

wSerialFlags:: ; cb6f
	ds $1

wSerialCounter:: ; cb70
	ds $1

wSerialCounter2:: ; cb71
	ds $1

wSerialTimeoutCounter:: ; cb72
	ds $1

; tcg1: wcb79
wcb73:: ; cb73
	ds $2

; tcg1: wcb7b
wcb75:: ; cb75
	ds $2

wSerialSendSave:: ; cb77
	ds $1

wSerialSendBufToggle:: ; cb78
	ds $1

wSerialSendBufIndex:: ; cb79
	ds $1

wcb80:: ; cb7a
	ds $1

wSerialSendBuf:: ; cb7b
	ds $20

wSerialLastReadCA:: ; cb9b
	ds $1

wSerialRecvCounter:: ; cb9c
	ds $1

wcba3:: ; cb9d
	ds $1

wSerialRecvIndex:: ; cb9e
	ds $1

wSerialRecvBuf:: ; cb9f
	ds $20

wSerialEnd:: ; cbbf

SECTION "WRAM0 2", WRAM0

; In a duel, the main menu current or last selected menu item
; From 0 to 5: Hand, Attack, Check, Pkmn Power, Retreat, Done
wCurrentDuelMenuItem:: ; cbbf
	ds $1

; When we're viewing a card's information, the page we are currently at.
; For Pokemon cards, values from $1 to $6 (two pages for attack descriptions)
; For Energy cards, it's always $9
; For Trainer cards, $d or $e (two pages for trainer card descriptions)
; see CARDPAGE_* constants
wCardPageNumber:: ; cbc0
	ds $1

; how many selectable items are in a play area screen. used to set wNumMenuItems
; in order to navigate through a play area screen. this becomes the number of bench
; Pokemon cards if wExcludeArenaPokemon is 1, and that number plus 1 if it's 0.
wNumPlayAreaItems:: ; cbc1
	ds $1

; selects a PLAY_AREA_* slot in order to display information related to it. used by functions
; such as PrintPlayAreaCardLocation, PrintPlayAreaCardInformation and PrintPlayAreaCardHeader
wCurPlayAreaSlot:: ; cbc2

; X position to display the attached energies, HP bar, and PlusPower/Defender icons
; obviously different for player and opponent side. used by DrawDuelHUD.
wHUDEnergyAndHPBarsX:: ; cbc2
	ds $1

; current Y coordinate where some play area information is being printed at. used by functions
; such as PrintPlayAreaCardLocation, PrintPlayAreaCardInformation and PrintPlayAreaCardHeader
wCurPlayAreaY:: ; cbc3

; current Y coordinate where some play area information is being printed at. used by functions
; such as PrintPlayAreaCardLocation, PrintPlayAreaCardInformation and PrintPlayAreaCardHeader
wHUDEnergyAndHPBarsY:: ; cbc3

wPracticeDuelTextY:: ; cbc3
	ds $1

; selected bench slot (1-5, that is, a PLAY_AREA_BENCH_* constant)
wBenchSelectedPokemon:: ; cbc4
	ds $1

; used by CheckIfEnoughEnergiesToRetreat and DisplayRetreatScreen
wEnergyCardsRequiredToRetreat:: ; cbc5
	ds $1

wNumRetreatEnergiesSelected:: ; cbc6
	ds $1

	ds $1

; when you're in a duel submenu like the cards in your hand and you press A,
; the following two addresses keep track of which item was selected by the cursor
wSelectedDuelSubMenuItem:: ; cbc8
	ds $1

	ds $1

; CARDPAGETYPE_PLAY_AREA or CARDPAGETYPE_NOT_PLAY_AREA
; some of the elements displayed in a card page change depending on which value
wCardPageType:: ; cbca
	ds $1

; when processing or displaying the play area Pokemon cards of a duelist,
; whether to account for only the benched Pokemon ($01) or also the arena Pokemon ($00).
wExcludeArenaPokemon:: ; cbcb
	ds $1

wPlayAreaScreenLoaded:: ; cbcc
	ds $1

; determines what to do when player presses the Select button
; while viewing the Play Area:
; - if $0 or $2: no action
; - if $1: menu is accessible where player can examine Hand or other screens
; $2 is reserved for OpenVariousPlayAreaScreens_FromSelectPresses
wPlayAreaSelectAction:: ; cbcd
	ds $1

; low byte of the address of the next slot in the hTempRetreatCostCards array to be used
wTempRetreatCostCardsPos:: ; cbce
	ds $1

; in a card list, which keys (among START and A) do not open the item selection
; menu when a card is selected, directly "submitting" the selected card instead.
wNoItemSelectionMenuKeys:: ; cbcf
	ds $1

; when viewing a card page, which keys (among B, D_UP, and D_DOWN) will exit the page,
; either to go back to the previous menu or list, or to load the card page of the card above/below it
wCardPageExitKeys:: ; cbd0
	ds $1

; used to store function pointer for printing card order
; in card list reordering screen.
wPrintSortNumberInCardListPtr:: ; cbd1
	ds $2

; in the hand or discard pile card screen, id of the text printed in the bottom-left box
wCardListInfoBoxText:: ; cbd3
	ds $2

; in the hand or discard pile card screen, id of the text printed as the header title
wCardListHeaderText:: ; cbd5
	ds $2

; when selecting an item of a list of cards which type of menu shows up.
; PLAY_CHECK, SELECT_CHECK, or $00 for none.
wCardListItemSelectionMenuType:: ; cbd7
	ds $1

; flag indicating whether a list of cards should be sorted by ID
wSortCardListByID:: ; cbd8
	ds $1

wAttachedEnergyMenuPlayAreaLocation:: ; cbd9
	ds $1

SECTION "WRAM0 Duels 2", WRAM0

wOppRNG1:: ; cbda
	ds $1

	ds $2

; sp is saved here when starting a duel, in order to save the return address
; however, it only seems to be read after a transmission error in a link duel
wDuelReturnAddress:: ; cbdd
	ds $2

; if non-zero, duel menu input is not checked
wDebugSkipDuelMenuInput:: ; cbdf
	ds $1

	ds $2

; temporarily stores 8 bytes for serial send/recv.
; used by SerialSend8Bytes and SerialRecv8Bytes
wTempSerialBuf:: ; cbe2
	ds $8

	ds $1

wcbeb:: ; cbeb
	ds $1

wAttachedEnergyMenuDenominator:: ; cbec
	ds $1

wAttachedEnergyMenuNumerator:: ; cbed

; number of selections already done in BenchMultiSelectMenu
wPlayAreaMultiSelectMenuNumSelections:: ; cbed
	ds $1

; text ID to show in the Attached Energy screen
wAttachedEnergyMenuTextID:: ; cbee
	ds $2

; used by TurnDuelistTakePrizes to store the remaining Prizes, so that if more than that
; amount would be taken, only the remaining amount is taken
wTempNumRemainingPrizeCards:: ; cbf0
	ds $1

; if FALSE, player is placing initial arena pokemon
; if TRUE, player is placing initial bench pokemon
wPlacingInitialBenchPokemon:: ; cbf1
	ds $1

; during a practice duel, identifies an entry of PracticeDuelActionTable
wPracticeDuelAction:: ; cbf2
	ds $1

wDuelMainSceneSelectHotkeyAction:: ; cbf3
	ds $1

wPracticeDuelTurn:: ; cbf4
	ds $1

wcbf5:: ; cbf5
	ds $1

	ds $6

; used when opening the card page of an attack when attacking,
; serving as an index for AttackPageDisplayPointerTable.
; see ATTACKPAGE_* constants
wAttackPageNumber:: ; cbfc
	ds $1

; the value of hWhoseTurn gets loaded here at the beginning of each duelist's turn.
; more reliable than hWhoseTurn, as hWhoseTurn may change temporarily in order to handle status
; conditions or other events of the non-turn duelist. used mostly between turns (to check which
; duelist's turn just finished), or to restore the value of hWhoseTurn at some point.
wWhoseTurn:: ; cbfd
	ds $1

; number of turns taken by both players
wDuelTurns:: ; cbfe
	ds $1

; used to signal that the current duel has finished, not to be mistaken with wDuelResult
; 0 = no one has won duel yet
; 1 = player whose turn it is has won the duel
; 2 = player whose turn it is has lost the duel
; 3 = duel ended in a draw (start sudden death match)
wDuelFinished:: ; cbff
	ds $1

; current duel is a [wDuelInitialPrizes]-prize match
wDuelInitialPrizes:: ; cc00
	ds $1

; maximum number of Pokémon in Play Area
; normally it's 6, but when dueling with the
; Small Bench rule, it's reduced to 4
wMaxNumPlayAreaPokemon:: ; cc01
	ds $1

; a DUELTYPE_* constant. note that for a practice duel, wIsPracticeDuel must also be set to $1
wDuelType:: ; cc02
	ds $1

; set to 1 if the coin toss during the CheckSandAttackSmokescreenOrLightningFlashSubstatus check is heads
wGotHeadsFromSandAttackSmokescreenOrLightningFlashCheck:: ; cc03
	ds $1

wAlreadyPlayedEnergy:: ; cc04
	ds $1

; set to 1 if the confusion check coin toss in AttemptRetreat is heads
wGotHeadsFromConfusionCheckDuringRetreat:: ; cc05
	ds $1

wGoopGasAttackActiveTurns:: ; cc06
	ds $1

; if TRUE, then Prize Cards are turned face up
; set to TRUE by the effects of Here Comes Team Rocket!
wPrizeCardsFaceUp:: ; cc07
	ds $1

; DUELIST_TYPE_* of the turn holder
wDuelistType:: ; cc08
	ds $1

; this holds the current opponent's deck minus 2 (that is, a *_DECK_ID constant),
; in order to account for the two unused pointers at the beginning of DeckPointers.
wOpponentDeckID:: ; cc09
	ds $1

wcc0f:: ; cc0a
	ds $1

; index (0-1) of the attack or Pokemon Power being used by the player's arena card
; set to $ff when the duel starts and at the end of the opponent's turn
wPlayerAttackingAttackIndex:: ; cc0b
	ds $1

; deck index of the player's arena card that is attacking or using a Pokemon Power
; set to $ff when the duel starts and at the end of the opponent's turn
wPlayerAttackingCardIndex:: ; cc0c
	ds $1

; ID of the player's arena card that is attacking or using a Pokemon Power
wPlayerAttackingCardID:: ; cc0d
	ds $2

wIsPracticeDuel:: ; cc0f
	ds $1

; index of special rules for this duel
wSpecialRule:: ; cc10
	ds $1

	ds $1

wOpponentPicID:: ; cc12
	ds $1

; text id of the opponent's name
wOpponentName:: ; cc13
	ds $2

wNPCDuelPrizes:: ; cc15
	ds $1

wNPCDuelDeckID:: ; cc16
	ds $1

; song played during a duel
wDuelTheme:: ; cc17
	ds $1

; which coin the opponent is using for this duel
; holds a COIN_* constant
wOppCoin:: ; cc18
	ds $1

; which coin the player is using for this duel
; holds a COIN_* constant
wPlayerCoin:: ; cc19
	ds $1

; increments each time turn-holder uses Prehistoric Dream
; attack by a "Fossil" Pokémon will be boosted by 10 * this amount
wPrehistoricDreamBoost:: ; cc1a
	ds $1

; to keep track on the result of the coin toss when using Mini-Metronome
; -1 means the coin hasn't been tossed yet, 0 means it was tails, 1 was heads
wMiniMetronomeCoinTossResult:: ; cc1b
	ds $1

	ds $5

wAttackEnergyCost:: ; cc21
	ds NUM_TYPES

; holds the energies attached to a given pokemon card. 1 byte for each of the
; 8 energy types (includes the unused one that shares byte with the colorless energy)
wAttachedEnergies:: ; cc29
	ds NUM_TYPES

; holds the total amount of energies attached to a given pokemon card
wTotalAttachedEnergies:: ; cc31
	ds $1

; Used as temporary storage for a card's data
wLoadedCard1:: ; cc32
	card_data_struct wLoadedCard1
wLoadedCard2:: ; cc74
	card_data_struct wLoadedCard2
wLoadedAttack:: ; ccb6
	atk_data_struct wLoadedAttack

; the damage field of a used attack is loaded here
; doubles as "wAIAverageDamage" when complementing wAIMinDamage and wAIMaxDamage
; little-endian
; second byte may have UNAFFECTED_BY_WEAKNESS_RESISTANCE_F set/unset
wDamage:: ; ccc9
	ds $2

; wAIMinDamage and wAIMaxDamage appear to be used for AI scoring
; they are updated with the minimum (or floor) damage of the current attack
; and with the maximum (or ceiling) damage of the current attack
wAIMinDamage:: ; cccb
	ds $1

wAIMaxDamage:: ; cccc
	ds $1

; only written, never read
wccbd:: ; cccd
	ds $2

; damage dealt by an attack to a target
wDealtDamage:: ; cccf
	ds $2

; WEAKNESS and RESISTANCE flags for a damaging attack
wDamageEffectiveness:: ; ccd1
	ds $1

; used in damage related functions
wTempCardID_ccc2:: ; ccd2
	ds $2

wTempTurnDuelistCardID:: ; ccd4
	ds $2

wTempNonTurnDuelistCardID:: ; ccd6
	ds $2

wccd8:: ; ccd8
	ds $1

wccd9:: ; ccd9
	ds $1

; the status condition of the defending Pokemon is loaded here after an attack
wccc5:: ; ccda
	ds $1

; *_ATTACK constants for selected attack
; 0 for the first attack (or PKMN Power)
; 1 for the second attack
wSelectedAttack:: ; ccdb
	ds $1

; if affected by a no damage or effect substatus, this flag indicates what the cause was
wNoDamageOrEffect:: ; ccdc
	ds $1

; used by CountKnockedOutPokemon and TurnDuelistTakePrizes to store the amount
; of prizes to take (equal to the number of Pokemon knocked out)
wNumberPrizeCardsToTake:: ; ccdd
	ds $1

; set to 1 if the coin toss in the confusion check is heads (CheckSelfConfusionDamage)
wGotHeadsFromConfusionCheck:: ; ccde
	ds $1

; used to store card indices of all stages, in order, of a Play Area Pokémon
wAllStagesIndices:: ; ccdf
	ds $3

wEffectFunctionsFeedbackIndex:: ; cce2
	ds $1

; some array used in effect functions with wEffectFunctionsFeedbackIndex
; as the index, used to return feedback. unknown length.
wEffectFunctionsFeedback:: ; cce3
	ds $18

; this is 1 (non-0) if dealing damage to self due to confusion
; or a self-destruct type attack
wIsDamageToSelf:: ; ccfb
	ds $1

wccfc:: ; ccfc
	ds $1

wDuelFinishParam:: ; cce8
	ds $1

wOpponentDeckName:: ; ccfe
	ds $2

; a PLAY_AREA_* constant (0: arena card, 1-5: bench card)
wTempPlayAreaLocation_cceb:: ; cd00
	ds $1

wccec:: ; cd01
	ds $1

; used by the effect functions to return the cause of an effect to fail
; in order print the appropriate text
wEffectFailed:: ; cd02
	ds $1

wPreEvolutionPokemonCard:: ; cd03
	ds $1

; whether or not current Arena card was switched due to an effect
wForcedSwitchPlayAreaLocation:: ; cd04
	ds $1

; stores the energy cost of the Metronome attack being used.
; it's used to know how many attached Energy cards are being used
; to pay for the attack for damage calculation.
; if equal to 0, then the attack wasn't invoked by Metronome.
wMetronomeEnergyCost:: ; cd05
	ds $1

; effect functions return a status condition constant here when it had no effect
; on the target, in order to print one of the ThereWasNoEffectFrom* texts
wNoEffectFromWhichStatus:: ; cd06
	ds $1

; used to check whether deck indices are within range
wDeckSize:: ; cd07
	ds $1

; when non-0, allows the player to skip some delays during a duel by pressing B.
; value read from sSkipDelayAllowed. probably only used for debugging.
wSkipDelayAllowed:: ; cd08
	ds $1

wTurnEndedDueToComputerError:: ; cd09
	ds $1

wcd0a:: ; cd0a
	ds $1

wcd0b:: ; cd0b
	ds $1

wKnockedOutByGasExplosion:: ; cd0c
	ds $1

wcd0d:: ; cd0d
	ds $1

; DECK_REQUIREMENT_* constant for the current duel
wDeckRequirement:: ; cd0e
	ds $1

; DUELIST_INTRO_* constant for the current duel
wDuelistIntroText:: ; cd0f
	ds $1

; values used by Dark Wave and Darkness Veil
; determined in SetDarkWaveAndDarknessVeilDamageModifiers
wDarkWaveAndDarknessVeilDamageModifiers::
wDarkWaveDamageModifier:: ; cd10
	ds $2
wDarknessVeilDamageModifier:: ; cd12
	ds $2

wcd14:: ; cd14
	ds $1

wcd15:: ; cd15
	ds $1

; if TRUE, then attack selected with Metronome/Mini-Metronome
; does not have its requirements met in order to be used
wMetronomeAttackCannotBeUsed:: ; cd16
	ds $1

wcd17:: ; cd17
	ds $1

wcd18:: ; cd18
	ds $1

; when non-0, AIMakeDecision doesn't wait 60 frames and print DuelistIsThinkingText
wSkipDuelistIsThinkingDelay:: ; cd19
	ds $1

; return address for when the Link Opponent has
; made a decision on his turn, so that the duel continues
wLinkOpponentTurnReturnAddress:: ; cd1a
	ds $2

wNumCardsTryingToDraw:: ; cd1c
	ds $1

; number of cards being drawn in order to animate the number of cards in
; the hand and in the deck in the draw card screen
wNumCardsBeingDrawn:: ; cd1d
	ds $1

wOpponentTurnEnded:: ; cd1e
	ds $1

; stores the amount of cards that are being ordered.
wNumberOfCardsToOrder:: ; cd1f
	ds $1

	ds $1

wCardSearchFunc:: ; cd21
	ds $1

wCardSearchFuncParam:: ; cd22
	ds $2

wDeckDiagnosisTextIDsPtr:: ; cd24
	ds $2

wDeckDiagnosisMenuStepSelected:: ; cd26
	ds $1

; number of steps unlocked for
; the Deck Diagnosis menu
wNumDeckDiagnosisSteps:: ; cd27
	ds $1

wDeckDiagnosisStep:: ; cd28
	ds $1

wcd29:: ; cd29
	ds $1

wDeckDiagnosisAdvice:: ; cd2a
	ds $1

wcd2b:: ; cd2b
	ds $2

wDeckCheckCardCounts:: ; cd2d

wDeckCheckEnergyCount:: ; cd2d
	ds $1

wDeckCheckBasicCount:: ; cd2e
	ds $1

wDeckCheckStage1Count:: ; cd2f
	ds $1

wDeckCheckStage2Count:: ; cd30
	ds $1

wDeckCheckTrainerCount:: ; cd31
	ds $1

wDeckCheckEnergyCounts:: ; cd32
	ds NUM_TYPES

wDeckCheckPkmnCounts:: ; cd3a
	ds NUM_TYPES

wDeckCheckEnergySurplus:: ; cd42
	ds NUM_TYPES

wDeckCheckRainbowEnergyCount:: ; cd4a
	ds $1

wDeckCheckCardCountsEnd::

wcd4b:: ; cd4b
	ds $1

wcd4c:: ; cd4c
	ds $1

wDeckCheckTotalEnergyRequirement:: ; cd4d
	ds $1

wcd4e:: ; cd4e
	ds $1

wDeckCheckTotalEnergySurplus:: ; cd4f
	ds $1

; is equal to number of colorless cards in deck divided by
; the number of unique Pokémon types in deck (rounded up)
wDeckCheckColorlessCardsPerType:: ; cd50
	ds $1

wcd51:: ; cd51
	ds $1

wcd52:: ; cd52
	ds $1

wcd53:: ; cd53
	ds $1

wcd54:: ; cd54
	ds $1

wcd55:: ; cd55
	ds $1

wDeckCheckCardName:: ; cd56
	ds $2

; these are counts for a single evolutionary line
; counts basic, stage 1 and stage 2 cards
wDeckCheckCurBasicCount:: ; cd58
	ds $1

wDeckCheckCurStage1Count:: ; cd59
	ds $1

wDeckCheckCurStage2Count:: ; cd5a
	ds $1

SECTION "WRAM0 3", WRAM0

; on CGB, attributes of the text box borders. (values 0-7 seem to be used, which only affect palette)
; on SGB, colorize text box border with SGB1 if non-0
wTextBoxFrameType:: ; cd5b
	ds $1

wcd5c:: ; cd5c
	ds $1

; pixel data of a tile used for text
; either a combination of two half-width characters or a full-width character
wTextTileBuffer:: ; cd5d
	ds TILE_SIZE

wcd04:: ; cd6d
	ds $1

; used by PlaceNextTextTile
wCurTextTile:: ; cd6e
	ds $1

; VRAM tile patterns selector for text tiles
; if wTilePatternSelector == $80 and wTilePatternSelectorCorrection == $00 -> select tiles at $8000-$8FFF
; if wTilePatternSelector == $88 and wTilePatternSelectorCorrection == $80 -> select tiles at $8800-$97FF
wTilePatternSelector:: ; cd6f
	ds $1

; complements wTilePatternSelector by correcting the VRAM tile order when $8800-$97FF is selected
; a value of $80 in wTilePatternSelectorCorrection reflects tiles $00-$7f being located after tiles $80-$ff
wTilePatternSelectorCorrection:: ; cd70
	ds $1

; if 0, text lines are separated by a blank line
wLineSeparation:: ; cd71
	ds $1

; line number in which text is being printed as an offset to
; the topmost line, including separator lines
wCurTextLine:: ; cd72
	ds $1

; how to process the current text tile
; 0: full-width font | non-0: half-width font
wFontWidth:: ; cd73
	ds $1

; when printing half-width text, this variable alternates between 0 and the value
; of the first character. 0 signals that no text should be printed in the current
; iteration of Func_235e, while non-0 means to print the character pair
; made of [wHalfWidthPrintState] (first char) and register e (second char).
wHalfWidthPrintState:: ; cd74
	ds $1

; used by CopyTextData
wTextMaxLength:: ; cd75
	ds $1

; half-width font letters become uppercase if non-0, lowercase if 0
wUppercaseHalfWidthLetters:: ; cd76
	ds $1

wcd77:: ; cd77
	ds $1

wcd78:: ; cd78
	ds $1

; During a duel, this is always $b after the first attack.
; $b is the bank where the functions associated to card or effect commands are.
; Its only purpose seems to be store this value to be read by TryExecuteEffectCommandFunction.
; possibly used in other contexts too
wEffectFunctionsBank:: ; cd79
	ds $1

wCardPalettes:: ; cd7a
	ds 3 palettes

wCardAttrMap:: ; cd92
	ds $30

; information about the text being currently processed, including font width,
; the rom bank, and the memory address of the next character to be printed.
; supports up to four nested texts (used with TX_RAM).
wTextHeader1:: ; cdc2
	text_header wTextHeader1
wTextHeader2:: ; cdc7
	text_header wTextHeader2
wTextHeader3:: ; cdcc
	text_header wTextHeader3
wTextHeader4:: ; cdd1
	text_header wTextHeader4

; text id for the first TX_RAM2 of a text
; prints from wDefaultText if $0000
wTxRam2:: ; cdd6
	ds $2

; text id for the second TX_RAM2 of a text
wTxRam2_b:: ; cdd8
	ds $2

; text id for the first TX_RAM3 of a text
; a number between 0 and 65535
wTxRam3:: ; cdda
	ds $2

; text id for the second TX_RAM3 of a text
; a number between 0 and 65535
wTxRam3_b:: ; cddc
	ds $2

; when printing text, number of frames to wait between each text tile
; derived from wMessageSpeedSetting
wTextSpeed:: ; cdde
	ds $1

; a number between 0 and 3 to select a wTextHeader to use for the current text
wWhichTextHeader:: ; cddf
	ds $1

; selects wTxRam2 or wTxRam2_b
wWhichTxRam2:: ; cde0
	ds $1

; selects wTxRam3 or wTxRam3_b
wWhichTxRam3:: ; cde1
	ds $1

wIsTextBoxLabeled:: ; cde2
	ds $1

; text id of a text box's label
wTextBoxLabel:: ; cde3
	ds $2

wcde5:: ; cde5
	ds $2

wCoinTossScreenTextID:: ; cde7
	ds $2

; which routine in ExecutePrinterPacketSequence to run
wPrinterPacketSequence:: ; cde9
	ds $1

wPrinterPacket:: ; cdea

wPrinterPacketPreamble::
	ds $2

wPrinterPacketInstructions:: ; cdec
	ds $2

wPrinterPacketDataSize:: ; cdee
	ds $2

; pointer to memory of data to send
; in the data packet to the printer
wPrinterPacketDataPtr:: ; cdf0
	ds $2

wPrinterPacketChecksum:: ; cdf2
	ds $2

wSerialTransferData:: ; cdf4
	ds $1

wPrinterStatus:: ; cdf5
	ds $1

; pointer to packet data that is
; being transmitted through serial
wSerialDataPtr:: ; cdf6
	ds $2

; keeps track of which Bench Pokemon is pointed
; by the cursor during Gigashock selection screen
wCurGigashockItem:: ; cdf8
	ds $1

; card index and its attack index chosen
; to be used by Metronome.
wMetronomeSelectedAttack:: ; cdf9
	ds $2

wBackupPlayerAreaHP:: ; cdfb
	ds MAX_PLAY_AREA_POKEMON

wce01:: ; ce01
	ds $1

; holds misc values corresponding to each Play Area card
; (e.g. how many times each card is selected to be damaged)
wPlayAreaList:: ; ce02
	ds MAX_PLAY_AREA_POKEMON

wTempCardID_ce08:: ; ce08
	ds $2

wce0a:: ; ce0a
	ds $2

wce0c:: ; ce0c
	ds $1

; stores the real Retreat cost of a card
; taking into account Pkmn Powers and Special Rules
wEffectiveRetreatCost:: ; ce0d
	ds $1

wVBlankFunctionTrampolineBackup:: ; ce0e
	ds $2

wTempPrinterSRAM:: ; ce10
	ds $1

wPrinterHorizontalOffset:: ; ce11
	ds $1

; the count of some card ID in the deck to be printed
wPrinterCardCount:: ; ce12
	ds $1

; total card count of list to be printed
wPrinterTotalCardCount:: ; ce13
	ds $2

wCurPrinterCardType:: ; ce15
	ds $1

; total card count of the current card type
; in list to be printed
wPrinterCurCardTypeCount:: ; ce16
	ds $2

wPrinterNumCardTypes:: ; ce18
	ds $2

; related to printer functions
; only written to but never read
wce98:: ; ce1a
	ds $1

wPrinterContrastLevel:: ; ce1b
	ds $1

wPrinterCurPrizeFrame:: ; ce1c
	ds $1

wPrinterNumberLineFeeds:: ; ce1d
	ds $1

wPrintOnlyStarRarity:: ; ce1e
	ds $1

; only used in unreferenced function Func_1a14b
; otherwise unused
wce9d:: ; ce1f
	ds $1

wPrinterInitAttempts:: ; ce20
	ds $1

wce9f:: ; ce21
	ds $1

; which song to play when obtaining the card from Card Pop!
; the card's rarity determines which song to play
wCardPopCardObtainSong:: ; ce22
	ds $1

	ds $2

; either IRPARAM_CARD_POP or IRPARAM_RARE_CARD_POP
wCardPopType:: ; ce25
	ds $1

; whether the player has cleared the game
wClearedGame:: ; ce26
	ds $1

wce27:: ; ce27
	ds $1

wce28:: ; ce28
	ds $1

wce29:: ; ce29
	ds $1

wce2a:: ; ce2a
	ds $1

wNumCardPopRecords:: ; ce2b
	ds $1

wCardPopRecord:: ; ce2c

wCardPopRecordName:: ; ce2c
	ds NAME_BUFFER_LENGTH

wCardPopRecordYourCardID:: ; ce3c
	ds $2

wCardPopRecordTheirCardID:: ; ce3e
	ds $2

wCardPopRecordStats:: ; ce40
wCardPopRecordNumBattles:: ; ce40
	ds $2

wCardPopRecordNumCards:: ; ce42
	ds $2

wCardPopRecordNumCoins:: ; ce44
	ds $1

; either IRPARAM_CARD_POP or IRPARAM_RARE_CARD_POP
wCardPopRecordType:: ; ce45
	ds $1

	ds $6 ; padding to align to $20

wTempBankWRAM:: ; ce4c
	ds $1

wWRAMBank:: ; ce4d
	ds $1

wTargetBGPalettes:: ; ce4e
	ds NUM_BACKGROUND_PALETTES palettes

wTargetOBPalettes:: ; ce8e
	ds NUM_OBJECT_PALETTES palettes

wBGColorFadeConfigList:: ; cece
	ds (NUM_BACKGROUND_PALETTES palettes) / 2

wOBColorFadeConfigList:: ; ceee
	ds (NUM_OBJECT_PALETTES palettes) / 2

SECTION "WRAM1", WRAMX

; stores a pointer to a temporary list of elements (e.g. pointer to wDuelTempList)
; to be read or written sequentially
wListPointer:: ; d000
	ds $2

wListPointer2:: ; d002
	ds $2

	ds $7

; handles timing of (horizontal or vertical) arrow blinking while waiting for user input.
wCursorBlinkCounter:: ; d00b
	ds $1

wCurMenuItem:: ; d00c
	ds $1

wCursorXPosition:: ; d00d
	ds $1

wCursorYPosition:: ; d00e
	ds $1

wYDisplacementBetweenMenuItems:: ; d00f
	ds $1

wNumScrollMenuItems:: ; d010
	ds $1

wCursorTile:: ; d011
	ds $1

wTileBehindCursor:: ; d012
	ds $1

; if non-$0000, the function loaded here is called once per frame by HandleMenuInput
wMenuFunctionPointer:: ; d013
	ds $2

wListScrollOffset:: ; d015
	ds $1

wListItemXPosition:: ; d016
	ds $1

wNumListItems:: ; d017
	ds $1

wListItemNameMaxLength:: ; d018
	ds $1

; if non-$0000, the function loaded here is called once per frame by CardListMenuFunction,
; which is the function loaded to wMenuFunctionPointer for card lists
wListFunctionPointer:: ; d019
	ds $2

; in a card list, the Y position where the <sel_item>/<num_items> indicator is placed
; if wCardListIndicatorYPosition == $ff, no indicator is displayed
wCardListIndicatorYPosition:: ; d01b
	ds $1

; x coord of the leftmost item in a horizontal menu
wLeftmostItemCursorX:: ; d01c
	ds $1

; used in RefreshMenuCursor_CheckPlaySFX to play a sound during any frame when this address is non-0
wRefreshMenuCursorSFX:: ; d01d
	ds $1

; when printing a YES/NO menu, whether the cursor is
; initialized to the YES ($01) or to the NO ($00) item
wDefaultYesOrNo:: ; d01e
	ds $1

; stores the total number of coins to flip
wCoinTossTotalNum:: ; d01f
	ds $1

; this stores the result from a coin toss (number of heads)
wCoinTossNumHeads:: ; d020
	ds $1

; stores type of the duelist that is tossing coins
wCoinTossDuelistType:: ; d021
	ds $1

; holds the number of coins that have already been tossed
wCoinTossNumTossed:: ; d022
	ds $1

wAIDuelVars::
; saves the prizes that the AI already used Peek on
; each bit corresponds to a Prize card
wAIPeekedPrizes:: ; d023
	ds $1

; this is used by AI in order to determine whether
; it should use Pokedex Trainer card.
; starts with 5 when Duel starts and counts up by 1 every turn.
; only when it's higher than 5 is AI allowed to use Pokedex,
; in which case it sets the counter to 0.
; this stops the AI from using Pokedex right after using another one
; while still drawing cards that were ordered.
wAIPokedexCounter:: ; d024
	ds $1

; variable to keep track of MewtwoLv53's Barrier usage during Player' turn.
; AI_MEWTWO_MILL set means Player is running MewtwoLv53 mill deck.
; 	- when flag is not set, this counts how many turns in a row
;	  Player used MewtwoLv53's Barrier attack;
;	- when flag is set, this counts how many turns in a row
;	  Player has NOT used Barrier attack.
wAIBarrierFlagCounter:: ; d025
	ds $1

; pointer to $00-terminated list of card IDs
; to avoid being placed as prize cards
; when setting up AI duelist's cards at duel start.
; (see SetUpBossStartingHandAndDeck)
wAICardListAvoidPrize:: ; d026
	ds $2

; pointer to $00-terminated list of card IDs
; sorted by priority of AI placing in the Arena
; at duel start (see TrySetUpBossStartingPlayArea)
wAICardListArenaPriority:: ; d028
	ds $2

; pointer to $00-terminated list of card IDs
; sorted by priority of AI placing in the Bench
; at duel start (see TrySetUpBossStartingPlayArea)
wAICardListBenchPriority:: ; d02a
	ds $2

; pointer to $00-terminated list of card IDs
; sorted by priority of AI playing it from Hand
; to the Bench (see AIDecidePlayPokemonCard)
wAICardListPlayFromHandPriority:: ; d02c
	ds $2

; pointer to $00-terminated list of card IDs and AI scores.
; these are for giving certain cards more or less
; likelihood of being picked by AI to switch to.
; (see AIDecideBenchPokemonToSwitchTo)
wAICardListRetreatBonus:: ; d02e
	ds $2

; pointer to $00-terminated list of card IDs,
; number of energy cards and AI score.
; these are for giving certain cards more or less
; likelihood of being picked for AI to attach energy.
; also has the maximum number of energy cards that
; the AI is willing to provide for it.
; (see AIProcessEnergyCards)
wAICardListEnergyBonus:: ; d030
	ds $2

wd032:: ; d032
	ds $1

wd033:: ; d033
	ds $1

wd034:: ; d034
	ds $1

wd035:: ; d035
	ds $1

wd036:: ; d036
	ds $1

wd037:: ; d037
	ds $1

wd038:: ; d038
	ds $1

	ds $a

wAIDuelVarsEnd::

	ds $1

; when AI decides which Bench Pokemon to switch to
; it stores it Play Area location here.
wAIPlayAreaCardToSwitch:: ; d044
	ds $1

; the index of attack chosen by AI
; to use with PlusPower.
wAIPlusPowerAttack:: ; d045
	ds $1

; whether AI is allowed to play an energy card
; from the hand in order to retreat arena card
;	FALSE = not allowed
;	TRUE  = allowed
wAIPlayEnergyCardForRetreat:: ; d046
	ds $1

; flags defined by AI_ENERGY_FLAG_* constants
; used as input for AIProcessEnergyCards
; to determine what to check in the routine.
wAIEnergyAttachLogicFlags:: ; d047
	ds $1

; used as input to AIProcessAttacks.
; if 0, execute the attack chosen by the AI.
; if not 0, return without executing attack.
wAIExecuteProcessedAttack:: ; d048
	ds $1

; flags used by AI for retreat logic
; if bit 0 set, then it means the current Pokémon
; can KO the defending card with one of its attacks
; if bit 7 is set, then it means the switch is due
; to the effect of an attack (not Pkmn Power)
wAIRetreatFlags:: ; d049
	ds $1

wAITriedAttack:: ; d04a
	ds $1

wcddc:: ; d04b
	ds $1

; used to temporarily backup wPlayAreaAIScore values.
wTempPlayAreaAIScore:: ; cd04c
	ds MAX_PLAY_AREA_POKEMON

	ds $1

; used for AI decisions that involve
; each card in the Play Area involving
; attaching Energy cards.
wPlayAreaEnergyAIScore:: ; d053
	ds MAX_PLAY_AREA_POKEMON

wSamePokemonEnergyScore:: ; d059
	ds MAX_PLAY_AREA_POKEMON

wd05f:: ; d05f
	ds $1

; used by AI to store variable information
wTempAI:: ; d060
	ds $1

wd061:: ; d061
	ds $1

; used to temporarily store the card deck index
; while AI is deciding whether to evolve Pokémon
; or deciding whether to play Pokémon card from hand
wTempAIPokemonCard:: ; d062
	ds $1

wd063:: ; d063
	ds $1

	ds $4

wSamePokemonCardID:: ; d068
	ds $2

UNION

wSamePokemonEnergyScoreHandled:: ; d06a
	ds MAX_PLAY_AREA_POKEMON

NEXTU

wd06a:: ; d06a
	ds $1

wd06b:: ; d06b
	ds $1

ENDU

wAIFirstAttackDamage:: ; d070
	ds $1
wAISecondAttackDamage:: ; d071
	ds $1

wd072:: ; d072
	ds $1

wd073:: ; d073
	ds $1

wd074:: ; d074
	ds $1

wd075:: ; d075
	ds $1

wd076:: ; d076
	ds $1

	ds $2

wd079:: ; d079
	ds $1

	ds $1

wd07b:: ; d07b
	ds $1

wd07c:: ; d07c
	ds $1

; whether AI already retreated this turn or not.
;	- $0 has not retreated;
;	- $1 has retreated.
wAIRetreatedThisTurn::  ; d07d
	ds $1

; used by AI to store information of VenusaurLv67
; while handling Energy Trans logic.
wAIVenusaurLv67DeckIndex::  ; d07e
	ds $1

wd07f:: ; d07f
	ds $1

wAIRetreatConsiderStatus:: ; d080
	ds $1

wd081:: ; d081
	ds $1

; number of Basic Pokemon cards when
; setting up AI Boss deck
wAISetupBasicPokemonCount:: ; d082
wd082:: ; d082
	ds $1

	ds $1

; number of Energy cards when
; setting up AI Boss deck
wAISetupEnergyCount:: ; d084
wAIPkmnPowerUserCardIndex:: ; d084
wd084:: ; d084
	ds $1

	ds $d

; stores the deck index (0-59) of the Trainer card
; the AI intends to play from hand.
wAITrainerCardToPlay:: ; d092
	ds $1

; temporarily stores the card ID from AITrainerCardLogic
; to compare with the card in AI's hand
wAITrainerLogicCard:: ; d093
	ds $2

wAITrainerCardPhase:: ; d095
	ds $1

; parameters output by AI Trainer card logic routines
; (e.g. what Pokemon in Play Area to use card on, etc)
wAITrainerCardParameter:: ; d096
	ds $1

	ds $6

; used to store previous/current flags of AI actions
; see AI_FLAG_* constants
wPreviousAIFlags:: ; d09d
	ds $1
wCurrentAIFlags:: ; d09e
	ds $1

; information about various properties of
; loaded attack for AI calculations
wTempLoadedAttackEnergyCost:: ; d09f
	ds $1
wTempLoadedAttackEnergyNeededType:: ; d0a0
	ds $1
wTempLoadedAttackEnergyNeededAmount:: ; d0a1
	ds $1

; used for the AI to store various
; details about a given card
wTempCardRetreatCost:: ; d0a2
	ds $1
wTempCardID_d0a3:: ; d0a3
	ds $2
wTempCardType:: ; d0a5
	ds $1

	ds $3

; used for AI to score decisions for actions
wAIScore:: ; d0a9
	ds $1

UNION

; used for AI decisions that involve
; each card in the Play Area.
wPlayAreaAIScore:: ; d0aa
	ds MAX_PLAY_AREA_POKEMON

NEXTU

; stores the score determined by AI for first attack
wFirstAttackAIScore:: ; d0aa
	ds $1

ENDU

	ds $a

; information about the defending Pokémon and
; the prize card count on both sides for AI:
; player's active Pokémon color
wAIPlayerColor:: ; d0ba
	ds $1
; player's active Pokémon weakness
wAIPlayerWeakness:: ; d0bb
	ds $1
; player's active Pokémon resistance
wAIPlayerResistance:: ; d0bc
	ds $1
; player's prize count
wAIPlayerPrizeCount:: ; d0bd
	ds $1
; opponent's prize count
wAIOpponentPrizeCount:: ; d0be
	ds $1

; set to PLAYER_TURN in the "Your Play Area" screen
; set to OPPONENT_TURN in the "Opp Play Area" screen
; alternates when drawing the "In Play Area" screen
wCheckMenuPlayAreaWhichDuelist:: ; d0bf
	ds $1

; apparently complements wCheckMenuPlayAreaWhichDuelist to be able to combine
; the usual player or opponent layout with the opposite duelist information
; appears not to be relevant in the "In Play Area" screen
wCheckMenuPlayAreaWhichLayout:: ; d0c0
	ds $1

wd0c1:: ; d0c1
	ds $1

; pointer to transition table data
wTransitionTablePtr:: ; d0c2
	ds $2

; same as wDuelInitialPrizes but with upper 2 bits set
wDuelInitialPrizesUpperBitsSet:: ; d0c4

wd0c4:: ; d0c4
	ds $1

	ds $3

; number of prize cards still to be
; picked by the player
wNumberOfPrizeCardsToSelect:: ; d0c8
	ds $1

	ds $4

wd0cd:: ; d0cd
	ds $1

	ds $1

; $00 when the "In Play Area" screen has been opened from the Check menu
; $01 when the "In Play Area" screen has been opened by pressing the select button
wInPlayAreaFromSelectButton:: ; d0cf
	ds $1

wd0d0:: ; d0d0
	ds $1

; GLOSSARY_* constant
wGlossaryMenu:: ; d0d1
	ds $1

wd0d2:: ; d0d2
	ds $1

wAttackAnimationIsPlaying:: ; d0d3
	ds $1

wDamageAnimAmount:: ; d0d4
	ds $2

wDamageAnimPlayAreaLocation:: ; d0d6
	ds $1

wDamageAnimEffectiveness:: ; d0d7
	ds $1

wDamageAnimPlayAreaSide:: ; d0d8
	ds $1

; buffer to store data that will be sent/received through IR
wIRDataBuffer:: ; d0d9
	ds $8

wScrollMenuScrollOffset:: ; d0e1
	ds $1

	ds $1

wScrollMenuCursorBlinkCounter:: ; d0e3
wNamingScreenCursorBlinkCounter:: ; d0e3
	ds $1

; used to temporarily store wCurCardTypeFilter
; to check whether a new filter is to be applied
wTempCardTypeFilter:: ; d0e4

wCurScrollMenuItem:: ; d0e4

wNamingScreenCursorY:: ; d0e4
	ds $1

wMenuParams::

wMenuCursorXOffset:: ; d0e5
	ds $1

wMenuCursorYOffset:: ; d0e6
	ds $1

wMenuYSeparation:: ; d0e7
	ds $1

wMenuXSeparation:: ; d0e8
	ds $1

wNumMenuItems:: ; d0e9
wNamingScreenNumRows:: ; d0e9
	ds $1

wMenuVisibleCursorTile:: ; d0ea
	ds $1

wMenuInvisibleCursorTile:: ; d0eb
	ds $1

; if non-NULL, the function loaded here is called once per frame by HandleMenuInput
wMenuUpdateFunc:: ; d0ec
	ds $2

wMenuParamsEnd::

; number of cards that are listed
; in the current filtered list
wNumEntriesInCurFilter::

wBoosterPackCardListSize:: ; d0ee
	ds $1

wCheckMenuCursorXPosition:: ; d0ef
	ds $1

wCheckMenuCursorYPosition:: ; d0f0
	ds $1

; deck selected by the player in the Decks screen
wCurDeck:: ; d0f1
	ds $1

; each of these are a boolean to
; represent whether a given deck
; that the player has is a valid deck
wDecksValid::
wDeck1Valid:: ds $1 ; d0f2
wDeck2Valid:: ds $1 ; d0f3
wDeck3Valid:: ds $1 ; d0f4
wDeck4Valid:: ds $1 ; d0f5

; holds symbols for representing a number in decimal
; goes up in magnitude (first byte is ones place,
; second byte is tens place, etc) up to 5 digits
wDecimalDigitsSymbols:: ; d0f6
	ds $5

UNION

; each of these stores the card count
; of each filter in the deck building screen
; the order follows CardTypeFilters
wCardFilterCounts:: ; d0fb
	ds NUM_FILTERS

NEXTU

; represents which Booster Packs have been
; collected by the player in the Card Album
; - $0 is obtained
; - non-$0 is not obtained yet
wBoosterPackItems:: ; d0fb
	ds NUM_CARD_SETS

ENDU

; buffer used to show which card IDs
; are visible in a given list
wVisibleListCardIDs:: ; d104
	ds $e

; number of visible entries
; when showing a list of cards
wNumVisibleCardListEntries:: ; d112
	ds $1

wTotalCardCount:: ; d113
	ds $1

; is TRUE if list cannot be scrolled down
; past the last visible entry
wUnableToScrollDown:: ; d114
	ds $1

wScrollMenuScrollFunc:: ; d115
	ds $2

; holds y and x coordinates (in that order)
; of start of card list (top-left corner)
wCardListCoords:: ; d117
	ds $2

wd119:: ; d119
	ds $1

; the current filter being used
; from the CardTypeFilters list
wCurCardTypeFilter:: ; d11a
	ds $1

; temporarily stores wCurMenuItem value
wTempCurMenuItem:: ; d11b
	ds $1

wTempFilteredCardListNumCursorPositions:: ; d11c
	ds $1

wd11d:: ; d11d
	ds $1

; tcg1: wced7
wd11e:: ; d11e
	ds $1

wCardListVisibleOffsetBackup:: ; d11f
	ds $1

; stores how many different cards there are in a deck
wNumUniqueCards:: ; d120
	ds $1

; flag for Bill's Computer
wBillsComputerAllowedInCardList:: ; d121
	ds $1

; cards that belong to a Booster Pack
; for showing in the Card Album
wBoosterPackCardList:: ; d122

; temporary card list for multiple purposes
wTempCardList:: ; d122
	ds 2 * 80

	ds $2

; holds cards for the current deck
wCurDeckCards:: ; d1c4
	ds 2 * (DECK_CONFIG_BUFFER_SIZE + 1)

; list of all the different cards in a deck configuration
wUniqueDeckCardList:: ; d266

; stores the count number of cards owned
; can be 0 in the case that a card is not available
; i.e. already inside a built deck
wOwnedCardsCountList:: ; d266

; used by _AIProcessHandTrainerCards, AI related
wTempHandCardList:: ; d266

wBoosterPackCardCounts:: ; d266
	ds $51

	ds $29

; name of the selected deck
wCurDeckName:: ; d2e0

wBoosterPackCardListPrefixBuffer:: ; d2e0
	ds DECK_NAME_SIZE

	ds $6

wTempSavedDeckCards:: ; d2fe
	ds 2 * DECK_SIZE

	ds $a

wDeckBuildingParams:: ; d380

; max number of cards that are allowed
; to include when building a deck configuration
wMaxNumCardsAllowed:: ; d380
	ds $1

wNumValidDeckSize:: ; d381
	ds $1

; max number of cards with same name that are allowed
; to be included when building a deck configuration
wSameNameCardsLimit:: ; d382
	ds $1

; whether to include the cards in the selected deck
; to appear in the filtered lists
; is TRUE when building a deck (since the cards should be shown for removal)
; is FALSE when choosing a deck configuration to send through Gift Center
; (can't select cards that are included in already built decks)
wIncludeCardsInDeck:: ; d383
	ds $1

; pointer to a function that handles the menu
; when building a deck configuration
wDeckConfigurationMenuHandlerFunction:: ; d384
	ds $2

; pointer to a transition table for the
; function in wDeckConfigurationMenuHandlerFunction
wDeckConfigurationMenuTransitionTable:: ; d386
	ds $2

wDeckBuildingParamsEnd::

wCurCardListPtr:: ; d388
	ds $1

	ds $1

wCardConfirmationText:: ; d38a
	ds $2

	ds $2

; the tile to draw in place of the cursor, in case
; the cursor is not to be drawn
wCursorAlternateTile:: ; d38e
	ds $1

wTempScrollMenuNumVisibleItems:: ; d38f
	ds $1

; which Booster Pack was selected
; in the Card Album menu
wCardAlbumBoosterPack:: ; d390
	ds $1

wBoosterPackCardListNumItems:: ; d391
	ds $1


wOwnedPhantomCards:: ; d392
	ds $1

; value containing a SFX to play
; due to a menu input
wMenuInputSFX:: ; d393
	ds $1

UNION

wSelectedPrinterMenuItem:: ; d394
	ds $1

wFirstOwnedCardIndex:: ; d395
	ds $1

NEXTU

wd394:: ; d394
	ds $2

ENDU

wNumCardListEntries:: ; d396
	ds $1

wNamingScreenBuffer:: ; d397
	ds NAMING_SCREEN_BUFFER_LENGTH

	ds $32

wNamingScreenBufferLength:: ; d3e1
	ds $1

wNamingScreenDestPointer:: ; d3e2
	ds $2

wNamingScreenQuestionPointer:: ; d3e4
	ds $2

wNamingScreenBufferMaxLength:: ; d3e6
	ds $1

wNamingScreenNumColumns:: ; d3e7
	ds $1

wNamingScreenCursorX:: ; d3e8
	ds $1

wNamingScreenNamePosition:: ; d3e9
	ds $2

; NAME_MODE_* constant
wNamingScreenMode:: ; d3eb
	ds $1

; see also: sUnnamedDeckCounter
wTempUnnamedDeckCounter:: ; d3ec
	ds $3

wd3ef:: ; d3ef
	ds $1

	ds $1e

wd40e:: ; d40e
	ds $8

; pointers to all decks of current deck machine
wMachineDeckPtrs:: ; d416
	ds 2 * NUM_DECK_SAVE_MACHINE_SLOTS

wNumSavedDecks:: ; d47a
	ds $1

wTempScrollMenuItem:: ; d47b
	ds $1

wTempScrollMenuScrollOffset:: ; d47c
	ds $1

; which list entry was selected in the Deck Machine screen
wSelectedDeckMachineEntry:: ; d47d
	ds $1

wDismantledDeckName:: ; d47e
	ds DECK_NAME_SIZE

; which deck slot to be used to build a new deck
wDeckSlotForNewDeck:: ; d496
	ds $1

wDeckMachineTitleText:: ; d497
	ds $2

wNumDeckMachineEntries:: ; d499
	ds $1

wDecksToBeDismantled:: ; d49a
	ds $1

wNumCardsNeededToBuildSelectedDeckUsedInBuiltDecks:: ; d49b
	ds $1

; text ID to print in the text box when
; inside the Deck Machine menu
wDeckMachineText:: ; d49c
	ds $2

wNumCardsNeededToBuildSelectedDeckMissingInCardCollection:: ; d49e
	ds $1

UNION

; cards used in built decks, cards missing
wNumCardsNeededToBuildDeckMachineDecks:: ; d49f
	ds (1 + 1) * NUM_DECK_SAVE_MACHINE_SLOTS

NEXTU

; store (index + 1)
wIndicesAutoDeckMachineUnlockedCategories:: ; d49f
	ds NUM_AUTO_DECK_MACHINE_CATEGORIES

	ds $a

; selected category index of current auto deck machine
wSelectedAutoDeckMachineCategory:: ; d4b3
	ds $1

; unlocked category names, description texts of current category, etc.
wAutoDeckMachineTexts:: ; d4b4
	ds 2 * NUM_AUTO_DECK_MACHINE_CATEGORIES

wSelectedMachineDeck:: ; d4c8
	ds DECK_TEMP_BUFFER_SIZE

ENDU

UNION

; *_ISLAND flag to switch machine 1 and 2
wAutoDeckMachineIndex:: ; d548
	ds $1

NEXTU

wd548:: ; d548
	ds $2

ENDU

wAutoDeckMachineScrollOffset:: ; d54a
	ds $1

wAutoDeckMachineScrollMenuItem:: ; d54b
	ds $1

wNextGameEvent:: ; d54c
	ds $1

; MAP_* constant
; also used for new-game entry flag:
;   FALSE: no save data
;    TRUE: entered player info
wNextWarpMap:: ; d54d
	ds $1

wd54e:: ; d54e
	ds $2

wPlayerOWObject:: ; d550
	ds $1

wCurMapScriptsBank:: ; d551
	ds $1

wCurMapScriptsPointer:: ; d552
	ds $2

; bit 0: has save data
; bit 1: has saved duel + ?
; bit 2: has saved duel
wd554:: ; d554
	ds $1

wCurrentNPCDuelistData:: ; d555
	ds NPC_DUELIST_STRUCT_SIZE

; TODO: is this really union?
UNION

; MAPHEADERSTRUCT_*
wTempMapHeaderData:: ; d561

wTempMapGfx:: ; d561
	ds $1

wTempMapScriptsBank:: ; d562
	ds $1

wTempMapScriptsPointer:: ; d563
	ds $2

wTempMapMusic:: ; d565
	ds $1

wTempMapHeaderDataEnd::

NEXTU

wNumBlackBoxInputPkmnPerType:: ; d561
	ds NUM_PKMN_TYPES

ENDU

	ds $d

wFilteredListPtr:: ; d575
	ds $2

; TODO: is this really union?
UNION

; for challenge cups and challenge machines
wNumRandomDuelists:: ; d577
	ds $1

wChallengeCupIndex:: ; d578
	ds $1

NEXTU

wRemainingIntroCards:: ; d577
	ds $1

	ds $1

wd579:: ; d579
	ds $2

wIntroCardsRepeatsAllowed:: ; d57b
	ds $1

NEXTU

wBlackBoxOutputCountCircle:: ; d577
	ds $1

wBlackBoxOutputCountDiamond:: ; d578
	ds $1

wBlackBoxOutputCountStar:: ; d579
	ds $1

	ds $2

wTempBlackBoxInputEvoLine:: ; d57c

wTempBlackBoxInputBasic:: ; d57c
	ds $2

wTempBlackBoxInputStage1:: ; d57e
	ds $2

wTempBlackBoxInputStage2:: ; d580
	ds $2

wTempBlackBoxInputEvoLineEnd:: ; d582

ENDU

; OWMODE_* constant
wOverworldMode:: ; d582
	ds $1

; bit 0: set when player warps
; bit 1: set when NPC initiates duel
; bit 7: set when game continues from diary
wOverworldTransition:: ; d583
	ds $1

wPrevMap:: ; d584
	ds $1

wTempPrevMap:: ; d585
	ds $1

wCurMap:: ; d586
	ds $1

; OWMAP_* constant
wCurOWLocation:: ; d587
	ds $1

; OWMAP_* constant
wPlayerOWLocation:: ; d588
	ds $1

; island where player is located
; either TCG_ISLAND or GR_ISLAND
wCurIsland:: ; d589
	ds $1

wNextMapHeaderData:: ; d58a

; MAP_GFX_* constant
wNextMapGfx:: ; d58a
	ds $1

wNextMapScriptsBank:: ; d58b
	ds $1

wNextMapScriptsPointer:: ; d58c
	ds $2

; MUSIC_* constant
; see also: wCurMusic
; notably passed to PlayAfterCurrentSong in PlayNextMusic
wNextMusic:: ; d58e
	ds $1

wNextMapHeaderDataEnd::

wNextWarpPlayerData:: ; d58f

wNextWarpPlayerXCoord:: ; d58f
	ds $1

wNextWarpPlayerYCoord:: ; d590
	ds $1

wNextWarpPlayerDirection:: ; d591
	ds $1

wNextWarpPlayerDataEnd::

wOverworldScriptBank:: ; d592
	ds $1

wOverworldScriptPointer:: ; d593
	ds $2

; NPC_* ID
wd595:: ; d595
	ds $1

wOWObjTargetX:: ; d596
	ds $1

wOWObjTargetY:: ; d597
	ds $1

wd598:: ; d598
	ds $1

wOWObjXVelocity:: ; d599
	ds $1

wd59a:: ; d59a
	ds $1

wOWObjYVelocity:: ; d59b
	ds $1

wd59c:: ; d59c
	ds $1

wd59d:: ; d59d
	ds $1

wEventVars:: ; d59e
	ds EVENT_VAR_BYTES

wGeneralVars:: ; d5d2
	ds GENERAL_VAR_BYTES

; various temp flags
; e.g. blackbox input type flags, evo stage flags, etc.
wd606:: ; d606
	ds wD606_STRUCT_SIZE

; NPC_* ID of the active speaker / OW Object
wScriptNPC:: ; d60e
	ds $1

; text ID of the active speaker's name
wScriptNPCName:: ; d60f
	ds $2

; a bitfield for every unique mail in the game (29 total).
; the corresponding bit is set when a mail is sent, and mask is checked before sending
; mail in event scripts. Mail that is not sent via event script skips the check.
wSentMailBitfield:: ; d611
	ds (NUM_UNIQUE_MAILS_IN_GAME + 7) / 8

wTempCardDungeonBet:: ; d615
	ds $1

; sometimes treated as 8-bit, sometimes treated as 16-bit
wScriptLoadedVar:: ; d616
	ds $2

; temporarily stores multiple script flags
; - bit 0: general purpose script logic flag, often treated like a z flag
;     examples:
;     - set by ask_question if player chooses "Yes"
;     - set by compare_loaded_var if var is equal to the comparison value
; - bit 1: second general purpose script logic flag, often treated like a c flag
;     examples:
;     - set by duel_requirement_check to indicate failure
;     - set by compare_loaded_var if var is less than the comparison value
; - bit 6: set when script is ended by quit_script
; - bit 7: set when script is ended by end_script
wScriptFlags:: ; d618
	ds $1

wScriptBank:: ; d619
	ds $1

wScriptBufferIndex:: ; d61a
	ds $1

wScriptPointer:: ; d61b
	ds $2

wScriptStackOffset:: ; d61d
	ds $1

wScriptBuffer:: ; d61e
	ds SCRIPT_BUFFER_SIZE

wScriptStack:: ; d63e
	ds SCRIPT_STACK_SIZE

; buffer to hold booster pack random choice list
wBoosterPackList:: ; d64e
	ds $10

; size of wBoosterPackList
wBoosterPackCount:: ; d65e
	ds $1

; the list of booster packs to give, chosen from wBoosterPackList
wBoosterPacksToGive:: ; d65f
	ds $8

; the number of booster packs to give
wNumBoosterPacksToGive:: ; d667
	ds $1

; SRAM0 or SRAM2
wSaveDataCurBankSRAM:: ; d668
	ds $1

	ds $1

wSaveDataCurItemMinValidValue:: ; d66a
	ds $1

wSaveDataCurItemMaxValidValue:: ; d66b
	ds $1

wSaveDataChecksum0:: ; d66c
	ds $1

wSaveDataChecksum1:: ; d66d
	ds $1

wSaveDataChecksum2:: ; d66e
	ds $1

wWRAMToSRAMMapperPointer:: ; d66f
	ds $2

wSaveDataSRAMOffset:: ; d671
	ds $2

wSaveDataChecksumSeed:: ; d673
	ds $1

; MUSIC_* constant
; see also: wNextMusic
wCurMusic:: ; d674
	ds $1

wMusicFadeOutCounter:: ; d675
	ds $1

wMusicFadeOutDuration:: ; d676
	ds $1

wMusicFadeOutVolume:: ; d677
	ds $1

wd678:: ; d678
	ds $1

	ds $7

wd680:: ; d680
	ds $1

wOWScrollSpeed:: ; d681
	ds $1

wDebugMenuCursorPosition:: ; d682
	ds $1

	ds $2

wDebugAnimDuelistSide:: ; d685
	ds $1

wDebugSelectedAnimNumber:: ; d686
	ds $1

wDebugDuelAnimationScreen:: ; d687
	ds $1

wDebugDuelAnimLocationParam:: ; d688
	ds $1

	ds $3

wd68c:: ; d68c
	ds $1

; represents a 16-bit value
; in big endian decimal representation
wDecimalRepresentation:: ; d68d
	ds $5

	ds $1

wd693:: ; d693
	ds $1

wDecompressedBGMap:: ; d694
	ds 2 * TILEMAP_WIDTH

wd6d4:: ; d6d4
	ds $100

wBGMapAttribute:: ; d7d4
	ds $1

wBGMapTileOffset:: ; d7d5
	ds $1

wBGMapWidth:: ; d7d6
	ds $1

wBGMapHeight:: ; d7d7
	ds $1

wd7d8:: ; d7d8
	ds $1

wd7d9:: ; d7d9
	ds $1

	ds $2

wd7dc:: ; d7dc
	ds $1

wd7dd:: ; d7dd
	ds $1

wd7de:: ; d7de
	ds $1

wd7df:: ; d7df
	ds $2

wOWAnimBank:: ; d7e1
	ds $1

wOWAnimPtr:: ; d7e2
	ds $2

	ds $1

wd7e5:: ; d7e5
	ds $2

wd7e7:: ; d7e7
	ds $1

wd7e8:: ; d7e8
	ds $1

wd7e9:: ; d7e9
	ds $1

	ds $2

; 177 bytes
wOWData:: ; d7ec

; OW map constant
wOWMap:: ; d7ec
	ds $2

wOWAnimatedTiles:: ; d7ee
	ds NUM_OW_ANIMATED_TILES * $4

wd852:: ; d852
	ds $1

wd853:: ; d853
	ds $40

wScrollTargetSpritePtr:: ; d893
	ds $2

wOWScrollState:: ; d895
	ds $1

wd896:: ; d896
	ds $2

wd898:: ; d898
	ds $1

wd899:: ; d899
	ds $1

wd89a:: ; d89a
	ds $1

wOWScrollX:: ; d89b
	ds $1

wOWScrollY:: ; d89c
	ds $1

wOWDataEnd::

wd89d:: ; d89d
	ds $1

wd89e:: ; d89e
	ds $1

wPauseMenuCursorPosition:: ; d89f
	ds $1

; if TRUE, pause menu adds chips display
wPauseMenuWithChips:: ; d8a0
	ds $1

wd8a1:: ; d8a1
	ds $1

wSpriteAnimationStructs:: ; d8a2
; wSpriteAnim1 - wSpriteAnim10
FOR n, 1, NUM_SPRITE_ANIM_STRUCTS + 1
wSpriteAnim{d:n}:: sprite_anim_struct wSpriteAnim{d:n}
ENDR

; used to keep track of tiles being copied to VRAM
; bit 7: VRAM0 or VRAM1
wCurVRAMTile:: ; d942
	ds $1

wNumSpriteTilesets:: ; d943
	ds $1

wSpriteTilesets:: ; d944
; wSpriteTileset1 - wSpriteTileset10
FOR n, 1, NUM_SPRITE_ANIM_STRUCTS + 1
wSpriteTileset{d:n}:: obj_tile_struct wSpriteTileset{d:n}
ENDR

	ds $3

wd96f:: ; d96f
	ds $1

wd970:: ; d970
	ds $1

wd971:: ; d971
	ds $1

wd972:: ; d972
	ds $1

	ds $2

wd975:: ; d975
	ds $1

wCurSpriteAnim:: sprite_anim_struct wCurSpriteAnim ; d976

wd986:: ; d986
	ds $1

; NPC_* ID (or NPC_NONE)
; see also: wScriptNPC
wTempScriptNPC:: ; d987
	ds $1

	ds $1

; NPC_* ID
wd989:: ; d989
	ds $1

wd98a:: ; d98a
	ds $1

wd98b:: ; d98b
	ds 5 * MAX_NUM_OW_OBJECTS

wFrameFunctionStackSize:: ; d9bd
	ds $1

wFrameFunctionStack:: ; d9be
	ds $10

wPortraitSlot:: ; d9ce
	ds $1

wPortraitEmotion:: ; d9cf
	ds $1

; which of the 5 submenus in the Config menu is selected
wSelectedConfigSubmenu:: ; d9d0
	ds $1

	ds $2

; see also: sDuelAnimationsSetting
wDuelAnimationsSetting:: ; d9d3
	ds $1

wCoinTossAnimationSetting:: ; d9d4
	ds $1

; used to set wTextSpeed, sTextSpeed
wMessageSpeedSetting:: ; d9d5
	ds $1

wTextBoxFrameColor:: ; d9d6
	ds $1

	ds $5

wPCMenuCursorPosition:: ; d9dc
	ds $1

; $0 = no fading
; $1 = fade to target palette
; $2 = fade to black/white
wPaletteFadeMode:: ; d9dd
	ds $1

wd9de:: ; d9de
	ds $1

; whether pal fading happens
; as an increment or decrement
; of the color values
; when fading to black/white:
;  bit 0 not set = fade to white
;  bit 0 set     = fade to black
; when fading to a target pal:
;  bit 0 not set = color decrement
;  bit 0 set     = color increment
wPalFadeDirection:: ; d9df
	ds $1

wPaletteFadeCounter:: ; d9e0
	ds $1

wPaletteFadeSpeedMask:: ; d9e1
	ds $1

; whether palette fading is enabled
; bit 0 set: enabled for BGP
; bit 7 set: enabled for OBP
wPaletteFadeFlags:: ; d9e2
	ds $1

wMenuBoxX:: ; d9e3
	ds $1

wMenuBoxY:: ; d9e4
	ds $1

wMenuBoxWidth:: ; d9e5
	ds $1

wMenuBoxHeight:: ; d9e6
	ds $1

wMenuBoxSkipClear:: ; d9e7
	ds $1

wMenuBoxLabelTextID:: ; d9e8
	ds $2

wMenuBoxHasHorizontalScroll:: ; d9ea
	ds $1

wMenuBoxVerticalStep:: ; d9eb
	ds $1

wMenuBoxBlinkSymbol:: ; d9ec
	ds $1

wMenuBoxSpaceSymbol:: ; d9ed
	ds $1

wMenuBoxCursorSymbol:: ; d9ee
	ds $1

wMenuBoxSelectionSymbol:: ; d9ef
	ds $1

wMenuBoxPressKeys:: ; d9f0
	ds $1

wMenuBoxHeldKeys:: ; d9f1
	ds $1

wMenuBoxNumItems:: ; d9f2
	ds $1

wMenuBoxItemsXPositions:: ; d9f3
	ds $10

wMenuBoxItemsYPositions:: ; da03
	ds $10

wMenuBoxItemsTextIDs:: ; da13
	ds 2 * $10

wMenuBoxBlinkCounter:: ; da33
	ds $1

wMenuBoxUpdateFunction:: ; da34
	ds $2

wMenuBoxFocusedItem:: ; da36
	ds $1

wda37:: ; da37
	ds $1

wMenuBoxDelay:: ; da38
	ds $1

wOWObjects:: ; da39
; wOWObj1 - wOWObj10
FOR n, 1, MAX_NUM_OW_OBJECTS + 1
wOWObj{d:n}:: ow_obj_struct wOWObj{d:n}
ENDR

	ds $2

wda8b:: ; da8b
	ds $1

wda8c:: ; da8c
	ds $1

wda8d:: ; da8d
	ds $1

	ds $6

wda94:: ; da94
	ds $2

	ds $1

wScrollTargetObject:: ; da97
	ds $1

; set to FF while chip count window is on screen (top-left corner)
wda98:: ; da98
	ds $1

; capped at MAX_CHIPS
wGameCenterChips:: ; da99
	ds $2

; capped at MAX_CHIPS
wGameCenterBankedChips:: ; da9b
	ds $2

wIntroOrbsStates:: ; da9d
	ds NUM_INTRO_ORBS

wIntroSceneCounter:: ; daa5
wIntroCardIndex::
	ds $1

wIntroStateMode:: ; daa6
	ds $1

wIntroStateCounter:: ; daa7
	ds $1

	ds $1

wTitleScreenCards:: ; daa9
	ds 2 * NUM_TITLE_SCREEN_CARDS

	ds $4

wdabd:: ; dabd
	ds $1

	ds $1

wdabf:: ; dabf
	ds $1

	ds $1

wdac1:: ; dac1
	ds $20

	ds $1c

wdafd:: ; dafd
	ds $1

	ds $1

; STARTMENU_CONFIG_* constant
wStartMenuConfiguration:: ; daff
	ds $1

wMenuCursorPosition:: ; db00
	ds $1

wMenuBoxLastFocusedItem:: ; db01
	ds $1

	ds $c

wBackupWX:: ; db0e
	ds $1

wBackupWY:: ; db0f
	ds $1

wDisplayHours:: ; db10
	ds $2

wDisplayMinutes:: ; db12
	ds $1

wTotalNumCardsToCollect:: ; db13
	ds $2

wTotalNumCardsCollected:: ; db15
	ds $2

wPopupMenuCursorPosition:: ; db17
	ds $1

wdb18:: ; db18
	ds $1

wdb19:: ; db19
	ds $1

wdb1a:: ; db1a
	ds $5

wdb1f:: ; db1f
	ds $1

wdb20:: ; db20
	ds $1

wdb21:: ; db21
	ds $2

wdb23:: ; db23
	ds $c

wdb2f:: ; db2f
	ds $1

wdb30:: ; db30
	ds $1

wdb31:: ; db31
	ds $1

wdb32:: ; db32
	ds $1

	ds $1

wdb34:: ; db34
	ds $1

wdb35:: ; db35
	ds $1

wdb36:: ; db36
	ds $1

	ds $2

wdb39:: ; db39
	ds $3

wdb3c:: ; db3c
	ds $1

wdb3d:: ; db3d
	ds $1

	ds $1

wdb3f:: ; db3f
	ds $1

	ds $6

wdb46:: ; db46
	ds $40

wdb86:: ; db86
	ds $40

wdbc6:: ; dbc6
	ds $40

wGiftCenterMenuCursorPosition:: ; dc06
	ds $1

wSelectedGiftCenterMenuItem:: ; dc07
	ds $1

wSelectedCoin:: ; dc08
	ds $1

; used when viewing your coins in Coin menu.
; same values as COIN_TYPE_*
wCoinPage:: ; dc09
	ds $1

; COIN_* id being given to player during cutscene
wIncomingCoin:: ; dc0a
	ds $1

wdc0b:: ; dc0b
	ds $1

; see: _CoinPageListTable for valid values
wCoinPageXCoordinate:: ; dc0c
	ds $1

; see: _CoinPageListTable for valid values
wCoinPageYCoordinate:: ; dc0d
	ds $1

	ds $1

; store settings for animation enabled/disabled
; FALSE means enabled, TRUE means disabled
wAnimationsDisabled:: ; dc0f
	ds $1

; temporarily holds the palettes from
; wBackgroundPalettesCGB
wTempBackgroundPalettesCGB:: ; dc10
	ds NUM_BACKGROUND_PALETTES palettes

	ds $7

wdc57:: ; dc57
	ds $1

wdc58:: ; dc58
	ds $1

wNumActiveAnimations:: ; dc59
	ds $1

wdc5a:: ; dc5a
	ds $1

	ds $1

wAnimFlags:: ; dc5c
	ds $1

wAnimAllowedFlags:: ; dc5d
	ds $1

wDuelAnimBufferSize:: ; dc5e
	ds $1

wDuelAnimBufferCurPos:: ; dc5e
	ds $1

wDuelAnimBuffer:: ; dc60
	duel_anim_struct wDuelAnim1
	duel_anim_struct wDuelAnim2
	duel_anim_struct wDuelAnim3
	duel_anim_struct wDuelAnim4
	duel_anim_struct wDuelAnim5
	duel_anim_struct wDuelAnim6
	duel_anim_struct wDuelAnim7
	duel_anim_struct wDuelAnim8
	duel_anim_struct wDuelAnim9
	duel_anim_struct wDuelAnim10
	duel_anim_struct wDuelAnim11
	duel_anim_struct wDuelAnim12
	duel_anim_struct wDuelAnim13
	duel_anim_struct wDuelAnim14
	duel_anim_struct wDuelAnim15
	duel_anim_struct wDuelAnim16
wDuelAnimBufferEnd::

wdce0:: ; dce0
	ds $1

wdce1:: ; dce1
	ds $1

; holds an animation to play
wCurAnimation:: ; dce2
	ds $1

; used to know what coordinate offsets to use to place animations
; for use in GetAnimCoordsAndFlags
; DUEL_ANIM_SCREEN_MAIN_SCENE       = main scene
; DUEL_ANIM_SCREEN_PLAYER_PLAY_AREA = Player's Play Area screen
; DUEL_ANIM_SCREEN_OPP_PLAY_AREA    = Opponent's Play Area screen
wDuelAnimationScreen:: ; dce3
	ds $1

; which side to play animation
; uses PLAYER_TURN and OPPONENT_TURN constants
wDuelAnimDuelistSide:: ; dce4
	ds $1

; used in GetAnimCoordsAndFlags to determine
; what coordinates to draw the animation in.
; e.g. used to know what Play Area card
; to draw a hit animation in the Play Area screen.
wDuelAnimLocationParam:: ; dce5
	ds $1

; damage value to display with animation
wDuelAnimDamage:: ; dce6
	ds $2

wDuelAnimSetScreen:: ; dce8
wDuelAnimEffectiveness::
	ds $1

; bank number to return to after processing animation
wDuelAnimReturnBank:: ; dce9
	ds $1

wActiveScreenAnim:: ; dcea
	ds $1

; pointer to a function to update
; the current screen animation
wScreenAnimUpdatePtr:: ; dceb
	ds $2

; duration of the current screen animation
wScreenAnimDuration:: ; dced
	ds $1

wdcee:: ; dcee
	ds $2

wdcf0:: ; dcf0
	ds $1

wAnimationTileset:: ; dcf1
	ds $2

wAnimationSpriteAnim:: ; dcf3
	ds $2

wAnimationFrameset:: ; dcf5
	ds $2

wAnimationPalette:: ; dcf7
	ds $2

wAnimationDataFlags:: ; dcf9
	ds $1

wAnimationSFX:: ; dcfa
	ds $1

; only written, always equals 0
wAnimationUnknownParam:: ; dcfb
	ds $1

	ds $6

; stores the player's result in a duel (0: win, 1: loss, 2: ???, -1: transmission error?)
; to be read by the overworld caller
wDuelResult:: ; dd02
	ds $1

wDuelStartTheme:: ; dd03
	ds $1

wTempActiveMusic:: ; dd04
	ds $1

wTempActiveMusicState:: ; dd05
	ds $1

wActiveMusicState:: ; dd06
	ds $1

wMinicomMenuCursorPosition:: ; dd07
	ds $1

wCurBoosterPack:: ; dd08
	ds $1

wAnotherBoosterPack:: ; dd09
	ds $1

wGrandMasterCupCompetitorNames:: ; dd0a
	ds 2 * NUM_GRANDMASTERCUP_COMPETITORS

; store the winner side (GRANDMASTERCUP_BRACKET_*_WON) for each match
wGrandMasterCupBracketWinnerSides:: ; dd1a
	ds NUM_GRANDMASTERCUP_BRACKET_MATCHES

; GRANDMASTERCUP_BRACKET_*_WON_F bitfield
wGrandMasterCupBracketWinnerSideBitfield:: ; dd21
	ds $1

; NPC ID
wGrandMasterCupBracketChampion:: ; dd22
	ds $1

wGrandMasterCupBracketChampionSpriteAnimIndex:: ; dd23
	ds $1

wGrandMasterCupBracketChampionSpriteAnimTick:: ; dd24
	ds $1

wdd25:: ; dd25
	ds $2

wdd27:: ; dd27
	ds $2

wdd29:: ; dd29
	ds $2

wdd2b:: ; dd2b
	ds $2

wdd2d:: ; dd2d
	ds $1

wdd2e:: ; dd2e
	ds $1

wdd2f:: ; dd2f
	ds $1

; id of the mail item being read
wMailId:: ; dd30
	ds $1

; 0 - mailbox full, 1 - new mail, 2 - no new mail
wMailboxStatus:: ; dd31
	ds $1

; text offset of the sender line. displayed when reading a mail
wMailSenderText:: ; dd32
	ds $2

; text offset of the subject line. displayed when reading a mail
wMailSubjectText:: ; dd34
	ds $2

; number of minicom mail queued to be delivered. mail is delivered when changing OW locations
wNumMailInQueue:: ; dd36
	ds $1

; list of mail items queued to be delivered
wMailQueue:: ; dd37
	ds MAIL_QUEUE_BUFFER_SIZE

; total number of mail in your mailbox
wMailCount:: ; dd50
	ds $1

; list of mail items in the player's mailbox. holds up to 8 mail.
; Each byte is the id of a mail item.
; When mail is read, $80 is added to the id
wMailList:: ; dd51
	ds MAIL_BUFFER_SIZE

; $ff when the player has new mail. set to 0 when opening minicom mail menu. affects the mailbox animation
wNewMail:: ; dd5a
	ds $1

; copied from wNumMailInQueue when visiting world map.
; cleared after viewing the mailbox screen once.
; used to show the "mailbox full" graphic
wTempNumMailInQueue:: ; dd5b
	ds $1

; which page of mail you are viewing. 0 or 1
wMailboxPage:: ; dd5c
	ds $1

; the mail you have selected to read/delete
wSelectedMailCursorPosition:: ; dd5d
	ds $1

; 0 - read mail, 1 - delete mail, 2 - quit
wMailOptionSelected:: ; dd5e
	ds $1

; card offsets. the cards mailed to you after using the Game Center black box
wBlackBoxCardReceived:: ; dd5f
	ds BLACK_BOX_OUTPUT_BYTES

; card offset. the card mailed to you after using the Game Center Bill's PC
wBillsPCCardReceived:: ; dd73
	ds $2

wdd75:: ; dd75
	ds $1

wdd76:: ; dd76
	ds $1

wdd77:: ; dd77
	ds $1

wGrandMasterCupPrizeSelectionMenuCursorPosition:: ; dd78
	ds $1

wNumGrandMasterCupPrizesSelected:: ; dd79
	ds $1

; card name, card id
wGrandMasterCupPrizes:: ; dd7a
	ds (2 + 2) * NUM_GRANDMASTERCUP_PRIZE_CANDIDATES

wGrandMasterCupPrizesSelectionState:: ; dd8a
	ds NUM_GRANDMASTERCUP_PRIZE_CANDIDATES

wSelectedGrandMasterCupPrizeItems:: ; dd8e
wSelectedGrandMasterCupPrizeItem1:: ; dd8e
	ds $1
wSelectedGrandMasterCupPrizeItem2:: ; dd8f
	ds $1

	ds $3

wdd93:: ; dd93
	ds $1

wCardTilemap:: ; dd94
	ds $30

wddc4:: ; ddc4
	ds $30

wCardTilemapOffset:: ; ddf4
	ds $1

wddf5:: ; ddf5
	ds $1

; TCG_ISLAND or GR_ISLAND
wChallengeMachineIndex:: ; ddf6
	ds $1

wChallengeMachineCurRound:: ; ddf7
	ds $1

wChallengeMachineDuelResult:: ; ddf8
	ds $1

; title name, dialog name for 5 rounds of the set
wChallengeMachineOpponentTitlesAndNames:: ; ddf9
	ds (2 + 2) * NUM_CHALLENGE_MACHINE_ROUNDS_PER_SET

wChallengeMachineSetsWonRecords:: ; de0d
wTCGChallengeMachineSetsWonRecord:: ; de0d
	ds $2

wGRChallengeMachineSetsWonRecord:: ; de0f
	ds $2

wChallengeMachineCurWinStreaks:: ; de11
wTCGChallengeMachineCurWinStreak:: ; de11
	ds $2

wGRChallengeMachineCurWinStreak:: ; de13
	ds $2

wChallengeMachineWinStreakRecords:: ; de15
wTCGChallengeMachineWinStreakRecord:: ; de15
	ds $2

wGRChallengeMachineWinStreakRecord:: ; de17
	ds $2

wChallengeMachinePlayerNames:: ; de19
wTCGChallengeMachinePlayerName:: ; de19
	ds NAME_BUFFER_LENGTH

wGRChallengeMachinePlayerName:: ; de29
	ds NAME_BUFFER_LENGTH

wChallengeMachineTempPlayerName:: ; de39
	ds NAME_BUFFER_LENGTH

wCreditsCmdArg1:: ; de49
	ds $1

wCreditsCmdArg2:: ; de4a
	ds $1

wCreditsCmdArg3:: ; de4b
	ds $1

wCreditsCmdArg4:: ; de4c
	ds $1

wCreditsCmdArg5:: ; de4d
	ds $1

wde4e:: ; de4e
	ds $1

wde4f:: ; de4f
	ds $1

wde50:: ; de50
	ds $1

wde51:: ; de51
	ds $1

wde52:: ; de52
	ds $1

wProloguePortraitScene:: ; de53
	ds $1

wPlayerName:: ; de54
	ds NAME_BUFFER_LENGTH

wde64:: ; de64
	ds $1

; used by GetNextBackgroundScroll
wBGScrollMod:: ; de65
	ds $1

; used by ApplyBackgroundScroll
wApplyBGScroll:: ; de66
	ds $1

; used by ApplyBackgroundScroll
wNextScrollLY:: ; de67
	ds $1

	ds $1

wde69:: ; de69
	ds $2

SECTION "WRAM2", WRAMX

wScratchCardCollection:: ; d000
	ds CARD_COLLECTION_SIZE

wBackup1DeckToBuild:: ; d200
	ds DECK_TEMP_BUFFER_SIZE

; $ff-terminated array of basic energy amount available to sub in,
; first in card constant order (not in type-flag order),
; then sorted in descending order when processed
; also a subbed deck flag after the sort
wNumRemainingBasicEnergyCardsForSubbedDeck:: ; d280
	ds NUM_COLORED_TYPES + 1

; $ff-terminated index array [0, 5]
; mapped when wNumRemainingBasicEnergyCardsForSubbedDeck is sorted
wIndicesRemainingBasicEnergyCardsForSubbedDeck:: ; d287
	ds NUM_COLORED_TYPES + 1

wBigBackupDeckToBuild:: ; d28e
	ds DECK_BIG_TEMP_BUFFER_SIZE

wBackup2DeckToBuild:: ; d38e
	ds DECK_TEMP_BUFFER_SIZE

wAutoDecks:: ; d40e
	ds DECK_COMPRESSED_STRUCT_SIZE * NUM_AUTO_DECK_MACHINE_SLOTS

wBackup3DeckToBuild:: ; d58e
	ds DECK_TEMP_BUFFER_SIZE

SECTION "WRAM3", WRAMX

w3d000:: ; d000
	ds $1

	ds $3ff

w3d400:: ; d400
	ds $1

; pointers to BG map
w3d401:: ; d401
	ds 2 * 10

w3d415:: ; d415
	ds $1

	ds $b0

w3d4c6:: ; d4c6
	ds $415

w3d8db:: ; d8db
	ds SPRITE_ANIM_TILE_BUFFER_SIZE

w3d9a5:: ; d9a5
	ds OW_OBJECTS_BUFFER_SIZE

SECTION "WRAM7 Audio", WRAMX

wSVBKBackup:: ; d000
	ds $1

wSVBKBackup2:: ; d001
	ds $1

; bit 7 is set once the song has been started
wCurSongID:: ; d002
	ds $1

wCurSongBank:: ; d003
	ds $1

; bit 7 is set once the sfx has been started
wCurSfxID:: ; d004
	ds $1

wAudio_d005:: ; d005
	ds $1

; priority value of current sfx (0 if nothing is playing)
wSfxPriority:: ; d006
	ds $1

wCurSfxBank:: ; d007
	ds $1

; 8-bit output enable mask for left/right output for each channel
wMusicStereoPanning:: ; d008
	ds $1

wdd85:: ; d009
	ds $1

wMusicDuty1:: ; d00a
	ds $1

wMusicDuty2:: ; d00b
	ds $1

	ds $2

wMusicWave:: ; d00e
	ds $1

wMusicWaveChange:: ; d00f
	ds $1

wdd8c:: ; d010
	ds $1

wAudio_d011:: ; d011
	ds $1

wMusicIsPlaying:: ; d012
	ds $4

wMusicTie:: ; d016
	ds $4

; 4 pointers to the current music commands being executed
wMusicChannelPointers:: ; d01a
	ds $8

; 4 pointers to the addresses of the beginning of the main loop for each channel
wMusicMainLoopStart:: ; d022
	ds $8

wMusicCh1CurPitch:: ; d02a
	ds $1

wMusicCh1CurOctave:: ; d02b
	ds $1

wMusicCh2CurPitch:: ; d02c
	ds $1

wMusicCh2CurOctave:: ; d02d
	ds $1

wMusicCh3CurPitch:: ; d02e
	ds $1

wMusicCh3CurOctave:: ; d02f
	ds $1

wddab:: ; d030
	ds $1

wddac:: ; d031
	ds $1

	ds $2

wMusicOctave:: ; d034
	ds $4

wddb3:: ; d038
	ds $4

wddb7:: ; d03c
	ds $1

wddb8:: ; d03d
	ds $1

wddb9:: ; d03e
	ds $1

wddba:: ; d03f
	ds $1

wddbb:: ; d040
	ds $4

; the delay (1-8) before a note is cut off early (0 is disabled)
wMusicCutoff:: ; d044
	ds $4

wddc3:: ; d048
	ds $4

; the volume to apply after a cutoff
wMusicEcho:: ; d04c
	ds $4

; the pitch offset to apply to each note (see Music1_Pitches)
wMusicPitchOffset:: ; d050
	ds $4

wMusicSpeed:: ; d054
	ds $4

wMusicVibratoType:: ; d058
	ds $4

wMusicVibratoType2:: ; d05c
	ds $4

wdddb:: ; d060
	ds $4

wMusicVibratoDelay:: ; d064
	ds $4

wdde3:: ; d068
	ds $4

wAudio_d06c:: ; d06c
	ds $4

wAudio_d070:: ; d070
	ds $4

wMusicVolume:: ; d07c
	ds $3

; the frequency offset to apply to each note
wMusicFrequencyOffset:: ; d077
	ds $3

wAudio_d07a:: ; d07a
	ds $3

wAudio_d07d:: ; d07d
	ds $3

wAudio_d080:: ; d080
	ds $3

wAudio_d083:: ; d083
	ds $1

wdded:: ; d084
	ds $2

wddef:: ; d086
	ds $1

wAudio_d087:: ; d087
	ds $1

wddf0:: ; d088
	ds $1

wMusicPanning:: ; d089
	ds $1

wddf2:: ; d08a
	ds $1

; 4 pointers to the positions on the stack for each channel
wMusicChannelStackPointers:: ; d08b
	ds $8

wMusicCh1Stack:: ; d093
	ds $c

wMusicCh2Stack:: ; d09f
	ds $c

wMusicCh3Stack:: ; d0ab
	ds $c

wMusicCh4Stack:: ; d0b7
	ds $c

wde2b:: ; d0c3
	ds $3

wde2e:: ; d0c6
	ds $1

wde2f:: ; d0c7
	ds $3

wde32:: ; d0ca
	ds $1

wde33:: ; d0cb
	ds $4

wde37:: ; d0cf
	ds $6

wde3d:: ; d0d5
	ds $2

wde3f:: ; d0d7
	ds $4

wde43:: ; d0db
	ds $8

wd0e3:: ; d0e3
	ds $8

wde53:: ; d0eb
	ds $1

wde54:: ; d0ec
	ds $1

wAudio_d0ed:: ; d0ed
	ds $1

wCurSongIDBackup:: ; d0ee
	ds $1

wCurSongBankBackup:: ; d0ef
	ds $1

wMusicStereoPanningBackup:: ; d0f0
	ds $1

wMusicDuty1Backup:: ; d0f1
	ds $4

wMusicWaveBackup:: ; d0f5
	ds $1

wMusicWaveChangeBackup:: ; d0f6
	ds $1

wMusicIsPlayingBackup:: ; d0f7
	ds $4

wMusicTieBackup:: ; d0fb
	ds $4

wMusicChannelPointersBackup:: ; d0ff
	ds $8

wMusicMainLoopStartBackup:: ; d107
	ds $8

wde76:: ; d10f
	ds $1

wde77:: ; d110
	ds $1

wMusicOctaveBackup:: ; d111
	ds $4

wde7c:: ; d115
	ds $4

wde80:: ; d119
	ds $4

wde84:: ; d11d
	ds $4

wMusicCutoffBackup:: ; d121
	ds $4

wde8c:: ; d125
	ds $4

wMusicEchoBackup:: ; d129
	ds $4

wMusicPitchOffsetBackup:: ; d12d
	ds $4

wMusicSpeedBackup:: ; d131
	ds $4

wMusicVibratoType2Backup:: ; d135
	ds $4

wMusicVibratoDelayBackup:: ; d139
	ds $4

wMusicVolumeBackup:: ; d13d
	ds $3

wMusicFrequencyOffsetBackup:: ; d140
	ds $3

wdeaa:: ; d143
	ds $2

wdeac:: ; d145
	ds $1

wAudio_d146:: ; d146
	ds $1

wAudio_d147:: ; d147
	ds $4

wAudio_d14b:: ; d14b
	ds $4

wAudio_d14f:: ; d14f
	ds $3

wAudio_d152:: ; d152
	ds $3

wAudio_d155:: ; d155
	ds $3

wAudio_d158:: ; d158
	ds $1

wMusicChannelStackPointersBackup:: ; d159
	ds $8

wMusicCh1StackBackup:: ; d161
	ds $c * 4

INCLUDE "sram.asm"
