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

SECTION "Gfx 1@70b0", ROMX

Pals_6f0b0::
	rgb 31, 31, 31
	rgb 21, 21, 16
	rgb 10, 10,  8
	rgb  0,  0,  0

	rgb 31, 31, 31
	rgb 31, 14,  0
	rgb 26,  8,  0
	rgb 19,  0,  0

	rgb 31, 31, 31
	rgb  8, 20, 31
	rgb  0, 12, 31
	rgb  0,  0, 31

	rgb 31, 31, 31
	rgb  2, 27,  0
	rgb  0, 19,  6
	rgb  0, 10,  0

	rgb 31, 31, 30
	rgb 21, 21, 16
	rgb 10, 10,  8
	rgb  0,  0,  0

	rgb 31, 31, 31
	rgb 30, 29,  0
	rgb 30,  3,  0
	rgb  0,  0,  0

	rgb 31, 31, 31
	rgb  0, 18,  0
	rgb 12, 11, 20
	rgb  0,  0,  0

	rgb 31, 31, 31
	rgb 22,  0, 22
	rgb 27,  7,  3
	rgb  0,  0,  0

SECTION "Gfx 1@7150", ROMX

SymbolsFont::
INCBIN "gfx/fonts/symbols.2bpp"

SECTION "Card Gfx 1", ROMX

CardGraphics::

SECTION "Tilemaps 1", ROMX[$74f5], BANK[$4b]
INCLUDE "src/data/maps/tilemaps1.asm"

SECTION "Tilemaps 2", ROMX
INCLUDE "src/data/maps/tilemaps2.asm"

Frameset081::
	oamframe  0,  1,   0,   0
	oamreset

SECTION "Tilemaps 3", ROMX
INCLUDE "src/data/maps/tilemaps3.asm"

SECTION "Tilemaps 4", ROMX
INCLUDE "src/data/maps/tilemaps4.asm"

SECTION "Tilemaps 5", ROMX
INCLUDE "src/data/maps/tilemaps5.asm"

SECTION "Tilemaps 6", ROMX
INCLUDE "src/data/maps/tilemaps6.asm"

SECTION "Tilesets 1", ROMX

Tileset000::
	dw 179 ; length
	INCBIN "gfx/tilesets/tileset000.2bpp"

Tileset001::
	dw 8 ; length
	INCBIN "gfx/tilesets/tileset001.2bpp"

Tileset003::
	dw 27 ; length
	INCBIN "gfx/tilesets/tileset003.2bpp"

Tileset02B::
	dw 52 ; length
	INCBIN "gfx/tilesets/tileset02B.2bpp"

Tileset07B::
	dw 4 ; length
	INCBIN "gfx/tilesets/tileset07B.2bpp"

Tileset07C::
	dw 2 ; length
	INCBIN "gfx/tilesets/tileset07C.2bpp"

Tileset15A::
	dw 1 ; length
	INCBIN "gfx/tilesets/tileset15A.2bpp"

SECTION "Tilesets 2", ROMX

Tileset002::
	dw 214 ; length
	INCBIN "gfx/tilesets/tileset002.2bpp"

Tileset004::
	dw 148 ; length
	INCBIN "gfx/tilesets/tileset004.2bpp"

Tileset005::
	dw 134 ; length
	INCBIN "gfx/tilesets/tileset005.2bpp"

Tileset006::
	dw 97 ; length
	INCBIN "gfx/tilesets/tileset006.2bpp"

Tileset007::
	dw 66 ; length
	INCBIN "gfx/tilesets/tileset007.2bpp"

Tileset008::
	dw 82 ; length
	INCBIN "gfx/tilesets/tileset008.2bpp"

Tileset009::
	dw 138 ; length
	INCBIN "gfx/tilesets/tileset009.2bpp"

Tileset00B::
	dw 78 ; length
	INCBIN "gfx/tilesets/tileset00B.2bpp"

Tileset03A::
	dw 46 ; length
	INCBIN "gfx/tilesets/tileset03A.2bpp"

Tileset077::
	dw 12 ; length
	INCBIN "gfx/tilesets/tileset077.2bpp"

Tileset142::
	dw 3 ; length
	INCBIN "gfx/overworld_sprites/tileset142.2bpp"

Tileset143::
	dw 4 ; length
	INCBIN "gfx/overworld_sprites/tileset143.2bpp"

Frameset085::
	oamframe  0,  1,   0,   0
	oamreset

SECTION "Tilesets 3", ROMX

Tileset00A::
	dw 214 ; length
	INCBIN "gfx/tilesets/tileset00A.2bpp"

Tileset00C::
	dw 129 ; length
	INCBIN "gfx/tilesets/tileset00C.2bpp"

Tileset00D::
	dw 193 ; length
	INCBIN "gfx/tilesets/tileset00D.2bpp"

Tileset00E::
	dw 100 ; length
	INCBIN "gfx/tilesets/tileset00E.2bpp"

Tileset00F::
	dw 155 ; length
	INCBIN "gfx/tilesets/tileset00F.2bpp"

Tileset010::
	dw 133 ; length
	INCBIN "gfx/tilesets/tileset010.2bpp"

Tileset011::
	dw 73 ; length
	INCBIN "gfx/tilesets/tileset011.2bpp"

Tileset078::
	dw 16 ; length
	INCBIN "gfx/tilesets/tileset078.2bpp"

Tileset07A::
	dw 8 ; length
	INCBIN "gfx/tilesets/tileset07A.2bpp"

Tileset16B::
	dw 1 ; length
	INCBIN "gfx/tilesets/tileset16B.2bpp"

Palette0D8::
	db 1 ; number of palettes

	rgb 28, 28, 24
	rgb 31, 31,  7
	rgb 31, 24,  6
	rgb 11,  3,  0

SECTION "Tilesets 4", ROMX

Tileset012::
	dw 146 ; length
	INCBIN "gfx/tilesets/tileset012.2bpp"

Tileset013::
	dw 119 ; length
	INCBIN "gfx/tilesets/tileset013.2bpp"

Tileset014::
	dw 78 ; length
	INCBIN "gfx/tilesets/tileset014.2bpp"

Tileset015::
	dw 137 ; length
	INCBIN "gfx/tilesets/tileset015.2bpp"

Tileset016::
	dw 163 ; length
	INCBIN "gfx/tilesets/tileset016.2bpp"

Tileset017::
	dw 91 ; length
	INCBIN "gfx/tilesets/tileset017.2bpp"

Tileset018::
	dw 137 ; length
	INCBIN "gfx/tilesets/tileset018.2bpp"

Tileset01A::
	dw 106 ; length
	INCBIN "gfx/tilesets/tileset01A.2bpp"

Tileset04B::
	dw 44 ; length
	INCBIN "gfx/tilesets/tileset04B.2bpp"

Tileset175::
	dw 1 ; length
	INCBIN "gfx/tilesets/tileset175.2bpp"

Palette0D9::
	db 1 ; number of palettes

	rgb 28, 28, 24
	rgb 31, 31, 31
	rgb 28, 20, 12
	rgb  0,  0,  0

SECTION "Tilesets 5", ROMX

Tileset019::
	dw 169 ; length
	INCBIN "gfx/tilesets/tileset019.2bpp"

Tileset01B::
	dw 137 ; length
	INCBIN "gfx/tilesets/tileset01B.2bpp"

Tileset01C::
	dw 171 ; length
	INCBIN "gfx/tilesets/tileset01C.2bpp"

Tileset01D::
	dw 98 ; length
	INCBIN "gfx/tilesets/tileset01D.2bpp"

Tileset01E::
	dw 143 ; length
	INCBIN "gfx/tilesets/tileset01E.2bpp"

Tileset01F::
	dw 222 ; length
	INCBIN "gfx/tilesets/tileset01F.2bpp"

Tileset025::
	dw 67 ; length
	INCBIN "gfx/tilesets/tileset025.2bpp"

Tileset079::
	dw 13 ; length
	INCBIN "gfx/tilesets/tileset079.2bpp"

Tileset14B::
	dw 2 ; length
	INCBIN "gfx/tilesets/tileset14B.2bpp"

Palette0DE::
	db 1 ; number of palettes

	rgb  0,  0,  0
	rgb 31, 31, 31
	rgb 15, 15, 15
	rgb  0,  0,  0

SECTION "Tilesets 6", ROMX

Tileset020::
	dw 87 ; length
	INCBIN "gfx/tilesets/tileset020.2bpp"

Tileset021::
	dw 208 ; length
	INCBIN "gfx/tilesets/tileset021.2bpp"

