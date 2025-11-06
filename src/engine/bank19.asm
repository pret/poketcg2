ImposterOaksRevenge_InitialEffect1:
	ld a, DUELVARS_NUMBER_OF_CARDS_IN_HAND
	get_turn_duelist_var
	cp $02
	ld hl, $bf
	ret

ImposterOaksRevenge_InitialEffect2:
	ldtx hl, ChooseCardFromHandToDiscardText
	call DrawWideTextBox_WaitForInput
	call CreateHandCardList
	ldh a, [hTempCardIndex_ff9f]
	call RemoveCardFromDuelTempList
	bank1call Func_5221
	bank1call DisplayCardList
	ldh a, [hTempCardIndex_ff98]
	ldh [hTemp_ffa0], a
	ret

ImposterOaksRevenge_BeforeDamage:
	ldh a, [hTemp_ffa0]
	call RemoveCardFromHand
	call PutCardInDiscardPile
	call SwapTurn
	call CreateHandCardList
	bank1call SortCardsInDuelTempListByID
	ld hl, wDuelTempList
.asm_64036
	ld a, [hli]
	cp $ff
	jr z, .asm_64043
	call RemoveCardFromHand
	call ReturnCardToDeck
	jr .asm_64036
.asm_64043
	farcall Func_680a0
	ld a, $04
	farcall DisplayDrawNCardsScreen
	ld c, $04
.asm_6404f
	call DrawCardFromDeck
	jr c, .asm_6405a
	call AddCardToHand
	dec c
	jr nz, .asm_6404f
.asm_6405a
	call SwapTurn
	ret

Sleep_BeforeDamage:
	ldtx de, IfHeadsInflictSleepText
	farcall TossCoin_Bank1a
	ret nc
	bank1call DrawDuelMainScene
	call SwapTurn
	bank1call CheckIfArenaCardIsProtectedFromStatusCondition
	push af
	call SwapTurn
	ld a, $7e
	call Func_67843
	pop af
	jr nc, .asm_64082
	ldtx hl, ThereWasNoEffectText
	call DrawWideTextBox_WaitForInput
	ret
.asm_64082
	ld a, $ec
	call GetNonTurnDuelistVariable
	and $f0
	or $02
	ld [hl], a
	ld l, $d4
	ld [hl], $00
	ld l, $c2
	res 3, [hl]
	bank1call DrawDuelHUDs
	ret

Digger_BeforeDamage:
.asm_64098
	ldtx de, DiggerCheckText
	farcall TossCoin_Bank1a
	jr nc, .asm_640b2
	call SwapTurn
	ldtx de, DiggerCheckText
	farcall TossCoin_Bank1a
	jr nc, .asm_640b7
	call SwapTurn
	jr .asm_64098
.asm_640b2
	call Func_640c1
	jr .asm_640bd
.asm_640b7
	call Func_640c1
	call SwapTurn
.asm_640bd
	bank1call Func_6518
	ret

Func_640c1:
	ld b, $00
	ld de, $a
	call Func_640ca
	ret

Func_640ca:
	push hl
	push de
	push bc
	ld c, $78
	ld a, b
	or a
	jr nz, .asm_640df
	ld c, $8f
	ldh a, [hWhoseTurn]
	ld hl, wWhoseTurn
	cp [hl]
	jr nz, .asm_640df
	ld c, $7a
.asm_640df
	ld a, c
	ld [wLoadedAttackAnimation], a
	push de
	ld a, b
	bank1call LoadPlayAreaCardID_ToTempNonTurnDuelistCardID
	pop de
	ld a, b
	or a
	jr nz, .asm_64101
	push bc
	ld [wNoDamageOrEffect], a
	ld a, $04
	ld [wLoadedAttackCategory], a
	bank1call HandleDamageReductionExceptSubstatus2
	pop bc
	bit 7, d
	jr z, .asm_64101
	ld de, $0
.asm_64101
	ldh a, [hWhoseTurn]
	push af
	push bc
	ld a, b
	add DUELVARS_ARENA_CARD_HP
	get_turn_duelist_var
	ld c, $00
	ld a, [wWhoseTurn]
	ldh [hWhoseTurn], a
	farcall Func_18a9c
	pop bc
	pop af
	ldh [hWhoseTurn], a
	ld a, b
	call PrintPlayAreaCardKnockedOutIfNoHP
	pop bc
	pop de
	pop hl
	ret

TheBosssWay_InitialEffect1:
	farcall Func_2435f
	ret

TheBosssWay_RequireSelection:
	call CreateDeckCardList
	ldtx hl, ChooseADarkEvolutionCardText
	ldtx bc, EffectTargetDarkPokemonText
	ld a, CARDSEARCH_DARK_POKEMON
	farcall Func_24c9d
	jr c, .asm_64140
	ldtx hl, ChooseADarkPokemonText
	ldtx de, DuelistDeckText
	farcall Func_24df8
.asm_64140
	ldh [hTemp_ffa0], a
	ret

TheBosssWay_BeforeDamage:
	ldh a, [hTemp_ffa0]
	cp $ff
	jr z, .asm_6415d
	call SearchCardInDeckAndAddToHand
	call AddCardToHand
	farcall Func_680ab
	jr c, .asm_6415d
	ldh a, [hTemp_ffa0]
	ldtx hl, WasPlacedInTheHandText
	bank1call DisplayCardDetailScreen
.asm_6415d
	farcall Func_680a0
	ret

GoopGasAttack_BeforeDamage:
	ld a, $02
	ld [wGoopGasAttackActive], a
	bank1call ClearChangedTypesIfMuk.ResetChangedTypes
	ret

RocketsSneakAttack_RequireSelection:
	ld a, $ff
	ldh [hTemp_ffa0], a
	call SwapTurn
	call CreateHandCardList
	jr nc, .asm_6417f
	ldtx hl, DuelistHasNoCardsInHandText
	call DrawWideTextBox_WaitForInput
	jr .asm_641b6
.asm_6417f
	bank1call Func_5221
	ldtx hl, ChooseATrainerCardText_2
	ldtx de, DuelistHandText
	bank1call SetCardListHeaderAndInfoText
.asm_6418b
	bank1call DisplayCardList
	jr c, .asm_641a2
	ldh a, [hTempCardIndex_ff98]
	call LoadCardDataToBuffer2_FromDeckIndex
	ld a, [wLoadedCard2Type]
	cp $10
	jr nz, .asm_6418b
	ldh a, [hTempCardIndex_ff98]
	ldh [hTemp_ffa0], a
	jr .asm_641b6
.asm_641a2
	ld hl, wDuelTempList
.asm_641a5
	ld a, [hli]
	cp $ff
	jr z, .asm_641b6
	call LoadCardDataToBuffer2_FromDeckIndex
	ld a, [wLoadedCard2Type]
	cp $10
	jr nz, .asm_641a5
	jr .asm_6418b
.asm_641b6
	call SwapTurn
	ret

RocketsSneakAttack_BeforeDamage:
	ldh a, [hTemp_ffa0]
	cp $ff
	ret z
	call SwapTurn
	call RemoveCardFromHand
	call ReturnCardToDeck
	farcall Func_680a0
	call SwapTurn
	ret

HereComesTeamRocket_BeforeDamage:
	ld a, $01
	ld [wcc07], a
	ret

NightlyGarbageRun_InitialEffect1:
	call Func_64244
	ld hl, $24d
	ret

NightlyGarbageRun_RequireSelection:
	xor a
	ldh [hffb2], a
	ldtx hl, NightlyGarbageRunPromptText
	call DrawWideTextBox_WaitForInput
	call Func_64244
.asm_641e9
	bank1call Func_5221
	ld hl, IncrementPlayTimeCounter
	ldtx de, DuelistDiscardPileText
	bank1call SetCardListHeaderAndInfoText
	bank1call DisplayCardList
	jr nc, .asm_64204
	ld a, $03
	farcall Func_6856d
	jr c, .asm_641e9
	jr .asm_64219
.asm_64204
	ldh a, [hTempCardIndex_ff98]
	get_turn_duelist_var
	farcall Func_24350
	ldh a, [hTempCardIndex_ff98]
	ld [hl], a
	call RemoveCardFromDuelTempList
	jr c, .asm_64219
	ldh a, [hffb2]
	cp $03
	jr c, .asm_641e9
.asm_64219
	farcall Func_24350
	ld [hl], $ff
	or a
	ret

NightlyGarbageRun_BeforeDamage:
	ld hl, hTemp_ffa0
	ld de, wDuelTempList
.asm_64227
	ld a, [hli]
	ld [de], a
	inc de
	cp $ff
	jr z, .asm_64236
	call MoveDiscardPileCardToHand
	call ReturnCardToDeck
	jr .asm_64227
.asm_64236
	farcall Func_680ab
	jr c, .asm_6423f
	bank1call Func_49e8
.asm_6423f
	farcall Func_680a0
	ret

Func_64244:
	bank1call IsBlackHoleRuleActive
	ret c
	ld a, DUELVARS_NUMBER_OF_CARDS_IN_DISCARD_PILE
	get_turn_duelist_var
	ld b, a
	add $7e
	ld l, a
	ld de, wDuelTempList
	inc b
	jr .asm_6426b
.asm_64255
	ld a, [hl]
	call LoadCardDataToBuffer2_FromDeckIndex
	ld a, [wLoadedCard2Type]
	cp $08
	jr c, .asm_64268
	cp $0e
	jr nc, .asm_6426b
	and $08
	jr z, .asm_6426b
.asm_64268
	ld a, [hl]
	ld [de], a
	inc de
.asm_6426b
	dec l
	dec b
	jr nz, .asm_64255
	ld a, $ff
	ld [de], a
	ld a, [wDuelTempList]
	cp $ff
	jr z, .asm_6427b
	or a
	ret
.asm_6427b
	scf
	ret

PotionEnergy_PkmnPowerTrigger:
	ldh a, [hTempPlayAreaLocation_ff9d]
	ld e, a
	call GetCardDamageAndMaxHP
	or a
	ret z
	ld a, $0a
	call Func_67859
	ret

FullhealEnergy_PkmnPowerTrigger:
	ldh a, [hTempPlayAreaLocation_ff9d]
	or a
	ret nz
	ld a, $8a
	call Func_67843
	ld a, DUELVARS_ARENA_CARD_STATUS
	get_turn_duelist_var
	ld [hl], $00
	bank1call DrawDuelHUDs
	ret

RainbowEnergy_PkmnPowerTrigger:
	ldh a, [hTempPlayAreaLocation_ff9d]
	ld b, a
	ld de, $a
	call Func_640ca
	bank1call Func_6518
	ret

Challenge_RequireSelection:
	ld a, $f6
	call GetNonTurnDuelistVariable
	cp $01
	jr z, .asm_642fa
	cp $00
	jr z, .asm_642d5
	call SwapTurn
	call Func_2983
	call SwapTurn
	call Func_64335
	ret c
	farcall Func_24be8
	call SwapTurn
	call Func_298a
	call SwapTurn
	xor a
	ldh [hTemp_ffa0], a
	ret
.asm_642d5
	call SwapTurn
	bank1call DrawDuelMainScene
	ldtx hl, ChallengePromptText
	call YesOrNoMenuWithText
	call SwapTurn
	call Func_64335
	ret c
	farcall Func_24be8
	call SwapTurn
	farcall Func_24be8
	call SwapTurn
	xor a
	ldh [hTemp_ffa0], a
	ret
.asm_642fa
	ld a, $1b
	call SetOppAction_SerialSendDuelData
.asm_642ff
	call SerialRecvByte
	jr nc, .asm_64308
	halt
	nop
	jr .asm_642ff
.asm_64308
	call Func_64335
	ret c
	farcall Func_24be8
	ld a, $1c
	call SetOppAction_SerialSendDuelData
	ldtx hl, SelectingPokemonFromDeckText
	call DrawWideTextBox_PrintText
	call SerialRecvDuelData
	call SwapTurn
	ldh a, [hffb2]
	ld e, a
	ldh a, [hTemp_ffa0]
	sub e
	inc a
	ldh [hTemp_ffa0], a
	farcall Func_24c7f
	call SwapTurn
	xor a
	ldh [hTemp_ffa0], a
	ret

Func_64335:
	ldh [hTemp_ffa0], a
	ldtx hl, ChallengeDeclinedText
	or a
	scf
	jr nz, .asm_64346
	ldtx hl, ChallengeAcceptedText
	ld a, $01
	ldh [hTemp_ffa0], a
	or a
.asm_64346
	push af
	call SwapTurn
	call DrawWideTextBox_WaitForInput
	call SwapTurn
	pop af
	ret

Challenge_BeforeDamage:
	ld hl, hTemp_ffa0
	ld a, [hli]
	or a
	jr z, .asm_6437f
	ldh a, [hTempCardIndex_ff9f]
	call RemoveCardFromHand
	ld a, $02
	farcall DisplayDrawNCardsScreen
	ld c, $02
.asm_64366
	call DrawCardFromDeck
	jr c, .asm_6437e
	ldh [hTempCardIndex_ff98], a
	call AddCardToHand
	farcall Func_680ab
	jr nc, .asm_6437b
	push bc
	bank1call DisplayPlayerDrawCardScreen
	pop bc
.asm_6437b
	dec c
	jr nz, .asm_64366
.asm_6437e
	ret
.asm_6437f
	ld a, [hli]
	cp $ff
	jr z, .asm_64391
	push hl
	call SearchCardInDeckAndAddToHand
	call AddCardToHand
	call PutHandPokemonCardInPlayArea
	pop hl
	jr .asm_6437f
.asm_64391
	push hl
	farcall Func_680a0
	pop hl
	call SwapTurn
.asm_6439a
	ld a, [hli]
	cp $ff
	jr z, .asm_643ac
	push hl
	call SearchCardInDeckAndAddToHand
	call AddCardToHand
	call PutHandPokemonCardInPlayArea
	pop hl
	jr .asm_6439a
.asm_643ac
	farcall Func_680a0
	call SwapTurn
	ret

BulbasaurLv15FirstAid_InitialEffect1:
	ld e, $00
	call GetCardDamageAndMaxHP
	ld hl, $b6
	cp $0a
	ret

BulbasaurLv15FirstAid_AfterDamage:
	ld e, $00
	call GetCardDamageAndMaxHP
	or a
	ret z
	ld de, $a
	farcall ApplyAndAnimateHPRecovery
	ret

CharmanderLv12Growl_BeforeDamage:
	ld a, $17
	farcall Func_6812e
	ret

SquirtleLv15WaterPower_BeforeDamage:
	ld a, $0d
	farcall Func_6810e
	ret

MetapodLv20GreenShield_InitialEffect1:
	scf
	ret

KakunaLv20PoisonFluid_InitialEffect1:
	scf
	ret

PidgeyLv10QuickAttack_AI:
	ld a, 20
	lb de, 10, 30
	farcall Func_680dd
	ret

PidgeyLv10QuickAttack_BeforeDamage:
	ld a, $14
	farcall Func_682e0
	ret

RattataLv15TailWhip_BeforeDamage:
	ldtx de, IfHeadsOpponentCannotAttackText
	farcall TossCoin_Bank1a
	jr nc, .asm_64401
	ld a, $05
	farcall Func_6812e
	ret
.asm_64401
	ld a, $ca
	ld [wLoadedAttackAnimation], a
	farcall Func_6809a
	ret

PikachuLv5Agility_BeforeDamage:
	ldtx de, IfHeadsDoNotReceiveDamageOrEffectText
	farcall TossCoin_Bank1a
	jr nc, .asm_6441b
	ld a, $11
	farcall Func_68127
	ret
.asm_6441b
	ld a, $51
	ld [wLoadedAttackAnimation], a
	ret

NidoranFLv12TailWhip_BeforeDamage:
	ldtx de, IfHeadsOpponentCannotAttackText
	farcall TossCoin_Bank1a
	jr nc, .asm_64431
	ld a, $05
	farcall Func_6812e
	ret
.asm_64431
	ld a, $ca
	ld [wLoadedAttackAnimation], a
	farcall Func_6809a
	ret

NidoranMLv22FocusEnergy_BeforeDamage:
	ld a, $1e
	farcall Func_6810e
	ret

NidoranMLv22HornRush_AI:
	ld a, 40
	lb de, 0, 40
	farcall Func_680dd
	ret

NidoranMLv22HornRush_BeforeDamage:
	ldtx de, AttackSuccessCheckText
	farcall TossCoin_Bank1a
	ret c
	xor a
	ld [wLoadedAttackAnimation], a
	farcall Func_6817e
	farcall Func_6809a
	ret

ClefairyLv15FollowMe_InitialEffect1:
	farcall Func_6843b
	ret

ClefairyLv15FollowMe_RequireSelection:
	ldtx hl, SelectBenchedPokemonToSwitchWithActiveText
	call DrawWideTextBox_WaitForInput
	call SwapTurn
	bank1call HasAlivePokemonInBench
.asm_64472
	bank1call OpenPlayAreaScreenForSelection
	jr c, .asm_64472
	ldh a, [hTempPlayAreaLocation_ff9d]
	ldh [hTemp_ffa0], a
	call SwapTurn
	ret

ClefairyLv15FollowMe_AISwitchDefendingPkmn:
	farcall Func_6869d
	ldh [hTemp_ffa0], a
	ret

ClefairyLv15FollowMe_AfterDamage:
	call SwapTurn
	ldh a, [hTemp_ffa0]
	ld e, a
	bank1call Func_6f49
	call nc, SwapArenaWithBenchPokemon
	call SwapTurn
	xor a
	ld [wDuelDisplayedScreen], a
	ret

WigglytuffLv40HelpingHand_InitialEffect2:
	ldh a, [hTempPlayAreaLocation_ff9d]
	ld hl, $dc
	or a
	jr z, .asm_644b3
	farcall Func_6808d
	farcall Func_6844f
	ret c
	ld a, DUELVARS_ARENA_CARD_STATUS
	get_turn_duelist_var
	or a
	ret nz
	ld hl, $be
.asm_644b3
	scf
	ret

WigglytuffLv40HelpingHand_RequireSelection:
	ld a, $ff
	ldh [hTempPlayAreaLocation_ffa1], a
	ldtx de, IfHeadsHeal1StatusOfYourActiveText
	farcall Func_68079
	jr c, .asm_644c4
	or a
	ret
.asm_644c4
	ld a, DUELVARS_ARENA_CARD_STATUS
	get_turn_duelist_var
	and $f0
	jr z, .asm_644d0
	ld a, [hl]
	and $0f
	jr nz, .asm_644d4
.asm_644d0
	xor a
	ldh [hTempPlayAreaLocation_ffa1], a
	ret
.asm_644d4
	ld a, [hl]
	and $0f
	ldtx hl, EffectTargetSleepText
	cp $02
	jr z, .asm_644e8
	ldtx hl, EffectTargetParalysisText
	cp $03
	jr z, .asm_644e8
	ldtx hl, EffectTargetConfusionText
.asm_644e8
	call LoadTxRam2
	bank1call DrawDuelMainScene
	ldtx hl, Choose1StatusToHealText
	call TwoItemHorizontalMenu
	ld e, $f0
	ldh a, [hCurScrollMenuItem]
	or a
	jr nz, .asm_644fd
	ld e, $0f
.asm_644fd
	ld a, e
	ldh [hTempPlayAreaLocation_ffa1], a
	or a
	ret

WigglytuffLv40HelpingHand_BeforeDamage:
	farcall Func_68465
	ldh a, [hTempPlayAreaLocation_ffa1]
	cp $ff
	ret z
	ld a, $8a
	call Func_67843
	ldh a, [hTempPlayAreaLocation_ffa1]
	ld e, a
	ld a, DUELVARS_ARENA_CARD_STATUS
	get_turn_duelist_var
	and e
	ld [hl], a
	bank1call DrawDuelHUDs
	ret

WigglytuffLv40Expand_BeforeDamage:
	ld a, $23
	farcall Func_68127
	ret

GolbatLv25LeechLife_AfterDamage:
	ld hl, wDealtDamage
	ld e, [hl]
	inc hl
	ld d, [hl]
	farcall ApplyAndAnimateHPRecovery
	ret

GolbatLv25Nosedive_BeforeDamage:
	ldtx de, IfTails40DamageToYourselfTooText
	farcall TossCoin_Bank1a
	ldh [hTemp_ffa0], a
	ret

GolbatLv25Nosedive_AfterDamage:
	ldh a, [hTemp_ffa0]
	or a
	ret nz
	ld a, $28
	call DealRecoilDamageToSelf
	ret

ParasLv15ScatterSpores_InitialEffect1:
	farcall Func_2435f
	ret c
	farcall Func_24369
	ret

ParasLv15ScatterSpores_RequireSelection:
	call CreateDeckCardList
	ldtx hl, ChooseAParasFromDeckText
	ldtx bc, EffectTargetParasText
	ld de, DEX_PARAS
	ld a, CARDSEARCH_POKEDEX_NUMBER
	farcall Func_24c9d
	jr c, .asm_6456a
	ldtx hl, ChooseAParasText
	ldtx de, DuelistDeckText
	farcall Func_24df8
.asm_6456a
	ldh [hTemp_ffa0], a
	ret

ParasLv15ScatterSpores_AISelection:
	ld de, DEX_PARAS
	ld a, CARDSEARCH_POKEDEX_NUMBER
	farcall SetCardSearchFuncParams
	call CreateDeckCardList
	ld hl, wDuelTempList
.asm_6457c
	ld a, [hli]
	ldh [hTemp_ffa0], a
	cp $ff
	ret z
	farcall ExecuteCardSearchFunc
	jr nc, .asm_6457c
	ret

ParasLv15ScatterSpores_AfterDamage:
	ldh a, [hTemp_ffa0]
	cp $ff
	jr z, .asm_645a8
	ldh [hTempCardIndex_ff98], a
	call SearchCardInDeckAndAddToHand
	call AddCardToHand
	call PutHandPokemonCardInPlayArea
	farcall Func_680ab
	jr c, .asm_645a8
	ldh a, [hTemp_ffa0]
	ldtx hl, PlacedOnBenchText
	bank1call DisplayCardDetailScreen
.asm_645a8
	farcall Func_680a0
	ret

ParasectLv29LeechLife_AfterDamage:
	ld hl, wDealtDamage
	ld e, [hl]
	inc hl
	ld d, [hl]
	farcall ApplyAndAnimateHPRecovery
	ret

PoliwhirlLv30Twiddle_BeforeDamage:
	ldtx de, ConfusedIfHeadsSleepIfTailsText
	farcall TossCoin_Bank1a
	jr c, .asm_645c6
	farcall Func_6805c
	ret
.asm_645c6
	farcall Func_68045
	ret

PoliwrathLv40HydroPump_BeforeDamage:
	ld bc, $300
	farcall Func_68e88
	ret

AbraLv8PsychicBeam_AI:
	ld a, $0a
	farcall Func_68175
	ret

AbraLv8PsychicBeam_RequireSelection:
	farcall Func_68686
	ret

AbraLv8PsychicBeam_AISelection:
	farcall Func_686be
	ldh [hTemp_ffa0], a
	ret

AbraLv8PsychicBeam_BeforeDamage:
	ldh a, [hTemp_ffa0]
	or a
	jr nz, .asm_645f7
	farcall Func_682a9
	ret c
	ld a, $0a
	farcall Func_68175
	ret
.asm_645f7
	xor a
	ld [wLoadedAttackAnimation], a
	ret

AbraLv8PsychicBeam_AfterDamage:
	ldh a, [hTemp_ffa0]
	or a
	ret z
	call SwapTurn
	ld b, a
	ld a, $ab
	ld [wLoadedAttackAnimation], a
	ld de, $a
	call DealDamageToPlayAreaPokemon
	call SwapTurn
	ret

GeodudeLv15Harden_BeforeDamage:
	ld a, $26
	farcall Func_68127
	ret

RapidashLv30FlameInferno_AI:
	xor a
	farcall Func_681e3
	ld de, $a32
	ld c, $0a
	cp $02
	jr nc, .asm_64630
	add a
	call ATimes10
	add $0a
	ld e, a
	ld c, a
.asm_64630
	ld a, c
	farcall Func_680dd
	ret

RapidashLv30FlameInferno_AISwitchDefendingPkmn:
	xor a
	ldh [hTemp_ffa0], a
	farcall Func_681e3
	ret c
	ld c, a
	ld a, $c8
	call GetNonTurnDuelistVariable
	cp $0a
	ret c
	ld b, $01
	cp $28
	jr c, .asm_64657
	ld b, $02
	cp $3c
	jr c, .asm_64657
	ld a, c
	cp $01
	ret z
.asm_64657
	ld hl, wDuelTempList
	ld de, hTemp_ffa0
	ld a, b
	cp c
	ret c
.asm_64660
	ld a, [hli]
	ld [de], a
	inc de
	dec b
	jr nz, .asm_64660
	ld a, $ff
	ld [de], a
	ret

RapidashLv30FlameInferno_RequireSelection:
	xor a
	ld [wAttachedEnergyMenuNumerator], a
	ld a, $01
	ldh [hffb2], a
	farcall Func_681e3
	jr c, .asm_646b1
	ldtx hl, ChooseUpTo2FireEnergyPlus20DamageForEachText
	call DrawWideTextBox_WaitForInput
	xor a
	bank1call DisplayEnergyDiscardMenu
	ld a, $02
	ld [wAttachedEnergyMenuDenominator], a
.asm_64687
	bank1call HandleAttachedEnergyMenuInput
	jr nc, .asm_64696
	ld a, $03
	farcall Func_6856d
	jr nc, .asm_646b1
	jr .asm_646ac
.asm_64696
	ld hl, wAttachedEnergyMenuNumerator
	inc [hl]
	farcall Func_24350
	ldh a, [hTempCardIndex_ff98]
	ld [hl], a
	call RemoveCardFromDuelTempList
	jr c, .asm_646b1
	ldh a, [hffb2]
	cp $03
	jr nc, .asm_646b1
.asm_646ac
	bank1call UpdateAttachedEnergyMenu
	jr .asm_64687
.asm_646b1
	farcall Func_24350
	ld [hl], $ff
	ld a, [wAttachedEnergyMenuNumerator]
	ldh [hTemp_ffa0], a
	or a
	ret

RapidashLv30FlameInferno_BeforeDamage:
	ld hl, hTempPlayAreaLocation_ffa1
.asm_646c1
	ld a, [hli]
	cp $ff
	jr z, .asm_646cb
	call Func_0ffa
	jr .asm_646c1
.asm_646cb
	ldh a, [hTemp_ffa0]
	add a
	call ATimes10
	farcall Func_68163
	ret

RapidashLv30KickAway_RequireSelection:
	farcall HandleMandatorySwitchSelection
	ldh a, [hTempPlayAreaLocation_ff9d]
	ldh [hTemp_ffa0], a
	ret

RapidashLv30KickAway_AfterDamage:
	ldh a, [hTemp_ffa0]
	farcall Func_6828a
	ret

DoduoLv8Growl_BeforeDamage:
	ld a, $17
	farcall Func_6812e
	ret

DodrioLv25TriAttack_AI:
	ld a, 30
	lb de, 0, 60
	farcall Func_680dd
	ret

DodrioLv25TriAttack_BeforeDamage:
	ld hl, $14
	call LoadTxRam3
	ldtx de, DamageCheckXDamageTimesHeadsText
	ld a, $03
	farcall Func_68069
	add a
	call ATimes10
	farcall Func_6817e
	ret

