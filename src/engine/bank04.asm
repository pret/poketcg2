SECTION "Bank 4@4285", ROMX[$4285], BANK[$4]

; use with FadeToWhiteAndUnsetFrameFunc
SetFrameFuncAndFadeFromWhite:
	call SetSpriteAnimationAndFadePalsFrameFunc
	farcall StartFadeFromWhite
	farcall WaitPalFading
	ret

; use with SetFrameFuncAndFadeFromWhite
FadeToWhiteAndUnsetFrameFunc:
	farcall StartFadeToWhite
	farcall WaitPalFading
	call UnsetSpriteAnimationAndFadePalsFrameFunc
	ret

ClearSpriteAnimsAndSetInitialGraphicsConfiguration::
	call ClearSpriteAnims
	call SetInitialGraphicsConfiguration
	ret
; 0x102a4

SECTION "Bank 4@42ef", ROMX[$42ef], BANK[$4]

Func_102ef:
	push af
	push bc
	push de
	push hl
	call SetInitialGraphicsConfiguration
	xor a
	ld hl, wd7ee
	ld bc, $64
	call WriteBCBytesToHL
	ld a, $80
	ld hl, wd6d4
	ld bc, $101
	call WriteBCBytesToHL
	xor a
	ld [wd852], a
	ld hl, wd853
	ld bc, $40
	call WriteBCBytesToHL
	call Func_10327
	xor a
	ld [wd896 + 0], a
	ld [wd896 + 1], a
	pop hl
	pop de
	pop bc
	pop af
	ret

Func_10327:
	ld a, [wce4d]
	push af
	ld a, $03
	call Func_3523
	xor a
	ld [w3d400], a
	ld de, w3d000
	ld hl, w3d401
	ld [hl], e
	inc hl
	ld [hl], d
	pop af
	call Func_3523
	ret
; 0x10342

SECTION "Bank 4@463a", ROMX[$463a], BANK[$4]

SetInitialGraphicsConfiguration:
	push af
	push bc
	push de
	push hl
	xor a
	ld [wTileMapFill], a
	bank1call SetZeroLineSeparation
	call LoadSymbolsFont
	call Func_35a0
	call SetZeroScroll
	call SafeClearBGMap
	ld a, $01
	ld [wTextBoxFrameType], a
	bank1call SetFontAndTextBoxFrameColor
	farcall EnableBGPFading
	xor a
	call BankswitchVRAM
	pop hl
	pop de
	pop bc
	pop af
	ret
; 0x10666

SECTION "Bank 4@468a", ROMX[$468a], BANK[$4]

SetZeroScroll:
	push af
	xor a
	ldh [hSCX], a
	ldh [hSCY], a
	pop af
	ret

; safely clears BGMap0 and BGMap1
; of both VRAM0 and VRAM1
SafeClearBGMap:
	push af
	push bc
	push de
	push hl
	ld hl, v0BGMap0
	ld bc, $800
.loop_clear
	xor a
	call BankswitchVRAM
	ei
.wait_lcd_1
	di
	ldh a, [rSTAT]
	and STAT_LCDC_STATUS
	jr nz, .wait_lcd_1
	xor a
	ld [hl], a
	ei
	ld a, $01
	call BankswitchVRAM
	ei
.wait_lcd_2
	di
	ldh a, [rSTAT]
	and STAT_LCDC_STATUS
	jr nz, .wait_lcd_2
	xor a
	ld [hli], a
	ei
	dec c
	jr nz, .loop_clear
	dec b
	jr nz, .loop_clear
	xor a
	call BankswitchVRAM
	pop hl
	pop de
	pop bc
	pop af
	ret
; 0x106ca

SECTION "Bank 4@46f4", ROMX[$46f4], BANK[$4]

; h = tile index
; l = attributes
; de = coodinates
; b = width
; c = height
FillBoxInBGMap:
	push af
	push bc
	push de
	push hl
	ld a, h
	ld [wd89d], a
	ld a, l
	ld [wd89e], a
	push bc
	ld b, d
	ld c, e
	call BCCoordToBGMap0Address
	pop bc
.loop_rows
	push bc
	push hl
.loop_columns
	xor a
	call BankswitchVRAM
	di
	call WaitForLCDOff
	ld a, [wd89d]
	ld [hl], a
	ei
	ld a, $01
	call BankswitchVRAM
	di
	call WaitForLCDOff
	ld a, [wd89e]
	ld [hli], a
	ei
	dec b
	jr nz, .loop_columns
	pop hl
	ld de, BG_MAP_WIDTH
	add hl, de
	pop bc
	dec c
	jr nz, .loop_rows
	xor a
	call BankswitchVRAM
	pop hl
	pop de
	pop bc
	pop af
	ret

; same as ClearBoxInBGMap
; de = coordinates
; b = width
; c = height
FillBoxInBGMapWithZero:
	push hl
	lb hl, $0, $0
	call FillBoxInBGMap
	pop hl
	ret
; 0x10742

SECTION "Bank 4@488a", ROMX[$488a], BANK[$4]

ZeroObjectPositionsAndEnableOBPFading:
	push af
	push bc
	push de
	push hl
	call Set_OBJ_8x8
	call ZeroObjectPositions
	ld a, $01
	ld [wVBlankOAMCopyToggle], a
	farcall EnableOBPFading
	pop hl
	pop de
	pop bc
	pop af
	ret
; 0x108a2

SECTION "Bank 4@48c9", ROMX[$48c9], BANK[$4]

Func_108c9:
	ld [wd8a1], a
	ret
; 0x108cd

SECTION "Bank 4@48e6", ROMX[$48e6], BANK[$4]

ClearSpriteAnims:
	push af
	push bc
	push de
	push hl
	xor a
	ld [wCurVRAMTile], a
	ld [wNumSpriteTilesets], a
	ld [wd96f], a
	ld [wd970], a
	ld bc, NUM_SPRITE_ANIM_STRUCTS * SPRITEANIMSTRUCT_LENGTH
	ld hl, wSpriteAnimationStructs
	call WriteBCBytesToHL
	call ZeroObjectPositionsAndEnableOBPFading
	pop hl
	pop de
	pop bc
	pop af
	ret
; 0x10908

SECTION "Bank 4@490e", ROMX[$490e], BANK[$4]

GetNextInactiveSpriteAnim::
	push af
	push bc
	push de
	ld hl, wSpriteAnimationStructs
	ld c, NUM_SPRITE_ANIM_STRUCTS
	ld b, $00 ; unused
	ld de, SPRITEANIMSTRUCT_LENGTH
.loop
	ld a, [hl] ; SPRITEANIMSTRUCT_FLAGS
	bit SPRITEANIMSTRUCT_ACTIVE_F, a
	jr z, .inactive
	add hl, de
	dec c
	jr nz, .loop
	ld hl, NULL
.inactive
	pop de
	pop bc
	pop af
	ret

SECTION "Bank 4@4948", ROMX[$4948], BANK[$4]

GetCthSpriteAnim::
	push bc
	sla c
	sla c
	sla c
	sla c ; *16 aka SPRITEANIMSTRUCT_LENGTH
	ld b, $00
	ld hl, wSpriteAnimationStructs
	add hl, bc
	pop bc
	ret

SetNewSpriteAnimValues::
	push af
	push bc
	push de
	push hl
	ld a, SPRITEANIMSTRUCT_ANIMATING | SPRITEANIMSTRUCT_FLAG6 | SPRITEANIMSTRUCT_ACTIVE
	call SetSpriteAnimFlags
	xor a
	lb bc, $0, $0
	lb de, $0, $0
	call Func_10ca2
	call SetSpriteAnimPosition
	call SetSpriteAnimFrameIndex
	call Func_10c7a
	call SetSpriteAnimFrameDuration
	call SetSpriteAnimTileOffset
	call SetSpriteAnimAnimation
	call Func_10cc1
	call SetSpriteAnimStartDelay
	pop hl
	pop de
	pop bc
	pop af
	ret