Tileset022::
	dw 91 ; length
	INCBIN "gfx/tilesets/tileset022.2bpp"

Tileset023::
	dw 146 ; length
	INCBIN "gfx/tilesets/tileset023.2bpp"

Tileset024::
	dw 177 ; length
	INCBIN "gfx/tilesets/tileset024.2bpp"

Tileset026::
	dw 99 ; length
	INCBIN "gfx/tilesets/tileset026.2bpp"

Tileset027::
	dw 70 ; length
	INCBIN "gfx/tilesets/tileset027.2bpp"

Tileset028::
	dw 87 ; length
	INCBIN "gfx/tilesets/tileset028.2bpp"

Tileset045::
	dw 50 ; length
	INCBIN "gfx/tilesets/tileset045.2bpp"

Tileset144::
	dw 4 ; length
	INCBIN "gfx/overworld_sprites/tileset144.2bpp"

Tileset151::
	dw 3 ; length
	INCBIN "gfx/tilesets/tileset151.2bpp"

Palette0E4::
	db 1 ; number of palettes

	rgb 28, 28, 24
	rgb 30, 28, 13
	rgb 31, 17,  8
	rgb 12,  0,  0

SECTION "Tilesets 7", ROMX

Tileset029::
	dw 208 ; length
	INCBIN "gfx/tilesets/tileset029.2bpp"

Tileset02A::
	dw 72 ; length
	INCBIN "gfx/tilesets/tileset02A.2bpp"

Tileset02C::
	dw 74 ; length
	INCBIN "gfx/tilesets/tileset02C.2bpp"

Tileset02D::
	dw 92 ; length
	INCBIN "gfx/tilesets/tileset02D.2bpp"

Tileset02E::
	dw 175 ; length
	INCBIN "gfx/tilesets/tileset02E.2bpp"

Tileset02F::
	dw 135 ; length
	INCBIN "gfx/tilesets/tileset02F.2bpp"

Tileset030::
	dw 70 ; length
	INCBIN "gfx/tilesets/tileset030.2bpp"

Tileset031::
	dw 79 ; length
	INCBIN "gfx/tilesets/tileset031.2bpp"

Tileset032::
	dw 78 ; length
	INCBIN "gfx/tilesets/tileset032.2bpp"

Tileset054::
	dw 34 ; length
	INCBIN "gfx/tilesets/tileset054.2bpp"

Tileset14C::
	dw 4 ; length
	INCBIN "gfx/tilesets/tileset14C.2bpp"

Tileset1E9::
	dw 1 ; length
	INCBIN "gfx/tilesets/tileset1E9.2bpp"

Frameset086::
	oamframe  4,  1,   0,   0
	oamreset

SECTION "Tilesets 8", ROMX

Tileset033::
	dw 76 ; length
	INCBIN "gfx/tilesets/tileset033.2bpp"

Tileset034::
	dw 112 ; length
	INCBIN "gfx/tilesets/tileset034.2bpp"

Tileset035::
	dw 72 ; length
	INCBIN "gfx/tilesets/tileset035.2bpp"

Tileset036::
	dw 159 ; length
	INCBIN "gfx/tilesets/tileset036.2bpp"

Tileset037::
	dw 84 ; length
	INCBIN "gfx/tilesets/tileset037.2bpp"

Tileset038::
	dw 163 ; length
	INCBIN "gfx/tilesets/tileset038.2bpp"

Tileset039::
	dw 182 ; length
	INCBIN "gfx/tilesets/tileset039.2bpp"

Tileset03B::
	dw 85 ; length
	INCBIN "gfx/tilesets/tileset03B.2bpp"

Tileset03E::
	dw 58 ; length
	INCBIN "gfx/tilesets/tileset03E.2bpp"

Tileset0DD::
	dw 20 ; length
	INCBIN "gfx/overworld_sprites/tileset0DD.2bpp"

Tileset140::
	dw 8 ; length
	INCBIN "gfx/overworld_sprites/tileset140.2bpp"

Tileset156::
	dw 3 ; length
	INCBIN "gfx/tilesets/tileset156.2bpp"

Frameset0BE::
	oamframe  0, 16,   0,   0
	oamreset

SECTION "Tilesets 9", ROMX

Tileset03C::
	dw 140 ; length
	INCBIN "gfx/tilesets/tileset03C.2bpp"

Tileset03D::
	dw 90 ; length
	INCBIN "gfx/tilesets/tileset03D.2bpp"

Tileset03F::
	dw 102 ; length
	INCBIN "gfx/tilesets/tileset03F.2bpp"

Tileset040::
	dw 61 ; length
	INCBIN "gfx/tilesets/tileset040.2bpp"

Tileset041::
	dw 105 ; length
	INCBIN "gfx/tilesets/tileset041.2bpp"

Tileset042::
	dw 72 ; length
	INCBIN "gfx/tilesets/tileset042.2bpp"

Tileset043::
	dw 168 ; length
	INCBIN "gfx/tilesets/tileset043.2bpp"

Tileset044::
	dw 184 ; length
	INCBIN "gfx/tilesets/tileset044.2bpp"

Tileset046::
	dw 84 ; length
	INCBIN "gfx/tilesets/tileset046.2bpp"

Tileset141::
	dw 8 ; length
	INCBIN "gfx/overworld_sprites/tileset141.2bpp"

Tileset149::
	dw 6 ; length
	INCBIN "gfx/tilesets/tileset149.2bpp"

Tileset17D::
	dw 2 ; length
	INCBIN "gfx/tilesets/tileset17D.2bpp"

Frameset103::
	oamframe  0,  1,   0,   0
	oamreset

SECTION "Tilesets 10", ROMX

Tileset047::
	dw 66 ; length
	INCBIN "gfx/tilesets/tileset047.2bpp"

Tileset048::
	dw 80 ; length
	INCBIN "gfx/tilesets/tileset048.2bpp"

Tileset049::
	dw 72 ; length
	INCBIN "gfx/tilesets/tileset049.2bpp"

Tileset04A::
	dw 155 ; length
	INCBIN "gfx/tilesets/tileset04A.2bpp"

Tileset04C::
	dw 93 ; length
	INCBIN "gfx/tilesets/tileset04C.2bpp"

Tileset04D::
	dw 59 ; length
	INCBIN "gfx/tilesets/tileset04D.2bpp"

Tileset04E::
	dw 113 ; length
	INCBIN "gfx/tilesets/tileset04E.2bpp"

Tileset04F::
	dw 79 ; length
	INCBIN "gfx/tilesets/tileset04F.2bpp"

Tileset050::
	dw 116 ; length
	INCBIN "gfx/tilesets/tileset050.2bpp"

Tileset051::
	dw 76 ; length
	INCBIN "gfx/tilesets/tileset051.2bpp"

Tileset053::
	dw 57 ; length
	INCBIN "gfx/tilesets/tileset053.2bpp"

Tileset056::
	dw 56 ; length
	INCBIN "gfx/tilesets/tileset056.2bpp"

Frameset104::
	oamframe  1,  1,   0,   0
	oamreset

SECTION "Tilesets 11", ROMX

Tileset052::
	dw 118 ; length
	INCBIN "gfx/tilesets/tileset052.2bpp"

Tileset055::
	dw 57 ; length
	INCBIN "gfx/tilesets/tileset055.2bpp"

Tileset057::
	dw 50 ; length
	INCBIN "gfx/tilesets/tileset057.2bpp"

Tileset058::
	dw 42 ; length
	INCBIN "gfx/tilesets/tileset058.2bpp"

Tileset059::
	dw 131 ; length
	INCBIN "gfx/tilesets/tileset059.2bpp"

Tileset05A::
	dw 81 ; length
	INCBIN "gfx/tilesets/tileset05A.2bpp"

Tileset05B::
	dw 103 ; length
	INCBIN "gfx/tilesets/tileset05B.2bpp"

Tileset05C::
	dw 210 ; length
	INCBIN "gfx/tilesets/tileset05C.2bpp"

Tileset05D::
	dw 210 ; length
	INCBIN "gfx/tilesets/tileset05D.2bpp"

Tileset0DE::
	dw 20 ; length
	INCBIN "gfx/overworld_sprites/tileset0DE.2bpp"

Palette0E7::
	db 1 ; number of palettes

	rgb  0,  0,  0
	rgb  0, 31, 31
	rgb  0, 15, 31
	rgb  0,  0, 21

SECTION "Tilesets 12", ROMX

Tileset05E::
	dw 207 ; length
	INCBIN "gfx/tilesets/tileset05E.2bpp"

