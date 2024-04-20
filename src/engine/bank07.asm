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
	call .CalculateDecimalDigits
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

.CalculateDecimalDigits:
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
	ld [wdc0f], a
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
	ld [wdc0f], a
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
	ld e, PORTRAITVARIANT_NORMAL
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

	call Func_1e419
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
	ld [wdc08 + 0], a
	ld [wdc08 + 1], a
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
	ld [wdc5e + 0], a
	ld [wdc5e + 1], a
	ld [wdce2], a
	ld [wdc59], a
	ld [wdce8], a
	ld [wDuelAnimLocationParam], a
	ld [wdcf0], a
	ld [wdc57], a
	ld a, $ff
	ld [wdcea], a
	xor a
	ld bc, $80
	ld hl, wdc60
	call WriteBCBytesToHL
	pop hl
	pop de
	pop bc
	pop af
	ret
; 0x1dff5

SECTION "Bank 7@6419", ROMX[$6419], BANK[$7]

Func_1e419:
	push af
	xor a
	ld [wdc0f], a
	pop af
	ret
; 0x1e420

SECTION "Bank 7@65a2", ROMX[$65a2], BANK[$7]

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
	ld e, PORTRAITVARIANT_NORMAL
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
