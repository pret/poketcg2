; prints decimal digit in a
; to coordinates de
PrintDigit:
	push af
	push bc
	push de
	push hl
	add SYM_0
	ld b, d ; x
	ld c, e ; y
	call WriteByteToBGMap0
	pop hl
	pop de
	pop bc
	pop af
	ret

; hl = 16-bit input value
; de = coordinates
; b = FALSE: left-padded with zeroes
;     TRUE:  left-padded with empty spaces
; a = identation
PrintNumber:
	ld c, a
	push de
	ld de, wDecimalRepresentation
	call CalculateDecimalDigits
	pop de
	ld a, d
	add c
	ld d, a
	ld hl, wDecimalRepresentation + $4
.loop_digits
	ld a, [hld]
	cp $ff
	jr nz, .print
	dec d
	push af
	push bc
	push de
	push hl
	ld b, d ; x
	ld c, e ; y
	ld a, SYM_SPACE
	call WriteByteToBGMap0
	pop hl
	pop de
	pop bc
	pop af
	jr .next_digit
.print
	dec d
	call PrintDigit
.next_digit
	dec c
	jr nz, .loop_digits
	ret

; hl = 16-bit input value
; de = address to write character bytes
; b = FALSE: left-padded with zeroes
;     TRUE:  left-padded with empty spaces
CalculateDecimalDigits:
	push af
	push bc
	push de
	push hl
	push bc
	push de
	ld bc, -10000
	call .GetDigit ; ten-thousands digit
	ld bc, -1000
	call .GetDigit ; thousands digit
	ld bc, -100
	call .GetDigit ; hundreds digit
	ld bc, -10
	call .GetDigit ; tens digit
	ld bc, -1
	call .GetDigit ; ones digit
	pop de
	pop bc
	ld a, b
	and a
	jr z, .done
; left pad with $ff
	ld c, 4
.loop_pad
	ld a, [de]
	and a
	jr nz, .done
	ld a, $ff
	ld [de], a
	inc de
	dec c
	jr nz, .loop_pad
.done
	pop hl
	pop de
	pop bc
	pop af
	ret

.GetDigit:
	ld a, -1
.loop
	inc a
	add hl, bc
	jr c, .loop
	push af
	ld a, l
	sub c
	ld l, a
	ld a, h
	sbc b
	ld h, a
	pop af
	ld [de], a
	inc de
	ret

Func_1c08b::
	push af
	push bc
	push de
	push hl
	xor a
	call BankswitchVRAM
	ld a, c ; unused
	ld hl, v0Tiles1
	add hl, bc
	inc d
.loop_tiles
	ld c, TILE_SIZE / 2
.loop_inner
	di
	call WaitForLCDOff
	ld a, $ff
	ld [hli], a
	inc hl
	ei
	dec c
	jr nz, .loop_inner
	dec e
	jr nz, .loop_tiles
	dec d
	jr nz, .loop_tiles
	pop hl
	pop de
	pop bc
	pop af
	ret
; 0x1c0b2

SECTION "Bank 7@40ec", ROMX[$40ec], BANK[$7]

Func_1c0ec::
	push bc
	push de
	push hl
	ld a, EVENT_PLAYER_GENDER
	farcall GetEventValue
	jr nz, .female
; male
	ld a, NPC_MARK
	jr .asm_1c0fd
.female
	ld a, NPC_MINT
.asm_1c0fd
	pop hl
	pop de
	pop bc
	ret

; converts NPC_* in a
; into PORTRAIT_* constant
GetDuelistPortrait::
	push bc
	push hl
	ld c, a
	ld b, $00
	ld hl, .PortraitIDs
	add hl, bc
	ld a, [hl]
	pop hl
	pop bc
	ret

.PortraitIDs
	db PORTRAIT_MARK          ; NPC_MARK
	db PORTRAIT_MINT          ; NPC_MINT
	db PORTRAIT_MARK_LINK     ; NPC_MARK_LINK
	db PORTRAIT_MINT_LINK     ; NPC_MINT_LINK
	db PORTRAIT_RONALD        ; NPC_RONALD
	db PORTRAIT_SAM           ; NPC_SAM
	db PORTRAIT_AARON         ; NPC_AARON
	db PORTRAIT_ISHIHARA      ; NPC_ISHIHARA
	db PORTRAIT_IMAKUNI_BLACK ; NPC_IMAKUNI_BLACK
	db PORTRAIT_IMAKUNI_RED   ; NPC_IMAKUNI_RED
	db PORTRAIT_ISAAC         ; NPC_ISAAC
	db PORTRAIT_JENNIFER      ; NPC_JENNIFER
	db PORTRAIT_NICHOLAS      ; NPC_NICHOLAS
	db PORTRAIT_BRANDON       ; NPC_BRANDON
	db PORTRAIT_MURRAY        ; NPC_MURRAY
	db PORTRAIT_STEPHANIE     ; NPC_STEPHANIE
	db PORTRAIT_DANIEL        ; NPC_DANIEL
	db PORTRAIT_ROBERT        ; NPC_ROBERT
	db PORTRAIT_GENE          ; NPC_GENE
	db PORTRAIT_MATTHEW       ; NPC_MATTHEW
	db PORTRAIT_RYAN          ; NPC_RYAN
	db PORTRAIT_ANDREW        ; NPC_ANDREW
	db PORTRAIT_MITCH         ; NPC_MITCH
	db PORTRAIT_MICHAEL       ; NPC_MICHAEL
	db PORTRAIT_CHRIS         ; NPC_CHRIS
	db PORTRAIT_JESSICA       ; NPC_JESSICA
	db PORTRAIT_NIKKI         ; NPC_NIKKI
	db PORTRAIT_BRITTANY      ; NPC_BRITTANY
	db PORTRAIT_KRISTIN       ; NPC_KRISTIN
	db PORTRAIT_HEATHER       ; NPC_HEATHER
	db PORTRAIT_RICK          ; NPC_RICK
	db PORTRAIT_JOSEPH        ; NPC_JOSEPH
	db PORTRAIT_DAVID         ; NPC_DAVID
	db PORTRAIT_ERIK          ; NPC_ERIK
	db PORTRAIT_AMY           ; NPC_AMY
	db PORTRAIT_JOSHUA        ; NPC_JOSHUA
	db PORTRAIT_SARA          ; NPC_SARA
	db PORTRAIT_AMANDA        ; NPC_AMANDA
	db PORTRAIT_KEN           ; NPC_KEN
	db PORTRAIT_JOHN          ; NPC_JOHN
	db PORTRAIT_ADAM          ; NPC_ADAM
	db PORTRAIT_JONATHAN      ; NPC_JONATHAN
	db PORTRAIT_COURTNEY      ; NPC_COURTNEY
	db PORTRAIT_STEVE         ; NPC_STEVE
	db PORTRAIT_JACK          ; NPC_JACK
	db PORTRAIT_ROD           ; NPC_ROD
	db PORTRAIT_EIJI          ; NPC_EIJI
	db PORTRAIT_MAGICIAN      ; NPC_MAGICIAN
	db PORTRAIT_YUI           ; NPC_YUI
	db PORTRAIT_TOSHIRON      ; NPC_TOSHIRON
	db PORTRAIT_PIERROT       ; NPC_PIERROT
	db PORTRAIT_ANNA          ; NPC_ANNA
	db PORTRAIT_DEE           ; NPC_DEE
	db PORTRAIT_MASQUERADE    ; NPC_MASQUERADE
	db PORTRAIT_PAWN          ; NPC_PAWN
	db PORTRAIT_KNIGHT        ; NPC_KNIGHT
	db PORTRAIT_BISHOP        ; NPC_BISHOP
	db PORTRAIT_ROOK          ; NPC_ROOK
	db PORTRAIT_QUEEN         ; NPC_QUEEN
	db PORTRAIT_GR_1          ; NPC_GR_1
	db PORTRAIT_GR_2          ; NPC_GR_2
	db PORTRAIT_GR_3          ; NPC_GR_3
	db PORTRAIT_GR_4          ; NPC_GR_4
	db PORTRAIT_MIDORI        ; NPC_MIDORI
	db PORTRAIT_YUUTA         ; NPC_YUUTA
	db PORTRAIT_MIYUKI        ; NPC_MIYUKI
	db PORTRAIT_MORINO        ; NPC_MORINO
	db PORTRAIT_RENNA         ; NPC_RENNA
	db PORTRAIT_ICHIKAWA      ; NPC_ICHIKAWA
	db PORTRAIT_CATHERINE     ; NPC_CATHERINE
	db PORTRAIT_TAP           ; NPC_TAP
	db PORTRAIT_JES           ; NPC_JES
	db PORTRAIT_YUKI          ; NPC_YUKI
	db PORTRAIT_SHOKO         ; NPC_SHOKO
	db PORTRAIT_HIDERO        ; NPC_HIDERO
	db PORTRAIT_MIYAJIMA      ; NPC_MIYAJIMA
	db PORTRAIT_SENTA         ; NPC_SENTA
	db PORTRAIT_AIRA          ; NPC_AIRA
	db PORTRAIT_KANOKO        ; NPC_KANOKO
	db PORTRAIT_GODA          ; NPC_GODA
	db PORTRAIT_GRACE         ; NPC_GRACE
	db PORTRAIT_KAMIYA        ; NPC_KAMIYA
	db PORTRAIT_MIWA          ; NPC_MIWA
	db PORTRAIT_KEVIN         ; NPC_KEVIN
	db PORTRAIT_YOSUKE        ; NPC_YOSUKE
	db PORTRAIT_RYOKO         ; NPC_RYOKO
	db PORTRAIT_MAMI          ; NPC_MAMI
	db PORTRAIT_NISHIJIMA     ; NPC_NISHIJIMA
	db PORTRAIT_ISHII         ; NPC_ISHII
	db PORTRAIT_SAMEJIMA      ; NPC_SAMEJIMA
	db PORTRAIT_KANZAKI       ; NPC_KANZAKI
	db PORTRAIT_RUI           ; NPC_RUI
	db PORTRAIT_BIRURITCHI    ; NPC_BIRURITCHI
	db PORTRAIT_GR_X          ; NPC_GR_X
	db PORTRAIT_TOBI_CHAN     ; NPC_TOBI_CHAN
	db PORTRAIT_DR_MASON      ; NPC_DR_MASON
; 0x1c116

SECTION "Bank 7@4395", ROMX[$4395], BANK[$7]

LoadSavedOptions:
	call EnableSRAM
	call .LoadTextSpeed
	call .LoadDuelAnimation
	call .LoadCoinTossAnimation
	call .LoadTextFrameColor
	call DisableSRAM
	ret

.LoadTextSpeed:
	ld a, [sTextSpeed]
	ld [wTextSpeed], a
	call Func_1c448
	ld b, a
	ld a, 4
	sub b
	ld [wd9d5], a
	ret

.LoadDuelAnimation:
	ld a, [s0a007]
	ld [wd9d3], a
	srl a
	and $01
	ld [wAnimationsDisabled], a
	ret

.LoadCoinTossAnimation:
	ld a, [s0a00b]
	ld [wd9d4], a
	ret

.LoadTextFrameColor:
	ld a, [sTextBoxFrameColor]
	ld [wTextBoxFrameColor], a
	ret

Func_1c3d5:
	call EnableSRAM
	call Func_1c3e8
	call Func_1c3f9
	call Func_1c417
	call SaveTextBoxFrameColor
	call DisableSRAM
	ret

Func_1c3e8:
	ld a, [wd9d5]
	ld b, a
	ld a, $04
	sub b
	call Func_1c438
	ld [sTextSpeed], a
	ld [wTextSpeed], a
	ret

Func_1c3f9:
	ld a, [wd9d3]
	ld [s0a007], a
	push af
	srl a
	and $01
	ld [wAnimationsDisabled], a
	pop af
	ld c, a
	ld b, $00
	ld hl, .data
	add hl, bc
	ld a, [hl]
	ld [sSkipDelayAllowed], a
	ret

.data
	db $00, $01, $01

Func_1c417:
	ld a, [wd9d4]
	ld [s0a00b], a
	ret

SaveTextBoxFrameColor:
	ld a, [wTextBoxFrameColor]
	ld [sTextBoxFrameColor], a
	ret

Func_1c425:
	ld a, $02
	ld [wd9d5], a
	xor a
	ld [wd9d4], a
	ld [wd9d3], a
	ld [wTextBoxFrameColor], a
	ld [wd9d0], a
	ret

Func_1c438:
	push bc
	ld c, a
	ld b, $00
	ld hl, .data
	add hl, bc
	ld a, [hl]
	pop bc
	ret

.data
	db $00, $01, $02, $04, $06

Func_1c448:
	push bc
	ld c, a
	ld b, $00
	ld hl, .data
	add hl, bc
	ld a, [hl]
	pop bc
	ret

.data
	db $00, $01, $02
; 0x1c456

SECTION "Bank 7@46bb", ROMX[$46bb], BANK[$7]

SetAllPaletteFadeConfigsToEnabled:
	call SetAllBGPaletteFadeConfigsToEnabled
	call SetAllOBPaletteFadeConfigsToEnabled
	ret

FadePalettes::
	push af
	push bc
	push de
	push hl
	ld a, [wPaletteFadeMode]
	and a
	jr z, .done
	ld a, [wPaletteFadeSpeedMask]
	ld b, a
	ld a, [wVBlankCounter]
	and b
	jr nz, .done
	ld a, [wPaletteFadeMode]
	dec a
	jr nz, .asm_1c6e1
; wPaletteFadeMode == 1
	call Func_1c7b6
	jr .decrement_counter
.asm_1c6e1
; wPaletteFadeMode != 1
	call Func_1c799
.decrement_counter
	ld hl, wPaletteFadeCounter
	ld a, [hl]
	and a
	jr z, .done
	ld a, [hl] ; unnecessary
	dec a
	ld [hl], a
	jr nz, .done
	xor a
	ld [wPaletteFadeMode], a
.done
	pop hl
	pop de
	pop bc
	pop af
	ret

FadeBGPalsToWhiteOrBlack:
	ld bc, wBGColorFadeConfigList
	ld hl, wBackgroundPalettesCGB
	ld a, (NUM_BACKGROUND_PALETTES palettes) / 2
.loop_colors
	push af
	ld e, [hl]
	inc hl
	ld d, [hl]
	dec hl
	ld a, [bc]
	or a
	jr nz, .skip_color
	call FadeColorToBlackOrWhite
.skip_color
	ld [hl], e
	inc hl
	ld [hl], d
	inc hl
	pop af
	inc bc
	dec a
	jr nz, .loop_colors
	ret

FadeOBPalsToWhiteOrBlack:
	ld bc, wOBColorFadeConfigList
	ld hl, wObjectPalettesCGB
	ld a, (NUM_OBJECT_PALETTES palettes) / 2
.asm_1c71f
	push af
	ld e, [hl]
	inc hl
	ld d, [hl]
	dec hl
	ld a, [bc]
	or a
	jr nz, .asm_1c72b
	call FadeColorToBlackOrWhite
.asm_1c72b
	ld [hl], e
	inc hl
	ld [hl], d
	inc hl
	pop af
	inc bc
	dec a
	jr nz, .asm_1c71f
	ret

Func_1c735:
	ld bc, wBGColorFadeConfigList
	ld hl, wTargetBGPalettes
	ld de, wBackgroundPalettesCGB
	ld a, (NUM_BACKGROUND_PALETTES palettes) / 2
.asm_1c740
	push af
	push hl
	push de
	push bc
	ld a, [de]
	ld b, a
	inc de
	ld a, [de]
	ld d, a
	ld e, b
	pop bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, [bc]
	or a
	jr nz, .asm_1c755
	call FadeColorToTarget
.asm_1c755
	ld h, d
	ld l, e
	pop de
	ld a, l
	ld [de], a
	inc de
	ld a, h
	ld [de], a
	inc de
	pop hl
	inc hl
	inc hl
	pop af
	inc bc
	dec a
	jr nz, .asm_1c740
	ret

Func_1c767:
	ld bc, wOBColorFadeConfigList
	ld hl, wTargetOBPalettes
	ld de, wObjectPalettesCGB
	ld a, (NUM_OBJECT_PALETTES palettes) / 2
.asm_1c772
	push af
	push hl
	push de
	push bc
	ld a, [de]
	ld b, a
	inc de
	ld a, [de]
	ld d, a
	ld e, b
	pop bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, [bc]
	or a
	jr nz, .asm_1c787
	call FadeColorToTarget
.asm_1c787
	ld h, d
	ld l, e
	pop de
	ld a, l
	ld [de], a
	inc de
	ld a, h
	ld [de], a
	inc de
	pop hl
	inc hl
	inc hl
	pop af
	inc bc
	dec a
	jr nz, .asm_1c772
	ret

Func_1c799:
	ld hl, wPaletteFadeFlags
	bit 0, [hl]
	jr z, .asm_1c7a3
	call FadeBGPalsToWhiteOrBlack
.asm_1c7a3
	ld hl, wPaletteFadeFlags
	bit 7, [hl]
	jr z, .asm_1c7ad
	call FadeOBPalsToWhiteOrBlack
.asm_1c7ad
	call FlushAllPalettes
	ld a, $02
	ld [wd9de], a
	ret

Func_1c7b6:
	ld hl, wPaletteFadeFlags
	bit 0, [hl]
	jr z, .asm_1c7c0
	call Func_1c735
