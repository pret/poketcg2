NPCDuelistPointers:
	dw SamNPCDuelistHeader          ; $00
	dw AaronNPCDuelistHeader        ; $01
	dw NikkiNPCDuelistHeader        ; $02
	dw BrittanyNPCDuelistHeader     ; $03
	dw KristinNPCDuelistHeader      ; $04
	dw HeatherNPCDuelistHeader      ; $05
	dw AmyNPCDuelistHeader          ; $06
	dw JoshuaNPCDuelistHeader       ; $07
	dw SaraNPCDuelistHeader         ; $08
	dw AmandaNPCDuelistHeader       ; $09
	dw GeneNPCDuelistHeader         ; $0a
	dw MatthewNPCDuelistHeader      ; $0b
	dw RyanNPCDuelistHeader         ; $0c
	dw AndrewNPCDuelistHeader       ; $0d
	dw MitchNPCDuelistHeader        ; $0e
	dw MichaelNPCDuelistHeader      ; $0f
	dw ChrisNPCDuelistHeader        ; $10
	dw JessicaNPCDuelistHeader      ; $11
	dw RickNPCDuelistHeader         ; $12
	dw DavidNPCDuelistHeader        ; $13
	dw JosephNPCDuelistHeader       ; $14
	dw ErikNPCDuelistHeader         ; $15
	dw KenNPCDuelistHeader          ; $16
	dw JohnNPCDuelistHeader         ; $17
	dw AdamNPCDuelistHeader         ; $18
	dw JonathanNPCDuelistHeader     ; $19
	dw IsaacNPCDuelistHeader        ; $1a
	dw JenniferNPCDuelistHeader     ; $1b
	dw NicholasNPCDuelistHeader     ; $1c
	dw BrandonNPCDuelistHeader      ; $1d
	dw MurrayNPCDuelistHeader       ; $1e
	dw RobertNPCDuelistHeader       ; $1f
	dw DanielNPCDuelistHeader       ; $20
	dw StephanieNPCDuelistHeader    ; $21
	dw RodNPCDuelistHeader          ; $22
	dw JackNPCDuelistHeader         ; $23
	dw SteveNPCDuelistHeader        ; $24
	dw CourtneyNPCDuelistHeader     ; $25
	dw MorinoNPCDuelistHeader       ; $26
	dw MiyukiNPCDuelistHeader       ; $27
	dw YutaNPCDuelistHeader         ; $28
	dw MidoriNPCDuelistHeader       ; $29
	dw CatherineNPCDuelistHeader    ; $2a
	dw IchikawaNPCDuelistHeader     ; $2b
	dw RennaNPCDuelistHeader        ; $2c
	dw HideroNPCDuelistHeader       ; $2d
	dw ShokoNPCDuelistHeader        ; $2e
	dw YukiNPCDuelistHeader         ; $2f
	dw JesNPCDuelistHeader          ; $30
	dw KanokoNPCDuelistHeader       ; $31
	dw AiraNPCDuelistHeader         ; $32
	dw SentaNPCDuelistHeader        ; $33
	dw MiyajimaNPCDuelistHeader     ; $34
	dw KamiyaNPCDuelistHeader       ; $35
	dw GraceNPCDuelistHeader        ; $36
	dw GotaNPCDuelistHeader         ; $37
	dw MamiNPCDuelistHeader         ; $38
	dw RyokoNPCDuelistHeader        ; $39
	dw YosukeNPCDuelistHeader       ; $3a
	dw KevinNPCDuelistHeader        ; $3b
	dw MiwaNPCDuelistHeader         ; $3c
	dw SamejimaNPCDuelistHeader     ; $3d
	dw IshiiNPCDuelistHeader        ; $3e
	dw NishijimaNPCDuelistHeader    ; $3f
	dw BiruritchiNPCDuelistHeader   ; $40
	dw RuiNPCDuelistHeader          ; $41
	dw KanzakiNPCDuelistHeader      ; $42
	dw RonaldNPCDuelistHeader       ; $43
	dw ImakuniBlackNPCDuelistHeader ; $44
	dw ImakuniRedNPCDuelistHeader   ; $45
	dw IshiharaNPCDuelistHeader     ; $46
	dw TapNPCDuelistHeader          ; $47
	dw QueenNPCDuelistHeader        ; $48
	dw RookNPCDuelistHeader         ; $49
	dw BishopNPCDuelistHeader       ; $4a
	dw KnightNPCDuelistHeader       ; $4b
	dw PawnNPCDuelistHeader         ; $4c
	dw TobichanNPCDuelistHeader     ; $4d
	dw EijiNPCDuelistHeader         ; $4e
	dw MagicianNPCDuelistHeader     ; $4f
	dw YuiNPCDuelistHeader          ; $50
	dw ToshironNPCDuelistHeader     ; $51
	dw PierrotNPCDuelistHeader      ; $52
	dw AnnaNPCDuelistHeader         ; $53
	dw DeeNPCDuelistHeader          ; $54
	dw MasqueradeNPCDuelistHeader   ; $55
	dw GR1NPCDuelistHeader          ; $56
	dw GR2NPCDuelistHeader          ; $57
	dw GR3NPCDuelistHeader          ; $58
	dw GR4NPCDuelistHeader          ; $59
	dw NULL

