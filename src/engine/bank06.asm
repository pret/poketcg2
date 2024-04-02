SECTION "Bank 6@46a6", ROMX[$46a6], BANK[$6]

INCLUDE "engine/glossary.asm"
; 0x1897e

SECTION "Bank 6@4a14", ROMX[$4a14], BANK[$6]

Func_18a14::
	xor a
	ld [wd0d3], a
	ret
; 0x18a19

SECTION "Bank 6@5657", ROMX[$5657], BANK[$6]

; if carry flag is set, only delays
; if carry not set:
; - set rRP edge up, wait;
; - set rRP edge down, wait;
; - return
TransmitIRBit:
	jr c, .delay_once
	ld [hl], RPF_WRITE_HI | RPF_ENREAD
	ld a, 5
	jr .loop_delay_1 ; jump to possibly to add more cycles?
.loop_delay_1
	dec a
	jr nz, .loop_delay_1
	ld [hl], RPF_WRITE_LO | RPF_ENREAD
	ld a, 14
	jr .loop_delay_2 ; jump to possibly to add more cycles?
.loop_delay_2
	dec a
	jr nz, .loop_delay_2
	ret

.delay_once
	ld a, 21
	jr .loop_delay_3 ; jump to possibly to add more cycles?
.loop_delay_3
	dec a
	jr nz, .loop_delay_3
	nop
	ret

; input a = byte to transmit through IR
TransmitByteThroughIR:
	push hl
	ld hl, rRP
	push de
	push bc
	ld b, a
	scf  ; carry set
	call TransmitIRBit
	or a ; carry not set
	call TransmitIRBit
	ld c, 8
	ld c, 8 ; number of input bits
.loop
	ld a, $00
	rr b
	call TransmitIRBit
	dec c
	jr nz, .loop
	pop bc
	pop de
	pop hl
	ldh a, [rJOYP]
	bit 1, a ; P11
	jr z, ReturnZFlagUnsetAndCarryFlagSet
	xor a ; return z set
	ret

; same as ReceiveByteThroughIR but
; returns $0 in a if there's an error in IR
ReceiveByteThroughIR_ZeroIfUnsuccessful:
	call ReceiveByteThroughIR
	ret nc
	xor a
	ret

	; returns carry if there's some time out
; and output in register a of $ff
; otherwise returns in a some sequence of bits
; related to how rRP sets/unsets bit 1
ReceiveByteThroughIR:
	push de
	push bc
	push hl

; waits for bit 1 in rRP to be unset
; up to $100 loops
	ld b, 0
	ld hl, rRP
.wait_ir
	bit RPB_DATAIN, [hl]
	jr z, .ok
	dec b
	jr nz, .wait_ir
	; looped around $100 times
	; return $ff and carry set
	pop hl
	pop bc
	pop de
	scf
	ld a, $ff
	ret

.ok
; delay for some cycles
	ld a, 15
.loop_delay
	dec a
	jr nz, .loop_delay

; loop for each bit
	ld e, 8
.loop
	ld a, $01
	; possibly delay cycles?
	ld b, 9
	ld b, 9
	ld b, 9
	ld b, 9

; checks for bit 1 in rRP
; if in any of the checks it is unset,
; then a is set to 0
; this is done a total of 9 times
	bit RPB_DATAIN, [hl]
	jr nz, .asm_196ec
	xor a
.asm_196ec
	bit RPB_DATAIN, [hl]
	jr nz, .asm_196f1
	xor a
.asm_196f1
	dec b
	jr nz, .asm_196ec
	; one bit received
	rrca
	rr d
	dec e
	jr nz, .loop
	ld a, d ; has bits set for each "cycle" that bit 1 was not unset
	pop hl
	pop bc
	pop de
	or a
	ret

ReturnZFlagUnsetAndCarryFlagSet:
	ld a, $ff
	or a ; z not set
	scf  ; carry set
	ret

; called when expecting to transmit data
Func_196e8:
	ld hl, rRP
.loop
	ldh a, [rJOYP]
	bit 1, a
	jr z, ReturnZFlagUnsetAndCarryFlagSet
	ld a, $a5 ; request
	call TransmitByteThroughIR
	push hl
	pop hl
	call ReceiveByteThroughIR_ZeroIfUnsuccessful
	cp $35 ; acknowledge
	jr nz, .loop
	xor a
	ret

; called when expecting to receive data
Func_1971e:
	ld hl, rRP
.asm_19721
	ldh a, [rJOYP]
	bit 1, a
	jr z, ReturnZFlagUnsetAndCarryFlagSet
	call ReceiveByteThroughIR_ZeroIfUnsuccessful
	cp $a5 ; request
	jr nz, .asm_19721
	ld a, $35 ; acknowledge
	call TransmitByteThroughIR
	xor a
	ret

ReturnZFlagUnsetAndCarryFlagSet2:
	jp ReturnZFlagUnsetAndCarryFlagSet

TransmitIRDataBuffer:
	call Func_196e8
	jr c, ReturnZFlagUnsetAndCarryFlagSet2
	ld a, $49
	call TransmitByteThroughIR
	ld a, $52
	call TransmitByteThroughIR
	ld hl, wIRDataBuffer
	ld c, 8
	jr TransmitNBytesFromHLThroughIR

ReceiveIRDataBuffer:
	call Func_1971e
	jr c, ReturnZFlagUnsetAndCarryFlagSet2
	call ReceiveByteThroughIR
	cp $49
	jr nz, ReceiveIRDataBuffer
	call ReceiveByteThroughIR
	cp $52
	jr nz, ReceiveIRDataBuffer
	ld hl, wIRDataBuffer
	ld c, 8
	jr ReceiveNBytesToHLThroughIR

; hl = start of data to transmit
; c = number of bytes to transmit
TransmitNBytesFromHLThroughIR:
	ld b, $0
.loop_data_bytes
	ld a, b
	add [hl]
	ld b, a
	ld a, [hli]
	call TransmitByteThroughIR
	jr c, .asm_1977c
	dec c
	jr nz, .loop_data_bytes
	ld a, b
	cpl
	inc a
	call TransmitByteThroughIR
.asm_1977c
	ret

; hl = address to write received data
; c = number of bytes to be received
ReceiveNBytesToHLThroughIR:
	ld b, 0
.loop_data_bytes
	call ReceiveByteThroughIR
	jr c, ReturnZFlagUnsetAndCarryFlagSet2
	ld [hli], a
	add b
	ld b, a
	dec c
	jr nz, .loop_data_bytes
	call ReceiveByteThroughIR
	add b
	or a
	jr nz, ReturnZFlagUnsetAndCarryFlagSet2
	ret

; disables interrupts, and sets joypad and IR communication port
; switches to CGB normal speed
StartIRCommunications:
	di
	call SwitchToCGBNormalSpeed
	ld a, P14
	ldh [rJOYP], a
	ld a, RPF_ENREAD
	ldh [rRP], a
	ret

; reenables interrupts, and switches CGB back to double speed
CloseIRCommunications:
	ld a, P14 | P15
	ldh [rJOYP], a
.wait_vblank_on
	ldh a, [rSTAT]
	and STAT_LCDC_STATUS
	cp STAT_ON_VBLANK
	jr z, .wait_vblank_on
.wait_vblank_off
	ldh a, [rSTAT]
	and STAT_LCDC_STATUS
	cp STAT_ON_VBLANK
	jr nz, .wait_vblank_off
	call SwitchToCGBDoubleSpeed
	ei
	ret

; set rRP to 0
ClearRP:
	ld a, $00
	ldh [rRP], a
	ret

; expects to receive a command (IRCMD_* constant)
; in wIRDataBuffer + 1, then calls the subroutine
; corresponding to that command
ExecuteReceivedIRCommands:
	call StartIRCommunications
.loop_commands
	call ReceiveIRDataBuffer
	jr c, .error
	jr nz, .loop_commands
	ld hl, wIRDataBuffer + 1
	ld a, [hl]
	ld hl, .CmdPointerTable
	cp NUM_IR_COMMANDS
	jr nc, .loop_commands ; invalid command
	call .JumpToCmdPointer ; execute command
	jr .loop_commands
.error
	call CloseIRCommunications
	xor a
	scf
	ret

.JumpToCmdPointer
	add a ; *2
	add l
	ld l, a
	ld a, 0
	adc h
	ld h, a
	ld a, [hli]
	ld h, [hl]
	ld l, a
.jp_hl
	jp hl

.CmdPointerTable
	dw .Close                ; IRCMD_CLOSE
	dw .ReturnWithoutClosing ; IRCMD_RETURN_WO_CLOSING
	dw .TransmitData         ; IRCMD_TRANSMIT_DATA
	dw .ReceiveData          ; IRCMD_RECEIVE_DATA
	dw .CallFunction         ; IRCMD_CALL_FUNCTION

; closes the IR communications
; pops hl so that the sp points
; to the return address of ExecuteReceivedIRCommands
.Close
	pop hl
	call CloseIRCommunications
	or a
	ret

; returns without closing the IR communications
; will continue the command loop
.ReturnWithoutClosing
	or a
	ret

; receives an address and number of bytes
; and transmits starting at that address
.TransmitData
	call Func_196e8
	ret c
	call LoadRegistersFromIRDataBuffer
	jp TransmitNBytesFromHLThroughIR

; receives an address and number of bytes
; and writes the data received to that address
.ReceiveData
	call LoadRegistersFromIRDataBuffer
	ld l, e
	ld h, d
	call ReceiveNBytesToHLThroughIR
	jr c, .asm_19812
	sub b
	call TransmitByteThroughIR
.asm_19812
	ret

; receives an address to call, then stores
; the registers in the IR data buffer
.CallFunction
	call LoadRegistersFromIRDataBuffer
	call .jp_hl
	call StoreRegistersInIRDataBuffer
	ret

; returns carry set if request sent was not acknowledged
TrySendIRRequest:
	call StartIRCommunications
	ld hl, rRP
	ld c, 4
.send_request
	ld a, $a5 ; request
	push bc
	call TransmitByteThroughIR
	push bc
	pop bc
	call ReceiveByteThroughIR_ZeroIfUnsuccessful
	pop bc
	cp $35 ; acknowledgement
	jr z, .received_ack
	dec c
	jr nz, .send_request
	scf
	jr .close

.received_ack
	xor a
.close
	push af
	call CloseIRCommunications
	pop af
	ret

; returns carry set if request was not received
TryReceiveIRRequest:
	call StartIRCommunications
	ld hl, rRP
.wait_request
	call ReceiveByteThroughIR_ZeroIfUnsuccessful
	cp $a5 ; request
	jr z, .send_ack
	ldh a, [rJOYP]
	cpl
	and P10 | P11
	jr z, .wait_request
	scf
	jr .close

.send_ack
	ld a, $35 ; acknowledgement
	call TransmitByteThroughIR
	xor a
.close
	push af
	call CloseIRCommunications
	pop af
	ret

; sends request for other device to close current communication
RequestCloseIRCommunication:
	call StartIRCommunications
	ld a, IRCMD_CLOSE
	ld [wIRDataBuffer + 1], a
	call TransmitIRDataBuffer
;	fallthrough

; calls CloseIRCommunications while preserving af
SafelyCloseIRCommunications:
	push af
	call CloseIRCommunications
	pop af
	ret

; sends a request for data to be transmitted
; from the other device
; hl = start of data to request to transmit
; de = address to write data received
; c = length of data
RequestDataTransmissionThroughIR:
	ld a, IRCMD_TRANSMIT_DATA
	call TransmitRegistersThroughIR
	push de
	push bc
	call Func_1971e
	pop bc
	pop hl
	jr c, SafelyCloseIRCommunications
	call ReceiveNBytesToHLThroughIR
	jr SafelyCloseIRCommunications

; transmits data to be written in the other device
; hl = start of data to transmit
; de = address for other device to write data
; c = length of data
RequestDataReceivalThroughIR:
	ld a, IRCMD_RECEIVE_DATA
	call TransmitRegistersThroughIR
	call TransmitNBytesFromHLThroughIR
	jr c, SafelyCloseIRCommunications
	call ReceiveByteThroughIR
	jr c, SafelyCloseIRCommunications
	add b
	jr nz, .asm_1989e
	xor a
	jr SafelyCloseIRCommunications
.asm_1989e
	call ReturnZFlagUnsetAndCarryFlagSet
	jr SafelyCloseIRCommunications

; first stores all the current registers in wIRDataBuffer
; then transmits it through IR
TransmitRegistersThroughIR:
	push hl
	push de
	push bc
	call StoreRegistersInIRDataBuffer
	call StartIRCommunications
	call TransmitIRDataBuffer
	pop bc
	pop de
	pop hl
	ret nc
	inc sp
	inc sp
	jr SafelyCloseIRCommunications

; stores af, hl, de and bc in wIRDataBuffer
StoreRegistersInIRDataBuffer:
	push de
	push hl
	push af
	ld hl, wIRDataBuffer
	pop de
	ld [hl], e ; <- f
	inc hl
	ld [hl], d ; <- a
	inc hl
	pop de
	ld [hl], e ; <- l
	inc hl
	ld [hl], d ; <- h
	inc hl
	pop de
	ld [hl], e ; <- e
	inc hl
	ld [hl], d ; <- d
	inc hl
	ld [hl], c ; <- c
	inc hl
	ld [hl], b ; <- b
	ret

; loads all the registers that were stored
; from StoreRegistersInIRDataBuffer
LoadRegistersFromIRDataBuffer:
	ld hl, wIRDataBuffer
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

; empties screen and enables sprite animations
SetSpriteAnimationsAsVBlankFunction:
	call EmptyScreen
	lb de, $38, $7f
	call SetupText
	ld hl, wVBlankFunctionTrampoline + 1
	ld de, wVBlankFunctionTrampolineBackup
	call BackupVBlankFunctionTrampoline
	di
	call Func_3e4f
	ei
	ret

; sets backup VBlank function as wVBlankFunctionTrampoline
RestoreVBlankFunction:
	call Func_3e54
	ld hl, wVBlankFunctionTrampolineBackup
	ld de, wVBlankFunctionTrampoline + 1
	call BackupVBlankFunctionTrampoline
	ret

; copies 2 bytes from hl to de while interrupts are disabled
; used to load or store wVBlankFunctionTrampoline
; to wVBlankFunctionTrampolineBackup
BackupVBlankFunctionTrampoline:
	di
	ld a, [hli]
	ld [de], a
	inc de
	ld a, [hld]
	ld [de], a
	ei
	ret

; unreferenced
Func_198f7:
	ret

; clears saved data (card Collection/saved decks/Card Pop! data/etc)
; then adds the old starter decks as saved decks
; marks all cards in Collection as not owned
InitSaveData:
; clear card and deck save data
	call EnableSRAM
	ld a, PLAYER_TURN
	ldh [hWhoseTurn], a
	ld hl, sCardAndDeckSaveData
	ld bc, sCardAndDeckSaveDataEnd - sCardAndDeckSaveData
