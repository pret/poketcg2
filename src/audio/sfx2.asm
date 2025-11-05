SFX2_PlaySFX:
	jp SFX2_Play

SFX2_UpdateSFX:
	jp SFX2_Update

SFX2_Play:
	ld hl, NumberOfSFX2
	cp [hl]
	jp nc, .invalidID
	ld c, a
	ld b, $0
	ld l, c
	ld h, b
	add hl, bc
	ld c, l
	ld b, h
	ld a, [wde53]
	or a
	jr z, .asm_1f805a
	ld a, [wdd8c]
	rrca
	ld [wdd8c], a
	jr nc, .asm_1f802e
	ld a, AUD1SWEEP_DOWN
	ldh [rAUD1SWEEP], a
	ldh [rAUD1ENV], a
	swap a ; AUD1HIGH_RESTART
	ldh [rAUD1HIGH], a
.asm_1f802e
	ld a, [wdd8c]
	rrca
	ld [wdd8c], a
	jr nc, .asm_1f803f
	ld a, AUD2ENV_UP
	ldh [rAUD2ENV], a
	swap a ; AUD2HIGH_RESTART
	ldh [rAUD2HIGH], a
.asm_1f803f
	ld a, [wdd8c]
	rrca
	ld [wdd8c], a
	jr nc, .asm_1f804c
	ld a, $0
	ldh [rAUD3LEVEL], a
.asm_1f804c
	ld a, [wdd8c]
	rrca
	jr nc, .asm_1f805a
	ld a, AUD4ENV_UP
	ldh [rAUD4ENV], a
	swap a ; AUD4GO_RESTART
	ldh [rAUD4GO], a
.asm_1f805a
	ld a, $1
	ld [wde53], a
	ld hl, SFXHeaderPointers2
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, [hli]
	ld [wCurSfxBank], a
	ld a, [hli]
	ld [wdd8c], a
	ld [wde54], a
	ld de, wd0e3
	ld c, $0
	ld b, $0
.asm_fc031
	ld a, [wde54]
	rrca
	ld [wde54], a
	jr nc, .asm_fc050
	ld a, [hli]
	ld [de], a
	inc de
	ld a, [hli]
	ld [de], a
	inc de
	push hl
	ld a, c
	cp $0
	jr nz, .asm_1f8091
	ld a, AUD1SWEEP_DOWN
	ldh [rAUD1SWEEP], a
.asm_1f8091
	ld hl, wde2f
	add hl, bc
	ld [hl], $0
	ld hl, wde33
	add hl, bc
	ld [hl], $1
	pop hl
	jr .asm_fc052
.asm_fc050
	inc de
	inc de
.asm_fc052
	inc c
	ld a, $4
	cp c
	jr nz, .asm_fc031
.invalidID
	ret

SFX2_Update:
	ld a, [wCurSfxBank]
	ldh [hBankROM], a
	ld [rROMB], a
	ld a, [wdd8c]
	or a
	jr nz, .asm_fc063
	call Func_fc26c_2
	ret
.asm_fc063
	xor a
	ld b, a
	ld c, a
	ld a, [wdd8c]
	ld [wAudio_d0ed], a
.asm_fc06c
	ld hl, wAudio_d0ed
	ld a, [hl]
	rrca
	ld [hl], a
	jr nc, .asm_fc08d
	ld hl, wde33
	add hl, bc
	ld a, [hl]
	dec a
	jr z, .asm_fc082
	ld [hl], a
	call Func_fc18d_2
	jr .asm_fc08d
.asm_fc082
	ld hl, wd0e3
	add hl, bc
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	call Func_fc094_2
.asm_fc08d
	inc c
	ld a, c
	cp $4
	jr nz, .asm_fc06c
	ret

Func_fc094_2:
	ld a, [hl]
	and $f0
	swap a
	add a
	ld e, a
	ld d, $0
	ld a, [hli]
	push hl
	and $f
	ld hl, SFX2_CommandTable
	add hl, de
	ld e, [hl]
	inc hl
	ld d, [hl]
	ld h, d
	ld l, e
	jp hl

