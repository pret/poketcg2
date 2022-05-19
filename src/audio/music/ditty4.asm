Music_Ditty4_Ch2: ; 1ebeae (7a:7eae)
	musicf0 0
	speed 1
	stereo_panning 15, 15
	octave 3
	musicf1 87
	C_ 4
	C_ 2
	A_ 4
	A_ 2
	F_ 4
	F_ 2
	inc_octave
	C_ 4
	C_ 1
	dec_octave
	A_ 4
	A_ 2
	inc_octave
	F_ 15
	F_ 11
	music_end


Music_Ditty4_Ch1: ; 1ebec7 (7a:7ec7)
	musicf0 0
	speed 1
	stereo_panning 15, 15
	octave 2
	musicf1 87
	A_ 4
	A_ 2
	inc_octave
	C_ 4
	C_ 2
	dec_octave
	A_ 4
	A_ 2
	inc_octave
	F_ 4
	F_ 1
	C_ 4
	C_ 2
	A_ 15
	A_ 11
	music_end


Music_Ditty4_Ch3: ; 1ebee0 (7a:7ee0)
	wave 4
	speed 1
	volume 64
	echo 128
	stereo_panning 15, 15
	speed 1
	cutoff 1
	rest 6
	rest 5
	rest 6
	rest 5
	rest 6
	musicf1 128
	octave 3
	F_ 16
	tie
	F_ 6
	music_end
; 0x1ebefa
