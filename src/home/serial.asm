; called at roughly 240Hz by TimerHandler
SerialTimerHandler:
	ld a, [wSerialOp]
	cp SERIAL_OP_MASTER_TCG2
	jr z, .begin_transfer
	cp SERIAL_PEER_MASTER_TCG2
	jr z, .check_for_timeout
	ret
.begin_transfer
	ldh a, [rSC]         ;
	add a                ; make sure that no serial transfer is active
	ret c                ;
	ld a, SC_INTERNAL
	ldh [rSC], a         ; use internal clock
	ld a, SC_START | SC_INTERNAL
	ldh [rSC], a         ; use internal clock, set transfer start flag
	ret
.check_for_timeout
	; sets bit7 of [wSerialFlags] if the serial interrupt hasn't triggered
	; within four timer interrupts (60Hz)
	ld a, [wSerialCounter]
	ld hl, wSerialCounter2
	cp [hl]
	ld [hl], a
	ld hl, wSerialTimeoutCounter
	jr nz, .clear_timeout_counter
	inc [hl]
	ld a, [hl]
	cp 4
	ret c
	ld hl, wSerialFlags
	set 7, [hl]
	ret
.clear_timeout_counter
	ld [hl], 0
	ret

; tcg1: Func_0cc5
Serial_Func_0be6::
	ld hl, wSerialRecvCounter
	or a
	jr nz, .input_nonzero
; input a = 0
	ld a, [hl]
	or a
	ret z
; wSerialRecvCounter exists
	ld [hl], 0
	ld a, [wSerialRecvBuf]
	ld e, SERIAL_PEER_MASTER_TCG2
	cp SERIAL_OP_MASTER_TCG2
	jr z, .received_peer
	xor a
	scf
	ret

.input_nonzero
	ld a, SERIAL_OP_MASTER_TCG2
	ldh [rSB], a
	ld a, SC_INTERNAL
	ldh [rSC], a
	ld a, SC_START | SC_INTERNAL
	ldh [rSC], a
.zero_loop
	ld a, [hl]
	or a
	jr z, .zero_loop
	ld [hl], 0
	ld a, [wSerialRecvBuf]
	ld e, SERIAL_OP_MASTER_TCG2
	cp SERIAL_PEER_MASTER_TCG2
	jr z, .received_peer
	xor a
	scf
	ret

.received_peer
	xor a
	ld [wSerialSendBufIndex], a
	ld [wcb80], a
	ld [wSerialSendBufToggle], a
	ld [wSerialSendSave], a
	ld [wcba3], a
	ld [wSerialRecvIndex], a
	ld [wSerialRecvCounter], a
	ld [wSerialLastReadCA], a
	ld a, e
	cp SERIAL_OP_MASTER_TCG2
	jr nz, .got_mode
	ld bc, $1000
.countdown_loop
	dec bc
	ld a, c
	or b
	jr nz, .countdown_loop
	ld a, e
.got_mode
	ld [wSerialOp], a
	scf
	ret

SerialHandler:
	push af
	push hl
	push de
	push bc
	ld a, [wPrinterPacketSequence] ;
	or a                           ;
	jr z, .not_printer_sequence    ; if [wPrinterPacketSequence] nonzero:
	call ExecutePrinterPacketSequence
	jr .done                       ; return
.not_printer_sequence
	ld a, [wSerialOp]    ;
	or a                 ;
	jr z, .asm_d55       ; skip ahead if [wSerialOp] zero
	; send/receive a byte
	ldh a, [rSB]
	call SerialHandleRecv
	call SerialHandleSend ; returns byte to actually send
	push af
.wait_for_completion
	ldh a, [rSC]
	add a
	jr c, .wait_for_completion
	pop af
	; end send/receive
	ldh [rSB], a         ; prepare sending byte (from Func_0dc8?)
	ld a, [wSerialOp]
	cp SERIAL_OP_MASTER_TCG2
	jr z, .done          ; if [wSerialOp] != $92, use external clock
	jr .asm_d6a          ; and prepare for next byte. either way, return