; *_NPCDuelistHeader structure:
; byte 1: overworld object
; bytes 2, 3: dialog-box name
; bytes 4, 5: home name (abbreviated)
; bytes 6, 7: title (abbreviated)
; bytes 8--12: deck IDs
SamNPCDuelistHeader:
	db OW_SAM
	tx DialogSamText
	tx 0
	tx 0
	db UNUSED_SAMS_PRACTICE_DECK_ID
	db $ff
	db $ff
	db $ff
	db $ff
AaronNPCDuelistHeader:
	db OW_AARON
	tx DialogAaronText
	tx 0
	tx DialogTechText
	db AARONS_STEP1_DECK_ID
	db AARONS_STEP2_DECK_ID
	db AARONS_STEP3_DECK_ID
	db BRICK_WALK_DECK_ID
	db BENCH_TRAP_DECK_ID
NikkiNPCDuelistHeader:
	db OW_NIKKI
	tx DialogNikkiText
	tx GrassClubShortText
	tx OpponentGrassClubMasterBracketedText
	db MAX_ENERGY_DECK_ID
	db $ff
	db $ff
	db $ff
	db $ff
BrittanyNPCDuelistHeader:
	db OW_BRITTANY
	tx DialogBrittanyText
	tx GrassClubShortText
	tx OpponentGrassClubMemberBracketedText
	db REMAINING_GREEN_DECK_ID
	db POISON_CURSE_DECK_ID
	db $ff
	db $ff
	db $ff
KristinNPCDuelistHeader:
	db OW_KRISTIN
	tx DialogKristinText
	tx GrassClubShortText
	tx OpponentGrassClubMemberBracketedText
	db GLITTERING_SCALES_DECK_ID
	db $ff
	db $ff
	db $ff
	db $ff
HeatherNPCDuelistHeader:
	db OW_HEATHER
	tx DialogHeatherText
	tx GrassClubShortText
	tx OpponentGrassClubMemberBracketedText
	db STEADY_INCREASE_DECK_ID
	db $ff
	db $ff
	db $ff
	db $ff
AmyNPCDuelistHeader:
	db OW_AMY_LOUNGE
	tx DialogAmyText
	tx WaterClubShortText
	tx OpponentWaterClubMasterBracketedText
	db RAIN_DANCE_CONFUSION_DECK_ID
	db $ff
	db $ff
	db $ff
	db $ff
JoshuaNPCDuelistHeader:
	db OW_JOSHUA
	tx DialogJoshuaText
	tx WaterClubShortText
	tx OpponentWaterClubMemberBracketedText
	db CONSERVING_WATER_DECK_ID
	db ENERGY_REMOVAL_DECK_ID
	db $ff
	db $ff
	db $ff
