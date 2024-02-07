SECTION "Bank 1@4278", ROMX[$4278], BANK[$1]

Func_4278:
	xor a
	ld [wTileMapFill], a
	call ZeroObjectPositionsAndToggleOAMCopy
	call EmptyScreen
	call LoadSymbolsFont
	call SetDefaultPalettes
	lb de, $38, $9f
	call SetupText
	call EnableLCD
	ret
; 0x4292

SECTION "Bank 1@4cd7", ROMX[$4cd7], BANK[$1]

DrawDuelMainScene:
	ld a, [wDuelType]
	cp $00
	jr nz, .asm_4ced
	ldh a, [hWhoseTurn]
	push af
	ld a, [wcbfd]
	ldh [hWhoseTurn], a
	call .Draw
	pop af
	ldh [hWhoseTurn], a
	ret

.asm_4ced
	ldh a, [hWhoseTurn]
	push af
	ld a, PLAYER_TURN
	ldh [hWhoseTurn], a
	call .Draw
	pop af
	ldh [hWhoseTurn], a
	ret

.Draw:
	ld a, [wDuelDisplayedScreen]
	cp $01
	ret z
	call ZeroObjectPositionsAndToggleOAMCopy
	call EmptyScreen
	call LoadSymbolsFont
	ld a, $01
	ld [wDuelDisplayedScreen], a

	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	cp $ff
	jr z, .turn_duelist_no_arena
	ld de, v0Tiles1 + $50 tiles
	call LoadCardGfxFromDeckIndex
	lb de, 0, 5
	call DrawCardGfxToDE_BGPalIndex2
.turn_duelist_no_arena
	call SwapTurn
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	cp $ff
	jr z, .non_turn_duelist_no_arena
	ld de, v0Tiles1 + $20 tiles
	call LoadCardGfxFromDeckIndex
	lb de, 12, 1
	call DrawCardGfxToDE_BGPalIndex5
	call FlushAllPalettesIfNotDMG
.non_turn_duelist_no_arena
	call SwapTurn
; next, draw the Pokemon in the arena
;.place_player_arena_pkmn
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	cp $ff
	jr z, .place_opponent_arena_pkmn
	ld a, $d0 ; v0Tiles1 + $50 tiles
	lb hl, 6, 1
	lb de, 0, 5
	lb bc, 8, 6
	call FillRectangle
.place_opponent_arena_pkmn
	call SwapTurn
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	cp $ff
	jr z, .place_other_elements
	ld a, $a0 ; v0Tiles1 + $20 tiles
	lb hl, 6, 1
	lb de, 12, 1
	lb bc, 8, 6
	call FillRectangle
.place_other_elements
	call SwapTurn
	ld hl, DuelEAndHPTileData
	call WriteDataBlocksToBGMap0
	farcall DrawDuelHorizontalSeparator
	call DrawDuelHUDs
	call DrawWideTextBox
	call EnableLCD
	ret

DrawDuelHUDs:
	ld a, [wDuelDisplayedScreen]
	cp $01
	ret nz
	ld e, PLAYER_TURN
	ld a, [wDuelType]
	cp $00
	jr nz, .asm_4d95
	ld a, [wcbfd]
	ld e, a
.asm_4d95
	ldh a, [hWhoseTurn]
	push af
	ld a, e
	ldh [hWhoseTurn], a
	lb de, 1, 11 ; coordinates for player's arena card name and info icons
	lb bc, 11, 8 ; coordinates for player's attached energies and HP bar
	call DrawDuelHUD
	lb bc, 8, 5
	ld a, DUELVARS_ARENA_CARD_STATUS
	get_turn_duelist_var
	call CheckPrintCnfSlpPrz
	inc c
	call CheckPrintPoisoned
	inc c
	call CheckPrintDoublePoisoned ; if double poisoned, print a second poison icon
	inc c
	ld a, 1
	call CheckPrintFoodCounters

	call SwapTurn
	lb de, 7, 0 ; coordinates for opponent's arena card name and info icons
	lb bc, 3, 1 ; coordinates for opponent's attached energies and HP bar
	call GetNonTurnDuelistVariable
	call DrawDuelHUD
	lb bc, 11, 6
	ld a, DUELVARS_ARENA_CARD_STATUS
	get_turn_duelist_var
	call CheckPrintCnfSlpPrz
	dec c
	call CheckPrintPoisoned
	dec c
	call CheckPrintDoublePoisoned ; if double poisoned, print a second poison icon
	dec c
	ld a, -1
	call CheckPrintFoodCounters
	pop af
	ldh [hWhoseTurn], a
	ret

DuelEAndHPTileData:
; x, y, tiles[], 0
	db 1, 1, SYM_E,  0
	db 1, 2, SYM_HP, 0
	db 9, 8, SYM_E,  0
	db 9, 9, SYM_HP, 0
	db $ff ; end

DrawDuelHUD:
	ld hl, wHUDEnergyAndHPBarsX
	ld [hl], b
	inc hl
	ld [hl], c ; wHUDEnergyAndHPBarsY
	push de
	ld d, 1 ; x
	ld a, e
	or a
	jr z, .asm_4e05
	ld d, 15 ; x
.asm_4e05
	push de
	pop bc

	; number of Bench Pokemon
	ld a, SYM_POKEMON
	call WriteByteToBGMap0
	inc b
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	add SYM_0 - 1
	call WriteByteToBGMap0
	inc b

	; number of prize cards
	ld a, SYM_PRIZE
	call WriteByteToBGMap0
	inc b
	call CountPrizes
	add SYM_0
	call WriteByteToBGMap0
	pop de

	; Arena card names
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	cp $ff
	ret z ; no arena card
	call LoadCardDataToBuffer1_FromDeckIndex
	push de
	ld a, 32
	call CopyCardNameAndLevel
	ld [hl], TX_END

	; print the arena Pokemon card color symbol just before the name
	pop de
	ld a, e
	or a
	jr nz, .print_color_icon
	ld hl, wDefaultText
	call GetTextLengthInTiles
	add SCREEN_WIDTH
	ld d, a
.print_color_icon
	call InitTextPrinting
	ld hl, wDefaultText
	call ProcessText
	push de
	pop bc
	call GetArenaCardColor
	inc a ; TX_SYMBOL color tiles start at 1
	dec b ; place the color symbol one tile to the left of the start of the card's name
	call JPWriteByteToBGMap0

	; print attached energies
	ld hl, wHUDEnergyAndHPBarsX
	ld b, [hl]
	inc hl
	ld c, [hl] ; wHUDEnergyAndHPBarsY
	lb de, 9, PLAY_AREA_ARENA
	call PrintPlayAreaCardAttachedEnergies

	; print HP bar
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call LoadCardDataToBuffer1_FromDeckIndex
	ld a, [wLoadedCard1HP]
	ld d, a ; max HP
	ld a, DUELVARS_ARENA_CARD_HP
	get_turn_duelist_var
	ld e, a ; cur HP
	call DrawHPBar
	ld hl, wHUDEnergyAndHPBarsX
	ld b, [hl]
	inc hl
	ld c, [hl] ; wHUDEnergyAndHPBarsY
	inc c ; [wHUDEnergyAndHPBarsY] + 1
	call BCCoordToBGMap0Address
	push de
	ld hl, wDefaultText
	ld b, HP_BAR_LENGTH / 2 ; first row of the HP bar
	call SafeCopyDataHLtoDE
	pop de
	ld hl, BG_MAP_WIDTH
	add hl, de
	ld e, l
	ld d, h
	ld hl, wDefaultText + HP_BAR_LENGTH / 2
	ld b, HP_BAR_LENGTH / 2 ; second row of the HP bar
	call SafeCopyDataHLtoDE

	; print number of attached Pluspower and Defender with respective icon, if any
	ld hl, wHUDEnergyAndHPBarsX
	ld a, [hli]
	add 6
	ld b, a
	ld c, [hl] ; wHUDEnergyAndHPBarsY
	inc c
	ld a, DUELVARS_ARENA_CARD_ATTACHED_PLUSPOWER
	get_turn_duelist_var
	or a
	jr z, .check_defender
	ld a, SYM_PLUSPOWER
	call WriteByteToBGMap0
	inc b
	ld a, [hl] ; number of attached Pluspower
	add SYM_0
	call WriteByteToBGMap0
	dec b
.check_defender
	ld a, DUELVARS_ARENA_CARD_ATTACHED_DEFENDER
	get_turn_duelist_var
	or a
	jr z, .done
	inc c
	ld a, SYM_DEFENDER
	call WriteByteToBGMap0
	inc b
	ld a, [hl] ; number of attached Defender
	add SYM_0
	call WriteByteToBGMap0
.done
	ret
; 0x4ec6

SECTION "Bank 1@53e9", ROMX[$53e9], BANK[$1]

