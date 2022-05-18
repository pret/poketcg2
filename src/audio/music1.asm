_SetupSound::
	jp Music1_Init

SoundTimerHandler::
	jp Music1_Update

_PlaySong::
	jp Music1_PlaySong

_PlaySFX::
	jp Music1_PlaySFX

Func_f400c::
	jp Func_f404e

_AssertSongFinished::
	jp Music1_AssertSongFinished

_AssertSFXFinished::
	jp Music1_AssertSFXFinished

Func_f4015::
	jp Func_f4066

Func_f4018::
	jp Func_f406f

_PauseSong::
	jp $4be3 ; Music1_PauseSong

_ResumeSong::
	jp $4bf5 ; Music1_ResumeSong

Music1_PlaySong:
	call $4ed1 ; LoadAudioWRAMBank
	push hl
	ld hl, NumberOfSongs1
	cp [hl]
	jr nc, .invalidID
	ld [wCurSongID], a
.invalidID
	pop hl
	call $4edf ; UnloadAudioWRAMBank
	ret

Music1_PlaySFX:
	call $4ed1 ; LoadAudioWRAMBank
	push bc
	push hl
	ld b, $0
	ld c, a
	or a
	jr z, .play_sfx ; SFX_STOP
	ld hl, $534a ; Music1_SFXPriorities
	add hl, bc
	ld b, [hl]
	ld a, [wSfxPriority]
	or a
	jr z, .play_sfx ; no sfx is currently playing
	cp b
	jr c, .skip ; lower priority
.play_sfx
	ld a, b
	ld [wSfxPriority], a
	ld a, c
	ld [wCurSfxID], a
	ld a, $2
	ld [wAudio_d005], a
.skip
	pop hl
	pop bc
	call $4edf ; UnloadAudioWRAMBank
	ret

Func_f404e:
	call $4ed1 ; LoadAudioWRAMBank
	ld [wddf0], a
	call $4edf ; UnloadAudioWRAMBank
	ret

Music1_AssertSongFinished:
	call $4ed1 ; LoadAudioWRAMBank
	ld a, [wCurSongID]
	cp $80
	ld a, $1
	jr nz, .done
	xor a
.done
	call $4edf ; UnloadAudioWRAMBank
	ret

Music1_AssertSFXFinished:
	call $4ed1 ; LoadAudioWRAMBank
	ld a, [wAudio_d005]
	or a
	ld a, $1
	jr nz, .done
	xor a
.done
	call $4edf ; UnloadAudioWRAMBank
	ret

Func_f4066:
	call $4ed1 ; LoadAudioWRAMBank
	ld a, [wddf2]
	xor $1
	ld [wddf2], a
	call $4edf ; UnloadAudioWRAMBank
	ret

Func_f406f:
	call $4ed1 ; LoadAudioWRAMBank
	push bc
	push af
	and $7
	ld b, a
	swap b
	or b
	ld [wMusicPanning], a
	pop af
	pop bc
	call $4edf ; UnloadAudioWRAMBank
	ret

Music1_Init:
	call $4ed1 ; LoadAudioWRAMBank
	xor a
	ldh [rNR52], a
	ld a, $80
	ldh [rNR52], a
	ld a, $77
	ldh [rNR50], a
	ld a, $ff
	ldh [rNR51], a
	ld a, $78
	ld [wCurSongBank], a
	ld a, $7e
	ld [wAudio_d007], a
	ld a, $80
	ld [wCurSongID], a
	swap a
	ld [wAudio_d083], a
	ld a, $77 ; set both speakers to max volume
	ld [wMusicPanning], a
	xor a
	ld [wdd8c], a
	ld [$d0eb], a ; wde53?
	ld [wMusicWaveChange], a
	ld [wddef], a
	ld [wddf0], a
	ld [wddf2], a
	ld [wCurSfxID], a
	ld [wAudio_d005], a
	ld [$d011], a
	dec a
	ld [wMusicStereoPanning], a
	ld de, $0001
	ld bc, $0000
.zero_loop1
	ld hl, wMusicIsPlaying
	add hl, bc
	ld [hl], d
	ld hl, wMusicTie
	add hl, bc
	ld [hl], d
	ld hl, $d038
	add hl, bc
	ld [hl], d
	ld hl, wMusicPitchOffset
	add hl, bc
	ld [hl], d
	ld hl, wMusicCutoff
	add hl, bc
	ld [hl], d
	ld hl, $d06c
	add hl, bc
	ld [hl], d
	ld hl, $d070
	add hl, bc
	ld [hl], d
	inc c
	ld a, c
	cp $4
	jr nz, .zero_loop1
	ld hl, $4efd ; Music1_ChannelLoopStacks
	ld bc, wMusicChannelStackPointers
	ld d, $8
