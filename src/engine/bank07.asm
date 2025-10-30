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
; a = indentation
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

GetPlayerPortrait::
	push bc
	push de
	push hl
	ld a, EVENT_PLAYER_GENDER
	farcall GetEventValue
	jr nz, .female
; male
	ld a, PORTRAIT_MARK
	jr .got_portrait
.female
	ld a, PORTRAIT_MINT
.got_portrait
	pop hl
	pop de
	pop bc
	ret

; converts *_PIC in a
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
	db PORTRAIT_MARK          ; MARK_PIC
	db PORTRAIT_MINT          ; MINT_PIC
	db PORTRAIT_MARK_LINK     ; MARK_LINK_PIC
	db PORTRAIT_MINT_LINK     ; MINT_LINK_PIC
	db PORTRAIT_RONALD        ; RONALD_PIC
	db PORTRAIT_SAM           ; SAM_PIC
	db PORTRAIT_AARON         ; AARON_PIC
	db PORTRAIT_ISHIHARA      ; ISHIHARA_PIC
	db PORTRAIT_IMAKUNI_BLACK ; IMAKUNI_BLACK_PIC
	db PORTRAIT_IMAKUNI_RED   ; IMAKUNI_RED_PIC
	db PORTRAIT_ISAAC         ; ISAAC_PIC
	db PORTRAIT_JENNIFER      ; JENNIFER_PIC
	db PORTRAIT_NICHOLAS      ; NICHOLAS_PIC
	db PORTRAIT_BRANDON       ; BRANDON_PIC
	db PORTRAIT_MURRAY        ; MURRAY_PIC
	db PORTRAIT_STEPHANIE     ; STEPHANIE_PIC
	db PORTRAIT_DANIEL        ; DANIEL_PIC
	db PORTRAIT_ROBERT        ; ROBERT_PIC
	db PORTRAIT_GENE          ; GENE_PIC
	db PORTRAIT_MATTHEW       ; MATTHEW_PIC
	db PORTRAIT_RYAN          ; RYAN_PIC
	db PORTRAIT_ANDREW        ; ANDREW_PIC
	db PORTRAIT_MITCH         ; MITCH_PIC
	db PORTRAIT_MICHAEL       ; MICHAEL_PIC
	db PORTRAIT_CHRIS         ; CHRIS_PIC
	db PORTRAIT_JESSICA       ; JESSICA_PIC
	db PORTRAIT_NIKKI         ; NIKKI_PIC
	db PORTRAIT_BRITTANY      ; BRITTANY_PIC
	db PORTRAIT_KRISTIN       ; KRISTIN_PIC
	db PORTRAIT_HEATHER       ; HEATHER_PIC
	db PORTRAIT_RICK          ; RICK_PIC
	db PORTRAIT_JOSEPH        ; JOSEPH_PIC
	db PORTRAIT_DAVID         ; DAVID_PIC
	db PORTRAIT_ERIK          ; ERIK_PIC
	db PORTRAIT_AMY           ; AMY_PIC
	db PORTRAIT_JOSHUA        ; JOSHUA_PIC
	db PORTRAIT_SARA          ; SARA_PIC
	db PORTRAIT_AMANDA        ; AMANDA_PIC
	db PORTRAIT_KEN           ; KEN_PIC
	db PORTRAIT_JOHN          ; JOHN_PIC
	db PORTRAIT_ADAM          ; ADAM_PIC
	db PORTRAIT_JONATHAN      ; JONATHAN_PIC
	db PORTRAIT_COURTNEY      ; COURTNEY_PIC
	db PORTRAIT_STEVE         ; STEVE_PIC
	db PORTRAIT_JACK          ; JACK_PIC
	db PORTRAIT_ROD           ; ROD_PIC
	db PORTRAIT_EIJI          ; EIJI_PIC
	db PORTRAIT_MAGICIAN      ; MAGICIAN_PIC
	db PORTRAIT_YUI           ; YUI_PIC
	db PORTRAIT_TOSHIRON      ; TOSHIRON_PIC
	db PORTRAIT_PIERROT       ; PIERROT_PIC
	db PORTRAIT_ANNA          ; ANNA_PIC
	db PORTRAIT_DEE           ; DEE_PIC
	db PORTRAIT_MASQUERADE    ; MASQUERADE_PIC
	db PORTRAIT_PAWN          ; PAWN_PIC
	db PORTRAIT_KNIGHT        ; KNIGHT_PIC
	db PORTRAIT_BISHOP        ; BISHOP_PIC
	db PORTRAIT_ROOK          ; ROOK_PIC
	db PORTRAIT_QUEEN         ; QUEEN_PIC
	db PORTRAIT_GR_1          ; GR_1_PIC
	db PORTRAIT_GR_2          ; GR_2_PIC
	db PORTRAIT_GR_3          ; GR_3_PIC
	db PORTRAIT_GR_4          ; GR_4_PIC
	db PORTRAIT_MIDORI        ; MIDORI_PIC
	db PORTRAIT_YUTA          ; YUTA_PIC
	db PORTRAIT_MIYUKI        ; MIYUKI_PIC
	db PORTRAIT_MORINO        ; MORINO_PIC
	db PORTRAIT_RENNA         ; RENNA_PIC
	db PORTRAIT_ICHIKAWA      ; ICHIKAWA_PIC
	db PORTRAIT_CATHERINE     ; CATHERINE_PIC
	db PORTRAIT_TAP           ; TAP_PIC
	db PORTRAIT_JES           ; JES_PIC
	db PORTRAIT_YUKI          ; YUKI_PIC
	db PORTRAIT_SHOKO         ; SHOKO_PIC
	db PORTRAIT_HIDERO        ; HIDERO_PIC
	db PORTRAIT_MIYAJIMA      ; MIYAJIMA_PIC
	db PORTRAIT_SENTA         ; SENTA_PIC
	db PORTRAIT_AIRA          ; AIRA_PIC
	db PORTRAIT_KANOKO        ; KANOKO_PIC
	db PORTRAIT_GODA          ; GODA_PIC
	db PORTRAIT_GRACE         ; GRACE_PIC
	db PORTRAIT_KAMIYA        ; KAMIYA_PIC
	db PORTRAIT_MIWA          ; MIWA_PIC
	db PORTRAIT_KEVIN         ; KEVIN_PIC
	db PORTRAIT_YOSUKE        ; YOSUKE_PIC
	db PORTRAIT_RYOKO         ; RYOKO_PIC
	db PORTRAIT_MAMI          ; MAMI_PIC
	db PORTRAIT_NISHIJIMA     ; NISHIJIMA_PIC
	db PORTRAIT_ISHII         ; ISHII_PIC
	db PORTRAIT_SAMEJIMA      ; SAMEJIMA_PIC
	db PORTRAIT_KANZAKI       ; KANZAKI_PIC
	db PORTRAIT_RUI           ; RUI_PIC
	db PORTRAIT_BIRURITCHI    ; BIRURITCHI_PIC
	db PORTRAIT_GR_X          ; GR_X_PIC
	db PORTRAIT_TOBICHAN      ; TOBICHAN_PIC
	db PORTRAIT_DR_MASON      ; DR_MASON_PIC
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
StartPalFadeToBlackOrWhite::
	ld [wPalFadeDirection], a
	ld a, b
	ld [wPaletteFadeSpeedMask], a
	call SaveTargetFadePals
	ld a, $02
	ld [wPaletteFadeMode], a
	ld a, 8
	ld [wPaletteFadeCounter], a
	ret

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
	farcall ResetActiveSpriteAnimFlag6WithinArea
	call DoFrame
	farcall CopyBGMapFromVRAMToWRAM
	pop de
	pop bc
	pop af
	ret

Func_1caf1:
	push af
	push bc
	push de
	farcall CopyBGMapFromWRAMToVRAM
	farcall SetActiveSpriteAnimFlag6WithinArea
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
	call DrawLabeledTextBoxVRAM0

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
	and PAD_UP
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
	and PAD_DOWN
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
	and PAD_LEFT
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
	and PAD_RIGHT
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

SetMenuBoxFocusedItem:
	ld [wMenuBoxFocusedItem], a
	ret

SetwDA37:
	push af
	ld a, 1
	ld [wda37], a
	pop af
	ret

SetMenuBoxNumItems:
	ld [wMenuBoxNumItems], a
	ret

SetMenuBoxDelay:
	ld [wMenuBoxDelay], a
	ret

GetGameCenterBankedChips:
	push af
	ld a, [wGameCenterBankedChips]
	ld c, a
	ld a, [wGameCenterBankedChips + 1]
	ld b, a
	pop af
	ret

