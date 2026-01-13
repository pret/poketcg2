; a -> wChallengeMachineIndex (island)
; b -> wChallengeMachineCurRound [0, 4]
; c -> wChallengeMachineDuelResult
ChallengeMachine:
	call Func_102a4
	call _ChallengeMachine
	call Func_102c4
	ret

_ChallengeMachine:
	push bc
	push de
	push hl
	ld [wChallengeMachineIndex], a
	ld a, c
	ld [wChallengeMachineDuelResult], a
	ld a, b
	ld [wChallengeMachineCurRound], a
	and a
	jr nz, .resume_challenge
; new challenge
	call ChallengeMachine_Start
	ld a, $00
	jr c, .exit
.resume_challenge
	call ChallengeMachine_DrawCurSet
	ld a, $01
.exit
	pop hl
	pop de
	pop bc
	ret

ChallengeMachine_Start:
	call ClearSpriteAnimsAndSetInitialGraphicsConfiguration
	lb de, $40, $ff
	call SetupText
	call ChallengeMachine_DrawScoreScreen
	call SetFrameFuncAndFadeFromWhite
	call ChallengeMachine_StartConfirmation
	call FadeToWhiteAndUnsetFrameFunc
	ret

ChallengeMachine_DrawScoreScreen:
	lb de, 0, 0
	lb bc, 20, 13
	call DrawRegularTextBoxVRAM0
	lb de, 0, 12
	lb bc, 20, 6
	call DrawRegularTextBoxVRAM0
	ld a, [wChallengeMachineIndex]
	add a
	ld c, a
	ld b, $00
	ld hl, .name_table
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	lb de, 1, 0
	call Func_2c4b
	ld hl, .text_items
	call PlaceTextItemsVRAM0
	ldtx hl, ChallengeMachineScoreTitleText
	lb de, 1, 2
	call PrintTextNoDelay_InitVRAM0
	ld hl, wChallengeMachineSetsWonRecords
	lb de, 14, 4
	call .PrintScore
	ld hl, wChallengeMachineCurWinStreaks
	lb de, 14, 6
	call .PrintScore
	ld hl, wChallengeMachineWinStreakRecords
	lb de, 14, 10
	call .PrintScore
	call .PrintPlayerName
	ret

.PrintScore:
	push hl
	ld a, [wChallengeMachineIndex]
	add a
	ld c, a
	ld b, $00
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, 3
	ld b, TRUE
	farcall PrintNumber
	pop hl
	ret

.text_items:
	textitem  2,  4, ChallengeMachineSetsWonRecordText
	textitem  2,  6, ChallengeMachineCurrentWinStreakText
	textitem  1,  8, ChallengeMachineWinStreakRecordText
	textitem 17,  4, AttemptsUnitText
	textitem 17,  6, WinsUnitText
	textitem 17, 10, WinsUnitText
	textitems_end

.name_table:
	tx TCGChallengeMachineText
	tx GRChallengeMachineText

.PrintPlayerName:
	ld de, wChallengeMachineTempPlayerName
	call LoadPlayerNameToDE
	ld a, [wChallengeMachineIndex]
REPT 4 ; *= NAME_BUFFER_LENGTH
	add a
ENDR
	ld c, a
	ld b, $00
	ld hl, wChallengeMachinePlayerNames
	add hl, bc
	call SavePlayerName
	ldtx hl, TxRam1Text
	lb de, 2, 10
	call PrintTextNoDelay_InitVRAM0
	ld hl, wChallengeMachineTempPlayerName
	call SavePlayerName
	ret

ChallengeMachine_StartConfirmation:
	ldtx hl, ChallengeMachineStartPromptText
	ld a, $01
	call DrawWideTextBox_PrintTextWithYesOrNoMenu
	ret

ChallengeMachine_DrawCurSet:
	call ClearSpriteAnimsAndSetInitialGraphicsConfiguration
	lb de, $40, $ff
	call SetupText
	call ChallengeMachine_DrawOpponentList
	call SetFrameFuncAndFadeFromWhite
	ld a, [wChallengeMachineDuelResult]
	and a
	jr z, .next_opponent
	call ChallengeMachine_PrintRoundResult
	ld a, [wChallengeMachineDuelResult]
	cp CHALLENGE_MACHINE_DUEL_LOSS_OR_QUIT
	jr z, .finished_set
	ld a, [wChallengeMachineCurRound]
	cp NUM_CHALLENGE_MACHINE_ROUNDS_PER_SET
	scf
	jr z, .finished_set
.next_opponent
	call ChallengeMachine_PrintOpponentDialog
	call ChallengeMachine_ProceedConfirmation
	jr nc, .done
; quit
	ld a, CHALLENGE_MACHINE_DUEL_LOSS_OR_QUIT
	ld [wChallengeMachineDuelResult], a
.finished_set
	call ChallengeMachine_PrintSetResult
.done
	call FadeToWhiteAndUnsetFrameFunc
	ret

ChallengeMachine_DrawOpponentList:
	lb de, 0, 0
	lb bc, 20, 13
	call DrawRegularTextBoxVRAM0
	lb de, 0, 12
	lb bc, 20, 6
	call DrawRegularTextBoxVRAM0
	ld a, [wChallengeMachineIndex]
	add a
	ld c, a
	ld b, $00
	ld hl, .name_table
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	lb de, 1, 0
	call Func_2c4b
	call ChallengeMachine_PrintOpponentInfo
	ret

.name_table:
	tx TCGChallengeMachineText
	tx GRChallengeMachineText