SECTION "Bank 4@4991", ROMX[$4991], BANK[$4]

MoveSpriteAnim:
	push af
	push bc
	push de
	push hl
	bit SPRITEANIMSTRUCT_MOVE_F, [hl] ; SPRITEANIMSTRUCT_FLAGS
	jr z, .done
	push hl
	ld a, [hl] ; SPRITEANIMSTRUCT_FLAGS
	and SPRITEANIMSTRUCT_DIR_MASK
	ld b, a
	srl b
	ld a, [hl] ; SPRITEANIMSTRUCT_FLAGS
	and SPRITEANIMSTRUCT_SPEED
	inc a
	ld c, a
	inc hl
	inc hl
	inc hl
	ld d, [hl] ; SPRITEANIMSTRUCT_X_POS
	inc hl
	ld e, [hl] ; SPRITEANIMSTRUCT_Y_POS
	inc b
	dec b
	jr nz, .right

; up
; b == 0
	; y -= c
	ld a, e
	sub c
	ld e, a

.right
	dec b
	jr nz, .down
; b == 1
	; x += c
	ld a, d
	add c
	ld d, a

.down
	dec b
	jr nz, .left
; b == 2
	; y += c
	ld a, e
	add c
	ld e, a

.left
	dec b
	jr nz, .up_right
; b == 3
	; x -= c
	ld a, d
	sub c
	ld d, a

.up_right
	dec b
	jr nz, .down_right
; b == 4
	; x += c
	; y -= c
	ld a, d
	add c
	ld d, a
	ld a, e
	sub c
	ld e, a

.down_right
	dec b
	jr nz, .down_left
; b == 5
	; x += c
	; y += c
	ld a, d
	add c
	ld d, a
	ld a, e
	add c
	ld e, a

.down_left
	dec b
	jr nz, .up_left
; b == 6
	; x -= c
	; y += c
	ld a, d
	sub c
	ld d, a
	ld a, e
	add c
	ld e, a

.up_left
	dec b
	jr nz, .apply_offset
; b == 7
	; x -= c
	; y -= c
	ld a, d
	sub c
	ld d, a
	ld a, e
	sub c
	ld e, a

.apply_offset
	ld [hl], e ; SPRITEANIMSTRUCT_Y_POS
	dec hl
	ld [hl], d ; SPRITEANIMSTRUCT_X_POS
	ld bc, SPRITEANIMSTRUCT_C - SPRITEANIMSTRUCT_X_POS
	add hl, bc
	dec [hl] ; SPRITEANIMSTRUCT_C
	pop hl
	jr nz, .done
	res SPRITEANIMSTRUCT_MOVE_F, [hl] ; SPRITEANIMSTRUCT_FLAGS

.done
	pop hl
	pop de
	pop bc
	pop af
	ret

UpdateSpriteAnims::
	push af
	push bc
	push de
	push hl
	call ZeroObjectPositions
	ld hl, wSpriteAnimationStructs
	ld c, NUM_SPRITE_ANIM_STRUCTS
.loop_objs
	call MoveSpriteAnim
	farcall UpdateSpriteAnim
	ld de, SPRITEANIMSTRUCT_LENGTH
	add hl, de
	dec c
	jr nz, .loop_objs
	ld a, $01
	ld [wVBlankOAMCopyToggle], a
	pop hl
	pop de
	pop bc
	pop af
	ret

SECTION "Bank 4@4a1e", ROMX[$4a1e], BANK[$4]

; d = x coordinate
; e = y coordinate
SetSpriteAnimPosition::
	push hl
	inc hl
	inc hl
	inc hl
	ld [hl], d ; SPRITEANIMSTRUCT_X_POS
	inc hl
	ld [hl], e ; SPRITEANIMSTRUCT_Y_POS
	pop hl
	ret

SECTION "Bank 4@4bc8", ROMX[$4bc8], BANK[$4]

SetSpriteAnimAnimating:
	set SPRITEANIMSTRUCT_ANIMATING_F, [hl] ; SPRITEANIMSTRUCT_FLAGS
	ret
; 0x10bcb

SECTION "Bank 4@4c39", ROMX[$4c39], BANK[$4]

; returns nz if sprite anim in hl is animating
CheckIsSpriteAnimAnimating:
	bit SPRITEANIMSTRUCT_ANIMATING_F, [hl] ; SPRITEANIMSTRUCT_FLAGS
	ret
; 0x10c3c

SECTION "Bank 4@4c5a", ROMX[$4c5a], BANK[$4]

; bc = FRAMESET_* constant
SetAndInitSpriteAnimFrameset::
	push af
	push de
	push hl
	ld de, SPRITEANIMSTRUCT_FRAME_INDEX
	add hl, de
	xor a
	ld [hli], a ; SPRITEANIMSTRUCT_FRAME_INDEX
	ld [hl], c ; SPRITEANIMSTRUCT_FRAMESET_ID
	inc hl
	ld [hl], b
	inc hl
	ld [hl], a ; SPRITEANIMSTRUCT_FRAME_DURATION
	pop hl
	pop de
	pop af
	ret

SetSpriteAnimFrameset:
	push af
	push de
	push hl
	ld de, SPRITEANIMSTRUCT_FRAMESET_ID
	add hl, de
	ld [hl], c ; SPRITEANIMSTRUCT_FRAMESET_ID
	inc hl
	ld [hl], b
	pop hl
	pop de
	pop af
	ret

Func_10c7a:
	push af
	push bc
	push de
	push hl
	inc hl
	ld a, [hl] ; SPRITEANIMSTRUCT_1
	and $fc
	ld [hl], a
	ld de, SPRITEANIMSTRUCT_E - SPRITEANIMSTRUCT_1
	add hl, de
	ld [hl], c ; SPRITEANIMSTRUCT_E
	inc hl
	ld [hl], b
	farcall Func_12c09a
	pop hl
	call SetAndInitSpriteAnimFrameset
	pop de
	pop bc
	pop af
	ret

SetSpriteAnimStartDelay:
	push bc
	push hl
	ld bc, SPRITEANIMSTRUCT_START_DELAY
	add hl, bc
	ld [hl], a ; SPRITEANIMSTRUCT_START_DELAY
	pop hl
	pop bc
	ret

SetSpriteAnimFlags:
	ld [hl], a ; SPRITEANIMSTRUCT_FLAGS
	ret

Func_10ca2:
	ret

SetSpriteAnimFrameDuration:
	push bc
	push hl
	ld bc, SPRITEANIMSTRUCT_FRAME_DURATION
	add hl, bc
	ld [hl], a ; SPRITEANIMSTRUCT_FRAME_DURATION
	pop hl
	pop bc
	ret

SetSpriteAnimTileOffset::
	push bc
	push hl
	ld bc, SPRITEANIMSTRUCT_TILE_OFFSET
	add hl, bc
	ld [hl], a ; SPRITEANIMSTRUCT_TILE_OFFSET
	pop hl
	pop bc
	ret

SetSpriteAnimFrameIndex:
	push bc
	push hl
	ld bc, SPRITEANIMSTRUCT_FRAME_INDEX
	add hl, bc
	ld [hl], a ; SPRITEANIMSTRUCT_FRAME_INDEX
	pop hl
	pop bc
	ret

Func_10cc1:
	push bc
	push hl
	ld bc, SPRITEANIMSTRUCT_C
	add hl, bc
	ld [hl], a ; SPRITEANIMSTRUCT_C
	pop hl
	pop bc
	ret