WithdrawChips:
	push af
	push bc
	ld a, [wGameCenterBankedChips]
	ld c, a
	ld a, [wGameCenterBankedChips + 1]
	ld b, a
	farcall IncreaseChipsSmoothly
	xor a
	ld [wGameCenterBankedChips], a
	ld [wGameCenterBankedChips + 1], a
	pop bc
	pop af
	ret

DepositChips:
	push af
	push bc
	farcall GetGameCenterChips
	farcall DecreaseChipsSmoothly
	ld a, c
	ld [wGameCenterBankedChips], a
	ld a, b
	ld [wGameCenterBankedChips + 1], a
	pop bc
	pop af
	ret

Func_1cd63:
	farcall Func_1022a
	call ShowStartMenu
	farcall Func_10252
	ret

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
	call GetPlayerPortrait
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
	ldtx hl, TxRam1Text
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
	db PAD_A ; press keys
	db $00 ; held keys
	db FALSE ; has horizontal scroll
	db 0 ; vertical step
	dw StartMenuBoxUpdate ; update function
	dw NULL ; label text ID

	textitem 2, 2, MainMenuNewGameText
	db $ff ; end

.Config1Params
	db TRUE ; ?
	db 12, 6 ; width, height
	db SYM_CURSOR_R ; blink cursor symbol
	db SYM_SPACE ; space symbol
	db SYM_CURSOR_R ; default cursor symbol
	db SYM_CURSOR_R ; selection cursor symbol
	db PAD_A ; press keys
	db $00 ; held keys
	db FALSE ; has horizontal scroll
	db 1 ; vertical step
	dw StartMenuBoxUpdate ; update function
	dw NULL ; label text ID

	textitem 2, 2, MainMenuContinueFromDiaryText
	textitem 2, 4, MainMenuNewGameText
	db $ff ; end

.Config2Params
	db TRUE ; ?
	db 12, 8 ; width, height
	db SYM_CURSOR_R ; blink cursor symbol
	db SYM_SPACE ; space symbol
	db SYM_CURSOR_R ; default cursor symbol
	db SYM_CURSOR_R ; selection cursor symbol
	db PAD_A ; press keys
	db $00 ; held keys
	db FALSE ; has horizontal scroll
	db 1 ; vertical step
	dw StartMenuBoxUpdate ; update function
	dw NULL ; label text ID

	textitem 2, 2, MainMenuCardPopText
	textitem 2, 4, MainMenuContinueFromDiaryText
	textitem 2, 6, MainMenuNewGameText
	db $ff ; end

.Config3Params
	db TRUE ; ?
	db 12, 10 ; width, height
	db SYM_CURSOR_R ; blink cursor symbol
	db SYM_SPACE ; space symbol
	db SYM_CURSOR_R ; default cursor symbol
	db SYM_CURSOR_R ; selection cursor symbol
	db PAD_A ; press keys
	db $00 ; held keys
	db FALSE ; has horizontal scroll
	db 1 ; vertical step
	dw StartMenuBoxUpdate ; update function
	dw NULL ; label text ID

	textitem 2, 2, MainMenuCardPopText
	textitem 2, 4, MainMenuContinueFromDiaryText
	textitem 2, 6, MainMenuNewGameText
	textitem 2, 8, MainMenuContinueDuelText
	db $ff ; end

.Config4Params
	db TRUE ; ?
	db 12, 8 ; width, height
	db SYM_CURSOR_R ; blink cursor symbol
	db SYM_SPACE ; space symbol
	db SYM_CURSOR_R ; default cursor symbol
	db SYM_CURSOR_R ; selection cursor symbol
	db PAD_A ; press keys
	db $00 ; held keys
	db FALSE ; has horizontal scroll
	db 1 ; vertical step
	dw StartMenuBoxUpdate ; update function
	dw NULL ; label text ID

	textitem 2, 2, MainMenuContinueFromDiaryText
	textitem 2, 4, MainMenuNewGameText
	textitem 2, 6, MainMenuContinueDuelText
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
	ldtx hl, MainMenuNewGameDialogText
	call Func_35af
	ret

.ContinueFromDiary:
	farcall GetCurrentLocationName
	call LoadTxRam2
	ldtx hl, TxRam2TextPadded
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
	textitem  3, 12, PlayerDiaryEventCoinText
	textitem 15, 12, PlayerDiaryCardsUnitText
	textitem  3, 14, PlayerDiaryAlbumText
	textitem  3, 16, PlayerDiaryPlayTimeText
	db $ff

.CardPop:
	lb de, 1, 12
	ldtx hl, MainMenuCardPopDialogText
	call Func_35af
	ret

.ContinueDuel:
	lb de, 1, 12
	ldtx hl, MainMenuContinueDuelDialogText
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
	ldtx hl, MainMenuNewGameInsteadOfContinueConfirmPromptText
	ld a, $1 ; "no" selected by default
	farcall DrawWideTextBox_PrintTextWithYesOrNoMenu
	jr c, .fade_out
	farcall Func_e97a
	ldtx hl, MainMenuNewGameInsteadOfContinueDeletedText
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
	tx MainMenuNewGameInsteadOfContinueWarning1Text
	tx MainMenuNewGameInsteadOfContinueWarning2Text
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
	ldtx hl, MainMenuContinueFromDiaryInsteadOfDuelConfirmText
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
	tx MainMenuContinueFromDiaryInsteadOfDuelWarning1Text
	tx MainMenuContinueFromDiaryInsteadOfDuelWarning2Text
	tx MainMenuContinueFromDiaryInsteadOfDuelWarning3Text
	tx MainMenuContinueFromDiaryInsteadOfDuelWarning4Text
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
	ldtx hl, TxRam1Text
	lb de, 5, 4
	call Func_35bf
	; print gender
	farcall GetPlayerGender
	and a
	ldtx hl, PlayerGenderMaleText
	jr z, .got_gender_text
	ldtx hl, PlayerGenderFemaleText
.got_gender_text
	lb de, 5, 8
	call Func_35af
	ret

.TextItems:
	textitem 2, 2, PlayerDiaryNameText
	textitem 2, 6, PlayerGenderText
	db $ff

.ShowYesOrNoMenu:
	ldtx hl, IsThisOKText_2
	ld a, $1
	farcall DrawWideTextBox_PrintTextWithYesOrNoMenu
	ret

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
	db EVENT_GOT_GOLBAT_COIN     ; COIN_GOLBAT
	db EVENT_GOT_MAGNEMITE_COIN  ; COIN_MAGNEMITE
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
	jr z, .got_coin
	inc b
.got_coin
	pop af
	inc a
	dec c
	jr nz, .loop
	ld a, b
	and a
	pop hl
	pop bc
	ret

; return in a the total number of pieces in possession
CountGRCoinPiecesObtained_2:
	push bc
	ld c, 0
	ld a, EVENT_GOT_GR_COIN_PIECE_BOTTOM_RIGHT
	farcall GetEventValue
	jr z, .checked_bottom_right
	inc c
.checked_bottom_right
	ld a, EVENT_GOT_GR_COIN_PIECE_BOTTOM_LEFT
	farcall GetEventValue
	jr z, .checked_bottom_left
	inc c
.checked_bottom_left
	ld a, EVENT_GOT_GR_COIN_PIECE_TOP_RIGHT
	farcall GetEventValue
	jr z, .checked_top_right
	inc c
.checked_top_right
	ld a, EVENT_GOT_GR_COIN_PIECE_TOP_LEFT
	farcall GetEventValue
	jr z, .checked_top_left
	inc c
.checked_top_left
	ld a, c
	pop bc
	ret

; return in hl the coin text at .CoinTable[a]
GetCoinName:
	push af
	push bc
	ld c, a
	ld b, 0
	sla c
	rl b
	ld hl, .CoinTable
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	pop bc
	pop af
	ret

