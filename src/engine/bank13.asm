FindBenchCardThatCanBeDamaged:
	farcall IsPlayerArenaCardImmune
	jr c, .find
	xor a
	farcall CheckIfCanDamageDefendingPokemon
	jr nc, .find
	xor a
	ret

.find
	ld a, DUELVARS_BENCH
	call GetNonTurnDuelistVariable
	ld e, PLAY_AREA_BENCH_1
.loop
	ld a, [hli]
	cp $ff
	jr z, .not_found
	push hl
	push de
	ld b, a
	ld a, DUELVARS_ARENA_CARD
	call GetNonTurnDuelistVariable
	push af
	ld [hl], b ; temporarily replace Arena card
	ld a, e
	add DUELVARS_ARENA_CARD_HP
	call GetNonTurnDuelistVariable
	ld b, a
	ld a, DUELVARS_ARENA_CARD_HP
	call GetNonTurnDuelistVariable
	push af
	ld [hl], b ; temporarily replace Arena card HP
	xor a
	farcall CheckIfCanDamageDefendingPokemon
	jr c, .can_damage
	ld a, DUELVARS_ARENA_CARD_HP
	call GetNonTurnDuelistVariable
	pop af
	ld [hl], a
	ld a, DUELVARS_ARENA_CARD
	call GetNonTurnDuelistVariable
	pop af
	ld [hl], a
	pop de
	inc e
	pop hl
	jr .loop

.can_damage
	ld a, DUELVARS_ARENA_CARD_HP
	call GetNonTurnDuelistVariable
	pop af
	ld [hl], a
	ld a, DUELVARS_ARENA_CARD
	call GetNonTurnDuelistVariable
	pop af
	ld [hl], a
	pop de
	ld a, e
	pop hl
	scf
	ret
.not_found
	ld a, PLAY_AREA_BENCH_1
	ret

INCLUDE "engine/duel/spread_attacks.asm"

