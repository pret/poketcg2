ImposterOaksRevenge_CheckHand:
	ld a, DUELVARS_NUMBER_OF_CARDS_IN_HAND
	get_turn_duelist_var
	cp 2
	; return carry if no card to discard for effect
	ldtx hl, NotEnoughCardsInHandText
	ret

ImposterOaksRevenge_PlayerSelectEffect:
	ldtx hl, ChooseCardFromHandToDiscardText
	call DrawWideTextBox_WaitForInput
	call CreateHandCardList
	ldh a, [hTempCardIndex_ff9f]
	call RemoveCardFromDuelTempList
	bank1call InitAndDrawCardListScreenLayout_WithSelectCheckMenu
	bank1call DisplayCardList
	ldh a, [hTempCardIndex_ff98]
	ldh [hTemp_ffa0], a
	ret

ImposterOaksRevenge_ReturnHandAndDrawEffect:
	; discard selected card
	ldh a, [hTemp_ffa0]
	call RemoveCardFromHand
	call PutCardInDiscardPile

	; shuffle other duelist's hand into deck
	call SwapTurn
	call CreateHandCardList
	bank1call SortCardsInDuelTempListByID
	ld hl, wDuelTempList
.loop_return_to_deck
	ld a, [hli]
	cp $ff
	jr z, .shuffle
	call RemoveCardFromHand
	call ReturnCardToDeck
	jr .loop_return_to_deck
.shuffle
	farcall ShuffleCardsInDeck

	; draw 4 cards
	ld a, 4
	farcall DisplayDrawNCardsScreen
	ld c, 4
.loop_draw
	call DrawCardFromDeck
	jr c, .done
	call AddCardToHand
	dec c
	jr nz, .loop_draw

.done
	call SwapTurn
	ret

SleepCardEffect:
	ldtx de, IfHeadsInflictSleepText
	farcall TossCoin_Bank1a
	ret nc ; got tails

	bank1call DrawDuelMainScene

	call SwapTurn
	bank1call CheckIfArenaCardIsProtectedFromStatusCondition
	push af
	call SwapTurn
	ld a, ATK_ANIM_SLEEP
	call PlaySpecialAttackAnimation
	pop af
	jr nc, .sleep
	; is unaffected
	ldtx hl, ThereWasNoEffectText
	call DrawWideTextBox_WaitForInput
	ret

.sleep
	ld a, DUELVARS_ARENA_CARD_STATUS
	call GetNonTurnDuelistVariable
	and PSN_DBLPSN
	or ASLEEP
	ld [hl], a
	; reset changed type
	ld l, DUELVARS_ARENA_CARD_CHANGED_TYPE
	ld [hl], $00
	; reset PLAY_AREA_FLAG_UNK_3 flag
	ld l, DUELVARS_ARENA_CARD_FLAGS
	res AFFECTED_BY_POISON_MIST_F, [hl]
	bank1call DrawDuelHUDs
	ret

DiggerEffect:
.toss_coin
	ldtx de, DiggerCheckText
	farcall TossCoin_Bank1a
	jr nc, .user_got_tails
	call SwapTurn
	ldtx de, DiggerCheckText
	farcall TossCoin_Bank1a
	jr nc, .other_got_tails
	call SwapTurn
	jr .toss_coin
.user_got_tails
	call .Deal10Damage
	jr .after_damage
.other_got_tails
	call .Deal10Damage
	call SwapTurn
.after_damage
	bank1call HandleDestinyBondAndBetweenTurnKnockOuts
	ret

.Deal10Damage:
	ld b, PLAY_AREA_ARENA
	ld de, 10
	call InflictEnergyOrTrainerCardDamage
	ret

; input:
; - b = PLAY_AREA_* card
; - de = damage
InflictEnergyOrTrainerCardDamage:
	push hl
	push de
	push bc
	; for the Bench
	ld c, ATK_ANIM_BENCH_HIT
	ld a, b
	or a
	jr nz, .got_anim
	; for the Arena card
	ld c, ATK_ANIM_ENERGY_TRAINER_DAMAGE
	ldh a, [hWhoseTurn]
	ld hl, wWhoseTurn
	cp [hl]
	jr nz, .got_anim
	ld c, ATK_ANIM_RECOIL_HIT
.got_anim
	ld a, c
	ld [wLoadedAttackAnimation], a

	push de
	ld a, b
	bank1call LoadPlayAreaCardID_ToTempNonTurnDuelistCardID
	pop de
	ld a, b
	or a
	jr nz, .got_final_damage
	push bc
	; a = 0
	ld [wNoDamageOrEffect], a
	ld a, POKEMON_POWER
	ld [wLoadedAttackCategory], a
	bank1call HandleDamageReductionExceptSubstatus2
	pop bc
	bit 7, d
	jr z, .got_final_damage
	ld de, 0 ; avoid underflow
.got_final_damage
	ldh a, [hWhoseTurn]
	push af
	push bc
	ld a, b
	add DUELVARS_ARENA_CARD_HP
	get_turn_duelist_var
	ld c, $00
	ld a, [wWhoseTurn]
	ldh [hWhoseTurn], a
	farcall PlayAnimationAndSubtractFromHP
	pop bc
	pop af
	ldh [hWhoseTurn], a
	ld a, b
	call PrintPlayAreaCardKnockedOutIfNoHP
	pop bc
	pop de
	pop hl
	ret

TheBosssWay_CheckDeck:
	farcall CheckIfDeckIsEmpty
	ret

TheBosssWay_PlayerSelectEffect:
	call CreateDeckCardList
	ldtx hl, ChooseADarkEvolutionCardText
	ldtx bc, EffectTargetDarkPokemonText
	ld a, CARDSEARCH_DARK_POKEMON
	farcall LookForCardsInDeck
	jr c, .got_selection
	ldtx hl, ChooseADarkPokemonText
	ldtx de, DuelistDeckText
	farcall SelectCardSearchTarget
.got_selection
	ldh [hTemp_ffa0], a
	ret

TheBosssWay_AddToHandEffect:
	ldh a, [hTemp_ffa0]
	cp $ff
	jr z, .finish ; no valid selection

	call SearchCardInDeckAndAddToHand
	call AddCardToHand
	farcall IsPlayerTurn
	jr c, .finish

	; show card to player
	ldh a, [hTemp_ffa0]
	ldtx hl, WasPlacedInTheHandText
	bank1call DisplayCardDetailScreen

.finish
	farcall ShuffleCardsInDeck
	ret

