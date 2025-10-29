; handle AI routines for Energy Trans.
; uses AI_ENERGY_TRANS_* constants as input:
;	- AI_ENERGY_TRANS_RETREAT: transfers enough Grass Energy cards to
;	Arena Pokemon for it to be able to pay the Retreat Cost;
;	- AI_ENERGY_TRANS_ATTACK: transfers enough Grass Energy cards to
;	Arena Pokemon for it to be able to use its second attack;
;	- AI_ENERGY_TRANS_TO_BENCH: transfers all Grass Energy cards from
;	Arena Pokemon to Bench in case Arena card will be KO'd.
HandleAIEnergyTrans:
	ld [wd082], a

	farcall StubbedAIChooseRandomlyNotToDoAction
	ret c

	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	dec a
	ret z ; return if no Bench cards

	ld de, VENUSAUR_LV67
	ld b, PLAY_AREA_ARENA
	farcall FindCardIDInTurnDuelistsPlayArea
	ret nc ; return if no VenusaurLv67 found in own Play Area

	bank1call CheckIsIncapableOfUsingPkmnPower
	ret c ; return if cannot use Energy Trans

	ld a, [wd082]
	cp AI_ENERGY_TRANS_RETREAT
	jr z, .check_retreat

	cp AI_ENERGY_TRANS_TO_BENCH
	jp z, AIEnergyTransTransferEnergyToBench

	; AI_ENERGY_TRANS_ATTACK
	call .CheckEnoughGrassEnergyCardsForAttack
	ret nc
	jr .TransferEnergyToArena

.check_retreat
	call .CheckEnoughGrassEnergyCardsForRetreatCost
	ret nc

; use Energy Trans to transfer number of Grass energy cards
; equal to input a from the Bench to the Arena card.
.TransferEnergyToArena
	ld [wd082], a

; look for VenusaurLv67 in Play Area
; so that its PKMN Power can be used.
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	dec a
	ld b, a
.loop_play_area
	ld a, DUELVARS_ARENA_CARD
	add b
	get_turn_duelist_var
	ldh [hTempCardIndex_ff9f], a
	call GetCardIDFromDeckIndex
	cp16 VENUSAUR_LV67
	jr z, .use_pkmn_power

	ld a, b
	or a
	ret z ; return when finished Play Area loop

	dec b
	jr .loop_play_area

.use_pkmn_power
	ld a, b
	ldh [hTemp_ffa0], a
	ld a, OPPACTION_USE_PKMN_POWER
	farcall AIMakeDecision
	ld a, OPPACTION_EXECUTE_PKMN_POWER_EFFECT
	farcall AIMakeDecision

	xor a
	ldh [hAIEnergyTransPlayAreaLocation], a
	ld a, [wd082]
	ld d, a

	ld e, 0
.loop_deck_locations
	ld a, DUELVARS_CARD_LOCATIONS
	add e
	get_turn_duelist_var
	and %00011111
	cp CARD_LOCATION_BENCH_1
	jr c, .next_card

	and %00001111
	ldh [hAIPkmnPowerEffectParam], a

	ld a, e
	push de
	call GetCardIDFromDeckIndex
	cp16 GRASS_ENERGY
	pop de
	jr nz, .next_card

	; store the deck index of energy card
	ld a, e
	ldh [hTempRetreatCostCards], a

	push de
	ld d, 30
.small_delay_loop
	call DoFrame
	dec d
	jr nz, .small_delay_loop

	ld a, OPPACTION_6B15
	farcall AIMakeDecision
	pop de
	dec d
	jr z, .done_transfer

.next_card
	inc e
	ld a, DECK_SIZE
	cp e
	jr nz, .loop_deck_locations

; transfer is done, perform delay
; and return to main scene.
.done_transfer
	ld d, 60
.big_delay_loop
	call DoFrame
	dec d
	jr nz, .big_delay_loop
	ld a, OPPACTION_DUEL_MAIN_SCENE
	farcall AIMakeDecision
	ret

; checks if the Arena card needs energy for its second attack,
; and if it does, return carry if transferring Grass energy from Bench
; would be enough to use it. Outputs number of energy cards needed in a.
.CheckEnoughGrassEnergyCardsForAttack:
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call GetCardIDFromDeckIndex
	cp16 EXEGGUTOR
	jr z, .is_exeggutor

	xor a ; PLAY_AREA_ARENA
	ldh [hTempPlayAreaLocation_ff9d], a
	ld a, SECOND_ATTACK
	ld [wSelectedAttack], a
	farcall CheckEnergyNeededForAttack
	jr nc, .attack_false ; return if no energy needed

; check if colorless energy is needed...
	ld a, c
	or a
	jr nz, .count_if_enough

; ...otherwise check if basic energy card is needed
; and it's grass energy.
	ld a, b
	or a
	jr z, .attack_false
	cp16 GRASS_ENERGY
	jr nz, .attack_false
	ld c, b
	jr .count_if_enough

.attack_false
	or a
	ret

.count_if_enough
; if there's enough Grass energy cards in Bench
; to satisfy the attack energy cost, return carry.
	push bc
	call .CountGrassEnergyInBench
	pop bc
	cp c
	jr c, .attack_false
	ld a, c
	scf
	ret

.is_exeggutor
; in case it's Exeggutor in Arena, return carry
; if there are any Grass energy cards in Bench.
	call .CountGrassEnergyInBench
	or a
	jr z, .attack_false

	scf
	ret

; outputs in a the number of Grass energy cards
; currently attached to Bench cards.
.CountGrassEnergyInBench:
	lb de, 0, 0
.count_loop
	ld a, DUELVARS_CARD_LOCATIONS
	add e
	get_turn_duelist_var
	and %00011111
	cp CARD_LOCATION_BENCH_1
	jr c, .count_next

; is in bench
	ld a, e
	push de
	call GetCardIDFromDeckIndex
	cp16 GRASS_ENERGY
	pop de
	jr nz, .count_next
	inc d
.count_next
	inc e
	ld a, DECK_SIZE
	cp e
	jr nz, .count_loop
	ld a, d
	ret

; returns carry if there are enough Grass energy cards in Bench
; to satisfy the retreat cost of the Arena card.
; if so, output the number of energy cards still needed in a.
.CheckEnoughGrassEnergyCardsForRetreatCost:
	xor a ; PLAY_AREA_ARENA
	ldh [hTempPlayAreaLocation_ff9d], a
	call GetPlayAreaCardRetreatCost
	ld b, a
	xor a ; PLAY_AREA_ARENA
	push bc
	call CreateArenaOrBenchEnergyCardList
	pop bc
	cp b
	jr nc, .retreat_false

; see if there's enough Grass energy cards
; in the Bench to satisfy retreat cost
	ld c, a
	ld a, b
	sub c
	ld c, a
	push bc
	call .CountGrassEnergyInBench
	pop bc
	cp c
	jr c, .retreat_false ; return if less cards than needed

; output number of cards needed to retreat
	ld a, c
	scf
	ret
.retreat_false
	or a
	ret

; AI logic to determine whether to use Energy Trans Pkmn Power
; to transfer energy cards attached from the Arena Pokemon to
; some card in the Bench.
AIEnergyTransTransferEnergyToBench:
	xor a ; PLAY_AREA_ARENA
	ldh [hTempPlayAreaLocation_ff9d], a
	call CheckIfDefendingPokemonCanKnockOut
	ret nc ; return if Defending can't KO

; processes attacks and see if any attack would be used by AI.
; if so, return.
	farcall AIProcessButDontUseAttack
	ret c

; return if Arena card has no Grass energy cards attached.
	ld e, PLAY_AREA_ARENA
	call GetPlayAreaCardAttachedEnergies
	ld a, [wAttachedEnergies + GRASS]
	or a
	ret z

; if no energy card attachment is needed, return.
	farcall AIProcessButDontPlayEnergy_SkipEvolutionAndArena
	ret nc

; AI decided that an energy card is needed
; so look for VenusaurLv67 in Play Area
; so that its PKMN Power can be used.
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	dec a
	ld b, a
.loop_play_area
	ld a, DUELVARS_ARENA_CARD
	add b
	get_turn_duelist_var
	ldh [hTempCardIndex_ff9f], a
	ld [wAIVenusaurLv67DeckIndex], a
	call GetCardIDFromDeckIndex
	cp16 VENUSAUR_LV67
	jr z, .use_pkmn_power

	ld a, b
	or a
	ret z ; return when Play Area loop is ended

	dec b
	jr .loop_play_area

; use Energy Trans Pkmn Power
.use_pkmn_power
	ld a, b
	ldh [hTemp_ffa0], a
	ld [wd07f], a
	ld a, OPPACTION_USE_PKMN_POWER
	farcall AIMakeDecision
	ld a, OPPACTION_EXECUTE_PKMN_POWER_EFFECT
	farcall AIMakeDecision

; loop for each energy cards that are going to be transferred.
.loop_energy
	xor a
	ldh [hAIPkmnPowerEffectParam], a
	ld a, [wd07f]
	ldh [hTemp_ffa0], a

	; returns when Arena card has no Grass energy cards attached.
	ld e, PLAY_AREA_ARENA
	call GetPlayAreaCardAttachedEnergies
	ld a, [wAttachedEnergies + GRASS]
	or a
	jr z, .done_transfer

; look for Grass energy cards that
; are currently attached to Arena card.
	ld e, 0
.loop_deck_locations
	ld a, DUELVARS_CARD_LOCATIONS
	add e
	get_turn_duelist_var
	cp CARD_LOCATION_ARENA
	jr nz, .next_card

	ld a, e
	push de
	call GetCardIDFromDeckIndex
	cp16 GRASS_ENERGY
	pop de
	jr nz, .next_card

	; store the deck index of energy card
	ld a, e
	ldh [hTempRetreatCostCards], a
	jr .transfer

.next_card
	inc e
	ld a, DECK_SIZE
	cp e
	jr nz, .loop_deck_locations
	jr .done_transfer

.transfer
; get the Bench card location to transfer Grass energy card to.
	farcall AIProcessButDontPlayEnergy_SkipEvolutionAndArena
	jr nc, .done_transfer
	ldh a, [hTempPlayAreaLocation_ff9d]
	ldh [hAIEnergyTransPlayAreaLocation], a

	ld d, 30
.small_delay_loop
	call DoFrame
	dec d
	jr nz, .small_delay_loop

	ld a, [wAIVenusaurLv67DeckIndex]
	ldh [hTempCardIndex_ff9f], a
	ld d, a
	ld e, FIRST_ATTACK_OR_PKMN_POWER
	call CopyAttackDataAndDamage_FromDeckIndex
	ld a, OPPACTION_6B15
	farcall AIMakeDecision
	jr .loop_energy

; transfer is done, perform delay
; and return to main scene.
.done_transfer
	ld d, 60
.big_delay_loop
	call DoFrame
	dec d
	jr nz, .big_delay_loop
	ld a, OPPACTION_DUEL_MAIN_SCENE
	farcall AIMakeDecision
	ret

; handles AI logic for using some Pkmn Powers.
; Pkmn Powers handled here are:
;	- Heal;
;	- Shift;
;	- Peek;
;	- Strange Behavior;
;	- Curse
;	- Long-Distance Hypnosis;
;	- Pollen Stench;
;	- Gather Fire;
;	- Evolutionary Light;
;	- Matter Exchange;
;	- Play Tricks;
;	- Fossilize;
;	- Special Delivery;
;	- StepIn.
; returns carry if turn ended.
HandleAIPkmnPowers:
	farcall StubbedAIChooseRandomlyNotToDoAction
	ccf
	ret nc ; return no carry if AI randomly decides to

	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	ld b, a
	ld c, PLAY_AREA_ARENA

.loop_play_area
	ld a, DUELVARS_ARENA_CARD
	add c
	get_turn_duelist_var
	ld [wd084], a

	push af
	push bc
	ld d, a
	ld a, c
	ldh [hTempPlayAreaLocation_ff9d], a
	ld e, FIRST_ATTACK_OR_PKMN_POWER
	call CopyAttackDataAndDamage_FromDeckIndex
	ld a, [wLoadedAttackCategory]
	cp POKEMON_POWER
	jr z, .execute_effect
	pop bc
	jp .next_3

.execute_effect
	ld a, EFFECTCMDTYPE_INITIAL_EFFECT_2
	call TryExecuteEffectCommandFunction
	pop bc
	jp c, .next_3

	; TryExecuteEffectCommandFunction was successful
	; check if this Pokémon can use its Pkmn Power
	push bc
	ldh a, [hTempPlayAreaLocation_ff9d]
	bank1call CheckIsIncapableOfUsingPkmnPower
	pop bc
	jp c, .next_3

	; check what Pkmn Power this is through card's ID.
	pop af
	call GetCardIDFromDeckIndex
	push bc

; heal
	cp16 VILEPLUME
	jr nz, .shift
	call HandleAIHeal
	jp .next_1

.shift
	cp16 VENOMOTH_LV28
	jr nz, .peek
	call HandleAIShift
	jp .next_1

.peek
	cp16 MANKEY_LV7
	jr nz, .strange_behavior
	call HandleAIPeek
	jp .next_1

.strange_behavior
	cp16 SLOWBRO_LV26
	jr nz, .curse
	call HandleAIStrangeBehavior
	jp .next_1

.curse
	cp16 GENGAR_LV38
	jr nz, .long_distance_hypnosis
	call z, HandleAICurse
	jp c, .done
	jp .next_1

.long_distance_hypnosis
	cp16 DROWZEE_LV10
	jr nz, .pollen_stench
	call z, HandleAILongDistanceHypnosis
	jr .next_1

.pollen_stench
	cp16 DARK_GLOOM
	jr nz, .gather_fire
	call z, HandleAIPollenStench
	jr .next_1

.gather_fire
	cp16 CHARMANDER_LV9
	jr nz, .evolutionary_light
	call z, HandleAIGatherFire
	jr .next_1

.evolutionary_light
	cp16 DARK_DRAGONAIR
	jr nz, .matter_exchange
	call z, HandleAIEvolutionaryLight
	jr .next_1

.matter_exchange
	cp16 DARK_KADABRA
	jr nz, .play_tricks
	call z, HandleAIMatterExchange
	jr .next_1

.play_tricks
	cp16 DARK_GENGAR
	jr nz, .fossilize
	call z, HandleAIPlayTricks
	jr .next_1

.fossilize
	cp16 KABUTO_LV22
	jr nz, .special_delivery
	call z, HandleAIFossilize
	jp c, .done
	; number of Pokemon in Play Area changed
	; update count for loop
	pop bc
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	ld b, a
	push bc
	jr .next_1

.special_delivery
	cp16 DRAGONITE_LV43
	jr nz, .step_in
	call z, HandleAISpecialDelivery
	jr .next_1

.step_in
	cp16 DRAGONITE_LV45
	jr nz, .next_1
	call z, HandleAIStepIn

.next_1
	pop bc
.next_2
	inc c
	ld a, c
	cp b
	jp nz, .loop_play_area
	ret

.next_3
	pop af
	jr .next_2

.done
	pop bc
	ret

; checks whether AI uses Heal on Pokemon in Play Area.
; input:
;	c = Play Area location (PLAY_AREA_*) of Vileplume.
HandleAIHeal:
	ld a, c
	ldh [hTemp_ffa0], a
	call .CheckHealTarget
	ret nc ; return if no target to heal
	push af
	ld a, [wd084]
	ldh [hTempCardIndex_ff9f], a
	ld a, OPPACTION_USE_PKMN_POWER
	farcall AIMakeDecision
	pop af
	ldh [hPlayAreaEffectTarget], a
	ld a, OPPACTION_EXECUTE_PKMN_POWER_EFFECT
	farcall AIMakeDecision
	ld a, OPPACTION_DUEL_MAIN_SCENE
	farcall AIMakeDecision
	ret

; finds a target suitable for AI to use Heal on.
; only heals Arena card if the Defending Pokemon
; cannot KO it after Heal is used.
; returns carry if target was found and outputs
; in a the Play Area location of that card.
.CheckHealTarget
; check if Arena card has any damage counters,
; if not, check Bench instead.
	ld e, PLAY_AREA_ARENA
	call GetCardDamageAndMaxHP
	or a
	jr z, .check_bench

	xor a ; PLAY_AREA_ARENA
	ldh [hTempPlayAreaLocation_ff9d], a
	call CheckIfDefendingPokemonCanKnockOut
	jr nc, .set_carry ; return carry if can't KO
	ld d, a
	ld a, DUELVARS_ARENA_CARD_HP
	get_turn_duelist_var
	ld h, a
	ld e, PLAY_AREA_ARENA
	call GetCardDamageAndMaxHP
	; this seems useless since it was already
	; checked that Arena card has damage,
	; so card damage is at least 10.
	cp 10 + 1
	jr c, .check_remaining
	ld a, 10
	; a = min(10, CardDamage)

; checks if Defending Pokemon can still KO
; if Heal is used on this card.
; if Heal prevents KO, return carry.
.check_remaining
	ld l, a
	ld a, h ; load remaining HP
	add l ; add 1 counter to account for heal
	sub d ; subtract damage of strongest opponent attack
	jr c, .check_bench
	jr z, .check_bench

.set_carry
	xor a ; PLAY_AREA_ARENA
	scf
	ret

; check Bench for Pokemon with damage counters
; and find the one with the most damage.
.check_bench
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	ld d, a
	lb bc, 0, 0
	ld e, PLAY_AREA_BENCH_1
.loop_bench
	ld a, e
	cp d
	jr z, .done
	push bc
	call GetCardDamageAndMaxHP
	pop bc
	cp b
	jr c, .next_bench
	jr z, .next_bench
	ld b, a ; store this damage
	ld c, e ; store this Play Area location
.next_bench
	inc e
	jr .loop_bench

; check if a Pokemon with damage counters was found
; in the Bench and, if so, return carry.
.done
	ld a, c
	or a
	jr z, .not_found
; found
	scf
	ret
.not_found
	or a
	ret

; checks whether AI uses Shift.
; input:
;	c = Play Area location (PLAY_AREA_*) of Venomoth
HandleAIShift:
	ld a, c
	or a
	ret nz ; return if Venomoth is not Arena card

	ldh [hTemp_ffa0], a
	bank1call GetArenaCardColor
	call TranslateColorToWR
	ld b, a
	call SwapTurn
	bank1call GetArenaCardWeakness
	ld [wd082], a
	call SwapTurn
	or a
	ret z ; return if Defending Pokemon has no weakness
	and b
	ret nz ; return if Venomoth is already Defending card's weakness type

; check whether there's a card in play with
; the same color as the Player's card weakness
	call .CheckWhetherTurnDuelistHasWRColor
	jr c, .found
	call SwapTurn
	call .CheckWhetherTurnDuelistHasWRColor
	call SwapTurn
	jr nc, .choose_random_color ; no color found

.found
	ld a, [wd084]
	ldh [hTempCardIndex_ff9f], a
	ld a, OPPACTION_USE_PKMN_POWER
	farcall AIMakeDecision

; converts WR_* to appropriate color
	ld a, [wd082]
	ld b, 0
.loop_color
	bit 7, a
	jr nz, .done
	inc b
	rlca
	jr .loop_color

; use Pkmn Power effect
.done
	ld a, b
	ldh [hAIPkmnPowerEffectParam], a
	ld a, OPPACTION_EXECUTE_PKMN_POWER_EFFECT
	farcall AIMakeDecision
	ld a, OPPACTION_DUEL_MAIN_SCENE
	farcall AIMakeDecision
	ret

.choose_random_color
; the AI will decide on a random color
; that is not Defending card's resistance
	xor a
	ld hl, wDuelTempList
	ld [hli], a ; FIRE
	inc a
	ld [hli], a ; GRASS
	inc a
	ld [hli], a ; LIGHTNING
	inc a
	ld [hli], a ; WATER
	inc a
	ld [hli], a ; FIGHTING
	inc a
	ld [hli], a ; PSYCHIC
	ld [hl], $ff
	ld hl, wDuelTempList
	call CountCardsInDuelTempList
	call ShuffleCards
	ld hl, wDuelTempList
.loop_random_color
	ld a, [hl]
	cp $ff
	ret z
	push hl
	call .CheckIfColorIsNotResisted
	pop hl
	ld a, [hli]
	jr nc, .loop_random_color
	call TranslateColorToWR
	ld [wd082], a
	jr .found

; returns carry if turn Duelist has a Pokemon
; with same color as wd082.
.CheckWhetherTurnDuelistHasWRColor
	ld a, [wd082]
	ld b, a
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
.loop_play_area_1
	ld a, [hli]
	cp $ff
	jr z, .false_1
	push bc
	call GetCardIDFromDeckIndex
	call GetCardType ; bug, this could be a Trainer card
	call TranslateColorToWR
	pop bc
	and b
	jr z, .loop_play_area_1
; true
	scf
	ret
.false_1
	or a
	ret

.CheckIfColorIsNotResisted:
	push af
	call TranslateColorToWR
	push af
	call SwapTurn
	bank1call GetArenaCardResistance
	call SwapTurn
	pop bc
	cp b
	pop bc
	ret z ; is defending card's resistance type
	push bc
	bank1call GetArenaCardColor
	pop bc
	cp b
	ret z ; Venomoth is already this type

	; decided on this color, check
	; if it is a legal color to change to
	call .CheckWhetherTurnDuelistHasColor
	ret c
	call SwapTurn
	call .CheckWhetherTurnDuelistHasColor
	call SwapTurn
	ret

.CheckWhetherTurnDuelistHasColor:
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
.loop_play_area_2
	ld a, [hli]
	cp $ff
	jr z, .false_2
	push bc
	call GetCardIDFromDeckIndex
	call GetCardType ; bug, this could be a Trainer card
	pop bc
	cp b
	jr nz, .loop_play_area_2
; true
	scf
	ret
.false_2
	or a
	ret

; checks whether AI uses Peek.
; input:
;	c = Play Area location (PLAY_AREA_*) of Mankey.
HandleAIPeek:
	ld a, c
	ldh [hTemp_ffa0], a
	ld a, 50
	call Random
	cp 3
	ret nc ; return 47 out of 50 times

; choose what to use Peek on at random
	ld a, 3
	call Random
	or a
	jr z, .check_ai_prizes
	cp 2
	jr c, .check_player_hand

; check Player's Deck
	ld a, DUELVARS_NUMBER_OF_CARDS_NOT_IN_DECK
	call GetNonTurnDuelistVariable
	cp DECK_SIZE - 1
	ret nc ; return if Player has one or no cards in Deck
	ld a, AI_PEEK_TARGET_DECK
	jr .use_peek

.check_ai_prizes
	ld a, DUELVARS_PRIZES
	get_turn_duelist_var
	ld hl, wAIPeekedPrizes
	and [hl]
	ld [hl], a
	or a
	ret z ; return if no prizes

	ld c, a
	ld b, $1
	ld d, 0
.loop_prizes
	ld a, c
	and b
	jr nz, .found_prize
	sla b
	inc d
	jr .loop_prizes
.found_prize
; remove this prize's flag from the prize list
; and use Peek on first one in list (lowest bit set)
	ld a, c
	sub b
	ld [hl], a
	ld a, AI_PEEK_TARGET_PRIZE
	add d
	jr .use_peek

.check_player_hand
	call SwapTurn
	call CreateHandCardList
	call SwapTurn
	or a
	ret z ; return if no cards in Hand
; shuffle list and pick the first entry to Peek
	ld hl, wDuelTempList
	call CountCardsInDuelTempList
	call ShuffleCards
	ld a, [wDuelTempList]
	or AI_PEEK_TARGET_HAND

.use_peek
	push af
	ld a, [wd084]
	ldh [hTempCardIndex_ff9f], a
	ld a, OPPACTION_USE_PKMN_POWER
	farcall AIMakeDecision
	pop af
	ldh [hAIPkmnPowerEffectParam], a
	ld a, OPPACTION_EXECUTE_PKMN_POWER_EFFECT
	farcall AIMakeDecision
	ld a, OPPACTION_DUEL_MAIN_SCENE
	farcall AIMakeDecision
	ret

; checks whether AI uses Strange Behavior.
; input:
;	c = Play Area location (PLAY_AREA_*) of Slowbro.
HandleAIStrangeBehavior:
	ld a, c
	or a
	ret z ; return if Slowbro is Arena card

	ldh [hTemp_ffa0], a
	ld e, PLAY_AREA_ARENA
	call GetCardDamageAndMaxHP
	or a
	ret z ; return if Arena card has no damage counters

	ld [wd082], a
	ldh a, [hTemp_ffa0]
	add DUELVARS_ARENA_CARD_HP
	get_turn_duelist_var
	sub 10
	ret z ; return if Slowbro has only 10 HP remaining

; if Slowbro can't receive all damage counters,
; only transfer remaining HP - 10 damage
	ld hl, wd082
	cp [hl]
	jr c, .use_strange_behavior
	ld a, [hl] ; can receive all damage counters