.zero_loop2
	ld a, [hli]
	ld [bc], a
	inc bc
	dec d
	jr nz, .zero_loop2
	call $4edf ; UnloadAudioWRAMBank
	ret

Music1_Update:
	call $4ee7 ; Func_1dcee7 ; ???
	call Music1_EmptyFunc
	call Music1_CheckForNewSound
	ld hl, $4003 ; SFX_UpdateSFX
	call Bankswitch78To7e
	ld a, [wCurSongBank]
	ldh [hBankROM], a
	ld [MBC3RomBank], a
	ld a, [wddf2]
	cp $0
	jr z, .update_channels
	call $4b9f ; Func_1dcb9f ; Func_f4980
	jr .skip_channel_Updates
.update_channels
	call Music1_UpdateChannel1
	call Music1_UpdateChannel2
	call Music1_UpdateChannel3
	call Music1_UpdateChannel4
.skip_channel_Updates
	call $4a56 ; Func_1dca56 ; Func_f4866?
	call $4bd0 ; Func_1dcbd0 ; Music1_CheckForEndOfSong?
	ld a, [$d011]
	or a
	jr z, .asm_1dc17b
	call $4c07 ; Func_1dcc07 ; ???
	xor a
	ld [$d011], a
.asm_1dc17b
	call $4ef5 ; Func_1dcef5 ; ???
	ret

Music1_CheckForNewSound:
	ld a, [wCurSongID]
	rla
	jr c, .check_for_new_sfx
	call Music1_StopAllChannels
	ld a, [wCurSongID]
	call Music1_BeginSong
	ld a, [wCurSongID]
	or $80
	ld [wCurSongID], a
.check_for_new_sfx
	ld a, [wAudio_d005]
	bit 1, a
	jr z, .no_new_sound
	ld a, [wCurSfxID]
	ld hl, $4000 ; SFX_PlaySFX
	call Bankswitch78To7e
	ld a, $1
	ld [wAudio_d005], a
.no_new_sound
	ret

Music1_StopAllChannels:
	ld a, [wdd8c]
	ld d, a
	xor a
	ld [wMusicIsPlaying], a
	bit 0, d
	jr nz, .stop_channel_2
	ld a, $8
	ldh [rNR12], a
	swap a
	ldh [rNR14], a
.stop_channel_2
	xor a
	ld [wMusicIsPlaying + 1], a
	bit 1, d
	jr nz, .stop_channel_4
	ld a, $8
	ldh [rNR22], a
	swap a
	ldh [rNR24], a
.stop_channel_4
	xor a
	ld [wMusicIsPlaying + 3], a
	bit 3, d
	jr nz, .stop_channel_3
	ld a, $8
	ldh [rNR42], a
	swap a
	ldh [rNR44], a
.stop_channel_3
	xor a
	ld [wMusicIsPlaying + 2], a
	bit 2, d
	jr nz, .done
	ld a, $0
	ldh [rNR32], a
.done
	ret

; plays the song given by the id in a
Music1_BeginSong:
	push af
	ld c, a
	ld b, $0
	ld hl, SongBanks1
	add hl, bc
	ld a, [hl]
	ld [wCurSongBank], a
	ldh [hBankROM], a
	ld [MBC3RomBank], a
	pop af
	add a
	ld c, a
	ld b, $0
	ld hl, SongHeaderPointers1
	add hl, bc
	ld e, [hl]
	inc hl
	ld h, [hl]
	ld l, e
	ld e, [hl]
	inc hl
	ld b, h
	ld c, l
	rr e
	jr nc, .no_channel_1
	ld a, [bc]
	inc bc
	ld [wMusicChannelPointers], a
	ld [wMusicMainLoopStart], a
	ld a, [bc]
	inc bc
	ld [wMusicChannelPointers + 1], a
	ld [wMusicMainLoopStart + 1], a
	ld a, $1
	ld [wddbb], a
	ld [wMusicIsPlaying], a
	xor a
	ld [wMusicTie], a
	ld [wMusicFrequencyOffset], a
	ld [wMusicCutoff], a
	ld [wMusicVibratoDelay], a
	ld [wMusicPitchOffset], a
	ld [$d06c], a
	ld [$d070], a
	ld [$d080], a
	ld a, [$4efd] ; [Music1_ChannelLoopStacks]
	ld [wMusicChannelStackPointers], a
	ld a, [$4efe] ; [Music1_ChannelLoopStacks + 1]
	ld [wMusicChannelStackPointers + 1], a
	ld a, $8
	ld [wMusicEcho], a
	ld [wAudio_d083], a
