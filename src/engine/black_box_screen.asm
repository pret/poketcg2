BlackBoxScreen:
	call Func_1022a
	call BlackBox
	call Func_10252
	ret

BlackBox:
	push bc
	push de
	push hl
	call .Start
	jr c, .done ; cancelled
	call PauseSong_SaveState
	push af
	ld a, MUSIC_CARD_POP
	call SetMusic
	pop af
	call .ShowProcedureScreen
	call ShowBlackBoxCardSelectionScreen
	jr c, .resume_song
	call ShowBlackBoxSendingCardsScreen
	scf
	ccf
.resume_song
	call ResumeSong_ClearTemp
.done
	pop hl
	pop de
	pop bc
	ret

.Start:
	call ClearSpriteAnimsAndSetInitialGraphicsConfiguration
	lb de, $40, $ff
	call SetupText
	call .ShowDescriptionScreen
	call SetFrameFuncAndFadeFromWhite
	call SetFadePalsFrameFunc
	call .StartPrompt
	jr c, .exit
	call .CheckQueue
	jr c, .exit
	call .CheckOwnedChips
	jr c, .exit
	call .SaveRequest
.exit
	call UnsetFadePalsFrameFunc
	call FadeToWhiteAndUnsetFrameFunc
	ret

.ShowDescriptionScreen:
	lb de, 0, 0
	lb bc, 20, 13
	call DrawRegularTextBoxVRAM0
	lb de, 0, 12
	lb bc, 20, 6
	call DrawRegularTextBoxVRAM0
	ldtx hl, GameCenterBlackBoxDescriptionText
	lb de, 1, 2
	call InitTextPrinting_ProcessTextFromIDVRAM0
	ldtx hl, GameCenterBlackBoxTitleText
	lb de, 1, 0
	call Func_2c4b
	ld hl, CHIPS_BET_BLACK_BOX
	call LoadTxRam3
	ldtx hl, GameCenterXChipsPerPlayText
	lb de, 14, 0
	call Func_2c4b
	ret

.StartPrompt:
	ldtx hl, GameCenterBlackBoxStartPromptText
	ld a, $01
	call DrawWideTextBox_PrintTextWithYesOrNoMenu
	ret c
	call PauseSong_SaveState
	push af
	ld a, MUSIC_GAME_CENTER_POWER_ON
	call CallPlaySong
	pop af
	call WaitForSongToFinish
	call ResumeSong_ClearTemp
	ret

.SaveRequest:
	ldtx hl, GameCenterBlackBoxSaveRequestText
	call PrintScrollableText_NoTextBoxLabelVRAM0
	ld c, FALSE
	farcall SaveGamePrompt
	ret nc
	ldtx hl, GameCenterBlackBoxUnableSaveRequiredText
	call PrintScrollableText_NoTextBoxLabelVRAM0
	ret

.CheckOwnedChips:
	call GetGameCenterChips
	ld de, CHIPS_BET_BLACK_BOX
	call CompareBCAndDE
	ret z
	ret nc
	ldtx hl, GameCenterBlackBoxUnableNotEnoughChipsText
	call PrintScrollableText_NoTextBoxLabelVRAM0
	ret

.CheckQueue:
	farcall CheckForBlackBoxCardInMail
	ret nc
	ldtx hl, GameCenterBlackBoxUnableLastOutputRemainingText
	call PrintScrollableText_NoTextBoxLabelVRAM0
	ldtx hl, GameCenterBlackBoxUnableLastOutputRemainingTextCont
	call PrintScrollableText_NoTextBoxLabelVRAM0
	ret

.ShowProcedureScreen:
	call ClearSpriteAnimsAndSetInitialGraphicsConfiguration
	call .DrawProcedureScreen
	call SetFrameFuncAndFadeFromWhite
	ldtx hl, GameCenterBlackBoxProcedureDialogText
	call PrintScrollableText_NoTextBoxLabelVRAM0
	call FadeToWhiteAndUnsetFrameFunc
	ret

.DrawProcedureScreen:
	lb de, 0, 12
	lb bc, 20, 6
	call DrawRegularTextBoxVRAM0
	bank1call SetNoLineSeparation
	ldtx hl, GameCenterBlackBoxProcedureText
	lb de, 1, 1
	call InitTextPrinting_ProcessTextFromIDVRAM0
	bank1call SetOneLineSeparation
	ret

ShowBlackBoxSendingCardsScreen:
	call ClearSpriteAnimsAndSetInitialGraphicsConfiguration
	call .CallLoadScene
	call SetFrameFuncAndFadeFromWhite
	call .ShowInsertScreen
	ldtx hl, GameCenterBlackBoxDoneText
	call PrintScrollableText_NoTextBoxLabelVRAM0
	call .TransmitAnim
	ldtx hl, GameCenterToBeMailedText
	call PrintScrollableText_NoTextBoxLabelVRAM0
	call FadeToWhiteAndUnsetFrameFunc
	ret

.CallLoadScene:
	call .LoadScene
	ret

.LoadScene:
	ld a, SCENE_BLACK_BOX
	lb bc, 0, 0
	call LoadScene
	ret

.ShowInsertScreen:
	call ClearSpriteAnims
	call CreateBlackBoxCardAnimation
	call FlushAllPalettes
	call CountBlackBoxSendingCards
	ld c, a
	ld a, 0
	lb de, 32, 32
.loop_insert
	push bc
	call .InsertingAnim
	call .InsertedAnim
	pop bc
	push af
	ld a, 24
	add d
	ld d, a
	pop af
	inc a
	dec c
	jr nz, .loop_insert
	ret

