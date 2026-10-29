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
	call LookForEvoCardInDeck_GivenPreevoInHandOrPlayArea
	jr c, .use_evolutionary_light
	ld bc, DRATINI_LV12
	ld de, DARK_DRAGONAIR
	call LookForEvoCardInDeck_GivenPreevoInHandOrPlayArea
	jr c, .use_evolutionary_light
	ld bc, DARK_DRAGONAIR
	ld de, DARK_DRAGONITE
	call LookForEvoCardInDeck_GivenPreevoInHandOrPlayArea
	jr c, .use_evolutionary_light
	ret

.pokemon_power_deck
	ld bc, KADABRA_LV38
	ld de, ALAKAZAM_LV42
	call LookForEvoCardInDeck_GivenPreevoInHandOrPlayArea
	jr c, .use_evolutionary_light
	ld bc, ABRA_LV14
	ld de, KADABRA_LV38
	call LookForEvoCardInDeck_GivenPreevoInHandOrPlayArea
	jp c, .use_evolutionary_light
	ld bc, SLOWPOKE_LV16
	ld de, SLOWBRO_LV26
	call LookForEvoCardInDeck_GivenPreevoInHandOrPlayArea
	jp c, .use_evolutionary_light
	ld bc, MEOWTH_LV14
	ld de, DARK_PERSIAN_LV28
	call LookForEvoCardInDeck_GivenPreevoInHandOrPlayArea
	jp c, .use_evolutionary_light
	ld bc, DRATINI_LV12
	ld de, DARK_DRAGONAIR
	call LookForEvoCardInDeck_GivenPreevoInHandOrPlayArea
	jp c, .use_evolutionary_light
	ret

.sudden_growth_deck
	ld bc, CLEFAIRY_LV15
	ld de, DARK_CLEFABLE
	call LookForEvoCardInDeck_GivenPreevoInHandOrPlayArea
	jp c, .use_evolutionary_light
	ld de, DARK_CLEFABLE
	ld b, PLAY_AREA_ARENA
	call CountCardIDInTurnDuelistPlayArea
	cp 2
	jr c, .not_enough_dark_clefable
	; has at least 2 Dark Clefable
	ld de, DARK_DRAGONITE
	call IsCardIDInDeckAndNotInHand
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
	call LookForEvoCardInDeck_GivenPreevoInPlayArea
	jp c, .use_evolutionary_light
	ld bc, BULBASAUR_LV12
	ld de, DARK_IVYSAUR
	call LookForEvoCardInDeck_GivenPreevoInPlayArea
	jp c, .use_evolutionary_light
	ld bc, DRATINI_LV10
	ld de, DARK_DRAGONAIR
	call LookForEvoCardInDeck_GivenPreevoInPlayArea
	jp c, .use_evolutionary_light

	; next search for targets that are not in Hand
	ld de, DARK_VENUSAUR
	call IsCardIDInDeckAndNotInHand
	jp c, .use_evolutionary_light
	ld de, DARK_IVYSAUR
	call IsCardIDInDeckAndNotInHand
	jp c, .use_evolutionary_light
	ld de, DARK_DRAGONAIR
	call IsCardIDInDeckAndNotInHand
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
	call LookForEvoCardInDeck_GivenPreevoInHandOrPlayArea
	jp c, .use_evolutionary_light
	ld bc, HAUNTER_LV26
	ld de, GENGAR_LV40
	call LookForEvoCardInDeck_GivenPreevoInHandOrPlayArea
	jp c, .use_evolutionary_light
	ld bc, DRATINI_LV10
	ld de, DARK_DRAGONAIR
	call LookForEvoCardInDeck_GivenPreevoInHandOrPlayArea
	jp c, .use_evolutionary_light
	ld bc, DARK_DRAGONAIR
	ld de, DARK_DRAGONITE
	call LookForEvoCardInDeck_GivenPreevoInHandOrPlayArea
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
	farcall IsEvoCardIDInDeckAndNotInHand_AIDecideEvolution
	jp c, .use_evolutionary_light
	ld de, DARK_GOLDUCK
	farcall IsEvoCardIDInDeckAndNotInHand_AIDecideEvolution
	jp c, .use_evolutionary_light
	ld de, DARK_DRAGONAIR
	farcall IsEvoCardIDInDeckAndNotInHand_AIDecideEvolution
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
	ld a, OPPACTION_USE_PKMN_POWER_NO_EFF2
	farcall AIMakeDecision
	ld a, -1
	ldh [hTempPlayAreaLocation_ffa1], a
	ldtx de, FossilizeCheckText
	farcall Serial_TossCoin
	jr c, .got_heads
	farcall SetWasUnsuccessful
	call PrintFailedEffectText
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
	ld a, OPPACTION_USE_PKMN_POWER_NO_EFF2
	farcall AIMakeDecision
	ldtx de, MagnetCheckText
	farcall Serial_TossCoin
	ldh [hAIPkmnPowerEffectParam], a
	jr c, .heads
	farcall SetWasUnsuccessful
	call PrintFailedEffectText
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

.try
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

.CheckWhetherToUseCowardice_SkipDamageCheck:
	ld a, c
	ldh [hTemp_ffa0], a
	bank1call CheckIsIncapableOfUsingPkmnPower
	ccf
	ret nc
	jp .try

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
	call AIDecide_ProfessorOak_UltraRemovalDeck
	jr nc, .loop_play_energy_cards ; disinclined

	; has Professor Oak and inclined to play it
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
	ld a, [wPrehistoricDreamBoost]
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
	; temporarily add PlusPower to simulate
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
	call IsCardIDInDeckAndNotInHandOrPlayArea
	call c, .AddCardToList
	ld de, ZAPDOS_LV40
	call IsCardIDInDeckAndNotInHandOrPlayArea
	call c, .AddCardToList
	ld de, SNORLAX_LV20
	call IsCardIDInDeckAndNotInHandOrPlayArea
	call c, .AddCardToList
	ld de, SNORLAX_LV35
	call IsCardIDInDeckAndNotInHandOrPlayArea
	call c, .AddCardToList
	ld de, HUNGRY_SNORLAX
	call IsCardIDInDeckAndNotInHandOrPlayArea
	call c, .AddCardToList
	ld de, DRATINI_LV12
	call IsCardIDInDeckAndNotInHandOrPlayArea
	call c, .AddCardToList
	jr .asm_391e1

.RonaldsPsychicDeck
	ld de, GASTLY_LV13
	call IsCardIDInDeckAndNotInHandOrPlayArea
	call c, .AddCardToList
	ld de, DRATINI_LV10
	call IsCardIDInDeckAndNotInHandOrPlayArea
	call c, .AddCardToList
	ld de, MEW_LV23
	call IsCardIDInDeckAndNotInHandOrPlayArea
	call c, .AddCardToList
	ld de, MEWTWO_LV67
	call IsCardIDInDeckAndNotInHandOrPlayArea
	call c, .AddCardToList
	ld de, KANGASKHAN_LV40
	call IsCardIDInDeckAndNotInHandOrPlayArea
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
	ld [wTempAICount1], a
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
	ld a, [wTempAICount1]
	cp b
	; carry if wTempAICount1 < b
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
; - a and [wTempAICount1] = card count
CountCardIDInTurnDuelistPlayArea:
	xor a
	ld [wTempAICount1], a
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
	ld a, [wTempAICount1]
	inc a
	ld [wTempAICount1], a
.not_equal
	ld d, b
	ld e, c
	pop bc
	inc b
	ld a, MAX_PLAY_AREA_POKEMON
	cp b
	jr nz, .loop_play_area
.done
	ld a, [wTempAICount1]
	ret

AIDecide_ProfessorOak_RainDanceConfusionDeck:
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

; check trainer
	cp16 ENERGY_RETRIEVAL
	jp z, .no_carry
	cp16 COMPUTER_SEARCH
	jp z, .no_carry
	cp16 POKEMON_TRADER
	jp z, .no_carry
	cp16 POTION
	jr nz, .check_squirtle_lv15
	farcall CheckIfAnyPlayAreaPokemonHasDamage
	jp c, .no_carry
	jp .next_card

.check_squirtle_lv15
	cp16 SQUIRTLE_LV15
	jr nz, .check_squirtle_lv16
	ld b, PLAY_AREA_ARENA
	farcall FindCardIDInTurnDuelistsPlayArea
	jp nc, .no_carry
	jp .next_card

.check_squirtle_lv16
	cp16 SQUIRTLE_LV16
	jr nz, .check_wartortle
	ld b, PLAY_AREA_ARENA
	farcall FindCardIDInTurnDuelistsPlayArea
	jp nc, .no_carry
	jp .next_card

.check_wartortle
	cp16 WARTORTLE_LV22
	jr nz, .check_blastoise
	ld b, PLAY_AREA_ARENA
	farcall FindCardIDInTurnDuelistsPlayArea
	jp nc, .no_carry
	jp .next_card

.check_blastoise
	cp16 BLASTOISE_LV52
	jr nz, .check_seel
	ld b, PLAY_AREA_ARENA
	farcall FindCardIDInTurnDuelistsPlayArea
	jp nc, .no_carry
	jp .next_card

.check_seel
	cp16 SEEL_LV10
	jr nz, .check_dewgong
	ld b, PLAY_AREA_ARENA
	farcall FindCardIDInTurnDuelistsPlayArea
	jr nc, .no_carry
	jr .next_card

.check_dewgong
	cp16 DEWGONG_LV24
	jr nz, .check_lapras
	ld b, PLAY_AREA_ARENA
	farcall FindCardIDInTurnDuelistsPlayArea
	jr nc, .no_carry
	jr .next_card

.check_lapras
	cp16 LAPRAS_LV31
	jr nz, .check_water_energy
	ld b, PLAY_AREA_ARENA
	farcall FindCardIDInTurnDuelistsPlayArea
	jr nc, .no_carry
	jr .next_card

.check_water_energy
	cp16 WATER_ENERGY
	jr nz, .check_breeder
	ld de, BLASTOISE_LV52
	ld b, PLAY_AREA_ARENA
	farcall FindCardIDInTurnDuelistsPlayArea
	jr nc, .no_carry

.check_breeder
	cp16 POKEMON_BREEDER
	jr nz, .next_card
	ld de, BLASTOISE_LV52
	farcall LookForCardIDInHandList
	jr nc, .next_card
	ld de, SQUIRTLE_LV15
	ld b, PLAY_AREA_ARENA
	farcall FindCardIDInTurnDuelistsPlayArea
	jr c, .no_carry
	ld de, SQUIRTLE_LV16
	ld b, PLAY_AREA_ARENA
	farcall FindCardIDInTurnDuelistsPlayArea
	jr c, .no_carry

.next_card
	pop hl
	jp .loop_hand_cards

.set_carry
	; use Professor Oak
	scf
	ret

.no_carry
	; don't use Professor Oak
	pop hl
	or a
	ret

AIDecide_ComputerSearch_RainDanceConfusionDeck_PickDiscardCards:
	ld a, $ff
	ld [wTempAIMultiTargetCardDeckIndex1], a
	ld [wTempAIMultiTargetCardDeckIndex2], a

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
	jp z, .no_carry
	ld b, a
	push hl
	call GetCardIDFromDeckIndex

; try some trainers
	cp16 ENERGY_RETRIEVAL
	jp z, .store_discard_cards

	cp16 POTION
	jr nz, .try_water_energy
	push bc
	farcall CheckIfAnyPlayAreaPokemonHasDamage
	pop bc
	jp nc, .store_discard_cards
	jp .next_card

.try_water_energy
	cp16 WATER_ENERGY
	jr nz, .try_switch
	push bc
	farcall CountCardIDInHand
	pop bc
	cp 3
	jp nc, .store_discard_cards
	jp .next_card

.try_switch
	cp16 SWITCH
	jp z, .store_discard_cards

; try squirtle lv15
	cp16 SQUIRTLE_LV15
	jr nz, .try_squirtle_lv16
	push bc
	ld b, PLAY_AREA_ARENA
	farcall FindCardIDInTurnDuelistsPlayArea
	pop bc
	jr c, .store_discard_cards
	jr .next_card

.try_squirtle_lv16
	cp16 SQUIRTLE_LV16
	jr nz, .try_wartortle
	push bc
	ld b, PLAY_AREA_ARENA
	farcall FindCardIDInTurnDuelistsPlayArea
	pop bc
	jr c, .store_discard_cards
	jr .next_card

.try_wartortle
	cp16 WARTORTLE_LV22
	jr nz, .try_seel
	push bc
	ld b, PLAY_AREA_ARENA
	farcall FindCardIDInTurnDuelistsPlayArea
	pop bc
	jr c, .store_discard_cards
	jr .next_card

.try_seel
	cp16 SEEL_LV10
	jr nz, .try_dewgong
	push bc
	ld b, PLAY_AREA_ARENA
	farcall FindCardIDInTurnDuelistsPlayArea
	pop bc
	jr c, .store_discard_cards
	jr .next_card

.try_dewgong
	cp16 DEWGONG_LV24
	jr nz, .try_lapras
	push bc
	ld b, PLAY_AREA_ARENA
	farcall FindCardIDInTurnDuelistsPlayArea
	pop bc
	jr c, .store_discard_cards
	jr .next_card

.try_lapras
	cp16 LAPRAS_LV31
	jr nz, .next_card
	push bc
	ld b, PLAY_AREA_ARENA
	farcall FindCardIDInTurnDuelistsPlayArea
	pop bc
	jr c, .store_discard_cards

.next_card
	pop hl
	jp .loop_hand_cards

.no_carry
	or a
	ret

.store_discard_cards
	ld a, [wTempAIMultiTargetCardDeckIndex1]
	cp $ff
	jr nz, .latter_discard_card
	ld a, b
	ld [wTempAIMultiTargetCardDeckIndex1], a
	jr .next_card

.latter_discard_card
	ld a, b
	ld [wTempAIMultiTargetCardDeckIndex2], a
; success
	pop hl
	scf
	ret

AIDecide_PokemonTrader_MadPetalsDeck:
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	cp 2
	jr nc, .check_player_fire_pkmn

; check kangaskhan
	ld de, KANGASKHAN_LV40
	ld bc, KANGASKHAN_LV40
	call LookForCardIDToTradeWithDifferentHandCard
	jr nc, .check_player_fire_pkmn

.success
	ld [wTempAIMultiTargetCardDeckIndex1], a
	ld a, e
	scf
	ret

.check_player_fire_pkmn
	ld a, TYPE_PKMN_FIRE
	call CheckIfPlayerHasPokemonOfType
	jp c, .check_squirtle

; check dark gloom in play
	ld de, DARK_GLOOM
	ld b, PLAY_AREA_ARENA
	farcall FindCardIDInTurnDuelistsPlayArea
	jr nc, .check_oddish_dark_vileplume
	ld de, DARK_VILEPLUME
	ld bc, DARK_VILEPLUME
	call LookForCardIDToTradeWithDifferentHandCard
	jr c, .success

.check_oddish_dark_vileplume
	ld de, ODDISH_LV21
	call IsCardIDInHandOrPlayArea
	jr nc, .check_oddish_breeder_dark
	ld de, DARK_VILEPLUME
	farcall LookForCardIDInHandList
	jr nc, .check_oddish_breeder_dark
	ld de, DARK_GLOOM
	ld bc, ODDISH_LV21
	call LookForCardIDToTradeWithDifferentHandCard
	jr c, .success

.check_oddish_breeder_dark
	ld de, ODDISH_LV21
	call IsCardIDInHandOrPlayArea
	jr nc, .check_dark_gloom_in_hand
	ld de, POKEMON_BREEDER
	farcall LookForCardIDInHandList
	jr nc, .check_dark_gloom_in_hand
	ld de, DARK_VILEPLUME
	ld bc, ODDISH_LV21
	call LookForCardIDToTradeWithDifferentHandCard
	jr c, .success

.check_dark_gloom_in_hand
	ld de, DARK_GLOOM
	farcall LookForCardIDInHandList
	jr nc, .check_dark_vileplume_breeder
	ld de, DARK_VILEPLUME
	farcall LookForCardIDInHandList
	jr nc, .check_dark_vileplume_breeder
	ld de, ODDISH_LV21
	ld bc, DARK_GLOOM
	call LookForCardIDToTradeWithDifferentHandCard
	jp c, .success

.check_dark_vileplume_breeder
	ld de, DARK_VILEPLUME
	farcall LookForCardIDInHandList
	jr nc, .check_gloom
	ld de, POKEMON_BREEDER
	farcall LookForCardIDInHandList
	jr nc, .check_gloom
	ld de, ODDISH_LV21
	ld bc, DARK_VILEPLUME
	call LookForCardIDToTradeWithDifferentHandCard
	jp c, .success

.check_gloom
	ld de, GLOOM
	ld b, PLAY_AREA_ARENA
	farcall FindCardIDInTurnDuelistsPlayArea
	jr nc, .check_oddish_vileplume
	ld de, VILEPLUME
	ld bc, VILEPLUME
	call LookForCardIDToTradeWithDifferentHandCard
	jp c, .success

.check_oddish_vileplume
	ld de, ODDISH_LV21
	call IsCardIDInHandOrPlayArea
	jr nc, .check_oddish_breeder_nondark
	ld de, VILEPLUME
	farcall LookForCardIDInHandList
	jr nc, .check_oddish_breeder_nondark
	ld de, GLOOM
	ld bc, ODDISH_LV21
	call LookForCardIDToTradeWithDifferentHandCard
	jp c, .success

.check_oddish_breeder_nondark
	ld de, ODDISH_LV21
	call IsCardIDInHandOrPlayArea
	jr nc, .check_gloom_vileplume
	ld de, POKEMON_BREEDER
	farcall LookForCardIDInHandList
	jr nc, .check_gloom_vileplume
	ld de, VILEPLUME
	ld bc, ODDISH_LV21
	call LookForCardIDToTradeWithDifferentHandCard
	jp c, .success

.check_gloom_vileplume
	ld de, GLOOM
	farcall LookForCardIDInHandList
	jr nc, .check_vileplume_breeder
	ld de, VILEPLUME
	farcall LookForCardIDInHandList
	jr nc, .check_vileplume_breeder
	ld de, ODDISH_LV21
	ld bc, GLOOM
	call LookForCardIDToTradeWithDifferentHandCard
	jp c, .success

.check_vileplume_breeder
	ld de, VILEPLUME
	farcall LookForCardIDInHandList
	ret nc
	ld de, POKEMON_BREEDER
	farcall LookForCardIDInHandList
	ret nc
	ld de, ODDISH_LV21
	ld bc, VILEPLUME
	call LookForCardIDToTradeWithDifferentHandCard
	jp c, .success
	ret

