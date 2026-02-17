AskToPlaySlots:
	call ClearSpriteAnimsAndSetInitialGraphicsConfiguration
	call .ShowDescription
	call SetFrameFuncAndFadeFromWhite
	call .StartPrompt
	call FadeToWhiteAndUnsetFrameFunc
	ret

.ShowDescription:
	lb de, 0, 0
	lb bc, 20, 12
	call DrawRegularTextBoxVRAM0
	lb de, 0, 12
	lb bc, 20, 6
	call DrawRegularTextBoxVRAM0
	lb de, 1, 0
	ldtx hl, GameCenterSlotMachineTitleText
	call Func_2c4b
	lb de, 1, 2
	ldtx hl, GameCenterSlotMachineDescriptionText
	call InitTextPrinting_ProcessTextFromIDVRAM0
	ld a, [wSlotMachineBets]
	ld l, a
	ld h, $00
	call LoadTxRam3
	ldtx hl, GameCenterXChipsPerPlayText
	lb de, 14, 0
	call Func_2c4b
	ret

.StartPrompt:
	ldtx hl, GameCenterSlotMachineStartPromptText
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

StartSlotMachine:
	call ClearSpriteAnimsAndSetInitialGraphicsConfiguration
	call InitSlotMachineReels
	xor a
	ld [wSlotMachineDebugFlag], a
	xor a
	ld [wSlotMachineIsBonusPlay], a
	call LoadSlotMachineReels
	call DrawSlotMachine
	call SetFrameFuncAndFadeFromWhite
	call .Start
	call FadeToWhiteAndUnsetFrameFunc
	ret

.Start:
	call .InitSpins
	call HandleSlotMachineBetting
	ret c ; cancelled
	call UpdateSlotMachineHotModeAndBias
	call .IsChanceAnim
	push af
	ld a, SFX_SLOT_START
	call CallPlaySFX
	pop af
	ld a, 8
	call DoAFrames_WithPreCheck
.wait_vblank
	call DoFrame
	ld a, [wSlotMachineVBlankCounter]
	ld b, a
	ld a, [wVBlankCounter]
	and b
	jr nz, .wait_vblank
	call SpinSlotMachineReels
	call UpdateSlotMachineSpinTimer
	call DrawSlotMachineReels
	call AreAllSlotMachineReelsStopped
	jr nc, .wait_vblank
	call CheckSlotMachinePayline
	jr c, .payout
	ld a, 30
	call DoAFrames_WithPreCheck
	jr .Start

.payout
	call HandleSlotMachinePayouts
	xor a
	ld [wSlotMachineHotModeRemaining], a
	jr .Start

.InitSpins:
	ld a, 30
	call Random
	add 24
	ld [wSlotMachineSpinTimer], a
	xor a
	ld [wNumSlotMachineLandedReels], a
	ld a, 1
	ld [wSlotMachineVBlankCounter], a
	call ReinitSlotMachineReels
	call CallClearSpriteAnims
	ret

; display "CHANCE!" above reels
; only in regular-jackpot hot mode (colorless/rainbow)
.IsChanceAnim:
	ld a, [wSlotMachineHotModeRemaining]
	and a
	ret z
	ld a, [wSlotMachineBiasedSymbol]
	cp SLOTMACHINESYMBOL_COLORLESS ; big hit
	jr z, .display_chance
	cp SLOTMACHINESYMBOL_RAINBOW   ; bonus hit
	jr z, .display_chance
	ret
.display_chance
	call CreateSlotMachineChanceAnimation
	ret

SlotMachineBonusPlay:
	call BackupSlotMachineReelStates
	ld a, TRUE
	call .SwitchDisplay
	call HideNPCAnimsUnderDialogBox
	ldtx hl, GameCenterSlotMachineBonusPlayText
	call PrintSlotMachineBonusPlayDialog
	call ShowNPCAnimsUnderDialogBox
	ld a, MAX_NUM_SLOT_MACHINE_BONUS_PLAYS
	ld [wSlotMachineBonusPlaysRemaining], a

.start
	call .InitSpins
	call UpdateSlotMachineHotModeAndBias
	call PrintSlotMachineBonusPlayCounter
	ld a, [wSlotMachineBonusPlaysRemaining]
	and a
	jr z, .exit
	dec a
	ld [wSlotMachineBonusPlaysRemaining], a
	push af
	ld a, SFX_SLOT_START
	call CallPlaySFX
	pop af
	ld a, 8
	call DoAFrames_WithPreCheck
.wait_vblank
	call DoFrame
	ld a, [wSlotMachineVBlankCounter]
	ld b, a
	ld a, [wVBlankCounter]
	and b
	jr nz, .wait_vblank
	call SpinSlotMachineReels
	call UpdateSlotMachineSpinTimer
	call DrawSlotMachineReels
	call AreAllSlotMachineReelsStopped
	jr nc, .wait_vblank
	call CheckSlotMachinePayline
	jr c, .payout
	ld a, 30
	call DoAFrames_WithPreCheck
	jr .start

.payout
	call HandleSlotMachinePayouts
	xor a
	ld [wSlotMachineHotModeRemaining], a
	jr .start

.exit
	call RestoreBackupSlotMachineReelStates
	xor a
	ld [wSlotMachineIsBonusPlay], a
	call .SwitchDisplay
	ret

.InitSpins:
	ld a, 30
	call Random
	add 24
	ld [wSlotMachineSpinTimer], a
	xor a
	ld [wNumSlotMachineLandedReels], a
	ld a, 1
	ld [wSlotMachineVBlankCounter], a
	call ReinitSlotMachineReels
	ret

; a = bonus play flag
.SwitchDisplay:
	ld [wSlotMachineIsBonusPlay], a
	add a
	ld c, a
	ld b, $00
	ld hl, .jump_table
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp hl

.jump_table
	dw .Regular
	dw .Bonus

.Regular:
	xor a
	call LoadSlotMachineReels
	call DrawSlotMachineReels
	call LoadSlotMachineTilemap
	ret

.Bonus:
	ld a, TRUE
	call LoadSlotMachineReels
	call DrawSlotMachineReels
	call LoadSlotMachineBonusTilemap
	ret

UpdateSlotMachineHotModeAndBias:
	ld a, [wSlotMachineHotModeRemaining]
	and a
	jr z, .init

; during hot mode
; just decr, keeping current bias
	dec a
	ld [wSlotMachineHotModeRemaining], a
	ret

