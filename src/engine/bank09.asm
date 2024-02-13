SECTION "Bank 9@409a", ROMX[$409a], BANK[$9]

; return carry if saved duel checksum
; in SRAM is not valid
CheckSavedDuelChecksum:
	call EnableSRAM
	ld hl, sSavedDuel
	ld a, [sSavedDuelChecksum + $2]
	call DisableSRAM
	cp $01
	jr nz, .continue
	scf
	ret

.continue
	call EnableSRAM
	push de
	ld a, [hli] ; sSavedDuel
	or a
	jr z, .set_carry
	lb de, $23, $45
	ld bc, $352
	ld a, [hl] ; sSavedDuelChecksum
	sub e
	ld e, a
	inc hl
	ld a, [hl]
	xor d
	ld d, a
	inc hl
	inc hl
	; hl = sSavedDuelData
.loop_data
	ld a, [hl]
	add e
	ld e, a
	ld a, [hli]
	xor d
	ld d, a
	dec bc
	ld a, c
	or b
	jr nz, .loop_data
	ld a, e
	or d
	jr z, .no_carry
.set_carry
	scf
.no_carry
	call DisableSRAM
	pop de
	ret

ClearSavedDuel:
	call EnableSRAM
	ld hl, sSavedDuel
	xor a
	ld [hli], a
	ld [hli], a
	ld [hl], a
	call DisableSRAM
	ret
; 0x240e6

SECTION "Bank 9@4158", ROMX[$4158], BANK[$9]

Func_24158:
	push hl
	call .Func_2416e
	ld a, $12
	call CopyCardNameAndLevel
	ld [hl], TX_END
	ld hl, $0
	call LoadTxRam2
	pop hl
	call DrawWideTextBox_WaitForInput
	ret

.Func_2416e:
	bank1call ZeroObjectPositionsAndToggleOAMCopy
	call EmptyScreen
	call LoadSymbolsFont
	bank1call SetDefaultPalettes
	ld a, $08
	ld [wDuelDisplayedScreen], a
	call LoadCardOrDuelMenuBorderTiles
	ld e, $00 ; trainer
	ld a, [wLoadedCard1Type]
	cp TYPE_TRAINER
	jr z, .asm_24193
	ld e, $01 ; energy
	and TYPE_ENERGY
	jr nz, .asm_24193
	ld e, $02 ; pkmn
.asm_24193
	push de
	ld a, e
	call LoadCardTypeHeaderTiles
	pop de
	ld d, $00
	ld hl, .CardTypeTileAttributes
	add hl, de
	ld a, [hl]
	lb de, 6, 1
	lb bc, 8, 2
	lb hl, 0, 0
	call BankswitchVRAM1
	call FillRectangle
	call BankswitchVRAM0
	ld de, v0Tiles1 + $200
	bank1call LoadLoadedCard1Gfx
	lb de, 6, 3
	bank1call DrawCardGfxToDE_BGPalIndex5
	bank1call FlushAllPalettesIfNotDMG
	ld hl, .TileData
	call WriteDataBlocksToBGMap0
	ret

.CardTypeTileAttributes:
	db $04 ; Trainer
	db $03 ; Energy
	db $02 ; Pkmn

.TileData:
	db  5,  0, $d0, $d4, $d4, $d4, $d4, $d4, $d4, $d4, $d4, $d1, 0
	db  5,  1, $d6, $e0, $e1, $e2, $e3, $e4, $e5, $e6, $e7, $d7, 0
	db  5,  2, $d6, $e8, $e9, $ea, $eb, $ec, $ed, $ee, $ef, $d7, 0
	db  5,  3, $d6, $a0, $a6, $ac, $b2, $b8, $be, $c4, $ca, $d7, 0
	db  5,  4, $d6, $a1, $a7, $ad, $b3, $b9, $bf, $c5, $cb, $d7, 0
	db  5,  5, $d6, $a2, $a8, $ae, $b4, $ba, $c0, $c6, $cc, $d7, 0
	db  5,  6, $d6, $a3, $a9, $af, $b5, $bb, $c1, $c7, $cd, $d7, 0
	db  5,  7, $d6, $a4, $aa, $b0, $b6, $bc, $c2, $c8, $ce, $d7, 0
	db  5,  8, $d6, $a5, $ab, $b1, $b7, $bd, $c3, $c9, $cf, $d7, 0
	db  5,  9, $d6, 0
	db 14,  9, $d7, 0
	db  5, 10, $d6, 0
	db 14, 10, $d7, 0
	db  5, 11, $d2, $d5, $d5, $d5, $d5, $d5, $d5, $d5, $d5, $d3, 0
	db $ff ; end

DrawDuelHorizontalSeparator:
	ld hl, .LineSeparatorTileData
	call WriteDataBlocksToBGMap0
	ld a, [wConsole]
	cp CONSOLE_CGB
	ret nz
	call BankswitchVRAM1
	ld hl, .LineSeparatorAttributeData
	call WriteDataBlocksToBGMap0
	call BankswitchVRAM0
	ret

.LineSeparatorTileData:
	db 0, 4, $34, $34, $34, $34, $34, $34, $34, $34, $34, $31, $32, 0
	db 9, 5, $33, $33, 0
	db 9, 6, $33, $33, 0
	db 9, 7, $32, $31, $34, $34, $34, $34, $34, $34, $34, $34, $34, 0
	db $ff ; end

.LineSeparatorAttributeData:
	db 0, 4, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, 0
	db 9, 5, $01, $21, 0
	db 9, 6, $01, $21, 0
	db 9, 7, $61, $61, $01, $01, $01, $01, $01, $01, $01, $01, $01, 0
	db $ff ; end
; 0x242c5

SECTION "Bank 9@4fe0", ROMX[$4fe0], BANK[$9]

DeckDiagnosis:
	farcall GetNumberOfDeckDiagnosisStepsUnlocked
	ld [wNumDeckDiagnosisSteps], a

	bank1call Func_4278

	call DisableLCD
	call LoadDeckDiagnosisScene
	call PrintDeckDiagnosisSteps
	call EnableLCD

	; initial text
	ldtx hl, Text053e
	call CheckDeck.PrintDrMasonText

	xor a
	ld [wDeckDiagnosisStep], a
.loop_menu
	ld a, [wDeckDiagnosisStep]
	ldh [hCurScrollMenuItem], a
	xor a ; menu to select the step
	ld [wDeckDiagnosisMenuStepSelected], a
	call HandleDeckDiagnosisMenu
	ld [wDeckDiagnosisStep], a
	cp $ff
	ret z ; exit Deck Diagnosis screen
	inc a
	ld [wDeckDiagnosisMenuStepSelected], a
	xor a
	ld [wcd29], a
.selected_step_menu
	ld a, [wcd29]
	ldh [hCurScrollMenuItem], a
	ld a, [wDeckDiagnosisMenuStepSelected]
	call HandleDeckDiagnosisMenu
	cp $ff
	jr z, .loop_menu
	ld [wcd29], a
	call Func_2517f
	call EmptyScreen
	call LoadDeckDiagnosisScene
	jr .selected_step_menu

DeckDiagnosisTextTables:
	dw .steps_menu
	dw .step_1
	dw .step_2
	dw .step_3
	dw .step_4

.steps_menu
	db $00
	dw NULL
	tx Text053f

	tx Text0540 ; Step 1
	tx Text0541 ; Step 2
	tx Text0542 ; Step 3
	tx Text0543 ; Step 4

.step_1
	db 5 ; number of items
	tx Text0532 ; text ID with all items

	; menu items
	tx Text0544 ; Check Deck
	tx Text0545 ; Advice 1
	tx Text0546 ; Advice 2
	tx Text0547 ; Advice 3
	tx Text0548 ; Back

.step_2
	db 4 ; number of items
	tx Text0533 ; text ID with all items

	; menu items
	tx Text0549 ; Advice 1
	tx Text054a ; Advice 2
	tx Text054b ; Advice 3
	tx Text0548 ; Back

.step_3
	db 4 ; number of items
	tx Text0534 ; text ID with all items

	; menu items
	tx Text054c ; Advice 1
	tx Text054d ; Advice 2
	tx Text054e ; Advice 3
	tx Text0548 ; Back

.step_4
	db 5 ; number of items
	tx Text0535 ; text ID with all items

	; menu items
	tx Text054f ; Advice 1
	tx Text0550 ; Advice 2
	tx Text0551 ; Advice 3
	tx Text0552 ; Advice 4
	tx Text0548 ; Back

; prints menu for the current Deck Diagnosis step
; depending on a:
; - 0 = menu to select which step to view
; - 1 = Step 1 menu
; - 2 = Step 2 menu
; - 3 = Step 3 menu
; - 4 = Step 4 menu
; returns item that player selected in a
; if player selected cancel (last item),
; returns $ff instead
HandleDeckDiagnosisMenu:
	add a ; *2
	ld e, a
	ld d, $00
	ld hl, DeckDiagnosisTextTables
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, [hli]
	ld e, [hl]
	inc hl
	ld d, [hl]
	inc hl
	push af
	push de
	ld a, l
	ld [wDeckDiagnosisTextIDsPtr + 0], a
	ld a, h
	ld [wDeckDiagnosisTextIDsPtr + 1], a
	lb de, 10, 0
	lb bc, 10, 12
	call DrawRegularTextBox
	pop hl

	; print the menu items
	lb de, 12, 0
	ld a, $06
	call ZeroAttributesAtDE
	call InitTextPrinting_ProcessTextFromID

	; initialize the menu
	ld hl, .MenuParameters
	ldh a, [hCurScrollMenuItem]
	call InitializeMenuParameters

	call .PrintCursorMenuItemText
	pop af
	or a
	call z, PrintDeckDiagnosisSteps
	ld [wNumScrollMenuItems], a
	call EnableLCD
.loop_input
	call DoFrame
	call HandleMenuInput
	jr nc, .loop_input
	ld hl, wNumScrollMenuItems
	ld c, [hl]
	dec c
	cp c
	ret c
	ld a, $ff
	ret

.MenuParameters:
	db 11, 2 ; cursor x, cursor y
	db 2 ; y displacement between items
	db 5 ; number of items
	db SYM_CURSOR_R ; cursor tile number
	db SYM_SPACE ; tile behind cursor
	dw .UpdateFunc ; function pointer if non-0

.UpdateFunc:
	ldh a, [hDPadHeld]
	and D_UP | D_DOWN
	jr z, .check_a_btn
	call .PrintCursorMenuItemText
