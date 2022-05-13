; screen size
DEF SCREEN_WIDTH  EQU 20 ; tiles
DEF SCREEN_HEIGHT EQU 18 ; tiles

; background map size
DEF BG_MAP_WIDTH  EQU 32 ; tiles
DEF BG_MAP_HEIGHT EQU 32 ; tiles

; cgb palette size
DEF CGB_PAL_SIZE EQU 8 ; bytes
DEF palettes EQUS "* CGB_PAL_SIZE"

DEF NUM_BACKGROUND_PALETTES EQU 8
DEF NUM_OBJECT_PALETTES     EQU 8

DEF PALRGB_WHITE EQU (31 << 10 | 31 << 5 | 31)

; tile size
DEF TILE_SIZE EQU 16 ; bytes
DEF tiles EQUS "* TILE_SIZE"

DEF TILE_SIZE_1BPP EQU 8 ; bytes
DEF tiles_1bpp EQUS "* TILE_SIZE_1BPP"