Tileset05F::
	dw 73 ; length
	INCBIN "gfx/tilesets/tileset05F.2bpp"

Tileset060::
	dw 143 ; length
	INCBIN "gfx/tilesets/tileset060.2bpp"

Tileset061::
	dw 121 ; length
	INCBIN "gfx/tilesets/tileset061.2bpp"

Tileset062::
	dw 176 ; length
	INCBIN "gfx/tilesets/tileset062.2bpp"

Tileset063::
	dw 176 ; length
	INCBIN "gfx/tilesets/tileset063.2bpp"

Tileset065::
	dw 52 ; length
	INCBIN "gfx/tilesets/tileset065.2bpp"

Tileset066::
	dw 60 ; length
	INCBIN "gfx/tilesets/tileset066.2bpp"

Tileset145::
	dw 12 ; length
	INCBIN "gfx/tilesets/tileset145.2bpp"

Tileset17E::
	dw 2 ; length
	INCBIN "gfx/tilesets/tileset17E.2bpp"

Palette0EA::
	db 1 ; number of palettes

	rgb 28, 28, 24
	rgb 31, 31, 31
	rgb  7, 26, 31
	rgb  0, 15, 31

SECTION "Tilesets 13", ROMX

Tileset064::
	dw 203 ; length
	INCBIN "gfx/tilesets/tileset064.2bpp"

Tileset067::
	dw 54 ; length
	INCBIN "gfx/tilesets/tileset067.2bpp"

Tileset068::
	dw 39 ; length
	INCBIN "gfx/tilesets/tileset068.2bpp"

Tileset069::
	dw 52 ; length
	INCBIN "gfx/tilesets/tileset069.2bpp"

Tileset06A::
	dw 56 ; length
	INCBIN "gfx/tilesets/tileset06A.2bpp"

Tileset06B::
	dw 52 ; length
	INCBIN "gfx/tilesets/tileset06B.2bpp"

Tileset06C::
	dw 60 ; length
	INCBIN "gfx/tilesets/tileset06C.2bpp"

Tileset06D::
	dw 38 ; length
	INCBIN "gfx/tilesets/tileset06D.2bpp"

Tileset06E::
	dw 56 ; length
	INCBIN "gfx/tilesets/tileset06E.2bpp"

Tileset06F::
	dw 61 ; length
	INCBIN "gfx/tilesets/tileset06F.2bpp"

Tileset070::
	dw 54 ; length
	INCBIN "gfx/tilesets/tileset070.2bpp"

Tileset071::
	dw 32 ; length
	INCBIN "gfx/tilesets/tileset071.2bpp"

Tileset072::
	dw 38 ; length
	INCBIN "gfx/tilesets/tileset072.2bpp"

Tileset073::
	dw 48 ; length
	INCBIN "gfx/tilesets/tileset073.2bpp"

Tileset074::
	dw 34 ; length
	INCBIN "gfx/tilesets/tileset074.2bpp"

Tileset075::
	dw 68 ; length
	INCBIN "gfx/tilesets/tileset075.2bpp"

Tileset07D::
	dw 36 ; length
	INCBIN "gfx/duelists/tileset07D.2bpp"

Tileset07E::
	dw 36 ; length
	INCBIN "gfx/duelists/tileset07E.2bpp"

Tileset172::
	dw 4 ; length
	INCBIN "gfx/tilesets/tileset172.2bpp"

Palette0F1::
	db 1 ; number of palettes

	rgb  0,  0,  0
	rgb 31, 31, 31
	rgb 28, 20, 12
	rgb  0,  0,  0

SECTION "Tilesets 14", ROMX

Tileset076::
	dw 175 ; length
	INCBIN "gfx/tilesets/tileset076.2bpp"

Tileset07F::
	dw 36 ; length
	INCBIN "gfx/duelists/tileset07F.2bpp"

Tileset080::
	dw 36 ; length
	INCBIN "gfx/duelists/tileset080.2bpp"

Tileset081::
	dw 108 ; length
	INCBIN "gfx/duelists/tileset081.2bpp"

Tileset082::
	dw 108 ; length
	INCBIN "gfx/duelists/tileset082.2bpp"

Tileset083::
	dw 108 ; length
	INCBIN "gfx/duelists/tileset083.2bpp"

Tileset084::
	dw 108 ; length
	INCBIN "gfx/duelists/tileset084.2bpp"

Tileset085::
	dw 108 ; length
	INCBIN "gfx/duelists/tileset085.2bpp"

Tileset086::
	dw 108 ; length
	INCBIN "gfx/duelists/tileset086.2bpp"

Tileset087::
	dw 108 ; length
	INCBIN "gfx/duelists/tileset087.2bpp"

Tileset146::
	dw 12 ; length
	INCBIN "gfx/tilesets/tileset146.2bpp"

Tileset158::
	dw 7 ; length
	INCBIN "gfx/tilesets/tileset158.2bpp"

Frameset105::
	oamframe  2,  1,   0,   0
	oamreset

SECTION "Tilesets 15", ROMX

Tileset088::
	dw 108 ; length
	INCBIN "gfx/duelists/tileset088.2bpp"

Tileset089::
	dw 108 ; length
	INCBIN "gfx/duelists/tileset089.2bpp"

Tileset08A::
	dw 108 ; length
	INCBIN "gfx/duelists/tileset08A.2bpp"

Tileset08B::
	dw 108 ; length
	INCBIN "gfx/duelists/tileset08B.2bpp"

Tileset08C::
	dw 108 ; length
	INCBIN "gfx/duelists/tileset08C.2bpp"

Tileset08D::
	dw 108 ; length
	INCBIN "gfx/duelists/tileset08D.2bpp"

Tileset08E::
	dw 108 ; length
	INCBIN "gfx/duelists/tileset08E.2bpp"

Tileset08F::
	dw 108 ; length
	INCBIN "gfx/duelists/tileset08F.2bpp"

Tileset090::
	dw 108 ; length
	INCBIN "gfx/duelists/tileset090.2bpp"

Tileset0DF::
	dw 20 ; length
	INCBIN "gfx/overworld_sprites/tileset0DF.2bpp"

Tileset0E0::
	dw 20 ; length
	INCBIN "gfx/overworld_sprites/tileset0E0.2bpp"

Tileset148::
	dw 9 ; length
	INCBIN "gfx/tilesets/tileset148.2bpp"

Palette05F::
	db 2 ; number of palettes

	rgb 31, 31, 31
	rgb 19, 18, 18
	rgb 12, 12, 11
	rgb  0,  0,  0

	rgb 19, 18, 18
	rgb 12, 12, 11
	rgb  7,  7,  6
	rgb  0,  0,  0

SECTION "Tilesets 16", ROMX

Tileset091::
	dw 108 ; length
	INCBIN "gfx/duelists/tileset091.2bpp"

Tileset092::
	dw 108 ; length
	INCBIN "gfx/duelists/tileset092.2bpp"

Tileset093::
	dw 108 ; length
	INCBIN "gfx/duelists/tileset093.2bpp"

Tileset094::
	dw 108 ; length
	INCBIN "gfx/duelists/tileset094.2bpp"

Tileset095::
	dw 108 ; length
	INCBIN "gfx/duelists/tileset095.2bpp"

Tileset096::
	dw 108 ; length
	INCBIN "gfx/duelists/tileset096.2bpp"

Tileset097::
	dw 108 ; length
	INCBIN "gfx/duelists/tileset097.2bpp"

Tileset098::
	dw 108 ; length
	INCBIN "gfx/duelists/tileset098.2bpp"

Tileset099::
	dw 108 ; length
	INCBIN "gfx/duelists/tileset099.2bpp"

Tileset0E1::
	dw 20 ; length
	INCBIN "gfx/overworld_sprites/tileset0E1.2bpp"

Tileset0E2::
	dw 20 ; length
	INCBIN "gfx/overworld_sprites/tileset0E2.2bpp"

Tileset14A::
	dw 8 ; length
	INCBIN "gfx/tilesets/tileset14A.2bpp"

Tileset1D8::
	dw 2 ; length
	INCBIN "gfx/tilesets/tileset1D8.2bpp"

SECTION "Tilesets 17", ROMX

Tileset09A::
	dw 108 ; length
	INCBIN "gfx/duelists/tileset09A.2bpp"

Tileset09B::
	dw 108 ; length
	INCBIN "gfx/duelists/tileset09B.2bpp"

Tileset09C::
	dw 108 ; length
	INCBIN "gfx/duelists/tileset09C.2bpp"

Tileset09D::
	dw 108 ; length
	INCBIN "gfx/duelists/tileset09D.2bpp"

