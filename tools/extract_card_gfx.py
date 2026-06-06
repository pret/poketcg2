#!/usr/bin/env python3
"""Disassemble the card-graphics section ($1b:74d0 .. $36) out of the
baserom overlay into per-card sources + an asm layout.

Card format (uncompressed, fixed 840 B), starting at CardGraphics + index*8:
  72-byte header = 3 GBC palettes (24 B) + a 48-entry attribute map.
                   Each map byte's high 2 bits pick that tile's palette; the
                   low 6 bits are a tile index used by the alternate (Func_2dc4)
                   renderer. The portrait loader copies the 48 tiles 1:1, so for
                   the portrait each tile uses exactly one palette.
  768-byte tiles = 48 stored tiles x TILE_SIZE (column-major).

These are standard CGB multi-palette images, so colour PNGs are possible
(rgbgfx can derive the tiles + palettes); but the game's 72-byte .pal layout
isn't an rgbgfx output, so that path needs a repack step. For simplicity and
byte-exactness (no palette-ordering pitfalls) we instead:
  - tiles  -> src/gfx/cards/<name>.png   (4-shade grayscale, built to .2bpp)
  - header -> emitted as asm (`rgb` palettes + `db` map) in card_graphics.asm
  - the index field in src/data/cards*.asm becomes `gfx <Name>CardGfx`.

Un-indexed graphics sharing these banks (the ~19 KB before CardGraphics and the
~41 KB interleaved between cards) are written as raw src/gfx/cards/misc/*.bin
blobs (".bin" is not gitignored, unlike ".2bpp"/".pal") pending identification.
"""
import re, glob, os, argparse, subprocess

CG = 0x74000            # CardGraphics absolute file offset ($1d:4000)
CARD_SIZE = 0x348       # 840 = 72 header + 768 tiles
HDR = 72
CARD_W = 8              # card tiles are 8 wide (48 tiles = 8x6)
REGION_START = 0x6f4d0  # $1b:74d0, first overlay byte after SymbolsFont
REGION_END   = 0xd9818  # end of last card; rest of region is 0xff pad
ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
GFXDIR = os.path.join(ROOT, "src/gfx/cards")
RGBGFX = os.environ.get("RGBGFX", "rgbgfx")

def parse_cards():
    out = []
    for f in sorted(glob.glob(os.path.join(ROOT, "src/data/cards*.asm"))):
        cur = None
        for line in open(f):
            m = re.match(r'^([A-Za-z0-9_]+Card):\s*$', line)
            if m: cur = m.group(1); continue
            m = re.match(r'^\s*dw \$([0-9a-fA-F]+) ; gfx', line)
            if m and cur:
                out.append((CG + int(m.group(1), 16)*8, cur, f)); cur = None
    return out

def card_filename(label):
    base = label[:-4] if label.endswith("Card") else label
    return re.sub(r'(?<!^)(?=[A-Z])', '_', base).lower()

def header_asm(hdr):
    """72-byte header -> asm lines: 3 palettes as `rgb`, then the map as `db`."""
    out = []
    for p in range(3):
        for c in range(4):
            v = hdr[(p*4+c)*2] | (hdr[(p*4+c)*2+1] << 8)
            out.append(f'\trgb {v&31},{(v>>5)&31},{(v>>10)&31}\n')
        out.append('\n')
    tm = hdr[24:72]                       # 48-entry (palette<<6)|tile map
    for i in range(0, 48, 16):
        out.append('\tdb ' + ', '.join(f'${b:02x}' for b in tm[i:i+16]) + '\n')
    return out

def build_segments(card_starts, byaddr):
    """Tile the region into card / misc segments, split at 0x4000 bank bounds."""
    segs = []; pos = REGION_START; cs = card_starts; ci = 0
    while pos < REGION_END:
        while ci < len(cs) and cs[ci] < pos: ci += 1
        nxt = cs[ci] if ci < len(cs) else REGION_END
        if pos == nxt:
            segs.append((pos, pos+CARD_SIZE, 'card', byaddr[pos])); pos += CARD_SIZE
        else:
            end = min(nxt, REGION_END, (pos & ~0x3fff) + 0x4000)
            segs.append((pos, end, 'misc', None)); pos = end
    return segs

