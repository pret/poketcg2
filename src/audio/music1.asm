_SetupSound::
	jp Music1_Init

SoundTimerHandler::
	jp Music1_Update

_PlaySong::
	jp Music1_PlaySong

_PlaySFX::
	jp Music1_PlaySFX

Music1_f400c::
	jp Music1_f404e

_AssertSongFinished::
	jp Music1_AssertSongFinished

_AssertSFXFinished::
	jp Music1_AssertSFXFinished

Music1_f4015::
	jp Music1_f4066

_SetVolume::
	jp Music1_SetVolume

_PauseSong::
	jp Music1_PauseSong

_ResumeSong::
	jp Music1_ResumeSong

Music1_PlaySong:
	call Music1_LoadAudioWRAMBank
	push hl
	ld hl, NumberOfSongs1
	cp [hl]
	jr nc, .invalidID
	ld [wCurSongID], a
.invalidID
	pop hl
	call Music1_UnloadAudioWRAMBank
	ret

Music1_PlaySFX:
	call Music1_LoadAudioWRAMBank
	push bc
	push hl
	ld b, $0
	ld c, a
	or a
	jr z, .play_sfx ; SFX_STOP
	ld hl, Music1_SFXPriorities
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
	call Music1_UnloadAudioWRAMBank
	ret

Music1_f404e:
	call Music1_LoadAudioWRAMBank
	ld [wddf0], a
	call Music1_UnloadAudioWRAMBank
	ret

Music1_AssertSongFinished:
	call Music1_LoadAudioWRAMBank
	ld a, [wCurSongID]
	cp $80
	ld a, $1
	jr nz, .done
	xor a
.done
	call Music1_UnloadAudioWRAMBank
	ret

Music1_AssertSFXFinished:
	call Music1_LoadAudioWRAMBank
	ld a, [wAudio_d005]
	or a
	ld a, $1
	jr nz, .done
	xor a
.done
	call Music1_UnloadAudioWRAMBank
	ret

Music1_f4066:
	call Music1_LoadAudioWRAMBank
	ld a, [wddf2]
	xor $1
	ld [wddf2], a
	call Music1_UnloadAudioWRAMBank
	ret

Music1_SetVolume:
	call Music1_LoadAudioWRAMBank
	push bc
	push af
	and $7
	ld b, a
	swap b
	or b
	ld [wMusicPanning], a
	pop af
	pop bc
	call Music1_UnloadAudioWRAMBank
	ret

Music1_Init:
	call Music1_LoadAudioWRAMBank
	xor a
	ldh [rAUDENA], a
	ld a, AUDENA_ON
	ldh [rAUDENA], a
	ld a, $77
	ldh [rAUDVOL], a
	ld a, AUDTERM_1_RIGHT | AUDTERM_2_RIGHT | AUDTERM_3_RIGHT | AUDTERM_4_RIGHT | AUDTERM_1_LEFT | AUDTERM_2_LEFT | AUDTERM_3_LEFT | AUDTERM_4_LEFT
	ldh [rAUDTERM], a
	ld a, $78
	ld [wCurSongBank], a
	ld a, $7e
	ld [wCurSfxBank], a
	ld a, $80
	ld [wCurSongID], a
	swap a
	ld [wAudio_d083], a
	ld a, $77 ; set both speakers to max volume
	ld [wMusicPanning], a
	xor a
	ld [wdd8c], a
	ld [wde53], a
	ld [wMusicWaveChange], a
	ld [wddef], a
	ld [wddf0], a
	ld [wddf2], a
	ld [wCurSfxID], a
	ld [wAudio_d005], a
	ld [wAudio_d011], a
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
	ld hl, wddb3
	add hl, bc
	ld [hl], d
	ld hl, wMusicPitchOffset
	add hl, bc
	ld [hl], d
	ld hl, wMusicCutoff
	add hl, bc
	ld [hl], d
	ld hl, wAudio_d06c
	add hl, bc
	ld [hl], d
	ld hl, wAudio_d070
	add hl, bc
	ld [hl], d
	inc c
	ld a, c
	cp $4
	jr nz, .zero_loop1
	ld hl, Music1_ChannelLoopStacks
	ld bc, wMusicChannelStackPointers
	ld d, $8
.zero_loop2
	ld a, [hli]
	ld [bc], a
	inc bc
	dec d
	jr nz, .zero_loop2
	call Music1_UnloadAudioWRAMBank
	ret

Music1_Update:
	call Music1_LoadAudioWRAMBank2
	call Music1_EmptyFunc
	call Music1_CheckForNewSound
	ld hl, SFX_UpdateSFX
	call Bankswitch78To7e
	ld a, [wCurSongBank]
	ldh [hBankROM], a
	ld [rROMB], a
	ld a, [wddf2]
	cp $0
	jr z, .update_channels
	call Music1_f4980
	jr .skip_channel_Updates
.update_channels
	call Music1_UpdateChannel1
	call Music1_UpdateChannel2
	call Music1_UpdateChannel3
	call Music1_UpdateChannel4
.skip_channel_Updates
	call Music1_f4866
	call Music1_CheckForEndOfSong
	ld a, [wAudio_d011]
	or a
	jr z, .asm_1dc17b
	call Music1_BackupSong
	xor a
	ld [wAudio_d011], a
.asm_1dc17b
	call Music1_UnloadAudioWRAMBank2
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
	ld hl, SFX_PlaySFX
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
	ld a, AUD1ENV_UP
	ldh [rAUD1ENV], a
	swap a ; AUD1HIGH_RESTART
	ldh [rAUD1HIGH], a
.stop_channel_2
	xor a
	ld [wMusicIsPlaying + 1], a
	bit 1, d
	jr nz, .stop_channel_4
	ld a, AUD2ENV_UP
	ldh [rAUD2ENV], a
	swap a ; AUD2HIGH_RESTART
	ldh [rAUD2HIGH], a
.stop_channel_4
	xor a
	ld [wMusicIsPlaying + 3], a
	bit 3, d
	jr nz, .stop_channel_3
	ld a, AUD4ENV_UP
	ldh [rAUD4ENV], a
	swap a ; AUD4GO_RESTART
	ldh [rAUD4GO], a
