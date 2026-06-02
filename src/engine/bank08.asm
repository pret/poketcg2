MACRO ai_trainer_card_logic
	db \1 ; AI_TRAINER_CARD_PHASE_* constant
	dw \2 ; ID of trainer card
	dw \3 ; function for AI decision to play card
	dw \4 ; function for AI playing the card
ENDM

AITrainerCardLogic:
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_07, POTION,                 AIDecide_Potion_Phase07, AIPlay_Potion
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_10, POTION,                 AIDecide_Potion_Phase10, AIPlay_Potion
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_11, POTION,                 AIDecide_Potion_Phase11, AIPlay_Potion
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_08, SUPER_POTION,           $43d0, $43aa
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_11, SUPER_POTION,           $43ff, $43aa
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_13, SUPER_POTION,           $44d4, $43aa
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_13, DEFENDER,               $44f2, $44e3
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_14, DEFENDER,               $45ef, $44e3
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_13, PLUSPOWER,              $4692, $4678
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_14, PLUSPOWER,              $4752, $4678
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_09, SWITCH,                 $485a, $483d
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_16, SWITCH,                 AIDecide_Switch_Phase16, $483d
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_07, GUST_OF_WIND,           AIDecide_GustOfWind, AIPlay_GustOfWind
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_10, GUST_OF_WIND,           AIDecide_GustOfWind, AIPlay_GustOfWind
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_04, BILL,                   AIDecide_Bill, AIPlay_Bill
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_05, ENERGY_REMOVAL,         $4c5a, $4c44
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_05, SUPER_ENERGY_REMOVAL,   $4f33, $4f0a
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_07, POKEMON_BREEDER,        $50b6, $507b
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_15, PROFESSOR_OAK,          AIDecide_ProfessorOak, AIPlay_ProfessorOak
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_10, ENERGY_RETRIEVAL,       $566e, AIPlay_EnergyRetrieval
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_11, SUPER_ENERGY_RETRIEVAL, $5adf, AIPlay_SuperEnergyRetrieval
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_06, POKEMON_CENTER,         $5c65, $5c59
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_07, IMPOSTER_PROFESSOR_OAK, AIDecide_ImposterProfessorOak, AIPlay_ImposterProfessorOak
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_12, ENERGY_SEARCH,          $5d3e, $5d2d
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_03, POKEDEX,                $5ebd, $5e94
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_07, FULL_HEAL,              AIDecide_FullHeal, AIPlay_FullHeal
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_10, MR_FUJI,                $604f, $603e
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_10, SCOOP_UP,               $60ed, $60d7
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_02, MAINTENANCE,            $6269, $624b
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_03, RECYCLE,                $62b9, $629a
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_13, LASS,                   $6340, $632c
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_04, ITEMFINDER,             $6396, $6373
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_01, IMAKUNI_CARD,           $6659, $664d
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_01, GAMBLER,                AIDecide_Gambler, AIPlay_Gambler
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_05, REVIVE,                 $672c, $671b
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_06, POKEMON_FLUTE,          $67c0, $67af
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_05, CLEFAIRY_DOLL,          $6864, $6858
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_05, MYSTERIOUS_FOSSIL,      $6864, $6858
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_02, POKEBALL,               $68d8, $68b7
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_02, COMPUTER_SEARCH,        $6d20, $6cfd
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_02, POKEMON_TRADER,         AIDecide_PokemonTrader, AIPlay_PokemonTrader
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_02, THE_BOSSS_WAY,          $74a7, $7492
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_04, NIGHTLY_GARBAGE_RUN,    $761d, $75fe
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_04, FOSSIL_EXCAVATION,      $7a13, $79f5
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_12, SLEEP,                  AIDecide_Sleep, AIPlay_Sleep
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_02, POKEMON_RECALL,         $7aa5, $7a90
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_02, MASTER_BALL,            AIDecide_MasterBall, AIPlay_MasterBall
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_04, BILLS_TELEPORTER,       $7e05, $7df9
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_02, MOON_STONE,             $7e1c, $7e0b
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_08, THE_ROCKETS_TRAP,       $7e85, $7e79
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_17, GOOP_GAS_ATTACK,        $7eaa, $7e9e
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_07, IMPOSTER_OAKS_REVENGE,  $7ed4, $7ec3
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_01, DIGGER,                 $7f3c, $7f30
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_17, COMPUTER_ERROR,         $7f61, $7f3e
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_10, SUPER_SCOOP_UP,         $7fbc, $7f96
	db $ff

AIProcessHandTrainerCards:
	ld [wAITrainerCardPhase], a
; create hand list in wDuelTempList and wTempHandCardList.
	call CreateHandCardList
	ld hl, wDuelTempList
	ld de, wTempHandCardList
	call .CopyList

	ld hl, wTempHandCardList
.loop_hand
	ld a, [hli]
	ld [wAITrainerCardToPlay], a
	cp $ff
	ret z

	push hl
	ld hl, AITrainerCardLogic
.loop_data
	xor a
	ld [wCurrentAIFlags], a
	ld a, [hli]
	cp $ff
	jp z, .pop_hl

; compare input to first byte in data and continue if equal.
	push af
	ld a, [wAITrainerCardPhase]
	ld d, a
	pop af
	cp d
	jp nz, .inc_hl_by_6

	ld a, [hli]
	ld [wAITrainerLogicCard + 0], a
	ld a, [hli]
	ld [wAITrainerLogicCard + 1], a
	ld a, [wAITrainerCardToPlay]
	call GetCardIDFromDeckIndex
	cp16 SWITCH
	jr nz, .skip_switch_check

	ld a, [wPreviousAIFlags]
	and AI_FLAG_USED_SWITCH
	jr nz, .inc_hl_by_4

.skip_switch_check
; compare hand card to second byte in data and continue if equal.
	ld a, [wAITrainerLogicCard + 0]
	cp e
	jr nz, .inc_hl_by_4
	ld a, [wAITrainerLogicCard + 1]
	cp d
	jr nz, .inc_hl_by_4

; found Trainer card
	push hl
	push de
	ld a, [wAITrainerCardToPlay]
	ldh [hTempCardIndex_ff9f], a

; if Headache effects prevent playing card
; move on to the next item in list.
	bank1call CheckCantUseTrainerDueToEffect
	jp c, .next_in_data

	bank1call LoadNonPokemonCardEffectCommands
	ld a, EFFECTCMDTYPE_INITIAL_EFFECT_1
	call TryExecuteEffectCommandFunction
	jp c, .next_in_data

	farcall StubbedAIChooseRandomlyNotToDoAction
	jr c, .next_in_data

