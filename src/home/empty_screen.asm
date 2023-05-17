; initialize the screen by emptying the tilemap. used during screen transitions
EmptyScreen::
	call DisableLCD
	call FillTileMap
	xor a
	ld [wDuelDisplayedScreen], a
	ret

; returns v*BGMap0 + BG_MAP_WIDTH * c + b in de.
; used to map coordinates at bc to a BGMap0 address.
BCCoordToBGMap0Address::
	ld l, c
	ld h, $0
	add hl, hl
	add hl, hl
	add hl, hl
	add hl, hl
	add hl, hl
	ld c, b
	ld b, HIGH(v0BGMap0)
	add hl, bc
	ld e, l
	ld d, h
	ret
