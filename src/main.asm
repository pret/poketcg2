INCLUDE "macros.asm"
INCLUDE "constants.asm"

SECTION "Game Loop", ROMX
INCLUDE "engine/game_loop.asm"

SECTION "Bank 1", ROMX
INCLUDE "engine/bank01.asm"

SECTION "Bank 2", ROMX
INCLUDE "engine/bank02.asm"

SECTION "Bank 3", ROMX
INCLUDE "engine/bank03.asm"

SECTION "Bank 4", ROMX
INCLUDE "engine/bank04.asm"

SECTION "Scenes", ROMX[$6eb9], BANK[$4]
INCLUDE "engine/scenes.asm"

SECTION "Bank 5", ROMX
INCLUDE "engine/bank05.asm"

SECTION "Bank 6", ROMX
INCLUDE "engine/bank06.asm"

SECTION "Bank 7", ROMX
INCLUDE "engine/bank07.asm"

SECTION "Bank 8", ROMX
INCLUDE "engine/bank08.asm"

SECTION "Bank 9", ROMX
INCLUDE "engine/bank09.asm"

SECTION "GBC Only Disclaimer", ROMX[$64fd], BANK[$9]
INCLUDE "engine/gbc_only_disclaimer.asm"

SECTION "Bank a", ROMX
INCLUDE "engine/bank0a.asm"

SECTION "Bank b", ROMX
INCLUDE "engine/bank0b.asm"

SECTION "Bank c", ROMX
INCLUDE "engine/bank0c.asm"

SECTION "Bank d", ROMX
INCLUDE "engine/bank0d.asm"

SECTION "Bank e", ROMX
INCLUDE "engine/bank0e.asm"

SECTION "Bank f", ROMX
INCLUDE "engine/bank0f.asm"

SECTION "Bank 10", ROMX
INCLUDE "engine/bank10.asm"

SECTION "Bank 11", ROMX
INCLUDE "engine/bank11.asm"

SECTION "Bank 12", ROMX
INCLUDE "engine/bank12.asm"

SECTION "Bank 13", ROMX
INCLUDE "engine/bank13.asm"

SECTION "Bank 16", ROMX
INCLUDE "engine/bank16.asm"

SECTION "Bank 17", ROMX
INCLUDE "data/card_pointers.asm"
INCLUDE "data/cards1.asm"

SECTION "Bank 18", ROMX
INCLUDE "data/cards2.asm"

SECTION "Decks", ROMX[$54ac], BANK[$16]
INCLUDE "data/decks.asm"

SECTION "Bank 1a", ROMX
INCLUDE "engine/bank1a.asm"

INCLUDE "engine/bank4b.asm"

SECTION "Gfx Pointers", ROMX[$4545], BANK[$4b]
INCLUDE "data/gfx_pointers/tilemaps.asm"
INCLUDE "data/gfx_pointers/tilesets.asm"
INCLUDE "data/gfx_pointers/palettes.asm"
INCLUDE "data/gfx_pointers/sprite_animations.asm"
INCLUDE "data/gfx_pointers/framesets.asm"
INCLUDE "data/gfx_pointers/ow_tile_frames.asm"
INCLUDE "data/gfx_pointers/ow_animations.asm"

SECTION "Map Gfx", ROMX[$6c59], BANK[$4b]
INCLUDE "data/map_gfx.asm"

SECTION "Bank 4c", ROMX
INCLUDE "engine/bank4c.asm"
