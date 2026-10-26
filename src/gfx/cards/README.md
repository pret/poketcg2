# Card GFX

## ROM Data structure

In the following order:

1. `regular.gbcpal`: 3 palettes.
2. `attributes.cardattr`: Custom-format attribute metadata, `(palette index) << 6 | (alt tile index offset)` for each tile.
3. `regular.2bpp`: 48 tiles of the full-color illustration.
4. `alt_tiles.2bpp`: Tiles to replace regular ones in the Game Boy Printer mode. The amount ranges from 0 to 48.

See `CARDGFXSTRUCT_*` offset constants for details.

## Files included under `<card_name>/`

* `regular.png`: The full-color illustration.
* `regular.hex`: The palette file in binary for RGBGFX to load.
* `regular.attrmap`: The attribute map of only the palette indices. It's often different than RGBGFX would generate with the  `--attr-map` option, due to duplicate color entries across the palettes. That's inconsequential in the 2bpp output for most affected cards, thanks to the shared color index in their palettes, but…
* `regular.2bpp.match`: Some affected cards point to a different color index of a different palette than RGBGFX would normally do for the same full-color PNG; so the raw 2bpp data is provided for those cards for matching purposes.
* `grayscale.png`: Some cards have a modified illustration for the Game Boy Printer.

## Assembling process

1. `tools/card_attributes` prepares `attributes.cardattr` from `regular.attrmap` by `<<= 6`.
2. If `regular.2bpp.match` exists, it gets duplicated as `regular.2bpp`; otherwise RGBGFX outputs `regular.2bpp` from `regular.png` using `regular.hex`.
3. If `grayscale.png` exists, RGBGFX also outputs `grayscale.2bpp` from `grayscale.png`. Then, `tools/alt_tiles` compares `regular.2bpp` and `grayscale.2bpp` to modify `attributes.cardattr` and generate `alt_tiles.2bpp`.
4. RGBGFX converts `regular.hex` to `regular.gbcpal` to make it ready for `INCBIN`.
