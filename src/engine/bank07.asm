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

; return TRUE if wOWMap is in Game Center
CheckIfGameCenter:
	push bc
	push de
	push hl
	ld hl, .GameCenterMaps
	ld c, MAP_CARD_DUNGEON_QUEEN - MAP_GAME_CENTER_ENTRANCE + 1
	ld b, 0
.loop_lookup
	push hl
	ld a, [wOWMap]
	ld e, a
	ld a, [hli]
	cp e
	jr nz, .next
	ld a, [wOWMap + 1]
	ld e, a
	ld a, [hl]
	cp e
	jr nz, .next
	inc b
.next
	pop hl
	inc hl
	inc hl
	dec c
	jr nz, .loop_lookup
	ld a, b
	and a
	pop hl
	pop de
	pop bc
	ret

.GameCenterMaps:
	dw MAP_GAME_CENTER_ENTRANCE
	dw MAP_GAME_CENTER_LOBBY
	dw MAP_GAME_CENTER_1
	dw MAP_GAME_CENTER_2
	dw MAP_CARD_DUNGEON_PAWN
	dw MAP_CARD_DUNGEON_KNIGHT
	dw MAP_CARD_DUNGEON_BISHOP
	dw MAP_CARD_DUNGEON_ROOK
	dw MAP_CARD_DUNGEON_QUEEN
	; no sentinels

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

SECTION "Bank 7@416e", ROMX[$416e], BANK[$7]

PauseMenuConfigScreen:
	farcall Func_1022a
	call ShowConfigMenu
	farcall Func_10252
	ret

ShowConfigMenu:
	push af
	push bc
	push de
	push hl
	call LoadSavedOptions
	call DrawAndHandleConfigMenu
	call SaveConfigMenuChoicesToSRAM
	pop hl
	pop de
	pop bc
	pop af
	ret

DrawAndHandleConfigMenu:
	farcall ClearSpriteAnimsAndSetInitialGraphicsConfiguration
	call DrawConfigMenu
	farcall SetFrameFuncAndFadeFromWhite
	call HandleConfigMenu
	farcall FadeToWhiteAndUnsetFrameFunc
	ret

DrawConfigMenu:
	lb de, 0, 0
	lb bc, 20, 4
	call DrawRegularTextBoxVRAM0
	lb de, 0, 4
	lb bc, 20, 4
	call DrawRegularTextBoxVRAM0
	lb de, 0, 8
	lb bc, 20, 4
	call DrawRegularTextBoxVRAM0
	lb de, 0, 12
	lb bc, 20, 4
	call DrawRegularTextBoxVRAM0
	ld b, $07
	ld hl, $44ee
	lb de, 1, 17
	call LoadMenuBoxParams
	ld b, $07
	ld hl, $4476
	lb de, 6, 2
	call LoadMenuBoxParams
	ld a, [wMessageSpeedSetting]
	call DrawMenuBox
	ld b, $07
	ld hl, $449a
	lb de, 1, 6
	call LoadMenuBoxParams
	ld a, [wDuelAnimationsSetting]
	call DrawMenuBox
	ld b, $07
	ld hl, $44b6
	lb de, 1, 10
	call LoadMenuBoxParams
	ld a, [wCoinTossAnimationSetting]
	call DrawMenuBox
	ld b, $07
	ld hl, $44ce
	lb de, 1, 14
	call LoadMenuBoxParams
	ld a, [wTextBoxFrameColor]
	call DrawMenuBox
	ldtx hl, ConfigMessageSpeedText
	lb de, 1, 0
	call Func_2c4b
	ldtx hl, ConfigDuelAnimationText
	lb de, 1, 4
	call Func_2c4b
	ldtx hl, ConfigCoinAnimationText
	lb de, 1, 8
	call Func_2c4b
	ldtx hl, ConfigFrameColorText
	lb de, 1, 12
	call Func_2c4b
	ldtx hl, ConfigMessageSpeedSlowLabelText
	lb de, 2, 2
	call InitTextPrinting_ProcessTextFromIDVRAM0
	ldtx hl, ConfigMessageSpeedFastLabelText
	lb de, 16, 2
	call InitTextPrinting_ProcessTextFromIDVRAM0
	ldtx hl, ConfigExitText
	lb de, 2, 17
	call InitTextPrinting_ProcessTextFromIDVRAM0
	ret

HandleConfigMenu:
	ld a, [wSelectedConfigSubmenu]
	ld c, a
	inc a
	dec a
	jr z, .exit_menu_box
	dec a
	jr z, .message_speed_box
	dec a
	jr z, .duel_animations_box
	dec a
	jr z, .coin_toss_animation_box
	dec a
	jr z, .frame_color_box
.exit_menu_box
	ld c, 0
	call HandleConfigExitMenuBox
	jr nc, .done
	push af
	ld a, SFX_CURSOR
	call CallPlaySFX
	pop af
	ldh a, [hKeysPressed]
	and PAD_B
	jr nz, .done
	ldh a, [hKeysHeld]
	and PAD_UP
	jr nz, .frame_color_box
.message_speed_box
	ld c, 1
	call HandleMessageSpeedSettingMenuBox
	push af
	ld a, SFX_CURSOR
	call CallPlaySFX
	pop af
	ldh a, [hKeysPressed]
	and PAD_B
	jr nz, .done
	ldh a, [hKeysHeld]
	and PAD_UP
	jr nz, .exit_menu_box
.duel_animations_box
	ld c, 2
	call HandleDuelAnimationsSettingMenuBox
	push af
	ld a, SFX_CURSOR
	call CallPlaySFX
	pop af
	ldh a, [hKeysPressed]
	and PAD_B
	jr nz, .done
	ldh a, [hKeysHeld]
	and PAD_UP
	jr nz, .message_speed_box
.coin_toss_animation_box
	ld c, 3
	call HandleCoinTossAnimationSettingMenuBox
	push af
	ld a, SFX_CURSOR
	call CallPlaySFX
	pop af
	ldh a, [hKeysPressed]
	and PAD_B
	jr nz, .done
	ldh a, [hKeysHeld]
	and PAD_UP
	jr nz, .duel_animations_box
.frame_color_box
	ld c, 4
	call HandleTextBoxFrameColorSettingMenuBox
	push af
	ld a, SFX_CURSOR
	call CallPlaySFX
	pop af
	ldh a, [hKeysPressed]
	and PAD_B
	jr nz, .done
	ldh a, [hKeysHeld]
	and PAD_UP
	jr nz, .coin_toss_animation_box
	jp .exit_menu_box
.done
	push af
	ld a, SFX_CONFIRM
	call CallPlaySFX
	pop af
	ld a, c
	ld [wSelectedConfigSubmenu], a
	ret

HandleMessageSpeedSettingMenuBox:
	ld b, $07
	ld hl, $4476
	lb de, 6, 2
	ld a, [wMessageSpeedSetting]
	call LoadMenuBoxParams
	ld a, 8
	call SetMenuBoxDelay
	ld a, [wMessageSpeedSetting]
	call HandleMenuBox
	ld [wMessageSpeedSetting], a
	ret

HandleDuelAnimationsSettingMenuBox:
	ld b, $07
	ld hl, $449a
	lb de, 1, 6
	ld a, [wDuelAnimationsSetting]
	call LoadMenuBoxParams
	ld a, 8
	call SetMenuBoxDelay
	ld a, [wDuelAnimationsSetting]
	call HandleMenuBox
	ld [wDuelAnimationsSetting], a
	ret

HandleCoinTossAnimationSettingMenuBox:
	ld b, $07
	ld hl, $44b6
	lb de, 1, 10
	ld a, [wCoinTossAnimationSetting]
	call LoadMenuBoxParams
	ld a, 8
	call SetMenuBoxDelay
	ld a, [wCoinTossAnimationSetting]
	call HandleMenuBox
	ld [wCoinTossAnimationSetting], a
	ret

HandleTextBoxFrameColorSettingMenuBox:
	ld b, $07
	ld hl, $44ce
	lb de, 1, 14
	ld a, [wTextBoxFrameColor]
	call LoadMenuBoxParams
	ld a, 8
	call SetMenuBoxDelay
	ld a, [wTextBoxFrameColor]
	call HandleMenuBox
	ld [wTextBoxFrameColor], a
	ret

HandleConfigExitMenuBox:
	ld b, $07
	ld hl, $44ee
	lb de, 1, 17
	xor a
	call LoadMenuBoxParams
	ld a, 8
	call SetMenuBoxDelay
	xor a
	call HandleMenuBox
	ret
; 0x1c379

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
	call ConvertTextSpeedToMessageSpeedSetting
	ld b, a
	ld a, 4
	sub b
	ld [wMessageSpeedSetting], a
	ret

.LoadDuelAnimation:
	ld a, [sDuelAnimationsSetting]
	ld [wDuelAnimationsSetting], a
	srl a
	and $01
	ld [wAnimationsDisabled], a
	ret

.LoadCoinTossAnimation:
	ld a, [sCoinTossAnimationSetting]
	ld [wCoinTossAnimationSetting], a
	ret

.LoadTextFrameColor:
	ld a, [sTextBoxFrameColor]
	ld [wTextBoxFrameColor], a
	ret

SaveConfigMenuChoicesToSRAM:
	call EnableSRAM
	call SaveMessageSpeed
	call SaveDuelAnimationsSetting
	call SaveCoinTossAnimationSetting
	call SaveTextBoxFrameColor
	call DisableSRAM
	ret

SaveMessageSpeed:
	ld a, [wMessageSpeedSetting]
	ld b, a
	ld a, 4
	sub b
	call ConvertMessageSpeedSettingToTextSpeed
	ld [sTextSpeed], a
	ld [wTextSpeed], a
	ret

SaveDuelAnimationsSetting:
	ld a, [wDuelAnimationsSetting]
	ld [sDuelAnimationsSetting], a
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
	db 0, 1, 1

SaveCoinTossAnimationSetting:
	ld a, [wCoinTossAnimationSetting]
	ld [sCoinTossAnimationSetting], a
	ret

SaveTextBoxFrameColor:
	ld a, [wTextBoxFrameColor]
	ld [sTextBoxFrameColor], a
	ret

InitDefaultConfigMenuSettings:
	ld a, 2
	ld [wMessageSpeedSetting], a
	xor a
	ld [wCoinTossAnimationSetting], a
	ld [wDuelAnimationsSetting], a
	ld [wTextBoxFrameColor], a
	ld [wSelectedConfigSubmenu], a
	ret

; a - message speed setting
; ret - a: text speed (in frames to wait between printing)
ConvertMessageSpeedSettingToTextSpeed:
	push bc
	ld c, a
	ld b, $00
	ld hl, .data
	add hl, bc
	ld a, [hl]
	pop bc
	ret

.data
	db 0, 1, 2, 4, 6

; a - text speed (in frames to wait between printing)
; ret - a: message speed setting
ConvertTextSpeedToMessageSpeedSetting:
	push bc
	ld c, a
	ld b, $00
	ld hl, .data
	add hl, bc
	ld a, [hl]
	pop bc
	ret

.data
	; values correspond to the 0,1,2,4,6 values just above
	db 0, 1, 2, 0, 3, 0, 4
; 0x1c45a

SECTION "Bank 7@4502", ROMX[$4502], BANK[$7]

PauseMenuDiaryScreen:
	farcall Func_1022a
	call PushRegistersAndShowDiaryScreen
	farcall Func_10252
	ret

PushRegistersAndShowDiaryScreen:
	push af
	push bc
	push de
	push hl
	call ShowDiaryScreen
	pop hl
	pop de
	pop bc
	pop af
	ret

ShowDiaryScreen:
	farcall ClearSpriteAnimsAndSetInitialGraphicsConfiguration
	farcall ClearSpriteAnims
	call DrawDiaryStatusBox
	farcall SetFadePalsFrameFunc
	call StartFadeFromWhite
	call WaitPalFading_Bank07
	ld c, $00
	call DrawSavePromptAndWaitForInput
	call StartFadeToWhite
	call WaitPalFading_Bank07
	farcall UnsetFadePalsFrameFunc
	ret

DrawDiaryStatusBox:
	lb de, 0, 0
	lb bc, 20, 12
	call DrawRegularTextBoxVRAM0
	lb de, 0, 12
	lb bc, 20, 6
	call DrawRegularTextBoxVRAM0
	ld hl, .TextItems
	call PlaceTextItemsVRAM0
	lb bc, 1, 3
	call DrawPlayerPortrait
	ldtx hl, PlayerDiaryTitleText
	lb de, 5, 1
	call PrintTextNoDelay_InitVRAM0
	ldtx hl, TxRam1Text
	lb de, 11, 4
	call PrintTextNoDelay_InitVRAM0
	call CountEventCoinsObtained
	ld l, a
	ld h, $00
	lb de, 16, 6
	ld a, 2
	ld b, TRUE
	call PrintNumber
	lb de, 13, 10
	farcall PrintPlayTime
	lb de, 12, 8
	farcall PrintCardAlbumProgress
	ret

.TextItems:
	textitem  7,  4, PlayerDiaryNameText
	textitem  7,  6, PlayerDiaryEventCoinText
	textitem 18,  6, PlayerDiaryCardsUnitText
	textitem  7,  8, PlayerDiaryAlbumText
	textitem  7, 10, PlayerDiaryPlayTimeText
	textitems_end

; c - ?
DrawSavePromptAndWaitForInput:
	push bc
	push de
	push hl
	ldtx hl, PlayerDiaryPromptText
	xor a
	farcall DrawWideTextBox_PrintTextWithYesOrNoMenu
	jr c, .asm_1c5ca
	ld a, c
	and a
	jr nz, .asm_1c5b9
	call Func_1c5d6
	jr .asm_1c5bc
.asm_1c5b9
	call SaveGame
.asm_1c5bc
	push af
	ld a, SFX_SAVE_GAME
	call CallPlaySFX
	pop af
	ldtx hl, PlayerDiarySavedText
	scf
	ccf
	jr .asm_1c5ce
.asm_1c5ca
	ldtx hl, PlayerDiaryCancelledText
	scf
.asm_1c5ce
	farcall PrintScrollableText_NoTextBoxLabelVRAM0
	pop hl
	pop de
	pop bc
	ret

Func_1c5d6:
	push af
	push bc
	push de
	push hl
	farcall Func_10ed3
	farcall Func_105de
	call SaveGame
	farcall Func_10ea7
	farcall Func_1059f
	pop hl
	pop de
	pop bc
	pop af
	ret

PauseMenuStatusScreen:
	farcall Func_1022a
	call PushRegistersAndShowStatusScreen
	farcall Func_10252
	ret

PushRegistersAndShowStatusScreen:
	push af
	push bc
	push de
	push hl
	call ShowStatusScreen
	pop hl
	pop de
	pop bc
	pop af
	ret

ShowStatusScreen:
	farcall ClearSpriteAnimsAndSetInitialGraphicsConfiguration
	farcall ClearSpriteAnims
	call DisableLCD
	call DrawStatusScreenTopBox
	call DrawStatusScreenBottomBox
	call EnableLCD
	farcall SetFrameFuncAndFadeFromWhite
	ld c, PAD_A | PAD_B
	farcall WaitForButtonPress
	farcall FadeToWhiteAndUnsetFrameFunc
	ret

DrawStatusScreenTopBox:
	lb de, 0, 0
	lb bc, 20, 8
	call DrawRegularTextBoxVRAM0
	ld hl, .TextItems
	call PlaceTextItemsVRAM0
	lb bc, 1, 1
	call DrawPlayerPortrait
	ldtx hl, TxRam1Text
	lb de, 11, 2
	call PrintTextNoDelay_InitVRAM0
	lb de, 13, 6
	farcall PrintPlayTime
	lb de, 12, 4
	farcall PrintCardAlbumProgress
	ret

.TextItems:
	textitem 7, 2, PlayerDiaryNameText
	textitem 7, 4, PlayerDiaryAlbumText
	textitem 7, 6, PlayerDiaryPlayTimeText
	textitems_end

DrawStatusScreenBottomBox:
	lb de, 0, 8
	lb bc, 20, 10
	call DrawRegularTextBoxVRAM0
	lb de, 1, 8
	lb bc, 9, 1
	farcall FillBoxInBGMapWithZero
	ld hl, .TextItems
	call PlaceTextItemsVRAM0
	call Func_1dfb5
	call GetCoinName
	lb de, 4, 12
	call InitTextPrinting_ProcessTextFromIDVRAM0
	call Func_1dfb5
	add $28
	lb de, 28, 108
	call CreateCoinAnimation
	call CheckObtainedGRCoinPieces
	add $40
	lb de, 28, 140
	call CreateCoinAnimation
	call CheckObtainedGRCoinPieces
	and a
	jr z, .asm_1c6b1
	ldtx hl, PlayerStatusGRCoinText
	lb de, 4, 14
	call InitTextPrinting_ProcessTextFromIDVRAM0
.asm_1c6b1
	ret

.TextItems:
	textitem 1,  8, PlayerStatusEventCoinTitleText
	textitem 4, 10, PlayerStatusCurrentCoinText
	textitems_end

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

HideNPCAnimsUnderMenuBox:
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

ShowNPCAnimsUnderMenuBox:
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
	call InitTextPrinting_ProcessTextFromIDVRAM0
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
	ld a, SFX_CURSOR
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
	ld a, SFX_CURSOR
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
	ld a, SFX_CURSOR
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
	ld a, SFX_CURSOR
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
	ld a, BANK("VRAM1")
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

