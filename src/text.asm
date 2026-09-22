INCLUDE "macros.asm"
INCLUDE "constants.asm"

INCLUDE "text/text_offsets.asm"

SECTION "Text 1", ROMX
INCLUDE "text/text1.asm"

	ds $e

SECTION "Text 2", ROMX
INCLUDE "text/text2.asm"

	ds $d

SECTION "Text 3", ROMX
INCLUDE "text/text3.asm"

	ds $4

SECTION "Text 4", ROMX
INCLUDE "text/text4.asm"

	ds $b

SECTION "Text 5", ROMX
INCLUDE "text/text5.asm"

	ds $29

SECTION "Text 6", ROMX
INCLUDE "text/text6.asm"

	ds $15

SECTION "Text 7", ROMX
INCLUDE "text/text7.asm"

	ds $7

SECTION "Text 8", ROMX
INCLUDE "text/text8.asm"

	ds $35

SECTION "Text 9", ROMX
INCLUDE "text/text9.asm"

	ds $ae

SECTION "Text 10", ROMX
INCLUDE "text/text10.asm"

	ds $15

SECTION "Text 11", ROMX
INCLUDE "text/text11.asm"

	ds $12

SECTION "Text 12", ROMX
INCLUDE "text/text12.asm"

	ds $d

SECTION "Text 13", ROMX
INCLUDE "text/text13.asm"

	ds $7b

SECTION "Text 14", ROMX
INCLUDE "text/text14.asm"

	ds $1b

SECTION "Text 15", ROMX
INCLUDE "text/text15.asm"

	ds $9

SECTION "Text 16", ROMX
INCLUDE "text/text16.asm"

	ds $34

SECTION "Text 17", ROMX
INCLUDE "text/text17.asm"