.asm_1c7c0
	ld hl, wPaletteFadeFlags
	bit 7, [hl]
	jr z, .asm_1c7ca
	call Func_1c767
.asm_1c7ca
	call FlushAllPalettes
	ld a, $01
	ld [wd9de], a
	ret

; de = 15-bit palette colors
FadeColorToBlackOrWhite:
	push af
	push bc
	push hl

; blue
	ld a, d
	and $7c
	srl a
	srl a
	call .FadeColor
	sla a
	sla a
	and $7c
	ld b, a

; green
	ld a, d
	and $03
	or b
	ld d, a
	ld a, e
	and $1f
	call .FadeColor
	and $1f
	ld b, a
	ld a, e
	and $e0
	or b
	ld e, a
	ld a, d
	and $03
	sla a
	sla a
	sla a
	ld b, a

; red
	ld a, e
	and $e0
	swap a
	srl a
	or b
	call .FadeColor
	ld c, a
	srl a
	srl a
	srl a
	and $03
	ld b, a
	ld a, d
	and $fc
	or b
	ld d, a
	ld a, c
	swap a
	sla a
	and $e0
	ld b, a
	ld a, e
	and $1f
	or b
	ld e, a
	pop hl
	pop bc
	pop af
	ret

.FadeColor:
	push hl
	ld hl, wPalFadeDirection
	bit 0, [hl]
	pop hl
	jr nz, .decr_color

; incr color
REPT 4
	ld b, a
	cp $1f
	ld a, b
	ret z
	inc a
ENDR
	ret

.decr_color
	and a
REPT 4
	ret z
	dec a
ENDR
	ret

; hl = 15-bit palette colors (target)
; de = 15-bit palette colors (source)
FadeColorToTarget:
	push af
	push bc
	push hl

; blue
	ld a, h
	and $7c
	srl a
	srl a
	ld c, a
	ld a, d
	and $7c
	srl a
	srl a
	call .FadeColor
	sla a
	sla a
	and $7c
	ld b, a

; green
	ld a, d
	and $03
	or b
	ld d, a
	ld a, l
	and $1f
	ld c, a
	ld a, e
	and $1f
	call .FadeColor
	and $1f
	ld b, a
	ld a, e
	and $e0
	or b
	ld e, a
	ld a, h
	and $03
	sla a
	sla a
	sla a
	ld b, a

; red
	ld a, l
	and $e0
	swap a
	srl a
	or b
	ld c, a
	ld a, d
	and $03
	sla a
	sla a
	sla a
	ld b, a
	ld a, e
	and $e0
	swap a
	srl a
	or b
	call .FadeColor
	ld c, a
	srl a
	srl a
	srl a
	and $03
	ld b, a
	ld a, d
	and $fc
	or b
	ld d, a
	ld a, c
	swap a
	sla a
	and $e0
	ld b, a
	ld a, e
	and $1f
	or b
	ld e, a
	pop hl
	pop bc
	pop af
	ret

.FadeColor:
	push hl
	ld hl, wPalFadeDirection
	bit 0, [hl]
	pop hl
	jr nz, .incr_color

; decr color
REPT 4
	ld b, a
	cp c
	ld a, b
	ret z
	dec a
ENDR
	ret

.incr_color
REPT 2
	ld b, a
	cp c
	ld a, b
	ret z
	inc a
	ld b, a
	cp c
	ld a, b
	ret nc
	inc a
ENDR
	ret

; b = mask used on VBlankCounter
;     for deciding when to fade color
; if a = 0, fade from white
; if a = 1, fade from black
StartPalFadeFromBlackOrWhite::
	push af
	ld [wPalFadeDirection], a
	ld a, b
	ld [wPaletteFadeSpeedMask], a
	pop af
	and a
	ld a, $ff ; white
	jr z, .got_fill_color
	ld a, $00 ; black
.got_fill_color
	call InitFadePalettes
	ld a, $01
	ld [wPaletteFadeMode], a
	ld a, 8
	ld [wPaletteFadeCounter], a
	ret

; b = mask used on VBlankCounter
;     for deciding when to fade color
; if a = 0, fade to white
; if a = 1, fade to black
StartPalFadeToBlackOrWhite:
	ld [wPalFadeDirection], a
	ld a, b
	ld [wPaletteFadeSpeedMask], a
	call SaveTargetFadePals
	ld a, $02
	ld [wPaletteFadeMode], a
	ld a, 8
	ld [wPaletteFadeCounter], a
	ret
; 0x1c93c

SECTION "Bank 7@493c", ROMX[$493c], BANK[$7]

; returns nz if palettes are still fading
CheckPalFading::
	ld a, [wPaletteFadeMode]
	and a
	ret
; 0x1c941

SECTION "Bank 7@494a", ROMX[$494a], BANK[$7]

; fills the pals with fade enabled
; with color in a
; a = $00 for black
;     $ff for white
InitFadePalettes:
	push af
	push bc
	push de
	push hl
	ld e, a
	ld hl, wPaletteFadeFlags
	bit 0, [hl]
	jr z, .asm_1c96d
	ld bc, wBGColorFadeConfigList
	ld hl, wBackgroundPalettesCGB
	ld d, (NUM_BACKGROUND_PALETTES palettes) / 2
.loop_1
	ld a, [bc]
	or a
	jr nz, .asm_1c967
	push hl
	ld [hl], e
	inc hl
	ld [hl], e
	pop hl
.asm_1c967
	inc hl
	inc hl
	inc bc
	dec d
	jr nz, .loop_1

.asm_1c96d
	ld hl, wPaletteFadeFlags
	bit 7, [hl]
	jr z, .asm_1c98b
	ld bc, wOBColorFadeConfigList
	ld hl, wObjectPalettesCGB
	ld d, (NUM_OBJECT_PALETTES palettes) / 2
.loop_2
	ld a, [bc]
	or a
	jr nz, .skip_2
	push hl
	ld [hl], e
	inc hl
	ld [hl], e
	pop hl
.skip_2
	inc hl
	inc hl
	inc bc
	dec d
	jr nz, .loop_2
.asm_1c98b
	pop hl
	pop de
	pop bc
	pop af
	ret

; saves the current palettes in
; wBackgroundPalettesCGB/wObjectPalettesCGB
; to wTargetBGPalettes/wTargetOBPalettes
SaveTargetFadePals::
	push af
	push bc
	push de
	push hl
	ld hl, wPaletteFadeFlags
	bit 0, [hl]
	jr z, .obpals
	ld bc, wBGColorFadeConfigList
	ld de, wTargetBGPalettes
	ld hl, wBackgroundPalettesCGB
	ld a, (NUM_BACKGROUND_PALETTES palettes) / 2
.loop_1
	push af
	ld a, [bc]
	or a
	jr nz, .skip_1
	ld a, [hli]
	ld [de], a
	inc de
	ld a, [hld]
	ld [de], a
	dec de
.skip_1
	inc de
	inc de
	inc hl
	inc hl
	inc bc
	pop af
	dec a
	jr nz, .loop_1

.obpals
	ld hl, wPaletteFadeFlags
	bit 7, [hl]
	jr z, .done
	ld bc, wOBColorFadeConfigList
	ld de, wTargetOBPalettes
	ld hl, wObjectPalettesCGB
	ld a, (NUM_OBJECT_PALETTES palettes) / 2
.loop_2
	push af
	ld a, [bc]
	or a
	jr nz, .skip_2
	ld a, [hli]
	ld [de], a
	inc de
	ld a, [hld]
	ld [de], a
	dec de
.skip_2
	inc de
	inc de
	inc hl
	inc hl
	inc bc
	pop af
	dec a
	jr nz, .loop_2

.done
	pop hl
	pop de
	pop bc
	pop af
	ret

WaitPalFading_Bank07:
	push af
.loop_wait
	call DoFrame
	call CheckPalFading
	jr nz, .loop_wait
	pop af
	ret

StartFadeToWhite:
	push af
	push bc
	xor a
	ld b, $00
	call StartPalFadeToBlackOrWhite
	pop bc
	pop af
	ret

StartFadeFromWhite:
	call SaveTargetFadePals
	push af
	push bc
	xor a
	ld b, $00
	call StartPalFadeFromBlackOrWhite
	pop bc
	pop af
	ret
; 0x1ca09

SECTION "Bank 7@4a21", ROMX[$4a21], BANK[$7]

EnableBGPFading:
	push hl
	ld hl, wPaletteFadeFlags
	set 0, [hl]
	pop hl
	ret
; 0x1ca29

SECTION "Bank 7@4a31", ROMX[$4a31], BANK[$7]

EnableOBPFading:
	push hl
	ld hl, wPaletteFadeFlags
	set 7, [hl]
	pop hl
	ret

DisableOBPFading:
	push hl
	ld hl, wPaletteFadeFlags
	res 7, [hl]
	pop hl
	ret

SetPaletteFadeConfigToEnabled:
	push af
	push bc
	push de
	push hl
	add a
	add a
	ld c, a
	ld b, $00
	ld hl, wBGColorFadeConfigList
	add hl, bc
	xor a ; enable fading
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld [hl], a
	pop hl
	pop de
	pop bc
	pop af
	ret

SetBGPaletteFadeConfigToDisabled:
	push af
	push bc
	push de
	push hl
	add a
	add a
	ld c, a
	ld b, $00
	ld hl, wBGColorFadeConfigList
	add hl, bc
	ld a, $ff ; disable fading
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld [hl], a
	pop hl
	pop de
	pop bc
	pop af
	ret

SetOBPaletteFadeConfigToEnabled:
	push af
	push bc
	push de
	push hl
	add a
	add a
	ld c, a
	ld b, $00
	ld hl, wOBColorFadeConfigList
	add hl, bc
	xor a ; enable fading
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld [hl], a
	pop hl
	pop de
	pop bc
	pop af
	ret

SetOBPaletteFadeConfigToDisabled:
	push af
	push bc
	push de
	push hl
	add a
	add a
	ld c, a
	ld b, $00
	ld hl, wOBColorFadeConfigList
	add hl, bc
	ld a, $ff ; disable fading
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld [hl], a
	pop hl
	pop de
	pop bc
	pop af
	ret

SetAllBGPaletteFadeConfigsToEnabled:
	push af
	xor a
.loop_pals
	call SetPaletteFadeConfigToEnabled
	inc a
	cp NUM_BACKGROUND_PALETTES
	jr c, .loop_pals
	pop af
	ret

SetAllBGPaletteFadeConfigsToDisabled:
	push af
	xor a
.loop_pals
	call SetBGPaletteFadeConfigToDisabled
	inc a
	cp NUM_BACKGROUND_PALETTES
	jr c, .loop_pals
	pop af
	ret

SetAllOBPaletteFadeConfigsToEnabled:
	push af
	xor a
.loop_pals
	call SetOBPaletteFadeConfigToEnabled
	inc a
	cp NUM_OBJECT_PALETTES
	jr c, .loop_pals
	pop af
	ret
; 0x1cac3

SECTION "Bank 7@4acf", ROMX[$4acf], BANK[$7]

Func_1cacf:
	push af
	push bc
	push de
	ld a, [wMenuBoxX]
	ld d, a
	ld a, [wMenuBoxY]
	ld e, a
	ld a, [wMenuBoxWidth]
	ld b, a
	ld a, [wMenuBoxHeight]
	ld c, a
	farcall Func_10abf
	call DoFrame
	farcall Func_10342
	pop de
	pop bc
	pop af
	ret

Func_1caf1:
	push af
	push bc
	push de
	farcall Func_103b6
	farcall Func_10b18
	pop de
	pop bc
	pop af
	ret

; a = default cursor position
DrawMenuBox:
	push af
	push bc
	push de
	push hl
	push af
	ld a, [wMenuBoxX]
	ld d, a
	ld a, [wMenuBoxY]
	ld e, a
	ld a, [wMenuBoxWidth]
	ld b, a
	ld a, [wMenuBoxHeight]
	ld c, a
	ld a, [wMenuBoxSkipClear]
	and a
	jr nz, .skip_clear
	farcall FillBoxInBGMapWithZero
	jr .print_items
.skip_clear
	ld a, [wMenuBoxLabelTextID + 0]
	ld l, a
	ld a, [wMenuBoxLabelTextID + 1]
	ld h, a
	or l
	jr nz, .asm_1cb31
	call DrawRegularTextBoxVRAM0
	jr .print_items
.asm_1cb31
	call Func_38ad

.print_items
	ld a, [wMenuBoxNumItems]
	ld b, a
	ld c, 0
.loop_text_items
	push bc
	push de
	ld b, $00
	ld hl, wMenuBoxItemsXPositions
	add hl, bc
	ld d, [hl]
	ld hl, wMenuBoxItemsYPositions
	add hl, bc
	ld e, [hl]
	ld hl, wMenuBoxItemsTextIDs
	sla c
	rl b
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	call Func_35af
	pop de
	pop bc
	inc c
	ld a, c
	cp b
	jr nz, .loop_text_items
	pop af

	; place cursor in default position
	ld b, $00
	ld c, a
	ld hl, wMenuBoxItemsXPositions
	add hl, bc
	ld a, [hl]
	ld d, a
	ld hl, wMenuBoxItemsYPositions
	add hl, bc
	ld a, [hl]
	ld e, a
	ld b, d
	dec b
	ld c, e
	xor a
	call BankswitchVRAM
	ld a, [wMenuBoxCursorSymbol]
	call WriteByteToBGMap0
	pop hl
	pop de
	pop bc
	pop af
	ret

; handles player input inside a menu box
; that was initialized with LoadMenuBoxParams
; returns carry if a selection was made
; input:
; a = default cursor position
HandleMenuBox:
	push bc
	push de
	push hl
	ld c, a
	ld [wMenuBoxFocusedItem], a
	xor a
	ld [wMenuBoxBlinkCounter], a
	call .UnfocusItem
	ld a, [wMenuBoxDelay]
	and a
	jr z, .no_delay
.loop_delay
	call DoFrame
	dec a
	jr nz, .loop_delay

.no_delay
	call .InitAndUpdateBlinkCounter
.loop_main
	call DoFrame
	call UpdateRNGSources
	ld a, [wMenuBoxNumItems]
	ld h, a
	ld a, [wMenuBoxFocusedItem]
	ld c, a
	call .CallUpdateFunction
	ld a, [wda37]
	and a
	jr nz, .asm_1cbc3
	call .DownPress
	call .UpPress
	call .RightPress
	call .LeftPress
	ld a, c
	ld [wMenuBoxFocusedItem], a
.asm_1cbc3
	ld a, [wMenuBoxFocusedItem]
	ld c, a
	xor a
	ld [wda37], a
	call .CheckKeysPressed
	jr nz, .asm_1cbda
	call .CheckKeysHeld
	jr nz, .asm_1cbda
	call .UpdateBlinkCounter
	jr .loop_main
.asm_1cbda
	call .FocusItem
	ld a, c
	pop hl
	pop de
	pop bc
	ret

.UpPress:
	ldh a, [hDPadHeld]
	and D_UP
	ret z
	ld a, [wMenuBoxHasHorizontalScroll]
	ld l, a ; unused
	ld a, [wMenuBoxVerticalStep]
	and a
	ret z
	ld b, a
	ld a, c
	sub b
	jr nc, .no_overflow_1
	add h ; warp around
.no_overflow_1
	push af
	ld a, SFX_01
	call CallPlaySFX
	pop af
	call .UnfocusItem
	ld c, a
	ret

.DownPress:
	ldh a, [hDPadHeld]
	and D_DOWN
	ret z
	ld a, [wMenuBoxHasHorizontalScroll]
	ld l, a ; unused
	ld a, [wMenuBoxVerticalStep]
	and a
	ret z
	ld b, a
	ld a, c
	add b
	cp h
	jr c, .no_overflow_2
	sub h ; warp around
.no_overflow_2
	push af
	ld a, SFX_01
	call CallPlaySFX
	pop af
	call .UnfocusItem
	ld c, a
	ret

.LeftPress:
	ldh a, [hDPadHeld]
	and D_LEFT
	ret z
	ld a, [wMenuBoxHasHorizontalScroll]
	and a
	ret z
	ld b, a
	ld a, c
	sub b
	jr nc, .no_overflow_3
	add h
.no_overflow_3
	push af
	ld a, SFX_01
	call CallPlaySFX
	pop af
	call .UnfocusItem
	ld c, a
	ret

.RightPress:
	ldh a, [hDPadHeld]
	and D_RIGHT
	ret z
	ld a, [wMenuBoxHasHorizontalScroll]
	and a
	ret z
	ld b, a
	ld a, c
	add b
	cp h
	jr c, .no_overflow_4
	sub h
.no_overflow_4
	push af
	ld a, SFX_01
	call CallPlaySFX
	pop af
	call .UnfocusItem
	ld c, a
	ret

; returns carry if any of the keys
; in wMenuBoxPressKeys are pressed
.CheckKeysPressed:
	ld a, [wMenuBoxPressKeys]
	ld b, a
	ldh a, [hKeysPressed]
	and b
	ret z
	scf
	ccf
	ret

; returns carry if any of the keys
; in wMenuBoxHeldKeys are held
.CheckKeysHeld:
	ld a, [wMenuBoxHeldKeys]
	ld b, a
	ldh a, [hDPadHeld]
	and b
	ret z
	scf
	ret

