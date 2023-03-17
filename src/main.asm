INCLUDE "macros.asm"
INCLUDE "constants.asm"

SECTION "Game Loop", ROMX
INCLUDE "engine/game_loop.asm"

INCLUDE "engine/duel/core.asm"

SECTION "Bank 3", ROMX
INCLUDE "engine/bank03.asm"

INCLUDE "engine/bank04.asm"

SECTION "Scenes", ROMX[$6eb9], BANK[$4]
INCLUDE "engine/scenes.asm"

SECTION "GBC Only Disclaimer", ROMX[$64fd], BANK[$9]
INCLUDE "engine/gbc_only_disclaimer.asm"

SECTION "Decks", ROMX[$54ac], BANK[$16]
INCLUDE "data/decks.asm"

INCLUDE "engine/bank4b.asm"

SECTION "Gfx Pointers", ROMX[$4545], BANK[$4b]
INCLUDE "data/gfx_pointers/tilemaps.asm"
INCLUDE "data/gfx_pointers/tilesets.asm"
INCLUDE "data/gfx_pointers/palettes.asm"
INCLUDE "data/gfx_pointers/sprite_animations.asm"
INCLUDE "data/gfx_pointers/gfx_unknown3.asm"
INCLUDE "data/gfx_pointers/gfx_unknown2.asm"
INCLUDE "data/gfx_pointers/gfx_unknown1.asm"

SECTION "Tilemaps 1", ROMX[$74f5], BANK[$4b]
INCLUDE "src/data/maps/tilemaps1.asm"

SECTION "Tilemaps 2", ROMX
INCLUDE "src/data/maps/tilemaps2.asm"

SECTION "Tilemaps 3", ROMX
INCLUDE "src/data/maps/tilemaps3.asm"

SECTION "Tilemaps 4", ROMX
INCLUDE "src/data/maps/tilemaps4.asm"

SECTION "Tilemaps 5", ROMX
INCLUDE "src/data/maps/tilemaps5.asm"

SECTION "Tilemaps 6", ROMX
INCLUDE "src/data/maps/tilemaps6.asm"
