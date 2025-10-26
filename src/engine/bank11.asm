SECTION "Bank 11@4039", ROMX[$4039], BANK[$11]

; counts number of cards in
; $0000 terminated list in hl
; output:
;  a = number of cards
CountCardsInHL:
	push bc
	push hl
	xor a
	ld c, a
.loop
	ld a, [hli]
	ld b, a
	ld a, [hli]
	or b
	jr z, .asm_44046
	inc c
	jr .loop
.asm_44046
	ld a, c
	pop hl
	pop bc
	ret

; input:
;  hl = card list
;  de = card ID to search for
; output:
;  carry set if not found
;  a = index in list if found
SearchCardInListInHL:
	push bc
	push de
	push hl
	xor a
.loop_cards
	push af
	ld a, [hli]
	ld c, a
	ld a, [hli]
	ld b, a
	or c
	jr z, .not_found
	ld a, d
	cp b
	jr c, .not_equal
	jr nz, .not_equal
	ld a, e
	cp c
.not_equal
	jr z, .found
	pop af
	inc a
	jr .loop_cards
.not_found
	pop af
	xor a
	scf
	jr .done
.found
	pop af
	scf
	ccf
.done
	pop hl
	pop de
	pop bc
	ret
; 0x44070

SECTION "Bank 11@426a", ROMX[$426a], BANK[$11]

; appends card ID in de to list in hl
AppendCardToListInHL:
	push af
	push bc
	push hl
.loop_cards
	ld a, [hli]
	ld c, a
	ld a, [hli]
	ld b, a
	or c
	jr nz, .loop_cards
	inc hl
	xor a
	ld [hld], a ; terminating byte
	ld [hld], a ;
	ld a, d
	ld [hld], a ; card ID
	ld [hl], e  ;
	pop hl
	pop bc
	pop af
	ret
; 0x4427f

SECTION "Bank 11@43d4", ROMX[$43d4], BANK[$11]

; filters card list in hl
; based on rarity in c and value in b:
;    $0: only pkmn
;    $1: only trainers
;  > $1: only energy
; input:
;  b = filter option
;  c = card rarity
; output:
;  wDuelTempList = filtered list
;  a = number of cards in filtered list
FilterCardListInHL:
	push bc
	push de
	push hl
	xor a
	push af
	ld a, LOW(wDuelTempList)
	ld [wFilteredListPtr + 0], a
	ld a, HIGH(wDuelTempList)
	ld [wFilteredListPtr + 1], a
.loop_cards
	ld a, [hli]
	ld e, a
	ld a, [hli]
	ld d, a
	or e
	jr z, .done
	call LoadCardDataToBuffer1_FromCardID
	ld a, [wLoadedCard1Rarity]
	cp c
	jr nz, .loop_cards
	ld a, b
	cp $01
	jr z, .only_trainers
	jr nc, .only_energy
; only pkmn
	ld a, [wLoadedCard1Type]
	cp TYPE_ENERGY
	jr nc, .loop_cards
	jr .append_card
.only_trainers
	ld a, [wLoadedCard1Type]
	cp TYPE_TRAINER
	jr nz, .loop_cards
	jr .append_card
.only_energy
	ld a, [wLoadedCard1Type]
	cp TYPE_ENERGY
	jr c, .loop_cards
	cp TYPE_TRAINER
	jr z, .loop_cards
	jr .append_card

.append_card
; writes this card ID to the next entry in the list
	push hl
	ld a, [wFilteredListPtr + 0]
	ld l, a
	ld a, [wFilteredListPtr + 1]
	ld h, a
	ld a, e
	ld [hli], a
	ld a, d
	ld [hli], a
	ld a, l
	ld [wFilteredListPtr + 0], a
	ld a, h
	ld [wFilteredListPtr + 1], a
	pop hl
	pop af
	inc a
	push af
	jr .loop_cards

.done
; add terminating bytes
	ld a, [wFilteredListPtr + 0]
	ld l, a
	ld a, [wFilteredListPtr + 1]
	ld h, a
	xor a
	ld [hli], a
	ld [hl], a
	pop af
	pop hl
	pop de
	pop bc
	ret