.InitAndUpdateBlinkCounter:
	xor a
	ld [wMenuBoxBlinkCounter], a
; fallthrough

.UpdateBlinkCounter:
	push bc
	push hl
	ld b, $00
	ld hl, wMenuBoxItemsXPositions
	add hl, bc
	ld a, [hl]
	ld d, a
	ld hl, wMenuBoxItemsYPositions
	add hl, bc
	ld a, [hl]
	ld e, a
	ld b, d
	dec b
	ld c, e
	ld a, [wMenuBoxBlinkCounter]
	and $10
	ld a, [wMenuBoxBlinkSymbol]
	jr z, .blink
	ld a, [wMenuBoxSpaceSymbol]
.blink
	push af
	xor a
	call BankswitchVRAM
	pop af
	call WriteByteToBGMap0
	ld a, $01
	call BankswitchVRAM
	ld a, $80 ; priority
	call WriteByteToBGMap0
	xor a
	call BankswitchVRAM
	; increment counter
	ld hl, wMenuBoxBlinkCounter
	inc [hl]
	pop hl
	pop bc
	ret

; c = cursor position
.UnfocusItem:
	push af
	push bc
	push hl
	ld b, $00
	ld hl, wMenuBoxItemsXPositions
	add hl, bc
	ld a, [hl]
	ld d, a
	ld hl, wMenuBoxItemsYPositions
	add hl, bc
	ld a, [hl]
	ld e, a
	ld b, d
	dec b
	ld c, e
	ld a, [wMenuBoxSpaceSymbol]
	call WriteByteToBGMap0
	xor a
	ld [wMenuBoxBlinkCounter], a
	pop hl
	pop bc
	pop af
	ret

; c = cursor position
; carry = doing selection
.FocusItem:
	push af
	push bc
	push hl
	ld a, [wMenuBoxCursorSymbol]
	jr nc, .not_selection
	ld a, [wMenuBoxSelectionSymbol]
.not_selection
	push af
	ld b, $00
	ld hl, wMenuBoxItemsXPositions
	add hl, bc
	ld a, [hl]
	ld d, a
	ld hl, wMenuBoxItemsYPositions
	add hl, bc
	ld a, [hl]
	ld e, a
	ld b, d
	dec b
	ld c, e
	pop af
	call WriteByteToBGMap0
	pop hl
	pop bc
	pop af
	ret

.CallUpdateFunction:
	push af
	push bc
	push de
	push hl
	ld a, [wMenuBoxUpdateFunction + 0]
	ld l, a
	ld a, [wMenuBoxUpdateFunction + 1]
	ld h, a
	or l
	jr z, .done
; call hl
	ld de, .done
	push de
	jp hl
.done
	pop hl
	pop de
	pop bc
	pop af
	ret

GetMenuBoxFocusedItem:
	ld a, [wMenuBoxFocusedItem]
	ret
; 0x1cd17

SECTION "Bank 7@4d6f", ROMX[$4d6f], BANK[$7]

; outputs in a what option the player chose
ShowStartMenu:
	push bc
	push de
	push hl
	ld [wStartMenuConfiguration], a
	push af
	ld a, MUSIC_PCMAINMENU
	call SetMusic
	pop af
	call .HandleMenu
	ld a, [wMenuCursorPosition]
	pop hl
	pop de
	pop bc
	ret

.HandleMenu:
	farcall ClearSpriteAnimsAndSetInitialGraphicsConfiguration
	ld de, $4090
	call SetupText
	call .DrawMenu
	farcall SetFrameFuncAndFadeFromWhite
	farcall SetFadePalsFrameFunc
	call HandleStartMenuBox
	farcall UnsetFadePalsFrameFunc
	farcall FadeToWhiteAndUnsetFrameFunc
	ret

.DrawMenu:
	ld a, [wStartMenuConfiguration]
	and a
	jr z, .skip_portrait_and_name

; draw player portrait
	call Func_1c0ec
	add 0
	lb bc, 13, 1
	ld e, EMOTION_NORMAL
	call DrawNPCPortrait

; print player's name
	farcall LoadPlayerName
	ld b, a
	ld a, MAX_PLAYER_NAME_CHARS
	sub b
	ld d, 13
	add d
	ld d, a
	ld e, 8
	ldtx hl, Text05be
	call Func_35bf

.skip_portrait_and_name
	ld a, [wStartMenuConfiguration]
	add a
	ld c, a
	ld b, $00
	ld hl, .MenuBoxParamPointers
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld b, BANK(.MenuBoxParamPointers)
	lb de, 0, 0
	call LoadMenuBoxParams
	ld a, [wStartMenuConfiguration]
	ld c, a
	ld b, $00
	ld hl, .DefaultCursorPositions
	add hl, bc
	ld a, [hl]
	ld [wMenuCursorPosition], a
	call DrawMenuBox
	lb de, 0, 10
	lb bc, 20, 8
	call DrawRegularTextBoxVRAM0
	ret

.DefaultCursorPositions
	db 0 ; STARTMENU_CONFIG_0
	db 0 ; STARTMENU_CONFIG_1
	db 1 ; STARTMENU_CONFIG_2
	db 1 ; STARTMENU_CONFIG_3
	db 0 ; STARTMENU_CONFIG_4

.MenuBoxParamPointers:
	dw .Config0Params ; STARTMENU_CONFIG_0
	dw .Config1Params ; STARTMENU_CONFIG_1
	dw .Config2Params ; STARTMENU_CONFIG_2
	dw .Config3Params ; STARTMENU_CONFIG_3
	dw .Config4Params ; STARTMENU_CONFIG_4

.Config0Params
	db TRUE ; ?
	db 12, 4 ; width, height
	db SYM_CURSOR_R ; blink cursor symbol
	db SYM_SPACE ; space symbol
	db SYM_CURSOR_R ; default cursor symbol
	db SYM_CURSOR_R ; selection cursor symbol
	db A_BUTTON ; press keys
	db $00 ; held keys
	db FALSE ; has horizontal scroll
	db 0 ; vertical step
	dw StartMenuBoxUpdate ; update function
	dw NULL ; label text ID

	textitem 2, 2, Text05ce
	db $ff ; end

.Config1Params
	db TRUE ; ?
	db 12, 6 ; width, height
	db SYM_CURSOR_R ; blink cursor symbol
	db SYM_SPACE ; space symbol
	db SYM_CURSOR_R ; default cursor symbol
	db SYM_CURSOR_R ; selection cursor symbol
	db A_BUTTON ; press keys
	db $00 ; held keys
	db FALSE ; has horizontal scroll
	db 1 ; vertical step
	dw StartMenuBoxUpdate ; update function
	dw NULL ; label text ID

	textitem 2, 2, Text05cf
	textitem 2, 4, Text05ce
	db $ff ; end

.Config2Params
	db TRUE ; ?
	db 12, 8 ; width, height
	db SYM_CURSOR_R ; blink cursor symbol
	db SYM_SPACE ; space symbol
	db SYM_CURSOR_R ; default cursor symbol
	db SYM_CURSOR_R ; selection cursor symbol
	db A_BUTTON ; press keys
	db $00 ; held keys
	db FALSE ; has horizontal scroll
	db 1 ; vertical step
	dw StartMenuBoxUpdate ; update function
	dw NULL ; label text ID

	textitem 2, 2, Text05d0
	textitem 2, 4, Text05cf
	textitem 2, 6, Text05ce
	db $ff ; end

.Config3Params
	db TRUE ; ?
	db 12, 10 ; width, height
	db SYM_CURSOR_R ; blink cursor symbol
	db SYM_SPACE ; space symbol
	db SYM_CURSOR_R ; default cursor symbol
	db SYM_CURSOR_R ; selection cursor symbol
	db A_BUTTON ; press keys
	db $00 ; held keys
	db FALSE ; has horizontal scroll
	db 1 ; vertical step
	dw StartMenuBoxUpdate ; update function
	dw NULL ; label text ID

	textitem 2, 2, Text05d0
	textitem 2, 4, Text05cf
	textitem 2, 6, Text05ce
	textitem 2, 8, Text05d1
	db $ff ; end

.Config4Params
	db TRUE ; ?
	db 12, 8 ; width, height
	db SYM_CURSOR_R ; blink cursor symbol
	db SYM_SPACE ; space symbol
	db SYM_CURSOR_R ; default cursor symbol
	db SYM_CURSOR_R ; selection cursor symbol
	db A_BUTTON ; press keys
	db $00 ; held keys
	db FALSE ; has horizontal scroll
	db 1 ; vertical step
	dw StartMenuBoxUpdate ; update function
	dw NULL ; label text ID

	textitem 2, 2, Text05cf
	textitem 2, 4, Text05ce
	textitem 2, 6, Text05d1
	db $ff ; end

_StartMenuBoxUpdate::
	push af
	push bc
	push de
	push hl
	call GetMenuBoxFocusedItem
	ld b, a
	ld a, [wMenuBoxLastFocusedItem]
	cp b
	jr z, .done
	call .DrawTextBox
	sla b
	ld a, [wStartMenuConfiguration]
	sla a
	sla a
	sla a ; *8
	add b
	ld c, a
	ld b, $00
	ld hl, .PointerTables
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
; call hl
	ld de, .done
	push de
	jp hl
.done
	call GetMenuBoxFocusedItem
	ld [wMenuBoxLastFocusedItem], a
	pop hl
	pop de
	pop bc
	pop af
	ret

.PointerTables:
; STARTMENU_CONFIG_0
	dw .NewGame
	dw NULL
	dw NULL
	dw NULL

; STARTMENU_CONFIG_1
	dw .ContinueFromDiary
	dw .NewGame
	dw NULL
	dw NULL

; STARTMENU_CONFIG_2
	dw .CardPop
	dw .ContinueFromDiary
	dw .NewGame
	dw NULL

; STARTMENU_CONFIG_3
	dw .CardPop
	dw .ContinueFromDiary
	dw .NewGame
	dw .ContinueDuel

; STARTMENU_CONFIG_4
	dw .ContinueFromDiary
	dw .NewGame
	dw .ContinueDuel
	dw NULL

.DrawTextBox:
	push bc
	lb de, 0, 10
	lb bc, 20, 8
	call DrawRegularTextBoxVRAM0
	pop bc
	ret

.NewGame:
	lb de, 1, 12
	ldtx hl, Text05d2
	call Func_35af
	ret

.ContinueFromDiary:
	farcall Func_c53e
	call LoadTxRam2
	ldtx hl, Text077b
	lb de, 1, 10
	call Func_2c4b
	ld hl, .TextItems
	call Func_35cf

	; print number of event coins
	; obtained by the player
	call CountEventCoinsObtained
	ld l, a
	ld h, $00
	lb de, 13, 12
	ld a, 2
	ld b, TRUE
	call PrintNumber

	lb de, 10, 16
	farcall PrintPlayTime
	lb de, 9, 14
	farcall PrintCardAlbumProgress
	ret

.TextItems:
	textitem  3, 12, Text05af
	textitem 15, 12, Text05ca
	textitem  3, 14, Text05b0
	textitem  3, 16, Text05b1
	db $ff

.CardPop:
	lb de, 1, 12
	ldtx hl, Text05d3
	call Func_35af
	ret

.ContinueDuel:
	lb de, 1, 12
	ldtx hl, Text05d4
	call Func_35af
	ret

HandleStartMenuBox:
	ld a, -1
	ld [wMenuBoxLastFocusedItem], a
	ld a, [wMenuCursorPosition]
	call HandleMenuBox
	ld [wMenuCursorPosition], a
	jr c, .selected
	push af
	ld a, SFX_02
	call CallPlaySFX
	pop af
	ret
.selected
	push af
	ld a, SFX_03
	call CallPlaySFX
	pop af
	ret

; return carry if "no" selected
AskToOverwriteSaveData:
	push bc
	push de
	push hl
	farcall SetFadePalsFrameFunc
	farcall ZeroObjectPositionsAndEnableOBPFading
	farcall SetInitialGraphicsConfiguration
	lb de,  0, 12
	lb bc, 20,  6
	call DrawRegularTextBoxVRAM0
	call StartFadeFromWhite
	call WaitPalFading_Bank07
	ld hl, .TextIDs
	call PrintScrollableTextFromList
	ldtx hl, Text0760
	ld a, $1 ; "no" selected by default
	farcall DrawWideTextBox_PrintTextWithYesOrNoMenu
	jr c, .fade_out
	farcall Func_e97a
	ldtx hl, Text0761
	farcall PrintScrollableText_NoTextBoxLabelVRAM0
.fade_out
	call StartFadeToWhite
	call WaitPalFading_Bank07
	farcall UnsetFadePalsFrameFunc
	pop hl
	pop de
	pop bc
	ret

.TextIDs:
	tx Text075e
	tx Text075f
	dw $ffff

; return carry if "no" selected
AskToContinueFromDiaryInsteadOfDuel:
	push bc
	push de
	push hl
	farcall SetFadePalsFrameFunc
	farcall ZeroObjectPositionsAndEnableOBPFading
	farcall SetInitialGraphicsConfiguration
	lb de,  0, 12
	lb bc, 20,  6
	call DrawRegularTextBoxVRAM0
	call StartFadeFromWhite
	call WaitPalFading_Bank07
	ld hl, .TextIDs
	call PrintScrollableTextFromList
	ldtx hl, Text078c
	ld a, $1 ; "no" selected by default
	farcall DrawWideTextBox_PrintTextWithYesOrNoMenu
	jr c, .fade_out ; unnecessary jump
.fade_out
	call StartFadeToWhite
	call WaitPalFading_Bank07
	farcall UnsetFadePalsFrameFunc
	pop hl
	pop de
	pop bc
	ret

.TextIDs:
	tx Text0788
	tx Text0789
	tx Text078a
	tx Text078b
	tx $ffff

ConfirmPlayerNameAndGender:
	push bc
	push de
	push hl
	call .ShowInfoAndAskPlayer
	pop hl
	pop de
	pop bc
	ret

.ShowInfoAndAskPlayer:
	farcall ClearSpriteAnimsAndSetInitialGraphicsConfiguration
	call .ShowPlayerInfo
	farcall SetFrameFuncAndFadeFromWhite
	call .ShowYesOrNoMenu
	farcall FadeToWhiteAndUnsetFrameFunc
	ret

.ShowPlayerInfo:
	lb de, 0, 0
	lb bc, 20, 12
	call DrawRegularTextBoxVRAM0
	lb de, 0, 12
	lb bc, 20, 6
	call DrawRegularTextBoxVRAM0
	ld hl, .TextItems
	call Func_35cf
	lb bc, 12, 3
	call DrawPlayerPortrait
	; print name
	ldtx hl, Text05be
	lb de, 5, 4
	call Func_35bf
	; print gender
	farcall GetPlayerGender
	and a
	ldtx hl, Text05d5
	jr z, .got_gender_text
	ldtx hl, Text05d6
.got_gender_text
	lb de, 5, 8
	call Func_35af
	ret

.TextItems:
	textitem 2, 2, Text05ad
	textitem 2, 6, Text05de
	db $ff

.ShowYesOrNoMenu:
	ldtx hl, Text05dd
	ld a, $1
	farcall DrawWideTextBox_PrintTextWithYesOrNoMenu
	ret
; 0x1d081

SECTION "Bank 7@5081", ROMX[$5081], BANK[$7]

; a = COIN_* constant
CheckIfCoinWasObtained:
	push bc
	push hl
	ld c, a
	ld b, $00
	ld hl, .CoinEventIDs
	add hl, bc
	ld a, [hl]
	farcall GetEventValue
	pop hl
	pop bc
	ret

.CoinEventIDs
	db EVENT_GOT_CHANSEY_COIN    ; COIN_CHANSEY
	db EVENT_GOT_GR_COIN         ; COIN_GR
	db EVENT_GOT_ODDISH_COIN     ; COIN_ODDISH
	db EVENT_GOT_CHARMANDER_COIN ; COIN_CHARMANDER
	db EVENT_GOT_STARMIE_COIN    ; COIN_STARMIE
	db EVENT_GOT_PIKACHU_COIN    ; COIN_PIKACHU
	db EVENT_GOT_ALAKAZAM_COIN   ; COIN_ALAKAZAM
	db EVENT_GOT_KABUTO_COIN     ; COIN_KABUTO
	db EVENT_GOT_MAGNEMITE_COIN  ; COIN_MAGNEMITE
	db EVENT_GOT_GOLBAT_COIN     ; COIN_GOLBAT
	db EVENT_GOT_MAGMAR_COIN     ; COIN_MAGMAR
	db EVENT_GOT_PSYDUCK_COIN    ; COIN_PSYDUCK
	db EVENT_GOT_MACHAMP_COIN    ; COIN_MACHAMP
	db EVENT_GOT_MEW_COIN        ; COIN_MEW
	db EVENT_GOT_SNORLAX_COIN    ; COIN_SNORLAX
	db EVENT_GOT_TOGEPI_COIN     ; COIN_TOGEPI
	db EVENT_GOT_PONYTA_COIN     ; COIN_PONYTA
	db EVENT_GOT_HORSEA_COIN     ; COIN_HORSEA
	db EVENT_GOT_ARBOK_COIN      ; COIN_ARBOK
	db EVENT_GOT_JIGGLYPUFF_COIN ; COIN_JIGGLYPUFF
	db EVENT_GOT_DUGTRIO_COIN    ; COIN_DUGTRIO
	db EVENT_GOT_GENGAR_COIN     ; COIN_GENGAR
	db EVENT_GOT_RAICHU_COIN     ; COIN_RAICHU
	db EVENT_GOT_LUGIA_COIN      ; COIN_LUGIA

