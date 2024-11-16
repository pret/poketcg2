SECTION "Bank a@4da3", ROMX[$4da3], BANK[$a]

; checks in other Play Area for non-basic cards.
; afterwards, that card is checked for damage,
; and if the damage counters it has is greater than or equal
; to the max HP of the card stage below it,
; return carry and that card's Play Area location in a.
; output:
;	a = card location of Pokémon card, if found;
;	carry set if such a card is found.
LookForCardThatIsKnockedOutOnDevolution:
	farcall Func_4c237
	ccf
	ret nc
	ldh a, [hTempPlayAreaLocation_ff9d]
	push af
	farcall Func_4acba
	jr nc, .start_with_arena_card

; skip arena card
	call SwapTurn
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	ld b, a
	ld c, PLAY_AREA_BENCH_1
	jr .loop

.start_with_arena_card
	call SwapTurn
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	ld b, a
	ld c, PLAY_AREA_ARENA

.loop
	ld a, c
	ldh [hTempPlayAreaLocation_ff9d], a
	push bc
	bank1call GetCardOneStageBelow
	pop bc
	jr c, .next
	; is not a basic card
	; compare its HP with current damage
	ld a, d
	call LoadCardDataToBuffer2_FromDeckIndex
	ld a, [wLoadedCard2HP]
	ld [wTempAI], a
	ld e, c
	push bc
	call GetCardDamageAndMaxHP
	pop bc
	ld e, a
	ld a, [wTempAI]
	cp e
	jr c, .set_carry
	jr z, .set_carry
.next
	inc c
	ld a, c
	cp b
	jr nz, .loop

	call SwapTurn
	pop af
	ldh [hTempPlayAreaLocation_ff9d], a
	or a
	ret

.set_carry
	call SwapTurn
	pop af
	ldh [hTempPlayAreaLocation_ff9d], a
	ld a, c
	scf
	ret
; 0x28dff

SECTION "Bank a@58f9", ROMX[$58f9], BANK[$a]

; loops through wDuelTempList and
; returns carry if a card is found that evolves
; Pokémon whose deck index is in register a
; input:
; - a = Pokémon card deck index
; - wDuelTempList = a $ff-terminated list of cards
; output:
; - carry set if a compatible evolution card is found
CheckIfPokemonEvolutionIsFoundInHand:
	ld b, a
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	push af
	ld [hl], b
	ld hl, wDuelTempList
.loop_cards
	ld a, [hli]
	cp $ff
	jr z, .no_carry ; not found
	ld d, a
	ld e, PLAY_AREA_ARENA
	push hl
	farcall CheckIfEvolvesInto
	pop hl
	jr c, .loop_cards
	; found a compatible evolution
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	pop af
	ld [hl], a
	ld a, d
	scf
	ret
.no_carry
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	pop af
	ld [hl], a
	or a
	ret
; 0x29921

SECTION "Bank a@5951", ROMX[$5951], BANK[$a]

; returns carry if Pokémon in play area location in a
; has any attack that is usable and non-residual
; input:
; - a = PLAY_AREA_* constant
CheckIfPokemonCanUseNonResidualAttack:
	xor a ; PLAY_AREA_ARENA
	ldh [hTempPlayAreaLocation_ff9d], a
	ld [wSelectedAttack], a ; FIRST_ATTACK_OR_PKMN_POWER
	farcall CheckIfSelectedAttackIsUnusable
	jr c, .check_second_attack
	ld a, [wLoadedAttackCategory]
	and RESIDUAL
	jr z, .set_carry ; not Residual
.check_second_attack
	ld a, SECOND_ATTACK
	ld [wSelectedAttack], a
	farcall CheckIfSelectedAttackIsUnusable
	jr c, .no_carry
	ld a, [wLoadedAttackCategory]
	and RESIDUAL
	jr z, .set_carry ; not Residual
.no_carry
	; either both are Residual or
	; all non-Residual attacks are unusable
	or a
	ret
.set_carry
	scf
	ret
; 0x2997a

