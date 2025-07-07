HandText: ; $0001
	textfw "てふだ"
	done

CheckText:
	textfw "しらべる"
	done

AttackText:
	textfw "ワ ザ"
	done

PokemonPowerHiraganaText:
	; The casual term for Pokémon Power
	; but was "PKMN Power" in tcg1-en
	textfw "とくしゅ"
	done

DoneText:
	textfw "おわり"
	done

TypeText:
	textfw "色"
	done

RetreatText:
	textfw "にげる"
	done

WeaknessText:
	textfw "弱点"
	done

ResistanceText:
	textfw "抵抗力"
	done

PokemonPowerKanjiText:
	; The formal term for Pokémon Power
	; but was "PKMN PWR" in tcg1-en
	textfw "特殊能力"
	done

PokemonCardString: ; unused?
	textfw "ポケモンカード"
	done

LengthText:
	textfw "身長"
	done

WeightText:
	textfw "体重"
	done

PokemonText:
	textfw "ポケモン"
	done

LengthUnitMetresText:
	textfw "m"
	done

WeightUnitKilogramsText:
	textfw "Kg"
	done

PromostarRarityText:
	textfw " "
	done

CircleRarityText:
	textfw "●"
	done

DiamondRarityText:
	textfw "◆"
	done

StarRarityText:
	textfw "★"
	done

WhitestarRarityText:
	textfw "☆"
	done

AllCardsOwnedText:
	textfw "のもっている全カード"
	done

TotalNumberOfCardsText:
	textfw "カードのごうけい         枚"
	done

TypesOfCardsText:
	textfw "カードのしゅるい         種"
	done

GrassPokemonText:
	textfw "草ポケモン"
	done

FirePokemonText:
	textfw "炎ポケモン"
	done

WaterPokemonText:
	textfw "水ポケモン"
	done

LightningPokemonText:
	textfw "雷ポケモン"
	done

FightingPokemonText:
	textfw "闘ポケモン"
	done

PsychicPokemonText:
	textfw "超ポケモン"
	done

ColorlessPokemonText:
	textfw "無色ポケモン"
	done

TrainerCardText:
	textfw "トレーナーカード"
	done

EnergyCardText:
	textfw "エネルギーカード"
	done

DeckPrinterText:
	textfw "デッキ"
	done

AttackByText: ; unused?
	textfw "のこうげき"
	done

NoPokemonOnTheBenchText:
	textfw "控えポケモンが いません"
	done

UnableDueToSleepText:
	textfw "「ねむり」状態なので できません"
	done

UnableDueToParalysisText:
	textfw "「マヒ」状態なので できません"
	done

ReceivedNDamageDueToPoisonText:
	textfw "<RAMTEXT>は"
	linefw "「どく」状態なので <RAMNUM>ダメージ"
	done

ReceivedNDamageDueToDoublePoisonText:
	textfw "<RAMTEXT>は"
	linefw "「どくどく」状態なので <RAMNUM>ダメージ"
	done

IsStillAsleepText:
	textfw "<RAMTEXT>は"
	linefw "ねむり つづけている"
	done

IsCuredOfSleepText:
	textfw "<RAMTEXT>は"
	linefw "ねむりから さめた"
	done

IsCuredOfParalysisText:
	textfw "<RAMTEXT>は"
	linefw "マヒが とけた"
	done

BetweenTurnsText:
	textfw "ポケモンチェックをします"
	done

UnableToUseItText:
	textfw "つかえない状態です"
	done

NoEnergyCardsText:
	textfw "エネルギーカードが ありません"
	done

IsThisOKText:
	textfw "これで いいですか?"
	done

YesOrNoText:
	textfw "はい  いいえ"
	done

DiscardActionName:
	textfw "トラッシュする"
	done

IncompleteText:
	textfw "未完成"
	done

DamageString: ; unused?
	textfw "ダメージ"
	done

UsedText:
	textfw "<RAMTEXT>を"
	linefw "つかいます"
	done

ReceivedDamageText: ; unused?
	textfw "ダメージを うけた"
	done

PokemonsAttackText:
	textfw "<RAMTEXT>の"
	linefw "<RAMTEXT>!"
	done

ResistanceLessDamageText:
	textfw "<RAMTEXT>は"
	linefw "抵抗力で <RAMNUM>ダメージを うけた"
	done

WeaknessMoreDamageText:
	textfw "<RAMTEXT>は"
	linefw "弱点で <RAMNUM>ダメージを うけた"
	done

WeaknessResistanceMixedDamageText:
	textfw "<RAMTEXT>は"
	linefw "弱点などで <RAMNUM>ダメージを うけた"
	done

ResistanceNoDamageText:
	textfw "<RAMTEXT>は"
	linefw "抵抗力で ダメージを うけなかった!"
	done

AttackDamageText:
	textfw "<RAMTEXT>は"
	linefw "<RAMNUM>ダメージを うけた"
	done

NoDamageText:
	textfw "<RAMTEXT>は"
	linefw "ダメージを うけなかった!"
	done