; outputs in a the number of event coins
; that has been obtained by the player
CountEventCoinsObtained:
	push bc
	push hl
	ld c, NUM_COINS
	ld b, 0
	xor a ; COIN_CHANSEY
.loop
	push af
	call CheckIfCoinWasObtained
	jr z, .next
	inc b
.next
	pop af
	inc a
	dec c
	jr nz, .loop
	ld a, b
	and a
	pop hl
	pop bc
	ret
; 0x1d0c2

SECTION "Bank 7@5198", ROMX[$5198], BANK[$7]

; input:
; - a = coin to load
; - de = coordinates
Func_1d198:
	push af
	push bc
	push de
	push hl
	ld c, a
	ld b, $00
	sla c
	rl b
	sla c
	rl b
	sla c
	rl b ; *8
	ld hl, .SpriteAnimGfxParams
	add hl, bc
	ld c, $00
	cp $28
	jr c, .asm_1d1b7
	ld c, $02
.asm_1d1b7
	ld b, $07
	ld a, $ff
	call CreateSpriteAnim
	pop hl
	pop de
	pop bc
	pop af
	ret

.SpriteAnimGfxParams:
	dw TILESET_CHANSEY_COIN,    SPRITE_ANIM_85, FRAMESET_112, PALETTE_13C ; $00
	dw TILESET_GR_COIN,         SPRITE_ANIM_85, FRAMESET_112, PALETTE_143 ; $01
	dw TILESET_ODDISH_COIN,     SPRITE_ANIM_85, FRAMESET_112, PALETTE_13D ; $02
	dw TILESET_CHARMANDER_COIN, SPRITE_ANIM_85, FRAMESET_112, PALETTE_13E ; $03
	dw TILESET_STARMIE_COIN,    SPRITE_ANIM_85, FRAMESET_112, PALETTE_13F ; $04
	dw TILESET_PIKACHU_COIN,    SPRITE_ANIM_85, FRAMESET_112, PALETTE_140 ; $05
	dw TILESET_ALAKAZAM_COIN,   SPRITE_ANIM_85, FRAMESET_112, PALETTE_141 ; $06
	dw TILESET_KABUTO_COIN,     SPRITE_ANIM_85, FRAMESET_112, PALETTE_142 ; $07
	dw TILESET_GOLBAT_COIN,     SPRITE_ANIM_85, FRAMESET_112, PALETTE_144 ; $08
	dw TILESET_MAGNEMITE_COIN,  SPRITE_ANIM_85, FRAMESET_112, PALETTE_145 ; $09
	dw TILESET_MAGMAR_COIN,     SPRITE_ANIM_85, FRAMESET_112, PALETTE_146 ; $0a
	dw TILESET_PSYDUCK_COIN,    SPRITE_ANIM_85, FRAMESET_112, PALETTE_147 ; $0b
	dw TILESET_MACHAMP_COIN,    SPRITE_ANIM_85, FRAMESET_112, PALETTE_148 ; $0c
	dw TILESET_MEW_COIN,        SPRITE_ANIM_85, FRAMESET_112, PALETTE_149 ; $0d
	dw TILESET_SNORLAX_COIN,    SPRITE_ANIM_85, FRAMESET_112, PALETTE_14A ; $0e
	dw TILESET_TOGEPI_COIN,     SPRITE_ANIM_85, FRAMESET_112, PALETTE_14B ; $0f
	dw TILESET_PONYTA_COIN,     SPRITE_ANIM_85, FRAMESET_112, PALETTE_14C ; $10
	dw TILESET_HORSEA_COIN,     SPRITE_ANIM_85, FRAMESET_112, PALETTE_14D ; $11
	dw TILESET_ARBOK_COIN,      SPRITE_ANIM_85, FRAMESET_112, PALETTE_14E ; $12
	dw TILESET_JIGGLYPUFF_COIN, SPRITE_ANIM_85, FRAMESET_112, PALETTE_14F ; $13
	dw TILESET_DUGTRIO_COIN,    SPRITE_ANIM_85, FRAMESET_112, PALETTE_150 ; $14
	dw TILESET_GENGAR_COIN,     SPRITE_ANIM_85, FRAMESET_112, PALETTE_151 ; $15
	dw TILESET_RAICHU_COIN,     SPRITE_ANIM_85, FRAMESET_112, PALETTE_152 ; $16
	dw TILESET_LUGIA_COIN,      SPRITE_ANIM_85, FRAMESET_112, PALETTE_153 ; $17
	dw TILESET_GR_COIN,         SPRITE_ANIM_85, FRAMESET_112, PALETTE_13C ; $18
	dw TILESET_GR_PIECES,       SPRITE_ANIM_AC, FRAMESET_118, PALETTE_143 ; $19
	dw TILESET_GR_PIECES,       SPRITE_ANIM_AC, FRAMESET_119, PALETTE_143 ; $1a
	dw TILESET_GR_COIN,         SPRITE_ANIM_85, FRAMESET_112, PALETTE_13C ; $1b
	dw TILESET_GR_PIECES,       SPRITE_ANIM_AC, FRAMESET_11A, PALETTE_143 ; $1c
	dw TILESET_GR_COIN,         SPRITE_ANIM_85, FRAMESET_112, PALETTE_13C ; $1d
	dw TILESET_GR_COIN,         SPRITE_ANIM_85, FRAMESET_112, PALETTE_13C ; $1e
	dw TILESET_GR_COIN,         SPRITE_ANIM_85, FRAMESET_112, PALETTE_13C ; $1f
	dw TILESET_GR_PIECES,       SPRITE_ANIM_AC, FRAMESET_11B, PALETTE_143 ; $20
	dw TILESET_GR_COIN,         SPRITE_ANIM_85, FRAMESET_112, PALETTE_13C ; $21
	dw TILESET_GR_COIN,         SPRITE_ANIM_85, FRAMESET_112, PALETTE_13C ; $22
	dw TILESET_GR_COIN,         SPRITE_ANIM_85, FRAMESET_112, PALETTE_13C ; $23
	dw TILESET_GR_COIN,         SPRITE_ANIM_85, FRAMESET_112, PALETTE_13C ; $24
	dw TILESET_GR_COIN,         SPRITE_ANIM_85, FRAMESET_112, PALETTE_13C ; $25
	dw TILESET_GR_COIN,         SPRITE_ANIM_85, FRAMESET_112, PALETTE_13C ; $26
	dw TILESET_GR_COIN,         SPRITE_ANIM_85, FRAMESET_112, PALETTE_13C ; $27
	dw TILESET_SMALL_COINS,     SPRITE_ANIM_AD, FRAMESET_120, PALETTE_13B ; $28
	dw TILESET_SMALL_COINS,     SPRITE_ANIM_AD, FRAMESET_146, PALETTE_13B ; $29
	dw TILESET_SMALL_COINS,     SPRITE_ANIM_AD, FRAMESET_121, PALETTE_13B ; $2a
	dw TILESET_SMALL_COINS,     SPRITE_ANIM_AD, FRAMESET_122, PALETTE_13B ; $2b
	dw TILESET_SMALL_COINS,     SPRITE_ANIM_AD, FRAMESET_123, PALETTE_13B ; $2c
	dw TILESET_SMALL_COINS,     SPRITE_ANIM_AD, FRAMESET_124, PALETTE_13B ; $2d
	dw TILESET_SMALL_COINS,     SPRITE_ANIM_AD, FRAMESET_125, PALETTE_13B ; $2e
	dw TILESET_SMALL_COINS,     SPRITE_ANIM_AD, FRAMESET_126, PALETTE_13B ; $2f
	dw TILESET_SMALL_COINS,     SPRITE_ANIM_AD, FRAMESET_127, PALETTE_13B ; $30
	dw TILESET_SMALL_COINS,     SPRITE_ANIM_AD, FRAMESET_128, PALETTE_13B ; $31
	dw TILESET_SMALL_COINS,     SPRITE_ANIM_AD, FRAMESET_129, PALETTE_13B ; $32
	dw TILESET_SMALL_COINS,     SPRITE_ANIM_AD, FRAMESET_12A, PALETTE_13B ; $33
	dw TILESET_SMALL_COINS,     SPRITE_ANIM_AD, FRAMESET_12B, PALETTE_13B ; $34
	dw TILESET_SMALL_COINS,     SPRITE_ANIM_AD, FRAMESET_12C, PALETTE_13B ; $35
	dw TILESET_SMALL_COINS,     SPRITE_ANIM_AD, FRAMESET_12D, PALETTE_13B ; $36
	dw TILESET_SMALL_COINS,     SPRITE_ANIM_AD, FRAMESET_12E, PALETTE_13B ; $37
	dw TILESET_SMALL_COINS,     SPRITE_ANIM_AD, FRAMESET_12F, PALETTE_13B ; $38
	dw TILESET_SMALL_COINS,     SPRITE_ANIM_AD, FRAMESET_130, PALETTE_13B ; $39
	dw TILESET_SMALL_COINS,     SPRITE_ANIM_AD, FRAMESET_131, PALETTE_13B ; $3a
	dw TILESET_SMALL_COINS,     SPRITE_ANIM_AD, FRAMESET_132, PALETTE_13B ; $3b
	dw TILESET_SMALL_COINS,     SPRITE_ANIM_AD, FRAMESET_133, PALETTE_13B ; $3c
	dw TILESET_SMALL_COINS,     SPRITE_ANIM_AD, FRAMESET_134, PALETTE_13B ; $3d
	dw TILESET_SMALL_COINS,     SPRITE_ANIM_AD, FRAMESET_135, PALETTE_13B ; $3e
	dw TILESET_SMALL_COINS,     SPRITE_ANIM_AD, FRAMESET_136, PALETTE_13B ; $3f
	dw TILESET_SMALL_COINS,     SPRITE_ANIM_AD, FRAMESET_137, PALETTE_13B ; $40
	dw TILESET_SMALL_COINS,     SPRITE_ANIM_AD, FRAMESET_138, PALETTE_13B ; $41
	dw TILESET_SMALL_COINS,     SPRITE_ANIM_AD, FRAMESET_139, PALETTE_13B ; $42
	dw TILESET_SMALL_COINS,     SPRITE_ANIM_AD, FRAMESET_13A, PALETTE_13B ; $43
	dw TILESET_SMALL_COINS,     SPRITE_ANIM_AD, FRAMESET_13B, PALETTE_13B ; $44
	dw TILESET_SMALL_COINS,     SPRITE_ANIM_AD, FRAMESET_13C, PALETTE_13B ; $45
	dw TILESET_SMALL_COINS,     SPRITE_ANIM_AD, FRAMESET_13D, PALETTE_13B ; $46
	dw TILESET_SMALL_COINS,     SPRITE_ANIM_AD, FRAMESET_13E, PALETTE_13B ; $47
	dw TILESET_SMALL_COINS,     SPRITE_ANIM_AD, FRAMESET_13F, PALETTE_13B ; $48
	dw TILESET_SMALL_COINS,     SPRITE_ANIM_AD, FRAMESET_140, PALETTE_13B ; $49
	dw TILESET_SMALL_COINS,     SPRITE_ANIM_AD, FRAMESET_141, PALETTE_13B ; $4a
	dw TILESET_SMALL_COINS,     SPRITE_ANIM_AD, FRAMESET_142, PALETTE_13B ; $4b
	dw TILESET_SMALL_COINS,     SPRITE_ANIM_AD, FRAMESET_143, PALETTE_13B ; $4c
	dw TILESET_SMALL_COINS,     SPRITE_ANIM_AD, FRAMESET_144, PALETTE_13B ; $4d
	dw TILESET_SMALL_COINS,     SPRITE_ANIM_AD, FRAMESET_145, PALETTE_13B ; $4e
	dw TILESET_SMALL_COINS,     SPRITE_ANIM_AD, FRAMESET_146, PALETTE_13B ; $4f

Func_1d443:
	push af
	push bc
	push de
	push hl
	ld c, a
	ld b, $00
	ld hl, FRAMESET_112
	add hl, bc
	ld b, h
	ld c, l
	farcall Func_10bc4
	farcall SetAndInitSpriteAnimFrameset
	xor a
	farcall SetSpriteAnimFrameIndex
	farcall SetSpriteAnimFrameDuration
	farcall SetSpriteAnimAnimating
	pop hl
	pop de
	pop bc
	pop af
	ret
; 0x1d46a

SECTION "Bank 7@5475", ROMX[$5475], BANK[$7]

; a = $0: initializes values for new save
; a = $1: reads values from SRAM
Func_1d475:
	ld hl, .FunctionMap
	call CallMappedFunction
	ret

.FunctionMap
	key_func $0, .Initialize
	key_func $1, .Read
	db $ff ; end

.Initialize:
	ld a, PLAYER_MALE
	farcall SetPlayerGender

	; give Chansey coin
	ld a, EVENT_GOT_CHANSEY_COIN
	farcall MaxOutEventValue

	farcall Func_1157c
	call Func_1eca5
	call Func_1d7a1
	call Func_1d9f9
	call Func_1dcb7

	; this is unnecessary since Card Pop list
	; was already cleared in InitSaveData
	farcall ClearCardPopNameList

	call EnableAnimations
	call Func_1e767
	farcall Func_111f0
	call Func_1c425
	call Func_1c3d5
	call LoadSavedOptions
	ret

.Read:
	call LoadSavedOptions
	ld a, $01
	farcall Func_108c9
	ret

ShowOWMapLocationBox:
	push af
	push bc
	push de
	push hl
	ldh a, [hWX]
	ld [wBackupWX], a
	ldh a, [hWY]
	ld [wBackupWY], a
	ld a, $40
	ldh [hWX], a
	ld a, $78
	ldh [hWY], a
	ld bc, TILEMAP_004
	lb de, 0, 16
	farcall Func_12c0ce
	lb de,  1, 33
	lb bc, 11,  1
	farcall FillBoxInBGMapWithZero
	lb de,  0, 32
	lb bc, 13,  3
	farcall Func_10742
	call .LoadPal
	call SetWindowOn
	pop hl
	pop de
	pop bc
	pop af
	ret

.LoadPal:
	ld b, BANK(Pals_1d50d)
	ld c, $00
	ld hl, Pals_1d50d
	call Func_3861
	ret

Pals_1d50d:
	db 2 ; number of palettes

	rgb 31, 31, 31
	rgb 31, 31, 31
	rgb  8,  8,  8
	rgb  0,  0,  0

	rgb 31, 31, 31
	rgb 31, 31, 31
	rgb 31,  0,  0
	rgb  1,  0,  5
; 0x1d51d

SECTION "Bank 7@551e", ROMX[$551e], BANK[$7]

Func_1d51e:
	push af
	ld a, [wBackupWX]
	ldh [hWX], a
	ld a, [wBackupWY]
	ldh [hWY], a
	call SetWindowOff
	pop af
	ret
; 0x1d52e

SECTION "Bank 7@57a1", ROMX[$57a1], BANK[$7]

Func_1d7a1:
	xor a
	ld [wdb1f], a
	ret
; 0x1d7a6

SECTION "Bank 7@59f9", ROMX[$59f9], BANK[$7]

Func_1d9f9:
	ld a, $04
	ld [wdc06], a
	ret
; 0x1d9ff

SECTION "Bank 7@5cb7", ROMX[$5cb7], BANK[$7]

Func_1dcb7:
	xor a
	ld [wdc08], a
	ld [wdc09], a
	ret
; 0x1dcbf

SECTION "Bank 7@5fb9", ROMX[$5fb9], BANK[$7]

Func_1dfb9::
	push af
	push bc
	push de
	push hl
	ld a, $01 ; unused
	farcall ClearSpriteAnims
	xor a
	farcall Func_108c9
	xor a
	ld [wDuelAnimBufferSize], a
	ld [wDuelAnimBufferCurPos], a
	ld [wCurAnimation], a
	ld [wNumActiveAnimations], a
	ld [wDuelAnimSetScreen], a
	ld [wDuelAnimLocationParam], a
	ld [wdcf0], a
	ld [wdc57], a
	ld a, $ff
	ld [wActiveScreenAnim], a

	; clear wDuelAnimBuffer
	xor a
	ld bc, wDuelAnimBufferEnd - wDuelAnimBuffer
	ld hl, wDuelAnimBuffer
	call WriteBCBytesToHL

	pop hl
	pop de
	pop bc
	pop af
	ret

; appends to end of wDuelAnimBuffer
; the current duel animation
_LoadDuelAnimationToBuffer::
	push af
	push bc
	push de
	push hl
	ld a, [wDuelAnimBufferSize]
	ld b, a
	ld a, [wDuelAnimBufferCurPos]
	ld c, a
	inc a
	and %00001111
	ld e, a
	cp b
	jr z, .skip
	ld a, e
	ld [wDuelAnimBufferCurPos], a

	ld b, $00
	sla c
	sla c
	sla c ; *8
	ld hl, wDuelAnimBuffer
	add hl, bc
	ld a, [wCurAnimation]
	ld [hli], a
	ld a, [wDuelAnimationScreen]
	ld [hli], a
	ld a, [wDuelAnimDuelistSide]
	ld [hli], a
	ld a, [wDuelAnimLocationParam]
	ld [hli], a
	ld a, [wDuelAnimDamage + 0]
	ld [hli], a
	ld a, [wDuelAnimDamage + 1]
	ld [hli], a
	ld a, [wDuelAnimEffectiveness]
	ld [hli], a
	ld a, [wDuelAnimReturnBank]
	ld [hl], a