; bc = SPRITE_ANIM_* constant
SetSpriteAnimAnimation::
	push bc
	push hl
	push bc
	ld bc, SPRITEANIMSTRUCT_ANIM_ID
	add hl, bc
	pop bc
	ld [hl], c ; SPRITEANIMSTRUCT_ANIM_ID
	inc hl
	ld [hl], b
	pop hl
	pop bc
	ret
; 0x10cd9

SECTION "Bank 4@4d40", ROMX[$4d40], BANK[$4]

Func_10d40:
	call Func_111f6
	ld a, $01
	call Func_108c9
	call Func_10f26
	ret
; 0x10d4c

SECTION "Bank 4@4f26", ROMX[$4f26], BANK[$4]

Func_10f26:
	ld a, $ff
	ld [wd986], a
	ret
; 0x10f2c

SECTION "Bank 4@502c", ROMX[$502c], BANK[$4]

PrintScrollableText_NoTextBoxLabelVRAM0::
	push af
	push bc
	push de
	push hl
	xor a
	call BankswitchVRAM
	call PrintScrollableText_NoTextBoxLabel
	pop hl
	pop de
	pop bc
	pop af
	ret
; 0x1103c

SECTION "Bank 4@504c", ROMX[$504c], BANK[$4]

; input:
;  a = $0 for "yes" default option
;  a = $1 for "no" default option
;  hl = text ID
; output:
;  a = $0 if "yes" selected
;  a = $1 if "no" selected
;  carry set if "no" selected
DrawWideTextBox_PrintTextWithYesOrNoMenu:
	push bc
	push de
	push hl
	xor $1
	ld [wDefaultYesOrNo], a
	call DrawWideTextBox_PrintText
	call YesOrNoMenu
	ld a, $00
	jr nc, .exit
	ld a, $01
.exit
	pop hl
	pop de
	pop bc
	ret
; 0x11064

SECTION "Bank 4@5092", ROMX[$5092], BANK[$4]

SetFadePalsFrameFunc:
	push hl
	ld hl, FrameFunc_FadePals
	call PushFrameFunction
	pop hl
	ret

UnsetFadePalsFrameFunc:
	call PopFrameFunction
	ret
; 0x1109f

SECTION "Bank 4@50ac", ROMX[$50ac], BANK[$4]

SetSpriteAnimationAndFadePalsFrameFunc::
	push hl
	ld hl, FrameFunc_SpriteAnimationAndFadePals
	call PushFrameFunction
	pop hl
	ret

UnsetSpriteAnimationAndFadePalsFrameFunc::
	call PopFrameFunction
	ret
; 0x110b9

SECTION "Bank 4@51f0", ROMX[$51f0], BANK[$4]

Func_111f0:
	ld a, $04
	ld [wd9dc], a
	ret
; 0x111f6

Func_111f6:
	push af
	push bc
	push de
	push hl
	xor a
	call ClearSpriteAnims
	xor a
	call Func_108c9
	xor a
	ld bc, $50
	ld hl, wda39
	call WriteBCBytesToHL
	pop hl
	pop de
	pop bc
	pop af
	ret
; 0x11211

SECTION "Bank 4@557c", ROMX[$557c], BANK[$4]

Func_1157c:
	push af
	xor a
	ld [wda99 + 0], a
	ld [wda99 + 1], a
	ld [wda99 + 2], a
	ld [wda99 + 3], a
	ld [wda98], a
	pop af
	ret
; 0x1158f

SECTION "Bank 4@5641", ROMX[$5641], BANK[$4]

IntroAndTitleScreen:
	push af
	push bc
	push de
	push hl
	call SetNoMusic

.start
	call ChooseTitleScreenCards
	call ClearSpriteAnimsAndSetInitialGraphicsConfiguration
	call EnableLCD
	call DoFrame
	call DoIntro
	jr c, .FadeInScreen
	call AnimateTitle
	jr c, .FadeInScreen
	call AnimateSubtitleEnter
	jr c, .FadeInScreen
	call AnimateTrademark
	jr nc, .title_screen_idle

; fade in whole title screen
; for when there is player input
.FadeInScreen
	call SetNoMusic
	call DoFrame
	call FadeInTitleScreen

.title_screen_idle
	call Func_3d02
	push af
	ld a, MUSIC_TITLESCREEN
	call SetMusic
	pop af
	call TitleScreenPushStart
	jr c, .restart_intro
	call DoFrame
	call AnimateSubtitleExit
	jr c, .FadeInScreen
	call DoFrame
	call AnimateIntroCards
	jr c, .FadeInScreen
	call FadeInTitleScreenAfterIntroCards
	jr c, .FadeInScreen

.restart_intro
	call SetNoMusic
	call SetFadePalsFrameFunc
	farcall StartFadeToWhite
	farcall WaitPalFading
	call UnsetFadePalsFrameFunc
	jr nc, .start

	pop hl
	pop de
	pop bc
	pop af
	ret

CreateIntroOrbs:
	ld hl, .SpriteAnimGfxParams
	ld b, BANK(.SpriteAnimGfxParams)
	lb de, 0, 0
	ld c, NUM_INTRO_ORBS
.loop_create
	push bc
	ld a, $ff
	ld c, 0
	call CreateSpriteAnim
	pop bc
	dec c
	jr nz, .loop_create
	ret

.SpriteAnimGfxParams
	dw TILESET_1CE
	dw SPRITE_ANIM_92
	dw FRAMESET_159
	dw PALETTE_168
; 0x116cc

SECTION "Bank 4@5704", ROMX[$5704], BANK[$4]

SetAthSpriteAnimPosition:
	push bc
	ld c, a
	call SetCthSpriteAnimPosition
	pop bc
	ret

; returns nz if sprite anim was animating
; before setting the flag
SetCthSpriteAnimAnimating:
	push bc
	ld c, a
	call Func_12ead
	pop bc
	ret

; c = which group this orb belongs to
;     group 1 will move from the right
;     group 2 will move from the left
SetIntroOrbFrameset:
	push af
	push bc
	push de
	push hl
	sla c
	ld b, $00
	ld hl, .FramesetIDs
	add hl, bc
	ld e, [hl]
	inc hl
	ld d, [hl]
	ld c, a
	call SetCthSpriteAnimFrameset
	pop hl
	pop de
	pop bc
	pop af
	ret

.FramesetIDs
	dw FRAMESET_159
	dw FRAMESET_176
	dw FRAMESET_177

; c = start delay
SetAthSpriteAnimStartDelay:
	push af
	push bc
	ld b, a
	ld a, c
	ld c, b
	call SetCthSpriteAnimStartDelay
	pop bc
	pop af
	ret

; loads title screen in parts, depending
; on value in register a:
; 0 = title
; 1 = subtitle top
; 2 = subtitle bottom
; 3 = trademark
LoadTitleScreenGraphics:
	ld c, a
	ld b, $00
	sla c
	rl b
	sla c
	rl b
	sla c
	rl b ; *8
	ld hl, .data
	add hl, bc
	ld b, $04
	ld c, $00
	call LoadBGGraphics
	ld a, [wd693]
	set 3, a
	ld [wd693], a
	ret

.data
	dw TILESET_TITLE_SCREEN, PALETTE_167, TILEMAP_21E, $0000
	dw TILESET_TITLE_SCREEN, PALETTE_167, TILEMAP_21F, $0000
	dw TILESET_TITLE_SCREEN, PALETTE_167, TILEMAP_220, $0000
	dw TILESET_TITLE_SCREEN, PALETTE_167, TILEMAP_221, $0000
	dw TILESET_TITLE_SCREEN, PALETTE_167, TILEMAP_222, $0000