NoSelectableAttackText:
	textfw "せんたくできるワザが ありません"
	done

UnableToRetreatText:
	textfw "にげられない"
	done

MayOnlyAttachOneEnergyCardText:
	textfw "エネルギーカードは"
	linefw "じぶんの番には 1枚しか だせません"
	done

UseThisPokemonPowerPromptText:
	textfw "この特殊能力を つかいますか?"
	done

PokemonPowerSelectNotRequiredText:
	textfw "この特殊能力は"
	linefw "えらぶ ひつようがありません"
	done

DiscardActionDescription:
	textfw "自分の番のとき このカードを"
	linefw "トラッシュすることができる。"
	linefw "これは「きぜつ」とカウントされない"
	linefw "(この「トラッシュする」は特殊能力"
	linefw "ではない)"
	done

WillDrawNPrizesText:
	textfw "<RAMNAME>は"
	linefw "サイドカードを<RAMNUM>枚 ひきます"
	done

DrewNPrizesText:
	textfw "<RAMNAME>は"
	linefw "サイドカードを<RAMNUM>枚 ひきました"
	done

DuelistPlacedACardInArenaText:
	textfw "<RAMNAME>は バトル場に"
	linefw "<RAMTEXT>をだした"
	done

UnableToSelectText:
	textfw "せんたくできません"
	done

ColorListText:
	textfw "草"
	linefw "炎"
	linefw "水"
	linefw "雷"
	linefw "闘"
	linefw "超"
	done

GrassSymbolText:
	textfw "<GRASS>"
	done

FireSymbolText:
	textfw "<FIRE>"
	done

WaterSymbolText:
	textfw "<WATER>"
	done

LightningSymbolText:
	textfw "<LIGHTNING>"
	done

FightingSymbolText:
	textfw "<FIGHTING>"
	done

PsychicSymbolText:
	textfw "<PSYCHIC>"
	done

BenchText:
	textfw "ベンチ"
	done

KnockOutText:
	textfw "きぜつ         "
	done

DamageToSelfDueToConfusionText:
	textfw "わけもわからず [自分]をこうげき!!"
	done

ChooseEnergyCardToRemoveText:
	; including but not limited to discarding
	textfw "はがす エネルギーカードを"
	linefw "えらんでください"
	done

ChooseEnergyCardToDiscardText:
	textfw "トラッシュする エネルギーカードを"
	linefw "えらんでください"
	done

ChooseNextActivePokemonText:
	textfw "バトル場のポケモンが、きぜつしました"
	linefw "だす ポケモンを えらんでください"
	done

PressStartWhenReadyText:
	textfw "じゅんびができたら どちらかが"
	linefw "STARTボタンを おしてください"
	done

YouPlayFirstText:
	textfw "あなたは せんこうです"
	done

YouPlaySecondText:
	textfw "あなたは こうこうです"
	done

TransmissionErrorTryAgainText:
	textfw "通信エラーです"
	linefw "はじめから やりなおしてください"
	done

ChooseTheCardYouWishToExamineText:
	textfw "しらべる カードを"
	linefw "えらんでください"
	done

TransmittingDataText:
	textfw "つうしん中です"
	done

WaitingHandExamineText:
	textfw "たいき中です"
	linefw "  てふだ   しらべる"
	done

SelectingBenchPokemonHandExamineBackText:
	textfw "ベンチポケモン せんたく中"
	linefw "  てふだ   しらべる  もどる"
	done

RetreatedToTheBenchText:
	textfw "<RAMTEXT>は"
	linefw "ベンチへ にげた"
	done

RetreatWasUnsuccessfulText:
	textfw "<RAMTEXT>は"
	linefw "にげるのに しっぱいした"
	done

WillUseThePokemonPowerText:
	textfw "<RAMTEXT>は特殊能力"
	linefw "<RAMTEXT>を つかいます"
	done

FinishedTurnWithoutAttackingText:
	textfw "ワザを つかわずに"
	linefw "番を しゅうりょう した"
	done

DuelistTurnText:
	textfw "<RAMNAME>の 番です"
	done

AttachedEnergyToPokemonText:
	textfw "<RAMTEXT>を"
	linefw "<RAMTEXT>に つけました"
	done

PokemonEvolvedIntoPokemonText:
	textfw "<RAMTEXT>は"
	linefw "<RAMTEXT>に 進化しました"
	done

PlacedOnTheBenchText:
	textfw "<RAMTEXT>を"
	linefw "ベンチに だしました"
	done

PlacedInTheArenaText:
	textfw "<RAMTEXT>を"
	linefw "バトル場に だしました"
	done

ShufflesTheDeckText:
	textfw "<RAMNAME>の山札を よくきります"
	done

ThisIsJustPracticeDoNotShuffleText:
	textfw "れんしゅうなので 山札をきりません"
	done

EachPlayerShuffleOpponentsDeckText:
	textfw "おたがいの山札を よくきります"
	done

EachPlayerDraw7CardsText:
	textfw "おたがいに 7枚ずつひきます"
	done

