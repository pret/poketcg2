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
	add_hl_a
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

INCLUDE "data/challenge_cup_opponents.asm"

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
	ld [wTempActiveMusic], a
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

; a = TCG_ISLAND or GR_ISLAND
; set three opponents for the cup
SetChallengeCupOpponents:
	or a
	jr nz, .gr_cup
; tcg cup
	ld a, NUM_TCG_CHALLENGE_CUP_OPPONENT_POOL
	ld [wNumRandomDuelists], a
	ld a, LOW(TCGChallengeCupOpponents)
	ld [wFilteredListPtr], a
	ld a, HIGH(TCGChallengeCupOpponents)
	ld [wFilteredListPtr + 1], a
	ld a, VAR_TCG_CHALLENGE_CUP_STATE
	farcall GetVarValue
	jr .get_cup_index
.gr_cup
	ld a, NUM_GR_CHALLENGE_CUP_OPPONENT_POOL
	ld [wNumRandomDuelists], a
	ld a, LOW(GRChallengeCupOpponents)
	ld [wFilteredListPtr], a
	ld a, HIGH(GRChallengeCupOpponents)
	ld [wFilteredListPtr + 1], a
	ld a, VAR_GR_CHALLENGE_CUP_STATE
	farcall GetVarValue
.get_cup_index
	cp CHALLENGE_CUP_2_START
	jr z, .cup2
	jr nc, .cup3
; cup1
	ld a, CHALLENGE_CUP_1
	jr .set_cup_index
.cup2
	ld a, CHALLENGE_CUP_2
	jr .set_cup_index
.cup3
	ld a, CHALLENGE_CUP_3
.set_cup_index
	ld [wChallengeCupIndex], a
; init
	ld e, NUM_CHALLENGE_CUP_ROUNDS
	ld d, VAR_CHALLENGECUP_ROUND1_OPPONENT_DECK_ID
	ld c, $ff
.loop_init
	ld a, d
	farcall SetVarValue
	inc d
	dec e
	jr nz, .loop_init
; set
; b = 1 << c for c = round number [0, 2]
; set opponents randomly with the bitmask b and wChallengeCupIndex
	ld c, 0
.loop_set_opponents
	ld b, 1
	ld a, c
	or a
.loop_shift
	jr z, .loop_pick
	sla b
	dec a
	jr .loop_shift
.loop_pick
	call .PickOpponent
	call .CheckDupe
	jr c, .loop_pick
	push bc
	ld d, a
	ld a, VAR_CHALLENGECUP_ROUND1_OPPONENT_DECK_ID
	add c
	ld c, d
	farcall SetVarValue
	pop bc
	inc c
	ld a, NUM_CHALLENGE_CUP_ROUNDS
	cp c
	jr nz, .loop_set_opponents
	ret

; for b = bitmask, choose a random opponent with wChallengeCupIndex
; and return their deck id in a
.PickOpponent:
	ld a, [wChallengeCupIndex]
	ld d, a
	ld a, [wFilteredListPtr]
	ld l, a
	ld a, [wFilteredListPtr + 1]
	ld h, a
	ld a, [wNumRandomDuelists]
	call Random
	sla a
	sla a
	add_hl_a
	push hl
	inc hl
	ld a, d
	add_hl_a
	ld a, [hl]
	pop hl
	and b
	jr z, .PickOpponent
	ld a, [hl]
	ret

; set carry if the opponent is already picked
.CheckDupe:
	ld d, a
	farcall GetNPCByDeck
	ld l, a
	ld e, VAR_CHALLENGECUP_ROUND1_OPPONENT_DECK_ID
.loop_check
	ld a, e
	farcall GetVarValue
	cp $ff
	jr z, .done
	farcall GetNPCByDeck
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

; GetNPCByDeck, with special handling for Amy
GetNPCByDeck_AdjustAmy:
	farcall GetNPCByDeck
	cp NPC_AMY_LOUNGE
	jr nz, .done
	ld a, NPC_AMY
.done
	ret

LoadChallengeCupOpponentName:
	ld a, VAR_CHALLENGECUP_CURRENT_ROUND
	farcall GetVarValue
	ld c, a
	dec c
	ld a, VAR_CHALLENGECUP_ROUND1_OPPONENT_DECK_ID
	add c
	farcall GetVarValue
	farcall GetNPCByDeck
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