SECTION "Bank a@6331", ROMX[$6331], BANK[$a]

Func_2a331:
	xor a ; FIRST_ATTACK_OR_PKMN_POWER
	ld [wSelectedAttack], a
	farcall CheckEnergyNeededForAttack
	ld a, b
	add c
	cp 1
	jr z, .asm_2a362
	cp 2
	jr nz, .asm_2a348
	ld a, c
	cp 2
	jr z, .asm_2a37a
.asm_2a348
	ld a, SECOND_ATTACK
	ld [wSelectedAttack], a
	farcall CheckEnergyNeededForAttack
	ld a, b
	add c
	cp 1
	jr z, .asm_2a362
	cp 2
	jr nz, .asm_2a360
	ld a, c
	cp 2
	jr z, .asm_2a37a
.asm_2a360
	or a
	ret

.asm_2a362
	ld a, b
	or a
	jr z, .asm_2a373
	call LookForCardIDInHandList
	ret c
	ld de, RAINBOW_ENERGY
	call LookForCardIDInHandList
	ret c
	jr .asm_2a360
.asm_2a373
	bank1call CreateEnergyCardListFromHand
	jr c, .asm_2a360
	scf
	ret
.asm_2a37a
	ld de, DOUBLE_COLORLESS_ENERGY
	call LookForCardIDInHandList
	ret c
	jr .asm_2a360

; looks for energy card(s) in hand depending on
; what is needed for selected card's attack
;	- if one basic energy is required, look for that energy;
;	- if one colorless is required, create a list at wDuelTempList
;	  of all energy cards;
;	- if two colorless are required, look for double colorless;
; return carry if successful in finding card
; input:
;	[hTempPlayAreaLocation_ff9d] = location of Pokémon card
LookForEnergyNeededForAttackInHand:
	farcall CheckEnergyNeededForAttack
	ld a, b
	add c
	cp 1
	jr z, .one_energy
	cp 2
	jr nz, .no_carry
	ld a, c
	cp 2
	jr z, .two_colorless

.no_carry
	or a
	ret

.one_energy
	ld a, b
	or a
	jr z, .one_colorless
	call LookForCardIDInHandList
	ret c
	ld de, RAINBOW_ENERGY
	call LookForCardIDInHandList
	ret c
	jr .no_carry

.one_colorless
	bank1call CreateEnergyCardListFromHand
	jr c, .no_carry
	scf
	ret

.two_colorless
	ld de, DOUBLE_COLORLESS_ENERGY
	call LookForCardIDInHandList
	ret c
	jr .no_carry

; additional AI logic for determining Bench score
; when deciding whether to retreat
; input:
; - de = card ID
AIDeckSpecificBenchScore:
	ld a, [wOpponentDeckID]
	cp OVERFLOW_DECK_ID
	jr z, .OverflowDeck
	cp PSYCHIC_ELITE_DECK_ID
	jp z, .PsychicEliteDeck
	cp PUPPET_MASTER_DECK_ID
	jp z, .PuppetMasterDeck
	cp GREAT_EARTHQUAKE_DECK_ID
	jp z, .GreatEarthquakeDeck
	cp YOU_CAN_DO_IT_MACHOP_DECK_ID
	jp z, .YouCanDoItMachopDeck
	cp GLITTERING_SCALES_DECK_ID
	jp z, .GlitteringScalesDeck
	cp POISONOUS_SWAMP_DECK_ID
	jp z, .PoisonousSwampDeck
	cp GATHERING_NIDORAN_DECK_ID
	jp z, .GatheringNidoranDeck
	cp COMPLETE_COMBUSTION_DECK_ID
	jp z, .CompleteCombustionDeck
	cp FIREBALL_DECK_ID
	jp z, .FireballDeck
	cp WHIRLPOOL_SHOWER_DECK_ID
	jp z, .WhirlpoolShowerDeck
	cp STOP_LIFE_DECK_ID
	jp z, .StopLifeDeck
	cp SCORCHER_DECK_ID
	jp z, .ScorcherDeck
	cp TSUNAMI_STARTER_DECK_ID
	jp z, .TsunamiStarterDeck
	cp SMASH_TO_MINCEMEAT_DECK_ID
	jp z, .SmashToMincemeatDeck
	cp POWERFUL_POKEMON_DECK_ID
	jp z, .PowerfulPokemonDeck
	cp IMMORTAL_POKEMON_DECK_ID
	jp z, .ImmortalPokemonDeck
	cp TRAINER_IMPRISON_DECK_ID
	jp z, .TrainerImprisonDeck
	cp BIG_THUNDER_DECK_ID
	jp z, .BigThunderDeck
	cp POWER_OF_DARKNESS_DECK_ID
	jp z, .PowerOfDarknessDeck

