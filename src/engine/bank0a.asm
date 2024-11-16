SECTION "Bank a@400e", ROMX[$400e], BANK[$a]

; return carry if card ID loaded in de is found in hand
; and outputs in a the deck index of that card
; as opposed to LookForCardIDInHand, this function
; creates a list in wDuelTempList
; input:
;	de = card ID
; output:
;	a = card deck index, if found
;	carry set if found
LookForCardIDInHandList:
	push de
	call CreateHandCardList
	pop bc
	ld hl, wDuelTempList
.loop
	ld a, [hli]
	cp $ff
	ret z
	ldh [hTempCardIndex_ff98], a
	push bc
	call GetCardIDFromDeckIndex
	pop bc
	ld a, d
	cp b
	jr nz, .loop
	ld a, e
	cp c
	jr nz, .loop
	ldh a, [hTempCardIndex_ff98]
	scf
	ret

; returns carry if card ID is found in non-turn duelist's Play Area
; inputs:
; - de = card ID
; outputs:
; - a = Play Area location of card if found
FindCardIDInNonTurnDuelistsPlayArea:
	call SwapTurn
	ld b, PLAY_AREA_ARENA
	call FindCardIDInTurnDuelistsPlayArea
	call SwapTurn
	ret
; 0x28039

; returns carry if card ID is found in turn duelist's Play Area
; inputs:
; - de = card ID
; - b = starting Play Area location
; outputs:
; - a = Play Area location of card if found
FindCardIDInTurnDuelistsPlayArea:
.loop_play_area
	ld a, DUELVARS_ARENA_CARD
	add b
	get_turn_duelist_var
	cp $ff
	ret z
	push bc
	push de
	call GetCardIDFromDeckIndex
	pop bc
	ld a, d
	cp b
	jr nz, .not_equal
	ld a, e
	cp c
	jr z, .found
.not_equal
	ld d, b
	ld e, c
	pop bc
	inc b
	ld a, [wMaxNumPlayAreaPokemon]
	cp b
	jr nz, .loop_play_area
	ld a, $ff
	or a
	ret
.found
	pop bc
	ld a, b
	scf
	ret

; check if energy card ID in bc is in AI hand and,
; if so, attaches it to card ID in bc in Play Area.
; input:
;	de = Pokemon card ID
;	bc = Energy card ID
AIAttachEnergyInHandToCardInPlayArea:
	push de
	ld d, b
	ld e, c
	call LookForCardIDInHandList
	pop de
	ret nc ; not in hand
	push af
	ld b, PLAY_AREA_ARENA
	call FindCardIDInTurnDuelistsPlayArea
	ldh [hTempPlayAreaLocation_ffa1], a
	pop af
	ldh [hTemp_ffa0], a
	ld a, OPPACTION_PLAY_ENERGY
	farcall AIMakeDecision
	ret
; 0x2807a

SECTION "Bank a@4087", ROMX[$4087], BANK[$a]

; finds a card ID in a given card location
; returns carry if found, and its deck index
; inputs:
; - a = CARD_LOCATION_* constant
; - de = card ID
FindCardIDInLocation:
	ld b, a
	ld hl, 0
.loop_deck
	ld a, DUELVARS_CARD_LOCATIONS
	add l
	push hl
	get_turn_duelist_var
	pop hl
	cp b
	jr nz, .next_card
	ld a, l
	push hl
	push de
	call GetCardIDFromDeckIndex
	ld l, e
	ld a, d
	pop de
	cp d
	jr nz, .next_card_pop_hl
	ld a, l
	cp e
	jr z, .found
.next_card_pop_hl
	pop hl
.next_card
	inc l
	ld a, l
	cp DECK_SIZE
	jr nz, .loop_deck
; not found
	or a
	ret
.found
	pop hl
	ld a, l
	scf
	ret
; 0x280b1

SECTION "Bank a@416b", ROMX[$416b], BANK[$a]

; in TCG1 this returned carry if deck AI was a boss deck
StubbedCheckIfOpponentHasBossDeckID:
	scf
	ret

; unreachable
	push af
	ld a, [wOpponentDeckID]
	cp AARON_PRACTICE_DECK3_ID ; LEGENDARY_MOLTRES_DECK_ID in TCG1
	jr c, .no_carry
	cp ROLLING_STONE_DECK_ID ; MUSCLES_FOR_BRAINS_DECK in TCG1
	jr nc, .no_carry
	pop af
	scf
	ret
.no_carry
	pop af
	or a
	ret

; never returns carry set
CheckIfNotABossDeckID:
	call EnableSRAM
	ld a, [sClearedGame]
	call DisableSRAM
	or a
	jr nz, .no_carry
	call StubbedCheckIfOpponentHasBossDeckID
	jr nc, .set_carry
.no_carry
	or a
	ret

.set_carry
	scf
	ret

; in TCG1 this routine randomly returned carry
; so that AI would not play a Trainer card
StubbedAIChooseRandomlyNotToDoAction:
	or a
	ret
; 0x28196

SECTION "Bank a@41cf", ROMX[$41cf], BANK[$a]

; a = number of copies
; de = card ID
CreateListOfCardIDFoundInDeck:
	ld b, a
	ld c, 0
.asm_281d2
	ld a, DUELVARS_CARD_LOCATIONS
	add c
	push hl
	get_turn_duelist_var
	pop hl
	cp CARD_LOCATION_DECK
	jr nz, .next_card ; not in Deck
	push hl
	push de
	push bc
	call GetCardIDFromDeckIndex
	pop bc
	; is it the same as input card ID?
	ld l, e
	ld a, d
	pop de
	cp d
	jr nz, .no_equal
	ld a, l
	cp e
	jr z, .is_equal
.no_equal
	pop hl
.next_card
	inc c
	ld a, c
	cp DECK_SIZE
	jr nz, .asm_281d2
	or a
	ret

.is_equal
	pop hl
	ld [hl], c
	inc hl
	dec b
	jr nz, .next_card
	scf
	ret
; 0x281fe

SECTION "Bank a@42ac", ROMX[$42ac], BANK[$a]

; inputs:
; - a = Play Area to start checking
; - d = damage to deal
FindTargetInPlayAreaToKO:
	ld e, a
	push de
	farcall CheckIfPlayerHasAuroraVeilActive
	pop de
	jr nc, .loop_whole_bench
	ld b, PLAY_AREA_ARENA + 1 ; only consider Arena card
	jr .loop_play_area
.loop_whole_bench
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	call GetNonTurnDuelistVariable
	ld b, a
.loop_play_area
	ld a, e
	cp b
	ret nc ; no KO
	add DUELVARS_ARENA_CARD_HP
	call GetNonTurnDuelistVariable
	farcall AddDefenderDamageReductionOfPlayAreaPokemon
	cp d
	jr z, .knocks_out
	jr c, .knocks_out
	inc e
	jr .loop_play_area
.knocks_out
	ld a, e
	scf
	ret

; input:
; - a = starting PLAY_AREA_* location to look
; - d = Pkmn should have at least this amount of HP
; output:
; - a = PLAY_AREA_* location found
; - d = remaining HP of selected Pokémon
; - carry set if found
AIFindPlayAreaPkmnWithMinimumLeastRemainingHP:
	ld b, $ff
	ld e, a
	add DUELVARS_ARENA_CARD
	call GetNonTurnDuelistVariable