; shuffle card list in hl by running
; random card swapping algorithm 40 times
ShuffleCardsInHL:
	push af
	push bc
	push de
	push hl
	call CountCardsInHL
	or a
	jr z, .done ; no cards in list
	ld b, a
	ld c, 40

.loop
	push bc
	push hl
	ld e, l
	ld d, h

; pick 2 random cards from list
; then swap them
	ld a, b
	call Random
	sla a
	add l
	ld l, a
	jr nc, .no_carry1
	inc h
.no_carry1
	ld a, b
	call Random
	sla a
	add e
	ld e, a
	jr nc, .no_carry2
	inc d
.no_carry2
	ld b, [hl]
	ld a, [de]
	ld [hl], a
	ld a, b
	ld [de], a
	inc hl
	inc de
	ld b, [hl]
	ld a, [de]
	ld [hl], a
	ld a, b
	ld [de], a
	pop hl
	pop bc
	dec c
	jr nz, .loop

.done
	pop hl
	pop de
	pop bc
	pop af
	ret
; 0x44481

SECTION "Bank 11@44bd", ROMX[$44bd], BANK[$11]

_ChooseTitleScreenCards:
	push af
	push bc
	push de
	push hl
	push hl
	xor a
	ld [hli], a
	ld [hld], a
	xor a ; unnecessary
	ld [wIntroCardsRepeatsAllowed], a

	call EnableSRAM
	ld hl, sDeck1Name
	ld c, $05
.loop_decks
	ld a, [hli]
	ld e, a
	ld a, [hld]
	or e
	jr nz, .got_deck
	ld de, DECK_COMPRESSED_STRUCT_SIZE
	add hl, de
	dec c
	jr nz, .loop_decks

; no decks in memory,
; use the default cards
	call DisableSRAM
	ld hl, .DefaultIntroCards
	pop de
	ld bc, 2 * 9
	call CopyDataHLtoDE_SaveRegisters
	jp .done

.got_deck
	call DisableSRAM

	bank1call LoadPlayerDeck
	xor a
	ld [wPlayerDeck + $78], a ; terminating bytes
	ld [wPlayerDeck + $79], a ; for wPlayerDeck
	pop hl

	ld a, NUM_TITLE_SCREEN_CARDS
	ld [wRemainingIntroCards], a
.star_pkmn
	push hl
	ld hl, wPlayerDeck
	lb bc, $0, STAR
	call FilterCardListInHL
	pop hl
	ld b, a
	or a
	jr z, .diamond_pkmn
	ld c, $00
	call .AppendCards
.diamond_pkmn
	push hl
	ld hl, wPlayerDeck
	lb bc, $0, DIAMOND
	call FilterCardListInHL
	pop hl
	ld b, a
	or a
	jr z, .circle_pkmn
	ld c, $00
	call .AppendCards
.circle_pkmn
	push hl
	ld hl, wPlayerDeck
	lb bc, $0, CIRCLE
	call FilterCardListInHL
	pop hl
	ld b, a
	or a
	jr z, .star_trainers
	ld c, $00
	call .AppendCards
.star_trainers
	push hl
	ld hl, wPlayerDeck
	lb bc, $1, STAR
	call FilterCardListInHL
	pop hl
	ld b, a
	or a
	jr z, .diamond_trainers
	ld c, $00
	call .AppendCards
.diamond_trainers
	push hl
	ld hl, wPlayerDeck
	lb bc, $1, DIAMOND
	call FilterCardListInHL
	pop hl
	ld b, a
	or a
	jr z, .circle_trainers
	ld c, $00
	call .AppendCards
.circle_trainers
	push hl
	ld hl, wPlayerDeck
	lb bc, $1, CIRCLE
	call FilterCardListInHL
	pop hl
	ld b, a
	or a
	jr z, .star_energy
	ld c, $00
	call ShuffleCardsInHL
	call .AppendCards