.zero
	xor a
	ret

.OverflowDeck:
	cp16 VOLTORB_LV8
	jr nz, .zero
	; count Voltorb lv8 in Bench
	ld b, PLAY_AREA_BENCH_1
	farcall CountCardIDInTurnDuelistPlayArea
	cp 2
	jr c, .asm_2a438
	; >= 2
	ld a, 5
	ret
.asm_2a438
	; < 2
	ld a, 5
	scf
	ret

.PsychicEliteDeck:
	cp16 MEWTWO_LV60
	jr z, .mewtwo_lv60
	cp16 CHANSEY_LV55
	jr nz, .zero

; chansey lv55
	ldh a, [hTempPlayAreaLocation_ff9d]
	ld e, a
	call GetPlayAreaCardAttachedEnergies
	ld a, [wTotalAttachedEnergies]
	cp 2
	jr c, .zero
	; has at least 2 energy cards attached
	ld a, 2
	ret

.mewtwo_lv60
	ld a, CARD_LOCATION_DISCARD_PILE
	farcall CreateBasicEnergyCardListInLocation
	cp 6
	jr c, .zero
	; has at least 6 basic energy cards
	; in Discard Pile
	ld a, 2
	ret

.PuppetMasterDeck:
	cp16 HYPNO_LV30
	jr z, .hypno_lv30
	cp16 CLEFAIRY_DOLL
	jr nz, .zero

; clefairy doll
	ld de, HYPNO_LV30
	ld b, PLAY_AREA_BENCH_1
	call FindCardIDInTurnDuelistsPlayArea
	jr nc, .asm_2a4a5
	ld hl, hTempPlayAreaLocation_ff9d
	ld b, [hl]
	push bc
	ldh [hTempPlayAreaLocation_ff9d], a
	ld a, SECOND_ATTACK
	ld [wSelectedAttack], a
	farcall CheckIfSelectedAttackIsUnusable
	pop bc
	ld hl, hTempPlayAreaLocation_ff9d
	ld [hl], b
	jr c, .asm_2a4a5
	ld a, 5
	ret
.asm_2a4a5
	ld a, 3
	scf
	ret

.hypno_lv30
	ld de, CLEFAIRY_DOLL
	ld b, PLAY_AREA_BENCH_1
	call FindCardIDInTurnDuelistsPlayArea
	jp nc, .zero
	ld a, 10
	scf
	ret

.GreatEarthquakeDeck:
	cp16 DIGLETT_LV8
	jr z, .asm_2a4cd
	cp16 DIGLETT_LV16
	jp nz, .zero
.asm_2a4cd
	ld a, 3
	scf
	ret

.YouCanDoItMachopDeck:
	cp16 MACHOP_LV20
	jp nz, .zero
	call SwapTurn
	call CountPrizes
	call SwapTurn
	cp 1
	jp z, .zero
	; player is not on last prize card
	ld a, 10
	scf
	ret

.GlitteringScalesDeck:
	cp16 VENONAT_LV15
	jp nz, .zero
	ld a, 3
	scf
	ret

.PoisonousSwampDeck:
	cp16 NIDORANM_LV20
	jr z, .asm_2a512
	cp16 NIDORANM_LV22
	jp nz, .zero
.asm_2a512
	; is NidoranM
	ld a, 5
	scf
	ret