.use_strange_behavior
	push af
	ld a, [wd084]
	ldh [hTempCardIndex_ff9f], a
	ld a, OPPACTION_USE_PKMN_POWER
	farcall AIMakeDecision
	xor a
	ldh [hAIPkmnPowerEffectParam], a
	ld a, OPPACTION_EXECUTE_PKMN_POWER_EFFECT
	farcall AIMakeDecision
	pop af

; loop counters chosen to transfer and use Pkmn Power
	farcall ConvertHPToCounters
	ld e, a
.loop_counters
	ld d, 30
.small_delay_loop
	call DoFrame
	dec d
	jr nz, .small_delay_loop
	push de
	ld a, OPPACTION_6B15
	farcall AIMakeDecision
	pop de
	dec e
	jr nz, .loop_counters

; return to main scene
	ld d, 60
.big_delay_loop
	call DoFrame
	dec d
	jr nz, .big_delay_loop
	ld a, OPPACTION_DUEL_MAIN_SCENE
	farcall AIMakeDecision
	ret

; checks whether AI uses Curse.
; input:
;	c = Play Area location (PLAY_AREA_*) of Gengar.
HandleAICurse:
	ld a, c
	ldh [hTemp_ffa0], a

; loop Player's Play Area and checks their damage.
; finds the card with lowest remaining HP and
; stores its HP and its Play Area location
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	call GetNonTurnDuelistVariable
	ld d, a
	ld e, PLAY_AREA_ARENA
	lb bc, 0, $ff
	ld h, PLAY_AREA_ARENA
	call SwapTurn
.loop_play_area_1
	push bc
	call GetCardDamageAndMaxHP
	pop bc
	or a
	jr z, .next_1

	inc b
	ld a, e
	add DUELVARS_ARENA_CARD_HP
	push hl
	get_turn_duelist_var
	pop hl
	cp c
	jr nc, .next_1
	; lower HP than one stored
	ld c, a ; store this HP
	ld h, e ; store this Play Area location

.next_1
	inc e
	ld a, e
	cp d
	jr nz, .loop_play_area_1 ; reached end of Play Area

	ld a, 1
	cp b
	jr nc, .failed ; return if less than 2 cards with damage

; card in Play Area with lowest HP remaining was found.
; look for another card to take damage counter from.
	ld a, h
	ldh [hTempRetreatCostCards], a
	ld b, a
	ld a, 10
	cp c
	jr z, .hp_10_remaining
	; if has more than 10 HP remaining,
	; skip Arena card in choosing which
	; card to take damage counter from.
	ld e, PLAY_AREA_BENCH_1
	jr .second_card

.hp_10_remaining
	; if Curse can KO, then include
	; Player's Arena card to take
	; damage counter from.
	ld e, PLAY_AREA_ARENA

.second_card
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	ld d, a
.loop_play_area_2
	ld a, e
	cp b
	jr z, .next_2 ; skip same Pokemon card
	push bc
	call GetCardDamageAndMaxHP
	pop bc
	jr nz, .use_curse ; has damage counters, choose this card
.next_2
	inc e
	ld a, e
	cp d
	jr nz, .loop_play_area_2

.failed
	call SwapTurn
	or a
	ret

.use_curse
	ld a, e
	ldh [hAIPkmnPowerEffectParam], a
	call SwapTurn
	ld a, [wd084]
	ldh [hTempCardIndex_ff9f], a
	ld a, OPPACTION_USE_PKMN_POWER
	farcall AIMakeDecision
	ld a, OPPACTION_EXECUTE_PKMN_POWER_EFFECT
	farcall AIMakeDecision
	ld a, OPPACTION_DUEL_MAIN_SCENE
	farcall AIMakeDecision
	ret

; checks whether AI uses Long-Distance Hypnosis.
; input:
;	c = Play Area location (PLAY_AREA_*) of Drowzee.
HandleAILongDistanceHypnosis:
	ld a, c
	ldh [hTemp_ffa0], a

	call CheckIfArenaCardCanKnockOutDefendingCard
	ccf
	ret nc ; can KO

	ld a, DUELVARS_ARENA_CARD_STATUS
	call GetNonTurnDuelistVariable
	and CNF_SLP_PRZ
	cp ASLEEP
	ret z ; defending card is already asleep

	call SwapTurn
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call GetCardIDFromDeckIndex
	cp16 SNORLAX_LV20
	jr nz, .no_thick_skinned
	xor a
	bank1call CheckIsIncapableOfUsingPkmnPower
	jr c, .no_thick_skinned
	; Thick Skinned is active, cannot be put to sleep
	call SwapTurn
	or a
	ret

.no_thick_skinned
	call SwapTurn
	ld a, [wOpponentDeckID]
	cp STRANGE_DECK_ID
	jr z, .strange_deck

	; if Full Heal is in hand,
	; then use Pkmn Power
	ld de, FULL_HEAL
	farcall LookForCardIDInHandList
	jr c, .use_long_distance_hypnosis

	; if player has more prize cards, exit
	; otherwise, if the prize card difference
	; is 4 or more, then use Pkmn Power
	call SwapTurn
	call CountPrizes
	call SwapTurn
	push af
	call CountPrizes
	pop bc
	; a = num opponent's prize cards
	; b = num player's prize cards
	sub b
	ret c ; player has more prize cards
	cp 4
	ret c ; difference is less than 4
.use_long_distance_hypnosis
	ld a, [wd084]
	ldh [hTempCardIndex_ff9f], a
	ld a, OPPACTION_USE_PKMN_POWER
	farcall AIMakeDecision
	ld a, OPPACTION_EXECUTE_PKMN_POWER_EFFECT
	farcall AIMakeDecision
	ld a, OPPACTION_DUEL_MAIN_SCENE
	farcall AIMakeDecision
	ret

.strange_deck
	; if Defending card cannot KO,
	; then use Pkmn Power
	xor a ; PLAY_AREA_ARENA
	ldh [hTempPlayAreaLocation_ff9d], a
	call CheckIfDefendingPokemonCanKnockOut
	ret c ; defending card can KO
	jr .use_long_distance_hypnosis

; checks whether AI uses Pollen Stench.
; input:
;	c = Play Area location (PLAY_AREA_*) of Dark Gloom.
HandleAIPollenStench:
	ld a, c
	ldh [hTemp_ffa0], a

	ld a, DUELVARS_ARENA_CARD_STATUS
	call GetNonTurnDuelistVariable
	and CNF_SLP_PRZ
	cp CONFUSED
	ret z ; is already confused
	cp PARALYZED
	ret z ; is paralyzed

	ld a, [wOpponentDeckID]
	cp MAD_PETALS_DECK_ID
	jr z, .mad_petals_deck
	cp BAD_GUYS_DECK_ID
	jp z, .bad_guys_deck

; either Trainer Imprison deck
; or Great Rocket 3 deck
; possibly an oversight that these decks
; do not check for Thick Skinned in player's side

	ld de, DARK_GLOOM
	ld b, PLAY_AREA_BENCH_1
	call CountCardIDInTurnDuelistPlayArea
	or a
	jr nz, .dark_gloom_in_bench

; Dark Gloom is in Arena
	; use Pkmn Power if Full Heal
	; or Full Heal Energy is in hand
	ld de, FULL_HEAL
	farcall LookForCardIDInHandList
	jr c, .use_pollen_stench ; has Full Heal
	ld de, FULLHEAL_ENERGY
	farcall LookForCardIDInHandList
	jr c, .use_pollen_stench ; has Full Heal Energy

	; if player has more prize cards, exit
	; otherwise, if the prize card difference
	; is 4 or more, then use Pkmn Power
	call SwapTurn
	call CountPrizes
	call SwapTurn
	push af
	call CountPrizes
	pop bc
	; a = num opponent's prize cards
	; b = num player's prize cards
	sub b
	ret c ; player has more prize cards
	cp 4
	ret c ; difference is less than 4
	jr .use_pollen_stench

.dark_gloom_in_bench
	; if Arena card is already statused, use Pkmn Power
	ld a, DUELVARS_ARENA_CARD_STATUS
	get_turn_duelist_var
	and CNF_SLP_PRZ
	or a
	jr nz, .use_pollen_stench

	; if it's last prize card, exit
	call CountPrizes
	cp 1
	ret z

	; if player has more prize cards, exit
	push af
	call SwapTurn
	call CountPrizes
	call SwapTurn
	ld b, a
	pop af
	cp b
	ret c

	; 50% chance to use Pkmn Power
	ld a, 2
	call Random
	or a
	ret z
.use_pollen_stench
	ld a, [wd084]
	ldh [hTempCardIndex_ff9f], a
	ld a, OPPACTION_USE_PKMN_POWER
	farcall AIMakeDecision
	ld a, OPPACTION_EXECUTE_PKMN_POWER_EFFECT
	farcall AIMakeDecision
	ld a, OPPACTION_DUEL_MAIN_SCENE
	farcall AIMakeDecision
	ret

.mad_petals_deck
	; will only use Pkmn Power if player's Arena card
	; is not a Grass-type or is not Snorlax lv20
	; and if own Arena card is a Grass-type
	call SwapTurn
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call LoadCardDataToBuffer2_FromDeckIndex
	call SwapTurn
	ld a, [wLoadedCard2Type]
	cp TYPE_PKMN_GRASS
	ret z ; player's Arena card is Grass type

	ld hl, wLoadedCard2ID
	cphl SNORLAX_LV20
	ret z ; player has Snorlax lv20

	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call LoadCardDataToBuffer2_FromDeckIndex
	ld a, [wLoadedCard2Type]
	cp TYPE_PKMN_GRASS
	ret nz ; exit if AI's Arena card is not Grass type
	jr .use_pollen_stench

.bad_guys_deck
	call CheckIfArenaCardCanKnockOutDefendingCard_CheckHand
	ret c ; can KO

	; if AI can evolve Arena card this turn,
	; then use Pkmn Power
	call CreateHandCardList
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	ld hl, wDuelTempList
	farcall CheckIfPokemonEvolutionIsFoundInHand
	jr nc, .cannot_evolve
	bank1call IsPrehistoricPowerActive
	jr c, .cannot_evolve
	ld a, DUELVARS_ARENA_CARD_FLAGS
	get_turn_duelist_var
	and CAN_EVOLVE_THIS_TURN
	jr z, .use_pollen_stench

.cannot_evolve
	; otherwise use it if Arena is statused
	; or it can be retreated
	ld a, DUELVARS_ARENA_CARD_STATUS
	get_turn_duelist_var
	and CNF_SLP_PRZ
	or a
	jr nz, .use_pollen_stench
	call CheckIfArenaCardCanRetreat
	ret c ; cannot retreat

	; if Defending card can't be KO'ed, use Pkmn Power
	xor a ; PLAY_AREA_ARENA
	ldh [hTempPlayAreaLocation_ff9d], a
	call CheckIfDefendingPokemonCanKnockOut
	jr c, .use_pollen_stench
	; cannot KO
	ret

; checks whether AI uses Gather Fire.
; input:
;	c = Play Area location (PLAY_AREA_*) of Charmander.
HandleAIGatherFire:
	ld a, [wOpponentDeckID]
	cp BAD_GUYS_DECK_ID
	jr z, .bad_guys_deck
	cp SCORCHER_DECK_ID
	jr z, .scorcher_deck

	ld a, c
	or a
	ret nz ; Charmander is in Bench

	ld e, PLAY_AREA_ARENA
	call GetPlayAreaCardAttachedEnergies
	ld a, [wTotalAttachedEnergies]
	or a
	ret nz ; already has energy attached

	; Charmander is Arena card and has no energy cards
	; look in Bench if there's a Fire energy to attach
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	ld b, a
	ld c, PLAY_AREA_BENCH_1
.loop_bench
	ld a, c
	cp b
	ret z
	push bc
	ld de, FIRE_ENERGY
	farcall CheckIfHasSpecificEnergyAttached
	pop bc
	inc c
	jr nc, .loop_bench
.use_gather_fire
	ldh [hTempPlayAreaLocation_ffa1], a
	ld a, [wd084]
	ldh [hTempCardIndex_ff9f], a
	ld a, OPPACTION_USE_PKMN_POWER
	farcall AIMakeDecision
	ld a, OPPACTION_EXECUTE_PKMN_POWER_EFFECT
	farcall AIMakeDecision
	ld a, OPPACTION_DUEL_MAIN_SCENE
	farcall AIMakeDecision
	ret

.bad_guys_deck
	; considering taking from Arena card
	; if it's in danger of getting KO'ed
	call CheckIfArenaCardCanRetreat
	jr c, .check_dark_charmeleon ; can retreat
	call CheckIfArenaCardCanKnockOutDefendingCard_CheckHand
	jr c, .check_dark_charmeleon ; can KO defending card
	; Arena card cannot KO nor retreat
	; check if defending card can KO it
	ld hl, hTempPlayAreaLocation_ff9d
	ld a, [hl]
	push af
	xor a
	ld [hl], a
	call CheckIfDefendingPokemonCanKnockOut
	pop bc
	ld a, b
	ldh [hTempPlayAreaLocation_ff9d], a
	ld a, PLAY_AREA_ARENA
	jr c, .arena_card_in_danger ; can KO Arena card

.check_dark_charmeleon
	; optionally take from a Dark Charmeleon
	; on the Bench that has remaining HP <= 20
	ld de, DARK_CHARMELEON
	ld b, PLAY_AREA_BENCH_1
	farcall FindCardIDInTurnDuelistsPlayArea
	ret nc ; no Dark Charmeleon in Bench
	ld b, a
	add DUELVARS_ARENA_CARD_HP
	get_turn_duelist_var
	cp 20 + 1
	ret nc ; remaining HP > 20
	ld a, b
.arena_card_in_danger
	ld de, FIRE_ENERGY
	farcall CheckIfHasSpecificEnergyAttached
	ret nc ; has no Fire energy to give
	jr .use_gather_fire

.scorcher_deck
	ld a, c
	add DUELVARS_ARENA_CARD_HP
	get_turn_duelist_var
	cp 40
	ret c ; Charmander has sustained damage
	farcall FindPokemonInBenchWithDamageAndEnergyAttached
	ret nc
	ld de, FIRE_ENERGY
	farcall CheckIfHasSpecificEnergyAttached
	ret nc
	jr .use_gather_fire

; checks whether AI uses Evolutionary Light.
; input:
;	c = Play Area location (PLAY_AREA_*) of Dark Dragonair.
HandleAIEvolutionaryLight:
	ld a, c
	ldh [hTemp_ffa0], a
	ld a, [wOpponentDeckID]
	cp GREAT_DRAGON_DECK_ID
	jr z, .great_dragon_deck
	cp DANGEROUS_BENCH_DECK_ID
	jr z, .dangerous_bench_deck
	cp POKEMON_POWER_DECK_ID
	jp z, .pokemon_power_deck
	cp SUDDEN_GROWTH_DECK_ID
	jp z, .sudden_growth_deck
	cp STOP_LIFE_DECK_ID
	jp z, .stop_life_deck
	cp RONALDS_PSYCHIC_DECK_ID
	jp z, .ronalds_psychic_deck
	cp POWER_OF_DARKNESS_DECK_ID
	jp z, .power_of_darkness
	ret

.use_evolutionary_light
	ldh [hTempPlayAreaLocation_ffa1], a
	ld a, [wd084]
	ldh [hTempCardIndex_ff9f], a
	ld a, OPPACTION_USE_PKMN_POWER
	farcall AIMakeDecision
	ld a, OPPACTION_EXECUTE_PKMN_POWER_EFFECT
	farcall AIMakeDecision
	ld a, OPPACTION_DUEL_MAIN_SCENE
	farcall AIMakeDecision
	ret

.great_dragon_deck
	ld a, CARD_LOCATION_DECK
	ld de, CHARMELEON
	farcall FindCardIDInLocation
	jr c, .use_evolutionary_light
	ld a, CARD_LOCATION_DECK
	ld de, CHARIZARD_LV76
	farcall FindCardIDInLocation
	jr c, .use_evolutionary_light
	ld a, CARD_LOCATION_DECK
	ld de, CHARIZARD_ALT_LV76
	farcall FindCardIDInLocation
	jr c, .use_evolutionary_light
	ld a, CARD_LOCATION_DECK
	ld de, DRAGONAIR
	farcall FindCardIDInLocation
	jr c, .use_evolutionary_light
	ld a, CARD_LOCATION_DECK
	ld de, DRAGONITE_LV41
	farcall FindCardIDInLocation
	jr c, .use_evolutionary_light
	ret

.dangerous_bench_deck
	ld bc, PIKACHU_LV14
	ld de, DARK_RAICHU
	call CheckEvolutionaryLightTarget
	jr c, .use_evolutionary_light
	ld bc, DRATINI_LV12
	ld de, DARK_DRAGONAIR
	call CheckEvolutionaryLightTarget
	jr c, .use_evolutionary_light
	ld bc, DARK_DRAGONAIR
	ld de, DARK_DRAGONITE
	call CheckEvolutionaryLightTarget
	jr c, .use_evolutionary_light
	ret

.pokemon_power_deck
	ld bc, KADABRA_LV38
	ld de, ALAKAZAM_LV42
	call CheckEvolutionaryLightTarget
	jr c, .use_evolutionary_light
	ld bc, ABRA_LV14
	ld de, KADABRA_LV38
	call CheckEvolutionaryLightTarget
	jp c, .use_evolutionary_light
	ld bc, SLOWPOKE_LV16
	ld de, SLOWBRO_LV26
	call CheckEvolutionaryLightTarget
	jp c, .use_evolutionary_light
	ld bc, MEOWTH_LV14
	ld de, DARK_PERSIAN_LV28
	call CheckEvolutionaryLightTarget
	jp c, .use_evolutionary_light
	ld bc, DRATINI_LV12
	ld de, DARK_DRAGONAIR
	call CheckEvolutionaryLightTarget
	jp c, .use_evolutionary_light
	ret

.sudden_growth_deck
	ld bc, CLEFAIRY_LV15
	ld de, DARK_CLEFABLE
	call CheckEvolutionaryLightTarget
	jp c, .use_evolutionary_light
	ld de, DARK_CLEFABLE
	ld b, PLAY_AREA_ARENA
	call CountCardIDInTurnDuelistPlayArea
	cp 2
	jr c, .not_enough_dark_clefable
	; has at least 2 Dark Clefable
	ld de, DARK_DRAGONITE
	call CheckIfCardIDIsInDeckAndNotInHand
	; bug, the result is discarded,
	; missing jump to use Pkmn Power
	; jp c, .use_evolutionary_light
	ret
.not_enough_dark_clefable
	or a
	ret

.stop_life_deck
	; first search for targets that can evolve
	; Pokémon already in the Play Area
	ld bc, DARK_IVYSAUR
	ld de, DARK_VENUSAUR
	call FindUsableEvolutionInDeck
	jp c, .use_evolutionary_light
	ld bc, BULBASAUR_LV12
	ld de, DARK_IVYSAUR
	call FindUsableEvolutionInDeck
	jp c, .use_evolutionary_light
	ld bc, DRATINI_LV10
	ld de, DARK_DRAGONAIR
	call FindUsableEvolutionInDeck
	jp c, .use_evolutionary_light

	; next search for targets that are not in Hand
	ld de, DARK_VENUSAUR
	call CheckIfCardIDIsInDeckAndNotInHand
	jp c, .use_evolutionary_light
	ld de, DARK_IVYSAUR
	call CheckIfCardIDIsInDeckAndNotInHand
	jp c, .use_evolutionary_light
	ld de, DARK_DRAGONAIR
	call CheckIfCardIDIsInDeckAndNotInHand
	jp c, .use_evolutionary_light

	; finally search for targets that are in the Deck
	ld a, CARD_LOCATION_DECK
	ld de, DARK_VENUSAUR
	farcall FindCardIDInLocation
	jp c, .use_evolutionary_light
	ld a, CARD_LOCATION_DECK
	ld de, DARK_IVYSAUR
	farcall FindCardIDInLocation
	jp c, .use_evolutionary_light
	ld a, CARD_LOCATION_DECK
	ld de, DARK_DRAGONAIR
	farcall FindCardIDInLocation
	jp c, .use_evolutionary_light
	ret

.ronalds_psychic_deck
	; first search for targets that can evolve
	; Pokémon already in the Play Area
	ld bc, GASTLY_LV13
	ld de, HAUNTER_LV26
	call CheckEvolutionaryLightTarget
	jp c, .use_evolutionary_light
	ld bc, HAUNTER_LV26
	ld de, GENGAR_LV40
	call CheckEvolutionaryLightTarget
	jp c, .use_evolutionary_light
	ld bc, DRATINI_LV10
	ld de, DARK_DRAGONAIR
	call CheckEvolutionaryLightTarget
	jp c, .use_evolutionary_light
	ld bc, DARK_DRAGONAIR
	ld de, DARK_DRAGONITE
	call CheckEvolutionaryLightTarget
	jp c, .use_evolutionary_light

	; next search for targets that are in the Deck
	ld a, CARD_LOCATION_DECK
	ld de, HAUNTER_LV26
	farcall FindCardIDInLocation
	jp c, .use_evolutionary_light
	ld a, CARD_LOCATION_DECK
	ld de, GENGAR_LV40
	farcall FindCardIDInLocation
	jp c, .use_evolutionary_light
	ld a, CARD_LOCATION_DECK
	ld de, DARK_DRAGONAIR
	farcall FindCardIDInLocation
	jp c, .use_evolutionary_light
	ld a, CARD_LOCATION_DECK
	ld de, DARK_DRAGONITE
	farcall FindCardIDInLocation
	jp c, .use_evolutionary_light
	ret

.power_of_darkness
	ld de, DARK_CLEFABLE
	farcall Func_4b9f4
	jp c, .use_evolutionary_light
	ld de, DARK_GOLDUCK
	farcall Func_4b9f4
	jp c, .use_evolutionary_light
	ld de, DARK_DRAGONAIR
	farcall Func_4b9f4
	jp c, .use_evolutionary_light
	ret

; checks whether AI uses Matter Exchange.
; input:
;	c = Play Area location (PLAY_AREA_*) of Dark Kadabra.
HandleAIMatterExchange:
	ld a, c
	ldh [hTemp_ffa0], a

	; only use Pkmn Power if there are no Energy cards in Hand
	; and there's duplicates of certain cards to discard

	call CountEnergyCardsInHand
	or a
	ret nz ; has energy cards

	ld de, THE_BOSSS_WAY
	call CheckIfHandHasRepeatedCard
	jr c, .use_matter_exchange
	ld de, ENERGY_RETRIEVAL
	call CheckIfHandHasRepeatedCard
	jr c, .use_matter_exchange
	ld de, POKEMON_TRADER
	call CheckIfHandHasRepeatedCard
	jr c, .use_matter_exchange
	ld de, ENERGY_REMOVAL
	call CheckIfHandHasRepeatedCard
	ret nc
.use_matter_exchange
	ldh [hTempPlayAreaLocation_ffa1], a
	ld a, [wd084]
	ldh [hTempCardIndex_ff9f], a
	ld a, OPPACTION_USE_PKMN_POWER
	farcall AIMakeDecision
	ld a, OPPACTION_EXECUTE_PKMN_POWER_EFFECT
	farcall AIMakeDecision
	ld a, OPPACTION_DUEL_MAIN_SCENE
	farcall AIMakeDecision
	ret

; checks whether AI uses Play Tricks.
; input:
;	c = Play Area location (PLAY_AREA_*) of Dark Gengar.
HandleAIPlayTricks:
	ld a, c
	or a
	ret z ; Dark Gengar is Arena card

	ldh [hTemp_ffa0], a
	ld a, [wOpponentDeckID]
	cp DAMAGE_CHAOS_DECK_ID
	jr z, .damage_chaos_deck
	call CheckIfArenaCardCanKnockOutDefendingCard_CheckHand
	ccf
	ret nc
.use_play_tricks
	ld a, [wd084]
	ldh [hTempCardIndex_ff9f], a
	ld a, OPPACTION_USE_PKMN_POWER
	farcall AIMakeDecision
	ld a, OPPACTION_EXECUTE_PKMN_POWER_EFFECT
	farcall AIMakeDecision
	ld a, OPPACTION_DUEL_MAIN_SCENE
	farcall AIMakeDecision
	ret

.damage_chaos_deck
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call GetCardIDFromDeckIndex
	cp16 EXEGGUTOR
	jr z, .exeggutor
	cp16 DARK_CLEFABLE
	jr z, .dark_clefable
	call CheckIfArenaCardCanKnockOutDefendingCard_CheckHand
	jr nc, .use_play_tricks
.dont_use_play_tricks
	or a
	ret

