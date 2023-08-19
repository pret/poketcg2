_LoadScene::
	push af
	push bc
	push de
	push hl
	push bc ; unnecessary push/pop
	add a ; *2
	ld e, a
	ld d, $00
	ld hl, SceneDataPointers
	add hl, de
	pop bc ; unnecessary push/pop
	ld d, b
	ld e, c
	ld b, $4
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld c, $02
	call LoadBGGraphics
	ld a, d
	add a
	add a
	add a ; *8
	add $08
	ld d, a ; base x
	ld a, e
	add a
	add a
	add a ; *8
	add $10
	ld e, a ; base y
	; d = 8*d + $08
	; e = 8*e + $10
.loop
	ld a, [hl]
	cp $ff
	jr z, .done
	push de
	ld a, [hli]
	add d
	ld d, a
	ld a, [hli]
	add e
	ld e, a
	ld b, BANK(SceneDataPointers)
	ld a, $ff
	ld c, 0
	call CreateSpriteAnim
	pop de
	jr .loop
.done
	pop hl
	pop de
	pop bc
	pop af
	ret

SceneDataPointers:
	dw .Scene00 ; SCENE_00
	dw .Scene01 ; SCENE_01
	dw .Scene02 ; SCENE_02
	dw .Scene03 ; SCENE_03
	dw .Scene04 ; SCENE_04
	dw .Scene05 ; SCENE_05
	dw .Scene06 ; SCENE_06
	dw .Scene07 ; SCENE_07
	dw .Scene08 ; SCENE_08
	dw .Scene09 ; SCENE_09
	dw .SceneIntroBaseSet ; SCENE_INTRO_BASE_SET
	dw .SceneIntroJungle ; SCENE_INTRO_JUNGLE
	dw .SceneIntroFossil ; SCENE_INTRO_FOSSIL
	dw .SceneIntroTeamRocket ; SCENE_INTRO_TEAM_ROCKET
	dw .Scene0e ; SCENE_0E
	dw .Scene0f ; SCENE_0F
	dw .Scene10 ; SCENE_10
	dw .Scene11 ; SCENE_11
	dw .Scene12 ; SCENE_12
	dw .Scene13 ; SCENE_13
	dw .Scene14 ; SCENE_14
	dw .Scene15 ; SCENE_15
	dw .Scene16 ; SCENE_16
	dw .Scene17 ; SCENE_17
	dw .Scene18 ; SCENE_18
	dw .Scene19 ; SCENE_19
	dw .Scene1a ; SCENE_1A
	dw .Scene1b ; SCENE_1B
	dw .Scene1c ; SCENE_1C
	dw .Scene1d ; SCENE_1D
	dw .Scene1e ; SCENE_1E
	dw .Scene1f ; SCENE_1F
	dw .Scene20 ; SCENE_20
	dw .Scene21 ; SCENE_21
	dw .Scene22 ; SCENE_22
	dw .Scene23 ; SCENE_23
	dw .SceneGBCOnlyDisclaimer ; SCENE_GBC_ONLY_DISCLAIMER

.Scene00
	dw TILESET_1E1
	dw PALETTE_178
	dw TILEMAP_22E
	db $ff, $ff ; end

.Scene01
	dw TILESET_1D6
	dw PALETTE_16D
	dw TILEMAP_227
	db $ff, $ff ; end

.Scene02
	dw TILESET_1C0
	dw PALETTE_154
	dw TILEMAP_212

	db $00, $00 ; x, y
	dw TILESET_1CC
	dw $091 ; ?
	dw $158 ; ?
	dw PALETTE_160
	db $ff, $ff ; end

.Scene03
	dw TILESET_1C1
	dw PALETTE_155
	dw TILEMAP_213

	db $00, $00 ; x, y
	dw TILESET_1CC
	dw $091 ; ?
	dw $158 ; ?
	dw PALETTE_160
	db $ff, $ff ; end

.Scene04
	dw TILESET_1C2
	dw PALETTE_156
	dw TILEMAP_214

	db $00, $00 ; x, y
	dw TILESET_1CC
	dw $091 ; ?
	dw $158 ; ?
	dw PALETTE_160
	db $ff, $ff ; end

.Scene05
	dw TILESET_1C3
	dw PALETTE_157
	dw TILEMAP_215

	db $00, $00 ; x, y
	dw TILESET_1CC
	dw $091 ; ?
	dw $158 ; ?
	dw PALETTE_160
	db $ff, $ff ; end

.Scene06
	dw TILESET_1C4
	dw PALETTE_158
	dw TILEMAP_216

	db $00, $00 ; x, y
	dw TILESET_1CC
	dw $091 ; ?
	dw $158 ; ?
	dw PALETTE_160
	db $ff, $ff ; end

.Scene07
	dw TILESET_1C5
	dw PALETTE_159
	dw TILEMAP_217

	db $00, $00 ; x, y
	dw TILESET_1CC
	dw $091 ; ?
	dw $158 ; ?
	dw PALETTE_160
	db $ff, $ff ; end

.Scene08
	dw TILESET_1C6
	dw PALETTE_15A
	dw TILEMAP_218

	db $00, $00 ; x, y
	dw TILESET_1CC
	dw $091 ; ?
	dw $158 ; ?
	dw PALETTE_160
	db $ff, $ff ; end

.Scene09
	dw TILESET_1C7
	dw PALETTE_15B
	dw TILEMAP_219

	db $00, $00 ; x, y
	dw TILESET_1CC
	dw $091 ; ?
	dw $158 ; ?
	dw PALETTE_160
	db $ff, $ff ; end

