; hl = text id
LoadLinkConnectingScene:
	push hl
	call SetSpriteAnimationsAsVBlankFunction
	ld a, SCENE_LINK
	lb bc, 0, 0
	call EmptyScreenAndLoadScene
	pop hl
	call DrawWideTextBox_PrintText
	call EnableLCD
	ret

; hl = text id
; shows Link Not Connected scene
; then asks the player whether they want to try again
; if the player selects "no", return carry
LoadLinkNotConnectedSceneAndAskWhetherToTryAgain:
	push hl
	call RestoreVBlankFunction
	call SetSpriteAnimationsAsVBlankFunction
	ld a, SCENE_LINK_INTRO_NOT_CONNECTED
	lb bc, 0, 0
	call EmptyScreenAndLoadScene
	pop hl
	call DrawWideTextBox_WaitForInput
	ldtx hl, TryAgainPromptText
	call YesOrNoMenuWithText_SetCursorToYes
; fallthrough

ClearRPAndRestoreVBlankFunction:
	push af
	call ClearRP
	call RestoreVBlankFunction
	pop af
	ret

; prepares IR communication parameter data
; a = a IRPARAM_* constant for the function of this connection
InitIRCommunications:
	ld hl, wOwnIRCommunicationParams
	ld [hl], a
FOR n, IR_MAGIC_STRING_SIZE
	inc hl
	ld [hl], STRBYTE("{IR_MAGIC_STRING_TCG2}", n)
ENDR
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

; returns carry if communication was unsuccessful
; if a = 0, then it was a communication error
; if a = 1, then operation was cancelled by the player
PrepareSendCardOrDeckConfigurationThroughIR:
	call InitIRCommunications

; pressing A button triggers request for IR communication
.loop_frame
	call DoFrame
	ldh a, [hKeysPressed]
	bit B_PAD_B, a
	jr nz, .b_btn
	ldh a, [hKeysHeld]
	bit B_PAD_A, a
	jr z, .loop_frame
; a btn
	call TrySendIRRequest
	jr nc, .request_success
	or a
	jr z, .loop_frame
	xor a
	scf
	ret

; cancelled by the player
.b_btn
	ld a, $01
	scf
	ret

.request_success
	call ExchangeIRCommunicationParameters
	ret c
	ld a, [wOtherIRCommunicationParams + 3]
	cp STRBYTE("{IR_MAGIC_STRING_TCG2}", 2)
	jr nz, SetIRCommunicationErrorCode_Error
	or a
	ret

; exchanges player names and IR communication parameters
; checks whether parameters for communication match
; and if they don't, an error is issued
ExchangeIRCommunicationParameters:
	ld hl, wOwnIRCommunicationParams
	ld de, wOtherIRCommunicationParams
	ld c, IR_PARAMS_STRUCT_SIZE
	call RequestDataTransmissionThroughIR
	jr c, .error
	ld hl, wOtherIRCommunicationParams + 1
	ld a, [hli]
	cp STRBYTE("{IR_MAGIC_STRING_TCG2}", 0)
	jr nz, .error
	ld a, [hli]
	cp STRBYTE("{IR_MAGIC_STRING_TCG2}", 1)
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
	ld [hl], NONE
	ld de, wIRCommunicationErrorCode
	ld c, 1
	call RequestDataReceivalThroughIR
	ret c
	call RequestCloseIRCommunication
	or a
	ret

; makes device receptive to receive data from other device
; to write in wDuelTempList (either list of cards or a deck configuration)
; returns carry if some error occurred
TryReceiveCardOrDeckConfigurationThroughIR:
	call InitIRCommunications
.loop_receive_request
	xor a
	ld [wDuelTempList], a
	call TryReceiveIRRequest
	jr nc, .receive_data
	bit 1, a
	jr nz, .cancelled
	jr .loop_receive_request
.receive_data
	call ExecuteReceivedIRCommands
	ld a, [wIRCommunicationErrorCode]
	or a
	ret z ; no error
	xor a
	scf
	ret