; call routine to decide whether to play Trainer card
	pop de
	pop hl
	push hl
	call CallIndirect
	pop hl
	jr nc, .inc_hl_by_4

; routine returned carry, which means
; this card should be played.
	inc hl
	inc hl
	ld [wAITrainerCardParameter], a

; show Play Trainer Card screen
	push de
	push hl
	ld a, [wAITrainerCardToPlay]
	ldh [hTempCardIndex_ff9f], a
	ld a, OPPACTION_PLAY_TRAINER
	farcall AIMakeDecision
	pop hl
	pop de
	jr c, .inc_hl_by_2

; execute the effects of the Trainer card
	push hl
	call CallIndirect
	pop hl
	jr c, .set_carry

	inc hl
	inc hl
	ld a, [wPreviousAIFlags]
	ld b, a
	ld a, [wCurrentAIFlags]
	or b
	ld [wPreviousAIFlags], a
	pop hl
	and AI_FLAG_MODIFIED_HAND
	jp z, .loop_hand

; the hand was modified during the Trainer effect
; so it needs to be re-listed again and
; looped from the top.
	call CreateHandCardList
	ld hl, wDuelTempList
	ld de, wTempHandCardList
	call .CopyList
	ld hl, wTempHandCardList
; clear the AI_FLAG_MODIFIED_HAND flag
	ld a, [wPreviousAIFlags]
	and ~AI_FLAG_MODIFIED_HAND
	ld [wPreviousAIFlags], a
	jp .loop_hand

.inc_hl_by_6
	inc hl
	inc hl
.inc_hl_by_4
	inc hl
	inc hl
.inc_hl_by_2
	inc hl
	inc hl
	jp .loop_data

.next_in_data
	pop de
	pop hl
	inc hl
	inc hl
	inc hl
	inc hl
	jp .loop_data

.pop_hl
	pop hl
	jp .loop_hand

.set_carry
	pop hl
	scf
	ret

; copies $ff-terminated list from hl to de
.CopyList:
	ld a, [hli]
	ld [de], a
	cp $ff
	ret z
	inc de
	jr .CopyList

; returns hl = floor(hl / 10)
CalculateWordTensDigit:
	push bc
	push de
	ld bc, -10
	ld de, -1
.loop
	inc de
	add hl, bc
	jr c, .loop
	ld h, d
	ld l, e
	pop de
	pop bc
	ret

; returns a = floor(b / a)
CalculateBDividedByA_Bank08:
	push bc
	ld c, a
	ld a, b
	ld b, c
	ld c, 0
.loop
	sub b
	jr c, .done
	inc c
	jr .loop
.done
	ld a, c
	pop bc
	ret

; makes AI use Potion card.
AIPlay_Potion:
	ld a, [wAITrainerCardToPlay]
	ldh [hTempCardIndex_ff9f], a
	ld a, [wAITrainerCardParameter]
	ldh [hTemp_ffa0], a
	ld e, a
	call GetCardDamageAndMaxHP
	cp 20
	jr c, .play_card
	ld a, 20
.play_card
	ldh [hTempPlayAreaLocation_ffa1], a
	ld a, OPPACTION_EXECUTE_TRAINER_EFFECTS
	farcall AIMakeDecision
	ret

; if AI doesn't decide to retreat this card,
; check if defending Pokémon can KO active card
; next turn after using Potion.
; if it cannot, return carry.
; also take into account whether attack is high recoil.
AIDecide_Potion_Phase07:
	farcall AIDecideWhetherToRetreat_ConsiderStatus
	jr c, .no_carry
	ld a, [wOpponentDeckID]
	cp QUICK_ATTACK_DECK_ID
	jr z, .no_carry
	cp BIG_THUNDER_DECK_ID
	jr z, .no_carry
	farcall AICheckIfAttackIsHighRecoil
	jr c, .no_carry
	ld a, 20
	farcall CheckIfRecoveryCanPreventKOByDefendingPokemon
	ret nc

; return carry
	xor a
	scf
	ret
.no_carry
	or a
	ret
; 0x202d0

SECTION "Bank 8@42d0", ROMX[$42d0], BANK[$8]

; PHASE_10 fires after the AI decides whether to retreat. Returns
; carry SET with `a` = play-area position to heal when Potion is
; worth playing on someone in our play area.
; Two deck IDs bypass the default heuristics:
;   $45: dispatches to a deck-specific Dark-Jolteon/Raichu policy
;        at $4365 (not yet decompiled).
;   $74: always returns "don't play".
AIDecide_Potion_Phase10:
	ld a, [wOpponentDeckID]
	cp $45
	jp z, $4365
	cp $74
	jp z, .skip
	ld a, $14
	farcall CheckIfRecoveryCanPreventKOByDefendingPokemon
	jr nc, .find_candidate
	or a
	ret
.find_candidate
; if we're on our last prize, consider healing the arena (start at
; e=0); otherwise skip the arena and look at bench only (start at e=1).
	call SwapTurn
	call CountPrizes
	call SwapTurn
	dec a
	jr z, .check_arena_too
	ld e, $01
	jr .loop
.check_arena_too
	ld e, $00
.loop
	ld a, DUELVARS_ARENA_CARD
	add e
	get_turn_duelist_var
	cp $ff
	ret z
	call CheckIfAnyAttackBoostsIfTakenDamage
	jr c, .next
	call GetCardDamageAndMaxHP
	cp $14
	jr nc, .found
.next
	inc e
	jr .loop
.found
	ld a, e
	or a
	jr z, .arena_pick
; bench pick: 30% of the time, skip the heal anyway so the AI is
; less deterministic. The skip is suppressed when the opponent has
; only one prize left (no time left to waste).
	push de
	call SwapTurn
	call CountPrizes
	call SwapTurn
	dec a
	or a
	jr z, .commit
	ld a, $0a
	call Random
	cp $03
.commit
	pop de
	jr c, .skip
	ld a, e
	scf
	ret
.arena_pick
; don't heal the arena if its attacks are high-recoil — Potion would
; just buy a turn so we hurt ourselves again.
	push de
	farcall AICheckIfAttackIsHighRecoil
	pop de
	jr c, .skip
	ld a, e
	scf
	ret
.skip
	or a
	ret

; returns carry SET if either of the loaded Pokemon's attacks has the
; BOOST_IF_TAKEN_DAMAGE flag (attacks like Bide that get stronger as
; the user takes damage). AIDecide_Potion_Phase10 uses this to avoid
; healing a Pokemon whose damage is actually load-bearing.
CheckIfAnyAttackBoostsIfTakenDamage:
	push de
	xor a
	ld [wSelectedAttack], a
	farcall CheckIfSelectedAttackIsUnusable
	jr c, .try_second
	ld a, ATTACK_FLAG3_ADDRESS | BOOST_IF_TAKEN_DAMAGE_F
	call CheckLoadedAttackFlag
	jr c, .yes
