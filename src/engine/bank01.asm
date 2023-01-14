GameLoop::
	di
	ld sp, $d000
	call ResetSerial
	call EnableInt_VBlank
	call EnableInt_Timer
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