.loop_play_area
	ld a, [hli]
	cp $ff
	jr z, .break_loop
	push hl
	ld a, e
	add DUELVARS_ARENA_CARD_HP
	call GetNonTurnDuelistVariable
	pop hl
	cp b
	jr nc, .next ; remaining HP >= b
	cp d
	jr c, .next ; remaining HP < d
	; remaining HP < b and >= d
	ld c, e
	ld b, a
.next
	inc e
	jr .loop_play_area
.break_loop
	ld a, $ff
	cp b
	jr z, .no_carry ; none found
	ld d, b ; remaining HP
	ld a, c ; Play Area location
	scf
	ret
.no_carry
	or a
	ret

; input:
; - a = PLAY_AREA_* constant to start with
FindPlayAreaCardWithLeastRemainingHP:
	ld b, $ff
	ld e, a
	add DUELVARS_ARENA_CARD
	get_turn_duelist_var
.loop_play_area
	ld a, [hli]
	cp $ff
	jr z, .break
	push hl
	ld a, e
	add DUELVARS_ARENA_CARD_HP
	get_turn_duelist_var
	pop hl
	cp b
	jr nc, .next_play_area_pkmn
	ld c, e
	ld b, a
.next_play_area_pkmn
	inc e
	jr .loop_play_area

.break
	ld a, $ff
	cp b
	jr z, .no_carry
	ld d, b ; remaining HP
	ld a, c ; play area location
	scf
	ret
.no_carry
	or a
	ret

; handles AI logic to determine some selections regarding certain attacks,
; if any of these attacks were chosen to be used.
; returns carry if selection was successful,
; and no carry if unable to make one.
AISelectSpecialAttackParameters:
	ld a, [wSelectedAttack]
	push af
	call .SelectAttackParameters
	pop bc
	ld a, b
	ld [wSelectedAttack], a
	ret

.SelectAttackParameters:
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call GetCardIDFromDeckIndex
	cp16 MEW_LV23
	jp z, .DevolutionBeam
	cp16 MEWTWO_ALT_LV60
	jp z, .EnergyAbsorption
	cp16 MEWTWO_LV60
	jp z, .EnergyAbsorption
	cp16 EXEGGUTOR
	jp z, .Teleport
	cp16 ELECTRODE_LV35
	jp z, .EnergySpike
	cp16 KINGLER_LV33
	jp z, .SaltWater
	cp16 SEADRA_LV26
	jp z, .WaterBomb
	cp16 VULPIX_LV13
	jp z, .Foxfire
	cp16 DARK_ELECTRODE
	jp z, .EnergyBomb
	cp16 ZAPDOS_LV28
	jp z, .RagingThunder
	cp16 PIKACHU_LV13
	jp z, .Recharge
	cp16 RAICHU_LV32
	jp z, .ShortCircuit
	cp16 SLOWPOKE_LV18
	jp z, .Scavenge
	cp16 GROWLITHE_LV16
	jp z, .ErrandRunning
	cp16 RAPIDASH_LV30
	jp z, .FlameInferno
	cp16 MAGIKARP_LV6
	jp z, .RapidEvolution
	cp16 DARK_PERSIAN_LV28
	jp z, .Fascinate
	cp16 MEOWTH_LV10
	jp z, .CoinHurl
	cp16 VENOMOTH_LV22
	jp z, .StirUpTwister
	cp16 DARK_ARBOK
	jp z, .Stare
	cp16 HUNGRY_SNORLAX
	jp z, .Rollout
	cp16 DARK_MAGNETON
	jp z, .MagneticLines
	cp16 DARK_RAPIDASH
	jp z, .FlamePillar
	cp16 MAGMAR_LV27
	jp z, .BurningFire
	cp16 GOLEM_LV37
	jp z, .RockBlast
	cp16 DARK_MACHOKE
	jp z, .DragOff
	cp16 DARK_ALAKAZAM
	jp z, .TeleportBlast
	cp16 MEWTWO_LV30
	jp z, .EnergyControlOrTelekinesis
	cp16 COOL_PORYGON
	jp z, .TextureMagic
	cp16 DARK_PERSIAN_ALT_LV28
	jp z, .Fascinate
	cp16 NINETALES_LV32
	jp z, .Lure
	cp16 CLEFAIRY_LV15
	jp z, .FollowMe
	cp16 PORYGON_LV12
	jp z, .Conversion1
	cp16 MACHOKE_LV24
	jp z, .FocusBlast

.no_carry
	or a
	ret

.DevolutionBeam:
	ld a, [wSelectedAttack]
	or a
	jp z, .no_carry ; not Devolution Beam
	ld a, [wOpponentDeckID]
	cp RONALDS_PSYCHIC_DECK_ID
	jr z, .ronalds_psychic_deck

.devolve_to_ko
	ld a, $01 ; player's Play Area
	ldh [hTemp_ffa0], a
	call LookForCardThatIsKnockedOutOnDevolution
	ldh [hTempPlayAreaLocation_ffa1], a
	scf
	ret

.ronalds_psychic_deck
	; check if can KO directly with attack
	call LookForCardThatIsKnockedOutOnDevolution
	jr c, .devolve_to_ko

	; cannot KO, search for a Gengar lv40
	; in own Play Area to devolve so it can reuse
	; Power of Darkness on next turn
	xor a ; AI's Play Area
	ldh [hTemp_ffa0], a
	ld de, GENGAR_LV40
	ld b, PLAY_AREA_BENCH_1
	call FindCardIDInTurnDuelistsPlayArea
	ldh [hTempPlayAreaLocation_ffa1], a
	scf
	ret

.EnergyAbsorption:
; in case selected attack is Energy Absorption
; make list from energy cards in Discard Pile
	ld a, [wSelectedAttack]
	or a
	jp nz, .no_carry

	ld a, $ff
	ldh [hTempPlayAreaLocation_ffa1], a
	ldh [hTempRetreatCostCards], a

; search for Psychic energy cards in Discard Pile
	ld de, PSYCHIC_ENERGY
	ld a, CARD_LOCATION_DISCARD_PILE
	call FindCardIDInLocation
	ldh [hTemp_ffa0], a
	farcall CreateEnergyCardListFromDiscardPile_OnlyBasic

; find any energy card different from
; the one found by FindCardIDInLocation.
; since using this attack requires a Psychic energy card,
; and another one is in hTemp_ffa0,
; then any other energy card would account
; for the Energy Cost of Psyburn.
	ld hl, wDuelTempList
.loop_energy_cards
	ld a, [hli]
	cp $ff
	jr z, .set_carry
	ld b, a
	ldh a, [hTemp_ffa0]
	cp b
	jr z, .loop_energy_cards ; same card, keep looking

; store the deck index of energy card found
	ld a, b
	ldh [hTempPlayAreaLocation_ffa1], a

.set_carry
	scf
	ret

.Teleport:
; in case selected attack is Teleport
; decide Bench card to switch to.
	ld a, [wSelectedAttack]
	or a
	jp nz, .no_carry
	farcall AIDecideBenchPokemonToSwitchTo
	jr c, .no_carry
	ldh [hTemp_ffa0], a
	scf
	ret