def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('--baserom', default=os.path.join(ROOT, 'baserom.gbc'))
    ap.add_argument('--write-files', action='store_true')
    ap.add_argument('--emit-asm')
    ap.add_argument('--apply-carddata', action='store_true')
    args = ap.parse_args()

    rom = open(args.baserom, 'rb').read()
    cards = parse_cards()
    byaddr = {a: lbl for a, lbl, _ in cards}
    card_starts = sorted(byaddr)
    segs = build_segments(card_starts, byaddr)

    # self-check: planned pieces reconstruct the region byte-identically
    recon = bytearray(); p = REGION_START
    for s, e, k, n in segs:
        assert s == p, f"gap at {s:#x}"; recon += rom[s:e]; p = e
    assert bytes(recon) == rom[REGION_START:REGION_END], "reconstruction mismatch!"

    if args.write_files:
        os.makedirs(os.path.join(GFXDIR, 'misc'), exist_ok=True)
        for s, e, kind, name in segs:
            if kind == 'card':
                fn = card_filename(name)
                tiles = os.path.join(GFXDIR, fn+'.2bpp')
                open(tiles, 'wb').write(rom[s+HDR:e])         # 768 B tiles
                # -Z: column-major, so the grayscale PNG renders as the card art
                # (tiles are stored column-major); the build rebuilds .2bpp with -Z too
                subprocess.run([RGBGFX, '-r', str(CARD_W), '-Z', '--colors', 'dmg',
                                '-o', tiles, os.path.join(GFXDIR, fn+'.png')],
                               check=True)
                os.remove(tiles)            # .png is the source; make rebuilds .2bpp
            else:
                open(os.path.join(GFXDIR, 'misc', f'gfx_{s:06x}.bin'), 'wb').write(rom[s:e])

    if args.emit_asm:
        L = []
        cur_bank = None
        SEC = {0x1b: 'Gfx 1b Tail', 0x1c: 'Gfx 1c'}
        for s, e, kind, name in segs:
            b = s >> 14
            if b != cur_bank:
                cur_bank = b; off = 0x4000 + (s & 0x3fff)
                if b == 0x1d:
                    L.append(f'\nSECTION "Card Gfx 1", ROMX[${off:04x}], BANK[${b:02x}]\n')
                    L.append('CardGraphics::\n')
                else:
                    L.append(f'\nSECTION "{SEC.get(b, f"Card Gfx {b:02x}")}", ROMX[${off:04x}], BANK[${b:02x}]\n')
            if kind == 'card':
                fn = card_filename(name)
                L.append(f'{name}Gfx::\n')
                L += header_asm(rom[s:s+HDR])
                L.append(f'\tINCBIN "gfx/cards/{fn}.2bpp"\n')
            else:
                L.append(f'\tINCBIN "gfx/cards/misc/gfx_{s:06x}.bin"\n')
        header = (
            "; Card graphics. 445 portraits, each \"<Name>CardGfx\": 3 GBC palettes (rgb)\n"
            "; + a 48-entry attribute map (db; high 2 bits = each tile's palette, low 6\n"
            "; bits = a tile index for the alternate Func_2dc4 renderer), then INCBIN of\n"
            "; the 48 portrait tiles (built from gfx/cards/<name>.png). The tiles are\n"
            "; stored as 4-shade grayscale PNGs and the colour data is emitted here as asm\n"
            "; for simplicity/byte-exactness; these are standard CGB multi-palette images,\n"
            "; so colour PNGs are also possible (see tools/extract_card_gfx.py).\n"
            "; gfx/cards/misc/*.bin are un-indexed graphics sharing these banks.\n"
        )
        open(args.emit_asm, 'w').write(header + ''.join(L))

    print(f"OK: {len(cards)} cards, {sum(1 for *_,k,_ in [(s,e,k,n) for s,e,k,n in segs] if k=='misc')} "
          f"misc blobs; region reconstructs byte-identical")

    if args.apply_carddata:
        for f in sorted(glob.glob(os.path.join(ROOT, "src/data/cards*.asm"))):
            txt = open(f).read().split('\n'); cur = None
            for i, line in enumerate(txt):
                m = re.match(r'^([A-Za-z0-9_]+Card):\s*$', line)
                if m: cur = m.group(1); continue
                m = re.match(r'^(\s*)dw \$[0-9a-fA-F]+ ; gfx\s*$', line)
                if m and cur:
                    txt[i] = f'{m.group(1)}gfx {cur}Gfx ; gfx'; cur = None
            open(f, 'w').write('\n'.join(txt))
        print("rewrote cards*.asm gfx fields")

if __name__ == '__main__':
    main()