.stop_channel_3
	xor a
	ld [wMusicIsPlaying + 2], a
	bit 2, d
	jr nz, .done
	ld a, $0
	ldh [rAUD3LEVEL], a
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
	ld [rROMB], a
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
	ld [wAudio_d06c], a
	ld [wAudio_d070], a
	ld [wAudio_d080], a
	ld a, [Music1_ChannelLoopStacks]
	ld [wMusicChannelStackPointers], a
	ld a, [Music1_ChannelLoopStacks + 1]
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
	ld [wAudio_d06c + 1], a
	ld [wAudio_d070 + 1], a
	ld [wAudio_d080 + 1], a
	ld a, [Music1_ChannelLoopStacks + 2]
	ld [wMusicChannelStackPointers + 2], a
	ld a, [Music1_ChannelLoopStacks + 3]
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
	ld [wAudio_d06c + 2], a
	ld [wAudio_d070 + 2], a
	ld [wAudio_d080 + 2], a
	ld a, [Music1_ChannelLoopStacks + 4]
	ld [wMusicChannelStackPointers + 4], a
	ld a, [Music1_ChannelLoopStacks + 5]
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
	ld [wAudio_d06c + 3], a
	ld [wAudio_d070 + 3], a
	ld [wAudio_d087], a
	ld a, [Music1_ChannelLoopStacks + 6]
	ld [wMusicChannelStackPointers + 6], a
	ld a, [Music1_ChannelLoopStacks + 7]
	ld [wMusicChannelStackPointers + 7], a
	ld a, $40
	ld [wMusicEcho + 3], a
.no_channel_4
	xor a
	ld [wAudio_d011], a
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
	ld hl, rAUD1ENV
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
	call Music1_f4714
.asm_f42f4
	ld a, $0
	call Music1_f485a
	ret
.asm_f42fa
	ld a, [wdd8c]
	bit 0, a
	jr nz, .asm_f4309
	ld a, AUD1ENV_UP
	ldh [rAUD1ENV], a
	swap a ; AUD1HIGH_RESTART
	ldh [rAUD1HIGH], a
.asm_f4309
	ldh a, [rAUD1LEN]
	and AUD1LEN_DUTY
	ldh [rAUD1LEN], a
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
	ld hl, rAUD2ENV
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
	call Music1_f475a
.asm_f4359
	ld a, $1
	call Music1_f485a
	ret
.asm_f435f
	ld a, [wdd8c]
	bit 1, a
	jr nz, .asm_f436e
	ld a, AUD2ENV_UP
	ldh [rAUD2ENV], a
	swap a ; AUD2HIGH_RESTART
	ldh [rAUD2HIGH], a
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
	ldh [rAUD3LEVEL], a
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
	call Music1_f479c
.asm_f43b8
	ld a, $2
	call Music1_f485a
	ret
.asm_f43be
	ld a, [wdd8c]
	bit 2, a
	jr nz, .asm_f43cd
	ld a, $0
	ldh [rAUD3LEVEL], a
	ld a, $80
	ldh [rAUD3HIGH], a
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
	call Music1_f480a
	jr .asm_f4413
.asm_f43f6
	ld a, [wddef]
	or a
	jr z, .asm_f4413
	call Music1_f4839
	ret
.asm_f4400
	ld a, [wdd8c]
	bit 3, a
	jr nz, .asm_f4413
	xor a
	ld [wddef], a
	ld a, AUD4ENV_UP
	ldh [rAUD4ENV], a
	swap a ; AUD4GO_RESTART
	ldh [rAUD4GO], a
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
	dw Music1_end
	dw Music1_end
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
	dw Music1_musicee
	dw Music1_musicef
	dw Music1_preset
	dw Music1_musicf1
	dw Music1_musicf2
	dw Music1_musicf3
	dw Music1_musicf4
	dw Music1_end
	dw Music1_end
	dw Music1_end
	dw Music1_end
	dw Music1_end
	dw Music1_end
	dw Music1_end
	dw Music1_end
	dw Music1_end
	dw Music1_end
	dw Music1_end

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
	ld hl, Music1_NoiseInstruments
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
	ld a, [wAudio_d087]
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
	ld hl, Music1_OctaveOffsets
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
	ld hl, wAudio_d06c
	add hl, bc
	ld [hl], e
	ld hl, Music1_Pitches
	add hl, de
	ld a, [hli]
	ld e, a
	ld d, [hl]
	call Music1_f4967
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
	jp Music1_PlayNextNote_pop

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
	jp Music1_PlayNextNote_pop
.asm_f45b6
	pop af
	ld [hl], a
	jp Music1_PlayNextNote_pop

Music1_inc_octave:
	ld hl, wMusicOctave
	add hl, bc
	inc [hl]
	jp Music1_PlayNextNote_pop

Music1_dec_octave:
	ld hl, wMusicOctave
	add hl, bc
	dec [hl]
	jp Music1_PlayNextNote_pop

Music1_tie:
	ld hl, wMusicTie
	add hl, bc
	ld [hl], $80
	jp Music1_PlayNextNote_pop

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
	jp Music1_PlayNextNote_pop

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
	jp Music1_PlayNextNote_pop

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
	call Music1_GetChannelStackPointer
	ld [hl], e ;
	inc hl     ; store address of command at beginning of loop
	ld [hl], d ;
	inc hl
	pop af
	ld [hl], a ; store loop count
	inc hl
	push de
	call Music1_SetChannelStackPointer
	jp Music1_PlayNextNote_pop

Music1_EndLoop:
	call Music1_GetChannelStackPointer
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
	call Music1_SetChannelStackPointer
	jp Music1_PlayNextNote_pop

Music1_jp:
	pop hl
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp Music1_PlayNextNote

Music1_call:
	call Music1_GetChannelStackPointer
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
	call Music1_SetChannelStackPointer
	jp Music1_PlayNextNote_pop

Music1_ret:
	pop de
	call Music1_GetChannelStackPointer
	dec hl
	ld a, [hld] ;
	ld e, [hl]  ; retrieve address of caller of this sub branch
	ld d, a
	inc de
	inc de
	push de
	call Music1_SetChannelStackPointer
	jp Music1_PlayNextNote_pop

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

Music1_musicee:
	pop de
	ld a, [de]
	inc de
	ld hl, wAudio_d083
	add hl, bc
	ld [hl], a
	ld h, d
	ld l, e
	jp Music1_PlayNextNote