.no_channel_1
	rr e
	jr nc, .no_channel_2
	ld a, [bc]
	inc bc
	ld [wMusicChannelPointers + 2], a
	ld [wMusicMainLoopStart + 2], a
	ld a, [bc]
	inc bc
	ld [wMusicChannelPointers + 3], a
	ld [wMusicMainLoopStart + 3], a
	ld a, $1
	ld [wddbb + 1], a
	ld [wMusicIsPlaying + 1], a
	xor a
	ld [wMusicTie + 1], a
	ld [wMusicFrequencyOffset + 1], a
	ld [wMusicCutoff + 1], a
	ld [wMusicVibratoDelay + 1], a
	ld [wMusicPitchOffset + 1], a
	ld [$d06d], a
	ld [$d071], a
	ld [$d081], a
	ld a, [$4eff] ; [Music1_ChannelLoopStacks + 2]
	ld [wMusicChannelStackPointers + 2], a
	ld a, [$4f00] ; [Music1_ChannelLoopStacks + 3]
	ld [wMusicChannelStackPointers + 3], a
	ld a, $8
	ld [wMusicEcho + 1], a
.no_channel_2
	rr e
	jr nc, .no_channel_3
	ld a, [bc]
	inc bc
	ld [wMusicChannelPointers + 4], a
	ld [wMusicMainLoopStart + 4], a
	ld a, [bc]
	inc bc
	ld [wMusicChannelPointers + 5], a
	ld [wMusicMainLoopStart + 5], a
	ld a, $1
	ld [wddbb + 2], a
	ld [wMusicIsPlaying + 2], a
	xor a
	ld [wMusicTie + 2], a
	ld [wMusicFrequencyOffset + 2], a
	ld [wMusicCutoff + 2], a
	ld [wMusicVibratoDelay + 2], a
	ld [wMusicPitchOffset + 2], a
	ld [$d06e], a
	ld [$d072], a
	ld [$d082], a
	ld a, [$4f01] ; [Music1_ChannelLoopStacks + 4]
	ld [wMusicChannelStackPointers + 4], a
	ld a, [$4f02] ; [Music1_ChannelLoopStacks + 5]
	ld [wMusicChannelStackPointers + 5], a
	ld a, $40
	ld [wMusicEcho + 2], a
.no_channel_3
	rr e
	jr nc, .no_channel_4
	ld a, [bc]
	inc bc
	ld [wMusicChannelPointers + 6], a
	ld [wMusicMainLoopStart + 6], a
	ld a, [bc]
	inc bc
	ld [wMusicChannelPointers + 7], a
	ld [wMusicMainLoopStart + 7], a
	ld a, $1
	ld [wddbb + 3], a
	ld [wMusicIsPlaying + 3], a
	xor a
	ld [wMusicTie + 3], a
	ld [wMusicCutoff + 3], a
	ld [wMusicVibratoDelay + 3], a
	ld [wMusicPitchOffset + 3], a
	ld [$d06f], a
	ld [$d073], a
	ld [$d087], a
	ld a, [$4f03] ; [Music1_ChannelLoopStacks + 6]
	ld [wMusicChannelStackPointers + 6], a
	ld a, [$4f04] ; [Music1_ChannelLoopStacks + 7]
	ld [wMusicChannelStackPointers + 7], a
	ld a, $40
	ld [wMusicEcho + 3], a
.no_channel_4
	xor a
	ld [$d011], a
	ld [wddf2], a
	ret

Music1_EmptyFunc:
	ret

Music1_UpdateChannel1:
	ld a, [wMusicIsPlaying]
	or a
	jr z, .asm_f42fa
	ld a, [wddb7]
	cp $0
	jr z, .asm_f42d4
	ld a, [wddc3]
	dec a
	ld [wddc3], a
	jr nz, .asm_f42d4
	ld a, [wddbb]
	cp $1
	jr z, .asm_f42d4
	ld a, [wdd8c]
	bit 0, a
	jr nz, .asm_f42d4
	ld hl, rNR12
	ld a, [wMusicEcho]
	ld [hli], a
	inc hl
	ld a, $80
	ld [hl], a
