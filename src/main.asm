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

SECTION "Effect Commands", ROMX
INCLUDE "engine/duel/effect_commands.asm"

SECTION "Decks", ROMX
INCLUDE "data/decks.asm"

SECTION "Bank 17", ROMX
INCLUDE "data/card_pointers.asm"
INCLUDE "data/cards1.asm"

SECTION "Bank 18", ROMX
INCLUDE "data/cards2.asm"

SECTION "Effect Functions 2", ROMX
INCLUDE "engine/duel/effect_functions2.asm"

SECTION "Effect Functions 1", ROMX
INCLUDE "engine/duel/effect_functions1.asm"