.CoinTable:
	tx ChanseyCoinText     ; COIN_CHANSEY
	tx GRCoinText          ; COIN_GR
	tx GrassCoinText       ; COIN_ODDISH
	tx FireCoinText        ; COIN_CHARMANDER
	tx WaterCoinText       ; COIN_STARMIE
	tx LightningCoinText   ; COIN_PIKACHU
	tx PsychicCoinText     ; COIN_ALAKAZAM
	tx RockCoinText        ; COIN_KABUTO
	tx GRGrassCoinText     ; COIN_GOLBAT
	tx GRLightningCoinText ; COIN_MAGNEMITE
	tx GRFireCoinText      ; COIN_MAGMAR
	tx GRWaterCoinText     ; COIN_PSYDUCK
	tx GRFightingCoinText  ; COIN_MACHAMP
	tx GRPsychicCoinText   ; COIN_MEW
	tx GRColorlessCoinText ; COIN_SNORLAX
	tx GRKingCoinText      ; COIN_TOGEPI
	tx PonytaCoinText      ; COIN_PONYTA
	tx HorseaCoinText      ; COIN_HORSEA
	tx ArbokCoinText       ; COIN_ARBOK
	tx JigglypuffCoinText  ; COIN_JIGGLYPUFF
	tx DugtrioCoinText     ; COIN_DUGTRIO
	tx GengarCoinText      ; COIN_GENGAR
	tx RaichuCoinText      ; COIN_RAICHU
	tx LugiaCoinText       ; COIN_LUGIA
	tx GRCoinText          ; COIN_GR_START
	tx GRCoinPiece1Text    ; COIN_GR_PIECE1
	tx GRCoinPiece2Text    ; COIN_GR_PIECE2
	tx GRCoinText          ; COIN_GR_PIECE1 | COIN_GR_PIECE2
	tx GRCoinPiece3Text    ; COIN_GR_PIECE3
	tx GRCoinText          ; COIN_GR_PIECE1 | COIN_GR_PIECE3
	tx GRCoinText          ; COIN_GR_PIECE2 | COIN_GR_PIECE3
	tx GRCoinText          ; COIN_GR_PIECE1 | COIN_GR_PIECE2 | COIN_GR_PIECE3
	tx GRCoinPiece4Text    ; COIN_GR_PIECE4
	tx GRCoinText          ; COIN_GR_PIECE1 | COIN_GR_PIECE4
	tx GRCoinText          ; COIN_GR_PIECE2 | COIN_GR_PIECE4
	tx GRCoinText          ; COIN_GR_PIECE1 | COIN_GR_PIECE2 | COIN_GR_PIECE4
	tx GRCoinText          ; COIN_GR_PIECE3 | COIN_GR_PIECE4
	tx GRCoinText          ; COIN_GR_PIECE1 | COIN_GR_PIECE3 | COIN_GR_PIECE4
	tx GRCoinText          ; COIN_GR_PIECE2 | COIN_GR_PIECE3 | COIN_GR_PIECE4
	; no COIN_GR_PIECE1 | COIN_GR_PIECE2 | COIN_GR_PIECE3 | COIN_GR_PIECE4

; set bit 0--3 of a for each piece obtained
CheckObtainedGRCoinPieces:
	push bc
	push de
	ld b, 0
	ld a, EVENT_GOT_GR_COIN_PIECE_BOTTOM_RIGHT
	farcall GetEventValue
	sla a
	sla a
	sla a
	or b
	ld b, a
	ld a, EVENT_GOT_GR_COIN_PIECE_BOTTOM_LEFT
	farcall GetEventValue
	sla a
	sla a
	or b
	ld b, a
	ld a, EVENT_GOT_GR_COIN_PIECE_TOP_RIGHT
	farcall GetEventValue
	sla a
	or b
	ld b, a
	ld a, EVENT_GOT_GR_COIN_PIECE_TOP_LEFT
	farcall GetEventValue
	or b
	and COIN_GR_PIECE1 | COIN_GR_PIECE2 | COIN_GR_PIECE3 | COIN_GR_PIECE4
	pop de
	pop bc
	ret

; a = COIN_* constant
; for a non-GR Coin, keep a if already obtained, return a = COIN_GR_START if not
; for GR Coin, return a = (bit 0--3 for each piece) + COIN_GR_START
GetCoinPossessionStatus:
	push bc
	ld b, a
	cp COIN_GR
	jr z, .check_gr_coin
; another coin
	call CheckIfCoinWasObtained
	jr nz, .got_value
; not yet obtained
	ld b, COIN_GR_START
.got_value
	ld a, b
	jr .done
.check_gr_coin
	call CheckObtainedGRCoinPieces
	add COIN_GR_START
.done
	pop bc
	ret

; input:
; - a = COIN_* constant
; - de = coordinates
CreateCoinAnimation:
	push af
	push bc
	push de
	push hl
	ld c, a
	ld b, 0
REPT 3 ; *8
	sla c
	rl b
ENDR
	ld hl, .SpriteAnimGfxParams
	add hl, bc
	ld c, 0
	cp NUM_COIN_GFX
	jr c, .got_obj_slot
	ld c, 2
.got_obj_slot
	ld b, BANK(.SpriteAnimGfxParams)
	ld a, $ff
	call CreateSpriteAnim
	pop hl
	pop de
	pop bc
	pop af
	ret

.SpriteAnimGfxParams:
	dw TILESET_CHANSEY_COIN,    SPRITE_ANIM_85, FRAMESET_112, PALETTE_13C ; COIN_CHANSEY
	dw TILESET_GR_COIN,         SPRITE_ANIM_85, FRAMESET_112, PALETTE_143 ; COIN_GR
	dw TILESET_ODDISH_COIN,     SPRITE_ANIM_85, FRAMESET_112, PALETTE_13D ; COIN_ODDISH
	dw TILESET_CHARMANDER_COIN, SPRITE_ANIM_85, FRAMESET_112, PALETTE_13E ; COIN_CHARMANDER
	dw TILESET_STARMIE_COIN,    SPRITE_ANIM_85, FRAMESET_112, PALETTE_13F ; COIN_STARMIE
	dw TILESET_PIKACHU_COIN,    SPRITE_ANIM_85, FRAMESET_112, PALETTE_140 ; COIN_PIKACHU
	dw TILESET_ALAKAZAM_COIN,   SPRITE_ANIM_85, FRAMESET_112, PALETTE_141 ; COIN_ALAKAZAM
	dw TILESET_KABUTO_COIN,     SPRITE_ANIM_85, FRAMESET_112, PALETTE_142 ; COIN_KABUTO
	dw TILESET_GOLBAT_COIN,     SPRITE_ANIM_85, FRAMESET_112, PALETTE_144 ; COIN_GOLBAT
	dw TILESET_MAGNEMITE_COIN,  SPRITE_ANIM_85, FRAMESET_112, PALETTE_145 ; COIN_MAGNEMITE
	dw TILESET_MAGMAR_COIN,     SPRITE_ANIM_85, FRAMESET_112, PALETTE_146 ; COIN_MAGMAR
	dw TILESET_PSYDUCK_COIN,    SPRITE_ANIM_85, FRAMESET_112, PALETTE_147 ; COIN_PSYDUCK
	dw TILESET_MACHAMP_COIN,    SPRITE_ANIM_85, FRAMESET_112, PALETTE_148 ; COIN_MACHAMP
	dw TILESET_MEW_COIN,        SPRITE_ANIM_85, FRAMESET_112, PALETTE_149 ; COIN_MEW
	dw TILESET_SNORLAX_COIN,    SPRITE_ANIM_85, FRAMESET_112, PALETTE_14A ; COIN_SNORLAX
	dw TILESET_TOGEPI_COIN,     SPRITE_ANIM_85, FRAMESET_112, PALETTE_14B ; COIN_TOGEPI
	dw TILESET_PONYTA_COIN,     SPRITE_ANIM_85, FRAMESET_112, PALETTE_14C ; COIN_PONYTA
	dw TILESET_HORSEA_COIN,     SPRITE_ANIM_85, FRAMESET_112, PALETTE_14D ; COIN_HORSEA
	dw TILESET_ARBOK_COIN,      SPRITE_ANIM_85, FRAMESET_112, PALETTE_14E ; COIN_ARBOK
	dw TILESET_JIGGLYPUFF_COIN, SPRITE_ANIM_85, FRAMESET_112, PALETTE_14F ; COIN_JIGGLYPUFF
	dw TILESET_DUGTRIO_COIN,    SPRITE_ANIM_85, FRAMESET_112, PALETTE_150 ; COIN_DUGTRIO
	dw TILESET_GENGAR_COIN,     SPRITE_ANIM_85, FRAMESET_112, PALETTE_151 ; COIN_GENGAR
	dw TILESET_RAICHU_COIN,     SPRITE_ANIM_85, FRAMESET_112, PALETTE_152 ; COIN_RAICHU
	dw TILESET_LUGIA_COIN,      SPRITE_ANIM_85, FRAMESET_112, PALETTE_153 ; COIN_LUGIA
	dw TILESET_GR_COIN,         SPRITE_ANIM_85, FRAMESET_112, PALETTE_13C ; COIN_GR_START
	dw TILESET_GR_PIECES,       SPRITE_ANIM_AC, FRAMESET_118, PALETTE_143 ; COIN_GR_PIECE1
	dw TILESET_GR_PIECES,       SPRITE_ANIM_AC, FRAMESET_119, PALETTE_143 ; COIN_GR_PIECE2
	dw TILESET_GR_COIN,         SPRITE_ANIM_85, FRAMESET_112, PALETTE_13C ; COIN_GR_PIECE1 | COIN_GR_PIECE2
	dw TILESET_GR_PIECES,       SPRITE_ANIM_AC, FRAMESET_11A, PALETTE_143 ; COIN_GR_PIECE3
	dw TILESET_GR_COIN,         SPRITE_ANIM_85, FRAMESET_112, PALETTE_13C ; COIN_GR_PIECE1 | COIN_GR_PIECE3
	dw TILESET_GR_COIN,         SPRITE_ANIM_85, FRAMESET_112, PALETTE_13C ; COIN_GR_PIECE2 | COIN_GR_PIECE3
	dw TILESET_GR_COIN,         SPRITE_ANIM_85, FRAMESET_112, PALETTE_13C ; COIN_GR_PIECE1 | COIN_GR_PIECE2 | COIN_GR_PIECE3
	dw TILESET_GR_PIECES,       SPRITE_ANIM_AC, FRAMESET_11B, PALETTE_143 ; COIN_GR_PIECE4
	dw TILESET_GR_COIN,         SPRITE_ANIM_85, FRAMESET_112, PALETTE_13C ; COIN_GR_PIECE1 | COIN_GR_PIECE4
	dw TILESET_GR_COIN,         SPRITE_ANIM_85, FRAMESET_112, PALETTE_13C ; COIN_GR_PIECE2 | COIN_GR_PIECE4
	dw TILESET_GR_COIN,         SPRITE_ANIM_85, FRAMESET_112, PALETTE_13C ; COIN_GR_PIECE1 | COIN_GR_PIECE2 | COIN_GR_PIECE4
	dw TILESET_GR_COIN,         SPRITE_ANIM_85, FRAMESET_112, PALETTE_13C ; COIN_GR_PIECE3 | COIN_GR_PIECE4
	dw TILESET_GR_COIN,         SPRITE_ANIM_85, FRAMESET_112, PALETTE_13C ; COIN_GR_PIECE1 | COIN_GR_PIECE3 | COIN_GR_PIECE4
	dw TILESET_GR_COIN,         SPRITE_ANIM_85, FRAMESET_112, PALETTE_13C ; COIN_GR_PIECE2 | COIN_GR_PIECE3 | COIN_GR_PIECE4
	dw TILESET_GR_COIN,         SPRITE_ANIM_85, FRAMESET_112, PALETTE_13C ; COIN_GR_PIECE1 | COIN_GR_PIECE2 | COIN_GR_PIECE3 | COIN_GR_PIECE4
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