Music1_musicef:
	ld a, c
	cp $03
	jr z, .noise
	pop de
	ld a, [de]
	inc de
	push de
	ld e, a
	ld hl, wMusicVolume
	add hl, bc
	ld a, [hl]
	swap a
	add e
	and $0f
	swap a
	ld d, a
	ld a, [hl]
	and $0f
	or d
	ld [hl], a
	ld hl, wAudio_d07a
	add hl, bc
	ld a, [hl]
	swap a
	add e
	and $0f
	swap a
	ld d, a
	ld a, [hl]
	and $0f
	or d
	ld [hl], a
	pop de
	ld h, d
	ld l, e
	jp Music1_PlayNextNote

.noise
	pop de
	ld a, [de]
	inc de
	and $0f
	swap a
	ld [wAudio_d087], a
	ld h, d
	ld l, e
	jp Music1_PlayNextNote

Music1_preset:
	pop de
	ld a, [de]
	inc de
	ld hl, Music1_Presets
	push bc
	ld c, a
	add hl, bc
	add hl, bc
	pop bc
	push de
	ld a, [hli]
	ld d, [hl]
	ld e, a
	ld a, [de]
	inc de
	cp $00
	jr z, .asm_1dc7f9
	ld hl, wMusicVolume
	add hl, bc
	ld [hl], a
.asm_1dc7f9
	ld a, [de]
	inc de
	cp $ff
	jr z, .asm_1dc804
	ld hl, wMusicDuty1
	add hl, bc
	ld [hl], a
.asm_1dc804
	ld a, [de]
	inc de
	cp $ff
	jr z, .asm_1dc814
	ld hl, wMusicVibratoType
	add hl, bc
	ld [hl], a
	ld hl, wMusicVibratoType2
	add hl, bc
	ld [hl], a
.asm_1dc814
	ld a, [de]
	inc de
	cp $ff
	jr z, .asm_1dc81f
	ld hl, wMusicVibratoDelay
	add hl, bc
	ld [hl], a
.asm_1dc81f
	ld a, [de]
	cp $80
	jr z, .asm_1dc829
	ld hl, wMusicFrequencyOffset
	add hl, bc
	ld [hl], a
.asm_1dc829
	pop de
	ld h, d
	ld l, e
	jp Music1_PlayNextNote

Music1_musicf1:
	pop de
	ld a, [de]
	inc de
	ld hl, wAudio_d07a
	add hl, bc
	ld [hl], a
	ld a, $01
	ld hl, wAudio_d080
	add hl, bc
	ld [hl], a
	xor a
	ld hl, wAudio_d07d
	add hl, bc
	ld [hl], a
	ld h, d
	ld l, e
	jp Music1_PlayNextNote

Music1_musicf2:
	ld a, $01
	ld hl, wAudio_d080
	add hl, bc
	ld [hl], a
	xor a
	ld hl, wAudio_d07d
	add hl, bc
	ld [hl], a
	jp Music1_PlayNextNote_pop

Music1_musicf3:
	xor a
	ld hl, wAudio_d080
	add hl, bc
	ld [hl], a
	jp Music1_PlayNextNote_pop

Music1_musicf4:
	ld a, $01
	ld hl, wAudio_d011
	ld [hl], a
	jp Music1_PlayNextNote_pop

Music1_end:
	ld hl, wMusicIsPlaying
	add hl, bc
	ld [hl], $00
	pop hl
	ret

; returns the address of the top of the stack
; for the current channel
; used for loops and calls
Music1_GetChannelStackPointer:
	ld hl, wMusicChannelStackPointers
	add hl, bc
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ret

; sets the current channel's stack pointer to hl
Music1_SetChannelStackPointer:
	ld d, h
	ld e, l
	ld hl, wMusicChannelStackPointers
	add hl, bc
	add hl, bc
	ld [hl], e
	inc hl
	ld [hl], d
	ret

Music1_PlayNextNote_pop:
	pop hl
	jp Music1_PlayNextNote

Music1_f4714:
	ld a, [wddb7]
	cp $0
	jr z, .asm_f474a
	ld d, $0
	ld hl, wMusicTie
	ld a, [hl]
	cp $80
	jr z, .asm_f4733
	ld a, [wMusicVolume]
	ld d, a
	ld a, [wAudio_d080]
	cp $00
	jr z, .asm_1dc8b5
	ld a, [wAudio_d07a]
	ld e, a
	ld hl, wAudio_d07d
	ld a, [hl]
	inc [hl]
	and $01
	jr z, .asm_1dc8b5
	ld d, e
.asm_1dc8b5
	ld a, [wdd8c]
	bit 0, a
	jr nz, .asm_f4749
	ld a, d
	ldh [rAUD1ENV], a
	ld d, $80
.asm_f4733
	ld hl, wMusicTie
	ld [hl], $2
	ld a, [wdd8c]
	bit 0, a
	jr nz, .asm_f4749
	ld a, [wAudio_d083]
	ldh [rAUD1SWEEP], a
	ld a, [wMusicDuty1]
	ldh [rAUD1LEN], a
	ld a, [wMusicCh1CurPitch]
	ldh [rAUD1LOW], a
	ld a, [wMusicCh1CurOctave]
	or d
	ldh [rAUD1HIGH], a
.asm_f4749
	ret
.asm_f474a
	ld hl, wMusicTie
	ld [hl], $0
	ld a, [wdd8c]
	bit 0, a
	jr nz, .asm_f4749
	ld hl, rAUD1ENV
	ld a, AUD1ENV_UP
	ld [hli], a
	inc hl
	swap a
	ld [hl], a
	ret

Music1_f475a:
	ld a, [wddb8]
	cp $0
	jr z, .asm_f478c
	ld d, $0
	ld hl, wMusicTie + 1
	ld a, [hl]
	cp $80
	jr z, .asm_f4779
	ld a, [wMusicVolume + 1]
	ld d, a
	ld a, [wAudio_d080 + 1]
	cp $00
	jr z, .asm_1dc924
	ld a, [wAudio_d07a + 1]
	ld e, a
	ld hl, wAudio_d07d + 1
	ld a, [hl]
	inc [hl]
	and $01
	jr z, .asm_1dc924
	ld d, e
