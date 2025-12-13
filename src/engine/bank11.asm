INCLUDE "engine/card_list_ops.asm"

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
	ld hl, sDeck1
	ld c, NUM_DECKS + 1
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
	lb bc, FILTER_ONLY_PKMN, STAR
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
	lb bc, FILTER_ONLY_PKMN, DIAMOND
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
	lb bc, FILTER_ONLY_PKMN, CIRCLE
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
	lb bc, FILTER_ONLY_TRAINER, STAR
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
	lb bc, FILTER_ONLY_TRAINER, DIAMOND
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
	lb bc, FILTER_ONLY_TRAINER, CIRCLE
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
	lb bc, FILTER_ONLY_ENERGY, STAR
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
	lb bc, FILTER_ONLY_ENERGY, DIAMOND
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
	lb bc, FILTER_ONLY_ENERGY, CIRCLE
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

INCLUDE "data/black_box_promos.asm"
; 0x447b0

SECTION "Bank 11@48cc", ROMX[$48cc], BANK[$11]

INCLUDE "data/grand_master_cup.asm"

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
; 0x449a8

SECTION "Bank 11@5301", ROMX[$5301], BANK[$11]

Func_45301:
	or a
	jr nz, .asm_4531b
	ld a, $2c
	ld [wRemainingIntroCards], a
	ld a, $b0
	ld [wFilteredListPtr], a
	ld a, $47
	ld [wFilteredListPtr+1], a
	ld a, VAR_28
	farcall GetVarValue
	jr .asm_45330
.asm_4531b
	ld a, $1b
	ld [wRemainingIntroCards], a
	ld a, $60
	ld [wFilteredListPtr], a
	ld a, $48
	ld [wFilteredListPtr+1], a
	ld a, VAR_30
	farcall GetVarValue
.asm_45330
	cp $03
	jr z, .asm_4533a
	jr nc, .asm_4533e
	ld a, $00
	jr .asm_45340
.asm_4533a
	ld a, $01
	jr .asm_45340
.asm_4533e
	ld a, $02
.asm_45340
	ld [wd578], a
	ld e, $03
	ld d, VAR_2D
	ld c, $ff
.asm_45349
	ld a, d
	farcall SetVarValue
	inc d
	dec e
	jr nz, .asm_45349
	ld c, $00
.asm_45354
	ld b, $01
	ld a, c
	or a
.asm_45358
	jr z, .asm_4535f
	sla b
	dec a
	jr .asm_45358
.asm_4535f
	call Func_45379
	call Func_453a3
	jr c, .asm_4535f
	push bc
	ld d, a
	ld a, VAR_2D
	add c
	ld c, d
	farcall SetVarValue
	pop bc
	inc c
	ld a, $03
	cp c
	jr nz, .asm_45354
	ret

Func_45379:
.asm_45379
	ld a, [wd578]
	ld d, a
	ld a, [wFilteredListPtr]
	ld l, a
	ld a, [wFilteredListPtr+1]
	ld h, a
	ld a, [wRemainingIntroCards]
	call Random
	sla a
	sla a
	add l
	ld l, a
	jr nc, .asm_45394
	inc h
.asm_45394
	push hl
	inc hl
	ld a, d
	add l
	ld l, a
	jr nc, .asm_4539c
	inc h
.asm_4539c
	ld a, [hl]
	pop hl
	and b
	jr z, .asm_45379
	ld a, [hl]
	ret

Func_453a3:
	ld d, a
	farcall LoadNPCDuelistDeck
	ld l, a
	ld e, VAR_2D
.asm_453ab
	ld a, e
	farcall GetVarValue
	cp $ff
	jr z, .asm_453bf
	farcall LoadNPCDuelistDeck
	inc e
	cp l
	jr nz, .asm_453ab
	ld a, d
	scf
	ret
.asm_453bf
	ld a, d
	scf
	ccf
	ret

