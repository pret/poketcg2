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
	dw .SceneSpecialRules      ; $00
	dw .SceneSlotMachine       ; $01
	dw .SceneBeginningPack     ; $02
	dw .SceneLegendaryPack     ; $03
	dw .SceneFossilPack        ; $04
	dw .ScenePsychicPack       ; $05
	dw .SceneFlyingPack        ; $06
	dw .SceneRocketPack        ; $07
	dw .SceneAmbitionPack      ; $08
	dw .ScenePresentPack       ; $09
	dw .SceneIntroBaseSet      ; $0A
	dw .SceneIntroJungle       ; $0B
	dw .SceneIntroFossil       ; $0C
	dw .SceneIntroTeamRocket   ; $0D
	dw .SceneTournamentTable   ; $0E
	dw .SceneCardPopMenu       ; $0F
	dw .SceneCardPop           ; $10
	dw .SceneCardPopError      ; $11
	dw .SceneLink              ; $12
	dw .SceneRareCardPop       ; $13
	dw .SceneRareCardPopError  ; $14
	dw .SceneBlackBox          ; $15
	dw .SceneTitleScreen1      ; $16
	dw .SceneTitleScreen2      ; $17
	dw .SceneTitleScreen3      ; $18
	dw .SceneTitleScreen4      ; $19
	dw .ScenePrinter1          ; $1A
	dw .ScenePrinter2          ; $1B
	dw .SceneFullMailbox       ; $1C
	dw .SceneGotMail           ; $1D
	dw .SceneMailbox           ; $1E
	dw .SceneDeckDiagnosis     ; $1F
	dw .SceneLinkIntro1        ; $20
	dw .SceneLinkIntro2        ; $21
	dw .SceneCoinTossResult1   ; $22
	dw .SceneCoinTossResult2   ; $23
	dw .SceneGBCOnlyDisclaimer ; $24

.SceneSpecialRules
	dw TILESET_SPECIAL_RULES
	dw PALETTE_178
	dw TILEMAP_22E
	db $ff, $ff ; end

.SceneSlotMachine
	dw TILESET_SLOTS_BG_ICONS
	dw PALETTE_16D
	dw TILEMAP_227
	db $ff, $ff ; end

.SceneBeginningPack
	dw TILESET_BEGINNING_PACK
	dw PALETTE_154
	dw TILEMAP_212

	db $00, $00 ; x, y
	dw TILESET_PACK_OAM
	dw $091 ; ?
	dw $158 ; ?
	dw PALETTE_160
	db $ff, $ff ; end

.SceneLegendaryPack
	dw TILESET_LEGENDARY_PACK
	dw PALETTE_155
	dw TILEMAP_213

	db $00, $00 ; x, y
	dw TILESET_PACK_OAM
	dw $091 ; ?
	dw $158 ; ?
	dw PALETTE_160
	db $ff, $ff ; end

.SceneFossilPack
	dw TILESET_FOSSIL_PACK
	dw PALETTE_156
	dw TILEMAP_214

	db $00, $00 ; x, y
	dw TILESET_PACK_OAM
	dw $091 ; ?
	dw $158 ; ?
	dw PALETTE_160
	db $ff, $ff ; end

.ScenePsychicPack
	dw TILESET_PSYCHIC_PACK
	dw PALETTE_157
	dw TILEMAP_215

	db $00, $00 ; x, y
	dw TILESET_PACK_OAM
	dw $091 ; ?
	dw $158 ; ?
	dw PALETTE_160
	db $ff, $ff ; end

.SceneFlyingPack
	dw TILESET_FLYING_PACK
	dw PALETTE_158
	dw TILEMAP_216

	db $00, $00 ; x, y
	dw TILESET_PACK_OAM
	dw $091 ; ?
	dw $158 ; ?
	dw PALETTE_160
	db $ff, $ff ; end

.SceneRocketPack
	dw TILESET_ROCKET_PACK
	dw PALETTE_159
	dw TILEMAP_217

	db $00, $00 ; x, y
	dw TILESET_PACK_OAM
	dw $091 ; ?
	dw $158 ; ?
	dw PALETTE_160
	db $ff, $ff ; end

.SceneAmbitionPack
	dw TILESET_AMBITION_PACK
	dw PALETTE_15A
	dw TILEMAP_218

	db $00, $00 ; x, y
	dw TILESET_PACK_OAM
	dw $091 ; ?
	dw $158 ; ?
	dw PALETTE_160
	db $ff, $ff ; end

.ScenePresentPack
	dw TILESET_PRESENT_PACK
	dw PALETTE_15B
	dw TILEMAP_219

	db $00, $00 ; x, y
	dw TILESET_PACK_OAM
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

.SceneTournamentTable
	dw TILESET_TOURNAMENT_TABLE
	dw PALETTE_16C
	dw TILEMAP_226
	db $ff, $ff ; end

.SceneCardPopMenu
	dw TILESET_CARD_POP_MENU
	dw PALETTE_170
	dw TILEMAP_22A

	db $00, $00 ; x, y
	dw TILESET_CARD_POP_MENU_OAM
	dw $0a3 ; ?
	dw $16b ; ?
	dw PALETTE_171
	db $ff, $ff ; end

