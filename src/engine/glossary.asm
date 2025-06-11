Glossary:
	xor a
	ld [wd0d2], a
	bank1call SetDefaultPalettes
	lb de, $38, $9f
	call SetupText
	jr .asm_186ba
	ld a, $01
	ld [wd0d2], a

.asm_186ba
	xor a
.main_menu
	ld hl, .MainMenuParameters
	call InitializeMenuParameters
	xor a
	ld [wTileMapFill], a
	call ZeroObjectPositions
	ld a, $01
	ld [wVBlankOAMCopyToggle], a
	call DoFrame
	call EmptyScreen
	farcall LoadMenuCursorTile
	ld hl, .MainMenuItems
	call PlaceTextItems
	ldtx hl, Text03d0
	call DrawWideTextBox_PrintText
.loop_input
	call DoFrame
	call HandleMenuInput
	jr nc, .loop_input
	cp -1
	ret z ; return

	; selection was made
	call EraseCursor
	ldh a, [hCurScrollMenuItem]
	ld [wGlossaryMenu], a
	cp GLOSSARY_EXIT
	ret z ; exit Glossary

	call .ShowMenuContent
	ld a, [wGlossaryMenu]
	cp GLOSSARY_STATUS_WINNING_LOSING
	jr nz, .has_10_topics
; GLOSSARY_STATUS_WINNING_LOSING
	xor a
	ld de, GlossaryTransitionTable_8Topics
	jr .got_transition_table
.has_10_topics
	cp GLOSSARY_SPECIAL_DUEL_RULES
	jr nz, .not_special_duel_rules
; GLOSSARY_SPECIAL_DUEL_RULES
	ld a, [wSpecialRule]
	or a
	jr z, .asm_18714
	dec a
.asm_18714
	ld de, GlossaryTransitionTable_10Topics
	jr .got_transition_table
.not_special_duel_rules
	xor a
	ld de, GlossaryTransitionTable_10Topics
.got_transition_table
	ld [wd0c1], a
	ld hl, wTransitionTablePtr
	ld [hl], e
	inc hl
	ld [hl], d
	ld a, $ff
	ld [wd0c4], a

	xor a
	ld [wScrollMenuCursorBlinkCounter], a
.topic_menu
	ld a, $01
	ld [wVBlankOAMCopyToggle], a
	call DoFrame
	ld a, [wd0d2]
	or a
	call nz, .Func_18763
	farcall HandleMultiDirectionalMenu
	jr nc, .topic_menu
	cp $ff
	jr nz, .selected_topic
	farcall ZeroObjectPositionsWithCopyToggleOn
	ldh a, [hCurScrollMenuItem]
	jp .main_menu

.selected_topic
	push af
	farcall ZeroObjectPositionsWithCopyToggleOn
	pop af
	call .ShowExplanation
	call .ShowMenuContent
	xor a
	ld [wScrollMenuCursorBlinkCounter], a
	jr .topic_menu

.Func_18763:
	ld a, [wGlossaryMenu]
	cp GLOSSARY_SPECIAL_DUEL_RULES
	ret nz ; not in special duel rules menu
	ld a, [wSpecialRule]
	or a
	ret z ; no special rules
	dec a
	sla a
	ld c, a
	ld hl, wScrollMenuCursorBlinkCounter
	ld a, [hl]
	and $0f
	ret nz
	ldfw de, "★"
	bit 4, [hl]
	jr z, .got_tile
	ldfw de, " "
.got_tile
	ld b, $00
	ld hl, .rule_coords
	add hl, bc
	push de
	ld e, [hl]
	inc hl
	ld d, [hl]
	call InitTextPrinting
	pop de
	call Func_22ca
	ret

.rule_coords
	; x, y
	db  3,  8 ; CHLOROPHYLL
	db  5,  8 ; THUNDER_CHARGE
	db  7,  8 ; FLAME_ARMOR
	db  9,  7 ; SMALL_BENCH
	db 11,  7 ; RUNNING_WATER
	db  3, 18 ; EARTH_POWER
	db  5, 17 ; LOW_RESISTANCE
	db  7, 17 ; ENERGY_RETURN
	db  9, 17 ; TOUGH_ESCAPE
	db 11, 18 ; BLACK_HOLE

.MainMenuParameters:
	db 1, 3 ; cursor x, cursor y
	db 2 ; y displacement between items
	db 5 ; number of items
	db SYM_CURSOR_R ; cursor tile number
	db SYM_SPACE ; tile behind cursor
	dw NULL ; function pointer if non-0

.MainMenuItems:
	textitem 2,  1, Text03c6
	textitem 3,  3, Text03c7
	textitem 3,  5, Text03c8
	textitem 3,  7, Text03c9
	textitem 3,  9, Text03ca
	textitem 3, 11, Text03cb
	db $ff

; shows which topics are inside this Glossary menu
; each menu has a text ID for title and for the items
.ShowMenuContent:
	xor a
	ld [wTileMapFill], a
	call EmptyScreen
	ld a, [wGlossaryMenu]
	or a
	jr nz, .asm_187df
; GLOSSARY_GAME_BASICS
	ldtx hl, Text03c7
	ldtx de, Text03cc
	jr .got_title_and_topics
.asm_187df
	cp GLOSSARY_CARD_TYPE_EXPLANATIONS
	jr nz, .asm_187eb
; GLOSSARY_CARD_TYPE_EXPLANATIONS
	ldtx hl, Text03c8
	ldtx de, Text03cd
	jr .got_title_and_topics
