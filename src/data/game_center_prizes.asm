MACRO? gamecenter_prize
	tx \1 ; name
	dw \2 ; price
ENDM

GameCenterPrizeExchangeItems:
	gamecenter_prize GameCenterPrizeVenusaurText,       GAMECENTERPRIZE_VENUSAUR_CHIPS
	gamecenter_prize GameCenterPrizeMewText,            GAMECENTERPRIZE_MEW_CHIPS
	gamecenter_prize GameCenterPrizeBillsComputerText,  GAMECENTERPRIZE_BILLS_COMPUTER_CHIPS
	gamecenter_prize GameCenterPrizeJigglypuffCoinText, GAMECENTERPRIZE_JIGGLYPUFF_COIN_CHIPS
	gamecenter_prize GameCenterPrize1PresentPackText,   GAMECENTERPRIZE_1_PRESENT_PACK_CHIPS
	gamecenter_prize GameCenterPrize3PresentPacksText,  GAMECENTERPRIZE_3_PRESENT_PACKS_CHIPS