.asm_1dc924
	ld a, [wdd8c]
	bit 1, a
	jr nz, .asm_f478b
	ld a, d
	ldh [rAUD2ENV], a
	ld d, $80
.asm_f4779
	ld hl, wMusicTie + 1
	ld [hl], $2
	ld a, [wdd8c]
	bit 1, a
	jr nz, .asm_f478b
	ld a, [wMusicDuty2]
	ldh [rAUD2LEN], a
	ld a, [wMusicCh2CurPitch]
	ldh [rAUD2LOW], a
	ld a, [wMusicCh2CurOctave]
	or d
	ldh [rAUD2HIGH], a
.asm_f478b
	ret
.asm_f478c
	ld hl, wMusicTie + 1
	ld [hl], $0
	ld a, [wdd8c]
	bit 1, a
	jr nz, .asm_f478b
	ld hl, rAUD2ENV
	ld a, AUD2ENV_UP
	ld [hli], a
	inc hl
	swap a
	ld [hl], a
	ret

Music1_f479c:
	ld d, $0
	ld a, [wMusicWaveChange]
	or a
	jr z, .no_wave_change
	xor a
	ldh [rAUD3ENA], a
	call Music1_LoadWaveInstrument
	ld d, $80
.no_wave_change
	ld a, [wddb9]
	cp $0
	jr z, .asm_f47e1
	ld hl, wMusicTie + 2
	ld a, [hl]
	cp $80
	jr z, .asm_f47cc
	ld a, [wMusicVolume + 2]
	ld d, a
	ld a, [wAudio_d080 + 2]
	cp $00
	jr z, .asm_1dc99c
	ld a, [wAudio_d07a + 2]
	ld e, a
	ld hl, wAudio_d07d + 2
	ld a, [hl]
	inc [hl]
	and $01
	jr z, .asm_1dc99c
	ld d, e
.asm_1dc99c
	ld a, [wdd8c]
	bit 2, a
	jr nz, .asm_f47e0
	ld a, d
	ldh [rAUD3LEVEL], a
	xor a
	ldh [rAUD3ENA], a
	ld d, $80
.asm_f47cc
	ld hl, wMusicTie + 2
	ld [hl], $2
	ld a, [wdd8c]
	bit 2, a
	jr nz, .asm_f47e0
	xor a
	ldh [rAUD3LEN], a
	ld a, [wMusicCh3CurPitch]
	ldh [rAUD3LOW], a
	ld a, $80
	ldh [rAUD3ENA], a
	ld a, [wMusicCh3CurOctave]
	or d
	ldh [rAUD3HIGH], a
.asm_f47e0
	ret
.asm_f47e1
	ld hl, wMusicTie + 2
	ld [hl], $0
	ld a, [wdd8c]
	bit 2, a
	jr nz, .asm_f47e0
	xor a
	ldh [rAUD3ENA], a
	ret

Music1_LoadWaveInstrument:
	ld a, [wMusicWave]
	add a
	ld d, $0
	ld e, a
	ld hl, Music1_WaveInstruments
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld b, d
	ld de, $ff30
.copy_wave_loop
	ld a, [hli]
	ld [de], a
	inc de
	inc b
	ld a, b
	cp $10
	jr nz, .copy_wave_loop
	xor a
	ld [wMusicWaveChange], a
	ret

Music1_f480a:
	ld a, [wdd8c]
	bit 3, a
	jr nz, .asm_f4829
	ld a, [wddba]
	cp $0
	jr z, .asm_f482a
	ld de, rAUD4LEN
	ld hl, wddab
	ld a, [hli]
	ld [de], a
	inc e
	ld a, [hli]
	ld [de], a
	inc e
	ld a, [hli]
	ld [de], a
	inc e
	ld a, [hli]
	ld [de], a
.asm_f4829
	ret
.asm_f482a
	xor a
	ld [wddef], a
	ld hl, rAUD4ENV
	ld a, AUD4ENV_UP
	ld [hli], a
	inc hl
	swap a
	ld [hl], a
	ret

Music1_f4839:
	ld a, [wdd8c]
	bit 3, a
	jr z, .asm_f4846
	xor a
	ld [wddef], a
	jr .asm_f4859
.asm_f4846
	ld hl, wdded
	ld a, [hli]
	ld d, [hl]
	ld e, a
	ld a, [de]
	cp $ff
	jr nz, .asm_f4853
	jr Music1_f480a.asm_f482a
.asm_f4853
	ldh [rAUD4POLY], a
	inc de
	ld a, d
	ld [hld], a
	ld [hl], e
.asm_f4859
	ret

Music1_f485a:
	push af
	ld b, $0
	ld c, a
	call Music1_UpdateVibrato
	pop af
	call Music1_f490b
	ret

Music1_f4866:
	ld a, [wMusicPanning]
	ldh [rAUDVOL], a
	ld a, [wdd8c]
	or a
	ld hl, wMusicStereoPanning
	ld a, [hli]
	jr z, .asm_f4888
	ld a, [wdd8c]
	and $f
	ld d, a
	swap d
	or d
	ld d, a
	xor $ff
	ld e, a
	ld a, [hld]
	and d
	ld d, a
	ld a, [hl]
	and e
	or d
.asm_f4888
	ld d, a
	ld a, [wddf0]
	xor $ff
	and $f
	ld e, a
	swap e
	or e
	and d
	ldh [rAUDTERM], a
	ret

Music1_UpdateVibrato:
	ld hl, wMusicVibratoDelay
	add hl, bc
	ld a, [hl]
	cp $0
	jr z, .asm_f4902
	ld hl, wdde3
	add hl, bc
	cp [hl]
	jr z, .asm_f48ab
	inc [hl]
	jr .asm_f4902
.asm_f48ab
	ld hl, wMusicVibratoType
	add hl, bc
	ld e, [hl]
	ld d, $0
	ld hl, Music1_VibratoTypes
	add hl, de
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	push hl
	ld hl, wdddb
	add hl, bc
	ld d, $0
	ld e, [hl]
	inc [hl]
	pop hl
	add hl, de
	ld a, [hli]
	cp $80
	jr z, .asm_f48ee
	cp $7f
	jr z, Music1_1dcaff
	ld hl, wMusicCh1CurPitch
	add hl, bc
	add hl, bc
	ld e, [hl]
	inc hl
	ld d, [hl]
	bit 7, a
	jr nz, .asm_f48df
	add e
	ld e, a
	ld a, $0
	adc d
	and $7
	ld d, a
	ret