.check_squirtle
	ld de, SQUIRTLE_LV16
	call IsCardIDInHandOrPlayArea
	jr nc, .check_wartortle
	ld de, WARTORTLE_LV22
	ld bc, SQUIRTLE_LV16
	call LookForCardIDToTradeWithDifferentHandCard
	jp c, .success

.check_wartortle
	ld de, WARTORTLE_LV22
	farcall LookForCardIDInHandList
	jr nc, .check_squirtle_in_deck
	ld de, SQUIRTLE_LV16
	ld bc, WARTORTLE_LV22
	call LookForCardIDToTradeWithDifferentHandCard
	jp c, .success

.check_squirtle_in_deck
	ld de, SQUIRTLE_LV16
	ld bc, SQUIRTLE_LV16
	call LookForCardIDToTradeWithDifferentHandCard
	jp c, .success
	ret

AIDecide_ComputerSearch_MadPetalsDeck_FindTarget:
	ld a, TYPE_PKMN_FIRE
	call CheckIfPlayerHasPokemonOfType
	jp c, .check_wartortle

	ld de, ODDISH_LV21
	ld b, PLAY_AREA_ARENA
	farcall FindCardIDInTurnDuelistsPlayArea
	jr nc, .check_wartortle
	ld de, DARK_GLOOM
	farcall LookForCardIDInHandList
	jr c, .check_gloom
	ld de, DARK_VILEPLUME
	farcall LookForCardIDInHandList
	jr c, .target_breeder

.check_gloom
	ld de, GLOOM
	farcall LookForCardIDInHandList
	jr c, .target_basic_pkmn
	ld de, VILEPLUME
	farcall LookForCardIDInHandList
	jr nc, .target_basic_pkmn

.target_breeder
	ld de, POKEMON_BREEDER
	call IsCardIDInDeckAndNotInHand
	ret c
	jr .target_basic_pkmn

.check_wartortle
	ld de, WARTORTLE_LV22
	ld b, PLAY_AREA_ARENA
	farcall FindCardIDInTurnDuelistsPlayArea
	jr nc, .target_basic_pkmn

; target rainbow energy
	ld de, RAINBOW_ENERGY
	call IsCardIDInDeckAndNotInHand
	ret c

.target_basic_pkmn
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	cp 2
	ret nc
	ld de, KANGASKHAN_LV40
	call IsCardIDInDeckAndNotInHand
	ret c
	ld de, ODDISH_LV21
	call IsCardIDInDeckAndNotInHand
	ret c
	ld de, SQUIRTLE_LV16
	call IsCardIDInDeckAndNotInHand
	ret c
	ld de, SCYTHER_LV25
	call IsCardIDInDeckAndNotInHand
	ret

; return carry if DCE is attached to player's pkmn in play
; input:
; b = starting PLAY_AREA_* location
; output:
; a = deck index of found DCE
; b = found PLAY_AREA_* location
FindDoubleColorlessAttachedToPlayerPokemonInPlayArea:
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

; returns in a the card index of energy card
; attached to Pokémon in Play Area location a,
; that is to be discarded by the AI for an effect.
; outputs $ff is none was found.
; input:
;	a = PLAY_AREA_* constant of card
; output:
;	a = deck index of attached energy card chosen
AIPickEnergyCardToDiscard:
; load Pokémon's attached energy cards.
	ldh [hTempPlayAreaLocation_ff9d], a

	; if has Recycle Energy, pick it right away
	ld de, RECYCLE_ENERGY
	farcall CheckIfHasSpecificEnergyAttached
	ret c

	ldh a, [hTempPlayAreaLocation_ff9d]
	call CreateArenaOrBenchEnergyCardList
	or a
	jr z, .no_energy

; load card's ID and type.
	ldh a, [hTempPlayAreaLocation_ff9d]
	add DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call GetCardIDFromDeckIndex
	ld a, e
	ld [wTempCardID_d0a3 + 0], a
	ld a, d
	ld [wTempCardID_d0a3 + 1], a
	call LoadCardDataToBuffer1_FromCardID
	ld a, [wLoadedCard1Type]
	or TYPE_ENERGY
	ld [wTempCardType], a

; find a card that is not useful.
; if none is found, just return the first energy card attached.
	ld hl, wDuelTempList
.loop
	ld a, [hl]
	cp $ff
	jr z, .not_found
	farcall CheckIfEnergyIsUseful
	jr nc, .found
	inc hl
	jr .loop

.found
	ld a, [hl]
	ret
.not_found
	ld hl, wDuelTempList
	ld a, [hl]
	ret
.no_energy
	ld a, $ff
	ret

; return in a deck index of energy card attached to
; pkmn at PLAY_AREA_* location in a
; to be removed by AI
; (or $ff if no energy)
;   order: DCE -> useful energy -> not useful energy -> Recycle Energy
PickAttachedEnergyCardToRemove:
	ldh [hTempPlayAreaLocation_ff9d], a
	call CreateArenaOrBenchEnergyCardList
	or a
	jr z, .no_energy

	ldh a, [hTempPlayAreaLocation_ff9d]
	add DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call GetCardIDFromDeckIndex
	ld a, e
	ld [wTempCardID_d0a3], a
	ld a, d
	ld [wTempCardID_d0a3 + 1], a
	call LoadCardDataToBuffer1_FromCardID
	ld a, [wLoadedCard1Type]
	or TYPE_ENERGY
	ld [wTempCardType], a

; check DCE
	ld hl, wDuelTempList
.loop_energy_cards_1
	ld a, [hl]
	cp $ff
	jr z, .check_useful
	push hl
	call GetCardIDFromDeckIndex
	cp16 DOUBLE_COLORLESS_ENERGY
	pop hl
	jr z, .found
	inc hl
	jr .loop_energy_cards_1

.check_useful
	ld hl, wDuelTempList
.loop_energy_cards_2
	ld a, [hl]
	cp $ff
	jr z, .check_non_recycle_energy
	farcall CheckIfEnergyIsUseful
	jr c, .found
	inc hl
	jr .loop_energy_cards_2

.found
	ld a, [hl]
	ret

.check_non_recycle_energy
	ld hl, wDuelTempList
.loop_energy_cards_3
	ld a, [hl]
	cp $ff
	jr z, .default
	call GetCardIDFromDeckIndex
	cp16 RECYCLE_ENERGY
	jr nz, .found_non_useful
	inc hl
	jr .loop_energy_cards_3

; redundant
.found_non_useful
	ld a, [hl]
	ret

.default
	ld hl, wDuelTempList
	ld a, [hl]
	ret

.no_energy
	ld a, $ff
	ret

; return in a and [wTempAI], and b and [wTempAI2], the deck indices
; of energy cards attached to pkmn at PLAY_AREA_* location in a
; (or just $ff in a if < 2 energy)
;   order: DCE -> useful energy -> not useful energy -> Recycle Energy
PickTwoAttachedEnergyCards:
	ldh [hTempPlayAreaLocation_ff9d], a
	call CreateArenaOrBenchEnergyCardList
	cp 2
	jp c, .not_enough

	ldh a, [hTempPlayAreaLocation_ff9d]
	ld b, a
	ld a, DUELVARS_ARENA_CARD
	add b
	get_turn_duelist_var
	call GetCardIDFromDeckIndex
	ld a, e
	ld [wTempCardID_d0a3], a
	ld a, d
	ld [wTempCardID_d0a3 + 1], a
	call LoadCardDataToBuffer1_FromCardID
	ld a, [wLoadedCard1Type]
	or TYPE_ENERGY
	ld [wTempCardType], a
	ld a, $ff
	ld [wTempAI], a
	ld [wTempAI2], a

; check DCE
	ld hl, wDuelTempList
.loop_energy_cards_1
	ld a, [hl]
	cp $ff
	jr z, .check_useful
	push hl
	call GetCardIDFromDeckIndex
	cp16 DOUBLE_COLORLESS_ENERGY
	pop hl
	jr z, .found_dce
	inc hl
	jr .loop_energy_cards_1
.found_dce
	ld a, [wTempAI]
	cp $ff
	jr nz, .already_chosen_1
	ld a, [hli]
	ld [wTempAI], a
	jr .loop_energy_cards_1
.already_chosen_1
	ld a, [hl]
	ld [wTempAI2], a
	jr .done

.check_useful
	ld hl, wDuelTempList
.loop_energy_cards_2
	ld a, [hl]
	cp $ff
	jr z, .check_non_recycle_energy
	farcall CheckIfEnergyIsUseful
	jr c, .found_useful
	inc hl
	jr .loop_energy_cards_2
.found_useful
	ld a, [wTempAI]
	cp $ff
	jr nz, .already_chosen_2
	ld a, [hli]
	ld [wTempAI], a
	jr .loop_energy_cards_2
.already_chosen_2
	ld b, a
	ld a, [hli]
	cp b
	jr z, .loop_energy_cards_2
	ld [wTempAI2], a
	jr .done

.check_non_recycle_energy
	ld hl, wDuelTempList
.loop_energy_cards_3
	ld a, [hl]
	cp $ff
	jr z, .default
	call GetCardIDFromDeckIndex
	cp16 RECYCLE_ENERGY
	jr nz, .found_non_useful
	inc hl
	jr .loop_energy_cards_3
.found_non_useful
	ld a, [wTempAI]
	cp $ff
	jr nz, .already_chosen_3
	ld a, [hli]
	ld [wTempAI], a
	jr .loop_energy_cards_3
.already_chosen_3
	ld b, a
	ld a, [hli]
	cp b
	jr z, .loop_energy_cards_3
	ld [wTempAI2], a
	jr .done

.default
	ld hl, wDuelTempList
	ld a, [wTempAI]
	cp $ff
	jr nz, .pick_one_card
; pick 2 cards
	ld a, [hli]
	ld [wTempAI], a
	ld a, [hl]
	ld [wTempAI2], a
	jr .done
.pick_one_card
	ld a, [wTempAI]
	ld b, a
.loop_energy_cards_4
	ld a, [hli]
	cp b
	jr z, .loop_energy_cards_4 ; already picked
	ld [wTempAI2], a

.done
	ld a, [wTempAI2]
	ld b, a
	ld a, [wTempAI]
	ret

.not_enough
	ld a, $ff
	ret

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

; Evolutionary Light, The Boss's Way, etc.
; return carry if
;     card ID in de is found in deck but not in hand or play area
; AND card ID in bc is found in hand or play area
; input:
; - de = card ID 1 (evo card)
; - bc = card ID 2 (card to evolve to card ID 1)
; output:
; - a = deck index of card ID 1 found in deck
LookForEvoCardInDeck_GivenPreevoInHandOrPlayArea:
	push bc
	push de
	ld a, CARD_LOCATION_DECK
	farcall FindCardIDInLocation
	pop de
	pop bc
	ret nc ; card ID 1 not found in deck
	ld [wTempAISingleTargetCardDeckIndex], a
	push bc
	push de
	ld d, b
	ld e, c
	call IsCardIDInHandOrPlayArea
	pop de
	pop bc
	ret nc ; card ID 2 not found in hand or play area
	push bc
	call IsCardIDInHandOrPlayArea
	pop de
	jr c, .no_carry ; card ID 1 found in hand or play area

; success
	ld a, [wTempAISingleTargetCardDeckIndex]
	scf
	ret

.no_carry
	or a
	ret

; Evolutionary Light, The Boss's Way, etc.
; return carry if
;     card ID in de is found in deck but not in hand
; AND card ID in bc is found in play area
; input:
; - de = card ID 1 (evo card)
; - bc = card ID 2 (card to evolve to card ID 1)
; output:
; - a = deck index of card ID 1 found in deck
LookForEvoCardInDeck_GivenPreevoInPlayArea:
	push bc
	push de
	ld a, CARD_LOCATION_DECK
	farcall FindCardIDInLocation
	pop de
	pop bc
	ret nc ; card ID 1 not found in deck
	ld [wTempAISingleTargetCardDeckIndex], a
	push de
	ld d, b
	ld e, c
	farcall FindCardIDInTurnDuelistsPlayArea
	pop de
	ret nc ; card ID 2 not found in play area
	push de
	farcall LookForCardIDInHandList
	pop bc
	jr c, .no_carry ; card ID 1 found in hand

; success
	ld a, [wTempAISingleTargetCardDeckIndex]
	scf
	ret

.no_carry
	or a
	ret

; return carry if
;     card ID in de is found in deck but not in hand or play area
; AND card ID in bc is found in hand
; input:
; - de = card ID 1
; - bc = card ID 2
; output:
; - a = deck index of card ID 1 found in deck
LookForCardIDInDeck_GivenCardIDInHand:
	push bc
	push de
	ld a, CARD_LOCATION_DECK
	farcall FindCardIDInLocation
	pop de
	pop bc
	ret nc ; card ID 1 not found in deck
	ld [wTempAISingleTargetCardDeckIndex], a
	push bc
	call IsCardIDInHandOrPlayArea
	pop de
	jr c, .no_carry ; card ID 1 found in hand or play area
	farcall LookForCardIDInHandList
	ret nc ; card ID 2 not found in hand

; success
	ld a, [wTempAISingleTargetCardDeckIndex]
	scf
	ret

.no_carry
	or a
	ret

; return carry if
;    (
;       card ID in de is found in deck but not in hand or play area
;   AND card ID in bc is found in hand or play area
; )
; OR (
;       card ID in de is found in hand
;   AND card ID in bc is found in deck but not in hand or play area
; )
; inputs:
; - de = card ID 1 (evo card)
; - bc = card ID 2 (card to evolve to card ID 1)
CheckReelInEvoLineTarget:
	push bc
	push de
	call LookForEvoCardInDeck_GivenPreevoInHandOrPlayArea
	pop bc
	pop de
	ret c
	call LookForCardIDInDeck_GivenCardIDInHand
	ret

; return carry if
;     card ID in de is found in discard pile but not in hand or play area
; AND card ID in bc is found in hand or play area
; input:
; - de = card ID 1
; - bc = card ID 2
; output:
; - a = deck index of card ID 1 found in discard pile
LookForCardIDInDiscardPile_GivenCardIDInHandOrPlayArea:
	push bc
	push de
	ld a, CARD_LOCATION_DISCARD_PILE
	farcall FindCardIDInLocation
	pop de
	pop bc
	ret nc ; card ID 1 not found in discard pile
	ld [wTempAISingleTargetCardDeckIndex], a
	push de
	ld d, b
	ld e, c
	call IsCardIDInHandOrPlayArea
	pop de
	ret nc ; card ID 2 not found in hand or play area
	call IsCardIDInHandOrPlayArea
	jr c, .no_carry ; card ID 1 found in hand or play area

; success
	ld a, [wTempAISingleTargetCardDeckIndex]
	scf
	ret

.no_carry
	or a
	ret

; return carry if
;     card ID in de is found in discard pile but not in hand or play area
; AND card ID in bc is found in hand
; input:
; - de = card ID 1
; - bc = card ID 2
; output:
; - a = deck index of card ID 1 found in discard pile
LookForCardIDInDiscardPile_GivenCardIDInHand:
	push bc
	push de
	ld a, CARD_LOCATION_DISCARD_PILE
	farcall FindCardIDInLocation
	pop de
	pop bc
	ret nc ; card ID 1 not found in discard pile
	ld [wTempAISingleTargetCardDeckIndex], a
	push bc
	call IsCardIDInHandOrPlayArea
	pop de
	jr c, .no_carry ; card ID 1 found in hand or play area
	farcall LookForCardIDInHandList
	ret nc ; card ID 2 not found in hand

; success
	ld a, [wTempAISingleTargetCardDeckIndex]
	scf
	ret

.no_carry
	or a
	ret

; return carry if
;     card ID in de is found in deck but not in hand
; AND card ID in bc is found in play area with >= (number in a) energy attached
; input:
; - a = number of energies
; - de = card ID 1
; - bc = card ID 2
; output:
; - a = deck index of card ID 1 found in discard pile
LookForCardIDInDeck_GivenCardIDInPlayAreaWithEnoughEnergy:
	ld [wTempAICount1], a
	push bc
	push de
	ld a, CARD_LOCATION_DECK
	farcall FindCardIDInLocation
	pop de
	pop bc
	ret nc ; card ID 1 not found in deck
	ld [wTempAISingleTargetCardDeckIndex], a
	push de
	ld d, b
	ld e, c
	ld a, [wTempAICount1]
	ld b, PLAY_AREA_ARENA
	call FindTurnDuelistPokemonInPlayAreaWithEnoughEnergy
	pop de
	ret nc ; card ID 2 with enough energy not found in play area
	push de
	farcall LookForCardIDInHandList
	pop bc
	jr c, .no_carry ; card ID 1 found in hand

; success
	ld a, [wTempAISingleTargetCardDeckIndex]
	scf
	ret

.no_carry
	or a
	ret

; return carry if
; card ID in de is found in play area with >= (number in a) energy attached
; input:
; - a = number of energies
; - b = starting PLAY_AREA_* location
; - de = card ID
; output:
;   a = b = found location if successful,
;   a = MAX_PLAY_AREA_POKEMON, b = $ff otherwise
FindTurnDuelistPokemonInPlayAreaWithEnoughEnergy:
	ld [wTempAICount2], a
.loop
	ld a, DUELVARS_ARENA_CARD
	add b
	get_turn_duelist_var
	cp $ff
	ret z
	push bc
	push de
	call GetCardIDFromDeckIndex
	pop bc
	; compare bc with de
	ld a, d
	cp b
	jr nz, .next
	ld a, e
	cp c
	jr z, .equal
.next
	ld d, b
	ld e, c
	pop bc
	inc b
	ld a, MAX_PLAY_AREA_POKEMON
	cp b
	jr nz, .loop
	ld b, $ff
	or a
	ret

.equal
	pop bc
	push bc
	; does it have input num of energies?
	ld e, b
	call GetPlayAreaCardAttachedEnergies
	ld a, [wTotalAttachedEnergies]
	ld hl, wTempAICount2
	cp [hl]
	jr c, .next
	pop bc
	ld a, b
	scf
	ret

; return carry if card id in de is found in hand or play area
; input:
; - de = card ID
IsCardIDInHandOrPlayArea:
	push de
	farcall LookForCardIDInHandList
	pop de
	ret c ; found in hand
	ld b, PLAY_AREA_ARENA
	farcall FindCardIDInTurnDuelistsPlayArea
	ret c ; found in Play Area
	or a
	ret

; get a random card from list in hl (wDuelTempList)
; that is different from deck index in e and matches AI_SEARCH_ONLY_* in d,
; return carry and the deck index, and drop that card from the list
; no carry and a = $ff if not found
TakeOutDifferentCardOfSpecificTypeFromListInHL:
	push hl
	push de
	push bc
	call CountCardsInDuelTempList
	call ShuffleCards
