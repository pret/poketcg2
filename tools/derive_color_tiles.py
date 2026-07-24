#!/usr/bin/env python3
"""Build a card's grayscale portrait tiles <name>.2bpp
from its in-duel COLOR image <name>.png, 3 palettes <name>.pal.asm, and
attributes <name>.cardattr.asm.

Each 8x8 cell of the color image is one portrait tile, colored by one of the
card's three palettes (chosen per cell by the attribute byte's high 2 bits).
Inverting that palette maps every color pixel back to its 2-bit shade,
recovering the exact grayscale tile --
lossless as long as the palette is injective on the shades the cell uses
(verified for all 445 cards).
Tiles are emitted column-major (rgbgfx -Z order), matching the ROM.

Pure standard library (zlib) so the build needs no image package.

Used by the Makefile:
    python3 tools/derive_color_tiles.py <name>.png <name>.2bpp
"""

import re, os, sys, zlib, struct, argparse


def parse_header(cardpath):
    """(palettes[3][4] of (r,g,b 0-31), attr[48]) for <name>
    from <name>.pal.asm and <name>.cardattr.asm."""
    pal_file = f"{cardpath}.pal.asm"
    attr_file = f"{cardpath}.cardattr.asm"
    name = os.path.basename(cardpath)

    if not os.path.exists(pal_file):
        sys.exit(f"derive_color_tiles: missing palette file for {name}: {pal_file}")
    if not os.path.exists(attr_file):
        sys.exit(f"derive_color_tiles: missing attr file for {name}: {attr_file}")

    pals = []
    for line in open(pal_file):
        m = re.match(r"\s*rgb\s+(\d+),\s*(\d+),\s*(\d+)", line)
        if m:
            pals.append(tuple(int(x) for x in m.groups()))
    if len(pals) < 12:
        sys.exit(f"derive_color_tiles: incomplete palette file for {name}: {pal_file}")

    attr = []
    for line in open(attr_file):
        m = re.match(r"\s*db\s+(.+)", line)
        if m:
            attr += [int(x, 16) for x in re.findall(r"\$([0-9a-f]{2})", m.group(1))]
    if len(attr) < 48:
        sys.exit(f"derive_color_tiles: incomplete attr file for {name}: {attr_file}")

    return [pals[i * 4 : i * 4 + 4] for i in range(3)], attr[:48]


