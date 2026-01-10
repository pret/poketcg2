Sfx_VinePull_Ch1:
	sfx_pan TRUE, TRUE
	; bug, sfx_sweep_down duration can only go up to 7,
	; a 9 here results in sweep with 1 in length
	; sfx_sweep_down 9, 6
	db $90, (9 << 4) | 6 | AUD1SWEEP_DOWN
	sfx_env 6, -3
	sfx_duty 1
	sfx_freq $7df
	sfx_pitch_offset 0
	sfx_wait 17
	sfx_sweep_down 2, 2
	sfx_loop 6
	sfx_env 15, -1
	sfx_duty 0
	sfx_freq $2c6
	sfx_wait 2
	sfx_endloop
	sfx_sweep_up 2, 7
	sfx_env 12, 5
	sfx_duty 2
	sfx_freq $744
	sfx_wait 5
	sfx_env 8, 5
	sfx_duty 2
	sfx_freq $76b
	sfx_wait 5
	sfx_env 3, 5
	sfx_duty 2
	sfx_freq $783
	sfx_wait 5
	sfx_end