; use FRAMESET_($112 + a)
SetAndInitCoinAnimation:
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
	farcall GetSpriteAnimBuffer
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
	farcall SetwD8A1
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
	call CopyCGBBGPalsFromSource_WithPalOffset
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

Func_1d52e:
	farcall Func_1022a
	call Func_1d53a
	farcall Func_10252
	ret

Func_1d53a:
	push af
	push bc
	push de
	push hl
	farcall SetFrameFuncAndFadeFromWhite
	farcall SetFadePalsFrameFunc
	call Func_3d1f
	farcall _ShowReceivedCardScreen
	call Func_3d32
	farcall UnsetFadePalsFrameFunc
	farcall FadeToWhiteAndUnsetFrameFunc
	pop hl
	pop de
	pop bc
	pop af
	ret
; 0x1d55d

SECTION "Bank 7@57a1", ROMX[$57a1], BANK[$7]

Func_1d7a1:
	xor a
	ld [wdb1f], a
	ret
; 0x1d7a6

SECTION "Bank 7@599e", ROMX[$599e], BANK[$7]

Func_1d99e:
	farcall Func_1022a
	call _PlayLinkDuelAndGetResult
	farcall Func_10252
	ret

_PlayLinkDuelAndGetResult:
	push bc
	push de
	push hl
	farcall _SetUpAndStartLinkDuel
	scf
	ccf
	ld a, [wDuelResult]
	and a
	jr z, .done
; set carry if DUEL_LOSS
	scf
.done
	pop hl
	pop de
	pop bc
	ret
; 0x1d9be

SECTION "Bank 7@59f9", ROMX[$59f9], BANK[$7]

Func_1d9f9:
	ld a, $04
	ld [wdc06], a
	ret
; 0x1d9ff

SECTION "Bank 7@5b63", ROMX[$5b63], BANK[$7]

GiveCoin:
	farcall Func_1022a
	call Func_1db6f
	farcall Func_10252
	ret

Func_1db6f:
	push af
	push bc
	push de
	push hl
	ld [wIncomingCoin], a
	call Func_1db81
	call Func_1dc0a
	pop hl
	pop de
	pop bc
	pop af
	ret

Func_1db81:
	farcall ClearSpriteAnimsAndSetInitialGraphicsConfiguration
	call DisableLCD
	call Func_1dbee
	call EnableLCD
	farcall SetFrameFuncAndFadeFromWhite
	call Func_3d0d
	ld a, [wIncomingCoin]
	cp COIN_GR_START
	jr c, .not_coin_gr
	ld a, COIN_GR
	ld [wIncomingCoin], a
	xor a
	jr .got_frames

.not_coin_gr
	push af
	ld a, SFX_0B
	call CallPlaySFX
	pop af
	ld a, 1
	call SetAndInitCoinAnimation
	ld a, 52

.got_frames
	ldtx hl, ObtainedCoinText
	farcall PrintTextInWideTextBox
	call DoAFrames_WithPreCheck
	push af
	ld a, MUSIC_MEDAL
	call Func_3d09
	pop af
	call WaitForSongToFinish
	ld a, 60
	call DoAFrames_WithPreCheck
	call Func_3d16
	call WaitForWideTextBoxInput
	farcall FadeToWhiteAndUnsetFrameFunc
	ld a, [wd693]
	set 0, a
	ld [wd693], a
	ld a, [wd693]
	res 2, a
	ld [wd693], a
	ld a, [wd693]
	res 1, a
	ld [wd693], a
	ret

Func_1dbee:
	ld a, [wIncomingCoin]
	lb de, 88, 88
	call CreateCoinAnimation
	lb de,  0, 12
	lb bc, 20,  6
	call DrawRegularTextBoxVRAM0
	ld a, [wIncomingCoin]
	call GetCoinName
	call LoadTxRam2
	ret

Func_1dc0a:
	farcall ClearSpriteAnimsAndSetInitialGraphicsConfiguration
	call Func_1dc52
	farcall SetFrameFuncAndFadeFromWhite
	xor a
	ld [wdc0b], a
.delay_loop
	call DoFrame
	call Func_1dc2a
	ldh a, [hKeysPressed]
	and PAD_A | PAD_B
	jr z, .delay_loop
	farcall FadeToWhiteAndUnsetFrameFunc
	ret

Func_1dc2a:
	ld a, [wdc0b]
	and $10
	push af
	call z, .asm_1dc3c
	pop af
	call nz, .asm_1dc47
	ld hl, wdc0b
	inc [hl]
	ret

.asm_1dc3c:
	ld a, [wIncomingCoin]
	call GetCoinPossessionStatus
	farcall Func_12c49b
	ret

.asm_1dc47:
	ld hl, 0
	lb bc, 3, 3
	farcall FillBoxInBGMapWithZero
	ret

Func_1dc52:
	lb de,  0, 0
	lb bc, 20, 8
	call DrawRegularTextBoxVRAM0
	call CountEventCoinsObtained
	ld l, a
	ld h, 0
	call LoadTxRam3
	ldtx hl, ObtainedCoinTotalNumberText
	ld a, [wIncomingCoin]
	cp COIN_GR
	jr nz, .got_coin_and_text

	call CheckObtainedGRCoinPieces
	cp $f
	jr z, .got_coin_and_text

	call CountGRCoinPiecesObtained_2
	ld l, a
	ld h, 0
	call LoadTxRam3
	ldtx hl, ObtainedGRCoinPieceTotalNumberText

.got_coin_and_text
	lb de, 1, 2
	call Func_35bf
	call Func_1dd08
	ld a, [wIncomingCoin]
	call GetCoinType
	push af
	ld a, b
	ld [wCoinPage], a
	pop af
	call Func_1dd89
	ret

Func_1dc9a:
	farcall Func_1022a
	call Func_1dca6
	farcall Func_10252
	ret

Func_1dca6:
	push af
	push bc
	push de
	push hl
	ld a, -1
	ld [wIncomingCoin], a
	call Func_1dcbf
	pop hl
	pop de
	pop bc
	pop af
	ret

Func_1dcb7:
	xor a
	ld [wSelectedCoin], a
	ld [wCoinPage], a
	ret

Func_1dcbf:
	farcall ClearSpriteAnimsAndSetInitialGraphicsConfiguration
	farcall ClearSpriteAnims
	call DisableLCD
	call Func_1dce3
	call EnableLCD
	farcall SetFrameFuncAndFadeFromWhite
	call Func_1deac
	push af
	ld a, SFX_02
	call CallPlaySFX
	pop af
	farcall FadeToWhiteAndUnsetFrameFunc
	ret