.check_a_btn
	ldh a, [hKeysPressed]
	bit A_BUTTON_F, a
	jr nz, .a_btn_pressed
	and B_BUTTON
	ret z
	; b btn pressed
	ld a, $ff
	ldh [hCurScrollMenuItem], a
.a_btn_pressed
	scf
	ret

.PrintCursorMenuItemText:
	ld a, [wDeckDiagnosisMenuStepSelected]
	or a
	jr nz, .load_text_id
	; is inside menu to select which step
	ld a, [wNumDeckDiagnosisSteps]
	ld hl, hCurScrollMenuItem
	cp [hl]
	jr nc, .load_text_id
	; cursor is on cancel (last item)
	ldtx hl, Text0543
	jr .print_text
.load_text_id
	; loads text ID from wDeckDiagnosisTextIDsPtr
	; depending on which menu item the cursor is on
	ldh a, [hCurScrollMenuItem]
	add a ; *2
	ld e, a
	ld d, $00
	ld hl, wDeckDiagnosisTextIDsPtr
	ld a, [hli]
	ld h, [hl]
	ld l, a
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
.print_text
	push hl
	lb de, 0, 12
	lb bc, 20, 6
	ldtx hl, Text04f7
	call DrawLabeledTextBox
	pop hl
	lb de, 1, 14
	call InitTextPrinting_ProcessTextFromID
	ret

PrintDeckDiagnosisSteps:
	lb de, 10,  0
	lb bc, 10, 12
	call DrawRegularTextBox

	ld a, [wNumDeckDiagnosisSteps]
	inc a
	ld c, a
	lb de, 12, 2
	ld hl, .text_ids
.loop
	push hl
	push de
	push bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	call InitTextPrinting_ProcessTextFromID
	pop bc
	pop de
	pop hl
	inc hl
	inc hl
	inc e
	inc e
	dec c
	jr nz, .loop

	ldtx hl, Text0531
	call InitTextPrinting_ProcessTextFromID
	ld a, [wNumDeckDiagnosisSteps]
	add 2
	ret

.text_ids
	tx Text0529 ; Step 1
	tx Text052a ; Step 2
	tx Text052b ; Step 3
	tx Text052c ; Step 4

; loads Deck Diagnosis scene together
; with Dr. Mason's portrait
LoadDeckDiagnosisScene:
	lb bc, 1, 1
	ld a, SCENE_DECK_DIAGNOSIS
	call LoadScene
	lb bc, 2, 6
;	fallthrough
DrawDrMasonsPortrait:
	ld a, $5f
	ld e, PORTRAITVARIANT_NORMAL
	call Func_3ab2
	call FlushAllPalettes
	ret

Func_2517f:
	call EmptyScreen
	ldh a, [hCurScrollMenuItem]
	ld [wDeckDiagnosisAdvice], a
	call .GetTextIDsForAdvice
	jp c, CheckDeck
	call .Func_251c2
	bank1call SetNoLineSeparation
.loop
	push hl
	lb de, 0, 8
	lb bc, 20, 10
	call DrawRegularTextBox
	pop hl

	push hl
	ld a, [hli]
	ld h, [hl]
	ld l, a
	lb de, 1, 9
	call InitTextPrinting_ProcessTextFromID
	call WaitForWideTextBoxInput
	pop hl
	inc hl
	inc hl
	ld a, [hli]
	or [hl]
	dec hl
	jr z, .done
	push hl
	call .GetTextIDsForAdvice
	call .Func_251c2
	pop hl
	jr .loop
.done
	bank1call SetOneLineSeparation
	or a
	ret

.Func_251c2:
	push de
	push hl
	ld a, [wDeckDiagnosisStep]
	add a ; *2
	ld e, a
	ld d, $00
	ld hl, .StepTextIDs
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	lb de, 10, 2
	call InitTextPrinting_ProcessTextFromID
	pop hl
	lb de, 10, 5
	call InitTextPrinting_ProcessTextFromID
	lb bc, 2, 1
	call DrawDrMasonsPortrait
	call EnableLCD
	pop hl
	ret

; output:
; hl = textID of advice (Advice1, Advice2, etc)
; de = pointer to text IDs of that advice's explanation
; if hl is NULL, then return carry set, this is
; done in the Check Deck option, or an invalid entry
.GetTextIDsForAdvice:
	ld a, [wDeckDiagnosisAdvice]
	ld c, a
	ld a, [wDeckDiagnosisStep]
	add a
	add a
	add c
	add a
	add a
	; a = (wDeckDiagnosisStep * 4 + wDeckDiagnosisAdvice) * 4
	ld e, a
	ld d, $00
	ld hl, .AdviceTexts
	add hl, de
	ld e, [hl]
	inc hl
	ld d, [hl]
	inc hl
	ld a, [hli]
	ld h, [hl]
	ld l, a
	or h
	ret nz
	scf
	ret

.StepTextIDs:
	tx Text0529 ; Step 1
	tx Text052a ; Step 2
	tx Text052b ; Step 3
	tx Text052c ; Step 4

MACRO advice
	dw \1
	tx \2
ENDM

.AdviceTexts:
	; Step 1
	dw NULL, NULL                   ; Check Deck
	advice .step1_advice1, Text052d ; Advice 1
	advice .step1_advice2, Text052e ; Advice 2
	advice .step1_advice3, Text052f ; Advice 3

	; Step 2
	advice .step2_advice1, Text052d ; Advice 1
	advice .step2_advice2, Text052e ; Advice 2
	advice .step2_advice3, Text052f ; Advice 3
	dw NULL, NULL

	; Step 3
	advice .step3_advice1, Text052d ; Advice 1
	advice .step3_advice2, Text052e ; Advice 2
	advice .step3_advice3, Text052f ; Advice 3
	dw NULL, NULL

	; Step 4
	advice .step4_advice1, Text052d ; Advice 1
	advice .step4_advice2, Text052e ; Advice 2
	advice .step4_advice3, Text052f ; Advice 3
	advice .step4_advice4, Text0530 ; Advice 4

.step1_advice1
	tx Text055b
	tx Text055c
	dw NULL

.step1_advice2
	tx Text055d
	tx Text055e
	dw NULL

.step1_advice3
	tx Text055f
	tx Text0560
	dw NULL

.step2_advice1
	tx Text0561
	dw NULL

.step2_advice2
	tx Text0562
	dw NULL

.step2_advice3
	tx Text0563
	dw NULL

.step3_advice1
	tx Text0564
	tx Text0565
	tx Text0566
	tx Text0567
	dw NULL

.step3_advice2
	tx Text0568
	tx Text0569
	dw NULL

.step3_advice3
	tx Text056a
	tx Text056b
	dw NULL

.step4_advice1
	tx Text056c
	tx Text056d
	tx Text056e
	tx Text056f
	tx Text0570
	tx Text0571
	dw NULL

.step4_advice2
	tx Text0572
	tx Text0573
	tx Text0574
	dw NULL

.step4_advice3
	tx Text0575
	tx Text0576
	dw NULL

.step4_advice4
	tx Text0577
	tx Text0578
	dw NULL

CheckDeck:
.start
	ldtx de, Text0553
	farcall Func_2bc4f
	ret c
	ld l, a
	ld h, DECK_COMPRESSED_STRUCT_SIZE
	call HtimesL
	ld de, sDeck1
	add hl, de
	ld a, l
	ld [wcd2b + 0], a
	ld a, h
	ld [wcd2b + 1], a

	call EnableSRAM
	ld de, wDefaultText
	ld c, DECK_NAME_SIZE
.loop_copy_name
	ld a, [hli]
	ld [de], a
	inc de
	dec c
	jr nz, .loop_copy_name
	xor a ; TX_END
	ld [de], a
	call DisableSRAM
	ld hl, $0
	call LoadTxRam2

	call .CheckDeckDelay
	call .GetDeckCardCountsAndPrintCounts

	xor a
	ld [wcd4e], a
	ld a, PLAYER_TURN
	ldh [hWhoseTurn], a
	call .DoChecks

	ldtx de, Text04f7
	ldtx hl, Text055a
	call PrintScrollableText_WithTextBoxLabel_NoWait
	call YesOrNoMenu
	jr nc, .start
	ret

.DoChecks:
	; check has enough Basic cards
	ldtx hl, Text0579
	ld a, [wDeckCheckBasicCount]
	cp 12
	jp c, .PrintDrMasonText ; < 12 Basic cards

	; check color diversity
	call .CountTypesOfPkmnCards
	ldtx hl, Text057a
	cp 4
	jp nc, .PrintDrMasonText ; >= 4 different types

	call .DiagnoseNumberOfPkmnAndEnergyCards
	ret c ; already printed a diagnosis

	call .CheckIfEvolutionCardsHaveTheirPreEvos
	jr nc, .check_mismatched_evos
	ldtx hl, Text0580
	ldtx de, Text0581
	jp .asm_25352

.check_mismatched_evos
	call .LookForBasicCardsWithMismatchedEvolutionCounts
	jr nc, .check_mismatched_energy
	ldtx hl, Text0582
	ldtx de, Text0583
	jp .asm_25352

.check_mismatched_energy
	call .CheckIfAllEnergyCardsMatchPkmnColors
	jr c, .check_amount_energy_cards
	ldtx hl, Text0584
	ldtx de, Text0585
	jp .asm_25352

.check_amount_energy_cards
	call .CheckEnergyAmountVsPkmnCards
	ret c
	ldtx hl, Text058a
	ld a, [wDeckCheckTrainerCount]
	or a
	jr nz, .asm_2534d
	ldtx hl, Text058b
.asm_2534d
	call .PrintDrMasonText
	or a
	ret

.asm_25352
	push de
	call .PrintDrMasonText
	pop hl
	farcall DeckDiagnosisResult
	ret

; print a given text in the text box
; with Dr. Mason as the box header
; hl = text ID
.PrintDrMasonText:
	ldtx de, Text04f7 ; "Dr. Mason"
	call PrintScrollableText_WithTextBoxLabel
	ld hl, wcd4e
	inc [hl]
	ret

; outputs in a number of different colored types
; that are found in wDeckCheckPkmnCounts
.CountTypesOfPkmnCards:
	lb bc, 0, NUM_COLORED_TYPES
	ld hl, wDeckCheckPkmnCounts
.loop_pkmn_colored_types
	ld a, [hli]
	or a
	jr z, .none
	inc b
.none
	dec c
	jr nz, .loop_pkmn_colored_types
	ld a, b
	or a
	ret nz
	; output at least 1
	ld a, 1
	ret

