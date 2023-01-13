INCLUDE "macros.asm"
INCLUDE "constants.asm"

SECTION "Gfx 1", ROMX

Fonts::

FullWidthFonts::
INCBIN "gfx/fonts/full_width/0_0_katakana.1bpp"
INCBIN "gfx/fonts/full_width/0_1_hiragana.1bpp"
INCBIN "gfx/fonts/full_width/0_2_digits_kanji1.1bpp"
INCBIN "gfx/fonts/full_width/1_kanji2.1bpp"
INCBIN "gfx/fonts/full_width/2_kanji3.1bpp"
INCBIN "gfx/fonts/full_width/3_kanji4.1bpp"
INCBIN "gfx/fonts/full_width/4.1bpp"

INCBIN "gfx/fonts/extra.1bpp"

HalfWidthFont::
INCBIN "gfx/fonts/half_width.1bpp"

SECTION "Gfx 1@7150", ROMX

SymbolsFont::
INCBIN "gfx/fonts/symbols.2bpp"

SECTION "Card Gfx 1", ROMX

CardGraphics::