; draw the card page of the card at wLoadedCard1 and listen for input
; in order to switch the page or to exit.
; triggered by checking a hand card or a discard pile card in the Check menu.
; D_UP and D_DOWN exit the card page allowing the caller to load the card page
; of the card above or below in the list.
OpenCardPage_FromCheckHandOrDiscardPile:
	ld a, B_BUTTON | D_UP | D_DOWN
	ld [wCardPageExitKeys], a
	xor a ; CARDPAGETYPE_NOT_PLAY_AREA
	jr OpenCardPage

; draw the card page of the card at wLoadedCard1 and listen for input
; in order to switch the page or to exit.
; triggered by checking an arena card or a bench card in the Check menu.
OpenCardPage_FromCheckPlayArea:
	ld a, B_BUTTON
	ld [wCardPageExitKeys], a
	ld a, CARDPAGETYPE_PLAY_AREA
	jr OpenCardPage

; draw the card page of the card at wLoadedCard1 and listen for input
; in order to switch the page or to exit.
; triggered by checking a card in the Hand menu.
OpenCardPage_FromHand:
	ld a, B_BUTTON
	ld [wCardPageExitKeys], a
	xor a ; CARDPAGETYPE_NOT_PLAY_AREA
;	fallthrough

; draw the card page of the card at wLoadedCard1 and listen for input
; in order to switch the page or to exit.
OpenCardPage:
	ld [wCardPageType], a
	call ZeroObjectPositionsAndToggleOAMCopy
	call EmptyScreen
	call FinishQueuedAnimations
	; load the graphics and display the card image of wLoadedCard1
	call LoadDuelCardSymbolTiles
	ld de, v0Tiles1 + $200
	call LoadLoadedCard1Gfx
	lb de, 6, 4
	call DrawCardGfxToDE_BGPalIndex5
	call Func_6c12
	call FlushAllPalettesIfNotDMG
	; display the initial card page for the card at wLoadedCard1
	xor a
	ld [wCardPageNumber], a

.load_next
	call DisplayFirstOrNextCardPage
	jr c, .done ; done if trying to advance past the last page with START or A_BUTTON

.loop_input
	call DoFrame
	ldh a, [hDPadHeld]
	ld b, a
	ld a, [wCardPageExitKeys]
	and b
	jr nz, .done
	; START and A_BUTTON advance to the next valid card page, but close it
	; after trying to advance from the last page
	ldh a, [hKeysPressed]
	and A_BUTTON | START
	jr nz, .load_next
	; D_RIGHT and D_LEFT advance to the next and previous valid card page respectively.
	; however, unlike START and A_BUTTON, D_RIGHT past the last page goes back to the start.
	ldh a, [hKeysPressed]
	and D_RIGHT | D_LEFT
	jr z, .loop_input
	call .LeftOrRightPressed
	jr .loop_input
.done
	ret

.LeftOrRightPressed:
	bit D_LEFT_F, a
	jr nz, .d_left
; d_right
	call DisplayFirstOrNextCardPage
	call c, DisplayCardPage
	ret
.d_left
	call DisplayPreviousCardPage
	call c, DisplayCardPage
	ret

DrawCardPageCardGfx:
	ld de, v0Tiles1 + $20 tiles
	call LoadLoadedCard1Gfx
	ld a, $a0
	lb hl, 6, 1
	lb de, 6, 4
	lb bc, 8, 6
	call FillRectangle
	lb de, 6, 4
	call DrawCardGfxToDE_BGPalIndex5
	ret
; 0x5475

SECTION "Bank 1@553d", ROMX[$553d], BANK[$1]

; display the previous valid card page
DisplayPreviousCardPage:
	call GoToPreviousCardPage
	jr nc, DisplayCardPage
	ret

; display the next valid card page or load the first valid card page if [wCardPageNumber] == 0
DisplayFirstOrNextCardPage:
	call GoToFirstOrNextCardPage
	ret c
;	fallthrough

; display the card page with id at wCardPageNumber of wLoadedCard1
DisplayCardPage:
	ld a, [wCardPageNumber]
	ld hl, CardPageDisplayPointerTable
	call JumpToFunctionInTable
	call EnableLCD
	or a
	ret
; 0x5555

SECTION "Bank 1@5570", ROMX[$5570], BANK[$1]

CardPageDisplayPointerTable:
	dw DrawDuelMainScene ; $0
	dw DisplayCardPage_PokemonOverview ; CARDPAGE_POKEMON_OVERVIEW
	dw DisplayCardPage_PokemonAttack1Page1 ; CARDPAGE_POKEMON_ATTACK1_1
	dw DisplayCardPage_PokemonAttack1Page2 ; CARDPAGE_POKEMON_ATTACK1_2
	dw DisplayCardPage_PokemonAttack2Page1 ; CARDPAGE_POKEMON_ATTACK2_1
	dw DisplayCardPage_PokemonAttack2Page2 ; CARDPAGE_POKEMON_ATTACK2_2
	dw DisplayCardPage_PokemonDescription ; CARDPAGE_POKEMON_DESCRIPTION
	dw DrawDuelMainScene ; $7
	dw DrawDuelMainScene ; $8
	dw DisplayCardPage_Energy1 ; CARDPAGE_ENERGY_1
	dw DisplayCardPage_Energy2 ; CARDPAGE_ENERGY_2
	dw DrawDuelMainScene ; $b
	dw DrawDuelMainScene ; $c
	dw DisplayCardPage_TrainerPage1 ; CARDPAGE_TRAINER_1
	dw DisplayCardPage_TrainerPage2 ; CARDPAGE_TRAINER_2
	dw DrawDuelMainScene ; $f

; given the current card page at [wCardPageNumber], go to the next valid card page or load
; the first valid card page of the current card at wLoadedCard1 if [wCardPageNumber] == 0
GoToFirstOrNextCardPage:
	ld a, [wCardPageNumber]
	or a
	jr nz, .advance_page
	; load the first page for this type of card
	ld a, [wLoadedCard1Type]
	ld b, a
	ld a, CARDPAGE_ENERGY_1
	bit TYPE_ENERGY_F, b
	jr nz, .set_initial_page
	ld a, CARDPAGE_TRAINER_1
	bit TYPE_TRAINER_F, b
	jr nz, .set_initial_page
	ld a, CARDPAGE_POKEMON_OVERVIEW
.set_initial_page
	ld [wCardPageNumber], a
	or a
	ret

.advance_page
	ld hl, wCardPageNumber
	inc [hl]
	ld a, [hl]
	call SwitchCardPage
	jr c, .set_card_page
	; stay in this page if it exists, or skip to previous page if it doesn't
	or a
	ret nz
	; non-existent page: skip to next
	jr .advance_page
.set_card_page
	ld [wCardPageNumber], a
	ret

; given the current card page at [wCardPageNumber], go to the previous
; valid card page for the current card at wLoadedCard1
GoToPreviousCardPage:
	ld hl, wCardPageNumber
	dec [hl]
	ld a, [hl]
	call SwitchCardPage
	jr c, .set_card_page
	; stay in this page if it exists, or skip to previous page if it doesn't
	or a
	ret nz
	; non-existent page: skip to previous
	jr GoToPreviousCardPage
.set_card_page
	ld [wCardPageNumber], a
.previous_page_loop
	call SwitchCardPage
	or a
	jr nz, .stay
	ld hl, wCardPageNumber
	dec [hl]
	jr .previous_page_loop
.stay
	scf
	ret

; check if the card page trying to switch to is valid for the card at wLoadedCard1
; return with the equivalent to one of these three actions:
   ; stay in card page trying to switch to (nc, nz)
   ; change to card page returned in a if D_LEFT/D_RIGHT pressed, or exit if A_BUTTON/START pressed (c)
   ; non-existent page, so skip to next/previous (nc, z)
SwitchCardPage:
	ld hl, .CardPageSwitchPointerTable
	jp JumpToFunctionInTable

.CardPageSwitchPointerTable:
	dw CardPageSwitch_00
	dw CardPageSwitch_PokemonOverviewOrDescription ; CARDPAGE_POKEMON_OVERVIEW
	dw CardPageSwitch_PokemonAttack1Page1 ; CARDPAGE_POKEMON_ATTACK1_1
	dw CardPageSwitch_PokemonAttack1Page2 ; CARDPAGE_POKEMON_ATTACK1_2
	dw CardPageSwitch_PokemonAttack2Page1 ; CARDPAGE_POKEMON_ATTACK2_1
	dw CardPageSwitch_PokemonAttack2Page2 ; CARDPAGE_POKEMON_ATTACK2_2
	dw CardPageSwitch_PokemonOverviewOrDescription ; CARDPAGE_POKEMON_DESCRIPTION
	dw CardPageSwitch_PokemonEnd
	dw CardPageSwitch_08
	dw CardPageSwitch_EnergyOrTrainerPage1 ; CARDPAGE_ENERGY_1
	dw CardPageSwitch_TrainerPage2 ; CARDPAGE_ENERGY_1 + 1
	dw CardPageSwitch_EnergyEnd
	dw CardPageSwitch_0c
	dw CardPageSwitch_EnergyOrTrainerPage1 ; CARDPAGE_TRAINER_1
	dw CardPageSwitch_TrainerPage2 ; CARDPAGE_TRAINER_2
	dw CardPageSwitch_TrainerEnd