Func_1dce3:
	lb de,  0, 0
	lb bc, 20, 8
	call DrawRegularTextBoxVRAM0
	ldtx hl, PlayerCoinSelectText
	lb de,  1, 2
	call Func_35af
	ld a, [wSelectedCoin]
	call GetCoinType
	push af
	ld a, b
	ld [wCoinPage], a
	pop af
	call Func_1dd89
	call Func_1dd08
	ret

Func_1dd08:
	push af
	push bc
	push de
	push hl
	ld a, [wSelectedCoin]
	ldtx hl, PlayerStatusCurrentCoinText
	lb de,  4, 4
	call Func_35af
	lb de,  4, 6
	lb bc, 12, 1
	farcall FillBoxInBGMapWithZero
	call GetCoinName
	call Func_35af
	ld a, [wSelectedCoin]
	lb de,  1, 4
	farcall Func_12c49b
	call Func_1dd3a
	pop hl
	pop de
	pop bc
	pop af
	ret

; each coin settings page
Func_1dd3a:
	push af
	push bc
	push de
	push hl
	ld a, [wSelectedCoin]
	call GetCoinType
	ld c, a
	ld a, [wCoinPage]
	cp b
	jr z, .got_index
	ld c, 8
.got_index
	ld a, c
	add a
	ld c, a
	ld b, 0
	ld hl, .CoordTable
	add hl, bc
	ld d, [hl]
	inc hl
	ld e, [hl]
	ld b, BANK(.SpriteAnimGfxParams)
	ld hl, .SpriteAnimGfxParams
	ld a, 0
	ld c, 0
	call CreateSpriteAnim
	pop hl
	pop de
	pop bc
	pop af
	ret

.CoordTable:
	db   8,  88 ; $0
	db  48,  88 ; $1
	db  88,  88 ; $2
	db 128,  88 ; $3
	db   8, 120 ; $4
	db  48, 120 ; $5
	db  88, 120 ; $6
	db 128, 120 ; $7
	db 160, 160 ; $8

.SpriteAnimGfxParams:
	dw TILESET_WINDOW
	dw SPRITE_ANIM_9D
	dw FRAMESET_117
	dw PALETTE_16B

Func_1dd84:
	farcall ClearSpriteAnims
	ret

; coin settings pages
Func_1dd89:
	push af
	push bc
	push hl
	push af
	push bc
	lb de, 0, 10
	ld b, BANK(_CoinPageMenuParams)
	ld hl, _CoinPageMenuParams
	call LoadMenuBoxParams
	call DrawMenuBox
	pop bc
	push bc
	ld c, b
	ld b, 0
	sla c
	ld hl, _CoinPageTextTable
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	lb de, 6, 8
	call Func_35af
	pop bc
	push bc
	ld c, b
	ld b, 0
	sla c
	sla c
	ld hl, _CoinPageCoordTable
	add hl, bc
	ld d, [hl]
	inc hl
	ld e, [hl]
	lb bc, 0, 8
	call Func_383b
	inc hl
	ld d, [hl]
	inc hl
	ld e, [hl]
	lb bc, 19, 8
	call Func_383b
	pop bc
	call Func_1dd3a
	ld c, b
	ld b, 0
	sla c
	ld hl, _CoinPageListTable
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	pop af
	ld b, a
	ld a, 8
	sub b
	ld b, a
	ld c, 8
.loop_show_coin
	push bc
	push hl
	ld a, [hli]
	call GetCoinPossessionStatus
	ld d, [hl]
	inc hl
	ld e, [hl]
	farcall Func_12c49b
	ld a, c
	cp b
	jr nz, .next_coin
	ld a, d
	ld [wCoinPageXCoordinate], a
	ld a, e
	ld [wCoinPageYCoordinate], a
.next_coin
	pop hl
	ld bc, 3
	add hl, bc
	pop bc
	dec c
	jr nz, .loop_show_coin
	ld a, [wCoinPageXCoordinate]
	ld d, a
	ld a, [wCoinPageYCoordinate]
	ld e, a
	pop hl
	pop bc
	pop af
	ret

Func_1de16:
	call CheckObtainedGRCoinPieces
	add COIN_GR_START
	ret

_CoinPageMenuParams:
	db FALSE ; skip clear
	db 20, 7 ; width, height
	db SYM_CURSOR_R ; blink cursor symbol
	db SYM_SPACE ; space symbol
	db SYM_CURSOR_R ; default cursor symbol
	db SYM_CURSOR_R ; selection cursor symbol
	db PAD_A ; press keys
	db PAD_B ; held keys
	db TRUE ; has horizontal scroll
	db 4 ; vertical step
	dw Func_1def1 ; update function
	dw NULL ; label text ID

	textitem  1,  1, SingleSpaceText
	textitem  6,  1, SingleSpaceText
	textitem 11,  1, SingleSpaceText
	textitem 16,  1, SingleSpaceText
	textitem  1,  5, SingleSpaceText
	textitem  6,  5, SingleSpaceText
	textitem 11,  5, SingleSpaceText
	textitem 16,  5, SingleSpaceText
	db $ff

_CoinPageTextTable:
	tx EventCoinPage1Text
	tx EventCoinPage2Text
	tx EventCoinPage3Text

; see also: wCoinPageXCoordinate, wCoinPageYCoordinate
_CoinPageListTable:
	dw .page1
	dw .page2
	dw .page3
; coin, x, y
.page1:
	db COIN_CHANSEY,     1, 10
	db COIN_GR,          6, 10
	db COIN_ODDISH,     11, 10
	db COIN_CHARMANDER, 16, 10
	db COIN_STARMIE,     1, 14
	db COIN_PIKACHU,     6, 14
	db COIN_ALAKAZAM,   11, 14
	db COIN_KABUTO,     16, 14
.page2:
	db COIN_GOLBAT,      1, 10
	db COIN_MAGNEMITE,   6, 10
	db COIN_MAGMAR,     11, 10
	db COIN_PSYDUCK,    16, 10
	db COIN_MACHAMP,     1, 14
	db COIN_MEW,         6, 14
	db COIN_SNORLAX,    11, 14
	db COIN_TOGEPI,     16, 14
.page3:
	db COIN_PONYTA,      1, 10
	db COIN_HORSEA,      6, 10
	db COIN_ARBOK,      11, 10
	db COIN_JIGGLYPUFF, 16, 10
	db COIN_DUGTRIO,     1, 14
	db COIN_GENGAR,      6, 14
	db COIN_RAICHU,     11, 14
	db COIN_LUGIA,      16, 14

_CoinPageCoordTable:
	db  0,  0, 15, 0
	db 15, 32, 15, 0
	db 15, 32,  0, 0

Func_1deac:
	push af
	push bc
	push de
	push hl
	ld a, [wSelectedCoin]
.asm_1deb3
	call GetCoinType
	push af
	ld a, b
	ld [wCoinPage], a
	pop af
	call HandleMenuBox
	jr c, .asm_1dec6
	call Func_1decb
	jr .asm_1deb3
.asm_1dec6
	pop hl
	pop de
	pop bc
	pop af
	ret

; COIN_* constant at [wCoinPage] * 8 + a
Func_1decb:
	ld b, a
	ld a, [wCoinPage]
REPT 3 ; *8
	add a
ENDR
	add b
	ld b, a
	call CheckIfCoinWasObtained
	ld a, b
	jr nz, .exists
	push af
	ld a, SFX_04
	call CallPlaySFX
	pop af
	ret
.exists
	push af
	ld a, SFX_0B
	call CallPlaySFX
	pop af
	ld a, b
	ld [wSelectedCoin], a
	call Func_1dd08
	ret

Func_1def1::
	push af
	push bc
	push de
	push hl
	call Func_1df10
	call GetMenuBoxFocusedItem
	and 3
	and a
	call z, Func_1df60
	call GetMenuBoxFocusedItem
	and 3
	cp 3
	call z, Func_1df36
	pop hl
	pop de
	pop bc
	pop af
	ret

Func_1df10:
	ldh a, [hKeysPressed]
	and PAD_SELECT
	ret z

	push af
	ld a, SFX_01
	call CallPlaySFX
	pop af
	ld a, [wCoinPage]
	inc a
	cp 3
	jr c, .got_value
	xor a
.got_value
	ld [wCoinPage], a
	ld b, a
	call GetMenuBoxFocusedItem
	call Func_1df89
	call SetMenuBoxFocusedItem
	call SetwDA37
	ret