CreatePushStartAnimation:
	ld b, BANK(.SpriteAnimGfxParams)
	ld hl, .SpriteAnimGfxParams
	lb de, 48, 119
	ld a, $00
	ld c, 0
	call CreateSpriteAnim
	ret

.SpriteAnimGfxParams
	dw TILESET_1CE
	dw SPRITE_ANIM_9A
	dw FRAMESET_161
	dw PALETTE_168

IntroCheckInput:
	scf
	ccf
	call DoFrame
	ldh a, [hKeysPressed]
	and A_BUTTON | START
	jr z, .no_carry
	scf
.no_carry
	ret

; waits a number of frames given in a
; for the player input
WaitAFramesForInput:
	push bc
	ld c, a
.loop_wait
	call DoFrame
	ldh a, [hKeysPressed]
	and A_BUTTON | START
	jr nz, .set_carry
	dec c
	jr nz, .loop_wait
	scf
	ccf
	jr .no_carry
.set_carry
	scf
.no_carry
	pop bc
	ret

; waits a number of frames given in bc
; for the player input
WaitBCFramesForInput:
	push bc
	ld a, b
	or c
	jr z, .no_carry
	inc c
.loop_wait
	call DoFrame
	ldh a, [hKeysPressed]
	and A_BUTTON | START
	jr nz, .set_carry
	dec c
	jr nz, .loop_wait
	dec b
	jr nz, .loop_wait
	scf
	ccf
	jr .no_carry
.set_carry
	scf
.no_carry
	pop bc
	ret

TitleScreenPushStart:
	call ClearSpriteAnims
	call SetSpriteAnimationAndFadePalsFrameFunc
	call CreatePushStartAnimation
	call FlushAllPalettes
	ld bc, 1080
	call WaitBCFramesForInput
	call UnsetSpriteAnimationAndFadePalsFrameFunc
	call ClearSpriteAnims
	ret

; returns carry set if there was user input
DoIntro:
	call ClearSpriteAnims
	call CreateIntroOrbs
	call SetFrameFuncAndFadeFromWhite
	farcall DisableOBPFading

	xor a
	ld [wIntroSceneCounter], a
.loop_intro_scenes
	call ResetIntroState
	call ResetIntroOrbStates
	push af
	ld a, $9a
	call Func_3cfe
	pop af

.loop_intro_update
	call IntroCheckInput
	jr c, .end_intro
	call HandleIntroScenes
	call UpdateIntroOrbs
	call .CheckLastOrbFinished
	jr nz, .loop_intro_update
	ld a, 20
	call WaitAFramesForInput
	jr c, .end_intro
	ld a, [wIntroSceneCounter]
	inc a
	ld [wIntroSceneCounter], a
	cp NUM_INTRO_SCENES
	jr nz, .loop_intro_scenes

.end_intro
	farcall EnableOBPFading
	call FadeToWhiteAndUnsetFrameFunc
	call ClearSpriteAnims
	ret

; returns z if last orb is in end state
.CheckLastOrbFinished:
	ld a, [wIntroOrbsStates + (NUM_INTRO_ORBS - 1)]
	cp INTRO_ORB_STATE_FINISH
	ret

ResetIntroOrbStates:
	ld hl, wIntroOrbsStates
	ld bc, NUM_INTRO_ORBS
	ld a, INTRO_ORB_STATE_START
	call WriteBCBytesToHL
	xor a
	ld c, $00
.loop_orbs
	call SetIntroOrbFrameset
	inc a
	cp NUM_INTRO_ORBS
	jr nz, .loop_orbs
	ret

UpdateIntroOrbs:
	ld hl, wIntroOrbsStates
	ld b, NUM_INTRO_ORBS
	ld c, 0
.loop_orbs
	push af
	push bc
	push de
	push hl
	ld a, c
	call SetCthSpriteAnimAnimating
	jr nz, .skip
	call .UpdateState
.skip
	pop hl
	pop de
	pop bc
	pop af
	inc hl
	inc c
	dec b
	jr nz, .loop_orbs
	ret

.UpdateState:
	ld a, [hl]
	inc a
	dec a
	call z, .Start
	dec a
	call z, .Stop
	ret

; INTRO_ORB_STATE_START
.Start:
	push af
	push hl
	ld a, c
	lb de, 88, 88
	call SetAthSpriteAnimPosition
	ld b, $00
	sla c
	ld hl, .OrbParams
	add hl, bc
	ld c, [hl]
	call SetIntroOrbFrameset
	inc hl
	ld c, [hl]
	call SetAthSpriteAnimStartDelay
	pop hl
	ld a, INTRO_ORB_STATE_STOP
	ld [hl], a
	pop af
	ret

; INTRO_ORB_STATE_STOP
.Stop:
	push af
	ld a, c
	ld c, $00
	call SetIntroOrbFrameset
	ld a, INTRO_ORB_STATE_FINISH
	ld [hl], a
	pop af
	ret

.OrbParams
	; group, delay
	db 1,  0
	db 1, 24
	db 1, 48
	db 1, 72
	db 2,  3
	db 2, 27
	db 2, 51
	db 2, 75

ResetIntroState:
	ld a, $01
	ld [wIntroStateCounter], a
	ld a, $00
	ld [wIntroStateMode], a
	ret

HandleIntroScenes:
	ld hl, wIntroStateCounter
	dec [hl]
	ret nz
	ld a, [wIntroStateMode]
	inc a
	dec a
	call z, .LoadSceneAndInitPals
	dec a
	call z, .FadeIn
	dec a
	call z, .FadeOut
	ret

; wIntroStateMode == 0
.LoadSceneAndInitPals:
	push af
	ld a, $ff ; white
	farcall InitFadePalettes
	call FlushAllPalettes
	; cycle through
	; SCENE_INTRO_BASE_SET,
	; SCENE_INTRO_JUNGLE,
	; SCENE_INTRO_FOSSIL,
	; SCENE_INTRO_TEAM_ROCKET
	ld a, [wIntroSceneCounter]
	and $3
	add SCENE_INTRO_BASE_SET
	lb bc, 6, 3
	call LoadScene
	ld a, 72
	ld [wIntroStateCounter], a
	ld a, 1
	ld [wIntroStateMode], a
	pop af
	ret

; wIntroStateMode == 1
.FadeIn:
	push af
	farcall SaveTargetFadePals
	xor a
	ld b, $06
	farcall StartPalFadeFromBlackOrWhite
	ld a, 216
	ld [wIntroStateCounter], a
	ld a, 2
	ld [wIntroStateMode], a
	pop af
	ret

; wIntroStateMode == 2
.FadeOut:
	push af
	xor a
	ld b, $06
	farcall StartPalFadeToBlackOrWhite
	ld a, 240
	ld [wIntroStateCounter], a
	ld a, 0
	ld [wIntroStateMode], a
	pop af
	ret

AnimateTitle:
	call SafeClearBGMap
	call DoFrame
	farcall SetAllBGPaletteFadeConfigsToDisabled
	ld a, $04
	farcall SetPaletteFadeConfigToEnabled
	ld a, $ff ; white
	farcall InitFadePalettes
	call FlushAllPalettes
	lb de, 0, 1
	xor a
	call LoadTitleScreenGraphics
	ld a, 2
	call WaitAFramesForInput
	jr c, .finish
	push af
	ld a, $9b
	call Func_3cfe
	pop af
	call .Expand
	jr c, .finish
	ld a, 18
	call WaitAFramesForInput
.finish
	farcall SetAllBGPaletteFadeConfigsToEnabled
	ret

.Expand:
	xor a
	ld [wIntroStateCounter], a
	ld hl, Data_11e52