.exeggutor
	; use Pkmn Power if on last Prize card
	call CountPrizes
	cp 1
	jr z, .use_play_tricks

	; use if estimated damage of attack doesn't KO
	xor a ; PLAY_AREA_ARENA
	ldh [hTempPlayAreaLocation_ff9d], a
	; bug, a is expected to have the attack index to estimate damage
	; because a is 0 here, it will estimate the damage of Teleport (which is 0)
	; a is supposed to have SECOND_ATTACK here
	; ld a, SECOND_ATTACK
	farcall EstimateDamage_VersusDefendingCard
	ld a, DUELVARS_ARENA_CARD_HP
	call GetNonTurnDuelistVariable
	ld hl, wAIMaxDamage
	cp [hl]
	jr nc, .dont_use_play_tricks
	jr .use_play_tricks

.dark_clefable
	call CheckIfArenaCardCanKnockOutDefendingCard_CheckHand
	jr c, .dont_use_play_tricks
	ld a, PLAY_AREA_BENCH_1
	ld d, 10
	farcall FindTargetInPlayAreaToKO
	jr c, .dont_use_play_tricks
	jr .use_play_tricks

; checks whether AI uses Fossilize.
; input:
;	c = Play Area location (PLAY_AREA_*) of Kabuto.
HandleAIFossilize:
	ld a, c
	ldh [hTemp_ffa0], a

	call CheckIfArenaCardCanKnockOutDefendingCard
	ccf
	ret nc ; Arena card can KO
	xor a ; PLAY_AREA_ARENA
	ldh [hTempPlayAreaLocation_ff9d], a
	call CheckIfDefendingPokemonCanKnockOut
	ret nc ; Defending card cannot KO

	; Arena card is in danger of being KO'ed by Defending card
	; check if there's at least 3 Pokémon in Play Area
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	cp 3
	ccf
	ret nc ; less than 3 Pokemon

	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call GetCardIDFromDeckIndex
	cp16 OMANYTE_LV19
	jr z, .use_fossilize
	cp16 OMANYTE_LV20
	jr z, .use_fossilize
	cp16 OMANYTE_LV22
	jr z, .use_fossilize
	cp16 OMASTAR_LV32
	jr z, .use_fossilize
	cp16 OMASTAR_LV36
	jr z, .use_fossilize
	cp16 KABUTO_LV9
	jr z, .use_fossilize
	cp16 KABUTO_LV22
	jr z, .use_fossilize
	cp16 KABUTOPS
	jr z, .use_fossilize
	cp16 AERODACTYL_LV28
	jr z, .use_fossilize
	cp16 AERODACTYL_LV30
	jr z, .use_fossilize
	; not a valid target of Fossilize
	or a
	ret

.use_fossilize
	ld a, [wd084]
	ldh [hTempCardIndex_ff9f], a
	ld a, OPPACTION_UNK_0C
	farcall AIMakeDecision
	ld a, -1
	ldh [hTempPlayAreaLocation_ffa1], a
	ldtx de, FossilizeCheckText
	farcall Func_68079
	jr c, .got_heads
	farcall Func_6809a
	call Func_19e1
	call WaitForWideTextBoxInput
	jr .got_tails
.got_heads
	xor a ; PLAY_AREA_ARENA
	ldh [hTempPlayAreaLocation_ffa1], a
.got_tails
	ld a, OPPACTION_USE_PKMN_POWER
	farcall AIMakeDecision
	ld a, OPPACTION_EXECUTE_PKMN_POWER_EFFECT
	farcall AIMakeDecision
	ld a, OPPACTION_DUEL_MAIN_SCENE
	farcall AIMakeDecision
	ret

; checks whether AI uses Special Delivery.
; input:
;	c = Play Area location (PLAY_AREA_*) of Dragonite.
HandleAISpecialDelivery:
	; chooses an evolution card in Hand that doesn't
	; evolve any Pokémon in the Play Area to place on Deck
	ld a, c
	ldh [hTemp_ffa0], a
	farcall FindUnusableEvolutionCardInHand
	ret nc ; not found
	ldh [hTempPlayAreaLocation_ffa1], a
	ld a, [wd084]
	ldh [hTempCardIndex_ff9f], a
	ld a, OPPACTION_USE_PKMN_POWER
	farcall AIMakeDecision
	ld a, OPPACTION_EXECUTE_PKMN_POWER_EFFECT
	farcall AIMakeDecision
	ld a, OPPACTION_DUEL_MAIN_SCENE
	farcall AIMakeDecision
	ret

; checks whether AI uses Step In.
; input:
;	c = Play Area location (PLAY_AREA_*) of Dragonite.
HandleAIStepIn:
	ld a, c
	ldh [hTemp_ffa0], a
	xor a ; PLAY_AREA_ARENA
	ldh [hTempPlayAreaLocation_ff9d], a
	call CheckIfDefendingPokemonCanKnockOut
	ret nc ; defending can't KO
	ldh a, [hTemp_ffa0]
	ld e, a
	call GetPlayAreaCardAttachedEnergies
	ld a, [wTotalAttachedEnergies]
	cp 4
	ccf
	ret nc ; Dragonite doesn't have enough energy to attack
	ld a, [wd084]
	ldh [hTempCardIndex_ff9f], a
	ld a, OPPACTION_USE_PKMN_POWER
	farcall AIMakeDecision
	ld a, OPPACTION_EXECUTE_PKMN_POWER_EFFECT
	farcall AIMakeDecision
	ld a, OPPACTION_DUEL_MAIN_SCENE
	farcall AIMakeDecision
	ret

HandleAIMagnet:
	farcall StubbedAIChooseRandomlyNotToDoAction
	ccf
	ret nc

	; check if there is a Magnemite lv15 in the Play Area
	; for each of them, attempt to use its Magnet Pkmn Power
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	ld b, a
	ld c, PLAY_AREA_ARENA
.loop_play_area
	ld a, DUELVARS_ARENA_CARD
	add c
	get_turn_duelist_var
	ld [wAIPkmnPowerUserCardIndex], a
	call GetCardIDFromDeckIndex
	push bc
	cp16 MAGNEMITE_LV15
	call z, .TryUseMagnet
	pop bc
	inc c
	ld a, c
	cp b
	jr nz, .loop_play_area
	ret

; input:
; - c = PLAY_AREA_* location of Magnemite lv15
; - [wAIPkmnPowerUserCardIndex] = Magnemite lv15 deck index
.TryUseMagnet:
	push bc
	ld a, c
	ldh [hTempPlayAreaLocation_ff9d], a
	ld a, [wAIPkmnPowerUserCardIndex]
	ld d, a ; card index
	ld e, FIRST_ATTACK_OR_PKMN_POWER
	call CopyAttackDataAndDamage_FromDeckIndex

	; check if can use Magnet Pkmn Power
	ld a, EFFECTCMDTYPE_INITIAL_EFFECT_2
	call TryExecuteEffectCommandFunction
	pop bc
	ret c ; cannot use Magnet
	push bc
	ld a, c
	bank1call CheckIsIncapableOfUsingPkmnPower
	pop bc
	ret c ; cannot use Magnet

	; check if there's space in the Bench
	ld a, c
	ldh [hTemp_ffa0], a
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	inc a
	ld hl, wMaxNumPlayAreaPokemon
	cp [hl]
	ret nc ; no space in Bench

	; set up the card search func
	ld a, CARDSEARCH_POKEDEX_NUMBER
	ld de, DEX_MAGNEMITE
	farcall SetCardSearchFuncParams

	call CreateDeckCardList
	ret c ; no cards in Deck
	ld hl, wDuelTempList
.loop_deck
	ld a, [hli]
	cp $ff
	ret z
	ldh [hTempRetreatCostCards], a
	farcall ExecuteCardSearchFunc
	jr nc, .loop_deck

	; a Magnemite is found in the Deck
	ld a, [wAIPkmnPowerUserCardIndex]
	ldh [hTempCardIndex_ff9f], a
	ld a, OPPACTION_UNK_0C
	farcall AIMakeDecision
	ldtx de, MagnetCheckText
	farcall Func_68079
	ldh [hAIPkmnPowerEffectParam], a
	jr c, .heads
	farcall Func_6809a
	call Func_19e1
	call WaitForWideTextBoxInput
.heads
	ld a, OPPACTION_USE_PKMN_POWER
	farcall AIMakeDecision
	ld a, OPPACTION_EXECUTE_PKMN_POWER_EFFECT
	farcall AIMakeDecision
	ld a, OPPACTION_DUEL_MAIN_SCENE
	farcall AIMakeDecision
	ret

; handles AI logic for Cowardice
HandleAICowardice:
	farcall StubbedAIChooseRandomlyNotToDoAction
	ret c

	ld a, [wOpponentDeckID]
	cp IMMORTAL_POKEMON_DECK_ID
	jp z, .immortal_pokemon_deck

	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	cp 1
	ret z ; return if only one Pokemon in Play Area
	ld b, a

	ld c, PLAY_AREA_ARENA
	ld a, DUELVARS_ARENA_CARD_STATUS
	get_turn_duelist_var
	or a
	jr nz, .next
.loop
	ld a, DUELVARS_ARENA_CARD
	add c
	get_turn_duelist_var
	ld [wd084], a
	call GetCardIDFromDeckIndex
	push bc
	cp16 TENTACOOL
	call z, .CheckWhetherToUseCowardice
	pop bc
	jr nc, .next

	dec b ; subtract 1 from number of Pokemon in Play Area
	ld a, 1
	cp b
	ret z ; return if no longer has Bench Pokemon
	ld c, PLAY_AREA_ARENA ; reset back to Arena
	jr .loop

.next
	inc c
	ld a, c
	cp b
	jr nz, .loop
	ret

; checks whether AI uses Cowardice.
; return carry if Pkmn Power was used.
; input:
;	c = Play Area location (PLAY_AREA_*) of Tentacool.
.CheckWhetherToUseCowardice:
	ld a, c
	ldh [hTemp_ffa0], a

	bank1call CheckIsIncapableOfUsingPkmnPower
	ccf
	ret nc ; can't use Cowardice

	ldh a, [hTemp_ffa0]
	ld e, a
	call GetCardDamageAndMaxHP
	or a
	ret z ; return if has no damage counters

	ldh a, [hTemp_ffa0]
	ldh [hTempPlayAreaLocation_ff9d], a
	ld a, [wd084]
	ld d, a
	ld e, FIRST_ATTACK_OR_PKMN_POWER
	call CopyAttackDataAndDamage_FromDeckIndex
	ld a, EFFECTCMDTYPE_INITIAL_EFFECT_2
	call TryExecuteEffectCommandFunction
	jr c, .dont_use_cowardice

	ldh a, [hTemp_ffa0]
	or a
	jr nz, .is_benched
	farcall AIDecideBenchPokemonToSwitchTo
	jr c, .dont_use_cowardice
	jr .use_cowardice

.is_benched
	ld a, $ff
.use_cowardice
	push af
	ld a, [wd084]
	ldh [hTempCardIndex_ff9f], a
	ld a, OPPACTION_USE_PKMN_POWER
	farcall AIMakeDecision
	pop af
	ldh [hAIPkmnPowerEffectParam], a
	ld a, OPPACTION_EXECUTE_PKMN_POWER_EFFECT
	farcall AIMakeDecision
	ld a, OPPACTION_DUEL_MAIN_SCENE
	farcall AIMakeDecision
	scf
	ret

.dont_use_cowardice
	or a
	ret

.immortal_pokemon_deck
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	cp 1
	ret z ; no Bench Pokémon

	; Immortal Pokémon deck AI uses Cowardice if Tentacool
	; has 10 HP remaining or is Arena card
	ld b, a
	ld c, PLAY_AREA_ARENA
.loop_play_area
	ld a, DUELVARS_ARENA_CARD
	add c
	get_turn_duelist_var
	ld [wd084], a
	call GetCardIDFromDeckIndex
	cp16 TENTACOOL
	jr nz, .next_pokemon
	ld a, c
	or a
	jr z, .tentacool_is_arena_card
	add DUELVARS_ARENA_CARD_HP
	get_turn_duelist_var
	cp 10
	jr nz, .next_pokemon
.tentacool_is_arena_card
	push bc
	call z, .CheckWhetherToUseCowardice
	pop bc
	jr nc, .next_pokemon
	dec b ; subtract 1 from number of Pokemon in Play Area
	ld a, 1
	cp b
	ret z ; return if no longer has Bench Pokemon
	ld c, PLAY_AREA_ARENA ; reset back to Arena
	jr .loop_play_area
.next_pokemon
	inc c
	ld a, c
	cp b
	jr nz, .loop_play_area
	ret
; 0x38cd4

SECTION "Bank e@4cdf", ROMX[$4cdf], BANK[$e]

HandleAITrickery:
	farcall StubbedAIChooseRandomlyNotToDoAction
	ret c

	ld de, RATTATA_LV12
	ld b, PLAY_AREA_ARENA
	farcall FindCardIDInTurnDuelistsPlayArea
	ret nc ; no Rattata in Play Area
	ldh [hTemp_ffa0], a

	bank1call CheckIsIncapableOfUsingPkmnPower
	ret c ; incapable of using Trickery

	; 50% chance of not using Trickery
	ld a, 2
	call Random
	or a
	ret z

	ldh a, [hTemp_ffa0]
	add DUELVARS_ARENA_CARD
	get_turn_duelist_var
	ldh [hTempCardIndex_ff9f], a

	; sample random prize cards
	; until we get one that hasn't been picked yet
.sample_prize_card
	ld a, 6
	call Random
	ld c, a
	ld b, $1
.loop_get_bit_mask
	or a
	jr z, .got_bit_mask
	sla b
	dec a
	jr .loop_get_bit_mask
.got_bit_mask
	ld a, DUELVARS_PRIZES
	get_turn_duelist_var
	and b
	jr z, .sample_prize_card

	; use Trickery with selected prize card
	ld a, c
	or $40
	ldh [hAIPkmnPowerEffectParam], a
	ld a, OPPACTION_USE_PKMN_POWER
	farcall AIMakeDecision
	ld a, OPPACTION_EXECUTE_PKMN_POWER_EFFECT
	farcall AIMakeDecision
	ld a, OPPACTION_DUEL_MAIN_SCENE
	farcall AIMakeDecision
	ret

HandleAIRebirth:
	farcall StubbedAIChooseRandomlyNotToDoAction
	ret c
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	cp 1
	ret z ; return if no Bench
	ld b, a
	ld c, PLAY_AREA_ARENA

	; if Arena card is statused, then skip it
	ld a, DUELVARS_ARENA_CARD_STATUS
	get_turn_duelist_var
	or a
	jr nz, .next_play_area_pkmn

.loop_play_area
	ld a, DUELVARS_ARENA_CARD
	add c
	get_turn_duelist_var
	ld [wAIPkmnPowerUserCardIndex], a
	call GetCardIDFromDeckIndex
	push bc
	cp16 DARK_STARMIE
	call z, .TryUseRebirth
	pop bc
	jr nc, .next_play_area_pkmn
	dec b
	ld a, 1
	cp b
	ret z
	; restart from Arena card
	ld c, PLAY_AREA_ARENA
	jr .loop_play_area
.next_play_area_pkmn
	inc c
	ld a, c
	cp b
	jr nz, .loop_play_area
	ret

; input:
; - c = Dark Starmie's PLAY_AREA_* location
.TryUseRebirth:
	ld a, c
	ldh [hTemp_ffa0], a
	bank1call CheckIsIncapableOfUsingPkmnPower
	ret c ; incapable of using Pkmn Power

	; check if any Staryu lv15 in Deck
	ld a, CARD_LOCATION_DECK
	ld de, STARYU_LV15
	farcall FindCardIDInLocation
	ret nc ; no Staryu in deck

	ldh a, [hTemp_ffa0]
	or a
	jr nz, .is_on_bench
	ldh [hTempPlayAreaLocation_ff9d], a
	call CheckIfDefendingPokemonCanKnockOut
	ret nc ; player cannot KO
	; player can KO next turn
	; use Rebirth if has <= 20 HP remaining
	ldh a, [hTemp_ffa0]
	add DUELVARS_ARENA_CARD_HP
	get_turn_duelist_var
	cp 20 + 1
	jr c, .use_rebirth

	; has > 20 HP remaining, use Rebirth
	; if Dark Starmie cannot use its attack
	ld a, SECOND_ATTACK
	ld [wSelectedAttack], a
	farcall CheckIfSelectedAttackIsUnusable
	jr c, .use_rebirth
	or a
	ret

.is_on_bench
	; Dark Starmie is on the Bench, use Rebirth
	; if remaining HP is <= 20
	ldh a, [hTemp_ffa0]
	add DUELVARS_ARENA_CARD_HP
	get_turn_duelist_var
	cp 20 + 1
	ret nc ; exit if > 20 HP remaining

.use_rebirth
	ld a, [wAIPkmnPowerUserCardIndex]
	ldh [hTempCardIndex_ff9f], a
	ld a, OPPACTION_USE_PKMN_POWER
	farcall AIMakeDecision
	ld a, OPPACTION_EXECUTE_PKMN_POWER_EFFECT
	farcall AIMakeDecision
	ld a, OPPACTION_DUEL_MAIN_SCENE
	farcall AIMakeDecision
	scf
	ret

; AI logic for Damage Swap to transfer damage from Arena card
; to a card in Bench with more than 10 HP remaining
; and with no energy cards attached.
HandleAIDamageSwap:
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	dec a
	ret z ; return if no Bench Pokemon

	farcall StubbedAIChooseRandomlyNotToDoAction
	ret c

	farcall FindAlakazamLv42WithActivePkmnPowerInPlayArea
	ret nc ; return if no Alakazam

	ld e, PLAY_AREA_ARENA
	call GetCardDamageAndMaxHP
	or a
	ret z ; return if Arena Card has no damage

	farcall ConvertHPToCounters
	ld [wd082], a
	farcall FindAlakazamLv42WithActivePkmnPowerInPlayArea
	ld [wd084], a

	call .FindTargets
	ret c ; no targets found

; use Damage Swap
	ld a, [wd084]
	add DUELVARS_ARENA_CARD
	get_turn_duelist_var
	ldh [hTempCardIndex_ff9f], a
	ld a, [wd084]
	ldh [hTemp_ffa0], a
	ld a, OPPACTION_USE_PKMN_POWER
	farcall AIMakeDecision
	ld a, OPPACTION_EXECUTE_PKMN_POWER_EFFECT
	farcall AIMakeDecision

	ld a, [wd082]
	ld e, a
.loop_damage
	ld d, 30
.small_delay_loop
	call DoFrame
	dec d
	jr nz, .small_delay_loop

	push de
	call .FindTargets
	jr c, .no_more_targets

	ldh [hTempRetreatCostCards], a
	xor a ; PLAY_AREA_ARENA
	ldh [hAIPkmnPowerEffectParam], a
	ld a, OPPACTION_6B15
	farcall AIMakeDecision
	pop de
	dec e
	jr nz, .loop_damage

.done
; return to main scene
	ld d, 60
.big_delay_loop
	call DoFrame
	dec d
	jr nz, .big_delay_loop
	ld a, OPPACTION_DUEL_MAIN_SCENE
	farcall AIMakeDecision
	ret

.no_more_targets
	pop de
	jr .done

; looks in the Play Area for certain Pokémon
.FindTargets:
	ld a, [wOpponentDeckID]
	cp IMMORTAL_POKEMON_DECK_ID
	jr z, .ImmortalPokemonDeck

	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	ld b, a
	ld c, PLAY_AREA_BENCH_1
	lb de, -1, -1
.loop_look_for_recipient_1
	ld a, c
	add DUELVARS_ARENA_CARD
	get_turn_duelist_var
	push de
	call GetCardIDFromDeckIndex
	; only the following Pokémon receives damage counters
	cp16 CHANSEY_LV55
	jr z, .potential_recipient_1
	cp16 KANGASKHAN_LV40
	jr z, .potential_recipient_1
	cp16 SNORLAX_LV20
	jr z, .potential_recipient_1
	cp16 MR_MIME_LV28
	jr z, .potential_recipient_1
	cp16 MR_MIME_LV20
	jr z, .potential_recipient_1
	pop de
.next_candidate_1
	inc c
	ld a, c
	cp b
	jr nz, .loop_look_for_recipient_1
	; check if a recipient was found
	; prefer to use card without energy cards
	ld a, e
	cp -1
	jr nz, .found_target
	; otherwise, use the one with energy cards
	ld a, d
	cp -1
	jr z, .target_not_found
.found_target
	or a
	ret

.potential_recipient_1
	pop de
	ld a, DUELVARS_ARENA_CARD_HP
	add c
	get_turn_duelist_var
	cp 20
	jr c, .next_candidate_1 ; less than 10 HP left
	ld d, c
	push de
	push bc
	ld a, c
	call CreateArenaOrBenchEnergyCardList
	pop bc
	pop de
	or a
	jr nz, .next_candidate_1 ; has energy cards
	; no energy cards
	ld e, c
	jr .next_candidate_1

.target_not_found
	scf
	ret

.ImmortalPokemonDeck:
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	ld b, a
	ld c, PLAY_AREA_BENCH_1
	lb de, PLAY_AREA_ARENA, 10
.loop_look_for_recipient_2
	ld a, c
	add DUELVARS_ARENA_CARD
	get_turn_duelist_var
	push de
	push bc
	call GetCardIDFromDeckIndex
	cp16 CHANSEY_LV55
	jr z, .potential_recipient_2
	cp16 SCYTHER_LV25
	jr z, .potential_recipient_2
	cp16 TENTACOOL
	jr z, .potential_recipient_2
	pop bc
	pop de
	jr .next_candidate_2
.potential_recipient_2
	pop bc
	pop de
	ld a, c
	add DUELVARS_ARENA_CARD_HP
	get_turn_duelist_var
	cp e
	jr c, .next_candidate_2 ; less HP
	jr z, .next_candidate_2 ; equal HP
	; has higher HP remaining
	ld e, a ; remaining HP
	ld d, c ; Play Area location
.next_candidate_2
	inc c
	ld a, c
	cp b
	jr nz, .loop_look_for_recipient_2
	ld a, d
	or a
	ret nz ; no recipient found

	; abort if Arena card is not
	; Mr. Mime or Kadabra
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call GetCardIDFromDeckIndex
	cp16 MR_MIME_LV28
	jr z, .mr_mime_or_kadabra
	cp16 KADABRA_LV39
	jr nz, .target_not_found

.mr_mime_or_kadabra
; find damage donor, can only be
; certain cards, and also chooses
; the card with most HP remaining
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	ld b, a
	ld c, PLAY_AREA_BENCH_1
	lb de, PLAY_AREA_ARENA, 0
.loop_find_donor
	ld a, c
	add DUELVARS_ARENA_CARD
	get_turn_duelist_var
	push de
	push bc
	call GetCardIDFromDeckIndex
	cp16 ABRA_LV14
	jr z, .potential_donor
	cp16 KADABRA_LV39
	jr z, .potential_donor
	cp16 MR_MIME_LV28
	jr z, .potential_donor
	pop bc
	pop de
	jr .next_donor_candidate
.potential_donor
	pop bc
	pop de
	ld a, c
	add DUELVARS_ARENA_CARD_HP
	get_turn_duelist_var
	cp e
	jr c, .next_donor_candidate ; new remaining HP is smaller
	jr z, .next_donor_candidate ; new remaining HP is equal
	ld e, a ; remaining HP
	ld d, c ; location
.next_donor_candidate
	inc c
	ld a, c
	cp b
	jr nz, .loop_find_donor
	ld a, d
	or a
	ret nz
	scf
	ret

; if Rain Dance is active, AI will attempt to attach
; energy cards until it has 1 energy card left in hand
HandleAIRainDanceEnergy:
	call CheckIfHasRainDanceActive
	ret nc ; no Rain Dance
	ld a, [wOpponentDeckID]
	cp ULTRA_REMOVAL_DECK_ID
	jr z, .ultra_removal_deck

.loop_play_energy_cards
	call CountEnergyCardsInHand
	cp 2
	ret c
	; at least 2 energy cards in hand
	farcall AIProcessAndTryToPlayEnergy
	jr c, .loop_play_energy_cards
	ret

.ultra_removal_deck
	ld de, PROFESSOR_OAK
	farcall LookForCardIDInHandList
	jr nc, .loop_play_energy_cards ; no Professor Oak
	call UltraRemovalDeckHandCheck
	jr nc, .loop_play_energy_cards ; has useful cards

	; has Professor Oak and no useful cards in hand
	; so call try attaching any energy cards that are left
	farcall AIProcessAndTryToPlayEnergy
	jr c, .loop_play_energy_cards
	ret

HandleAIPrehistoricDreamAndPoisonMist:
	farcall StubbedAIChooseRandomlyNotToDoAction
	ccf
	ret nc

	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	ld b, a
	ld c, PLAY_AREA_ARENA