.loop_clear
	xor a
	ld [hli], a
	dec bc
	ld a, c
	or b
	jr nz, .loop_clear

	; these have been kept from Pokémon TCG 1
	; and correspond to the old starter decks
	; they will be erased from SRAM afterwards
	ld a, SWEAT_ANTI_GR1_DECK ; old CHARMANDER_AND_FRIENDS_DECK
	ld hl, sSavedDeck1
	call .SaveDeck
	ld a, VENGEFUL_ANTI_GR3_DECK ; old SQUIRTLE_AND_FRIENDS_DECK
	ld hl, sSavedDeck2
	call .SaveDeck
	ld a, SAMS_PRACTICE_DECK ; old BULBASAUR_AND_FRIENDS_DECK
	ld hl, sSavedDeck3
	call .SaveDeck

; marks all cards in Collection to not owned
	call EnableSRAM
	ld hl, sCardCollection
	ld bc, CARD_COLLECTION_SIZE
.loop_collection
	ld [hl], CARD_NOT_OWNED
	inc hl
	dec bc
	ld a, c
	or b
	jr nz, .loop_collection

	ld hl, sCurrentDuel
	xor a
	ld [hli], a
	ld [hli], a ; sCurrentDuelChecksum
	ld [hl], a

	; clears Card Pop! names
	ld a, BANK(sCardPopNameList)
	call BankswitchSRAM
	ld hl, sCardPopNameList
	ld c, CARDPOP_NAME_LIST_MAX_ELEMS
.loop_card_pop_names
	ld [hl], $0
	ld de, NAME_BUFFER_LENGTH
	add hl, de
	dec c
	jr nz, .loop_card_pop_names
	ld hl, sCardPopRecords
	ld [hl], $00
	xor a
	call BankswitchSRAM

; saved configuration options
	ld a, 2
	ld [sPrinterContrastLevel], a
	ld a, 2
	ld [sTextSpeed], a
	ld [wTextSpeed], a

; miscellaneous data
	xor a
	ld [s0a007], a
	ld [sSkipDelayAllowed], a
	ld [s0a004], a
	ld [sTotalCardPopsDone], a
	ld [sClearedGame], a
	ld hl, sTotalDuelCounter
	ld [hli], a
	ld [hli], a
	ld [hli], a ; sLinkDuelCounter
	ld [hli], a

	farcall Func_8f10
	call DisableSRAM
	ret

; saves deck in a to SRAM address in hl
.SaveDeck:
	push de
	push bc
	push hl
	ld [wNPCDuelDeckID], a
	call LoadDeck
	jr c, .done
	call .LoadDeckName
	pop hl
	call EnableSRAM
	push hl
	ld de, wDefaultText
.loop_copy_name
	ld a, [de]
	inc de
	ld [hli], a
	or a
	jr nz, .loop_copy_name
	pop hl
	push hl
	ld de, DECK_NAME_SIZE
	add hl, de
	ld de, wPlayerDeck
	bank1call SaveDeckCards
	call DisableSRAM
	or a
.done
	pop hl
	pop bc
	pop de
	ret

.LoadDeckName:
	ld a, [wNPCDuelDeckID]
	sub 3
	farcall LoadDeckIDData
	ld hl, wOpponentDeckName
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld de, wDuelTempList
	call CopyText
	ld c, $0f
	ld hl, wDuelTempList
	ld de, wDefaultText
.loop_chars
	ld a, [hl]
	or a
	jr z, .terminating_byte
	cp $0f
	jr nz, .asm_199dc
	ld c, a
	jr .next_char
.asm_199dc
	cp $0e
	jr nz, .asm_199e3
	ld c, a
	jr .next_char
.asm_199e3
	cp $06
	jr c, .copy_2_bytes
	ld a, c
	ld [de], a
	inc de
	ld a, [hl]
	ld [de], a
	inc de
.next_char
	inc hl
	jr .loop_chars
.copy_2_bytes
	ld a, [hli]
	ld [de], a
	inc de
	ld a, [hli]
	ld [de], a
	inc de
	jr .loop_chars

.terminating_byte
	ld [de], a
	ret
; 0x199fa

SECTION "Bank 6@5a30", ROMX[$5a30], BANK[$6]

; prepares IR communication parameter data
; a = a IRPARAM_* constant for the function of this connection
InitIRCommunications:
	ld hl, wOwnIRCommunicationParams
	ld [hl], a
	inc hl
	ld [hl], $50
	inc hl
	ld [hl], $4b
	inc hl
	ld [hl], $32
	ld a, $ff
	ld [wIRCommunicationErrorCode], a
	ld a, PLAYER_TURN
	ldh [hWhoseTurn], a
; clear wNameBuffer and wOpponentName
	xor a
	ld [wNameBuffer], a
	ld hl, wOpponentName
	ld [hli], a
	ld [hl], a
; loads player's name from SRAM
; to wDefaultText
	call EnableSRAM
	ld hl, sPlayerName
	ld de, wDefaultText
	ld c, NAME_BUFFER_LENGTH
.loop
	ld a, [hli]
	ld [de], a
	inc de
	dec c
	jr nz, .loop
	call DisableSRAM
	ret
; 0x19a64

SECTION "Bank 6@5a92", ROMX[$5a92], BANK[$6]

; exchanges player names and IR communication parameters
; checks whether parameters for communication match
; and if they don't, an error is issued
ExchangeIRCommunicationParameters:
	ld hl, wOwnIRCommunicationParams
	ld de, wOtherIRCommunicationParams
	ld c, 4
	call RequestDataTransmissionThroughIR
	jr c, .error
	ld hl, wOtherIRCommunicationParams + 1
	ld a, [hli]
	cp $50
	jr nz, .error
	ld a, [hli]
	cp $4b
	jr nz, .error
	ld a, [wOwnIRCommunicationParams]
	ld hl, wOtherIRCommunicationParams
	cp [hl] ; do parameters match?
	jr nz, SetIRCommunicationErrorCode_Error

; receives wDefaultText from other device
; and writes it to wNameBuffer
	ld hl, wDefaultText
	ld de, wNameBuffer
	ld c, NAME_BUFFER_LENGTH
	call RequestDataTransmissionThroughIR
	jr c, .error
; transmits wDefaultText to be
; written in wNameBuffer in the other device
	ld hl, wDefaultText
	ld de, wNameBuffer
	ld c, NAME_BUFFER_LENGTH
	call RequestDataReceivalThroughIR
	jr c, .error
	or a
	ret

.error
	xor a
	scf
	ret

SetIRCommunicationErrorCode_Error:
	ld hl, wIRCommunicationErrorCode
	ld [hl], $01
	ld de, wIRCommunicationErrorCode
	ld c, 1
	call RequestDataReceivalThroughIR
	call RequestCloseIRCommunication
	ld a, $01
	scf
	ret

SetIRCommunicationErrorCode_NoError:
	ld hl, wOwnIRCommunicationParams
	ld [hl], $00
	ld de, wIRCommunicationErrorCode
	ld c, 1
	call RequestDataReceivalThroughIR
	ret c
	call RequestCloseIRCommunication
	or a
	ret
; 0x19afb

SECTION "Bank 6@5bf9", ROMX[$5bf9], BANK[$6]

_CardPopMenu:
	call EnableSRAM
	ld a, [sClearedGame]
	ld [wClearedGame], a
	call DisableSRAM
	xor a
	ld [wce27], a

; loads scene for Card Pop! menu
.asm_19c09
	call SetSpriteAnimationsAsVBlankFunction
	ld a, SCENE_CARD_POP_MENU
	lb bc, 0, 0
	call EmptyScreenAndLoadScene

	ld a, [wClearedGame]
	or a
	jr nz, .cleared_game
	lb de,  8, 0
	lb bc, 12, 8
	call DrawRegularTextBox
	ldtx hl, Text0254
	lb de, 10, 2
	call InitTextPrinting_ProcessTextFromID
	ld hl, CardPopMenuParams
	ld a, [wce27]
	call InitializeMenuParameters
	call DrawCardPopMenuBox

	call EnableLCD
.loop_input_1
	call DoFrame
	call HandleMenuInput
	ld [wce27], a
	jr nc, .loop_input_1

	; selected an option
	call RestoreVBlankFunction
	ldh a, [hCurScrollMenuItem]
	or a
	jr z, .card_pop
	cp 1
	jr z, .view_records
	jr .exit

.card_pop
	call DoCardPop
	jr .asm_19c09

.view_records
	call ViewCardPopRecords
	jr .asm_19c09

.cleared_game
	lb de,  8,  0
	lb bc, 12, 10
	call DrawRegularTextBox
	ldtx hl, Text0255
	lb de, 10, 2
	call InitTextPrinting_ProcessTextFromID
	ld hl, CardPopMenuParams
	ld a, [wce27]
	call InitializeMenuParameters
	ld a, 4 ; override num items
	ld [wNumScrollMenuItems], a
	call DrawCardPopMenuBox

	call EnableLCD
.loop_input_2
	call DoFrame
	call HandleMenuInput
	ld [wce27], a
	jr nc, .loop_input_2

	call RestoreVBlankFunction
	ldh a, [hCurScrollMenuItem]
	or a
	jr z, .card_pop
	cp 1
	jr z, .rare_card_pop
	cp 2
	jr z, .view_records
	jr .exit

.rare_card_pop
	call DoRareCardPop
	jp .asm_19c09

.exit
	ret

; draws the Card Pop! menu box with the
; options the player can select
; Rare Card Pop! is only available after
; the player has cleared the game
DrawCardPopMenuBox:
	lb de,  0, 12
	lb bc, 20,  6
	call DrawRegularTextBox
	ldh a, [hCurScrollMenuItem]
	add a ; *2
	ld e, a
	ld d, $00
	ld hl, .text_ids_without_rare_card_pop
	ld a, [wClearedGame]
	or a
	jr z, .got_menu_text_ids
	ld hl, .text_ids_with_rare_card_pop
.got_menu_text_ids
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	lb de, 1, 14
	call InitTextPrinting_ProcessTextFromID
	ret

.text_ids_without_rare_card_pop
	tx Text0256 ; Card Pop!
	tx Text0258 ; View Records
	tx Text0259 ; Exit

.text_ids_with_rare_card_pop
	tx Text0256 ; Card Pop!
	tx Text0257 ; Rare Card Pop!
	tx Text0258 ; View Records
	tx Text0259 ; Exit

CardPopMenuParams:
	db 9 ; x pos
	db 2 ; y pos
	db 2 ; y spacing
	db 3 ; num entries
	db SYM_CURSOR_R ; visible cursor tile
	db SYM_SPACE ; invisible cursor tile
	dw HandleCardPopMenuInput ; wCardListHandlerFunction

; returns carry if selection with A btn was made
HandleCardPopMenuInput:
	ldh a, [hDPadHeld]
	and D_UP | D_DOWN
	jr z, .no_up_down
	call DrawCardPopMenuBox
.no_up_down
	ldh a, [hKeysPressed]
	bit A_BUTTON_F, a
	jr nz, .set_carry
	and B_BUTTON
	ret z
	ld a, $ff
	ldh [hCurScrollMenuItem], a
.set_carry
	scf
	ret

DoCardPop:
	ld a, IRPARAM_CARD_POP
	ld [wCardPopType], a

	call SetSpriteAnimationsAsVBlankFunction
	ld a, SCENE_CARD_POP
	lb bc, 0, 0
	call EmptyScreenAndLoadScene
	ldtx hl, Text025a
	call PrintScrollableText_NoTextBoxLabel

	call RestoreVBlankFunction
	call PauseSong
	ld a, SCENE_LINK
	call LoadCardPopSceneAndHandleCommunications
	ld a, SCENE_CARD_POP_ERROR
	jr c, ShowCardPopError
	ldtx hl, Text025e
;	fallthrough

; hl = text ID
Func_19d24:
	farcall _DisplayCardDetailScreen
	call ResumeSong
	bank1call SetupDuel
	call DisableLCD
	bank1call OpenCardPage_FromHand
	ret

; a = scene ID
; hl = text ID for text box
ShowCardPopError:
	push hl
	push af
	call ResumeSong
	call SetSpriteAnimationsAsVBlankFunction
	pop af
	lb bc, 0, 0
	call EmptyScreenAndLoadScene
	pop hl
	call PrintScrollableText_NoTextBoxLabel
	call RestoreVBlankFunction
	ret

DoRareCardPop:
	ld a, IRPARAM_RARE_CARD_POP
	ld [wCardPopType], a

	call SetSpriteAnimationsAsVBlankFunction
	ld a, SCENE_RARE_CARD_POP
	lb bc, 0, 0
	call EmptyScreenAndLoadScene
	ldtx hl, Text025f
	call PrintScrollableText_NoTextBoxLabel
	call RestoreVBlankFunction
	call PauseSong
	ld a, SCENE_LINK
	call LoadCardPopSceneAndHandleCommunications
	ld a, SCENE_RARE_CARD_POP_ERROR
	jr c, ShowCardPopError
	ldtx hl, Text0260
	jr Func_19d24

; a = scene ID
LoadCardPopSceneAndHandleCommunications:
	push af
	call SetSpriteAnimationsAsVBlankFunction
	pop af
	lb bc, 0, 0
	call EmptyScreenAndLoadScene
	ldtx hl, Text025d
	call DrawWideTextBox_PrintText
	call EnableLCD
	call HandleCardPopCommunications
	push af
	push hl
	call ClearRP
	call RestoreVBlankFunction
	pop hl
	pop af
	ret c ; not successful

	; Card Pop! successful, add to collection
	ld hl, wLoadedCard1ID
	ld e, [hl]
	inc hl
	ld d, [hl]
	ld a, BANK("SRAM2")
	call BankswitchSRAM
	call AddCardToCollection
	xor a
	call BankswitchSRAM
	ld hl, wLoadedCard1ID
	ld e, [hl]
	inc hl
	ld d, [hl]
	call AddCardToCollection

	; loads card name and plays obtain song
	ld hl, wLoadedCard1Name
	ld a, [hli]
	ld h, [hl]
	ld l, a
	call LoadTxRam2
	ld a, PLAYER_TURN
	ldh [hWhoseTurn], a
	ld a, SFX_5D
	call PlaySFX
.wait_sfx
	call AssertSFXFinished
	or a
	jr nz, .wait_sfx
	ld a, [wCardPopCardObtainSong]
	call PlaySong
	or a
	ret

; handles all communications to the other device to do Card Pop!
; returns carry if Card Pop! is unsuccessful
; and returns in hl the corresponding error text ID
HandleCardPopCommunications:
; copy CardPopNameList from SRAM to WRAM
	ld a, BANK("SRAM1")
	call BankswitchSRAM
	ld hl, sCardPopNameList
	ld de, wCardPopNameList
	ld bc, CARDPOP_NAME_LIST_SIZE
	call CopyDataHLtoDE
	xor a
	call BankswitchSRAM
	call DisableSRAM

	ld a, [wCardPopType]
	call InitIRCommunications
.loop_request
	call TryReceiveIRRequest ; receive request
	jr nc, .execute_commands
	bit 1, a
	jp nz, .asm_19e7f
	call TrySendIRRequest ; send request
	jr c, .loop_request

