GameLoop: ; 4000 (1:4000)
	di
	ld sp, $d000
	call $0dc7
	call $02de
	call $02d7
	call EnableSRAM
	ld a, [$a006]
	ld [$cdde], a
	ld a, [$a009]
	ld [$cd08], a
	call DisableSRAM
	ld a, $3c				; And we have an unknown divergence right here.
	ld [$cd07], a
	ei
	; AND WE GO INTO THE MYSTERY FUNCTIONS HALP
INCBIN "baserom.gbc", $4025, $8000 - $4025