LickitungLv20Stomp_AI:
	ld a, 25
	lb de, 20, 30
	farcall Func_680dd
	ret

LickitungLv20Stomp_BeforeDamage:
	ld a, $0a
	farcall Func_682e0
	ret

ChanseyLv40DoubleSlapAlt_AI:
	ld a, 20
	lb de, 0, 40
	farcall Func_680dd
	ret

ChanseyLv40DoubleSlapAlt_BeforeDamage:
	ld hl, $14
	call LoadTxRam3
	ldtx de, DamageCheckXDamageTimesHeadsText
	ld a, $02
	farcall Func_68069
	add a
	call ATimes10
	farcall Func_6817e
	ret

MrMimeLv20DampeningShield_InitialEffect1:
	scf
	ret

MrMimeLv20Juggling_AI:
	ld a, 20
	lb de, 0, 40
	farcall Func_680dd
	ret

MrMimeLv20Juggling_BeforeDamage:
	ld hl, $a
	call LoadTxRam3
	ldtx de, DamageCheckXDamageTimesHeadsText
	ld a, $04
	farcall Func_68069
	call ATimes10
	farcall Func_6817e
	ret

PinsirLv15SlicingThrow_AI:
	ld a, 15
	lb de, 10, 20
	farcall Func_680dd
	ret

PinsirLv15SlicingThrow_BeforeDamage:
	ld a, $0a
	farcall Func_682e0
	ret

EeveeLv5Lunge_AI:
	ld a, 20
	lb de, 0, 20
	farcall Func_680dd
	ret

EeveeLv5Lunge_BeforeDamage:
	ldtx de, AttackSuccessCheckText
	farcall TossCoin_Bank1a
	ret c
	xor a
	ld [wLoadedAttackAnimation], a
	farcall Func_6817e
	farcall Func_6809a
	ret

PorygonLv18Porygon3DAttack_AI:
	ld a, 15
	lb de, 0, 30
	farcall Func_680dd
	ret

PorygonLv18Porygon3DAttack_BeforeDamage:
	ld hl, $a
	call LoadTxRam3
	ldtx de, DamageCheckXDamageTimesHeadsText
	ld a, $03
	farcall Func_68069
	call ATimes10
	farcall Func_6817e
	ret

PorygonLv18Conversion2_InitialEffect1:
	farcall Func_6aa84
	ret

PorygonLv18Conversion2_InitialEffect2:
	farcall Func_6aa94
	ret

PorygonLv18Conversion2_AISelection:
	farcall Func_6aaa0
	ret

PorygonLv18Conversion2_AfterDamage:
	farcall Func_6aac0
	ret

SnorlaxLv35Guard_InitialEffect1:
	scf
	ret

SnorlaxLv35RollOver_BeforeDamage:
	farcall Func_68055
	call SwapTurn
	farcall Func_6805c
	call SwapTurn
	ret

MewtwoLv54Psycrush_BeforeDamage:
	call SwapTurn
	ld a, DUELVARS_CARD_LOCATIONS
	get_turn_duelist_var
	ld c, $00
.asm_647e3
	ld a, [hl]
	and $10
	jr z, .asm_64801
	ld a, l
	call GetCardIDFromDeckIndex
	cp16 RAINBOW_ENERGY
	jr z, .asm_64800
	cp16 PSYCHIC_ENERGY
	jr nz, .asm_64801
.asm_64800
	inc c
.asm_64801
	inc l
	ld a, l
	cp $3c
	jr c, .asm_647e3
	call SwapTurn
	ld a, c
	call ATimes10
	farcall Func_6817e
	ret

TheRocketsTrap_InitialEffect1:
	ld a, $f4
	call GetNonTurnDuelistVariable
	or a
	ret nz
	ld hl, $e7
	scf
	ret

TheRocketsTrap_BeforeDamage:
	ldtx de, TheRocketsTrapCheckText
	farcall TossCoin_Bank1a
	ret nc
	call SwapTurn
	call CreateHandCardList
	ld hl, wDuelTempList
	call ShuffleCards
	ld a, $ff
	ld [wDuelTempList + 3], a
	ld c, a
.asm_64839
	inc c
	ld a, [hli]
	cp $ff
	jr z, .asm_64847
	call RemoveCardFromHand
	call ReturnCardToDeck
	jr .asm_64839
.asm_64847
	ld l, c
	ld h, $00
	call LoadTxRam3
	ldtx hl, ReturnedXCardsToDeckText
	call DrawWideTextBox_WaitForInput
	farcall Func_680a0
	call SwapTurn
	ret

FossilExcavation_InitialEffect1:
	farcall Func_2435f
	ret nc
	bank1call CreateDiscardPileCardList
	ret c
	call Func_64885
	ld hl, $1bd
	ccf
	ret

FossilExcavation_AISwitchDefendingPkmn:
	call CreateDeckCardList
	call Func_64885
	ld a, $00
	jr nc, .asm_64882
	bank1call CreateDiscardPileCardList
	call Func_64885
	ld a, $01
	jr nc, .asm_64882
	ld a, $ff
.asm_64882
	ldh [hTemp_ffa0], a
	ret

Func_64885:
	ld hl, wDuelTempList
.asm_64888
	ld a, [hli]
	ldh [hTempPlayAreaLocation_ffa1], a
	cp $ff
	ret z
	call GetCardIDFromDeckIndex
	cp16 MYSTERIOUS_FOSSIL
	jr nz, .asm_64888
	scf
	ret

FossilExcavation_RequireSelection:
.asm_6489d
	ldtx hl, ChooseDeckOrDiscardPileToCheckText
	call TwoItemHorizontalMenu
	ldh [hTemp_ffa0], a
	jr nc, .asm_648da
	bank1call CreateDiscardPileCardList
	jr c, .asm_6489d
	call Func_64885
	jr c, .asm_648b9
	ldtx hl, NoFossilsInDiscardPileText
	call DrawWideTextBox_WaitForInput
	jr .asm_6489d
.asm_648b9
	bank1call InitAndDrawCardListScreenLayout
	ldtx de, DuelistDiscardPileText
	ldtx hl, ChooseAFossilText
	bank1call SetCardListHeaderAndInfoText
.asm_648c5
	bank1call DisplayCardList
	jr c, .asm_648c5
	ldh [hTempPlayAreaLocation_ffa1], a
	call GetCardIDFromDeckIndex
	cp16 MYSTERIOUS_FOSSIL
	jr nz, .asm_648c5
	ret
.asm_648da
	call CreateDeckCardList
	jr c, .asm_6489d
	ldtx hl, ChooseAFossilFromDeckText
	ldtx bc, EffectTargetFossilText
	ld de, MYSTERIOUS_FOSSIL
	xor a ; CARDSEARCH_CARD_ID
	farcall Func_24c9d
	jr c, .asm_648f9
	ldtx hl, ChooseAFossilText
	ldtx de, DuelistDeckText
	farcall Func_24df8
.asm_648f9
	ldh [hTempPlayAreaLocation_ffa1], a
	ret

FossilExcavation_BeforeDamage:
	ldh a, [hTemp_ffa0]
	or a
	jr z, .asm_64914
	ldh a, [hTempPlayAreaLocation_ffa1]
	ldh [hTempCardIndex_ff98], a
	call MoveDiscardPileCardToHand
	call AddCardToHand
	farcall Func_680ab
	ret c
	bank1call DisplayPlayerDrawCardScreen
	ret
.asm_64914
	ldh a, [hTempPlayAreaLocation_ffa1]
	ldh [hTempCardIndex_ff98], a
	cp $ff
	jr z, .asm_6492b
	call SearchCardInDeckAndAddToHand
	call AddCardToHand
	farcall Func_680ab
	jr c, .asm_6492b
	bank1call DisplayPlayerDrawCardScreen
.asm_6492b
	farcall Func_680a0
	ret

MoonStone_InitialEffect1:
	farcall Func_2435f
	ret

MoonStone_AISelection:
	ld a, $ff
	ldh [hTemp_ffa0], a
	ret

MoonStone_RequireSelection:
	call CreateDeckCardList
	ldtx hl, ChooseAColorlessEvolutionCardText
	ldtx bc, EffectTargetColorlessEvolutionCardText
	ld a, CARDSEARCH_EVOLUTION_COLORLESS_POKEMON
	farcall Func_24c9d
	jr c, .asm_64955
	ldtx hl, ChooseAColorlessEvolutionPokemonText
	ldtx de, DuelistDeckText
	farcall Func_24df8
.asm_64955
	ldh [hTemp_ffa0], a
	ret

MoonStone_BeforeDamage:
	ldh a, [hTemp_ffa0]
	cp $ff
	jr z, .asm_64972
	call SearchCardInDeckAndAddToHand
	call AddCardToHand
	farcall Func_680ab
	jr c, .asm_64972
	ldh a, [hTemp_ffa0]
	ldtx hl, WasPlacedInTheHandText
	bank1call DisplayCardDetailScreen
.asm_64972
	farcall Func_680a0
	ret

MaxRevive_InitialEffect1:
	farcall Func_24369
	ret c
	farcall Func_6837a
	ret c
	bank1call CreateEnergyCardListFromHand
	ld hl, $ed
	cp $02
	ret

MaxRevive_InitialEffect2:
	ldtx hl, Choose2EnergyCardsFromHandToDiscardText
	ld de, $204
	push de
	call DrawWideTextBox_WaitForInput
	bank1call CreateEnergyCardListFromHand
	xor a
	ldh [hffb2], a
	pop hl
.asm_6499b
	push hl
	bank1call Func_5221
	pop hl
	bank1call SetCardListInfoBoxText
	push hl
	bank1call DisplayCardList
	pop hl
	jr c, .asm_649d7
	push hl
	farcall Func_24350
	ldh a, [hTempCardIndex_ff98]
	ld [hl], a
	call RemoveCardFromDuelTempList
	pop hl
	ldh a, [hffb2]
	cp $02
	jr c, .asm_6499b
	farcall Func_6837a
	bank1call Func_5221
	ldtx hl, PleaseSelectCardText
	ldtx de, DuelistDiscardPileText
	bank1call SetCardListHeaderAndInfoText
	bank1call DisplayCardList
	jr c, .asm_649d7
	ldh a, [hTempCardIndex_ff98]
	ldh [hTempRetreatCostCards], a
	or a
	ret
.asm_649d7
	scf
	ret

MaxRevive_BeforeDamage:
	ld hl, hTemp_ffa0
	ld a, [hli]
	call RemoveCardFromHand
	call PutCardInDiscardPile
	ld a, [hli]
	call RemoveCardFromHand
	call PutCardInDiscardPile
	ld a, [hl]
	call MoveDiscardPileCardToHand
	call AddCardToHand
	call PutHandPokemonCardInPlayArea
	farcall Func_680ab
	jr c, .asm_64a02
	ldh a, [hTempRetreatCostCards]
	ldtx hl, PlacedOnBenchText
	bank1call DisplayCardDetailScreen
.asm_64a02
	ret

MasterBall_InitialEffect1:
	farcall Func_2435f
	ret

MasterBall_RequireSelection:
	ld c, $07
	ld a, DUELVARS_NUMBER_OF_CARDS_NOT_IN_DECK
	get_turn_duelist_var
	ld a, $3c
	sub [hl]
	cp c
	jr nc, .asm_64a14
	ld c, a
.asm_64a14
	ld de, wDuelTempList
	ld a, [hl]
	add $7e
	ld l, a
.asm_64a1b
	ld a, [hli]
	ld [de], a
	inc de
	dec c
	jr nz, .asm_64a1b
	ld a, $ff
	ld [de], a
	bank1call Func_5221
	ldtx hl, ChooseBasicOrEvolutionCardText
	ldtx de, DuelistDeckText
	bank1call SetCardListHeaderAndInfoText
.asm_64a30
	bank1call DisplayCardList
	jr c, .asm_64a3e
	ldh [hTemp_ffa0], a
	call Func_64a6b
	jr c, .asm_64a30
.asm_64a3c
	or a
	ret
.asm_64a3e
	ld hl, wDuelTempList
.asm_64a41
	ld a, [hli]
	ldh [hTemp_ffa0], a
	cp $ff
	jr z, .asm_64a3c
	call Func_64a6b
	jr nc, .asm_64a30
	jr .asm_64a41

MasterBall_BeforeDamage:
	ldh a, [hTemp_ffa0]
	cp $ff
	jr z, .asm_64a66
	call SearchCardInDeckAndAddToHand
	call AddCardToHand
	ldh [hTempCardIndex_ff98], a
	farcall Func_680ab
	jr c, .asm_64a66
	bank1call DisplayPlayerDrawCardScreen
.asm_64a66
	farcall Func_680a0
	ret

Func_64a6b:
	call LoadCardDataToBuffer2_FromDeckIndex
	ld a, [wLoadedCard2Type]
	cp $08
	ccf
	ret

PokemonRecall_InitialEffect1:
	jr Func_64aa4

PokemonRecall_InitialEffect2:
	call Func_64aa4
	bank1call Func_5221
	ldtx hl, PleaseSelectCardText
	ldtx de, DuelistDiscardPileText
	bank1call SetCardListHeaderAndInfoText
	bank1call DisplayCardList
	ldh a, [hTempCardIndex_ff98]
	ldh [hTemp_ffa0], a
	ret

PokemonRecall_BeforeDamage:
	ldh a, [hTemp_ffa0]
	call MoveDiscardPileCardToHand
	call ReturnCardToDeck
	farcall Func_680ab
	ret c
	ldtx hl, CardWasChosenText
	ldh a, [hTemp_ffa0]
	bank1call DisplayCardDetailScreen
	ret

Func_64aa4:
	bank1call IsBlackHoleRuleActive
	ret c
	ld a, DUELVARS_NUMBER_OF_CARDS_IN_DISCARD_PILE
	get_turn_duelist_var
	ld b, a
	add $7e
	ld l, a
	ld de, wDuelTempList
	inc b
	jr .asm_64ac9
.asm_64ab5
	ld a, [hl]
	call LoadCardDataToBuffer2_FromDeckIndex
	ld a, [wLoadedCard2Type]
	cp $08
	jr nc, .asm_64ac9
	ld a, [wLoadedCard2Stage]
	or a
	jr z, .asm_64ac9
	ld a, [hl]
	ld [de], a
	inc de
.asm_64ac9
	dec l
	dec b
	jr nz, .asm_64ab5
	ld a, $ff
	ld [de], a
	ld a, [wDuelTempList]
	cp $ff
	jr z, .asm_64ad9
	or a
	ret
.asm_64ad9
	ld hl, $e8
	scf
	ret

BillsComputer_InitialEffect1:
	ld hl, $ec
	scf
	ret

ComputerError_InitialEffect1:
	farcall Func_2435f
	ret nc
	call SwapTurn
	farcall Func_2435f
	call SwapTurn
	ret

ComputerError_RequireSelection:
	farcall Func_24b83
	ldh [hTemp_ffa0], a
	call Func_64aff
	ldh [hTempPlayAreaLocation_ffa1], a
	ret

Func_64aff:
	ld a, $f6
	call GetNonTurnDuelistVariable
	cp $01
	jr z, .asm_64b21
	cp $00
	jr z, .asm_64b16
	call SwapTurn
	call Func_2972
	call SwapTurn
	ret
.asm_64b16
	call SwapTurn
	farcall Func_24b83
	call SwapTurn
	ret
.asm_64b21
	ld a, $1a
	call SetOppAction_SerialSendDuelData
.asm_64b26
	call SerialRecvByte
	jr nc, .asm_64b2f
	halt
	nop
	jr .asm_64b26
.asm_64b2f
	ret

ComputerError_BeforeDamage:
	ldh a, [hTempCardIndex_ff9f]
	call RemoveCardFromHand
	ldh a, [hTemp_ffa0]
	call Func_64b4b
	call SwapTurn
	ldh a, [hTempPlayAreaLocation_ffa1]
	call Func_64b4b
	call SwapTurn
	ld a, $01
	ld [wcd09], a
	ret

Func_64b4b:
	or a
	ret z
	push af
	farcall DisplayDrawNCardsScreen
	pop af
	ld c, a
.asm_64b54
	call DrawCardFromDeck
	ldh [hTempCardIndex_ff98], a
	call AddCardToHand
	farcall Func_680ab
	jr nc, .asm_64b67
	push bc
	bank1call DisplayPlayerDrawCardScreen
	pop bc
.asm_64b67
	dec c
	jr nz, .asm_64b54
	ret

SpearowLv12FuryAttack_AI:
	ld a, 20
	lb de, 0, 40
	farcall Func_680dd
	ret

SpearowLv12FuryAttack_BeforeDamage:
	ld hl, $a
	call LoadTxRam3
	ldtx de, DamageCheckXDamageTimesHeadsText
	ld a, $02
	farcall Func_68069
	call ATimes10
	farcall Func_6817e
	ret

FearowLv24QuickAttack_AI:
	ld a, 20
	lb de, 10, 30
	farcall Func_680dd
	ret

FearowLv24QuickAttack_BeforeDamage:
	ld a, $14
	farcall Func_682e0
	ret

FearowLv24DrillDescent_AI:
	ld a, 50
	lb de, 0, 50
	farcall Func_680dd
	ret

FearowLv24DrillDescent_BeforeDamage:
	ldtx de, AttackSuccessCheckText
	farcall TossCoin_Bank1a
	ret c
	xor a
	ld [wLoadedAttackAnimation], a
	farcall Func_6817e
	farcall Func_6809a
	ret

RaichuLv32ShortCircuit_InitialEffect1:
	call SwapTurn
	ld a, DUELVARS_CARD_LOCATIONS
	get_turn_duelist_var
.asm_64bc2
	bit 4, [hl]
	jr z, .asm_64bde
	ld a, l
	call GetCardIDFromDeckIndex
	cp16 WATER_ENERGY
	jr z, .asm_64bec
	cp16 RAINBOW_ENERGY
	jr z, .asm_64bec
.asm_64bde
	inc l
	ld a, l
	cp $3c
	jr c, .asm_64bc2
	call SwapTurn
	ld hl, $21b
	scf
	ret
.asm_64bec
	call SwapTurn
	or a
	ret

RaichuLv32ShortCircuit_RequireSelection:
	ldtx hl, ChoosePokemonWithWaterEnergyText
	call DrawWideTextBox_WaitForInput
	call SwapTurn
	bank1call HasAlivePokemonInPlayArea
.asm_64bfd
	bank1call OpenPlayAreaScreenForSelection
	jr c, .asm_64bfd
	ldh a, [hTempPlayAreaLocation_ff9d]
	ldh [hTemp_ffa0], a
	call Func_64c7c
	or a
	jr z, .asm_64bfd
	call SwapTurn
	ret

RaichuLv32ShortCircuit_AISelection:
	call SwapTurn
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	ld hl, wce02
	ld de, $0
	ld c, a
	ld b, $00
.asm_64c1f
	push hl
	push de
	push bc
	ld a, b
	call Func_64c7c
	pop bc
	pop de
	pop hl
	ld [hli], a
	cp d
	jr nc, .asm_64c2f
	ld d, a
	ld e, b
.asm_64c2f
	inc b
	dec c
	jr nz, .asm_64c1f
	ld a, e
	ldh [hTemp_ffa0], a
	call SwapTurn
	ret

RaichuLv32ShortCircuit_BeforeDamage:
	ldh a, [hTemp_ffa0]
	or a
	jr nz, .asm_64c56
	farcall Func_682a9
	ret c
	call SwapTurn
	xor a
	call Func_64c7c
	call SwapTurn
	call ATimes10
	farcall Func_68175
	ret
.asm_64c56
	xor a
	ld [wLoadedAttackAnimation], a
	ret

RaichuLv32ShortCircuit_AfterDamage:
	ldh a, [hTemp_ffa0]
	or a
	ret z
	ld a, $9b
	ld [wLoadedAttackAnimation], a
	call SwapTurn
	ldh a, [hTemp_ffa0]
	call Func_64c7c
	call ATimes10
	ld e, a
	ld d, $00
	ldh a, [hTemp_ffa0]
	ld b, a
	call DealDamageToPlayAreaPokemon
	call SwapTurn
	ret

Func_64c7c:
	or $10
	ld [wce01], a
	ld a, $0b
	farcall Func_681ec
	ret

SandshrewLv15Swift_AI:
	ld de, $14
	jr Func_64c9d

SandshrewLv15Swift_BeforeDamage:
	call SandshrewLv15Swift_AI
	jr Func_64cb9

SandshrewLv15Swift_AfterDamage:
	call SandshrewLv15Swift_AI
	jr Func_64cd1

Func_64c97:
	ld a, DUELVARS_ARENA_CARD_LAST_TURN_DAMAGE
	get_turn_duelist_var
	ld e, a
	inc hl
	ld d, [hl]

Func_64c9d:
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

Func_64cb6:
	call Func_64c97
;   fallthrough

Func_64cb9:
	ld a, $db
	call Func_67843
	xor a
	ld [wLoadedAttackAnimation], a
	farcall Func_6817e
	ld a, $fd
	call GetNonTurnDuelistVariable
	ld [hl], $04
	ret

Func_64cce:
	call Func_64c97
;   fallthrough

Func_64cd1:
	ld hl, wDealtDamage
	ld a, e
	add [hl]
	ld [hli], a
	ld a, d
	adc [hl]
	ld [hl], a
	ld a, $c8
	call GetNonTurnDuelistVariable
	call SubtractHP
	call PrintKnockedOutIfHLZero
	ret

VenomothLv22StirUpTwister_AISelection:
	farcall HandleMandatorySwitchSelection
	ldh a, [hTempPlayAreaLocation_ff9d]
	ldh [hTemp_ffa0], a
	farcall Func_68446
	ld c, a
	ld a, $ff
	jr c, .asm_64cfd
	ld a, c
	dec a
	call Random
	inc a
.asm_64cfd
	ldh [hTempPlayAreaLocation_ffa1], a
	ret

VenomothLv22StirUpTwister_RequireSelection:
	farcall HandleMandatorySwitchSelection
	ldh a, [hTempPlayAreaLocation_ff9d]
	ldh [hTemp_ffa0], a
	cp $ff
	jr z, .asm_64d1e
	farcall Func_680ab
	jr nc, .asm_64d1e
	call SwapTurn
	ldh a, [hTemp_ffa0]
	farcall Func_680ed
	call SwapTurn
.asm_64d1e
	call SwapTurn
	farcall HandleMandatorySwitchSelection
	call SwapTurn
	ldh a, [hTempPlayAreaLocation_ff9d]
	ldh [hTempPlayAreaLocation_ffa1], a
	ret

VenomothLv22StirUpTwister_AfterDamage:
	ldh a, [hTemp_ffa0]
	farcall Func_6828a
	ldh a, [hTempPlayAreaLocation_ffa1]
	cp $ff
	ret z
	ldh a, [hTemp_ffa0]
	add $c8
	call GetNonTurnDuelistVariable
	or a
	jr nz, .asm_64d49
	ld a, [wcd0b]
	cp $1b
	jr z, .asm_64d52
.asm_64d49
	ldh a, [hTempPlayAreaLocation_ffa1]
	ld [wcd0a], a
	ld e, a
	call SwapArenaWithBenchPokemon
.asm_64d52
	xor a
	ld [wDuelDisplayedScreen], a
	ret

VenomothLv22RainbowPowder_BeforeDamage:
	ldtx de, ParalyzedIfHeadsPoisonedIfTailsText
	farcall TossCoin_Bank1a
	jr c, .asm_64d65
	farcall Func_68012
	ret
.asm_64d65
	farcall Func_6802e
	ret

MachopLv18FocusedOneShot_BeforeDamage:
	ldtx de, FocusedOneShotCheckText
	farcall TossCoin_Bank1a
	jr c, .asm_64d7f
	ld a, $2d
	farcall Func_6846d
	ld a, $ed
	ld [wLoadedAttackAnimation], a
	ret
.asm_64d7f
	ld a, $1e
	farcall Func_6810e
	ret

MachopLv18CorkscrewPunch_InitialEffect1:
	ld a, $2d
	farcall Func_68478
	ret

MachokeLv28SteadyPunch_AI:
	ld a, 40
	lb de, 30, 50
	farcall Func_680dd
	ret

MachokeLv28SteadyPunch_BeforeDamage:
	ld a, $14
	farcall Func_682e0
	ret

GravelerLv28StoneBarrageAlt_AI:
	ld a, 20
	lb de, 0, 100
	farcall Func_680dd
	ret

GravelerLv28StoneBarrageAlt_BeforeDamage:
	xor a
	ldh [hTemp_ffa0], a
.asm_64dab
	ldtx de, FlipUntilTails20DamageTimesHeadsText
	xor a
	farcall Func_68069
	jr nc, .asm_64dbb
	ld hl, hTemp_ffa0
	inc [hl]
	jr .asm_64dab
.asm_64dbb
	ldh a, [hTemp_ffa0]
	ld l, a
	ld h, $14
	call HtimesL
	ld de, wDamage
	ld a, l
	ld [de], a
	inc de
	ld a, h
	ld [de], a
	ret

GravelerLv28Earthquake_AfterDamage:
	farcall Func_6806e
	ld a, $0a
	farcall Func_680f9
	farcall Func_68074
	ret

MagnemiteLv15MagnetMove_InitialEffect2:
	farcall Func_6808d
	farcall Func_6844f
	ret c
	farcall Func_2435f
	ret c
	farcall Func_24369
	ret

MagnemiteLv15MagnetMove_RequireSelection:
	ldtx de, MagnetCheckText
	farcall Func_68079
	ldh [hTempPlayAreaLocation_ffa1], a
	jr c, .asm_64e05
	farcall Func_6809a
	call Func_19e1
	call WaitForWideTextBoxInput
	or a
	ret
.asm_64e05
	call CreateDeckCardList
	ldtx hl, ChooseAMagnemiteFromDeckText
	ldtx bc, EffectTargetMagnemiteText
	ld de, DEX_MAGNEMITE
	ld a, CARDSEARCH_POKEDEX_NUMBER
	farcall Func_24c9d
	jr c, .asm_64e23
	ldtx hl, ChooseAMagnemiteText
	ldtx de, DuelistDeckText
	farcall Func_24df8
.asm_64e23
	ldh [hTempRetreatCostCards], a
	or a
	ret

MagnemiteLv15MagnetMove_AISelection:
	ldtx de, MagnetCheckText
	farcall Func_68079
	ldh [hTempPlayAreaLocation_ffa1], a
	ret nc
	ld de, DEX_MAGNEMITE
	ld a, CARDSEARCH_POKEDEX_NUMBER
	farcall SetCardSearchFuncParams
	call CreateDeckCardList
	ld hl, wDuelTempList
.asm_64e40
	ld a, [hli]
	ldh [hTempRetreatCostCards], a
	cp $ff
	ret z
	farcall ExecuteCardSearchFunc
	jr nc, .asm_64e40
	ret

MagnemiteLv15MagnetMove_BeforeDamage:
	farcall Func_68465
	ldh a, [hTempPlayAreaLocation_ffa1]
	or a
	ret z
	ldh a, [hTempRetreatCostCards]
	cp $ff
	jr z, .asm_64e72
	call SearchCardInDeckAndAddToHand
	call AddCardToHand
	call PutHandPokemonCardInPlayArea
	farcall Func_680ab
	jr c, .asm_64e72
	ldh a, [hTempRetreatCostCards]
	ldtx hl, PlacedOnBenchText
	bank1call DisplayCardDetailScreen
.asm_64e72
	farcall Func_680a0
	ret

MagnemiteLv15Superconductivity_AI:
	ld a, $0a
	farcall Func_68175
	ret