; do the player name search, then transmit the result
	call ExchangeIRCommunicationParameters
	jr c, .fail
	ld hl, wCardPopNameList
	ld de, wOtherPlayerCardPopNameList
	ld c, 0 ; $100 bytes = CARDPOP_NAME_LIST_SIZE
	call RequestDataTransmissionThroughIR
	jr c, .fail

	call LookUpNameInCardPopNameList
	call DecideCardToReceiveFromCardPop
	call FillCardPopSummary

	ld hl, wCardPopNameSearchResult
	ld e, l
	ld d, h
	ld c, 8 ; wCardPopNameSearchResult + wCardPopSummary
	call RequestDataReceivalThroughIR
	jr c, .fail
	call SetIRCommunicationErrorCode_NoError
	jr c, .fail
	call ExecuteReceivedIRCommands
	jr c, .fail
	call SetCardPopRecord
	jr .check_search_result

.execute_commands
; will receive commands to send card pop name list,
; and to receive the result of the name list search
	call ExecuteReceivedIRCommands
	ld a, [wIRCommunicationErrorCode]
	or a
	jr nz, .fail

	ld a, $32
	ld [wOtherIRCommunicationParams + 3], a
	call DecideCardToReceiveFromCardPop
	call SetCardPopRecord
	call FillCardPopSummary

	ld hl, wCardPopNameSearchResult
	ld e, l
	ld d, h
	ld c, 8 ; wCardPopNameSearchResult + wCardPopSummary
	call RequestDataReceivalThroughIR
	jr c, .fail
	call RequestCloseIRCommunication
	jr c, .fail

.check_search_result
	ld a, [wCardPopNameSearchResult]
	or a
	jr z, .success
	; not $00, means the name was found in the list
	ldtx hl, Text025c ; CannotCardPopWithFriendPreviouslyPoppedWithText
	ld a, [wCardPopType]
	cp $01
	jr z, .set_carry
	ldtx hl, Text0261
	jr .set_carry

.fail
	ld a, [wIRCommunicationErrorCode]
	cp $01
	jr nz, .asm_19e7f
	ldtx hl, Text0262 ; ThePopWasntSuccessfulText
	scf
	ret

.asm_19e7f
	ldtx hl, Text025b
.set_carry
	scf
	ret

.success

; increment number of times Card Pop! was done
; and write the other player's name to sCardPopNameList
; the spot where this is written in the list is derived
; from the lower nybble of sTotalCardPopsDone
; that means that after 16 Card Pop!, the older
; names start to get overwritten
	call EnableSRAM
	ld hl, sTotalCardPopsDone
	ld a, [hl]
	inc [hl]
	and $0f
	swap a ; *NAME_BUFFER_LENGTH
	ld l, a
	ld h, $0
	ld de, sCardPopNameList
	add hl, de
	ld e, l
	ld d, h
	ld hl, wNameBuffer
	ld bc, NAME_BUFFER_LENGTH
	ld a, BANK("SRAM1")
	call BankswitchSRAM
	call CopyDataHLtoDE
	ld a, [wOtherIRCommunicationParams + 3]
	cp $32
	jr nz, .asm_19ecb

	; copy SRAM so that sCardPopRecords is moved $20 forward
	ld hl, sCardPopRecords + MAX_NUM_CARDPOP_RECORDS * CARDPOP_RECORD_SIZE - 1
	ld de, sCardPopRecords + MAX_NUM_CARDPOP_RECORDS * CARDPOP_RECORD_SIZE - 1 + CARDPOP_RECORD_SIZE
	ld bc, MAX_NUM_CARDPOP_RECORDS * CARDPOP_RECORD_SIZE
.loop_copy_sram
	ld a, [hld]
	ld [de], a
	dec de
	dec bc
	ld a, c
	or b
	jr nz, .loop_copy_sram
	ld hl, wCardPopRecord
	ld de, sCardPopRecords
	ld bc, CARDPOP_RECORD_SIZE
	call CopyDataHLtoDE
.asm_19ecb
	xor a
	call BankswitchSRAM
	call DisableSRAM
	or a
	ret

; looks up the name in wNameBuffer in wCardPopNameList
; used to know whether this save file has done Card Pop!
; with the other player already
; returns carry and wCardPopNameSearchResult = $ff if the name was found;
; returns no carry and wCardPopNameSearchResult = $00 otherwise
LookUpNameInCardPopNameList:
; searches for other player's name in this game's name list
	ld hl, wCardPopNameList
	ld c, CARDPOP_NAME_LIST_MAX_ELEMS
.loop_own_card_pop_name_list
	push hl
	ld de, wNameBuffer
	call .CompareNames
	pop hl
	jr nc, .found_name
	ld de, NAME_BUFFER_LENGTH
	add hl, de
	dec c
	jr nz, .loop_own_card_pop_name_list

; name was not found in wCardPopNameList

; searches for this player's name in the other game's name list
	call EnableSRAM
	ld hl, wOtherPlayerCardPopNameList
	ld c, CARDPOP_NAME_LIST_MAX_ELEMS
.loop_other_card_pop_name_list
	push hl
	ld de, sPlayerName
	call .CompareNames ; discards result from comparison
	pop hl
	jr nc, .found_name
	ld de, NAME_BUFFER_LENGTH
	add hl, de
	dec c
	jr nz, .loop_other_card_pop_name_list
	xor a
	jr .no_carry

.found_name
	ld a, $ff
	scf
.no_carry
	ld [wCardPopNameSearchResult], a ; $00 if name was not found, $ff otherwise
	call DisableSRAM
	ret

; compares names in hl and de
; if they are different, return carry
.CompareNames
	ld b, NAME_BUFFER_LENGTH
.loop_chars
	ld a, [de]
	inc de
	cp [hl]
	jr nz, .not_same
	inc hl
	dec b
	jr nz, .loop_chars
	or a
	ret
.not_same
	scf
	ret
; 0x19f1f

SECTION "Bank 6@5f49", ROMX[$5f49], BANK[$6]

; loads in wLoadedCard1 a random card to be received
; this selection is done based on the rarity
; decided from the names of both participants
; the result will always be a non-Energy card that
; is not from a Promotional set, with the exception
; of VenusaurLv64 and MewLv15
; output:
; - e = card ID chosen
DecideCardToReceiveFromCardPop:
	ld a, PLAYER_TURN
	ldh [hWhoseTurn], a
	call EnableSRAM
	ld hl, sPlayerName
	call .CalculateNameHash
	call DisableSRAM
	push de
	ld hl, wNameBuffer
	call .CalculateNameHash
	pop bc

; de = other player's name  hash
; bc = this player's name hash

; updates RNG values to subtraction of these two hashes
	ld hl, wRNG1
	ld a, b
	sub d
	ld d, a ; b - d
	ld [hli], a ; wRNG1
	ld a, c
	sub e
	ld e, a ; c - e
	ld [hli], a ; wRNG2
	add d
	ld [hl], a ; wRNGCounter

	ld a, [wCardPopType]
	cp IRPARAM_RARE_CARD_POP
	jr nz, .not_rare
	; Rare Card Pop!
	ld a, e
	cp 5
	jr z, .phantom
	jr .star_rarity
.not_rare

; depending on the values obtained from the hashes,
; determine which rarity card to give to the player
; along with the song to play with each rarity
; the probabilities of each possibility can be calculated
; as follows (given 2 random player names):
; 101/256 ~ 39% for Circle
;  90/256 ~ 35% for Diamond
;  63/256 ~ 25% for Star
;   1/256 ~ .4% for VenusaurLv64 or MewLv15
	ld a, e
	cp 5
	jr z, .phantom
	cp 64
	jr c, .star_rarity ; < 64
	cp 154
	jr c, .diamond_rarity ; < 154
	; >= 154

	ld a, MUSIC_BOOSTER_PACK
	ld b, CIRCLE
	jr .got_rarity
.diamond_rarity
	ld a, MUSIC_BOOSTER_PACK
	ld b, DIAMOND
	jr .got_rarity
.star_rarity
	ld a, MUSIC_MATCH_VICTORY
	ld b, STAR
	jr .got_rarity
.phantom
	ld a, MUSIC_MEDAL
	ld b, $fe
.got_rarity
	ld [wCardPopCardObtainSong], a
	ld a, b
	lb bc, BEGINNING_POKEMON, TEAM_ROCKETS_AMBITION
	farcall CreateCardPopCandidateList
	; pick randomly from list
	call Random
	ld l, a
	ld h, $00
	add hl, hl
	ld de, wCardPopCandidateList
	add hl, de
	ld e, [hl]
	inc hl
	ld d, [hl]
	call LoadCardDataToBuffer1_FromCardID
	ret

; creates a unique two-byte hash from the name given in hl
; the low byte is calculated by simply adding up all characters
; the high byte is calculated by xoring all characters together
; input:
; - hl = points to the start of the name buffer
; output:
; - de = hash
.CalculateNameHash:
	ld c, NAME_BUFFER_LENGTH
	ld de, $0
.loop
	ld a, e
	add [hl]
	ld e, a
	ld a, d
	xor [hl]
	ld d, a
	inc hl
	dec c
	jr nz, .loop
	ret

FillCardPopSummary:
	ld hl, wLoadedCard1ID
	ld de, wCardPopSummary
	call CopyWordFromHLToDE
	call EnableSRAM
	ld hl, sTotalDuelCounter
	call CopyWordFromHLToDE
	call DisableSRAM
	call GetAmountOfCardsOwned
	ld a, l
	ld [de], a
	inc de
	ld a, h
	ld [de], a
	inc de
	push de
	xor a
	farcall CountEventCoinsObtained
	pop de
	ld [de], a
	ret

CopyWordFromHLToDE:
	ld a, [hli]
	ld [de], a
	inc de
	ld a, [hli]
	ld [de], a
	inc de
	ret

SetCardPopRecord:
	ld hl, wNameBuffer
	ld de, wCardPopRecord
	ld bc, NAME_BUFFER_LENGTH
	call CopyDataHLtoDE
	ld hl, wLoadedCard1ID
	call CopyWordFromHLToDE
	ld hl, wCardPopSummary
	ld bc, 7
	call CopyDataHLtoDE
	ld a, [wCardPopType]
	ld [de], a
	ret

ClearCardPopNameList:
	call EnableSRAM
	ld a, BANK(sCardPopNameList)
	call BankswitchSRAM
	ld hl, sCardPopNameList
	ld de, NAME_BUFFER_LENGTH
	ld c, CARDPOP_NAME_LIST_MAX_ELEMS
.loop_clear
	ld [hl], $0
	add hl, de
	dec c
	jr nz, .loop_clear
	; the intention was to clear sTotalCardPopsDone,
	; but since we are in SRAM1, it clears a byte
	; in sCardPopNameList instead
	xor a
	ld [sCardPopNameList + $5], a
	call BankswitchSRAM ; SRAM0
	call DisableSRAM
	ret

ViewCardPopRecords:
	xor a
	ld [wce28], a
	ld [wCurMenuItem], a
	call .CountNumberOfRecords
	ld a, [wNumCardPopRecords]
	or a
	jr nz, .init_list
	ret nz

	; no Card Pop! records
	ldtx hl, Text026d
	call DrawWideTextBox_WaitForInput
	ret

.init_list
	bank1call SetupDuel
	call .DrawSlashAndTopLineSeparator
	ld hl, .MenuParams
	ld a, [wCurMenuItem]
	call InitializeMenuParameters
	ld a, [wNumCardPopRecords]
	cp 5
	jr nc, .num_items_ok
	; overwrite number of items
	ld [wNumScrollMenuItems], a
.num_items_ok
	call .PrintRecordEntries
.loop_input
	call DoFrame
	call HandleMenuInput
	jr nc, .loop_input
	cp $ff
	ret z
	; selected a record entry
	call .LoadRecord
	ldh a, [hKeysPressed]
	and A_BUTTON
	jr nz, .show_record_page
	ld hl, wCardPopRecordYourCardID
	ld e, [hl]
	inc hl
	ld d, [hl]
	call LoadCardDataToBuffer1_FromCardID
	bank1call OpenCardPage_FromHand
	jr .init_list

.show_record_page
	; opens page to show details about this record
	call EmptyScreen
	lb de, 0, 0
	lb bc, 20, 10
	call DrawRegularTextBox
	lb de, 0, 10
	lb bc, 20, 8
	call DrawRegularTextBox
	ld hl, .text_items
	call PlaceTextItems
	lb de, 1, 0
	ld a, 11
	call ZeroAttributesAtDE
	lb de, 1, 10
	ld a, 5
	call ZeroAttributesAtDE

	lb de, 8, 2
	ld hl, wCardPopRecord
	call .PrintText
	ld a, [wCardPopRecordType]
	cp IRPARAM_RARE_CARD_POP
	jr nz, .rare_card_pop_1
	ldtx hl, Text0014
	lb de, 15, 2
	call InitTextPrinting_ProcessTextFromID
.rare_card_pop_1
	ld a, [wCardPopRecordNumCoins]
	lb bc, 13, 4
	bank1call WriteTwoDigitNumberInTxSymbolFormat
	ld hl, wCardPopRecordNumCards
	ld c, 6
	call .PrintNumberAtYCoord
	ld hl, wCardPopRecordNumBattles
	ld c, 8
	call .PrintNumberAtYCoord
	lb de, 4, 13
	ld hl, wCardPopRecordYourCardID
	call .PrintCardName
	lb de, 4, 16
	ld hl, wCardPopRecordTheirCardID
	call .PrintCardName

	; chooses a portrait based on player name
	ld a, [wCardPopRecordName + $d]
	ld e, a
	ld d, $00
	ld hl, .DuelistIDs
	add hl, de
	ld a, [hl]
	ld e, PORTRAITVARIANT_NORMAL
	lb bc, 1, 2
	call DrawNPCPortrait

	call EnableLCD
.loop_record_page_input
	call DoFrame
	ldh a, [hDPadHeld]
	bit START_F, a
	jr nz, .open_card_page
	bit D_UP_F, a
	jr nz, .show_previous_record
	bit D_DOWN_F, a
	jr nz, .show_next_record
	and A_BUTTON | B_BUTTON
	jr z, .loop_record_page_input
	jp .init_list

.open_card_page
	ld hl, wCardPopRecordTheirCardID
	ld e, [hl]
	inc hl
	ld d, [hl]
	call LoadCardDataToBuffer1_FromCardID
	bank1call OpenCardPage_FromHand
	jp .show_record_page

.show_previous_record
	ldh a, [hCurScrollMenuItem]
	or a
	jp z, .show_record_page
	dec a
	jr .update_menu_item
.show_next_record
	ldh a, [hCurScrollMenuItem]
	ld hl, wNumCardPopRecords
	inc a
	cp [hl]
	jp nc, .show_record_page
.update_menu_item
	ldh [hCurScrollMenuItem], a
	call .LoadRecord
	jp .show_record_page

; hl = pointer to card ID
; de = coordinates
.PrintCardName:
	push de
	ld e, [hl]
	inc hl
	ld d, [hl]
	call LoadCardDataToBuffer1_FromCardID
	ld a, 14
	call CopyCardNameAndLevel
	pop de
	ld hl, wDefaultText
	call .PrintText
	ret