Tileset09E::
	dw 108 ; length
	INCBIN "gfx/duelists/tileset09E.2bpp"

Tileset09F::
	dw 108 ; length
	INCBIN "gfx/duelists/tileset09F.2bpp"

Tileset0A0::
	dw 108 ; length
	INCBIN "gfx/duelists/tileset0A0.2bpp"

Tileset0A1::
	dw 108 ; length
	INCBIN "gfx/duelists/tileset0A1.2bpp"

Tileset0A2::
	dw 108 ; length
	INCBIN "gfx/duelists/tileset0A2.2bpp"

Tileset0E3::
	dw 20 ; length
	INCBIN "gfx/overworld_sprites/tileset0E3.2bpp"

Tileset0E4::
	dw 20 ; length
	INCBIN "gfx/overworld_sprites/tileset0E4.2bpp"

Tileset14D::
	dw 9 ; length
	INCBIN "gfx/tilesets/tileset14D.2bpp"

Palette0DB::
	db 2 ; number of palettes

	rgb  0,  0,  0
	rgb 31, 31,  0
	rgb 31, 13,  0
	rgb 11,  4,  0

	rgb  0,  0,  0
	rgb 24, 31, 31
	rgb  0, 14, 26
	rgb  0,  4,  4

SECTION "Tilesets 18", ROMX

Tileset0A3::
	dw 108 ; length
	INCBIN "gfx/duelists/tileset0A3.2bpp"

Tileset0A4::
	dw 108 ; length
	INCBIN "gfx/duelists/tileset0A4.2bpp"

Tileset0A5::
	dw 108 ; length
	INCBIN "gfx/duelists/tileset0A5.2bpp"

Tileset0A6::
	dw 108 ; length
	INCBIN "gfx/duelists/tileset0A6.2bpp"

Tileset0A7::
	dw 108 ; length
	INCBIN "gfx/duelists/tileset0A7.2bpp"

Tileset0A8::
	dw 108 ; length
	INCBIN "gfx/duelists/tileset0A8.2bpp"

Tileset0A9::
	dw 108 ; length
	INCBIN "gfx/duelists/tileset0A9.2bpp"

Tileset0AA::
	dw 108 ; length
	INCBIN "gfx/duelists/tileset0AA.2bpp"

Tileset0AB::
	dw 108 ; length
	INCBIN "gfx/duelists/tileset0AB.2bpp"

Tileset0E5::
	dw 20 ; length
	INCBIN "gfx/overworld_sprites/tileset0E5.2bpp"

Tileset0E6::
	dw 20 ; length
	INCBIN "gfx/overworld_sprites/tileset0E6.2bpp"

Tileset14F::
	dw 10 ; length
	INCBIN "gfx/tilesets/tileset14F.2bpp"

Frameset106::
	oamframe  3,  1,   0,   0
	oamreset

SECTION "Tilesets 19", ROMX

Tileset0AC::
	dw 108 ; length
	INCBIN "gfx/duelists/tileset0AC.2bpp"

Tileset0AD::
	dw 108 ; length
	INCBIN "gfx/duelists/tileset0AD.2bpp"

Tileset0AE::
	dw 108 ; length
	INCBIN "gfx/duelists/tileset0AE.2bpp"

Tileset0AF::
	dw 108 ; length
	INCBIN "gfx/duelists/tileset0AF.2bpp"

Tileset0B0::
	dw 108 ; length
	INCBIN "gfx/duelists/tileset0B0.2bpp"

Tileset0B1::
	dw 108 ; length
	INCBIN "gfx/duelists/tileset0B1.2bpp"

Tileset0B2::
	dw 108 ; length
	INCBIN "gfx/duelists/tileset0B2.2bpp"

Tileset0B3::
	dw 108 ; length
	INCBIN "gfx/duelists/tileset0B3.2bpp"

Tileset0B4::
	dw 108 ; length
	INCBIN "gfx/duelists/tileset0B4.2bpp"

Tileset0E7::
	dw 20 ; length
	INCBIN "gfx/overworld_sprites/tileset0E7.2bpp"

Tileset0E8::
	dw 21 ; length
	INCBIN "gfx/overworld_sprites/tileset0E8.2bpp"

Tileset161::
	dw 8 ; length
	INCBIN "gfx/tilesets/tileset161.2bpp"

Palette0DD::
	db 2 ; number of palettes

	rgb  0,  0,  0
	rgb 31, 23, 23
	rgb 31,  6,  7
	rgb  0,  0,  0

	rgb  0,  0,  0
	rgb 31, 23, 23
	rgb 31, 27, 27
	rgb 31, 31, 31

SECTION "Tilesets 20", ROMX

Tileset0B5::
	dw 108 ; length
	INCBIN "gfx/duelists/tileset0B5.2bpp"

Tileset0B6::
	dw 108 ; length
	INCBIN "gfx/duelists/tileset0B6.2bpp"

Tileset0B7::
	dw 108 ; length
	INCBIN "gfx/duelists/tileset0B7.2bpp"

Tileset0B8::
	dw 108 ; length
	INCBIN "gfx/duelists/tileset0B8.2bpp"

Tileset0B9::
	dw 108 ; length
	INCBIN "gfx/duelists/tileset0B9.2bpp"

Tileset0BA::
	dw 108 ; length
	INCBIN "gfx/duelists/tileset0BA.2bpp"

Tileset0BB::
	dw 108 ; length
	INCBIN "gfx/duelists/tileset0BB.2bpp"

Tileset0BC::
	dw 108 ; length
	INCBIN "gfx/duelists/tileset0BC.2bpp"

Tileset0BD::
	dw 108 ; length
	INCBIN "gfx/duelists/tileset0BD.2bpp"

Tileset0E9::
	dw 20 ; length
	INCBIN "gfx/overworld_sprites/tileset0E9.2bpp"

Tileset0EA::
	dw 27 ; length
	INCBIN "gfx/overworld_sprites/tileset0EA.2bpp"

Tileset17F::
	dw 3 ; length
	INCBIN "gfx/tilesets/tileset17F.2bpp"

Frameset107::
	oamframe  0,  1,   0,   0
	oamreset

SECTION "Tilesets 21", ROMX

Tileset0BE::
	dw 108 ; length
	INCBIN "gfx/duelists/tileset0BE.2bpp"

Tileset0BF::
	dw 108 ; length
	INCBIN "gfx/duelists/tileset0BF.2bpp"

Tileset0C0::
	dw 108 ; length
	INCBIN "gfx/duelists/tileset0C0.2bpp"

Tileset0C1::
	dw 108 ; length
	INCBIN "gfx/duelists/tileset0C1.2bpp"

Tileset0C2::
	dw 108 ; length
	INCBIN "gfx/duelists/tileset0C2.2bpp"

Tileset0C3::
	dw 108 ; length
	INCBIN "gfx/duelists/tileset0C3.2bpp"

Tileset0C4::
	dw 108 ; length
	INCBIN "gfx/duelists/tileset0C4.2bpp"

Tileset0C5::
	dw 108 ; length
	INCBIN "gfx/duelists/tileset0C5.2bpp"

Tileset0C6::
	dw 108 ; length
	INCBIN "gfx/duelists/tileset0C6.2bpp"

Tileset0EB::
	dw 27 ; length
	INCBIN "gfx/overworld_sprites/tileset0EB.2bpp"

Tileset0EC::
	dw 20 ; length
	INCBIN "gfx/overworld_sprites/tileset0EC.2bpp"

Tileset182::
	dw 3 ; length
	INCBIN "gfx/tilesets/tileset182.2bpp"

Frameset108::
	oamframe  1,  1,   0,   0
	oamreset

SECTION "Tilesets 22", ROMX

Tileset0C7::
	dw 108 ; length
	INCBIN "gfx/duelists/tileset0C7.2bpp"

Tileset0C8::
	dw 108 ; length
	INCBIN "gfx/duelists/tileset0C8.2bpp"

Tileset0C9::
	dw 108 ; length
	INCBIN "gfx/duelists/tileset0C9.2bpp"

Tileset0CA::
	dw 108 ; length
	INCBIN "gfx/duelists/tileset0CA.2bpp"

Tileset0CB::
	dw 108 ; length
	INCBIN "gfx/duelists/tileset0CB.2bpp"

Tileset0CC::
	dw 108 ; length
	INCBIN "gfx/duelists/tileset0CC.2bpp"

Tileset0CD::
	dw 108 ; length
	INCBIN "gfx/duelists/tileset0CD.2bpp"

Tileset0CE::
	dw 108 ; length
	INCBIN "gfx/duelists/tileset0CE.2bpp"