Drew7CardsText:
	textfw "<RAMNAME>は"
	linefw "手札を7枚ひきます"
	done

DeckHasXCardsText:
	textfw "<RAMNAME>の山札は <RAMNUM>枚です"
	done

ChooseBasicPkmnToPlaceInArenaText:
	textfw "バトル場に だす"
	linefw "たねポケモンを えらんでください"
	done

NoBasicPokemonInHandText:
	textfw "<RAMNAME>の 手札の中には"
	linefw "たねポケモンが ありませんでした"
	done

NeitherPlayerHasBasicPkmnText:
	textfw "おたがいに 手札の中には"
	linefw "たねポケモンが ありませんでした"
	done

ReturnCardsToDeckAndDrawAgainText:
	textfw "山札に もどして"
	linefw "カードをひきなおします"
	done

ChooseUpToXBasicPkmnToPlaceOnBenchText:
	textfw "ベンチに だす たねポケモンを"
	linefw "<RAMNUM>ひきまで えらべます"
	done

PleaseChooseAnActivePokemonText:
	textfw "バトル場のポケモンを"
	linefw "えらんでください"
	done

ChooseYourBenchPokemonText:
	textfw "ベンチのポケモンを"
	linefw "えらんでください"
	done

YouDrewText:
	textfw "<RAMTEXT>を ひいた"
	done

YouCannotSelectThisCardText:
	textfw "このカードは えらべません"
	done

PlacingThePrizesText:
	textfw "サイドカードを セットします"
	done

PleasePlacePrizesText:
	textfw "おたがいに"
	linefw "サイドカードを <RAMNUM>枚セットします"
	done

IfHeadsDuelistPlaysFirstText:
	textfw "「おもて」が でれば"
	linefw "<RAMTEXT>の せんこうです"
	done

CoinTossToDecideWhoPlaysFirstText:
	textfw "コインをなげて"
	linefw "せんこう・こうこうを きめます"
	done

DecisionText:
	textfw "はんていを おこないます"
	done

DuelWasADrawText:
	textfw "<RAMNAME>との対戦に ひきわけた"
	done

WonDuelText:
	textfw "<RAMNAME>との対戦に 勝った!"
	done

LostDuelText:
	textfw "<RAMNAME>との対戦に"
	linefw "まけてしまった・・・"
	done

StartSuddenDeathMatchText:
	textfw "「サドン・デス」スタート!"
	linefw "サイドカード1枚で 対戦です"
	done

PrizesLeftActivePokemonCardsInDeckText:
	textfw "サイドカード"
	linefw "対戦ポケモン"
	linefw "山札の数"
	done

NoneText:
	textfw "なし"
	done

YesText:
	textfw "あり"
	done

CardsUnitText:
	textfw "枚"
	done

DrewFromPrizesText:
	textfw "<RAMNAME>は サイドカードから"
	linefw "<RAMTEXT>を ひいた"
	done

TookAllThePrizesText:
	textfw "<RAMNAME>は サイドカードを"
	linefw "すべて とりおえた!"
	done

NoPokemonInPlayAreaText:
	textfw "<RAMNAME>の 場には"
	linefw "ポケモンが いなくなった"
	done

WasKnockedOutText:
	textfw "<RAMTEXT>は きぜつした"
	done

HavePokemonPowerText:
	textfw "<RAMTEXT>は"
	linefw "特殊能力を もっている"
	done

HavePkmnPowerButUnableDueToToxicGasText:
	textfw "しかし 「かがくへんかガス」の効果で"
	linefw "特殊能力は つかえない"
	done

HavePkmnPowerButUnableDueToGoopGasAttackText:
	textfw "しかし 「まきちらせ!ベトベトガス」"
	linefw "の効果で 特殊能力は つかえない"
	done

HavePkmnPowerButUnableDueToStareText:
	textfw "しかし 「ショックアイ」"
	linefw "の効果で 特殊能力は つかえない"
	done

PlayCheck1Text: ; grammmar for "to play"
	textfw " つかう"
	linefw " しらべる"
	done

PlayCheck2Text: ; grammmar for "to play"
	textfw " だす"
	linefw " しらべる"
	done

SelectCheckText:
	textfw " えらぶ"
	linefw " しらべる"
	done

UnusedText008c: ; unused?
	textfw "B<RAMNUM>S<RAMNUM>"
	done

DuelistIsThinkingText:
	textfw "<RAMNAME>は かんがえ中"
	done

ClearOpponentNameText:
	textfw "          "
	done

SelectComputerOpponentText:
	textfw "対戦コンピューター選択"
	done

NumberOfPrizesText:
	textfw "サイド枚数"
	done

DebugRandom1Text:
	textfw "ランダム1"
	done

DebugRandom2Text:
	textfw "ランダム2"
	done

DebugRandom3Text:
	textfw "ランダム3"
	done

DebugRandom4Text:
	textfw "ランダム4"
	done

DebugTrainingComputerOpponentText:
	textfw "教育用COM"
	done