SaraNPCDuelistHeader:
	db OW_SARA
	tx DialogSaraText
	tx WaterClubShortText
	tx OpponentWaterClubMemberBracketedText
	db SPLASHING_ABOUT_DECK_ID
	db $ff
	db $ff
	db $ff
	db $ff
AmandaNPCDuelistHeader:
	db OW_AMANDA
	tx DialogAmandaText
	tx WaterClubShortText
	tx OpponentWaterClubMemberBracketedText
	db BEACH_DECK_ID
	db $ff
	db $ff
	db $ff
	db $ff
GeneNPCDuelistHeader:
	db OW_GENE
	tx DialogGeneText
	tx RockClubShortText
	tx OpponentRockClubMasterBracketedText
	db EVEN3_YEARS_ON_A_ROCK_DECK_ID
	db $ff
	db $ff
	db $ff
	db $ff
MatthewNPCDuelistHeader:
	db OW_MATTHEW
	tx DialogMatthewText
	tx RockClubShortText
	tx OpponentRockClubMemberBracketedText
	db ROLLING_STONE_DECK_ID
	db $ff
	db $ff
	db $ff
	db $ff
RyanNPCDuelistHeader:
	db OW_RYAN
	tx DialogRyanText
	tx RockClubShortText
	tx OpponentRockClubMemberBracketedText
	db GREAT_EARTHQUAKE_DECK_ID
	db $ff
	db $ff
	db $ff
	db $ff
AndrewNPCDuelistHeader:
	db OW_ANDREW
	tx DialogAndrewText
	tx RockClubShortText
	tx OpponentRockClubMemberBracketedText
	db AWESOME_FOSSIL_DECK_ID
	db $ff
	db $ff
	db $ff
	db $ff
MitchNPCDuelistHeader:
	db OW_MITCH
	tx DialogMitchText
	tx FightingClubShortText
	tx OpponentFightingClubMasterBracketedText
	db RAGING_BILLOW_OF_FISTS_DECK_ID
	db $ff
	db $ff
	db $ff
	db $ff
MichaelNPCDuelistHeader:
	db OW_MICHAEL
	tx DialogMichaelText
	tx FightingClubShortText
	tx OpponentFightingClubMemberBracketedText
	db YOU_CAN_DO_IT_MACHOP_DECK_ID
	db NEW_MACHOKE_DECK_ID
	db $ff
	db $ff
	db $ff
ChrisNPCDuelistHeader:
	db OW_CHRIS
	tx DialogChrisText
	tx FightingClubShortText
	tx OpponentFightingClubMemberBracketedText
	db SKILLED_WARRIOR_DECK_ID
	db $ff
	db $ff
	db $ff
	db $ff
JessicaNPCDuelistHeader:
	db OW_JESSICA
	tx DialogJessicaText
	tx FightingClubShortText
	tx OpponentFightingClubMemberBracketedText
	db I_LOVE_TO_FIGHT_DECK_ID
	db $ff
	db $ff
	db $ff
	db $ff
RickNPCDuelistHeader:
	db OW_RICK
	tx DialogRickText
	tx ScienceClubShortText
	tx OpponentScienceClubMasterBracketedText
	db DARK_SCIENCE_DECK_ID
	db $ff
	db $ff
	db $ff
	db $ff
DavidNPCDuelistHeader:
	db OW_DAVID
	tx DialogDavidText
	tx ScienceClubShortText
	tx OpponentScienceClubMemberBracketedText
	db NATURAL_SCIENCE_DECK_ID
	db $ff
	db $ff
	db $ff
	db $ff
JosephNPCDuelistHeader:
	db OW_JOSEPH
	tx DialogJosephText
	tx ScienceClubShortText
	tx OpponentScienceClubMemberBracketedText
	db POISONOUS_SWAMP_DECK_ID
	db $ff
	db $ff
	db $ff
	db $ff