MagnemiteLv15Superconductivity_AISelection:
	farcall Func_686be
	ldh [hTemp_ffa0], a
	ret

MagnemiteLv15Superconductivity_RequireSelection:
	farcall Func_68686
	ret

MagnemiteLv15Superconductivity_BeforeDamage:
	ldh a, [hTemp_ffa0]
	or a
	jr nz, .asm_64e9b
	farcall Func_682a9
	ret c
	ld a, $0a
	farcall Func_68175
	ret
.asm_64e9b
	xor a
	ld [wLoadedAttackAnimation], a
	ret

MagnemiteLv15Superconductivity_AfterDamage:
	ldh a, [hTemp_ffa0]
	or a
	ret z
	call SwapTurn
	ld b, a
	ld a, $dc
	ld [wLoadedAttackAnimation], a
	ld de, $a
	call DealDamageToPlayAreaPokemon
	call SwapTurn
	ret

MagnetonLv30Microwave_InitialEffect1:
	farcall Func_6808d
	ret

MagnetonLv30Microwave_AI:
	ld a, $14
	farcall Func_68175
	ret

MagnetonLv30Microwave_AISelection:
	farcall Func_686be
	ldh [hTemp_ffa0], a
	call SwapTurn
	call CreateArenaOrBenchEnergyCardList
	ldh [hTempPlayAreaLocation_ffa1], a
	call SwapTurn
	ret c
	ldtx de, IfHeadsDiscard1EnergyCardText
	farcall Func_68079
	ldh [hTempPlayAreaLocation_ffa1], a
	ret nc
	call SwapTurn
	ldh a, [hTemp_ffa0]
	call CreateArenaOrBenchEnergyCardList
	call SwapTurn
	ld a, [wDuelTempList]
	ldh [hTempRetreatCostCards], a
	ret

MagnetonLv30Microwave_RequireSelection:
	farcall Func_68686
	call SwapTurn
	call CreateArenaOrBenchEnergyCardList
	ldh [hTempPlayAreaLocation_ffa1], a
	call SwapTurn
	ret c
	ldtx de, IfHeadsDiscard1EnergyCardText
	farcall Func_68079
	ldh [hTempPlayAreaLocation_ffa1], a
	ret nc
	call SwapTurn
	ldh a, [hTemp_ffa0]
	bank1call DisplayEnergyDiscardMenu
.asm_64f12
	bank1call HandleAttachedEnergyMenuInput
	jr c, .asm_64f12
	call SwapTurn
	ldh a, [hTempCardIndex_ff98]
	ldh [hTempRetreatCostCards], a
	ret

MagnetonLv30Microwave_BeforeDamage:
	ldh a, [hTemp_ffa0]
	or a
	jr nz, .asm_64f30
	farcall Func_682a9
	ret c
	ld a, $14
	farcall Func_68175
	ret
.asm_64f30
	xor a
	ld [wLoadedAttackAnimation], a
	ret

MagnetonLv30Microwave_AfterDamage:
	ldh a, [hTemp_ffa0]
	or a
	jr z, .asm_64f4e
	call SwapTurn
	ld a, $93
	ld [wLoadedAttackAnimation], a
	ldh a, [hTemp_ffa0]
	ld b, a
	ld de, $14
	call DealDamageToPlayAreaPokemon
	call SwapTurn
.asm_64f4e
	ldh a, [hTempPlayAreaLocation_ffa1]
	or a
	ret z
	call SwapTurn
	ldh a, [hTemp_ffa0]
	ld e, a
	bank1call Func_6f49
	jr c, .asm_64f62
	ldh a, [hTempRetreatCostCards]
	call Func_0ffa
.asm_64f62
	call SwapTurn
	ldh a, [hTemp_ffa0]
	or a
	ret nz
	ld a, $fd
	call GetNonTurnDuelistVariable
	ld [hl], $01
	ret

SeelLv10Growl_BeforeDamage:
	ld a, $17
	farcall Func_6812e
	ret

DewgongLv24Rest_BeforeDamage:
	ld a, DUELVARS_ARENA_CARD_STATUS
	get_turn_duelist_var
	ld [hl], $00
	call SwapTurn
	farcall Func_6805c
	call SwapTurn
	ret

DewgongLv24Rest_AfterDamage:
	ld e, $00
	call GetCardDamageAndMaxHP
	ld e, a
	ld d, $00
	farcall ApplyAndAnimateHPRecovery
	ret

ShellderLv16WaterSpout_BeforeDamage:
	ld bc, $101
	farcall Func_68e88
	ret

OnixLv25RockSeal_BeforeDamage:
	ldtx de, IfHeadsOpponentCannotRetreatText
	farcall TossCoin_Bank1a
	ret nc
	ld a, $0e
	farcall Func_6812e
	ret

VoltorbLv8GroupSpark_BeforeDamage:
	ld e, $00
	call Func_64fc3
	call SwapTurn
	call Func_64fc3
	call SwapTurn
	ld a, e
	call ATimes10
	farcall Func_68163
	ret

Func_64fc3:
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	ld b, a
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
.asm_64fca
	ld a, [hli]
	cp $ff
	jr z, .asm_64fd9
	call LoadCardDataToBuffer1_FromDeckIndex
	ld a, [wLoadedCard1PokedexNumber]
	cp $64
	jr nz, .asm_64fda
.asm_64fd9
	inc e
.asm_64fda
	dec b
	jr nz, .asm_64fca
	ret

HitmonleeLv23DoubleKick_AI:
	ld a, 30
	lb de, 0, 60
	farcall Func_680dd
	ret

HitmonleeLv23DoubleKick_BeforeDamage:
	ld hl, $1e
	call LoadTxRam3
	ldtx de, DamageCheckXDamageTimesHeadsText
	ld a, $02
	farcall Func_68069
	ld e, a
	add a
	add e
	call ATimes10
	farcall Func_6817e
	ret

HitmonchanLv23MatchPunch_InitialEffect1:
	farcall Func_6808d
	ret

HitmonchanLv23MatchPunch_AISelection:
	xor a
	ldh [hTemp_ffa0], a
	farcall Func_6843b
	ret c
	ldtx de, IfHeads10DamageToBenchText
	farcall Func_68079
	ldh [hTemp_ffa0], a
	ret nc
	farcall Func_6869d
	ldh [hTempPlayAreaLocation_ffa1], a
	ret

HitmonchanLv23MatchPunch_RequireSelection:
	xor a
	ldh [hTemp_ffa0], a
	farcall Func_6843b
	ret c
	ldtx de, IfHeads10DamageToBenchText
	farcall Func_68079
	ldh [hTemp_ffa0], a
	ret nc
	ldtx hl, ChooseBenchedPokemonToGiveDamageText
	call DrawWideTextBox_WaitForInput
	call SwapTurn
	bank1call HasAlivePokemonInBench
	ld a, $ff
	jr c, .asm_65047
.asm_65042
	bank1call OpenPlayAreaScreenForSelection
	jr c, .asm_65042
.asm_65047
	ldh [hTempPlayAreaLocation_ffa1], a
	call SwapTurn
	ret

HitmonchanLv23MatchPunch_AfterDamage:
	ldh a, [hTemp_ffa0]
	or a
	ret z
	ldh a, [hTempPlayAreaLocation_ffa1]
	cp $ff
	ret z
	call SwapTurn
	ld b, a
	ld de, $a
	call DealDamageToPlayAreaPokemon_RegularAnim
	call SwapTurn
	ret

OmanyteLv20PrehistoricDream_InitialEffect2:
	farcall Func_6844f
	ret

OmanyteLv20PrehistoricDream_BeforeDamage:
	farcall Func_68465
	ldtx de, PrehistoricDreamCheckText
	farcall TossCoin_Bank1a
	ret nc
	ld hl, wcc1a
	inc [hl]
	ret

KabutoLv22Fossilize_InitialEffect2:
	farcall Func_6808d
	farcall Func_6844f
	ret

KabutoLv22Fossilize_RequireSelection:
	ld a, $ff
	ldh [hTempPlayAreaLocation_ffa1], a
	ldtx de, FossilizeCheckText
	farcall Func_68079
	jr c, .asm_6509c
	farcall Func_6809a
	call Func_19e1
	call WaitForWideTextBoxInput
	or a
	ret
.asm_6509c
	ldtx hl, ChoosePokemonEvolvingFromFossilText
	call DrawWideTextBox_WaitForInput
	bank1call HasAlivePokemonInPlayArea
.asm_650a5
	bank1call OpenPlayAreaScreenForSelection
	jr c, .asm_650a5
	add DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call Func_65102
	jr c, .asm_650a5
	ldh a, [hTempPlayAreaLocation_ff9d]
	ldh [hTempPlayAreaLocation_ffa1], a
	or a
	ret

KabutoLv22Fossilize_BeforeDamage:
	farcall Func_68465
	ldh a, [hTempPlayAreaLocation_ffa1]
	cp $ff
	ret z
	ldh a, [hTempPlayAreaLocation_ffa1]
	ldh [hTempPlayAreaLocation_ff9d], a
	add DUELVARS_ARENA_CARD
	get_turn_duelist_var
	push hl
	bank1call GetCardOneStageBelow
	ld a, e
	call AddCardToHand
	ld a, d
	farcall Func_68525
	pop hl
	ld a, [hl]
	bank1call GetCardOneStageBelow
	jr c, .asm_650e5
	ld a, e
	call AddCardToHand
	ld a, d
	farcall Func_68525
.asm_650e5
	farcall Func_68556
	ldh a, [hTempPlayAreaLocation_ffa1]
	call PrintPlayAreaCardKnockedOutIfNoHP
	farcall Func_680ab
	jr c, .asm_650fe
	xor a
	ld [wDuelDisplayedScreen], a
	ldh a, [hTempPlayAreaLocation_ffa1]
	farcall Func_680ed
.asm_650fe
	bank1call Func_6518
	ret

Func_65102:
	call LoadCardDataToBuffer2_FromDeckIndex
	ld a, [wLoadedCard2PokedexNumber]
	cp $8a
	jr c, .asm_65112
	cp $8f
	jr nc, .asm_65112
	or a
	ret
.asm_65112
	scf
	ret

KabutoLv22SharpClaws_AI:
	ld a, 30
	lb de, 10, 40
	farcall Func_680dd
	ret

KabutoLv22SharpClaws_BeforeDamage:
	ld a, $1e
	farcall Func_682e0
	ret

AerodactylLv30TailspinAttack_AfterDamage:
	farcall Func_6806e
	ld b, $00
	ld de, $a
	call DealDamageToPlayAreaPokemon_RegularAnim
	farcall Func_68074
	ret

ArticunoLv34AuroraVeil_InitialEffect1:
	scf
	ret

ZapdosLv28RagingThunder_InitialEffect1:
	farcall Func_6808d
	ret

ZapdosLv28RagingThunder_AISelection:
	ldtx de, IfTails30DamageTo1OfYourPokemonText
	farcall Func_68079
	ldh [hTemp_ffa0], a
	ret c
	xor a
	ldh [hTemp_ffa0], a
	farcall Func_68446
	ret c
	ld c, a
	ld b, $00
	ld a, DUELVARS_ARENA_CARD_HP
	get_turn_duelist_var
	ld de, $0
.asm_65158
	ld a, [hl]
	cp d
	jr c, .asm_6515e
	ld d, a
	ld e, b
.asm_6515e
	inc hl
	inc b
	dec c
	jr nz, .asm_65158
	ld a, e
	ldh [hTempPlayAreaLocation_ffa1], a
	ret

ZapdosLv28RagingThunder_RequireSelection:
	ldtx de, IfTails30DamageTo1OfYourPokemonText
	farcall Func_68079
	ldh [hTemp_ffa0], a
	ret c
	bank1call HasAlivePokemonInPlayArea
	ldtx hl, ChoosePokemonToGiveDamageText
	call DrawWideTextBox_WaitForInput
.asm_6517a
	bank1call OpenPlayAreaScreenForSelection
	jr c, .asm_6517a
	ldh [hTempPlayAreaLocation_ffa1], a
	ret

ZapdosLv28RagingThunder_AfterDamage:
	ldh a, [hTemp_ffa0]
	or a
	ret nz
	farcall Func_6806e
	ldh a, [hTempPlayAreaLocation_ffa1]
	ld b, a
	ld de, $1e
	call DealDamageToPlayAreaPokemon_RegularAnim
	ret

ZapdosLv28ThunderCrash_AI:
	ld a, 60
	lb de, 50, 70
	farcall Func_680dd
	ret

ZapdosLv28ThunderCrash_BeforeDamage:
	ldtx de, Plus20DamageIfHeads20DamageToYourselfIfTailsText
	farcall TossCoin_Bank1a
	ldh [hTemp_ffa0], a
	ret nc
	ld a, $14
	farcall Func_68163
	ret

ZapdosLv28ThunderCrash_AfterDamage:
	ldh a, [hTemp_ffa0]
	or a
	ret nz
	ld a, $14
	call DealRecoilDamageToSelf
	ret

MoltresLv37DryUp_InitialEffect1:
	farcall Func_6808d
	call SwapTurn
	ld a, DUELVARS_CARD_LOCATIONS
	get_turn_duelist_var
.asm_651c3
	ld a, [hl]
	and $10
	jr z, .asm_651e0
	ld a, l
	call GetCardIDFromDeckIndex
	cp16 WATER_ENERGY
	jr z, .asm_651ee
	cp16 RAINBOW_ENERGY
	jr z, .asm_651ee
.asm_651e0
	inc l
	ld a, l
	cp $3c
	jr c, .asm_651c3
	call SwapTurn
	ld hl, $ee
	scf
	ret
.asm_651ee
	call SwapTurn
	or a
	ret

MoltresLv37DryUp_InitialEffect2:
	ldtx hl, ChoosePokemonToRemoveWaterEnergyFromText
	call DrawWideTextBox_WaitForInput
	call SwapTurn
	bank1call HasAlivePokemonInPlayArea
.asm_651ff
	bank1call OpenPlayAreaScreenForSelection
	ldh [hTemp_ffa0], a
	jr c, .asm_6520c
	call Func_64c7c
	or a
	jr z, .asm_651ff
.asm_6520c
	call SwapTurn
	ret

MoltresLv37DryUp_RequireSelection:
	jr Func_65237

MoltresLv37DryUp_AISelection:
	jp Func_65297

MoltresLv37DryUp_AISwitchDefendingPkmn:
    jp Func_652d9

MoltresLv37DryUp_BeforeDamage:
	jp Func_65307

MoltresLv37DryUp_AfterDamage:
	jp Func_65323

Func_6521e:
	farcall Func_6808d
	call SwapTurn
	xor a
	call Func_64c7c
	call SwapTurn
	or a
	ret nz
	ld hl, $21b
	scf
	ret

Func_65233:
	xor a
	ldh [hTemp_ffa0], a
	ret

Func_65237:
	call SwapTurn
	ld a, $01
	ldh [hffb2], a
	ldh a, [hTemp_ffa0]
	call Func_64c7c
	call SwapTurn
	ldh [hTempRetreatCostCards], a
	call Func_6534e
	ldh [hTempPlayAreaLocation_ffa1], a
	or a
	jr z, .asm_65290
	call SwapTurn
	ldh a, [hTemp_ffa0]
	bank1call DisplayEnergyDiscardMenu
	ldh a, [hTempPlayAreaLocation_ffa1]
	ld hl, hTempRetreatCostCards
	cp [hl]
	jr c, .asm_65261
	ld a, [hl]
.asm_65261
	ld [wAttachedEnergyMenuDenominator], a
	xor a
	ld [wAttachedEnergyMenuNumerator], a
.asm_65268
	bank1call HandleAttachedEnergyMenuInput
	jr c, .asm_65268
	farcall Func_24350
	ldh a, [hTempCardIndex_ff98]
	ld [hl], a
	call RemoveCardFromDuelTempList
	ld hl, wAttachedEnergyMenuNumerator
	inc [hl]
	ld a, [hl]
	ld hl, wAttachedEnergyMenuDenominator
	cp [hl]
	jr nc, .asm_6528d
	ldh a, [hffb2]
	cp $0f
	jr nc, .asm_6528d
	bank1call UpdateAttachedEnergyMenu
	jr .asm_65268
.asm_6528d
	call SwapTurn
.asm_65290
	farcall Func_24350
	ld [hl], $ff
	ret

Func_65297:
	call SwapTurn
	bank1call CheckArticunoAuroraVeil
	ld e, $00
	jr c, .asm_652d2
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	ld c, a
	ld b, $00
	ld de, $0
	push bc
	push de
	bank1call HandleNoDamageOrEffectSubstatus
	pop de
	pop bc
	jr c, .asm_652ce
	push bc
	push de
	xor a
	call Func_64c7c
	pop de
	pop bc
	jr z, .asm_652c1
	ld e, $00
	jr .asm_652d2
.asm_652c1
	push de
	push bc
	ld a, b
	call Func_64c7c
	pop bc
	pop de
	cp d
	jr c, .asm_652ce
	ld d, a
	ld e, b
.asm_652ce
	inc b
	dec c
	jr nz, .asm_652c1
.asm_652d2
	call SwapTurn
	ld a, e
	ldh [hTemp_ffa0], a
	ret

Func_652d9:
	call SwapTurn
	ldh a, [hTemp_ffa0]
	call Func_64c7c
	call SwapTurn
	call Func_6534e
	ldh [hTempPlayAreaLocation_ffa1], a
	cp $0e
	jr c, .asm_652ef
	ld a, $0d
.asm_652ef
	ld c, a
	ld hl, hTempPlayAreaLocation_ffa1
	ld de, wDuelTempList
	ld a, c
	or a
	jr z, .asm_65304
.asm_652fa
	ld a, [de]
	cp $ff
	jr z, .asm_65304
	inc de
	ld [hli], a
	dec c
	jr nz, .asm_652fa
.asm_65304
	ld [hl], $ff
	ret

Func_65307:
	ldh a, [hTemp_ffa0]
	or a
	ret nz
	ldh a, [hTempPlayAreaLocation_ffa1]
	cp $ff
	jr z, .asm_65316
	farcall Func_682a9
	ret c
.asm_65316
	ld a, $df
	ld [wLoadedAttackAnimation], a
	ld a, $fd
	call GetNonTurnDuelistVariable
	ld [hl], $05
	ret

Func_65323:
	ldh a, [hTempPlayAreaLocation_ffa1]
	cp $ff
	jr z, .asm_65341
	call SwapTurn
	ldh a, [hTemp_ffa0]
	ld e, a
	bank1call Func_6f49
	jr c, .asm_6534a
	ld hl, hTempPlayAreaLocation_ffa1
.asm_65337
	ld a, [hli]
	cp $ff
	jr z, .asm_65344
	call Func_0ffa
	jr .asm_65337
.asm_65341
	call SwapTurn
.asm_65344
	ldh a, [hTemp_ffa0]
	farcall Func_680ed
.asm_6534a
	call SwapTurn
	ret

Func_6534e:
	ld c, $00
.asm_65350
	push bc
	ldtx de, DryUpCheckText
	xor a
	farcall Func_6807b
	pop bc
	ld a, c
	ret nc
	inc c
	jr .asm_65350

PidgeottoLv38Twister_AfterDamage:
	ld a, $c8
	call GetNonTurnDuelistVariable
	or a
	ret z
	farcall Func_682be
	ret c
	call SwapTurn
	ld c, $00
	ld a, DUELVARS_CARD_LOCATIONS
	get_turn_duelist_var
.asm_65373
	ld a, [hl]
	cp $10
	jr nz, .asm_65384
	ld a, l
	call LoadCardDataToBuffer1_FromDeckIndex
	ld a, [wLoadedCard1Type]
	cp $08
	jr c, .asm_65384
	inc c
.asm_65384
	inc l
	ld a, l
	cp $3c
	jr c, .asm_65373
	call SwapTurn
	ld a, c
	or a
	ret z
	ldtx de, TwisterCheckText
	farcall TossCoin_Bank1a
	ret nc

Func_65398:
	farcall Func_682be
	ret c
	ld a, $c8
	call GetNonTurnDuelistVariable
	or a
	ret z
	call SwapTurn
	ld a, DUELVARS_ARENA_CARD_ATTACHED_DEFENDER
	get_turn_duelist_var
	ld [hl], $00
	ld l, $00
.asm_653ae
	ld a, [hl]
	cp $10
	jr nz, .asm_653c2
	ld a, l
	call LoadCardDataToBuffer1_FromDeckIndex
	ld a, [wLoadedCard1Type]
	cp $08
	jr c, .asm_653c2
	ld a, l
	call AddCardToHand
.asm_653c2
	inc l
	ld a, l
	cp $3c
	jr c, .asm_653ae
	xor a
	ld [wDuelDisplayedScreen], a
	ld a, DUELVARS_ARENA_CARD_LAST_TURN_EFFECT
	get_turn_duelist_var
	ld [hl], $07
	call SwapTurn
	ret

PidgeottoLv38Fly_AI:
	ld a, 30
	lb de, 0, 30
	farcall Func_680dd
	ret

PidgeottoLv38Fly_BeforeDamage:
	ldtx de, AttackSuccessCheckText
	farcall TossCoin_Bank1a
	jr c, .asm_653f5
	xor a
	ld [wLoadedAttackAnimation], a
	farcall Func_6817e
	farcall Func_6809a
	ret
.asm_653f5
	ld a, $12
	farcall Func_68127
	ret

ArbokLv30DeadlyPoison_AI:
	ld a, $ec
	call GetNonTurnDuelistVariable
	and $f0
	cp $80
	ret nz
	ld a, $0a
	farcall Func_68163
	ret

ArbokLv30DeadlyPoison_BeforeDamage:
	call ArbokLv30DeadlyPoison_AI
	farcall Func_68012
	ret

SandslashLv35SandVeil_BeforeDamage:
	ldtx de, IfHeadsNoDamageNextTurnText
	farcall TossCoin_Bank1a
	jr nc, .asm_65425
	ld a, $27
	farcall Func_68127
	ret
.asm_65425
	xor a
	ld [wLoadedAttackAnimation], a
	farcall Func_6809a
	ret

SandslashLv35RollingNeedle_AI:
	ld a, 15
	lb de, 0, 30
	farcall Func_680dd
	ret

SandslashLv35RollingNeedle_BeforeDamage:
	ld hl, $a
	call LoadTxRam3
	ldtx de, Plus10DamageToOppAndYourselfForEachHeadsText
	ld a, $03
	farcall Func_68069
	ldh [hTemp_ffa0], a
	call ATimes10
	farcall Func_68163
	ret

SandslashLv35RollingNeedle_AfterDamage:
	ldh a, [hTemp_ffa0]
	call ATimes10
	call DealRecoilDamageToSelf
	ret

NidorinaLv22StrengthInNumbers_BeforeDamage:
	ld e, $00
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	ld b, a
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
	jr .asm_65475
.asm_65465
	ld a, [hl]
	call LoadCardDataToBuffer1_FromDeckIndex
	ld a, [wLoadedCard1PokedexNumber]
	cp $1d
	jr c, .asm_65475
	cp $23
	jr nc, .asm_65475
	inc e
.asm_65475
	inc hl
	dec b
	jr nz, .asm_65465
	ld a, e
	call ATimes10
	farcall Func_68163
	ret

NidorinaLv22FurySwipes_AI:
	ld a, 45
	lb de, 0, 90
	farcall Func_680dd
	ret

NidorinaLv22FurySwipes_BeforeDamage:
	ld hl, $1e
	call LoadTxRam3
	ldtx de, DamageCheckXDamageTimesHeadsText
	ld a, $03
	farcall Func_68069
	ld e, a
	add a
	add e
	call ATimes10
	farcall Func_6817e
	ret

NidorinoLv23SwiftLunge_AI:
	ld a, 30
	lb de, 0, 60
	farcall Func_680dd
	ret

NidorinoLv23SwiftLunge_BeforeDamage:
	ldtx de, IfTailsNoDamageToOppAnd20ToYourselfText
	farcall TossCoin_Bank1a
	ldh [hTemp_ffa0], a
	ret c
	xor a
	ld [wLoadedAttackAnimation], a
	farcall Func_6817e
	farcall Func_6809a
	ret

NidorinoLv23SwiftLunge_AfterDamage:
	ldh a, [hTemp_ffa0]
	or a
	ret nz
	ld a, $14
	call DealRecoilDamageToSelf
	ret

VulpixLv13FoxFire_AISelection:
	farcall Func_686be
	ldh [hTemp_ffa0], a
	ret

VulpixLv13FoxFire_RequireSelection:
	ldtx hl, SelectBenchedPokemonToSwitchWithActiveText
	call DrawWideTextBox_WaitForInput
	call SwapTurn
	bank1call HasAlivePokemonInPlayArea
	jr c, .asm_654eb
	bank1call OpenPlayAreaScreenForSelection
	jr nc, .asm_654ec
.asm_654eb
	xor a
.asm_654ec
	ldh [hTemp_ffa0], a
	call SwapTurn
	ret

VulpixLv13FoxFire_BeforeDamage:
	ldh a, [hTemp_ffa0]
	or a
	jr nz, .asm_654fc
	farcall Func_682a9
	ret
.asm_654fc
	xor a
	ld [wNoDamageOrEffect], a
	call SwapTurn
	ldh a, [hTemp_ffa0]
	ld e, a
	bank1call Func_6f49
	jr nc, .asm_65512
	xor a
	farcall Func_6817e
	jr .asm_65532
.asm_65512
	xor a
	ld [wcd0b], a
	call SwapArenaWithBenchPokemon
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
.asm_65532
	xor a
	ld [wNoDamageOrEffect], a
	call SwapTurn
	ret

VenonatLv15Disable_InitialEffect1:
	farcall Func_6808d
	farcall Func_68501
	ret

VenonatLv15Disable_AISelection:
	ldtx de, AttackSuccessCheckText
	farcall Func_68079
	ldh [hTempPlayAreaLocation_ffa1], a
	ret nc
	farcall Func_68633
	ret

VenonatLv15Disable_RequireSelection:
	ldtx de, AttackSuccessCheckText
	farcall Func_68079
	ldh [hTempPlayAreaLocation_ffa1], a
	ret nc
.asm_6555c
	farcall Func_690c3
	jr c, .asm_6555c
	ret

VenonatLv15Disable_BeforeDamage:
	ldh a, [hTempPlayAreaLocation_ffa1]
	or a
	jr z, .asm_6556f
	ld a, $0f
	farcall Func_690d2
	ret
.asm_6556f
	xor a
	ld [wLoadedAttackAnimation], a
	farcall Func_6809a
	ret

GolduckLv28Psychic_BeforeDamage:
	farcall Func_69686
	ld hl, wDamage
	ld a, e
	add [hl]
	ld [hli], a
	ld a, d
	adc [hl]
	ld [hl], a
	farcall Func_6818c
	ret

GrowlitheLv16ErrandRunning_InitialEffect1:
	farcall Func_6808d
	farcall Func_2435f
	ret

GrowlitheLv16ErrandRunning_RequireSelection:
	ldtx de, AttackSuccessCheckText
	farcall Func_68079
	ldh [hTemp_ffa0], a
	ret nc
	call CreateDeckCardList
	ldtx hl, ChooseATrainerCardFromDeckText
	ldtx bc, TrainerCardText
	ld a, CARDSEARCH_TRAINER
	farcall Func_24c9d
	jr c, .asm_655b8
	ldtx hl, ChooseATrainerCardText
	ldtx de, DuelistDeckText
	farcall Func_24df8