.SceneIntroBaseSet
	dw TILESET_INTRO_BASE_SET
	dw PALETTE_15C
	dw TILEMAP_21A
	db $ff, $ff ; end

.SceneIntroJungle
	dw TILESET_INTRO_JUNGLE
	dw PALETTE_15D
	dw TILEMAP_21B
	db $ff, $ff ; end

.SceneIntroFossil
	dw TILESET_INTRO_FOSSIL
	dw PALETTE_15E
	dw TILEMAP_21C
	db $ff, $ff ; end

.SceneIntroTeamRocket
	dw TILESET_INTRO_TEAM_ROCKET
	dw PALETTE_15F
	dw TILEMAP_21D
	db $ff, $ff ; end

.Scene0e
	dw TILESET_1D5
	dw PALETTE_16C
	dw TILEMAP_226
	db $ff, $ff ; end

.Scene0f
	dw TILESET_1D9
	dw PALETTE_170
	dw TILEMAP_22A

	db $00, $00 ; x, y
	dw TILESET_1DA
	dw $0a3 ; ?
	dw $16b ; ?
	dw PALETTE_171
	db $ff, $ff ; end

.Scene10
	dw TILESET_1DB
	dw PALETTE_172
	dw TILEMAP_22B

	db $50, $48 ; x, y
	dw TILESET_1DD
	dw $0a5 ; ?
	dw $16d ; ?
	dw PALETTE_174
	db $ff, $ff ; end

.Scene11
	dw TILESET_1DB
	dw PALETTE_172
	dw TILEMAP_22B

	db $40, $30 ; x, y
	dw TILESET_1DC
	dw $0a4 ; ?
	dw $16c ; ?
	dw PALETTE_173
	db $ff, $ff ; end

.Scene12
	dw TILESET_1DE
	dw PALETTE_175
	dw TILEMAP_22C
	db $ff, $ff ; end

.Scene13
	dw TILESET_1DF
	dw PALETTE_176
	dw TILEMAP_22D

	db $50, $30 ; x, y
	dw TILESET_1E0
	dw $0a6 ; ?
	dw $16e ; ?
	dw PALETTE_177
	db $ff, $ff ; end

.Scene14
	dw TILESET_1DF
	dw PALETTE_176
	dw TILEMAP_22D

	db $40, $30 ; x, y
	dw TILESET_1DC
	dw $0a4 ; ?
	dw $16c ; ?
	dw PALETTE_173
	db $ff, $ff ; end

.Scene1a
	dw TILESET_1E2
	dw PALETTE_179
	dw TILEMAP_22F

	db $50, $48 ; x, y
	dw TILESET_1E3
	dw $0a7 ; ?
	dw $16f ; ?
	dw PALETTE_17A
	db $ff, $ff ; end

.Scene1b
	dw TILESET_1E2
	dw PALETTE_179
	dw TILEMAP_22F

	db $50, $40 ; x, y
	dw TILESET_1E3
	dw $0a7 ; ?
	dw $170 ; ?
	dw PALETTE_17A
	db $ff, $ff ; end

.Scene15
	dw TILESET_1D1
	dw PALETTE_138
	dw TILEMAP_225
	db $ff, $ff ; end

.Scene16
	dw TILESET_TITLE_SCREEN
	dw PALETTE_167
	dw TILEMAP_21E
	db $ff, $ff ; end

.Scene17
	dw TILESET_TITLE_SCREEN
	dw PALETTE_167
	dw TILEMAP_21F
	db $ff, $ff ; end

.Scene18
	dw TILESET_TITLE_SCREEN
	dw PALETTE_167
	dw TILEMAP_220
	db $ff, $ff ; end

.Scene19
	dw TILESET_TITLE_SCREEN
	dw PALETTE_167
	dw TILEMAP_221
	db $ff, $ff ; end

.Scene1c
	dw TILESET_1E4
	dw PALETTE_17B
	dw TILEMAP_230

	db $28, $20 ; x, y
	dw TILESET_1E5
	dw $0a8 ; ?
	dw $171 ; ?
	dw PALETTE_17C
	db $ff, $ff ; end

.Scene1d
	dw TILESET_1E6
	dw PALETTE_17D
	dw TILEMAP_231

	db $28, $20 ; x, y
	dw TILESET_1E7
	dw $0a9 ; ?
	dw $172 ; ?
	dw PALETTE_17E
	db $ff, $ff ; end

.Scene1e
	dw TILESET_1E8
	dw PALETTE_17F
	dw TILEMAP_232
	db $ff, $ff ; end

.Scene1f
	dw TILESET_1EA
	dw PALETTE_181
	dw TILEMAP_233
	db $ff, $ff ; end

.Scene20
	dw TILESET_1EB
	dw PALETTE_182
	dw TILEMAP_234

	db $50, $4c ; x, y
	dw TILESET_1EC
	dw $0ab ; ?
	dw $174 ; ?
	dw PALETTE_183
	db $ff, $ff ; end

.Scene21
	dw TILESET_1EB
	dw PALETTE_182
	dw TILEMAP_234

	db $50, $48 ; x, y
	dw TILESET_1EC
	dw $0ab ; ?
	dw $175 ; ?
	dw PALETTE_183
	db $ff, $ff ; end

.Scene22
	dw TILESET_1ED
	dw PALETTE_184
	dw TILEMAP_235
	db $ff, $ff ; end

.Scene23
	dw TILESET_1ED
	dw PALETTE_184
	dw TILEMAP_236
	db $ff, $ff ; end

.SceneGBCOnlyDisclaimer
	dw TILESET_1CF
	dw PALETTE_169
	dw TILEMAP_223
	db $ff, $ff ; end
