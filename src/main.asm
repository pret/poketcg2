INCLUDE "macros.asm"
INCLUDE "constants.asm"

SECTION "Game Loop", ROMX
INCLUDE "engine/game_loop.asm"

SECTION "Bank 1", ROMX
INCLUDE "engine/bank01.asm"

SECTION "Bank 3", ROMX
INCLUDE "engine/bank03.asm"

SECTION "Bank 4", ROMX
INCLUDE "engine/bank04.asm"

SECTION "Scenes", ROMX[$6eb9], BANK[$4]
INCLUDE "engine/scenes.asm"

SECTION "Bank 7", ROMX
INCLUDE "engine/bank07.asm"

SECTION "GBC Only Disclaimer", ROMX[$64fd], BANK[$9]
INCLUDE "engine/gbc_only_disclaimer.asm"

SECTION "Bank 11", ROMX
INCLUDE "engine/bank11.asm"

SECTION "Decks", ROMX[$54ac], BANK[$16]
INCLUDE "data/decks.asm"

INCLUDE "engine/bank4b.asm"

SECTION "Gfx Pointers", ROMX[$4545], BANK[$4b]
INCLUDE "data/gfx_pointers/tilemaps.asm"
INCLUDE "data/gfx_pointers/tilesets.asm"
INCLUDE "data/gfx_pointers/palettes.asm"
INCLUDE "data/gfx_pointers/sprite_animations.asm"
INCLUDE "data/gfx_pointers/framesets.asm"
INCLUDE "data/gfx_pointers/gfx_unknown2.asm"
INCLUDE "data/gfx_pointers/gfx_unknown1.asm"