.skip
	pop hl
	pop de
	pop bc
	pop af
	ret

; loads the animations from wDuelAnimBuffer
; corresponding to entry in wDuelAnimBufferCurPos
LoadBufferedDuelAnimation:
	push af
	push bc
	push de
	push hl

	; assume no animation
	xor a
	ld [wCurAnimation], a

	ld a, [wDuelAnimBufferCurPos]
	ld b, a
	ld a, [wDuelAnimBufferSize]
	ld c, a
	cp b
	jr z, .skip
	ld a, c
	inc a
	and $f
	ld [wDuelAnimBufferSize], a

	ld b, $00
	sla c
	sla c
	sla c ; *8
	ld hl, wDuelAnimBuffer
	add hl, bc
	ld a, [hli]
	ld [wCurAnimation], a
	ld a, [hli]
	ld [wDuelAnimationScreen], a
	ld a, [hli]
	ld [wDuelAnimDuelistSide], a
	ld a, [hli]
	ld [wDuelAnimLocationParam], a
	ld a, [hli]
	ld [wDuelAnimDamage + 0], a
	ld a, [hli]
	ld [wDuelAnimDamage + 1], a
	ld a, [hli]
	ld [wDuelAnimSetScreen], a
	ld a, [hl]
	ld [wDuelAnimReturnBank], a

.skip
	pop hl
	pop de
	pop bc
	pop af
	ret

Func_1e088::
	push af
	push bc
	push de
	push hl
	ld a, [wActiveScreenAnim]
	cp $ff
	jr z, .update_animations

	; run screen update function
	ld hl, wScreenAnimUpdatePtr
	ld a, [hli]
	ld h, [hl]
	ld l, a
	call CallHL2
	jr .done

.update_animations
	call .ClearInactiveAnimations
	call .Func_1e0e8
	jr nz, .done
	call LoadBufferedDuelAnimation
	ld a, [wCurAnimation]
	and a
	jr z, .done
	call .Func_1e0f8
.done
	pop hl
	pop de
	pop bc
	pop af
	ret

.ClearInactiveAnimations:
	push af
	push bc
	push de
	push hl
	ld c, NUM_SPRITE_ANIM_STRUCTS
	farcall Func_10bc4
.loop_sprite_anims
	farcall Func_10ab7
	bit 7, a
	jr z, .next_sprite_anim
	farcall CheckIsSpriteAnimAnimating
	jr nz, .next_sprite_anim
	; clear animation
	farcall Func_10b71
	ld a, [wNumActiveAnimations]
	dec a
	ld [wNumActiveAnimations], a
.next_sprite_anim
	push bc
	ld bc, SPRITEANIMSTRUCT_LENGTH
	add hl, bc
	pop bc
	dec c
	jr nz, .loop_sprite_anims
	pop hl
	pop de
	pop bc
	pop af
	ret

.Func_1e0e8:
	ld a, [wActiveScreenAnim]
	cp $ff
	ret nz
	ld a, [wdcf0]
	and a
	ret nz
	ld a, [wNumActiveAnimations]
	and a
	ret

.Func_1e0f8:
	ld a, $01 ; unused

	farcall ClearSpriteAnims

	ld a, [wCurAnimation]
	ld [wdc5a], a
	cp DUEL_SPECIAL_ANIMS
	jr c, .not_special
	call Func_3c8e
	jr .asm_1e122
.not_special
	cp DUEL_ANIM_DAMAGE_HUD
	jr nz, .not_damage_hud
	call Func_1e279
	jr .asm_1e122
.not_damage_hud
	cp DUEL_SCREEN_ANIMS
	jr c, .not_screen_anim
	call InitScreenAnimation
	jr .asm_1e122
.not_screen_anim
	call Func_1e171
.asm_1e122
	ret

; input:
; - a = DUEL_ANIM_* animation
GetAnimationData:
	push af
	push bc
	push de
	push hl
	ld c, a
	ld b, $00
	ld l, a
	ld h, $00
	sla l
	rl h
	sla l
	rl h
	sla l
	rl h ; *8
	add hl, bc
	add hl, bc
	add hl, bc ; *11
	ld de, Animations
	add hl, de
	ld a, [hli]
	ld [wAnimationTileset + 0], a
	ld a, [hli]
	ld [wAnimationTileset + 1], a
	ld a, [hli]
	ld [wAnimationSpriteAnim + 0], a
	ld a, [hli]
	ld [wAnimationSpriteAnim + 1], a
	ld a, [hli]
	ld [wAnimationFrameset + 0], a
	ld a, [hli]
	ld [wAnimationFrameset + 1], a
	ld a, [hli]
	ld [wAnimationPalette + 0], a
	ld a, [hli]
	ld [wAnimationPalette + 1], a
	ld a, [hli]
	ld [wAnimationDataFlags], a
	ld a, [hli]
	ld [wAnimationSFX], a
	ld a, [hl]
	ld [wAnimationUnknownParam], a
	pop hl
	pop de
	pop bc
	pop af
	ret

Func_1e171:
	push af
	push bc
	push de
	farcall GetNextInactiveSpriteAnim
	ld a, [wCurAnimation]
	call GetAnimationData
	cp DUEL_ANIM_COIN_HEADS + 1
	jr nc, .not_coin_flip_animation
	cp DUEL_ANIM_COIN_SPIN
	jr c, .not_coin_flip_animation
	call PlayCoinAnimation
	jr .asm_1e1d7

.not_coin_flip_animation
	; load tileset
	farcall SetNewSpriteAnimValues
	ld a, [wAnimationTileset + 0]
	ld c, a
	ld a, [wAnimationTileset + 1]
	ld b, a
	farcall StubSetSpriteAnimValue
	farcall LoadSpriteAnimGfx
	farcall SetSpriteAnimTileOffset

	; load sprite animation
	ld a, [wAnimationSpriteAnim + 0]
	ld c, a
	ld a, [wAnimationSpriteAnim + 1]
	ld b, a
	farcall SetSpriteAnimAnimation

	; load frameset
	ld a, [wAnimationFrameset + 0]
	ld c, a
	ld a, [wAnimationFrameset + 1]
	ld b, a
	farcall SetAndInitSpriteAnimFrameset

	; set object mode (8x8 or 8x16)
	ld a, [wAnimationDataFlags]
	and SPRITE_ANIM_FLAG_8x16
	jr z, .set_palette
	call Set_OBJ_8x16

.set_palette
	push hl
	ld a, [wAnimationPalette + 0]
	ld c, a
	ld a, [wAnimationPalette + 1]
	ld b, a
	farcall GetPaletteGfxPointer
	farcall Func_10908
	pop hl

.asm_1e1d7
	push af
	push bc
	push de
	push hl
	call FlushAllPalettes
	pop hl
	pop de
	pop bc
	pop af

	ld a, [wAnimationDataFlags]
	ld [wAnimFlags], a
	call GetAnimCoordsAndFlags
	ld [wAnimAllowedFlags], a

	ld a, [wAnimationsDisabled]
	or a
	jr z, .animation_enabled
	; animations are disabled, check if
	; this animation is unskippable
	ld a, [wAnimFlags]
	and SPRITE_ANIM_FLAG_UNSKIPPABLE
	jr nz, .animation_enabled
	farcall Func_10b71
	jr .done

.animation_enabled
	; play animation SFX
	ld a, [wAnimationSFX]
	and a
	jr z, .no_sfx
	push af
	ld a, a ; lol
	call CallPlaySFX
	pop af

.no_sfx
	xor a
	farcall Func_10989
	farcall Func_1098d
	ld a, [wAnimAllowedFlags]
	and SPRITE_ANIM_FLAG_X_INVERTED | SPRITE_ANIM_FLAG_Y_INVERTED
	farcall Func_10989
	bit SPRITE_ANIM_FLAG_Y_INVERTED_F, a
	jr z, .asm_1e234
	push af
	ld a, e
	add -88
	ld e, a
	ld a, [wAnimAllowedFlags]
	and SPRITE_ANIM_FLAG_3
	jr z, .asm_1e233
	ld a, e
	add 16
	ld e, a
.asm_1e233
	pop af
.asm_1e234
	bit SPRITE_ANIM_FLAG_X_INVERTED_F, a
	jr z, .asm_1e23e
	push af
	ld a, d
	add -8
	ld d, a
	pop af
.asm_1e23e
	and SPRITE_ANIM_FLAG_X_FLIP | SPRITE_ANIM_FLAG_Y_FLIP
	swap a
	sla a
	farcall Func_1098d
	farcall SetSpriteAnimPosition
	ld a, [wNumActiveAnimations]
	inc a
	ld [wNumActiveAnimations], a
.done
	pop de
	pop bc
	pop af
	ret

PlayCoinAnimation:
	ld a, [wDuelAnimDuelistSide]
	cp PLAYER_TURN
	jr nz, .opps_side
	ld a, [wPlayerCoin]
	jr .got_coin
.opps_side
	ld a, [wOppCoin]
.got_coin
	lb de, 80, 80
	call Func_1d198
	ld a, [wCurAnimation]
	sub DUEL_ANIM_COIN_SPIN
	call Func_1d443
	farcall Func_10bc4
	ret

Func_1e279:
	push af
	push bc
	push de
	push hl
	ld a, DUEL_ANIM_SHOW_DAMAGE
	ld [wCurAnimation], a
	xor a
	ld [wdc58], a
	call Func_1e2b1
	ld a, [wDuelAnimEffectiveness]
	bit 0, a
	jr z, .asm_1e293
	call Func_1e30d
.asm_1e293
	ld a, $12
	ld [wdc58], a
	ld a, [wDuelAnimEffectiveness]
	bit 1, a
	jr z, .asm_1e2a2
	call Func_1e324
.asm_1e2a2
	ld a, [wDuelAnimEffectiveness]
	bit 2, a
	jr z, .asm_1e2ac
	call Func_1e347
.asm_1e2ac
	pop hl
	pop de
	pop bc
	pop af
	ret

Func_1e2b1:
	; check if damage is over 1000
	ld a, [wDuelAnimDamage + 1]
	cp HIGH(1000)
	jr nz, .not_over_1000
	ld a, [wDuelAnimDamage + 0]
	cp LOW(1000)
	jr nc, .done

.not_over_1000
	ld a, [wDuelAnimDamage + 0]
	ld l, a
	ld a, [wDuelAnimDamage + 1]
	ld h, a
	ld de, wDecimalRepresentation
	ld b, TRUE
	call CalculateDecimalDigits

	ld de, wDecimalRepresentation + $4
	ld c, 3 ; number of digits
.loop_digits
	ld a, [de]
	cp $ff
	jr z, .done
	push de
	push bc
	call Func_1e171
	push hl
	ld a, [de]
	ld c, a
	ld b, $00
	ld hl, FRAMESET_008
	add hl, bc
	ld b, h
	ld c, l
	pop hl
	farcall SetAndInitSpriteAnimFrameset
	farcall GetSpriteAnimPosition
	pop bc
	push hl
	ld b, $00
	ld hl, .digit_offsets
	dec c
	add hl, bc
	inc c
	ld a, [hl]
	pop hl
	add d
	ld d, a
	farcall SetSpriteAnimPosition
	pop de
	dec de
	dec c
	jr nz, .loop_digits
.done
	ret

.digit_offsets
	;  ones digit, tens digit, hundred digits
	db        -16,         -8,              0

Func_1e30d:
	call Func_1e171
	ld bc, FRAMESET_014
	farcall SetAndInitSpriteAnimFrameset
	farcall GetSpriteAnimPosition
	ld a, d
	add 8
	ld d, a
	farcall SetSpriteAnimPosition
	ret

Func_1e324:
	call Func_1e171
	ld bc, FRAMESET_013
	farcall SetAndInitSpriteAnimFrameset
	farcall GetSpriteAnimPosition
	ld a, d
	add -8
	ld d, a
	farcall SetSpriteAnimPosition
	ld a, [wdc58]
	farcall SetSpriteAnimStartDelay
	add $12
	ld [wdc58], a
	ret

Func_1e347:
	call Func_1e171
	ld bc, FRAMESET_012
	farcall SetAndInitSpriteAnimFrameset
	farcall GetSpriteAnimPosition
	ld a, d
	add -16
	ld d, a
	farcall SetSpriteAnimPosition
	ld a, [wdc58]
	farcall SetSpriteAnimStartDelay
	ret

; outputs x and y coordinates for the sprite animation
; taking into account who the turn duelist is.
; also returns in a the allowed animation flags of
; the configuration that is selected.
; output:
; - a = anim flags
; - d = x coordinate
; - e = y coordinate
GetAnimCoordsAndFlags:
	push bc
	push hl
	ld c, 0
	ld a, [wAnimFlags]
	and SPRITE_ANIM_FLAG_CENTERED
	jr nz, .centered

	ld a, [wDuelAnimationScreen]
	add a ; 2 * [wDuelAnimationScreen]
	ld c, a
	add a ; 4 * [wDuelAnimationScreen]
	add c ; 6 * [wDuelAnimationScreen]
	add a ; 12 * [wDuelAnimationScreen]
	ld c, a

	ld a, [wDuelAnimDuelistSide]
	cp PLAYER_TURN
	jr z, .player_side
; opponent side
	ld a, 6
	add c
	ld c, a
.player_side
	ld a, [wDuelAnimLocationParam]
	add c ; a = [wDuelAnimLocationParam] + c
	ld c, a
	ld b, 0
	ld hl, AnimationCoordinatesIndex
	add hl, bc
	ld c, [hl]

.centered
	; if centered and y inverted/flipped
	ld a, [wAnimFlags]
	cp SPRITE_ANIM_FLAG_Y_FLIP | SPRITE_ANIM_FLAG_CENTERED | SPRITE_ANIM_FLAG_Y_INVERTED
	jr nz, .calc_addr
	ld a, [wDuelAnimDuelistSide]
	cp PLAYER_TURN
	jr z, .calc_addr
	ld c, 1

.calc_addr
	ld a, c
	add a ; a = c * 2
	add c ; a = c * 3
	ld c, a
	ld b, 0
	ld hl, AnimationCoordinates
	add hl, bc
	ld d, [hl] ; x coord
	inc hl
	ld e, [hl] ; y coord
	inc hl
	ld a, [wAnimFlags]
	and [hl] ; flags
	pop hl
	pop bc
	ret

AnimationCoordinatesIndex:
; animations in the Duel Main Scene
	db $02, $02, $02, $02, $02, $02 ; player
	db $03, $03, $03, $03, $03, $03 ; opponent

; animations in the Player's Play Area, for each Play Area Pokemon
	db $04, $05, $06, $07, $08, $09 ; player
	db $04, $05, $06, $07, $08, $09 ; opponent

; animations in the Opponent's Play Area, for each Play Area Pokemon
	db $0a, $0b, $0c, $0d, $0e, $0f ; player
	db $0a, $0b, $0c, $0d, $0e, $0f ; opponent

AnimationCoordinates:
; x coord, y coord, animation flags
	db  88, 88, NONE ; $0
	db  88, 56, SPRITE_ANIM_FLAG_Y_FLIP | SPRITE_ANIM_FLAG_Y_INVERTED ; $1

; animations in the Duel Main Scene
	db  40, 80, NONE ; $2
	db 136, 48, SPRITE_ANIM_FLAG_X_FLIP | SPRITE_ANIM_FLAG_Y_FLIP | SPRITE_ANIM_FLAG_X_INVERTED | SPRITE_ANIM_FLAG_Y_INVERTED ; $3

; animations in the Player's Play Area, for each Play Area Pokemon
	db  88, 72, NONE ; $4
	db  24, 96, NONE ; $5
	db  56, 96, NONE ; $6
	db  88, 96, NONE ; $7
	db 120, 96, NONE ; $8
	db 152, 96, NONE ; $9

; animations in the Opponent's Play Area, for each Play Area Pokemon
	db  88, 80, $ff ^ (SPRITE_ANIM_FLAG_CENTERED | SPRITE_ANIM_FLAG_8x16 | SPRITE_ANIM_FLAG_UNSKIPPABLE) ; $a
	db 152, 40, $ff ^ (SPRITE_ANIM_FLAG_CENTERED | SPRITE_ANIM_FLAG_8x16 | SPRITE_ANIM_FLAG_UNSKIPPABLE) ; $b
	db 120, 40, $ff ^ (SPRITE_ANIM_FLAG_CENTERED | SPRITE_ANIM_FLAG_8x16 | SPRITE_ANIM_FLAG_UNSKIPPABLE) ; $c
	db  88, 40, $ff ^ (SPRITE_ANIM_FLAG_CENTERED | SPRITE_ANIM_FLAG_8x16 | SPRITE_ANIM_FLAG_UNSKIPPABLE) ; $d
	db  56, 40, $ff ^ (SPRITE_ANIM_FLAG_CENTERED | SPRITE_ANIM_FLAG_8x16 | SPRITE_ANIM_FLAG_UNSKIPPABLE) ; $e
	db  24, 40, $ff ^ (SPRITE_ANIM_FLAG_CENTERED | SPRITE_ANIM_FLAG_8x16 | SPRITE_ANIM_FLAG_UNSKIPPABLE) ; $f
