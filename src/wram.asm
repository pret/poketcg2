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

	ds $1

wcc12:: ; cc12
	ds $1

; text id of the opponent's name
wOpponentName:: ; cc13
	ds $2

wcc15:: ; cc15
	ds $1

wcc16:: ; cc16
	ds $1

wcc17:: ; cc17
	ds $1

wcc18:: ; cc18
	ds $1

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

	ds $2

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

; used to check whether deck indices are within range
wDeckSize:: ; cd07
	ds $1

wcd08:: ; cd08
	ds $1

	ds $1

wcd0a:: ; cd0a
	ds $1

wcd0b:: ; cd0b
	ds $1

wcd0c:: ; cd0c
	ds $1

wcd0d:: ; cd0d
	ds $1

wcd0e:: ; cd0e
	ds $1

wcd0f:: ; cd0f
	ds $1

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

wCardPalettes:: ; cd7a
	ds 3 palettes

wCardAttrMap:: ; cd92
	ds $30

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

wce64:: ; cdea
	ds $1

wce65:: ; cdeb
	ds $1

wce66:: ; cdec
	ds $1

wce67:: ; cded
	ds $1

wce68:: ; cdee
	ds $1

wce69:: ; cdef
	ds $1

; pointer to memory of data to send
; in the data packet to the printer
wPrinterPacketDataPtr:: ; cdf0
	ds $2

wce6c:: ; cdf2
	ds $1

wce6d:: ; cdf3
	ds $1

wce6e:: ; cdf4
	ds $1

wPrinterStatus:: ; cdf5
	ds $1

; pointer to packet data that is
; being transmitted through serial
wSerialDataPtr:: ; cdf6
	ds $2

	ds $55

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

SECTION "WRAM1@d0e3", WRAMX

wNamingScreenCursorBlinkCounter:: ; d0e3
	ds $1

wNamingScreenCursorY:: ; d0e4
	ds $1

	ds $4

wNamingScreenNumRows:: ; d0e9
	ds $1

wVisibleCursorTile:: ; d0ea
	ds $1

wInvisibleCursorTile:: ; d0eb
	ds $1

SECTION "WRAM1@d393", WRAMX

wNamingScreenInputSFX:: ; d393
	ds $1

	ds $3

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

	ds $3

wd3ef:: ; d3ef
	ds $1


SECTION "WRAM1@d54c", WRAMX

wd54c:: ; d54c
	ds $1

wd54d:: ; d54d
	ds $1

wd54e:: ; d54e
	ds $1

wd54f:: ; d54f
	ds $1

wPlayerOWObject:: ; d550
	ds $1

wd551:: ; d551
	ds $1

wd552:: ; d552
	ds $2

; some flags for something
wd554:: ; d554
	ds $1

	ds $20

wFilteredListPtr:: ; d575
	ds $2

wRemainingIntroCards:: ; d577
	ds $1

	ds $3

wIntroCardsRepeatsAllowed:: ; d57b
	ds $1

	ds $6

wd582:: ; d582
	ds $1

wd583:: ; d583
	ds $1

wd584:: ; d584
	ds $1

wd585:: ; d585
	ds $1

wd586:: ; d586
	ds $1

wd587:: ; d587
	ds $1

wd588:: ; d588
	ds $1

wd589:: ; d589
	ds $1

wd58a:: ; d58a
	ds $1

wd58b:: ; d58b
	ds $1

wd58c:: ; d58c
	ds $2

wd58e:: ; d58e
	ds $1

wd58f:: ; d58f
	ds $1

wd590:: ; d590
	ds $1

wd591:: ; d591
	ds $1

wd592:: ; d592
	ds $1

wd593:: ; d593
	ds $2

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
	ds $34

wd5d2:: ; d5d2
	ds $34

	ds $b

wd611:: ; d611
	ds $1

wd612:: ; d612
	ds $1

wd613:: ; d613
	ds $1

wd614:: ; d614
	ds $1

	ds $1

wd616:: ; d616
	ds $1

wd617:: ; d617
	ds $1

wd618:: ; d618
	ds $1

wd619:: ; d619
	ds $1

wd61a:: ; d61a
	ds $1

wd61b:: ; d61b
	ds $2

wd61d:: ; d61d
	ds $1

wd61e:: ; d61e
	ds $1

	ds $49

wd668:: ; d668
	ds $1

	ds $1

wd66a:: ; d66a
	ds $1

wd66b:: ; d66b
	ds $1

wd66c:: ; d66c
	ds $1

wd66d:: ; d66d
	ds $1

wd66e:: ; d66e
	ds $1

wd66f:: ; d66f
	ds $1