.asm_d55
	ld a, $1
	ld [wSerialRecvCounter], a
	ldh a, [rSB]
	ld [wSerialRecvBuf], a
	ld a, $ac
	ldh [rSB], a
	ld a, [wSerialRecvBuf]
	cp SERIAL_PEER_MASTER_TCG2 ; if [wSerialRecvBuf] != $21, use external clock
	jr z, .done                ; and prepare for next byte. either way, return
.asm_d6a
	ld a, SC_START | SC_EXTERNAL
	ldh [rSC], a         ; transfer start, use external clock
.done
	ld hl, wSerialCounter
	inc [hl]
	pop bc
	pop de
	pop hl
	pop af
	reti

; handles a byte read from serial transfer by decoding it and storing it into
; the receive buffer
SerialHandleRecv:
	ld hl, wSerialLastReadCA
	ld e, [hl]
	dec e
	jr z, .last_was_ca
	cp $ac
	ret z ; return if read_data == $ac
	cp $ca
	jr z, .read_ca
	or a
	jr z, .read_00_or_ff
	cp $ff
	jr nz, .read_data
.read_00_or_ff
	ld hl, wSerialFlags
	set 6, [hl]
	ret
.read_ca
	inc [hl] ; inc [wSerialLastReadCA]
	ret
.last_was_ca
	; if last byte read was $ca, flip all bits of data received
	ld [hl], $0
	cpl
	jr .handle_byte
.read_data
	; flip top2 bits of data received
	xor $c0
.handle_byte
	push af
	ld a, [wSerialRecvIndex]
	ld e, a
	ld a, [wcba3]
	dec a
	and $1f
	cp e
	jr z, .set_flag_and_return
	ld d, $0
	; store into receive buffer
	ld hl, wSerialRecvBuf
	add hl, de
	pop af
	ld [hl], a
	; increment buffer index (mod 32)
	ld a, e
	inc a
	and $1f
	ld [wSerialRecvIndex], a
	; increment received bytes counter & clear flags
	ld hl, wSerialRecvCounter
	inc [hl]
	xor a
	ld [wSerialFlags], a
	ret
.set_flag_and_return
	pop af
	ld hl, wSerialFlags
	set 0, [hl]
	ret

; prepares a byte to send over serial transfer, either from the send-save byte
; slot or the send buffer
SerialHandleSend:
	ld hl, wSerialSendSave
	ld a, [hl]
	or a
	jr nz, .send_saved
	ld hl, wSerialSendBufToggle
	ld a, [hl]
	or a
	jr nz, .send_buf
	; no more data--send $ac to indicate this
	ld a, $ac
	ret
.send_saved
	ld a, [hl]
	ld [hl], $0
	ret
.send_buf
	; grab byte to send from send buffer, increment buffer index
	; and decrement to-send length
	dec [hl]
	ld a, [wSerialSendBufIndex]
	ld e, a
	ld d, $0
	ld hl, wSerialSendBuf
	add hl, de
	inc a
	and $1f
	ld [wSerialSendBufIndex], a
	ld a, [hl]
	; flip top2 bits of sent data
	xor $c0
	cp $ac
	jr z, .send_escaped
	cp $ca
	jr z, .send_escaped
	cp $ff
	jr z, .send_escaped
	or a
	jr z, .send_escaped
	ret
.send_escaped
	; escape tricky data by prefixing it with $ca and flipping all bits
	; instead of just top2
	xor $c0
	cpl
	ld [wSerialSendSave], a
	ld a, $ca
	ret

; store byte at a in wSerialSendBuf for sending
SerialSendByte:
	push hl
	push de
	push bc
	push af
.asm_e0e
	ld a, [wcb80]
	ld e, a
	ld a, [wSerialSendBufIndex]
	dec a
	and $1f
	cp e
	jr z, .asm_e0e
	ld d, $0
	ld a, e
	inc a
	and $1f
	ld [wcb80], a
	ld hl, wSerialSendBuf
	add hl, de
	pop af
	ld [hl], a
	ld hl, wSerialSendBufToggle
	inc [hl]
	pop bc
	pop de
	pop hl
	ret

; sets carry if [wSerialRecvCounter] nonzero
; tcg1: Func_0e32
CheckSerialRecvCounter:
	ld a, [wSerialRecvCounter]
	or a
	ret z
	scf
	ret