; return carry if thd defending (player's arena) card is immune, with no Benched Pokémon
IsPlayerArenaCardImmuneAndNoBenchedPokemon:
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	call GetNonTurnDuelistVariable
	cp 1
	jr nz, .no_carry
	farcall IsPlayerArenaCardImmune
	ret c
.no_carry
	or a
	ret

; called when duel starts, makes AI prioritize a certain
; card to place in Arena, if possible
; only has one example, Staryu lv15 in Conserving Water deck
AIPrioritizeStartingArenaCard:
	ld a, [wOpponentDeckID]
	cp CONSERVING_WATER_DECK_ID
	jr z, .conserving_water_deck
	or a
	ret

.conserving_water_deck
	; place Staryu as Arena card if possible
	ld de, STARYU_LV15
	farcall LookForCardIDInHandList
	call c, PutHandPokemonCardInPlayArea
	or a
	ret

; input:
; - a = deck index
CheckIfShouldPlaySpecialEnergyCard:
	call GetCardIDFromDeckIndex
	cp16 DOUBLE_COLORLESS_ENERGY
	jr z, .double_colorless
	cp16 RAINBOW_ENERGY
	jr z, .skip_card
	cp16 POTION_ENERGY
	jr z, .potion_energy
	cp16 FULLHEAL_ENERGY
	jr z, .full_heal_energy

; play card
	ld a, -1
	scf
	ret

.skip_card
	xor a
	scf
	ret

.play_card
	xor a
	ret

.double_colorless
	farcall StubbedCheckIfOpponentHasBossDeckID
	ld a, 0
	ret

.potion_energy
	call CountBasicEnergyCardsInHand
	jr nc, .skip_card
	ld de, POTION_ENERGY
	farcall CheckIfHandHasRepeatedCard
	jr c, .play_card ; has more than 1 copy
	ld de, POTION
	farcall LookForCardIDInHand
	ld a, 0
	ret

.full_heal_energy
	call CountBasicEnergyCardsInHand
	jr nc, .skip_card
	ld de, FULLHEAL_ENERGY
	farcall CheckIfHandHasRepeatedCard
	jr c, .play_card ; has more than 1 copy
	ld de, FULL_HEAL
	farcall LookForCardIDInHand
	ld a, 0
	ret

CountBasicEnergyCardsInHand:
	bank1call CreateEnergyCardListFromHand
	ld a, 0
	ret c ; no energy cards
	ld b, 0
	ld hl, wDuelTempList
.loop_cards
	ld a, [hli]
	cp $ff
	jr z, .got_count
	push bc
	push hl
	call GetCardIDFromDeckIndex
	pop hl
	pop bc
	cp16 DOUBLE_COLORLESS_ENERGY
	jr z, .loop_cards
	cp16 RAINBOW_ENERGY
	jr z, .loop_cards
	cp16 POTION_ENERGY
	jr z, .loop_cards
	cp16 FULLHEAL_ENERGY
	jr z, .loop_cards
	cp16 RECYCLE_ENERGY
	jr z, .loop_cards
	inc b
	jr .loop_cards
.got_count
	ld a, b
	or a
	jr z, .no_basic_energy_cards
	ret
.no_basic_energy_cards
	scf
	ret

AILookForFocusBlastTargetToKO:
	farcall CheckIfPlayerHasAuroraVeilActive
	ccf
	ret nc ; no carry if Aurora Veil active
	ld e, PLAY_AREA_BENCH_1
	ld a, DUELVARS_BENCH
	call GetNonTurnDuelistVariable
.loop_bench
	ld a, [hli]
	cp $ff
	ret z ; no KO
	push hl
	push de
	call GetFocusBlastDamageAgainstPlayAreaPkmn
	pop de
	ld a, e
	add DUELVARS_ARENA_CARD_HP
	call GetNonTurnDuelistVariable
	pop hl
	cp b
	jr z, .knocks_out
	jr nc, .next_pkmn ; doesn't KO
.knocks_out
	ld a, e
	scf
	ret
.next_pkmn
	inc e
	jr .loop_bench

; input:
; - e = PLAY_AREA_* location
GetFocusBlastDamageAgainstPlayAreaPkmn:
	ld a, e
	push de
	call CheckIfPlayAreaCardIsWeakToArenaCard
	pop de
	ld a, 20
	jr nc, .not_weak
	add 20 ; is weak, double damage
.not_weak
	push af
	ld a, e
	call CheckIfPlayAreaCardIsResistantToArenaCard
	pop bc
	ret nc ; not resistant
	ld a, b
	sub 30 ; subtract resistance
	jr nc, .got_damage
	xor a
.got_damage
	ld b, a
	ret

AIChooseFocusBlastTarget:
	farcall CheckIfPlayerHasAuroraVeilActive
	ccf
	ret nc ; no carry if Aurora Veil active
	ld e, PLAY_AREA_BENCH_1
	ld a, DUELVARS_BENCH
	call GetNonTurnDuelistVariable
.loop_bench
	ld a, [hli]
	cp $ff
	ret z
	push hl
	push de
	call GetFocusBlastDamageAgainstPlayAreaPkmn
	pop de
	pop hl
	or a
	jr z, .next_pkmn
	ld a, e
	scf
	ret
.next_pkmn
	inc e
	jr .loop_bench

; input:
; - a = PLAY_AREA_* location
CheckIfPlayAreaCardIsResistantToArenaCard:
	call SwapTurn
	bank1call GetPlayAreaCardResistance
	call SwapTurn
	push af
	bank1call GetArenaCardColor
	call TranslateColorToWR
	pop bc
	cp b
	jr z, .set_carry
	or a
	ret
.set_carry
	scf
	ret

; input:
; - a = PLAY_AREA_* location
CheckIfPlayAreaCardIsWeakToArenaCard:
	call SwapTurn
	bank1call GetPlayAreaCardWeakness
	call SwapTurn
	push af
	bank1call GetArenaCardColor
	call TranslateColorToWR
	pop bc
	cp b
	jr z, .set_carry
	or a
	ret
.set_carry
	scf
	ret

CheckIfDefendingCardIsResistantToArenaCard:
	bank1call GetArenaCardColor
	call TranslateColorToWR
	push af
	call SwapTurn
	bank1call GetArenaCardResistance
	call SwapTurn
	pop bc
	cp b
	jr z, .set_carry
	or a
	ret
.set_carry
	scf
	ret

CheckIfArenaCardIsWeakToDefendingCard:
	call SwapTurn
	bank1call GetArenaCardColor
	call SwapTurn
	call TranslateColorToWR
	push af
	bank1call GetArenaCardWeakness
	pop bc
	cp b
	jr z, .set_carry
	or a
	ret
.set_carry
	scf
	ret

CheckIfArenaCardIsResistantToDefendingCard:
	call SwapTurn
	bank1call GetArenaCardColor
	call SwapTurn
	call TranslateColorToWR
	push af
	bank1call GetArenaCardResistance
	pop bc
	cp b
	jr z, .set_carry
	or a
	ret
.set_carry
	scf
	ret

CheckIfDefendingCardIsWeakToArenaCard:
	bank1call GetArenaCardColor
	call TranslateColorToWR
	push af
	call SwapTurn
	bank1call GetArenaCardWeakness
	call SwapTurn
	pop bc
	cp b
	jr z, .set_carry
	or a
	ret
.set_carry
	scf
	ret

CountPlayAreaPokemonExcludingTrainerPokemon:
	lb bc, PLAY_AREA_ARENA, 0
.loop_play_area
	ld a, DUELVARS_ARENA_CARD
	add b
	get_turn_duelist_var
	cp $ff
	jr z, .got_count
	inc b
	call GetCardIDFromDeckIndex
	cp16 CLEFAIRY_DOLL
	jr z, .loop_play_area
	cp16 MYSTERIOUS_FOSSIL
	jr z, .loop_play_area
	inc c
	jr .loop_play_area
.got_count
	ld a, c
	ret

; no carry if
;       defending Pokémon has Invisible Wall or NShield in effect
;   AND attacking Pokémon at PLAY_AREA_* location in a cannot damage it
; return carry otherwise
CanDamageDefendingPokemonUnderInvisibleWallOrNShield:
	push af
	call SwapTurn
	xor a ; PLAY_AREA_ARENA
	bank1call CheckIsIncapableOfUsingPkmnPower
	jr c, .set_carry_pop_af ; skip if already disabled

	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call GetCardIDFromDeckIndex
	call SwapTurn
	pop bc
	cp16 MR_MIME_LV28
	jr z, .check_damage_output
	cp16 MEW_LV8
	jr nz, .set_carry

; Invisible Wall or NShield is active, can damage it?
.check_damage_output
	ld a, b
	farcall CheckIfCanDamageDefendingPokemon
	jr c, .set_carry

; no carry
	or a
	ret

.set_carry_pop_af
	call SwapTurn
	pop af
.set_carry
	scf
	ret

; no carry if zero, return carry otherwise
IswD035Zero:
	ld a, [wd035]
	or a
	ret z
	scf
	ret

; if Pokémon in non-turn duelist Play Area location in a
; is Mr. Mime, then find other Pokémon in Play Area
; that isn't Mr. Mime
; input:
; - a = PLAY_AREA_* constant
FindReplacementPkmnIfMrMime:
	call SwapTurn
	push af
	add DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call GetCardIDFromDeckIndex
	cp16 MR_MIME_LV28
	jr nz, .not_mr_mime
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	ld b, a
	ld c, PLAY_AREA_ARENA
.loop_play_area
	ld a, c
	cp b
	jr z, .non_mr_mime_not_found
	push bc
	add DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call GetCardIDFromDeckIndex
	pop bc
	cp16 MR_MIME_LV28
	jr nz, .found_non_mr_mime
	inc c
	jr .loop_play_area
.found_non_mr_mime
	; found a Play Area card that isn't Mr. Mime
	; output its location
	pop af
	ld a, c
	call SwapTurn
	ret
.not_mr_mime
	; input is not Mr. Mime, nothing to do
	pop af
	call SwapTurn
	ret
.non_mr_mime_not_found
	; all Pokémon are Mr. Mime, so just output Arena card
	pop af
	ld a, PLAY_AREA_ARENA
	call SwapTurn
	ret

; PsychicBattleDeckAI?
PsychicBattleDeckAIDecideProfessorOak:
	ld a, DUELVARS_NUMBER_OF_CARDS_NOT_IN_DECK
	get_turn_duelist_var
	cp DECK_SIZE - 16
	ret nc

	ld a, [wDuelTurns]
	srl a
	cp 3
	jr c, .check_hand ; AI hasn't taken 3 turns

	ld a, DUELVARS_NUMBER_OF_CARDS_IN_HAND
	get_turn_duelist_var
	cp 5
	ret nc

.check_hand
	farcall CountEnergyCardsInHand
	cp 3
	ret nc

	call CreateHandCardList
	ld hl, wDuelTempList
	ld de, wTempCardCollection
.loop_copy
	ld a, [hli]
	ld [de], a
	inc de
	cp $ff
	jr nz, .loop_copy

	ld hl, wTempCardCollection
.loop_hand_cards
	ld a, [hli]
	cp $ff
	jp z, .set_carry
	push hl
	call GetCardIDFromDeckIndex
	cp16 PROFESSOR_OAK
	jr z, .next_card
	push de
	ld b, PLAY_AREA_ARENA
	farcall FindCardIDInTurnDuelistsPlayArea
	pop de
	jr c, .next_card
	cp16 SWITCH
	jr z, .next_card
	cp16 ENERGY_RETRIEVAL
	jr z, .next_card
; no carry
	pop hl
	or a
	ret
.next_card
	pop hl
	jp .loop_hand_cards

.set_carry
	scf
	ret

; PsychicBattleDeckAI?
PsychicBattleDeckAIDecideEnergyRetrieval:
	call CountBasicEnergyCardsInHand
	ret nc

	ld de, PROFESSOR_OAK
	farcall CheckIfHandHasRepeatedCard
	ret c

	ld de, PROFESSOR_OAK
	farcall LookForCardIDInHandList
	jr nc, .check_bill

	push af
	ld a, DUELVARS_NUMBER_OF_CARDS_NOT_IN_DECK
	get_turn_duelist_var
	cp DECK_SIZE - 16
	pop bc
	ld a, b
	ccf
	ret c

.check_bill
	ld de, BILL
	farcall LookForCardIDInHandList
	jr nc, .check_hand_and_play_area

	push af
	ld a, DUELVARS_NUMBER_OF_CARDS_NOT_IN_DECK
	get_turn_duelist_var
	cp DECK_SIZE - 11
	pop bc
	ld a, b
	ccf
	ret c

.check_hand_and_play_area
	farcall IsSameCardInHandAndPlayArea
	ret c

	ld de, SWITCH
	farcall LookForCardIDInHandList
	ret c

	ld de, PLUSPOWER
	farcall LookForCardIDInHandList
	ret

PsychicBattleDeckAIDecideGustOfWind:
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call GetCardIDFromDeckIndex
	cp16 MR_MIME_LV28
	jr z, .mr_mime
	cp16 MEWTWO_LV53
	jr z, .mewtwo
	cp16 HITMONCHAN_LV33
	jr z, .hitmonchan_or_sandslash
	cp16 SANDSLASH_LV33
	jr z, .hitmonchan_or_sandslash

.check_immunity_arena
	farcall IsPlayerArenaCardImmune
	ret nc
	ld a, $ff
	scf
	ret

.mr_mime
	call FindBenchCardWithAtLeastHalfHP
	ret c
	jr .check_immunity_arena

.mewtwo
	call FindBenchCardWithAtLeast3AttachedEnergies
	ret c
	jr .check_immunity_arena

.hitmonchan_or_sandslash
	farcall AILookForBenchTargetWeakToArenaColor
	ret c
	jr .check_immunity_arena

FindBenchCardWithAtLeastHalfHP:
	call SwapTurn
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	ld b, a
	ld c, PLAY_AREA_BENCH_1 - 1
.loop_find_at_least_half_hp
	inc c
	ld a, c
	cp b
	jr z, .not_found
	add DUELVARS_ARENA_CARD
	get_turn_duelist_var
	push bc
	call LoadCardDataToBuffer2_FromDeckIndex
	pop bc
	ld a, c
	add DUELVARS_ARENA_CARD_HP
	get_turn_duelist_var
	sla a
	ld d, a ; remaining HP * 2
	ld a, [wLoadedCard2HP]
	cp d
	jr c, .loop_find_at_least_half_hp
	; >= 50% full HP
	call SwapTurn
	ld a, c
	scf
	ret
.not_found
	call SwapTurn
	or a
	ret

FindBenchCardWithAtLeast3AttachedEnergies:
	call SwapTurn
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	ld b, a
	ld c, PLAY_AREA_BENCH_1 - 1
.loop_find_at_least_3_energies
	inc c
	ld a, c
	cp b
	jr z, .not_found
	push bc
	call CreateArenaOrBenchEnergyCardList
	pop bc
	cp 3
	jr c, .loop_find_at_least_3_energies
	; at least 3 attached energies
	call SwapTurn
	ld a, c
	scf
	ret
.not_found
	call SwapTurn
	or a
	ret

CheckIfShouldAttachExtraEnergyThisTurn:
	call CountPrizes
	cp 1
	jr z, .set_carry ; on last prize card
	ld a, DUELVARS_NUMBER_OF_CARDS_NOT_IN_DECK
	get_turn_duelist_var
	cp DECK_SIZE - 9
	jr nc, .set_carry
	; has at least 10 cards in deck
	ld b, $05
	ld a, [wOpponentDeckID]
	cp GLITTERING_SCALES_DECK_ID
	jr z, .asm_4c640
	cp GREAT_DRAGON_DECK_ID
	jr z, .asm_4c640
	cp MAD_PETALS_DECK_ID
	jr z, .asm_4c640
	cp RUNNING_WILD_DECK_ID
	jr z, .asm_4c640
	cp SPIRITED_AWAY_DECK_ID
	jr z, .asm_4c640
	cp STOP_LIFE_DECK_ID
	jr z, .asm_4c640
	cp SCORCHER_DECK_ID
	jr z, .asm_4c640
	cp SMASH_TO_MINCEMEAT_DECK_ID
	jr z, .asm_4c640
	ld b, $08
	cp DIRECT_HIT_DECK_ID
	jr z, .asm_4c640
.no_carry
	or a
	ret

.asm_4c640
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	ld hl, wAIStallCheckArenaCard
	cp [hl]
	jr nz, .no_carry
	ld a, [wAIStallCheckSelectedAttack]
	or a
	jr nz, .no_carry
	ld a, [wAIStallCheckRepeatCount]
	cp b
	jr c, .no_carry
.set_carry
	xor a
	ld [wAIRetreatScore], a
	scf
	ret

RecordAISelectedAttackForStallCheck:
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	ld hl, wAIStallCheckArenaCard
	cp [hl]
	jr nz, .asm_4c66e
	inc hl
	ld a, [wSelectedAttack]
	cp [hl] ; wAIStallCheckSelectedAttack
	jr nz, .asm_4c66f
	inc hl
	inc [hl] ; wAIStallCheckRepeatCount
	ret
.asm_4c66e
	ld [hli], a
.asm_4c66f
	ld a, [wSelectedAttack]
	ld [hli], a ; wAIStallCheckSelectedAttack
	ld [hl], 1 ; wAIStallCheckRepeatCount
	ret

BigThunderDeckAIDecideEnergyRemoval:
	farcall CheckIfArenaCardCanKnockOutDefendingCard_CheckHand
	ld b, PLAY_AREA_BENCH_1
	jr c, .check_hp_and_energy
	ld b, PLAY_AREA_ARENA
.check_hp_and_energy
	ld a, 40
	call FindPlayerPokemonInPlayAreaWithEnoughHPAndNonRecycleEnergy
	jr c, .pick_energy_to_remove

	farcall CheckIfArenaCardCanKnockOutDefendingCard_CheckHand
	ld b, PLAY_AREA_BENCH_1
	jr c, .check_dce
	ld b, PLAY_AREA_ARENA
.check_dce
	farcall FindDoubleColorlessAttachedToPlayerPokemonInPlayArea
	jr nc, .check_can_ko
	ld [wTempAIMultiTargetCardDeckIndex1], a
	ld a, b
	scf
	ret

.check_can_ko
	farcall CheckIfArenaCardCanKnockOutDefendingCard_CheckHand
	ccf
	ret nc

	ld e, PLAY_AREA_ARENA
	call SwapTurn
	farcall CountNumberOfEnergyCardsAttached_IgnoreRecycleEnergy
	call SwapTurn
	or a
	ret z

	xor a
	ldh [hTempPlayAreaLocation_ff9d], a ; PLAY_AREA_ARENA
	ld [wSelectedAttack], a ; FIRST_ATTACK_OR_PKMN_POWER
	call SwapTurn
	farcall CanRemovingEnergyReduceDamage
	call SwapTurn
	ret nc

	ld a, SECOND_ATTACK
	ld [wSelectedAttack], a
	call SwapTurn
	farcall CanRemovingEnergyReduceDamage
	call SwapTurn
	ret nc

	xor a ; PLAY_AREA_ARENA
.pick_energy_to_remove
	push af
	call SwapTurn
	farcall PickAttachedEnergyCardToRemove
	call SwapTurn
	ld [wTempAIMultiTargetCardDeckIndex1], a
	pop af
	scf
	ret

; search player's play area for pkmn with >= a HP remaining and any non-recycle energy attached
; return carry and its location if found
; input:
; a = HP threshold
; b = starting PLAY_AREA_* location
; output:
; a = found location
FindPlayerPokemonInPlayAreaWithEnoughHPAndNonRecycleEnergy:
	ld c, a
	call SwapTurn
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	ld d, a
	ld e, b
.loop_play_area
	ld a, e
	add DUELVARS_ARENA_CARD_HP
	get_turn_duelist_var
	cp c
	jr c, .next
	farcall CountNumberOfEnergyCardsAttached_IgnoreRecycleEnergy
	or a
	jr z, .next

; found
	call SwapTurn
	ld a, e
	scf
	ret

.next
	inc e
	ld a, e
	cp d
	jr nz, .loop_play_area

; not found
	call SwapTurn
	or a
	ret

BigThunderDeckAIDecideEnergyRetrieval:
	farcall CountEnergyCardsInHand
	ret nc

	ld a, CARD_LOCATION_DISCARD_PILE
	farcall CreateBasicEnergyCardListInLocation
	ccf
	ret nc

	ld a, [wDuelTempList]
	ld [wTempAIMultiTargetCardDeckIndex1], a
	ld a, [wDuelTempList + 1]
	ld [wTempAIMultiTargetCardDeckIndex2], a

; find discard card
	call CreateHandCardList
	ld hl, wDuelTempList
	ld de, wTempCardCollection
.loop_copy
	ld a, [hli]
	ld [de], a
	inc de
	cp $ff
	jr nz, .loop_copy

	ld hl, wTempCardCollection
.loop_hand_cards
	ld a, [hl]
	cp $ff
	jp z, .no_carry
	push hl
	call GetCardIDFromDeckIndex
; try energy removal
	cp16 ENERGY_REMOVAL
	jr nz, .try_dupe_energy_retrieval
	ld a, 10
	ld b, PLAY_AREA_ARENA
	call FindPlayerPokemonInPlayAreaWithEnoughHPAndNonRecycleEnergy
	jr nc, .found_discard_card
	jr .next_card
.try_dupe_energy_retrieval
	cp16 ENERGY_RETRIEVAL
	jr nz, .try_other_trainers
	ld de, ENERGY_RETRIEVAL
	farcall LookForCardIDInHandList_IgnoreTrainerCardToPlay
	jr c, .found_discard_card
	jr .next_card
.try_other_trainers
	cp16 SUPER_ENERGY_REMOVAL
	jr z, .found_discard_card
	cp16 SCOOP_UP
	jr z, .found_discard_card
	cp16 POKEMON_TRADER
	jr z, .try_pkmn_trader_or_master_ball
	cp16 MASTER_BALL
	jr nz, .next_card
.try_pkmn_trader_or_master_ball
	ld de, ZAPDOS_LV68
	farcall CountCardIDInHand
	push af
	ld de, ZAPDOS_LV68
	ld b, PLAY_AREA_ARENA
	farcall CountCardIDInTurnDuelistPlayArea
	pop bc
	add b
	cp 2
	jr nc, .found_discard_card
.next_card
	pop hl
	inc hl
	jp .loop_hand_cards

.found_discard_card
	pop hl
	ld a, [hl]
	scf
	ret

.no_carry
	or a
	ret

; Switch or Scoop Up?
BigThunderDeckAIDecideScoopUp:
	farcall CheckIfArenaCardCanKnockOutDefendingCard_CheckHand
	ccf
	ret nc

	ld de, ZAPDOS_LV68
	ld b, PLAY_AREA_BENCH_1
	farcall CountCardIDInTurnDuelistPlayArea
	or a
	ret z

	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call GetCardIDFromDeckIndex
	cp16 DITTO
	ld a, 20
	jr z, .check_hp
; zapdos or chansey
	ld a, 50
.check_hp
	push af
	ld a, DUELVARS_ARENA_CARD_HP
	get_turn_duelist_var
	pop bc
	cp b
	jr z, .check_switch
	ret nc

.check_switch
	farcall AIDecideBenchPokemonToSwitchTo
	jr nc, .can_switch
	or a
	ret

.can_switch
	ld [wTempAIMultiTargetCardDeckIndex1], a
	xor a
	scf
	ret

BigThunderDeckAIDecidePokemonTrader:
	ld de, ZAPDOS_LV68
	farcall CountCardIDInHand
	push af
	ld de, ZAPDOS_LV68
	ld b, PLAY_AREA_ARENA
	farcall CountCardIDInTurnDuelistPlayArea
	pop bc
	add b
	cp 2
	ret nc

	ld de, ZAPDOS_LV68
	ld a, CARD_LOCATION_DECK
	farcall FindCardIDInLocation
	ret nc

	ld [wTempAIMultiTargetCardDeckIndex1], a

	ld de, DITTO
	farcall LookForCardIDInHandList
	ret c

	ld de, CHANSEY_LV55
	farcall LookForCardIDInHandList
	ret

BigThunderDeckAIDecideMasterBall:
	ld de, ZAPDOS_LV68
	farcall CountCardIDInHand
	push af
	ld de, ZAPDOS_LV68
	ld b, PLAY_AREA_ARENA
	farcall CountCardIDInTurnDuelistPlayArea
	pop bc
	add b
	cp 2
	ret nc

	ld de, ZAPDOS_LV68
	farcall AITryMasterBall_GivenTarget
	ret c

	ld de, DITTO
	farcall AITryMasterBall_GivenTarget
	ret c

	ld de, CHANSEY_LV55
	farcall AITryMasterBall_GivenTarget
	ret

; simplified version of DiscountInapplicablePoisonFromDamage
; always discount single psn damage from a
DiscountPoisonFromDamage:
	push af
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call GetCardIDFromDeckIndex
	cp16 BULBASAUR_LV15
	jr z, .second_attack_poison
	cp16 WEEDLE_LV15
	jr z, .second_attack_poison
	cp16 EKANS_LV10
	jr z, .first_attack_poison
	cp16 ODDISH_LV21
	jr z, .second_attack_poison
	cp16 GLOOM
	jr z, .first_attack_poison
	cp16 DARK_GLOOM
	jr z, .second_attack_poison
	jr .no_discount

.first_attack_poison
	ld a, [wSelectedAttack]
	or a
	jr nz, .no_discount
	jr .discount_psn

.second_attack_poison
	ld a, [wSelectedAttack]
	or a
	jr nz, .discount_psn

.no_discount
	pop af
	ret

.discount_psn
	pop af
	sub PSN_DAMAGE
	ret nc
; cap at 0
	xor a
	ret

AIOpponentPersonalities:
	db PERSONALITY_EMOTIONLESS ; SAMS_PRACTICE_DECK_ID
	db PERSONALITY_EMOTIONLESS ; PLAYER_PRACTICE_DECK_ID
	db PERSONALITY_EMOTIONLESS ; STARTER_DECK_ID
	db PERSONALITY_EMOTIONLESS ; SWEAT_ANTI_GR1_DECK_ID
	db PERSONALITY_EMOTIONLESS ; GIVE_IN_ANTI_GR2_DECK_ID
	db PERSONALITY_EMOTIONLESS ; VENGEFUL_ANTI_GR3_DECK_ID
	db PERSONALITY_STANDARD    ; UNFORGIVING_ANTI_GR4_DECK_ID
	db PERSONALITY_EMOTIONLESS ; UNUSED_SAMS_PRACTICE_DECK_ID
	db PERSONALITY_EMOTIONAL   ; AARON_PRACTICE_DECK1_ID
	db PERSONALITY_EMOTIONLESS ; AARONS_STEP1_DECK_ID
	db PERSONALITY_EMOTIONAL   ; AARON_PRACTICE_DECK2_ID
	db PERSONALITY_EMOTIONLESS ; AARONS_STEP2_DECK_ID
	db PERSONALITY_EMOTIONAL   ; AARON_PRACTICE_DECK3_ID
	db PERSONALITY_EMOTIONLESS ; AARONS_STEP3_DECK_ID
	db PERSONALITY_EMOTIONAL   ; BRICK_WALK_DECK_ID
	db PERSONALITY_STANDARD    ; BENCH_TRAP_DECK_ID
	db PERSONALITY_SERIOUS     ; SKY_SPARK_DECK_ID
	db PERSONALITY_STANDARD    ; ELECTRIC_SELFDESTRUCT_DECK_ID
	db PERSONALITY_STANDARD    ; OVERFLOW_DECK_ID
	db PERSONALITY_EMOTIONAL   ; TRIPLE_ZAPDOS_DECK_ID
	db PERSONALITY_STANDARD    ; I_LOVE_PIKACHU_DECK_ID
	db PERSONALITY_EMOTIONLESS ; TEN_THOUSAND_VOLTS_DECK_ID
	db PERSONALITY_EMOTIONAL   ; HAND_OVER_GR_DECK_ID
	db PERSONALITY_SERIOUS     ; PSYCHIC_ELITE_DECK_ID
	db PERSONALITY_STANDARD    ; PSYCHOKINESIS_DECK_ID
	db PERSONALITY_STANDARD    ; PHANTOM_DECK_ID
	db PERSONALITY_SERIOUS     ; PUPPET_MASTER_DECK_ID
	db PERSONALITY_STANDARD    ; EVEN3_YEARS_ON_A_ROCK_DECK_ID
	db PERSONALITY_EMOTIONAL   ; ROLLING_STONE_DECK_ID
	db PERSONALITY_SERIOUS     ; GREAT_EARTHQUAKE_DECK_ID
	db PERSONALITY_STANDARD    ; AWESOME_FOSSIL_DECK_ID
	db PERSONALITY_STANDARD    ; RAGING_BILLOW_OF_FISTS_DECK_ID
	db PERSONALITY_EMOTIONAL   ; YOU_CAN_DO_IT_MACHOP_DECK_ID
	db PERSONALITY_EMOTIONAL   ; NEW_MACHOKE_DECK_ID
	db PERSONALITY_STANDARD    ; SKILLED_WARRIOR_DECK_ID
	db PERSONALITY_STANDARD    ; I_LOVE_TO_FIGHT_DECK_ID
	db PERSONALITY_EMOTIONAL   ; MAX_ENERGY_DECK_ID
	db PERSONALITY_EMOTIONAL   ; REMAINING_GREEN_DECK_ID
	db PERSONALITY_STANDARD    ; POISON_CURSE_DECK_ID
	db PERSONALITY_STANDARD    ; GLITTERING_SCALES_DECK_ID
	db PERSONALITY_SERIOUS     ; STEADY_INCREASE_DECK_ID
	db PERSONALITY_STANDARD    ; DARK_SCIENCE_DECK_ID
	db PERSONALITY_SERIOUS     ; NATURAL_SCIENCE_DECK_ID
	db PERSONALITY_STANDARD    ; POISONOUS_SWAMP_DECK_ID
	db PERSONALITY_SERIOUS     ; GATHERING_NIDORAN_DECK_ID
	db PERSONALITY_SERIOUS     ; RAIN_DANCE_CONFUSION_DECK_ID
	db PERSONALITY_EMOTIONAL   ; CONSERVING_WATER_DECK_ID
	db PERSONALITY_SERIOUS     ; ENERGY_REMOVAL_DECK_ID
	db PERSONALITY_EMOTIONAL   ; SPLASHING_ABOUT_DECK_ID
	db PERSONALITY_EMOTIONAL   ; BEACH_DECK_ID
	db PERSONALITY_SERIOUS     ; GO_ARCANINE_DECK_ID
	db PERSONALITY_STANDARD    ; FLAME_FESTIVAL_DECK_ID
	db PERSONALITY_EMOTIONAL   ; IMMORTAL_FLAME_DECK_ID
	db PERSONALITY_EMOTIONAL   ; ELECTRIC_CURRENT_SHOCK_DECK_ID
	db PERSONALITY_EMOTIONAL   ; GREAT_ROCKET4_DECK_ID
	db PERSONALITY_SERIOUS     ; GREAT_ROCKET1_DECK_ID
	db PERSONALITY_SERIOUS     ; GREAT_ROCKET2_DECK_ID
	db PERSONALITY_EMOTIONAL   ; GREAT_ROCKET3_DECK_ID
	db PERSONALITY_EMOTIONAL   ; GRAND_FIRE_DECK_ID
	db PERSONALITY_STANDARD    ; LEGENDARY_FOSSIL_DECK_ID
	db PERSONALITY_SERIOUS     ; WATER_LEGEND_DECK_ID
	db PERSONALITY_STANDARD    ; GREAT_DRAGON_DECK_ID
	db PERSONALITY_EMOTIONAL   ; BUG_COLLECTING_DECK_ID
	db PERSONALITY_STANDARD    ; DEMONIC_FOREST_DECK_ID
	db PERSONALITY_EMOTIONAL   ; STICKY_POISON_GAS_DECK_ID
	db PERSONALITY_STANDARD    ; MAD_PETALS_DECK_ID
	db PERSONALITY_EMOTIONAL   ; DANGEROUS_BENCH_DECK_ID
	db PERSONALITY_SERIOUS     ; CHAIN_LIGHTNING_BY_PIKACHU_DECK_ID
	db PERSONALITY_EMOTIONAL   ; THIS_IS_THE_POWER_OF_ELECTRICITY_DECK_ID
	db PERSONALITY_STANDARD    ; QUICK_ATTACK_DECK_ID
	db PERSONALITY_EMOTIONAL   ; COMPLETE_COMBUSTION_DECK_ID
	db PERSONALITY_STANDARD    ; FIREBALL_DECK_ID
	db PERSONALITY_SERIOUS     ; EEVEE_SHOWDOWN_DECK_ID
	db PERSONALITY_EMOTIONAL   ; GAZE_UPON_THE_POWER_OF_FIRE_DECK_ID
	db PERSONALITY_STANDARD    ; WHIRLPOOL_SHOWER_DECK_ID
	db PERSONALITY_EMOTIONAL   ; PARALYZED_PARALYZED_DECK_ID
	db PERSONALITY_STANDARD    ; BENCH_CALL_DECK_ID
	db PERSONALITY_EMOTIONAL   ; WATER_STREAM_DECK_ID
	db PERSONALITY_STANDARD    ; ROCK_BLAST_DECK_ID
	db PERSONALITY_SERIOUS     ; FULL_STRENGTH_DECK_ID
	db PERSONALITY_EMOTIONAL   ; RUNNING_WILD_DECK_ID
	db PERSONALITY_EMOTIONAL   ; DIRECT_HIT_DECK_ID
	db PERSONALITY_STANDARD    ; SUPERDESTRUCTIVE_POWER_DECK_ID
	db PERSONALITY_SERIOUS     ; BAD_DREAM_DECK_ID
	db PERSONALITY_STANDARD    ; POKEMON_POWER_DECK_ID
	db PERSONALITY_STANDARD    ; SPIRITED_AWAY_DECK_ID
	db PERSONALITY_EMOTIONAL   ; SNORLAX_GUARD_DECK_ID
	db PERSONALITY_SERIOUS     ; EYE_OF_THE_STORM_DECK_ID
	db PERSONALITY_STANDARD    ; SUDDEN_GROWTH_DECK_ID
	db PERSONALITY_SERIOUS     ; VERY_RARE_CARD_DECK_ID
	db PERSONALITY_STANDARD    ; BAD_GUYS_DECK_ID
	db PERSONALITY_STANDARD    ; POISON_MIST_DECK_ID
	db PERSONALITY_STANDARD    ; ULTRA_REMOVAL_DECK_ID
	db PERSONALITY_STANDARD    ; PSYCHIC_BATTLE_DECK_ID
	db PERSONALITY_STANDARD    ; STOP_LIFE_DECK_ID
	db PERSONALITY_STANDARD    ; SCORCHER_DECK_ID
	db PERSONALITY_STANDARD    ; TSUNAMI_STARTER_DECK_ID
	db PERSONALITY_STANDARD    ; SMASH_TO_MINCEMEAT_DECK_ID
	db PERSONALITY_STANDARD    ; TEST_YOUR_LUCK_DECK_ID
	db PERSONALITY_STANDARD    ; PROTOHISTORIC_DECK_ID
	db PERSONALITY_STANDARD    ; TEXTURE_TUNER7_DECK_ID
	db PERSONALITY_STANDARD    ; COLORLESS_ENERGY_DECK_ID
	db PERSONALITY_EMOTIONAL   ; POWERFUL_POKEMON_DECK_ID
	db PERSONALITY_EMOTIONAL   ; WEIRD_DECK_ID
	db PERSONALITY_SERIOUS     ; STRANGE_DECK_ID
	db PERSONALITY_SERIOUS     ; RONALDS_UNCOOL_DECK_ID
	db PERSONALITY_SERIOUS     ; RONALDS_GRX_DECK_ID
	db PERSONALITY_SERIOUS     ; RONALDS_POWER_DECK_ID
	db PERSONALITY_SERIOUS     ; RONALDS_PSYCHIC_DECK_ID
	db PERSONALITY_EMOTIONAL   ; RONALDS_ULTRA_DECK_ID
	db PERSONALITY_SERIOUS     ; EVERYBODYS_FRIEND_DECK_ID
	db PERSONALITY_STANDARD    ; IMMORTAL_POKEMON_DECK_ID
	db PERSONALITY_SERIOUS     ; TORRENTIAL_FLOOD_DECK_ID
	db PERSONALITY_STANDARD    ; TRAINER_IMPRISON_DECK_ID
	db PERSONALITY_EMOTIONAL   ; BLAZING_FLAME_DECK_ID
	db PERSONALITY_EMOTIONAL   ; DAMAGE_CHAOS_DECK_ID
	db PERSONALITY_STANDARD    ; BIG_THUNDER_DECK_ID
	db PERSONALITY_EMOTIONAL   ; POWER_OF_DARKNESS_DECK_ID
	db PERSONALITY_STANDARD    ; POISON_STORM_DECK_ID
	db PERSONALITY_STANDARD    ; DECK_7269_ID

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

PrizeCountPersonalityEmotionMatrix:
	;  PERSONALITY_STANDARD    PERSONALITY_SERIOUS     PERSONALITY_EMOTIONAL  ; prize count difference
	db EMOTION_SAD,            EMOTION_SAD,            EMOTION_SAD    ; -6 ; player lead
	db EMOTION_SAD,            EMOTION_SAD,            EMOTION_SAD    ; -5
	db EMOTION_SAD,            EMOTION_SAD,            EMOTION_SAD    ; -4
	db EMOTION_SAD,            EMOTION_NORMAL,         EMOTION_SAD    ; -3
	db EMOTION_NORMAL,         EMOTION_NORMAL,         EMOTION_SAD    ; -2
	db EMOTION_NORMAL,         EMOTION_NORMAL,         EMOTION_NORMAL ; -1
	db EMOTION_NORMAL,         EMOTION_NORMAL,         EMOTION_HAPPY  ;  0 ; neutral
	db EMOTION_HAPPY,          EMOTION_NORMAL,         EMOTION_HAPPY  ;  1
	db EMOTION_HAPPY,          EMOTION_HAPPY,          EMOTION_HAPPY  ;  2
	db EMOTION_HAPPY,          EMOTION_HAPPY,          EMOTION_HAPPY  ;  3
	db EMOTION_HAPPY,          EMOTION_HAPPY,          EMOTION_HAPPY  ;  4 ; opp lead

; adjust max damage estimate in a
; see also DiscountInapplicablePoisonFromDamage
DiscountInapplicablePoisonFromMaxDamage:
	push af
	ld a, [wSpecialRule]
	cp CHLOROPHYLL
	jr nz, .check_thick_skinned
	call SwapTurn
	bank1call GetArenaCardColor
	call SwapTurn
	cp GRASS
	jr nz, .check_thick_skinned

; Chlorophyll applies
	ld a, ATTACK_FLAG1_ADDRESS | INFLICT_POISON_F
	call CheckLoadedAttackFlag
	jr c, .discount_psn
	pop af
	ret

.discount_psn
	pop af
	sub PSN_DAMAGE
	jp c, .cap_at_zero
	ret

.check_thick_skinned
	call SwapTurn
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call GetCardIDFromDeckIndex
	call SwapTurn
	cp16 SNORLAX_LV20
	jr nz, .check_status
	xor a ; PLAY_AREA_ARENA
	call SwapTurn
	bank1call CheckIsIncapableOfUsingPkmnPower
	call SwapTurn
	jr c, .check_status

; Thick Skinned is active
	ld a, ATTACK_FLAG1_ADDRESS | INFLICT_POISON_F
	call CheckLoadedAttackFlag
	jr c, .discount_psn

; already poisoned?
.check_status
	ld a, DUELVARS_ARENA_CARD_STATUS
	call GetNonTurnDuelistVariable
	and PSN_DBLPSN
	cp DOUBLE_POISONED
	jr nz, .check_poison_mist

.discount_dbl_psn
	pop af
	sub DBLPSN_DAMAGE
	jr c, .cap_at_zero
	ret

.check_poison_mist
	cp POISONED
	jr nz, .no_discount
	bank1call IsPoisonMistActive
	jr c, .discount_dbl_psn

; discount psn 2
	pop af
	sub PSN_DAMAGE
	jr c, .cap_at_zero
	ret

.cap_at_zero
	xor a
	ret

.no_discount
	pop af
	ret

; same as CheckIfCanEvolveInto but doesn't consider
; the CAN_EVOLVE_THIS_TURN flag
CheckIfEvolvesInto:
	push de
	ld a, e
	add DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call LoadCardDataToBuffer2_FromDeckIndex
	ld a, d
	call LoadCardDataToBuffer1_FromDeckIndex
	ld a, [wLoadedCard1Type]
	cp TYPE_ENERGY
	jr nc, .cant_evolve
	ld hl, wLoadedCard2Name
	ld de, wLoadedCard1PreEvoName
	ld a, [de]
	cp [hl]
	jr nz, .cant_evolve ; jump if they are incompatible to evolve
	inc de
	inc hl
	ld a, [de]
	cp [hl]
	jr nz, .cant_evolve ; jump if they are incompatible to evolve
	pop de
	or a
	ret
.cant_evolve
	pop de
	xor a
	scf
	ret

ChainLightningByPikachuDeckAIDecideMasterBall:
	ld de, RAICHU_LV32
	farcall LookForCardIDInHandList
	jr nc, .try_evo_cards
	ld de, DARK_JOLTEON
	farcall LookForCardIDInHandList
	jr nc, .try_evo_cards
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	cp 2
	jr c, .try_basic_pkmn
	farcall CountNumberOfBasicPokemonInHand
	or a
	ret nz

.try_evo_cards
	ld de, RAICHU_LV32
	farcall AITryMasterBall_GivenTarget
	ret c
	ld de, DARK_JOLTEON
	farcall AITryMasterBall_GivenTarget
	ret c
; check fighting-type evo lines
	ld bc, SANDSHREW_LV12
	ld de, SANDSLASH_LV35
	farcall LookForEvoCardInDeck_GivenPreevoInHandOrPlayArea
	jr nc, .check_marowak
	ld de, SANDSLASH_LV35
	farcall AITryMasterBall_GivenTarget
	ret c
.check_marowak
	ld bc, CUBONE_LV14
	ld de, MAROWAK_LV26
	farcall LookForEvoCardInDeck_GivenPreevoInHandOrPlayArea
	jr nc, .try_basic_pkmn
	ld de, MAROWAK_LV26
	farcall AITryMasterBall_GivenTarget
	ret c

.try_basic_pkmn
	ld de, ELECTABUZZ_LV35
	farcall AITryMasterBall_GivenTarget
	ret c
	ld de, PIKACHU_LV13
	farcall AITryMasterBall_GivenTarget
	ret c
	ld de, PIKACHU_LV5
	farcall AITryMasterBall_GivenTarget
	ret c
	ld de, SANDSHREW_LV12
	farcall AITryMasterBall_GivenTarget
	ret c
	ld de, CUBONE_LV14
	farcall AITryMasterBall_GivenTarget
	ret c
	farcall AITryMasterBall
	ret

; return carry if in KO range of poison damage within the next two between-turn steps
CanBeKnockedOutByTwicePoisonDamage:
	ld a, DUELVARS_ARENA_CARD_STATUS
	get_turn_duelist_var
	and PSN_DBLPSN
	cp DOUBLE_POISONED
	jr nz, .check_single

.double
	ld a, DBLPSN_DAMAGE * 2
	jr .check_remaining_hp

.check_single
	cp POISONED
	jr nz, .not_psn
; check Poison Mist
	bank1call IsPoisonMistActive
	jr c, .double

; single
	ld a, PSN_DAMAGE * 2

.check_remaining_hp
	push af
	ld a, DUELVARS_ARENA_CARD_HP
	get_turn_duelist_var
	ld b, a
	pop af
	cp b
	ccf
	ret

.not_psn
	or a
	ret

PoisonMistDeckAIDecideSwitch:
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call GetCardIDFromDeckIndex
	cp16 DARK_MUK
	jr z, .dark_muk_arena
	cp16 WEEZING_LV26
	jr z, .weezing_arena
	cp16 MR_MIME_LV20
	jr z, .check_switch

.no_carry
	or a
	ret

.dark_muk_arena
	ld a, DUELVARS_ARENA_CARD_STATUS
	get_turn_duelist_var
	or a
	ret z
; statused
	jr .check_switch

.weezing_arena
	farcall CanArenaCardUseNonResidualAttack
	jr c, .no_carry
	ld a, DUELVARS_ARENA_CARD_HP
	get_turn_duelist_var
	cp 60 ; default max HP of Weezing Lv.26
	jr nc, .no_carry
	ld de, WEEZING_LV26
	ld b, PLAY_AREA_BENCH_1
	farcall FindCardIDInTurnDuelistsPlayArea
	jr c, .no_carry

.check_switch
	farcall AIDecideBenchPokemonToSwitchTo
	ccf
	ret

; return carry if player's active pkmn is Mr. Mime Lv.28 with active Invisible Wall
IsInvisibleWallActiveInPlayerArena:
	xor a ; PLAY_AREA_ARENA
	call SwapTurn
	bank1call CheckIsIncapableOfUsingPkmnPower
	jr c, .no_carry
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call GetCardIDFromDeckIndex
	cp16 MR_MIME_LV28
	jr nz, .no_carry
; set carry
	call SwapTurn
	scf
	ret
.no_carry
	call SwapTurn
	or a
	ret