.asm_655b8
	ldh [hTempPlayAreaLocation_ffa1], a
	ret

GrowlitheLv16ErrandRunning_AISelection:
	ldtx de, AttackSuccessCheckText
	farcall Func_68079
	ldh [hTemp_ffa0], a
	ret nc
	ld a, CARDSEARCH_TRAINER
	farcall SetCardSearchFuncParams
	call CreateDeckCardList
	ld hl, wDuelTempList
.asm_655d1
	ld a, [hli]
	ldh [hTempPlayAreaLocation_ffa1], a
	cp $ff
	ret z
	farcall ExecuteCardSearchFunc
	jr nc, .asm_655d1
	ret

GrowlitheLv16ErrandRunning_BeforeDamage:
	ldh a, [hTemp_ffa0]
	or a
	ret nz
	xor a
	ld [wLoadedAttackAnimation], a
	ret

GrowlitheLv16ErrandRunning_AfterDamage:
	ldh a, [hTemp_ffa0]
	or a
	ret z
	ldh a, [hTempPlayAreaLocation_ffa1]
	cp $ff
	jr z, .asm_65605
	call SearchCardInDeckAndAddToHand
	call AddCardToHand
	farcall Func_680ab
	jr c, .asm_65605
	ldh a, [hTempPlayAreaLocation_ffa1]
	ldtx hl, WasPlacedInTheHandText
	bank1call DisplayCardDetailScreen
.asm_65605
	farcall Func_680a0
	ret

GrowlitheLv16Ember_InitialEffect1:
	farcall Func_6927b
	ret

GrowlitheLv16Ember_InitialEffect2:
	farcall Func_6926c
	ret

GrowlitheLv16Ember_AISelection:
	farcall Func_69291
	ret

GrowlitheLv16Ember_DiscardEnergy:
	ldh a, [hTemp_ffa0]
	call Func_0ffa
	ret

KadabraLv39PsychoPanic_BeforeDamage:
	call Func_6562a
	ret nz
	ld a, $3c
	farcall Func_6817e
	ret

Func_6562a:
	call SwapTurn
	bank1call GetArenaCardColor
	call SwapTurn
	cp $05
	ret

KadabraLv39Blink_BeforeDamage:
	ld a, $10
	farcall Func_68127
	ret

AlakazamLv45PsychoPanic_BeforeDamage:
	call Func_6562a
	ret nz
	ld a, $3c
	farcall Func_6817e
	ret

AlakazamLv45TransDamage_InitialEffect1:
	ld e, $00
	call GetCardDamageAndMaxHP
	or a
	ret nz
	ld hl, $b6
	scf
	ret

AlakazamLv45TransDamage_DiscardEnergy:
	xor a
	call CreateArenaOrBenchEnergyCardList
	ld hl, wDuelTempList
.asm_6565b
	inc b
	ld a, [hli]
	cp $ff
	ret z
	call Func_0ffa
	jr .asm_6565b

AlakazamLv45TransDamage_AI:
	ldh a, [hTempPlayAreaLocation_ff9d]
	jr Func_6566a

Func_65669:
	xor a
;   fallthrough

Func_6566a:
	ld e, a
	call GetCardDamageAndMaxHP
	farcall Func_68175
	ld a, [wDamage]
	ld e, a
	ld d, $00
	ld l, e
	ld h, d
	call LoadTxRam3
	ret

AlakazamLv45TransDamage_BeforeDamage:
	farcall Func_682a9
	ret c
	call SwapTurn
	bank1call Func_7038
	call SwapTurn
	ret c
	ld a, $e1
	ld [wLoadedAttackAnimation], a
	call Func_65669
	jr Func_656c8

AlakazamLv45TransDamage_AfterDamage:
	farcall Func_682be
	jr c, .asm_656a8
	call Func_65669
	ld a, $c8
	call GetNonTurnDuelistVariable
	call SubtractHP
.asm_656a8
	ld e, $00
	call GetCardDamageAndMaxHP
	ld e, a
	ld d, $00
	farcall ApplyAndAnimateHPRecovery
	ld a, $c8
	call GetNonTurnDuelistVariable
	call PrintKnockedOutIfHLZero
	ret

Func_656bd:
	ld a, $e1
	ld [wLoadedAttackAnimation], a
	ld a, DUELVARS_ARENA_CARD_LAST_TURN_CHANGE_WEAK
	get_turn_duelist_var
	ld e, a
	ld d, $00
;   fallthrough

Func_656c8:
	ld a, $fc
	call GetNonTurnDuelistVariable
	ld [hl], e
	ld a, $fd
	call GetNonTurnDuelistVariable
	ld [hl], $03
	ld a, [wLoadedAttackAnimation]
	call Func_67843
	xor a
	ld [wLoadedAttackAnimation], a
	farcall Func_6817e
	ret

Func_656e4:
	ld a, DUELVARS_ARENA_CARD_LAST_TURN_CHANGE_WEAK
	get_turn_duelist_var
	ld e, a
	ld d, $00
	ld a, $c8
	call GetNonTurnDuelistVariable
	call SubtractHP
	call PrintKnockedOutIfHLZero
	ret

MachokeLv24FocusBlast_InitialEffect1:
	farcall Func_6808d
	ret

MachokeLv24FocusBlast_AI:
	ld a, $14
	farcall Func_6817e
	ret

MachokeLv24FocusBlast_RequireSelection:
	xor a
	ldh [hTemp_ffa0], a
	ldtx de, IfHeads20DamageTo1OfOppPokemonText
	farcall Func_68079
	ldh [hTemp_ffa0], a
	ret nc
	ldtx hl, ChoosePokemonToGiveDamageText
	call DrawWideTextBox_WaitForInput
	call SwapTurn
	bank1call HasAlivePokemonInPlayArea
.asm_6571b
	bank1call OpenPlayAreaScreenForSelection
	jr c, .asm_6571b
	ldh a, [hTempPlayAreaLocation_ff9d]
	ldh [hTempPlayAreaLocation_ffa1], a
	call SwapTurn
	ret

MachokeLv24FocusBlast_AISelection:
	ldtx de, IfHeads20DamageTo1OfOppPokemonText
	farcall Func_68079
	ldh [hTemp_ffa0], a
	ret nc
	farcall Func_686be
	ldh [hTempPlayAreaLocation_ffa1], a
	ret

MachokeLv24FocusBlast_BeforeDamage:
	xor a
	ld [wLoadedAttackAnimation], a
	ret

MachokeLv24FocusBlast_AfterDamage:
	ldh a, [hTemp_ffa0]
	or a
	ret z
	ld e, $e2
	ldh a, [hTempPlayAreaLocation_ffa1]
	or a
	jr z, .asm_6574b
	ld e, $e3
.asm_6574b
	ld a, e
	ld [wLoadedAttackAnimation], a
	ldh a, [hTempPlayAreaLocation_ffa1]
	or a
	jr nz, .asm_65759
	ld hl, wLoadedAttackCategory
	res 7, [hl]
.asm_65759
	ldh a, [hTempPlayAreaLocation_ffa1]
	call SwapTurn
	bank1call LoadPlayAreaCardID_ToTempNonTurnDuelistCardID
	call SwapTurn
	ldh a, [hTempPlayAreaLocation_ffa1]
	ld c, a
	ld b, $00
	ld de, $14
	bank1call DamageCalculation
	call SwapTurn
	call DealDamageToPlayAreaPokemon.asm_192a
	call SwapTurn
	ret

MachampLv54SeethingAnger_AI:
	ld e, $00
	call GetCardDamageAndMaxHP
	ld [wAIMaxDamage], a
	srl a
	ld [wDamage], a
	xor a
	ld [wDamage + 1], a
	ld [wAIMinDamage], a
	ret

MachampLv54SeethingAnger_BeforeDamage:
	ld hl, $a
	call LoadTxRam3
	ld e, $00
	call GetCardDamageAndMaxHP
	or a
	ret z
	call ADividedBy10
	ldtx de, DamageCheckXDamageTimesHeadsText
	farcall Func_68069
	call ATimes10
	farcall Func_68163
	ret

MachampLv54Fling_RequireSelection:
	farcall HandleMandatorySwitchSelection
	ldh a, [hTempPlayAreaLocation_ff9d]
	ldh [hTemp_ffa0], a
	ret

MachampLv54Fling_AfterDamage:
	ldh a, [hTemp_ffa0]
	farcall Func_6828a
	ret

BellsproutLv10Sway_BeforeDamage:
	ldtx de, IfHeadsDoNotReceiveDamageText
	farcall TossCoin_Bank1a
	jr nc, .asm_657cd
	ld a, $28
	farcall Func_68127
	ret
.asm_657cd
	xor a
	ld [wLoadedAttackAnimation], a
	ret

WeepinbellLv23Regeneration_AfterDamage:
	ld e, $00
	call GetCardDamageAndMaxHP
	ld e, a
	ld d, $00
	farcall ApplyAndAnimateHPRecovery
	ld a, DUELVARS_CARD_LOCATIONS
	get_turn_duelist_var
.asm_657e1
	ld a, [hl]
	cp $10
	jr nz, .asm_6580b
	ld a, l
	call LoadCardDataToBuffer1_FromDeckIndex
	ld a, [wLoadedCard1Type]
	cp $08
	jr nc, .asm_65807
	ld a, [wLoadedCard1Stage]
	or a
	jr nz, .asm_65807
	push hl
	xor a
	ldh [hTempPlayAreaLocation_ff9d], a
	ld a, l
	farcall Func_68525
	farcall Func_68556
	pop hl
	jr .asm_6580b
.asm_65807
	ld a, l
	call Func_0ffa
.asm_6580b
	inc l
	ld a, l
	cp $3c
	jr c, .asm_657e1
	xor a
	ld [wDuelDisplayedScreen], a
	ret

WeepinbellLv23Dissolve_InitialEffect1:
	farcall Func_681a4
	jr c, .asm_65820
	farcall Func_6808d
.asm_65820
	or a
	ret

WeepinbellLv23Dissolve_RequireSelection:
	xor a
	ldh [hTempPlayAreaLocation_ffa1], a
	farcall Func_681a4
	ret c
	ldtx de, IfHeadsDiscard1EnergyCardFromOpponentText
	farcall Func_68079
	ldh [hTempPlayAreaLocation_ffa1], a
	ret nc
	farcall Func_6a87d
	ret

WeepinbellLv23Dissolve_AISelection:
	xor a
	ldh [hTempPlayAreaLocation_ffa1], a
	farcall Func_681a4
	ret c
	ldtx de, IfHeadsDiscard1EnergyCardFromOpponentText
	farcall Func_68079
	ldh [hTempPlayAreaLocation_ffa1], a
	ret nc
	farcall Func_685dd
	ldh [hTemp_ffa0], a
	ret

WeepinbellLv23Dissolve_AfterDamage:
	ldh a, [hTempPlayAreaLocation_ffa1]
	or a
	ret z
	farcall Func_6a8a5
	ret

GravelerLv27BoulderSmash_InitialEffect1:
	farcall Func_6808d
	ret

GravelerLv27BoulderSmash_RequireSelection:
	xor a
	ldh [hTemp_ffa0], a
	farcall Func_6843b
	ret c
	ldtx de, ForEachHeads10DamageToBenchInAnyWayYouLikeText
	ld a, $02
	farcall Func_6807b
	call Func_658b0
	ret

GravelerLv27BoulderSmash_AISelection:
	xor a
	ldh [hTemp_ffa0], a
	farcall Func_6843b
	ret c
	ldtx de, ForEachHeads10DamageToBenchInAnyWayYouLikeText
	ld a, $02
	farcall Func_6807b
	call Func_65978
	ret

GravelerLv27BoulderSmash_AfterDamage:
	ld hl, hTemp_ffa0
	ld a, [hli]
	or a
	ret z
	call SwapTurn
	ld b, $00
	ld c, $06
.asm_65897
	ld a, [hli]
	push hl
	push bc
	or a
	jr z, .asm_658a6
	call ATimes10
	ld e, a
	ld d, $00
	call DealDamageToPlayAreaPokemon_RegularAnim
.asm_658a6
	pop bc
	pop hl
	inc b
	dec c
	jr nz, .asm_65897
	call SwapTurn
	ret

Func_658b0:
	ldh [hTemp_ffa0], a
	or a
	ret z
	call Func_659bf
	farcall Func_6843b
	jr nc, .asm_658c1
	xor a
	ldh [hTemp_ffa0], a
	ret
.asm_658c1
	ldtx hl, ChoosePokemonToGiveDamageText
	call DrawWideTextBox_WaitForInput
	call SwapTurn
	xor a
	ld [wAttachedEnergyMenuNumerator], a
	ldh [hCurScrollMenuItem], a
	ld a, $01
	ldh [hffb2], a
	bank1call Func_5c30
	bank1call PrintPlayAreaCardList_EnableLCD
.asm_658da
	ldh a, [hCurScrollMenuItem]
	ld hl, Data_65970
	call InitializeMenuParameters
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	dec a
	ld [wNumScrollMenuItems], a
.asm_658e9
	call Func_65958
.asm_658ec
	call DoFrame
	call HandleMenuInput
	jr nc, .asm_658ec
	cp $ff
	jr nz, .asm_658fd
	call Func_6593d
	jr .asm_658e9
.asm_658fd
	farcall Func_24350
	ldh a, [hCurScrollMenuItem]
	inc a
	ld [hl], a
	ld e, a
	ld d, $00
	ld hl, wce02
	add hl, de
	inc [hl]
	ld hl, wAttachedEnergyMenuNumerator
	inc [hl]
	ldh a, [hTemp_ffa0]
	cp [hl]
	jr nz, .asm_658e9
	call Func_65958
	ldh a, [hCurScrollMenuItem]
	inc a
	farcall Func_680ed
	ldh a, [hKeysPressed]
	and $02
	jr z, .asm_6592b
	call Func_6593d
	jr .asm_658da
.asm_6592b
	call SwapTurn
	ld hl, hTempPlayAreaLocation_ffa1
	ld de, wce02
	ld c, $06
.asm_65936
	ld a, [de]
	inc de
	ld [hli], a
	dec c
	jr nz, .asm_65936
	ret

Func_6593d:
	ld hl, wAttachedEnergyMenuNumerator
	ld a, [hl]
	or a
	ret z
	dec [hl]
	ld hl, hffb2
	dec [hl]
	ld e, [hl]
	ld d, $00
	ld hl, hTemp_ffa0
	add hl, de
	ld e, [hl]
	ld d, $00
	ld hl, wce02
	add hl, de
	dec [hl]
	ret

Func_65958:
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	dec a
	ld e, a
	ld bc, $5
	ld hl, wce03
.asm_65963
	ld a, [hli]
	add $20
	call WriteByteToBGMap0
	inc c
	inc c
	inc c
	dec e
	jr nz, .asm_65963
	ret

Data_65970:
	db $00
	db $03
	db $03
	db $06
	db $0f
	db $00
	db $00
	db $00

Func_65978:
	ldh [hTemp_ffa0], a
	or a
	ret z
	call Func_659bf
	farcall Func_6843b
	jr nc, .asm_65989
	xor a
	ldh [hTemp_ffa0], a
	ret
.asm_65989
	ld c, $01
	ldh a, [hTemp_ffa0]
	cp $01
	jr z, .asm_6599b
	farcall Func_6843b
	cp $02
	jr z, .asm_659b8
	ld c, $02
.asm_6599b
	push bc
	farcall Func_6869d
	ld e, a
	ld d, $00
	ld hl, wce02
	add hl, de
	pop bc
	ld [hl], c
.asm_659a9
	ld hl, hTempPlayAreaLocation_ffa1
	ld de, wce02
	ld c, $06
.asm_659b1
	ld a, [de]
	inc de
	ld [hli], a
	dec c
	jr nz, .asm_659b1
	ret
.asm_659b8
	ld a, $02
	ld [wce03], a
	jr .asm_659a9

Func_659bf:
	ld hl, wce02
	xor a
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld [hl], a
	ret

GolemLv37RockBlast_AI:
	ld a, $0c
	farcall Func_681e5
	cp $05
	jr c, .asm_659d6
	ld a, $05
.asm_659d6
	call ATimes10
	ld [wAIMaxDamage], a
	xor a
	ld [wDamage], a
	ld [wDamage + 1], a
	ld [wAIMinDamage], a
	ret

GolemLv37RockBlast_InitialEffect1:
	ld a, $0c
	farcall Func_681e5
	ld hl, $21c
	ret

GolemLv37RockBlast_AISelection:
	xor a
	ldh [hTemp_ffa0], a
	ret

GolemLv37RockBlast_RequireSelection:
	xor a
	ld [wAttachedEnergyMenuNumerator], a
	ld a, $01
	ldh [hffb2], a
	ld a, $0c
	farcall Func_681e5
	xor a
	bank1call DisplayEnergyDiscardMenu
	ld a, $05
	ld [wAttachedEnergyMenuDenominator], a
.asm_65a0c
	bank1call HandleAttachedEnergyMenuInput
	jr nc, .asm_65a1b
	ld a, $06
	farcall Func_6856d
	jr nc, .asm_65a36
	jr .asm_65a31
.asm_65a1b
	ld hl, wAttachedEnergyMenuNumerator
	inc [hl]
	farcall Func_24350
	ldh a, [hTempCardIndex_ff98]
	ld [hl], a
	call RemoveCardFromDuelTempList
	jr c, .asm_65a36
	ldh a, [hffb2]
	cp $06
	jr nc, .asm_65a36
.asm_65a31
	bank1call UpdateAttachedEnergyMenu
	jr .asm_65a0c
.asm_65a36
	farcall Func_24350
	ld [hl], $ff
	call Func_659bf
	ldh a, [hffb2]
	sub $02
	ldh [hTemp_ffa0], a
	jr z, .asm_65aad
	call SwapTurn
	xor a
	ld [wAttachedEnergyMenuNumerator], a
	ldh [hCurScrollMenuItem], a
	bank1call Func_5c30
	bank1call PrintPlayAreaCardList_EnableLCD
.asm_65a56
	ldh a, [hCurScrollMenuItem]
	ld hl, Data_65b55
	call InitializeMenuParameters
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	ld [wNumScrollMenuItems], a
.asm_65a64
	call Func_65b3e
.asm_65a67
	call DoFrame
	call HandleMenuInput
	jr nc, .asm_65a67
	cp $ff
	jr nz, .asm_65a78
	call Func_65b23
	jr .asm_65a64
.asm_65a78
	farcall Func_24350
	ldh a, [hCurScrollMenuItem]
	ld [hl], a
	ld e, a
	ld d, $00
	ld hl, wce02
	add hl, de
	inc [hl]
	ld hl, wAttachedEnergyMenuNumerator
	inc [hl]
	ldh a, [hTemp_ffa0]
	cp [hl]
	jr nz, .asm_65a64
	call Func_65b3e
	ldh a, [hCurScrollMenuItem]
	farcall Func_680ed
	ldh a, [hKeysPressed]
	and $02
	jr z, .asm_65aa4
	call Func_65b23
	jr .asm_65a56
.asm_65aa4
	farcall Func_24350
	ld [hl], $ff
	call SwapTurn
.asm_65aad
	ldh a, [hTemp_ffa0]
	ld e, a
	ld d, $00
	ld hl, hTempRetreatCostCards
	add hl, de
	ld de, wce02
	ld c, $06
.asm_65abb
	ld a, [de]
	inc de
	ld [hli], a
	dec c
	jr nz, .asm_65abb
	ret

GolemLv37RockBlast_BeforeDamage:
	ld hl, hTemp_ffa0
	ld a, [hli]
	or a
	jr nz, .asm_65acd
	ld [wLoadedAttackAnimation], a
	ret
.asm_65acd
	ld a, [hli]
	cp $ff
	jr z, .asm_65ad7
	call Func_0ffa
	jr .asm_65acd
.asm_65ad7
	ld a, [hl]
	or a
	jr z, .asm_65aed
	call SwapTurn
	add a
	call ATimes10
	ld e, a
	ld d, $00
	ld b, $00
	call DealDamageToPlayAreaPokemon_RegularAnim
	call SwapTurn
.asm_65aed
	xor a
	ld [wLoadedAttackAnimation], a
	ld hl, wLoadedAttackCategory
	res 7, [hl]
	ret

GolemLv37RockBlast_AfterDamage:
	ld hl, hTemp_ffa0
	ld a, [hli]
	or a
	ret z
	inc a
	ld e, a
	ld d, $00
	add hl, de
	ld b, $01
	ld c, $05
	inc hl
	call SwapTurn
.asm_65b0a
	ld a, [hli]
	push hl
	push bc
	add a
	jr z, .asm_65b19
	call ATimes10
	ld e, a
	ld d, $00
	call DealDamageToPlayAreaPokemon_RegularAnim
.asm_65b19
	pop bc
	pop hl
	inc b
	dec c
	jr nz, .asm_65b0a
	call SwapTurn
	ret

Func_65b23:
	ld hl, wAttachedEnergyMenuNumerator
	ld a, [hl]
	or a
	ret z
	dec [hl]
	ld hl, hffb2
	dec [hl]
	ld e, [hl]
	ld d, $00
	ld hl, hTemp_ffa0
	add hl, de
	ld e, [hl]
	ld d, $00
	ld hl, wce02
	add hl, de
	dec [hl]
	ret

Func_65b3e:
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	ld e, a
	ld bc, $2
	ld hl, wce02
.asm_65b48
	ld a, [hli]
	add $20
	call WriteByteToBGMap0
	inc c
	inc c
	inc c
	dec e
	jr nz, .asm_65b48
	ret

Data_65b55:
	db $00
	db $00
	db $03
	db $06
	db $0f
	db $00
	db $00
	db $00

PonytaLv8Fireworks_InitialEffect1:
	farcall Func_6808d
	ret

PonytaLv8Fireworks_AI:
	xor a
	call CreateArenaOrBenchEnergyCardList
	ret nc
	xor a
	farcall Func_6817e
	ret

PonytaLv8Fireworks_AISelection:
	ldtx de, IfTailsDiscard1EnergyCardFromYourselfText
	farcall Func_68079
	ldh [hTemp_ffa0], a
	ret c
	xor a
	call CreateArenaOrBenchEnergyCardList
	ld a, [wDuelTempList]
	ldh [hTempPlayAreaLocation_ffa1], a
	ret

PonytaLv8Fireworks_RequireSelection:
	ldtx de, IfTailsDiscard1EnergyCardFromYourselfText
	farcall Func_68079
	ldh [hTemp_ffa0], a
	jr c, .asm_65ba1
	xor a
	call CreateArenaOrBenchEnergyCardList
	ld a, $ff
	jr z, .asm_65b9f
	xor a
	bank1call DisplayEnergyDiscardMenu
.asm_65b98
	bank1call HandleAttachedEnergyMenuInput
	jr c, .asm_65b98
	ldh a, [hTempCardIndex_ff98]
.asm_65b9f
	ldh [hTempPlayAreaLocation_ffa1], a
.asm_65ba1
	or a
	ret

PonytaLv8Fireworks_BeforeDamage:
	ldh a, [hTemp_ffa0]
	or a
	ret nz
	ldh a, [hTempPlayAreaLocation_ffa1]
	cp $ff
	ret z
	call Func_0ffa
	ret

SlowbroLv35BigYawn_InitialEffect1:
	call Func_65bce
	ld hl, $25
	ret

SlowbroLv35BigYawn_BeforeDamage:
	farcall Func_6805c
	call SwapTurn
	farcall Func_6805c
	call SwapTurn
	ret

SlowbroLv35BigSnore_InitialEffect1:
	call Func_65bce
	ld hl, $e6
	ccf
	ret

Func_65bce:
	ld a, DUELVARS_ARENA_CARD_STATUS
	get_turn_duelist_var
	and $0f
	cp $02
	jr nz, .asm_65bd9
	scf
	ret
.asm_65bd9
	or a
	ret

GastlyLv13Spookify_BeforeDamage:
	ld a, $f1
	call GetNonTurnDuelistVariable
	set 3, [hl]
	ret

HaunterLv26Poltergeist_AI:
	ld a, 10
	lb de, 0, 30
	farcall Func_680dd
	ret

HaunterLv26Poltergeist_BeforeDamage:
	call SwapTurn
	call CreateHandCardList
	jr c, .asm_65c32
	bank1call InitAndDrawCardListScreenLayout
	ldtx hl, ChooseCardToCheckText
	ldtx de, DuelistHandText
	bank1call SetCardListHeaderAndInfoText
	ld a, $09
	ld [wNoItemSelectionMenuKeys], a
	bank1call DisplayCardList
	ld hl, wDuelTempList
	ld c, $00
.asm_65c0e
	ld a, [hli]
	cp $ff
	jr z, .asm_65c20
	call LoadCardDataToBuffer1_FromDeckIndex
	ld a, [wLoadedCard1Type]
	cp $10
	jr nz, .asm_65c0e
	inc c
	jr .asm_65c0e
.asm_65c20
	call SwapTurn
	ld l, c
	ld h, $0a
	call HtimesL
	ld a, l
	ld [wDamage], a
	ld a, h
	ld [wDamage + 1], a
	ret
.asm_65c32
	ldtx hl, DuelistHasNoCardsInHandText
	call DrawWideTextBox_WaitForInput
	call SwapTurn
	xor a
	farcall Func_6817e
	ret

HaunterLv26BadDreams_BeforeDamage:
	ldtx de, AsleepIfHeadsConfusedIfTailsText
	farcall TossCoin_Bank1a
	jr c, .asm_65c4f
	farcall Func_68045
	ret
.asm_65c4f
	farcall Func_6805c
	ret

HaunterLv25Grudge_BeforeDamage:
	call SwapTurn
	call CountPrizes
	call SwapTurn
	ld e, a
	ld a, [wDuelInitialPrizes]
	sub e
	call ATimes10
	farcall Func_68163
	ret

GengarLv40PowerOfDarkness_InitialEffect1:
	farcall Func_6808d
	scf
	ret

GengarLv40PowerOfDarkness_RequireSelection:
	ldtx de, PowerOfDarknessCheckText
	farcall Func_68079
	ldh [hTemp_ffa0], a
	ret nc
	ldtx hl, ChoosePokemonToReturnToHandText
	call DrawWideTextBox_WaitForInput
	call SwapTurn
	bank1call HasAlivePokemonInPlayArea
.asm_65c86
	bank1call OpenPlayAreaScreenForSelection
	jr c, .asm_65c86
	call SwapTurn
	ldh [hTempPlayAreaLocation_ffa1], a
	ret

GengarLv40PowerOfDarkness_PkmnPowerTrigger:
	ldh a, [hTemp_ffa0]
	or a
	ret z
	call SwapTurn
	ldh a, [hTempPlayAreaLocation_ffa1]
	or $10
	ld b, a
	ld a, DUELVARS_CARD_LOCATIONS
	get_turn_duelist_var
.asm_65ca0
	ld a, [hl]
	cp b
	jr nz, .asm_65ca8
	ld a, l
	call AddCardToHand
.asm_65ca8
	inc l
	ld a, l
	cp $3c
	jr c, .asm_65ca0
	ldh a, [hTempPlayAreaLocation_ffa1]
	add $bb
	ld l, a
	ld a, [hl]
	ldh [hTempCardIndex_ff98], a
	ld [hl], $ff
	ldh a, [hTempPlayAreaLocation_ffa1]
	add $c8
	ld l, a
	ld [hl], $00
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
	bank1call Func_6518
	ret