Player1Text:
	textfw "プレイヤー1"
	done

Player2Text:
	text "Player2"
	done

DebugDirectionLeftToRightText:
	textfw "左から右"
	done

DebugDirectionRightToLeftText:
	textfw "右から左"
	done

DebugChangeExecuteEndText:
	textfw "START:入替え"
	linefw "    A:実行"
	linefw "    B:終了"
	done

DebugDuelMenu1Text:
	textfw "そのた"
	linefw "どく"
	linefw "ねむり"
	linefw "マヒ"
	linefw "こんらん"
	linefw "どくどく"
	linefw "クリア"
	linefw "えんまく状態"
	linefw "相手の手札"
	linefw "手札からトラッシュ"
	linefw "山札選択"
	linefw "トラッシュ選択"
	linefw "手札を山札へ"
	linefw "サイドひく"
	linefw "プレイヤー入替え"
	linefw "山札シャッフル"
	linefw "ベンチをトラッシュ"
	linefw "カード入替え"
	done

DebugDuelMenu2Text:
	textfw "ゲーム勝ち"
	linefw "ゲーム負け"
	linefw "ゲーム引き分け"
	linefw "限定環境"
	linefw "ポーズモード"
	linefw "コンピューター対戦切り替え"
	linefw "プレイヤー2をCOMにする"
	linefw "コイン投げ20回"
	linefw "現在の状態をセーブする"
	linefw "ファイルをロードする"
	done

DebugSaveFileText:
	textfw "ファイルセーブ"
	done

DebugLoadFileLastSavedFileText:
	textfw "ファイルロード"
	linefw " 0 最後にセーブされたファイル"
	done

DebugPauseModeOnText:
	textfw "ポーズモードがONになりました"
	linefw "SELECTでポーズがかかります"
	done

DebugPauseModeOffText:
	textfw "ポーズモードがOFFになりました"
	done

DebugComputerModeOnText:
	textfw "コンピューターモードが"
	linefw "OFFになりました"
	done

DebugComputerModeOffText:
	textfw "コンピューターモードが"
	linefw "ONになりました"
	done

DebugCardCategoryListText:
	textfw "<GRASS>ポケモン"
	linefw "<FIRE>ポケモン"
	linefw "<WATER>ポケモン"
	linefw "<LIGHTNING>ポケモン"
	linefw "<FIGHTING>ポケモン"
	linefw "<PSYCHIC>ポケモン"
	linefw "<COLORLESS>ポケモン"
	linefw "トレーナーカード"
	linefw "エネルギーカード"
	done

DebugBoosterPackListText:
	textfw "はじめてのポケモン"
	linefw "でんせつのちから"
	linefw "化石のしま"
	linefw "超バトル"
	linefw "そらをとぶポケモン"
	linefw "われらロケット団"
	linefw "ロケット団のやぼう"
	linefw "スペシャル"
	linefw "エネルギー"
	linefw "プレゼントパック1"
	linefw "プレゼントパック2"
	linefw "プレゼントパック3"
	linefw "プレゼントパック4"
	linefw "DDIパック"
	done

DebugSpecialDuelRuleListText:
	textfw "クリア"
	linefw "草ポケモンは特殊にならない"
	linefw "雷ポケモンは攻擊力+10"
	linefw "炎ポケモンは水の弱点なし"
	linefw "ベンチ数が3"
	linefw "水ポケモンはにげるコスト-1"
	linefw "闘ポケモンからのダメージ抵抗力無効"
	linefw "抵抗力は-30から-10になる"
	linefw "ポケモントラッシュ基本E手札に戻る"
	linefw "逃げるときコスト+1"
	linefw "トラッシュカード使えない"
	done

DebugCardListText:
	textfw "カードリスト"
	done

DebugTestCoinFlipText:
	textfw "コイン投げをテストします"
	done

DebugEndWithoutPrizesText:
	textfw "サイドカードなし 終わりにする?"
	done

ResetBackUpRamText:
	textfw "バックアップRAMを初期化する?"
	done

DebugIncidentAbortPleaseSubmitRomText:
	textfw "!!!! ABORT !!!!"
	linefw "重大な問題が発生しました"
	linefw "プログラムを停止します"
	linefw "カートリッジを提出してください"
	done

NoCardsInHandText:
	textfw "手札が ありません"
	done

TheDiscardPileHasNoCardsText:
	; Variant of NoCardsInDiscardPileText with different whitespace placement
	; but was distinct in tcg1-en: "The Discard Pile has no cards."
	textfw "トラッシュにカードが ありません"
	done

DuelistDiscardPileText:
	textfw "<RAMNAME>のトラッシュ"
	done

DuelistHandText:
	textfw "<RAMNAME>のてふだ"
	done

DuelistPlayAreaText:
	textfw "<RAMNAME>の場"
	done

DuelistDeckText:
	textfw "<RAMNAME>の山札"
	done

DuelistPrizeCardsText:
	textfw "<RAMNAME>のサイドカード"
	done

