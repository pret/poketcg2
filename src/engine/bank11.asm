SECTION "Bank 11@4039", ROMX[$4039], BANK[$11]

; counts number of cards in
; $0000 terminated list in hl
; ouptut:
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
; 0x44943

SECTION "Bank 11@4954", ROMX[$4954], BANK[$11]

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

SECTION "Credits", ROMX[$5c6e], BANK[$11]
INCLUDE "engine/credits.asm"