ErikNPCDuelistHeader:
	db OW_ERIK
	tx DialogErikText
	tx ScienceClubShortText
	tx OpponentScienceClubMemberBracketedText
	db GATHERING_NIDORAN_DECK_ID
	db $ff
	db $ff
	db $ff
	db $ff
KenNPCDuelistHeader:
	db OW_KEN
	tx DialogKenText
	tx FireClubShortText
	tx OpponentFireClubMasterBracketedText
	db GO_ARCANINE_DECK_ID
	db $ff
	db $ff
	db $ff
	db $ff
JohnNPCDuelistHeader:
	db OW_JOHN
	tx DialogJohnText
	tx FireClubShortText
	tx OpponentFireClubMemberBracketedText
	db FLAME_FESTIVAL_DECK_ID
	db $ff
	db $ff
	db $ff
	db $ff
AdamNPCDuelistHeader:
	db OW_ADAM
	tx DialogAdamText
	tx FireClubShortText
	tx OpponentFireClubMemberBracketedText
	db ELECTRIC_CURRENT_SHOCK_DECK_ID
	db $ff
	db $ff
	db $ff
	db $ff
JonathanNPCDuelistHeader:
	db OW_JONATHAN
	tx DialogJonathanText
	tx FireClubShortText
	tx OpponentFireClubMemberBracketedText
	db IMMORTAL_FLAME_DECK_ID
	db $ff
	db $ff
	db $ff
	db $ff
IsaacNPCDuelistHeader:
	db OW_ISAAC
	tx DialogIsaacText
	tx LightningClubShortText
	tx OpponentLightningClubMasterBracketedText
	db SKY_SPARK_DECK_ID
	db ELECTRIC_SELFDESTRUCT_DECK_ID
	db $ff
	db $ff
	db $ff
JenniferNPCDuelistHeader:
	db OW_JENNIFER
	tx DialogJenniferText
	tx LightningClubShortText
	tx OpponentLightningClubMemberBracketedText
	db I_LOVE_PIKACHU_DECK_ID
	db $ff
	db $ff
	db $ff
	db $ff
NicholasNPCDuelistHeader:
	db OW_NICHOLAS
	tx DialogNicholasText
	tx LightningClubShortText
	tx OpponentLightningClubMemberBracketedText
	db OVERFLOW_DECK_ID
	db TRIPLE_ZAPDOS_DECK_ID
	db $ff
	db $ff
	db $ff
BrandonNPCDuelistHeader:
	db OW_BRANDON
	tx DialogBrandonText
	tx LightningClubShortText
	tx OpponentLightningClubMemberBracketedText
	db TEN_THOUSAND_VOLTS_DECK_ID
	db $ff
	db $ff
	db $ff
	db $ff
MurrayNPCDuelistHeader:
	db OW_MURRAY
	tx DialogMurrayText
	tx PsychicClubShortText
	tx OpponentPsychicClubMasterBracketedText
	db HAND_OVER_GR_DECK_ID
	db PSYCHIC_ELITE_DECK_ID
	db $ff
	db $ff
	db $ff
RobertNPCDuelistHeader:
	db OW_ROBERT
	tx DialogRobertText
	tx PsychicClubShortText
	tx OpponentPsychicClubMemberBracketedText
	db PHANTOM_DECK_ID
	db $ff
	db $ff
	db $ff
	db $ff
DanielNPCDuelistHeader:
	db OW_DANIEL
	tx DialogDanielText
	tx PsychicClubShortText
	tx OpponentPsychicClubMemberBracketedText
	db PUPPET_MASTER_DECK_ID
	db $ff
	db $ff
	db $ff
	db $ff
StephanieNPCDuelistHeader:
	db OW_STEPHANIE
	tx DialogStephanieText
	tx PsychicClubShortText
	tx OpponentPsychicClubMemberBracketedText
	db PSYCHOKINESIS_DECK_ID
	db $ff
	db $ff
	db $ff
	db $ff
