SECTION "HRAM", HRAM

hBankROM:: ; ff80
	ds $1
hBankSRAM:: ; ff81
	ds $1
hBankVRAM:: ; ff82
	ds $1
hDMAFunction::
	ds $a
	ds $5
hSCX:: ;ff92
	ds $1
hSCY:: ;ff93
	ds $1
hWX:: ;ff94
	ds $1
hWY:: ;ff95
	ds $1
hLCDC:: ; ff96
	ds $1
	ds $2
hWhoseTurn:: ; ff99
	ds $1