; a - delay to set
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
	ld a, MUSIC_PC_MAIN_MENU
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
	lb de, $40, $90
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
	call PrintTextNoDelay_InitVRAM0

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
	menubox_params TRUE, 12, 4, \
		SYM_CURSOR_R, SYM_SPACE, SYM_CURSOR_R, SYM_CURSOR_R, \
		PAD_A, 0, FALSE, 0, StartMenuBoxUpdate, NULL
	textitem 2, 2, MainMenuNewGameText
	textitems_end

.Config1Params
	menubox_params TRUE, 12, 6, \
		SYM_CURSOR_R, SYM_SPACE, SYM_CURSOR_R, SYM_CURSOR_R, \
		PAD_A, 0, FALSE, 1, StartMenuBoxUpdate, NULL
	textitem 2, 2, MainMenuContinueFromDiaryText
	textitem 2, 4, MainMenuNewGameText
	textitems_end

.Config2Params
	menubox_params TRUE, 12, 8, \
		SYM_CURSOR_R, SYM_SPACE, SYM_CURSOR_R, SYM_CURSOR_R, \
		PAD_A, 0, FALSE, 1, StartMenuBoxUpdate, NULL
	textitem 2, 2, MainMenuCardPopText
	textitem 2, 4, MainMenuContinueFromDiaryText
	textitem 2, 6, MainMenuNewGameText
	textitems_end

.Config3Params
	menubox_params TRUE, 12, 10, \
		SYM_CURSOR_R, SYM_SPACE, SYM_CURSOR_R, SYM_CURSOR_R, \
		PAD_A, 0, FALSE, 1, StartMenuBoxUpdate, NULL
	textitem 2, 2, MainMenuCardPopText
	textitem 2, 4, MainMenuContinueFromDiaryText
	textitem 2, 6, MainMenuNewGameText
	textitem 2, 8, MainMenuContinueDuelText
	textitems_end

.Config4Params
	menubox_params TRUE, 12, 8, \
		SYM_CURSOR_R, SYM_SPACE, SYM_CURSOR_R, SYM_CURSOR_R, \
		PAD_A, 0, FALSE, 1, StartMenuBoxUpdate, NULL
	textitem 2, 2, MainMenuContinueFromDiaryText
	textitem 2, 4, MainMenuNewGameText
	textitem 2, 6, MainMenuContinueDuelText
	textitems_end

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
	call InitTextPrinting_ProcessTextFromIDVRAM0
	ret

.ContinueFromDiary:
	farcall GetCurrentLocationName
	call LoadTxRam2
	ldtx hl, TxRam2TextPadded
	lb de, 1, 10
	call Func_2c4b
	ld hl, .TextItems
	call PlaceTextItemsVRAM0

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
	textitems_end

.CardPop:
	lb de, 1, 12
	ldtx hl, MainMenuCardPopDialogText
	call InitTextPrinting_ProcessTextFromIDVRAM0
	ret

.ContinueDuel:
	lb de, 1, 12
	ldtx hl, MainMenuContinueDuelDialogText
	call InitTextPrinting_ProcessTextFromIDVRAM0
	ret

HandleStartMenuBox:
	ld a, -1
	ld [wMenuBoxLastFocusedItem], a
	ld a, [wMenuCursorPosition]
	call HandleMenuBox
	ld [wMenuCursorPosition], a
	jr c, .selected
	push af
	ld a, SFX_CONFIRM
	call CallPlaySFX
	pop af
	ret
.selected
	push af
	ld a, SFX_CANCEL
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
	farcall ClearSaveData
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
	dw $ffff

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
	call PlaceTextItemsVRAM0
	lb bc, 12, 3
	call DrawPlayerPortrait
	; print name
	ldtx hl, TxRam1Text
	lb de, 5, 4
	call PrintTextNoDelay_InitVRAM0
	; print gender
	farcall GetPlayerGender
	and a
	ldtx hl, PlayerGenderMaleText
	jr z, .got_gender_text
	ldtx hl, PlayerGenderFemaleText
.got_gender_text
	lb de, 5, 8
	call InitTextPrinting_ProcessTextFromIDVRAM0
	ret

.TextItems:
	textitem 2, 2, PlayerDiaryNameText
	textitem 2, 6, PlayerGenderText
	textitems_end

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

Func_1d46a:
	push hl
	farcall GetSpriteAnimBuffer
	farcall CheckIsSpriteAnimAnimating
	pop hl
	ret

; a: has-save flag
; if FALSE, initializes values for new save
; if TRUE, reads values from SRAM
ReadOrInitSaveData:
	ld hl, .FunctionMap
	call CallMappedFunction
	ret

.FunctionMap
	key_func FALSE, .Initialize
	key_func TRUE,  .Read
	db $ff ; end

.Initialize:
	ld a, PLAYER_MALE
	farcall SetPlayerGender

	; give Chansey coin
	ld a, EVENT_GOT_CHANSEY_COIN
	farcall MaxOutEventValue

	farcall ClearGameCenterChips
	call InitializeMailboxWRAM
	call Func_1d7a1
	call SetGiftCenterMenuCursorToQuit
	call Func_1dcb7

	; this is unnecessary since Card Pop list
	; was already cleared in InitSaveData
	farcall ClearCardPopNameList

	call EnableAnimations
	call ClearwMinicomMenuCursorPosition
	farcall SetPCMenuCursorToShutdown
	call InitDefaultConfigMenuSettings
	call SaveConfigMenuChoicesToSRAM
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
	call SetActiveMusicState
	farcall _ShowReceivedCardScreen
	call ClearTempActiveMusic
	farcall UnsetFadePalsFrameFunc
	farcall FadeToWhiteAndUnsetFrameFunc
	pop hl
	pop de
	pop bc
	pop af
	ret

Func_1d55d:
	farcall HideNPCAnimsUnderDialogBox
	call Func_1d594
	call Func_1d5aa
	jr c, .asm_1d57c
	farcall ShowNPCAnimsUnderDialogBox
	farcall Func_1022a
	call Func_1d584
	farcall Func_10252
	farcall HideNPCAnimsUnderDialogBox
.asm_1d57c
	call Func_1d59f
	farcall ShowNPCAnimsUnderDialogBox
	ret

Func_1d584:
	push af
	push bc
	push de
	push hl
	xor a
	ld [wdb18], a
	call Func_1d5b4
	pop hl
	pop de
	pop bc
	pop af
	ret

Func_1d594:
	ldtx de, ReceptionistText
	ldtx hl, GameCenterPrizeExchangeWelcomeText
	farcall PrintScrollableText_WithTextBoxLabelVRAM0
	ret

Func_1d59f:
	ldtx de, ReceptionistText
	ldtx hl, GameCenterPrizeExchangeComeAgainText
	farcall PrintScrollableText_WithTextBoxLabelVRAM0
	ret

Func_1d5aa:
	ldtx hl, GameCenterPrizeExchangePromptText
	ld a, $01
	farcall PrintScrollableText_WithTextBoxLabelWithYesOrNoMenu
	ret

Func_1d5b4:
	farcall ClearSpriteAnimsAndSetInitialGraphicsConfiguration
	call Func_1d5c7
	farcall SetFrameFuncAndFadeFromWhite
	call Func_1d66e
	farcall FadeToWhiteAndUnsetFrameFunc
	ret

Func_1d5c7:
	call Func_1d779
	ld de, $0
	ld b, $07
	ld hl, $564a
	call LoadMenuBoxParams
	ld a, [wdb18]
	call DrawMenuBox
	ldtx hl, PlayersChipsText
	lb de, 1, 0
	call Func_2c4b
	lb de, 14, 0
	lb bc, 5, 1
	farcall FillBoxInBGMapWithZero
	ldtx hl, PlayerDiaryCardsUnitText
	lb de, 18, 0
	call InitTextPrinting_ProcessTextFromIDVRAM0
	farcall GetGameCenterChips
	lb de, 14, 0
	ld h, b
	ld l, c
	ld a, 4
	ld b, TRUE
	call PrintNumber
	ld hl, wdb1a
	ld e, $02
	ld c, $05
.asm_1d60e
	ld a, [hli]
	call Func_1d618
	inc e
	inc e
	dec c
	jr nz, .asm_1d60e
	ret

Func_1d618:
	push af
	push bc
	push de
	push hl
	ld hl, $57a6
	add a
	add a
	ld c, a
	ld b, $00
	add hl, bc
	push hl
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld d, 2
	call InitTextPrinting_ProcessTextFromIDVRAM0
	pop hl
	inc hl
	inc hl
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, 4
	ld b, TRUE
	ld d, 14
	call PrintNumber
	ld d, 18
	ldtx hl, PlayerDiaryCardsUnitText
	call InitTextPrinting_ProcessTextFromIDVRAM0
	pop hl
	pop de
	pop bc
	pop af
	ret
; 0x1d64a

SECTION "Bank 7@566e", ROMX[$566e], BANK[$7]

Func_1d66e:
.asm_1d66e
	lb de, 1, 14
	ldtx hl, GameCenterPrizeExchangeChoosePrizeText
	farcall PrintTextInWideTextBox
	ld a, [wdb18]
	call HandleMenuBox
	ld [wdb18], a
	jr c, .asm_1d68c
	push af
	ld a, SFX_CONFIRM
	call CallPlaySFX
	pop af
	jr .asm_1d695
.asm_1d68c
	push af
	ld a, SFX_CANCEL
	call CallPlaySFX
	pop af
	jr .asm_1d6b2
.asm_1d695
	ldtx hl, GameCenterPrizeExchangeConfirmText
	ld a, $01
	farcall DrawWideTextBox_PrintTextWithYesOrNoMenu
	jr c, .asm_1d6b2
	call Func_1d6be
	jr c, .asm_1d6b2
	farcall ClearSpriteAnimsAndSetInitialGraphicsConfiguration
	call Func_1d5c7
	call StartFadeFromWhite
	call WaitPalFading_Bank07
.asm_1d6b2
	ldtx hl, GameCenterPrizeExchangeQuitConfirmText
	ld a, $01
	farcall DrawWideTextBox_PrintTextWithYesOrNoMenu
	jr c, .asm_1d66e
	ret

Func_1d6be:
	ld a, [wdb18]
	ld c, a
	ld b, $00
	ld hl, wdb1a
	add hl, bc
	ld a, [hl]
	ld [wdb19], a
	add a
	add a
	ld c, a
	ld b, $00
	ld hl, $57a6
	add hl, bc
	inc hl
	inc hl
	ld e, [hl]
	inc hl
	ld d, [hl]
	farcall GetGameCenterChips
	call CompareBCAndDE
	jr c, .asm_1d6fc
	ld b, d
	ld c, e
	farcall SubtractChips
	call StartFadeToWhite
	call WaitPalFading_Bank07
	ld a, [wdb19]
	ld hl, $5704
	call CallMappedFunction
	call WaitPalFading_Bank07
	ret
.asm_1d6fc
	ldtx hl, GameCenterNotEnoughChipsText
	farcall PrintScrollableText_NoTextBoxLabelVRAM0
	ret
; 0x1d704

SECTION "Bank 7@5779", ROMX[$5779], BANK[$7]

Func_1d779:
	ld a, [wdb1f]
	add a
	ld c, a
	ld b, $00
	ld hl, $5793
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld de, wdb1a
	ld c, $05
.asm_1d78c
	ld a, [hli]
	ld [de], a
	inc de
	dec c
	jr nz, .asm_1d78c
	ret
; 0x1d793

SECTION "Bank 7@57a1", ROMX[$57a1], BANK[$7]

Func_1d7a1:
	xor a
	ld [wdb1f], a
	ret
; 0x1d7a6

SECTION "Bank 7@57be", ROMX[$57be], BANK[$7]

Func_1d7be:
	farcall Func_1022a
	call Func_1d7ca
	farcall Func_10252
	ret

Func_1d7ca:
	push de
	push hl
	push af
	ld a, $03
	call CallSetVolume
	pop af
	call Func_1d813
	push af
	ld a, $07
	call CallSetVolume
	pop af
	call Func_1d7ec
	ld hl, wdb21
	ld c, [hl]
	inc hl
	ld b, [hl]
	ld a, [wdb20]
	pop hl
	pop de
	ret

Func_1d7ec:
	ld a, [wdb20]
	add a
	ld c, a
	ld b, $00
	add hl, bc
	ld a, [hli]
	ld [wdb21], a
	ld a, [hl]
	ld [wdb21 + 1], a
	ret
; 0x1d7fd

SECTION "Bank 7@5813", ROMX[$5813], BANK[$7]

Func_1d813:
	farcall ClearSpriteAnimsAndSetInitialGraphicsConfiguration
	call Func_1d886
	farcall SetFrameFuncAndFadeFromWhite
.asm_1d81e
	ld c, $00
.asm_1d820
	ld a, $00
	call SetAndInitCoinAnimation
.asm_1d825
	call UpdateRNGSources
	call DoFrame
	ldh a, [hKeysPressed]
	and PAD_A
	jr z, .asm_1d825
	call UpdateRNGSources
	and $01
	ld b, a
	push af
	ld a, SFX_COIN_TOSS
	call CallPlaySFX
	pop af
	ld a, b
	add $01
	call SetAndInitCoinAnimation
.asm_1d844
	call DoFrame
	call Func_1d46a
	jr nz, .asm_1d844
	ld a, b
	and $01
	jr nz, .asm_1d85a
	push af
	ld a, SFX_COIN_TOSS_POSITIVE
	call CallPlaySFX
	pop af
	jr .asm_1d861
.asm_1d85a
	push af
	ld a, SFX_COIN_TOSS_NEGATIVE
	call CallPlaySFX
	pop af
.asm_1d861
	ld a, b
	call Func_1d8c6
	ld a, $3c
	call DoAFrames_WithPreCheck
	ld a, b
	and a
	jr nz, .asm_1d874
	inc c
	ld a, c
	cp $0a
	jr nz, .asm_1d820
.asm_1d874
	ld a, c
	ld [wdb20], a
	cp $03
	jr nc, .asm_1d881
	call Func_1d8df
	jr nc, .asm_1d81e
.asm_1d881
	farcall FadeToWhiteAndUnsetFrameFunc
	ret

Func_1d886:
	push af
	push bc
	push de
	push hl
	farcall ClearSpriteAnims
	call Func_1dfb5
	ld de, $5858
	call CreateCoinAnimation
	ld a, $03
	call SetAndInitCoinAnimation
	lb de, 0, 12
	lb bc, 20, 6
	call DrawRegularTextBoxVRAM0
	ldtx hl, GameCenterCoinFlipTitleText
	lb de, 1, 12
	call Func_2c4b
	ldtx hl, GameCenterCoinFlipDialogText
	lb de, 1, 14
	call InitTextPrinting_ProcessTextFromIDVRAM0
	lb de, 0, 0
	lb bc, 20, 4
	farcall FillBoxInBGMapWithZero
	pop hl
	pop de
	pop bc
	pop af
	ret

Func_1d8c6:
	push af
	push bc
	and a
	jr nz, .asm_1d8cf
	ld a, SCENE_COIN_TOSS_RESULT_1
	jr .asm_1d8d1
.asm_1d8cf
	ld a, SCENE_COIN_TOSS_RESULT_2
.asm_1d8d1
	ld b, c
	sla b
	ld c, $00
	call LoadScene
	call FlushAllPalettes
	pop bc
	pop af
	ret

Func_1d8df:
	lb de, 0, 0
	lb bc, 8, 4
	farcall FillBoxInBGMapWithZero
	call DoFrame
	farcall TurnOnCurChipsHUD
	ldtx hl, GameCenterCoinFlipRetryPromptText
	ldtx de, AttendantText
	ld a, $01
	farcall PrintScrollableText_WithTextBoxLabelWithYesOrNoMenu
	jr c, .asm_1d914
	farcall GetGameCenterChips
	ld a, b
	or c
	jr z, .asm_1d91d
	ld bc, CHIPS_BET_COIN_FLIP
	farcall DecreaseChipsSmoothly
	ld a, 60
	call DoAFrames_WithPreCheck
	scf
	ccf
.asm_1d914
	farcall TurnOffCurChipsHUD
	ret c
	call Func_1d886
	ret
.asm_1d91d
	ldtx hl, GameCenterCoinFlipAttendantNotEnoughChipsText
	ldtx de, AttendantText
	farcall PrintScrollableText_WithTextBoxLabelVRAM0
	scf
	jr .asm_1d914
; 0x1d92a

SECTION "Bank 7@596e", ROMX[$596e], BANK[$7]

OWInteractionSlotMachine:
	farcall Func_1022a
	call SlotMachine
	farcall Func_10252
	ret

; a - chips per bet
SlotMachine:
	push af
	push bc
	push de
	push hl
	ld [wdb2f], a
	farcall AskToPlaySlots
	jr c, .done ; jump if player chose not to play
	push af
	ld a, $03
	call CallSetVolume
	pop af
	farcall StartSlotMachine
	push af
	ld a, $07
	call CallSetVolume
	pop af
.done
	pop hl
	pop de
	pop bc
	pop af
	ret

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

GiftCenter:
	push af
	push bc
	push de
	push hl
	farcall HideNPCAnimsUnderDialogBox
	call GiftCenter_PrintWelcome
	call GiftCenter_HandleMenu
	jr c, .exit
	ld a, [wGiftCenterMenuCursorPosition]
	cp GIFTCENTERMENU_QUIT
	jr z, .exit
	call GiftCenter_PrintSelectedService
	call GiftCenter_SaveRequest
	jr c, .exit
	call PauseSong_SaveState
	push af
	ld a, MUSIC_CARD_POP
	call SetMusic
	pop af
	call GiftCenter_ExecuteSelectedOption
	call ResumeSong_ClearTemp
