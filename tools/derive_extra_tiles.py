#!/usr/bin/env python3
"""Build a card's printer-only extra tiles <name>_extra.2bpp
from its printer-image data <name>_printer.2bpp and
attributes <name>.cardattr.asm.

The Game Boy Printer reconstructs 48 output tiles where
output cell c uses source tile (attr[c] & 0x3f) + c;
any source index > 47 is an extra tile stored after the 48-tile portrait.
Every extra index is referenced by some cell, so the extra tiles are exactly
the redirected cells of the printer image.

Used by the Makefile:
    python3 tools/derive_extra_tiles.py <name>_printer.2bpp <name>_extra.2bpp
"""

import re, os, sys, argparse


def parse_attr(cardpath):
    """the 48-byte attribute map for <name> from <name>.cardattr.asm."""
    attr_file = f"{cardpath}.cardattr.asm"

    if not os.path.exists(attr_file):
        sys.exit(
            f"derive_extra_tiles: missing attr file for {os.path.basename(cardpath)}: {attr_file}"
        )

    attr = []
    for line in open(attr_file):
        m = re.match(r"\s*db\s+(.+)", line)
        if m:
            attr += [int(x, 16) for x in re.findall(r"\$([0-9a-f]{2})", m.group(1))]
    if len(attr) < 48:
        sys.exit(
            f"derive_extra_tiles: no 48-byte attr map for {os.path.basename(cardpath)} in {attr_file}"
        )
    return attr[:48]


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("printer_2bpp")
    ap.add_argument("out_2bpp")
    a = ap.parse_args()
    suff = "_printer"
    assert a.printer_2bpp.endswith(
        suff + ".2bpp"
    ), f"derive_extra_tiles: expected <name>_printer.2bpp, got {a.printer_2bpp}"
    cardpath = os.path.splitext(a.printer_2bpp)[0].removesuffix(suff)
    name = os.path.basename(cardpath)

    with open(a.printer_2bpp, "rb") as f:
        data = f.read()
    tiles = [data[i : i + 16] for i in range(0, len(data), 16)]

    attr = parse_attr(cardpath)
    src = [
        (attr[c] & 0x3F) + c for c in range(48)
    ]  # printer source-tile index per cell
    n = max(src) - 47  # number of extra tiles
    extra = [None] * n
    for c in range(48):
        if src[c] > 47:
            extra[src[c] - 48] = tiles[c]  # this cell *is* extra tile src-48
    if any(t is None for t in extra):
        sys.exit(f"derive_extra_tiles: {name} references an unstored extra tile (gap)")

    with open(a.out_2bpp, "wb") as f:
        for t in extra:
            f.write(t)


if __name__ == "__main__":
    main()