SFX2_CommandTable:
	dw SFX2_0
	dw SFX2_1
	dw SFX2_2
	dw SFX2_loop
	dw SFX2_endloop
	dw SFX2_5
	dw SFX2_6
	dw SFX2_7
	dw SFX2_8
	dw SFX2_9
	dw SFX2_unused
	dw SFX2_unused
	dw SFX2_unused
	dw SFX2_unused
	dw SFX2_unused
	dw SFX2_end

SFX2_unused:
	jp Func_fc094_2

SFX2_0:
	ld d, a
	pop hl
	ld a, [hli]
	ld e, a
	push hl
	ld hl, wde37
	add hl, bc
	add hl, bc
	push bc
	ld b, [hl]
	ld [hl], e
	inc hl
	ld [hl], d
	ld a, c
	cp $3
	jr nz, .asm_fc0e9
	ld a, b
	xor e
	and $8
	swap a
	ld d, a
.asm_fc0e9
	pop bc
	ld hl, wde2b
	add hl, bc
	ld a, [hl]
	ld [hl], $0
	or d
	ld d, a
	ld hl, rAUD1LEN
	ld a, c
	add a
	add a
	add c
	add l
	ld l, a
	ld a, [hl]
	and $c0
	ld [hli], a
	inc hl
	ld a, e
	ld [hli], a
	ld [hl], d
	pop de
Func_fc105_2:
	ld hl, wd0e3
	add hl, bc
	add hl, bc
	ld [hl], e
	inc hl
	ld [hl], d
	ret

SFX2_1:
	ld hl, wde2b
	add hl, bc
	ld a, $80
	ld [hl], a
	pop hl
	ld a, [hli]
	ld e, a
	push hl
	ld hl, rAUD1ENV
	ld a, c
	add a
	add a
	add c
	add l
	ld l, a
	ld [hl], e
	pop hl
	jp Func_fc094_2

SFX2_2:
	swap a
	ld e, a
	ld hl, rAUD1LEN
	ld a, c
	add a
	add a
	add c
	add l
	ld l, a
	ld [hl], e
	pop hl
	jp Func_fc094_2

SFX2_loop:
	ld hl, wde43
	add hl, bc
	add hl, bc
	pop de
	ld a, [de]
	inc de
	ld [hl], e
	inc hl
	ld [hl], d
	ld hl, wde3f
	add hl, bc
	ld [hl], a
	ld l, e
	ld h, d
	jp Func_fc094_2

SFX2_endloop:
	ld hl, wde3f
	add hl, bc
	ld a, [hl]
	dec a
	jr z, .asm_fc162
	ld [hl], a
	ld hl, wde43
	add hl, bc
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	pop de
	jp Func_fc094_2
.asm_fc162
	pop hl
	jp Func_fc094_2

SFX2_5:
	ld hl, wde2f
	add hl, bc
	ld e, l
	ld d, h
	pop hl
	ld a, [hli]
	ld [de], a
	jp Func_fc094_2

SFX2_6:
	ld a, c
	cp $3
	jr nz, .asm_fc17c
	call Func_fc1cd_2
	jr .asm_fc17f
.asm_fc17c
	call Func_fc18d_2
.asm_fc17f
	ld hl, wde33
	add hl, bc
	ld e, l
	ld d, h
	pop hl
	ld a, [hli]
	ld [de], a
	ld e, l
	ld d, h
	jp Func_fc105_2

Func_fc18d_2:
	ld hl, wde2f
	add hl, bc
	ld a, [hl]
	or a
	jr z, .asm_fc1cc
	ld hl, wde37
	add hl, bc
	add hl, bc
	bit 7, a
	jr z, .asm_fc1aa
	xor $ff
	inc a
	ld d, a
	ld a, [hl]
	sub d
	ld [hli], a
	ld e, a
	ld a, [hl]
	sbc b
	jr .asm_fc1b1
