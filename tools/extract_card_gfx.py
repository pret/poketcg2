#!/usr/bin/env python3
"""Disassemble the card-graphics section ($1b:74d0 .. $36) out of the
baserom overlay into per-card sources + an asm layout.

Card format (uncompressed, fixed 840 B), starting at CardGraphics + index*8:
  72-byte header = 3 GBC palettes (24 B) + a 48-entry attribute map.
                   Each map byte's high 2 bits pick that tile's palette; the
                   low 6 bits are a tile index used by the alternate (LoadCardGfxRemapped)
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

# known graphics carved out of the pre-region and labelled:
#   (file offset, size, label, gfx path stem, png width in tiles)
KNOWN_PRE = [
    (0x70a30, 7*40*16, 'DuelBoxMessages', 'gfx/duel/box_messages', 10),  # 7 box msgs, 10x4 each
]
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

def extra_tile_bytes(rom, a):
    """bytes of printer tiles a card references past its 48-tile portrait.
       LoadCardGfxRemapped reads source tile (attr[i]&$3f)+i; anything above 47
       lives in the card's extra tiles right after the portrait."""
    attr = rom[a+24:a+72]
    return max(0, max((b & 0x3f) + j for j, b in enumerate(attr)) - 47) * 16

def card_addrs(rom):
    """addr -> card label, from the `dw` indices if present, else the built sym
       (so this stays runnable after the gfx field is rewritten to `gfx <...>`)."""
    cards = parse_cards()
    if cards:
        return {a: lbl for a, lbl, _ in cards}
    out = {}
    for line in open(os.path.join(ROOT, 'poketcg2.sym')):
        m = re.match(r'^([0-9a-f]{2}):([0-9a-f]{4}) ([A-Za-z0-9_]+Card)Gfx$', line.strip())
        if m:
            a = int(m.group(1), 16)*0x4000 + (int(m.group(2), 16) - 0x4000)
            if CG <= a < REGION_END: out[a] = m.group(3)
    return out

def build_segments(rom, byaddr):
    """Walk the region into typed segments:
         pre   - un-indexed gfx before CardGraphics ($1b tail, $1c)
         card  - the 840-byte portrait blob
         extra - the card's printer tiles (read by LoadCardGfxRemapped)
         pad   - 0x00/0xff alignment between cards
       Misc/pad are split at 0x4000 bank boundaries."""
    starts = sorted(byaddr)
    segs = []; pos = REGION_START
    known = sorted(KNOWN_PRE); ki = 0
    while pos < starts[0]:                          # pre-region
        kstart = known[ki][0] if ki < len(known) else starts[0]
        if pos == kstart:
            _, ksz, klabel, stem, w = known[ki]
            segs.append((pos, pos+ksz, 'known', (klabel, stem, w))); pos += ksz; ki += 1
            continue
        end = min(kstart, (pos & ~0x3fff) + 0x4000)
        chunk = rom[pos:end]
        segs.append((pos, end, 'pad' if set(chunk) <= {0, 0xff} else 'pre', None))
        pos = end
    for i, a in enumerate(starts):
        assert pos == a, f"misaligned card at {a:#x}"
        name = byaddr[a]
        segs.append((a, a+CARD_SIZE, 'card', name)); pos = a + CARD_SIZE
        nxt = starts[i+1] if i+1 < len(starts) else REGION_END
        if pos >= nxt: continue
        eb = min(extra_tile_bytes(rom, a), nxt - pos)
        if eb:
            segs.append((pos, pos+eb, 'extra', name)); pos += eb
        while pos < nxt:                            # alignment padding
            end = min(nxt, (pos & ~0x3fff) + 0x4000)
            segs.append((pos, end, 'pad', name)); pos = end
    return segs

def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('--baserom', default=os.path.join(ROOT, 'baserom.gbc'))
    ap.add_argument('--write-files', action='store_true')
    ap.add_argument('--emit-asm')
    ap.add_argument('--apply-carddata', action='store_true')
    args = ap.parse_args()

    rom = open(args.baserom, 'rb').read()
    byaddr = card_addrs(rom)
    segs = build_segments(rom, byaddr)

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
            elif kind == 'extra':
                open(os.path.join(GFXDIR, card_filename(name)+'_extra.bin'), 'wb').write(rom[s:e])
            elif kind == 'known':
                klabel, stem, w = name
                png = os.path.join(ROOT, 'src', stem + '.png')
                os.makedirs(os.path.dirname(png), exist_ok=True)
                tmp = os.path.join(GFXDIR, '_known.2bpp')
                open(tmp, 'wb').write(rom[s:e])
                subprocess.run([RGBGFX, '-r', str(w), '--colors', 'dmg', '-o', tmp, png], check=True)
                os.remove(tmp)
            elif kind == 'pre':
                open(os.path.join(GFXDIR, 'misc', f'gfx_{s:06x}.bin'), 'wb').write(rom[s:e])
            # 'pad' is emitted inline as `ds` -- no file

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
            elif kind == 'extra':
                L.append(f'{name}GfxExtra::\n')
                L.append(f'\tINCBIN "gfx/cards/{card_filename(name)}_extra.bin"\n')
            elif kind == 'known':
                klabel, stem, w = name
                L.append(f'{klabel}::\n')
                L.append(f'\tINCBIN "{stem}.2bpp"\n')
            elif kind == 'pad':
                seg = rom[s:e]; j = 0          # alignment padding -> ds runs
                while j < len(seg):
                    v = seg[j]; k = j
                    while k < len(seg) and seg[k] == v: k += 1
                    L.append(f'\tds ${k-j:x}, ${v:02x}\n'); j = k
            else:  # pre
                L.append(f'\tINCBIN "gfx/cards/misc/gfx_{s:06x}.bin"\n')
        header = (
            "; Card graphics. Each \"<Name>CardGfx\": 3 GBC palettes (rgb) + a 48-entry\n"
            "; attribute map (db; high 2 bits = each tile's palette, low 6 = a tile index\n"
            "; for the alternate LoadCardGfxRemapped renderer), then INCBIN of the 48\n"
            "; portrait tiles (built from gfx/cards/<name>.png, 4-shade grayscale, column-\n"
            "; major). A \"<Name>CardGfxExtra\" + INCBIN follows for cards whose printer\n"
            "; rendering pulls in extra tiles past the portrait; `ds` runs are inter-card\n"
            "; alignment padding. gfx/cards/misc/*.bin are the still-unlabeled gfx that\n"
            "; share these banks ahead of CardGraphics. Generated by\n"
            "; tools/extract_card_gfx.py.\n"
        )
        open(args.emit_asm, 'w').write(header + ''.join(L))

    counts = {k: sum(1 for *_, kk, _ in [(s, e, kk, n) for s, e, kk, n in segs] if kk == k)
              for k in ('card', 'extra', 'pre')}
    print(f"OK: {counts['card']} cards, {counts['extra']} extra-tile blobs, "
          f"{counts['pre']} pre-region blobs; region reconstructs byte-identical")

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
