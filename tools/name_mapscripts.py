#!/usr/bin/env python3
"""Name overworld map-script handler Func_* by their OWMODE slot.

Each map has a `<Map>_MapScripts:` table of `dbw OWMODE_<MODE>, <handler>` entries
(walked by ExecuteOWModeScript). This is tcg2's generalization of tcg1's fixed
8-slot MapScripts table, and like tcg1 the handlers are named per map + slot:
  dbw OWMODE_STEP_EVENT, Func_2d376   (in RockClubEntrance_MapScripts)
    ->  RockClubEntrance_StepEvent

Only handlers that are still Func_*, appear in exactly ONE table (map-specific),
and whose generated name doesn't already exist are renamed. Slot-based naming
matches tcg1 and is correct regardless of the handler's internal logic (the name
says WHEN it runs in the map lifecycle).

Usage:
  python3 tools/name_mapscripts.py            # dry run: print the rename map
  python3 tools/name_mapscripts.py --apply    # apply renames across src/
"""
import re, glob, os, sys, subprocess
from collections import Counter

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))

# OWMODE_<MODE> -> CamelCase slot action. NPC_POSITION handlers load the map's
# NPC table, so they read better as LoadNPCs (matches tcg1's <Map>NPCS).
ACTION = {
    'AFTER_DUEL': 'AfterDuel', 'AFTER_DUEL_PRELOAD': 'AfterDuelPreload',
    'CONTINUE_DUEL': 'ContinueDuel', 'CONTINUE_OW': 'ContinueOW',
    'IDLE': 'Idle', 'INTERACT': 'Interact',
    'MUSIC_POSTLOAD': 'MusicPostload', 'MUSIC_PRELOAD': 'MusicPreload',
    'NPC_POSITION': 'LoadNPCs', 'PAUSE_MENU': 'PauseMenu',
    'SAVE_POSTLOAD': 'SavePostload', 'SAVE_PRELOAD': 'SavePreload',
    'STEP_EVENT': 'StepEvent', 'WARP_END_SFX': 'WarpEndSFX',
    'WARP_FADE_IN_PRELOAD': 'WarpFadeInPreload',
    'WARP_FADE_OUT_PRELOAD': 'WarpFadeOutPreload',
}

def scan_tables():
    tables = {}  # map -> [(mode, handler)]
    cur = None
    for f in sorted(glob.glob(os.path.join(ROOT, 'src/**/*.asm'), recursive=True)):
        for line in open(f, errors='replace'):
            m = re.match(r'^([A-Za-z_][A-Za-z0-9_]*)_MapScripts:', line)
            if m:
                cur = m.group(1); tables.setdefault(cur, []); continue
            m = re.match(r'^\s*dbw OWMODE_([A-Z_]+),\s*([A-Za-z_][A-Za-z0-9_]*)', line)
            if m and cur is not None:
                tables[cur].append((m.group(1), m.group(2)))
            elif re.match(r'^[A-Za-z]', line):
                cur = None
    return tables

def existing_labels():
    labels = set()
    for f in glob.glob(os.path.join(ROOT, 'src/**/*.asm'), recursive=True):
        for line in open(f, errors='replace'):
            m = re.match(r'^([A-Za-z_][A-Za-z0-9_]*)::?', line)
            if m: labels.add(m.group(1))
    return labels

def build_renames():
    tables = scan_tables()
    handlers = [h for v in tables.values() for _, h in v if h.startswith('Func_')]
    shared = {h for h, n in Counter(handlers).items() if n > 1}
    labels = existing_labels()
    renames = {}; skipped = []
    for mp, entries in tables.items():
        for mode, h in entries:
            if not h.startswith('Func_') or h in shared:
                continue
            if mode not in ACTION:
                skipped.append((h, f'unknown mode {mode}')); continue
            name = f'{mp}_{ACTION[mode]}'
            if name in labels or name in renames.values():
                skipped.append((h, f'collision {name}')); continue
            renames[h] = name
    return renames, shared, skipped

def main():
    apply = '--apply' in sys.argv
    renames, shared, skipped = build_renames()
    print(f"# {len(renames)} handlers to rename; {len(shared)} shared (skipped): {sorted(shared)}")
    if skipped:
        print(f"# {len(skipped)} other skips:")
        for h, why in skipped[:20]: print(f"#   {h}: {why}")
    for h, n in sorted(renames.items()):
        print(f"{h} -> {n}")
    if apply:
        # group renames by file for efficient sed-free perl pass
        files = set()
        for f in glob.glob(os.path.join(ROOT, 'src/**/*.asm'), recursive=True):
            files.add(f)
        # build one perl script: s/\bOLD\b/NEW/g for each
        subs = ';'.join(f's/\\b{o}\\b/{n}/g' for o, n in renames.items())
        # perl has command-length limits with 554 subs; write to a script file
        script = os.path.join(ROOT, 'tools', '_mapscripts_sub.pl')
        with open(script, 'w') as s:
            for o, n in renames.items():
                s.write(f's/\\b{o}\\b/{n}/g;\n')
        for f in sorted(files):
            subprocess.run(['perl', '-pi', script, f], check=True)
        os.remove(script)
        print(f"\n# applied {len(renames)} renames")

if __name__ == '__main__':
    main()