.exit
	call GiftCenter_PrintComeAgain
	farcall ShowNPCAnimsUnderDialogBox
	pop hl
	pop de
	pop bc
	pop af
	ret

SetGiftCenterMenuCursorToQuit:
	ld a, GIFTCENTERMENU_QUIT
	ld [wGiftCenterMenuCursorPosition], a
	ret

GiftCenter_PrintWelcome:
	ldtx hl, GiftCenterWelcomeText
	ldtx de, ReceptionistText
	farcall PrintScrollableText_WithTextBoxLabelVRAM0
	ldtx hl, GiftCenterServicePromptText
	ldtx de, ReceptionistText
	farcall PrintScrollableText_WithTextBoxLabelVRAM0
	ret

GiftCenter_PrintComeAgain:
	ldtx hl, GiftCenterComeAgainText
	ldtx de, ReceptionistText
	farcall PrintScrollableText_WithTextBoxLabelVRAM0
	ret

GiftCenter_PrintSelectedService:
	ldtx hl, GiftCenterServiceAcknowledgementText
	ldtx de, ReceptionistText
	farcall PrintScrollableText_WithTextBoxLabelVRAM0
	ret

GiftCenter_SaveRequest:
	ldtx hl, GiftCenterServiceSaveRequestText
	ldtx de, ReceptionistText
	farcall PrintScrollableText_WithTextBoxLabelVRAM0
	ld c, $01
	call DrawSavePromptAndWaitForInput
	ret nc
	ldtx hl, GiftCenterServiceUnavailableSaveRequiredText
	ldtx de, ReceptionistText
	farcall PrintScrollableText_WithTextBoxLabelVRAM0
	ret

GiftCenter_HandleMenu:
	call .ShowMenu
	call .HandleInput
	call .RestoreNPCs
	ret

.ShowMenu:
	lb de, 4, 0
	ld b, BANK(.menu_params)
	ld hl, .menu_params
	call LoadMenuBoxParams
	ld a, [wGiftCenterMenuCursorPosition]
	call HideNPCAnimsUnderMenuBox
	call DrawMenuBox
	ret

.menu_params
	menubox_params TRUE, 16, 12, \
		SYM_CURSOR_R, SYM_SPACE, SYM_CURSOR_R, SYM_CURSOR_R, \
		PAD_A, PAD_B, FALSE, 1, NULL, NULL
	textitem 2,  2, GiftCenterSendCardsText
	textitem 2,  4, GiftCenterReceiveCardsText
	textitem 2,  6, GiftCenterSendDeckConfigurationText
	textitem 2,  8, GiftCenterReceiveDeckConfigurationText
	textitem 2, 10, GiftCenterQuitText
	textitems_end

.HandleInput:
	ld a, [wGiftCenterMenuCursorPosition]
	call HandleMenuBox
	ld [wGiftCenterMenuCursorPosition], a
	push af
	add a
	ld c, a
	ld b, $00
	ld hl, .text_table
	add hl, bc
	ld a, [hli]
	ld [wTxRam2], a
	ld a, [hl]
	ld [wTxRam2 + 1], a
	pop af
	jr c, .quit
	push af
	ld a, SFX_CONFIRM
	call CallPlaySFX
	pop af
	ret
.quit
	push af
	ld a, SFX_CANCEL
	call CallPlaySFX
	pop af
	ret

.text_table
	tx GiftCenterSendCardsText
	tx GiftCenterReceiveCardsText
	tx GiftCenterSendDeckConfigurationText
	tx GiftCenterReceiveDeckConfigurationText

.RestoreNPCs:
	call ShowNPCAnimsUnderMenuBox
	ret

GiftCenter_ExecuteSelectedOption:
	ld a, [wGiftCenterMenuCursorPosition]
	ld hl, .function_map
	call CallMappedFunction
	ret

.function_map
	key_func GIFTCENTERMENU_SEND_CARDS,                 .SendCards
	key_func GIFTCENTERMENU_RECEIVE_CARDS,              .ReceiveCards
	key_func GIFTCENTERMENU_SEND_DECK_CONFIGURATION,    .SendDeckConfiguration
	key_func GIFTCENTERMENU_RECEIVE_DECK_CONFIGURATION, .ReceiveDeckConfiguration
	db $ff ; end

.SendCards:
	farcall Func_1022a
	farcall SetFrameFuncAndFadeFromWhite
	farcall UnsetSpriteAnimationAndFadePalsFrameFunc
	xor a ; GIFTCENTERMENU_SEND_CARDS
	ld [wSelectedGiftCenterMenuItem], a
	farcall HandleGiftCenter
	farcall SetSpriteAnimationAndFadePalsFrameFunc
	farcall FadeToWhiteAndUnsetFrameFunc
	farcall Func_10252
	ret

.ReceiveCards:
	farcall Func_1022a
	farcall SetFrameFuncAndFadeFromWhite
	farcall UnsetSpriteAnimationAndFadePalsFrameFunc
	ld a, GIFTCENTERMENU_RECEIVE_CARDS
	ld [wSelectedGiftCenterMenuItem], a
	farcall HandleGiftCenter
	farcall SetSpriteAnimationAndFadePalsFrameFunc
	farcall FadeToWhiteAndUnsetFrameFunc
	farcall Func_10252
	ret

.SendDeckConfiguration:
	farcall Func_1022a
	farcall SetFrameFuncAndFadeFromWhite
	farcall UnsetSpriteAnimationAndFadePalsFrameFunc
	ld a, GIFTCENTERMENU_SEND_DECK_CONFIGURATION
	ld [wSelectedGiftCenterMenuItem], a
	farcall HandleGiftCenter
	farcall SetSpriteAnimationAndFadePalsFrameFunc
	farcall FadeToWhiteAndUnsetFrameFunc
	farcall Func_10252
	ret

.ReceiveDeckConfiguration:
	farcall Func_1022a
	farcall SetFrameFuncAndFadeFromWhite
	farcall UnsetSpriteAnimationAndFadePalsFrameFunc
	ld a, GIFTCENTERMENU_RECEIVE_DECK_CONFIGURATION
	ld [wSelectedGiftCenterMenuItem], a
	farcall HandleGiftCenter
	farcall SetSpriteAnimationAndFadePalsFrameFunc
	farcall FadeToWhiteAndUnsetFrameFunc
	farcall Func_10252
	ret

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
	call PauseSong_SaveState
	ld a, [wIncomingCoin]
	cp COIN_GR_START
	jr c, .not_coin_gr
	ld a, COIN_GR
	ld [wIncomingCoin], a
	xor a
	jr .got_frames

.not_coin_gr
	push af
	ld a, SFX_COIN_TOSS
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
	call CallPlaySong
	pop af
	call WaitForSongToFinish
	ld a, 60
	call DoAFrames_WithPreCheck
	call ResumeSong_ClearTemp
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
	call PrintTextNoDelay_InitVRAM0
	call Func_1dd08
	ld a, [wIncomingCoin]
	call GetCoinType
	push af
	ld a, b
	ld [wCoinPage], a
	pop af
	call Func_1dd89
	ret

PauseMenuCoinScreen:
	farcall Func_1022a
	call ShowCoinMenuWithoutIncomingCoin
	farcall Func_10252
	ret

ShowCoinMenuWithoutIncomingCoin::
	push af
	push bc
	push de
	push hl
	ld a, -1
	ld [wIncomingCoin], a
	call CoinMenu
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

CoinMenu:
	farcall ClearSpriteAnimsAndSetInitialGraphicsConfiguration
	farcall ClearSpriteAnims
	call DisableLCD
	call Func_1dce3
	call EnableLCD
	farcall SetFrameFuncAndFadeFromWhite
	call Func_1deac
	push af
	ld a, SFX_CONFIRM
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
	call InitTextPrinting_ProcessTextFromIDVRAM0
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
	call InitTextPrinting_ProcessTextFromIDVRAM0
	lb de,  4, 6
	lb bc, 12, 1
	farcall FillBoxInBGMapWithZero
	call GetCoinName
	call InitTextPrinting_ProcessTextFromIDVRAM0
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
	call InitTextPrinting_ProcessTextFromIDVRAM0
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
	menubox_params FALSE, 20, 7, \
		SYM_CURSOR_R, SYM_SPACE, SYM_CURSOR_R, SYM_CURSOR_R, \
		PAD_A, PAD_B, TRUE, 4, Func_1def1, NULL
	textitem  1,  1, SingleSpaceText
	textitem  6,  1, SingleSpaceText
	textitem 11,  1, SingleSpaceText
	textitem 16,  1, SingleSpaceText
	textitem  1,  5, SingleSpaceText
	textitem  6,  5, SingleSpaceText
	textitem 11,  5, SingleSpaceText
	textitem 16,  5, SingleSpaceText
	textitems_end

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
	ld a, SFX_DENIED
	call CallPlaySFX
	pop af
	ret
.exists
	push af
	ld a, SFX_COIN_TOSS
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
	ld a, SFX_CURSOR
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
	ld a, SFX_CURSOR
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
	ld a, SFX_CURSOR
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

GetwDuelAnimBufferSize:
	ld a, [wDuelAnimBufferSize]
	ret

GetwDuelAnimBufferCurPos:
	ld a, [wDuelAnimBufferCurPos]
	ret
; 0x1e411

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
	call CallPlaySong
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
	ld a, [wDuelistIntroText]
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
	tx DuelistIntroLightningClubMasterText
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
	tx DuelistIntroTapText
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
	call InitTextPrinting_ProcessTextFromIDVRAM0
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
	call InitTextPrinting_ProcessTextFromIDVRAM0
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

PauseMenuMinicomScreen:
	farcall Func_1022a
	call PushRegistersAndShowMinicomScreen
	farcall Func_10252
	ret

PushRegistersAndShowMinicomScreen:
	push af
	push bc
	push de
	push hl
	call ShowMinicomScreen
	pop hl
	pop de
	pop bc
	pop af
	ret

ClearwMinicomMenuCursorPosition:
	xor a
	ld [wMinicomMenuCursorPosition], a
	ret

ShowMinicomScreen:
	farcall ClearSpriteAnimsAndSetInitialGraphicsConfiguration
	call DrawMinicomMainScreen
	farcall SetFrameFuncAndFadeFromWhite
.loop
	call HandleMinicomMenuBox
	jr c, .end
	call CallMinicomMenuFunction
	jr c, .end
	call DisableLCD
	farcall ClearSpriteAnimsAndSetInitialGraphicsConfiguration
	call DrawMinicomMainScreen
	call EnableLCD
	jr .loop
.end
	farcall FadeToWhiteAndUnsetFrameFunc
	ret

DrawMinicomMainScreen:
	ld b, BANK(.menu)
	ld hl, .menu
	lb de, 0, 3
	call LoadMenuBoxParams
	ld a, [wMinicomMenuCursorPosition]
	call DrawMenuBox
	lb de, 0, 0
	lb bc, 20, 4
	call DrawRegularTextBoxVRAM0
	ldtx hl, PauseMenuMinicomText
	lb de, 7, 2
	call InitTextPrinting_ProcessTextFromIDVRAM0
	lb de, 0, 12
	lb bc, 20, 6
	call DrawRegularTextBoxVRAM0
	ldtx hl, MinicomDialogText
	lb de, 1, 14
	call InitTextPrinting_ProcessTextFromIDVRAM0
	call GetNewMailFlag
	jr z, .done
	ld b, BANK(.SpriteAnimGfxParams)
	ld hl, .SpriteAnimGfxParams
	ld d, 120
	ld e, 32
	ld a, $00
	ld c, $00
	call CreateSpriteAnim
.done
	ret

.menu:
	menubox_params TRUE, 20, 10, \
		SYM_CURSOR_R, SYM_SPACE, SYM_CURSOR_R, SYM_CURSOR_R, \
		PAD_A, PAD_B, FALSE, 1, NULL, NULL
	textitem 3, 2, MinicomDeckSaveMachineText
	textitem 3, 4, MinicomMailboxText
	textitem 3, 6, MinicomCardAlbumText
	textitem 3, 8, PCMenuShutdownText
	textitems_end

.SpriteAnimGfxParams:
	dw TILESET_SMALL_ENVELOPE
	dw SPRITE_ANIM_AA
	dw FRAMESET_173
	dw PALETTE_180

; return
;	 a - cursor position, used later in CallMinicomMenuFunction
HandleMinicomMenuBox:
	ld a, [wMinicomMenuCursorPosition]
	call HandleMenuBox
	ld [wMinicomMenuCursorPosition], a
	jr c, .cancel
	push af
	ld a, SFX_CONFIRM
	call CallPlaySFX
	pop af
	ret
.cancel
	push af
	ld a, SFX_CANCEL
	call CallPlaySFX
	pop af
	ret

; a - function table index
CallMinicomMenuFunction:
	ld hl, .minicom_functions
	call CallMappedFunction
	ret

.minicom_functions:
	key_func MINICOMMENU_DECK_SAVE_MACHINE, MinicomDeckSaveMachine
	key_func MINICOMMENU_MAILBOX,           MinicomMailbox
	key_func MINICOMMENU_CARD_ALBUM,        MinicomCardAlbum
	db $ff

MinicomDeckSaveMachine:
	farcall ClearSpriteAnimsAndSetInitialGraphicsConfiguration
	farcall HandleDeckSaveMachineMenu
	ret

MinicomCardAlbum:
	farcall ClearSpriteAnimsAndSetInitialGraphicsConfiguration
	farcall HandlePlayersCardsScreen
	ret

Func_1e849:
	farcall Func_1022a
	call MinicomDeckSaveMachine
	farcall Func_10252
	ret

AutoDeckMachine:
	farcall Func_1022a
	farcall ClearSpriteAnimsAndSetInitialGraphicsConfiguration
	farcall HandleAutoDeckMenu
	farcall Func_10252
	ret

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
	call PauseSong_SaveState
	push af
	ld a, MUSIC_BOOSTER_PACK
	call CallPlaySong
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
	call ResumeSong_ClearTemp
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
	tx SingleSpaceText,  DebugUnregisteredText              ; BOOSTER_DEBUG_10_STAR
	tx SingleSpaceText,  PresentPackText                    ; BOOSTER_PRESENT_10_ENERGY
	tx SingleSpaceText,  PresentPackText                    ; BOOSTER_PRESENT_FROM_ALL_SETS
	tx SingleSpaceText,  PresentPackText                    ; BOOSTER_PRESENT_FROM_NON_ROCKET_SETS
	tx SingleSpaceText,  PresentPackText                    ; BOOSTER_PRESENT_FROM_LATTER_4_SETS
	tx SingleSpaceText,  PresentPackText                    ; BOOSTER_PRESENT_FROM_ROCKET_SETS
	tx SingleSpaceText,  DebugUnregisteredText              ; BOOSTER_DEBUG_2_STAR

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
	db BEGINNING_POKEMON     ; BOOSTER_DEBUG_10_STAR
	db PRESENT_PACK          ; BOOSTER_PRESENT_10_ENERGY
	db PRESENT_PACK          ; BOOSTER_PRESENT_FROM_ALL_SETS
	db PRESENT_PACK          ; BOOSTER_PRESENT_FROM_NON_ROCKET_SETS
	db PRESENT_PACK          ; BOOSTER_PRESENT_FROM_LATTER_4_SETS
	db PRESENT_PACK          ; BOOSTER_PRESENT_FROM_ROCKET_SETS
	db BEGINNING_POKEMON     ; BOOSTER_DEBUG_2_STAR

.GetPack:
	call DoFrame
	farcall ClearSpriteAnims
	call DisableLCD
	call DoFrame
	ld a, [wCurBoosterPack]
	farcall GetBoosterPack
	ret

GrandMasterCupBracketScreen:
	farcall Func_1022a
	call ShowGrandMasterCupBracket
	farcall Func_10252
	ret

ShowGrandMasterCupBracket:
	push af
	push bc
	push de
	push hl
	call _ShowGrandMasterCupBracket
	pop hl
	pop de
	pop bc
	pop af
	ret

_ShowGrandMasterCupBracket:
	farcall ClearSpriteAnimsAndSetInitialGraphicsConfiguration
	farcall InitOWObjects
	call .LoadSceneAndPrintTitle
	call PrintGrandMasterCupCompetitorNames
	call DrawGrandMasterCupBracketAdvancementLines
	call PrintGrandMasterCupBracketChampion
	ld bc, PALETTE_161
	farcall GetPaletteGfxPointer
	ld c, $00
	call LoadGfxPalettes
	farcall SetFrameFuncAndFadeFromWhite
	ld c, PAD_B
	farcall WaitForButtonPress
	call Func_3f61
	farcall FadeToWhiteAndUnsetFrameFunc
	ret

.LoadSceneAndPrintTitle:
	ld a, SCENE_TOURNAMENT_TABLE
	lb bc, 0, 0
	call LoadScene
	lb de, 1, 1
	lb bc, 18, 1
	farcall FillBoxInBGMapWithZero
	ldtx hl, GrandMasterCupBracketTitleText
	lb de, 1, 1
	call InitTextPrinting_ProcessTextFromIDVRAM0
	ret

