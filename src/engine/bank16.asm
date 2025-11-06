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

EkansLv10SpitPoisonEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, EkansLv10SpitPoison_BeforeDamage
	dbw EFFECTCMDTYPE_AI, EkansLv10SpitPoison_AI
	db $00

EkansLv10WrapEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, EkansLv10Wrap_BeforeDamage
	db $00

ArbokLv27TerrorStrikeEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, ArbokLv27TerrorStrike_InitialEffect1
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, ArbokLv27TerrorStrike_AfterDamage
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, ArbokLv27TerrorStrike_RequireSelection
	dbw EFFECTCMDTYPE_AI_SWITCH_DEFENDING_PKMN, ArbokLv27TerrorStrike_RequireSelection
	db $00

ArbokLv27PoisonFangEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, ArbokLv27PoisonFang_BeforeDamage
	dbw EFFECTCMDTYPE_AI, ArbokLv27PoisonFang_AI
	db $00

WeepinbellLv28PoisonPowderEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, WeepinbellLv28PoisonPowder_BeforeDamage
	dbw EFFECTCMDTYPE_AI, WeepinbellLv28PoisonPowder_AI
	db $00

VictreebelLureEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, VictreebelLure_InitialEffect1
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, VictreebelLure_AfterDamage
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, VictreebelLure_RequireSelection
	dbw EFFECTCMDTYPE_AI_SELECTION, VictreebelLure_AISelection
	db $00

VictreebelAcidEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, VictreebelAcid_BeforeDamage
	db $00

PinsirLv24IrongripEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, PinsirLv24Irongrip_BeforeDamage
	db $00

CaterpieStringShotEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, CaterpieStringShot_BeforeDamage
	db $00

GloomPoisonPowderEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, GloomPoisonPowder_BeforeDamage
	dbw EFFECTCMDTYPE_AI, GloomPoisonPowder_AI
	db $00

GloomFoulOdorEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, GloomFoulOdor_BeforeDamage
	db $00

KakunaLv23StiffenEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, KakunaLv23Stiffen_BeforeDamage
	db $00

KakunaLv23PoisonPowderEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, KakunaLv23PoisonPowder_BeforeDamage
	dbw EFFECTCMDTYPE_AI, KakunaLv23PoisonPowder_AI
	db $00

GolbatLv29LeechLifeEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, GolbatLv29LeechLife_AfterDamage
	db $00

VenonatLv12StunSporeEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, VenonatLv12StunSpore_BeforeDamage
	db $00

VenonatLv12LeechLifeEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, VenonatLv12LeechLife_AfterDamage
	db $00

ScytherLv25SwordsDanceEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, ScytherLv25SwordsDance_BeforeDamage
	db $00

ZubatLv10SupersonicEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, ZubatLv10Supersonic_BeforeDamage
	db $00

ZubatLv10LeechLifeEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, ZubatLv10LeechLife_AfterDamage
	db $00

BeedrillTwineedleEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, BeedrillTwineedle_BeforeDamage
	dbw EFFECTCMDTYPE_AI, BeedrillTwineedle_AI
	db $00

BeedrillPoisonStingEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, BeedrillPoisonSting_BeforeDamage
	dbw EFFECTCMDTYPE_AI, BeedrillPoisonSting_AI
	db $00

ExeggcuteHypnosisMoveEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, ExeggcuteHypnosisMove_BeforeDamage
	db $00

ExeggcuteLeechSeedAltEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, ExeggcuteLeechSeedAlt_AfterDamage
	db $00

KoffingLv13FoulGasEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, KoffingLv13FoulGas_BeforeDamage
	dbw EFFECTCMDTYPE_AI, KoffingLv13FoulGas_AI
	db $00

MetapodLv21StiffenEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, MetapodLv21Stiffen_BeforeDamage
	db $00

MetapodLv21StunSporeEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, MetapodLv21StunSpore_BeforeDamage
	db $00

OddishLv8StunSporeEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, OddishLv8StunSpore_BeforeDamage
	db $00

OddishLv8SproutEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, OddishLv8Sprout_InitialEffect1
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, OddishLv8Sprout_AfterDamage
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, OddishLv8Sprout_RequireSelection
	dbw EFFECTCMDTYPE_AI_SELECTION, OddishLv8Sprout_AISelection
	db $00

ExeggutorTeleportEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, ExeggutorTeleport_InitialEffect1
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, ExeggutorTeleport_AfterDamage
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, ExeggutorTeleport_RequireSelection
	dbw EFFECTCMDTYPE_AI_SELECTION, ExeggutorTeleport_AISelection
	db $00

ExeggutorBigEggsplosionEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, ExeggutorBigEggsplosion_BeforeDamage
	dbw EFFECTCMDTYPE_AI, ExeggutorBigEggsplosion_AI
	db $00

NidokingThrashEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, NidokingThrash_BeforeDamage
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, NidokingThrash_AfterDamage
	dbw EFFECTCMDTYPE_AI, NidokingThrash_AI
	db $00

NidokingToxicEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, NidokingToxic_BeforeDamage
	dbw EFFECTCMDTYPE_AI, NidokingToxic_AI
	db $00

NidoqueenBoyfriendsEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, NidoqueenBoyfriends_BeforeDamage
	db $00

NidoranFLv13FurySwipesEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, NidoranFLv13FurySwipes_BeforeDamage
	dbw EFFECTCMDTYPE_AI, NidoranFLv13FurySwipes_AI
	db $00

NidoranFLv13CallForFamilyEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, NidoranFLv13CallForFamily_InitialEffect1
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, NidoranFLv13CallForFamily_AfterDamage
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, NidoranFLv13CallForFamily_RequireSelection
	dbw EFFECTCMDTYPE_AI_SELECTION, NidoranFLv13CallForFamily_AISelection
	db $00

NidoranMLv20HornHazardEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, NidoranMLv20HornHazard_BeforeDamage
	dbw EFFECTCMDTYPE_AI, NidoranMLv20HornHazard_AI
	db $00

NidorinaLv24SupersonicEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, NidorinaLv24Supersonic_BeforeDamage
	db $00

NidorinaLv24DoubleKickEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, NidorinaLv24DoubleKick_BeforeDamage
	dbw EFFECTCMDTYPE_AI, NidorinaLv24DoubleKick_AI
	db $00

NidorinoLv25DoubleKickEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, NidorinoLv25DoubleKick_BeforeDamage
	dbw EFFECTCMDTYPE_AI, NidorinoLv25DoubleKick_AI
	db $00

ButterfreeWhirlwindEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, ButterfreeWhirlwind_AfterDamage
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, ButterfreeWhirlwind_RequireSelection
	dbw EFFECTCMDTYPE_AI_SWITCH_DEFENDING_PKMN, ButterfreeWhirlwind_RequireSelection
	db $00

ButterfreeMegaDrainEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, ButterfreeMegaDrain_AfterDamage
	db $00

ParasLv8SporeEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, ParasLv8Spore_BeforeDamage
	db $00

ParasectLv28SporeEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, ParasectLv28Spore_BeforeDamage
	db $00

WeedleLv12PoisonStingEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, WeedleLv12PoisonSting_BeforeDamage
	dbw EFFECTCMDTYPE_AI, WeedleLv12PoisonSting_AI
	db $00

IvysaurLv20PoisonPowderEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, IvysaurLv20PoisonPowder_BeforeDamage
	dbw EFFECTCMDTYPE_AI, IvysaurLv20PoisonPowder_AI
	db $00

BulbasaurLv13LeechSeedEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, BulbasaurLv13LeechSeed_AfterDamage
	db $00

VenusaurLv67EnergyTransEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, VenusaurLv67EnergyTrans_InitialEffect2
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, VenusaurLv67EnergyTrans_BeforeDamage
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, VenusaurLv67EnergyTrans_RequireSelection
	dbw EFFECTCMDTYPE_UNK_11, VenusaurLv67EnergyTrans_Unk11
	db $00

VenusaurAltLv67EnergyTransEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, VenusaurAltLv67EnergyTrans_InitialEffect2
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, VenusaurAltLv67EnergyTrans_BeforeDamage
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, VenusaurAltLv67EnergyTrans_RequireSelection
	dbw EFFECTCMDTYPE_UNK_11, VenusaurAltLv67EnergyTrans_Unk11
	db $00

GrimerLv17NastyGooEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, GrimerLv17NastyGoo_BeforeDamage
	db $00

GrimerLv17MinimizeEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, GrimerLv17Minimize_BeforeDamage
	db $00

MukToxicGasEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, MukToxicGas_InitialEffect1
	db $00

MukSludgeMoveEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, MukSludgeMove_BeforeDamage
	dbw EFFECTCMDTYPE_AI, MukSludgeMove_AI
	db $00

BellsproutLv11CallForFamilyEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, BellsproutLv11CallForFamily_InitialEffect1
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, BellsproutLv11CallForFamily_AfterDamage
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, BellsproutLv11CallForFamily_RequireSelection
	dbw EFFECTCMDTYPE_AI_SELECTION, BellsproutLv11CallForFamily_AISelection
	db $00

WeezingLv27SmogEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, WeezingLv27Smog_BeforeDamage
	dbw EFFECTCMDTYPE_AI, WeezingLv27Smog_AI
	db $00

WeezingLv27SelfdestructEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, WeezingLv27Selfdestruct_AfterDamage
	db $00

VenomothLv28ShiftEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, VenomothLv28Shift_InitialEffect2
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, VenomothLv28Shift_BeforeDamage
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, VenomothLv28Shift_RequireSelection
	db $00

VenomothLv28VenomPowderEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, VenomothLv28VenomPowder_BeforeDamage
	dbw EFFECTCMDTYPE_AI, VenomothLv28VenomPowder_AI
	db $00

TangelaLv8BindEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, TangelaLv8Bind_BeforeDamage
	db $00

TangelaLv8PoisonPowderEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, TangelaLv8PoisonPowder_BeforeDamage
	dbw EFFECTCMDTYPE_AI, TangelaLv8PoisonPowder_AI
	db $00

VileplumeHealEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, VileplumeHeal_InitialEffect2
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, VileplumeHeal_BeforeDamage
	db $00

VileplumePetalDanceEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, VileplumePetalDance_BeforeDamage
	dbw EFFECTCMDTYPE_AI, VileplumePetalDance_AI
	db $00

TangelaLv12StunSporeEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, TangelaLv12StunSpore_BeforeDamage
	db $00

TangelaLv12PoisonWhipEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, TangelaLv12PoisonWhip_BeforeDamage
	dbw EFFECTCMDTYPE_AI, TangelaLv12PoisonWhip_AI
	db $00

VenusaurLv64SolarPowerEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, VenusaurLv64SolarPower_InitialEffect2
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, VenusaurLv64SolarPower_BeforeDamage
	db $00

VenusaurLv64MegaDrainEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, VenusaurLv64MegaDrain_AfterDamage
	db $00

OmastarLv32WaterGunEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, OmastarLv32WaterGun_BeforeDamage
	dbw EFFECTCMDTYPE_AI, OmastarLv32WaterGun_BeforeDamage
	db $00

OmastarLv32SpikeCannonEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, OmastarLv32SpikeCannon_BeforeDamage
	dbw EFFECTCMDTYPE_AI, OmastarLv32SpikeCannon_AI
	db $00

OmanyteLv19ClairvoyanceEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, OmanyteLv19Clairvoyance_InitialEffect2
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, OmanyteLv19Clairvoyance_BeforeDamage
	db $00

OmanyteLv19WaterGunEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, OmanyteLv19WaterGun_BeforeDamage
	dbw EFFECTCMDTYPE_AI, OmanyteLv19WaterGun_BeforeDamage
	db $00

WartortleLv22WithdrawEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, WartortleLv22Withdraw_BeforeDamage
	db $00

BlastoiseLv52RainDanceEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, BlastoiseLv52RainDance_InitialEffect1
	db $00

BlastoiseLv52HydroPumpEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, BlastoiseLv52HydroPump_BeforeDamage
	dbw EFFECTCMDTYPE_AI, BlastoiseLv52HydroPump_BeforeDamage
	db $00

BlastoiseAltLv52RainDanceEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, BlastoiseAltLv52RainDance_InitialEffect1
	db $00

BlastoiseAltLv52HydroPumpEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, BlastoiseAltLv52HydroPump_BeforeDamage
	dbw EFFECTCMDTYPE_AI, BlastoiseAltLv52HydroPump_BeforeDamage
	db $00

GyaradosBubblebeamEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, GyaradosBubblebeam_BeforeDamage
	db $00

KinglerLv27FlailEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, KinglerLv27Flail_BeforeDamage
	dbw EFFECTCMDTYPE_AI, KinglerLv27Flail_AI
	db $00

KrabbyLv20CallForFamilyEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, KrabbyLv20CallForFamily_InitialEffect1
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, KrabbyLv20CallForFamily_AfterDamage
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, KrabbyLv20CallForFamily_RequireSelection
	dbw EFFECTCMDTYPE_AI_SELECTION, KrabbyLv20CallForFamily_AISelection
	db $00

MagikarpLv8FlailEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, MagikarpLv8Flail_BeforeDamage
	dbw EFFECTCMDTYPE_AI, MagikarpLv8Flail_AI
	db $00

PsyduckLv15HeadacheEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, PsyduckLv15Headache_BeforeDamage
	db $00

PsyduckLv15FurySwipesEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, PsyduckLv15FurySwipes_BeforeDamage
	dbw EFFECTCMDTYPE_AI, PsyduckLv15FurySwipes_AI
	db $00

GolduckLv27PsyshockEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, GolduckLv27Psyshock_BeforeDamage
	db $00

GolduckLv27HyperBeamEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, GolduckLv27HyperBeam_AfterDamage
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, GolduckLv27HyperBeam_RequireSelection
	dbw EFFECTCMDTYPE_AI_SELECTION, GolduckLv27HyperBeam_AISelection
	db $00

SeadraLv23WaterGunEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, SeadraLv23WaterGun_BeforeDamage
	dbw EFFECTCMDTYPE_AI, SeadraLv23WaterGun_BeforeDamage
	db $00

SeadraLv23AgilityEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, SeadraLv23Agility_BeforeDamage
	db $00

ShellderLv8SupersonicEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, ShellderLv8Supersonic_BeforeDamage
	db $00

ShellderLv8HideInShellEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, ShellderLv8HideInShell_BeforeDamage
	db $00

VaporeonLv42QuickAttackEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, VaporeonLv42QuickAttack_BeforeDamage
	dbw EFFECTCMDTYPE_AI, VaporeonLv42QuickAttack_AI
	db $00

VaporeonLv42WaterGunEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, VaporeonLv42WaterGun_BeforeDamage
	dbw EFFECTCMDTYPE_AI, VaporeonLv42WaterGun_BeforeDamage
	db $00

DewgongLv42IceBeamEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, DewgongLv42IceBeam_BeforeDamage
	db $00

StarmieRecoverEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, StarmieRecover_InitialEffect1
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, StarmieRecover_InitialEffect2
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, StarmieRecover_AfterDamage
	dbw EFFECTCMDTYPE_DISCARD_ENERGY, StarmieRecover_DiscardEnergy
	dbw EFFECTCMDTYPE_AI_SELECTION, StarmieRecover_AISelection
	db $00

StarmieStarFreezeEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, StarmieStarFreeze_BeforeDamage
	db $00

SquirtleLv8BubbleEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, SquirtleLv8Bubble_BeforeDamage
	db $00

SquirtleLv8WithdrawEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, SquirtleLv8Withdraw_BeforeDamage
	db $00

HorseaLv19SmokescreenEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, HorseaLv19Smokescreen_BeforeDamage
	db $00

TentacruelSupersonicEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, TentacruelSupersonic_BeforeDamage
	db $00

TentacruelJellyfishStingEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, TentacruelJellyfishSting_BeforeDamage
	dbw EFFECTCMDTYPE_AI, TentacruelJellyfishSting_AI
	db $00

PoliwhirlLv28AmnesiaEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, PoliwhirlLv28Amnesia_InitialEffect1
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, PoliwhirlLv28Amnesia_InitialEffect2
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, PoliwhirlLv28Amnesia_BeforeDamage
	dbw EFFECTCMDTYPE_AI_SELECTION, PoliwhirlLv28Amnesia_AISelection
	db $00

PoliwhirlLv28DoubleSlapEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, PoliwhirlLv28DoubleSlap_BeforeDamage
	dbw EFFECTCMDTYPE_AI, PoliwhirlLv28DoubleSlap_AI
	db $00

PoliwrathLv48WaterGunEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, PoliwrathLv48WaterGun_BeforeDamage
	dbw EFFECTCMDTYPE_AI, PoliwrathLv48WaterGun_BeforeDamage
	db $00

PoliwrathLv48WhirlpoolEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, PoliwrathLv48Whirlpool_AfterDamage
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, PoliwrathLv48Whirlpool_RequireSelection
	dbw EFFECTCMDTYPE_AI_SELECTION, PoliwrathLv48Whirlpool_AISelection
	db $00

PoliwagLv13WaterGunEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, PoliwagLv13WaterGun_BeforeDamage
	dbw EFFECTCMDTYPE_AI, PoliwagLv13WaterGun_BeforeDamage
	db $00

CloysterClampEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, CloysterClamp_BeforeDamage
	dbw EFFECTCMDTYPE_AI, CloysterClamp_AI
	db $00

CloysterSpikeCannonEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, CloysterSpikeCannon_BeforeDamage
	dbw EFFECTCMDTYPE_AI, CloysterSpikeCannon_AI
	db $00

ArticunoLv35FreezeDryEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, ArticunoLv35FreezeDry_BeforeDamage
	db $00

ArticunoLv35BlizzardEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, ArticunoLv35Blizzard_BeforeDamage
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, ArticunoLv35Blizzard_AfterDamage
	db $00

TentacoolCowardiceEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, TentacoolCowardice_InitialEffect2
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, TentacoolCowardice_BeforeDamage
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, TentacoolCowardice_RequireSelection
	db $00

LaprasLv31WaterGunEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, LaprasLv31WaterGun_BeforeDamage
	dbw EFFECTCMDTYPE_AI, LaprasLv31WaterGun_BeforeDamage
	db $00

LaprasLv31ConfuseRayEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, LaprasLv31ConfuseRay_BeforeDamage
	db $00

ArticunoLv37QuickfreezeEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, ArticunoLv37Quickfreeze_InitialEffect1
	dbw EFFECTCMDTYPE_PKMN_POWER_TRIGGER, ArticunoLv37Quickfreeze_PkmnPowerTrigger
	db $00

ArticunoLv37IceBreathEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, ArticunoLv37IceBreath_BeforeDamage
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, ArticunoLv37IceBreath_AfterDamage
	db $00

VaporeonLv29FocusEnergyEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, VaporeonLv29FocusEnergy_BeforeDamage
	db $00

ArcanineLv45FlamethrowerEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, ArcanineLv45Flamethrower_InitialEffect1
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, ArcanineLv45Flamethrower_InitialEffect2
	dbw EFFECTCMDTYPE_DISCARD_ENERGY, ArcanineLv45Flamethrower_DiscardEnergy
	dbw EFFECTCMDTYPE_AI_SELECTION, ArcanineLv45Flamethrower_AISelection
	db $00

ArcanineLv45TakeDownEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, ArcanineLv45TakeDown_AfterDamage
	db $00

ArcanineLv34QuickAttackEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, ArcanineLv34QuickAttack_BeforeDamage
	dbw EFFECTCMDTYPE_AI, ArcanineLv34QuickAttack_AI
	db $00

ArcanineLv34FlamesOfRageEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, ArcanineLv34FlamesOfRage_InitialEffect1
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, ArcanineLv34FlamesOfRage_InitialEffect2
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, ArcanineLv34FlamesOfRage_BeforeDamage
	dbw EFFECTCMDTYPE_DISCARD_ENERGY, ArcanineLv34FlamesOfRage_DiscardEnergy
	dbw EFFECTCMDTYPE_AI_SELECTION, ArcanineLv34FlamesOfRage_AISelection
	dbw EFFECTCMDTYPE_AI, ArcanineLv34FlamesOfRage_AI
	db $00

RapidashLv33StompEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, RapidashLv33Stomp_BeforeDamage
	dbw EFFECTCMDTYPE_AI, RapidashLv33Stomp_AI
	db $00

RapidashLv33AgilityEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, RapidashLv33Agility_BeforeDamage
	db $00

NinetalesLv32LureAltEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, NinetalesLv32LureAlt_InitialEffect1
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, NinetalesLv32LureAlt_AfterDamage
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, NinetalesLv32LureAlt_RequireSelection
	dbw EFFECTCMDTYPE_AI_SELECTION, NinetalesLv32LureAlt_AISelection
	db $00

NinetalesLv32FireBlastEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, NinetalesLv32FireBlast_InitialEffect1
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, NinetalesLv32FireBlast_InitialEffect2
	dbw EFFECTCMDTYPE_DISCARD_ENERGY, NinetalesLv32FireBlast_DiscardEnergy
	dbw EFFECTCMDTYPE_AI_SELECTION, NinetalesLv32FireBlast_AISelection
	db $00

CharmanderLv10EmberEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, CharmanderLv10Ember_InitialEffect1
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, CharmanderLv10Ember_InitialEffect2
	dbw EFFECTCMDTYPE_DISCARD_ENERGY, CharmanderLv10Ember_DiscardEnergy
	dbw EFFECTCMDTYPE_AI_SELECTION, CharmanderLv10Ember_AISelection
	db $00

MoltresLv35WildfireEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, MoltresLv35Wildfire_InitialEffect1
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, MoltresLv35Wildfire_InitialEffect2
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, MoltresLv35Wildfire_AfterDamage
	dbw EFFECTCMDTYPE_DISCARD_ENERGY, MoltresLv35Wildfire_DiscardEnergy
	dbw EFFECTCMDTYPE_AI_SELECTION, MoltresLv35Wildfire_AISelection
	db $00

MoltresLv35DiveBombEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, MoltresLv35DiveBomb_BeforeDamage
	dbw EFFECTCMDTYPE_AI, MoltresLv35DiveBomb_AI
	db $00

FlareonLv28QuickAttackEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, FlareonLv28QuickAttack_BeforeDamage
	dbw EFFECTCMDTYPE_AI, FlareonLv28QuickAttack_AI
	db $00

FlareonLv28FlamethrowerEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, FlareonLv28Flamethrower_InitialEffect1
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, FlareonLv28Flamethrower_InitialEffect2
	dbw EFFECTCMDTYPE_DISCARD_ENERGY, FlareonLv28Flamethrower_DiscardEnergy
	dbw EFFECTCMDTYPE_AI_SELECTION, FlareonLv28Flamethrower_AISelection
	db $00

MagmarLv24FlamethrowerEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, MagmarLv24Flamethrower_InitialEffect1
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, MagmarLv24Flamethrower_InitialEffect2
	dbw EFFECTCMDTYPE_DISCARD_ENERGY, MagmarLv24Flamethrower_DiscardEnergy
	dbw EFFECTCMDTYPE_AI_SELECTION, MagmarLv24Flamethrower_AISelection
	db $00

MagmarLv31SmokescreenEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, MagmarLv31Smokescreen_BeforeDamage
	db $00

MagmarLv31SmogEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, MagmarLv31Smog_BeforeDamage
	dbw EFFECTCMDTYPE_AI, MagmarLv31Smog_AI
	db $00

CharmeleonFlamethrowerEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, CharmeleonFlamethrower_InitialEffect1
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, CharmeleonFlamethrower_InitialEffect2
	dbw EFFECTCMDTYPE_DISCARD_ENERGY, CharmeleonFlamethrower_DiscardEnergy
	dbw EFFECTCMDTYPE_AI_SELECTION, CharmeleonFlamethrower_AISelection
	db $00

CharizardLv76EnergyBurnEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, CharizardLv76EnergyBurn_InitialEffect1
	db $00

CharizardLv76FireSpinEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, CharizardLv76FireSpin_InitialEffect1
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, CharizardLv76FireSpin_InitialEffect2
	dbw EFFECTCMDTYPE_DISCARD_ENERGY, CharizardLv76FireSpin_DiscardEnergy
	dbw EFFECTCMDTYPE_AI_SELECTION, CharizardLv76FireSpin_AISelection
	db $00

CharizardAltLv76EnergyBurnEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, CharizardAltLv76EnergyBurn_InitialEffect1
	db $00

CharizardAltLv76FireSpinEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, CharizardAltLv76FireSpin_InitialEffect1
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, CharizardAltLv76FireSpin_InitialEffect2
	dbw EFFECTCMDTYPE_DISCARD_ENERGY, CharizardAltLv76FireSpin_DiscardEnergy
	dbw EFFECTCMDTYPE_AI_SELECTION, CharizardAltLv76FireSpin_AISelection
	db $00

VulpixLv11ConfuseRayEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, VulpixLv11ConfuseRay_BeforeDamage
	db $00

FlareonLv22RageEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, FlareonLv22Rage_BeforeDamage
	dbw EFFECTCMDTYPE_AI, FlareonLv22Rage_AI
	db $00

NinetalesLv35MixUpEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, NinetalesLv35MixUp_InitialEffect1
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, NinetalesLv35MixUp_AfterDamage
	db $00

NinetalesLv35DancingEmbersEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, NinetalesLv35DancingEmbers_BeforeDamage
	dbw EFFECTCMDTYPE_AI, NinetalesLv35DancingEmbers_AI
	db $00

MoltresLv40FiregiverEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, MoltresLv40Firegiver_InitialEffect1
	dbw EFFECTCMDTYPE_PKMN_POWER_TRIGGER, MoltresLv40Firegiver_PkmnPowerTrigger
	db $00

MoltresLv40DiveBombEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, MoltresLv40DiveBomb_BeforeDamage
	dbw EFFECTCMDTYPE_AI, MoltresLv40DiveBomb_AI
	db $00

AbraLv10PsyshockEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, AbraLv10Psyshock_BeforeDamage
	db $00

GengarLv38CurseEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, GengarLv38Curse_InitialEffect2
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, GengarLv38Curse_BeforeDamage
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, GengarLv38Curse_RequireSelection
	db $00

GengarLv38DarkMindEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, GengarLv38DarkMind_AfterDamage
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, GengarLv38DarkMind_RequireSelection
	dbw EFFECTCMDTYPE_AI_SELECTION, GengarLv38DarkMind_AISelection
	db $00

GastlyLv8SleepingGasEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, GastlyLv8SleepingGas_BeforeDamage
	db $00

GastlyLv8DestinyBondEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, GastlyLv8DestinyBond_InitialEffect1
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, GastlyLv8DestinyBond_InitialEffect2
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, GastlyLv8DestinyBond_BeforeDamage
	dbw EFFECTCMDTYPE_DISCARD_ENERGY, GastlyLv8DestinyBond_DiscardEnergy
	dbw EFFECTCMDTYPE_AI_SELECTION, GastlyLv8DestinyBond_AISelection
	db $00

GastlyLv17LickEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, GastlyLv17Lick_BeforeDamage
	db $00

GastlyLv17EnergyConversionEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, GastlyLv17EnergyConversion_InitialEffect1
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, GastlyLv17EnergyConversion_AfterDamage
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, GastlyLv17EnergyConversion_RequireSelection
	dbw EFFECTCMDTYPE_AI_SELECTION, GastlyLv17EnergyConversion_AISelection
	db $00

HaunterLv22HypnosisMoveEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, HaunterLv22HypnosisMove_BeforeDamage
	db $00

HaunterLv22DreamEaterEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, HaunterLv22DreamEater_InitialEffect1
	db $00

HaunterLv17TransparencyEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, HaunterLv17Transparency_InitialEffect1
	db $00

HaunterLv17NightmareEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, HaunterLv17Nightmare_BeforeDamage
	db $00

HypnoLv36ProphecyEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, HypnoLv36Prophecy_InitialEffect1
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, HypnoLv36Prophecy_AfterDamage
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, HypnoLv36Prophecy_RequireSelection
	dbw EFFECTCMDTYPE_AI_SELECTION, HypnoLv36Prophecy_AISelection
	db $00

HypnoLv36DarkMindEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, HypnoLv36DarkMind_AfterDamage
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, HypnoLv36DarkMind_RequireSelection
	dbw EFFECTCMDTYPE_AI_SELECTION, HypnoLv36DarkMind_AISelection
	db $00

DrowzeeLv12ConfuseRayEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, DrowzeeLv12ConfuseRay_BeforeDamage
	db $00

MrMimeLv28InvisibleWallEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, MrMimeLv28InvisibleWall_InitialEffect1
	db $00

MrMimeLv28MeditateEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, MrMimeLv28Meditate_BeforeDamage
	dbw EFFECTCMDTYPE_AI, MrMimeLv28Meditate_BeforeDamage
	db $00

AlakazamLv42DamageSwapEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, AlakazamLv42DamageSwap_InitialEffect2
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, AlakazamLv42DamageSwap_BeforeDamage
	dbw EFFECTCMDTYPE_UNK_11, AlakazamLv42DamageSwap_Unk11
	db $00

AlakazamLv42ConfuseRayEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, AlakazamLv42ConfuseRay_BeforeDamage
	db $00

MewLv23PsywaveEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, MewLv23Psywave_BeforeDamage
	dbw EFFECTCMDTYPE_AI, MewLv23Psywave_AI
	db $00

MewLv23DevolutionBeamEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, MewLv23DevolutionBeam_InitialEffect1
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, MewLv23DevolutionBeam_InitialEffect2
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, MewLv23DevolutionBeam_BeforeDamage
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, MewLv23DevolutionBeam_AfterDamage
	dbw EFFECTCMDTYPE_AI_SELECTION, MewLv23DevolutionBeam_AISelection
	db $00