.star_energy
	push hl
	ld hl, wPlayerDeck
	lb bc, $2, STAR
	call FilterCardListInHL
	pop hl
	ld b, a
	or a
	jr z, .diamond_energy
	ld c, $00
	call .AppendCards
.diamond_energy
	push hl
	ld hl, wPlayerDeck
	lb bc, $2, DIAMOND
	call FilterCardListInHL
	pop hl
	ld b, a
	or a
	jr z, .circle_energy
	ld c, $00
	call .AppendCards
.circle_energy
	push hl
	ld hl, wPlayerDeck
	lb bc, $2, CIRCLE
	call FilterCardListInHL
	pop hl
	ld b, a
	or a
	jr z, .allow_duplicates
	ld c, $00
	call .AppendCards
.allow_duplicates
	ld a, TRUE
	ld [wIntroCardsRepeatsAllowed], a
	ld a, [wRemainingIntroCards]
	or a
	jp nz, .star_pkmn
.done
	pop hl
	pop de
	pop bc
	pop af
	ret

.AppendCards:
	; shuffle card list
	push hl
	ld hl, wDuelTempList
	call ShuffleCardsInHL
	pop hl

.loop_cards
	push hl
	ld hl, wDuelTempList
	ld a, c
	sla a
	add l
	ld l, a
	jr nc, .no_carry
	inc h
.no_carry
	ld a, [hli]
	ld e, a
	ld d, [hl]
	pop hl
	call .TryAppend
	inc c
	ld a, c
	cp b
	jr nz, .loop_cards
	ret

.TryAppend:
; appends if wIntroCardsRepeatsAllowed != 0
; or otherwise, if card is not in list already
	ld a, [wRemainingIntroCards]
	or a
	ret z
	ld a, [wIntroCardsRepeatsAllowed]
	or a
	jr nz, .append
	call SearchCardInListInHL
	jr c, .append
	ret
.append
	call AppendCardToListInHL
	ld a, [wRemainingIntroCards]
	dec a
	ld [wRemainingIntroCards], a
	ret

.DefaultIntroCards:
	dw BULBASAUR_LV12
	dw CHARMANDER_LV9
	dw SQUIRTLE_LV16
	dw PIKACHU_LV13
	dw DARK_MACHOKE
	dw MEW_LV23
	dw MEOWTH_LV13
	dw HERE_COMES_TEAM_ROCKET
	dw $0000

MACRO blackbox_promo
	dw \1 ; recipe
	db \2 ; post-game flag
	dw \3 ; output
ENDM

BlackboxPromoCards:
	blackbox_promo .dugtrio_lv40, FALSE, DUGTRIO_LV40
	blackbox_promo .mankey_alt_lv7, TRUE, MANKEY_ALT_LV7
	blackbox_promo .diglett_lv16, TRUE, DIGLETT_LV16
	blackbox_promo .moltres_lv40, FALSE, MOLTRES_LV40
	blackbox_promo .arcanine_lv34, TRUE, ARCANINE_LV34
	blackbox_promo .nonpromo_charizard_lv76, FALSE, CHARIZARD_LV76 ; bug, should be CHARIZARD_ALT_LV76
	blackbox_promo .pikachu_lv13, TRUE, PIKACHU_LV13
	blackbox_promo .pikachu_lv16, FALSE, PIKACHU_LV16
	blackbox_promo .zapdos_lv68, FALSE, ZAPDOS_LV68
	blackbox_promo .pikachu_alt_lv16, FALSE, PIKACHU_ALT_LV16
	blackbox_promo .electabuzz_lv20, TRUE, ELECTABUZZ_LV20
	blackbox_promo .articuno_lv37, FALSE, ARTICUNO_LV37
	blackbox_promo .magikarp_lv10, TRUE, MAGIKARP_LV10
	blackbox_promo .blastoise_alt_lv52, FALSE, BLASTOISE_ALT_LV52
	blackbox_promo .venusaur_alt_lv67, FALSE, VENUSAUR_ALT_LV67
	blackbox_promo .grs_mewtwo, TRUE, GRS_MEWTWO
	blackbox_promo .mewtwo_alt_lv60, FALSE, MEWTWO_ALT_LV60
	blackbox_promo .mewtwo_lv60, FALSE, MEWTWO_LV60
	blackbox_promo .mewtwo_lv30, TRUE, MEWTWO_LV30
	blackbox_promo .slowpoke_lv9, TRUE, SLOWPOKE_LV9
	blackbox_promo .super_energy_retrieval, TRUE, SUPER_ENERGY_RETRIEVAL
	blackbox_promo .dark_persian_alt_lv28, TRUE, DARK_PERSIAN_ALT_LV28
	blackbox_promo .jigglypuff_lv12, FALSE, JIGGLYPUFF_LV12
	blackbox_promo .kangaskhan_lv38, FALSE, KANGASKHAN_LV38
	blackbox_promo .farfetchd_alt_lv20, TRUE, FARFETCHD_ALT_LV20
	blackbox_promo .dragonite_lv41, FALSE, DRAGONITE_LV41
	blackbox_promo .nonpromo_dragonite_lv45, TRUE, DRAGONITE_LV45 ; bug, should be DRAGONITE_LV43, though listed in .OtherPromoCards instead
	blackbox_promo .meowth_lv14, FALSE, MEOWTH_LV14
	blackbox_promo .hungry_snorlax, TRUE, HUNGRY_SNORLAX
	blackbox_promo .cool_porygon, TRUE, COOL_PORYGON
	dw 0 ; end

