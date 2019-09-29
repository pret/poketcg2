INCBIN "baserom.gbc", $0000, $0979 - $0000
; RST18
; this function affects the stack so that it returns to the pointer following
; the rst call. similar to rst 28, except this always loads bank 1
; Note: Exact match to TCG1
Bank1Call: ; 0979 (0:0979)
	push hl
	push hl
	push hl
	push hl
	push de
	push af
	ld hl, sp+$d
	ld d, [hl]
	dec hl
	ld e, [hl]
	dec hl
	ld [hl], $0
	dec hl
	ldh a, [hBankROM]
	ld [hld], a
	ld [hl], $9
	dec hl
	ld [hl], $a7
	dec hl
	inc de
	ld a, [de]
	ld [hld], a
	dec de
	ld a, [de]
	ld [hl], a
	ld a, $1
;	fallthrough
INCBIN "baserom.gbc", $0999, $09b4 - $0999
FarCall: ; 09b4 (0:09b4)
	push hl
	push hl
	push hl
	push hl
	push de
	push af
	ld hl, sp+$d
	ld d, [hl]
	dec hl
	ld e, [hl]
	dec hl
	ld [hl], $0
	dec hl
	ldh a, [hBankROM]
	ld [hld], a
	ld [hl], $9
	dec hl
	ld [hl], $a7
	dec hl
	inc de
	inc de
	ld a, [de]
	ld [hld], a
	dec de
	ld a, [de]
	ld [hl], a
	dec de
	ld a, [de]
	inc de
	jr $0999
;	fallthrough
INCBIN "baserom.gbc", $09d8, $1486 - $09d8
GetTurnDuelistVariable: ; 1486 (0:1486)
	ld l, a
	ldh a, [hWhoseTurn]
	ld h, a
	ld a, [hl]
	ret
;	fallthrough
INCBIN "baserom.gbc", $148c, $4000 - $148c