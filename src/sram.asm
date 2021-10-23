SECTION "SRAM0", SRAM

s0a000:: ; a000
	ds $3

	ds $d

sPlayerName:: ; a010
	ds NAME_BUFFER_LENGTH