.loop_play_area
	ld a, DUELVARS_ARENA_CARD
	add c
	get_turn_duelist_var
	ld [wAIPkmnPowerUserCardIndex], a
	push af
	push bc
	ld d, a
	ld a, c
	ldh [hTempPlayAreaLocation_ff9d], a
	ld e, FIRST_ATTACK_OR_PKMN_POWER
	call CopyAttackDataAndDamage_FromDeckIndex
	ld a, [wLoadedAttackCategory]
	cp POKEMON_POWER
	jr z, .is_pkmn_power
	pop bc
	jp .next_pop_af
.is_pkmn_power
	ld a, EFFECTCMDTYPE_INITIAL_EFFECT_2
	call TryExecuteEffectCommandFunction
	pop bc
	jp c, .next_pop_af
	push bc
	ldh a, [hTempPlayAreaLocation_ff9d]
	bank1call CheckIsIncapableOfUsingPkmnPower
	pop bc
	jp c, .next_pop_af
	pop af
	call GetCardIDFromDeckIndex
	push bc
	cp16 OMANYTE_LV20
	jr nz, .check_weezing
	call .HandlePrehistoricDream
	jr .next_pop_bc
.check_weezing
	cp16 WEEZING_LV26
	jr nz, .next_pop_bc
	call .HandlePoisonMist
.next_pop_bc
	pop bc
.next
	inc c
	ld a, c
	cp b
	jp nz, .loop_play_area
	ret
.next_pop_af
	pop af
	jr .next

; unreachable
	pop bc
	ret

.HandlePrehistoricDream:
	ld a, [wcc1a]
	or a
	ret nz
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call GetCardIDFromDeckIndex
	cp16 OMANYTE_LV19
	ld a, %10 ; only second attack
	jr z, .simulate_attack
	cp16 OMANYTE_LV20
	ld a, %10 ; only second attack
	jr z, .simulate_attack
	cp16 OMANYTE_LV22
	ld a, %10 ; only second attack
	jr z, .simulate_attack
	cp16 OMASTAR_LV32
	ld a, %11 ; any attack
	jr z, .simulate_attack
	cp16 OMASTAR_LV36
	ld a, %10 ; only second attack
	jr z, .simulate_attack
	cp16 KABUTO_LV9
	ld a, %10 ; only second attack
	jr z, .simulate_attack
	cp16 KABUTO_LV22
	ld a, %10 ; only second attack
	jr z, .simulate_attack
	cp16 KABUTOPS
	ld a, %11 ; any attack
	jr z, .simulate_attack
	cp16 AERODACTYL_LV28
	ld a, %10 ; only second attack
	jr z, .simulate_attack
	cp16 AERODACTYL_LV30
	ld a, %10 ; only second attack
	ret nz
.simulate_attack
	; temporarily add Pluspower to simulate
	; the attack boost by Prehistoric Dream
	push af
	ld a, DUELVARS_ARENA_CARD_ATTACHED_PLUSPOWER
	get_turn_duelist_var
	inc [hl]
	farcall AIProcessButDontUseAttack
	ld a, DUELVARS_ARENA_CARD_ATTACHED_PLUSPOWER
	get_turn_duelist_var
	dec [hl]
	pop bc
	ret nc ; no attack chosen

	ld a, [wSelectedAttack]
	inc a
	; if FIRST_ATTACK_OR_PKMN_POWER, a = 1
	; if SECOND_ATTACK,              a = 2
	and b
	ret z

	; use Prehistoric Dream
	ld a, [wAIPkmnPowerUserCardIndex]
	ldh [hTempCardIndex_ff9f], a
	ld a, OPPACTION_USE_PKMN_POWER
	farcall AIMakeDecision
	ld a, OPPACTION_EXECUTE_PKMN_POWER_EFFECT
	farcall AIMakeDecision
	ld a, OPPACTION_DUEL_MAIN_SCENE
	farcall AIMakeDecision
	ret

.HandlePoisonMist:
	call CheckIfArenaCardCanKnockOutDefendingCard
	jr nc, .cannot_ko
	; can KO
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call GetCardIDFromDeckIndex
	cp16 WEEZING_LV26
	ret nz ; not Weezing
.cannot_ko
	; exit if AI duelist has Poisoned Arena card
	ld a, DUELVARS_ARENA_CARD_STATUS
	get_turn_duelist_var
	and POISONED | DOUBLE_POISONED
	jr nz, .poisoned
	; bug, this check will never result in nz
	; since we just jumped on nz above
	ld a, DUELVARS_ARENA_CARD_STATUS
	get_turn_duelist_var
	and POISONED
	ret nz
.poisoned
	; exit if player has double poisoned Arena card
	ld a, DUELVARS_ARENA_CARD_STATUS
	call GetNonTurnDuelistVariable
	and PSN_DBLPSN
	cp DOUBLE_POISONED
	ret z ; player is double poisoned

	; use Poison Mist if player has poisoned Arena card
	ld a, DUELVARS_ARENA_CARD_STATUS
	call GetNonTurnDuelistVariable
	and POISONED
	jr nz, .use_poison_mist

	farcall AIProcessButDontUseAttack
	ret nc ; no selected attack
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call GetCardIDFromDeckIndex
	cp16 GRIMER_LV10
	jr z, .grimer
	cp16 WEEZING_LV26
	jr nz, .not_weezing

; weezing
	call CheckIfArenaCardCanKnockOutDefendingCard
	jr c, .use_poison_mist
	jr .check_snorlax

.not_weezing
	; check if AI's selected attack inflicts poison
	; if not, then exit
	ld a, [wSelectedAttack]
	ld e, a
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	ld d, a
	call CopyAttackDataAndDamage_FromDeckIndex
	ld a, ATTACK_FLAG1_ADDRESS | INFLICT_POISON_F
	call CheckLoadedAttackFlag
	ret nc ; doesn't inflict poison
	jr .check_snorlax

.grimer
	xor a ; PLAY_AREA_ARENA
	ldh [hTempPlayAreaLocation_ff9d], a
	ld [wSelectedAttack], a ; FIRST_ATTACK_OR_PKMN_POWER
	farcall CheckIfSelectedAttackIsUnusable
	ccf
	ret nc ; cannot use Poison Gas

.check_snorlax
	; if defending Pokémon is Snorlax lv20
	; and can use its Pkmn Power, then exit
	xor a ; PLAY_AREA_ARENA
	call SwapTurn
	bank1call CheckIsIncapableOfUsingPkmnPower
	call SwapTurn
	jr c, .use_poison_mist
	call SwapTurn
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call GetCardIDFromDeckIndex
	cp16 SNORLAX_LV20
	call SwapTurn
	ret z ; is Snorlax with active Pkmn Power

.use_poison_mist
	ld a, [wAIPkmnPowerUserCardIndex]
	ldh [hTempCardIndex_ff9f], a
	ld a, OPPACTION_USE_PKMN_POWER
	farcall AIMakeDecision
	ld a, OPPACTION_EXECUTE_PKMN_POWER_EFFECT
	farcall AIMakeDecision
	ld a, OPPACTION_DUEL_MAIN_SCENE
	farcall AIMakeDecision
	ret

; input:
; - a = number of Basic Pokémon to choose
AIChooseSummonMinionsCards:
	push af
	ld b, a
	ld a, $ff
	ldh [hTemp_ffa0], a
	ldh [hTempPlayAreaLocation_ffa1], a
	ldh [hPlayAreaEffectTarget], a
	ld a, b
	or a
	jr z, .zero
	ld a, [wOpponentDeckID]
	cp DANGEROUS_BENCH_DECK_ID
	jr z, .DangerousBenchDeck
	cp RONALDS_PSYCHIC_DECK_ID
	jr z, .RonaldsPsychicDeck
.zero
	pop af
	ret

.DangerousBenchDeck
	ld de, PIKACHU_LV14
	call CheckIfCardIDIsNotInHandOrPlayAreaAndIsInDeck
	call c, .AddCardToList
	ld de, ZAPDOS_LV40
	call CheckIfCardIDIsNotInHandOrPlayAreaAndIsInDeck
	call c, .AddCardToList
	ld de, SNORLAX_LV20
	call CheckIfCardIDIsNotInHandOrPlayAreaAndIsInDeck
	call c, .AddCardToList
	ld de, SNORLAX_LV35
	call CheckIfCardIDIsNotInHandOrPlayAreaAndIsInDeck
	call c, .AddCardToList
	ld de, HUNGRY_SNORLAX
	call CheckIfCardIDIsNotInHandOrPlayAreaAndIsInDeck
	call c, .AddCardToList
	ld de, DRATINI_LV12
	call CheckIfCardIDIsNotInHandOrPlayAreaAndIsInDeck
	call c, .AddCardToList
	jr .asm_391e1

.RonaldsPsychicDeck
	ld de, GASTLY_LV13
	call CheckIfCardIDIsNotInHandOrPlayAreaAndIsInDeck
	call c, .AddCardToList
	ld de, DRATINI_LV10
	call CheckIfCardIDIsNotInHandOrPlayAreaAndIsInDeck
	call c, .AddCardToList
	ld de, MEW_LV23
	call CheckIfCardIDIsNotInHandOrPlayAreaAndIsInDeck
	call c, .AddCardToList
	ld de, MEWTWO_LV67
	call CheckIfCardIDIsNotInHandOrPlayAreaAndIsInDeck
	call c, .AddCardToList
	ld de, KANGASKHAN_LV40
	call CheckIfCardIDIsNotInHandOrPlayAreaAndIsInDeck
	call c, .AddCardToList
	jr .asm_391e1

.AddCardToList:
	push af
	ldh a, [hTemp_ffa0]
	cp $ff
	jr nz, .second_pkmn
	pop af
	ldh [hTemp_ffa0], a
	ret
.second_pkmn
	pop af
	ldh [hTempPlayAreaLocation_ffa1], a
	add sp, $02
.asm_391e1
	pop af
	ld c, a
	ld b, $00
	ld hl, hTemp_ffa0
	add hl, bc
	ld [hl], $ff
	ret

; returns carry if player
; has a Pokémon in Play Area with given type
; a = TYPE_* constant
CheckIfPlayerHasPokemonOfType:
	ld b, a
	call SwapTurn
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
.loop_play_area
	ld a, [hli]
	cp $ff
	jr z, .no_carry
	call LoadCardDataToBuffer2_FromDeckIndex
	ld a, [wLoadedCard2Type]
	cp b
	jr nz, .loop_play_area
	call SwapTurn
	scf
	ret
.no_carry
	call SwapTurn
	or a
	ret

Func_3920b:
	ld a, [wOpponentDeckID]
	cp ROCK_BLAST_DECK_ID
	jr z, .rock_blast_deck
	cp SUDDEN_GROWTH_DECK_ID
	jr z, .sudden_growth_deck

.no_carry
	or a
	ret

.set_carry
	scf
	ret

.rock_blast_deck
	ldh a, [hTempPlayAreaLocation_ff9d]
	add DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call GetCardIDFromDeckIndex
	cp16 GEODUDE_LV16
	jr z, .set_carry
	cp16 GRAVELER_LV28
	jr z, .set_carry
	cp16 GOLEM_LV37
	jr z, .set_carry
	jr .no_carry

.sudden_growth_deck
	ldh a, [hTempPlayAreaLocation_ff9d]
	add DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call GetCardIDFromDeckIndex
	cp16 DARK_CLEFABLE
	jr z, .set_carry
	cp16 DARK_DRAGONAIR
	jr z, .set_carry
	cp16 DARK_DRAGONITE
	jr z, .set_carry
	jr .no_carry

Func_3926a:
	ld a, [wOpponentDeckID]
	cp ROCK_BLAST_DECK_ID
	jr z, .rock_blast_deck
	cp SUDDEN_GROWTH_DECK_ID
	jr z, .sudden_growth_deck

.no_carry
	or a
	ret

.check_attack
	ld hl, wSelectedAttack
	cp [hl]
	jr nz, .no_carry
	scf
	ret

.rock_blast_deck
	ldh a, [hTempPlayAreaLocation_ff9d]
	add DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call GetCardIDFromDeckIndex
	cp16 GEODUDE_LV16
	ld a, FIRST_ATTACK_OR_PKMN_POWER
	jr z, .check_attack
	cp16 GRAVELER_LV28
	ld a, SECOND_ATTACK
	jr z, .check_attack
	cp16 GOLEM_LV37
	ld a, SECOND_ATTACK
	jr z, .check_attack
	jr .no_carry

.sudden_growth_deck
	ldh a, [hTempPlayAreaLocation_ff9d]
	add DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call GetCardIDFromDeckIndex
	cp16 DARK_CLEFABLE
	ld a, SECOND_ATTACK
	jr z, .check_attack
	cp16 DARK_DRAGONAIR
	ld a, SECOND_ATTACK
	jr z, .check_attack
	cp16 DARK_DRAGONITE
	ld a, SECOND_ATTACK
	jr z, .check_attack
	jr .no_carry

; a = number of energy cards attached
Func_392db:
	ld [wd074], a
	ld a, [wOpponentDeckID]
	cp ROCK_BLAST_DECK_ID
	jr z, .rock_blast_deck
	cp SUDDEN_GROWTH_DECK_ID
	jr z, .sudden_growth_deck

.no_carry
	or a
	ret

.compare
	ld b, a ; max number of energy cards
	ld a, [wd074]
	cp b
	; carry if wd074 < b
	ret

.rock_blast_deck
	ldh a, [hTempPlayAreaLocation_ff9d]
	add DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call GetCardIDFromDeckIndex
	cp16 GEODUDE_LV16
	ld a, 3
	jr z, .compare
	cp16 GRAVELER_LV28
	ld a, 5
	jr z, .compare
	cp16 GOLEM_LV37
	ld a, 7
	jr z, .compare
	jr .no_carry

.sudden_growth_deck
	ldh a, [hTempPlayAreaLocation_ff9d]
	add DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call GetCardIDFromDeckIndex
	cp16 DARK_CLEFABLE
	ld a, 1
	jr z, .compare
	cp16 DARK_DRAGONAIR
	ld a, 1
	jr z, .compare
	cp16 DARK_DRAGONITE
	ld a, 1
	jr z, .compare
	jr .no_carry

Func_3934d:
	push bc
	ld a, [wOpponentDeckID]
	cp ROCK_BLAST_DECK_ID
	jr z, .rock_blast_deck
	cp SMASH_TO_MINCEMEAT_DECK_ID
	jr z, .smash_to_mincemeat_deck
.no_carry
	pop bc
	or a
	ret

.rock_blast_deck
	ldh a, [hTempPlayAreaLocation_ff9d]
	add DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call GetCardIDFromDeckIndex
	cp16 LICKITUNG_LV26
	jr z, .no_carry
	pop bc
	scf
	ret

.smash_to_mincemeat_deck
	ldh a, [hTempPlayAreaLocation_ff9d]
	add DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call GetCardIDFromDeckIndex
	cp16 CHANSEY_LV55
	jr z, .no_carry
	pop bc
	scf
	ret

; outputs number of a specific card in
; turn duelist's Play Area, starting
; from a given Play Area location
; inputs:
; - de = card ID
; - b = starting Play Area location
; outputs:
; - a and [wd074] = card count
CountCardIDInTurnDuelistPlayArea:
	xor a
	ld [wd074], a
.loop_play_area
	ld a, DUELVARS_ARENA_CARD
	add b
	get_turn_duelist_var
	cp $ff
	jr z, .done
	push bc
	push de
	call GetCardIDFromDeckIndex
	pop bc
	ld a, d
	cp b
	jr nz, .not_equal
	ld a, e
	cp c
	jr nz, .not_equal
	ld a, [wd074]
	inc a
	ld [wd074], a
.not_equal
	ld d, b
	ld e, c
	pop bc
	inc b
	ld a, MAX_PLAY_AREA_POKEMON
	cp b
	jr nz, .loop_play_area
.done
	ld a, [wd074]
	ret
; 0x393b4

SECTION "Bank e@57c7", ROMX[$57c7], BANK[$e]

Func_397c7:
	call SwapTurn
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	ld c, a
.loop_play_area
	ld a, b
	push bc
	farcall FindDoubleColorlessAttachedToCard
	pop bc
	jr c, .set_carry ; found Double Colorless energy
	inc b
	ld a, b
	cp c
	jr nz, .loop_play_area
; no carry
	call SwapTurn
	or a
	ret
.set_carry
	call SwapTurn
	scf
	ret

; runs through Player's whole deck and
; sets carry if there's any Pokemon other
; than MewtwoLv53.
CheckIfPlayerHasPokemonOtherThanMewtwoLv53:
	call SwapTurn
	ld e, 0
.loop_deck
	ld a, e
	call LoadCardDataToBuffer2_FromDeckIndex
	ld a, [wLoadedCard2Type]
	cp TYPE_ENERGY
	jp nc, .next ; can be a jr
	ld hl, wLoadedCard2ID
	cphl MEWTWO_LV53
	jr nz, .not_mewtwo1
.next
	inc e
	ld a, DECK_SIZE
	cp e
	jr nz, .loop_deck

; no carry
	call SwapTurn
	or a
	ret

.not_mewtwo1
	call SwapTurn
	scf
	ret

; returns no carry if, given the Player is using a MewtwoLv53 mill deck,
; the AI already has a Bench fully set up, in which case it
; will process some Trainer cards in hand (namely Energy Removals).
; this is used to check whether to skip some normal AI routines
; this turn and jump right to the attacking phase.
HandleAIAntiMewtwoDeckStrategy:
; return carry if Player is not playing MewtwoLv53 mill deck
	ld a, [wAIBarrierFlagCounter]
	bit AI_MEWTWO_MILL_F, a
	jr z, .set_carry

; else, check if there's been less than 2 turns
; without the Player using Barrier.
	cp AI_MEWTWO_MILL + 2
	jr c, .count_bench

; if there has been, reset wAIBarrierFlagCounter
; and return carry.
	xor a
	ld [wAIBarrierFlagCounter], a
	jr .set_carry

; else, check number of Pokemon that are set up in Bench
; if less than 4, return carry.
.count_bench
	farcall CountNumberOfSetUpBenchPokemon
	cp 4
	jr c, .set_carry

; if there's at least 4 Pokemon in the Bench set up,
; process Trainer hand cards of AI_TRAINER_CARD_PHASE_05
	ld a, AI_TRAINER_CARD_PHASE_05
	farcall AIProcessHandTrainerCards
	or a
	ret

.set_carry
	scf
	ret

; creates a list of all basic energy cards
; that are in card location given in a
; inputs:
; - a = CARD_LOCATION_* constant
; outputs:
; - wDuelTempList = list of card indices
; - a = list size
; - carry set if empty list
CreateBasicEnergyCardListInLocation:
	ld [wTempAI], a
	lb de, 0, 0
	ld hl, wDuelTempList
.loop_deck
	ld a, DUELVARS_CARD_LOCATIONS
	add e
	push hl
	get_turn_duelist_var
	ld hl, wTempAI
	cp [hl]
	pop hl
	jr nz, .next_card
	ld a, e
	push de
	push hl
	call GetCardIDFromDeckIndex
	pop hl
	cp16 DOUBLE_COLORLESS_ENERGY
	pop de
	jr nc, .next_card ; not basic energy card
	ld a, e
	ld [hli], a ; deck index
	inc d ; increment count
.next_card
	inc e
	ld a, DECK_SIZE
	cp e
	jr nz, .loop_deck

	ld a, $ff
	ld [hl], a ; terminating byte
	ld a, d
	or a
	jr z, .empty
; not empty
	ld a, d ; unnecessary
	ret
.empty
	scf
	ret
; 0x39873

SECTION "Bank e@5a0a", ROMX[$5a0a], BANK[$e]

; outputs in a the number of energy cards
; the turn holder has in hand
CountEnergyCardsInHand:
	bank1call CreateEnergyCardListFromHand
	ld a, 0
	ret c ; no energy cards
	ld b, -1
	ld hl, wDuelTempList
.loop_energy_cards
	inc b
	ld a, [hli]
	cp $ff
	jr nz, .loop_energy_cards
	ld a, b
	or a
	ret

; accepts as input 2 card IDs
; returns carry if card ID in de is in deck and
; not in Hand or Play Area, and card in bc is in
; Hand or Play Area
; inputs:
; - de = card ID to search in Deck
; - bc = card ID to look in Hand and Play Area
CheckEvolutionaryLightTarget:
	push bc
	push de
	ld a, CARD_LOCATION_DECK
	farcall FindCardIDInLocation
	pop de
	pop bc
	ret nc ; not found in deck
	ld [wd073], a ; deck index
	push bc
	push de
	ld d, b
	ld e, c
	call CheckIfCardIDIsInHandOrPlayArea
	pop de
	pop bc
	ret nc ; not found in Hand or Play Area
	push bc
	call CheckIfCardIDIsInHandOrPlayArea
	pop de
	jr c, .no_carry
	ld a, [wd073]
	scf
	ret
.no_carry
	or a
	ret

; returns carry if card ID in de is found in Deck
; but not in Hand, and card ID in bc is found in Play Area
; inputs:
; - de = card ID 1
; - bc = card ID 2
FindUsableEvolutionInDeck:
	push bc
	push de
	ld a, CARD_LOCATION_DECK
	farcall FindCardIDInLocation
	pop de
	pop bc
	ret nc ; card ID 1 not found in deck
	ld [wd073], a
	push de
	ld d, b
	ld e, c
	farcall FindCardIDInTurnDuelistsPlayArea
	pop de
	ret nc ; card ID 2 not found in Play Area
	push de
	farcall LookForCardIDInHandList
	pop bc
	jr c, .no_carry  ; card ID 1 found in Hand
	ld a, [wd073]
	scf
	ret
.no_carry
	or a
	ret

Func_39a6a:
	push bc
	push de
	ld a, CARD_LOCATION_DECK
	farcall FindCardIDInLocation
	pop de
	pop bc
	ret nc
	ld [wd073], a
	push bc
	call CheckIfCardIDIsInHandOrPlayArea
	pop de
	jr c, .asm_39a89
	farcall LookForCardIDInHandList
	ret nc
	ld a, [wd073]
	scf
	ret
.asm_39a89
	or a
	ret

; inputs:
; - de = card ID to search in Deck
; - bc = card ID to look in Hand and Play Area
Func_39a8b:
	push bc
	push de
	call CheckEvolutionaryLightTarget
	pop bc
	pop de
	ret c
	call Func_39a6a
	ret
; 0x39a97

SECTION "Bank e@5b3f", ROMX[$5b3f], BANK[$e]

; input:
; - de = card ID
CheckIfCardIDIsInHandOrPlayArea:
	push de
	farcall LookForCardIDInHandList
	pop de
	ret c ; found in hand
	ld b, PLAY_AREA_ARENA
	farcall FindCardIDInTurnDuelistsPlayArea
	ret c ; found in Play Area
	or a
	ret
; 0x39b4f

SECTION "Bank e@5bdd", ROMX[$5bdd], BANK[$e]

; returns carry if hand contains
; more than 1 copy of card ID
; input:
; - de = card ID
CheckIfHandHasRepeatedCard:
	push de
	call CreateHandCardList
	pop de
	ld hl, wDuelTempList
	ld c, 0
.loop_cards
	ld a, [hli]
	cp $ff
	ret z
	ldh [hTempCardIndex_ff98], a
	push de
	call GetCardIDFromDeckIndex
	ld a, e
	ld b, d
	pop de
	cp e
	jr nz, .loop_cards
	ld a, b
	cp d
	jr nz, .loop_cards
	ld a, c
	or a
	jr nz, .repeated
	inc c
	jr nz, .loop_cards
.repeated
	ldh a, [hTempCardIndex_ff98]
	scf
	ret
; 0x39c06

SECTION "Bank e@5c77", ROMX[$5c77], BANK[$e]

; return carry flag if attack is high recoil.
AICheckIfAttackIsHighRecoil:
	farcall AIProcessButDontUseAttack
	ret nc
	ld a, [wSelectedAttack]
	ld e, a
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	ld d, a
	call CopyAttackDataAndDamage_FromDeckIndex
	ld a, ATTACK_FLAG1_ADDRESS | HIGH_RECOIL_F
	call CheckLoadedAttackFlag
	ret

; input:
; - a = ?
Func_39c8d:
	ld [wd082], a
	xor a ; PLAY_AREA_ARENA
	ldh [hTempPlayAreaLocation_ff9d], a
	call CheckIfDefendingPokemonCanKnockOut
	jr nc, .no_carry
	ld d, a
	ld a, DUELVARS_ARENA_CARD_HP
	get_turn_duelist_var
	ld h, a ; remaining HP
	ld e, PLAY_AREA_ARENA
	call GetCardDamageAndMaxHP
	push hl
	ld hl, wd082
	cp [hl]
	pop hl
	jr c, .asm_39cad
	ld a, [wd082]