.DiagnoseNumberOfPkmnAndEnergyCards:
	ld hl, wDeckCheckBasicCount
	ld a, [hli]
	add [hl]
	inc hl
	add [hl]
	ldtx hl, Text057c
	cp 31
	jr nc, .asm_25390
	ldtx hl, Text057b
	cp 18
	jr nc, .asm_25393
.asm_25390
	call .PrintDrMasonText

.asm_25393
	ld a, [wDeckCheckEnergyCount]
	ldtx hl, Text057f
	or a
	jr z, .asm_253aa
	ldtx hl, Text057d
	cp 20
	jr c, .asm_253aa
	ldtx hl, Text057e
	cp 31
	jr c, .asm_253ad
.asm_253aa
	call .PrintDrMasonText

.asm_253ad
	ld a, [wcd4e]
	or a
	ret z
	scf
	ret

.CheckDeckDelay:
	call EmptyScreen

	lb de,  0, 0
	lb bc, 20, 3
	call DrawRegularTextBox
	lb de, 3, 1
	ldtx hl, Text0536
	call PrintTextNoDelay_Init
	call EnableLCD
	ldtx de, Text04f7
	ldtx hl, Text0554
	call PrintScrollableText_WithTextBoxLabel_NoWait

	; delays for $80 frames,
	; every $10 frames cycle Dr. Mason's portrait
	; between normal and sad variants
	ld d, $80
	ld e, PORTRAITVARIANT_NORMAL
.check_delay
	ld a, d
	and %1111
	jr nz, .skip_portrait_switch
	; swap between normal and sad portrait
	ld a, e
	xor $2
	ld e, a
.skip_portrait_switch
	push de
	call DoFrame
	ld a, $5f
	lb bc, 7, 4
	call Func_3ab2
	call FlushAllPalettes
	pop de
	dec d
	jr nz, .check_delay

	; show happy portrait
	ld a, $5f
	ld e, PORTRAITVARIANT_HAPPY
	lb bc, 7, 4
	call Func_3ab2
	call FlushAllPalettes

	call WaitForWideTextBoxInput
	ret

.GetDeckCardCountsAndPrintCounts:
	call EmptyScreen

	lb de,  0,  0
	lb bc, 20, 12
	call DrawRegularTextBox
	lb de, 2, 0
	ldtx hl, Text0536
	call Func_2c4b
	lb de, 2, 2
	ldtx hl, Text0537
	call PrintTextNoDelay_Init

	ld hl, wcd2b
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld de, DECK_NAME_SIZE
	add hl, de
	call .GetDeckCardCounts

	; prints counts for Energy, Basic,
	; Stage1, Stage2 and Trainer cards
	lb bc, 14, 2
	ld hl, wDeckCheckCardCounts
	ld e, (wDeckCheckTrainerCount - wDeckCheckEnergyCount) + 1
.loop_counts
	ld a, [hli]
	push hl
	bank1call WriteTwoByteNumberInTxSymbolFormat
	pop hl
	inc c
	inc c ; two tiles spacing
	dec e
	jr nz, .loop_counts
	call EnableLCD
	ldtx de, Text04f7
	ldtx hl, Text0555
	call PrintScrollableText_WithTextBoxLabel
	ret

; given deck in hl, count how many cards
; of each type there are (Basic, Stage1, Stage2, Energy, Trainer)
; and within Energy cards, count each color as well
; outputs all results in wDeckCheckCardCounts
.GetDeckCardCounts:
	ld e, l
	ld d, h
	ld hl, wPlayerDeck
	push hl
	call EnableSRAM
	bank1call DecompressSRAMDeck
	call DisableSRAM
	pop hl

	push hl
	ld hl, wDeckCheckCardCounts
	ld c, wDeckCheckCardCountsEnd - wDeckCheckCardCounts
	xor a
.loop_clear
	ld [hli], a
	dec c
	jr nz, .loop_clear
	pop hl

.loop_deck
	ld e, [hl]
	inc hl
	ld d, [hl]
	inc hl
	call LoadCardDataToBuffer1_FromCardID
	ret c ; done
	push hl
	cp16 RAINBOW_ENERGY
	jr nz, .not_rainbow
	; rainbow energy has its own count
	ld hl, wDeckCheckRainbowEnergyCount
	inc [hl]
.not_rainbow
	ld a, [wLoadedCard1Type]
	ld e, $4
	cp TYPE_TRAINER
	jr z, .got_type
	ld e, $0
	cp TYPE_ENERGY
	jr nc, .got_type
	ld e, $1
	ld a, [wLoadedCard1Stage]
	or a
	jr z, .got_type
	ld e, $2
	cp STAGE1
	jr z, .got_type
	ld e, $3
.got_type
	ld d, $00
	ld hl, wDeckCheckCardCounts
	add hl, de
	inc [hl]
	ld a, [wLoadedCard1Type]
	bit TYPE_ENERGY_F, a
	jr z, .not_energy
	; is an energy card
	and TYPE_PKMN
	ld e, a
	ld hl, wDeckCheckEnergyCounts
	add hl, de
	inc [hl]
.not_energy
	ld a, [wLoadedCard1Type]
	cp TYPE_ENERGY
	jr nc, .not_pkmn
	; is a pkmn card
	and TYPE_PKMN
	ld e, a
	ld hl, wDeckCheckPkmnCounts
	add hl, de
	inc [hl]
.not_pkmn
	pop hl
	jr .loop_deck

.CheckIfEvolutionCardsHaveTheirPreEvos:
	ld de, wCurDeckCards
	call SetListPointer2
	ld hl, wPlayerDeck
	ld a, DECK_SIZE ; unused
.loop_evo_cards
	ld e, [hl]
	inc hl
	ld d, [hl]
	inc hl
	call LoadCardDataToBuffer1_FromCardID
	jr c, .done_evo_cards
	ld a, [wLoadedCard1Type]
	cp TYPE_ENERGY
	jr nc, .check_next_evo_card
	ld a, [wLoadedCard1Stage]
	or a
	jr z, .check_next_evo_card
	call .CheckIfHasPreEvo
	jr nc, .check_next_evo_card
	call Func_0b99
.check_next_evo_card
	jr .loop_evo_cards
.done_evo_cards
	ld de, $0
	call Func_0b99
	ld hl, wCurDeckCards
	ld a, [hli]
	or [hl]
	ret z
	scf
	ret

; returns carry if wPlayerDeck does not
; contain the pre-evolution of wLoadedCard1
.CheckIfHasPreEvo:
	push hl
	push de
	push bc
	ld hl, wLoadedCard1PreEvoName
	ld c, [hl]
	inc hl
	ld b, [hl]
	ld hl, wPlayerDeck
.loop_search_pre_evo
	ld e, [hl]
	inc hl
	ld d, [hl]
	inc hl
	call GetCardName
	jr c, .pre_evo_not_found
	ld a, c
	cp e
	jr nz, .loop_search_pre_evo
	ld a, b
	cp d
	jr nz, .loop_search_pre_evo
	or a
.pre_evo_not_found
	pop bc
	pop de
	pop hl
	ret

; creates a list in wCurDeckCards of Basic cards
; that have mismatched Stage 1 and Stage 2 card counts
; if this list is not empty, return carry set
.LookForBasicCardsWithMismatchedEvolutionCounts:
	ld de, wCurDeckCards
	call SetListPointer2

	; fills wDuelTempList with sequence
	; 0, 1, 2, 3, 4, ... to serve as deck indices
	ld hl, wDuelTempList
	xor a
.loop_fill_list_sequence
	ld [hli], a
	inc a
	cp DECK_SIZE
	jr c, .loop_fill_list_sequence
	ld [hl], $ff

	bank1call SortDuelTempListByCardID

	ld hl, wDuelTempList
.loop_filter_only_pkmn
	ld a, [hli]
	ldh [hTempCardIndex_ff98], a
	cp $ff
	jp z, .got_basic_card_list
	; keeps only PKMN cards or Mysterious Fossil
	; and removes all other cards
	call GetCardIDFromDeckIndex
	call LoadCardDataToBuffer1_FromCardID
	cp16 MYSTERIOUS_FOSSIL
	jr z, .basic_stage
	ld a, [wLoadedCard1Type]
	cp TYPE_ENERGY
	jr c, .check_stage
	; is not PKMN card or Mysterious Fossil
	ldh a, [hTempCardIndex_ff98]
	call RemoveCardFromDuelTempList
	jr .loop_filter_only_pkmn
.check_stage
	ld a, [wLoadedCard1Stage]
	or a
	jr nz, .loop_filter_only_pkmn

.basic_stage
	ld a, [wListPointer2 + 0]
	ld [wListPointer + 0], a
	ld a, [wListPointer2 + 1]
	ld [wListPointer + 1], a

	xor a
	ld hl, wDeckCheckCurBasicCount
	ld [hli], a ; wDeckCheckCurBasicCount
	ld [hli], a ; wDeckCheckCurStage1Count
	ld [hl], a  ; wDeckCheckCurStage2Count

	ld hl, wLoadedCard1Name
	ld e, [hl]
	inc hl
	ld d, [hl]
	call .CountAndRemoveCardsWithSameName
	ld [wDeckCheckCurBasicCount], a

; goes through 1st and 2nd stage cards
; that evolve from current basic card
; counts how many cards of each stage there are
.loop_search_stage1_and_stage2_cards
	call .CountAndRemoveCardsWithPreEvolution
	or a
	jr z, .no_more_evolutions
	push de
	ld hl, wDeckCheckCurStage1Count
	add [hl]
	ld [hl], a
	ld hl, wLoadedCard2Name
	ld e, [hl]
	inc hl
	ld d, [hl]
	call .CountAndRemoveCardsWithPreEvolution
	ld hl, wDeckCheckCurStage2Count
	add [hl]
	ld [hl], a
	pop de
	jr .loop_search_stage1_and_stage2_cards

.no_more_evolutions
	ld hl, wDeckCheckCurBasicCount
	ld a, [hli]
	cp [hl] ; wDeckCheckCurStage1Count
	jr c, .mismatched_evo_cards
	ld a, [hli] ; wDeckCheckCurStage1Count
	cp [hl] ; wDeckCheckCurStage2Count
	jr c, .mismatched_evo_cards
	ld a, [wListPointer + 0]
	ld [wListPointer2 + 0], a
	ld a, [wListPointer + 1]
	ld [wListPointer2 + 1], a
.mismatched_evo_cards
	ld hl, wDuelTempList
	jp .loop_filter_only_pkmn