PleaseSelectHandText:
	textfw "てふだを"
	linefw "えらんでください"
	done

EnergyCardsAttachedToPokemonText:
	textfw "ポケモンについている"
	linefw "エネルギーカード いちらん"
	done

PleaseSelectCardText:
	textfw "カードを"
	linefw "えらんでください"
	done

NoPokemonWithDamageCountersText:
	textfw "ダメージカウンターの のっている"
	linefw "ポケモンが いません"
	done

NoDamageCountersText:
	textfw "ダメージカウンターが のっていません"
	done

NoEnergyAttachedToPokemonInOppPlayAreaText:
	; "Energy" compared to
	; "Energy Cards" in NoEnergyCardsAttachedToPokemonInOppPlayAreaText
	textfw "相手の場の ポケモンに"
	linefw "エネルギーが ついていません"
	done

NoEnergyCardsInDiscardPileText:
	textfw "トラッシュに"
	linefw "エネルギーカードが ありません"
	done

NoBasicEnergyCardsInDiscardPileText:
	textfw "トラッシュに"
	linefw "基本エネルギーカードが ありません"
	done

NoCardsLeftInTheDeckText:
	textfw "山札に カードがありません"
	done

NoSpaceOnTheBenchText:
	textfw "ベンチに あきがありません"
	done

NoPokemonCapableOfEvolvingText:
	textfw "進化できる ポケモンがいません"
	done

CantEvolvePokemonInSameTurnItsPlacedText:
	textfw "だした おなじ番には 進化できません"
	done

NotAffectedByStatusText:
	textfw "「どく・ねむり・マヒ・こんらん」の"
	linefw "特殊状態に なっていません"
	done

NotEnoughCardsInHandText:
	textfw "手札が たりません"
	done

EffectNoPokemonOnTheBenchText:
	textfw "控えポケモンが いません"
	done

NoBasicPokemonInDiscardPileText:
	textfw "トラッシュに"
	linefw "たねポケモンが ありません"
	done

NoPokemonInDiscardPileText:
	textfw "トラッシュに"
	linefw "ポケモンが ありません"
	done

ConditionsForEvolvingToStage2NotFulfilledText:
	textfw "2進化ポケモンに 進化させる"
	linefw "じょうけんが そろっていません"
	done

NoCardsInHandExchangeableText:
	textfw "手札に 交換できるカードがありません"
	done

NoCardsInDiscardPileText:
	; Variant of TheDiscardPileHasNoCardsText with different whitespace placement
	; but was distinct in tcg1-en: "There are no cards in the<LINE>Discard Pile."
	textfw "トラッシュに カードがありません"
	done

NoEvolvedPokemonText:
	textfw "進化ポケモンが 場にいません"
	done

NoEnergyCardsAttachedToPokemonInYourPlayAreaText:
	textfw "自分の場の ポケモンに"
	linefw "エネルギーカードに ついていません"
	done

NoEnergyCardsAttachedToPokemonInOppPlayAreaText:
	textfw "相手の場の ポケモンに"
	linefw "エネルギーカードが ついていません"
	done

EnergyRequiredToRetreatText:
	textfw "にげるためには"
	linefw "エネルギーが <RAMNUM>コひつようです"
	done

NotEnoughEnergyCardsText:
	textfw "エネルギーカードが たりません"
	done

NotEnoughFireEnergyText:
	textfw "「炎」エネルギーが たりません"
	done

NotEnoughPsychicEnergyText:
	textfw "「超」エネルギーが たりません"
	done

NotEnoughWaterEnergyText:
	textfw "「水」エネルギーが たりません"
	done

NoTrainerCardsInDiscardPileText:
	textfw "トラッシュに"
	linefw "トレーナーカードが ありません"
	done

NoAttacksMayBeChosenText:
	textfw "せんたくできるワザが ありません"
	done

YouDidNotReceiveAnAttackToMirrorMoveText:
	textfw "相手の番に オウムがえしできる"
	linefw "ワザを うけていません"
	done

CannotBeUsedTwiceText:
	textfw "すでに つかっているので"
	linefw "つかえません"
	done

NoWeaknessText:
	textfw "「弱点」が ありません"
	done

NoResistanceText:
	textfw "「抵抗力」が ありません"
	done

CannotChangeWeaknessDueToNoWeaknessText:
	textfw "[相手]に「弱点」が ないので"
	linefw "「弱点」の へんこうはできません"
	done

OnlyOncePerTurnText:
	textfw "自分の番に いちど だけです"
	done

CannotUseDueToStatusText:
	textfw "「ねむり・マヒ・こんらん」の"
	linefw "特殊状態のため つかえません"
	done

CannotBeUsedInTurnWhichWasPlayedText:
	textfw "場にだした番には つかえません"
	done

NoEnergyCardsAttachedText:
	textfw "エネルギーカードが ついていません"
	done

NoGrassEnergyText:
	textfw "「草」エネルギーが ありません"
	done