; a = competitor slot [0, 7]
; hl = text (name) to load
LoadGrandMasterCupCompetitorNames:
	push af
	push bc
	push de
	push hl
	ld d, h
	ld e, l
	add a
	ld c, a
	ld b, $00
	ld hl, wGrandMasterCupCompetitorNames
	add hl, bc
	ld [hl], e
	inc hl
	ld [hl], d
	pop hl
	pop de
	pop bc
	pop af
	ret

InitGrandMasterCupBracket:
	push af
	push hl
	xor a
	ldtx hl, TxRam1Text
.loop_init_names
	call LoadGrandMasterCupCompetitorNames
	inc a
	cp NUM_GRANDMASTERCUP_COMPETITORS
	jr nz, .loop_init_names

	ld hl, wGrandMasterCupBracketWinnerSides
	ld c, NUM_GRANDMASTERCUP_BRACKET_MATCHES
	xor a
.loop_init_results
	ld [hli], a
	dec c
	jr nz, .loop_init_results

	xor a
	ld [wGrandMasterCupBracketWinnerSideBitfield], a
	pop hl
	pop af
	ret

PrintGrandMasterCupCompetitorNames:
	push af
	push bc
	push de
	push hl
	lb de, 1, 2
	lb bc, 6, 15
	farcall FillBoxInBGMapWithZero
	lb de, 1, 2
	ld hl, wGrandMasterCupCompetitorNames
	xor a
.loop_print
	push hl
	push af
	ld a, [hli]
	ld h, [hl]
	ld l, a
	pop af
	call PrintTextNoDelay_InitVRAM0
	pop hl
	inc hl
	inc hl
	inc e
	inc e
	inc a
	cp NUM_GRANDMASTERCUP_COMPETITORS
	jr nz, .loop_print
	pop hl
	pop de
	pop bc
	pop af
	ret

; a = bracket match winner side GRANDMASTERCUP_BRACKET_*_WON)
; c = bracket match index (GRANDMASTERCUP_BRACKET_*)
; update wGrandMasterCupBracketWinnerSides and wGrandMasterCupBracketWinnerSideBitfield
UpdateGrandMasterCupBracketResults:
	push af
	push bc
	push hl
	ld b, $00
	ld hl, wGrandMasterCupBracketWinnerSides
	add hl, bc
	ld [hl], a

	dec a
	and GRANDMASTERCUP_BRACKET_RIGHT_WON_F
	inc c
.loop_shift
	sla a
	dec c
	jr nz, .loop_shift
	ld b, a
	srl b
	ld a, [wGrandMasterCupBracketWinnerSideBitfield]
	or b
	ld [wGrandMasterCupBracketWinnerSideBitfield], a
	pop hl
	pop bc
	pop af
	ret

DrawGrandMasterCupBracketAdvancementLines:
	push af
	push bc
	push de
	push hl
	ld hl, wGrandMasterCupBracketWinnerSides
	ld bc, GRANDMASTERCUP_BRACKET_ROUND1_MATCH1
.loop_matches
	ld a, [hli]
	and a
	jr z, .next_match
	push af
	push bc
	push de
	push hl
	call .GetTileset
	call .Draw
	pop hl
	pop de
	pop bc
	pop af
.next_match
	inc c
	ld a, c
	cp NUM_GRANDMASTERCUP_BRACKET_MATCHES
	jr nz, .loop_matches
	pop hl
	pop de
	pop bc
	pop af
	ret

; .tileset_table[c][a-1]
.GetTileset:
	ld hl, .tileset_table
	sla c
	sla c
	add hl, bc
	dec a
	ld c, a
	sla c
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ret

.Draw:
	ld a, [hl]
	cp $ff
	ret z
	ld b, [hl]
	inc hl
	ld c, [hl]
	inc hl
	ld a, [hl]
	add $80
	ld d, a
	inc hl
	ld e, [hl]
	inc hl
	call Func_383b
	jr .Draw
	ret

.tileset_table
	dw .round1_match1_left_won, .round1_match1_right_won ; GRANDMASTERCUP_BRACKET_ROUND1_MATCH1
	dw .round1_match2_left_won, .round1_match2_right_won ; GRANDMASTERCUP_BRACKET_ROUND1_MATCH2
	dw .round1_match3_left_won, .round1_match3_right_won ; GRANDMASTERCUP_BRACKET_ROUND1_MATCH3
	dw .round1_match4_left_won, .round1_match4_right_won ; GRANDMASTERCUP_BRACKET_ROUND1_MATCH4
	dw .round2_match1_left_won, .round2_match1_right_won ; GRANDMASTERCUP_BRACKET_ROUND2_MATCH1
	dw .round2_match2_left_won, .round2_match2_right_won ; GRANDMASTERCUP_BRACKET_ROUND2_MATCH2
	dw .final_left_won,         .final_right_won         ; GRANDMASTERCUP_BRACKET_FINAL

; tables
; x, y, (VRAM0 tile index - $80), VRAM1 tile attributes

.round1_match1_left_won
	db 7, 2, $11, $0a
	db 8, 2, $12, $0a
	db 8, 3, $13, $0a
	db $ff

.round1_match1_right_won
	db 7, 4, $11, $0a
	db 8, 4, $14, $0a
	db 8, 3, $17, $0a
	db $ff

.round1_match2_left_won
	db 7, 6, $11, $0a
	db 8, 6, $12, $0a
	db 8, 7, $13, $0a
	db $ff

.round1_match2_right_won
	db 7, 8, $11, $0a
	db 8, 8, $14, $0a
	db 8, 7, $17, $0a
	db $ff

.round1_match3_left_won
	db 7, 10, $11, $0a
	db 8, 10, $12, $0a
	db 8, 11, $13, $0a
	db $ff

.round1_match3_right_won
	db 7, 12, $11, $0a
	db 8, 12, $14, $0a
	db 8, 11, $17, $0a
	db $ff

.round1_match4_left_won
	db 7, 14, $11, $0a
	db 8, 14, $12, $0a
	db 8, 15, $13, $0a
	db $ff

.round1_match4_right_won
	db 7, 16, $11, $0a
	db 8, 16, $14, $0a
	db 8, 15, $17, $0a
	db $ff

.round2_match1_left_won
	db 9, 3, $12, $0a
	db 9, 4, $15, $0a
	db 9, 5, $13, $0a
	db $ff

.round2_match1_right_won
	db 9, 7, $14, $0a
	db 9, 6, $15, $0a
	db 9, 5, $17, $0a
	db $ff

.round2_match2_left_won
	db 9, 11, $12, $0a
	db 9, 12, $15, $0a
	db 9, 13, $13, $0a
	db $ff

.round2_match2_right_won
	db 9, 15, $14, $0a
	db 9, 14, $15, $0a
	db 9, 13, $17, $0a
	db $ff

.final_left_won
	db 10, 5, $12, $0a
	db 10, 6, $15, $0a
	db 10, 7, $15, $0a
	db 10, 8, $15, $0a
	db 10, 9, $13, $0a
	db 11, 9, $16, $0a
	db $ff

.final_right_won
	db 10, 13, $14, $0a
	db 10, 12, $15, $0a
	db 10, 11, $15, $0a
	db 10, 10, $15, $0a
	db 10,  9, $17, $0a
	db 11,  9, $16, $0a
	db $ff

PrintGrandMasterCupBracketChampion:
	push af
	push bc
	push de
	push hl
	ldtx hl, GrandMasterCupBracketChampionshipText
	ld a, [wGrandMasterCupBracketWinnerSides + GRANDMASTERCUP_BRACKET_FINAL]
	and a
	jr z, .print
; final played
	call .GetBracketChampionCompetitorIndex
	push af
	farcall GetGrandMasterCupBracketChampionID
	ld [wGrandMasterCupBracketChampion], a
	call .DrawSprite
	ld hl, SpinGrandMasterCupBracketChampionSprite
	call Func_3f6b
	pop af
	add a
	ld c, a
	ld b, $00
	ld hl, wGrandMasterCupCompetitorNames
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
.print
	lb de, 13, 9
	lb bc, 6, 1
	farcall FillBoxInBGMapWithZero
	call PrintTextNoDelay_InitVRAM0
	pop hl
	pop de
	pop bc
	pop af
	ret

.GetBracketChampionCompetitorIndex:
	push bc
	push de
	push hl
	ld hl, .advancement_lines
	ld d, 0
.loop_check_champion
	ld a, [wGrandMasterCupBracketWinnerSideBitfield]
	ld b, [hl]
	inc hl
	and b
	ld c, [hl]
	inc hl
	inc d
	cp c
	jr nz, .loop_check_champion
	dec d
	ld a, d
	and NUM_GRANDMASTERCUP_COMPETITORS - 1
	pop hl
	pop de
	pop bc
	ret

; matches (bitmask) and results
.advancement_lines:
	db \
		1 << GRANDMASTERCUP_BRACKET_ROUND1_MATCH1 | \
		1 << GRANDMASTERCUP_BRACKET_ROUND2_MATCH1 | \
		1 << GRANDMASTERCUP_BRACKET_FINAL, \
		GRANDMASTERCUP_BRACKET_LEFT_WON_F << GRANDMASTERCUP_BRACKET_ROUND1_MATCH1 | \
		GRANDMASTERCUP_BRACKET_LEFT_WON_F << GRANDMASTERCUP_BRACKET_ROUND2_MATCH1 | \
		GRANDMASTERCUP_BRACKET_LEFT_WON_F << GRANDMASTERCUP_BRACKET_FINAL
	db \
		1 << GRANDMASTERCUP_BRACKET_ROUND1_MATCH1 | \
		1 << GRANDMASTERCUP_BRACKET_ROUND2_MATCH1 | \
		1 << GRANDMASTERCUP_BRACKET_FINAL, \
		GRANDMASTERCUP_BRACKET_RIGHT_WON_F << GRANDMASTERCUP_BRACKET_ROUND1_MATCH1 | \
		GRANDMASTERCUP_BRACKET_LEFT_WON_F  << GRANDMASTERCUP_BRACKET_ROUND2_MATCH1 | \
		GRANDMASTERCUP_BRACKET_LEFT_WON_F  << GRANDMASTERCUP_BRACKET_FINAL
	db \
		1 << GRANDMASTERCUP_BRACKET_ROUND1_MATCH2 | \
		1 << GRANDMASTERCUP_BRACKET_ROUND2_MATCH1 | \
		1 << GRANDMASTERCUP_BRACKET_FINAL, \
		GRANDMASTERCUP_BRACKET_LEFT_WON_F  << GRANDMASTERCUP_BRACKET_ROUND1_MATCH2 | \
		GRANDMASTERCUP_BRACKET_RIGHT_WON_F << GRANDMASTERCUP_BRACKET_ROUND2_MATCH1 | \
		GRANDMASTERCUP_BRACKET_LEFT_WON_F  << GRANDMASTERCUP_BRACKET_FINAL
	db \
		1 << GRANDMASTERCUP_BRACKET_ROUND1_MATCH2 | \
		1 << GRANDMASTERCUP_BRACKET_ROUND2_MATCH1 | \
		1 << GRANDMASTERCUP_BRACKET_FINAL, \
		GRANDMASTERCUP_BRACKET_RIGHT_WON_F << GRANDMASTERCUP_BRACKET_ROUND1_MATCH2 | \
		GRANDMASTERCUP_BRACKET_RIGHT_WON_F << GRANDMASTERCUP_BRACKET_ROUND2_MATCH1 | \
		GRANDMASTERCUP_BRACKET_LEFT_WON_F  << GRANDMASTERCUP_BRACKET_FINAL
	db \
		1 << GRANDMASTERCUP_BRACKET_ROUND1_MATCH3 | \
		1 << GRANDMASTERCUP_BRACKET_ROUND2_MATCH2 | \
		1 << GRANDMASTERCUP_BRACKET_FINAL, \
		GRANDMASTERCUP_BRACKET_LEFT_WON_F  << GRANDMASTERCUP_BRACKET_ROUND1_MATCH3 | \
		GRANDMASTERCUP_BRACKET_LEFT_WON_F  << GRANDMASTERCUP_BRACKET_ROUND2_MATCH2 | \
		GRANDMASTERCUP_BRACKET_RIGHT_WON_F << GRANDMASTERCUP_BRACKET_FINAL
	db \
		1 << GRANDMASTERCUP_BRACKET_ROUND1_MATCH3 | \
		1 << GRANDMASTERCUP_BRACKET_ROUND2_MATCH2 | \
		1 << GRANDMASTERCUP_BRACKET_FINAL, \
		GRANDMASTERCUP_BRACKET_RIGHT_WON_F << GRANDMASTERCUP_BRACKET_ROUND1_MATCH3 | \
		GRANDMASTERCUP_BRACKET_LEFT_WON_F  << GRANDMASTERCUP_BRACKET_ROUND2_MATCH2 | \
		GRANDMASTERCUP_BRACKET_RIGHT_WON_F << GRANDMASTERCUP_BRACKET_FINAL
	db \
		1 << GRANDMASTERCUP_BRACKET_ROUND1_MATCH4 | \
		1 << GRANDMASTERCUP_BRACKET_ROUND2_MATCH2 | \
		1 << GRANDMASTERCUP_BRACKET_FINAL, \
		GRANDMASTERCUP_BRACKET_LEFT_WON_F  << GRANDMASTERCUP_BRACKET_ROUND1_MATCH4 | \
		GRANDMASTERCUP_BRACKET_RIGHT_WON_F << GRANDMASTERCUP_BRACKET_ROUND2_MATCH2 | \
		GRANDMASTERCUP_BRACKET_RIGHT_WON_F << GRANDMASTERCUP_BRACKET_FINAL
	db \
		1 << GRANDMASTERCUP_BRACKET_ROUND1_MATCH4 | \
		1 << GRANDMASTERCUP_BRACKET_ROUND2_MATCH2 | \
		1 << GRANDMASTERCUP_BRACKET_FINAL, \
		GRANDMASTERCUP_BRACKET_RIGHT_WON_F << GRANDMASTERCUP_BRACKET_ROUND1_MATCH4 | \
		GRANDMASTERCUP_BRACKET_RIGHT_WON_F << GRANDMASTERCUP_BRACKET_ROUND2_MATCH2 | \
		GRANDMASTERCUP_BRACKET_RIGHT_WON_F << GRANDMASTERCUP_BRACKET_FINAL

.DrawSprite:
	push af
	push bc
	push de
	push hl
	ld a, [wGrandMasterCupBracketChampion]
	ld b, SOUTH
	ld d, 112
	ld e, 48
	farcall LoadOWObject
	farcall ResetOWObjectSpriteAnimating
	ld b, $01 ; SPRITEANIMSTRUCT_FRAME_INDEX
	farcall _SetOWObjectFrameIndex
	xor a
	ld [wGrandMasterCupBracketChampionSpriteAnimTick], a
	ld a, $02
	ld [wGrandMasterCupBracketChampionSpriteAnimIndex], a
	pop hl
	pop de
	pop bc
	pop af
	ret

_SpinGrandMasterCupBracketChampionSprite::
	ld a, [wGrandMasterCupBracketChampionSpriteAnimTick]
	inc a
	and $07
	ld [wGrandMasterCupBracketChampionSpriteAnimTick], a
	and a
	ret nz

	ld a, [wGrandMasterCupBracketChampionSpriteAnimIndex]
	inc a
	and $1f
	ld [wGrandMasterCupBracketChampionSpriteAnimIndex], a
	ld c, a
	ld b, $00
	ld hl, .direction
	add hl, bc
	ld a, [hl]
	ld b, a
	ld a, [wGrandMasterCupBracketChampion]
	farcall _SetOWObjectDirection
	ld a, b
	and $01
	xor $01
	ld b, a
	ld a, [wGrandMasterCupBracketChampion]
	farcall _SetOWObjectFrameIndex
	ret

.direction:
	db SOUTH, SOUTH, SOUTH, SOUTH
REPT 4
	db SOUTH, WEST, NORTH, EAST
ENDR
REPT 3
	db SOUTH, SOUTH, SOUTH, SOUTH
ENDR

MinicomMailboxScreen:
	farcall Func_1022a
	call MinicomMailbox
	farcall Func_10252
	ret

MinicomMailbox:
	push af
	push bc
	push de
	push hl
	call MinicomMailboxNewMailScreen
	call MinicomMailboxMainScreen
	pop hl
	pop de
	pop bc
	pop af
	ret

InitializeMailboxWRAM:
	push af
	push bc
	push de
	push hl
	xor a
	ld [wNumMailInQueue], a
	ld [wMailCount], a
	ld [wMailboxPage], a
	ld [wSelectedMailCursorPosition], a
	ld [wMailOptionSelected], a
	ld [wTempNumMailInQueue], a
	ld [wNewMail], a
	ld [wBlackBoxCardReceived], a
	ld [wBlackBoxCardReceived + 1], a
	ld [wBillsPCCardReceived], a
	ld [wBillsPCCardReceived + 1], a
	xor a
	ld hl, wMailQueue
	ld bc, MAIL_QUEUE_BUFFER_SIZE
	call WriteBCBytesToHL
	xor a
	ld hl, wMailList
	ld bc, MAIL_BUFFER_SIZE
	call WriteBCBytesToHL
	pop hl
	pop de
	pop bc
	pop af
	ret

; the screen after selecting the mailbox which has a large picture of a literal mailbox on it
MinicomMailboxNewMailScreen:
	call DisableLCD
	farcall ClearSpriteAnimsAndSetInitialGraphicsConfiguration
	call CalculateMailboxStatus
	call Func_1ed2d
	call FlushAllPalettes
	call EnableLCD
	ld a, [wNewMail]
	and a
	jr z, .asm_1ed04
	push af
	ld a, SFX_NEW_MAIL
	call CallPlaySFX
	pop af