; receive byte in wSerialRecvBuf
SerialRecvByte::
	push hl
	ld hl, wSerialRecvCounter
	ld a, [hl]
	or a
	jr nz, .found_counter
; wSerialRecvCounter = 0
	pop hl
	ld a, [wSerialFlags]
	or a
	ret nz
	scf
	ret
.found_counter
	push de
	dec [hl]
	ld a, [wcba3]
	ld e, a
	ld d, $0
	ld hl, wSerialRecvBuf
	add hl, de
	ld a, [hl]
	push af
	ld a, e
	inc a
	and $1f
	ld [wcba3], a
	pop af
	pop de
	pop hl
	or a
	ret

; exchange c bytes. send bytes at hl and store received bytes in de
SerialExchangeBytes::
	ld b, c
.exchange_loop
	ld a, b
	sub c
	jr c, .send
	cp $1f
	jr nc, .receive
.send
	inc c
	dec c
	jr z, .receive
	ld a, [hli]
	call SerialSendByte
	dec c
.receive
	inc b
	dec b
	jr z, .confirm
	call SerialRecvByte
	jr c, .confirm
	ld [de], a
	inc de
	dec b
.confirm
	ld a, [wSerialFlags]
	or a
	jr nz, .flagged
	ld a, c
	or b
	jr nz, .exchange_loop
	ret
.flagged
	scf
	ret

; go into slave mode (external clock) for serial transfer
; tcg1: Func_0e8e
SerialDeclarePeerMaster::
	call ClearSerialData
	ld a, SERIAL_PEER_MASTER_TCG2
	ldh [rSB], a         ; send $21
	ld a, SC_START | SC_EXTERNAL
	ldh [rSC], a         ; use external clock, set transfer start flag
	ldh a, [rIF]
	and ~IF_SERIAL
	ldh [rIF], a         ; clear serial interrupt flag
	ldh a, [rIE]
	or IF_SERIAL         ; enable serial interrupt
	ldh [rIE], a
	ret

; disable serial interrupt, and clear rSB, rSC, and serial registers in WRAM
ResetSerial::
	ldh a, [rIE]
	and ~IF_SERIAL
	ldh [rIE], a
	xor a
	ldh [rSB], a
	ldh [rSC], a
;	fallthrough

; zero serial registers in WRAM
ClearSerialData:
	ld hl, wSerialOp
	ld bc, wSerialEnd - wSerialOp
.loop
	xor a
	ld [hli], a
	dec bc
	ld a, c
	or b
	jr nz, .loop
	ret

; store bc bytes from hl in wSerialSendBuf for sending
SerialSendBytes:
	push bc
.send_loop
	ld a, [hli]
	call SerialSendByte
	ld a, [wSerialFlags]
	or a
	jr nz, .done
	dec bc
	ld a, c
	or b
	jr nz, .send_loop
	pop bc
	or a
	ret
.done
	pop bc
	scf
	ret

; receive bc bytes in wSerialRecvBuf and save them to hl
SerialRecvBytes:
	push bc
.recv_loop
	call SerialRecvByte
	jr nc, .save_byte
	halt
	nop
	jr .recv_loop
.save_byte
	ld [hli], a
	ld a, [wSerialFlags]
	or a
	jr nz, .done
	dec bc
	ld a, c
	or b
	jr nz, .recv_loop
	pop bc
	or a
	ret
.done
	pop bc
	scf
	ret

; tcg1: Func_0ef1
Serial_Func_0e12:
	ld de, wcb73
	ld hl, sp+$fe
	ld a, l
	ld [de], a
	inc de
	ld a, h
	ld [de], a
	inc de
	pop hl
	push hl
	ld a, l
	ld [de], a
	inc de
	ld a, h
	ld [de], a
	or a
	ret

; tcg1: Func_0f05
Serial_Func_0e26:
	push hl
	ld hl, wcb75
	ld a, [hli]
	or [hl]
	pop hl
	ret z
	ld hl, wcb73
	ld a, [hli]
	ld h, a
	ld l, a
	ld sp, hl
	ld hl, wcb75
	ld a, [hli]
	ld h, [hl]
	ld l, a
	push hl
	scf
	ret