.got_basic_card_list
	ld de, $0
	call Func_0b99
	ld hl, wCurDeckCards
	ld a, [hli]
	or a
	ret z
	; at least 1 entry
	scf
	ret

; outputs in a the number of cards that
; have card name in de as its pre-evolution
; if it finds any, also removes them from wDuelTempList
; only does this to first card ID it finds, so
; if a card has different evolution cards, this needs
; to be called again until there are not cards left
; de = card name
.CountAndRemoveCardsWithPreEvolution:
	push hl
	push de
	push bc
	ld hl, wDeckCheckCardName
	ld [hl], e
	inc hl
	ld [hl], d

	ld c, 0
	ld hl, wDuelTempList
.loop_search_card_evos
	ld a, [hli]
	cp $ff
	jr z, .got_card_evo_count
	call GetCardIDFromDeckIndex
	call LoadCardDataToBuffer2_FromCardID
	ld a, [wLoadedCard2Type]
	cp TYPE_ENERGY
	jr nc, .loop_search_card_evos

	; check if it evolves from card currently looked at
	; if so, add to count and remove it from wDuelTempList
	push hl
	ld hl, wDeckCheckCardName
	ld a, [wLoadedCard2PreEvoName + 0]
	cp [hl]
	jr nz, .not_cards_evo
	ld a, [wLoadedCard2PreEvoName + 1]
	inc hl
	cp [hl]
.not_cards_evo
	pop hl
	jr nz, .loop_search_card_evos

	ld a, [wLoadedCard2Name + 0]
	ld e, a
	ld a, [wLoadedCard2Name + 1]
	ld d, a
	call .CountAndRemoveCardsWithSameName
	ld c, a
.got_card_evo_count
	ld a, c
	pop bc
	pop de
	pop hl
	ret

; outputs in a the number of cards with the name in de
; if it finds any, also removes them from wDuelTempList
; de = card name
.CountAndRemoveCardsWithSameName:
	push hl
	push de
	push bc
	ld hl, wDeckCheckCardName
	ld [hl], e
	inc hl
	ld [hl], d

	ld c, 0
	ld hl, wDuelTempList
.loop_search_cards_with_same_name
	ld a, [hli]
	ldh [hTempCardIndex_ff98], a
	cp $ff
	jr z, .got_card_with_same_name_count
	call GetCardIDFromDeckIndex
	call GetCardName
	jr c, .got_card_with_same_name_count
	push hl
	ld hl, wDeckCheckCardName
	ld a, e
	cp [hl]
	jr nz, .not_same_name
	inc hl
	ld a, d
	cp [hl]
.not_same_name
	pop hl
	jr nz, .loop_search_cards_with_same_name

	; has same name, remove it from wDuelTempList
	; and add this card to list in wListPointer2
	ldh a, [hTempCardIndex_ff98]
	call GetCardIDFromDeckIndex
	call Func_0b99
	ldh a, [hTempCardIndex_ff98]
	call RemoveCardFromDuelTempList
	dec hl
	inc c
	jr .loop_search_cards_with_same_name

.got_card_with_same_name_count
	ld a, c
	pop bc
	pop de
	pop hl
	ret

; returns carry if for all energy cards there is at least
; one Pokémon card in the deck that matches its color
.CheckIfAllEnergyCardsMatchPkmnColors:
	ld hl, wPlayerDeck
	ld bc, wCurDeckCards
.loop_basic_energy
	ld e, [hl]
	inc hl
	ld d, [hl]
	inc hl
	call GetCardType
	jr c, .check_nonmatching_energy
	cp TYPE_ENERGY
	jr c, .matching_pkmn_found
	cp TYPE_ENERGY_DOUBLE_COLORLESS
	jr nc, .matching_pkmn_found

	; is basic energy card
	; check if there is at least a Pokémon
	; that has the same color as it
	push hl
	push de
	push bc
	and TYPE_PKMN
	ld c, a
	ld hl, wPlayerDeck
.loop_pkmn_cards
	ld e, [hl]
	inc hl
	ld d, [hl]
	inc hl
	call GetCardType
	jr c, .break_pkmn_loop
	cp TYPE_ENERGY
	jr nc, .next_pkmn_card ; not Pkmn
	cp c
	jr nz, .next_pkmn_card ; not same type as energy
	or a ; unset carry
	jr .break_pkmn_loop
.next_pkmn_card
	jr .loop_pkmn_cards
.break_pkmn_loop
	pop bc
	pop de
	pop hl
	jr nc, .matching_pkmn_found
	; reaching here means that no
	; Pokémon with matching color was found
	; so add the energy card ID to wCurDeckCards
	ld a, e
	ld [bc], a
	inc bc
	ld a, d
	ld [bc], a
	inc bc
.matching_pkmn_found
	jr .loop_basic_energy

.check_nonmatching_energy
	xor a
	ld [bc], a
	inc bc
	ld [bc], a
	ld hl, wCurDeckCards
	ld a, [hli]
	or [hl]
	jr z, .return_carry
	; first check if all Pokémon are colorless
	; in that case, return carry
	call .CountTypesOfPkmnCards
	cp 2
	jr nc, .at_least_2_types
	ld a, [wDeckCheckPkmnCounts + COLORLESS]
	or a
	jr nz, .return_carry
.at_least_2_types
	or a
	ret
.return_carry
	scf
	ret

; checks if each every type has right amount
; of energy, dependent on number of Pokémon cards
; for that type
.CheckEnergyAmountVsPkmnCards:
	call .CountTypesOfPkmnCards
	ld [wcd4b], a

	; counts total amount of energy that the deck provides
	; Double Colorless counts as 2 energies
	ld c, 0
	ld hl, wPlayerDeck
.loop_count_amount_energy
	ld e, [hl]
	inc hl
	ld d, [hl]
	inc hl
	call GetCardType
	jr c, .done_counting_energy
	cp TYPE_ENERGY
	jr c, .next_card
	cp TYPE_TRAINER
	jr nc, .next_card
	inc c
	cp16 DOUBLE_COLORLESS_ENERGY
	jr nz, .next_card
	inc c
.next_card
	jr .loop_count_amount_energy

.done_counting_energy
	ld hl, wDeckCheckBasicCount
	ld a, [hli] ; wDeckCheckBasicCount
	add [hl] ; wDeckCheckStage1Count
	inc hl
	add [hl] ; wDeckCheckStage2Count
	ld b, a ; total count of all Pkmn cards
	ld hl, wcd4b
	sub [hl]
	sub c
	jr z, .asm_256f4
	jr c, .asm_256f4
	; total Pkmn cards > wcd4b + total energy
	ldtx hl, Text0586
	call .PrintDrMasonText

.asm_256f4
	call .CalculateEnergySurplus
	ld hl, wDeckCheckEnergySurplus
	ld c, FIRE
	ld b, NUM_COLORED_TYPES
.loop_colored_types_1
	ld a, [hli]
	push hl
	push bc
	or a
	jr z, .asm_25737
	bit 7, a
	jr nz, .negative
	; surplus of energy cards
	ldtx hl, Text0587
	jr .get_energy_name
.negative
	; not enough energy cards
	ldtx hl, Text0588

.get_energy_name
	push hl
	ld a, c
	add a ; *2
	ld c, a
	ld b, $00
	ld hl, .TypeTextIDs
	add hl, bc
	ld e, [hl]
	inc hl
	ld d, [hl]
	ld hl, wTxRam2
	ld [hl], e
	inc hl
	ld [hl], d
	inc hl
	ld [hl], e
	inc hl
	ld [hl], d
	ld a, [wcd4e]
	or a
	jr nz, .asm_25733
	ldtx hl, Text058c
	call .PrintDrMasonText
.asm_25733
	pop hl
	call .PrintDrMasonText
.asm_25737
	pop bc
	pop hl
	inc c
	dec b
	jr nz, .loop_colored_types_1
	ld a, [wcd4e]
	or a
	ret z
	scf
	ret

.TypeTextIDs:
	tx Text053b ; FIRE
	tx Text0538 ; GRASS
	tx Text053a ; LIGHTNING
	tx Text0539 ; WATER
	tx Text053c ; FIGHTING
	tx Text053d ; PSYCHIC

.CalculateEnergySurplus:
	; divide colorless card counts
	; between the different types found
	ld a, [wDeckCheckPkmnCounts + COLORLESS]
	ld b, a
	ld c, 0
	ld a, [wcd4b]
	ld d, 0
	ld e, a
	; bc = colorless counts * 16
	; de = number different Pkmn types in deck
	call DivideBCbyDE
	; round up
	ld hl, $80
	add hl, bc
	ld a, h
	ld [wDeckCheckColorlessCardsPerType], a

	xor a
	ld [wDeckCheckTotalEnergySurplus], a
	ld hl, wDeckCheckPkmnCounts
	ld de, .TypeEnergyWeights
	ld b, NUM_COLORED_TYPES
	ld c, FIRE
.loop_colored_types_2
	push bc
	ld a, [de] ; weight
	ld b, a
	ld a, [hl] ; pkmn counts
	push de
	push hl
	ld l, a
	ld h, b
	or a
	jr z, .got_surplus_energy
	cp 2
	jr nc, .at_least_2_pkmn
	; count = 1
	dec a
.at_least_2_pkmn
	ld [wcd4c], a

	; multiply Pkmn count with type weight
	call HtimesL
	add hl, hl
	add hl, hl
	add hl, hl
	add hl, hl ; *16
	; round up
	ld de, $80
	add hl, de
	ld a, [wDeckCheckColorlessCardsPerType]
	add h
	ld [wDeckCheckTotalEnergyRequirement], a

	; sum this type's energy count
	; with rainbow energy count
	ld b, $00
	ld hl, wDeckCheckEnergyCounts
	add hl, bc
	ld a, [wDeckCheckRainbowEnergyCount]
	add [hl]
	ld e, a

	ld hl, wcd4c
	sub [hl]
	jr c, .got_surplus_energy ; jump if (total energy) < Pkmn count
	ld a, e
	ld hl, wDeckCheckTotalEnergyRequirement
	sub [hl]
	jr nc, .got_surplus_energy ; jump if (total energy) >= (energy requirement)
	xor a