.asm_11976
	call DoFrame
	ldh a, [hKeysPressed]
	and A_BUTTON | START
	scf
	ret nz
	ld a, [wIntroStateCounter]
	ld b, a
	ld a, $30
	sub b
	ld b, a ; $30 - wIntroStateCounter
.asm_11987
	ldh a, [rLY]
	cp $91
	jr nc, .asm_11987
.asm_1198d
	ldh a, [rLY]
	cp $04
	jr c, .asm_1198d
	; $04 <= rLY < $91
	di
	call WaitForLCDOff
	ld a, $50
	ldh [rSCY], a
.asm_1199b
	ldh a, [rLY]
	cp b
	jr c, .asm_1199b
	; rLY >= b
	ld b, a
.asm_119a1
	ldh a, [rLY]
	cp $30
	jr nc, .asm_119bb
	cp b
	jr z, .asm_119a1
	ld b, a
	call WaitForLCDOff
	ldh a, [rLY]
	ld c, [hl]
	inc hl
	sub c
	sub 8
	xor $ff
	ldh [rSCY], a
	jr .asm_119a1

.asm_119bb
	call WaitForLCDOff
	xor a
	ldh [rSCY], a
	ei
	ld a, [wIntroStateCounter]
	cp 1
	call z, .LoadTitlePals
	ld a, [wIntroStateCounter]
	inc a
	ld [wIntroStateCounter], a
	cp 40
	jr c, .asm_11976
	scf
	ccf
	ret

.LoadTitlePals:
	push bc
	push de
	push hl
	ld hl, rBGPI
	ld a, $a0
	ld [hl], a
	ld de, rBGPD
	ld hl, wBackgroundPalettesCGB + $20
	ld c, CGB_PAL_SIZE
.loop_load_pal
	ldh a, [rSTAT]
	and STAT_ON_OAM
	jr nz, .loop_load_pal
	ld a, [hli]
	ld [de], a
	dec c
	jr nz, .loop_load_pal
	pop hl
	pop de
	pop bc
	ret

AnimateSubtitleEnter:
	farcall SetAllBGPaletteFadeConfigsToDisabled
	ld a, $05
	farcall SetPaletteFadeConfigToEnabled
	ld a, $06
	farcall SetPaletteFadeConfigToEnabled
	ld a, $ff ; white
	farcall InitFadePalettes
	call FlushAllPalettes
	lb de, 1, 6
	ld a, $01
	call LoadTitleScreenGraphics
	lb de, 1, 9
	ld a, $02
	call LoadTitleScreenGraphics
	push af
	ld a, $9c
	call Func_3cfe
	pop af
	call .Distort
	farcall SetAllBGPaletteFadeConfigsToEnabled
	ret

.Distort:
	ld a, $0f
	ld [wdafd], a
	xor a
	ld [wIntroStateCounter], a
	call .Func_11a98
.asm_11a3c
	call DoFrame
	ldh a, [hKeysPressed]
	and A_BUTTON | START
	scf
	ret nz
	ld a, [wIntroStateCounter]
	ld c, a
.asm_11a49
	ldh a, [rLY]
	cp $91
	jr nc, .asm_11a49
.asm_11a4f
	ldh a, [rLY]
	cp $30
	jr c, .asm_11a4f
	; $30 <= rLY < $91
	di
	ld a, [wIntroStateCounter]
	ld e, a
.asm_11a5a
	ldh a, [rLY]
	cp $68
	jr nc, .asm_11a7c
	ld d, a
	and $01
	swap a
	ld l, a
	ld a, d
	sub $30
	add e
	xor l
	and $1f
	; a = (rLY - $30 + wIntroStateCounter) ^ ((rLY & %1) << 4) & %11111
	ld b, $00
	ld c, a
	ld hl, wdac1
	add hl, bc
	call WaitForLCDOff
	ld a, [hl]
	ldh [rSCX], a
	jr .asm_11a5a
.asm_11a7c
	ei
	ld a, [wIntroStateCounter]
	cp 1
	call z, .LoadSubtitlePals
	ld a, [wIntroStateCounter]
	inc a
	ld [wIntroStateCounter], a
	call .Func_11a98
	ld a, [wdafd]
	and a
	jr nz, .asm_11a3c
	scf
	ccf
	ret

.Func_11a98:
	push de
	ld hl, Data_11dd2
	ld de, wdac1
	ld a, [wIntroStateCounter]
	ld c, a ; unused
	ld a, $20
.asm_11aa5
	push af
	ld a, [hl]
	push hl
	ld c, $00
	ld b, a
	sra b
	rr c
	sra b
	rr c
	sra b
	rr c
	sra b
	rr c
	sra b
	rr c ; /32

	ld hl, $0
	ld a, [wdafd]
.loop_multiply
	add hl, bc
	dec a
	jr nz, .loop_multiply
	; hl = bc * wdafd

	ld a, h
	ld [de], a
	inc de
	pop hl
	ld bc, $4
	add hl, bc
	pop af
	dec a
	jr nz, .asm_11aa5
	pop de
	ld a, [wIntroStateCounter]
	and $03
	ret nz
	ld hl, wdafd
	dec [hl]
	ret

.LoadSubtitlePals:
	push bc
	push de
	push hl
	ld hl, rBGPI
	ld a, $a8
	ld [hl], a
	ld de, rBGPD
	ld hl, wBackgroundPalettesCGB + $28
	ld c, 2 palettes
.asm_11af2
	ldh a, [rSTAT]
	and STAT_ON_OAM
	jr nz, .asm_11af2
	ld a, [hli]
	ld [de], a
	dec c
	jr nz, .asm_11af2
	pop hl
	pop de
	pop bc
	ret

AnimateTrademark:
	call SetFadePalsFrameFunc
	farcall SetAllBGPaletteFadeConfigsToDisabled
	ld a, $07
	farcall SetPaletteFadeConfigToEnabled
	ld a, $ff ; white
	farcall InitFadePalettes
	call FlushAllPalettes
	lb de, 0, 14
	ld a, $03
	call LoadTitleScreenGraphics
	farcall SaveTargetFadePals
	xor a
	ld b, $02
	farcall StartPalFadeFromBlackOrWhite
	ld a, 60
	call WaitAFramesForInput
	jr c, .asm_11b31 ; unnecessary jump
.asm_11b31
	farcall SetAllBGPaletteFadeConfigsToEnabled
	call UnsetFadePalsFrameFunc
	ret

AnimateSubtitleExit:
	call .Animate
	jr c, .asm_11b46
	ld a, 80
	call WaitAFramesForInput
	jr c, .asm_11b46
	ret
.asm_11b46
	call SetFadePalsFrameFunc
	farcall StartFadeToWhite
	farcall WaitPalFading
	call UnsetFadePalsFrameFunc
	ret

.Animate:
	xor a
	ld [wdabd], a
	ld [wdabf], a
	call .ApplyEffect
	ret c
	ld hl, .ClearBoxParams
	ld c, 7
.asm_11b65
	push bc
	ld d, [hl]
	inc hl
	ld e, [hl]
	inc hl
	ld b, [hl]
	inc hl
	ld c, [hl]
	inc hl
	push hl
	call ClearBoxInBGMap
	pop hl
	ld d, [hl]
	inc hl
	ld e, [hl]
	inc hl
	ld b, [hl]
	inc hl
	ld c, [hl]
	inc hl
	push hl
	call ClearBoxInBGMap
	pop hl
	push hl
	call .ApplyEffect
	pop hl
	pop bc
	jr c, .clear_subtitle
	dec c
	jr nz, .asm_11b65
	ret
.clear_subtitle
	push af
	lb de, 0, 6
	lb bc, 20, 7
	call ClearBoxInBGMap
	pop af
	ret