.GatheringNidoranDeck:
	cp16 NIDORANM_LV22
	jr z, .asm_2a535
	cp16 NIDORANF_LV12
	jr z, .asm_2a535
	cp16 NIDORANF_LV13
	jp nz, .zero
.asm_2a535
	; is NidoranM or NidoranF
	ld a, 3
	scf
	ret

.CompleteCombustionDeck:
	cp16 MAGMAR_LV27
	jp nz, .zero
	ldh a, [hTempPlayAreaLocation_ff9d]
	ld e, a
	call GetPlayAreaCardAttachedEnergies
	ld a, [wTotalAttachedEnergies]
	cp 3
	jp nc, .zero
	; has less than 3 energy cards
	ld a, 10
	scf
	ret

.FireballDeck:
	cp16 SQUIRTLE_LV16
	jr z, .squirtle_lv16
	cp16 MACHOP_LV24
	jp nz, .zero

; machop lv24
	call SwapTurn
	bank1call GetArenaCardWeakness
	call SwapTurn
	cp FIGHTING
	jr z, .asm_2a589 ; weak to Fighting

.asm_2a578
	ld a, 5
	scf
	ret

.squirtle_lv16
	call SwapTurn
	bank1call GetArenaCardWeakness
	call SwapTurn
	cp WATER
	jr nz, .asm_2a578 ; not weak to Water
.asm_2a589
	ld a, 5
	or a
	ret

.WhirlpoolShowerDeck:
	cp16 VOLTORB_LV10
	jr z, .voltorb_or_electrode
	cp16 ELECTRODE_LV42
	jp nz, .zero

.voltorb_or_electrode
	call SwapTurn
	bank1call GetArenaCardWeakness
	call SwapTurn
	cp LIGHTNING
	jr z, .asm_2a5b3
	ld a, 5
	scf
	ret
.asm_2a5b3
	ld a, 5
	or a
	ret

.StopLifeDeck:
	cp16 DARK_VENUSAUR
	jp nz, .zero
	ldh a, [hTempPlayAreaLocation_ff9d]
	ld e, a
	call GetPlayAreaCardAttachedEnergies
	ld a, [wTotalAttachedEnergies]
	cp 3
	jp c, .zero
	; has at least 3 energy cards
	ld a, 6
	ret

.ScorcherDeck:
	cp16 DARK_CHARMELEON
	jr z, .dark_charmeleon
	cp16 MAGMAR_LV31
	jp nz, .zero

; magmar lv31
	call SwapTurn
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call GetCardIDFromDeckIndex
	call SwapTurn
	cp16 MR_MIME_LV28
	jp nz, .zero
	; defending Pokémon is Mr. Mime lv28
	ld a, 6
	or a
	ret

.dark_charmeleon
	ld de, DARK_CLEFABLE
	farcall CheckCardIDInPlayAreaThatCanUseAttacks
	jp nc, .zero
	ld a, 3
	or a
	ret

.TsunamiStarterDeck:
	cp16 SCYTHER_LV25
	jr z, .scyther_lv25
	cp16 LAPRAS_LV31
	jp nz, .zero

; lapras lv31
	call SwapTurn
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call GetCardIDFromDeckIndex
	call SwapTurn
	cp16 MR_MIME_LV28
	jp nz, .zero
	ld a, 6
	or a
	ret

.scyther_lv25
	call SwapTurn
	bank1call GetArenaCardColor
	call SwapTurn
	cp LIGHTNING
	jp nz, .zero
	ld a, 6
	or a
	ret

.SmashToMincemeatDeck:
	cp16 DARK_MACHOKE
	jr z, .dark_machoke
	cp16 CHANSEY_LV55
	jr z, .chansey_lv55
	cp16 DARK_MACHAMP
	jp nz, .zero

; dark machamp
	ldh a, [hTempPlayAreaLocation_ff9d]
	ld e, a
	call GetPlayAreaCardAttachedEnergies
	ld a, [wTotalAttachedEnergies]
	cp 4
	jp c, .zero
	; has at least 4 energy cards
	ld a, 6
	ret