.asm_fc1aa
	ld d, a
	ld a, [hl]
	add d
	ld [hli], a
	ld e, a
	ld a, [hl]
	adc b
.asm_fc1b1
	ld [hl], a
	ld hl, wde2b
	add hl, bc
	ld d, [hl]
	ld [hl], $0
	or d
	ld d, a
	ld hl, rAUD1LEN
	ld a, c
	add a
	add a
	add c
	add l
	ld l, a
	ld a, [hl]
	and $c0
	ld [hli], a
	inc hl
	ld a, e
	ld [hli], a
	ld [hl], d
.asm_fc1cc
	ret

Func_fc1cd_2:
	ld hl, wde32
	ld a, [hl]
	or a
	jr z, .asm_fc201
	ld hl, wde3d
	bit 7, a
	jr z, .asm_fc1e5
	xor $ff
	inc a
	ld d, a
	ld e, [hl]
	ld a, e
	sub d
	ld [hl], a
	jr .asm_fc1ea
.asm_fc1e5
	ld d, a
	ld e, [hl]
	ld a, e
	add d
	ld [hl], a
.asm_fc1ea
	ld d, a
	xor e
	and $8
	swap a
	ld hl, wde2e
	ld e, [hl]
	ld [hl], $0
	or e
	ld e, a
	ld hl, rAUD4LEN
	xor a
	ld [hli], a
	inc hl
	ld a, d
	ld [hli], a
	ld [hl], e
.asm_fc201
	ret

SFX2_7:
	add a
	ld d, $0
	ld e, a
	ld hl, SFX_WaveInstruments2
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, $0
	ldh [rAUD3ENA], a
	ld b, d
	ld de, $ff30
.asm_fc215
	ld a, [hli]
	ld [de], a
	inc de
	inc b
	ld a, b
	cp $10
	jr nz, .asm_fc215
	ld a, $1
	ld [wMusicWaveChange], a
	ld a, $80
	ldh [rAUD3ENA], a
	ld b, $0
	pop hl
	jp Func_fc094_2

SFX2_8:
	pop hl
	ld a, [hli]
	push hl
	push bc
	inc c
	ld e, $ee
.asm_fc234
	dec c
	jr z, .asm_fc23c
	rlca
	rlc e
	jr .asm_fc234
.asm_fc23c
	ld d, a
	ld hl, wdd85
	ld a, [hl]
	and e
	or d
	ld [hl], a
	pop bc
	pop hl
	jp Func_fc094_2

SFX2_9:
	pop hl
	ld a, [hli]
	ldh [rAUD1SWEEP], a
	jp Func_fc094_2

SFX2_end:
	ld e, c
	inc e
	ld a, $7f
.asm_fc24d
	rlca
	dec e
	jr nz, .asm_fc24d
	ld e, a
	ld a, [wdd8c]
	and e
	ld [wdd8c], a
	ld a, c
	rlca
	rlca
	add c
	ld e, a
	ld d, b
	ld hl, rAUD1ENV
	add hl, de
	ld a, $8
	ld [hli], a
	inc hl
	swap a
	ld [hl], a
	pop hl
	ret

Func_fc26c_2:
	xor a
	ld [wde53], a
	ld [wSfxPriority], a
	ld [wAudio_d005], a
	ret

INCLUDE "audio/sfx2_headers.asm"

SFX_WaveInstruments2:
INCLUDE "audio/wave_instruments.asm"

INCLUDE "audio/sfx/sfx_unused.asm"