.asm_1ed04
	call Func_1ed57
	call DisableLCD
	xor a
	ld [wNewMail], a
	ld [wMailboxPage], a
	ld [wSelectedMailCursorPosition], a
	ld [wTempNumMailInQueue], a
	ret

CalculateMailboxStatus:
	ld b, $00
	ld a, [wTempNumMailInQueue]
	and a
	jr nz, .asm_1ed28
	inc b
	ld a, [wNewMail]
	and a
	jr nz, .asm_1ed28
	inc b
.asm_1ed28
	ld a, b
	ld [wMailboxStatus], a
	ret

Func_1ed2d:
	lb de, 0, 0
	lb bc, 20, 4
	call DrawRegularTextBoxVRAM0
	ldtx hl, MailboxTitleText
	lb de, 6, 2
	call InitTextPrinting_ProcessTextFromIDVRAM0
	lb de, 0, 12
	lb bc, 20, 6
	call DrawRegularTextBoxVRAM0
	call Func_1ed5e
	call LoadMailboxScene
	ret

LoadMailboxScene:
	lb bc, 5, 5
	ld a, [hli]
	call LoadScene
	ret

; hl - text
Func_1ed57:
	ld a, [hli]
	ld h, [hl]
	ld l, a
	farcall PrintScrollableText_NoTextBoxLabelVRAM0
;	fallthrough

Func_1ed5e:
	ld a, [wMailboxStatus]
	add a
	ld c, a
	ld b, $00
	ld hl, .MailboxScenes
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ret

.MailboxScenes:
	dw .SceneFull
	dw .SceneGotMail
	dw .SceneNoNewMail
.SceneFull
	db SCENE_FULL_MAILBOX
	tx MailboxFullWarningText
.SceneGotMail
	db SCENE_GOT_MAIL
	tx MailboxNewMailText
.SceneNoNewMail
	db SCENE_MAILBOX
	tx MailboxNoNewMailText
; 0x1ed7c

SECTION "Bank 7@6da5", ROMX[$6da5], BANK[$7]

MinicomMailboxMainScreen:
	call DisableLCD
	farcall ClearSpriteAnimsAndSetInitialGraphicsConfiguration
	lb de, $40, $ff
	call SetupText
	call MinicomMailboxMainScreen_DrawTextBoxes
	call FlushAllPalettes
	call EnableLCD
.loop
	call MailboxMainScreen
	call Func_1eef8
	jr c, .done
	call MailboxSelectedMail_LoadMenuBoxParams
	call MailboxSelectedMail_HandleMenuBox
	jr c, .loop
	call MailboxSelectedMail_CallMappedFunction
	jr .loop
.done
	ret

MinicomMailboxMainScreen_DrawTextBoxes:
	lb de, 0, 4
	lb bc, 20, 14
	call DrawRegularTextBoxVRAM0
	lb de, 0, 0
	lb bc, 20, 5
	call DrawRegularTextBoxVRAM0
	ret

MailboxMainScreen:
	push af
	push bc
	push de
	push hl
	lb de, 1, 5
	ld b, BANK(MailboxMainScreenMenuBoxParams)
	ld hl, MailboxMainScreenMenuBoxParams
	call LoadMenuBoxParams
	ld a, [wSelectedMailCursorPosition]
	call DrawMenuBox
	lb de, 0, 0
	lb bc, 20, 5
	call DrawRegularTextBoxVRAM0
	ldtx hl, MailboxChooseMailText
	ld a, [wMailCount]
	and a
	jr nz, .asm_1ee0e
	ldtx hl, MailboxEmptyText
.asm_1ee0e
	lb de, 1, 2
	call InitTextPrinting_ProcessTextFromIDVRAM0
	ldtx hl, MailboxTitleText
	lb de, 1, 0
	call Func_2c4b
	ld a, [wMailboxPage]
	add a
	add a
	ld c, a
	ld b, $00
	ld hl, wMailList
	add hl, bc
	lb de, 2, 6
	ld c, MAIL_MAX_ON_SCREEN
.print_mail_loop
	ld a, [hli]
	and a
	jr z, .count_mail_items_on_screen
	call PrintMailSenderAndSubjectToScreen
	dec c
	jr nz, .print_mail_loop
.count_mail_items_on_screen
	ld a, MAIL_MAX_ON_SCREEN
	sub c
	and a
	jr nz, .done
	inc a
.done
	call SetMenuBoxNumItems
	call Func_1ee97
	pop hl
	pop de
	pop bc
	pop af
	ret

; a - mail ID to print
; de - coordinates passed to InitTextPrinting_ProcessTextFromIDVRAM0
PrintMailSenderAndSubjectToScreen:
	push bc
	push hl
	ldtx hl, MailboxSenderText
	call InitTextPrinting_ProcessTextFromIDVRAM0
	inc e
	ldtx hl, MailboxSubjectText
	call InitTextPrinting_ProcessTextFromIDVRAM0
	and a
	jr z, .asm_1ee68
	bit B_MAIL_READ, a
	jr nz, .asm_1ee68
	dec d
	ldtx hl, MailboxUnreadSymbolText
	call InitTextPrinting_ProcessTextFromIDVRAM0
	inc d
.asm_1ee68
	ld hl, Mail
	and ~(1 << B_MAIL_READ)
	ld c, a
	ld b, $00
	sla c
	rl b
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, d
	add $05
	ld d, a
	dec e

	push hl
	ld a, [hli]
	ld h, [hl]
	ld l, a
	; sender
	call InitTextPrinting_ProcessTextFromIDVRAM0

	pop hl
	inc hl
	inc hl
	inc e
	ld a, [hli]
	ld h, [hl]
	ld l, a
	; subject
	call InitTextPrinting_ProcessTextFromIDVRAM0
	inc e
	inc e
	ld a, d
	sub $05
	ld d, a
	pop hl
	pop bc
	ret

Func_1ee97:
	lb bc, 1, 17
	ld d, $1d
	ld e, $01
	call Func_383b
	ld a, [wMailboxPage]
	cp $01
	jr nz, .asm_1eebd
	lb bc, 1, 4
	ld d, $2f
	ld e, $41
	call Func_383b
	lb bc, 1, 17
	ld d, $1d
	ld e, $01
	call Func_383b
	ret
.asm_1eebd
	ld a, [wMailCount]
	cp $05
	ret c
	lb bc, 1, 17
	ld d, $2f
	ld e, $01
	call Func_383b
	lb bc, 1, 4
	ld d, $1d
	ld e, $01
	call Func_383b
	ret

; a menu box with blank text items that line up with mail items on screen
MailboxMainScreenMenuBoxParams:
	menubox_params FALSE, 18, 12, \
		SYM_CURSOR_R, SYM_SPACE, SYM_CURSOR_R, SYM_CURSOR_R, \
		PAD_A, PAD_B, FALSE, 1, UpdateMailboxPage, NULL
	textitem 1,  1, SingleSpaceText
	textitem 1,  4, SingleSpaceText
	textitem 1,  7, SingleSpaceText
	textitem 1, 10, SingleSpaceText
	textitems_end

Func_1eef8:
	ld a, [wSelectedMailCursorPosition]
	call HandleMenuBox
	ld [wSelectedMailCursorPosition], a
	jr c, .asm_1ef22
	call GetSelectedMailPosition
	ld c, a
	ld b, $00
	ld hl, wMailList
	add hl, bc
	ld a, [hl]
	and a
	jr nz, .asm_1ef1a
	push af
	ld a, SFX_DENIED
	call CallPlaySFX
	pop af
	jr Func_1eef8
.asm_1ef1a
	push af
	ld a, SFX_CONFIRM
	call CallPlaySFX
	pop af
	ret
.asm_1ef22
	push af
	ld a, SFX_CANCEL
	call CallPlaySFX
	pop af
	ret

_UpdateMailboxPage::
	push af
	push bc
	push de
	push hl
	call GetMenuBoxFocusedItem
	and $03 ; bottom-most mail item on the screen
	cp 3
	call z, ScrollMailboxPageOnPadDown
	call GetMenuBoxFocusedItem
	and $03
	and a ; top mail item on the screen
	call z, ScrollMailboxPageOnPadUp
	pop hl
	pop de
	pop bc
	pop af
	ret

ScrollMailboxPageOnPadDown:
	ldh a, [hDPadHeld]
	and PAD_DOWN
	ret z

	ld a, [wMailboxPage]
	cp 1
	ret z

	ld a, [wMailCount]
	cp 5
	ret c

	push af
	ld a, SFX_CURSOR
	call CallPlaySFX
	pop af
	ld a, [wMailboxPage]
	inc a
	ld [wMailboxPage], a
	xor a
	ld [wSelectedMailCursorPosition], a
	call MailboxMainScreen
	call SetMenuBoxFocusedItem
	call SetwDA37
	ret

ScrollMailboxPageOnPadUp:
	ldh a, [hDPadHeld]
	and PAD_UP
	ret z

	ld a, [wMailboxPage]
	and a
	ret z

	push af
	ld a, SFX_CURSOR
	call CallPlaySFX
	pop af
	ld a, [wMailboxPage]
	dec a
	ld [wMailboxPage], a
	ld a, 3
	ld [wSelectedMailCursorPosition], a
	call MailboxMainScreen
	call SetMenuBoxFocusedItem
	call SetwDA37
	ret
; 0x1ef9a

SECTION "Bank 7@6fa4", ROMX[$6fa4], BANK[$7]

MailboxSelectedMail_LoadMenuBoxParams:
	lb de, 0, 0
	ld b, BANK(.menu_box_params)
	ld hl, .menu_box_params
	call LoadMenuBoxParams
	xor a
	call DrawMenuBox
	ldtx hl, MailboxActionPromptText
	lb de, 1, 1
	call InitTextPrinting_ProcessTextFromIDVRAM0
	ret

.menu_box_params
	menubox_params TRUE, 20, 5, \
		SYM_CURSOR_R, SYM_SPACE, SYM_CURSOR_R, SYM_CURSOR_R, \
		PAD_A, PAD_B, TRUE, 0, NULL, NULL
	textitem  2, 3, MailboxActionReadText
	textitem  9, 3, MailboxActionDeleteText
	textitem 16, 3, GiftCenterQuitText
	textitems_end

MailboxSelectedMail_HandleMenuBox:
	xor a
	call HandleMenuBox
	ld [wMailOptionSelected], a
	ret

MailboxSelectedMail_CallMappedFunction:
	ld a, [wMailOptionSelected]
	ld hl, .function_map
	call CallMappedFunction
	ret

.function_map:
	key_func MAILBOXMENU_READ,   ReadMail
	key_func MAILBOXMENU_DELETE, DeleteMail
	db $ff

ReadMail:
	call DrawReadMailScreenHeader
	call _ReadMail
	ret

; draws the box at the top that says the sender and subject
; does not actually fill in the sender and subject names though
DrawReadMailScreenHeader:
	lb de, $40, $7f
	call SetupText
	lb de, 0, 0
	lb bc, 20, 5
	call DrawRegularTextBoxVRAM0
	ldtx hl, MailboxTitleText
	lb de, 1, 0
	call Func_2c4b
	ld hl, .text_items
	call PlaceTextItemsVRAM0
	ret

.text_items:
	textitem 1, 2, MailboxSenderText
	textitem 1, 3, MailboxSubjectText
	textitems_end

_ReadMail:
	lb bc, 1, 17
	ld d, $1d
	ld e, $01
	call Func_383b
	call GetSelectedMailPosition
	ld c, a
	ld b, $00
	ld hl, wMailList
	add hl, bc
	ld a, [hl]
	ld [wMailId], a
	set B_MAIL_READ, a ; mark mail as read
	ld [hl], a
	add a
	ld c, a
	ld b, $00
	ld hl, Mail
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, [hli]
	ld [wMailSenderText], a
	ld a, [hli]
	ld [wMailSenderText + 1], a
	call PrintMailSender
	ld a, [hli]
	ld [wMailSubjectText], a
	ld a, [hli]
	ld [wMailSubjectText + 1], a
	call PrintMailSubject
.read_mail_loop
	; mail is terminated with MAIL_TERMINATOR ($ffff)
	ld a, [hl]
	cp $ff
	jr nz, .print_body
	inc hl
	ld a, [hld]
	cp $ff
	jr z, .done
.print_body
	call PrintMailBodyPage
	jr z, .asm_1f074
	push hl
	call WaitForWideTextBoxInput
	pop hl
.asm_1f074
	call GiveCardsAttachedToMailPage
	jr .read_mail_loop
.done
	ret

PrintMailSender:
	push hl
	ld a, [wMailSenderText]
	ld l, a
	ld a, [wMailSenderText + 1]
	ld h, a
	lb de, 6, 2
	call InitTextPrinting_ProcessTextFromIDVRAM0
	pop hl
	ret

PrintMailSubject:
	push hl
	ld a, [wMailSubjectText]
	ld l, a
	ld a, [wMailSubjectText + 1]
	ld h, a
	lb de, 6, 3
	call InitTextPrinting_ProcessTextFromIDVRAM0
	pop hl
	ret

ClearMailBodyPage:
	lb de, 1, 5
	lb bc, 18, 12
	farcall FillBoxInBGMapWithZero
	ret