.ClearBoxParams:
	; top
	db  0,  6 ; coordinates
	db  3,  3 ; box dimensions
	; bottom
	db 18,  9 ; coordinates
	db  3,  4 ; box dimensions

	; top
	db  3,  6 ; coordinates
	db  3,  3 ; box dimensions
	; bottom
	db 15,  9 ; coordinates
	db  3,  4 ; box dimensions

	; top
	db  6,  6 ; coordinates
	db  3,  3 ; box dimensions
	; bottom
	db 12,  9 ; coordinates
	db  3,  4 ; box dimensions

	; top
	db  9,  6 ; coordinates
	db  3,  3 ; box dimensions
	; bottom
	db  9,  9 ; coordinates
	db  3,  4 ; box dimensions

	; top
	db 12,  6 ; coordinates
	db  3,  3 ; box dimensions
	; bottom
	db  6,  9 ; coordinates
	db  3,  4 ; box dimensions

	; top
	db 15,  6 ; coordinates
	db  3,  3 ; box dimensions
	; bottom
	db  3,  9 ; coordinates
	db  3,  4 ; box dimensions

	; top
	db 18,  6 ; coordinates
	db  3,  3 ; box dimensions
	; bottom
	db  0,  9 ; coordinates
	db  3,  4 ; box dimensions

.ApplyEffect:
	ld c, 10
.asm_11bd2
	call DoFrame
	ldh a, [hKeysPressed]
	and A_BUTTON | START
	scf
	ret nz
.asm_11bdb
	ldh a, [rLY]
	cp $91
	jr nc, .asm_11bdb
.asm_11be1
	ldh a, [rLY]
	cp $20
	jr c, .asm_11be1
	; $20 <= rLY < $91
	di
.asm_11be8
	ldh a, [rLY]
	cp $2f
	jr c, .asm_11be8
	call WaitForLCDOff
	ld a, [wdabd]
	ldh [rSCX], a
	ei
.asm_11bf7
	ldh a, [rLY]
	cp $3c
	jr c, .asm_11bf7
	di
.asm_11bfe
	ldh a, [rLY]
	cp $48
	jr c, .asm_11bfe
	call WaitForLCDOff
	ld a, [wdabf]
	ldh [rSCX], a
	ei
.asm_11c0d
	ldh a, [rLY]
	cp $58
	jr c, .asm_11c0d
	di
.asm_11c14
	ldh a, [rLY]
	cp $68
	jr c, .asm_11c14
	call WaitForLCDOff
	xor a
	ldh [rSCX], a
	ei
	ld a, [wdabd]
	add 3
	ld [wdabd], a
	ld a, [wdabf]
	add -3
	ld [wdabf], a
	dec c
	jr nz, .asm_11bd2
	scf
	ccf
	ret

AnimateIntroCards:
	xor a
	ld [wIntroCardIndex], a
.loop_cards
	call .DrawCurrentIntroCard
	call .AnimateEntrance
	jr c, .FadeOutAndExit
	call .WaitInput
	jr c, .FadeOutAndExit
	call .AnimateExit
	jr c, .FadeOutAndExit
	ld a, [wIntroCardIndex]
	inc a
	ld [wIntroCardIndex], a
	cp NUM_TITLE_SCREEN_CARDS
	jr nz, .loop_cards
	ld a, 30
	call WaitAFramesForInput
	ret

.FadeOutAndExit
	call SetFadePalsFrameFunc
	farcall StartFadeToWhite
	farcall WaitPalFading
	call UnsetFadePalsFrameFunc
	ret

.DrawCurrentIntroCard:
	ld a, [wIntroCardIndex]
	add a ; *2
	ld c, a
	ld b, $00
	ld hl, wTitleScreenCards
	add hl, bc
	ld e, [hl]
	inc hl
	ld d, [hl]
	lb bc, 20, 7
	call DrawIntroCardGfx
	call FlushAllPalettes
	ret

.AnimateEntrance:
	call ScrollIntroCard
	jr c, .asm_11c90
	lb bc, 6, 7
	call Func_1340c
.asm_11c90
	ret

.AnimateExit:
	lb de, 20, 7
	lb bc, 8, 6
	call FillBoxInBGMapWithZero
	call ScrollIntroCard
	lb de, 6, 7
	lb bc, 8, 6
	call FillBoxInBGMapWithZero
	ret

.WaitInput:
	ld a, 240
	call WaitAFramesForInput
	ret

ChooseTitleScreenCards:
	ld hl, wTitleScreenCards
	farcall _ChooseTitleScreenCards
	ret

ScrollIntroCard:
	ldh a, [rSCX]
	ld [wdabd], a
	ld c, 28
.asm_11cbc
	call DoFrame
	ldh a, [hKeysPressed]
	and A_BUTTON | START
	scf
	jr nz, .done
.asm_11cc6
	ldh a, [rLY]
	cp $91
	jr nc, .asm_11cc6
.asm_11ccc
	ldh a, [rLY]
	cp $20
	jr c, .asm_11ccc
	; $20 <= rLY < $91
	di
.asm_11cd3
	ldh a, [rLY]
	cp $36
	jr c, .asm_11cd3
	call WaitForLCDOff
	ld a, [wdabd]
	ldh [rSCX], a
	ei
.asm_11ce2
	ldh a, [rLY]
	cp $50
	jr c, .asm_11ce2
	di
.asm_11ce9
	ldh a, [rLY]
	cp $68
	jr c, .asm_11ce9
	call WaitForLCDOff
	xor a
	ldh [rSCX], a
	ei
	ld a, [wdabd]
	add 4
	ld [wdabd], a
	dec c
	jr nz, .asm_11cbc
	scf
	ccf
.done
	ret

FadeInTitleScreenAfterIntroCards:
	call SetFadePalsFrameFunc
	farcall SetAllBGPaletteFadeConfigsToDisabled
	ld a, $05
	farcall SetPaletteFadeConfigToEnabled
	ld a, $06
	farcall SetPaletteFadeConfigToEnabled
	ld a, $ff ; white
	farcall InitFadePalettes
	call FlushAllPalettes

	ld a, $01
	lb de, 1, 6
	call LoadTitleScreenGraphics

	ld a, $02
	lb de, 1, 9
	call LoadTitleScreenGraphics

	farcall SaveTargetFadePals
	xor a
	ld b, $0f
	farcall StartPalFadeFromBlackOrWhite
	ld bc, 600
	call WaitBCFramesForInput
	farcall SetAllBGPaletteFadeConfigsToEnabled
	call UnsetFadePalsFrameFunc
	ret

FadeInTitleScreen:
	call DisableLCD
	call ClearSpriteAnimsAndSetInitialGraphicsConfiguration
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
	ld a, $03
	call LoadTitleScreenGraphics
	bank1call SetFontAndTextBoxFrameColor
	call EnableLCD
	call SetFadePalsFrameFunc
	farcall StartFadeFromWhite
	farcall WaitPalFading
	call UnsetFadePalsFrameFunc
	ret

; clears a bxc box at coordinates de
ClearBoxInBGMap:
	di
	push bc
	ld b, d
	ld c, e
	call BCCoordToBGMap0Address
	pop bc
.loop_rows
	push bc
	push hl
.loop_columns
	xor a
	call BankswitchVRAM
	call WaitForLCDOff
	xor a
	ld [hl], a
	ld a, $01
	call BankswitchVRAM
	call WaitForLCDOff
	xor a
	ld [hli], a
	dec b
	jr nz, .loop_columns
	pop hl
	ld de, BG_MAP_WIDTH
	add hl, de
	pop bc
	dec c
	jr nz, .loop_rows
	xor a
	call BankswitchVRAM
	ei
	ret
