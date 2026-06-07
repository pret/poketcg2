#!/usr/bin/env python3
"""Render card-graphics examples (portrait / in-duel color / extra tiles /
printer gray) for docs/card-graphics.md. Reads the real source: the 3 palettes
+ 48-byte attribute map from src/gfx/card_graphics.asm, the 48 portrait tiles
from <name>.2bpp, and the appended printer tiles from <name>_extra.bin."""
import re, os
from PIL import Image

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
GFX  = os.path.join(ROOT, 'src/gfx/cards')
ASM  = os.path.join(ROOT, 'src/gfx/card_graphics.asm')
OUT  = os.path.join(ROOT, 'docs/img')
GRAY = [(255,255,255),(170,170,170),(85,85,85),(0,0,0)]  # 2bpp value 0..3, light->dark

def label(name):  # grass_energy -> GrassEnergyCardGfx
    return ''.join(p.capitalize() for p in name.split('_')) + 'CardGfx'

def parse_header(name):
    """return (palettes[3][4]=(r,g,b 0-31), attr[48])."""
    lab = label(name); pals=[]; attr=[]; grab=False
    for line in open(ASM):
        if line.startswith(lab+'::'): grab=True; continue
        if not grab: continue
        m=re.match(r'\s*rgb\s+(\d+),\s*(\d+),\s*(\d+)', line)
        if m: pals.append(tuple(int(x) for x in m.groups())); continue
        m=re.match(r'\s*db\s+(.+)', line)
        if m: attr += [int(x,16) for x in re.findall(r'\$([0-9a-f]{2})', m.group(1))]; continue
        if 'INCBIN' in line: break
    pal3=[pals[i*4:i*4+4] for i in range(3)]
    return pal3, attr

def tiles(blob):  # bytes -> list of 8x8 value grids
    out=[]
    for t in range(len(blob)//16):
        b=blob[t*16:t*16+16]; g=[[0]*8 for _ in range(8)]
        for r in range(8):
            lo,hi=b[2*r],b[2*r+1]
            for x in range(8):
                bit=7-x; g[r][x]=((hi>>bit)&1)<<1 | ((lo>>bit)&1)
        out.append(g)
    return out

def rgb555(c): return tuple(round(v*255/31) for v in c)

def grid_img(tile_vals, color_of, cols, rows):
    """place tiles in a cols x rows grid, COLUMN-MAJOR (rgbgfx -Z): tile k at (k//rows, k%rows)."""
    im=Image.new('RGB',(cols*8,rows*8),(255,0,255))
    px=im.load()
    for k in range(cols*rows):
        if k>=len(tile_vals): break
        gx,gy=k//rows,k%rows; g=tile_vals[k]
        for r in range(8):
            for x in range(8):
                px[gx*8+x, gy*8+r]=color_of(k,g[r][x])
    return im

def strip_img(tile_vals, per_row=8):
    n=len(tile_vals); rows=(n+per_row-1)//per_row
    im=Image.new('RGB',(per_row*8,rows*8),(40,40,40)); px=im.load()
    for k,g in enumerate(tile_vals):
        gx,gy=k%per_row,k//per_row
        for r in range(8):
            for x in range(8): px[gx*8+x,gy*8+r]=GRAY[g[r][x]]
    return im

def save(im, name, scale):
    im=im.resize((im.width*scale, im.height*scale), Image.NEAREST)
    im.save(os.path.join(OUT,name)); print('wrote', name, im.size)

def render(name, scale=10):
    pal,attr=parse_header(name)
    port=open(os.path.join(GFX,name+'.2bpp'),'rb').read()
    ex=os.path.join(GFX,name+'_extra.bin')
    extra=open(ex,'rb').read() if os.path.exists(ex) else b''
    pool=tiles(port+extra)            # full tile pool: 48 portrait + N extra
    ptiles=pool[:48]
    # in-duel COLOR: output cell c = portrait tile c, palette = attr[c]>>6
    # in-duel: tile k sits at screen (col k//6, row k%6); the attribute map is
    # indexed ROW-MAJOR by screen cell (.ApplyAttrmap copies attr[i] straight to
    # BG cell i, while .CardTilemap places column-major tile (col*6+row) there).
    induel=grid_img(ptiles, lambda c,v: rgb555(pal[attr[(c%6)*8 + (c//6)]>>6][v]), 8,6)
    save(induel, f'{name}_induel.png', scale)
    # portrait stored tiles, grayscale (what <name>.2bpp / .png holds)
    save(grid_img(ptiles, lambda c,v: GRAY[v], 8,6), f'{name}_portrait_gray.png', scale)
    # printer FLAT GRAY: output cell c = pool tile (attr[c]&0x3f)+c, no palette
    im=Image.new('RGB',(8*8,6*8),(255,0,255)); px=im.load()
    for c in range(48):
        src=(attr[c]&0x3f)+c; g=pool[src]; gx,gy=c//6,c%6
        for r in range(8):
            for x in range(8): px[gx*8+x,gy*8+r]=GRAY[g[r][x]]
    save(im, f'{name}_printer_gray.png', scale)
    if extra:
        save(strip_img(pool[48:]), f'{name}_extra_tiles.png', scale)
    # attr decode table data
    redirect=[c for c in range(48) if (attr[c]&0x3f)+c>47]
    return dict(name=name, n_extra=len(extra)//16, redirect=redirect, attr=attr)

if __name__=='__main__':
    import json
    info={n:render(n) for n in ('grass_energy','charmander_lv10','abra_lv14')}
    json.dump({k:{'n_extra':v['n_extra'],'redirect':v['redirect']} for k,v in info.items()},
              open(os.path.join(OUT,'_info.json'),'w'), indent=1)
    print('done')