MewLv8NeutralShieldEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, MewLv8NeutralShield_InitialEffect1
	db $00

MewLv8PsyshockEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, MewLv8Psyshock_BeforeDamage
	db $00

MewtwoLv53PsychicEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, MewtwoLv53Psychic_BeforeDamage
	dbw EFFECTCMDTYPE_AI, MewtwoLv53Psychic_AI
	db $00

MewtwoLv53BarrierEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, MewtwoLv53Barrier_InitialEffect1
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, MewtwoLv53Barrier_InitialEffect2
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, MewtwoLv53Barrier_BeforeDamage
	dbw EFFECTCMDTYPE_DISCARD_ENERGY, MewtwoLv53Barrier_DiscardEnergy
	dbw EFFECTCMDTYPE_AI_SELECTION, MewtwoLv53Barrier_AISelection
	db $00

MewtwoAltLv60EnergyAbsorptionEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, MewtwoAltLv60EnergyAbsorption_InitialEffect1
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, MewtwoAltLv60EnergyAbsorption_AfterDamage
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, MewtwoAltLv60EnergyAbsorption_RequireSelection
	dbw EFFECTCMDTYPE_AI_SELECTION, MewtwoAltLv60EnergyAbsorption_AISelection
	db $00

MewtwoLv60EnergyAbsorptionEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, MewtwoLv60EnergyAbsorption_InitialEffect1
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, MewtwoLv60EnergyAbsorption_AfterDamage
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, MewtwoLv60EnergyAbsorption_RequireSelection
	dbw EFFECTCMDTYPE_AI_SELECTION, MewtwoLv60EnergyAbsorption_AISelection
	db $00

SlowbroLv26StrangeBehaviorEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, SlowbroLv26StrangeBehavior_InitialEffect2
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, SlowbroLv26StrangeBehavior_BeforeDamage
	dbw EFFECTCMDTYPE_UNK_11, SlowbroLv26StrangeBehavior_Unk11
	db $00

SlowbroLv26PsyshockEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, SlowbroLv26Psyshock_BeforeDamage
	db $00

SlowpokeLv18SpacingOutEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, SlowpokeLv18SpacingOut_InitialEffect1
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, SlowpokeLv18SpacingOut_BeforeDamage
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, SlowpokeLv18SpacingOut_AfterDamage
	db $00

SlowpokeLv18ScavengeEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, SlowpokeLv18Scavenge_InitialEffect1
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, SlowpokeLv18Scavenge_InitialEffect2
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, SlowpokeLv18Scavenge_AfterDamage
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, SlowpokeLv18Scavenge_RequireSelection
	dbw EFFECTCMDTYPE_DISCARD_ENERGY, SlowpokeLv18Scavenge_DiscardEnergy
	dbw EFFECTCMDTYPE_AI_SELECTION, SlowpokeLv18Scavenge_AISelection
	db $00

SlowpokeLv9AmnesiaEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, SlowpokeLv9Amnesia_InitialEffect1
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, SlowpokeLv9Amnesia_InitialEffect2
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, SlowpokeLv9Amnesia_BeforeDamage
	dbw EFFECTCMDTYPE_AI_SELECTION, SlowpokeLv9Amnesia_AISelection
	db $00

KadabraLv38RecoverEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, KadabraLv38Recover_InitialEffect1
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, KadabraLv38Recover_InitialEffect2
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, KadabraLv38Recover_AfterDamage
	dbw EFFECTCMDTYPE_DISCARD_ENERGY, KadabraLv38Recover_DiscardEnergy
	dbw EFFECTCMDTYPE_AI_SELECTION, KadabraLv38Recover_AISelection
	db $00

JynxLv23DoubleSlapEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, JynxLv23DoubleSlap_BeforeDamage
	dbw EFFECTCMDTYPE_AI, JynxLv23DoubleSlap_AI
	db $00

JynxLv23MeditateEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, JynxLv23Meditate_BeforeDamage
	dbw EFFECTCMDTYPE_AI, JynxLv23Meditate_BeforeDamage
	db $00

MewLv15MysteryAttackEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, MewLv15MysteryAttack_BeforeDamage
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, MewLv15MysteryAttack_AfterDamage
	dbw EFFECTCMDTYPE_AI, MewLv15MysteryAttack_AI
	db $00

GeodudeLv16StoneBarrageEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, GeodudeLv16StoneBarrage_BeforeDamage
	dbw EFFECTCMDTYPE_AI, GeodudeLv16StoneBarrage_AI
	db $00

OnixLv12HardenEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, OnixLv12Harden_BeforeDamage
	db $00

PrimeapeFurySwipesEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, PrimeapeFurySwipes_BeforeDamage
	dbw EFFECTCMDTYPE_AI, PrimeapeFurySwipes_AI
	db $00

PrimeapeTantrumEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, PrimeapeTantrum_BeforeDamage
	db $00

MachampLv67StrikesBackEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, MachampLv67StrikesBack_InitialEffect1
	db $00

KabutoLv9KabutoArmorEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, KabutoLv9KabutoArmor_InitialEffect1
	db $00

KabutopsAbsorbEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, KabutopsAbsorb_AfterDamage
	db $00

CuboneLv13SnivelEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, CuboneLv13Snivel_BeforeDamage
	db $00

CuboneLv13RageEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, CuboneLv13Rage_BeforeDamage
	dbw EFFECTCMDTYPE_AI, CuboneLv13Rage_AI
	db $00

MarowakLv26BonemerangEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, MarowakLv26Bonemerang_BeforeDamage
	dbw EFFECTCMDTYPE_AI, MarowakLv26Bonemerang_AI
	db $00

MarowakLv26CallForFriendEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, MarowakLv26CallForFriend_InitialEffect1
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, MarowakLv26CallForFriend_AfterDamage
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, MarowakLv26CallForFriend_RequireSelection
	dbw EFFECTCMDTYPE_AI_SELECTION, MarowakLv26CallForFriend_AISelection
	db $00

MachokeLv40KarateChopEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, MachokeLv40KarateChop_BeforeDamage
	dbw EFFECTCMDTYPE_AI, MachokeLv40KarateChop_AI
	db $00

MachokeLv40SubmissionEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, MachokeLv40Submission_AfterDamage
	db $00

GolemLv36SelfdestructEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, GolemLv36Selfdestruct_AfterDamage
	db $00

GravelerLv29HardenEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, GravelerLv29Harden_BeforeDamage
	db $00

RhydonLv48RamAltEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, RhydonLv48RamAlt_AfterDamage
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, RhydonLv48RamAlt_RequireSelection
	dbw EFFECTCMDTYPE_AI_SWITCH_DEFENDING_PKMN, RhydonLv48RamAlt_RequireSelection
	db $00

RhyhornLeerEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, RhyhornLeer_BeforeDamage
	db $00

HitmonleeLv30StretchKickEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, HitmonleeLv30StretchKick_InitialEffect1
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, HitmonleeLv30StretchKick_AfterDamage
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, HitmonleeLv30StretchKick_RequireSelection
	dbw EFFECTCMDTYPE_AI_SELECTION, HitmonleeLv30StretchKick_AISelection
	db $00

SandshrewLv12SandAttackEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, SandshrewLv12SandAttack_BeforeDamage
	db $00

SandslashLv33FurySwipesEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, SandslashLv33FurySwipes_BeforeDamage
	dbw EFFECTCMDTYPE_AI, SandslashLv33FurySwipes_AI
	db $00

DugtrioLv36EarthquakeEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, DugtrioLv36Earthquake_AfterDamage
	db $00

AerodactylLv28PrehistoricPowerEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, AerodactylLv28PrehistoricPower_InitialEffect1
	db $00

MankeyLv7PeekEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, MankeyLv7Peek_InitialEffect2
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, MankeyLv7Peek_BeforeDamage
	db $00

MarowakLv32BoneAttackEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, MarowakLv32BoneAttack_BeforeDamage
	db $00

MarowakLv32WailEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, MarowakLv32Wail_InitialEffect1
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, MarowakLv32Wail_AfterDamage
	db $00

ElectabuzzLv35ThundershockEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, ElectabuzzLv35Thundershock_BeforeDamage
	db $00

ElectabuzzLv35ThunderpunchEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, ElectabuzzLv35Thunderpunch_BeforeDamage
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, ElectabuzzLv35Thunderpunch_AfterDamage
	dbw EFFECTCMDTYPE_AI, ElectabuzzLv35Thunderpunch_AI
	db $00

ElectabuzzLv20LightScreenEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, ElectabuzzLv20LightScreen_BeforeDamage
	db $00

ElectabuzzLv20QuickAttackEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, ElectabuzzLv20QuickAttack_BeforeDamage
	dbw EFFECTCMDTYPE_AI, ElectabuzzLv20QuickAttack_AI
	db $00

MagnemiteLv13ThunderWaveEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, MagnemiteLv13ThunderWave_BeforeDamage
	db $00

MagnemiteLv13SelfdestructEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, MagnemiteLv13Selfdestruct_AfterDamage
	db $00

ZapdosLv64ThunderEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, ZapdosLv64Thunder_BeforeDamage
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, ZapdosLv64Thunder_AfterDamage
	db $00

ZapdosLv64ThunderboltEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, ZapdosLv64Thunderbolt_BeforeDamage
	db $00

ZapdosLv40ThunderstormEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, ZapdosLv40Thunderstorm_AfterDamage
	db $00

JolteonLv29QuickAttackEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, JolteonLv29QuickAttack_BeforeDamage
	dbw EFFECTCMDTYPE_AI, JolteonLv29QuickAttack_AI
	db $00

JolteonLv29PinMissileEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, JolteonLv29PinMissile_BeforeDamage
	dbw EFFECTCMDTYPE_AI, JolteonLv29PinMissile_AI
	db $00

FlyingPikachuLv12ThundershockEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, FlyingPikachuLv12Thundershock_BeforeDamage
	db $00

FlyingPikachuLv12FlyEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, FlyingPikachuLv12Fly_BeforeDamage
	dbw EFFECTCMDTYPE_AI, FlyingPikachuLv12Fly_AI
	db $00

FlyingPikachuAltLv12ThundershockEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, FlyingPikachuAltLv12Thundershock_BeforeDamage
	db $00

FlyingPikachuAltLv12FlyEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, FlyingPikachuAltLv12Fly_BeforeDamage
	dbw EFFECTCMDTYPE_AI, FlyingPikachuAltLv12Fly_AI
	db $00

PikachuLv12ThunderJoltEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, PikachuLv12ThunderJolt_BeforeDamage
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, PikachuLv12ThunderJolt_AfterDamage
	db $00

PikachuLv14SparkEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, PikachuLv14Spark_AfterDamage
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, PikachuLv14Spark_RequireSelection
	dbw EFFECTCMDTYPE_AI_SELECTION, PikachuLv14Spark_AISelection
	db $00

PikachuLv16GrowlEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, PikachuLv16Growl_BeforeDamage
	db $00

PikachuLv16ThundershockEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, PikachuLv16Thundershock_BeforeDamage
	db $00

PikachuAltLv16GrowlEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, PikachuAltLv16Growl_BeforeDamage
	db $00

PikachuAltLv16ThundershockEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, PikachuAltLv16Thundershock_BeforeDamage
	db $00

ElectrodeLv42ChainLightningEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, ElectrodeLv42ChainLightning_AfterDamage
	db $00

RaichuLv40AgilityEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, RaichuLv40Agility_BeforeDamage
	db $00

RaichuLv40ThunderEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, RaichuLv40Thunder_BeforeDamage
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, RaichuLv40Thunder_AfterDamage
	db $00

RaichuLv45GigashockEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, RaichuLv45Gigashock_AfterDamage
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, RaichuLv45Gigashock_RequireSelection
	dbw EFFECTCMDTYPE_AI_SELECTION, RaichuLv45Gigashock_AISelection
	db $00

MagnetonLv28ThunderWaveEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, MagnetonLv28ThunderWave_BeforeDamage
	db $00

MagnetonLv28SelfdestructEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, MagnetonLv28Selfdestruct_AfterDamage
	db $00

MagnetonLv35SonicboomEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, MagnetonLv35Sonicboom_BeforeDamage
	dbw EFFECTCMDTYPE_AI, MagnetonLv35Sonicboom_BeforeDamage
	db $00

MagnetonLv35SelfdestructEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, MagnetonLv35Selfdestruct_AfterDamage
	db $00

ZapdosLv68PealOfThunderEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, ZapdosLv68PealOfThunder_InitialEffect1
	dbw EFFECTCMDTYPE_PKMN_POWER_TRIGGER, ZapdosLv68PealOfThunder_PkmnPowerTrigger
	db $00

ZapdosLv68BigThunderEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, ZapdosLv68BigThunder_AfterDamage
	db $00

MagnemiteLv14MagneticStormEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, MagnemiteLv14MagneticStorm_AfterDamage
	db $00

ElectrodeLv35SonicboomEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, ElectrodeLv35Sonicboom_BeforeDamage
	dbw EFFECTCMDTYPE_AI, ElectrodeLv35Sonicboom_BeforeDamage
	db $00

ElectrodeLv35EnergySpikeEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, ElectrodeLv35EnergySpike_InitialEffect1
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, ElectrodeLv35EnergySpike_AfterDamage
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, ElectrodeLv35EnergySpike_RequireSelection
	dbw EFFECTCMDTYPE_AI_SELECTION, ElectrodeLv35EnergySpike_AISelection
	db $00

JolteonLv24DoubleKickEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, JolteonLv24DoubleKick_BeforeDamage
	dbw EFFECTCMDTYPE_AI, JolteonLv24DoubleKick_AI
	db $00

JolteonLv24StunNeedleEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, JolteonLv24StunNeedle_BeforeDamage
	db $00

EeveeLv12TailWhipEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, EeveeLv12TailWhip_BeforeDamage
	db $00

EeveeLv12QuickAttackEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, EeveeLv12QuickAttack_BeforeDamage
	dbw EFFECTCMDTYPE_AI, EeveeLv12QuickAttack_AI
	db $00

SpearowLv13MirrorMoveEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, SpearowLv13MirrorMove_InitialEffect1
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, SpearowLv13MirrorMove_InitialEffect2
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, SpearowLv13MirrorMove_BeforeDamage
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, SpearowLv13MirrorMove_AfterDamage
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, SpearowLv13MirrorMove_RequireSelection
	dbw EFFECTCMDTYPE_AI_SELECTION, SpearowLv13MirrorMove_AISelection
	dbw EFFECTCMDTYPE_AI, SpearowLv13MirrorMove_AI
	dbw EFFECTCMDTYPE_AI_SWITCH_DEFENDING_PKMN, SpearowLv13MirrorMove_AISwitchDefendingPkmn
	db $00

FearowLv27AgilityEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, FearowLv27Agility_BeforeDamage
	db $00

DragoniteLv45StepInEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, DragoniteLv45StepIn_InitialEffect2
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, DragoniteLv45StepIn_BeforeDamage
	db $00