.asm_f42d4
	ld a, [wddbb]
	dec a
	ld [wddbb], a
	jr nz, .asm_f42f4
	ld a, [wMusicChannelPointers + 1]
	ld h, a
	ld a, [wMusicChannelPointers]
	ld l, a
	ld bc, $0000
	call Music1_PlayNextNote
	ld a, [wMusicIsPlaying]
	or a
	jr z, .asm_f42fa
	call $488b ; Func_f4714
.asm_f42f4
	ld a, $0
	call $4a4a ; Func_f485a
	ret
.asm_f42fa
	ld a, [wdd8c]
	bit 0, a
	jr nz, .asm_f4309
	ld a, $8
	ldh [rNR12], a
	swap a
	ldh [rNR14], a
.asm_f4309
	ldh a, [rNR11]
	and $c0
	ldh [rNR11], a
	ret

Music1_UpdateChannel2:
	ld a, [wMusicIsPlaying + 1]
	or a
	jr z, .asm_f435f
	ld a, [wddb8]
	cp $0
	jr z, .asm_f4339
	ld a, [wddc3 + 1]
	dec a
	ld [wddc3 + 1], a
	jr nz, .asm_f4339
	ld a, [wddbb + 1]
	cp $1
	jr z, .asm_f4339
	ld a, [wdd8c]
	bit 1, a
	jr nz, .asm_f4339
	ld hl, rNR22
	ld a, [wMusicEcho + 1]
	ld [hli], a
	inc hl
	ld a, $80
	ld [hl], a
.asm_f4339
	ld a, [wddbb + 1]
	dec a
	ld [wddbb + 1], a
	jr nz, .asm_f4359
	ld a, [wMusicChannelPointers + 3]
	ld h, a
	ld a, [wMusicChannelPointers + 2]
	ld l, a
	ld bc, $0001
	call Music1_PlayNextNote
	ld a, [wMusicIsPlaying + 1]
	or a
	jr z, .asm_f435f
	call $48fa ; Func_f475a
.asm_f4359
	ld a, $1
	call $4a4a ; Func_f485a
	ret
.asm_f435f
	ld a, [wdd8c]
	bit 1, a
	jr nz, .asm_f436e
	ld a, $8
	ldh [rNR22], a
	swap a
	ldh [rNR24], a
.asm_f436e
	ret

Music1_UpdateChannel3:
	ld a, [wMusicIsPlaying + 2]
	or a
	jr z, .asm_f43be
	ld a, [wddb9]
	cp $0
	jr z, .asm_f4398
	ld a, [wddc3 + 2]
	dec a
	ld [wddc3 + 2], a
	jr nz, .asm_f4398
	ld a, [wdd8c]
	bit 2, a
	jr nz, .asm_f4398
	ld a, [wddbb + 2]
	cp $1
	jr z, .asm_f4398
	ld a, [wMusicEcho + 2]
	ldh [rNR32], a
.asm_f4398
	ld a, [wddbb + 2]
	dec a
	ld [wddbb + 2], a
	jr nz, .asm_f43b8
	ld a, [wMusicChannelPointers + 5]
	ld h, a
	ld a, [wMusicChannelPointers + 4]
	ld l, a
	ld bc, $0002
	call Music1_PlayNextNote
	ld a, [wMusicIsPlaying + 2]
	or a
	jr z, .asm_f43be
	call $4964 ; Func_f479c
.asm_f43b8
	ld a, $2
	call $4a4a ; Func_f485a
	ret
.asm_f43be
	ld a, [wdd8c]
	bit 2, a
	jr nz, .asm_f43cd
	ld a, $0
	ldh [rNR32], a
	ld a, $80
	ldh [rNR34], a
.asm_f43cd
	ret

Music1_UpdateChannel4:
	ld a, [wMusicIsPlaying + 3]
	or a
	jr z, .asm_f4400
	ld a, [wddbb + 3]
	dec a
	ld [wddbb + 3], a
	jr nz, .asm_f43f6
	ld a, [wMusicChannelPointers + 7]
	ld h, a
	ld a, [wMusicChannelPointers + 6]
	ld l, a
	ld bc, $0003
	call Music1_PlayNextNote
	ld a, [wMusicIsPlaying + 3]
	or a
	jr z, .asm_f4400
	call $49fa ; Func_f480a
	jr .asm_f4413