.loop_cards
	ld a, [hli]
	cp $ff
	jr z, .no_carry
	cp e
	jr z, .loop_cards
	ldh [hTempCardIndex_ff98], a
	push de
	call GetCardIDFromDeckIndex
	call GetCardType
	pop de
	cp TYPE_ENERGY
	jr c, .pkmn_card
	cp TYPE_TRAINER
	jr nz, .energy_card
; trainer
	ld a, d
	or a ; AI_SEARCH_ONLY_TRAINER
	jr nz, .loop_cards
	jr .found
.energy_card
	ld a, d
	cp AI_SEARCH_ONLY_ENERGY
	jr nz, .loop_cards
	jr .found
.pkmn_card
	ld a, d
	cp AI_SEARCH_ONLY_PKMN
	jr nz, .loop_cards

.found
	ld d, h
	ld e, l
	dec hl
.loop_shift
	ld a, [de]
	inc de
	ld [hli], a
	cp $ff
	jr nz, .loop_shift

; success
	ldh a, [hTempCardIndex_ff98]
	pop bc
	pop de
	pop hl
	scf
	ret

.no_carry
	pop bc
	pop de
	pop hl
	or a
	ret

; return carry if
;     card ID in de is found in deck but not in hand
; AND any pkmn card that is not card ID in bc is found in hand
; input:
; - de = card ID 1
; - bc = card ID 2
; output:
; - a = deck index of card ID 1 found in deck
; - e = deck index of pkmn card in hand different from card ID 2
LookForCardIDToTradeWithDifferentHandCard:
	push bc
	push de
	farcall LookForCardIDInHandList
	pop de
	pop bc
	jr c, .no_carry ; card ID 1 found in hand
	push bc
	ld a, CARD_LOCATION_DECK
	farcall FindCardIDInLocation
	pop de
	jr nc, .no_carry ; card ID 1 not found in deck
	ld [wTempAI], a
	push de
	call CreateHandCardList
	pop de
	ld hl, wDuelTempList
.loop_hand_cards
	ld a, [hli]
	cp $ff
	jr z, .no_carry
	ld b, a
	call LoadCardDataToBuffer1_FromDeckIndex
	ld a, [wLoadedCard1ID]
	cp e
	jr nz, .check_if_pkmn_card
	ld a, [wLoadedCard1ID + 1]
	cp d
	jr z, .loop_hand_cards
.check_if_pkmn_card
	ld a, [wLoadedCard1Type]
	cp TYPE_ENERGY
	jr nc, .loop_hand_cards

; success
	ld e, b
	ld a, [wTempAI]
	scf
	ret

.no_carry
	or a
	ret

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

; returns in a number of Pokémon in Play Area
; plus number of Pokémon cards in hand
CountNumberOfPkmnInPlayAreaAndInHand:
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	ld [wTempAI], a
	call CreateHandCardList
	ld hl, wDuelTempList
.loop_cards
	ld a, [hli]
	cp $ff
	jr z, .done
	call GetCardIDFromDeckIndex
	call GetCardType
	cp TYPE_ENERGY
	jr nc, .loop_cards
	; is Pokémon card
	ld a, [wTempAI]
	inc a
	ld [wTempAI], a
	jr .loop_cards
.done
	ld a, [wTempAI]
	ret

; return carry and the deck index of dupe pkmn cards in hand
; no carry and a = $ff if not found
FindDuplicatePokemonCardsInHand:
	ld a, $ff
	ld [wTempAI], a

	call CreateHandCardList
	ld hl, wDuelTempList
	push hl
.loop_cards
	pop hl
	ld a, [hli]
	cp $ff
	jr z, .check_found
	call GetCardIDFromDeckIndex
	ld b, d
	ld c, e
	push hl
.loop_compare
	ld a, [hli]
	cp $ff
	jr z, .loop_cards
	ld [wTempAIHandDuplicatePokemonCardDeckIndex], a
	push bc
	call GetCardIDFromDeckIndex
	pop bc
	ld a, e
	cp c
	jr nz, .loop_compare
	ld a, d
	cp b
	jr nz, .loop_compare
	push bc
	call GetCardType
	pop bc
	cp TYPE_ENERGY
	jr nc, .loop_cards
	ld a, [wTempAIHandDuplicatePokemonCardDeckIndex]
	ld [wTempAI], a
	jr .loop_cards

.check_found
	ld a, [wTempAI]
	cp $ff
	jr z, .not_found
; found
	scf ; actually redundant
	ret
.not_found
	or a
	ret

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

; for an HP-recovery effect (a = amount),
; set carry if that puts the active pkmn out of KO range of the defending pkmn,
; no carry otherwise
CheckIfHealingPreventsKOByDefendingPokemon:
	ld [wAITempHPRecoverAmount], a
	xor a ; PLAY_AREA_ARENA
	ldh [hTempPlayAreaLocation_ff9d], a
	call CheckIfDefendingPokemonCanKnockOut
	jr nc, .no_carry

	; can KO
	ld d, a ; excess damage after KO'ing
	ld a, DUELVARS_ARENA_CARD_HP
	get_turn_duelist_var
	ld h, a ; remaining HP
	ld e, PLAY_AREA_ARENA
	call GetCardDamageAndMaxHP
	push hl
	ld hl, wAITempHPRecoverAmount
	cp [hl]
	pop hl
	jr c, .got_actual_recovery_amount
	ld a, [wAITempHPRecoverAmount]
.got_actual_recovery_amount
	ld l, a ; l = HP recovery (min(card damage, base recovery amount))
	ld a, h ; a = remaining HP
	add l   ; a += HP recovery
	sub d   ; a -= damage done by the defender
	jr c, .no_carry
	jr z, .no_carry
	; does not get KO'd after heal
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

; find duplicates in card list in hl, excluding card in wAITrainerCardToPlay,
; return deck index of the second one in a if found;
; return carry and a = $ff otherwise
FindDuplicateCards_IgnoreTrainerCardToPlay:
	ld a, $ff
	ld [wTempAITargetPokemonCardDeckIndex], a
	ld [wTempAITargetNonPokemonCardDeckIndex], a

	push hl
.loop_cards
	pop hl
	ld a, [hli]
	cp $ff
	jr z, .check_found
	call GetCardIDFromDeckIndex
	push hl
.loop_compare
	ld a, [hli]
	cp $ff
	jr z, .loop_cards
	ld c, a
	push hl
	ld hl, wAITrainerCardToPlay
	cp [hl]
	pop hl
	jr z, .loop_compare
	push de
	call GetCardIDFromDeckIndex
	ld a, e
	ld b, d
	pop de
	cp e
	jr nz, .loop_compare
	ld a, b
	cp d
	jr nz, .loop_compare

; found two cards with same ID
	push bc
	push de
	call GetCardType
	pop de
	pop bc
	cp TYPE_ENERGY
	jr c, .pkmn_card
; energy or trainer
	ld a, c
	ld [wTempAITargetNonPokemonCardDeckIndex], a
	jr .loop_cards
.pkmn_card
	ld a, c
	ld [wTempAITargetPokemonCardDeckIndex], a
	jr .loop_cards

.check_found
	ld a, [wTempAITargetPokemonCardDeckIndex]
	cp $ff
	jr nz, .found
	ld a, [wTempAITargetNonPokemonCardDeckIndex]
	cp $ff
	jr nz, .found
; not found
	scf
	ret
.found
	or a
	ret

; return carry and the deck index if
; card ID in de is in deck and not in hand
IsCardIDInDeckAndNotInHand:
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

; return carry and the deck index if
; card ID in de is in deck and not in hand or play area
IsCardIDInDeckAndNotInHandOrPlayArea:
	push de
	call IsCardIDInHandOrPlayArea
	pop de
	jr c, .no_carry ; is in hand or play area
	ld a, CARD_LOCATION_DECK
	farcall FindCardIDInLocation
	ret c ; is in deck
.no_carry
	or a
	ret

; return carry and the deck index if
; Master Ball hits target pkmn card in de
AITryMasterBall_GivenTarget:
	ld a, DUELVARS_NUMBER_OF_CARDS_NOT_IN_DECK
	get_turn_duelist_var
	add DUELVARS_DECK_CARDS
	ld l, a
	ld c, 7
.loop_deck_cards
	ld a, [hli]
	ld [wTempAITargetPokemonCardDeckIndex], a
	push de
	push bc
	call GetCardIDFromDeckIndex
	pop bc
	ld b, d
	ld a, e
	pop de
	cp e
	jr nz, .next_card
	ld a, b
	cp d
	jr z, .found
.next_card
	dec c
	jr nz, .loop_deck_cards
; not found
	or a
	ret
.found
	ld a, [wTempAITargetPokemonCardDeckIndex]
	scf
	ret

; return carry and the deck index if
; Master Ball hits any pkmn card
AITryMasterBall:
	ld a, DUELVARS_NUMBER_OF_CARDS_NOT_IN_DECK
	get_turn_duelist_var
	add DUELVARS_DECK_CARDS
	ld l, a
	ld c, 7
.loop_deck_cards
	ld a, [hli]
	ld [wTempAITargetPokemonCardDeckIndex], a
	push bc
	call GetCardIDFromDeckIndex
	call GetCardType
	pop bc
	cp TYPE_ENERGY
	jr c, .found
	dec c
	jr nz, .loop_deck_cards
; not found
	or a
	ret
.found
	ld a, [wTempAITargetPokemonCardDeckIndex]
	scf
	ret

; return carry if
; >= 18 cards remaining in deck pile
; AND (
;      <= 4 cards in hand
;   OR no energy cards in hand
;   OR no bench pkmn
; )
; AND no non-whitelist cards in hand;
; whitelist:
;   Professor Oak, Energy Retrieval, Switch, Lightning/Full Heal Energy;
;   exactly 1 Computer Search;
;   Potion if no heal targets;
;   cards already in own play area
ColorlessAltarAIDecideProfessorOak:
	ld a, DUELVARS_NUMBER_OF_CARDS_NOT_IN_DECK
	get_turn_duelist_var
	cp DECK_SIZE - 17
	ret nc

	ld a, DUELVARS_NUMBER_OF_CARDS_IN_HAND
	get_turn_duelist_var
	cp 5
	jr c, .check_hand

	call CountEnergyCardsInHand
	jr c, .check_hand

	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	cp 1
	jr z, .check_hand

; disinclined, no carry
	or a
	ret

.check_hand
	call CreateHandCardList
	ld hl, wDuelTempList
	ld de, wTempCardCollection
.loop_copy
	ld a, [hli]
	ld [de], a
	inc de
	cp $ff
	jr nz, .loop_copy

	ld hl, wc000
.loop_hand_cards
	ld a, [hli]
	cp $ff
	jp z, .set_carry
	push hl
	call GetCardIDFromDeckIndex

	; if is any of the following cards, continue
	cp16 PROFESSOR_OAK
	jr z, .next_card
	cp16 ENERGY_RETRIEVAL
	jr z, .next_card
	cp16 SWITCH
	jr z, .next_card
	cp16 LIGHTNING_ENERGY
	jr z, .next_card
	cp16 FULLHEAL_ENERGY
	jr z, .next_card

	; if is Computer Search and there's another
	; Computer Search in hand, then don't use
	cp16 COMPUTER_SEARCH
	jr nz, .check_potion
	ld de, COMPUTER_SEARCH
	call CheckIfHandHasRepeatedCard
	jr c, .no_carry
	jr .next_card
.check_potion
	; if is Potion and there are any damage counters
	; in own Play Area, don't use
	cp16 POTION
	jr nz, .check_play_area
	farcall CheckIfAnyPlayAreaPokemonHasDamage
	jr c, .no_carry
	jr .next_card
.check_play_area
	; if is a Pokémon card, and that card isn't found
	; in Play Area, then don't use
	push de
	ld b, PLAY_AREA_ARENA
	farcall FindCardIDInTurnDuelistsPlayArea
	pop de
	jr c, .next_card
.no_carry
	; don't use Professor Oak
	pop hl
	or a
	ret
.next_card
	pop hl
	jp .loop_hand_cards

.set_carry
	; use Professor Oak
	scf
	ret

AIDecide_MoonStone_EyeOfTheStormDeck:
	ld a, 3
	ld bc, PIDGEOTTO_LV38
	ld de, PIDGEOT_LV40
	call LookForCardIDInDeck_GivenCardIDInPlayAreaWithEnoughEnergy
	ret c
	ld a, 2
	ld bc, PIDGEY_LV10
	ld de, PIDGEOTTO_LV38
	call LookForCardIDInDeck_GivenCardIDInPlayAreaWithEnoughEnergy
	ret c
	ld a, 3
	ld bc, SPEAROW_LV13
	ld de, FEAROW_LV27
	call LookForCardIDInDeck_GivenCardIDInPlayAreaWithEnoughEnergy
	ret

AIDecide_ComputerSearch_EyeOfTheStormDeck:
	ld a, DUELVARS_NUMBER_OF_CARDS_IN_HAND
	get_turn_duelist_var
	cp 5
	jr nc, .check_moon_stone
	ld a, DUELVARS_NUMBER_OF_CARDS_NOT_IN_DECK
	get_turn_duelist_var
	cp DECK_SIZE - 19
	jr nc, .check_moon_stone
	call ColorlessAltarAIDecideProfessorOak
	jr nc, .check_moon_stone

; target professor oak
	ld de, PROFESSOR_OAK
	ld a, CARD_LOCATION_DECK
	farcall FindCardIDInLocation
	jr c, .find_discard_cards

.check_moon_stone
	ld de, MOON_STONE
	farcall LookForCardIDInHandList
	jr c, .target_gust_of_wind

; target pkmn
	ld a, 3
	ld bc, PIDGEOTTO_LV38
	ld de, PIDGEOT_LV40
	call LookForCardIDInDeck_GivenCardIDInPlayAreaWithEnoughEnergy
	jr c, .find_discard_cards
	ld a, 2
	ld bc, PIDGEY_LV10
	ld de, PIDGEOTTO_LV38
	call LookForCardIDInDeck_GivenCardIDInPlayAreaWithEnoughEnergy
	jr c, .find_discard_cards
	ld a, 3
	ld bc, SPEAROW_LV13
	ld de, FEAROW_LV27
	call LookForCardIDInDeck_GivenCardIDInPlayAreaWithEnoughEnergy
	jr c, .find_discard_cards
	ld bc, PIDGEOTTO_LV38
	ld de, PIDGEOT_LV40
	call LookForEvoCardInDeck_GivenPreevoInHandOrPlayArea
	jr c, .find_discard_cards
	ld bc, PIDGEY_LV10
	ld de, PIDGEOTTO_LV38
	call LookForEvoCardInDeck_GivenPreevoInHandOrPlayArea
	jr c, .find_discard_cards
	ld bc, SPEAROW_LV13
	ld de, FEAROW_LV27
	call LookForEvoCardInDeck_GivenPreevoInHandOrPlayArea
	jr c, .find_discard_cards

.target_gust_of_wind
	farcall FindBenchCardThatCanBeKnockedOut
	ret nc
	ld de, GUST_OF_WIND
	ld a, CARD_LOCATION_DECK
	farcall FindCardIDInLocation
	ret nc

.find_discard_cards
	ld [wTempAISingleTargetCardDeckIndex_2], a
	ld a, $ff
	ld [wTempAIMultiTargetCardDeckIndex1], a
	ld [wTempAIMultiTargetCardDeckIndex2], a

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
; try some trainers
	cp16 PROFESSOR_OAK
	jr z, .store_discard_cards
	cp16 ENERGY_RETRIEVAL
	jr z, .store_discard_cards
	cp16 SWITCH
	jr z, .store_discard_cards
	cp16 POTION
	jr nz, .try_lightning_energy
	farcall CheckIfAnyPlayAreaPokemonHasDamage
	jr c, .next_card
	jr .store_discard_cards
.try_lightning_energy
	cp16 LIGHTNING_ENERGY
	jr z, .store_discard_cards
; try pkmn
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	cp MAX_PLAY_AREA_POKEMON
	jr nz, .next_card
	push de
	ld b, PLAY_AREA_ARENA
	farcall FindCardIDInTurnDuelistsPlayArea
	pop de
	jr c, .store_discard_cards
.next_card
	pop hl
	inc hl
	jp .loop_hand_cards

.store_discard_cards
	pop hl
	ld b, [hl]
	push hl
	ld a, [wTempAIMultiTargetCardDeckIndex1]
	cp $ff
	jr nz, .latter_discard_card
	ld a, b
	ld [wTempAIMultiTargetCardDeckIndex1], a
	jr .next_card

.latter_discard_card
	ld a, b
	ld [wTempAIMultiTargetCardDeckIndex2], a
; success
	pop hl
	ld a, [wTempAISingleTargetCardDeckIndex_2]
	scf
	ret

.no_carry
	or a
	ret

AIDecide_EnergyRetrieval_EyeOfTheStormDeck:
	ld a, CARD_LOCATION_DISCARD_PILE
	call CreateBasicEnergyCardListInLocation
	cp 2
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
	cp16 SWITCH
	jr z, .found_discard_card
	cp16 COMPUTER_SEARCH
	jr nz, .try_moon_stone
	ld de, COMPUTER_SEARCH
	call CheckIfHandHasRepeatedCard
	jr c, .found_discard_card
	jr .next_card
.try_moon_stone
	cp16 MOON_STONE
	jr nz, .try_potion
	ld de, PIDGEOT_LV40
	ld b, PLAY_AREA_ARENA
	farcall FindCardIDInTurnDuelistsPlayArea
	jr c, .found_discard_card
	ld de, FEAROW_LV27
	ld b, PLAY_AREA_ARENA
	farcall FindCardIDInTurnDuelistsPlayArea
	jr c, .found_discard_card
	ld de, PIDGEY_LV10
	ld b, PLAY_AREA_ARENA
	farcall FindCardIDInTurnDuelistsPlayArea
	jr c, .next_card
	ld de, PIDGEOTTO_LV38
	ld b, PLAY_AREA_ARENA
	farcall FindCardIDInTurnDuelistsPlayArea
	jr c, .next_card
	ld de, SPEAROW_LV12
	ld b, PLAY_AREA_ARENA
	farcall FindCardIDInTurnDuelistsPlayArea
	jr c, .next_card
	jr .found_discard_card
.try_potion
	cp16 POTION
	jr nz, .try_pkmn
	farcall CheckIfAnyPlayAreaPokemonHasDamage
	jr c, .next_card
	jr .found_discard_card
.try_pkmn
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	cp MAX_PLAY_AREA_POKEMON
	jr nz, .next_card
	push de
	ld b, PLAY_AREA_ARENA
	farcall FindCardIDInTurnDuelistsPlayArea
	pop de
	jr c, .found_discard_card
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

AIDecide_ItemFinder_SuddenGrowthDeck_TargetProfessorOak:
	ld de, NIGHTLY_GARBAGE_RUN
	farcall LookForCardIDInHandList
	jr c, .check_num_deck_cards

	ld de, NIGHTLY_GARBAGE_RUN
	farcall CountCardIDInDiscardPile
	cp 2
	ret c