DragoniteLv45SlamEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, DragoniteLv45Slam_BeforeDamage
	dbw EFFECTCMDTYPE_AI, DragoniteLv45Slam_AI
	db $00

SnorlaxLv20ThickSkinnedEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, SnorlaxLv20ThickSkinned_InitialEffect1
	db $00

SnorlaxLv20BodySlamEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, SnorlaxLv20BodySlam_BeforeDamage
	db $00

FarfetchdLv20LeekSlapEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, FarfetchdLv20LeekSlap_InitialEffect1
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, FarfetchdLv20LeekSlap_BeforeDamage
	dbw EFFECTCMDTYPE_DISCARD_ENERGY, FarfetchdLv20LeekSlap_DiscardEnergy
	dbw EFFECTCMDTYPE_AI, FarfetchdLv20LeekSlap_AI
	db $00

KangaskhanLv40FetchEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, KangaskhanLv40Fetch_InitialEffect1
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, KangaskhanLv40Fetch_AfterDamage
	db $00

KangaskhanLv40CometPunchEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, KangaskhanLv40CometPunch_BeforeDamage
	dbw EFFECTCMDTYPE_AI, KangaskhanLv40CometPunch_AI
	db $00

TaurosLv32StompEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, TaurosLv32Stomp_BeforeDamage
	dbw EFFECTCMDTYPE_AI, TaurosLv32Stomp_AI
	db $00

TaurosLv32RampageEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, TaurosLv32Rampage_BeforeDamage
	dbw EFFECTCMDTYPE_AI, TaurosLv32Rampage_AI
	db $00

DoduoLv10FuryAttackEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, DoduoLv10FuryAttack_BeforeDamage
	dbw EFFECTCMDTYPE_AI, DoduoLv10FuryAttack_AI
	db $00

DodrioLv28RetreatAidEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, DodrioLv28RetreatAid_InitialEffect1
	db $00

DodrioLv28RageEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, DodrioLv28Rage_BeforeDamage
	dbw EFFECTCMDTYPE_AI, DodrioLv28Rage_AI
	db $00

MeowthLv15PayDayEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, MeowthLv15PayDay_AfterDamage
	db $00

DragonairSlamEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, DragonairSlam_BeforeDamage
	dbw EFFECTCMDTYPE_AI, DragonairSlam_AI
	db $00

DragonairHyperBeamEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, DragonairHyperBeam_AfterDamage
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, DragonairHyperBeam_RequireSelection
	dbw EFFECTCMDTYPE_AI_SELECTION, DragonairHyperBeam_AISelection
	db $00

ClefableMetronomeEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, ClefableMetronome_InitialEffect1
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, ClefableMetronome_InitialEffect2
	dbw EFFECTCMDTYPE_AI_SELECTION, ClefableMetronome_AISelection
	db $00

ClefableMinimizeEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, ClefableMinimize_BeforeDamage
	db $00

PidgeotLv40HurricaneEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, PidgeotLv40Hurricane_AfterDamage
	db $00

PidgeottoLv36WhirlwindEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, PidgeottoLv36Whirlwind_AfterDamage
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, PidgeottoLv36Whirlwind_RequireSelection
	dbw EFFECTCMDTYPE_AI_SWITCH_DEFENDING_PKMN, PidgeottoLv36Whirlwind_RequireSelection
	db $00

PidgeottoLv36MirrorMoveEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, PidgeottoLv36MirrorMove_InitialEffect1
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, PidgeottoLv36MirrorMove_InitialEffect2
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, PidgeottoLv36MirrorMove_BeforeDamage
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, PidgeottoLv36MirrorMove_AfterDamage
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, PidgeottoLv36MirrorMove_RequireSelection
	dbw EFFECTCMDTYPE_AI_SELECTION, PidgeottoLv36MirrorMove_AISelection
	dbw EFFECTCMDTYPE_AI, PidgeottoLv36MirrorMove_AI
	dbw EFFECTCMDTYPE_AI_SWITCH_DEFENDING_PKMN, PidgeottoLv36MirrorMove_AISwitchDefendingPkmn
	db $00

ClefairyLv14SingEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, ClefairyLv14Sing_BeforeDamage
	db $00

ClefairyLv14MetronomeEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, ClefairyLv14Metronome_InitialEffect1
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, ClefairyLv14Metronome_InitialEffect2
	dbw EFFECTCMDTYPE_AI_SELECTION, ClefairyLv14Metronome_AISelection
	db $00

WigglytuffLv36LullabyEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, WigglytuffLv36Lullaby_BeforeDamage
	db $00

WigglytuffLv36DoTheWaveEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, WigglytuffLv36DoTheWave_BeforeDamage
	dbw EFFECTCMDTYPE_AI, WigglytuffLv36DoTheWave_BeforeDamage
	db $00

JigglypuffLv14LullabyEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, JigglypuffLv14Lullaby_BeforeDamage
	db $00

JigglypuffLv12FirstAidEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, JigglypuffLv12FirstAid_InitialEffect1
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, JigglypuffLv12FirstAid_AfterDamage
	db $00

JigglypuffLv12DoubleEdgeEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, JigglypuffLv12DoubleEdge_AfterDamage
	db $00

PersianPounceEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, PersianPounce_BeforeDamage
	db $00

LickitungLv26TongueWrapEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, LickitungLv26TongueWrap_BeforeDamage
	db $00

LickitungLv26SupersonicEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, LickitungLv26Supersonic_BeforeDamage
	db $00

PidgeyLv8WhirlwindEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, PidgeyLv8Whirlwind_AfterDamage
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, PidgeyLv8Whirlwind_RequireSelection
	dbw EFFECTCMDTYPE_AI_SWITCH_DEFENDING_PKMN, PidgeyLv8Whirlwind_RequireSelection
	db $00

PorygonLv12Conversion1EffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, PorygonLv12Conversion1_InitialEffect1
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, PorygonLv12Conversion1_InitialEffect2
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, PorygonLv12Conversion1_AfterDamage
	dbw EFFECTCMDTYPE_AI_SELECTION, PorygonLv12Conversion1_AISelection
	db $00

PorygonLv12Conversion2EffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, PorygonLv12Conversion2_InitialEffect1
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, PorygonLv12Conversion2_InitialEffect2
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, PorygonLv12Conversion2_AfterDamage
	dbw EFFECTCMDTYPE_AI_SELECTION, PorygonLv12Conversion2_AISelection
	db $00

ChanseyLv55ScrunchEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, ChanseyLv55Scrunch_BeforeDamage
	db $00

ChanseyLv55DoubleEdgeEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, ChanseyLv55DoubleEdge_AfterDamage
	db $00

RaticateSuperFangEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, RaticateSuperFang_BeforeDamage
	dbw EFFECTCMDTYPE_AI, RaticateSuperFang_BeforeDamage
	db $00

; unreferenced
EffectCommands_58896:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, EffectCommands_58896_InitialEffect2
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, EffectCommands_58896_BeforeDamage
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, EffectCommands_58896_RequireSelection
	db $00

DragoniteLv41HealingWindEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, DragoniteLv41HealingWind_InitialEffect1
	dbw EFFECTCMDTYPE_PKMN_POWER_TRIGGER, DragoniteLv41HealingWind_PkmnPowerTrigger
	db $00

DragoniteLv41SlamEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, DragoniteLv41Slam_BeforeDamage
	dbw EFFECTCMDTYPE_AI, DragoniteLv41Slam_AI
	db $00

MeowthLv13CatPunchEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, MeowthLv13CatPunch_AfterDamage
	db $00

DittoMorphEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, DittoMorph_InitialEffect1
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, DittoMorph_AfterDamage
	db $00

PidgeotLv38SlicingWingEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, PidgeotLv38SlicingWing_AfterDamage
	db $00

PidgeotLv38GaleEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, PidgeotLv38Gale_BeforeDamage
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, PidgeotLv38Gale_AfterDamage
	db $00

JigglypuffLv13FriendshipSongEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, JigglypuffLv13FriendshipSong_InitialEffect1
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, JigglypuffLv13FriendshipSong_AfterDamage
	db $00

JigglypuffLv13ExpandEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, JigglypuffLv13Expand_AfterDamage
	db $00

CharmanderLv9GatherFireEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, CharmanderLv9GatherFire_InitialEffect2
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, CharmanderLv9GatherFire_BeforeDamage
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, CharmanderLv9GatherFire_RequireSelection
	db $00

DarkCharmeleonFireballEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, DarkCharmeleonFireball_InitialEffect1
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, DarkCharmeleonFireball_BeforeDamage
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, DarkCharmeleonFireball_RequireSelection
	dbw EFFECTCMDTYPE_AI, DarkCharmeleonFireball_AI
	dbw EFFECTCMDTYPE_AI_SWITCH_DEFENDING_PKMN, DarkCharmeleonFireball_AISwitchDefendingPkmn
	db $00

DarkCharizardContinuousFireballEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, DarkCharizardContinuousFireball_InitialEffect1
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, DarkCharizardContinuousFireball_BeforeDamage
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, DarkCharizardContinuousFireball_RequireSelection
	dbw EFFECTCMDTYPE_AI, DarkCharizardContinuousFireball_AI
	dbw EFFECTCMDTYPE_AI_SWITCH_DEFENDING_PKMN, DarkCharizardContinuousFireball_AISwitchDefendingPkmn
	db $00

PonytaLv15EmberEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, PonytaLv15Ember_InitialEffect1
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, PonytaLv15Ember_InitialEffect2
	dbw EFFECTCMDTYPE_DISCARD_ENERGY, PonytaLv15Ember_DiscardEnergy
	dbw EFFECTCMDTYPE_AI_SELECTION, PonytaLv15Ember_AISelection
	db $00

DarkRapidashFlamePillarEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, DarkRapidashFlamePillar_AfterDamage
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, DarkRapidashFlamePillar_RequireSelection
	dbw EFFECTCMDTYPE_AI_SELECTION, DarkRapidashFlamePillar_AISelection
	db $00

DarkFlareonRageEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, DarkFlareonRage_BeforeDamage
	dbw EFFECTCMDTYPE_AI, DarkFlareonRage_AI
	db $00

DarkFlareonPlayingWithFireEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, DarkFlareonPlayingWithFire_InitialEffect1
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, DarkFlareonPlayingWithFire_BeforeDamage
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, DarkFlareonPlayingWithFire_RequireSelection
	dbw EFFECTCMDTYPE_AI, DarkFlareonPlayingWithFire_AI
	dbw EFFECTCMDTYPE_AI_SWITCH_DEFENDING_PKMN, DarkFlareonPlayingWithFire_AISwitchDefendingPkmn
	db $00

DarkWartortleDoubleSlapEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, DarkWartortleDoubleSlap_BeforeDamage
	dbw EFFECTCMDTYPE_AI, DarkWartortleDoubleSlap_AI
	db $00

DarkWartortleMirrorShellEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, DarkWartortleMirrorShell_BeforeDamage
	db $00

DarkBlastoiseHydrocannonEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, DarkBlastoiseHydrocannon_BeforeDamage
	dbw EFFECTCMDTYPE_AI, DarkBlastoiseHydrocannon_BeforeDamage
	db $00

DarkBlastoiseRocketTackleEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, DarkBlastoiseRocketTackle_BeforeDamage
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, DarkBlastoiseRocketTackle_AfterDamage
	db $00

PsyduckLv16DizzinessEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, PsyduckLv16Dizziness_InitialEffect1
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, PsyduckLv16Dizziness_AfterDamage
	db $00

PsyduckLv16WaterGunEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, PsyduckLv16WaterGun_BeforeDamage
	dbw EFFECTCMDTYPE_AI, PsyduckLv16WaterGun_BeforeDamage
	db $00

DarkGolduckThirdEyeEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, DarkGolduckThirdEye_InitialEffect1
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, DarkGolduckThirdEye_InitialEffect2
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, DarkGolduckThirdEye_AfterDamage
	dbw EFFECTCMDTYPE_DISCARD_ENERGY, DarkGolduckThirdEye_DiscardEnergy
	dbw EFFECTCMDTYPE_AI_SELECTION, DarkGolduckThirdEye_AISelection
	db $00

MagikarpLv6RapidEvolutionEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, MagikarpLv6RapidEvolution_InitialEffect1
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, MagikarpLv6RapidEvolution_AfterDamage
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, MagikarpLv6RapidEvolution_RequireSelection
	dbw EFFECTCMDTYPE_AI_SELECTION, MagikarpLv6RapidEvolution_AISelection
	db $00

DarkGyaradosFinalBeamEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, DarkGyaradosFinalBeam_InitialEffect1
	db $00

DarkGyaradosIceBeamEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, DarkGyaradosIceBeam_BeforeDamage
	db $00

DarkVaporeonWhirlpoolEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, DarkVaporeonWhirlpool_AfterDamage
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, DarkVaporeonWhirlpool_RequireSelection
	dbw EFFECTCMDTYPE_AI_SELECTION, DarkVaporeonWhirlpool_AISelection
	db $00

EkansLv15PoisonStingEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, EkansLv15PoisonSting_BeforeDamage
	dbw EFFECTCMDTYPE_AI, EkansLv15PoisonSting_AI
	db $00

DarkArbokStareEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, DarkArbokStare_BeforeDamage
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, DarkArbokStare_AfterDamage
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, DarkArbokStare_RequireSelection
	dbw EFFECTCMDTYPE_AI_SELECTION, DarkArbokStare_AISelection
	dbw EFFECTCMDTYPE_AI, DarkArbokStare_AI
	db $00

DarkArbokPoisonVaporEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, DarkArbokPoisonVapor_BeforeDamage
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, DarkArbokPoisonVapor_AfterDamage
	db $00

DarkGolbatSneakAttackEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, DarkGolbatSneakAttack_InitialEffect1
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, DarkGolbatSneakAttack_RequireSelection
	dbw EFFECTCMDTYPE_PKMN_POWER_TRIGGER, DarkGolbatSneakAttack_PkmnPowerTrigger
	db $00

DarkGolbatFlitterEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, DarkGolbatFlitter_BeforeDamage
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, DarkGolbatFlitter_AfterDamage
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, DarkGolbatFlitter_RequireSelection
	dbw EFFECTCMDTYPE_AI_SELECTION, DarkGolbatFlitter_AISelection
	dbw EFFECTCMDTYPE_AI, DarkGolbatFlitter_AI
	db $00

OddishLv21SleepPowderEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, OddishLv21SleepPowder_BeforeDamage
	db $00

OddishLv21PoisonPowderEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, OddishLv21PoisonPowder_BeforeDamage
	dbw EFFECTCMDTYPE_AI, OddishLv21PoisonPowder_AI
	db $00

DarkGloomPollenStenchEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, DarkGloomPollenStench_InitialEffect2
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, DarkGloomPollenStench_BeforeDamage
	db $00

DarkGloomPoisonPowderEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, DarkGloomPoisonPowder_BeforeDamage
	dbw EFFECTCMDTYPE_AI, DarkGloomPoisonPowder_AI
	db $00

DarkVileplumeHayFeverEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, DarkVileplumeHayFever_InitialEffect1
	db $00

DarkVileplumePetalWhirlwindEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, DarkVileplumePetalWhirlwind_BeforeDamage
	dbw EFFECTCMDTYPE_AI, DarkVileplumePetalWhirlwind_AI
	db $00

GrimerLv10PoisonGasEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, GrimerLv10PoisonGas_BeforeDamage
	dbw EFFECTCMDTYPE_AI, GrimerLv10PoisonGas_AI
	db $00

GrimerLv10StickyHandsEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, GrimerLv10StickyHands_BeforeDamage
	dbw EFFECTCMDTYPE_AI, GrimerLv10StickyHands_AI
	db $00

DarkMukStickyGooEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, DarkMukStickyGoo_InitialEffect1
	db $00

DarkMukSludgePunchEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, DarkMukSludgePunch_BeforeDamage
	dbw EFFECTCMDTYPE_AI, DarkMukSludgePunch_AI
	db $00

KoffingLv12PoisonGasEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, KoffingLv12PoisonGas_BeforeDamage
	dbw EFFECTCMDTYPE_AI, KoffingLv12PoisonGas_AI
	db $00

DarkWeezingMassExplosionEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, DarkWeezingMassExplosion_BeforeDamage
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, DarkWeezingMassExplosion_AfterDamage
	dbw EFFECTCMDTYPE_AI, DarkWeezingMassExplosion_BeforeDamage
	db $00

DarkWeezingStunGasEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, DarkWeezingStunGas_BeforeDamage
	db $00

AbraLv14VanishEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, AbraLv14Vanish_InitialEffect1
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, AbraLv14Vanish_AfterDamage
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, AbraLv14Vanish_RequireSelection
	db $00

AbraLv14PsyshockEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, AbraLv14Psyshock_BeforeDamage
	db $00

DarkKadabraMatterExchangeEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, DarkKadabraMatterExchange_InitialEffect2
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, DarkKadabraMatterExchange_BeforeDamage
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, DarkKadabraMatterExchange_RequireSelection
	db $00

DarkKadabraMindShockEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, DarkKadabraMindShock_BeforeDamage
	dbw EFFECTCMDTYPE_AI, DarkKadabraMindShock_BeforeDamage
	db $00

DarkAlakazamTeleportBlastEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, DarkAlakazamTeleportBlast_BeforeDamage
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, DarkAlakazamTeleportBlast_AfterDamage
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, DarkAlakazamTeleportBlast_RequireSelection
	dbw EFFECTCMDTYPE_AI_SELECTION, DarkAlakazamTeleportBlast_AISelection
	db $00

DarkAlakazamMindShockEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, DarkAlakazamMindShock_BeforeDamage
	dbw EFFECTCMDTYPE_AI, DarkAlakazamMindShock_BeforeDamage
	db $00

SlowpokeLv16AfternoonNapEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, SlowpokeLv16AfternoonNap_InitialEffect1
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, SlowpokeLv16AfternoonNap_AfterDamage
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, SlowpokeLv16AfternoonNap_RequireSelection
	dbw EFFECTCMDTYPE_AI_SELECTION, SlowpokeLv16AfternoonNap_AISelection
	db $00

DarkSlowbroReelInEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, DarkSlowbroReelIn_InitialEffect1
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, DarkSlowbroReelIn_RequireSelection
	dbw EFFECTCMDTYPE_PKMN_POWER_TRIGGER, DarkSlowbroReelIn_PkmnPowerTrigger
	db $00

DarkSlowbroFickleAttackEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, DarkSlowbroFickleAttack_BeforeDamage
	dbw EFFECTCMDTYPE_AI, DarkSlowbroFickleAttack_AI
	db $00

DrowzeeLv10LongDistanceHypnosisEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, DrowzeeLv10LongDistanceHypnosis_InitialEffect2
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, DrowzeeLv10LongDistanceHypnosis_BeforeDamage
	db $00

DrowzeeLv10NightmareEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, DrowzeeLv10Nightmare_BeforeDamage
	db $00

DarkHypnoBenchManipulationEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, DarkHypnoBenchManipulation_InitialEffect1
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, DarkHypnoBenchManipulation_BeforeDamage
	dbw EFFECTCMDTYPE_AI, DarkHypnoBenchManipulation_AI
	db $00

DiglettLv15DigUnderEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, DiglettLv15DigUnder_BeforeDamage
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, DiglettLv15DigUnder_AfterDamage
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, DiglettLv15DigUnder_RequireSelection
	dbw EFFECTCMDTYPE_AI_SELECTION, DiglettLv15DigUnder_AISelection
	dbw EFFECTCMDTYPE_AI, DiglettLv15DigUnder_AI
	db $00

DarkDugtrioSinkholeEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, DarkDugtrioSinkhole_InitialEffect1
	db $00

DarkDugtrioKnockDownEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, DarkDugtrioKnockDown_BeforeDamage
	dbw EFFECTCMDTYPE_AI, DarkDugtrioKnockDown_AI
	db $00

MankeyLv14MischiefEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, MankeyLv14Mischief_InitialEffect1
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, MankeyLv14Mischief_AfterDamage
	db $00

MankeyLv14AngerEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, MankeyLv14Anger_BeforeDamage
	dbw EFFECTCMDTYPE_AI, MankeyLv14Anger_AI
	db $00

DarkPrimeapeFrenzyEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, DarkPrimeapeFrenzy_InitialEffect1
	db $00

DarkPrimeapeFrenziedAttackEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, DarkPrimeapeFrenziedAttack_BeforeDamage
	dbw EFFECTCMDTYPE_AI, DarkPrimeapeFrenziedAttack_AI
	db $00

DarkMachokeDragOffEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, DarkMachokeDragOff_InitialEffect1
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, DarkMachokeDragOff_BeforeDamage
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, DarkMachokeDragOff_RequireSelection
	dbw EFFECTCMDTYPE_AI_SELECTION, DarkMachokeDragOff_AISelection
	db $00

DarkMachokeKnockBackEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, DarkMachokeKnockBack_AfterDamage
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, DarkMachokeKnockBack_RequireSelection
	dbw EFFECTCMDTYPE_AI_SWITCH_DEFENDING_PKMN, DarkMachokeKnockBack_RequireSelection
	db $00

DarkMachampFlingAltEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, DarkMachampFlingAlt_InitialEffect1
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, DarkMachampFlingAlt_AfterDamage
	db $00

RattataLv12TrickeryEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, RattataLv12Trickery_InitialEffect2
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, RattataLv12Trickery_BeforeDamage
	db $00

RattataLv12QuickAttackEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, RattataLv12QuickAttack_BeforeDamage
	dbw EFFECTCMDTYPE_AI, RattataLv12QuickAttack_AI
	db $00

DarkRaticateHyperFangEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, DarkRaticateHyperFang_BeforeDamage
	dbw EFFECTCMDTYPE_AI, DarkRaticateHyperFang_AI
	db $00

MeowthLv10CoinHurlEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, MeowthLv10CoinHurl_InitialEffect1
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, MeowthLv10CoinHurl_BeforeDamage
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, MeowthLv10CoinHurl_AfterDamage
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, MeowthLv10CoinHurl_RequireSelection
	dbw EFFECTCMDTYPE_AI, MeowthLv10CoinHurl_AI
	dbw EFFECTCMDTYPE_AI_SWITCH_DEFENDING_PKMN, MeowthLv10CoinHurl_AISwitchDefendingPkmn
	db $00

DarkPersianLv28FascinateEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, DarkPersianLv28Fascinate_InitialEffect1
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, DarkPersianLv28Fascinate_BeforeDamage
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, DarkPersianLv28Fascinate_AfterDamage
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, DarkPersianLv28Fascinate_RequireSelection
	dbw EFFECTCMDTYPE_AI_SELECTION, DarkPersianLv28Fascinate_AISelection
	db $00

DarkPersianLv28PoisonClawsEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, DarkPersianLv28PoisonClaws_BeforeDamage
	dbw EFFECTCMDTYPE_AI, DarkPersianLv28PoisonClaws_AI
	db $00

EeveeLv9SandAttackEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, EeveeLv9SandAttack_BeforeDamage
	db $00

PorygonLv20Conversion1EffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, PorygonLv20Conversion1_InitialEffect1
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, PorygonLv20Conversion1_InitialEffect2
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, PorygonLv20Conversion1_AfterDamage
	dbw EFFECTCMDTYPE_AI_SELECTION, PorygonLv20Conversion1_AISelection
	db $00

PorygonLv20PsybeamEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, PorygonLv20Psybeam_BeforeDamage
	db $00

DratiniLv12WrapEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, DratiniLv12Wrap_BeforeDamage
	db $00

DarkDragonairEvolutionaryLightEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, DarkDragonairEvolutionaryLight_InitialEffect2
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, DarkDragonairEvolutionaryLight_BeforeDamage
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, DarkDragonairEvolutionaryLight_RequireSelection
	db $00

DarkDragonairTailStrikeEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, DarkDragonairTailStrike_BeforeDamage
	dbw EFFECTCMDTYPE_AI, DarkDragonairTailStrike_AI
	db $00

DarkDragoniteSummonMinionsEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, DarkDragoniteSummonMinions_InitialEffect1
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, DarkDragoniteSummonMinions_RequireSelection
	dbw EFFECTCMDTYPE_PKMN_POWER_TRIGGER, DarkDragoniteSummonMinions_PkmnPowerTrigger
	db $00

DarkDragoniteGiantTailEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, DarkDragoniteGiantTail_BeforeDamage
	dbw EFFECTCMDTYPE_AI, DarkDragoniteGiantTail_AI
	db $00

MagnemiteLv12MagnetismEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, MagnemiteLv12Magnetism_BeforeDamage
	dbw EFFECTCMDTYPE_AI, MagnemiteLv12Magnetism_BeforeDamage
	db $00

DarkMagnetonSonicboomEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, DarkMagnetonSonicboom_BeforeDamage
	dbw EFFECTCMDTYPE_AI, DarkMagnetonSonicboom_BeforeDamage
	db $00

DarkMagnetonMagneticLinesEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, DarkMagnetonMagneticLines_AfterDamage
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, DarkMagnetonMagneticLines_RequireSelection
	dbw EFFECTCMDTYPE_AI_SELECTION, DarkMagnetonMagneticLines_AISelection
	db $00

DarkElectrodeEnergyBombEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, DarkElectrodeEnergyBomb_InitialEffect1
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, DarkElectrodeEnergyBomb_BeforeDamage
	dbw EFFECTCMDTYPE_UNK_11, DarkElectrodeEnergyBomb_Unk11
	db $00

DarkJolteonLightningFlashEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, DarkJolteonLightningFlash_BeforeDamage
	db $00

DarkJolteonThunderAttackEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, DarkJolteonThunderAttack_BeforeDamage
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, DarkJolteonThunderAttack_AfterDamage
	db $00

ImposterOaksRevengeEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, ImposterOaksRevenge_InitialEffect1
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, ImposterOaksRevenge_InitialEffect2
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, ImposterOaksRevenge_BeforeDamage
	db $00

SleepEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Sleep_BeforeDamage
	db $00

DiggerEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Digger_BeforeDamage
	db $00

TheBosssWayEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, TheBosssWay_InitialEffect1
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, TheBosssWay_BeforeDamage
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, TheBosssWay_RequireSelection
	db $00

GoopGasAttackEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, GoopGasAttack_BeforeDamage
	db $00

RocketsSneakAttackEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, RocketsSneakAttack_BeforeDamage
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, RocketsSneakAttack_RequireSelection
	db $00

HereComesTeamRocketEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, HereComesTeamRocket_BeforeDamage
	db $00

NightlyGarbageRunEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, NightlyGarbageRun_InitialEffect1
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, NightlyGarbageRun_BeforeDamage
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, NightlyGarbageRun_RequireSelection
	db $00

PotionEnergyEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_PKMN_POWER_TRIGGER, PotionEnergy_PkmnPowerTrigger
	db $00

FullhealEnergyEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_PKMN_POWER_TRIGGER, FullhealEnergy_PkmnPowerTrigger
	db $00

RainbowEnergyEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_PKMN_POWER_TRIGGER, RainbowEnergy_PkmnPowerTrigger
	db $00

ChallengeEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Challenge_BeforeDamage
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, Challenge_RequireSelection
	db $00

BulbasaurLv15FirstAidEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, BulbasaurLv15FirstAid_InitialEffect1
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, BulbasaurLv15FirstAid_AfterDamage
	db $00

BulbasaurLv15PoisonSeedEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, BulbasaurLv15PoisonSeed_BeforeDamage
	dbw EFFECTCMDTYPE_AI, BulbasaurLv15PoisonSeed_AI
	db $00

CharmanderLv12GrowlEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, CharmanderLv12Growl_BeforeDamage
	db $00

SquirtleLv15WaterPowerEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, SquirtleLv15WaterPower_BeforeDamage
	db $00

MetapodLv20GreenShieldEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, MetapodLv20GreenShield_InitialEffect1
	db $00

MetapodLv20MysteriousPowerEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, MetapodLv20MysteriousPower_BeforeDamage
	db $00

WeedleLv15PoisonHornEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, WeedleLv15PoisonHorn_BeforeDamage
	dbw EFFECTCMDTYPE_AI, WeedleLv15PoisonHorn_AI
	db $00

KakunaLv20PoisonFluidEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, KakunaLv20PoisonFluid_InitialEffect1
	db $00

PidgeyLv10QuickAttackEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, PidgeyLv10QuickAttack_BeforeDamage
	dbw EFFECTCMDTYPE_AI, PidgeyLv10QuickAttack_AI
	db $00

RattataLv15TailWhipEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, RattataLv15TailWhip_BeforeDamage
	db $00

PikachuLv5ThundershockEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, PikachuLv5Thundershock_BeforeDamage
	db $00

PikachuLv5AgilityEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, PikachuLv5Agility_BeforeDamage
	db $00

NidoranFLv12TailWhipEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, NidoranFLv12TailWhip_BeforeDamage
	db $00

NidoranFLv12PoisonStingEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, NidoranFLv12PoisonSting_BeforeDamage
	dbw EFFECTCMDTYPE_AI, NidoranFLv12PoisonSting_AI
	db $00

NidoranMLv22FocusEnergyEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, NidoranMLv22FocusEnergy_BeforeDamage
	db $00

NidoranMLv22HornRushEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, NidoranMLv22HornRush_BeforeDamage
	dbw EFFECTCMDTYPE_AI, NidoranMLv22HornRush_AI
	db $00

ClefairyLv15FollowMeEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, ClefairyLv15FollowMe_InitialEffect1
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, ClefairyLv15FollowMe_AfterDamage
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, ClefairyLv15FollowMe_RequireSelection
	dbw EFFECTCMDTYPE_AI_SWITCH_DEFENDING_PKMN, ClefairyLv15FollowMe_AISwitchDefendingPkmn
	db $00