.asm_39cad
	ld l, a
	ld a, h ; a = remaining HP
	add l   ; a += min(card damage, wd082)
	sub d   ; a -= ?
	jr c, .no_carry
	jr z, .no_carry
	scf
	ret
.no_carry
	or a
	ret

CheckIfArenaCardCanKnockOutDefendingCard_CheckHand:
	xor a ; PLAY_AREA_ARENA
	ldh [hTempPlayAreaLocation_ff9d], a
	farcall CheckIfAnyAttackKnocksOutDefendingCard
	ret nc
	farcall CheckIfSelectedAttackIsUnusable
	ccf
	ret c
	farcall LookForEnergyNeededForAttackInHand
	ret
; 0x39ccc

SECTION "Bank e@5d24", ROMX[$5d24], BANK[$e]

CheckIfCardIDIsInDeckAndNotInHand:
	push de
	farcall LookForCardIDInHandList
	pop de
	jr c, .no_carry ; is in hand
	ld a, CARD_LOCATION_DECK
	farcall FindCardIDInLocation
	ret c ; is in deck
.no_carry
	or a
	ret

; input:
; - de = card ID
CheckIfCardIDIsNotInHandOrPlayAreaAndIsInDeck:
	push de
	call CheckIfCardIDIsInHandOrPlayArea
	pop de
	jr c, .no_carry
	ld a, CARD_LOCATION_DECK
	farcall FindCardIDInLocation
	ret c
.no_carry
	or a
	ret
; 0x39d45

SECTION "Bank e@6186", ROMX[$6186], BANK[$e]

; return carry if duelist has Bench Pokémon,
; Arena card has no effect that stops it from retreating
; and has enough energy cards to pay retreat cost
CheckIfArenaCardCanRetreat:
	ldh a, [hTempPlayAreaLocation_ff9d]
	push af
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	cp 1
	jr z, .no_carry ; only 1 Pokemon in Play Area
	bank1call CheckUnableToRetreatDueToEffect
	jr c, .no_carry ; cannot retreat
	xor a ; PLAY_AREA_ARENA
	ldh [hTempPlayAreaLocation_ff9d], a
	call GetPlayAreaCardRetreatCost
	ld b, a
	ld e, PLAY_AREA_ARENA
	call GetPlayAreaCardAttachedEnergies
	ld a, [wTotalAttachedEnergies]
	cp b
	jr c, .no_carry ; doesn't have enough energy to retreat
	pop af
	ldh [hTempPlayAreaLocation_ff9d], a
	scf
	ret
.no_carry
	pop af
	ldh [hTempPlayAreaLocation_ff9d], a
	or a
	ret

BadGuysDeckAIDecideReelIn:
	; first fetch an Oddish and Dark Gloom
	ld de, ODDISH_LV21
	ld a, CARD_LOCATION_DISCARD_PILE
	farcall FindCardIDInLocation
	jr nc, .try_psyduck_and_golduck
	; got an Oddish, try a Dark Gloom next
	ldh [hTemp_ffa0], a
	ld de, DARK_GLOOM
	ld a, CARD_LOCATION_DISCARD_PILE
	farcall FindCardIDInLocation
	jr nc, .try_psyduck_and_golduck
	ldh [hTempPlayAreaLocation_ffa1], a
	jr .find_third_card

.try_psyduck_and_golduck
	; fetch a Psyduck and Dark Golduck instead
	ld de, PSYDUCK_LV16
	ld a, CARD_LOCATION_DISCARD_PILE
	farcall FindCardIDInLocation
	jr nc, .try_charmander_and_charmeleon
	ldh [hTemp_ffa0], a
	ld de, DARK_GOLDUCK
	ld a, CARD_LOCATION_DISCARD_PILE
	farcall FindCardIDInLocation
	jr nc, .try_charmander_and_charmeleon
	ldh [hTempPlayAreaLocation_ffa1], a
	jr .find_third_card

.try_charmander_and_charmeleon
	; fetch a Charmander and Dark Charmeleon instead
	ld de, CHARMANDER_LV9
	ld a, CARD_LOCATION_DISCARD_PILE
	farcall FindCardIDInLocation
	jr nc, .try_slowpoke_and_slowbro
	ldh [hTemp_ffa0], a
	ld de, DARK_CHARMELEON
	ld a, CARD_LOCATION_DISCARD_PILE
	farcall FindCardIDInLocation
	jr nc, .try_slowpoke_and_slowbro
	ldh [hTempPlayAreaLocation_ffa1], a
	jr .find_third_card

.try_slowpoke_and_slowbro
	ld de, SLOWPOKE_LV16
	ld a, CARD_LOCATION_DISCARD_PILE
	farcall FindCardIDInLocation
	ret nc
	ldh [hTemp_ffa0], a
	ld de, DARK_SLOWBRO
	ld a, CARD_LOCATION_DISCARD_PILE
	farcall FindCardIDInLocation
	ret nc
	ldh [hTempPlayAreaLocation_ffa1], a

.find_third_card
	ld de, ODDISH_LV21
	ld a, CARD_LOCATION_DISCARD_PILE
	farcall FindCardIDInLocation
	call c, .AddCardIfNotInListAlready
	ld de, DARK_GLOOM
	ld a, CARD_LOCATION_DISCARD_PILE
	farcall FindCardIDInLocation
	call c, .AddCardIfNotInListAlready
	ld de, PSYDUCK_LV16
	ld a, CARD_LOCATION_DISCARD_PILE
	farcall FindCardIDInLocation
	call c, .AddCardIfNotInListAlready
	ld de, DARK_GOLDUCK
	ld a, CARD_LOCATION_DISCARD_PILE
	farcall FindCardIDInLocation
	call c, .AddCardIfNotInListAlready
	ld de, CHARMANDER_LV9
	ld a, CARD_LOCATION_DISCARD_PILE
	farcall FindCardIDInLocation
	call c, .AddCardIfNotInListAlready
	ld de, DARK_CHARMELEON
	ld a, CARD_LOCATION_DISCARD_PILE
	farcall FindCardIDInLocation
	call c, .AddCardIfNotInListAlready
	ld de, SLOWPOKE_LV16
	ld a, CARD_LOCATION_DISCARD_PILE
	farcall FindCardIDInLocation
	call c, .AddCardIfNotInListAlready
	ld de, DARK_SLOWBRO
	ld a, CARD_LOCATION_DISCARD_PILE
	farcall FindCardIDInLocation
	call c, .AddCardIfNotInListAlready
	scf
	ret

.AddCardIfNotInListAlready:
	ld hl, hTemp_ffa0
	cp [hl]
	ret z ; equal to first card
	inc hl
	cp [hl]
	ret z ; equal to second card
	inc hl
	ld [hl], a
	add sp, $02 ; exit BadGuysDeckAIDecideReelIn
	scf
	ret
; 0x3a28d

SECTION "Bank e@6441", ROMX[$6441], BANK[$e]

; checks if player has Bench cards and Arena card can retreat
; then checks if has Dark Muk in own Play Area
; if both are true, search player's Bench for card
; with at least 2 energy retreat cost
; return carry and its Play Area location if found
Func_3a441:
	ld de, DARK_MUK
	ld b, PLAY_AREA_ARENA
	farcall FindCardIDInTurnDuelistsPlayArea
	ret nc ; no Dark Muk
	ld a, DUELVARS_ARENA_CARD_STATUS
	call GetNonTurnDuelistVariable
	or a
	ret nz ; player Arena card has status condition
	call SwapTurn
	call CheckIfArenaCardCanRetreat
	call SwapTurn
	ret nc ; can't retreat
	call SwapTurn
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	cp 1
	; bug, doesn't swap turn back to opponent
	ret z ; player has no bench

	ld d, a ; number of Play Area cards
	ld e, PLAY_AREA_BENCH_1
.loop_play_area
	ld a, e
	ldh [hTempPlayAreaLocation_ff9d], a
	push de
	call GetPlayAreaCardRetreatCost
	pop de
	cp 2
	jr nc, .set_carry ; more than 2 cost
	inc e
	ld a, e
	cp d
	jr nz, .loop_play_area
; no carry
	call SwapTurn
	or a
	ret
.set_carry
	call SwapTurn
	ld a, e
	scf
	ret

; returns carry if current Arena card
; can KO the Defending card with
; any of its attacks, and that attack can be used
CheckIfArenaCardCanKnockOutDefendingCard:
	ldh a, [hTempPlayAreaLocation_ff9d]
	push af
	xor a ; PLAY_AREA_ARENA
	ldh [hTempPlayAreaLocation_ff9d], a
	farcall CheckIfAnyAttackKnocksOutDefendingCard
	jr nc, .cannot_ko
	farcall CheckIfSelectedAttackIsUnusable
	jp c, .cannot_ko ; can be jr
	pop af
	ldh [hTempPlayAreaLocation_ff9d], a
	scf
	ret
.cannot_ko
	pop af
	ldh [hTempPlayAreaLocation_ff9d], a
	or a
	ret

; looks for energy card(s) in list at wDuelTempList
; depending on energy flags set in a
; return carry if successful in finding card
; input:
;	a = energy flags needed
CheckEnergyFlagsNeededInList:
	ld e, a
	ld hl, wDuelTempList
	push de
.loop_cards
	ld a, [hli]
	cp $ff
	jp z, .no_carry
	call GetCardIDFromDeckIndex
	cp16 RAINBOW_ENERGY
	jr nz, .fire
	; rainbow matches with anything
	pop de
	scf
	ret
.fire
	cp16 FIRE_ENERGY
	jr nz, .grass
	ld a, FIRE_F
	jr .check_energy
.grass
	cp16 GRASS_ENERGY
	jr nz, .lightning
	ld a, GRASS_F
	jr .check_energy
.lightning
	cp16 LIGHTNING_ENERGY
	jr nz, .water
	ld a, LIGHTNING_F
	jr .check_energy
.water
	cp16 WATER_ENERGY
	jr nz, .fighting
	ld a, WATER_F
	jr .check_energy
.fighting
	cp16 FIGHTING_ENERGY
	jr nz, .psychic
	ld a, FIGHTING_F
	jr .check_energy
.psychic
	cp16 PSYCHIC_ENERGY
	jr nz, .colorless
	ld a, PSYCHIC_F
	jr .check_energy
.colorless
	cp16 DOUBLE_COLORLESS_ENERGY
	jr z, .check_colorless
	cp16 POTION_ENERGY
	jr z, .check_colorless
	cp16 FULLHEAL_ENERGY
	jr z, .check_colorless
	cp16 RECYCLE_ENERGY
	jp nz, .loop_cards
.check_colorless
	ld a, COLORLESS_F

; if energy card matches required energy, return carry
.check_energy
	pop de
	ld d, e
	and e
	ld e, d
	push de
	jp z, .loop_cards
	pop de
	scf
	ret

.no_carry
	pop de
	or a
	ret

; returns in a the energy cost of both attacks from card index in a
; represented by energy flags
; i.e. each bit represents a different energy type cost
; if any colorless energy is required, all bits are set
; input:
;	a = card index
; output:
;	a = bits of each energy requirement
GetAttacksEnergyCostBits:
	call LoadCardDataToBuffer2_FromDeckIndex
	ld hl, wLoadedCard2Atk1EnergyCost
	call .GetEnergyCostBits
	ld b, a

	push bc
	ld hl, wLoadedCard2Atk2EnergyCost
	call .GetEnergyCostBits
	pop bc
	or b
	ret

; returns in a the energy cost of an attack in [hl]
; represented by energy flags
; i.e. each bit represents a different energy type cost
; if any colorless energy is required, all bits are set
; input:
;	[hl] = Loaded card attack energy cost
; output:
;	a = bits of each energy requirement
.GetEnergyCostBits:
	ld c, $00
	ld a, [hli]
	ld b, a

; fire
	and $f0
	jr z, .grass
	ld c, FIRE_F
.grass
	ld a, b
	and $0f
	jr z, .lightning
	ld a, GRASS_F
	or c
	ld c, a
.lightning
	ld a, [hli]
	ld b, a
	and $f0
	jr z, .water
	ld a, LIGHTNING_F
	or c
	ld c, a
.water
	ld a, b
	and $0f
	jr z, .fighting
	ld a, WATER_F
	or c
	ld c, a
.fighting
	ld a, [hli]
	ld b, a
	and $f0
	jr z, .psychic
	ld a, FIGHTING_F
	or c
	ld c, a
.psychic
	ld a, b
	and $0f
	jr z, .colorless
	ld a, PSYCHIC_F
	or c
	ld c, a
.colorless
	ld a, [hli]
	ld b, a
	and $f0
	jr z, .done
	ld a, %11111111
	or c ; unnecessary
	ld c, a
.done
	ld a, c
	ret

; returns carry if there's an evolution card
; that can evolve card in hTempPlayAreaLocation_ff9d,
; and that card needs energy to use wSelectedAttack.
CheckIfEvolutionNeedsEnergyForAttack:
	call CreateHandCardList
	ldh a, [hTempPlayAreaLocation_ff9d]
	add DUELVARS_ARENA_CARD
	get_turn_duelist_var
	farcall CheckCardEvolutionInHandOrDeck
	jr c, .has_evolution
	or a
	ret

.has_evolution
	ld b, a
	ldh a, [hTempPlayAreaLocation_ff9d]
	add DUELVARS_ARENA_CARD
	get_turn_duelist_var
	push af
	ld [hl], b
	farcall CheckEnergyNeededForAttack
	jr c, .not_enough_energy
	ldh a, [hTempPlayAreaLocation_ff9d]
	add DUELVARS_ARENA_CARD
	get_turn_duelist_var
	pop af
	ld [hl], a
	or a
	ret

.not_enough_energy
	ldh a, [hTempPlayAreaLocation_ff9d]
	add DUELVARS_ARENA_CARD
	get_turn_duelist_var
	pop af
	ld [hl], a
	scf
	ret

; returns in e the card ID of the energy required for
; the Discard/Energy Boost attack loaded in wSelectedAttack.
; if it's ZapdosLv64's Thunderbolt attack, return no carry.
; if it's Charizard's Fire Spin or Exeggutor's Big Eggsplosion
; attack, don't return energy card ID, but set carry.
; output:
;	b = 1 if needs color energy, 0 otherwise;
;	c = 1 if only needs colorless energy, 0 otherwise;
;	carry set if not ZapdosLv64's Thunderbolt attack.
GetEnergyCardForDiscardOrEnergyBoostAttack:
; load card ID and check selected attack index.
	ldh a, [hTempPlayAreaLocation_ff9d]
	add DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call LoadCardDataToBuffer2_FromDeckIndex
	ld a, [wSelectedAttack]
	or a
	jr z, .first_attack

; check if second attack is ZapdosLv64's Thunderbolt,
; Charizard's Fire Spin or Exeggutor's Big Eggsplosion,
; for these to be treated differently.
; for both attacks, load its energy cost.
	ld hl, wLoadedCard2ID
	cphl ZAPDOS_LV64
	jr z, .zapdos_lv64
	cphl CHARIZARD_LV76
	jr z, .charizard_or_exeggutor
	cphl EXEGGUTOR
	jr z, .charizard_or_exeggutor
	ld hl, wLoadedCard2Atk2EnergyCost
	jr .fire
.first_attack
	ld hl, wLoadedCard2Atk1EnergyCost

; check which energy color the attack requires,
; and load in e the card ID of corresponding energy card,
; then return carry flag set.
.fire
	ld a, [hli]
	ld b, a
	and $f0
	jr z, .grass
	ld de, FIRE_ENERGY
	jr .set_carry
.grass
	ld a, b
	and $0f
	jr z, .lightning
	ld de, GRASS_ENERGY
	jr .set_carry
.lightning
	ld a, [hli]
	ld b, a
	and $f0
	jr z, .water
	ld de, LIGHTNING_ENERGY
	jr .set_carry
.water
	ld a, b
	and $0f
	jr z, .fighting
	ld de, WATER_ENERGY
	jr .set_carry
.fighting
	ld a, [hli]
	ld b, a
	and $f0
	jr z, .psychic
	ld de, FIGHTING_ENERGY
	jr .set_carry
.psychic
	ld de, PSYCHIC_ENERGY

.set_carry
	lb bc, TRUE, FALSE
	scf
	ret

; for ZapdosLv64's Thunderbolt attack, return with no carry.
.zapdos_lv64
	or a
	ret

; Charizard's Fire Spin and Exeggutor's Big Eggsplosion,
; return carry.
.charizard_or_exeggutor
	lb bc, FALSE, TRUE
	scf
	ret

; called when second attack is determined by AI to have
; more AI score than the first attack, so that it checks
; whether the first attack is a better alternative.
CheckWhetherToSwitchToFirstAttack:
; this checks whether the first attack is also viable
; (has more than minimum score to be used)
	ld a, [wFirstAttackAIScore]
	cp $50
	jr c, .keep_second_attack

; first attack has more than minimum score to be used,
; check if it can KO, in case it can't
; then the AI keeps second attack as selection.
	xor a ; PLAY_AREA_ARENA
	ldh [hTempPlayAreaLocation_ff9d], a
	; a = FIRST_ATTACK_OR_PKMN_POWER
	farcall EstimateDamage_VersusDefendingCard
	ld a, DUELVARS_ARENA_CARD_HP
	call GetNonTurnDuelistVariable
	ld hl, wDamage
	sub [hl] ; HP - damage
	jr z, .check_min_damage
	jr nc, .keep_second_attack ; cannot KO

; check if even minDamage can KO, in case it can't
; then the AI keeps second attack as selection.
.check_min_damage
	ld a, DUELVARS_ARENA_CARD_HP
	call GetNonTurnDuelistVariable
	ld hl, wAIMinDamage
	sub [hl]
	jr z, .check_flag
	jr nc, .keep_second_attack ; cannot KO

; first attack can ko, check flags from second attack
; in case its effect is to heal user or nullify/weaken damage
; next turn, keep second attack as the option.
.check_flag
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	ld d, a
	ld e, SECOND_ATTACK
	call CopyAttackDataAndDamage_FromDeckIndex
	ld a, ATTACK_FLAG2_ADDRESS | HEAL_USER_F
	call CheckLoadedAttackFlag
	jr c, .keep_second_attack
	ld a, ATTACK_FLAG2_ADDRESS | NULLIFY_OR_WEAKEN_ATTACK_F
	call CheckLoadedAttackFlag
	jr c, .keep_second_attack
	farcall CheckUseZapdosThunderboltInTenThousandVoltsDeck
	jr c, .keep_second_attack
; otherwise, switch to first attack
	xor a ; FIRST_ATTACK_OR_PKMN_POWER
	ld [wSelectedAttack], a
	ret
.keep_second_attack
	ld a, SECOND_ATTACK
	ld [wSelectedAttack], a
	ret

; checks if Defending Pokémon can damage card
; that is in play area location given in a
; returns carry if can damage
; input:
; - a = PLAY_AREA_* constant
CheckIfCanDamageDefendingPokemon:
	ldh [hTempPlayAreaLocation_ff9d], a
	xor a ; FIRST_ATTACK_OR_PKMN_POWER
	ld [wSelectedAttack], a
	farcall CheckIfSelectedAttackIsUnusable
	jr c, .check_second_attack
	xor a ; FIRST_ATTACK_OR_PKMN_POWER
	farcall EstimateDamage_VersusDefendingCard
	ld a, [wDamage]
	or a
	jr nz, .set_carry ; can damage
.check_second_attack
	ld a, SECOND_ATTACK
	ld [wSelectedAttack], a
	farcall CheckIfSelectedAttackIsUnusable
	jr c, .no_carry
	ld a, SECOND_ATTACK
	farcall EstimateDamage_VersusDefendingCard
	ld a, [wDamage]
	or a
	jr nz, .set_carry ; can damage
.no_carry
	or a
	ret
.set_carry
	scf
	ret

; checks if defending Pokémon can knock out
; card at hTempPlayAreaLocation_ff9d with any of its attacks
; and if so, stores the damage to wAIFirstAttackDamage and wAISecondAttackDamage
; sets carry if any on the attacks knocks out
; also outputs the largest damage dealt in a
; input:
;	[hTempPlayAreaLocation_ff9d] = location of card to check
; output:
;	a = largest damage of both attacks
;	carry set if can knock out
CheckIfDefendingPokemonCanKnockOut:
	xor a
	ld [wAIFirstAttackDamage], a
	ld [wAISecondAttackDamage], a

	; first attack
	call .CheckAttack
	jr nc, .second_attack
	ld a, [wDamage]
	ld [wAIFirstAttackDamage], a
.second_attack
	ld a, SECOND_ATTACK
	call .CheckAttack
	jr nc, .return_if_neither_kos
	ld a, [wDamage]
	ld [wAISecondAttackDamage], a
	jr .compare

.return_if_neither_kos
	ld a, [wAIFirstAttackDamage]
	or a
	ret z

.compare
	ld a, [wAIFirstAttackDamage]
	ld b, a
	ld a, [wAISecondAttackDamage]
	cp b
	jr nc, .set_carry ; wAIFirstAttackDamage < wAISecondAttackDamage
	ld a, b
.set_carry
	scf
	ret

; return carry if defending Pokémon can knock out
; card at hTempPlayAreaLocation_ff9d
; input:
;	a = attack index
;	[hTempPlayAreaLocation_ff9d] = location of card to check
.CheckAttack:
	ld [wSelectedAttack], a
	ldh a, [hTempPlayAreaLocation_ff9d]
	push af
	xor a ; PLAY_AREA_ARENA
	ldh [hTempPlayAreaLocation_ff9d], a
	call SwapTurn
	farcall CheckIfSelectedAttackIsUnusable
	call SwapTurn
	pop bc
	ld a, b
	ldh [hTempPlayAreaLocation_ff9d], a
	jr c, .done

; player's active Pokémon can use attack
	ld a, [wSelectedAttack]
	farcall EstimateDamage_FromDefendingPokemon
	ldh a, [hTempPlayAreaLocation_ff9d]
	add DUELVARS_ARENA_CARD_HP
	get_turn_duelist_var
	ld hl, wDamage
	sub [hl]
	jr z, .can_ko
	ret

.can_ko
	scf
	ret

.done
	or a
	ret

; returns carry if turn holder has
; Rain Dance active in own Play Area
CheckIfHasRainDanceActive:
	ld c, PLAY_AREA_ARENA
.loop_play_area
	ld a, DUELVARS_ARENA_CARD
	add c
	get_turn_duelist_var
	cp $ff
	ret z ; not found
	ld b, a
	push bc
	ld a, c
	bank1call CheckIsIncapableOfUsingPkmnPower
	jr c, .next_pokemon
	pop bc
	push bc
	ld a, b
	call GetCardIDFromDeckIndex
	cp16 BLASTOISE_LV52
	jr z, .found
	cp16 BLASTOISE_ALT_LV52
	jr z, .found
.next_pokemon
	pop bc
	inc c
	ld a, [wMaxNumPlayAreaPokemon]
	cp c
	jr nz, .loop_play_area
	or a
	ret
.found
	pop bc
	ld a, c
	scf
	ret

; used by Ultra Removal Deck AI to check
; whether to use Professor Oak
; returns carry if:
; - has Golduck or Blastoise in Arena and has no energy cards in hand
; - has no evolutions in hand that can be used for a Pokémon in Play Area
UltraRemovalDeckHandCheck:
	ld de, GOLDUCK_LV27
	ld b, PLAY_AREA_ARENA
	farcall FindCardIDInTurnDuelistsPlayArea
	jr c, .count_energy_cards_in_hand
	ld de, BLASTOISE_LV52
	ld b, PLAY_AREA_ARENA
	farcall FindCardIDInTurnDuelistsPlayArea
	jr c, .count_energy_cards_in_hand
	call .CheckIfHasUsefulEvolutionInHand
	ccf
	; carry set if has no evolution in hand to use
	ret

.count_energy_cards_in_hand
	call CountEnergyCardsInHand
	ret ; carry set if has no energy cards in hand

.CheckIfHasUsefulEvolutionInHand:
; creates hand list and looks for a card
; that can evolve any Pokémon in Play Area
	call CreateHandCardList
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
.loop_play_area
	ld a, [hli]
	cp $ff
	ret z
	push hl
	farcall CheckIfPokemonEvolutionIsFoundInHand
	pop hl
	jr nc, .loop_play_area
	; found evolution card
	ret
; 0x3a7a0

SECTION "Bank e@6803", ROMX[$6803], BANK[$e]

Func_3a803:
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call GetCardIDFromDeckIndex
	cp16 GOLDUCK_LV27
	jr z, .golduck_in_arena
.no_carry
	or a
	ret
.golduck_in_arena
	ld a, SECOND_ATTACK
	ld [wSelectedAttack], a
	xor a ; PLAY_AREA_ARENA
	ldh [hTempPlayAreaLocation_ff9d], a
	farcall CheckIfSelectedAttackIsUnusable
	jr c, .no_carry
	ld b, PLAY_AREA_BENCH_1
	call Func_397c7
	ld a, b
	ret c ; found Double Colorless energy
	call SwapTurn
	ld e, PLAY_AREA_BENCH_1
	farcall Func_4a3dc
	call SwapTurn
	ret