; c = y coordinate
.PrintNumberAtYCoord:
	ld b, 12 ; x coordinate
	ld a, [hli]
	ld h, [hl]
	ld l, a
	bank1call Func_6079
	ret

.text_items
	textitem 1,  0, Text0266
	textitem 8,  4, Text0267
	textitem 8,  6, Text0268
	textitem 8,  8, Text0269
	textitem 1, 10, Text026a
	textitem 1, 12, Text026b
	textitem 1, 15, Text026c
	db $ff ; end

.DuelistIDs
	db NPC_MARK
	db NPC_MINT
	db NPC_RONALD
	db NPC_IMAKUNI_BLACK
	db NPC_IMAKUNI_RED

.DrawSlashAndTopLineSeparator:
	lb bc, 17, 1
	ld a, [wNumCardPopRecords]
	bank1call WriteTwoDigitNumberInTxSymbolFormat
	ld hl, .SlashAndLineSeparatorTileData
	call WriteDataBlocksToBGMap0
	call BankswitchVRAM1
	ld hl, .LineSeparatorAttributes
	call WriteDataBlocksToBGMap0
	call BankswitchVRAM0
	ret

.SlashAndLineSeparatorTileData:
	db 16, 1, $2e, 0 ; slash
	db  0, 2, $1c, $1c, $1c, $1c, $1c, $1c, $1c, $1c, $1c, $1c, $1c, $1c, $1c, $1c, $1c, $1c, $1c, $1c, $1c, $1c, 0
	db $ff ; end

.LineSeparatorAttributes:
	db 0, 2, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, 0
	db $ff ; end

.CountNumberOfRecords:
	ld a, BANK("SRAM1")
	call BankswitchSRAM
	ld c, -1
	ld hl, sCardPopRecords - CARDPOP_RECORD_SIZE
	ld de, CARDPOP_RECORD_SIZE
.loop_records
	inc c
	add hl, de
	ld a, c
	cp MAX_NUM_CARDPOP_RECORDS + 1
	jr z, .got_count
	ld a, [hl]
	or a
	jr nz, .loop_records
.got_count
	ld a, c
	ld [wNumCardPopRecords], a
	xor a
	call BankswitchSRAM
	call DisableSRAM
	ret

; loads record with index in register a
; from SRAM to wCardPopRecord
.LoadRecord:
	ld l, a
	ld h, CARDPOP_RECORD_SIZE
	call HtimesL
	ld de, sCardPopRecords
	add hl, de
	ld a, BANK("SRAM1")
	call BankswitchSRAM
	ld de, wCardPopRecord
	ld bc, CARDPOP_RECORD_SIZE
	call CopyDataHLtoDE
	xor a
	call BankswitchSRAM
	call DisableSRAM
	ret

.MenuParams:
	db 1 ; x pos
	db 4 ; y pos
	db 3 ; y spacing
	db 5 ; num entries
	db SYM_CURSOR_R ; visible cursor tile
	db SYM_SPACE ; invisible cursor tile
	dw .HandleMenuInput ; wCardListHandlerFunction

.HandleMenuInput:
	ldh a, [hDPadHeld]
	ld b, a
	and D_PAD
	jr z, .got_cur_menu_item
	bit D_UP_F, b
	jr nz, .d_up
	bit D_DOWN_F, b
	jr nz, .d_down
	bit D_RIGHT_F, b
	jr nz, .d_right

; d left
	ld hl, wce28
	ld a, [hl]
	or a
	jr z, .got_cur_menu_item
	sub 5
	jr nc, .asm_1a252
	xor a
.asm_1a252
	ld [hl], a
	jr .update_list_entries

.d_right
	ld a, [wNumCardPopRecords]
	ld e, a
	ld hl, wce28
	ld a, [hl]
	add 5
	cp e
	jr nc, .got_cur_menu_item
	ld [hl], a
	add 5
	cp e
	jr c, .update_list_entries
	ld a, e
	sub 5
	ld [hl], a
	jr .update_list_entries

.d_up
	ld hl, wCurMenuItem
	ld a, [wNumScrollMenuItems]
	dec a
	cp [hl]
	jr nz, .update_highlighted_record_number
	xor a
	ld [wCurMenuItem], a
	ld hl, wce28
	ld a, [hl]
	or a
	jr z, .update_highlighted_record_number
	dec [hl]
	jr .update_list_entries

.d_down
	ld hl, wCurMenuItem
	ld a, [hl]
	or a
	jr nz, .update_highlighted_record_number
	ld a, [wNumScrollMenuItems]
	dec a
	ld [hl], a
	ld hl, wce28
	add [hl]
	inc a
	ld hl, wNumCardPopRecords
	cp [hl]
	jr nc, .update_highlighted_record_number
	ld hl, wce28
	inc [hl]

.update_list_entries
	call .PrintRecordEntries
	jr .got_cur_menu_item
.update_highlighted_record_number
	call .UpdateHighlightedRecordNumber
.got_cur_menu_item
	ld a, [wCurMenuItem]
	ld hl, wce28
	add [hl]
	ldh [hCurScrollMenuItem], a

	ldh a, [hKeysPressed]
	and A_BUTTON | START
	jr nz, .a_btn_or_start
	ldh a, [hKeysPressed]
	and B_BUTTON
	ret z
; cancel
	ld a, $ff
	ldh [hCurScrollMenuItem], a
.a_btn_or_start
	scf
	ret

.UpdateHighlightedRecordNumber:
	ld a, [wCurMenuItem]
	ld hl, wce28
	add [hl]
	inc a
	lb bc, 14, 1
	bank1call WriteTwoDigitNumberInTxSymbolFormat
	ret

.PrintRecordEntries:
	lb de, 1, 1
	ldtx hl, Text0263
	call InitTextPrinting_ProcessTextFromID
	ld a, $04
	ld [wce2a], a
	call .UpdateHighlightedRecordNumber

	; up arrow in list
	ld e, SYM_SPACE
	ld a, [wce28]
	ld [wce29], a
	or a
	jr z, .got_up_arrow_tile
	ld e, SYM_CURSOR_U
.got_up_arrow_tile
	ld a, e
	lb bc, 18, 4
	call WriteByteToBGMap0

	; down arrow in list
	ld e, SYM_SPACE
	ld a, [wce28]
	add 5
	ld hl, wNumCardPopRecords
	cp [hl]
	jr nc, .got_down_arrow_tile
	ld e, SYM_CURSOR_D
.got_down_arrow_tile
	ld a, e
	lb bc, 18, 17
	call WriteByteToBGMap0

.loop_visible_record_entries
	ld a, [wce29]
	call .LoadRecord
	ld a, [wce2a]
	ld e, a
	ld d, 2
	ldtx hl, Text0264
	ld a, [wCardPopRecordType]
	cp IRPARAM_RARE_CARD_POP
	jr nz, .rare_card_pop_2
	ldtx hl, Text0265
.rare_card_pop_2
	push de
	call InitTextPrinting_ProcessTextFromID
	pop de

	ld d, 7
	ld hl, wCardPopRecord
	call .PrintText
	ld hl, wCardPopRecordYourCardID
	ld e, [hl]
	inc hl
	ld d, [hl]
	call LoadCardDataToBuffer1_FromCardID
	ld a, 14
	call CopyCardNameAndLevel
	ld a, [wce2a]
	inc a
	ld e, a
	ld d, 4
	ld hl, wDefaultText
	call .PrintText
	ld hl, wce29
	inc [hl]
	ld a, [wNumCardPopRecords]
	cp [hl]
	jr z, .done_print_entries
	ld hl, wce2a
	ld a, [hl]
	add $03
	ld [hl], a
	cp $12
	jr c, .loop_visible_record_entries

.done_print_entries
	ret

.PrintText:
	call InitTextPrinting
	jp ProcessText
; 0x1a36a

SECTION "Bank 6@64b1", ROMX[$64b1], BANK[$6]

; sends serial data to printer
; if there's an error in connection,
; show Printer Not Connected scene with error message
ConnectPrinter:
	ld bc, 0
	lb de, PRINTERPKT_DATA, FALSE
	call SendPrinterPacket
	ret nc ; return if no error

	ld hl, wPrinterStatus
	ld a, [hl]
	or a
	jr nz, .asm_1a4c4
	ld [hl], $ff
.asm_1a4c4
	ld a, [hl]
	cp $ff
	jr z, ShowPrinterIsNotConnected
;	fallthrough

; shows message on screen depending on wPrinterStatus
; also shows SCENE_GAMEBOY_PRINTER_NOT_CONNECTED.
HandlePrinterError:
	ld a, [wPrinterStatus]
	cp $ff
	jr z, .cable_or_printer_switch
	or a
	jr z, .interrupted
	bit PRINTER_ERROR_BATTERIES_LOST_CHARGE, a
	jr nz, .batteries_lost_charge
	bit PRINTER_ERROR_CABLE_PRINTER_SWITCH, a
	jr nz, .cable_or_printer_switch
	bit PRINTER_ERROR_PAPER_JAMMED, a
	jr nz, .jammed_printer

	ldtx hl, Text00f6 ; PrinterPacketErrorText
	ld a, $04
	jr ShowPrinterConnectionErrorScene
.cable_or_printer_switch
	ldtx hl, Text00f5 ; CheckCableOrPrinterSwitchText
	ld a, $04
	jr ShowPrinterConnectionErrorScene
.jammed_printer
	ldtx hl, Text00f4 ; PrinterPaperIsJammedText
	ld a, $04
	jr ShowPrinterConnectionErrorScene
.batteries_lost_charge
	ldtx hl, Text00f3 ; BatteriesHaveLostTheirChargeText
	ld a, $01
	jr ShowPrinterConnectionErrorScene
.interrupted
	ldtx hl, Text00f7 ; PrintingWasInterruptedText
	call DrawWideTextBox_WaitForInput
	scf
	ret

ShowPrinterIsNotConnected:
	ldtx hl, Text00f2 ; PrinterIsNotConnectedText
	ld a, $02
;	fallthrough

; a = error code
; hl = text ID to print in text box
ShowPrinterConnectionErrorScene:
	push hl
	; unnecessary loading TxRam, since the text data
	; already incorporate the error number
	ld l, a
	ld h, $00
	call LoadTxRam3

	call SetSpriteAnimationsAsVBlankFunction
	ld a, SCENE_GAMEBOY_PRINTER_NOT_CONNECTED
	lb bc, 0, 0
	call EmptyScreenAndLoadScene
	pop hl
	call DrawWideTextBox_WaitForInput
	call RestoreVBlankFunction
	scf
	ret

; main card printer function
RequestToPrintCard:
	call LoadCardDataToBuffer1_FromCardID
	call SetSpriteAnimationsAsVBlankFunction
	ld a, SCENE_GAMEBOY_PRINTER_TRANSMITTING
	lb bc, 0, 0
	call EmptyScreenAndLoadScene
	ld a, 20
	call CopyCardNameAndLevel
	ld [hl], TX_END
	ld hl, $0
	call LoadTxRam2
	ldtx hl, Text0248
	call DrawWideTextBox_PrintText
	call EnableLCD
	call PrepareForPrinterCommunications
	call .DrawTopCardInfoInSRAMGfxBuffer0
	call Func_19f87
	call .DrawCardPicInSRAMGfxBuffer2
	call Func_19f99
	jr c, .error
	call DrawBottomCardInfoInSRAMGfxBuffer0
	call Func_1a011
	jr c, .error
	call RestoreVBlankFunction
	call ResetPrinterCommunicationSettings
	or a
	ret
.error
	call RestoreVBlankFunction
	call ResetPrinterCommunicationSettings
	jp HandlePrinterError

; draw card's picture in sGfxBuffer2
.DrawCardPicInSRAMGfxBuffer2:
	ld hl, wLoadedCard1Gfx
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld de, sGfxBuffer2
	call Func_1adbd
	ld a, $40
	lb hl, 12,  1
	lb de,  2, 68
	lb bc, 16, 12
	call FillRectangle
	ret

; writes the tiles necessary to draw
; the card's information in sGfxBuffer0
; this includes card's type, lv, HP and attacks if Pokemon card
; or otherwise just the card's name and type symbol
.DrawTopCardInfoInSRAMGfxBuffer0:
	call Func_1a025
	call Func_212f

	; draw empty text box frame
	ld hl, sGfxBuffer0
	ld a, $34
	lb de, $30, $31
	ld b, 20
	call CopyLine
	ld c, 15
.loop_lines
	xor a ; SYM_SPACE
	lb de, $36, $37
	ld b, 20
	call CopyLine
	dec c
	jr nz, .loop_lines

	; draw card type symbol
	ld a, $38
	lb hl, 1,  2
	lb de, 1, 65
	lb bc, 2,  2
	call FillRectangle
	; print card's name
	lb de, 4, 65
	ld hl, wLoadedCard1Name
	call InitTextPrinting_ProcessTextFromPointerToID

; prints card's type, lv, HP and attacks if it's a Pokemon card
	ld a, [wLoadedCard1Type]
	cp TYPE_ENERGY
	jr nc, .skip_pokemon_data
	inc a ; symbol corresponding to card's type (color)
	lb bc, 18, 65
	call WriteByteToBGMap0
	ld a, SYM_Lv
	lb bc, 11, 66
	call WriteByteToBGMap0
	ld a, [wLoadedCard1Level]
	lb bc, 12, 66
	bank1call WriteTwoDigitNumberInTxSymbolFormat
	ld a, SYM_HP
	lb bc, 15, 66
	call WriteByteToBGMap0
	ld a, [wLoadedCard1HP]
	inc b
	bank1call WriteTwoByteNumberInTxSymbolFormat
.skip_pokemon_data
	ret

Func_19f87:
	call TryInitPrinterCommunications
	ret c ; aborted
	ld hl, sGfxBuffer0
	call SendTilesToPrinter
	ret c
	call SendTilesToPrinter
	call SendPrinterInstructionPacket_1Sheet
	ret

Func_19f99:
	call TryInitPrinterCommunications
	ret c
	ld hl, sGfxBuffer0 + $8 tiles
	ld c, $06
.asm_19fa2
	call SendTilesToPrinter
	ret c
	dec c
	jr nz, .asm_19fa2
	call SendPrinterInstructionPacket_1Sheet
	ret

; writes the tiles necessary to draw
; the card's information in sGfxBuffer0
; this includes card's Retreat cost, Weakness, Resistance,
; and attack if it's Pokemon card
; or otherwise just the card's description.
DrawBottomCardInfoInSRAMGfxBuffer0:
	call Func_1a025
	xor a
	ld [wCardPageType], a
	ld hl, sGfxBuffer0
	ld b, 20
	ld c, 9
.loop_lines
	xor a ; SYM_SPACE
	lb de, $36, $37
	call CopyLine
	dec c
	jr nz, .loop_lines
	ld a, $35
	lb de, $32, $33
	call CopyLine

	ld a, [wLoadedCard1Type]
	cp TYPE_ENERGY
	jr nc, .not_pkmn_card
	ld hl, RetreatWeakResistData
	call PlaceTextItems
	ld c, 66
	bank1call DisplayCardPage_PokemonOverview.attacks

	ld a, SYM_No
	lb bc, 15, 72
	call WriteByteToBGMap0
	inc b
	ld a, [wLoadedCard1PokedexNumber]
	bank1call WriteTwoByteNumberInTxSymbolFormat
	ret

