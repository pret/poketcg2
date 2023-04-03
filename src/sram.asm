SECTION "SRAM0", SRAM

s0a000:: ; a000
	ds $3

	ds $3

sTextSpeed:: ; a006
	ds $1

s0a007:: ; a007
	ds $1

	ds $1

s0a009:: ; a009
	ds $1

	ds $1

s0a00b:: ; a00b
	ds $1

sTextBoxFrameColor:: ; a00c
	ds $1

	ds $3

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

	ds $60

s0a4e0:: ; a4e0
	ds $12c0

sb7a0:: ; b7a0
	ds $1

SECTION "SRAM1", SRAM

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

SECTION "SRAM2", SRAM