GengarLv40PsyHorror_BeforeDamage:
	ldtx de, AsleepIfHeadsConfusedIfTailsText
	farcall TossCoin_Bank1a
	jr c, .asm_65cec
	farcall Func_68045
	ret
.asm_65cec
	farcall Func_6805c
	ret

HypnoLv30PuppetMaster_InitialEffect1:
	scf
	ret

HypnoLv30MindShock_BeforeDamage:
	ld hl, wDamage + 1
	set 7, [hl]
	ret

EffectCommands_590ab_BeforeDamage:
	ld a, $19
	ld [wLoadedAttackAnimation], a
	ld hl, wDamage + 1
	set 7, [hl]
	ret

KinglerLv33SaltWater_InitialEffect1:
	farcall Func_6808d
	farcall Func_2435f
	ret

KinglerLv33SaltWater_AISelection:
	xor a
	ldh [hTemp_ffa0], a
	ret

KinglerLv33SaltWater_RequireSelection:
	ldtx de, IfHeadsAttachUpTo3WaterEnergyFromDeckText
	farcall Func_68079
	ldh [hTemp_ffa0], a
	ret nc
	ld a, $01
	ldh [hffb2], a
	call CreateDeckCardList
.asm_65d22
	bank1call InitAndDrawCardListScreenLayout
	ldtx hl, ChooseWaterEnergyText
	ldtx de, DuelistDeckText
	bank1call SetCardListHeaderAndInfoText
.asm_65d2e
	bank1call DisplayCardList
	jr nc, .asm_65d3d
	ld a, $04
	farcall Func_6856d
	jr nc, .asm_65d5b
	jr .asm_65d22
.asm_65d3d
	ldh a, [hTempCardIndex_ff98]
	call LoadCardDataToBuffer1_FromDeckIndex
	ld a, [wLoadedCard1Type]
	cp $0b
	jr nz, .asm_65d2e
	farcall Func_24350
	ldh a, [hTempCardIndex_ff98]
	ld [hl], a
	call RemoveCardFromDuelTempList
	jr c, .asm_65d5b
	ldh a, [hffb2]
	cp $04
	jr c, .asm_65d22
.asm_65d5b
	farcall Func_24350
	ld [hl], $ff
	or a
	ret

KinglerLv33SaltWater_BeforeDamage:
	ldh a, [hTemp_ffa0]
	or a
	ret nz
	ld [wLoadedAttackAnimation], a
	ret

KinglerLv33SaltWater_AfterDamage:
	ld hl, hTemp_ffa0
	ld a, [hli]
	or a
	ret z
.asm_65d71
	ld a, [hli]
	cp $ff
	jr z, .asm_65d85
	call SearchCardInDeckAndAddToHand
	call AddCardToHand
	push hl
	ld e, $00
	call PutHandCardInPlayArea
	pop hl
	jr .asm_65d71
.asm_65d85
	farcall Func_680a0
	ret

KinglerLv33DoubleEdgedPincers_BeforeDamage:
	ld a, $29
	farcall Func_68127
	ret

CuboneLv14BoneToss_InitialEffect1:
	farcall Func_6808d
	ret

CuboneLv14BoneToss_AI:
	ld a, 15
	lb de, 0, 30
	farcall Func_680dd
	ret

CuboneLv14BoneToss_AISelection:
	ldtx de, IfHeads30DamageToOppIfTails10DamageToBenchText
	farcall Func_68079
	ldh [hTemp_ffa0], a
	ret c
	farcall Func_6843b
	jr c, Func_65dde
	farcall Func_6869d
	ldh [hTempPlayAreaLocation_ffa1], a
	ret

CuboneLv14BoneToss_RequireSelection:
	ldtx de, IfHeads30DamageToOppIfTails10DamageToBenchText
	farcall Func_68079
	ldh [hTemp_ffa0], a
	ret c
	farcall Func_6843b
	jr c, Func_65dde
	ldtx hl, ChooseBenchedPokemonToGiveDamageText
	call DrawWideTextBox_WaitForInput
	call SwapTurn
	bank1call HasAlivePokemonInBench
.asm_65dd3
	bank1call OpenPlayAreaScreenForSelection
	jr c, .asm_65dd3
	ldh [hTempPlayAreaLocation_ffa1], a
	call SwapTurn
	ret

Func_65dde:
	xor a
	ldh [hTemp_ffa0], a
	ldh [hTempPlayAreaLocation_ffa1], a
	ret

CuboneLv14BoneToss_BeforeDamage:
	ldh a, [hTemp_ffa0]
	or a
	jr z, .asm_65df0
	ld a, $1e
	farcall Func_6817e
	ret
.asm_65df0
	ld [wLoadedAttackAnimation], a
	ret

CuboneLv14BoneToss_AfterDamage:
	ldh a, [hTemp_ffa0]
	or a
	ret nz
	ldh a, [hTempPlayAreaLocation_ffa1]
	or a
	ret z
	call SwapTurn
	ld b, a
	ld a, $e6
	ld [wLoadedAttackAnimation], a
	ld de, $a
	call DealDamageToPlayAreaPokemon
	call SwapTurn
	ret

WeezingLv26PoisonMist_InitialEffect2:
	farcall Func_6844f
	ret

WeezingLv26PoisonMist_BeforeDamage:
	farcall Func_68465
	ldtx de, PoisonMistCheckText
	farcall TossCoin_Bank1a
	ret nc
	ldh a, [hTempPlayAreaLocation_ff9d]
	add DUELVARS_ARENA_CARD_FLAGS
	get_turn_duelist_var
	set 3, [hl]
	ret

WeezingLv26GasExplosion_AfterDamage:
	ld a, $1e
	call DealRecoilDamageToSelf
	ld a, $c8
	call GetNonTurnDuelistVariable
	or a
	ret nz
	ld a, $01
	ld [wcd0c], a
	ret

RhydonLv37MountainBreak_InitialEffect1:
	farcall Func_2435f
	ret

RhydonLv37MountainBreak_AfterDamage:
	ld a, $05
	ldh [hffb2], a
.asm_65e43
	call DrawCardFromDeck
	jr c, .asm_65e74
	ldh [hTempCardIndex_ff98], a
	call PutCardInDiscardPile
	call LoadCardDataToBuffer1_FromDeckIndex
	ld a, [wLoadedCard1Type]
	cp $0c
	jr nz, .asm_65e66
	ld a, [wSpecialRule]
	cp $0a
	jr z, .asm_65e66
	ldh a, [hTempCardIndex_ff98]
	call MoveDiscardPileCardToHand
	call AddCardToHand
.asm_65e66
	ldtx hl, DiscardedCardText
	ldh a, [hTempCardIndex_ff98]
	bank1call DisplayCardDetailScreen
	ld hl, hffb2
	dec [hl]
	jr nz, .asm_65e43
.asm_65e74
	ret

RhydonLv37OneTwoStrike_AI:
	ld a, 40
	lb de, 30, 50
	farcall Func_680dd
	ret

RhydonLv37OneTwoStrike_BeforeDamage:
	ld a, $14
	farcall Func_682e0
	ret

KangaskhanLv36TailDrop_AI:
	ld a, 80
	lb de, 0, 80
	farcall Func_680dd
	ret

KangaskhanLv36TailDrop_BeforeDamage:
	ldtx de, FailIfEitherOf2CoinsIsTailsText
	ld a, $02
	farcall Func_68069
	cp $02
	ret z
	xor a
	ld [wLoadedAttackAnimation], a
	farcall Func_6817e
	farcall Func_6809a
	ret

HorseaLv20Hide_BeforeDamage:
	ldtx de, AttackSuccessCheckText
	farcall TossCoin_Bank1a
	jr c, .asm_65ebb
	xor a
	ld [wLoadedAttackAnimation], a
	farcall Func_6809a
	ret
.asm_65ebb
	ld a, $2a
	farcall Func_68127
	ret

HorseaLv20WaterGun_BeforeDamage:
	ld bc, $100
	farcall Func_68e88
	ret

SeadraLv26WaterBomb_RequireSelection:
	ld bc, $200
	farcall Func_68e97
	call Func_658b0
	ret

SeadraLv26WaterBomb_AISelection:
	ld bc, $200
	farcall Func_68e97
	call Func_65978
	ret

SeadraLv26WaterBomb_AfterDamage:
	ld hl, hTemp_ffa0
	ld a, [hli]
	or a
	ret z
	call SwapTurn
	ld b, $00
	ld c, $06
.asm_65eed
	ld a, [hli]
	push hl
	push bc
	or a
	jr z, .asm_65efc
	call ATimes10
	ld e, a
	ld d, $00
	call DealDamageToPlayAreaPokemon_RegularAnim
.asm_65efc
	pop bc
	pop hl
	inc b
	dec c
	jr nz, .asm_65eed
	call SwapTurn
	ret

StaryuLv17StrangeBeam_AfterDamage:
	ld a, DUELVARS_ARENA_CARD_SUBSTATUS3
	get_turn_duelist_var
	set 6, [hl]
	ret

ScytherLv23SlashingStrike_InitialEffect1:
	ld a, $2e
	farcall Func_68478
	ret

ScytherLv23SlashingStrike_BeforeDamage:
	ld a, $2e
	farcall Func_6846d
	ret

MagmarLv27BurningFire_AI:
	xor a
	farcall Func_681e3
	call ATimes10
	add $0a
	ld e, a
	ld d, $0a
	ld a, d
	farcall Func_680dd
	ret

MagmarLv27BurningFire_AISelection:
	ld a, $ff
	ldh [hTemp_ffa0], a
	ret

MagmarLv27BurningFire_RequireSelection:
	ldtx hl, ProcedureForBurningFireText
	bank1call Func_5475
.asm_65f38
	ldh a, [hWhoseTurn]
	ld h, a
	ld l, $00
	ld de, wc000
.asm_65f40
	ld a, [hli]
	ld [de], a
	inc e
	jr nz, .asm_65f40
	xor a
	ldh [hffb2], a
.asm_65f48
	bank1call HasAlivePokemonInPlayArea
.asm_65f4b
	bank1call OpenPlayAreaScreenForSelection
	cp $ff
	jr z, .asm_65f7d
	ldh [hTempPlayAreaLocation_ff9d], a
	farcall Func_681af
	jr c, .asm_65f4b
	ldh a, [hTempPlayAreaLocation_ff9d]
	bank1call DisplayEnergyDiscardMenu
	ldh a, [hffb2]
	ld [wAttachedEnergyMenuNumerator], a
	xor a
	ld [wAttachedEnergyMenuDenominator], a
	bank1call HandleAttachedEnergyMenuInput
	jr c, .asm_65f48
	call PutCardInDiscardPile
	farcall Func_24350
	ldh a, [hTempCardIndex_ff98]
	ld [hl], a
	ldh a, [hffb2]
	cp $0f
	jr c, .asm_65f48
.asm_65f7d
	farcall Func_24350
	ld [hl], $ff
	ldh a, [hWhoseTurn]
	ld d, a
	ld e, $00
	ld hl, wc000
.asm_65f8b
	ld a, [hli]
	ld [de], a
	inc e
	jr nz, .asm_65f8b
	ldh a, [hffb2]
	dec a
	ld l, a
	ld h, $00
	call LoadTxRam3
	ldtx hl, DiscardingXCardsPromptText
	call YesOrNoMenuWithText_SetCursorToYes
	jr c, .asm_65f38
	ret

MagmarLv27BurningFire_BeforeDamage:
	ld hl, hTemp_ffa0
	ld c, $00
.asm_65fa7
	ld a, [hli]
	cp $ff
	jr z, .asm_65fb2
	call Func_0ffa
	inc c
	jr .asm_65fa7
.asm_65fb2
	ld a, c
	call ATimes10
	farcall Func_68163
	ret

TaurosLv35KickingAndStamping_InitialEffect1:
	farcall Func_6808d
	ret

TaurosLv35KickingAndStamping_AI:
	ld a, 25
	lb de, 20, 30
	farcall Func_680dd
	ret

TaurosLv35KickingAndStamping_RequireSelection:
	ldtx de, KickingAndStampingCheckText
	farcall Func_68079
	ldh [hTemp_ffa0], a
	ret c
	farcall HandleMandatorySwitchSelection
	ldh a, [hTempPlayAreaLocation_ff9d]
	ldh [hTempPlayAreaLocation_ffa1], a
	ret

TaurosLv35KickingAndStamping_BeforeDamage:
	ldh a, [hTemp_ffa0]
	or a
	ret z
	ld a, $0a
	farcall Func_68163
	ret

TaurosLv35KickingAndStamping_AfterDamage:
	ldh a, [hTemp_ffa0]
	or a
	ret nz
	ldh a, [hTempPlayAreaLocation_ffa1]
	farcall Func_6828a
	ret

OmanyteLv22FossilGuidance_InitialEffect2:
	farcall Func_6844f
	ret c
	call Func_6601c
	ld hl, $1bd
	ret

OmanyteLv22FossilGuidance_BeforeDamage:
	farcall Func_68465
	ldtx de, FossilGuidanceCheckText
	farcall TossCoin_Bank1a
	ret nc
	call Func_6601c
	ldh a, [hTempCardIndex_ff98]
	call MoveDiscardPileCardToHand
	call AddCardToHand
	ldh a, [hTempCardIndex_ff98]
	bank1call DisplayPlayerDrawCardScreen
	ret

Func_6601c:
	bank1call CreateDiscardPileCardList
	ld hl, wDuelTempList
.asm_66022
	ld a, [hli]
	ldh [hTempCardIndex_ff98], a
	cp $ff
	jr z, .asm_66038
	call GetCardIDFromDeckIndex
	cp16 MYSTERIOUS_FOSSIL
	jr nz, .asm_66022
	or a
	ret
.asm_66038
	scf
	ret

OmastarLv36TentacleGrip_InitialEffect1:
	farcall Func_2435f
	ret c
	ld a, $0b
	farcall Func_681e5
	ld hl, $21b
	ret

OmastarLv36TentacleGrip_BeforeDamage:
	ld a, $0b
	farcall Func_681e5
	ldtx de, DrawCardForEachHeadsText
	farcall Func_68069
	ldh [hTemp_ffa0], a
	ret

OmastarLv36TentacleGrip_AfterDamage:
	ldh a, [hTemp_ffa0]
	or a
	ret z
	add a
	farcall DisplayDrawNCardsScreen
	ldh a, [hTemp_ffa0]
	add a
	ld c, a
.asm_66066
	call DrawCardFromDeck
	jr c, .asm_6607e
	ldh [hTempCardIndex_ff98], a
	call AddCardToHand
	farcall Func_680ab
	jr nc, .asm_6607b
	push bc
	bank1call DisplayPlayerDrawCardScreen
	pop bc
.asm_6607b
	dec c
	jr nz, .asm_66066
.asm_6607e
	ret

OmastarLv36CorrosiveAcid_InitialEffect1:
	ld a, $2f
	farcall Func_68478
	ret

OmastarLv36CorrosiveAcid_BeforeDamage:
	ldtx de, ParalyzedIfHeadsUnableToAttackNextTurnIfTailsText
	farcall TossCoin_Bank1a
	jr nc, .asm_66094
	farcall Func_6802e
	ret
.asm_66094
	ld a, $c7
	ld [wLoadedAttackAnimation], a
	ld a, $2f
	farcall Func_6846d
	ret

MewtwoLv67CompleteRecovery_InitialEffect1:
	ld e, $00
	call GetCardDamageAndMaxHP
	or a
	ret nz
	ld a, DUELVARS_ARENA_CARD_STATUS
	get_turn_duelist_var
	or a
	ret nz
	ld hl, $be
	scf
	ret

MewtwoLv67CompleteRecovery_AfterDamage:
	ld a, DUELVARS_ARENA_CARD_STATUS
	get_turn_duelist_var
	ld [hl], $00
	ld e, $00
	call GetCardDamageAndMaxHP
	ld e, a
	ld d, $00
	farcall ApplyAndAnimateHPRecovery
	ld a, DUELVARS_CARD_LOCATIONS
	get_turn_duelist_var
.asm_660c5
	ld a, [hl]
	cp $10
	jr nz, .asm_660d9
	ld a, l
	call LoadCardDataToBuffer1_FromDeckIndex
	ld a, [wLoadedCard1Type]
	cp $08
	jr c, .asm_660d9
	ld a, l
	call Func_0ffa
.asm_660d9
	inc l
	ld a, l
	cp $3c
	jr c, .asm_660c5
	ret

MewtwoLv67PsychoBlast_InitialEffect1:
	farcall Func_681a4
	jr c, .asm_660ea
	farcall Func_6808d
.asm_660ea
	or a
	ret

MewtwoLv67PsychoBlast_RequireSelection:
	xor a
	ldh [hTempPlayAreaLocation_ffa1], a
	farcall Func_681a4
	ret c
	ldtx de, IfHeadsDiscard1EnergyCardFromOpponentText
	farcall Func_68079
	ldh [hTempPlayAreaLocation_ffa1], a
	ret nc
	farcall Func_6a87d
	ret

MewtwoLv67PsychoBlast_AISelection:
	xor a
	ldh [hTempPlayAreaLocation_ffa1], a
	farcall Func_681a4
	ret c
	ldtx de, IfHeadsDiscard1EnergyCardFromOpponentText
	farcall Func_68079
	ldh [hTempPlayAreaLocation_ffa1], a
	ret nc
	farcall Func_685dd
	ldh [hTemp_ffa0], a
	ret

MewtwoLv67PsychoBlast_AfterDamage:
	ldh a, [hTempPlayAreaLocation_ffa1]
	or a
	ret z
	farcall Func_6a8a5
	ret

DarkPersianAltLv28Fascinate_InitialEffect1:
	farcall Func_6b8c6
	ret

DarkPersianAltLv28Fascinate_AISelection:
	farcall Func_6b8cd
	ret

DarkPersianAltLv28Fascinate_RequireSelection:
	farcall Func_6b8dc
	ret

DarkPersianAltLv28Fascinate_BeforeDamage:
	farcall Func_6b8f6
	ret

DarkPersianAltLv28Fascinate_AfterDamage:
	farcall Func_6b901
	ret

MeowthLv14ClearProfit_InitialEffect1:
	farcall Func_2435f
	ret

MeowthLv14ClearProfit_BeforeDamage:
	xor a
	ldh [hTemp_ffa0], a
.asm_66146
	ldtx de, ClearProfitCheckText
	xor a
	farcall Func_68069
	jr nc, .asm_66156
	ld hl, hTemp_ffa0
	inc [hl]
	jr .asm_66146
.asm_66156
	ret

MeowthLv14ClearProfit_AfterDamage:
	ldh a, [hTemp_ffa0]
	or a
	ret z
	farcall DisplayDrawNCardsScreen
	ldh a, [hTemp_ffa0]
	ld c, a
.asm_66162
	call DrawCardFromDeck
	jr c, .asm_6617a
	ldh [hTempCardIndex_ff98], a
	call AddCardToHand
	farcall Func_680ab
	jr nc, .asm_66177
	push bc
	bank1call DisplayPlayerDrawCardScreen
	pop bc
.asm_66177
	dec c
	jr nz, .asm_66162
.asm_6617a
	ret

CoolPorygonTextureMagic_InitialEffect1:
	farcall Func_6aa84
	ret

CoolPorygonTextureMagic_AISelection:
	ld a, $ff
	ldh [hTemp_ffa0], a
	ldh [hTempPlayAreaLocation_ffa1], a
	ret

CoolPorygonTextureMagic_InitialEffect2:
	ld a, $ff
	ldh [hTempPlayAreaLocation_ffa1], a
	farcall Func_6aa2e
	jr nc, .asm_66199
	ldtx hl, CannotChangeWeaknessDueToNoWeaknessText
	call DrawWideTextBox_WaitForInput
	jr .asm_661a1
.asm_66199
	farcall Func_6aa44
	ldh a, [hTemp_ffa0]
	ldh [hTempPlayAreaLocation_ffa1], a
.asm_661a1
	farcall Func_6aa94
	ret

CoolPorygonTextureMagic_AfterDamage:
	ldh a, [hTempPlayAreaLocation_ffa1]
	cp $ff
	jr z, .asm_661bd
	ldh a, [hTemp_ffa0]
	push af
	ldh a, [hTempPlayAreaLocation_ffa1]
	ldh [hTemp_ffa0], a
	farcall Func_6aa4f
	call WaitForWideTextBoxInput
	pop af
	ldh [hTemp_ffa0], a
.asm_661bd
	farcall Func_6aac0
	ret

CoolPorygonPorygon3DAttack_AI:
	ld a, 30
	lb de, 0, 60
	farcall Func_680dd
	ret

CoolPorygonPorygon3DAttack_BeforeDamage:
	ld hl, $14
	call LoadTxRam3
	ldtx de, DamageCheckXDamageTimesHeadsText
	ld a, $03
	farcall Func_68069
	add a
	call ATimes10
	farcall Func_6817e
	ret

HungrySnorlaxEat_InitialEffect1:
	ld a, DUELVARS_ARENA_CARD_FOOD_COUNTERS
	get_turn_duelist_var
	ld hl, $ea
	cp $02
	ccf
	ret

HungrySnorlaxEat_AfterDamage:
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

HungrySnorlaxRollout_AI:
	ldh a, [hTempPlayAreaLocation_ff9d]
	add DUELVARS_ARENA_CARD_FOOD_COUNTERS
	get_turn_duelist_var
	ld e, a
	add a
	add e
	call ATimes10
	add $14
	ld [wAIMaxDamage], a
	xor a
	ld [wDamage + 1], a
	ld a, $14
	ld [wDamage], a
	ld [wAIMinDamage], a
	ret

HungrySnorlaxRollout_AISelection:
	xor a
	ldh [hTemp_ffa0], a
	ret

HungrySnorlaxRollout_InitialEffect2:
	ld a, DUELVARS_ARENA_CARD_FOOD_COUNTERS
	get_turn_duelist_var
	ldh [hTemp_ffa0], a
	or a
	ret z
	inc a
	ldh [hffb2], a
	call EmptyScreen
	ld de, $0
	ld bc, $140d
	call DrawRegularTextBox
	ldtx hl, ChooseHowManyFoodCountersToRemoveText
	call DrawWideTextBox_PrintText
	ldh a, [hffb2]
	ld c, a
	ld de, $202
	ld b, $20
.asm_66247
	push bc
	ld a, b
	ld c, e
	ld b, d
	call WriteByteToBGMap0
	push de
	inc d
	ldtx hl, EffectTargetGeneralUnitText
	call InitTextPrinting_ProcessTextFromID
	pop de
	pop bc
	inc e
	inc b
	dec c
	jr nz, .asm_66247
	call EnableLCD
	ld hl, Data_66291
	xor a
	call InitializeMenuParameters
	ldh a, [hffb2]
	ld [wNumScrollMenuItems], a
.asm_6626c
	call DoFrame
	call HandleMenuInput
	jr nc, .asm_6626c
	cp $ff
	jr z, .asm_6627c
	ldh [hTemp_ffa0], a
	or a
	ret
.asm_6627c
	scf
	ret

HungrySnorlaxRollout_BeforeDamage:
	ldh a, [hTemp_ffa0]
	ld e, a
	ld a, DUELVARS_ARENA_CARD_FOOD_COUNTERS
	get_turn_duelist_var
	sub e
	ld [hl], a
	ld a, e
	add a
	add e
	call ATimes10
	farcall Func_68163
	ret

Data_66291:
	db $01
	db $02
	db $01
	db $06
	db $0f
	db $00
	db $00
	db $00

Func_66299:
    ret

MewtwoLv30EnergySpike_InitialEffect1:
	farcall Func_6808d
	call SwapTurn
	ld b, $ff
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
.asm_662a6
	inc b
	ld a, [hli]
	cp $ff
	jr z, .asm_662ba
	push hl
	push bc
	farcall Func_6822e
	pop bc
	pop hl
	jr c, .asm_662a6
.asm_662b6
	call SwapTurn
	ret
.asm_662ba
	ld hl, $e3
	scf
	jr .asm_662b6

MewtwoLv30EnergySpike_AISwitchDefendingPkmn:
	xor a
	ldh [hTemp_ffa0], a
	ret

MewtwoLv30EnergySpike_RequireSelection:
	ldtx de, AttackSuccessCheckText
	farcall Func_68079
	ldh [hTemp_ffa0], a
	jr c, .asm_662d4
	farcall Func_6809a
	ret
.asm_662d4
	ldtx hl, ChoosePokemonToRemoveEnergyFromText
	call DrawWideTextBox_WaitForInput
	call SwapTurn
.asm_662dd
	bank1call HasAlivePokemonInPlayArea
.asm_662e0
	bank1call OpenPlayAreaScreenForSelection
	jr c, .asm_662e0
	ldh a, [hTempPlayAreaLocation_ff9d]
	ld b, a
	farcall Func_6822e
	jr c, .asm_662e0
	ldh a, [hTempPlayAreaLocation_ff9d]
	ldh [hTempPlayAreaLocation_ffa1], a
	ld e, a
	bank1call DisplayEnergyDiscardMenu
	bank1call HandleAttachedEnergyMenuInput
	jr c, .asm_662dd
	ldh a, [hTempCardIndex_ff98]
	ldh [hTempRetreatCostCards], a
	ldtx hl, ChoosePokemonToAttachEnergyToText
	call DrawWideTextBox_WaitForInput
	bank1call HasAlivePokemonInPlayArea
.asm_66308
	bank1call OpenPlayAreaScreenForSelection
	jr c, .asm_66308
	ldh a, [hTempPlayAreaLocation_ff9d]
	ldh [hAIEnergyTransPlayAreaLocation], a
	call SwapTurn
	ret

MewtwoLv30EnergySpike_AfterDamage:
	ldh a, [hTemp_ffa0]
	or a
	ret z
	call SwapTurn
	ldh a, [hTempPlayAreaLocation_ffa1]
	ld e, a
	bank1call Func_6f49
	jr c, .asm_66341
	ldh a, [hAIEnergyTransPlayAreaLocation]
	ld e, a
	bank1call Func_6f49
	jr c, .asm_66341
	ldh a, [hAIEnergyTransPlayAreaLocation]
	ld e, a
	ldh a, [hTempRetreatCostCards]
	call AddCardToHand
	call PutHandCardInPlayArea
	ldh a, [hTempPlayAreaLocation_ffa1]
	or a
	jr nz, .asm_66341
	ld a, DUELVARS_ARENA_CARD_LAST_TURN_EFFECT
	get_turn_duelist_var
	ld [hl], $01
.asm_66341
	call SwapTurn
	ret

MewtwoLv30Telekinesis_AI:
	ld a, $1e
	farcall Func_68175
	ret

MewtwoLv30Telekinesis_RequireSelection:
	farcall Func_68686
	ret

MewtwoLv30Telekinesis_AISelection:
	farcall Func_686be
	ldh [hTemp_ffa0], a
	ret

MewtwoLv30Telekinesis_BeforeDamage:
	ldh a, [hTemp_ffa0]
	or a
	jr nz, .asm_66369
	farcall Func_682a9
	ret c
	ld a, $1e
	farcall Func_68175
	ret
.asm_66369
	xor a
	ld [wLoadedAttackAnimation], a
	ret

MewtwoLv30Telekinesis_AfterDamage:
	ldh a, [hTemp_ffa0]
	or a
	ret z
	call SwapTurn
	ld b, a
	ld a, $a8
	ld [wLoadedAttackAnimation], a
	ld de, $1e
	call DealDamageToPlayAreaPokemon
	call SwapTurn
	ret