.not_pkmn_card
	bank1call SetNoLineSeparation
	lb de, 1, 66
	ld a, SYM_No
	call InitTextPrintingInTextbox
	ld hl, wLoadedCard1NonPokemonDescription
	call ProcessTextFromPointerToID
	bank1call SetOneLineSeparation
	ret

RetreatWeakResistData:
	textitem 1, 70, Text0007
	textitem 1, 71, Text0008
	textitem 1, 72, Text0009
	db $ff

Func_1a011:
	call TryInitPrinterCommunications
	ret c
	ld hl, sGfxBuffer0
	ld c, $05
.asm_1a01a
	call SendTilesToPrinter
	ret c
	dec c
	jr nz, .asm_1a01a
	call SendPrinterInstructionPacket_1Sheet_3LineFeeds
	ret

; calls setup text and sets wTilePatternSelector
Func_1a025:
	lb de, $40, $bf
	call SetupText
	ld a, $a4
	ld [wTilePatternSelector], a
	xor a
	ld [wTilePatternSelectorCorrection], a
	ret

; switches to CGB normal speed, resets serial
; enables SRAM and switches to SRAM1
; and clears sGfxBuffer0
PrepareForPrinterCommunications:
	call SwitchToCGBNormalSpeed
	call ResetSerial
	ld a, $10
	ld [wPrinterNumberLineFeeds], a
	call EnableSRAM
	ld a, [sPrinterContrastLevel]
	ld [wPrinterContrastLevel], a
	ldh a, [hBankSRAM]
	ld [wTempPrinterSRAM], a
	ld a, BANK("SRAM3")
	call BankswitchSRAM
	call EnableSRAM
;	fallthrough

ClearPrinterGfxBuffer:
	ld hl, sGfxBuffer0
	ld bc, $400
.loop
	xor a
	ld [hli], a
	dec bc
	ld a, c
	or b
	jr nz, .loop
	xor a
	ld [wce9f], a
	ret

; reverts settings changed by PrepareForPrinterCommunications
ResetPrinterCommunicationSettings:
	push af
	call SwitchToCGBDoubleSpeed
	ld a, [wTempPrinterSRAM]
	call BankswitchSRAM
	call DisableSRAM
	lb de, $30, $bf
	call SetupText
	pop af
	ret

	; send some bytes through serial
Func_1a080: ; unreferenced
	ld bc, 0
	lb de, PRINTERPKT_NUL, FALSE
	jp SendPrinterPacket

; tries initiating the communications for
; sending data to printer
; returns carry if operation was cancelled
; by pressing B button or serial transfer took long
TryInitPrinterCommunications:
	xor a
	ld [wPrinterInitAttempts], a
.wait_input
	call DoFrame
	ldh a, [hKeysHeld]
	and B_BUTTON
	jr nz, .b_button
	ld bc, 0
	lb de, PRINTERPKT_NUL, FALSE
	call SendPrinterPacket
	jr c, .delay
	and (1 << PRINTER_STATUS_BUSY) | (1 << PRINTER_STATUS_PRINTING)
	jr nz, .wait_input

.init
	ld bc, 0
	lb de, PRINTERPKT_INIT, FALSE
	call SendPrinterPacket
	jr nc, .no_carry
	ld hl, wPrinterInitAttempts
	inc [hl]
	ld a, [hl]
	cp 3
	jr c, .wait_input
	; time out
	scf
	ret
.no_carry
	ret

.b_button
	xor a
	ld [wPrinterStatus], a
	scf
	ret

.delay
	ld c, 10
.delay_loop
	call DoFrame
	dec c
	jr nz, .delay_loop
	jr .init

; loads tiles given by map in hl to sGfxBuffer5
; copies first 20 tiles, then offsets by 2 tiles
; and copies another 20
; compresses this data and sends it to printer
SendTilesToPrinter:
	push bc
	ld de, sGfxBuffer5
	call .Copy20Tiles
	call .Copy20Tiles
	push hl
	call CompressDataForPrinterSerialTransfer
	call SendPrinterPacket
	pop hl
	pop bc
	ret

; copies 20 tiles given by hl to de
; then adds 2 tiles to hl
.Copy20Tiles
	push hl
	ld c, 20
.loop_tiles
	ld a, [hli]
	call .CopyTile
	dec c
	jr nz, .loop_tiles
	pop hl
	ld bc, 2 tiles
	add hl, bc
	ret

; copies a tile to de
; a = tile to get from sGfxBuffer1
.CopyTile
	push hl
	push bc
	ld l, a
	ld h, $00
	add hl, hl
	add hl, hl
	add hl, hl
	add hl, hl ; *TILE_SIZE
	ld bc, sGfxBuffer1
	add hl, bc
	ld c, TILE_SIZE
.loop_copy
	ld a, [hli]
	ld [de], a
	inc de
	dec c
	jr nz, .loop_copy
	pop bc
	pop hl
	ret

SendPrinterInstructionPacket_1Sheet_3LineFeeds:
	call GetPrinterContrastSerialData
	push hl
	lb hl, 3, 1
	jr SendPrinterInstructionPacket

; uses wPrinterNumberLineFeeds to get number
; of line feeds to insert before print
SendPrinterInstructionPacket_1Sheet:
	call GetPrinterContrastSerialData
	push hl
	ld hl, wPrinterNumberLineFeeds
	ld a, [hl]
	ld [hl], $00
	ld h, a
	ld l, 1
;	fallthrough

; h = number of line feeds where:
;     high nybble is number of line feeds before printing
;     low nybble is number of line feeds after printing
; l = number of sheets
; expects printer contrast information to be on stack
SendPrinterInstructionPacket:
	push hl
	ld bc, 0
	lb de, PRINTERPKT_DATA, FALSE
	call SendPrinterPacket
	jr c, .aborted
	ld hl, sp+$00 ; contrast level bytes
	ld bc, 4 ; instruction packets are 4 bytes in size
	lb de, PRINTERPKT_PRINT_INSTRUCTION, FALSE
	call SendPrinterPacket
.aborted
	pop hl
	pop hl
	ret

	; returns in h and l the bytes
; to be sent through serial to the printer
; for the set contrast level
GetPrinterContrastSerialData:
	ld a, [wPrinterContrastLevel]
	ld e, a
	ld d, $00
	ld hl, .contrast_level_data
	add hl, de
	ld h, [hl]
	ld l, %11100100 ; palette format
	ret

.contrast_level_data
	db $00, $20, $40, $60, $7f

Func_1a14b: ; unreferenced
	ld a, $01
	jr .asm_1a15d
	ld a, $02
	jr .asm_1a15d
	ld a, $03
	jr .asm_1a15d
	ld a, $04
	jr .asm_1a15d
	ld a, $05
.asm_1a15d
	ld [wce9d], a
	scf
	ret

; a = saved deck index to print
PrintDeckConfiguration:
; copies selected deck from SRAM to wDuelTempList
	call EnableSRAM
	ld l, a
	ld h, DECK_COMPRESSED_STRUCT_SIZE
	call HtimesL
	ld de, sSavedDecks
	add hl, de
	ld de, wDuelTempList
	ld bc, DECK_COMPRESSED_STRUCT_SIZE
	call CopyDataHLtoDE
	call DisableSRAM

	call ShowPrinterTransmitting
	call PrepareForPrinterCommunications
	call Func_1a025
	call Func_212f
	lb de, 0, 64
	lb bc, 20, 4
	call DrawRegularTextBoxDMG
	lb de, 4, 66
	call InitTextPrinting
	ld hl, wDuelTempList ; print deck name
	call ProcessText
	ldtx hl, Text0022 ; DeckPrinterText
	call ProcessTextFromID

	ld a, 5
	ld [wPrinterHorizontalOffset], a
	ld hl, wPrinterTotalCardCount
	xor a
	ld [hli], a
	ld [hl], a
	ld [wPrintOnlyStarRarity], a

	ld hl, wCurDeckCards
.loop_cards
	ld a, [hli]
	ld e, a
	ld d, [hl]
	inc hl
	or d
	jr z, .asm_1a1d6
	call LoadCardDataToBuffer1_FromCardID

	; find out this card's count
	ld c, 1
.loop_card_count
	ld a, e
	cp [hl]
	jr nz, .got_card_count
	inc hl
	ld a, d
	cp [hl]
	jr nz, .got_card_count
	inc hl
	inc c
	jr .loop_card_count

.got_card_count
	ld a, c
	ld [wPrinterCardCount], a
	call LoadCardInfoForPrinter
	call AddToPrinterGfxBuffer
	jr c, .printer_error
	jr .loop_cards

.asm_1a1d6
	call SendCardListToPrinter
	jr c, .printer_error
	call ResetPrinterCommunicationSettings
	call RestoreVBlankFunction
	or a
	ret

.printer_error
	call ResetPrinterCommunicationSettings
	call RestoreVBlankFunction
	jp HandlePrinterError

SendCardListToPrinter:
	ld a, [wPrinterHorizontalOffset]
	cp 1
	jr z, .skip_load_gfx
	call LoadGfxBufferForPrinter
	ret c
.skip_load_gfx
	call TryInitPrinterCommunications
	ret c
	call SendPrinterInstructionPacket_1Sheet_3LineFeeds
	ret

; increases printer horizontal offset by 2
AddToPrinterGfxBuffer:
	push hl
	ld hl, wPrinterHorizontalOffset
	inc [hl]
	inc [hl]
	ld a, [hl]
	pop hl
	; return no carry if below 18
	cp 18
	ccf
	ret nc
	; >= 18
;	fallthrough

; copies Gfx to Gfx buffer and sends some serial data
; returns carry set if unsuccessful
LoadGfxBufferForPrinter:
	push hl
	call TryInitPrinterCommunications
	jr c, .set_carry
	ld a, [wPrinterHorizontalOffset]
	srl a
	ld c, a
	ld hl, sGfxBuffer0
.loop_gfx_buffer
	call SendTilesToPrinter
	jr c, .set_carry
	dec c
	jr nz, .loop_gfx_buffer
	call SendPrinterInstructionPacket_1Sheet
	jr c, .set_carry

	call ClearPrinterGfxBuffer
	ld a, 1
	ld [wPrinterHorizontalOffset], a
	pop hl
	or a
	ret

.set_carry
	pop hl
	scf
	ret

; load symbol, name, level and card count to buffer
LoadCardInfoForPrinter:
	push hl
	ld a, [wPrinterHorizontalOffset]
	or %1000000
	ld e, a
	ld d, 3
	ld a, [wPrintOnlyStarRarity]
	or a
	jr nz, .skip_card_symbol
	ld hl, wPrinterTotalCardCount
	ld a, [hli]
	or [hl]
	call z, DrawCardSymbol
.skip_card_symbol
	ld a, 14
	call CopyCardNameAndLevel
	call InitTextPrinting
	ld hl, wDefaultText
	call ProcessText
	ld a, [wPrinterHorizontalOffset]
	or %1000000
	ld c, a
	ld b, 16
	ld a, SYM_CROSS
	call WriteByteToBGMap0
	inc b
	ld a, [wPrinterCardCount]
	bank1call WriteTwoDigitNumberInTxSymbolFormat
	pop hl
	ret

PrintCardList:
; if Select button is held when printing card list
; only print cards with Star rarity (excluding Promotional cards)
; even if it's not marked as seen in the collection
	ld e, FALSE
	ldh a, [hKeysHeld]
	and SELECT
	jr z, .no_select
	inc e ; TRUE
.no_select
	ld a, e
	ld [wPrintOnlyStarRarity], a

	call ShowPrinterTransmitting
	bank1call CreateTempCardCollection
	ld de, wDefaultText
	call CopyPlayerName
	call PrepareForPrinterCommunications
	call Func_1a025
	call Func_212f

	lb de, 0, 64
	lb bc, 20, 4
	call DrawRegularTextBoxDMG
	ld a, PLAYER_TURN
	ldh [hWhoseTurn], a
	lb de, 2, 66
	call InitTextPrinting
	ld hl, wDefaultText
	call ProcessText
	ldtx hl, Text0016 ; AllCardsOwnedText
	call ProcessTextFromID
	ld a, [wPrintOnlyStarRarity]
	or a
	jr z, .asm_1a2c2
	lb de, 4, 85
	call Func_22ca
.asm_1a2c2
	ld a, $ff
	ld [wCurPrinterCardType], a
	xor a
	ld hl, wPrinterTotalCardCount
	ld [hli], a
	ld [hl], a
	ld hl, wPrinterNumCardTypes
	ld [hli], a
	ld [hl], a
	ld a, 5
	ld [wPrinterHorizontalOffset], a

	ld de, GRASS_ENERGY
.loop_cards
	push de
	call LoadCardDataToBuffer1_FromCardID
	jr c, .done_card_loop
	ld hl, wTempCardCollection
	add hl, de
	ld a, [hl] ; card ID count in collection
	ld [wPrinterCardCount], a
	call .LoadCardTypeEntry
	jr c, .printer_error_pop_de

	ld a, [wPrintOnlyStarRarity]
	or a
	jr z, .all_owned_cards_mode
	ld a, [wLoadedCard1Set]
	and %11110000
	cp $40 ; PROMOTIONAL
	jr z, .next_card
	ld a, [wLoadedCard1Rarity]
	cp STAR
	jr nz, .next_card
	; not Promotional, and Star rarity
	ld hl, wPrinterCardCount
	res CARD_NOT_OWNED_F, [hl]
	jr .got_card_count

.all_owned_cards_mode
	ld a, [wPrinterCardCount]
	or a
	jr z, .next_card
	cp CARD_NOT_OWNED
	jr z, .next_card ; ignore not owned cards

.got_card_count
	ld a, [wPrinterCardCount]
	and CARD_COUNT_MASK
	ld c, a

	; add to total card count
	ld hl, wPrinterTotalCardCount
	add [hl]
	ld [hli], a
	ld a, 0
	adc [hl]
	ld [hl], a

	; add to current card type count
	ld hl, wPrinterCurCardTypeCount
	ld a, c
	add [hl]
	ld [hli], a
	ld a, 0
	adc [hl]
	ld [hl], a

	ld hl, wPrinterNumCardTypes
	inc [hl]
	jr nz, .asm_1a99d
	inc hl
	inc [hl]
.asm_1a99d
	ld hl, wce98
	inc [hl]
	call LoadCardInfoForPrinter
	call AddToPrinterGfxBuffer
	jr c, .printer_error_pop_de
.next_card
	pop de
	inc de
	jr .loop_cards

.printer_error_pop_de
	pop de
.printer_error
	call ResetPrinterCommunicationSettings
	call RestoreVBlankFunction
	jp HandlePrinterError

