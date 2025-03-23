; loads opponent deck at wOpponentDeckID to wOpponentDeck, and initializes wPlayerDuelistType.
; on a duel against Sam, also loads PRACTICE_PLAYER_DECK to wPlayerDeck.
; also, sets wRNG1 and wRNGCounter to $20 and wRNG2 to 0.
LoadOpponentDeck::
	xor a
	ld [wIsPracticeDuel], a
	ld [wcd17], a
	ld a, [wOpponentDeckID]
	or a
	jr z, .set_practice_duel
	cp UNUSED_SAMS_PRACTICE_DECK_ID
	jr z, .overwrite_opp_id
	cp AARONS_STEP1_DECK_ID
	jr z, .decr_by_1
	cp AARONS_STEP2_DECK_ID
	jr z, .decr_by_1
	cp AARONS_STEP3_DECK_ID
	jr z, .decr_by_1
	jr .not_special_duel
.set_practice_duel
	ld a, TRUE
	ld [wIsPracticeDuel], a
	ld e, a
	jr .load_predefined_player_deck
.overwrite_opp_id
	xor a ; SAMS_PRACTICE_DECK_ID
	ld [wOpponentDeckID], a
	ld e, $01
	jr .load_predefined_player_deck
.decr_by_1
	ld e, a
	dec e
.load_predefined_player_deck
	ld a, $01
	ld [wcd17], a
	call SwapTurn
	ld a, e
	add 2
	call LoadDeck
	call SwapTurn
	ld hl, wRNG1
	ld a, $20
	ld [hli], a
	ld [hl], $00
	inc hl
	ld [hl], a
.not_special_duel
	ld a, [wOpponentDeckID]
	inc a
	inc a ; convert from *_DECK_ID constant read from wOpponentDeckID to *_DECK constant
	call LoadDeck
	ld a, [wOpponentDeckID]
	cp $7a ; DECKS_END
	jr c, .valid_deck
	ld a, $01 ; PRACTICE_PLAYER_DECK_ID
	ld [wOpponentDeckID], a
.valid_deck
; set opponent as controlled by AI
	ld a, DUELVARS_DUELIST_TYPE
	get_turn_duelist_var
	ld a, [wOpponentDeckID]
	or DUELIST_TYPE_AI_OPP
	ld [hl], a
	ret

AIDoAction_Turn::
	ld a, AIACTION_DO_TURN
	jr AIDoAction

AIDoAction_StartDuel::
	ld a, AIACTION_START_DUEL
	jr AIDoAction

AIDoAction_ForcedSwitch::
	ld a, AIACTION_FORCED_SWITCH
	call AIDoAction
	ldh [hTempPlayAreaLocation_ff9d], a
	ret

AIDoAction_KOSwitch::
	ld a, AIACTION_KO_SWITCH
	call AIDoAction
	ldh [hTemp_ffa0], a
	ret

AIDoAction_TakePrize::
	ld a, AIACTION_TAKE_PRIZE
	jr AIDoAction

AIDoAction_UpdatePortrait::
	ld a, AIACTION_UPDATE_PORTRAIT
	jr AIDoAction

Func_2972:
	ld a, DUELVARS_NUMBER_OF_CARDS_NOT_IN_DECK
	get_turn_duelist_var
	ld b, a
	ld a, 50
	sub b
	jr c, .asm_2981
	cp 6
	ret c
	ld a, 5
	ret
.asm_2981
	xor a
	ret

Func_2983:
	ld a, $07
	ld a, $01
	ldh [hTemp_ffa0], a
	ret

Func_298a:
	ld a, $08
	ld hl, hTemp_ffa0
.asm_298f
	ld a, [hli]
	cp $ff
	jr nz, .asm_298f
	ld a, $ff
	ld [hl], a
	ret

; calls the appropriate AI routine to handle action,
; depending on the deck ID (see engine/duel/ai/deck_ai.asm)
; input:
;	- a = AIACTION_* constant
AIDoAction:
	ld c, a

; load bank for Opponent Deck pointer table
	ldh a, [hBankROM]
	push af
	ld a, BANK(DeckAIPointerTable)
	call BankswitchROM

; load hl with the corresponding pointer
	ld a, [wOpponentDeckID]
	ld l, a
	ld h, $0
	add hl, hl ; two bytes per deck
	ld de, DeckAIPointerTable
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a

	ld a, c
	or a
	jr nz, .not_zero

; if input was 0, copy deck data of turn player
	ld e, [hl]
	inc hl
	ld d, [hl]
	call CopyDeckData
	jr .done

; jump to corresponding AI routine related to input
.not_zero
	call JumpToFunctionInTable

.done
	ld c, a
	pop af
	call BankswitchROM
	ld a, c
	ret