PikachuLv13Recharge_InitialEffect1:
	farcall Func_2435f
	ret

PikachuLv13Recharge_RequireSelection:
	call CreateDeckCardList
	ldtx hl, ChooseALightningEnergyFromDeckText
	ldtx bc, EffectTargetLightningEnergyText
	ld a, CARDSEARCH_LIGHTNING_ENERGY
	farcall Func_24c9d
	jr c, .asm_663a5
	ldtx hl, ChooseALightningEnergyText
	ldtx de, DuelistDeckText
	farcall Func_24df8
.asm_663a5
	ldh [hTemp_ffa0], a
	ret

PikachuLv13Recharge_AISelection:
	ld a, CARDSEARCH_LIGHTNING_ENERGY
	farcall SetCardSearchFuncParams
	call CreateDeckCardList
	ld hl, wDuelTempList
.asm_663b4
	ld a, [hli]
	ldh [hTemp_ffa0], a
	cp $ff
	ret z
	farcall ExecuteCardSearchFunc
	jr nc, .asm_663b4
	ret

PikachuLv13Recharge_AfterDamage:
	ldh a, [hTemp_ffa0]
	cp $ff
	jr z, .asm_663cd
	call SearchCardInDeckAndAddToHand
	get_turn_duelist_var
	ld [hl], $10
.asm_663cd
	farcall Func_680a0
	ret

PikachuLv13Thunderbolt_BeforeDamage:
	xor a
	call CreateArenaOrBenchEnergyCardList
	ld hl, wDuelTempList
.asm_663d9
	ld a, [hli]
	cp $ff
	ret z
	call Func_0ffa
	jr .asm_663d9

Func_663e2:
	ld a, 15
	lb de, 0, 30
	farcall Func_680dd
	ret

FarfetchdAltLv20LeekSlap_InitialEffect1:
	ld a, DUELVARS_ARENA_CARD_FLAGS
	get_turn_duelist_var
	and $40
	ret z
	ld hl, $d1
	scf
	ret

FarfetchdAltLv20LeekSlap_DiscardEnergy:
	ld a, DUELVARS_ARENA_CARD_FLAGS
	get_turn_duelist_var
	set 6, [hl]
	ret

FarfetchdAltLv20LeekSlap_BeforeDamage:
	ldtx de, DamageCheckIfTailsNoDamageText
	farcall TossCoin_Bank1a
	ret c
	xor a
	farcall Func_6817e
	ret

KangaskhanLv38DizzyPunch_AI:
	ld a, 10
	lb de, 0, 20
	farcall Func_680dd
	ret

KangaskhanLv38DizzyPunch_BeforeDamage:
	ld hl, $a
	call LoadTxRam3
	ldtx de, DamageCheckXDamageTimesHeadsText
	ld a, $02
	farcall Func_68069
	call ATimes10
	farcall Func_6817e
	ret

DiglettLv16TripOver_AI:
	ld a, 25
	lb de, 20, 30
	farcall Func_680dd
	ret

DiglettLv16TripOver_BeforeDamage:
	ld a, $0a
	farcall Func_682e0
	ret

DugtrioLv40GoUnderground_InitialEffect1:
	scf
	ret

DugtrioLv40EarthWave_RequireSelection:
	farcall Func_6843b
	jr nc, .asm_6644a
	ld a, $ff
	ldh [hTemp_ffa0], a
	ret
.asm_6644a
	call SwapTurn
	ldtx hl, ChooseUpTo2BenchedPokemonToGiveDamageText
	call DrawWideTextBox_WaitForInput
	xor a
	ldh [hffb2], a
	ld [wcdf8], a
	bank1call Func_5c30
;   fallthrough

Func_6645c:
.asm_6645c
	bank1call PrintPlayAreaCardList_EnableLCD
	push af
	ld a, [wcdf8]
	ld hl, Data_66568
	call InitializeMenuParameters
	pop af
	dec a
	ld [wNumScrollMenuItems], a
.asm_6646e
	call DoFrame
	call HandleMenuInput
	ld a, e
	ld [wcdf8], a
	jr nc, .asm_6646e
	ldh a, [hCurScrollMenuItem]
	cp $ff
	jr z, .asm_664c0
	call Func_664e2
	jr nc, .asm_6648a
	call Func_3071
	jr .asm_6646e
.asm_6648a
	ldh a, [hCurScrollMenuItem]
	inc a
	ld b, $05
	farcall Func_6872f
	farcall Func_24350
	ldh a, [hCurScrollMenuItem]
	inc a
	ld [hl], a
	ldh a, [hffb2]
	ld c, a
	cp $02
	jr nc, .asm_664a9
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	dec a
	cp c
	jr nz, .asm_6645c
.asm_664a9
	ldh a, [hCurScrollMenuItem]
	inc a
	farcall Func_680ed
	ldh a, [hKeysPressed]
	and $02
	jr nz, .asm_664c0
	call SwapTurn
	farcall Func_24350
	ld [hl], $ff
	ret
.asm_664c0
	ldh a, [hffb2]
	or a
	jr z, .asm_6645c
	dec a
	ldh [hffb2], a
	ld e, a
	ld d, $00
	ld hl, hTemp_ffa0
	add hl, de
	ld a, [hl]
	push af
	ld b, $00
	farcall Func_6872f
	call EraseCursor
	pop af
	dec a
	ld [wcdf8], a
	jp Func_6645c

Func_664e2:
	inc a
	ld c, a
	ldh a, [hffb2]
	ld b, a
	ld hl, hTemp_ffa0
	inc b
	jr .asm_664f1
.asm_664ed
	ld a, [hli]
	cp c
	scf
	ret z
.asm_664f1
	dec b
	jr nz, .asm_664ed
	or a
	ret

DugtrioLv40EarthWave_AISelection:
	ld a, $f5
	call GetNonTurnDuelistVariable
	cp $03
	jr nc, .asm_6650f
	ld hl, hTemp_ffa0
	ld b, $00
	jr .asm_66508
.asm_66506
	ld [hl], b
	inc hl
.asm_66508
	inc b
	dec a
	jr nz, .asm_66506
	ld [hl], $ff
	ret
.asm_6650f
	call SwapTurn
	dec a
	ld c, a
	ld b, $01
	ld hl, hTemp_ffa0
.asm_66519
	ld [hl], b
	inc hl
	inc b
	dec c
	jr nz, .asm_66519
	ld [hl], $00
	ld de, hTemp_ffa0
.asm_66524
	ld a, [de]
	add DUELVARS_ARENA_CARD_HP
	get_turn_duelist_var
	ld c, a
	ld l, e
	ld h, d
	inc hl
.asm_6652c
	ld a, [hli]
	or a
	jr z, .asm_66541
	push hl
	add DUELVARS_ARENA_CARD_HP
	get_turn_duelist_var
	pop hl
	cp c
	jr c, .asm_6652c
	ld c, a
	dec hl
	ld b, [hl]
	ld a, [de]
	ld [hli], a
	ld a, b
	ld [de], a
	jr .asm_6652c
.asm_66541
	inc de
	ld a, [de]
	or a
	jr nz, .asm_66524
	ld a, $ff
	ldh [hTempRetreatCostCards], a
	call SwapTurn
	ret

DugtrioLv40EarthWave_AfterDamage:
	call SwapTurn
	ld hl, hTemp_ffa0
.asm_66554
	ld a, [hli]
	cp $ff
	jr z, .asm_66564
	push hl
	ld b, a
	ld de, $a
	call DealDamageToPlayAreaPokemon_RegularAnim
	pop hl
	jr .asm_66554
.asm_66564
	call SwapTurn
	ret

Data_66568:
	db $00
	db $03
	db $03
	db $06
	db $0f
	db $00
	db $00
	db $00

DragoniteLv43SpecialDelivery_InitialEffect2:
	farcall Func_6844f
	ret c
	farcall Func_2435f
	ret

DragoniteLv43SpecialDelivery_RequireSelection:
	call DrawCardFromDeck
	ldh [hTempRetreatCostCards], a
	ldh [hTempCardIndex_ff98], a
	call AddCardToHand
	bank1call DisplayPlayerDrawCardScreen
	ldtx hl, ChooseCardToReturnToTopDeckText
	call DrawWideTextBox_WaitForInput
	call CreateHandCardList
	bank1call Func_5221
.asm_66593
	bank1call DisplayCardList
	jr c, .asm_66593
	ldh [hTempPlayAreaLocation_ffa1], a
	ldh a, [hTempRetreatCostCards]
	call RemoveCardFromHand
	call ReturnCardToDeck
	or a
	ret

DragoniteLv43SpecialDelivery_BeforeDamage:
	farcall Func_68465
	call DrawCardFromDeck
	call AddCardToHand
	ldh a, [hTempPlayAreaLocation_ffa1]
	call RemoveCardFromHand
	call ReturnCardToDeck
	ret

DragoniteLv43SupersonicFlight_AI:
	ld a, 60
	lb de, 0, 60
	farcall Func_680dd
	ret

DragoniteLv43SupersonicFlight_BeforeDamage:
	ldtx de, AttackSuccessCheckText
	farcall TossCoin_Bank1a
	ret c
	xor a
	ld [wLoadedAttackAnimation], a
	farcall Func_6817e
	farcall Func_6809a
	ret

MagikarpLv10Trickle_AI:
	ld a, 10
	lb de, 0, 20
	farcall Func_680dd
	ret

MagikarpLv10Trickle_BeforeDamage:
	ld hl, $a
	call LoadTxRam3
	ldtx de, DamageCheckXDamageTimesHeadsText
	ld a, $02
	farcall Func_68069
	call ATimes10
	farcall Func_6817e
	ret

MagikarpLv10DragonRage_AI:
	ld a, 50
	lb de, 0, 50
	farcall Func_680dd
	ret

MagikarpLv10DragonRage_BeforeDamage:
	ldtx de, FailIfEitherOf2CoinsIsTailsText
	ld a, $02
	farcall Func_68069
	cp $02
	ret z
	xor a
	ld [wLoadedAttackAnimation], a
	farcall Func_6817e
	farcall Func_6809a
	ret

TogepiSnivel_BeforeDamage:
	ld a, $03
	farcall Func_6812e
	ret

TogepiMetronome_InitialEffect1:
	farcall Func_6808d
	farcall Func_68501
	ret c
	ld a, [wcc1b]
	or a
	ret nz
	ld hl, $46
	scf
	ret

TogepiMetronome_AISelection:
	call Func_66653
	jr c, Func_66651
	farcall Func_6a9dd
	ret

TogepiMetronome_InitialEffect2:
	call Func_66653
	jr c, Func_66651
	ld a, $02
	farcall Func_6a958
	ld a, [wcd16]
	or a
	jr z, Func_66651
	scf
	ret

Func_66651:
	or a
	ret

Func_66653:
	ld a, [wcc1b]
	cp $01
	jr nz, .asm_6665c
	or a
	ret
.asm_6665c
	ldtx de, AttackSuccessCheckText
	farcall Func_68079
	ld [wcc1b], a
	ccf
	ret nc
	xor a
	ld [wLoadedAttackAnimation], a
	farcall Func_6809a
	scf
	ret

MarillWaterGun_BeforeDamage:
	ld bc, $200
	farcall Func_68e88
	ret

MankeyAltLv7Peek_InitialEffect2:
	farcall Func_6844f
	ret

MankeyAltLv7Peek_BeforeDamage:
	farcall MankeyLv7Peek_BeforeDamage
	ret

IvysaurLv26LeechSeedAlt_AfterDamage:
	ld hl, wDealtDamage
	ld a, [hli]
	or [hl]
	ret z
	ld de, $a
	farcall ApplyAndAnimateHPRecovery
	ret

RaichuLv33QuickAttack_AI:
	ld a, 20
	lb de, 10, 30
	farcall Func_680dd
	ret

RaichuLv33QuickAttack_BeforeDamage:
	ld a, $14
	farcall Func_682e0
	ret

RaichuLv33Thunderbolt_BeforeDamage:
	xor a
	call CreateArenaOrBenchEnergyCardList
	ld hl, wDuelTempList
.asm_666aa
	ld a, [hli]
	cp $ff
	ret z
	call Func_0ffa
	jr .asm_666aa

JynxLv27DoubleSlap_AI:
	ld a, 20
	lb de, 0, 40
	farcall Func_680dd
	ret

JynxLv27DoubleSlap_BeforeDamage:
	ld hl, $14
	call LoadTxRam3
	ldtx de, DamageCheckXDamageTimesHeadsText
	ld a, $02
	farcall Func_68069
	add a
	call ATimes10
	farcall Func_6817e
	ret

MeowthLv17FurySwipes_AI:
	ld a, 20
	lb de, 0, 40
	farcall Func_680dd
	ret

MeowthLv17FurySwipes_BeforeDamage:
	ld hl, $a
	call LoadTxRam3
	ldtx de, DamageCheckXDamageTimesHeadsText
	ld a, $03
	farcall Func_68069
	call ATimes10
	farcall Func_6817e
	ret

GrowlitheLv12Lunge_AI:
	ld a, 20
	lb de, 0, 20
	farcall Func_680dd
	ret

GrowlitheLv12Lunge_BeforeDamage:
	ldtx de, AttackSuccessCheckText
	farcall TossCoin_Bank1a
	ret c
	xor a
	ld [wLoadedAttackAnimation], a
	farcall Func_6817e
	farcall Func_6809a
	ret

GrowlitheLv12Ember_InitialEffect1:
	farcall Func_6927b
	ret

GrowlitheLv12Ember_InitialEffect2:
	farcall Func_6926c
	ret

GrowlitheLv12Ember_AISelection:
	farcall Func_69291
	ret

GrowlitheLv12Ember_DiscardEnergy:
	ldh a, [hTemp_ffa0]
	call Func_0ffa
	ret

ArcanineLv35TakeDown_AfterDamage:
	ld a, $14
	call DealRecoilDamageToSelf
	ret

SuperScoopUp_InitialEffect1:
	farcall Func_6808d
	farcall Func_68446
	ret

SuperScoopUp_RequireSelection:
	ldtx de, TrainerCardSuccessCheckText
	farcall Func_68079
	ldh [hTemp_ffa0], a
	ret nc
	ldtx hl, ChoosePokemonToReturnToHandText
	call DrawWideTextBox_WaitForInput
	bank1call HasAlivePokemonInPlayArea
.asm_6674c
	bank1call OpenPlayAreaScreenForSelection
	jr c, .asm_6674c
	ldh [hTempPlayAreaLocation_ffa1], a
	or a
	ret nz
	call EmptyScreen
	ldtx hl, SelectPokemonToPlaceInTheArenaText
	call DrawWideTextBox_WaitForInput
	bank1call HasAlivePokemonInBench
	bank1call OpenPlayAreaScreenForSelection
	ldh [hTempRetreatCostCards], a
	ret

SuperScoopUp_BeforeDamage:
	ldh a, [hTemp_ffa0]
	or a
	ret z
	ldh a, [hTempPlayAreaLocation_ffa1]
	add DUELVARS_ARENA_CARD
	get_turn_duelist_var
	ldh [hTempCardIndex_ff98], a
	ldh a, [hTempPlayAreaLocation_ffa1]
	or $10
	ld c, a
	ld a, DUELVARS_CARD_LOCATIONS
	get_turn_duelist_var
.asm_6677a
	ld a, [hl]
	cp c
	jr nz, .asm_66782
	ld a, l
	call AddCardToHand
.asm_66782
	inc l
	ld a, l
	cp $3c
	jr c, .asm_6677a
	ldh a, [hTempPlayAreaLocation_ffa1]
	ld e, a
	call Func_12fc
	farcall Func_680ab
	jr c, .asm_667a4
	ld hl, $1fd
	ldh a, [hTempPlayAreaLocation_ffa1]
	or a
	jr z, .asm_6679f
	ld hl, $1fe
.asm_6679f
	ldh a, [hTempCardIndex_ff98]
	bank1call DisplayCardDetailScreen
.asm_667a4
	ldh a, [hTempPlayAreaLocation_ffa1]
	or a
	jr nz, .asm_667b4
	call ClearAllStatusConditions
	ldh a, [hTempRetreatCostCards]
	ld d, a
	ld e, $00
	call SwapPlayAreaPokemon
.asm_667b4
	call ShiftAllPokemonToFirstPlayAreaSlots
	ret

BillsTeleporter_BeforeDamage:
	ldtx de, TrainerCardSuccessCheckText
	farcall TossCoin_Bank1a
	ret nc
	ldh a, [hTempCardIndex_ff9f]
	call RemoveCardFromHand
	ld a, $04
	farcall DisplayDrawNCardsScreen
	ld c, $04
.asm_667cd
	call DrawCardFromDeck
	jr c, .asm_667e5
	ldh [hTempCardIndex_ff98], a
	call AddCardToHand
	farcall Func_680ab
	jr nc, .asm_667e2
	push bc
	bank1call DisplayPlayerDrawCardScreen
	pop bc
.asm_667e2
	dec c
	jr nz, .asm_667cd
.asm_667e5
	ret

DarkClefableDarknessVeil_InitialEffect1:
	scf
	ret

DarkClefableDarkSong_BeforeDamage:
	ldtx de, SleepInflictionCheckText
	farcall TossCoin_Bank1a
	ldh [hTemp_ffa0], a
	ret nc
	farcall Func_6805c
	ret

DarkClefableDarkSong_AfterDamage:
	ldh a, [hTemp_ffa0]
	or a
	ret z
	farcall Func_6843b
	ret c
	dec a
	ld c, a
	ld b, $01
	call SwapTurn
	ld a, DUELVARS_BENCH
	get_turn_duelist_var
.asm_6680a
	ld a, [hli]
	push hl
	push bc
	call LoadCardDataToBuffer1_FromDeckIndex
	ld a, [wLoadedCard1Dark]
	or a
	jr nz, .asm_6681f
	ld de, $a
	bank1call Func_6f37
	call DealDamageToPlayAreaPokemon_RegularAnim
.asm_6681f
	pop bc
	pop hl
	inc b
	dec c
	jr nz, .asm_6680a
	call SwapTurn
	ret

DarkHaunterBother_BeforeDamage:
	ldtx de, BotherCheckText
	farcall TossCoin_Bank1a
	ldh [hTemp_ffa0], a
	ret

DarkHaunterBother_AfterDamage:
	ldh a, [hTemp_ffa0]
	or a
	ret z
	call SwapTurn
	call CreateHandCardList
	ld hl, $e7
	jr c, .asm_66870
	call Func_66877
	ldtx hl, NoTrainerCardsInOppHandText
	jr c, .asm_66870
	ld hl, wDuelTempList
	call CountCardsInDuelTempList
	call ShuffleCards
	call Func_66877
	push af
	call LoadCardDataToBuffer1_FromDeckIndex
	pop af
	call RemoveCardFromHand
	call ReturnCardToDeck
	ldtx hl, PokemonWasReturnedToDeckText
	farcall _DisplayCardDetailScreen
	farcall Func_680a0
	call SwapTurn
	ret
.asm_66870
	call SwapTurn
	call DrawWideTextBox_PrintText
	ret

Func_66877:
	ld hl, wDuelTempList
.asm_6687a
	ld a, [hli]
	cp $ff
	scf
	ret z
	call GetCardIDFromDeckIndex
	call GetCardType
	cp $10
	jr nz, .asm_6687a
	dec hl
	ld a, [hl]
	or a
	ret

DarkGengarPlayTricks_InitialEffect2:
	farcall Func_6843b
	ret c
	call SwapTurn
	farcall Func_68335
	call SwapTurn
	ld hl, $b5
	ret c
	farcall Func_6844f
	ret

DarkGengarPlayTricks_BeforeDamage:
	farcall Func_68465
	call SwapTurn
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	ld [wcdf8], a
	ld c, $1e
.asm_668b4
	push bc
	ld a, [wcdf8]
	call Random
	ld [wTempPlayAreaLocation_cceb], a
	add DUELVARS_ARENA_CARD_HP
	get_turn_duelist_var
	cp $14
	jr c, .asm_668e2
	ld a, [wcdf8]
	call Random
	ld e, a
	call GetCardDamageAndMaxHP
	or a
	jr z, .asm_668e2
	ld a, e
	add DUELVARS_ARENA_CARD_HP
	get_turn_duelist_var
	add $0a
	ld [hl], a
	ld a, [wTempPlayAreaLocation_cceb]
	add DUELVARS_ARENA_CARD_HP
	get_turn_duelist_var
	sub $0a
	ld [hl], a
.asm_668e2
	pop bc
	dec c
	jr nz, .asm_668b4
	xor a
	farcall Func_680ed
	call SwapTurn
	ret

DarkGengarPushAside_BeforeDamage:
	xor a
	ld [wLoadedAttackAnimation], a
	ldtx de, AttackSuccessCheckText
	farcall TossCoin_Bank1a
	ldh [hTemp_ffa0], a
	ret c
	farcall Func_6809a
	ret

DarkGengarPushAside_AfterDamage:
	ldh a, [hTemp_ffa0]
	or a
	ret z
	call SwapTurn
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	call Random
	ldh [hTempPlayAreaLocation_ffa1], a
	ldh [hTempPlayAreaLocation_ff9d], a
	ld a, $fd
	farcall Func_18a87
	ldh a, [hTempPlayAreaLocation_ffa1]
	ld e, a
	bank1call Func_6f49
	call SwapTurn
	ret c
	ldh a, [hTempPlayAreaLocation_ffa1]
	ld e, a
	ld b, e
	ld a, e
	or $10
	ld c, a
	call SwapTurn
	ld a, DUELVARS_CARD_LOCATIONS
	get_turn_duelist_var
.asm_66931
	ld a, [hl]
	cp c
	jr nz, .asm_66939
	ld a, l
	call ReturnCardToDeck
.asm_66939
	inc l
	ld a, l
	cp $3c
	jr c, .asm_66931
	ld a, b
	add $bb
	ld l, a
	ld a, [hl]
	ld [hl], $ff
	call LoadCardDataToBuffer1_FromDeckIndex
	ld a, b
	add $c8
	ld l, a
	ld [hl], $00
	ld a, b
	add $da
	ld l, a
	ld [hl], $00
	ld hl, wLoadedCard1Name
	ld a, [hli]
	ld h, [hl]
	ld l, a
	call LoadTxRam2
	ldtx hl, PokemonAndAllAttachedCardsWereReturnedToDeckText
	call DrawWideTextBox_WaitForInput
	farcall Func_680a0
	call SwapTurn
	ret

DarkStarmieRebirth_InitialEffect2:
	ldh a, [hTempPlayAreaLocation_ff9d]
	ldh [hTemp_ffa0], a
	bank1call CheckIsIncapableOfUsingPkmnPower
	ret

DarkStarmieRebirth_BeforeDamage:
	call CreateDeckCardList
	jr c, .asm_669cf
	ld hl, wDuelTempList
.asm_6697c
	ld a, [hli]
	ldh [hTempCardIndex_ff98], a
	cp $ff
	jr z, .asm_669cf
	call GetCardIDFromDeckIndex
	cp16 STARYU_LV15
	jr z, .asm_6699a
	cp16 STARYU_LV17
	jr nz, .asm_6697c
.asm_6699a
	ldh a, [hTempPlayAreaLocation_ff9d]
	ld e, a
	call Func_12fc
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	inc [hl]
	ldh a, [hTempCardIndex_ff98]
	call SearchCardInDeckAndAddToHand
	ldh a, [hTempPlayAreaLocation_ff9d]
	add DUELVARS_ARENA_CARD
	get_turn_duelist_var
	ldh a, [hTempCardIndex_ff98]
	ld [hl], a
	ld l, a
	ldh a, [hTempPlayAreaLocation_ff9d]
	or $10
	ld [hl], a
	ldh a, [hTempPlayAreaLocation_ff9d]
	add $ce
	ld l, a
	ld [hl], $00
	farcall Func_68556
	ldh a, [hTempPlayAreaLocation_ff9d]
	ld e, a
	call GetCardDamageAndMaxHP
	ldh a, [hTempPlayAreaLocation_ff9d]
	add DUELVARS_ARENA_CARD_HP
	get_turn_duelist_var
	ld [hl], c
	ret
.asm_669cf
	farcall Func_6809a
	call Func_19e1
	call WaitForWideTextBoxInput
	ret

DarkStarmieSpinningShower_BeforeDamage:
	ldtx de, AttackSuccessCheckText
	farcall TossCoin_Bank1a
	ldh [hTemp_ffa0], a
	ret c
	xor a
	ld [wLoadedAttackAnimation], a
	ret

DarkStarmieSpinningShower_AfterDamage:
	ldh a, [hTemp_ffa0]
	or a
	ret z
	ld hl, wLoadedAttackCategory
	res 7, [hl]
	farcall Func_6843b
	ld c, a
	ld b, a
	dec a
	jr z, .asm_66a17
	ld hl, wce02
	push hl
	xor a
.asm_66a00
	ld [hli], a
	inc a
	dec c
	jr nz, .asm_66a00
	pop hl
	ld a, b
	call ShuffleCards
	ld a, [hl]
	call .asm_66a17
	call UpdateRNGSources
	and $01
	ret z
	ld a, [wce03]
.asm_66a17
	call SwapTurn
	ld [wTempPlayAreaLocation_cceb], a
	ld b, a
	ld de, $14
	bank1call Func_6f34
	call DealDamageToPlayAreaPokemon_RegularAnim
	call Func_66a3c
	call SwapTurn
	ret

Func_66a2e:
	call SwapTurn
	xor a
	ld [wTempPlayAreaLocation_cceb], a
	call Func_66a3c
	call SwapTurn
	ret

Func_66a3c:
	ld a, [wTempPlayAreaLocation_cceb]
	ld e, a
	bank1call Func_6f49
	ret c
	ld a, [wTempPlayAreaLocation_cceb]
	call CreateArenaOrBenchEnergyCardList
	ret c
	ld hl, wDuelTempList
	call ShuffleCards
	ld a, [wDuelTempList]
	call Func_0ffa
	ld a, [wTempPlayAreaLocation_cceb]
	or a
	ret nz
	ld a, DUELVARS_ARENA_CARD_LAST_TURN_EFFECT
	get_turn_duelist_var
	ld [hl], $08
	ret

DarkFearowFlyHigh_BeforeDamage:
	ld a, $1e
	farcall Func_6810e
	ret

DarkFearowDrillDive_InitialEffect1:
	ld a, $30
	farcall Func_68478
	ret

DarkFearowDrillDive_AfterDamage:
	ld a, $30
	farcall Func_6846d
	ret

DarkRaichuSurpriseThunder_AfterDamage:
	farcall Func_6843b
	ret c
	ld a, $03
	call Random
	call ATimes10
	ld e, a
	ld d, $00
	call SwapTurn
	bank1call Func_6f37
	ld a, e
	farcall Func_680f9
	call SwapTurn
	ret

DarkNinetalesPerplex_BeforeDamage:
	call SwapTurn
	ldtx de, PerplexCheckText
	farcall TossCoin_Bank1a
	call SwapTurn
	jr c, .asm_66aad
	ld a, $f1
	call GetNonTurnDuelistVariable
	set 7, [hl]
	ret
.asm_66aad
	xor a
	ld [wLoadedAttackAnimation], a
	ret

DarkNinetalesNineTails_AI:
	ld a, 45
	lb de, 0, 90
	farcall Func_680dd
	ret