ClefairyLv15ShiningFingersEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, ClefairyLv15ShiningFingers_BeforeDamage
	db $00

WigglytuffLv40HelpingHandEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, WigglytuffLv40HelpingHand_InitialEffect2
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, WigglytuffLv40HelpingHand_BeforeDamage
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, WigglytuffLv40HelpingHand_RequireSelection
	db $00

WigglytuffLv40ExpandEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, WigglytuffLv40Expand_BeforeDamage
	db $00

ZubatLv12SuspiciousSoundwaveEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, ZubatLv12SuspiciousSoundwave_BeforeDamage
	db $00

GolbatLv25LeechLifeEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, GolbatLv25LeechLife_AfterDamage
	db $00

GolbatLv25NosediveEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, GolbatLv25Nosedive_BeforeDamage
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, GolbatLv25Nosedive_AfterDamage
	db $00

ParasLv15ScatterSporesEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, ParasLv15ScatterSpores_InitialEffect1
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, ParasLv15ScatterSpores_AfterDamage
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, ParasLv15ScatterSpores_RequireSelection
	dbw EFFECTCMDTYPE_AI_SELECTION, ParasLv15ScatterSpores_AISelection
	db $00

ParasectLv29ToxicSporeEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, ParasectLv29ToxicSpore_BeforeDamage
	dbw EFFECTCMDTYPE_AI, ParasectLv29ToxicSpore_AI
	db $00

ParasectLv29LeechLifeEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, ParasectLv29LeechLife_AfterDamage
	db $00

PoliwagLv15BubbleEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, PoliwagLv15Bubble_BeforeDamage
	db $00

PoliwhirlLv30TwiddleEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, PoliwhirlLv30Twiddle_BeforeDamage
	db $00

PoliwhirlLv30BodySlamEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, PoliwhirlLv30BodySlam_BeforeDamage
	db $00

PoliwrathLv40HydroPumpEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, PoliwrathLv40HydroPump_BeforeDamage
	dbw EFFECTCMDTYPE_AI, PoliwrathLv40HydroPump_BeforeDamage
	db $00

AbraLv8PsychicBeamEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, AbraLv8PsychicBeam_BeforeDamage
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, AbraLv8PsychicBeam_AfterDamage
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, AbraLv8PsychicBeam_RequireSelection
	dbw EFFECTCMDTYPE_AI_SELECTION, AbraLv8PsychicBeam_AISelection
	dbw EFFECTCMDTYPE_AI, AbraLv8PsychicBeam_AI
	db $00

GeodudeLv15HardenEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, GeodudeLv15Harden_BeforeDamage
	db $00

RapidashLv30FlameInfernoEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, RapidashLv30FlameInferno_BeforeDamage
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, RapidashLv30FlameInferno_RequireSelection
	dbw EFFECTCMDTYPE_AI, RapidashLv30FlameInferno_AI
	dbw EFFECTCMDTYPE_AI_SWITCH_DEFENDING_PKMN, RapidashLv30FlameInferno_AISwitchDefendingPkmn
	db $00

RapidashLv30KickAwayEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, RapidashLv30KickAway_AfterDamage
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, RapidashLv30KickAway_RequireSelection
	dbw EFFECTCMDTYPE_AI_SWITCH_DEFENDING_PKMN, RapidashLv30KickAway_RequireSelection
	db $00

DoduoLv8GrowlEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, DoduoLv8Growl_BeforeDamage
	db $00

DodrioLv25TriAttackEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, DodrioLv25TriAttack_BeforeDamage
	dbw EFFECTCMDTYPE_AI, DodrioLv25TriAttack_AI
	db $00

LickitungLv20LickAltEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, LickitungLv20LickAlt_BeforeDamage
	db $00

LickitungLv20StompEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, LickitungLv20Stomp_BeforeDamage
	dbw EFFECTCMDTYPE_AI, LickitungLv20Stomp_AI
	db $00

ChanseyLv40SingEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, ChanseyLv40Sing_BeforeDamage
	db $00

ChanseyLv40DoubleSlapAltEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, ChanseyLv40DoubleSlapAlt_BeforeDamage
	dbw EFFECTCMDTYPE_AI, ChanseyLv40DoubleSlapAlt_AI
	db $00

MrMimeLv20DampeningShieldEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, MrMimeLv20DampeningShield_InitialEffect1
	db $00

MrMimeLv20JugglingEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, MrMimeLv20Juggling_BeforeDamage
	dbw EFFECTCMDTYPE_AI, MrMimeLv20Juggling_AI
	db $00

PinsirLv15SlicingThrowEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, PinsirLv15SlicingThrow_BeforeDamage
	dbw EFFECTCMDTYPE_AI, PinsirLv15SlicingThrow_AI
	db $00

EeveeLv5LungeEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, EeveeLv5Lunge_BeforeDamage
	dbw EFFECTCMDTYPE_AI, EeveeLv5Lunge_AI
	db $00

PorygonLv18Porygon3DAttackEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, PorygonLv18Porygon3DAttack_BeforeDamage
	dbw EFFECTCMDTYPE_AI, PorygonLv18Porygon3DAttack_AI
	db $00

PorygonLv18Conversion2EffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, PorygonLv18Conversion2_InitialEffect1
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, PorygonLv18Conversion2_InitialEffect2
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, PorygonLv18Conversion2_AfterDamage
	dbw EFFECTCMDTYPE_AI_SELECTION, PorygonLv18Conversion2_AISelection
	db $00

SnorlaxLv35GuardEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, SnorlaxLv35Guard_InitialEffect1
	db $00

SnorlaxLv35RollOverEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, SnorlaxLv35RollOver_BeforeDamage
	db $00

MewtwoLv54PsycrushEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, MewtwoLv54Psycrush_BeforeDamage
	dbw EFFECTCMDTYPE_AI, MewtwoLv54Psycrush_BeforeDamage
	db $00

TheRocketsTrapEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, TheRocketsTrap_InitialEffect1
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, TheRocketsTrap_BeforeDamage
	db $00

FossilExcavationEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, FossilExcavation_InitialEffect1
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, FossilExcavation_BeforeDamage
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, FossilExcavation_RequireSelection
	dbw EFFECTCMDTYPE_AI_SWITCH_DEFENDING_PKMN, FossilExcavation_AISwitchDefendingPkmn
	db $00

MoonStoneEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, MoonStone_InitialEffect1
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, MoonStone_BeforeDamage
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, MoonStone_RequireSelection
	dbw EFFECTCMDTYPE_AI_SELECTION, MoonStone_AISelection
	db $00

MaxReviveEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, MaxRevive_InitialEffect1
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, MaxRevive_InitialEffect2
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, MaxRevive_BeforeDamage
	db $00

MasterBallEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, MasterBall_InitialEffect1
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, MasterBall_BeforeDamage
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, MasterBall_RequireSelection
	db $00

PokemonRecallEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, PokemonRecall_InitialEffect1
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, PokemonRecall_InitialEffect2
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, PokemonRecall_BeforeDamage
	db $00

BillsComputerEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, BillsComputer_InitialEffect1
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, BillsComputer_InitialEffect1
	db $00

ComputerErrorEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, ComputerError_InitialEffect1
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, ComputerError_BeforeDamage
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, ComputerError_RequireSelection
	db $00

SpearowLv12FuryAttackEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, SpearowLv12FuryAttack_BeforeDamage
	dbw EFFECTCMDTYPE_AI, SpearowLv12FuryAttack_AI
	db $00

FearowLv24QuickAttackEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, FearowLv24QuickAttack_BeforeDamage
	dbw EFFECTCMDTYPE_AI, FearowLv24QuickAttack_AI
	db $00

FearowLv24DrillDescentEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, FearowLv24DrillDescent_BeforeDamage
	dbw EFFECTCMDTYPE_AI, FearowLv24DrillDescent_AI
	db $00

RaichuLv32ShortCircuitEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, RaichuLv32ShortCircuit_InitialEffect1
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, RaichuLv32ShortCircuit_BeforeDamage
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, RaichuLv32ShortCircuit_AfterDamage
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, RaichuLv32ShortCircuit_RequireSelection
	dbw EFFECTCMDTYPE_AI_SELECTION, RaichuLv32ShortCircuit_AISelection
	db $00

RaichuLv32SparkingKickEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, RaichuLv32SparkingKick_BeforeDamage
	db $00

SandshrewLv15PoisonStingEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, SandshrewLv15PoisonSting_BeforeDamage
	dbw EFFECTCMDTYPE_AI, SandshrewLv15PoisonSting_AI
	db $00

SandshrewLv15SwiftEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, SandshrewLv15Swift_BeforeDamage
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, SandshrewLv15Swift_AfterDamage
	dbw EFFECTCMDTYPE_AI, SandshrewLv15Swift_AI
	db $00

VenomothLv22StirUpTwisterEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, VenomothLv22StirUpTwister_AfterDamage
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, VenomothLv22StirUpTwister_RequireSelection
	dbw EFFECTCMDTYPE_AI_SELECTION, VenomothLv22StirUpTwister_AISelection
	db $00

VenomothLv22RainbowPowderEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, VenomothLv22RainbowPowder_BeforeDamage
	db $00

MachopLv18FocusedOneShotEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, MachopLv18FocusedOneShot_BeforeDamage
	db $00

MachopLv18CorkscrewPunchEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, MachopLv18CorkscrewPunch_InitialEffect1
	db $00

MachokeLv28SteadyPunchEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, MachokeLv28SteadyPunch_BeforeDamage
	dbw EFFECTCMDTYPE_AI, MachokeLv28SteadyPunch_AI
	db $00

GravelerLv28StoneBarrageAltEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, GravelerLv28StoneBarrageAlt_BeforeDamage
	dbw EFFECTCMDTYPE_AI, GravelerLv28StoneBarrageAlt_AI
	db $00

GravelerLv28EarthquakeEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, GravelerLv28Earthquake_AfterDamage
	db $00

MagnemiteLv15MagnetMoveEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, MagnemiteLv15MagnetMove_InitialEffect2
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, MagnemiteLv15MagnetMove_BeforeDamage
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, MagnemiteLv15MagnetMove_RequireSelection
	dbw EFFECTCMDTYPE_AI_SELECTION, MagnemiteLv15MagnetMove_AISelection
	db $00

MagnemiteLv15SuperconductivityEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, MagnemiteLv15Superconductivity_BeforeDamage
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, MagnemiteLv15Superconductivity_AfterDamage
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, MagnemiteLv15Superconductivity_RequireSelection
	dbw EFFECTCMDTYPE_AI_SELECTION, MagnemiteLv15Superconductivity_AISelection
	dbw EFFECTCMDTYPE_AI, MagnemiteLv15Superconductivity_AI
	db $00

MagnetonLv30MicrowaveEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, MagnetonLv30Microwave_InitialEffect1
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, MagnetonLv30Microwave_BeforeDamage
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, MagnetonLv30Microwave_AfterDamage
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, MagnetonLv30Microwave_RequireSelection
	dbw EFFECTCMDTYPE_AI_SELECTION, MagnetonLv30Microwave_AISelection
	dbw EFFECTCMDTYPE_AI, MagnetonLv30Microwave_AI
	db $00

SeelLv10GrowlEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, SeelLv10Growl_BeforeDamage
	db $00

SeelLv10IceBeamEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, SeelLv10IceBeam_BeforeDamage
	db $00

DewgongLv24RestEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, DewgongLv24Rest_BeforeDamage
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, DewgongLv24Rest_AfterDamage
	db $00

DewgongLv24AuroraWaveEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, DewgongLv24AuroraWave_BeforeDamage
	db $00

ShellderLv16WaterSpoutEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, ShellderLv16WaterSpout_BeforeDamage
	dbw EFFECTCMDTYPE_AI, ShellderLv16WaterSpout_BeforeDamage
	db $00

OnixLv25BindEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, OnixLv25Bind_BeforeDamage
	db $00

OnixLv25RockSealEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, OnixLv25RockSeal_BeforeDamage
	db $00

KrabbyLv17BubbleEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, KrabbyLv17Bubble_BeforeDamage
	db $00

VoltorbLv8ThundershockEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, VoltorbLv8Thundershock_BeforeDamage
	db $00

VoltorbLv8GroupSparkEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, VoltorbLv8GroupSpark_BeforeDamage
	dbw EFFECTCMDTYPE_AI, VoltorbLv8GroupSpark_BeforeDamage
	db $00

HitmonleeLv23DoubleKickEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, HitmonleeLv23DoubleKick_BeforeDamage
	dbw EFFECTCMDTYPE_AI, HitmonleeLv23DoubleKick_AI
	db $00

HitmonleeLv23RollingKickEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, HitmonleeLv23RollingKick_BeforeDamage
	db $00

HitmonchanLv23MatchPunchEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, HitmonchanLv23MatchPunch_InitialEffect1
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, HitmonchanLv23MatchPunch_AfterDamage
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, HitmonchanLv23MatchPunch_RequireSelection
	dbw EFFECTCMDTYPE_AI_SELECTION, HitmonchanLv23MatchPunch_AISelection
	db $00

JynxLv18IcePunchEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, JynxLv18IcePunch_BeforeDamage
	db $00

JynxLv18ColdBreathEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, JynxLv18ColdBreath_BeforeDamage
	db $00

LaprasLv24SingEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, LaprasLv24Sing_BeforeDamage
	db $00

OmanyteLv20PrehistoricDreamEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, OmanyteLv20PrehistoricDream_InitialEffect2
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, OmanyteLv20PrehistoricDream_BeforeDamage
	db $00

KabutoLv22FossilizeEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, KabutoLv22Fossilize_InitialEffect2
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, KabutoLv22Fossilize_BeforeDamage
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, KabutoLv22Fossilize_RequireSelection
	db $00

KabutoLv22SharpClawsEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, KabutoLv22SharpClaws_BeforeDamage
	dbw EFFECTCMDTYPE_AI, KabutoLv22SharpClaws_AI
	db $00

AerodactylLv30SupersonicEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, AerodactylLv30Supersonic_BeforeDamage
	db $00

AerodactylLv30TailspinAttackEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, AerodactylLv30TailspinAttack_AfterDamage
	db $00

ArticunoLv34AuroraVeilEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, ArticunoLv34AuroraVeil_InitialEffect1
	db $00

ArticunoLv34IceBeamEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, ArticunoLv34IceBeam_BeforeDamage
	db $00

ZapdosLv28RagingThunderEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, ZapdosLv28RagingThunder_InitialEffect1
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, ZapdosLv28RagingThunder_AfterDamage
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, ZapdosLv28RagingThunder_RequireSelection
	dbw EFFECTCMDTYPE_AI_SELECTION, ZapdosLv28RagingThunder_AISelection
	db $00

ZapdosLv28ThunderCrashEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, ZapdosLv28ThunderCrash_BeforeDamage
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, ZapdosLv28ThunderCrash_AfterDamage
	dbw EFFECTCMDTYPE_AI, ZapdosLv28ThunderCrash_AI
	db $00

