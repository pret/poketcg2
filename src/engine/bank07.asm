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
	ld a, $00
	jr .asm_1c0fd
.female
	ld a, $01
.asm_1c0fd
	pop hl
	pop de
	pop bc
	ret

; converts a into PORTRAIT_* constant
Func_1c101::
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
	db PORTRAIT_00 ; $00
	db PORTRAIT_01 ; $01
	db PORTRAIT_02 ; $02
	db PORTRAIT_03 ; $03
	db PORTRAIT_04 ; $04
	db PORTRAIT_05 ; $05
	db PORTRAIT_06 ; $06
	db PORTRAIT_07 ; $07
	db PORTRAIT_5E ; $08
	db PORTRAIT_5F ; $09
	db PORTRAIT_08 ; $0a
	db PORTRAIT_09 ; $0b
	db PORTRAIT_0A ; $0c
	db PORTRAIT_0B ; $0d
	db PORTRAIT_0C ; $0e
	db PORTRAIT_0D ; $0f
	db PORTRAIT_0E ; $10
	db PORTRAIT_0F ; $11
	db PORTRAIT_10 ; $12
	db PORTRAIT_11 ; $13
	db PORTRAIT_12 ; $14
	db PORTRAIT_13 ; $15
	db PORTRAIT_14 ; $16
	db PORTRAIT_15 ; $17
	db PORTRAIT_16 ; $18
	db PORTRAIT_17 ; $19
	db PORTRAIT_18 ; $1a
	db PORTRAIT_19 ; $1b
	db PORTRAIT_1A ; $1c
	db PORTRAIT_1B ; $1d
	db PORTRAIT_1C ; $1e
	db PORTRAIT_1D ; $1f
	db PORTRAIT_1E ; $20
	db PORTRAIT_1F ; $21
	db PORTRAIT_20 ; $22
	db PORTRAIT_21 ; $23
	db PORTRAIT_22 ; $24
	db PORTRAIT_23 ; $25
	db PORTRAIT_24 ; $26
	db PORTRAIT_25 ; $27
	db PORTRAIT_26 ; $28
	db PORTRAIT_27 ; $29
	db PORTRAIT_28 ; $2a
	db PORTRAIT_29 ; $2b
	db PORTRAIT_2A ; $2c
	db PORTRAIT_2B ; $2d
	db PORTRAIT_2C ; $2e
	db PORTRAIT_2D ; $2f
	db PORTRAIT_2E ; $30
	db PORTRAIT_2F ; $31
	db PORTRAIT_30 ; $32
	db PORTRAIT_31 ; $33
	db PORTRAIT_32 ; $34
	db PORTRAIT_33 ; $35
	db PORTRAIT_34 ; $36
	db PORTRAIT_35 ; $37
	db PORTRAIT_36 ; $38
	db PORTRAIT_37 ; $39
	db PORTRAIT_38 ; $3a
	db PORTRAIT_39 ; $3b
	db PORTRAIT_3A ; $3c
	db PORTRAIT_3B ; $3d
	db PORTRAIT_3C ; $3e
	db PORTRAIT_3D ; $3f
	db PORTRAIT_3E ; $40
	db PORTRAIT_3F ; $41
	db PORTRAIT_40 ; $42
	db PORTRAIT_41 ; $43
	db PORTRAIT_42 ; $44
	db PORTRAIT_43 ; $45
	db PORTRAIT_44 ; $46
	db PORTRAIT_45 ; $47
	db PORTRAIT_46 ; $48
	db PORTRAIT_47 ; $49
	db PORTRAIT_48 ; $4a
	db PORTRAIT_49 ; $4b
	db PORTRAIT_4A ; $4c
	db PORTRAIT_4B ; $4d
	db PORTRAIT_4C ; $4e
	db PORTRAIT_4D ; $4f
	db PORTRAIT_4E ; $50
	db PORTRAIT_4F ; $51
	db PORTRAIT_50 ; $52
	db PORTRAIT_51 ; $53
	db PORTRAIT_52 ; $54
	db PORTRAIT_53 ; $55
	db PORTRAIT_54 ; $56
	db PORTRAIT_55 ; $57
	db PORTRAIT_56 ; $58
	db PORTRAIT_57 ; $59
	db PORTRAIT_58 ; $5a
	db PORTRAIT_59 ; $5b
	db PORTRAIT_5A ; $5c
	db PORTRAIT_5B ; $5d
	db PORTRAIT_5C ; $5e
	db PORTRAIT_5D ; $5f