Tileset0CF::
	dw 108 ; length
	INCBIN "gfx/duelists/tileset0CF.2bpp"

Tileset0ED::
	dw 20 ; length
	INCBIN "gfx/overworld_sprites/tileset0ED.2bpp"

Tileset0EE::
	dw 20 ; length
	INCBIN "gfx/overworld_sprites/tileset0EE.2bpp"

Tileset15D::
	dw 10 ; length
	INCBIN "gfx/tilesets/tileset15D.2bpp"

Frameset109::
	oamframe  2,  1,   0,   0
	oamreset

SECTION "Tilesets 23", ROMX

Tileset0D0::
	dw 108 ; length
	INCBIN "gfx/duelists/tileset0D0.2bpp"

Tileset0D1::
	dw 108 ; length
	INCBIN "gfx/duelists/tileset0D1.2bpp"

Tileset0D2::
	dw 108 ; length
	INCBIN "gfx/duelists/tileset0D2.2bpp"

Tileset0D3::
	dw 108 ; length
	INCBIN "gfx/duelists/tileset0D3.2bpp"

Tileset0D4::
	dw 108 ; length
	INCBIN "gfx/duelists/tileset0D4.2bpp"

Tileset0D5::
	dw 108 ; length
	INCBIN "gfx/duelists/tileset0D5.2bpp"

Tileset0D6::
	dw 108 ; length
	INCBIN "gfx/duelists/tileset0D6.2bpp"

Tileset0D7::
	dw 108 ; length
	INCBIN "gfx/duelists/tileset0D7.2bpp"

Tileset0D8::
	dw 108 ; length
	INCBIN "gfx/duelists/tileset0D8.2bpp"

Tileset0EF::
	dw 20 ; length
	INCBIN "gfx/overworld_sprites/tileset0EF.2bpp"

Tileset0F0::
	dw 20 ; length
	INCBIN "gfx/overworld_sprites/tileset0F0.2bpp"

Tileset169::
	dw 8 ; length
	INCBIN "gfx/tilesets/tileset169.2bpp"

Palette03B::
	db 4 ; number of palettes

	rgb  6, 25,  5
	rgb  0, 12,  0
	rgb 26, 31, 31
	rgb  0,  0,  2

	rgb  0, 20,  0
	rgb  0, 12,  0
	rgb 19, 31, 31
	rgb  0,  0,  2

	rgb  0, 20,  0
	rgb  0, 12,  0
	rgb 11, 29, 29
	rgb  0,  0,  2

	rgb  0, 20,  0
	rgb  0, 12,  0
	rgb  7, 23, 25
	rgb  0,  0,  2

SECTION "Tilesets 24", ROMX

Tileset0D9::
	dw 108 ; length
	INCBIN "gfx/duelists/tileset0D9.2bpp"

Tileset0DA::
	dw 108 ; length
	INCBIN "gfx/duelists/tileset0DA.2bpp"

Tileset0DB::
	dw 108 ; length
	INCBIN "gfx/duelists/tileset0DB.2bpp"

Tileset0DC::
	dw 108 ; length
	INCBIN "gfx/duelists/tileset0DC.2bpp"

Tileset0F1::
	dw 20 ; length
	INCBIN "gfx/overworld_sprites/tileset0F1.2bpp"

Tileset0F2::
	dw 23 ; length
	INCBIN "gfx/overworld_sprites/tileset0F2.2bpp"

Tileset0F3::
	dw 20 ; length
	INCBIN "gfx/overworld_sprites/tileset0F3.2bpp"

Tileset0F4::
	dw 28 ; length
	INCBIN "gfx/overworld_sprites/tileset0F4.2bpp"

Tileset0F5::
	dw 20 ; length
	INCBIN "gfx/overworld_sprites/tileset0F5.2bpp"

Tileset0F6::
	dw 23 ; length
	INCBIN "gfx/overworld_sprites/tileset0F6.2bpp"

Tileset0F7::
	dw 21 ; length
	INCBIN "gfx/overworld_sprites/tileset0F7.2bpp"

Tileset0F8::
	dw 20 ; length
	INCBIN "gfx/overworld_sprites/tileset0F8.2bpp"

Tileset0F9::
	dw 20 ; length
	INCBIN "gfx/overworld_sprites/tileset0F9.2bpp"

Tileset0FA::
	dw 20 ; length
	INCBIN "gfx/overworld_sprites/tileset0FA.2bpp"

Tileset0FB::
	dw 20 ; length
	INCBIN "gfx/overworld_sprites/tileset0FB.2bpp"

Tileset0FC::
	dw 20 ; length
	INCBIN "gfx/overworld_sprites/tileset0FC.2bpp"

Tileset0FD::
	dw 20 ; length
	INCBIN "gfx/overworld_sprites/tileset0FD.2bpp"

Tileset0FE::
	dw 20 ; length
	INCBIN "gfx/overworld_sprites/tileset0FE.2bpp"

Tileset0FF::
	dw 20 ; length
	INCBIN "gfx/overworld_sprites/tileset0FF.2bpp"

Tileset100::
	dw 20 ; length
	INCBIN "gfx/overworld_sprites/tileset100.2bpp"

Tileset101::
	dw 20 ; length
	INCBIN "gfx/overworld_sprites/tileset101.2bpp"

Tileset102::
	dw 20 ; length
	INCBIN "gfx/overworld_sprites/tileset102.2bpp"

Tileset103::
	dw 20 ; length
	INCBIN "gfx/overworld_sprites/tileset103.2bpp"

Tileset104::
	dw 20 ; length
	INCBIN "gfx/overworld_sprites/tileset104.2bpp"

Tileset105::
	dw 20 ; length
	INCBIN "gfx/overworld_sprites/tileset105.2bpp"

Tileset106::
	dw 20 ; length
	INCBIN "gfx/overworld_sprites/tileset106.2bpp"

Tileset107::
	dw 20 ; length
	INCBIN "gfx/overworld_sprites/tileset107.2bpp"

Tileset108::
	dw 20 ; length
	INCBIN "gfx/overworld_sprites/tileset108.2bpp"

Tileset109::
	dw 20 ; length
	INCBIN "gfx/overworld_sprites/tileset109.2bpp"

Tileset10A::
	dw 20 ; length
	INCBIN "gfx/overworld_sprites/tileset10A.2bpp"

Tileset10B::
	dw 40 ; length
	INCBIN "gfx/overworld_sprites/tileset10B.2bpp"

Tileset153::
	dw 13 ; length
	INCBIN "gfx/tilesets/tileset153.2bpp"

SECTION "Tilesets 25", ROMX

Tileset10C::
	dw 20 ; length
	INCBIN "gfx/overworld_sprites/tileset10C.2bpp"

Tileset10D::
	dw 21 ; length
	INCBIN "gfx/overworld_sprites/tileset10D.2bpp"

Tileset10E::
	dw 20 ; length
	INCBIN "gfx/overworld_sprites/tileset10E.2bpp"

Tileset10F::
	dw 20 ; length
	INCBIN "gfx/overworld_sprites/tileset10F.2bpp"

Tileset110::
	dw 20 ; length
	INCBIN "gfx/overworld_sprites/tileset110.2bpp"

Tileset111::
	dw 24 ; length
	INCBIN "gfx/overworld_sprites/tileset111.2bpp"

Tileset112::
	dw 25 ; length
	INCBIN "gfx/overworld_sprites/tileset112.2bpp"

Tileset113::
	dw 25 ; length
	INCBIN "gfx/overworld_sprites/tileset113.2bpp"

Tileset114::
	dw 21 ; length
	INCBIN "gfx/overworld_sprites/tileset114.2bpp"

Tileset115::
	dw 27 ; length
	INCBIN "gfx/overworld_sprites/tileset115.2bpp"

Tileset116::
	dw 21 ; length
	INCBIN "gfx/overworld_sprites/tileset116.2bpp"

Tileset117::
	dw 20 ; length
	INCBIN "gfx/overworld_sprites/tileset117.2bpp"

Tileset118::
	dw 20 ; length
	INCBIN "gfx/overworld_sprites/tileset118.2bpp"

Tileset119::
	dw 21 ; length
	INCBIN "gfx/overworld_sprites/tileset119.2bpp"

Tileset11A::
	dw 34 ; length
	INCBIN "gfx/overworld_sprites/tileset11A.2bpp"

Tileset11B::
	dw 38 ; length
	INCBIN "gfx/overworld_sprites/tileset11B.2bpp"

Tileset11C::
	dw 20 ; length
	INCBIN "gfx/overworld_sprites/tileset11C.2bpp"

