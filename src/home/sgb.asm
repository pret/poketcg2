; setup SNES memory $810-$867 and palette
InitSGB:
	ld hl, MaskEnPacket_Freeze
	call SendSGB
	ld hl, DataSndPacket1
	call SendSGB
	ld hl, DataSndPacket2
	call SendSGB
	ld hl, DataSndPacket3
	call SendSGB
	ld hl, DataSndPacket4
	call SendSGB
	ld hl, DataSndPacket5
	call SendSGB
	ld hl, DataSndPacket6
	call SendSGB
	ld hl, DataSndPacket7
	call SendSGB
	ld hl, DataSndPacket8
	call SendSGB
	ld hl, Pal01Packet_InitSGB
	call SendSGB
	ld hl, MaskEnPacket_Cancel
	call SendSGB
	ret

DataSndPacket1:
	sgb DATA_SND, 1 ; sgb_command, length
	dwb $085d, $00 ; destination address, bank
	db $0b ; number of bytes to write
	db $8c, $d0, $f4, $60, $00, $00, $00, $00, $00, $00, $00 ; data bytes

DataSndPacket2:
	sgb DATA_SND, 1 ; sgb_command, length
	dwb $0852, $00 ; destination address, bank
	db $0b ; number of bytes to write
	db $a9, $e7, $9f, $01, $c0, $7e, $e8, $e8, $e8, $e8, $e0 ; data bytes

DataSndPacket3:
	sgb DATA_SND, 1 ; sgb_command, length
	dwb $0847, $00 ; destination address, bank
	db $0b ; number of bytes to write
	db $c4, $d0, $16, $a5, $cb, $c9, $05, $d0, $10, $a2, $28 ; data bytes

DataSndPacket4:
	sgb DATA_SND, 1 ; sgb_command, length
	dwb $083c, $00 ; destination address, bank
	db $0b ; number of bytes to write
	db $f0, $12, $a5, $c9, $c9, $c8, $d0, $1c, $a5, $ca, $c9 ; data bytes

DataSndPacket5:
	sgb DATA_SND, 1 ; sgb_command, length
	dwb $0831, $00 ; destination address, bank
	db $0b ; number of bytes to write
	db $0c, $a5, $ca, $c9, $7e, $d0, $06, $a5, $cb, $c9, $7e ; data bytes

DataSndPacket6:
	sgb DATA_SND, 1 ; sgb_command, length
	dwb $0826, $00 ; destination address, bank
	db $0b ; number of bytes to write
	db $39, $cd, $48, $0c, $d0, $34, $a5, $c9, $c9, $80, $d0 ; data bytes

DataSndPacket7:
	sgb DATA_SND, 1 ; sgb_command, length
	dwb $081b, $00 ; destination address, bank
	db $0b ; number of bytes to write
	db $ea, $ea, $ea, $ea, $ea, $a9, $01, $cd, $4f, $0c, $d0 ; data bytes

DataSndPacket8:
	sgb DATA_SND, 1 ; sgb_command, length
	dwb $0810, $00 ; destination address, bank
	db $0b ; number of bytes to write
	db $4c, $20, $08, $ea, $ea, $ea, $ea, $ea, $60, $ea, $ea ; data bytes

MaskEnPacket_Freeze:
	sgb MASK_EN, 1 ; sgb_command, length
	db MASK_EN_FREEZE_SCREEN
	ds $0e

MaskEnPacket_Cancel:
	sgb MASK_EN, 1 ; sgb_command, length
	db MASK_EN_CANCEL_MASK
	ds $0e

Pal01Packet_InitSGB:
	sgb PAL01, 1 ; sgb_command, length
	rgb 28, 28, 24
	rgb 20, 20, 16
	rgb 8, 8, 8
	rgb 0, 0, 0
	rgb 31, 0, 0
	rgb 15, 0, 0
	rgb 7, 0, 0
	db $00

Pal23Packet_0b00:
	sgb PAL23, 1 ; sgb_command, length
	rgb 0, 31, 0
	rgb 0, 15, 0
	rgb 0, 7, 0
	rgb 0, 0, 0
	rgb 0, 0, 31
	rgb 0, 0, 15
	rgb 0, 0, 7
	db $00

AttrBlkPacket_0b10:
	sgb ATTR_BLK, 1 ; sgb_command, length
	db 1 ; number of data sets
	; Control Code, Color Palette Designation, X1, Y1, X2, Y2
	db ATTR_BLK_CTRL_INSIDE + ATTR_BLK_CTRL_LINE, 1 << 0 + 2 << 2, 5, 5, 10, 10 ; data set 1
	ds 6 ; data set 2
	ds 2 ; data set 3

; send SGB packet at hl (or packets, if length > 1)
; (removed in TCG2)
SendSGB:

; SGB hardware detection
; return carry if SGB detected and disable multi-controller mode before returning
; (removed in TCG2)
DetectSGB:

	or a
	ret