CannotUseSinceTheresOnly1PkmnText:
	textfw "1体しかいないので つかえません"
	done

CannotUseBecauseItWillBeKnockedOutText:
	textfw "「きぜつ」してしまうので"
	linefw "つかえません"
	done

CanOnlyBeUsedOnTheBenchText:
	textfw "ベンチでしか つかえません"
	done

NoBenchedPokemonOnBenchText: ; grammatically redundant
	textfw "ベンチに 控えポケモンがいません"
	done

OpponentIsNotAsleepText:
	textfw "[相手]が"
	linefw "「ねむり」状態に なってません"
	done

UnableDueToToxicGasText:
	textfw "「かがくへんかガス」の効果で"
	linefw "つかえない"
	done

UnableDueToStareText:
	textfw "「ショックアイ」の効果で"
	linefw "つかえない"
	done

NoBasicEnergyCardsAttachedToOpponentText:
	textfw "[相手]に 基本エネルギーカードが"
	linefw "ついていません"
	done

NoSpecialEnergyCardsInDiscardPileText:
	textfw "トラッシュに"
	linefw "特殊エネルギーカードが ありません"
	done

NoBasicEnergyAttachedToPokemonInOppPlayAreaText:
	textfw "相手の場の ポケモンに"
	linefw "基本エネルギーが ついていません"
	done

NoBasicEnergyAttachedToPokemonInYourPlayAreaText:
	textfw "自分の場の ポケモンに"
	linefw "基本エネルギーが ついていません"
	done

CannotUseThisTurnText:
	textfw "この番では つかえません"
	done

CannotUseDueToNotAsleepText:
	textfw "「ねむり」状態ではないため"
	linefw "つかえません"
	done

NoCardsInOpponentsHandText:
	textfw "相手に 手札がありません"
	done

NoEvolutionCardsInDiscardPileText:
	textfw "トラッシュに 進化カードが"
	linefw "ありません"
	done

NoPokemonEvolvingFromFossilText:
	textfw "「なにかの化石」から 進化した"
	linefw "ポケモンがいません"
	done

CannotUseSinceItAlreadyHas2FoodCountersText:
	textfw "「たべものカウンター」が"
	linefw "2コのっているので つかえません"
	done

CannotEvolveText:
	textfw "進化できません"
	done

CannotUseText:
	textfw "つかえません"
	done

NotEnoughEnergyCardsInHandText:
	textfw "手札のエネルギーカードが たりません"
	done

NoWaterEnergyInOppPlayAreaText:
	textfw "相手の場に 水エネルギーがありません"
	done

CannotUseThisAttackText:
	textfw "このワザは つかえません"
	done

TransmissionErrorSimpleText:
	textfw "通信エラーが はっせいしました"
	done

BackUpIsBrokenText:
	textfw "バックアップが こわれてます"
	done

PrinterIsNotConnectedText:
	textfw "エラー <No>0<RAMNUM>"
	linefw "プリンターが つながってません"
	done

BatteriesHaveLostTheirChargeText:
	textfw "エラー <No>0<RAMNUM>"
	linefw "プリンターの電池が のこりわずかです"
	done

PrinterPaperIsJammedText:
	textfw "エラー <No>0<RAMNUM>"
	linefw "プリンターの紙が つまっています"
	done

PrinterErrorText:
	; doesn't say "check cable or printer switch"
	textfw "エラー <No>0<RAMNUM>"
	linefw "プリンターのエラーです"
	done

PrinterPacketErrorText:
	textfw "エラー <No>0<RAMNUM>"
	linefw "プリンターのパケットエラーです"
	done

PrintingWasInterruptedText:
	textfw "プリントが ちゅうだん されました"
	done

CardPopCannotBePlayedWithTheGameBoyText: ; unused?
	; left over from tcg1-jp, whose cartridge's built-in infrared allowed GB
	; "Play with GB or GBC, can't with SGB"
	; doesn't make sense at all for the GBC-only tcg2
	textfw "スーパーゲームボーイでは"
	linefw "「カードポン!」は あそべません"
	linefw "ゲームボーイ ゲームボーイカラーで"
	linefw "あそんでください"
	done

GBCOnlyString:
	textfw "  このカートリッジは"
	linefw "ゲームボーイカラーせんようです"
	linefw "  ゲームボーイカラーで"
	linefw "  しようしてください"
	done

SandAttackCheckText:
	textfw "「すなかけ」判定"
	linefw "「うら」ならワザは しっぱい"
	done

SmokescreenCheckText:
	textfw "「えんまく」判定"
	linefw "「うら」ならワザは しっぱい"
	done

LightningFlashCheckText:
	textfw "「サンダーフラッシュ」判定"
	linefw "「うら」ならワザは しっぱい"
	done

ParalysisInflictionCheckText:
	textfw "「マヒ」判定!"
	linefw "「おもて」なら[相手]を「マヒ」"
	done

SleepInflictionCheckText:
	textfw "「ねむり」判定!"
	linefw "「おもて」なら[相手]を「ねむり」"
	done