; special handling for Amy?
Func_453c3:
	farcall LoadNPCDuelistDeck
	cp NPC_AMY_LOUNGE
	jr nz, .done
	ld a, NPC_AMY
.done
	ret

Func_453ce:
	ld a, VAR_2C
	farcall GetVarValue
	ld c, a
	dec c
	ld a, VAR_2D
	add c
	farcall GetVarValue
	farcall LoadNPCDuelistDeck
	farcall LoadNPCDuelist
	ld a, [wCurrentNPCDuelistData + NPC_DUELIST_STRUCT_DIALOG_NAME]
	ld l, a
	ld a, [wCurrentNPCDuelistData + NPC_DUELIST_STRUCT_DIALOG_NAME + 1]
	ld h, a
	call LoadTxRam2
	ld a, l
	ld [wTxRam2_b], a
	ld a, h
	ld [wTxRam2_b + 1], a
	ret

Func_453f9:
	ld a, VAR_2C
	farcall GetVarValue
	dec a
	ld c, a
	ld a, VAR_2D
	add c
	farcall GetVarValue
	ld [wNPCDuelDeckID], a
	ld a, MUSIC_MATCH_START_CLUB_MASTER
	ld [wDuelStartTheme], a
	ld hl, wd583
	set 1, [hl]
	ret

SetGrandMasterCupOpponents:
	ld e, NUM_GRANDMASTERCUP_OPPONENTS
	ld d, VAR_GRANDMASTERCUP_OPPONENT_DECK_0
	ld c, $ff
.loop_init
	ld a, d
	farcall SetVarValue
	inc d
	dec e
	jr nz, .loop_init
; b = 1 << c for c = opponent slot number [0, 6]
; set opponents randomly with the bitmask b
; so Ronald may only be chosen at the last slot
	ld c, 0
.loop_set_opponents
	ld b, 1
	ld a, c
	or a
.loop_shift
	jr z, .set_opponent
	sla b
	dec a
	jr .loop_shift
.set_opponent
	call .PickOpponent
	call .CheckDupe
	jr c, .set_opponent
	push bc
	ld d, a
	ld a, VAR_GRANDMASTERCUP_OPPONENT_DECK_0
	add c
	ld c, d
	farcall SetVarValue
	pop bc
	inc c
	ld a, NUM_GRANDMASTERCUP_OPPONENTS
	cp c
	jr nz, .loop_set_opponents
	ret

; for b = bitmask, choose a random opponent and return their deck id in a
.PickOpponent:
	ld hl, GrandMasterCupOpps
	ld a, NUM_GRANDMASTERCUP_OPPONENT_IDS
	call Random
	sla a
	add l
	ld l, a
	jr nc, .compare
	inc h
.compare
	push hl
	inc hl
	ld a, [hl]
	pop hl
	and b
	jr z, .PickOpponent
	ld a, [hl]
	ret

; set carry if the opponent is already picked
.CheckDupe:
	ld d, a
	farcall LoadNPCDuelistDeck
	ld l, a
	ld e, VAR_GRANDMASTERCUP_OPPONENT_DECK_0
.loop_check
	ld a, e
	farcall GetVarValue
	cp $ff
	jr z, .done
	farcall LoadNPCDuelistDeck
	inc e
	cp l
	jr nz, .loop_check
	ld a, d
	scf
	ret
.done
	ld a, d
	scf
	ccf
	ret

Func_45484:
	call Func_453c3
	ret

Func_45488:
	ld a, VAR_0E
	farcall GetVarValue
	cp $02
	jr z, .asm_4549c
	jr nc, .asm_454a4
	ld a, VAR_GRANDMASTERCUP_OPPONENT_DECK_0
	farcall GetVarValue
	jr .asm_454aa
.asm_4549c
	ld a, VAR_1B
	farcall GetVarValue
	jr .asm_454aa
.asm_454a4
	ld a, VAR_1E
	farcall GetVarValue
.asm_454aa
	ret