SetChallengeCupDuelParams:
	ld a, VAR_CHALLENGECUP_CURRENT_ROUND
	farcall GetVarValue
	dec a
	ld c, a
	ld a, VAR_CHALLENGECUP_ROUND1_OPPONENT_DECK_ID
	add c
	farcall GetVarValue
	ld [wNPCDuelDeckID], a
	ld a, MUSIC_MATCH_START_CLUB_MASTER
	ld [wDuelStartTheme], a
	ld hl, wOverworldTransition
	set 1, [hl]
	ret

SetGrandMasterCupOpponents:
; init
	ld e, NUM_GRANDMASTERCUP_NPC_COMPETITORS
	ld d, VAR_GRANDMASTERCUP_ROUND1_NPC1_DECK_ID
	ld c, $ff
.loop_init
	ld a, d
	farcall SetVarValue
	inc d
	dec e
	jr nz, .loop_init
; set
; b = 1 << c for c = opponent slot number [0, 6]
; set opponents randomly with the bitmask b
; so Ronald may only be chosen at the last slot
	ld c, 0
.loop_set_opponents
	ld b, 1
	ld a, c
	or a
.loop_shift
	jr z, .loop_pick
	sla b
	dec a
	jr .loop_shift
.loop_pick
	call .PickOpponent
	call .CheckDupe
	jr c, .loop_pick
	push bc
	ld d, a
	ld a, VAR_GRANDMASTERCUP_ROUND1_NPC1_DECK_ID
	add c
	ld c, d
	farcall SetVarValue
	pop bc
	inc c
	ld a, NUM_GRANDMASTERCUP_NPC_COMPETITORS
	cp c
	jr nz, .loop_set_opponents
	ret

; for b = bitmask, choose a random opponent and return their deck id in a
.PickOpponent:
	ld hl, GrandMasterCupOpponents
	ld a, NUM_GRANDMASTERCUP_OPPONENT_POOL
	call Random
	sla a
	add_hl_a
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
	farcall GetNPCByDeck
	ld l, a
	ld e, VAR_GRANDMASTERCUP_ROUND1_NPC1_DECK_ID
.loop_check
	ld a, e
	farcall GetVarValue
	cp $ff
	jr z, .done
	farcall GetNPCByDeck
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

; just GetNPCByDeck_AdjustAmy
; tried to add something for pokemon dome?
GetNPCByDeck_AdjustAmy_PokemonDome:
	call GetNPCByDeck_AdjustAmy
	ret

; return a = opponent deck id of the current round (1, 2, finals)
GetGrandMasterCupCurOpponent:
	ld a, VAR_GRANDMASTERCUP_CURRENT_ROUND
	farcall GetVarValue
	cp 2
	jr z, .round2
	jr nc, .finals
; round 1
	ld a, VAR_GRANDMASTERCUP_ROUND1_NPC1_DECK_ID
	farcall GetVarValue
	jr .done
.round2
	ld a, VAR_GRANDMASTERCUP_ROUND2_NPC1_DECK_ID
	farcall GetVarValue
	jr .done
.finals
	ld a, VAR_GRANDMASTERCUP_FINAL_NPC_DECK_ID
	farcall GetVarValue
.done
	ret

SetGrandMasterCupDuelParams:
	call GetGrandMasterCupCurOpponent
	ld [wNPCDuelDeckID], a
	ld a, MUSIC_MATCH_START_CLUB_MASTER
	ld [wDuelStartTheme], a
	ld hl, wOverworldTransition
	set 1, [hl]
	ret

LoadGrandMasterCupCurOpponentLocationAndName:
	call GetGrandMasterCupCurOpponent
	farcall GetNPCByDeck
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

LoadGrandMasterCupCurOpponentName:
	call GetGrandMasterCupCurOpponent
	farcall GetNPCByDeck
	farcall LoadNPCDuelist
	ld a, [wCurrentNPCDuelistData + NPC_DUELIST_STRUCT_DIALOG_NAME]
	ld l, a
	ld a, [wCurrentNPCDuelistData + NPC_DUELIST_STRUCT_DIALOG_NAME + 1]
	ld h, a
	call LoadTxRam2
	ret

; determine all non-player match results up to finals
; by UpdateRNGSources + rrca
SetGrandMasterCupNPCMatchWinners:
; round 1 match 2
	ld a, VAR_GRANDMASTERCUP_ROUND1_NPC2_DECK_ID
	farcall GetVarValue
	ld c, a
	call UpdateRNGSources
	rrca
	jr nc, .got_winner_round1_match2
	ld a, VAR_GRANDMASTERCUP_ROUND1_NPC3_DECK_ID
	farcall GetVarValue
	ld c, a