Tileset11D::
	dw 20 ; length
	INCBIN "gfx/overworld_sprites/tileset11D.2bpp"

Tileset11E::
	dw 23 ; length
	INCBIN "gfx/overworld_sprites/tileset11E.2bpp"

Tileset11F::
	dw 20 ; length
	INCBIN "gfx/overworld_sprites/tileset11F.2bpp"

Tileset120::
	dw 20 ; length
	INCBIN "gfx/overworld_sprites/tileset120.2bpp"

Tileset121::
	dw 20 ; length
	INCBIN "gfx/overworld_sprites/tileset121.2bpp"

Tileset122::
	dw 20 ; length
	INCBIN "gfx/overworld_sprites/tileset122.2bpp"

Tileset123::
	dw 20 ; length
	INCBIN "gfx/overworld_sprites/tileset123.2bpp"

Tileset124::
	dw 20 ; length
	INCBIN "gfx/overworld_sprites/tileset124.2bpp"

Tileset125::
	dw 20 ; length
	INCBIN "gfx/overworld_sprites/tileset125.2bpp"

Tileset126::
	dw 20 ; length
	INCBIN "gfx/overworld_sprites/tileset126.2bpp"

Tileset127::
	dw 20 ; length
	INCBIN "gfx/overworld_sprites/tileset127.2bpp"

Tileset128::
	dw 20 ; length
	INCBIN "gfx/overworld_sprites/tileset128.2bpp"

Tileset129::
	dw 20 ; length
	INCBIN "gfx/overworld_sprites/tileset129.2bpp"

Tileset12A::
	dw 20 ; length
	INCBIN "gfx/overworld_sprites/tileset12A.2bpp"

Tileset12B::
	dw 20 ; length
	INCBIN "gfx/overworld_sprites/tileset12B.2bpp"

Tileset12C::
	dw 20 ; length
	INCBIN "gfx/overworld_sprites/tileset12C.2bpp"

Tileset12D::
	dw 20 ; length
	INCBIN "gfx/overworld_sprites/tileset12D.2bpp"

Tileset12E::
	dw 20 ; length
	INCBIN "gfx/overworld_sprites/tileset12E.2bpp"

Tileset12F::
	dw 20 ; length
	INCBIN "gfx/overworld_sprites/tileset12F.2bpp"

Tileset130::
	dw 30 ; length
	INCBIN "gfx/overworld_sprites/tileset130.2bpp"

Tileset131::
	dw 20 ; length
	INCBIN "gfx/overworld_sprites/tileset131.2bpp"

Tileset132::
	dw 20 ; length
	INCBIN "gfx/overworld_sprites/tileset132.2bpp"

Tileset133::
	dw 20 ; length
	INCBIN "gfx/overworld_sprites/tileset133.2bpp"

Tileset134::
	dw 20 ; length
	INCBIN "gfx/overworld_sprites/tileset134.2bpp"

Tileset135::
	dw 20 ; length
	INCBIN "gfx/overworld_sprites/tileset135.2bpp"

Tileset136::
	dw 20 ; length
	INCBIN "gfx/overworld_sprites/tileset136.2bpp"

Tileset137::
	dw 20 ; length
	INCBIN "gfx/overworld_sprites/tileset137.2bpp"

Tileset138::
	dw 20 ; length
	INCBIN "gfx/overworld_sprites/tileset138.2bpp"

Tileset139::
	dw 20 ; length
	INCBIN "gfx/overworld_sprites/tileset139.2bpp"

Tileset13A::
	dw 20 ; length
	INCBIN "gfx/overworld_sprites/tileset13A.2bpp"

Tileset16A::
	dw 7 ; length
	INCBIN "gfx/tilesets/tileset16A.2bpp"

Palette0FD::
	db 1 ; number of palettes

	rgb 16,  0,  0
	rgb 26, 29, 31
	rgb 13, 16, 28
	rgb  6,  7,  0

SECTION "Tilesets 26", ROMX

Tileset13B::
	dw 20 ; length
	INCBIN "gfx/overworld_sprites/tileset13B.2bpp"

Tileset13C::
	dw 20 ; length
	INCBIN "gfx/overworld_sprites/tileset13C.2bpp"

Tileset13D::
	dw 20 ; length
	INCBIN "gfx/overworld_sprites/tileset13D.2bpp"

Tileset13E::
	dw 20 ; length
	INCBIN "gfx/overworld_sprites/tileset13E.2bpp"

Tileset13F::
	dw 20 ; length
	INCBIN "gfx/overworld_sprites/tileset13F.2bpp"

Tileset147::
	dw 37 ; length
	INCBIN "gfx/tilesets/tileset147.2bpp"

Tileset14E::
	dw 25 ; length
	INCBIN "gfx/tilesets/tileset14E.2bpp"

Tileset150::
	dw 17 ; length
	INCBIN "gfx/tilesets/tileset150.2bpp"

Tileset152::
	dw 46 ; length
	INCBIN "gfx/tilesets/tileset152.2bpp"

Tileset154::
	dw 28 ; length
	INCBIN "gfx/tilesets/tileset154.2bpp"

Tileset155::
	dw 76 ; length
	INCBIN "gfx/tilesets/tileset155.2bpp"

Tileset157::
	dw 27 ; length
	INCBIN "gfx/tilesets/tileset157.2bpp"

Tileset159::
	dw 12 ; length
	INCBIN "gfx/tilesets/tileset159.2bpp"

Tileset15B::
	dw 36 ; length
	INCBIN "gfx/tilesets/tileset15B.2bpp"

Tileset15C::
	dw 32 ; length
	INCBIN "gfx/tilesets/tileset15C.2bpp"

Tileset15E::
	dw 37 ; length
	INCBIN "gfx/tilesets/tileset15E.2bpp"

Tileset15F::
	dw 24 ; length
	INCBIN "gfx/tilesets/tileset15F.2bpp"

Tileset160::
	dw 27 ; length
	INCBIN "gfx/tilesets/tileset160.2bpp"

Tileset162::
	dw 13 ; length
	INCBIN "gfx/tilesets/tileset162.2bpp"

Tileset163::
	dw 34 ; length
	INCBIN "gfx/tilesets/tileset163.2bpp"

Tileset164::
	dw 12 ; length
	INCBIN "gfx/tilesets/tileset164.2bpp"

Tileset165::
	dw 37 ; length
	INCBIN "gfx/tilesets/tileset165.2bpp"

Tileset166::
	dw 34 ; length
	INCBIN "gfx/tilesets/tileset166.2bpp"

Tileset167::
	dw 12 ; length
	INCBIN "gfx/tilesets/tileset167.2bpp"

Tileset168::
	dw 76 ; length
	INCBIN "gfx/tilesets/tileset168.2bpp"

Tileset16C::
	dw 26 ; length
	INCBIN "gfx/tilesets/tileset16C.2bpp"

Tileset16D::
	dw 10 ; length
	INCBIN "gfx/tilesets/tileset16D.2bpp"

Tileset16E::
	dw 46 ; length
	INCBIN "gfx/tilesets/tileset16E.2bpp"

Tileset16F::
	dw 8 ; length
	INCBIN "gfx/tilesets/tileset16F.2bpp"

Tileset170::
	dw 7 ; length
	INCBIN "gfx/tilesets/tileset170.2bpp"

Tileset171::
	dw 28 ; length
	INCBIN "gfx/tilesets/tileset171.2bpp"

Tileset173::
	dw 8 ; length
	INCBIN "gfx/tilesets/tileset173.2bpp"

Tileset174::
	dw 11 ; length
	INCBIN "gfx/tilesets/tileset174.2bpp"

Tileset176::
	dw 28 ; length
	INCBIN "gfx/tilesets/tileset176.2bpp"

Tileset177::
	dw 22 ; length
	INCBIN "gfx/tilesets/tileset177.2bpp"

Tileset178::
	dw 16 ; length
	INCBIN "gfx/tilesets/tileset178.2bpp"

Tileset179::
	dw 15 ; length
	INCBIN "gfx/tilesets/tileset179.2bpp"

Tileset17A::
	dw 7 ; length
	INCBIN "gfx/tilesets/tileset17A.2bpp"

Tileset17B::
	dw 10 ; length
	INCBIN "gfx/tilesets/tileset17B.2bpp"

Tileset17C::
	dw 9 ; length
	INCBIN "gfx/tilesets/tileset17C.2bpp"

Tileset180::
	dw 8 ; length
	INCBIN "gfx/tilesets/tileset180.2bpp"