.init
	call .ProcCheck
	call .SetBias
	ret

; 30% if regular, 90% if bonus
.ProcCheck:
	ld a, [wSlotMachineIsBonusPlay]
	ld c, a
	ld b, $00
	ld hl, .thresholds
	add hl, bc
	ld b, [hl]
	ld a, 100
	call Random
	cp b
	ret nc
; proc
	ld a, MAX_NUM_SLOT_MACHINE_HOT_MODE
	ld [wSlotMachineHotModeRemaining], a
	ret

; calc and set biased symbol
.SetBias:
	ld a, [wSlotMachineIsBonusPlay]
	add a
	ld c, a
	ld b, $00
	ld hl, .bias_lists
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, 100
	call Random
	ld b, a
	ld c, 6
.loop_compare
	ld a, [hli]
	ld e, a
	ld a, [hli]
	cp b
	jr nc, .set
	dec c
	jr nz, .loop_compare
.set
	ld a, e
	ld [wSlotMachineBiasedSymbol], a
	ret

; percent
.thresholds:
	db 30, 90

.bias_lists:
	dw .bias_regular, .bias_bonus

.bias_regular:
	db SLOTMACHINESYMBOL_FIRE,      25 ; 25%
	db SLOTMACHINESYMBOL_LIGHTNING, 50 ; 25%
	db SLOTMACHINESYMBOL_WATER,     75 ; 25%
	db SLOTMACHINESYMBOL_COLORLESS, 90 ; 15%
	db SLOTMACHINESYMBOL_RAINBOW,  100 ; 10%
	db SLOTMACHINESYMBOL_FIRE,       0

.bias_bonus:
	db SLOTMACHINESYMBOL_MONEYBAG,  40 ; 40%
	db SLOTMACHINESYMBOL_UNUSED,    52 ; 12%
	db SLOTMACHINESYMBOL_DRAGONITE, 64 ; 12%
	db SLOTMACHINESYMBOL_ARTICUNO,  76 ; 12%
	db SLOTMACHINESYMBOL_MOLTRES,   88 ; 12%
	db SLOTMACHINESYMBOL_ZAPDOS,   100 ; 12%

; c = reel index
; set offset = -2, and reset flags and tease offset
InitCurSlotMachineReel:
	push af
	push hl
	call GetSlotMachineReelStatePtr
	ld a, SLOT_MACHINE_REEL_OFFSET_LENGTH - 2
	ld [hli], a
	xor a
	ld [hl], a
	pop hl
	pop af
	ret

; set offset = -2, and reset flags and tease offset
InitSlotMachineReels:
	push af
	push bc
	ld c, 0
.loop_init
	call InitCurSlotMachineReel
	inc c
	ld a, c
	cp NUM_SLOT_MACHINE_REELS
	jr nz, .loop_init
	pop bc
	pop af
	ret

; c = reel index
; reset flags and tease offset
ReinitCurSlotMachineReel:
	push af
	push hl
	call GetSlotMachineReelStatePtr
	ld a, [hl]
	and SLOT_MACHINE_REEL_OFFSET_MASK
	ld [hli], a
	xor a
	ld [hl], a
	pop hl
	pop af
	ret

; reset flags and tease offset
ReinitSlotMachineReels:
	push af
	push bc
	ld c, 0
.loop_init
	call ReinitCurSlotMachineReel
	inc c
	ld a, c
	cp NUM_SLOT_MACHINE_REELS
	jr nz, .loop_init
	pop bc
	pop af
	ret

; a = bonus play flag
LoadSlotMachineReels:
	and a
	jr nz, .bonus
; regular
	ld hl, wIndicesSlotMachineLeftReel
	ld de, SlotMachineLeftReelSymbols
	call .LoadReel
	ld hl, wIndicesSlotMachineCenterReel
	ld de, SlotMachineCenterReelSymbols
	call .LoadReel
	ld hl, wIndicesSlotMachineRightReel
	ld de, SlotMachineRightReelSymbols
	call .LoadReel
	ret
.bonus
	ld hl, wIndicesSlotMachineLeftReel
	ld de, SlotMachineBonusLeftReelSymbols
	call .LoadReel
	ld hl, wIndicesSlotMachineCenterReel
	ld de, SlotMachineBonusCenterReelSymbols
	call .LoadReel
	ld hl, wIndicesSlotMachineRightReel
	ld de, SlotMachineBonusRightReelSymbols
	call .LoadReel
	ret

; for n = [0, 19] and k = *ReelSymbols[n] (SLOTMACHINESYMBOL_*),
; write {3k, 3k+1, 3k+2} to wIndices*Reel[n][0:2] (top/mid/bot)
.LoadReel:
	ld c, SLOT_MACHINE_REEL_LENGTH
.loop_symbols
	push bc
	push de
	call .LoadSymbol
	pop de
	pop bc
	inc de
	dec c
	jr nz, .loop_symbols
	ret

; for k = *ReelSymbols[cur] (SLOTMACHINESYMBOL_*),
; write {3k, 3k+1, 3k+2} to wIndices*Reel[cur][0:2] (top/mid/bot)
.LoadSymbol:
	push hl
	ld a, [de]
	ld c, a
	sla c
	add c ; *3