; 0x3a837

SECTION "Bank e@6887", ROMX[$6887], BANK[$e]

Func_3a887:
	bank1call GetArenaCardColor
	call TranslateColorToWR
	ld [wd075], a
	call SwapTurn
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	ld b, a
	ld c, PLAY_AREA_BENCH_1
.loop_bench
	ld a, c
	cp b
	jr z, .no_carry
	inc c
	push bc
	bank1call GetArenaOrBenchCardWeakness
	pop bc
	ld hl, wd075
	cp [hl]
	jr nz, .loop_bench
	; is weak to Arena card
	call SwapTurn
	ld a, c
	dec a
	scf
	ret
.no_carry
	call SwapTurn
	or a
	ret
; 0x3a8b5

SECTION "Bank e@6994", ROMX[$6994], BANK[$e]

AIChooseStareTarget:
	bank1call CheckGoopGasAttackAndToxicGasActive
	jr nc, .pkmn_powers_are_active
	or a
	ret
.pkmn_powers_are_active
	; if any of the following are
	; in player's Play Area, select them
	ld de, VENUSAUR_LV67
	farcall FindCardIDInNonTurnDuelistsPlayArea
	ret c
	ld de, VENUSAUR_ALT_LV67
	farcall FindCardIDInNonTurnDuelistsPlayArea
	ret c
	ld de, CHARIZARD_LV76
	farcall FindCardIDInNonTurnDuelistsPlayArea
	ret c
	ld de, CHARIZARD_ALT_LV76
	farcall FindCardIDInNonTurnDuelistsPlayArea
	ret c
	ld de, BLASTOISE_LV52
	farcall FindCardIDInNonTurnDuelistsPlayArea
	ret c
	ld de, BLASTOISE_ALT_LV52
	farcall FindCardIDInNonTurnDuelistsPlayArea
	ret c
	ld de, ALAKAZAM_LV42
	farcall FindCardIDInNonTurnDuelistsPlayArea
	ret c
	ld de, MR_MIME_LV28
	farcall FindCardIDInNonTurnDuelistsPlayArea
	ret c
	ld de, SLOWBRO_LV26
	farcall FindCardIDInNonTurnDuelistsPlayArea
	ret c
	ld de, GENGAR_LV38
	farcall FindCardIDInNonTurnDuelistsPlayArea
	ret c

	ld a, DUELVARS_ARENA_CARD_STATUS
	call GetNonTurnDuelistVariable
	or a
	jr z, .skip_venusaur_lv64
	; player's Arena card is statused
	; if AI also has status condition, then just skip
	ld a, DUELVARS_ARENA_CARD_STATUS
	get_turn_duelist_var
	or a
	jr nz, .skip_venusaur_lv64
	; AI's Arena card isn't statused
	; bug, this is supposed to check for VENUSAUR_LV64
	ld de, DARK_VENUSAUR
	farcall FindCardIDInNonTurnDuelistsPlayArea
	ret c

.skip_venusaur_lv64
	; only select Dark Primeape if it's Arena card
	ld de, DARK_PRIMEAPE
	farcall FindCardIDInNonTurnDuelistsPlayArea
	jr nc, .check_clefairy_doll_and_hypno
	or a
	scf
	ret z

.check_clefairy_doll_and_hypno
	; select Hypno lv30 if there's a Clefairy Doll in Play Area as well
	ld de, CLEFAIRY_DOLL
	farcall FindCardIDInNonTurnDuelistsPlayArea
	jr nc, .no_clefairy_doll
	ld de, HYPNO_LV30
	farcall FindCardIDInNonTurnDuelistsPlayArea
	ret c

.no_clefairy_doll
	; select Weezing lv26 if AI's Arena card is poisoned
	ld a, DUELVARS_ARENA_CARD_STATUS
	get_turn_duelist_var
	and POISONED
	jr z, .no_poisoned
	ld de, WEEZING_LV26
	farcall FindCardIDInNonTurnDuelistsPlayArea
	ret c

.no_poisoned
	; if any of the following are
	; in player's Play Area, select them
	ld de, DARK_STARMIE
	farcall FindCardIDInNonTurnDuelistsPlayArea
	ret c
	ld de, DARK_GENGAR
	farcall FindCardIDInNonTurnDuelistsPlayArea
	ret c
	ld de, VILEPLUME
	farcall FindCardIDInNonTurnDuelistsPlayArea
	ret c

	; only select Venomoth lv28 if it's Arena card
	ld de, VENOMOTH_LV28
	farcall FindCardIDInNonTurnDuelistsPlayArea
	jr nc, .check_dodrio
	or a
	scf
	ret z

.check_dodrio
	ld de, DODRIO_LV28
	farcall FindCardIDInNonTurnDuelistsPlayArea
	ret c

	ld de, DRAGONITE_LV45
	ld b, PLAY_AREA_BENCH_1
	; bug, this checks the AI's Play Area
	; should call SwapTurn before calling following routine
	farcall FindCardIDInTurnDuelistsPlayArea
	ret c

	; only select Charmander lv9 if it's Arena card
	ld de, CHARMANDER_LV9
	farcall FindCardIDInNonTurnDuelistsPlayArea
	jr nc, .asm_3aa6f
	or a
	scf
	ret z

.asm_3aa6f
	; only select Dark Gloom if AI's Arena card is not confused
	ld a, DUELVARS_ARENA_CARD_STATUS
	get_turn_duelist_var
	and CNF_SLP_PRZ
	cp CONFUSED
	jr nz, .skip_dark_gloom
	; not confused
	ld de, DARK_GLOOM
	farcall FindCardIDInNonTurnDuelistsPlayArea
	ret c

.skip_dark_gloom
	ld de, DARK_KADABRA
	farcall FindCardIDInNonTurnDuelistsPlayArea
	ret c

	; only select Drowzee lv10 if AI's Arena card is not asleep
	ld a, DUELVARS_ARENA_CARD_STATUS
	get_turn_duelist_var
	and CNF_SLP_PRZ
	cp ASLEEP
	jr nz, .skip_drowzee
	; not asleep
	ld de, DROWZEE_LV10
	farcall FindCardIDInNonTurnDuelistsPlayArea
	ret c

.skip_drowzee
	ld de, DARK_DRAGONAIR
	farcall FindCardIDInNonTurnDuelistsPlayArea
	ret c

	ld a, DUELVARS_ARENA_CARD_STATUS
	; bug, should call GetNonTurnDuelistVariable instead
	get_turn_duelist_var
	or a
	jr z, .skip_wigglytuff
	ld de, WIGGLYTUFF_LV40
	farcall FindCardIDInNonTurnDuelistsPlayArea
	ret c

.skip_wigglytuff
	; only select Omanyte lv20 if any of the following
	; Pokémon are the player's Arena card
	call SwapTurn
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call GetCardIDFromDeckIndex
	call SwapTurn
	cp16 OMANYTE_LV19
	jr z, .has_fossil_pkmn
	cp16 OMANYTE_LV20
	jr z, .has_fossil_pkmn
	cp16 OMANYTE_LV22
	jr z, .has_fossil_pkmn
	cp16 OMASTAR_LV32
	jr z, .has_fossil_pkmn
	cp16 OMASTAR_LV36
	jr z, .has_fossil_pkmn
	cp16 KABUTO_LV9
	jr z, .has_fossil_pkmn
	cp16 KABUTO_LV22
	jr z, .has_fossil_pkmn
	cp16 KABUTOPS
	jr z, .has_fossil_pkmn
	cp16 AERODACTYL_LV28
	jr z, .has_fossil_pkmn
	cp16 AERODACTYL_LV30
	jr nz, .skip_omanyte_lv20
.has_fossil_pkmn
	ld de, OMANYTE_LV20
	farcall FindCardIDInNonTurnDuelistsPlayArea
	ret c

.skip_omanyte_lv20
	ld de, KABUTO_LV22
	farcall FindCardIDInNonTurnDuelistsPlayArea
	ret c
	ld de, MAGNEMITE_LV15
	farcall FindCardIDInNonTurnDuelistsPlayArea
	ret c

	ld de, MYSTERIOUS_FOSSIL
	ld a, CARD_LOCATION_DISCARD_PILE
	; bug, should call SwapTurn to check player's Discard Pile instead
	farcall FindCardIDInLocation
	jr nc, .skip_omanyte_lv22
	ld de, OMANYTE_LV22
	farcall FindCardIDInNonTurnDuelistsPlayArea
	ret c

.skip_omanyte_lv22
	ld de, DARK_IVYSAUR
	farcall FindCardIDInNonTurnDuelistsPlayArea
	ret c

	ld de, DARK_DUGTRIO
	farcall FindCardIDInNonTurnDuelistsPlayArea
	jr c, .has_dugtrio
	; player has no Dark Dugtrio
	ld a, [wOpponentDeckID]
	cp POWER_OF_DARKNESS_DECK_ID
	jr nz, .skip_dark_ivysaur
.has_dugtrio
	; bug, this never happens because if a Dark Ivysaur is
	; present in player's Play Area, then it's already been selected above
	ld de, DARK_IVYSAUR
	farcall FindCardIDInNonTurnDuelistsPlayArea
	ret c

.skip_dark_ivysaur
	ld de, GRS_MEWTWO
	farcall FindCardIDInNonTurnDuelistsPlayArea
	ret c
	ld de, DARK_CLEFABLE
	farcall FindCardIDInNonTurnDuelistsPlayArea
	ret c
	ld de, DRAGONITE_LV43
	farcall FindCardIDInNonTurnDuelistsPlayArea
	ret

HandleScrollMenu:
	xor a
	ld [wMenuInputSFX], a
	ldh a, [hDPadHeld]
	or a
	jp z, .call_update_func ; no keys
	ld b, a
	ld a, [wNumMenuItems]
	ld c, a
	ld a, [wCurScrollMenuItem]
	bit D_UP_F, b
	jr z, .check_d_down
; d-up
	push af
	ld a, SFX_01
	ld [wMenuInputSFX], a
	pop af
	dec a
	bit 7, a
	jr z, .scroll_done
; wrap around
	ld a, [wScrollMenuScrollOffset]
	or a
	jr z, .no_scroll_up
	dec a
	ld [wScrollMenuScrollOffset], a
	ld hl, wScrollMenuScrollFunc
	call CallIndirect
	xor a
	jr .scroll_done
.no_scroll_up
	xor a
	ld [wMenuInputSFX], a
	jr .scroll_done

.check_d_down
	bit D_DOWN_F, b
	jr z, .call_update_func
; d-down
	push af
	ld a, SFX_01
	ld [wMenuInputSFX], a
	pop af
	inc a
	cp c
	jr c, .scroll_done
	push af
	ld a, [wUnableToScrollDown]
	or a
	jr nz, .already_at_bottom
	ld a, [wScrollMenuScrollOffset]
	inc a
	ld [wScrollMenuScrollOffset], a
	ld hl, wScrollMenuScrollFunc
	call CallIndirect
	pop af
	dec a
	jr .scroll_done
.already_at_bottom
	pop af
	dec a
	push af
	xor a
	ld [wMenuInputSFX], a
	pop af

.scroll_done
	push af
	call .draw_invisible_cursor
	pop af
	ld [wCurScrollMenuItem], a
	xor a
	ld [wScrollMenuCursorBlinkCounter], a
	jr .call_update_func ; unnecessary jump

.call_update_func
	ld a, [wCurScrollMenuItem]
	ld [hCurMenuItem], a
	ld hl, wMenuUpdateFunc
	ld a, [hli]
	or [hl]
	jr z, .null
	ld a, [hld]
	ld l, [hl]
	ld h, a
	ld a, [hCurMenuItem]
	call CallHL
	jr nc, .blink_cursor

.asm_3ac12
	call .draw_visible_cursor
	ld a, $01
	farcall PlayAcceptOrDeclineSFX
	ld a, [wCurScrollMenuItem]
	ld e, a
	ld a, [hCurMenuItem]
	scf
	ret

.null
	ldh a, [hKeysPressed]
	and A_BUTTON | B_BUTTON
	jr z, .play_menu_input_sfx
	and A_BUTTON
	jr nz, .asm_3ac12
; b button
	ld a, $ff
	ld [hCurMenuItem], a
	farcall PlayAcceptOrDeclineSFX
	scf
	ret

.play_menu_input_sfx
	ld a, [wMenuInputSFX]
	or a
	jr z, .blink_cursor
	call PlaySFX

.blink_cursor
	ld hl, wScrollMenuCursorBlinkCounter
	ld a, [hl]
	inc [hl]
	and %1111
	ret nz
	ld a, [wMenuVisibleCursorTile]
	bit 4, [hl]
	jr z, .draw_cursor
.draw_invisible_cursor
	ld a, [wMenuInvisibleCursorTile]
.draw_cursor
	ld e, a
	ld a, [wMenuXSeparation]
	ld l, a
	ld a, [wCurScrollMenuItem]
	ld h, a
	call HtimesL
	ld a, l
	ld hl, wMenuCursorXOffset
	add [hl]
	ld b, a
	ld a, [wMenuYSeparation]
	ld l, a
	ld a, [wCurScrollMenuItem]
	ld h, a
	call HtimesL
	ld a, l
	ld hl, wMenuCursorYOffset
	add [hl]
	ld c, a
	ld a, e
	call WriteByteToBGMap0
	or a
	ret

.draw_visible_cursor:
	ld a, [wMenuVisibleCursorTile]
	jr .draw_cursor
; 0x3ac82

SECTION "Bank e@6d06", ROMX[$6d06], BANK[$e]

FillBoosterPackMenuItems:
	call UpdateBoosterPackMenuArrows
	ld a, [wScrollMenuScrollOffset]
	lb de, 5, 2
	ld b, $05
.loop
	push af
	push bc
	push de
	call .PrintBoosterPackName
	pop de
	pop bc
	pop af
	ret c
	dec b
	ret z
	inc a
	inc e
	inc e
	jr .loop

; prints Booster Pack name in case
; player has obtained that booster pack
.PrintBoosterPackName:
	push af
	call InitTextPrinting
	pop af
	ld b, $00
	ld c, %1
.loop_find
	cp b
	jr z, .found
	sla c
	inc b
	jr .loop_find
.found
	call EnableSRAM
	ld a, [sBoosterPacksObtained]
	call DisableSRAM
	and c
	ld hl, .ObtainedTextIDs
	jr nz, .has_booster
	ld hl, .NotObtainedTextIDs
.has_booster
	ld a, b
	add a ; *2
	ld c, a
	ld b, $00
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	call ProcessTextFromID
	ret

.ObtainedTextIDs:
	tx Item1BeginningPokemonText
	tx Item2LegendaryPowerText
	tx Item3IslandOfFossilText
	tx Item4PsychicBattleText
	tx Item5SkyFlyingPokemonText
	tx Item6WeAreTeamRocketText
	tx Item7TeamRocketsAmbitionText
	tx Item8PromotionalCardText

.NotObtainedTextIDs:
	tx Item1BeginningPokemonText
	tx Item2LegendaryPowerText
	tx Item3IslandOfFossilLockedText
	tx Item4PsychicBattleLockedText
	tx Item5SkyFlyingPokemonLockedText
	tx Item6WeAreTeamRocketLockedText
	tx Item7TeamRocketsAmbitionLockedText
	tx Item8PromotionalCardLockedText

UpdateBoosterPackMenuArrows:
	ld a, [wScrollMenuScrollOffset]
	or a
	jr z, .no_up_arrow
	ld a, SYM_CURSOR_U
	jr .draw_up_arrow
.no_up_arrow
	ld a, SYM_BOX_TOP
.draw_up_arrow
	lb bc, 18, 0
	call WriteByteToBGMap0
	ld a, [wScrollMenuScrollOffset]
	cp $03
	jr nc, .no_down_arrow
	xor a
	ld [wUnableToScrollDown], a
	ld a, SYM_CURSOR_D
	jr .draw_down_arrow
.no_down_arrow
	ld a, $01
	ld [wUnableToScrollDown], a
	ld a, SYM_BOX_TOP
.draw_down_arrow
	lb bc, 18, 12
	call WriteByteToBGMap0
	ret
; 0x3ada1

Func_3ada1:
	xor a
	ld [wScrollMenuScrollOffset], a
	ld de, $2d3
	ld hl, wDeckMachineTitleText
	ld [hl], e
	inc hl
	ld [hl], d
	call ClearScreenAndDrawDeckMachineScreen
	ld a, $32
	ld [wNumDeckMachineEntries], a
	xor a
.asm_3adb7
	ld hl, $5eac
	farcall InitializeScrollMenuParameters
	call DrawListScrollArrows
	call PrintNumSavedDecks
	ldtx hl, PleaseSelectDeckText
	call DrawWideTextBox_PrintText
	ldtx de, PleaseSelectDeckText
	call InitDeckMachineDrawingParams
	call HandleDeckMachineSelection.start
	jr c, .asm_3adb7
	cp $ff
	ret z
	ld b, a
	ld a, [wScrollMenuScrollOffset]
	add b
	ld [wSelectedDeckMachineEntry], a
	farcall Func_9287
	call DrawWideTextBox
	ld hl, $6e7b
	call PlaceTextItems
.asm_3aded:
	call DoFrame
	farcall Func_9292
	jp nc, .asm_3aded
	cp $ff
	jr nz, .asm_3ae01
	ld a, [wTempScrollMenuItem]
	jp .asm_3adb7
.asm_3ae01
	ld a, [wMusicStereoPanningBackup]
	sla a
	ld hl, wCurSongBankBackup
	add [hl]
	or a
	jr nz, .asm_3ae33
	call CheckIfSelectedDeckMachineEntryIsEmpty
	jr nc, .asm_3ae1d
	call Func_3b2db
	ld a, [wTempScrollMenuItem]
	jp c, .asm_3adb7
	jr .asm_3ae65
.asm_3ae1d
	ldtx hl, DeleteSavedDeckPromptText
	call YesOrNoMenuWithText
	ld a, [wTempScrollMenuItem]
	jr c, .asm_3adb7
	call Func_3b2db
	ld a, [wTempScrollMenuItem]
	jp c, .asm_3adb7
	jr .asm_3ae65
.asm_3ae33
	cp $01
	jr nz, .asm_3ae53
	call CheckIfSelectedDeckMachineEntryIsEmpty
	jr c, .asm_3ae47
	call Func_3b3fa
	ld a, [wTempScrollMenuItem]
	jp c, .asm_3adb7
	jr .asm_3ae65
.asm_3ae47
	ldtx hl, NoDecksSavedToMachineText
	call DrawWideTextBox_WaitForInput
	ld a, [wTempScrollMenuItem]
	jp .asm_3adb7
.asm_3ae53
	cp $02
	jr nz, .asm_3ae7a
	call CheckIfSelectedDeckMachineEntryIsEmpty
	jr c, .asm_3ae47
	call Func_3b4eb
	ld a, [wTempScrollMenuItem]
	jp nc, .asm_3adb7
.asm_3ae65
	ld a, [wTempScrollMenuScrollOffset]
	ld [wScrollMenuScrollOffset], a
	call ClearScreenAndDrawDeckMachineScreen
	call DrawListScrollArrows
	call PrintNumSavedDecks
	ld a, [wTempScrollMenuItem]
	jp .asm_3adb7
.asm_3ae7a
	ret
; 0x3ae7b

SECTION "Bank e@6e8c", ROMX[$6e8c], BANK[$e]

; sets the number of cursor positions for deck machine menu,
; sets the text ID to show given by de
; and sets DrawDeckMachineScreen as the update function
; de = text ID
InitDeckMachineDrawingParams:
	ld a, NUM_DECK_MACHINE_VISIBLE_DECKS
	ld [wNumMenuItems], a
	ld hl, wDeckMachineText
	ld [hl], e
	inc hl
	ld [hl], d
	ld hl, DrawDeckMachineScreen
	ld d, h
	ld a, l
	ld hl, wScrollMenuScrollFunc
	ld [hli], a
	ld [hl], d
	xor a
	ld [wd119], a
	ret

	; handles player input inside the Deck Machine screen
; the Start button opens up the deck confirmation menu
; and returns carry
; otherwise, returns no carry and selection made in a
HandleDeckMachineSelection:
.start
	call DoFrame
	call HandleScrollMenu
	jr c, .selection_made

	call .HandleListJumps
	jr c, .start
	ldh a, [hDPadHeld]
	and START
	jr z, .start

; start btn
	ld a, [wScrollMenuScrollOffset]
	ld [wTempScrollMenuScrollOffset], a
	ld b, a
	ld a, [wCurScrollMenuItem]
	ld [wTempScrollMenuItem], a
	add b
	ld c, a
	inc a
	or $80
	ld [wCurDeck], a

	; get pointer to selected deck cards
	; and if it's an empty deck, jump to start
	ld a, c
	call Func_3afb8
	push hl
	farcall CheckIfDeckHasCards
	pop hl
	jr c, .start

; show deck confirmation screen with deck cards
; and return carry set
	push hl
	ld bc, DECK_NAME_SIZE
	add hl, bc
	ld d, h
	ld e, l
	pop hl
	ld a, $01
	farcall PlayAcceptOrDeclineSFX
	farcall OpenDeckConfirmationMenu
	ld a, [wTempScrollMenuScrollOffset]
	ld [wScrollMenuScrollOffset], a
	call ClearScreenAndDrawDeckMachineScreen
	call DrawListScrollArrows
	call PrintNumSavedDecks
	ld a, [wTempScrollMenuItem]
	ld [wCurScrollMenuItem], a
	scf
	ret

.selection_made
	call HandleScrollMenu.draw_visible_cursor
	ld a, [wScrollMenuScrollOffset]
	ld [wTempScrollMenuScrollOffset], a
	ld a, [wCurScrollMenuItem]
	ld [wTempScrollMenuItem], a
	ld a, [hCurMenuItem]
	or a
	ret

; handles right and left input for jumping several entries at once
; returns carry if jump was made
.HandleListJumps
	ld a, [wScrollMenuScrollOffset]
	ld c, a
	ldh a, [hDPadHeld]
	cp D_RIGHT
	jr z, .d_right
	cp D_LEFT
	jr z, .d_left
	or a
	ret

.d_right
	ld a, [wScrollMenuScrollOffset]
	add NUM_DECK_MACHINE_VISIBLE_DECKS
	ld b, a
	add NUM_DECK_MACHINE_VISIBLE_DECKS
	ld hl, wNumDeckMachineEntries
	cp [hl]
	jr c, .got_new_pos
	ld a, [wNumDeckMachineEntries]
	sub NUM_DECK_MACHINE_VISIBLE_DECKS
	ld b, a
	jr .got_new_pos

.d_left
	ld a, [wScrollMenuScrollOffset]
	sub NUM_DECK_MACHINE_VISIBLE_DECKS
	ld b, a
	jr nc, .got_new_pos
	ld b, 0 ; first entry

.got_new_pos
	ld a, b
	ld [wScrollMenuScrollOffset], a
	cp c
	jr z, .set_carry
	; play SFX if jump was made
	; and update UI
	ld a, SFX_01
	call PlaySFX
	call DrawDeckMachineScreen
	call PrintNumSavedDecks
.set_carry
	scf
	ret

; returns carry if deck corresponding to the
; entry selected in the Deck Machine menu is empty
CheckIfSelectedDeckMachineEntryIsEmpty:
	ld a, [wSelectedDeckMachineEntry]
	call Func_3afb8
	farcall CheckIfDeckHasCards
	ret

ClearScreenAndDrawDeckMachineScreen:
	xor a
	ld [wTileMapFill], a
	call ZeroObjectPositions
	call EmptyScreen
	ld a, $01
	ld [wVBlankOAMCopyToggle], a
	call LoadSymbolsFont
	call LoadDuelCardSymbolTiles
	bank1call SetDefaultPalettes
	lb de, $3c, $ff
	call SetupText
	lb de, 0, 0
	lb bc, 20, 13
	call DrawRegularTextBox
	call SetDeckMachineTitleText
	call GetSavedDeckPointers
	call PrintVisibleDeckMachineEntries
	call GetSavedDeckCount
	call EnableLCD
	ret

; prints wDeckMachineTitleText as title text
SetDeckMachineTitleText:
	ld hl, wDeckMachineTitleText
	ld a, [hli]
	ld h, [hl]
	ld l, a
	lb de, 1, 0
	call Func_2c4b
	ret

CopyBBytesFromHLToDE_Bank0e:
.loop
	ld a, [hli]
	ld [de], a
	inc de
	dec b
	jr nz, .loop
	ret

Func_3afb1:
.asm_3afb1
	ld a, [hli]
	ld [de], a
	or a
	ret z
	inc de
	jr .asm_3afb1