.done_card_loop
	pop de
	; add separator line
	ld a, [wPrinterHorizontalOffset]
	dec a
	or $40
	ld c, a
	ld b, 0
	call BCCoordToBGMap0Address
	ld a, $35
	lb de, $35, $35
	ld b, 20
	call CopyLine
	call AddToPrinterGfxBuffer
	jr c, .printer_error

	ld hl, wPrinterTotalCardCount
	ld c, [hl]
	inc hl
	ld b, [hl]
	ldtx hl, Text0017 ; TotalNumberOfCardsText
	call .PrintTextWithNumber
	jr c, .printer_error
	ld a, [wPrintOnlyStarRarity]
	or a
	jr nz, .done
	ld hl, wPrinterNumCardTypes
	ld c, [hl]
	inc hl
	ld b, [hl]
	ldtx hl, Text0018 ; TypesOfCardsText
	call .PrintTextWithNumber
	jr c, .printer_error

.done
	call SendCardListToPrinter
	jr c, .printer_error
	call ResetPrinterCommunicationSettings
	call RestoreVBlankFunction
	or a
	ret

; prints text ID given in hl
; with decimal representation of
; the number given in bc
; hl = text ID
; bc = number
.PrintTextWithNumber
	push bc
	ld a, [wPrinterHorizontalOffset]
	dec a
	or $40
	ld e, a
	ld d, 2
	call InitTextPrinting
	call ProcessTextFromID
	ld d, 14
	call InitTextPrinting
	pop hl
	call TwoByteNumberToTxSymbol_TrimLeadingZeros
	ld hl, wStringBuffer
	call ProcessText
	call AddToPrinterGfxBuffer
	ret

; loads this card's type icon and text
; if it's a new card type that hasn't been printed yet
.LoadCardTypeEntry
	ld a, [wLoadedCard1Type]
	ld c, a
	cp TYPE_ENERGY
	jr c, .got_type ; jump if Pokemon card
	ld c, $08
	cp TYPE_TRAINER
	jr nc, .got_type ; jump if Trainer card
	ld c, $07
.got_type
	ld hl, wCurPrinterCardType
	ld a, [hl]
	cp c
	ret z ; already handled this card type

	; show corresponding icon and text
	; for this new card type
	ld a, c
	ld [hl], a ; set it as current card type
	add a
	add c ; *3
	ld c, a
	ld b, $00
	ld hl, .IconTextList
	add hl, bc
	ld a, [wPrinterHorizontalOffset]
	dec a
	or %1000000
	ld e, a
	ld d, 1
	ld a, [hli]
	push hl
	lb bc, 2, 2
	lb hl, 1, 2
	call FillRectangle
	pop hl
	ld d, 3
	inc e
	call InitTextPrinting
	ld a, [hli]
	ld h, [hl]
	ld l, a
	call ProcessTextFromID

	call AddToPrinterGfxBuffer
	ld hl, wPrinterCurCardTypeCount
	xor a
	ld [hli], a
	ld [hl], a
	ld [wce98], a
	ret

.IconTextList
	; Fire
	db $e0 ; icon tile
	tx Text001a ; FirePokemonText

	; Grass
	db $e4 ; icon tile
	tx Text0019 ; GrassPokemonText

	; Lightning
	db $e8 ; icon tile
	tx Text001c ; LightningPokemonText

	; Water
	db $ec ; icon tile
	tx Text001b ; WaterPokemonText

	; Fighting
	db $f0 ; icon tile
	tx Text001d ;FightingPokemonText

	; Psychic
	db $f4 ; icon tile
	tx Text001e ; PsychicPokemonText

	; Colorless
	db $f8 ; icon tile
	tx Text001f ; ColorlessPokemonText

	; Energy
	db $fc ; icon tile
	tx Text0021 ; EnergyCardText

	; Trainer
	db $dc ; icon tile
	tx Text0020 ; TrainerCardText

ShowPrinterTransmitting:
	call SetSpriteAnimationsAsVBlankFunction
	ld a, SCENE_GAMEBOY_PRINTER_TRANSMITTING
	lb bc, 0, 0
	call EmptyScreenAndLoadScene
	ldtx hl, Text023b ; NowPrintingPleaseWaitText
	call DrawWideTextBox_PrintText
	call EnableLCD
	ret

; compresses $28 tiles in sGfxBuffer5
; and writes it in sGfxBuffer5 + $28 tiles.
; compressed data has 2 commands to instruct on how to decompress it.
; - a command byte with bit 7 not set, means to copy that many + 1
; bytes that are following it literally.
; - a command byte with bit 7 set, means to copy the following byte
; that many times + 2 (after masking the top bit of command byte).
; returns in bc the size of the compressed data and
; in de the packet type data.
CompressDataForPrinterSerialTransfer:
	ld hl, sGfxBuffer5
	ld de, sGfxBuffer5 + $28 tiles
	ld bc, $28 tiles
.loop_remaining_data
	ld a, $ff
	inc b
	dec b
	jr nz, .check_compression
	ld a, c
.check_compression
	push bc
	push de
	ld c, a
	call CheckDataCompression
	ld a, e
	ld c, e
	pop de
	jr c, .copy_byte
	ld a, c
	ld b, c
	dec a
	ld [de], a ; number of bytes to  copy literally - 1
	inc de
.copy_literal_sequence
	ld a, [hli]
	ld [de], a
	inc de
	dec c
	jr nz, .copy_literal_sequence
	ld c, b
	jr .sub_added_bytes

.copy_byte
	ld a, c
	dec a
	dec a
	or %10000000 ; set high bit
	ld [de], a ; = (n times to copy - 2) | %10000000
	inc de
	ld a, [hl] ; byte to copy n times
	ld [de], a
	inc de
	ld b, $0
	add hl, bc

.sub_added_bytes
	ld a, c
	cpl
	inc a
	pop bc
	add c
	ld c, a
	ld a, $ff
	adc b
	ld b, a
	or c
	jr nz, .loop_remaining_data

	ld hl, $10000 - (sGfxBuffer5 + $28 tiles)
	add hl, de ; gets the size of the compressed data
	ld c, l
	ld b, h
	ld hl, sGfxBuffer5 + $28 tiles
	lb de, PRINTERPKT_DATA, TRUE
	ret

; checks whether the next byte sequence in hl, up to c bytes, can be compressed
; returns carry if the next sequence of bytes can be compressed,
; i.e. has at least 3 consecutive bytes with the same value.
; in that case, returns in e the number of consecutive
; same value bytes that were found.
; if there are no bytes with same value, then count as many bytes left
; as possible until either there are no more remaining data bytes,
; or until a sequence of 3 bytes with the same value are found.
; in that case, the number of bytes in this sequence is returned in e.
CheckDataCompression:
	push hl
	ld e, c
	ld a, c
; if number of remaining bytes is less than 4
; then no point in compressing
	cp 4
	jr c, .no_carry

; check first if there are at least
; 3 consecutive bytes with the same value
	ld b, c
	ld a, [hli]
	cp [hl]
	inc hl
	jr nz, .literal_copy ; not same
	cp [hl]
	inc hl
	jr nz, .literal_copy ; not same

; 3 consecutive bytes were found with same value
; keep track of how many consecutive bytes
; with the same value there are in e
	dec c
	dec c
	dec c
	ld e, 3
.loop_same_value
	cp [hl]
	jr nz, .set_carry ; exit when a different byte is found
	inc hl
	inc e
	dec c
	jr z, .set_carry ; exit when there is no more remaining data
	bit 5, e
	; exit if number of consecutive bytes >= $20
	jr z, .loop_same_value
.set_carry
	pop hl
	scf
	ret

.literal_copy
; consecutive bytes are not the same value
; count the number of bytes there are left
; until a sequence of 3 bytes with the same value is found
	pop hl
	push hl
	ld c, b ; number of remaining bytes
	ld e, 1
	ld a, [hli]
	dec c
	jr z, .no_carry ; exit if no more data
.reset_same_value_count
	ld d, 2 ; number of consecutive same value bytes to exit
.next_byte
	inc e
	dec c
	jr z, .no_carry
	bit 7, e
	jr nz, .no_carry ; exit if >= $80
	cp [hl]
	jr z, .same_consecutive_value
	ld a, [hli]
	jr .reset_same_value_count
.no_carry
	pop hl
	or a
	ret

.same_consecutive_value
	inc hl
	dec d
	jr nz, .next_byte
	; 3 consecutive bytes with same value found
	; discard the last 3 bytes in the sequence
	dec e
	dec e
	dec e
	jr .no_carry
; 0x1ab3e

SECTION "Bank 6@6dbd", ROMX[$6dbd], BANK[$6]

Func_1adbd:
	push de
	ld de, wc000
	lb bc, $30, TILE_SIZE
	call Func_2dc4
	pop de
	ld hl, wc000
	ld c, $08
.asm_1adcd
	ld b, $06
.asm_1adcf
	push bc
	ld c, $08
.asm_1add2
	ld b, $02
.asm_1add4
	push bc
	push hl
	ld c, [hl]
	ld b, $04
.asm_1add9
	rr c
	rra
	sra a
	dec b
	jr nz, .asm_1add9
	ld hl, $c0
	add hl, de
	ld [hli], a
	inc hl
	ld [hl], a
	ld b, $04
.asm_1adea
	rr c
	rra
	sra a
	dec b
	jr nz, .asm_1adea
	ld [de], a
	ld hl, $2
	add hl, de
	ld [hl], a
	pop hl
	pop bc
	inc de
	inc hl
	dec b
	jr nz, .asm_1add4
	inc de
	inc de
	dec c
	jr nz, .asm_1add2
	pop bc
	dec b
	jr nz, .asm_1adcf
	ld a, $c0
	add e
	ld e, a
	ld a, $00
	adc d
	ld d, a
	dec c
	jr nz, .asm_1adcd
	ret

LoadHandCardsIcon:
	ld hl, HandCardsGfx
	ld de, v0Tiles2 + $38 tiles
	ld b, 4 tiles
	call Func_1b8f1
	ret

HandCardsGfx:
	INCBIN "gfx/hand_cards.2bpp"

WhatIsYourNameData:
	textitem 1, 1, Text0287
	db $ff ; end
; 0x1ae65

SECTION "Bank 6@6e92", ROMX[$6e92], BANK[$6]

; play different sfx by a.
; if a is 0xff play SFX_03 (usually following a B press),
; else play SFX_02 (usually following an A press).
PlayAcceptOrDeclineSFX_Bank06:
	push af
	inc a
	jr z, .sfx_decline
	ld a, SFX_02
	jr .sfx_accept
.sfx_decline
	ld a, SFX_03
.sfx_accept
	call PlaySFX
	pop af
	ret

; get player name from the user into hl
InputPlayerName:
	ld e, l
	ld d, h
	ld a, MAX_PLAYER_NAME_LENGTH
	ld hl, WhatIsYourNameData
	lb bc, 12, 1
	call InitializeInputName
	call Set_OBJ_8x8

	xor a
	ld [wd3ef], a
	ld [wTileMapFill], a
	call EmptyScreen
	call ZeroObjectPositions
	ld a, $01
	ld [wVBlankOAMCopyToggle], a
	call LoadSymbolsFont
	lb de, $38, $bf
	call SetupText
	call LoadFullWidthTextCursorTile
	xor a ; NAME_MODE_HIRAGANA
	ld [wNamingScreenMode], a

	call UpdateNamingScreenUI

	xor a
	ld [wNamingScreenCursorX], a
	ld [wNamingScreenCursorY], a

	ld a, 9
	ld [wNamingScreenNumColumns], a
	ld a, 7
	ld [wNamingScreenNumRows], a
	ld a, SYM_CURSOR_R
	ld [wMenuVisibleCursorTile], a
	ld a, SYM_SPACE
	ld [wMenuInvisibleCursorTile], a
.loop
	ld a, $01
	ld [wVBlankOAMCopyToggle], a
	call DoFrame

	call UpdateRNGSources

	ldh a, [hDPadHeld]
	and START
	jr z, .check_select
	ld a, $01
	call PlayAcceptOrDeclineSFX_Bank06
	call HideCursorAtCharPosition
	ld a, 6
	ld [wNamingScreenCursorY], a
	inc a ; 7
	ld [wNamingScreenCursorX], a
	call ShowCursorAtCharPosition
	jr .loop

.check_select
	ldh a, [hDPadHeld]
	and SELECT
	jr z, .asm_1af3b
	ld a, $01
	call PlayAcceptOrDeclineSFX_Bank06
	ld a, [wNamingScreenMode]
	inc a
	cp NUM_NAME_MODES
	jr c, .got_mode
	xor a ; NAME_MODE_HIRAGANA
.got_mode
	ld [wNamingScreenMode], a
	xor a
	ld [wNamingScreenCursorX], a
	ld [wNamingScreenCursorY], a
	call UpdateNamingScreenUI
	jr .loop

.asm_1af3b
	call HandleNamingScreenInput
	jr nc, .loop
	cp $ff
	jr z, .remove_last_char
	call SelectKeyboardItem
	jr nc, .loop
	call FinalizeInputName
	ret

.remove_last_char
	ld a, [wNamingScreenBufferLength]
	or a
	jr z, .loop
	ld e, a
	ld d, $00
	ld hl, wNamingScreenBuffer
	add hl, de
	dec hl
	dec hl
	ld [hl], TX_END
	ld hl, wNamingScreenBufferLength
	dec [hl]
	dec [hl]
	call ProcessTextWithUnderbar
	jr .loop

; called when naming (either player's or deck's) starts.
; a = maximum length of name (depending on whether player's or deck's).
; bc = position of name.
; de = dest. pointer.
; hl = pointer to text item of the question.
InitializeInputName:
	ld [wNamingScreenBufferMaxLength], a

	; wNamingScreenNamePosition = bc
	push hl
	ld hl, wNamingScreenNamePosition
	ld [hl], b
	inc hl
	ld [hl], c
	pop hl

	; wNamingScreenQuestionPointer = hl
	ld b, h
	ld c, l
	ld hl, wNamingScreenQuestionPointer
	ld [hl], c
	inc hl
	ld [hl], b

	; wNamingScreenDestPointer = de
	ld hl, wNamingScreenDestPointer
	ld [hl], e
	inc hl
	ld [hl], d

	; clear the name buffer
	ld a, NAMING_SCREEN_BUFFER_LENGTH
	ld hl, wNamingScreenBuffer
	farcall ClearNBytesFromHL

	ld a, [de]
	cp $06
	jr z, .get_length
	ld hl, wNamingScreenBuffer
	ld a, [wNamingScreenBufferMaxLength]
	ld b, a
	inc b
.loop
	ld a, [de]
	inc de
	ld [hli], a
	dec b
	jr nz, .loop
.get_length
	ld hl, wNamingScreenBuffer
	call GetTextLengthInTiles
	ld a, c
	ld [wNamingScreenBufferLength], a
	ret

FinalizeInputName:
	ld hl, wNamingScreenDestPointer
	ld e, [hl]
	inc hl
	ld d, [hl]
	ld l, e
	ld h, d
	ld de, wNamingScreenBuffer
	ld a, [wNamingScreenBufferMaxLength]
	ld b, a
	inc b
	jr InitializeInputName.loop