; return with CARDPAGE_POKEMON_DESCRIPTION
CardPageSwitch_00:
	ld a, CARDPAGE_POKEMON_DESCRIPTION
	scf
	ret

; return with current page
CardPageSwitch_PokemonOverviewOrDescription:
	ld a, $1
	or a
	ret ; nz

; return with current page if [wLoadedCard1Atk1Name] non-0
; (if card has at least one attack)
CardPageSwitch_PokemonAttack1Page1:
	ld hl, wLoadedCard1Atk1Name
	jr CheckCardPageExists

; return with current page if [wLoadedCard1Atk1Description + 2] non-0
; (if card's first attack has a two-page description)
CardPageSwitch_PokemonAttack1Page2:
	ld hl, wLoadedCard1Atk1Description + 2
	jr CheckCardPageExists

; return with current page if [wLoadedCard1Atk2Name] non-0
; (if card has two attacks)
CardPageSwitch_PokemonAttack2Page1:
	ld hl, wLoadedCard1Atk2Name
	jr CheckCardPageExists

; return with current page if [wLoadedCard1Atk1Description + 2] non-0
; (if card's second attack has a two-page description)
CardPageSwitch_PokemonAttack2Page2:
	ld hl, wLoadedCard1Atk2Description + 2
;	fallthrough

CheckCardPageExists:
	ld a, [hli]
	or [hl]
	ret

; return with CARDPAGE_POKEMON_OVERVIEW
CardPageSwitch_PokemonEnd:
	ld a, CARDPAGE_POKEMON_OVERVIEW
	scf
	ret

; return with CARDPAGE_ENERGY_1 + 1
CardPageSwitch_08:
	ld a, CARDPAGE_ENERGY_1 + 1
	scf
	ret

; return with current page
CardPageSwitch_EnergyOrTrainerPage1:
	ld a, $1
	or a
	ret ; nz

; return with current page if [wLoadedCard1NonPokemonDescription + 2] non-0
; (if this trainer card has a two-page description)
CardPageSwitch_TrainerPage2:
	ld hl, wLoadedCard1NonPokemonDescription + 2
	jr CheckCardPageExists

; return with CARDPAGE_ENERGY_1
CardPageSwitch_EnergyEnd:
	ld a, CARDPAGE_ENERGY_1
	scf
	ret

; return with CARDPAGE_TRAINER_2
CardPageSwitch_0c:
	ld a, CARDPAGE_TRAINER_2
	scf
	ret

; return with CARDPAGE_TRAINER_1
CardPageSwitch_TrainerEnd:
	ld a, CARDPAGE_TRAINER_1
	scf
	ret

ZeroObjectPositionsAndToggleOAMCopy:
	call ZeroObjectPositions
	ld a, $01
	ld [wVBlankOAMCopyToggle], a
	ret

SECTION "Bank 1@5670", ROMX[$5670], BANK[$1]

LoadCardGfxFromDeckIndex:
	push de
	call LoadCardDataToBuffer1_FromDeckIndex
	pop de
;	fallthrough

LoadLoadedCard1Gfx:
	ld hl, wLoadedCard1Gfx
	ld a, [hli]
	ld h, [hl]
	ld l, a
	lb bc, $30, TILE_SIZE
	call LoadCardGfx
	ret

; applies the tilemap of the loaded card gfx
; to coordinates in de, and loads its palette
; starting from BG pal 2
DrawCardGfxToDE_BGPalIndex2:
	ld a, [wConsole]
	or a
	ret z
	ld a, $02
	call LoadCardPalettesAndAttributes
	ret

; applies the tilemap of the loaded card gfx
; to coordinates in de, and loads its palette
; starting from BG pal 5
DrawCardGfxToDE_BGPalIndex5:
	ld a, [wConsole]
	or a
	ret z
	ld a, $5
	call LoadCardPalettesAndAttributes
	ret
; 0x5698

SECTION "Bank 1@56a6", ROMX[$56a6], BANK[$1]

; de = coordinates
LoadCardPalettesAndAttributes:
	push de
	call .CopyCardPals
	pop bc

	; copy attributes
	push hl
	call BCCoordToBGMap0Address
	pop hl
	call BankswitchVRAM1
	ld c, $06
.loop_copy_attr
	ld b, $08
	push de
	call SafeCopyDataHLtoDE
	pop de
	ld a, e
	add BG_MAP_WIDTH
	ld e, a
	ld a, $00
	adc d
	ld d, a
	dec c
	jr nz, .loop_copy_attr
	call BankswitchVRAM0
	ret

; a = starting BG palette index to copy to
.CopyCardPals:
	ld c, a
	add a
	add a
	add a ; *8
	ld e, a
	ld d, $00
	ld hl, wBackgroundPalettesCGB
	add hl, de
	ld de, wCardPalettes
	ld b, 3 palettes
.loop_copy_pal
	ld a, [de]
	inc de
	ld [hli], a
	dec b
	jr nz, .loop_copy_pal

	; de = wCardAttrMap
	push de
	ld b, $30
.asm_56e4
	ld a, [de]
	rlca
	rlca
	and $03
	add c
	ld [de], a
	inc de
	dec b
	jr nz, .asm_56e4
	pop hl
	ret

FlushAllPalettesIfNotDMG:
	ld a, [wConsole]
	or a
	ret z
	call FlushAllPalettes
	ret
; 0x56fa

	ret ; stray ret

JPWriteByteToBGMap0:
	jp WriteByteToBGMap0

DisplayCardPage_PokemonOverview:
	ld a, [wCardPageType]
	or a
	jr nz, .play_area_card_page

	; print surrounding box, card name at 5,1, type, set 2, and rarity
	call PrintPokemonCardPageGenericInformation
	; print fixed text and draw the card symbol associated to its TYPE_*
	ld hl, CardPageRetreatWRTextData
	call PlaceTextItems
	ld hl, CardPageLvHPNoTextTileData
	call WriteDataBlocksToBGMap0
	lb de, 3, 2
	call DrawCardSymbol
	; print pre-evolution's name (if any)
	ld a, [wLoadedCard1Stage]
	or a
	jr z, .basic
	ld hl, wLoadedCard1NonPokemonDescription
	lb de, 1, 3
	call InitTextPrinting_ProcessTextFromPointerToID
.basic
	; print card level and maximum HP
	lb bc, 12, 2
	ld a, [wLoadedCard1Level]
	call WriteTwoDigitNumberInTxSymbolFormat
	lb bc, 16, 2
	ld a, [wLoadedCard1HP]
	call WriteTwoByteNumberInTxSymbolFormat
	jr .print_numbers_and_energies

.play_area_card_page
	; draw the surrounding box, and print fixed text
	call DrawCardPageBoxAndCardGfx
	call LoadDuelCheckPokemonScreenTiles
	ld hl, CardPageRetreatWRTextData
	call PlaceTextItems
	ld hl, CardPageNoTextTileData
	call WriteDataBlocksToBGMap0
	ld a, 1
	ld [wCurPlayAreaY], a
	; print set 2 icon and rarity symbol at fixed positions
	call DrawCardPageSet2AndRarityIcons
	; print (Y coord at [wCurPlayAreaY]) card name, level, type, energies, HP, location...
	call PrintPlayAreaCardInformationAndLocation

; common for both card page types
.print_numbers_and_energies
	; print Pokedex number in the bottom right corner (16,16)
	lb bc, 16, 16
	ld a, [wLoadedCard1PokedexNumber]
	call WriteTwoByteNumberInTxSymbolFormat
	; print the name, damage, and energy cost of each attack and/or Pokemon power that exists
	; first attack at 5,10 and second at 5,12
	lb bc, 5, 10

.attacks
	ld e, c
	ld hl, wLoadedCard1Atk1Name
	call PrintAttackOrPkmnPowerInformation
	inc c
	inc c ; 12
	ld e, c
	ld hl, wLoadedCard1Atk2Name
	call PrintAttackOrPkmnPowerInformation
	; print the retreat cost (some amount of colorless energies) at 8,14
	inc c
	inc c ; 14
	ld b, 5
	ld a, [wLoadedCard1RetreatCost]
	ld e, a
	inc e
.retreat_cost_loop
	dec e
	jr z, .retreat_cost_done
	ld a, SYM_COLORLESS
	call JPWriteByteToBGMap0
	inc b
	jr .retreat_cost_loop
.retreat_cost_done
	; print the colors (energies) of the weakness(es) and resistance(s)
	inc c ; 15
	ld a, [wCardPageType]
	or a
	jr z, .wr_from_loaded_card
	ld a, [wCurPlayAreaSlot]
	or a
	jr nz, .wr_from_loaded_card
	call GetArenaCardWeakness
	ld d, a
	call GetArenaCardResistance
	ld e, a
	jr .got_wr
.wr_from_loaded_card
	ld a, [wLoadedCard1Weakness]
	ld d, a
	ld a, [wLoadedCard1Resistance]
	ld e, a
.got_wr
	ld a, d
	ld b, 5
	call PrintCardPageWeaknessesOrResistances
	inc c
	ld a, e
	call PrintCardPageWeaknessesOrResistances
	ret

; displays the name, damage, and energy cost of an attack or Pokemon power.
; used in the Attack menu and in the card page of a Pokemon.
; input:
   ; hl: pointer to attack 1 name in a atk_data_struct (which can be inside at card_data_struct)
   ; e: Y coordinate to start printing the data at
PrintAttackOrPkmnPowerInformation:
	ld a, [hli]
	or [hl]
	ret z
	push bc
	push hl
	dec hl
	; print text ID pointed to by hl at 7,e
	ld d, 7
	call InitTextPrinting_ProcessTextFromPointerToID
	pop hl
	inc hl
	inc hl
	ld a, [wCardPageNumber]
	or a
	jr nz, .print_damage
	dec hl
	ld a, [hli]
	or [hl]
	jr z, .print_damage
	; if in Attack menu and attack 1 description exists, print at 7,e:
	ld b, 7
	ld c, e
	inc c
	ld a, SYM_ATK_DESCR
	call WriteByteToBGMap0
.print_damage
	inc hl
	inc hl
	inc hl
	push hl
	ld a, [hl]
	or a
	jr z, .print_category
	; print attack damage at 15,(e+1) if non-0
	ld b, 15 ; unless damage has three digits, this is effectively 16
	ld c, e
	inc c
	call WriteTwoByteNumberInTxSymbolFormat
.print_category
	pop hl
	inc hl
	ld a, [hl]
	and $ff ^ RESIDUAL
	jr z, .print_energy_cost
	cp POKEMON_POWER
	jr z, .print_pokemon_power
	; register a is DAMAGE_PLUS, DAMAGE_MINUS, or DAMAGE_X
	; print the damage modifier (+, -, x) at 18,(e+1) (after the damage value)
	add SYM_PLUS - DAMAGE_PLUS
	ld b, 18
	ld c, e
	inc c
	call WriteByteToBGMap0
	jr .print_energy_cost
.print_energy_cost
	ld bc, CARD_DATA_ATTACK1_ENERGY_COST - CARD_DATA_ATTACK1_CATEGORY
	add hl, bc
	ld c, e
	ld b, 2 ; bc = 2, e
	lb de, NUM_TYPES / 2, 0
.energy_loop
	ld a, [hl]
	swap a
	call .PrintEnergiesOfColor
	ld a, [hli]
	call .PrintEnergiesOfColor
	dec d
	jr nz, .energy_loop
	pop bc
	ret
.print_pokemon_power
	; print "PKMN PWR" at 2,e
	ld d, 2
	ldtx hl, Text000a
	call InitTextPrinting_ProcessTextFromID
	pop bc
	ret

; print the number of energies required of color (type) e, and return e ++ (next color).
; the requirement of the current color is provided as input in the lower nybble of a.
.PrintEnergiesOfColor:
	inc e
	and $0f
	ret z
	push de
	ld d, a
.print_energies_loop
	ld a, e
	call JPWriteByteToBGMap0
	inc b
	dec d
	jr nz, .print_energies_loop
	pop de
	ret

; print the weaknesses or resistances of a Pokemon card, given in a, at b,c
PrintCardPageWeaknessesOrResistances:
	push bc
	push de
	ld d, a
	xor a ; FIRE
.loop
	; each WR_* constant is a different bit. rotate the value to find out
	; which bits are set and therefore which WR_* values are active.
	; a is kept updated with the equivalent TYPE_* constant.
	inc a
	cp 8
	jr nc, .done
	rl d
	jr nc, .loop
	push af
	call JPWriteByteToBGMap0
	inc b
	pop af
	jr .loop
.done
	pop de
	pop bc
	ret

; prints surrounding box, card name at 5,1, type, set 2, and rarity.
; used in all CARDPAGE_POKEMON_* and ATTACKPAGE_*, except in
; CARDPAGE_POKEMON_OVERVIEW when wCardPageType is CARDPAGETYPE_PLAY_AREA.
PrintPokemonCardPageGenericInformation:
	call DrawCardPageBoxAndCardGfx
	lb de, 5, 1
	ld hl, wLoadedCard1Name
	call InitTextPrinting_ProcessTextFromPointerToID
	ld a, [wCardPageType]
	or a
	jr z, .from_loaded_card
	ld a, [wCurPlayAreaSlot]
	call GetPlayAreaCardColor
	jr .got_color
.from_loaded_card
	ld a, [wLoadedCard1Type]
.got_color
	lb bc, 18, 1
	inc a
	call JPWriteByteToBGMap0
	call DrawCardPageSet2AndRarityIcons
	ret

DrawCardPageBoxAndCardGfx:
	lb de, 0, 0
	lb bc, 20, 18
	call DrawRegularTextBox
	call DrawCardPageCardGfx
	ret

CardPageRetreatWRTextData:
	textitem 1, 14, Text0007
	textitem 1, 15, Text0008
	textitem 1, 16, Text0009
	db $ff

CardPageLvHPNoTextTileData:
	db 11,  2, SYM_Lv, 0
	db 15,  2, SYM_HP, 0
;	continues to CardPageNoTextTileData

CardPageNoTextTileData:
	db 15, 16, SYM_No, 0
	db $ff

DisplayCardPage_PokemonAttack1Page1:
	ld hl, wLoadedCard1Atk1Name
	ld de, wLoadedCard1Atk1Description
	jr DisplayPokemonAttackCardPage

DisplayCardPage_PokemonAttack1Page2:
	ld hl, wLoadedCard1Atk1Name
	ld de, wLoadedCard1Atk1Description + 2
	jr DisplayPokemonAttackCardPage

DisplayCardPage_PokemonAttack2Page1:
	ld hl, wLoadedCard1Atk2Name
	ld de, wLoadedCard1Atk2Description
	jr DisplayPokemonAttackCardPage

DisplayCardPage_PokemonAttack2Page2:
	ld hl, wLoadedCard1Atk2Name
	ld de, wLoadedCard1Atk2Description + 2
;	fallthrough

; input:
   ; hl = address of the attack's name (text id)
   ; de = address of the attack's description (either first or second text id)
DisplayPokemonAttackCardPage:
	push de
	push hl
	; print surrounding box, card name at 5,1, type, set 2, and rarity
	call PrintPokemonCardPageGenericInformation
	; print name, damage, and energy cost of attack or Pokemon power starting at line 2
	ld e, 2
	pop hl
	call PrintAttackOrPkmnPowerInformation
	pop hl
;	fallthrough

; print, if non-null, the description of the trainer card, energy card, attack,
; or Pokemon power, given as a pointer to text id in hl, starting from 1,11
PrintAttackOrNonPokemonCardDescription:
	ld a, [hli]
	or [hl]
	ret z
	dec hl
	lb de, 1, 11
	call PrintAttackOrCardDescription
	ret

DisplayCardPage_PokemonDescription:
	; print surrounding box, card name at 5,1, type, set 2, and rarity
	call PrintPokemonCardPageGenericInformation
	call LoadDuelCardSymbolTiles2
	; print "LENGTH", "WEIGHT", "Lv", and "HP" where it corresponds in the page
	ld hl, CardPageLengthWeightTextData
	call PlaceTextItems
	ld hl, CardPageLvHPTextTileData
	call WriteDataBlocksToBGMap0
	; draw the card symbol associated to its TYPE_* at 3,2
	lb de, 3, 2
	call DrawCardSymbol
	; print the Level and HP numbers at 12,2 and 16,2 respectively
	lb bc, 12, 2
	ld a, [wLoadedCard1Level]
	call WriteTwoDigitNumberInTxSymbolFormat
	lb bc, 16, 2
	ld a, [wLoadedCard1HP]
	call WriteTwoByteNumberInTxSymbolFormat
	; print the Pokemon's category at 1,10 (just above the length and weight texts)
	lb de, 1, 10
	ld hl, wLoadedCard1Category
	call InitTextPrinting_ProcessTextFromPointerToID
	ld a, TX_KATAKANA
	call ProcessSpecialTextCharacter
	ldtx hl, Text000e
	call ProcessTextFromID
	; print the length at 3, 11
	lb bc, 3, 11
	ld a, [wLoadedCard1Length]
	ld l, a
	ld h, $00
	call PrintNumberAsMeasurement
	call InitTextPrinting
	ldtx hl, Text000f ; "m"
	call ProcessTextFromID
	; print the weight at 3, 12
	lb bc, 3, 12
	ld hl, wLoadedCard1Weight
	ld a, [hli]
	ld h, [hl]
	ld l, a
	call PrintNumberAsMeasurement
	ldtx hl, Text0010 ; "kg"
	call InitTextPrinting_ProcessTextFromID
	call SetNoLineSeparation
	ld a, 19
	lb de, 1, 14
	call InitTextPrintingInTextbox
	ld hl, wLoadedCard1Description
	call ProcessTextFromPointerToID
	call SetOneLineSeparation
	ret

; given a card rarity constant in a, and CardRarityTextIDs in hl,
; print the text character associated to it at d,e
PrintCardPageRarityIcon:
	inc a
	add a
	ld c, a
	ld b, $00
	add hl, bc
	call InitTextPrinting_ProcessTextFromPointerToID
	ret

; prints the card's set 2 icon and the full width text character of the card's rarity
DrawCardPageSet2AndRarityIcons:
	ld a, [wLoadedCard1Set]
	call LoadCardSet2Tiles
	jr c, .icon_done
	; draw the 2x2 set 2 icon of this card
	ld a, $fc
	lb hl, 1, 2
	lb bc, 2, 2
	lb de, 15, 8
	call FillRectangle
.icon_done
	lb de, 18, 9
	ld hl, CardRarityTextIDs
	ld a, [wLoadedCard1Rarity]
	cp PROMOSTAR
	call nz, PrintCardPageRarityIcon
	ret

CardPageLengthWeightTextData:
	textitem 1, 11, Text000c
	textitem 1, 12, Text000d
	db $ff

CardPageLvHPTextTileData:
	db 11, 2, SYM_Lv, 0
	db 15, 2, SYM_HP, 0
	db $ff

CardRarityTextIDs:
	tx Text0011 ; PROMOSTAR (unused)
	tx Text0012 ; CIRCLE
	tx Text0013 ; DIAMOND
	tx Text0014 ; STAR
	tx Text0015 ; RARITY_3

DisplayCardPage_TrainerPage1:
	xor a ; HEADER_TRAINER
	ld hl, wLoadedCard1NonPokemonDescription
	jr DisplayEnergyOrTrainerCardPage

DisplayCardPage_TrainerPage2:
	xor a ; HEADER_TRAINER
	ld hl, wLoadedCard1NonPokemonDescription + 2
	jr DisplayEnergyOrTrainerCardPage

DisplayCardPage_Energy2:
	ld a, HEADER_ENERGY
	ld hl, wLoadedCard1NonPokemonDescription + 2
	jr DisplayEnergyOrTrainerCardPage

DisplayCardPage_Energy1:
	ld a, HEADER_ENERGY
	ld hl, wLoadedCard1NonPokemonDescription
;	fallthrough

; input:
   ; a = HEADER_ENERGY or HEADER_TRAINER
   ; hl = address of the card's description (text id)
DisplayEnergyOrTrainerCardPage:
	push hl
	push af
	call LoadCardTypeHeaderTiles
	; draw surrounding box
	lb de, 0, 0
	lb bc, 20, 18
	call DrawRegularTextBox
	pop af
	ld e, a
	ld d, $00
	ld hl, .HeaderPaletteIndices
	add hl, de
	ld a, [hl]
	lb hl, 0, 0
	call BankswitchVRAM1
	call .FillHeaderRectangle
	call BankswitchVRAM0
	call DrawCardPageCardGfx
	; print the card's name at 4,3
	lb de, 4, 3
	ld hl, wLoadedCard1Name
	call InitTextPrinting_ProcessTextFromPointerToID
	ld a, $e0
	lb hl, 1, 8
	call .FillHeaderRectangle
	call DrawCardPageSet2AndRarityIcons
	pop hl
	call PrintAttackOrNonPokemonCardDescription
	ret

.FillHeaderRectangle:
	lb de, 6, 1
	lb bc, 8, 2
	jp FillRectangle

.HeaderPaletteIndices:
	db $4 ; HEADER_TRAINER
	db $3 ; HEADER_ENERGY
	db $2 ; HEADER_POKEMON (unused)

; print lines of text with no separation between them
SetNoLineSeparation:
	ld a, $01
;	fallthrough

SetLineSeparation:
	ld [wLineSeparation], a
	ret

; separate lines of text by an empty line
SetOneLineSeparation:
	xor a
	jr SetLineSeparation

; prints number in register hl, first
; by dividing by 10, then by adding ".0"
; to the end if result has less than
; 4 digits (ie xxxx.0)
PrintNumberAsMeasurement:
	push bc
	ld de, -1
	ld bc, -10
.loop_subtract
	inc de
	add hl, bc
	jr c, .loop_subtract
	ld bc, 10
	add hl, bc
	pop bc
	push hl
	push bc
	ld l, e
	ld h, d
	call TwoByteNumberToTxSymbol_TrimLeadingZeros_Bank1
	pop bc
	pop hl
	ld a, l
	ld hl, wStringBuffer + $5
	or a
	jr z, .skip_decimal
	; appends ".0" to string
	ld [hl], SYM_DOT
	inc hl
	add SYM_0
	ld [hli], a
.skip_decimal
	ld [hl], TX_END
	push bc
	call BCCoordToBGMap0Address

	; loop through the string to find the first
	; non-0 byte (first number character)
	ld hl, wStringBuffer
.loop_find_first_number
	ld a, [hli]
	or a
	jr z, .loop_find_first_number
	dec hl

	; now loop string until end of text is found
	; and output size in b for SafeCopyDataHLtoDE
	push hl
	ld b, -1
.loop_get_size
	inc b
	ld a, [hli]
	or a
	jr nz, .loop_get_size
	pop hl
	push bc
	call SafeCopyDataHLtoDE
	pop bc
	pop de
	ld a, b
	add d
	ld d, a
	ret
; 0x5a42

SECTION "Bank 1@5cb7", ROMX[$5cb7], BANK[$1]

; print a turn holder's play area Pokemon card's name, level, face down stage card,
; color symbol, status symbol (if any), pluspower/defender symbols (if any),
; attached energies (if any), HP bar, and the play area location (ACT/BPx indicator)
; input:
   ; wCurPlayAreaSlot: PLAY_AREA_* of the card to display the information of
   ; wCurPlayAreaY: Y coordinate of where to print the card's information
; total space occupied is a rectangle of 20x3 tiles
PrintPlayAreaCardInformationAndLocation:
	ld a, [wCurPlayAreaSlot]
	add DUELVARS_ARENA_CARD
	get_turn_duelist_var
	cp -1
	ret z
	call PrintPlayAreaCardInformation
	ld de, PlayerPlayAreaLocationTileNumbers
	ldh a, [hWhoseTurn]
	cp PLAYER_TURN
	jr z, .opps_turn
	ld de, OpponentPlayAreaLocationTileNumbers
.opps_turn
	ld a, [wCurPlayAreaSlot]
	add a
	add a
	ld l, a
	ld h, $00
	add hl, de
	ld a, [wCurPlayAreaY]
	ld c, a
	ld b, 1
	ld a, [hli]
	ld e, a
	; call .WritePalAndTile 3 times
	; because each position is 3 tiles high
	call .WritePalAndTile
	call .WritePalAndTile
;	fallthrough

.WritePalAndTile:
	call BankswitchVRAM1
	ld a, e ; pal index
	call WriteByteToBGMap0
	call BankswitchVRAM0
	ld a, [hli] ; vtile
	call WriteByteToBGMap0
	inc c
	ret

PlayerPlayAreaLocationTileNumbers:
	db $2, $e0, $e1, $e2 ; ACT
	db $2, $e3, $e4, $e5 ; BP1
	db $2, $e3, $e4, $e6 ; BP2
	db $2, $e3, $e4, $e7 ; BP3
	db $2, $e3, $e4, $e8 ; BP4
	db $2, $e3, $e4, $e9 ; BP5

OpponentPlayAreaLocationTileNumbers:
	db $4, $ea, $eb, $ec ; ACT
	db $3, $ed, $ee, $ef ; BP1
	db $3, $ed, $ee, $f0 ; BP2
	db $3, $ed, $ee, $f1 ; BP3
	db $3, $ed, $ee, $f2 ; BP4
	db $3, $ed, $ee, $f3 ; BP5

; print a turn holder's play area Pokemon card's name, level, face down stage card,
; color symbol, status symbol (if any), pluspower/defender symbols (if any),
; attached energies (if any), and HP bar.
; input:
   ; wCurPlayAreaSlot: PLAY_AREA_* of the card to display the information of
   ; wCurPlayAreaY: Y coordinate of where to print the card's information
; total space occupied is a rectangle of 20x3 tiles
PrintPlayAreaCardInformation:
	; print name, level, color, stage, status, pluspower/defender
	call PrintPlayAreaCardHeader
	; print the symbols of the attached energies
	ld a, [wCurPlayAreaSlot]
	ld e, a
	ld a, [wCurPlayAreaY]
	inc a
	ld c, a
	ld b, 7
	call PrintPlayAreaCardAttachedEnergies
	ld a, [wCurPlayAreaY]
	inc a
	ld c, a
	ld b, 5
	ld a, SYM_E
	call WriteByteToBGMap0
	; print the HP bar
	inc c
	ld a, SYM_HP
	call WriteByteToBGMap0
	ld a, [wCurPlayAreaSlot]
	add DUELVARS_ARENA_CARD_HP
	get_turn_duelist_var
	or a
	jr z, .zero_hp
	ld e, a
	ld a, [wLoadedCard1HP]
	ld d, a
	call DrawHPBar
	ld a, [wCurPlayAreaY]
	inc a
	inc a
	ld c, a
	ld b, 7
	call BCCoordToBGMap0Address
	ld hl, wDefaultText
	ld b, 12
	call SafeCopyDataHLtoDE
	ret
.zero_hp
	; if fainted, print "Knock Out" in place of the HP bar
	ld a, [wCurPlayAreaY]
	inc a
	inc a
	ld e, a
	ld d, 7
	ldtx hl, Text004f
	call InitTextPrinting_ProcessTextFromID
	ret

; print a turn holder's play area Pokemon card's name, level, face down stage card,
; color symbol, status symbol (if any), and pluspower/defender symbols (if any).
; input:
   ; wCurPlayAreaSlot: PLAY_AREA_* of the card to display the information of
   ; wCurPlayAreaY: Y coordinate of where to print the card's information
PrintPlayAreaCardHeader:
	ld a, [wCurPlayAreaSlot]
	add DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call LoadCardDataToBuffer1_FromDeckIndex
	ld a, [wCurPlayAreaY]
	ld e, a
	ld d, 4
	call InitTextPrinting
	; copy the name to wDefaultText (max. 10 characters)
	; then call ProcessText with hl = wDefaultText
	ld hl, wLoadedCard1Name
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld de, wDefaultText
	push de
	ld a, 10 ; card name maximum length
	call CopyTextData_FromTextID
	pop hl
	call ProcessText

	; print the Pokemon's color and the level
	ld a, [wCurPlayAreaY]
	ld c, a
	ld b, 18
	ld a, [wCurPlayAreaSlot]
	call GetPlayAreaCardColor
	inc a
	call JPWriteByteToBGMap0
	ld b, 14
	ld a, SYM_Lv
	call WriteByteToBGMap0
	ld a, [wCurPlayAreaY]
	ld c, a
	ld b, 15
	ld a, [wLoadedCard1Level]
	call WriteTwoDigitNumberInTxSymbolFormat

	; print the 2x2 face down card image depending on the Pokemon's evolution stage
	ld a, [wCurPlayAreaSlot]
	add DUELVARS_ARENA_CARD_STAGE
	get_turn_duelist_var
	add a
	ld e, a
	ld d, $00
	ld hl, FaceDownCardTileNumbers
	add hl, de
	ld a, [hli] ; starting tile to fill the 2x2 rectangle with
	push hl
	push af
	lb hl, 1, 2
	lb bc, 2, 2
	ld a, [wCurPlayAreaY]
	ld e, a
	ld d, 2
	pop af
	call FillRectangle
	pop hl
	ld a, [wConsole]
	cp CONSOLE_CGB
	jr nz, .not_cgb
	; in cgb, we have to take care of coloring it too
	ld a, [hl]
	lb hl, 0, 0
	lb bc, 2, 2
	call BankswitchVRAM1
	call FillRectangle
	call BankswitchVRAM0

.not_cgb
	; print the status condition symbol if any (only for the arena Pokemon card)
	ld hl, wCurPlayAreaSlot
	ld a, [hli]
	or a
	jr nz, .skip_status
	ld c, [hl]
	inc c
	inc c
	ld b, 2
	ld a, DUELVARS_ARENA_CARD_STATUS
	get_turn_duelist_var
	call CheckPrintCnfSlpPrz
	inc b
	call CheckPrintPoisoned
	inc b
	call CheckPrintDoublePoisoned

.skip_status
	; finally check whether to print the Pluspower and/or Defender symbols
	ld a, [wCurPlayAreaSlot]
	add DUELVARS_ARENA_CARD_ATTACHED_PLUSPOWER
	get_turn_duelist_var
	or a
	jr z, .not_pluspower
	ld a, [wCurPlayAreaY]
	inc a
	ld c, a
	ld b, 15
	ld a, SYM_PLUSPOWER
	call WriteByteToBGMap0
	inc b
	ld a, [hl]
	add SYM_0
	call WriteByteToBGMap0
.not_pluspower
	ld a, [wCurPlayAreaSlot]
	add DUELVARS_ARENA_CARD_ATTACHED_DEFENDER
	get_turn_duelist_var
	or a
	jr z, .not_defender
	ld a, [wCurPlayAreaY]
	inc a
	ld c, a
	ld b, 17
	ld a, SYM_DEFENDER
	call WriteByteToBGMap0
	inc b
	ld a, [hl]
	add SYM_0
	call WriteByteToBGMap0

.not_defender
	ld a, [wCurPlayAreaSlot]
	add DUELVARS_ARENA_CARD_FOOD_COUNTERS
	get_turn_duelist_var
	or a
	jr z, .no_food_counters
	ld e, a
	ld a, [wCurPlayAreaY]
	inc a
	ld c, a
	ld b, 6
.loop_food_counters
	ld a, SYM_CHERRY
	call WriteByteToBGMap0
	inc c
	dec e
	jr nz, .loop_food_counters
.no_food_counters
	ret

FaceDownCardTileNumbers:
; starting tile number, cgb palette (grey, yellow/red, green/blue, pink/orange)
	db $d0, $03 ; basic
	db $d4, $03 ; stage 1
	db $d8, $02 ; stage 2
	db $dc, $02 ; stage 2 special

CheckPrintPoisoned:
	push af
	and POISONED
	jr z, .print
.poison
	ld a, SYM_POISONED
.print
	call WriteByteToBGMap0
	pop af
	ret

CheckPrintDoublePoisoned:
	push af
	and DOUBLE_POISONED & (POISONED ^ $ff)
	jr nz, CheckPrintPoisoned.poison ; double poisoned (print SYM_POISONED)
	jr CheckPrintPoisoned.print ; not double poisoned (print SYM_SPACE)

; given a card's status in a, print the Confusion, Sleep, or Paralysis symbol at bc
; for each of those status that is active
CheckPrintCnfSlpPrz:
	push af
	push hl
	push de
	and CNF_SLP_PRZ
	ld e, a
	ld d, $00
	ld hl, .status_symbols
	add hl, de
	ld a, [hl]
	call WriteByteToBGMap0
	pop de
	pop hl
	pop af
	ret

.status_symbols
	;  NO_STATUS, CONFUSED,     ASLEEP,     PARALYZED
	db SYM_SPACE, SYM_CONFUSED, SYM_ASLEEP, SYM_PARALYZED

; prints cherry symbols on the arena card
; if it has any Food Counters
; if a = 1, prints them left to right
; if a = -1, print them right to left
CheckPrintFoodCounters:
	push af
	ld a, DUELVARS_ARENA_CARD_FOOD_COUNTERS
	get_turn_duelist_var
	or a
	jr z, .done
	ld e, a
.loop_counters
	ld a, SYM_CHERRY
	call WriteByteToBGMap0
	pop af
	push af
	add c
	ld c, a
	dec e
	jr nz, .loop_counters
.done
	pop af
	ret

; print the symbols of the attached energies of a turn holder's play area card
; input:
; - e: PLAY_AREA_*
; - b, c: where to print (x, y)
; - wAttachedEnergies and wTotalAttachedEnergies
PrintPlayAreaCardAttachedEnergies:
	push bc
	call GetPlayAreaCardAttachedEnergies
	ld hl, wDefaultText
	push hl
	ld c, 8
	xor a
.empty_loop
	ld [hli], a
	dec c
	jr nz, .empty_loop
	pop hl
	ld a, [wAttachedEnergies + RAINBOW]
	inc a
	ld c, a
	jr .next_rainbow_energy
.loop_rainbow_energies
	ld [hl], SYM_RAINBOW
	inc hl
.next_rainbow_energy
	dec c
	jr nz, .loop_rainbow_energies

	ld de, wAttachedEnergies
	lb bc, SYM_FIRE, NUM_TYPES - 1
.next_color
	ld a, [de] ; energy count of current color
	inc de
	inc a
	jr .check_amount
.has_energy
	ld [hl], b
	inc hl
.check_amount
	dec a
	jr nz, .has_energy
	inc b
	dec c
	jr nz, .next_color
	ld a, [wTotalAttachedEnergies]
	cp 9
	jr c, .place_tiles
	ld a, SYM_PLUS
	ld [wDefaultText + 7], a
.place_tiles
	pop bc
	call BCCoordToBGMap0Address
	ld hl, wDefaultText
	ld b, NUM_TYPES
	call SafeCopyDataHLtoDE
	ret
; 0x5efe

SECTION "Bank 1@5fea", ROMX[$5fea], BANK[$1]

; print the description of an attack, a Pokemon power, or a trainer or energy card
; x,y coordinates of where to start printing the text are given at de
; don't separate lines of text
PrintAttackOrCardDescription:
	call SetNoLineSeparation
	ld a, [hli]
	ld h, [hl]
	ld l, a
	call CountLinesOfTextFromID
	cp 7
	jr c, .print
	dec e ; move one line up to fit (assumes it will be enough)
.print
	ld a, 19
	call InitTextPrintingInTextbox
	call ProcessTextFromID
	call SetOneLineSeparation
	ret
; 0x6004

SECTION "Bank 1@6061", ROMX[$6061], BANK[$1]

WriteTwoByteNumberInTxSymbolFormat:
	push de
	push bc
	ld l, a
	ld h, $00
	call TwoByteNumberToTxSymbol_TrimLeadingZeros_Bank1
	pop bc
	push bc
	call BCCoordToBGMap0Address
	ld hl, wStringBuffer + 2
	ld b, 3
	call SafeCopyDataHLtoDE
	pop bc
	pop de
	ret
; 0x6079

SECTION "Bank 1@608e", ROMX[$608e], BANK[$1]

; given a number between 0-99 in a, converts it to TX_SYMBOL format,
; and writes it to wStringBuffer + 3 and to the BGMap0 address at bc.
; if the number is between 0-9, the first digit is replaced with SYM_SPACE.
WriteTwoDigitNumberInTxSymbolFormat:
	push hl
	push de
	push bc
	ld l, a
	ld h, $00
	call TwoByteNumberToTxSymbol_TrimLeadingZeros_Bank1
	pop bc
	push bc
	call BCCoordToBGMap0Address
	ld hl, wStringBuffer + 3
	ld b, 2
	call SafeCopyDataHLtoDE
	pop bc
	pop de
	pop hl
	ret

; convert the number at hl to TX_SYMBOL text format and write it to wStringBuffer
; replace leading zeros with SYM_SPACE
TwoByteNumberToTxSymbol_TrimLeadingZeros_Bank1:
	ld de, wStringBuffer
	ld bc, -10000
	call .get_digit
	ld bc, -1000
	call .get_digit
	ld bc, -100
	call .get_digit
	ld bc, -10
	call .get_digit
	ld bc, -1
	call .get_digit
	xor a
	ld [de], a
	ld hl, wStringBuffer
	ld b, 4
.digit_loop
	ld a, [hl]
	cp SYM_0
	jr nz, .done ; jump if not zero
	ld [hl], SYM_SPACE ; trim leading zero
	inc hl
	dec b
	jr nz, .digit_loop
.done
	ret

.get_digit
	ld a, SYM_0 - 1
.subtract_loop
	inc a
	add hl, bc
	jr c, .subtract_loop
	ld [de], a
	inc de
	ld a, l
	sub c
	ld l, a
	ld a, h
	sbc b
	ld h, a
	ret

; input d, e: max. HP, current HP
DrawHPBar:
	ld a, MAX_HP
	ld c, SYM_SPACE
	call .fill_hp_bar ; empty bar
	ld a, d
	ld c, SYM_HP_OK
	call .fill_hp_bar ; fill (max. HP) with HP counters
	ld a, d
	sub e
	ld c, SYM_HP_NOK
; fill (max. HP - current HP) with damaged HP counters
.fill_hp_bar
	or a
	ret z
	ld hl, wDefaultText
	ld b, HP_BAR_LENGTH
.tile_loop
	ld [hl], c
	inc hl
	dec b
	ret z
	sub MAX_HP / HP_BAR_LENGTH
	jr nz, .tile_loop
	ret

; loads a player deck (sDeck*Cards) from SRAM to wPlayerDeck
; sCurrentlySelectedDeck determines which sDeck*Cards source (0-3)
LoadPlayerDeck:
	call EnableSRAM
	ld a, [sCurrentlySelectedDeck]
	ld l, a
	ld h, DECK_COMPRESSED_STRUCT_SIZE
	call HtimesL
	ld de, sDeck1Cards
	add hl, de
	ld e, l
	ld d, h
	ld hl, wPlayerDeck
	call DecompressSRAMDeck
	call DisableSRAM
	ret
; 0x6128

SECTION "Bank 1@6897", ROMX[$6897], BANK[$1]

; writes the cards in de to hl
; in a compressed format
SaveDeckCards:
	push hl
	push de
	push bc
	ld a, 8
.loop
	push af
	inc hl
	ld c, 8
.loop_bits
	ld a, [de]
	inc de
	ld [hli], a
	ld a, [de]
	inc de
	rra
	rl b
	dec c
	jr nz, .loop_bits
	push hl
	push de
	ld de, -9
	add hl, de
	ld [hl], b
	pop de
	pop hl
	pop af
	dec a
	jr nz, .loop
	pop bc
	pop de
	pop hl
	ret

; loads deck saved in SRAM to hl
DecompressSRAMDeck:
	push hl
	push de
	push bc
	ld a, $08
.loop_outer
	push af
	ld a, [de]
	inc de
	ld b, a
	ld c, 8 ; number of bits
.loop_inner
	ld a, [de]
	inc de
	ld [hli], a
	xor a
	rl b
	rla
	ld [hli], a
	dec c
	jr nz, .loop_inner
	pop af
	dec a
	jr nz, .loop_outer
	pop bc
	pop de
	pop hl
	ret
; 0x68da

SECTION "Bank 1@6a0c", ROMX[$6a0c], BANK[$1]

; creates a list at wTempCardCollection of every card the player owns and how many
CreateTempCardCollection::
	call EnableSRAM
	ld hl, sCardCollection
	ld de, wTempCardCollection
	ld bc, CARD_COLLECTION_SIZE
	call CopyDataHLtoDE
	ld de, sDeck1Cards
	call .AddCards
	call .AddCards
	call .AddCards
	call .AddCards
	call DisableSRAM
	ret

.AddCards:
	push de
	ld hl, wDuelTempList
	push hl
	call DecompressSRAMDeck
	pop hl
.loop_cards
	ld e, [hl]
	inc hl
	ld d, [hl]
	inc hl
	ld a, e
	or d
	jr z, .next_deck
	push hl
	ld hl, wTempCardCollection
	add hl, de
	inc [hl]
	pop hl
	jr .loop_cards
.next_deck
	pop de
	ld hl, DECK_COMPRESSED_STRUCT_SIZE
	add hl, de
	ld e, l
	ld d, h
	ret

SECTION "Bank 1@6a96", ROMX[$6a96], BANK[$1]

SortDuelTempListByCardID:
	ld hl, hTempListPtr_ff99
	ld [hl], LOW(wDuelTempList)
	inc hl
	ld [hl], HIGH(wDuelTempList)
	jr .asm_6ae2

.asm_6aa0
	ld hl, hTempListPtr_ff99
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld e, l
	ld d, h
	ld a, [de]
	call .GetCardID
	ld a, c
	ldh [hTempCardID_ff9b + 0], a
	ld a, b
	ldh [hTempCardID_ff9b + 1], a
	inc hl
	jr .asm_6acc

.compare_card_ids
	ld a, [hl]
	call .GetCardID
	ldh a, [hTempCardID_ff9b + 1]
	cp b
	jr nz, .swap_card_ids
	ldh a, [hTempCardID_ff9b + 0]
	cp c
.swap_card_ids
	jr c, .sorted
	ld e, l
	ld d, h
	ld a, c
	ldh [hTempCardID_ff9b + 0], a
	ld a, b
	ldh [hTempCardID_ff9b + 1], a
.sorted
	inc hl
.asm_6acc
	bit 7, [hl]
	jr z, .compare_card_ids
	ld hl, hTempListPtr_ff99
	push hl
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld c, [hl]
	ld a, [de]
	ld [hl], a
	ld a, c
	ld [de], a
	pop hl
	inc [hl]
	jr nz, .asm_6ae2
	inc hl
	inc [hl]
.asm_6ae2
	ld hl, hTempListPtr_ff99
	ld a, [hli]
	ld h, [hl]
	ld l, a
	bit 7, [hl]
	jr z, .asm_6aa0
	ret

.GetCardID:
	push hl
	call _GetCardIDFromDeckIndex
	ld c, [hl]
	inc hl
	ld b, [hl]
	pop hl
	ret
; 0x6af6

SECTION "Bank 1@6bc8", ROMX[$6bc8], BANK[$1]

SetDefaultPalettes:
	call SetFontAndTextBoxFrameColor
	ld a, %11100100
	ld [wOBP0], a
	ld [wBGP], a
	ld a, $01 ; equivalent to FLUSH_ONE_PAL
	ldh [hFlushPaletteFlags], a
	ld hl, Pals_6f0b0 - $4000
	ld de, wObjectPalettesCGB
	ld c, CGB_PAL_SIZE
	call CopyFontsOrDuelGraphicsBytes
	call FlushAllPalettes
	ret

SetFontAndTextBoxFrameColor:
	ld a, $01
	ld [wTextBoxFrameType], a
	ld hl, Pals_6f0b0 - $4000
	ld de, wBackgroundPalettesCGB
	ld c, CGB_PAL_SIZE
	call CopyFontsOrDuelGraphicsBytes
	push de
	call EnableSRAM
	ld a, [sTextBoxFrameColor]
	call DisableSRAM
	inc a
	add a
	add a
	add a ; *CGB_PAL_SIZE
	ld e, a
	ld d, $00
	ld hl, Pals_6f0b0 - $4000
	add hl, de
	pop de
	ld c, CGB_PAL_SIZE
	call CopyFontsOrDuelGraphicsBytes
	ret

SECTION "Bank 1@6c12", ROMX[$6c12], BANK[$1]

Func_6c12:
	ld hl, $30d8
	ld de, wBackgroundPalettesCGB + 2 * CGB_PAL_SIZE
	ld c, 3 palettes
	jp CopyFontsOrDuelGraphicsBytes
; 0x6c1d

SECTION "Bank 1@70b4", ROMX[$70b4], BANK[$1]

; returns carry if Pokemon in turn holder's
; Play Area location in register a cannot
; use its Pkmn Power
CheckIsIncapableOfUsingPkmnPower:
	ld [wce0c], a
	or a
	jr nz, .skip_arena_card_condition
	ld a, DUELVARS_ARENA_CARD_STATUS
	get_turn_duelist_var
	and CNF_SLP_PRZ
	ldtx hl, Text00d6
	scf
	ret nz
.skip_arena_card_condition
	call CheckGoopGasAttackAndToxicGasActive
	ret c
	ld a, [wce0c]
	add DUELVARS_ARENA_CARD_FLAGS
	get_turn_duelist_var
	and $10
	jr z, .can_use
	; used this turn
	ldtx hl, Text00e0 ; can't use due to "Shock Eye"?
	ld a, $02
	scf
	ret
.can_use
	or a
	ret

; return in a the amount of cards that correspond to the
; card ID in input register de, which have their Pkmn Power active
; also return carry if at least 1 is found
; de = card ID
CountPokemonWithActivePkmnPowerInBothPlayAreas:
	push bc
	push de
	call CountTurnDuelistPokemonWithActivePkmnPower
	ld c, a
	call SwapTurn
	pop de
	call CountTurnDuelistPokemonWithActivePkmnPower
	call SwapTurn
	add c
	jr z, .none_found
	scf
.none_found
	pop bc
	ret
; 0x70f1

SECTION "Bank 1@7100", ROMX[$7100], BANK[$1]

; counts how many Pokemon with card ID in de
; is in Turn Duelist's Play Area with its Pkmn Power active
; de = card ID
CountTurnDuelistPokemonWithActivePkmnPower:
	push hl
	push de
	push bc
	ld c, 0
	call .CheckArenaCard
	jr nc, .check_bench
	inc c

; if a Bench card is the same as wTempCardID_ce08,
; and its flag 4 is not set, then add to count
.check_bench
	ld b, PLAY_AREA_BENCH_1
	ldh a, [hWhoseTurn]
	ld h, a
.loop_bench
	ld a, b
	add DUELVARS_ARENA_CARD
	ld l, a
	ld a, [hl]
	cp $ff
	jr z, .tally
	call GetCardIDFromDeckIndex
	ld a, [wTempCardID_ce08 + 0]
	cp e
	jr nz, .next_bench_card
	ld a, [wTempCardID_ce08 + 1]
	cp d
	jr nz, .next_bench_card
	; is input card ID
	ld a, b
	add DUELVARS_ARENA_CARD_FLAGS
	ld l, a
	bit 4, [hl]
	jr nz, .next_bench_card
	inc c
.next_bench_card
	inc b
	jr .loop_bench

.tally
	ld a, c
	or a
	scf
	jr nz, .at_least_1
	or a
.at_least_1
	pop bc
	pop de
	pop hl
	ret

; returns carry if turn duelist's Arena card
; is the card in input registers de,
; is not affected by a status condition and
; flag 4 is not set
.CheckArenaCard:
	ld hl, wTempCardID_ce08
	ld [hl], e
	inc hl
	ld [hl], d
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	cp $ff
	jr z, .false
	call GetCardIDFromDeckIndex
	ld hl, wTempCardID_ce08
	ld a, [hli]
	cp e
	jr nz, .false
	ld a, [hl]
	cp d
	jr nz, .false
	ld a, DUELVARS_ARENA_CARD_STATUS
	get_turn_duelist_var
	and CNF_SLP_PRZ
	jr nz, .false
	ld l, DUELVARS_ARENA_CARD_FLAGS
	bit 4, [hl]
	jr nz, .false
; true
	scf
	ret
.false
	or a
	ret
; 0x716a

SECTION "Bank 1@71ea", ROMX[$71ea], BANK[$1]

; checks if Goop Gas Attack is active and if so,
; returns carry and a = $1
; otherwise, checks for Muk in Play Area with Pkmn Power active
; and if there is at least 1, return carry and a = $0
CheckGoopGasAttackAndToxicGasActive:
	ld a, [wGoopGasAttackActive]
	or a
	jr nz, .goop_gas_attack_active
	push de
	ld de, MUK
	call CountPokemonWithActivePkmnPowerInBothPlayAreas
	pop de
	ld a, $00
	ldtx hl, Text00df
	ret
.goop_gas_attack_active
	ld a, $01
	ldtx hl, Text024a
	scf
	ret
; 0x7205

SECTION "Bank 1@755d", ROMX[$755d], BANK[$1]

; return the turn holder's arena card's color in a, accounting for Venomoth's Shift Pokemon Power if active
GetArenaCardColor:
	xor a

; input: a = play area location offset (PLAY_AREA_*) of the desired card
; return the turn holder's card's color in a, accounting for Venomoth's Shift Pokemon Power if active
GetPlayAreaCardColor::
	push hl
	push de
	ld e, a
	add DUELVARS_ARENA_CARD_CHANGED_TYPE
	get_turn_duelist_var
	bit HAS_CHANGED_COLOR_F, a
	jr nz, .has_changed_color
.regular_color
	ld a, e
	add DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call GetCardIDFromDeckIndex
	call GetCardType
	cp TYPE_TRAINER
	jr nz, .got_type
	ld a, COLORLESS
.got_type
	pop de
	pop hl
	ret
.has_changed_color
	ld a, e
	call CheckIsIncapableOfUsingPkmnPower
	jr c, .regular_color ; jump if can't use Shift
	ld a, e
	add DUELVARS_ARENA_CARD_CHANGED_TYPE
	get_turn_duelist_var
	pop de
	pop hl
	and $f
	ret
; 0x758a

SECTION "Bank 1@7591", ROMX[$7591], BANK[$1]

; return in a the weakness of the turn holder's arena Pokemon
; if [DUELVARS_ARENA_CARD_CHANGED_WEAKNESS] != 0, return it instead
GetArenaCardWeakness:
	ld a, DUELVARS_ARENA_CARD_CHANGED_WEAKNESS
	get_turn_duelist_var
	or a
	ret nz
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call LoadCardDataToBuffer2_FromDeckIndex
	ld a, [wLoadedCard2Weakness]
	ret
; 0x75a0

SECTION "Bank 1@75a7", ROMX[$75a7], BANK[$1]

GetArenaCardResistance:
	ld a, DUELVARS_ARENA_CARD_CHANGED_RESISTANCE
	get_turn_duelist_var
	or a
	ret nz
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call LoadCardDataToBuffer2_FromDeckIndex
	ld a, [wLoadedCard2Resistance]
	ret
; 0x75b6