.EnergySpike:
; in case selected attack is Energy Spike
; decide basic energy card to fetch from Deck.
	ld a, [wSelectedAttack]
	or a
	jp z, .no_carry

	; if none were found in Deck, return carry...
	ld a, CARD_LOCATION_DECK
	ld de, LIGHTNING_ENERGY
	call FindCardIDInLocation
	ldh [hTemp_ffa0], a
	jp nc, .no_carry

; ...else find a suitable Play Area Pokemon to
; attach the energy card to.
	farcall AIProcessButDontPlayEnergy_SkipEvolution
	jp nc, .no_carry
	ldh a, [hTempPlayAreaLocation_ff9d]
	ldh [hTempPlayAreaLocation_ffa1], a
	scf
	ret

.SaltWater:
	ld a, [wSelectedAttack]
	or a
	jp nz, .no_carry

	; toss coin
	ldtx de, Text01bb
	farcall Func_68079
	ldh [hTemp_ffa0], a

	; check number of Water energies attached to Kingler
	ld e, PLAY_AREA_ARENA
	call GetPlayAreaCardAttachedEnergies
	ld a, [wAttachedEnergies + WATER]
	ld e, a
	ld a, 4 ; Double-Edged Claw energy requirements
	sub e

	; a = number of Water energies still needed
	;     for Double-Edged Claw
	ld hl, hTempPlayAreaLocation_ffa1
	jr c, .kingler_no_energy_required
	jr z, .kingler_no_energy_required
	ld de, WATER_ENERGY
	call CreateListOfCardIDFoundInDeck
.kingler_no_energy_required
	ld [hl], $ff
	scf
	ret

.WaterBomb:
	ld a, MAX_PLAY_AREA_POKEMON + 1
	ld hl, hTemp_ffa0
	farcall ClearNBytesFromHL
	ld e, PLAY_AREA_ARENA
	call GetPlayAreaCardAttachedEnergies
	ld a, [wAttachedEnergies + WATER]
	sub 3
	jr c, .made_water_bomb_selection ; no surplus energy
	jr z, .one_water_bomb_target ; only 1 surplus energy

	; 2 surplus energy, choose 2
	ld a, PLAY_AREA_BENCH_1
	ld d, 10
	call FindTargetInPlayAreaToKO
	jr nc, .check_water_bomb_20_damage
	; can KO, store this location
	ld c, a
	ld b, $00
	ld hl, hTempPlayAreaLocation_ffa1
	add hl, bc
	ld [hl], 1
	ld b, a
	ld a, 1
	ldh [hTemp_ffa0], a ; number of selected targets

	; look for another card to KO,
	; other than the one already checked
	ld a, b
	inc a
	ld d, 10
	call FindTargetInPlayAreaToKO
	jr c, .can_ko_both
	; cannot KO another one, choose target
	; with lowest remining HP
	ld a, PLAY_AREA_BENCH_1
	ld d, 20
	call AIFindPlayAreaPkmnWithMinimumLeastRemainingHP
	jr nc, .made_water_bomb_selection
.can_ko_both
	ld c, a
	ld b, $00
	ld hl, hTempPlayAreaLocation_ffa1
	add hl, bc
	ld a, [hl]
	inc a
	ld [hl], a
	ld a, 2
	ldh [hTemp_ffa0], a ; number of selected targets
.made_water_bomb_selection
	scf
	ret

.check_water_bomb_20_damage
	; check if can KO by choosing same target exactly twice
	; or otherwise the target with lowest remaining HP
	ld a, PLAY_AREA_BENCH_1
	ld d, 20
	call AIFindPlayAreaPkmnWithMinimumLeastRemainingHP
	jr nc, .made_water_bomb_selection
	ld c, a
	ld b, $00
	ld hl, hTempPlayAreaLocation_ffa1
	add hl, bc
	ld [hl], 2
	ld a, 2
	ldh [hTemp_ffa0], a ; number of selected targets
	jr .made_water_bomb_selection

.one_water_bomb_target
	; choose 1
	ld a, PLAY_AREA_BENCH_1
	ld d, 10
	call AIFindPlayAreaPkmnWithMinimumLeastRemainingHP
	jr nc, .made_water_bomb_selection
	ld c, a
	ld b, $00
	ld hl, hTempPlayAreaLocation_ffa1
	add hl, bc
	ld [hl], 1
	ld a, 1
	ldh [hTemp_ffa0], a ; number of selected targets
	jr .made_water_bomb_selection

.Foxfire:
	ld a, [wOpponentDeckID]
	cp FLAME_FESTIVAL_DECK_ID
	jr z, .select_foxfire_target_randomly
	cp BLAZING_FLAME_DECK_ID
	jr z, .select_foxfire_based_on_energies
	farcall Func_209fc
	jr c, .asm_285ff
	farcall FindBenchCardThatCanBeDamaged
.asm_285ff
	ldh [hTemp_ffa0], a
	scf
	ret

.select_foxfire_target_randomly
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	call GetNonTurnDuelistVariable
	call Random
	ldh [hTemp_ffa0], a
	scf
	ret

.select_foxfire_based_on_energies
	farcall AIDecideFirefoxTarget
	ldh [hTemp_ffa0], a
	scf
	ret

.EnergyBomb:
	ld a, [wSelectedAttack]
	or a
	jp z, .no_carry
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	cp 1
	jp z, .no_carry
	xor a ; PLAY_AREA_ARENA
	call CreateArenaOrBenchEnergyCardList
	jp c, .asm_286ad
	; show Play Area
	bank1call Func_5c30
	bank1call PrintPlayAreaCardList_EnableLCD
.asm_28633
	; check a potential target to give energy card
	farcall AIProcessButDontPlayEnergy_SkipEvolutionAndArena
	jr nc, .asm_28661
	ldh a, [hTempPlayAreaLocation_ff9d]
	ldh [hTempPlayAreaLocation_ffa1], a
	xor a ; PLAY_AREA_ARENA
	call CreateArenaOrBenchEnergyCardList
	jr c, .energy_bomb_no_more_energies ; no energies
	ld a, [wDuelTempList + 0] ; first energy card
	ldh [hTemp_ffa0], a
	ld b, 60
.asm_2864a
	call DoFrame
	dec b
	jr nz, .asm_2864a
	ld e, SECOND_ATTACK
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	ld d, a
	call CopyAttackDataAndDamage_FromDeckIndex
	ld a, OPPACTION_6B15
	farcall AIMakeDecision
	jr .asm_28633
.asm_28661
	xor a ; PLAY_AREA_ARENA
	ldh [hTempPlayAreaLocation_ffa1], a
.asm_28664
	ld a, DUELVARS_BENCH
	ld hl, hTempPlayAreaLocation_ffa1
	add [hl]
	get_turn_duelist_var
	cp $ff
	jr z, .asm_28661 ; restart loop
	; bug, a is clobbered so it doesn't have a play area location
	call CreateArenaOrBenchEnergyCardList
	jr c, .energy_bomb_no_more_energies
	ld a, [wDuelTempList + 0] ; first energy card
	ldh [hTemp_ffa0], a
	ld b, 60