def read_png_rgb(path):
    """Strict PNG decoder: 8-bit truecolor (RGB), no interlace.
    Rejects (exits with a clear message) any file that doesn't parse exactly as expected --
    bad signature, truncated/oversized chunk, CRC mismatch, missing IHDR/IEND,
    wrong pixel format, no image data, bad zlib stream,
    wrong decompressed size, or an unsupported scanline filter.
    -> (w, h, rows of (r,g,b))."""

    def reject(msg):
        sys.exit(f"derive_color_tiles: {path}: {msg}")

    data = open(path, "rb").read()
    if data[:8] != b"\x89PNG\r\n\x1a\n":
        reject("not a PNG (bad signature)")
    pos, w, h, bitdepth, colortype, interlace = 8, None, None, None, None, 0
    idat = bytearray()
    seen_ihdr = seen_iend = False
    while pos + 8 <= len(data):
        ln = struct.unpack(">I", data[pos : pos + 4])[0]
        typ = data[pos + 4 : pos + 8]
        if pos + 12 + ln > len(data):
            reject(f"truncated chunk {typ.decode('latin1')!r}")
        chunk = data[pos + 8 : pos + 8 + ln]
        crc = struct.unpack(">I", data[pos + 8 + ln : pos + 12 + ln])[0]
        if zlib.crc32(typ + chunk) & 0xFFFFFFFF != crc:
            reject(f"CRC mismatch in chunk {typ.decode('latin1')!r} (corrupt)")
        pos += 12 + ln
        if typ == b"IHDR":
            if ln != 13:
                reject("malformed IHDR")
            w, h, bitdepth, colortype, _comp, _filt, interlace = struct.unpack(
                ">IIBBBBB", chunk
            )
            seen_ihdr = True
        elif typ == b"IDAT":
            idat += chunk
        elif typ == b"IEND":
            seen_iend = True
            break
    if not seen_ihdr:
        reject("missing IHDR")
    if not seen_iend:
        reject("missing IEND (truncated file)")
    if (bitdepth, colortype, interlace) != (8, 2, 0):
        reject(
            f"need 8-bit RGB non-interlaced (got depth={bitdepth}, colortype={colortype}, interlace={interlace})"
        )
    if not w or not h:
        reject("zero-sized image")
    if not idat:
        reject("no image data (no IDAT chunk)")
    try:
        raw = zlib.decompress(bytes(idat))
    except zlib.error as e:
        reject(f"corrupt compressed image data ({e})")
    bpp = 3
    stride = w * bpp
    if len(raw) != h * (stride + 1):
        reject(
            f"decompressed size {len(raw)} != expected {h * (stride + 1)} (truncated/corrupt)"
        )
    rows, prev, p = [], bytes(stride), 0
    for _y in range(h):
        ft = raw[p]
        p += 1
        line = bytearray(raw[p : p + stride])
        p += stride
        if ft == 1:
            for i in range(bpp, stride):
                line[i] = (line[i] + line[i - bpp]) & 0xFF
        elif ft == 2:
            for i in range(stride):
                line[i] = (line[i] + prev[i]) & 0xFF
        elif ft == 3:
            for i in range(stride):
                a = line[i - bpp] if i >= bpp else 0
                line[i] = (line[i] + ((a + prev[i]) >> 1)) & 0xFF
        elif ft == 4:
            for i in range(stride):
                a = line[i - bpp] if i >= bpp else 0
                b = prev[i]
                c = prev[i - bpp] if i >= bpp else 0
                pp = a + b - c
                pa, pb, pc = abs(pp - a), abs(pp - b), abs(pp - c)
                pr = a if (pa <= pb and pa <= pc) else (b if pb <= pc else c)
                line[i] = (line[i] + pr) & 0xFF
        elif ft != 0:
            reject(f"unsupported PNG scanline filter {ft}")
        rows.append([(line[x * 3], line[x * 3 + 1], line[x * 3 + 2]) for x in range(w)])
        prev = bytes(line)
    return w, h, rows


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("png")
    ap.add_argument("out_2bpp")
    a = ap.parse_args()
    assert (
        os.path.splitext(a.png)[1].lower() == ".png"
    ), f"derive_color_tiles: expected <name>.png, got {a.png}"
    cardpath = os.path.splitext(a.png)[0]
    name = os.path.basename(cardpath)

    pal, attr = parse_header(cardpath)
    # palette colors as 8-bit RGB
    # (rgb555 -> 8bpc, same mapping the color png was built with)
    pal8 = [[tuple(round(v * 255 / 31) for v in c) for c in pal[p]] for p in range(3)]
    w, h, px = read_png_rgb(a.png)
    if (w, h) != (64, 48):
        sys.exit(f"derive_color_tiles: {name} expected 64x48, got {w}x{h}")

    out = bytearray()
    # column-major tiles: tile k sits at grid (col k//6, row k%6);
    # the cell's palette is the attribute byte read ROW-MAJOR
    # (attr[row*8 + col])
    for k in range(48):
        col, row = k // 6, k % 6
        p = attr[row * 8 + col] >> 6
        inv = {}
        for idx, c in enumerate(pal8[p]):
            inv.setdefault(c, idx)  # canonical: lowest index sharing a color
        for r in range(8):
            lo = hi = 0
            for x in range(8):
                v = inv.get(px[row * 8 + r][col * 8 + x])
                if v is None:
                    sys.exit(
                        f"derive_color_tiles: {name} cell {k} has a color absent from palette {p}"
                    )
                lo = (lo << 1) | (v & 1)
                hi = (hi << 1) | ((v >> 1) & 1)
            out += bytes((lo, hi))
    with open(a.out_2bpp, "wb") as f:
        f.write(out)


if __name__ == "__main__":
    main()