.asm_f48df
	xor $ff
	inc a
	push bc
	ld c, a
	ld a, e
	sub c
	ld e, a
	ld a, d
	sbc b
	and $7
	ld d, a
	pop bc
	ret
.asm_f48ee
	push hl
	ld hl, wdddb
	add hl, bc
	ld [hl], $0
	pop hl
	ld a, [hl]
	cp $80
	jr z, .asm_f48ab
	ld hl, wMusicVibratoType
	add hl, bc
	ld [hl], a
	jr .asm_f48ab
.asm_f4902
	ld hl, wMusicCh1CurPitch
	add hl, bc
	add hl, bc
	ld e, [hl]
	inc hl
	ld d, [hl]
	ret

Music1_1dcaff:
	ld a, c
	cp $0
	jr nz, .asm_1dcb12
	ld a, [wdd8c]
	bit 0, a
	jr nz, .asm_1dcb22
	ld de, rAUD1LEN
	ld a, [hli]
	ld [de], a
	jr .asm_1dcb22
.asm_1dcb12
	cp $1
	jr nz, .asm_1dcb22
	ld a, [wdd8c]
	bit 0, a
	jr nz, .asm_1dcb22
	ld de, rAUD2LEN
	ld a, [hli]
	ld [de], a
.asm_1dcb22
	ld hl, wdddb
	add hl, bc
	inc [hl]
	jp Music1_UpdateVibrato.asm_f48ab

Music1_f490b:
	cp $0
	jr nz, .not_channel_1
	ld a, [wMusicVibratoDelay]
	cp $0
	jr z, .done
	ld a, [wdd8c]
	bit 0, a
	jr nz, .done
	ld a, e
	ldh [rAUD1LOW], a
	ldh a, [rAUD1LEN]
	and AUD1LEN_DUTY
	ldh [rAUD1LEN], a
	ld a, d
	and $3f
	ldh [rAUD1HIGH], a
	ret
.not_channel_1
	cp $1
	jr nz, .not_channel_2
	ld a, [wMusicVibratoDelay + 1]
	cp $0
	jr z, .done
	ld a, [wdd8c]
	bit 1, a
	jr nz, .done
	ld a, e
	ldh [rAUD2LOW], a
	ldh a, [rAUD2LEN]
	and AUD2LEN_DUTY
	ldh [rAUD2LEN], a
	ld a, d
	ldh [rAUD2HIGH], a
	ret
.not_channel_2
	cp $2
	jr nz, .done
	ld a, [wMusicVibratoDelay + 2]
	cp $0
	jr z, .done
	ld a, [wdd8c]
	bit 2, a
	jr nz, .done
	ld a, e
	ldh [rAUD3LOW], a
	xor a
	ldh [rAUD3LEN], a
	ld a, d
	ldh [rAUD3HIGH], a
.done
	ret

Music1_f4967:
	ld hl, wMusicFrequencyOffset
	add hl, bc
	ld a, [hl]
	bit 7, a
	jr nz, .asm_f4976
	add e
	ld e, a
	ld a, d
	adc b
	ld d, a
	ret
.asm_f4976
	xor $ff
	ld h, a
	ld a, e
	sub h
	ld e, a
	ld a, d
	sbc b
	ld d, a
	ret

Music1_f4980:
	ld a, [wdd8c]
	ld d, a
	bit 0, d
	jr nz, .asm_f4990
	ld a, AUD1ENV_UP
	ldh [rAUD1ENV], a
	swap a ; AUD1HIGH_RESTART
	ldh [rAUD1HIGH], a
.asm_f4990
	bit 1, d
	jr nz, .asm_f499c
	swap a
	ldh [rAUD2ENV], a
	swap a ; AUD2HIGH_RESTART
	ldh [rAUD2HIGH], a
.asm_f499c
	bit 3, d
	jr nz, .asm_f49a8
	swap a
	ldh [rAUD4ENV], a
	swap a ; AUD4GO_RESTART
	ldh [rAUD4GO], a
.asm_f49a8
	bit 2, d
	jr nz, .asm_f49b0
	ld a, $0
	ldh [rAUD3LEVEL], a
.asm_f49b0
	ret

Music1_CheckForEndOfSong:
	ld hl, wMusicIsPlaying
	xor a
	add [hl]
	inc hl
	add [hl]
	inc hl
	add [hl]
	inc hl
	add [hl]
	or a
	ret nz
	ld a, $80
	ld [wCurSongID], a
	ret

Music1_PauseSong:
	di
	call Music1_LoadAudioWRAMBank
	call Music1_f4980
	call Music1_BackupSong
	call Music1_StopAllChannels
	call Music1_UnloadAudioWRAMBank
	ei
	ret

Music1_ResumeSong:
	di
	call Music1_LoadAudioWRAMBank
	call Music1_f4980
	call Music1_StopAllChannels
	call Music1_LoadBackup
	call Music1_UnloadAudioWRAMBank
	ei
	ret