; draws textbox around keyboard,
; the naming question and the actual
; items in the keyboard
UpdateNamingScreenUI:
	call DrawTextboxForKeyboard
	call ProcessTextWithUnderbar
	ld hl, wNamingScreenQuestionPointer
	ld c, [hl]
	inc hl
	ld a, [hl]
	ld h, a
	or c
	jr z, .print
	; print the question string.
	ld l, c
	call PlaceTextItems
.print
	ld hl, .text_items1
	call PlaceTextItems

	ld a, [wNamingScreenMode]
	or a
	jr nz, .asm_1afe5
; NAME_MODE_HIRAGANA
	ld hl, .text_items2
	call PlaceTextItems
	ldtx hl, Text0288
	jr .asm_1b00a
.asm_1afe5
	dec a
	jr nz, .asm_1aff3
; NAME_MODE_KATAKANA
	ld hl, .text_items3
	call PlaceTextItems
	ldtx hl, Text0289
	jr .asm_1b00a
.asm_1aff3
	dec a
	jr nz, .asm_1b001
; NAME_MODE_UPPER_ABC
	ld hl, .text_items4
	call PlaceTextItems
	ldtx hl, Text028a
	jr .asm_1b00a
.asm_1b001
; NAME_MODE_LOWER_ABC
	ld hl, .text_items5
	call PlaceTextItems
	ldtx hl, Text028b
.asm_1b00a
	lb de, 2, 4
	call InitTextPrinting
	call ProcessTextFromID
	call EnableLCD
	ret

.text_items1:
	textitem 16, 16, Text0286
	db $ff ; end

.text_items2:
	textitem  2, 16, Text0283
	textitem  7, 16, Text0284
	textitem 12, 16, Text0285
	db $ff ; end

.text_items3:
	textitem  2, 16, Text0282
	textitem  7, 16, Text0284
	textitem 12, 16, Text0285
	db $ff ; end

.text_items4:
	textitem  2, 16, Text0282
	textitem  7, 16, Text0283
	textitem 12, 16, Text0285
	db $ff ; end

.text_items5:
	textitem  2, 16, Text0282
	textitem  7, 16, Text0283
	textitem 12, 16, Text0284
	db $ff ; end

DrawTextboxForKeyboard:
	lb de, 0, 3
	lb bc, 20, 15
	call DrawRegularTextBox
	ret

ProcessTextWithUnderbar:
	ld hl, wNamingScreenNamePosition
	ld d, [hl]
	inc hl
	ld e, [hl]
	push de
	call InitTextPrinting
	ld a, [wNamingScreenBufferMaxLength]
	ld e, a
	ld a, $14
	sub e
	inc a
	ld e, a ; = $14 - wNamingScreenBufferMaxLength + 1
	ld d, $00
	ld hl, .underbar_chars
	add hl, de
	call ProcessText
	pop de
	call InitTextPrinting
	ld hl, wNamingScreenBuffer
	call ProcessText
	ret

.underbar_chars
	db "W" ; stray byte
REPT $a
	textfw "_"
ENDR
	done

HandleNamingScreenInput:
.start
	xor a
	ld [wMenuInputSFX], a
	ldh a, [hDPadHeld]
	or a
	jp z, .check_btns
	ld b, a
	ld a, [wNamingScreenNumRows]
	ld c, a
	ld a, [wNamingScreenCursorX]
	ld h, a
	ld a, [wNamingScreenCursorY]
	ld l, a
	bit D_UP_F, b
	jr z, .check_d_down
	; move cursor down
	dec a
	bit 7, a
	jr z, .apply_y_value
	; wrap around
	ld a, c
	dec a
	jr .apply_y_value
.check_d_down
	bit D_DOWN_F, b
	jr z, .horizontal_directions
	; move cursor up
	inc a
	cp c
	jr c, .apply_y_value
	; wrap around
	xor a
	jr .apply_y_value

.horizontal_directions
	ld a, [wNamingScreenNumColumns]
	ld c, a
	ld a, h
	bit D_LEFT_F, b
	jr z, .check_d_right
	ld d, a
	ld a, 6 ; is last row?
	cp l
	ld a, d
	jr nz, .move_left
	; handle last row movement
	push hl
	push bc
	push af
	call GetCharInfoFromPos
	inc hl
	inc hl
	inc hl
	inc hl
	inc hl
	ld a, [hl]
	dec a
	ld d, a
	pop af
	pop bc
	pop hl
	sub d ; cursor_x - d
	cp -1
	jr nz, .asm_1b0f1
	; wrap around
	ld a, c
	sub 2
	jr .apply_x_value
.asm_1b0f1
	cp -2
	jr nz, .move_left
	; wrap around
	ld a, c
	sub 3
	jr .apply_x_value

.move_left
	dec a
	bit 7, a
	jr z, .apply_x_value
	ld a, c
	dec a
	jr .apply_x_value

.check_d_right
	bit D_RIGHT_F, b
	jr z, .check_btns
	ld d, a
	ld a, 6 ; is last row?
	cp l
	ld a, d
	jr nz, .move_right
	push hl
	push bc
	push af
	call GetCharInfoFromPos
	inc hl
	inc hl
	inc hl
	inc hl
	ld a, [hl]
	dec a
	ld d, a
	pop af
	pop bc
	pop hl
	add d ; cursor_x + d
.move_right
	inc a
	cp c
	jr c, .apply_x_value
	inc c
	cp c
	jr c, .warp_around_right
	inc c
	cp c
	jr c, .warp_round_last_row
	ld a, 2
	jr .apply_x_value
.warp_round_last_row
	ld a, 1
	jr .apply_x_value
.warp_around_right
	xor a
	jr .apply_x_value

.apply_y_value
	ld l, a
	jr .got_new_cursor_position

.apply_x_value
	ld h, a

.got_new_cursor_position
	push hl
	call GetCharInfoFromPos
	inc hl
	inc hl
	inc hl
	ld a, [wNamingScreenMode]
	cp NAME_MODE_LOWER_ABC
	jr nz, .asm_1b14a
	inc hl
	inc hl
.asm_1b14a
	ld d, [hl]
	push de
	call HideCursorAtCharPosition
	pop de
	pop hl
	ld a, l
	ld [wNamingScreenCursorY], a
	ld a, h
	ld [wNamingScreenCursorX], a
	xor a
	ld [wNamingScreenCursorBlinkCounter], a
	ld a, KEYBOARD_UNKNOWN
	cp d
	jp z, .start
	ld a, SFX_01
	ld [wMenuInputSFX], a

.check_btns
	ldh a, [hKeysPressed]
	and A_BUTTON | B_BUTTON
	jr z, .no_pressed_btns
	and A_BUTTON
	jr nz, .asm_1b174
	ld a, $ff
.asm_1b174
	call PlayAcceptOrDeclineSFX_Bank06
	push af
	call ShowCursorAtCharPosition
	pop af
	scf
	ret

.no_pressed_btns
	ld a, [wMenuInputSFX]
	or a
	jr z, .skip_sfx
	call PlaySFX
.skip_sfx
	ld hl, wNamingScreenCursorBlinkCounter
	ld a, [hl]
	inc [hl]
	and $0f
	ret nz
	ld a, [wMenuVisibleCursorTile]
	bit 4, [hl]
	jr z, DrawSymbolAtCharPosition
; fallthrough

HideCursorAtCharPosition:
	ld a, [wMenuInvisibleCursorTile]
; fallthrough

DrawSymbolAtCharPosition:
	ld e, a
	ld a, [wNamingScreenCursorX]
	ld h, a
	ld a, [wNamingScreenCursorY]
	ld l, a
	call GetCharInfoFromPos
	ld a, [hli] ; y
	ld c, a
	ld a, [wd3ef]
	or a
	jr z, .asm_1b1ae
	inc c
.asm_1b1ae
	ld b, [hl] ; x
	dec b
	ld a, e ; tile
	call UpdateNameTextCursor
	call WriteByteToBGMap0
	or a
	ret

ShowCursorAtCharPosition:
	ld a, [wMenuVisibleCursorTile]
	jr DrawSymbolAtCharPosition

; a = tile of cursor
UpdateNameTextCursor:
	push af
	push bc
	push de
	push hl
	push af
	call ZeroObjectPositions
	pop af
	ld b, a
	ld a, [wMenuInvisibleCursorTile]
	cp b
	jr z, .done ; cursor is invisible, done
	ld a, [wd3ef]
	or a
	jr nz, .asm_1b201

; place text cursor on the next name character position
	ld a, [wNamingScreenBufferLength]
	srl a ; /2
	ld d, a
	ld a, [wNamingScreenBufferMaxLength]
	srl a ; /2
	ld e, a
	ld a, d
	cp e
	jr nz, .name_not_full
	dec a
.name_not_full
	ld hl, wNamingScreenNamePosition
	add [hl] ; add name x position
	ld d, a
	ld h, 8
	ld l, d
	call HtimesL
	ld a, l
	add 8
	ld d, a ; x
	ld e, 24 ; y
	lb bc, $0, $0 ; attributes, tile number
	call SetOneObjectAttributes
.done
	pop hl
	pop de
	pop bc
	pop af
	ret

.asm_1b201
	ld a, [wNamingScreenBufferLength]
	sub $24
	jr c, .asm_1b212
	cp $24
	jr nz, .asm_1b20e
	dec a
	dec a
.asm_1b20e
	ld e, 32 ; y
	jr .asm_1b217
.asm_1b212
	ld a, [wNamingScreenBufferLength]
	ld e, 24 ; y
.asm_1b217
	sra a
	ld l, a
	ld h, 8
	call HtimesL
	ld a, l
	add 16
	ld d, a ; x
	lb bc, $0, $0
	call SetOneObjectAttributes
	jr .done

; load, to the first tile of v0Tiles0, the graphics for the
; blinking black square used in name input screens
LoadFullWidthTextCursorTile:
	ld hl, v0Tiles0
	ld de, .black_tile
	ld b, $00
.loop
	ld a, TILE_SIZE
	cp b
	ret z
	inc b
	ld a, [de]
	inc de
	ld [hli], a
	jr .loop

.black_tile
REPT TILE_SIZE
	db $ff
ENDR

; return carry if player selected "Done"
SelectKeyboardItem:
	ld a, [wNamingScreenCursorX]
	ld h, a
	ld a, [wNamingScreenCursorY]
	ld l, a
	call GetCharInfoFromPos
	inc hl
	inc hl
	ld e, [hl]
	inc hl
	ld a, [hli]
	ld d, a
	cp KEYBOARD_DONE
	jp z, .set_carry
	cp KEYBOARD_TOGGLE_KATAKANA
	jr nz, .asm_1b276
	ld a, [wNamingScreenMode]
	or a
	jr nz, .hiragana_mode
	ld a, NAME_MODE_KATAKANA
	jp .set_mode
.hiragana_mode
	xor a ; NAME_MODE_HIRAGANA
	jp .set_mode
.asm_1b276
	cp KEYBOARD_TOGGLE_UPPER_ABC
	jr nz, .asm_1b289
	ld a, [wNamingScreenMode]
	cp NAME_MODE_UPPER_ABC
	jr c, .not_upper_abc_mode
	ld a, NAME_MODE_KATAKANA
	jr .set_mode
.not_upper_abc_mode
	ld a, NAME_MODE_UPPER_ABC
	jr .set_mode
.asm_1b289
	cp KEYBOARD_TOGGLE_LOWER_ABC
	jr nz, .character_item
	ld a, [wNamingScreenMode]
	cp NAME_MODE_LOWER_ABC
	jr nz, .not_lower_abc_mode
	ld a, NAME_MODE_UPPER_ABC
	jr .set_mode
.not_lower_abc_mode
	ld a, NAME_MODE_LOWER_ABC
.set_mode
	ld [wNamingScreenMode], a
	call UpdateNamingScreenUI
	or a
	ret

.character_item
	ld a, [wNamingScreenMode]
	cp NAME_MODE_UPPER_ABC
	jr z, .upper_abc
	cp NAME_MODE_LOWER_ABC
	jr z, .lower_abc

	; handle diacritics
	lb bc, TX_FULLWIDTH4, "FW4_゛"
	ld a, d
	cp b
	jr nz, .check_handakuten
	ld a, e
	cp c
	jr nz, .check_handakuten
	push hl
	ld hl, DakutenTable
	call GetDiacriticCharacter
	pop hl
	jr c, .no_carry
	jr .apply_diacritic
.check_handakuten
	lb bc, TX_FULLWIDTH4, "FW4_゜"
	ld a, d
	cp b
	jr nz, .not_diacritic
	ld a, e
	cp c
	jr nz, .not_diacritic
	push hl
	ld hl, HandakutenTable
	call GetDiacriticCharacter
	pop hl
	jr c, .no_carry
.apply_diacritic
	; decrease length by 2
	ld a, [wNamingScreenBufferLength]
	dec a
	dec a
	ld [wNamingScreenBufferLength], a

	; get pointer to last character in buffer
	ld hl, wNamingScreenBuffer
	push de
	ld d, $00
	ld e, a
	add hl, de
	pop de
	ld a, [hl]
	jr .add_character

.not_diacritic
	ld a, d
	or a
	jr nz, .add_character
	ld a, [wNamingScreenMode]
	or a
	jr nz, .asm_1b2fb
	; NAME_MODE_HIRAGANA
	ld a, TX_HIRAGANA
	jr .add_character
.asm_1b2fb
	; NAME_MODE_KATAKANA
	ld a, TX_KATAKANA
	jr .add_character
.lower_abc
	inc hl
	inc hl
.upper_abc
	ld e, [hl]
	inc hl
	ld a, [hl]
	or a
	jr nz, .add_character
	ld a, TX_HIRAGANA

; a = TX_* constant
; e = character byte
.add_character
	ld d, a
	ld hl, wNamingScreenBufferLength
	ld a, [hl]
	ld c, a
	push hl
	ld hl, wNamingScreenBufferMaxLength
	cp [hl]
	pop hl
	jr nz, .not_last_character
	; overwrite last character
	ld hl, wNamingScreenBuffer
	dec hl
	dec hl
	; hl = wNamingScreenBuffer - 2
	jr .got_char_position
.not_last_character
	inc [hl]
	inc [hl]
	ld hl, wNamingScreenBuffer
.got_char_position
	ld b, $00
	add hl, bc
	ld [hl], d
	inc hl
	ld [hl], e
	inc hl
	ld [hl], TX_END
	call ProcessTextWithUnderbar
.no_carry
	or a
	ret

.set_carry:
	scf
	ret

; input:
;  hl = pointer to either DakutenTable or HandakutenTable
; output:
;  d = $00
;  e = new character byte
GetDiacriticCharacter:
	ld a, [wNamingScreenBufferLength]
	or a
	jr z, .set_carry
	dec a
	dec a
	push hl
	ld hl, wNamingScreenBuffer
	ld d, $00
	ld e, a
	add hl, de
	ld e, [hl] ; TX_*
	inc hl
	ld d, [hl] ; character
	ld a, TX_KATAKANA
	cp e
	jr nz, .not_katakana
	dec e ; change to hiragana
.not_katakana
	pop hl
.loop
	ld a, [hli]
	or a
	jr z, .set_carry ; not in table
	cp d
	jr nz, .next
	ld a, [hl]
	cp e
	jr nz, .next
	inc hl
	ld e, [hl] ; new character byte
	inc hl
	ld d, [hl] ; unused byte
	or a
	ret