.got_winner_round1_match2
	ld a, VAR_GRANDMASTERCUP_ROUND2_NPC1_DECK_ID
	farcall SetVarValue

; round 1 match 3
	ld a, VAR_GRANDMASTERCUP_ROUND1_NPC4_DECK_ID
	farcall GetVarValue
	ld c, a
	call UpdateRNGSources
	rrca
	jr nc, .got_winner_round1_match3
	ld a, VAR_GRANDMASTERCUP_ROUND1_NPC5_DECK_ID
	farcall GetVarValue
	ld c, a
.got_winner_round1_match3
	ld a, VAR_GRANDMASTERCUP_ROUND2_NPC2_DECK_ID
	farcall SetVarValue

; round 1 match 4 and round 2 match 2
; Ronald is guaranteed to advance to finals
	ld a, VAR_GRANDMASTERCUP_ROUND1_NPC7_DECK_ID
	farcall GetVarValue
	ld c, a
	farcall GetNPCByDeck
	cp NPC_RONALD
	jr z, .got_winner_round1_match4
	call UpdateRNGSources
	rrca
	jr c, .got_winner_round1_match4
	ld a, VAR_GRANDMASTERCUP_ROUND1_NPC6_DECK_ID
	farcall GetVarValue
	ld c, a
.got_winner_round1_match4
	ld a, VAR_GRANDMASTERCUP_ROUND2_NPC3_DECK_ID
	farcall SetVarValue

	ld a, VAR_GRANDMASTERCUP_ROUND2_NPC3_DECK_ID
	farcall GetVarValue
	ld c, a
	farcall GetNPCByDeck
	cp NPC_RONALD
	jr z, .got_winner_round2_match2
	call UpdateRNGSources
	rrca
	jr c, .got_winner_round2_match2
	ld a, VAR_GRANDMASTERCUP_ROUND2_NPC2_DECK_ID
	farcall GetVarValue
	ld c, a
.got_winner_round2_match2
	ld a, VAR_GRANDMASTERCUP_FINAL_NPC_DECK_ID
	farcall SetVarValue
	ret

InitAndLoadGrandMasterCupOpponentNames:
	farcall InitGrandMasterCupBracket
	ld a, VAR_GRANDMASTERCUP_ROUND1_NPC1_DECK_ID
	ld c, 1
.loop_load
	push af
	push bc
	farcall GetVarValue
	farcall GetNPCByDeck
	farcall LoadNPCDuelist
	ld a, [wCurrentNPCDuelistData + NPC_DUELIST_STRUCT_DIALOG_NAME]
	ld l, a
	ld a, [wCurrentNPCDuelistData + NPC_DUELIST_STRUCT_DIALOG_NAME + 1]
	ld h, a
	pop bc
	ld a, c
	farcall LoadGrandMasterCupCompetitorNames
	inc c
	ld a, NUM_GRANDMASTERCUP_COMPETITORS
	cp c
	jr z, .done
	pop af
	inc a
	jr .loop_load
.done
	pop af
	ret

; defaults to the left (top) side being the match winner,
; so adjust with *_RIGHT_WON otherwise
SetupAndShowGrandMasterCupBracket:
	ld a, VAR_GRANDMASTERCUP_CURRENT_ROUND
	farcall GetVarValue
	cp 1
	jp c, .draw_bracket
	jr z, .draw_round1_results
	cp 2
	jr z, .draw_round2_results

; draw final results
	ld a, EVENT_SET_UNTIL_MAP_RELOAD_2
	farcall GetEventValue
	ld c, GRANDMASTERCUP_BRACKET_FINAL
	jr z, .player_lost_finals
	ld a, GRANDMASTERCUP_BRACKET_LEFT_WON
	jr .checked_final_result
.player_lost_finals
	ld a, GRANDMASTERCUP_BRACKET_RIGHT_WON
.checked_final_result
	farcall UpdateGrandMasterCupBracketResults

.draw_round2_results
	ld c, GRANDMASTERCUP_BRACKET_ROUND2_MATCH1
	ld a, GRANDMASTERCUP_BRACKET_LEFT_WON
	farcall UpdateGrandMasterCupBracketResults

	ld c, GRANDMASTERCUP_BRACKET_ROUND2_MATCH2
	ld a, GRANDMASTERCUP_BRACKET_LEFT_WON
	farcall UpdateGrandMasterCupBracketResults