.asm_2867b
	call DoFrame
	dec b
	jr nz, .asm_2867b
	ld e, SECOND_ATTACK
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	ld d, a
	call CopyAttackDataAndDamage_FromDeckIndex
	ld a, OPPACTION_6B15
	farcall AIMakeDecision
	ld hl, hTempPlayAreaLocation_ffa1
	inc [hl]
	jr .asm_28664
.energy_bomb_no_more_energies
	ld d, 60
.asm_28698
	call DoFrame
	dec d
	jr nz, .asm_28698
	ld e, SECOND_ATTACK
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	ld d, a
	call CopyAttackDataAndDamage_FromDeckIndex
	ld a, OPPACTION_DUEL_MAIN_SCENE
	farcall AIMakeDecision
.asm_286ad
	scf
	ret

.RagingThunder:
	ld a, [wSelectedAttack]
	or a
	jp nz, .no_carry
	ldtx de, Text012b
	farcall Func_68079
	ldh [hTemp_ffa0], a
	or a
	jr nz, .asm_286c7
	call AIChooseRagingThunderTarget
	ldh [hTempPlayAreaLocation_ffa1], a
.asm_286c7
	scf
	ret

.Recharge:
	ld a, [wSelectedAttack]
	or a
	jp nz, .no_carry
	; finds first Lightning Energy card in deck
	ld de, LIGHTNING_ENERGY
	ld a, CARD_LOCATION_DECK
	call FindCardIDInLocation
	ldh [hTemp_ffa0], a
	scf
	ret

.ShortCircuit:
	; first look if can KO some target...
	call AILookForShortCircuitTargetToKO
	jr c, .got_short_circuit_target
	; ...if not, then choose a target based on damage
	call AIChooseShortCircuitTarget
.got_short_circuit_target
	ldh [hTemp_ffa0], a
	scf
	ret

.Scavenge:
	ld a, [wSelectedAttack]
	or a
	jp z, .no_carry
	ldh a, [hTempPlayAreaLocation_ff9d]
	call CreateArenaOrBenchEnergyCardList
	jp c, .no_carry ; no energies
	ld a, [wDuelTempList + 0] ; first energy in list
	ldh [hTemp_ffa0], a
	; fetch a Clefairy Doll from the Discard Pile
	ld de, CLEFAIRY_DOLL
	ld a, CARD_LOCATION_DISCARD_PILE
	call FindCardIDInLocation
	jp nc, .no_carry
	ldh [hTempPlayAreaLocation_ffa1], a
	scf
	ret

.ErrandRunning:
	ld a, [wSelectedAttack]
	or a
	jp nz, .no_carry
	ldtx de, Text010d
	farcall Func_68079
	ldh [hTemp_ffa0], a
	or a
	jr z, .errand_running_tails
	; find a Bill first
	ld de, BILL
	ld a, CARD_LOCATION_DECK
	call FindCardIDInLocation
	jr c, .found_target_for_errand_running
	; no Bill, find an Imposter Professor Oak
	ld de, IMPOSTER_PROFESSOR_OAK
	ld a, CARD_LOCATION_DECK
	call FindCardIDInLocation
	jr c, .found_target_for_errand_running
	jp .no_carry
.errand_running_tails
	ld a, $ff
.found_target_for_errand_running
	ldh [hTempPlayAreaLocation_ffa1], a
	scf
	ret

.FlameInferno:
	ld a, [wSelectedAttack]
	or a
	jp nz, .no_carry
	xor a ; PLAY_AREA_ARENA
	call CreateArenaOrBenchEnergyCardList
	sub 1
	jr z, .dont_discard_for_flame_inferno ; only 1 energy attached
	cp 3
	jr c, .start_fill_flame_inferno_list ; less than 3 attached
	ld a, 2 ; maximum 2 energies
.start_fill_flame_inferno_list
	; discard as many as possible
	ld b, a ; number of energies available to discard
	ld hl, wDuelTempList
	ld de, hTemp_ffa0
	ld [de], a ; number of energies
	inc de
.loop_fill_flame_inferno_list
	ld a, [hli]
	ld [de], a
	cp $ff
	jr z, .got_flame_inferno_list
	inc de
	dec b
	jr nz, .loop_fill_flame_inferno_list
	ld a, $ff
	ld [de], a
.got_flame_inferno_list
	scf
	ret
.dont_discard_for_flame_inferno
	xor a ; 0 energies
	ldh [hTemp_ffa0], a
	; empty list
	ld a, $ff
	ldh [hTempPlayAreaLocation_ffa1], a
	scf
	ret

.RapidEvolution:
	ld a, [wSelectedAttack]
	or a
	jp z, .no_carry
	ld de, DARK_GYARADOS
	ld a, CARD_LOCATION_DISCARD_PILE ; bug, should be CARD_LOCATION_DISCARD_DECK
	call FindCardIDInLocation
	jp nc, .no_carry
	ldh [hTemp_ffa0], a
	scf
	ret

.Fascinate:
	ld a, [wSelectedAttack]
	or a
	jp nz, .no_carry
	farcall Func_209fc
	jp nc, .no_carry
	ldh [hTempPlayAreaLocation_ffa1], a
	ldtx de, Text010d
	farcall Func_68079
	ldh [hTemp_ffa0], a
	scf
	ret

.CoinHurl:
	call SwapTurn
	farcall CheckIfAnyPlayAreaPokemonHasDamage
	call SwapTurn
	jp c, .no_carry
	; no Play Area Pokémon has damage
	ldtx de, Text0105
	farcall Func_68079
	ldh [hTemp_ffa0], a
	xor a ; choose Arena card
	ldh [hTempPlayAreaLocation_ffa1], a
	scf
	ret

.StirUpTwister:
	ld a, [wSelectedAttack]
	or a
	jp nz, .no_carry
	farcall HandleMandatorySwitchSelection
	ldh a, [hTempPlayAreaLocation_ff9d]
	ldh [hTemp_ffa0], a
	farcall AIDecideBenchPokemonToSwitchTo
	jr nc, .got_stir_up_twister_decision
	ld a, $ff ; no switch
.got_stir_up_twister_decision
	ldh [hTempPlayAreaLocation_ffa1], a
	scf
	ret

.Stare:
	ld a, [wSelectedAttack]
	or a
	jp nz, .no_carry
	farcall Func_4acba
	ld a, PLAY_AREA_BENCH_1
	jr c, .asm_287e8
	xor a ; PLAY_AREA_ARENA
.asm_287e8
	ld d, 10
	call AIFindPlayAreaPkmnWithMinimumLeastRemainingHP
	ld b, a
	ld a, 10
	cp d
	jr z, .got_stare_target_to_ko
	push bc
	farcall AIChooseStareTarget
	pop bc
	jr c, .got_stare_target
.got_stare_target_to_ko
	ld a, b
.got_stare_target
	ldh [hTemp_ffa0], a
	scf
	ret

