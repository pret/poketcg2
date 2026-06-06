#!/usr/bin/env python3
"""Map gfx-copy reads captured in SameBoy to their source region/label.

Capture procedure (SameBoy, `tools/sameboy_trace/sameboy_trace -s poketcg2.gbc`;
poketcg2.sym is auto-loaded for label names):

    breakpoint CopyGfxData        # $00:06dd -- the actual tile read, AFTER the
                                  #            bank switch, so `mbc` = true bank
    continue
    # ... navigate the game to a screen that loads duel gfx ...
    # on each breakpoint hit, run:
    mbc                           # prints the mapped ROM bank
    p hl                          # prints the source address
    continue

Collect the (bank, address) pairs into a file, one "BANK ADDR" per line in hex
(e.g. "1c 4a30"), then:

    python3 tools/trace_gfx_reads.py reads.txt

It reports, for each read, which region/label it lands in -- confirming the
DuelCardHeaderGraphics/.../DuelBoxMessages labels and naming whatever the
$1c:4000-4a30 blob and the DuelOtherGraphics operands actually point at.

Screens worth visiting: a duel's check-Pokemon screen, drawing/placing a card
(card-type header), the "Draw X cards" screen, and Bill's PC.
"""
import sys, re

CG = 0x74000  # CardGraphics file offset ($1d:4000)

def classify(bank, addr):
    off = bank * 0x4000 + (addr - 0x4000) if addr >= 0x4000 else addr
    if addr < 0x4000:
        return off, f"home / bank 0 (ROM0) ${addr:04x} -- code or home data"
    if bank == 0x1b:
        for lo, hi, name in [
            (0x4000, 0x6db0, "Fonts (full-width)"),
            (0x6db0, 0x7150, "HalfWidthFont"),
            (0x7150, 0x74d0, "SymbolsFont"),
            (0x74d0, 0x77d0, "DuelCardHeaderGraphics"),
            (0x77d0, 0x7ad0, "DuelCgbSymbolGraphics"),
            (0x7ad0, 0x7c00, "DuelDmgSgbSymbolGraphics"),
            (0x7c00, 0x8000, "DuelOtherGraphics"),
        ]:
            if lo <= addr < hi:
                return off, f"{name} + ${addr-lo:x} ($1b:{addr:04x})"
    if bank == 0x1c:
        if 0x4000 <= addr < 0x4a30:
            return off, f"$1c:4000-4a30 UNLABELED blob (gfx_070000) + ${addr-0x4000:x}"
        if 0x4a30 <= addr < 0x5bb0:
            return off, f"DuelBoxMessages + ${addr-0x4a30:x} ($1c:{addr:04x})"
        return off, f"$1c:{addr:04x} (padding region)"
    if 0x1d <= bank <= 0x36:
        idx = (off - CG) // 8
        return off, f"CardGraphics + ${off-CG:x} (card gfx_index ~${idx:x}, ${bank:02x}:{addr:04x})"
    return off, f"${bank:02x}:{addr:04x} (outside the card/duel gfx banks)"

def main():
    src = open(sys.argv[1]) if len(sys.argv) > 1 else sys.stdin
    seen = {}
    for line in src:
        m = re.search(r'([0-9a-fA-F]{1,2})[:\s]+\$?([0-9a-fA-F]{4})', line)
        if not m:
            continue
        bank = int(m.group(1), 16); addr = int(m.group(2), 16)
        off, label = classify(bank, addr)
        key = (bank, addr)
        seen[key] = label
    if not seen:
        print("no 'BANK ADDR' pairs found (expected hex like '1c 4a30')"); return
    print(f"{len(seen)} distinct reads:\n")
    for (bank, addr), label in sorted(seen.items()):
        print(f"  ${bank:02x}:{addr:04x}  ->  {label}")

if __name__ == '__main__':
    main()
