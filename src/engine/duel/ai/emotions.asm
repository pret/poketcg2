AIUpdatePortrait:
	ld a, -1
	ld [wd061], a
	ld a, [wDuelFinished]
	or a
	jr z, .duel_ongoing

; duel finished
	ld a, [wDuelResult]
	or a
	jp z, .set_sad_portrait ; DUEL_WIN
	cp DUEL_LOSS
	jp z, .set_happy_portrait
	jp .set_normal_portrait

.duel_ongoing
	ld a, [wOpponentDeckID]
	or a
	jp z, .set_normal_portrait
	ld c, a
	ld b, $00
	ld hl, AIOpponentPersonalities
	add hl, bc
	ld a, [hl]

	; emotionless opponents only emote
	; when the duel is finished
	cp PERSONALITY_EMOTIONLESS
	jp z, .set_normal_portrait

	ld b, a
	ld a, [wcd77]
	or a
	jr z, .not_drawing
	; is drawing cards
	cp 1
	jp z, .drawing_1_card

	; is drawing more than 1 card
	ldh a, [hWhoseTurn]
	cp PLAYER_TURN
	jp z, .finished
	ld a, b
	cp PERSONALITY_EMOTIONAL
	jr nz, .check_serious
	; 10% chance normal portrait
	; 90% chance happy portrait
	ld a, 10
	call Random
	or a
	jp z, .set_normal_portrait
	jp .set_happy_portrait

.check_serious
	cp PERSONALITY_SERIOUS
	jr nz, .standard
	; 10% chance happy portrait
	; 90% chance normal portrait
	ld a, 10
	call Random
	or a
	jp z, .set_happy_portrait
	jp .set_normal_portrait

.standard
	; 10% chance sad portrait
	; 40% chance happy portrait
	; 50% chance normal portrait
	ld a, 10
	call Random
	or a
	jp z, .set_sad_portrait
	cp 5
	jp c, .set_happy_portrait
	jp .set_normal_portrait

.not_drawing
	ldh a, [hWhoseTurn]
	cp PLAYER_TURN
	jp z, .count_prizes ; can be jr
	ld a, DUELVARS_NUMBER_OF_CARDS_NOT_IN_DECK
	get_turn_duelist_var
	cp DECK_SIZE
	jp z, .set_sad_portrait
.count_prizes
	ldh a, [hWhoseTurn]
	cp PLAYER_TURN
	jp nz, .reverse_count_order ; can be jr
	call SwapTurn
	call CountPrizes
	ld [wAIOpponentPrizeCount], a
	call SwapTurn
	call CountPrizes
	ld [wAIPlayerPrizeCount], a
	jr .got_prize_count_of_both_duelists
.reverse_count_order
	call SwapTurn
	call CountPrizes
	ld [wAIPlayerPrizeCount], a
	call SwapTurn
	call CountPrizes
	ld [wAIOpponentPrizeCount], a
.got_prize_count_of_both_duelists
	ld a, [wAIOpponentPrizeCount]
	ld c, a ; opp's prize count
	cp 1
	ld a, [wAIPlayerPrizeCount]
	jr z, .opp_or_player_on_last_prize_card
	cp 1
	jp nz, .set_normal_portrait
.opp_or_player_on_last_prize_card
	add 5
	sub c ; 6 + (player's prize count - opp's prize count)
	ld c, a
	add a
	add c ; got row
	add b ; got column
	ld c, a
	ld b, $00
	ld hl, PrizeCountPersonalityEmotionMatrix
	add hl, bc
	ld a, [hl]
	ld [wcd78], a
	ret