.InsertingAnim:
	push de
	lb de, 88, 88
	call SetBlackBoxSendingCardAnimPosition
	ld c, FRAMESET_163 - FRAMESET_162
	call SetBlackBoxSendingCardAnimFrameset
	pop de
	push af
	ld a, 40
	call DoAFrames_WithPreCheck
	push af
	ld a, SFX_BLACK_BOX_INSERT
	call CallPlaySFX
	pop af
	ld a, 40
	call DoAFrames_WithPreCheck
	pop af
	ret

.InsertedAnim:
	call SetBlackBoxSendingCardAnimPosition
	ld c, FRAMESET_162 - FRAMESET_162
	call SetBlackBoxSendingCardAnimFrameset
	push af
	ld a, SFX_BLACK_BOX_INSERTED
	call CallPlaySFX
	pop af
	push af
	ld a, 20
	call DoAFrames_WithPreCheck
	pop af
	ret

.TransmitAnim:
	ld a, 0
	ld c, MAX_NUM_BLACK_BOX_INPUT
.loop_transmit
	push bc
	ld c, FRAMESET_164 - FRAMESET_162
	call SetBlackBoxSendingCardAnimFrameset
	pop bc
	inc a
	dec c
	jr nz, .loop_transmit
	ld a, 60
	call DoAFrames_WithPreCheck
	call ClearSpriteAnims
	call CreateBlackBoxEnvelopeAnimation
	call FlushAllPalettes
	ld a, 40
	call DoAFrames_WithPreCheck
	push af
	ld a, SFX_BLACK_BOX_TRANSMITTED
	call CallPlaySFX
	pop af
	ld a, 20
	call DoAFrames_WithPreCheck
	ret

CreateBlackBoxCardAnimation:
	ld hl, .SpriteAnimGfxParams
	ld b, BANK(.SpriteAnimGfxParams)
	lb de, 192, 192
	ld c, MAX_NUM_BLACK_BOX_INPUT
.loop_cards
	push hl
	push bc
	ld a, $ff
	ld c, $00
	call CreateSpriteAnim
	pop bc
	pop hl
	dec c
	jr nz, .loop_cards
	ret

.SpriteAnimGfxParams:
	dw TILESET_BLACK_BOX_CARD, SPRITE_ANIM_9B, FRAMESET_162, PALETTE_139

; a = card index [0, 4]
SetBlackBoxSendingCardAnimPosition:
	push af
	push bc
	push de
	push hl
	ld c, a
	call SetCthSpriteAnimPosition
	pop hl
	pop de
	pop bc
	pop af
	ret

; a = card index [0, 4]
; c = frameset index [0, 2]
SetBlackBoxSendingCardAnimFrameset:
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

.FramesetIDs:
	dw FRAMESET_162 ; inserted/registered
	dw FRAMESET_163 ; inserting
	dw FRAMESET_164 ; transmitting

CreateBlackBoxEnvelopeAnimation:
	ld hl, .SpriteAnimGfxParams
	ld b, BANK(.SpriteAnimGfxParams)
	ld a, $ff
	lb de, 88, 88
	ld c, $00
	call CreateSpriteAnim
	ret

.SpriteAnimGfxParams:
	dw TILESET_ENVELOPE, SPRITE_ANIM_9C, FRAMESET_165, PALETTE_13A

ShowBlackBoxCardSelectionScreen:
	call ClearSpriteAnimsAndSetInitialGraphicsConfiguration
	call SetFrameFuncAndFadeFromWhite
	call SetFadePalsFrameFunc
.card_selection
	farcall HandleBlackBoxSendCardsScreen
	jr nc, .verify
	ldtx hl, GameCenterBlackBoxCancelPromptText
	ld a, $01
	call DrawWideTextBox_PrintTextWithYesOrNoMenu
	jr c, .card_selection
	scf
	jr .exit

.verify
	call CountBlackBoxSendingCards
	and a
	jr nz, .confirm_prompt
	ldtx hl, NoCardsSelectedTryAgainText
	call PrintScrollableText_NoTextBoxLabelVRAM0
	jr .card_selection

.confirm_prompt
	call .ShowCardSelection
	ldtx hl, GameCenterBlackBoxConfirmPromptText
	ld a, $01
	call DrawWideTextBox_PrintTextWithYesOrNoMenu
	jr c, .card_selection
	call .Payment

.exit
	call UnsetFadePalsFrameFunc
	call FadeToWhiteAndUnsetFrameFunc
	ret

.Payment:
	call TurnOnCurChipsHUD
	ldtx hl, GameCenterBlackBoxChipsPaidText
	call PrintScrollableText_NoTextBoxLabelVRAM0
	ld bc, CHIPS_BET_BLACK_BOX
	call DecreaseChipsSmoothly
	ld a, 30
	call DoAFrames_WithPreCheck
	call TurnOffCurChipsHUD
	ret

.ShowCardSelection:
	farcall PrintBlackBoxSendingCardList
	ldtx hl, GameCenterBlackBoxSendingHeaderText
	lb de, 1, 1
	call InitTextPrinting_ProcessTextFromIDVRAM0
	call CountBlackBoxSendingCards
	ld [wTxRam3], a
	xor a
	ld [wTxRam3 + 1], a
	ld bc, MAX_NUM_BLACK_BOX_INPUT
	ld a, c
	ld [wTxRam3_b], a
	ld a, b
	ld [wTxRam3_b + 1], a
	ldtx hl, NumberSlashNumberText
	lb de, 16, 1
	call PrintTextNoDelay_InitVRAM0
	ret

CountBlackBoxSendingCards:
	push bc
	push hl
	ld hl, wCurDeckCards
	ld c, 0
.loop_cards
	ld a, [hli]
	ld b, a
	ld a, [hli]
	or b
	jr z, .done
	inc c
	jr .loop_cards
.done
	ld a, c
	pop hl
	pop bc
	ret