.got_surplus_energy
	; a = 0, if (total energy) < (energy requirement)
	; a = (energy requirement) - (total energy), otherwise
	ld hl, wDeckCheckEnergySurplus
	add hl, bc
	ld [hl], a
	ld hl, wDeckCheckTotalEnergySurplus
	add [hl]
	ld [hl], a
	pop hl
	pop de
	pop bc
	inc de
	inc hl
	inc c
	dec b
	jr nz, .loop_colored_types_2

	ld a, [wDeckCheckEnergyCount]
	ld hl, wDeckCheckTotalEnergySurplus
	add [hl]
	cp 31
	jr nc, .asm_257d2
	; less than 31, set to 0
	xor a
.asm_257d2
	ld [hl], a
	ret

; these will contribute as weights to the number
; of energy cards each Pkmn of that type requires
.TypeEnergyWeights:
	db $13 ; x1.2 FIRE
	db $13 ; x1.2 GRASS
	db $13 ; x1.2 LIGHTNING
	db $13 ; x1.2 WATER
	db $15 ; x1.3 FIGHTING
	db $15 ; x1.3 PSYCHIC
; 0x257da

SECTION "Bank 9@58a2", ROMX[$58a2], BANK[$9]

; fills wCardPopCandidateList with cards that satisfy
; certain criteria:
; if a == $ff, then only output energy cards
; if a == $fe, then only output Phantom cards
; otherwise, output cards with:
; - rarity == a
; - b <= set <= c
; outputs in a the number of cards in the list
CreateCardPopCandidateList:
	cp $ff
	jr z, .energy_cards
	cp $fe
	jr z, .phantom_cards

	ld hl, wcd51
	ld [hli], a
	ld [hl], b ; wcd52
	inc hl
	ld [hl], c ; wcd53
	xor a
	ld [wcd54], a

	ld de, 0
	ld hl, wCardPopCandidateList
	jr .start_loop

.loop_ids
	push hl
	ld hl, wcd51
	ld a, b ; rarity
	cp [hl]
	jr nz, .next_card
	inc hl

	; accept sets >= minimum set
	ld a, c ; set
	cp [hl] ; wcd52
	jr z, .add_card
	jr c, .next_card

	; accept sets <= maximum set
	inc hl
	cp [hl] ; wcd53
	jr z, .add_card
	jr nc, .next_card

.add_card
	ld hl, wcd54
	inc [hl]
	pop hl
	ld [hl], e
	inc hl
	ld [hl], d
	inc hl
.start_loop
	push hl
.next_card
	inc de
	call GetCardTypeRarityAndSet
	pop hl
	jr nc, .loop_ids
	; no more cards
	xor a
	ld [hli], a
	ld [hl], a
	ld a, [wcd54] ; number of cards
	ret

.phantom_cards
	ld hl, .phantom_card_list
	jr .got_card_list
.energy_cards
	ld hl, .energy_card_list
.got_card_list
	ld c, 0
	ld de, wCardPopCandidateList
.loop_list
	ld a, [hli]
	ld b, a
	ld [de], a
	inc de
	ld a, [hli]
	ld [de], a
	inc de
	inc c
	or b
	jr nz, .loop_list
	ld a, c
	dec a
	ld [wcd54], a
	ret

.energy_card_list
	dw GRASS_ENERGY
	dw FIRE_ENERGY
	dw WATER_ENERGY
	dw LIGHTNING_ENERGY
	dw FIGHTING_ENERGY
	dw PSYCHIC_ENERGY
	dw GRASS_ENERGY
	dw FIRE_ENERGY
	dw WATER_ENERGY
	dw LIGHTNING_ENERGY
	dw FIGHTING_ENERGY
	dw PSYCHIC_ENERGY
	dw NULL

.phantom_card_list
	dw VENUSAUR_LV64
	dw MEW_LV15
	dw HERE_COMES_TEAM_ROCKET
	dw LUGIA
	dw VENUSAUR_LV64
	dw MEW_LV15
	dw HERE_COMES_TEAM_ROCKET
	dw LUGIA
	dw NULL

; a = deck ID
LoadDeckIDData:
	ld [wcc16], a
	ld c, a
	ld hl, DeckIDData
.loop_find
	ld a, [hl]
	cp $ff
	jr z, .not_found
	cp c
	jr z, .found
	ld de, 12
	add hl, de
	jr .loop_find
.not_found
	scf
	ret

.found
	inc hl
	ld a, [hli]
	ld [wOpponentDeckName + 0], a
	ld a, [hli]
	ld [wOpponentDeckName + 1], a
	ld a, [hli]
	ld [wOpponentName + 0], a
	ld a, [hli]
	ld [wOpponentName + 1], a
	ld a, [hli]
	ld [wcc12], a
	ld a, [hli]
	ld [wcc15], a
	ld a, [hli]
	ld [wSpecialRule], a
	ld a, [hli]
	ld [wcd0e], a
	ld a, [hli]
	ld [wcc17], a
	ld a, [hli]
	ld [wcd0f], a
	ld a, [hli]
	ld [wcc18], a
	or a
	ret

