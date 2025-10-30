; console types (wConsole)
DEF CONSOLE_DMG EQU $00
DEF CONSOLE_SGB EQU $01
DEF CONSOLE_CGB EQU $02

; wReentrancyFlag bits
DEF IN_VBLANK EQU 0
DEF IN_TIMER EQU 1

; hFlushPaletteFlags constants
DEF FLUSH_ONE_PAL    EQU %10000000
DEF FLUSH_ALL_PALS   EQU %11000000
DEF FLUSH_ALL_PALS_F EQU 6

DEF NULL EQU $0000

DEF FALSE EQU 0
DEF TRUE  EQU 1

; max number of player names that
; can be written to sCardPopNameList
DEF CARDPOP_NAME_LIST_MAX_ELEMS EQU 16
DEF CARDPOP_NAME_LIST_SIZE EQUS "CARDPOP_NAME_LIST_MAX_ELEMS * NAME_BUFFER_LENGTH"
DEF MAX_NUM_CARDPOP_RECORDS EQU 98

DEF CARDPOP_RECORD_SIZE       EQU $20
DEF CARDPOP_RECORD_STATS_SIZE EQU $05

DEF MAX_CHIPS EQU 9999

; rJOYP constants to read IR signals
DEF P15              EQU %00100000
DEF P14              EQU %00010000
DEF P13              EQU %00001000
DEF P12              EQU %00000100
DEF P11              EQU %00000010
DEF P10              EQU %00000001

; commands transmitted through IR to be
; executed by the other device
; (see ExecuteReceivedIRCommands)
	const_def
	const IRCMD_CLOSE             ; $0
	const IRCMD_RETURN_WO_CLOSING ; $1
	const IRCMD_TRANSMIT_DATA     ; $2
	const IRCMD_RECEIVE_DATA      ; $3
	const IRCMD_CALL_FUNCTION     ; $4
DEF NUM_IR_COMMANDS EQU const_value

; parameters for IR communication
; (see InitIRCommunications)
	const_def 1
	const IRPARAM_CARD_POP      ; $1
	const IRPARAM_SEND_CARDS    ; $2
	const IRPARAM_SEND_DECK     ; $3
	const IRPARAM_RARE_CARD_POP ; $4

; serial transfer
DEF SERIAL_OP_DATA_END      EQU $ac
DEF SERIAL_OP_DATA_ESCAPE   EQU $ca
DEF SERIAL_OP_MASTER_TCG2   EQU $92
DEF SERIAL_PEER_MASTER_TCG2 EQU $21
; cf.)
; DEF SERIAL_OP_MASTER_TCG1   EQU $29
; DEF SERIAL_PEER_MASTER_TCG1 EQU $12
