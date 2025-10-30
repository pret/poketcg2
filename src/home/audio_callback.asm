SECTION "Audio Callback", ROM0

; jumps to 7e:hl, then switches to bank 78
Bankswitch78To7e::
	push af
	ld a, $7e
	ldh [hBankROM], a
	ld [rROMB], a
	pop af
	ld bc, .bankswitch78
	push bc
	jp hl
.bankswitch78
	ld a, $78
	ldh [hBankROM], a
	ld [rROMB], a
	ret
