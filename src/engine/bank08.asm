; Many functions below are per-deck AI policies named AIDecide_*_DeckNN,
; where NN is the hex wOpponentDeckID literal they dispatch on. The "(name)"
; in their comments is the deck's in-game *DeckName (data/deck_id_data.asm),
; NOT the *_DECK symbol from constants/deck_constants.asm -- those two often
; disagree, and both can differ from external English name lists. When in
; doubt a deck is described by its card contents. See the naming caveat at
; the top of data/deck_id_data.asm.

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
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_13, DEFENDER,               AIDecide_Defender_Phase13, AIPlay_Defender
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_14, DEFENDER,               AIDecide_Defender_Phase14, AIPlay_Defender
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_13, PLUSPOWER,              AIDecide_PlusPower_Phase13, AIPlay_PlusPower
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_14, PLUSPOWER,              AIDecide_PlusPower_Phase14, AIPlay_PlusPower
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_09, SWITCH,                 AIDecide_Switch_Phase09, AIPlay_Switch
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_16, SWITCH,                 AIDecide_Switch_Phase16, AIPlay_Switch
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_07, GUST_OF_WIND,           AIDecide_GustOfWind, AIPlay_GustOfWind
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_10, GUST_OF_WIND,           AIDecide_GustOfWind, AIPlay_GustOfWind
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_04, BILL,                   AIDecide_Bill, AIPlay_Bill
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_05, ENERGY_REMOVAL,         AIDecide_EnergyRemoval, AIPlay_EnergyRemoval
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_05, SUPER_ENERGY_REMOVAL,   AIDecide_SuperEnergyRemoval, AIPlay_SuperEnergyRemoval
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_07, POKEMON_BREEDER,        $50b6, AIPlay_PokemonBreeder
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_15, PROFESSOR_OAK,          AIDecide_ProfessorOak, AIPlay_ProfessorOak
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_10, ENERGY_RETRIEVAL,       AIDecide_EnergyRetrieval, AIPlay_EnergyRetrieval
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_11, SUPER_ENERGY_RETRIEVAL, $5adf, AIPlay_SuperEnergyRetrieval
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_06, POKEMON_CENTER,         $5c65, $5c59
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_07, IMPOSTER_PROFESSOR_OAK, AIDecide_ImposterProfessorOak, AIPlay_ImposterProfessorOak
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_12, ENERGY_SEARCH,          AIDecide_EnergySearch, AIPlay_EnergySearch
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_03, POKEDEX,                $5ebd, $5e94
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_07, FULL_HEAL,              AIDecide_FullHeal, AIPlay_FullHeal
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_10, MR_FUJI,                AIDecide_MrFuji, AIPlay_MrFuji
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_10, SCOOP_UP,               AIDecide_ScoopUp, AIPlay_ScoopUp
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_02, MAINTENANCE,            $6269, $624b
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_03, RECYCLE,                $62b9, $629a
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_13, LASS,                   $6340, $632c
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_04, ITEMFINDER,             AIDecide_ItemFinder, AIPlay_ItemFinder
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_01, IMAKUNI_CARD,           AIDecide_ImakuniCard, AIPlay_ImakuniCard
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_01, GAMBLER,                AIDecide_Gambler, AIPlay_Gambler
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_05, REVIVE,                 AIDecide_Revive, AIPlay_Revive
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_06, POKEMON_FLUTE,          AIDecide_PokemonFlute, AIPlay_PokemonFlute
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_05, CLEFAIRY_DOLL,          $6864, $6858
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_05, MYSTERIOUS_FOSSIL,      $6864, $6858
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_02, POKEBALL,               AIDecide_Pokeball, AIPlay_Pokeball
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_02, COMPUTER_SEARCH,        AIDecide_ComputerSearch, AIPlay_ComputerSearch
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_02, POKEMON_TRADER,         AIDecide_PokemonTrader, AIPlay_PokemonTrader
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_02, THE_BOSSS_WAY,          AIDecide_TheBosssWay, AIPlay_TheBosssWay
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_04, NIGHTLY_GARBAGE_RUN,    AIDecide_NightlyGarbageRun, AIPlay_NightlyGarbageRun
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_04, FOSSIL_EXCAVATION,      $7a13, $79f5
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_12, SLEEP,                  AIDecide_Sleep, AIPlay_Sleep
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_02, POKEMON_RECALL,         $7aa5, $7a90
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_02, MASTER_BALL,            AIDecide_MasterBall, AIPlay_MasterBall
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_04, BILLS_TELEPORTER,       AIDecide_BillsTeleporter, AIPlay_BillsTeleporter
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_02, MOON_STONE,             AIDecide_MoonStone, AIPlay_MoonStone
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_08, THE_ROCKETS_TRAP,       AIDecide_TheRocketsTrap, AIPlay_TheRocketsTrap
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_17, GOOP_GAS_ATTACK,        AIDecide_GoopGasAttack, AIPlay_GoopGasAttack
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_07, IMPOSTER_OAKS_REVENGE,  $7ed4, $7ec3
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_01, DIGGER,                 $7f3c, $7f30
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_17, COMPUTER_ERROR,         AIDecide_ComputerError, AIPlay_ComputerError
	ai_trainer_card_logic AI_TRAINER_CARD_PHASE_10, SUPER_SCOOP_UP,         AIDecide_SuperScoopUp, AIPlay_SuperScoopUp
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

; PHASE_10 fires after the AI decides whether to retreat. Returns
; carry SET with `a` = play-area position to heal when Potion is
; worth playing on someone in our play area.
; Two deck IDs bypass the default heuristics:
;   $45: dispatches to a deck-specific Dark-Jolteon/Raichu policy
;        at $4365 (not yet decompiled).
;   $74: always returns "don't play".
AIDecide_Potion_Phase10:
	ld a, [wOpponentDeckID]
	cp QUICK_ATTACK_DECK_ID
	jp z, AIDecide_Potion_Phase10_Deck45
	cp BIG_THUNDER_DECK_ID
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

; deck $45's POTION Phase 10 policy: iterate play-area positions,
; pick the first Dark Jolteon (HP threshold 30) or Dark Raichu (HP
; threshold 50) whose current HP is below its threshold. Returns
; carry SET with the slot index in `a`.
AIDecide_Potion_Phase10_Deck45:
	ld e, $00
.loop
	ld a, e
	add DUELVARS_ARENA_CARD
	get_turn_duelist_var
	cp $ff
	ret z
	push de
	call GetCardIDFromDeckIndex
	cp16 DARK_JOLTEON
	ld c, $1e
	jr z, .check_hp
	cp16 DARK_RAICHU
	ld c, $32
	jr z, .check_hp
.next
	pop de
	inc e
	jr .loop
.check_hp
	pop de
	ld a, e
	add DUELVARS_ARENA_CARD_HP
	get_turn_duelist_var
	cp c
	push de
	jr nc, .next
	pop de
	ld a, e
	scf
	ret
; 0x2039b

; PHASE_11 only fires for deck $74 — every other deck immediately
; returns "don't play". The deck-$74 path delegates to a bank $12
; helper that drives its bespoke Potion policy.
AIDecide_Potion_Phase11:
	ld a, [wOpponentDeckID]
	cp BIG_THUNDER_DECK_ID
	jp z, AIDecide_Potion_Phase11_Deck74
	or a
	ret

AIDecide_Potion_Phase11_Deck74:
	farcall Func_4bc5d
	ret
; 0x203aa

SECTION "Bank 8@44e3", ROMX[$44e3], BANK[$8]

; Shared by Phase_13 and Phase_14. Forwards hTemp_ffa0 = 0 since
; Defender doesn't need a target parameter beyond the active slot.
AIPlay_Defender:
	ld a, [wAITrainerCardToPlay]
	ldh [hTempCardIndex_ff9f], a
	xor a
	ldh [hTemp_ffa0], a
	ld a, OPPACTION_EXECUTE_TRAINER_EFFECTS
	farcall AIMakeDecision
	ret

; PHASE_13 fires before the AI attacks. Skip if our active is
; Mr. Mime Lv28 (its Pkmn Power makes Defender redundant). If we
; can pull Professor Oak via card $18e + AIDecide_ProfessorOak,
; commit to that instead -- Oak is a bigger swing than Defender.
; Skip if a Defender is already attached. Two decks have bespoke
; policies ($50 and $74).
; Default: look at the strongest attack we could land this turn,
; compare its damage to the defender's strongest counter; play only
; if the counter would otherwise KO us but adding $14 (Defender's
; reduction) keeps us alive.
AIDecide_Defender_Phase13:
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call GetCardIDFromDeckIndex
	cp16 MR_MIME_LV28
	ret z
	ld de, PROFESSOR_OAK
	farcall LookForCardIDInHandList
	jr nc, .skip_oak
	call AIDecide_ProfessorOak
	ret c
.skip_oak
	ld a, DUELVARS_ARENA_CARD_ATTACHED_DEFENDER
	get_turn_duelist_var
	or a
	ret nz
	ld a, [wOpponentDeckID]
	cp RUNNING_WILD_DECK_ID
	jr z, .deck_50
	cp BIG_THUNDER_DECK_ID
	jp z, .deck_74
	farcall CheckIfArenaCardCanKnockOutDefendingCard_CheckHand
	jr c, .no_play
	farcall CanBeKnockedOutByTwicePoisonDamage
	jr c, .no_play
	farcall CheckIfAnyDefendingPokemonAttackDealsSameDamageAsHP
	jr nc, .no_play
	call SwapTurn
	farcall CheckIfSelectedAttackIsUnusable
	call SwapTurn
	jr c, .no_play
	ld a, [wSelectedAttack]
	farcall EstimateDamage_FromDefendingPokemon
	ld a, [wDamage]
	ld [wd082], a
	ld d, a
	ld a, [wSelectedAttack]
	ld b, a
	ld a, $01
	sub b
	ld [wSelectedAttack], a
	push de
	call SwapTurn
	farcall CheckIfSelectedAttackIsUnusable
	call SwapTurn
	pop de
	jr c, .restore_attack
	ld a, [wSelectedAttack]
	push de
	farcall EstimateDamage_FromDefendingPokemon
	pop de
	ld a, [wDamage]
	cp d
	jr nc, .check_hp
.restore_attack
	ld a, [wSelectedAttack]
	ld b, a
	ld a, $01
	sub b
	ld [wSelectedAttack], a
	ld a, [wd082]
	ld [wDamage], a
.check_hp
	ld a, [wDamage]
	sub $14
	ld d, a
	ld a, DUELVARS_ARENA_CARD_HP
	get_turn_duelist_var
	sub d
	jr c, .no_play
	jr z, .no_play
.play
	scf
	ret
.no_play
	or a
	ret
; deck $50 (Running Wild): only play if our active is Dark Primeape AND its status
; is CONFUSED AND it still has 40+ HP -- Defender preserves our
; Dark Primeape long enough to recover.
.deck_50
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call GetCardIDFromDeckIndex
	cp16 DARK_PRIMEAPE
	jr nz, .no_play
	ld a, DUELVARS_ARENA_CARD_STATUS
	get_turn_duelist_var
	and $0f
	cp CONFUSED
	jr nz, .no_play
	ld a, DUELVARS_ARENA_CARD_HP
	get_turn_duelist_var
	cp $28
	jr c, .no_play
	scf
	ret
; deck $74: if active is Ditto and we have a solo play area, just
; play. Otherwise gate on a "highest damage we'd take >= 30 AND
; Defender keeps us alive" check.
.deck_74
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call GetCardIDFromDeckIndex
	cp16 DITTO
	jr nz, .deck_74_check_threat
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	cp $01
	jr z, .play
.deck_74_check_threat
	farcall CheckIfArenaCardCanKnockOutDefendingCard_CheckHand
	jr c, .no_play
	farcall CanBeKnockedOutByTwicePoisonDamage
	jr c, .no_play
	farcall GetHighestDamageFromDefendingPokemon
	cp $1e
	jr c, .no_play
	push af
	ld a, DUELVARS_ARENA_CARD_HP
	get_turn_duelist_var
	add $14
	pop bc
	sub b
	jr c, .no_play
	jr z, .no_play
	jr nc, .play
; 0x205ef