MoltresLv37DryUpEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, MoltresLv37DryUp_InitialEffect1
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, MoltresLv37DryUp_InitialEffect2
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, MoltresLv37DryUp_BeforeDamage
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, MoltresLv37DryUp_AfterDamage
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, MoltresLv37DryUp_RequireSelection
	dbw EFFECTCMDTYPE_AI_SELECTION, MoltresLv37DryUp_AISelection
	dbw EFFECTCMDTYPE_AI_SWITCH_DEFENDING_PKMN, MoltresLv37DryUp_AISwitchDefendingPkmn
	db $00

PidgeottoLv38TwisterEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, PidgeottoLv38Twister_AfterDamage
	db $00

PidgeottoLv38FlyEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, PidgeottoLv38Fly_BeforeDamage
	dbw EFFECTCMDTYPE_AI, PidgeottoLv38Fly_AI
	db $00

ArbokLv30WrapEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, ArbokLv30Wrap_BeforeDamage
	db $00

ArbokLv30DeadlyPoisonEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, ArbokLv30DeadlyPoison_BeforeDamage
	dbw EFFECTCMDTYPE_AI, ArbokLv30DeadlyPoison_AI
	db $00

SandslashLv35SandVeilEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, SandslashLv35SandVeil_BeforeDamage
	db $00

SandslashLv35RollingNeedleEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, SandslashLv35RollingNeedle_BeforeDamage
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, SandslashLv35RollingNeedle_AfterDamage
	dbw EFFECTCMDTYPE_AI, SandslashLv35RollingNeedle_AI
	db $00

NidorinaLv22StrengthInNumbersEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, NidorinaLv22StrengthInNumbers_BeforeDamage
	dbw EFFECTCMDTYPE_AI, NidorinaLv22StrengthInNumbers_BeforeDamage
	db $00

NidorinaLv22FurySwipesEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, NidorinaLv22FurySwipes_BeforeDamage
	dbw EFFECTCMDTYPE_AI, NidorinaLv22FurySwipes_AI
	db $00

NidorinoLv23SwiftLungeEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, NidorinoLv23SwiftLunge_BeforeDamage
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, NidorinoLv23SwiftLunge_AfterDamage
	dbw EFFECTCMDTYPE_AI, NidorinoLv23SwiftLunge_AI
	db $00

VulpixLv13FoxFireEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, VulpixLv13FoxFire_BeforeDamage
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, VulpixLv13FoxFire_RequireSelection
	dbw EFFECTCMDTYPE_AI_SELECTION, VulpixLv13FoxFire_AISelection
	db $00

VenonatLv15DisableEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, VenonatLv15Disable_InitialEffect1
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, VenonatLv15Disable_BeforeDamage
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, VenonatLv15Disable_RequireSelection
	dbw EFFECTCMDTYPE_AI_SELECTION, VenonatLv15Disable_AISelection
	db $00

VenonatLv15PsybeamEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, VenonatLv15Psybeam_BeforeDamage
	db $00

GolduckLv28PsychicEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, GolduckLv28Psychic_BeforeDamage
	dbw EFFECTCMDTYPE_AI, GolduckLv28Psychic_BeforeDamage
	db $00

GrowlitheLv16ErrandRunningEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, GrowlitheLv16ErrandRunning_InitialEffect1
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, GrowlitheLv16ErrandRunning_BeforeDamage
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, GrowlitheLv16ErrandRunning_AfterDamage
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, GrowlitheLv16ErrandRunning_RequireSelection
	dbw EFFECTCMDTYPE_AI_SELECTION, GrowlitheLv16ErrandRunning_AISelection
	db $00

GrowlitheLv16EmberEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, GrowlitheLv16Ember_InitialEffect1
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, GrowlitheLv16Ember_InitialEffect2
	dbw EFFECTCMDTYPE_DISCARD_ENERGY, GrowlitheLv16Ember_DiscardEnergy
	dbw EFFECTCMDTYPE_AI_SELECTION, GrowlitheLv16Ember_AISelection
	db $00

KadabraLv39PsychoPanicEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, KadabraLv39PsychoPanic_BeforeDamage
	dbw EFFECTCMDTYPE_AI, KadabraLv39PsychoPanic_BeforeDamage
	db $00

KadabraLv39BlinkEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, KadabraLv39Blink_BeforeDamage
	db $00

AlakazamLv45PsychoPanicEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, AlakazamLv45PsychoPanic_BeforeDamage
	dbw EFFECTCMDTYPE_AI, AlakazamLv45PsychoPanic_BeforeDamage
	db $00

AlakazamLv45TransDamageEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, AlakazamLv45TransDamage_InitialEffect1
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, AlakazamLv45TransDamage_BeforeDamage
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, AlakazamLv45TransDamage_AfterDamage
	dbw EFFECTCMDTYPE_DISCARD_ENERGY, AlakazamLv45TransDamage_DiscardEnergy
	dbw EFFECTCMDTYPE_AI, AlakazamLv45TransDamage_AI
	db $00

MachokeLv24WickedJabEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, MachokeLv24WickedJab_BeforeDamage
	db $00

MachokeLv24FocusBlastEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, MachokeLv24FocusBlast_InitialEffect1
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, MachokeLv24FocusBlast_BeforeDamage
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, MachokeLv24FocusBlast_AfterDamage
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, MachokeLv24FocusBlast_RequireSelection
	dbw EFFECTCMDTYPE_AI_SELECTION, MachokeLv24FocusBlast_AISelection
	dbw EFFECTCMDTYPE_AI, MachokeLv24FocusBlast_AI
	db $00

MachampLv54SeethingAngerEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, MachampLv54SeethingAnger_BeforeDamage
	dbw EFFECTCMDTYPE_AI, MachampLv54SeethingAnger_AI
	db $00

MachampLv54FlingEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, MachampLv54Fling_AfterDamage
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, MachampLv54Fling_RequireSelection
	dbw EFFECTCMDTYPE_AI_SWITCH_DEFENDING_PKMN, MachampLv54Fling_RequireSelection
	db $00

BellsproutLv10SwayEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, BellsproutLv10Sway_BeforeDamage
	db $00

BellsproutLv10StunSporeEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, BellsproutLv10StunSpore_BeforeDamage
	db $00

WeepinbellLv23RegenerationEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, WeepinbellLv23Regeneration_AfterDamage
	db $00

WeepinbellLv23DissolveEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, WeepinbellLv23Dissolve_InitialEffect1
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, WeepinbellLv23Dissolve_AfterDamage
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, WeepinbellLv23Dissolve_RequireSelection
	dbw EFFECTCMDTYPE_AI_SELECTION, WeepinbellLv23Dissolve_AISelection
	db $00

GravelerLv27BoulderSmashEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, GravelerLv27BoulderSmash_InitialEffect1
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, GravelerLv27BoulderSmash_AfterDamage
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, GravelerLv27BoulderSmash_RequireSelection
	dbw EFFECTCMDTYPE_AI_SELECTION, GravelerLv27BoulderSmash_AISelection
	db $00

GolemLv37RockBlastEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, GolemLv37RockBlast_InitialEffect1
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, GolemLv37RockBlast_BeforeDamage
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, GolemLv37RockBlast_AfterDamage
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, GolemLv37RockBlast_RequireSelection
	dbw EFFECTCMDTYPE_AI_SELECTION, GolemLv37RockBlast_AISelection
	dbw EFFECTCMDTYPE_AI, GolemLv37RockBlast_AI
	db $00

PonytaLv8FireworksEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, PonytaLv8Fireworks_InitialEffect1
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, PonytaLv8Fireworks_BeforeDamage
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, PonytaLv8Fireworks_RequireSelection
	dbw EFFECTCMDTYPE_AI_SELECTION, PonytaLv8Fireworks_AISelection
	dbw EFFECTCMDTYPE_AI, PonytaLv8Fireworks_AI
	db $00

SlowbroLv35BigYawnEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, SlowbroLv35BigYawn_InitialEffect1
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, SlowbroLv35BigYawn_BeforeDamage
	db $00

SlowbroLv35BigSnoreEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, SlowbroLv35BigSnore_InitialEffect1
	db $00

GastlyLv13SpookifyEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, GastlyLv13Spookify_BeforeDamage
	db $00

GastlyLv13FadeToBlackEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, GastlyLv13FadeToBlack_BeforeDamage
	db $00

HaunterLv26PoltergeistEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, HaunterLv26Poltergeist_BeforeDamage
	dbw EFFECTCMDTYPE_AI, HaunterLv26Poltergeist_AI
	db $00

HaunterLv26BadDreamsEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, HaunterLv26BadDreams_BeforeDamage
	db $00

HaunterLv25EerieLightEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, HaunterLv25EerieLight_BeforeDamage
	db $00

HaunterLv25GrudgeEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, HaunterLv25Grudge_BeforeDamage
	dbw EFFECTCMDTYPE_AI, HaunterLv25Grudge_BeforeDamage
	db $00

GengarLv40PowerOfDarknessEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, GengarLv40PowerOfDarkness_InitialEffect1
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, GengarLv40PowerOfDarkness_RequireSelection
	dbw EFFECTCMDTYPE_PKMN_POWER_TRIGGER, GengarLv40PowerOfDarkness_PkmnPowerTrigger
	db $00

GengarLv40PsyHorrorEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, GengarLv40PsyHorror_BeforeDamage
	db $00

HypnoLv30PuppetMasterEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, HypnoLv30PuppetMaster_InitialEffect1
	db $00

HypnoLv30MindShockEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, HypnoLv30MindShock_BeforeDamage
	db $00

; unreferenced
EffectCommands_590ab:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, EffectCommands_590ab_BeforeDamage
	db $00

KinglerLv33SaltWaterEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, KinglerLv33SaltWater_InitialEffect1
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, KinglerLv33SaltWater_BeforeDamage
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, KinglerLv33SaltWater_AfterDamage
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, KinglerLv33SaltWater_RequireSelection
	dbw EFFECTCMDTYPE_AI_SELECTION, KinglerLv33SaltWater_AISelection
	db $00

KinglerLv33DoubleEdgedPincersEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, KinglerLv33DoubleEdgedPincers_BeforeDamage
	db $00

CuboneLv14BoneTossEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, CuboneLv14BoneToss_InitialEffect1
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, CuboneLv14BoneToss_BeforeDamage
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, CuboneLv14BoneToss_AfterDamage
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, CuboneLv14BoneToss_RequireSelection
	dbw EFFECTCMDTYPE_AI_SELECTION, CuboneLv14BoneToss_AISelection
	dbw EFFECTCMDTYPE_AI, CuboneLv14BoneToss_AI
	db $00

WeezingLv26PoisonMistEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, WeezingLv26PoisonMist_InitialEffect2
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, WeezingLv26PoisonMist_BeforeDamage
	db $00

WeezingLv26GasExplosionEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, WeezingLv26GasExplosion_AfterDamage
	db $00

RhydonLv37MountainBreakEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, RhydonLv37MountainBreak_InitialEffect1
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, RhydonLv37MountainBreak_AfterDamage
	db $00

RhydonLv37OneTwoStrikeEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, RhydonLv37OneTwoStrike_BeforeDamage
	dbw EFFECTCMDTYPE_AI, RhydonLv37OneTwoStrike_AI
	db $00

KangaskhanLv36TailDropEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, KangaskhanLv36TailDrop_BeforeDamage
	dbw EFFECTCMDTYPE_AI, KangaskhanLv36TailDrop_AI
	db $00

HorseaLv20HideEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, HorseaLv20Hide_BeforeDamage
	db $00

HorseaLv20WaterGunEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, HorseaLv20WaterGun_BeforeDamage
	dbw EFFECTCMDTYPE_AI, HorseaLv20WaterGun_BeforeDamage
	db $00

SeadraLv26WaterBombEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, SeadraLv26WaterBomb_AfterDamage
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, SeadraLv26WaterBomb_RequireSelection
	dbw EFFECTCMDTYPE_AI_SELECTION, SeadraLv26WaterBomb_AISelection
	db $00

StaryuLv17StrangeBeamEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, StaryuLv17StrangeBeam_AfterDamage
	db $00

ScytherLv23SlashingStrikeEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, ScytherLv23SlashingStrike_InitialEffect1
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, ScytherLv23SlashingStrike_BeforeDamage
	db $00

MagmarLv27BurningFireEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, MagmarLv27BurningFire_BeforeDamage
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, MagmarLv27BurningFire_RequireSelection
	dbw EFFECTCMDTYPE_AI_SELECTION, MagmarLv27BurningFire_AISelection
	dbw EFFECTCMDTYPE_AI, MagmarLv27BurningFire_AI
	db $00

TaurosLv35KickingAndStampingEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, TaurosLv35KickingAndStamping_InitialEffect1
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, TaurosLv35KickingAndStamping_BeforeDamage
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, TaurosLv35KickingAndStamping_AfterDamage
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, TaurosLv35KickingAndStamping_RequireSelection
	dbw EFFECTCMDTYPE_AI_SELECTION, TaurosLv35KickingAndStamping_RequireSelection
	dbw EFFECTCMDTYPE_AI, TaurosLv35KickingAndStamping_AI
	db $00

OmanyteLv22FossilGuidanceEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, OmanyteLv22FossilGuidance_InitialEffect2
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, OmanyteLv22FossilGuidance_BeforeDamage
	db $00

OmastarLv36TentacleGripEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, OmastarLv36TentacleGrip_InitialEffect1
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, OmastarLv36TentacleGrip_BeforeDamage
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, OmastarLv36TentacleGrip_AfterDamage
	db $00

OmastarLv36CorrosiveAcidEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, OmastarLv36CorrosiveAcid_InitialEffect1
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, OmastarLv36CorrosiveAcid_BeforeDamage
	db $00

MewtwoLv67CompleteRecoveryEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, MewtwoLv67CompleteRecovery_InitialEffect1
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, MewtwoLv67CompleteRecovery_AfterDamage
	db $00

MewtwoLv67PsychoBlastEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, MewtwoLv67PsychoBlast_InitialEffect1
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, MewtwoLv67PsychoBlast_AfterDamage
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, MewtwoLv67PsychoBlast_RequireSelection
	dbw EFFECTCMDTYPE_AI_SELECTION, MewtwoLv67PsychoBlast_AISelection
	db $00

DarkPersianAltLv28FascinateEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, DarkPersianAltLv28Fascinate_InitialEffect1
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, DarkPersianAltLv28Fascinate_BeforeDamage
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, DarkPersianAltLv28Fascinate_AfterDamage
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, DarkPersianAltLv28Fascinate_RequireSelection
	dbw EFFECTCMDTYPE_AI_SELECTION, DarkPersianAltLv28Fascinate_AISelection
	db $00

DarkPersianAltLv28PoisonClawsEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, DarkPersianAltLv28PoisonClaws_BeforeDamage
	dbw EFFECTCMDTYPE_AI, DarkPersianAltLv28PoisonClaws_AI
	db $00