.next
	inc hl
	inc hl
	inc hl
	jr .loop

.set_carry
	scf
	ret

; given the position of the current cursor,
; it returns the pointer to the proper information.
; h: position x.
; l: position y.
GetCharInfoFromPos:
	push de
	; (information index) = (x) * (height) + (y)
	ld e, l
	ld d, h
	ld a, [wNamingScreenNumRows]
	ld l, a
	call HtimesL
	ld a, l
	add e
	ld hl, KeyboardData
	pop de
	or a
	ret z
.loop
REPT 8
	inc hl
ENDR
	dec a
	jr nz, .loop
	ret

; a set of keyboard datum
; \1 = absolute y coordinate
; \2 = absolute x coordinate
; \3 = TX_* constant (hiragana/katakana)
; \4 = hiragana character (must coincide with the
;      katakana character with the same byte value)
; \5 = TX_* constant (uppercase ABC)
; \6 = uppercase alphabet character
; \7 = TX_* constant (lowercase ABC)
; \8 = lowercase alphabet character
MACRO kbchar
	db \1, \2

REPT 3
IF \3 == TX_KATAKANA
	db STRCAT("FW{x:TX_KATAKANA}_", \4)
	db \3
ELIF \3 == TX_HIRAGANA
	db STRCAT("FW{x:TX_HIRAGANA}_", \4)
	db TX_FULLWIDTH0
ELIF \3 == TX_FULLWIDTH0
	db STRCAT("FW0_", \4)
	db \3
ELIF \3 == TX_FULLWIDTH4
	db STRCAT("FW4_", \4)
	db \3
ELIF \3 == TX_SYMBOL
	db SYM_\4
	db \3
ENDC
SHIFT 2
ENDR
ENDM

; \1 = absolute y coordinate
; \2 = absolute x coordinate
; \3 = keyboard function (KEYBOARD_* constant)
; \4 = cursor x offset to right
; \5 = cursor x offset to left
MACRO kbitem
	db \1, \2
	db $01 ; unused
	db \3
	db \4, \5
	db \4, \5 ; unused
ENDM

KeyboardData:
	; col 0
	kbchar  4,  2, TX_HIRAGANA,   "あ", TX_FULLWIDTH4, "A",  TX_FULLWIDTH4, "a"
	kbchar  6,  2, TX_HIRAGANA,   "い", TX_FULLWIDTH4, "J",  TX_FULLWIDTH4, "j"
	kbchar  8,  2, TX_HIRAGANA,   "う", TX_FULLWIDTH4, "S",  TX_FULLWIDTH4, "s"
	kbchar 10,  2, TX_HIRAGANA,   "え", TX_FULLWIDTH0, "?",  TX_FULLWIDTH4, "@"
	kbchar 12,  2, TX_HIRAGANA,   "お", TX_FULLWIDTH0, "4",  TX_FULLWIDTH4, ":"
	kbchar 14,  2, TX_HIRAGANA,   "ゃ", TX_HIRAGANA,   "ぃ", TX_SYMBOL,     LIGHTNING
	kbitem 16,  2, KEYBOARD_TOGGLE_KATAKANA, 3, 2

	; col 1
	kbchar  4,  4, TX_HIRAGANA,   "か", TX_FULLWIDTH4, "B",  TX_FULLWIDTH4, "b"
	kbchar  6,  4, TX_HIRAGANA,   "き", TX_FULLWIDTH4, "K",  TX_FULLWIDTH4, "k"
	kbchar  8,  4, TX_HIRAGANA,   "く", TX_FULLWIDTH4, "T",  TX_FULLWIDTH4, "t"
	kbchar 10,  4, TX_HIRAGANA,   "け", TX_FULLWIDTH4, "&",  TX_FULLWIDTH4, "&"
	kbchar 12,  4, TX_HIRAGANA,   "こ", TX_FULLWIDTH0, "5",  TX_FULLWIDTH4, ";"
	kbchar 14,  4, TX_HIRAGANA,   "ゅ", TX_HIRAGANA,   "ぅ", TX_SYMBOL,     GRASS
	kbitem 16,  2, KEYBOARD_TOGGLE_KATAKANA, 2, 2

	; col 2
	kbchar  4,  6, TX_HIRAGANA,   "さ", TX_FULLWIDTH4, "C",  TX_FULLWIDTH4, "c"
	kbchar  6,  6, TX_HIRAGANA,   "し", TX_FULLWIDTH4, "L",  TX_FULLWIDTH4, "l"
	kbchar  8,  6, TX_HIRAGANA,   "す", TX_FULLWIDTH4, "U",  TX_FULLWIDTH4, "u"
	kbchar 10,  6, TX_HIRAGANA,   "せ", TX_FULLWIDTH0, "+",  TX_FULLWIDTH0, "/"
	kbchar 12,  6, TX_HIRAGANA,   "そ", TX_FULLWIDTH0, "6",  TX_FULLWIDTH4, "_"
	kbchar 14,  6, TX_HIRAGANA,   "ょ", TX_HIRAGANA,   "ぇ", TX_SYMBOL,     FIRE
	kbitem 16,  2, KEYBOARD_TOGGLE_KATAKANA, 2, 3

	; col 3
	kbchar  4,  8, TX_HIRAGANA,   "た", TX_FULLWIDTH4, "D",  TX_FULLWIDTH4, "d"
	kbchar  6,  8, TX_HIRAGANA,   "ち", TX_FULLWIDTH4, "M",  TX_FULLWIDTH4, "m"
	kbchar  8,  8, TX_HIRAGANA,   "つ", TX_FULLWIDTH4, "V",  TX_FULLWIDTH4, "v"
	kbchar 10,  8, TX_HIRAGANA,   "て", TX_FULLWIDTH0, "-",  TX_FULLWIDTH4, "*"
	kbchar 12,  8, TX_HIRAGANA,   "と", TX_FULLWIDTH0, "7",  TX_FULLWIDTH4, "<"
	kbchar 14,  8, TX_HIRAGANA,   "っ", TX_HIRAGANA,   "ぉ", TX_SYMBOL,     WATER
	kbitem 16,  7, KEYBOARD_TOGGLE_UPPER_ABC, 2, 3

	; col 4
	kbchar  4, 10, TX_HIRAGANA,   "な", TX_FULLWIDTH4, "E",  TX_FULLWIDTH4, "e"
	kbchar  6, 10, TX_HIRAGANA,   "に", TX_FULLWIDTH4, "N",  TX_FULLWIDTH4, "n"
	kbchar  8, 10, TX_HIRAGANA,   "ぬ", TX_FULLWIDTH4, "W",  TX_FULLWIDTH4, "w"
	kbchar 10, 10, TX_HIRAGANA,   "ね", TX_FULLWIDTH0, "・", TX_FULLWIDTH0, "+"
	kbchar 12, 10, TX_HIRAGANA,   "の", TX_FULLWIDTH0, "8",  TX_FULLWIDTH4, ">"
	kbchar 14, 10, TX_HIRAGANA,   "を", TX_KATAKANA,   "ァ", TX_SYMBOL,     PSYCHIC
	kbitem 16,  7, KEYBOARD_TOGGLE_UPPER_ABC, 2, 2

	; col 5
	kbchar  4, 12, TX_HIRAGANA,   "は", TX_FULLWIDTH4, "F",  TX_FULLWIDTH4, "f"
	kbchar  6, 12, TX_HIRAGANA,   "ひ", TX_FULLWIDTH4, "O",  TX_FULLWIDTH4, "о"
	kbchar  8, 12, TX_HIRAGANA,   "ふ", TX_FULLWIDTH4, "X",  TX_FULLWIDTH4, "x"
	kbchar 10, 12, TX_HIRAGANA,   "へ", TX_FULLWIDTH0, "0",  TX_FULLWIDTH0, "-"
	kbchar 12, 12, TX_HIRAGANA,   "ほ", TX_FULLWIDTH0, "9",  TX_FULLWIDTH0, " "
	kbchar 14, 12, TX_FULLWIDTH4, "゛", TX_KATAKANA,   "ィ", TX_SYMBOL,     FIGHTING
	kbitem 16, 12, KEYBOARD_TOGGLE_LOWER_ABC, 2, 2

	; col 6
	kbchar  4, 14, TX_HIRAGANA,   "ま", TX_FULLWIDTH4, "G",  TX_FULLWIDTH4, "g"
	kbchar  6, 14, TX_HIRAGANA,   "み", TX_FULLWIDTH4, "P",  TX_FULLWIDTH4, "p"
	kbchar  8, 14, TX_HIRAGANA,   "む", TX_FULLWIDTH4, "Y",  TX_FULLWIDTH4, "y"
	kbchar 10, 14, TX_HIRAGANA,   "め", TX_FULLWIDTH0, "1",  TX_FULLWIDTH4, "="
	kbchar 12, 14, TX_HIRAGANA,   "も", TX_SYMBOL,     No,   TX_FULLWIDTH0, " "
	kbchar 14, 14, TX_FULLWIDTH4, "゜", TX_KATAKANA,   "ゥ", TX_SYMBOL,     COLORLESS
	kbitem 16, 12, KEYBOARD_TOGGLE_LOWER_ABC, 2, 2

	; col 7
	kbchar  4, 16, TX_HIRAGANA,   "や", TX_FULLWIDTH4, "H",  TX_FULLWIDTH4, "h"
	kbchar  6, 16, TX_HIRAGANA,   "ゆ", TX_FULLWIDTH4, "Q",  TX_FULLWIDTH4, "q"
	kbchar  8, 16, TX_HIRAGANA,   "よ", TX_FULLWIDTH4, "Z",  TX_FULLWIDTH4, "z"
	kbchar 10, 16, TX_HIRAGANA,   "わ", TX_FULLWIDTH0, "2",  TX_FULLWIDTH0, "・"
	kbchar 12, 16, TX_HIRAGANA,   "ん", TX_SYMBOL,     Lv,   TX_FULLWIDTH0, " "
	kbchar 14, 16, TX_FULLWIDTH0, "ー", TX_KATAKANA,   "ェ", TX_SYMBOL,    RAINBOW
	kbitem 16, 16, KEYBOARD_DONE, 2, 2

	; col 8
	kbchar  4, 18, TX_HIRAGANA,   "ら", TX_FULLWIDTH4, "I",  TX_FULLWIDTH4, "i"
	kbchar  6, 18, TX_HIRAGANA,   "り", TX_FULLWIDTH4, "R",  TX_FULLWIDTH4, "r"
	kbchar  8, 18, TX_HIRAGANA,   "る", TX_FULLWIDTH0, "!",  TX_FULLWIDTH0, " "
	kbchar 10, 18, TX_HIRAGANA,   "れ", TX_FULLWIDTH0, "3",  TX_FULLWIDTH4, "ˍ"
	kbchar 12, 18, TX_HIRAGANA,   "ろ", TX_HIRAGANA,   "ぁ", TX_FULLWIDTH0, " "
	kbchar 14, 18, TX_FULLWIDTH0, " ",  TX_KATAKANA,   "ォ", TX_FULLWIDTH0, " "
	kbitem 16, 16, KEYBOARD_DONE, 3, 3

	db  0,  0, $00, $00, $00, $00, $00, $00

MACRO diacritic
	db STRCAT("FW{x:TX_HIRAGANA}_", \1)
	db \2
	db STRCAT("FW{x:TX_HIRAGANA}_", \3)
	db $00
ENDM

DakutenTable:
	diacritic "か", TX_HIRAGANA, "が" ; katakana カ, ガ
	diacritic "き", TX_HIRAGANA, "ぎ" ; katakana キ, ギ
	diacritic "く", TX_HIRAGANA, "ぐ" ; katakana ク, グ
	diacritic "け", TX_HIRAGANA, "げ" ; katakana ケ, ゲ
	diacritic "こ", TX_HIRAGANA, "ご" ; katakana コ, ゴ
	diacritic "さ", TX_HIRAGANA, "ざ" ; katakana サ, ザ
	diacritic "し", TX_HIRAGANA, "じ" ; katakana シ, ジ
	diacritic "す", TX_HIRAGANA, "ず" ; katakana ス, ズ
	diacritic "せ", TX_HIRAGANA, "ぜ" ; katakana セ, ゼ
	diacritic "そ", TX_HIRAGANA, "ぞ" ; katakana ソ, ゾ
	diacritic "た", TX_HIRAGANA, "だ" ; katakana タ, ダ
	diacritic "ち", TX_HIRAGANA, "ぢ" ; katakana チ, ヂ
	diacritic "つ", TX_HIRAGANA, "づ" ; katakana ツ, ヅ
	diacritic "て", TX_HIRAGANA, "で" ; katakana テ, デ
	diacritic "と", TX_HIRAGANA, "ど" ; katakana ト, ド
	diacritic "は", TX_HIRAGANA, "ば" ; katakana ハ, バ
	diacritic "ひ", TX_HIRAGANA, "び" ; katakana ヒ, ビ
	diacritic "ふ", TX_HIRAGANA, "ぶ" ; katakana フ, ブ
	diacritic "へ", TX_HIRAGANA, "べ" ; katakana ヘ, ベ
	diacritic "ほ", TX_HIRAGANA, "ぼ" ; katakana ホ, ボ
	diacritic "ぱ", TX_HIRAGANA, "ば" ; katakana パ, バ
	diacritic "ぴ", TX_HIRAGANA, "び" ; katakana ピ, ビ
	diacritic "ぷ", TX_HIRAGANA, "ぶ" ; katakana プ, ブ
	diacritic "ぺ", TX_HIRAGANA, "べ" ; katakana ペ, ベ
	diacritic "ぽ", TX_HIRAGANA, "ぼ" ; katakana ポ, ボ
	db $00, $00 ; end

HandakutenTable:
	diacritic "は", TX_HIRAGANA, "ぱ" ; katakana ハ, パ
	diacritic "ひ", TX_HIRAGANA, "ぴ" ; katakana ヒ, ピ
	diacritic "ふ", TX_HIRAGANA, "ぷ" ; katakana フ, プ
	diacritic "へ", TX_HIRAGANA, "ぺ" ; katakana ヘ, ペ
	diacritic "ほ", TX_HIRAGANA, "ぽ" ; katakana ホ, ポ
	diacritic "ば", TX_HIRAGANA, "ぱ" ; katakana バ, パ
	diacritic "び", TX_HIRAGANA, "ぴ" ; katakana ビ, ピ
	diacritic "ぶ", TX_HIRAGANA, "ぷ" ; katakana ブ, プ
	diacritic "べ", TX_HIRAGANA, "ぺ" ; katakana ベ, ペ
	diacritic "ぼ", TX_HIRAGANA, "ぽ" ; katakana ボ, ポ
	db $00, $00 ; end
; 0x1b613

SECTION "Bank 6@78f1", ROMX[$78f1], BANK[$6]

Func_1b8f1:
	ld a, b
	or a
	ret z
.asm_1b8f4
	ld a, [hli]
	ld [de], a
	inc de
	dec b
	jr nz, .asm_1b8f4
	ret
; 0x1b8fb