DarkNinetalesNineTails_BeforeDamage:
	ld hl, $a
	call LoadTxRam3
	ldtx de, DamageCheckXDamageTimesHeadsText
	ld a, $09
	farcall Func_68069
	call ATimes10
	farcall Func_6817e
	ret

DarkMarowakBoneHeadbutt_AfterDamage:
	farcall Func_6843b
	ret c
	call SwapTurn
	dec a
	call Random
	inc a
	ld b, a
	ld a, $03
	call Random
	call ATimes10
	ld e, a
	ld d, $00
	push bc
	bank1call Func_6f37
	call DealDamageToPlayAreaPokemon_RegularAnim
	pop bc
	ld a, [wNoDamageOrEffect]
	cp $07
	jr z, .asm_66b14
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	dec a
	call Random
	inc a
	ld e, a
	bank1call Func_6f49
	jr c, .asm_66b14
	call SwapArenaWithBenchPokemon
	ld a, e
	ld [wccef], a
	xor a
	ld [wccc5], a
.asm_66b14
	xor a
	ld [wDuelDisplayedScreen], a
	call SwapTurn
	ret

GRsMewtwoDarkWave_InitialEffect1:
	scf
	ret

GRsMewtwoDarkAmplification_AI:
	call Func_66b45
	ret c
	call ATimes10
	farcall Func_68163
	ret

GRsMewtwoDarkAmplification_BeforeDamage:
	call Func_66b45
	ret c
	ld hl, $14
	call LoadTxRam3
	ldtx de, DamageCheckPlusXDamageForEachHeadsText
	ld a, b
	farcall Func_68069
	add a
	call ATimes10
	farcall Func_68163
	ret

Func_66b45:
	ld b, $00
	farcall Func_68446
	ret c
	ld c, a
	ld a, DUELVARS_ARENA_CARD
	get_turn_duelist_var
.asm_66b50
	ld a, [hli]
	call LoadCardDataToBuffer1_FromDeckIndex
	ld a, [wLoadedCard1Dark]
	or a
	jr z, .asm_66b5b
	inc b
.asm_66b5b
	dec c
	jr nz, .asm_66b50
	ld a, b
	or a
	ret nz
	scf
	ret

DarkIvysaurVinePull_InitialEffect1:
	scf
	ret

DarkIvysaurFuryStrikes_AfterDamage:
	ld hl, wLoadedAttackCategory
	res 7, [hl]
	call Func_659bf
	call SwapTurn
	ld c, $03
.asm_66b72
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	call Random
	ld e, a
	ld d, $00
	ld hl, wce02
	add hl, de
	inc [hl]
	dec c
	jr nz, .asm_66b72
	ld hl, wce02
	ld b, $00
	ld c, $06
.asm_66b8a
	ld a, [hli]
	push hl
	push bc
	or a
	jr z, .asm_66ba2
	call ATimes10
	ld e, a
	ld d, $00
	ld a, b
	or a
	jr z, .asm_66b9f
	push bc
	bank1call Func_6f37
	pop bc
.asm_66b9f
	call DealDamageToPlayAreaPokemon_RegularAnim
.asm_66ba2
	pop bc
	pop hl
	inc b
	dec c
	jr nz, .asm_66b8a
	call SwapTurn
	ret

DarkVenusaurHorridPollen_BeforeDamage:
	farcall Func_68012
	ld a, $03
	call Random
	dec a
	jr z, .asm_66bc0
	dec a
	jr z, .asm_66bc5
	farcall Func_6802e
	ret
.asm_66bc0
	farcall Func_68045
	ret
.asm_66bc5
	farcall Func_6805c
	ret

LugiaAeroblast_AI:
	ld a, $14
	farcall Func_68163
	ret

LugiaAeroblast_BeforeDamage:
	ld hl, $14
	call LoadTxRam3
	ldtx de, DamageCheckPlusXDamageForEachHeadsText
	ld a, $02
	farcall Func_68069
	add a
	call ATimes10
	farcall Func_68163
	ret

Func_66be9:
	farcall Func_680a0
	ret

Func_66bee:
	farcall Func_680ab
	ret

SuperPotion_InitialEffect1:
	farcall Func_68335
	ld hl, $b5
	ret c
	call Func_66c5f
	ld hl, $d8
	ret

SuperPotion_InitialEffect2:
	ldtx hl, ChoosePokemonToRemoveDamageCounterFromText_2
	call DrawWideTextBox_WaitForInput
.asm_66c08
	bank1call HasAlivePokemonInPlayArea
.asm_66c0b
	bank1call OpenPlayAreaScreenForSelection
	ret c
	ld e, a
	call GetCardDamageAndMaxHP
	or a
	jr z, .asm_66c0b
	ldh a, [hCurScrollMenuItem]
	ld e, a
	call GetPlayAreaCardAttachedEnergies
	ld a, [wTotalAttachedEnergies]
	or a
	jr nz, .asm_66c2a
	ldtx hl, NoEnergyCardsText
	call DrawWideTextBox_WaitForInput
	jr .asm_66c08
.asm_66c2a
	ldh a, [hCurScrollMenuItem]
	bank1call CreateArenaOrBenchEnergyCardList
	ldh a, [hCurScrollMenuItem]
	bank1call DisplayEnergyDiscardMenu
	bank1call HandleAttachedEnergyMenuInput
	ret c
	ldh a, [hTempCardIndex_ff98]
	ldh [hTemp_ffa0], a
	ldh a, [hTempPlayAreaLocation_ff9d]
	ldh [hTempPlayAreaLocation_ffa1], a
	ld e, a
	call GetCardDamageAndMaxHP
	ld c, $28
	cp $28
	jr nc, .asm_66c4b
	ld c, a
.asm_66c4b
	ld a, c
	ldh [hTempRetreatCostCards], a
	or a
	ret

SuperPotion_BeforeDamage:
	ldh a, [hTemp_ffa0]
	call Func_0ffa
	ldh a, [hTempPlayAreaLocation_ffa1]
	ldh [hTempPlayAreaLocation_ff9d], a
	ldh a, [hTempRetreatCostCards]
	call Func_67859
	ret

Func_66c5f:
	ld a, DUELVARS_CARD_LOCATIONS
	get_turn_duelist_var
.asm_66c62
	ld a, [hl]
	bit 4, a
	jr z, .asm_66c76
	ld a, l
	call LoadCardDataToBuffer2_FromDeckIndex
	ld a, [wLoadedCard2Type]
	cp $10
	jr z, .asm_66c76
	cp $08
	jr nc, .asm_66c7e
.asm_66c76
	inc l
	ld a, l
	cp $3c
	jr c, .asm_66c62
	scf
	ret
.asm_66c7e
	or a
	ret

Func_66c80:
.asm_66c80
	bank1call HasAlivePokemonInPlayArea
	bank1call OpenPlayAreaScreenForSelection
	ret c
	ld e, a
	call GetPlayAreaCardAttachedEnergies
	ld a, [wTotalAttachedEnergies]
	or a
	jr nz, .asm_66c99
	ldtx hl, NoEnergyCardsText
	call DrawWideTextBox_WaitForInput
	jr .asm_66c80
.asm_66c99
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

ImakuniCard_BeforeDamage:
	bank1call CheckIfArenaCardIsProtectedFromStatusCondition
	push af
	ld a, $7f
	call Func_67843
	pop af
	jr nc, .asm_66cc2
	ldtx hl, ThereWasNoEffectText
	call DrawWideTextBox_WaitForInput
	ret
.asm_66cc2
	ld a, DUELVARS_ARENA_CARD_STATUS
	get_turn_duelist_var
	and $f0
	or $01
	ld [hl], a
	bank1call DrawDuelHUDs
	ret

EnergyRemoval_InitialEffect1:
	call SwapTurn
	call Func_66c5f
	ld hl, $b7
	call SwapTurn
	ret

EnergyRemoval_InitialEffect2:
	ld hl, VBlankHandler.done
	call DrawWideTextBox_WaitForInput
	call SwapTurn
	call Func_66c80
	call SwapTurn
	ret

EnergyRemoval_AISelection:
	farcall Func_685dd
	ret

EnergyRemoval_BeforeDamage:
	call SwapTurn
	ldh a, [hTempPlayAreaLocation_ffa1]
	call Func_0ffa
	call SwapTurn
	call Func_66bee
	ret c
	call SwapTurn
	ldh a, [hTemp_ffa0]
	farcall Func_680ed
	call SwapTurn
	ret

EnergyRetrieval_InitialEffect1:
	ld a, DUELVARS_NUMBER_OF_CARDS_IN_HAND
	get_turn_duelist_var
	cp $02
	ld hl, $bf
	ret c
	farcall CreateEnergyCardListFromDiscardPile_OnlyBasic
	ld hl, $b9
	ret

EnergyRetrieval_InitialEffect2:
	ldtx hl, ChooseCardFromHandToDiscardText
	call DrawWideTextBox_WaitForInput
	call CreateHandCardList
	ldh a, [hTempCardIndex_ff9f]
	call RemoveCardFromDuelTempList
	bank1call Func_5221
	bank1call DisplayCardList
	ldh a, [hTempCardIndex_ff98]
	ldh [hTemp_ffa0], a
	ret

EnergyRetrieval_RequireSelection:
	ld a, $01
	ldh [hffb2], a
	ldtx hl, Choose2BasicEnergyCardsFromDiscardPileText
	call DrawWideTextBox_WaitForInput
	farcall CreateEnergyCardListFromDiscardPile_OnlyBasic
.asm_66d44
	bank1call InitAndDrawCardListScreenLayout
	ldtx hl, PleaseSelectCardText
	ldtx de, DuelistDiscardPileText
	bank1call SetCardListHeaderAndInfoText
	bank1call DisplayCardList
	jr nc, .asm_66d5f
	ld a, $03
	farcall Func_6856d
	jr c, .asm_66d44
	jr .asm_66d71
.asm_66d5f
	farcall Func_24350
	ldh a, [hTempCardIndex_ff98]
	ld [hl], a
	call RemoveCardFromDuelTempList
	jr c, .asm_66d71
	ldh a, [hffb2]
	cp $03
	jr c, .asm_66d44
.asm_66d71
	farcall Func_24350
	ld [hl], $ff
	or a
	ret

EnergyRetrieval_BeforeDamage:
	ld hl, hTemp_ffa0
	ld a, [hli]
	call RemoveCardFromHand
	call PutCardInDiscardPile
	ld de, wDuelTempList
.asm_66d86
	ld a, [hli]
	ld [de], a
	inc de
	cp $ff
	jr z, .asm_66d95
	call MoveDiscardPileCardToHand
	call AddCardToHand
	jr .asm_66d86
.asm_66d95
	call Func_66bee
	ret c
	bank1call Func_49e8
	ret

EnergySearch_InitialEffect1:
	ld a, DUELVARS_NUMBER_OF_CARDS_NOT_IN_DECK
	get_turn_duelist_var
	cp $3c
	ccf
	ld hl, $ba
	ret

EnergySearch_RequireSelection:
	call CreateDeckCardList
	ldtx hl, Choose1BasicEnergyCardFromDeckText
	ldtx bc, EffectTargetBasicEnergyText
	ld a, CARDSEARCH_BASIC_ENERGY
	farcall Func_24c9d
	jr c, .asm_66dc2
	ldtx hl, ChooseBasicEnergyCardText
	ldtx de, DuelistDeckText
	farcall Func_24df8
.asm_66dc2
	ldh [hTemp_ffa0], a
	ret

EnergySearch_BeforeDamage:
	ldh a, [hTemp_ffa0]
	cp $ff
	jr z, .asm_66dde
	call SearchCardInDeckAndAddToHand
	call AddCardToHand
	call Func_66bee
	jr c, .asm_66dde
	ldh a, [hTemp_ffa0]
	ldtx hl, WasPlacedInTheHandText
	bank1call DisplayCardDetailScreen
.asm_66dde
	call Func_66be9
	ret

Func_66de2:
	call LoadCardDataToBuffer2_FromDeckIndex
	ld a, [wLoadedCard2Type]
	cp $08
	jr c, .asm_66df2
	cp $0e
	jr nc, .asm_66df2
	or a
	ret
    .asm_66df2
	scf
	ret

ProfessorOak_BeforeDamage:
	call CreateHandCardList
	bank1call SortCardsInDuelTempListByID
	ld hl, wDuelTempList
.asm_66dfd
	ld a, [hli]
	cp $ff
	jr z, .asm_66e0a
	call RemoveCardFromHand
	call PutCardInDiscardPile
	jr .asm_66dfd
.asm_66e0a
	ld a, $07
	farcall DisplayDrawNCardsScreen
	ld c, $07
.asm_66e12
	call DrawCardFromDeck
	jr c, .asm_66e1d
	call AddCardToHand
	dec c
	jr nz, .asm_66e12
.asm_66e1d
	ret

Potion_InitialEffect1:
	farcall Func_68335
	ld hl, $b5
	ret

Potion_InitialEffect2:
	bank1call HasAlivePokemonInPlayArea
.asm_66e29
	bank1call OpenPlayAreaScreenForSelection
	ret c
	ldh a, [hTempPlayAreaLocation_ff9d]
	ldh [hTemp_ffa0], a
	ld e, a
	call GetCardDamageAndMaxHP
	or a
	jr z, .asm_66e29
	ld c, $14
	cp $14
	jr nc, .asm_66e3f
	ld c, a
.asm_66e3f
	ld a, c
	ldh [hTempPlayAreaLocation_ffa1], a
	or a
	ret

Potion_BeforeDamage:
	ldh a, [hTemp_ffa0]
	ldh [hTempPlayAreaLocation_ff9d], a
	ldh a, [hTempPlayAreaLocation_ffa1]
	call Func_67859
	ret

Gambler_BeforeDamage:
	ldtx de, GamblerQuantityCheckText
	farcall TossCoin_Bank1a
	ldh [hTemp_ffa0], a
	ldh a, [hTempCardIndex_ff9f]
	call RemoveCardFromHand
	call PutCardInDiscardPile
	call CreateHandCardList
	bank1call SortCardsInDuelTempListByID
	ld hl, wDuelTempList
.asm_66e68
	ld a, [hli]
	cp $ff
	jr z, .asm_66e75
	call RemoveCardFromHand
	call ReturnCardToDeck
	jr .asm_66e68
.asm_66e75
	call Func_66be9
	ld c, $08
	ldh a, [hTemp_ffa0]
	or a
	jr nz, .asm_66e81
	ld c, $01
.asm_66e81
	ld a, c
	farcall DisplayDrawNCardsScreen
.asm_66e86
	call DrawCardFromDeck
	jr c, .asm_66e91
	call AddCardToHand
	dec c
	jr nz, .asm_66e86
.asm_66e91
	ret

Itemfinder_InitialEffect1:
	ld a, DUELVARS_NUMBER_OF_CARDS_IN_HAND
	get_turn_duelist_var
	ld hl, $bf
	cp $03
	ret c
	farcall Func_683b4
	ret

Itemfinder_InitialEffect2:
	call Func_677d3
	ret c
	farcall Func_683b4
	bank1call Func_5221
	ldtx hl, ChooseCardToPlaceInHandText
	ldtx de, DuelistDiscardPileText
	bank1call SetCardListHeaderAndInfoText
	bank1call DisplayCardList
	ldh [hTempRetreatCostCards], a
	ret

Itemfinder_BeforeDamage:
	ld hl, hTemp_ffa0
	ld a, [hli]
	call RemoveCardFromHand
	call PutCardInDiscardPile
	ld a, [hli]
	call RemoveCardFromHand
	call PutCardInDiscardPile
	ld a, [hl]
	call MoveDiscardPileCardToHand
	call AddCardToHand
	call Func_66bee
	ret c
	ldh a, [hTempRetreatCostCards]
	ldtx hl, WasPlacedInTheHandText
	bank1call DisplayCardDetailScreen
	ret

Defender_InitialEffect2:
	ldtx hl, ChoosePokemonToAttachDefenderToText
	call DrawWideTextBox_WaitForInput
	bank1call HasAlivePokemonInPlayArea
	bank1call OpenPlayAreaScreenForSelection
	ldh a, [hTempPlayAreaLocation_ff9d]
	ldh [hTemp_ffa0], a
	ret

Defender_BeforeDamage:
	ldh a, [hTemp_ffa0]
	ld e, a
	ldh a, [hTempCardIndex_ff9f]
	call PutHandCardInPlayArea
	ldh a, [hTemp_ffa0]
	add DUELVARS_ARENA_CARD_ATTACHED_DEFENDER
	get_turn_duelist_var
	inc [hl]
	call Func_66bee
	ret c
	ldh a, [hTemp_ffa0]
	farcall Func_680ed
	ret

MysteriousFossil_InitialEffect1:
	farcall Func_24369
	ret

MysteriousFossil_BeforeDamage:
	ldh a, [hTempCardIndex_ff9f]
	call PutHandPokemonCardInPlayArea
	ret

FullHeal_InitialEffect1:
	ld a, DUELVARS_ARENA_CARD_STATUS
	get_turn_duelist_var
	or a
	ret nz
	ld hl, $be
	scf
	ret

FullHeal_BeforeDamage:
	ld a, $8a
	call Func_67843
	ld a, DUELVARS_ARENA_CARD_STATUS
	get_turn_duelist_var
	ld [hl], $00
	bank1call DrawDuelHUDs
	ret

ImposterProfessorOak_BeforeDamage:
	call SwapTurn
	call CreateHandCardList
	bank1call SortCardsInDuelTempListByID
	ld hl, wDuelTempList
.asm_66f38
	ld a, [hli]
	cp $ff
	jr z, .asm_66f45
	call RemoveCardFromHand
	call ReturnCardToDeck
	jr .asm_66f38
.asm_66f45
	call Func_66be9
	ld a, $07
	farcall DisplayDrawNCardsScreen
	ld c, $07
.asm_66f50
	call DrawCardFromDeck
	jr c, .asm_66f5b
	call AddCardToHand
	dec c
	jr nz, .asm_66f50
.asm_66f5b
	call SwapTurn
	ret

ComputerSearch_InitialEffect1:
	ld a, DUELVARS_NUMBER_OF_CARDS_IN_HAND
	get_turn_duelist_var
	ld hl, $bf
	cp $03
	ret c
	ld a, DUELVARS_NUMBER_OF_CARDS_NOT_IN_DECK
	get_turn_duelist_var
	ld hl, $ba
	cp $3c
	ccf
	ret

ComputerSearch_InitialEffect2:
	call Func_677d3
	ret

ComputerSearch_RequireSelection:
	call CreateDeckCardList
	bank1call Func_5221
	ldtx hl, ChooseCardToPlaceInHandText
	ldtx de, DuelistDeckText
	bank1call SetCardListHeaderAndInfoText
.asm_66f85
	bank1call DisplayCardList
	jr c, .asm_66f85
	ldh [hTempRetreatCostCards], a
	ret

ComputerSearch_BeforeDamage:
	ld hl, hTemp_ffa0
	ld a, [hli]
	call RemoveCardFromHand
	call PutCardInDiscardPile
	ld a, [hli]
	call RemoveCardFromHand
	call PutCardInDiscardPile
	ld a, [hl]
	call SearchCardInDeckAndAddToHand
	call AddCardToHand
	call Func_66be9
	ret

ClefairyDoll_InitialEffect1:
	farcall Func_24369
	ret

ClefairyDoll_BeforeDamage:
	ldh a, [hTempCardIndex_ff9f]
	call PutHandPokemonCardInPlayArea
	ret

MrFuji_InitialEffect1:
	farcall Func_68446
	ret

MrFuji_InitialEffect2:
	ldtx hl, ChoosePokemonToReturnToTheDeckText
	call DrawWideTextBox_WaitForInput
	bank1call HasAlivePokemonInBench
	bank1call OpenPlayAreaScreenForSelection
	ldh a, [hTempPlayAreaLocation_ff9d]
	ldh [hTemp_ffa0], a
	ret

MrFuji_BeforeDamage:
	ldh a, [hTemp_ffa0]
	add DUELVARS_ARENA_CARD
	get_turn_duelist_var
	ldh [hTempCardIndex_ff98], a
	ldh a, [hTemp_ffa0]
	or $10
	ld e, a
	ld a, DUELVARS_CARD_LOCATIONS
	get_turn_duelist_var
.asm_66fd9
	push de
	push hl
	ld a, [hl]
	cp e
	jr nz, .asm_66fe3
	ld a, l
	call ReturnCardToDeck
.asm_66fe3
	pop hl
	pop de
	inc l
	ld a, l
	cp $3c
	jr c, .asm_66fd9
	ldh a, [hTemp_ffa0]
	ld e, a
	call EmptyPlayAreaSlot
	ld l, $f5
	dec [hl]
	call ShiftAllPokemonToFirstPlayAreaSlots
	call Func_66bee
	jr c, .asm_67014
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
.asm_67014
	call Func_66be9
	ret

Pluspower_BeforeDamage:
	ld e, $00
	ldh a, [hTempCardIndex_ff9f]
	call PutHandCardInPlayArea
	ld a, DUELVARS_ARENA_CARD_ATTACHED_PLUSPOWER
	get_turn_duelist_var
	inc [hl]
	ret

Switch_InitialEffect1:
	farcall Func_68446
	ret

Switch_InitialEffect2:
	ldtx hl, SelectBenchedPokemonToSwitchWithActiveText
	call DrawWideTextBox_WaitForInput
	bank1call HasAlivePokemonInBench
	bank1call OpenPlayAreaScreenForSelection
	ldh a, [hTempPlayAreaLocation_ff9d]
	ldh [hTemp_ffa0], a
	ret

Switch_BeforeDamage:
	ldh a, [hTemp_ffa0]
	ld e, a
	call SwapArenaWithBenchPokemon
	ret

PokemonCenter_InitialEffect1:
	farcall Func_68335
	ld hl, $b5
	ret

PokemonCenter_BeforeDamage:
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	ld d, a
	ld e, $00
.asm_6704f
	ld a, e
	ldh [hTempPlayAreaLocation_ff9d], a
	call GetCardDamageAndMaxHP
	or a
	jr z, .asm_67081
	push de
	ld e, a
	ld d, $00
	call Func_67859
	ldh a, [hTempPlayAreaLocation_ff9d]
	or $10
	ld e, a
	ld a, DUELVARS_CARD_LOCATIONS
	get_turn_duelist_var
.asm_67067
	ld a, [hl]
	cp e
	jr nz, .asm_6707a
	ld a, l
	call LoadCardDataToBuffer2_FromDeckIndex
	ld a, [wLoadedCard2Type]
	and $08
	jr z, .asm_6707a
	ld a, l
	call Func_0ffa
.asm_6707a
	inc l
	ld a, l
	cp $3c
	jr c, .asm_67067
	pop de
.asm_67081
	inc e
	dec d
	jr nz, .asm_6704f
	ret

PokemonFlute_InitialEffect1:
	call SwapTurn
	bank1call IsBlackHoleRuleActive
	jr c, .asm_67098
	farcall Func_24369
	jr c, .asm_67098
	farcall Func_6837a
.asm_67098
	call SwapTurn
	ret

PokemonFlute_InitialEffect2:
	call SwapTurn
	farcall Func_6837a
	bank1call Func_5221
	ldtx hl, ChoosePokemonToPlaceInPlayText
	ldtx de, DuelistDiscardPileText
	bank1call SetCardListHeaderAndInfoText
	bank1call DisplayCardList
	call SwapTurn
	ldh a, [hTempCardIndex_ff98]
	ldh [hTemp_ffa0], a
	ret

PokemonFlute_BeforeDamage:
	call SwapTurn
	ldh a, [hTemp_ffa0]
	call MoveDiscardPileCardToHand
	call AddCardToHand
	call PutHandPokemonCardInPlayArea
	call SwapTurn
	call Func_66bee
	ret c
	call SwapTurn
	ldh a, [hTemp_ffa0]
	ldtx hl, CardWasChosenText
	bank1call DisplayCardDetailScreen
	call SwapTurn
	ret

PokemonBreeder_InitialEffect1:
	call Func_67167
	jr c, .asm_670e7
	bank1call IsPrehistoricPowerActive
	ret
.asm_670e7
	ld hl, $c3
	scf
	ret

PokemonBreeder_InitialEffect2:
	call Func_67167
	bank1call Func_5221
	ldtx hl, PleaseSelectCardText
	ldtx de, DuelistHandText
	bank1call SetCardListHeaderAndInfoText
	bank1call DisplayCardList
	ret c
	ldh a, [hTempCardIndex_ff98]
	ldh [hTemp_ffa0], a
	ldtx hl, ChooseBasicPokemonToEvolveText
	call DrawWideTextBox_WaitForInput
	bank1call HasAlivePokemonInPlayArea
.asm_6710c
	bank1call OpenPlayAreaScreenForSelection
	ret c
	ldh a, [hTempPlayAreaLocation_ff9d]
	ldh [hTempPlayAreaLocation_ffa1], a
	ld e, a
	ldh a, [hTemp_ffa0]
	ld d, a
	call CheckIfCanEvolveInto_BasicToStage2
	jr c, .asm_6710c
	or a
	ret

PokemonBreeder_BeforeDamage:
	ldh a, [hTempCardIndex_ff9f]
	push af
	ld hl, hTemp_ffa0
	ld a, [hli]
	ldh [hTempCardIndex_ff98], a
	ld a, [hl]
	ldh [hTempPlayAreaLocation_ff9d], a
	add DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call LoadCardDataToBuffer1_FromDeckIndex
	ld hl, wLoadedCard1Name
	ld a, [hli]
	ld h, [hl]
	ld l, a
	call LoadTxRam2
	ldh a, [hTempCardIndex_ff98]
	call EvolvePokemonCard
	ld [hl], $03
	ldh a, [hTempCardIndex_ff98]
	ld [wcd15], a
	call LoadCardDataToBuffer1_FromDeckIndex
	ld hl, wTxRam2_b
	ld a, [wLoadedCard1Name]
	ld [hli], a
	ld a, [wLoadedCard1Name + 1]
	ld [hl], a
	farcall DrawLargePictureOfCard
	ld a, SFX_5E
	call PlaySFX
	ldtx hl, PokemonEvolvedIntoPokemonText
	call DrawWideTextBox_WaitForInput
	pop af
	ldh [hTempCardIndex_ff9f], a
	ret

Func_67167:
	call CreateHandCardList
	ret c
	ld hl, wDuelTempList
	ld e, l
	ld d, h
.asm_67170
	ld a, [hl]
	cp $ff
	jr z, .asm_67180
	call Func_6718c
	jr c, .asm_6717d
	ld a, [hl]
	ld [de], a
	inc de
.asm_6717d
	inc hl
	jr .asm_67170
.asm_67180
	ld a, $ff
	ld [de], a
	ld a, [wDuelTempList]
	cp $ff
	scf
	ret z
	or a
	ret

Func_6718c:
	push de
	ld d, a
	call LoadCardDataToBuffer2_FromDeckIndex
	ld a, [wLoadedCard2Type]
	cp $08
	jr nc, .asm_671b9
	ld a, [wLoadedCard2Stage]
	cp $02
	jr nz, .asm_671b9
	push hl
	push bc
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	ld c, a
	ld e, $00
.asm_671a7
	push bc
	push de
	call CheckIfCanEvolveInto_BasicToStage2
	pop de
	pop bc
	jr nc, .asm_671b5
	inc e
	dec c
	jr nz, .asm_671a7
	scf
.asm_671b5
	pop bc
	pop hl
	pop de
	ret
.asm_671b9
	pop de
	scf
	ret

ScoopUp_InitialEffect1:
	farcall Func_68446
	ret

