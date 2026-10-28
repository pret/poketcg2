# Card GFX

## ROM Data structure

In the following order:

1. `regular.gbcpal`: 3 palettes, in native GBC binary format.
2. `attributes.cardattr`: Custom-format attribute metadata, `(palette index) << 6 | (alt tile index offset)` for each tile.
3. `regular.2bpp`: 48 tiles of the full-color illustration.
4. `alt_tiles.2bpp`: Tiles to replace regular ones in the Game Boy Printer mode. The amount ranges from 0 to 48.

See `CARDGFXSTRUCT_*` offset constants for details.

## Files included under `<card_name>/`

* `regular.png`: The full-color illustration.
* `regular.hex`: The 3 palettes in `rrggbb` text format for RGBGFX to load.
* `regular.attrmap`: The attribute map of only the palette indices. It's often different than RGBGFX would generate with the  `--attr-map` option, due to duplicate color entries across the palettes. That's inconsequential in the 2bpp output for most affected cards, thanks to the shared color index in their palettes, but…
* `regular.2bpp.match`: Some affected cards point to a different color index of a different palette than RGBGFX would normally do for the same full-color PNG; so the raw 2bpp data is provided for those cards for matching purposes.
* `grayscale.png`: Some cards have a modified illustration for the Game Boy Printer.

### Example of 2bpp mismatching

Water Energy has the following palettes: {#deffff, #00b5ff, #005aa5, #00004a}, {#00b5ff, #0084ce, #005aa5, #00004a}, {#deffff, #00b5ff, #005aa5, #0084ce}. It wants palette #0 at tile $14, and the topmost line of that tile is {1 1 2 3 3 3 3 3}; however, RGBGFX would choose palette #1 there, which would provide {0 0 2 3 3 3 3 3}. The same thing occurs on tile $1b of that card, too.

## Assembling process

1. `tools/card_attributes` prepares `attributes.cardattr` from `regular.attrmap` by `<<= 6`.
2. If `regular.2bpp.match` exists, it gets duplicated as `regular.2bpp`; otherwise RGBGFX outputs `regular.2bpp` from `regular.png` using `regular.hex`.
3. If `grayscale.png` exists, RGBGFX also outputs `grayscale.2bpp` from `grayscale.png`. Then, `tools/alt_tiles` compares `regular.2bpp` and `grayscale.2bpp` to modify `attributes.cardattr` and generate `alt_tiles.2bpp`.
4. RGBGFX converts `regular.hex` to `regular.gbcpal` to make it ready for `INCBIN`.