.Rollout:
	ld a, [wSelectedAttack]
	or a
	jp z, .no_carry
	; don't remove any Food Counters in order to
	; damage through Mr. Mime's Invisible Wall
	farcall CheckIfDefendingPkmnIsMrMimeLv28AndHasActivePkmnPower
	jr c, .remove_0_food_counters

	; if has no Food counters, output 0
	ld a, DUELVARS_ARENA_CARD_FOOD_COUNTERS
	get_turn_duelist_var
	or a
	jr z, .remove_0_food_counters

	; bug?
	; Flame Festival deck AI always chooses all food counters
	; except... that deck has no Hungry Snorlax cards
	; probably intended to be WEIRD_DECK_ID
	ld a, [wOpponentDeckID]
	cp FLAME_FESTIVAL_DECK_ID
	jr z, .remove_all_food_counters

	; only remove the necessary amount of Food Counters to KO
	; or otherwise damage the Defending Pokémon
	xor a
	ldh [hTempPlayAreaLocation_ff9d], a
	ld a, [wSelectedAttack]
	farcall EstimateDamage_VersusDefendingCard
	ld a, DUELVARS_ARENA_CARD_HP
	call GetNonTurnDuelistVariable
	ld b, a

	; use all Food Counters if it won't KO Arena card,
	; or exactly KO Arena card
	ld a, [wAIMaxDamage]
	cp b
	jr c, .remove_all_food_counters ; wAIMaxDamage < remaining HP
	jr z, .remove_all_food_counters ; wAIMaxDamage == remaining HP

	; remove all Food Counters if otherwise it wouldn't damage
	sub 30
	jr c, .remove_all_food_counters ; wAIMaxDamage < 30

	; remove all Food Counters if one less wouldn't KO
	cp b
	jr c, .remove_all_food_counters ; wAIMaxDamage - 30 < remaining HP

	; remove all but one Food Counter if one less wouldn't damage
	sub 30
	jr c, .remove_all_but_1_food_counters ; wAIMaxDamage < 60

	; remove all but one Food Counter if one less wouldn't KO
	cp b
	jr c, .remove_all_but_1_food_counters

.remove_0_food_counters
	xor a
	jr .got_num_food_counters_to_remove
.remove_all_food_counters
	ld a, DUELVARS_ARENA_CARD_FOOD_COUNTERS
	get_turn_duelist_var
	jr .got_num_food_counters_to_remove
.remove_all_but_1_food_counters
	ld a, DUELVARS_ARENA_CARD_FOOD_COUNTERS
	get_turn_duelist_var
	dec a
.got_num_food_counters_to_remove
	ldh [hTemp_ffa0], a
	scf
	ret

.MagneticLines:
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	call GetNonTurnDuelistVariable
	cp 1
	jp z, .no_carry ; no Bench
	xor a
	call SwapTurn
	farcall GetFirstBasicEnergyAttachedToPlayAreaCard
	call SwapTurn
	jp c, .no_carry
	; attach it to Pokémon with least amount of HP remaining in Bench
	ld a, [wDuelTempList + 0]
	ldh [hTemp_ffa0], a
	ld a, PLAY_AREA_BENCH_1
	ld d, 10
	call AIFindPlayAreaPkmnWithMinimumLeastRemainingHP
	ldh [hTempPlayAreaLocation_ffa1], a
	ret

.FlamePillar:
	ld a, PLAY_AREA_BENCH_1
	ld d, 10
	call AIFindPlayAreaPkmnWithMinimumLeastRemainingHP
	jr nc, .dont_discard_for_flame_pillar
	ldh [hPlayAreaEffectTarget], a
	; discard if will KO bench card
	ld a, 10
	cp d
	jr z, .discard_energy_for_flame_pillar
	; discard energy if will be KO'd on player's turn
	farcall CheckIfDefendingPokemonCanKnockOut
	jr c, .discard_energy_for_flame_pillar
.dont_discard_for_flame_pillar
	ld a, $01
	ldh [hTemp_ffa0], a
	scf
	ret
.discard_energy_for_flame_pillar
	xor a ; PLAY_AREA_ARENA
	call CreateArenaOrBenchEnergyCardList
	jr c, .dont_discard_for_flame_pillar
	; choose first energy card
	ld a, [wDuelTempList + 0]
	ldh [hTempPlayAreaLocation_ffa1], a
	xor a
	ldh [hTemp_ffa0], a
	scf
	ret

.BurningFire:
	ld a, [wSelectedAttack]
	or a
	jp nz, .no_carry
	farcall CheckIfDefendingPokemonCanKnockOut
	jp nc, .no_carry
	ld a, $ff
	ldh [hTemp_ffa0], a
	ldh [hTempPlayAreaLocation_ffa1], a
	ldh [hPlayAreaEffectTarget], a
	ldh [$ffa5], a
	farcall CheckIfDefendingCardIsWeakToArenaCard
	ld c, 10
	jr nc, .asm_288c5
	ld c, 20 ; defending is weak to attack
.asm_288c5
	xor a ; PLAY_AREA_ARENA
	ldh [hTempPlayAreaLocation_ff9d], a
	push bc
	farcall EstimateDamage_VersusDefendingCard
	pop bc
	ld a, DUELVARS_ARENA_CARD_HP
	call GetNonTurnDuelistVariable
	ld b, a
	ld a, [wAIMaxDamage]
	cp b
	jr c, .discard_all_cards_for_burning_fire
	jr z, .discard_all_cards_for_burning_fire
	sub c
	jr c, .discard_all_cards_for_burning_fire
	cp b
	jr c, .discard_all_cards_for_burning_fire
	sub c
	jr c, .discard_all_but_1_cards_for_burning_fire
	cp b
	jr c, .discard_all_but_1_cards_for_burning_fire
	sub c
	jr c, .discard_all_but_2_cards_for_burning_fire
	cp b
	jp nc, .no_carry

.discard_all_but_2_cards_for_burning_fire
	xor a ; PLAY_AREA_ARENA
	call CreateArenaOrBenchEnergyCardList
	sub 2
	jp c, .no_carry
	jp z, .no_carry
	jr .got_cards_to_discard_for_burning_fire

.discard_all_but_1_cards_for_burning_fire
	xor a ; PLAY_AREA_ARENA
	call CreateArenaOrBenchEnergyCardList
	sub 1
	jp c, .no_carry
	jp z, .no_carry
	jr .got_cards_to_discard_for_burning_fire

.discard_all_cards_for_burning_fire
	xor a ; PLAY_AREA_ARENA
	call CreateArenaOrBenchEnergyCardList

; a = number of cards to discard
;     from the loaded card list
; wDuelTempList = energy card list to pick from
.got_cards_to_discard_for_burning_fire
	ld b, a
	ld hl, wDuelTempList
	ld de, hTemp_ffa0
.loop_fill_burning_fire_list
	ld a, [hli]
	ld [de], a
	cp $ff
	jr z, .got_burning_fire_list
	inc de
	dec b
	jr nz, .loop_fill_burning_fire_list
	ld [hl], $ff ; terminating byte
.got_burning_fire_list
	scf
	ret

.RockBlast:
	ld a, [wSelectedAttack]
	or a
	jp z, .no_carry
	xor a ; PLAY_AREA_ARENA
	call CreateArenaOrBenchEnergyCardList
	jp c, .no_carry ; no energies
	cp 6
	jr c, .got_num_energy_discard_for_rock_blast
	ld a, 5 ; maximum 5 energies