GoopGasAttackEffect:
	ld a, 2 ; effect is active for 2 turns (user and opponent's turn)
	ld [wGoopGasAttackActiveTurns], a
	bank1call ClearChangedTypesIfMuk.ResetChangedTypes
	ret

RocketsSneakAttack_PlayerSelectEffect:
	; default to invalid selection
	ld a, $ff
	ldh [hTemp_ffa0], a

	call SwapTurn
	call CreateHandCardList
	jr nc, .has_hand_cards
	ldtx hl, DuelistHasNoCardsInHandText
	call DrawWideTextBox_WaitForInput
	jr .done
.has_hand_cards
	bank1call InitAndDrawCardListScreenLayout_WithSelectCheckMenu
	ldtx hl, ChooseATrainerCardText_2
	ldtx de, DuelistHandText
	bank1call SetCardListHeaderAndInfoText
.loop_selection
	bank1call DisplayCardList
	jr c, .check_if_can_exit
	ldh a, [hTempCardIndex_ff98]
	call LoadCardDataToBuffer2_FromDeckIndex
	ld a, [wLoadedCard2Type]
	cp TYPE_TRAINER
	jr nz, .loop_selection
	; is Trainer
	ldh a, [hTempCardIndex_ff98]
	ldh [hTemp_ffa0], a
	jr .done

.check_if_can_exit
; player tried exiting
	; check if a Trainer card can be selected (mandatory)
	; if yes, then don't allow exiting
	ld hl, wDuelTempList
.loop_check
	ld a, [hli]
	cp $ff
	jr z, .done
	call LoadCardDataToBuffer2_FromDeckIndex
	ld a, [wLoadedCard2Type]
	cp TYPE_TRAINER
	jr nz, .loop_check
	; has Trainer card, go back to previous loop
	jr .loop_selection
.done
	call SwapTurn
	ret

RocketsSneakAttack_ReturnToDeckEffect:
	ldh a, [hTemp_ffa0]
	cp $ff
	ret z ; no selection
	call SwapTurn
	call RemoveCardFromHand
	call ReturnCardToDeck
	farcall ShuffleCardsInDeck
	call SwapTurn
	ret

HereComesTeamRocketEffect:
	ld a, TRUE
	ld [wPrizeCardsFaceUp], a
	ret

NightlyGarbageRun_CheckDiscardPile:
	call CreatePokemonAndBasicEnergyCardListFromDiscardPile
	ldtx hl, NoRecoverableCardsInDiscardPileText
	ret

NightlyGarbageRun_PlayerSelectEffect:
	xor a
	ldh [hCurSelectionItem], a
	ldtx hl, NightlyGarbageRunPromptText
	call DrawWideTextBox_WaitForInput

	; handles player selection of cards in Discard Pile
	call CreatePokemonAndBasicEnergyCardListFromDiscardPile
.loop_select
	bank1call InitAndDrawCardListScreenLayout_WithSelectCheckMenu
	ldtx hl, ChooseACardToReturnToDeckText
	ldtx de, DuelistDiscardPileText
	bank1call SetCardListHeaderAndInfoText
	bank1call DisplayCardList
	jr nc, .select_card
	ld a, 3
	farcall AskWhetherToQuitSelectingCards
	jr c, .loop_select
	jr .finished
.select_card
	; add this card to list and loop back if not finished
	ldh a, [hTempCardIndex_ff98]
	get_turn_duelist_var
	farcall GetNextPositionInTempList
	ldh a, [hTempCardIndex_ff98]
	ld [hl], a
	call RemoveCardFromDuelTempList
	jr c, .finished
	; needs 3 targets
	ldh a, [hCurSelectionItem]
	cp 3
	jr c, .loop_select
.finished
	farcall GetNextPositionInTempList
	ld [hl], $ff
	or a
	ret

NightlyGarbageRun_ReturnToDeckEffect:
	ld hl, hTemp_ffa0
	ld de, wDuelTempList
.loop_return_to_deck
	ld a, [hli]
	ld [de], a
	inc de
	cp $ff
	jr z, .done_return
	call MoveDiscardPileCardToHand
	call ReturnCardToDeck
	jr .loop_return_to_deck
.done_return
	farcall IsPlayerTurn
	jr c, .finish
	; display list to player
	bank1call DisplayCardListDetails
.finish
	farcall ShuffleCardsInDeck
	ret

; creates list in wDuelTempList with all Pokémon cards
; and Basic energy cards in turn-holder's Discard Pile
; returns carry if Black Hole is active or no such cards
CreatePokemonAndBasicEnergyCardListFromDiscardPile:
	bank1call IsBlackHoleRuleActive
	ret c ; no Discard Pile when Black Hole is active

	; create list of Pokémon and Basic energy cards
	ld a, DUELVARS_NUMBER_OF_CARDS_IN_DISCARD_PILE
	get_turn_duelist_var
	ld b, a
	add DUELVARS_DECK_CARDS
	ld l, a
	ld de, wDuelTempList
	inc b
	jr .next_card
.loop_discard_pile
	ld a, [hl]
	call LoadCardDataToBuffer2_FromDeckIndex
	ld a, [wLoadedCard2Type]
	cp TYPE_ENERGY
	jr c, .add_card_to_list ; pkmn cards
	cp TYPE_ENERGY_DOUBLE_COLORLESS
	jr nc, .next_card
	and TYPE_ENERGY
	jr z, .next_card
	; basic energies
.add_card_to_list
	ld a, [hl]
	ld [de], a
	inc de
.next_card
	dec l
	dec b
	jr nz, .loop_discard_pile
	ld a, $ff ; terminating byte
	ld [de], a

	ld a, [wDuelTempList + 0]
	cp $ff
	jr z, .no_cards
	or a
	ret
.no_cards
	scf
	ret

PotionEnergyEffect:
	ldh a, [hTempPlayAreaLocation_ff9d]
	ld e, a
	call GetCardDamageAndMaxHP
	or a
	ret z ; no damage
	ld a, 10
	call HealPlayAreaPokemon
	ret

FullHealEnergyEffect:
	ldh a, [hTempPlayAreaLocation_ff9d]
	or a
	ret nz ; nothing to do on Bench
	ld a, ATK_ANIM_FULL_HEAL
	call PlaySpecialAttackAnimation

	; clear any status and redraw HUDs
	ld a, DUELVARS_ARENA_CARD_STATUS
	get_turn_duelist_var
	ld [hl], NO_STATUS
	bank1call DrawDuelHUDs
	ret

RainbowEnergyEffect:
	; deals 10 damage to Play Area card
	ldh a, [hTempPlayAreaLocation_ff9d]
	ld b, a
	ld de, 10
	call InflictEnergyOrTrainerCardDamage
	bank1call HandleDestinyBondAndBetweenTurnKnockOuts
	ret

Challenge_PlayerAndOpponentSelectEffect:
	ld a, DUELVARS_DUELIST_TYPE
	call GetNonTurnDuelistVariable
	cp DUELIST_TYPE_LINK_OPP
	jr z, .link_opp
	cp DUELIST_TYPE_PLAYER
	jr z, .player

; ai opponent
	call SwapTurn
	call AIAcceptOrDeclineChallenge
	call SwapTurn
	call .ProcessResponse
	ret c ; declined

	; this is unreachable, AI always declines
	; seems like an attempt was made to have AI work with
	; this card, but then it was scrapped for simplicity
	farcall HandleChallengeCardPlayerSelection
	call SwapTurn
	call AIDecideChallengeCards
	call SwapTurn
	xor a
	ldh [hTemp_ffa0], a
	ret

.player
	call SwapTurn
	bank1call DrawDuelMainScene
	ldtx hl, ChallengePromptText
	call YesOrNoMenuWithText
	call SwapTurn
	call .ProcessResponse
	ret c ; declined

	; have player select cards
	farcall HandleChallengeCardPlayerSelection

	; have AI select cards, but HandleChallengeCardPlayerSelection
	; only works for player selection
	call SwapTurn
	farcall HandleChallengeCardPlayerSelection
	call SwapTurn

	xor a
	ldh [hTemp_ffa0], a
	ret

.link_opp
	ld a, OPPACTION_UNK_1B
	call SetOppAction_SerialSendDuelData
.loop_wait_response
	call SerialRecvByte
	jr nc, .got_response
	halt
	nop
	jr .loop_wait_response
.got_response
	call .ProcessResponse
	ret c ; declined

	; handle player's selection of cards
	farcall HandleChallengeCardPlayerSelection

	; send selection to link opponent
	ld a, OPPACTION_UNK_1C
	call SetOppAction_SerialSendDuelData

	; await other player's selection
	ldtx hl, SelectingPokemonFromDeckText
	call DrawWideTextBox_PrintText
	call SerialRecvDuelData
	call SwapTurn
	ldh a, [hCurSelectionItem]
	ld e, a
	ldh a, [hTemp_ffa0]
	sub e
	inc a
	ldh [hTemp_ffa0], a
	farcall PrintHowManyCardsLinkOpponentChoseDueToChallenge
	call SwapTurn
	xor a
	ldh [hTemp_ffa0], a
	ret

; input:
; - a = TRUE if declined challenge, FALSE if accepted
; output:
; - carry set if challenge was declined
; - either way, $1 is loaded to hTemp_ffa0
.ProcessResponse:
	ldh [hTemp_ffa0], a
	ldtx hl, ChallengeDeclinedText
	or a
	scf ; carry set
	jr nz, .print_text
	ldtx hl, ChallengeAcceptedText
	ld a, $01
	ldh [hTemp_ffa0], a
	or a ; carry not set
.print_text
	push af
	call SwapTurn
	call DrawWideTextBox_WaitForInput
	call SwapTurn
	pop af
	ret

Challenge_DrawOrPlaceInPlayAreaEffect:
	ld hl, hTemp_ffa0
	ld a, [hli]
	or a
	jr z, .loop_add_to_play_area_player

; challenge was declined, draw 2 cards
	ldh a, [hTempCardIndex_ff9f]
	call RemoveCardFromHand
	ld a, 2
	farcall DisplayDrawNCardsScreen
	ld c, 2
.loop_draw
	call DrawCardFromDeck
	jr c, .done_draw
	ldh [hTempCardIndex_ff98], a
	call AddCardToHand
	farcall IsPlayerTurn
	jr nc, .next_draw
	push bc
	bank1call DisplayPlayerDrawCardScreen
	pop bc
.next_draw
	dec c
	jr nz, .loop_draw
.done_draw
	ret

; hTempList holds 2 $ff-terminated lists of cards
; first is the player's cards, and the second is the opponent's cards 
.loop_add_to_play_area_player
	ld a, [hli]
	cp $ff
	jr z, .done_add_to_play_area_player
	push hl
	call SearchCardInDeckAndAddToHand
	call AddCardToHand
	call PutHandPokemonCardInPlayArea
	pop hl
	jr .loop_add_to_play_area_player

.done_add_to_play_area_player
	; shuffle deck
	push hl
	farcall ShuffleCardsInDeck
	pop hl

; process opponent's cards to add to Play Area
	call SwapTurn
.loop_add_to_play_area_opp
	ld a, [hli]
	cp $ff
	jr z, .done_add_to_play_area_opp
	push hl
	call SearchCardInDeckAndAddToHand
	call AddCardToHand
	call PutHandPokemonCardInPlayArea
	pop hl
	jr .loop_add_to_play_area_opp

.done_add_to_play_area_opp
	; shuffle deck
	farcall ShuffleCardsInDeck
	call SwapTurn
	ret

BulbasaurFirstAid_DamageCheck:
	ld e, PLAY_AREA_ARENA
	call GetCardDamageAndMaxHP
	ldtx hl, NoDamageCountersText
	cp 10
	ret

BulbasaurFirstAid_HealEffect:
	ld e, PLAY_AREA_ARENA
	call GetCardDamageAndMaxHP
	or a
	ret z ; no damage to heal
	ld de, 10
	farcall ApplyAndAnimateHPRecovery
	ret

CharmanderGrowlEffect:
	ld a, SUBSTATUS2_GROWL
	farcall ApplySubstatus2ToDefendingCard
	ret

SquirtleWaterPowerEffect:
	ld a, SUBSTATUS1_NEXT_TURN_TRIPLE_DAMAGE
	farcall SetAttackDoubleOrTripleDamageNextTurn
	ret

MetapodGreenShieldEffect:
	scf
	ret

KakunaPoisonFluidEffect:
	scf
	ret

PideyQuickAttack_AIEffect:
	ld a, (10 + 30) / 2
	lb de, 10, 30
	farcall SetExpectedAIDamage
	ret

PideyQuickAttack_DamageBoostEffect:
	ld a, 20
	farcall AddDamageIfHeads
	ret

RattataTailWhipEffect:
	ldtx de, IfHeadsOpponentCannotAttackText
	farcall TossCoin_Bank1a
	jr nc, .tails
; heads
	ld a, SUBSTATUS2_TAIL_WAG
	farcall ApplySubstatus2ToDefendingCard
	ret
.tails
	ld a, ATK_ANIM_TAIL_WHIP_FAILED
	ld [wLoadedAttackAnimation], a
	farcall SetWasUnsuccessful
	ret

PikachuAgilityEffect:
	ldtx de, IfHeadsDoNotReceiveDamageOrEffectText
	farcall TossCoin_Bank1a
	jr nc, .tails
; heads
	ld a, SUBSTATUS1_AGILITY
	farcall ApplySubstatus1ToAttackingCard
	ret
.tails
	ld a, ATK_ANIM_QUICK_ATTACK
	ld [wLoadedAttackAnimation], a
	ret

NidoranFTailWhipEffect:
	ldtx de, IfHeadsOpponentCannotAttackText
	farcall TossCoin_Bank1a
	jr nc, .tails
; heads
	ld a, SUBSTATUS2_TAIL_WAG
	farcall ApplySubstatus2ToDefendingCard
	ret
.tails
	ld a, ATK_ANIM_TAIL_WHIP_FAILED
	ld [wLoadedAttackAnimation], a
	farcall SetWasUnsuccessful
	ret

NidoranMFocusEnergyEffect:
	ld a, SUBSTATUS1_NEXT_TURN_DOUBLE_DAMAGE
	farcall SetAttackDoubleOrTripleDamageNextTurn
	ret

HornRush_AIEffect:
	ld a, 40
	lb de, 0, 40
	farcall SetExpectedAIDamage
	ret

HornRush_NoDamage50PercentEffect:
	ldtx de, AttackSuccessCheckText
	farcall TossCoin_Bank1a
	ret c ; heads
	xor a
	ld [wLoadedAttackAnimation], a
	farcall SetDefiniteDamage
	farcall SetWasUnsuccessful
	ret

FollowMe_AssertPokemonInBench:
	farcall CheckNonTurnDuelistHasBench
	ret

FollowMe_SelectSwitchPokemon:
	ldtx hl, SelectBenchedPokemonToSwitchWithActiveText
	call DrawWideTextBox_WaitForInput
	call SwapTurn
	bank1call HasAlivePokemonInBench
.loop
	bank1call OpenPlayAreaScreenForSelection
	jr c, .loop ; mandatory selection
	ldh a, [hTempPlayAreaLocation_ff9d]
	ldh [hTemp_ffa0], a
	call SwapTurn
	ret

FollowMe_GetBenchPokemonWithLowestHP:
	farcall AIFindTargetForBenchAttack
	ldh [hTemp_ffa0], a
	ret

FollowMe_SwitchDefendingPokemon:
	call SwapTurn
	ldh a, [hTemp_ffa0]
	ld e, a
	bank1call HandlePlayAreaCardNoDamageOrEffect
	call nc, SwapArenaWithBenchPokemon
	call SwapTurn
	xor a
	ld [wDuelDisplayedScreen], a
	ret

HelpingHandEffect_CheckUse:
	; can only use this Pkmn Power on the Bench
	ldh a, [hTempPlayAreaLocation_ff9d]
	ldtx hl, CanOnlyBeUsedOnTheBenchText
	or a
	jr z, .set_carry
	farcall Func_6808d
	farcall CheckIfCanUsePkmnPowerThisTurn
	ret c ; cannot use Pkmn Power

	; only use if Arena card is statused
	ld a, DUELVARS_ARENA_CARD_STATUS
	get_turn_duelist_var
	or a
	ret nz ; has status
	ldtx hl, NotAffectedByStatusText
.set_carry
	scf
	ret

HelpingHandEffect_PlayerSelectEffect:
	; set result as unsuccessful by default
	ld a, $ff
	ldh [hTempPlayAreaLocation_ffa1], a
	ldtx de, IfHeadsHeal1StatusOfYourActiveText
	farcall Serial_TossCoin
	jr c, .heads
	; tails, return
	or a
	ret
.heads
	ld a, DUELVARS_ARENA_CARD_STATUS
	get_turn_duelist_var
	and PSN_DBLPSN
	jr z, .one_status_only
	; has poison
	ld a, [hl]
	and CNF_SLP_PRZ
	jr nz, .two_status
.one_status_only
	xor a
	ldh [hTempPlayAreaLocation_ffa1], a
	ret

.two_status
	; choose between poison and whatever
	; other status Arena card has
	ld a, [hl]
	and CNF_SLP_PRZ
	ldtx hl, EffectTargetSleepText
	cp ASLEEP
	jr z, .got_status
	ldtx hl, EffectTargetParalysisText
	cp PARALYZED
	jr z, .got_status
	ldtx hl, EffectTargetConfusionText
.got_status
	call LoadTxRam2
	bank1call DrawDuelMainScene
	ldtx hl, Choose1StatusToHealText
	call TwoItemHorizontalMenu
	ld e, PSN_DBLPSN ; keep poison, heal cnf/slp/prz
	ldh a, [hCurScrollMenuItem]
	or a
	jr nz, .got_choice
	ld e, CNF_SLP_PRZ ; keep cnf/slp/prz, heal poison
.got_choice
	ld a, e
	ldh [hTempPlayAreaLocation_ffa1], a
	or a
	ret

HelpingHandEffect_HealStatusEffect:
	farcall SetUsedPkmnPowerThisTurnFlag
	ldh a, [hTempPlayAreaLocation_ffa1]
	cp $ff
	ret z ; got tails
	ld a, ATK_ANIM_FULL_HEAL
	call PlaySpecialAttackAnimation
	; hTempPlayAreaLocation_ffa1 holds mask to apply to status
	ldh a, [hTempPlayAreaLocation_ffa1]
	ld e, a
	ld a, DUELVARS_ARENA_CARD_STATUS
	get_turn_duelist_var
	and e
	ld [hl], a
	bank1call DrawDuelHUDs
	ret

WigglytuffExpandEffect:
	ld a, SUBSTATUS1_REDUCE_BY_10
	farcall ApplySubstatus1ToAttackingCard
	ret

GolbatLv25LeechLifeEffect:
	ld hl, wDealtDamage
	ld e, [hl]
	inc hl
	ld d, [hl]
	farcall ApplyAndAnimateHPRecovery
	ret

Nosedive_Recoil50PercentEffect:
	ldtx de, IfTails40DamageToYourselfTooText
	farcall TossCoin_Bank1a
	ldh [hTemp_ffa0], a ; store coin toss result
	ret

Nosedive_RecoilEffect:
	ldh a, [hTemp_ffa0]
	or a
	ret nz ; was heads
	ld a, 40
	call DealRecoilDamageToSelf
	ret

ScatterSpores_CheckDeckAndBench:
	farcall CheckIfDeckIsEmpty
	ret c ; return if deck empty
	farcall CheckIfHasSpaceInBench
	ret

ScatterSpores_PlayerSelectEffect:
	call CreateDeckCardList
	ldtx hl, ChooseAParasFromDeckText
	ldtx bc, EffectTargetParasText
	ld de, DEX_PARAS
	ld a, CARDSEARCH_POKEDEX_NUMBER
	farcall LookForCardsInDeck
	jr c, .got_selection
	ldtx hl, ChooseAParasText
	ldtx de, DuelistDeckText
	farcall SelectCardSearchTarget
.got_selection
	ldh [hTemp_ffa0], a
	ret

ScatterSpores_AISelectEffect:
	ld de, DEX_PARAS
	ld a, CARDSEARCH_POKEDEX_NUMBER
	farcall SetCardSearchFuncParams
	call CreateDeckCardList
	ld hl, wDuelTempList
.loop
	ld a, [hli]
	ldh [hTemp_ffa0], a
	cp $ff
	ret z
	farcall ExecuteCardSearchFunc
	jr nc, .loop
	ret

ScatterSpores_PlaceInPlayAreaEffect:
	ldh a, [hTemp_ffa0]
	cp $ff
	jr z, .no_selection
	ldh [hTempCardIndex_ff98], a
	call SearchCardInDeckAndAddToHand
	call AddCardToHand
	call PutHandPokemonCardInPlayArea
	farcall IsPlayerTurn
	jr c, .no_selection
	; show card to player
	ldh a, [hTemp_ffa0]
	ldtx hl, PlacedOnBenchText
	bank1call DisplayCardDetailScreen
.no_selection
	farcall ShuffleCardsInDeck
	ret

ParasectLeechLifeEffect:
	ld hl, wDealtDamage
	ld e, [hl]
	inc hl
	ld d, [hl]
	farcall ApplyAndAnimateHPRecovery
	ret

TwiddleEffect:
	; inflict confusion if heads
	; and sleep if tails
	ldtx de, ConfusedIfHeadsSleepIfTailsText
	farcall TossCoin_Bank1a
	jr c, .confusion
	farcall SleepEffect
	ret
.confusion
	farcall ConfusionEffect
	ret

PoliwrathHydroPumpEffect:
	lb bc, 3, 0
	farcall ApplyExtraWaterEnergy10DamageBonus
	ret

AbraPsychic_AIEffect:
	ld a, 10
	farcall SetDefiniteDamageAndSetUnaffectedByWR
	ret

AbraPsychic_PlayerSelectEffect:
	farcall HandlePlayerSelectOppPlayAreaPkmn
	ret

AbraPsychic_AISelectEffect:
	farcall AIFindTargetForPlayAreaAttack
	ldh [hTemp_ffa0], a
	ret

AbraPsychic_ArenaDamageEffect:
	ldh a, [hTemp_ffa0]
	or a
	jr nz, .bench
	farcall PreparePlayAreaAttackAgainstArena
	ret c ; unaffected
	ld a, 10
	farcall SetDefiniteDamageAndSetUnaffectedByWR
	ret
.bench
	xor a ; ATK_ANIM_NONE
	ld [wLoadedAttackAnimation], a
	ret

AbraPsychic_BenchDamageEffect:
	ldh a, [hTemp_ffa0]
	or a
	ret z ; is arena
	call SwapTurn
	ld b, a
	ld a, ATK_ANIM_PSYCHIC_BENCH
	ld [wLoadedAttackAnimation], a
	ld de, 10
	call DealDamageToPlayAreaPokemon
	call SwapTurn
	ret

GeodudeHardenEffect:
	ld a, SUBSTATUS1_PREVENT_LESS_THAN_30
	farcall ApplySubstatus1ToAttackingCard
	ret

FlameInferno_AIEffect:
	xor a ; useless
	farcall CreateListOfFireEnergyAttachedToArena
	lb de, 10, 50
	ld c, 10 ; base damage
	cp 2
	jr nc, .at_least_2
	; less than 2 fire energies
	add a ; *2
	call ATimes10
	add 10
	ld e, a ; max damage
	ld c, a
.at_least_2
	ld a, c ; expected damage
	farcall SetExpectedAIDamage
	ret

FlameInferno_AISelectEffect:
	xor a ; 0 cards
	ldh [hTemp_ffa0], a

	farcall CreateListOfFireEnergyAttachedToArena
	ret c ; no fire energies to discard
	ld c, a ; num of cards that can be discarded

	; first check if defending card can be KO'd with no discard
	ld a, DUELVARS_ARENA_CARD_HP
	call GetNonTurnDuelistVariable
	cp 10
	ret c ; can be KO'd, no need to boost damage

	; if defending card can be KO'd with 1 or 2 discards, then do it
	ld b, 1
	cp 40
	jr c, .got_num_to_discard ; hp < 40
	ld b, 2
	cp 60
	jr c, .got_num_to_discard ; 40 <= hp < 60
	; else, only discard if has more than 2 fire energies
	ld a, c
	cp 1
	ret z ; only one fire, don't discard
.got_num_to_discard
	ld hl, wDuelTempList
	ld de, hTemp_ffa0
	ld a, b
	cp c
	ret c ; need more cards to discard than has attached

	; select first b cards to discard
.loop_select_cards
	ld a, [hli]
	ld [de], a
	inc de
	dec b
	jr nz, .loop_select_cards
	ld a, $ff ; terminating byte
	ld [de], a
	ret

FlameInferno_PlayerSelectEffect:
	xor a
	ld [wAttachedEnergyMenuNumerator], a

	; start on 1 because hTemp_ffa0 will hold num cards discarded
	ld a, 1
	ldh [hCurSelectionItem], a

	; create list of fire energies
	farcall CreateListOfFireEnergyAttachedToArena
	jr c, .finish_list

	; start selection
	ldtx hl, ChooseUpTo2FireEnergyPlus20DamageForEachText
	call DrawWideTextBox_WaitForInput
	xor a
	bank1call DisplayEnergyDiscardMenu

	ld a, 2 ; can select up to 2 cards
	ld [wAttachedEnergyMenuDenominator], a
.loop_selection
	bank1call HandleAttachedEnergyMenuInput
	jr nc, .add_card
	; double-check if player wants to exit selection
	ld a, 2 + 1
	farcall AskWhetherToQuitSelectingCards
	jr nc, .finish_list ; player selected yes
	jr .next_card ; player selected no

.add_card
	ld hl, wAttachedEnergyMenuNumerator
	inc [hl]
	farcall GetNextPositionInTempList
	ldh a, [hTempCardIndex_ff98]
	ld [hl], a
	call RemoveCardFromDuelTempList
	jr c, .finish_list
	ldh a, [hCurSelectionItem]
	cp 2 + 1
	jr nc, .finish_list
.next_card
	bank1call UpdateAttachedEnergyMenu
	jr .loop_selection

.finish_list
	farcall GetNextPositionInTempList
	ld [hl], $ff ; terminating byte

	; also output num of cards discarded
	ld a, [wAttachedEnergyMenuNumerator]
	ldh [hTemp_ffa0], a
	or a
	ret

FlameInferno_DiscardAndDamageBoostEffect:
	; discard selected cards
	ld hl, hTempList + 1
.loop_discard
	ld a, [hli]
	cp $ff
	jr z, .calculate_damage_boost
	call DiscardCard
	jr .loop_discard

.calculate_damage_boost
	ldh a, [hTemp_ffa0] ; num cards discarded
	add a
	call ATimes10
	farcall AddToDamage
	ret

KickAway_CheckBench:
	farcall HandleMandatorySwitchSelection
	ldh a, [hTempPlayAreaLocation_ff9d]
	ldh [hTemp_ffa0], a
	ret

KickAway_SwitchEffect:
	ldh a, [hTemp_ffa0]
	farcall HandleSwitchDefendingPokemonEffect
	ret

DoduoGrowlEffect:
	ld a, SUBSTATUS2_GROWL
	farcall ApplySubstatus2ToDefendingCard
	ret

TriAttack_AIEffect:
	ld a, (20 * 3) / 2
	lb de, 0, 60
	farcall SetExpectedAIDamage
	ret

TriAttack_MultiplierEffect:
	ld hl, 20
	call LoadTxRam3
	ldtx de, DamageCheckXDamageTimesHeadsText
	ld a, 3
	farcall TossCoinATimes_Bank1a
	add a
	call ATimes10
	farcall SetDefiniteDamage
	ret

LickitungStomp_AIEffect:
	ld a, (20 + 30) / 2
	lb de, 20, 30
	farcall SetExpectedAIDamage
	ret

LickitungStomp_DamageBoostEffect:
	ld a, 10
	farcall AddDamageIfHeads
	ret

ChanseyDoubleSlap_AIEffect:
	ld a, (20 * 2) / 2
	lb de, 0, 40
	farcall SetExpectedAIDamage
	ret

ChanseyDoubleSlap_MultiplierEffect:
	ld hl, 20
	call LoadTxRam3
	ldtx de, DamageCheckXDamageTimesHeadsText
	ld a, 2
	farcall TossCoinATimes_Bank1a
	add a
	call ATimes10
	farcall SetDefiniteDamage
	ret

DampeningShieldEffect:
	scf
	ret

Juggling_AIEffect:
	ld a, (10 * 4) / 2
	lb de, 0, 40
	farcall SetExpectedAIDamage
	ret

Juggling_MultiplierEffect:
	ld hl, 10
	call LoadTxRam3
	ldtx de, DamageCheckXDamageTimesHeadsText
	ld a, 4
	farcall TossCoinATimes_Bank1a
	call ATimes10
	farcall SetDefiniteDamage
	ret

SlicingThrow_AIEffect:
	ld a, (10 + 20) / 2
	lb de, 10, 20
	farcall SetExpectedAIDamage
	ret

SlicingThrow_DamageBoostEffect:
	ld a, 10
	farcall AddDamageIfHeads
	ret

EeveeLunge_AIEffect:
	ld a, 20
	lb de, 0, 20
	farcall SetExpectedAIDamage
	ret

EeveeLunge_NoDamage50PercentEffect:
	ldtx de, AttackSuccessCheckText
	farcall TossCoin_Bank1a
	ret c ; heads
	xor a
	ld [wLoadedAttackAnimation], a
	farcall SetDefiniteDamage
	farcall SetWasUnsuccessful
	ret

Porygon3DAttack_AIEffect:
	ld a, (10 * 3) / 2
	lb de, 0, 30
	farcall SetExpectedAIDamage
	ret

Porygon3DAttack_MultiplierEffect:
	ld hl, 10
	call LoadTxRam3
	ldtx de, DamageCheckXDamageTimesHeadsText
	ld a, 3
	farcall TossCoinATimes_Bank1a
	call ATimes10
	farcall SetDefiniteDamage
	ret

PorygonLv18Conversion2_ResistanceCheck:
	farcall CheckIfAttackingCardHasResistance
	ret

PorygonLv18Conversion2_PlayerSelectEffect:
	farcall HandleConversion2PlayerSelection
	ret

PorygonLv18Conversion2_AISelectEffect:
	farcall AISelectConversion2Color
	ret

PorygonLv18Conversion2_ChangeResistanceEffect:
	farcall ChangeAttackingCardsResistance
	ret

GuardEffect:
	scf
	ret

RollOverEffect:
	farcall Sleep50PercentEffect
	call SwapTurn
	farcall SleepEffect
	call SwapTurn
	ret

PsycrushEffect:
	; go through all cards in opponent's deck
	; and count how many Psychic/Rainbow cards are in Play Area
	call SwapTurn
	ld a, DUELVARS_CARD_LOCATIONS
	get_turn_duelist_var
	ld c, 0
.loop_cards
	ld a, [hl]
	and CARD_LOCATION_PLAY_AREA
	jr z, .next_card
	ld a, l
	call GetCardIDFromDeckIndex
	cp16 RAINBOW_ENERGY
	jr z, .increment
	cp16 PSYCHIC_ENERGY
	jr nz, .next_card
.increment
	inc c
.next_card
	inc l
	ld a, l
	cp DECK_SIZE
	jr c, .loop_cards
	call SwapTurn

	; inflict 10 times that count
	ld a, c
	call ATimes10
	farcall SetDefiniteDamage
	ret

TheRocketsTrap_CheckHand:
	ld a, DUELVARS_NUMBER_OF_CARDS_IN_HAND
	call GetNonTurnDuelistVariable
	or a
	ret nz ; has cards
	ldtx hl, NoCardsInOpponentsHandText
	scf
	ret

TheRocketsTrap_ReturnToDeck50PercentEffect:
	ldtx de, TheRocketsTrapCheckText
	farcall TossCoin_Bank1a
	ret nc ; tails

	; shuffle other duelist's hand cards
	call SwapTurn
	call CreateHandCardList
	ld hl, wDuelTempList
	call ShuffleCards

	; place terminating byte on end of list
	ld a, $ff
	ld [wDuelTempList + 3], a

	; go through shuffled hand cards and add to wDuelTempList
	ld c, a ; -1
.loop_cards
	inc c
	ld a, [hli]
	cp $ff
	jr z, .got_cards
	call RemoveCardFromHand
	call ReturnCardToDeck
	jr .loop_cards
.got_cards
	ld l, c ; num of cards returned to deck
	ld h, $00
	call LoadTxRam3
	ldtx hl, ReturnedXCardsToDeckText
	call DrawWideTextBox_WaitForInput
	farcall ShuffleCardsInDeck
	call SwapTurn
	ret

FossilExcavation_DeckAndDiscardPileCheck:
	farcall CheckIfDeckIsEmpty
	ret nc ; deck not empty
	bank1call CreateDiscardPileCardList
	ret c ; both deck and discard pile empty
	call CheckIfMysteriousFossilInList
	ldtx hl, NoFossilsInDiscardPileText
	ccf
	ret

FossilExcavation_AISelectEffect:
	; AI will get it from Deck if possible
	call CreateDeckCardList
	call CheckIfMysteriousFossilInList
	ld a, $00
	jr nc, .got_selection
	; otherwise fetch it from Discard Pile
	bank1call CreateDiscardPileCardList
	call CheckIfMysteriousFossilInList
	ld a, $01
	jr nc, .got_selection
	ld a, $ff
.got_selection
	ldh [hTemp_ffa0], a
	; [hTempPlayAreaLocation_ffa1] already has deck index
	; of Mysterious Fossil because of CheckIfMysteriousFossilInList
	ret

; returns carry set if Mysterious Fossil is found in wDuelTempList
; also outputs first card it finds in [hTempPlayAreaLocation_ffa1]
CheckIfMysteriousFossilInList:
	ld hl, wDuelTempList
.loop_find
	ld a, [hli]
	ldh [hTempPlayAreaLocation_ffa1], a
	cp $ff
	ret z ; didn't find any
	call GetCardIDFromDeckIndex
	cp16 MYSTERIOUS_FOSSIL
	jr nz, .loop_find
	scf
	ret

FossilExcavation_PlayerSelectEffect:
.select_deck_or_discard_pile
	ldtx hl, ChooseDeckOrDiscardPileToCheckText
	call TwoItemHorizontalMenu
	ldh [hTemp_ffa0], a
	jr nc, .deck

; discard pile
	bank1call CreateDiscardPileCardList
	jr c, .select_deck_or_discard_pile
	call CheckIfMysteriousFossilInList
	jr c, .pick_from_discard_pile
	; no Mysterious Fossil in Discard Pile
	ldtx hl, NoFossilsInDiscardPileText
	call DrawWideTextBox_WaitForInput
	jr .select_deck_or_discard_pile

.pick_from_discard_pile
	bank1call InitAndDrawCardListScreenLayout
	ldtx de, DuelistDiscardPileText
	ldtx hl, ChooseAFossilText
	bank1call SetCardListHeaderAndInfoText
.loop_discard_pile_input
	bank1call DisplayCardList
	jr c, .loop_discard_pile_input
	ldh [hTempPlayAreaLocation_ffa1], a
	call GetCardIDFromDeckIndex
	cp16 MYSTERIOUS_FOSSIL
	jr nz, .loop_discard_pile_input
	ret

.deck
	call CreateDeckCardList
	jr c, .select_deck_or_discard_pile
	ldtx hl, ChooseAFossilFromDeckText
	ldtx bc, EffectTargetFossilText
	ld de, MYSTERIOUS_FOSSIL
	xor a ; CARDSEARCH_CARD_ID
	farcall LookForCardsInDeck
	jr c, .got_selection
	ldtx hl, ChooseAFossilText
	ldtx de, DuelistDeckText
	farcall SelectCardSearchTarget
.got_selection
	ldh [hTempPlayAreaLocation_ffa1], a
	ret

FossilExcavation_AddToHandEffect:
	ldh a, [hTemp_ffa0]
	or a
	jr z, .get_from_deck

	; get from Discard Pile
	ldh a, [hTempPlayAreaLocation_ffa1]
	ldh [hTempCardIndex_ff98], a
	call MoveDiscardPileCardToHand
	call AddCardToHand
	farcall IsPlayerTurn
	ret c
	; display it to the player
	bank1call DisplayPlayerDrawCardScreen
	ret

.get_from_deck
	ldh a, [hTempPlayAreaLocation_ffa1]
	ldh [hTempCardIndex_ff98], a
	cp $ff
	jr z, .finish ; no valid card in deck
	call SearchCardInDeckAndAddToHand
	call AddCardToHand
	farcall IsPlayerTurn
	jr c, .finish
	; display it to the player
	bank1call DisplayPlayerDrawCardScreen
.finish
	farcall ShuffleCardsInDeck
	ret

MoonStone_DeckCheck:
	farcall CheckIfDeckIsEmpty
	ret

MoonStone_AISelectEffect:
	; AI always chooses no target here since
	; this is handled in Trainer-specific logic
	ld a, $ff
	ldh [hTemp_ffa0], a
	ret

MoonStone_PlayerSelectEffect:
	call CreateDeckCardList
	ldtx hl, ChooseAColorlessEvolutionCardText
	ldtx bc, EffectTargetColorlessEvolutionCardText
	ld a, CARDSEARCH_EVOLUTION_COLORLESS_POKEMON
	farcall LookForCardsInDeck
	jr c, .got_selection
	ldtx hl, ChooseAColorlessEvolutionPokemonText
	ldtx de, DuelistDeckText
	farcall SelectCardSearchTarget
.got_selection
	ldh [hTemp_ffa0], a
	ret

MoonStone_AddToHandEffect:
	ldh a, [hTemp_ffa0]
	cp $ff
	jr z, .finish
	call SearchCardInDeckAndAddToHand
	call AddCardToHand
	farcall IsPlayerTurn
	jr c, .finish
	ldh a, [hTemp_ffa0]
	ldtx hl, WasPlacedInTheHandText
	bank1call DisplayCardDetailScreen
.finish
	farcall ShuffleCardsInDeck
	ret

MaxRevive_DiscardPileAndHandCheck:
	farcall CheckIfHasSpaceInBench
	ret c ; no space in Bench
	farcall CreateBasicPkmnCardListFromDiscardPile
	ret c ; no Basics
	bank1call CreateEnergyCardListFromHand
	ldtx hl, NotEnoughEnergyCardsInHandText
	cp 2 ; carry set if less than 2 energy cards in hand
	ret

MaxRevive_PlayerSelectEffect:
	ldtx hl, Choose2EnergyCardsFromHandToDiscardText
	ldtx de, ChooseTheCardToDiscardText
	push de
	call DrawWideTextBox_WaitForInput
	bank1call CreateEnergyCardListFromHand
	xor a
	ldh [hCurSelectionItem], a
	pop hl
.loop_select_energy_cards
	push hl
	bank1call InitAndDrawCardListScreenLayout_WithSelectCheckMenu
	pop hl
	bank1call SetCardListInfoBoxText
	push hl
	bank1call DisplayCardList
	pop hl
	jr c, .cancelled
	push hl
	farcall GetNextPositionInTempList
	ldh a, [hTempCardIndex_ff98]
	ld [hl], a
	call RemoveCardFromDuelTempList
	pop hl
	ldh a, [hCurSelectionItem]
	cp 2
	jr c, .loop_select_energy_cards

	; energy cards in hand done, now select Pkmn in Discard Pile
	farcall CreateBasicPkmnCardListFromDiscardPile
	bank1call InitAndDrawCardListScreenLayout_WithSelectCheckMenu
	ldtx hl, PleaseSelectCardText
	ldtx de, DuelistDiscardPileText
	bank1call SetCardListHeaderAndInfoText
	bank1call DisplayCardList
	jr c, .cancelled
	ldh a, [hTempCardIndex_ff98]
	ldh [hTempList + 2], a
	or a
	ret

.cancelled
	scf
	ret

MaxRevive_DiscardAndPlaceInBenchEffect:
	ld hl, hTempList
	ld a, [hli] ; first energy
	call RemoveCardFromHand
	call PutCardInDiscardPile
	ld a, [hli] ; second energy
	call RemoveCardFromHand
	call PutCardInDiscardPile

	ld a, [hl] ; pkmn card
	call MoveDiscardPileCardToHand
	call AddCardToHand
	call PutHandPokemonCardInPlayArea

	farcall IsPlayerTurn
	jr c, .done
	ldh a, [hTempList + 2]
	ldtx hl, PlacedOnBenchText
	bank1call DisplayCardDetailScreen
.done
	ret

MasterBall_DeckCheck:
	farcall CheckIfDeckIsEmpty
	ret

MasterBall_PlayerSelectEffect:
	ld c, 7
	ld a, DUELVARS_NUMBER_OF_CARDS_NOT_IN_DECK
	get_turn_duelist_var
	ld a, DECK_SIZE
	sub [hl]
	; a = number of cards in deck
	cp c
	jr nc, .got_num_cards
	; less than 7 cards, load c with num of card in deck
	ld c, a

.got_num_cards
	; create list at wDuelTempList
	; with top c cards
	ld de, wDuelTempList
	ld a, [hl]
	add DUELVARS_DECK_CARDS
	ld l, a
.loop_create_list
	ld a, [hli]
	ld [de], a
	inc de
	dec c
	jr nz, .loop_create_list
	ld a, $ff ; terminating byte
	ld [de], a

	; show selection screen
	bank1call InitAndDrawCardListScreenLayout_WithSelectCheckMenu
	ldtx hl, ChooseBasicOrEvolutionCardText
	ldtx de, DuelistDeckText
	bank1call SetCardListHeaderAndInfoText
.loop_selection
	bank1call DisplayCardList
	jr c, .try_exit
	ldh [hTemp_ffa0], a
	call CheckIfCardIsNotPkmn
	jr c, .loop_selection ; not a Pkmn
.done
	or a
	ret

.try_exit
	; only exit if player cannot choose a Pokémon card
	; will exit with $ff in hTemp_ffa0, in case there are no valid targets
	ld hl, wDuelTempList
.loop_check
	ld a, [hli]
	ldh [hTemp_ffa0], a
	cp $ff
	jr z, .done
	call CheckIfCardIsNotPkmn
	jr nc, .loop_selection
	jr .loop_check

MasterBall_AddToHandEffect:
	ldh a, [hTemp_ffa0]
	cp $ff
	jr z, .finish
	call SearchCardInDeckAndAddToHand
	call AddCardToHand
	ldh [hTempCardIndex_ff98], a
	farcall IsPlayerTurn
	jr c, .finish
	bank1call DisplayPlayerDrawCardScreen
.finish
	farcall ShuffleCardsInDeck
	ret

; returns carry if card index given in a
; is not a Pokémon card
CheckIfCardIsNotPkmn:
	call LoadCardDataToBuffer2_FromDeckIndex
	ld a, [wLoadedCard2Type]
	cp TYPE_ENERGY
	ccf
	; carry set if is not Pkmn
	ret

PokemonRecall_DiscardPileCheck:
	jr CreateListOfEvolutionCardsFromDiscardPile

PokemonRecall_PlayerSelectEffect:
	call CreateListOfEvolutionCardsFromDiscardPile
	bank1call InitAndDrawCardListScreenLayout_WithSelectCheckMenu
	ldtx hl, PleaseSelectCardText
	ldtx de, DuelistDiscardPileText
	bank1call SetCardListHeaderAndInfoText
	bank1call DisplayCardList
	ldh a, [hTempCardIndex_ff98]
	ldh [hTemp_ffa0], a
	; if player cancelled during DisplayCardList,
	; then carry is set here and effect will not continue
	ret

PokemonRecall_AddToHandEffect:
	ldh a, [hTemp_ffa0]
	call MoveDiscardPileCardToHand
	call ReturnCardToDeck
	farcall IsPlayerTurn
	ret c
	ldtx hl, CardWasChosenText
	ldh a, [hTemp_ffa0]
	bank1call DisplayCardDetailScreen
	ret

CreateListOfEvolutionCardsFromDiscardPile:
	bank1call IsBlackHoleRuleActive
	ret c ; can't access discard pile

	; create list of Evolution cards in Discard Pile
	ld a, DUELVARS_NUMBER_OF_CARDS_IN_DISCARD_PILE
	get_turn_duelist_var
	ld b, a
	add DUELVARS_DECK_CARDS
	ld l, a
	ld de, wDuelTempList
	inc b
	jr .next_card
.loop_discard_pile
	ld a, [hl]
	call LoadCardDataToBuffer2_FromDeckIndex
	ld a, [wLoadedCard2Type]
	cp TYPE_ENERGY
	jr nc, .next_card
	ld a, [wLoadedCard2Stage]
	or a
	jr z, .next_card
	; is Evolution card
	ld a, [hl]
	ld [de], a
	inc de
.next_card
	dec l
	dec b
	jr nz, .loop_discard_pile
	ld a, $ff ; terminating byte
	ld [de], a

	ld a, [wDuelTempList + 0]
	cp $ff
	jr z, .no_evolution_cards
	or a
	ret
.no_evolution_cards
	ldtx hl, NoEvolutionCardsInDiscardPileText
	scf
	ret

BillsComputerEffect:
	; cannot use card
	ldtx hl, CannotUseText
	scf
	ret

ComputerError_DecksCheck:
	farcall CheckIfDeckIsEmpty
	ret nc ; deck no empty
	call SwapTurn
	farcall CheckIfDeckIsEmpty
	call SwapTurn
	ret

ComputerError_PlayerAndOppSelection:
	farcall HandleComputerErrorPlayerSelection
	ldh [hTemp_ffa0], a
	call .OtherDuelist
	ldh [hTempPlayAreaLocation_ffa1], a
	ret

.OtherDuelist:
	ld a, DUELVARS_DUELIST_TYPE
	call GetNonTurnDuelistVariable
	cp DUELIST_TYPE_LINK_OPP
	jr z, .link_opp
	cp DUELIST_TYPE_PLAYER
	jr z, .player
	call SwapTurn
	call AIChooseCardsToDrawFromComputerError
	call SwapTurn
	ret

.player
	call SwapTurn
	farcall HandleComputerErrorPlayerSelection
	call SwapTurn
	ret

.link_opp
	ld a, OPPACTION_UNK_1A
	call SetOppAction_SerialSendDuelData
.loop_wait
	call SerialRecvByte
	jr nc, .got_response
	halt
	nop
	jr .loop_wait
.got_response
	ret

ComputerError_DrawEffect:
	ldh a, [hTempCardIndex_ff9f]
	call RemoveCardFromHand

	; turn duelist draws
	ldh a, [hTemp_ffa0]
	call .DrawCards

	; non-turn duelist draws
	call SwapTurn
	ldh a, [hTempPlayAreaLocation_ffa1]
	call .DrawCards
	call SwapTurn

	; turn will end due to effect
	ld a, TRUE
	ld [wTurnEndedDueToComputerError], a
	ret

; input:
; - a = number of cards chosen to draw
.DrawCards:
	or a
	ret z ; no cards to draw
	push af
	farcall DisplayDrawNCardsScreen
	pop af
	ld c, a
.loop_draw
	call DrawCardFromDeck
	ldh [hTempCardIndex_ff98], a
	call AddCardToHand
	farcall IsPlayerTurn
	jr nc, .skip_display_card
	push bc
	bank1call DisplayPlayerDrawCardScreen
	pop bc
.skip_display_card
	dec c
	jr nz, .loop_draw
	ret

SpearowFuryAttack_AIEffect:
	ld a, 10 * 2 ; bug, should be (10 * 2) / 2
	lb de, 0, 40 ; bug, should be 0, 20
	farcall SetExpectedAIDamage
	ret

SpearowFuryAttack_MultiplierEffect:
	ld hl, 10
	call LoadTxRam3
	ldtx de, DamageCheckXDamageTimesHeadsText
	ld a, 2
	farcall TossCoinATimes_Bank1a
	call ATimes10
	farcall SetDefiniteDamage
	ret

FearowQuickAttack_AIEffect:
	ld a, (10 + 30) / 2
	lb de, 10, 30
	farcall SetExpectedAIDamage
	ret

FearowQuickAttack_DamageBoostEffect:
	ld a, 20
	farcall AddDamageIfHeads
	ret

DrillDescent_AIEffect:
	ld a, 50
	lb de, 0, 50
	farcall SetExpectedAIDamage
	ret

DrillDescent_NoDamage50PercentEffect:
	ldtx de, AttackSuccessCheckText
	farcall TossCoin_Bank1a
	ret c ; heads
	xor a
	ld [wLoadedAttackAnimation], a
	farcall SetDefiniteDamage
	farcall SetWasUnsuccessful
	ret

ShortCircuit_WaterEnergyCheck:
	; loop all deck cards to find either
	; a Water or Rainbow energy in the Play Area
	call SwapTurn
	ld a, DUELVARS_CARD_LOCATIONS
	get_turn_duelist_var
.loop_deck
	bit CARD_LOCATION_PLAY_AREA_F, [hl]
	jr z, .next_card
	ld a, l
	call GetCardIDFromDeckIndex
	cp16 WATER_ENERGY
	jr z, .no_carry
	cp16 RAINBOW_ENERGY
	jr z, .no_carry
.next_card
	inc l
	ld a, l
	cp DECK_SIZE
	jr c, .loop_deck

	; no Water/Rainbow energy in Play Area
	call SwapTurn
	ldtx hl, NoWaterEnergyText
	scf
	ret

.no_carry
	call SwapTurn
	or a
	ret

ShortCircuit_PlayerSelectEffect:
	ldtx hl, ChoosePokemonWithWaterEnergyText
	call DrawWideTextBox_WaitForInput
	call SwapTurn
	bank1call HasAlivePokemonInPlayArea
.loop_selection
	bank1call OpenPlayAreaScreenForSelection
	jr c, .loop_selection ; mandatory selection
	ldh a, [hTempPlayAreaLocation_ff9d]
	ldh [hTemp_ffa0], a
	call GetNumberOfWaterEnergiesAttachedToPlayAreaCard
	; does it have any Water energies?
	or a
	jr z, .loop_selection ; no, loop back
	; at least one
	call SwapTurn
	ret

ShortCircuit_AISelectEffect:
	; choose play area location with most Water cards attached
	call SwapTurn
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var

	; AI builds a list in wPlayAreaList, that corresponds to number of
	; Water energies attached for each Play Area card
	; but it seems like it goes to waste, since it just chooses
	; the one with the most Water energies attached
	ld hl, wPlayAreaList

	lb de, 0, 0
	ld c, a ; num pokemon in play
	ld b, PLAY_AREA_ARENA
.loop_play_area
	push hl
	push de
	push bc
	ld a, b
	call GetNumberOfWaterEnergiesAttachedToPlayAreaCard
	pop bc
	pop de
	pop hl
	ld [hli], a ; num Water energies
	cp d
	jr nc, .next_play_area_pkmn
	ld d, a ; new max
	ld e, b ; play area location of max
.next_play_area_pkmn
	inc b
	dec c
	jr nz, .loop_play_area
	ld a, e
	ldh [hTemp_ffa0], a
	call SwapTurn
	ret

ShortCircuit_DamageArenaEffect:
	ldh a, [hTemp_ffa0]
	or a
	jr nz, .bench
	farcall PreparePlayAreaAttackAgainstArena
	ret c ; unaffected
	call SwapTurn
	xor a ; PLAY_AREA_ARENA
	call GetNumberOfWaterEnergiesAttachedToPlayAreaCard
	call SwapTurn
	call ATimes10
	farcall SetDefiniteDamageAndSetUnaffectedByWR
	ret
.bench
	xor a ; ATK_ANIM_NONE
	ld [wLoadedAttackAnimation], a
	ret

ShortCircuit_DamageBenchEffect:
	ldh a, [hTemp_ffa0]
	or a
	ret z ; arena
	ld a, ATK_ANIM_SHORT_CIRCUIT_BENCH
	ld [wLoadedAttackAnimation], a
	call SwapTurn
	ldh a, [hTemp_ffa0]
	call GetNumberOfWaterEnergiesAttachedToPlayAreaCard
	call ATimes10
	ld e, a
	ld d, 0
	ldh a, [hTemp_ffa0]
	ld b, a
	call DealDamageToPlayAreaPokemon
	call SwapTurn
	ret

; input:
; - a = PLAY_AREA_* constant
; output:
; - a = number of Water/Rainbow energies attached to Play Area card
GetNumberOfWaterEnergiesAttachedToPlayAreaCard:
	or CARD_LOCATION_ARENA
	ld [wce01], a
	ld a, TYPE_ENERGY_WATER
	farcall CreateListOfEnergyAttachedToPlayAreaCard
	ret

SetSandshrewSwiftDamage:
	ld de, 20
	jr CalculateDamageImmuneToDefendingCardEffects_GotDamage

SandshrewSwift_BeforeDamage:
	call SetSandshrewSwiftDamage
	jr PlaySwiftAnimationAndZeroDamage

SandshrewSwift_AfterDamage:
	call SetSandshrewSwiftDamage
	jr DealDamageImmuneToDefendingCardEffects

; for Sandshrew's Swift attack, do everything that a normal attack
; would do except check of substatus/pkmn powers/other effects
; damage calculation is done here and applied "manually"
; gets damage from DUELVARS_ARENA_CARD_LAST_TURN_DAMAGE
CalculateDamageImmuneToDefendingCardEffects:
	ld a, DUELVARS_ARENA_CARD_LAST_TURN_DAMAGE
	get_turn_duelist_var
	ld e, a
	inc hl
	ld d, [hl]
;	fallthrough

; input:
; - de = base damage to inflict
; output:
; - de = damage after attacking card modifiers
CalculateDamageImmuneToDefendingCardEffects_GotDamage:
	bank1call HandleDamageModifiersEffects
	ld a, DUELVARS_ARENA_CARD_ATTACHED_PLUSPOWER
	get_turn_duelist_var
	call ATimes10
	ld l, a
	ld h, $00
	add hl, de
	ld e, l
	ld d, h
	call LoadTxRam3
	ld hl, wDamage
	ld [hl], e
	inc hl
	ld [hl], d
	ret

PlayMirrorMoveSwiftAnimationAndZeroDamage:
	call CalculateDamageImmuneToDefendingCardEffects
PlaySwiftAnimationAndZeroDamage:
	ld a, ATK_ANIM_SWIFT
	call PlaySpecialAttackAnimation
	xor a
	ld [wLoadedAttackAnimation], a
	farcall SetDefiniteDamage
	ld a, DUELVARS_ARENA_CARD_LAST_TURN_EFFECT
	call GetNonTurnDuelistVariable
	ld [hl], LAST_TURN_EFFECT_SWIFT
	ret

DealMirrorMoveSwiftDamage:
	call CalculateDamageImmuneToDefendingCardEffects
DealDamageImmuneToDefendingCardEffects:
	ld hl, wDealtDamage
	ld a, e
	add [hl]
	ld [hli], a
	ld a, d
	adc [hl]
	ld [hl], a
	ld a, DUELVARS_ARENA_CARD_HP
	call GetNonTurnDuelistVariable
	call SubtractHP
	call PrintKnockedOutIfHLZero
	ret

StirUpTwister_AISelectEffect:
	; handle own switch
	farcall HandleMandatorySwitchSelection
	ldh a, [hTempPlayAreaLocation_ff9d]
	ldh [hTemp_ffa0], a

	; handle player switch
	farcall CheckIfTurnDuelistHasBench
	ld c, a
	ld a, $ff ; output $ff if player has no bench
	jr c, .no_bench
	; otherwise pick a random bench Pokémon
	ld a, c
	dec a
	call Random
	inc a
.no_bench
	ldh [hTempPlayAreaLocation_ffa1], a
	ret

StirUpTwister_PlayerSelectEffect:
	; handle own switch
	farcall HandleMandatorySwitchSelection
	ldh a, [hTempPlayAreaLocation_ff9d]
	ldh [hTemp_ffa0], a
	cp $ff
	jr z, .select_opp_switch
	farcall IsPlayerTurn
	jr nc, .select_opp_switch
	call SwapTurn
	ldh a, [hTemp_ffa0]
	farcall DrawPlayAreaScreenToShowChanges
	call SwapTurn

.select_opp_switch
	call SwapTurn
	farcall HandleMandatorySwitchSelection
	call SwapTurn
	ldh a, [hTempPlayAreaLocation_ff9d]
	ldh [hTempPlayAreaLocation_ffa1], a
	ret

StirUpTwister_SwitchEffect:
	; switch defending card first
	ldh a, [hTemp_ffa0]
	farcall HandleSwitchDefendingPokemonEffect

	ldh a, [hTempPlayAreaLocation_ffa1]
	cp $ff
	ret z
	ldh a, [hTemp_ffa0]
	add DUELVARS_ARENA_CARD_HP
	call GetNonTurnDuelistVariable
	or a
	jr nz, .no_ko
	; was KO'd by attack, in case it has Destiny Bond
	; then skip switching out attacking card
	ld a, [wcd0b]
	cp SUBSTATUS1_DESTINY_BOND
	jr z, .skip_attacking_switch
.no_ko
	ldh a, [hTempPlayAreaLocation_ffa1]
	ld [wcd0a], a
	ld e, a
	call SwapArenaWithBenchPokemon
.skip_attacking_switch
	xor a
	ld [wDuelDisplayedScreen], a
	ret

RainbowPowderEffect:
	ldtx de, ParalyzedIfHeadsPoisonedIfTailsText
	farcall TossCoin_Bank1a
	jr c, .paralysis
; poison
	farcall PoisonEffect
	ret
.paralysis
	farcall ParalysisEffect
	ret

FocusedOneShotEffect:
	ldtx de, FocusedOneShotCheckText
	farcall TossCoin_Bank1a
	jr c, .heads

	; was tails, next turn cannot use Corkscrew Punch
	ld a, SUBSTATUS1_CANNOT_USE_CORKSCREW_PUNCH
	farcall ApplySubstatus1ToAttackingCardAndSetCountdown
	ld a, ATK_ANIM_FOCUSED_ONE_SHOT_FAILED
	ld [wLoadedAttackAnimation], a
	ret

.heads
	; heads, next turn Corkscrew Punch is double damage
	ld a, SUBSTATUS1_NEXT_TURN_DOUBLE_DAMAGE
	farcall SetAttackDoubleOrTripleDamageNextTurn
	ret

CorkscrewPunchEffect:
	ld a, SUBSTATUS1_CANNOT_USE_CORKSCREW_PUNCH
	farcall CheckIfHasSubstatusThatPreventsUsingAttack
	ret

SteadyPunch_AIEffect:
	ld a, (30 + 50) / 2
	lb de, 30, 50
	farcall SetExpectedAIDamage
	ret

SteadyPunch_DamageBoostEffect:
	ld a, 20
	farcall AddDamageIfHeads
	ret

GravelerStoneBarrage_AIEffect:
	ld a, 20
	lb de, 0, 100
	farcall SetExpectedAIDamage
	ret

GravelerStoneBarrage_MultiplierEffect:
	xor a
	ldh [hTemp_ffa0], a
.loop_coin_toss
	ldtx de, FlipUntilTails20DamageTimesHeadsText
	xor a
	farcall TossCoinATimes_Bank1a
	jr nc, .tails
	ld hl, hTemp_ffa0
	inc [hl] ; increase heads count
	jr .loop_coin_toss

.tails
; store resulting damage
	ldh a, [hTemp_ffa0]
	ld l, a
	ld h, 20
	call HtimesL
	ld de, wDamage
	ld a, l
	ld [de], a
	inc de
	ld a, h
	ld [de], a
	ret

GravelerEarthquakeEffect:
	farcall SetIsDamageToSelf
	ld a, 10
	farcall DealDamageToAllBenchedPokemon
	farcall UnsetIsDamageToSelf
	ret

MagnetMove_CheckUse:
	farcall Func_6808d
	farcall CheckIfCanUsePkmnPowerThisTurn
	ret c
	farcall CheckIfDeckIsEmpty
	ret c
	farcall CheckIfHasSpaceInBench
	ret

MagnetMove_PlayerSelectEffect:
	ldtx de, MagnetCheckText
	farcall Serial_TossCoin
	ldh [hTempPlayAreaLocation_ffa1], a
	jr c, .successful

; unsuccessful
	farcall SetWasUnsuccessful
	call PrintFailedEffectText
	call WaitForWideTextBoxInput
	or a
	ret

.successful
	call CreateDeckCardList
	ldtx hl, ChooseAMagnemiteFromDeckText
	ldtx bc, EffectTargetMagnemiteText
	ld de, DEX_MAGNEMITE
	ld a, CARDSEARCH_POKEDEX_NUMBER
	farcall LookForCardsInDeck
	jr c, .got_selection
	ldtx hl, ChooseAMagnemiteText
	ldtx de, DuelistDeckText
	farcall SelectCardSearchTarget
.got_selection
	ldh [hPlayAreaEffectTarget], a
	or a
	ret

MagnetMove_AISelectEffect:
	ldtx de, MagnetCheckText
	farcall Serial_TossCoin
	ldh [hTempPlayAreaLocation_ffa1], a
	ret nc
	ld de, DEX_MAGNEMITE
	ld a, CARDSEARCH_POKEDEX_NUMBER
	farcall SetCardSearchFuncParams
	call CreateDeckCardList
	ld hl, wDuelTempList
.loop
	ld a, [hli]
	ldh [hPlayAreaEffectTarget], a
	cp $ff
	ret z
	farcall ExecuteCardSearchFunc
	jr nc, .loop
	ret

MagnetMove_AddToPlayAreaEffect:
	farcall SetUsedPkmnPowerThisTurnFlag
	ldh a, [hTempPlayAreaLocation_ffa1]
	or a
	ret z ; not successful
	ldh a, [hPlayAreaEffectTarget]
	cp $ff
	jr z, .finish
	call SearchCardInDeckAndAddToHand
	call AddCardToHand
	call PutHandPokemonCardInPlayArea
	farcall IsPlayerTurn
	jr c, .finish
	; show card to player
	ldh a, [hPlayAreaEffectTarget]
	ldtx hl, PlacedOnBenchText
	bank1call DisplayCardDetailScreen
.finish
	farcall ShuffleCardsInDeck
	ret

Superconductivity_AIEffect:
	ld a, 10
	farcall SetDefiniteDamageAndSetUnaffectedByWR
	ret

Superconductivity_AISelectEffect:
	farcall AIFindTargetForPlayAreaAttack
	ldh [hTemp_ffa0], a
	ret

Superconductivity_PlayerSelectEffect:
	farcall HandlePlayerSelectOppPlayAreaPkmn
	ret

Superconductivity_DamageArenaEffect:
	ldh a, [hTemp_ffa0]
	or a
	jr nz, .bench
	farcall PreparePlayAreaAttackAgainstArena
	ret c
	ld a, 10
	farcall SetDefiniteDamageAndSetUnaffectedByWR
	ret
.bench
	xor a ; ATK_ANIM_NONE
	ld [wLoadedAttackAnimation], a
	ret

Superconductivity_DamageBenchEffect:
	ldh a, [hTemp_ffa0]
	or a
	ret z ; arena
	call SwapTurn
	ld b, a
	ld a, ATK_ANIM_SUPERCONDUCTIVITY_BENCH
	ld [wLoadedAttackAnimation], a
	ld de, 10
	call DealDamageToPlayAreaPokemon
	call SwapTurn
	ret

Microwave_InitialEffect:
	farcall Func_6808d
	ret

Microwave_AIEffect:
	ld a, 20
	farcall SetDefiniteDamageAndSetUnaffectedByWR
	ret

Microwave_AISelectEffect:
	farcall AIFindTargetForPlayAreaAttack
	ldh [hTemp_ffa0], a
	call SwapTurn
	call CreateArenaOrBenchEnergyCardList
	ldh [hTempPlayAreaLocation_ffa1], a
	call SwapTurn
	ret c ; no energy cards
	ldtx de, IfHeadsDiscard1EnergyCardText
	farcall Serial_TossCoin
	ldh [hTempPlayAreaLocation_ffa1], a
	ret nc ; tails

	; select energy card to discard
	call SwapTurn
	ldh a, [hTemp_ffa0]
	call CreateArenaOrBenchEnergyCardList
	call SwapTurn
	; simply select first card in list
	ld a, [wDuelTempList + 0]
	ldh [hPlayAreaEffectTarget], a
	ret

Microwave_PlayerSelectEffect:
	farcall HandlePlayerSelectOppPlayAreaPkmn
	call SwapTurn
	call CreateArenaOrBenchEnergyCardList
	ldh [hTempPlayAreaLocation_ffa1], a
	call SwapTurn
	ret c ; no energy cards
	ldtx de, IfHeadsDiscard1EnergyCardText
	farcall Serial_TossCoin
	ldh [hTempPlayAreaLocation_ffa1], a
	ret nc ; tails

	; select energy card to discard
	call SwapTurn
	ldh a, [hTemp_ffa0]
	bank1call DisplayEnergyDiscardMenu
.loop
	bank1call HandleAttachedEnergyMenuInput
	jr c, .loop ; mandatory selection
	call SwapTurn
	ldh a, [hTempCardIndex_ff98]
	ldh [hPlayAreaEffectTarget], a
	ret

Microwave_ArenaDamageEffect:
	ldh a, [hTemp_ffa0]
	or a
	jr nz, .bench
	farcall PreparePlayAreaAttackAgainstArena
	ret c
	ld a, 20
	farcall SetDefiniteDamageAndSetUnaffectedByWR
	ret
.bench
	xor a ; ATK_ANIM_NONE
	ld [wLoadedAttackAnimation], a
	ret

Microwave_BenchDamageAndDiscardEffect:
	ldh a, [hTemp_ffa0]
	or a
	jr z, .arena
	call SwapTurn
	ld a, ATK_ANIM_THUNDER_WAVE_BENCH
	ld [wLoadedAttackAnimation], a
	ldh a, [hTemp_ffa0]
	ld b, a
	ld de, 20
	call DealDamageToPlayAreaPokemon
	call SwapTurn
.arena
	ldh a, [hTempPlayAreaLocation_ffa1]
	or a
	ret z ; no energy to discard
	call SwapTurn
	ldh a, [hTemp_ffa0]
	ld e, a
	bank1call HandlePlayAreaCardNoDamageOrEffect
	jr c, .skip_discard
	ldh a, [hPlayAreaEffectTarget]
	call DiscardCard
.skip_discard
	call SwapTurn
	ldh a, [hTemp_ffa0]
	or a
	ret nz
	ld a, DUELVARS_ARENA_CARD_LAST_TURN_EFFECT
	call GetNonTurnDuelistVariable
	ld [hl], LAST_TURN_EFFECT_DISCARD_ENERGY
	ret

SeelGrowlEffect:
	ld a, SUBSTATUS2_GROWL
	farcall ApplySubstatus2ToDefendingCard
	ret

Rest_SleepEffect:
	; clear all status
	ld a, DUELVARS_ARENA_CARD_STATUS
	get_turn_duelist_var
	ld [hl], NO_STATUS
	; set attacking card to sleep
	call SwapTurn
	farcall SleepEffect
	call SwapTurn
	ret

Rest_HealEffect:
	ld e, PLAY_AREA_ARENA
	call GetCardDamageAndMaxHP
	ld e, a ; heal all damage
	ld d, 0
	farcall ApplyAndAnimateHPRecovery
	ret

WaterSpoutEffect:
	lb bc, 1, 1
	farcall ApplyExtraWaterEnergy10DamageBonus
	ret

RockSealEffect:
	ldtx de, IfHeadsOpponentCannotRetreatText
	farcall TossCoin_Bank1a
	ret nc ; tails
	ld a, SUBSTATUS2_ROCK_SEAL
	farcall ApplySubstatus2ToDefendingCard
	ret

GroupSparkEffect:
	ld e, 0 ; tally number of Voltorb in play
	call .CountVoltorbInPlayArea
	call SwapTurn
	call .CountVoltorbInPlayArea
	call SwapTurn
	ld a, e ; num of total Voltorb
	call ATimes10
	farcall AddToDamage
	ret

.CountVoltorbInPlayArea:
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	ld b, a
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
.loop_play_area
	ld a, [hli]
	cp $ff
	jr z, .empty_slot
	call LoadCardDataToBuffer1_FromDeckIndex
	ld a, [wLoadedCard1PokedexNumber]
	cp DEX_VOLTORB
	jr nz, .next
.empty_slot ; weird, counts an empty Play Area slot as Voltorb
	inc e ; increment tally
.next
	dec b
	jr nz, .loop_play_area
	ret

HitmonleeDoubleKick_AIEffect:
	ld a, (30 * 2) / 2
	lb de, 0, 60
	farcall SetExpectedAIDamage
	ret

HitmonleeDoubleKick_MultiplierEffect:
	ld hl, 30
	call LoadTxRam3
	ldtx de, DamageCheckXDamageTimesHeadsText
	ld a, 2
	farcall TossCoinATimes_Bank1a
	ld e, a
	add a
	add e ; * 3
	call ATimes10
	farcall SetDefiniteDamage
	ret

MatchPunch_InitialEffect:
	farcall Func_6808d
	ret

MatchPunch_AISelectEffect:
	xor a
	ldh [hTemp_ffa0], a
	farcall CheckNonTurnDuelistHasBench
	ret c ; no bench
	ldtx de, IfHeads10DamageToBenchText
	farcall Serial_TossCoin
	ldh [hTemp_ffa0], a
	ret nc ; tails
	farcall AIFindTargetForBenchAttack
	ldh [hTempPlayAreaLocation_ffa1], a
	ret

MatchPunch_PlayerSelectEffect:
	xor a
	ldh [hTemp_ffa0], a
	farcall CheckNonTurnDuelistHasBench
	ret c ; no bench
	ldtx de, IfHeads10DamageToBenchText
	farcall Serial_TossCoin
	ldh [hTemp_ffa0], a
	ret nc ; tails
	ldtx hl, ChooseBenchedPokemonToGiveDamageText
	call DrawWideTextBox_WaitForInput
	call SwapTurn
	bank1call HasAlivePokemonInBench
	ld a, $ff
	jr c, .got_selection
.loop
	bank1call OpenPlayAreaScreenForSelection
	jr c, .loop ; mandatory selection
.got_selection
	ldh [hTempPlayAreaLocation_ffa1], a
	call SwapTurn
	ret

MatchPunch_DamageBenchEffect:
	ldh a, [hTemp_ffa0]
	or a
	ret z
	ldh a, [hTempPlayAreaLocation_ffa1]
	cp $ff
	ret z
	call SwapTurn
	ld b, a
	ld de, 10
	call DealDamageToPlayAreaPokemon_RegularAnim
	call SwapTurn
	ret

PrehistoricDream_CheckUse:
	farcall CheckIfCanUsePkmnPowerThisTurn
	ret

PrehistoricDream_IncrementBoostEffect:
	farcall SetUsedPkmnPowerThisTurnFlag
	ldtx de, PrehistoricDreamCheckText
	farcall TossCoin_Bank1a
	ret nc ; tails
	ld hl, wPrehistoricDreamBoost
	inc [hl]
	ret

Fossilize_CheckUse:
	farcall Func_6808d
	farcall CheckIfCanUsePkmnPowerThisTurn
	ret

Fossilize_PlayerSelectEffect:
	ld a, $ff
	ldh [hTempPlayAreaLocation_ffa1], a
	ldtx de, FossilizeCheckText
	farcall Serial_TossCoin
	jr c, .successful

; unsuccessful
	farcall SetWasUnsuccessful
	call PrintFailedEffectText
	call WaitForWideTextBoxInput
	or a
	ret

.successful
	ldtx hl, ChoosePokemonEvolvingFromFossilText
	call DrawWideTextBox_WaitForInput
	bank1call HasAlivePokemonInPlayArea
.loop_select
	bank1call OpenPlayAreaScreenForSelection
	jr c, .loop_select
	add DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call CheckIfCardIsFossilPokemon
	jr c, .loop_select ; not a valid target
	ldh a, [hTempPlayAreaLocation_ff9d]
	ldh [hTempPlayAreaLocation_ffa1], a
	or a
	ret

Fossilize_DevolveEffect:
	farcall SetUsedPkmnPowerThisTurnFlag
	ldh a, [hTempPlayAreaLocation_ffa1]
	cp $ff
	ret z ; didn't choose any target

	; devolve this card in Play Area
	ldh a, [hTempPlayAreaLocation_ffa1]
	ldh [hTempPlayAreaLocation_ff9d], a
	add DUELVARS_ARENA_CARD
	get_turn_duelist_var
	push hl
	bank1call GetCardOneStageBelow
	ld a, e
	call AddCardToHand
	ld a, d
	farcall UpdateDevolvedCardHPAndStage
	pop hl
	ld a, [hl]
	bank1call GetCardOneStageBelow
	jr c, .devolved
	; still one stage left to devolve
	ld a, e
	call AddCardToHand
	ld a, d
	farcall UpdateDevolvedCardHPAndStage

.devolved
	farcall ResetDevolvedCardStatus
	ldh a, [hTempPlayAreaLocation_ffa1]
	call PrintPlayAreaCardKnockedOutIfNoHP
	farcall IsPlayerTurn
	jr c, .skip_show_changes
	; show changes to player
	xor a
	ld [wDuelDisplayedScreen], a
	ldh a, [hTempPlayAreaLocation_ffa1]
	farcall DrawPlayAreaScreenToShowChanges
.skip_show_changes
	bank1call HandleDestinyBondAndBetweenTurnKnockOuts
	ret

; returns carry if card index given in a is NOT a fossil Pokémon
CheckIfCardIsFossilPokemon:
	call LoadCardDataToBuffer2_FromDeckIndex
	ld a, [wLoadedCard2PokedexNumber]
	cp DEX_OMANYTE
	jr c, .not_fossil
	cp DEX_AERODACTYL + 1
	jr nc, .not_fossil
	or a
	ret
.not_fossil
	scf
	ret

SharpClaws_AIEffect:
	ld a, 30 ; bug, should be (10 + 40) / 2
	lb de, 10, 40
	farcall SetExpectedAIDamage
	ret

SharpClaws_DamageBoostEffect:
	ld a, 30
	farcall AddDamageIfHeads
	ret

TailspinAttackEffect:
	farcall SetIsDamageToSelf
	ld b, PLAY_AREA_ARENA
	ld de, 10
	call DealDamageToPlayAreaPokemon_RegularAnim
	farcall UnsetIsDamageToSelf
	ret

AuroraVeilEffect:
	scf
	ret

RagingThunder_InitialEffect:
	farcall Func_6808d
	ret

RagingThunder_AISelectEffect:
	ldtx de, IfTails30DamageTo1OfYourPokemonText
	farcall Serial_TossCoin
	ldh [hTemp_ffa0], a
	ret c ; heads

	; this is incorrect, if AI doesn't have bench then
	; it will output whatever value is in hTempPlayAreaLocation_ffa1 already
	; seems like they wanted to output PLAY_AREA_ARENA here instead
	xor a
	ldh [hTemp_ffa0], a ; bug, should be ldh [hTempPlayAreaLocation_ffa1], a
	farcall CheckIfTurnDuelistHasBench
	ret c ; no bench

	; find card with highest remaining HP
	ld c, a
	ld b, PLAY_AREA_ARENA
	ld a, DUELVARS_ARENA_CARD_HP
	get_turn_duelist_var
	lb de, 0, PLAY_AREA_ARENA
.loop_bench
	ld a, [hl]
	cp d
	jr c, .next ; has less HP
	ld d, a
	ld e, b
.next
	inc hl
	inc b
	dec c
	jr nz, .loop_bench
	; e has the bench location with highest remaining HP
	ld a, e
	ldh [hTempPlayAreaLocation_ffa1], a
	ret

RagingThunder_PlayerSelectEffect:
	ldtx de, IfTails30DamageTo1OfYourPokemonText
	farcall Serial_TossCoin
	ldh [hTemp_ffa0], a
	ret c ; heads

	; player has to choose a card in play area to damage
	bank1call HasAlivePokemonInPlayArea
	ldtx hl, ChoosePokemonToGiveDamageText
	call DrawWideTextBox_WaitForInput
.loop
	bank1call OpenPlayAreaScreenForSelection
	jr c, .loop ; mandatory selection
	ldh [hTempPlayAreaLocation_ffa1], a
	ret

RagingThunder_DamageOwnPlayAreaEffect:
	ldh a, [hTemp_ffa0]
	or a
	ret nz ; got heads

	; deal 30 damage to selected target
	farcall SetIsDamageToSelf
	ldh a, [hTempPlayAreaLocation_ffa1]
	ld b, a
	ld de, 30
	call DealDamageToPlayAreaPokemon_RegularAnim
	ret

ThunderCrash_AIEffect:
	ld a, (50 + 70) / 2
	lb de, 50, 70
	farcall SetExpectedAIDamage
	ret

ThunderCrash_DamageBoostOrRecoilEffect:
	ldtx de, Plus20DamageIfHeads20DamageToYourselfIfTailsText
	farcall TossCoin_Bank1a
	ldh [hTemp_ffa0], a
	ret nc ; tails, will recoil instead
	ld a, 20
	farcall AddToDamage
	ret

ThunderCrash_RecoilEffect:
	ldh a, [hTemp_ffa0]
	or a
	ret nz ; got heads
	ld a, 20
	call DealRecoilDamageToSelf
	ret

DryUp_CheckPlayAreaWaterEnergies:
	farcall Func_6808d

	; check all cards in play area
	; if non are Water/Rainbow energy, then return carry
	call SwapTurn
	ld a, DUELVARS_CARD_LOCATIONS
	get_turn_duelist_var
.loop_cards
	ld a, [hl]
	and CARD_LOCATION_PLAY_AREA
	jr z, .next_card
	ld a, l
	call GetCardIDFromDeckIndex
	cp16 WATER_ENERGY
	jr z, .has_water_or_rainbow_energy
	cp16 RAINBOW_ENERGY
	jr z, .has_water_or_rainbow_energy
.next_card
	inc l
	ld a, l
	cp DECK_SIZE
	jr c, .loop_cards
	; none found
	call SwapTurn
	ldtx hl, NoWaterEnergyInOppPlayAreaText
	scf
	ret
.has_water_or_rainbow_energy
	call SwapTurn
	or a
	ret

DryUp_PlayerSelectPlayAreaPkmnEffect:
	ldtx hl, ChoosePokemonToRemoveWaterEnergyFromText
	call DrawWideTextBox_WaitForInput
	call SwapTurn
	bank1call HasAlivePokemonInPlayArea
.loop_select
	bank1call OpenPlayAreaScreenForSelection
	ldh [hTemp_ffa0], a
	jr c, .got_selection
	call GetNumberOfWaterEnergiesAttachedToPlayAreaCard
	or a
	jr z, .loop_select
.got_selection
	call SwapTurn
	; carry set if operation cancelled
	ret

DryUp_PlayerSelectEnergyEffect:
	jr HandleDryUpPlayerSelection

DryUp_AISelectPlayAreaPkmnEffect:
	jp AISelectTargetForDryUp

DryUp_AISelectEnergyEffect:
	jp AISelectEnergiesForDryUp

DryUp_DiscardFromArenaEffect:
	jp DryUpProcessArenaEffects

DryUp_DiscardFromBenchEffect:
	jp DiscardDryUpEnergies

; check if Mirror Move Dry Up can be used
; against the Defending Pokémon, that is to say
; whether the Defending Pokémon has any Water energies to discard
MirrorMoveDryUpCheck:
	farcall Func_6808d
	call SwapTurn
	xor a ; PLAY_AREA_ARENA
	call GetNumberOfWaterEnergiesAttachedToPlayAreaCard
	call SwapTurn
	or a
	ret nz ; has Water energies
	ldtx hl, NoWaterEnergyText
	scf
	ret

; Mirror Move Dry Up is forced to select Arena card as target
MirrorMoveDryUpSelectArenaCard:
	xor a
	ldh [hTemp_ffa0], a
	ret

HandleDryUpPlayerSelection:
	call SwapTurn
	ld a, 1
	ldh [hCurSelectionItem], a
	ldh a, [hTemp_ffa0] ; selected play area card
	call GetNumberOfWaterEnergiesAttachedToPlayAreaCard
	call SwapTurn
	ldh [hPlayAreaEffectTarget], a

	call TossCoinsUntilTails
	ldh [hTempPlayAreaLocation_ffa1], a
	or a
	jr z, .no_heads

	; got at least 1 heads
	call SwapTurn
	ldh a, [hTemp_ffa0]
	bank1call DisplayEnergyDiscardMenu

	; can only select up to the number of Water/Rainbow cards
	; that are attached to target
	ldh a, [hTempPlayAreaLocation_ffa1]
	ld hl, hPlayAreaEffectTarget
	cp [hl]
	jr c, .got_num_to_select
	ld a, [hl]
.got_num_to_select
	ld [wAttachedEnergyMenuDenominator], a
	xor a
	ld [wAttachedEnergyMenuNumerator], a

.loop_selection
	bank1call HandleAttachedEnergyMenuInput
	jr c, .loop_selection ; mandatory selection
	farcall GetNextPositionInTempList
	ldh a, [hTempCardIndex_ff98]
	ld [hl], a
	call RemoveCardFromDuelTempList
	ld hl, wAttachedEnergyMenuNumerator
	inc [hl]
	ld a, [hl]
	ld hl, wAttachedEnergyMenuDenominator
	cp [hl]
	jr nc, .selection_done
	ldh a, [hCurSelectionItem]
	cp 15
	jr nc, .selection_done
	bank1call UpdateAttachedEnergyMenu
	jr .loop_selection
.selection_done
	call SwapTurn
.no_heads
	farcall GetNextPositionInTempList
	ld [hl], $ff
	ret

AISelectTargetForDryUp:
	call SwapTurn
	; select Arena card if Aurora Veil is in effect
	bank1call CheckArticunoAuroraVeil
	ld e, PLAY_AREA_ARENA
	jr c, .got_target

	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	ld c, a
	ld b, $00
	lb de, 0, PLAY_AREA_ARENA

	; if Arena card is unaffected by effects, start with bench
	push bc
	push de
	bank1call HandleNoDamageOrEffectSubstatus
	pop de
	pop bc
	jr c, .next_pkmn

	; if Arena card has any Water/Rainbow energies, choose it as target
	push bc
	push de
	xor a ; PLAY_AREA_ARENA
	call GetNumberOfWaterEnergiesAttachedToPlayAreaCard
	pop de
	pop bc
	jr z, .loop
	ld e, PLAY_AREA_ARENA
	jr .got_target

	; loop through Play Area, output the target
	; with most Water/Rainbow energy cards
.loop
	push de
	push bc
	ld a, b
	call GetNumberOfWaterEnergiesAttachedToPlayAreaCard
	pop bc
	pop de
	cp d ; does it have more than the one already found?
	jr c, .next_pkmn
	; yes, store this location
	ld d, a
	ld e, b
.next_pkmn
	inc b
	dec c
	jr nz, .loop

.got_target
	call SwapTurn
	ld a, e
	ldh [hTemp_ffa0], a
	ret

AISelectEnergiesForDryUp:
	call SwapTurn
	ldh a, [hTemp_ffa0]
	call GetNumberOfWaterEnergiesAttachedToPlayAreaCard
	call SwapTurn
	call TossCoinsUntilTails
	ldh [hTempPlayAreaLocation_ffa1], a

	; cap num of energies to discard to 13
	cp 14
	jr c, .got_num
	ld a, 13
.got_num
	ld c, a
	ld hl, hTempList + 1
	ld de, wDuelTempList
	ld a, c
	or a
	jr z, .done

	; just run through list and choose energies sequentially
.loop_list
	ld a, [de]
	cp $ff
	jr z, .done
	inc de
	ld [hli], a
	dec c
	jr nz, .loop_list
.done
	ld [hl], $ff ; terminating byte
	ret

DryUpProcessArenaEffects:
	ldh a, [hTemp_ffa0] ; target chosen
	or a
	ret nz ; is in bench
	; was there any energy cards chosen?
	ldh a, [hTempList + 1]
	cp $ff
	jr z, .none_chosen
	; at least one was chosen
	farcall PreparePlayAreaAttackAgainstArena
	ret c
.none_chosen
	ld a, ATK_ANIM_DRY_UP
	ld [wLoadedAttackAnimation], a
	ld a, DUELVARS_ARENA_CARD_LAST_TURN_EFFECT
	call GetNonTurnDuelistVariable
	ld [hl], LAST_TURN_EFFECT_DRY_UP
	ret

DiscardDryUpEnergies:
	ldh a, [hTempList + 1]
	cp $ff
	jr z, .none_chosen
	call SwapTurn
	ldh a, [hTemp_ffa0]
	ld e, a
	bank1call HandlePlayAreaCardNoDamageOrEffect
	jr c, .done ; unaffected

	; start discarding chosen energies
	ld hl, hTempList + 1
.loop_discard
	ld a, [hli]
	cp $ff
	jr z, .show_changes
	call DiscardCard
	jr .loop_discard

.none_chosen
	call SwapTurn
.show_changes
	ldh a, [hTemp_ffa0]
	farcall DrawPlayAreaScreenToShowChanges
.done
	call SwapTurn
	ret

; flips coins until tails
; outputs number of heads in a
TossCoinsUntilTails:
	ld c, 0 ; num heads
.loop_coin_toss
	push bc
	ldtx de, DryUpCheckText
	xor a
	farcall Serial_TossCoinATimes
	pop bc
	ld a, c
	ret nc ; tails
	inc c ; increment num of tails
	jr .loop_coin_toss

TwisterEffect:
	ld a, DUELVARS_ARENA_CARD_HP
	call GetNonTurnDuelistVariable
	or a
	ret z ; defending card was KO'd

	farcall HandleNoDamageOrEffect
	ret c ; no effect

	; count how many Energy/Trainer cards are attached
	; to the Defending card
	call SwapTurn
	ld c, 0
	ld a, DUELVARS_CARD_LOCATIONS
	get_turn_duelist_var
.loop_cards_1
	ld a, [hl]
	cp CARD_LOCATION_ARENA
	jr nz, .next_card_1
	ld a, l
	call LoadCardDataToBuffer1_FromDeckIndex
	ld a, [wLoadedCard1Type]
	cp TYPE_ENERGY
	jr c, .next_card_1
	; is Energy or Trainer card
	inc c
.next_card_1
	inc l
	ld a, l
	cp DECK_SIZE
	jr c, .loop_cards_1

	call SwapTurn
	ld a, c
	or a
	ret z ; no cards attached

	ldtx de, TwisterCheckText
	farcall TossCoin_Bank1a
	ret nc ; tails
;	fallthrough

TwisterEffect_SkipCoinToss:
	farcall HandleNoDamageOrEffect
	ret c ; not affected

	ld a, DUELVARS_ARENA_CARD_HP
	call GetNonTurnDuelistVariable
	or a
	ret z ; defending card was KO'd

	call SwapTurn
	; clear number of Defender cards attached
	ld a, DUELVARS_ARENA_CARD_ATTACHED_DEFENDER
	get_turn_duelist_var
	ld [hl], 0

	ld l, 0
.loop_cards_2
	ld a, [hl]
	cp CARD_LOCATION_ARENA
	jr nz, .next_card_2
	ld a, l
	call LoadCardDataToBuffer1_FromDeckIndex
	ld a, [wLoadedCard1Type]
	cp TYPE_ENERGY
	jr c, .next_card_2
	; return to hand
	ld a, l
	call AddCardToHand
.next_card_2
	inc l
	ld a, l
	cp DECK_SIZE
	jr c, .loop_cards_2
	xor a
	ld [wDuelDisplayedScreen], a
	ld a, DUELVARS_ARENA_CARD_LAST_TURN_EFFECT
	get_turn_duelist_var
	ld [hl], LAST_TURN_EFFECT_TWISTER
	call SwapTurn
	ret

PidgeottoFly_AIEffect:
	ld a, 30
	lb de, 0, 30
	farcall SetExpectedAIDamage
	ret

PidgeottoFly_Success50PercentEffect:
	ldtx de, AttackSuccessCheckText
	farcall TossCoin_Bank1a
	jr c, .successful
	xor a ; ATK_ANIM_NONE
	ld [wLoadedAttackAnimation], a
	farcall SetDefiniteDamage
	farcall SetWasUnsuccessful
	ret
.successful
	ld a, SUBSTATUS1_FLY
	farcall ApplySubstatus1ToAttackingCard
	ret

AddDeadlyPoisonDamageBoost:
	ld a, DUELVARS_ARENA_CARD_STATUS
	call GetNonTurnDuelistVariable
	and PSN_DBLPSN
	cp POISONED
	ret nz ; not poisoned
	ld a, 10
	farcall AddToDamage
	ret

DeadlyPoisonEffect:
	call AddDeadlyPoisonDamageBoost
	farcall PoisonEffect
	ret

SandVeilEffect:
	ldtx de, IfHeadsNoDamageNextTurnText
	farcall TossCoin_Bank1a
	jr nc, .unsuccessful
	ld a, SUBSTATUS1_SAND_VEIL
	farcall ApplySubstatus1ToAttackingCard
	ret
.unsuccessful
	xor a
	ld [wLoadedAttackAnimation], a
	farcall SetWasUnsuccessful
	ret

RollingNeedle_AIEffect:
	ld a, (10 * 3) / 2
	lb de, 0, 30
	farcall SetExpectedAIDamage
	ret

RollingNeedle_MultiplierEffect:
	ld hl, 10
	call LoadTxRam3
	ldtx de, Plus10DamageToOppAndYourselfForEachHeadsText
	ld a, 3
	farcall TossCoinATimes_Bank1a
	ldh [hTemp_ffa0], a ; save num of heads
	call ATimes10
	farcall AddToDamage
	ret

RollingNeedle_RecoilEffect:
	ldh a, [hTemp_ffa0] ; num of heads
	call ATimes10
	call DealRecoilDamageToSelf
	ret

StrengthInNumbersEffect:
	ld e, 0
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	ld b, a
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	jr .next
.loop_play_area
	ld a, [hl]
	call LoadCardDataToBuffer1_FromDeckIndex
	ld a, [wLoadedCard1PokedexNumber]
	cp DEX_NIDORAN_F
	jr c, .next
	cp DEX_NIDOKING + 1
	jr nc, .next
	inc e
.next
	inc hl
	dec b
	jr nz, .loop_play_area

	; e = num of Nidoran/Nidorino/Nidorina/Nidoqueen/Nidoking
	ld a, e
	call ATimes10
	farcall AddToDamage
	ret

NidoranaFurySwipes_AIEffect:
	ld a, (30 * 3) / 2
	lb de, 0, 90
	farcall SetExpectedAIDamage
	ret

NidoranaFurySwipes_MultiplierEffect:
	ld hl, 30
	call LoadTxRam3
	ldtx de, DamageCheckXDamageTimesHeadsText
	ld a, 3
	farcall TossCoinATimes_Bank1a
	ld e, a
	add a
	add e ; *3
	call ATimes10
	farcall SetDefiniteDamage
	ret

SwiftLunge_AIEffect:
	; inconsistent with other AI estimations,
	; cwhich would put the full damage here
	ld a, 30
	lb de, 0, 60
	farcall SetExpectedAIDamage
	ret

SwiftLunge_NoDamage50PercentEffect:
	ldtx de, IfTailsNoDamageToOppAnd20ToYourselfText
	farcall TossCoin_Bank1a
	ldh [hTemp_ffa0], a
	ret c ; heads
	xor a ; ATK_ANIM_NONE
	ld [wLoadedAttackAnimation], a
	farcall SetDefiniteDamage
	farcall SetWasUnsuccessful
	ret

SwiftLunge_RecoilEffect:
	ldh a, [hTemp_ffa0]
	or a
	ret nz ; got heads
	ld a, 20
	call DealRecoilDamageToSelf
	ret

FoxFire_AISelectEffect:
	farcall AIFindTargetForPlayAreaAttack
	ldh [hTemp_ffa0], a
	ret

FoxFire_PlayerSelectEffect:
	ldtx hl, SelectBenchedPokemonToSwitchWithActiveText
	call DrawWideTextBox_WaitForInput
	call SwapTurn
	bank1call HasAlivePokemonInPlayArea
	jr c, .no_play_area
	bank1call OpenPlayAreaScreenForSelection
	jr nc, .got_selection
.no_play_area
	; don't switch
	xor a
.got_selection
	ldh [hTemp_ffa0], a
	call SwapTurn
	ret

FoxFire_SwitchAndDamageEffect:
	ldh a, [hTemp_ffa0]
	or a
	jr nz, .chose_bench_card
	; just attack Arena card normally
	farcall PreparePlayAreaAttackAgainstArena
	ret
.chose_bench_card
	xor a
	ld [wNoDamageOrEffect], a
	call SwapTurn
	ldh a, [hTemp_ffa0]
	ld e, a
	bank1call HandlePlayAreaCardNoDamageOrEffect
	jr nc, .affected
	xor a ; no damage
	farcall SetDefiniteDamage
	jr .finish
.affected
	xor a
	ld [wcd0b], a

	; swap cards
	call SwapArenaWithBenchPokemon

	; update non-turn-duelist card ID
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call GetCardIDFromDeckIndex
	ld hl, wTempNonTurnDuelistCardID
	ld [hl], e
	inc hl
	ld [hl], d

	xor a
	ld [wDuelDisplayedScreen], a
	call SwapTurn
	bank1call ClearDamageReductionSubstatus2
	call SwapTurn
.finish
	xor a
	ld [wNoDamageOrEffect], a
	call SwapTurn
	ret

Disable_CheckAttacks:
	farcall Func_6808d
	farcall CheckIfDefendingCardHasAnyAttacks
	ret

Disable_AISelectEffect:
	ldtx de, AttackSuccessCheckText
	farcall Serial_TossCoin
	ldh [hTempPlayAreaLocation_ffa1], a
	ret nc
	farcall AIPickAttackForAmnesia
	ret

Disable_PlayerSelectEffect:
	ldtx de, AttackSuccessCheckText
	farcall Serial_TossCoin
	ldh [hTempPlayAreaLocation_ffa1], a
	ret nc ; was tails
.select_atk
	farcall PlayerPickAttackForAmnesia
	jr c, .select_atk ; mandatory selection
	ret

Disable_DisableEffect:
	ldh a, [hTempPlayAreaLocation_ffa1]
	or a
	jr z, .unsuccessful
	ld a, SUBSTATUS2_DISABLE
	farcall ApplyAmnesiaToAttack_GotSubstatus
	ret
.unsuccessful
	xor a
	ld [wLoadedAttackAnimation], a
	farcall SetWasUnsuccessful
	ret

GolduckPsychicEffect:
	farcall GetEnergyAttachedMultiplierDamage
	ld hl, wDamage
	ld a, e
	add [hl]
	ld [hli], a
	ld a, d
	adc [hl]
	ld [hl], a
	farcall SetDefiniteAIDamage
	ret

ErrandRunning_DeckCheck:
	farcall Func_6808d
	farcall CheckIfDeckIsEmpty
	ret

ErrandRunning_PlayerSelectEffect:
	ldtx de, AttackSuccessCheckText
	farcall Serial_TossCoin
	ldh [hTemp_ffa0], a
	ret nc ; tails
	call CreateDeckCardList
	ldtx hl, ChooseATrainerCardFromDeckText
	ldtx bc, TrainerCardText
	ld a, CARDSEARCH_TRAINER
	farcall LookForCardsInDeck
	jr c, .got_selection
	ldtx hl, ChooseATrainerCardText
	ldtx de, DuelistDeckText
	farcall SelectCardSearchTarget
.got_selection
	ldh [hTempPlayAreaLocation_ffa1], a
	ret

ErrandRunning_AISelectEffect:
	ldtx de, AttackSuccessCheckText
	farcall Serial_TossCoin
	ldh [hTemp_ffa0], a
	ret nc ; tails
	ld a, CARDSEARCH_TRAINER
	farcall SetCardSearchFuncParams
	call CreateDeckCardList
	ld hl, wDuelTempList
.loop
	ld a, [hli]
	ldh [hTempPlayAreaLocation_ffa1], a
	cp $ff
	ret z
	farcall ExecuteCardSearchFunc
	jr nc, .loop
	ret

ErrandRunning_SetAnimationEffect:
	ldh a, [hTemp_ffa0]
	or a
	ret nz ; was heads
	xor a ; ATK_ANIM_NONE
	ld [wLoadedAttackAnimation], a
	ret

ErrandRunning_AddToHandEffect:
	ldh a, [hTemp_ffa0]
	or a
	ret z ; got tails
	ldh a, [hTempPlayAreaLocation_ffa1]
	cp $ff
	jr z, .finish
	call SearchCardInDeckAndAddToHand
	call AddCardToHand
	farcall IsPlayerTurn
	jr c, .finish
	; show to the player
	ldh a, [hTempPlayAreaLocation_ffa1]
	ldtx hl, WasPlacedInTheHandText
	bank1call DisplayCardDetailScreen
.finish
	farcall ShuffleCardsInDeck
	ret

GrowlitheLv16Ember_CheckEnergy:
	farcall CheckIfArenaCardHasFireOrRainbowEnergy
	ret

GrowlitheLv16Ember_PlayerSelectEffect:
	farcall PlayerPickFireEnergyCardToDiscard
	ret

GrowlitheLv16Ember_AISelectEffect:
	farcall AIPickFireEnergyCardToDiscard
	ret

GrowlitheLv16Ember_DiscardEffect:
	ldh a, [hTemp_ffa0]
	call DiscardCard
	ret

KadabraPsychoPanicEffect:
	call CheckIfDefendingCardIsPsychic
	ret nz ; not Psychic
	ld a, 60
	farcall SetDefiniteDamage
	ret

; returns z if defending card is Psychic
CheckIfDefendingCardIsPsychic:
	call SwapTurn
	bank1call GetArenaCardColor
	call SwapTurn
	cp PSYCHIC
	ret

BlinkEffect:
	ld a, SUBSTATUS1_BLINK
	farcall ApplySubstatus1ToAttackingCard
	ret

AlakazamPsychoPanicEffect:
	call CheckIfDefendingCardIsPsychic
	ret nz ; not Psychic
	ld a, 60
	farcall SetDefiniteDamage
	ret

TransDamage_DamageCheck:
	ld e, PLAY_AREA_ARENA
	call GetCardDamageAndMaxHP
	or a
	ret nz ; has damage
	ldtx hl, NoDamageCountersText
	scf
	ret

TransDamage_DiscardAllEnergiesEffect:
	xor a ; PLAY_AREA_ARENA
	call CreateArenaOrBenchEnergyCardList
	ld hl, wDuelTempList
.loop_discard
	inc b
	ld a, [hli]
	cp $ff
	ret z ; done
	call DiscardCard
	jr .loop_discard

TransDamage_AIEffect:
	ldh a, [hTempPlayAreaLocation_ff9d]
	jr SetTransDamageAttackDamage_GotPlayAreaLocation

SetTransDamageAttackDamage:
	xor a ; PLAY_AREA_ARENA
SetTransDamageAttackDamage_GotPlayAreaLocation:
	ld e, a
	call GetCardDamageAndMaxHP
	farcall SetDefiniteDamageAndSetUnaffectedByWR
	ld a, [wDamage]
	ld e, a
	ld d, 0
	ld l, e
	ld h, d
	call LoadTxRam3
	ret

TransDamage_AnimateAndSetDamageEffect:
	farcall PreparePlayAreaAttackAgainstArena
	ret c ; not affected
	call SwapTurn
	bank1call HandleTransparency
	call SwapTurn
	ret c ; not affected due to Transparency
	ld a, ATK_ANIM_TRANS_DAMAGE
	ld [wLoadedAttackAnimation], a
	call SetTransDamageAttackDamage
	jr ApplyTransDamageAttackDamage

TransDamage_MoveCountersEffect:
	farcall HandleNoDamageOrEffect
	jr c, .recover_hp
	call SetTransDamageAttackDamage
	ld a, DUELVARS_ARENA_CARD_HP
	call GetNonTurnDuelistVariable
	call SubtractHP
.recover_hp
	ld e, PLAY_AREA_ARENA
	call GetCardDamageAndMaxHP
	ld e, a
	ld d, 0
	farcall ApplyAndAnimateHPRecovery
	ld a, DUELVARS_ARENA_CARD_HP
	call GetNonTurnDuelistVariable
	call PrintKnockedOutIfHLZero
	ret

PlayMirrorMoveTransDamageAnimation:
	ld a, ATK_ANIM_TRANS_DAMAGE
	ld [wLoadedAttackAnimation], a
	ld a, DUELVARS_ARENA_CARD_LAST_TURN_CHANGE_WEAK
	get_turn_duelist_var
	ld e, a
	ld d, 0
ApplyTransDamageAttackDamage:
	ld a, DUELVARS_ARENA_CARD_LAST_TURN_CHANGE_WEAK
	call GetNonTurnDuelistVariable
	ld [hl], e
	ld a, DUELVARS_ARENA_CARD_LAST_TURN_EFFECT
	call GetNonTurnDuelistVariable
	ld [hl], LAST_TURN_EFFECT_TRANS_DAMAGE
	ld a, [wLoadedAttackAnimation]
	call PlaySpecialAttackAnimation
	xor a ; ATK_ANIM_NONE
	ld [wLoadedAttackAnimation], a
	farcall SetDefiniteDamage
	ret

ApplyMirrorMoveTransDamageAttackDamage:
	ld a, DUELVARS_ARENA_CARD_LAST_TURN_CHANGE_WEAK
	get_turn_duelist_var
	ld e, a
	ld d, 0
	ld a, DUELVARS_ARENA_CARD_HP
	call GetNonTurnDuelistVariable
	call SubtractHP
	call PrintKnockedOutIfHLZero
	ret

FocusBlast_InitialEffect:
	farcall Func_6808d
	ret

FocusBlast_AIEffect:
	ld a, 20
	farcall SetDefiniteDamage
	ret

FocusBlast_PlayerSelectEffect:
	xor a
	ldh [hTemp_ffa0], a
	ldtx de, IfHeads20DamageTo1OfOppPokemonText
	farcall Serial_TossCoin
	ldh [hTemp_ffa0], a
	ret nc ; tails
	ldtx hl, ChoosePokemonToGiveDamageText
	call DrawWideTextBox_WaitForInput
	call SwapTurn
	bank1call HasAlivePokemonInPlayArea
.select_pkmn
	bank1call OpenPlayAreaScreenForSelection
	jr c, .select_pkmn ; mandatory selection
	ldh a, [hTempPlayAreaLocation_ff9d]
	ldh [hTempPlayAreaLocation_ffa1], a
	call SwapTurn
	ret

FocusBlast_AISelectEffect:
	ldtx de, IfHeads20DamageTo1OfOppPokemonText
	farcall Serial_TossCoin
	ldh [hTemp_ffa0], a
	ret nc ; tails
	farcall AIFindTargetForPlayAreaAttack
	ldh [hTempPlayAreaLocation_ffa1], a
	ret

FocusBlast_ClearAnimationEffect:
	xor a ; ATK_ANIM_NONE
	ld [wLoadedAttackAnimation], a
	ret

FocusBlast_DealDamageEffect:
	ldh a, [hTemp_ffa0]
	or a
	ret z ; got tails
	ld e, ATK_ANIM_FOCUS_BLAST
	ldh a, [hTempPlayAreaLocation_ffa1]
	or a
	jr z, .got_anim
	ld e, ATK_ANIM_FOCUS_BLAST_BENCH
.got_anim
	ld a, e
	ld [wLoadedAttackAnimation], a

	ldh a, [hTempPlayAreaLocation_ffa1]
	or a
	jr nz, .bench
	ld hl, wLoadedAttackCategory
	res RESIDUAL_F, [hl]
.bench
	ldh a, [hTempPlayAreaLocation_ffa1]
	call SwapTurn
	bank1call LoadPlayAreaCardID_ToTempNonTurnDuelistCardID
	call SwapTurn
	ldh a, [hTempPlayAreaLocation_ffa1]
	ld c, a
	ld b, 0
	ld de, 20
	bank1call DamageCalculation
	call SwapTurn
	call DealDamageToPlayAreaPokemon_GotPlayAreaLocation
	call SwapTurn
	ret

SeethingAnger_AIEffect:
	; bug, AI incorrectly estimates damage here
	; it doesn't take into account that
	; this attack has 20 base (guaranteed) damage
	ld e, PLAY_AREA_ARENA
	call GetCardDamageAndMaxHP
	; set attacking card's damage as max damage
	ld [wAIMaxDamage], a
	; set half as expected damage
	srl a ; /2
	ld [wDamage], a
	; set 0 as min damage
	xor a ; 0
	ld [wDamage + 1], a
	ld [wAIMinDamage], a
	ret

SeethingAnger_DamageBoostEffect:
	ld hl, 10
	call LoadTxRam3
	ld e, PLAY_AREA_ARENA
	call GetCardDamageAndMaxHP
	or a
	ret z ; no damage

	; flip num of coins equal to damage counters
	call ADividedBy10
	ldtx de, DamageCheckXDamageTimesHeadsText
	farcall TossCoinATimes_Bank1a
	; add (num heads) * 10 to damage
	call ATimes10
	farcall AddToDamage
	ret

MachampFling_CheckBench:
	farcall HandleMandatorySwitchSelection
	ldh a, [hTempPlayAreaLocation_ff9d]
	ldh [hTemp_ffa0], a
	ret

MachampFling_SwitchEffect:
	ldh a, [hTemp_ffa0]
	farcall HandleSwitchDefendingPokemonEffect
	ret

SwayEffect:
	ldtx de, IfHeadsDoNotReceiveDamageText
	farcall TossCoin_Bank1a
	jr nc, .unsuccessful
	ld a, SUBSTATUS1_SWAY
	farcall ApplySubstatus1ToAttackingCard
	ret
.unsuccessful
	xor a ; ATK_ANIM_NONE
	ld [wLoadedAttackAnimation], a
	ret

RegenerationEffect:
	; heal all damage and play animation
	ld e, PLAY_AREA_ARENA
	call GetCardDamageAndMaxHP
	ld e, a
	ld d, 0
	farcall ApplyAndAnimateHPRecovery

	; loop all deck cards
	; discard all cards attached to Arena
	ld a, DUELVARS_CARD_LOCATIONS
	get_turn_duelist_var
.loop
	ld a, [hl]
	cp CARD_LOCATION_ARENA
	jr nz, .next_card
	; is in Arena, discard if is Energy/Trainer
	ld a, l
	call LoadCardDataToBuffer1_FromDeckIndex
	ld a, [wLoadedCard1Type]
	cp TYPE_ENERGY
	jr nc, .discard
	; is a Pkmn card, discard if not Basic
	ld a, [wLoadedCard1Stage]
	or a
	jr nz, .discard
	; is basic, devolve it using its deck index
	push hl
	xor a ; PLAY_AREA_ARENA
	ldh [hTempPlayAreaLocation_ff9d], a
	ld a, l
	farcall UpdateDevolvedCardHPAndStage
	farcall ResetDevolvedCardStatus
	pop hl
	jr .next_card
.discard
	ld a, l
	call DiscardCard
.next_card
	inc l
	ld a, l
	cp DECK_SIZE
	jr c, .loop

	xor a
	ld [wDuelDisplayedScreen], a
	ret

Dissolve_ArenaEnergyCheck:
	farcall CreateNonTurnDuelistArenaEnergyCardList
	jr c, .no_energy_cards
	farcall Func_6808d
.no_energy_cards
	or a
	ret

Dissolve_PlayerSelectEffect:
	xor a
	ldh [hTempPlayAreaLocation_ffa1], a
	farcall CreateNonTurnDuelistArenaEnergyCardList
	ret c ; no energies
	ldtx de, IfHeadsDiscard1EnergyCardFromOpponentText
	farcall Serial_TossCoin
	ldh [hTempPlayAreaLocation_ffa1], a
	ret nc ; got tails
	farcall HandleDiscardEnergyFromDefendingCardPlayerSelection
	ret

Dissolve_AISelectEffect:
	xor a
	ldh [hTempPlayAreaLocation_ffa1], a
	farcall CreateNonTurnDuelistArenaEnergyCardList
	ret c ; no energies
	ldtx de, IfHeadsDiscard1EnergyCardFromOpponentText
	farcall Serial_TossCoin
	ldh [hTempPlayAreaLocation_ffa1], a
	ret nc ; got tails
	farcall _AIPickEnergyCardToDiscardFromDefendingPokemon
	ldh [hTemp_ffa0], a
	ret

Dissolve_DiscardEnergyEffect:
	ldh a, [hTempPlayAreaLocation_ffa1]
	or a
	ret z ; got tails or no energy to discard
	farcall DiscardEnergyEffect
	ret

BoulderSmash_InitialEffect:
	farcall Func_6808d
	ret

BoulderSmash_PlayerSelectEffect:
	xor a
	ldh [hTemp_ffa0], a
	farcall CheckNonTurnDuelistHasBench
	ret c ; no bench
	; flip 2 coins, for each heads
	; you can choose a bench Pokémon to place a damage counter
	ldtx de, ForEachHeads10DamageToBenchInAnyWayYouLikeText
	ld a, 2
	farcall Serial_TossCoinATimes
	call BenchMultiSelectMenuPlayerSelection
	ret

BoulderSmash_AISelectEffect:
	xor a
	ldh [hTemp_ffa0], a
	farcall CheckNonTurnDuelistHasBench
	ret c ; no bench
	ldtx de, ForEachHeads10DamageToBenchInAnyWayYouLikeText
	ld a, 2
	farcall Serial_TossCoinATimes
	call BenchMultiSelectMenuAISelection
	ret

BoulderSmash_BenchDamageEffect:
	ld hl, hTemp_ffa0
	ld a, [hli]
	or a
	ret z ; no selections

	call SwapTurn
	ld b, PLAY_AREA_ARENA
	ld c, MAX_PLAY_AREA_POKEMON
.loop_selected_counts
	ld a, [hli]
	push hl
	push bc
	or a
	jr z, .next
	; deal damage equal to count * 10
	call ATimes10
	ld e, a
	ld d, $00
	call DealDamageToPlayAreaPokemon_RegularAnim
.next
	pop bc
	pop hl
	inc b
	dec c
	jr nz, .loop_selected_counts
	call SwapTurn
	ret

; handles selections for effects that involve choosing Bench Pokémon
; up to a number of times given by register a
; the same Bench Pokémon may be chosen more than once
; input:
; - a = number of selections that can be chosen
BenchMultiSelectMenuPlayerSelection:
	ldh [hTemp_ffa0], a
	or a
	ret z ; can't choose any

	; clears all selection values
	call ClearPlayAreaList

	farcall CheckNonTurnDuelistHasBench
	jr nc, .has_bench
	; no bench, output 0
	xor a
	ldh [hTemp_ffa0], a
	ret

.has_bench
	ldtx hl, ChoosePokemonToGiveDamageText
	call DrawWideTextBox_WaitForInput
	call SwapTurn

	; set num of selections made to 0
	xor a
	ld [wPlayAreaMultiSelectMenuNumSelections], a

	; set current item to 0 and set to start
	; at hTemplist + 1
	ldh [hCurScrollMenuItem], a
	ld a, 1
	ldh [hCurSelectionItem], a

	; prepare to show Play Area
	bank1call SetupPlayAreaScreen
	bank1call PrintPlayAreaCardList_EnableLCD

.init_menu
	ldh a, [hCurScrollMenuItem]
	ld hl, BenchMultiSelectMenuParameters
	call InitializeMenuParameters
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	dec a
	; a = num of bench pkmn
	ld [wNumScrollMenuItems], a

.select_loop
	call RefreshBenchMultiSelectCounts
.loop_input
	call DoFrame
	call HandleMenuInput
	jr nc, .loop_input
	cp -1
	jr nz, .selected_pkmn
	; B was pressed
	call .UndoLastSelection
	jr .select_loop

.selected_pkmn
	farcall GetNextPositionInTempList
	ldh a, [hCurScrollMenuItem]
	inc a
	ld [hl], a
	ld e, a
	ld d, $00
	ld hl, wPlayAreaList
	add hl, de
	inc [hl]

	; increment num of selections
	ld hl, wPlayAreaMultiSelectMenuNumSelections
	inc [hl]
	; is it equal to total selections allowed?
	ldh a, [hTemp_ffa0]
	cp [hl]
	jr nz, .select_loop
	; done all allowable selections
	call RefreshBenchMultiSelectCounts

	ldh a, [hCurScrollMenuItem]
	inc a
	farcall DrawPlayAreaScreenToShowChanges
	ldh a, [hKeysPressed]
	and PAD_B
	jr z, .apply_selection
	call .UndoLastSelection
	jr .init_menu

.apply_selection
	call SwapTurn

	; wPlayAreaList list holds number of times each
	; bench Pokémon was chosen
	ld hl, hTempList + 1
	ld de, wPlayAreaList
	ld c, MAX_PLAY_AREA_POKEMON
.loop_selected_counts
	ld a, [de]
	inc de
	ld [hli], a
	dec c
	jr nz, .loop_selected_counts
	ret

.UndoLastSelection:
	ld hl, wPlayAreaMultiSelectMenuNumSelections
	ld a, [hl]
	or a
	ret z ; nothing to undo
	dec [hl] ; decrement total selections
	ld hl, hCurSelectionItem
	dec [hl] ; decrement current item
	ld e, [hl]
	ld d, $00
	ld hl, hTempList
	add hl, de
	ld e, [hl]
	ld d, $00
	ld hl, wPlayAreaList
	add hl, de
	dec [hl] ; decrement count of this play area pkmn
	ret

RefreshBenchMultiSelectCounts:
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	dec a
	ld e, a ; num bench pkmn
	lb bc, 0, 5 ; x, y
	ld hl, wPlayAreaList + PLAY_AREA_BENCH_1
.loop_bench
	ld a, [hli]
	add SYM_0
	call WriteByteToBGMap0
	inc c
	inc c
	inc c ; y += 3
	dec e
	jr nz, .loop_bench
	ret

BenchMultiSelectMenuParameters:
	db 0, 3 ; cursor x, cursor y
	db 3 ; y displacement between items
	db MAX_PLAY_AREA_POKEMON ; number of items
	db SYM_CURSOR_R ; cursor tile number
	db SYM_SPACE ; tile behind cursor
	dw NULL ; function pointer if non-0

BenchMultiSelectMenuAISelection:
	ldh [hTemp_ffa0], a
	or a
	ret z ; can't choose any

	; clears all selection values
	call ClearPlayAreaList

	farcall CheckNonTurnDuelistHasBench
	jr nc, .has_bench
	; no bench, output 0
	xor a
	ldh [hTemp_ffa0], a
	ret

.has_bench
	ld c, 1
	ldh a, [hTemp_ffa0]
	cp 1
	jr z, .only_1_selection
	farcall CheckNonTurnDuelistHasBench
	cp 2
	jr z, .only_one_target
	; has more than 1 bench card and can select more than once
	ld c, 2
.only_1_selection
	; select lowest HP card, once or twice according to c
	push bc
	farcall AIFindTargetForBenchAttack
	ld e, a
	ld d, $00
	ld hl, wPlayAreaList
	add hl, de
	pop bc
	ld [hl], c ; choose this card once or twice, according to c
.got_counts
	ld hl, hTempList + 1
	ld de, wPlayAreaList
	ld c, MAX_PLAY_AREA_POKEMON
.loop_selected_counts
	ld a, [de]
	inc de
	ld [hli], a
	dec c
	jr nz, .loop_selected_counts
	ret

.only_one_target
	; select single target 2 times
	ld a, 2
	ld [wPlayAreaList + PLAY_AREA_BENCH_1], a
	jr .got_counts

; clears wPlayAreaList
ClearPlayAreaList:
	ld hl, wPlayAreaList
	xor a
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld [hl], a
	ret

RockBlast_AIEffect:
	ld a, TYPE_ENERGY_FIGHTING
	farcall CreateListOfEnergyAttachedToArena
	cp 5
	jr c, .capped
	ld a, 5
.capped
	call ATimes10
	; bug, this is doing *10 but should be *20 damage
	; max damage = min(num Fighting energies, 5) * 10
	ld [wAIMaxDamage], a
	xor a
	ld [wDamage], a
	ld [wDamage + 1], a
	ld [wAIMinDamage], a
	ret

RockBlast_EnergiesCheck:
	ld a, TYPE_ENERGY_FIGHTING
	farcall CreateListOfEnergyAttachedToArena
	ldtx hl, NoFightingEnergyText
	; carry set if no Fighting energy cards
	ret

RockBlast_AISelectEffect:
	; don't select any cards to discard
	xor a
	ldh [hTemp_ffa0], a
	ret

RockBlast_PlayerSelectEffect:
	; handle selection of Fighting energy cards to discard
	xor a
	ld [wAttachedEnergyMenuNumerator], a
	ld a, 1
	ldh [hCurSelectionItem], a
	ld a, TYPE_ENERGY_FIGHTING
	farcall CreateListOfEnergyAttachedToArena
	xor a ; PLAY_AREA_ARENA
	bank1call DisplayEnergyDiscardMenu
	ld a, 5
	ld [wAttachedEnergyMenuDenominator], a
.loop_select_energies
	; get player selection
	bank1call HandleAttachedEnergyMenuInput
	jr nc, .got_energy_card_selection
	; tried to cancel, ask if player wants to finish selection
	ld a, 5 + 1
	farcall AskWhetherToQuitSelectingCards
	jr nc, .done_selecting_energies
	; not yet, loop back
	jr .update_discard_menu
.got_energy_card_selection
	ld hl, wAttachedEnergyMenuNumerator
	inc [hl]
	farcall GetNextPositionInTempList
	ldh a, [hTempCardIndex_ff98]
	ld [hl], a
	call RemoveCardFromDuelTempList
	jr c, .done_selecting_energies
	; did we select 5 cards?
	; if so, then we are done
	ldh a, [hCurSelectionItem]
	cp 5 + 1
	jr nc, .done_selecting_energies
.update_discard_menu
	bank1call UpdateAttachedEnergyMenu
	jr .loop_select_energies

.done_selecting_energies
	farcall GetNextPositionInTempList
	ld [hl], $ff ; terminating byte

	; clears all selection values
	call ClearPlayAreaList

	ldh a, [hCurSelectionItem]
	sub 2
	ldh [hTemp_ffa0], a
	jr z, .got_play_area_selection
	call SwapTurn

	; set num of selections made to 0
	xor a
	ld [wPlayAreaMultiSelectMenuNumSelections], a
	; set current item to 0
	ldh [hCurScrollMenuItem], a

	; prepare to show Play Area
	bank1call SetupPlayAreaScreen
	bank1call PrintPlayAreaCardList_EnableLCD

.init_menu
	ldh a, [hCurScrollMenuItem]
	ld hl, RockBlastSelectionMenuParameters
	call InitializeMenuParameters
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	; a = num of play area pkmn
	ld [wNumScrollMenuItems], a

.select_loop
	call RefreshRockBlastSelectCounts
.loop_input
	call DoFrame
	call HandleMenuInput
	jr nc, .loop_input
	cp -1
	jr nz, .selected_pkmn
	; B was pressed
	call UndoLastRockBlastSelection
	jr .select_loop

.selected_pkmn
	farcall GetNextPositionInTempList
	ldh a, [hCurScrollMenuItem]
	ld [hl], a
	ld e, a
	ld d, $00
	ld hl, wPlayAreaList
	add hl, de
	inc [hl]

	; increment num of selections
	ld hl, wPlayAreaMultiSelectMenuNumSelections
	inc [hl]
	; is it equal to total selections allowed?
	ldh a, [hTemp_ffa0]
	cp [hl]
	jr nz, .select_loop
	; done all allowable selections
	call RefreshRockBlastSelectCounts

	ldh a, [hCurScrollMenuItem]
	farcall DrawPlayAreaScreenToShowChanges
	ldh a, [hKeysPressed]
	and PAD_B
	jr z, .apply_selection
	call UndoLastRockBlastSelection
	jr .init_menu

.apply_selection
	farcall GetNextPositionInTempList
	ld [hl], $ff ; terminating byte
	call SwapTurn

.got_play_area_selection
	; wPlayAreaList list holds number of times each
	; bench Pokémon was chosen
	ldh a, [hTemp_ffa0]
	ld e, a
	ld d, $00
	ld hl, hTempList + 2
	add hl, de
	ld de, wPlayAreaList
	ld c, MAX_PLAY_AREA_POKEMON
.loop_selected_counts
	ld a, [de]
	inc de
	ld [hli], a
	dec c
	jr nz, .loop_selected_counts
	ret

RockBlast_DiscardEnergiesAndDamageArenaEffect:
	ld hl, hTemp_ffa0
	ld a, [hli]
	or a
	jr nz, .loop_discard
	; a = ATK_ANIM_NONE
	ld [wLoadedAttackAnimation], a
	ret
.loop_discard
	ld a, [hli]
	cp $ff
	jr z, .check_target
	call DiscardCard
	jr .loop_discard
.check_target
	ld a, [hl]
	or a
	jr z, .selected_bench
	; deal damage to arena card
	call SwapTurn
	add a ; *2
	call ATimes10
	ld e, a
	ld d, $00
	ld b, PLAY_AREA_ARENA
	call DealDamageToPlayAreaPokemon_RegularAnim
	call SwapTurn
.selected_bench
	; we'll handle bench damage in next command
	xor a ; ATK_ANIM_NONE
	ld [wLoadedAttackAnimation], a
	ld hl, wLoadedAttackCategory
	res RESIDUAL_F, [hl]
	ret

RockBlast_DamageBenchEffect:
	ld hl, hTemp_ffa0
	ld a, [hli]
	or a
	ret z ; no cards discarded
	inc a
	ld e, a
	ld d, $00
	add hl, de
	ld b, PLAY_AREA_BENCH_1
	ld c, 5
	inc hl
	call SwapTurn
.loop_damage
	ld a, [hli]
	push hl
	push bc
	add a ; *2
	jr z, .next
	; deal count * 2 * 10 damage to this bench card
	call ATimes10
	ld e, a
	ld d, $00
	call DealDamageToPlayAreaPokemon_RegularAnim
.next
	pop bc
	pop hl
	inc b
	dec c
	jr nz, .loop_damage
	call SwapTurn
	ret

UndoLastRockBlastSelection:
	ld hl, wPlayAreaMultiSelectMenuNumSelections
	ld a, [hl]
	or a
	ret z ; nothing to undo
	dec [hl] ; decrement total selections
	ld hl, hCurSelectionItem
	dec [hl] ; decrement current item
	ld e, [hl]
	ld d, $00
	ld hl, hTempList
	add hl, de
	ld e, [hl]
	ld d, $00
	ld hl, wPlayAreaList
	add hl, de
	dec [hl] ; decrement count of this play area pkmn
	ret

RefreshRockBlastSelectCounts:
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	ld e, a ; num play area pkmn
	lb bc, 0, 2 ; x, y
	ld hl, wPlayAreaList + PLAY_AREA_ARENA
.loop_play_area
	ld a, [hli]
	add SYM_0
	call WriteByteToBGMap0
	inc c
	inc c
	inc c ; y += 3
	dec e
	jr nz, .loop_play_area
	ret

RockBlastSelectionMenuParameters:
	db 0, 0 ; cursor x, cursor y
	db 3 ; y displacement between items
	db MAX_PLAY_AREA_POKEMON ; number of items
	db SYM_CURSOR_R ; cursor tile number
	db SYM_SPACE ; tile behind cursor
	dw NULL ; function pointer if non-0

Fireworks_InitialEffect:
	farcall Func_6808d
	ret

Fireworks_AIEffect:
	xor a ; PLAY_AREA_ARENA
	call CreateArenaOrBenchEnergyCardList
	ret nc ; has energy
	xor a ; 0 damage
	farcall SetDefiniteDamage
	ret

Fireworks_AISelectEffect:
	ldtx de, IfTailsDiscard1EnergyCardFromYourselfText
	farcall Serial_TossCoin
	ldh [hTemp_ffa0], a
	ret c ; got heads
	xor a ; PLAY_AREA_ARENA
	call CreateArenaOrBenchEnergyCardList
	ld a, [wDuelTempList + 0]
	ldh [hTempPlayAreaLocation_ffa1], a
	ret

Fireworks_PlayerSelectEffect:
	ldtx de, IfTailsDiscard1EnergyCardFromYourselfText
	farcall Serial_TossCoin
	ldh [hTemp_ffa0], a
	jr c, .heads

	; got tails, needs to discard a fire energy
	xor a ; PLAY_AREA_ARENA
	call CreateArenaOrBenchEnergyCardList
	ld a, $ff
	jr z, .got_selection
	xor a
	bank1call DisplayEnergyDiscardMenu
.select
	bank1call HandleAttachedEnergyMenuInput
	jr c, .select ; mandatory selection
	ldh a, [hTempCardIndex_ff98]
.got_selection
	ldh [hTempPlayAreaLocation_ffa1], a
.heads
	or a
	ret

Fireworks_DiscardEffect:
	ldh a, [hTemp_ffa0]
	or a
	ret nz ; got heads
	ldh a, [hTempPlayAreaLocation_ffa1]
	cp $ff
	ret z ; selected a card
	call DiscardCard
	ret

BigYawn_SleepCheck:
	; Slowbro is the only card that can attack while asleep
	; which means that the player can access its attacks
	; this prevents the player using Big Yawn if Slowbro is asleep
	call CheckIfAttackingCardIsAsleep
	ldtx hl, UnableDueToSleepText
	ret

BigYawn_SleepEffect:
	farcall SleepEffect
	call SwapTurn
	farcall SleepEffect
	call SwapTurn
	ret

BigSnoreEffect:
	; can only use this attack while asleep
	call CheckIfAttackingCardIsAsleep
	ldtx hl, CannotUseDueToNotAsleepText
	ccf ; carry set if NOT asleep
	ret

; returns carry if turn-holder's Arena card is asleep
CheckIfAttackingCardIsAsleep:
	ld a, DUELVARS_ARENA_CARD_STATUS
	get_turn_duelist_var
	and CNF_SLP_PRZ
	cp ASLEEP
	jr nz, .not_asleep
	scf
	ret
.not_asleep
	or a
	ret

SpookifyEffect:
	ld a, DUELVARS_ARENA_CARD_SUBSTATUS3
	call GetNonTurnDuelistVariable
	set SUBSTATUS3_SPOOKIFY_F, [hl]
	ret

Poltergeist_AIEffect:
	ld a, 10 ; estimates 1 Trainer card in hand
	lb de, 0, 30 ; estimates min 0 and max 3 Trainer cards in hand
	farcall SetExpectedAIDamage
	ret

Poltergeist_10DamagePerTrainerEffect:
	call SwapTurn
	call CreateHandCardList
	jr c, .no_hand

	; shows hand card list
	bank1call InitAndDrawCardListScreenLayout
	ldtx hl, ChooseCardToCheckText
	ldtx de, DuelistHandText
	bank1call SetCardListHeaderAndInfoText
	ld a, PAD_START + PAD_A
	ld [wNoItemSelectionMenuKeys], a
	bank1call DisplayCardList

	; count how many Trainer cards there are
	ld hl, wDuelTempList
	ld c, 0
.loop_hand_cards
	ld a, [hli]
	cp $ff
	jr z, .got_tally
	call LoadCardDataToBuffer1_FromDeckIndex
	ld a, [wLoadedCard1Type]
	cp TYPE_TRAINER
	jr nz, .loop_hand_cards
	inc c
	jr .loop_hand_cards

.got_tally
	call SwapTurn
	; does number of Trainer cards times 10 damage
	ld l, c
	ld h, 10
	call HtimesL
	ld a, l
	ld [wDamage], a
	ld a, h
	ld [wDamage + 1], a
	ret

.no_hand
	ldtx hl, DuelistHasNoCardsInHandText
	call DrawWideTextBox_WaitForInput
	call SwapTurn
	xor a
	farcall SetDefiniteDamage
	ret

BadDreamsEffect:
	ldtx de, AsleepIfHeadsConfusedIfTailsText
	farcall TossCoin_Bank1a
	jr c, .heads
; tails
	farcall ConfusionEffect
	ret
.heads
	farcall SleepEffect
	ret

GrudgeEffect:
	call SwapTurn
	call CountPrizes
	call SwapTurn
	ld e, a
	ld a, [wDuelInitialPrizes]
	sub e ; (initial prizes) - (current prizes)
	call ATimes10
	farcall AddToDamage
	ret

PowerOfDarkness_InitialEffect:
	farcall Func_6808d
	scf
	ret

PowerOfDarkness_PlayerSelectEffect:
	ldtx de, PowerOfDarknessCheckText
	farcall Serial_TossCoin
	ldh [hTemp_ffa0], a
	ret nc ; tails
	ldtx hl, ChoosePokemonToReturnToHandText
	call DrawWideTextBox_WaitForInput
	call SwapTurn
	bank1call HasAlivePokemonInPlayArea
.select
	bank1call OpenPlayAreaScreenForSelection
	jr c, .select ; mandatory selection
	call SwapTurn
	ldh [hTempPlayAreaLocation_ffa1], a
	ret

PowerOfDarkness_ReturnToHandEffect:
	ldh a, [hTemp_ffa0]
	or a
	ret z ; got tails

	; add to hand all cards that are in
	; the chosen Play Area location
	call SwapTurn
	ldh a, [hTempPlayAreaLocation_ffa1]
	or CARD_LOCATION_PLAY_AREA
	ld b, a
	ld a, DUELVARS_CARD_LOCATIONS
	get_turn_duelist_var
.loop_add_to_hand
	ld a, [hl]
	cp b
	jr nz, .next_card
	ld a, l
	call AddCardToHand
.next_card
	inc l
	ld a, l
	cp DECK_SIZE
	jr c, .loop_add_to_hand

	ldh a, [hTempPlayAreaLocation_ffa1]
	add DUELVARS_ARENA_CARD
	ld l, a
	ld a, [hl]
	ldh [hTempCardIndex_ff98], a
	; indicate empty play area location
	ld [hl], $ff
	; zero out its HP
	ldh a, [hTempPlayAreaLocation_ffa1]
	add DUELVARS_ARENA_CARD_HP
	ld l, a
	ld [hl], $00
	; get card's name for printing text
	ldh a, [hTempCardIndex_ff98]
	call LoadCardDataToBuffer1_FromDeckIndex
	ld hl, wLoadedCard1Name
	ld a, [hli]
	ld h, [hl]
	ld l, a
	call LoadTxRam2
	ldtx hl, PokemonAndAllAttachedCardsReturnedToHandText
	call DrawWideTextBox_WaitForInput

	xor a
	ld [wDuelDisplayedScreen], a
	call SwapTurn
	bank1call HandleDestinyBondAndBetweenTurnKnockOuts
	ret

PsyHorrorEffect:
	ldtx de, AsleepIfHeadsConfusedIfTailsText
	farcall TossCoin_Bank1a
	jr c, .heads
; tails
	farcall ConfusionEffect
	ret
.heads
	farcall SleepEffect
	ret

PuppetMasterEffect:
	scf
	ret

HypnoMindShockEffect:
	ld hl, wDamage + 1
	set UNAFFECTED_BY_WEAKNESS_RESISTANCE_F, [hl]
	ret

Func_65cf9:
	ld a, ATK_ANIM_PSYCHIC_HIT
	ld [wLoadedAttackAnimation], a
	ld hl, wDamage + 1
	set UNAFFECTED_BY_WEAKNESS_RESISTANCE_F, [hl]
	ret

SaltWater_DeckCheck:
	farcall Func_6808d
	farcall CheckIfDeckIsEmpty
	ret

SaltWater_AIEffect:
	; this selection is handled in AISelectSpecialAttackParameters
	xor a
	ldh [hTemp_ffa0], a
	ret

SaltWater_PlayerSelectEffect:
	ldtx de, IfHeadsAttachUpTo3WaterEnergyFromDeckText
	farcall Serial_TossCoin
	ldh [hTemp_ffa0], a
	ret nc ; tails

	; was heads
	ld a, 1
	ldh [hCurSelectionItem], a
	call CreateDeckCardList
.init_menu
	bank1call InitAndDrawCardListScreenLayout
	ldtx hl, ChooseWaterEnergyText
	ldtx de, DuelistDeckText
	bank1call SetCardListHeaderAndInfoText
.loop_selection
	bank1call DisplayCardList
	jr nc, .selected_card
	; prompt player if they want to quit if more cards
	; are available to be selected
	ld a, 3 + 1
	farcall AskWhetherToQuitSelectingCards
	jr nc, .finished_selection ; "yes"
	jr .init_menu              ; "no"
.selected_card
	ldh a, [hTempCardIndex_ff98]
	call LoadCardDataToBuffer1_FromDeckIndex
	ld a, [wLoadedCard1Type]
	cp TYPE_ENERGY_WATER
	jr nz, .loop_selection
	farcall GetNextPositionInTempList
	ldh a, [hTempCardIndex_ff98]
	ld [hl], a
	call RemoveCardFromDuelTempList
	jr c, .finished_selection
	ldh a, [hCurSelectionItem]
	cp 3 + 1
	jr c, .init_menu
	; no more cards that can be selected
.finished_selection
	farcall GetNextPositionInTempList
	ld [hl], $ff ; terminating byte
	or a
	ret

SaltWater_ClearAnimationIfFailed:
	ldh a, [hTemp_ffa0]
	or a
	ret nz ; was heads
	; a = ATK_ANIM_NONE
	ld [wLoadedAttackAnimation], a
	ret

SaltWater_AttachToArenaEffect:
	ld hl, hTemp_ffa0
	ld a, [hli]
	or a
	ret z ; was tails

	; attach all cards selected from the deck
	; to the card in the Arena
.loop_attach_energy
	ld a, [hli]
	cp $ff
	jr z, .finish
	call SearchCardInDeckAndAddToHand
	call AddCardToHand
	push hl
	ld e, PLAY_AREA_ARENA
	call PutHandCardInPlayArea
	pop hl
	jr .loop_attach_energy

.finish
	farcall ShuffleCardsInDeck
	ret

DoubleEdgedPincersEffect:
	ld a, SUBSTATUS1_DOUBLE_DAMAGE
	farcall ApplySubstatus1ToAttackingCard
	ret

BoneToss_InitialEffect:
	farcall Func_6808d
	ret

BoneToss_AIEffect:
	ld a, 30 / 2
	lb de, 0, 30
	farcall SetExpectedAIDamage
	ret

BoneToss_AISelectEffect:
	ldtx de, IfHeads30DamageToOppIfTails10DamageToBenchText
	farcall Serial_TossCoin
	ldh [hTemp_ffa0], a
	ret c ; heads

	; tails, choose a Bench pkmn to damage
	farcall CheckNonTurnDuelistHasBench
	jr c, SetUnsuccessfulBoneToss
	farcall AIFindTargetForBenchAttack
	ldh [hTempPlayAreaLocation_ffa1], a
	ret

BoneToss_PlayerSelectEffect:
	ldtx de, IfHeads30DamageToOppIfTails10DamageToBenchText
	farcall Serial_TossCoin
	ldh [hTemp_ffa0], a
	ret c ; heads

	; tails, choose a Bench pkmn to damage
	farcall CheckNonTurnDuelistHasBench
	jr c, SetUnsuccessfulBoneToss
	ldtx hl, ChooseBenchedPokemonToGiveDamageText
	call DrawWideTextBox_WaitForInput
	call SwapTurn
	bank1call HasAlivePokemonInBench
.select
	bank1call OpenPlayAreaScreenForSelection
	jr c, .select ; mandatory selection
	ldh [hTempPlayAreaLocation_ffa1], a
	call SwapTurn
	ret

SetUnsuccessfulBoneToss:
	xor a
	ldh [hTemp_ffa0], a
	ldh [hTempPlayAreaLocation_ffa1], a
	ret

BoneToss_ArenaDamageEffect:
	ldh a, [hTemp_ffa0]
	or a
	jr z, .set_atk_anim_none
	; attack Arena card
	ld a, 30
	farcall SetDefiniteDamage
	ret
.set_atk_anim_none
	; a = ATK_ANIM_NONE
	ld [wLoadedAttackAnimation], a
	ret

BoneToss_BenchDamageEffect:
	ldh a, [hTemp_ffa0]
	or a
	ret nz ; got heads
	ldh a, [hTempPlayAreaLocation_ffa1]
	or a
	ret z ; no selection

	; deal 10 damage to selected Bench pkmn
	call SwapTurn
	ld b, a
	ld a, ATK_ANIM_BONE_TOSS_BENCH
	ld [wLoadedAttackAnimation], a
	ld de, 10
	call DealDamageToPlayAreaPokemon
	call SwapTurn
	ret

PoisonMist_CheckUse:
	farcall CheckIfCanUsePkmnPowerThisTurn
	ret

PoisonMist_SetAffectedByPoisonMistEffect:
	farcall SetUsedPkmnPowerThisTurnFlag
	ldtx de, PoisonMistCheckText
	farcall TossCoin_Bank1a
	ret nc ; tails
	ldh a, [hTempPlayAreaLocation_ff9d]
	add DUELVARS_ARENA_CARD_FLAGS
	get_turn_duelist_var
	set AFFECTED_BY_POISON_MIST_F, [hl]
	ret

GasExplosionEffect:
	ld a, 30
	call DealRecoilDamageToSelf
	ld a, DUELVARS_ARENA_CARD_HP
	call GetNonTurnDuelistVariable
	or a
	ret nz ; 
	ld a, TRUE
	ld [wKnockedOutByGasExplosion], a
	ret

MountainBreak_DeckCheck:
	farcall CheckIfDeckIsEmpty
	ret

MountainBreak_DiscardAndAddToHandEffect:
	ld a, 5
	ldh [hCurSelectionItem], a
.loop_draw
	call DrawCardFromDeck
	jr c, .no_more_cards
	ldh [hTempCardIndex_ff98], a
	call PutCardInDiscardPile
	call LoadCardDataToBuffer1_FromDeckIndex
	ld a, [wLoadedCard1Type]
	cp TYPE_ENERGY_FIGHTING
	jr nz, .not_fighting
	; if Black Hole is in effect, then can't
	; add it from Discard Pile to hand
	ld a, [wSpecialRule]
	cp BLACK_HOLE
	jr z, .not_fighting
	; add it to the hand
	ldh a, [hTempCardIndex_ff98]
	call MoveDiscardPileCardToHand
	call AddCardToHand
.not_fighting
	; show card
	ldtx hl, DiscardedCardText
	ldh a, [hTempCardIndex_ff98]
	bank1call DisplayCardDetailScreen
	ld hl, hCurSelectionItem
	dec [hl]
	jr nz, .loop_draw
.no_more_cards
	ret

OneTwoStrike_AIEffect:
	ld a, (30 + 50) / 2
	lb de, 30, 50
	farcall SetExpectedAIDamage
	ret

OneTwoStrike_DamageBoostEffect:
	ld a, 20
	farcall AddDamageIfHeads
	ret

TailDrop_AIEffect:
	ld a, 80
	lb de, 0, 80
	farcall SetExpectedAIDamage
	ret

TailDrop_NoDamage25PercentEffect:
	ldtx de, FailIfEitherOf2CoinsIsTailsText
	ld a, 2
	farcall TossCoinATimes_Bank1a
	cp 2
	ret z ; got 2 heads
	xor a ; ATK_ANIM_NONE
	ld [wLoadedAttackAnimation], a
	; a = 0 damage
	farcall SetDefiniteDamage
	farcall SetWasUnsuccessful
	ret

HideEffect:
	ldtx de, AttackSuccessCheckText
	farcall TossCoin_Bank1a
	jr c, .successful
	xor a ; ATK_ANIM_NONE
	ld [wLoadedAttackAnimation], a
	farcall SetWasUnsuccessful
	ret
.successful
	ld a, SUBSTATUS1_HIDE
	farcall ApplySubstatus1ToAttackingCard
	ret

HorseaWaterGunEffect:
	lb bc, 1, 0
	farcall ApplyExtraWaterEnergy10DamageBonus
	ret

WaterBomb_PlayerSelectEffect:
	lb bc, 2, 0
	farcall CalculateExtraWaterEnergiesForDamageBonus
	call BenchMultiSelectMenuPlayerSelection
	ret

WaterBomb_AISelectEffect:
	lb bc, 2, 0
	farcall CalculateExtraWaterEnergiesForDamageBonus
	call BenchMultiSelectMenuAISelection
	ret

WaterBomb_BenchDamageEffect:
	ld hl, hTemp_ffa0
	ld a, [hli]
	or a
	ret z ; no damage to bench
	call SwapTurn
	ld b, PLAY_AREA_ARENA
	ld c, MAX_PLAY_AREA_POKEMON
.loop_play_area
	ld a, [hli]
	push hl
	push bc
	or a
	jr z, .next
	; deal 10 damage to this Play Area card
	call ATimes10
	ld e, a
	ld d, 0
	call DealDamageToPlayAreaPokemon_RegularAnim
.next
	pop bc
	pop hl
	inc b
	dec c
	jr nz, .loop_play_area
	call SwapTurn
	ret

StrangeBeamEffect:
	ld a, DUELVARS_ARENA_CARD_SUBSTATUS3
	get_turn_duelist_var
	set SUBSTATUS3_STRANGE_BEAM_F, [hl]
	ret

SlashingStrike_CheckUse:
	ld a, SUBSTATUS1_CANNOT_USE_SLASHING_STRIKE
	farcall CheckIfHasSubstatusThatPreventsUsingAttack
	ret

SlashingStrike_CannotUseNextTurnEffect:
	ld a, SUBSTATUS1_CANNOT_USE_SLASHING_STRIKE
	farcall ApplySubstatus1ToAttackingCardAndSetCountdown
	ret

BurningFire_AIEffect:
	xor a
	farcall CreateListOfFireEnergyAttachedToArena
	call ATimes10
	add 10
	ld e, a  ; max damage
	ld d, 10 ; min damage
	ld a, d  ; mean damage
	farcall SetExpectedAIDamage
	ret

BurningFire_AISelectEffect:
	; this selection is handled in AISelectSpecialAttackParameters
	ld a, $ff
	ldh [hTemp_ffa0], a
	ret

BurningFire_PlayerSelectEffect:
	ldtx hl, ProcedureForBurningFireText
	bank1call DrawWholeScreenTextBox
.start_selection
	; copy all player variables to temporary buffer
	; this is done so that we temporarily discard chosen cards
	; and at the end of selection this is reverted
	; actual discarding is done in next effect command step
	ldh a, [hWhoseTurn]
	ld h, a
	ld l, LOW(wPlayerDuelVariables)
	ld de, wc000
.loop_copy_to_buffer
	ld a, [hli]
	ld [de], a
	inc e
	jr nz, .loop_copy_to_buffer

	xor a
	ldh [hCurSelectionItem], a

	; first select a play area Pokémon
.select_play_area_pkmn
	bank1call HasAlivePokemonInPlayArea
.play_area_selection
	bank1call OpenPlayAreaScreenForSelection
	cp -1 ; B pressed?
	jr z, .done_selecting_energies
	; selected a pkmn, does it have Fire energies?
	ldh [hTempPlayAreaLocation_ff9d], a
	farcall GetListOfFireEnergiesFromPlayAreaCard
	jr c, .play_area_selection ; no Fire energies
	ldh a, [hTempPlayAreaLocation_ff9d]
	bank1call DisplayEnergyDiscardMenu
	ldh a, [hCurSelectionItem]
	ld [wAttachedEnergyMenuNumerator], a
	xor a
	ld [wAttachedEnergyMenuDenominator], a
	bank1call HandleAttachedEnergyMenuInput
	jr c, .select_play_area_pkmn ; cancelled operation
	; selected a Fire energy, place it in Discard Pile
	call PutCardInDiscardPile
	farcall GetNextPositionInTempList
	ldh a, [hTempCardIndex_ff98]
	ld [hl], a
	ldh a, [hCurSelectionItem]
	cp 15 ; max 15 energies chosen this way
	jr c, .select_play_area_pkmn

.done_selecting_energies
	farcall GetNextPositionInTempList
	ld [hl], $ff ; terminating byte

	; restore player variables from buffer
	ldh a, [hWhoseTurn]
	ld d, a
	ld e, LOW(wPlayerDuelVariables)
	ld hl, wc000
.loop_copy_from_buffer
	ld a, [hli]
	ld [de], a
	inc e
	jr nz, .loop_copy_from_buffer
	ldh a, [hCurSelectionItem] ; num energies chosen to discard
	dec a
	ld l, a
	ld h, $00
	call LoadTxRam3
	ldtx hl, DiscardingXCardsPromptText
	call YesOrNoMenuWithText_SetCursorToYes
	jr c, .start_selection
	ret

BurningFire_DiscardAndMutliplierEffect:
	ld hl, hTemp_ffa0
	ld c, 0 ; energy discarded tally
.loop_discard
	ld a, [hli]
	cp $ff
	jr z, .done_discard
	call DiscardCard
	inc c
	jr .loop_discard
.done_discard
	; do 10 * discarded energies in damage
	ld a, c
	call ATimes10
	farcall AddToDamage
	ret

KickingAndStamping_InitialEffect:
	farcall Func_6808d
	ret

KickingAndStamping_AIEffect:
	ld a, (20 + 30) / 2
	lb de, 20, 30
	farcall SetExpectedAIDamage
	ret

KickingAndStamping_Switch50PercentEffect:
	; AI flips a coin, if tails, defending card is forced to switch
	ldtx de, KickingAndStampingCheckText
	farcall Serial_TossCoin
	ldh [hTemp_ffa0], a
	ret c ; tails, will do more damage
	farcall HandleMandatorySwitchSelection
	ldh a, [hTempPlayAreaLocation_ff9d]
	ldh [hTempPlayAreaLocation_ffa1], a
	ret

KickingAndStamping_DamageBoostEffect:
	ldh a, [hTemp_ffa0]
	or a
	ret z ; was tails, no damage boost
	ld a, 10
	farcall AddToDamage
	ret

KickingAndStamping_SwitchEffect:
	ldh a, [hTemp_ffa0]
	or a
	ret nz ; was heads, no switching
	ldh a, [hTempPlayAreaLocation_ffa1]
	farcall HandleSwitchDefendingPokemonEffect
	ret

FossilGuidance_CheckUse:
	farcall CheckIfCanUsePkmnPowerThisTurn
	ret c
	call CheckIfAnyMysteriousFossilCardsInDiscardPile
	ldtx hl, NoFossilsInDiscardPileText
	ret

FossilGuidance_AddToHand50PercentEffect:
	farcall SetUsedPkmnPowerThisTurnFlag
	ldtx de, FossilGuidanceCheckText
	farcall TossCoin_Bank1a
	ret nc ; tails
	; was successful, add it to the hand
	call CheckIfAnyMysteriousFossilCardsInDiscardPile
	ldh a, [hTempCardIndex_ff98]
	call MoveDiscardPileCardToHand
	call AddCardToHand
	ldh a, [hTempCardIndex_ff98]
	bank1call DisplayPlayerDrawCardScreen
	ret

; returns carry if NO Mysterious Fossil cards in the Discard Pile
CheckIfAnyMysteriousFossilCardsInDiscardPile:
	bank1call CreateDiscardPileCardList
	ld hl, wDuelTempList
.loop
	ld a, [hli]
	ldh [hTempCardIndex_ff98], a
	cp $ff
	jr z, .none_found
	call GetCardIDFromDeckIndex
	cp16 MYSTERIOUS_FOSSIL
	jr nz, .loop
	or a
	ret
.none_found
	scf
	ret

TentacleGrip_DeckAndEnergyCheck:
	farcall CheckIfDeckIsEmpty
	ret c ; no cards in deck
	ld a, TYPE_ENERGY_WATER
	farcall CreateListOfEnergyAttachedToArena
	ldtx hl, NoWaterEnergyText
	ret ; carry if no Water energies attached

TentacleGrip_FlipCoinsEffect:
	ld a, TYPE_ENERGY_WATER
	farcall CreateListOfEnergyAttachedToArena
	; a = num of Water energies attached to Arena card
	ldtx de, DrawCardForEachHeadsText
	farcall TossCoinATimes_Bank1a
	ldh [hTemp_ffa0], a
	ret

TentacleGrip_DrawEffect:
	ldh a, [hTemp_ffa0]
	or a
	ret z ; no heads
	add a ; * 2
	; a = num of cards to draw
	farcall DisplayDrawNCardsScreen
	ldh a, [hTemp_ffa0]
	add a
	ld c, a
.loop_draw
	call DrawCardFromDeck
	jr c, .no_more_cards
	ldh [hTempCardIndex_ff98], a
	call AddCardToHand
	farcall IsPlayerTurn
	jr nc, .next_draw
	; show card to player
	push bc
	bank1call DisplayPlayerDrawCardScreen
	pop bc
.next_draw
	dec c
	jr nz, .loop_draw
.no_more_cards
	ret

CorrosiveAcid_CheckCanUse:
	ld a, SUBSTATUS1_CANNOT_USE_CORROSIVE_ACID
	farcall CheckIfHasSubstatusThatPreventsUsingAttack
	ret

CorrosiveAcid_ParalysisOrCannotUseNextTurnEffect:
	ldtx de, ParalyzedIfHeadsUnableToAttackNextTurnIfTailsText
	farcall TossCoin_Bank1a
	jr nc, .tails
; heads
	farcall ParalysisEffect
	ret
.tails
	ld a, ATK_ANIM_CORROSIVE_ACID
	ld [wLoadedAttackAnimation], a
	ld a, SUBSTATUS1_CANNOT_USE_CORROSIVE_ACID
	farcall ApplySubstatus1ToAttackingCardAndSetCountdown
	ret

CompleteRecovery_HPAndStatusCheck:
	ld e, PLAY_AREA_ARENA
	call GetCardDamageAndMaxHP
	or a
	ret nz ; has damage counters
	ld a, DUELVARS_ARENA_CARD_STATUS
	get_turn_duelist_var
	or a
	ret nz ; has status
	ldtx hl, NotAffectedByStatusText
	scf
	ret

CompleteRecovery_ClearStatusAndHealDamageEffect:
	; clear any status
	ld a, DUELVARS_ARENA_CARD_STATUS
	get_turn_duelist_var
	ld [hl], NO_STATUS

	; heal all damage
	ld e, PLAY_AREA_ARENA
	call GetCardDamageAndMaxHP
	ld e, a
	ld d, 0
	farcall ApplyAndAnimateHPRecovery

	; discard all energies attached to Arena
	ld a, DUELVARS_CARD_LOCATIONS
	get_turn_duelist_var
.loop_discard
	ld a, [hl]
	cp CARD_LOCATION_ARENA
	jr nz, .next_card
	ld a, l
	call LoadCardDataToBuffer1_FromDeckIndex
	ld a, [wLoadedCard1Type]
	cp TYPE_ENERGY
	jr c, .next_card
	ld a, l
	call DiscardCard
.next_card
	inc l
	ld a, l
	cp DECK_SIZE
	jr c, .loop_discard
	ret

PsychoBlast_InitialEffect:
	farcall CreateNonTurnDuelistArenaEnergyCardList
	jr c, .no_cards
	farcall Func_6808d
.no_cards
	or a
	ret

PsychoBlast_PlayerSelectEffect:
	xor a
	ldh [hTempPlayAreaLocation_ffa1], a
	farcall CreateNonTurnDuelistArenaEnergyCardList
	ret c ; arena has no energy attached
	ldtx de, IfHeadsDiscard1EnergyCardFromOpponentText
	farcall Serial_TossCoin
	ldh [hTempPlayAreaLocation_ffa1], a
	ret nc ; tails
	; discard an energy from Defending card
	farcall HandleDiscardEnergyFromDefendingCardPlayerSelection
	ret

PsychoBlast_AISelectEffect:
	xor a
	ldh [hTempPlayAreaLocation_ffa1], a
	farcall CreateNonTurnDuelistArenaEnergyCardList
	ret c ; arena has no energy attached
	ldtx de, IfHeadsDiscard1EnergyCardFromOpponentText
	farcall Serial_TossCoin
	ldh [hTempPlayAreaLocation_ffa1], a
	ret nc ; tails
	; discard an energy from Defending card
	farcall _AIPickEnergyCardToDiscardFromDefendingPokemon
	ldh [hTemp_ffa0], a
	ret

PsychoBlast_DiscardEffect:
	ldh a, [hTempPlayAreaLocation_ffa1]
	or a
	ret z ; no discard
	farcall DiscardEnergyEffect
	ret

DarkPersianAltFascinate_InitialEffect:
	farcall FascinateInitialEffect
	ret

DarkPersianAltFascinate_AISelectEffect:
	farcall FascinateAISelectEffect
	ret

DarkPersianAltFascinate_PlayerSelectEffect:
	farcall FascinatePlayerSelectEffect
	ret

DarkPersianAltFascinate_LoadAnimation:
	farcall FascinateLoadAnimation
	ret

DarkPersianAltFascinate_SwitchEffect:
	farcall FascinateSwitchEffect
	ret

ClearProfit_DeckCheck:
	farcall CheckIfDeckIsEmpty
	ret

ClearProfit_FlipCoinUntilTailsEffect:
	xor a ; num of heads
	ldh [hTemp_ffa0], a
.loop_coin_toss
	ldtx de, ClearProfitCheckText
	xor a
	farcall TossCoinATimes_Bank1a
	jr nc, .done ; tails
	; heads, increment tally
	ld hl, hTemp_ffa0
	inc [hl]
	jr .loop_coin_toss
.done
	ret

ClearProfit_DrawEffect:
	ldh a, [hTemp_ffa0]
	or a
	ret z ; no heads
	; a = num of cards to draw
	farcall DisplayDrawNCardsScreen
	ldh a, [hTemp_ffa0]
	ld c, a
.loop_draw
	call DrawCardFromDeck
	jr c, .no_more_cards
	ldh [hTempCardIndex_ff98], a
	call AddCardToHand
	farcall IsPlayerTurn
	jr nc, .next
	; show card to player
	push bc
	bank1call DisplayPlayerDrawCardScreen
	pop bc
.next
	dec c
	jr nz, .loop_draw
.no_more_cards
	ret

TextureMagic_ResistanceCheck:
	farcall CheckIfAttackingCardHasResistance
	ret

TextureMagic_AISelectEffect:
	; this is handled in AISelectSpecialAttackParameters
	ld a, $ff
	ldh [hTemp_ffa0], a
	ldh [hTempPlayAreaLocation_ffa1], a
	ret

TextureMagic_PlayerSelectEffect:
	; assume Defending card has no weakness
	ld a, $ff
	ldh [hTempPlayAreaLocation_ffa1], a
	farcall CheckIfDefendingCardHasWeakness
	jr nc, .has_weakness
	; no weakness, skip
	ldtx hl, CannotChangeWeaknessDueToNoWeaknessText
	call DrawWideTextBox_WaitForInput
	jr .handle_selection_of_resistance
.has_weakness
	farcall HandleConversion1PlayerSelection
	ldh a, [hTemp_ffa0]
	ldh [hTempPlayAreaLocation_ffa1], a
.handle_selection_of_resistance
	farcall HandleConversion2PlayerSelection
	ret

TextureMagic_ChangeWeaknessAndResistanceEffect:
	ldh a, [hTempPlayAreaLocation_ffa1]
	cp $ff
	jr z, .skip_change_weakness
	ldh a, [hTemp_ffa0]
	push af
	ldh a, [hTempPlayAreaLocation_ffa1]
	ldh [hTemp_ffa0], a
	farcall ChangeDefendingCardsWeakness
	call WaitForWideTextBoxInput
	pop af
	ldh [hTemp_ffa0], a
.skip_change_weakness
	farcall ChangeAttackingCardsResistance
	ret

CoolPorygon3DAttack_AIEffect:
	ld a, (20 * 3) / 2
	lb de, 0, 60
	farcall SetExpectedAIDamage
	ret

CoolPorygon3DAttack_MultiplierEffect:
	ld hl, 20
	call LoadTxRam3
	ldtx de, DamageCheckXDamageTimesHeadsText
	ld a, 3
	farcall TossCoinATimes_Bank1a
	add a ; *2
	call ATimes10
	farcall SetDefiniteDamage
	ret

Eat_CountersCheck:
	ld a, DUELVARS_ARENA_CARD_FOOD_COUNTERS
	get_turn_duelist_var
	ldtx hl, CannotUseSinceItAlreadyHas2FoodCountersText
	cp 2
	ccf
	; carry set if food counters >= 2
	ret

Eat_AddFoodCounterEffect:
	; increment num of food counters
	ld a, DUELVARS_ARENA_CARD_FOOD_COUNTERS
	get_turn_duelist_var
	inc [hl]
	ld l, [hl]
	ld h, $00
	call LoadTxRam3
	ldtx hl, Put1FoodCounterCurrentNumberText
	call DrawWideTextBox_PrintText
	bank1call DrawDuelHUDs
	ret

Rollout_AIEffect:
	ldh a, [hTempPlayAreaLocation_ff9d]
	add DUELVARS_ARENA_CARD_FOOD_COUNTERS
	get_turn_duelist_var
	ld e, a
	add a
	add e
	call ATimes10 ; *30
	add 20
	ld [wAIMaxDamage], a
	xor a
	ld [wDamage + 1], a
	ld a, 20
	ld [wDamage], a
	ld [wAIMinDamage], a
	ret

Rollout_AISelectEffect:
	; this is handled in AISelectSpecialAttackParameters
	xor a
	ldh [hTemp_ffa0], a
	ret

Rollout_PlayerSelectEffect:
	ld a, DUELVARS_ARENA_CARD_FOOD_COUNTERS
	get_turn_duelist_var
	ldh [hTemp_ffa0], a
	or a
	ret z ; has 0 counters, nothing to do
	inc a
	ldh [hCurSelectionItem], a

	; prepare to show selection screen
	call EmptyScreen
	lb de, 0, 0
	lb bc, 20, 13
	call DrawRegularTextBox
	ldtx hl, ChooseHowManyFoodCountersToRemoveText
	call DrawWideTextBox_PrintText

	; draw the different choices of 
	; number of food counters to remove (0, 1, 2)
	; in a vertical list
	ldh a, [hCurSelectionItem]
	ld c, a
	lb de, 2, 2
	ld b, SYM_0
.loop_draw_digits
	push bc
	ld a, b ; digit symbol
	ld c, e ; y
	ld b, d ; x
	call WriteByteToBGMap0
	; print "counters" text
	push de
	inc d ; x += 1
	ldtx hl, EffectTargetGeneralUnitText
	call InitTextPrinting_ProcessTextFromID
	pop de
	pop bc
	inc e ; y += 1
	inc b ; next digit
	dec c
	jr nz, .loop_draw_digits

	call EnableLCD
	ld hl, RolloutMenuParameters
	xor a
	call InitializeMenuParameters
	ldh a, [hCurSelectionItem]
	ld [wNumScrollMenuItems], a
.loop_input
	call DoFrame
	call HandleMenuInput
	jr nc, .loop_input
	cp $ff
	jr z, .cancelled
	; got choice
	ldh [hTemp_ffa0], a
	or a
	ret
.cancelled
	scf
	ret

Rollout_RemoveCountersAndDamageBoostEffect:
	; decrease num food counters selected
	ldh a, [hTemp_ffa0]
	ld e, a
	ld a, DUELVARS_ARENA_CARD_FOOD_COUNTERS
	get_turn_duelist_var
	sub e
	ld [hl], a

	; add num chosen * 30 to damage
	ld a, e
	add a
	add e
	call ATimes10
	farcall AddToDamage
	ret

RolloutMenuParameters:
	db 1, 2 ; cursor x, cursor y
	db 1 ; y displacement between items
	db 6 ; number of items
	db SYM_CURSOR_R ; cursor tile number
	db SYM_SPACE ; tile behind cursor
	dw NULL ; function pointer if non-0

	ret ; stray ret

EnergyControl_EnergyCheck:
	farcall Func_6808d

	; run through all cards on non-turn holder's side
	; and return carry if none of them have basic energy cards attached
	call SwapTurn
	ld b, PLAY_AREA_ARENA - 1
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
.loop_play_area
	inc b
	ld a, [hli]
	cp $ff
	jr z, .none_found
	push hl
	push bc
	farcall CreateListOfBasicEnergyCardsAttachedToPlayAreaCard
	pop bc
	pop hl
	jr c, .loop_play_area
	; found at least 1 basic card attached
.done
	call SwapTurn
	ret
.none_found
	ldtx hl, NoBasicEnergyAttachedToPokemonInOppPlayAreaText
	scf
	jr .done

EnergyControl_AISelectEffect:
	; this is handled in AISelectSpecialAttackParameters
	xor a
	ldh [hTemp_ffa0], a
	ret

EnergyControl_PlayerSelectEffect:
	ldtx de, AttackSuccessCheckText
	farcall Serial_TossCoin
	ldh [hTemp_ffa0], a
	jr c, .successful
; unsuccessful
	farcall SetWasUnsuccessful
	ret

.successful
	ldtx hl, ChoosePokemonToRemoveEnergyFromText
	call DrawWideTextBox_WaitForInput

	; choose a Play Area card
	call SwapTurn
.start_selection
	bank1call HasAlivePokemonInPlayArea
.select_play_area_1
	bank1call OpenPlayAreaScreenForSelection
	jr c, .select_play_area_1 ; mandatory selection
	ldh a, [hTempPlayAreaLocation_ff9d]
	ld b, a
	farcall CreateListOfBasicEnergyCardsAttachedToPlayAreaCard
	jr c, .select_play_area_1 ; no energy cards
	; has basic energy cards, select energy card
	ldh a, [hTempPlayAreaLocation_ff9d]
	ldh [hTempPlayAreaLocation_ffa1], a
	ld e, a
	bank1call DisplayEnergyDiscardMenu
	bank1call HandleAttachedEnergyMenuInput
	jr c, .start_selection
	ldh a, [hTempCardIndex_ff98]
	ldh [hTempRetreatCostCards], a

	; got selection of donor of energy card,
	; now select receiver of this energy
	ldtx hl, ChoosePokemonToAttachEnergyToText
	call DrawWideTextBox_WaitForInput
	bank1call HasAlivePokemonInPlayArea
.select_play_area_2
	bank1call OpenPlayAreaScreenForSelection
	jr c, .select_play_area_2 ; mandatory selection
	ldh a, [hTempPlayAreaLocation_ff9d]
	ldh [hAIEnergyTransPlayAreaLocation], a
	call SwapTurn
	ret

EnergyControl_SwitchEnergyEffect:
	ldh a, [hTemp_ffa0]
	or a
	ret z ; none chosen

	call SwapTurn
	ldh a, [hTempPlayAreaLocation_ffa1]
	ld e, a
	bank1call HandlePlayAreaCardNoDamageOrEffect
	jr c, .done
	ldh a, [hAIEnergyTransPlayAreaLocation]
	ld e, a
	bank1call HandlePlayAreaCardNoDamageOrEffect
	jr c, .done
	ldh a, [hAIEnergyTransPlayAreaLocation]
	ld e, a
	ldh a, [hTempRetreatCostCards]
	call AddCardToHand
	call PutHandCardInPlayArea
	ldh a, [hTempPlayAreaLocation_ffa1]
	or a
	jr nz, .done
	ld a, DUELVARS_ARENA_CARD_LAST_TURN_EFFECT
	get_turn_duelist_var
	ld [hl], LAST_TURN_EFFECT_DISCARD_ENERGY
.done
	call SwapTurn
	ret

Telekinesis_UnaffectedByWREffect:
	ld a, 30
	farcall SetDefiniteDamageAndSetUnaffectedByWR
	ret

Telekinesis_PlayerSelectEffect:
	farcall HandlePlayerSelectOppPlayAreaPkmn
	ret

Telekinesis_AISelectEffect:
	farcall AIFindTargetForPlayAreaAttack
	ldh [hTemp_ffa0], a
	ret

Telekinesis_ArenaDamageEffect:
	ldh a, [hTemp_ffa0]
	or a
	jr nz, .bench
; arena
	farcall PreparePlayAreaAttackAgainstArena
	ret c
	ld a, 30
	farcall SetDefiniteDamageAndSetUnaffectedByWR
	ret
.bench
	xor a ; ATK_ANIM_NONE
	ld [wLoadedAttackAnimation], a
	ret

Telekinesis_BenchDamageEffect:
	ldh a, [hTemp_ffa0]
	or a
	ret z ; arena

	; damage bench card
	call SwapTurn
	ld b, a
	ld a, ATK_ANIM_TELEKINESIS_BENCH
	ld [wLoadedAttackAnimation], a
	ld de, 30
	call DealDamageToPlayAreaPokemon
	call SwapTurn
	ret

Recharge_DeckCheck:
	farcall CheckIfDeckIsEmpty
	ret

Recharge_PlayerSelectEffect:
	call CreateDeckCardList
	ldtx hl, ChooseALightningEnergyFromDeckText
	ldtx bc, EffectTargetLightningEnergyText
	ld a, CARDSEARCH_LIGHTNING_ENERGY
	farcall LookForCardsInDeck
	jr c, .got_selection
	ldtx hl, ChooseALightningEnergyText
	ldtx de, DuelistDeckText
	farcall SelectCardSearchTarget
.got_selection
	ldh [hTemp_ffa0], a
	ret

Recharge_AISelectEffect:
	ld a, CARDSEARCH_LIGHTNING_ENERGY
	farcall SetCardSearchFuncParams
	call CreateDeckCardList
	ld hl, wDuelTempList
.loop
	ld a, [hli]
	ldh [hTemp_ffa0], a
	cp $ff
	ret z
	farcall ExecuteCardSearchFunc
	jr nc, .loop
	ret

Recharge_AttachFromDeckEffect:
	ldh a, [hTemp_ffa0]
	cp $ff
	jr z, .finish
	; attach it from the deck
	call SearchCardInDeckAndAddToHand
	get_turn_duelist_var
	ld [hl], CARD_LOCATION_ARENA
.finish
	farcall ShuffleCardsInDeck
	ret

PikachuThunderboltEffect:
	xor a ; PLAY_AREA_ARENA
	call CreateArenaOrBenchEnergyCardList
	ld hl, wDuelTempList
.loop_discard
	ld a, [hli]
	cp $ff
	ret z
	call DiscardCard
	jr .loop_discard

; unreferenced
Func_663e2:
	ld a, 30 / 2
	lb de, 0, 30
	farcall SetExpectedAIDamage
	ret

; return carry if already used attack in this duel
FarfetchdAltLeekSlap_OncePerDuelCheck:
; can only use attack if it was never used before this duel
	ld a, DUELVARS_ARENA_CARD_FLAGS
	get_turn_duelist_var
	and USED_LEEK_SLAP_THIS_DUEL
	ret z
	ldtx hl, CannotBeUsedTwiceText
	scf
	ret

FarfetchdAltLeekSlap_SetUsedThisDuelFlag:
	ld a, DUELVARS_ARENA_CARD_FLAGS
	get_turn_duelist_var
	set USED_LEEK_SLAP_THIS_DUEL_F, [hl]
	ret

FarfetchdAltLeekSlap_NoDamage50PercentEffect:
	ldtx de, DamageCheckIfTailsNoDamageText
	farcall TossCoin_Bank1a
	ret c
	xor a ; 0 damage
	farcall SetDefiniteDamage
	ret

DizzyPunch_AIEffect:
	ld a, (10 * 2) / 2
	lb de, 0, 20
	farcall SetExpectedAIDamage
	ret

DizzyPunch_MultiplierEffect:
	ld hl, 10
	call LoadTxRam3
	ldtx de, DamageCheckXDamageTimesHeadsText
	ld a, 2
	farcall TossCoinATimes_Bank1a
	call ATimes10
	farcall SetDefiniteDamage
	ret

TripOver_AIEffect:
	ld a, (20 + 30) / 2
	lb de, 20, 30
	farcall SetExpectedAIDamage
	ret

TripOver_DamageBoost50PercentEffect:
	ld a, 10
	farcall AddDamageIfHeads
	ret

GoUndergroundEffect:
	scf
	ret

EarthWave_PlayerSelectEffect:
	farcall CheckNonTurnDuelistHasBench
	jr nc, .has_bench
	ld a, $ff
	ldh [hTempList], a
	ret

.has_bench
	call SwapTurn
	ldtx hl, ChooseUpTo2BenchedPokemonToGiveDamageText
	call DrawWideTextBox_WaitForInput

; init number of items in list and cursor position
	xor a
	ldh [hCurSelectionItem], a
	ld [wCurGigashockItem], a
	bank1call SetupPlayAreaScreen
.start
	bank1call PrintPlayAreaCardList_EnableLCD
	push af
	ld a, [wCurGigashockItem]
	ld hl, EarthPowerMenuParameters
	call InitializeMenuParameters
	pop af

; exclude Arena Pokemon from number of items
	dec a
	ld [wNumScrollMenuItems], a
.loop_input
	call DoFrame
	call HandleMenuInput
	ld a, e
	ld [wCurGigashockItem], a
	jr nc, .loop_input
	ldh a, [hCurScrollMenuItem]
	cp -1
	jr z, .try_cancel

	call .CheckIfChosenAlready
	jr nc, .asm_6648a
	; play SFX
	call PlaySFX_InvalidChoice
	jr .loop_input

.asm_6648a
; mark this Play Area location
	ldh a, [hCurScrollMenuItem]
	inc a
	ld b, SYM_FIGHTING
	farcall DrawSymbolOnPlayAreaCursor
; store it in the list of chosen Bench Pokemon
	farcall GetNextPositionInTempList
	ldh a, [hCurScrollMenuItem]
	inc a
	ld [hl], a

; check if 3 were chosen already
	ldh a, [hCurSelectionItem]
	ld c, a
	cp 2
	jr nc, .chosen ; check if already chose 2

	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	dec a
	cp c
	jr nz, .start ; if still more options available, loop back
	; fallthrough if no other options available to choose

.chosen
	ldh a, [hCurScrollMenuItem]
	inc a
	farcall DrawPlayAreaScreenToShowChanges
	ldh a, [hKeysPressed]
	and PAD_B
	jr nz, .try_cancel
	call SwapTurn
	farcall GetNextPositionInTempList
	ld [hl], $ff ; terminating byte
	ret

.try_cancel
	ldh a, [hCurSelectionItem]
	or a
	jr z, .start ; none selected, can safely loop back to start

; undo last selection made
	dec a
	ldh [hCurSelectionItem], a
	ld e, a
	ld d, $00
	ld hl, hTempList
	add hl, de
	ld a, [hl]

	push af
	ld b, SYM_SPACE
	farcall DrawSymbolOnPlayAreaCursor
	call EraseCursor
	pop af

	dec a
	ld [wCurGigashockItem], a
	jp .start

; returns carry if Bench Pokemon
; in register a was already chosen.
.CheckIfChosenAlready:
	inc a
	ld c, a
	ldh a, [hCurSelectionItem]
	ld b, a
	ld hl, hTempList
	inc b
	jr .next_check
.check_chosen
	ld a, [hli]
	cp c
	scf
	ret z ; return if chosen already
.next_check
	dec b
	jr nz, .check_chosen
	or a
	ret

EarthWave_AISelectEffect:
; if Bench has 2 Pokemon or less, no need for selection,
; since AI will choose them all.
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	call GetNonTurnDuelistVariable
	cp 1 + 2 ; should be 1 + 3
	jr nc, .start_selection

; select them all
	ld hl, hTempList
	ld b, PLAY_AREA_ARENA
	jr .next_bench
.select_bench
	ld [hl], b
	inc hl
.next_bench
	inc b
	dec a
	jr nz, .select_bench
	ld [hl], $ff ; terminating byte
	ret

.start_selection
; has more than 3 Bench cards, proceed to sort them
; by lowest remaining HP to highest, and pick first 3.
	call SwapTurn
	dec a
	ld c, a
	ld b, PLAY_AREA_BENCH_1

; first select all of the Bench Pokemon and write to list
	ld hl, hTempList
.loop_all
	ld [hl], b
	inc hl
	inc b
	dec c
	jr nz, .loop_all
	ld [hl], $00 ; end list with $00

; then check each of the Bench Pokemon HP
; sort them from lowest remaining HP to highest.
	ld de, hTempList
.loop_outer
	ld a, [de]
	add DUELVARS_ARENA_CARD_HP
	get_turn_duelist_var
	ld c, a
	ld l, e
	ld h, d
	inc hl

.loop_inner
	ld a, [hli]
	or a
	jr z, .next ; reaching $00 means it's end of list

	push hl
	add DUELVARS_ARENA_CARD_HP
	get_turn_duelist_var
	pop hl
	cp c
	jr c, .loop_inner
	; a Bench Pokemon was found with less HP
	ld c, a ; store its HP

; switch the two
	dec hl
	ld b, [hl]
	ld a, [de]
	ld [hli], a
	ld a, b
	ld [de], a
	jr .loop_inner

.next
	inc de
	ld a, [de]
	or a
	jr nz, .loop_outer

; done
	ld a, $ff ; terminating byte
	ldh [hTempList + 2], a
	call SwapTurn
	ret

EarthWave_BenchDamageEffect:
	call SwapTurn
	ld hl, hTempList
.loop_selection
	ld a, [hli]
	cp $ff
	jr z, .done
	push hl
	ld b, a
	ld de, 10
	call DealDamageToPlayAreaPokemon_RegularAnim
	pop hl
	jr .loop_selection
.done
	call SwapTurn
	ret

EarthPowerMenuParameters:
	db 0, 3 ; cursor x, cursor y
	db 3 ; y displacement between items
	db MAX_PLAY_AREA_POKEMON ; number of items
	db SYM_CURSOR_R ; cursor tile number
	db SYM_SPACE ; tile behind cursor
	dw NULL ; function pointer if non-0

SpecialDelivery_UseAndDeckCheck:
	farcall CheckIfCanUsePkmnPowerThisTurn
	ret c
	farcall CheckIfDeckIsEmpty
	ret

SpecialDelivery_PlayerSelectEffect:
	; draw a card (temporarily)
	call DrawCardFromDeck
	ldh [hTempRetreatCostCards], a
	ldh [hTempCardIndex_ff98], a
	call AddCardToHand
	bank1call DisplayPlayerDrawCardScreen

	; select a card from hand to place on top of deck
	ldtx hl, ChooseCardToReturnToTopDeckText
	call DrawWideTextBox_WaitForInput
	call CreateHandCardList
	bank1call InitAndDrawCardListScreenLayout_WithSelectCheckMenu
.select_card
	bank1call DisplayCardList
	jr c, .select_card ; mandatory selection
	ldh [hTempPlayAreaLocation_ffa1], a

	; return drawn card back to deck, it will be drawn in next step
	ldh a, [hTempRetreatCostCards]
	call RemoveCardFromHand
	call ReturnCardToDeck
	or a
	ret

SpecialDelivery_DrawAndPlaceInDeckEffect:
	farcall SetUsedPkmnPowerThisTurnFlag

	; actually draw card
	call DrawCardFromDeck
	call AddCardToHand

	; return selected card to deck
	ldh a, [hTempPlayAreaLocation_ffa1]
	call RemoveCardFromHand
	call ReturnCardToDeck
	ret

SupersonicFlight_AIEffect:
	ld a, 60
	lb de, 0, 60
	farcall SetExpectedAIDamage
	ret

SupersonicFlight_NoDamage50PercentEffect:
	ldtx de, AttackSuccessCheckText
	farcall TossCoin_Bank1a
	ret c ; got heads
	xor a ; ATK_ANIM_NONE
	ld [wLoadedAttackAnimation], a
	farcall SetDefiniteDamage
	farcall SetWasUnsuccessful
	ret

Trickle_AIEffect:
	ld a, (10 * 2) / 2
	lb de, 0, 20
	farcall SetExpectedAIDamage
	ret

Trickle_MultiplierEffect:
	ld hl, 10
	call LoadTxRam3
	ldtx de, DamageCheckXDamageTimesHeadsText
	ld a, 2
	farcall TossCoinATimes_Bank1a
	call ATimes10
	farcall SetDefiniteDamage
	ret

DragonRage_AIEffect:
	ld a, 50
	lb de, 0, 50
	farcall SetExpectedAIDamage
	ret

DragonRage_NoDamage75PercentEffect:
	ldtx de, FailIfEitherOf2CoinsIsTailsText
	ld a, 2
	farcall TossCoinATimes_Bank1a
	cp 2
	ret z ; got 2 heads
	xor a ; ATK_ANIM_NONE
	ld [wLoadedAttackAnimation], a
	farcall SetDefiniteDamage
	farcall SetWasUnsuccessful
	ret

TogepiSnivelEffect:
	ld a, SUBSTATUS2_REDUCE_BY_20
	farcall ApplySubstatus2ToDefendingCard
	ret

MiniMetronome_CheckAttacks:
	farcall Func_6808d
	farcall CheckIfDefendingCardHasAnyAttacks
	ret c ; no attacks selectable
	ld a, [wMiniMetronomeCoinTossResult]
	or a
	ret nz ; got heads in coin toss
	ldtx hl, UnableToSelectText
	scf
	ret

MiniMetronome_AISelectEffect:
	call GetMiniMetronomeCoinTossResult
	jr c, MiniMetronomeUnsuccessful
	farcall HandleAIMetronomeEffect
	ret

MiniMetronome_UseAttackEffect:
	call GetMiniMetronomeCoinTossResult
	jr c, MiniMetronomeUnsuccessful
	ld a, 2
	farcall HandlePlayerMetronomeEffect
	ld a, [wcd16]
	or a
	jr z, MiniMetronomeUnsuccessful
	scf
	ret
MiniMetronomeUnsuccessful:
	or a
	ret

; tosses coin to see if Mini-Metronome is successful
; returns carry if result was tails
GetMiniMetronomeCoinTossResult:
	ld a, [wMiniMetronomeCoinTossResult]
	cp 1
	jr nz, .toss_coin
	; coin toss already yielded heads
	or a
	ret
.toss_coin
	ldtx de, AttackSuccessCheckText
	farcall Serial_TossCoin
	ld [wMiniMetronomeCoinTossResult], a
	ccf
	ret nc ; got heads
	; got tails, unsuccessful
	xor a ; ATK_ANIM_NONE
	ld [wLoadedAttackAnimation], a
	farcall SetWasUnsuccessful
	scf
	ret

MarillWaterGunEffect:
	lb bc, 2, 0
	farcall ApplyExtraWaterEnergy10DamageBonus
	ret

MankeyAltPeek_OncePerTurnCheck:
	farcall CheckIfCanUsePkmnPowerThisTurn
	ret

MankeyAltPeek_SelectEffect:
	farcall MankeyPeek_SelectEffect
	ret

IvysaurLeechSeedEffect:
	ld hl, wDealtDamage
	ld a, [hli]
	or [hl]
	ret z ; no damage dealt
	ld de, 10
	farcall ApplyAndAnimateHPRecovery
	ret

RaichuQuickAttack_AIEffect:
	ld a, (10 + 30) / 2
	lb de, 10, 30
	farcall SetExpectedAIDamage
	ret

RaichuQuickAttack_DamageBoostEffect:
	ld a, 20
	farcall AddDamageIfHeads
	ret

RaichuThunderboltEffect:
	xor a ; PLAY_AREA_ARENA
	call CreateArenaOrBenchEnergyCardList
	ld hl, wDuelTempList
.loop_discard
	ld a, [hli]
	cp $ff
	ret z
	call DiscardCard
	jr .loop_discard

JynxDoubleSlap_AIEffect:
	ld a, (20 * 2) / 2
	lb de, 0, 40
	farcall SetExpectedAIDamage
	ret

JynxDoubleSlap_MultiplierEffect:
	ld hl, 20
	call LoadTxRam3
	ldtx de, DamageCheckXDamageTimesHeadsText
	ld a, 2
	farcall TossCoinATimes_Bank1a
	add a ; *2
	call ATimes10
	farcall SetDefiniteDamage
	ret

MeowthFurySwipes_AIEffect:
	ld a, 20 ; bug, should be (10 * 3) / 2
	lb de, 0, 40 ; bug, should be 30
	farcall SetExpectedAIDamage
	ret

MeowthFurySwipes_MultiplierEffect:
	ld hl, 10
	call LoadTxRam3
	ldtx de, DamageCheckXDamageTimesHeadsText
	ld a, 3
	farcall TossCoinATimes_Bank1a
	call ATimes10
	farcall SetDefiniteDamage
	ret

GrowlitheLunge_AIEffect:
	ld a, 20
	lb de, 0, 20
	farcall SetExpectedAIDamage
	ret

GrowlitheLunge_NoDamage50PercentEffect:
	ldtx de, AttackSuccessCheckText
	farcall TossCoin_Bank1a
	ret c ; was heads
	xor a ; ATK_ANIM_NONE
	ld [wLoadedAttackAnimation], a
	farcall SetDefiniteDamage
	farcall SetWasUnsuccessful
	ret

GrowlitheLv12Ember_CheckEnergy:
	farcall CheckIfArenaCardHasFireOrRainbowEnergy
	ret

GrowlitheLv12Ember_PlayerSelectEffect:
	farcall PlayerPickFireEnergyCardToDiscard
	ret

GrowlitheLv12Ember_AISelectEffect:
	farcall AIPickFireEnergyCardToDiscard
	ret

GrowlitheLv12Ember_DiscardEffect:
	ldh a, [hTemp_ffa0]
	call DiscardCard
	ret

ArcanineLv35TakeDownEffect:
	ld a, 20
	call DealRecoilDamageToSelf
	ret

SuperScoopUp_BenchCheck:
	farcall Func_6808d
	farcall CheckIfTurnDuelistHasBench
	ret

SuperScoopUp_PlayerSelection:
	; toss coin to check if successful
	ldtx de, TrainerCardSuccessCheckText
	farcall Serial_TossCoin
	ldh [hTemp_ffa0], a
	ret nc ; tails

; print text box
	ldtx hl, ChoosePokemonToReturnToHandText
	call DrawWideTextBox_WaitForInput

; handle Player selection
	bank1call HasAlivePokemonInPlayArea
.select_pkmn
	bank1call OpenPlayAreaScreenForSelection
	jr c, .select_pkmn ; mandatory selection

	ldh [hTempPlayAreaLocation_ffa1], a
	or a
	ret nz ; if it wasn't the Active Pokemon, we are done

; handle switching to a Pokemon in Bench and store location selected.
	call EmptyScreen
	ldtx hl, SelectPokemonToPlaceInTheArenaText
	call DrawWideTextBox_WaitForInput
	bank1call HasAlivePokemonInBench
	bank1call OpenPlayAreaScreenForSelection
	ldh [hTempRetreatCostCards], a
	ret

SuperScoopUp_ReturnToHandEffect:
	ldh a, [hTemp_ffa0]
	or a
	ret z ; got tails

; store chosen card location to Scoop Up
	ldh a, [hTempPlayAreaLocation_ffa1]
	add DUELVARS_ARENA_CARD
	get_turn_duelist_var
	ldh [hTempCardIndex_ff98], a
	ldh a, [hTempPlayAreaLocation_ffa1]
	or CARD_LOCATION_PLAY_AREA
	ld c, a

; find Basic Pokemon card that is in the selected Play Area location
; and add it and all cards attached to the hand
	ld a, DUELVARS_CARD_LOCATIONS
	get_turn_duelist_var
.loop
	ld a, [hl]
	cp c
	jr nz, .next_card ; skip if not in selected location
	ld a, l
	call AddCardToHand
.next_card
	inc l
	ld a, l
	cp DECK_SIZE
	jr c, .loop

; since the card has been moved to hand,
; DiscardPlayAreaCard will take care
; of discarding every higher stage cards and other cards attached.
	ldh a, [hTempPlayAreaLocation_ffa1]
	ld e, a
	call DiscardPlayAreaCard

; if card was not played by Player, show detail screen
; and print corresponding text.
	farcall IsPlayerTurn
	jr c, .player_turn
	ldtx hl, PokemonWasReturnedFromArenaToHandText
	ldh a, [hTempPlayAreaLocation_ffa1]
	or a
	jr z, .display_list
	ldtx hl, PokemonWasReturnedFromBenchToHandText
.display_list
	ldh a, [hTempCardIndex_ff98]
	bank1call DisplayCardDetailScreen

.player_turn
; if the Pokemon was in the Arena, clear status
	ldh a, [hTempPlayAreaLocation_ffa1]
	or a
	jr nz, .skip_clear_status
	call ClearAllStatusConditions
	ldh a, [hTempRetreatCostCards]
	ld d, a
	ld e, $00
	call SwapPlayAreaPokemon
.skip_clear_status
	call ShiftAllPokemonToFirstPlayAreaSlots
	ret

BillsTeleporterEffect:
	ldtx de, TrainerCardSuccessCheckText
	farcall TossCoin_Bank1a
	ret nc ; got tails

	; successful, remove Bill's Teleporter from hand
	ldh a, [hTempCardIndex_ff9f]
	call RemoveCardFromHand

	; draw 4 cards
	ld a, 4
	farcall DisplayDrawNCardsScreen
	ld c, 4
.loop_draw
	call DrawCardFromDeck
	jr c, .no_more_cards
	ldh [hTempCardIndex_ff98], a
	call AddCardToHand
	farcall IsPlayerTurn
	jr nc, .next
	push bc
	bank1call DisplayPlayerDrawCardScreen
	pop bc
.next
	dec c
	jr nz, .loop_draw
.no_more_cards
	ret

DarknessVeilEffect:
	scf
	ret

DarkSong_Sleep50PercentEffect:
	ldtx de, SleepInflictionCheckText
	farcall TossCoin_Bank1a
	ldh [hTemp_ffa0], a
	ret nc ; tails
	farcall SleepEffect
	ret

DarkSong_BenchDamageEffect:
	ldh a, [hTemp_ffa0]
	or a
	ret z ; got tails

	farcall CheckNonTurnDuelistHasBench
	ret c ; no bench

	; deal damage to all non-dark Bench pkmn
	dec a
	ld c, a ; num bench pkmn
	ld b, PLAY_AREA_BENCH_1
	call SwapTurn
	ld a, DUELVARS_BENCH
	get_turn_duelist_var
.loop
	ld a, [hli]
	push hl
	push bc
	call LoadCardDataToBuffer1_FromDeckIndex
	ld a, [wLoadedCard1Dark]
	or a
	jr nz, .is_dark
	ld de, 10
	bank1call ApplyDarkWaveDamageBoost
	call DealDamageToPlayAreaPokemon_RegularAnim
.is_dark
	pop bc
	pop hl
	inc b
	dec c
	jr nz, .loop
	call SwapTurn
	ret

Bother_Success50PercentEffect:
	ldtx de, BotherCheckText
	farcall TossCoin_Bank1a
	ldh [hTemp_ffa0], a
	ret

Bother_ReturnTrainerCardToDeckEffect:
	ldh a, [hTemp_ffa0]
	or a
	ret z ; got tails

	call SwapTurn
	call CreateHandCardList
	ldtx hl, NoCardsInOpponentsHandText
	jr c, .unsuccessful ; no hand cards
	call .FindTrainerCard
	ldtx hl, NoTrainerCardsInOppHandText
	jr c, .unsuccessful ; no Trainer cards

	; shuffle cards so that it picks a random Trainer card
	ld hl, wDuelTempList
	call CountCardsInDuelTempList
	call ShuffleCards
	call .FindTrainerCard
	push af
	call LoadCardDataToBuffer1_FromDeckIndex
	pop af

	; return this card to the deck
	call RemoveCardFromHand
	call ReturnCardToDeck

	; display card
	ldtx hl, PokemonWasReturnedToDeckText
	farcall _DisplayCardDetailScreen
	farcall ShuffleCardsInDeck
	call SwapTurn
	ret

.unsuccessful
	call SwapTurn
	call DrawWideTextBox_PrintText
	ret

; returns deck index of first Trainer card found in wDuelTempList
; if none found, return carry set
.FindTrainerCard:
	ld hl, wDuelTempList
.loop_find
	ld a, [hli]
	cp $ff
	scf
	ret z ; none found
	call GetCardIDFromDeckIndex
	call GetCardType
	cp TYPE_TRAINER
	jr nz, .loop_find
	; got Trainer card
	dec hl
	ld a, [hl]
	or a
	ret

PlayTricks_CheckBenchAndDamage:
	farcall CheckNonTurnDuelistHasBench
	ret c ; no bench
	call SwapTurn
	farcall CheckIfPlayAreaHasAnyDamage
	call SwapTurn
	ldtx hl, NoPokemonWithDamageCountersText
	ret c ; no damage counters in Play Area
	farcall CheckIfCanUsePkmnPowerThisTurn
	ret

PlayTricks_ShuffleDamageEffect:
	farcall SetUsedPkmnPowerThisTurnFlag

	call SwapTurn
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	ld [wCurGigashockItem], a ; num of pkmn in Play Area

	ld c, 30 ; number of iterations
.loop
	push bc
	; get random Play Area location
	ld a, [wCurGigashockItem]
	call Random
	ld [wTempPlayAreaLocation_cceb], a
	add DUELVARS_ARENA_CARD_HP
	get_turn_duelist_var
	; does it have enough HP to receive damage?
	cp 10 + 10
	jr c, .next_iteration ; not enough HP

	; has enough HP to receive damage
	; get another random Play Area location
	; (possibly the same as the first sampled pkmn)
	ld a, [wCurGigashockItem]
	call Random
	ld e, a

	; does it have any damage?
	call GetCardDamageAndMaxHP
	or a
	jr z, .next_iteration ; no damage

	; remove a counter from second sampled pkmn
	ld a, e
	add DUELVARS_ARENA_CARD_HP
	get_turn_duelist_var
	add 10
	ld [hl], a

	; add a counter from first sampled pkmn
	ld a, [wTempPlayAreaLocation_cceb]
	add DUELVARS_ARENA_CARD_HP
	get_turn_duelist_var
	sub 10
	ld [hl], a

.next_iteration
	pop bc
	dec c
	jr nz, .loop

	xor a
	farcall DrawPlayAreaScreenToShowChanges
	call SwapTurn
	ret

PushAside_Success50PercentEffect:
	; assume it is unsuccessful
	xor a ; ATK_ANIM_NONE
	ld [wLoadedAttackAnimation], a
	ldtx de, AttackSuccessCheckText
	farcall TossCoin_Bank1a
	ldh [hTemp_ffa0], a
	ret c ; got tails
	; set it as unsuccessful
	farcall SetWasUnsuccessful
	ret

PushAside_ReturnToDeckEffect:
	ldh a, [hTemp_ffa0]
	or a
	ret z ; got tails

	call SwapTurn
	; pick random Play Area pkmn
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	call Random
	ldh [hTempPlayAreaLocation_ffa1], a
	ldh [hTempPlayAreaLocation_ff9d], a

	; play animation
	ld a, ATK_ANIM_PUSH_ASIDE
	farcall PlayAttackAnimationOverAttackingPokemon

	ldh a, [hTempPlayAreaLocation_ffa1]
	ld e, a
	bank1call HandlePlayAreaCardNoDamageOrEffect
	call SwapTurn
	ret c ; unaffected

	ldh a, [hTempPlayAreaLocation_ffa1]
	ld e, a
	ld b, e
	ld a, e ; redundant load
	or CARD_LOCATION_PLAY_AREA
	ld c, a
	call SwapTurn
	ld a, DUELVARS_CARD_LOCATIONS
	get_turn_duelist_var
.loop_return_to_deck
	ld a, [hl]
	cp c
	jr nz, .next_card
	ld a, l
	call ReturnCardToDeck
.next_card
	inc l
	ld a, l
	cp DECK_SIZE
	jr c, .loop_return_to_deck

	; clear this Play Area slot
	ld a, b
	add DUELVARS_ARENA_CARD
	ld l, a
	ld a, [hl]
	ld [hl], $ff

	call LoadCardDataToBuffer1_FromDeckIndex

	; set HP to zero
	ld a, b
	add DUELVARS_ARENA_CARD_HP
	ld l, a
	ld [hl], 0

	; clear attached Defenders
	ld a, b
	add DUELVARS_ARENA_CARD_ATTACHED_DEFENDER
	ld l, a
	ld [hl], 0

	; load its name and show text
	ld hl, wLoadedCard1Name
	ld a, [hli]
	ld h, [hl]
	ld l, a
	call LoadTxRam2
	ldtx hl, PokemonAndAllAttachedCardsWereReturnedToDeckText
	call DrawWideTextBox_WaitForInput

	; finally, shuffle deck
	farcall ShuffleCardsInDeck
	call SwapTurn
	ret

Rebirth_UseCheck:
	ldh a, [hTempPlayAreaLocation_ff9d]
	ldh [hTemp_ffa0], a
	bank1call CheckIsIncapableOfUsingPkmnPower
	ret

Rebirth_DiscardAndAddStaryuEffect:
	call CreateDeckCardList
	jr c, .unsuccessful ; no deck cards

	ld hl, wDuelTempList
.loop_find_staryu
	ld a, [hli]
	ldh [hTempCardIndex_ff98], a
	cp $ff
	jr z, .unsuccessful ; no Staryu found in deck
	call GetCardIDFromDeckIndex
	cp16 STARYU_LV15
	jr z, .is_staryu
	cp16 STARYU_LV17
	jr nz, .loop_find_staryu

.is_staryu
	; discard Dark Starmie
	ldh a, [hTempPlayAreaLocation_ff9d]
	ld e, a
	call DiscardPlayAreaCard

	; increment Play Area pkmn
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	inc [hl]

	; add found Staryu card and add it to hand
	ldh a, [hTempCardIndex_ff98]
	call SearchCardInDeckAndAddToHand

	; replace card deck index
	ldh a, [hTempPlayAreaLocation_ff9d]
	add DUELVARS_ARENA_CARD
	get_turn_duelist_var
	ldh a, [hTempCardIndex_ff98]
	ld [hl], a
	ld l, a

	; set its location
	ldh a, [hTempPlayAreaLocation_ff9d]
	or CARD_LOCATION_PLAY_AREA
	ld [hl], a

	; set it as Basic Pokémon
	ldh a, [hTempPlayAreaLocation_ff9d]
	add DUELVARS_ARENA_CARD_STAGE
	ld l, a
	ld [hl], BASIC
	farcall ResetDevolvedCardStatus

	; restore all its HP
	ldh a, [hTempPlayAreaLocation_ff9d]
	ld e, a
	call GetCardDamageAndMaxHP
	ldh a, [hTempPlayAreaLocation_ff9d]
	add DUELVARS_ARENA_CARD_HP
	get_turn_duelist_var
	ld [hl], c
	ret

.unsuccessful
	farcall SetWasUnsuccessful
	call PrintFailedEffectText
	call WaitForWideTextBoxInput
	ret

SpinningShower_Success50PercentEffect:
	ldtx de, AttackSuccessCheckText
	farcall TossCoin_Bank1a
	ldh [hTemp_ffa0], a
	ret c ; heads
	xor a ; ATK_ANIM_NONE
	ld [wLoadedAttackAnimation], a
	ret

SpinningShower_AttackRandomPlayAreaCardsEffect:
	ldh a, [hTemp_ffa0]
	or a
	ret z ; got tails

	ld hl, wLoadedAttackCategory
	res RESIDUAL_F, [hl]
	farcall CheckNonTurnDuelistHasBench
	ld c, a ; num of Play Area cards
	ld b, a ; num of Play Area cards
	dec a
	jr z, .AttackPlayAreaCard ; no bench, attack Arena card

	; label each Play Area card (0, 1, 2, etc) 
	ld hl, wPlayAreaList
	push hl
	xor a
.loop_store_index
	ld [hli], a
	inc a
	dec c
	jr nz, .loop_store_index
	pop hl

	; shuffles this list, gets first entry and attacks it
	ld a, b
	call ShuffleCards
	ld a, [hl]
	call .AttackPlayAreaCard

	; 50% chance to pick next card in shuffled list
	; to attack it as well
	call UpdateRNGSources
	and 1
	ret z ; no second attack
	ld a, [wPlayAreaList + 1]
;	fallthrough
.AttackPlayAreaCard:
	call SwapTurn
	ld [wTempPlayAreaLocation_cceb], a
	ld b, a
	ld de, 20
	bank1call ApplyDarkWaveDamageBoostIfTargetIsBench
	call DealDamageToPlayAreaPokemon_RegularAnim
	call .DiscardRandomEnergy
	call SwapTurn
	ret

; this is used specifically with Mirror Move,
; the attack's target is forced to be Arena card
.DiscardRandomArenaCardEnergy:
	call SwapTurn
	xor a ; PLAY_AREA_ARENA
	ld [wTempPlayAreaLocation_cceb], a
	call .DiscardRandomEnergy
	call SwapTurn
	ret

.DiscardRandomEnergy:
	ld a, [wTempPlayAreaLocation_cceb]
	ld e, a
	bank1call HandlePlayAreaCardNoDamageOrEffect
	ret c ; unaffected
	ld a, [wTempPlayAreaLocation_cceb]
	call CreateArenaOrBenchEnergyCardList
	ret c ; no energy attached

	; shuffle energy card list and discard first entry
	ld hl, wDuelTempList
	call ShuffleCards
	ld a, [wDuelTempList]
	call DiscardCard

	ld a, [wTempPlayAreaLocation_cceb]
	or a
	ret nz ; was bench
	; if was Arena card, then set last turn effect
	ld a, DUELVARS_ARENA_CARD_LAST_TURN_EFFECT
	get_turn_duelist_var
	ld [hl], LAST_TURN_EFFECT_SPINNING_SHOWER
	ret

FlyHighEffect:
	ld a, SUBSTATUS1_NEXT_TURN_DOUBLE_DAMAGE
	farcall SetAttackDoubleOrTripleDamageNextTurn
	ret

DrillDive_CheckUse:
	ld a, SUBSTATUS1_USED_DRILL_DIVE
	farcall CheckIfHasSubstatusThatPreventsUsingAttack
	ret

DrillDive_CannotUseNextTurnEffect:
	ld a, SUBSTATUS1_USED_DRILL_DIVE
	farcall ApplySubstatus1ToAttackingCardAndSetCountdown
	ret

SurpriseThunderEffect:
	farcall CheckNonTurnDuelistHasBench
	ret c ; no Bench
	; deal between 0 and 20 damage to all bench Pokémon
	ld a, 2 + 1
	call Random
	call ATimes10
	ld e, a
	ld d, $00
	call SwapTurn
	bank1call ApplyDarkWaveDamageBoost
	ld a, e
	farcall DealDamageToAllBenchedPokemon
	call SwapTurn
	ret

PerplexEffect:
	call SwapTurn
	ldtx de, PerplexCheckText
	farcall TossCoin_Bank1a
	call SwapTurn
	jr c, .unsuccessful
	ld a, DUELVARS_ARENA_CARD_SUBSTATUS3
	call GetNonTurnDuelistVariable
	set SUBSTATUS3_PERPLEX_F, [hl]
	ret
.unsuccessful
	xor a ; ATK_ANIM_NONE
	ld [wLoadedAttackAnimation], a
	ret

NineTails_AIEffect:
	ld a, (10 * 9) / 2
	lb de, 0, 90
	farcall SetExpectedAIDamage
	ret

NineTails_MulitplierEffect:
	ld hl, 10
	call LoadTxRam3
	ldtx de, DamageCheckXDamageTimesHeadsText
	ld a, 9
	farcall TossCoinATimes_Bank1a
	call ATimes10
	farcall SetDefiniteDamage
	ret

BoneHeadbuttEffect:
	farcall CheckNonTurnDuelistHasBench
	ret c ; no Bench
	call SwapTurn

	; choose random Bench Pokémon
	dec a
	call Random
	inc a
	ld b, a ; PLAY_AREA_BENCH_* location chosen

	; deal between 0 and 20 damage
	ld a, 2 + 1
	call Random
	call ATimes10
	ld e, a
	ld d, $00
	push bc
	bank1call ApplyDarkWaveDamageBoost
	call DealDamageToPlayAreaPokemon_RegularAnim
	pop bc

	ld a, [wNoDamageOrEffect]
	cp NO_DAMAGE_OR_EFFECT_AURORA_VEIL
	jr z, .unaffected ; was unaffected due to Aurora Veil

	; choose another random Bench Pokémon
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	dec a
	call Random
	inc a
	ld e, a
	bank1call HandlePlayAreaCardNoDamageOrEffect
	jr c, .unaffected
	call SwapArenaWithBenchPokemon
	ld a, e
	ld [wccef], a
	xor a
	ld [wccc5], a
.unaffected
	xor a
	ld [wDuelDisplayedScreen], a
	call SwapTurn
	ret

DarkWaveEffect:
	scf
	ret

DarkAmplification_AIEffect:
	call GetNumberOfDarkPokemonInTurnDuelistsPlayArea
	ret c ; none found
	; add (num of Dark Pokémon) * (20 / 2) to damage
	call ATimes10
	farcall AddToDamage
	ret

DarkAmplification_20Damage50PercentPerDarkPokemonEffect:
	call GetNumberOfDarkPokemonInTurnDuelistsPlayArea
	ret c ; none found
	ld hl, 20
	call LoadTxRam3
	ldtx de, DamageCheckPlusXDamageForEachHeadsText
	; toss coin number of times equal to Dark Pokémon
	ld a, b
	farcall TossCoinATimes_Bank1a
	; add 20 damage for each heads
	add a
	call ATimes10
	farcall AddToDamage
	ret

; counts number of Dark Pokémon in turn-holder's Play Area
; if no Bench, or if no Dark Pokémon found, return carry
GetNumberOfDarkPokemonInTurnDuelistsPlayArea:
	ld b, 0
	farcall CheckIfTurnDuelistHasBench
	ret c ; no bench
	ld c, a
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
.loop_play_area
	ld a, [hli]
	call LoadCardDataToBuffer1_FromDeckIndex
	ld a, [wLoadedCard1Dark]
	or a
	jr z, .next
	inc b
.next
	dec c
	jr nz, .loop_play_area
	ld a, b ; num Dark Pokémon found
	or a
	ret nz
	; none found
	scf
	ret

VinePullEffect:
	scf
	ret

FuryStrikesEffect:
	ld hl, wLoadedAttackCategory
	res RESIDUAL_F, [hl]
	call ClearPlayAreaList

	call SwapTurn

	; sample a random Play Area Pokémon 3 times
	; and for each sample increment corresponding entry in wPlayAreaList
	ld c, 3
.loop_sample
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	call Random
	ld e, a
	ld d, $00
	ld hl, wPlayAreaList
	add hl, de
	inc [hl]
	dec c
	jr nz, .loop_sample

	ld hl, wPlayAreaList
	ld b, PLAY_AREA_ARENA
	ld c, MAX_PLAY_AREA_POKEMON
.loop_list
	ld a, [hli]
	push hl
	push bc
	or a
	jr z, .next_entry
	; do value times 10 damage
	call ATimes10
	ld e, a
	ld d, 0

	; if dealing damage to Bench, don't forget
	; to add in the Dark Wave damage boost
	ld a, b
	or a
	jr z, .arena
	push bc
	bank1call ApplyDarkWaveDamageBoost
	pop bc

.arena
	call DealDamageToPlayAreaPokemon_RegularAnim

.next_entry
	pop bc
	pop hl
	inc b
	dec c
	jr nz, .loop_list
	call SwapTurn
	ret

HorridPollenEffect:
	farcall PoisonEffect

	; equal chance to inflict confusion, paralysis or sleep
	ld a, 3
	call Random
	dec a
	jr z, .confusion
	dec a
	jr z, .sleep
; paralysis
	farcall ParalysisEffect
	ret
.confusion
	farcall ConfusionEffect
	ret
.sleep
	farcall SleepEffect
	ret

Aeroblast_AIEffect:
	ld a, (20 * 2) / 2
	farcall AddToDamage
	ret

Aeroblast_DamageBoostEffect:
	ld hl, 20
	call LoadTxRam3
	ldtx de, DamageCheckPlusXDamageForEachHeadsText
	ld a, 2
	farcall TossCoinATimes_Bank1a
	add a
	call ATimes10
	farcall AddToDamage
	ret

CallShuffleCardsInDeck:
	farcall ShuffleCardsInDeck
	ret

CallIfIsPlayerTurn:
	farcall IsPlayerTurn
	ret

; returns carry if either there are no damage counters
; or no Energy cards attached in the Play Area.
SuperPotion_DamageEnergyCheck:
	farcall CheckIfPlayAreaHasAnyDamage
	ldtx hl, NoPokemonWithDamageCountersText
	ret c ; no damage counters
	call CheckIfThereAreAnyEnergyCardsAttached
	ldtx hl, NoEnergyCardsAttachedText
	ret

SuperPotion_PlayerSelectEffect:
	ldtx hl, ChoosePokemonToRemoveDamageCounterFromText_2
	call DrawWideTextBox_WaitForInput
.start
	bank1call HasAlivePokemonInPlayArea
.read_input
	bank1call OpenPlayAreaScreenForSelection
	ret c ; exit if B is pressed
	ld e, a
	call GetCardDamageAndMaxHP
	or a
	jr z, .read_input ; Pokemon has no damage?
	ldh a, [hCurScrollMenuItem]
	ld e, a
	call GetPlayAreaCardAttachedEnergies
	ld a, [wTotalAttachedEnergies]
	or a
	jr nz, .got_pkmn
	; no energy cards attached
	ldtx hl, NoEnergyCardsText
	call DrawWideTextBox_WaitForInput
	jr .start

.got_pkmn
; Pokemon has damage and Energy cards attached,
; prompt the Player for Energy selection to discard.
	ldh a, [hCurScrollMenuItem]
	bank1call CreateArenaOrBenchEnergyCardList
	ldh a, [hCurScrollMenuItem]
	bank1call DisplayEnergyDiscardMenu
	bank1call HandleAttachedEnergyMenuInput
	ret c ; exit if B was pressed

	ldh a, [hTempCardIndex_ff98]
	ldh [hTemp_ffa0], a
	ldh a, [hTempPlayAreaLocation_ff9d]
	ldh [hTempPlayAreaLocation_ffa1], a
	ld e, a

; cap the healing damage if
; it would make it exceed max HP.
	call GetCardDamageAndMaxHP
	ld c, 40
	cp 40
	jr nc, .heal
	ld c, a
.heal
	ld a, c
	ldh [hPlayAreaEffectTarget], a
	or a
	ret

SuperPotion_HealEffect:
	ldh a, [hTemp_ffa0]
	call DiscardCard
	ldh a, [hTempPlayAreaLocation_ffa1]
	ldh [hTempPlayAreaLocation_ff9d], a
	ldh a, [hTempRetreatCostCards]
	call HealPlayAreaPokemon
	ret

; checks if there is at least one Energy card
; attached to some card in the Turn Duelist's Play Area.
; return no carry if one is found,
; and returns carry set if none is found.
CheckIfThereAreAnyEnergyCardsAttached:
	ld a, DUELVARS_CARD_LOCATIONS
	get_turn_duelist_var
.loop_deck
	ld a, [hl]
	bit CARD_LOCATION_PLAY_AREA_F, a
	jr z, .next_card ; skip if not in Play Area
	ld a, l
	call LoadCardDataToBuffer2_FromDeckIndex
	ld a, [wLoadedCard2Type]
	cp TYPE_TRAINER
	jr z, .next_card ; skip if it's a Trainer card
	cp TYPE_ENERGY
	jr nc, .found
.next_card
	inc l
	ld a, l
	cp DECK_SIZE
	jr c, .loop_deck
	scf
	ret
.found
	or a
	ret

; handles Player selection for Pokemon in Play Area,
; then opens screen to choose one of the energy cards
; attached to that selected Pokemon.
; outputs the selection in:
;	[hTemp_ffa0] = play area location
;	[hTempPlayAreaLocation_ffa1] = index of energy card
HandlePokemonAndEnergySelectionScreen:
.start
	bank1call HasAlivePokemonInPlayArea
	bank1call OpenPlayAreaScreenForSelection
	ret c ; exit if B is pressed
	ld e, a
	call GetPlayAreaCardAttachedEnergies
	ld a, [wTotalAttachedEnergies]
	or a
	jr nz, .has_energy
	ldtx hl, NoEnergyCardsText
	call DrawWideTextBox_WaitForInput
	jr .start ; loop back to start

.has_energy
	ldh a, [hCurScrollMenuItem]
	bank1call CreateArenaOrBenchEnergyCardList
	ldh a, [hCurScrollMenuItem]
	bank1call DisplayEnergyDiscardMenu
	bank1call HandleAttachedEnergyMenuInput
	ldh a, [hTempPlayAreaLocation_ff9d]
	ldh [hTemp_ffa0], a
	ldh a, [hTempCardIndex_ff98]
	ldh [hTempPlayAreaLocation_ffa1], a
	ret

ImakuniEffect:
	; play animation, then return if Arena card is unaffected
	bank1call CheckIfArenaCardIsProtectedFromStatusCondition
	push af
	ld a, ATK_ANIM_OWN_CONFUSION
	call PlaySpecialAttackAnimation
	pop af
	jr nc, .success
	ldtx hl, ThereWasNoEffectText
	call DrawWideTextBox_WaitForInput
	ret
.success
	ld a, DUELVARS_ARENA_CARD_STATUS
	get_turn_duelist_var
	and PSN_DBLPSN
	or CONFUSED
	ld [hl], a
	bank1call DrawDuelHUDs
	ret

; returns carry if opponent has no energy cards attached
EnergyRemoval_EnergyCheck:
	call SwapTurn
	call CheckIfThereAreAnyEnergyCardsAttached
	ldtx hl, NoEnergyAttachedToPokemonInOppPlayAreaText
	call SwapTurn
	ret

EnergyRemoval_PlayerSelection:
	ldtx hl, ChoosePokemonAndRemoveEnergyText
	call DrawWideTextBox_WaitForInput
	call SwapTurn
	call HandlePokemonAndEnergySelectionScreen
	call SwapTurn
	ret

EnergyRemoval_AISelection:
	farcall _AIPickEnergyCardToDiscardFromDefendingPokemon
	ret

EnergyRemoval_DiscardEffect:
	call SwapTurn
	ldh a, [hTempPlayAreaLocation_ffa1]
	call DiscardCard
	call SwapTurn
	call CallIfIsPlayerTurn
	ret c

; show Player which Pokemon was affected
	call SwapTurn
	ldh a, [hTemp_ffa0]
	farcall DrawPlayAreaScreenToShowChanges
	call SwapTurn
	ret

; return carry if no other card in hand to discard
; or if there are no Basic Energy cards in Discard Pile.
EnergyRetrieval_HandEnergyCheck:
	ld a, DUELVARS_NUMBER_OF_CARDS_IN_HAND
	get_turn_duelist_var
	cp 2
	ldtx hl, NotEnoughCardsInHandText
	ret c ; return if doesn't have another card to discard
	farcall CreateEnergyCardListFromDiscardPile_OnlyBasic
	ldtx hl, NoBasicEnergyCardsInDiscardPileText
	ret

EnergyRetrieval_PlayerHandSelection:
	ldtx hl, ChooseCardFromHandToDiscardText
	call DrawWideTextBox_WaitForInput
	call CreateHandCardList
	ldh a, [hTempCardIndex_ff9f]
	call RemoveCardFromDuelTempList
	bank1call InitAndDrawCardListScreenLayout_WithSelectCheckMenu
	bank1call DisplayCardList
	ldh a, [hTempCardIndex_ff98]
	ldh [hTemp_ffa0], a
	ret

EnergyRetrieval_PlayerDiscardPileSelection:
	ld a, 1 ; start at 1 due to card selected from hand
	ldh [hCurSelectionItem], a
	ldtx hl, Choose2BasicEnergyCardsFromDiscardPileText
	call DrawWideTextBox_WaitForInput
	farcall CreateEnergyCardListFromDiscardPile_OnlyBasic

.select_card
	bank1call InitAndDrawCardListScreenLayout
	ldtx hl, PleaseSelectCardText
	ldtx de, DuelistDiscardPileText
	bank1call SetCardListHeaderAndInfoText
	bank1call DisplayCardList
	jr nc, .selected
	; B was pressed
	ld a, 2 + 1 ; includes the card selected from hand
	farcall AskWhetherToQuitSelectingCards
	jr c, .select_card ; player selected No
	jr .done

.selected
	farcall GetNextPositionInTempList
	ldh a, [hTempCardIndex_ff98]
	ld [hl], a
	call RemoveCardFromDuelTempList
	jr c, .done
	ldh a, [hCurSelectionItem]
	cp 2 + 1 ; includes the card selected from hand
	jr c, .select_card

.done
	farcall GetNextPositionInTempList
	ld [hl], $ff ; terminating byte
	or a
	ret

EnergyRetrieval_DiscardAndAddToHandEffect:
	ld hl, hTemp_ffa0
	ld a, [hli]
	call RemoveCardFromHand
	call PutCardInDiscardPile
	ld de, wDuelTempList
.loop
	ld a, [hli]
	ld [de], a
	inc de
	cp $ff
	jr z, .done
	call MoveDiscardPileCardToHand
	call AddCardToHand
	jr .loop
.done
	call CallIfIsPlayerTurn
	ret c
	bank1call DisplayCardListDetails
	ret

; return carry if no cards left in Deck.
EnergySearch_DeckCheck:
	ld a, DUELVARS_NUMBER_OF_CARDS_NOT_IN_DECK
	get_turn_duelist_var
	cp DECK_SIZE
	ccf
	ldtx hl, NoCardsLeftInTheDeckText
	ret

EnergySearch_PlayerSelection:
	call CreateDeckCardList
	ldtx hl, Choose1BasicEnergyCardFromDeckText
	ldtx bc, EffectTargetBasicEnergyText
	ld a, CARDSEARCH_BASIC_ENERGY
	farcall LookForCardsInDeck
	jr c, .got_selection
	ldtx hl, ChooseBasicEnergyCardText
	ldtx de, DuelistDeckText
	farcall SelectCardSearchTarget
.got_selection
	ldh [hTemp_ffa0], a
	ret

EnergySearch_AddToHandEffect:
	ldh a, [hTemp_ffa0]
	cp $ff
	jr z, .done
; add to hand
	call SearchCardInDeckAndAddToHand
	call AddCardToHand
	call CallIfIsPlayerTurn
	jr c, .done ; done if Player played card
; display card in screen
	ldh a, [hTemp_ffa0]
	ldtx hl, WasPlacedInTheHandText
	bank1call DisplayCardDetailScreen
.done
	call CallShuffleCardsInDeck
	ret

; remnant subroutine from TCG1,
; now we use CARDSEARCH_* constants together
; with LookForCardsInDeck to search for Basic Energy cards
UnreferencedCheckIfCardIsBasicEnergy:
	call LoadCardDataToBuffer2_FromDeckIndex
	ld a, [wLoadedCard2Type]
	cp TYPE_ENERGY
	jr c, .not_basic_energy
	cp TYPE_ENERGY_DOUBLE_COLORLESS
	jr nc, .not_basic_energy
; is basic energy
	or a
	ret
.not_basic_energy
	scf
	ret

ProfessorOakEffect:
; discard hand
	call CreateHandCardList
	bank1call SortCardsInDuelTempListByID
	ld hl, wDuelTempList
.discard_loop
	ld a, [hli]
	cp $ff
	jr z, .draw_cards
	call RemoveCardFromHand
	call PutCardInDiscardPile
	jr .discard_loop

.draw_cards
	ld a, 7
	farcall DisplayDrawNCardsScreen
	ld c, 7
.draw_loop
	call DrawCardFromDeck
	jr c, .done
	call AddCardToHand
	dec c
	jr nz, .draw_loop
.done
	ret

Potion_DamageCheck:
	farcall CheckIfPlayAreaHasAnyDamage
	ldtx hl, NoPokemonWithDamageCountersText
	ret

Potion_PlayerSelection:
	bank1call HasAlivePokemonInPlayArea
.read_input
	bank1call OpenPlayAreaScreenForSelection
	ret c ; exit is B was pressed
	ldh a, [hTempPlayAreaLocation_ff9d]
	ldh [hTemp_ffa0], a
	ld e, a
	call GetCardDamageAndMaxHP
	or a
	jr z, .read_input ; no damage, loop back to start
; cap damage
	ld c, 20
	cp 20
	jr nc, .skip_cap
	ld c, a
.skip_cap
	ld a, c
	ldh [hTempPlayAreaLocation_ffa1], a
	or a
	ret

Potion_HealEffect:
	ldh a, [hTemp_ffa0]
	ldh [hTempPlayAreaLocation_ff9d], a
	ldh a, [hTempPlayAreaLocation_ffa1]
	call HealPlayAreaPokemon
	ret

GamblerEffect:
	ldtx de, GamblerQuantityCheckText
	farcall TossCoin_Bank1a
	ldh [hTemp_ffa0], a
; discard Gambler card from hand
	ldh a, [hTempCardIndex_ff9f]
	call RemoveCardFromHand
	call PutCardInDiscardPile

; shuffle cards into deck
	call CreateHandCardList
	bank1call SortCardsInDuelTempListByID
	ld hl, wDuelTempList
.loop_return_deck
	ld a, [hli]
	cp $ff
	jr z, .check_coin_toss
	call RemoveCardFromHand
	call ReturnCardToDeck
	jr .loop_return_deck

.check_coin_toss
	call CallShuffleCardsInDeck
	ld c, 8
	ldh a, [hTemp_ffa0]
	or a
	jr nz, .draw_cards ; coin toss was heads?
	; if tails, number of cards to draw is 1
	ld c, 1

; correct number of cards to draw is in c
.draw_cards
	ld a, c
	farcall DisplayDrawNCardsScreen
.draw_loop
	call DrawCardFromDeck
	jr c, .done
	call AddCardToHand
	dec c
	jr nz, .draw_loop
.done
	ret

; return carry if not enough cards in hand to discard
; or if there are no cards in the Discard Pile
ItemFinder_HandDiscardPileCheck:
	ld a, DUELVARS_NUMBER_OF_CARDS_IN_HAND
	get_turn_duelist_var
	ldtx hl, NotEnoughCardsInHandText
	cp 3
	ret c
	farcall CreateTrainerCardListFromDiscardPile
	ret

ItemFinder_PlayerSelection:
	call HandlePlayerSelection2HandCardsToDiscard
	ret c ; was operation cancelled?

; cards were selected to discard from hand.
; now to choose a Trainer card from Discard Pile.
	farcall CreateTrainerCardListFromDiscardPile
	bank1call InitAndDrawCardListScreenLayout_WithSelectCheckMenu
	ldtx hl, ChooseCardToPlaceInHandText
	ldtx de, DuelistDiscardPileText
	bank1call SetCardListHeaderAndInfoText
	bank1call DisplayCardList
	ldh [hTempList + 2], a ; placed after the 2 cards selected to discard
	ret

ItemFinder_DiscardAddToHandEffect:
; discard cards from hand
	ld hl, hTempList
	ld a, [hli]
	call RemoveCardFromHand
	call PutCardInDiscardPile
	ld a, [hli]
	call RemoveCardFromHand
	call PutCardInDiscardPile

; place card from Discard Pile to hand
	ld a, [hl]
	call MoveDiscardPileCardToHand
	call AddCardToHand
	call CallIfIsPlayerTurn
	ret c
; display card in screen
	ldh a, [hTempList + 2]
	ldtx hl, WasPlacedInTheHandText
	bank1call DisplayCardDetailScreen
	ret

Defender_PlayerSelection:
	ldtx hl, ChoosePokemonToAttachDefenderToText
	call DrawWideTextBox_WaitForInput
	bank1call HasAlivePokemonInPlayArea
	bank1call OpenPlayAreaScreenForSelection
	ldh a, [hTempPlayAreaLocation_ff9d]
	ldh [hTemp_ffa0], a
	ret

Defender_AttachDefenderEffect:
; attach Trainer card to Play Area Pokemon
	ldh a, [hTemp_ffa0]
	ld e, a
	ldh a, [hTempCardIndex_ff9f]
	call PutHandCardInPlayArea

; increase number of Defender cards of this location by 1
	ldh a, [hTemp_ffa0]
	add DUELVARS_ARENA_CARD_ATTACHED_DEFENDER
	get_turn_duelist_var
	inc [hl]
	call CallIfIsPlayerTurn
	ret c

	ldh a, [hTemp_ffa0]
	farcall DrawPlayAreaScreenToShowChanges
	ret

MysteriousFossil_BenchCheck:
	farcall CheckIfHasSpaceInBench
	ret

MysteriousFossil_PlaceInPlayAreaEffect:
	ldh a, [hTempCardIndex_ff9f]
	call PutHandPokemonCardInPlayArea
	ret

; return carry if Arena card has no status to heal.
FullHeal_StatusCheck:
	ld a, DUELVARS_ARENA_CARD_STATUS
	get_turn_duelist_var
	or a
	ret nz
	ldtx hl, NotAffectedByStatusText
	scf
	ret

FullHeal_ClearStatusEffect:
	ld a, ATK_ANIM_FULL_HEAL
	call PlaySpecialAttackAnimation
	ld a, DUELVARS_ARENA_CARD_STATUS
	get_turn_duelist_var
	ld [hl], NO_STATUS
	bank1call DrawDuelHUDs
	ret

ImposterProfessorOakEffect:
	call SwapTurn
	call CreateHandCardList
	bank1call SortCardsInDuelTempListByID

; first return all cards in hand to the deck.
	ld hl, wDuelTempList
.loop_return_deck
	ld a, [hli]
	cp $ff
	jr z, .done_return
	call RemoveCardFromHand
	call ReturnCardToDeck
	jr .loop_return_deck

; then draw 7 cards from the deck.
.done_return
	call CallShuffleCardsInDeck
	ld a, 7
	farcall DisplayDrawNCardsScreen
	ld c, 7
.loop_draw
	call DrawCardFromDeck
	jr c, .done
	call AddCardToHand
	dec c
	jr nz, .loop_draw
.done
	call SwapTurn
	ret

; return carry if not enough cards in hand to discard
; or if there are no cards left in the deck.
ComputerSearch_HandDeckCheck:
	ld a, DUELVARS_NUMBER_OF_CARDS_IN_HAND
	get_turn_duelist_var
	ldtx hl, NotEnoughCardsInHandText
	cp 3
	ret c
	ld a, DUELVARS_NUMBER_OF_CARDS_NOT_IN_DECK
	get_turn_duelist_var
	ldtx hl, NoCardsLeftInTheDeckText
	cp DECK_SIZE
	ccf
	ret

ComputerSearch_PlayerDiscardHandSelection:
	call HandlePlayerSelection2HandCardsToDiscard
	ret

ComputerSearch_PlayerDeckSelection:
	call CreateDeckCardList
	bank1call InitAndDrawCardListScreenLayout_WithSelectCheckMenu
	ldtx hl, ChooseCardToPlaceInHandText
	ldtx de, DuelistDeckText
	bank1call SetCardListHeaderAndInfoText
.loop_input
	bank1call DisplayCardList
	jr c, .loop_input ; can't exit with B button
	ldh [hTempList + 2], a
	ret

ComputerSearch_DiscardAddToHandEffect:
; discard cards from hand
	ld hl, hTempList
	ld a, [hli]
	call RemoveCardFromHand
	call PutCardInDiscardPile
	ld a, [hli]
	call RemoveCardFromHand
	call PutCardInDiscardPile

; add card from deck to hand
	ld a, [hl]
	call SearchCardInDeckAndAddToHand
	call AddCardToHand
	call CallShuffleCardsInDeck
	ret

ClefairyDoll_BenchCheck:
	farcall CheckIfHasSpaceInBench
	ret

ClefairyDoll_PlaceInPlayAreaEffect:
	ldh a, [hTempCardIndex_ff9f]
	call PutHandPokemonCardInPlayArea
	ret

MrFuji_BenchCheck:
	farcall CheckIfTurnDuelistHasBench
	ret

MrFuji_PlayerSelection:
	ldtx hl, ChoosePokemonToReturnToTheDeckText
	call DrawWideTextBox_WaitForInput
	bank1call HasAlivePokemonInBench
	bank1call OpenPlayAreaScreenForSelection
	ldh a, [hTempPlayAreaLocation_ff9d]
	ldh [hTemp_ffa0], a
	ret

MrFuji_ReturnToDeckEffect:
; get Play Area location's card index
	ldh a, [hTemp_ffa0]
	add DUELVARS_ARENA_CARD
	get_turn_duelist_var
	ldh [hTempCardIndex_ff98], a

; find all cards that are in the same location
; (previous evolutions and energy cards attached)
; and return them all to the deck.
	ldh a, [hTemp_ffa0]
	or $10
	ld e, a
	ld a, DUELVARS_CARD_LOCATIONS
	get_turn_duelist_var
.loop_cards
	push de
	push hl
	ld a, [hl]
	cp e
	jr nz, .next_card
	ld a, l
	call ReturnCardToDeck
.next_card
	pop hl
	pop de
	inc l
	ld a, l
	cp DECK_SIZE
	jr c, .loop_cards

; clear Play Area location of card
	ldh a, [hTemp_ffa0]
	ld e, a
	call EmptyPlayAreaSlot
	ld l, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	dec [hl]
	call ShiftAllPokemonToFirstPlayAreaSlots

; if Trainer card wasn't played by the Player,
; print the selected Pokemon's name and show card on screen.
	call CallIfIsPlayerTurn
	jr c, .done
	ldh a, [hTempCardIndex_ff98]
	call LoadCardDataToBuffer1_FromDeckIndex
	ld hl, wLoadedCard1Name
	ld a, [hli]
	ld h, [hl]
	ld l, a
	call LoadTxRam2
	farcall DrawLargePictureOfCard
	ldtx hl, PokemonAndAllAttachedCardsWereReturnedToDeckText
	call DrawWideTextBox_WaitForInput
.done
	call CallShuffleCardsInDeck
	ret

PlusPowerEffect:
; attach Trainer card to Arena Pokemon
	ld e, PLAY_AREA_ARENA
	ldh a, [hTempCardIndex_ff9f]
	call PutHandCardInPlayArea

; increase number of Defender cards of this location by 1
	ld a, DUELVARS_ARENA_CARD_ATTACHED_PLUSPOWER
	get_turn_duelist_var
	inc [hl]
	ret

; return carry if no Pokemon in the Bench.
Switch_BenchCheck:
	farcall CheckIfTurnDuelistHasBench
	ret

Switch_PlayerSelection:
	ldtx hl, SelectBenchedPokemonToSwitchWithActiveText
	call DrawWideTextBox_WaitForInput
	bank1call HasAlivePokemonInBench
	bank1call OpenPlayAreaScreenForSelection
	ldh a, [hTempPlayAreaLocation_ff9d]
	ldh [hTemp_ffa0], a
	ret

Switch_SwitchEffect:
	ldh a, [hTemp_ffa0]
	ld e, a
	call SwapArenaWithBenchPokemon
	ret

PokemonCenter_DamageCheck:
	farcall CheckIfPlayAreaHasAnyDamage
	ldtx hl, NoPokemonWithDamageCountersText
	ret

PokemonCenter_HealDiscardEnergyEffect:
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	ld d, a
	ld e, PLAY_AREA_ARENA

; go through every Pokemon in the Play Area
; and heal all damage & discard their Energy cards.
.loop_play_area
; check its damage
	ld a, e
	ldh [hTempPlayAreaLocation_ff9d], a
	call GetCardDamageAndMaxHP
	or a
	jr z, .next_pkmn ; if no damage, skip Pokemon

; heal all its damage
	push de
	ld e, a
	ld d, $00
	call HealPlayAreaPokemon

; loop all cards in deck and for all the Energy cards
; that are attached to this Play Area location Pokemon,
; place them in the Discard Pile.
	ldh a, [hTempPlayAreaLocation_ff9d]
	or CARD_LOCATION_PLAY_AREA
	ld e, a
	ld a, DUELVARS_CARD_LOCATIONS
	get_turn_duelist_var
.loop_deck
	ld a, [hl]
	cp e
	jr nz, .next_card_deck ; not attached to card, skip
	ld a, l
	call LoadCardDataToBuffer2_FromDeckIndex
	ld a, [wLoadedCard2Type]
	and TYPE_ENERGY
	jr z, .next_card_deck ; not Energy, skip
	ld a, l
	call DiscardCard
.next_card_deck
	inc l
	ld a, l
	cp DECK_SIZE
	jr c, .loop_deck

	pop de
.next_pkmn
	inc e
	dec d
	jr nz, .loop_play_area
	ret

; return carry if non-Turn Duelist has full Bench,
; if they have no Basic Pokemon cards in Discard Pile,
; or if Black Hole special rule is active
PokemonFlute_BenchCheck:
	call SwapTurn
	bank1call IsBlackHoleRuleActive
	jr c, .got_result
	farcall CheckIfHasSpaceInBench
	jr c, .got_result
	farcall CreateBasicPkmnCardListFromDiscardPile
.got_result
	call SwapTurn
	ret

PokemonFlute_PlayerSelection:
; create Discard Pile list
	call SwapTurn
	farcall CreateBasicPkmnCardListFromDiscardPile

; display selection screen and store Player's selection
	bank1call InitAndDrawCardListScreenLayout_WithSelectCheckMenu
	ldtx hl, ChoosePokemonToPlaceInPlayText
	ldtx de, DuelistDiscardPileText
	bank1call SetCardListHeaderAndInfoText
	bank1call DisplayCardList
	call SwapTurn
	ldh a, [hTempCardIndex_ff98]
	ldh [hTemp_ffa0], a
	ret

PokemonFlute_PlaceInPlayAreaText:
; place selected card in non-Turn Duelist's Bench
	call SwapTurn
	ldh a, [hTemp_ffa0]
	call MoveDiscardPileCardToHand
	call AddCardToHand
	call PutHandPokemonCardInPlayArea
	call SwapTurn

; unless it was the Player who played the card,
; display the Pokemon card on screen.
	call CallIfIsPlayerTurn
	ret c
	call SwapTurn
	ldh a, [hTemp_ffa0]
	ldtx hl, CardWasChosenText
	bank1call DisplayCardDetailScreen
	call SwapTurn
	ret

PokemonBreeder_HandPlayAreaCheck:
	call CreatePlayableStage2PokemonCardListFromHand
	jr c, .cannot_evolve
	bank1call IsPrehistoricPowerActive
	ret
.cannot_evolve
	ldtx hl, ConditionsForEvolvingToStage2NotFulfilledText
	scf
	ret

PokemonBreeder_PlayerSelection:
; create hand list of playable Stage2 cards
	call CreatePlayableStage2PokemonCardListFromHand
	bank1call InitAndDrawCardListScreenLayout_WithSelectCheckMenu

; handle Player selection of Stage2 card
	ldtx hl, PleaseSelectCardText
	ldtx de, DuelistHandText
	bank1call SetCardListHeaderAndInfoText
	bank1call DisplayCardList
	ret c ; exit if B was pressed

	ldh a, [hTempCardIndex_ff98]
	ldh [hTemp_ffa0], a
	ldtx hl, ChooseBasicPokemonToEvolveText
	call DrawWideTextBox_WaitForInput

; handle Player selection of Basic card to evolve
	bank1call HasAlivePokemonInPlayArea
.read_input
	bank1call OpenPlayAreaScreenForSelection
	ret c ; exit if B was pressed
	ldh a, [hTempPlayAreaLocation_ff9d]
	ldh [hTempPlayAreaLocation_ffa1], a
	ld e, a
	ldh a, [hTemp_ffa0]
	ld d, a
	call CheckIfCanEvolveInto_BasicToStage2
	jr c, .read_input ; loop back if cannot evolve this card
	or a
	ret

PokemonBreeder_EvolveEffect:
	ldh a, [hTempCardIndex_ff9f]
	push af
	ld hl, hTemp_ffa0
	ld a, [hli]
	ldh [hTempCardIndex_ff98], a
	ld a, [hl] ; hTempPlayAreaLocation_ffa1
	ldh [hTempPlayAreaLocation_ff9d], a

; load the Basic Pokemon card name to RAM
	add DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call LoadCardDataToBuffer1_FromDeckIndex
	ld hl, wLoadedCard1Name
	ld a, [hli]
	ld h, [hl]
	ld l, a
	call LoadTxRam2

; evolve card and overwrite its stage as STAGE2_WITHOUT_STAGE1
	ldh a, [hTempCardIndex_ff98]
	call EvolvePokemonCard
	ld [hl], STAGE2_WITHOUT_STAGE1

; load Stage2 Pokemon card name to RAM
	ldh a, [hTempCardIndex_ff98]
	ld [wcd15], a
	call LoadCardDataToBuffer1_FromDeckIndex
	ld hl, wTxRam2_b
	ld a, [wLoadedCard1Name + 0]
	ld [hli], a
	ld a, [wLoadedCard1Name + 1]
	ld [hl], a

; display Pokemon picture and play sfx,
; print the corresponding card names.
	farcall DrawLargePictureOfCard
	ld a, SFX_POKEMON_EVOLUTION
	call PlaySFX
	ldtx hl, PokemonEvolvedIntoPokemonText
	call DrawWideTextBox_WaitForInput
	pop af
	ldh [hTempCardIndex_ff9f], a
	ret

; creates list in wDuelTempList of all Stage2 Pokemon cards
; in the hand that can evolve a Basic Pokemon card in Play Area
; through use of Pokemon Breeder.
; returns carry if that list is empty.
CreatePlayableStage2PokemonCardListFromHand:
	call CreateHandCardList
	ret c ; return if no hand cards

; check if hand Stage2 Pokemon cards can be made
; to evolve a Basic Pokemon in the Play Area and, if so,
; add it to the wDuelTempList.
	ld hl, wDuelTempList
	ld e, l
	ld d, h
.loop_hand
	ld a, [hl]
	cp $ff
	jr z, .done
	call .CheckIfCanEvolveAnyPlayAreaBasicCard
	jr c, .next_hand_card
	ld a, [hl]
	ld [de], a
	inc de
.next_hand_card
	inc hl
	jr .loop_hand
.done
	ld a, $ff ; terminating byte
	ld [de], a
	ld a, [wDuelTempList]
	cp $ff
	scf
	ret z ; return carry if empty
	; not empty
	or a
	ret

; return carry if Stage2 card in a cannot evolve any
; of the Basic Pokemon in Play Area through Pokemon Breeder.
.CheckIfCanEvolveAnyPlayAreaBasicCard:
	push de
	ld d, a
	call LoadCardDataToBuffer2_FromDeckIndex
	ld a, [wLoadedCard2Type]
	cp TYPE_ENERGY
	jr nc, .set_carry ; skip if not Pokemon card
	ld a, [wLoadedCard2Stage]
	cp STAGE2
	jr nz, .set_carry ; skip if not Stage2

; check if can evolve any Play Area cards
	push hl
	push bc
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	ld c, a
	ld e, PLAY_AREA_ARENA
.loop_play_area
	push bc
	push de
	call CheckIfCanEvolveInto_BasicToStage2
	pop de
	pop bc
	jr nc, .done_play_area
	inc e
	dec c
	jr nz, .loop_play_area
; set carry
	scf
.done_play_area
	pop bc
	pop hl
	pop de
	ret
.set_carry
	pop de
	scf
	ret

ScoopUp_BenchCheck:
	farcall CheckIfTurnDuelistHasBench
	ret

ScoopUp_PlayerSelection:
; print text box
	ldtx hl, ChoosePokemonToScoopUpText
	call DrawWideTextBox_WaitForInput

; handle Player selection
	bank1call HasAlivePokemonInPlayArea
	bank1call OpenPlayAreaScreenForSelection
	ret c ; exit if B was pressed

	ldh [hTemp_ffa0], a
	or a
	ret nz ; if it wasn't the Active Pokemon, we are done

; handle switching to a Pokemon in Bench and store location selected.
	call EmptyScreen
	ldtx hl, SelectPokemonToPlaceInTheArenaText
	call DrawWideTextBox_WaitForInput
	bank1call HasAlivePokemonInBench
	bank1call OpenPlayAreaScreenForSelection
	ldh [hTempPlayAreaLocation_ffa1], a
	ret

ScoopUp_ReturnToHandEffect:
; store chosen card location to Scoop Up
	ldh a, [hTemp_ffa0]
	or CARD_LOCATION_PLAY_AREA
	ld e, a

; find Basic Pokemon card that is in the selected Play Area location
; and add it to the hand, discarding all cards attached.
	ld a, DUELVARS_CARD_LOCATIONS
	get_turn_duelist_var
.loop
	ld a, [hl]
	cp e
	jr nz, .next_card ; skip if not in selected location
	ld a, l
	call LoadCardDataToBuffer2_FromDeckIndex
	ld a, [wLoadedCard2Type]
	cp TYPE_ENERGY
	jr nc, .discard ; discard if not Pokemon card
	ld a, [wLoadedCard2Stage]
	or a
	jr nz, .discard  ; discard if not Basic stage

	; add to hand if Basic card
	ld a, l
	ldh [hTempCardIndex_ff98], a
	call AddCardToHand
	jr .next_card

.discard
	ld a, l
	call PutCardInDiscardPile

.next_card
	inc l
	ld a, l
	cp DECK_SIZE
	jr c, .loop

	ldh a, [hTemp_ffa0]
	ld e, a
	call DiscardPlayAreaCard

; if the Pokemon was in the Arena, clear status
	ldh a, [hTemp_ffa0]
	or a
	jr nz, .skip_clear_status
	call ClearAllStatusConditions
.skip_clear_status

; if card was not played by Player, show detail screen
; and print corresponding text.
	call CallIfIsPlayerTurn
	jr c, .shift_or_switch
	ldtx hl, PokemonWasReturnedFromArenaToHandText
	ldh a, [hTemp_ffa0]
	or a
	jr z, .asm_67231
	ldtx hl, PokemonWasReturnedFromBenchToHandText
.asm_67231
	ldh a, [hTempCardIndex_ff98]
	bank1call DisplayCardDetailScreen

.shift_or_switch
; if card was in Bench, simply shift Pokemon slots...
	ldh a, [hTemp_ffa0]
	or a
	jr z, .switch
	call ShiftAllPokemonToFirstPlayAreaSlots
	ret

.switch
; ...if Pokemon was in Arena, then switch it with the selected Bench card.
	ldh a, [hTempPlayAreaLocation_ffa1]
	ld d, a
	ld e, $00
	call SwapPlayAreaPokemon
	call ShiftAllPokemonToFirstPlayAreaSlots
	ret

; return carry if no other cards in hand,
; or if there are no Pokemon cards in hand.
PokemonTrader_HandDeckCheck:
	ld a, DUELVARS_NUMBER_OF_CARDS_IN_HAND
	get_turn_duelist_var
	ldtx hl, NoExchangeableCardsInHandText
	cp 2
	ret c ; return if no other cards in hand
	call CreatePokemonCardListFromHand
	ldtx hl, NoExchangeableCardsInHandText
	ret

PokemonTrader_PlayerHandSelection:
; print text box
	ldtx hl, ChooseCardFromYourHandToExchangeText
	call DrawWideTextBox_WaitForInput

; create list with all Pokemon cards in hand
	call CreatePokemonCardListFromHand
	bank1call InitAndDrawCardListScreenLayout_WithSelectCheckMenu

; handle Player selection
	ldtx hl, ChooseCardToExchangeText
	ldtx de, DuelistHandText
	bank1call SetCardListHeaderAndInfoText
	bank1call DisplayCardList
	ldh [hTemp_ffa0], a
	ret

PokemonTrader_PlayerDeckSelection:
; temporarily place chosen hand card in deck
; so it can be potentially chosen to be traded.
	ldh a, [hTemp_ffa0]
	call RemoveCardFromHand
	call ReturnCardToDeck

; display deck card list screen
	ldtx hl, ChooseBasicOrEvolutionPokemonCardFromDeckText
	call DrawWideTextBox_WaitForInput
	call CreateDeckCardList
	bank1call InitAndDrawCardListScreenLayout_WithSelectCheckMenu
	ldtx hl, ChoosePokemonCardText
	ldtx de, DuelistDeckText
	bank1call SetCardListHeaderAndInfoText

; handle Player selection
.read_input
	bank1call DisplayCardList
	jr c, .read_input ; pressing B loops back to selection
	call LoadCardDataToBuffer2_FromDeckIndex
	ld a, [wLoadedCard2Type]
	cp TYPE_ENERGY
	jr nc, .read_input ; can't select non-Pokemon cards

; a valid card was selected, store its card index and
; place the selected hand card back to the hand.
	ldh a, [hTempCardIndex_ff98]
	ldh [hTempPlayAreaLocation_ffa1], a
	ldh a, [hTemp_ffa0]
	call SearchCardInDeckAndAddToHand
	call AddCardToHand
	or a
	ret

PokemonTrader_TradeCardsEffect:
; place hand card in deck
	ldh a, [hTemp_ffa0]
	call RemoveCardFromHand
	call ReturnCardToDeck

; place deck card in hand
	ldh a, [hTempPlayAreaLocation_ffa1]
	call SearchCardInDeckAndAddToHand
	call AddCardToHand

; display cards if the Pokemon Trader wasn't played by Player
	call CallIfIsPlayerTurn
	jr c, .done
	ldh a, [hTemp_ffa0]
	ldtx hl, PokemonWasReturnedToDeckText
	bank1call DisplayCardDetailScreen
	ldh a, [hTempPlayAreaLocation_ffa1]
	ldtx hl, WasPlacedInTheHandText
	bank1call DisplayCardDetailScreen
.done
	call CallShuffleCardsInDeck
	ret

; makes list in wDuelTempList with all Pokemon cards
; that are in Turn Duelist's hand.
; if list turns out empty, return carry.
CreatePokemonCardListFromHand:
	ld a, DUELVARS_NUMBER_OF_CARDS_IN_HAND
	get_turn_duelist_var
	ld c, a
	ld l, DUELVARS_HAND
	ld de, wDuelTempList
.loop
	ld a, [hl]
	call LoadCardDataToBuffer2_FromDeckIndex
	ld a, [wLoadedCard2Type]
	cp TYPE_ENERGY
	jr nc, .next_hand_card
	ld a, [hl]
	ld [de], a
	inc de
.next_hand_card
	inc l
	dec c
	jr nz, .loop
	ld a, $ff ; terminating byte
	ld [de], a
	ld a, [wDuelTempList]
	cp $ff
	jr z, .set_carry
	or a
	ret
.set_carry
	scf
	ret

; return carry if no cards in deck
Pokedex_DeckCheck:
	ld a, DUELVARS_NUMBER_OF_CARDS_NOT_IN_DECK
	get_turn_duelist_var
	ldtx hl, NoCardsLeftInTheDeckText
	cp DECK_SIZE
	ccf
	ret

Pokedex_PlayerSelection:
; print text box
	ldtx hl, RearrangeThe5CardsAtTopOfDeckText
	call DrawWideTextBox_WaitForInput

; cap the number of cards to reorder up to
; number of cards left in the deck (maximum of 5)
	ld a, DUELVARS_NUMBER_OF_CARDS_NOT_IN_DECK
	get_turn_duelist_var
	ld b, a
	ld a, DECK_SIZE
	sub [hl]
	ld c, 5
	cp c
	jr nc, .no_cap
	ld c, a
.no_cap

; fill wDuelTempList with cards that are going to be sorted
	ld a, c
	inc a
	ld [wNumberOfCardsToOrder], a
	ld a, b
	add DUELVARS_DECK_CARDS
	ld l, a
	ld de, wDuelTempList
.loop_cards_to_order
	ld a, [hli]
	ld [de], a
	inc de
	dec c
	jr nz, .loop_cards_to_order
	ld a, $ff ; terminating byte
	ld [de], a

.clear_list
; wDuelTempList + 10 will be filled with numbers from 1
; to 5 (or whatever the maximum order card is).
; so that the first item in that list corresponds to the first card
; the second item corresponds to the second card, etc.
; and the number in the list corresponds to the ordering number.
	call CountCardsInDuelTempList
	ld b, a
	ld a, 1
; fill order list with zeroes
	ldh [hCurSelectionItem], a
	ld hl, wDuelTempList + 10
	xor a
.loop_init
	ld [hli], a
	dec b
	jr nz, .loop_init
	ld [hl], $ff ; terminating byte

; display card list to order
	bank1call InitAndDrawCardListScreenLayout
	ldtx hl, ChooseTheOrderOfTheCardsText
	ldtx de, DuelistDeckText
	bank1call SetCardListHeaderAndInfoText
	bank1call PrintSortNumberInCardList_SetPointer

.read_input
	bank1call DisplayCardList
	jr c, .undo ; if B is pressed, undo last order selection

; a card was selected, check if it's already been selected
	ldh a, [hCurScrollMenuItem]
	ld e, a
	ld d, $00
	ld hl, wDuelTempList + 10
	add hl, de
	ld a, [hl]
	or a
	jr nz, .read_input ; already has an ordering number

; hasn't been ordered yet, apply to it current ordering number
; and increase it by 1.
	ldh a, [hCurSelectionItem]
	ld [hl], a
	inc a
	ldh [hCurSelectionItem], a

; refresh screen
	push af
	bank1call PrintSortNumberInCardList_CallFromPointer
	pop af

; check if we're done ordering
	ldh a, [hCurSelectionItem]
	ld hl, wNumberOfCardsToOrder
	cp [hl]
	jr c, .read_input ; if still more cards to select, loop back up

; we're done selecting cards
	call EraseCursor
	ldtx hl, IsThisOKText
	call YesOrNoMenuWithText_LeftAligned
	jr c, .clear_list ; "No" was selected, start over
	; selection was confirmed
	
; now wDuelTempList + 10 will be overwritten with the
; card indices in order of selection.
	ld hl, wDuelTempList + 10
	ld de, wDuelTempList
	ld c, 0
.loop_write_indices
	ld a, [hli]
	cp $ff
	jr z, .done_write_indices
	push hl
	push bc
	ld c, a
	ld b, $00
	ld hl, hTempCardIndex_ff9f
	add hl, bc
	ld a, [de]
	ld [hl], a
	pop bc
	pop hl
	inc de
	inc c
	jr .loop_write_indices

.done_write_indices
	ld b, $00
	ld hl, hTempList
	add hl, bc
	ld [hl], $ff ; terminating byte
	or a
	ret

.undo
; undo last selection and get previous order number
	ld hl, hCurSelectionItem
	ld a, [hl]
	cp 1
	jr z, .read_input ; already at first input, nothing to undo
	dec a
	ld [hl], a
	ld c, a
	ld hl, wDuelTempList + 10
.loop_find_last_entry
	ld a, [hli]
	cp c
	jr nz, .loop_find_last_entry
	dec hl
	ld [hl], 0 ; overwrite order number with 0
	bank1call PrintSortNumberInCardList_CallFromPointer
	jr .read_input

Pokedex_OrderDeckCardsEffect:
; place cards in order to the hand.
	ld hl, hTempList
	ld c, 0
.loop_place_hand
	ld a, [hli]
	cp $ff
	jr z, .place_top_deck
	call SearchCardInDeckAndAddToHand
	inc c
	jr .loop_place_hand

.place_top_deck
; go to last card in list and iterate in decreasing order
; placing each card in top of deck.
	dec hl
	dec hl
.loop_place_deck
	ld a, [hld]
	call ReturnCardToDeck
	dec c
	jr nz, .loop_place_deck
	ret

BillEffect:
	ldh a, [hTempCardIndex_ff9f]
	call RemoveCardFromHand
	ld a, 2
	farcall DisplayDrawNCardsScreen
	ld c, 2
.loop_draw
	call DrawCardFromDeck
	jr c, .done
	ldh [hTempCardIndex_ff98], a
	call AddCardToHand
	call CallIfIsPlayerTurn
	jr nc, .skip_display_screen
	push bc
	bank1call DisplayPlayerDrawCardScreen
	pop bc
.skip_display_screen
	dec c
	jr nz, .loop_draw
.done
	ret

LassEffect:
; first discard Lass card that was used
	ldh a, [hTempCardIndex_ff9f]
	call RemoveCardFromHand
	call PutCardInDiscardPile

	ldtx hl, PleaseCheckTheOpponentsHandText
	call DrawWideTextBox_WaitForInput

	call .DisplayLinkOrCPUHand
	; do for non-Turn Duelist
	call SwapTurn
	call .ShuffleDuelistHandTrainerCardsInDeck
	call SwapTurn
	; do for Turn Duelist
;	fallthrough

.ShuffleDuelistHandTrainerCardsInDeck:
	call CreateHandCardList
	bank1call SortCardsInDuelTempListByID
	xor a
	ldh [hCurSelectionItem], a

; go through all cards in hand
; and any Trainer card is returned to deck.
	ld hl, wDuelTempList
.loop_hand
	ld a, [hli]
	ldh [hTempCardIndex_ff98], a
	cp $ff
	jr z, .done
	call GetCardIDFromDeckIndex
	call GetCardType
	cp TYPE_TRAINER
	jr nz, .loop_hand
	ldh a, [hTempCardIndex_ff98]
	call RemoveCardFromHand
	call ReturnCardToDeck
	push hl
	ld hl, hCurSelectionItem
	inc [hl]
	pop hl
	jr .loop_hand
.done
; show card list
	ldh a, [hCurSelectionItem]
	or a
	call nz, CallShuffleCardsInDeck ; only show list if there were any Trainer cards
	ret

.DisplayLinkOrCPUHand:
	ld a, [wDuelType]
	or a
	jr z, .cpu_opp

; link duel
	ldh a, [hWhoseTurn]
	push af
	ld a, OPPONENT_TURN
	ldh [hWhoseTurn], a
	call .DisplayOppHand
	pop af
	ldh [hWhoseTurn], a
	ret

.cpu_opp
	call SwapTurn
	call .DisplayOppHand
	call SwapTurn
	ret

.DisplayOppHand:
	call CreateHandCardList
	jr c, .no_cards
	bank1call InitAndDrawCardListScreenLayout
	ldtx hl, ChooseCardToCheckText
	ldtx de, DuelistHandText
	bank1call SetCardListHeaderAndInfoText
	ld a, PAD_A | PAD_START
	ld [wNoItemSelectionMenuKeys], a
	bank1call DisplayCardList
	ret
.no_cards
	ldtx hl, DuelistHasNoCardsInHandText
	call DrawWideTextBox_WaitForInput
	ret

; return carry if not enough cards in hand for effect
Maintenance_HandCheck:
	ld a, DUELVARS_NUMBER_OF_CARDS_IN_HAND
	get_turn_duelist_var
	ldtx hl, NotEnoughCardsInHandText
	cp 3
	ret

Maintenance_PlayerSelection:
	ldtx hl, Choose2CardsFromHandToReturnToDeckText
	ldtx de, ChooseTheCardToPutBackText
	call HandlePlayerSelection2HandCards
	ret

Maintenance_ReturnToDeckAndDrawEffect:
; return both selected cards to the deck
	ldh a, [hTemp_ffa0]
	call RemoveCardFromHand
	call ReturnCardToDeck
	ldh a, [hTempPlayAreaLocation_ffa1]
	call RemoveCardFromHand
	call ReturnCardToDeck
	call CallShuffleCardsInDeck

; draw one card
	ld a, 1
	farcall DisplayDrawNCardsScreen
	call DrawCardFromDeck
	call AddCardToHand
	ret

; return carry if no cards in deck
PokeBall_DeckCheck:
	ld a, DUELVARS_NUMBER_OF_CARDS_NOT_IN_DECK
	get_turn_duelist_var
	ldtx hl, NoCardsLeftInTheDeckText
	cp DECK_SIZE
	ccf
	ret

PokeBall_PlayerSelection:
	ldtx de, TrainerCardSuccessCheckText
	farcall Serial_TossCoin
	ldh [hTemp_ffa0], a ; store coin result
	ret nc

; create list of all Pokemon cards in deck to search for
	call CreateDeckCardList
	ldtx hl, ChooseBasicOrEvolutionPokemonCardFromDeckText
	ldtx bc, EffectTargetBasicOrEvolutionPokemonCardText
	ld a, CARDSEARCH_POKEMON
	farcall LookForCardsInDeck
	jr c, .got_selection
	ldtx hl, ChoosePokemonCardText
	ldtx de, DuelistDeckText
	farcall SelectCardSearchTarget
.got_selection
	ldh [hTempPlayAreaLocation_ffa1], a
	ret

PokeBall_AddToHandEffect:
	ldh a, [hTemp_ffa0]
	or a
	ret z ; return if coin toss was tails

	ldh a, [hTempPlayAreaLocation_ffa1]
	cp $ff
	jr z, .done ; skip if no Pokemon was chosen

; add Pokemon card to hand and show in screen if
; it wasn't the Player who played the Trainer card.
	call SearchCardInDeckAndAddToHand
	call AddCardToHand
	call CallIfIsPlayerTurn
	jr c, .done
	ldh a, [hTempPlayAreaLocation_ffa1]
	ldtx hl, WasPlacedInTheHandText
	bank1call DisplayCardDetailScreen
.done
	call CallShuffleCardsInDeck
	ret

; return carry if no cards in the Discard Pile
; or if Dark Hole special rule is active
Recycle_DiscardPileCheck:
	bank1call IsBlackHoleRuleActive
	jr c, .black_hole_active
	ld a, DUELVARS_NUMBER_OF_CARDS_IN_DISCARD_PILE
	get_turn_duelist_var
	cp 1
.black_hole_active
	ldtx hl, NoCardsInDiscardPileText
	ret

Recycle_PlayerSelection:
	ldtx de, TrainerCardSuccessCheckText
	farcall Serial_TossCoin
	jr nc, .tails

	bank1call CreateDiscardPileCardList
	bank1call InitAndDrawCardListScreenLayout_WithSelectCheckMenu
	ldtx hl, PleaseSelectCardText
	ldtx de, DuelistDiscardPileText
	bank1call SetCardListHeaderAndInfoText
.read_input
	bank1call DisplayCardList
	jr c, .read_input ; can't cancel with B button

; Discard Pile card was chosen
	ldh a, [hTempCardIndex_ff98]
	ldh [hTemp_ffa0], a
	ret

.tails
	ld a, $ff
	ldh [hTemp_ffa0], a
	or a
	ret

Recycle_AddToHandEffect:
	ldh a, [hTemp_ffa0]
	cp $ff
	ret z ; return if no card was selected

; add card to hand and show in screen if
; it wasn't the Player who played the Trainer card.
	call MoveDiscardPileCardToHand
	call ReturnCardToDeck
	call CallIfIsPlayerTurn
	ret c
	ldh a, [hTemp_ffa0]
	ldtx hl, CardWasChosenText
	bank1call DisplayCardDetailScreen
	ret

; return carry if Bench is full or
; if no Basic Pokemon cards in Discard Pile.
Revive_BenchCheck:
	farcall CheckIfHasSpaceInBench
	ret c
	farcall CreateBasicPkmnCardListFromDiscardPile
	ret

Revive_PlayerSelection:
; create Basic Pokemon card list from Discard Pile
	ldtx hl, ChooseBasicPokemonToPlaceOnBenchText
	call DrawWideTextBox_WaitForInput
	farcall CreateBasicPkmnCardListFromDiscardPile
	bank1call InitAndDrawCardListScreenLayout_WithSelectCheckMenu

; display screen to select Pokemon
	ldtx hl, PleaseSelectCardText
	ldtx de, DuelistDiscardPileText
	bank1call SetCardListHeaderAndInfoText
	bank1call DisplayCardList

; store selection
	ldh a, [hTempCardIndex_ff98]
	ldh [hTemp_ffa0], a
	ret

Revive_PlaceInPlayAreaEffect:
; place selected Pokemon in the Bench
	ldh a, [hTemp_ffa0]
	call MoveDiscardPileCardToHand
	call AddCardToHand
	call PutHandPokemonCardInPlayArea
	
; set HP to half, rounded up
	add DUELVARS_ARENA_CARD_HP
	get_turn_duelist_var
	srl a
	bit 0, a
	jr z, .rounded
	add 5 ; round up HP to nearest 10
.rounded
	ld [hl], a
	call CallIfIsPlayerTurn
	ret c ; done if Player played Revive

; display card
	ldh a, [hTemp_ffa0]
	ldtx hl, PlacedOnBenchText
	bank1call DisplayCardDetailScreen
	ret

; return carry if Turn Duelist has no Evolution cards in Play Area
DevolutionSpray_PlayAreaEvolutionCheck:
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	ld c, a
	ld l, DUELVARS_ARENA_CARD
.loop
	ld a, [hli]
	call LoadCardDataToBuffer2_FromDeckIndex
	ld a, [wLoadedCard2Stage]
	or a
	ret nz ; found an Evolution card
	dec c
	jr nz, .loop

	ldtx hl, NoEvolvedPokemonText
	scf
	ret

DevolutionSpray_PlayerSelection:
; display textbox
	ldtx hl, ChooseEvolutionCardAndPressAButtonToDevolveText
	call DrawWideTextBox_WaitForInput

; have Player select an Evolution card in Play Area
	ld a, 1
	ldh [hCurSelectionItem], a
	bank1call HasAlivePokemonInPlayArea
.read_input
	bank1call OpenPlayAreaScreenForSelection
	ret c ; exit if B was pressed
	bank1call GetCardOneStageBelow
	jr c, .read_input ; can't select Basic cards

; get pre-evolution card data
	ldh a, [hTempPlayAreaLocation_ff9d]
	add DUELVARS_ARENA_CARD_HP
	get_turn_duelist_var
	push hl
	push af
	ldh a, [hTempPlayAreaLocation_ff9d]
	add DUELVARS_ARENA_CARD_STAGE
	ld l, a
	ld a, [hl]
	push hl
	push af
	ldh a, [hTempPlayAreaLocation_ff9d]
	add DUELVARS_ARENA_CARD
	ld l, a
	ld a, [hl]
	push hl
	push af
	jr .update_data

.repeat_devolution
; show Play Area screen with static cursor
; so that the Player either presses A to do one more devolution
; or presses B to finish selection.
	bank1call InitAndPrintPlayAreaCardInformationAndLocation_WithTextBox
	jr c, .done_selection ; if B pressed, end selection instead
	; do one more devolution
	bank1call GetCardOneStageBelow

.update_data
; overwrite the card data to new devolved stats
	ld a, d
	farcall UpdateDevolvedCardHPAndStage
	farcall GetNextPositionInTempList
	ld [hl], e
	ld a, d
	call LoadCardDataToBuffer2_FromDeckIndex
	ld a, [wLoadedCard2Stage]
	or a
	jr nz, .repeat_devolution ; can do one more devolution

.done_selection
	farcall GetNextPositionInTempList
	ld [hl], $ff

; store this Play Area location in first item of temp list
	ldh a, [hTempPlayAreaLocation_ff9d]
	ldh [hTemp_ffa0], a

; update Play Area location display of this Pokemon
	call EmptyScreen
	ldh a, [hTempPlayAreaLocation_ff9d]
	ld hl, wHUDEnergyAndHPBarsX
	ld [hli], a
	ld [hl], $00
	bank1call PrintPlayAreaCardInformationAndLocation
	call EnableLCD
	pop bc
	pop hl

; rewrite all duelvars from before the selection was done
; this is so that if "No" is selected in confirmation menu,
; then the Pokemon isn't devolved and remains unchanged.
	ld [hl], b
	ldtx hl, IsThisOKText
	call YesOrNoMenuWithText
	pop bc
	pop hl

	ld [hl], b
	pop bc
	pop hl

	ld [hl], b
	ret

DevolutionSpray_DevolutionEffect:
; first byte in list is Play Area location chosen
	ld hl, hTempList
	ld a, [hli]
	ldh [hTempPlayAreaLocation_ff9d], a
	add DUELVARS_ARENA_CARD
	get_turn_duelist_var
	push hl
	push af

; loop through devolutions selected
	ld hl, hTempList + 1
.loop_devolutions
	ld a, [hl]
	cp $ff
	jr z, .check_ko ; list is over
	; devolve card to its stage below
	push hl
	bank1call GetCardOneStageBelow
	ld a, d
	farcall UpdateDevolvedCardHPAndStage
	farcall ResetDevolvedCardStatus
	pop hl
	ld a, [hli]
	call PutCardInDiscardPile
	jr .loop_devolutions

.check_ko
	pop af
	ld e, a
	pop hl
	ld d, [hl]
	farcall PrintDevolvedCardNameAndLevelText
	ldh a, [hTemp_ffa0]
	call PrintPlayAreaCardKnockedOutIfNoHP
	bank1call HandleDestinyBondAndBetweenTurnKnockOuts
	ret

; returns carry if neither duelist has any energy cards attached
SuperEnergyRemoval_EnergyCheck:
	call CheckIfThereAreAnyEnergyCardsAttached
	ldtx hl, NoEnergyCardsAttachedToPokemonInYourPlayAreaText
	ret c
	call SwapTurn
	call CheckIfThereAreAnyEnergyCardsAttached
	ldtx hl, NoEnergyCardsAttachedToPokemonInOppPlayAreaText
	call SwapTurn
	ret

SuperEnergyRemoval_PlayerSelection:
; handle selection of Energy to discard in own Play Area
	ldtx hl, ChoosePokemonInYourAreaThenInOppAreaText
	call DrawWideTextBox_WaitForInput
	call HandlePokemonAndEnergySelectionScreen
	ret c ; return if operation was cancelled

	ldtx hl, ChoosePokemonAndRemoveEnergyText
	call DrawWideTextBox_WaitForInput

	call SwapTurn
	ld a, 3
	ldh [hCurSelectionItem], a
.select_opp_pkmn
	bank1call HasAlivePokemonInPlayArea
	bank1call OpenPlayAreaScreenForSelection
	jr nc, .opp_pkmn_selected
	; B was pressed
	call SwapTurn
	ret ; return if operation was cancelled
.opp_pkmn_selected
	ld e, a
	call GetPlayAreaCardAttachedEnergies
	ld a, [wTotalAttachedEnergies]
	or a
	jr nz, .has_energy ; has any energy cards attached?
	; no energy, loop back
	ldtx hl, NoEnergyCardsText
	call DrawWideTextBox_WaitForInput
	jr .select_opp_pkmn

.has_energy
; store this Pokemon's Play Area location
	ldh a, [hTempPlayAreaLocation_ff9d]
	ldh [hPlayAreaEffectTarget], a
; store which energy card to discard from it
	bank1call CreateArenaOrBenchEnergyCardList
	ldh a, [hTempPlayAreaLocation_ff9d]
	bank1call DisplayEnergyDiscardMenu
	ld a, 2
	ld [wAttachedEnergyMenuDenominator], a

.loop_discard_energy_selection
	bank1call HandleAttachedEnergyMenuInput
	; B pressed
	jr nc, .energy_selected
	ld a, 5
	farcall AskWhetherToQuitSelectingCards
	jr nc, .done ; finish operation
	; player selected to continue selection
	ld a, [wAttachedEnergyMenuNumerator]
	push af
	ldh a, [hTempPlayAreaLocation_ff9d]
	bank1call DisplayEnergyDiscardMenu
	ld a, 2
	ld [wAttachedEnergyMenuDenominator], a
	pop af
	ld [wAttachedEnergyMenuNumerator], a
	jr .loop_discard_energy_selection

.energy_selected
; store energy cards to discard from opponent
	farcall GetNextPositionInTempList
	ldh a, [hTempCardIndex_ff98]
	ld [hl], a
	call RemoveCardFromDuelTempList
	ld hl, wAttachedEnergyMenuNumerator
	inc [hl]
	ldh a, [hCurSelectionItem]
	cp 5
	jr nc, .done ; no more energy cards to select
	ld a, [wDuelTempList + 0]
	cp $ff
	jr z, .done ; no more energy cards to select
	bank1call UpdateAttachedEnergyMenu
	jr .loop_discard_energy_selection

.done
	farcall GetNextPositionInTempList
	ld [hl], $ff
	call SwapTurn
	or a
	ret

SuperEnergyRemoval_DiscardEffect:
	ld hl, hTempList + 1

; discard energy card of own Play Area
	ld a, [hli]
	call DiscardCard

; iterate and discard opponent's energy cards
	inc hl
	call SwapTurn
.loop
	ld a, [hli]
	cp $ff
	jr z, .done_discard
	call DiscardCard
	jr .loop

.done_discard
; if it's Player's turn, return...
	call SwapTurn
	call CallIfIsPlayerTurn
	ret c
; ...otherwise show Play Area of affected Pokemon
; in opponent's Play Area
	ldh a, [hTemp_ffa0]
	farcall DrawPlayAreaScreenToShowChanges
; in player's Play Area
	xor a
	ld [wDuelDisplayedScreen], a
	call SwapTurn
	ldh a, [hPlayAreaEffectTarget]
	farcall DrawPlayAreaScreenToShowChanges
	call SwapTurn
	ret

; return carry if not enough cards in hand to
; discard for Super Energy Retrieval effect
; or if the Discard Pile has no basic Energy cards
SuperEnergyRetrieval_HandEnergyCheck:
	ld a, DUELVARS_NUMBER_OF_CARDS_IN_HAND
	get_turn_duelist_var
	ldtx hl, NotEnoughCardsInHandText
	cp 3
	ret c
	farcall CreateEnergyCardListFromDiscardPile_OnlyBasic
	ldtx hl, NoBasicEnergyCardsInDiscardPileText
	ret

SuperEnergyRetrieval_PlayerHandSelection:
	call HandlePlayerSelection2HandCardsToDiscard
	ret

SuperEnergyRetrieval_PlayerDiscardPileSelection:
	ldtx hl, ChooseUpTo4FromDiscardPileText
	call DrawWideTextBox_WaitForInput
	farcall CreateEnergyCardListFromDiscardPile_OnlyBasic

.loop_discard_pile_selection
	bank1call InitAndDrawCardListScreenLayout
	ldtx hl, PleaseSelectCardText
	ldtx de, DuelistDiscardPileText
	bank1call SetCardListHeaderAndInfoText
	bank1call DisplayCardList
	jr nc, .store_selected_card
	; B pressed
	ld a, 6
	farcall AskWhetherToQuitSelectingCards
	jr c, .loop_discard_pile_selection ; player selected to continue
	jr .done

.store_selected_card
	ldh a, [hTempCardIndex_ff98]
	get_turn_duelist_var
	farcall GetNextPositionInTempList
	ldh a, [hTempCardIndex_ff98]
	ld [hl], a ; store selected energy card
	call RemoveCardFromDuelTempList
	jr c, .done
	; this shouldn't happen
	ldh a, [hCurSelectionItem]
	cp 6
	jr c, .loop_discard_pile_selection

.done
; insert terminating byte
	farcall GetNextPositionInTempList
	ld [hl], $ff
	or a
	ret

SuperEnergyRetrieval_DiscardAndAddToHandEffect:
; discard 2 cards selected from the hand
	ld hl, hTemp_ffa0
	ld a, [hli]
	call RemoveCardFromHand
	call PutCardInDiscardPile
	ld a, [hli]
	call RemoveCardFromHand
	call PutCardInDiscardPile

; put selected cards in hand
	ld de, wDuelTempList
.loop
	ld a, [hli]
	ld [de], a
	inc de
	cp $ff
	jr z, .done
	call MoveDiscardPileCardToHand
	call AddCardToHand
	jr .loop

.done
; if Player played the card, exit
	call CallIfIsPlayerTurn
	ret c
; if not, show card list selected by Opponent
	bank1call DisplayCardListDetails
	ret

; handles screen for Player to select 2 cards from the hand to discard.
; first prints text informing Player to choose cards to discard
; then runs HandlePlayerSelection2HandCards routine.
HandlePlayerSelection2HandCardsToDiscard:
	ldtx hl, Choose2CardsFromHandToDiscardText
	ldtx de, ChooseTheCardToDiscardText
;	fallthrough

; handles screen for Player to select 2 cards from the hand
; to activate some Trainer card effect.
; assumes Trainer card index being used is in [hTempCardIndex_ff9f].
; stores selection of cards in hTempList.
; returns carry if Player cancels operation.
; input:
;	hl = text to print in text box;
;	de = text to print in screen header.
HandlePlayerSelection2HandCards:
	push de
	call DrawWideTextBox_WaitForInput

; remove the Trainer card being used from list
; of cards to select from hand.
	call CreateHandCardList
	ldh a, [hTempCardIndex_ff9f]
	call RemoveCardFromDuelTempList

	xor a
	ldh [hCurSelectionItem], a
	pop hl
.loop
	push hl
	bank1call InitAndDrawCardListScreenLayout_WithSelectCheckMenu
	pop hl
	bank1call SetCardListInfoBoxText
	push hl
	bank1call DisplayCardList
	pop hl
	jr c, .set_carry ; was B pressed?
	push hl
	farcall GetNextPositionInTempList
	ldh a, [hTempCardIndex_ff98]
	ld [hl], a
	call RemoveCardFromDuelTempList
	pop hl
	ldh a, [hCurSelectionItem]
	cp 2
	jr c, .loop ; is selection over?
	or a
	ret
.set_carry
	scf
	ret

; return carry if non-turn duelist has no benched Pokemon
GustOfWind_BenchCheck:
	farcall CheckNonTurnDuelistHasBench
	ret

GustOfWind_PlayerSelection:
	ldtx hl, ChoosePokemonToSwitchWithActiveText
	call DrawWideTextBox_WaitForInput
	call SwapTurn
	bank1call HasAlivePokemonInBench
	bank1call OpenPlayAreaScreenForSelection
	ldh a, [hTempPlayAreaLocation_ff9d]
	ldh [hTemp_ffa0], a
	call SwapTurn
	ret

GustOfWind_SwitchEffect:
; play whirlwind animation
	ld a, ATK_ANIM_GUST_OF_WIND
	call PlaySpecialAttackAnimation

; switch Arena card
	call SwapTurn
	ldh a, [hTemp_ffa0]
	ld e, a
	call SwapArenaWithBenchPokemon
	call SwapTurn
	bank1call ClearDamageReductionSubstatus2
	xor a
	ld [wDuelDisplayedScreen], a
	ret

; some attacks and trainer cards play a special animation
; in the middle of resolving their effects, this routine
; plays an animation given in register a then waits for it to finish
; input:
; - a = ATK_ANIM_* constant to play
PlaySpecialAttackAnimation:
	ld [wLoadedAttackAnimation], a
	farcall ResetAttackAnimationIsPlaying
	lb bc, PLAY_AREA_ARENA, 0
	ldh a, [hWhoseTurn]
	ld h, a
	farcall PlayAttackAnimation
	farcall WaitAttackAnimation
	ret

; input:
; - a = amount of HP to heal
HealPlayAreaPokemon:
	ld e, a
	ld d, 0

	; play healing animation in Play Area
	push de
	farcall ResetAttackAnimationIsPlaying
	ld a, ATK_ANIM_HEALING_WIND_PLAY_AREA
	ld [wLoadedAttackAnimation], a
	ldh a, [hTempPlayAreaLocation_ff9d]
	ld b, a
	ld c, $01
	ldh a, [hWhoseTurn]
	ld h, a
	farcall PlayAttackAnimation
	farcall WaitAttackAnimation
	pop hl

	; load amount to heal as text
	push hl
	call LoadTxRam3
	ld hl, NULL
	call LoadTxRam2

	; load Pokémon's name
	ldh a, [hTempPlayAreaLocation_ff9d]
	add DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call LoadCardDataToBuffer1_FromDeckIndex
	ld a, 18
	call CopyCardNameAndLevel
	ld [hl], TX_END

	; display text
	ldtx hl, PokemonHealedDamageText
	call DrawWideTextBox_WaitForInput
	pop de

	; actually add amount to heal
	ldh a, [hTempPlayAreaLocation_ff9d]
	add DUELVARS_ARENA_CARD_HP
	get_turn_duelist_var
	add e
	ld [hl], a
	ret