.dugtrio_lv40
	dw DUGTRIO_LV36, HITMONLEE_LV30, HITMONCHAN_LV23
	dw 0
.mankey_alt_lv7
	dw HITMONLEE_LV30, HITMONCHAN_LV23
	dw 0
.diglett_lv16
	dw DUGTRIO_LV36, DARK_DUGTRIO
	dw 0
.moltres_lv40
	dw NINETALES_LV32, DARK_NINETALES, MOLTRES_LV35
	dw 0
.arcanine_lv34
	dw NINETALES_LV32, ARCANINE_LV45
	dw 0
.nonpromo_charizard_lv76
	dw DARK_CHARIZARD, DARK_NINETALES
	dw 0
.pikachu_lv13
	dw RAICHU_LV40, RAICHU_LV45, RAICHU_LV32, DARK_RAICHU
	dw 0
.pikachu_lv16
	dw RAICHU_LV40, RAICHU_LV45, RAICHU_LV32
	dw 0
.zapdos_lv68
	dw RAICHU_LV40, DARK_RAICHU, ZAPDOS_LV64
	dw 0
.pikachu_alt_lv16
	dw ELECTRODE_LV35, ELECTRODE_LV42, MAGNETON_LV28, MAGNETON_LV35
	dw 0
.electabuzz_lv20
	dw ELECTABUZZ_LV35, MAGNETON_LV30, MAGNETON_LV28, MAGNETON_LV35
	dw 0
.articuno_lv37
	dw POLIWRATH_LV40, KINGLER_LV33, ARTICUNO_LV35
	dw 0
.magikarp_lv10
	dw GYARADOS, DARK_GYARADOS
	dw 0
.blastoise_alt_lv52
	dw DARK_BLASTOISE, DARK_GYARADOS
	dw 0
.venusaur_alt_lv67
	dw DARK_VILEPLUME, DARK_VENUSAUR
	dw 0
.grs_mewtwo
	dw MEW_LV23, MEWTWO_LV53, MEWTWO_LV67
	dw 0
.mewtwo_alt_lv60
	dw MEW_LV23, MEWTWO_LV67
	dw 0
.mewtwo_lv60
	dw MEW_LV23, MEWTWO_LV53
	dw 0
.mewtwo_lv30
	dw MEWTWO_LV53, MEWTWO_LV67
	dw 0
.slowpoke_lv9
	dw ALAKAZAM_LV42, GENGAR_LV38, MR_MIME_LV28
	dw 0
.super_energy_retrieval
	dw POLIWRATH_LV40, DRAGONAIR
	dw 0