RodNPCDuelistHeader:
	db OW_ROD
	tx DialogRodText
	tx 0
	tx OpponentGrandMasterText
	db GREAT_DRAGON_DECK_ID
	db $ff
	db $ff
	db $ff
	db $ff
JackNPCDuelistHeader:
	db OW_JACK
	tx DialogJackText
	tx 0
	tx OpponentGrandMasterText
	db WATER_LEGEND_DECK_ID
	db $ff
	db $ff
	db $ff
	db $ff
SteveNPCDuelistHeader:
	db OW_STEVE
	tx DialogSteveText
	tx 0
	tx OpponentGrandMasterText
	db LEGENDARY_FOSSIL_DECK_ID
	db $ff
	db $ff
	db $ff
	db $ff
CourtneyNPCDuelistHeader:
	db OW_COURTNEY
	tx DialogCourtneyText
	tx 0
	tx OpponentGrandMasterText
	db GRAND_FIRE_DECK_ID
	db $ff
	db $ff
	db $ff
	db $ff
MorinoNPCDuelistHeader:
	db OW_MORINO
	tx DialogMorinoText
	tx GRGrassFortShortText
	tx OpponentGRGrassFortLeaderText
	db MAD_PETALS_DECK_ID
	db $ff
	db $ff
	db $ff
	db $ff
MiyukiNPCDuelistHeader:
	db OW_MIYUKI
	tx DialogMiyukiText
	tx GRGrassFortShortText
	tx OpponentGRGrassFortMemberText
	db STICKY_POISON_GAS_DECK_ID
	db $ff
	db $ff
	db $ff
	db $ff
YutaNPCDuelistHeader:
	db OW_YUTA
	tx DialogYutaText
	tx GRGrassFortShortText
	tx OpponentGRGrassFortMemberText
	db DEMONIC_FOREST_DECK_ID
	db $ff
	db $ff
	db $ff
	db $ff
MidoriNPCDuelistHeader:
	db OW_MIDORI
	tx DialogMidoriText
	tx GRGrassFortShortText
	tx OpponentGRGrassFortMemberText
	db BUG_COLLECTING_DECK_ID
	db $ff
	db $ff
	db $ff
	db $ff
CatherineNPCDuelistHeader:
	db OW_CATHERINE
	tx DialogCatherineText
	tx GRLightningFortShortText
	tx OpponentGRLightningFortLeaderText
	db QUICK_ATTACK_DECK_ID
	db $ff
	db $ff
	db $ff
	db $ff
IchikawaNPCDuelistHeader:
	db OW_ICHIKAWA
	tx DialogIchikawaText
	tx GRLightningFortShortText
	tx OpponentGRLightningFortMemberText
	db THIS_IS_THE_POWER_OF_ELECTRICITY_DECK_ID
	db $ff
	db $ff
	db $ff
	db $ff
RennaNPCDuelistHeader:
	db OW_RENNA
	tx DialogRennaText
	tx GRLightningFortShortText
	tx OpponentGRLightningFortMemberText
	db CHAIN_LIGHTNING_BY_PIKACHU_DECK_ID
	db $ff
	db $ff
	db $ff
	db $ff
HideroNPCDuelistHeader:
	db OW_HIDERO
	tx DialogHideroText
	tx GRFireFortShortText
	tx OpponentGRFireFortLeaderText
	db GAZE_UPON_THE_POWER_OF_FIRE_DECK_ID
	db $ff
	db $ff
	db $ff
	db $ff
ShokoNPCDuelistHeader:
	db OW_SHOKO
	tx DialogShokoText
	tx GRFireFortShortText
	tx OpponentGRFireFortMemberText
	db EEVEE_SHOWDOWN_DECK_ID
	db $ff
	db $ff
	db $ff
	db $ff
