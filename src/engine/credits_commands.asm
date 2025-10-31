_PlayCredits::
	push af
	push bc
	push de
	push hl
	call SetFrameFuncAndFadeFromWhite
	call .Play
	call FadeToWhiteAndUnsetFrameFunc
	pop hl
	pop de
	pop bc
	pop af
	ret

.Play:
	call DisableLCD
	call ClearSpriteAnimsAndSetInitialGraphicsConfiguration
	call EnableLCD
	xor a
	ld [wde4e], a
	ld [wde4f], a
	ld [wde50], a
	ld [wde51], a
	ld [wde52], a
	farcall RunCreditsCommands
	call Func_3f61
	call Func_3f61 ; repeated
	ret

Func_138c6:
	push af
	push bc
	push de
	push hl
	farcall SetAllBGPaletteFadeConfigsToEnabled
	farcall SetAllOBPaletteFadeConfigsToEnabled
	ld c, a
	ld b, $00
	sla c
	rl b
	sla c
	rl b
	sla c
	rl b
	sla c
	rl b ; *16
	ld hl, .PalFadeConfigs
	add hl, bc
	xor a
.loop_bg
	bit 0, [hl]
	jr z, .skip_bg
	farcall SetBGPaletteFadeConfigToDisabled
.skip_bg
	inc hl
	inc a
	cp NUM_BACKGROUND_PALETTES
	jr c, .loop_bg

	xor a
.loop_ob
	bit 0, [hl]
	jr z, .skip_ob
	farcall SetOBPaletteFadeConfigToDisabled
.skip_ob
	inc hl
	inc a
	cp NUM_OBJECT_PALETTES
	jr c, .loop_ob
	pop hl
	pop de
	pop bc
	pop af
	ret

; each entry represents 2 sets of data for BG and OB pals
; $1 means that pal fading will be disabled
.PalFadeConfigs
	; CREDITS_FADE_ALL
	db $0, $0, $0, $0, $0, $0, $0, $0 ; bg pals
	db $0, $0, $0, $0, $0, $0, $0, $0 ; ob pals

	; CREDITS_FADE_BACKGROUND
	db $1, $1, $0, $0, $0, $0, $0, $0 ; bg pals
	db $0, $0, $0, $0, $0, $0, $0, $0 ; ob pals

	; CREDITS_FADE_HEADER
	db $1, $0, $1, $1, $1, $1, $1, $1 ; bg pals
	db $0, $0, $0, $0, $0, $0, $0, $0 ; ob pals

	; CREDITS_FADE_TEXT
	db $0, $1, $1, $1, $1, $1, $1, $1 ; bg pals
	db $0, $0, $0, $0, $0, $0, $0, $0 ; ob pals

	; CREDITS_FADE_HEADER_TEXT
	db $0, $0, $1, $1, $1, $1, $1, $1 ; bg pals
	db $1, $1, $1, $1, $1, $1, $1, $1 ; ob pals

	; CREDITS_FADE_BACKGROUND_TEXT
	db $0, $1, $0, $0, $0, $0, $0, $0 ; bg pals
	db $0, $0, $0, $0, $0, $0, $0, $0 ; ob pals

CreditsCmd_Wait:
	ld a, [wCreditsCmdArg1]
	ld c, a
	scf
.loop
	call DoFrame
	dec c
	jr nz, .loop
	ccf
	ret

CreditsCmd_DrawBox:
	ld a, [wCreditsCmdArg2]
	ld d, a
	ld a, [wCreditsCmdArg3]
	ld e, a
	ld a, [wCreditsCmdArg4]
	ld b, a
	ld a, [wCreditsCmdArg5]
	ld c, a
	call FillBoxInBGMapWithZero
	ret

CreditsCmd_FadeOut:
	ld a, [wCreditsCmdArg2]
	ld b, a
	ld a, [wCreditsCmdArg1]
	call Func_138c6
	xor a
	farcall StartPalFadeToBlackOrWhite
	ret