Music1_BackupSong:
	ld a, [wCurSongID]
	ld [wCurSongIDBackup], a
	ld a, [wCurSongBank]
	ld [wCurSongBankBackup], a
	ld a, [wMusicStereoPanning]
	ld [wMusicStereoPanningBackup], a
	ld hl, wMusicDuty1
	ld de, wMusicDuty1Backup
	ld a, $4
	call Music1_CopyData
	ld a, [wMusicWave]
	ld [wMusicWaveBackup], a
	ld a, [wMusicWaveChange]
	ld [wMusicWaveChangeBackup], a
	ld hl, wMusicIsPlaying
	ld de, wMusicIsPlayingBackup
	ld a, $4
	call Music1_CopyData
	ld hl, wMusicTie
	ld de, wMusicTieBackup
	ld a, $4
	call Music1_CopyData
	ld hl, wMusicChannelPointers
	ld de, wMusicChannelPointersBackup
	ld a, $8
	call Music1_CopyData
	ld hl, wMusicMainLoopStart
	ld de, wMusicMainLoopStartBackup
	ld a, $8
	call Music1_CopyData
	ld a, [wddab]
	ld [wde76], a
	ld a, [wddac]
	ld [wde77], a
	ld hl, wMusicOctave
	ld de, wMusicOctaveBackup
	ld a, $4
	call Music1_CopyData
	ld hl, wddb3
	ld de, wde7c
	ld a, $4
	call Music1_CopyData
	ld hl, wddb7
	ld de, wde80
	ld a, $4
	call Music1_CopyData
	ld hl, wddbb
	ld de, wde84
	ld a, $4
	call Music1_CopyData
	ld hl, wMusicCutoff
	ld de, wMusicCutoffBackup
	ld a, $4
	call Music1_CopyData
	ld hl, wddc3
	ld de, wde8c
	ld a, $4
	call Music1_CopyData
	ld hl, wMusicEcho
	ld de, wMusicEchoBackup
	ld a, $4
	call Music1_CopyData
	ld hl, wMusicPitchOffset
	ld de, wMusicPitchOffsetBackup
	ld a, $4
	call Music1_CopyData
	ld hl, wMusicSpeed
	ld de, wMusicSpeedBackup
	ld a, $4
	call Music1_CopyData
	ld hl, wMusicVibratoType2
	ld de, wMusicVibratoType2Backup
	ld a, $4
	call Music1_CopyData
	ld hl, wMusicVibratoDelay
	ld de, wMusicVibratoDelayBackup
	ld a, $4
	call Music1_CopyData
	ld a, $0
	ld [wdddb], a
	ld [wdddb + 1], a
	ld [wdddb + 2], a
	ld [wdddb + 3], a
	ld hl, wMusicVolume
	ld de, wMusicVolumeBackup
	ld a, $3
	call Music1_CopyData
	ld hl, wMusicFrequencyOffset
	ld de, wMusicFrequencyOffsetBackup
	ld a, $3
	call Music1_CopyData
	ld hl, wdded
	ld de, wdeaa
	ld a, $2
	call Music1_CopyData
	ld a, $0
	ld [wdeac], a
	ld hl, wMusicChannelStackPointers
	ld de, wMusicChannelStackPointersBackup
	ld a, $8
	call Music1_CopyData
	ld hl, wMusicCh1Stack
	ld de, wMusicCh1StackBackup
	ld a, $c * 4
	call Music1_CopyData
	ld hl, wAudio_d06c
	ld de, wAudio_d147
	ld a, $04
	call Music1_CopyData
	ld hl, wAudio_d070
	ld de, wAudio_d14b
	ld a, $04
	call Music1_CopyData
	ld hl, wAudio_d07a
	ld de, wAudio_d14f
	ld a, $03
	call Music1_CopyData
	ld hl, wAudio_d07d
	ld de, wAudio_d152
	ld a, $03
	call Music1_CopyData
	ld hl, wAudio_d080
	ld de, wAudio_d155
	ld a, $03
	call Music1_CopyData
	ld a, [wAudio_d083]
	ld [wAudio_d158], a
	ld a, [wAudio_d087]
	ld [wAudio_d146], a
	ret

Music1_LoadBackup:
	ld a, [wCurSongIDBackup]
	ld [wCurSongID], a
	ld a, [wCurSongBankBackup]
	ld [wCurSongBank], a
	ld a, [wMusicStereoPanningBackup]
	ld [wMusicStereoPanning], a
	ld hl, wMusicDuty1Backup
	ld de, wMusicDuty1
	ld a, $4
	call Music1_CopyData
	ld a, [wMusicWaveBackup]
	ld [wMusicWave], a
	ld a, $1
	ld [wMusicWaveChange], a
	ld hl, wMusicIsPlayingBackup
	ld de, wMusicIsPlaying
	ld a, $4
	call Music1_CopyData
	ld hl, wMusicTieBackup
	ld de, wMusicTie
	ld a, $4
	call Music1_CopyData
	ld hl, wMusicChannelPointersBackup
	ld de, wMusicChannelPointers
	ld a, $8
	call Music1_CopyData
	ld hl, wMusicMainLoopStartBackup
	ld de, wMusicMainLoopStart
	ld a, $8
	call Music1_CopyData
	ld a, [wde76]
	ld [wddab], a
	ld a, [wde77]
	ld [wddac], a
	ld hl, wMusicOctaveBackup
	ld de, wMusicOctave
	ld a, $4
	call Music1_CopyData
	ld hl, wde7c
	ld de, wddb3
	ld a, $4
	call Music1_CopyData
	ld hl, wde80
	ld de, wddb7
	ld a, $4
	call Music1_CopyData
	ld hl, wde84
	ld de, wddbb
	ld a, $4
	call Music1_CopyData
	ld hl, wMusicCutoffBackup
	ld de, wMusicCutoff
	ld a, $4
	call Music1_CopyData
	ld hl, wde8c
	ld de, wddc3
	ld a, $4
	call Music1_CopyData
	ld hl, wMusicEchoBackup
	ld de, wMusicEcho
	ld a, $4
	call Music1_CopyData
	ld hl, wMusicPitchOffsetBackup
	ld de, wMusicPitchOffset
	ld a, $4
	call Music1_CopyData
	ld hl, wMusicSpeedBackup
	ld de, wMusicSpeed
	ld a, $4
	call Music1_CopyData
	ld hl, wMusicVibratoType2Backup
	ld de, wMusicVibratoType2
	ld a, $4
	call Music1_CopyData
	ld hl, wMusicVibratoDelayBackup
	ld de, wMusicVibratoDelay
	ld a, $4
	call Music1_CopyData
	ld hl, wMusicVolumeBackup
	ld de, wMusicVolume
	ld a, $3
	call Music1_CopyData
	ld hl, wMusicFrequencyOffsetBackup
	ld de, wMusicFrequencyOffset
	ld a, $3
	call Music1_CopyData
	ld hl, wdeaa
	ld de, wdded
	ld a, $2
	call Music1_CopyData
	ld a, [wdeac]
	ld [wddef], a
	ld hl, wMusicChannelStackPointersBackup
	ld de, wMusicChannelStackPointers
	ld a, $8
	call Music1_CopyData
	ld hl, wMusicCh1StackBackup
	ld de, wMusicCh1Stack
	ld a, $c * 4
	call Music1_CopyData
	ld hl, wAudio_d147
	ld de, wAudio_d06c
	ld a, $04
	call Music1_CopyData
	ld hl, wAudio_d14b
	ld de, wAudio_d070
	ld a, $04
	call Music1_CopyData
	ld hl, wAudio_d14f
	ld de, wAudio_d07a
	ld a, $03
	call Music1_CopyData
	ld hl, wAudio_d152
	ld de, wAudio_d07d
	ld a, $03
	call Music1_CopyData
	ld hl, wAudio_d155
	ld de, wAudio_d080
	ld a, $03
	call Music1_CopyData
	ld a, [wAudio_d158]
	ld [wAudio_d083], a
	ld a, [wAudio_d146]
	ld [wAudio_d087], a
	ret