; write extremely verbosely :(
; was the table more complex at some point?
	ld c, a
	ld b, $00
	ld hl, .enumerate_table
	add hl, bc
	ld d, h
	ld e, l
	pop hl
	ld c, NUM_SLOT_MACHINE_SYMBOL_VERT_TILES
.loop_load
	ld a, [de]
	inc de
	ld [hli], a
	dec c
	jr nz, .loop_load
	ret
; just 0 to 32
.enumerate_table
FOR n, NUM_SLOT_MACHINE_SYMBOLS_TILES
	db {d:n}
ENDR

DrawSlotMachineReels:
	ld hl, wSlotMachineReelStates
	ld c, NUM_SLOT_MACHINE_REELS
.loop_reels
	call .DrawReel
	inc hl
	inc hl
	dec c
	jr nz, .loop_reels
	ret

; c = {3, 2, 1} -> {left, center, right} in .coord_table
.DrawReel:
	push bc
	push hl
	ld a, [hl]
	and SLOT_MACHINE_REEL_OFFSET_MASK
	ld e, a
	dec c
	ld b, $00
	sla c
	sla c ; *4
	ld hl, .coord_table
	add hl, bc
	ld a, [hli]
	ld c, a
	ld a, [hli]
	ld b, a
	ld a, [hli]
	ld h, [hl]
	ld l, a
	call .DrawSymbols
	pop hl
	pop bc
	ret

; y, x, source buffer
MACRO slotreel_coord
	db \1, \2
	dw \3
ENDM

.coord_table
	slotreel_coord 5, 14, wIndicesSlotMachineRightReel
	slotreel_coord 5,  8, wIndicesSlotMachineCenterReel
	slotreel_coord 5,  2, wIndicesSlotMachineLeftReel

; bc = coordinates
; e  = reel offset
; hl = wIndices*Reel
; draw [e:e+7] at ([b:b+3], [c:c+7])
.DrawSymbols:
	ld d, $00
	add hl, de
	ld d, SLOT_MACHINE_REEL_VISIBLE_HEIGHT
.loop_rows
	push de
	ld a, [hli]
	ld e, a
	call .DrawSymbolTiles
	pop de
	inc e
	ld a, e
	cp SLOT_MACHINE_REEL_OFFSET_LENGTH
	jr c, .next_row
; wrap
	push bc
	ld bc, -SLOT_MACHINE_REEL_OFFSET_LENGTH
	add hl, bc
	pop bc
	ld e, 0
.next_row
	inc c ; next y
	dec d
	jr nz, .loop_rows
	ret

; bc = coordinates
; e  = wIndices*Reel[q][r] (= 3 * *ReelSymbols[q] + r) for offset = 3q + r
; (e = [0, 32])
; draw .tileset_table[q][r][0:3] at ([b:b+3], c)
.DrawSymbolTiles:
	push af
	push bc
	push de
	push hl
	ld d, 0
REPT 3 ; de << 3
	sla e
	rl d
ENDR
	ld hl, .tileset_table
	add hl, de
	ld a, SLOT_MACHINE_REEL_VISIBLE_WIDTH
.loop_tiles
	push af
	ld a, [hl] ; tile
	add $80
	ld d, a
	pop af
	inc hl
	ld e, [hl] ; attributes
	inc hl
	call .DrawCurSymbolTile
	inc b ; next x
	dec a
	jr nz, .loop_tiles
	pop hl
	pop de
	pop bc
	pop af
	ret

; bc = coordinates
; d = VRAM0 tile index
; e = VRAM1 tile attributes
.DrawCurSymbolTile:
	push af
	xor a ; BANK("VRAM0")
	call BankswitchVRAM
	push bc
	push de
	ld a, d
	call WriteByteToBGMap0
	ld a, BANK("VRAM1")
	call BankswitchVRAM
	pop de
	pop bc
	ld a, e
	call WriteByteToBGMap0
	xor a ; BANK("VRAM0")
	call BankswitchVRAM
	pop af
	ret

; (tile - $80), attributes
MACRO slotsymbol_tileset
	FOR n, 4 ; top left to right
		db \1 + {d:n} + $00, \2
	ENDR
	FOR n, 4 ; mid left to right
		db \1 + {d:n} + $10, \2
	ENDR
	FOR n, 4 ; bot left to right
		db \1 + {d:n} + $20, \2
	ENDR
ENDM

.tileset_table:
	slotsymbol_tileset $74, $d ; SLOTMACHINESYMBOL_FIRE
	slotsymbol_tileset $78, $a ; SLOTMACHINESYMBOL_LIGHTNING
	slotsymbol_tileset $7c, $e ; SLOTMACHINESYMBOL_WATER
	slotsymbol_tileset $a0, $f ; SLOTMACHINESYMBOL_COLORLESS
	slotsymbol_tileset $a4, $b ; SLOTMACHINESYMBOL_RAINBOW
	slotsymbol_tileset $a8, $a ; SLOTMACHINESYMBOL_UNUSED
	slotsymbol_tileset $ac, $d ; SLOTMACHINESYMBOL_MONEYBAG
	slotsymbol_tileset $d0, $e ; SLOTMACHINESYMBOL_DRAGONITE
	slotsymbol_tileset $d4, $e ; SLOTMACHINESYMBOL_ARTICUNO
	slotsymbol_tileset $d8, $c ; SLOTMACHINESYMBOL_MOLTRES
	slotsymbol_tileset $dc, $c ; SLOTMACHINESYMBOL_ZAPDOS

SpinSlotMachineReels:
	ld c, SLOTMACHINE_LEFT_REEL
.loop_reels
	call .SpinReel
	inc c
	ld a, c
	cp NUM_SLOT_MACHINE_REELS
	jr nz, .loop_reels
	ret

; c = reel index
.SpinReel:
	call GetSlotMachineReelStatePtr
	bit SLOT_MACHINE_REEL_LANDED_F, [hl]
	ret nz
	bit SLOT_MACHINE_REEL_LANDING_F, [hl]
	jr nz, .landing

.next_offset
	ld a, [hl]
	and SLOT_MACHINE_REEL_FLAGS_MASK
	ld b, a
	ld a, [hl]
	and SLOT_MACHINE_REEL_OFFSET_MASK
	dec a
	cp -1
	jr nz, .update_offset
; wrap
	ld a, SLOT_MACHINE_REEL_OFFSET_LENGTH - 1
.update_offset
	or b
	ld [hl], a
	ret

.landing
	call .IsSymbolMidTile
	jr nz, .next_offset

; mid tile (offset % 3 = 1)
	inc hl
	ld a, [hld] ; tease offset
	and a
	jr z, .stop

; tease
	ld e, a
	and SLOT_MACHINE_REEL_TEASE_MASK
	dec a
	ld b, a
	ld a, e
	and ~SLOT_MACHINE_REEL_TEASE_MASK
	or b
	inc hl
	ld [hld], a
	jr nz, .next_offset

; no (more) teases
.stop
	res SLOT_MACHINE_REEL_LANDING_F, [hl]
	set SLOT_MACHINE_REEL_LANDED_F, [hl]
	ld b, 0
	call CalculateSlotMachineLandingSymbol
	call StoreSlotMachineLandedSymbol
	push af
	ld a, SFX_SLOT_REEL
	call CallPlaySFX
	pop af
	ret

; set z if offset % 3 = 1
.IsSymbolMidTile:
	ld a, [hl]
	and SLOT_MACHINE_REEL_OFFSET_MASK
FOR n, 1, SLOT_MACHINE_REEL_OFFSET_LENGTH, NUM_SLOT_MACHINE_SYMBOL_VERT_TILES
	cp {d:n}
	ret z
ENDR
	ret

; decr timer
; if already 0, stop the current reel and set the timer for the next reel
UpdateSlotMachineSpinTimer:
	ld a, [wSlotMachineSpinTimer]
	and a
	jr z, .check_prev_reel
	dec a
	ld [wSlotMachineSpinTimer], a
	ret

.check_prev_reel
	ld a, [wNumSlotMachineLandedReels]
	cp NUM_SLOT_MACHINE_REELS
	ret z
	ld a, [wNumSlotMachineLandedReels]
	and a
	jr z, .stop_cur_reel
	ld c, a
	dec c
	call GetSlotMachineReelStatePtr
	bit SLOT_MACHINE_REEL_LANDED_F, [hl]
	ret z

.stop_cur_reel
	ld a, [wNumSlotMachineLandedReels]
	ld c, a
	call SetSlotMachineTeaseOffset
	ld hl, wNumSlotMachineLandedReels
	inc [hl]
	ld a, 30
	call Random
	add 18
	ld [wSlotMachineSpinTimer], a
	ret

; unreferenced
SetSlotMachineTeases:
	ld c, SLOTMACHINE_LEFT_REEL
.loop_reels
	call SetSlotMachineTeaseOffset
	inc c
	ld a, c
	cp NUM_SLOT_MACHINE_REELS
	jr nz, .loop_reels
	ret

; c = reel index
; set SLOT_MACHINE_REEL_LANDING_F,
; and calculate and set tease offset
SetSlotMachineTeaseOffset:
	call GetSlotMachineReelStatePtr
	set SLOT_MACHINE_REEL_LANDING_F, [hl]
	call .JumpToList
	ret

; c = reel index
.JumpToList:
	ld e, c
	sla e
	ld d, $00
	ld hl, .jump_table
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp hl

.jump_table:
	dw .Left
	dw .Center
	dw .Right

.Left:
	ld a, [wSlotMachineHotModeRemaining]
	and a
	jr nz, .hot_mode
	jr .regular_left_center

.Center:
	ld a, [wSlotMachineHotModeRemaining]
	and a
	jr nz, .hot_mode
	jr .regular_left_center

.Right:
	ld a, [wSlotMachineHotModeRemaining]
	and a
	jr nz, .hot_mode_right
	call .CheckLeftAndCenter
	jr z, .leading_pair
	jr .right_already_whiffed

.hot_mode_right
	call .CheckLeftAndCenter
	jr z, .hot_mode_leading_pair
	jr .hot_mode

.CheckLeftAndCenter:
	push bc
	ld b, 0
	ld c, SLOTMACHINE_LEFT_REEL
	call CalculateSlotMachineLandingSymbol
	ld e, a
	ld c, SLOTMACHINE_CENTER_REEL
	call CalculateSlotMachineLandingSymbol
	cp e
	pop bc
	ret

; zero out tease offset
.right_already_whiffed
	call GetSlotMachineReelStatePtr
	inc hl
	xor a
	ld [hl], a
	ret

; set tease offset = rand[0, 3]
.regular_left_center
	call GetSlotMachineReelStatePtr
	inc hl
	ld a, 4
	call Random
	ld [hl], a
	ret

; set tease offset = (distance + 1) % 5
.hot_mode
	call GetSlotMachineReelStatePtr
	inc hl
	ld a, [wSlotMachineBiasedSymbol]
	call .CalculateDistanceToBias
	ld c, 5
	call DivModC
	ld [hl], a
	ret

; unreferenced
; set tease offset = (distance + 1) % 4
.asm_1295f
	call GetSlotMachineReelStatePtr
	inc hl
	ld a, [wSlotMachineBiasedSymbol]
	call .CalculateDistanceToBias
	inc a
	ld c, 4
	call DivModC
	ld [hl], a
	ret

; set tease offset = ((distance + 1) % 5) + 20
.hot_mode_leading_pair
	call GetSlotMachineReelStatePtr
	inc hl
	ld a, [wSlotMachineBiasedSymbol]
	call .CalculateDistanceToBias
	ld c, 5
	call DivModC
	add 20
	ld [hl], a
	ld a, 3
	ld [wSlotMachineVBlankCounter], a
	ret

; set tease offset = ((distance + 1) % 4) + 20
.leading_pair
	call GetSlotMachineReelStatePtr
	inc hl
	ld a, [wSlotMachineBiasedSymbol]
	call .CalculateDistanceToBias
	inc a
	ld c, 4
	call DivModC
	add 20
	ld [hl], a
	ld a, 3
	ld [wSlotMachineVBlankCounter], a
	ret

; a = biased symbol
; for n = additional cycles required to land it
; (or 50 if biased towards SLOTMACHINESYMBOL_UNUSED; 3n in offset),
; return a = n + 1
.CalculateDistanceToBias:
	push bc
	push de
	ld e, a
	ld b, 0
	ld d, 50
.loop_calc
	call CalculateSlotMachineLandingSymbol
	cp e
	jr z, .got_distance
	inc b
	dec d
	jr nz, .loop_calc

.got_distance
	ld a, b
	inc a
	pop de
	pop bc
	ret

; set carry if all reels have stopped
AreAllSlotMachineReelsStopped:
	scf
	ccf
	ld hl, wSlotMachineReelStates
	ld c, NUM_SLOT_MACHINE_REELS
.loop_reels
	bit SLOT_MACHINE_REEL_LANDED_F, [hl]
	jr z, .done
	inc hl
	inc hl
	dec c
	jr nz, .loop_reels
	scf
.done
	ret

HandleSlotMachineBetting:
	call TurnOnCurChipsHUD
	call HideNPCAnimsUnderDialogBox
	call .PrintDialog
	ld a, 60
	ld [wSlotMachineDelayFrames], a
.wait_input
	call DoFrame
	call UpdateRNGSources
	jr c, .start_bet
	ldh a, [hKeysPressed]
	and PAD_B
	jr nz, .cancel
	ldh a, [hKeysPressed]
	and PAD_DOWN
	jr nz, .start_bet
	jr .wait_input

.start_bet
	call .Bet
	jr c, .wait_input

	ld a, 20
	call DoAFrames_WithPreCheck
	jr .done

.cancel
	scf
.done
	call ShowNPCAnimsUnderDialogBox
	call TurnOffCurChipsHUD
	ret

.PrintDialog:
	lb de, 0, 12
	lb bc, 20, 6
	call DrawRegularTextBoxVRAM0
	ldtx hl, GameCenterSlotMachineDialogText
	lb de, 1, 14
	call InitTextPrinting_ProcessTextFromIDVRAM0
	ret

.Bet:
	call GetGameCenterChips
	ld a, [wSlotMachineBets]
	ld e, a
	ld d, $00
	call CompareBCAndDE
	jr c, .not_enough_chips
	ld a, [wSlotMachineBets]
	ld c, a
	ld b, $00
	call DecreaseChipsSmoothly
	ld a, 4
	call DoAFrames_WithPreCheck
	scf
	ccf
	ret

.not_enough_chips
	push af
	ld a, SFX_DENIED
	call CallPlaySFX
	pop af
	scf
	ret

; debug? unreferenced
Func_12a3d:
	ldh a, [hKeysPressed]
	and PAD_SELECT
	ret z
	push af
	ld a, SFX_NEW_MAIL
	call CallPlaySFX
	pop af
	ld a, [wSlotMachineDebugFlag]
	xor $ff
	ld [wSlotMachineDebugFlag], a
	ld a, 60
	ld [wSlotMachineDelayFrames], a
	ret

; debug? unreferenced
Func_12a57:
	scf
	ccf
	ld a, [wSlotMachineDebugFlag]
	and a
	ret z
	ld a, [wSlotMachineDelayFrames]
	and a
	ret z
	dec a
	ld [wSlotMachineDelayFrames], a
	ret nz
	scf
	ret

; single-line machine
; set carry if hit
CheckSlotMachinePayline:
	ld c, SLOTMACHINE_LEFT_REEL
	call GetStoredSlotMachineLandedSymbol
	ld b, a
.loop_reels
	call GetStoredSlotMachineLandedSymbol
	cp b
	jr nz, .whiff
	inc c
	ld a, c
	cp NUM_SLOT_MACHINE_REELS
	jr c, .loop_reels

; hit
	scf
	ret

.whiff
	scf
	ccf
	ret

; c = reel index
GetStoredSlotMachineLandedSymbol:
	push bc
	push hl
	ld b, $00
	ld hl, wSlotMachineLandedSymbols
	add hl, bc
	ld a, [hl]
	pop hl
	pop bc
	ret

; c = reel index
StoreSlotMachineLandedSymbol:
	push bc
	push hl
	ld b, $00
	ld hl, wSlotMachineLandedSymbols
	add hl, bc
	ld [hl], a
	pop hl
	pop bc
	ret

; c = reel index
; b = cycles
; for input offset = 3q + r,
; return a = symbol at new offset = (3*(q-b) + r + 2) % 60
CalculateSlotMachineLandingSymbol:
	push bc
	push de
	push hl
	call GetSlotMachineReelStatePtr
	call GetSlotMachineReelSymbolIndicesPtr
	ld a, [hl]
	and SLOT_MACHINE_REEL_OFFSET_MASK
	add 2
REPT NUM_SLOT_MACHINE_SYMBOL_VERT_TILES
	sub b
ENDR
; mod 60
	bit 7, a
	jr z, .wrap_offset
	add SLOT_MACHINE_REEL_OFFSET_LENGTH
.wrap_offset
	cp SLOT_MACHINE_REEL_OFFSET_LENGTH
	jr c, .get_symbol
	sub SLOT_MACHINE_REEL_OFFSET_LENGTH
.get_symbol
	ld c, a ; updated offset
	ld b, $00
	ld h, d
	ld l, e
	add hl, bc
	ld a, [hl]
	ld c, NUM_SLOT_MACHINE_SYMBOL_VERT_TILES
	call DivModC
	ld a, b ; SLOTMACHINESYMBOL_*
	pop hl
	pop de
	pop bc
	ret

HandleSlotMachinePayouts:
	call .PaylineAnim
	ld c, SLOTMACHINE_LEFT_REEL
	call GetStoredSlotMachineLandedSymbol
	add a
	ld c, a
	ld b, $00
	ld hl, .jump_table
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp hl

.jump_table
	dw .SmallHit     ; SLOTMACHINESYMBOL_FIRE
	dw .SmallHit     ; SLOTMACHINESYMBOL_LIGHTNING
	dw .SmallHit     ; SLOTMACHINESYMBOL_WATER
	dw .BigHit       ; SLOTMACHINESYMBOL_COLORLESS
	dw .BonusHit     ; SLOTMACHINESYMBOL_RAINBOW
	dw .LegendaryHit ; SLOTMACHINESYMBOL_UNUSED
	dw .MoneybagHit  ; SLOTMACHINESYMBOL_MONEYBAG
	dw .LegendaryHit ; SLOTMACHINESYMBOL_DRAGONITE
	dw .LegendaryHit ; SLOTMACHINESYMBOL_ARTICUNO
	dw .LegendaryHit ; SLOTMACHINESYMBOL_MOLTRES
	dw .LegendaryHit ; SLOTMACHINESYMBOL_ZAPDOS

.PaylineAnim:
	call CallClearSpriteAnims
	call CreateSlotMachinePaylineAnimation
	ld a, 40
	call DoAFrames_WithPreCheck
	ret

.SmallHit:
	call CreateSlotMachineHitAnimation
	push af
	ld a, SFX_SLOT_SMALL_HIT
	call CallPlaySFX
	pop af
	ld a, 70
	call DoAFrames_WithPreCheck
	call .Payout
	call CallClearSpriteAnims
	ret

.BigHit:
	call CreateSlotMachineHitAnimation
	push af
	ld a, SFX_SLOT_BIG_HIT
	call CallPlaySFX
	pop af
	ld a, 70
	call DoAFrames_WithPreCheck
	call .Payout
	call CallClearSpriteAnims
	ret

.BonusHit:
	call CallClearSpriteAnims
	call CreateSlotMachineBonusAnimation
	push af
	ld a, SFX_SLOT_BONUS_HIT
	call CallPlaySFX
	pop af
	ld a, 70
	call DoAFrames_WithPreCheck
	call CallClearSpriteAnims
	call SlotMachineBonusPlay
	ret

; bug: prize is always BOOSTER_PRESENT_10_ENERGY
;   base "payout" is [0, 4] (meant for index?),
;   but payout value in bc is (base) * (chips per play) anyway (< 256),
;   and ld a, b (offset from BOOSTERS_PRESENT_START) always becomes ld a, 0
.LegendaryHit:
	call CreateSlotMachineBoosterPrizeAnimation
	push af
	ld a, SFX_SLOT_BONUS_HIT
	call CallPlaySFX
	pop af
	ld a, 70
	call DoAFrames_WithPreCheck
	call CallClearSpriteAnims
	call HideNPCAnimsUnderDialogBox
	ldtx hl, GameCenterSlotMachineBonusPlayLegendaryHitText
	call PrintSlotMachineBonusPlayDialog
	call ShowNPCAnimsUnderDialogBox
	ld a, [wSlotMachineDebugFlag]
	and a
	jr nz, .debug_skip_boosters
	call .CalculatePayout
	ld a, b ; always 0
	call .BoosterPrize
.debug_skip_boosters
	xor a
	ld [wSlotMachineBonusPlaysRemaining], a
	ret

.MoneybagHit:
	call CreateSlotMachineHitAnimation
	push af
	ld a, SFX_SLOT_BONUS_HIT
	call CallPlaySFX
	pop af
	ld a, 70
	call DoAFrames_WithPreCheck
	call CallClearSpriteAnims
	call HideNPCAnimsUnderDialogBox
	call .CalculatePayout
	call LoadTxRam3
	ldtx hl, GameCenterSlotMachineBonusPlayMoneybagHitText
	call PrintTextInWideTextBox
	call .Payout
	ld a, [wSlotMachineDebugFlag]
	and a
	jr nz, .debug_skip_pad_input
	call WaitForWideTextBoxInput
.debug_skip_pad_input
	call TurnOffCurChipsHUD
	call ShowNPCAnimsUnderDialogBox
	xor a
	ld [wSlotMachineBonusPlaysRemaining], a
	ret

.Payout:
	call TurnOnCurChipsHUD
	call .CalculatePayout
	call IncreaseChipsSmoothly
	ld a, 30
	call DoAFrames_WithPreCheck
	ret

; return bc = payout
.CalculatePayout:
	push af
	ld c, SLOTMACHINE_LEFT_REEL
	call GetStoredSlotMachineLandedSymbol
	ld c, a
	ld b, $00
	ld hl, .base_payouts
	add hl, bc
	ld h, [hl]
	ld a, [wSlotMachineBets]
	ld l, a
	call HtimesL
	ld b, h
	ld c, l
	pop af
	ret

.base_payouts
	db   2 ; SLOTMACHINESYMBOL_FIRE
	db   3 ; SLOTMACHINESYMBOL_LIGHTNING
	db   4 ; SLOTMACHINESYMBOL_WATER
	db  20 ; SLOTMACHINESYMBOL_COLORLESS
	db  10 ; SLOTMACHINESYMBOL_RAINBOW
	db   0 ; SLOTMACHINESYMBOL_UNUSED
	db 100 ; SLOTMACHINESYMBOL_MONEYBAG
	db   1 ; SLOTMACHINESYMBOL_DRAGONITE
	db   2 ; SLOTMACHINESYMBOL_ARTICUNO
	db   3 ; SLOTMACHINESYMBOL_MOLTRES
	db   4 ; SLOTMACHINESYMBOL_ZAPDOS

; a = offset from BOOSTERS_PRESENT_START
; bug: input is always 0, giving BOOSTER_PRESENT_10_ENERGY
.BoosterPrize:
	farcall StartFadeToWhite
	farcall WaitPalFading_Bank07
	ld [wSlotMachineBonusBoosterOffset], a
	ld a, [wSlotMachineBets]
	ld c, a
	ld b, $00
	ld hl, .boooster_amount_table
	add hl, bc
	ld c, [hl]
	ld b, 0
.loop_give_booster
	ld a, [wSlotMachineBonusBoosterOffset]
	add BOOSTERS_PRESENT_START
	farcall GiveBoosterPacks
	inc b
	dec c
	jr nz, .loop_give_booster
	call ClearSpriteAnimsAndSetInitialGraphicsConfiguration
	call DrawSlotMachine
	farcall StartFadeFromWhite
	farcall WaitPalFading_Bank07
	ret

.boooster_amount_table
	db 0 ; unused
	db 1 ; bet 1
	db 1 ; unused
	db 2 ; unused
	db 2 ; unused
	db 3 ; bet 5

; debug? unreferenced
Func_12c17:
	ld hl, .pointer_table
	ld c, 0
.loop_presets
	ld a, [hl]
	cp $ff
	jr z, .not_found
	push hl
	ld a, [hli]
	ld h, [hl]
	ld l, a
	call .Validate
	pop hl
	inc hl
	inc hl
	inc c
	jr nc, .loop_presets
; matched
	dec c
	ld a, c
	scf
	ret
.not_found
	ld a, $ff
	scf
	ccf
	ret

.Validate:
	ld a, [hl]
	cp $ff
	jr z, .all_matched
	ld c, [hl]
	inc hl
	ld b, [hl]
	inc hl
	call CalculateSlotMachineLandingSymbol
	ld b, [hl]
	inc hl
	cp b
	jr z, .Validate
; mismatched
	scf
	ccf
	ret
.all_matched
	scf
	ret

.pointer_table
	dw .table0
	dw .table1
	dw .table2
	dw .table3
	dw .table4
	dw .table5
	dw .table6
	dw $ffff ; end

.table0
	db SLOTMACHINE_LEFT_REEL,    0, SLOTMACHINESYMBOL_FIRE
	db SLOTMACHINE_CENTER_REEL,  3, SLOTMACHINESYMBOL_FIRE
	db SLOTMACHINE_CENTER_REEL, 57, SLOTMACHINESYMBOL_FIRE
	db SLOTMACHINE_RIGHT_REEL,   0, SLOTMACHINESYMBOL_FIRE
	db $ff

.table1
	db SLOTMACHINE_LEFT_REEL,   0, SLOTMACHINESYMBOL_FIRE
	db SLOTMACHINE_CENTER_REEL, 0, SLOTMACHINESYMBOL_WATER
	db SLOTMACHINE_RIGHT_REEL,  0, SLOTMACHINESYMBOL_LIGHTNING
	db $ff

.table2
	db SLOTMACHINE_CENTER_REEL,  3, SLOTMACHINESYMBOL_FIRE
	db SLOTMACHINE_LEFT_REEL,   57, SLOTMACHINESYMBOL_FIRE
	db SLOTMACHINE_CENTER_REEL, 57, SLOTMACHINESYMBOL_FIRE
	db SLOTMACHINE_RIGHT_REEL,  57, SLOTMACHINESYMBOL_FIRE
	db $ff

.table3
	db SLOTMACHINE_LEFT_REEL,   3, SLOTMACHINESYMBOL_FIRE
	db SLOTMACHINE_CENTER_REEL, 0, SLOTMACHINESYMBOL_FIRE
	db SLOTMACHINE_RIGHT_REEL, 57, SLOTMACHINESYMBOL_FIRE
	db $ff

.table4
	db SLOTMACHINE_LEFT_REEL,   3, SLOTMACHINESYMBOL_WATER
	db SLOTMACHINE_CENTER_REEL, 0, SLOTMACHINESYMBOL_WATER
	db SLOTMACHINE_RIGHT_REEL,  3, SLOTMACHINESYMBOL_WATER
	db $ff

.table5
	db SLOTMACHINE_LEFT_REEL,   0, SLOTMACHINESYMBOL_WATER
	db SLOTMACHINE_CENTER_REEL, 0, SLOTMACHINESYMBOL_FIRE
	db SLOTMACHINE_CENTER_REEL, 0, SLOTMACHINESYMBOL_RAINBOW
	db $ff

.table6
	db SLOTMACHINE_CENTER_REEL,  3, SLOTMACHINESYMBOL_FIRE
	db SLOTMACHINE_RIGHT_REEL,   3, SLOTMACHINESYMBOL_FIRE
	db SLOTMACHINE_CENTER_REEL,  0, SLOTMACHINESYMBOL_WATER
	db SLOTMACHINE_RIGHT_REEL,   0, SLOTMACHINESYMBOL_WATER
	db SLOTMACHINE_CENTER_REEL, 57, SLOTMACHINESYMBOL_LIGHTNING
	db SLOTMACHINE_RIGHT_REEL,  57, SLOTMACHINESYMBOL_LIGHTNING
	db $ff

; c = reel index
; return hl = ptr to wSlotMachineReelStates[c]
GetSlotMachineReelStatePtr:
	push bc
	sla c
	ld b, $00
	ld hl, wSlotMachineReelStates
	add hl, bc
	pop bc
	ret

; c = reel index
; return de = ptr to wIndicesSlotMachine*Reel
GetSlotMachineReelSymbolIndicesPtr:
	push bc
	push hl
	ld b, $00
REPT 6 ; bc << 6
	sla c
	rl b
ENDR
	ld hl, wIndicesSlotMachineReels
	add hl, bc
	ld d, h
	ld e, l
	pop hl
	pop bc
	ret

BackupSlotMachineReelStates:
	ld hl, wSlotMachineReelStates
	ld de, wBackupSlotMachineReelStates
	ld bc, 2 * NUM_SLOT_MACHINE_REELS
	call CopyBCBytesFromHLToDE
	ret

RestoreBackupSlotMachineReelStates:
	ld hl, wBackupSlotMachineReelStates
	ld de, wSlotMachineReelStates
	ld bc, 2 * NUM_SLOT_MACHINE_REELS
	call CopyBCBytesFromHLToDE
	ret

PrintSlotMachineBonusPlayCounter:
	lb de, 8, 15
	lb bc, 4, 1
	call FillBoxInBGMapWithZero
	ld a, [wSlotMachineBonusPlaysRemaining]
	ld l, a
	ld h, $00
	lb de, 9, 15
	ld a, 2
	ld b, FALSE
	farcall PrintNumber
	ret

DrawSlotMachine:
	ld b, BANK(.BGGraphics)
	ld hl, .BGGraphics
	ld de, $0
	ld c, $02
	call LoadBGGraphics
	call DrawSlotMachineReels
	call PrintSlotMachineBonusPlayCounter
	ret

.BGGraphics:
	dw TILESET_SLOTS_BG_ICONS, PALETTE_16D, TILEMAP_227

LoadSlotMachineBonusTilemap:
	ld bc, TILEMAP_228
	lb de, 2, 0
	call LoadAttrmap
	ret

LoadSlotMachineTilemap:
	ld bc, TILEMAP_229
	lb de, 2, 0
	call LoadAttrmap
	ret

CreateSlotMachinePaylineAnimation:
	ld b, BANK(.SpriteAnimGfxParams)
	ld hl, .SpriteAnimGfxParams
	lb de, 88, 88
	ld a, $ff
	ld c, $00
	call CreateSpriteAnim
	call FlushAllPalettes
	ret

.SpriteAnimGfxParams:
	dw TILESET_SLOTS_MESSAGES, SPRITE_ANIM_9E, FRAMESET_166, PALETTE_16E

CreateSlotMachineChanceAnimation:
	ld b, BANK(.SpriteAnimGfxParams)
	ld hl, .SpriteAnimGfxParams
	lb de, 88, 88
	ld a, $ff
	ld c, $00
	call CreateSpriteAnim
	call FlushAllPalettes
	ret

.SpriteAnimGfxParams:
	dw TILESET_SLOTS_MESSAGES, SPRITE_ANIM_9F, FRAMESET_167, PALETTE_16E

CreateSlotMachineBonusAnimation:
	ld b, BANK(.SpriteAnimGfxParams)
	ld hl, .SpriteAnimGfxParams
	lb de, 88, 88
	ld a, $ff
	ld c, $00
	call CreateSpriteAnim
	call FlushAllPalettes
	ret

.SpriteAnimGfxParams:
	dw TILESET_SLOTS_MESSAGES, SPRITE_ANIM_A0, FRAMESET_168, PALETTE_16E

CreateSlotMachineHitAnimation:
	ld b, BANK(.SpriteAnimGfxParams)
	ld hl, .SpriteAnimGfxParams
	lb de, 88, 88
	ld a, $ff
	ld c, $00
	call CreateSpriteAnim
	call FlushAllPalettes
	ret

.SpriteAnimGfxParams:
	dw TILESET_SLOTS_MESSAGES, SPRITE_ANIM_A1, FRAMESET_169, PALETTE_16E

CreateSlotMachineBoosterPrizeAnimation:
	ld b, BANK(.SpriteAnimGfxParams)
	ld hl, .SpriteAnimGfxParams
	lb de, 88, 88
	ld a, $ff
	ld c, $00
	call CreateSpriteAnim
	call FlushAllPalettes
	ret

.SpriteAnimGfxParams:
	dw TILESET_SLOTS_MESSAGES, SPRITE_ANIM_A2, FRAMESET_16A, PALETTE_16E

CallClearSpriteAnims:
	call ClearSpriteAnims
	ret

; hl = text
PrintSlotMachineBonusPlayDialog:
	call PrintTextInWideTextBox
	ld a, [wSlotMachineDebugFlag]
	and a
	jr z, .debug_wait_pad_input
	ld a, 30
	call DoAFrames_WithPreCheck
	ret
.debug_wait_pad_input
	call WaitForWideTextBoxInput
	ret

; unreferenced
SlotMachineReels:
	dw SlotMachineLeftReelSymbols
	dw SlotMachineCenterReelSymbols
	dw SlotMachineRightReelSymbols
	dw SlotMachineBonusLeftReelSymbols
	dw SlotMachineBonusCenterReelSymbols
	dw SlotMachineBonusRightReelSymbols

SlotMachineLeftReelSymbols:
	db SLOTMACHINESYMBOL_RAINBOW
	db SLOTMACHINESYMBOL_FIRE
	db SLOTMACHINESYMBOL_LIGHTNING
	db SLOTMACHINESYMBOL_COLORLESS
	db SLOTMACHINESYMBOL_WATER
	db SLOTMACHINESYMBOL_FIRE
	db SLOTMACHINESYMBOL_LIGHTNING
	db SLOTMACHINESYMBOL_WATER
	db SLOTMACHINESYMBOL_FIRE
	db SLOTMACHINESYMBOL_COLORLESS
	db SLOTMACHINESYMBOL_RAINBOW
	db SLOTMACHINESYMBOL_LIGHTNING
	db SLOTMACHINESYMBOL_WATER
	db SLOTMACHINESYMBOL_COLORLESS
	db SLOTMACHINESYMBOL_FIRE
	db SLOTMACHINESYMBOL_LIGHTNING
	db SLOTMACHINESYMBOL_WATER
	db SLOTMACHINESYMBOL_FIRE
	db SLOTMACHINESYMBOL_LIGHTNING
	db SLOTMACHINESYMBOL_COLORLESS

SlotMachineCenterReelSymbols:
	db SLOTMACHINESYMBOL_RAINBOW
	db SLOTMACHINESYMBOL_WATER
	db SLOTMACHINESYMBOL_LIGHTNING
	db SLOTMACHINESYMBOL_FIRE
	db SLOTMACHINESYMBOL_WATER
	db SLOTMACHINESYMBOL_COLORLESS
	db SLOTMACHINESYMBOL_LIGHTNING
	db SLOTMACHINESYMBOL_FIRE
	db SLOTMACHINESYMBOL_COLORLESS
	db SLOTMACHINESYMBOL_FIRE
	db SLOTMACHINESYMBOL_RAINBOW
	db SLOTMACHINESYMBOL_LIGHTNING
	db SLOTMACHINESYMBOL_FIRE
	db SLOTMACHINESYMBOL_WATER
	db SLOTMACHINESYMBOL_LIGHTNING
	db SLOTMACHINESYMBOL_COLORLESS
	db SLOTMACHINESYMBOL_FIRE
	db SLOTMACHINESYMBOL_WATER
	db SLOTMACHINESYMBOL_COLORLESS
	db SLOTMACHINESYMBOL_LIGHTNING

SlotMachineRightReelSymbols:
	db SLOTMACHINESYMBOL_RAINBOW
	db SLOTMACHINESYMBOL_COLORLESS
	db SLOTMACHINESYMBOL_FIRE
	db SLOTMACHINESYMBOL_WATER
	db SLOTMACHINESYMBOL_LIGHTNING
	db SLOTMACHINESYMBOL_FIRE
	db SLOTMACHINESYMBOL_LIGHTNING
	db SLOTMACHINESYMBOL_COLORLESS
	db SLOTMACHINESYMBOL_WATER
	db SLOTMACHINESYMBOL_FIRE
	db SLOTMACHINESYMBOL_RAINBOW
	db SLOTMACHINESYMBOL_COLORLESS
	db SLOTMACHINESYMBOL_WATER
	db SLOTMACHINESYMBOL_LIGHTNING
	db SLOTMACHINESYMBOL_FIRE
	db SLOTMACHINESYMBOL_WATER
	db SLOTMACHINESYMBOL_LIGHTNING
	db SLOTMACHINESYMBOL_COLORLESS
	db SLOTMACHINESYMBOL_LIGHTNING
	db SLOTMACHINESYMBOL_FIRE

SlotMachineBonusLeftReelSymbols:
REPT 2
	db SLOTMACHINESYMBOL_DRAGONITE
	db SLOTMACHINESYMBOL_MOLTRES
	db SLOTMACHINESYMBOL_MONEYBAG
	db SLOTMACHINESYMBOL_MONEYBAG
	db SLOTMACHINESYMBOL_MONEYBAG
	db SLOTMACHINESYMBOL_ZAPDOS
	db SLOTMACHINESYMBOL_ARTICUNO
	db SLOTMACHINESYMBOL_MONEYBAG
	db SLOTMACHINESYMBOL_MONEYBAG
	db SLOTMACHINESYMBOL_MONEYBAG
ENDR

SlotMachineBonusCenterReelSymbols:
REPT 2
	db SLOTMACHINESYMBOL_DRAGONITE
	db SLOTMACHINESYMBOL_MONEYBAG
	db SLOTMACHINESYMBOL_MOLTRES
	db SLOTMACHINESYMBOL_MONEYBAG
	db SLOTMACHINESYMBOL_ZAPDOS
	db SLOTMACHINESYMBOL_MONEYBAG
	db SLOTMACHINESYMBOL_ARTICUNO
	db SLOTMACHINESYMBOL_MONEYBAG
	db SLOTMACHINESYMBOL_MONEYBAG
	db SLOTMACHINESYMBOL_MONEYBAG
ENDR

SlotMachineBonusRightReelSymbols:
REPT 2
	db SLOTMACHINESYMBOL_DRAGONITE
	db SLOTMACHINESYMBOL_MOLTRES
	db SLOTMACHINESYMBOL_ZAPDOS
	db SLOTMACHINESYMBOL_ARTICUNO
	db SLOTMACHINESYMBOL_MONEYBAG
	db SLOTMACHINESYMBOL_MONEYBAG
	db SLOTMACHINESYMBOL_MONEYBAG
	db SLOTMACHINESYMBOL_MONEYBAG
	db SLOTMACHINESYMBOL_MONEYBAG
	db SLOTMACHINESYMBOL_MONEYBAG
ENDR

	ret ; stray ret