.try_second
	ld a, $01
	ld [wSelectedAttack], a
	farcall CheckIfSelectedAttackIsUnusable
	jr c, .no
	ld a, ATTACK_FLAG3_ADDRESS | BOOST_IF_TAKEN_DAMAGE_F
	call CheckLoadedAttackFlag
	jr c, .yes
.no
	pop de
	or a
	ret
.yes
	pop de
	scf
	ret
; 0x20365

SECTION "Bank 8@439b", ROMX[$439b], BANK[$8]

; PHASE_11 only fires for deck $74 — every other deck immediately
; returns "don't play". The deck-$74 path delegates to a bank $12
; helper that drives its bespoke Potion policy.
AIDecide_Potion_Phase11:
	ld a, [wOpponentDeckID]
	cp $74
	jp z, AIDecide_Potion_Phase11_Deck74
	or a
	ret

AIDecide_Potion_Phase11_Deck74:
	farcall Func_4bc5d
	ret
; 0x203aa

SECTION "Bank 8@489c", ROMX[$489c], BANK[$8]

; PHASE_16 fires when the AI is considering whether to manually
; switch its active Pokemon (vs. through a forced retreat). Bails
; out immediately if we have no bench, or if wD035 is non-zero
; (some prior pass already committed to a different action).
; Then dispatches to one of 14 deck-specific switch policies; decks
; not in the table default to "don't play".
AIDecide_Switch_Phase16:
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	dec a
	jr z, .skip
	farcall IswD035Zero
	ret nc
	ld a, [wOpponentDeckID]
	cp $32
	jp z, $4902
	cp $3a
	jp z, $493d
	cp $3b
	jp z, $493d
	cp $3d
	jp z, $494f
	cp $5b
	jp z, $49a7
	cp $5c
	jp z, $49ac
	cp $5d
	jp z, $49b1
	cp $5e
	jp z, $49b6
	cp $5f
	jp z, $49bb
	cp $60
	jp z, $49c0
	cp $61
	jp z, $49c5
	cp $66
	jp z, $49ca
	cp $6e
	jp z, $49cf
	cp $6f
	jp z, $49d4
	cp $70
	jp z, $49d9
	cp $72
	jp z, $49de
.skip
	or a
	ret
; 0x208fc

SECTION "Bank 8@49e3", ROMX[$49e3], BANK[$8]

; Shared play function for both AI_TRAINER_CARD_PHASE_07 and
; AI_TRAINER_CARD_PHASE_10 GUST_OF_WIND entries. Sets the
; AI_FLAG_USED_GUST_OF_WIND so the same phase pass doesn't try it
; twice, then forwards the AI's pre-picked target Pokemon via
; wAITrainerCardParameter.
AIPlay_GustOfWind:
	ld a, [wCurrentAIFlags]
	or AI_FLAG_USED_GUST_OF_WIND
	ld [wCurrentAIFlags], a
	ld a, [wAITrainerCardToPlay]
	ldh [hTempCardIndex_ff9f], a
	ld a, [wAITrainerCardParameter]
	ldh [hTemp_ffa0], a
	ld a, OPPACTION_EXECUTE_TRAINER_EFFECTS
	farcall AIMakeDecision
	ret
; 0x209fc

SECTION "Bank 8@49fc", ROMX[$49fc], BANK[$8]

AIDecide_GustOfWind:
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	call GetNonTurnDuelistVariable
	dec a
	ret z ; no Bench

	ld a, [wPreviousAIFlags]
	and AI_FLAG_USED_GUST_OF_WIND
	ret nz ; used Gust of Wind

	; a = PLAY_AREA_ARENA
	farcall CanArenaCardUseNonResidualAttack
	ret nc ; cannot use non-residual attack

	farcall CheckIfArenaCardCanKnockOutDefendingCard_CheckHand
	jr c, .no_carry ; Arena can KO

	ld a, [wOpponentDeckID]
	cp STOP_LIFE_DECK_ID
	jp z, .StopLifeDeck
	cp TSUNAMI_STARTER_DECK_ID
	jp z, .TsunamiStarterDeck
	cp SMASH_TO_MINCEMEAT_DECK_ID
	jp z, .SmashToMincemeatDeck

	; don't consider switching if Mew lv23
	; or Mewtwo lv53 is the Arena card
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call GetCardIDFromDeckIndex
	cp16 MEW_LV23
	jr z, .no_carry
	cp16 MEWTWO_LV53
	jr z, .no_carry

	call FindBenchCardThatCanBeKnockedOut
	ret c ; found card to switch in Bench

	ld a, [wOpponentDeckID]
	cp POISON_MIST_DECK_ID
	jp z, .PoisonMistDeck
	cp ULTRA_REMOVAL_DECK_ID
	jp z, .UltraRemovalDeck
	cp PSYCHIC_BATTLE_DECK_ID
	jp z, .PsychicBattleDeck

	xor a ; PLAY_AREA_ARENA
	ldh [hTempPlayAreaLocation_ff9d], a
	call CheckIfArenaCardCanPotentiallyDamageDefendingCard
	jr c, .asm_20a79 ; Arena card cannot damage
	bank1call GetArenaCardColor
	call TranslateColorToWR
	ld b, a
	call SwapTurn
	bank1call GetArenaCardWeakness
	call SwapTurn
	and b
	jr nz, .no_carry
	call .Func_20ae8
	ret nc
	scf
	ret
.no_carry
	or a
	ret

.asm_20a79
	call .Func_20ae8
	ret c
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	call GetNonTurnDuelistVariable
	ld d, a
	ld e, PLAY_AREA_BENCH_1 - 1
.asm_20a85
	inc e
	dec d
	jr z, .asm_20aa0
	call SwapTurn
	call GetPlayAreaCardAttachedEnergies
	call SwapTurn
	ld a, [wTotalAttachedEnergies]
	or a
	jr nz, .asm_20a85
	call Func_20be6
	jr nc, .asm_20a85
	ld a, e
	scf
	ret
.asm_20aa0
	ld a, $ff
	ld [wd082], a
	xor a
	ld [wd084], a
	ld e, a
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	call GetNonTurnDuelistVariable
	ld d, a