DeckIDData:
	db PLAYER_PRACTICE_DECK_ID
	tx Text04d6 ; deck name
	tx Text04d5 ; opponent name
	db $05 ; ?
	db $02 ; ?
	db NO_RULES ; special duel rules
	db $00 ; ?
	db $02 ; ?
	db $12 ; ?
	db $00 ; ?

	db STARTER_DECK_ID
	tx Text0448 ; deck name
	tx Text04f6 ; opponent name
	db $00 ; ?
	db $00 ; ?
	db NO_RULES ; special duel rules
	db $00 ; ?
	db $00 ; ?
	db $00 ; ?
	db $00 ; ?

	db SWEAT_ANTI_GR1_DECK_ID
	tx Text044d ; deck name
	tx Text04f6 ; opponent name
	db $00 ; ?
	db $00 ; ?
	db NO_RULES ; special duel rules
	db $00 ; ?
	db $00 ; ?
	db $00 ; ?
	db $00 ; ?

	db GIVE_IN_ANTI_GR2_DECK_ID
	tx Text0466 ; deck name
	tx Text04f6 ; opponent name
	db $00 ; ?
	db $00 ; ?
	db NO_RULES ; special duel rules
	db $00 ; ?
	db $00 ; ?
	db $00 ; ?
	db $00 ; ?

	db VENGEFUL_ANTI_GR3_DECK_ID
	tx Text0449 ; deck name
	tx Text04f6 ; opponent name
	db $00 ; ?
	db $00 ; ?
	db NO_RULES ; special duel rules
	db $00 ; ?
	db $00 ; ?
	db $00 ; ?
	db $00 ; ?

	db UNFORGIVING_ANTI_GR4_DECK_ID
	tx Text0470 ; deck name
	tx Text04f6 ; opponent name
	db $00 ; ?
	db $00 ; ?
	db NO_RULES ; special duel rules
	db $00 ; ?
	db $00 ; ?
	db $00 ; ?
	db $00 ; ?

	db SAMS_PRACTICE_DECK_ID
	tx Text04f1 ; deck name
	tx Text04f6 ; opponent name
	db $00 ; ?
	db $00 ; ?
	db NO_RULES ; special duel rules
	db $00 ; ?
	db $00 ; ?
	db $00 ; ?
	db $00 ; ?

	db AARON_PRACTICE_DECK1_ID
	tx Text04d6 ; deck name
	tx Text04d5 ; opponent name
	db $05 ; ?
	db $02 ; ?
	db NO_RULES ; special duel rules
	db $00 ; ?
	db $02 ; ?
	db $12 ; ?
	db $00 ; ?

	db AARONS_STEP1_DECK_ID
	tx Text04af ; deck name
	tx Text04f6 ; opponent name
	db $00 ; ?
	db $00 ; ?
	db NO_RULES ; special duel rules
	db $00 ; ?
	db $00 ; ?
	db $00 ; ?
	db $00 ; ?

	db AARON_PRACTICE_DECK2_ID
	tx Text0433 ; deck name
	tx Text0432 ; opponent name
	db $06 ; ?
	db $04 ; ?
	db NO_RULES ; special duel rules
	db $00 ; ?
	db $02 ; ?
	db $12 ; ?
	db $00 ; ?

	db AARONS_STEP2_DECK_ID
	tx Text04b0 ; deck name
	tx Text04f6 ; opponent name
	db $00 ; ?
	db $00 ; ?
	db NO_RULES ; special duel rules
	db $00 ; ?
	db $00 ; ?
	db $00 ; ?
	db $00 ; ?

	db AARON_PRACTICE_DECK3_ID
	tx Text0434 ; deck name
	tx Text0432 ; opponent name
	db $06 ; ?
	db $04 ; ?
	db NO_RULES ; special duel rules
	db $00 ; ?
	db $02 ; ?
	db $12 ; ?
	db $00 ; ?

	db AARONS_STEP3_DECK_ID
	tx Text04b1 ; deck name
	tx Text04f6 ; opponent name
	db $00 ; ?
	db $00 ; ?
	db NO_RULES ; special duel rules
	db $00 ; ?
	db $00 ; ?
	db $00 ; ?
	db $00 ; ?

	db BRICK_WALK_DECK_ID
	tx Text0435 ; deck name
	tx Text0432 ; opponent name
	db $06 ; ?
	db $04 ; ?
	db NO_RULES ; special duel rules
	db $00 ; ?
	db $02 ; ?
	db $12 ; ?
	db $00 ; ?

	db BENCH_TRAP_DECK_ID
	tx Text043e ; deck name
	tx Text0432 ; opponent name
	db $06 ; ?
	db $04 ; ?
	db NO_RULES ; special duel rules
	db $00 ; ?
	db $02 ; ?
	db $12 ; ?
	db $00 ; ?

	db SKY_SPARK_DECK_ID
	tx Text044b ; deck name
	tx Text0432 ; opponent name
	db $06 ; ?
	db $04 ; ?
	db NO_RULES ; special duel rules
	db $00 ; ?
	db $02 ; ?
	db $12 ; ?
	db $00 ; ?

	db ELECTRIC_SELFDESTRUCT_DECK_ID
	tx Text049d ; deck name
	tx Text04a3 ; opponent name
	db $0a ; ?
	db $06 ; ?
	db NO_RULES ; special duel rules
	db $00 ; ?
	db $03 ; ?
	db $09 ; ?
	db $05 ; ?

	db OVERFLOW_DECK_ID
	tx Text04c1 ; deck name
	tx Text04a3 ; opponent name
	db $0a ; ?
	db $06 ; ?
	db NO_RULES ; special duel rules
	db $00 ; ?
	db $03 ; ?
	db $09 ; ?
	db $05 ; ?

	db TRIPLE_ZAPDOS_DECK_ID
	tx Text0481 ; deck name
	tx Text04a0 ; opponent name
	db $0c ; ?
	db $04 ; ?
	db NO_RULES ; special duel rules
	db $00 ; ?
	db $02 ; ?
	db $01 ; ?
	db $00 ; ?

	db I_LOVE_PIKACHU_DECK_ID
	tx Text04ad ; deck name
	tx Text04a0 ; opponent name
	db $0c ; ?
	db $04 ; ?
	db NO_RULES ; special duel rules
	db $00 ; ?
	db $02 ; ?
	db $01 ; ?
	db $05 ; ?

	db TEN_THOUSAND_VOLTS_DECK_ID
	tx Text04c4 ; deck name
	tx Text04e4 ; opponent name
	db $0b ; ?
	db $04 ; ?
	db NO_RULES ; special duel rules
	db $00 ; ?
	db $02 ; ?
	db $01 ; ?
	db $00 ; ?

	db HAND_OVER_GR_DECK_ID
	tx Text0426 ; deck name
	tx Text04aa ; opponent name
	db $0d ; ?
	db $04 ; ?
	db NO_RULES ; special duel rules
	db $00 ; ?
	db $02 ; ?
	db $01 ; ?
	db $00 ; ?

	db PSYCHIC_ELITE_DECK_ID
	tx Text0471 ; deck name
	tx Text04d4 ; opponent name
	db $0e ; ?
	db $06 ; ?
	db NO_RULES ; special duel rules
	db $00 ; ?
	db $03 ; ?
	db $0a ; ?
	db $06 ; ?

	db PSYCHOKINESIS_DECK_ID
	tx Text0453 ; deck name
	tx Text04d4 ; opponent name
	db $0e ; ?
	db $06 ; ?
	db NO_RULES ; special duel rules
	db $00 ; ?
	db $03 ; ?
	db $0a ; ?
	db $06 ; ?

	db PHANTOM_DECK_ID
	tx Text0496 ; deck name
	tx Text04ec ; opponent name
	db $0f ; ?
	db $04 ; ?
	db NO_RULES ; special duel rules
	db $00 ; ?
	db $02 ; ?
	db $02 ; ?
	db $00 ; ?

	db PUPPET_MASTER_DECK_ID
	tx Text046e ; deck name
	tx Text04bd ; opponent name
	db $11 ; ?
	db $04 ; ?
	db NO_RULES ; special duel rules
	db $00 ; ?
	db $02 ; ?
	db $02 ; ?
	db $00 ; ?

	db EVEN3_YEARS_ON_A_ROCK_DECK_ID
	tx Text045f ; deck name
	tx Text0491 ; opponent name
	db $10 ; ?
	db $04 ; ?
	db NO_RULES ; special duel rules
	db $00 ; ?
	db $02 ; ?
	db $02 ; ?
	db $00 ; ?

	db ROLLING_STONE_DECK_ID
	tx Text0438 ; deck name
	tx Text0493 ; opponent name
	db $12 ; ?
	db $06 ; ?
	db NO_RULES ; special duel rules
	db $00 ; ?
	db $03 ; ?
	db $0b ; ?
	db $07 ; ?

	db GREAT_EARTHQUAKE_DECK_ID
	tx Text04f3 ; deck name
	tx Text04de ; opponent name
	db $13 ; ?
	db $04 ; ?
	db NO_RULES ; special duel rules
	db $00 ; ?
	db $02 ; ?
	db $03 ; ?
	db $00 ; ?

	db AWESOME_FOSSIL_DECK_ID
	tx Text044f ; deck name
	tx Text04b8 ; opponent name
	db $14 ; ?
	db $04 ; ?
	db NO_RULES ; special duel rules
	db $00 ; ?
	db $02 ; ?
	db $03 ; ?
	db $00 ; ?

	db RAGING_BILLOW_OF_FISTS_DECK_ID
	tx Text0498 ; deck name
	tx Text049c ; opponent name
	db $15 ; ?
	db $04 ; ?
	db NO_RULES ; special duel rules
	db $00 ; ?
	db $02 ; ?
	db $03 ; ?
	db $00 ; ?

	db YOU_CAN_DO_IT_MACHOP_DECK_ID
	tx Text04b2 ; deck name
	tx Text04e0 ; opponent name
	db $16 ; ?
	db $06 ; ?
	db NO_RULES ; special duel rules
	db $00 ; ?
	db $03 ; ?
	db $0c ; ?
	db $0c ; ?

	db NEW_MACHOKE_DECK_ID
	tx Text0440 ; deck name
	tx Text04ce ; opponent name
	db $17 ; ?
	db $04 ; ?
	db NO_RULES ; special duel rules
	db $00 ; ?
	db $02 ; ?
	db $04 ; ?
	db $00 ; ?

	db SKILLED_WARRIOR_DECK_ID
	tx Text04b7 ; deck name
	tx Text04ce ; opponent name
	db $17 ; ?
	db $04 ; ?
	db NO_RULES ; special duel rules
	db $00 ; ?
	db $02 ; ?
	db $04 ; ?
	db $00 ; ?

	db I_LOVE_TO_FIGHT_DECK_ID
	tx Text046a ; deck name
	tx Text04a5 ; opponent name
	db $18 ; ?
	db $04 ; ?
	db NO_RULES ; special duel rules
	db $00 ; ?
	db $02 ; ?
	db $04 ; ?
	db $00 ; ?

	db MAX_ENERGY_DECK_ID
	tx Text04bb ; deck name
	tx Text04b5 ; opponent name
	db $19 ; ?
	db $04 ; ?
	db NO_RULES ; special duel rules
	db $00 ; ?
	db $02 ; ?
	db $04 ; ?
	db $00 ; ?

	db REMAINING_GREEN_DECK_ID
	tx Text042c ; deck name
	tx Text0489 ; opponent name
	db $1a ; ?
	db $06 ; ?
	db NO_RULES ; special duel rules
	db $00 ; ?
	db $03 ; ?
	db $0d ; ?
	db $02 ; ?

	db POISON_CURSE_DECK_ID
	tx Text0461 ; deck name
	tx Text0475 ; opponent name
	db $1b ; ?
	db $04 ; ?
	db NO_RULES ; special duel rules
	db $00 ; ?
	db $02 ; ?
	db $05 ; ?
	db $00 ; ?

	db GLITTERING_SCALES_DECK_ID
	tx Text045d ; deck name
	tx Text0475 ; opponent name
	db $1b ; ?
	db $04 ; ?
	db NO_RULES ; special duel rules
	db $00 ; ?
	db $02 ; ?
	db $05 ; ?
	db $02 ; ?

	db STEADY_INCREASE_DECK_ID
	tx Text043c ; deck name
	tx Text04b9 ; opponent name
	db $1c ; ?
	db $04 ; ?
	db NO_RULES ; special duel rules
	db $00 ; ?
	db $02 ; ?
	db $05 ; ?
	db $00 ; ?

	db DARK_SCIENCE_DECK_ID
	tx Text04b3 ; deck name
	tx Text04d7 ; opponent name
	db $1d ; ?
	db $04 ; ?
	db NO_RULES ; special duel rules
	db $00 ; ?
	db $02 ; ?
	db $05 ; ?
	db $00 ; ?

	db NATURAL_SCIENCE_DECK_ID
	tx Text04a6 ; deck name
	tx Text048a ; opponent name
	db $1e ; ?
	db $06 ; ?
	db NO_RULES ; special duel rules
	db $00 ; ?
	db $03 ; ?
	db $0e ; ?
	db $08 ; ?

	db POISONOUS_SWAMP_DECK_ID
	tx Text044a ; deck name
	tx Text04df ; opponent name
	db $20 ; ?
	db $04 ; ?
	db NO_RULES ; special duel rules
	db $00 ; ?
	db $02 ; ?
	db $06 ; ?
	db $00 ; ?

	db GATHERING_NIDORAN_DECK_ID
	tx Text045b ; deck name
	tx Text04a1 ; opponent name
	db $1f ; ?
	db $04 ; ?
	db NO_RULES ; special duel rules
	db $00 ; ?
	db $02 ; ?
	db $06 ; ?
	db $00 ; ?

	db RAIN_DANCE_CONFUSION_DECK_ID
	tx Text042f ; deck name
	tx Text04cc ; opponent name
	db $21 ; ?
	db $04 ; ?
	db NO_RULES ; special duel rules
	db $00 ; ?
	db $02 ; ?
	db $06 ; ?
	db $00 ; ?

	db CONSERVING_WATER_DECK_ID
	tx Text0431 ; deck name
	tx Text047d ; opponent name
	db $22 ; ?
	db $06 ; ?
	db NO_RULES ; special duel rules
	db $00 ; ?
	db $03 ; ?
	db $0f ; ?
	db $04 ; ?

	db ENERGY_REMOVAL_DECK_ID
	tx Text0460 ; deck name
	tx Text049a ; opponent name
	db $23 ; ?
	db $04 ; ?
	db NO_RULES ; special duel rules
	db $00 ; ?
	db $02 ; ?
	db $07 ; ?
	db $00 ; ?

	db SPLASHING_ABOUT_DECK_ID
	tx Text0480 ; deck name
	tx Text049a ; opponent name
	db $23 ; ?
	db $04 ; ?
	db NO_RULES ; special duel rules
	db $00 ; ?
	db $02 ; ?
	db $07 ; ?
	db $04 ; ?

	db BEACH_DECK_ID
	tx Text0467 ; deck name
	tx Text04d3 ; opponent name
	db $24 ; ?
	db $04 ; ?
	db NO_RULES ; special duel rules
	db $00 ; ?
	db $02 ; ?
	db $07 ; ?
	db $00 ; ?

	db GO_ARCANINE_DECK_ID
	tx Text045e ; deck name
	tx Text04dc ; opponent name
	db $25 ; ?
	db $04 ; ?
	db NO_RULES ; special duel rules
	db $00 ; ?
	db $02 ; ?
	db $07 ; ?
	db $00 ; ?

	db FLAME_FESTIVAL_DECK_ID
	tx Text046f ; deck name
	tx Text0474 ; opponent name
	db $26 ; ?
	db $06 ; ?
	db NO_RULES ; special duel rules
	db $00 ; ?
	db $03 ; ?
	db $10 ; ?
	db $03 ; ?

	db IMMORTAL_FLAME_DECK_ID
	tx Text0465 ; deck name
	tx Text04a2 ; opponent name
	db $27 ; ?
	db $04 ; ?
	db NO_RULES ; special duel rules
	db $00 ; ?
	db $02 ; ?
	db $08 ; ?
	db $00 ; ?

	db ELECTRIC_CURRENT_SHOCK_DECK_ID
	tx Text0463 ; deck name
	tx Text04cd ; opponent name
	db $29 ; ?
	db $04 ; ?
	db NO_RULES ; special duel rules
	db $00 ; ?
	db $02 ; ?
	db $08 ; ?
	db $00 ; ?

	db GREAT_ROCKET4_DECK_ID
	tx Text0459 ; deck name
	tx Text04f5 ; opponent name
	db $28 ; ?
	db $04 ; ?
	db NO_RULES ; special duel rules
	db $00 ; ?
	db $02 ; ?
	db $08 ; ?
	db $00 ; ?

	db GREAT_ROCKET1_DECK_ID
	tx Text0490 ; deck name
	tx Text042a ; opponent name
	db $3e ; ?
	db $06 ; ?
	db NO_RULES ; special duel rules
	db $00 ; ?
	db $1f ; ?
	db $16 ; ?
	db $01 ; ?

	db GREAT_ROCKET2_DECK_ID
	tx Text048d ; deck name
	tx Text0427 ; opponent name
	db $3b ; ?
	db $06 ; ?
	db NO_RULES ; special duel rules
	db $00 ; ?
	db $1f ; ?
	db $16 ; ?
	db $01 ; ?

	db GREAT_ROCKET3_DECK_ID
	tx Text048e ; deck name
	tx Text0428 ; opponent name
	db $3c ; ?
	db $06 ; ?
	db NO_RULES ; special duel rules
	db $00 ; ?
	db $1f ; ?
	db $16 ; ?
	db $01 ; ?

	db GRAND_FIRE_DECK_ID
	tx Text048f ; deck name
	tx Text0429 ; opponent name
	db $3d ; ?
	db $06 ; ?
	db NO_RULES ; special duel rules
	db $00 ; ?
	db $1f ; ?
	db $16 ; ?
	db $01 ; ?

	db LEGENDARY_FOSSIL_DECK_ID
	tx Text048b ; deck name
	tx Text04be ; opponent name
	db $2a ; ?
	db $06 ; ?
	db NO_RULES ; special duel rules
	db $00 ; ?
	db $04 ; ?
	db $11 ; ?
	db $03 ; ?

	db WATER_LEGEND_DECK_ID
	tx Text0458 ; deck name
	tx Text049e ; opponent name
	db $2b ; ?
	db $06 ; ?
	db NO_RULES ; special duel rules
	db $00 ; ?
	db $04 ; ?
	db $11 ; ?
	db $05 ; ?

	db GREAT_DRAGON_DECK_ID
	tx Text047c ; deck name
	tx Text0482 ; opponent name
	db $2c ; ?
	db $06 ; ?
	db NO_RULES ; special duel rules
	db $00 ; ?
	db $04 ; ?
	db $11 ; ?
	db $04 ; ?

	db BUG_COLLECTING_DECK_ID
	tx Text0450 ; deck name
	tx Text04ed ; opponent name
	db $2d ; ?
	db $06 ; ?
	db NO_RULES ; special duel rules
	db $00 ; ?
	db $04 ; ?
	db $11 ; ?
	db $00 ; ?

	db DEMONIC_FOREST_DECK_ID
	tx Text0447 ; deck name
	tx Text04d8 ; opponent name
	db $3f ; ?
	db $04 ; ?
	db NO_RULES ; special duel rules
	db $00 ; ?
	db $1f ; ?
	db $17 ; ?
	db $01 ; ?

	db STICKY_POISON_GAS_DECK_ID
	tx Text042e ; deck name
	tx Text04e3 ; opponent name
	db $40 ; ?
	db $04 ; ?
	db NO_RULES ; special duel rules
	db $00 ; ?
	db $1f ; ?
	db $17 ; ?
	db $01 ; ?

	db MAD_PETALS_DECK_ID
	tx Text045c ; deck name
	tx Text04da ; opponent name
	db $41 ; ?
	db $04 ; ?
	db NO_RULES ; special duel rules
	db $01 ; ?
	db $1f ; ?
	db $17 ; ?
	db $01 ; ?

	db DANGEROUS_BENCH_DECK_ID
	tx Text0445 ; deck name
	tx Text04dd ; opponent name
	db $42 ; ?
	db $06 ; ?
	db $01 ; special duel rules
	db $00 ; ?
	db $20 ; ?
	db $1d ; ?
	db $08 ; ?

	db CHAIN_LIGHTNING_BY_PIKACHU_DECK_ID
	tx Text0441 ; deck name
	tx Text04a4 ; opponent name
	db $46 ; ?
	db $04 ; ?
	db NO_RULES ; special duel rules
	db $00 ; ?
	db $02 ; ?
	db $26 ; ?
	db $00 ; ?

	db THIS_IS_THE_POWER_OF_ELECTRICITY_DECK_ID
	tx Text04c5 ; deck name
	tx Text04f2 ; opponent name
	db $43 ; ?
	db $04 ; ?
	db NO_RULES ; special duel rules
	db $07 ; ?
	db $1f ; ?
	db $18 ; ?
	db $01 ; ?

	db QUICK_ATTACK_DECK_ID
	tx Text0456 ; deck name
	tx Text0479 ; opponent name
	db $44 ; ?
	db $04 ; ?
	db NO_RULES ; special duel rules
	db $02 ; ?
	db $1f ; ?
	db $18 ; ?
	db $01 ; ?

	db COMPLETE_COMBUSTION_DECK_ID
	tx Text0457 ; deck name
	tx Text0487 ; opponent name
	db $45 ; ?
	db $06 ; ?
	db $02 ; special duel rules
	db $00 ; ?
	db $20 ; ?
	db $1e ; ?
	db $09 ; ?

	db FIREBALL_DECK_ID
	tx Text043f ; deck name
	tx Text049b ; opponent name
	db $47 ; ?
	db $04 ; ?
	db NO_RULES ; special duel rules
	db $00 ; ?
	db $1f ; ?
	db $19 ; ?
	db $01 ; ?

	db EEVEE_SHOWDOWN_DECK_ID
	tx Text04c6 ; deck name
	tx Text04e2 ; opponent name
	db $48 ; ?
	db $04 ; ?
	db NO_RULES ; special duel rules
	db $03 ; ?
	db $1f ; ?
	db $19 ; ?
	db $01 ; ?

	db GAZE_UPON_THE_POWER_OF_FIRE_DECK_ID
	tx Text0477 ; deck name
	tx Text0499 ; opponent name
	db $49 ; ?
	db $04 ; ?
	db NO_RULES ; special duel rules
	db $08 ; ?
	db $1f ; ?
	db $19 ; ?
	db $01 ; ?

	db WHIRLPOOL_SHOWER_DECK_ID
	tx Text0468 ; deck name
	tx Text04bc ; opponent name
	db $4a ; ?
	db $06 ; ?
	db $03 ; special duel rules
	db $00 ; ?
	db $20 ; ?
	db $1f ; ?
	db $0a ; ?

	db PARALYZED_PARALYZED_DECK_ID
	tx Text0439 ; deck name
	tx Text04d9 ; opponent name
	db $4b ; ?
	db $04 ; ?
	db NO_RULES ; special duel rules
	db $04 ; ?
	db $1f ; ?
	db $1a ; ?
	db $01 ; ?

	db BENCH_CALL_DECK_ID
	tx Text04d1 ; deck name
	tx Text049f ; opponent name
	db $4c ; ?
	db $04 ; ?
	db NO_RULES ; special duel rules
	db $09 ; ?
	db $1f ; ?
	db $1a ; ?
	db $01 ; ?

	db WATER_STREAM_DECK_ID
	tx Text04c7 ; deck name
	tx Text0473 ; opponent name
	db $4d ; ?
	db $04 ; ?
	db $04 ; special duel rules
	db $00 ; ?
	db $1f ; ?
	db $1a ; ?
	db $01 ; ?

	db ROCK_BLAST_DECK_ID
	tx Text047b ; deck name
	tx Text0483 ; opponent name
	db $4e ; ?
	db $06 ; ?
	db $05 ; special duel rules
	db $00 ; ?
	db $20 ; ?
	db $20 ; ?
	db $0b ; ?

	db FULL_STRENGTH_DECK_ID
	tx Text04f4 ; deck name
	tx Text0494 ; opponent name
	db $4f ; ?
	db $04 ; ?
	db NO_RULES ; special duel rules
	db $0c ; ?
	db $1f ; ?
	db $1b ; ?
	db $01 ; ?

	db RUNNING_WILD_DECK_ID
	tx Text0451 ; deck name
	tx Text048c ; opponent name
	db $50 ; ?
	db $04 ; ?
	db NO_RULES ; special duel rules
	db $05 ; ?
	db $1f ; ?
	db $1b ; ?
	db $01 ; ?

	db DIRECT_HIT_DECK_ID
	tx Text0430 ; deck name
	tx Text0485 ; opponent name
	db $51 ; ?
	db $06 ; ?
	db $06 ; special duel rules
	db $00 ; ?
	db $20 ; ?
	db $21 ; ?
	db $0c ; ?

	db SUPERDESTRUCTIVE_POWER_DECK_ID
	tx Text0454 ; deck name
	tx Text04db ; opponent name
	db $52 ; ?
	db $04 ; ?
	db NO_RULES ; special duel rules
	db $06 ; ?
	db $1f ; ?
	db $1c ; ?
	db $01 ; ?

	db BAD_DREAM_DECK_ID
	tx Text0452 ; deck name
	tx Text0492 ; opponent name
	db $53 ; ?
	db $04 ; ?
	db $07 ; special duel rules
	db $00 ; ?
	db $1f ; ?
	db $1c ; ?
	db $01 ; ?

	db POKEMON_POWER_DECK_ID
	tx Text04ba ; deck name
	tx Text04e5 ; opponent name
	db $54 ; ?
	db $04 ; ?
	db NO_RULES ; special duel rules
	db $0a ; ?
	db $1f ; ?
	db $1c ; ?
	db $01 ; ?

	db SPIRITED_AWAY_DECK_ID
	tx Text04cb ; deck name
	tx Text04ee ; opponent name
	db $55 ; ?
	db $04 ; ?
	db NO_RULES ; special duel rules
	db $0d ; ?
	db $1f ; ?
	db $1c ; ?
	db $01 ; ?

	db SNORLAX_GUARD_DECK_ID
	tx Text043d ; deck name
	tx Text04d2 ; opponent name
	db $56 ; ?
	db $06 ; ?
	db $08 ; special duel rules
	db $00 ; ?
	db $20 ; ?
	db $22 ; ?
	db $0d ; ?

	db EYE_OF_THE_STORM_DECK_ID
	tx Text0484 ; deck name
	tx Text04b6 ; opponent name
	db $57 ; ?
	db $06 ; ?
	db NO_RULES ; special duel rules
	db $0e ; ?
	db $20 ; ?
	db $23 ; ?
	db $0e ; ?

	db SUDDEN_GROWTH_DECK_ID
	tx Text044c ; deck name
	tx Text0478 ; opponent name
	db $58 ; ?
	db $06 ; ?
	db NO_RULES ; special duel rules
	db $0f ; ?
	db $20 ; ?
	db $23 ; ?
	db $0e ; ?

	db VERY_RARE_CARD_DECK_ID
	tx Text0443 ; deck name
	tx Text0497 ; opponent name
	db $59 ; ?
	db $06 ; ?
	db NO_RULES ; special duel rules
	db $10 ; ?
	db $20 ; ?
	db $23 ; ?
	db $0e ; ?

	db BAD_GUYS_DECK_ID
	tx Text045a ; deck name
	tx Text042d ; opponent name
	db $07 ; ?
	db $06 ; ?
	db NO_RULES ; special duel rules
	db $00 ; ?
	db $23 ; ?
	db $14 ; ?
	db $13 ; ?

	db POISON_MIST_DECK_ID
	tx Text0472 ; deck name
	tx Text0486 ; opponent name
	db $5a ; ?
	db $06 ; ?
	db NO_RULES ; special duel rules
	db $0b ; ?
	db $20 ; ?
	db $24 ; ?
	db $11 ; ?

	db ULTRA_REMOVAL_DECK_ID
	tx Text04ca ; deck name
	tx Text04f0 ; opponent name
	db $5b ; ?
	db $06 ; ?
	db $09 ; special duel rules
	db $00 ; ?
	db $20 ; ?
	db $24 ; ?
	db $12 ; ?

	db PSYCHIC_BATTLE_DECK_ID
	tx Text047e ; deck name
	tx Text04f0 ; opponent name
	db $5b ; ?
	db $06 ; ?
	db $0a ; special duel rules
	db $00 ; ?
	db $20 ; ?
	db $24 ; ?
	db $13 ; ?

	db STOP_LIFE_DECK_ID
	tx Text0495 ; deck name
	tx Text04f0 ; opponent name
	db $5b ; ?
	db $06 ; ?
	db $07 ; special duel rules
	db $00 ; ?
	db $20 ; ?
	db $24 ; ?
	db $15 ; ?

	db SCORCHER_DECK_ID
	tx Text0437 ; deck name
	tx Text04c2 ; opponent name
	db $5c ; ?
	db $06 ; ?
	db NO_RULES ; special duel rules
	db $00 ; ?
	db $21 ; ?
	db $25 ; ?
	db $0f ; ?

	db TSUNAMI_STARTER_DECK_ID
	tx Text046d ; deck name
	tx Text04c2 ; opponent name
	db $5c ; ?
	db $06 ; ?
	db NO_RULES ; special duel rules
	db $00 ; ?
	db $21 ; ?
	db $25 ; ?
	db $0f ; ?

	db SMASH_TO_MINCEMEAT_DECK_ID
	tx Text044e ; deck name
	tx Text04c2 ; opponent name
	db $5c ; ?
	db $06 ; ?
	db NO_RULES ; special duel rules
	db $00 ; ?
	db $21 ; ?
	db $25 ; ?
	db $0f ; ?

	db TEST_YOUR_LUCK_DECK_ID
	tx Text0455 ; deck name
	tx Text04c2 ; opponent name
	db $5c ; ?
	db $06 ; ?
	db NO_RULES ; special duel rules
	db $00 ; ?
	db $21 ; ?
	db $25 ; ?
	db $0f ; ?

	db PROTOHISTORIC_DECK_ID
	tx Text043a ; deck name
	tx Text04c8 ; opponent name
	db $36 ; ?
	db $04 ; ?
	db NO_RULES ; special duel rules
	db $00 ; ?
	db $02 ; ?
	db $27 ; ?
	db $13 ; ?

	db TEXTURE_TUNER7_DECK_ID
	tx Text0446 ; deck name
	tx Text04b4 ; opponent name
	db $37 ; ?
	db $04 ; ?
	db NO_RULES ; special duel rules
	db $00 ; ?
	db $03 ; ?
	db $27 ; ?
	db $13 ; ?

	db COLORLESS_ENERGY_DECK_ID
	tx Text04a8 ; deck name
	tx Text04bf ; opponent name
	db $38 ; ?
	db $04 ; ?
	db NO_RULES ; special duel rules
	db $00 ; ?
	db $1f ; ?
	db $27 ; ?
	db $13 ; ?

	db POWERFUL_POKEMON_DECK_ID
	tx Text046b ; deck name
	tx Text04ef ; opponent name
	db $39 ; ?
	db $05 ; ?
	db NO_RULES ; special duel rules
	db $00 ; ?
	db $1f ; ?
	db $27 ; ?
	db $13 ; ?

	db WEIRD_DECK_ID
	tx Text0444 ; deck name
	tx Text0488 ; opponent name
	db $3a ; ?
	db $06 ; ?
	db NO_RULES ; special duel rules
	db $00 ; ?
	db $20 ; ?
	db $27 ; ?
	db $13 ; ?

	db STRANGE_DECK_ID
	tx Text0464 ; deck name
	tx Text047a ; opponent name
	db $08 ; ?
	db $06 ; ?
	db NO_RULES ; special duel rules
	db $00 ; ?
	db $10 ; ?
	db $13 ; ?
	db $0b ; ?

	db RONALDS_UNCOOL_DECK_ID
	tx Text0442 ; deck name
	tx Text047a ; opponent name
	db $09 ; ?
	db $06 ; ?
	db NO_RULES ; special duel rules
	db $00 ; ?
	db $24 ; ?
	db $13 ; ?
	db $13 ; ?

	db RONALDS_GRX_DECK_ID
	tx Text04e8 ; deck name
	tx Text04e6 ; opponent name
	db $04 ; ?
	db $06 ; ?
	db NO_RULES ; special duel rules
	db $00 ; ?
	db $0f ; ?
	db $15 ; ?
	db $16 ; ?

	db RONALDS_POWER_DECK_ID
	tx Text04e7 ; deck name
	tx Text042b ; opponent name
	db $5d ; ?
	db $06 ; ?
	db NO_RULES ; special duel rules
	db $00 ; ?
	db $0f ; ?
	db $16 ; ?
	db $16 ; ?

	db RONALDS_PSYCHIC_DECK_ID
	tx Text04eb ; deck name
	tx Text04e6 ; opponent name
	db $04 ; ?
	db $06 ; ?
	db NO_RULES ; special duel rules
	db $00 ; ?
	db $0f ; ?
	db $15 ; ?
	db $16 ; ?

	db RONALDS_ULTRA_DECK_ID
	tx Text04ea ; deck name
	tx Text04e6 ; opponent name
	db $04 ; ?
	db $06 ; ?
	db NO_RULES ; special duel rules
	db $00 ; ?
	db $0f ; ?
	db $15 ; ?
	db $16 ; ?

	db EVERYBODYS_FRIEND_DECK_ID
	tx Text04e9 ; deck name
	tx Text04e6 ; opponent name
	db $04 ; ?
	db $06 ; ?
	db NO_RULES ; special duel rules
	db $00 ; ?
	db $0f ; ?
	db $15 ; ?
	db $16 ; ?

	db IMMORTAL_POKEMON_DECK_ID
	tx Text0469 ; deck name
	tx Text047f ; opponent name
	db $2e ; ?
	db $06 ; ?
	db NO_RULES ; special duel rules
	db $00 ; ?
	db $20 ; ?
	db $28 ; ?
	db $17 ; ?

	db TORRENTIAL_FLOOD_DECK_ID
	tx Text0462 ; deck name
	tx Text04cf ; opponent name
	db $2f ; ?
	db $06 ; ?
	db NO_RULES ; special duel rules
	db $00 ; ?
	db $20 ; ?
	db $28 ; ?
	db $17 ; ?

	db TRAINER_IMPRISON_DECK_ID
	tx Text043b ; deck name
	tx Text04e1 ; opponent name
	db $30 ; ?
	db $06 ; ?
	db NO_RULES ; special duel rules
	db $00 ; ?
	db $20 ; ?
	db $28 ; ?
	db $17 ; ?

	db BLAZING_FLAME_DECK_ID
	tx Text04ae ; deck name
	tx Text04ab ; opponent name
	db $31 ; ?
	db $06 ; ?
	db NO_RULES ; special duel rules
	db $00 ; ?
	db $20 ; ?
	db $28 ; ?
	db $17 ; ?

	db DAMAGE_CHAOS_DECK_ID
	tx Text046c ; deck name
	tx Text04c3 ; opponent name
	db $32 ; ?
	db $06 ; ?
	db NO_RULES ; special duel rules
	db $00 ; ?
	db $20 ; ?
	db $28 ; ?
	db $17 ; ?

	db BIG_THUNDER_DECK_ID
	tx Text04a7 ; deck name
	tx Text0476 ; opponent name
	db $33 ; ?
	db $06 ; ?
	db NO_RULES ; special duel rules
	db $00 ; ?
	db $20 ; ?
	db $28 ; ?
	db $17 ; ?

	db POWER_OF_DARKNESS_DECK_ID
	tx Text04c0 ; deck name
	tx Text04a9 ; opponent name
	db $34 ; ?
	db $06 ; ?
	db NO_RULES ; special duel rules
	db $00 ; ?
	db $20 ; ?
	db $28 ; ?
	db $17 ; ?

	db POISON_STORM_DECK_ID
	tx Text0436 ; deck name
	tx Text04d0 ; opponent name
	db $35 ; ?
	db $06 ; ?
	db NO_RULES ; special duel rules
	db $00 ; ?
	db $20 ; ?
	db $28 ; ?
	db $17 ; ?

	db DECK_7269_ID
	tx Text04c9 ; deck name
	tx Text04ac ; opponent name
	db $5e ; ?
	db $06 ; ?
	db NO_RULES ; special duel rules
	db $00 ; ?
	db $20 ; ?
	db $28 ; ?
	db $17 ; ?

	db $ff ; end