; 0x1c116

SECTION "Bank 7@4395", ROMX[$4395], BANK[$7]

Func_1c395:
	call EnableSRAM
	call Func_1c3a8
	call Func_1c3b9
	call Func_1c3c7
	call Func_1c3ce
	call DisableSRAM
	ret

Func_1c3a8:
	ld a, [sTextSpeed]
	ld [wTextSpeed], a
	call Func_1c448
	ld b, a
	ld a, $04
	sub b
	ld [wd9d5], a
	ret

Func_1c3b9:
	ld a, [s0a007]
	ld [wd9d3], a
	srl a
	and $01
	ld [wdc0f], a
	ret

Func_1c3c7:
	ld a, [s0a00b]
	ld [wd9d4], a
	ret

Func_1c3ce:
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
	ld [s0a009], a
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

WaitPalFading:
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

SECTION "Bank 7@4b00", ROMX[$4b00], BANK[$7]

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
	jr nc, .asm_1cbf6
	add h ; warp around
.asm_1cbf6
	push af
	ld a, SFX_01
	call Func_3cfe
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
	jr c, .asm_1cc17
	sub h ; warp around
.asm_1cc17
	push af
	ld a, SFX_01
	call Func_3cfe
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
	jr nc, .asm_1cc33
	add h
.asm_1cc33
	push af
	ld a, SFX_01
	call Func_3cfe
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
	jr c, .asm_1cc50
	sub h
.asm_1cc50
	push af
	ld a, SFX_01
	call Func_3cfe
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
	call Func_3ab2

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
	call Func_1d0aa
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
	call Func_3cfe
	pop af
	ret
.selected
	push af
	ld a, SFX_03
	call Func_3cfe
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
	call WaitPalFading
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
	call WaitPalFading
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
	call WaitPalFading
	ld hl, .TextIDs
	call PrintScrollableTextFromList
	ldtx hl, Text078c
	ld a, $1 ; "no" selected by default
	farcall DrawWideTextBox_PrintTextWithYesOrNoMenu
	jr c, .fade_out ; unnecessary jump
.fade_out
	call StartFadeToWhite
	call WaitPalFading
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

Func_1d081:
	push bc
	push hl
	ld c, a
	ld b, $00
	ld hl, .EventIDs
	add hl, bc
	ld a, [hl]
	farcall GetEventValue
	pop hl
	pop bc
	ret

.EventIDs
	db EVENT_04
	db EVENT_0B
	db EVENT_05
	db EVENT_06
	db EVENT_07
	db EVENT_08
	db EVENT_09
	db EVENT_0A
	db EVENT_10
	db EVENT_11
	db EVENT_12
	db EVENT_13
	db EVENT_14
	db EVENT_15
	db EVENT_16
	db EVENT_17
	db EVENT_18
	db EVENT_19
	db EVENT_1A
	db EVENT_1B
	db EVENT_1C
	db EVENT_1D
	db EVENT_1E
	db EVENT_1F

Func_1d0aa:
	push bc
	push hl
	ld c, $18
	ld b, $00
	xor a
.asm_1d0b1
	push af
	call Func_1d081
	jr z, .asm_1d0b8
	inc b
.asm_1d0b8
	pop af
	inc a
	dec c
	jr nz, .asm_1d0b1
	ld a, b
	and a
	pop hl
	pop bc
	ret
; 0x1d0c2

SECTION "Bank 7@5475", ROMX[$5475], BANK[$7]

Func_1d475:
	ld hl, .FunctionMap
	call CallMappedFunction
	ret

.FunctionMap
	key_func $0, Func_1d485
	key_func $1, Func_1d4b9
	db $ff ; end

Func_1d485:
	ld a, PLAYER_MALE
	farcall SetPlayerGender
	ld a, EVENT_04
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
	call Func_1c395
	ret

Func_1d4b9:
	call Func_1c395
	ld a, $01
	farcall Func_108c9
	ret
; 0x1d4c3

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

Func_1dfb9:
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
	ld [wdce5], a
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

SECTION "Bank 7@78bd", ROMX[$78bd], BANK[$7]

PlayerGenderAndNameSelection::
	push af
	push bc
	push de
	push hl
.start
	farcall SetFadePalsFrameFunc
	call StartFadeToWhite
	call WaitPalFading
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
