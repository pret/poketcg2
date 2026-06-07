# Card graphics & the `_extra.bin` printer tiles

How a card picture is stored, the two different ways it gets drawn, and what the
per-card `src/gfx/cards/<name>_extra.bin` files actually contain.

TL;DR — every card stores **one 8×6 picture**, but it is drawn **two ways** from
the same data: in a duel the Game Boy Color recolors shared tiles with palettes;
the Game Boy Printer has no palettes, so it needs extra **pre-shaded copies** of
those tiles. `<name>_extra.bin` is exactly that pool of palette-baked tiles.

---

## 1. The on-ROM storage format

Each card image is a fixed record: a **72-byte header + 768-byte portrait + N extra tiles**.

| Part | Size | Contents |
|---|---|---|
| Palettes | 24 B | 3 GBC palettes (4 colors × 2 bytes each) |
| Attribute map | 48 B | one byte per **output cell** (the card is 8×6 = 48 tiles) |
| Portrait tiles | 768 B | the 48 tiles shown 1:1 in a duel → `<name>.2bpp` (built from `<name>.png`) |
| Extra tiles | N×16 B | appended printer-only tiles → `<name>_extra.bin` |

In source ([src/gfx/card_graphics.asm](../src/gfx/card_graphics.asm)) that's the
palettes as `rgb` directives, the attribute map as `db`, then
`<Name>CardGfx:: INCBIN "<name>.2bpp"` immediately followed (when N > 0) by
`<Name>CardGfxExtra:: INCBIN "<name>_extra.bin"`.

### The attribute-map byte
Each of the 48 attribute bytes packs **two unrelated fields**:

```
 bit  7 6 | 5 4 3 2 1 0
      pal | tile-redirect offset (0..63)
```
- **high 2 bits** — which of the 3 palettes colors this cell (used in a duel)
- **low 6 bits** — a *relative* tile offset added to the cell index (used by the printer)

The portrait tiles + extra tiles form **one tile pool** (tiles 0..47 are the
portrait, 48.. are the extra). One byte drives both renderers.

---

## 2. Two renderers, one record

**In a duel** — [`LoadCardGfx`](../src/home/card_data.asm) copies the 48 portrait
tiles **1:1** into VRAM, and [`CopyCGBCardPalette`](../src/engine/bank01.asm) turns
each attribute byte's **high 2 bits** into a CGB background-palette attribute. So
output cell `c` shows **portrait tile `c`, recolored by hardware** with palette
`attr[c] >> 6`. The redirect offset and the extra tiles are never touched.

**On the printer** — [`LoadCardGfxRemapped`](../src/home/card_data.asm) reconstructs
the 48 tiles using the **low 6 bits**:

```
printer output tile c  =  source tile  (attr[c] & 0x3f) + c
```

When that index exceeds 47 it reaches into the **extra** region.
[`BuildPrintableCardPic`](../src/engine/bank06.asm) then repacks each tile's raw
2-bpp pixels (with a 2× upscale) into the print buffer and — per its own source
comment — *"The per-tile palette is dropped, so the printout is a flat grayscale
of the card."*

### A subtlety: tile order vs cell order
The stored tiles are **column-major** (`rgbgfx -Z`): tile `k` belongs at screen
column `k // 6`, row `k % 6`. The in-duel BG is filled **row-major** through a
reorder table ([`DrawLoadedCard.CardTilemap`](../src/engine/bank04.asm)), and the
attribute map is copied straight onto it — so a cell's **palette** is read
**row-major** by screen cell (`attr[row*8 + col]`), while its **tile** and the
printer's **redirect** are **column-major** (`attr[col*6 + row]`). The 48 attribute
bytes are just 48 bytes; the two renderers walk them in different orders, and the
data is authored so both produce the right picture. (Getting this transpose wrong
keeps the card's *shape* but scrambles its *colors* — an easy mistake when
reconstructing the image off-hardware.)