ChallengeMachine_PrintOpponentInfo:
	ld hl, wChallengeMachineOpponentTitlesAndNames
	ld c, NUM_CHALLENGE_MACHINE_ROUNDS_PER_SET
	ld e, 2 ; beginning y-pos
.loop_rounds
	call .PrintRoundNumber
	call .PrintOpponentTitle
	call .PrintOpponentName
; down 2 rows
	inc e
	inc e
	dec c
	jr nz, .loop_rounds
	ret

.PrintRoundNumber:
	push hl
	ld a, NUM_CHALLENGE_MACHINE_ROUNDS_PER_SET + 1
	sub c
	ld [wTxRam3], a
	xor a
	ld [wTxRam3 + 1], a
	ldtx hl, TxRam3Text
	ld d, 2 ; x-pos
	call PrintTextNoDelay_InitVRAM0
	pop hl
	ret

.PrintOpponentTitle:
	push hl
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld d, 4 ; x-pos
	call PrintTextNoDelay_InitVRAM0
	pop hl
	inc hl
	inc hl
	ret

.PrintOpponentName:
	push hl
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld d, 14 ; x-pos
	call PrintTextNoDelay_InitVRAM0
	pop hl
	inc hl
	inc hl
	ret

ChallengeMachine_PrintOpponentDialog:
	ld a, [wChallengeMachineCurRound]
	and a
	jr nz, .next_opponent
	ldtx hl, ChallengeMachineOpponentListDialogText
	call PrintScrollableText_NoTextBoxLabelVRAM0
.next_opponent
	ld a, [wChallengeMachineIndex]
	add a
	ld c, a
	ld b, $00
	ld hl, wChallengeMachineCurWinStreaks
	add hl, bc
	ld c, [hl]
	inc hl
	ld b, [hl]
	ld de, 1
	call CompareBCAndDE
	ret c
	ret z
	ld h, b
	ld l, c
	call LoadTxRam3 ; current win streak
	ld a, [wChallengeMachineCurRound]
	inc a
	ld [wTxRam3_b], a ; next round num
	xor a
	ld [wTxRam3_b + 1], a
	ld a, [wChallengeMachineCurRound]
	add a
	add a
	ld c, a
	ld b, $00
	ld hl, wChallengeMachineOpponentTitlesAndNames
	add hl, bc
	inc hl
	inc hl
	ld a, [hli]
	ld h, [hl]
	ld l, a
	call LoadTxRam2 ; next opp name
	ldtx hl, ChallengeMachineOpponentXDialogText
	call PrintScrollableText_NoTextBoxLabelVRAM0
	ret

ChallengeMachine_ProceedConfirmation:
.duel_prompt
	ldtx hl, ChallengeMachineDuelPromptText
	ld a, $01
	call DrawWideTextBox_PrintTextWithYesOrNoMenu
	ret nc
	ldtx hl, ChallengeMachineQuitWinStreakWarningText
	call PrintScrollableText_NoTextBoxLabelVRAM0
	ldtx hl, ChallengeMachineQuitPromptText
	ld a, $01
	call DrawWideTextBox_PrintTextWithYesOrNoMenu
	jr c, .duel_prompt
; quit
	scf
	ret

ChallengeMachine_PrintRoundResult:
	ld a, [wChallengeMachineCurRound]
	dec a
	add a
	add a
	ld c, a
	ld b, $00
	ld hl, wChallengeMachineOpponentTitlesAndNames
	add hl, bc
	inc hl
	inc hl
	ld a, [hli] ; last opp name
	ld [wTxRam2], a
	ld a, [hl]
	ld [wTxRam2 + 1], a
	ld a, [wChallengeMachineCurRound]
	ld l, a
	ld h, $00
	call LoadTxRam3 ; cur round num
	ld a, [wChallengeMachineDuelResult]
	dec a
	jr z, .won_round
; lost round
	ldtx hl, ChallengeMachineLossDialogText
	call PrintScrollableText_NoTextBoxLabelVRAM0
	ret
.won_round
	ldtx hl, ChallengeMachineWinDialogText
	call PrintScrollableText_NoTextBoxLabelVRAM0
	ret

ChallengeMachine_PrintSetResult:
	push af
	ld a, [wChallengeMachineDuelResult]
	dec a
	jr z, .won_set
; lost or quit
	ld a, [wChallengeMachineIndex]
	add a
	ld c, a
	ld b, $00
	ld hl, wChallengeMachineCurWinStreaks
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	call LoadTxRam3 ; cur win streak
	ldtx hl, ChallengeMachineLossDialogWinStreakText
	call PrintScrollableText_NoTextBoxLabelVRAM0
	jr .exit
.won_set
	call PauseSong_SaveState
	push af
	ld a, MUSIC_MEDAL
	call CallPlaySong
	pop af
	ldtx hl, ChallengeMachineWonASetText
	call PrintTextInWideTextBox
	call WaitForSongToFinish
	call ResumeSong_ClearTemp
	call WaitForWideTextBoxInput
	ld a, [wChallengeMachineIndex]
	add a
	ld c, a
	ld b, $00
	ld hl, wChallengeMachineSetsWonRecords
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	call LoadTxRam3 ; sets won
	ldtx hl, ChallengeMachineSetsWonText
	call PrintScrollableText_NoTextBoxLabelVRAM0
.exit
	ldtx hl, ChallengeMachineComeAgainText
	call PrintScrollableText_NoTextBoxLabelVRAM0
	pop af
	ret
