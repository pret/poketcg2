INCLUDE "macros.asm"
INCLUDE "constants.asm"

; list of $00 padding rather than the standard $ff
; TODO: put them to the appropriate place
SECTION "ROM0 Padding", ROM0[$3ff6]
	ds $4000 - $3ff6, $00 ; after Audio Callback

SECTION "Bank 38 Padding", ROMX[$7ff2], BANK[$38]
	ds $8000 - $7ff2, $00 ; after Text 1
SECTION "Bank 39 Padding", ROMX[$7ff3], BANK[$39]
	ds $8000 - $7ff3, $00 ; after Text 2
SECTION "Bank 3a Padding", ROMX[$7ffc], BANK[$3a]
	ds $8000 - $7ffc, $00 ; after Text 3
SECTION "Bank 3b Padding", ROMX[$7ff5], BANK[$3b]
	ds $8000 - $7ff5, $00 ; after Text 4
SECTION "Bank 3c Padding", ROMX[$7fd7], BANK[$3c]
	ds $8000 - $7fd7, $00 ; after Text 5
SECTION "Bank 3d Padding", ROMX[$7feb], BANK[$3d]
	ds $8000 - $7feb, $00 ; after Text 6
SECTION "Bank 3e Padding", ROMX[$7ff9], BANK[$3e]
	ds $8000 - $7ff9, $00 ; after Text 7
SECTION "Bank 3f Padding", ROMX[$7fcb], BANK[$3f]
	ds $8000 - $7fcb, $00 ; after Text 8
SECTION "Bank 40 Padding", ROMX[$7f52], BANK[$40]
	ds $8000 - $7f52, $00 ; after Text 9
SECTION "Bank 41 Padding", ROMX[$7feb], BANK[$41]
	ds $8000 - $7feb, $00 ; after Text 10
SECTION "Bank 42 Padding", ROMX[$7fee], BANK[$42]
	ds $8000 - $7fee, $00 ; after Text 11
SECTION "Bank 43 Padding", ROMX[$7ff3], BANK[$43]
	ds $8000 - $7ff3, $00 ; after Text 12
SECTION "Bank 44 Padding", ROMX[$7f85], BANK[$44]
	ds $8000 - $7f85, $00 ; after Text 13
SECTION "Bank 45 Padding", ROMX[$7fe5], BANK[$45]
	ds $8000 - $7fe5, $00 ; after Text 14
SECTION "Bank 46 Padding", ROMX[$7ff7], BANK[$46]
	ds $8000 - $7ff7, $00 ; after Text 15
SECTION "Bank 47 Padding", ROMX[$7fcc], BANK[$47]
	ds $8000 - $7fcc, $00 ; after Text 16

SECTION "Bank 7e Padding", ROMX[$7c4d], BANK[$7e]
	ds $8000 - $7c4d, $00 ; after Audio 8
SECTION "Bank 7f Padding", ROMX[$71e6], BANK[$7f]
	ds $8000 - $71e6, $00 ; after Audio 9