; hl - mail body text
; fills the lower portion of the ReadMail screen with the mail body text at hl
; and then increments hl by 2 (advancing it to the next body page's text).
; prints nothing if value at hl is $0000
; return
;	- hl: input incremented by 2
PrintMailBodyPage:
	push hl
	lb de, $80, $ff
	call SetupText
	pop hl
	push hl
	ld a, [hli]
	ld h, [hl]
	ld l, a
	or h
	jr z, .skip
	call ClearMailBodyPage
	lb de, 1, 6
	call PrintTextNoDelay_InitVRAM0
.skip
	pop hl
	inc hl
	inc hl
	ret

; give the card(s) attached to the current page of mail, if present
GiveCardsAttachedToMailPage:
	push hl
	ld a, [wMailId]
	bit B_MAIL_READ, a
	; don't give out a card again if this mail has already been read
	jr nz, .done

	ld a, [hli]
	ld b, [hl]
	ld c, a
	or b
	jr z, .done
	bit B_MAIL_BOOSTER_PACK, b
	jr nz, .give_booster
	bit B_MAIL_GENERIC_CARD, b
	jr nz, .give_generic_card
	bit B_MAIL_BLACK_BOX, b
	jr nz, .give_blackbox_cards
	bit B_MAIL_BILLS_PC, b
	jr nz, .give_billspc_card

.done
	pop hl
	inc hl
	inc hl
	ret

; gives the booster pack specified in the first byte of the command
.give_booster
	call StartFadeToWhite
	call WaitPalFading_Bank07
	ld a, c
	ld b, $00
	call GiveBoosterPacks
	call .redraw_mail_screen
	jr .done

; gives a card specified in the first byte of the command.
; this would effectively be a "hard-coded" card delivered with the mail.
; appears to be unused in the real game mail data
.give_generic_card
	ld a, b
	and %00111111
	ld d, a
	ld e, c
	call .give_card
	call .redraw_mail_screen
	jr .done

; gives the cards attached to black box mail, found at [wBlackBoxCardReceived]
; clears out the cards by setting to $0000 as it gives them
.give_blackbox_cards
	push hl
	ld hl, wBlackBoxCardReceived
.blackbox_card_loop
	xor a
	ld e, [hl]
	ld [hli], a
	ld d, [hl]
	ld [hli], a
	ld a, d
	or e
	jr z, .loop_done
	call .give_card
	jr .blackbox_card_loop
.loop_done
	pop hl
	call .redraw_mail_screen
	jr .done

; gives the cards attached to bill's PC mail, found at [wBillsPCCardReceived]
.give_billspc_card
	push hl
	ld hl, wBillsPCCardReceived
	xor a
	ld e, [hl]
	ld [hli], a
	ld d, [hl]
	ld [hli], a
	call .give_card
	pop hl
	call .redraw_mail_screen
	jr .done

.give_card
	call StartFadeToWhite
	call WaitPalFading_Bank07
	push hl
	farcall GetReceivedCardText
	call AddCardToCollection
	call Func_1d53a
	pop hl
	ret

.redraw_mail_screen
	inc hl
	ld a, [hli]
	ld b, a
	ld a, [hl]
	or b
	jr z, .done
	farcall ClearSpriteAnimsAndSetInitialGraphicsConfiguration
	call DisableLCD
	call MinicomMailboxMainScreen_DrawTextBoxes
	call DrawReadMailScreenHeader
	call PrintMailSender
	call PrintMailSubject
	call FlushAllPalettes
	call EnableLCD
	ret

DeleteMail:
	push af
	push bc
	push de
	push hl
	call GetSelectedMailPosition
	ld c, a
	ld b, $00
	ld hl, wMailList
	add hl, bc
	ld a, [hl]
	ld [wMailId], a
	call MailboxYesNoPrompt_DeleteConfirm
	jr c, .asm_1f1ad
	dec a
	jr z, .asm_1f1ad
	bit 7, [hl]
	jr nz, .asm_1f187
	call MailboxYesNoPrompt_DeleteUnreadConfirm
	jr c, .asm_1f1ad
	dec a
	jr z, .asm_1f1ad
.asm_1f187
	xor a
	ld [hl], a
	ld d, h
	ld e, l
	inc hl
	ld a, $08
	sub c
	and a
	jr z, .asm_1f19d
	ld c, a
.asm_1f193
	push af
	ld a, [hli]
	ld [de], a
	inc de
	pop af
	dec a
	jr nz, .asm_1f193
	xor a
	ld [hl], a
.asm_1f19d
	ld a, [wMailCount]
	dec a
	ld [wMailCount], a
	call DeleteGameCenterMailedCard
	call DrawMailDeletedTextBox
	call Func_1f210
.asm_1f1ad
	pop hl
	pop de
	pop bc
	pop af
	ret

DrawMailDeletedTextBox:
	lb de, 0, 0
	lb bc, 20, 5
	call DrawRegularTextBoxVRAM0
	ldtx hl, MailboxDeletedText
	lb de, 1, 2
	call InitTextPrinting_ProcessTextFromIDVRAM0
	ld a, 60
	call DoAFrames_WithPreCheck
	ret

MailboxYesNoPrompt_DeleteConfirm:
	push hl
	ldtx hl, MailboxActionDeleteConfirmText
	call MailboxYesNoPrompt
	pop hl
	ret

MailboxYesNoPrompt_DeleteUnreadConfirm:
	push hl
	ldtx hl, MailboxActionDeleteUnreadConfirmText
	call MailboxYesNoPrompt
	pop hl
	ret

; hl - text
MailboxYesNoPrompt:
	push hl
	ld b, BANK(.menu_box_params)
	ld hl, .menu_box_params
	lb de, 0, 0
	call LoadMenuBoxParams
	pop hl
	ld a, 1
	call DrawMenuBox
	lb de, 1, 1
	call InitTextPrinting_ProcessTextFromIDVRAM0
	call HandleMenuBox
	ret

.menu_box_params
	menubox_params TRUE, 20, 5, \
		SYM_CURSOR_R, SYM_SPACE, SYM_CURSOR_R, SYM_CURSOR_R, \
		PAD_A, PAD_B, TRUE, 0, NULL, NULL
	textitem  7, 3, PlayerDiaryPromptYesText
	textitem 11, 3, PlayerDiaryPromptNoText
	textitems_end

Func_1f210:
	ld a, [wSelectedMailCursorPosition]
	and a
	jr nz, .asm_1f225
	ld a, [wMailboxPage]
	and a
	ret z
	xor a
	ld [wMailboxPage], a
	ld a, $03
	ld [wSelectedMailCursorPosition], a
	ret
.asm_1f225
	ld a, [wMailCount]
	ld c, a
	call GetSelectedMailPosition
	cp c
	ret c
	ld a, [wSelectedMailCursorPosition]
	dec a
	ld [wSelectedMailCursorPosition], a
	ret

; if the current mail being read/acted on is from the game center,
; delete the card that is waiting to be collected.
DeleteGameCenterMailedCard:
	ld a, [wMailId]
	cp $01 ; black box mail id
	jr nz, .asm_1f244
	ld de, $0
	call SetBlackBoxCard
	ret
.asm_1f244
	cp $02 ; bill's PC mail id
	ret nz
	ld de, $0
	call SetBillsPCCard
	ret

; input: a - new mail to add to queue
; set carry and quit if mail queue is full, i.e. [wNumMailInQueue] = MAIL_QUEUE_BUFFER_SIZE - 1
; else:
; - if bit 7 (B_MAIL_PRIORITY_DELIVERY) of a is 0, add to the END of the mail queue
; - if bit 7 (B_MAIL_PRIORITY_DELIVERY) of a is 1,
;     add to the FRONT of the mail queue and shift the rest
;	  this new mail will be inserted BETWEEN any current priority mail in the queue, and the non-priority
; finally, increment [wNumMailInQueue] by 1
AddMailToQueue:
	push bc
	push de
	push hl
	ld e, a
	ld a, [wNumMailInQueue]
	cp MAIL_QUEUE_BUFFER_SIZE - 1
	jr z, .mail_queue_full

	bit B_MAIL_PRIORITY_DELIVERY, e
	call z, .not_priority
	call nz, .has_priority

	ld hl, wNumMailInQueue
	inc [hl]
; clear carry
	scf
	ccf
	jr .done
.mail_queue_full
	scf
; fallthrough
.done
	pop hl
	pop de
	pop bc
	ret

; if not priority mail, add it to the END of the mail queue
.not_priority:
	push af
	ld a, [wNumMailInQueue]
	ld c, a
	ld b, 0
	ld hl, wMailQueue
	add hl, bc
	ld [hl], e
	pop af
	ret

; if mail is high priority, add it to the FRONT of the mail queue
; black box and bill's PC mail, for example, are sent as high priority
.has_priority:
	push af
	ld hl, wMailQueue
	ld c, MAIL_QUEUE_BUFFER_SIZE - 1
	; skip past other high priority mail
.check_byte_loop
	bit B_MAIL_PRIORITY_DELIVERY, [hl]
	jr z, .shift_loop
	inc hl
	dec c
	jr nz, .check_byte_loop
.shift_loop
	ld b, [hl]
	ld [hl], e ; at top of function, e was copied from input a (our new mail)
	ld e, b
	inc hl
	dec c
	jr nz, .shift_loop
	pop af
	ret

DeliverMailFromQueue:
	push af
	push bc
	push de
	push hl
	ld a, [wNumMailInQueue]
	and a
	jr z, .done

	ld a, NEW_MAIL
	ld [wNewMail], a
	ld a, [wMailCount]
	cp MAIL_MAX_NUM
	; if the mailbox already has MAIL_MAX_NUM, can't deliver more mail
	jr z, .done

	ld de, wMailList
	ld hl, wMailQueue
	ld a, [wMailCount]
	ld b, a
	ld a, MAIL_MAX_NUM
	sub b
	ld b, a ; number of mail to insert
	ld c, $00 ; counts how many times we insert mail in the loop

.insert_new_mail_loop
	ld a, [hli]
	and a
	; break the loop if the next mail in the queue is $00, i.e. we have drained the whole queue
	jr z, .done_inserting_mail
	; reset bit 7, because when mail is in the mailbox it means it has been read (B_MAIL_READ)
	res B_MAIL_PRIORITY_DELIVERY, a
	call InsertNewMail
	inc c
	dec b
	jr nz, .insert_new_mail_loop
	; fallthrough if b = 0; i.e. when we have filled up the mailbox again

.done_inserting_mail
	; update the mail counts based on how many we inserted
	ld a, [wMailCount]
	add c
	ld [wMailCount], a
	ld a, [wNumMailInQueue]
	sub c
	ld [wNumMailInQueue], a

	ld hl, wMailQueue
	ld b, $00
	add hl, bc
	ld de, wMailQueue
	ld a, MAIL_QUEUE_BUFFER_SIZE - 1
	sub c
	ld c, a
	ld a, [hli]

.loop2
	ld [de], a
	inc de
	ld b, [hl]
	xor a
	ld [hli], a
	ld a, b
	dec c
	jr nz, .loop2

.done
	ld a, [wNumMailInQueue]
	ld [wTempNumMailInQueue], a
	pop hl
	pop de
	pop bc
	pop af
	ret

; a - new mail to add
; de - wMailList
; Shifts the mail list one byte to the right, and inserts (a) at the front
InsertNewMail:
	push bc
	push de
	push hl
	ld c, MAIL_MAX_NUM
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

GetNewMailFlag:
	ld a, [wNewMail]
	and a
	ret

; de - card offset
SetBlackBoxCard:
	push af
	ld a, e
	ld [wBlackBoxCardReceived], a
	ld a, d
	ld [wBlackBoxCardReceived + 1], a
	pop af
	ret

; de - card offset
SetBillsPCCard:
	push af
	ld a, e
	ld [wBillsPCCardReceived], a
	ld a, d
	ld [wBillsPCCardReceived + 1], a
	pop af
	ret

; set carry if there is a black box card
CheckForBlackBoxCardInMail:
	push bc
	ld a, [wBlackBoxCardReceived]
	ld b, a
	ld a, [wBlackBoxCardReceived + 1]
	or b
	scf
	jr nz, .asm_1f331
	ccf
.asm_1f331
	pop bc
	ret

; set carry if there is a bill's pc card
CheckForBillsPCCardInMail:
	push bc
	ld a, [wBillsPCCardReceived]
	ld b, a
	ld a, [wBillsPCCardReceived + 1]
	or b
	scf
	jr nz, .asm_1f340
	ccf
.asm_1f340
	pop bc
	ret

; return
;	a - position in the mail list of the currently selected mail item
GetSelectedMailPosition:
	push bc
	ld a, [wMailboxPage]
	add a
	add a
	ld b, a
	ld a, [wSelectedMailCursorPosition]
	add b
	pop bc
	ret

INCLUDE "data/mail.asm"

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

; return b = item1, c = item2
SelectGrandMasterCupPrizes:
	farcall Func_102a4
	call _SelectGrandMasterCupPrizes
	farcall Func_102c4
	ret

; return b = item1, c = item2
_SelectGrandMasterCupPrizes:
	push af
	push de
	push hl
	xor a
	ld [wGrandMasterCupPrizeSelectionMenuCursorPosition], a
	call .SelectionMenu
	call .GetSelectedCardItems
	pop hl
	pop de
	pop af
	ret

.SelectionMenu:
	farcall InitOWObjects
	farcall SetInitialGraphicsConfiguration
	farcall Stub_10672
	call .DrawSelectionMenuTitle
	call .DrawSelectionMenu
	call StartFadeFromWhite
	call WaitPalFading_Bank07
	call .HandleSelectionMenu
	call StartFadeToWhite
	call WaitPalFading_Bank07
	ret

.DrawSelectionMenuTitle:
	lb de, 0, 0
	lb bc, 20, 3
	call DrawRegularTextBoxVRAM0
	lb de, 0, 12
	lb bc, 20, 6
	call DrawRegularTextBoxVRAM0
	ldtx hl, GrandMasterCupPrizesTitleText
	lb de, 4, 1
	call InitTextPrinting_ProcessTextFromIDVRAM0
	ret

.DrawSelectionMenu:
	ld b, BANK(.menu_box_params)
	ld hl, .menu_box_params
	lb de, 0, 3
	call LoadMenuBoxParams
	ld a, [wGrandMasterCupPrizeSelectionMenuCursorPosition]
	call DrawMenuBox
	lb de, 4, 4
	ld hl, wGrandMasterCupPrizes
	ld c, NUM_GRANDMASTERCUP_PRIZE_CANDIDATES
.loop_print_card_names
	push hl
	ld a, [hli]
	ld h, [hl]
	ld l, a
	call InitTextPrinting_ProcessTextFromIDVRAM0
	pop hl
	inc hl
	inc hl
	inc hl
	inc hl
	inc e
	inc e
	dec c
	jr nz, .loop_print_card_names
	ret

.menu_box_params:
	menubox_params FALSE, 20, 8, \
		SYM_CURSOR_R, SYM_SPACE, SYM_CURSOR_R, SYM_CURSOR_R, \
		PAD_A | PAD_START, PAD_B, FALSE, 1, NULL, NULL
	textitem 2, 1, SingleSpaceText
	textitem 2, 3, SingleSpaceText
	textitem 2, 5, SingleSpaceText
	textitem 2, 7, SingleSpaceText
	textitems_end

.HandleSelectionMenu:
	call .InitSelection
	xor a
	ld [wNumGrandMasterCupPrizesSelected], a
.loop_dialog_box
	ldtx hl, GrandMasterCupPrizesDialogText
	lb de, 1, 14
	call InitTextPrinting_ProcessTextFromIDVRAM0
.wait_input
	ld a, [wGrandMasterCupPrizeSelectionMenuCursorPosition]
	call HandleMenuBox
	ld [wGrandMasterCupPrizeSelectionMenuCursorPosition], a
	ldh a, [hKeysPressed]
	and PAD_START
	jr z, .no_start_btn
	call .CardPreview
	jr .loop_dialog_box
.no_start_btn
	ldh a, [hKeysPressed]
	and PAD_A
	jr z, .no_a_btn
	ld a, [wGrandMasterCupPrizeSelectionMenuCursorPosition]
	call .SelectCurCardItem
.no_a_btn
	ldh a, [hKeysPressed]
	and PAD_B
	jr z, .no_b_btn
	ld a, [wGrandMasterCupPrizeSelectionMenuCursorPosition]
	call .DeselectCurCardItem
.no_b_btn
	ld a, [wNumGrandMasterCupPrizesSelected]
	cp NUM_GRANDMASTERCUP_PRIZES_TO_RECEIVE
	jr nz, .wait_input

	ldtx hl, GrandMasterCupPrizesConfirmPromptText
	ld a, $01
	farcall DrawWideTextBox_PrintTextWithYesOrNoMenu
	jr c, .HandleSelectionMenu ; loop
	ret

.CardPreview:
	call .OpenCardPage

; back to menu
	call EmptyScreen
	farcall InitOWObjects
	farcall SetInitialGraphicsConfiguration
	farcall Stub_10672
	call .DrawSelectionMenuTitle
	call .DrawSelectionMenu
; restore marks (HP_NOK)
	ld a, [wNumGrandMasterCupPrizesSelected]
	and a
	jr z, .handled_marks_after_preview
	ld a, [wSelectedGrandMasterCupPrizeItems]
	ld d, SYM_HP_NOK
	ld e, $00
	call .UpdateMarkOnCurCardItem
.handled_marks_after_preview
	call EnableLCD
	ret

.InitSelection:
	xor a
.loop_init
	call .DeselectCurCardItem
	inc a
	cp NUM_GRANDMASTERCUP_PRIZE_CANDIDATES
	jr nz, .loop_init
	ret

; a = cursor pos
; marks with HP_NOK
.SelectCurCardItem:
	push af
	ld d, SYM_HP_NOK
	ld e, $00
	call .UpdateMarkOnCurCardItem
	call .SetSelectedCardItems
	call .SetCurCardItemFlagAndUpdateCount
	pop af
	ret

; a = cursor pos
.DeselectCurCardItem:
	push af
	ld d, SYM_SPACE
	ld e, $00
	call .UpdateMarkOnCurCardItem
	call .UnsetCurCardItemFlagAndUpdateCount
	pop af
	ret

; a = cursor pos (y coord = 2a + 4)
; d = VRAM0 tile index (SYM_*)
; e = VRAM1 tile attributes ($00)
.UpdateMarkOnCurCardItem:
	push af
	add a
	add 4
	ld c, a
	ld b, 3 ; x coord
	call Func_383b
	pop af
	ret

; a = cursor pos
.SetCurCardItemFlagAndUpdateCount:
	ld c, a
	ld b, $00
	ld hl, wGrandMasterCupPrizesSelectionState
	add hl, bc
	ld a, [hl]
	and a
	ret nz
	ld a, GRANDMASTERCUP_PRIZE_SELECTED
	ld [hl], a
	ld hl, wNumGrandMasterCupPrizesSelected
	inc [hl]
	ret

.UnsetCurCardItemFlagAndUpdateCount:
	ld c, a
	ld b, $00
	ld hl, wGrandMasterCupPrizesSelectionState
	add hl, bc
	ld a, [hl]
	and a
	ret z
	xor a
	ld [hl], a
	ld hl, wNumGrandMasterCupPrizesSelected
	dec [hl]
	ret

.SetSelectedCardItems:
	ld a, [wNumGrandMasterCupPrizesSelected]
	ld c, a
	ld b, $00
	ld hl, wSelectedGrandMasterCupPrizeItems
	add hl, bc
	ld a, [wGrandMasterCupPrizeSelectionMenuCursorPosition]
	ld [hl], a
	ret

; return b = item1, c = item2
.GetSelectedCardItems:
	ld a, [wSelectedGrandMasterCupPrizeItem1]
	ld b, a
	ld a, [wSelectedGrandMasterCupPrizeItem2]
	ld c, a
	ret

.OpenCardPage:
	ld a, [wGrandMasterCupPrizeSelectionMenuCursorPosition]
	add a
	add a
	ld c, a
	ld b, $00
	ld hl, wGrandMasterCupPrizes
	add hl, bc
	inc hl
	inc hl
	ld e, [hl] ; low card id
	inc hl
	ld d, [hl] ; high card id
; harmless bug, uses farcall bank1 for all these three funcs
; but BANK(LoadCardDataToBuffer1_FromCardID) = 0
	farcall 1, LoadCardDataToBuffer1_FromCardID
	farcall SetupDuel
	farcall OpenCardPage_FromHand
	ret

; a = [0, 3]
; bc = card id
; hl = card name
LoadGrandMasterCupPrizeCardData:
	push af
	push bc
	push de
	push hl
	ld d, h
	ld e, l
	push bc
	add a
	add a
	ld c, a
	ld b, $00
	ld hl, wGrandMasterCupPrizes
	add hl, bc
	pop bc
	ld [hl], e
	inc hl
	ld [hl], d
	inc hl
	ld [hl], c
	inc hl
	ld [hl], b
	pop hl
	pop de
	pop bc
	pop af
	ret

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

Func_1f84c:
	farcall Func_102a4
	call Func_1f858
	farcall Func_102c4
	ret

Func_1f858:
	push af
	push bc
	push de
	push hl
	ld [wdd93], a
	call Func_1f867
	pop hl
	pop de
	pop bc
	pop af
	ret

Func_1f867:
	farcall ZeroObjectPositionsAndEnableOBPFading
	farcall SetInitialGraphicsConfiguration
	call Func_1f88f
	call StartFadeFromWhite
	call WaitPalFading_Bank07
	ldtx hl, GameCenterCardDungeonUnableNotEnoughChipsText
	ld a, [wdd93]
	and a
	jr z, .asm_1f884
	ldtx hl, GameCenterCardDungeonDialogText
.asm_1f884
	farcall PrintScrollableText_NoTextBoxLabelVRAM0
	call StartFadeToWhite
	call WaitPalFading_Bank07
	ret

Func_1f88f:
	lb de, 0, 0
	lb bc, 20, 19
	call DrawRegularTextBoxVRAM0
	ldtx hl, GameCenterCardDungeonDescriptionText
	lb de, 1, 2
	call InitTextPrinting_ProcessTextFromIDVRAM0
	ldtx hl, GameCenterCardDungeonTitleText
	lb de, 1, 0
	call Func_2c4b
	ldtx hl, GameCenter10ChipsPerPlayText
	lb de, 13, 0
	call Func_2c4b
	lb de, 0, 12
	lb bc, 20, 6
	call DrawRegularTextBoxVRAM0
	ret

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
	ld a, MUSIC_PC_MAIN_MENU
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

Func_1f8eb:
	farcall Func_1022a
	call Func_1f8f7
	farcall Func_10252
	ret

Func_1f8f7:
	push af
	push bc
	push de
	push hl
	farcall SetFrameFuncAndFadeFromWhite
	farcall Func_2612a
	jr c, .asm_1f914
	ldtx hl, GameCenterToBeMailedText_2
	farcall PrintScrollableText_NoTextBoxLabelVRAM0
	call SetBillsPCCard
	ld a, $82 ; priority bill's PC mail
	call AddMailToQueue
.asm_1f914
	farcall FadeToWhiteAndUnsetFrameFunc
	pop hl
	pop de
	pop bc
	pop af
	ret

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
	animation TILESET_GLOW, SPRITE_ANIM_00, FRAMESET_000, PALETTE_0D8, SPRITE_ANIM_FLAG_UNSKIPPABLE, SFX_SONIC_BOOM, $00
; DUEL_ANIM_GLOW
	animation TILESET_GLOW, SPRITE_ANIM_00, FRAMESET_000, PALETTE_0D8, SPRITE_ANIM_FLAG_UNSKIPPABLE, SFX_GLOW, $00
; DUEL_ANIM_PARALYSIS
	animation TILESET_PARALYSIS, SPRITE_ANIM_01, FRAMESET_001, PALETTE_0D9, SPRITE_ANIM_FLAG_UNSKIPPABLE, SFX_PARALYSIS, $00
; DUEL_ANIM_SLEEP
	animation TILESET_SLEEP, SPRITE_ANIM_02, FRAMESET_002, PALETTE_0DA, SPRITE_ANIM_FLAG_UNSKIPPABLE, SFX_SLEEP, $00
; DUEL_ANIM_CONFUSION
	animation TILESET_CONFUSION_STAR, SPRITE_ANIM_03, FRAMESET_003, PALETTE_0DB, SPRITE_ANIM_FLAG_UNSKIPPABLE, SFX_CONFUSION, $00
; DUEL_ANIM_POISON
	animation TILESET_POISON, SPRITE_ANIM_04, FRAMESET_004, PALETTE_0DC, SPRITE_ANIM_FLAG_UNSKIPPABLE, SFX_POISON, $00
; DUEL_ANIM_SINGLE_HIT
	animation TILESET_HIT, SPRITE_ANIM_05, FRAMESET_005, PALETTE_0DD, SPRITE_ANIM_FLAG_UNSKIPPABLE, SFX_SMALL_HIT, $00
; DUEL_ANIM_HIT
	animation TILESET_HIT, SPRITE_ANIM_05, FRAMESET_006, PALETTE_0DD, SPRITE_ANIM_FLAG_UNSKIPPABLE, SFX_HIT, $00
; DUEL_ANIM_BIG_HIT
	animation TILESET_HIT, SPRITE_ANIM_05, FRAMESET_007, PALETTE_0DD, SPRITE_ANIM_FLAG_UNSKIPPABLE, SFX_HIT, $00
; DUEL_ANIM_SHOW_DAMAGE
	animation TILESET_DAMAGE, SPRITE_ANIM_06, FRAMESET_008, PALETTE_0DE, SPRITE_ANIM_FLAG_UNSKIPPABLE, NONE, $00
; DUEL_ANIM_THUNDER_SHOCK
	animation TILESET_THUNDER, SPRITE_ANIM_07, FRAMESET_015, PALETTE_0DF, NONE, SFX_THUNDER_SHOCK, $00
; DUEL_ANIM_LIGHTNING
	animation TILESET_LIGHTNING, SPRITE_ANIM_08, FRAMESET_016, PALETTE_0E0, NONE, SFX_LIGHTNING, $00
; DUEL_ANIM_BORDER_SPARK
	animation TILESET_SPARK, SPRITE_ANIM_09, FRAMESET_017, PALETTE_0E1, NONE, SFX_BORDER_SPARK, $00
; DUEL_ANIM_BIG_LIGHTNING
	animation TILESET_BIG_LIGHTNING, SPRITE_ANIM_0A, FRAMESET_018, PALETTE_0E2, SPRITE_ANIM_FLAG_CENTERED, SFX_BIG_LIGHTNING, $00
; DUEL_ANIM_SMALL_FLAME
	animation TILESET_EMBER, SPRITE_ANIM_0B, FRAMESET_019, PALETTE_0E3, NONE, SFX_SMALL_FLAME, $00
; DUEL_ANIM_BIG_FLAME
	animation TILESET_EMBER, SPRITE_ANIM_0B, FRAMESET_01A, PALETTE_0E3, NONE, SFX_BIG_FLAME, $00
; DUEL_ANIM_FIRE_SPIN
	animation TILESET_FIRE_SPIN, SPRITE_ANIM_0C, FRAMESET_01B, PALETTE_0E4, SPRITE_ANIM_FLAG_CENTERED, SFX_FIRE_SPIN, $00
; DUEL_ANIM_DIVE_BOMB
	animation TILESET_FIRE_BIRD, SPRITE_ANIM_0D, FRAMESET_01C, PALETTE_0E5, NONE, SFX_DIVE_BOMB, $00
; DUEL_ANIM_WATER_JETS
	animation TILESET_WATER_DROP, SPRITE_ANIM_0E, FRAMESET_021, PALETTE_0E6, SPRITE_ANIM_FLAG_CENTERED, SFX_WATER_JETS, $00
; DUEL_ANIM_WATER_GUN
	animation TILESET_WATER_GUN, SPRITE_ANIM_0F, FRAMESET_022, PALETTE_0E7, NONE, SFX_WATER_GUN, $00
; DUEL_ANIM_WHIRLPOOL
	animation TILESET_WHIRLPOOL, SPRITE_ANIM_10, FRAMESET_023, PALETTE_0E8, SPRITE_ANIM_FLAG_CENTERED, SFX_WHIRLPOOL, $00
; DUEL_ANIM_HYDRO_PUMP
	animation TILESET_HYDRO_PUMP, SPRITE_ANIM_11, FRAMESET_024, PALETTE_0E9, NONE, SFX_HYDRO_PUMP, $00
; DUEL_ANIM_BLIZZARD
	animation TILESET_SNOW, SPRITE_ANIM_12, FRAMESET_025, PALETTE_0EA, SPRITE_ANIM_FLAG_CENTERED, SFX_BLIZZARD, $00
; DUEL_ANIM_PSYCHIC
	animation TILESET_PSYCHIC, SPRITE_ANIM_13, FRAMESET_026, PALETTE_0EB, NONE, SFX_PSYCHIC, $00
; DUEL_ANIM_LEER
	animation TILESET_EVIL_EYES, SPRITE_ANIM_14, FRAMESET_027, PALETTE_0EC, NONE, SFX_LEER, $00
; DUEL_ANIM_BEAM
	animation TILESET_BEAM, SPRITE_ANIM_15, FRAMESET_028, PALETTE_0ED, SPRITE_ANIM_FLAG_Y_INVERTED | SPRITE_ANIM_FLAG_Y_FLIP, SFX_BEAM, $00
; DUEL_ANIM_HYPER_BEAM
	animation TILESET_HYPER_BEAM, SPRITE_ANIM_16, FRAMESET_029, PALETTE_0EE, SPRITE_ANIM_FLAG_Y_INVERTED | SPRITE_ANIM_FLAG_Y_FLIP, SFX_HYPER_BEAM, $00
; DUEL_ANIM_AVALANCHE
	animation TILESET_ROCK, SPRITE_ANIM_17, FRAMESET_02A, PALETTE_0EF, NONE, SFX_AVALANCHE, $00
; DUEL_ANIM_STONE_BARRAGE
	animation TILESET_ROCK, SPRITE_ANIM_17, FRAMESET_02B, PALETTE_0EF, NONE, SFX_STONE_BARRAGE, $00
; DUEL_ANIM_PUNCH
	animation TILESET_PUNCH, SPRITE_ANIM_18, FRAMESET_02C, PALETTE_0F0, NONE, SFX_PUNCH, $00
; DUEL_ANIM_THUNDER_PUNCH
	animation TILESET_PUNCH, SPRITE_ANIM_18, FRAMESET_02D, PALETTE_0F0, NONE, SFX_THUNDER_PUNCH, $00
; DUEL_ANIM_FIRE_PUNCH
	animation TILESET_PUNCH, SPRITE_ANIM_18, FRAMESET_02E, PALETTE_0F0, NONE, SFX_FIRE_PUNCH, $00
; DUEL_ANIM_STRETCH_KICK
	animation TILESET_STRETCH_KICK, SPRITE_ANIM_19, FRAMESET_02F, PALETTE_0F1, SPRITE_ANIM_FLAG_X_INVERTED | SPRITE_ANIM_FLAG_X_FLIP, SFX_STRETCH_KICK, $00
; DUEL_ANIM_SLASH
	animation TILESET_SLASH, SPRITE_ANIM_1A, FRAMESET_030, PALETTE_0F2, NONE, SFX_SLASH, $00
; DUEL_ANIM_WHIP
	animation TILESET_VINE_WHIP, SPRITE_ANIM_1B, FRAMESET_032, PALETTE_0F3, NONE, SFX_SLASH, $00
; DUEL_ANIM_SONIC_BOOM
	animation TILESET_SONIC_BOOM, SPRITE_ANIM_1C, FRAMESET_033, PALETTE_0F4, NONE, SFX_SONIC_BOOM, $00
; DUEL_ANIM_FURY_SWIPES
	animation TILESET_SLASH, SPRITE_ANIM_1A, FRAMESET_031, PALETTE_0F2, NONE, SFX_FURY_SWIPES, $00
; DUEL_ANIM_DRILL
	animation TILESET_HORN_DRILL, SPRITE_ANIM_1D, FRAMESET_034, PALETTE_0F5, SPRITE_ANIM_FLAG_X_INVERTED | SPRITE_ANIM_FLAG_X_FLIP, SFX_DRILL, $00
; DUEL_ANIM_POT_SMASH
	animation TILESET_POT_SMASH, SPRITE_ANIM_1E, FRAMESET_035, PALETTE_0F6, NONE, SFX_POT_SMASH, $00
; DUEL_ANIM_BONEMERANG
	animation TILESET_BONE, SPRITE_ANIM_1F, FRAMESET_036, PALETTE_0F7, NONE, SFX_BONEMERANG, $00
; DUEL_ANIM_SEISMIC_TOSS
	animation TILESET_SEISMIC_TOSS, SPRITE_ANIM_20, FRAMESET_037, PALETTE_0F8, NONE, SFX_SEISMIC_TOSS, $00
; DUEL_ANIM_NEEDLES
	animation TILESET_NEEDLES, SPRITE_ANIM_21, FRAMESET_038, PALETTE_0F9, NONE, SFX_NEEDLES, $00
; DUEL_ANIM_WHITE_GAS
	animation TILESET_GAS, SPRITE_ANIM_22, FRAMESET_039, PALETTE_0FA, NONE, SFX_WHITE_GAS, $00
; DUEL_ANIM_POWDER
	animation TILESET_POWDER, SPRITE_ANIM_23, FRAMESET_03A, PALETTE_0FB, NONE, SFX_POWDER, $00
; DUEL_ANIM_GOO
	animation TILESET_GOO, SPRITE_ANIM_24, FRAMESET_03B, PALETTE_0FC, NONE, SFX_GOO, $00
; DUEL_ANIM_BUBBLES
	animation TILESET_BUBBLE, SPRITE_ANIM_25, FRAMESET_03C, PALETTE_0FD, NONE, SFX_BUBBLES, $00
; DUEL_ANIM_STRING_SHOT
	animation TILESET_STRING_SHOT, SPRITE_ANIM_26, FRAMESET_03D, PALETTE_0FE, NONE, SFX_STRING_SHOT, $00
; DUEL_ANIM_BOYFRIENDS
	animation TILESET_HEART, SPRITE_ANIM_27, FRAMESET_03E, PALETTE_0FF, NONE, SFX_BOYFRIENDS, $00
; DUEL_ANIM_LURE
	animation TILESET_LURE, SPRITE_ANIM_28, FRAMESET_03F, PALETTE_100, SPRITE_ANIM_FLAG_X_INVERTED | SPRITE_ANIM_FLAG_X_FLIP, SFX_LURE, $00
; DUEL_ANIM_TOXIC
	animation TILESET_SKULL, SPRITE_ANIM_29, FRAMESET_040, PALETTE_101, NONE, SFX_TOXIC, $00
; DUEL_ANIM_CONFUSE_RAY
	animation TILESET_CONFUSE_RAY, SPRITE_ANIM_2A, FRAMESET_041, PALETTE_102, NONE, SFX_CONFUSE_RAY, $00
; DUEL_ANIM_SING
	animation TILESET_NOTES, SPRITE_ANIM_2B, FRAMESET_042, PALETTE_103, NONE, SFX_SING, $00
; DUEL_ANIM_SUPERSONIC
	animation TILESET_SOUND, SPRITE_ANIM_2C, FRAMESET_043, PALETTE_104, NONE, SFX_SUPERSONIC, $00
; DUEL_ANIM_PETAL_DANCE
	animation TILESET_PETAL, SPRITE_ANIM_2D, FRAMESET_044, PALETTE_105, SPRITE_ANIM_FLAG_CENTERED, SFX_PETAL_DANCE, $00
; DUEL_ANIM_PROTECT
	animation TILESET_PROTECT, SPRITE_ANIM_2E, FRAMESET_045, PALETTE_106, NONE, SFX_PROTECT, $00
; DUEL_ANIM_BARRIER
	animation TILESET_BARRIER, SPRITE_ANIM_2F, FRAMESET_046, PALETTE_107, NONE, SFX_BARRIER, $00
; DUEL_ANIM_SPEED
	animation TILESET_SPEED, SPRITE_ANIM_30, FRAMESET_047, PALETTE_108, SPRITE_ANIM_FLAG_CENTERED, SFX_SPEED, $00
; DUEL_ANIM_WHIRLWIND
	animation TILESET_WHIRLWIND, SPRITE_ANIM_31, FRAMESET_048, PALETTE_109, NONE, SFX_WHIRLWIND, $00
; DUEL_ANIM_CRY
	animation TILESET_SNIVEL, SPRITE_ANIM_32, FRAMESET_04A, PALETTE_10A, NONE, SFX_CRY, $00
; DUEL_ANIM_QUESTION_MARK
	animation TILESET_QUESTION_MARK, SPRITE_ANIM_33, FRAMESET_04B, PALETTE_10B, NONE, SFX_QUESTION_MARK, $00
; DUEL_ANIM_SELFDESTRUCT
	animation TILESET_EXPLOSION, SPRITE_ANIM_34, FRAMESET_04C, PALETTE_10C, NONE, SFX_SELFDESTRUCT, $00
; DUEL_ANIM_BIG_SELFDESTRUCT_1
	animation TILESET_EXPLOSION, SPRITE_ANIM_34, FRAMESET_04D, PALETTE_10C, NONE, SFX_BIG_SELFDESTRUCT, $00
; DUEL_ANIM_HEAL
	animation TILESET_HEAL, SPRITE_ANIM_35, FRAMESET_04F, PALETTE_10D, NONE, SFX_HEAL, $00
; DUEL_ANIM_DRAIN
	animation TILESET_DRAIN, SPRITE_ANIM_36, FRAMESET_051, PALETTE_10E, NONE, SFX_DRAIN, $00
; DUEL_ANIM_DARK_GAS
	animation TILESET_GAS, SPRITE_ANIM_22, FRAMESET_039, PALETTE_10F, NONE, SFX_DARK_GAS, $00
; DUEL_ANIM_BIG_SELFDESTRUCT_2
	animation TILESET_EXPLOSION, SPRITE_ANIM_34, FRAMESET_04E, PALETTE_10C, NONE, SFX_SELFDESTRUCT, $00
; DUEL_ANIM_UNUSED_HIT
	animation TILESET_HIT, SPRITE_ANIM_05, FRAMESET_006, PALETTE_0DD, SPRITE_ANIM_FLAG_UNSKIPPABLE, SFX_SMALL_HIT, $00
; DUEL_ANIM_UNUSED_BIG_HIT
	animation TILESET_HIT, SPRITE_ANIM_05, FRAMESET_007, PALETTE_0DD, SPRITE_ANIM_FLAG_UNSKIPPABLE, SFX_HIT, $00
; DUEL_ANIM_THUNDER_BENCH
	animation TILESET_THUNDER, SPRITE_ANIM_07, FRAMESET_015, PALETTE_0DF, NONE, SFX_THUNDER_SHOCK, $00
; DUEL_ANIM_QUICKFREEZE
	animation TILESET_SNOW, SPRITE_ANIM_12, FRAMESET_025, PALETTE_0EA, SPRITE_ANIM_FLAG_CENTERED, SFX_BLIZZARD, $00
; DUEL_ANIM_GLOW_BENCH
	animation TILESET_SMALL_GLOW, SPRITE_ANIM_37, FRAMESET_052, PALETTE_110, SPRITE_ANIM_FLAG_UNSKIPPABLE, SFX_GLOW, $00
; DUEL_ANIM_FIREGIVER_START
	animation TILESET_FIRE_BIRD, SPRITE_ANIM_0D, FRAMESET_01D, PALETTE_0E5, SPRITE_ANIM_FLAG_CENTERED, SFX_FIREGIVER_START, $00
; DUEL_ANIM_UNUSED_FIREGIVER_INIT
	animation TILESET_FIRE_BIRD, SPRITE_ANIM_0D, FRAMESET_01E, PALETTE_0E5, SPRITE_ANIM_FLAG_CENTERED, NONE, $00
; DUEL_ANIM_HEALING_WIND
	animation TILESET_HEAL, SPRITE_ANIM_35, FRAMESET_050, PALETTE_10D, SPRITE_ANIM_FLAG_CENTERED, SFX_HEALING_WIND, $00
; DUEL_ANIM_WHIRLWIND_BENCH
	animation TILESET_WHIRLWIND, SPRITE_ANIM_31, FRAMESET_049, PALETTE_109, SPRITE_ANIM_FLAG_CENTERED, SFX_WHIRLWIND_BENCH, $00
; DUEL_ANIM_EXPAND
	animation TILESET_EXPAND, SPRITE_ANIM_38, FRAMESET_053, PALETTE_111, NONE, SFX_EXPAND, $00
; DUEL_ANIM_CAT_PUNCH
	animation TILESET_CAT_PUNCH, SPRITE_ANIM_39, FRAMESET_054, PALETTE_112, NONE, SFX_CAT_PUNCH, $00
; DUEL_ANIM_THUNDER_WAVE
	animation TILESET_ELECTRIC_WAVE, SPRITE_ANIM_3A, FRAMESET_055, PALETTE_113, NONE, SFX_THUNDER_WAVE, $00
; DUEL_ANIM_FIREGIVER_PLAYER
	animation TILESET_FIRE_BIRD, SPRITE_ANIM_0D, FRAMESET_01F, PALETTE_0E5, SPRITE_ANIM_FLAG_CENTERED, SFX_FIREGIVER, $00
; DUEL_ANIM_FIREGIVER_OPP
	animation TILESET_FIRE_BIRD, SPRITE_ANIM_0D, FRAMESET_020, PALETTE_0E5, SPRITE_ANIM_FLAG_CENTERED, SFX_FIREGIVER, $00
; DUEL_ANIM_UNUSED_DECK_SWAP
	animation TILESET_CARD, SPRITE_ANIM_5C, FRAMESET_079, PALETTE_135, SPRITE_ANIM_FLAG_CENTERED | SPRITE_ANIM_FLAG_UNSKIPPABLE, NONE, $00
; DUEL_ANIM_PLAYER_SHUFFLE
	animation TILESET_CARD, SPRITE_ANIM_5C, FRAMESET_07A, PALETTE_135, SPRITE_ANIM_FLAG_CENTERED | SPRITE_ANIM_FLAG_UNSKIPPABLE, SFX_CARD_SHUFFLE, $00
; DUEL_ANIM_OPP_SHUFFLE
	animation TILESET_CARD, SPRITE_ANIM_5C, FRAMESET_07B, PALETTE_135, SPRITE_ANIM_FLAG_CENTERED | SPRITE_ANIM_FLAG_UNSKIPPABLE, SFX_CARD_SHUFFLE, $00
; DUEL_ANIM_BOTH_SHUFFLE
	animation TILESET_CARD, SPRITE_ANIM_5C, FRAMESET_07C, PALETTE_135, SPRITE_ANIM_FLAG_CENTERED | SPRITE_ANIM_FLAG_UNSKIPPABLE, SFX_CARD_SHUFFLE, $00
; DUEL_ANIM_UNUSED_DECK_SHIFT
	animation TILESET_CARD, SPRITE_ANIM_5C, FRAMESET_07D, PALETTE_135, SPRITE_ANIM_FLAG_CENTERED | SPRITE_ANIM_FLAG_UNSKIPPABLE, NONE, $00
; DUEL_ANIM_BOTH_DRAW
	animation TILESET_CARD, SPRITE_ANIM_5C, FRAMESET_07E, PALETTE_135, SPRITE_ANIM_FLAG_CENTERED | SPRITE_ANIM_FLAG_UNSKIPPABLE, NONE, $00
; DUEL_ANIM_PLAYER_DRAW
	animation TILESET_CARD, SPRITE_ANIM_5C, FRAMESET_07F, PALETTE_135, SPRITE_ANIM_FLAG_CENTERED | SPRITE_ANIM_FLAG_UNSKIPPABLE, NONE, $00
; DUEL_ANIM_OPP_DRAW
	animation TILESET_CARD, SPRITE_ANIM_5C, FRAMESET_080, PALETTE_135, SPRITE_ANIM_FLAG_CENTERED | SPRITE_ANIM_FLAG_UNSKIPPABLE, NONE, $00
; DUEL_ANIM_COIN_SPIN
	animation TILESET_TCG1_PIKACHU_COIN, SPRITE_ANIM_5D, FRAMESET_082, PALETTE_136, SPRITE_ANIM_FLAG_CENTERED | SPRITE_ANIM_FLAG_UNSKIPPABLE, NONE, $00
; DUEL_ANIM_COIN_TOSS_GOING_HEADS
	animation TILESET_TCG1_PIKACHU_COIN, SPRITE_ANIM_5D, FRAMESET_083, PALETTE_136, SPRITE_ANIM_FLAG_CENTERED | SPRITE_ANIM_FLAG_UNSKIPPABLE, SFX_COIN_TOSS, $00
; DUEL_ANIM_COIN_TOSS_GOING_TAILS
	animation TILESET_TCG1_PIKACHU_COIN, SPRITE_ANIM_5D, FRAMESET_084, PALETTE_136, SPRITE_ANIM_FLAG_CENTERED | SPRITE_ANIM_FLAG_UNSKIPPABLE, SFX_COIN_TOSS, $00
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
; DUEL_ANIM_UNUSED_DECK_PAUSE
	animation TILESET_CARD, SPRITE_ANIM_5C, FRAMESET_081, PALETTE_135, SPRITE_ANIM_FLAG_CENTERED | SPRITE_ANIM_FLAG_UNSKIPPABLE, NONE, $00
; DUEL_ANIM_PLACEHOLDER_61
	animation TILESET_GLOW, SPRITE_ANIM_00, FRAMESET_000, PALETTE_0D8, SPRITE_ANIM_FLAG_UNSKIPPABLE, SFX_SONIC_BOOM, $00
; DUEL_ANIM_PLACEHOLDER_62
	animation TILESET_GLOW, SPRITE_ANIM_00, FRAMESET_000, PALETTE_0D8, SPRITE_ANIM_FLAG_UNSKIPPABLE, SFX_SONIC_BOOM, $00
; DUEL_ANIM_PLACEHOLDER_63
	animation TILESET_GLOW, SPRITE_ANIM_00, FRAMESET_000, PALETTE_0D8, SPRITE_ANIM_FLAG_UNSKIPPABLE, SFX_SONIC_BOOM, $00
; DUEL_ANIM_FIREBALL
	animation TILESET_FIREBALLS, SPRITE_ANIM_3B, FRAMESET_056, PALETTE_114, SPRITE_ANIM_FLAG_X_INVERTED | SPRITE_ANIM_FLAG_Y_INVERTED | SPRITE_ANIM_FLAG_X_FLIP | SPRITE_ANIM_FLAG_Y_FLIP, SFX_FIREBALL, $00
; DUEL_ANIM_CONTINUOUS_FIREBALL
	animation TILESET_FIREBALLS, SPRITE_ANIM_3B, FRAMESET_057, PALETTE_114, SPRITE_ANIM_FLAG_X_INVERTED | SPRITE_ANIM_FLAG_Y_INVERTED | SPRITE_ANIM_FLAG_X_FLIP | SPRITE_ANIM_FLAG_Y_FLIP, SFX_CONTINUOUS_FIREBALL, $00
; DUEL_ANIM_BENCH_MANIPULATION
	animation TILESET_BENCH_MANIPULATION, SPRITE_ANIM_3C, FRAMESET_058, PALETTE_115, SPRITE_ANIM_FLAG_Y_INVERTED | SPRITE_ANIM_FLAG_CENTERED | SPRITE_ANIM_FLAG_Y_FLIP, SFX_BENCH_MANIPULATION, $00
; DUEL_ANIM_PSYCHIC_BEAM
	animation TILESET_PSYCHIC_BEAM, SPRITE_ANIM_3D, FRAMESET_059, PALETTE_116, SPRITE_ANIM_FLAG_Y_INVERTED | SPRITE_ANIM_FLAG_Y_FLIP, SFX_PSYCHIC_BEAM, $00
; DUEL_ANIM_PSYCHIC_BEAM_BENCH
	animation TILESET_PSYCHIC_BEAM_BENCH, SPRITE_ANIM_3E, FRAMESET_05A, PALETTE_117, SPRITE_ANIM_FLAG_Y_INVERTED | SPRITE_ANIM_FLAG_3 | SPRITE_ANIM_FLAG_Y_FLIP, SFX_PSYCHIC_BEAM_BENCH, $00
; DUEL_ANIM_BOULDER_SMASH
	animation TILESET_ROCK_THROW, SPRITE_ANIM_3F, FRAMESET_05B, PALETTE_118, NONE, SFX_BOULDER_SMASH, $00
; DUEL_ANIM_MEGA_PUNCH
	animation TILESET_MEGA_PUNCH, SPRITE_ANIM_40, FRAMESET_05C, PALETTE_119, NONE, SFX_MEGA_PUNCH, $00
; DUEL_ANIM_PSYPUNCH
	animation TILESET_PSYPUNCH, SPRITE_ANIM_41, FRAMESET_05D, PALETTE_11A, NONE, SFX_PSYPUNCH, $00
; DUEL_ANIM_SLUDGE_PUNCH
	animation TILESET_SLUDGE_PUNCH, SPRITE_ANIM_42, FRAMESET_05E, PALETTE_11B, NONE, SFX_SLUDGE_PUNCH, $00
; DUEL_ANIM_ICE_PUNCH
	animation TILESET_ICE_PUNCH, SPRITE_ANIM_43, FRAMESET_05F, PALETTE_11C, NONE, SFX_ICE_PUNCH, $00
; DUEL_ANIM_KICK
	animation TILESET_KICK, SPRITE_ANIM_44, FRAMESET_060, PALETTE_11D, NONE, SFX_KICK, $00
; DUEL_ANIM_TAIL_SLAP
	animation TILESET_TAIL_SLAP, SPRITE_ANIM_45, FRAMESET_061, PALETTE_11E, NONE, SFX_TAIL_SLAP, $00
; DUEL_ANIM_TAIL_WHIP
	animation TILESET_TAIL_WHIP, SPRITE_ANIM_46, FRAMESET_062, PALETTE_11F, SPRITE_ANIM_FLAG_X_INVERTED | SPRITE_ANIM_FLAG_X_FLIP, SFX_TAIL_WHIP, $00
; DUEL_ANIM_SLAP
	animation TILESET_SLAP, SPRITE_ANIM_47, FRAMESET_063, PALETTE_120, NONE, SFX_SLAP, $00
; DUEL_ANIM_QUESTION_MARK_BENCH
	animation TILESET_QUESTION_MARK_SMALL, SPRITE_ANIM_48, FRAMESET_064, PALETTE_121, NONE, SFX_QUESTION_MARK_BENCH, $00
; DUEL_ANIM_SKULL_BASH
	animation TILESET_SKULL_BASH, SPRITE_ANIM_49, FRAMESET_065, PALETTE_122, SPRITE_ANIM_FLAG_X_INVERTED | SPRITE_ANIM_FLAG_X_FLIP, SFX_SKULL_BASH, $00
; DUEL_ANIM_COIN_HURL
	animation TILESET_COIN_HURL, SPRITE_ANIM_4A, FRAMESET_066, PALETTE_123, NONE, SFX_COIN_HURL, $00
; DUEL_ANIM_TELEPORT
	animation TILESET_TELEPORT, SPRITE_ANIM_4B, FRAMESET_068, PALETTE_124, SPRITE_ANIM_FLAG_8x16, SFX_TELEPORT, $00
; DUEL_ANIM_FOLLOW_ME
	animation TILESET_FOLLOW_ME, SPRITE_ANIM_4C, FRAMESET_069, PALETTE_125, NONE, SFX_FOLLOW_ME, $00
; DUEL_ANIM_SWIFT
	animation TILESET_SWIFT, SPRITE_ANIM_4D, FRAMESET_06A, PALETTE_126, SPRITE_ANIM_FLAG_X_INVERTED | SPRITE_ANIM_FLAG_X_FLIP, SFX_SWIFT, $00
; DUEL_ANIM_3D_ATTACK
	animation TILESET_3D_ATTACK, SPRITE_ANIM_4E, FRAMESET_06B, PALETTE_127, NONE, SFX_3D_ATTACK, $00
; DUEL_ANIM_DRY_UP
	animation TILESET_WATER_DROP, SPRITE_ANIM_0E, FRAMESET_021, PALETTE_0E6, SPRITE_ANIM_FLAG_CENTERED, SFX_DRY_UP, $00
; DUEL_ANIM_FOCUS_BLAST
	animation TILESET_FOCUS_BLAST, SPRITE_ANIM_50, FRAMESET_06D, PALETTE_129, SPRITE_ANIM_FLAG_Y_INVERTED | SPRITE_ANIM_FLAG_Y_FLIP, SFX_FOCUS_BLAST, $00
; DUEL_ANIM_FOCUS_BLAST_BENCH
	animation TILESET_FOCUS_BLAST_BENCH, SPRITE_ANIM_51, FRAMESET_06E, PALETTE_12A, SPRITE_ANIM_FLAG_Y_INVERTED | SPRITE_ANIM_FLAG_3 | SPRITE_ANIM_FLAG_Y_FLIP, SFX_FOCUS_BLAST_BENCH, $00
; DUEL_ANIM_BONE_TOSS_BENCH
	animation TILESET_BONE2, SPRITE_ANIM_52, FRAMESET_06F, PALETTE_12B, NONE, SFX_BONE_TOSS_BENCH, $00
; DUEL_ANIM_COIN_HURL_BENCH
	animation TILESET_COIN_HURL, SPRITE_ANIM_4A, FRAMESET_067, PALETTE_123, NONE, SFX_COIN_HURL_BENCH, $00
; DUEL_ANIM_BIG_SNORE
	animation TILESET_BIG_SNORE, SPRITE_ANIM_53, FRAMESET_070, PALETTE_12C, NONE, SFX_BIG_SNORE, $00
; DUEL_ANIM_RAZOR_LEAF
	animation TILESET_RAZOR_LEAF, SPRITE_ANIM_54, FRAMESET_071, PALETTE_12D, SPRITE_ANIM_FLAG_X_INVERTED | SPRITE_ANIM_FLAG_X_FLIP, SFX_RAZOR_LEAF, $00
; DUEL_ANIM_GUILLOTINE
	animation TILESET_GUILLOTINE, SPRITE_ANIM_55, FRAMESET_072, PALETTE_12E, NONE, SFX_GUILLOTINE, $00
; DUEL_ANIM_VINE_PULL
	animation TILESET_VINE_PULL, SPRITE_ANIM_56, FRAMESET_073, PALETTE_12F, SPRITE_ANIM_FLAG_X_INVERTED | SPRITE_ANIM_FLAG_Y_INVERTED | SPRITE_ANIM_FLAG_X_FLIP | SPRITE_ANIM_FLAG_Y_FLIP, SFX_VINE_PULL, $00
; DUEL_ANIM_PERPLEX
	animation TILESET_PERPLEX, SPRITE_ANIM_57, FRAMESET_074, PALETTE_130, NONE, SFX_PERPLEX, $00
; DUEL_ANIM_NINE_TAILS
	animation TILESET_NINE_TAILS, SPRITE_ANIM_58, FRAMESET_075, PALETTE_131, NONE, SFX_NINE_TAILS, $00
; DUEL_ANIM_BONE_HEADBUTT
	animation TILESET_BONE_HEADBUTT, SPRITE_ANIM_59, FRAMESET_076, PALETTE_132, SPRITE_ANIM_FLAG_X_INVERTED | SPRITE_ANIM_FLAG_X_FLIP, SFX_BONE_HEADBUTT, $00
; DUEL_ANIM_DRILL_DIVE
	animation TILESET_DRILL_DIVE, SPRITE_ANIM_5A, FRAMESET_077, PALETTE_133, SPRITE_ANIM_FLAG_X_INVERTED | SPRITE_ANIM_FLAG_X_FLIP, SFX_DRILL_DIVE, $00
; DUEL_ANIM_DARK_SONG
	animation TILESET_DARK_SONG, SPRITE_ANIM_5B, FRAMESET_078, PALETTE_134, SPRITE_ANIM_FLAG_X_INVERTED | SPRITE_ANIM_FLAG_X_FLIP, SFX_DARK_SONG, $00