.cancelled
	ld a, $01
	scf
	ret

; returns carry if card(s) wasn't successfully sent
_SendCard:
	call StopMusic
	ldtx hl, TransmittingCardSenderText
	call LoadLinkConnectingScene
	ld a, IRPARAM_SEND_CARDS
	call PrepareSendCardOrDeckConfigurationThroughIR
	jr c, .fail

; send cards
	ld hl, wDuelTempList
	ld e, l
	ld d, h
	ld c, DECK_COMPRESSED_SIZE
	call RequestDataReceivalThroughIR
	jr c, .fail
	call SetIRCommunicationErrorCode_NoError
	jr c, .fail
	call ExecuteReceivedIRCommands
	jr c, .fail
	ld a, [wOwnIRCommunicationParams + 1]
	cp STRBYTE("{IR_ACK_MAGIC_STRING_TCG2}", 0)
	jr nz, .fail
	call PlayCardPopSong
	xor a
	call ClearRPAndRestoreVBlankFunction
	ret

.fail
	call PlayCardPopSong
	ldtx hl, TransmittingCardUnsuccessfulSenderText
	call LoadLinkNotConnectedSceneAndAskWhetherToTryAgain
	jr nc, _SendCard
	scf
	ret

PlayCardPopSong:
	ld a, MUSIC_CARD_POP
	jp PlaySong

_ReceiveCard:
	call StopMusic
	ldtx hl, TransmittingCardReceiverText
	call LoadLinkConnectingScene
	ld a, IRPARAM_SEND_CARDS
	call TryReceiveCardOrDeckConfigurationThroughIR
	jr c, .fail
	ld a, STRBYTE("{IR_ACK_MAGIC_STRING_TCG2}", 0)
	ld [wOwnIRCommunicationParams + 1], a
	ld hl, wOwnIRCommunicationParams
	ld e, l
	ld d, h
	ld c, IR_PARAMS_STRUCT_SIZE
	call RequestDataReceivalThroughIR
	jr c, .fail
	call RequestCloseIRCommunication
	jr c, .fail
	call PlayCardPopSong
	or a
	call ClearRPAndRestoreVBlankFunction
	ret

.fail
	call PlayCardPopSong
	ldtx hl, TransmittingCardUnsuccessfulReceiverText
	call LoadLinkNotConnectedSceneAndAskWhetherToTryAgain
	jr nc, _ReceiveCard
	scf
	ret

_SendDeckConfiguration:
	call StopMusic
	ldtx hl, TransmittingDeckConfigurationSenderText
	call LoadLinkConnectingScene
	ld a, IRPARAM_SEND_DECK
	call PrepareSendCardOrDeckConfigurationThroughIR
	jr c, .fail
	ld hl, wDuelTempList
	ld e, l
	ld d, h
	ld c, DECK_COMPRESSED_STRUCT_SIZE
	call RequestDataReceivalThroughIR
	jr c, .fail
	call SetIRCommunicationErrorCode_NoError
	jr c, .fail
	call PlayCardPopSong
	call ClearRPAndRestoreVBlankFunction
	or a
	ret

.fail
	call PlayCardPopSong
	ldtx hl, TransmittingDeckConfigurationUnsuccessfulSenderText
	call LoadLinkNotConnectedSceneAndAskWhetherToTryAgain
	jr nc, _SendDeckConfiguration
	scf
	ret

_ReceiveDeckConfiguration:
	call StopMusic
	ldtx hl, TransmittingDeckConfigurationReceiverText
	call LoadLinkConnectingScene
	ld a, IRPARAM_SEND_DECK
	call TryReceiveCardOrDeckConfigurationThroughIR
	jr c, .fail
	call PlayCardPopSong
	call ClearRPAndRestoreVBlankFunction
	or a
	ret

.fail
	call PlayCardPopSong
	ldtx hl, TransmittingDeckConfigurationUnsuccessfulReceiverText
	call LoadLinkNotConnectedSceneAndAskWhetherToTryAgain
	jr nc, _ReceiveDeckConfiguration
	scf
	ret
