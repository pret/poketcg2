Sfx_Slap_Ch1:
	sfx_env 2, -4
	sfx_pan TRUE, TRUE
	sfx_duty 2
	sfx_freq $416
	sfx_freq $44e
	sfx_freq $483
	sfx_env 4, -4
	sfx_duty 2
	sfx_freq $4b5
	sfx_freq $4e5
	sfx_freq $511
	sfx_env 6, -4
	sfx_duty 2
	sfx_freq $563
	sfx_freq $589
	sfx_freq $5ac
	sfx_env 8, -4
	sfx_duty 2
	sfx_freq $5cd
	sfx_freq $5ed
	sfx_freq $60b
	sfx_env 10, -4
	sfx_duty 2
	sfx_freq $642
	sfx_freq $65b
	sfx_freq $672
	sfx_env 12, -4
	sfx_duty 2
	sfx_freq $689
	sfx_freq $69e
	sfx_freq $6b2
	sfx_end

Sfx_Slap_Ch2:
	sfx_pan TRUE, TRUE
	sfx_env 0, 0
	sfx_wait 18
	sfx_loop 2
	sfx_env 15, 0
	sfx_freq $35
	sfx_freq $13
	sfx_freq $11
	sfx_env 15, 5
	sfx_freq $11
	sfx_freq $1
	sfx_env 11, 7
	sfx_freq $13
	sfx_freq $1
	sfx_freq $11
	sfx_freq $1
	sfx_env 6, 7
	sfx_freq $13
	sfx_freq $1
	sfx_freq $11
	sfx_freq $1
	sfx_env 4, 7
	sfx_freq $13
	sfx_freq $1
	sfx_endloop
	sfx_end