Func_1df36:
	ldh a, [hDPadHeld]
	and PAD_RIGHT
	ret z
	ld a, [wCoinPage]
	cp 2
	jr z, .done
	push af
	ld a, SFX_01
	call CallPlaySFX
	pop af
	ld a, [wCoinPage]
	inc a
	ld [wCoinPage], a
	ld b, a
	call GetMenuBoxFocusedItem
	sub 3
	call Func_1df89
	call SetMenuBoxFocusedItem
.done
	call SetwDA37
	ret

Func_1df60:
	ldh a, [hDPadHeld]
	and PAD_LEFT
	ret z

	ld a, [wCoinPage]
	and a
	jr z, .done
	push af
	ld a, SFX_01
	call CallPlaySFX
	pop af
	ld a, [wCoinPage]
	dec a
	ld [wCoinPage], a
	ld b, a
	call GetMenuBoxFocusedItem
	add 3
	call Func_1df89
	call SetMenuBoxFocusedItem
.done
	call SetwDA37
	ret

Func_1df89:
	call Func_1dd84
	push af
	ld a,  8
	ldh [hWX], a
	ld a, 80
	ldh [hWY], a
	call SetWindowOn
	pop af
	call DoFrame
	call Func_1dd89
	push af
	call SetWindowOff
	pop af
	ret

; a = COIN_* constant
; return its COIN_TYPE_* in a and b
GetCoinType:
	cp COIN_GR_START
	jr c, .found_coin
	ld a, COIN_GR
.found_coin
	ld b, a
	srl b
	srl b
	srl b
	and 7
	ret

Func_1dfb5:
	ld a, [wSelectedCoin]
	ret

Func_1dfb9::
	push af
	push bc
	push de
	push hl
	ld a, $01 ; unused
	farcall ClearSpriteAnims
	xor a
	farcall SetwD8A1
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
	farcall GetSpriteAnimBuffer
.loop_sprite_anims
	farcall Func_10ab7
	bit 7, a
	jr z, .next_sprite_anim
	farcall CheckIsSpriteAnimAnimating
	jr nz, .next_sprite_anim
	; clear animation
	farcall _ClearSpriteAnimFlags
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
	farcall LoadGfxPalettesFrom0
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
	farcall _ClearSpriteAnimFlags
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
	and SPRITE_ANIM_FLAG_X_FLIP | SPRITE_ANIM_FLAG_Y_FLIP
	farcall Func_10989
	bit SPRITE_ANIM_FLAG_Y_FLIP_F, a
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
	bit SPRITE_ANIM_FLAG_X_FLIP_F, a
	jr z, .asm_1e23e
	push af
	ld a, d
	add -8
	ld d, a
	pop af
.asm_1e23e
	and SPRITE_ANIM_FLAG_X_INVERTED | SPRITE_ANIM_FLAG_Y_INVERTED
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
	call CreateCoinAnimation
	ld a, [wCurAnimation]
	sub DUEL_ANIM_COIN_SPIN
	call SetAndInitCoinAnimation
	farcall GetSpriteAnimBuffer
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
	cp SPRITE_ANIM_FLAG_Y_INVERTED | SPRITE_ANIM_FLAG_CENTERED | SPRITE_ANIM_FLAG_Y_FLIP
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
	db  88, 56, SPRITE_ANIM_FLAG_Y_INVERTED | SPRITE_ANIM_FLAG_Y_FLIP ; $1

; animations in the Duel Main Scene
	db  40, 80, NONE ; $2
	db 136, 48, SPRITE_ANIM_FLAG_X_INVERTED | SPRITE_ANIM_FLAG_Y_INVERTED | SPRITE_ANIM_FLAG_X_FLIP | SPRITE_ANIM_FLAG_Y_FLIP ; $3

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
	farcall Stub_10cfe
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
	ld a, [wOpponentPicID]
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
	farcall PrintTextInWideTextBox

	call WaitForSongToFinish
	call WaitForWideTextBoxInput
	farcall FadeToWhiteAndUnsetFrameFunc
	pop hl
	pop de
	pop bc
	pop af
	ret

.DuelistIntroTextIDs
	tx DuelistIntroLightningClubMemberText
	tx DuelistIntroPsychicClubMemberText
	tx DuelistIntroRockClubMemberText
	tx DuelistIntroFightingClubMemberText
	tx DuelistIntroGrassClubMemberText
	tx DuelistIntroScienceClubMemberText
	tx DuelistIntroWaterClubMemberText
	tx DuelistIntroFireClubMemberText
	tx DuelistIntroLightingClubMasterText
	tx DuelistIntroPsychicClubMasterText
	tx DuelistIntroRockClubMasterText
	tx DuelistIntroFightingClubMasterText
	tx DuelistIntroGrassClubMasterText
	tx DuelistIntroScienceClubMasterText
	tx DuelistIntroWaterClubMasterText
	tx DuelistIntroFireClubMasterText
	tx DuelistIntroGrandMasterText
	tx DuelistIntroTechText
	tx DuelistIntroStrangeLifeFormText
	tx DuelistIntroCollectorText
	tx DuelistIntroRivalText
	tx DuelistIntroEnigmaticMaskText
	tx DuelistIntroGRGrassFortMemberText
	tx DuelistIntroGRLightningFortMemberText
	tx DuelistIntroGRFireFortMemberText
	tx DuelistIntroGRWaterFortMemberText
	tx DuelistIntroGRFightingFortMemberText
	tx DuelistIntroGRPsychicStrongholdMemberText
	tx DuelistIntroGRGrassFortLeaderText
	tx DuelistIntroGRLightningFortLeaderText
	tx DuelistIntroGRFireFortLeaderText
	tx DuelistIntroGRWaterFortLeaderText
	tx DuelistIntroGRFightingFortLeaderText
	tx DuelistIntroGRPsychicStrongholdLeaderText
	tx DuelistIntroColorlessAltarGuardianText
	tx DuelistIntroGRBigBossText
	tx DuelistIntroGRKingText
	tx DuelistIntroUntitledText
	tx DuelistIntroDungeonMasterText
	tx DuelistIntroGhostMasterText

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
	;  title, description
	dw NULL,  NULL ; NO_SPECIAL_RULE
	tx SpecialRuleChlorophyllTitleText,   SpecialRuleChlorophyllDescriptionText
	tx SpecialRuleThunderChargeTitleText, SpecialRuleThunderChargeDescriptionText
	tx SpecialRuleFlameArmorTitleText,    SpecialRuleFlameArmorDescriptionText
	tx SpecialRuleSmallBenchTitleText,    SpecialRuleSmallBenchDescriptionText
	tx SpecialRuleRunningWaterTitleText,  SpecialRuleRunningWaterDescriptionText
	tx SpecialRuleEarthPowerTitleText,    SpecialRuleEarthPowerDescriptionText
	tx SpecialRuleLowResistanceTitleText, SpecialRuleLowResistanceDescriptionText
	tx SpecialRuleEnergyReturnTitleText,  SpecialRuleEnergyReturnDescriptionText
	tx SpecialRuleToughEscapeTitleText,   SpecialRuleToughEscapeDescriptionText
	tx SpecialRuleBlackHoleTitleText,     SpecialRuleBlackHoleDescriptionText

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

SECTION "Bank 7@6866", ROMX[$6866], BANK[$7]

LoadBoosterPackScene:
	push af
	push bc
	push de
	push hl
	ld c, a
	ld b, 0
	ld hl, .SceneTable
	add hl, bc
	ld a, [hl]
	lb bc, 6, 0
	call LoadScene
	pop hl
	pop de
	pop bc
	pop af
	ret

.SceneTable:
	db SCENE_BEGINNING_PACK
	db SCENE_LEGENDARY_PACK
	db SCENE_FOSSIL_PACK
	db SCENE_PSYCHIC_PACK
	db SCENE_FLYING_PACK
	db SCENE_ROCKET_PACK
	db SCENE_AMBITION_PACK
	db SCENE_PRESENT_PACK
	db SCENE_INTRO_BASE_SET
	db SCENE_INTRO_JUNGLE
	db SCENE_INTRO_FOSSIL
	db SCENE_INTRO_TEAM_ROCKET

Func_1e889:
	farcall Func_1022a
	call GiveBoosterPacks
	farcall Func_10252
	ret

; a = BOOSTER_* constant, b = has-another count?
GiveBoosterPacks:
	push af
	push bc
	push de
	push hl
	ld [wCurBoosterPack], a
	ld a, b
	ld [wAnotherBoosterPack], a
	call _GiveBoosterPack
	pop hl
	pop de
	pop bc
	pop af
	ret