.asm_187eb
	cp GLOSSARY_STATUS_WINNING_LOSING
	jr nz, .asm_187f7
; GLOSSARY_STATUS_WINNING_LOSING
	ldtx hl, Text03c9
	ldtx de, Text03ce
	jr .got_title_and_topics
.asm_187f7
; GLOSSARY_SPECIAL_DUEL_RULES
	lb de, 6, 1
	call InitTextPrinting
	ldtx hl, Text03ca
	ldtx de, Text03cf
	push de
	jr .skip_init_text

; hl = title
; de = topics
.got_title_and_topics
	push de
	push hl
	lb de, 3, 1
	call InitTextPrinting
	pop hl
.skip_init_text
	call ProcessTextFromID
	lb de, 1, 3
	call InitTextPrinting
	pop hl
	call ProcessTextFromID
	ldtx hl, Text03d0
	call DrawWideTextBox_PrintText
	ret

; shows a big box with the explanation of the
; selected topic, each topic has data
; related to the x position of the topic title text
; and the text IDs of the information shown
; waits for the player to press the B button
.ShowExplanation:
	push af
	xor a
	ld [wTileMapFill], a
	call EmptyScreen
	lb de, 0, 4
	lb bc, 20, 14
	call DrawRegularTextBox

	ld a, [wGlossaryMenu]
	or a
	jr nz, .asm_18847
; GLOSSARY_GAME_BASICS
	ld hl, .ExplanationTextData_GameBasics
	push hl
	ldtx hl, Text03d1
	push hl
	lb de, 2, 0
	jr .got_explanation_data

.asm_18847
	cp GLOSSARY_CARD_TYPE_EXPLANATIONS
	jr nz, .asm_18858
; GLOSSARY_CARD_TYPE_EXPLANATIONS
	ld hl, .ExplanationTextData_CardTypes
	push hl
	ldtx hl, Text03d2
	push hl
	lb de, 2, 0
	jr .got_explanation_data

.asm_18858
	cp GLOSSARY_STATUS_WINNING_LOSING
	jr nz, .asm_18869
; GLOSSARY_STATUS_WINNING_LOSING
	ld hl, .ExplanationTextData_StatusWinningLosing
	push hl
	ldtx hl, Text03d3
	push hl
	lb de, 2, 0
	jr .got_explanation_data

.asm_18869
; GLOSSARY_SPECIAL_DUEL_RULES
	ld hl, .ExplanationTextData_SpecialDuelRules
	push hl
	ldtx hl, Text03d4
	push hl
	lb de, 5, 0
.got_explanation_data
	call InitTextPrinting
	pop hl
	call ProcessTextFromID
	pop hl
	pop af
	ld c, a
	ld b, $00
	add hl, bc
	sla a
	sla a ; *4
	ld c, a
	add hl, bc

	; topic title
	ld a, [hli]
	push hl
	ld d, a ; x
	ld e, 2
	call InitTextPrinting
	ld a, [hli]
	ld h, [hl]
	ld l, a
	call ProcessTextFromID
	pop hl

	; topic explanation
	lb de, 1, 5
	call InitTextPrinting
	inc hl
	inc hl
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, SINGLE_SPACED
	ld [wLineSeparation], a
	call ProcessTextFromID
	xor a ; DOUBLE_SPACED
	ld [wLineSeparation], a
	call EnableLCD
.loop_wait_b_btn
	call DoFrame
	ldh a, [hKeysPressed]
	and B_BUTTON
	jr z, .loop_wait_b_btn
	ld a, $ff
	farcall PlayAcceptOrDeclineSFX
	ret

MACRO explanation
	db \1 ; title x position
	tx \2 ; title text ID
	tx \3 ; explanation text ID
ENDM

.ExplanationTextData_GameBasics:
	explanation 5, Text03d5, Text03fb
	explanation 6, Text03d6, Text03fc
	explanation 4, Text03d7, Text03fd
	explanation 6, Text03d8, Text03fe
	explanation 5, Text03d9, Text03ff
	explanation 5, Text03da, Text0400
	explanation 4, Text03db, Text0401
	explanation 3, Text03dc, Text0402
	explanation 4, Text03dd, Text0403
	explanation 2, Text03de, Text0404

.ExplanationTextData_CardTypes:
	explanation 3, Text03df, Text0405
	explanation 3, Text03e0, Text0406
	explanation 4, Text03e1, Text0407
	explanation 4, Text03e2, Text0408
	explanation 3, Text03e3, Text0409
	explanation 6, Text03e4, Text040a
	explanation 5, Text03e5, Text040b
	explanation 6, Text03e6, Text040c
	explanation 5, Text03e7, Text040d
	explanation 5, Text03e8, Text040e

.ExplanationTextData_StatusWinningLosing:
	explanation 5, Text03e9, Text040f
	explanation 5, Text03ea, Text0410
	explanation 4, Text03eb, Text0411
	explanation 4, Text03ec, Text0412
	explanation 3, Text03ed, Text0413
	explanation 3, Text03ee, Text0414
	explanation 3, Text03ef, Text0415
	explanation 4, Text03f0, Text0416

.ExplanationTextData_SpecialDuelRules:
	explanation 3, Text03f1, Text0417
	explanation 3, Text03f2, Text0418
	explanation 3, Text03f3, Text0419
	explanation 4, Text03f4, Text041a
	explanation 4, Text03f5, Text041b
	explanation 3, Text03f6, Text041c
	explanation 4, Text03f7, Text041d
	explanation 4, Text03f8, Text041e
	explanation 4, Text03f9, Text041f
	explanation 3, Text03fa, Text0420
