; timer interrupt handler
TimerHandler:
	push af
	push hl
	push de
	push bc
	ei
	call SerialTimerHandler
	ldh a, [rWBK]
	push af
	ld a, $1
	ldh [rWBK], a
	; only trigger every fourth interrupt ≈ 60.24 Hz
	ld hl, wTimerCounter
	ld a, [hl]
	inc [hl]
	and $3
	jr nz, .done
	; increment the 60-60-60-255-255 counter
	call IncrementPlayTimeCounter
	; check in-timer flag
	ld hl, wReentrancyFlag
	bit IN_TIMER, [hl]
	jr nz, .done
	set IN_TIMER, [hl]
	ldh a, [hBankROM]
	push af
	ld a, BANK(SoundTimerHandler)
	call BankswitchROM
	call SoundTimerHandler
	pop af
	call BankswitchROM
	; clear in-timer flag
	ld hl, wReentrancyFlag
	res IN_TIMER, [hl]
.done
	pop af
	ldh [rWBK], a
	pop bc
	pop de
	pop hl
	pop af
	reti

; increment play time counter by a tick
IncrementPlayTimeCounter:
	ld a, [wPlayTimeCounterEnable]
	or a
	ret z
	ld hl, wPlayTimeCounter
	inc [hl]
	ld a, [hl]
	cp 60
	ret c
	ld [hl], $0
	inc hl
	inc [hl]
	ld a, [hl]
	cp 60
	ret c
	ld [hl], $0
	inc hl
	inc [hl]
	ld a, [hl]
	cp 60
	ret c
	ld [hl], $0
	inc hl
	inc [hl]
	ret nz
	inc hl
	inc [hl]
	ret

; setup timer to 16384/68 ≈ 240.94 Hz
SetupTimer:
	push bc
	ld b, -68 ; Value for Normal Speed
	ldh a, [rSPD]
	and SPD_DOUBLE
	jr z, .set_timer
	ld b, LOW(-68 * 2) ; Value for CGB Double Speed
.set_timer
	ld a, b
	ldh [rTMA], a
	ld a, TAC_STOP | TAC_16KHZ
	ldh [rTAC], a
	ld a, TAC_START | TAC_16KHZ
	ldh [rTAC], a
	pop bc
	ret
