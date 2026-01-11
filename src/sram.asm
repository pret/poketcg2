SECTION "SRAM0", SRAM

s0a000:: ; a000
	ds $3

sPrinterContrastLevel:: ; a003
	ds $1

s0a004:: ; a004
	ds $1

sTotalCardPopsDone:: ; a005
	ds $1

sTextSpeed:: ; a006
	ds $1

sDuelAnimationsSetting:: ; a007
	ds $1

s0a008:: ; a008
	ds $1

sSkipDelayAllowed:: ; a009
	ds $1

sClearedGame:: ; a00a
	ds $1

sCoinTossAnimationSetting:: ; a00b
	ds $1

sTextBoxFrameColor:: ; a00c
	ds $1

	ds $3

sPlayerName:: ; a010
	ds NAME_BUFFER_LENGTH

sTotalDuelCounter:: ; a020
	ds $2

; number of link battles the player has played
sLinkDuelCounter:: ; a022
	ds $2

	ds $dc

sCardAndDeckSaveData::

; for each card, how many (0-127) the player owns
; CARD_NOT_OWNED ($80) indicates that the player has not yet seen the card
sCardCollection:: ; a100
	ds CARD_COLLECTION_SIZE

sBuiltDecks::
sDeck1:: deck_struct sDeck1 ; a300
sDeck2:: deck_struct sDeck2 ; a360
sDeck3:: deck_struct sDeck3 ; a3c0
sDeck4:: deck_struct sDeck4 ; a420

	ds $60

sSavedDecks:: ; a4e0
; wSavedDeck1 - wSavedDeck10
FOR n, 1, NUM_DECK_SAVE_MACHINE_SLOTS + 1
sSavedDeck{d:n}:: deck_struct sSavedDeck{d:n}
ENDR

sCurrentlySelectedDeck:: ; b7a0
	ds $1

; keeps track of how many unnamed decks have been built
; as they suffix the number ### in the form of "<PLYAYER>の###デッキ"
; max number is MAX_UNNAMED_DECK_NUM
sUnnamedDeckCounter:: ; b7a1
	ds $2

; each bit represents whether the player has
; obtained a card from a given set
sBoosterPacksObtained:: ; b7a3
	ds $1

	ds $3

sCardAndDeckSaveDataEnd::

	ds $59

sGeneralSaveData:: ; b800

sGeneralSaveDataHeader:: ; b800
	ds $1

; see WRAMToSRAMMapper_GeneralSave
; TODO: break down into each segment (after fully labelling wram?)
sGeneralSaveDataMain:: ; b801
	ds $1b9

sGeneralSaveDataEnd::

	ds $e6

; checksum: swapped order
sGeneralSaveDataChecksum1:: ; baa0
	ds $1

sGeneralSaveDataChecksum0:: ; baa1
	ds $1

sGeneralSaveDataChecksumSeed:: ; baa2
	ds $1

; 0: no save
; 1: saved and backed up
; 2: saved but not backed up
sSaveDataState:: ; baa3
	ds $1

; see WRAMToSRAMMapper_ChallengeMachineSave
; TODO: break down into each segment (after fully labelling wram?)
sChallengeMachineSaveData:: ; baa4
	ds $40
sChallengeMachineSaveDataEnd::

; checksum: swapped order
sChallengeMachineSaveDataChecksum1:: ; bae4
	ds $1

sChallengeMachineSaveDataChecksum0:: ; bae5
	ds $1

sChallengeMachineSaveDataChecksumSeed:: ; bae6
	ds $1

	ds $19

; saved data of the current duel, including a two-byte checksum
; see SaveDuelDataToDE
sCurrentDuel:: ; bb00
	ds $1
sCurrentDuelChecksum:: ; bb01
	ds $3
sCurrentDuelData:: ; bb04
	ds $352

SECTION "SRAM1", SRAM

; keeps track of last 16 player's names that
; this save file has done Card Pop! with
sCardPopNameList:: ; a000
	ds CARDPOP_NAME_LIST_SIZE

sCardPopRecords:: ; a100
	ds MAX_NUM_CARDPOP_RECORDS * CARDPOP_RECORD_SIZE

SECTION "SRAM2", SRAM

; the same structure as SRAM0
; mainly as a backup, much like tcg1
; see BulkCopySRAM

	ds $1800

sBackupGeneralSaveData:: ; b800

sBackupGeneralSaveDataHeader:: ; b800
	ds $1

sBackupGeneralSaveDataMain:: ; b801
	ds $1b9

sBackupGeneralSaveDataEnd::

	ds $e6

sBackupGeneralSaveDataChecksum1:: ; baa0
	ds $1

sBackupGeneralSaveDataChecksum0:: ; baa1
	ds $1

sBackupGeneralSaveDataChecksumSeed:: ; baa2
	ds $1

; see sSaveDataState
sBackupSaveDataState:: ; baa3
	ds $1

sBackupChallengeMachineSaveData:: ; baa4
	ds $40
sBackupChallengeMachineSaveDataEnd::

sBackupChallengeMachineSaveDataChecksum1:: ; bae4
	ds $1

sBackupChallengeMachineSaveDataChecksum0:: ; bae5
	ds $1

sBackupChallengeMachineSaveDataChecksumSeed:: ; bae6
	ds $1

SECTION "SRAM3", SRAM

; buffers used to temporary store gfx related data
; such as tiles or BG maps
sGfxBuffer0:: ; a000
	ds $400

sGfxBuffer1:: ; a400
	ds $400

sGfxBuffer2:: ; a800
	ds $400

sGfxBuffer3:: ; ac00
	ds $400

sGfxBuffer4:: ; b000
	ds $400

sGfxBuffer5:: ; b400
	ds $400