wd670:: ; d670
	ds $1

wd671:: ; d671
	ds $1

wd672:: ; d672
	ds $1

wd673:: ; d673
	ds $1

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

	ds $13

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
	ds 2 * BG_MAP_WIDTH

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

wd7ec:: ; d7ec
	ds $2

wOWAnimatedTiles:: ; d7ee
	ds NUM_OW_ANIMATED_TILES * $4

wd852:: ; d852
	ds $1

wd853:: ; d853
	ds $40

wd893:: ; d893
	ds $2

wd895:: ; d895
	ds $1

wd896:: ; d896
	ds $2

	ds $3

wd89b:: ; d89b
	ds $1

wd89c:: ; d89c
	ds $1

wd89d:: ; d89d
	ds $1

wd89e:: ; d89e
	ds $1

	ds $2

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

wd987:: ; d987
	ds $1

	ds $1

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

wPortraitVariant:: ; d9cf
	ds $1

wd9d0:: ; d9d0
	ds $1

	ds $2

wd9d3:: ; d9d3
	ds $1

wd9d4:: ; d9d4
	ds $1

wd9d5:: ; d9d5
	ds $1

wTextBoxFrameColor:: ; d9d6
	ds $1

	ds $5

wd9dc:: ; d9dc
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

wda97:: ; da97
	ds $1

wda98:: ; da98
	ds $1

wda99:: ; da99
	ds $4

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

	ds $e

wDisplayHours:: ; db10
	ds $2

wDisplayMinutes:: ; db12
	ds $1

wTotalNumCardsToCollect:: ; db13
	ds $2

wTotalNumCardsCollected:: ; db15
	ds $2

	ds $8

wdb1f:: ; db1f
	ds $1

SECTION "WRAM1@dc06", WRAMX

wdc06:: ; dc06
	ds $1

	ds $1

wdc08:: ; dc08
	ds $2

	ds $5

wdc0f:: ; dc0f
	ds $1

	ds $47

wdc57:: ; dc57
	ds $1

	ds $1

wdc59:: ; dc59
	ds $1

	ds $4

wdc5e:: ; dc5e
	ds $2

wdc60:: ; dc60
	ds $80

	ds $2

wdce2:: ; dce2
	ds $1

	ds $2

wdce5:: ; dce5
	ds $1

	ds $2

wdce8:: ; dce8
	ds $1

	ds $1

wdcea:: ; dcea
	ds $1

	ds $5

wdcf0:: ; dcf0
	ds $1

SECTION "WRAM1@dd02", WRAMX

; stores the player's result in a duel (0: win, 1: loss, 2: ???, -1: transmission error?)
; to be read by the overworld caller
wDuelResult:: ; dd02
	ds $1

wdd03:: ; dd03
	ds $1

wdd04:: ; dd04
	ds $1

wdd05:: ; dd05
	ds $1

wdd06:: ; dd06
	ds $1

wdd07:: ; dd07
	ds $1

	ds $1d

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

	ds $6

wdd36:: ; dd36
	ds $1

wdd37:: ; dd37
	ds $19

wdd50:: ; dd50
	ds $1

wdd51:: ; dd51
	ds $9

wdd5a:: ; dd5a
	ds $1

wdd5b:: ; dd5b
	ds $1

wdd5c:: ; dd5c
	ds $1

wdd5d:: ; dd5d
	ds $1

wdd5e:: ; dd5e
	ds $1

wdd5f:: ; dd5f
	ds $1

wdd60:: ; dd60
	ds $1

	ds $12

wdd73:: ; dd73
	ds $1

wdd74:: ; dd74
	ds $1

wdd75:: ; dd75
	ds $1

wdd76:: ; dd76
	ds $1

wdd77:: ; dd77
	ds $1

	ds $1c

wCardTilemap:: ; dd94
	ds $30

wddc4:: ; ddc4
	ds $30

wCardTilemapOffset:: ; ddf4
	ds $1

wddf5:: ; ddf5
	ds $1

	ds $3

wddf9:: ; ddf9
	ds $14

wde0d:: ; de0d
	ds $4

wde11:: ; de11
	ds $4

wde15:: ; de15
	ds $4

wde19:: ; de19
	ds $20

	ds $10

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

wde53:: ; de53
	ds $1

wPlayerName:: ; de54
	ds NAME_BUFFER_LENGTH

wde64:: ; de64
	ds $1

	ds $4

wde69:: ; de69
	ds $2

SECTION "WRAM3", WRAMX

w3d000:: ; d000
	ds $1

	ds $3ff

w3d400:: ; d400
	ds $1

w3d401:: ; d401
	ds $1

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

wd0eb:: ; d0eb
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