; check round2-match2 result
	ld a, VAR_GRANDMASTERCUP_ROUND2_NPC2_DECK_ID
	farcall GetVarValue
	ld c, a
	ld a, VAR_GRANDMASTERCUP_FINAL_NPC_DECK_ID
	farcall GetVarValue
	cp c
	jr z, .draw_round1_results
	ld c, GRANDMASTERCUP_BRACKET_ROUND2_MATCH2
	ld a, GRANDMASTERCUP_BRACKET_RIGHT_WON
	farcall UpdateGrandMasterCupBracketResults

.draw_round1_results
	ld c, GRANDMASTERCUP_BRACKET_ROUND1_MATCH1
	ld a, GRANDMASTERCUP_BRACKET_LEFT_WON
	farcall UpdateGrandMasterCupBracketResults

	ld c, GRANDMASTERCUP_BRACKET_ROUND1_MATCH2
	ld a, GRANDMASTERCUP_BRACKET_LEFT_WON
	farcall UpdateGrandMasterCupBracketResults
; check round1-match2 result
	ld a, VAR_GRANDMASTERCUP_ROUND1_NPC2_DECK_ID
	farcall GetVarValue
	ld c, a
	ld a, VAR_GRANDMASTERCUP_ROUND2_NPC1_DECK_ID
	farcall GetVarValue
	cp c
	jr z, .round1_match3
	ld c, GRANDMASTERCUP_BRACKET_ROUND1_MATCH2
	ld a, GRANDMASTERCUP_BRACKET_RIGHT_WON
	farcall UpdateGrandMasterCupBracketResults

.round1_match3
	ld c, GRANDMASTERCUP_BRACKET_ROUND1_MATCH3
	ld a, GRANDMASTERCUP_BRACKET_LEFT_WON
	farcall UpdateGrandMasterCupBracketResults
; check round1-match3 result
	ld a, VAR_GRANDMASTERCUP_ROUND1_NPC4_DECK_ID
	farcall GetVarValue
	ld c, a
	ld a, VAR_GRANDMASTERCUP_ROUND2_NPC2_DECK_ID
	farcall GetVarValue
	cp c
	jr z, .round1_match4
	ld c, GRANDMASTERCUP_BRACKET_ROUND1_MATCH3
	ld a, GRANDMASTERCUP_BRACKET_RIGHT_WON
	farcall UpdateGrandMasterCupBracketResults

.round1_match4
	ld c, GRANDMASTERCUP_BRACKET_ROUND1_MATCH4
	ld a, GRANDMASTERCUP_BRACKET_LEFT_WON
	farcall UpdateGrandMasterCupBracketResults
; check round1-match4 result
	ld a, VAR_GRANDMASTERCUP_ROUND1_NPC6_DECK_ID
	farcall GetVarValue
	ld c, a
	ld a, VAR_GRANDMASTERCUP_ROUND2_NPC3_DECK_ID
	farcall GetVarValue
	cp c
	jr z, .draw_bracket
	ld c, GRANDMASTERCUP_BRACKET_ROUND1_MATCH4
	ld a, GRANDMASTERCUP_BRACKET_RIGHT_WON
	farcall UpdateGrandMasterCupBracketResults

.draw_bracket
	farcall GrandMasterCupBracketScreen
	ret

; a = bracket champion's competitor index, player (0) or npc 1--7
; return a = NPC ID
GetGrandMasterCupBracketChampionID:
	push bc
	push de
	push hl
	or a
	jr nz, .npc
	ld a, [wPlayerOWObject]
	jr .done
.npc
	dec a
	add VAR_GRANDMASTERCUP_ROUND1_NPC1_DECK_ID
	farcall GetVarValue
	call GetNPCByDeck_AdjustAmy_PokemonDome
.done
	pop hl
	pop de
	pop bc
	ret

; for a = [0, 3], return bc = prize card id
; at GrandMasterCupPromoPrizes[VAR_GRANDMASTERCUP_PRIZE_INDEX_[a]]
GetGrandMasterCupPrizeCardID:
	push af
	push hl
	ld c, VAR_GRANDMASTERCUP_PRIZE_INDEX_0
	add c
	farcall GetVarValue
	ld hl, GrandMasterCupPromoPrizes
	sla a
	add_hl_a
	ld a, [hli]
	ld b, [hl]
	ld c, a
	pop hl
	pop af
	ret

; for a = [0, 3], return hl = prize card name
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