Tileset181::
	dw 17 ; length
	INCBIN "gfx/tilesets/tileset181.2bpp"

Palette103::
	db 1 ; number of palettes

	rgb 11, 11, 11
	rgb 31, 31, 30
	rgb 31,  0, 30
	rgb  5,  2,  0

SECTION "Tilesets 27", ROMX

Tileset183::
	dw 43 ; length
	INCBIN "gfx/tilesets/tileset183.2bpp"

Tileset184::
	dw 12 ; length
	INCBIN "gfx/tilesets/tileset184.2bpp"

Tileset185::
	dw 49 ; length
	INCBIN "gfx/tilesets/tileset185.2bpp"

Tileset186::
	dw 34 ; length
	INCBIN "gfx/tilesets/tileset186.2bpp"

Tileset187::
	dw 67 ; length
	INCBIN "gfx/tilesets/tileset187.2bpp"

Tileset188::
	dw 45 ; length
	INCBIN "gfx/tilesets/tileset188.2bpp"

Tileset189::
	dw 46 ; length
	INCBIN "gfx/tilesets/tileset189.2bpp"

Tileset18A::
	dw 49 ; length
	INCBIN "gfx/tilesets/tileset18A.2bpp"

Tileset18B::
	dw 15 ; length
	INCBIN "gfx/tilesets/tileset18B.2bpp"

Tileset18C::
	dw 94 ; length
	INCBIN "gfx/tilesets/tileset18C.2bpp"

Tileset18D::
	dw 90 ; length
	INCBIN "gfx/tilesets/tileset18D.2bpp"

Tileset18E::
	dw 60 ; length
	INCBIN "gfx/tilesets/tileset18E.2bpp"

Tileset18F::
	dw 52 ; length
	INCBIN "gfx/tilesets/tileset18F.2bpp"

Tileset190::
	dw 7 ; length
	INCBIN "gfx/tilesets/tileset190.2bpp"

Tileset191::
	dw 63 ; length
	INCBIN "gfx/tilesets/tileset191.2bpp"

Tileset192::
	dw 18 ; length
	INCBIN "gfx/tilesets/tileset192.2bpp"

Tileset193::
	dw 50 ; length
	INCBIN "gfx/tilesets/tileset193.2bpp"

Tileset194::
	dw 38 ; length
	INCBIN "gfx/tilesets/tileset194.2bpp"

Tileset195::
	dw 12 ; length
	INCBIN "gfx/tilesets/tileset195.2bpp"

Tileset196::
	dw 25 ; length
	INCBIN "gfx/tilesets/tileset196.2bpp"

Tileset197::
	dw 3 ; length
	INCBIN "gfx/tilesets/tileset197.2bpp"

Tileset198::
	dw 23 ; length
	INCBIN "gfx/tilesets/tileset198.2bpp"

Tileset199::
	dw 12 ; length
	INCBIN "gfx/tilesets/tileset199.2bpp"

Tileset19A::
	dw 12 ; length
	INCBIN "gfx/tilesets/tileset19A.2bpp"

Tileset19B::
	dw 70 ; length
	INCBIN "gfx/tilesets/tileset19B.2bpp"

Tileset19C::
	dw 12 ; length
	INCBIN "gfx/tilesets/tileset19C.2bpp"

Tileset19E::
	dw 8 ; length
	INCBIN "gfx/tilesets/tileset19E.2bpp"

Tileset1A3::
	dw 8 ; length
	INCBIN "gfx/tilesets/tileset1A3.2bpp"

Palette000::
	db 6 ; number of palettes

	rgb 31, 31, 31
	rgb  8, 26,  0
	rgb  1, 15,  0
	rgb  1,  0,  5

	rgb 31, 31, 31
	rgb 25, 18,  6
	rgb 15,  6,  0
	rgb  1,  0,  5

	rgb 31, 31, 31
	rgb  8, 26,  0
	rgb 31,  0,  0
	rgb  1,  0,  5

	rgb 31, 31, 31
	rgb  8, 26,  0
	rgb 25, 18,  6
	rgb  1,  0,  5

	rgb 31, 31, 31
	rgb  8, 26,  0
	rgb  9,  3, 31
	rgb  1,  0,  5

	rgb 31, 31, 31
	rgb 25, 18,  6
	rgb  9,  3, 31
	rgb  1,  0,  5

SECTION "Tilesets 28", ROMX

Tileset19D::
	dw 72 ; length
	INCBIN "gfx/tilesets/tileset19D.2bpp"

Tileset19F::
	dw 23 ; length
	INCBIN "gfx/tilesets/tileset19F.2bpp"

Tileset1A0::
	dw 72 ; length
	INCBIN "gfx/tilesets/tileset1A0.2bpp"

Tileset1A1::
	dw 22 ; length
	INCBIN "gfx/tilesets/tileset1A1.2bpp"

Tileset1A2::
	dw 16 ; length
	INCBIN "gfx/tilesets/tileset1A2.2bpp"

Tileset1A4::
	dw 5 ; length
	INCBIN "gfx/tilesets/tileset1A4.2bpp"

Pikachu2CoinGfx::
	dw 23 ; length
	INCBIN "gfx/coins/pikachu2.2bpp"

Tileset1A6::
	dw 54 ; length
	INCBIN "gfx/tilesets/tileset1A6.2bpp"

Tileset1A7::
	dw 239 ; length
	INCBIN "gfx/coins/tileset1A7.2bpp"

ChanseyCoinGfx::
	dw 39 ; length
	INCBIN "gfx/coins/chansey.2bpp"

OddishCoinGfx::
	dw 39 ; length
	INCBIN "gfx/coins/oddish.2bpp"

CharmanderCoinGfx::
	dw 39 ; length
	INCBIN "gfx/coins/charmander.2bpp"

StarmieCoinGfx::
	dw 39 ; length
	INCBIN "gfx/coins/starmie.2bpp"

PikachuCoinGfx::
	dw 39 ; length
	INCBIN "gfx/coins/pikachu.2bpp"

AlakazamCoinGfx::
	dw 39 ; length
	INCBIN "gfx/coins/alakazam.2bpp"

KabutoCoinGfx::
	dw 39 ; length
	INCBIN "gfx/coins/kabuto.2bpp"

GRCoinGfx::
	dw 39 ; length
	INCBIN "gfx/coins/gr.2bpp"

GolbatCoinGfx::
	dw 39 ; length
	INCBIN "gfx/coins/golbat.2bpp"

MagnemiteCoinGfx::
	dw 39 ; length
	INCBIN "gfx/coins/magnemite.2bpp"

MagmarCoinGfx::
	dw 39 ; length
	INCBIN "gfx/coins/magmar.2bpp"

PsyduckCoinGfx::
	dw 39 ; length
	INCBIN "gfx/coins/psyduck.2bpp"

Tileset1CC::
	dw 23 ; length
	INCBIN "gfx/scenes/tileset1CC.2bpp"

Tileset1E5::
	dw 4 ; length
	INCBIN "gfx/tilesets/tileset1E5.2bpp"

SECTION "Tilesets 29", ROMX

MachampCoinGfx::
	dw 39 ; length
	INCBIN "gfx/coins/machamp.2bpp"

MewCoinGfx::
	dw 39 ; length
	INCBIN "gfx/coins/mew.2bpp"

SnorlaxCoinGfx::
	dw 39 ; length
	INCBIN "gfx/coins/snorlax.2bpp"

TogepiCoinGfx::
	dw 39 ; length
	INCBIN "gfx/coins/togepi.2bpp"

PonytaCoinGfx::
	dw 39 ; length
	INCBIN "gfx/coins/ponyta.2bpp"

HorseaCoinGfx::
	dw 39 ; length
	INCBIN "gfx/coins/horsea.2bpp"

ArbokCoinGfx::
	dw 39 ; length
	INCBIN "gfx/coins/arbok.2bpp"

JigglypuffCoinGfx::
	dw 39 ; length
	INCBIN "gfx/coins/jigglypuff.2bpp"

DugtrioCoinGfx::
	dw 39 ; length
	INCBIN "gfx/coins/dugtrio.2bpp"

GengarCoinGfx::
	dw 39 ; length
	INCBIN "gfx/coins/gengar.2bpp"

RaichuCoinGfx::
	dw 39 ; length
	INCBIN "gfx/coins/raichu.2bpp"

LugiaCoinGfx::
	dw 39 ; length
	INCBIN "gfx/coins/lugia.2bpp"

Tileset1C0::
	dw 86 ; length
	INCBIN "gfx/scenes/tileset1C0.2bpp"

