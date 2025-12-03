EffectCommands::
	; Each attack has a two-byte effect pointer (attack's 7th param) that points to one of these structures.
	; Similarly, trainer cards have a two-byte pointer (7th param) to one of these structures, which determines the card's function.
	; Energy cards also point to one of these, but their data is just $00.
	;	db Bank
	;	db EFFECTCMDTYPE_* ($01 - $0b)
	;	dw Function
	;	...
	;	db $00

	; The first byte is the bank where the effect function is located
	; Commands are associated to a time or a scope (EFFECTCMDTYPE_*) that determines when their function is executed during the turn.
	; - EFFECTCMDTYPE_INITIAL_EFFECT_1: Executed right after attack or trainer card is used. Bypasses Smokescreen and Sand Attack effects.
	; - EFFECTCMDTYPE_INITIAL_EFFECT_2: Executed right after attack, Pokemon Power, or trainer card is used.
	; - EFFECTCMDTYPE_DISCARD_ENERGY: For attacks or trainer cards that require putting one or more attached energy cards into the discard pile.
	; - EFFECTCMDTYPE_REQUIRE_SELECTION: For attacks, Pokemon Powers, or trainer cards requiring the user to select a card (from e.g. play area screen or card list).
	; - EFFECTCMDTYPE_BEFORE_DAMAGE: Effect command of an attack executed prior to the damage step. For trainer card or Pokemon Power, usually the main effect.
	; - EFFECTCMDTYPE_AFTER_DAMAGE: Effect command executed after the damage step.
	; - EFFECTCMDTYPE_AI_SWITCH_DEFENDING_PKMN: For attacks that may result in the defending Pokemon being switched out. Called only for AI-executed attacks.
	; - EFFECTCMDTYPE_PKMN_POWER_TRIGGER: Pokemon Power effects that trigger the moment the Pokemon card is played.
	; - EFFECTCMDTYPE_AI: Used for AI scoring.
	; - EFFECTCMDTYPE_AI_SELECTION: When AI is required to select a card
	; - EFFECTCMDTYPE_UNK_11: ?

	; Attacks that have an EFFECTCMDTYPE_REQUIRE_SELECTION also must have either an EFFECTCMDTYPE_AI_SWITCH_DEFENDING_PKMN or an
	; EFFECTCMDTYPE_AI_SELECTION (for anything not involving switching the defending Pokemon), to handle selections involving the AI.

	; Similar attack effects of different Pokemon cards all point to a different command list,
	; even though in some cases their commands and function pointers match.

	; Function name examples
	;	PoisonEffect                     ; generic effect shared by multiple attacks.
	;	Paralysis50PercentEffect         ;
	;	KakunaStiffenEffect              ; unique effect from an attack known by multiple cards.
	;	MetapodStiffenEffect             ;
	;	AcidEffect                       ; unique effect from an attack known by a single card
	;	FoulOdorEffect                   ;
	;	SpitPoison_Poison50PercentEffect ; unique effect made of more than one command.
	;	SpitPoison_AIEffect              ;

EkansSpitPoisonEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, SpitPoison_Poison50PercentEffect
	dbw EFFECTCMDTYPE_AI, SpitPoison_AIEffect
	db $00

EkansWrapEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, EkansWrapEffect
	db $00

ArbokTerrorStrikeEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, TerrorStrike_InitialEffect
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, TerrorStrike_SwitchDefendingPokemon
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, TerrorStrike_50PercentSelectSwitchPokemon
	dbw EFFECTCMDTYPE_AI_SWITCH_DEFENDING_PKMN, TerrorStrike_50PercentSelectSwitchPokemon
	db $00

ArbokPoisonFangEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, PoisonFang_PoisonEffect
	dbw EFFECTCMDTYPE_AI, PoisonFang_AIEffect
	db $00

WeepinbellPoisonPowderEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, WeepinbellPoisonPowder_Poison50PercentEffect
	dbw EFFECTCMDTYPE_AI, WeepinbellPoisonPowder_AIEffect
	db $00

VictreebelLureEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, VictreebelLure_AssertPokemonInBench
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, VictreebelLure_SwitchDefendingPokemon
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, VictreebelLure_SelectSwitchPokemon
	dbw EFFECTCMDTYPE_AI_SELECTION, VictreebelLure_GetBenchPokemonWithLowestHP
	db $00

VictreebelAcidEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, AcidEffect
	db $00

PinsirIronGripEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, IronGripEffect
	db $00

CaterpieStringShotEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, StringShotEffect
	db $00

GloomPoisonPowderEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, GloomPoisonPowder_PoisonEffect
	dbw EFFECTCMDTYPE_AI, GloomPoisonPowder_AIEffect
	db $00

GloomFoulOdorEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, FoulOdorEffect
	db $00

KakunaStiffenEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, KakunaStiffenEffect
	db $00

KakunaPoisonPowderEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, KakunaPoisonPowder_PoisonEffect
	dbw EFFECTCMDTYPE_AI, KakunaPoisonPowder_AIEffect
	db $00

GolbatLv29LeechLifeEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, GolbatLv29LeechLifeEffect
	db $00

VenonatStunSporeEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, VenonatStunSpore
	db $00

VenonatLeechLifeEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, VenonatLeechLifeEffect
	db $00

ScytherSwordsDanceEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, SwordsDanceEffect
	db $00

ZubatSupersonicEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, ZubatSupersonicEffect
	db $00

ZubatLeechLifeEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, ZubatLeechLifeEffect
	db $00

BeedrillTwineedleEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Twineedle_MultiplierEffect
	dbw EFFECTCMDTYPE_AI, Twineedle_AIEffect
	db $00

BeedrillPoisonStingEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, BeedrillPoisonSting_Poison50PercentEffect
	dbw EFFECTCMDTYPE_AI, BeedrillPoisonSting_AIEffect
	db $00

ExeggcuteHypnosisEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, ExeggcuteHypnosisEffect
	db $00

ExeggcuteLeechSeedEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, ExeggcuteLeechSeedEffect
	db $00

KoffingFoulGasEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, FoulGas_PoisonOrConfusionEffect
	dbw EFFECTCMDTYPE_AI, FoulGas_AIEffect
	db $00

MetapodStiffenEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, MetapodStiffenEffect
	db $00

MetapodStunSporeEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, MetapodStunSporeEffect
	db $00

OddishStunSporeEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, OddishStunSporeEffect
	db $00

OddishSproutEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Sprout_CheckDeckAndPlayArea
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Sprout_PutInPlayAreaEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, Sprout_PlayerSelectEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, Sprout_AISelectEffect
	db $00

ExeggutorTeleportEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Teleport_CheckBench
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Teleport_SwitchEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, Teleport_PlayerSelectEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, Teleport_AISelectEffect
	db $00

ExeggutorBigEggsplosionEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, BigEggsplosion_MultiplierEffect
	dbw EFFECTCMDTYPE_AI, BigEggsplosion_AIEffect
	db $00

NidokingThrashEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Thrash_ModifierEffect
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Thrash_RecoilEffect
	dbw EFFECTCMDTYPE_AI, Thrash_AIEffect
	db $00

NidokingToxicEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Toxic_DoublePoisonEffect
	dbw EFFECTCMDTYPE_AI, Toxic_AIEffect
	db $00

NidoqueenBoyfriendsEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, BoyfriendsEffect
	db $00

NidoranFFurySwipesEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, NidoranFFurySwipes_MultiplierEffect
	dbw EFFECTCMDTYPE_AI, NidoranFFurySwipes_AIEffect
	db $00

NidoranFCallForFamilyEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, NidoranFCallForFamily_CheckDeckAndPlayArea
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, NidoranFCallForFamily_PutInPlayAreaEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, NidoranFCallForFamily_PlayerSelectEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, NidoranFCallForFamily_AISelectEffect
	db $00

NidoranMHornHazardEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, HornHazard_NoDamage50PercentEffect
	dbw EFFECTCMDTYPE_AI, HornHazard_AIEffect
	db $00

NidorinaSupersonicEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, NidorinaSupersonicEffect
	db $00

NidorinaDoubleKickEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, NidorinaDoubleKick_MultiplierEffect
	dbw EFFECTCMDTYPE_AI, NidorinaDoubleKick_AIEffect
	db $00

NidorinoDoubleKickEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, NidorinoDoubleKick_MultiplierEffect
	dbw EFFECTCMDTYPE_AI, NidorinoDoubleKick_AIEffect
	db $00

ButterfreeWhirlwindEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, ButterfreeWhirlwind_SwitchEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, ButterfreeWhirlwind_CheckBench
	dbw EFFECTCMDTYPE_AI_SWITCH_DEFENDING_PKMN, ButterfreeWhirlwind_CheckBench
	db $00

ButterfreeMegaDrainEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, ButterfreeMegaDrainEffect
	db $00

ParasSporeEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, ParasSporeEffect
	db $00

ParasectSporeEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, ParasectSporeEffect
	db $00

WeedlePoisonStingEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, WeedlePoisonSting_Poison50PercentEffect
	dbw EFFECTCMDTYPE_AI, WeedlePoisonSting_AIEffect
	db $00

IvysaurPoisonPowderEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, IvysaurPoisonPowder_PoisonEffect
	dbw EFFECTCMDTYPE_AI, IvysaurPoisonPowder_AIEffect
	db $00

BulbasaurLeechSeedEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, BulbasaurLeechSeedEffect
	db $00

VenusaurEnergyTransEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, VenusaurEnergyTrans_CheckPlayArea
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, VenusaurEnergyTrans_TransferEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, VenusaurEnergyTrans_PrintProcedure
	dbw EFFECTCMDTYPE_UNK_11, VenusaurEnergyTrans_AIEffect
	db $00

VenusaurAltEnergyTransEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, VenusaurAltEnergyTrans_CheckPlayArea
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, VenusaurAltEnergyTrans_TransferEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, VenusaurAltEnergyTrans_PrintProcedure
	dbw EFFECTCMDTYPE_UNK_11, VenusaurAltEnergyTrans_AIEffect
	db $00

GrimerNastyGooEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, NastyGooEffect
	db $00

GrimerMinimizeEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, GrimerMinimizeEffect
	db $00

MukToxicGasEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, ToxicGasEffect
	db $00

MukSludgeEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Sludge_Poison50PercentEffect
	dbw EFFECTCMDTYPE_AI, Sludge_AIEffect
	db $00

BellsproutCallForFamilyEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, BellsproutCallForFamily_CheckDeckAndPlayArea
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, BellsproutCallForFamily_PutInPlayAreaEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, BellsproutCallForFamily_PlayerSelectEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, BellsproutCallForFamily_AISelectEffect
	db $00

WeezingSmogEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, WeezingSmog_Poison50PercentEffect
	dbw EFFECTCMDTYPE_AI, WeezingSmog_AIEffect
	db $00

WeezingSelfdestructEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, WeezingSelfdestructEffect
	db $00

VenomothShiftEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, Shift_OncePerTurnCheck
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Shift_ChangeColorEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, Shift_PlayerSelectEffect
	db $00

VenomothVenomPowderEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, VenomPowder_PoisonConfusion50PercentEffect
	dbw EFFECTCMDTYPE_AI, VenomPowder_AIEffect
	db $00

TangelaBindEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, BindEffect
	db $00

TangelaPoisonPowderEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, TangelaPoisonPowder_PoisonEffect
	dbw EFFECTCMDTYPE_AI, TangelaPoisonPowder_AIEffect
	db $00

VileplumeHealEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, Heal_OncePerTurnCheck
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Heal_RemoveDamageEffect
	db $00

VileplumePetalDanceEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, PetalDance_MultiplierEffect
	dbw EFFECTCMDTYPE_AI, PetalDance_AIEffect
	db $00

TangelaStunSporeEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, TangelaStunSporeEffect
	db $00

TangelaPoisonWhipEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, PoisonWhip_PoisonEffect
	dbw EFFECTCMDTYPE_AI, PoisonWhip_AIEffect
	db $00

VenusaurSolarPowerEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, SolarPower_CheckUse
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, SolarPower_RemoveStatusEffect
	db $00

VenusaurMegaDrainEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, VenusaurMegaDrainEffect
	db $00

OmastarWaterGunEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, OmastarWaterGunEffect
	dbw EFFECTCMDTYPE_AI, OmastarWaterGunEffect
	db $00

OmastarSpikeCannonEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, OmastarSpikeCannon_MultiplierEffect
	dbw EFFECTCMDTYPE_AI, OmastarSpikeCannon_AIEffect
	db $00

OmanyteClairvoyanceEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, Clairvoyance_CheckUse
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Clairvoyance_CheckHandEffect
	db $00

OmanyteWaterGunEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, OmanyteWaterGunEffect
	dbw EFFECTCMDTYPE_AI, OmanyteWaterGunEffect
	db $00

WartortleWithdrawEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, WartortleWithdrawEffect
	db $00

BlastoiseRainDanceEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, BlastoiseRainDanceEffect
	db $00

BlastoiseHydroPumpEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, BlastoiseHydroPumpEffect
	dbw EFFECTCMDTYPE_AI, BlastoiseHydroPumpEffect
	db $00

BlastoiseAltRainDanceEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, BlastoiseAltRainDanceEffect
	db $00

BlastoiseAltHydroPumpEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, BlastoiseAltHydroPumpEffect
	dbw EFFECTCMDTYPE_AI, BlastoiseAltHydroPumpEffect
	db $00

GyaradosBubblebeamEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, BubblebeamEffect
	db $00

KinglerFlailEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, KinglerFlail_HPCheck
	dbw EFFECTCMDTYPE_AI, KinglerFlail_AIEffect
	db $00

KrabbyCallForFamilyEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, KrabbyCallForFamily_CheckDeckAndPlayArea
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, KrabbyCallForFamily_PutInPlayAreaEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, KrabbyCallForFamily_PlayerSelectEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, KrabbyCallForFamily_AISelectEffect
	db $00

MagikarpFlailEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, MagikarpFlail_HPCheck
	dbw EFFECTCMDTYPE_AI, MagikarpFlail_AIEffect
	db $00

PsyduckHeadacheEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, HeadacheEffect
	db $00

PsyduckFurySwipesEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, PsyduckFurySwipes_MultiplierEffect
	dbw EFFECTCMDTYPE_AI, PsyduckFurySwipes_AIEffect
	db $00

GolduckPsyshockEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, GolduckPsyshockEffect
	db $00

GolduckHyperBeamEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, GolduckHyperBeam_DiscardEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, GolduckHyperBeam_PlayerSelectEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, GolduckHyperBeam_AISelectEffect
	db $00

SeadraWaterGunEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, SeadraWaterGunEffect
	dbw EFFECTCMDTYPE_AI, SeadraWaterGunEffect
	db $00

SeadraAgilityEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, SeadraAgilityEffect
	db $00

ShellderSupersonicEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, ShellderSupersonicEffect
	db $00

ShellderHideInShellEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, HideInShellEffect
	db $00

VaporeonQuickAttackEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, VaporeonQuickAttack_DamageBoostEffect
	dbw EFFECTCMDTYPE_AI, VaporeonQuickAttack_AIEffect
	db $00

VaporeonWaterGunEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, VaporeonWaterGunEffect
	dbw EFFECTCMDTYPE_AI, VaporeonWaterGunEffect
	db $00

DewgongIceBeamEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, DewgongIceBeamEffect
	db $00

StarmieRecoverEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, StarmieRecover_CheckEnergyHP
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, StarmieRecover_PlayerSelectEffect
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, StarmieRecover_HealEffect
	dbw EFFECTCMDTYPE_DISCARD_ENERGY, StarmieRecover_DiscardEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, StarmieRecover_AISelectEffect
	db $00

StarmieStarFreezeEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, StarFreezeEffect
	db $00

SquirtleBubbleEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, SquirtleBubbleEffect
	db $00

SquirtleWithdrawEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, SquirtleWithdrawEffect
	db $00

HorseaSmokescreenEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, HorseaSmokescreenEffect
	db $00

TentacruelSupersonicEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, TentacruelSupersonicEffect
	db $00

TentacruelJellyfishStingEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, JellyfishSting_PoisonEffect
	dbw EFFECTCMDTYPE_AI, JellyfishSting_AIEffect
	db $00

PoliwhirlAmnesiaEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, PoliwhirlAmnesia_CheckAttacks
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, PoliwhirlAmnesia_PlayerSelectEffect
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, PoliwhirlAmnesia_DisableEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, PoliwhirlAmnesia_AISelectEffect
	db $00

PoliwhirlDoubleslapEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, PoliwhirlDoubleslap_MultiplierEffect
	dbw EFFECTCMDTYPE_AI, PoliwhirlDoubleslap_AIEffect
	db $00

PoliwrathWaterGunEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, PoliwrathWaterGunEffect
	dbw EFFECTCMDTYPE_AI, PoliwrathWaterGunEffect
	db $00

PoliwrathWhirlpoolEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, PoliwrathWhirlpool_DiscardEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, PoliwrathWhirlpool_PlayerSelectEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, PoliwrathWhirlpool_AISelectEffect
	db $00

PoliwagWaterGunEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, PoliwagWaterGunEffect
	dbw EFFECTCMDTYPE_AI, PoliwagWaterGunEffect
	db $00

CloysterClampEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Clamp_Successful50PercentEffect
	dbw EFFECTCMDTYPE_AI, Clamp_AIEffect
	db $00

CloysterSpikeCannonEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, CloysterSpikeCannon_MultiplierEffect
	dbw EFFECTCMDTYPE_AI, CloysterSpikeCannon_AIEffect
	db $00

ArticunoFreezeDryEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, FreezeDryEffect
	db $00

ArticunoBlizzardEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Blizzard_BenchDamage50PercentEffect
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Blizzard_BenchDamageEffect
	db $00

TentacoolCowardiceEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, Cowardice_CheckUseAndBench
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Cowardice_ReturnToHandEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, Cowardice_PlayerSelectEffect
	db $00

LaprasWaterGunEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, LaprasWaterGunEffect
	dbw EFFECTCMDTYPE_AI, LaprasWaterGunEffect
	db $00

LaprasConfuseRayEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, LaprasConfuseRayEffect
	db $00

ArticunoQuickfreezeEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Quickfreeze_InitialEffect
	dbw EFFECTCMDTYPE_PKMN_POWER_TRIGGER, Quickfreeze_Paralysis50PercentEffect
	db $00

ArticunoIceBreathEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, IceBreath_ZeroDamage
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, IceBreath_RandomPokemonDamageEffect
	db $00

VaporeonFocusEnergyEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, FocusEnergyEffect
	db $00

ArcanineFlamethrowerEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, ArcanineFlamethrower_CheckEnergy
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, ArcanineFlamethrower_PlayerSelectEffect
	dbw EFFECTCMDTYPE_DISCARD_ENERGY, ArcanineFlamethrower_DiscardEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, ArcanineFlamethrower_AISelectEffect
	db $00

ArcanineLv45TakeDownEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, ArcanineLv45TakeDownEffect
	db $00

ArcanineQuickAttackEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, ArcanineQuickAttack_DamageBoostEffect
	dbw EFFECTCMDTYPE_AI, ArcanineQuickAttack_AIEffect
	db $00

ArcanineFlamesOfRageEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, FlamesOfRage_CheckEnergy
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, FlamesOfRage_PlayerSelectEffect
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, FlamesOfRage_DamageBoostEffect
	dbw EFFECTCMDTYPE_DISCARD_ENERGY, FlamesOfRage_DiscardEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, FlamesOfRage_AISelectEffect
	dbw EFFECTCMDTYPE_AI, FlamesOfRage_AIEffect
	db $00

RapidashStompEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, RapidashStomp_DamageBoostEffect
	dbw EFFECTCMDTYPE_AI, RapidashStomp_AIEffect
	db $00

RapidashAgilityEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, RapidashAgilityEffect
	db $00

NinetalesLureEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, NinetalesLure_CheckBench
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, NinetalesLure_SwitchEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, NinetalesLure_PlayerSelectEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, NinetalesLure_AISelectEffect
	db $00

NinetalesFireBlastEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, FireBlast_CheckEnergy
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, FireBlast_PlayerSelectEffect
	dbw EFFECTCMDTYPE_DISCARD_ENERGY, FireBlast_DiscardEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, FireBlast_AISelectEffect
	db $00

CharmanderEmberEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, CharmanderEmber_CheckEnergy
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, CharmanderEmber_PlayerSelectEffect
	dbw EFFECTCMDTYPE_DISCARD_ENERGY, CharmanderEmber_DiscardEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, CharmanderEmber_AISelectEffect
	db $00

MoltresWildfireEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Wildfire_CheckDeckAndEnergy
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, Wildfire_PlayerSelectEffect
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Wildfire_DiscardDeckEffect
	dbw EFFECTCMDTYPE_DISCARD_ENERGY, Wildfire_DiscardEnergyEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, Wildfire_AISelectEffect
	db $00

MoltresLv35DiveBombEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, MoltresLv35DiveBomb_Success50PercentEffect
	dbw EFFECTCMDTYPE_AI, MoltresLv35DiveBomb_AIEffect
	db $00

FlareonQuickAttackEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, FlareonQuickAttack_DamageBoostEffect
	dbw EFFECTCMDTYPE_AI, FlareonQuickAttack_AIEffect
	db $00

FlareonFlamethrowerEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, FlareonFlamethrower_CheckEnergy
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, FlareonFlamethrower_PlayerSelectEffect
	dbw EFFECTCMDTYPE_DISCARD_ENERGY, FlareonFlamethrower_DiscardEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, FlareonFlamethrower_AISelectEffect
	db $00

MagmarFlamethrowerEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, MagmarFlamethrower_CheckEnergy
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, MagmarFlamethrower_PlayerSelectEffect
	dbw EFFECTCMDTYPE_DISCARD_ENERGY, MagmarFlamethrower_DiscardEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, MagmarFlamethrower_AISelectEffect
	db $00

MagmarSmokescreenEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, MagmarSmokescreenEffect
	db $00

MagmarLv31SmogEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, MagmarLv31Smog_Poison50PercentEffect
	dbw EFFECTCMDTYPE_AI, MagmarLv31Smog_AIEffect
	db $00

CharmeleonFlamethrowerEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, CharmeleonFlamethrower_CheckEnergy
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, CharmeleonFlamethrower_PlayerSelectEffect
	dbw EFFECTCMDTYPE_DISCARD_ENERGY, CharmeleonFlamethrower_DiscardEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, CharmeleonFlamethrower_AISelectEffect
	db $00

CharizardEnergyBurnEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, CharizardEnergyBurnEffect
	db $00

CharizardFireSpinEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, CharizardFireSpin_CheckEnergy
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, CharizardFireSpin_PlayerSelectEffect
	dbw EFFECTCMDTYPE_DISCARD_ENERGY, CharizardFireSpin_DiscardEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, CharizardFireSpin_AISelectEffect
	db $00

CharizardAltEnergyBurnEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, CharizardAltEnergyBurnEffect
	db $00

CharizardAltFireSpinEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, CharizardAltFireSpin_CheckEnergy
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, CharizardAltFireSpin_PlayerSelectEffect
	dbw EFFECTCMDTYPE_DISCARD_ENERGY, CharizardAltFireSpin_DiscardEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, CharizardAltFireSpin_AISelectEffect
	db $00

VulpixConfuseRayEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, VulpixConfuseRayEffect
	db $00

FlareonRageEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, FlareonRage_DamageBoostEffect
	dbw EFFECTCMDTYPE_AI, FlareonRage_AIEffect
	db $00

NinetalesMixUpEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, MixUp_CheckHandAndDeck
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, MixUp_ShuffleCardsEffect
	db $00

NinetalesDancingEmbersEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, DancingEmbers_MultiplierEffect
	dbw EFFECTCMDTYPE_AI, DancingEmbers_AIEffect
	db $00

MoltresFiregiverEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Firegiver_InitialEffect
	dbw EFFECTCMDTYPE_PKMN_POWER_TRIGGER, Firegiver_AddToHandEffect
	db $00

MoltresLv37DiveBombEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, MoltresLv37DiveBomb_Success50PercentEffect
	dbw EFFECTCMDTYPE_AI, MoltresLv37DiveBomb_AIEffect
	db $00

AbraLv10PsyshockEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, AbraLv10PsyshockEffect
	db $00

GengarCurseEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, Curse_CheckDamageAndBench
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Curse_TransferDamageEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, Curse_PlayerSelectEffect
	db $00

GengarDarkMindEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, GengarDarkMind_DamageBenchEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, GengarDarkMind_PlayerSelectEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, GengarDarkMind_AISelectEffect
	db $00

GastlySleepingGasEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, SleepingGasEffect
	db $00

GastlyDestinyBondEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, DestinyBond_CheckEnergy
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, DestinyBond_PlayerSelectEffect
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, DestinyBond_DestinyBondEffect
	dbw EFFECTCMDTYPE_DISCARD_ENERGY, DestinyBond_DiscardEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, DestinyBond_AISelectEffect
	db $00

GastlyLickEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, LickEffect
	db $00

GastlyEnergyConversionEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, EnergyConversion_CheckEnergy
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, EnergyConversion_AddToHandEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, EnergyConversion_PlayerSelectEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, EnergyConversion_AISelectEffect
	db $00

HaunterHypnosisEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, HaunterHypnosisEffect
	db $00

HaunterDreamEaterEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, DreamEaterEffect
	db $00

HaunterTransparencyEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, TransparencyEffect
	db $00

HaunterNightmareEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, HaunterNightmareEffect
	db $00

HypnoProphecyEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Prophecy_CheckDeck
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Prophecy_ReorderDeckEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, Prophecy_PlayerSelectEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, Prophecy_AISelectEffect
	db $00

HypnoDarkMindEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, HypnoDarkMind_DamageBenchEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, HypnoDarkMind_PlayerSelectEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, HypnoDarkMind_AISelectEffect
	db $00

DrowzeeConfuseRayEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, DrowzeeConfuseRayEffect
	db $00

MrMimeInvisibleWallEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, InvisibleWallEffect
	db $00

MrMimeMeditateEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, MrMimeMeditateEffect
	dbw EFFECTCMDTYPE_AI, MrMimeMeditateEffect
	db $00

AlakazamDamageSwapEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, DamageSwap_CheckDamage
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, DamageSwap_SelectAndSwapEffect
	dbw EFFECTCMDTYPE_UNK_11, DamageSwap_SwapEffect
	db $00

AlakazamConfuseRayEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, AlakazamConfuseRayEffect
	db $00

MewPsywaveEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Psywave_DamageMultiplierEffect
	dbw EFFECTCMDTYPE_AI, Psywave_AIEffect
	db $00

MewDevolutionBeamEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, DevolutionBeam_CheckPlayArea
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, DevolutionBeam_PlayerSelectEffect
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, DevolutionBeam_LoadAnimation
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, DevolutionBeam_DevolveEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, DevolutionBeam_AISelectEffect
	db $00

MewNeutralizingShieldEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, NeutralizingShieldEffect
	db $00

MewPsyshockEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, MewPsyshockEffect
	db $00

MewtwoPsychicEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Psychic_DamageBoostEffect
	dbw EFFECTCMDTYPE_AI, Psychic_AIEffect
	db $00

MewtwoBarrierEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Barrier_CheckEnergy
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, Barrier_PlayerSelectEffect
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Barrier_BarrierEffect
	dbw EFFECTCMDTYPE_DISCARD_ENERGY, Barrier_DiscardEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, Barrier_AISelectEffect
	db $00

MewtwoAltEnergyAbsorptionEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, MewtwoAltEnergyAbsorption_CheckDiscardPile
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, MewtwoAltEnergyAbsorption_AddToHandEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, MewtwoAltEnergyAbsorption_PlayerSelectEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, MewtwoAltEnergyAbsorption_AISelectEffect
	db $00

MewtwoEnergyAbsorptionEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, MewtwoEnergyAbsorption_CheckDiscardPile
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, MewtwoEnergyAbsorption_AddToHandEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, MewtwoEnergyAbsorption_PlayerSelectEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, MewtwoEnergyAbsorption_AISelectEffect
	db $00

SlowbroStrangeBehaviorEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, StrangeBehavior_CheckDamage
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, StrangeBehavior_SelectAndSwapEffect
	dbw EFFECTCMDTYPE_UNK_11, StrangeBehavior_SwapEffect
	db $00

SlowbroPsyshockEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, SlowbroPsyshockEffect
	db $00

SlowpokeSpacingOutEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, SpacingOut_CheckDamage
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, SpacingOut_Success50PercentEffect
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, SpacingOut_HealEffect
	db $00

SlowpokeScavengeEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Scavenge_CheckDiscardPile
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, Scavenge_PlayerSelectEnergyEffect
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Scavenge_AddToHandEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, Scavenge_PlayerSelectTrainerEffect
	dbw EFFECTCMDTYPE_DISCARD_ENERGY, Scavenge_DiscardEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, Scavenge_AISelectEffect
	db $00

SlowpokeAmnesiaEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, SlowpokeAmnesia_CheckAttacks
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, SlowpokeAmnesia_PlayerSelectEffect
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, SlowpokeAmnesia_DisableEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, SlowpokeAmnesia_AISelectEffect
	db $00

KadabraRecoverEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, KadabraRecover_CheckEnergyHP
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, KadabraRecover_PlayerSelectEffect
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, KadabraRecover_HealEffect
	dbw EFFECTCMDTYPE_DISCARD_ENERGY, KadabraRecover_DiscardEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, KadabraRecover_AISelectEffect
	db $00

JynxDoubleslapEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, JynxDoubleslap_MultiplierEffect
	dbw EFFECTCMDTYPE_AI, JynxDoubleslap_AIEffect
	db $00

JynxMeditateEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, JynxMeditateEffect
	dbw EFFECTCMDTYPE_AI, JynxMeditateEffect
	db $00

MewMysteryAttackEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, MysteryAttack_RandomEffect
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, MysteryAttack_RecoverEffect
	dbw EFFECTCMDTYPE_AI, MysteryAttack_AIEffect
	db $00

GeodudeStoneBarrageEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, GeodudeStoneBarrage_MultiplierEffect
	dbw EFFECTCMDTYPE_AI, GeodudeStoneBarrage_AIEffect
	db $00

OnixHardenEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, OnixHardenEffect
	db $00

PrimeapeFurySwipesEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, PrimeapeFurySwipes_MultiplierEffect
	dbw EFFECTCMDTYPE_AI, PrimeapeFurySwipes_AIEffect
	db $00

PrimeapeTantrumEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, TantrumEffect
	db $00

MachampStrikesBackEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, StrikesBackEffect
	db $00

KabutoKabutoArmorEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, KabutoArmorEffect
	db $00

KabutopsAbsorbEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, AbsorbEffect
	db $00

CuboneSnivelEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, CuboneSnivelEffect
	db $00

CuboneRageEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, CuboneRage_DamageBoostEffect
	dbw EFFECTCMDTYPE_AI, CuboneRage_AIEffect
	db $00

MarowakBonemerangEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Bonemerang_MultiplierEffect
	dbw EFFECTCMDTYPE_AI, Bonemerang_AIEffect
	db $00

MarowakCallforFriendEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, MarowakCallForFamily_CheckDeckAndPlayArea
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, MarowakCallForFamily_PutInPlayAreaEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, MarowakCallForFamily_PlayerSelectEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, MarowakCallForFamily_AISelectEffect
	db $00

MachokeKarateChopEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, KarateChop_DamageSubtractionEffect
	dbw EFFECTCMDTYPE_AI, KarateChop_AIEffect
	db $00

MachokeSubmissionEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, SubmissionEffect
	db $00

GolemSelfdestructEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, GolemSelfdestructEffect
	db $00

GravelerHardenEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, GravelerHardenEffect
	db $00

RhydonRamEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Ram_RecoilSwitchEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, Ram_SelectSwitchEffect
	dbw EFFECTCMDTYPE_AI_SWITCH_DEFENDING_PKMN, Ram_SelectSwitchEffect
	db $00

RhyhornLeerEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, LeerEffect
	db $00

HitmonleeStretchKickEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, StretchKick_CheckBench
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, StretchKick_BenchDamageEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, StretchKick_PlayerSelectEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, StretchKick_AISelectEffect
	db $00

SandshrewSandAttackEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, SandshrewSandAttackEffect
	db $00

SandslashFurySwipesEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, SandslashFurySwipes_MultiplierEffect
	dbw EFFECTCMDTYPE_AI, SandslashFurySwipes_AIEffect
	db $00

DugtrioEarthquakeEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, DugtrioEarthquakeEffect
	db $00

AerodactylPrehistoricPowerEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, PrehistoricPowerEffect
	db $00

MankeyPeekEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, MankeyPeek_OncePerTurnCheck
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, MankeyPeek_SelectEffect
	db $00

MarowakBoneAttackEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, BoneAttackEffect
	db $00

MarowakWailEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Wail_BenchAndDeckCheck
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Wail_FillBenchEffect
	db $00

ElectabuzzThundershockEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, ElectabuzzThundershockEffect
	db $00

ElectabuzzThunderpunchEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Thunderpunch_ModifierEffect
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Thunderpunch_RecoilEffect
	dbw EFFECTCMDTYPE_AI, Thunderpunch_AIEffect
	db $00

ElectabuzzLightScreenEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, LightScreenEffect
	db $00

ElectabuzzQuickAttackEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, ElectabuzzQuickAttack_DamageBoostEffect
	dbw EFFECTCMDTYPE_AI, ElectabuzzQuickAttack_AIEffect
	db $00

MagnemiteThunderWaveEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, MagnemiteThunderWaveEffect
	db $00

MagnemiteSelfdestructEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, MagnemiteSelfdestructEffect
	db $00

ZapdosThunderEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, ZapdosThunder_Recoil50PercentEffect
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, ZapdosThunder_RecoilEffect
	db $00

ZapdosThunderboltEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, ZapdosThunderboltEffect
	db $00

ZapdosThunderstormEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, ThunderstormEffect
	db $00

JolteonQuickAttackEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, JolteonQuickAttack_DamageBoostEffect
	dbw EFFECTCMDTYPE_AI, JolteonQuickAttack_AIEffect
	db $00

JolteonPinMissileEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, PinMissile_MultiplierEffect
	dbw EFFECTCMDTYPE_AI, PinMissile_AIEffect
	db $00

FlyingPikachuThundershockEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, FlyingPikachuThundershockEffect
	db $00

FlyingPikachuFlyEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, FlyingPikachuFly_Success50PercentEffect
	dbw EFFECTCMDTYPE_AI, FlyingPikachuFly_AIEffect
	db $00

FlyingPikachuAltThundershockEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, FlyingPikachuAltThundershockEffect
	db $00

FlyingPikachuAltFlyEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, FlyingPikachuAltFly_Success50PercentEffect
	dbw EFFECTCMDTYPE_AI, FlyingPikachuAltFly_AIEffect
	db $00

PikachuThunderJoltEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, ThunderJolt_Recoil50PercentEffect
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, ThunderJolt_RecoilEffect
	db $00

PikachuSparkEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Spark_BenchDamageEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, Spark_PlayerSelectEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, Spark_AISelectEffect
	db $00

PikachuLv16GrowlEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, PikachuLv16GrowlEffect
	db $00

PikachuLv16ThundershockEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, PikachuLv16ThundershockEffect
	db $00

PikachuAltLv16GrowlEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, PikachuAltLv16GrowlEffect
	db $00

PikachuAltLv16ThundershockEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, PikachuAltLv16ThundershockEffect
	db $00

ElectrodeChainLightningEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, ChainLightningEffect
	db $00

RaichuAgilityEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, RaichuAgilityEffect
	db $00

RaichuThunderEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, RaichuThunder_Recoil50PercentEffect
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, RaichuThunder_RecoilEffect
	db $00

RaichuGigashockEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Gigashock_BenchDamageEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, Gigashock_PlayerSelectEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, Gigashock_AISelectEffect
	db $00

MagnetonThunderWaveEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, MagnetonThunderWaveEffect
	db $00

MagnetonLv28SelfdestructEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, MagnetonLv28SelfdestructEffect
	db $00

MagnetonSonicboomEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, MagnetonSonicboom_UnaffectedByColorEffect
	dbw EFFECTCMDTYPE_AI, MagnetonSonicboom_UnaffectedByColorEffect
	db $00

MagnetonLv35SelfdestructEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, MagnetonLv35SelfdestructEffect
	db $00

ZapdosPealOfThunderEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, PealOfThunder_InitialEffect
	dbw EFFECTCMDTYPE_PKMN_POWER_TRIGGER, PealOfThunder_RandomlyDamageEffect
	db $00

ZapdosBigThunderEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, BigThunderEffect
	db $00

MagnemiteMagneticStormEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, MagneticStormEffect
	db $00

ElectrodeSonicboomEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, ElectrodeSonicboom_UnaffectedByColorEffect
	dbw EFFECTCMDTYPE_AI, ElectrodeSonicboom_UnaffectedByColorEffect
	db $00

ElectrodeEnergySpikeEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, EnergySpike_DeckCheck
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, EnergySpike_AttachEnergyEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, EnergySpike_PlayerSelectEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, EnergySpike_AISelectEffect
	db $00

JolteonDoubleKickEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, JolteonDoubleKick_MultiplierEffect
	dbw EFFECTCMDTYPE_AI, JolteonDoubleKick_AIEffect
	db $00

JolteonStunNeedleEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, StunNeedleEffect
	db $00

EeveeTailWagEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, TailWagEffect
	db $00

EeveeQuickAttackEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, EeveeQuickAttack_DamageBoostEffect
	dbw EFFECTCMDTYPE_AI, EeveeQuickAttack_AIEffect
	db $00

SpearowMirrorMoveEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, SpearowMirrorMove_InitialEffect1
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, SpearowMirrorMove_InitialEffect2
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, SpearowMirrorMove_BeforeDamage
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, SpearowMirrorMove_AfterDamage
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, SpearowMirrorMove_PlayerSelection
	dbw EFFECTCMDTYPE_AI_SELECTION, SpearowMirrorMove_AISelection
	dbw EFFECTCMDTYPE_AI, SpearowMirrorMove_AIEffect
	dbw EFFECTCMDTYPE_AI_SWITCH_DEFENDING_PKMN, SpearowMirrorMove_SwitchDefendingPkmn
	db $00

FearowAgilityEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, FearowAgilityEffect
	db $00

DragoniteStepInEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, StepIn_BenchCheck
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, StepIn_SwitchEffect
	db $00

DragoniteLv45SlamEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, DragoniteLv45Slam_MultiplierEffect
	dbw EFFECTCMDTYPE_AI, DragoniteLv45Slam_AIEffect
	db $00

SnorlaxThickSkinnedEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, ThickSkinnedEffect
	db $00

SnorlaxBodySlamEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, SnorlaxBodySlamEffect
	db $00

FarfetchdLeekSlapEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, FarfetchdLeekSlap_OncePerDuelCheck
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, FarfetchdLeekSlap_NoDamage50PercentEffect
	dbw EFFECTCMDTYPE_DISCARD_ENERGY, FarfetchdLeekSlap_SetUsedThisDuelFlag
	dbw EFFECTCMDTYPE_AI, FarfetchdLeekSlap_AIEffect
	db $00

KangaskhanFetchEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Fetch_CheckDeck
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Fetch_DrawCardEffect
	db $00

KangaskhanCometPunchEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, CometPunch_MultiplierEffect
	dbw EFFECTCMDTYPE_AI, CometPunch_AIEffect
	db $00

TaurosStompEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, TaurosStomp_DamageBoostEffect
	dbw EFFECTCMDTYPE_AI, TaurosStomp_AIEffect
	db $00

TaurosRampageEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Rampage_Confusion50PercentEffect
	dbw EFFECTCMDTYPE_AI, Rampage_AIEffect
	db $00

DoduoFuryAttackEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, DoduoFuryAttack_MultiplierEffect
	dbw EFFECTCMDTYPE_AI, DoduoFuryAttack_AIEffect
	db $00

DodrioRetreatAidEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, RetreatAidEffect
	db $00

DodrioRageEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, DodrioRage_DamageBoostEffect
	dbw EFFECTCMDTYPE_AI, DodrioRage_AIEffect
	db $00

MeowthPayDayEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, PayDayEffect
	db $00

DragonairSlamEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, DragonairSlam_MultiplierEffect
	dbw EFFECTCMDTYPE_AI, DragonairSlam_AIEffect
	db $00

DragonairHyperBeamEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, DragonairHyperBeam_DiscardEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, DragonairHyperBeam_PlayerSelectEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, DragonairHyperBeam_AISelectEffect
	db $00

ClefableMetronomeEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, ClefableMetronome_CheckAttacks
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, ClefableMetronome_UseAttackEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, ClefableMetronome_AISelectEffect
	db $00

ClefableMinimizeEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, ClefableMinimizeEffect
	db $00

PidgeotHurricaneEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, HurricaneEffect
	db $00

PidgeottoWhirlwindEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, PidgeottoWhirlwind_SwitchEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, PidgeottoWhirlwind_SelectEffect
	dbw EFFECTCMDTYPE_AI_SWITCH_DEFENDING_PKMN, PidgeottoWhirlwind_SelectEffect
	db $00

PidgeottoMirrorMoveEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, PidgeottoMirrorMove_InitialEffect1
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, PidgeottoMirrorMove_InitialEffect2
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, PidgeottoMirrorMove_BeforeDamage
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, PidgeottoMirrorMove_AfterDamage
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, PidgeottoMirrorMove_PlayerSelection
	dbw EFFECTCMDTYPE_AI_SELECTION, PidgeottoMirrorMove_AISelection
	dbw EFFECTCMDTYPE_AI, PidgeottoMirrorMove_AIEffect
	dbw EFFECTCMDTYPE_AI_SWITCH_DEFENDING_PKMN, PidgeottoMirrorMove_SwitchDefendingPkmn
	db $00

ClefairySingEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, ClefairySingEffect
	db $00

ClefairyMetronomeEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, ClefairyMetronome_CheckAttacks
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, ClefairyMetronome_UseAttackEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, ClefairyMetronome_AISelectEffect
	db $00

WigglytuffLullabyEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, WigglytuffLullabyEffect
	db $00

WigglytuffDoTheWaveEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, DoTheWaveEffect
	dbw EFFECTCMDTYPE_AI, DoTheWaveEffect
	db $00

JigglypuffLullabyEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, JigglypuffLullabyEffect
	db $00

JigglypuffFirstAidEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, JigglypuffFirstAid_DamageCheck
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, JigglypuffFirstAid_HealEffect
	db $00

JigglypuffDoubleEdgeEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, JigglypuffDoubleEdgeEffect
	db $00

PersianPounceEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, PounceEffect
	db $00

LickitungTongueWrapEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, TongueWrapEffect
	db $00

LickitungSupersonicEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, LickitungSupersonicEffect
	db $00

PidgeyWhirlwindEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, PidgeyWhirlwind_SwitchEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, PidgeyWhirlwind_SelectEffect
	dbw EFFECTCMDTYPE_AI_SWITCH_DEFENDING_PKMN, PidgeyWhirlwind_SelectEffect
	db $00

PorygonLv12Conversion1EffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, PorygonLv12Conversion1_WeaknessCheck
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, PorygonLv12Conversion1_PlayerSelectEffect
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, PorygonLv12Conversion1_ChangeWeaknessEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, PorygonLv12Conversion1_AISelectEffect
	db $00

PorygonLv12Conversion2EffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, PorygonLv12Conversion2_ResistanceCheck
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, PorygonLv12Conversion2_PlayerSelectEffect
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, PorygonLv12Conversion2_ChangeResistanceEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, PorygonLv12Conversion2_AISelectEffect
	db $00

ChanseyScrunchEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, ScrunchEffect
	db $00

ChanseyDoubleEdgeEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, ChanseyDoubleEdgeEffect
	db $00

RaticateSuperFangEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, SuperFangEffect
	dbw EFFECTCMDTYPE_AI, SuperFangEffect
	db $00

; unreferenced
UnreferencedTrainerCardAsPokemonEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, TrainerCardAsPokemon_BenchCheck
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, TrainerCardAsPokemon_DiscardEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, TrainerCardAsPokemon_PlayerSelectSwitch
	db $00

DragoniteHealingWindEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, HealingWind_InitialEffect
	dbw EFFECTCMDTYPE_PKMN_POWER_TRIGGER, HealingWind_PlayAreaHealEffect
	db $00

DragoniteLv41SlamEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, DragoniteLv41Slam_MultiplierEffect
	dbw EFFECTCMDTYPE_AI, DragoniteLv41Slam_AIEffect
	db $00

MeowthCatPunchEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, CatPunchEffect
	db $00

DittoMorphEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Morph_CheckDeck
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Morph_TransformEffect
	db $00

PidgeotSlicingWindEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, SlicingWindEffect
	db $00

PidgeotGaleEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Gale_LoadAnimation
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Gale_SwitchEffect
	db $00

JigglypuffFriendshipSongEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, FriendshipSong_BenchCheck
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, FriendshipSong_AddToBench50PercentEffect
	db $00

JigglypuffExpandEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, JigglypuffExpandEffect
	db $00

CharmanderGatherFireEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, GatherFire_CheckUse
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, GatherFire_TransferEnergyEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, GatherFire_PlayerSelectEffect
	db $00

DarkCharmeleonFireballEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Fireball_CheckEnergy
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Fireball_DiscardEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, Fireball_PlayerSuccess50PercentEffect
	dbw EFFECTCMDTYPE_AI, Fireball_AIEffect
	dbw EFFECTCMDTYPE_AI_SWITCH_DEFENDING_PKMN, Fireball_AISuccess50PercentEffect
	db $00

DarkCharizardContinuousFireballEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, ContinuousFireball_CheckEnergy
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, ContinuousFireball_DiscardEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, ContinuousFireball_PlayerMultiplierEffect
	dbw EFFECTCMDTYPE_AI, ContinuousFireball_AIEffect
	dbw EFFECTCMDTYPE_AI_SWITCH_DEFENDING_PKMN, ContinuousFireball_AIMultiplierEffect
	db $00

PonytaEmberEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, PonytaEmber_CheckEnergy
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, PonytaEmber_PlayerSelectEffect
	dbw EFFECTCMDTYPE_DISCARD_ENERGY, PonytaEmber_DiscardEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, PonytaEmber_AISelectEffect
	db $00

RapidashFlamePillarEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, FlamePillar_BenchDamageEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, FlamePillar_PlayerSelectEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, FlamePillar_AISelectEffect
	db $00

DarkFlareonRageEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, DarkFlareonRage_DamageBoostEffect
	dbw EFFECTCMDTYPE_AI, DarkFlareonRage_AIEffect
	db $00

DarkFlareonPlayingWithFireEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, PlayingWithFire_InitialEffect
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, PlayingWithFire_DiscardAndDamageBonusEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, PlayingWithFire_PlayerSelectEffect
	dbw EFFECTCMDTYPE_AI, PlayingWithFire_AIEffect
	dbw EFFECTCMDTYPE_AI_SWITCH_DEFENDING_PKMN, PlayingWithFire_AISelectEffect
	db $00

DarkWartortleDoubleslapEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, DarkWartortleDoubleslap_MultiplierEffect
	dbw EFFECTCMDTYPE_AI, DarkWartortleDoubleslap_AIEffect
	db $00

DarkWartortleMirrorShellEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, DarkWartortleMirrorShellEffect
	db $00

DarkBlastoiseHydrocannonEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, HydrocannonEffect
	dbw EFFECTCMDTYPE_AI, HydrocannonEffect
	db $00

DarkBlastoiseRocketTackleEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, RocketTackle_NoDamageCheckEffect
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, RocketTackle_NoDamageEffect
	db $00

PsyduckDizzinessEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Dizziness_CheckDeck
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Dizziness_DrawCardEffect
	db $00

PsyduckWaterGunEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, PsyduckWaterGunEffect
	dbw EFFECTCMDTYPE_AI, PsyduckWaterGunEffect
	db $00

DarkGolduckThirdEyeEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, ThirdEye_DeckAndEnergyCheck
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, ThirdEye_PlayerSelectEffect
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, ThirdEye_DrawCardsEffect
	dbw EFFECTCMDTYPE_DISCARD_ENERGY, ThirdEye_DiscardEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, ThirdEye_AISelectEffect
	db $00

MagikarpRapidEvolutionEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, RapidEvolution_CheckEvolutionAndDeck
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, RapidEvolution_EvolveEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, RapidEvolution_PlayerSelectEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, RapidEvolution_AISelectEffect
	db $00

FinalBeamEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, FinalBeamEffect
	db $00

DarkGyaradosIceBeamEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, DarkGyaradosIceBeamEffect
	db $00

DarkVaporeonWhirlpoolEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, DarkVaporeonWhirlpool_DiscardEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, DarkVaporeonWhirlpool_PlayerSelectEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, DarkVaporeonWhirlpool_AISelectEffect
	db $00

EkansPoisonStingEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, EkansPoisonSting_Poison50PercentEffect
	dbw EFFECTCMDTYPE_AI, EkansPoisonSting_AIEffect
	db $00

DarkArbokStareEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Stare_BeforeDamageEffect
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Stare_DamageBenchEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, Stare_PlayerSelectEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, Stare_AISelectEffect
	dbw EFFECTCMDTYPE_AI, Stare_AIEffect
	db $00

DarkArbokPoisonVaporEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, PoisonVapor_PoisonEffect
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, PoisonVapor_DamageBenchEffect
	db $00

DarkGolbatSneakAttackEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, SneakAttack_InitialEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, SneakAttack_PlayerSelectEffect
	dbw EFFECTCMDTYPE_PKMN_POWER_TRIGGER, SneakAttack_DealDamageEffect
	db $00

DarkGolbatFlitterEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Flitter_DamageArenaEffect
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Flitter_DamageBenchEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, Flitter_PlayerSelectEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, Flitter_AISelectEffect
	dbw EFFECTCMDTYPE_AI, Flitter_AIEffect
	db $00

OddishSleepPowderEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, SleepPowderEffect
	db $00

OddishPoisonPowderEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, OddishPoisonPowder_PoisonEffect
	dbw EFFECTCMDTYPE_AI, OddishPoisonPowder_AIEffect
	db $00

DarkGloomPollenStenchEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, PollenStench_CheckUse
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, PollenStench_ConfusionEffect
	db $00

DarkGloomPoisonPowderEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, DarkGloomPoisonPowder_PoisonEffect
	dbw EFFECTCMDTYPE_AI, DarkGloomPoisonPowder_AIEffect
	db $00

DarkVileplumeHayFeverEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, HayFeverEffect
	db $00

DarkVileplumePetalWhirlwindEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, PetalWhirlwindEffect_MultiplierEffect
	dbw EFFECTCMDTYPE_AI, PetalWhirlwindEffect_AIEffect
	db $00

GrimerPoisonGasEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, GrimerPoisonGas_PoisonEffect
	dbw EFFECTCMDTYPE_AI, GrimerPoisonGas_AIEffect
	db $00

GrimerStickyHandsEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, StickyHands_DamageBoostAndParalysisEffect
	dbw EFFECTCMDTYPE_AI, StickyHands_AIEffect
	db $00

DarkMukStickyGooEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, StickyGooEffect
	db $00

DarkMukSludgePunchEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, SludgePunch_PoisonEffect
	dbw EFFECTCMDTYPE_AI, SludgePunch_AIEffect
	db $00

KoffingLv12PoisonGasEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, KoffingLv12PoisonGas_Poison50PercentEffect
	dbw EFFECTCMDTYPE_AI, KoffingLv12PoisonGas_AIEffect
	db $00

DarkWeezingMassExplosionEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, MassExplosion_MultiplierEffect
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, MassExplosion_DamageBenchEffect
	dbw EFFECTCMDTYPE_AI, MassExplosion_MultiplierEffect
	db $00

DarkWeezingStunGasEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, StunGasEffect
	db $00

AbraVanishEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, AbraVanish_CheckBench
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, AbraVanish_ReturnToDeckEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, AbraVanish_PlayerSelectEffect
	db $00

AbraLv14PsyshockEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, AbraLv14PsyshockEffect
	db $00

DarkKadabraMatterExchangeEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, MatterExchange_CheckUseDeckAndHandCards
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, MatterExchange_DiscardAndDrawEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, MatterExchange_PlayerSelectEffect
	db $00

DarkKadabraMindShockEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, DarkKadabraMindShockEffect
	dbw EFFECTCMDTYPE_AI, DarkKadabraMindShockEffect
	db $00

DarkAlakazamTeleportBlastEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, TeleportBlast_BeforeDamageEffect
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, TeleportBlast_SwitchEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, TeleportBlast_PlayerSelectEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, TeleportBlast_AISelectEffect
	db $00

DarkAlakazamMindShockEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, DarkAlakazamMindShockEffect
	dbw EFFECTCMDTYPE_AI, DarkAlakazamMindShockEffect
	db $00

SlowpokeAfternoonNapEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, AfternoonNap_CheckDeck
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, AfternoonNap_AttachEnergyEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, AfternoonNap_PlayerSelectEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, AfternoonNap_AISelectEffect
	db $00

DarkSlowbroReelInEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, ReelIn_InitialEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, ReelIn_PlayerSelectEffect
	dbw EFFECTCMDTYPE_PKMN_POWER_TRIGGER, ReelIn_AddToHandEffect
	db $00

DarkSlowbroFickleAttackEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, FickleAttack_NoDamage50PercentEffect
	dbw EFFECTCMDTYPE_AI, FickleAttack_AIEffect
	db $00

DrowzeeLongDistanceHypnosisEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, LongDistanceHypnosis_CheckUse
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, LongDistanceHypnosis_SleepEffect
	db $00

DrowzeeNightmareEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, DrowzeeNightmareEffect
	db $00

DarkHypnoBenchManipulationEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, BenchManipulation_CheckBench
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, BenchManipulation_MultiplierEffect
	dbw EFFECTCMDTYPE_AI, BenchManipulation_AIEffect
	db $00

DiglettDigUnderEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, DigUnder_ArenaDamageEffect
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, DigUnder_BenchDamageEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, DigUnder_PlayerSelectEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, DigUnder_AISelectEffect
	dbw EFFECTCMDTYPE_AI, DigUnder_AIEffect
	db $00

DarkDugtrioSinkholeEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, SinkholeEffect
	db $00

DarkDugtrioKnockDownEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, KnockDown_DamageBoostEffect
	dbw EFFECTCMDTYPE_AI, KnockDown_AIEffect
	db $00

MankeyMischiefEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Mischief_CheckDeck
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Mischief_ShuffleDeckEffect
	db $00

MankeyQuickAttackEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, MankeyQuickAttack_DamageBoostEffect
	dbw EFFECTCMDTYPE_AI, MankeyQuickAttack_AIEffect
	db $00

DarkPrimeapeFrenzyEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, FrenzyEffect
	db $00

DarkPrimeapeFrenziedAttackEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, FrenziedAttackEffect
	dbw EFFECTCMDTYPE_AI, CalculateFrenziedAttackDamage
	db $00

DarkMachokeDragOffEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, DragOff_CheckBench
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, DragOff_SwitchEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, DragOff_PlayerSelectEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, DragOff_AISelectEffect
	db $00

DarkMachokeKnockBackEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, KnockBack_SwitchEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, KnockBack_CheckBench
	dbw EFFECTCMDTYPE_AI_SWITCH_DEFENDING_PKMN, KnockBack_CheckBench
	db $00

DarkMachampFlingEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, DarkMachampFling_CheckBench
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, DarkMachampFling_ShuffleToDeckEffect
	db $00

RattataTrickeryEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, Trickery_CheckUseAndDeck
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Trickery_SwitchPrizeEffect
	db $00

RattataQuickAttackEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, RattataQuickAttack_DamageBoostEffect
	dbw EFFECTCMDTYPE_AI, RattataQuickAttack_AIEffect
	db $00

DarkRaticateHyperFangEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, HyperFang_NoDamage50PercentEffect
	dbw EFFECTCMDTYPE_AI, HyperFang_AIEffect
	db $00

MeowthCoinHurlEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, CoinHurl_InitialEffect
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, CoinHurl_DamageArenaEffect
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, CoinHurl_DamageBenchEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, CoinHurl_PlayerSelectEffect
	dbw EFFECTCMDTYPE_AI, CoinHurl_AIEffect
	dbw EFFECTCMDTYPE_AI_SWITCH_DEFENDING_PKMN, CoinHurl_AISelectEffect
	db $00

DarkPersianFascinateEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, DarkPersianFascinate_InitialEffect
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, DarkPersianFascinate_LoadAnimation
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, DarkPersianFascinate_SwitchEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, DarkPersianFascinate_PlayerSelectEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, DarkPersianFascinate_AISelectEffect
	db $00

DarkPersianPoisonClawsEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, PersianPoisonClaws_Poison50PercentEffect
	dbw EFFECTCMDTYPE_AI, PersianPoisonClaws_AIEffect
	db $00

EeveeSandAttackEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, EeveeSandAttackEffect
	db $00

PorygonLv20Conversion1EffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, PorygonLv20Conversion1_WeaknessCheck
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, PorygonLv20Conversion1_PlayerSelectEffect
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, PorygonLv20Conversion1_ChangeWeaknessEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, PorygonLv20Conversion1_AISelectEffect
	db $00

PorygonPsybeamEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, PorygonPsybeamEffect
	db $00

DratiniWrapEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, DratiniWrapEffect
	db $00

DarkDragonairEvolutionaryLightEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, EvolutionaryLight_CheckUseAndDeck
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, EvolutionaryLight_AddToHandEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, EvolutionaryLight_PlayerSelectEffect
	db $00

DarkDragonairTailStrikeEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, TailStrike_DamageBoostEffect
	dbw EFFECTCMDTYPE_AI, TailStrike_AIEffect
	db $00

DarkDragoniteSummonMinionsEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, SummonMinions_InitialEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, SummonMinions_PlayerSelectEffect
	dbw EFFECTCMDTYPE_PKMN_POWER_TRIGGER, SummonMinions_AddToHandEffect
	db $00

DarkDragoniteGiantTailEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, GiantTail_NoDamage50PercentEffect
	dbw EFFECTCMDTYPE_AI, GiantTail_AIEffect
	db $00

MagnemiteMagnetismEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, MagnetismEffect
	dbw EFFECTCMDTYPE_AI, MagnetismEffect
	db $00

DarkMagnetonSonicboomEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, DarkMagnetonSonicboomEffect
	dbw EFFECTCMDTYPE_AI, DarkMagnetonSonicboomEffect
	db $00

DarkMagnetonMagneticLinesEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, MagneticLines_TransferEnergyEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, MagneticLines_PlayerSelectEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, MagneticLines_AISelectEffect
	db $00

DarkElectrodeEnergyBombEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, EnergyBomb_CheckEnergy
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, EnergyBomb_PlayerSelectEffect
	dbw EFFECTCMDTYPE_UNK_11, TransferEnergyToPlayAreaPkmn
	db $00

DarkJolteonLightningFlashEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, LightningFlashEffect
	db $00

DarkJolteonThunderAttackEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, ThunderAttack_Paralysis50PercentEffect
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, ThunderAttack_RecoilEffect
	db $00

ImposterOaksRevengeEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, ImposterOaksRevenge_CheckHand
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, ImposterOaksRevenge_PlayerSelectEffect
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, ImposterOaksRevenge_ReturnHandAndDrawEffect
	db $00

SleepEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, SleepCardEffect
	db $00

DiggerEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, DiggerEffect
	db $00

TheBosssWayEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, TheBosssWay_CheckDeck
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, TheBosssWay_AddToHandEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, TheBosssWay_PlayerSelectEffect
	db $00

GoopGasAttackEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, GoopGasAttackEffect
	db $00

RocketsSneakAttackEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, RocketsSneakAttack_ReturnToDeckEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, RocketsSneakAttack_PlayerSelectEffect
	db $00

HereComesTeamRocketEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, HereComesTeamRocketEffect
	db $00

NightlyGarbageRunEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, NightlyGarbageRun_CheckDiscardPile
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, NightlyGarbageRun_ReturnToDeckEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, NightlyGarbageRun_PlayerSelectEffect
	db $00

PotionEnergyEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_PKMN_POWER_TRIGGER, PotionEnergyEffect
	db $00

FullHealEnergyEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_PKMN_POWER_TRIGGER, FullHealEnergyEffect
	db $00

RainbowEnergyEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_PKMN_POWER_TRIGGER, RainbowEnergyEffect
	db $00

ChallengeEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Challenge_DrawOrPlaceInPlayAreaEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, Challenge_PlayerAndOpponentSelectEffect
	db $00

BulbasaurFirstAidEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, BulbasaurFirstAid_DamageCheck
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, BulbasaurFirstAid_HealEffect
	db $00

BulbasaurPoisonSeedEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, PoisonSeed_PoisonEffect
	dbw EFFECTCMDTYPE_AI, PoisonSeed_AIEffect
	db $00

CharmanderGrowlEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, CharmanderGrowlEffect
	db $00

SquirtleWaterPowerEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, SquirtleWaterPowerEffect
	db $00

MetapodGreenShieldEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, MetapodGreenShieldEffect
	db $00

MetapodMysteriousPowerEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, MysteriousPowerEffect
	db $00

WeedlePoisonHornEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, PoisonHorn_PoisonEffect
	dbw EFFECTCMDTYPE_AI, PoisonHorn_AIEffect
	db $00

KakunaPoisonFluidEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, KakunaPoisonFluidEffect
	db $00

PidgeyQuickAttackEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, PideyQuickAttack_DamageBoostEffect
	dbw EFFECTCMDTYPE_AI, PideyQuickAttack_AIEffect
	db $00

RattataTailWhipEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, RattataTailWhipEffect
	db $00

PikachuLv5ThundershockEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, PikachuLv5ThundershockEffect
	db $00

PikachuAgilityEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, PikachuAgilityEffect
	db $00

NidoranFTailWhipEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, NidoranFTailWhipEffect
	db $00

NidoranFPoisonStingEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, NidoranFPoisonSting_Poison50PercentEffect
	dbw EFFECTCMDTYPE_AI, NidoranFPoisonSting_AIEffect
	db $00

NidoranMFocusEnergyEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, NidoranMFocusEnergyEffect
	db $00

NidoranMHornRushEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, HornRush_NoDamage50PercentEffect
	dbw EFFECTCMDTYPE_AI, HornRush_AIEffect
	db $00

ClefairyFollowMeEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, FollowMe_AssertPokemonInBench
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, FollowMe_SwitchDefendingPokemon
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, FollowMe_SelectSwitchPokemon
	dbw EFFECTCMDTYPE_AI_SWITCH_DEFENDING_PKMN, FollowMe_GetBenchPokemonWithLowestHP
	db $00

ClefairyShiningFingersEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, ShiningFingersEffect
	db $00

WigglytuffHelpingHandEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, HelpingHandEffect_CheckUse
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, HelpingHandEffect_HealStatusEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, HelpingHandEffect_PlayerSelectEffect
	db $00

WigglytuffExpandEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, WigglytuffExpandEffect
	db $00

ZubatSuspiciousSoundwaveEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, SuspiciousSoundwaveEffect
	db $00

GolbatLv25LeechLifeEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, GolbatLv25LeechLifeEffect
	db $00

GolbatNosediveEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Nosedive_Recoil50PercentEffect
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Nosedive_RecoilEffect
	db $00

ParasScatterSporesEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, ScatterSpores_CheckDeckAndBench
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, ScatterSpores_PlaceInPlayAreaEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, ScatterSpores_PlayerSelectEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, ScatterSpores_AISelectEffect
	db $00

ParasectToxicSporeEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, ToxicSpore_PoisonEffect
	dbw EFFECTCMDTYPE_AI, ToxicSpore_AIEffect
	db $00

ParasectLeechLifeEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, ParasectLeechLifeEffect
	db $00

PoliwagBubbleEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, PoliwagBubbleEffect
	db $00

PoliwhirlTwiddleEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, TwiddleEffect
	db $00

PoliwagBodySlamEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, PoliwagBodySlamEffect
	db $00

PoliwrathHydroPumpEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, PoliwrathHydroPumpEffect
	dbw EFFECTCMDTYPE_AI, PoliwrathHydroPumpEffect
	db $00

AbraPsychicEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, AbraPsychic_ArenaDamageEffect
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, AbraPsychic_BenchDamageEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, AbraPsychic_PlayerSelectEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, AbraPsychic_AISelectEffect
	dbw EFFECTCMDTYPE_AI, AbraPsychic_AIEffect
	db $00

GeodudeHardenEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, GeodudeHardenEffect
	db $00

RapidashFlameInfernoEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, FlameInferno_DiscardAndDamageBoostEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, FlameInferno_PlayerSelectEffect
	dbw EFFECTCMDTYPE_AI, FlameInferno_AIEffect
	dbw EFFECTCMDTYPE_AI_SWITCH_DEFENDING_PKMN, FlameInferno_AISelectEffect
	db $00

RapidashKickAwayEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, KickAway_SwitchEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, KickAway_CheckBench
	dbw EFFECTCMDTYPE_AI_SWITCH_DEFENDING_PKMN, KickAway_CheckBench
	db $00

DoduoGrowlEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, DoduoGrowlEffect
	db $00

DodrioTriAttackEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, TriAttack_MultiplierEffect
	dbw EFFECTCMDTYPE_AI, TriAttack_AIEffect
	db $00

LickitungLickEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, LickitungLickEffect
	db $00

LickitungStompEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, LickitungStomp_DamageBoostEffect
	dbw EFFECTCMDTYPE_AI, LickitungStomp_AIEffect
	db $00

ChanseySingEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, ChanseySingEffect
	db $00

ChanseyDoubleSlapEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, ChanseyDoubleSlap_MultiplierEffect
	dbw EFFECTCMDTYPE_AI, ChanseyDoubleSlap_AIEffect
	db $00

MrMimeDampeningShieldEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, DampeningShieldEffect
	db $00

MrMimeJugglingEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Juggling_MultiplierEffect
	dbw EFFECTCMDTYPE_AI, Juggling_AIEffect
	db $00

PinsirSlicingThrowEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, SlicingThrow_DamageBoostEffect
	dbw EFFECTCMDTYPE_AI, SlicingThrow_AIEffect
	db $00

EeveeLungeEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, EeveeLunge_NoDamage50PercentEffect
	dbw EFFECTCMDTYPE_AI, EeveeLunge_AIEffect
	db $00

Porygon3DAttackEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Porygon3DAttack_MultiplierEffect
	dbw EFFECTCMDTYPE_AI, Porygon3DAttack_AIEffect
	db $00

PorygonLv18Conversion2EffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, PorygonLv18Conversion2_ResistanceCheck
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, PorygonLv18Conversion2_PlayerSelectEffect
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, PorygonLv18Conversion2_ChangeResistanceEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, PorygonLv18Conversion2_AISelectEffect
	db $00

SnorlaxGuardEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, GuardEffect
	db $00

SnorlaxRollOverEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, RollOverEffect
	db $00

MewtwoPsycrushEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, PsycrushEffect
	dbw EFFECTCMDTYPE_AI, PsycrushEffect
	db $00

TheRocketsTrapEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, TheRocketsTrap_CheckHand
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, TheRocketsTrap_ReturnToDeck50PercentEffect
	db $00

FossilExcavationEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, FossilExcavation_DeckAndDiscardPileCheck
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, FossilExcavation_AddToHandEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, FossilExcavation_PlayerSelectEffect
	dbw EFFECTCMDTYPE_AI_SWITCH_DEFENDING_PKMN, FossilExcavation_AISelectEffect
	db $00

MoonStoneEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, MoonStone_DeckCheck
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, MoonStone_AddToHandEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, MoonStone_PlayerSelectEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, MoonStone_AISelectEffect
	db $00

MaxReviveEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, MaxRevive_DiscardPileAndHandCheck
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, MaxRevive_PlayerSelectEffect
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, MaxRevive_DiscardAndPlaceInBenchEffect
	db $00

MasterBallEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, MasterBall_DeckCheck
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, MasterBall_AddToHandEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, MasterBall_PlayerSelectEffect
	db $00

PokemonRecallEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, PokemonRecall_DiscardPileCheck
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, PokemonRecall_PlayerSelectEffect
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, PokemonRecall_AddToHandEffect
	db $00

BillsComputerEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, BillsComputerEffect
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, BillsComputerEffect
	db $00

ComputerErrorEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, ComputerError_DecksCheck
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, ComputerError_DrawEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, ComputerError_PlayerAndOppSelection
	db $00

SpearowFuryAttackEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, SpearowFuryAttack_MultiplierEffect
	dbw EFFECTCMDTYPE_AI, SpearowFuryAttack_AIEffect
	db $00

FearowQuickAttackEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, FearowQuickAttack_DamageBoostEffect
	dbw EFFECTCMDTYPE_AI, FearowQuickAttack_AIEffect
	db $00

FearowDrillDescentEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, DrillDescent_NoDamage50PercentEffect
	dbw EFFECTCMDTYPE_AI, DrillDescent_AIEffect
	db $00

RaichuShortCircuitEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, ShortCircuit_WaterEnergyCheck
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, ShortCircuit_DamageArenaEffect
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, ShortCircuit_DamageBenchEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, ShortCircuit_PlayerSelectEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, ShortCircuit_AISelectEffect
	db $00

RaichuSparkingKickEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, SparkingKickEffect
	db $00

SandshrewPoisonStingEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, SandshrewPoisonSting_Poison50PercentEffect
	dbw EFFECTCMDTYPE_AI, SandshrewPoisonSting_AIEffect
	db $00

SandshrewSwiftEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, SandshrewSwift_BeforeDamage
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, SandshrewSwift_AfterDamage
	dbw EFFECTCMDTYPE_AI, SetSandshrewSwiftDamage
	db $00

VenomothStirUpTwisterEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, StirUpTwister_SwitchEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, StirUpTwister_PlayerSelectEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, StirUpTwister_AISelectEffect
	db $00

VenomothRainbowPowderEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, RainbowPowderEffect
	db $00

MachopFocusedOneShotEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, FocusedOneShotEffect
	db $00

MachopCorkscrewPunchEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, CorkscrewPunchEffect
	db $00

MachokeSteadyPunchEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, SteadyPunch_DamageBoostEffect
	dbw EFFECTCMDTYPE_AI, SteadyPunch_AIEffect
	db $00

GravelerStoneBarrageEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, GravelerStoneBarrage_MultiplierEffect
	dbw EFFECTCMDTYPE_AI, GravelerStoneBarrage_AIEffect
	db $00

GravelerEarthquakeEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, GravelerEarthquakeEffect
	db $00

MagnemiteMagnetMoveEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, MagnetMove_CheckUse
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, MagnetMove_AddToPlayAreaEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, MagnetMove_PlayerSelectEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, MagnetMove_AISelectEffect
	db $00

MagnemiteSuperconductivityEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Superconductivity_DamageArenaEffect
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Superconductivity_DamageBenchEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, Superconductivity_PlayerSelectEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, Superconductivity_AISelectEffect
	dbw EFFECTCMDTYPE_AI, Superconductivity_AIEffect
	db $00

MagnetonMicrowaveEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Microwave_InitialEffect
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Microwave_ArenaDamageEffect
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Microwave_BenchDamageAndDiscardEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, Microwave_PlayerSelectEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, Microwave_AISelectEffect
	dbw EFFECTCMDTYPE_AI, Microwave_AIEffect
	db $00

SeelGrowlEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, SeelGrowlEffect
	db $00

SeelIceBeamEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, SeelIceBeamEffect
	db $00

DewgongRestEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Rest_SleepEffect
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Rest_HealEffect
	db $00

DewgongAuroraWaveEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, AuroraWaveEffect
	db $00

ShellderWaterSpoutEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, WaterSpoutEffect
	dbw EFFECTCMDTYPE_AI, WaterSpoutEffect
	db $00

OnixBindEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, OnixBindEffect
	db $00

OnixRockSealEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, RockSealEffect
	db $00

KrabbyBubbleEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, KrabbyBubbleEffect
	db $00

VoltorbThundershockEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, VoltorbThundershockEffect
	db $00

VoltorbGroupSparkEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, GroupSparkEffect
	dbw EFFECTCMDTYPE_AI, GroupSparkEffect
	db $00

HitmonleeDoubleKickEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, HitmonleeDoubleKick_MultiplierEffect
	dbw EFFECTCMDTYPE_AI, HitmonleeDoubleKick_AIEffect
	db $00

HitmonleeRollingKickEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, RollingKickEffect
	db $00

HitmonchanMatchPunchEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, MatchPunch_InitialEffect
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, MatchPunch_DamageBenchEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, MatchPunch_PlayerSelectEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, MatchPunch_AISelectEffect
	db $00

JynxIcePunchEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, IcePunchEffect
	db $00

JynxColdBreathEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, ColdBreathEffect
	db $00

LaprasSingEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, LaprasSingEffect
	db $00

OmanytePrehistoricDreamEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, PrehistoricDream_CheckUse
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, PrehistoricDream_IncrementBoostEffect
	db $00

KabutoFossilizeEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, Fossilize_CheckUse
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Fossilize_DevolveEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, Fossilize_PlayerSelectEffect
	db $00

KabutoSharpClawsEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, SharpClaws_DamageBoostEffect
	dbw EFFECTCMDTYPE_AI, SharpClaws_AIEffect
	db $00

AerodactylSupersonicEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, AerodactylSupersonicEffect
	db $00

AerodactylTailspinAttackEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, TailspinAttackEffect
	db $00

ArticunoAuroraVeilEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, AuroraVeilEffect
	db $00

ArticunoIceBeamEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, ArticunoIceBeamEffect
	db $00

ZapdosRagingThunderEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, RagingThunder_InitialEffect
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, RagingThunder_DamageOwnPlayAreaEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, RagingThunder_PlayerSelectEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, RagingThunder_AISelectEffect
	db $00

ZapdosThunderCrashEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, ThunderCrash_DamageBoostOrRecoilEffect
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, ThunderCrash_RecoilEffect
	dbw EFFECTCMDTYPE_AI, ThunderCrash_AIEffect
	db $00

MoltresDryUpEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, DryUp_CheckPlayAreaWaterEnergies
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, DryUp_PlayerSelectPlayAreaPkmnEffect
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, DryUp_DiscardFromArenaEffect
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, DryUp_DiscardFromBenchEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, DryUp_PlayerSelectEnergyEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, DryUp_AISelectPlayAreaPkmnEffect
	dbw EFFECTCMDTYPE_AI_SWITCH_DEFENDING_PKMN, DryUp_AISelectEnergyEffect
	db $00

PidgeottoTwisterEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, TwisterEffect
	db $00

PidgeottoFlyEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, PidgeottoFly_Success50PercentEffect
	dbw EFFECTCMDTYPE_AI, PidgeottoFly_AIEffect
	db $00

ArbokWrapEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, ArbokWrapEffect
	db $00

ArbokDeadlyPoisonEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, DeadlyPoisonEffect
	dbw EFFECTCMDTYPE_AI, AddDeadlyPoisonDamageBoost
	db $00

SandslashSandVeilEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, SandVeilEffect
	db $00

SandslashRollingNeedleEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, RollingNeedle_MultiplierEffect
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, RollingNeedle_RecoilEffect
	dbw EFFECTCMDTYPE_AI, RollingNeedle_AIEffect
	db $00

NidorinaStrengthInNumbersEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, StrengthInNumbersEffect
	dbw EFFECTCMDTYPE_AI, StrengthInNumbersEffect
	db $00

NidorinaFurySwipesEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, NidoranaFurySwipes_MultiplierEffect
	dbw EFFECTCMDTYPE_AI, NidoranaFurySwipes_AIEffect
	db $00

NidorinoSwiftLungeEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, SwiftLunge_NoDamage50PercentEffect
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, SwiftLunge_RecoilEffect
	dbw EFFECTCMDTYPE_AI, SwiftLunge_AIEffect
	db $00

VulpixFoxFireEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, FoxFire_SwitchAndDamageEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, FoxFire_PlayerSelectEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, FoxFire_AISelectEffect
	db $00

VenonatDisableEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Disable_CheckAttacks
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Disable_DisableEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, Disable_PlayerSelectEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, Disable_AISelectEffect
	db $00

VenonatPsybeamEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, VenonatPsybeamEffect
	db $00

GolduckPsychicEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, GolduckPsychicEffect
	dbw EFFECTCMDTYPE_AI, GolduckPsychicEffect
	db $00

GrowlitheErrandRunningEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, ErrandRunning_DeckCheck
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, ErrandRunning_SetAnimationEffect
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, ErrandRunning_AddToHandEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, ErrandRunning_PlayerSelectEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, ErrandRunning_AISelectEffect
	db $00

GrowlitheLv16EmberEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, GrowlitheLv16Ember_CheckEnergy
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, GrowlitheLv16Ember_PlayerSelectEffect
	dbw EFFECTCMDTYPE_DISCARD_ENERGY, GrowlitheLv16Ember_DiscardEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, GrowlitheLv16Ember_AISelectEffect
	db $00

KadabraPsychoPanicEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, KadabraPsychoPanicEffect
	dbw EFFECTCMDTYPE_AI, KadabraPsychoPanicEffect
	db $00

KadabraBlinkEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, BlinkEffect
	db $00

AlakazamPsychoPanicEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, AlakazamPsychoPanicEffect
	dbw EFFECTCMDTYPE_AI, AlakazamPsychoPanicEffect
	db $00

AlakazamTransDamageEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, TransDamage_DamageCheck
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, TransDamage_AnimateAndSetDamageEffect
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, TransDamage_MoveCountersEffect
	dbw EFFECTCMDTYPE_DISCARD_ENERGY, TransDamage_DiscardAllEnergiesEffect
	dbw EFFECTCMDTYPE_AI, TransDamage_AIEffect
	db $00

MachokeWickedJabEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, WickedJabEffect
	db $00

MachokeFocusBlastEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, FocusBlast_InitialEffect
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, FocusBlast_ClearAnimationEffect
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, FocusBlast_DealDamageEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, FocusBlast_PlayerSelectEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, FocusBlast_AISelectEffect
	dbw EFFECTCMDTYPE_AI, FocusBlast_AIEffect
	db $00

MachampSeethingAngerEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, SeethingAnger_DamageBoostEffect
	dbw EFFECTCMDTYPE_AI, SeethingAnger_AIEffect
	db $00

MachampFlingEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, MachampFling_SwitchEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, MachampFling_CheckBench
	dbw EFFECTCMDTYPE_AI_SWITCH_DEFENDING_PKMN, MachampFling_CheckBench
	db $00

BellsproutSwayEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, SwayEffect
	db $00

BellsproutStunSporeEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, BellsproutStunSporeEffect
	db $00

WeepinbellRegenerationEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, RegenerationEffect
	db $00

WeepinbellDissolveEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Dissolve_ArenaEnergyCheck
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Dissolve_DiscardEnergyEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, Dissolve_PlayerSelectEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, Dissolve_AISelectEffect
	db $00

GravelerBoulderSmashEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, BoulderSmash_InitialEffect
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, BoulderSmash_BenchDamageEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, BoulderSmash_PlayerSelectEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, BoulderSmash_AISelectEffect
	db $00

GolemRockBlastEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, RockBlast_EnergiesCheck
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, RockBlast_DiscardEnergiesAndDamageArenaEffect
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, RockBlast_DamageBenchEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, RockBlast_PlayerSelectEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, RockBlast_AISelectEffect
	dbw EFFECTCMDTYPE_AI, RockBlast_AIEffect
	db $00

PonytaFireworksEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Fireworks_InitialEffect
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Fireworks_DiscardEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, Fireworks_PlayerSelectEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, Fireworks_AISelectEffect
	dbw EFFECTCMDTYPE_AI, Fireworks_AIEffect
	db $00

SlowbroBigYawnEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, BigYawn_SleepCheck
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, BigYawn_SleepEffect
	db $00

SlowbroBigSnoreEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, BigSnoreEffect
	db $00

GastlySpookifyEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, SpookifyEffect
	db $00

GastlyFadeToBlackEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, FadeToBlackEffect
	db $00

HaunterPoltergeistEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Poltergeist_10DamagePerTrainerEffect
	dbw EFFECTCMDTYPE_AI, Poltergeist_AIEffect
	db $00

HaunterBadDreamsEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, BadDreamsEffect
	db $00

HaunterEerieLightEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, EerieLightEffect
	db $00

HaunterGrudgeEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, GrudgeEffect
	dbw EFFECTCMDTYPE_AI, GrudgeEffect
	db $00

GengarPowerOfDarknessEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, PowerOfDarkness_InitialEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, PowerOfDarkness_PlayerSelectEffect
	dbw EFFECTCMDTYPE_PKMN_POWER_TRIGGER, PowerOfDarkness_ReturnToHandEffect
	db $00

GengarPsyHorrorEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, PsyHorrorEffect
	db $00

HypnoPuppetMasterEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, PuppetMasterEffect
	db $00

HypnoMindShockEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, HypnoMindShockEffect
	db $00

; unreferenced
EffectCommands_590ab:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_65cf9
	db $00

KinglerSaltWaterEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, SaltWater_DeckCheck
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, SaltWater_ClearAnimationIfFailed
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, SaltWater_AttachToArenaEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, SaltWater_PlayerSelectEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, SaltWater_AIEffect
	db $00

KinglerDoubleEdgedPincersEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, DoubleEdgedPincersEffect
	db $00

CuboneBoneTossEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, BoneToss_InitialEffect
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, BoneToss_ArenaDamageEffect
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, BoneToss_BenchDamageEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, BoneToss_PlayerSelectEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, BoneToss_AISelectEffect
	dbw EFFECTCMDTYPE_AI, BoneToss_AIEffect
	db $00

WeezingPoisonMistEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, PoisonMist_CheckUse
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, PoisonMist_SetAffectedByPoisonMistEffect
	db $00

WeezingGasExplosionEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, GasExplosionEffect
	db $00

RhydonMountainBreakEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, MountainBreak_DeckCheck
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, MountainBreak_DiscardAndAddToHandEffect
	db $00

RhydonOneTwoStrikeEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, OneTwoStrike_DamageBoostEffect
	dbw EFFECTCMDTYPE_AI, OneTwoStrike_AIEffect
	db $00

KangaskhanTailDropEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, TailDrop_NoDamage25PercentEffect
	dbw EFFECTCMDTYPE_AI, TailDrop_AIEffect
	db $00

HorseaHideEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, HideEffect
	db $00

HorseaWaterGunEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, HorseaWaterGunEffect
	dbw EFFECTCMDTYPE_AI, HorseaWaterGunEffect
	db $00

SeadraWaterBombEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, WaterBomb_BenchDamageEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, WaterBomb_PlayerSelectEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, WaterBomb_AISelectEffect
	db $00

StaryuStrangeBeamEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, StrangeBeamEffect
	db $00

ScytherSlashingStrikeEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, SlashingStrike_CheckUse
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, SlashingStrike_CannotUseNextTurnEffect
	db $00

MagmarBurningFireEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, BurningFire_DiscardAndMutliplierEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, BurningFire_PlayerSelectEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, BurningFire_AISelectEffect
	dbw EFFECTCMDTYPE_AI, BurningFire_AIEffect
	db $00

TaurosKickingAndStampingEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, KickingAndStamping_InitialEffect
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, KickingAndStamping_DamageBoostEffect
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, KickingAndStamping_SwitchEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, KickingAndStamping_Switch50PercentEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, KickingAndStamping_Switch50PercentEffect
	dbw EFFECTCMDTYPE_AI, KickingAndStamping_AIEffect
	db $00

OmanyteFossilGuidanceEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, FossilGuidance_CheckUse
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, FossilGuidance_AddToHand50PercentEffect
	db $00

OmastarTentacleGripEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, TentacleGrip_DeckAndEnergyCheck
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, TentacleGrip_FlipCoinsEffect
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, TentacleGrip_DrawEffect
	db $00

OmastarCorrosiveAcidEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, CorrosiveAcid_CheckCanUse
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, CorrosiveAcid_ParalysisOrCannotUseNextTurnEffect
	db $00

MewtwoCompleteRecoveryEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, CompleteRecovery_HPAndStatusCheck
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, CompleteRecovery_ClearStatusAndHealDamageEffect
	db $00

MewtwoPsychoBlastEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, PsychoBlast_InitialEffect
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, PsychoBlast_DiscardEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, PsychoBlast_PlayerSelectEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, PsychoBlast_AISelectEffect
	db $00

DarkPersianAltFascinateEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, DarkPersianAltFascinate_InitialEffect
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, DarkPersianAltFascinate_LoadAnimation
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, DarkPersianAltFascinate_SwitchEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, DarkPersianAltFascinate_PlayerSelectEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, DarkPersianAltFascinate_AISelectEffect
	db $00

PersianAltPoisonClawsEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, PersianAltPoisonClaws_Poison50PercentEffect
	dbw EFFECTCMDTYPE_AI, PersianAltPoisonClaws_AIEffect
	db $00

MeowthClearProfitEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, ClearProfit_DeckCheck
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, ClearProfit_FlipCoinUntilTailsEffect
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, ClearProfit_DrawEffect
	db $00

CoolPorygonTextureMagicEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, TextureMagic_ResistanceCheck
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, TextureMagic_PlayerSelectEffect
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, TextureMagic_ChangeWeaknessAndResistanceEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, TextureMagic_AISelectEffect
	db $00

CoolPorygon3DAttackEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, CoolPorygon3DAttack_MultiplierEffect
	dbw EFFECTCMDTYPE_AI, CoolPorygon3DAttack_AIEffect
	db $00

HungrySnorlaxEatEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Eat_CountersCheck
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Eat_AddFoodCounterEffect
	db $00

HungrySnorlaxRolloutEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, Rollout_PlayerSelectEffect
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Rollout_RemoveCountersAndDamageBoostEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, Rollout_AISelectEffect
	dbw EFFECTCMDTYPE_AI, Rollout_AIEffect
	db $00

MewtwoEnergyControlEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, EnergyControl_EnergyCheck
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, EnergyControl_SwitchEnergyEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, EnergyControl_PlayerSelectEffect
	dbw EFFECTCMDTYPE_AI_SWITCH_DEFENDING_PKMN, EnergyControl_AISelectEffect
	db $00

MewtwoTelekinesisEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Telekinesis_ArenaDamageEffect
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Telekinesis_BenchDamageEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, Telekinesis_PlayerSelectEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, Telekinesis_AISelectEffect
	dbw EFFECTCMDTYPE_AI, Telekinesis_UnaffectedByWREffect
	db $00

PikachuRechargeEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Recharge_DeckCheck
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Recharge_AttachFromDeckEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, Recharge_PlayerSelectEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, Recharge_AISelectEffect
	db $00

PikachuThunderboltEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, PikachuThunderboltEffect
	db $00

FarfetchdAltLeekSlapEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, FarfetchdAltLeekSlap_OncePerDuelCheck
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, FarfetchdAltLeekSlap_NoDamage50PercentEffect
	dbw EFFECTCMDTYPE_DISCARD_ENERGY, FarfetchdAltLeekSlap_SetUsedThisDuelFlag
	; bug, missing AI effect command
	db $00

KangaskhanDizzyPunchEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, DizzyPunch_MultiplierEffect
	dbw EFFECTCMDTYPE_AI, DizzyPunch_AIEffect
	db $00

DiglettTripOverEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, TripOver_DamageBoost50PercentEffect
	dbw EFFECTCMDTYPE_AI, TripOver_AIEffect
	db $00

DugtrioGoUndergroundEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, GoUndergroundEffect
	db $00

DugtrioEarthWaveEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, EarthWave_BenchDamageEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, EarthWave_PlayerSelectEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, EarthWave_AISelectEffect
	db $00

DragoniteSpecialDeliveryEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, SpecialDelivery_UseAndDeckCheck
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, SpecialDelivery_DrawAndPlaceInDeckEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, SpecialDelivery_PlayerSelectEffect
	db $00

DragoniteSupersonicFlightEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, SupersonicFlight_NoDamage50PercentEffect
	dbw EFFECTCMDTYPE_AI, SupersonicFlight_AIEffect
	db $00

MagikarpTrickleEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Trickle_MultiplierEffect
	dbw EFFECTCMDTYPE_AI, Trickle_AIEffect
	db $00

MagikarpDragonRageEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, DragonRage_NoDamage75PercentEffect
	dbw EFFECTCMDTYPE_AI, DragonRage_AIEffect
	db $00

TogepiSnivelEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, TogepiSnivelEffect
	db $00

TogepiMiniMetronomeEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, MiniMetronome_CheckAttacks
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, MiniMetronome_UseAttackEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, MiniMetronome_AISelectEffect
	db $00

MarillWaterGunEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, MarillWaterGunEffect
	dbw EFFECTCMDTYPE_AI, MarillWaterGunEffect
	db $00

MankeyAltPeekEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, MankeyAltPeek_OncePerTurnCheck
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, MankeyAltPeek_SelectEffect
	db $00

IvysaurLeechSeedEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, IvysaurLeechSeedEffect
	db $00

KoffingLv14PoisonGasEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, KoffingLv14PoisonGas_Poison50PercentEffect
	dbw EFFECTCMDTYPE_AI, KoffingLv14PoisonGas_AIEffect
	db $00

KoffingConfusionGasEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, KoffingConfusionGasEffect
	db $00

RaichuQuickAttackEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, RaichuQuickAttack_DamageBoostEffect
	dbw EFFECTCMDTYPE_AI, RaichuQuickAttack_AIEffect
	db $00

RaichuThunderboltEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, RaichuThunderboltEffect
	db $00

ElectabuzzLv30ThundershockEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, ElectabuzzLv30ThundershockEffect
	db $00

JynxDoubleSlapEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, JynxDoubleSlap_MultiplierEffect
	dbw EFFECTCMDTYPE_AI, JynxDoubleSlap_AIEffect
	db $00

MeowthFurySwipesEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, MeowthFurySwipes_MultiplierEffect
	dbw EFFECTCMDTYPE_AI, MeowthFurySwipes_AIEffect
	db $00

GrowlitheLungeEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, GrowlitheLunge_NoDamage50PercentEffect
	dbw EFFECTCMDTYPE_AI, GrowlitheLunge_AIEffect
	db $00

GrowlitheLv12EmberEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, GrowlitheLv12Ember_CheckEnergy
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, GrowlitheLv12Ember_PlayerSelectEffect
	dbw EFFECTCMDTYPE_DISCARD_ENERGY, GrowlitheLv12Ember_DiscardEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, GrowlitheLv12Ember_AISelectEffect
	db $00

ArcanineLv35TakeDownEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, ArcanineLv35TakeDownEffect
	db $00

MagmarLv18SmogEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, MagmarLv18Smog_Poison50PercentEffect
	dbw EFFECTCMDTYPE_AI, MagmarLv18Smog_AIEffect
	db $00

WartortleBubbleEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, WartortleBubbleEffect
	db $00

SuperScoopUpEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, SuperScoopUp_BenchCheck
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, SuperScoopUp_ReturnToHandEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, SuperScoopUp_PlayerSelection
	db $00

BillsTeleporterEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, BillsTeleporterEffect
	db $00

DarkClefableDarknessVeilEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, DarknessVeilEffect
	db $00

DarkClefableDarkSongEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, DarkSong_Sleep50PercentEffect
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, DarkSong_BenchDamageEffect
	db $00

DarkHaunterBotherEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Bother_Success50PercentEffect
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Bother_ReturnTrainerCardToDeckEffect
	db $00

DarkGengarPlayTricksEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, PlayTricks_CheckBenchAndDamage
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, PlayTricks_ShuffleDamageEffect
	db $00

DarkGengarPushAsideEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, PushAside_Success50PercentEffect
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, PushAside_ReturnToDeckEffect
	db $00

DarkStarmieRebirthEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, Rebirth_UseCheck
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Rebirth_DiscardAndAddStaryuEffect
	db $00

DarkStarmieSpinningShowerEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, SpinningShower_Success50PercentEffect
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, SpinningShower_AttackRandomPlayAreaCardsEffect
	db $00

DarkFearowFlyHighEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, FlyHighEffect
	db $00

DarkFearowDrillDiveEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, DrillDive_CheckUse
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, DrillDive_CannotUseNextTurnEffect
	db $00

DarkRaichuSurpriseThunderEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, SurpriseThunderEffect
	db $00

DarkNinetalesPerplexEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, PerplexEffect
	db $00

DarkNinetalesNineTailsEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, NineTails_MulitplierEffect
	dbw EFFECTCMDTYPE_AI, NineTails_AIEffect
	db $00

DarkMarowakBoneHeadbuttEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, BoneHeadbuttEffect
	db $00

GRsMewtwoDarkWaveEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, DarkWaveEffect
	db $00

GRsMewtwoDarkAmplificationEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, DarkAmplification_20Damage50PercentPerDarkPokemonEffect
	dbw EFFECTCMDTYPE_AI, DarkAmplification_AIEffect
	db $00

DarkIvysaurVinePullEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, VinePullEffect
	db $00

DarkIvysaurFuryStrikesEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, FuryStrikesEffect
	db $00

DarkVenusaurHorridPollenEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, HorridPollenEffect
	db $00

LugiaAeroblastEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Aeroblast_DamageBoostEffect
	dbw EFFECTCMDTYPE_AI, Aeroblast_AIEffect
	db $00

RecycleEnergyEffectCommands:
	db $19 ; effect bank
	db $00

DoubleColorlessEnergyEffectCommands:
	db $19 ; effect bank
	db $00

PsychicEnergyEffectCommands:
	db $19 ; effect bank
	db $00

FightingEnergyEffectCommands:
	db $19 ; effect bank
	db $00

LightningEnergyEffectCommands:
	db $19 ; effect bank
	db $00

WaterEnergyEffectCommands:
	db $19 ; effect bank
	db $00

FireEnergyEffectCommands:
	db $19 ; effect bank
	db $00

GrassEnergyEffectCommands:
	db $19 ; effect bank
	db $00

SuperPotionEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, SuperPotion_DamageEnergyCheck
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, SuperPotion_PlayerSelectEffect
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, SuperPotion_HealEffect
	db $00

ImakuniEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, ImakuniEffect
	db $00

EnergyRemovalEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, EnergyRemoval_EnergyCheck
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, EnergyRemoval_PlayerSelection
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, EnergyRemoval_DiscardEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, EnergyRemoval_AISelection
	db $00

EnergyRetrievalEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, EnergyRetrieval_HandEnergyCheck
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, EnergyRetrieval_PlayerHandSelection
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, EnergyRetrieval_DiscardAndAddToHandEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, EnergyRetrieval_PlayerDiscardPileSelection
	db $00

EnergySearchEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, EnergySearch_DeckCheck
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, EnergySearch_AddToHandEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, EnergySearch_PlayerSelection
	db $00

ProfessorOakEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, ProfessorOakEffect
	db $00

PotionEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Potion_DamageCheck
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, Potion_PlayerSelection
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Potion_HealEffect
	db $00

GamblerEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, GamblerEffect
	db $00

ItemFinderEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, ItemFinder_HandDiscardPileCheck
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, ItemFinder_PlayerSelection
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, ItemFinder_DiscardAddToHandEffect
	db $00

DefenderEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, Defender_PlayerSelection
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Defender_AttachDefenderEffect
	db $00

MysteriousFossilEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, MysteriousFossil_BenchCheck
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, MysteriousFossil_PlaceInPlayAreaEffect
	db $00

FullHealEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, FullHeal_StatusCheck
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, FullHeal_ClearStatusEffect
	db $00

ImposterProfessorOakEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, ImposterProfessorOakEffect
	db $00

ComputerSearchEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, ComputerSearch_HandDeckCheck
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, ComputerSearch_PlayerDiscardHandSelection
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, ComputerSearch_DiscardAddToHandEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, ComputerSearch_PlayerDeckSelection
	db $00

ClefairyDollEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, ClefairyDoll_BenchCheck
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, ClefairyDoll_PlaceInPlayAreaEffect
	db $00

MrFujiEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, MrFuji_BenchCheck
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, MrFuji_PlayerSelection
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, MrFuji_ReturnToDeckEffect
	db $00

PlusPowerEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, PlusPowerEffect
	db $00

SwitchEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Switch_BenchCheck
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, Switch_PlayerSelection
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Switch_SwitchEffect
	db $00

PokemonCenterEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, PokemonCenter_DamageCheck
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, PokemonCenter_HealDiscardEnergyEffect
	db $00

PokemonFluteEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, PokemonFlute_BenchCheck
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, PokemonFlute_PlayerSelection
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, PokemonFlute_PlaceInPlayAreaText
	db $00

PokemonBreederEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, PokemonBreeder_HandPlayAreaCheck
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, PokemonBreeder_PlayerSelection
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, PokemonBreeder_EvolveEffect
	db $00

ScoopUpEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, ScoopUp_BenchCheck
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, ScoopUp_PlayerSelection
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, ScoopUp_ReturnToHandEffect
	db $00

PokemonTraderEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, PokemonTrader_HandDeckCheck
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, PokemonTrader_PlayerHandSelection
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, PokemonTrader_TradeCardsEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, PokemonTrader_PlayerDeckSelection
	db $00

PokedexEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Pokedex_DeckCheck
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Pokedex_OrderDeckCardsEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, Pokedex_PlayerSelection
	db $00

BillEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, BillEffect
	db $00

LassEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, LassEffect
	db $00

MaintenanceEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Maintenance_HandCheck
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, Maintenance_PlayerSelection
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Maintenance_ReturnToDeckAndDrawEffect
	db $00

PokeBallEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, PokeBall_DeckCheck
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, PokeBall_AddToHandEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, PokeBall_PlayerSelection
	db $00

RecycleEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Recycle_DiscardPileCheck
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Recycle_AddToHandEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, Recycle_PlayerSelection
	db $00

ReviveEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Revive_BenchCheck
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, Revive_PlayerSelection
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Revive_PlaceInPlayAreaEffect
	db $00

DevolutionSprayEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, DevolutionSpray_PlayAreaEvolutionCheck
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, DevolutionSpray_PlayerSelection
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, DevolutionSpray_DevolutionEffect
	db $00

SuperEnergyRemovalEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, SuperEnergyRemoval_EnergyCheck
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, SuperEnergyRemoval_PlayerSelection
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, SuperEnergyRemoval_DiscardEffect
	db $00

SuperEnergyRetrievalEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, SuperEnergyRetrieval_HandEnergyCheck
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, SuperEnergyRetrieval_PlayerHandSelection
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, SuperEnergyRetrieval_DiscardAndAddToHandEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, SuperEnergyRetrieval_PlayerDiscardPileSelection
	db $00

GustOfWindEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, GustOfWind_BenchCheck
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, GustOfWind_PlayerSelection
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, GustOfWind_SwitchEffect
	db $00