; 0x1e409

SECTION "Bank 7@6419", ROMX[$6419], BANK[$7]

; sets wAnimationsDisabled to FALSE
EnableAnimations:
	push af
	xor a ; FALSe
	ld [wAnimationsDisabled], a
	pop af
	ret

_CheckAnyAnimationPlaying::
	push bc
	ld a, [wDuelAnimBufferSize]
	ld b, a
	ld a, [wDuelAnimBufferCurPos]
	cp b
	jr nz, .asm_1e42f
	ld a, [wNumActiveAnimations]
	and a
.asm_1e42f
	pop bc
	ret

; initializes a screen animation from wCurAnimation
; loads a function pointer for updating a frame
; and initializes the duration of the animation.
InitScreenAnimation:
	ld a, [wAnimationsDisabled]
	and a
	jr nz, .skip
	push hl
	ld hl, wNumActiveAnimations
	inc [hl]
	pop hl

	ld a, [wCurAnimation]
	ld [wActiveScreenAnim], a
	sub DUEL_SCREEN_ANIMS
	add a
	add a
	ld c, a
	ld b, $00
	ld hl, ScreenAnimationFunctions
	add hl, bc
	ld a, [hli]
	ld [wScreenAnimUpdatePtr], a
	ld c, a
	ld a, [hli]
	ld [wScreenAnimUpdatePtr + 1], a
	ld b, a
	ld a, [hl]
	ld [wScreenAnimDuration], a
	call CallBC
.skip
	ret

; for the following animations, these functions
; are run with the corresponding duration.
; this duration decides different effects,
; depending on which function runs
; and is decreased by one each time.
; when it is down to 0, the animation is done.

MACRO screen_effect
	dw \1 ; function pointer
	db \2 ; duration
	db $00 ; padding
ENDM

ScreenAnimationFunctions:
; function pointer, duration
	screen_effect ShakeScreenX_Small, 24 ; DUEL_ANIM_SMALL_SHAKE_X
	screen_effect ShakeScreenX_Big,   32 ; DUEL_ANIM_BIG_SHAKE_X
	screen_effect ShakeScreenY_Small, 24 ; DUEL_ANIM_SMALL_SHAKE_Y
	screen_effect ShakeScreenY_Big,   32 ; DUEL_ANIM_BIG_SHAKE_Y
	screen_effect WhiteFlashScreen,    8 ; DUEL_ANIM_FLASH
	screen_effect DistortScreen,      63 ; DUEL_ANIM_DISTORT

ShakeScreenX_Small:
	ld hl, SmallShakeOffsets
	jr ShakeScreenX
ShakeScreenX_Big:
	ld hl, BigShakeOffsets
ShakeScreenX:
	ld a, l
	ld [wdcee + 0], a
	ld a, h
	ld [wdcee + 1], a
	ld hl, wScreenAnimUpdatePtr
	ld [hl], LOW(.UpdateFunc)
	inc hl
	ld [hl], HIGH(.UpdateFunc)
	ret

.UpdateFunc:
	ld hl, wScreenAnimDuration
	dec [hl]
	call UpdateShakeOffset
	jp nc, LoadDefaultScreenAnimationUpdateWhenFinished
	ldh a, [hSCX]
	add [hl]
	ldh [hSCX], a
	jp LoadDefaultScreenAnimationUpdateWhenFinished

ShakeScreenY_Small:
	ld hl, SmallShakeOffsets
	jr ShakeScreenY
ShakeScreenY_Big:
	ld hl, BigShakeOffsets
ShakeScreenY:
	ld a, l
	ld [wdcee + 0], a
	ld a, h
	ld [wdcee + 1], a
	ld hl, wScreenAnimUpdatePtr
	ld [hl], LOW(.UpdateFunc)
	inc hl
	ld [hl], HIGH(.UpdateFunc)
	ret

.UpdateFunc:
	ld hl, wScreenAnimDuration
	dec [hl]
	call UpdateShakeOffset
	jp nc, LoadDefaultScreenAnimationUpdateWhenFinished
	ldh a, [hSCY]
	add [hl]
	ldh [hSCY], a
	jp LoadDefaultScreenAnimationUpdateWhenFinished

; get the displacement of the current frame
; depending on the value of wScreenAnimDuration
; returns carry if displacement was updated
UpdateShakeOffset:
	ld hl, wdcee
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, [wScreenAnimDuration]
	cp [hl]
	ret nc
	inc hl
	push hl
	inc hl
	ld a, l
	ld [wdcee + 0], a
	ld a, h
	ld [wdcee + 1], a
	pop hl
	scf
	ret

SmallShakeOffsets:
; timer, offset
	db 21,  2
	db 17, -2
	db 13,  2
	db  9, -2
	db  5,  1
	db  1, -1

BigShakeOffsets:
; timer, offset
	db 29,  4
	db 25, -4
	db 21,  4
	db 17, -4
	db 13,  3
	db  9, -3
	db  5,  2
	db  1, -2

; checks if screen animation duration is over
; and if so, loads the default update function
LoadDefaultScreenAnimationUpdateWhenFinished:
	ld a, [wScreenAnimDuration]
	and a
	ret nz
	; fallthrough

; function called for the screen animation update when it is over
DefaultScreenAnimationUpdate:
	ld a, $ff
	ld [wActiveScreenAnim], a
	ld hl, wNumActiveAnimations
	dec [hl]
	call DisableInt_LYCoincidence
	xor a
	ldh [hSCX], a
	ldh [rSCX], a
	ldh [hSCY], a
	ld hl, wScreenAnimUpdatePtr
	ld [hl], LOW(DefaultScreenAnimationUpdate)
	inc hl
	ld [hl], HIGH(DefaultScreenAnimationUpdate)
	ret

WhiteFlashScreen:
	ld hl, wScreenAnimUpdatePtr
	ld [hl], LOW(.UpdateFunc)
	inc hl
	ld [hl], HIGH(.UpdateFunc)

	; backup the current background pals
	ld de, wTempBackgroundPalettesCGB
	ld hl, wBackgroundPalettesCGB
	ld bc, 8 palettes
	call CopyBCBytesFromHLToDE
	ld a, $ff ; white
	ld hl, wBackgroundPalettesCGB
	ld bc, 8 palettes
	call WriteBCBytesToHL
	xor a
	call FlushAllPalettes

.UpdateFunc:
	ld hl, wScreenAnimDuration
	dec [hl]
	ld a, [hl]
	and a
	ret nz
	; retrieve the previous background pals
	ld de, wBackgroundPalettesCGB
	ld hl, wTempBackgroundPalettesCGB
	ld bc, 8 palettes
	call CopyBCBytesFromHLToDE
	xor a
	call FlushAllPalettes
	jp DefaultScreenAnimationUpdate

DistortScreen:
	ld hl, wScreenAnimUpdatePtr
	ld [hl], LOW(.UpdateFunc)
	inc hl
	ld [hl], HIGH(.UpdateFunc)
	xor a
	ld [wApplyBGScroll], a
	ld hl, wLCDCFunctionTrampoline + 1
	ld [hl], LOW(ApplyBackgroundScroll)
	inc hl
	ld [hl], HIGH(ApplyBackgroundScroll)
	ld a, 1
	ld [wBGScrollMod], a
	call EnableInt_LYCoincidence

.UpdateFunc:
	ld a, [wScreenAnimDuration]
	srl a
	srl a
	srl a
	and %00000111
	ld c, a
	ld b, $00
	ld hl, .BGScrollModData
	add hl, bc
	ld a, [hl]
	ld [wBGScrollMod], a
	ld hl, wScreenAnimDuration
	dec [hl]
	jp LoadDefaultScreenAnimationUpdateWhenFinished

; each value is applied for 8 "ticks" of wScreenAnimDuration
; starting from the last and running backwards
.BGScrollModData:
	db 4, 3, 2, 1, 1, 1, 1, 2

; returns carry if player lost
Func_1e5a2::
	push bc
	push de
	push hl
	ld a, EVENT_F0
	farcall GetEventValue
	jr nz, .from_sram
	call .RunDuel
	jr .check_result
.from_sram
	call RunDuelFromSRAM
.check_result
	scf
	ccf
	ld a, [wDuelResult]
	and a
	jr z, .won
	scf ; lost
.won
	pop hl
	pop de
	pop bc
	ret

.RunDuel:
	farcall Func_1022a
	call Func_1e73a
	ld a, EVENT_EB
	farcall GetEventValue
	jr nz, .start_duel
	call Func_1e60c
	ld a, [wSpecialRule]
	and a
	jr z, .start_duel
	call ShowSpecialRuleDescription
.start_duel
	bank1call StartDuel_VSAIOpp
	farcall Func_10252
	ret
; 0x1e5e5

SECTION "Bank 7@65f8", ROMX[$65f8], BANK[$7]

RunDuelFromSRAM:
	farcall Func_10cfe
	farcall Func_1109f
	farcall Func_1022a
	bank1call StartDuelFromSRAM
	farcall Func_10252
	ret

Func_1e60c:
	push af
	push bc
	push de
	push hl
	farcall ClearSpriteAnimsAndSetInitialGraphicsConfiguration

	; show opponent portrait
	ld a, [wOpponentNPCID]
	lb bc, 7, 3
	ld e, EMOTION_NORMAL
	call DrawNPCPortrait

	farcall SetFrameFuncAndFadeFromWhite

	; play duel start theme
	ld a, [wDuelStartTheme]
	push af
	ld a, a ; wow
	call Func_3d09
	pop af

	; print duelist intro text
	ld a, [wOpponentName + 0]
	ld [wTxRam2 + 0], a
	ld a, [wOpponentName + 1]
	ld [wTxRam2 + 1], a
	ld a, [wOpponentDeckName + 0]
	ld [wTxRam2_b + 0], a
	ld a, [wOpponentDeckName + 1]
	ld [wTxRam2_b + 1], a
	ld a, [wcd0f]
	dec a
	add a ; *2
	ld c, a
	ld b, $00
	ld hl, .DuelistIntroTextIDs
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	farcall Func_1107c

	call WaitForSongToFinish
	call WaitForWideTextBoxInput
	farcall FadeToWhiteAndUnsetFrameFunc
	pop hl
	pop de
	pop bc
	pop af
	ret

.DuelistIntroTextIDs
	tx Text0651
	tx Text0652
	tx Text0653
	tx Text0654
	tx Text0655
	tx Text0656
	tx Text0657
	tx Text0658
	tx Text0659
	tx Text065a
	tx Text065b
	tx Text065c
	tx Text065d
	tx Text065e
	tx Text065f
	tx Text0660
	tx Text0661
	tx Text0662
	tx Text0663
	tx Text0664
	tx Text0665
	tx Text0666
	tx Text0667
	tx Text0668
	tx Text0669
	tx Text066a
	tx Text066b
	tx Text066c
	tx Text066d
	tx Text066e
	tx Text066f
	tx Text0670
	tx Text0671
	tx Text0672
	tx Text0673
	tx Text0674
	tx Text0675
	tx Text0676
	tx Text0677
	tx Text0678

ShowSpecialRuleDescription:
	push af
	push bc
	push de
	push hl
	farcall ClearSpriteAnimsAndSetInitialGraphicsConfiguration
	call .DrawScreen
	farcall SetFrameFuncAndFadeFromWhite
	call WaitForWideTextBoxInput
	farcall FadeToWhiteAndUnsetFrameFunc
	pop hl
	pop de
	pop bc
	pop af
	ret

.DrawScreen:
	ld a, [wSpecialRule]
	add a
	add a
	ld c, a ; *4
	ld b, $00
	ld hl, .TitleAndDescriptionTextIDs
	add hl, bc

	; draws scene with text box drawn around
	lb de,  0, 0
	lb bc, 20, 6
	call DrawRegularTextBoxVRAM0
	ld a, SCENE_SPECIAL_RULES
	lb bc, 5, 1
	call LoadScene

	; print title
	push hl
	ld a, [hli]
	ld h, [hl]
	ld l, a
	lb de, 3, 4
	call Func_35af
	pop hl

	; print description
	inc hl
	inc hl
	lb de,  0,  6
	lb bc, 20, 12
	call DrawRegularTextBoxVRAM0
	ld a, [hli]
	ld h, [hl]
	ld l, a
	lb de, 1, 8
	call Func_35af
	ret

.TitleAndDescriptionTextIDs:
	;  title,    description
	dw NULL,     NULL     ; NO_SPECIAL_RULE
	tx Text063b, Text063c ; CHLOROPHYLL
	tx Text063d, Text063e ; THUNDER_CHARGE
	tx Text063f, Text0640 ; FLAME_ARMOR
	tx Text0641, Text0642 ; SMALL_BENCH
	tx Text0643, Text0644 ; RUNNING_WATER
	tx Text0645, Text0646 ; EARTH_POWER
	tx Text0647, Text0648 ; LOW_RESISTANCE
	tx Text0649, Text064a ; ENERGY_RETURN
	tx Text064b, Text064c ; TOUGH_ESCAPE
	tx Text064d, Text064e ; BLACK_HOLE
; 0x1e73a

SECTION "Bank 7@673a", ROMX[$673a], BANK[$7]

Func_1e73a:
	push af
	push bc
	push de
	push hl
	ld a, [wNPCDuelDeckID]
	push af
	farcall LoadDeckIDData
	pop af
	ld [wNPCDuelDeckID], a
	pop hl
	pop de
	pop bc
	pop af
	ret
; 0x1e74f

SECTION "Bank 7@6767", ROMX[$6767], BANK[$7]

Func_1e767:
	xor a
	ld [wdd07], a
	ret
; 0x1e76c

SECTION "Bank 7@6ca5", ROMX[$6ca5], BANK[$7]

Func_1eca5:
	push af
	push bc
	push de
	push hl
	xor a
	ld [wdd36], a
	ld [wdd50], a
	ld [wdd5c], a
	ld [wdd5d], a
	ld [wdd5e], a
	ld [wdd5b], a
	ld [wdd5a], a
	ld [wdd5f], a
	ld [wdd60], a
	ld [wdd73], a
	ld [wdd74], a
	xor a
	ld hl, wdd37
	ld bc, $19
	call WriteBCBytesToHL
	xor a
	ld hl, wdd51
	ld bc, $9
	call WriteBCBytesToHL
	pop hl
	pop de
	pop bc
	pop af
	ret
; 0x1ece4

SECTION "Bank 7@7293", ROMX[$7293], BANK[$7]

Func_1f293:
	push af
	push bc
	push de
	push hl
	ld a, [wdd36]
	and a
	jr z, .asm_1f2eb
	ld a, $ff
	ld [wdd5a], a
	ld a, [wdd50]
	cp $08
	jr z, .asm_1f2eb
	ld de, wdd51
	ld hl, wdd37
	ld a, [wdd50]
	ld b, a
	ld a, $08
	sub b
	ld b, a
	ld c, $00
.asm_1f2b9
	ld a, [hli]
	and a
	jr z, .asm_1f2c6
	res 7, a
	call .Func_1f2f6
	inc c
	dec b
	jr nz, .asm_1f2b9
.asm_1f2c6
	ld a, [wdd50]
	add c
	ld [wdd50], a
	ld a, [wdd36]
	sub c
	ld [wdd36], a
	ld hl, wdd37
	ld b, $00
	add hl, bc
	ld de, wdd37
	ld a, $18
	sub c
	ld c, a
	ld a, [hli]
.asm_1f2e2
	ld [de], a
	inc de
	ld b, [hl]
	xor a
	ld [hli], a
	ld a, b
	dec c
	jr nz, .asm_1f2e2
.asm_1f2eb
	ld a, [wdd36]
	ld [wdd5b], a
	pop hl
	pop de
	pop bc
	pop af
	ret

; shift data in de 1 byte right
.Func_1f2f6:
	push bc
	push de
	push hl
	ld c, $08
.loop
	ld l, a
	ld a, [de]
	ld h, a
	ld a, l
	ld [de], a
	inc de
	ld a, h
	dec c
	jr nz, .loop
	pop hl
	pop de
	pop bc
	ret
; 0x1f309

SECTION "Bank 7@757b", ROMX[$757b], BANK[$7]

Func_1f57b::
	push af
	push bc
	push de
	push hl
	ld a, [wdd75]
	and a
	jr z, .asm_1f588
	call .Func_1f58d
.asm_1f588
	pop hl
	pop de
	pop bc
	pop af
	ret

.Func_1f58d:
	dec a
	add a ; *2
	ld c, a
	ld b, $00
	ld hl, .OffsetPointers
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, [wdd76]
	add a ; *2
	ld c, a
	add hl, bc
	ld a, [hl]
	cp $80
	jr z, .asm_1f5b6
	ld c, [hl]
	ldh a, [hSCX]
	sub c
	ldh [hSCX], a
	inc hl
	ld c, [hl]
	ldh a, [hSCY]
	sub c
	ldh [hSCY], a
	ld hl, wdd76
	inc [hl]
	ret

.asm_1f5b6
	xor a
	ld [wdd76], a
	ld a, [wdd77]
	and a
	jr z, .asm_1f5c5
	dec a
	ld [wdd77], a
	ret nz