; copies a bytes from hl to de
Music1_CopyData:
	ld c, a
.loop
	ld a, [hli]
	ld [de], a
	inc de
	dec c
	jr nz, .loop
	ret

Music1_LoadAudioWRAMBank:
	push af
	ldh a, [rWBK]
	push af
	ld a, BANK("WRAM7 Audio")
	ldh [rWBK], a
	pop af
	ld [wSVBKBackup], a
	pop af
	ret

Music1_UnloadAudioWRAMBank:
	push af
	ld a, [wSVBKBackup]
	ldh [rWBK], a
	pop af
	ret

Music1_LoadAudioWRAMBank2:
	push af
	ldh a, [rWBK]
	push af
	ld a, BANK("WRAM7 Audio")
	ldh [rWBK], a
	pop af
	ld [wSVBKBackup2], a
	pop af
	ret

Music1_UnloadAudioWRAMBank2:
	push af
	ld a, [wSVBKBackup2]
	ldh [rWBK], a
	pop af
	ret

Music1_ChannelLoopStacks:
	dw wMusicCh1Stack
	dw wMusicCh2Stack
	dw wMusicCh3Stack
	dw wMusicCh4Stack

; these are address offsets into the pitches table below
; offset = (12 notes per octave * 2 bytes per pitch) * octave
Music1_OctaveOffsets:
	db (12 * 2) * 0
	db (12 * 2) * 1
	db (12 * 2) * 2
	db (12 * 2) * 3
	db (12 * 2) * 4
	db (12 * 2) * 5
	db (12 * 2) * 6
	db (12 * 2) * 7

Music1_Pitches:
	dw $002c ; C_ 0
	dw $009c ; C# 0
	dw $0106 ; D_ 0
	dw $016b ; D# 0
	dw $01c9 ; E_ 0
	dw $0222 ; F_ 0
	dw $0278 ; F# 0
	dw $02c6 ; G_ 0
	dw $0312 ; G# 0
	dw $0358 ; A_ 0
	dw $039b ; A# 0
	dw $03da ; B_ 0
	dw $0416 ; C_ 1
	dw $044e ; C# 1
	dw $0483 ; D_ 1
	dw $04b5 ; D# 1
	dw $04e5 ; E_ 1
	dw $0511 ; F_ 1
	dw $053c ; F# 1
	dw $0563 ; G_ 1
	dw $0589 ; G# 1
	dw $05ac ; A_ 1
	dw $05cd ; A# 1
	dw $05ed ; B_ 1
	dw $060b ; C_ 2
	dw $0628 ; C# 2
	dw $0642 ; D_ 2
	dw $065b ; D# 2
	dw $0672 ; E_ 2
	dw $0689 ; F_ 2
	dw $069e ; F# 2
	dw $06b2 ; G_ 2
	dw $06c4 ; G# 2
	dw $06d6 ; A_ 2
	dw $06e7 ; A# 2
	dw $06f6 ; B_ 2
	dw $0705 ; C_ 3
	dw $0714 ; C# 3
	dw $0721 ; D_ 3
	dw $072d ; D# 3
	dw $0739 ; E_ 3
	dw $0744 ; F_ 3
	dw $074f ; F# 3
	dw $0759 ; G_ 3
	dw $0762 ; G# 3
	dw $076b ; A_ 3
	dw $0773 ; A# 3
	dw $077b ; B_ 3
	dw $0783 ; C_ 4
	dw $078a ; C# 4
	dw $0790 ; D_ 4
	dw $0797 ; D# 4
	dw $079d ; E_ 4
	dw $07a2 ; F_ 4
	dw $07a7 ; F# 4
	dw $07ac ; G_ 4
	dw $07b1 ; G# 4
	dw $07b6 ; A_ 4
	dw $07ba ; A# 4
	dw $07be ; B_ 4
	dw $07c1 ; C_ 5
	dw $07c5 ; C# 5
	dw $07c8 ; D_ 5
	dw $07cb ; D# 5
	dw $07ce ; E_ 5
	dw $07d1 ; F_ 5
	dw $07d4 ; F# 5
	dw $07d6 ; G_ 5
	dw $07d9 ; G# 5
	dw $07db ; A_ 5
	dw $07dd ; A# 5
	dw $07df ; B_ 5
	dw $07e1 ; C_ 6
	dw $07e3 ; C# 6
	dw $07e4 ; D_ 6
	dw $07e5 ; D# 6
	dw $07e7 ; E_ 6
	dw $07e8 ; F_ 6
	dw $07ea ; F# 6
	dw $07eb ; G_ 6
	dw $07ec ; G# 6
	dw $07ed ; A_ 6
	dw $07ee ; A# 6
	dw $07ef ; B_ 6
	dw $07f0 ; C_ 7

Music1_WaveInstruments:
INCLUDE "audio/wave_instruments.asm"

Music1_NoiseInstruments:
INCLUDE "audio/noise_instruments.asm"

Music1_VibratoTypes:
INCLUDE "audio/vibrato_types.asm"

Music1_Presets:
INCLUDE "audio/presets.asm"

