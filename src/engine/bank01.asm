GameLoop: ; 4000 (1:4000)
	di
	ld sp, $d000
	call $0dc7 ; ResetSerial
	call $02de ; EnableInt_VBlank
	call $02d7 ; EnableInt_Timer
	call EnableSRAM
	ld a, [$a006] ; sTextSpeed
	ld [$cdde], a ; wTextSpeed
	ld a, [$a009] ; sSkipDelayAllowed
	ld [$cd08], a ; wSkipDelayAllowed
	call DisableSRAM
	ld a, $3c
	ld [$cd07], a
	ei
; 0x4025