; 0x11db2

SECTION "Bank 4@5dd2", ROMX[$5dd2], BANK[$4]

; used for Title Screen subtitle distortion BG effect
Data_11dd2:
	db $00, $03, $06, $09
	db $0c, $0f, $12, $15
	db $18, $1b, $1e, $20
	db $23, $26, $28, $2a
	db $2d, $2f, $31, $33
	db $35, $36, $38, $39
	db $3b, $3c, $3d, $3e
	db $3e, $3f, $3f, $3f
	db $40, $3f, $3f, $3f
	db $3e, $3e, $3d, $3c
	db $3b, $39, $38, $36
	db $35, $33, $31, $2f
	db $2d, $2a, $28, $26
	db $23, $20, $1e, $1b
	db $18, $15, $12, $0f
	db $0c, $09, $06, $03
	db $00, $fd, $fa, $f7
	db $f4, $f1, $ee, $eb
	db $e8, $e5, $e2, $e0
	db $dd, $da, $d8, $d6
	db $d3, $d1, $cf, $cd
	db $cb, $ca, $c8, $c7
	db $c5, $c4, $c3, $c2
	db $c2, $c1, $c1, $c1
	db $c0, $c1, $c1, $c1
	db $c2, $c2, $c3, $c4
	db $c5, $c7, $c8, $ca
	db $cb, $cd, $cf, $d1
	db $d3, $d6, $d8, $da
	db $dd, $e0, $e2, $e5
	db $e8, $eb, $ee, $f1
	db $f4, $f7, $fa, $fd

; used for Title Screen title expansion BG effect
Data_11e52:
	db $28, $14, $28, $0d, $1a, $28, $0a, $14, $1e, $28, $08, $10, $18, $20, $28, $06, $0d, $14, $1a, $21
	db $28, $05, $0b, $11, $16, $1c, $22, $28, $05, $0a, $0f, $14, $19, $1e, $23, $28, $04, $08, $0d, $11
	db $16, $1a, $1f, $23, $27, $04, $08, $0c, $10, $14, $18, $1c, $20, $24, $28, $03, $07, $0a, $0e, $12
	db $15, $19, $1d, $20, $24, $28, $03, $06, $0a, $0d, $10, $14, $17, $1a, $1d, $21, $24, $28, $03, $06
	db $09, $0c, $0f, $12, $15, $18, $1b, $1e, $21, $24, $28, $02, $05, $08, $0b, $0e, $11, $14, $16, $19
	db $1c, $1f, $22, $25, $28, $02, $05, $08, $0a, $0d, $0f, $12, $15, $18, $1a, $1d, $20, $22, $25, $28
	db $02, $05, $07, $0a, $0c, $0f, $11, $14, $16, $19, $1b, $1e, $20, $23, $25, $28, $02, $04, $07, $09
	db $0b, $0e, $10, $12, $15, $17, $19, $1c, $1e, $20, $23, $25, $28, $02, $04, $06, $08, $0b, $0d, $0f
	db $11, $13, $16, $18, $1a, $1c, $1f, $21, $23, $25, $28, $02, $04, $06, $08, $0a, $0c, $0e, $10, $12
	db $15, $17, $19, $1b, $1d, $1f, $21, $23, $25, $28, $02, $04, $06, $08, $0a, $0c, $0e, $10, $12, $14
	db $16, $18, $1a, $1c, $1e, $20, $22, $24, $26, $28, $01, $03, $05, $07, $09, $0b, $0d, $0f, $11, $13
	db $14, $16, $18, $1a, $1c, $1e, $20, $22, $24, $26, $28, $01, $03, $05, $07, $09, $0a, $0c, $0e, $10
	db $12, $13, $15, $17, $19, $1b, $1d, $1e, $20, $22, $24, $26, $28, $01, $03, $05, $06, $08, $0a, $0c
	db $0d, $0f, $11, $13, $14, $16, $18, $1a, $1b, $1d, $1f, $21, $22, $24, $26, $28, $01, $03, $05, $06
	db $08, $0a, $0b, $0d, $0e, $10, $12, $14, $15, $17, $19, $1a, $1c, $1e, $1f, $21, $23, $24, $26, $28
	db $01, $03, $04, $06, $08, $09, $0b, $0c, $0e, $0f, $11, $13, $14, $16, $18, $19, $1b, $1c, $1e, $20
	db $21, $23, $24, $26, $28, $01, $03, $04, $06, $07, $09, $0a, $0c, $0d, $0f, $10, $12, $14, $15, $17
	db $18, $1a, $1b, $1d, $1e, $20, $21, $23, $24, $26, $28, $01, $02, $04, $05, $07, $08, $0a, $0b, $0d
	db $0e, $10, $11, $13, $14, $16, $17, $19, $1a, $1c, $1d, $1f, $20, $22, $23, $25, $26, $28, $01, $02
	db $04, $05, $07, $08, $0a, $0b, $0c, $0e, $0f, $11, $12, $13, $15, $16, $18, $19, $1b, $1c, $1d, $1f
	db $20, $22, $23, $25, $26, $28, $01, $02, $04, $05, $06, $08, $09, $0b, $0c, $0d, $0f, $10, $11, $13
	db $14, $16, $17, $18, $1a, $1b, $1c, $1e, $1f, $21, $22, $23, $25, $26, $28, $01, $02, $04, $05, $06
	db $07, $09, $0a, $0c, $0d, $0e, $10, $11, $12, $13, $15, $16, $17, $19, $1a, $1b, $1d, $1e, $1f, $21
	db $22, $23, $25, $26, $28, $01, $02, $03, $05, $06, $07, $09, $0a, $0b, $0c, $0e, $0f, $10, $12, $13
	db $14, $15, $17, $18, $19, $1b, $1c, $1d, $1e, $20, $21, $22, $24, $25, $26, $28, $01, $02, $03, $05
	db $06, $07, $08, $0a, $0b, $0c, $0d, $0f, $10, $11, $12, $14, $15, $16, $17, $19, $1a, $1b, $1c, $1e
	db $1f, $20, $21, $23, $24, $25, $26, $28, $01, $02, $03, $04, $06, $07, $08, $09, $0a, $0c, $0d, $0e
	db $0f, $10, $12, $13, $14, $15, $17, $18, $19, $1a, $1b, $1d, $1e, $1f, $20, $21, $23, $24, $25, $26
	db $28, $01, $02, $03, $04, $05, $07, $08, $09, $0a, $0b, $0c, $0e, $0f, $10, $11, $12, $13, $15, $16
	db $17, $18, $19, $1b, $1c, $1d, $1e, $1f, $20, $22, $23, $24, $25, $26, $28, $01, $02, $03, $04, $05
	db $06, $07, $09, $0a, $0b, $0c, $0d, $0e, $0f, $11, $12, $13, $14, $15, $16, $17, $19, $1a, $1b, $1c
	db $1d, $1e, $1f, $21, $22, $23, $24, $25, $26, $28, $01, $02, $03, $04, $05, $06, $07, $08, $09, $0b
	db $0c, $0d, $0e, $0f, $10, $11, $12, $13, $15, $16, $17, $18, $19, $1a, $1b, $1c, $1d, $1f, $20, $21
	db $22, $23, $24, $25, $26, $28, $01, $02, $03, $04, $05, $06, $07, $08, $09, $0a, $0b, $0c, $0e, $0f
	db $10, $11, $12, $13, $14, $15, $16, $17, $18, $19, $1b, $1c, $1d, $1e, $1f, $20, $21, $22, $23, $24
	db $25, $26, $28, $01, $02, $03, $04, $05, $06, $07, $08, $09, $0a, $0b, $0c, $0d, $0e, $0f, $10, $11
	db $12, $14, $15, $16, $17, $18, $19, $1a, $1b, $1c, $1d, $1e, $1f, $20, $21, $22, $23, $24, $25, $26
	db $28, $01, $02, $03, $04, $05, $06, $07, $08, $09, $0a, $0b, $0c, $0d, $0e, $0f, $10, $11, $12, $13
	db $14, $15, $16, $17, $18, $19, $1a, $1b, $1c, $1d, $1e, $1f, $20, $21, $22, $23, $24, $25, $26, $28
