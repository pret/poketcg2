SECTION "SRAM0", SRAM

s0a000:: ; a000
	ds $3

	ds $d

sPlayerName:: ; a010
	ds NAME_BUFFER_LENGTH

	ds $e0

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