.asm_20ab0
	inc e
	dec d
	jr z, .asm_20ad2
	ld a, e
	add DUELVARS_ARENA_CARD_HP
	call GetNonTurnDuelistVariable
	ld b, a
	ld a, [wd082]
	inc b
	cp b
	jr c, .asm_20ab0
	call Func_20be6
	jr nc, .asm_20ab0
	dec b
	ld a, b
	ld [wd082], a
	ld a, e
	ld [wd084], a
	jr .asm_20ab0
.asm_20ad2
	ld a, [wd084]
	or a
	jr z, .no_carry
	scf
	ret

.asm_20ada
	push bc
	push hl
	xor a
	farcall CheckIfCanDamageDefendingPokemon
	pop hl
	pop bc
	jr nc, .loop_bench
	ld a, c
	scf
	ret

.Func_20ae8:
	ld a, DUELVARS_BENCH
	call GetNonTurnDuelistVariable
	ld c, PLAY_AREA_BENCH_1 - 1
.loop_bench
	inc c
	ld a, [hli]
	cp $ff
	jr z, .no_carry
	call SwapTurn
	call LoadCardDataToBuffer1_FromDeckIndex
	call SwapTurn
	ld a, [wLoadedCard1Weakness]
	and b
	jr nz, .asm_20ada
	jr .loop_bench

.PoisonMistDeck:
	farcall PoisonMistDeckAIDecideGustOfWind
	ret

.UltraRemovalDeck:
	farcall UltraRemovalDeckAIDecideGustOfWind
	ret

.PsychicBattleDeck:
	farcall PsychicBattleDeckAIDecideGustOfWind
	ret nc
	cp $ff
	jp z, .asm_20a79
	scf
	ret

.StopLifeDeck:
	farcall StopLifeDeckAIDecideGustOfWind
	ret

.TsunamiStarterDeck:
	farcall TsunamiStarterDeckAIDecideGustOfWind
	ret

.SmashToMincemeatDeck:
	farcall SmashToMincemeatDeckAIDecideGustOfWind
	ret

; returns nc if Arena card can potentially damage
; the current Defending card
CheckIfArenaCardCanPotentiallyDamageDefendingCard:
	xor a ; FIRST_ATTACK_OR_PKMN_POWER
	ld [wSelectedAttack], a
	call .CheckIfCanPotentiallyDamage
	jr c, .second_attack
	ret
.second_attack
	ld a, SECOND_ATTACK
	ld [wSelectedAttack], a
	call .CheckIfCanPotentiallyDamage
	jr c, .cannot_damage
	ret
.cannot_damage
	scf
	ret

.CheckIfCanPotentiallyDamage:
	ld a, [wSelectedAttack]
	ld e, a
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	ld d, a
	call CopyAttackDataAndDamage_FromDeckIndex
	ld a, [wLoadedAttackCategory]
	cp POKEMON_POWER
	jr z, .is_pkmn_power
	ld a, ATTACK_FLAG2_ADDRESS | NULLIFY_OR_WEAKEN_ATTACK_F
	call CheckLoadedAttackFlag
	jr c, .nullify_or_weaken_atk
	ld a, [wDamage]
	or a
	ret z ; no damage
.nullify_or_weaken_atk
	ld a, [wSelectedAttack]
	farcall EstimateDamage_VersusDefendingCard
	ld a, [wAIMaxDamage]
	or a
	ret nz ; can damage
.is_pkmn_power
	; cannot damage or is Pkmn Power
	scf
	ret

FindBenchCardThatCanBeKnockedOut:
	ld a, DUELVARS_BENCH
	call GetNonTurnDuelistVariable
	ld e, PLAY_AREA_BENCH_1
.loop
	ld a, [hli]
	cp $ff
	ret z
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
	xor a ; PLAY_AREA_ARENA
	ldh [hTempPlayAreaLocation_ff9d], a
	call .CheckIfAnyAttackCanKO
	jr nc, .next_bench_card
	farcall CheckIfSelectedAttackIsUnusable
	jr nc, .can_potentially_ko
	farcall LookForEnergyNeededForAttackInHand
	jr c, .can_potentially_ko
.next_bench_card
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

.can_potentially_ko
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

; e = PLAY_AREA_* constant
.CheckIfAnyAttackCanKO:
	xor a ; FIRST_ATTACK_OR_PKMN_POWER
	call .Func_20bd2
	ret c
	ld a, SECOND_ATTACK
.Func_20bd2:
	push de
	farcall EstimateDamage_VersusDefendingCard
	pop de
	ld a, DUELVARS_ARENA_CARD_HP
	add e
	call GetNonTurnDuelistVariable
	ld hl, wDamage
	sub [hl]
	ret c ; can KO
	ret nz ; cannot KO
	; can KO
	scf
	ret

Func_20be6:
	push bc
	push de
	push hl
	ld a, e
	add DUELVARS_ARENA_CARD
	call GetNonTurnDuelistVariable
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
	xor a ; PLAY_AREA_ARENA
	farcall CheckIfCanDamageDefendingPokemon
	jr c, .return_with_carry
; return with no carry
	ld a, DUELVARS_ARENA_CARD_HP
	call GetNonTurnDuelistVariable
	pop af
	ld [hl], a
	ld a, DUELVARS_ARENA_CARD
	call GetNonTurnDuelistVariable
	pop af
	ld [hl], a
	pop hl
	pop de
	pop bc
	or a
	ret
.return_with_carry
	ld a, DUELVARS_ARENA_CARD_HP
	call GetNonTurnDuelistVariable
	pop af
	ld [hl], a
	ld a, DUELVARS_ARENA_CARD
	call GetNonTurnDuelistVariable
	pop af
	ld [hl], a
	pop hl
	pop de
	pop bc
	scf
	ret
; 0x20c32

SECTION "Bank 8@4c32", ROMX[$4c32], BANK[$8]

AIPlay_Bill:
	ld a, [wAITrainerCardToPlay]
	ldh [hTempCardIndex_ff9f], a
	ld a, OPPACTION_EXECUTE_TRAINER_EFFECTS
	farcall AIMakeDecision
	ret

; play Bill only if fewer than 49 cards are out of the deck — i.e.
; there are 12+ cards left to draw from, so the extra two-card draw
; won't risk decking out.
AIDecide_Bill:
	ld a, DUELVARS_NUMBER_OF_CARDS_NOT_IN_DECK
	get_turn_duelist_var
	cp $31
	ret
; 0x20c44

SECTION "Bank 8@53bc", ROMX[$53bc], BANK[$8]

AIPlay_ProfessorOak:
	ld a, [wCurrentAIFlags]
	or AI_FLAG_USED_PROFESSOR_OAK | AI_FLAG_MODIFIED_HAND
	ld [wCurrentAIFlags], a
	ld a, [wAITrainerCardToPlay]
	ldh [hTempCardIndex_ff9f], a
	ld a, OPPACTION_EXECUTE_TRAINER_EFFECTS
	farcall AIMakeDecision
	ret

