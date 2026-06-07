#!/usr/bin/env python3
"""Build a card's printer-extra tiles (<name>_extra.2bpp) from its remapped
printer image (<name>_remapped.png) and the attribute map in card_graphics.asm.

The Game Boy Printer reconstructs 48 output tiles where output cell c uses source
tile (attr[c] & 0x3f) + c; any source index > 47 is an "extra" tile stored after
the 48-tile portrait. Every extra index is referenced by some cell, so the extra
tiles are exactly the redirected cells of the printer image -- we harvest them from
<name>_remapped.png rather than storing them as a separate tile strip.

Used by the Makefile:
  python3 tools/derive_extra_tiles.py --rgbgfx <rgbgfx> --asm <card_graphics.asm> \
      <name>_remapped.png <name>_extra.2bpp
"""
import re, os, sys, subprocess, argparse, tempfile

def parse_attr(asm, name):
    """the 48-byte attribute map for <name> from card_graphics.asm."""
    lab = ''.join(p.capitalize() for p in name.split('_')) + 'CardGfx'
    attr, grab = [], False
    for line in open(asm):
        if line.startswith(lab + '::'):
            grab = True; continue
        if not grab:
            continue
        m = re.match(r'\s*db\s+(.+)', line)
        if m:
            attr += [int(x, 16) for x in re.findall(r'\$([0-9a-f]{2})', m.group(1))]
        elif 'INCBIN' in line and attr:
            break
    if len(attr) < 48:
        sys.exit(f"derive_extra_tiles: no 48-byte attr map for {name} in {asm}")
    return attr[:48]

def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('remapped_png')
    ap.add_argument('out_2bpp')
    ap.add_argument('--rgbgfx', default='rgbgfx')
    ap.add_argument('--asm', required=True)
    a = ap.parse_args()
    name = os.path.basename(a.remapped_png)[:-len('_remapped.png')]

    # remapped png -> the 48 printer-image tiles, column-major (same as the portrait),
    # so tile index == printer output-cell index.
    tmp = tempfile.mktemp(suffix='.2bpp')
    subprocess.run([a.rgbgfx, '--colors', 'dmg', '-Z', '-o', tmp, a.remapped_png], check=True)
    data = open(tmp, 'rb').read(); os.remove(tmp)
    tiles = [data[i:i+16] for i in range(0, len(data), 16)]

    attr = parse_attr(a.asm, name)
    src = [(attr[c] & 0x3f) + c for c in range(48)]   # printer source-tile index per cell
    n = max(src) - 47                                  # number of extra tiles
    extra = [None] * n
    for c in range(48):
        if src[c] > 47:
            extra[src[c] - 48] = tiles[c]              # this cell *is* extra tile src-48
    if any(t is None for t in extra):
        sys.exit(f"derive_extra_tiles: {name} references an unstored extra tile (gap)")

    with open(a.out_2bpp, 'wb') as f:
        for t in extra:
            f.write(t)

if __name__ == '__main__':
    main()