.asm_1f5c5
	xor a
	ld [wdd75], a
	ret

.OffsetPointers:
	dw .offsets1 ; $1
	dw .offsets2 ; $2
	dw .offsets3 ; $3
	dw .offsets4 ; $4
	dw .offsets5 ; $5
	dw .offsets6 ; $6

.offsets1
	db -1,  0
	db  1,  0
	db  1,  0
	db -1,  0
	db $80 ; end

.offsets2
	db  0, -1
	db  0,  1
	db  0,  1
	db  0, -1
	db $80 ; end

.offsets3
	db -1, -1
	db  1,  1
	db  1,  1
	db -1, -1
	db $80 ; end

.offsets4
	db -2,  0
	db  2,  0
	db  2,  0
	db -2,  0
	db $80 ; end

.offsets5
	db  0, -2
	db  0,  2
	db  0,  2
	db  0, -2
	db $80 ; end

.offsets6
	db -2,  2
	db  2, -2
	db  2, -2
	db -2,  2
	db $80 ; end
; 0x1f60c

SECTION "Bank 7@782b", ROMX[$782b], BANK[$7]

CardPopMenu:
	push af
	push bc
	push de
	push hl
	farcall SetSpriteAnimationAndFadePalsFrameFunc
	call StartFadeFromWhite
	call WaitPalFading_Bank07
	farcall _CardPopMenu
	call StartFadeToWhite
	call WaitPalFading_Bank07
	farcall UnsetSpriteAnimationAndFadePalsFrameFunc
	pop hl
	pop de
	pop bc
	pop af
	ret
; 0x1f84c

SECTION "Bank 7@78bd", ROMX[$78bd], BANK[$7]

PlayerGenderAndNameSelection::
	push af
	push bc
	push de
	push hl
.start
	farcall SetFadePalsFrameFunc
	call StartFadeToWhite
	call WaitPalFading_Bank07
	farcall UnsetFadePalsFrameFunc
	push af
	ld a, MUSIC_PCMAINMENU
	call SetMusic
	pop af
	farcall PlayerGenderSelection
	farcall PlayerNameSelection
	call ConfirmPlayerNameAndGender
	jr c, .start ; player selected no
	call SetNoMusic
	pop hl
	pop de
	pop bc
	pop af
	ret
; 0x1f8eb

SECTION "Bank 7@791d", ROMX[$791d], BANK[$7]

MACRO animation
	dw \1 ; tileset ID
	dw \2 ; sprite animation ID
	dw \3 ; frameset ID
	dw \4 ; palette ID
	db \5 ; flags
	db \6 ; sfx ID
	db \7 ; ?
ENDM

Animations:
; DUEL_ANIM_NONE
	animation TILESET_HIT, SPRITE_ANIM_00, FRAMESET_000, PALETTE_0D8, SPRITE_ANIM_FLAG_UNSKIPPABLE, SFX_2E, $00
; DUEL_ANIM_GLOW
	animation TILESET_HIT, SPRITE_ANIM_00, FRAMESET_000, PALETTE_0D8, SPRITE_ANIM_FLAG_UNSKIPPABLE, SFX_11, $00
; DUEL_ANIM_PARALYSIS
	animation TILESET_PARALYSIS, SPRITE_ANIM_01, FRAMESET_001, PALETTE_0D9, SPRITE_ANIM_FLAG_UNSKIPPABLE, SFX_12, $00
; DUEL_ANIM_SLEEP
	animation TILESET_SLEEP, SPRITE_ANIM_02, FRAMESET_002, PALETTE_0DA, SPRITE_ANIM_FLAG_UNSKIPPABLE, SFX_13, $00
; DUEL_ANIM_CONFUSION
	animation TILESET_CONFUSION_STAR, SPRITE_ANIM_03, FRAMESET_003, PALETTE_0DB, SPRITE_ANIM_FLAG_UNSKIPPABLE, SFX_14, $00
; DUEL_ANIM_POISON
	animation TILESET_POISON, SPRITE_ANIM_04, FRAMESET_004, PALETTE_0DC, SPRITE_ANIM_FLAG_UNSKIPPABLE, SFX_15, $00
; DUEL_ANIM_SINGLE_HIT
	animation TILESET_GLOW, SPRITE_ANIM_05, FRAMESET_005, PALETTE_0DD, SPRITE_ANIM_FLAG_UNSKIPPABLE, SFX_16, $00
; DUEL_ANIM_HIT
	animation TILESET_GLOW, SPRITE_ANIM_05, FRAMESET_006, PALETTE_0DD, SPRITE_ANIM_FLAG_UNSKIPPABLE, SFX_17, $00
; DUEL_ANIM_BIG_HIT
	animation TILESET_GLOW, SPRITE_ANIM_05, FRAMESET_007, PALETTE_0DD, SPRITE_ANIM_FLAG_UNSKIPPABLE, SFX_17, $00
; DUEL_ANIM_SHOW_DAMAGE
	animation TILESET_DAMAGE, SPRITE_ANIM_06, FRAMESET_008, PALETTE_0DE, SPRITE_ANIM_FLAG_UNSKIPPABLE, NONE, $00
; DUEL_ANIM_THUNDER_SHOCK
	animation TILESET_THUNDER, SPRITE_ANIM_07, FRAMESET_015, PALETTE_0DF, NONE, SFX_18, $00
; DUEL_ANIM_LIGHTNING
	animation TILESET_LIGHTING, SPRITE_ANIM_08, FRAMESET_016, PALETTE_0E0, NONE, SFX_19, $00
; DUEL_ANIM_BORDER_SPARK
	animation TILESET_SPARK, SPRITE_ANIM_09, FRAMESET_017, PALETTE_0E1, NONE, SFX_1A, $00
; DUEL_ANIM_BIG_LIGHTNING
	animation TILESET_BIG_LIGHTING, SPRITE_ANIM_0A, FRAMESET_018, PALETTE_0E2, SPRITE_ANIM_FLAG_CENTERED, SFX_1B, $00
; DUEL_ANIM_SMALL_FLAME
	animation TILESET_EMBER, SPRITE_ANIM_0B, FRAMESET_019, PALETTE_0E3, NONE, SFX_1C, $00
; DUEL_ANIM_BIG_FLAME
	animation TILESET_EMBER, SPRITE_ANIM_0B, FRAMESET_01A, PALETTE_0E3, NONE, SFX_1D, $00
; DUEL_ANIM_FIRE_SPIN
	animation TILESET_FIRE_SPIN, SPRITE_ANIM_0C, FRAMESET_01B, PALETTE_0E4, SPRITE_ANIM_FLAG_CENTERED, SFX_1E, $00
; DUEL_ANIM_DIVE_BOMB
	animation TILESET_FIRE_BIRD, SPRITE_ANIM_0D, FRAMESET_01C, PALETTE_0E5, NONE, SFX_1F, $00
; DUEL_ANIM_WATER_JETS
	animation TILESET_WATER_DROP, SPRITE_ANIM_0E, FRAMESET_021, PALETTE_0E6, SPRITE_ANIM_FLAG_CENTERED, SFX_20, $00
; DUEL_ANIM_WATER_GUN
	animation TILESET_WATER_GUN, SPRITE_ANIM_0F, FRAMESET_022, PALETTE_0E7, NONE, SFX_21, $00
; DUEL_ANIM_WHIRLPOOL
	animation TILESET_WHIRLPOOL, SPRITE_ANIM_10, FRAMESET_023, PALETTE_0E8, SPRITE_ANIM_FLAG_CENTERED, SFX_22, $00
; DUEL_ANIM_HYDRO_PUMP
	animation TILESET_HYDRO_PUMP, SPRITE_ANIM_11, FRAMESET_024, PALETTE_0E9, NONE, SFX_23, $00
; DUEL_ANIM_BLIZZARD
	animation TILESET_SNOW, SPRITE_ANIM_12, FRAMESET_025, PALETTE_0EA, SPRITE_ANIM_FLAG_CENTERED, SFX_24, $00
; DUEL_ANIM_PSYCHIC
	animation TILESET_PSYCHIC, SPRITE_ANIM_13, FRAMESET_026, PALETTE_0EB, NONE, SFX_25, $00
; DUEL_ANIM_LEER
	animation TILESET_EVIL_EYES, SPRITE_ANIM_14, FRAMESET_027, PALETTE_0EC, NONE, SFX_26, $00
; DUEL_ANIM_BEAM
	animation TILESET_BEAM, SPRITE_ANIM_15, FRAMESET_028, PALETTE_0ED, SPRITE_ANIM_FLAG_Y_FLIP | SPRITE_ANIM_FLAG_Y_INVERTED, SFX_27, $00
; DUEL_ANIM_HYPER_BEAM
	animation TILESET_HYPER_BEAM, SPRITE_ANIM_16, FRAMESET_029, PALETTE_0EE, SPRITE_ANIM_FLAG_Y_FLIP | SPRITE_ANIM_FLAG_Y_INVERTED, SFX_28, $00
; DUEL_ANIM_ROCK_THROW
	animation TILESET_ROCK, SPRITE_ANIM_17, FRAMESET_02A, PALETTE_0EF, NONE, SFX_29, $00
; DUEL_ANIM_STONE_BARRAGE
	animation TILESET_ROCK, SPRITE_ANIM_17, FRAMESET_02B, PALETTE_0EF, NONE, SFX_2A, $00
; DUEL_ANIM_PUNCH
	animation TILESET_PUNCH, SPRITE_ANIM_18, FRAMESET_02C, PALETTE_0F0, NONE, SFX_2B, $00
; DUEL_ANIM_THUNDERPUNCH
	animation TILESET_PUNCH, SPRITE_ANIM_18, FRAMESET_02D, PALETTE_0F0, NONE, SFX_52, $00
; DUEL_ANIM_FIRE_PUNCH
	animation TILESET_PUNCH, SPRITE_ANIM_18, FRAMESET_02E, PALETTE_0F0, NONE, SFX_53, $00
; DUEL_ANIM_STRETCH_KICK
	animation TILESET_STRETCH_KICK, SPRITE_ANIM_19, FRAMESET_02F, PALETTE_0F1, SPRITE_ANIM_FLAG_X_FLIP | SPRITE_ANIM_FLAG_X_INVERTED, SFX_2C, $00
; DUEL_ANIM_SLASH
	animation TILESET_SLASH, SPRITE_ANIM_1A, FRAMESET_030, PALETTE_0F2, NONE, SFX_2D, $00
; DUEL_ANIM_WHIP
	animation TILESET_VINE_WHIP, SPRITE_ANIM_1B, FRAMESET_032, PALETTE_0F3, NONE, SFX_2D, $00
; DUEL_ANIM_SONICBOOM
	animation TILESET_SONIC_BOOM, SPRITE_ANIM_1C, FRAMESET_033, PALETTE_0F4, NONE, SFX_2E, $00
; DUEL_ANIM_FURY_SWIPES
	animation TILESET_SLASH, SPRITE_ANIM_1A, FRAMESET_031, PALETTE_0F2, NONE, SFX_2F, $00
; DUEL_ANIM_DRILL
	animation TILESET_HORN_DRILL, SPRITE_ANIM_1D, FRAMESET_034, PALETTE_0F5, SPRITE_ANIM_FLAG_X_FLIP | SPRITE_ANIM_FLAG_X_INVERTED, SFX_30, $00
; DUEL_ANIM_POT_SMASH
	animation TILESET_POT_SMASH, SPRITE_ANIM_1E, FRAMESET_035, PALETTE_0F6, NONE, SFX_31, $00
; DUEL_ANIM_BONEMERANG
	animation TILESET_BONE, SPRITE_ANIM_1F, FRAMESET_036, PALETTE_0F7, NONE, SFX_32, $00
; DUEL_ANIM_SEISMIC_TOSS
	animation TILESET_SEISMIC_TOSS, SPRITE_ANIM_20, FRAMESET_037, PALETTE_0F8, NONE, SFX_33, $00
; DUEL_ANIM_NEEDLES
	animation TILESET_NEEDLES, SPRITE_ANIM_21, FRAMESET_038, PALETTE_0F9, NONE, SFX_34, $00
; DUEL_ANIM_WHITE_GAS
	animation TILESET_GAS, SPRITE_ANIM_22, FRAMESET_039, PALETTE_0FA, NONE, SFX_35, $00
; DUEL_ANIM_POWDER
	animation TILESET_POWDER, SPRITE_ANIM_23, FRAMESET_03A, PALETTE_0FB, NONE, SFX_36, $00
; DUEL_ANIM_GOO
	animation TILESET_GOO, SPRITE_ANIM_24, FRAMESET_03B, PALETTE_0FC, NONE, SFX_37, $00
; DUEL_ANIM_BUBBLES
	animation TILESET_BUBBLE, SPRITE_ANIM_25, FRAMESET_03C, PALETTE_0FD, NONE, SFX_38, $00
; DUEL_ANIM_STRING_SHOT
	animation TILESET_STRING_SHOT, SPRITE_ANIM_26, FRAMESET_03D, PALETTE_0FE, NONE, SFX_39, $00
; DUEL_ANIM_BOYFRIENDS
	animation TILESET_HEART, SPRITE_ANIM_27, FRAMESET_03E, PALETTE_0FF, NONE, SFX_3A, $00
; DUEL_ANIM_LURE
	animation TILESET_LURE, SPRITE_ANIM_28, FRAMESET_03F, PALETTE_100, SPRITE_ANIM_FLAG_X_FLIP | SPRITE_ANIM_FLAG_X_INVERTED, SFX_3B, $00
; DUEL_ANIM_TOXIC
	animation TILESET_SKULL, SPRITE_ANIM_29, FRAMESET_040, PALETTE_101, NONE, SFX_3C, $00
; DUEL_ANIM_CONFUSE_RAY
	animation TILESET_CONFUSE_RAY, SPRITE_ANIM_2A, FRAMESET_041, PALETTE_102, NONE, SFX_3D, $00
; DUEL_ANIM_SING
	animation TILESET_NOTES, SPRITE_ANIM_2B, FRAMESET_042, PALETTE_103, NONE, SFX_3E, $00
; DUEL_ANIM_SUPERSONIC
	animation TILESET_SOUND, SPRITE_ANIM_2C, FRAMESET_043, PALETTE_104, NONE, SFX_3F, $00
; DUEL_ANIM_PETAL_DANCE
	animation TILESET_PETAL, SPRITE_ANIM_2D, FRAMESET_044, PALETTE_105, SPRITE_ANIM_FLAG_CENTERED, SFX_40, $00
; DUEL_ANIM_PROTECT
	animation TILESET_PROTECT, SPRITE_ANIM_2E, FRAMESET_045, PALETTE_106, NONE, SFX_41, $00
; DUEL_ANIM_BARRIER
	animation TILESET_BARRIER, SPRITE_ANIM_2F, FRAMESET_046, PALETTE_107, NONE, SFX_42, $00
; DUEL_ANIM_SPEED
	animation TILESET_SPEED, SPRITE_ANIM_30, FRAMESET_047, PALETTE_108, SPRITE_ANIM_FLAG_CENTERED, SFX_43, $00
; DUEL_ANIM_WHIRLWIND
	animation TILESET_WHIRLWIND, SPRITE_ANIM_31, FRAMESET_048, PALETTE_109, NONE, SFX_44, $00
; DUEL_ANIM_CRY
	animation TILESET_SNIVEL, SPRITE_ANIM_32, FRAMESET_04A, PALETTE_10A, NONE, SFX_45, $00
; DUEL_ANIM_QUESTION_MARK
	animation TILESET_QUESTION_MARK, SPRITE_ANIM_33, FRAMESET_04B, PALETTE_10B, NONE, SFX_46, $00
; DUEL_ANIM_SELFDESTRUCT
	animation TILESET_EXPLOSION, SPRITE_ANIM_34, FRAMESET_04C, PALETTE_10C, NONE, SFX_47, $00
; DUEL_ANIM_BIG_SELFDESTRUCT_1
	animation TILESET_EXPLOSION, SPRITE_ANIM_34, FRAMESET_04D, PALETTE_10C, NONE, SFX_48, $00
; DUEL_ANIM_HEAL
	animation TILESET_HEAL, SPRITE_ANIM_35, FRAMESET_04F, PALETTE_10D, NONE, SFX_49, $00
; DUEL_ANIM_DRAIN
	animation TILESET_DRAIN, SPRITE_ANIM_36, FRAMESET_051, PALETTE_10E, NONE, SFX_4A, $00
; DUEL_ANIM_DARK_GAS
	animation TILESET_GAS, SPRITE_ANIM_22, FRAMESET_039, PALETTE_10F, NONE, SFX_4B, $00
; DUEL_ANIM_BIG_SELFDESTRUCT_2
	animation TILESET_EXPLOSION, SPRITE_ANIM_34, FRAMESET_04E, PALETTE_10C, NONE, SFX_47, $00
; DUEL_ANIM_UNUSED_42
	animation TILESET_GLOW, SPRITE_ANIM_05, FRAMESET_006, PALETTE_0DD, SPRITE_ANIM_FLAG_UNSKIPPABLE, SFX_16, $00
; DUEL_ANIM_UNUSED_43
	animation TILESET_GLOW, SPRITE_ANIM_05, FRAMESET_007, PALETTE_0DD, SPRITE_ANIM_FLAG_UNSKIPPABLE, SFX_17, $00