.SceneCardPop
	dw TILESET_CARD_POP_SCENE
	dw PALETTE_172
	dw TILEMAP_22B

	db $50, $48 ; x, y
	dw TILESET_CARD_POP_OAM
	dw $0a5 ; ?
	dw $16d ; ?
	dw PALETTE_174
	db $ff, $ff ; end

.SceneCardPopError
	dw TILESET_CARD_POP_SCENE
	dw PALETTE_172
	dw TILEMAP_22B

	db $40, $30 ; x, y
	dw TILESET_LINK_CROSS
	dw $0a4 ; ?
	dw $16c ; ?
	dw PALETTE_173
	db $ff, $ff ; end

.SceneLink
	dw TILESET_LINK_SCENE
	dw PALETTE_175
	dw TILEMAP_22C
	db $ff, $ff ; end

.SceneRareCardPop
	dw TILESET_RARE_CARD_POP_SCENE
	dw PALETTE_176
	dw TILEMAP_22D

	db $50, $30 ; x, y
	dw TILESET_RARE_CARD_POP_OAM
	dw $0a6 ; ?
	dw $16e ; ?
	dw PALETTE_177
	db $ff, $ff ; end

.SceneRareCardPopError
	dw TILESET_RARE_CARD_POP_SCENE
	dw PALETTE_176
	dw TILEMAP_22D

	db $40, $30 ; x, y
	dw TILESET_LINK_CROSS
	dw $0a4 ; ?
	dw $16c ; ?
	dw PALETTE_173
	db $ff, $ff ; end

.ScenePrinter1
	dw TILESET_PRINTER_SCENE
	dw PALETTE_179
	dw TILEMAP_22F

	db $50, $48 ; x, y
	dw TILESET_PRINTER_OAM
	dw $0a7 ; ?
	dw $16f ; ?
	dw PALETTE_17A
	db $ff, $ff ; end

.ScenePrinter2
	dw TILESET_PRINTER_SCENE
	dw PALETTE_179
	dw TILEMAP_22F

	db $50, $40 ; x, y
	dw TILESET_PRINTER_OAM
	dw $0a7 ; ?
	dw $170 ; ?
	dw PALETTE_17A
	db $ff, $ff ; end

.SceneBlackBox
	dw TILESET_BLACK_BOX_BG
	dw PALETTE_138
	dw TILEMAP_225
	db $ff, $ff ; end

.SceneTitleScreen1
	dw TILESET_TITLE_SCREEN
	dw PALETTE_167
	dw TILEMAP_21E
	db $ff, $ff ; end

.SceneTitleScreen2
	dw TILESET_TITLE_SCREEN
	dw PALETTE_167
	dw TILEMAP_21F
	db $ff, $ff ; end

.SceneTitleScreen3
	dw TILESET_TITLE_SCREEN
	dw PALETTE_167
	dw TILEMAP_220
	db $ff, $ff ; end

.SceneTitleScreen4
	dw TILESET_TITLE_SCREEN
	dw PALETTE_167
	dw TILEMAP_221
	db $ff, $ff ; end

.SceneFullMailbox
	dw TILESET_FULL_MAILBOX
	dw PALETTE_17B
	dw TILEMAP_230

	db $28, $20 ; x, y
	dw TILESET_MAIL_CROSS
	dw $0a8 ; ?
	dw $171 ; ?
	dw PALETTE_17C
	db $ff, $ff ; end

.SceneGotMail
	dw TILESET_MAILBOX
	dw PALETTE_17D
	dw TILEMAP_231

	db $28, $20 ; x, y
	dw TILESET_GOT_MAIL_ANIM
	dw $0a9 ; ?
	dw $172 ; ?
	dw PALETTE_17E
	db $ff, $ff ; end

.SceneMailbox
	dw TILESET_MAILBOX_COPY
	dw PALETTE_17F
	dw TILEMAP_232
	db $ff, $ff ; end

.SceneDeckDiagnosis
	dw TILESET_DECK_DIAGNOSIS
	dw PALETTE_181
	dw TILEMAP_233
	db $ff, $ff ; end

.SceneLinkIntro1
	dw TILESET_LINK_SCENE_INTRO
	dw PALETTE_182
	dw TILEMAP_234

	db $50, $4c ; x, y
	dw TILESET_LINK_OAM
	dw $0ab ; ?
	dw $174 ; ?
	dw PALETTE_183
	db $ff, $ff ; end

.SceneLinkIntro2
	dw TILESET_LINK_SCENE_INTRO
	dw PALETTE_182
	dw TILEMAP_234

	db $50, $48 ; x, y
	dw TILESET_LINK_OAM
	dw $0ab ; ?
	dw $175 ; ?
	dw PALETTE_183
	db $ff, $ff ; end

.SceneCoinTossResult1
	dw TILESET_COIN_TOSS_RESULT
	dw PALETTE_184
	dw TILEMAP_235
	db $ff, $ff ; end

.SceneCoinTossResult2
	dw TILESET_COIN_TOSS_RESULT
	dw PALETTE_184
	dw TILEMAP_236
	db $ff, $ff ; end

.SceneGBCOnlyDisclaimer
	dw TILESET_GB_ERROR
	dw PALETTE_169
	dw TILEMAP_223
	db $ff, $ff ; end
