; return a = streak
; harmless bug: also return bc = wUnusedCoinFlipGamePayout which is garbage but unused
CoinFlipGameScreen:
	farcall Func_1022a
	call ShowCoinFlipGame
	farcall Func_10252
	ret

; return a = streak
; harmless bug: also return bc = wUnusedCoinFlipGamePayout which is garbage but unused
ShowCoinFlipGame:
	push de
	push hl
	push af
	ld a, AUDVOL_HALF_VOLUME
	call CallSetVolume
	pop af
	call PlayCoinFlipGame
	push af
	ld a, AUDVOL_FULL_VOLUME
	call CallSetVolume
	pop af
	call .LoadPayout
	ld hl, wUnusedCoinFlipGamePayout
	ld c, [hl]
	inc hl
	ld b, [hl]
	ld a, [wCoinFlipGameStreak]
	pop hl
	pop de
	ret

; bug: never points at .payout and loads garbage to the buffer
.LoadPayout:
	ld a, [wCoinFlipGameStreak]
	add a
	ld c, a
	ld b, $00
	; ld hl, .payout
	add hl, bc
	ld a, [hli]
	ld [wUnusedCoinFlipGamePayout], a
	ld a, [hl]
	ld [wUnusedCoinFlipGamePayout + 1], a
	ret

.payout
	dw 0
	dw 0
	dw 0
	dw CHIPS_COIN_FLIP_STREAK_3
	dw CHIPS_COIN_FLIP_STREAK_4
	dw CHIPS_COIN_FLIP_STREAK_5
	dw CHIPS_COIN_FLIP_STREAK_6
	dw CHIPS_COIN_FLIP_STREAK_7
	dw CHIPS_COIN_FLIP_STREAK_8
	dw CHIPS_COIN_FLIP_STREAK_9
	dw 0

PlayCoinFlipGame:
	farcall ClearSpriteAnimsAndSetInitialGraphicsConfiguration
	call .DrawScreen
	farcall SetFrameFuncAndFadeFromWhite

.start
	ld c, 0
.loop_toss
	ld a, FRAMESET_112 - FRAMESET_112
	call SetAndInitCoinAnimation
.wait_input
	call UpdateRNGSources
	call DoFrame
	ldh a, [hKeysPressed]
	and PAD_A
	jr z, .wait_input
	call UpdateRNGSources
	and HEADS
	ld b, a
	push af
	ld a, SFX_COIN_TOSS
	call CallPlaySFX
	pop af
	ld a, b
	add 1
	call SetAndInitCoinAnimation
.wait_anim
	call DoFrame
	call IsCoinAnimating
	jr nz, .wait_anim
	ld a, b
	and HEADS
	jr nz, .tails
	push af
	ld a, SFX_COIN_TOSS_POSITIVE
	call CallPlaySFX
	pop af
	jr .toss_result
.tails
	push af
	ld a, SFX_COIN_TOSS_NEGATIVE
	call CallPlaySFX
	pop af
.toss_result
	ld a, b
	call .UpdateResultOnScreen
	ld a, 60
	call DoAFrames_WithPreCheck
	ld a, b
	and a
	jr nz, .finish
	inc c
	ld a, c
	cp MAX_NUM_GAMECENTER_COIN_FLIP_STREAK
	jr nz, .loop_toss
.finish
	ld a, c
	ld [wCoinFlipGameStreak], a
	cp MIN_NUM_GAMECENTER_COIN_FLIP_STREAK
	jr nc, .done
	call .RestartPrompt
	jr nc, .start

.done
	farcall FadeToWhiteAndUnsetFrameFunc
	ret

.DrawScreen:
	push af
	push bc
	push de
	push hl
	farcall ClearSpriteAnims
	call GetSelectedCoin
	lb de, 88, 88
	call CreateCoinAnimation
	ld a, FRAMESET_115 - FRAMESET_112
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

.UpdateResultOnScreen:
	push af
	push bc
	and a
	jr nz, .heads
	ld a, SCENE_COIN_TOSS_RESULT_1
	jr .draw_result
.heads
	ld a, SCENE_COIN_TOSS_RESULT_2
.draw_result
	ld b, c
	sla b ; *2, x
	ld c, $00 ; y
	call LoadScene
	call FlushAllPalettes
	pop bc
	pop af
	ret

.RestartPrompt:
	lb de, 0, 0
	lb bc, 8, 4
	farcall FillBoxInBGMapWithZero
	call DoFrame
	farcall TurnOnCurChipsHUD
	ldtx hl, GameCenterCoinFlipPlayAgainPromptText
	ldtx de, AttendantText
	ld a, $01
	farcall PrintScrollableText_WithTextBoxLabelWithYesOrNoMenu
	jr c, .got_decision
	farcall GetGameCenterChips
	ld a, b
	or c
	jr z, .not_enough_chips
	ld bc, CHIPS_BET_COIN_FLIP
	farcall DecreaseChipsSmoothly
	ld a, 60
	call DoAFrames_WithPreCheck
	scf
	ccf
.got_decision
	farcall TurnOffCurChipsHUD
	ret c
	call .DrawScreen
	ret
.not_enough_chips
	ldtx hl, GameCenterCoinFlipAttendantNotEnoughChipsText
	ldtx de, AttendantText
	farcall PrintScrollableText_WithTextBoxLabelVRAM0
	scf
	jr .got_decision

; unused
ShowCoinFlipGameDescription:
	farcall ClearSpriteAnimsAndSetInitialGraphicsConfiguration
	call .DrawTextBoxes
	call .PrintDescription
	farcall SetFrameFuncAndFadeFromWhite
	call .PrintCheers
	farcall FadeToWhiteAndUnsetFrameFunc
	ret

.DrawTextBoxes:
	lb de, 0, 0
	lb bc, 20, 12
	call DrawRegularTextBoxVRAM0
	lb de, 0, 12
	lb bc, 20, 6
	call DrawRegularTextBoxVRAM0
	ret

.PrintDescription:
	ldtx hl, GameCenterCoinFlipTitleText
	lb de, 1, 0
	call Func_2c4b
	ldtx hl, GameCenterCoinFlipDescriptionText
	lb de, 1, 2
	call InitTextPrinting_ProcessTextFromIDVRAM0
	ret

.PrintCheers:
	ldtx hl, GameCenterCoinFlipCheersText
	farcall PrintScrollableText_NoTextBoxLabelVRAM0
	ret
