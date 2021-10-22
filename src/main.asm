INCLUDE "macros.asm"
INCLUDE "constants.asm"

INCLUDE "engine/home.asm"

SECTION "Bank 1", ROMX[$4000], BANK[$1]
INCLUDE "engine/bank01.asm"

SECTION "Decks", ROMX[$54ac], BANK[$16]
INCLUDE "data/decks.asm"