.got_num_energy_discard_for_rock_blast
	ldh [hTemp_ffa0], a
	ld b, a
	ld hl, hTempPlayAreaLocation_ffa1
	ld de, wDuelTempList
.loop_fill_rock_blast_energy_list
	ld a, [de]
	ld [hli], a
	inc de
	dec b
	jr nz, .loop_fill_rock_blast_energy_list
	ld a, $ff ; terminating byte
	ld [hli], a
	push hl
	farcall Func_4acba
	pop hl
	jr c, .defending_is_invulnerable_to_rock_blast
	; choose all of them on the Defending card
	ldh a, [hTemp_ffa0]
	ld [hli], a ; PLAY_AREA_ARENA
	xor a
	ld [hli], a ; PLAY_AREA_BENCH_1
	ld [hli], a ; PLAY_AREA_BENCH_2
	ld [hli], a ; PLAY_AREA_BENCH_3
	ld [hli], a ; PLAY_AREA_BENCH_4
	ld [hl], a  ; PLAY_AREA_BENCH_5
	scf
	ret

.defending_is_invulnerable_to_rock_blast
	xor a
	ld [hli], a ; PLAY_AREA_ARENA
	push hl
	ld [hli], a ; PLAY_AREA_BENCH_1
	ld [hli], a ; PLAY_AREA_BENCH_2
	ld [hli], a ; PLAY_AREA_BENCH_3
	ld [hli], a ; PLAY_AREA_BENCH_4
	ld [hl], a  ; PLAY_AREA_BENCH_5
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	call GetNonTurnDuelistVariable
	pop hl
	cp 1
	ret z ; no Bench
	dec a
	ld c, a ; number of benched Pokémon
	ldh a, [hTemp_ffa0]
	or a
	jr z, .asm_28984 ; no energy cards to discard
	; choose randomly from player's Bench,
	; up to [hTemp_ffa0] number of cards
	ld b, a
	ld d, $00
.loop_rock_blast_random_selection
	ld a, c
	call Random
	ld e, a
	push hl
	add hl, de
	inc [hl]
	pop hl
	dec b
	jr nz, .loop_rock_blast_random_selection
.asm_28984
	scf
	ret

.DragOff:
	ld a, [wSelectedAttack]
	or a
	jp nz, .no_carry
	; prioritize finding a target that can be KO'd
	farcall FindBenchCardThatCanBeKnockedOut
	jr c, .got_drag_off_target
	; otherwise, choose the Pkmn with least amount of HP
	ld a, PLAY_AREA_BENCH_1
	call SwapTurn
	call FindPlayAreaCardWithLeastRemainingHP
	call SwapTurn
.got_drag_off_target
	ldh [hTemp_ffa0], a
	scf
	ret

.TeleportBlast:
	ld a, [wSelectedAttack]
	or a
	jp nz, .no_carry
	farcall CheckIfArenaCardCanKnockOutDefendingCard
	jr c, .dont_switch_teleport_blast
	; can't KO, switch if Defending card can KO on player's turn
	farcall CheckIfDefendingPokemonCanKnockOut
	jr nc, .dont_switch_teleport_blast ; don't switch
	farcall AIDecideBenchPokemonToSwitchTo
	jr nc, .got_teleport_blast_target ; switch
.dont_switch_teleport_blast
	ld a, $ff
.got_teleport_blast_target
	ldh [hTemp_ffa0], a
	scf
	ret

.EnergyControlOrTelekinesis:
	ld a, [wSelectedAttack]
	or a
	jr nz, .Telekinesis

; Energy Control
	call SwapTurn
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	ld d, a
	ld e, PLAY_AREA_BENCH_1
.asm_289d0
	push de
	call GetPlayAreaCardAttachedEnergies
	pop de
	ld a, [wTotalAttachedEnergies]
	or a
	jr z, .asm_289e6 ; no energies
	inc e
	ld a, e
	cp d
	jr nz, .asm_289d0
	ld a, PLAY_AREA_BENCH_1
	call FindPlayAreaCardWithLeastRemainingHP
	ld e, a
.asm_289e6
	ld a, e
	ldh [$ffa5], a
	xor a ; PLAY_AREA_ARENA
	ldh [hTempPlayAreaLocation_ffa1], a
	farcall GetFirstBasicEnergyAttachedToPlayAreaCard
	ldh [hPlayAreaEffectTarget], a
	call SwapTurn
	ldtx de, Text010d
	farcall TossCoin_Bank1a
	ldh [hTemp_ffa0], a
	ret c
	farcall Func_6809a
	scf
	ret

.Telekinesis:
	; for the following cases, choose Arena card...
	farcall CheckIfPlayerHasAuroraVeilActive
	jr c, .choose_arena_for_telekinesis_target
	farcall CheckIfDefendingCardIsResistantToArenaCard
	jr c, .choose_arena_for_telekinesis_target
	farcall CheckIfArenaCardIsWeakToDefendingCard
	jr c, .choose_arena_for_telekinesis_target

	; ...else choose Bench card to KO
	xor a ; PLAY_AREA_ARENA
	ld d, 30
	call FindTargetInPlayAreaToKO
	jr c, .got_telekinesis_target

	; ...else choose card with least amount of HP
	xor a ; PLAY_AREA_ARENA
	ld d, 10
	call AIFindPlayAreaPkmnWithMinimumLeastRemainingHP
	jr c, .got_telekinesis_target

.choose_arena_for_telekinesis_target
	ld a, PLAY_AREA_ARENA
.got_telekinesis_target
	farcall FindReplacementPkmnIfMrMime
	ldh [hTemp_ffa0], a
	ret

.TextureMagic:
	ld a, [wSelectedAttack]
	or a
	jp nz, .no_carry
	ld a, [wOpponentDeckID]
	cp VERY_RARE_CARD_DECK_ID
	jr z, .choose_color_of_strongest_pkmn
	ld a, $ff
	ldh [hTempPlayAreaLocation_ffa1], a
	call SwapTurn
	bank1call GetArenaCardWeakness
	call SwapTurn
	or a
	jr z, .choose_texture_magic_resistance
	; always choose Grass as player's Arena card weakness
	ld a, GRASS
	ldh [hTempPlayAreaLocation_ffa1], a
.choose_texture_magic_resistance
	; choose arena card's color for Porygon's resistance
	call SwapTurn
	bank1call GetArenaCardColor
	call SwapTurn
	; if it's Colorless, choose Psychic instead
	cp COLORLESS
	jr nz, .got_texture_magic_color
	ld a, PSYCHIC
.got_texture_magic_color
	ldh [hTemp_ffa0], a
	scf
	ret

.choose_color_of_strongest_pkmn
	; for Defending Pokémon, choose as weakness
	; the color of the Pokémon with most energy cards attached
	ld e, PLAY_AREA_BENCH_1
	farcall Func_4a3dc
	bank1call GetPlayAreaCardColor
	cp COLORLESS
	jr c, .strongest_pkmn_is_valid_color
	ld a, $ff
.strongest_pkmn_is_valid_color
	ldh [hTempPlayAreaLocation_ffa1], a
	jr .choose_texture_magic_resistance