; PHASE_14 fires immediately before the AI attacks. Most of the
; smarts is in checking whether our own current attack will be
; effective and meaningful (after applying Defender to the
; defender's expected counter). Decks $50 and $74 decline outright;
; $72 takes a bespoke path. For every other deck the selected attack
; must have flag $06 or $04 set, otherwise we decline.
AIDecide_Defender_Phase14:
	ld a, DUELVARS_ARENA_CARD_ATTACHED_DEFENDER
	get_turn_duelist_var
	or a
	ret nz
	farcall CanBeKnockedOutByTwicePoisonDamage
	jr c, .no_play
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	ld d, a
	ld a, [wSelectedAttack]
	ld e, a
	call CopyAttackDataAndDamage_FromDeckIndex
	ld a, [wOpponentDeckID]
	cp RUNNING_WILD_DECK_ID
	jr z, .no_play
	cp BLAZING_FLAME_DECK_ID
	jr z, .deck_72
	cp BIG_THUNDER_DECK_ID
	jr z, .no_play
	ld a, $06
	call CheckLoadedAttackFlag
	jr c, .compute_threat
	ld a, $04
	call CheckLoadedAttackFlag
	jr c, .compute_threat
.no_play
	or a
	ret
.compute_threat
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call LoadCardDataToBuffer2_FromDeckIndex
	ld a, [wSelectedAttack]
	or a
	jr nz, .use_atk2
	ld a, [wLoadedCard2Atk1EffectParam]
	jr .got_damage
.use_atk2
	ld a, [wLoadedCard2Atk2EffectParam]
.got_damage
	ld d, a
	push de
	bank1call GetArenaCardColor
	call TranslateColorToWR
	ld b, a
	bank1call GetArenaCardWeakness
	and b
	pop de
	jr z, .no_weakness
	sla d
.no_weakness
	push de
	bank1call GetArenaCardColor
	call TranslateColorToWR
	ld b, a
	bank1call GetArenaCardResistance
	and b
	pop de
	jr z, .no_resistance
	ld a, d
	sub $1e
	jr c, .no_play_alias
	ld d, a
.no_resistance
	ld a, d
	or a
	jr z, .no_play_alias
	sub $14
	ld d, a
	ld a, DUELVARS_ARENA_CARD_HP
	get_turn_duelist_var
	sub d
	jr c, .no_play_alias
	jr z, .no_play_alias
	scf
	ret
.no_play_alias
	or a
	ret
.deck_72
	ld a, $04
	call CheckLoadedAttackFlag
	ret
; 0x20678

; Shared by Phase_13 and Phase_14. Sets AI_FLAG_USED_PLUSPOWER and
; stashes wAITrainerCardParameter (which attack to boost) into
; wAIPlusPowerAttack so the trainer-effect step knows which attack
; was chosen.
AIPlay_PlusPower:
	ld a, [wCurrentAIFlags]
	or AI_FLAG_USED_PLUSPOWER
	ld [wCurrentAIFlags], a
	ld a, [wAITrainerCardParameter]
	ld [wAIPlusPowerAttack], a
	ld a, [wAITrainerCardToPlay]
	ldh [hTempCardIndex_ff9f], a
	ld a, OPPACTION_EXECUTE_TRAINER_EFFECTS
	farcall AIMakeDecision
	ret

; Phase_13 pre-attack decision. Bail if the player's arena card is
; under Destiny Bond ($1b in DUELVARS_ARENA_CARD_SUBSTATUS1) or is
; immune to our attack. deck $45 skips this phase entirely.
; If we can already KO from hand, skip (no point boosting). If our
; active is Mr. Mime Lv28, skip (Pkmn Power). If Professor Oak ($18e)
; is in hand AND AIDecide_ProfessorOak says fire, return with a = $ff so
; the caller defers to Oak (the bigger swing).
; Otherwise pick whichever of our two attacks PlusPower-would-KO
; (CheckIfPlusPowerEnablesKO_Phase13) AND clears the damage
; threshold (CheckIfDamageThresholdMetForPlusPower_Phase13). Returns
; carry SET with `a` = attack index (0 or 1) on commit.
AIDecide_PlusPower_Phase13:
	ld a, DUELVARS_ARENA_CARD_SUBSTATUS1
	call GetNonTurnDuelistVariable
	cp $1b
	ret z
	farcall IsPlayerArenaCardImmune
	ccf
	ret nc
	ld a, [wOpponentDeckID]
	cp QUICK_ATTACK_DECK_ID
	jr z, .skip
	farcall CheckIfArenaCardCanKnockOutDefendingCard_CheckHand
	jr c, .skip
	call SwapTurn
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call GetCardIDFromDeckIndex
	call SwapTurn
	cp16 MR_MIME_LV28
	jr z, .check_attacks
	ld de, PROFESSOR_OAK
	farcall LookForCardIDInHandList
	jr nc, .check_attacks
	call AIDecide_ProfessorOak
	jr nc, .check_attacks
	ld a, $ff
	scf
	ret
.check_attacks
	xor a
	ld [wSelectedAttack], a
	call CheckIfPlusPowerEnablesKO_Phase13
	jr c, .attack_0_passes
	ld a, $01
	ld [wSelectedAttack], a
	call CheckIfPlusPowerEnablesKO_Phase13
	jr c, .attack_1_passes
.skip
	or a
	ret
.attack_0_passes
	call CheckIfDamageThresholdMetForPlusPower_Phase13
	jr nc, .skip
	xor a
	scf
	ret
.attack_1_passes
	call CheckIfDamageThresholdMetForPlusPower_Phase13
	jr nc, .skip
	ld a, $01
	scf
	ret

; Phase 13 helper: simulate "what if PlusPower were attached" and
; return carry SET when the boosted attack would KO the defender
; (going from "doesn't KO" to "does KO" by adding +10 damage).
; Returns NC when the attack is unusable, would already KO without
; the bonus, or wouldn't KO even with it.
CheckIfPlusPowerEnablesKO_Phase13:
	farcall CheckIfSelectedAttackIsUnusable
	jr c, .unusable
	ld a, [wSelectedAttack]
	farcall EstimateDamage_VersusDefendingCard
	ld a, DUELVARS_ARENA_CARD_HP
	call GetNonTurnDuelistVariable
	ld b, a
	ld hl, wDamage
	sub [hl]
	jr c, AIDecide_PlusPower_Phase13.skip
	jr z, AIDecide_PlusPower_Phase13.skip
	ld a, DUELVARS_ARENA_CARD_ATTACHED_PLUSPOWER
	get_turn_duelist_var
	inc [hl]
	push bc
	ld a, [wSelectedAttack]
	farcall EstimateDamage_VersusDefendingCard
	pop bc
	ld a, DUELVARS_ARENA_CARD_ATTACHED_PLUSPOWER
	get_turn_duelist_var
	dec [hl]
	ld a, [wDamage]
	ld c, a
	ld a, b
	sub c
	ret c
	ret nz
	scf
	ret
.unusable
	or a
	ret

; Phase 13 helper: returns carry SET when (damage + 10 >= 30) AND
; the defending Pokemon is NOT Mr. Mime Lv28 (whose Pkmn Power
; prevents low-damage attacks). Used as a secondary gate after
; CheckIfPlusPowerEnablesKO_Phase13.
CheckIfDamageThresholdMetForPlusPower_Phase13:
	ld a, [wDamage]
	add $0a
	cp $1e
	ret c
	call SwapTurn
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call GetCardIDFromDeckIndex
	call SwapTurn
	cp16 MR_MIME_LV28
	ret z
	scf
	ret

; Phase 14 immediately-pre-attack decision. Same Mr. Mime / immune
; guard as Phase 13. Then deck-specific skip list ($32, $3b, $4d,
; $5d, $5e, $60, $6e, $76) and one deck ($45) with its own policy.
; Default: gates the active attack through 3 helpers
; (CheckIfAttackWontKOAlready, ScoreAttackWithPoisonDiscount,
; CheckIfDamageThresholdMetForPlusPower_Phase14). Returns carry SET
; with the active attack as the commit.
AIDecide_PlusPower_Phase14:
	ld a, DUELVARS_ARENA_CARD_SUBSTATUS1
	call GetNonTurnDuelistVariable
	cp $1b
	ret z
	farcall IsPlayerArenaCardImmune
	ccf
	ret nc
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	ld d, a
	ld a, [wSelectedAttack]
	ld e, a
	call CopyAttackDataAndDamage_FromDeckIndex
	ld a, $05
	call CheckLoadedAttackFlag
	jr c, .skip
	xor a
	ldh [hTempPlayAreaLocation_ff9d], a
	ld a, [wOpponentDeckID]
	cp GO_ARCANINE_DECK_ID
	jr z, .skip
	cp LEGENDARY_FOSSIL_DECK_ID
	jr z, .skip
	cp QUICK_ATTACK_DECK_ID
	jp z, AIDecide_PlusPower_Phase14_Deck45
	cp WATER_STREAM_DECK_ID
	jr z, .skip
	cp PSYCHIC_BATTLE_DECK_ID
	jr z, .skip
	cp STOP_LIFE_DECK_ID
	jr z, .skip
	cp TSUNAMI_STARTER_DECK_ID
	jr z, .skip
	cp EVERYBODYS_FRIEND_DECK_ID
	jr z, .skip
	cp POISON_STORM_DECK_ID
	jr z, .skip
	call CheckIfAttackWontKOAlready
	jr nc, .skip
	call ScoreAttackWithPoisonDiscount
	jr nc, .skip
	call CheckIfDamageThresholdMetForPlusPower_Phase14
	jr nc, .skip
	scf
	ret
.skip
	or a
	ret

; Phase 14 helper (duplicate of CheckIfDamageThresholdMetForPlusPower_Phase13
; -- the ROM has both copies at $4733 and $47b0).
CheckIfDamageThresholdMetForPlusPower_Phase14:
	ld a, [wDamage]
	add $0a
	cp $1e
	ret c
	call SwapTurn
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call GetCardIDFromDeckIndex
	call SwapTurn
	cp16 MR_MIME_LV28
	ret z
	scf
	ret

; Returns carry SET when our attack would NOT already KO the
; defender (so PlusPower's +10 might enable the KO). NC means the
; attack is already lethal or unusable -- don't bother boosting.
CheckIfAttackWontKOAlready:
	farcall CheckIfSelectedAttackIsUnusable
	jr c, .unusable
	ld a, [wSelectedAttack]
	farcall EstimateDamage_VersusDefendingCard
	ld a, DUELVARS_ARENA_CARD_HP
	call GetNonTurnDuelistVariable
	ld hl, wDamage
	sub [hl]
	jr c, AIDecide_PlusPower_Phase14.skip
	jr z, AIDecide_PlusPower_Phase14.skip
	scf
	ret
.unusable
	or a
	ret

; Random-gate scorer. Reads wAIMinDamage, subtracts the poison
; tick, and bails if it's still under 10. Otherwise rolls
; Random(0..9) and compares with 3 -- carry SET 30% of the time
; means commit. This is how the AI introduces randomness into its
; PlusPower commitment.
ScoreAttackWithPoisonDiscount:
	ld a, [wAIMinDamage]
	farcall DiscountPoisonFromDamage
	cp $0a
	jr c, CheckIfAttackWontKOAlready.unusable
	ld a, $0a
	call Random
	cp $03
	ret

; deck $45 (Quick Attack) Phase 14 case: only commit if our active is
; Dark Jolteon or Dark Raichu AND the standard gates pass
; (CheckIfAttackWontKOAlready + min-damage >= 10 +
; CheckIfDamageThresholdMetForPlusPower_Phase14).
AIDecide_PlusPower_Phase14_Deck45:
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call GetCardIDFromDeckIndex
	cp16 DARK_JOLTEON
	jr z, .matched
	cp16 DARK_RAICHU
	jr nz, AIDecide_PlusPower_Phase14.skip
.matched
	call CheckIfAttackWontKOAlready
	jr nc, AIDecide_PlusPower_Phase14.skip
	farcall CheckIfSelectedAttackIsUnusable
	jp c, AIDecide_PlusPower_Phase14.skip
	ld a, [wSelectedAttack]
	farcall EstimateDamage_VersusDefendingCard
	ld a, [wAIMinDamage]
	cp $0a
	jp c, AIDecide_PlusPower_Phase14.skip
	call CheckIfDamageThresholdMetForPlusPower_Phase14
	jp nc, AIDecide_PlusPower_Phase14.skip
	scf
	ret
; 0x2083d

; Shared play function for Switch (both Phase_09 and Phase_16). Sets
; AI_FLAG_USED_SWITCH so the AI doesn't try Switch again this turn,
; then clears wd032 after the trainer effect so any "pending switch
; target" flag is reset.
AIPlay_Switch:
	ld a, [wCurrentAIFlags]
	or AI_FLAG_USED_SWITCH
	ld [wCurrentAIFlags], a
	ld a, [wAITrainerCardToPlay]
	ldh [hTempCardIndex_ff9f], a
	ld a, [wAITrainerCardParameter]
	ldh [hTemp_ffa0], a
	ld a, OPPACTION_EXECUTE_TRAINER_EFFECTS
	farcall AIMakeDecision
	xor a
	ld [wd032], a
	ret

; PHASE_09 is the general "would switching the active Pokemon help
; us this turn?" decider. Two paths in: if the AI is mid-way through
; setting up the energy needed for a normal retreat
; (wAIPlayEnergyCardForRetreat != 0), Switch is only worth playing
; when retreat is still 2+ energy short. Otherwise it's only worth
; considering if wd035 is zero (no other pending action).
; The actual decision: pick Switch when the active either has a
; status condition, has retreat cost 3+, or can't currently afford
; its retreat cost. Final go/no-go runs through
; AIDecideBenchPokemonToSwitchTo, which scores bench candidates --
; if none qualifies we don't play Switch.
AIDecide_Switch_Phase09:
	ld a, [wAIPlayEnergyCardForRetreat]
	or a
	jr z, .check_wd035
	xor a ; PLAY_AREA_ARENA
	ldh [hTempPlayAreaLocation_ff9d], a
	call GetPlayAreaCardRetreatCost
	push af
	xor a
	call CreateArenaOrBenchEnergyCardList
	ld b, a
	pop af
	sub b
	jr c, .check_active
	cp $02
	jr nc, .pick_bench
	jr .check_active
.check_wd035
	farcall IswD035Zero
	ret nc
.check_active
	ld a, DUELVARS_ARENA_CARD_STATUS
	get_turn_duelist_var
	and $0f
	jr nz, .pick_bench
	xor a ; PLAY_AREA_ARENA
	ldh [hTempPlayAreaLocation_ff9d], a
	call GetPlayAreaCardRetreatCost
	cp $03
	jr nc, .pick_bench
	push af
	xor a
	call CreateArenaOrBenchEnergyCardList
	pop bc
	cp b
	jr c, .pick_bench
	ret
.pick_bench
	farcall AIDecideBenchPokemonToSwitchTo
	ccf
	ret
; 0x2089c

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
	cp GO_ARCANINE_DECK_ID
	jp z, $4902
	cp GRAND_FIRE_DECK_ID
	jp z, $493d
	cp LEGENDARY_FOSSIL_DECK_ID
	jp z, $493d
	cp GREAT_DRAGON_DECK_ID
	jp z, $494f
	cp POISON_MIST_DECK_ID
	jp z, AIDecide_Switch_Phase16_Deck5B
	cp ULTRA_REMOVAL_DECK_ID
	jp z, AIDecide_Switch_Phase16_Deck5C
	cp PSYCHIC_BATTLE_DECK_ID
	jp z, AIDecide_Switch_Phase16_Deck5D
	cp STOP_LIFE_DECK_ID
	jp z, AIDecide_Switch_Phase16_Deck5E
	cp SCORCHER_DECK_ID
	jp z, AIDecide_Switch_Phase16_Deck5F
	cp TSUNAMI_STARTER_DECK_ID
	jp z, AIDecide_Switch_Phase16_Deck60
	cp SMASH_TO_MINCEMEAT_DECK_ID
	jp z, AIDecide_Switch_Phase16_Deck61
	cp POWERFUL_POKEMON_DECK_ID
	jp z, AIDecide_Switch_Phase16_Deck66
	cp EVERYBODYS_FRIEND_DECK_ID
	jp z, AIDecide_Switch_Phase16_Deck6E
	cp IMMORTAL_POKEMON_DECK_ID
	jp z, AIDecide_Switch_Phase16_Deck6F
	cp TORRENTIAL_FLOOD_DECK_ID
	jp z, AIDecide_Switch_Phase16_Deck70
	cp BLAZING_FLAME_DECK_ID
	jp z, AIDecide_Switch_Phase16_Deck72
.skip
	or a
	ret
; 0x208fc
; (decks $32/$3a/$3b/$3d have bespoke inline sub-deciders at $4902-$49a6,
; still raw)

SECTION "Bank 8@49a7", ROMX[$49a7], BANK[$8]

; Twelve decks delegate their Phase-16 Switch decision to a per-deck AI
; helper in bank $0e/$12.
AIDecide_Switch_Phase16_Deck5B:
	farcall PoisonMistDeckAIDecideSwitch
	ret
AIDecide_Switch_Phase16_Deck5C:
	farcall UltraRemovalDeckAIDecideSwitch
	ret
AIDecide_Switch_Phase16_Deck5D:
	farcall PsychicBattleDeckAIDecideSwitch
	ret
AIDecide_Switch_Phase16_Deck5E:
	farcall StopLifeDeckAIDecideSwitch
	ret
AIDecide_Switch_Phase16_Deck5F:
	farcall ScorcherDeckAIDecideSwitch
	ret
AIDecide_Switch_Phase16_Deck60:
	farcall TsunamiStarterDeckAIDecideSwitch
	ret
AIDecide_Switch_Phase16_Deck61:
	farcall SmashToMincemeatDeckAIDecideSwitch
	ret
AIDecide_Switch_Phase16_Deck66:
	farcall PowerfulPokemonDeckAIDecideSwitch
	ret
AIDecide_Switch_Phase16_Deck6E:
	farcall EverybodysFriendDeckAIDecideSwitch
	ret
AIDecide_Switch_Phase16_Deck6F:
	farcall ImmortalPokemonDeckAIDecideSwitch
	ret
AIDecide_Switch_Phase16_Deck70:
	farcall TorrentialFloodDeckAIDecideSwitch
	ret
AIDecide_Switch_Phase16_Deck72:
	farcall BlazingFlameDeckAIDecideSwitch
	ret

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

AIPlay_EnergyRemoval:
	ld a, [wAITrainerCardToPlay]
	ldh [hTempCardIndex_ff9f], a
	ld a, [wAITrainerCardParameter]
	ldh [hTemp_ffa0], a
	ld a, [wTempAIMultiTargetCardDeckIndex1]
	ldh [hTempPlayAreaLocation_ffa1], a
	ld a, OPPACTION_EXECUTE_TRAINER_EFFECTS
	farcall AIMakeDecision
	ret

; 7 deck-specific policies, all still raw. Default: walk the
; opponent's play area looking for a Pokemon that (a) has at least
; one non-Recycle energy attached and (b) would be disabled /
; weakened if we removed one. Skip their arena and start at the bench
; if we can KO their active from hand (no point disrupting an attack
; we'll prevent anyway); otherwise start at the arena. Falls back to
; scoring bench-only candidates by estimated incoming damage.
AIDecide_EnergyRemoval:
	ld a, [wOpponentDeckID]
	cp ELECTRIC_SELFDESTRUCT_DECK_ID
	jp z, $4d6b
	cp QUICK_ATTACK_DECK_ID
	jp z, AIDecide_EnergyRemoval_Deck45Or50
	cp FIREBALL_DECK_ID
	jp z, AIDecide_EnergyRemoval_Deck47
	cp WHIRLPOOL_SHOWER_DECK_ID
	jp z, AIDecide_EnergyRemoval_Deck4A
	cp RUNNING_WILD_DECK_ID
	jp z, AIDecide_EnergyRemoval_Deck45Or50
	cp SPIRITED_AWAY_DECK_ID
	jp z, AIDecide_EnergyRemoval_Deck55
	cp BIG_THUNDER_DECK_ID
	jp z, AIDecide_EnergyRemoval_Deck74
	farcall CheckIfArenaCardCanKnockOutDefendingCard_CheckHand
	jr nc, .scan_from_arena
	ld a, $01
	ld [wTempAITargetPokemonCardDeckIndex], a
	jr .start_scan
.scan_from_arena
	xor a
	ld [wTempAITargetPokemonCardDeckIndex], a
.start_scan
	call SwapTurn
	ld a, [wTempAITargetPokemonCardDeckIndex]
	ld e, a
.scan_play_area
	ld a, DUELVARS_ARENA_CARD
	add e
	get_turn_duelist_var
	cp $ff
	jr z, .primary_scan_done
	ld d, a
	call CheckIfHasNonRecycleEnergy
	jr nc, .next_slot
	call CheckIfBothAttacksStillNeedEnergy
	jr nc, .commit
.next_slot
	inc e
	jr .scan_play_area
.commit
	ld a, e
	push af
	farcall PickAttachedEnergyCardToRemove
	ld [wTempAIMultiTargetCardDeckIndex1], a
	pop af
	call SwapTurn
	scf
	ret
.primary_scan_done
	ld a, [wTempAITargetPokemonCardDeckIndex]
	or a
	jr nz, .start_secondary_scan
; arena was skipped during the primary pass; circle back and try it now.
	call CheckIfHasNonRecycleEnergy
	jr c, .commit
.start_secondary_scan
; secondary scan: best bench target by estimated damage on us.
	xor a
	ld [wd082], a
	ld [wd084], a
	ld e, $01
.secondary_loop
	ld a, DUELVARS_ARENA_CARD
	add e
	get_turn_duelist_var
	cp $ff
	jr z, .secondary_done
	ld d, a
	call CheckIfHasNonRecycleEnergy
	jr nc, .secondary_next
	call ScoreBenchEnergyRemovalCandidate
.secondary_next
	inc e
	jr .secondary_loop
.secondary_done
	ld a, [wd084]
	or a
	jr z, .secondary_no_target
	ld e, a
	jr .commit
.secondary_no_target
	call SwapTurn
	or a
	ret

; returns carry SET if the Pokemon at deck index `d` has at least
; one energy card attached (ignoring Recycle Energy).
CheckIfHasNonRecycleEnergy:
	farcall CountNumberOfEnergyCardsAttached_IgnoreRecycleEnergy
	or a
	ret z
	scf
	ret

; returns carry SET when removing energy from the play-area slot
; in `e` would actually disrupt the target -- i.e. both of their
; attacks still need more energy, so removing one keeps them from
; firing. NC means the target's first attack is already ready
; (removing energy is a waste). When only the second attack still
; needs energy, defers to CanRemovingEnergyReduceDamage to decide
; whether removal would meaningfully cut its damage.
CheckIfBothAttacksStillNeedEnergy:
	push de
	xor a
	ld [wSelectedAttack], a
	ld a, e
	ldh [hTempPlayAreaLocation_ff9d], a
	farcall CheckEnergyNeededForAttack
	jr nc, .first_ready
	pop de
	push de
	ld a, $01
	ld [wSelectedAttack], a
	ld a, e
	ldh [hTempPlayAreaLocation_ff9d], a
	farcall CheckEnergyNeededForAttack
	jr nc, .check_reduce
	pop de
	scf
	ret
.first_ready
	pop de
	or a
	ret
.check_reduce
	farcall CanRemovingEnergyReduceDamage
	pop de
	ccf
	ret

; secondary-pass scorer: simulate damage from both attacks against
; us with the candidate at slot `e`. Track the maximum-damage
; target in wd082 (best damage so far) and wd084 (slot picked).
ScoreBenchEnergyRemovalCandidate:
	push de
	ld a, e
	ldh [hTempPlayAreaLocation_ff9d], a
	xor a
	farcall EstimateDamage_VersusDefendingCard
	ld a, [wDamage]
	or a
	jr z, .try_attack_2
	ld e, a
	ld a, [wd082]
	cp e
	jr nc, .try_attack_2
	ld a, e
	ld [wd082], a
	pop de
	ld a, e
	ld [wd084], a
	jr .check_atk2
.try_attack_2
	pop de
.check_atk2
	push de
	ld a, e
	ldh [hTempPlayAreaLocation_ff9d], a
	ld a, $01
	farcall EstimateDamage_VersusDefendingCard
	ld a, [wDamage]
	or a
	jr z, .done
	ld e, a
	ld a, [wd082]
	cp e
	jr nc, .done
	ld a, e
	ld [wd082], a
	pop de
	ld a, e
	ld [wd084], a
	ret
.done
	pop de
	ret
; 0x20d6b

SECTION "Bank 8@4de7", ROMX[$4de7], BANK[$8]

; Shared by deck $45 (Quick Attack) and deck $50 (Running Wild) -- two
; different archetypes that happen to use the same Energy Removal policy.
; First two passes: if a Double Colorless energy is attached to a
; player-area Pokemon, remove THAT one as priority -- returning the
; "should I play Energy Removal because we can KO?" flag (b) as the
; commit hint. Otherwise the policy needs us to actually be able to
; KO from hand AND the defender to have meaningful HP (more than
; double our active's current HP). Then commit a normal energy
; removal via PickAttachedEnergyCardToRemove.
AIDecide_EnergyRemoval_Deck45Or50:
	farcall CheckIfArenaCardCanKnockOutDefendingCard_CheckHand
	ld b, $01
	jr c, .check_dce
	ld b, $00
.check_dce
	farcall FindDoubleColorlessAttachedToPlayerPokemonInPlayArea
	jr c, .commit_dce
	farcall CheckIfArenaCardCanKnockOutDefendingCard_CheckHand
	jr nc, .normal_path
.skip
	or a
	ret
.normal_path
	ld e, $00
	call SwapTurn
	farcall CountNumberOfEnergyCardsAttached_IgnoreRecycleEnergy
	call SwapTurn
	or a
	ret z
	call SwapTurn
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call LoadCardDataToBuffer2_FromDeckIndex
	ld a, [wLoadedCard2HP]
	ld b, a
	ld a, DUELVARS_ARENA_CARD_HP
	get_turn_duelist_var
	call SwapTurn
	sla a
	cp b
	jr c, .skip
	call SwapTurn
	xor a
	farcall PickAttachedEnergyCardToRemove
	call SwapTurn
	ld [wTempAIMultiTargetCardDeckIndex1], a
	xor a
	scf
	ret
.commit_dce
	ld [wTempAIMultiTargetCardDeckIndex1], a
	ld a, b
	scf
	ret
; 0x20e3c

; deck $47's Energy Removal policy. Bail if we can already KO the
; defender from hand (no point disrupting attacks we'll prevent
; anyway). Bail if the defender has no non-Recycle energy. Score
; both of the defender's attacks via the helper -- attack 0 hitting
; means we want to disrupt it; attack 0 missing but attack 1 hitting
; means we'd rather NOT remove energy (leave the weaker option as
; their commitment); both attacks "safe" means we still commit.
AIDecide_EnergyRemoval_Deck47:
	farcall CheckIfArenaCardCanKnockOutDefendingCard_CheckHand
	jr nc, .check_energy
.no_play
	or a
	ret
.check_energy
	ld e, $00
	call SwapTurn
	farcall CountNumberOfEnergyCardsAttached_IgnoreRecycleEnergy
	call SwapTurn
	or a
	ret z
	xor a
	ldh [hTempPlayAreaLocation_ff9d], a
	call CheckIfEnergyRemovalDisruptsBigAttack
	jr c, .commit
	ld a, $01
	call CheckIfEnergyRemovalDisruptsBigAttack
	jr c, .no_play
.commit
	call SwapTurn
	xor a
	farcall PickAttachedEnergyCardToRemove
	call SwapTurn
	ld [wTempAIMultiTargetCardDeckIndex1], a
	xor a
	scf
	ret

; For attack `a` of the defending Pokemon: returns carry SET when
; (a) it would do 50+ damage to us AND (b) removing energy from the
; defender would actually reduce that damage. NC means either the
; attack is too weak to worry about or removal wouldn't change the
; outcome.
CheckIfEnergyRemovalDisruptsBigAttack:
	ld [wSelectedAttack], a
	call SwapTurn
	farcall EstimateDamage_VersusDefendingCard
	ld a, [wDamage]
	cp $32
	jr c, .too_weak
	farcall CanRemovingEnergyReduceDamage
	call SwapTurn
	ret
.too_weak
	call SwapTurn
	or a
	ret
; 0x20e90

; deck $4a (Whirlpool Shower) Energy Removal policy. Bail if we can KO the defender
; from hand or if the defender has no non-Recycle energy. Special
; case: if our active is Dark Vaporeon or Dark Starmie AND its
; attack 1 is usable right now, defer to attacking (return NC) --
; we'd rather hit than disrupt. Otherwise commit the removal,
; picking the energy via PickAttachedEnergyCardToRemove.
AIDecide_EnergyRemoval_Deck4A:
	farcall CheckIfArenaCardCanKnockOutDefendingCard_CheckHand
	jr nc, .check_energy
	or a
	ret
.check_energy
	ld e, $00
	call SwapTurn
	farcall CountNumberOfEnergyCardsAttached_IgnoreRecycleEnergy
	call SwapTurn
	or a
	ret z
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call GetCardIDFromDeckIndex
	cp16 DARK_VAPOREON
	jr z, .check_dark_attack
	cp16 DARK_STARMIE
	jr nz, .commit
.check_dark_attack
	xor a ; PLAY_AREA_ARENA
	ldh [hTempPlayAreaLocation_ff9d], a
	ld a, $01
	ld [wSelectedAttack], a
	farcall CheckIfSelectedAttackIsUnusable
	ret nc
.commit
	call SwapTurn
	xor a
	farcall PickAttachedEnergyCardToRemove
	call SwapTurn
	ld [wTempAIMultiTargetCardDeckIndex1], a
	xor a
	scf
	ret
; 0x20ede

; deck $55 (Spirited Away) Energy Removal policy: don't bother if we can
; already KO the defender from hand; otherwise, if the opponent's active
; has any energy, remove one.
AIDecide_EnergyRemoval_Deck55:
	farcall CheckIfArenaCardCanKnockOutDefendingCard_CheckHand
	jr nc, .consider
	or a
	ret
.consider
	ld e, $00
	call SwapTurn
	farcall CountNumberOfEnergyCardsAttached_IgnoreRecycleEnergy
	call SwapTurn
	or a
	ret z
	call SwapTurn
	xor a
	farcall PickAttachedEnergyCardToRemove
	call SwapTurn
	ld [wTempAIMultiTargetCardDeckIndex1], a
	xor a
	scf
	ret

; deck $74 (Big Thunder) Energy Removal policy: delegated to a bank-13
; helper.
AIDecide_EnergyRemoval_Deck74:
	farcall Func_4c676
	ret

; Forwards the pre-computed Super Energy Removal targets to the trainer
; effect: the target Pokemon (slot1 = its discard energy), plus the two
; energies to remove (slots 2/3) and a third in $d09a. $ffa7 = $ff caps
; the list.
AIPlay_SuperEnergyRemoval:
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
	ld a, [$d09a]
	ldh [$ffa6], a
	ld a, $ff
	ldh [$ffa7], a
	ld a, OPPACTION_EXECUTE_TRAINER_EFFECTS
	farcall AIMakeDecision
	ret

; Super Energy Removal makes us discard one of our own energies to
; remove two from a single opponent Pokemon. First find one of our own
; play-area Pokemon carrying a non-Rainbow, non-Double-Colorless energy
; we can afford to discard. Then pick the opponent Pokemon to strip: if
; we can already KO their active from hand we scan only their bench (no
; point stripping a Pokemon we'll KO anyway), otherwise their whole play
; area, preferring a target whose attack we can disrupt, and among
; multiple disruptable targets the one estimated to deal the most damage.
AIDecide_SuperEnergyRemoval:
	ld e, $01
.find_discard_loop
	ld a, DUELVARS_ARENA_CARD
	add e
	get_turn_duelist_var
	cp $ff
	jr z, .no_target
	ld d, a
	push de
	call .check_discardable_energy
	pop de
	jr c, .have_discard
	inc e
	jr .find_discard_loop
.check_discardable_energy
	ld a, e
	call CreateArenaOrBenchEnergyCardList
	ld hl, wDuelTempList
.scan_discard
	ld a, [hli]
	cp $ff
	ret z
	call GetCardIDFromDeckIndex
	cp16 RAINBOW_ENERGY
	jr z, .scan_discard
	cp16 DOUBLE_COLORLESS_ENERGY
	jr z, .scan_discard
	scf
	ret
.no_target
	or a
	ret
.have_discard
	ld a, e
	ld [wTempAITargetPokemonCardDeckIndex], a
	farcall CheckIfArenaCardCanKnockOutDefendingCard_CheckHand
	jr nc, .scan_whole_area
	call SwapTurn
	ld e, $01
	jr .scan_opp_loop
.scan_whole_area
	call SwapTurn
	ld e, $00
.scan_opp_loop
	ld a, DUELVARS_ARENA_CARD
	add e
	get_turn_duelist_var
	cp $ff
	jr z, .no_disrupt_target
	ld d, a
	call CheckIfPlayAreaCardHasTwoEnergy
	jr c, .scan_opp_next
	call CheckIfRemovingEnergyDisruptsAttack
	jr nc, .disrupt_found
.scan_opp_next
	inc e
	jr .scan_opp_loop
.disrupt_found
	ld a, e
	or a
	jr nz, .score_bench
.commit
	ld [wTempAIMultiTargetCardDeckIndex2], a
	farcall PickTwoAttachedEnergyCards
	ld [wTempAIMultiTargetCardDeckIndex3], a
	ld a, b
	ld [$d09a], a
	call SwapTurn
	ld a, [wTempAITargetPokemonCardDeckIndex]
	push af
	farcall AIPickEnergyCardToDiscard
	ld [wTempAIMultiTargetCardDeckIndex1], a
	pop af
	scf
	ret
.score_bench
	xor a
	ld [wd082], a
	ld [wd084], a
	ld e, $01
.score_loop
	ld a, DUELVARS_ARENA_CARD
	add e
	get_turn_duelist_var
	cp $ff
	jr z, .score_done
	ld d, a
	call CheckIfPlayAreaCardHasTwoEnergy
	jr c, .score_next
	call CheckIfRemovingEnergyDisruptsAttack
	jr c, .score_next
	call ScoreSuperEnergyRemovalTarget
.score_next
	inc e
	jr .score_loop
.score_done
	ld a, [wd084]
	or a
	jr z, .no_disrupt_target
	jr .commit
.no_disrupt_target
	call SwapTurn
	or a
	ret

; Returns NC if play-area Pokemon e carries at least two units of energy
; (counting the colorless-bucket byte at half weight) -- i.e. enough to
; be worth a double removal. Carry SET means too little to bother.
CheckIfPlayAreaCardHasTwoEnergy:
	call GetPlayAreaCardAttachedEnergies
	ld a, [wTotalAttachedEnergies]
	cp $02
	ret c
	xor a
	ld b, $06
	ld hl, wAttachedEnergies
.sum
	add [hl]
	inc hl
	dec b
	jr nz, .sum
	ld b, [hl]
	srl b
	add b
	cp $02
	ret

; Returns NC ("disrupts") if removing energy from play-area Pokemon e
; would stop one of its attacks: either an attack is currently usable
; (so removal denies it), or for an affordable attack removal would cut
; its damage by 2+.
CheckIfRemovingEnergyDisruptsAttack:
	push de
	xor a
	ld [wSelectedAttack], a
	ld a, e
	ldh [hTempPlayAreaLocation_ff9d], a
	farcall CheckEnergyNeededForAttack
	jr nc, .cannot_disrupt
	pop de
	push de
	ld a, $01
	ld [wSelectedAttack], a
	ld a, e
	ldh [hTempPlayAreaLocation_ff9d], a
	farcall CheckEnergyNeededForAttack
	jr nc, .attack1_check_reduce
	pop de
	scf
	ret
.cannot_disrupt
	pop de
	or a
	ret
.attack1_check_reduce
	farcall CanRemovingEnergyReduceDamage
	cp $02
	jr c, .cannot_disrupt
	pop de
	scf
	ret

; Tracks the highest single-attack damage estimate across the opponent's
; play area into wd082 (best damage) / wd084 (best slot), checking both
; attacks of play-area Pokemon e.
ScoreSuperEnergyRemovalTarget:
	push de
	ld a, e
	ldh [hTempPlayAreaLocation_ff9d], a
	xor a
	farcall EstimateDamage_VersusDefendingCard
	ld a, [wDamage]
	or a
	jr z, .attack1
	ld e, a
	ld a, [wd082]
	cp e
	jr nc, .attack1
	ld a, e
	ld [wd082], a
	pop de
	ld a, e
	ld [wd084], a
	jr .score_attack1
.attack1
	pop de
.score_attack1
	push de
	ld a, e
	ldh [hTempPlayAreaLocation_ff9d], a
	ld a, $01
	farcall EstimateDamage_VersusDefendingCard
	ld a, [wDamage]
	or a
	jr z, .done
	ld e, a
	ld a, [wd082]
	cp e
	jr nc, .done
	ld a, e
	ld [wd082], a
	pop de
	ld a, e
	ld [wd084], a
	ret
.done
	pop de
	ret
; 0x2107b

; Pokemon Breeder is a non-standard play wrapper -- the trainer card
; effect picks a Stage-2 Pokemon from hand, but only the AI knows
; the bench slot to evolve. So it runs THREE AIMakeDecision calls:
; (1) action $07 to play the Breeder card itself, (2) action $18 to
; commit the Stage-2 Pokemon, (3) action $19 to resolve the new
; Pokemon's incoming Pkmn Power. The intermediate $ff / $00 checks
; bail out cleanly if the prior step rejected the choice.
AIPlay_PokemonBreeder:
	ld a, [wAITrainerCardToPlay]
	ldh [hTempCardIndex_ff9f], a
	ld a, [wAITrainerCardParameter]
	ldh [hTempPlayAreaLocation_ffa1], a
	ld a, [wTempAIMultiTargetCardDeckIndex1]
	ldh [hTemp_ffa0], a
	ld a, OPPACTION_EXECUTE_TRAINER_EFFECTS
	farcall AIMakeDecision
	ld a, [wcd15]
	cp $ff
	ret z
	ldh [hTempCardIndex_ff9f], a
	ld [wTempAIPokemonCard], a
	ld a, [wAITrainerCardParameter]
	ldh [hTemp_ffa0], a
	ld a, $18
	farcall AIMakeDecision
	ld a, [wcd18]
	or a
	ret z
	farcall AIHandlePkmnPowersWhenPlayingPkmnFromHand
	ld a, $19
	farcall AIMakeDecision
	ret
; 0x210b6

SECTION "Bank 8@52fb", ROMX[$52fb], BANK[$8]

; deck $55 (Spirited Away) Pokemon Breeder case (reached from the still-
; raw AIDecide_PokemonBreeder dispatcher at $50b6). Breed Gastly Lv17
; ($126) straight up to Dark Gengar ($12e) when the Gastly is on the
; field carrying 2+ energy and Dark Gengar is in hand.
AIDecide_PokemonBreeder_Deck55:
	ld de, GASTLY_LV17
	ld b, $00
	farcall FindCardIDInTurnDuelistsPlayArea.loop_play_area
	ret nc
	ld [wd082], a
	ld e, a
	call GetPlayAreaCardAttachedEnergies
	ld a, [wTotalAttachedEnergies]
	cp $02
	ccf
	ret nc
	ld de, DARK_GENGAR
	farcall LookForCardIDInHandList
	ret nc
	ld [wTempAIMultiTargetCardDeckIndex1], a
	ld a, [wd082]
	scf
	ret

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
;   has Water Energy (card $03) in hand AND no active Pkmn Powers
;     on either side: +10
;   always: +10
;   has at least one Basic Pokemon in hand: -10
;   for any play-area Pokemon that has an evolution available in deck
;     but not in hand: +10 (Oak might draw it)
; Decks $11, $2d, $32, $3a, $3b, $45, $49, $4d, $50, $53, $55, $57,
; $58, $5a, $5c, $5d, $6e, $70, $71, $72 each have bespoke deciders;
; $57-$72 are thin delegates to per-deck AI helpers (decompiled just
; below), the rest are still raw hex. All decks bail out immediately if
; 54+ cards are out of the deck.
AIDecide_ProfessorOak:
	ld a, DUELVARS_NUMBER_OF_CARDS_NOT_IN_DECK
	get_turn_duelist_var
	cp $36
	ret nc
	ld a, [wOpponentDeckID]
	cp ELECTRIC_SELFDESTRUCT_DECK_ID
	jp z, $5528
	cp RAIN_DANCE_CONFUSION_DECK_ID
	jp z, $5546
	cp GO_ARCANINE_DECK_ID
	jp z, $5565
	cp GRAND_FIRE_DECK_ID
	jp z, $559c
	cp LEGENDARY_FOSSIL_DECK_ID
	jp z, $55c9
	cp QUICK_ATTACK_DECK_ID
	jp z, AIDecide_ProfessorOak_Deck45Or50
	cp GAZE_UPON_THE_POWER_OF_FIRE_DECK_ID
	jp z, AIDecide_ProfessorOak_Deck49Or4D
	cp WATER_STREAM_DECK_ID
	jp z, AIDecide_ProfessorOak_Deck49Or4D
	cp RUNNING_WILD_DECK_ID
	jp z, AIDecide_ProfessorOak_Deck45Or50
	cp BAD_DREAM_DECK_ID
	jp z, AIDecide_ProfessorOak_Deck53
	cp SPIRITED_AWAY_DECK_ID
	jp z, AIDecide_ProfessorOak_Deck55
	cp EYE_OF_THE_STORM_DECK_ID
	jp z, AIDecide_ProfessorOak_Deck57
	cp SUDDEN_GROWTH_DECK_ID
	jp z, AIDecide_ProfessorOak_Deck58
	cp BAD_GUYS_DECK_ID
	jp z, AIDecide_ProfessorOak_Deck5A
	cp ULTRA_REMOVAL_DECK_ID
	jp z, AIDecide_ProfessorOak_Deck5C
	cp PSYCHIC_BATTLE_DECK_ID
	jp z, AIDecide_ProfessorOak_Deck5D
	cp EVERYBODYS_FRIEND_DECK_ID
	jp z, AIDecide_ProfessorOak_Deck6E
	cp TORRENTIAL_FLOOD_DECK_ID
	jp z, AIDecide_ProfessorOak_Deck70
	cp TRAINER_IMPRISON_DECK_ID
	jp z, AIDecide_ProfessorOak_Deck71
	cp BLAZING_FLAME_DECK_ID
	jp z, AIDecide_ProfessorOak_Deck72
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
	ld de, MUK
	bank1call CountPokemonWithActivePkmnPowerInBothPlayAreas
	jr c, .after_pkmn_power
	ld de, BLASTOISE_LV52
	bank1call CountTurnDuelistPokemonWithActivePkmnPower
	jr nc, .after_pkmn_power
	ld de, WATER_ENERGY
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

SECTION "Bank 8@55cf", ROMX[$55cf], BANK[$8]

; Shared by decks $45 and $50: play Oak iff hand has fewer than 5
; cards.
AIDecide_ProfessorOak_Deck45Or50:
	ld a, DUELVARS_NUMBER_OF_CARDS_IN_HAND
	get_turn_duelist_var
	cp $05
	ret
; 0x215d5

; Shared by decks $49 and $4d: hand-size threshold for playing Oak
; scales with how much of the deck is gone. Early game
; (cards-out-of-deck < 36): play Oak iff hand < 5. Late game
; (cards-out >= 36): play Oak iff hand < 4 -- be stingier as the
; deck shrinks since the redraw shuffles the hand back in.
AIDecide_ProfessorOak_Deck49Or4D:
	ld a, DUELVARS_NUMBER_OF_CARDS_NOT_IN_DECK
	get_turn_duelist_var
	cp $24
	jr nc, .late_game
	ld a, DUELVARS_NUMBER_OF_CARDS_IN_HAND
	get_turn_duelist_var
	cp $05
	ret
.late_game
	ld a, DUELVARS_NUMBER_OF_CARDS_IN_HAND
	get_turn_duelist_var
	cp $04
	ret
; 0x215e8

; Deck $53 (Bad Dream): play Oak to refill a tiny hand (< 5 cards), or
; for a mid-size hand (5-10) only if we're not already holding the key
; Psychic basics (Gastly, Haunter Lv22, Drowzee) -- redrawing would risk
; shuffling those evolution starters away. Never play with 11+ cards.
AIDecide_ProfessorOak_Deck53:
	ld a, DUELVARS_NUMBER_OF_CARDS_IN_HAND
	get_turn_duelist_var
	cp $05
	ret c
	cp $0b
	ret nc
	ld de, GASTLY_LV13
	farcall LookForCardIDInHandList
	jr c, .dont_play
	ld de, HAUNTER_LV22
	farcall LookForCardIDInHandList
	jr c, .dont_play
	ld de, DROWZEE_LV10
	farcall LookForCardIDInHandList
	jr c, .dont_play
	scf
	ret
.dont_play
	or a
	ret
; 0x21610

; deck $55 (Spirited Away) Professor Oak policy: play whenever our hand
; has fewer than 8 cards (carry set), so we redraw a full 7 once we've
; spent down.
AIDecide_ProfessorOak_Deck55:
	ld a, DUELVARS_NUMBER_OF_CARDS_IN_HAND
	get_turn_duelist_var
	cp $08
	ret

; Nine decks delegate their Professor Oak decision to a bespoke per-deck
; AI helper in bank $0e/$12 (deck $5d's is still raw, Func_4c4ba).
AIDecide_ProfessorOak_Deck57:
	farcall ColorlessAltarAIDecideProfessorOak
	ret
AIDecide_ProfessorOak_Deck58:
	farcall SuddenGrowthDeckAIDecideItemFinder_TargetProfessorOak
	ret
AIDecide_ProfessorOak_Deck5A:
	farcall BadGuysDeckAIDecideProfessorOak
	ret
AIDecide_ProfessorOak_Deck5C:
	farcall UltraRemovalDeckAIDecideProfessorOak
	ret
AIDecide_ProfessorOak_Deck5D:
	farcall Func_4c4ba
	ret
AIDecide_ProfessorOak_Deck6E:
	farcall EverybodysFriendDeckAIDecideProfessorOak
	ret
AIDecide_ProfessorOak_Deck70:
	farcall TorrentialFloodDeckAIDecideProfessorOak
	ret
AIDecide_ProfessorOak_Deck71:
	farcall TrainerImprisonDeckAIDecideProfessorOak
	ret
AIDecide_ProfessorOak_Deck72:
	farcall BlazingFlameDeckAIDecideProfessorOak
	ret

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
;           sole caller (AIDecide_ProfessorOak) uses this to choose between
;           the Pokemon-target and non-Pokemon-target AI flags.
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

; Dispatcher for the Energy Retrieval decide pass. Reads the opponent's
; deck ID and routes to a per-deck handler when it matches one of 22
; tuned cases; otherwise falls through to the general gate which only
; proceeds when the hand still has at least one basic-energy card to
; discard as fuel.
AIDecide_EnergyRetrieval:
	ld a, [wOpponentDeckID]
	cp ELECTRIC_SELFDESTRUCT_DECK_ID
	jp z, $57c8
	cp MAX_ENERGY_DECK_ID
	jp z, $57d2
	cp RAIN_DANCE_CONFUSION_DECK_ID
	jp z, $581d
	cp ELECTRIC_CURRENT_SHOCK_DECK_ID
	jp z, $589d
	cp STICKY_POISON_GAS_DECK_ID
	jp z, $58cf
	cp EEVEE_SHOWDOWN_DECK_ID
	jp z, $5937
	cp WHIRLPOOL_SHOWER_DECK_ID
	jp z, $5969
	cp PARALYZED_PARALYZED_DECK_ID
	jp z, $5969
	cp BENCH_CALL_DECK_ID
	jp z, $599b
	cp FULL_STRENGTH_DECK_ID
	jp z, $59cd
	cp EYE_OF_THE_STORM_DECK_ID
	jp z, AIDecide_EnergyRetrieval_Deck57
	cp BAD_GUYS_DECK_ID
	jp z, $5a10
	cp PSYCHIC_BATTLE_DECK_ID
	jp z, AIDecide_EnergyRetrieval_Deck5D
	cp SCORCHER_DECK_ID
	jp z, AIDecide_EnergyRetrieval_Deck5F
	cp PROTOHISTORIC_DECK_ID
	jp z, $5a2b
	cp TEXTURE_TUNER7_DECK_ID
	jp z, $5a34
	cp RONALDS_PSYCHIC_DECK_ID
	jp z, AIDecide_EnergyRetrieval_Deck6C
	cp TORRENTIAL_FLOOD_DECK_ID
	jp z, $5a5c
	cp BLAZING_FLAME_DECK_ID
	jp z, $5a70
	cp DAMAGE_CHAOS_DECK_ID
	jp z, $5a75
	cp BIG_THUNDER_DECK_ID
	jp z, $5a7e
	cp POWER_OF_DARKNESS_DECK_ID
	jp z, $5a83
.default
	farcall CountBasicEnergyCardsInHand
	ret nc
	; the hand still has a basic energy to discard as fuel — now choose
	; which Pokemon to recharge and which discarded energies to pull.
	; Default target is a duplicated Pokemon in hand; a few decks instead
	; reuse the pre-tagged non-Pokemon AI target.
	call CreateHandCardList
	ld hl, wDuelTempList
	farcall FindDuplicateCards_IgnoreTrainerCardToPlay
	jp c, .no_targets
	push af
	ld a, [wOpponentDeckID]
	cp PHANTOM_DECK_ID
	jr z, .use_tagged_target
	cp SKILLED_WARRIOR_DECK_ID
	jr z, .use_tagged_target
	cp GO_ARCANINE_DECK_ID
	jr z, .use_tagged_target
	cp DANGEROUS_BENCH_DECK_ID
	jp z, $591a
	cp THIS_IS_THE_POWER_OF_ELECTRICITY_DECK_ID
	jp z, $592c
	cp QUICK_ATTACK_DECK_ID
	jp z, $592c
	cp DIRECT_HIT_DECK_ID
	jr z, .use_tagged_target
	cp TEST_YOUR_LUCK_DECK_ID
	jp z, $592c
	cp EVERYBODYS_FRIEND_DECK_ID
	jp z, $591a
	jr .got_target
.use_tagged_target
	ld a, [wTempAITargetNonPokemonCardDeckIndex]
	cp $ff
	jr z, .got_target
	pop af
	ld a, [wTempAITargetNonPokemonCardDeckIndex]
	push af
.got_target
	pop af
	ld [wd082], a
	ld a, CARD_LOCATION_DISCARD_PILE
	farcall CreateBasicEnergyCardListInLocation
	jp c, .no_targets
	ld a, $ff
	ld [wTempAIMultiTargetCardDeckIndex1], a
	ld [wTempAIMultiTargetCardDeckIndex2], a
	ld [wTempAIMultiTargetCardDeckIndex3], a
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	ld d, a
	ld e, $00
.play_area_loop
	push de
	ld a, e
	farcall Func_4b3d8
	pop de
	jr c, .next_play_area
	ld a, DUELVARS_ARENA_CARD
	add e
	push de
	get_turn_duelist_var
	call LoadCardDataToBuffer1_FromDeckIndex
	pop de
	ld a, [wLoadedCard1ID]
	ld [wTempCardID_d0a3], a
	ld a, [$cc3b]
	ld [wTempCardID_d0a3 + 1], a
	ld a, [wLoadedCard1Type]
	or TYPE_ENERGY
	ld [wTempCardType], a
	ld hl, wDuelTempList
.energy_loop
	ld a, [hli]
	cp $ff
	jr z, .next_play_area
	ld b, a
	push hl
	farcall CheckIfEnergyIsUseful
	pop hl
	jr nc, .energy_loop
	ld a, [wTempAIMultiTargetCardDeckIndex1]
	cp $ff
	jr nz, .second_slot
	ld a, b
	ld [wTempAIMultiTargetCardDeckIndex1], a
	call RemoveCardFromListAtHL
	jr .next_play_area
.second_slot
	ld a, b
	ld [wTempAIMultiTargetCardDeckIndex2], a
	jr .success
.next_play_area
	inc e
	dec d
	jr nz, .play_area_loop
	; play area exhausted — top off any unused slot from the energy list
	ld hl, wDuelTempList
.fill_remaining
	ld a, [hli]
	cp $ff
	jr z, .check_found
	ld b, a
	ld a, [wTempAIMultiTargetCardDeckIndex1]
	cp $ff
	jr nz, .fill_second
	ld a, b
	ld [wTempAIMultiTargetCardDeckIndex1], a
	call RemoveCardFromListAtHL
	jr .fill_remaining
.fill_second
	ld a, b
	ld [wTempAIMultiTargetCardDeckIndex2], a
	jr .success
.check_found
	ld a, [wTempAIMultiTargetCardDeckIndex1]
	cp $ff
	jr nz, .success
.no_targets
	or a
	ret
.success
	ld a, [wd082]
	scf
	ret
; 0x217c8

SECTION "Bank 8@5a0b", ROMX[$5a0b], BANK[$8]

; deck $57 (Eye of the Storm) Energy Retrieval: bank-$0e delegate. (One
; of AIDecide_EnergyRetrieval's many deck cases carved out of the
; otherwise-still-raw $57c8-$5a8c block.)
AIDecide_EnergyRetrieval_Deck57:
	farcall EyeOfTheStormDeckAIDecideEnergyRetrieval
	ret

SECTION "Bank 8@5a19", ROMX[$5a19], BANK[$8]

; deck $5d (Psychic Battle) Energy Retrieval: a bank-$13 helper (Func_4c524,
; still raw) picks the target; on success rejoin AIDecide_EnergyRetrieval's
; shared commit tail (.got_target). Also carved out of the still-raw
; $57c8-$5a8c block.
AIDecide_EnergyRetrieval_Deck5D:
	farcall Func_4c524
	ret nc
	push af
	jp AIDecide_EnergyRetrieval.got_target

SECTION "Bank 8@5a22", ROMX[$5a22], BANK[$8]

; deck $5f (internal ScorcherDeck -- a Fire deck built around Dark
; Charizard) Energy Retrieval: a bank-$12 helper picks the target; on
; success rejoin the shared commit tail (.got_target). Also carved out
; of the still-raw $57c8-$5a8c block.
AIDecide_EnergyRetrieval_Deck5F:
	farcall ScorcherDeckAIDecideEnergyRetrieval
	ret nc
	push af
	jp AIDecide_EnergyRetrieval.got_target

SECTION "Bank 8@5a53", ROMX[$5a53], BANK[$8]

; deck $6c (Ronald's Super) Energy Retrieval: a bank-$12 helper picks
; the target; on success rejoin AIDecide_EnergyRetrieval's shared
; commit tail (.got_target).
AIDecide_EnergyRetrieval_Deck6C:
	farcall RonaldsPsychicDeckAIDecideEnergyRetrieval
	ret nc
	push af
	jp AIDecide_EnergyRetrieval.got_target

SECTION "Bank 8@5a8c", ROMX[$5a8c], BANK[$8]

; Removes the list entry just consumed from an $ff-terminated byte list.
; On entry hl points one past that entry (i.e. the caller just did
; `ld a, [hli]`); the remainder of the list is shifted down one byte to
; overwrite it. hl ends at the deleted slot (now the next entry) and de
; is preserved. Used by AIDecide_EnergyRetrieval and ITEMFINDER to drop
; a card from wDuelTempList once it has been assigned to a target slot.
RemoveCardFromListAtHL:
	push de
	ld d, h
	ld e, l
	dec hl
	push hl
.loop
	ld a, [de]
	ld [hli], a
	cp $ff
	jr z, .done
	inc de
	jr .loop
.done
	pop hl
	pop de
	ret
; 0x21a9d

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

SECTION "Bank 8@5c4e", ROMX[$5c4e], BANK[$8]

; Removes the first entry equal to A from the $ff-terminated list at hl,
; shifting the remainder down (via RemoveCardFromListAtHL). hl is
; preserved. Used by the Item Finder decider to drop the Item Finder
; card itself (and other unwanted IDs) from the working hand list.
RemoveCardFromListByValue:
	push hl
	ld b, a
.find
	ld a, [hli]
	cp b
	jr nz, .find
	call RemoveCardFromListAtHL
	pop hl
	ret

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
	cp VERY_RARE_CARD_DECK_ID
	jr z, .deck_59_or_68
	cp WEIRD_DECK_ID
	jr z, .play
	cp STRANGE_DECK_ID
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

AIPlay_EnergySearch:
	ld a, [wAITrainerCardToPlay]
	ldh [hTempCardIndex_ff9f], a
	ld a, [wAITrainerCardParameter]
	ldh [hTemp_ffa0], a
	ld a, OPPACTION_EXECUTE_TRAINER_EFFECTS
	farcall AIMakeDecision
	ret

; Decks $09 and $0b each pick between two specific basic-energy types
; (whichever the AI has fewer of in hand). Decks $0d and $66 dispatch
; to bespoke policies. Default path: see if any basic / Recycle Energy
; in the hand would already be useful to someone in the play area; if
; so, fetching another from the deck is fair game. If the hand has
; nothing useful, fall back to picking the first useful basic energy
; in the deck. Returns NC if there's no good pick.
AIDecide_EnergySearch:
	ld a, [wOpponentDeckID]
	cp AARONS_STEP1_DECK_ID
	jr z, .deck_09_fighting_or_grass
	cp AARONS_STEP2_DECK_ID
	jr z, .deck_0b_psychic_or_grass
	cp AARONS_STEP3_DECK_ID
	jp z, AIDecide_EnergySearch_Deck0D
	cp POWERFUL_POKEMON_DECK_ID
	jp z, AIDecide_EnergySearch_Deck66
	farcall CreateEnergyCardListFromHand_OnlyBasicOrRecycleEnergy
	jr c, .check_deck
	call LookForEnergyUsefulToPlayArea
	jr c, .check_deck
.skip
	or a
	ret
.check_deck
	ld a, CARD_LOCATION_DECK
	farcall CreateBasicEnergyCardListInLocation
	jr c, .skip
	call LookForEnergyUsefulToPlayArea
	jr c, .pick_first_in_list
	scf
	ret
.pick_first_in_list
	ld a, [wDuelTempList]
	scf
	ret

; deck $09: pick whichever the AI has less of in hand (Fighting vs Grass).
.deck_09_fighting_or_grass
	ld de, FIGHTING_ENERGY
	farcall CountCardIDInHand
	push af
	ld de, GRASS_ENERGY
	farcall CountCardIDInHand
	pop bc
	cp b
	jr c, .pick_grass
	ld de, FIGHTING_ENERGY
	jr .pick_in_deck
.pick_grass
	ld de, GRASS_ENERGY
.pick_in_deck
	ld a, CARD_LOCATION_DECK
	farcall FindCardIDInLocation
	ret

; deck $0b: pick whichever the AI has less of in hand (Psychic vs Grass).
.deck_0b_psychic_or_grass
	ld de, PSYCHIC_ENERGY
	farcall CountCardIDInHand
	push af
	ld de, GRASS_ENERGY
	farcall CountCardIDInHand
	pop bc
	cp b
	jr c, .pick_grass
	ld de, PSYCHIC_ENERGY
	jr .pick_in_deck

; Unreferenced in bank $08; preserved here so the section produces
; the same bytes as the baserom. May be called from another bank
; via a jump table or function pointer.
AIDecide_EnergySearch_GrassOnly:
	ld de, GRASS_ENERGY
	ld a, CARD_LOCATION_DECK
	farcall FindCardIDInLocation
	ret

; deck $0d: always grab Psychic.
AIDecide_EnergySearch_Deck0D:
	ld de, PSYCHIC_ENERGY
	ld a, CARD_LOCATION_DECK
	farcall FindCardIDInLocation
	ret

; deck $66: delegate to the Powerful Pokemon deck's bespoke policy
; in bank $12.
AIDecide_EnergySearch_Deck66:
	farcall PowerfulPokemonDeckAIDecideEnergySearch
	ret

; Iterates the turn duelist's play-area Pokemon; for each, loads its
; card data and scans wDuelTempList (basic-or-Recycle energies the
; caller produced) for one that's "useful" to this Pokemon via
; CheckIfEnergyIsUseful. Returns NC + `a` = the useful energy's deck
; index on the first match. Returns carry SET if the list was
; exhausted without finding a useful target on any play-area Pokemon.
LookForEnergyUsefulToPlayArea:
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	ld d, a
	ld e, $00
.next_pokemon
	push de
	ld a, e
	farcall Func_4b3d8
	pop de
	jr c, .advance
	ld a, DUELVARS_ARENA_CARD
	add e
	push de
	get_turn_duelist_var
	call LoadCardDataToBuffer1_FromDeckIndex
	pop de
	ld a, [wLoadedCard1ID]
	ld [wTempCardID_d0a3], a
	ld a, [$cc3b]
	ld [$d0a4], a
	ld a, [wLoadedCard1Type]
	or $08
	ld [wTempCardType], a
	ld hl, wDuelTempList
.scan_list
	ld a, [hli]
	cp $ff
	jr z, .list_exhausted
	ld b, a
	farcall CheckIfEnergyIsUseful
	jr nc, .scan_list
	ld a, b
	or a
	ret
.list_exhausted
	scf
	ret
.advance
	inc e
	ld a, e
	cp d
	jr nz, .next_pokemon
	or a
	ret
; 0x21e0e

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
	cp BAD_DREAM_DECK_ID
	jp z, AIDecide_FullHeal_Deck53
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
	ld de, GASTLY_LV8
	ld b, $00
	call SwapTurn
	farcall FindCardIDInTurnDuelistsPlayArea.loop_play_area
	call SwapTurn
	jr c, .play
	ld de, GASTLY_LV17
	ld b, $00
	call SwapTurn
	farcall FindCardIDInTurnDuelistsPlayArea.loop_play_area
	call SwapTurn
	jr c, .play
	ld de, HAUNTER_LV22
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
	ld de, SCOOP_UP
	farcall LookForCardIDInHandList
	jr nc, .full_heal_check_damage
	call AIDecide_ScoopUp
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
	ld de, SCOOP_UP
	farcall LookForCardIDInHandList
	jr nc, .confused_check_damage
	call AIDecide_ScoopUp
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

; Deck $53 (Bad Dream): when the defending Pokemon is Asleep -- which
; this sleep-lock deck engineers on purpose -- only Full Heal ourselves
; if we actually carry a status worth clearing. When the defender isn't
; asleep, decline (jump straight to AIDecide_FullHeal.no_play).
AIDecide_FullHeal_Deck53:
	ld a, DUELVARS_ARENA_CARD_STATUS
	call GetNonTurnDuelistVariable
	and CNF_SLP_PRZ
	cp ASLEEP
	jr nz, AIDecide_FullHeal.no_play
	ld a, DUELVARS_ARENA_CARD_STATUS
	get_turn_duelist_var
	or a
	jp nz, AIDecide_FullHeal.play
	ret
; 0x2203e

AIPlay_MrFuji:
	ld a, [wAITrainerCardToPlay]
	ldh [hTempCardIndex_ff9f], a
	ld a, [wAITrainerCardParameter]
	ldh [hTemp_ffa0], a
	ld a, OPPACTION_EXECUTE_TRAINER_EFFECTS
	farcall AIMakeDecision
	ret

; Mr. Fuji shuffles our active or bench Pokemon (plus its cards)
; back into our deck. The AI uses it to retire weak benched Pokemon.
; Two deck-specific cases ($4d, $6d); default scans the bench
; (skipping arena) for the Pokemon whose damage-vs-HP ratio is
; lowest (i.e. heaviest damage relative to max HP). Only commits if
; that minimum ratio is under $14 quanta of CalculateBDividedByA's
; scale -- otherwise the candidate isn't damaged enough to bother.
AIDecide_MrFuji:
	ld a, [wOpponentDeckID]
	cp WATER_STREAM_DECK_ID
	jp z, AIDecide_MrFuji_Deck4D
	cp RONALDS_ULTRA_DECK_ID
	jp z, AIDecide_MrFuji_Deck6D
.default_scan
	ld a, $ff
	ld [wd082], a
	ld [wd084], a
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	cp $01
	ret z
	dec a
	ld d, a
	ld e, $01
.scan_loop
	ld a, DUELVARS_ARENA_CARD
	add e
	get_turn_duelist_var
	call LoadCardDataToBuffer1_FromDeckIndex
	ld a, [wLoadedCard1HP]
	ld b, a
	call GetCardDamageAndMaxHP
	farcall ConvertHPToCounters
	or a
	jr z, .next
	call CalculateBDividedByA_Bank08
	cp $14
	jr nc, .next
	ld hl, wd084
	cp [hl]
	jr nc, .next
	ld [hl], a
	ld a, e
	ld [wd082], a
.next
	inc e
	dec d
	jr nz, .scan_loop
	ld a, [wd082]
	cp $ff
	ret z
	scf
	ret

; deck $4d: walk the bench, return the slot of the first Pokemon
; that has energy attached AND HP < $15 (21). I.e., "rescue a
; powered-up Pokemon that's about to die".
AIDecide_MrFuji_Deck4D:
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	or a
	ret z
	ld d, a
	ld e, $01
.deck_4d_loop
	call GetPlayAreaCardAttachedEnergies
	ld a, [wTotalAttachedEnergies]
	or a
	jr z, .deck_4d_next
	ld a, e
	add DUELVARS_ARENA_CARD_HP
	get_turn_duelist_var
	cp $15
	jr nc, .deck_4d_next
	ld a, e
	scf
	ret
.deck_4d_next
	inc e
	ld a, e
	cp d
	jr nz, .deck_4d_loop
	or a
	ret

; deck $6d: only consider Mr. Fuji when cards-out-of-deck >= $29
; AND our play area is full (5). Then runs the default scoring
; logic via .default_scan above.
AIDecide_MrFuji_Deck6D:
	ld a, DUELVARS_NUMBER_OF_CARDS_NOT_IN_DECK
	get_turn_duelist_var
	cp $29
	jr nc, .deck_6d_check_full
.deck_6d_skip
	or a
	ret
.deck_6d_check_full
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	cp $05
	jr c, .deck_6d_skip
	jp AIDecide_MrFuji.default_scan
; 0x220d7

AIPlay_ScoopUp:
	ld a, [wAITrainerCardToPlay]
	ldh [hTempCardIndex_ff9f], a
	ld a, [wAITrainerCardParameter]
	ldh [hTemp_ffa0], a
	ld a, [wTempAIMultiTargetCardDeckIndex1]
	ldh [hTempPlayAreaLocation_ffa1], a
	ld a, OPPACTION_EXECUTE_TRAINER_EFFECTS
	farcall AIMakeDecision
	ret

; Bails out immediately if we have fewer than two Pokemon in the play
; area (no bench means nothing to scoop into). 8 deck IDs have
; bespoke policies (one of them, deck $3c, is inline as .deck_3c);
; the default policy says: only scoop if the arena can't already KO
; the defender from hand, is in a bad spot (POISONED or status type
; $02/$03 -- ASLEEP/PARALYZED), or can't afford its retreat cost.
; If those gates pass, evaluate via a damage-taken / HP-counters
; ratio and only commit when a suitable bench replacement scores
; well in AIDecideBenchPokemonToSwitchTo.
;
; Also called as a standalone heuristic from AIDecide_FullHeal --
; FullHeal asks "would the Scoop Up decider fire here?" and if so
; defers to it instead of healing.
AIDecide_ScoopUp:
	xor a ; PLAY_AREA_ARENA
	ldh [hTempPlayAreaLocation_ff9d], a
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	cp $02
	jr c, .no_play
	ld a, [wOpponentDeckID]
	cp PSYCHIC_ELITE_DECK_ID
	jp z, $61e2
	cp RAGING_BILLOW_OF_FISTS_DECK_ID
	jp z, $61e7
	cp GRAND_FIRE_DECK_ID
	jp z, $6201
	cp WATER_LEGEND_DECK_ID
	jr z, .deck_3c
	cp FIREBALL_DECK_ID
	jp z, AIDecide_ScoopUp_Deck47
	cp TEXTURE_TUNER7_DECK_ID
	jp z, $6228
	cp EVERYBODYS_FRIEND_DECK_ID
	jp z, $6241
	cp BIG_THUNDER_DECK_ID
	jp z, $6246
; default policy:
	farcall CheckIfArenaCardCanKnockOutDefendingCard_CheckHand
	jr c, .no_play
	ld a, DUELVARS_ARENA_CARD_STATUS
	get_turn_duelist_var
	push af
	and $80
	pop bc
	ld a, b
	jr nz, .evaluate
	and $0f
	cp PARALYZED
	jr z, .evaluate
	cp ASLEEP
	jr z, .evaluate
	xor a ; PLAY_AREA_ARENA
	ldh [hTempPlayAreaLocation_ff9d], a
	call GetPlayAreaCardRetreatCost
	ld b, a
	xor a
	push bc
	call CreateArenaOrBenchEnergyCardList
	pop bc
	cp b
	jr c, .evaluate
.no_play
	or a
	ret
.evaluate
; score the active by damage taken / HP counters. If the ratio is at
; least 7 (out of CalculateBDividedByA_Bank08's quantization), the
; active is too damaged to be worth retreating -- commit to scooping.
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call LoadCardDataToBuffer1_FromDeckIndex
	ld a, [wLoadedCard1HP]
	farcall ConvertHPToCounters
	ld d, a
	ld e, $00
	call GetCardDamageAndMaxHP
	or a
	jr z, .no_play
	ld b, a
	ld a, d
	call CalculateBDividedByA_Bank08
	cp $07
	jr c, .no_play
.pick_bench
	farcall AIDecideBenchPokemonToSwitchTo
	jr c, .no_play
	ld [wTempAIMultiTargetCardDeckIndex1], a
	xor a
	scf
	ret

; deck $3c: only scoop with 3+ Pokemon in play. If card $b9 is in
; the play area, fall through to a Snorlax-Lv20-defender check;
; otherwise require the active to be Articuno Lv37 or Chansey Lv40
; plus a "can't KO but can be KO'd" situation, then commit via the
; normal pick-bench path.
.deck_3c
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	cp $03
	jr c, .no_play
	ld de, ARTICUNO_LV37
	ld b, $01
	farcall FindCardIDInTurnDuelistsPlayArea.loop_play_area
	jr c, .deck_3c_card_b9
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call GetCardIDFromDeckIndex
	cp16 ARTICUNO_LV37
	jr z, .deck_3c_check_threat
	cp16 CHANSEY_LV40
	jr nz, .no_play
.deck_3c_check_threat
	farcall CheckIfArenaCardCanKnockOutDefendingCard_CheckHand
	jr c, .no_play
	farcall CheckIfDefendingPokemonCanKnockOut
	jr nc, .no_play
	jr .pick_bench
.deck_3c_card_b9
; if defender is Snorlax Lv20 skip; otherwise require energy ready
; so the scoop has follow-up value, then commit with $ff as the
; target deck index (let the trainer effect pick the bench slot).
	push af
	ld a, DUELVARS_ARENA_CARD
	call GetNonTurnDuelistVariable
	call SwapTurn
	call GetCardIDFromDeckIndex
	call SwapTurn
	cp16 SNORLAX_LV20
	pop bc
	jp z, .no_play
	ld a, b
	push af
	call CreateArenaOrBenchEnergyCardList
	pop bc
	ld a, b
	jr c, .deck_3c_play
	jp .no_play
.deck_3c_play
	push af
	ld a, $ff
	ld [wTempAIMultiTargetCardDeckIndex1], a
	pop af
	scf
	ret
; 0x221e2

SECTION "Bank 8@620f", ROMX[$620f], BANK[$8]

; deck $47's Scoop Up policy: find the play-area card with the
; lowest remaining HP (returns slot in `e`, remaining HP in `d`).
; If d >= $15 (21 HP), it's not desperate enough to scoop.
; If the candidate is a bench slot (e != 0), commit (carry SET).
; If the candidate is the arena, defer to the shared
; AIDecide_ScoopUp paths -- skip if we can already KO from hand,
; otherwise jump to its bench-picker.
AIDecide_ScoopUp_Deck47:
	xor a
	farcall FindPlayAreaCardWithLeastRemainingHP
	ret nc
	ld e, a
	ld a, d
	cp $15
	ret nc
	ld a, e
	or a
	scf
	ret nz
	farcall CheckIfArenaCardCanKnockOutDefendingCard_CheckHand
	jp c, AIDecide_ScoopUp.no_play
	jp AIDecide_ScoopUp.pick_bench
; 0x22228

SECTION "Bank 8@6373", ROMX[$6373], BANK[$8]

; Itemfinder discards two trainer cards from hand to recover one
; from the discard. The play wrapper sets AI_FLAG_MODIFIED_HAND
; (since hand contents change) and forwards three slots: the two
; cards to discard (wTempAIMultiTargetCardDeckIndex1/2) and the
; recovery target via wAITrainerCardParameter.
AIPlay_ItemFinder:
	ld a, [wCurrentAIFlags]
	or AI_FLAG_MODIFIED_HAND
	ld [wCurrentAIFlags], a
	ld a, [wAITrainerCardToPlay]
	ldh [hTempCardIndex_ff9f], a
	ld a, [wTempAIMultiTargetCardDeckIndex1]
	ldh [hTemp_ffa0], a
	ld a, [wTempAIMultiTargetCardDeckIndex2]
	ldh [hTempPlayAreaLocation_ffa1], a
	ld a, [wAITrainerCardParameter]
	ldh [hTempRetreatCostCards], a
	ld a, OPPACTION_EXECUTE_TRAINER_EFFECTS
	farcall AIMakeDecision
	ret

; Item Finder decider. Seven decks have bespoke policies; the default
; only fires if Energy Removal ($18b) is sitting in our discard to fetch
; back. It then builds a hand list, drops Mr. Mime and Pokemon Trader
; (cards we don't want to discard as the Item Finder cost), and uses the
; first two duplicate cards in hand as the two discard targets.
AIDecide_ItemFinder:
	ld a, [wOpponentDeckID]
	cp PUPPET_MASTER_DECK_ID
	jp z, $6421
	cp AWESOME_FOSSIL_DECK_ID
	jp z, $6475
	cp RUNNING_WILD_DECK_ID
	jp z, $64c2
	cp SPIRITED_AWAY_DECK_ID
	jp z, AIDecide_ItemFinder_Deck55
	cp SNORLAX_GUARD_DECK_ID
	jp z, AIDecide_ItemFinder_Deck56
	cp SUDDEN_GROWTH_DECK_ID
	jp z, AIDecide_ItemFinder_Deck58
	cp EVERYBODYS_FRIEND_DECK_ID
	jp z, AIDecide_ItemFinder_Deck6E
	ld de, ENERGY_REMOVAL
	ld a, CARD_LOCATION_DISCARD_PILE
	farcall FindCardIDInLocation
	jr nc, .no_play
	ld [wd082], a
	call CreateHandCardList
	ld hl, wDuelTempList
.scan_hand
	ld a, [hli]
	cp $ff
	jr z, .pick_discards
	ld b, a
	call GetCardIDFromDeckIndex
	cp16 MR_MIME_LV28
	jr nz, .check_trader
	call RemoveCardFromListAtHL
	jr .scan_hand
.check_trader
	cp16 POKEMON_TRADER
	jr nz, .scan_hand
	call RemoveCardFromListAtHL
	jr .scan_hand
.pick_discards
	ld hl, wDuelTempList
	ld a, [wAITrainerCardToPlay]
	call RemoveCardFromListByValue
	farcall FindDuplicateCards_IgnoreTrainerCardToPlay
	jp c, .no_play
	ld [wTempAIMultiTargetCardDeckIndex1], a
	ld hl, wDuelTempList
	call RemoveCardFromListByValue
	farcall FindDuplicateCards_IgnoreTrainerCardToPlay
	jp c, .no_play
	ld [wTempAIMultiTargetCardDeckIndex2], a
	ld a, [wd082]
	scf
	ret
.no_play
	or a
	ret

SECTION "Bank 8@6542", ROMX[$6542], BANK[$8]

; deck $55 (Spirited Away) Item Finder policy: fetch the most valuable
; trainer sitting in the discard, scanning in priority order -- Super
; Energy Removal, Energy Removal, Bill, Energy Retrieval, Professor Oak,
; Pokemon Breeder, Computer Search. Only commits if we still have 3+
; basic energies in hand to pay (discard) for the Item Finder, using the
; first two hand-list entries as the discard cost.
AIDecide_ItemFinder_Deck55:
	ld de, SUPER_ENERGY_REMOVAL
	ld a, CARD_LOCATION_DISCARD_PILE
	farcall FindCardIDInLocation
	jr c, .found
	ld de, ENERGY_REMOVAL
	ld a, CARD_LOCATION_DISCARD_PILE
	farcall FindCardIDInLocation
	jr c, .found
	ld de, BILL
	ld a, CARD_LOCATION_DISCARD_PILE
	farcall FindCardIDInLocation
	jr c, .found
	ld de, ENERGY_RETRIEVAL
	ld a, CARD_LOCATION_DISCARD_PILE
	farcall FindCardIDInLocation
	jr c, .found
	ld de, PROFESSOR_OAK
	ld a, CARD_LOCATION_DISCARD_PILE
	farcall FindCardIDInLocation
	jr c, .found
	ld de, POKEMON_BREEDER
	ld a, CARD_LOCATION_DISCARD_PILE
	farcall FindCardIDInLocation
	jr c, .found
	ld de, COMPUTER_SEARCH
	ld a, CARD_LOCATION_DISCARD_PILE
	farcall FindCardIDInLocation
	jr c, .found
.no_play
	or a
	ret
.found
	ld [wd082], a
	farcall CountBasicEnergyCardsInHand
	cp $03
	jr c, .no_play
	ld a, [wDuelTempList]
	ld [wTempAIMultiTargetCardDeckIndex1], a
	ld a, [wDuelTempList + 1]
	ld [wTempAIMultiTargetCardDeckIndex2], a
	ld a, [wd082]
	scf
	ret

; deck $56 (Snorlax Guard) Item Finder policy. Only worth it if there's a
; high-value trainer to recover -- require Super Energy Removal, Energy
; Removal, or Switch sitting in the discard. Then pick the two discard-cost
; cards from duplicates in hand, scanning a priority list of cards this
; deck is happy to pitch (its own Pokemon plus filler trainers). The first
; two duplicates found become the discard targets; StoreItemFinderDiscardTarget
; commits (carry SET) the moment the second one is collected.
AIDecide_ItemFinder_Deck56:
	ld de, SUPER_ENERGY_REMOVAL
	ld a, CARD_LOCATION_DISCARD_PILE
	farcall FindCardIDInLocation
	jr c, .found
	ld de, ENERGY_REMOVAL
	ld a, CARD_LOCATION_DISCARD_PILE
	farcall FindCardIDInLocation
	jr c, .found
	ld de, SWITCH
	ld a, CARD_LOCATION_DISCARD_PILE
	farcall FindCardIDInLocation
	jr nc, .no_play
.found
	ld [wd082], a
	ld a, $ff
	ld [wTempAIMultiTargetCardDeckIndex1], a
	ld [wTempAIMultiTargetCardDeckIndex2], a
	ld de, SWITCH
	farcall CheckIfHandHasRepeatedCard
	call c, StoreItemFinderDiscardTarget
	ld de, SCOOP_UP
	farcall CheckIfHandHasRepeatedCard
	call c, StoreItemFinderDiscardTarget
	ld de, PLUSPOWER
	farcall CheckIfHandHasRepeatedCard
	call c, StoreItemFinderDiscardTarget
	ld de, BILLS_TELEPORTER
	farcall CheckIfHandHasRepeatedCard
	call c, StoreItemFinderDiscardTarget
	ld de, LICKITUNG_LV26
	farcall CheckIfHandHasRepeatedCard
	call c, StoreItemFinderDiscardTarget
	ld de, CHANSEY_LV55
	farcall CheckIfHandHasRepeatedCard
	call c, StoreItemFinderDiscardTarget
	ld de, KANGASKHAN_LV40
	farcall CheckIfHandHasRepeatedCard
	call c, StoreItemFinderDiscardTarget
	ld de, SNORLAX_LV35
	farcall CheckIfHandHasRepeatedCard
	call c, StoreItemFinderDiscardTarget
.no_play
	or a
	ret

; deck $58 (Sudden Growth) delegates Item Finder to a bespoke bank-$12 helper.
AIDecide_ItemFinder_Deck58:
	farcall SuddenGrowthDeckAIDecideItemFinder
	ret

; deck $6e (Everybody's Friend) delegates Item Finder to a bespoke bank-$12 helper.
AIDecide_ItemFinder_Deck6E:
	farcall EverybodysFriendDeckAIDecideItemFinder
	ret

; Records a discard-cost target (deck index in `a`) for the deck-$56 Item
; Finder. Fills wTempAIMultiTargetCardDeckIndex1 first; once that slot is
; taken, fills slot 2 and unwinds the caller's stack frame (`add sp, $02`)
; so AIDecide_ItemFinder_Deck56 returns immediately with carry SET -- two
; discard targets are enough, no need to scan the rest of the list.
StoreItemFinderDiscardTarget:
	push af
	ld a, [wTempAIMultiTargetCardDeckIndex1]
	cp $ff
	jr nz, .slot1_taken
	pop af
	ld [wTempAIMultiTargetCardDeckIndex1], a
	ret
.slot1_taken
	pop af
	ld [wTempAIMultiTargetCardDeckIndex2], a
	add sp, $02
	ld a, [wd082]
	scf
	ret

AIPlay_ImakuniCard:
	ld a, [wAITrainerCardToPlay]
	ldh [hTempCardIndex_ff9f], a
	ld a, OPPACTION_EXECUTE_TRAINER_EFFECTS
	farcall AIMakeDecision
	ret

; Imakuni's Card confuses our OWN active. The AI plays it when (a)
; our active doesn't already have a status condition (no point
; overwriting), or (b) we're deck $50 (Running Wild) and the
; confusion is desirable -- but only if our Dark Primeape has 2+
; energy attached (so its "Fury Swipes" benefits) and isn't
; already confused.
AIDecide_ImakuniCard:
	ld a, [wOpponentDeckID]
	cp RUNNING_WILD_DECK_ID
	jr z, .deck_50_dark_primeape
	ld a, DUELVARS_ARENA_CARD_STATUS
	get_turn_duelist_var
	and $0f
	cp CONFUSED
	jr z, .skip
	scf
	ret
.skip
	or a
	ret
.deck_50_dark_primeape
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call GetCardIDFromDeckIndex
	cp16 DARK_PRIMEAPE
	jr nz, .skip
	ld e, $00 ; PLAY_AREA_ARENA
	call GetPlayAreaCardAttachedEnergies
	ld a, [wTotalAttachedEnergies]
	cp $02
	jr c, .skip
	ld a, DUELVARS_ARENA_CARD_STATUS
	get_turn_duelist_var
	and $0f
	cp CONFUSED
	jr z, .skip
	scf
	ret
; 0x22694

; The AI cheats at Gambler: stash wRNGVars, force every byte to $50 so
; the coin flip and shuffle land on a known outcome, play the card, then
; restore the original RNG state. Three deck IDs ($29, $65, $67) opt out
; of the rigging and just play it honestly.
AIPlay_Gambler:
	ld a, [wCurrentAIFlags]
	or AI_FLAG_MODIFIED_HAND
	ld [wCurrentAIFlags], a
	ld a, [wOpponentDeckID]
	cp DARK_SCIENCE_DECK_ID
	jr z, .play_honestly
	cp COLORLESS_ENERGY_DECK_ID
	jr z, .play_honestly
	cp WEIRD_DECK_ID
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
	cp DARK_SCIENCE_DECK_ID
	jr z, .deck_29
	cp COLORLESS_ENERGY_DECK_ID
	jr z, .deck_65
	cp WEIRD_DECK_ID
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

AIPlay_Revive:
	ld a, [wAITrainerCardToPlay]
	ldh [hTempCardIndex_ff9f], a
	ld a, [wAITrainerCardParameter]
	ldh [hTemp_ffa0], a
	ld a, OPPACTION_EXECUTE_TRAINER_EFFECTS
	farcall AIMakeDecision
	ret

; Don't play if the discard pile is empty or if we already have 4+
; Pokemon in the play area. Two decks ($14 and $40) have bespoke
; "which card to revive" policies; the default policy walks the
; discard pile looking for Hitmonchan Lv33, Hitmonlee Lv30, Tauros
; Lv32, or Kangaskhan Lv40 in priority order.
AIDecide_Revive:
	bank1call CreateDiscardPileCardList
	jr c, .no_play
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	cp $04
	jr c, .check_deck
.no_play
	or a
	ret
.check_deck
	ld a, [wOpponentDeckID]
	cp I_LOVE_PIKACHU_DECK_ID
	jp z, AIDecide_Revive_Deck14
	cp STICKY_POISON_GAS_DECK_ID
	jp z, AIDecide_Revive_Deck40
	ld hl, wDuelTempList
.scan
	ld a, [hli]
	cp $ff
	jr z, .no_play
	ld b, a
	call GetCardIDFromDeckIndex
	cp16 HITMONCHAN_LV33
	jr z, .pick
	cp16 HITMONLEE_LV30
	jr z, .pick
	cp16 TAUROS_LV32
	jr nz, .scan
	cp16 KANGASKHAN_LV40
	jr z, .pick
.pick
	ld a, b
	scf
	ret

; deck $14: delegate to a still-raw helper with parameter $02.
AIDecide_Revive_Deck14:
	ld a, $02
	call $6ca2
	ret

; deck $40: first try card $5a in the discard pile. Otherwise look
; for three specific "card-in-hand + matching-card-in-discard" pairs:
; ($47 hand, $49 discard), ($4d hand, $52 discard), ($20 hand, $23
; discard).
AIDecide_Revive_Deck40:
	ld de, CHARMANDER_LV10
	ld a, CARD_LOCATION_DISCARD_PILE
	farcall FindCardIDInLocation
	ret c
	ld de, GRIMER_LV10
	ld bc, MUK
	farcall LookForCardIDInDiscardPile_GivenCardIDInHand
	ret c
	ld de, KOFFING_LV12
	ld bc, DARK_WEEZING
	farcall LookForCardIDInDiscardPile_GivenCardIDInHand
	ret c
	ld de, EKANS_LV15
	ld bc, DARK_ARBOK
	farcall LookForCardIDInDiscardPile_GivenCardIDInHand
	ret
; 0x227af

AIPlay_PokemonFlute:
	ld a, [wAITrainerCardToPlay]
	ldh [hTempCardIndex_ff9f], a
	ld a, [wAITrainerCardParameter]
	ldh [hTemp_ffa0], a
	ld a, OPPACTION_EXECUTE_TRAINER_EFFECTS
	farcall AIMakeDecision
	ret

; Pokemon Flute brings a basic Pokemon from the *opponent's* discard
; pile to their bench. The AI's angle: dump a *weak* basic on their
; bench so they have to babysit it. Bail if their discard is empty
; or their bench is full.
;
; Two deck-specific cases: deck $67 always picks any basic via the
; .pick_any_basic loop; deck $68 first checks for our card $133 on
; our play area that can attack -- if so, drop a basic, otherwise
; skip.
;
; Default policy: walk the opponent's discard pile tracking the
; LOWEST-HP basic Pokemon (wd082 = best HP, wd084 = slot). Commit
; only if the minimum HP is under $32 (50) -- otherwise the dumped
; Pokemon would be too useful to them.
AIDecide_PokemonFlute:
	call SwapTurn
	bank1call CreateDiscardPileCardList
	call SwapTurn
	jr c, .skip
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	call GetNonTurnDuelistVariable
	ld hl, wMaxNumPlayAreaPokemon
	cp [hl]
	jr nc, .skip
	ld a, [wOpponentDeckID]
	ld a, [wOpponentDeckID]
	cp WEIRD_DECK_ID
	jr z, .pick_any_basic
	cp STRANGE_DECK_ID
	jr z, .deck_68
	ld a, $ff
	ld [wd082], a
	ld [wd084], a
	ld hl, wDuelTempList
.scan_min_hp
	ld a, [hli]
	cp $ff
	jr z, .check_min_hp
	ld b, a
	call SwapTurn
	call LoadCardDataToBuffer1_FromDeckIndex
	call SwapTurn
	ld a, [wLoadedCard1Type]
	cp $08
	jr nc, .scan_min_hp
	ld a, [wLoadedCard1Stage]
	or a
	jr nz, .scan_min_hp
	ld a, [wLoadedCard1HP]
	push hl
	ld hl, wd082
	cp [hl]
	pop hl
	jr nc, .scan_min_hp
	ld [wd082], a
	ld a, b
	ld [wd084], a
	jr .scan_min_hp
.check_min_hp
	ld a, [wd082]
	cp $32
	jr nc, .skip
	ld a, [wd084]
	scf
	ret
.skip
	or a
	ret
.deck_68
	ld de, DARK_HYPNO
	farcall CheckCardIDInPlayAreaThatCanUseAttacks
	jr nc, .skip
.pick_any_basic
	ld hl, wDuelTempList
.pick_loop
	ld a, [hli]
	cp $ff
	jr z, .skip
	ld b, a
	call SwapTurn
	call LoadCardDataToBuffer1_FromDeckIndex
	call SwapTurn
	ld a, [wLoadedCard1Type]
	cp $08
	jr nc, .pick_loop
	ld a, [wLoadedCard1Stage]
	or a
	jr nz, .pick_loop
	ld a, b
	scf
	ret
; 0x22858

SECTION "Bank 8@68b7", ROMX[$68b7], BANK[$8]

; Poké Ball is a coin-flip card: heads → search the deck for a basic
; Pokemon, tails → nothing happens. The AI tosses the coin first so
; it knows the outcome before committing the target — on heads it
; forwards the pre-picked target via wAITrainerCardParameter; on
; tails it forwards $ff so AIMakeDecision treats it as "no target".
AIPlay_Pokeball:
	ld a, [wAITrainerCardToPlay]
	ldh [hTempCardIndex_ff9f], a
	ld de, $10e ; coin-toss prompt text ID (not a card ID)
	bank1call TossCoin
	ldh [hTemp_ffa0], a
	jr nc, .tails
	ld a, [wAITrainerCardParameter]
	ldh [hTempPlayAreaLocation_ffa1], a
	jr .commit
.tails
	ld a, $ff
	ldh [hTempPlayAreaLocation_ffa1], a
.commit
	ld a, OPPACTION_EXECUTE_TRAINER_EFFECTS
	farcall AIMakeDecision
	ret

; Pure dispatcher: 13 deck-specific policies, default returns NC.
AIDecide_Pokeball:
	ld a, [wOpponentDeckID]
	cp GRAND_FIRE_DECK_ID
	jp z, $691e
	cp TRIPLE_ZAPDOS_DECK_ID
	jp z, $6965
	cp I_LOVE_PIKACHU_DECK_ID
	jp z, $699f
	cp MAX_ENERGY_DECK_ID
	jp z, $69b5
	cp REMAINING_GREEN_DECK_ID
	jp z, AIDecide_Pokeball_Deck25
	cp GATHERING_NIDORAN_DECK_ID
	jp z, $6a68
	cp BUG_COLLECTING_DECK_ID
	jp z, $6b02
	cp COMPLETE_COMBUSTION_DECK_ID
	jp z, $6b2e
	cp FIREBALL_DECK_ID
	jp z, AIDecide_Pokeball_Deck47
	cp WHIRLPOOL_SHOWER_DECK_ID
	jp z, AIDecide_Pokeball_Deck4A
	cp PARALYZED_PARALYZED_DECK_ID
	jp z, AIDecide_Pokeball_Deck4B
	cp ROCK_BLAST_DECK_ID
	jp z, AIDecide_Pokeball_Deck4E
	cp BAD_DREAM_DECK_ID
	jp z, AIDecide_Pokeball_Deck53
	or a
	ret
; 0x2291e

SECTION "Bank 8@6a59", ROMX[$6a59], BANK[$8]

; Deck $25's Poké Ball policy: don't play if our play area is already
; full (6 Pokemon); otherwise search the deck for any basic Pokemon
; and return its result (carry SET + deck index in `a` on success).
AIDecide_Pokeball_Deck25:
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	cp $06
	jr c, .has_room
	or a
	ret
.has_room
	farcall CheckIfAnyBasicPokemonInDeck
	ld a, e
	ret
; 0x22a68

SECTION "Bank 8@6b60", ROMX[$6b60], BANK[$8]

; deck $47's Poké Ball policy. If we have only one Pokemon left in
; play, scramble: search the deck for any of card IDs $59, $7f, $f3,
; $168 (basic Pokemon options). Otherwise walk a two-stage evolution
; chain ($59 -> $5d -> $60) by checking both "evo is in deck" and
; "preevo is in deck given evo is in hand".
AIDecide_Pokeball_Deck47:
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	cp $01
	jr nz, .evolution_chain
	ld de, CHARMANDER_LV9
	ld a, CARD_LOCATION_DECK
	farcall FindCardIDInLocation
	ret c
	ld de, SQUIRTLE_LV16
	ld a, CARD_LOCATION_DECK
	farcall FindCardIDInLocation
	ret c
	ld de, MACHOP_LV24
	ld a, CARD_LOCATION_DECK
	farcall FindCardIDInLocation
	ret c
	ld de, DODUO_LV10
	ld a, CARD_LOCATION_DECK
	farcall FindCardIDInLocation
	ret
.evolution_chain
	ld bc, CHARMANDER_LV9
	ld de, DARK_CHARMELEON
	farcall LookForEvoCardInDeck_GivenPreevoInHandOrPlayArea
	ret c
	ld bc, DARK_CHARMELEON
	ld de, DARK_CHARIZARD
	farcall LookForEvoCardInDeck_GivenPreevoInHandOrPlayArea
	ret c
	ld de, CHARMANDER_LV9
	ld bc, DARK_CHARMELEON
	farcall LookForCardIDInDeck_GivenCardIDInHand
	ret c
	ld de, DARK_CHARMELEON
	ld bc, DARK_CHARIZARD
	farcall LookForCardIDInDeck_GivenCardIDInHand
	ret
; 0x22bbb

; deck $4a's Poké Ball policy. Two paths based on play-area count.
;
; Solo: priority fetch card $a4, then swap $176-in-hand for
; $b1-in-deck, then swap $d3-in-hand for $d6-in-deck.
; Multi: walk evolution chain $176 -> $b1, fall back to $176-in-
; hand-for-$b1-in-deck swap.
AIDecide_Pokeball_Deck4A:
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	cp $01
	jr nz, .multi
	ld de, STARYU_LV15
	ld a, CARD_LOCATION_DECK
	farcall FindCardIDInLocation
	ret c
	ld de, EEVEE_LV9
	ld bc, DARK_VAPOREON
	farcall LookForCardIDInDeck_GivenCardIDInHand
	ret c
	ld de, VOLTORB_LV10
	ld bc, ELECTRODE_LV42
	farcall LookForCardIDInDeck_GivenCardIDInHand
	ret
.multi
	ld bc, EEVEE_LV9
	ld de, DARK_VAPOREON
	farcall LookForEvoCardInDeck_GivenPreevoInHandOrPlayArea
	ret c
	ld de, EEVEE_LV9
	ld bc, DARK_VAPOREON
	farcall LookForCardIDInDeck_GivenCardIDInHand
	ret
; 0x22bf8

; deck $4b's Poké Ball policy. Same shape as deck $4a -- solo path
; priority-fetches a single card then tries two in-hand-for-in-deck
; swap pairs; multi path walks an evolution chain with the swap as
; fallback.
;
; Solo: fetch card $8c, then $7c-for-$81 swap, then $a8-for-$ac.
; Multi: $a8 -> $ac evolution chain, fall back to $a8-for-$ac swap.
AIDecide_Pokeball_Deck4B:
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	cp $01
	jr nz, .multi
	ld de, POLIWAG_LV15
	ld a, CARD_LOCATION_DECK
	farcall FindCardIDInLocation
	ret c
	ld de, SQUIRTLE_LV8
	ld bc, WARTORTLE_LV24
	farcall LookForCardIDInDeck_GivenCardIDInHand
	ret c
	ld de, MAGIKARP_LV6
	ld bc, DARK_GYARADOS
	farcall LookForCardIDInDeck_GivenCardIDInHand
	ret
.multi
	ld bc, MAGIKARP_LV6
	ld de, DARK_GYARADOS
	farcall LookForEvoCardInDeck_GivenPreevoInHandOrPlayArea
	ret c
	ld de, MAGIKARP_LV6
	ld bc, DARK_GYARADOS
	farcall LookForCardIDInDeck_GivenCardIDInHand
	ret
; 0x22c35

; deck $4e's Poké Ball policy: walk three evolution chains
; ($fc -> $fe, $fe -> $101, $e7 -> $eb), then fall back to any basic
; Pokemon in the deck.
AIDecide_Pokeball_Deck4E:
	ld bc, GEODUDE_LV16
	ld de, GRAVELER_LV28
	farcall LookForEvoCardInDeck_GivenPreevoInHandOrPlayArea
	ret c
	ld bc, GRAVELER_LV28
	ld de, GOLEM_LV37
	farcall LookForEvoCardInDeck_GivenPreevoInHandOrPlayArea
	ret c
	ld bc, DIGLETT_LV15
	ld de, DARK_DUGTRIO
	farcall CheckReelInEvoLineTarget
	ret c
	farcall CheckIfAnyBasicPokemonInDeck
	ld a, e
	ret
; 0x22c5c

; Deck $53 (Bad Dream): search the deck for any of the deck's Pokemon
; line -- Haunter Lv22/Lv17, Drowzee, Kangaskhan, Gastly, Gengar, Dark
; Hypno -- returning the first one found (carry SET) so Poké Ball can
; fetch it.
AIDecide_Pokeball_Deck53:
	ld de, HAUNTER_LV22
	ld a, CARD_LOCATION_DECK
	farcall FindCardIDInLocation
	ret c
	ld de, HAUNTER_LV17
	ld a, CARD_LOCATION_DECK
	farcall FindCardIDInLocation
	ret c
	ld de, DROWZEE_LV10
	ld a, CARD_LOCATION_DECK
	farcall FindCardIDInLocation
	ret c
	ld de, KANGASKHAN_LV40
	ld a, CARD_LOCATION_DECK
	farcall FindCardIDInLocation
	ret c
	ld de, GASTLY_LV13
	ld a, CARD_LOCATION_DECK
	farcall FindCardIDInLocation
	ret c
	ld de, GENGAR_LV40
	ld a, CARD_LOCATION_DECK
	farcall FindCardIDInLocation
	ret c
	ld de, DARK_HYPNO
	ld a, CARD_LOCATION_DECK
	farcall FindCardIDInLocation
	ret
; 0x22ca2

SECTION "Bank 8@6cfd", ROMX[$6cfd], BANK[$8]

; Forwards the two pre-chosen discard targets to Computer Search's
; trainer effect.
AIPlay_ComputerSearch:
	ld a, [wCurrentAIFlags]
	or AI_FLAG_MODIFIED_HAND
	ld [wCurrentAIFlags], a
	ld a, [wAITrainerCardToPlay]
	ldh [hTempCardIndex_ff9f], a
	ld a, [wAITrainerCardParameter]
	ldh [hTempRetreatCostCards], a
	ld a, [wTempAIMultiTargetCardDeckIndex1]
	ldh [hTemp_ffa0], a
	ld a, [wTempAIMultiTargetCardDeckIndex2]
	ldh [hTempPlayAreaLocation_ffa1], a
	ld a, OPPACTION_EXECUTE_TRAINER_EFFECTS
	farcall AIMakeDecision
	ret

; Computer Search dispatcher: never play with fewer than 3 cards in hand
; (it discards two as its cost). Nine decks have bespoke policies; every
; other deck declines.
AIDecide_ComputerSearch:
	ld a, DUELVARS_NUMBER_OF_CARDS_IN_HAND
	get_turn_duelist_var
	cp $03
	jr c, .no_play
	ld a, [wOpponentDeckID]
	cp RAIN_DANCE_CONFUSION_DECK_ID
	jp z, $6d59
	cp LEGENDARY_FOSSIL_DECK_ID
	jp z, $6d5e
	cp MAD_PETALS_DECK_ID
	jp z, $6dbe
	cp SPIRITED_AWAY_DECK_ID
	jp z, AIDecide_ComputerSearch_Deck55
	cp EYE_OF_THE_STORM_DECK_ID
	jp z, AIDecide_ComputerSearch_Deck57
	cp SUDDEN_GROWTH_DECK_ID
	jp z, AIDecide_ComputerSearch_Deck58
	cp EVERYBODYS_FRIEND_DECK_ID
	jp z, AIDecide_ComputerSearch_Deck6E
	cp IMMORTAL_POKEMON_DECK_ID
	jp z, AIDecide_ComputerSearch_Deck6F
	cp TORRENTIAL_FLOOD_DECK_ID
	jp z, AIDecide_ComputerSearch_Deck70
.no_play
	or a
	ret

SECTION "Bank 8@6e0a", ROMX[$6e0a], BANK[$8]

; deck $55 (Spirited Away) Computer Search policy: delegated to a bank-13
; helper.
AIDecide_ComputerSearch_Deck55:
	farcall SpiritedAwayDeckAIDecideComputerSearch
	ret

; Five more decks delegate Computer Search to a per-deck AI helper in
; bank $0e/$12.
AIDecide_ComputerSearch_Deck57:
	farcall EyeOfTheStormDeckAIDecideComputerSearch
	ret
AIDecide_ComputerSearch_Deck58:
	farcall SuddenGrowthDeckAIDecideComputerSearch
	ret
AIDecide_ComputerSearch_Deck6E:
	farcall EverybodysFriendDeckAIDecideComputerSearch
	ret
AIDecide_ComputerSearch_Deck6F:
	farcall ImmortalPokemonDeckAIDecideComputerSearch
	ret
AIDecide_ComputerSearch_Deck70:
	farcall TorrentialFloodDeckAIDecideComputerSearch
	ret

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
	cp PSYCHIC_ELITE_DECK_ID
	jp z, $6eca
	cp PSYCHOKINESIS_DECK_ID
	jp z, AIDecide_PokemonTrader_Deck18
	cp GATHERING_NIDORAN_DECK_ID
	jp z, $6f88
	cp RAIN_DANCE_CONFUSION_DECK_ID
	jp z, $7040
	cp GO_ARCANINE_DECK_ID
	jp z, $70a7
	cp MAD_PETALS_DECK_ID
	jp z, AIDecide_PokemonTrader_Deck41
	cp DANGEROUS_BENCH_DECK_ID
	jp z, $71d9
	cp EEVEE_SHOWDOWN_DECK_ID
	jp z, AIDecide_PokemonTrader_Deck48
	cp GAZE_UPON_THE_POWER_OF_FIRE_DECK_ID
	jp z, AIDecide_PokemonTrader_Deck49
	cp BENCH_CALL_DECK_ID
	jp z, AIDecide_PokemonTrader_Deck4C
	cp WATER_STREAM_DECK_ID
	jp z, AIDecide_PokemonTrader_Deck4D
	cp FULL_STRENGTH_DECK_ID
	jp z, AIDecide_PokemonTrader_Deck4F
	cp DIRECT_HIT_DECK_ID
	jp z, AIDecide_PokemonTrader_Deck51
	cp BAD_GUYS_DECK_ID
	jp z, AIDecide_PokemonTrader_Deck5A
	cp POISON_MIST_DECK_ID
	jp z, AIDecide_PokemonTrader_Deck5B
	cp ULTRA_REMOVAL_DECK_ID
	jp z, AIDecide_PokemonTrader_Deck5C
	cp COLORLESS_ENERGY_DECK_ID
	jp z, AIDecide_PokemonTrader_Deck65
	cp RONALDS_PSYCHIC_DECK_ID
	jp z, AIDecide_PokemonTrader_Deck6C
	cp RONALDS_ULTRA_DECK_ID
	jp z, AIDecide_PokemonTrader_Deck6D
	cp IMMORTAL_POKEMON_DECK_ID
	jp z, AIDecide_PokemonTrader_Deck6F
	cp TORRENTIAL_FLOOD_DECK_ID
	jp z, AIDecide_PokemonTrader_Deck70
	cp TRAINER_IMPRISON_DECK_ID
	jp z, AIDecide_PokemonTrader_Deck71
	cp BLAZING_FLAME_DECK_ID
	jp z, AIDecide_PokemonTrader_Deck72
	cp DAMAGE_CHAOS_DECK_ID
	jp z, AIDecide_PokemonTrader_Deck73
	cp BIG_THUNDER_DECK_ID
	jp z, AIDecide_PokemonTrader_Deck74
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
	ld bc, ABRA_LV8
	ld de, KADABRA_LV39
	farcall LookForEvoCardInDeck_GivenPreevoInHandOrPlayArea
	jr c, .pick
	ld bc, KADABRA_LV39
	ld de, ALAKAZAM_LV45
	farcall LookForEvoCardInDeck_GivenPreevoInHandOrPlayArea
	jr c, .pick
	ld de, ABRA_LV8
	ld bc, KADABRA_LV39
	farcall LookForCardIDInDeck_GivenCardIDInHand
	jr c, .pick
	ld de, KADABRA_LV39
	ld bc, ALAKAZAM_LV45
	farcall LookForCardIDInDeck_GivenCardIDInHand
	jr c, .pick
	ld bc, GASTLY_LV13
	ld de, HAUNTER_LV26
	farcall LookForEvoCardInDeck_GivenPreevoInHandOrPlayArea
	jr c, .pick
	ld bc, HAUNTER_LV26
	ld de, GENGAR_LV40
	farcall LookForEvoCardInDeck_GivenPreevoInHandOrPlayArea
	jr c, .pick
	ld de, GASTLY_LV13
	ld bc, HAUNTER_LV26
	farcall LookForCardIDInDeck_GivenCardIDInHand
	jr c, .pick
	ld de, HAUNTER_LV26
	ld bc, GENGAR_LV40
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

SECTION "Bank 8@71d4", ROMX[$71d4], BANK[$8]

; deck $41 ("Mad Petals") delegates Pokemon Trader entirely to a
; bespoke bank-$12 helper.
AIDecide_PokemonTrader_Deck41:
	farcall MadPetalsDeckAIDecidePokemonTrader
	ret
; 0x231d9

SECTION "Bank 8@71fc", ROMX[$71fc], BANK[$8]

; deck $48's Pokemon Trader policy. Splits on (a) whether we have
; only one Pokemon in play and (b) whether the opponent has a
; Water-type Pokemon out (Water-type matchup changes our target
; priority).
;
; With one Pokemon in play AND no Water threat: try to fetch card
; $75 from the deck directly, falling back to swapping card $176
; in hand for card $78 in deck.
; With one Pokemon in play AND a Water threat: same shape but the
; targets become $da and $176/$dd.
; With multi Pokemon AND no Water threat: walk evolution chain
; $176 -> $78, falling back to $176 in-hand-given-$78-in-deck.
; With multi Pokemon AND a Water threat: same shape but pivoting
; through $dd instead of $78.
;
; Any successful target is stored to wTempAIMultiTargetCardDeckIndex1,
; then FindDifferentPokemonCardInHand picks the swap partner.
AIDecide_PokemonTrader_Deck48:
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	cp $01
	jr nz, .multi_pokemon
	ld a, $03
	farcall CheckIfPlayerHasPokemonOfType
	jr c, .single_water_threat
	ld a, CARD_LOCATION_DECK
	ld de, MAGMAR_LV31
	farcall FindCardIDInLocation
	ld de, MAGMAR_LV31
	jr c, .commit
	jr .single_no_threat_fallback
.single_water_threat
	ld de, ELECTABUZZ_LV35
	farcall FindCardIDInLocation
	ld de, ELECTABUZZ_LV35
	jr c, .commit
	jr .single_water_threat_fallback
.multi_pokemon
	ld a, $03
	farcall CheckIfPlayerHasPokemonOfType
	jr c, .multi_water_threat
	ld bc, EEVEE_LV9
	ld de, DARK_FLAREON
	farcall LookForEvoCardInDeck_GivenPreevoInHandOrPlayArea
	jr c, .commit
	jr .single_no_threat_fallback
.multi_water_threat
	ld bc, EEVEE_LV9
	ld de, DARK_JOLTEON
	farcall LookForEvoCardInDeck_GivenPreevoInHandOrPlayArea
	jr c, .commit
	jr .single_water_threat_fallback
.single_no_threat_fallback
	ld de, EEVEE_LV9
	ld bc, DARK_FLAREON
	farcall LookForCardIDInDeck_GivenCardIDInHand
	ld de, DARK_FLAREON
	jp c, .commit
	ret
.single_water_threat_fallback
	ld de, EEVEE_LV9
	ld bc, DARK_JOLTEON
	farcall LookForCardIDInDeck_GivenCardIDInHand
	ld de, DARK_JOLTEON
	ret nc
.commit
	ld [wTempAIMultiTargetCardDeckIndex1], a
	farcall FindDifferentPokemonCardInHand
	ret
; 0x23274

; deck $49's Pokemon Trader policy. Two paths based on whether we
; have only one Pokemon in play.
;
; Multi-Pokemon: walk the evolution chain (preevo $61 -> evo $65)
; in deck, fall back to swap $61-in-hand for $65-in-deck.
; Solo: try fetching specific cards from the deck in order:
; $75, $59, $61, $6c. Any hit commits.
;
; Hits store the deck index to wTempAIMultiTargetCardDeckIndex1,
; then FindDifferentPokemonCardInHand picks the swap partner.
AIDecide_PokemonTrader_Deck49:
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	cp $01
	jr z, .solo
	ld bc, VULPIX_LV11
	ld de, DARK_NINETALES
	farcall LookForEvoCardInDeck_GivenPreevoInHandOrPlayArea
	jr c, .commit
	ld de, VULPIX_LV11
	ld bc, DARK_NINETALES
	farcall LookForCardIDInDeck_GivenCardIDInHand
	ld de, DARK_NINETALES
	jp c, .commit
	ret
.solo
	ld a, $00
	ld de, MAGMAR_LV31
	farcall IsCardIDInDeckAndNotInHand
	ld de, MAGMAR_LV31
	jr c, .commit
	ld a, $00
	ld de, CHARMANDER_LV9
	farcall IsCardIDInDeckAndNotInHand
	ld de, CHARMANDER_LV9
	jr c, .commit
	ld a, $00
	ld de, VULPIX_LV11
	farcall IsCardIDInDeckAndNotInHand
	ld de, VULPIX_LV11
	jr c, .commit
	ld a, $00
	ld de, PONYTA_LV8
	farcall IsCardIDInDeckAndNotInHand
	ld de, PONYTA_LV8
	ret nc
.commit
	ld [wTempAIMultiTargetCardDeckIndex1], a
	farcall FindDifferentPokemonCardInHand
	ret
; 0x232d7

; deck $4c only plays Pokemon Trader when the opponent's arena
; Pokemon is Water type. Then priority-fetches card $136, $173,
; $c3, or $c4 from the deck.
AIDecide_PokemonTrader_Deck4C:
	call SwapTurn
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call LoadCardDataToBuffer2_FromDeckIndex
	call SwapTurn
	ld a, [wLoadedCard2Type]
	cp $02
	jr z, .water_matchup
	or a
	ret
.water_matchup
	ld a, CARD_LOCATION_DECK
	ld de, JYNX_LV18
	farcall FindCardIDInLocation
	ld de, JYNX_LV18
	jr c, .commit
	ld a, CARD_LOCATION_DECK
	ld de, TAUROS_LV35
	farcall FindCardIDInLocation
	ld de, TAUROS_LV35
	jr c, .commit
	ld de, SURFING_PIKACHU_LV13
	farcall FindCardIDInLocation
	ld de, SURFING_PIKACHU_LV13
	jr c, .commit
	ld de, SURFING_PIKACHU_ALT_LV13
	farcall FindCardIDInLocation
	ld de, SURFING_PIKACHU_ALT_LV13
	ret nc
.commit
	ld [wTempAIMultiTargetCardDeckIndex1], a
	farcall FindDifferentPokemonCardInHand
	ret
; 0x23327

; deck $4d's Pokemon Trader: 3-way split on play-area-count x
; opponent-Water-type. Solo path priority-fetches single cards.
; Multi+no-Water walks $a4 -> $a7 evolution chain with swap
; fallback. Multi+Water tries a single in-deck-not-in-hand check
; for card $b7 (likely the deck's Water-counter target).
AIDecide_PokemonTrader_Deck4D:
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	cp $01
	jr z, .solo
	ld a, $02
	farcall CheckIfPlayerHasPokemonOfType
	jr c, .multi_water
	ld bc, STARYU_LV15
	ld de, DARK_STARMIE
	farcall LookForEvoCardInDeck_GivenPreevoInHandOrPlayArea
	jr c, .commit
	ld de, STARYU_LV15
	ld bc, DARK_STARMIE
	farcall LookForCardIDInDeck_GivenCardIDInHand
	ld de, DARK_STARMIE
	jr c, .commit
	ret
.multi_water
	ld de, ARTICUNO_LV34
	farcall IsCardIDInDeckAndNotInHandOrPlayArea
	ld de, ARTICUNO_LV34
	jr c, .commit
	ret
.solo
	ld a, CARD_LOCATION_DECK
	ld de, LAPRAS_LV31
	farcall FindCardIDInLocation
	ld de, LAPRAS_LV31
	jr c, .commit
	ld a, CARD_LOCATION_DECK
	ld de, ARTICUNO_LV34
	farcall FindCardIDInLocation
	ld de, ARTICUNO_LV34
	jr c, .commit
	ld a, CARD_LOCATION_DECK
	ld de, STARYU_LV15
	farcall FindCardIDInLocation
	ld de, STARYU_LV15
	jr c, .commit
	ld a, CARD_LOCATION_DECK
	ld de, GOLDEEN
	farcall FindCardIDInLocation
	ld de, GOLDEEN
	ret nc
.commit
	ld [wTempAIMultiTargetCardDeckIndex1], a
	farcall FindDifferentPokemonCardInHand
	ret
; 0x2339e

; deck $4f's Pokemon Trader policy. Solo path priority-fetches
; card $103 from the deck. Multi path walks the $f3 -> $f7 -> $fa
; 3-stage evolution chain, falling back to the chain swap.
AIDecide_PokemonTrader_Deck4F:
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	cp $01
	jr nz, .multi
	ld a, CARD_LOCATION_DECK
	ld de, ONIX_LV25
	farcall FindCardIDInLocation
	ld de, ONIX_LV25
	jr c, .commit
.multi
	ld de, MACHOP_LV24
	ld bc, DARK_MACHOKE
	farcall LookForCardIDInDeck_GivenCardIDInHand
	ld de, DARK_MACHOKE
	jr c, .commit
	ld de, DARK_MACHOKE
	ld bc, DARK_MACHAMP
	farcall LookForCardIDInDeck_GivenCardIDInHand
	ld de, DARK_MACHAMP
	ret nc
.commit
	ld [wTempAIMultiTargetCardDeckIndex1], a
	farcall FindDifferentPokemonCardInHand
	ret
; 0x233d8

; deck $51's Pokemon Trader policy. Solo path (one Pokemon in play)
; priority-fetches a basic from the deck ($171, $87, $139, $14b, $115).
; Multi path walks the Abra -> Dark Kadabra -> Dark Alakazam chain
; ($115 -> $11a -> $11d) plus the $87 -> $8a and $14b -> $14d advances.
AIDecide_PokemonTrader_Deck51:
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	cp $01
	jr nz, .multi
	ld a, CARD_LOCATION_DECK
	ld de, KANGASKHAN_LV40
	farcall FindCardIDInLocation
	ld de, KANGASKHAN_LV40
	jr c, .commit
	ld a, CARD_LOCATION_DECK
	ld de, PSYDUCK_LV16
	farcall FindCardIDInLocation
	ld de, PSYDUCK_LV16
	jr c, .commit
	ld de, MEWTWO_LV30
	farcall FindCardIDInLocation
	ld de, MEWTWO_LV30
	jr c, .commit
	ld de, RATTATA_LV15
	farcall FindCardIDInLocation
	ld de, RATTATA_LV15
	jr c, .commit
	ld de, ABRA_LV8
	farcall FindCardIDInLocation
	ld de, ABRA_LV8
	jr c, .commit
.multi
	ld bc, ABRA_LV8
	ld de, DARK_KADABRA
	farcall LookForEvoCardInDeck_GivenPreevoInHandOrPlayArea
	jr c, .commit
	ld bc, DARK_KADABRA
	ld de, DARK_ALAKAZAM
	farcall LookForEvoCardInDeck_GivenPreevoInHandOrPlayArea
	jr c, .commit
	ld bc, PSYDUCK_LV16
	ld de, DARK_GOLDUCK
	farcall LookForEvoCardInDeck_GivenPreevoInHandOrPlayArea
	jr c, .commit
	ld bc, RATTATA_LV15
	ld de, DARK_RATICATE
	farcall LookForEvoCardInDeck_GivenPreevoInHandOrPlayArea
	ret nc
.commit
	ld [wTempAIMultiTargetCardDeckIndex1], a
	farcall FindDifferentPokemonCardInHand
	ret

; Twelve more decks delegate Pokemon Trader to a per-deck AI helper in
; bank $0e/$12 (deck $6d's is still raw, Func_487ff).
AIDecide_PokemonTrader_Deck5A:
	farcall BadGuysDeckAIDecidePokemonTraderForEvo
	ret
AIDecide_PokemonTrader_Deck5B:
	farcall PoisonMistDeckAIDecidePokemonTrader
	ret
AIDecide_PokemonTrader_Deck5C:
	farcall UltraRemovalDeckAIDecidePokemonTrader
	ret
AIDecide_PokemonTrader_Deck65:
	farcall ColorlessEnergyDeckAIDecidePokemonTrader
	ret
AIDecide_PokemonTrader_Deck6C:
	farcall RonaldsPsychicDeckAIDecidePokemonTrader
	ret
AIDecide_PokemonTrader_Deck6D:
	farcall Func_487ff
	ret
AIDecide_PokemonTrader_Deck6F:
	farcall ImmortalPokemonDeckAIDecidePokemonTrader
	ret
AIDecide_PokemonTrader_Deck70:
	farcall TorrentialFloodDeckAIDecidePokemonTrader
	ret
AIDecide_PokemonTrader_Deck71:
	farcall TrainerImprisonDeckAIDecidePokemonTrader
	ret
AIDecide_PokemonTrader_Deck72:
	farcall BlazingFlameDeckAIDecidePokemonTrader
	ret
AIDecide_PokemonTrader_Deck73:
	farcall DamageChaosDeckAIDecidePokemonTrader
	ret
AIDecide_PokemonTrader_Deck74:
	farcall BigThunderDeckAIDecidePokemonTrader
	ret

AIPlay_TheBosssWay:
	ld a, [wAITrainerCardToPlay]
	ldh [hTempCardIndex_ff9f], a
	ld a, [wAITrainerCardParameter]
	ldh [hTemp_ffa0], a
	ld a, $ff
	ldh [hTempPlayAreaLocation_ffa1], a
	ld a, OPPACTION_EXECUTE_TRAINER_EFFECTS
	farcall AIMakeDecision
	ret

; Pure dispatcher: 10 deck-specific policies, two of them ($38 and
; $39) inline. Every other deck returns "don't play" by default.
AIDecide_TheBosssWay:
	ld a, [wOpponentDeckID]
	cp GREAT_ROCKET2_DECK_ID
	jr z, .deck_38
	cp GREAT_ROCKET3_DECK_ID
	jr z, .deck_39
	cp DEMONIC_FOREST_DECK_ID
	jp z, AIDecide_TheBosssWay_Deck3F
	cp DANGEROUS_BENCH_DECK_ID
	jp z, $754f
	cp FULL_STRENGTH_DECK_ID
	jp z, AIDecide_TheBosssWay_Deck4F
	cp DIRECT_HIT_DECK_ID
	jp z, AIDecide_TheBosssWay_Deck51
	cp SUDDEN_GROWTH_DECK_ID
	jp z, AIDecide_TheBosssWay_Deck58
	cp BAD_GUYS_DECK_ID
	jp z, AIDecide_TheBosssWay_Deck5A
	cp RONALDS_GRX_DECK_ID
	jp z, AIDecide_TheBosssWay_Deck6A
	cp DAMAGE_CHAOS_DECK_ID
	jp z, $75f9
	or a
	ret
; deck $38: scan the deck for four specific evolution chain advances
; (card IDs $1f→$23, $20→$23, $e6→$eb, $e7→$eb), then fall back to
; checking whether card $23 or $eb is in the deck but not in hand.
.deck_38
	ld bc, EKANS_LV10
	ld de, DARK_ARBOK
	farcall LookForEvoCardInDeck_GivenPreevoInHandOrPlayArea
	ret c
	ld bc, EKANS_LV15
	ld de, DARK_ARBOK
	farcall LookForEvoCardInDeck_GivenPreevoInHandOrPlayArea
	ret c
	ld bc, DIGLETT_LV8
	ld de, DARK_DUGTRIO
	farcall LookForEvoCardInDeck_GivenPreevoInHandOrPlayArea
	ret c
	ld bc, DIGLETT_LV15
	ld de, DARK_DUGTRIO
	farcall LookForEvoCardInDeck_GivenPreevoInHandOrPlayArea
	ret c
	ld de, DARK_ARBOK
	farcall IsCardIDInDeckAndNotInHand
	ret c
	ld de, DARK_DUGTRIO
	farcall IsCardIDInDeckAndNotInHand
	ret
; deck $39: three evolution chain checks ($5b→$5d, $34→$37, $37→$39).
.deck_39
	ld bc, CHARMANDER_LV12
	ld de, DARK_CHARMELEON
	farcall LookForEvoCardInDeck_GivenPreevoInHandOrPlayArea
	ret c
	ld bc, ODDISH_LV8
	ld de, DARK_GLOOM
	farcall LookForEvoCardInDeck_GivenPreevoInHandOrPlayArea
	ret c
	ld bc, DARK_GLOOM
	ld de, DARK_VILEPLUME
	farcall LookForEvoCardInDeck_GivenPreevoInHandOrPlayArea
	ret
; 0x23539

; deck $3f's The Boss's Way policy: walk a 3-stage evolution chain
; ($e -> $11 -> $15) by checking $e->$11 and $11->$15 advances.
AIDecide_TheBosssWay_Deck3F:
	ld bc, BULBASAUR_LV15
	ld de, DARK_IVYSAUR
	farcall LookForEvoCardInDeck_GivenPreevoInHandOrPlayArea
	ret c
	ld bc, DARK_IVYSAUR
	ld de, DARK_VENUSAUR
	farcall LookForEvoCardInDeck_GivenPreevoInHandOrPlayArea
	ret
; 0x2354f

SECTION "Bank 8@7570", ROMX[$7570], BANK[$8]

; deck $4f's The Boss's Way policy: walk the Machop -> Dark Machoke ->
; Dark Machamp 3-stage evolution chain (same chain that deck $4f's
; Pokemon Trader walks).
AIDecide_TheBosssWay_Deck4F:
	ld bc, MACHOP_LV24
	ld de, DARK_MACHOKE
	farcall LookForEvoCardInDeck_GivenPreevoInHandOrPlayArea
	ret c
	ld bc, DARK_MACHOKE
	ld de, DARK_MACHAMP
	farcall LookForEvoCardInDeck_GivenPreevoInHandOrPlayArea
	ret
; 0x23586

; deck $51 (Direct Hit) The Boss's Way policy: walk the same evolution
; chains its Pokemon Trader uses -- Abra -> Dark Kadabra -> Dark Alakazam,
; plus Psyduck -> Dark Golduck and Rattata -> Dark Raticate.
AIDecide_TheBosssWay_Deck51:
	ld bc, ABRA_LV8
	ld de, DARK_KADABRA
	farcall LookForEvoCardInDeck_GivenPreevoInHandOrPlayArea
	ret c
	ld bc, DARK_KADABRA
	ld de, DARK_ALAKAZAM
	farcall LookForEvoCardInDeck_GivenPreevoInHandOrPlayArea
	ret c
	ld bc, PSYDUCK_LV16
	ld de, DARK_GOLDUCK
	farcall LookForEvoCardInDeck_GivenPreevoInHandOrPlayArea
	ret c
	ld bc, RATTATA_LV15
	ld de, DARK_RATICATE
	farcall LookForEvoCardInDeck_GivenPreevoInHandOrPlayArea
	ret
; 0x235b2

; deck $58 (Sudden Growth) The Boss's Way policy: pull a Moon Stone evo
; line from the opponent's deck -- Dratini -> Dark Dragonair, else
; Clefairy -> Dark Clefable.
AIDecide_TheBosssWay_Deck58:
	ld bc, DRATINI_LV12
	ld de, DARK_DRAGONAIR
	farcall LookForEvoCardInDeck_GivenPreevoInHandOrPlayArea
	ret c
	ld bc, CLEFAIRY_LV15
	ld de, DARK_CLEFABLE
	farcall LookForEvoCardInDeck_GivenPreevoInHandOrPlayArea
	ret

; deck $5a (Bad Guys) delegates The Boss's Way to a bespoke bank-$12 helper.
AIDecide_TheBosssWay_Deck5A:
	farcall BadGuysDeckAIDecideTheBosssWay
	ret

; deck $6a's The Boss's Way policy: four evolution-chain checks. Same
; "fetch from opponent's deck along an evolution line" pattern that
; decks $38 and $39 use, just with different card-ID pairs.
AIDecide_TheBosssWay_Deck6A:
	ld bc, ZUBAT_LV9
	ld de, DARK_GOLBAT
	farcall LookForEvoCardInDeck_GivenPreevoInHandOrPlayArea
	ret c
	ld bc, GRIMER_LV10
	ld de, DARK_MUK
	farcall LookForEvoCardInDeck_GivenPreevoInHandOrPlayArea
	ret c
	ld bc, RATTATA_LV12
	ld de, DARK_RATICATE
	farcall LookForEvoCardInDeck_GivenPreevoInHandOrPlayArea
	ret c
	ld bc, MEOWTH_LV10
	ld de, DARK_PERSIAN_LV28
	farcall LookForEvoCardInDeck_GivenPreevoInHandOrPlayArea
	ret c
; 0x235f9

SECTION "Bank 8@75fe", ROMX[$75fe], BANK[$8]

AIPlay_NightlyGarbageRun:
	ld a, [wAITrainerCardToPlay]
	ldh [hTempCardIndex_ff9f], a
	ld a, [wAITrainerCardParameter]
	ldh [hTemp_ffa0], a
	ld a, [wTempAIMultiTargetCardDeckIndex1]
	ldh [hTempPlayAreaLocation_ffa1], a
	ld a, [wTempAIMultiTargetCardDeckIndex2]
	ldh [hTempRetreatCostCards], a
	ld a, $ff
	ldh [hAIEnergyTransPlayAreaLocation], a
	ld a, OPPACTION_EXECUTE_TRAINER_EFFECTS
	farcall AIMakeDecision
	ret

; Pure dispatcher: 12 deck-specific policies, default returns NC.
AIDecide_NightlyGarbageRun:
	ld a, [wOpponentDeckID]
	cp PSYCHIC_ELITE_DECK_ID
	jp z, $765e
	cp GRAND_FIRE_DECK_ID
	jp z, $76ad
	cp LEGENDARY_FOSSIL_DECK_ID
	jp z, $76d6
	cp GREAT_DRAGON_DECK_ID
	jp z, $76ff
	cp STICKY_POISON_GAS_DECK_ID
	jp z, $7789
	cp MAD_PETALS_DECK_ID
	jp z, AIDecide_NightlyGarbageRun_Deck41
	cp COMPLETE_COMBUSTION_DECK_ID
	jp z, $787d
	cp GAZE_UPON_THE_POWER_OF_FIRE_DECK_ID
	jp z, AIDecide_NightlyGarbageRun_Deck49
	cp SPIRITED_AWAY_DECK_ID
	jp z, AIDecide_NightlyGarbageRun_Deck55
	cp SUDDEN_GROWTH_DECK_ID
	jp z, AIDecide_NightlyGarbageRun_Deck58
	cp BAD_GUYS_DECK_ID
	jp z, AIDecide_NightlyGarbageRun_Deck5A
	cp IMMORTAL_POKEMON_DECK_ID
	jp z, AIDecide_NightlyGarbageRun_Deck6F
	or a
	ret
; 0x2365e

SECTION "Bank 8@782f", ROMX[$782f], BANK[$8]

; deck $41 NGR policy. Empties the three multi-target slots, then
; tries to fill them with cards from the discard pile in priority
; order: card ID $39 (Dark Vileplume), card ID $37 (Dark Gloom), and
; finally any basic energies. Any successful add returns NC from
; AddDeckIndexToAIMultiTargetSlots; once it returns carry SET we
; know we've packed all three slots.
;
; The trailing block shifts slot2 down to slot1 and slot3 down to
; slot2 -- the trainer effect treats slot1 as "first card to rescue"
; so this re-packs after the AI knocked some entries out, then
; commits with the saved $a register state.
AIDecide_NightlyGarbageRun_Deck41:
	ld a, $ff
	ld [wTempAIMultiTargetCardDeckIndex1], a
	ld [wTempAIMultiTargetCardDeckIndex2], a
	ld [wTempAIMultiTargetCardDeckIndex3], a
	ld a, CARD_LOCATION_DISCARD_PILE
	ld de, DARK_VILEPLUME
	farcall FindCardIDInLocation
	call c, AddDeckIndexToAIMultiTargetSlots
	ld a, CARD_LOCATION_DISCARD_PILE
	ld de, DARK_GLOOM
	farcall FindCardIDInLocation
	call c, AddDeckIndexToAIMultiTargetSlots
	ld a, CARD_LOCATION_DISCARD_PILE
	farcall CreateBasicEnergyCardListInLocation
	ld hl, wDuelTempList
.scan_energy
	ld a, [hli]
	cp $ff
	jr z, .commit
	push hl
	call AddDeckIndexToAIMultiTargetSlots
	pop hl
	jr nc, .scan_energy
.commit
	ld a, [wTempAIMultiTargetCardDeckIndex1]
	cp $ff
	ret z
	push af
	ld a, [wTempAIMultiTargetCardDeckIndex2]
	ld [wTempAIMultiTargetCardDeckIndex1], a
	ld a, [wTempAIMultiTargetCardDeckIndex3]
	ld [wTempAIMultiTargetCardDeckIndex2], a
	pop af
	scf
	ret
; 0x2387d

SECTION "Bank 8@79df", ROMX[$79df], BANK[$8]

; Helper for NIGHTLY_GARBAGE_RUN's deck-specific policies: given a
; deck index in `a`, find the first $ff slot in
; wTempAIMultiTargetCardDeckIndex1/2/3 and write `a` there. Returns
; NC on success, carry SET if all three slots are already full.
AddDeckIndexToAIMultiTargetSlots:
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
; 0x239f5

SECTION "Bank 8@78c9", ROMX[$78c9], BANK[$8]

; deck $49 NGR policy: gather basic energies in the discard pile,
; require at least 3, then rescue the first two on the list plus
; (if found) a card $65 from discard. Returns the result with the
; rescue target list pre-populated in
; wTempAIMultiTargetCardDeckIndex1/2.
AIDecide_NightlyGarbageRun_Deck49:
	ld a, CARD_LOCATION_DISCARD_PILE
	farcall CreateBasicEnergyCardListInLocation
	jr c, .no_play
	cp $03
	jr c, .no_play
	ld a, [wDuelTempList]
	ld [wTempAIMultiTargetCardDeckIndex1], a
	ld a, [wDuelTempList + 1]
	ld [wTempAIMultiTargetCardDeckIndex2], a
	ld a, CARD_LOCATION_DISCARD_PILE
	ld de, DARK_NINETALES
	farcall FindCardIDInLocation
	ret c
	ld a, [wDuelTempList + 2]
	scf
	ret
.no_play
	or a
	ret
; 0x238f2

; deck $55 (Spirited Away) Nightly Garbage Run policy: pull back up to
; three cards from the discard pile. First grab every basic energy
; found, then top up with the deck's Psychic line from discard --
; Gastly Lv17 ($126), Dark Haunter ($12b), Dark Gengar ($12e). Returns
; with the chosen deck indices packed into the first two target slots.
AIDecide_NightlyGarbageRun_Deck55:
	ld a, $ff
	ld [wTempAIMultiTargetCardDeckIndex1], a
	ld [wTempAIMultiTargetCardDeckIndex2], a
	ld [wTempAIMultiTargetCardDeckIndex3], a
	ld a, CARD_LOCATION_DISCARD_PILE
	farcall CreateBasicEnergyCardListInLocation
	ld hl, wDuelTempList
.energy_loop
	ld a, [hli]
	cp $ff
	jr z, .add_pokemon
	push hl
	call AddDeckIndexToAIMultiTargetSlots
	pop hl
	jr nc, .energy_loop
	jr .pack
.add_pokemon
	ld a, CARD_LOCATION_DISCARD_PILE
	ld de, DARK_GENGAR
	farcall FindCardIDInLocation
	call c, AddDeckIndexToAIMultiTargetSlots
	jr c, .pack
	ld a, CARD_LOCATION_DISCARD_PILE
	ld de, DARK_HAUNTER
	farcall FindCardIDInLocation
	call c, AddDeckIndexToAIMultiTargetSlots
	jr c, .pack
	ld a, CARD_LOCATION_DISCARD_PILE
	ld de, GASTLY_LV17
	farcall FindCardIDInLocation
	call c, AddDeckIndexToAIMultiTargetSlots
	jr c, .pack
	or a
	ret
.pack
	ld a, [wTempAIMultiTargetCardDeckIndex1]
	cp $ff
	ret z
	push af
	ld a, [wTempAIMultiTargetCardDeckIndex2]
	ld [wTempAIMultiTargetCardDeckIndex1], a
	ld a, [wTempAIMultiTargetCardDeckIndex3]
	ld [wTempAIMultiTargetCardDeckIndex2], a
	pop af
	scf
	ret

; deck $58 (Sudden Growth) Nightly Garbage Run policy: recover its Moon
; Stone evo line from the discard -- Dratini, Dark Dragonair, Dark
; Dragonite, then Clefairy / Dark Clefable (stopping once one of the
; Clefairy-line cards is queued) -- and top up with basic energy. Up to
; three deck indices are collected, then `.pack` compacts the slots and
; returns carry SET if anything was found.
AIDecide_NightlyGarbageRun_Deck58:
	ld a, $ff
	ld [wTempAIMultiTargetCardDeckIndex1], a
	ld [wTempAIMultiTargetCardDeckIndex2], a
	ld [wTempAIMultiTargetCardDeckIndex3], a
	ld a, CARD_LOCATION_DISCARD_PILE
	ld de, DRATINI_LV12
	farcall FindCardIDInLocation
	call c, AddDeckIndexToAIMultiTargetSlots
	ld a, CARD_LOCATION_DISCARD_PILE
	ld de, DARK_DRAGONAIR
	farcall FindCardIDInLocation
	call c, AddDeckIndexToAIMultiTargetSlots
	ld a, CARD_LOCATION_DISCARD_PILE
	ld de, DARK_DRAGONITE
	farcall FindCardIDInLocation
	call c, AddDeckIndexToAIMultiTargetSlots
	jr c, .pack
	ld a, CARD_LOCATION_DISCARD_PILE
	ld de, CLEFAIRY_LV15
	farcall FindCardIDInLocation
	call c, AddDeckIndexToAIMultiTargetSlots
	jr c, .pack
	ld a, CARD_LOCATION_DISCARD_PILE
	ld de, DARK_CLEFABLE
	farcall FindCardIDInLocation
	call c, AddDeckIndexToAIMultiTargetSlots
	jr c, .pack
	ld a, CARD_LOCATION_DISCARD_PILE
	farcall CreateBasicEnergyCardListInLocation
	ld hl, wDuelTempList
.energy_loop
	ld a, [hli]
	cp $ff
	jr z, .pack
	push hl
	call AddDeckIndexToAIMultiTargetSlots
	pop hl
	jr nc, .energy_loop
.pack
	ld a, [wTempAIMultiTargetCardDeckIndex1]
	cp $ff
	ret z
	push af
	ld a, [wTempAIMultiTargetCardDeckIndex2]
	ld [wTempAIMultiTargetCardDeckIndex1], a
	ld a, [wTempAIMultiTargetCardDeckIndex3]
	ld [wTempAIMultiTargetCardDeckIndex2], a
	cp $ff
	jr z, .none_left
	pop af
	scf
	ret
.none_left
	pop af
	or a
	ret

; deck $5a (Bad Guys) delegates Nightly Garbage Run to a bank-$12 helper.
AIDecide_NightlyGarbageRun_Deck5A:
	farcall BadGuysDeckAIDecideNightlyGarbageRun
	ret

; deck $6f (Immortal Pokemon) delegates Nightly Garbage Run to a bank-$12 helper.
AIDecide_NightlyGarbageRun_Deck6F:
	farcall ImmortalPokemonDeckAIDecideNightlyGarbageRun
	ret

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
	cp OVERFLOW_DECK_ID
	jp z, AIDecide_Sleep_Deck12
	cp BAD_DREAM_DECK_ID
	jp z, AIDecide_Sleep_Deck53
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

; Deck $53 (Bad Dream): only bother with Sleep when our active is
; Haunter Lv22 (whose attack synergizes with a sleeping defender), and
; not if the defender is already Asleep.
AIDecide_Sleep_Deck53:
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call GetCardIDFromDeckIndex
	cp16 HAUNTER_LV22
	jr nz, AIDecide_Sleep.no_play
	ld a, DUELVARS_ARENA_CARD_STATUS
	call GetNonTurnDuelistVariable
	and CNF_SLP_PRZ
	cp ASLEEP
	jr z, AIDecide_Sleep.no_play
	scf
	ret
; 0x23a90

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
; (decks $3f, $43, $46, $74 decompiled; six still raw); everyone else
; returns "don't play".
AIDecide_MasterBall:
	ld a, DUELVARS_NUMBER_OF_CARDS_NOT_IN_DECK
	get_turn_duelist_var
	cp $37
	ret nc
	ld a, [wOpponentDeckID]
	cp TRIPLE_ZAPDOS_DECK_ID
	jr z, .deck_13
	cp I_LOVE_PIKACHU_DECK_ID
	jr z, .deck_14
	cp PSYCHOKINESIS_DECK_ID
	jp z, $7bdf
	cp PUPPET_MASTER_DECK_ID
	jp z, $7be4
	cp DARK_SCIENCE_DECK_ID
	jp z, $7c10
	cp GREAT_DRAGON_DECK_ID
	jp z, $7c60
	cp BUG_COLLECTING_DECK_ID
	jp z, $7cdc
	cp DEMONIC_FOREST_DECK_ID
	jp z, AIDecide_MasterBall_Deck3F
	cp STICKY_POISON_GAS_DECK_ID
	jp z, $7d61
	cp CHAIN_LIGHTNING_BY_PIKACHU_DECK_ID
	jp z, AIDecide_MasterBall_Deck43
	cp COMPLETE_COMBUSTION_DECK_ID
	jp z, AIDecide_MasterBall_Deck46
	cp BIG_THUNDER_DECK_ID
	jp z, AIDecide_MasterBall_Deck74
	or a
	ret
; deck $13: priority targets are card IDs $de, $df, $e0; else AITryMasterBall
.deck_13
	ld de, ZAPDOS_LV28
	farcall AITryMasterBall_GivenTarget
	ret c
	ld de, ZAPDOS_LV40
	farcall AITryMasterBall_GivenTarget
	ret c
	ld de, ZAPDOS_LV64
	farcall AITryMasterBall_GivenTarget
	ret c
	farcall AITryMasterBall
	ret
; deck $14: skip Master Ball if card $1b8 is already in hand, if we
; already have 3+ Pokemon in play, or if we have a Basic Pokemon to
; develop instead. Otherwise pull from a fixed priority list of
; target card IDs.
.deck_14
	ld de, POKEBALL
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
	ld de, FLYING_PIKACHU_LV12
	farcall AITryMasterBall_GivenTarget
	ret c
	ld de, FLYING_PIKACHU_ALT_LV12
	farcall AITryMasterBall_GivenTarget
	ret c
	ld de, PIKACHU_LV16
	farcall AITryMasterBall_GivenTarget
	ret c
	ld de, PIKACHU_ALT_LV16
	farcall AITryMasterBall_GivenTarget
	ret c
	ld de, PIKACHU_LV5
	farcall AITryMasterBall_GivenTarget
	ret c
	ld de, PIKACHU_LV13
	farcall AITryMasterBall_GivenTarget
	ret c
	ld de, SURFING_PIKACHU_LV13
	farcall AITryMasterBall_GivenTarget
	ret c
	ld de, SURFING_PIKACHU_ALT_LV13
	farcall AITryMasterBall_GivenTarget
	ret c
	farcall AITryMasterBall
	ret
; 0x23bdf

SECTION "Bank 8@7d44", ROMX[$7d44], BANK[$8]

; deck $3f's Master Ball policy: priority targets are the same three
; card IDs deck $3f's Boss's Way decider walks ($11 then $15 then
; $e), then fall through to a generic AITryMasterBall.
AIDecide_MasterBall_Deck3F:
	ld de, DARK_IVYSAUR
	farcall AITryMasterBall_GivenTarget
	ret c
	ld de, DARK_VENUSAUR
	farcall AITryMasterBall_GivenTarget
	ret c
	ld de, BULBASAUR_LV15
	farcall AITryMasterBall_GivenTarget
	ret c
	farcall AITryMasterBall
	ret
; 0x23d61

SECTION "Bank 8@7dc2", ROMX[$7dc2], BANK[$8]

; deck $43 ("Chain Lightning by Pikachu") delegates Master Ball
; entirely to a bespoke bank-$12 helper.
AIDecide_MasterBall_Deck43:
	farcall ChainLightningByPikachuDeckAIDecideMasterBall
	ret

; deck $46 (Complete Combustion) Master Ball policy: walk a fixed
; priority list of card IDs (its Fire attackers plus two Colorless
; support Pokemon); fall back to the generic AITryMasterBall.
AIDecide_MasterBall_Deck46:
	ld de, MAGMAR_LV27
	farcall AITryMasterBall_GivenTarget
	ret c
	ld de, PONYTA_LV15
	farcall AITryMasterBall_GivenTarget
	ret c
	ld de, GROWLITHE_LV12
	farcall AITryMasterBall_GivenTarget
	ret c
	ld de, KANGASKHAN_LV40
	farcall AITryMasterBall_GivenTarget
	ret c
	ld de, MEOWTH_LV14
	farcall AITryMasterBall_GivenTarget
	ret c
	farcall AITryMasterBall
	ret

; deck $74 (Big Thunder) delegates Master Ball to a bespoke bank-$12 helper.
AIDecide_MasterBall_Deck74:
	farcall BigThunderDeckAIDecideMasterBall
	ret

; Bill's Teleporter has no targeting -- just execute the trainer effect.
AIPlay_BillsTeleporter:
	ld a, [wAITrainerCardToPlay]
	ldh [hTempCardIndex_ff9f], a
	ld a, OPPACTION_EXECUTE_TRAINER_EFFECTS
	farcall AIMakeDecision
	ret

; Play Bill's Teleporter only while fewer than $2f (47) cards are out of
; the deck -- with that many cards still left to draw into, the
; shuffle-hand-and-redraw is worth it. Returns carry SET to play.
AIDecide_BillsTeleporter:
	ld a, DUELVARS_NUMBER_OF_CARDS_NOT_IN_DECK
	get_turn_duelist_var
	cp $2f
	ret

; Moon Stone evolves a Pokemon already in play. Stash the chosen
; play-area position (wAITrainerCardParameter, set by the decider) into
; hTemp_ffa0, then execute the trainer effect.
AIPlay_MoonStone:
	ld a, [wAITrainerCardToPlay]
	ldh [hTempCardIndex_ff9f], a
	ld a, [wAITrainerCardParameter]
	ldh [hTemp_ffa0], a
	ld a, OPPACTION_EXECUTE_TRAINER_EFFECTS
	farcall AIMakeDecision
	ret

; Moon Stone decider: bail if 56+ cards are already out of the deck, then
; dispatch on deck ID. Each deck checks for a specific Moon Stone evolution
; it can complete (pre-evo in hand/play + evo waiting in deck), returning
; carry SET to play; the lookups also stash the target as a side effect.
AIDecide_MoonStone:
	ld a, DUELVARS_NUMBER_OF_CARDS_NOT_IN_DECK
	get_turn_duelist_var
	cp $38
	ret nc
	ld a, [wOpponentDeckID]
	cp HAND_OVER_GR_DECK_ID
	jr z, .deck_16
	cp I_LOVE_TO_FIGHT_DECK_ID
	jr z, .deck_23
	cp EYE_OF_THE_STORM_DECK_ID
	jr z, .deck_57
	cp SUDDEN_GROWTH_DECK_ID
	jr z, .deck_58
	cp COLORLESS_ENERGY_DECK_ID
	jr z, .deck_65
	cp RONALDS_ULTRA_DECK_ID
	jr z, .deck_6d
	or a
	ret
; deck $16 (Handed Over GR): Jigglypuff -> Wigglytuff
.deck_16
	ld bc, JIGGLYPUFF_LV13
	ld de, WIGGLYTUFF_LV36
	farcall LookForEvoCardInDeck_GivenPreevoInHandOrPlayArea
	ret
; deck $23 (Love to Battle): just confirm Dodrio is sitting in the deck
.deck_23
	ld a, CARD_LOCATION_DECK
	ld de, DODRIO_LV28
	farcall FindCardIDInLocation
	ret
; deck $57 (Eye of the Storm) delegates to a bespoke bank-$12 helper.
.deck_57
	farcall EyeOfTheStormDeckAIDecideMoonStone
	ret
; deck $58 (Sudden Growth): Dratini -> Dark Dragonair, else Clefairy -> Dark Clefable
.deck_58
	ld bc, DRATINI_LV12
	ld de, DARK_DRAGONAIR
	farcall LookForEvoCardInDeck_GivenPreevoInHandOrPlayArea
	ret c
	ld bc, CLEFAIRY_LV15
	ld de, DARK_CLEFABLE
	farcall LookForEvoCardInDeck_GivenPreevoInHandOrPlayArea
	ret
; deck $65 (Colorless Energy) delegates to a bespoke bank-$12 helper.
.deck_65
	farcall ColorlessEnergyDeckAIDecideMoonStone
	ret
; deck $6d (Ronald's Ultra) delegates to a bespoke bank-$48 helper.
.deck_6d
	farcall Func_487c7
	ret

; The Rocket's Trap has no targeting -- just execute the trainer effect.
AIPlay_TheRocketsTrap:
	ld a, [wAITrainerCardToPlay]
	ldh [hTempCardIndex_ff9f], a
	ld a, OPPACTION_EXECUTE_TRAINER_EFFECTS
	farcall AIMakeDecision
	ret

; The Rocket's Trap disrupts the opponent's hand, so play it once the
; opponent is holding a big hand: 5+ cards normally, or 3+ for deck $6d
; (Ronald's Ultra). `ccf` flips the `cp` borrow so carry is SET (play)
; when the hand size is at or above the threshold.
AIDecide_TheRocketsTrap:
	ld a, [wOpponentDeckID]
	cp RONALDS_ULTRA_DECK_ID
	jr z, .deck_6d
	ld a, DUELVARS_NUMBER_OF_CARDS_IN_HAND
	call GetNonTurnDuelistVariable
	cp $05
	ccf
	ret
.deck_6d
	ld a, DUELVARS_NUMBER_OF_CARDS_IN_HAND
	call GetNonTurnDuelistVariable
	cp $03
	ccf
	ret

AIPlay_GoopGasAttack:
	ld a, [wAITrainerCardToPlay]
	ldh [hTempCardIndex_ff9f], a
	ld a, OPPACTION_EXECUTE_TRAINER_EFFECTS
	farcall AIMakeDecision
	ret

; Deck $67 always plays. Otherwise the AI skips Goop Gas Attack if
; card ID $49 is already in our play area (its Pkmn Power likely
; conflicts with the trainer effect). If neither applies, delegate
; to AIChooseStareTarget which picks a target and returns the
; appropriate carry.
AIDecide_GoopGasAttack:
	ld a, [wOpponentDeckID]
	cp WEIRD_DECK_ID
	jr z, .pick_target
	ld de, MUK
	ld b, $00
	farcall FindCardIDInTurnDuelistsPlayArea.loop_play_area
	jr nc, .pick_target
	or a
	ret
.pick_target
	farcall AIChooseStareTarget
	ret
; 0x23ec3

SECTION "Bank 8@7f3e", ROMX[$7f3e], BANK[$8]

; Computer Error's play has its own pre-step: SwapTurn so the
; trainer effect picks a card from the *player's* hand to swap,
; then SwapTurn back, store the chosen index in
; hTempPlayAreaLocation_ffa1, fire the effect, and bump wd033 to
; signal "AI used Computer Error this turn".
AIPlay_ComputerError:
	ld a, [wAITrainerCardToPlay]
	ldh [hTempCardIndex_ff9f], a
	ld a, [wAITrainerCardParameter]
	ldh [hTemp_ffa0], a
	call SwapTurn
	farcall HandleComputerErrorPlayerSelection
	call SwapTurn
	ldh [hTempPlayAreaLocation_ffa1], a
	ld a, OPPACTION_EXECUTE_TRAINER_EFFECTS
	farcall AIMakeDecision
	ld a, $02
	ld [wd033], a
	scf
	ret

; Three deck-specific cases ($59, $68, $6b); default returns NC.
; All three "yes" exits return with a = $05 (Computer Error's
; per-card priority code in the AI ranking system).
AIDecide_ComputerError:
	ld a, [wOpponentDeckID]
	cp VERY_RARE_CARD_DECK_ID
	jr z, .deck_59
	cp STRANGE_DECK_ID
	jr z, .deck_68
	cp RONALDS_POWER_DECK_ID
	jr z, .deck_6b
.skip
	or a
	ret
.deck_59
	farcall AIProcessButDontUseAttack
	jr c, .skip
	ld a, DUELVARS_NUMBER_OF_CARDS_IN_HAND
	get_turn_duelist_var
	cp $03
	ret nc
	ld a, $05
	scf
	ret
.deck_68
	ld a, $05
	scf
	ret
.deck_6b
	farcall AIProcessButDontUseAttack
	jr c, .skip
	ld a, DUELVARS_NUMBER_OF_CARDS_NOT_IN_DECK
	get_turn_duelist_var
	cp $33
	ret nc
	ld a, $05
	scf
	ret

; Coin-flip card -- toss first, only commit the target on heads.
; On tails the trainer effect treats $ff as "no target."
AIPlay_SuperScoopUp:
	ld a, [wAITrainerCardToPlay]
	ldh [hTempCardIndex_ff9f], a
	ld de, $10e ; coin-toss prompt text ID (not a card ID)
	bank1call TossCoin
	ldh [hTemp_ffa0], a
	jr nc, .tails
	ld a, [wAITrainerCardParameter]
	ldh [hTempPlayAreaLocation_ffa1], a
	ld a, [wTempAIMultiTargetCardDeckIndex1]
	ldh [hTempRetreatCostCards], a
	jr .commit
.tails
	ld a, $ff
	ldh [hTempPlayAreaLocation_ffa1], a
.commit
	ld a, OPPACTION_EXECUTE_TRAINER_EFFECTS
	farcall AIMakeDecision
	ret

; Skip if we only have 1 Pokemon in play (would leave us with
; nothing), can already KO the defender from hand, the defender
; can't even KO us, or no good bench candidate exists. The bench
; pick (via AIDecideBenchPokemonToSwitchTo) is scored -- the
; replacement must hit score >= 50, otherwise scooping costs more
; than it saves.
AIDecide_SuperScoopUp:
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	cp $01
	jr z, .skip
	farcall CheckIfArenaCardCanKnockOutDefendingCard_CheckHand
	jr c, .skip
	xor a ; PLAY_AREA_ARENA
	ldh [hTempPlayAreaLocation_ff9d], a
	farcall CheckIfDefendingPokemonCanKnockOut
	jr nc, .skip
	farcall AIDecideBenchPokemonToSwitchTo
	jr c, .skip
	ld a, e
	cp $32
	jr c, .skip
	ld a, d
	ld [wTempAIMultiTargetCardDeckIndex1], a
	xor a
	scf
	ret
.skip
	or a
	ret
; 0x23fe6