Func_454ab:
	call Func_45488
	ld [wNPCDuelDeckID], a
	ld a, MUSIC_MATCH_START_CLUB_MASTER
	ld [wDuelStartTheme], a
	ld hl, wd583
	set 1, [hl]
	ret

Func_454bc:
	call Func_45488
	farcall LoadNPCDuelistDeck
	farcall LoadNPCDuelist
	ld a, [wCurrentNPCDuelistData + NPC_DUELIST_STRUCT_LOCATION_NAME]
	ld l, a
	ld a, [wCurrentNPCDuelistData + NPC_DUELIST_STRUCT_LOCATION_NAME + 1]
	ld h, a
	call LoadTxRam2
	ld a, [wCurrentNPCDuelistData + NPC_DUELIST_STRUCT_DIALOG_NAME]
	ld l, a
	ld a, [wCurrentNPCDuelistData + NPC_DUELIST_STRUCT_DIALOG_NAME + 1]
	ld h, a
	ld a, l
	ld [wTxRam2_b], a
	ld a, h
	ld [wTxRam2_b + 1], a
	ret

Func_454e3:
	call Func_45488
	farcall LoadNPCDuelistDeck
	farcall LoadNPCDuelist
	ld a, [wCurrentNPCDuelistData + NPC_DUELIST_STRUCT_DIALOG_NAME]
	ld l, a
	ld a, [wCurrentNPCDuelistData + NPC_DUELIST_STRUCT_DIALOG_NAME + 1]
	ld h, a
	call LoadTxRam2
	ret

Func_454fa:
	ld a, VAR_GRANDMASTERCUP_OPPONENT_DECK_1
	farcall GetVarValue
	ld c, a
	call UpdateRNGSources
	rrca
	jr nc, .asm_4550e
	ld a, VAR_GRANDMASTERCUP_OPPONENT_DECK_2
	farcall GetVarValue
	ld c, a
.asm_4550e
	ld a, VAR_1B
	farcall SetVarValue
	ld a, VAR_GRANDMASTERCUP_OPPONENT_DECK_3
	farcall GetVarValue
	ld c, a
	call UpdateRNGSources
	rrca
	jr nc, .asm_45528
	ld a, VAR_GRANDMASTERCUP_OPPONENT_DECK_4
	farcall GetVarValue
	ld c, a
.asm_45528
	ld a, VAR_1C
	farcall SetVarValue
	ld a, VAR_GRANDMASTERCUP_OPPONENT_DECK_6
	farcall GetVarValue
	ld c, a
	farcall LoadNPCDuelistDeck
	cp NPC_RONALD
	jr z, .asm_4554a
	call UpdateRNGSources
	rrca
	jr c, .asm_4554a
	ld a, VAR_GRANDMASTERCUP_OPPONENT_DECK_5
	farcall GetVarValue
	ld c, a
.asm_4554a
	ld a, VAR_1D
	farcall SetVarValue
	ld a, VAR_1D
	farcall GetVarValue
	ld c, a
	farcall LoadNPCDuelistDeck
	cp NPC_RONALD
	jr z, .asm_4556c
	call UpdateRNGSources
	rrca
	jr c, .asm_4556c
	ld a, VAR_1C
	farcall GetVarValue
	ld c, a
.asm_4556c
	ld a, VAR_1E
	farcall SetVarValue
	ret

Func_45573:
	farcall Func_1ea00
	ld a, VAR_GRANDMASTERCUP_OPPONENT_DECK_0
	ld c, $01
.asm_4557b
	push af
	push bc
	farcall GetVarValue
	farcall LoadNPCDuelistDeck
	farcall LoadNPCDuelist
	ld a, [wCurrentNPCDuelistData + NPC_DUELIST_STRUCT_DIALOG_NAME]
	ld l, a
	ld a, [wCurrentNPCDuelistData + NPC_DUELIST_STRUCT_DIALOG_NAME + 1]
	ld h, a
	pop bc
	ld a, c
	farcall Func_1e9ea
	inc c
	ld a, $08
	cp c
	jr z, .asm_455a1
	pop af
	inc a
	jr .asm_4557b