.check_num_deck_cards
	; if has 24 or fewer deck cards remaining...
	ld a, DUELVARS_NUMBER_OF_CARDS_NOT_IN_DECK
	get_turn_duelist_var
	cp DECK_SIZE - 24
	jr c, .else
	; ...and any of the following Pokémon are in Play Area...
	ld de, DARK_DRAGONAIR
	ld b, PLAY_AREA_ARENA
	farcall FindCardIDInTurnDuelistsPlayArea
	jr c, .use_if_less_than_2_energies_in_hand
	ld de, DARK_DRAGONITE
	ld b, PLAY_AREA_ARENA
	farcall FindCardIDInTurnDuelistsPlayArea
	jr c, .use_if_less_than_2_energies_in_hand
	ld de, DARK_CLEFABLE
	ld b, PLAY_AREA_ARENA
	farcall FindCardIDInTurnDuelistsPlayArea
	jr nc, .else
.use_if_less_than_2_energies_in_hand
	; ...and has less than 2 energy cards in hand, use
	call CountEnergyCardsInHand
	cp 2
	ret

.else
	; if Dratini or Clefairy is in Hand or Play Area, don't use
	ld de, DRATINI_LV12
	call IsCardIDInHandOrPlayArea
	jr c, .no_carry
	ld de, CLEFAIRY_LV15
	call IsCardIDInHandOrPlayArea
	jr c, .no_carry

	; if any of the following cards are in hand, don't use
	ld de, DARK_DRAGONAIR
	farcall LookForCardIDInHandList
	jr c, .no_carry
	ld de, DARK_DRAGONITE
	farcall LookForCardIDInHandList
	jr c, .no_carry
	ld de, DARK_CLEFABLE
	farcall LookForCardIDInHandList
	jr c, .no_carry

	; otherwise use Professor Oak
	scf
	ret

.no_carry
	; don't use Professor Oak
	or a
	ret

AIDecide_ComputerSearch_SuddenGrowthDeck:
	ld de, PROFESSOR_OAK
	farcall LookForCardIDInHandList
	jr c, .check_bosss_way_in_hand

	call ColorlessAltarAIDecideProfessorOak
	ret nc

	ld a, DUELVARS_NUMBER_OF_CARDS_IN_HAND
	get_turn_duelist_var
	cp 3
	ccf
	ret nc

; target professor oak, bill
	ld de, PROFESSOR_OAK
	ld a, CARD_LOCATION_DECK
	farcall FindCardIDInLocation
	jr c, .find_discard_cards_any
	ld de, BILL
	ld a, CARD_LOCATION_DECK
	farcall FindCardIDInLocation
	ret nc

.find_discard_cards_any
	ld [wTempAISingleTargetCardDeckIndex_2], a
	call CreateHandCardList
	ld a, [wAITrainerCardToPlay]
	ld b, a
	ld c, 2
	ld hl, wDuelTempList
	ld de, wTempAIMultiTargetCardDeckIndex1
.loop_hand_cards
	ld a, [hli]
	cp b
	jr z, .loop_hand_cards
	ld [de], a
	inc de
	dec c
	jr nz, .loop_hand_cards
; success
	ld a, [wTempAISingleTargetCardDeckIndex_2]
	scf
	ret

.check_bosss_way_in_hand
	ld de, THE_BOSSS_WAY
	farcall LookForCardIDInHandList
	ccf
	ret nc

; target pkmn
	ld bc, DRATINI_LV12
	ld de, DARK_DRAGONAIR
	call LookForEvoCardInDeck_GivenPreevoInPlayArea
	jr c, .find_discard_cards_pkmn
	ld bc, CLEFAIRY_LV15
	ld de, DARK_CLEFABLE
	call LookForEvoCardInDeck_GivenPreevoInPlayArea
	ret nc

.find_discard_cards_pkmn
	ld [wTempAISingleTargetCardDeckIndex_2], a
	call CreateHandCardList
	ld hl, wDuelTempList
	ld d, AI_SEARCH_ONLY_PKMN
	ld e, 0
	call TakeOutDifferentCardOfSpecificTypeFromListInHL
	jr nc, .find_discard_cards_energy_1
	ld [wTempAIMultiTargetCardDeckIndex1], a
	call TakeOutDifferentCardOfSpecificTypeFromListInHL
	jr nc, .find_discard_cards_energy_2
	ld [wTempAIMultiTargetCardDeckIndex2], a
; success
	ld a, [wTempAISingleTargetCardDeckIndex_2]
	scf
	ret

.find_discard_cards_energy_1
	ld d, AI_SEARCH_ONLY_ENERGY
	ld e, 0
	call TakeOutDifferentCardOfSpecificTypeFromListInHL
	jr nc, .no_carry
	ld [wTempAIMultiTargetCardDeckIndex1], a

.find_discard_cards_energy_2
	ld d, AI_SEARCH_ONLY_ENERGY
	ld e, 0
	call TakeOutDifferentCardOfSpecificTypeFromListInHL
	jr nc, .no_carry
	ld [wTempAIMultiTargetCardDeckIndex2], a
; success
	ld a, [wTempAISingleTargetCardDeckIndex_2]
	scf
	ret

.no_carry
	or a
	ret

AIDecide_ItemFinder_SuddenGrowthDeck:
; target professor oak
	ld de, PROFESSOR_OAK
	ld a, CARD_LOCATION_DISCARD_PILE
	farcall FindCardIDInLocation
	jr nc, .count_deck_pile

	push af
	call AIDecide_ItemFinder_SuddenGrowthDeck_TargetProfessorOak
	pop bc
	ld a, b
	jr c, .find_discard_cards

.count_deck_pile
	ld a, DUELVARS_NUMBER_OF_CARDS_NOT_IN_DECK
	get_turn_duelist_var
	cp DECK_SIZE - 14
	ret nc

; target nightly garbage run
	ld de, NIGHTLY_GARBAGE_RUN
	ld a, CARD_LOCATION_DISCARD_PILE
	farcall FindCardIDInLocation
	ret nc

.find_discard_cards
	ld [wTempAISingleTargetCardDeckIndex_2], a
	call CreateHandCardList
	ld hl, wDuelTempList
	ld d, AI_SEARCH_ONLY_PKMN
	ld e, 0
	call TakeOutDifferentCardOfSpecificTypeFromListInHL
	jr nc, .no_carry
	ld [wTempAIMultiTargetCardDeckIndex1], a
	call TakeOutDifferentCardOfSpecificTypeFromListInHL
	jr nc, .no_carry
	ld [wTempAIMultiTargetCardDeckIndex2], a
; success
	ld a, [wTempAISingleTargetCardDeckIndex_2]
	scf
	ret

.no_carry
	or a
	ret

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

AIDecide_ReelIn_BadGuysDeck:
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
	add sp, $02 ; exit AIDecide_ReelIn_BadGuysDeck
	scf
	ret

; return carry if
;    (<= 6 cards in hand AND no energy there)
; OR (<= 4 cards in hand AND <= 2 energy there)
; a and b get clobbered
AIDecide_ProfessorOak_BadGuysDeck:
	ld a, DUELVARS_NUMBER_OF_CARDS_IN_HAND
	get_turn_duelist_var
	cp 7
	ret nc
	push af
	call CountEnergyCardsInHand
	jr nc, .has_energy
	pop af
	ret
.has_energy
	ld b, a
	pop af
	cp 5
	ret nc
	ld a, b
	cp 3
	ret

; return carry and output three selected cards to
; {a, wTempAIMultiTargetCardDeckIndex1, wTempAIMultiTargetCardDeckIndex2}
; if discard pile contains dark golduck, dark charmeleon, dark slowbro, and dark gloom,
; select {dark golduck, dark charmeleon, dark slowbro};
; elif discard pile contains >= 7 basic energy cards,
; select 3 of them;
; otherwise no carry
AIDecide_NightlyGarbageRun_BadGuysDeck:
; init
	ld a, $ff
	ld [wTempAIMultiTargetCardDeckIndex1], a
	ld [wTempAIMultiTargetCardDeckIndex2], a
	ld [wTempAIMultiTargetCardDeckIndex3], a

	ld a, CARD_LOCATION_DISCARD_PILE
	ld de, DARK_GOLDUCK
	farcall FindCardIDInLocation
	call c, .store_cards

	ld a, CARD_LOCATION_DISCARD_PILE
	ld de, DARK_CHARMELEON
	farcall FindCardIDInLocation
	call c, .store_cards

	ld a, CARD_LOCATION_DISCARD_PILE
	ld de, DARK_SLOWBRO
	farcall FindCardIDInLocation
	call c, .store_cards
	jr c, .shift

	ld a, CARD_LOCATION_DISCARD_PILE
	ld de, DARK_GLOOM
	farcall FindCardIDInLocation
	call c, .store_cards
	jr c, .shift

; re-init
	ld a, $ff
	ld [wTempAIMultiTargetCardDeckIndex1], a
	ld [wTempAIMultiTargetCardDeckIndex2], a
	ld [wTempAIMultiTargetCardDeckIndex3], a

	ld a, CARD_LOCATION_DISCARD_PILE
	call CreateBasicEnergyCardListInLocation
	cp 7
	ccf
	ret nc

; >= 7 basic energy cards in discard pile
	ld hl, wDuelTempList
.loop_basic_energy
	ld a, [hli]
	cp $ff
	jr z, .shift
	push hl
	call .store_cards
	pop hl
	jr nc, .loop_basic_energy