YukiNPCDuelistHeader:
	db OW_YUKI
	tx DialogYukiText
	tx GRFireFortShortText
	tx OpponentGRFireFortMemberText
	db FIREBALL_DECK_ID
	db $ff
	db $ff
	db $ff
	db $ff
JesNPCDuelistHeader:
	db OW_JES
	tx DialogJesText
	tx GRFireFortShortText
	tx OpponentGRFireFortMemberText
	db COMPLETE_COMBUSTION_DECK_ID
	db $ff
	db $ff
	db $ff
	db $ff
KanokoNPCDuelistHeader:
	db OW_KANOKO
	tx DialogKanokoText
	tx GRWaterFortShortText
	tx OpponentGRWaterFortLeaderText
	db WATER_STREAM_DECK_ID
	db $ff
	db $ff
	db $ff
	db $ff
AiraNPCDuelistHeader:
	db OW_AIRA
	tx DialogAiraText
	tx GRWaterFortShortText
	tx OpponentGRWaterFortMemberText
	db BENCH_CALL_DECK_ID
	db $ff
	db $ff
	db $ff
	db $ff
SentaNPCDuelistHeader:
	db OW_SENTA
	tx DialogSentaText
	tx GRWaterFortShortText
	tx OpponentGRWaterFortMemberText
	db PARALYZED_PARALYZED_DECK_ID
	db $ff
	db $ff
	db $ff
	db $ff
MiyajimaNPCDuelistHeader:
	db OW_MIYAJIMA
	tx DialogMiyajimaText
	tx GRWaterFortShortText
	tx OpponentGRWaterFortMemberText
	db WHIRLPOOL_SHOWER_DECK_ID
	db $ff
	db $ff
	db $ff
	db $ff
KamiyaNPCDuelistHeader:
	db OW_KAMIYA
	tx DialogKamiyaText
	tx GRFightingFortShortText
	tx OpponentGRFightingFortLeaderText
	db RUNNING_WILD_DECK_ID
	db $ff
	db $ff
	db $ff
	db $ff
GraceNPCDuelistHeader:
	db OW_GRACE
	tx DialogGraceText
	tx GRFightingFortShortText
	tx OpponentGRFightingFortMemberText
	db FULL_STRENGTH_DECK_ID
	db $ff
	db $ff
	db $ff
	db $ff
GotaNPCDuelistHeader:
	db OW_GODA
	tx DialogGotaText
	tx GRFightingFortShortText
	tx OpponentGRFightingFortMemberText
	db ROCK_BLAST_DECK_ID
	db $ff
	db $ff
	db $ff
	db $ff
MamiNPCDuelistHeader:
	db OW_MAMI
	tx DialogMamiText
	tx GRPsychicStrongholdShortText
	tx OpponentGRPsychicStrongholdLeaderText
	db SPIRITED_AWAY_DECK_ID
	db $ff
	db $ff
	db $ff
	db $ff
RyokoNPCDuelistHeader:
	db OW_RYOKO
	tx DialogRyokoText
	tx GRPsychicStrongholdShortText
	tx OpponentGRPsychicStrongholdMemberText
	db POKEMON_POWER_DECK_ID
	db $ff
	db $ff
	db $ff
	db $ff
YosukeNPCDuelistHeader:
	db OW_YOSUKE
	tx DialogYosukeText
	tx GRPsychicStrongholdShortText
	tx OpponentGRPsychicStrongholdMemberText
	db BAD_DREAM_DECK_ID
	db $ff
	db $ff
	db $ff
	db $ff
KevinNPCDuelistHeader:
	db OW_KEVIN
	tx DialogKevinText
	tx GRPsychicStrongholdShortText
	tx OpponentGRPsychicStrongholdMemberText
	db SUPERDESTRUCTIVE_POWER_DECK_ID
	db $ff
	db $ff
	db $ff
	db $ff
MiwaNPCDuelistHeader:
	db OW_MIWA
	tx DialogMiwaText
	tx GRPsychicStrongholdShortText
	tx OpponentGRPsychicStrongholdMemberText
	db DIRECT_HIT_DECK_ID
	db $ff
	db $ff
	db $ff
	db $ff
