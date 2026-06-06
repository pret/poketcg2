#!/usr/bin/env python3
"""Static call graph over the tcg2 source, for labeling Func_* by context.

Since byte-matching tcg1 only resolves a handful of functions (most Func_* are
tcg2-specific), the main lever is cross-reference: who calls a Func_, and which
*named* functions / RAM symbols it calls. A function surrounded by named symbols
usually describes itself.

For each top-level label it records callers and callees (via call/jp/farcall/
bank1call/bank3call and `dw`/`db BANK(...)` table refs). Reports, per Func_*:
  - reference count (callers) -- prioritize hot functions
  - named callees -- the semantic fingerprint ("calls LoadDuel*, Draw* ...")

Usage:
  python3 tools/callgraph.py                 # summary + worklist
  python3 tools/callgraph.py Func_2c0c1      # detail for one function
  python3 tools/callgraph.py --bank 0b       # Func_* in bank, by ref count
"""
import sys, os, re, glob, argparse, bisect

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))

def load_sym(path):
    """bank -> (sorted addrs, labels) for ROM, for pc->enclosing-function lookup."""
    banks = {}
    for line in open(path):
        line = line.strip()
        if not line or line.startswith(';'): continue
        try:
            loc, label = line.split(None, 1)
            bs, as_ = loc.split(':'); bank = int(bs, 16); addr = int(as_, 16)
        except ValueError:
            continue
        if addr >= 0x8000 or '.' in label: continue   # ROM, top-level only
        banks.setdefault(bank, []).append((addr, label))
    return {b: ([a for a, _ in sorted(v)], [l for _, l in sorted(v)]) for b, v in banks.items()}

def pc_to_func(sym, bank, pc):
    """enclosing top-level function label for bank:pc."""
    if bank not in sym: return f"{bank:02x}:{pc:04x}"
    addrs, labels = sym[bank]
    i = bisect.bisect_right(addrs, pc) - 1
    return labels[i] if i >= 0 else f"{bank:02x}:{pc:04x}"

def load_dyn_edges(path, sym):
    """dynamic edge dump (cbank:cpc tbank:tpc) -> (callers, callees) func maps."""
    dcallers, dcallees = {}, {}
    for line in open(path):
        m = re.match(r'([0-9a-f]{2}):([0-9a-f]{4})\s+([0-9a-f]{2}):([0-9a-f]{4})', line.strip())
        if not m: continue
        cb, cp, tb, tp = (int(m.group(i), 16) for i in (1, 2, 3, 4))
        caller = pc_to_func(sym, cb, cp); callee = pc_to_func(sym, tb, tp)
        if caller == callee: continue
        dcallees.setdefault(caller, set()).add(callee)
        dcallers.setdefault(callee, set()).add(caller)
    return dcallers, dcallees
CALL = re.compile(r'^\s*(?:call|jp|jr|farcall|callfar|bank1call|bank3call)\s+(?:[a-z]+,\s*)?([A-Za-z_][A-Za-z0-9_]*)')
REFW = re.compile(r'\b([A-Za-z_][A-Za-z0-9_]+)\b')
LABEL = re.compile(r'^([A-Za-z_][A-Za-z0-9_]*)::?\s*(?:;.*)?$')

def build():
    callers = {}     # label -> set(caller labels)
    callees = {}     # label -> list(callee labels, in order)
    defined = set()
    for f in glob.glob(os.path.join(ROOT, 'src/**/*.asm'), recursive=True):
        cur = None
        for line in open(f, errors='replace'):
            m = LABEL.match(line)
            if m and not line[0].isspace():
                cur = m.group(1); defined.add(cur); callees.setdefault(cur, [])
                continue
            if cur is None: continue
            m = CALL.match(line)
            if m:
                tgt = m.group(1)
                callees[cur].append(tgt)
                callers.setdefault(tgt, set()).add(cur)
    return callers, callees, defined

def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('target', nargs='?', help='a label to show detail for')
    ap.add_argument('--bank', help='hex bank to list Func_* for (e.g. 0b)')
    ap.add_argument('--min-refs', type=int, default=0)
    ap.add_argument('--dyn', help='dynamic call-graph dump from sameboy_trace (SAMEBOY_CALLGRAPH)')
    args = ap.parse_args()
    callers, callees, defined = build()
    dcallers = dcallees = {}
    if args.dyn:
        sym = load_sym(os.path.join(ROOT, 'poketcg2.sym'))
        dcallers, dcallees = load_dyn_edges(args.dyn, sym)

    if args.target:
        t = args.target
        cs = sorted(callers.get(t, []))
        print(f"{t}: {len(cs)} static caller(s)")
        for c in cs: print(f"  <- {c}")
        if args.dyn:
            extra = sorted(dcallers.get(t, set()) - set(cs))
            print(f"  + {len(extra)} dynamic-only caller(s) (indirect dispatch):")
            for c in extra: print(f"  <-* {c}")
        named = [c for c in callees.get(t, []) if not c.startswith('Func_') and c in defined]
        print(f"calls {len(callees.get(t,[]))} static target(s); named callees:")
        for c in dict.fromkeys(named): print(f"  -> {c}")
        if args.dyn:
            dyn_only = sorted(dcallees.get(t, set()) - set(callees.get(t, [])))
            if dyn_only:
                print(f"  + {len(dyn_only)} dynamic-only callee(s):")
                for c in dyn_only: print(f"  ->* {c}")
        return

    funcs = sorted(f for f in defined if f.startswith('Func_'))
    if args.bank:
        # Func_<hex>: 4 digits => home (bank 0); 5+ digits => linear file offset (bank = val>>14)
        want = int(args.bank, 16)
        def fbank(name):
            h = re.match(r'Func_([0-9a-f]+)', name)
            if not h: return None
            v = int(h.group(1), 16)
            return 0 if len(h.group(1)) <= 4 else v >> 14
        funcs = [f for f in funcs if fbank(f) == want]
    rows = []
    for f in funcs:
        nc = len(callers.get(f, []))
        if nc < args.min_refs: continue
        named = [c for c in dict.fromkeys(callees.get(f, [])) if not c.startswith('Func_') and c in defined]
        rows.append((nc, f, named))
    rows.sort(key=lambda r: -r[0])
    print(f"# {len(rows)} Func_* (callers, named-callee hints)")
    for nc, f, named in rows[:80]:
        hint = ', '.join(named[:5]) + ('…' if len(named) > 5 else '')
        print(f"{nc:3} refs  {f:16}  {hint}")
    tot = sum(len(callers.get(f, [])) for f in funcs)
    print(f"\n# {len(funcs)} Func_* total; {sum(1 for f in funcs if not callers.get(f))} never call-referenced (table/ptr only or dead)")

if __name__ == '__main__':
    main()