.Lure:
	ld a, [wSelectedAttack]
	or a
	jp nz, .no_carry
	farcall AIChoosePlayerBenchPkmnWithNotEnoughEnergiesOrHighRetreatCost
	ret nc
	ldh [hTemp_ffa0], a
	scf
	ret

.FollowMe:
	ld a, [wSelectedAttack]
	or a
	jp nz, .no_carry
	ld a, FIGHTING
	farcall AIChooseFollowMeTarget
	ret nc ; no target
	ldh [hTemp_ffa0], a
	scf
	ret

.Conversion1:
	ld a, [wSelectedAttack]
	or a
	jp nz, .no_carry
	ld a, [wOpponentDeckID]
	cp YOU_CAN_DO_IT_MACHOP_DECK_ID
	jp z, .no_carry
	; always choose Grass
	ld a, GRASS
	ldh [hTemp_ffa0], a
	scf
	ret

.FocusBlast:
	ld a, [wSelectedAttack]
	or a
	jp z, .no_carry
	farcall Func_4c237
	jp c, .no_carry
	farcall AILookForFocusBlastTargetToKO
	jr c, .got_focus_blast_target
	farcall Func_3a887
	jr c, .got_focus_blast_target
	farcall AIChooseFocusBlastTarget
	jr c, .got_focus_blast_target
	; default to Arena card
	xor a ; PLAY_AREA_ARENA
.got_focus_blast_target
	ldh [hTempPlayAreaLocation_ffa1], a
	ldtx de, Text012f
	farcall Func_68079
	ldh [hTemp_ffa0], a
	scf
	ret

AIChooseRagingThunderTarget:
	xor a
	ld [wd06a], a
	ld [wd06b], a
	ld e, a ; PLAY_AREA_ARENA
	ld a, DUELVARS_BENCH
	get_turn_duelist_var
	push hl
.loop_bench
	inc e
	pop hl
	ld a, [hli]
	cp $ff
	jr z, .break
	push hl
	ld a, e
	add DUELVARS_ARENA_CARD_HP
	get_turn_duelist_var
	ld hl, wd06b
	cp [hl]
	jr c, .loop_bench ; has less remaining HP
	ld [hl], a
	ld a, e
	ld [wd06a], a
	jr .loop_bench
.break
	ld a, [wd06a]
	or a
	ret z ; has no choice other than Arena card

	; picked a Bench card, will it KO?
	ld a, [wd06b]
	cp 30
	jr nc, .got_target ; it won't
	; it will, check whether to pick Arena card instead
	; but only if it won't KO it
	ld a, DUELVARS_ARENA_CARD_HP
	get_turn_duelist_var
	cp 30
	jr c, .got_target ;  < 30
	jr z, .got_target ; == 30
	xor a ; PLAY_AREA_ARENA
	ret
.got_target
	ld a, [wd06a]
	ret

AILookForShortCircuitTargetToKO:
	farcall Func_4acba
	jr nc, .include_arena
; exclude Arena
	call SwapTurn
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	ld d, a
	ld e, PLAY_AREA_BENCH_1
	dec a
	jr nz, .loop_play_area
	or a
	call SwapTurn
	ret
.include_arena
	call SwapTurn
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	ld d, a
	ld e, PLAY_AREA_ARENA
.loop_play_area
	ld a, e
	push de
	call CreateArenaOrBenchEnergyCardList
	pop de
	call CountNumberAttachedWaterEnergies
	push af
	ld a, e
	add DUELVARS_ARENA_CARD_HP
	get_turn_duelist_var
	farcall ConvertHPToCounters
	ld b, a
	pop af
	cp b
	jr nc, .set_carry ; can KO
	inc e
	ld a, e
	cp d
	jr nz, .loop_play_area
; no carry
	call SwapTurn
	or a
	ret
.set_carry
	ld a, e
	call SwapTurn
	scf
	ret

CountNumberAttachedWaterEnergies:
	push de
	ld b, 0
	ld hl, wDuelTempList
.loop_attached_energies
	ld a, [hli]
	cp $ff
	jr z, .count_done
	push bc
	call GetCardIDFromDeckIndex
	pop bc
	cp16 WATER_ENERGY
	jr z, .incr_count
	cp16 RAINBOW_ENERGY
	jr nz, .loop_attached_energies
.incr_count
	inc b
	jr .loop_attached_energies
.count_done
	pop de
	ld a, b
	ret

AIChooseShortCircuitTarget:
	xor a
	ld [wd06a], a
	ld [wd06b], a
	farcall Func_4acba
	jr nc, .include_arena
; exclude Arena
	call SwapTurn
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	ld d, a
	ld e, PLAY_AREA_BENCH_1
	dec a
	jr nz, .loop_play_area
	xor a
	ld b, a
	call SwapTurn
	ret
.include_arena
	call SwapTurn
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	ld d, a
	ld e, PLAY_AREA_ARENA
.loop_play_area
	ld a, e
	push de
	call CreateArenaOrBenchEnergyCardList
	pop de
	call CountNumberAttachedWaterEnergies
	ld b, a
	ld a, [wd06b]
	cp b
	jr nc, .next_play_area
	ld a, b
	ld [wd06b], a
	ld a, e
	ld [wd06a], a
.next_play_area
	inc e
	ld a, e
	cp d
	jr nz, .loop_play_area
	call SwapTurn
	ld a, [wd06b]
	ld b, a
	ld a, [wd06a]
	ret

; used by AI to determine which Pokémon it should favor in the bench
; in order to attach an energy card from the hand, in case there are repeats
; if there is repeated Pokémon in bench, then increase wPlayAreaEnergyAIScore
; from the Pokémon with less damage and more energy cards,
; and decrease from all others
HandleAIEnergyScoringForRepeatedBenchPokemon:
	; clears wSamePokemonEnergyScoreHandled
	ld a, MAX_PLAY_AREA_POKEMON
	ld hl, wSamePokemonEnergyScoreHandled
	farcall ClearNBytesFromHL

	ld a, DUELVARS_BENCH
	get_turn_duelist_var
	ld e, PLAY_AREA_BENCH_1 - 1
.loop_bench
	; clears wSamePokemonEnergyScore
	push hl
	ld a, MAX_PLAY_AREA_POKEMON
	ld hl, wSamePokemonEnergyScore
	farcall ClearNBytesFromHL
	pop hl

	inc e
	ld a, [hli]
	cp $ff
	ret z ; done looping bench

	ld [wSamePokemonCardID], a ; deck index

; checks wSamePokemonEnergyScoreHandled of location in e
; if != 0, go to next in play area
	push de
	push hl
	ld d, $00
	ld hl, wSamePokemonEnergyScoreHandled
	add hl, de
	ld a, [hl]
	or a
	pop hl
	pop de
	jr nz, .loop_bench ; already handled

	; store this card's ID
	push de
	ld a, [wSamePokemonCardID]
	call GetCardIDFromDeckIndex
	ld a, e
	ld [wSamePokemonCardID + 0], a
	ld a, d
	ld [wSamePokemonCardID + 1], a
	pop de

	; calculate score of this Pokémon
	; and all cards with same ID
	push hl
	push de
	call .CalculateScore