.dark_persian_alt_lv28
	dw CHANSEY_LV55, CLEFABLE, WIGGLYTUFF_LV36
	dw 0
.jigglypuff_lv12
	dw CHANSEY_LV55, CLEFAIRY_LV14
	dw 0
.kangaskhan_lv38
	dw KANGASKHAN_LV40, DRAGONAIR
	dw 0
.farfetchd_alt_lv20
	dw PIDGEOT_LV38, CLEFAIRY_LV14, DITTO
	dw 0
.dragonite_lv41
	dw DRAGONITE_LV45, DARK_DRAGONITE, DRAGONAIR
	dw 0
.nonpromo_dragonite_lv45
	dw DRAGONITE_LV45, DARK_DRAGONITE, DRAGONITE_LV41
	dw 0
.meowth_lv14
	dw DITTO, SNORLAX_LV20
	dw 0
.hungry_snorlax
	dw SNORLAX_LV20, SNORLAX_LV35
	dw 0
.cool_porygon
	dw DITTO, CLEFABLE
	dw 0

.OtherPromoCards:
	dw VENUSAUR_LV64
	dw MARILL
	dw OMASTAR_LV36
	dw GOLEM_LV37
	dw MACHAMP_LV54
	dw ALAKAZAM_LV45
	dw GENGAR_LV40
	dw MEWTWO_LV30 ; weird, also in BlackboxPromoCards
	dw MEW_LV15
	dw MEW_LV8
	dw SURFING_PIKACHU_LV13
	dw SURFING_PIKACHU_ALT_LV13
	dw FLYING_PIKACHU_LV12
	dw FLYING_PIKACHU_ALT_LV12
	dw DRAGONITE_LV43 ; weird if BlackboxPromoCards weren't bugged
	dw TOGEPI
	dw LUGIA
	dw HERE_COMES_TEAM_ROCKET
	dw IMAKUNI_CARD
	dw COMPUTER_ERROR
	dw 0

SECTION "Bank 11@4928", ROMX[$4928], BANK[$11]

; a = MUSIC_*
PlayAfterCurrentSong:
	ld b, a
	ld a, [wCurMusic]
	cp b
	jr nz, .play_song
	push bc
	call AssertSongFinished
	pop bc
	or a
	jr z, .play_song
	ret

.play_song
	ld a, b
	ld [wCurMusic], a
	ld [wdd04], a
	call PlaySong
	ret

PlayCurrentSong:
	ld a, [wCurMusic]
	call PlaySong
	ret

; WaitForSongToFinish but without push/pop af
WaitSong:
.loop
	call DoFrame
	call AssertSongFinished
	or a
	jr nz, .loop
	ret

InitMusicFadeOut:
	ld [wMusicFadeOutCounter], a
	ld [wMusicFadeOutDuration], a
	ld a, c
	ld [wMusicFadeOutVolume], a
	call SetVolume
	ret

TickMusicFadeOut:
	ld a, [wMusicFadeOutCounter]
	dec a
	ld [wMusicFadeOutCounter], a
	jr nz, .done
	ld a, [wMusicFadeOutDuration]
	ld [wMusicFadeOutCounter], a
	ld a, [wMusicFadeOutVolume]
	or a
	jr z, .done
	dec a
	ld [wMusicFadeOutVolume], a
	call SetVolume
.done
	ret

MusicFadeOut:
.loop
	call DoFrame
	call TickMusicFadeOut
	ld a, [wMusicFadeOutVolume]
	or a
	jr nz, .loop
	ret
; 0x4498c

SECTION "Bank 11@499e", ROMX[$499e], BANK[$11]

WaitForSFXToFinish::
.loop_wait
	call DoFrame
	call AssertSFXFinished
	or a
	jr nz, .loop_wait
	ret

SECTION "Bank 11@569f", ROMX[$569f], BANK[$11]

Func_4569f:
; TODO - ran into problems while disassembling this big chain of functions

SECTION "Credits", ROMX[$5c6e], BANK[$11]
INCLUDE "engine/credits.asm"