; 0x1215e

SECTION "Bank 4@6e68", ROMX[$6e68], BANK[$4]

; bc = TILEMAP_* constant
LoadAttrmap::
	push af
	push bc
	push de
	push hl
	farcall GetTilemapGfxPointer
	xor a
	ld c, $80
	farcall Func_12c10b
	pop hl
	pop de
	pop bc
	pop af
	ret
; 0x12e7c

SECTION "Bank 4@6e87", ROMX[$6e87], BANK[$4]

SetCthSpriteAnimPosition:
	push bc
	push hl
	call GetCthSpriteAnim
	call SetSpriteAnimPosition
	pop hl
	pop bc
	ret

; de = FRAMESET_* constant
SetCthSpriteAnimFrameset:
	push bc
	push hl
	call GetCthSpriteAnim
	ld b, d
	ld c, e
	call SetAndInitSpriteAnimFrameset
	call SetSpriteAnimAnimating
	pop hl
	pop bc
	ret

SetCthSpriteAnimStartDelay:
	push bc
	push hl
	call GetCthSpriteAnim
	call SetSpriteAnimStartDelay
	pop hl
	pop bc
	ret

Func_12ead:
	push hl
	call GetCthSpriteAnim
	call CheckIsSpriteAnimAnimating
	call SetSpriteAnimAnimating
	pop hl
	ret
; 0x12eb9

SECTION "Bank 4@73f0", ROMX[$73f0], BANK[$4]

; de = card ID
DrawIntroCardGfx:
	push af
	push bc
	push de
	push hl
	push bc
	ld c, $80
	call LoadCardGfx_FromCardID
	pop de
	ld c, $01
	call CopyCardPalettesToBGPals
	ld b, $80
	ld c, $01
	call Func_1347a
	pop hl
	pop de
	pop bc
	pop af
	ret

; bc = coordinates
Func_1340c:
	push af
	push bc
	push de
	push hl
	ld d, b
	ld e, c
	ld b, $80
	ld c, $01
	call Func_1347a
	pop hl
	pop de
	pop bc
	pop af
	ret

; de = card ID
; c = address selector in VRAM
;     if $80, then v0Tiles1
;     if $00, then v0Tiles2
LoadCardGfx_FromCardID:
	push af
	push bc
	push de
	push hl
	push bc
	call LoadCardDataToBuffer1_FromCardID
	pop bc
	ld hl, wLoadedCard1Gfx
	ld a, [hli]
	ld h, [hl]
	ld l, a
	push hl
	ld a, $80
	add c
	ld c, a
	ld b, $00
	sla c
	rl b
	sla c
	rl b
	sla c
	rl b
	sla c
	rl b ; *TILE_SIZE
	ld hl, v0Tiles1
	add hl, bc
	ld d, h
	ld e, l
	pop hl
	xor a
	call BankswitchVRAM
	lb bc, $30, TILE_SIZE
	call LoadCardGfx
	pop hl
	pop de
	pop bc
	pop af
	ret

; c = starting BG pal index
CopyCardPalettesToBGPals:
	push af
	push bc
	push de
	push hl
	ld b, $00
	sla c
	sla c
	sla c ; *CGB_PAL_SIZE
	ld hl, wBackgroundPalettesCGB
	add hl, bc
	ld d, h
	ld e, l
	ld hl, wCardPalettes
	ld bc, 3 palettes
	call CopyBCBytesFromHLToDE
	pop hl
	pop de
	pop bc
	pop af
	ret

; de = coordinates
Func_1347a:
	push af
	push bc
	push de
	push hl
	ld a, b
	ld [wCardTilemapOffset], a
	ld a, c
	ld [wddf5], a
	ld b, d
	ld c, e
	call BCCoordToBGMap0Address
	xor a
	call BankswitchVRAM
	call .ApplyTilemap
	ld a, $01
	call BankswitchVRAM
	call .ApplyAttrmap
	pop hl
	pop de
	pop bc
	pop af
	ret

.ApplyTilemap:
	push de
	ld hl, .CardTilemap
	ld de, wCardTilemap
	ld a, [wCardTilemapOffset]
	ld c, a
	ld b, $30 ; card size in tiles
.loop_copy
	ld a, [hli]
	add c
	ld [de], a
	inc de
	dec b
	jr nz, .loop_copy
	pop de
	ld hl, wCardTilemap
	call .CopyCardDataToBGMap
	ret

.CardTilemap:
	db $00, $06, $0c, $12, $18, $1e, $24, $2a, $01, $07, $0d, $13, $19, $1f, $25, $2b
	db $02, $08, $0e, $14, $1a, $20, $26, $2c, $03, $09, $0f, $15, $1b, $21, $27, $2d
	db $04, $0a, $10, $16, $1c, $22, $28, $2e, $05, $0b, $11, $17, $1d, $23, $29, $2f

.ApplyAttrmap:
	push de
	ld hl, wCardAttrMap
	ld de, wddc4
	ld a, [wddf5]
	ld c, a
	ld b, $30 ; card size in tiles
.asm_134f8
	ld a, [hli]
	rlca
	rlca
	and $03 ; palette
	add c
	ld [de], a
	inc de
	dec b
	jr nz, .asm_134f8
	pop de
	ld hl, wddc4
	call .CopyCardDataToBGMap
	ret

.CopyCardDataToBGMap:
	push af
	push bc
	push de
	push hl
	ld b, $8 ; card width
	ld c, $6 ; card height
.loop_rows
	push bc
	call SafeCopyDataHLtoDE
	push hl
	ld h, d
	ld l, e
	ld bc, BG_MAP_WIDTH - 8 ; start of next line
	add hl, bc
	ld d, h
	ld e, l
	pop hl
	pop bc
	dec c
	jr nz, .loop_rows
	pop hl
	pop de
	pop bc
	pop af
	ret
; 0x1352a

SECTION "Bank 4@7cc6", ROMX[$7cc6], BANK[$4]

Func_13cc6:
	call EnableSRAM
	ld hl, $a01d
	ld [hl], a
	call DisableSRAM
	ret
; 0x13cd1

SECTION "Bank 4@7dcd", ROMX[$7dcd], BANK[$4]

Func_13dcd:
	push af
	push bc
	push de
	push hl
	and a
	ld a, $00
	jr z, .asm_13ddc
	farcall Func_d6d3
	jr .asm_13de0
.asm_13ddc
	farcall Func_d6e3
.asm_13de0
	call .Func_13deb
	call Func_13cc6
	pop hl
	pop de
	pop bc
	pop af
	ret

.Func_13deb:
	push hl
	ld a, $00
	farcall Func_d698
	ld a, $00
	jr z, .asm_13df8
	ld a, $01
.asm_13df8
	pop hl
	ret

Func_13dfa:
	call DisableLCD
	call Func_10d40
	call Func_102ef
	call EnableLCD
	ld a, $01
	ld [wce4d], a
	call ResetFrameFunctionStack
	call Func_3cdd
	farcall SetAllPaletteFadeConfigsToEnabled
	ld a, $ff
	farcall InitFadePalettes
	call Func_3f61
	farcall Func_1dfb9
	farcall Func_1e419
	ret
; 0x13e27