SamejimaNPCDuelistHeader:
	db OW_SAMEJIMA
	tx DialogSamejimaText
	tx ColorlessAltarShortText
	tx OpponentColorlessAltarGuardianText
	db SUDDEN_GROWTH_DECK_ID
	db $ff
	db $ff
	db $ff
	db $ff
IshiiNPCDuelistHeader:
	db OW_ISHII
	tx DialogIshiiText
	tx ColorlessAltarShortText
	tx OpponentColorlessAltarGuardianText
	db EYE_OF_THE_STORM_DECK_ID
	db $ff
	db $ff
	db $ff
	db $ff
NishijimaNPCDuelistHeader:
	db OW_NISHIJIMA
	tx DialogNishijimaText
	tx ColorlessAltarShortText
	tx OpponentColorlessAltarGuardianText
	db SNORLAX_GUARD_DECK_ID
	db $ff
	db $ff
	db $ff
	db $ff
BiruritchiNPCDuelistHeader:
	db OW_BIRURITCHI
	tx DialogBiruritchiText
	tx 0
	tx OpponentGRKingText
	db STOP_LIFE_DECK_ID
	db SCORCHER_DECK_ID
	db TSUNAMI_STARTER_DECK_ID
	db SMASH_TO_MINCEMEAT_DECK_ID
	db $ff
RuiNPCDuelistHeader:
	db OW_RUI
	tx DialogRuiText
	tx 0
	tx OpponentGRBigBossText
	db POISON_MIST_DECK_ID
	db ULTRA_REMOVAL_DECK_ID
	db PSYCHIC_BATTLE_DECK_ID
	db $ff
	db $ff
KanzakiNPCDuelistHeader:
	db OW_KANZAKI
	tx DialogKanzakiText
	tx 0
	tx OpponentGRBigBossText
	db BAD_GUYS_DECK_ID
	db $ff
	db $ff
	db $ff
	db $ff
RonaldNPCDuelistHeader:
	db OW_RONALD
	tx DialogRonaldText
	tx 0
	tx OpponentRivalText
	db RONALDS_UNCOOL_DECK_ID
	db RONALDS_GRX_DECK_ID
	db RONALDS_POWER_DECK_ID
	db RONALDS_PSYCHIC_DECK_ID
	db RONALDS_ULTRA_DECK_ID
ImakuniBlackNPCDuelistHeader:
	db OW_IMAKUNI_BLACK
	tx DialogImakuniText
	tx 0
	tx OpponentStrangeLifeFormText
	db WEIRD_DECK_ID
	db $ff
	db $ff
	db $ff
	db $ff
ImakuniRedNPCDuelistHeader:
	db OW_IMAKUNI_RED
	tx DialogImakuniText
	tx 0
	tx OpponentStrangeLifeFormText
	db STRANGE_DECK_ID
	db $ff
	db $ff
	db $ff
	db $ff
IshiharaNPCDuelistHeader:
	db OW_ISHIHARA
	tx DialogMrIshiharaText
	tx 0
	tx 0
	db VERY_RARE_CARD_DECK_ID
	db $ff
	db $ff
	db $ff
	db $ff
TapNPCDuelistHeader:
	db OW_TAP
	tx DialogTapText
	tx 0
	tx 0
	db DANGEROUS_BENCH_DECK_ID
	db $ff
	db $ff
	db $ff
	db $ff
QueenNPCDuelistHeader:
	db OW_QUEEN
	tx DialogQueenText
	tx 0
	tx 0
	db POWERFUL_POKEMON_DECK_ID
	db $ff
	db $ff
	db $ff
	db $ff
RookNPCDuelistHeader:
	db OW_ROOK
	tx DialogRookText
	tx 0
	tx 0
	db COLORLESS_ENERGY_DECK_ID
	db $ff
	db $ff
	db $ff
	db $ff