.asm_f43f6
	ld a, [wddef]
	or a
	jr z, .asm_f4413
	call $4a29 ; Func_f4839
	ret
.asm_f4400
	ld a, [wdd8c]
	bit 3, a
	jr nz, .asm_f4413
	xor a
	ld [wddef], a
	ld a, $8
	ldh [rNR42], a
	swap a
	ldh [rNR44], a
.asm_f4413
	ret

Music1_PlayNextNote:
	ld a, [hli]
	push hl
	push af
	cp $d0
	jr c, Music1_note
	sub $d0
	add a
	ld e, a
	ld d, $0
	ld hl, Music1_CommandTable
	add hl, de
	ld e, [hl]
	inc hl
	ld d, [hl]
	ld h, d
	ld l, e
	pop af
	jp hl

Music1_CommandTable:
	dw Music1_speed
	dw Music1_octave
	dw Music1_octave
	dw Music1_octave
	dw Music1_octave
	dw Music1_octave
	dw Music1_octave
	dw Music1_inc_octave
	dw Music1_dec_octave
	dw Music1_tie
	dw $486b ; Music1_end
	dw $486b ; Music1_end
	dw Music1_stereo_panning
	dw Music1_MainLoop
	dw Music1_EndMainLoop
	dw Music1_Loop
	dw Music1_EndLoop
	dw Music1_jp
	dw Music1_call
	dw Music1_ret
	dw Music1_frequency_offset
	dw Music1_duty
	dw Music1_volume
	dw Music1_wave
	dw Music1_cutoff
	dw Music1_echo
	dw Music1_vibrato_type
	dw Music1_vibrato_delay
	dw Music1_pitch_offset
	dw Music1_adjust_pitch_offset
	dw $478f ; Music1_
	dw $479c ; Music1_
	dw $47df ; Music1_
	dw $482f ; Music1_
	dw $4849 ; Music1_
	dw $4859 ; Music1_
	dw $4862 ; Music1_
	dw $486b ; Music1_end
	dw $486b ; Music1_end
	dw $486b ; Music1_end
	dw $486b ; Music1_end
	dw $486b ; Music1_end
	dw $486b ; Music1_end
	dw $486b ; Music1_end
	dw $486b ; Music1_end
	dw $486b ; Music1_end
	dw $486b ; Music1_end
	dw $486b ; Music1_end

Music1_note:
	push af
	ld a, [hl]
	ld e, a
	ld hl, wMusicTie
	add hl, bc
	ld a, [hl]
	cp $80
	jr z, .asm_f44b0
	ld [hl], $1
	xor a
	ld hl, wdddb
	add hl, bc
	ld [hl], a
	ld hl, wdde3
	add hl, bc
	ld [hl], a
	inc [hl]
	ld hl, wMusicVibratoType2
	add hl, bc
	ld a, [hl]
	ld hl, wMusicVibratoType
	add hl, bc
	ld [hl], a
.asm_f44b0
	pop af
	push de
	ld hl, wMusicSpeed
	add hl, bc
	ld d, [hl]
	and $f
	inc a
	cp d
	jr nc, .asm_f44c0
	ld e, a
	ld a, d
	ld d, e
.asm_f44c0
	ld e, a
.asm_f44c1
	dec d
	jr z, .asm_f44c7
	add e
	jr .asm_f44c1
.asm_f44c7
	ld hl, wddbb
	add hl, bc
	ld [hl], a
	pop de
	ld d, a
	ld a, e
	cp $d9
	ld a, d
	jr z, .asm_f44fb
	ld e, a
	ld hl, wMusicCutoff
	add hl, bc
	ld a, [hl]
	cp $8
	ld d, a
	ld a, e
	jr z, .asm_f44fb
	push hl
	push bc
	ld b, $0
	ld c, a
	ld hl, $0000
.asm_f44e8
	add hl, bc
	dec d
	jr nz, .asm_f44e8
	srl h
	rr l
	srl h
	rr l
	srl h
	rr l
	ld a, l
	pop bc
	pop hl
.asm_f44fb
	ld hl, wddc3
	add hl, bc
	ld [hl], a
	pop af
	and $f0
	ld hl, wddb7
	add hl, bc
	ld [hl], a
	or a
	jr nz, .asm_f450e
	jp .asm_f458e