; PHASE_15 fires only after every other phase. The AI scores Oak
; against a target of $3c (60) and plays if the score lands at or
; above it. The default scoring path:
;   start at $1e (30)
;   hand size: +50 if <4, -30 if >=9, no change otherwise
;   duplicate energy cards in hand: +40
;   has Computer Search (card $03) in hand AND no active Pkmn Powers
;     on either side: +10
;   always: +10
;   has at least one Basic Pokemon in hand: -10
;   for any play-area Pokemon that has an evolution available in deck
;     but not in hand: +10 (Oak might draw it)
; Decks $11, $2d, $32, $3a, $3b, $45, $49, $4d, $50, $53, $55, $57,
; $58, $5a, $5c, $5d, $6e, $70, $71, $72 each have bespoke deciders
; (still raw hex). All decks bail out immediately if 54+ cards are
; out of the deck.
AIDecide_ProfessorOak:
	ld a, DUELVARS_NUMBER_OF_CARDS_NOT_IN_DECK
	get_turn_duelist_var
	cp $36
	ret nc
	ld a, [wOpponentDeckID]
	cp $11
	jp z, $5528
	cp $2d
	jp z, $5546
	cp $32
	jp z, $5565
	cp $3a
	jp z, $559c
	cp $3b
	jp z, $55c9
	cp $45
	jp z, $55cf
	cp $49
	jp z, $55d5
	cp $4d
	jp z, $55d5
	cp $50
	jp z, $55cf
	cp $53
	jp z, $55e8
	cp $55
	jp z, $5610
	cp $57
	jp z, $5616
	cp $58
	jp z, $561b
	cp $5a
	jp z, $5620
	cp $5c
	jp z, $5625
	cp $5d
	jp z, $562a
	cp $6e
	jp z, $562f
	cp $70
	jp z, $5634
	cp $71
	jp z, $5639
	cp $72
	jp z, $563e
; default scoring path
	ld a, [hl]
	cp $2e
	ret nc
	ld a, $1e
	ld [wd082], a
	ld a, DUELVARS_NUMBER_OF_CARDS_IN_HAND
	get_turn_duelist_var
	cp $04
	jr nc, .not_small_hand
	ld a, [wd082]
	add $32
	ld [wd082], a
	jr .after_hand_size
.not_small_hand
	cp $09
	jr c, .after_hand_size
	ld a, [wd082]
	sub $1e
	ld [wd082], a
.after_hand_size
	bank1call CreateEnergyCardListFromHand
	jr nc, .after_dup_energy
	ld a, [wd082]
	add $28
	ld [wd082], a
.after_dup_energy
	ld de, $49
	bank1call CountPokemonWithActivePkmnPowerInBothPlayAreas
	jr c, .after_pkmn_power
	ld de, $83
	bank1call CountTurnDuelistPokemonWithActivePkmnPower
	jr nc, .after_pkmn_power
	ld de, $3
	farcall LookForCardIDInHand
	jr nc, .after_pkmn_power
	ld a, [wd082]
	add $0a
	ld [wd082], a
.after_pkmn_power
	ld a, [wd082]
	add $0a
	ld [wd082], a
	call CreateHandCardList
	ld hl, wDuelTempList
.scan_basics
	ld a, [hli]
	cp $ff
	jr z, .check_evolutions
	call LoadCardDataToBuffer1_FromDeckIndex
	ld a, [wLoadedCard1Type]
	cp $08
	jr nc, .scan_basics
	ld a, [wLoadedCard1Stage]
	or a
	jr nz, .scan_basics
	ld a, [wd082]
	sub $0a
	ld [wd082], a
.check_evolutions
	xor a
	ld [wTempAITargetPokemonCardDeckIndex], a
	ld [wTempAITargetNonPokemonCardDeckIndex], a
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	ld d, a
	ld e, $00
.evolution_loop
	push de
	call LookForEvolutionInHand
	pop de
	jr nc, .check_deck_only
	ld a, $01
	ld [wTempAITargetPokemonCardDeckIndex], a
.check_deck_only
	ld a, [wd084]
	cp $01
	jr nz, .next_evolution
	ld a, $01
	ld [wTempAITargetNonPokemonCardDeckIndex], a
.next_evolution
	inc e
	dec d
	jr nz, .evolution_loop
	ld a, [wTempAITargetNonPokemonCardDeckIndex]
	or a
	jr z, .score_check
	ld a, [wTempAITargetPokemonCardDeckIndex]
	or a
	jr nz, .score_check
; an evolution exists in deck but not in hand: Oak might draw it
	ld a, [wd082]
	add $0a
	ld [wd082], a
.score_check
	ld a, [wd082]
	ld b, $3c
	cp b
	jr nc, .play_oak
	or a
	ret
.play_oak
	scf
	ret
; 0x21505

SECTION "Bank 8@5505", ROMX[$5505], BANK[$8]

; Searches the turn duelist's deck for a card that the play-area
; Pokemon at position e evolves into.
; Input:
;   e = play-area position of the Pokemon (0 = arena, 1-5 = bench)
; Output:
;   carry = a matching evolution card was found in the duelist's hand.
;   wd084 = $01 if any matching evolution exists in the deck regardless
;           of location, else $00. Lets callers tell "evolution in hand
;           right now" apart from "evolution buried in the deck" — the
;           sole caller (Func_214ad) uses this to choose between the
;           Pokemon-target and non-Pokemon-target AI flags.
LookForEvolutionInHand:
	xor a
	ld [wd084], a
	ld d, $00
.loop_deck
	farcall CheckIfEvolvesInto
	jr nc, .evolution_in_deck
.next
	inc d
	ld a, DECK_SIZE
	cp d
	jr nz, .loop_deck
	or a
	ret
.evolution_in_deck
	ld a, $01
	ld [wd084], a
	ld a, DUELVARS_CARD_LOCATIONS
	add d
	get_turn_duelist_var
	cp CARD_LOCATION_HAND
	jr nz, .next
	scf
	ret
; 0x21528

SECTION "Bank 8@5643", ROMX[$5643], BANK[$8]