.dark_machoke
	ld de, DARK_CLEFABLE
	farcall CheckCardIDInPlayAreaThatCanUseAttacks
	jp nc, .zero
	ld a, 3
	or a
	ret

.chansey_lv55
	call CountPrizes
	cp 1
	jp nz, .zero
	; is in last prize card
	ldh a, [hTempPlayAreaLocation_ff9d]
	ld e, a
	call GetPlayAreaCardAttachedEnergies
	ld a, [wTotalAttachedEnergies]
	cp 4
	jp c, .zero
	; has at least 4 energy cards
	ld a, 6
	ret

.PowerfulPokemonDeck:
	ldh a, [hTempPlayAreaLocation_ff9d]
	farcall CheckIfDefendingPokemonIsWeakToArenaCard
	jp nc, .zero
	ld a, 5
	or a
	ret

.ImmortalPokemonDeck:
	cp16 KADABRA_LV39
	jr z, .kadabra_or_mr_mime
	cp16 MR_MIME_LV28
	jp nz, .zero

.kadabra_or_mr_mime
	ld a, SECOND_ATTACK
	ld [wSelectedAttack], a
	farcall CheckIfSelectedAttackIsUnusable
	jp c, .zero ; unusable
	ld de, ALAKAZAM_LV42
	farcall CheckCardIDInPlayAreaThatCanUseAttacks
	jp nc, .zero ; looks like a bug
	; has an Alakazam that can use all its attacks
	ld a, 5
	or a
	ret

.TrainerImprisonDeck:
	cp16 PSYDUCK_LV15
	jp nz, .zero
	ld de, DARK_VILEPLUME
	ld b, PLAY_AREA_BENCH_1
	call FindCardIDInTurnDuelistsPlayArea
	jp c, .zero
	; there's no Dark Vileplume in the bench
	ld a, 5
	ret

.BigThunderDeck:
	cp16 ZAPDOS_LV68
	jp nz, .zero
	ldh a, [hTempPlayAreaLocation_ff9d]
	add DUELVARS_ARENA_CARD_HP
	cp 60
	jp c, .zero
	ld a, 10
	ret

.PowerOfDarknessDeck:
	cp16 GRS_MEWTWO
	jp nz, .zero
	ld b, PLAY_AREA_BENCH_1
	farcall CountCardIDInTurnDuelistPlayArea
	cp 2
	jp c, .zero
	; at least 2 GR's Mewtwo in Play Area
	ld a, 28
	ret
; 0x2a72f

SECTION "Bank a@7c4f", ROMX[$7c4f], BANK[$a]

; de = text ID
Func_2bc4f:
	ld hl, wd548
	ld [hl], e
	inc hl
	ld [hl], d

	ld a, $ff ; all decks
	farcall DrawDeckSelectionMenu
	xor a
.asm_2bc5c
	ld hl, .MenuParameters
	call InitializeMenuParameters
	ld hl, wd548
	ld a, [hli]
	ld h, [hl]
	ld l, a
	call DrawWideTextBox_PrintText
.loop_input
	call DoFrame
	farcall Func_8fb9
	jr c, .asm_2bc5c
	call HandleMenuInput
	jp nc, .loop_input ; can be jr
	ldh a, [hCurScrollMenuItem]
	cp $ff
	jr nz, .selected_deck
	; player canceled selection
	scf
	ret
.selected_deck
	ld [wCurDeck], a
	farcall CheckIfCurDeckIsEmpty
	jp nc, .valid ; can be jr
	; deck is empty
	farcall Func_9215
	jr .asm_2bc5c

.valid
	ld a, [wCurDeck]
	or a
	ret

.MenuParameters:
	db 1, 2 ; cursor x, cursor y
	db 3 ; y displacement between items
	db NUM_DECKS ; number of items
	db SYM_CURSOR_R ; cursor tile number
	db SYM_SPACE ; tile behind cursor
	dw NULL ; function pointer if non-0
; 0x2bc9f