; load the number at wSerialFlags (error code?) to TxRam3, print
; TransmissionErrorTryAgainText, exit the duel, and reset serial registers.
DuelTransmissionError::
	ld a, [wSerialFlags]
	ld l, a
	ld h, 0
	call LoadTxRam3
	ldtx hl, TransmissionErrorTryAgainText
	call DrawWideTextBox_WaitForInput
	ld a, -1
	ld [wDuelResult], a
	ld hl, wDuelReturnAddress
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld sp, hl
	xor a
	call PlaySong
	call ResetSerial
	ret

; exchange RNG during a link duel between both games
ExchangeRNG::
	ld a, [wDuelType]
	cp DUELTYPE_LINK
	jr z, .link_duel
	ret
.link_duel
	ld a, DUELVARS_DUELIST_TYPE
	get_turn_duelist_var
	or a ; cp DUELIST_TYPE_PLAYER
	jr z, .player_turn
; link opponent's turn
	ld hl, wOppRNG1
	ld de, wRNG1
	jr .exchange
.player_turn
	ld hl, wRNG1
	ld de, wOppRNG1
.exchange
	ld c, 3 ; wRNG1, wRNG2, and wRNGCounter
	call SerialExchangeBytes
	jp c, DuelTransmissionError
	ret

; sets hOppActionTableIndex to an AI action specified in register a.
; send 18 bytes of data to the other game from hOppActionTableIndex, hTempCardIndex_ff9f,
; hTemp_ffa0, and hTempPlayAreaLocation_ffa1, and hTempRetreatCostCards.
; finally exchange RNG data.
; the receiving side will use this data to read the OPPACTION_* value in
; [hOppActionTableIndex] and match it by calling the corresponding OppAction* function
SetOppAction_SerialSendDuelData::
	push hl
	push bc
	ldh [hOppActionTableIndex], a
	ld a, [wDuelType]
	cp DUELIST_TYPE_LINK_OPP
	jr nz, .not_link
	ld hl, hOppActionTableIndex
	ld bc, 18
	call SerialSendBytes
	call ExchangeRNG
.not_link
	pop bc
	pop hl
	ret

; receive 18 bytes of data from wSerialRecvBuf and store them into hOppActionTableIndex,
; hTempCardIndex_ff9f, hTemp_ffa0, and hTempPlayAreaLocation_ffa1,
; and hTempRetreatCostCards. also exchange RNG data.
SerialRecvDuelData::
	push hl
	push bc
	ld hl, hOppActionTableIndex
	ld bc, 18
	call SerialRecvBytes
	call ExchangeRNG
	pop bc
	pop hl
	ret

; serial send 8 bytes at f, a, l, h, e, d, c, b
; only during a duel against a link opponent
SerialSend8Bytes::
	push hl
	push af
	ld a, [wDuelType]
	cp DUELIST_TYPE_LINK_OPP
	jr z, .link
	pop af
	pop hl
	ret

.link
	pop af
	pop hl
	push af
	push hl
	push de
	push bc
	push de
	push hl
	push af
	ld hl, wTempSerialBuf
	pop de
	ld [hl], e
	inc hl
	ld [hl], d
	inc hl
	pop de
	ld [hl], e
	inc hl
	ld [hl], d
	inc hl
	pop de
	ld [hl], e
	inc hl
	ld [hl], d
	inc hl
	ld [hl], c
	inc hl
	ld [hl], b
	ld hl, wTempSerialBuf
	ld bc, 8
	call SerialSendBytes
	jp c, DuelTransmissionError
	pop bc
	pop de
	pop hl
	pop af
	ret

; serial recv 8 bytes to f, a, l, h, e, d, c, b
SerialRecv8Bytes::
	ld hl, wTempSerialBuf
	ld bc, 8
	push hl
	call SerialRecvBytes
	jp c, DuelTransmissionError
	pop hl
	ld e, [hl]
	inc hl
	ld d, [hl]
	inc hl
	push de
	ld e, [hl]
	inc hl
	ld d, [hl]
	inc hl
	push de
	ld e, [hl]
	inc hl
	ld d, [hl]
	inc hl
	ld c, [hl]
	inc hl
	ld b, [hl]
	pop hl
	pop af
	ret

SerialStartDuel:
	ld a, BANK(StartDuelFromSRAM.ok) ; $1
	call BankswitchROM
	jp StartDuelFromSRAM.ok