; Packs the AI's pre-computed Energy Retrieval targets into the
; OPPACTION_EXECUTE_TRAINER_EFFECTS registers and dispatches. The
; second multi-target slot is optional — when it holds $ff, the
; AI energy-trans slot is zeroed so the effect treats it as unused.
AIPlay_EnergyRetrieval:
	ld a, [wCurrentAIFlags]
	or AI_FLAG_MODIFIED_HAND
	ld [wCurrentAIFlags], a
	ld a, [wAITrainerCardToPlay]
	ldh [hTempCardIndex_ff9f], a
	ld a, [wAITrainerCardParameter]
	ldh [hTemp_ffa0], a
	ld a, [wTempAIMultiTargetCardDeckIndex1]
	ldh [hTempPlayAreaLocation_ffa1], a
	ld a, [wTempAIMultiTargetCardDeckIndex2]
	ldh [hTempRetreatCostCards], a
	cp $ff
	jr z, .single_target
	ld a, $ff
	ldh [hAIEnergyTransPlayAreaLocation], a
.single_target
	ld a, OPPACTION_EXECUTE_TRAINER_EFFECTS
	farcall AIMakeDecision
	ret
; 0x2166e

SECTION "Bank 8@5a9d", ROMX[$5a9d], BANK[$8]

; Same shape as AIPlay_EnergyRetrieval, but Super Energy Retrieval
; takes up to three multi-target slots plus two raw $d09a/$d09b
; arguments. Each slot is forwarded only until one is $ff, at which
; point the rest are skipped (the trainer effect treats $ff as "no
; more targets").
AIPlay_SuperEnergyRetrieval:
	ld a, [wCurrentAIFlags]
	or AI_FLAG_MODIFIED_HAND
	ld [wCurrentAIFlags], a
	ld a, [wAITrainerCardToPlay]
	ldh [hTempCardIndex_ff9f], a
	ld a, [wAITrainerCardParameter]
	ldh [hTemp_ffa0], a
	ld a, [wTempAIMultiTargetCardDeckIndex1]
	ldh [hTempPlayAreaLocation_ffa1], a
	ld a, [wTempAIMultiTargetCardDeckIndex2]
	ldh [hTempRetreatCostCards], a
	ld a, [wTempAIMultiTargetCardDeckIndex3]
	ldh [hAIEnergyTransPlayAreaLocation], a
	cp $ff
	jr z, .done
	ld a, [$d09a]
	ldh [$ffa6], a
	cp $ff
	jr z, .done
	ld a, [$d09b]
	ldh [$ffa7], a
	cp $ff
	jr z, .done
	ld a, $ff
	ldh [$ffa8], a
.done
	ld a, OPPACTION_EXECUTE_TRAINER_EFFECTS
	farcall AIMakeDecision
	ret
; 0x21adf

SECTION "Bank 8@5ce2", ROMX[$5ce2], BANK[$8]

AIPlay_ImposterProfessorOak:
	ld a, [wAITrainerCardToPlay]
	ldh [hTempCardIndex_ff9f], a
	ld a, OPPACTION_EXECUTE_TRAINER_EFFECTS
	farcall AIMakeDecision
	ret

; Three deck IDs bypass the default policy:
;   $59, $68: play whenever wd033 is non-zero, OR when the opponent
;             has 7+ cards in hand.
;   $67:      always play.
; Default: in the early game (opponent has <46 cards out of deck),
; play only if the opponent has 9+ cards in hand (force them to redraw
; a smaller hand). In the late game (>=46 out), play only if the
; opponent has fewer than 6 cards in hand (try to deck them out).
AIDecide_ImposterProfessorOak:
	ld a, [wOpponentDeckID]
	cp $59
	jr z, .deck_59_or_68
	cp $67
	jr z, .play
	cp $68
	jr z, .deck_59_or_68
	ld a, DUELVARS_NUMBER_OF_CARDS_NOT_IN_DECK
	call GetNonTurnDuelistVariable
	cp $2e
	jr c, .early_game
	ld a, DUELVARS_NUMBER_OF_CARDS_IN_HAND
	call GetNonTurnDuelistVariable
	cp $06
	jr c, .play
.no_play
	or a
	ret
.early_game
	ld a, DUELVARS_NUMBER_OF_CARDS_IN_HAND
	call GetNonTurnDuelistVariable
	cp $09
	jr c, .no_play
.play
	scf
	ret
.deck_59_or_68
	ld a, [wd033]
	or a
	jr nz, .play
	ld a, DUELVARS_NUMBER_OF_CARDS_IN_HAND
	call GetNonTurnDuelistVariable
	cp $07
	jr c, .no_play
	jr .play
; 0x21d2d

SECTION "Bank 8@5f63", ROMX[$5f63], BANK[$8]

AIPlay_FullHeal:
	ld a, [wAITrainerCardToPlay]
	ldh [hTempCardIndex_ff9f], a
	ld a, OPPACTION_EXECUTE_TRAINER_EFFECTS
	farcall AIMakeDecision
	ret

; First checks: if the AI is already committed to retreating AND can
; either retreat or has the energy for it, skip Full Heal (just
; retreat). If the defender can't KO us, also skip — no urgency.
; If we have no status condition, skip.
; Otherwise branch by the status condition (CONFUSED / ASLEEP /
; PARALYZED) into per-status policies; deck $53 has its own policy.
AIDecide_FullHeal:
	farcall AIDecideWhetherToRetreat_IgnoreStatus
	jr nc, .check_threat
	farcall CheckIfArenaCardCanRetreat
	ccf
	ret nc
	ld a, [wAIPlayEnergyCardForRetreat]
	or a
	jr z, .check_threat
	or a
	ret
.check_threat
	farcall CheckIfDefendingPokemonCanKnockOut
	ccf
	ret nc
	ld a, [wOpponentDeckID]
	cp $53
	jp z, $602b
	ld a, DUELVARS_ARENA_CARD_STATUS
	get_turn_duelist_var
	or a
	jr z, .no_play
	and $0f
	cp PARALYZED
	jr z, .check_paralyzed_or_other
	cp ASLEEP
	jr z, .asleep_case
	cp CONFUSED
	jr z, .confused_case
.play
	scf
	ret
.asleep_case
; if our active is Slowbro Lv35 (whose Pkmn Power keeps it asleep on
; purpose), don't Full Heal — being asleep is the point.
; Otherwise check if the opponent has any of a few specific cards
; ($124, $126, $128) in play that would punish us for being asleep.
; If yes, play immediately; else fall through to the paralyzed-or-other
; checks below.
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call GetCardIDFromDeckIndex
	cp16 SLOWBRO_LV35
	jr z, .no_play
	ld de, $124
	ld b, $00
	call SwapTurn
	farcall FindCardIDInTurnDuelistsPlayArea.loop_play_area
	call SwapTurn
	jr c, .play
	ld de, $126
	ld b, $00
	call SwapTurn
	farcall FindCardIDInTurnDuelistsPlayArea.loop_play_area
	call SwapTurn
	jr c, .play
	ld de, $128
	ld b, $00
	call SwapTurn
	farcall FindCardIDInTurnDuelistsPlayArea.loop_play_area
	call SwapTurn
	jr c, .play
.check_paralyzed_or_other
; if our hand has card ID $1a9 (some recovery / cure card?) and the
; Scoop Up decider would also fire, skip — let one of those handle
; the situation. Otherwise: play if we can damage the defender AND
; we either have no energy-for-retreat OR retreat-with-status isn't
; a viable plan.
	ld de, $1a9
	farcall LookForCardIDInHandList
	jr nc, .full_heal_check_damage
	call $60ed
	jr c, .no_play
.full_heal_check_damage
	xor a
	farcall CheckIfCanDamageDefendingPokemon
	jr nc, .no_play
	ld a, [wAIPlayEnergyCardForRetreat]
	or a
	jr nz, .play
	farcall AIDecideWhetherToRetreat_ConsiderStatus
	jr nc, .play
.no_play
	or a
	ret
.confused_case
	ld de, $1a9
	farcall LookForCardIDInHandList
	jr nc, .confused_check_damage
	call $60ed
	jr c, .no_play
.confused_check_damage
	xor a
	farcall CheckIfCanDamageDefendingPokemon
	jr nc, .no_play
	ld a, [wAIPlayEnergyCardForRetreat]
	or a
	jp nz, .play
	jr .no_play
; 0x2202b

SECTION "Bank 8@6694", ROMX[$6694], BANK[$8]

; The AI cheats at Gambler: stash wRNGVars, force every byte to $50 so
; the coin flip and shuffle land on a known outcome, play the card, then
; restore the original RNG state. Three deck IDs ($29, $65, $67) opt out
; of the rigging and just play it honestly.
AIPlay_Gambler:
	ld a, [wCurrentAIFlags]
	or AI_FLAG_MODIFIED_HAND
	ld [wCurrentAIFlags], a
	ld a, [wOpponentDeckID]
	cp $29
	jr z, .play_honestly
	cp $65
	jr z, .play_honestly
	cp $67
	jr z, .play_honestly
	ld hl, wRNGVars
	ld a, [hli]
	ld [wd082], a
	ld a, [hli]
	ld [wd084], a
	ld a, [hl]
	ld [wTempAITargetPokemonCardDeckIndex], a
	ld a, $50
	ld [hld], a
	ld [hld], a
	ld [hl], a
	ld a, [wAITrainerCardToPlay]
	ldh [hTempCardIndex_ff9f], a
	ld a, OPPACTION_EXECUTE_TRAINER_EFFECTS
	farcall AIMakeDecision
	ld hl, wRNGVars
	ld a, [wd082]
	ld [hli], a
	ld a, [wd084]
	ld [hli], a
	ld a, [wTempAITargetPokemonCardDeckIndex]
	ld [hl], a
	or a
	ret
.play_honestly
	ld a, [wAITrainerCardToPlay]
	ldh [hTempCardIndex_ff9f], a
	ld a, OPPACTION_EXECUTE_TRAINER_EFFECTS
	farcall AIMakeDecision
	ret

; decides whether the AI should play Gambler this turn. Three deck IDs
; have bespoke conditions; the default policy is to play only when
; wAIBarrierFlagCounter bit 7 is set AND the duelist has 56+ cards out
; of the deck (i.e. the deck is nearly empty and Gambler will shuffle
; the hand back in).
AIDecide_Gambler:
	ld a, [wOpponentDeckID]
	cp $29
	jr z, .deck_29
	cp $65
	jr z, .deck_65
	cp $67
	jr z, .always_play
	ld a, [wAIBarrierFlagCounter]
	and $80
	jr z, .skip
	ld a, DUELVARS_NUMBER_OF_CARDS_NOT_IN_DECK
	get_turn_duelist_var
	cp $38
	jr nc, .always_play
.skip
	or a
	ret
; play if hand has fewer than 3 cards.
.deck_29
	ld a, DUELVARS_NUMBER_OF_CARDS_IN_HAND
	get_turn_duelist_var
	cp $03
	ret
; play if hand has fewer than 3 cards, or if 46+ cards are out of the deck.
.deck_65
	ld a, DUELVARS_NUMBER_OF_CARDS_IN_HAND
	get_turn_duelist_var
	cp $03
	ret c
	ld a, DUELVARS_NUMBER_OF_CARDS_NOT_IN_DECK
	get_turn_duelist_var
	cp $2e
	ccf
	ret
.always_play
	scf
	ret
; 0x2271b

SECTION "Bank 8@6e28", ROMX[$6e28], BANK[$8]

; Pokemon Trader's play also sets wd081 = 1 so subsequent passes can
; tell the AI has already traded this turn.
AIPlay_PokemonTrader:
	ld a, [wAITrainerCardToPlay]
	ldh [hTempCardIndex_ff9f], a
	ld a, [wAITrainerCardParameter]
	ldh [hTemp_ffa0], a
	ld a, [wTempAIMultiTargetCardDeckIndex1]
	ldh [hTempPlayAreaLocation_ffa1], a
	ld a, OPPACTION_EXECUTE_TRAINER_EFFECTS
	farcall AIMakeDecision
	ld a, $01
	ld [wd081], a
	ret

; Pure dispatcher: bail if we've already traded this turn, then jump
; to a per-deck policy. 25 deck IDs are special-cased; everyone else
; defaults to "don't play".
AIDecide_PokemonTrader:
	ld a, [wd081]
	or a
	ret nz
	ld a, [wOpponentDeckID]
	cp $17
	jp z, $6eca
	cp $18
	jp z, AIDecide_PokemonTrader_Deck18
	cp $2c
	jp z, $6f88
	cp $2d
	jp z, $7040
	cp $32
	jp z, $70a7
	cp $41
	jp z, $71d4
	cp $42
	jp z, $71d9
	cp $48
	jp z, $71fc
	cp $49
	jp z, $7274
	cp $4c
	jp z, $72d7
	cp $4d
	jp z, $7327
	cp $4f
	jp z, $739e
	cp $51
	jp z, $73d8
	cp $5a
	jp z, $7456
	cp $5b
	jp z, $745b
	cp $5c
	jp z, $7460
	cp $65
	jp z, $7465
	cp $6c
	jp z, $746a
	cp $6d
	jp z, $746f
	cp $6f
	jp z, $7474
	cp $70
	jp z, $7479
	cp $71
	jp z, $747e
	cp $72
	jp z, $7483
	cp $73
	jp z, $7488
	cp $74
	jp z, $748d
	or a
	ret
; 0x22eca

SECTION "Bank 8@6f1b", ROMX[$6f1b], BANK[$8]

; Deck $18's Pokemon Trader policy: only play when we can complete
; one of two specific evolution chains (by either fetching the next
; stage in an existing line, or by digging up a duplicate basic).
; The pairs are (preevo card ID, evo card ID); each pair is tried as
; both "evo is in deck" and "preevo is in deck given evo in hand".
; If any pair matches, set the picked deck index as the swap target.
; Falls back to FindDuplicatePokemonCardsInHand as a generic out.
AIDecide_PokemonTrader_Deck18:
	ld bc, $115
	ld de, $119
	farcall LookForEvoCardInDeck_GivenPreevoInHandOrPlayArea
	jr c, .pick
	ld bc, $119
	ld de, $11c
	farcall LookForEvoCardInDeck_GivenPreevoInHandOrPlayArea
	jr c, .pick
	ld de, $115
	ld bc, $119
	farcall LookForCardIDInDeck_GivenCardIDInHand
	jr c, .pick
	ld de, $119
	ld bc, $11c
	farcall LookForCardIDInDeck_GivenCardIDInHand
	jr c, .pick
	ld bc, $125
	ld de, $12a
	farcall LookForEvoCardInDeck_GivenPreevoInHandOrPlayArea
	jr c, .pick
	ld bc, $12a
	ld de, $12d
	farcall LookForEvoCardInDeck_GivenPreevoInHandOrPlayArea
	jr c, .pick
	ld de, $125
	ld bc, $12a
	farcall LookForCardIDInDeck_GivenCardIDInHand
	jr c, .pick
	ld de, $12a
	ld bc, $12d
	farcall LookForCardIDInDeck_GivenCardIDInHand
	jr nc, .no_match
.pick
	ld [wTempAIMultiTargetCardDeckIndex1], a
	farcall FindDuplicatePokemonCardsInHand
	jr c, .play
.no_match
	or a
	ret
.play
	scf
	ret
; 0x22f88

SECTION "Bank 8@7a43", ROMX[$7a43], BANK[$8]

AIPlay_Sleep:
	ld a, [wAITrainerCardToPlay]
	ldh [hTempCardIndex_ff9f], a
	ld a, OPPACTION_EXECUTE_TRAINER_EFFECTS
	farcall AIMakeDecision
	ret

; PHASE_12 fires only for two decks. Always bails out first if the
; defending Pokemon is protected from status conditions (Mr. Mime,
; Erika's Tangela, etc.). Decks $12 and $53 have bespoke policies;
; every other deck defaults to "don't play".
AIDecide_Sleep:
	call SwapTurn
	bank1call CheckIfArenaCardIsProtectedFromStatusCondition
	call SwapTurn
	jr c, .no_play
	ld a, [wOpponentDeckID]
	cp $12
	jp z, AIDecide_Sleep_Deck12
	cp $53
	jp z, $7a73
.no_play
	or a
	ret

; Deck $12: only play Sleep when the defending Pokemon doesn't
; already have a status condition — otherwise it'd just overwrite
; (or be useless if it's already Asleep / Paralyzed / etc.).
AIDecide_Sleep_Deck12:
	ld a, DUELVARS_ARENA_CARD_STATUS
	call GetNonTurnDuelistVariable
	or a
	jr nz, AIDecide_Sleep.no_play
	scf
	ret
; 0x23a73

SECTION "Bank 8@7b0a", ROMX[$7b0a], BANK[$8]

AIPlay_MasterBall:
	ld a, [wAITrainerCardToPlay]
	ldh [hTempCardIndex_ff9f], a
	ld a, [wAITrainerCardParameter]
	ldh [hTemp_ffa0], a
	ld a, $ff
	ldh [hTempPlayAreaLocation_ffa1], a
	ld a, OPPACTION_EXECUTE_TRAINER_EFFECTS
	farcall AIMakeDecision
	ret

; Bails out first if the duelist already has 55+ cards out of the
; deck. Then 12-way deck-ID dispatch. Decks $13 and $14 have inline
; policies (right here); ten others jump to bespoke sub-functions
; that are still raw; everyone else returns "don't play".
AIDecide_MasterBall:
	ld a, DUELVARS_NUMBER_OF_CARDS_NOT_IN_DECK
	get_turn_duelist_var
	cp $37
	ret nc
	ld a, [wOpponentDeckID]
	cp $13
	jr z, .deck_13
	cp $14
	jr z, .deck_14
	cp $18
	jp z, $7bdf
	cp $1a
	jp z, $7be4
	cp $29
	jp z, $7c10
	cp $3d
	jp z, $7c60
	cp $3e
	jp z, $7cdc
	cp $3f
	jp z, $7d44
	cp $40
	jp z, $7d61
	cp $43
	jp z, $7dc2
	cp $46
	jp z, $7dc7
	cp $74
	jp z, $7df4
	or a
	ret
; deck $13: priority targets are card IDs $de, $df, $e0; else AITryMasterBall
.deck_13
	ld de, $de
	farcall AITryMasterBall_GivenTarget
	ret c
	ld de, $df
	farcall AITryMasterBall_GivenTarget
	ret c
	ld de, $e0
	farcall AITryMasterBall_GivenTarget
	ret c
	farcall AITryMasterBall
	ret
; deck $14: skip Master Ball if card $1b8 is already in hand, if we
; already have 3+ Pokemon in play, or if we have a Basic Pokemon to
; develop instead. Otherwise pull from a fixed priority list of
; target card IDs.
.deck_14
	ld de, $1b8
	farcall LookForCardIDInHand
	jr nc, .deck_14_pick
.deck_14_skip
	or a
	ret
.deck_14_pick
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	cp $03
	jr nc, .deck_14_skip
	farcall CountNumberOfBasicPokemonInHand
	or a
	jr nz, .deck_14_skip
	ld de, $c1
	farcall AITryMasterBall_GivenTarget
	ret c
	ld de, $c2
	farcall AITryMasterBall_GivenTarget
	ret c
	ld de, $bf
	farcall AITryMasterBall_GivenTarget
	ret c
	ld de, $c0
	farcall AITryMasterBall_GivenTarget
	ret c
	ld de, $bb
	farcall AITryMasterBall_GivenTarget
	ret c
	ld de, $bd
	farcall AITryMasterBall_GivenTarget
	ret c
	ld de, $c3
	farcall AITryMasterBall_GivenTarget
	ret c
	ld de, $c4
	farcall AITryMasterBall_GivenTarget
	ret c
	farcall AITryMasterBall
	ret
; 0x23bdf