; shift {#1, #2, #3} to {a, #1, #2}
; no carry if selected <= 2 cards
.shift
	ld a, [wTempAIMultiTargetCardDeckIndex1]
	push af
	ld a, [wTempAIMultiTargetCardDeckIndex2]
	ld [wTempAIMultiTargetCardDeckIndex1], a
	ld a, [wTempAIMultiTargetCardDeckIndex3]
	ld [wTempAIMultiTargetCardDeckIndex2], a
	cp $ff
	jr z, .no_carry
; success
	pop af
	scf
	ret

.no_carry
	pop af
	or a
	ret

; a = deck index
; expectation: set carry when storing the third card
; reality: set carry when trying the fourth card
.store_cards
	ld b, a
	ld hl, wTempAIMultiTargetCardDeckIndex1
	ld a, $ff
	cp [hl]
	jr z, .store
	inc hl
	cp [hl]
	jr z, .store
	inc hl
	cp [hl]
	jr z, .store
	scf
	ret

.store
	ld [hl], b
	or a
	ret

AIDecide_EnergyRetrieval_BadGuysDeck_PickDiscardCard:
; try oak
	call AIDecide_ProfessorOak_BadGuysDeck
	jr c, .try_bill
	ld de, PROFESSOR_OAK
	farcall LookForCardIDInHandList
	ret c
.try_bill
	ld a, DUELVARS_NUMBER_OF_CARDS_NOT_IN_DECK
	get_turn_duelist_var
	cp DECK_SIZE - 11
	jr c, .try_pkmn
	ld de, BILL
	farcall LookForCardIDInHandList
	ret c
.try_pkmn
	call IsSameCardInHandAndPlayArea
	ret c
; try boss's way
	call AIDecide_TheBosssWay_BadGuysDeck
	jr nc, .try_energy_search
	ld de, THE_BOSSS_WAY
	farcall LookForCardIDInHandList
	ret c
.try_energy_search
	ld de, ENERGY_SEARCH
	farcall LookForCardIDInHandList
	ret

; return carry and deck index of hand card if
; the same card is found in both hand and own play area
IsSameCardInHandAndPlayArea:
	call CreateHandCardList
	ld hl, wDuelTempList
.loop_hand_cards
	ld a, [hl]
	cp $ff
	ret z
	push hl
	call GetCardIDFromDeckIndex
	ld b, PLAY_AREA_ARENA
	farcall FindCardIDInTurnDuelistsPlayArea
	pop hl
	jr c, .found
	inc hl
	jr .loop_hand_cards
.found
	ld a, [hl]
	scf
	ret

; check dark charmeleon, dark golduck, dark slowbro, or dark gloom
AIDecide_TheBosssWay_BadGuysDeck:
	ld bc, CHARMANDER_LV9
	ld de, DARK_CHARMELEON
	call LookForEvoCardInDeck_GivenPreevoInHandOrPlayArea
	ret c
	ld bc, PSYDUCK_LV16
	ld de, DARK_GOLDUCK
	call LookForEvoCardInDeck_GivenPreevoInHandOrPlayArea
	ret c
	ld bc, SLOWPOKE_LV16
	ld de, DARK_SLOWBRO
	call LookForEvoCardInDeck_GivenPreevoInHandOrPlayArea
	ret c
	ld bc, ODDISH_LV21
	ld de, DARK_GLOOM
	call LookForEvoCardInDeck_GivenPreevoInHandOrPlayArea
	ret

; check dark charmeleon, dark golduck, dark slowbro, or dark gloom
AIDecide_PokemonTraderForEvo_BadGuysDeck:
	ld de, CHARMANDER_LV9
	ld bc, DARK_CHARMELEON
	call LookForCardIDInDeck_GivenCardIDInHand
	ld de, DARK_CHARMELEON
	jr c, .find_trade_pkmn

	ld de, PSYDUCK_LV16
	ld bc, DARK_GOLDUCK
	call LookForCardIDInDeck_GivenCardIDInHand
	ld de, DARK_GOLDUCK
	jr c, .find_trade_pkmn

	ld de, SLOWPOKE_LV16
	ld bc, DARK_SLOWBRO
	call LookForCardIDInDeck_GivenCardIDInHand
	ld de, DARK_SLOWBRO
	jr c, .find_trade_pkmn

	ld de, ODDISH_LV21
	ld bc, DARK_GLOOM
	call LookForCardIDInDeck_GivenCardIDInHand
	ld de, DARK_GLOOM
	ret nc

.find_trade_pkmn
	ld [wTempAIMultiTargetCardDeckIndex1], a
	farcall FindDifferentPokemonCardInHand
	ret

AIDecide_PokemonTrader_PoisonMistDeck:
	ld de, DARK_MUK
	ld b, PLAY_AREA_ARENA
	farcall FindCardIDInTurnDuelistsPlayArea
	jr nc, .dark_muk_line ; no Dark Muk

	ld de, WEEZING_LV26
	ld b, PLAY_AREA_ARENA
	farcall FindCardIDInTurnDuelistsPlayArea
	jr nc, .weezing_line ; no Weezing

.dark_muk_line
	ld bc, GRIMER_LV10
	ld de, DARK_MUK
	call LookForEvoCardInDeck_GivenPreevoInHandOrPlayArea
	jr c, .find_trade_pkmn

	ld de, GRIMER_LV10
	ld bc, DARK_MUK
	call LookForCardIDInDeck_GivenCardIDInHand
	ld de, DARK_MUK
	jr c, .find_trade_pkmn
	ret

.weezing_line
	ld bc, KOFFING_LV14
	ld de, WEEZING_LV26
	call LookForEvoCardInDeck_GivenPreevoInHandOrPlayArea
	jr c, .find_trade_pkmn

	ld de, KOFFING_LV14
	ld bc, WEEZING_LV26
	call LookForCardIDInDeck_GivenCardIDInHand
	ld de, WEEZING_LV26
	jr c, .find_trade_pkmn
	ret

.find_trade_pkmn
	ld [wTempAIMultiTargetCardDeckIndex1], a
	farcall FindDifferentPokemonCardInHand
	ret

; checks if player has Bench cards and Arena card can retreat
; then checks if has Dark Muk in own Play Area
; if both are true, search player's Bench for card
; with at least 2 energy retreat cost
; return carry and its Play Area location if found
AIDecide_GustOfWind_PoisonMistDeck:
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

; return carry if
;    (golduck or blastoise in arena AND no energy in hand)
; OR no evolution cards in hand for her pkmn in play
AIDecide_ProfessorOak_UltraRemovalDeck:
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

AIDecide_PokemonTrader_UltraRemovalDeck:
	ld de, GOLDUCK_LV27
	ld b, PLAY_AREA_ARENA
	farcall FindCardIDInTurnDuelistsPlayArea
	jr c, .blastoise_line

; golduck line
	ld bc, PSYDUCK_LV15
	ld de, GOLDUCK_LV27
	call LookForEvoCardInDeck_GivenPreevoInHandOrPlayArea
	jr c, .find_trade_pkmn
	ld de, PSYDUCK_LV15
	ld bc, GOLDUCK_LV27
	call LookForCardIDInDeck_GivenCardIDInHand
	ld de, GOLDUCK_LV27
	jr c, .find_trade_pkmn
	ret

.blastoise_line
	ld bc, WARTORTLE_LV22
	ld de, BLASTOISE_LV52
	call LookForEvoCardInDeck_GivenPreevoInPlayArea
	ld de, WARTORTLE_LV22
	jr c, .find_trade_pkmn
	ld bc, SQUIRTLE_LV8
	ld de, WARTORTLE_LV22
	call LookForEvoCardInDeck_GivenPreevoInHandOrPlayArea
	jr c, .find_trade_pkmn
	ld de, SQUIRTLE_LV8
	ld bc, WARTORTLE_LV22
	call LookForCardIDInDeck_GivenCardIDInHand
	ld de, WARTORTLE_LV22
	jr c, .find_trade_pkmn
	ld de, WARTORTLE_LV22
	ld bc, BLASTOISE_LV52
	call LookForCardIDInDeck_GivenCardIDInHand
	ld de, BLASTOISE_LV52
	jr c, .find_trade_pkmn
	ret

.find_trade_pkmn
	ld [wTempAIMultiTargetCardDeckIndex1], a
	farcall FindDifferentPokemonCardInHand
	ret

AIDecide_GustOfWind_UltraRemovalDeck:
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
	jr c, .no_carry ; Hyper Beam not ready
	ld b, PLAY_AREA_BENCH_1
	call FindDoubleColorlessAttachedToPlayerPokemonInPlayArea
	ld a, b
	ret c ; found Double Colorless energy
	call SwapTurn
	ld e, PLAY_AREA_BENCH_1
	farcall Func_4a3dc
	call SwapTurn
	ret

AIDecide_Switch_UltraRemovalDeck:
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call GetCardIDFromDeckIndex
	cp16 BLASTOISE_LV52
	jr z, .blastoise_or_golduck
	cp16 GOLDUCK_LV27
	jr z, .blastoise_or_golduck

	; switch to a benched Golduck with at least 3 energies
	ld a, 3
	ld b, PLAY_AREA_BENCH_1
	ld de, GOLDUCK_LV27
	call FindTurnDuelistPokemonInPlayAreaWithEnoughEnergy
	ret

.blastoise_or_golduck
	ld a, SECOND_ATTACK
	ld [wSelectedAttack], a
	xor a
	ldh [hTempPlayAreaLocation_ff9d], a
	farcall CheckIfSelectedAttackIsUnusable
	jr c, .cannot_use_second_atk

	; can use second attack
	; use Switch only if statused
	ld a, DUELVARS_ARENA_CARD_STATUS
	get_turn_duelist_var
	or a
	ret z
	; statused
	farcall AIDecideBenchPokemonToSwitchTo
	ccf
	ret

.cannot_use_second_atk
	; stay in Arena if no other set up bench Pokémon
	farcall CountNumberOfSetUpBenchPokemon
	ret nc

	; otherwise try to use Switch
	farcall AIDecideBenchPokemonToSwitchTo
	ccf
	ret nc ; none found
	; only switch if score was more than 50
	push af
	ld a, 50
	cp e
	pop bc
	ld a, b
	ret

Func_3a887:
	bank1call GetArenaCardColor
	call TranslateColorToWR
	ld [wTempAICount2], a
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
	bank1call GetPlayAreaCardWeakness
	pop bc
	ld hl, wTempAICount2
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

AIDecide_Switch_PsychicBattleDeck:
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call GetCardIDFromDeckIndex
	cp16 MEWTWO_LV53
	jr nz, .not_mewtwo

	; use Switch on Mewtwo if defending card doesn't have energies
	call SwapTurn
	xor a ; PLAY_AREA_ARENA
	call CreateArenaOrBenchEnergyCardList
	call SwapTurn
	or a
	jr z, .switch

.not_mewtwo
	; use Switch if Arena card cannot use damaging attack
	; and there are any set up Benched Pokémon
	farcall CanArenaCardUseNonResidualAttack
	jr c, .else
	farcall CountNumberOfSetUpBenchPokemon
	jr c, .switch

.else
	; don't use Switch if not statused
	ld a, DUELVARS_ARENA_CARD_STATUS
	get_turn_duelist_var
	or a
	ret z

	; use Switch if retreat cost is 2 or more
	xor a
	ldh [hTempPlayAreaLocation_ff9d], a
	call GetPlayAreaCardRetreatCost
	cp 2
	jr nc, .switch
	; don't use if retreat cost is 0
	or a
	ret z
	; otherwise use if no energy cards in hand
	call CountEnergyCardsInHand
	ret nc
.switch
	farcall AIDecideBenchPokemonToSwitchTo
	ccf
	ret

; return carry and the deck index if found
SearchHandForEvoCardAlreadyInTurnDuelistPlayArea:
	call CreateHandCardList
	ld hl, wDuelTempList
.loop_hand_cards
	ld a, [hl]
	cp $ff
	ret z
	push hl
	call LoadCardDataToBuffer2_FromDeckIndex
	ld a, [wLoadedCard2Stage]
	or a ; cp BASIC
	jr z, .next_card
	ld a, [wLoadedCard2ID]
	ld e, a
	ld a, [wLoadedCard2ID + 1]
	ld d, a
	ld b, PLAY_AREA_ARENA
	farcall FindCardIDInTurnDuelistsPlayArea
	pop hl
	jr c, .found
	inc hl
	jr .loop_hand_cards
.next_card
	pop hl
	inc hl
	jr .loop_hand_cards

.found
	ld a, [hl]
	scf
	ret

; return a = b = number of Weezing family in own play area,
; set carry if KOing enough amount of Pokémon for player to win
; (c = (number of prizes for player to take) + 1)
AICountMassExplosion:
	lb bc, 0, 1
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	push hl
.loop_play_area
	pop hl
	ld a, [hli]
	cp $ff
	jr z, .check_prizes
	push hl
	ld [wTempAI], a
	push bc
	call GetCardIDFromDeckIndex
	pop bc
	cp16 KOFFING_LV12
	jr z, .check_remaining_hp
	cp16 KOFFING_LV13
	jr z, .check_remaining_hp
	cp16 KOFFING_LV14
	jr z, .check_remaining_hp
	cp16 WEEZING_LV26
	jr z, .check_remaining_hp
	cp16 WEEZING_LV27
	jr z, .check_remaining_hp
	cp16 DARK_WEEZING
	jr nz, .loop_play_area
.check_remaining_hp
	inc b
	ld a, [wTempAI]
	add DUELVARS_ARENA_CARD_HP
	get_turn_duelist_var
	cp 30
	jr nc, .loop_play_area
	inc c
	jr .loop_play_area

.check_prizes
	call SwapTurn
	call CountPrizes
	call SwapTurn
	cp c
	ld a, b
	ret

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
	bit B_PAD_UP, b
	jr z, .check_d_down
; d-up
	push af
	ld a, SFX_CURSOR
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
	bit B_PAD_DOWN, b
	jr z, .call_update_func
; d-down
	push af
	ld a, SFX_CURSOR
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
	ld a, MENU_CONFIRM
	farcall PlaySFXConfirmOrCancel
	ld a, [wCurScrollMenuItem]
	ld e, a
	ld a, [hCurMenuItem]
	scf
	ret

.null
	ldh a, [hKeysPressed]
	and PAD_A | PAD_B
	jr z, .play_menu_input_sfx
	and PAD_A
	jr nz, .asm_3ac12
; b button
	ld a, MENU_CANCEL
	ld [hCurMenuItem], a
	farcall PlaySFXConfirmOrCancel
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
	and CURSOR_BLINK_PERIOD_MASK
	ret nz

	ld a, [wMenuVisibleCursorTile]
	bit B_CURSOR_BLINK_PERIOD, [hl]
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

; HandleCheckMenuInput variant
Func_3ac82:
	xor a
	ld [wMenuInputSFX], a
	ld a, [wCheckMenuCursorXPosition]
	ld d, a

	ldh a, [hDPadHeld]
	or a
	jr z, .no_pad
	bit B_PAD_LEFT, a
	jr nz, .horizontal
	bit B_PAD_RIGHT, a
	jr z, .no_pad

; x coordinate
; incr if even, decr if odd
.horizontal
	ld a, d
	xor 1
	ld d, a
	jr .erase ; unnecessary jump
.erase
	ld a, SFX_CURSOR
	ld [wMenuInputSFX], a
	push de
	call .erase_cursor
	pop de

; update x
	ld a, d
	ld [wCheckMenuCursorXPosition], a

; reset blink
	xor a
	ld [wScrollMenuCursorBlinkCounter], a

.no_pad
	ldh a, [hKeysPressed]
	and PAD_A | PAD_B
	jr z, .no_input
	and PAD_A
	jr nz, .a_btn_pressed

; b btn pressed
	ld a, MENU_CANCEL
	farcall PlaySFXConfirmOrCancel
	scf
	ret

.a_btn_pressed
	call .display_cursor
	ld a, MENU_CONFIRM
	farcall PlaySFXConfirmOrCancel
	scf
	ret

.no_input
	ld a, [wMenuInputSFX]
	or a
	jr z, .check_blink
	call PlaySFX

.check_blink
	ld hl, wScrollMenuCursorBlinkCounter
	ld a, [hl]
	inc [hl]
	and CURSOR_BLINK_PERIOD_MASK
	ret nz

	ld a, SYM_CURSOR_R
	bit B_CURSOR_BLINK_PERIOD, [hl]
	jr z, .draw_cursor

; draw a space in the cursor position
.erase_cursor
	ld a, SYM_SPACE
; fallthrough

; for a = tile byte,
; draw it in the cursor position
; by converting the position to coordinates
.draw_cursor
	ld e, a
	ld a, 10
	ld l, a
	ld a, [wCheckMenuCursorXPosition]
	ld h, a
	call HtimesL
	ld a, l
	add 1
	ld b, a
	ld a, [wCheckMenuCursorYPosition]
	sla a
	add 14
	ld c, a

; b = 10x + 1, c = 2y + 14
	ld a, e
	call WriteByteToBGMap0
	or a
	ret

.display_cursor
	ld a, SYM_CURSOR_R
	jr .draw_cursor

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
	xor a ; FALSE
	ld [wUnableToScrollDown], a
	ld a, SYM_CURSOR_D
	jr .draw_down_arrow
.no_down_arrow
	ld a, TRUE
	ld [wUnableToScrollDown], a
	ld a, SYM_BOX_TOP
.draw_down_arrow
	lb bc, 18, 12
	call WriteByteToBGMap0
	ret

_HandleDeckSaveMachineMenu:
	xor a
	ld [wScrollMenuScrollOffset], a
	ldtx de, DeckSaveMachineText
	ld hl, wDeckMachineTitleText
	ld [hl], e
	inc hl
	ld [hl], d
	call ClearScreenAndDrawDeckMachineScreen
	ld a, NUM_DECK_SAVE_MACHINE_SLOTS
	ld [wNumDeckMachineEntries], a

	xor a
.wait_input
	ld hl, DeckMachineSelectionParams
	farcall InitializeScrollMenuParameters
	call DrawListScrollArrows
	call PrintNumSavedDecks
	ldtx hl, PleaseSelectDeckText
	call DrawWideTextBox_PrintText
	ldtx de, PleaseSelectDeckText
	call InitDeckMachineDrawingParams
	call HandleDeckMachineSelection
	jr c, .wait_input
	cp MENU_CANCEL
	ret z
; get deck index
	ld b, a
	ld a, [wScrollMenuScrollOffset]
	add b
	ld [wSelectedDeckMachineEntry], a

	farcall ResetCheckMenuCursorPositionAndBlink
	call DrawWideTextBox
	ld hl, .text_items
	call PlaceTextItems
.wait_input_submenu
	call DoFrame
	farcall HandleCheckMenuInput
	jp nc, .wait_input_submenu
	cp MENU_CANCEL
	jr nz, .submenu_option_selected
; return from submenu
	ld a, [wTempScrollMenuItem]
	jp .wait_input

.submenu_option_selected
	ld a, [wCheckMenuCursorYPosition]
	sla a
	ld hl, wCheckMenuCursorXPosition
	add [hl]
	or a
	jr nz, .next_submenu_1

; save
	call CheckIfSelectedDeckMachineEntryIsEmpty
	jr nc, .overwrite
	call SaveDeckInDeckSaveMachine
	ld a, [wTempScrollMenuItem]
	jp c, .wait_input
	jr .return_to_list

.overwrite
	ldtx hl, DeleteSavedDeckPromptText
	call YesOrNoMenuWithText
	ld a, [wTempScrollMenuItem]
	jr c, .wait_input
	call SaveDeckInDeckSaveMachine
	ld a, [wTempScrollMenuItem]
	jp c, .wait_input
	jr .return_to_list

.next_submenu_1
	cp DECKSAVEMACHINEMENU_DELETE
	jr nz, .next_submenu_2

; delete
	call CheckIfSelectedDeckMachineEntryIsEmpty
	jr c, .is_empty
	call TryDeleteSavedDeck
	ld a, [wTempScrollMenuItem]
	jp c, .wait_input
	jr .return_to_list

.is_empty
	ldtx hl, NoDecksSavedToMachineText
	call DrawWideTextBox_WaitForInput
	ld a, [wTempScrollMenuItem]
	jp .wait_input

.next_submenu_2
	cp DECKSAVEMACHINEMENU_BUILD
	jr nz, .cancel

; build
	call CheckIfSelectedDeckMachineEntryIsEmpty
	jr c, .is_empty
	call TryBuildDeckMachineDeck
	ld a, [wTempScrollMenuItem]
	jp nc, .wait_input

.return_to_list
	ld a, [wTempScrollMenuScrollOffset]
	ld [wScrollMenuScrollOffset], a
	call ClearScreenAndDrawDeckMachineScreen
	call DrawListScrollArrows
	call PrintNumSavedDecks
	ld a, [wTempScrollMenuItem]
	jp .wait_input

.cancel
	ret

.text_items
	textitem  2, 14, SaveDeckToMachineText     ; DECKSAVEMACHINEMENU_SAVE
	textitem 12, 14, DeleteDeckFromMachineText ; DECKSAVEMACHINEMENU_DELETE
	textitem  2, 16, BuildDeckText             ; DECKSAVEMACHINEMENU_BUILD
	textitem 12, 16, CancelDeckText            ; DECKSAVEMACHINEMENU_CANCEL
	textitems_end

; sets the number of cursor positions for deck machine menu,
; sets the text ID to show given by de
; and sets DrawDeckMachineScreen as the update function
; de = text ID
InitDeckMachineDrawingParams:
	ld a, NUM_DECK_MACHINE_VISIBLE_SLOTS
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
	and PAD_START
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
	call GetAndLoadSelectedMachineDeckPtr
	push hl
	farcall CheckIfDeckHasCards
	pop hl
	jr c, .start
	push hl
	ld bc, DECK_NAME_SIZE
	add hl, bc
	ld d, h
	ld e, l
	pop hl

; show deck confirmation screen with deck cards
; and return carry set
	ld a, MENU_CONFIRM
	farcall PlaySFXConfirmOrCancel
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
	cp PAD_RIGHT
	jr z, .d_right
	cp PAD_LEFT
	jr z, .d_left
	or a
	ret

.d_right
	ld a, [wScrollMenuScrollOffset]
	add NUM_DECK_MACHINE_VISIBLE_SLOTS
	ld b, a
	add NUM_DECK_MACHINE_VISIBLE_SLOTS
	ld hl, wNumDeckMachineEntries
	cp [hl]
	jr c, .got_new_pos
	ld a, [wNumDeckMachineEntries]
	sub NUM_DECK_MACHINE_VISIBLE_SLOTS
	ld b, a
	jr .got_new_pos

.d_left
	ld a, [wScrollMenuScrollOffset]
	sub NUM_DECK_MACHINE_VISIBLE_SLOTS
	ld b, a
	jr nc, .got_new_pos
	ld b, 0 ; first entry

.got_new_pos
	ld a, b
	ld [wScrollMenuScrollOffset], a
	cp c
	jr z, .set_carry

; play SFX on jump and update UI
	ld a, SFX_CURSOR
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
	call GetAndLoadSelectedMachineDeckPtr
	farcall CheckIfDeckHasCards
	ret

ClearScreenAndDrawDeckMachineScreen:
	xor a
	ld [wTileMapFill], a
	call ZeroObjectPositions
	call EmptyScreen
	ld a, TRUE
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

CopyListFromHLToDE_Bank0e:
.loop
	ld a, [hli]
	ld [de], a
	or a
	ret z
	inc de
	jr .loop

; return hl = wMachineDeckPtrs[a]
; if that points at wram (not at sram, etc.),
; also load its data to wSelectedMachineDeck and wBackup3DeckToBuild,
; and overwrite hl = wSelectedMachineDeck
GetAndLoadSelectedMachineDeckPtr:
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
	ld hl, wDeckToBuild
	ld de, wBackup3DeckToBuild
	ld b, DECK_TEMP_BUFFER_SIZE
	call CopyBBytesFromHLToDE_Bank0e
	pop hl
	ld de, wDeckToBuild
	ld b, DECK_TEMP_BUFFER_SIZE
	call CopyBBytesFromHLToDE_Bank0e

	call SwitchToWRAM1
	ld hl, wDeckToBuild
	ld de, wSelectedMachineDeck
	ld b, DECK_TEMP_BUFFER_SIZE
	call CopyBBytesFromHLToDE_Bank0e
	call SwitchToWRAM2
	ld hl, wBackup3DeckToBuild
	ld de, wDeckToBuild
	ld b, DECK_TEMP_BUFFER_SIZE
	call CopyBBytesFromHLToDE_Bank0e
	call SwitchToWRAM1
	ld hl, wSelectedMachineDeck
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
	ld b, NUM_DECK_MACHINE_VISIBLE_SLOTS
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

UpdateDeckMachineScrollArrowsAndEntries_TCG1:
	call DrawListScrollArrows
	jr PrintVisibleDeckMachineEntries

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

; update wScrollMenuScrollFunc to PrintVisibleAutoDeckMachineEntries
; and init wd119
UpdateAutoDeckSelectionMenuScroll:
	ld hl, PrintVisibleAutoDeckMachineEntries
	ld d, h
	ld a, l
	ld hl, wScrollMenuScrollFunc
	ld [hli], a
	ld [hl], d
	xor a
	ld [wd119], a
	ret

; variant of PrintVisibleDeckMachineEntries for Auto Deck Machine categories
PrintVisibleAutoDeckMachineEntries:
	lb de, 2, 2
	ld b, NUM_AUTO_DECK_MACHINE_SLOTS
	ld a, [wNumDeckMachineEntries]
	cp b
	jr nc, .got_offset
	ld b, a
.got_offset
	xor a
.loop
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
	jr .loop

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
	call GetAndLoadSelectedMachineDeckPtr
REPT 3 ; indent x
	inc d
ENDR
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
	ld hl, .spaces
	call ProcessText
	scf
	ret

; b = deck index
.valid_deck
	push de
	push bc

	ld a, 0 ; no decks dismantled
	call CheckIfCanBuildSavedDeck
	pop bc
	ld hl, wDefaultText
	jr c, .cannot_build

; can build
	xor a
	ld [wNumCardsNeededToBuildSelectedDeckUsedInBuiltDecks], a
	ld hl, wNumCardsNeededToBuildDeckMachineDecks
	ld d, $00
	ld e, b
	sla e ; *2
	add hl, de
	ld [hl], a
	ld [wNumCardsNeededToBuildSelectedDeckMissingInCardCollection], a
	ld hl, wNumCardsNeededToBuildDeckMachineDecks
	ld d, $00
	ld e, b
	sla e
	inc e ; *2 + 1
	add hl, de
	ld [hl], a
	ldfw de, "○" ; "can build" symbol
	jp .padding

.cannot_build
	ldfw de, " "
	call Func_22ca

; figure out how many cards are being used on the other decks
	push bc
	call CountCardsNeededToBuildInBuiltDecks
	ld [wNumCardsNeededToBuildSelectedDeckUsedInBuiltDecks], a
	pop bc
	ld hl, wNumCardsNeededToBuildDeckMachineDecks
	ld d, $00
	ld e, b
	sla e ; *2
	add hl, de
	ld [hl], a

	push bc
	ld a, $ff ; all owned cards
	call CountCardsNeededToBuildInCardCollection
	ld [wNumCardsNeededToBuildSelectedDeckMissingInCardCollection], a
	pop bc
	ld hl, wNumCardsNeededToBuildDeckMachineDecks
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
	ld hl, .spaces
	call ProcessText
	pop de
	pop af
	push de
	or a
	jr z, .need_dismantle ; can build by dismantling

; necessary cards missing in collection
	pop de
	push de
	inc e
	ld d, 16
	call InitTextPrinting
	ldfw de, "×" ; "missing" symbol
	call Func_22ca
	ld a, [wNumCardsNeededToBuildSelectedDeckMissingInCardCollection]
	ld hl, wDefaultText
	farcall ConvertToNumericalDigits
	ld [hl], TX_END
	ld hl, wDefaultText
	call ProcessText

; necessary cards used in built decks
.need_dismantle
	pop de
	ld a, [wNumCardsNeededToBuildSelectedDeckUsedInBuiltDecks]
	or a
	jr z, .printed_shortfall
	inc e
	ld d, 12
	call InitTextPrinting
	ldfw de, "※" ; REF_MARK, "used" symbol
	call Func_22ca
	ld a, [wNumCardsNeededToBuildSelectedDeckUsedInBuiltDecks]
	ld hl, wDefaultText
	farcall ConvertToNumericalDigits
	ld [hl], TX_END
	ld hl, wDefaultText
	call ProcessText

.printed_shortfall
	or a
	ret

; clear the card-shortfall text area
.padding
	call Func_22ca
	pop de
	ld d, 12
	inc e
	call InitTextPrinting
	ld hl, .spaces
	call ProcessText
	or a
	ret

.spaces
REPT 7
	db "<SPACE>"
ENDR
	done

; de = card ID
GetCardCountInScratchCardCollection:
	call SwitchToWRAM2
	push hl
	ld hl, wScratchCardCollection
	add hl, de
	ld a, [hl]
	pop hl
	call SwitchToWRAM1
	ret

; de = card ID
DecrementCardCountInScratchCardCollection:
	call SwitchToWRAM2
	push hl
	ld hl, wScratchCardCollection
	add hl, de
	dec [hl]
	pop hl
	call SwitchToWRAM1
	ret

; b = saved deck index
; return a = total number of cards required but already used in built decks
CountCardsNeededToBuildInBuiltDecks:
	push bc

; set:
;   wTempCardCollection    = all owned cards
;   wScratchCardCollection = all cards used in built decks
	ld a, CARD_COUNT_FROM_BUILT_DECKS
	farcall CreateCardCollectionListWithDeckCards
	call SwitchToWRAM2
	ld hl, wTempCardCollection
	ld de, wScratchCardCollection
	ld b, 0 ; aka $100 bytes
	call CopyBBytesFromHLToDE_Bank0e
	ld hl, wTempCardCollection + $100
	ld de, wScratchCardCollection + $100
	ld b, 0 ; aka $100 bytes
	call CopyBBytesFromHLToDE_Bank0e
	call SwitchToWRAM1
	xor a
	farcall CreateCardCollectionListWithDeckCards

	pop bc
	ld a, b
	call GetAndLoadSelectedMachineDeckPtr
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
	jr z, .got_count_already_in_use
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
	call GetCardCountInScratchCardCollection
	or a
	jr z, .next_card
	call DecrementCardCountInScratchCardCollection
	inc c
.next_card
	pop hl
	jr .loop_deck

.got_count_already_in_use
	ld a, c
	ret

; b = saved deck index
; return a = total number of cards required but missing
CountCardsNeededToBuildInCardCollection:
	push bc
	farcall CreateCardCollectionListWithDeckCards
	pop bc

	ld a, b
	call GetAndLoadSelectedMachineDeckPtr
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
	jr z, .got_count_missing
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
	jr z, .next_card_in_collection
	dec a
	ld [hl], a
	pop hl
	jr .loop_collection
.next_card_in_collection
	inc c
	pop hl
	jr .loop_collection

.got_count_missing
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

; unused in tcg1
PrintDeckIndexPerNumSavedDecks:
	ld a, [wCurScrollMenuItem]
	ld b, a
	ld a, [wScrollMenuScrollOffset]
	add b
	inc a
	ld hl, wDefaultText
	farcall ConvertToNumericalDigits
	ld a, TX_SYMBOL
	ld [hli], a
	ld a, SYM_SLASH
	ld [hli], a
	ld a, [wNumSavedDecks]
	farcall ConvertToNumericalDigits
	ld [hl], TX_END
	lb de, 14, 1
	call InitTextPrinting
	ld hl, wDefaultText
	call ProcessText
	ret

; for the selected slot (wSelectedDeckMachineEntry),
; handle decks screen menu to choose a deck to save there
; set carry if successfully saved
SaveDeckInDeckSaveMachine:
	ld a, ALL_DECKS
	farcall DrawDecksScreen
	xor a
.wait_input
	ld hl, DecksScreenMenuParams
	call InitializeMenuParameters
	ldtx hl, ChooseDeckToSaveToMachineText
	call DrawWideTextBox_PrintText
.wait_submenu_input
	call DoFrame
	farcall HandleStartButtonInDeckSelectionMenu
	jr c, .wait_input
	call HandleMenuInput
	jp nc, .wait_submenu_input
	ldh a, [hCurScrollMenuItem]
	cp MENU_CANCEL
	ret z
	ld [wCurDeck], a
	farcall CheckIfCurDeckIsEmpty
	jp nc, .SaveDeckInSelectedEntry ; can be jr
	farcall PrintThereIsNoDeckHereText
	ld a, [wCurDeck]
	jr .wait_input

; copy sDeckX (X = [wCurDeck]) data
; to sSavedDeckY (Y = [wSelectedDeckMachineEntry]),
; update screen ui, and set carry
.SaveDeckInSelectedEntry:
	farcall GetSRAMPointerToCurDeck
	push hl
	call GetSelectedSavedDeckPtr
	ld d, h
	ld e, l
	pop hl
	ld b, DECK_COMPRESSED_STRUCT_SIZE
	call EnableSRAM
	call CopyBBytesFromHLToDE_Bank0e
	call DisableSRAM

	call ClearScreenAndDrawDeckMachineScreen
	call DrawListScrollArrows
	call PrintNumSavedDecks
	ld a, [wTempScrollMenuItem]
	ld hl, DeckMachineSelectionParams
	farcall InitializeScrollMenuParameters
	call HandleScrollMenu.draw_visible_cursor
	farcall GetSRAMPointerToCurDeck
	call EnableSRAM
	farcall CopyDeckName
	call DisableSRAM
	xor a
	ld [wTxRam2], a
	ld [wTxRam2 + 1], a
	ldtx hl, SavedDeckToMachineText
	call DrawWideTextBox_WaitForInput
	scf
	ret

DecksScreenMenuParams:
	menu_params 1, 2, 3, NUM_DECKS, SYM_CURSOR_R, SYM_SPACE, NULL

GetSelectedSavedDeckPtr:
	push af
	push de
	ld a, [wSelectedDeckMachineEntry]
	call GetAndLoadSelectedMachineDeckPtr
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
	call GetAndLoadSelectedMachineDeckPtr
	ld bc, DECK_NAME_SIZE
	add hl, bc
	call CheckIfHasEnoughCardsToBuildDeck
	ret

SwitchToWRAM1:
	push af
	ld a, [wTempBankWRAM]
	cp BANK("WRAM1")
	jr z, .skip
	ld a, BANK("WRAM1")
	ld [wTempBankWRAM], a
	ldh [rWBK], a
.skip
	pop af
	ret

SwitchToWRAM2:
	push af
	ld a, [wTempBankWRAM]
	cp BANK("WRAM2")
	jr z, .skip
	ld a, BANK("WRAM2")
	ld [wTempBankWRAM], a
	ldh [rWBK], a
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

; return a = DECK_*_F of the first empty slot
; set carry otherwise
FindFirstEmptyDeckSlot:
	ld hl, sDeck1
	ld a, [hl]
	or a
	jr nz, .check_deck_2
	xor a ; DECK_1_F
	ret

.check_deck_2
	ld hl, sDeck2
	ld a, [hl]
	or a
	jr nz, .check_deck_3
	ld a, DECK_2_F
	ret

.check_deck_3
	ld hl, sDeck3
	ld a, [hl]
	or a
	jr nz, .check_deck_4
	ld a, DECK_3_F
	ret

.check_deck_4
	ld hl, sDeck4
	ld a, [hl]
	or a
	jr nz, .no_empty
	ld a, DECK_4_F
	ret

.no_empty
	scf
	ret

; for N = selected saved deck [wSelectedDeckMachineEntry],
; provide delete prompt
; if yes, clear sSavedDeckN
; if no, return a = menu item pos with carry
TryDeleteSavedDeck:
	ldtx hl, ConfirmDeletePromptText
	call YesOrNoMenuWithText
	jr c, .no
	call GetSelectedSavedDeckPtr
	push hl
	call EnableSRAM
	farcall CopyDeckName
	pop hl
	ld a, DECK_COMPRESSED_STRUCT_SIZE
	farcall ClearNBytesFromHL
	call DisableSRAM
	xor a
	ld [wTxRam2], a
	ld [wTxRam2 + 1], a
	ldtx hl, DeletedDeckFromMachineText
	call DrawWideTextBox_WaitForInput
	or a
	ret

.no
	ld a, [wCurScrollMenuItem]
	scf
	ret

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
	add NUM_DECK_MACHINE_VISIBLE_SLOTS + 1
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

; decks screen menu to make space for new deck to build
HandleDismantleDeckToMakeSpace:
	ldtx hl, YouMayOnlyCarry4DecksText
	call DrawWideTextBox_WaitForInput
	ld a, ALL_DECKS
	farcall DrawDecksScreen
	xor a
.init_menu_params
	ld hl, DecksScreenMenuParams
	call InitializeMenuParameters
	ldtx hl, ChooseDeckToDismantleText
	call DrawWideTextBox_PrintText
.loop_input
	call DoFrame
	farcall HandleStartButtonInDeckSelectionMenu
	jr c, .init_menu_params
	call HandleMenuInput
	jp nc, .loop_input ; can be jr
	ldh a, [hCurScrollMenuItem]
	cp MENU_CANCEL
	jr nz, .selected_deck
	scf
	ret

.selected_deck
	ld [wCurDeck], a
	ldtx hl, DeckBuildingDismantlePromptText
	call YesOrNoMenuWithText
	jr nc, .dismantle
	ld a, [wCurDeck]
	jr .init_menu_params

.dismantle
	farcall GetSRAMPointerToCurDeck
	push hl
	ld de, wDismantledDeckName
	call EnableSRAM
	call CopyListFromHLToDE_Bank0e
	pop hl
	push hl
	ld bc, DECK_NAME_SIZE
	add hl, bc
	farcall AddDeckToCollection
	pop hl
	ld a, DECK_COMPRESSED_STRUCT_SIZE
	farcall ClearNBytesFromHL
	call DisableSRAM

; redraw decks screen
	ld a, ALL_DECKS
	farcall DrawDecksScreen
	ld a, [wCurDeck]
	ld hl, DecksScreenMenuParams
	call InitializeMenuParameters
	call DrawCursor2
	ld hl, wDismantledDeckName
	farcall CopyDeckName
	xor a
	ld [wTxRam2], a
	ld [wTxRam2 + 1], a
	ldtx hl, DismantledThisDeckText
	call DrawWideTextBox_WaitForInput
	ld a, [wCurDeck]
	ret

TryBuildDeckMachineDeck:
	call SwitchToWRAM2
	xor a
	ld [wNumRemainingBasicEnergyCardsForSubbedDeck], a
	call SwitchToWRAM1
	ld a, [wSelectedDeckMachineEntry]
	ld hl, wNumCardsNeededToBuildDeckMachineDecks
	sla a ; *2
	ld b, $00
	ld c, a
	add hl, bc
	ld a, [hli]
	ld [wNumCardsNeededToBuildSelectedDeckUsedInBuiltDecks], a
	ld a, [hl]
	ld [wNumCardsNeededToBuildSelectedDeckMissingInCardCollection], a
	or a
	jr nz, .not_own_all_cards_needed
	ld a, [wNumCardsNeededToBuildSelectedDeckUsedInBuiltDecks]
	or a
	jr z, .build_deck

; can build by dismantling deck(s)
	ldtx hl, CannotBuildMustDismantleText
	call DrawWideTextBox_WaitForInput
	call ShowUsedCardListFromBuiltDecks
	call .DismantleDecksNeededToBuild
	jr nc, .build_deck
	call .TryBuildSubbedDeck
	jr nc, .build_deck
	ret

.not_own_all_cards_needed
	ldtx hl, YouDoNotOwnAllCardsNeededToBuildThisDeckText
	call DrawWideTextBox_WaitForInput
	call ShowMissingCardList
	ld a, [wNumCardsNeededToBuildSelectedDeckUsedInBuiltDecks]
	or a
	call nz, ShowUsedCardListFromBuiltDecks
	call .TryBuildSubbedDeck
	ret c
; fallthrough

.build_deck
	call EnableSRAM
	call FindFirstEmptyDeckSlot
	call DisableSRAM
	jr nc, .got_deck_slot
	call HandleDismantleDeckToMakeSpace
	jr nc, .got_deck_slot
	scf
	ret

.got_deck_slot
	ld [wDeckSlotForNewDeck], a
	ld a, [wSelectedDeckMachineEntry]
	call GetAndLoadSelectedMachineDeckPtr

; copy deck to buffer
	ld de, wDeckToBuild
	ld b, DECK_COMPRESSED_STRUCT_SIZE
	call EnableSRAM
	call CopyBBytesFromHLToDE_Bank0e

	call SwitchToWRAM2
	ld a, [wNumRemainingBasicEnergyCardsForSubbedDeck]
	or a
	call nz, SubInBasicEnergyInCurDeck

; remove needed cards from collection
	call SwitchToWRAM1
	ld hl, wDeckToBuild + DECK_NAME_SIZE
	farcall DecrementDeckCardsInCollection_CopyDeckFromSRAM

; copy deck cards from buffer to selected deck slot
	ld a, [wDeckSlotForNewDeck]
	ld l, a
	ld h, DECK_COMPRESSED_STRUCT_SIZE
	call HtimesL
	ld bc, sBuiltDecks
	add hl, bc
	ld d, h
	ld e, l
	ld hl, wDeckToBuild
	ld b, DECK_COMPRESSED_STRUCT_SIZE
	call CopyBBytesFromHLToDE_Bank0e
	call DisableSRAM

; draw decks screen
	ld a, ALL_DECKS
	farcall DrawDecksScreen
	ld a, [wDeckSlotForNewDeck]
	ld [wCurDeck], a
	ld hl, DecksScreenMenuParams
	call InitializeMenuParameters
	call DrawCursor2
	farcall GetSRAMPointerToCurDeck
	call EnableSRAM
	farcall CopyDeckName
	call DisableSRAM
	xor a
	ld [wTxRam2], a
	ld [wTxRam2 + 1], a
	ldtx hl, BuiltDeckText
	call DrawWideTextBox_WaitForInput
	call SwitchToWRAM2
	ld a, [wNumRemainingBasicEnergyCardsForSubbedDeck]
	or a
	call SwitchToWRAM1
	jr z, .done

; built subbed deck
	call SwitchToWRAM2
	ld hl, wBackup2DeckToBuild
	ld de, wDeckToBuild
	ld b, DECK_TEMP_BUFFER_SIZE
	call CopyBBytesFromHLToDE_Bank0e
	call SwitchToWRAM1
	ldtx bc, BuiltSubbedDeckWithTheseCardsText
	ld hl, wCardConfirmationText
	ld a, c
	ld [hli], a
	ld a, b
	ld [hl], a
	call GetSelectedSavedDeckPtr
	ld de, wDeckToBuild
	farcall HandleDeckStatusCardList_InSRAM

.done
	scf
	ret

.DismantleDecksNeededToBuild:
	call CheckWhichDecksToDismantleToBuildSavedDeck
	farcall DrawDecksScreen
	ldtx hl, DismantleTheseDecksPromptText
	call YesOrNoMenuWithText
	jr nc, .dismantle_yes
	ret
.dismantle_yes
	call EnableSRAM
; dismantle deck 1
	ld a, [wDecksToBeDismantled]
	bit DECK_1_F, a
	jr z, .dismantle_deck_2
	ld a, DECK_1_F
	call .DismantleDeck
.dismantle_deck_2
	ld a, [wDecksToBeDismantled]
	bit DECK_2_F, a
	jr z, .dismantle_deck_3
	ld a, DECK_2_F
	call .DismantleDeck
.dismantle_deck_3
	ld a, [wDecksToBeDismantled]
	bit DECK_3_F, a
	jr z, .dismantle_deck_4
	ld a, DECK_3_F
	call .DismantleDeck
.dismantle_deck_4
	ld a, [wDecksToBeDismantled]
	bit DECK_4_F, a
	jr z, .done_dismantling
	ld a, DECK_4_F
	call .DismantleDeck

.done_dismantling
	call DisableSRAM
	ld a, [wDecksToBeDismantled]
	farcall DrawDecksScreen
	ldtx hl, DismantledTheseDecksText
	call DrawWideTextBox_WaitForInput
	or a
	ret

; a = DECK_*_F
.DismantleDeck:
	ld l, a
	ld h, DECK_COMPRESSED_STRUCT_SIZE
	call HtimesL
	ld bc, sBuiltDecks
	add hl, bc
	push hl
	ld bc, DECK_NAME_SIZE
	add hl, bc
	farcall AddDeckToCollection
	pop hl
	ld a, DECK_COMPRESSED_STRUCT_SIZE
	farcall ClearNBytesFromHL
	ret

.TryBuildSubbedDeck:
	ldtx hl, MaySubInEnergyCardsToBuildThisDeckText
	call DrawWideTextBox_WaitForInput
	ldtx hl, BuildSubbedDeckPromptText
	call YesOrNoMenuWithText
	ret c

	ld a, [wNumCardsNeededToBuildSelectedDeckUsedInBuiltDecks]
	ld hl, wNumCardsNeededToBuildSelectedDeckMissingInCardCollection
	add [hl]
	cp MAX_NUM_SUB_ENERGY_CARDS + 1
	jr c, .check_basic_energy_to_sub_in
	ldtx hl, CannotBuildLackingTooManyCardsText
	call DrawWideTextBox_WaitForInput
	scf
	ret

.check_basic_energy_to_sub_in
	push af
	call OmitMissingCardsFromDeckAndBackup
	call GetSumOfRemainingBasicEnergyCards
	pop bc
	jr c, .check_basic_pkmn_before_sub ; has >= 256 energy cards
	cp b ; required sub count
	jr nc, .check_basic_pkmn_before_sub
	ldtx hl, CannotBuildLackingEnergyCardsText
	call DrawWideTextBox_WaitForInput
	scf
	ret

.check_basic_pkmn_before_sub
	call SwitchToWRAM2
	ld hl, wBackup1DeckToBuild
	ld de, wDeckToBuild
	ld b, DECK_TEMP_BUFFER_SIZE
	call CopyBBytesFromHLToDE_Bank0e
	call SwitchToWRAM1
	ld hl, wDeckToBuild
	ld de, wCurDeckCards
	ld b, DECK_TEMP_BUFFER_SIZE
	call CopyBBytesFromHLToDE_Bank0e
	farcall CheckIfThereAreAnyBasicCardsInDeck
	jr c, .prepare_sub
	ldtx hl, CannotBuildLackingBasicPokemonText
	call DrawWideTextBox_WaitForInput
	scf
	ret

.prepare_sub
	call SortRemainingBasicEnergyCardsDescending
	ret

; list available cards for the target deck
; and load them into wDeckToBuild and wBackup1DeckToBuild,
; skipping all missing cards
OmitMissingCardsFromDeckAndBackup:
	ld a, [wSelectedDeckMachineEntry]
	ld [wCurDeck], a
	call GetSelectedSavedDeckPtr
	ld de, DECK_NAME_SIZE
	add hl, de
	ld d, h
	ld e, l
	ld hl, wCurDeckCards
	farcall CopyDeckFromSRAM
	farcall SortCurDeckCardsByID
	farcall CreateCurDeckUniqueCardList

; set wTempCardCollection = all owned cards
	xor a
	farcall CreateCardCollectionListWithDeckCards

	ld hl, 0
.loop_deck_configuration
	push hl
	ld l, h
	ld h, 0
	ld de, wUniqueDeckCardList
	add hl, de
	ld e, [hl]
	inc hl
	ld d, [hl]
	pop hl
	inc h
	inc h
	call IsCardIDZero_Bank0e
	jr c, .got_list
	push bc
	push de
	push hl
	ld hl, wCurDeckCards
	call .GetCardCountAvailable
	pop hl
	pop de
	pop bc
	jr nc, .loop_deck_configuration

	ld c, a
.loop_append
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
	jr nz, .loop_append
	jr .loop_deck_configuration

.got_list
; append null terminator
	ld h, $00
	ld de, wTempCardList
	add hl, de
	xor a
	ld [hli], a
	ld [hl], a
; copy deck data
	ld hl, wTempCardList
	ld de, wDeckToBuild
	ld b, DECK_TEMP_BUFFER_SIZE
	call CopyBBytesFromHLToDE_Bank0e
	call SwitchToWRAM2
	ld hl, wDeckToBuild
	ld de, wBackup1DeckToBuild
	ld b, DECK_TEMP_BUFFER_SIZE
	call CopyBBytesFromHLToDE_Bank0e
	call SwitchToWRAM1
	ret

; hl = deck cards (wCurDeckCards)
; de = card id
; if owned count > 0, return a = min( (required count), (owned count) ) with carry
; if owned count = 0, return a = 0 (nc)
.GetCardCountAvailable:
	call GetCardCountFromDeck
	ld hl, wTempCardCollection ; all owned cards
	add hl, de
	ld a, [hl]
	and CARD_COUNT_MASK
	or a
	ret z

	cp b
	jr nc, .enough
; not enough but nonzero
	scf
	ret
.enough
	ld a, b
	scf
	ret

; for x[t] = {basic energy cards remaining after building wBackup1DeckToBuild},
; calc sum(x) from grass to psychic with overflow check:
; if sum(x[0..k]) > 255 at t = k, return
;   a = sum(x[0..k]) % 256 (with carry),
;   b = sum(x[0..k-1])
; otherwise return a = b = sum(x)
GetSumOfRemainingBasicEnergyCards:
; set wTempCardCollection = all owned cards
	xor a
	farcall CreateCardCollectionListWithDeckCards

	call SwitchToWRAM2
	ld hl, wBackup1DeckToBuild
.loop_deck_cards
	ld e, [hl]
	inc hl
	ld d, [hl]
	inc hl
	call IsCardIDZero_Bank0e
	jr c, .load_count
	push hl
	ld hl, wTempCardCollection
	add hl, de
	ld a, [hl]
	and CARD_COUNT_MASK
	jr z, .next_card
	dec [hl]
.next_card
	pop hl
	jr .loop_deck_cards

.load_count
	ld hl, wTempCardCollection + GRASS_ENERGY
	ld de, wNumRemainingBasicEnergyCardsForSubbedDeck
	ld b, NUM_COLORED_TYPES
	call CopyBBytesFromHLToDE_Bank0e

	ld hl, wNumRemainingBasicEnergyCardsForSubbedDeck
	lb bc, 0, NUM_COLORED_TYPES
.loop_sum
	ld a, [hli]
	add b
	jr c, .done
	ld b, a
	dec c
	jr nz, .loop_sum
	ld b, a
	or a
.done
	call SwitchToWRAM1
	ret

; sort wNumRemainingBasicEnergyCardsForSubbedDeck in descending order
; and map its index array to wIndicesRemainingBasicEnergyCardsForSubbedDeck
SortRemainingBasicEnergyCardsDescending:
	call SwitchToWRAM2
	ld a, $ff
	ld [wNumRemainingBasicEnergyCardsForSubbedDeck + NUM_COLORED_TYPES], a
	xor a
	ld hl, wIndicesRemainingBasicEnergyCardsForSubbedDeck
	ld [hli], a ; GRASS_ENERGY - GRASS_ENERGY
	inc a
	ld [hli], a ; FIRE_ENERGY - GRASS_ENERGY
	inc a
	ld [hli], a ; WATER_ENERGY - GRASS_ENERGY
	inc a
	ld [hli], a ; LIGHTNING_ENERGY - GRASS_ENERGY
	inc a
	ld [hli], a ; FIGHTING_ENERGY - GRASS_ENERGY
	inc a
	ld [hl], a  ; PSYCHIC_ENERGY - GRASS_ENERGY

	ld de, 0
.loop_swap
	ld hl, wNumRemainingBasicEnergyCardsForSubbedDeck
	add hl, de
	call .GetMaxNumAndIndex
	ld a, e
	add c
	ld c, a
	ld hl, wNumRemainingBasicEnergyCardsForSubbedDeck
	add hl, de
	ld a, [hl]
	ld [hl], b
	ld b, 0
	ld hl, wNumRemainingBasicEnergyCardsForSubbedDeck
	add hl, bc
	ld [hl], a
	ld hl, wIndicesRemainingBasicEnergyCardsForSubbedDeck
	add hl, de
	ld a, [hl]
	push hl
	ld hl, wIndicesRemainingBasicEnergyCardsForSubbedDeck
	add hl, bc
	ld c, [hl]
	ld [hl], a
	pop hl
	ld [hl], c
	inc e
	ld a, NUM_COLORED_TYPES
	cp e
	jr nz, .loop_swap
	call SwitchToWRAM1
	ret

; from the current index and onwards,
; return b = max count, c = energy index of max count
.GetMaxNumAndIndex:
	push de
	ld e, 0
	lb bc, 0, 0
.loop_energy
	ld a, [hli]
	cp $ff
	jr z, .got_max
	and CARD_COUNT_MASK
	cp b
	jr c, .next_energy
	ld b, a
	ld e, c
.next_energy
	inc c
	jr .loop_energy
.got_max
	ld c, e
	pop de
	ret

; fill in missing card slots in the deck with remaining basic energy cards
; (already guaranteed of enough amount of replacements at this point),
; starting with the type of the most remaining
; bug:
; in the first iteration, skip type(s) of
; ( (*_ENERGY used in the deck) + 1)
; e.g.
;  when the deck misses 9 cards
;  and the remaining energy count is 50 fighting, 40 grass, 30 fire, …,
;  if the deck has any lightning (LIGHTNING_ENERGY + 1 = FIGHTING_ENERGY),
;  sub in 9 grass
;  otherwise sub in 9 fighting
SubInBasicEnergyInCurDeck:
	call SwitchToWRAM2
	ld hl, wDeckToBuild
	ld de, wBigBackupDeckToBuild
	ld b, 0 ; aka $100 bytes
	call CopyBBytesFromHLToDE_Bank0e
	call SwitchToWRAM1
	call OmitMissingCardsFromDeckAndBackup
	call GetSumOfRemainingBasicEnergyCards
	call SortRemainingBasicEnergyCardsDescending
	call SwitchToWRAM2
	ld hl, wBigBackupDeckToBuild
	ld de, wDeckToBuild
	ld b, 0 ; aka $100 bytes
	call CopyBBytesFromHLToDE_Bank0e

; decompress wDeckToBuild deck config
	call SwitchToWRAM1
	ld de, wDeckToBuild + DECK_NAME_SIZE
	ld hl, wTempSavedDeckCards
	farcall CopyDeckFromSRAM
	ld hl, wTempSavedDeckCards
	ld de, wDeckToBuild + DECK_NAME_SIZE
	ld b, DECK_TEMP_BUFFER_SIZE
	call CopyBBytesFromHLToDE_Bank0e

; copy wBackup1DeckToBuild (missing cards omitted) to wScratchCardCollection
; set b = card count
	call SwitchToWRAM2
	ld a, DECK_TEMP_BUFFER_SIZE
	ld hl, wScratchCardCollection
	farcall ClearNBytesFromHL
	ld b, 0
	ld de, wBackup1DeckToBuild
.loop_copy_and_count
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
	call IsCardIDZero_Bank0e
	pop de
	jr nc, .loop_copy_and_count
	dec b
	dec hl
	dec hl

	push hl
	ld a, $ff
	ld [wIndicesRemainingBasicEnergyCardsForSubbedDeck + NUM_COLORED_TYPES], a

; first iteration
; bug: skip all *_ENERGY of ( (*_ENERGY used in the deck) + 1)
	ld de, 0
.loop_energy
	push hl
	ld hl, wIndicesRemainingBasicEnergyCardsForSubbedDeck
	add hl, de
	ld a, [hl]
	cp $ff
	jr z, .second_iteration
	call .CheckEnergyInDeck
	pop hl
	jr c, .next_energy
	call .SubInCurBasicEnergy
	jr c, .list_energy
.next_energy
	inc e
	jr .loop_energy

; ensure completion, with no skip logic
.second_iteration
	pop hl
	ld de, 0
.loop_energy_2
	push hl
	ld hl, wIndicesRemainingBasicEnergyCardsForSubbedDeck
	add hl, de
	ld a, [hl]
	cp $ff
	pop hl
	jr z, .list_energy
	call .SubInCurBasicEnergy
	jr c, .list_energy
	inc e
	jr .loop_energy_2

; list all energy subs at wBackup2DeckToBuild to display it later
.list_energy
	ld a, DECK_TEMP_BUFFER_SIZE
	ld hl, wBackup2DeckToBuild
	farcall ClearNBytesFromHL
	pop hl
	ld bc, wBackup2DeckToBuild
.loop_list
	ld a, [hli]
	ld [bc], a
	inc bc
	ld e, a
	ld a, [hli]
	ld [bc], a
	inc bc
	ld d, a
	call IsCardIDZero_Bank0e
	jr nc, .loop_list

; save result
	ld hl, wDeckToBuild + DECK_NAME_SIZE
	ld de, wScratchCardCollection
	bank1call SaveDeckCards
	call SwitchToWRAM1
	ret

; a = basic energy index [0, 5]
; bug: set carry if wDeckToBuild contains a card of id = a
; *_ENERGY card id is [1, 6], which is a mismatch
.CheckEnergyInDeck:
	push de
	ld hl, wDeckToBuild + DECK_NAME_SIZE
.loop_deck_cards
	ld e, [hl]
	inc hl
	ld d, [hl]
	inc hl
	call IsCardIDZero_Bank0e
	ccf
	jr nc, .checked_deck_cards
	cp e
	jr nz, .loop_deck_cards
	ld e, a
	ld a, d
	or a
	ld a, e
	jr nz, .loop_deck_cards
	scf
.checked_deck_cards
	pop de
	ret

; append current basic energy (e = offset)
; to the end of card list (wScratchCardCollection)
; if the deck is completed, set carry
; and overwrite the index in wIndicesRemainingBasicEnergyCardsForSubbedDeck
; with the final remaining count (!?)
.SubInCurBasicEnergy:
	push hl
	ld hl, wNumRemainingBasicEnergyCardsForSubbedDeck
	add hl, de
	ld a, [hl]
	and CARD_COUNT_MASK
	jr z, .exit_append
	ld c, a
	pop hl
	push de
	push hl
	ld hl, wIndicesRemainingBasicEnergyCardsForSubbedDeck
	add hl, de
	ld e, [hl]
	inc e ; convert index to *_ENERGY card id
	ld d, $00
	pop hl
.loop_append
	ld [hl], e
	inc hl
	ld [hl], d
	inc hl
	inc b
	dec c
	jr z, .depleted
	ld a, DECK_SIZE
	cp b
	jr z, .done_append
	jr .loop_append

.depleted
	ld a, DECK_SIZE
	cp b
	jr z, .done_append
	pop de
	push hl
	ld hl, wNumRemainingBasicEnergyCardsForSubbedDeck
	add hl, de
	xor a
	ld [hl], a
.exit_append
	pop hl
	or a
	ret

.done_append
	xor a
	ld [hli], a
	ld [hl], a
	pop de
	push hl
	ld hl, wIndicesRemainingBasicEnergyCardsForSubbedDeck
	add hl, de
	ld [hl], c
	pop hl
	scf
	ret

; return carry if de (card ID) = 0
IsCardIDZero_Bank0e:
	push af
	xor a
	cp d
	jr nz, .false
	cp e
	jr nz, .false
	pop af
	scf
	ret
.false
	pop af
	or a
	ret

ShowMissingCardList:
	ld a, [wSelectedDeckMachineEntry]
	ld [wCurDeck], a
	call GetSelectedSavedDeckPtr
	ld de, DECK_NAME_SIZE
	add hl, de
	ld d, h
	ld e, l
	ld hl, wCurDeckCards
	farcall CopyDeckFromSRAM
	farcall SortCurDeckCardsByID
	farcall CreateCurDeckUniqueCardList

; set wTempCardCollection = all owned cards
	ld a, $ff
	farcall CreateCardCollectionListWithDeckCards

	ld hl, 0
.loop_deck_configuration
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
	call IsCardIDZero_Bank0e
	jr c, .got_list
	push bc
	push de
	push hl
	ld hl, wCurDeckCards
	call .GetCardCountMissing
	pop hl
	pop de
	pop bc
	jr nc, .loop_deck_configuration

; list at wTempCardList cards missing
	ld c, a
.loop_append
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
	jr nz, .loop_append
	jr .loop_deck_configuration

.got_list
; append null terminator
	ld h, $00
	ld de, wTempCardList
	add hl, de
	xor a
	ld [hli], a
	ld [hl], a
; display list
	ldtx bc, LackTheseCardsToBuildThisDeckText
	ld hl, wCardConfirmationText
	ld a, c
	ld [hli], a
	ld a, b
	ld [hl], a
	call GetSelectedSavedDeckPtr
	ld de, wTempCardList
	farcall HandleDeckStatusCardList_InSRAM
	ret

; hl = deck cards (wCurDeckCards)
; de = card id
; if (required count) > (owned count), return a = (shortage count) with carry
; otherwise clear carry
.GetCardCountMissing:
	call GetCardCountFromDeck
	ld hl, wTempCardCollection ; all owned cards
	add hl, de
	ld a, [hl]
	and CARD_COUNT_MASK
	cp b
	jr c, .not_enough
; enough
	or a
	ret
.not_enough
	ld e, a
	ld a, b
	sub e
	scf
	ret

; hl = deck cards (wCurDeckCards)
; de = card id
; return b = count of the card in hl
GetCardCountFromDeck:
	push de
	ld b, 0
.loop_list
	push de
	ld e, [hl]
	inc hl
	ld d, [hl]
	inc hl
	call IsCardIDZero_Bank0e
	ld a, e
	ld c, d
	pop de
	jr c, .done
	cp e
	jr nz, .loop_list
	ld a, c
	cp d
	jr nz, .loop_list
	inc b
	jr .loop_list
.done
	pop de
	ret

ShowUsedCardListFromBuiltDecks:
	ld a, [wSelectedDeckMachineEntry]
	ld [wCurDeck], a
	call GetSelectedSavedDeckPtr
	ld de, DECK_NAME_SIZE
	add hl, de
	ld d, h
	ld e, l
	ld hl, wCurDeckCards
	farcall CopyDeckFromSRAM
	farcall SortCurDeckCardsByID
	farcall CreateCurDeckUniqueCardList

; set:
;   wTempCardCollection    = all cards used in built decks
;   wScratchCardCollection = all owned cards
	xor a
	farcall CreateCardCollectionListWithDeckCards
	call SwitchToWRAM2
	ld hl, wTempCardCollection
	ld de, wScratchCardCollection
	ld b, 0 ; aka $100 bytes
	call CopyBBytesFromHLToDE_Bank0e
	ld hl, wTempCardCollection + $100
	ld de, wScratchCardCollection + $100
	ld b, 0 ; aka $100 bytes
	call CopyBBytesFromHLToDE_Bank0e
	call SwitchToWRAM1
	ld a, CARD_COUNT_FROM_BUILT_DECKS
	farcall CreateCardCollectionListWithDeckCards

	ld hl, 0
.loop_deck_configuration
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
	call IsCardIDZero_Bank0e
	jr c, .got_list
	push bc
	push de
	push hl
	ld hl, wCurDeckCards
	call .GetCardCountNeededToTakeFromBuiltDecks
	pop hl
	pop de
	pop bc
	jr nc, .loop_deck_configuration

; list at wTempCardList cards needed from built decks
	ld c, a
.loop_append
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
	jr nz, .loop_append
	jr .loop_deck_configuration

.got_list
; append null terminator
	ld h, $00
	ld de, wTempCardList
	add hl, de
	xor a
	ld [hli], a
	ld [hl], a
; set up text
	ld a, [wNumCardsNeededToBuildSelectedDeckMissingInCardCollection]
	or a
	jr nz, .also_not_enough_in_card_collection
	ldtx bc, UsingTheseCardsInOtherDecksText
	jr .display_list
.also_not_enough_in_card_collection
	ldtx bc, UsingTheseCardsTooInOtherDecksText
.display_list
	ld hl, wCardConfirmationText
	ld a, c
	ld [hli], a
	ld a, b
	ld [hl], a
	call GetSelectedSavedDeckPtr
	ld de, wTempCardList
	farcall HandleDeckStatusCardList_InSRAM
	ret

; hl = deck cards (wCurDeckCards)
; de = card id
; if that card isn't enough and is used in built decks,
; return a = min( (card count used in built decks), (shortage count) ) with carry
; otherwise clear carry
.GetCardCountNeededToTakeFromBuiltDecks:
	call GetCardCountFromDeck
	call GetCardCountInScratchCardCollection
	ld c, a
	ld a, b
	sub c
; a = (shortage count) = (card count needed) - (owned count)
	jr z, .no_cards_to_take
	jr c, .no_cards_to_take
; not enough, check built decks
	ld b, a
	ld hl, wTempCardCollection ; all cards used in built decks
	add hl, de
	ld a, [hl]
	and CARD_COUNT_MASK
	jr z, .no_cards_to_take
	cp b
	jr c, .got_count_to_take
	ld a, b
.got_count_to_take
	scf
	ret
.no_cards_to_take
	or a ; clear carry
	ret

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
	cp MENU_CANCEL
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

_HandleAutoDeckSelectionMenu:
	ld a, [wAutoDeckMachineIndex]
	or a
	jr nz, .machine_2
; machine 1
	ld hl, .machine_1_category_titles
	jr .launch
.machine_2
	ld hl, .machine_2_category_titles
.launch
	ld a, [wSelectedAutoDeckMachineCategory]
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
	call .InitAutoDeckMenu
	xor a

.please_select_deck
	ld hl, AutoDeckMachineDeckSelectionParams
	farcall InitializeScrollMenuParameters
	ldtx hl, PleaseSelectDeckText
	call DrawWideTextBox_PrintText
	ld a, [wNumDeckMachineEntries]
	ld [wNumMenuItems], a
	ld a, TRUE
	ld [wUnableToScrollDown], a
	xor a
	ld [wd119], a
	call UpdateAutoDeckSelectionMenuScroll

.wait_input
	call DoFrame
	call HandleScrollMenu
	jr c, .selected_deck

; start btn to show full deck list
	ldh a, [hDPadHeld]
	and PAD_START
	jr z, .wait_input
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
	ld a, c
	call GetAndLoadSelectedMachineDeckPtr
; validity check just in case
	push hl
	farcall CheckIfDeckHasCards
	pop hl
	jr c, .wait_input
; show full deck list
	push hl
	ld bc, DECK_NAME_SIZE
	add hl, bc
	ld d, h
	ld e, l
	pop hl
	ld a, MENU_CONFIRM
	farcall PlaySFXConfirmOrCancel
	farcall OpenDeckConfirmationMenu
	ld a, [wTempScrollMenuScrollOffset]
	ld [wScrollMenuScrollOffset], a
	call .InitAutoDeckMenu
	ld a, [wTempScrollMenuItem]
	ld [wCurScrollMenuItem], a
	jp .please_select_deck

.selected_deck
	call HandleScrollMenu.draw_visible_cursor
	ld a, [wScrollMenuScrollOffset]
	ld [wTempScrollMenuScrollOffset], a
	ld a, [wCurScrollMenuItem]
	ld [wTempScrollMenuItem], a
	ld a, [hCurMenuItem]
	cp MENU_CANCEL
	jp z, .exit

	ld b, a
	ld a, [wScrollMenuScrollOffset]
	add b
	ld [wSelectedDeckMachineEntry], a
	farcall ResetCheckMenuCursorPositionAndBlink
	xor a
	ld [wd0cd], a
	call DrawWideTextBox
	ld hl, .deck_options
	call PlaceTextItems
.wait_submenu_input
	call DoFrame
	farcall HandleCheckMenuInput_YourOrOppPlayArea
	jp nc, .wait_submenu_input
	cp MENU_CANCEL
	jr nz, .selected_submenu
	ld a, [wTempScrollMenuItem]
	jp .please_select_deck

.selected_submenu
	ld a, [wCheckMenuCursorYPosition]
	sla a
	ld hl, wCheckMenuCursorXPosition
	add [hl]
	or a
	jr nz, .next_submenu

; AUTODECKMACHINEMENU_BUILD
	call TryBuildDeckMachineDeck
	ld a, [wTempScrollMenuItem]
	jp nc, .please_select_deck
	ld a, [wTempScrollMenuScrollOffset]
	ld [wScrollMenuScrollOffset], a
	call .InitAutoDeckMenu
	ld a, [wTempScrollMenuItem]
	jp .please_select_deck

.next_submenu
	cp AUTODECKMACHINEMENU_CANCEL
	jr nz, .read_instructions

.exit
	ret

; AUTODECKMACHINEMENU_READ
.read_instructions
	ld a, [wScrollMenuScrollOffset]
	ld [wTempScrollMenuScrollOffset], a
	ld b, a
	ld a, [wCurScrollMenuItem]
	ld [wTempScrollMenuItem], a
	add b
	ld c, a
	ld [wCurDeck], a
	push af
	sla c
	ld b, $00
	ld hl, wAutoDeckMachineTexts
	add hl, bc
; set description text
	ld bc, wCardConfirmationText
	ld a, [hli]
	ld [bc], a
	inc bc
	ld a, [hl]
	ld [bc], a
	pop af
	call GetAndLoadSelectedMachineDeckPtr
; validity check just in case
	push hl
	farcall CheckIfDeckHasCards
	pop hl
	jp c, .wait_input
; show instructions (card list + description)
	ld a, MENU_CONFIRM
	farcall PlaySFXConfirmOrCancel
	push hl
	ld de, DECK_NAME_SIZE
	add hl, de
	ld d, h
	ld e, l
	pop hl
	farcall HandleDeckStatusCardList
	ld a, [wTempScrollMenuScrollOffset]
	ld [wScrollMenuScrollOffset], a
	call .InitAutoDeckMenu
	ld a, [wTempScrollMenuItem]
	jp .please_select_deck

.deck_options
	textitem  2, 14, BuildDeckText
	textitem 12, 14, CancelDeckText
	textitem  2, 16, DeckMachineReadInstructionsText
	textitems_end

; category titles for header, so no padding
.machine_1_category_titles
	tx AutoDeckMachine1BasicDecksText
	tx AutoDeckMachine1GivenDecksText
	tx AutoDeckMachine1FightingDecksText
	tx AutoDeckMachine1GrassDecksText
	tx AutoDeckMachine1WaterDecksText
	tx AutoDeckMachine1FireDecksText
	tx AutoDeckMachine1LightningDecksText
	tx AutoDeckMachine1PsychicDecksText
	tx AutoDeckMachine1SpecialDecksText
	tx AutoDeckMachine1LegendaryDecksText

.machine_2_category_titles
	tx AutoDeckMachine2DarkGrassDecksText
	tx AutoDeckMachine2DarkLightningDecksText
	tx AutoDeckMachine2DarkWaterDecksText
	tx AutoDeckMachine2DarkFireDecksText
	tx AutoDeckMachine2DarkFightingDecksText
	tx AutoDeckMachine2DarkPsychicDecksText
	tx AutoDeckMachine2ColorlessDecksText
	tx AutoDeckMachine2DarkSpecialDecksText
	tx AutoDeckMachine2RareCardDecksText
	tx AutoDeckMachine2MysteriousCardDecksText

.InitAutoDeckMenu:
	xor a
	ld [wTileMapFill], a
	call ZeroObjectPositions
	call EmptyScreen
	ld a, TRUE
	ld [wVBlankOAMCopyToggle], a
	call LoadSymbolsFont
	call LoadDuelCardSymbolTiles
	bank1call SetDefaultPalettes
	lb de, $3c, $ff
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
	farcall ReadAutoDeckConfiguration
	call CreateAutoDeckPointerList
	call PrintVisibleAutoDeckMachineEntries
	call EnableLCD
	ret

; to build wSelectedDeckMachineEntry,
; try out all combinations of dismantling decks
; if none of the combinations work, return carry set
; otherwise, return a = DECK_* flags to be dismantled
; and load it to wDecksToBeDismantled
CheckWhichDecksToDismantleToBuildSavedDeck:
	xor a
	ld [wDecksToBeDismantled], a

; single deck
	ld a, DECK_1
.loop_single_built_decks
	call .CheckIfCanBuild
	ret nc
	sla a ; next deck
	cp 1 << NUM_DECKS
	jr nz, .loop_single_built_decks

; two-deck combinations
	ld a, DECK_1 | DECK_2
	call .CheckIfCanBuild
	ret nc
	ld a, DECK_1 | DECK_3
	call .CheckIfCanBuild
	ret nc
	ld a, DECK_1 | DECK_4
	call .CheckIfCanBuild
	ret nc
	ld a, DECK_2 | DECK_3
	call .CheckIfCanBuild
	ret nc
	ld a, DECK_2 | DECK_4
	call .CheckIfCanBuild
	ret nc
	ld a, DECK_3 | DECK_4
	call .CheckIfCanBuild
	ret nc
; three-deck combinations
	ld a, DECK_1 | DECK_2 | DECK_3
	call .CheckIfCanBuild
	ret nc
	ld a, DECK_1 | DECK_2 | DECK_4
	call .CheckIfCanBuild
	ret nc
	ld a, DECK_1 | DECK_3 | DECK_4
	call .CheckIfCanBuild
	ret nc
	ld a, DECK_2 | DECK_3 | DECK_4
	call .CheckIfCanBuild
	ret nc
; all
	ld a, ALL_DECKS
	call .CheckIfCanBuild
	ret

.CheckIfCanBuild:
	push af
	ld hl, wSelectedDeckMachineEntry
	ld b, [hl]
	call CheckIfCanBuildSavedDeck
	jr c, .cannot_build
	pop af
	ld [wDecksToBeDismantled], a
	or a
	ret
.cannot_build
	pop af
	scf
	ret

; write to wMachineDeckPtrs the pointers to the auto decks in WRAM2 wAutoDecks
CreateAutoDeckPointerList:
	ld a, 2 * NUM_AUTO_DECK_MACHINE_SLOTS
	ld hl, wMachineDeckPtrs
	farcall ClearNBytesFromHL
	ld de, wMachineDeckPtrs
	ld hl, wAutoDecks
	ld bc, DECK_COMPRESSED_STRUCT_SIZE
	ld a, NUM_AUTO_DECK_MACHINE_SLOTS
.loop
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
	jr nz, .loop
	ret

SendDeckConfigurationMenu:
	xor a
	ld [wScrollMenuScrollOffset], a
	ldtx de, DeckSaveMachineText
	ld hl, wDeckMachineTitleText
	ld [hl], e
	inc hl
	ld [hl], d
	call ClearScreenAndDrawDeckMachineScreen
	ld a, NUM_DECK_SAVE_MACHINE_SLOTS
	ld [wNumDeckMachineEntries], a

	xor a
.start_selection
	ld hl, DeckMachineSelectionParams
	farcall InitializeScrollMenuParameters
	call DrawListScrollArrows
	call PrintNumSavedDecks
	ldtx hl, ChooseDeckConfigurationToSendText
	call DrawWideTextBox_PrintText
	ldtx de, ChooseDeckConfigurationToSendText
	call InitDeckMachineDrawingParams
.loop_input
	call HandleDeckMachineSelection
	jr c, .start_selection
	cp MENU_CANCEL
	jr nz, .get_deck_machine_slot
	ld a, 1
	or a
	ret

.get_deck_machine_slot
	ld b, a
	ld a, [wScrollMenuScrollOffset]
	add b
	ld [wSelectedDeckMachineEntry], a
	call CheckIfSelectedDeckMachineEntryIsEmpty
	jr c, .loop_input

	call GetSelectedSavedDeckPtr
	ld de, wDuelTempList
	ld b, DECK_COMPRESSED_STRUCT_SIZE
	call EnableSRAM
	call CopyBBytesFromHLToDE_Bank0e
	call DisableSRAM
	xor a
	ld [wNameBuffer], a
	farcall _SendDeckConfiguration
	ret c

	call GetSelectedSavedDeckPtr
	ld de, wDefaultText
	call EnableSRAM
	call CopyListFromHLToDE_Bank0e
	call DisableSRAM
	or a
	ret

ReceiveDeckConfigurationMenu:
	xor a
	ld [wScrollMenuScrollOffset], a
	ldtx de, DeckSaveMachineText
	ld hl, wDeckMachineTitleText
	ld [hl], e
	inc hl
	ld [hl], d
	call ClearScreenAndDrawDeckMachineScreen
	ld a, NUM_DECK_SAVE_MACHINE_SLOTS
	ld [wNumDeckMachineEntries], a

	xor a
.start_selection
	ld hl, DeckMachineSelectionParams
	farcall InitializeScrollMenuParameters
	call DrawListScrollArrows
	call PrintNumSavedDecks
	ldtx hl, ChooseWhereToSaveText
	call DrawWideTextBox_PrintText
	ldtx de, ChooseWhereToSaveText
	call InitDeckMachineDrawingParams
	call HandleDeckMachineSelection
	jr c, .start_selection
	cp MENU_CANCEL
	jr nz, .get_deck_machine_slot
	ld a, 1
	or a
	ret

.get_deck_machine_slot
	ld b, a
	ld a, [wScrollMenuScrollOffset]
	add b
	ld [wSelectedDeckMachineEntry], a
	call CheckIfSelectedDeckMachineEntryIsEmpty
	jr nc, .overwrite
	jr .save

.overwrite
	ldtx hl, DeleteSavedDeckPromptText
	call YesOrNoMenuWithText
	jr nc, .save
	ld a, [wCurScrollMenuItem]
	jr .start_selection

.save
	xor a
	ld [wDuelTempList], a
	ld [wNameBuffer], a
	farcall _ReceiveDeckConfiguration
	ret c

	call GetSelectedSavedDeckPtr
	ld d, h
	ld e, l
	ld hl, wDuelTempList
	ld b, DECK_COMPRESSED_STRUCT_SIZE
	call EnableSRAM
	call CopyBBytesFromHLToDE_Bank0e
	call DisableSRAM
	call SaveGame_PreserveRegisters
	call ClearScreenAndDrawDeckMachineScreen
	ld a, [wCurScrollMenuItem]
	ld hl, DeckMachineSelectionParams
	farcall InitializeScrollMenuParameters
	call DrawListScrollArrows
	call PrintNumSavedDecks
	call HandleScrollMenu.draw_visible_cursor
	ld hl, wNameBuffer
	ld de, wDefaultText
	call EnableSRAM
	call CopyListFromHLToDE_Bank0e
	call DisableSRAM
	xor a
	ld [wTxRam2], a
	ld [wTxRam2 + 1], a
	ldtx hl, ReceivedDeckConfigurationFromText
	call DrawWideTextBox_WaitForInput
	call GetSelectedSavedDeckPtr
	ld de, wDefaultText
	call EnableSRAM
	call CopyListFromHLToDE_Bank0e
	call DisableSRAM
	xor a
	ret

SaveDeckDataToWRAM2:
	push de
	ld de, wDeckToBuild
	call CopyListFromHLToDE_Bank0e
	pop de
	ld hl, wDeckToBuild + DECK_NAME_SIZE
	bank1call SaveDeckCards
	call SwitchToWRAM2
	ld hl, wDeckToBuild
	ld de, wBigBackupDeckToBuild
	ld b, DECK_COMPRESSED_STRUCT_SIZE
	call CopyBBytesFromHLToDE_Bank0e
	call SwitchToWRAM1
	ret

OpenDeckSaveMachineFromDeckBuilding:
	ld a, [wCurDeck]
	push af
	xor a
	ld [wScrollMenuScrollOffset], a
	ldtx de, DeckSaveMachineText
	ld hl, wDeckMachineTitleText
	ld [hl], e
	inc hl
	ld [hl], d
	call ClearScreenAndDrawDeckMachineScreen
	ld a, NUM_DECK_SAVE_MACHINE_SLOTS
	ld [wNumDeckMachineEntries], a
	xor a
.wait_input
	ld hl, DeckMachineSelectionParams
	farcall InitializeScrollMenuParameters
	call DrawListScrollArrows
	call PrintNumSavedDecks
	ldtx hl, PleaseSelectDeckText
	call DrawWideTextBox_PrintText
	ldtx de, PleaseSelectDeckText
	call InitDeckMachineDrawingParams
	call HandleDeckMachineSelection
	jr c, .wait_input
	cp MENU_CANCEL
	jr z, .cancel
	ld b, a
	ld a, [wScrollMenuScrollOffset]
	add b
	ld [wSelectedDeckMachineEntry], a
	call CheckIfSelectedDeckMachineEntryIsEmpty
	jr c, .save_deck
	ldtx hl, DeleteSavedDeckPromptText
	call YesOrNoMenuWithText
	ld a, [wTempScrollMenuItem]
	jr c, .wait_input
.save_deck
	call GetSelectedSavedDeckPtr
	ld d, h
	ld e, l
	ld hl, wBigBackupDeckToBuild
	ld b, DECK_COMPRESSED_STRUCT_SIZE
	call EnableSRAM
	call SwitchToWRAM2
	call CopyBBytesFromHLToDE_Bank0e
	call SwitchToWRAM1
	call DisableSRAM
	call ClearScreenAndDrawDeckMachineScreen
	call DrawListScrollArrows
	call PrintNumSavedDecks
	ld a, [wTempScrollMenuItem]
	ld hl, DeckMachineSelectionParams
	farcall InitializeScrollMenuParameters
	call HandleScrollMenu.draw_visible_cursor
	pop af
	ld [wCurDeck], a
	farcall GetSRAMPointerToCurDeck
	call EnableSRAM
	farcall CopyDeckName
	call DisableSRAM
	xor a
	ld [wTxRam2], a
	ld [wTxRam2 + 1], a
	ldtx hl, SavedDeckToMachineText
	call DrawWideTextBox_WaitForInput
	ret
.cancel
	pop af
	ld [wCurDeck], a
	ret

Menu_3bf55:
	textitem  2, 14, SaveDeckToMachineText
	textitem 12, 14, CancelDeckText
	textitems_end

UpdateDeckMachineScrollArrowsAndEntries:
	call .DrawListScrollArrows
	ld a, [wNumDeckMachineEntries]
	cp 5
	jr c, .got_count
	ld a, 5
.got_count
	ld b, a
	ld a, [wScrollMenuScrollOffset]
	lb de, 6, 2
.loop_print
	push af
	push bc
	push de
	call .PrintDeckEntry
	pop de
	pop bc
	pop af
	dec b
	ret z
	inc a
	inc e
	inc e
	jr .loop_print

.PrintDeckEntry:
	push af
	call InitTextPrinting
	pop af
	add a
	ld c, a
	ld b, $00
	ld hl, wAutoDeckMachineTexts
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	call ProcessTextFromID
	ret

.DrawListScrollArrows:
	ld a, [wScrollMenuScrollOffset]
	or a
	jr z, .no_up_cursor
	ld a, SYM_CURSOR_U
	jr .draw_top
.no_up_cursor
	ld a, SYM_BOX_TOP
.draw_top
	lb bc, 18, 0
	call WriteByteToBGMap0

	ld a, [wScrollMenuScrollOffset]
	add 5
	ld b, a
	inc b
	ld a, [wNumDeckMachineEntries]
	cp b
	jr c, .no_down_cursor
	xor a ; FALSE
	ld [wUnableToScrollDown], a
	ld a, SYM_CURSOR_D
	jr .draw_bottom
.no_down_cursor
	ld a, TRUE
	ld [wUnableToScrollDown], a
	ld a, SYM_BOX_TOP
.draw_bottom
	lb bc, 18, 12
	call WriteByteToBGMap0
	ret