---

## 3. Why the extra tiles exist

It is a **Game Boy Color compression trick that the palette-less printer must undo.**

On CGB, one stored tile can be shown in **different colors** by giving it
different palettes at different screen positions — the *hardware* recolors it. So
the in-duel card reuses tile shapes across regions that differ only in color, and
48 stored tiles + 3 palettes cover a richer-looking image.

The **printer has no palette hardware** — it prints the raw 2-bit pixel values as
flat grays. A tile the screen showed in two colors (via two palettes) would print
**identically** in both spots, which is wrong. To print correctly, every cell
needs a tile whose pixels *already* encode the right shade — a **palette-baked
copy**. Those baked variants are the `_extra` tiles, and the redirect offset sends
each printer cell to its correct pre-shaded tile (identity when the portrait tile
already works, or an offset into the extra pool when it does not).

> **`_extra.bin` = the palette-baked tile variants the grayscale printer needs
> that don't already exist among the 48 portrait tiles.**

Energy cards have the biggest extras (Grass = 21 tiles) precisely because their
art is the most color-repetitive: the screen reuses tiles heavily across palettes,
so the printer needs many baked variants.

---

## 4. Worked example — Grass Energy (21 extra tiles)

**In a duel** (CGB, portrait tiles recolored by palette) vs **on the printer**
(flat grayscale, remapped through the extra tiles):

| In-duel (CGB color) | Printer (flat gray, remapped) |
|---|---|
| ![Grass Energy in-duel color](img/grass_energy_induel.png) | ![Grass Energy printer gray](img/grass_energy_printer_gray.png) |

The printer reproduces the same leaf in 4 grays. It can only do that because of
the extra tiles — here are all 21 of them (a *tile pool*, not a coherent picture):

![Grass Energy extra tiles](img/grass_energy_extra_tiles.png)

To see *why* they're needed, compare the printer's correct output (above) with a
**naïve** render that uses only the stored portrait tiles, flat, with no remap —
i.e. what you'd print if you ignored `_extra.bin`:

| Naïve: portrait tiles, flat gray, no remap | Correct: remapped through extra tiles |
|---|---|
| ![Grass Energy portrait flat gray](img/grass_energy_portrait_gray.png) | ![Grass Energy printer gray](img/grass_energy_printer_gray.png) |

21 of the 48 cells differ — look at the top-left corner and the outer halo, the
regions the in-duel display recolored via palette. Those are exactly the cells (column-major
index `c`) whose `attr` low-bits redirect the printer into the extra pool:

| cell `c` | `attr[c]` | offset (`& $3f`) | source tile = offset + `c` |
|---|---|---|---|
| 0 | `$00` | 0 | 0 (portrait) |
| 1 | `$6f` | 47 | **48 (extra 0)** |
| 2 | `$6f` | 47 | **49 (extra 1)** |
| … | | | |
| 11 | `$00` | 0 | 11 (portrait) |
| 26 | `$21` | 33 | **59 (extra 11)** |
| 45 | `$17` | 23 | **68 (extra 20)** |

Redirected cells for Grass Energy: `1–10, 12, 26, 30, 32, 36–39, 43–45` → 21
extra tiles → 336 bytes. (Tile count `N = max((attr[c] & 0x3f) + c) − 47`.)
The byte's *high* bits aren't shown here — they're the palette, and as noted
above the in-duel renderer reads them in a different (row-major) order.

---

## 5. Contrast — a card with **no** extra tiles (Abra)

Most cards (254 of 445) have an all-identity attribute map: the printer render is
the portrait, recolored, with no redirects — so there is no `_extra.bin` at all.
The in-duel color and the printer gray come from the **same 48 portrait tiles**:

| Abra in-duel (CGB color) | Abra printer (flat gray) |
|---|---|
| ![Abra in-duel](img/abra_lv14_induel.png) | ![Abra printer gray](img/abra_lv14_printer_gray.png) |