_GiveBoosterPack:
	farcall ClearSpriteAnimsAndSetInitialGraphicsConfiguration
	call .DrawScreen
	farcall SetFrameFuncAndFadeFromWhite
	call Func_3d0d
	push af
	ld a, MUSIC_BOOSTER_PACK
	call Func_3d09
	pop af
	ld a, [wCurBoosterPack]
	add a
	add a ; table_width 4
	ld c, a
	ld b, 0
	ld hl, .TextTable
	add hl, bc
	ld a, [hli]
	ld [wTxRam2], a
	ld a, [hli]
	ld [wTxRam2 + 1], a
	ld a, [hli]
	ld [wTxRam2_b], a
	ld a, [hl]
	ld [wTxRam2_b + 1], a
	ldtx hl, ReceivedBoosterPackText
	ld a, [wAnotherBoosterPack]
	and a
	jr z, .loaded_text
	ldtx hl, ReceivedAnotherBoosterPackText

.loaded_text
	farcall PrintTextInWideTextBox
	call WaitForSongToFinish
	ld a, 60
	call DoAFrames_WithPreCheck
	call Func_3d16
	call WaitForWideTextBoxInput
	ldtx hl, OpenedBoosterPackText
	farcall PrintScrollableText_NoTextBoxLabelVRAM0
	farcall UnsetSpriteAnimationAndFadePalsFrameFunc
	call .GetPack
	farcall SetSpriteAnimationAndFadePalsFrameFunc
	farcall FadeToWhiteAndUnsetFrameFunc
	ret

; pack number, title
.TextTable:
	tx BoosterPack1Text, BoosterPackBeginningPokemonText    ; BOOSTER_BEGINNING_POKEMON
	tx BoosterPack2Text, BoosterPackLegendaryPowerText      ; BOOSTER_LEGENDARY_POWER
	tx BoosterPack3Text, BoosterPackIslandOfFossilText      ; BOOSTER_ISLAND_OF_FOSSIL
	tx BoosterPack4Text, BoosterPackPsychicBattleText       ; BOOSTER_PSYCHIC_BATTLE
	tx BoosterPack5Text, BoosterPackFlyingPokemonText       ; BOOSTER_SKY_FLYING_POKEMON
	tx BoosterPack6Text, BoosterPackWeAreTeamRocketText     ; BOOSTER_WE_ARE_TEAM_ROCKET
	tx BoosterPack7Text, BoosterPackTeamRocketsAmbitionText ; BOOSTER_TEAM_ROCKETS_AMBITION
	tx SingleSpaceText,  DebugUnregisteredText              ; BOOSTER_DEBUG_1
	tx SingleSpaceText,  PresentPackText                    ; BOOSTER_PRESENT_PACK_1
	tx SingleSpaceText,  PresentPackText                    ; BOOSTER_PRESENT_PACK_2
	tx SingleSpaceText,  PresentPackText                    ; BOOSTER_PRESENT_PACK_3
	tx SingleSpaceText,  PresentPackText                    ; BOOSTER_PRESENT_PACK_4
	tx SingleSpaceText,  PresentPackText                    ; BOOSTER_PRESENT_PACK_5
	tx SingleSpaceText,  DebugUnregisteredText              ; BOOSTER_DEBUG_2

.DrawScreen:
	ld a, [wCurBoosterPack]
	ld c, a
	ld b, 0
	ld hl, .PackTable
	add hl, bc
	ld a, [hl]
	lb de,  6,  0
	call LoadBoosterPackScene
	lb de,  0, 12
	lb bc, 20,  6
	call DrawRegularTextBoxVRAM0
	ret

.PackTable:
	db BEGINNING_POKEMON     ; BOOSTER_BEGINNING_POKEMON
	db LEGENDARY_POWER       ; BOOSTER_LEGENDARY_POWER
	db ISLAND_OF_FOSSIL      ; BOOSTER_ISLAND_OF_FOSSIL
	db PSYCHIC_BATTLE        ; BOOSTER_PSYCHIC_BATTLE
	db SKY_FLYING_POKEMON    ; BOOSTER_SKY_FLYING_POKEMON
	db WE_ARE_TEAM_ROCKET    ; BOOSTER_WE_ARE_TEAM_ROCKET
	db TEAM_ROCKETS_AMBITION ; BOOSTER_TEAM_ROCKETS_AMBITION
	db BEGINNING_POKEMON     ; BOOSTER_DEBUG_1
	db PRESENT_PACK          ; BOOSTER_PRESENT_PACK_1
	db PRESENT_PACK          ; BOOSTER_PRESENT_PACK_2
	db PRESENT_PACK          ; BOOSTER_PRESENT_PACK_3
	db PRESENT_PACK          ; BOOSTER_PRESENT_PACK_4
	db PRESENT_PACK          ; BOOSTER_PRESENT_PACK_5
	db BEGINNING_POKEMON     ; BOOSTER_DEBUG_2

.GetPack:
	call DoFrame
	farcall ClearSpriteAnims
	call DisableLCD
	call DoFrame
	ld a, [wCurBoosterPack]
	farcall GetBoosterPack
	ret
; 0x1e984

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

SECTION "Bank 7@724e", ROMX[$724e], BANK[$7]

; input: a
; set carry if [wdd36] = wDD37_BUFFER_SIZE - 1
; else:
; - if bit 7 of a is 0, [wdd37 + [wdd36] ] = a
; - if bit 7 of a is 1,
;   (the first byte in wdd37[n] whose bit 7 is 0) = a
;   and shift the rest
; and increment [wdd36] by 1
Func_1f24e:
	push bc
	push de
	push hl
	ld e, a
	ld a, [wdd36]
	cp wDD37_BUFFER_SIZE - 1
	jr z, .set_carry
	bit 7, e
	call z, .not_bit7
	call nz, .has_bit7
	ld hl, wdd36
	inc [hl]
; clear carry
	scf
	ccf
	jr .done
.set_carry
	scf
; fallthrough
.done
	pop hl
	pop de
	pop bc
	ret

.not_bit7:
	push af
	ld a, [wdd36]
	ld c, a
	ld b, 0
	ld hl, wdd37
	add hl, bc
	ld [hl], e
	pop af
	ret

.has_bit7:
	push af
	ld hl, wdd37
	ld c, wDD37_BUFFER_SIZE - 1
.check_byte_loop
	bit 7, [hl]
	jr z, .shift_loop
	inc hl
	dec c
	jr nz, .check_byte_loop
.shift_loop
	ld b, [hl]
	ld [hl], e
	ld e, b
	inc hl
	dec c
	jr nz, .shift_loop
	pop af
	ret

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

; input: a, c
; set [wdd75] = a, [wdd76] = 0, [wdd77] = c
Set3FromwDD75:
	push af
	ld [wdd75], a
	ld a, c
	ld [wdd77], a
	xor a
	ld [wdd76], a
	pop af
	ret

; set [wdd75] = [wdd76] = 0, [wdd77] = c
Func_1f61a:
	push af
	ld a, 0
	call Set3FromwDD75
	push af
	ret

GetwDD75:
	ld a, [wdd75]
	and a
	ret
; 0x1f627

SECTION "Bank 7@77f1", ROMX[$77f1], BANK[$7]

Func_1f7f1:
	farcall Func_102a4
	call HandleIngameCardPop
	farcall Func_102c4
	ret

HandleIngameCardPop:
	push af
	push bc
	push de
	push hl
	ld hl, .FunctionMap
	call CallMappedFunction
	call StartFadeToWhite
	call WaitPalFading_Bank07
	pop hl
	pop de
	pop bc
	pop af
	ret

.FunctionMap:
	key_func SCRIPTED_CARD_POP_RONALD,       IngameCardPop.Ronald
	key_func SCRIPTED_CARD_POP_IMAKUNI,      IngameCardPop.Imakuni_first
	key_func SCRIPTED_RARE_CARD_POP_IMAKUNI, IngameCardPop.Imakuni_rare
	db $ff

; dupe of Func_1f7f1
Func_1f81f:
	farcall Func_102a4
	call HandleIngameCardPop
	farcall Func_102c4
	ret

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
	animation TILESET_BEAM, SPRITE_ANIM_15, FRAMESET_028, PALETTE_0ED, SPRITE_ANIM_FLAG_Y_INVERTED | SPRITE_ANIM_FLAG_Y_FLIP, SFX_27, $00
; DUEL_ANIM_HYPER_BEAM
	animation TILESET_HYPER_BEAM, SPRITE_ANIM_16, FRAMESET_029, PALETTE_0EE, SPRITE_ANIM_FLAG_Y_INVERTED | SPRITE_ANIM_FLAG_Y_FLIP, SFX_28, $00
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
	animation TILESET_STRETCH_KICK, SPRITE_ANIM_19, FRAMESET_02F, PALETTE_0F1, SPRITE_ANIM_FLAG_X_INVERTED | SPRITE_ANIM_FLAG_X_FLIP, SFX_2C, $00