BishopNPCDuelistHeader:
	db OW_BISHOP
	tx DialogBishopText
	tx 0
	tx 0
	db TEXTURE_TUNER7_DECK_ID
	db $ff
	db $ff
	db $ff
	db $ff
KnightNPCDuelistHeader:
	db OW_KNIGHT
	tx DialogKnightText
	tx 0
	tx 0
	db PROTOHISTORIC_DECK_ID
	db $ff
	db $ff
	db $ff
	db $ff
PawnNPCDuelistHeader:
	db OW_PAWN
	tx DialogPawnText
	tx 0
	tx 0
	db TEST_YOUR_LUCK_DECK_ID
	db $ff
	db $ff
	db $ff
	db $ff
TobichanNPCDuelistHeader:
	db OW_TOBICHAN
	tx DialogTobichanText
	tx 0
	tx 0
	db POISON_STORM_DECK_ID
	db $ff
	db $ff
	db $ff
	db $ff
EijiNPCDuelistHeader:
	db OW_EIJI
	tx DialogEijiText
	tx 0
	tx 0
	db EVERYBODYS_FRIEND_DECK_ID
	db $ff
	db $ff
	db $ff
	db $ff
MagicianNPCDuelistHeader:
	db OW_MAGICIAN
	tx DialogMagicianText
	tx 0
	tx 0
	db IMMORTAL_POKEMON_DECK_ID
	db $ff
	db $ff
	db $ff
	db $ff
YuiNPCDuelistHeader:
	db OW_YUI
	tx DialogYuiText
	tx 0
	tx 0
	db TORRENTIAL_FLOOD_DECK_ID
	db $ff
	db $ff
	db $ff
	db $ff
ToshironNPCDuelistHeader:
	db OW_TOSHIRON
	tx DialogToshironText
	tx 0
	tx 0
	db TRAINER_IMPRISON_DECK_ID
	db $ff
	db $ff
	db $ff
	db $ff
PierrotNPCDuelistHeader:
	db OW_PIERROT
	tx DialogPierrotText
	tx 0
	tx 0
	db BLAZING_FLAME_DECK_ID
	db $ff
	db $ff
	db $ff
	db $ff
AnnaNPCDuelistHeader:
	db OW_ANNA
	tx DialogAnnaText
	tx 0
	tx 0
	db DAMAGE_CHAOS_DECK_ID
	db $ff
	db $ff
	db $ff
	db $ff
DeeNPCDuelistHeader:
	db OW_DEE
	tx DialogDeeText
	tx 0
	tx 0
	db BIG_THUNDER_DECK_ID
	db $ff
	db $ff
	db $ff
	db $ff
MasqueradeNPCDuelistHeader:
	db OW_MASQUERADE
	tx DialogMasqueradeText
	tx 0
	tx 0
	db POWER_OF_DARKNESS_DECK_ID
	db $ff
	db $ff
	db $ff
	db $ff
GR1NPCDuelistHeader:
	db OW_GR_1
	tx DialogGR1Text
	tx 0
	tx OpponentEnigmaticMaskText
	db GREAT_ROCKET1_DECK_ID
	db $ff
	db $ff
	db $ff
	db $ff
GR2NPCDuelistHeader:
	db OW_GR_2
	tx DialogGR2Text
	tx 0
	tx OpponentEnigmaticMaskText
	db GREAT_ROCKET2_DECK_ID
	db $ff
	db $ff
	db $ff
	db $ff
GR3NPCDuelistHeader:
	db OW_GR_3
	tx DialogGR3Text
	tx 0
	tx OpponentEnigmaticMaskText
	db GREAT_ROCKET3_DECK_ID
	db $ff
	db $ff
	db $ff
	db $ff
GR4NPCDuelistHeader:
	db OW_GR_4
	tx DialogGR4Text
	tx 0
	tx OpponentEnigmaticMaskText
	db GREAT_ROCKET4_DECK_ID
	db $ff
	db $ff
	db $ff
	db $ff
