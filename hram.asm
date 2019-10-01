SECTION "HRAM", HRAM

hBankROM:: ; ff80
	ds $1
hBankSRAM:: ; ff81
	ds $1
hBankVRAM:: ; ff82
	ds $1
	ds $16
hWhoseTurn:: ; ff99
	ds $1