; DUEL_ANIM_SLASH
	animation TILESET_SLASH, SPRITE_ANIM_1A, FRAMESET_030, PALETTE_0F2, NONE, SFX_2D, $00
; DUEL_ANIM_WHIP
	animation TILESET_VINE_WHIP, SPRITE_ANIM_1B, FRAMESET_032, PALETTE_0F3, NONE, SFX_2D, $00
; DUEL_ANIM_SONICBOOM
	animation TILESET_SONIC_BOOM, SPRITE_ANIM_1C, FRAMESET_033, PALETTE_0F4, NONE, SFX_2E, $00
; DUEL_ANIM_FURY_SWIPES
	animation TILESET_SLASH, SPRITE_ANIM_1A, FRAMESET_031, PALETTE_0F2, NONE, SFX_2F, $00
; DUEL_ANIM_DRILL
	animation TILESET_HORN_DRILL, SPRITE_ANIM_1D, FRAMESET_034, PALETTE_0F5, SPRITE_ANIM_FLAG_X_INVERTED | SPRITE_ANIM_FLAG_X_FLIP, SFX_30, $00
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
	animation TILESET_LURE, SPRITE_ANIM_28, FRAMESET_03F, PALETTE_100, SPRITE_ANIM_FLAG_X_INVERTED | SPRITE_ANIM_FLAG_X_FLIP, SFX_3B, $00
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
	animation TILESET_FIREBALLS, SPRITE_ANIM_3B, FRAMESET_056, PALETTE_114, SPRITE_ANIM_FLAG_X_INVERTED | SPRITE_ANIM_FLAG_Y_INVERTED | SPRITE_ANIM_FLAG_X_FLIP | SPRITE_ANIM_FLAG_Y_FLIP, SFX_64, $00
; DUEL_ANIM_65
	animation TILESET_FIREBALLS, SPRITE_ANIM_3B, FRAMESET_057, PALETTE_114, SPRITE_ANIM_FLAG_X_INVERTED | SPRITE_ANIM_FLAG_Y_INVERTED | SPRITE_ANIM_FLAG_X_FLIP | SPRITE_ANIM_FLAG_Y_FLIP, SFX_65, $00
; DUEL_ANIM_66
	animation TILESET_BENCH_MANIP, SPRITE_ANIM_3C, FRAMESET_058, PALETTE_115, SPRITE_ANIM_FLAG_Y_INVERTED | SPRITE_ANIM_FLAG_CENTERED | SPRITE_ANIM_FLAG_Y_FLIP, SFX_66, $00
; DUEL_ANIM_67
	animation TILESET_PSYCHIC_BEAM, SPRITE_ANIM_3D, FRAMESET_059, PALETTE_116, SPRITE_ANIM_FLAG_Y_INVERTED | SPRITE_ANIM_FLAG_Y_FLIP, SFX_67, $00
; DUEL_ANIM_68
	animation TILESET_BENCH_PSYCHIC_BEAM, SPRITE_ANIM_3E, FRAMESET_05A, PALETTE_117, SPRITE_ANIM_FLAG_Y_INVERTED | SPRITE_ANIM_FLAG_3 | SPRITE_ANIM_FLAG_Y_FLIP, SFX_68, $00
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
	animation TILESET_TAIL_WHIP, SPRITE_ANIM_46, FRAMESET_062, PALETTE_11F, SPRITE_ANIM_FLAG_X_INVERTED | SPRITE_ANIM_FLAG_X_FLIP, SFX_70, $00
; DUEL_ANIM_71
	animation TILESET_SLAP, SPRITE_ANIM_47, FRAMESET_063, PALETTE_120, NONE, SFX_71, $00
; DUEL_ANIM_72
	animation TILESET_QUESTION_MARK_SMALL, SPRITE_ANIM_48, FRAMESET_064, PALETTE_121, NONE, SFX_72, $00
; DUEL_ANIM_73
	animation TILESET_SKULL_BASH, SPRITE_ANIM_49, FRAMESET_065, PALETTE_122, SPRITE_ANIM_FLAG_X_INVERTED | SPRITE_ANIM_FLAG_X_FLIP, SFX_73, $00
; DUEL_ANIM_74
	animation TILESET_COIN_HURL, SPRITE_ANIM_4A, FRAMESET_066, PALETTE_123, NONE, SFX_74, $00
; DUEL_ANIM_75
	animation TILESET_193, SPRITE_ANIM_4B, FRAMESET_068, PALETTE_124, SPRITE_ANIM_FLAG_8x16, SFX_75, $00
; DUEL_ANIM_76
	animation TILESET_FOLLOW_ME, SPRITE_ANIM_4C, FRAMESET_069, PALETTE_125, NONE, SFX_76, $00
; DUEL_ANIM_77
	animation TILESET_SWIFT, SPRITE_ANIM_4D, FRAMESET_06A, PALETTE_126, SPRITE_ANIM_FLAG_X_INVERTED | SPRITE_ANIM_FLAG_X_FLIP, SFX_77, $00
; DUEL_ANIM_78
	animation TILESET_3D_ATTACK, SPRITE_ANIM_4E, FRAMESET_06B, PALETTE_127, NONE, SFX_78, $00
; DUEL_ANIM_79
	animation TILESET_WATER_DROP, SPRITE_ANIM_0E, FRAMESET_021, PALETTE_0E6, SPRITE_ANIM_FLAG_CENTERED, SFX_79, $00
; DUEL_ANIM_7A
	animation TILESET_FOCUS_BLAST, SPRITE_ANIM_50, FRAMESET_06D, PALETTE_129, SPRITE_ANIM_FLAG_Y_INVERTED | SPRITE_ANIM_FLAG_Y_FLIP, SFX_7A, $00
; DUEL_ANIM_7B
	animation TILESET_FOCUS_BLAST_BENCH, SPRITE_ANIM_51, FRAMESET_06E, PALETTE_12A, SPRITE_ANIM_FLAG_Y_INVERTED | SPRITE_ANIM_FLAG_3 | SPRITE_ANIM_FLAG_Y_FLIP, SFX_7B, $00
; DUEL_ANIM_7C
	animation TILESET_BONE2, SPRITE_ANIM_52, FRAMESET_06F, PALETTE_12B, NONE, SFX_8C, $00
; DUEL_ANIM_7D
	animation TILESET_COIN_HURL, SPRITE_ANIM_4A, FRAMESET_067, PALETTE_123, NONE, SFX_8D, $00
; DUEL_ANIM_7E
	animation TILESET_BIG_SNORE, SPRITE_ANIM_53, FRAMESET_070, PALETTE_12C, NONE, SFX_8E, $00
; DUEL_ANIM_7F
	animation TILESET_RAZOR_LEAF, SPRITE_ANIM_54, FRAMESET_071, PALETTE_12D, SPRITE_ANIM_FLAG_X_INVERTED | SPRITE_ANIM_FLAG_X_FLIP, SFX_92, $00
; DUEL_ANIM_80
	animation TILESET_GUILLOTINE, SPRITE_ANIM_55, FRAMESET_072, PALETTE_12E, NONE, SFX_93, $00
; DUEL_ANIM_81
	animation TILESET_VINE_PULL, SPRITE_ANIM_56, FRAMESET_073, PALETTE_12F, SPRITE_ANIM_FLAG_X_INVERTED | SPRITE_ANIM_FLAG_Y_INVERTED | SPRITE_ANIM_FLAG_X_FLIP | SPRITE_ANIM_FLAG_Y_FLIP, SFX_94, $00
; DUEL_ANIM_82
	animation TILESET_PERPLEX, SPRITE_ANIM_57, FRAMESET_074, PALETTE_130, NONE, SFX_95, $00
; DUEL_ANIM_83
	animation TILESET_NINE_TAILS, SPRITE_ANIM_58, FRAMESET_075, PALETTE_131, NONE, SFX_96, $00
; DUEL_ANIM_84
	animation TILESET_BONE_HEADBUTT, SPRITE_ANIM_59, FRAMESET_076, PALETTE_132, SPRITE_ANIM_FLAG_X_INVERTED | SPRITE_ANIM_FLAG_X_FLIP, SFX_97, $00
; DUEL_ANIM_85
	animation TILESET_DRILL_DIVE, SPRITE_ANIM_5A, FRAMESET_077, PALETTE_133, SPRITE_ANIM_FLAG_X_INVERTED | SPRITE_ANIM_FLAG_X_FLIP, SFX_98, $00
; DUEL_ANIM_86
	animation TILESET_DARK_SONG, SPRITE_ANIM_5B, FRAMESET_078, PALETTE_134, SPRITE_ANIM_FLAG_X_INVERTED | SPRITE_ANIM_FLAG_X_FLIP, SFX_99, $00