MeowthLv14ClearProfitEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, MeowthLv14ClearProfit_InitialEffect1
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, MeowthLv14ClearProfit_BeforeDamage
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, MeowthLv14ClearProfit_AfterDamage
	db $00

CoolPorygonTextureMagicEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, CoolPorygonTextureMagic_InitialEffect1
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, CoolPorygonTextureMagic_InitialEffect2
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, CoolPorygonTextureMagic_AfterDamage
	dbw EFFECTCMDTYPE_AI_SELECTION, CoolPorygonTextureMagic_AISelection
	db $00

CoolPorygonPorygon3DAttackEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, CoolPorygonPorygon3DAttack_BeforeDamage
	dbw EFFECTCMDTYPE_AI, CoolPorygonPorygon3DAttack_AI
	db $00

HungrySnorlaxEatEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, HungrySnorlaxEat_InitialEffect1
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, HungrySnorlaxEat_AfterDamage
	db $00

HungrySnorlaxRolloutEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, HungrySnorlaxRollout_InitialEffect2
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, HungrySnorlaxRollout_BeforeDamage
	dbw EFFECTCMDTYPE_AI_SELECTION, HungrySnorlaxRollout_AISelection
	dbw EFFECTCMDTYPE_AI, HungrySnorlaxRollout_AI
	db $00

MewtwoLv30EnergySpikeEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, MewtwoLv30EnergySpike_InitialEffect1
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, MewtwoLv30EnergySpike_AfterDamage
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, MewtwoLv30EnergySpike_RequireSelection
	dbw EFFECTCMDTYPE_AI_SWITCH_DEFENDING_PKMN, MewtwoLv30EnergySpike_AISwitchDefendingPkmn
	db $00

MewtwoLv30TelekinesisEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, MewtwoLv30Telekinesis_BeforeDamage
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, MewtwoLv30Telekinesis_AfterDamage
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, MewtwoLv30Telekinesis_RequireSelection
	dbw EFFECTCMDTYPE_AI_SELECTION, MewtwoLv30Telekinesis_AISelection
	dbw EFFECTCMDTYPE_AI, MewtwoLv30Telekinesis_AI
	db $00

PikachuLv13RechargeEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, PikachuLv13Recharge_InitialEffect1
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, PikachuLv13Recharge_AfterDamage
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, PikachuLv13Recharge_RequireSelection
	dbw EFFECTCMDTYPE_AI_SELECTION, PikachuLv13Recharge_AISelection
	db $00

PikachuLv13ThunderboltEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, PikachuLv13Thunderbolt_BeforeDamage
	db $00

FarfetchdAltLv20LeekSlapEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, FarfetchdAltLv20LeekSlap_InitialEffect1
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, FarfetchdAltLv20LeekSlap_BeforeDamage
	dbw EFFECTCMDTYPE_DISCARD_ENERGY, FarfetchdAltLv20LeekSlap_DiscardEnergy
	db $00

KangaskhanLv38DizzyPunchEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, KangaskhanLv38DizzyPunch_BeforeDamage
	dbw EFFECTCMDTYPE_AI, KangaskhanLv38DizzyPunch_AI
	db $00

DiglettLv16TripOverEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, DiglettLv16TripOver_BeforeDamage
	dbw EFFECTCMDTYPE_AI, DiglettLv16TripOver_AI
	db $00

DugtrioLv40GoUndergroundEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, DugtrioLv40GoUnderground_InitialEffect1
	db $00

DugtrioLv40EarthWaveEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, DugtrioLv40EarthWave_AfterDamage
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, DugtrioLv40EarthWave_RequireSelection
	dbw EFFECTCMDTYPE_AI_SELECTION, DugtrioLv40EarthWave_AISelection
	db $00

DragoniteLv43SpecialDeliveryEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, DragoniteLv43SpecialDelivery_InitialEffect2
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, DragoniteLv43SpecialDelivery_BeforeDamage
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, DragoniteLv43SpecialDelivery_RequireSelection
	db $00

DragoniteLv43SupersonicFlightEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, DragoniteLv43SupersonicFlight_BeforeDamage
	dbw EFFECTCMDTYPE_AI, DragoniteLv43SupersonicFlight_AI
	db $00

MagikarpLv10TrickleEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, MagikarpLv10Trickle_BeforeDamage
	dbw EFFECTCMDTYPE_AI, MagikarpLv10Trickle_AI
	db $00

MagikarpLv10DragonRageEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, MagikarpLv10DragonRage_BeforeDamage
	dbw EFFECTCMDTYPE_AI, MagikarpLv10DragonRage_AI
	db $00

TogepiSnivelEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, TogepiSnivel_BeforeDamage
	db $00

TogepiMetronomeEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, TogepiMetronome_InitialEffect1
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, TogepiMetronome_InitialEffect2
	dbw EFFECTCMDTYPE_AI_SELECTION, TogepiMetronome_AISelection
	db $00

MarillWaterGunEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, MarillWaterGun_BeforeDamage
	dbw EFFECTCMDTYPE_AI, MarillWaterGun_BeforeDamage
	db $00

MankeyAltLv7PeekEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, MankeyAltLv7Peek_InitialEffect2
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, MankeyAltLv7Peek_BeforeDamage
	db $00

IvysaurLv26LeechSeedAltEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, IvysaurLv26LeechSeedAlt_AfterDamage
	db $00

KoffingLv14PoisonGasEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, KoffingLv14PoisonGas_BeforeDamage
	dbw EFFECTCMDTYPE_AI, KoffingLv14PoisonGas_AI
	db $00

KoffingLv14ConfusionGasEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, KoffingLv14ConfusionGas_BeforeDamage
	db $00

RaichuLv33QuickAttackEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, RaichuLv33QuickAttack_BeforeDamage
	dbw EFFECTCMDTYPE_AI, RaichuLv33QuickAttack_AI
	db $00

RaichuLv33ThunderboltEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, RaichuLv33Thunderbolt_BeforeDamage
	db $00

ElectabuzzLv30ThundershockEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, ElectabuzzLv30Thundershock_BeforeDamage
	db $00

JynxLv27DoubleSlapEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, JynxLv27DoubleSlap_BeforeDamage
	dbw EFFECTCMDTYPE_AI, JynxLv27DoubleSlap_AI
	db $00

MeowthLv17FurySwipesEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, MeowthLv17FurySwipes_BeforeDamage
	dbw EFFECTCMDTYPE_AI, MeowthLv17FurySwipes_AI
	db $00

GrowlitheLv12LungeEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, GrowlitheLv12Lunge_BeforeDamage
	dbw EFFECTCMDTYPE_AI, GrowlitheLv12Lunge_AI
	db $00

GrowlitheLv12EmberEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, GrowlitheLv12Ember_InitialEffect1
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, GrowlitheLv12Ember_InitialEffect2
	dbw EFFECTCMDTYPE_DISCARD_ENERGY, GrowlitheLv12Ember_DiscardEnergy
	dbw EFFECTCMDTYPE_AI_SELECTION, GrowlitheLv12Ember_AISelection
	db $00

ArcanineLv35TakeDownEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, ArcanineLv35TakeDown_AfterDamage
	db $00

MagmarLv18SmogEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, MagmarLv18Smog_BeforeDamage
	dbw EFFECTCMDTYPE_AI, MagmarLv18Smog_AI
	db $00

WartortleLv24BubbleEffectCommands:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, WartortleLv24Bubble_BeforeDamage
	db $00

SuperScoopUpEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, SuperScoopUp_InitialEffect1
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, SuperScoopUp_BeforeDamage
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, SuperScoopUp_RequireSelection
	db $00

BillsTeleporterEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, BillsTeleporter_BeforeDamage
	db $00

DarkClefableDarknessVeilEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, DarkClefableDarknessVeil_InitialEffect1
	db $00

DarkClefableDarkSongEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, DarkClefableDarkSong_BeforeDamage
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, DarkClefableDarkSong_AfterDamage
	db $00

DarkHaunterBotherEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, DarkHaunterBother_BeforeDamage
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, DarkHaunterBother_AfterDamage
	db $00

DarkGengarPlayTricksEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, DarkGengarPlayTricks_InitialEffect2
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, DarkGengarPlayTricks_BeforeDamage
	db $00

DarkGengarPushAsideEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, DarkGengarPushAside_BeforeDamage
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, DarkGengarPushAside_AfterDamage
	db $00

DarkStarmieRebirthEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, DarkStarmieRebirth_InitialEffect2
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, DarkStarmieRebirth_BeforeDamage
	db $00

DarkStarmieSpinningShowerEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, DarkStarmieSpinningShower_BeforeDamage
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, DarkStarmieSpinningShower_AfterDamage
	db $00

DarkFearowFlyHighEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, DarkFearowFlyHigh_BeforeDamage
	db $00

DarkFearowDrillDiveEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, DarkFearowDrillDive_InitialEffect1
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, DarkFearowDrillDive_AfterDamage
	db $00

DarkRaichuSurpriseThunderEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, DarkRaichuSurpriseThunder_AfterDamage
	db $00

DarkNinetalesPerplexEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, DarkNinetalesPerplex_BeforeDamage
	db $00

DarkNinetalesNineTailsEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, DarkNinetalesNineTails_BeforeDamage
	dbw EFFECTCMDTYPE_AI, DarkNinetalesNineTails_AI
	db $00

DarkMarowakBoneHeadbuttEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, DarkMarowakBoneHeadbutt_AfterDamage
	db $00

GRsMewtwoDarkWaveEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, GRsMewtwoDarkWave_InitialEffect1
	db $00

GRsMewtwoDarkAmplificationEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, GRsMewtwoDarkAmplification_BeforeDamage
	dbw EFFECTCMDTYPE_AI, GRsMewtwoDarkAmplification_AI
	db $00

DarkIvysaurVinePullEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, DarkIvysaurVinePull_InitialEffect1
	db $00

DarkIvysaurFuryStrikesEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, DarkIvysaurFuryStrikes_AfterDamage
	db $00

DarkVenusaurHorridPollenEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, DarkVenusaurHorridPollen_BeforeDamage
	db $00

LugiaAeroblastEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, LugiaAeroblast_BeforeDamage
	dbw EFFECTCMDTYPE_AI, LugiaAeroblast_AI
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
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, SuperPotion_InitialEffect1
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, SuperPotion_InitialEffect2
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, SuperPotion_BeforeDamage
	db $00

ImakuniCardEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, ImakuniCard_BeforeDamage
	db $00

EnergyRemovalEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, EnergyRemoval_InitialEffect1
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, EnergyRemoval_InitialEffect2
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, EnergyRemoval_BeforeDamage
	dbw EFFECTCMDTYPE_AI_SELECTION, EnergyRemoval_AISelection
	db $00

EnergyRetrievalEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, EnergyRetrieval_InitialEffect1
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, EnergyRetrieval_InitialEffect2
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, EnergyRetrieval_BeforeDamage
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, EnergyRetrieval_RequireSelection
	db $00

EnergySearchEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, EnergySearch_InitialEffect1
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, EnergySearch_BeforeDamage
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, EnergySearch_RequireSelection
	db $00

ProfessorOakEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, ProfessorOak_BeforeDamage
	db $00

PotionEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Potion_InitialEffect1
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, Potion_InitialEffect2
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Potion_BeforeDamage
	db $00

GamblerEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Gambler_BeforeDamage
	db $00

ItemfinderEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Itemfinder_InitialEffect1
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, Itemfinder_InitialEffect2
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Itemfinder_BeforeDamage
	db $00

DefenderEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, Defender_InitialEffect2
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Defender_BeforeDamage
	db $00

MysteriousFossilEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, MysteriousFossil_InitialEffect1
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, MysteriousFossil_BeforeDamage
	db $00

FullHealEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, FullHeal_InitialEffect1
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, FullHeal_BeforeDamage
	db $00

ImposterProfessorOakEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, ImposterProfessorOak_BeforeDamage
	db $00

ComputerSearchEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, ComputerSearch_InitialEffect1
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, ComputerSearch_InitialEffect2
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, ComputerSearch_BeforeDamage
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, ComputerSearch_RequireSelection
	db $00

ClefairyDollEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, ClefairyDoll_InitialEffect1
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, ClefairyDoll_BeforeDamage
	db $00

MrFujiEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, MrFuji_InitialEffect1
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, MrFuji_InitialEffect2
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, MrFuji_BeforeDamage
	db $00

PluspowerEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Pluspower_BeforeDamage
	db $00

SwitchEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Switch_InitialEffect1
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, Switch_InitialEffect2
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Switch_BeforeDamage
	db $00

PokemonCenterEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, PokemonCenter_InitialEffect1
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, PokemonCenter_BeforeDamage
	db $00

PokemonFluteEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, PokemonFlute_InitialEffect1
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, PokemonFlute_InitialEffect2
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, PokemonFlute_BeforeDamage
	db $00

PokemonBreederEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, PokemonBreeder_InitialEffect1
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, PokemonBreeder_InitialEffect2
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, PokemonBreeder_BeforeDamage
	db $00

ScoopUpEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, ScoopUp_InitialEffect1
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, ScoopUp_InitialEffect2
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, ScoopUp_BeforeDamage
	db $00

PokemonTraderEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, PokemonTrader_InitialEffect1
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, PokemonTrader_InitialEffect2
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, PokemonTrader_BeforeDamage
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, PokemonTrader_RequireSelection
	db $00

PokedexEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Pokedex_InitialEffect1
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Pokedex_BeforeDamage
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, Pokedex_RequireSelection
	db $00

BillEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Bill_BeforeDamage
	db $00

LassEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Lass_BeforeDamage
	db $00

MaintenanceEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Maintenance_InitialEffect1
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, Maintenance_InitialEffect2
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Maintenance_BeforeDamage
	db $00

PokeballEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Pokeball_InitialEffect1
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Pokeball_BeforeDamage
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, Pokeball_RequireSelection
	db $00

RecycleEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Recycle_InitialEffect1
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Recycle_BeforeDamage
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, Recycle_RequireSelection
	db $00

ReviveEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Revive_InitialEffect1
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, Revive_InitialEffect2
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Revive_BeforeDamage
	db $00

DevolutionSprayEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, DevolutionSpray_InitialEffect1
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, DevolutionSpray_InitialEffect2
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, DevolutionSpray_BeforeDamage
	db $00

SuperEnergyRemovalEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, SuperEnergyRemoval_InitialEffect1
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, SuperEnergyRemoval_InitialEffect2
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, SuperEnergyRemoval_BeforeDamage
	db $00

SuperEnergyRetrievalEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, SuperEnergyRetrieval_InitialEffect1
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, SuperEnergyRetrieval_InitialEffect2
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, SuperEnergyRetrieval_BeforeDamage
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, SuperEnergyRetrieval_RequireSelection
	db $00

GustOfWindEffectCommands:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, GustOfWind_InitialEffect1
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, GustOfWind_InitialEffect2
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, GustOfWind_BeforeDamage
	db $00

INCLUDE "data/decks.asm"