; all real SFX have the same priority (SFX_STOP does not use this table)
Music1_SFXPriorities:
	db $00 ; SFX_STOP
	db $0a ; SFX_01
	db $0a ; SFX_02
	db $0a ; SFX_03
	db $0a ; SFX_04
	db $0a ; SFX_05
	db $0a ; SFX_06
	db $0a ; SFX_07
	db $0a ; SFX_08
	db $0a ; SFX_09
	db $0a ; SFX_0A
	db $0a ; SFX_0B
	db $0a ; SFX_0C
	db $0a ; SFX_0D
	db $0a ; SFX_0E
	db $0a ; SFX_0F
	db $0a ; SFX_10
	db $0a ; SFX_11
	db $0a ; SFX_12
	db $0a ; SFX_13
	db $0a ; SFX_14
	db $0a ; SFX_15
	db $0a ; SFX_16
	db $0a ; SFX_17
	db $0a ; SFX_18
	db $0a ; SFX_19
	db $0a ; SFX_1A
	db $0a ; SFX_1B
	db $0a ; SFX_1C
	db $0a ; SFX_1D
	db $0a ; SFX_1E
	db $0a ; SFX_1F
	db $0a ; SFX_20
	db $0a ; SFX_21
	db $0a ; SFX_22
	db $0a ; SFX_23
	db $0a ; SFX_24
	db $0a ; SFX_25
	db $0a ; SFX_26
	db $0a ; SFX_27
	db $0a ; SFX_28
	db $0a ; SFX_29
	db $0a ; SFX_2A
	db $0a ; SFX_2B
	db $0a ; SFX_2C
	db $0a ; SFX_2D
	db $0a ; SFX_2E
	db $0a ; SFX_2F
	db $0a ; SFX_30
	db $0a ; SFX_31
	db $0a ; SFX_32
	db $0a ; SFX_33
	db $0a ; SFX_34
	db $0a ; SFX_35
	db $0a ; SFX_36
	db $0a ; SFX_37
	db $0a ; SFX_38
	db $0a ; SFX_39
	db $0a ; SFX_3A
	db $0a ; SFX_3B
	db $0a ; SFX_3C
	db $0a ; SFX_3D
	db $0a ; SFX_3E
	db $0a ; SFX_3F
	db $0a ; SFX_40
	db $0a ; SFX_41
	db $0a ; SFX_42
	db $0a ; SFX_43
	db $0a ; SFX_44
	db $0a ; SFX_45
	db $0a ; SFX_46
	db $0a ; SFX_47
	db $0a ; SFX_48
	db $0a ; SFX_49
	db $0a ; SFX_4A
	db $0a ; SFX_4B
	db $0a ; SFX_4C
	db $0a ; SFX_4D
	db $0a ; SFX_4E
	db $0a ; SFX_4F
	db $0a ; SFX_50
	db $0a ; SFX_51
	db $0a ; SFX_52
	db $0a ; SFX_53
	db $0a ; SFX_54
	db $0a ; SFX_55
	db $0a ; SFX_56
	db $0a ; SFX_57
	db $0a ; SFX_58
	db $0a ; SFX_59
	db $0a ; SFX_5A
	db $0a ; SFX_5B
	db $0a ; SFX_5C
	db $0a ; SFX_5D
	db $0a ; SFX_5E
	db $0a ; SFX_5F
	db $0a ; SFX_60
	db $0a ; SFX_61
	db $0a ; SFX_62
	db $0a ; SFX_63
	db $0a ; SFX_64
	db $0a ; SFX_65
	db $0a ; SFX_66
	db $0a ; SFX_67
	db $0a ; SFX_68
	db $0a ; SFX_69
	db $0a ; SFX_6A
	db $0a ; SFX_6B
	db $0a ; SFX_6C
	db $0a ; SFX_6D
	db $0a ; SFX_6E
	db $0a ; SFX_6F
	db $0a ; SFX_70
	db $0a ; SFX_71
	db $0a ; SFX_72
	db $0a ; SFX_73
	db $0a ; SFX_74
	db $0a ; SFX_75
	db $0a ; SFX_76
	db $0a ; SFX_77
	db $0a ; SFX_78
	db $0a ; SFX_79
	db $0a ; SFX_7A
	db $0a ; SFX_7B
	db $0a ; SFX_CHIPS_COUNTING
	db $0a ; SFX_7D
	db $0a ; SFX_7E
	db $0a ; SFX_7F
	db $0a ; SFX_80
	db $0a ; SFX_81
	db $0a ; SFX_82
	db $0a ; SFX_83
	db $0a ; SFX_84
	db $0a ; SFX_85
	db $0a ; SFX_86
	db $0a ; SFX_87
	db $0a ; SFX_88
	db $0a ; SFX_89
	db $0a ; SFX_8A
	db $0a ; SFX_8B
	db $0a ; SFX_8C
	db $0a ; SFX_8D
	db $0a ; SFX_8E
	db $0a ; SFX_8F
	db $0a ; SFX_90
	db $0a ; SFX_91
	db $0a ; SFX_92
	db $0a ; SFX_93
	db $0a ; SFX_94
	db $0a ; SFX_95
	db $0a ; SFX_96
	db $0a ; SFX_97
	db $0a ; SFX_98
	db $0a ; SFX_99
	db $0a ; SFX_9A
	db $0a ; SFX_9B
	db $0a ; SFX_9C
	db $0a ; SFX_9D
	db $0a ; SFX_9E
	db $0a ; SFX_9F
	db $0a ; SFX_A0

	db $0a ; ?
	db $0a
	db $0a
	db $0a
	db $0a
	db $0a
	db $0a
	db $0a
	db $0a
	db $0a
	db $0a
	db $0a
	db $0a
	db $0a
	db $0a
	db $0a
	db $0a
	db $0a
	db $0a
	db $0a
	db $0a
	db $0a
	db $0a
	db $0a
	db $0a
	db $0a
	db $0a
	db $0a
	db $0a
	db $0a
	db $0a
	db $0a
	db $0a
	db $0a
	db $0a
	db $0a
	db $0a
	db $0a
	db $0a
	db $0a
	db $0a
	db $0a
	db $0a
	db $0a
	db $0a
	db $0a
	db $0a
	db $0a
	db $0a
	db $0a
	db $0a
	db $0a
	db $0a
	db $0a
	db $0a
	db $0a
	db $0a
	db $0a
	db $0a
	db $0a
	db $0a
	db $0a
	db $0a
	db $0a
	db $0a
	db $0a
	db $0a
	db $0a
	db $0a
	db $0a
	db $0a
	db $0a
	db $0a
	db $0a
	db $0a
	db $0a
	db $0a
	db $0a
	db $0a
	db $0a
	db $0a
	db $0a
	db $0a
	db $0a
	db $0a
	db $0a
	db $0a

INCLUDE "audio/music1_headers.asm"

INCLUDE "audio/music/ishihara.asm"
INCLUDE "audio/music/credits.asm"

	ds $267