; DUEL_ANIM_BENCH_THUNDER
	animation TILESET_THUNDER, SPRITE_ANIM_07, FRAMESET_015, PALETTE_0DF, NONE, SFX_18, $00
; DUEL_ANIM_QUICKFREEZE
	animation TILESET_SNOW, SPRITE_ANIM_12, FRAMESET_025, PALETTE_0EA, SPRITE_ANIM_FLAG_CENTERED, SFX_24, $00
; DUEL_ANIM_BENCH_GLOW
	animation TILESET_SMALL_GLOW, SPRITE_ANIM_37, FRAMESET_052, PALETTE_110, SPRITE_ANIM_FLAG_UNSKIPPABLE, SFX_11, $00
; DUEL_ANIM_FIREGIVER_START
	animation TILESET_FIRE_BIRD, SPRITE_ANIM_0D, FRAMESET_01D, PALETTE_0E5, SPRITE_ANIM_FLAG_CENTERED, SFX_5C, $00
; DUEL_ANIM_UNUSED_48
	animation TILESET_FIRE_BIRD, SPRITE_ANIM_0D, FRAMESET_01E, PALETTE_0E5, SPRITE_ANIM_FLAG_CENTERED, NONE, $00
; DUEL_ANIM_HEALING_WIND
	animation TILESET_HEAL, SPRITE_ANIM_35, FRAMESET_050, PALETTE_10D, SPRITE_ANIM_FLAG_CENTERED, SFX_4C, $00
; DUEL_ANIM_BENCH_WHIRLWIND
	animation TILESET_WHIRLWIND, SPRITE_ANIM_31, FRAMESET_049, PALETTE_109, SPRITE_ANIM_FLAG_CENTERED, SFX_4D, $00
; DUEL_ANIM_EXPAND
	animation TILESET_EXPAND, SPRITE_ANIM_38, FRAMESET_053, PALETTE_111, NONE, SFX_4E, $00
; DUEL_ANIM_CAT_PUNCH
	animation TILESET_CAT_PUNCH, SPRITE_ANIM_39, FRAMESET_054, PALETTE_112, NONE, SFX_4F, $00
; DUEL_ANIM_THUNDER_WAVE
	animation TILESET_ELECTRIC_WAVE, SPRITE_ANIM_3A, FRAMESET_055, PALETTE_113, NONE, SFX_50, $00
; DUEL_ANIM_FIREGIVER_PLAYER
	animation TILESET_FIRE_BIRD, SPRITE_ANIM_0D, FRAMESET_01F, PALETTE_0E5, SPRITE_ANIM_FLAG_CENTERED, SFX_51, $00
; DUEL_ANIM_FIREGIVER_OPP
	animation TILESET_FIRE_BIRD, SPRITE_ANIM_0D, FRAMESET_020, PALETTE_0E5, SPRITE_ANIM_FLAG_CENTERED, SFX_51, $00
; DUEL_ANIM_UNUSED_50
	animation TILESET_CARD, SPRITE_ANIM_5C, FRAMESET_079, PALETTE_135, SPRITE_ANIM_FLAG_CENTERED | SPRITE_ANIM_FLAG_UNSKIPPABLE, NONE, $00
; DUEL_ANIM_PLAYER_SHUFFLE
	animation TILESET_CARD, SPRITE_ANIM_5C, FRAMESET_07A, PALETTE_135, SPRITE_ANIM_FLAG_CENTERED | SPRITE_ANIM_FLAG_UNSKIPPABLE, SFX_07, $00
; DUEL_ANIM_OPP_SHUFFLE
	animation TILESET_CARD, SPRITE_ANIM_5C, FRAMESET_07B, PALETTE_135, SPRITE_ANIM_FLAG_CENTERED | SPRITE_ANIM_FLAG_UNSKIPPABLE, SFX_07, $00
; DUEL_ANIM_BOTH_SHUFFLE
	animation TILESET_CARD, SPRITE_ANIM_5C, FRAMESET_07C, PALETTE_135, SPRITE_ANIM_FLAG_CENTERED | SPRITE_ANIM_FLAG_UNSKIPPABLE, SFX_07, $00
; DUEL_ANIM_UNUSED_54
	animation TILESET_CARD, SPRITE_ANIM_5C, FRAMESET_07D, PALETTE_135, SPRITE_ANIM_FLAG_CENTERED | SPRITE_ANIM_FLAG_UNSKIPPABLE, NONE, $00
; DUEL_ANIM_BOTH_DRAW
	animation TILESET_CARD, SPRITE_ANIM_5C, FRAMESET_07E, PALETTE_135, SPRITE_ANIM_FLAG_CENTERED | SPRITE_ANIM_FLAG_UNSKIPPABLE, NONE, $00
; DUEL_ANIM_PLAYER_DRAW
	animation TILESET_CARD, SPRITE_ANIM_5C, FRAMESET_07F, PALETTE_135, SPRITE_ANIM_FLAG_CENTERED | SPRITE_ANIM_FLAG_UNSKIPPABLE, NONE, $00
; DUEL_ANIM_OPP_DRAW
	animation TILESET_CARD, SPRITE_ANIM_5C, FRAMESET_080, PALETTE_135, SPRITE_ANIM_FLAG_CENTERED | SPRITE_ANIM_FLAG_UNSKIPPABLE, NONE, $00
; DUEL_ANIM_COIN_SPIN
	animation TILESET_TCG1_PIKACHU_COIN, SPRITE_ANIM_5D, FRAMESET_082, PALETTE_136, SPRITE_ANIM_FLAG_CENTERED | SPRITE_ANIM_FLAG_UNSKIPPABLE, NONE, $00
; DUEL_ANIM_COIN_TOSS1
	animation TILESET_TCG1_PIKACHU_COIN, SPRITE_ANIM_5D, FRAMESET_083, PALETTE_136, SPRITE_ANIM_FLAG_CENTERED | SPRITE_ANIM_FLAG_UNSKIPPABLE, SFX_0B, $00
; DUEL_ANIM_COIN_TOSS2
	animation TILESET_TCG1_PIKACHU_COIN, SPRITE_ANIM_5D, FRAMESET_084, PALETTE_136, SPRITE_ANIM_FLAG_CENTERED | SPRITE_ANIM_FLAG_UNSKIPPABLE, SFX_0B, $00
; DUEL_ANIM_COIN_TAILS
	animation TILESET_TCG1_PIKACHU_COIN, SPRITE_ANIM_5D, FRAMESET_085, PALETTE_136, SPRITE_ANIM_FLAG_CENTERED | SPRITE_ANIM_FLAG_UNSKIPPABLE, NONE, $00
; DUEL_ANIM_COIN_HEADS
	animation TILESET_TCG1_PIKACHU_COIN, SPRITE_ANIM_5D, FRAMESET_086, PALETTE_136, SPRITE_ANIM_FLAG_CENTERED | SPRITE_ANIM_FLAG_UNSKIPPABLE, NONE, $00
; DUEL_ANIM_DUEL_WIN
	animation TILESET_DUEL_RESULT, SPRITE_ANIM_5E, FRAMESET_087, PALETTE_137, SPRITE_ANIM_FLAG_CENTERED | SPRITE_ANIM_FLAG_UNSKIPPABLE, NONE, $00
; DUEL_ANIM_DUEL_LOSS
	animation TILESET_DUEL_RESULT, SPRITE_ANIM_5E, FRAMESET_088, PALETTE_137, SPRITE_ANIM_FLAG_CENTERED | SPRITE_ANIM_FLAG_UNSKIPPABLE, NONE, $00
; DUEL_ANIM_DUEL_DRAW
	animation TILESET_DUEL_RESULT, SPRITE_ANIM_5E, FRAMESET_089, PALETTE_137, SPRITE_ANIM_FLAG_CENTERED | SPRITE_ANIM_FLAG_UNSKIPPABLE, NONE, $00
; DUEL_ANIM_UNUSED_60
	animation TILESET_CARD, SPRITE_ANIM_5C, FRAMESET_081, PALETTE_135, SPRITE_ANIM_FLAG_CENTERED | SPRITE_ANIM_FLAG_UNSKIPPABLE, NONE, $00
; DUEL_ANIM_61
	animation TILESET_HIT, SPRITE_ANIM_00, FRAMESET_000, PALETTE_0D8, SPRITE_ANIM_FLAG_UNSKIPPABLE, SFX_2E, $00
; DUEL_ANIM_62
	animation TILESET_HIT, SPRITE_ANIM_00, FRAMESET_000, PALETTE_0D8, SPRITE_ANIM_FLAG_UNSKIPPABLE, SFX_2E, $00
; DUEL_ANIM_63
	animation TILESET_HIT, SPRITE_ANIM_00, FRAMESET_000, PALETTE_0D8, SPRITE_ANIM_FLAG_UNSKIPPABLE, SFX_2E, $00
; DUEL_ANIM_64
	animation TILESET_FIREBALLS, SPRITE_ANIM_3B, FRAMESET_056, PALETTE_114, SPRITE_ANIM_FLAG_X_FLIP | SPRITE_ANIM_FLAG_Y_FLIP | SPRITE_ANIM_FLAG_X_INVERTED | SPRITE_ANIM_FLAG_Y_INVERTED, SFX_64, $00
; DUEL_ANIM_65
	animation TILESET_FIREBALLS, SPRITE_ANIM_3B, FRAMESET_057, PALETTE_114, SPRITE_ANIM_FLAG_X_FLIP | SPRITE_ANIM_FLAG_Y_FLIP | SPRITE_ANIM_FLAG_X_INVERTED | SPRITE_ANIM_FLAG_Y_INVERTED, SFX_65, $00
; DUEL_ANIM_66
	animation TILESET_BENCH_MANIP, SPRITE_ANIM_3C, FRAMESET_058, PALETTE_115, SPRITE_ANIM_FLAG_Y_FLIP | SPRITE_ANIM_FLAG_CENTERED | SPRITE_ANIM_FLAG_Y_INVERTED, SFX_66, $00
; DUEL_ANIM_67
	animation TILESET_PSYCHIC_BEAM, SPRITE_ANIM_3D, FRAMESET_059, PALETTE_116, SPRITE_ANIM_FLAG_Y_FLIP | SPRITE_ANIM_FLAG_Y_INVERTED, SFX_67, $00
; DUEL_ANIM_68
	animation TILESET_BENCH_PSYCHIC_BEAM, SPRITE_ANIM_3E, FRAMESET_05A, PALETTE_117, SPRITE_ANIM_FLAG_Y_FLIP | SPRITE_ANIM_FLAG_3 | SPRITE_ANIM_FLAG_Y_INVERTED, SFX_68, $00
; DUEL_ANIM_69
	animation TILESET_ROCK_THROW, SPRITE_ANIM_3F, FRAMESET_05B, PALETTE_118, NONE, SFX_69, $00
; DUEL_ANIM_6A
	animation TILESET_MEGA_PUNCH, SPRITE_ANIM_40, FRAMESET_05C, PALETTE_119, NONE, SFX_6A, $00
; DUEL_ANIM_6B
	animation TILESET_PSYPUNCH, SPRITE_ANIM_41, FRAMESET_05D, PALETTE_11A, NONE, SFX_6B, $00
; DUEL_ANIM_6C
	animation TILESET_SLUDGE_PUNCH, SPRITE_ANIM_42, FRAMESET_05E, PALETTE_11B, NONE, SFX_6C, $00
; DUEL_ANIM_6D
	animation TILESET_ICE_PUNCH, SPRITE_ANIM_43, FRAMESET_05F, PALETTE_11C, NONE, SFX_6D, $00
; DUEL_ANIM_6E
	animation TILESET_KICK, SPRITE_ANIM_44, FRAMESET_060, PALETTE_11D, NONE, SFX_6E, $00
; DUEL_ANIM_6F
	animation TILESET_TAIL_SLAP, SPRITE_ANIM_45, FRAMESET_061, PALETTE_11E, NONE, SFX_6F, $00
; DUEL_ANIM_70
	animation TILESET_TAIL_WHIP, SPRITE_ANIM_46, FRAMESET_062, PALETTE_11F, SPRITE_ANIM_FLAG_X_FLIP | SPRITE_ANIM_FLAG_X_INVERTED, SFX_70, $00
; DUEL_ANIM_71
	animation TILESET_SLAP, SPRITE_ANIM_47, FRAMESET_063, PALETTE_120, NONE, SFX_71, $00
; DUEL_ANIM_72
	animation TILESET_QUESTION_MARK_SMALL, SPRITE_ANIM_48, FRAMESET_064, PALETTE_121, NONE, SFX_72, $00
; DUEL_ANIM_73
	animation TILESET_SKULL_BASH, SPRITE_ANIM_49, FRAMESET_065, PALETTE_122, SPRITE_ANIM_FLAG_X_FLIP | SPRITE_ANIM_FLAG_X_INVERTED, SFX_73, $00
; DUEL_ANIM_74
	animation TILESET_COIN_HURL, SPRITE_ANIM_4A, FRAMESET_066, PALETTE_123, NONE, SFX_74, $00
; DUEL_ANIM_75
	animation TILESET_193, SPRITE_ANIM_4B, FRAMESET_068, PALETTE_124, SPRITE_ANIM_FLAG_8x16, SFX_75, $00
; DUEL_ANIM_76
	animation TILESET_FOLLOW_ME, SPRITE_ANIM_4C, FRAMESET_069, PALETTE_125, NONE, SFX_76, $00
; DUEL_ANIM_77
	animation TILESET_SWIFT, SPRITE_ANIM_4D, FRAMESET_06A, PALETTE_126, SPRITE_ANIM_FLAG_X_FLIP | SPRITE_ANIM_FLAG_X_INVERTED, SFX_77, $00
; DUEL_ANIM_78
	animation TILESET_3D_ATTACK, SPRITE_ANIM_4E, FRAMESET_06B, PALETTE_127, NONE, SFX_78, $00
; DUEL_ANIM_79
	animation TILESET_WATER_DROP, SPRITE_ANIM_0E, FRAMESET_021, PALETTE_0E6, SPRITE_ANIM_FLAG_CENTERED, SFX_79, $00
; DUEL_ANIM_7A
	animation TILESET_FOCUS_BLAST, SPRITE_ANIM_50, FRAMESET_06D, PALETTE_129, SPRITE_ANIM_FLAG_Y_FLIP | SPRITE_ANIM_FLAG_Y_INVERTED, SFX_7A, $00
; DUEL_ANIM_7B
	animation TILESET_FOCUS_BLAST_BENCH, SPRITE_ANIM_51, FRAMESET_06E, PALETTE_12A, SPRITE_ANIM_FLAG_Y_FLIP | SPRITE_ANIM_FLAG_3 | SPRITE_ANIM_FLAG_Y_INVERTED, SFX_7B, $00
; DUEL_ANIM_7C
	animation TILESET_BONE2, SPRITE_ANIM_52, FRAMESET_06F, PALETTE_12B, NONE, SFX_8C, $00
; DUEL_ANIM_7D
	animation TILESET_COIN_HURL, SPRITE_ANIM_4A, FRAMESET_067, PALETTE_123, NONE, SFX_8D, $00
; DUEL_ANIM_7E
	animation TILESET_BIG_SNORE, SPRITE_ANIM_53, FRAMESET_070, PALETTE_12C, NONE, SFX_8E, $00
; DUEL_ANIM_7F
	animation TILESET_RAZOR_LEAF, SPRITE_ANIM_54, FRAMESET_071, PALETTE_12D, SPRITE_ANIM_FLAG_X_FLIP | SPRITE_ANIM_FLAG_X_INVERTED, SFX_92, $00
; DUEL_ANIM_80
	animation TILESET_GUILLOTINE, SPRITE_ANIM_55, FRAMESET_072, PALETTE_12E, NONE, SFX_93, $00
; DUEL_ANIM_81
	animation TILESET_VINE_PULL, SPRITE_ANIM_56, FRAMESET_073, PALETTE_12F, SPRITE_ANIM_FLAG_X_FLIP | SPRITE_ANIM_FLAG_Y_FLIP | SPRITE_ANIM_FLAG_X_INVERTED | SPRITE_ANIM_FLAG_Y_INVERTED, SFX_94, $00
; DUEL_ANIM_82
	animation TILESET_PERPLEX, SPRITE_ANIM_57, FRAMESET_074, PALETTE_130, NONE, SFX_95, $00
; DUEL_ANIM_83
	animation TILESET_NINE_TAILS, SPRITE_ANIM_58, FRAMESET_075, PALETTE_131, NONE, SFX_96, $00
; DUEL_ANIM_84
	animation TILESET_BONE_HEADBUTT, SPRITE_ANIM_59, FRAMESET_076, PALETTE_132, SPRITE_ANIM_FLAG_X_FLIP | SPRITE_ANIM_FLAG_X_INVERTED, SFX_97, $00
; DUEL_ANIM_85
	animation TILESET_DRILL_DIVE, SPRITE_ANIM_5A, FRAMESET_077, PALETTE_133, SPRITE_ANIM_FLAG_X_FLIP | SPRITE_ANIM_FLAG_X_INVERTED, SFX_98, $00
; DUEL_ANIM_86
	animation TILESET_DARK_SONG, SPRITE_ANIM_5B, FRAMESET_078, PALETTE_134, SPRITE_ANIM_FLAG_X_FLIP | SPRITE_ANIM_FLAG_X_INVERTED, SFX_99, $00
