#!/usr/bin/env python3
"""Propose tcg1 names for tcg2 Func_* labels by fingerprinting function bodies.

tcg1 (pret/poketcg) is a ~95%-labeled decomp that shares much of tcg2's engine.
Each function is reduced to a normalized opcode stream: instruction opcodes and
8-bit immediates are kept, but 16-bit immediates (call/jp/ld rr,nn/ld (nn),a ...)
are masked, so the SAME code matches across the two ROMs despite living at
different absolute addresses. A tcg2 Func_* whose fingerprint uniquely equals a
*named* tcg1 function is a high-confidence rename candidate.

Output is a candidate list (TSV) the human verifies before applying; it changes
nothing on its own.

Usage:
  python3 tools/match_tcg1.py [--tcg1 ../poketcg] [--min-bytes 6] [--filter bank0b]
"""
import sys, os, argparse, hashlib

# GB opcode lengths. LEN2 = 1 opcode + 1 imm byte; LEN3 = 1 opcode + 2 imm bytes.
LEN2 = {0x06,0x0e,0x16,0x1e,0x26,0x2e,0x36,0x3e,0xc6,0xce,0xd6,0xde,0xe6,0xee,
        0xf6,0xfe,0xe0,0xf0,0xe8,0xf8,0x18,0x20,0x28,0x30,0x38}
LEN3 = {0x01,0x11,0x21,0x31,0x08,0xc2,0xc3,0xca,0xd2,0xda,0xc4,0xcc,0xcd,0xd4,0xdc,0xea,0xfa}

def normalize(b):
    """opcode stream with 16-bit immediates masked to \\x00\\x00."""
    out = bytearray(); i = 0; n = len(b)
    while i < n:
        op = b[i]
        if op == 0xcb:                 # CB-prefixed: 2 bytes, fully kept
            out += b[i:i+2]; i += 2
        elif op in LEN3:               # keep opcode, mask the 16-bit operand
            out.append(op); out += b'\x00\x00'; i += 3
        elif op in LEN2:               # keep opcode + 8-bit immediate
            out += b[i:i+2]; i += 2
        else:
            out.append(op); i += 1
    return bytes(out)

def parse_sym(path):
    """bank -> sorted [(addr, label)] for ROM (addr < $8000), globals only."""
    banks = {}
    for line in open(path):
        line = line.strip()
        if not line or line.startswith(';'): continue
        try:
            loc, label = line.split(None, 1)
            bs, as_ = loc.split(':')
            bank = int(bs, 16); addr = int(as_, 16)
        except ValueError:
            continue
        if addr >= 0x8000: continue          # WRAM/HRAM/SRAM/VRAM, not code
        if '.' in label: continue             # local labels
        banks.setdefault(bank, []).append((addr, label))
    for b in banks: banks[b].sort()
    return banks

def file_off(bank, addr):
    return addr if bank == 0 else bank*0x4000 + (addr - 0x4000)

def func_bodies(rom, banks):
    """label -> (bank, addr, size, normalized_fp) using next-global as the bound."""
    out = {}
    for bank, lst in banks.items():
        end_of_bank = 0x4000 if bank == 0 else 0x8000
        for i, (addr, label) in enumerate(lst):
            nxt = lst[i+1][0] if i+1 < len(lst) else end_of_bank
            if nxt <= addr: continue
            s = file_off(bank, addr); e = file_off(bank, nxt)
            if e > len(rom): continue
            out[label] = (bank, addr, nxt-addr, normalize(rom[s:e]))
    return out

def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('--tcg1', default='../poketcg')
    ap.add_argument('--tcg2', default='.')
    ap.add_argument('--min-bytes', type=int, default=6, help='skip tcg2 funcs smaller than this')
    ap.add_argument('--prefix', type=int, default=24, help='normalized-prefix length (bytes) for boundary-independent matching')
    ap.add_argument('--filter', default='', help='only report tcg2 funcs whose source file contains this substring')
    args = ap.parse_args()

    t2rom = open(os.path.join(args.tcg2, 'poketcg2.gbc'), 'rb').read()
    t1rom = open(os.path.join(args.tcg1, 'poketcg.gbc'), 'rb').read()
    t2 = func_bodies(t2rom, parse_sym(os.path.join(args.tcg2, 'poketcg2.sym')))
    t1 = func_bodies(t1rom, parse_sym(os.path.join(args.tcg1, 'poketcg.sym')))

    # tcg1 index by normalized-prefix (boundary-independent: function *starts*
    # line up even when the two repos label the tails differently). NAMED only,
    # and only funcs long enough to be discriminating.
    K = args.prefix
    full = {}; pref = {}
    for label, (_, _, _, fp) in t1.items():
        if label.startswith('Func_'): continue
        full.setdefault(fp, set()).add(label)
        if len(fp) >= K:
            pref.setdefault(fp[:K], set()).add(label)

    rows = []  # (confidence, tcg2_label, bank, addr, size, kind, candidates)
    for label, (bank, addr, size, fp) in sorted(t2.items()):
        if not label.startswith('Func_'): continue
        if size < args.min_bytes: continue
        if args.filter and args.filter not in f"{bank:02x}:{addr:04x}" and args.filter not in label.lower():
            continue
        hits = full.get(fp)
        if hits and len(hits) == 1:
            kind = 'EXACT'; cand = sorted(hits)
            conf = 'high' if len(fp) >= 12 else 'med'
        elif len(fp) >= K and pref.get(fp[:K]):
            cand = sorted(pref[fp[:K]]); kind = 'PREFIX'
            # high only if the long prefix is unique among named tcg1 funcs
            conf = 'high' if len(cand) == 1 and len(fp) >= K + 8 else ('med' if len(cand) == 1 else 'low')
        else:
            continue
        rows.append((conf, label, bank, addr, size, kind, cand))

    order = {'high': 0, 'med': 1, 'low': 2}
    rows.sort(key=lambda r: (order[r[0]], -r[4]))
    print(f"# {len(rows)} candidate(s)  [conf  tcg2_func  @bank:addr  size  match  -> tcg1 name(s)]")
    for conf, label, bank, addr, size, kind, cand in rows:
        c = cand[0] if len(cand) == 1 else "{" + ",".join(cand[:4]) + ("..." if len(cand) > 4 else "") + "}"
        print(f"{conf:4}  {label:18} @{bank:02x}:{addr:04x}  {size:4}B  {kind:6} -> {c}")
    hi = sum(1 for r in rows if r[0] == 'high')
    print(f"\n# {hi} high-confidence, {sum(1 for r in rows if r[0]=='med')} med, {sum(1 for r in rows if r[0]=='low')} low")

if __name__ == '__main__':
    main()