.asm_f450e
	swap a
	dec a
	ld h, a
	ld a, $3
	cp c
	ld a, h
	jr z, .asm_f451a
	jr .asm_f4564
.asm_f451a
	push af
	ld hl, wMusicOctave
	add hl, bc
	ld a, [hl]
	ld d, a
	sla a
	add d
	sla a
	sla a
	sla a
	ld e, a
	pop af
	ld hl, $5035 ; Music1_NoiseInstruments
	add a
	ld d, c
	ld c, a
	add hl, bc
	ld c, e
	add hl, bc
	ld c, d
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, [hli]
	ld d, a
	ld a, [wMusicStereoPanning]
	and $77
	or d
	ld [wMusicStereoPanning], a
	ld de, wddab
	ld a, [hli]
	ld [de], a
	inc de
	ld b, [hl]
	inc hl
	ld a, [$d087]
	add b
	ld [de], a
	inc de
	ld b, [hl]
	inc hl
	ld a, [hli]
	ld [de], a
	inc de
	ld a, b
	ld [de], a
	ld b, $0
	ld a, l
	ld d, h
	ld hl, wdded
	ld [hli], a
	ld [hl], d
	ld a, $1
	ld [wddef], a
	jr .asm_f458e
.asm_f4564
	ld hl, wMusicCh1CurPitch
	add hl, bc
	add hl, bc
	push hl
	ld hl, wMusicOctave
	add hl, bc
	ld e, [hl]
	ld d, $0
	ld hl, $4f05 ; Music1_OctaveOffsets
	add hl, de
	add a
	ld e, [hl]
	add e
	ld hl, wMusicPitchOffset
	add hl, bc
	ld e, [hl]
	add e
	add e
	ld e, a
	ld hl, $d06c
	add hl, bc
	ld [hl], e
	ld hl, $4f0d ; Music1_Pitches
	add hl, de
	ld a, [hli]
	ld e, a
	ld d, [hl]
	call $4b86 ; Func_f4967
	pop hl
	ld a, e
	ld [hli], a
	ld [hl], d
.asm_f458e
	pop de
	ld hl, wMusicChannelPointers
	add hl, bc
	add hl, bc
	ld [hl], e
	inc hl
	ld [hl], d
	ret

Music1_speed:
	pop hl
	ld a, [hli]
	push hl
	ld hl, wMusicSpeed
	add hl, bc
	ld [hl], a
	jp $4887 ; Music1_PlayNextNote_pop

Music1_octave:
	and $7
	dec a
	ld hl, wMusicOctave
	add hl, bc
	push af
	ld a, c
	cp $2
	jr nz, .asm_f45b6
	pop af
	inc a
	ld [hl], a
	jp $4887 ; Music1_PlayNextNote_pop
.asm_f45b6
	pop af
	ld [hl], a
	jp $4887 ; Music1_PlayNextNote_pop

Music1_inc_octave:
	ld hl, wMusicOctave
	add hl, bc
	inc [hl]
	jp $4887 ; Music1_PlayNextNote_pop

Music1_dec_octave:
	ld hl, wMusicOctave
	add hl, bc
	dec [hl]
	jp $4887 ; Music1_PlayNextNote_pop

Music1_tie:
	ld hl, wMusicTie
	add hl, bc
	ld [hl], $80
	jp $4887 ; Music1_PlayNextNote_pop

Music1_stereo_panning:
	pop hl
	ld a, [hli]
	push hl
	push bc
	inc c
	ld e, %11101110 ; mask
.loop
	dec c
	jr z, .done
	rlca ; rotate input param
	rlc e ; rotate mask
	jr .loop
.done
	ld d, a
	ld hl, wMusicStereoPanning
	ld a, [hl]
	and e ; keep old panning for all other channels
	or d ; apply new panning for this channel
	ld [hl], a
	pop bc
	jp $4887 ; Music1_PlayNextNote_pop

Music1_MainLoop:
	pop de
	push de
	dec de
	ld hl, wMusicMainLoopStart
	add hl, bc
	add hl, bc
	ld [hl], e
	inc hl
	ld [hl], d
	jp $4887 ; Music1_PlayNextNote_pop

Music1_EndMainLoop:
	pop hl
	ld hl, wMusicMainLoopStart
	add hl, bc
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp Music1_PlayNextNote