; 0x3afb8

SECTION "Bank e@6fb8", ROMX[$6fb8], BANK[$e]

; a = deck index in wMachineDeckPtrs
Func_3afb8:
	push bc
	push de
	add a ; *2
	ld c, a
	ld b, $00
	ld hl, wMachineDeckPtrs
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, h
	cp HIGH(STARTOF(WRAM0))
	jr c, .done ; done if not from WRAM

	call SwitchToWRAM2
	push hl
	ld hl, wc000
	ld de, w2d58e
	ld b, $80
	call CopyBBytesFromHLToDE_Bank0e
	pop hl
	ld de, wc000
	ld b, $80
	call CopyBBytesFromHLToDE_Bank0e

	call SwitchToWRAM1
	ld hl, wc000
	ld de, wd4c8
	ld b, $80
	call CopyBBytesFromHLToDE_Bank0e
	call SwitchToWRAM2
	ld hl, w2d58e
	ld de, wc000
	ld b, $80
	call CopyBBytesFromHLToDE_Bank0e
	call SwitchToWRAM1
	ld hl, wd4c8
.done
	pop de
	pop bc
	ret

; save all sSavedDecks pointers in wMachineDeckPtrs
GetSavedDeckPointers:
	ld a, NUM_DECK_SAVE_MACHINE_SLOTS
	add NUM_DECK_SAVE_MACHINE_SLOTS ; add a is better
	ld hl, wMachineDeckPtrs
	farcall ClearNBytesFromHL
	ld de, wMachineDeckPtrs
	ld hl, sSavedDecks
	ld bc, DECK_COMPRESSED_STRUCT_SIZE
	ld a, NUM_DECK_SAVE_MACHINE_SLOTS
.loop_saved_decks
	push af
	ld a, l
	ld [de], a
	inc de
	ld a, h
	ld [de], a
	inc de
	add hl, bc
	pop af
	dec a
	jr nz, .loop_saved_decks
	ret

; given the cursor position in the deck machine menu
; prints the deck names of all entries that are visible
PrintVisibleDeckMachineEntries:
	ld a, [wScrollMenuScrollOffset]
	lb de, 2, 2
	ld b, NUM_DECK_MACHINE_VISIBLE_DECKS
.loop
	push af
	push bc
	push de
	call PrintDeckMachineEntry
	pop de
	pop bc
	pop af
	ret c ; jump never made?
	dec b
	ret z ; no more entries
	inc a
	inc e
	inc e
	jr .loop
; 0x3b043

SECTION "Bank e@7048", ROMX[$7048], BANK[$e]

DrawDeckMachineScreen:
	call DrawListScrollArrows
	ld hl, hffbb
	ld [hl], $01
	call SetDeckMachineTitleText
	lb de, 1, 14
	call InitTextPrinting
	ld hl, wDeckMachineText
	ld a, [hli]
	ld h, [hl]
	ld l, a
	call ProcessTextFromID
	ld hl, hffbb
	ld [hl], $00
	jr PrintVisibleDeckMachineEntries

Func_3b069:
	ld hl, $7078
	ld d, h
	ld a, l
	ld hl, wScrollMenuScrollFunc
	ld [hli], a
	ld [hl], d
	xor a
	ld [wd119], a
	ret

Func_3b078:
	ld de, $202
	ld b, $04
	ld a, [wNumDeckMachineEntries]
	cp b
	jr nc, .asm_3b084
	ld b, a
.asm_3b084
	xor a
.asm_3b085
	push af
	push bc
	push de
	call PrintDeckMachineEntry
	pop de
	pop bc
	pop af
	ret c
	dec b
	ret z
	inc a
	inc e
	inc e
	jr .asm_3b085
; 0x3b096

SECTION "Bank e@7096", ROMX[$7096], BANK[$e]

; prints the deck name of the deck corresponding
; to index in register a, from wMachineDeckPtrs
; also checks whether the deck can be built
; either by dismantling other decks or not,
; and places the corresponding symbol next to the name
PrintDeckMachineEntry:
	ld b, a
	push bc
	ld hl, wDefaultText
	inc a
	farcall ConvertToNumericalDigits
	ldfw [hl], "・"
	inc hl
	ld [hl], TX_END
	call InitTextPrinting
	ld hl, wDefaultText
	call ProcessText
	pop af

; get the deck corresponding to input index
; and append its name to wDefaultText
	push af
	call Func_3afb8
	inc d
	inc d
	inc d
	push de
	farcall AppendDeckName
	pop de
	pop bc
	jr nc, .valid_deck

; invalid deck, give it the default
; empty deck name ("--------------")
	call InitTextPrinting
	ldtx hl, EmptyDeckNameText
	call ProcessTextFromID
	ld d, 12
	inc e
	call InitTextPrinting
	ld hl, .text
	call ProcessText
	scf
	ret

.valid_deck
	push de
	push bc

	ld a, $0 ; no decks dismantled
	call CheckIfCanBuildSavedDeck
	pop bc
	ld hl, wDefaultText
	jr c, .cannot_build

	; deck can be built
	xor a
	ld [wd49b], a
	ld hl, wd49f
	ld d, $00
	ld e, b
	sla e ; *2
	add hl, de
	ld [hl], a
	ld [wd49e], a
	ld hl, wd49f
	ld d, $00
	ld e, b
	sla e
	inc e ; *2 + 1
	add hl, de
	ld [hl], a
	ldfw de, "○" ; can build
	jp .asm_3b18e

.cannot_build
	; deck cannot be built
	ldfw de, " "
	call Func_22ca

	; figure out how many cards are being
	; used on the other decks
	push bc
	call .CountCardsNeededToBuildInBuiltDecks
	ld [wd49b], a
	pop bc
	ld hl, wd49f
	ld d, $00
	ld e, b
	sla e ; *2
	add hl, de
	ld [hl], a

	push bc
	ld a, $ff ; all decks
	call .CountCardsNeededToBuildInCardCollection
	ld [wd49e], a
	pop bc
	ld hl, wd49f
	ld d, $00
	ld e, b
	sla e
	inc e ; *2 + 1
	add hl, de
	ld [hl], a
	pop de

	push af
	push de
	ld d, 12
	inc e
	call InitTextPrinting
	ld hl, .text
	call ProcessText
	pop de
	pop af
	push de
	or a
	jr z, .need_dismantle

	; players doesn't own all necessary cards
	pop de
	push de
	inc e
	ld d, $10
	call InitTextPrinting
	ldfw de, "×"
	call Func_22ca
	ld a, [wd49e]
	ld hl, wDefaultText
	farcall ConvertToNumericalDigits
	ld [hl], TX_END
	ld hl, wDefaultText
	call ProcessText

.need_dismantle
	pop de
	ld a, [wd49b]
	or a
	jr z, .asm_3b18c
	inc e
	ld d, 12
	call InitTextPrinting
	ldfw de, "※"
	call Func_22ca
	ld a, [wd49b]
	ld hl, wDefaultText
	farcall ConvertToNumericalDigits
	ld [hl], TX_END
	ld hl, wDefaultText
	call ProcessText
.asm_3b18c
	or a
	ret

.asm_3b18e
	call Func_22ca
	pop de
	ld d, 12
	inc e
	call InitTextPrinting
	ld hl, .text
	call ProcessText
	or a
	ret

.text
	db "<SPACE><SPACE><SPACE><SPACE><SPACE><SPACE><SPACE>"
	done

; de = card ID
.GetCardCountInScratchCardCollection:
	call SwitchToWRAM2
	push hl
	ld hl, wScratchCardCollection
	add hl, de
	ld a, [hl]
	pop hl
	call SwitchToWRAM1
	ret

; de = card ID
.DecrementCardCountInScratchCardCollection:
	call SwitchToWRAM2
	push hl
	ld hl, wScratchCardCollection
	add hl, de
	dec [hl]
	pop hl
	call SwitchToWRAM1
	ret

; b = saved deck index
.CountCardsNeededToBuildInBuiltDecks:
	push bc
	ld a, $80 ; only cards that are in built decks
	farcall CreateCardCollectionListWithDeckCards

	; copy to wScratchCardCollection
	call SwitchToWRAM2
	ld hl, wTempCardCollection
	ld de, wScratchCardCollection
	ld b, 0 ; $100 bytes
	call CopyBBytesFromHLToDE_Bank0e
	ld hl, wTempCardCollection + $100
	ld de, wScratchCardCollection + $100
	ld b, 0 ; $100 bytes
	call CopyBBytesFromHLToDE_Bank0e
	call SwitchToWRAM1

	xor a ; all owned cards
	farcall CreateCardCollectionListWithDeckCards
	pop bc

	; here, wTempCardCollection holds all cards that
	; the player owns, including in and out of decks
	; wScratchCardCollection holds all cards that
	; are in built decks only

	ld a, b
	call Func_3afb8
	ld bc, DECK_NAME_SIZE
	add hl, bc
	ld d, h
	ld e, l
	ld hl, wTempSavedDeckCards
	farcall CopyDeckFromSRAM

	ld hl, wTempSavedDeckCards
	lb bc, DECK_SIZE + 1, 0
.loop_deck
	dec b
	jr z, .got_count_1
	ld e, [hl]
	inc hl
	ld d, [hl]
	inc hl
	push hl
	ld hl, wTempCardCollection
	add hl, de
	ld a, [hl]
	and CARD_COUNT_MASK
	or a
	jr z, .zero_count
	dec [hl]
	pop hl
	jr .loop_deck
.zero_count
	call .GetCardCountInScratchCardCollection
	or a
	jr z, .next_card
	call .DecrementCardCountInScratchCardCollection
	inc c
.next_card
	pop hl
	jr .loop_deck
.got_count_1
	ld a, c ; total number of cards found in built decks
	ret

; b = saved deck index
.CountCardsNeededToBuildInCardCollection:
	push bc
	farcall CreateCardCollectionListWithDeckCards
	pop bc

	ld a, b
	call Func_3afb8
	ld bc, DECK_NAME_SIZE
	add hl, bc
	ld d, h
	ld e, l
	ld hl, wTempSavedDeckCards
	farcall CopyDeckFromSRAM
	ld hl, wTempSavedDeckCards
	lb bc, DECK_SIZE + 1, 0
.loop_collection
	dec b
	jr z, .got_count_2
	ld e, [hl]
	inc hl
	ld d, [hl]
	inc hl
	push hl
	ld hl, wc000
	add hl, de
	ld a, [hl]
	and CARD_COUNT_MASK
	or a
	jr z, .next_card_in_collection
	dec a
	ld [hl], a
	pop hl
	jr .loop_collection
.next_card_in_collection
	inc c
	pop hl
	jr .loop_collection
.got_count_2
	ld a, c
	ret

; counts how many decks in sSavedDecks are not empty
; stores value in wNumSavedDecks
GetSavedDeckCount:
	call EnableSRAM
	ld hl, sSavedDecks
	ld bc, DECK_COMPRESSED_STRUCT_SIZE
	ld d, NUM_DECK_SAVE_MACHINE_SLOTS
	ld e, 0
.loop
	ld a, [hl]
	or a
	jr z, .empty_slot
	inc e
.empty_slot
	dec d
	jr z, .got_count
	add hl, bc
	jr .loop
.got_count
	ld a, e
	ld [wNumSavedDecks], a
	call DisableSRAM
	ret

; prints "[wNumSavedDecks]/50"
PrintNumSavedDecks:
	ld a, [wNumSavedDecks]
	ld hl, wDefaultText
	farcall ConvertToNumericalDigits
	ld a, TX_SYMBOL
	ld [hli], a
	ld a, SYM_SLASH
	ld [hli], a
	ld a, NUM_DECK_SAVE_MACHINE_SLOTS
	farcall ConvertToNumericalDigits
	ld [hl], TX_END
	lb de, 14, 1
	call InitTextPrinting
	ld hl, wDefaultText
	call ProcessText
	ret
; 0x3b2af

SECTION "Bank e@72db", ROMX[$72db], BANK[$e]

Func_3b2db:
	ld a, $ff
	farcall DrawDeckSelectionMenu
	xor a
.asm_3b2e2
	ld hl, $735e
	call InitializeMenuParameters
	ld hl, EnableInt_Timer
	call DrawWideTextBox_PrintText
.asm_3b2ee
	call DoFrame
	farcall Func_8fb9
	jr c, .asm_3b2e2
	call HandleMenuInput
	jp nc, .asm_3b2ee
	ldh a, [hCurScrollMenuItem]
	cp $ff
	ret z
	ld [wCurDeck], a
	farcall CheckIfCurDeckIsEmpty
	jp nc, Func_3b315
	farcall Func_9215
	ld a, [wCurDeck]
	jr .asm_3b2e2

Func_3b315:
	farcall GetSRAMPointerToCurDeck
	push hl
	call GetSelectedSavedDeckPtr
	ld d, h
	ld e, l
	pop hl
	ld b, $60
	call EnableSRAM
	call CopyBBytesFromHLToDE_Bank0e.loop
	call DisableSRAM
	call ClearScreenAndDrawDeckMachineScreen
	call DrawListScrollArrows
	call PrintNumSavedDecks
	ld a, [wTempScrollMenuItem]
	ld hl, $5eac
	farcall InitializeScrollMenuParameters
	call HandleScrollMenu.draw_visible_cursor
	farcall GetSRAMPointerToCurDeck
	call EnableSRAM
	farcall CopyDeckName
	call DisableSRAM
	xor a
	ld [wTxRam2], a
	ld [$cdd7], a
	ldtx hl, SavedDeckToMachineText
	call DrawWideTextBox_WaitForInput
	scf
	ret
; 0x3b35e

SECTION "Bank e@7366", ROMX[$7366], BANK[$e]

GetSelectedSavedDeckPtr:
	push af
	push de
	ld a, [wSelectedDeckMachineEntry]
	call Func_3afb8
	pop de
	pop af
	ret

; checks if it's possible to build saved deck with index b
; includes cards from already built decks from flags in a
; returns carry if cannot build the deck with the given criteria
; a = DECK_* flags for which decks to include in the collection
; b = saved deck index
CheckIfCanBuildSavedDeck:
	push bc
	farcall CreateCardCollectionListWithDeckCards
	pop bc
	ld a, b
	call Func_3afb8
	ld bc, DECK_NAME_SIZE
	add hl, bc
	call CheckIfHasEnoughCardsToBuildDeck
	ret

SwitchToWRAM1:
	push af
	ld a, [wce4c]
	cp $01
	jr z, .skip
	ld a, $01
	ld [wce4c], a
	ldh [rSVBK], a
.skip
	pop af
	ret

SwitchToWRAM2:
	push af
	ld a, [wce4c]
	cp $02
	jr z, .skip
	ld a, $02
	ld [wce4c], a
	ldh [rSVBK], a
.skip
	pop af
	ret

; returns carry if wTempCardCollection does not
; have enough cards to build deck pointed by hl
; hl = pointer to cards of deck to check
CheckIfHasEnoughCardsToBuildDeck:
	ld d, h
	ld e, l
	ld hl, wTempSavedDeckCards
	farcall CopyDeckFromSRAM
	ld hl, wTempSavedDeckCards
	ld b, DECK_SIZE + 1
.loop
	dec b
	jr z, .no_carry
	ld e, [hl]
	inc hl
	ld d, [hl]
	inc hl
	push hl
	ld hl, wTempCardCollection
	add hl, de
	ld a, [hl]
	or a
	jr z, .set_carry
	cp CARD_NOT_OWNED
	jr z, .set_carry
	dec a
	ld [hl], a
	pop hl
	jr .loop

.set_carry
	pop hl
	scf
	ret

.no_carry
	or a
	ret

Func_3b3d1:
	ld hl, sDeck1Name
	ld a, [hl]
	or a
	jr nz, .asm_3b3da
	xor a
	ret
.asm_3b3da
	ld hl, sDeck2Name
	ld a, [hl]
	or a
	jr nz, .asm_3b3e4
	ld a, $01
	ret
.asm_3b3e4
	ld hl, sDeck3Name
	ld a, [hl]
	or a
	jr nz, .asm_3b3ee
	ld a, $02
	ret
.asm_3b3ee
	ld hl, sDeck4Name
	ld a, [hl]
	or a
	jr nz, .asm_3b3f8
	ld a, $03
	ret
.asm_3b3f8
	scf
	ret

Func_3b3fa:
	ldtx hl, ConfirmDeletePromptText
	call YesOrNoMenuWithText
	jr c, .asm_3b426
	call GetSelectedSavedDeckPtr
	push hl
	call EnableSRAM
	farcall CopyDeckName
	pop hl
	ld a, $60
	farcall ClearNBytesFromHL
	call DisableSRAM
	xor a
	ld [wTxRam2], a
	ld [$cdd7], a
	ld hl, EnableInt_VBlank
	call DrawWideTextBox_WaitForInput
	or a
	ret
.asm_3b426
	ld a, [wTempCardTypeFilter]
	scf
	ret
; 0x3b42b

SECTION "Bank e@742b", ROMX[$742b], BANK[$e]

DrawListScrollArrows:
	ld a, [wScrollMenuScrollOffset]
	or a
	jr z, .no_up_cursor
	ld a, SYM_CURSOR_U
	jr .got_tile_1
.no_up_cursor
	ld a, SYM_BOX_RIGHT
.got_tile_1
	lb bc, 19, 1
	call WriteByteToBGMap0

	ld a, [wScrollMenuScrollOffset]
	add NUM_DECK_MACHINE_VISIBLE_DECKS + 1
	ld b, a
	ld a, [wNumDeckMachineEntries]
	cp b
	jr c, .no_down_cursor
	xor a ; FALSE
	ld [wUnableToScrollDown], a
	ld a, SYM_CURSOR_D
	jr .got_tile_2
.no_down_cursor
	ld a, TRUE
	ld [wUnableToScrollDown], a
	ld a, SYM_BOX_RIGHT
.got_tile_2
	lb bc, 19, 11
	call WriteByteToBGMap0
	ret

Func_3b45f:
	ldtx hl, YouMayOnlyCarry4DecksText
	call DrawWideTextBox_WaitForInput
	ld a, $ff
	farcall DrawDeckSelectionMenu
	xor a
.asm_3b46c
	ld hl, $735e
	call InitializeMenuParameters
	ldtx hl, ChooseDeckToDismantleText
	call DrawWideTextBox_PrintText
.asm_3b478
	call DoFrame
	farcall Func_8fb9
	jr c, .asm_3b46c
	call HandleMenuInput
	jp nc, .asm_3b478
	ldh a, [hCurScrollMenuItem]
	cp $ff
	jr nz, .asm_3b48f
	scf
	ret
.asm_3b48f
	ld [wCurDeck], a
	ldtx hl, DeckBuildingDismantlePromptText
	call YesOrNoMenuWithText
	jr nc, .asm_3b49f
	ld a, [wCurDeck]
	jr .asm_3b46c
.asm_3b49f
	farcall GetSRAMPointerToCurDeck
	push hl
	ld de, $d47e
	call EnableSRAM
	call Func_3afb1
	pop hl
	push hl
	ld bc, $18
	add hl, bc
	farcall Func_9397
	pop hl
	ld a, $60
	farcall ClearNBytesFromHL
	call DisableSRAM
	ld a, $ff
	farcall DrawDeckSelectionMenu
	ld a, [wCurDeck]
	ld hl, $735e
	call InitializeMenuParameters
	call DrawCursor2
	ld hl, $d47e
	farcall CopyDeckName
	xor a
	ld [wTxRam2], a
	ld [$cdd7], a
	ldtx hl, DismantledThisDeckText
	call DrawWideTextBox_WaitForInput
	ld a, [wCurDeck]
	ret

Func_3b4eb:
	call SwitchToWRAM2
	xor a
	ld [$d280], a
	call SwitchToWRAM1
	ld a, [wSelectedDeckMachineEntry]
	ld hl, wd49f
	sla a
	ld b, $00
	ld c, a
	add hl, bc
	ld a, [hli]
	ld [wd49b], a
	ld a, [hl]
	ld [wd49e], a
	or a
	jr nz, .asm_3b526
	ld a, [wd49b]
	or a
	jr z, .asm_3b53a
	ldtx hl, CannotBuildMustDismantleText
	call DrawWideTextBox_WaitForInput
	call Func_3b9d6
	call Func_3b5f1
	jr nc, .asm_3b53a
	call Func_3b661
	jr nc, .asm_3b53a
	ret
.asm_3b526
	ldtx hl, YouDoNotOwnAllCardsNeededToBuildThisDeckText
	call DrawWideTextBox_WaitForInput
	call Func_3b92b
	ld a, [wd49b]
	or a
	call nz, Func_3b9d6
	call Func_3b661
	ret c
.asm_3b53a
	call EnableSRAM
	call Func_3b3d1
	call DisableSRAM
	jr nc, .asm_3b54c
	call Func_3b45f
	jr nc, .asm_3b54c
	scf
	ret
.asm_3b54c
	ld [$d496], a
	ld a, [wSelectedDeckMachineEntry]
	call Func_3afb8
	ld de, wc000
	ld b, $60
	call EnableSRAM
	call CopyBBytesFromHLToDE_Bank0e.loop
	call SwitchToWRAM2
	ld a, [$d280]
	or a
	call nz, Func_3b7fc
	call SwitchToWRAM1
	ld hl, $c018
	farcall Func_9337
	ld a, [$d496]
	ld l, a
	ld h, $60
	call HtimesL
	ld bc, sDeck1Name
	add hl, bc
	ld d, h
	ld e, l
	ld hl, wc000
	ld b, $60
	call CopyBBytesFromHLToDE_Bank0e.loop
	call DisableSRAM
	ld a, $ff
	farcall DrawDeckSelectionMenu
	ld a, [$d496]
	ld [wCurDeck], a
	ld hl, $735e
	call InitializeMenuParameters
	call DrawCursor2
	farcall GetSRAMPointerToCurDeck
	call EnableSRAM
	farcall CopyDeckName
	call DisableSRAM
	xor a
	ld [wTxRam2], a
	ld [$cdd7], a
	ldtx hl, BuiltDeckText
	call DrawWideTextBox_WaitForInput
	call SwitchToWRAM2
	ld a, [$d280]
	or a
	call SwitchToWRAM1
	jr z, .asm_3b5ef
	call SwitchToWRAM2
	ld hl, wCursorAlternateTile
	ld de, wc000
	ld b, $80
	call CopyBBytesFromHLToDE_Bank0e.loop
	call SwitchToWRAM1
	ld bc, $2f3
	ld hl, $d38a
	ld a, c
	ld [hli], a
	ld a, b
	ld [hl], a
	call GetSelectedSavedDeckPtr
	ld de, wc000
	farcall Func_b59f
.asm_3b5ef
	scf
	ret

Func_3b5f1:
	call Func_3bcd6
	farcall DrawDeckSelectionMenu
	ldtx hl, DismantleTheseDecksPromptText
	call YesOrNoMenuWithText
	jr nc, .asm_3b601
	ret
.asm_3b601
	call EnableSRAM
	ld a, [$d49a]
	bit 0, a
	jr z, .asm_3b610
	ld a, $00
	call Func_3b646
.asm_3b610
	ld a, [$d49a]
	bit 1, a
	jr z, .asm_3b61c
	ld a, $01
	call Func_3b646
.asm_3b61c
	ld a, [$d49a]
	bit 2, a
	jr z, .asm_3b628
	ld a, $02
	call Func_3b646
.asm_3b628
	ld a, [$d49a]
	bit 3, a
	jr z, .asm_3b634
	ld a, $03
	call Func_3b646
.asm_3b634
	call DisableSRAM
	ld a, [$d49a]
	farcall DrawDeckSelectionMenu
	ldtx hl, DismantledTheseDecksText
	call DrawWideTextBox_WaitForInput
	or a
	ret

Func_3b646:
	ld l, a
	ld h, $60
	call HtimesL
	ld bc, sDeck1Name
	add hl, bc
	push hl
	ld bc, $18
	add hl, bc
	farcall Func_9397
	pop hl
	ld a, $60
	farcall ClearNBytesFromHL
	ret

Func_3b661:
	ldtx hl, MaySubInEnergyCardsToBuildThisDeckText
	call DrawWideTextBox_WaitForInput
	ldtx hl, BuildSubbedDeckPromptText
	call YesOrNoMenuWithText
	ret c
	ld a, [wd49b]
	ld hl, wd49e
	add [hl]
	cp $0a
	jr c, .asm_3b681
	ldtx hl, CannotBuildLackingTooManyCardsText
	call DrawWideTextBox_WaitForInput
	scf
	ret
.asm_3b681
	push af
	call Func_3b6c4
	call Func_3b75a
	pop bc
	jr c, .asm_3b696
	cp b
	jr nc, .asm_3b696
	ldtx hl, CannotBuildLackingEnergyCardsText
	call DrawWideTextBox_WaitForInput
	scf
	ret