CreditsCmd_FadeIn:
	ld a, [wCreditsCmdArg2]
	ld b, a
	ld a, [wCreditsCmdArg1]
	call Func_138c6
	farcall SaveTargetFadePals
	xor a
	farcall StartPalFadeFromBlackOrWhite
	ret

CreditsCmd_SetMusic:
	ld a, [wCreditsCmdArg1]
	push af
	ld a, a
	call SetMusic
	pop af
	ret

CreditsCmd_StopMusic:
	call SetNoMusic
	ret

CreditsCmd_ShowCompanies:
	ld b, BANK(.BGGraphics)
	ld hl, .BGGraphics
	lb de, 0, 0
	ld c, $00
	call LoadBGGraphics
	ret

.BGGraphics:
	dw TILESET_COMPANIES, PALETTE_16A, TILEMAP_224

CreditsCmd_ShowTitle:
	lb de, 0, 1
	xor a
	call LoadTitleScreenGraphics
	lb de, 1, 6
	ld a, $01
	call LoadTitleScreenGraphics
	lb de, 1, 9
	ld a, $02
	call LoadTitleScreenGraphics
	lb de, 0, 14
	ld a, $04
	call LoadTitleScreenGraphics
	ret

CreditsCmd_ShowCard:
	ld a, [wCreditsCmdArg2]
	ld b, a
	ld a, [wCreditsCmdArg3]
	ld c, a
	ld a, [wCreditsCmdArg4]
	ld e, a
	ld a, [wCreditsCmdArg5]
	ld d, a
	push af
	push bc
	push de
	push hl
	push bc
	ld c, $80
	call LoadCardGfx_FromCardID
	pop de
	ld c, $2
	call CopyCardPalettesToBGPals
	ld b, $80
	ld c, $2
	call DrawLoadedCard
	pop hl
	pop de
	pop bc
	pop af
	ret

CreditsCmd_ShowSet:
	ld a, [wCreditsCmdArg2]
	ld b, a
	ld a, [wCreditsCmdArg3]
	ld c, a
	ld a, [wCreditsCmdArg1]
	add SCENE_INTRO_BASE_SET
	call LoadScene
	ret

CreditsCmd_ShowPortrait:
	ld a, [wCreditsCmdArg2]
	ld b, a
	ld a, [wCreditsCmdArg3]
	ld c, a
	ld a, [wCreditsCmdArg5]
	ld e, a
	ld a, [wCreditsCmdArg1]
	call DrawNPCPortrait
	ret

CreditsCmd_PrintHeader:
	ld a, [wCreditsCmdArg2]
	ld d, a
	ld a, [wCreditsCmdArg3]
	ld e, a
	ld a, [wCreditsCmdArg4]
	ld l, a
	ld a, [wCreditsCmdArg5]
	ld h, a
	call Func_35af
	ld b, d
	ld c, e
	call BCCoordToBGMap0Address
	ld a, [wCreditsCmdArg1]
	ld b, a ; length
	ld c, 1 ; num rows
	ld a, BANK("VRAM1")
	call BankswitchVRAM
.loop_row
	push bc
	push hl
.loop_tiles
	di
	call WaitForLCDOff
	ld a, [hl]
	ld a, $01
	ld [hli], a
	ei
	dec b
	jr nz, .loop_tiles
	pop hl
	ld de, TILEMAP_WIDTH
	add hl, de
	pop bc
	dec c
	jr nz, .loop_row
	xor a
	call BankswitchVRAM
	bank1call SetFontAndTextBoxFrameColor
	ret

CreditsCmd_PrintBlack:
	ld a, [wCreditsCmdArg2]
	ld d, a
	ld a, [wCreditsCmdArg3]
	ld e, a
	ld a, [wCreditsCmdArg4]
	ld l, a
	ld a, [wCreditsCmdArg5]
	ld h, a
	call Func_35af
	bank1call SetFontAndTextBoxFrameColor
	ret

