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

INCLUDE "engine/duel/ai/spread_attacks.asm"

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

AIDecide_ProfessorOak_PsychicBattleDeck:
	; if 16 or fewer cards remaining in deck, don't use
	ld a, DUELVARS_NUMBER_OF_CARDS_NOT_IN_DECK
	get_turn_duelist_var
	cp DECK_SIZE - 16
	ret nc

	; count number of turns AI has played (half of wDuelTurns)
	ld a, [wDuelTurns]
	srl a
	cp 3
	jr c, .less_than_3_turns
	; has played at least 3 turns, don't use
	; if number of cards in hand is 5 or more
	ld a, DUELVARS_NUMBER_OF_CARDS_IN_HAND
	get_turn_duelist_var
	cp 5
	ret nc
.less_than_3_turns
	; if has at least 3 energy cards in hand, don't use
	farcall CountEnergyCardsInHand
	cp 3
	ret nc

	; create working copy of hand
	call CreateHandCardList
	ld hl, wDuelTempList
	ld de, wWorkingDuelTempList
.loop_copy
	ld a, [hli]
	ld [de], a
	inc de
	cp $ff
	jr nz, .loop_copy

	ld hl, wWorkingDuelTempList
.loop_cards
	ld a, [hli]
	cp $ff
	jp z, .set_carry
	push hl
	call GetCardIDFromDeckIndex
	; continue if is Professor Oak card
	cp16 PROFESSOR_OAK
	jr z, .next_card
	; if this card is already found in Play Area, continue
	push de
	ld b, PLAY_AREA_ARENA
	farcall FindCardIDInTurnDuelistsPlayArea
	pop de
	jr c, .next_card
	; if is Switch or Energy Retrieval, continue
	cp16 SWITCH
	jr z, .next_card
	cp16 ENERGY_RETRIEVAL
	jr z, .next_card
	; if none of those are true, don't use Professor Oak
	pop hl
	or a
	ret
.next_card
	pop hl
	jp .loop_cards

.set_carry
	; use Professor Oak
	scf
	ret

; PsychicBattleDeckAI?
AIDecide_EnergyRetrieval_PsychicBattleDeck:
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

AIDecide_GustOfWind_PsychicBattleDeck:
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

AIDecide_EnergyRemoval_BigThunderDeck:
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
	ld [wAITrainerCardArgs + 1], a
	ld a, b
	scf
	ret

.check_can_ko
	farcall CheckIfArenaCardCanKnockOutDefendingCard_CheckHand
	ccf
	ret nc

	ld e, PLAY_AREA_ARENA
	call SwapTurn
	farcall CountEnergyRemovalEnergyCardTargets
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
	ld [wAITrainerCardArgs + 1], a
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
	farcall CountEnergyRemovalEnergyCardTargets
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

AIDecide_EnergyRetrieval_BigThunderDeck:
	farcall CountEnergyCardsInHand
	ret nc

	ld a, CARD_LOCATION_DISCARD_PILE
	farcall CreateBasicEnergyCardListInLocation
	ccf
	ret nc

	ld a, [wDuelTempList]
	ld [wAITrainerCardArgs + 1], a
	ld a, [wDuelTempList + 1]
	ld [wAITrainerCardArgs + 2], a

; pick discard card
	call CreateHandCardList
	ld hl, wDuelTempList
	ld de, wWorkingDuelTempList
.loop_copy
	ld a, [hli]
	ld [de], a
	inc de
	cp $ff
	jr nz, .loop_copy

	ld hl, wWorkingDuelTempList
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

AIDecide_ScoopUp_BigThunderDeck:
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
	ld [wAITrainerCardArgs + 1], a
	xor a
	scf
	ret

AIDecide_PokemonTrader_BigThunderDeck:
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

	ld [wAITrainerCardArgs + 1], a

	ld de, DITTO
	farcall LookForCardIDInHandList
	ret c

	ld de, CHANSEY_LV55
	farcall LookForCardIDInHandList
	ret

AIDecide_MasterBall_BigThunderDeck:
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

INCLUDE "data/duel/ai_personalities.asm"
INCLUDE "engine/duel/ai/emotions.asm"
INCLUDE "data/duel/ai_emotions.asm"

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

AIDecide_MasterBall_ChainLightningByPikachuDeck:
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

; returns carry if Arena card is KO'd by poison damage
; after this turn and the next (2 turns of damage)
CheckIfPoisonDamageKOsArenaPkmn:
	ld a, DUELVARS_ARENA_CARD_STATUS
	get_turn_duelist_var
	and PSN_DBLPSN
	cp DOUBLE_POISONED
	jr nz, .not_dbl_psn
.dbl_psn_or_poison_mist
	ld a, 2 * 20
	jr .got_psn_damage
.not_dbl_psn
	cp POISONED
	jr nz, .no_carry
	bank1call IsPoisonMistActive
	jr c, .dbl_psn_or_poison_mist
	ld a, 2 * 10
.got_psn_damage
	push af
	ld a, DUELVARS_ARENA_CARD_HP
	get_turn_duelist_var
	ld b, a
	pop af
	cp b
	ccf
	; carry if a >= b
	ret

.no_carry
	or a
	ret

AIDecide_Switch_PoisonMistDeck:
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call GetCardIDFromDeckIndex
	cp16 DARK_MUK
	jr z, .dark_muk
	cp16 WEEZING_LV26
	jr z, .weezing
	cp16 MR_MIME_LV20
	jr z, .switch

.no_carry
	or a
	ret

.dark_muk
	; if Dark Muk has status, use Switch
	ld a, DUELVARS_ARENA_CARD_STATUS
	get_turn_duelist_var
	or a
	ret z
	jr .switch

.weezing
	; if Weezing cannot attack...
	farcall CanArenaCardUseNonResidualAttack
	jr c, .no_carry
	; ...and its HP is below 60...
	ld a, DUELVARS_ARENA_CARD_HP
	get_turn_duelist_var
	cp 60
	jr nc, .no_carry
	; ...and there's no other Weezing in bench, use Switch
	ld de, WEEZING_LV26
	ld b, PLAY_AREA_BENCH_1
	farcall FindCardIDInTurnDuelistsPlayArea
	jr c, .no_carry
.switch
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