PoisonInflictionCheckText:
	textfw "「どく」判定!"
	linefw "「おもて」なら[相手]を「どく」"
	done

PoisonedIfHeadsParalyzedIfTailsText:
	textfw "「おもて」なら[相手]を「どく」"
	linefw "「うら」なら[相手]を「マヒ」"
	done

IfHeadsPlus20AndParalysisText:
	textfw "「おもて」なら20ダメージついかと"
	linefw "[相手]を「マヒ」"
	done

ConfusionInflictionCheckText:
	textfw "「こんらん」判定!"
	linefw "「おもて」なら[相手]を「こんらん」"
	done

VenomPowderCheckText:
	textfw "「りんぷん」判定! 「おもて」なら"
	linefw "[相手]を「どく」と「こんらん」"
	done

IfTailsYourPokemonBecomesConfusedText:
	textfw "「うら」なら"
	linefw "[自分]は「こんらん」"
	done

DamageCheckIfTailsNoDamageText:
	textfw "ダメージ判定!"
	linefw "「うら」なら ダメージなし!!"
	done

IfHeadsDraw1CardFromDeckText:
	textfw "「おもて」なら"
	linefw "山札から1枚カードをひく!"
	done

FlipUntilTails10DamageTimesHeadsText:
	textfw "「うら」が でるまで ふる"
	linefw "「おもて」×10ダメージ!!"
	done

IfHeadPlus10IfTails10ToYourselfText:
	textfw "「おもて」なら +10ダメージ!"
	linefw "「うら」なら[自分]に 10ダメージ!"
	done

DamageToOppBenchIfHeadsDamageToYoursIfTailsText:
	textfw "「おもて」なら[相手]の 「うら」なら"
	linefw "自分の控え全員に 10ダメージ!"
	done

IfHeadsChangeOpponentsActivePokemonText:
	textfw "「おもて」なら"
	linefw "相手の対戦ポケモンをいれかえる"
	done

IfHeadsHealIsSuccessfulText:
	textfw "「おもて」なら"
	linefw "「ヒーリング」成功!!"
	done

IfTailsDamageToYourselfTooText:
	textfw "「うら」なら"
	linefw "[自分]にも <RAMNUM>ダメージ!"
	done

AttackSuccessCheckText:
	textfw "ワザの成功判定!"
	linefw "「おもて」なら ワザ成功!!"
	done

TrainerCardSuccessCheckText:
	textfw "トレーナーカードの成功判定!"
	linefw "「おもて」なら成功!"
	done

GamblerQuantityCheckText:
	textfw "枚数判定!"
	linefw "「おもて」8枚!「うら」1枚!"
	done

IfHeadsNoDamageNextTurnText:
	textfw "「おもて」なら つぎの相手の番に"
	linefw "ダメージを うけなくなる!"
	done

DamageCheckSimpleText: ; unused?
	textfw "ダメージ判定"
	done

DamageCheckIfHeadsPlusDamageText:
	textfw "ダメージ判定!"
	linefw "「おもて」なら+<RAMNUM>ダメージ!!"
	done

DamageCheckXDamageTimesHeadsText:
	textfw "ダメージ判定!"
	linefw "「おもて」×<RAMNUM>ダメージ!!"
	done

DamageCheckPlusXDamageForEachHeadsText:
	textfw "ダメージ判定!"
	linefw "「おもて」×<RAMNUM>ダメージ追加!!"
	done

AcidCheckText:
	textfw "「ようかいえき」判定"
	linefw "「おもて」ならつぎの番ににげられない"
	done

TransparencyCheckText:
	textfw "「とうめい」判定"
	linefw "「おもて」なら ワザをうけない"
	done

ConfusionCheckDamageText:
	textfw "「こんらん」チェックをします"
	linefw "「うら」なら [自分]にダメージ"
	done

ConfusionCheckRetreatText:
	textfw "「こんらん」判定!"
	linefw "「うら」なら にげられない"
	done

PokemonsSleepCheckText:
	textfw "<RAMTEXT>の"
	linefw "「ねむり」のけいぞく チェック!"
	done

PoisonedIfHeadsConfusedIfTailsText:
	textfw "「おもて」なら[相手]を「どく」状態"
	linefw "「うら」なら「こんらん」状態"
	done

IfHeadsDoNotReceiveDamageOrEffectText:
	textfw "「おもて」なら つぎの相手の番に"
	linefw "ワザのダメージと効果を うけない!"
	done

IfHeadsOpponentCannotAttackText:
	textfw "「おもて」なら つぎの相手の番に"
	linefw "[相手]は ワザをつかえない!"
	done

FinalBeamSuccessCheckText:
	textfw "「おもて」なら"
	linefw "「ファイナルビーム」成功!"
	done

ConfuseOppIfHeadsConfuseYourselfIfTailsText:
	textfw "「おもて」なら[相手]を「うら」なら"
	linefw "[自分]を「こんらん」状態"
	done

LongDistanceHypnosisCheckText:
	textfw "「おもて」なら[相手]を「うら」なら"
	linefw "[自分]を「ねむり」状態"
	done