ScoopUp_InitialEffect2:
	ldtx hl, ChoosePokemonToScoopUpText
	call DrawWideTextBox_WaitForInput
	bank1call HasAlivePokemonInPlayArea
	bank1call OpenPlayAreaScreenForSelection
	ret c
	ldh [hTemp_ffa0], a
	or a
	ret nz
	call EmptyScreen
	ldtx hl, SelectPokemonToPlaceInTheArenaText
	call DrawWideTextBox_WaitForInput
	bank1call HasAlivePokemonInBench
	bank1call OpenPlayAreaScreenForSelection
	ldh [hTempPlayAreaLocation_ffa1], a
	ret

ScoopUp_BeforeDamage:
	ldh a, [hTemp_ffa0]
	or $10
	ld e, a
	ld a, DUELVARS_CARD_LOCATIONS
	get_turn_duelist_var
.asm_671ec
	ld a, [hl]
	cp e
	jr nz, .asm_6720d
	ld a, l
	call LoadCardDataToBuffer2_FromDeckIndex
	ld a, [wLoadedCard2Type]
	cp $08
	jr nc, .asm_67209
	ld a, [wLoadedCard2Stage]
	or a
	jr nz, .asm_67209
	ld a, l
	ldh [hTempCardIndex_ff98], a
	call AddCardToHand
	jr .asm_6720d
.asm_67209
	ld a, l
	call PutCardInDiscardPile
.asm_6720d
	inc l
	ld a, l
	cp $3c
	jr c, .asm_671ec
	ldh a, [hTemp_ffa0]
	ld e, a
	call Func_12fc
	ldh a, [hTemp_ffa0]
	or a
	jr nz, .asm_67221
	call ClearAllStatusConditions
.asm_67221
	call Func_66bee
	jr c, .asm_67236
	ldtx hl, PokemonWasReturnedFromArenaToHandText
	ldh a, [hTemp_ffa0]
	or a
	jr z, .asm_67231
	ldtx hl, PokemonWasReturnedFromBenchToHandText
.asm_67231
	ldh a, [hTempCardIndex_ff98]
	bank1call DisplayCardDetailScreen
.asm_67236
	ldh a, [hTemp_ffa0]
	or a
	jr z, .asm_6723f
	call ShiftAllPokemonToFirstPlayAreaSlots
	ret
.asm_6723f
	ldh a, [hTempPlayAreaLocation_ffa1]
	ld d, a
	ld e, $00
	call SwapPlayAreaPokemon
	call ShiftAllPokemonToFirstPlayAreaSlots
	ret

PokemonTrader_InitialEffect1:
	ld a, DUELVARS_NUMBER_OF_CARDS_IN_HAND
	get_turn_duelist_var
	ld hl, $c4
	cp $02
	ret c
	call Func_672d9
	ld hl, $c4
	ret

PokemonTrader_InitialEffect2:
	ld hl, TimerHandler
	call DrawWideTextBox_WaitForInput
	call Func_672d9
	bank1call Func_5221
	ldtx hl, ChooseCardToExchangeText
	ldtx de, DuelistHandText
	bank1call SetCardListHeaderAndInfoText
	bank1call DisplayCardList
	ldh [hTemp_ffa0], a
	ret

PokemonTrader_RequireSelection:
	ldh a, [hTemp_ffa0]
	call RemoveCardFromHand
	call ReturnCardToDeck
	ldtx hl, ChooseBasicOrEvolutionPokemonCardFromDeckText
	call DrawWideTextBox_WaitForInput
	call CreateDeckCardList
	bank1call Func_5221
	ldtx hl, ChoosePokemonCardText
	ldtx de, DuelistDeckText
	bank1call SetCardListHeaderAndInfoText
.asm_67293
	bank1call DisplayCardList
	jr c, .asm_67293
	call LoadCardDataToBuffer2_FromDeckIndex
	ld a, [wLoadedCard2Type]
	cp $08
	jr nc, .asm_67293
	ldh a, [hTempCardIndex_ff98]
	ldh [hTempPlayAreaLocation_ffa1], a
	ldh a, [hTemp_ffa0]
	call SearchCardInDeckAndAddToHand
	call AddCardToHand
	or a
	ret

PokemonTrader_BeforeDamage:
	ldh a, [hTemp_ffa0]
	call RemoveCardFromHand
	call ReturnCardToDeck
	ldh a, [hTempPlayAreaLocation_ffa1]
	call SearchCardInDeckAndAddToHand
	call AddCardToHand
	call Func_66bee
	jr c, .asm_672d5
	ldh a, [hTemp_ffa0]
	ldtx hl, PokemonWasReturnedToDeckText
	bank1call DisplayCardDetailScreen
	ldh a, [hTempPlayAreaLocation_ffa1]
	ldtx hl, WasPlacedInTheHandText
	bank1call DisplayCardDetailScreen
.asm_672d5
	call Func_66be9
	ret

Func_672d9:
	ld a, DUELVARS_NUMBER_OF_CARDS_IN_HAND
	get_turn_duelist_var
	ld c, a
	ld l, $42
	ld de, wDuelTempList
.asm_672e2
	ld a, [hl]
	call LoadCardDataToBuffer2_FromDeckIndex
	ld a, [wLoadedCard2Type]
	cp $08
	jr nc, .asm_672f0
	ld a, [hl]
	ld [de], a
	inc de
.asm_672f0
	inc l
	dec c
	jr nz, .asm_672e2
	ld a, $ff
	ld [de], a
	ld a, [wDuelTempList]
	cp $ff
	jr z, .asm_67300
	or a
	ret
.asm_67300
	scf
	ret

Pokedex_InitialEffect1:
	ld a, DUELVARS_NUMBER_OF_CARDS_NOT_IN_DECK
	get_turn_duelist_var
	ld hl, $ba
	cp $3c
	ccf
	ret

Pokedex_RequireSelection:
	ldtx hl, RearrangeThe5CardsAtTopOfDeckText
	call DrawWideTextBox_WaitForInput
	ld a, DUELVARS_NUMBER_OF_CARDS_NOT_IN_DECK
	get_turn_duelist_var
	ld b, a
	ld a, $3c
	sub [hl]
	ld c, $05
	cp c
	jr nc, .asm_6731f
	ld c, a
.asm_6731f
	ld a, c
	inc a
	ld [wcd1f], a
	ld a, b
	add $7e
	ld l, a
	ld de, wDuelTempList
.asm_6732b
	ld a, [hli]
	ld [de], a
	inc de
	dec c
	jr nz, .asm_6732b
	ld a, $ff
	ld [de], a
.asm_67334
	call CountCardsInDuelTempList
	ld b, a
	ld a, $01
	ldh [hffb2], a
	ld hl, wDuelTempList + 10
	xor a
.asm_67340
	ld [hli], a
	dec b
	jr nz, .asm_67340
	ld [hl], $ff
	bank1call InitAndDrawCardListScreenLayout
	ldtx hl, ChooseTheOrderOfTheCardsText
	ldtx de, DuelistDeckText
	bank1call SetCardListHeaderAndInfoText
	bank1call Func_53bc
.asm_67355
	bank1call DisplayCardList
	jr c, .asm_673ad
	ldh a, [hCurScrollMenuItem]
	ld e, a
	ld d, $00
	ld hl, wDuelTempList + 10
	add hl, de
	ld a, [hl]
	or a
	jr nz, .asm_67355
	ldh a, [hffb2]
	ld [hl], a
	inc a
	ldh [hffb2], a
	push af
	bank1call Func_53cb
	pop af
	ldh a, [hffb2]
	ld hl, wcd1f
	cp [hl]
	jr c, .asm_67355
	call EraseCursor
	ld hl, $2f
	call YesOrNoMenuWithText_LeftAligned
	jr c, .asm_67334
	ld hl, wDuelTempList + 10
	ld de, wDuelTempList
	ld c, $00
.asm_6738d
	ld a, [hli]
	cp $ff
	jr z, .asm_673a3
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
	jr .asm_6738d
.asm_673a3
	ld b, $00
	ld hl, hTemp_ffa0
	add hl, bc
	ld [hl], $ff
	or a
	ret
.asm_673ad
	ld hl, hffb2
	ld a, [hl]
	cp $01
	jr z, .asm_67355
	dec a
	ld [hl], a
	ld c, a
	ld hl, wDuelTempList + 10
.asm_673bb
	ld a, [hli]
	cp c
	jr nz, .asm_673bb
	dec hl
	ld [hl], $00
	bank1call Func_53cb
	jr .asm_67355

Pokedex_BeforeDamage:
	ld hl, hTemp_ffa0
	ld c, $00
.asm_673cc
	ld a, [hli]
	cp $ff
	jr z, .asm_673d7
	call SearchCardInDeckAndAddToHand
	inc c
	jr .asm_673cc
.asm_673d7
	dec hl
	dec hl
.asm_673d9
	ld a, [hld]
	call ReturnCardToDeck
	dec c
	jr nz, .asm_673d9
	ret

Bill_BeforeDamage:
	ldh a, [hTempCardIndex_ff9f]
	call RemoveCardFromHand
	ld a, $02
	farcall DisplayDrawNCardsScreen
	ld c, $02
.asm_673ee
	call DrawCardFromDeck
	jr c, .asm_67405
	ldh [hTempCardIndex_ff98], a
	call AddCardToHand
	call Func_66bee
	jr nc, .asm_67402
	push bc
	bank1call DisplayPlayerDrawCardScreen
	pop bc
.asm_67402
	dec c
	jr nz, .asm_673ee
.asm_67405
	ret

Lass_BeforeDamage:
	ldh a, [hTempCardIndex_ff9f]
	call RemoveCardFromHand
	call PutCardInDiscardPile
	ldtx hl, PleaseCheckTheOpponentsHandText
	call DrawWideTextBox_WaitForInput
	call Func_67454
	call SwapTurn
	call Func_67420
	call SwapTurn
;   fallthrough

Func_67420:
	call CreateHandCardList
	bank1call SortCardsInDuelTempListByID
	xor a
	ldh [hffb2], a
	ld hl, wDuelTempList
.asm_6742c
	ld a, [hli]
	ldh [hTempCardIndex_ff98], a
	cp $ff
	jr z, .asm_6744d
	call GetCardIDFromDeckIndex
	call GetCardType
	cp $10
	jr nz, .asm_6742c
	ldh a, [hTempCardIndex_ff98]
	call RemoveCardFromHand
	call ReturnCardToDeck
	push hl
	ld hl, hffb2
	inc [hl]
	pop hl
	jr .asm_6742c
.asm_6744d
	ldh a, [hffb2]
	or a
	call nz, Func_66be9
	ret

Func_67454:
	ld a, [wDuelType]
	or a
	jr z, .asm_67468
	ldh a, [hWhoseTurn]
	push af
	ld a, $c3
	ldh [hWhoseTurn], a
	call Func_67472
	pop af
	ldh [hWhoseTurn], a
	ret
.asm_67468
	call SwapTurn
	call Func_67472
	call SwapTurn
	ret

Func_67472:
	call CreateHandCardList
	jr c, .asm_6748c
	bank1call InitAndDrawCardListScreenLayout
	ldtx hl, ChooseCardToCheckText
	ldtx de, DuelistHandText
	bank1call SetCardListHeaderAndInfoText
	ld a, $09
	ld [wNoItemSelectionMenuKeys], a
	bank1call DisplayCardList
	ret
.asm_6748c
	ldtx hl, DuelistHasNoCardsInHandText
	call DrawWideTextBox_WaitForInput
	ret

Maintenance_InitialEffect1:
	ld a, DUELVARS_NUMBER_OF_CARDS_IN_HAND
	get_turn_duelist_var
	ld hl, $bf
	cp $03
	ret

Maintenance_InitialEffect2:
	ld hl, $1e7
	ld de, $203
	call Func_677d9
	ret

Maintenance_BeforeDamage:
	ldh a, [hTemp_ffa0]
	call RemoveCardFromHand
	call ReturnCardToDeck
	ldh a, [hTempPlayAreaLocation_ffa1]
	call RemoveCardFromHand
	call ReturnCardToDeck
	call Func_66be9
	ld a, $01
	farcall DisplayDrawNCardsScreen
	call DrawCardFromDeck
	call AddCardToHand
	ret

Pokeball_InitialEffect1:
	ld a, DUELVARS_NUMBER_OF_CARDS_NOT_IN_DECK
	get_turn_duelist_var
	ld hl, $ba
	cp $3c
	ccf
	ret

Pokeball_RequireSelection:
	ldtx de, TrainerCardSuccessCheckText
	farcall Func_68079
	ldh [hTemp_ffa0], a
	ret nc
	call CreateDeckCardList
	ldtx hl, ChooseBasicOrEvolutionPokemonCardFromDeckText
	ldtx bc, EffectTargetBasicOrEvolutionPokemonCardText
	ld a, CARDSEARCH_ANY_ENERGY
	farcall Func_24c9d
	jr c, .asm_674f5
	ldtx hl, ChoosePokemonCardText
	ldtx de, DuelistDeckText
	farcall Func_24df8
.asm_674f5
	ldh [hTempPlayAreaLocation_ffa1], a
	ret

Pokeball_BeforeDamage:
	ldh a, [hTemp_ffa0]
	or a
	ret z
	ldh a, [hTempPlayAreaLocation_ffa1]
	cp $ff
	jr z, .asm_67515
	call SearchCardInDeckAndAddToHand
	call AddCardToHand
	call Func_66bee
	jr c, .asm_67515
	ldh a, [hTempPlayAreaLocation_ffa1]
	ldtx hl, WasPlacedInTheHandText
	bank1call DisplayCardDetailScreen
.asm_67515
	call Func_66be9
	ret

Recycle_InitialEffect1:
	bank1call IsBlackHoleRuleActive
	jr c, .asm_67523
	ld a, DUELVARS_NUMBER_OF_CARDS_IN_DISCARD_PILE
	get_turn_duelist_var
	cp $01
.asm_67523
	ld hl, $c5
	ret

Recycle_RequireSelection:
	ldtx de, TrainerCardSuccessCheckText
	farcall Func_68079
	jr nc, .asm_67549
	bank1call CreateDiscardPileCardList
	bank1call Func_5221
	ldtx hl, PleaseSelectCardText
	ldtx de, DuelistDiscardPileText
	bank1call SetCardListHeaderAndInfoText
.asm_6753f
	bank1call DisplayCardList
	jr c, .asm_6753f
	ldh a, [hTempCardIndex_ff98]
	ldh [hTemp_ffa0], a
	ret
.asm_67549
	ld a, $ff
	ldh [hTemp_ffa0], a
	or a
	ret

Recycle_BeforeDamage:
	ldh a, [hTemp_ffa0]
	cp $ff
	ret z
	call MoveDiscardPileCardToHand
	call ReturnCardToDeck
	call Func_66bee
	ret c
	ldh a, [hTemp_ffa0]
	ldtx hl, CardWasChosenText
	bank1call DisplayCardDetailScreen
	ret

Revive_InitialEffect1:
	farcall Func_24369
	ret c
	farcall Func_6837a
	ret

Revive_InitialEffect2:
	ldtx hl, ChooseBasicPokemonToPlaceOnBenchText
	call DrawWideTextBox_WaitForInput
	farcall Func_6837a
	bank1call Func_5221
	ldtx hl, PleaseSelectCardText
	ldtx de, DuelistDiscardPileText
	bank1call SetCardListHeaderAndInfoText
	bank1call DisplayCardList
	ldh a, [hTempCardIndex_ff98]
	ldh [hTemp_ffa0], a
	ret

Revive_BeforeDamage:
	ldh a, [hTemp_ffa0]
	call MoveDiscardPileCardToHand
	call AddCardToHand
	call PutHandPokemonCardInPlayArea
	add DUELVARS_ARENA_CARD_HP
	get_turn_duelist_var
	srl a
	bit 0, a
	jr z, .asm_675a5
	add $05
.asm_675a5
	ld [hl], a
	call Func_66bee
	ret c
	ldh a, [hTemp_ffa0]
	ldtx hl, PlacedOnBenchText
	bank1call DisplayCardDetailScreen
	ret

DevolutionSpray_InitialEffect1:
	ld a, DUELVARS_NUMBER_OF_POKEMON_IN_PLAY_AREA
	get_turn_duelist_var
	ld c, a
	ld l, $bb
.asm_675b9
	ld a, [hli]
	call LoadCardDataToBuffer2_FromDeckIndex
	ld a, [wLoadedCard2Stage]
	or a
	ret nz
	dec c
	jr nz, .asm_675b9
	ld hl, $c6
	scf
	ret

DevolutionSpray_InitialEffect2:
	ldtx hl, ChooseEvolutionCardAndPressAButtonToDevolveText
	call DrawWideTextBox_WaitForInput
	ld a, $01
	ldh [hffb2], a
	bank1call HasAlivePokemonInPlayArea
.asm_675d7
	bank1call OpenPlayAreaScreenForSelection
	ret c
	bank1call GetCardOneStageBelow
	jr c, .asm_675d7
	ldh a, [hTempPlayAreaLocation_ff9d]
	add DUELVARS_ARENA_CARD_HP
	get_turn_duelist_var
	push hl
	push af
	ldh a, [hTempPlayAreaLocation_ff9d]
	add $ce
	ld l, a
	ld a, [hl]
	push hl
	push af
	ldh a, [hTempPlayAreaLocation_ff9d]
	add $bb
	ld l, a
	ld a, [hl]
	push hl
	push af
	jr .asm_67601
.asm_675f9
	bank1call Func_5c23
	jr c, .asm_67615
	bank1call GetCardOneStageBelow
.asm_67601
	ld a, d
	farcall Func_68525
	farcall Func_24350
	ld [hl], e
	ld a, d
	call LoadCardDataToBuffer2_FromDeckIndex
	ld a, [wLoadedCard2Stage]
	or a
	jr nz, .asm_675f9
.asm_67615
	farcall Func_24350
	ld [hl], $ff
	ldh a, [hTempPlayAreaLocation_ff9d]
	ldh [hTemp_ffa0], a
	call EmptyScreen
	ldh a, [hTempPlayAreaLocation_ff9d]
	ld hl, wHUDEnergyAndHPBarsX
	ld [hli], a
	ld [hl], $00
	bank1call PrintPlayAreaCardInformationAndLocation
	call EnableLCD
	pop bc
	pop hl
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

DevolutionSpray_BeforeDamage:
	ld hl, hTemp_ffa0
	ld a, [hli]
	ldh [hTempPlayAreaLocation_ff9d], a
	add DUELVARS_ARENA_CARD
	get_turn_duelist_var
	push hl
	push af
	ld hl, hTempPlayAreaLocation_ffa1
.asm_6764e
	ld a, [hl]
	cp $ff
	jr z, .asm_67667
	push hl
	bank1call GetCardOneStageBelow
	ld a, d
	farcall Func_68525
	farcall Func_68556
	pop hl
	ld a, [hli]
	call PutCardInDiscardPile
	jr .asm_6764e
.asm_67667
	pop af
	ld e, a
	pop hl
	ld d, [hl]
	farcall Func_68262
	ldh a, [hTemp_ffa0]
	call PrintPlayAreaCardKnockedOutIfNoHP
	bank1call Func_6518
	ret

SuperEnergyRemoval_InitialEffect1:
	call Func_66c5f
	ld hl, $c7
	ret c
	call SwapTurn
	call Func_66c5f
	ld hl, $c8
	call SwapTurn
	ret

SuperEnergyRemoval_InitialEffect2:
	ldtx hl, ChoosePokemonInYourAreaThenInOppAreaText
	call DrawWideTextBox_WaitForInput
	call Func_66c80
	ret c
	ld hl, VBlankHandler.done
	call DrawWideTextBox_WaitForInput
	call SwapTurn
	ld a, $03
	ldh [hffb2], a
.asm_676a3
	bank1call HasAlivePokemonInPlayArea
	bank1call OpenPlayAreaScreenForSelection
	jr nc, .asm_676af
	call SwapTurn
	ret
.asm_676af
	ld e, a
	call GetPlayAreaCardAttachedEnergies
	ld a, [wTotalAttachedEnergies]
	or a
	jr nz, .asm_676c1
	ldtx hl, NoEnergyCardsText
	call DrawWideTextBox_WaitForInput
	jr .asm_676a3
.asm_676c1
	ldh a, [hTempPlayAreaLocation_ff9d]
	ldh [hTempRetreatCostCards], a
	bank1call CreateArenaOrBenchEnergyCardList
	ldh a, [hTempPlayAreaLocation_ff9d]
	bank1call DisplayEnergyDiscardMenu
	ld a, $02
	ld [wAttachedEnergyMenuDenominator], a
.asm_676d2
	bank1call HandleAttachedEnergyMenuInput
	jr nc, .asm_676f3
	ld a, $05
	farcall Func_6856d
	jr nc, .asm_67713
	ld a, [wAttachedEnergyMenuNumerator]
	push af
	ldh a, [hTempPlayAreaLocation_ff9d]
	bank1call DisplayEnergyDiscardMenu
	ld a, $02
	ld [wAttachedEnergyMenuDenominator], a
	pop af
	ld [wAttachedEnergyMenuNumerator], a
	jr .asm_676d2
.asm_676f3
	farcall Func_24350
	ldh a, [hTempCardIndex_ff98]
	ld [hl], a
	call RemoveCardFromDuelTempList
	ld hl, wAttachedEnergyMenuNumerator
	inc [hl]
	ldh a, [hffb2]
	cp $05
	jr nc, .asm_67713
	ld a, [wDuelTempList]
	cp $ff
	jr z, .asm_67713
	bank1call UpdateAttachedEnergyMenu
	jr .asm_676d2
.asm_67713
	farcall Func_24350
	ld [hl], $ff
	call SwapTurn
	or a
	ret

SuperEnergyRemoval_BeforeDamage:
	ld hl, hTempPlayAreaLocation_ffa1
	ld a, [hli]
	call Func_0ffa
	inc hl
	call SwapTurn
.asm_67729
	ld a, [hli]
	cp $ff
	jr z, .asm_67733
	call Func_0ffa
	jr .asm_67729
.asm_67733
	call SwapTurn
	call Func_66bee
	ret c
	ldh a, [hTemp_ffa0]
	farcall Func_680ed
	xor a
	ld [wDuelDisplayedScreen], a
	call SwapTurn
	ldh a, [hTempRetreatCostCards]
	farcall Func_680ed
	call SwapTurn
	ret

SuperEnergyRetrieval_InitialEffect1:
	ld a, DUELVARS_NUMBER_OF_CARDS_IN_HAND
	get_turn_duelist_var
	ld hl, $bf
	cp $03
	ret c
	farcall CreateEnergyCardListFromDiscardPile_OnlyBasic
	ld hl, $b9
	ret

SuperEnergyRetrieval_InitialEffect2:
	call Func_677d3
	ret

SuperEnergyRetrieval_RequireSelection:
	ldtx hl, ChooseUpTo4FromDiscardPileText
	call DrawWideTextBox_WaitForInput
	farcall CreateEnergyCardListFromDiscardPile_OnlyBasic
.asm_67770
	bank1call InitAndDrawCardListScreenLayout
	ldtx hl, PleaseSelectCardText
	ldtx de, DuelistDiscardPileText
	bank1call SetCardListHeaderAndInfoText
	bank1call DisplayCardList
	jr nc, .asm_6778b
	ld a, $06
	farcall Func_6856d
	jr c, .asm_67770
	jr .asm_677a0
.asm_6778b
	ldh a, [hTempCardIndex_ff98]
	get_turn_duelist_var
	farcall Func_24350
	ldh a, [hTempCardIndex_ff98]
	ld [hl], a
	call RemoveCardFromDuelTempList
	jr c, .asm_677a0
	ldh a, [hffb2]
	cp $06
	jr c, .asm_67770
.asm_677a0
	farcall Func_24350
	ld [hl], $ff
	or a
	ret

SuperEnergyRetrieval_BeforeDamage:
	ld hl, hTemp_ffa0
	ld a, [hli]
	call RemoveCardFromHand
	call PutCardInDiscardPile
	ld a, [hli]
	call RemoveCardFromHand
	call PutCardInDiscardPile
	ld de, wDuelTempList
.asm_677bc
	ld a, [hli]
	ld [de], a
	inc de
	cp $ff
	jr z, .asm_677cb
	call MoveDiscardPileCardToHand
	call AddCardToHand
	jr .asm_677bc
.asm_677cb
	call Func_66bee
	ret c
	bank1call Func_49e8
	ret

Func_677d3:
	ld hl, $1e6
	ld de, $204
;   fallthrough

Func_677d9:
	push de
	call DrawWideTextBox_WaitForInput
	call CreateHandCardList
	ldh a, [hTempCardIndex_ff9f]
	call RemoveCardFromDuelTempList
	xor a
	ldh [hffb2], a
	pop hl
.asm_677e9
	push hl
	bank1call Func_5221
	pop hl
	bank1call SetCardListInfoBoxText
	push hl
	bank1call DisplayCardList
	pop hl
	jr c, .asm_6780c
	push hl
	farcall Func_24350
	ldh a, [hTempCardIndex_ff98]
	ld [hl], a
	call RemoveCardFromDuelTempList
	pop hl
	ldh a, [hffb2]
	cp $02
	jr c, .asm_677e9
	or a
	ret
.asm_6780c
	scf
	ret

GustOfWind_InitialEffect1:
	farcall Func_6843b
	ret

GustOfWind_InitialEffect2:
	ldtx hl, ChoosePokemonToSwitchWithActiveText
	call DrawWideTextBox_WaitForInput
	call SwapTurn
	bank1call HasAlivePokemonInBench
	bank1call OpenPlayAreaScreenForSelection
	ldh a, [hTempPlayAreaLocation_ff9d]
	ldh [hTemp_ffa0], a
	call SwapTurn
	ret

GustOfWind_BeforeDamage:
	ld a, $8d
	call Func_67843
	call SwapTurn
	ldh a, [hTemp_ffa0]
	ld e, a
	call SwapArenaWithBenchPokemon
	call SwapTurn
	bank1call ClearDamageReductionSubstatus2
	xor a
	ld [wDuelDisplayedScreen], a
	ret

Func_67843:
	ld [wLoadedAttackAnimation], a
	farcall ResetAttackAnimationIsPlaying
	ld bc, $0
	ldh a, [hWhoseTurn]
	ld h, a
	farcall PlayAttackAnimation
	farcall WaitAttackAnimation
	ret

Func_67859:
	ld e, a
	ld d, $00
	push de
	farcall ResetAttackAnimationIsPlaying
	ld a, $86
	ld [wLoadedAttackAnimation], a
	ldh a, [hTempPlayAreaLocation_ff9d]
	ld b, a
	ld c, $01
	ldh a, [hWhoseTurn]
	ld h, a
	farcall PlayAttackAnimation
	farcall WaitAttackAnimation
	pop hl
	push hl
	call LoadTxRam3
	ld hl, $0
	call LoadTxRam2
	ldh a, [hTempPlayAreaLocation_ff9d]
	add DUELVARS_ARENA_CARD
	get_turn_duelist_var
	call LoadCardDataToBuffer1_FromDeckIndex
	ld a, $12
	call CopyCardNameAndLevel
	ld [hl], $00
	ldtx hl, PokemonHealedDamageText
	call DrawWideTextBox_WaitForInput
	pop de
	ldh a, [hTempPlayAreaLocation_ff9d]
	add DUELVARS_ARENA_CARD_HP
	get_turn_duelist_var
	add e
	ld [hl], a
	ret