CreditsCmd_Scroll:
	ld a, [wCreditsCmdArg1]
	ld [wde52], a
	ld a, [wCreditsCmdArg2]
	ld [wde4f], a
	ld a, [wCreditsCmdArg3]
	ld [wde4e], a
	ld a, [wCreditsCmdArg4]
	ld [wde51], a
	ld a, [wCreditsCmdArg5]
	ld [wde50], a
	; this won't work since the frame function
	; doesn't actually call wde69
	ld hl, Func_3e7a
	call Func_3f6b
	ret

Func_13ac1::
	; current scroll position
	ld a, [wde4f]
	ld b, a
	ld a, [wde51]
	ld c, a
	or b
	ret z

	; scrolling speed
	ld a, [wde52]
	ld e, a

	; x scrolling
	ld a, [wde4e]
	ld d, a
	ld a, b
	and a
	call nz, .ApplyScrollingOffset
	ld [wde4f], a
	ldh [hSCX], a

	; y scrolling
	ld a, [wde50]
	ld d, a
	ld a, c
	and a
	call nz, .ApplyScrollingOffset
	ld [wde51], a
	ldh [hSCY], a
	ret

.ApplyScrollingOffset:
	bit 7, d
	jr nz, .subtract
	add e
	ret
.subtract
	sub e
	ret

CreditsCmd_WaitInput:
	ld a, [wCreditsCmdArg1]
	ld c, a
	call Func_10221
	ret

CreditsCmd_MusicFadeOut:
	ld c, $08
.loop
	ld a, c
	dec a
	push af
	ld a, a
	call Func_3d3a
	pop af
	ld b, 20
.loop_wait
	call DoFrame
	dec b
	jr nz, .loop_wait
	dec c
	jr nz, .loop
	ret

CreditsCmd_SetVolume:
	ld a, [wCreditsCmdArg1]
	push af
	ld a, a
	call Func_3d3a
	pop af
	ret

CreditsCmd_LoadMap:
	ld a, [wCreditsCmdArg2]
	ld b, a
	ld a, [wCreditsCmdArg3]
	ld c, a
	farcall LoadOWMap
	ret

CreditsCmd_InitOW:
	call InitOWObjects
	call Func_1109f
	ret

CreditsCmd_DeinitOW:
	call Func_110a8
	ret

CreditsCmd_LoadTilemap:
	ld a, [wCreditsCmdArg2]
	ld b, a
	ld a, [wCreditsCmdArg3]
	ld c, a
	ld a, [wCreditsCmdArg4]
	ld d, a
	ld a, [wCreditsCmdArg5]
	ld e, a
	farcall Func_12c0ce
	ret

CreditsCmd_LoadOWObject:
	ld a, [wCreditsCmdArg2]
	ld b, a
	ld a, [wCreditsCmdArg4]
	ld d, a
	ld a, [wCreditsCmdArg5]
	ld e, a
	ld a, [wCreditsCmdArg1]
	and a
	jr nz, .got_ow_obj
	call GetPlayerGender
.got_ow_obj
	call LoadOWObject
	ret

CreditsCmd_LoadOWObjectInMap:
	ld a, [wCreditsCmdArg2]
	ld b, a
	ld a, [wCreditsCmdArg4]
	ld d, a
	ld a, [wCreditsCmdArg5]
	ld e, a
	ld a, [wCreditsCmdArg1]
	and a
	jr nz, .got_ow_object
	call GetPlayerGender
.got_ow_object
	call LoadOWObjectInMap
	ret

CreditsCmd_ShowTile:
	ld a, [wCreditsCmdArg2]
	ld b, a
	ld a, [wCreditsCmdArg3]
	ld c, a
	ld a, [wCreditsCmdArg4]
	ld d, a
	ld a, [wCreditsCmdArg5]
	ld e, a
	call Func_383b
	ret