DamageCheckXDamageTimesTailsText:
	textfw "ダメージ判定!"
	linefw "「うら」×<RAMNUM>ダメージ!!"
	done

DamageCheckIfTailsPlusDamageText:
	textfw "ダメージ判定!"
	linefw "「うら」なら+<RAMNUM>ダメージ!!"
	done

SinkholeCheckText:
	textfw "おとしあな判定!"
	linefw "「うら」なら 20ダメージ!!"
	done

ConfusedIfHeadsSleepIfTailsText:
	textfw "「おもて」なら [相手]を「こんらん」"
	linefw "「うら」なら 「ねむり」状態"
	done

ParalyzedIfHeadsPoisonedIfTailsText:
	textfw "「おもて」なら [相手]を 「マヒ」"
	linefw "「うら」なら 「どく」状態"
	done

AsleepIfHeadsConfusedIfTailsText:
	textfw "「おもて」なら [相手]を「ねむり」"
	linefw "「うら」なら 「こんらん」状態"
	done

IfTails40DamageToYourselfTooText:
	textfw "「うら」なら"
	linefw "[自分]にも 40ダメージ!!"
	done

FlipUntilTails20DamageTimesHeadsText:
	textfw "「うら」が でるまで ふる"
	linefw "「おもて」×20ダメージ!!"
	done

IfHeadsDiscard1EnergyCardText:
	textfw "「おもて」なら エネルギーカードを"
	linefw "1枚トラッシュ!"
	done

IfHeadsOpponentCannotRetreatText:
	textfw "「おもて」なら"
	linefw "[相手]は つぎの番に にげられない"
	done

IfHeads10DamageToBenchText:
	textfw "「おもて」なら"
	linefw "ベンチのポケモンに 10ダメージ!"
	done

IfTails30DamageTo1OfYourPkmnText:
	textfw "「うら」なら 自分の場の"
	linefw "ポケモンに 30ダメージ!"
	done

Plus20DamageIfHeads20DamageToYourselfIfTailsText:
	textfw "「おもて」なら 20ダメージついか"
	linefw "「うら」なら [自分]に20ダメージ"
	done

IfTailsNoDamageToOppAnd20ToYourselfText:
	textfw "「うら」なら ダメージ無しと"
	linefw "[自分]に20ダメージ"
	done

BlinkCheckText:
	textfw "「ブリンク」判定"
	linefw "「おもて」なら ダメージをうけない"
	done

IfHeads20DamageTo1OfOppPkmnText:
	textfw "「おもて」なら あいての場の"
	linefw "ポケモンに 20ダメージ!"
	done

IfHeadsDoNotReceiveDamageText:
	textfw "「おもて」なら つぎの相手の番に"
	linefw "ワザのダメージを うけない!"
	done

IfHeadsDiscard1EnergyCardFromOpponentText:
	textfw "「おもて」なら [相手]の"
	linefw "エネルギーカードを 1枚トラッシュ!"
	done

IfTailsDiscard1EnergyCardFromYourselfText:
	textfw "「うら」なら [自分]の"
	linefw "エネルギーカードを 1枚トラッシュ!"
	done

30DamageToOppIfHeads10DamageToBenchIfTailsText:
	textfw "「おもて」なら [相手]に30ダメージ"
	linefw "「うら」なら ベンチに10ダメージ"
	done

FailIfEitherOf2CoinsIsTailsText:
	textfw "コインを 2枚なげて 1枚でも"
	linefw "「うら」なら このワザは しっぱい!"
	done

KickingAndStampingCheckText:
	textfw "「おもて」なら 10ダメージついか"
	linefw "「うら」なら [相手]をいれかえる"
	done

DrawCardForEachHeadsText:
	textfw "「おもて」の数だけ カードをひく"
	done

ClearProfitCheckText:
	textfw "「うら」がでるまで コインをなげて"
	linefw "「おもて」の数だけ カードをひく"
	done

FocusedOneShotCheckText:
	textfw "「おもて」なら つぎの番「どつく」が"
	linefw "2倍ダメージ 「うら」ならつかえない"
	done

ParalyzedIfHeadsUnableToAttackNextTurnIfTailsText:
	textfw "「おもて」なら [相手]を「マヒ」"
	linefw "「うら」なら つぎの番つかえない"
	done

10DamageForEachHeadsToBenchInAnyWayYouLikeText:
	textfw "「おもて」の数 ×10ダメージを"
	linefw "自由に控えポケモンに わりふる"
	done

PoisonMistCheckText:
	textfw "「おもて」なら つぎの自分の番の"
	linefw "はじめまで 毒ダメージが20になる"
	done

DryUpCheckText:
	textfw "「おもて」の数だけ"
	linefw "「水」エネルギーを はがす"
	done

FossilizeCheckText: $013d
	textfw "「おもて」なら 「なにかの化石」から"
	linefw "進化した進化カードを 手札にもどせる"
	linefw ""
	done
