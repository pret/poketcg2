INCLUDE "macros.asm"
INCLUDE "constants.asm"

INCLUDE "vram.asm"

SECTION "WRAM0", WRAM0

UNION

wTempCardCollection:: ; c000
	ds $100

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

ENDU

	ds $100

SECTION "WRAM0 Duels 1", WRAM0

wPlayerDuelVariables:: ; c200

	ds $100

wOpponentDuelVariables:: ; c300

	ds $100

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

wcb79:: ; cb73
	ds $2

wcb7b:: ; cb75
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

SECTION "WRAM0 Duels 2", WRAM0

wOppRNG1:: ; cbda
	ds $1

	ds $2

; sp is saved here when starting a duel, in order to save the return address
; however, it only seems to be read after a transmission error in a link duel
wDuelReturnAddress:: ; cbdd
	ds $2

	ds $3

; temporarily stores 8 bytes for serial send/recv.
; used by SerialSend8Bytes and SerialRecv8Bytes
wTempSerialBuf:: ; cbe2
	ds $8

SECTION "WRAM0 Duels 2@cc01", WRAM0

wcc01:: ; cc01
	ds $1

; a DUELTYPE_* constant. note that for a practice duel, wIsPracticeDuel must also be set to $1
wDuelType:: ; cc02
	ds $1

	ds $6

; this holds the current opponent's deck minus 2 (that is, a *_DECK_ID constant),
; in order to account for the two unused pointers at the beginning of DeckPointers.
wOpponentDeckID:: ; cc0e
	ds $1

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

wcc10:: ; cc10
	ds $1

	ds $2

; text id of the opponent's name
wOpponentName:: ; cc13
	ds $2

SECTION "WRAM0 Duels 2@cc29", WRAM0

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

	ds $4

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

	ds $3

; *_ATTACK constants for selected attack
; 0 for the first attack (or PKMN Power)
; 1 for the second attack
wSelectedAttack:: ; ccdb
	ds $1

; if affected by a no damage or effect substatus, this flag indicates what the cause was
wNoDamageOrEffect:: ; ccdc
	ds $1

; used by CountKnockedOutPokemon and Func_5805 to store the amount
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

	ds $4

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

; flag to determine whether DUELVARS_ARENA_CARD_LAST_TURN_DAMAGE
; gets zeroed or gets updated with wDealtDamage
wccef:: ; cd04
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

wcd07:: ; cd07
	ds $1

	ds $2

wcd0a:: ; cd0a
	ds $1

wcd0b:: ; cd0b
	ds $1

wcd0c:: ; cd0c
	ds $1

wcd0d:: ; cd0d
	ds $1

	ds $2

wcd10:: ; cd10
	ds $4

	ds $2

wcd16:: ; cd16
	ds $1

wcd17:: ; cd17
	ds $3

wcd1a:: ; cd1a
	ds $1

SECTION "WRAM0 2", WRAM0

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

	ds $2

; During a duel, this is always $b after the first attack.
; $b is the bank where the functions associated to card or effect commands are.
; Its only purpose seems to be store this value to be read by TryExecuteEffectCommandFunction.
; possibly used in other contexts too
wEffectFunctionsBank:: ; cd79
	ds $1

SECTION "WRAM0 2@cdc2", WRAM0

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

wce63:: ; cde9
	ds $1

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

wNumMenuItems:: ; d010
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

SECTION "WRAM1@d0bf", WRAMX

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

	ds $7

; number of prize cards still to be
; picked by the player
wNumberOfPrizeCardsToSelect:: ; d0c8
	ds $1

	ds $6

; $00 when the "In Play Area" screen has been opened from the Check menu
; $01 when the "In Play Area" screen has been opened by pressing the select button
wInPlayAreaFromSelectButton:: ; d0cf
	ds $1

SECTION "WRAM1@dd02", WRAMX

; stores the player's result in a duel (0: win, 1: loss, 2: ???, -1: transmission error?)
; to be read by the overworld caller
wDuelResult:: ; dd02
	ds $1

INCLUDE "sram.asm"