.loop_search_same_card_id
	inc e
	ld a, [hli]
	cp $ff
	jr z, .tally_repeated_pokemon
	push de
	call GetCardIDFromDeckIndex
	ld a, [wSamePokemonCardID + 0]
	cp e
	jr nz, .not_equal
	ld a, [wSamePokemonCardID + 1]
	cp d
	pop de
	jr nz, .loop_search_same_card_id
	call .CalculateScore
	jr .loop_search_same_card_id
.not_equal
	pop de
	jr .loop_search_same_card_id

.tally_repeated_pokemon
	call .CountNumberOfCardsWithSameID
	jr c, .next_bench_pokemon

	; has repeated card IDs in bench
	; find which one has highest score
	lb bc, 0, 0
	ld hl, wSamePokemonEnergyScore + PLAY_AREA_BENCH_5
	ld d, PLAY_AREA_BENCH_5 + 1
.loop_find_highest_score
	dec d
	jr z, .got_highest_score
	ld a, [hld]
	cp b
	jr c, .loop_find_highest_score
	ld b, a ; highest score
	ld c, d ; play area location
	jr .loop_find_highest_score

; c = play area location of highest score
; increase wPlayAreaEnergyAIScore score for card with highest ID
; decrease wPlayAreaEnergyAIScore score for all cards with same ID
.got_highest_score
	ld hl, wPlayAreaEnergyAIScore
	ld de, wSamePokemonEnergyScore
	ld b, PLAY_AREA_ARENA
.loop_modify_energy_score
	ld a, c
	cp b
	jr z, .increase_score
	ld a, [de] ; score
	or a
	jr z, .next_repeat_pokemon
; decrease score
	dec [hl]
	jr .next_repeat_pokemon
.increase_score
	inc [hl]
.next_repeat_pokemon
	inc b
	ld a, MAX_PLAY_AREA_POKEMON
	cp b
	jr z, .next_bench_pokemon
	inc de
	inc hl
	jr .loop_modify_energy_score
.next_bench_pokemon
	pop de
	pop hl
	jp .loop_bench

; determines score to store in wSamePokemonEnergyScore
; for current bench Pokémon
.CalculateScore:
	push hl
	push de
	call GetCardDamageAndMaxHP
	farcall ConvertHPToCounters
	ld b, a ; number of damage counters
	push bc
	ld a, e
	call CreateArenaOrBenchEnergyCardList
	pop bc
	sla a ; number of energy cards * 2
	add $80
	sub b
	pop de
	; score = $80 + (num energy cards) * 2 - (num damage counters)
	push de
	ld d, $00
	ld hl, wSamePokemonEnergyScore
	add hl, de
	ld [hl], a
	ld hl, wSamePokemonEnergyScoreHandled
	add hl, de
	ld [hl], TRUE ; flag this bench Pokémon as handled
	pop de
	pop hl
	ret

.CountNumberOfCardsWithSameID:
	ld hl, wSamePokemonEnergyScore
	ld d, 0
	ld e, MAX_PLAY_AREA_POKEMON + 1
.loop
	dec e
	jr z, .got_count
	ld a, [hli]
	or a
	jr z, .loop
	; non-zero means it's same card ID
	inc d
	jr .loop
.got_count
	ld a, d
	cp 2
	ret

; return carry if there is a card that
; can evolve a Pokémon in hand or deck.
; input:
;	a = deck index of card to check;
; output:
;	a = deck index of evolution in hand, if found;
;	carry set if there's a card in hand that can evolve.
CheckCardEvolutionInHandOrDeck:
	ld b, a
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	push af
	ld [hl], b
	ld e, 0

.loop
	ld a, DUELVARS_CARD_LOCATIONS
	add e
	get_turn_duelist_var
	cp CARD_LOCATION_DECK
	jr z, .deck_or_hand
	cp CARD_LOCATION_HAND
	jr nz, .next
.deck_or_hand
	push de
	ld d, e
	ld e, PLAY_AREA_ARENA
	farcall CheckIfEvolvesInto
	pop de
	jr nc, .set_carry
.next
	inc e
	ld a, DECK_SIZE
	cp e
	jr nz, .loop

	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	pop af
	ld [hl], a
	or a
	ret

.set_carry
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	pop af
	ld [hl], a
	ld a, e
	scf
	ret

; returns carry if the following conditions are met:
;	- arena card HP >= half max HP
;	- arena card cannot potentially evolve
;	- arena card can use second attack
CheckIfArenaCardIsFullyPowered:
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	ld d, a
	push de
	call LoadCardDataToBuffer1_FromDeckIndex
	ld a, DUELVARS_ARENA_CARD_HP
	get_turn_duelist_var
	ld d, a
	ld a, [wLoadedCard1HP]
	rrca
	cp d
	pop de
	jr nc, .no_carry

	ld a, [wLoadedCard1AIInfo]
	and HAS_EVOLUTION
	jr z, .check_second_attack
	ld a, d
	call CheckCardEvolutionInHandOrDeck
	jr c, .no_carry

.check_second_attack
	xor a ; active card
	ldh [hTempPlayAreaLocation_ff9d], a
	ld a, SECOND_ATTACK
	ld [wSelectedAttack], a
	push hl
	farcall CheckIfSelectedAttackIsUnusable
	pop hl
	jr c, .no_carry
	scf
	ret
.no_carry
	or a
	ret

; count Pokemon in the Bench that
; meet the following conditions:
;	- card HP > half max HP
;	- card Unknown2's 4 bit is not set or
;	  is set but there's no evolution of card in hand/deck
;	- card can use second attack
; Outputs the number of Pokémon in bench
; that meet these requirements in a
; and returns carry if at least one is found
CountNumberOfSetUpBenchPokemon:
	ldh a, [hTempPlayAreaLocation_ff9d]
	ld d, a
	ld a, [wSelectedAttack]
	ld e, a
	push de
	ld a, DUELVARS_BENCH
	get_turn_duelist_var
	lb bc, 0, 0
	push hl

.next
	inc c
	pop hl
	ld a, [hli]
	push hl
	cp $ff
	jr z, .done

	ld d, a
	push de
	call LoadCardDataToBuffer1_FromDeckIndex

; compares card's current HP with max HP
	ld a, c
	add DUELVARS_ARENA_CARD_HP
	get_turn_duelist_var
	ld d, a
	ld a, [wLoadedCard1HP]
	rrca

; a = max HP / 2
; d = current HP
; jumps if (current HP) <= (max HP / 2)
	cp d
	pop de
	jr nc, .next

	ld a, [wLoadedCard1AIInfo]
	and HAS_EVOLUTION
	jr z, .check_second_attack
	ld a, d
	push bc
	call CheckCardEvolutionInHandOrDeck
	pop bc
	jr c, .next

.check_second_attack
	ld a, c
	ldh [hTempPlayAreaLocation_ff9d], a
	farcall GetHighestAttackIndex
	ld [wSelectedAttack], a
	push bc
	push hl
	farcall CheckIfSelectedAttackIsUnusable
	pop hl
	pop bc
	jr c, .next
	inc b
	jr .next

.done
	pop hl
	pop de
	ld a, e
	ld [wSelectedAttack], a
	ld a, d
	ldh [hTempPlayAreaLocation_ff9d], a
	ld a, b
	or a
	ret z
	scf
	ret
; 0x28d7e