Music1_Loop:
	pop de
	ld a, [de] ; get loop count
	inc de
	push af
	call $4873 ; Music1_GetChannelStackPointer
	ld [hl], e ;
	inc hl     ; store address of command at beginning of loop
	ld [hl], d ;
	inc hl
	pop af
	ld [hl], a ; store loop count
	inc hl
	push de
	call $487c ; Music1_SetChannelStackPointer
	jp $4887 ; Music1_PlayNextNote_pop

Music1_EndLoop:
	call $4873 ; Music1_GetChannelStackPointer
	dec hl
	ld a, [hl] ; get remaining loop count
	dec a
	jr z, .loop_done
	ld [hld], a
	ld d, [hl]
	dec hl
	ld e, [hl]
	pop hl
	ld h, d ;
	ld l, e ; go to address of beginning of loop
	jp Music1_PlayNextNote
.loop_done
	dec hl
	dec hl
	call $487c ; Music1_SetChannelStackPointer
	jp $4887 ; Music1_PlayNextNote_pop

Music1_jp:
	pop hl
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp Music1_PlayNextNote

Music1_call:
	call $4873 ; Music1_GetChannelStackPointer
	pop de
	ld a, e
	ld [hli], a ;
	ld a, d     ; store address of command after call
	ld [hli], a ;
	ld a, [de]
	ld b, a
	inc de
	ld a, [de]
	ld d, a
	ld e, b
	ld b, $0
	push de
	call $487c ; Music1_SetChannelStackPointer
	jp $4887 ; Music1_PlayNextNote_pop

Music1_ret:
	pop de
	call $4873 ; Music1_GetChannelStackPointer
	dec hl
	ld a, [hld] ;
	ld e, [hl]  ; retrieve address of caller of this sub branch
	ld d, a
	inc de
	inc de
	push de
	call $487c ; Music1_SetChannelStackPointer
	jp $4887 ; Music1_PlayNextNote_pop

Music1_frequency_offset:
	pop de
	ld a, [de]
	inc de
	ld hl, wMusicFrequencyOffset
	add hl, bc
	ld [hl], a
	ld h, d
	ld l, e
	jp Music1_PlayNextNote

Music1_duty:
	pop de
	ld a, [de]
	and $c0
	inc de
	ld hl, wMusicDuty1
	add hl, bc
	ld [hl], a
	ld h, d
	ld l, e
	jp Music1_PlayNextNote

Music1_volume:
	pop de
	ld a, [de]
	inc de
	ld hl, wMusicVolume
	add hl, bc
	ld [hl], a
	ld h, d
	ld l, e
	jp Music1_PlayNextNote

Music1_wave:
	pop de
	ld a, [de]
	inc de
	ld [wMusicWave], a
	ld a, $1
	ld [wMusicWaveChange], a
	ld h, d
	ld l, e
	jp Music1_PlayNextNote

Music1_cutoff:
	pop de
	ld a, [de]
	inc de
	ld hl, wMusicCutoff
	add hl, bc
	ld [hl], a
	ld h, d
	ld l, e
	jp Music1_PlayNextNote

Music1_echo:
	pop de
	ld a, [de]
	inc de
	ld hl, wMusicEcho
	add hl, bc
	ld [hl], a
	ld h, d
	ld l, e
	jp Music1_PlayNextNote

Music1_vibrato_type:
	pop de
	ld a, [de]
	inc de
	ld hl, wMusicVibratoType
	add hl, bc
	ld [hl], a
	ld hl, wMusicVibratoType2
	add hl, bc
	ld [hl], a
	ld h, d
	ld l, e
	jp Music1_PlayNextNote

Music1_vibrato_delay:
	pop de
	ld a, [de]
	inc de
	ld hl, wMusicVibratoDelay
	add hl, bc
	ld [hl], a
	ld h, d
	ld l, e
	jp Music1_PlayNextNote

Music1_pitch_offset:
	pop de
	ld a, [de]
	inc de
	ld hl, wMusicPitchOffset
	add hl, bc
	ld [hl], a
	ld h, d
	ld l, e
	jp Music1_PlayNextNote

Music1_adjust_pitch_offset:
	pop de
	ld a, [de]
	inc de
	ld hl, wMusicPitchOffset
	add hl, bc
	add [hl]
	ld [hl], a
	ld h, d
	ld l, e
	jp Music1_PlayNextNote