.asm_3b696
	call SwitchToWRAM2
	ld hl, $d200
	ld de, wc000
	ld b, $80
	call CopyBBytesFromHLToDE_Bank0e.loop
	call SwitchToWRAM1
	ld hl, wc000
	ld de, wCurDeckCards
	ld b, $80
	call CopyBBytesFromHLToDE_Bank0e.loop
	farcall Func_9a0f
	jr c, .asm_3b6c0
	ldtx hl, CannotBuildLackingBasicPokemonText
	call DrawWideTextBox_WaitForInput
	scf
	ret
.asm_3b6c0
	call Func_3b79b
	ret

Func_3b6c4:
	ld a, [wSelectedDeckMachineEntry]
	ld [wCurDeck], a
	call GetSelectedSavedDeckPtr
	ld de, $18
	add hl, de
	ld d, h
	ld e, l
	ld hl, wCurDeckCards
	farcall CopyDeckFromSRAM
	farcall SortCurDeckCardsByID
	farcall CreateCurDeckUniqueCardList
	xor a
	farcall CreateCardCollectionListWithDeckCards
	ld hl, $0
.asm_3b6ea
	push hl
	ld l, h
	ld h, $00
	ld de, wUniqueDeckCardList
	add hl, de
	ld e, [hl]
	inc hl
	ld d, [hl]
	pop hl
	inc h
	inc h
	call Func_3b91d
	jr c, .asm_3b720
	push bc
	push de
	push hl
	ld hl, wCurDeckCards
	call Func_3b746
	pop hl
	pop de
	pop bc
	jr nc, .asm_3b6ea
	ld c, a
.asm_3b70c
	push hl
	push de
	ld h, $00
	ld de, wTempCardList
	add hl, de
	pop de
	ld [hl], e
	inc hl
	ld [hl], d
	pop hl
	inc l
	inc l
	dec c
	jr nz, .asm_3b70c
	jr .asm_3b6ea
.asm_3b720
	ld h, $00
	ld de, wTempCardList
	add hl, de
	xor a
	ld [hli], a
	ld [hl], a
	ld hl, wTempCardList
	ld de, wc000
	ld b, $80
	call CopyBBytesFromHLToDE_Bank0e.loop
	call SwitchToWRAM2
	ld hl, wc000
	ld de, $d200
	ld b, $80
	call CopyBBytesFromHLToDE_Bank0e.loop
	call SwitchToWRAM1
	ret

Func_3b746:
	call Func_3b9ba
	ld hl, wc000
	add hl, de
	ld a, [hl]
	and $7f
	or a
	ret z
	cp b
	jr nc, .asm_3b757
	scf
	ret
.asm_3b757
	ld a, b
	scf
	ret

Func_3b75a:
	xor a
	farcall CreateCardCollectionListWithDeckCards
	call SwitchToWRAM2
	ld hl, $d200
.asm_3b765
	ld e, [hl]
	inc hl
	ld d, [hl]
	inc hl
	call Func_3b91d
	jr c, .asm_3b77c
	push hl
	ld hl, wc000
	add hl, de
	ld a, [hl]
	and $7f
	jr z, .asm_3b779
	dec [hl]
.asm_3b779
	pop hl
	jr .asm_3b765
.asm_3b77c
	ld hl, $c001
	ld de, $d280
	ld b, $06
	call CopyBBytesFromHLToDE_Bank0e.loop
	ld hl, $d280
	ld bc, $6
.asm_3b78d
	ld a, [hli]
	add b
	jr c, .asm_3b797
	ld b, a
	dec c
	jr nz, .asm_3b78d
	ld b, a
	or a
.asm_3b797
	call SwitchToWRAM1
	ret

Func_3b79b:
	call SwitchToWRAM2
	ld a, $ff
	ld [$d286], a
	xor a
	ld hl, $d287
	ld [hli], a
	inc a
	ld [hli], a
	inc a
	ld [hli], a
	inc a
	ld [hli], a
	inc a
	ld [hli], a
	inc a
	ld [hl], a
	ld de, $0
.asm_3b7b5
	ld hl, $d280
	add hl, de
	call Func_3b7e4
	ld a, e
	add c
	ld c, a
	ld hl, $d280
	add hl, de
	ld a, [hl]
	ld [hl], b
	ld b, $00
	ld hl, $d280
	add hl, bc
	ld [hl], a
	ld hl, $d287
	add hl, de
	ld a, [hl]
	push hl
	ld hl, $d287
	add hl, bc
	ld c, [hl]
	ld [hl], a
	pop hl
	ld [hl], c
	inc e
	ld a, $06
	cp e
	jr nz, .asm_3b7b5
	call SwitchToWRAM1
	ret

Func_3b7e4:
	push de
	ld e, $00
	ld bc, $0
.asm_3b7ea
	ld a, [hli]
	cp $ff
	jr z, .asm_3b7f9
	and $7f
	cp b
	jr c, .asm_3b7f6
	ld b, a
	ld e, c
.asm_3b7f6
	inc c
	jr .asm_3b7ea
.asm_3b7f9
	ld c, e
	pop de
	ret

Func_3b7fc:
	call SwitchToWRAM2
	ld hl, wc000
	ld de, $d28e
	ld b, $00
	call CopyBBytesFromHLToDE_Bank0e.loop
	call SwitchToWRAM1
	call Func_3b6c4
	call Func_3b75a
	call Func_3b79b
	call SwitchToWRAM2
	ld hl, $d28e
	ld de, wc000
	ld b, $00
	call CopyBBytesFromHLToDE_Bank0e.loop
	call SwitchToWRAM1
	ld de, $c018
	ld hl, wTempSavedDeckCards
	farcall CopyDeckFromSRAM
	ld hl, wTempSavedDeckCards
	ld de, $c018
	ld b, $80
	call CopyBBytesFromHLToDE_Bank0e.loop
	call SwitchToWRAM2
	ld a, $80
	ld hl, wListPointer
	farcall ClearNBytesFromHL
	ld b, $00
	ld de, $d200
.asm_3b84d
	ld a, [de]
	inc de
	ld [hli], a
	ld c, a
	ld a, [de]
	inc de
	ld [hli], a
	push de
	inc b
	ld e, c
	ld d, a
	call Func_3b91d
	pop de
	jr nc, .asm_3b84d
	dec b
	dec hl
	dec hl
	push hl
	ld a, $ff
	ld [$d28d], a
	ld de, $0
.asm_3b86a
	push hl
	ld hl, $d287
	add hl, de
	ld a, [hl]
	cp $ff
	jr z, .asm_3b882
	call Func_3b8c0
	pop hl
	jr c, .asm_3b87f
	call Func_3b8da
	jr c, .asm_3b899
.asm_3b87f
	inc e
	jr .asm_3b86a
.asm_3b882
	pop hl
	ld de, $0
.asm_3b886
	push hl
	ld hl, $d287
	add hl, de
	ld a, [hl]
	cp $ff
	pop hl
	jr z, .asm_3b899
	call Func_3b8da
	jr c, .asm_3b899
	inc e
	jr .asm_3b886
.asm_3b899
	ld a, $80
	ld hl, wCursorAlternateTile
	farcall ClearNBytesFromHL
	pop hl
	ld bc, wCursorAlternateTile
.asm_3b8a6
	ld a, [hli]
	ld [bc], a
	inc bc
	ld e, a
	ld a, [hli]
	ld [bc], a
	inc bc
	ld d, a
	call Func_3b91d
	jr nc, .asm_3b8a6
	ld hl, $c018
	ld de, wListPointer
	bank1call SaveDeckCards
	call SwitchToWRAM1
	ret

Func_3b8c0:
	push de
	ld hl, $c018
.asm_3b8c4
	ld e, [hl]
	inc hl
	ld d, [hl]
	inc hl
	call Func_3b91d
	ccf
	jr nc, .asm_3b8d8
	cp e
	jr nz, .asm_3b8c4
	ld e, a
	ld a, d
	or a
	ld a, e
	jr nz, .asm_3b8c4
	scf
.asm_3b8d8
	pop de
	ret

Func_3b8da:
	push hl
	ld hl, $d280
	add hl, de
	ld a, [hl]
	and $7f
	jr z, .asm_3b90d
	ld c, a
	pop hl
	push de
	push hl
	ld hl, $d287
	add hl, de
	ld e, [hl]
	inc e
	ld d, $00
	pop hl
.asm_3b8f1
	ld [hl], e
	inc hl
	ld [hl], d
	inc hl
	inc b
	dec c
	jr z, .asm_3b900
	ld a, $3c
	cp b
	jr z, .asm_3b910
	jr .asm_3b8f1
.asm_3b900
	ld a, $3c
	cp b
	jr z, .asm_3b910
	pop de
	push hl
	ld hl, $d280
	add hl, de
	xor a
	ld [hl], a
.asm_3b90d
	pop hl
	or a
	ret
.asm_3b910
	xor a
	ld [hli], a
	ld [hl], a
	pop de
	push hl
	ld hl, $d287
	add hl, de
	ld [hl], c
	pop hl
	scf
	ret

Func_3b91d:
	push af
	xor a
	cp d
	jr nz, .asm_3b928
	cp e
	jr nz, .asm_3b928
	pop af
	scf
	ret
.asm_3b928
	pop af
	or a
	ret

Func_3b92b:
	ld a, [wSelectedDeckMachineEntry]
	ld [wCurDeck], a
	call GetSelectedSavedDeckPtr
	ld de, $18
	add hl, de
	ld d, h
	ld e, l
	ld hl, wCurDeckCards
	farcall CopyDeckFromSRAM
	farcall SortCurDeckCardsByID
	farcall CreateCurDeckUniqueCardList
	ld a, $ff
	farcall CreateCardCollectionListWithDeckCards
	ld hl, $0
.asm_3b952
	push hl
	ld l, h
	ld h, $00
	ld de, wUniqueDeckCardList
	add hl, de
	ld e, [hl]
	inc hl
	ld d, [hl]
	pop hl
	inc h
	inc h
	call Func_3b91d
	jr c, .asm_3b988
	push bc
	push de
	push hl
	ld hl, wCurDeckCards
	call Func_3b9a6
	pop hl
	pop de
	pop bc
	jr nc, .asm_3b952
	ld c, a
.asm_3b974
	push hl
	push de
	ld h, $00
	ld de, wTempCardList
	add hl, de
	pop de
	ld [hl], e
	inc hl
	ld [hl], d
	pop hl
	inc l
	inc l
	dec c
	jr nz, .asm_3b974
	jr .asm_3b952
.asm_3b988
	ld h, $00
	ld de, wTempCardList
	add hl, de
	xor a
	ld [hli], a
	ld [hl], a
	ld bc, $2e7
	ld hl, $d38a
	ld a, c
	ld [hli], a
	ld a, b
	ld [hl], a
	call GetSelectedSavedDeckPtr
	ld de, wTempCardList
	farcall Func_b59f
	ret

Func_3b9a6:
	call Func_3b9ba
	ld hl, wc000
	add hl, de
	ld a, [hl]
	and $7f
	cp b
	jr c, .asm_3b9b5
	or a
	ret
.asm_3b9b5
	ld e, a
	ld a, b
	sub e
	scf
	ret

Func_3b9ba:
	push de
	ld b, $00
.asm_3b9bd
	push de
	ld e, [hl]
	inc hl
	ld d, [hl]
	inc hl
	call Func_3b91d
	ld a, e
	ld c, d
	pop de
	jr c, .asm_3b9d4
	cp e
	jr nz, .asm_3b9bd
	ld a, c
	cp d
	jr nz, .asm_3b9bd
	inc b
	jr .asm_3b9bd
.asm_3b9d4
	pop de
	ret

Func_3b9d6:
	ld a, [wSelectedDeckMachineEntry]
	ld [wCurDeck], a
	call GetSelectedSavedDeckPtr
	ld de, $18
	add hl, de
	ld d, h
	ld e, l
	ld hl, wCurDeckCards
	farcall CopyDeckFromSRAM
	farcall SortCurDeckCardsByID
	farcall CreateCurDeckUniqueCardList
	xor a
	farcall CreateCardCollectionListWithDeckCards
	call SwitchToWRAM2
	ld hl, wc000
	ld de, wListPointer
	ld b, $00
	call CopyBBytesFromHLToDE_Bank0e.loop
	ld hl, $c100
	ld de, $d100
	ld b, $00
	call CopyBBytesFromHLToDE_Bank0e.loop
	call SwitchToWRAM1
	ld a, $80
	farcall CreateCardCollectionListWithDeckCards
	ld hl, $0
.asm_3ba1e
	push hl
	ld l, h
	ld h, $00
	ld de, wUniqueDeckCardList
	add hl, de
	ld e, [hl]
	inc hl
	ld d, [hl]
	pop hl
	inc h
	inc h
	call Func_3b91d
	jr c, .asm_3ba54
	push bc
	push de
	push hl
	ld hl, wCurDeckCards
	call Func_3ba7d
	pop hl
	pop de
	pop bc
	jr nc, .asm_3ba1e
	ld c, a
.asm_3ba40
	push hl
	push de
	ld h, $00
	ld de, wTempCardList
	add hl, de
	pop de
	ld [hl], e
	inc hl
	ld [hl], d
	pop hl
	inc l
	inc l
	dec c
	jr nz, .asm_3ba40
	jr .asm_3ba1e
.asm_3ba54
	ld h, $00
	ld de, wTempCardList
	add hl, de
	xor a
	ld [hli], a
	ld [hl], a
	ld a, [wd49e]
	or a
	jr nz, .asm_3ba68
	ld bc, $2e8
	jr .asm_3ba6b
.asm_3ba68
	ld bc, $2e9
.asm_3ba6b
	ld hl, $d38a
	ld a, c
	ld [hli], a
	ld a, b
	ld [hl], a
	call GetSelectedSavedDeckPtr
	ld de, wTempCardList
	farcall Func_b59f
	ret

Func_3ba7d:
	call Func_3b9ba
	call PrintDeckMachineEntry.GetCardCountInScratchCardCollection
	ld c, a
	ld a, b
	sub c
	jr z, .asm_3ba9a
	jr c, .asm_3ba9a
	ld b, a
	ld hl, wc000
	add hl, de
	ld a, [hl]
	and $7f
	jr z, .asm_3ba9a
	cp b
	jr c, .asm_3ba98
	ld a, b
.asm_3ba98
	scf
	ret
.asm_3ba9a
	or a
	ret
; 0x3ba9c

SECTION "Bank e@7a9c", ROMX[$7a9c], BANK[$e]

_PrinterMenu_DeckConfiguration:
	xor a
	ld [wScrollMenuScrollOffset], a
	call ClearScreenAndDrawDeckMachineScreen
	ld a, NUM_DECK_SAVE_MACHINE_SLOTS
	ld [wNumDeckMachineEntries], a

	xor a
.start_selection
	ld hl, DeckMachineSelectionParams
	farcall InitializeScrollMenuParameters
	call DrawListScrollArrows
	call PrintNumSavedDecks
	ldtx hl, ChooseDeckConfigurationToPrintText
	call DrawWideTextBox_PrintText
	ldtx de, ChooseDeckConfigurationToPrintText
	call InitDeckMachineDrawingParams
.loop_input
	call HandleDeckMachineSelection
	jr c, .start_selection
	cp $ff
	ret z

	ld b, a
	ld a, [wScrollMenuScrollOffset]
	add b
	ld [wSelectedDeckMachineEntry], a
	call CheckIfSelectedDeckMachineEntryIsEmpty
	jr c, .loop_input
	call DrawWideTextBox
	ldtx hl, PrintThisDeckPromptText
	call YesOrNoMenuWithText
	jr c, .no
	call GetSelectedSavedDeckPtr
	ld de, DECK_NAME_SIZE
	add hl, de
	ld d, h
	ld e, l
	ld hl, wCurDeckCards
	farcall CopyDeckFromSRAM
	farcall SortCurDeckCardsByID
	ld a, [wSelectedDeckMachineEntry]
	farcall PrintDeckConfiguration
	call ClearScreenAndDrawDeckMachineScreen

.no
	ld a, [wTempScrollMenuItem]
	ld [wCurScrollMenuItem], a
	jp .start_selection

Func_3bb09:
	ld a, [wd548]
	or a
	jr nz, .asm_3bb14
	ld hl, $7c6d
	jr .asm_3bb17
.asm_3bb14
	ld hl, $7c81
.asm_3bb17
	ld a, [$d4b3]
	sla a
	ld c, a
	ld b, $00
	add hl, bc
	ld de, wDeckMachineTitleText
	ld a, [hli]
	ld [de], a
	inc de
	ld a, [hl]
	ld [de], a
	xor a
	ld [wScrollMenuScrollOffset], a
	call Func_3bc95
	xor a
.asm_3bb30
	ld hl, $5eb5
	farcall InitializeScrollMenuParameters
	ldtx hl, PleaseSelectDeckText
	call DrawWideTextBox_PrintText
	ld a, [wNumDeckMachineEntries]
	ld [wNumMenuItems], a
	ld a, $01
	ld [wUnableToScrollDown], a
	xor a
	ld [wd119], a
	call Func_3b069
.asm_3bb4f
	call DoFrame
	call HandleScrollMenu
	jr c, .asm_3bba2
	ldh a, [hDPadHeld]
	and $08
	jr z, .asm_3bb4f
	ld a, [wScrollMenuScrollOffset]
	ld [wTempScrollMenuScrollOffset], a
	ld b, a
	ld a, [wTempCardTypeFilter]
	ld [wTempScrollMenuItem], a
	add b
	ld c, a
	inc a
	or $80
	ld [wCurDeck], a
	ld a, c
	call Func_3afb8
	push hl
	farcall AppendDeckName.text_end
	pop hl
	jr c, .asm_3bb4f
	push hl
	ld bc, $18
	add hl, bc
	ld d, h
	ld e, l
	pop hl
	ld a, $01
	farcall PlayAcceptOrDeclineSFX
	farcall OpenDeckConfirmationMenu
	ld a, [wTempScrollMenuScrollOffset]
	ld [wScrollMenuScrollOffset], a
	call Func_3bc95
	ld a, [wTempScrollMenuItem]
	ld [wTempCardTypeFilter], a
	jp .asm_3bb30
.asm_3bba2
	call HandleScrollMenu.draw_visible_cursor
	ld a, [wScrollMenuScrollOffset]
	ld [wTempScrollMenuScrollOffset], a
	ld a, [wTempCardTypeFilter]
	ld [wTempScrollMenuItem], a
	ld a, [hCurMenuItem]
	cp $ff
	jp z, .asm_3bc0e
	ld b, a
	ld a, [wScrollMenuScrollOffset]
	add b
	ld [wSelectedDeckMachineEntry], a
	farcall Func_9287
	xor a
	ld [$d0cd], a
	call DrawWideTextBox
	ld hl, $7c60
	call PlaceTextItems
.asm_3bbd2
	call DoFrame
	farcall Func_87d3
	jp nc, .asm_3bbd2
	cp $ff
	jr nz, .asm_3bbe6
	ld a, [wTempScrollMenuItem]
	jp .asm_3bb30
.asm_3bbe6
	ld a, [wMusicStereoPanningBackup]
	sla a
	ld hl, wCurSongBankBackup
	add [hl]
	or a
	jr nz, .asm_3bc0a
	call Func_3b4eb
	ld a, [wTempScrollMenuItem]
	jp nc, .asm_3bb30
	ld a, [wTempScrollMenuScrollOffset]
	ld [wScrollMenuScrollOffset], a
	call Func_3bc95
	ld a, [wTempScrollMenuItem]
	jp .asm_3bb30
.asm_3bc0a
	cp $01
	jr nz, .asm_3bc0f
.asm_3bc0e
	ret
.asm_3bc0f
	ld a, [wScrollMenuScrollOffset]
	ld [wTempScrollMenuScrollOffset], a
	ld b, a
	ld a, [wTempCardTypeFilter]
	ld [wTempScrollMenuItem], a
	add b
	ld c, a
	ld [wCurDeck], a
	push af
	sla c
	ld b, $00
	ld hl, $d4b4
	add hl, bc
	ld bc, $d38a
	ld a, [hli]
	ld [bc], a
	inc bc
	ld a, [hl]
	ld [bc], a
	pop af
	call Func_3afb8
	push hl
	farcall AppendDeckName.text_end
	pop hl
	jp c, .asm_3bb4f
	ld a, $01
	farcall PlayAcceptOrDeclineSFX
	push hl
	ld de, $18
	add hl, de
	ld d, h
	ld e, l
	pop hl
	farcall Func_b57c
	ld a, [wTempScrollMenuScrollOffset]
	ld [wScrollMenuScrollOffset], a
	call Func_3bc95
	ld a, [wTempScrollMenuItem]
	jp .asm_3bb30
; 0x3bc60

SECTION "Bank e@7c95", ROMX[$7c95], BANK[$e]

Func_3bc95:
	xor a
	ld [wTileMapFill], a
	call ZeroObjectPositions
	call EmptyScreen
	ld a, $01
	ld [wVBlankOAMCopyToggle], a
	call LoadSymbolsFont
	call LoadDuelCardSymbolTiles
	bank1call SetDefaultPalettes
	ld de, $3cff
	call SetupText
	lb de, 0, 0
	lb bc, 20, 12
	call DrawRegularTextBox
	ld hl, wDeckMachineTitleText
	ld a, [hli]
	ld h, [hl]
	ld l, a
	lb de, 1, 0
	call Func_2c4b
	farcall Func_2bb32
	call Func_3bd3b
	call Func_3b078
	call EnableLCD
	ret

Func_3bcd6:
	xor a
	ld [$d49a], a
	ld a, $01
.asm_3bcdc
	call Func_3bd28
	ret nc
	sla a
	cp $10
	jr nz, .asm_3bcdc
	ld a, $03
	call Func_3bd28
	ret nc
	ld a, $05
	call Func_3bd28
	ret nc
	ld a, $09
	call Func_3bd28
	ret nc
	ld a, $06
	call Func_3bd28
	ret nc
	ld a, $0a
	call Func_3bd28
	ret nc
	ld a, $0c
	call Func_3bd28
	ret nc
	ld a, $07
	call Func_3bd28
	ret nc
	ld a, $0b
	call Func_3bd28
	ret nc
	ld a, $0d
	call Func_3bd28
	ret nc
	ld a, $0e
	call Func_3bd28
	ret nc
	ld a, $ff
	call Func_3bd28
	ret

Func_3bd28:
	push af
	ld hl, wSelectedDeckMachineEntry
	ld b, [hl]
	call CheckIfCanBuildSavedDeck
	jr c, .asm_3bd38
	pop af
	ld [$d49a], a
	or a
	ret
.asm_3bd38
	pop af
	scf
	ret

Func_3bd3b:
	ld a, $08
	ld hl, wMachineDeckPtrs
	farcall ClearNBytesFromHL
	ld de, wMachineDeckPtrs
	ld hl, $d40e
	ld bc, $60
	ld a, $04
.asm_3bd4f
	push af
	ld a, l
	ld [de], a
	inc de
	ld a, h
	ld [de], a
	inc de
	add hl, bc
	pop af
	dec a
	jr nz, .asm_3bd4f
	ret
; 0x3bd5c

SECTION "Bank e@7f5e", ROMX[$7f5e], BANK[$e]

Func_3bf5e:
	call Func_3bf95
	ld a, [wNumDeckMachineEntries]
	cp $05
	jr c, .asm_3bf6a
	ld a, $05
.asm_3bf6a
	ld b, a
	ld a, [wScrollMenuScrollOffset]
	ld de, $602
.asm_3bf71
	push af
	push bc
	push de
	call Func_3bf81
	pop de
	pop bc
	pop af
	dec b
	ret z
	inc a
	inc e
	inc e
	jr .asm_3bf71

Func_3bf81:
	push af
	call InitTextPrinting
	pop af
	add a
	ld c, a
	ld b, $00
	ld hl, $d4b4
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	call ProcessTextFromID
	ret

Func_3bf95:
	ld a, [wScrollMenuScrollOffset]
	or a
	jr z, .asm_3bf9f
	ld a, $0d
	jr .asm_3bfa1
.asm_3bf9f
	ld a, $1c
.asm_3bfa1
	ld bc, $1200
	call WriteByteToBGMap0
	ld a, [wScrollMenuScrollOffset]
	add $05
	ld b, a
	inc b
	ld a, [wNumDeckMachineEntries]
	cp b
	jr c, .asm_3bfbc
	xor a
	ld [wUnableToScrollDown], a
	ld a, $2f
	jr .asm_3bfc3
.asm_3bfbc
	ld a, $01
	ld [wUnableToScrollDown], a
	ld a, $1c
.asm_3bfc3
	ld bc, $120c
	call WriteByteToBGMap0
	ret
; 0x3bfca
