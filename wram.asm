SECTION "WRAM Bank 0", WRAM0
ds $a00
wOAM:: ; ca00
ds $1
ds $b2
wInitialA:: ; cab3
ds $1
wConsole:: ; cab4
ds $1
wOAMOffset:: ; cab5
ds $1
wTileMapFill:: ; cab6
ds $1
ds $11
wRNG1:: ; cac8
ds $1
SECTION "WRAM Bank 1", WRAMX
