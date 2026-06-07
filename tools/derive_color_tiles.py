#!/usr/bin/env python3
"""Build a card's grayscale portrait tiles (<name>.2bpp) from its in-duel COLOR
image (<name>_color.png) plus the 3 palettes + attribute map in card_graphics.asm.

Each 8x8 cell of the color image is one portrait tile, colored by one of the
card's three palettes (chosen per cell by the attribute byte's high 2 bits).
Inverting that palette maps every color pixel back to its 2-bit shade, recovering
the exact grayscale tile -- lossless as long as the palette is injective on the
shades the cell uses (verified for all 445 cards). Tiles are emitted column-major
(rgbgfx -Z order), matching the ROM.

Pure standard library (zlib) so the build needs no image package.

Used by the Makefile:
  python3 tools/derive_color_tiles.py --asm <card_graphics.asm> \
      <name>.png <name>.2bpp
"""
import re, os, sys, zlib, struct, argparse


def parse_header(asm, name):
    """(palettes[3][4] of (r,g,b 0-31), attr[48]) for <name> from card_graphics.asm."""
    lab = ''.join(p.capitalize() for p in name.split('_')) + 'CardGfx'
    pals, attr, grab = [], [], False
    for line in open(asm):
        if line.startswith(lab + '::'):
            grab = True; continue
        if not grab:
            continue
        m = re.match(r'\s*rgb\s+(\d+),\s*(\d+),\s*(\d+)', line)
        if m:
            pals.append(tuple(int(x) for x in m.groups())); continue
        m = re.match(r'\s*db\s+(.+)', line)
        if m:
            attr += [int(x, 16) for x in re.findall(r'\$([0-9a-f]{2})', m.group(1))]; continue
        if 'INCBIN' in line and (pals or attr):
            break
    if len(pals) < 12 or len(attr) < 48:
        sys.exit(f"derive_color_tiles: incomplete header for {name} in {asm}")
    return [pals[i*4:i*4+4] for i in range(3)], attr[:48]


def read_png_rgb(path):
    """minimal PNG decoder: 8-bit truecolor, no interlace. -> (w, h, rows of (r,g,b))."""
    data = open(path, 'rb').read()
    if data[:8] != b'\x89PNG\r\n\x1a\n':
        sys.exit(f"derive_color_tiles: not a PNG: {path}")
    pos, w, h, bitdepth, colortype, interlace, idat = 8, None, None, None, None, 0, b''
    while pos < len(data):
        ln = struct.unpack('>I', data[pos:pos+4])[0]
        typ = data[pos+4:pos+8]; chunk = data[pos+8:pos+8+ln]; pos += 12 + ln
        if typ == b'IHDR':
            w, h, bitdepth, colortype, _comp, _filt, interlace = struct.unpack('>IIBBBBB', chunk)
        elif typ == b'IDAT':
            idat += chunk
        elif typ == b'IEND':
            break
    if bitdepth != 8 or colortype != 2 or interlace != 0:
        sys.exit(f"derive_color_tiles: need 8-bit RGB non-interlaced PNG ({path})")
    raw = zlib.decompress(idat); bpp = 3; stride = w * bpp
    rows, prev, p = [], bytes(stride), 0
    for _y in range(h):
        ft = raw[p]; p += 1
        line = bytearray(raw[p:p+stride]); p += stride
        if ft == 1:
            for i in range(bpp, stride): line[i] = (line[i] + line[i-bpp]) & 0xff
        elif ft == 2:
            for i in range(stride): line[i] = (line[i] + prev[i]) & 0xff
        elif ft == 3:
            for i in range(stride):
                a = line[i-bpp] if i >= bpp else 0
                line[i] = (line[i] + ((a + prev[i]) >> 1)) & 0xff
        elif ft == 4:
            for i in range(stride):
                a = line[i-bpp] if i >= bpp else 0
                b = prev[i]; c = prev[i-bpp] if i >= bpp else 0
                pp = a + b - c; pa, pb, pc = abs(pp-a), abs(pp-b), abs(pp-c)
                pr = a if (pa <= pb and pa <= pc) else (b if pb <= pc else c)
                line[i] = (line[i] + pr) & 0xff
        elif ft != 0:
            sys.exit(f"derive_color_tiles: unsupported PNG filter {ft} in {path}")
        rows.append([(line[x*3], line[x*3+1], line[x*3+2]) for x in range(w)])
        prev = bytes(line)
    return w, h, rows


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('png')
    ap.add_argument('out_2bpp')
    ap.add_argument('--asm', required=True)
    a = ap.parse_args()
    name = os.path.basename(a.png)[:-len('.png')]

    pal, attr = parse_header(a.asm, name)
    # palette colors as 8-bit RGB (rgb555 -> 8bpc, same mapping the color png was built with)
    pal8 = [[tuple(round(v * 255 / 31) for v in c) for c in pal[p]] for p in range(3)]
    w, h, px = read_png_rgb(a.png)
    if (w, h) != (64, 48):
        sys.exit(f"derive_color_tiles: {name} expected 64x48, got {w}x{h}")

    out = bytearray()
    # column-major tiles: tile k sits at grid (col k//6, row k%6); the cell's
    # palette is the attribute byte read ROW-MAJOR (attr[row*8 + col]).
    for k in range(48):
        col, row = k // 6, k % 6
        p = attr[row*8 + col] >> 6
        inv = {}
        for idx, c in enumerate(pal8[p]):
            inv.setdefault(c, idx)          # canonical: lowest index sharing a color
        for r in range(8):
            lo = hi = 0
            for x in range(8):
                v = inv.get(px[row*8 + r][col*8 + x])
                if v is None:
                    sys.exit(f"derive_color_tiles: {name} cell {k} has a color absent from palette {p}")
                lo = (lo << 1) | (v & 1)
                hi = (hi << 1) | ((v >> 1) & 1)
            out += bytes((lo, hi))
    with open(a.out_2bpp, 'wb') as f:
        f.write(out)


if __name__ == '__main__':
    main()
