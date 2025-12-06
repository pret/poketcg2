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
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, SpitPoison_Poison50PercentEffect
	dbw EFFECTCMDTYPE_AI, SpitPoison_AIEffect
	db $00

EkansWrapEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, EkansWrapEffect
	db $00

ArbokTerrorStrikeEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, TerrorStrike_InitialEffect
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, TerrorStrike_SwitchDefendingPokemon
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, TerrorStrike_50PercentSelectSwitchPokemon
	dbw EFFECTCMDTYPE_AI_SWITCH_DEFENDING_PKMN, TerrorStrike_50PercentSelectSwitchPokemon
	db $00

ArbokPoisonFangEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, PoisonFang_PoisonEffect
	dbw EFFECTCMDTYPE_AI, PoisonFang_AIEffect
	db $00

WeepinbellPoisonPowderEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, WeepinbellPoisonPowder_Poison50PercentEffect
	dbw EFFECTCMDTYPE_AI, WeepinbellPoisonPowder_AIEffect
	db $00

VictreebelLureEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, VictreebelLure_AssertPokemonInBench
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, VictreebelLure_SwitchDefendingPokemon
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, VictreebelLure_SelectSwitchPokemon
	dbw EFFECTCMDTYPE_AI_SELECTION, VictreebelLure_GetBenchPokemonWithLowestHP
	db $00

VictreebelAcidEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, AcidEffect
	db $00

PinsirIronGripEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, IronGripEffect
	db $00

CaterpieStringShotEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, StringShotEffect
	db $00

GloomPoisonPowderEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, GloomPoisonPowder_PoisonEffect
	dbw EFFECTCMDTYPE_AI, GloomPoisonPowder_AIEffect
	db $00

GloomFoulOdorEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, FoulOdorEffect
	db $00

KakunaStiffenEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, KakunaStiffenEffect
	db $00

KakunaPoisonPowderEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, KakunaPoisonPowder_PoisonEffect
	dbw EFFECTCMDTYPE_AI, KakunaPoisonPowder_AIEffect
	db $00

GolbatLv29LeechLifeEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, GolbatLv29LeechLifeEffect
	db $00

VenonatStunSporeEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, VenonatStunSpore
	db $00

VenonatLeechLifeEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, VenonatLeechLifeEffect
	db $00

ScytherSwordsDanceEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, SwordsDanceEffect
	db $00

ZubatSupersonicEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, ZubatSupersonicEffect
	db $00

ZubatLeechLifeEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, ZubatLeechLifeEffect
	db $00

BeedrillTwineedleEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Twineedle_MultiplierEffect
	dbw EFFECTCMDTYPE_AI, Twineedle_AIEffect
	db $00

BeedrillPoisonStingEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, BeedrillPoisonSting_Poison50PercentEffect
	dbw EFFECTCMDTYPE_AI, BeedrillPoisonSting_AIEffect
	db $00

ExeggcuteHypnosisEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, ExeggcuteHypnosisEffect
	db $00

ExeggcuteLeechSeedEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, ExeggcuteLeechSeedEffect
	db $00

KoffingFoulGasEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, FoulGas_PoisonOrConfusionEffect
	dbw EFFECTCMDTYPE_AI, FoulGas_AIEffect
	db $00

MetapodStiffenEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, MetapodStiffenEffect
	db $00

MetapodStunSporeEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, MetapodStunSporeEffect
	db $00

OddishStunSporeEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, OddishStunSporeEffect
	db $00

OddishSproutEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Sprout_CheckDeckAndPlayArea
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Sprout_PutInPlayAreaEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, Sprout_PlayerSelectEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, Sprout_AISelectEffect
	db $00

ExeggutorTeleportEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Teleport_CheckBench
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Teleport_SwitchEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, Teleport_PlayerSelectEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, Teleport_AISelectEffect
	db $00

ExeggutorBigEggsplosionEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, BigEggsplosion_MultiplierEffect
	dbw EFFECTCMDTYPE_AI, BigEggsplosion_AIEffect
	db $00

NidokingThrashEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Thrash_ModifierEffect
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Thrash_RecoilEffect
	dbw EFFECTCMDTYPE_AI, Thrash_AIEffect
	db $00

NidokingToxicEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Toxic_DoublePoisonEffect
	dbw EFFECTCMDTYPE_AI, Toxic_AIEffect
	db $00

NidoqueenBoyfriendsEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, BoyfriendsEffect
	db $00

NidoranFFurySwipesEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, NidoranFFurySwipes_MultiplierEffect
	dbw EFFECTCMDTYPE_AI, NidoranFFurySwipes_AIEffect
	db $00

NidoranFCallForFamilyEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, NidoranFCallForFamily_CheckDeckAndPlayArea
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, NidoranFCallForFamily_PutInPlayAreaEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, NidoranFCallForFamily_PlayerSelectEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, NidoranFCallForFamily_AISelectEffect
	db $00

NidoranMHornHazardEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, HornHazard_NoDamage50PercentEffect
	dbw EFFECTCMDTYPE_AI, HornHazard_AIEffect
	db $00

NidorinaSupersonicEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, NidorinaSupersonicEffect
	db $00

NidorinaDoubleKickEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, NidorinaDoubleKick_MultiplierEffect
	dbw EFFECTCMDTYPE_AI, NidorinaDoubleKick_AIEffect
	db $00

NidorinoDoubleKickEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, NidorinoDoubleKick_MultiplierEffect
	dbw EFFECTCMDTYPE_AI, NidorinoDoubleKick_AIEffect
	db $00

ButterfreeWhirlwindEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, ButterfreeWhirlwind_SwitchEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, ButterfreeWhirlwind_CheckBench
	dbw EFFECTCMDTYPE_AI_SWITCH_DEFENDING_PKMN, ButterfreeWhirlwind_CheckBench
	db $00

ButterfreeMegaDrainEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, ButterfreeMegaDrainEffect
	db $00

ParasSporeEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, ParasSporeEffect
	db $00

ParasectSporeEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, ParasectSporeEffect
	db $00

WeedlePoisonStingEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, WeedlePoisonSting_Poison50PercentEffect
	dbw EFFECTCMDTYPE_AI, WeedlePoisonSting_AIEffect
	db $00

IvysaurPoisonPowderEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, IvysaurPoisonPowder_PoisonEffect
	dbw EFFECTCMDTYPE_AI, IvysaurPoisonPowder_AIEffect
	db $00

BulbasaurLeechSeedEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, BulbasaurLeechSeedEffect
	db $00

VenusaurEnergyTransEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, VenusaurEnergyTrans_CheckPlayArea
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, VenusaurEnergyTrans_TransferEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, VenusaurEnergyTrans_PrintProcedure
	dbw EFFECTCMDTYPE_UNK_11, VenusaurEnergyTrans_AIEffect
	db $00

VenusaurAltEnergyTransEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, VenusaurAltEnergyTrans_CheckPlayArea
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, VenusaurAltEnergyTrans_TransferEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, VenusaurAltEnergyTrans_PrintProcedure
	dbw EFFECTCMDTYPE_UNK_11, VenusaurAltEnergyTrans_AIEffect
	db $00

GrimerNastyGooEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, NastyGooEffect
	db $00

GrimerMinimizeEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, GrimerMinimizeEffect
	db $00

MukToxicGasEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, ToxicGasEffect
	db $00

MukSludgeEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Sludge_Poison50PercentEffect
	dbw EFFECTCMDTYPE_AI, Sludge_AIEffect
	db $00

BellsproutCallForFamilyEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, BellsproutCallForFamily_CheckDeckAndPlayArea
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, BellsproutCallForFamily_PutInPlayAreaEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, BellsproutCallForFamily_PlayerSelectEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, BellsproutCallForFamily_AISelectEffect
	db $00

WeezingSmogEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, WeezingSmog_Poison50PercentEffect
	dbw EFFECTCMDTYPE_AI, WeezingSmog_AIEffect
	db $00

WeezingSelfdestructEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, WeezingSelfdestructEffect
	db $00

VenomothShiftEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, Shift_OncePerTurnCheck
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Shift_ChangeColorEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, Shift_PlayerSelectEffect
	db $00

VenomothVenomPowderEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, VenomPowder_PoisonConfusion50PercentEffect
	dbw EFFECTCMDTYPE_AI, VenomPowder_AIEffect
	db $00

TangelaBindEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, BindEffect
	db $00

TangelaPoisonPowderEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, TangelaPoisonPowder_PoisonEffect
	dbw EFFECTCMDTYPE_AI, TangelaPoisonPowder_AIEffect
	db $00

VileplumeHealEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, Heal_OncePerTurnCheck
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Heal_RemoveDamageEffect
	db $00

VileplumePetalDanceEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, PetalDance_MultiplierEffect
	dbw EFFECTCMDTYPE_AI, PetalDance_AIEffect
	db $00

TangelaStunSporeEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, TangelaStunSporeEffect
	db $00

TangelaPoisonWhipEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, PoisonWhip_PoisonEffect
	dbw EFFECTCMDTYPE_AI, PoisonWhip_AIEffect
	db $00

VenusaurSolarPowerEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, SolarPower_CheckUse
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, SolarPower_RemoveStatusEffect
	db $00

VenusaurMegaDrainEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, VenusaurMegaDrainEffect
	db $00

OmastarWaterGunEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, OmastarWaterGunEffect
	dbw EFFECTCMDTYPE_AI, OmastarWaterGunEffect
	db $00

OmastarSpikeCannonEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, OmastarSpikeCannon_MultiplierEffect
	dbw EFFECTCMDTYPE_AI, OmastarSpikeCannon_AIEffect
	db $00

OmanyteClairvoyanceEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, Clairvoyance_CheckUse
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Clairvoyance_CheckHandEffect
	db $00

OmanyteWaterGunEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, OmanyteWaterGunEffect
	dbw EFFECTCMDTYPE_AI, OmanyteWaterGunEffect
	db $00

WartortleWithdrawEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, WartortleWithdrawEffect
	db $00

BlastoiseRainDanceEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, BlastoiseRainDanceEffect
	db $00

BlastoiseHydroPumpEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, BlastoiseHydroPumpEffect
	dbw EFFECTCMDTYPE_AI, BlastoiseHydroPumpEffect
	db $00

BlastoiseAltRainDanceEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, BlastoiseAltRainDanceEffect
	db $00

BlastoiseAltHydroPumpEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, BlastoiseAltHydroPumpEffect
	dbw EFFECTCMDTYPE_AI, BlastoiseAltHydroPumpEffect
	db $00

GyaradosBubblebeamEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, BubblebeamEffect
	db $00

KinglerFlailEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, KinglerFlail_HPCheck
	dbw EFFECTCMDTYPE_AI, KinglerFlail_AIEffect
	db $00

KrabbyCallForFamilyEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, KrabbyCallForFamily_CheckDeckAndPlayArea
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, KrabbyCallForFamily_PutInPlayAreaEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, KrabbyCallForFamily_PlayerSelectEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, KrabbyCallForFamily_AISelectEffect
	db $00

MagikarpFlailEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, MagikarpFlail_HPCheck
	dbw EFFECTCMDTYPE_AI, MagikarpFlail_AIEffect
	db $00

PsyduckHeadacheEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, HeadacheEffect
	db $00

PsyduckFurySwipesEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, PsyduckFurySwipes_MultiplierEffect
	dbw EFFECTCMDTYPE_AI, PsyduckFurySwipes_AIEffect
	db $00

GolduckPsyshockEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, GolduckPsyshockEffect
	db $00

GolduckHyperBeamEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, GolduckHyperBeam_DiscardEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, GolduckHyperBeam_PlayerSelectEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, GolduckHyperBeam_AISelectEffect
	db $00

SeadraWaterGunEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, SeadraWaterGunEffect
	dbw EFFECTCMDTYPE_AI, SeadraWaterGunEffect
	db $00

SeadraAgilityEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, SeadraAgilityEffect
	db $00

ShellderSupersonicEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, ShellderSupersonicEffect
	db $00

ShellderHideInShellEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, HideInShellEffect
	db $00

VaporeonQuickAttackEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, VaporeonQuickAttack_DamageBoostEffect
	dbw EFFECTCMDTYPE_AI, VaporeonQuickAttack_AIEffect
	db $00

VaporeonWaterGunEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, VaporeonWaterGunEffect
	dbw EFFECTCMDTYPE_AI, VaporeonWaterGunEffect
	db $00

DewgongIceBeamEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, DewgongIceBeamEffect
	db $00

StarmieRecoverEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, StarmieRecover_CheckEnergyHP
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, StarmieRecover_PlayerSelectEffect
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, StarmieRecover_HealEffect
	dbw EFFECTCMDTYPE_DISCARD_ENERGY, StarmieRecover_DiscardEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, StarmieRecover_AISelectEffect
	db $00

StarmieStarFreezeEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, StarFreezeEffect
	db $00

SquirtleBubbleEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, SquirtleBubbleEffect
	db $00

SquirtleWithdrawEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, SquirtleWithdrawEffect
	db $00

HorseaSmokescreenEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, HorseaSmokescreenEffect
	db $00

TentacruelSupersonicEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, TentacruelSupersonicEffect
	db $00

TentacruelJellyfishStingEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, JellyfishSting_PoisonEffect
	dbw EFFECTCMDTYPE_AI, JellyfishSting_AIEffect
	db $00

PoliwhirlAmnesiaEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, PoliwhirlAmnesia_CheckAttacks
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, PoliwhirlAmnesia_PlayerSelectEffect
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, PoliwhirlAmnesia_DisableEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, PoliwhirlAmnesia_AISelectEffect
	db $00

PoliwhirlDoubleslapEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, PoliwhirlDoubleslap_MultiplierEffect
	dbw EFFECTCMDTYPE_AI, PoliwhirlDoubleslap_AIEffect
	db $00

PoliwrathWaterGunEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, PoliwrathWaterGunEffect
	dbw EFFECTCMDTYPE_AI, PoliwrathWaterGunEffect
	db $00

PoliwrathWhirlpoolEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, PoliwrathWhirlpool_DiscardEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, PoliwrathWhirlpool_PlayerSelectEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, PoliwrathWhirlpool_AISelectEffect
	db $00

PoliwagWaterGunEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, PoliwagWaterGunEffect
	dbw EFFECTCMDTYPE_AI, PoliwagWaterGunEffect
	db $00

CloysterClampEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Clamp_Successful50PercentEffect
	dbw EFFECTCMDTYPE_AI, Clamp_AIEffect
	db $00

CloysterSpikeCannonEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, CloysterSpikeCannon_MultiplierEffect
	dbw EFFECTCMDTYPE_AI, CloysterSpikeCannon_AIEffect
	db $00

ArticunoFreezeDryEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, FreezeDryEffect
	db $00

ArticunoBlizzardEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Blizzard_BenchDamage50PercentEffect
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Blizzard_BenchDamageEffect
	db $00

TentacoolCowardiceEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, Cowardice_CheckUseAndBench
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Cowardice_ReturnToHandEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, Cowardice_PlayerSelectEffect
	db $00

LaprasWaterGunEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, LaprasWaterGunEffect
	dbw EFFECTCMDTYPE_AI, LaprasWaterGunEffect
	db $00

LaprasConfuseRayEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, LaprasConfuseRayEffect
	db $00

ArticunoQuickfreezeEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Quickfreeze_InitialEffect
	dbw EFFECTCMDTYPE_PKMN_POWER_TRIGGER, Quickfreeze_Paralysis50PercentEffect
	db $00

ArticunoIceBreathEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, IceBreath_ZeroDamage
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, IceBreath_RandomPokemonDamageEffect
	db $00

VaporeonFocusEnergyEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, FocusEnergyEffect
	db $00

ArcanineFlamethrowerEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, ArcanineFlamethrower_CheckEnergy
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, ArcanineFlamethrower_PlayerSelectEffect
	dbw EFFECTCMDTYPE_DISCARD_ENERGY, ArcanineFlamethrower_DiscardEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, ArcanineFlamethrower_AISelectEffect
	db $00

ArcanineLv45TakeDownEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, ArcanineLv45TakeDownEffect
	db $00

ArcanineQuickAttackEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, ArcanineQuickAttack_DamageBoostEffect
	dbw EFFECTCMDTYPE_AI, ArcanineQuickAttack_AIEffect
	db $00

ArcanineFlamesOfRageEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, FlamesOfRage_CheckEnergy
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, FlamesOfRage_PlayerSelectEffect
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, FlamesOfRage_DamageBoostEffect
	dbw EFFECTCMDTYPE_DISCARD_ENERGY, FlamesOfRage_DiscardEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, FlamesOfRage_AISelectEffect
	dbw EFFECTCMDTYPE_AI, FlamesOfRage_AIEffect
	db $00

RapidashStompEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, RapidashStomp_DamageBoostEffect
	dbw EFFECTCMDTYPE_AI, RapidashStomp_AIEffect
	db $00

RapidashAgilityEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, RapidashAgilityEffect
	db $00

NinetalesLureEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, NinetalesLure_CheckBench
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, NinetalesLure_SwitchEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, NinetalesLure_PlayerSelectEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, NinetalesLure_AISelectEffect
	db $00

NinetalesFireBlastEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, FireBlast_CheckEnergy
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, FireBlast_PlayerSelectEffect
	dbw EFFECTCMDTYPE_DISCARD_ENERGY, FireBlast_DiscardEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, FireBlast_AISelectEffect
	db $00

CharmanderEmberEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, CharmanderEmber_CheckEnergy
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, CharmanderEmber_PlayerSelectEffect
	dbw EFFECTCMDTYPE_DISCARD_ENERGY, CharmanderEmber_DiscardEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, CharmanderEmber_AISelectEffect
	db $00

MoltresWildfireEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Wildfire_CheckDeckAndEnergy
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, Wildfire_PlayerSelectEffect
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Wildfire_DiscardDeckEffect
	dbw EFFECTCMDTYPE_DISCARD_ENERGY, Wildfire_DiscardEnergyEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, Wildfire_AISelectEffect
	db $00

MoltresLv35DiveBombEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, MoltresLv35DiveBomb_Success50PercentEffect
	dbw EFFECTCMDTYPE_AI, MoltresLv35DiveBomb_AIEffect
	db $00

FlareonQuickAttackEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, FlareonQuickAttack_DamageBoostEffect
	dbw EFFECTCMDTYPE_AI, FlareonQuickAttack_AIEffect
	db $00

FlareonFlamethrowerEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, FlareonFlamethrower_CheckEnergy
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, FlareonFlamethrower_PlayerSelectEffect
	dbw EFFECTCMDTYPE_DISCARD_ENERGY, FlareonFlamethrower_DiscardEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, FlareonFlamethrower_AISelectEffect
	db $00

MagmarFlamethrowerEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, MagmarFlamethrower_CheckEnergy
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, MagmarFlamethrower_PlayerSelectEffect
	dbw EFFECTCMDTYPE_DISCARD_ENERGY, MagmarFlamethrower_DiscardEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, MagmarFlamethrower_AISelectEffect
	db $00

MagmarSmokescreenEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, MagmarSmokescreenEffect
	db $00

MagmarLv31SmogEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, MagmarLv31Smog_Poison50PercentEffect
	dbw EFFECTCMDTYPE_AI, MagmarLv31Smog_AIEffect
	db $00

CharmeleonFlamethrowerEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, CharmeleonFlamethrower_CheckEnergy
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, CharmeleonFlamethrower_PlayerSelectEffect
	dbw EFFECTCMDTYPE_DISCARD_ENERGY, CharmeleonFlamethrower_DiscardEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, CharmeleonFlamethrower_AISelectEffect
	db $00

CharizardEnergyBurnEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, CharizardEnergyBurnEffect
	db $00

CharizardFireSpinEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, CharizardFireSpin_CheckEnergy
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, CharizardFireSpin_PlayerSelectEffect
	dbw EFFECTCMDTYPE_DISCARD_ENERGY, CharizardFireSpin_DiscardEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, CharizardFireSpin_AISelectEffect
	db $00

CharizardAltEnergyBurnEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, CharizardAltEnergyBurnEffect
	db $00

CharizardAltFireSpinEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, CharizardAltFireSpin_CheckEnergy
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, CharizardAltFireSpin_PlayerSelectEffect
	dbw EFFECTCMDTYPE_DISCARD_ENERGY, CharizardAltFireSpin_DiscardEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, CharizardAltFireSpin_AISelectEffect
	db $00

VulpixConfuseRayEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, VulpixConfuseRayEffect
	db $00

FlareonRageEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, FlareonRage_DamageBoostEffect
	dbw EFFECTCMDTYPE_AI, FlareonRage_AIEffect
	db $00

NinetalesMixUpEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, MixUp_CheckHandAndDeck
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, MixUp_ShuffleCardsEffect
	db $00

NinetalesDancingEmbersEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, DancingEmbers_MultiplierEffect
	dbw EFFECTCMDTYPE_AI, DancingEmbers_AIEffect
	db $00

MoltresFiregiverEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Firegiver_InitialEffect
	dbw EFFECTCMDTYPE_PKMN_POWER_TRIGGER, Firegiver_AddToHandEffect
	db $00

MoltresLv37DiveBombEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, MoltresLv37DiveBomb_Success50PercentEffect
	dbw EFFECTCMDTYPE_AI, MoltresLv37DiveBomb_AIEffect
	db $00

AbraLv10PsyshockEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, AbraLv10PsyshockEffect
	db $00

GengarCurseEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, Curse_CheckDamageAndBench
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Curse_TransferDamageEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, Curse_PlayerSelectEffect
	db $00

GengarDarkMindEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, GengarDarkMind_DamageBenchEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, GengarDarkMind_PlayerSelectEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, GengarDarkMind_AISelectEffect
	db $00

GastlySleepingGasEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, SleepingGasEffect
	db $00

GastlyDestinyBondEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, DestinyBond_CheckEnergy
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, DestinyBond_PlayerSelectEffect
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, DestinyBond_DestinyBondEffect
	dbw EFFECTCMDTYPE_DISCARD_ENERGY, DestinyBond_DiscardEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, DestinyBond_AISelectEffect
	db $00

GastlyLickEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, LickEffect
	db $00

GastlyEnergyConversionEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, EnergyConversion_CheckEnergy
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, EnergyConversion_AddToHandEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, EnergyConversion_PlayerSelectEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, EnergyConversion_AISelectEffect
	db $00

HaunterHypnosisEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, HaunterHypnosisEffect
	db $00

HaunterDreamEaterEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, DreamEaterEffect
	db $00

HaunterTransparencyEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, TransparencyEffect
	db $00

HaunterNightmareEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, HaunterNightmareEffect
	db $00

HypnoProphecyEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Prophecy_CheckDeck
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Prophecy_ReorderDeckEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, Prophecy_PlayerSelectEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, Prophecy_AISelectEffect
	db $00

HypnoDarkMindEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, HypnoDarkMind_DamageBenchEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, HypnoDarkMind_PlayerSelectEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, HypnoDarkMind_AISelectEffect
	db $00

DrowzeeConfuseRayEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, DrowzeeConfuseRayEffect
	db $00

MrMimeInvisibleWallEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, InvisibleWallEffect
	db $00

MrMimeMeditateEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, MrMimeMeditateEffect
	dbw EFFECTCMDTYPE_AI, MrMimeMeditateEffect
	db $00

AlakazamDamageSwapEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, DamageSwap_CheckDamage
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, DamageSwap_SelectAndSwapEffect
	dbw EFFECTCMDTYPE_UNK_11, DamageSwap_SwapEffect
	db $00

AlakazamConfuseRayEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, AlakazamConfuseRayEffect
	db $00

MewPsywaveEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Psywave_DamageMultiplierEffect
	dbw EFFECTCMDTYPE_AI, Psywave_AIEffect
	db $00

MewDevolutionBeamEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, DevolutionBeam_CheckPlayArea
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, DevolutionBeam_PlayerSelectEffect
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, DevolutionBeam_LoadAnimation
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, DevolutionBeam_DevolveEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, DevolutionBeam_AISelectEffect
	db $00

MewNeutralizingShieldEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, NeutralizingShieldEffect
	db $00

MewPsyshockEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, MewPsyshockEffect
	db $00

MewtwoPsychicEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Psychic_DamageBoostEffect
	dbw EFFECTCMDTYPE_AI, Psychic_AIEffect
	db $00

MewtwoBarrierEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Barrier_CheckEnergy
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, Barrier_PlayerSelectEffect
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Barrier_BarrierEffect
	dbw EFFECTCMDTYPE_DISCARD_ENERGY, Barrier_DiscardEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, Barrier_AISelectEffect
	db $00

MewtwoAltEnergyAbsorptionEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, MewtwoAltEnergyAbsorption_CheckDiscardPile
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, MewtwoAltEnergyAbsorption_AddToHandEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, MewtwoAltEnergyAbsorption_PlayerSelectEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, MewtwoAltEnergyAbsorption_AISelectEffect
	db $00

MewtwoEnergyAbsorptionEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, MewtwoEnergyAbsorption_CheckDiscardPile
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, MewtwoEnergyAbsorption_AddToHandEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, MewtwoEnergyAbsorption_PlayerSelectEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, MewtwoEnergyAbsorption_AISelectEffect
	db $00

SlowbroStrangeBehaviorEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, StrangeBehavior_CheckDamage
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, StrangeBehavior_SelectAndSwapEffect
	dbw EFFECTCMDTYPE_UNK_11, StrangeBehavior_SwapEffect
	db $00

SlowbroPsyshockEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, SlowbroPsyshockEffect
	db $00

SlowpokeSpacingOutEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, SpacingOut_CheckDamage
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, SpacingOut_Success50PercentEffect
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, SpacingOut_HealEffect
	db $00

SlowpokeScavengeEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Scavenge_CheckDiscardPile
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, Scavenge_PlayerSelectEnergyEffect
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Scavenge_AddToHandEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, Scavenge_PlayerSelectTrainerEffect
	dbw EFFECTCMDTYPE_DISCARD_ENERGY, Scavenge_DiscardEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, Scavenge_AISelectEffect
	db $00

SlowpokeAmnesiaEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, SlowpokeAmnesia_CheckAttacks
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, SlowpokeAmnesia_PlayerSelectEffect
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, SlowpokeAmnesia_DisableEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, SlowpokeAmnesia_AISelectEffect
	db $00

KadabraRecoverEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, KadabraRecover_CheckEnergyHP
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, KadabraRecover_PlayerSelectEffect
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, KadabraRecover_HealEffect
	dbw EFFECTCMDTYPE_DISCARD_ENERGY, KadabraRecover_DiscardEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, KadabraRecover_AISelectEffect
	db $00

JynxDoubleslapEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, JynxDoubleslap_MultiplierEffect
	dbw EFFECTCMDTYPE_AI, JynxDoubleslap_AIEffect
	db $00

JynxMeditateEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, JynxMeditateEffect
	dbw EFFECTCMDTYPE_AI, JynxMeditateEffect
	db $00

MewMysteryAttackEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, MysteryAttack_RandomEffect
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, MysteryAttack_RecoverEffect
	dbw EFFECTCMDTYPE_AI, MysteryAttack_AIEffect
	db $00

GeodudeStoneBarrageEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, GeodudeStoneBarrage_MultiplierEffect
	dbw EFFECTCMDTYPE_AI, GeodudeStoneBarrage_AIEffect
	db $00

OnixHardenEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, OnixHardenEffect
	db $00

PrimeapeFurySwipesEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, PrimeapeFurySwipes_MultiplierEffect
	dbw EFFECTCMDTYPE_AI, PrimeapeFurySwipes_AIEffect
	db $00

PrimeapeTantrumEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, TantrumEffect
	db $00

MachampStrikesBackEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, StrikesBackEffect
	db $00

KabutoKabutoArmorEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, KabutoArmorEffect
	db $00

KabutopsAbsorbEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, AbsorbEffect
	db $00

CuboneSnivelEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, CuboneSnivelEffect
	db $00

CuboneRageEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, CuboneRage_DamageBoostEffect
	dbw EFFECTCMDTYPE_AI, CuboneRage_AIEffect
	db $00

MarowakBonemerangEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Bonemerang_MultiplierEffect
	dbw EFFECTCMDTYPE_AI, Bonemerang_AIEffect
	db $00

MarowakCallforFriendEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, MarowakCallForFamily_CheckDeckAndPlayArea
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, MarowakCallForFamily_PutInPlayAreaEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, MarowakCallForFamily_PlayerSelectEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, MarowakCallForFamily_AISelectEffect
	db $00

MachokeKarateChopEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, KarateChop_DamageSubtractionEffect
	dbw EFFECTCMDTYPE_AI, KarateChop_AIEffect
	db $00

MachokeSubmissionEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, SubmissionEffect
	db $00

GolemSelfdestructEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, GolemSelfdestructEffect
	db $00

GravelerHardenEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, GravelerHardenEffect
	db $00

RhydonRamEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Ram_RecoilSwitchEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, Ram_SelectSwitchEffect
	dbw EFFECTCMDTYPE_AI_SWITCH_DEFENDING_PKMN, Ram_SelectSwitchEffect
	db $00

RhyhornLeerEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, LeerEffect
	db $00

HitmonleeStretchKickEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, StretchKick_CheckBench
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, StretchKick_BenchDamageEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, StretchKick_PlayerSelectEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, StretchKick_AISelectEffect
	db $00

SandshrewSandAttackEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, SandshrewSandAttackEffect
	db $00

SandslashFurySwipesEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, SandslashFurySwipes_MultiplierEffect
	dbw EFFECTCMDTYPE_AI, SandslashFurySwipes_AIEffect
	db $00

DugtrioEarthquakeEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, DugtrioEarthquakeEffect
	db $00

AerodactylPrehistoricPowerEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, PrehistoricPowerEffect
	db $00

MankeyPeekEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, MankeyPeek_OncePerTurnCheck
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, MankeyPeek_SelectEffect
	db $00

MarowakBoneAttackEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, BoneAttackEffect
	db $00

MarowakWailEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Wail_BenchAndDeckCheck
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Wail_FillBenchEffect
	db $00

ElectabuzzThundershockEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, ElectabuzzThundershockEffect
	db $00

ElectabuzzThunderpunchEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Thunderpunch_ModifierEffect
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Thunderpunch_RecoilEffect
	dbw EFFECTCMDTYPE_AI, Thunderpunch_AIEffect
	db $00

ElectabuzzLightScreenEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, LightScreenEffect
	db $00

ElectabuzzQuickAttackEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, ElectabuzzQuickAttack_DamageBoostEffect
	dbw EFFECTCMDTYPE_AI, ElectabuzzQuickAttack_AIEffect
	db $00

MagnemiteThunderWaveEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, MagnemiteThunderWaveEffect
	db $00

MagnemiteSelfdestructEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, MagnemiteSelfdestructEffect
	db $00

ZapdosThunderEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, ZapdosThunder_Recoil50PercentEffect
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, ZapdosThunder_RecoilEffect
	db $00

ZapdosThunderboltEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, ZapdosThunderboltEffect
	db $00

ZapdosThunderstormEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, ThunderstormEffect
	db $00

JolteonQuickAttackEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, JolteonQuickAttack_DamageBoostEffect
	dbw EFFECTCMDTYPE_AI, JolteonQuickAttack_AIEffect
	db $00

JolteonPinMissileEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, PinMissile_MultiplierEffect
	dbw EFFECTCMDTYPE_AI, PinMissile_AIEffect
	db $00

FlyingPikachuThundershockEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, FlyingPikachuThundershockEffect
	db $00

FlyingPikachuFlyEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, FlyingPikachuFly_Success50PercentEffect
	dbw EFFECTCMDTYPE_AI, FlyingPikachuFly_AIEffect
	db $00

FlyingPikachuAltThundershockEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, FlyingPikachuAltThundershockEffect
	db $00

FlyingPikachuAltFlyEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, FlyingPikachuAltFly_Success50PercentEffect
	dbw EFFECTCMDTYPE_AI, FlyingPikachuAltFly_AIEffect
	db $00

PikachuThunderJoltEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, ThunderJolt_Recoil50PercentEffect
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, ThunderJolt_RecoilEffect
	db $00

PikachuSparkEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Spark_BenchDamageEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, Spark_PlayerSelectEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, Spark_AISelectEffect
	db $00

PikachuLv16GrowlEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, PikachuLv16GrowlEffect
	db $00

PikachuLv16ThundershockEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, PikachuLv16ThundershockEffect
	db $00

PikachuAltLv16GrowlEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, PikachuAltLv16GrowlEffect
	db $00

PikachuAltLv16ThundershockEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, PikachuAltLv16ThundershockEffect
	db $00

ElectrodeChainLightningEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, ChainLightningEffect
	db $00

RaichuAgilityEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, RaichuAgilityEffect
	db $00

RaichuThunderEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, RaichuThunder_Recoil50PercentEffect
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, RaichuThunder_RecoilEffect
	db $00

RaichuGigashockEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Gigashock_BenchDamageEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, Gigashock_PlayerSelectEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, Gigashock_AISelectEffect
	db $00

MagnetonThunderWaveEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, MagnetonThunderWaveEffect
	db $00

MagnetonLv28SelfdestructEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, MagnetonLv28SelfdestructEffect
	db $00

MagnetonSonicboomEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, MagnetonSonicboom_UnaffectedByColorEffect
	dbw EFFECTCMDTYPE_AI, MagnetonSonicboom_UnaffectedByColorEffect
	db $00

MagnetonLv35SelfdestructEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, MagnetonLv35SelfdestructEffect
	db $00

ZapdosPealOfThunderEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, PealOfThunder_InitialEffect
	dbw EFFECTCMDTYPE_PKMN_POWER_TRIGGER, PealOfThunder_RandomlyDamageEffect
	db $00

ZapdosBigThunderEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, BigThunderEffect
	db $00

MagnemiteMagneticStormEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, MagneticStormEffect
	db $00

ElectrodeSonicboomEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, ElectrodeSonicboom_UnaffectedByColorEffect
	dbw EFFECTCMDTYPE_AI, ElectrodeSonicboom_UnaffectedByColorEffect
	db $00

ElectrodeEnergySpikeEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, EnergySpike_DeckCheck
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, EnergySpike_AttachEnergyEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, EnergySpike_PlayerSelectEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, EnergySpike_AISelectEffect
	db $00

JolteonDoubleKickEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, JolteonDoubleKick_MultiplierEffect
	dbw EFFECTCMDTYPE_AI, JolteonDoubleKick_AIEffect
	db $00

JolteonStunNeedleEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, StunNeedleEffect
	db $00

EeveeTailWagEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, TailWagEffect
	db $00

EeveeQuickAttackEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, EeveeQuickAttack_DamageBoostEffect
	dbw EFFECTCMDTYPE_AI, EeveeQuickAttack_AIEffect
	db $00

SpearowMirrorMoveEffectCommands:
	db BANK("Effect Functions 1")
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
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, FearowAgilityEffect
	db $00

DragoniteStepInEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, StepIn_BenchCheck
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, StepIn_SwitchEffect
	db $00

DragoniteLv45SlamEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, DragoniteLv45Slam_MultiplierEffect
	dbw EFFECTCMDTYPE_AI, DragoniteLv45Slam_AIEffect
	db $00

SnorlaxThickSkinnedEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, ThickSkinnedEffect
	db $00

SnorlaxBodySlamEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, SnorlaxBodySlamEffect
	db $00

FarfetchdLeekSlapEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, FarfetchdLeekSlap_OncePerDuelCheck
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, FarfetchdLeekSlap_NoDamage50PercentEffect
	dbw EFFECTCMDTYPE_DISCARD_ENERGY, FarfetchdLeekSlap_SetUsedThisDuelFlag
	dbw EFFECTCMDTYPE_AI, FarfetchdLeekSlap_AIEffect
	db $00

KangaskhanFetchEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Fetch_CheckDeck
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Fetch_DrawCardEffect
	db $00

KangaskhanCometPunchEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, CometPunch_MultiplierEffect
	dbw EFFECTCMDTYPE_AI, CometPunch_AIEffect
	db $00

TaurosStompEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, TaurosStomp_DamageBoostEffect
	dbw EFFECTCMDTYPE_AI, TaurosStomp_AIEffect
	db $00

TaurosRampageEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Rampage_Confusion50PercentEffect
	dbw EFFECTCMDTYPE_AI, Rampage_AIEffect
	db $00

DoduoFuryAttackEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, DoduoFuryAttack_MultiplierEffect
	dbw EFFECTCMDTYPE_AI, DoduoFuryAttack_AIEffect
	db $00

DodrioRetreatAidEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, RetreatAidEffect
	db $00

DodrioRageEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, DodrioRage_DamageBoostEffect
	dbw EFFECTCMDTYPE_AI, DodrioRage_AIEffect
	db $00

MeowthPayDayEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, PayDayEffect
	db $00

DragonairSlamEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, DragonairSlam_MultiplierEffect
	dbw EFFECTCMDTYPE_AI, DragonairSlam_AIEffect
	db $00

DragonairHyperBeamEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, DragonairHyperBeam_DiscardEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, DragonairHyperBeam_PlayerSelectEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, DragonairHyperBeam_AISelectEffect
	db $00

ClefableMetronomeEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, ClefableMetronome_CheckAttacks
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, ClefableMetronome_UseAttackEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, ClefableMetronome_AISelectEffect
	db $00

ClefableMinimizeEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, ClefableMinimizeEffect
	db $00

PidgeotHurricaneEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, HurricaneEffect
	db $00

PidgeottoWhirlwindEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, PidgeottoWhirlwind_SwitchEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, PidgeottoWhirlwind_SelectEffect
	dbw EFFECTCMDTYPE_AI_SWITCH_DEFENDING_PKMN, PidgeottoWhirlwind_SelectEffect
	db $00

PidgeottoMirrorMoveEffectCommands:
	db BANK("Effect Functions 1")
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
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, ClefairySingEffect
	db $00

ClefairyMetronomeEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, ClefairyMetronome_CheckAttacks
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, ClefairyMetronome_UseAttackEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, ClefairyMetronome_AISelectEffect
	db $00

WigglytuffLullabyEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, WigglytuffLullabyEffect
	db $00

WigglytuffDoTheWaveEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, DoTheWaveEffect
	dbw EFFECTCMDTYPE_AI, DoTheWaveEffect
	db $00

JigglypuffLullabyEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, JigglypuffLullabyEffect
	db $00

JigglypuffFirstAidEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, JigglypuffFirstAid_DamageCheck
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, JigglypuffFirstAid_HealEffect
	db $00

JigglypuffDoubleEdgeEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, JigglypuffDoubleEdgeEffect
	db $00

PersianPounceEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, PounceEffect
	db $00

LickitungTongueWrapEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, TongueWrapEffect
	db $00

LickitungSupersonicEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, LickitungSupersonicEffect
	db $00

PidgeyWhirlwindEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, PidgeyWhirlwind_SwitchEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, PidgeyWhirlwind_SelectEffect
	dbw EFFECTCMDTYPE_AI_SWITCH_DEFENDING_PKMN, PidgeyWhirlwind_SelectEffect
	db $00

PorygonLv12Conversion1EffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, PorygonLv12Conversion1_WeaknessCheck
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, PorygonLv12Conversion1_PlayerSelectEffect
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, PorygonLv12Conversion1_ChangeWeaknessEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, PorygonLv12Conversion1_AISelectEffect
	db $00

PorygonLv12Conversion2EffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, PorygonLv12Conversion2_ResistanceCheck
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, PorygonLv12Conversion2_PlayerSelectEffect
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, PorygonLv12Conversion2_ChangeResistanceEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, PorygonLv12Conversion2_AISelectEffect
	db $00

ChanseyScrunchEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, ScrunchEffect
	db $00

ChanseyDoubleEdgeEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, ChanseyDoubleEdgeEffect
	db $00

RaticateSuperFangEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, SuperFangEffect
	dbw EFFECTCMDTYPE_AI, SuperFangEffect
	db $00

; unreferenced
UnreferencedTrainerCardAsPokemonEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, TrainerCardAsPokemon_BenchCheck
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, TrainerCardAsPokemon_DiscardEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, TrainerCardAsPokemon_PlayerSelectSwitch
	db $00

DragoniteHealingWindEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, HealingWind_InitialEffect
	dbw EFFECTCMDTYPE_PKMN_POWER_TRIGGER, HealingWind_PlayAreaHealEffect
	db $00

DragoniteLv41SlamEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, DragoniteLv41Slam_MultiplierEffect
	dbw EFFECTCMDTYPE_AI, DragoniteLv41Slam_AIEffect
	db $00

MeowthCatPunchEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, CatPunchEffect
	db $00

DittoMorphEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Morph_CheckDeck
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Morph_TransformEffect
	db $00

PidgeotSlicingWindEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, SlicingWindEffect
	db $00

PidgeotGaleEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Gale_LoadAnimation
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Gale_SwitchEffect
	db $00

JigglypuffFriendshipSongEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, FriendshipSong_BenchCheck
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, FriendshipSong_AddToBench50PercentEffect
	db $00

JigglypuffExpandEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, JigglypuffExpandEffect
	db $00

CharmanderGatherFireEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, GatherFire_CheckUse
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, GatherFire_TransferEnergyEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, GatherFire_PlayerSelectEffect
	db $00

DarkCharmeleonFireballEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Fireball_CheckEnergy
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Fireball_DiscardEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, Fireball_PlayerSuccess50PercentEffect
	dbw EFFECTCMDTYPE_AI, Fireball_AIEffect
	dbw EFFECTCMDTYPE_AI_SWITCH_DEFENDING_PKMN, Fireball_AISuccess50PercentEffect
	db $00

DarkCharizardContinuousFireballEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, ContinuousFireball_CheckEnergy
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, ContinuousFireball_DiscardEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, ContinuousFireball_PlayerMultiplierEffect
	dbw EFFECTCMDTYPE_AI, ContinuousFireball_AIEffect
	dbw EFFECTCMDTYPE_AI_SWITCH_DEFENDING_PKMN, ContinuousFireball_AIMultiplierEffect
	db $00

PonytaEmberEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, PonytaEmber_CheckEnergy
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, PonytaEmber_PlayerSelectEffect
	dbw EFFECTCMDTYPE_DISCARD_ENERGY, PonytaEmber_DiscardEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, PonytaEmber_AISelectEffect
	db $00

RapidashFlamePillarEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, FlamePillar_BenchDamageEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, FlamePillar_PlayerSelectEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, FlamePillar_AISelectEffect
	db $00

DarkFlareonRageEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, DarkFlareonRage_DamageBoostEffect
	dbw EFFECTCMDTYPE_AI, DarkFlareonRage_AIEffect
	db $00

DarkFlareonPlayingWithFireEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, PlayingWithFire_InitialEffect
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, PlayingWithFire_DiscardAndDamageBonusEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, PlayingWithFire_PlayerSelectEffect
	dbw EFFECTCMDTYPE_AI, PlayingWithFire_AIEffect
	dbw EFFECTCMDTYPE_AI_SWITCH_DEFENDING_PKMN, PlayingWithFire_AISelectEffect
	db $00

DarkWartortleDoubleslapEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, DarkWartortleDoubleslap_MultiplierEffect
	dbw EFFECTCMDTYPE_AI, DarkWartortleDoubleslap_AIEffect
	db $00

DarkWartortleMirrorShellEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, DarkWartortleMirrorShellEffect
	db $00

DarkBlastoiseHydrocannonEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, HydrocannonEffect
	dbw EFFECTCMDTYPE_AI, HydrocannonEffect
	db $00

DarkBlastoiseRocketTackleEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, RocketTackle_NoDamageCheckEffect
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, RocketTackle_NoDamageEffect
	db $00

PsyduckDizzinessEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Dizziness_CheckDeck
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Dizziness_DrawCardEffect
	db $00

PsyduckWaterGunEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, PsyduckWaterGunEffect
	dbw EFFECTCMDTYPE_AI, PsyduckWaterGunEffect
	db $00

DarkGolduckThirdEyeEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, ThirdEye_DeckAndEnergyCheck
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, ThirdEye_PlayerSelectEffect
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, ThirdEye_DrawCardsEffect
	dbw EFFECTCMDTYPE_DISCARD_ENERGY, ThirdEye_DiscardEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, ThirdEye_AISelectEffect
	db $00

MagikarpRapidEvolutionEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, RapidEvolution_CheckEvolutionAndDeck
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, RapidEvolution_EvolveEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, RapidEvolution_PlayerSelectEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, RapidEvolution_AISelectEffect
	db $00

FinalBeamEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, FinalBeamEffect
	db $00

DarkGyaradosIceBeamEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, DarkGyaradosIceBeamEffect
	db $00

DarkVaporeonWhirlpoolEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, DarkVaporeonWhirlpool_DiscardEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, DarkVaporeonWhirlpool_PlayerSelectEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, DarkVaporeonWhirlpool_AISelectEffect
	db $00

EkansPoisonStingEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, EkansPoisonSting_Poison50PercentEffect
	dbw EFFECTCMDTYPE_AI, EkansPoisonSting_AIEffect
	db $00

DarkArbokStareEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Stare_BeforeDamageEffect
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Stare_DamageBenchEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, Stare_PlayerSelectEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, Stare_AISelectEffect
	dbw EFFECTCMDTYPE_AI, Stare_AIEffect
	db $00

DarkArbokPoisonVaporEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, PoisonVapor_PoisonEffect
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, PoisonVapor_DamageBenchEffect
	db $00

DarkGolbatSneakAttackEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, SneakAttack_InitialEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, SneakAttack_PlayerSelectEffect
	dbw EFFECTCMDTYPE_PKMN_POWER_TRIGGER, SneakAttack_DealDamageEffect
	db $00

DarkGolbatFlitterEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Flitter_DamageArenaEffect
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Flitter_DamageBenchEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, Flitter_PlayerSelectEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, Flitter_AISelectEffect
	dbw EFFECTCMDTYPE_AI, Flitter_AIEffect
	db $00

OddishSleepPowderEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, SleepPowderEffect
	db $00

OddishPoisonPowderEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, OddishPoisonPowder_PoisonEffect
	dbw EFFECTCMDTYPE_AI, OddishPoisonPowder_AIEffect
	db $00

DarkGloomPollenStenchEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, PollenStench_CheckUse
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, PollenStench_ConfusionEffect
	db $00

DarkGloomPoisonPowderEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, DarkGloomPoisonPowder_PoisonEffect
	dbw EFFECTCMDTYPE_AI, DarkGloomPoisonPowder_AIEffect
	db $00

DarkVileplumeHayFeverEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, HayFeverEffect
	db $00

DarkVileplumePetalWhirlwindEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, PetalWhirlwindEffect_MultiplierEffect
	dbw EFFECTCMDTYPE_AI, PetalWhirlwindEffect_AIEffect
	db $00

GrimerPoisonGasEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, GrimerPoisonGas_PoisonEffect
	dbw EFFECTCMDTYPE_AI, GrimerPoisonGas_AIEffect
	db $00

GrimerStickyHandsEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, StickyHands_DamageBoostAndParalysisEffect
	dbw EFFECTCMDTYPE_AI, StickyHands_AIEffect
	db $00

DarkMukStickyGooEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, StickyGooEffect
	db $00

DarkMukSludgePunchEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, SludgePunch_PoisonEffect
	dbw EFFECTCMDTYPE_AI, SludgePunch_AIEffect
	db $00

KoffingLv12PoisonGasEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, KoffingLv12PoisonGas_Poison50PercentEffect
	dbw EFFECTCMDTYPE_AI, KoffingLv12PoisonGas_AIEffect
	db $00

DarkWeezingMassExplosionEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, MassExplosion_MultiplierEffect
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, MassExplosion_DamageBenchEffect
	dbw EFFECTCMDTYPE_AI, MassExplosion_MultiplierEffect
	db $00

DarkWeezingStunGasEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, StunGasEffect
	db $00

AbraVanishEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, AbraVanish_CheckBench
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, AbraVanish_ReturnToDeckEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, AbraVanish_PlayerSelectEffect
	db $00

AbraLv14PsyshockEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, AbraLv14PsyshockEffect
	db $00

DarkKadabraMatterExchangeEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, MatterExchange_CheckUseDeckAndHandCards
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, MatterExchange_DiscardAndDrawEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, MatterExchange_PlayerSelectEffect
	db $00

DarkKadabraMindShockEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, DarkKadabraMindShockEffect
	dbw EFFECTCMDTYPE_AI, DarkKadabraMindShockEffect
	db $00

DarkAlakazamTeleportBlastEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, TeleportBlast_BeforeDamageEffect
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, TeleportBlast_SwitchEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, TeleportBlast_PlayerSelectEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, TeleportBlast_AISelectEffect
	db $00

DarkAlakazamMindShockEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, DarkAlakazamMindShockEffect
	dbw EFFECTCMDTYPE_AI, DarkAlakazamMindShockEffect
	db $00

SlowpokeAfternoonNapEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, AfternoonNap_CheckDeck
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, AfternoonNap_AttachEnergyEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, AfternoonNap_PlayerSelectEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, AfternoonNap_AISelectEffect
	db $00

DarkSlowbroReelInEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, ReelIn_InitialEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, ReelIn_PlayerSelectEffect
	dbw EFFECTCMDTYPE_PKMN_POWER_TRIGGER, ReelIn_AddToHandEffect
	db $00

DarkSlowbroFickleAttackEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, FickleAttack_NoDamage50PercentEffect
	dbw EFFECTCMDTYPE_AI, FickleAttack_AIEffect
	db $00

DrowzeeLongDistanceHypnosisEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, LongDistanceHypnosis_CheckUse
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, LongDistanceHypnosis_SleepEffect
	db $00

DrowzeeNightmareEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, DrowzeeNightmareEffect
	db $00

DarkHypnoBenchManipulationEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, BenchManipulation_CheckBench
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, BenchManipulation_MultiplierEffect
	dbw EFFECTCMDTYPE_AI, BenchManipulation_AIEffect
	db $00

DiglettDigUnderEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, DigUnder_ArenaDamageEffect
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, DigUnder_BenchDamageEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, DigUnder_PlayerSelectEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, DigUnder_AISelectEffect
	dbw EFFECTCMDTYPE_AI, DigUnder_AIEffect
	db $00

DarkDugtrioSinkholeEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, SinkholeEffect
	db $00

DarkDugtrioKnockDownEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, KnockDown_DamageBoostEffect
	dbw EFFECTCMDTYPE_AI, KnockDown_AIEffect
	db $00

MankeyMischiefEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Mischief_CheckDeck
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Mischief_ShuffleDeckEffect
	db $00

MankeyQuickAttackEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, MankeyQuickAttack_DamageBoostEffect
	dbw EFFECTCMDTYPE_AI, MankeyQuickAttack_AIEffect
	db $00

DarkPrimeapeFrenzyEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, FrenzyEffect
	db $00

DarkPrimeapeFrenziedAttackEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, FrenziedAttackEffect
	dbw EFFECTCMDTYPE_AI, CalculateFrenziedAttackDamage
	db $00

DarkMachokeDragOffEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, DragOff_CheckBench
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, DragOff_SwitchEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, DragOff_PlayerSelectEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, DragOff_AISelectEffect
	db $00

DarkMachokeKnockBackEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, KnockBack_SwitchEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, KnockBack_CheckBench
	dbw EFFECTCMDTYPE_AI_SWITCH_DEFENDING_PKMN, KnockBack_CheckBench
	db $00

DarkMachampFlingEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, DarkMachampFling_CheckBench
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, DarkMachampFling_ShuffleToDeckEffect
	db $00

RattataTrickeryEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, Trickery_CheckUseAndDeck
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Trickery_SwitchPrizeEffect
	db $00

RattataQuickAttackEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, RattataQuickAttack_DamageBoostEffect
	dbw EFFECTCMDTYPE_AI, RattataQuickAttack_AIEffect
	db $00

DarkRaticateHyperFangEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, HyperFang_NoDamage50PercentEffect
	dbw EFFECTCMDTYPE_AI, HyperFang_AIEffect
	db $00

MeowthCoinHurlEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, CoinHurl_InitialEffect
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, CoinHurl_DamageArenaEffect
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, CoinHurl_DamageBenchEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, CoinHurl_PlayerSelectEffect
	dbw EFFECTCMDTYPE_AI, CoinHurl_AIEffect
	dbw EFFECTCMDTYPE_AI_SWITCH_DEFENDING_PKMN, CoinHurl_AISelectEffect
	db $00

DarkPersianFascinateEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, DarkPersianFascinate_InitialEffect
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, DarkPersianFascinate_LoadAnimation
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, DarkPersianFascinate_SwitchEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, DarkPersianFascinate_PlayerSelectEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, DarkPersianFascinate_AISelectEffect
	db $00

DarkPersianPoisonClawsEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, PersianPoisonClaws_Poison50PercentEffect
	dbw EFFECTCMDTYPE_AI, PersianPoisonClaws_AIEffect
	db $00

EeveeSandAttackEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, EeveeSandAttackEffect
	db $00

PorygonLv20Conversion1EffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, PorygonLv20Conversion1_WeaknessCheck
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, PorygonLv20Conversion1_PlayerSelectEffect
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, PorygonLv20Conversion1_ChangeWeaknessEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, PorygonLv20Conversion1_AISelectEffect
	db $00

PorygonPsybeamEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, PorygonPsybeamEffect
	db $00

DratiniWrapEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, DratiniWrapEffect
	db $00

DarkDragonairEvolutionaryLightEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, EvolutionaryLight_CheckUseAndDeck
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, EvolutionaryLight_AddToHandEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, EvolutionaryLight_PlayerSelectEffect
	db $00

DarkDragonairTailStrikeEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, TailStrike_DamageBoostEffect
	dbw EFFECTCMDTYPE_AI, TailStrike_AIEffect
	db $00

DarkDragoniteSummonMinionsEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, SummonMinions_InitialEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, SummonMinions_PlayerSelectEffect
	dbw EFFECTCMDTYPE_PKMN_POWER_TRIGGER, SummonMinions_AddToHandEffect
	db $00

DarkDragoniteGiantTailEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, GiantTail_NoDamage50PercentEffect
	dbw EFFECTCMDTYPE_AI, GiantTail_AIEffect
	db $00

MagnemiteMagnetismEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, MagnetismEffect
	dbw EFFECTCMDTYPE_AI, MagnetismEffect
	db $00

DarkMagnetonSonicboomEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, DarkMagnetonSonicboomEffect
	dbw EFFECTCMDTYPE_AI, DarkMagnetonSonicboomEffect
	db $00

DarkMagnetonMagneticLinesEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, MagneticLines_TransferEnergyEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, MagneticLines_PlayerSelectEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, MagneticLines_AISelectEffect
	db $00

DarkElectrodeEnergyBombEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, EnergyBomb_CheckEnergy
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, EnergyBomb_PlayerSelectEffect
	dbw EFFECTCMDTYPE_UNK_11, TransferEnergyToPlayAreaPkmn
	db $00

DarkJolteonLightningFlashEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, LightningFlashEffect
	db $00

DarkJolteonThunderAttackEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, ThunderAttack_Paralysis50PercentEffect
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, ThunderAttack_RecoilEffect
	db $00

ImposterOaksRevengeEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, ImposterOaksRevenge_CheckHand
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, ImposterOaksRevenge_PlayerSelectEffect
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, ImposterOaksRevenge_ReturnHandAndDrawEffect
	db $00

SleepEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, SleepCardEffect
	db $00

DiggerEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, DiggerEffect
	db $00

TheBosssWayEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, TheBosssWay_CheckDeck
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, TheBosssWay_AddToHandEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, TheBosssWay_PlayerSelectEffect
	db $00

GoopGasAttackEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, GoopGasAttackEffect
	db $00

RocketsSneakAttackEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, RocketsSneakAttack_ReturnToDeckEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, RocketsSneakAttack_PlayerSelectEffect
	db $00

HereComesTeamRocketEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, HereComesTeamRocketEffect
	db $00

NightlyGarbageRunEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, NightlyGarbageRun_CheckDiscardPile
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, NightlyGarbageRun_ReturnToDeckEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, NightlyGarbageRun_PlayerSelectEffect
	db $00

PotionEnergyEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_PKMN_POWER_TRIGGER, PotionEnergyEffect
	db $00

FullHealEnergyEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_PKMN_POWER_TRIGGER, FullHealEnergyEffect
	db $00

RainbowEnergyEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_PKMN_POWER_TRIGGER, RainbowEnergyEffect
	db $00

ChallengeEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Challenge_DrawOrPlaceInPlayAreaEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, Challenge_PlayerAndOpponentSelectEffect
	db $00

BulbasaurFirstAidEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, BulbasaurFirstAid_DamageCheck
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, BulbasaurFirstAid_HealEffect
	db $00

BulbasaurPoisonSeedEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, PoisonSeed_PoisonEffect
	dbw EFFECTCMDTYPE_AI, PoisonSeed_AIEffect
	db $00

CharmanderGrowlEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, CharmanderGrowlEffect
	db $00

SquirtleWaterPowerEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, SquirtleWaterPowerEffect
	db $00

MetapodGreenShieldEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, MetapodGreenShieldEffect
	db $00

MetapodMysteriousPowerEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, MysteriousPowerEffect
	db $00

WeedlePoisonHornEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, PoisonHorn_PoisonEffect
	dbw EFFECTCMDTYPE_AI, PoisonHorn_AIEffect
	db $00

KakunaPoisonFluidEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, KakunaPoisonFluidEffect
	db $00

PidgeyQuickAttackEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, PidgeyQuickAttack_DamageBoostEffect
	dbw EFFECTCMDTYPE_AI, PidgeyQuickAttack_AIEffect
	db $00

RattataTailWhipEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, RattataTailWhipEffect
	db $00

PikachuLv5ThundershockEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, PikachuLv5ThundershockEffect
	db $00

PikachuAgilityEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, PikachuAgilityEffect
	db $00

NidoranFTailWhipEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, NidoranFTailWhipEffect
	db $00

NidoranFPoisonStingEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, NidoranFPoisonSting_Poison50PercentEffect
	dbw EFFECTCMDTYPE_AI, NidoranFPoisonSting_AIEffect
	db $00

NidoranMFocusEnergyEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, NidoranMFocusEnergyEffect
	db $00

NidoranMHornRushEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, HornRush_NoDamage50PercentEffect
	dbw EFFECTCMDTYPE_AI, HornRush_AIEffect
	db $00

ClefairyFollowMeEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, FollowMe_AssertPokemonInBench
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, FollowMe_SwitchDefendingPokemon
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, FollowMe_SelectSwitchPokemon
	dbw EFFECTCMDTYPE_AI_SWITCH_DEFENDING_PKMN, FollowMe_GetBenchPokemonWithLowestHP
	db $00

ClefairyShiningFingersEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, ShiningFingersEffect
	db $00

WigglytuffHelpingHandEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, HelpingHandEffect_CheckUse
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, HelpingHandEffect_HealStatusEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, HelpingHandEffect_PlayerSelectEffect
	db $00

WigglytuffExpandEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, WigglytuffExpandEffect
	db $00

ZubatSuspiciousSoundwaveEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, SuspiciousSoundwaveEffect
	db $00

GolbatLv25LeechLifeEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, GolbatLv25LeechLifeEffect
	db $00

GolbatNosediveEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Nosedive_Recoil50PercentEffect
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Nosedive_RecoilEffect
	db $00

ParasScatterSporesEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, ScatterSpores_CheckDeckAndBench
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, ScatterSpores_PlaceInPlayAreaEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, ScatterSpores_PlayerSelectEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, ScatterSpores_AISelectEffect
	db $00

ParasectToxicSporeEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, ToxicSpore_PoisonEffect
	dbw EFFECTCMDTYPE_AI, ToxicSpore_AIEffect
	db $00

ParasectLeechLifeEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, ParasectLeechLifeEffect
	db $00

PoliwagBubbleEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, PoliwagBubbleEffect
	db $00

PoliwhirlTwiddleEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, TwiddleEffect
	db $00

PoliwagBodySlamEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, PoliwagBodySlamEffect
	db $00

PoliwrathHydroPumpEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, PoliwrathHydroPumpEffect
	dbw EFFECTCMDTYPE_AI, PoliwrathHydroPumpEffect
	db $00

AbraPsychicEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, AbraPsychic_ArenaDamageEffect
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, AbraPsychic_BenchDamageEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, AbraPsychic_PlayerSelectEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, AbraPsychic_AISelectEffect
	dbw EFFECTCMDTYPE_AI, AbraPsychic_AIEffect
	db $00

GeodudeHardenEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, GeodudeHardenEffect
	db $00

RapidashFlameInfernoEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, FlameInferno_DiscardAndDamageBoostEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, FlameInferno_PlayerSelectEffect
	dbw EFFECTCMDTYPE_AI, FlameInferno_AIEffect
	dbw EFFECTCMDTYPE_AI_SWITCH_DEFENDING_PKMN, FlameInferno_AISelectEffect
	db $00

RapidashKickAwayEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, KickAway_SwitchEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, KickAway_CheckBench
	dbw EFFECTCMDTYPE_AI_SWITCH_DEFENDING_PKMN, KickAway_CheckBench
	db $00

DoduoGrowlEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, DoduoGrowlEffect
	db $00

DodrioTriAttackEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, TriAttack_MultiplierEffect
	dbw EFFECTCMDTYPE_AI, TriAttack_AIEffect
	db $00

LickitungLickEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, LickitungLickEffect
	db $00

LickitungStompEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, LickitungStomp_DamageBoostEffect
	dbw EFFECTCMDTYPE_AI, LickitungStomp_AIEffect
	db $00

ChanseySingEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, ChanseySingEffect
	db $00

ChanseyDoubleSlapEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, ChanseyDoubleSlap_MultiplierEffect
	dbw EFFECTCMDTYPE_AI, ChanseyDoubleSlap_AIEffect
	db $00

MrMimeDampeningShieldEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, DampeningShieldEffect
	db $00

MrMimeJugglingEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Juggling_MultiplierEffect
	dbw EFFECTCMDTYPE_AI, Juggling_AIEffect
	db $00

PinsirSlicingThrowEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, SlicingThrow_DamageBoostEffect
	dbw EFFECTCMDTYPE_AI, SlicingThrow_AIEffect
	db $00

EeveeLungeEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, EeveeLunge_NoDamage50PercentEffect
	dbw EFFECTCMDTYPE_AI, EeveeLunge_AIEffect
	db $00

Porygon3DAttackEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Porygon3DAttack_MultiplierEffect
	dbw EFFECTCMDTYPE_AI, Porygon3DAttack_AIEffect
	db $00

PorygonLv18Conversion2EffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, PorygonLv18Conversion2_ResistanceCheck
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, PorygonLv18Conversion2_PlayerSelectEffect
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, PorygonLv18Conversion2_ChangeResistanceEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, PorygonLv18Conversion2_AISelectEffect
	db $00

SnorlaxGuardEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, GuardEffect
	db $00

SnorlaxRollOverEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, RollOverEffect
	db $00

MewtwoPsycrushEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, PsycrushEffect
	dbw EFFECTCMDTYPE_AI, PsycrushEffect
	db $00

TheRocketsTrapEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, TheRocketsTrap_CheckHand
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, TheRocketsTrap_ReturnToDeck50PercentEffect
	db $00

FossilExcavationEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, FossilExcavation_DeckAndDiscardPileCheck
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, FossilExcavation_AddToHandEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, FossilExcavation_PlayerSelectEffect
	dbw EFFECTCMDTYPE_AI_SWITCH_DEFENDING_PKMN, FossilExcavation_AISelectEffect
	db $00

MoonStoneEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, MoonStone_DeckCheck
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, MoonStone_AddToHandEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, MoonStone_PlayerSelectEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, MoonStone_AISelectEffect
	db $00

MaxReviveEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, MaxRevive_DiscardPileAndHandCheck
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, MaxRevive_PlayerSelectEffect
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, MaxRevive_DiscardAndPlaceInBenchEffect
	db $00

MasterBallEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, MasterBall_DeckCheck
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, MasterBall_AddToHandEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, MasterBall_PlayerSelectEffect
	db $00

PokemonRecallEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, PokemonRecall_DiscardPileCheck
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, PokemonRecall_PlayerSelectEffect
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, PokemonRecall_AddToHandEffect
	db $00

BillsComputerEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, BillsComputerEffect
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, BillsComputerEffect
	db $00

ComputerErrorEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, ComputerError_DecksCheck
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, ComputerError_DrawEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, ComputerError_PlayerAndOppSelection
	db $00

SpearowFuryAttackEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, SpearowFuryAttack_MultiplierEffect
	dbw EFFECTCMDTYPE_AI, SpearowFuryAttack_AIEffect
	db $00

FearowQuickAttackEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, FearowQuickAttack_DamageBoostEffect
	dbw EFFECTCMDTYPE_AI, FearowQuickAttack_AIEffect
	db $00

FearowDrillDescentEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, DrillDescent_NoDamage50PercentEffect
	dbw EFFECTCMDTYPE_AI, DrillDescent_AIEffect
	db $00

RaichuShortCircuitEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, ShortCircuit_WaterEnergyCheck
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, ShortCircuit_DamageArenaEffect
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, ShortCircuit_DamageBenchEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, ShortCircuit_PlayerSelectEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, ShortCircuit_AISelectEffect
	db $00

RaichuSparkingKickEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, SparkingKickEffect
	db $00

SandshrewPoisonStingEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, SandshrewPoisonSting_Poison50PercentEffect
	dbw EFFECTCMDTYPE_AI, SandshrewPoisonSting_AIEffect
	db $00

SandshrewSwiftEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, SandshrewSwift_BeforeDamage
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, SandshrewSwift_AfterDamage
	dbw EFFECTCMDTYPE_AI, SetSandshrewSwiftDamage
	db $00

VenomothStirUpTwisterEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, StirUpTwister_SwitchEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, StirUpTwister_PlayerSelectEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, StirUpTwister_AISelectEffect
	db $00

VenomothRainbowPowderEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, RainbowPowderEffect
	db $00

MachopFocusedOneShotEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, FocusedOneShotEffect
	db $00

MachopCorkscrewPunchEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, CorkscrewPunchEffect
	db $00

MachokeSteadyPunchEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, SteadyPunch_DamageBoostEffect
	dbw EFFECTCMDTYPE_AI, SteadyPunch_AIEffect
	db $00

GravelerStoneBarrageEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, GravelerStoneBarrage_MultiplierEffect
	dbw EFFECTCMDTYPE_AI, GravelerStoneBarrage_AIEffect
	db $00

GravelerEarthquakeEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, GravelerEarthquakeEffect
	db $00

MagnemiteMagnetMoveEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, MagnetMove_CheckUse
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, MagnetMove_AddToPlayAreaEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, MagnetMove_PlayerSelectEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, MagnetMove_AISelectEffect
	db $00

MagnemiteSuperconductivityEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Superconductivity_DamageArenaEffect
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Superconductivity_DamageBenchEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, Superconductivity_PlayerSelectEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, Superconductivity_AISelectEffect
	dbw EFFECTCMDTYPE_AI, Superconductivity_AIEffect
	db $00

MagnetonMicrowaveEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Microwave_InitialEffect
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Microwave_ArenaDamageEffect
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Microwave_BenchDamageAndDiscardEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, Microwave_PlayerSelectEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, Microwave_AISelectEffect
	dbw EFFECTCMDTYPE_AI, Microwave_AIEffect
	db $00

SeelGrowlEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, SeelGrowlEffect
	db $00

SeelIceBeamEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, SeelIceBeamEffect
	db $00

DewgongRestEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Rest_SleepEffect
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Rest_HealEffect
	db $00

DewgongAuroraWaveEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, AuroraWaveEffect
	db $00

ShellderWaterSpoutEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, WaterSpoutEffect
	dbw EFFECTCMDTYPE_AI, WaterSpoutEffect
	db $00

OnixBindEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, OnixBindEffect
	db $00

OnixRockSealEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, RockSealEffect
	db $00

KrabbyBubbleEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, KrabbyBubbleEffect
	db $00

VoltorbThundershockEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, VoltorbThundershockEffect
	db $00

VoltorbGroupSparkEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, GroupSparkEffect
	dbw EFFECTCMDTYPE_AI, GroupSparkEffect
	db $00

HitmonleeDoubleKickEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, HitmonleeDoubleKick_MultiplierEffect
	dbw EFFECTCMDTYPE_AI, HitmonleeDoubleKick_AIEffect
	db $00

HitmonleeRollingKickEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, RollingKickEffect
	db $00

HitmonchanMatchPunchEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, MatchPunch_InitialEffect
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, MatchPunch_DamageBenchEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, MatchPunch_PlayerSelectEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, MatchPunch_AISelectEffect
	db $00

JynxIcePunchEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, IcePunchEffect
	db $00

JynxColdBreathEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, ColdBreathEffect
	db $00

LaprasSingEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, LaprasSingEffect
	db $00

OmanytePrehistoricDreamEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, PrehistoricDream_CheckUse
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, PrehistoricDream_IncrementBoostEffect
	db $00

KabutoFossilizeEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, Fossilize_CheckUse
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Fossilize_DevolveEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, Fossilize_PlayerSelectEffect
	db $00

KabutoSharpClawsEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, SharpClaws_DamageBoostEffect
	dbw EFFECTCMDTYPE_AI, SharpClaws_AIEffect
	db $00

AerodactylSupersonicEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, AerodactylSupersonicEffect
	db $00

AerodactylTailspinAttackEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, TailspinAttackEffect
	db $00

ArticunoAuroraVeilEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, AuroraVeilEffect
	db $00

ArticunoIceBeamEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, ArticunoIceBeamEffect
	db $00

ZapdosRagingThunderEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, RagingThunder_InitialEffect
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, RagingThunder_DamageOwnPlayAreaEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, RagingThunder_PlayerSelectEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, RagingThunder_AISelectEffect
	db $00

ZapdosThunderCrashEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, ThunderCrash_DamageBoostOrRecoilEffect
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, ThunderCrash_RecoilEffect
	dbw EFFECTCMDTYPE_AI, ThunderCrash_AIEffect
	db $00

MoltresDryUpEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, DryUp_CheckPlayAreaWaterEnergies
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, DryUp_PlayerSelectPlayAreaPkmnEffect
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, DryUp_DiscardFromArenaEffect
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, DryUp_DiscardFromBenchEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, DryUp_PlayerSelectEnergyEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, DryUp_AISelectPlayAreaPkmnEffect
	dbw EFFECTCMDTYPE_AI_SWITCH_DEFENDING_PKMN, DryUp_AISelectEnergyEffect
	db $00

PidgeottoTwisterEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, TwisterEffect
	db $00

PidgeottoFlyEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, PidgeottoFly_Success50PercentEffect
	dbw EFFECTCMDTYPE_AI, PidgeottoFly_AIEffect
	db $00

ArbokWrapEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, ArbokWrapEffect
	db $00

ArbokDeadlyPoisonEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, DeadlyPoisonEffect
	dbw EFFECTCMDTYPE_AI, AddDeadlyPoisonDamageBoost
	db $00

SandslashSandVeilEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, SandVeilEffect
	db $00

SandslashRollingNeedleEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, RollingNeedle_MultiplierEffect
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, RollingNeedle_RecoilEffect
	dbw EFFECTCMDTYPE_AI, RollingNeedle_AIEffect
	db $00

NidorinaStrengthInNumbersEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, StrengthInNumbersEffect
	dbw EFFECTCMDTYPE_AI, StrengthInNumbersEffect
	db $00

NidorinaFurySwipesEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, NidorinaFurySwipes_MultiplierEffect
	dbw EFFECTCMDTYPE_AI, NidorinaFurySwipes_AIEffect
	db $00

NidorinoSwiftLungeEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, SwiftLunge_NoDamage50PercentEffect
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, SwiftLunge_RecoilEffect
	dbw EFFECTCMDTYPE_AI, SwiftLunge_AIEffect
	db $00

VulpixFoxFireEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, FoxFire_SwitchAndDamageEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, FoxFire_PlayerSelectEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, FoxFire_AISelectEffect
	db $00

VenonatDisableEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Disable_CheckAttacks
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Disable_DisableEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, Disable_PlayerSelectEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, Disable_AISelectEffect
	db $00

VenonatPsybeamEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, VenonatPsybeamEffect
	db $00

GolduckPsychicEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, GolduckPsychicEffect
	dbw EFFECTCMDTYPE_AI, GolduckPsychicEffect
	db $00

GrowlitheErrandRunningEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, ErrandRunning_DeckCheck
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, ErrandRunning_SetAnimationEffect
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, ErrandRunning_AddToHandEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, ErrandRunning_PlayerSelectEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, ErrandRunning_AISelectEffect
	db $00

GrowlitheLv16EmberEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, GrowlitheLv16Ember_CheckEnergy
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, GrowlitheLv16Ember_PlayerSelectEffect
	dbw EFFECTCMDTYPE_DISCARD_ENERGY, GrowlitheLv16Ember_DiscardEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, GrowlitheLv16Ember_AISelectEffect
	db $00

KadabraPsychoPanicEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, KadabraPsychoPanicEffect
	dbw EFFECTCMDTYPE_AI, KadabraPsychoPanicEffect
	db $00

KadabraBlinkEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, BlinkEffect
	db $00

AlakazamPsychoPanicEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, AlakazamPsychoPanicEffect
	dbw EFFECTCMDTYPE_AI, AlakazamPsychoPanicEffect
	db $00

AlakazamTransDamageEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, TransDamage_DamageCheck
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, TransDamage_AnimateAndSetDamageEffect
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, TransDamage_MoveCountersEffect
	dbw EFFECTCMDTYPE_DISCARD_ENERGY, TransDamage_DiscardAllEnergiesEffect
	dbw EFFECTCMDTYPE_AI, TransDamage_AIEffect
	db $00

MachokeWickedJabEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, WickedJabEffect
	db $00

MachokeFocusBlastEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, FocusBlast_InitialEffect
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, FocusBlast_ClearAnimationEffect
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, FocusBlast_DealDamageEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, FocusBlast_PlayerSelectEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, FocusBlast_AISelectEffect
	dbw EFFECTCMDTYPE_AI, FocusBlast_AIEffect
	db $00

MachampSeethingAngerEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, SeethingAnger_DamageBoostEffect
	dbw EFFECTCMDTYPE_AI, SeethingAnger_AIEffect
	db $00

MachampFlingEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, MachampFling_SwitchEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, MachampFling_CheckBench
	dbw EFFECTCMDTYPE_AI_SWITCH_DEFENDING_PKMN, MachampFling_CheckBench
	db $00

BellsproutSwayEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, SwayEffect
	db $00

BellsproutStunSporeEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, BellsproutStunSporeEffect
	db $00

WeepinbellRegenerationEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, RegenerationEffect
	db $00

WeepinbellDissolveEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Dissolve_ArenaEnergyCheck
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Dissolve_DiscardEnergyEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, Dissolve_PlayerSelectEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, Dissolve_AISelectEffect
	db $00

GravelerBoulderSmashEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, BoulderSmash_InitialEffect
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, BoulderSmash_BenchDamageEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, BoulderSmash_PlayerSelectEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, BoulderSmash_AISelectEffect
	db $00

GolemRockBlastEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, RockBlast_EnergiesCheck
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, RockBlast_DiscardEnergiesAndDamageArenaEffect
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, RockBlast_DamageBenchEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, RockBlast_PlayerSelectEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, RockBlast_AISelectEffect
	dbw EFFECTCMDTYPE_AI, RockBlast_AIEffect
	db $00

PonytaFireworksEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Fireworks_InitialEffect
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Fireworks_DiscardEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, Fireworks_PlayerSelectEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, Fireworks_AISelectEffect
	dbw EFFECTCMDTYPE_AI, Fireworks_AIEffect
	db $00

SlowbroBigYawnEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, BigYawn_SleepCheck
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, BigYawn_SleepEffect
	db $00

SlowbroBigSnoreEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, BigSnoreEffect
	db $00

GastlySpookifyEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, SpookifyEffect
	db $00

GastlyFadeToBlackEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, FadeToBlackEffect
	db $00

HaunterPoltergeistEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Poltergeist_10DamagePerTrainerEffect
	dbw EFFECTCMDTYPE_AI, Poltergeist_AIEffect
	db $00

HaunterBadDreamsEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, BadDreamsEffect
	db $00

HaunterEerieLightEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, EerieLightEffect
	db $00

HaunterGrudgeEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, GrudgeEffect
	dbw EFFECTCMDTYPE_AI, GrudgeEffect
	db $00

GengarPowerOfDarknessEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, PowerOfDarkness_InitialEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, PowerOfDarkness_PlayerSelectEffect
	dbw EFFECTCMDTYPE_PKMN_POWER_TRIGGER, PowerOfDarkness_ReturnToHandEffect
	db $00

GengarPsyHorrorEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, PsyHorrorEffect
	db $00

HypnoPuppetMasterEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, PuppetMasterEffect
	db $00

HypnoMindShockEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, HypnoMindShockEffect
	db $00

; unreferenced
EffectCommands_590ab:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_65cf9
	db $00

KinglerSaltWaterEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, SaltWater_DeckCheck
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, SaltWater_ClearAnimationIfFailed
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, SaltWater_AttachToArenaEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, SaltWater_PlayerSelectEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, SaltWater_AIEffect
	db $00

KinglerDoubleEdgedPincersEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, DoubleEdgedPincersEffect
	db $00

CuboneBoneTossEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, BoneToss_InitialEffect
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, BoneToss_ArenaDamageEffect
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, BoneToss_BenchDamageEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, BoneToss_PlayerSelectEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, BoneToss_AISelectEffect
	dbw EFFECTCMDTYPE_AI, BoneToss_AIEffect
	db $00

WeezingPoisonMistEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, PoisonMist_CheckUse
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, PoisonMist_SetAffectedByPoisonMistEffect
	db $00

WeezingGasExplosionEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, GasExplosionEffect
	db $00

RhydonMountainBreakEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, MountainBreak_DeckCheck
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, MountainBreak_DiscardAndAddToHandEffect
	db $00

RhydonOneTwoStrikeEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, OneTwoStrike_DamageBoostEffect
	dbw EFFECTCMDTYPE_AI, OneTwoStrike_AIEffect
	db $00

KangaskhanTailDropEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, TailDrop_NoDamage25PercentEffect
	dbw EFFECTCMDTYPE_AI, TailDrop_AIEffect
	db $00

HorseaHideEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, HideEffect
	db $00

HorseaWaterGunEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, HorseaWaterGunEffect
	dbw EFFECTCMDTYPE_AI, HorseaWaterGunEffect
	db $00

SeadraWaterBombEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, WaterBomb_BenchDamageEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, WaterBomb_PlayerSelectEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, WaterBomb_AISelectEffect
	db $00

StaryuStrangeBeamEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, StrangeBeamEffect
	db $00

ScytherSlashingStrikeEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, SlashingStrike_CheckUse
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, SlashingStrike_CannotUseNextTurnEffect
	db $00

MagmarBurningFireEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, BurningFire_DiscardAndMultiplierEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, BurningFire_PlayerSelectEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, BurningFire_AISelectEffect
	dbw EFFECTCMDTYPE_AI, BurningFire_AIEffect
	db $00

TaurosKickingAndStampingEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, KickingAndStamping_InitialEffect
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, KickingAndStamping_DamageBoostEffect
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, KickingAndStamping_SwitchEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, KickingAndStamping_Switch50PercentEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, KickingAndStamping_Switch50PercentEffect
	dbw EFFECTCMDTYPE_AI, KickingAndStamping_AIEffect
	db $00

OmanyteFossilGuidanceEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, FossilGuidance_CheckUse
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, FossilGuidance_AddToHand50PercentEffect
	db $00

OmastarTentacleGripEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, TentacleGrip_DeckAndEnergyCheck
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, TentacleGrip_FlipCoinsEffect
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, TentacleGrip_DrawEffect
	db $00

OmastarCorrosiveAcidEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, CorrosiveAcid_CheckCanUse
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, CorrosiveAcid_ParalysisOrCannotUseNextTurnEffect
	db $00

MewtwoCompleteRecoveryEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, CompleteRecovery_HPAndStatusCheck
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, CompleteRecovery_ClearStatusAndHealDamageEffect
	db $00

MewtwoPsychoBlastEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, PsychoBlast_InitialEffect
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, PsychoBlast_DiscardEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, PsychoBlast_PlayerSelectEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, PsychoBlast_AISelectEffect
	db $00

DarkPersianAltFascinateEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, DarkPersianAltFascinate_InitialEffect
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, DarkPersianAltFascinate_LoadAnimation
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, DarkPersianAltFascinate_SwitchEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, DarkPersianAltFascinate_PlayerSelectEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, DarkPersianAltFascinate_AISelectEffect
	db $00

PersianAltPoisonClawsEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, PersianAltPoisonClaws_Poison50PercentEffect
	dbw EFFECTCMDTYPE_AI, PersianAltPoisonClaws_AIEffect
	db $00

MeowthClearProfitEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, ClearProfit_DeckCheck
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, ClearProfit_FlipCoinUntilTailsEffect
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, ClearProfit_DrawEffect
	db $00

CoolPorygonTextureMagicEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, TextureMagic_ResistanceCheck
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, TextureMagic_PlayerSelectEffect
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, TextureMagic_ChangeWeaknessAndResistanceEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, TextureMagic_AISelectEffect
	db $00

CoolPorygon3DAttackEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, CoolPorygon3DAttack_MultiplierEffect
	dbw EFFECTCMDTYPE_AI, CoolPorygon3DAttack_AIEffect
	db $00

HungrySnorlaxEatEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Eat_CountersCheck
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Eat_AddFoodCounterEffect
	db $00

HungrySnorlaxRolloutEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, Rollout_PlayerSelectEffect
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Rollout_RemoveCountersAndDamageBoostEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, Rollout_AISelectEffect
	dbw EFFECTCMDTYPE_AI, Rollout_AIEffect
	db $00

MewtwoEnergyControlEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, EnergyControl_EnergyCheck
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, EnergyControl_SwitchEnergyEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, EnergyControl_PlayerSelectEffect
	dbw EFFECTCMDTYPE_AI_SWITCH_DEFENDING_PKMN, EnergyControl_AISelectEffect
	db $00

MewtwoTelekinesisEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Telekinesis_ArenaDamageEffect
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Telekinesis_BenchDamageEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, Telekinesis_PlayerSelectEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, Telekinesis_AISelectEffect
	dbw EFFECTCMDTYPE_AI, Telekinesis_UnaffectedByWREffect
	db $00

PikachuRechargeEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Recharge_DeckCheck
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Recharge_AttachFromDeckEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, Recharge_PlayerSelectEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, Recharge_AISelectEffect
	db $00

PikachuThunderboltEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, PikachuThunderboltEffect
	db $00

FarfetchdAltLeekSlapEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, FarfetchdAltLeekSlap_OncePerDuelCheck
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, FarfetchdAltLeekSlap_NoDamage50PercentEffect
	dbw EFFECTCMDTYPE_DISCARD_ENERGY, FarfetchdAltLeekSlap_SetUsedThisDuelFlag
	; bug, missing AI effect command
	db $00

KangaskhanDizzyPunchEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, DizzyPunch_MultiplierEffect
	dbw EFFECTCMDTYPE_AI, DizzyPunch_AIEffect
	db $00

DiglettTripOverEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, TripOver_DamageBoost50PercentEffect
	dbw EFFECTCMDTYPE_AI, TripOver_AIEffect
	db $00

DugtrioGoUndergroundEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, GoUndergroundEffect
	db $00

DugtrioEarthWaveEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, EarthWave_BenchDamageEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, EarthWave_PlayerSelectEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, EarthWave_AISelectEffect
	db $00

DragoniteSpecialDeliveryEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, SpecialDelivery_UseAndDeckCheck
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, SpecialDelivery_DrawAndPlaceInDeckEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, SpecialDelivery_PlayerSelectEffect
	db $00

DragoniteSupersonicFlightEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, SupersonicFlight_NoDamage50PercentEffect
	dbw EFFECTCMDTYPE_AI, SupersonicFlight_AIEffect
	db $00

MagikarpTrickleEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Trickle_MultiplierEffect
	dbw EFFECTCMDTYPE_AI, Trickle_AIEffect
	db $00

MagikarpDragonRageEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, DragonRage_NoDamage75PercentEffect
	dbw EFFECTCMDTYPE_AI, DragonRage_AIEffect
	db $00

TogepiSnivelEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, TogepiSnivelEffect
	db $00

TogepiMiniMetronomeEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, MiniMetronome_CheckAttacks
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, MiniMetronome_UseAttackEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, MiniMetronome_AISelectEffect
	db $00

MarillWaterGunEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, MarillWaterGunEffect
	dbw EFFECTCMDTYPE_AI, MarillWaterGunEffect
	db $00

MankeyAltPeekEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, MankeyAltPeek_OncePerTurnCheck
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, MankeyAltPeek_SelectEffect
	db $00

IvysaurLeechSeedEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, IvysaurLeechSeedEffect
	db $00

KoffingLv14PoisonGasEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, KoffingLv14PoisonGas_Poison50PercentEffect
	dbw EFFECTCMDTYPE_AI, KoffingLv14PoisonGas_AIEffect
	db $00

KoffingConfusionGasEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, KoffingConfusionGasEffect
	db $00

RaichuQuickAttackEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, RaichuQuickAttack_DamageBoostEffect
	dbw EFFECTCMDTYPE_AI, RaichuQuickAttack_AIEffect
	db $00

RaichuThunderboltEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, RaichuThunderboltEffect
	db $00

ElectabuzzLv30ThundershockEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, ElectabuzzLv30ThundershockEffect
	db $00

JynxDoubleSlapEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, JynxDoubleSlap_MultiplierEffect
	dbw EFFECTCMDTYPE_AI, JynxDoubleSlap_AIEffect
	db $00

MeowthFurySwipesEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, MeowthFurySwipes_MultiplierEffect
	dbw EFFECTCMDTYPE_AI, MeowthFurySwipes_AIEffect
	db $00

GrowlitheLungeEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, GrowlitheLunge_NoDamage50PercentEffect
	dbw EFFECTCMDTYPE_AI, GrowlitheLunge_AIEffect
	db $00

GrowlitheLv12EmberEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, GrowlitheLv12Ember_CheckEnergy
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, GrowlitheLv12Ember_PlayerSelectEffect
	dbw EFFECTCMDTYPE_DISCARD_ENERGY, GrowlitheLv12Ember_DiscardEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, GrowlitheLv12Ember_AISelectEffect
	db $00

ArcanineLv35TakeDownEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, ArcanineLv35TakeDownEffect
	db $00

MagmarLv18SmogEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, MagmarLv18Smog_Poison50PercentEffect
	dbw EFFECTCMDTYPE_AI, MagmarLv18Smog_AIEffect
	db $00

WartortleBubbleEffectCommands:
	db BANK("Effect Functions 1")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, WartortleBubbleEffect
	db $00

SuperScoopUpEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, SuperScoopUp_BenchCheck
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, SuperScoopUp_ReturnToHandEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, SuperScoopUp_PlayerSelection
	db $00

BillsTeleporterEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, BillsTeleporterEffect
	db $00

DarkClefableDarknessVeilEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, DarknessVeilEffect
	db $00

DarkClefableDarkSongEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, DarkSong_Sleep50PercentEffect
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, DarkSong_BenchDamageEffect
	db $00

DarkHaunterBotherEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Bother_Success50PercentEffect
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Bother_ReturnTrainerCardToDeckEffect
	db $00

DarkGengarPlayTricksEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, PlayTricks_CheckBenchAndDamage
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, PlayTricks_ShuffleDamageEffect
	db $00

DarkGengarPushAsideEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, PushAside_Success50PercentEffect
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, PushAside_ReturnToDeckEffect
	db $00

DarkStarmieRebirthEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, Rebirth_UseCheck
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Rebirth_DiscardAndAddStaryuEffect
	db $00

DarkStarmieSpinningShowerEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, SpinningShower_Success50PercentEffect
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, SpinningShower_AttackRandomPlayAreaCardsEffect
	db $00

DarkFearowFlyHighEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, FlyHighEffect
	db $00

DarkFearowDrillDiveEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, DrillDive_CheckUse
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, DrillDive_CannotUseNextTurnEffect
	db $00

DarkRaichuSurpriseThunderEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, SurpriseThunderEffect
	db $00

DarkNinetalesPerplexEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, PerplexEffect
	db $00

DarkNinetalesNineTailsEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, NineTails_MultiplierEffect
	dbw EFFECTCMDTYPE_AI, NineTails_AIEffect
	db $00

DarkMarowakBoneHeadbuttEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, BoneHeadbuttEffect
	db $00

GRsMewtwoDarkWaveEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, DarkWaveEffect
	db $00

GRsMewtwoDarkAmplificationEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, DarkAmplification_20Damage50PercentPerDarkPokemonEffect
	dbw EFFECTCMDTYPE_AI, DarkAmplification_AIEffect
	db $00

DarkIvysaurVinePullEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, VinePullEffect
	db $00

DarkIvysaurFuryStrikesEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, FuryStrikesEffect
	db $00

DarkVenusaurHorridPollenEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, HorridPollenEffect
	db $00

LugiaAeroblastEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Aeroblast_DamageBoostEffect
	dbw EFFECTCMDTYPE_AI, Aeroblast_AIEffect
	db $00

RecycleEnergyEffectCommands:
	db BANK("Effect Functions 2")
	db $00

DoubleColorlessEnergyEffectCommands:
	db BANK("Effect Functions 2")
	db $00

PsychicEnergyEffectCommands:
	db BANK("Effect Functions 2")
	db $00

FightingEnergyEffectCommands:
	db BANK("Effect Functions 2")
	db $00

LightningEnergyEffectCommands:
	db BANK("Effect Functions 2")
	db $00

WaterEnergyEffectCommands:
	db BANK("Effect Functions 2")
	db $00

FireEnergyEffectCommands:
	db BANK("Effect Functions 2")
	db $00

GrassEnergyEffectCommands:
	db BANK("Effect Functions 2")
	db $00

SuperPotionEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, SuperPotion_DamageEnergyCheck
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, SuperPotion_PlayerSelectEffect
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, SuperPotion_HealEffect
	db $00

ImakuniEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, ImakuniEffect
	db $00

EnergyRemovalEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, EnergyRemoval_EnergyCheck
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, EnergyRemoval_PlayerSelection
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, EnergyRemoval_DiscardEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, EnergyRemoval_AISelection
	db $00

EnergyRetrievalEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, EnergyRetrieval_HandEnergyCheck
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, EnergyRetrieval_PlayerHandSelection
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, EnergyRetrieval_DiscardAndAddToHandEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, EnergyRetrieval_PlayerDiscardPileSelection
	db $00

EnergySearchEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, EnergySearch_DeckCheck
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, EnergySearch_AddToHandEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, EnergySearch_PlayerSelection
	db $00

ProfessorOakEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, ProfessorOakEffect
	db $00

PotionEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Potion_DamageCheck
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, Potion_PlayerSelection
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Potion_HealEffect
	db $00

GamblerEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, GamblerEffect
	db $00

ItemFinderEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, ItemFinder_HandDiscardPileCheck
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, ItemFinder_PlayerSelection
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, ItemFinder_DiscardAddToHandEffect
	db $00

DefenderEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, Defender_PlayerSelection
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Defender_AttachDefenderEffect
	db $00

MysteriousFossilEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, MysteriousFossil_BenchCheck
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, MysteriousFossil_PlaceInPlayAreaEffect
	db $00

FullHealEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, FullHeal_StatusCheck
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, FullHeal_ClearStatusEffect
	db $00

ImposterProfessorOakEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, ImposterProfessorOakEffect
	db $00

ComputerSearchEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, ComputerSearch_HandDeckCheck
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, ComputerSearch_PlayerDiscardHandSelection
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, ComputerSearch_DiscardAddToHandEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, ComputerSearch_PlayerDeckSelection
	db $00

ClefairyDollEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, ClefairyDoll_BenchCheck
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, ClefairyDoll_PlaceInPlayAreaEffect
	db $00

MrFujiEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, MrFuji_BenchCheck
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, MrFuji_PlayerSelection
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, MrFuji_ReturnToDeckEffect
	db $00

PlusPowerEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, PlusPowerEffect
	db $00

SwitchEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Switch_BenchCheck
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, Switch_PlayerSelection
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Switch_SwitchEffect
	db $00

PokemonCenterEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, PokemonCenter_DamageCheck
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, PokemonCenter_HealDiscardEnergyEffect
	db $00

PokemonFluteEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, PokemonFlute_BenchCheck
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, PokemonFlute_PlayerSelection
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, PokemonFlute_PlaceInPlayAreaText
	db $00

PokemonBreederEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, PokemonBreeder_HandPlayAreaCheck
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, PokemonBreeder_PlayerSelection
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, PokemonBreeder_EvolveEffect
	db $00

ScoopUpEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, ScoopUp_BenchCheck
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, ScoopUp_PlayerSelection
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, ScoopUp_ReturnToHandEffect
	db $00

PokemonTraderEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, PokemonTrader_HandDeckCheck
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, PokemonTrader_PlayerHandSelection
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, PokemonTrader_TradeCardsEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, PokemonTrader_PlayerDeckSelection
	db $00

PokedexEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Pokedex_DeckCheck
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Pokedex_OrderDeckCardsEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, Pokedex_PlayerSelection
	db $00

BillEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, BillEffect
	db $00

LassEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, LassEffect
	db $00

MaintenanceEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Maintenance_HandCheck
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, Maintenance_PlayerSelection
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Maintenance_ReturnToDeckAndDrawEffect
	db $00

PokeBallEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, PokeBall_DeckCheck
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, PokeBall_AddToHandEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, PokeBall_PlayerSelection
	db $00

RecycleEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Recycle_DiscardPileCheck
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Recycle_AddToHandEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, Recycle_PlayerSelection
	db $00

ReviveEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Revive_BenchCheck
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, Revive_PlayerSelection
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Revive_PlaceInPlayAreaEffect
	db $00

DevolutionSprayEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, DevolutionSpray_PlayAreaEvolutionCheck
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, DevolutionSpray_PlayerSelection
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, DevolutionSpray_DevolutionEffect
	db $00

SuperEnergyRemovalEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, SuperEnergyRemoval_EnergyCheck
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, SuperEnergyRemoval_PlayerSelection
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, SuperEnergyRemoval_DiscardEffect
	db $00

SuperEnergyRetrievalEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, SuperEnergyRetrieval_HandEnergyCheck
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, SuperEnergyRetrieval_PlayerHandSelection
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, SuperEnergyRetrieval_DiscardAndAddToHandEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, SuperEnergyRetrieval_PlayerDiscardPileSelection
	db $00

GustOfWindEffectCommands:
	db BANK("Effect Functions 2")
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, GustOfWind_BenchCheck
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, GustOfWind_PlayerSelection
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, GustOfWind_SwitchEffect
	db $00