INCLUDE "audio/sfx/sfx_fireball.asm"
INCLUDE "audio/sfx/sfx_continuous_fireball.asm"
INCLUDE "audio/sfx/sfx_bench_manipulation.asm"
INCLUDE "audio/sfx/sfx_psychic_beam.asm"
INCLUDE "audio/sfx/sfx_psychic_beam_bench.asm"
INCLUDE "audio/sfx/sfx_boulder_smash.asm"
INCLUDE "audio/sfx/sfx_mega_punch.asm"
INCLUDE "audio/sfx/sfx_psypunch.asm"
INCLUDE "audio/sfx/sfx_sludge_punch.asm"
INCLUDE "audio/sfx/sfx_ice_punch.asm"
INCLUDE "audio/sfx/sfx_kick.asm"
INCLUDE "audio/sfx/sfx_tail_slap.asm"
INCLUDE "audio/sfx/sfx_tail_whip.asm"
INCLUDE "audio/sfx/sfx_slap.asm"
INCLUDE "audio/sfx/sfx_question_mark_bench.asm"
INCLUDE "audio/sfx/sfx_skull_bash.asm"
INCLUDE "audio/sfx/sfx_coin_hurl.asm"
INCLUDE "audio/sfx/sfx_teleport.asm"
INCLUDE "audio/sfx/sfx_follow_me.asm"
INCLUDE "audio/sfx/sfx_swift.asm"
INCLUDE "audio/sfx/sfx_3d_attack.asm"
INCLUDE "audio/sfx/sfx_dry_up.asm"
INCLUDE "audio/sfx/sfx_focus_blast.asm"
INCLUDE "audio/sfx/sfx_focus_blast_bench.asm"
INCLUDE "audio/sfx/sfx_chips_counting.asm"
INCLUDE "audio/sfx/sfx_slot_start.asm"
INCLUDE "audio/sfx/sfx_slot_reel.asm"
INCLUDE "audio/sfx/sfx_black_box_insert.asm"
INCLUDE "audio/sfx/sfx_black_box_inserted.asm"
INCLUDE "audio/sfx/sfx_black_box_transmitted.asm"
INCLUDE "audio/sfx/sfx_new_mail.asm"
INCLUDE "audio/sfx/sfx_pod_doors.asm"
INCLUDE "audio/sfx/sfx_pitfall.asm"
INCLUDE "audio/sfx/sfx_open_chest.asm"
INCLUDE "audio/sfx/sfx_npc_warp_transform.asm"
INCLUDE "audio/sfx/sfx_stronghold_platform_up.asm"
INCLUDE "audio/sfx/sfx_stronghold_platform_down.asm"
INCLUDE "audio/sfx/sfx_gr_blimp_hatch_close.asm"
INCLUDE "audio/sfx/sfx_gr_blimp_hatch_open.asm"
INCLUDE "audio/sfx/sfx_gr_blimp_beam.asm"
INCLUDE "audio/sfx/sfx_bone_toss_bench.asm"
INCLUDE "audio/sfx/sfx_coin_hurl_bench.asm"
INCLUDE "audio/sfx/sfx_big_snore.asm"
INCLUDE "audio/sfx/sfx_slot_big_hit.asm"
INCLUDE "audio/sfx/sfx_slot_bonus_hit.asm"
INCLUDE "audio/sfx/sfx_slot_small_hit.asm"
INCLUDE "audio/sfx/sfx_razor_leaf.asm"
INCLUDE "audio/sfx/sfx_guillotine.asm"
INCLUDE "audio/sfx/sfx_vine_pull.asm"
INCLUDE "audio/sfx/sfx_perplex.asm"
INCLUDE "audio/sfx/sfx_nine_tails.asm"
INCLUDE "audio/sfx/sfx_bone_headbutt.asm"
INCLUDE "audio/sfx/sfx_drill_dive.asm"
INCLUDE "audio/sfx/sfx_dark_song.asm"
INCLUDE "audio/sfx/sfx_tcg2_intro_orbs.asm"
INCLUDE "audio/sfx/sfx_tcg2_intro_title.asm"
INCLUDE "audio/sfx/sfx_tcg2_intro_subtitle.asm"
INCLUDE "audio/sfx/sfx_electronic_input.asm"
INCLUDE "audio/sfx/sfx_electronic_response.asm"
INCLUDE "audio/sfx/sfx_ghost_master_appear.asm"
INCLUDE "audio/sfx/sfx_ghost_master_disappear.asm"