.drawing_1_card
	ldh a, [hWhoseTurn]
	cp PLAYER_TURN
	jp z, .finished
	ld a, b
	ld [wTempAI], a
	; temporarily draw card
	; set sad portrait if no more deck cards
	call DrawCardFromDeck
	jp c, .set_sad_portrait
	ld [wd061], a
	ld a, [wd061] ; unnecessary
	call GetCardIDFromDeckIndex
	cp16 PROFESSOR_OAK
	jp z, .set_happy_based_on_personality
	cp16 BILL
	jp z, .set_happy_based_on_personality
	cp16 BILLS_TELEPORTER
	jp z, .set_happy_based_on_personality
	cp16 ENERGY_SEARCH
	jp z, .set_happy_based_on_personality
	cp16 DOUBLE_COLORLESS_ENERGY
	jp z, .set_happy_based_on_personality
	cp16 POTION_ENERGY
	jp z, .set_happy_based_on_personality
	cp16 RAINBOW_ENERGY
	jp z, .set_happy_based_on_personality
	cp16 FULLHEAL_ENERGY
	jp z, .set_happy_based_on_personality
	cp16 FULL_HEAL
	jp z, .happy_if_statused

	call GetCardType
	cp TYPE_ENERGY
	jr c, .pkmn_card
	cp TYPE_TRAINER
	jr z, .trainer_card

; energy card
	farcall LookForCardIDInHandList
	jp c, .finished ; already has one in hand
	; doesn't have this energy card in hand
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	dec a
	ld b, a
.loop_play_area_1
	ld a, DUELVARS_ARENA_CARD
	add b
	get_turn_duelist_var
	push bc
	call GetCardIDFromDeckIndex
	ld a, e
	ld [wTempCardID_d0a3 + 0], a
	ld a, d
	ld [wTempCardID_d0a3 + 1], a
	call LoadCardDataToBuffer1_FromCardID
	ld a, [wLoadedCard1Type]
	or TYPE_ENERGY
	ld [wTempCardType], a
	ld a, [wd061]
	farcall CheckIfEnergyIsUseful
	pop bc
	jr c, .set_happy_based_on_personality
	ld a, b
	or a
	jp z, .finished
	dec b
	jr .loop_play_area_1

.pkmn_card
	ld a, [wd061]
	call LoadCardDataToBuffer1_FromDeckIndex
	ld a, [wLoadedCard1Stage]
	or a
	jr z, .basic_pkmn
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	dec a
	ld e, a
	ld a, [wd061]
	ld d, a
.loop_play_area_2
	call CheckIfEvolvesInto
	; bug, this should be jr c
	jr nc, .set_happy_based_on_personality
	ld a, e
	or a
	jr z, .finished
	dec e
	jr .loop_play_area_2

.basic_pkmn
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	cp 2
	jr c, .set_happy_based_on_personality ; only has 1 Pokémon in Play Area
	jr .finished

.trainer_card
	ld a, [wTempAI]
	cp PERSONALITY_EMOTIONAL
	jr nz, .check_standard

	; 25% chance normal portrait
	; 75% chance sad portrait
	ld a, 20
	call Random
	cp 5
	jr c, .set_normal_portrait
	jr .set_sad_portrait

.check_standard
	or a
	jr z, .serious

	; 10% chance sad portrait
	; 90% chance normal portrait
	ld a, 10
	call Random
	or a
	jr z, .set_sad_portrait
	jr .set_normal_portrait

.serious
	; 75% chance normal portrait
	; 25% chance sad portrait
	ld a, 20
	call Random
	cp 15
	jr c, .set_normal_portrait
	jr .set_sad_portrait

.happy_if_statused
	ld a, DUELVARS_ARENA_CARD_STATUS
	get_turn_duelist_var
	or a
	jr z, .finished
.set_happy_based_on_personality
	ld a, [wTempAI]
	cp PERSONALITY_EMOTIONAL
	jr z, .set_happy_portrait
	or a
	jr z, .likely_happy_portrait
	; 10% chance happy portrait
	ld a, 10
	call Random
	or a
	jr z, .set_happy_portrait
	jr .finished
.likely_happy_portrait
	; 75% chance happy portrait
	ld a, 20
	call Random
	cp 15
	jr c, .set_happy_portrait
	jr .finished

.set_normal_portrait
	xor a ; EMOTION_NORMAL
	ld [wcd78], a
	jr .finished
.set_happy_portrait
	ld a, EMOTION_HAPPY
	ld [wcd78], a
	jr .finished
.set_sad_portrait
	ld a, EMOTION_SAD
	ld [wcd78], a
.finished
	; if drew a card to peek,
	; then put it back in the deck
	ld a, [wd061]
	cp -1
	ret z
	call ReturnCardToDeck
	ret
