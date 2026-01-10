Sfx_ReceiveCardPop_Ch1:
	sfx_env 13, 0
	sfx_pan TRUE, TRUE
	sfx_duty 2
	sfx_freq $759
	sfx_pitch_offset 0
	sfx_wait 1
	sfx_env 7, 1
	sfx_freq $744
	sfx_env 4, 1
	sfx_freq $739
	sfx_freq $721
	sfx_freq $705
	sfx_freq $6f6
	sfx_end

Sfx_ReceiveCardPop_Ch2:
	sfx_env 1, -5
	sfx_pan TRUE, TRUE
	sfx_duty 0
	sfx_loop 3
	sfx_freq $7d6
	sfx_pitch_offset 0
	sfx_wait 1
	sfx_freq $7db
	sfx_wait 1
	sfx_freq $7df
	sfx_wait 1
	sfx_endloop
	sfx_env 4, 7
	sfx_loop 8
	sfx_freq $7d6
	sfx_wait 1
	sfx_freq $7db
	sfx_wait 1
	sfx_freq $7df
	sfx_wait 1
	sfx_endloop
	sfx_end

Sfx_ReceiveCardPop_Ch3:
	sfx_pan TRUE, TRUE
	sfx_env 15, 1
	sfx_freq $63
	sfx_env 4, 0
	sfx_freq $11
	sfx_freq $21
	sfx_loop 6
	sfx_freq $11
	sfx_freq $21
	sfx_endloop
	sfx_env 4, 7
	sfx_loop 20
	sfx_freq $11
	sfx_freq $21
	sfx_endloop
	sfx_end