Charmander sits between the two — just 3 extra tiles (cells 33, 39, 45):

![Charmander extra tiles](img/charmander_lv10_extra_tiles.png)

---

## 6. What this means for representing the files

- The portrait `.2bpp` and `_extra.bin` are **one logical tile array** indexed by
  the header. The extra is *not* a spatial extension of the portrait and *not* a
  separate picture — it's just more tiles of the same pool, used only by the
  printer path.
- There is **no single bigger image** to reconstruct: both renders are 8×6. The
  closest thing to "the full picture" is the printer's flat-gray render, which is
  a *derived* artifact (apply the remap, drop palettes); reversing it back to the
  exact stored bytes is not lossless, so it can't be a build input.
- Faithful representations, cleanest first:
  1. **`<name>_extra.png`** (grayscale tile-strip) — byte-exact, mirrors the
     portrait pipeline; "it's just more tiles." (Looks like a fragment sheet,
     because that's what it is.)
  2. **One combined tile-array `.2bpp`** with `CardGfx` / `CardGfxExtra` as two
     `INCBIN …, offset` labels — possible but needs a concat step (the portrait's
     column-major `-Z` geometry can't absorb N extra tiles in one rectangular PNG).
  3. **A non-build debug viewer** (this doc's renderer) that produces the in-duel
     color image and the printer gray image per card — best for *seeing* a card,
     but a viewer, not source.

---

## 7. Comparison to tcg1 (this is a sequel-only feature)

The original Pokémon TCG GB (`pret/poketcg`, "tcg1") has **none** of this — no
attribute map, no `LoadCardGfxRemapped`, no `BuildPrintableCardPic` remap, and no
`_extra.bin`. The whole system is new in poketcg2.

The reason is the palette count. A tcg1 card is **768 bytes (48 tiles) + one
8-byte palette** (stored as a separate `<name>.pal` file, 4 colors). With a
**single palette**, no tile is ever reused in two colors, so the 48 portrait tiles
*are* the whole picture, 1:1 — and tcg1's Game Boy Printer (same
`_RequestToPrintCard` / `.DrawCardPicInSRAMGfxBuffer2` engine) just prints those
tiles directly: 4 pixel values → 4 grays, nothing to undo.

poketcg2 upgraded each card to **three palettes + a 48-byte per-cell attribute
map** (up to 12 colors), letting the CGB recolor shared tiles per cell for richer
art from the same tile budget. `_extra.bin` is the direct cost of that upgrade:
the moment a card depends on the hardware recoloring a tile, the palette-less
printer needs a distinct pre-shaded copy.

| | tcg1 | poketcg2 |
|---|---|---|
| palettes per card | 1 (separate `.pal`) | 3 (in the asm header) |
| per-cell attribute map | none | 48 bytes (palette + redirect) |
| colors per card | 4 | up to 12 |
| portrait tiles | 48, = the whole image | 48, but cells can be recolored / redirected |
| printer path | `LoadCardGfx` → tiles printed directly | `LoadCardGfxRemapped` → pulls extra tiles |
| extra tiles | — | `_extra.bin` (palette-baked variants) |
| header layout | `[tiles][1 palette]` | `[3 palettes + 48 attr][tiles]` |

So if you ever wonder "why isn't this just a `.png` like tcg1's cards?" — it's
because tcg1's cards genuinely *are* single-palette images, while a poketcg2 card
is a multi-palette image plus a printer-only tile pool.

---

## Regenerating these images

[tools/render_card_gfx_doc.py](../tools/render_card_gfx_doc.py) reads the real
source (palettes + attribute map from `card_graphics.asm`, tiles from `.2bpp` +
`_extra.bin`) and renders the in-duel color, naïve-gray, printer-gray, and
extra-tile images into `docs/img/`. It is documentation tooling only — it does not
touch the build.

```sh
python3 tools/render_card_gfx_doc.py
```