Tileset1C1::
	dw 95 ; length
	INCBIN "gfx/scenes/tileset1C1.2bpp"

Tileset1C2::
	dw 86 ; length
	INCBIN "gfx/scenes/tileset1C2.2bpp"

Tileset1C3::
	dw 95 ; length
	INCBIN "gfx/scenes/tileset1C3.2bpp"

Tileset1C4::
	dw 96 ; length
	INCBIN "gfx/scenes/tileset1C4.2bpp"

Tileset1C5::
	dw 68 ; length
	INCBIN "gfx/scenes/tileset1C5.2bpp"

Tileset1D2::
	dw 6 ; length
	INCBIN "gfx/tilesets/tileset1D2.2bpp"

Tileset1D3::
	dw 6 ; length
	INCBIN "gfx/tilesets/tileset1D3.2bpp"

Tileset1D4::
	dw 8 ; length
	INCBIN "gfx/tilesets/tileset1D4.2bpp"

Tileset1DC::
	dw 6 ; length
	INCBIN "gfx/scenes/tileset1DC.2bpp"

Palette0E1::
	db 2 ; number of palettes

	rgb  0,  0,  0
	rgb 31, 31, 31
	rgb 31, 31,  0
	rgb  0,  0,  0

	rgb  0,  0,  0
	rgb 31,  0,  0
	rgb 31, 13,  0
	rgb 31, 31,  0

SECTION "Tilesets 30", ROMX

Tileset1C6::
	dw 86 ; length
	INCBIN "gfx/scenes/tileset1C6.2bpp"

Tileset1C7::
	dw 86 ; length
	INCBIN "gfx/scenes/tileset1C7.2bpp"

IntroBaseSetGfx::
	dw 96 ; length
	INCBIN "gfx/scenes/intro_base_set.2bpp"

IntroJungleGfx::
	dw 96 ; length
	INCBIN "gfx/scenes/intro_jungle.2bpp"

IntroFossilGfx::
	dw 96 ; length
	INCBIN "gfx/scenes/intro_fossil.2bpp"

IntroTeamRocketGfx::
	dw 96 ; length
	INCBIN "gfx/scenes/intro_team_rocket.2bpp"

TitleScreenGfx::
	dw 188 ; length
	INCBIN "gfx/scenes/title_screen.2bpp"

Tileset1CE::
	dw 52 ; length
	INCBIN "gfx/tilesets/tileset1CE.2bpp"

Tileset1CF::
	dw 70 ; length
	INCBIN "gfx/scenes/tileset1CF.2bpp"

Tileset1D0::
	dw 66 ; length
	INCBIN "gfx/tilesets/tileset1D0.2bpp"

Tileset1D5::
	dw 64 ; length
	INCBIN "gfx/scenes/tileset1D5.2bpp"

Tileset1DA::
	dw 13 ; length
	INCBIN "gfx/scenes/tileset1DA.2bpp"

Tileset1E3::
	dw 6 ; length
	INCBIN "gfx/tilesets/tileset1E3.2bpp"

Tileset1EC::
	dw 4 ; length
	INCBIN "gfx/tilesets/tileset1EC.2bpp"

Palette001::
	db 6 ; number of palettes

	rgb 31, 31, 31
	rgb  8, 26,  0
	rgb  1, 15,  0
	rgb  1,  0,  5

	rgb 31, 31, 31
	rgb 25, 18,  6
	rgb 15,  6,  0
	rgb  1,  0,  5

	rgb 31, 31, 31
	rgb 15,  6,  0
	rgb 31,  0,  0
	rgb  1,  0,  5

	rgb 31, 31, 31
	rgb  8, 26,  0
	rgb 25, 18,  6
	rgb  1,  0,  5

	rgb 31, 31, 31
	rgb  8, 26,  0
	rgb  9,  3, 31
	rgb  1,  0,  5

	rgb 31, 31, 31
	rgb 25, 18,  6
	rgb  9,  3, 31
	rgb  1,  0,  5

SECTION "Tilesets 31", ROMX

Tileset1D1::
	dw 91 ; length
	INCBIN "gfx/scenes/tileset1D1.2bpp"

Tileset1D6::
	dw 256 ; length
	INCBIN "gfx/scenes/tileset1D6.2bpp"

Tileset1D7::
	dw 144 ; length
	INCBIN "gfx/tilesets/tileset1D7.2bpp"

Tileset1D9::
	dw 50 ; length
	INCBIN "gfx/scenes/tileset1D9.2bpp"

Tileset1DB::
	dw 103 ; length
	INCBIN "gfx/scenes/tileset1DB.2bpp"

Tileset1DD::
	dw 95 ; length
	INCBIN "gfx/scenes/tileset1DD.2bpp"

Tileset1DE::
	dw 73 ; length
	INCBIN "gfx/scenes/tileset1DE.2bpp"

Tileset1DF::
	dw 124 ; length
	INCBIN "gfx/tilesets/tileset1DF.2bpp"

Tileset1E1::
	dw 21 ; length
	INCBIN "gfx/tilesets/tileset1E1.2bpp"

Tileset1E4::
	dw 55 ; length
	INCBIN "gfx/tilesets/tileset1E4.2bpp"

Tileset1ED::
	dw 5 ; length
	INCBIN "gfx/tilesets/tileset1ED.2bpp"

Palette002::
	db 6 ; number of palettes

	rgb 30, 27, 15
	rgb 24, 13,  0
	rgb 14,  8,  0
	rgb  0,  0,  0

	rgb 25, 31, 31
	rgb  9, 21, 31
	rgb  5,  7, 31
	rgb  0,  0,  5

	rgb 25, 31, 31
	rgb  0, 31,  6
	rgb  0, 16,  0
	rgb  5,  0,  0

	rgb 31, 19,  0
	rgb 17,  8, 23
	rgb 10,  0, 15
	rgb  0,  0,  5

	rgb 25, 31, 31
	rgb  9, 21, 31
	rgb  0, 16,  0
	rgb 10,  4,  0

	rgb 25, 31, 31
	rgb  9, 21, 31
	rgb 31,  0, 31
	rgb  0,  0,  5

Palette053::
	db 5 ; number of palettes

	rgb 31, 31, 14
	rgb 23, 23, 23
	rgb 15, 15, 15
	rgb  0,  0,  0

	rgb 29, 29, 16
	rgb 23, 23, 23
	rgb 15, 15, 15
	rgb  0,  0,  0

	rgb 27, 27, 18
	rgb 23, 23, 23
	rgb 15, 15, 15
	rgb  0,  0,  0

	rgb 25, 25, 20
	rgb 23, 23, 23
	rgb 15, 15, 15
	rgb  0,  0,  0

	rgb 23, 23, 23
	rgb 23, 23, 23
	rgb 15, 15, 15
	rgb  0,  0,  0

SECTION "Tilesets 32", ROMX

Tileset1E0::
	dw 256 ; length
	INCBIN "gfx/tilesets/tileset1E0.2bpp"

Tileset1E2::
	dw 78 ; length
	INCBIN "gfx/tilesets/tileset1E2.2bpp"

Tileset1E6::
	dw 45 ; length
	INCBIN "gfx/tilesets/tileset1E6.2bpp"

Tileset1E7::
	dw 19 ; length
	INCBIN "gfx/tilesets/tileset1E7.2bpp"

Tileset1E8::
	dw 45 ; length
	INCBIN "gfx/tilesets/tileset1E8.2bpp"

Tileset1EA::
	dw 33 ; length
	INCBIN "gfx/tilesets/tileset1EA.2bpp"

Tileset1EB::
	dw 64 ; length
	INCBIN "gfx/tilesets/tileset1EB.2bpp"

Tileset1EE::
	dw 24 ; length
	INCBIN "gfx/tilesets/tileset1EE.2bpp"

SECTION "Palettes 1", ROMX
INCLUDE "data/palettes1.asm"

Frameset10A::
	oamframe  3,  1,   0,   0
	oamreset

SECTION "Framesets 1", ROMX
INCLUDE "data/framesets1.asm"

SECTION "Framesets 2", ROMX
INCLUDE "data/framesets2.asm"

SECTION "Palettes 2", ROMX
INCLUDE "data/palettes2.asm"

SECTION "OAM 1", ROMX
INCLUDE "data/oam1.asm"

SECTION "OAM 2", ROMX
INCLUDE "data/oam2.asm"

SECTION "OAM 3", ROMX
INCLUDE "data/oam3.asm"

SECTION "OAM 4", ROMX
INCLUDE "data/oam4.asm"

SECTION "OAM 5", ROMX
INCLUDE "data/oam5.asm"