.asm_455a1
	pop af
	ret

Func_455a3:
	ld a, VAR_0E
	farcall GetVarValue
	cp $01
	jp c, .asm_45658
	jr z, .asm_455f0
	cp $02
	jr z, .asm_455c8
	ld a, EVENT_SET_UNTIL_MAP_RELOAD_2
	farcall GetEventValue
	ld c, $06
	jr z, .asm_455c2
	ld a, $01
	jr .asm_455c4
.asm_455c2
	ld a, $02
.asm_455c4
	farcall Func_1ea4c
.asm_455c8
	ld c, $04
	ld a, $01
	farcall Func_1ea4c
	ld c, $05
	ld a, $01
	farcall Func_1ea4c
	ld a, VAR_1C
	farcall GetVarValue
	ld c, a
	ld a, VAR_1E
	farcall GetVarValue
	cp c
	jr z, .asm_455f0
	ld c, $05
	ld a, $02
	farcall Func_1ea4c
.asm_455f0
	ld c, $00
	ld a, $01
	farcall Func_1ea4c
	ld c, $01
	ld a, $01
	farcall Func_1ea4c
	ld a, VAR_GRANDMASTERCUP_OPPONENT_DECK_1
	farcall GetVarValue
	ld c, a
	ld a, VAR_1B
	farcall GetVarValue
	cp c
	jr z, .asm_45618
	ld c, $01
	ld a, $02
	farcall Func_1ea4c
.asm_45618
	ld c, $02
	ld a, $01
	farcall Func_1ea4c
	ld a, VAR_GRANDMASTERCUP_OPPONENT_DECK_3
	farcall GetVarValue
	ld c, a
	ld a, VAR_1C
	farcall GetVarValue
	cp c
	jr z, .asm_45638
	ld c, $02
	ld a, $02
	farcall Func_1ea4c
.asm_45638
	ld c, $03
	ld a, $01
	farcall Func_1ea4c
	ld a, VAR_GRANDMASTERCUP_OPPONENT_DECK_5
	farcall GetVarValue
	ld c, a
	ld a, VAR_1D
	farcall GetVarValue
	cp c
	jr z, .asm_45658
	ld c, $03
	ld a, $02
	farcall Func_1ea4c
.asm_45658
	farcall Func_1e984
	ret

Func_4565d:
	push bc
	push de
	push hl
	or a
	jr nz, .asm_45668
	ld a, [wPlayerOWObject]
	jr .asm_45672
.asm_45668
	dec a
	add VAR_GRANDMASTERCUP_OPPONENT_DECK_0
	farcall GetVarValue
	call Func_45484
.asm_45672
	pop hl
	pop de
	pop bc
	ret

; for a = [0, 3], return in bc the prize card id
; at GrandMasterCupPromoPrizes[VAR_GRANDMASTERCUP_PRIZE_INDEX_[a]]
GetGrandMasterCupPrizeCardID:
	push af
	push hl
	ld c, VAR_GRANDMASTERCUP_PRIZE_INDEX_0
	add c
	farcall GetVarValue
	ld hl, GrandMasterCupPromoPrizes
	sla a
	add l
	ld l, a
	jr nc, .asm_45689
	inc h
.asm_45689
	ld a, [hli]
	ld b, [hl]
	ld c, a
	pop hl
	pop af
	ret

; for a = [0, 3], return in hl the prize card name
; at GrandMasterCupPromoPrizes[VAR_GRANDMASTERCUP_PRIZE_INDEX_[a]]
GetGrandMasterCupPrizeCardName:
	push af
	push bc
	push de
	call GetGrandMasterCupPrizeCardID
	ld e, c
	ld d, b
	farcall GetReceivingCardLongName
	pop de
	pop bc
	pop af
	ret

INCLUDE "engine/black_box.asm"

INCLUDE "engine/credits.asm"
